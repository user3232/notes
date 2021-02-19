

# XML schemas

Usefull (rare) guide can be found here: 
[XML schema primer W3C!!!!](https://www.w3.org/TR/xmlschema-0/).
Official manual for actually simple thing is totally long and unridable.

A schema can be viewed as: 
- a collection (vocabulary) of 
  - type definitions and 
  - element declarations 
  - whose names belong to a particular namespace 
    called a **target namespace**.

Target namespaces enable us to distinguish between definitions and
declarations from different vocabularies. 


For example, target namespaces would enable us to distinguish between: 
- the declaration for element in the XML Schema language vocabulary,
  (part of the http://www.w3.org/2001/XMLSchema target namespace)
- and a declaration for element in a hypothetical chemistry language
  vocabulary (part of another target namespace).


The author can decide whether or not the appearance of locally
declared elements and attributes in an instance must be qualified by a
namespace, 
- using either an explicit prefix or 
- implicitly by default. 
- The schema author's choice regarding qualification of local elements
  and attributes has a number of implications regarding the structures
  of schemas and instance documents

## Example

Schema have key properties:

- **schema discribes namespace (`xmlns` attribute value of xml element)** 
- in every `.xml` (and schema `.xsd`) file every name comes from some namespace
- default namespace for element is declared using
  `xmlns="some_global_identifier"` attribute of xml element
- additional namespaces for element (and its children) are
  declared using `xmlns:add="some_other_same_global_identifier"`
- `schema` xml element of `http://www.w3.org/2001/XMLSchema` schema
  can be used to declare:
  - that names created by this schema should be associated with 
    some declared namespace by using `targetNamespace` attribute, e.g.:
    `targetNamespace="global_identifier_of_declared_names_here"`
  - that here declared element names should be qualified using
    `elementFormDefault="qualified"` attribute
  - that here declared attribute names should be unqualified using
    `attributeFormDefault="unqualified"` attribute

Qualification obligations dont change names understanding. Even
if `elementFormDefault="unqualified"` is set, use in xml instance of
scheme top level element must be qualified.


For exemplary schema below: 

- The default namespace is `http://www.w3.org/2001/XMLSchema`
  so unqalified names typically describes (anonymous) types, 
  and root elements, for example:
  - `<element ...></element>` - xml element
  - `<complexType ...></complexType>` - xml element
  - `<element name="comment"       type="string"/>` - type xml attribute
  - `<element name="comment"       type="string"/>` - name xml attribute
- `targetNamespace` is set to global identifier `http://www.example.com/PO1`
- `po` namespace is connected with global identifier
  `http://www.example.com/PO1` same as `targetNamespace`, it can be
  used for referencing names created here (self references)
- `elementFormDefault="qualified"` is set to qualified, so instance
  xml doc is obligated to qualify xml element names declared here.
- `attributeFormDefault="unqualified"` is set to unqualified, so
  instance xml doc is obligated to not qualify xml attributes names
  declared here.


```xsd
<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://www.w3.org/2001/XMLSchema"
        xmlns:po="http://www.example.com/PO1"
        targetNamespace="http://www.example.com/PO1"
        elementFormDefault="qualified"
        attributeFormDefault="unqualified">

  <!-- below is root element, it must be qualified in xml instance doc -->
  <element name="purchaseOrder" type="po:PurchaseOrderType"/>
  <!-- below is other root element, it must be qualified in xml instance doc -->
  <element name="comment"       type="string"/>

  <!-- this is type: -->
  <complexType name="PurchaseOrderType">
    <!-- etc. -->
  </complexType>

  <!-- etc. -->

</schema>
```

Exemplary conforming xml instance below:

- notice to use `<purchaseOrder ...>...</purchaseOrder>` element
  one must: 
  - first connect with this name schema, here by using custom
    namespace `apo` and schema global identifier
    `http://www.example.com/PO1` by using attribute:
    `xmlns:apo="http://www.example.com/PO1"`
  - than reference `purchaseOrder` using namespace prefix:
    `<apo:purchaseOrder ...>...</apo:purchaseOrder>`
  - notice that `apo` scheme attribute `orderDate` must not
    be qualified, but its meaning can be deduced because
    it is child of `apo:purchaseOrder` element
  - (If schema before would declared `elementFormDefault="unqualified"`
    than `shipTo`, `name`, `street`, ... etc. elements should
    not be qualified, but `purchaseOrder` steel should be qualified.)

```xml
<?xml version="1.0"?>
<apo:purchaseOrder xmlns:apo="http://www.example.com/PO1"
                   orderDate="1999-10-20">
  <apo:shipTo country="US">
    <apo:name>Alice Smith</apo:name>
    <apo:street>123 Maple Street</apo:street>
    <!-- etc. -->
  </apo:shipTo>
  <apo:billTo country="US">
    <apo:name>Robert Smith</apo:name>
    <apo:street>8 Oak Avenue</apo:street>
    <!-- etc. -->
  </apo:billTo>
  <apo:comment>Hurry, my lawn is going wild<!/apo:comment>
  <!-- etc. -->
</apo:purchaseOrder>
```

Below it is also conforming xml instance, diffrence
comes from setting default namespace to `http://www.example.com/PO1`
(`<purchaseOrder xmlns="http://www.example.com/PO1" ...">...</purchaseOrder>`).

This way all child (and root `purchaseOrder`) elements are implicitly
qualified.

```xml
<?xml version="1.0"?>
<purchaseOrder xmlns="http://www.example.com/PO1" orderDate="1999-10-20">
  <shipTo country="US">
    <name>Alice Smith</name>
    <street>123 Maple Street</street>
    <!-- etc. -->
  </shipTo>
  <billTo country="US">
    <name>Robert Smith</name>
    <street>8 Oak Avenue</street>
    <!-- etc. -->
  </billTo>
  <comment>Hurry, my lawn is going wild<!/comment>
  <!-- etc. -->
</purchaseOrder>
```