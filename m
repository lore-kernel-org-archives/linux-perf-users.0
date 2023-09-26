Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1609B125BA
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 08:21:20 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2112.outbound.protection.outlook.com [40.107.241.112])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4CB97
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Sep 2023 01:21:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rp10jbK6PjWI3H1DLHoJBFfvDR4bzHkkH/syPTFuMsLETodmR4VBmSeItiat5Gmdf6zQRhIbCEzUJ/qjYfynr0wZALdMZDENpbFJQPLqsKQdUUQwSo89dEluFbSoZ6qMD1JM+ErVVi6JkGWyBwF+5/aIu/O6XIYQz+3XDgYX5Vn0p2m7QKbNZzQhkjarRvj5Wn1buUiEp02YrAeFg98jAop3Hw2bhaI0Z/XLrnRhlz8y4Cr01AqcUyt0uX39UahiDxyx6OLH6jgPOIG3wDKuoTAwEnVBLNeVFMCdmllTC0OwglFOlNea3dFq6sQQTHi3K9fcTDV6X8zlATTrsrrm1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeHb04We0yRpImq7sukQt0yqQXOPezkLDHcZTkHAxC0=;
 b=mQT7dbTX4YWaR+r20nualIAbSi2kUnykSmKQuIexeOX28HTpCd8FDKUW5oTxCQPyR/IOzJX94JXJYna/2XffEKWr4ZBaiUCDe0dQSgLEaC6PmIMd0sHoSLWIwcPZlLryXEfj2zsp+gTh4IVje6TMgEOQ2BpjO1K9FItIJ51OpmvK43aV3GGIhD5PVMm5a6tC6hil+3qeraLD4dg9gyhXt9HoufoAAKgW2AP8cEbNiGN5j2DU6JZHHbydTEHUMXdzCuhkoqCGA+SGuewY9j1MM1vdtMrVgN7+fsOhoX6ZgrHcGucA+bRORrlCU5NLJVEheO4sYVQm1wbZJb8hsWl2oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=criteo.com; dmarc=pass action=none header.from=criteo.com;
 dkim=pass header.d=criteo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criteo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeHb04We0yRpImq7sukQt0yqQXOPezkLDHcZTkHAxC0=;
 b=X32DYqQ/jD8WDhZxc5HcHGk7uYGe81cnf1TfTXcRwZaHUGPFYNw5voUrNTOzWIBQeFm8b82JvLEEN9mTvyE+SSdTANKCU3fDXQ3vSYB4iM9VeVJubbf5uKh+29AecqhIAkvKGwElNI5lob1abgAvWHAtQyF2KyA2QR3+RBVR+j4=
Received: from PAWPR04MB9765.eurprd04.prod.outlook.com (2603:10a6:102:389::6)
 by DU2PR04MB8983.eurprd04.prod.outlook.com (2603:10a6:10:2e2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 08:21:16 +0000
Received: from PAWPR04MB9765.eurprd04.prod.outlook.com
 ([fe80::1d55:1a06:a523:7f15]) by PAWPR04MB9765.eurprd04.prod.outlook.com
 ([fe80::1d55:1a06:a523:7f15%6]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 08:21:16 +0000
From: Pierre Cheynier <p.cheynier@criteo.com>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
CC: "irogers@google.com" <irogers@google.com>
Subject: [6.5.4] perf: bison min. requirements
Thread-Topic: [6.5.4] perf: bison min. requirements
Thread-Index: AQHZ8Eu7lsFOZxzLTEu2ll5o5fOx3A==
Date: Tue, 26 Sep 2023 08:21:16 +0000
Message-ID:
 <PAWPR04MB97658DD9546C6D0A141C0766EAC3A@PAWPR04MB9765.eurprd04.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=criteo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR04MB9765:EE_|DU2PR04MB8983:EE_
x-ms-office365-filtering-correlation-id: 8575cd62-d937-4957-a329-08dbbe698daf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 sE4OuMjQjPZY4EwvhcPV5//ZYSyqWuSXbFpAWOv+ktbqtXQMWd1ce/bbJMs1m1VmoG6bLi2BKujVgNeZvenUHVUIaC5BWTZhqr8b0mpj4lN56TqQximf6hoVsBSk2n+BXe6Anca0WzlCFhdjQCOFHnIXYl555K5oBMKW9RKRdpWn+iTu6C0EkcKUsIZK3Rd5IbPFE5/Qss07X45nVZJuSDuzK2SSnpU7poQVnu0fl9krA8WSuQmmLNTeuTbE1gJdZ50KHTo643rNuCzpO1MEVpUZ5j3P/FGjzvmIzBwCTA/obsn63DWjECFZy0Tx3JOfBeRjpW020PDgJtq4mlc1hgnfgewCxQqwbeOv9GOZiNT/3q5Y3s73nSyHzIvNHXrdSUKYMRH8nIxfvXCwADWWzQ42hmo7IBmGprKHOuEVoAcml8rv4v3qqrm7A+5V6+cdNpgqZOtzr/mDCeoEECsYCX7oNK8vultAArwcVHehQscsBQPzLg0Fr5AoB9pgGTteXeuRPxxbbBJHgI8zGAkrUNcs+rRC3/m2RwGR+OFxDV0Mo+SoaUdb0NK2u/Vc1CVc+tbudujY8HzFeL9VFRtBYHtzw+oz6Jkws37ZG3ns7/g=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR04MB9765.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(186009)(8936002)(4326008)(8676002)(55016003)(26005)(52536014)(2906002)(4744005)(478600001)(966005)(66476007)(41300700001)(76116006)(316002)(6916009)(66446008)(66556008)(66946007)(5660300002)(64756008)(6506007)(7696005)(71200400001)(9686003)(83380400001)(33656002)(38070700005)(122000001)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CCa5aU3Zdp/dfvOm+zXlBsWJnob6nX0KZbETVrxkuQg2aAYzc1EX3kKska?=
 =?iso-8859-1?Q?4QSXqdzuOeEkHd0Ef/Okvbwpxvo8P/aZLea1D93YnhuLQB9tHXIsmR5/CW?=
 =?iso-8859-1?Q?CsKq0AfF3CTMoa6VkIjO3tv6tf3TWV9qoc+rmqjkQNwjSaq5esvwR08Ljs?=
 =?iso-8859-1?Q?NNKrTSfNpk7AYBDWL2aucuzp7pEDVeJmT31LZZJX9wzEtnDPcopMD0Ybps?=
 =?iso-8859-1?Q?eaaZIS5xtGLdp65dOJviv0R3jIEsmrIbva6g7U15y1JTwmFWNm5s7KwmRc?=
 =?iso-8859-1?Q?Wersk5YIgdIXcMtUmLW1ssXewI4Um4kqkEaRhh3WQQF+STqyUG74MsUmsH?=
 =?iso-8859-1?Q?4BupYzhRMi+HjP9cedhJsjInO+EmYyan9fAoIn5Qq+xVySzb2fFQ/VIumM?=
 =?iso-8859-1?Q?hfq/F40paxvl4slKYCKKUe09MFpn784REUnCMR+daRWFcz0k/Q3GpFe8Ls?=
 =?iso-8859-1?Q?lpA8Lr0YEia2FxLeJM9HDxEwCzxFIJSpKzrkYKwavRtHrEuzKGGp1fWjrg?=
 =?iso-8859-1?Q?vF+c43w+IhVlM0mnTLfbeaRk5CAkf9Cx6EVfS8mhO2B43w3FW3Wgt9iJk4?=
 =?iso-8859-1?Q?US9Hw3CmQZz17u2QlvffVScgXoT7yrAUT6x0zco75wqTBL6bInjppn5RM6?=
 =?iso-8859-1?Q?C19zl8PQ2d4C3IsZ19EtT4iTVPDr3+kCJ7C8+lFAoQI9n3E8/4NP5hmYPp?=
 =?iso-8859-1?Q?Lxwc6khpGvw9Q6biZFIrxrMuGyRqFAWxUkmfDayyumBXkuzXFJLFEoq2IV?=
 =?iso-8859-1?Q?8V3Oc8DKspgb2DB4PmO3owzJIBdK2HlEeWGvp0r5OXEeZx1qOuh0fI/Nq9?=
 =?iso-8859-1?Q?nlJV0L+rgnAnpAR1jcab6ANiwCclyfMx6Yvd1mIyUi+XDid3mjn6HKLVXd?=
 =?iso-8859-1?Q?yTPctoKqLGK7K6GqCBPUzGrwJvh6RHSKlz8uBbkylQms0hAhxltACxe0B2?=
 =?iso-8859-1?Q?XSD4DGShTyr0lSiFNJgFG5CAqxkfPc/W33sFUhayE+7S0AbY29A9ewUdsA?=
 =?iso-8859-1?Q?5kK+i5bVGmbLX5hBCA/wipUqMTyEx3Yw3UZVwXgGHACnocULhxLsMldlk+?=
 =?iso-8859-1?Q?nOEidqa8QcGGgkyELlyny/aYyqq4/D4QTx4tNozc2Qex63qQpKloZ74vhB?=
 =?iso-8859-1?Q?3yxABCASMVuik5eMWFRC5gfvDpP1cG8G/8KZ3FIdhsQq5IUme6NnbGbJ4U?=
 =?iso-8859-1?Q?t42pKLSZOVgoSfXp4z9Rc1R4ZLeRETX2Y3NdEnvqFkbP8CGRwkYOwNwOsq?=
 =?iso-8859-1?Q?+Sebblu62A03We6KrOHQEA8a2ymahUjSkmodfDzVvZWQFarlJQh0LHA6o2?=
 =?iso-8859-1?Q?L0TsACJN4rt26T3/V5+gbXOyu3CBv5JN7roCcehcwKT05dj3cFnauUsEO/?=
 =?iso-8859-1?Q?Sqin2AhodK6AIPskeOFltxWYq7GsSu6uAb75ST1NtUn95vw2vR2Su+7Cxu?=
 =?iso-8859-1?Q?c+6272gd9qwS5KTp6BDijK0V8GHICZBYSeidHKTStokLSWaGpq1tQbEzjg?=
 =?iso-8859-1?Q?o0iAg7fPzW6iCFBpBR6W1NPkTQaopiUmIFG7vnaBDlIQFjf9JKrWjxAL5f?=
 =?iso-8859-1?Q?pQ/Lzc71gQ6V5G3Lqg8shRrlOQel1t5drMljia+9ej6FKpyKOLGNuL5MYf?=
 =?iso-8859-1?Q?IukvB2chjnoZc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: criteo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR04MB9765.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8575cd62-d937-4957-a329-08dbbe698daf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 08:21:16.0438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2a35d8fd-574d-48e3-927c-8c398e225a01
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hVbpOzTirBsrU1f5PFCWYsgb4Tq/epOaqWwQ538ys2wjX9bAH16KVFmTkovX/VmPzLkVwi9Ns3FFZrvf6/BYpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8983
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dear list,=0A=
At compiling 6.5.4 it seemed to me that this specific patch [1] added an im=
plicit dependency to bison >=3D 3.7.4, due to usage of YYNOMEM.=0A=
Shouldn't this be part of Documentation/process/changes.rst?=0A=
=0A=
[1] https://www.spinics.net/lists/linux-perf-users/msg30885.html "perf pars=
e-events: Separate YYABORT and YYNOMEM cases"=0A=
=0A=
Sorry for the noise, and thanks for inputs if ever I'm totally wrong here.=
=0A=
=0A=
--=0A=
Pierre=
