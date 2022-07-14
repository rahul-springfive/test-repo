<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>ACC_WF09_Si_Statut_Insolvable_Cycle_Referentiel_Devient_AVerifier</fullName>
        <actions>
            <name>ACC_Update_Cycle_Referentiel_AVerifier</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>(1 OR 2) AND 3 AND 4</booleanFilter>
        <criteriaItems>
            <field>Account.RecordTypeId</field>
            <operation>equals</operation>
            <value>Compte de Gestion Meunerie BA - Livré</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.RecordTypeId</field>
            <operation>equals</operation>
            <value>Compte de Gestion Meunerie BA - Facturé</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Statut__c</field>
            <operation>equals</operation>
            <value>D</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.BypassWorkflow__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Si Statut passe à Insolvable alors Cycle référentiel passe à A Vérifier</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>ACC_WF09tier_Si_Statut_Prospect_Cycle_Referentiel_Devient_AVerifier</fullName>
        <actions>
            <name>ACC_Update_Cycle_Referentiel_AVerifier</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Si Statut passe à Prospect alors Cycle référentiel passe à A Vérifier</description>
        <formula>AND( 
!$User.BypassWorkflow__c, 
OR( 
RecordType.DeveloperName = &apos;Compte_de_Gestion_Meunerie_BA_Factur&apos;, 
RecordType.DeveloperName = &apos;Compte_de_Gestion_Meunerie_BA&apos; 
), 
ISCHANGED ( Statut__c ), 
ISPICKVAL( Statut__c ,&apos;A&apos;), 
ISPICKVAL(PRIORVALUE (Statut__c ),&apos;D&apos;) 
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>ACC_WF10_Si_Champ_Modifie_RefGroupe</fullName>
        <actions>
            <name>ACC_MAJ_Controle_RefGroupe</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>La case ‘Contrôlé Réf. Groupe » est décochée si l’un des champs suivants est modifié :</description>
        <formula>AND( !$User.BypassWorkflow__c,      RecordType.DeveloperName = &apos;Compte&apos;,      NOT ( $Profile.Name =&apos;Ref Groupe&apos;) ,      OR( ISCHANGED( Name ),          ISCHANGED( BillingCountryCode ),          ISCHANGED( BillingStreet ),          ISCHANGED( BillingPostalCode ),          ISCHANGED( BillingCity ),          ISCHANGED( Groupe_Soufflet__c ),          ISCHANGED( Scoring__c ),          ISCHANGED( Situation__c ),          ISCHANGED( Numero_Legal__c ),          ISCHANGED( ParentId ),          ISCHANGED( Numero_TVA__c ),          ISCHANGED( Code_NAF_APE__c ),          ISCHANGED( Blackliste__c ),          AND( Tech_Compte_Soufflet__c = true,               OR(ISCHANGED( SIRET__c ),                  ISCHANGED( EnCoursImmatriculation__c ),                  ISCHANGED( SansIdentifiant__c ),                  ISCHANGED( DUNS__c ),                  ISCHANGED( Numero_legal_hors_France__c ))          )       )  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
