DROP TABLE dummy_entity;
CREATE TABLE dummy_entity
(
    id_Prop SERIAL PRIMARY KEY,
    NAME    VARCHAR(100),
    POINT_IN_TIME TIMESTAMP,
    OFFSET_DATE_TIME TIMESTAMP WITH TIME ZONE,
    FLAG BOOLEAN
);
