Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA2133F7;
	Thu,  8 Aug 2024 04:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723091872; cv=fail; b=bU5zizEGCgBPoWO2LTe5J7n8OArcGjpt9jkDEd4IakrIm9SH4iFLxISfuqXLLvgxV44vecq3c/syT7SQwhtJgjNmyyAbD2rzVz6Hr6A1ukWs2mocZlUZB6XLxBCQ4aBfkRPylU2DLLpCgwbnegG/2fn0PSAQHgdRd0XF1u9+dBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723091872; c=relaxed/simple;
	bh=GAG8/TLVAOpU8gE8FuURQmRea2pWCguMbj7QRXv7PWU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u88uKtE2bcMv2XwVPRn8WrIR0bdvTaUIqmVbGtpwhlx22W34gngDWBI8baQgqFeHZ6vFMjSSl9LFmBUWz9xUGtjp+1LU2mIuMNj0q8lPkWSLfvcklL76ctPiejihC4xZ3/CBS2yWrigDf9or5xqntH4qsXrvZiTnBESTz7JGZiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hSdKr1Et; arc=fail smtp.client-ip=40.107.96.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hSdKr1Et"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuRzC3Obg9sBJeuzZkx/SzdNiaOgzeKeCxPRKrb4TjDH0yyd9zQ4OCQJ6PF6dSSCclFhOWvwVZWuy6D289ztotn4TBK+/B9FJO0VdnRh9OG2nyfVvqoWPhzCmKoSULd5mx8GVBOJBLIrNPKWWec6L3F1GTMYM5FN5/R/03vzAe10FceqCZPkMEsk4gxiF/Wif0Y/Km1Ro3ogh5gbGNYbEoMzLNGkxo5CZN0ufReI8JF2VkWrqrfyBILO334C+jUXCxupLVWerIfdqvMZpFezJJUqP4GOxZm1VaMRDJdlihRWKTp7bA0eMorj4afxlyf7D1mZ04aNWtxPHwzz6gWFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAG8/TLVAOpU8gE8FuURQmRea2pWCguMbj7QRXv7PWU=;
 b=ZVkygQ2vrnV2Yw5o4J16Vn7VOWIgL6AK9N78sa+PI7gVQwRTkzThNyzmfEtwdsbu+S+g9eyzkyP83HCch+gceE6HK2HSVeBnYjP86+hAQv8y5IizLUpBeCWwc8/Xem/4XWpcUsQoV0PbuU+NnbtRiUy753D9pDlPHsXebs6n0T3nXwlCcz7FUPZedvqF1Pl7S2+9O3qd2PTyhxih3yC52HL1UFTSWyydPg5tmmDZCkFeRAblD222BG3Lr/n3DM+k2cRQR2zZog4Jg5p/9/AOoua2NBpQCKHMpXEqvXWn0sTqxaIQMBaA+kY/Smjmi9+vxIvwhegKw9fS3rrPF7vuMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAG8/TLVAOpU8gE8FuURQmRea2pWCguMbj7QRXv7PWU=;
 b=hSdKr1EtWQ2Wa/tttu4shgtbwH0tqwDIF4LgWWpgu9JIbYmUW40bS3Rt6M95M6zb5T3DbKlZBfreo7kexJpkmpYWTAaBObj1+AWefCl/RF0WYfMNcDDi96QWtfnUO30dzdge8HuZOemvH8XtIDKNMwfpJMb7QhxdNpomMk6aBEq41wL6MhyAKYmpgOTeQMTS7tiqRQCKYJqOw3FZpCrLLwpOQ2N8zqW+BgKfM1h8l304+ipwQOj3/rPIDpcMtMvhFvC3jpqOsQObToV89hxUCRXMyow3gnVTHy9geh8rSZEsSH1K4/w8ZFKDZ9rUdSiCfojBhWmldU47A5WUQoMbMQ==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by DS7PR12MB8289.namprd12.prod.outlook.com (2603:10b6:8:d8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.27; Thu, 8 Aug 2024 04:37:46 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::abdb:7990:cc95:89ce]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::abdb:7990:cc95:89ce%5]) with mapi id 15.20.7828.016; Thu, 8 Aug 2024
 04:37:46 +0000
From: Besar Wicaksono <bwicaksono@nvidia.com>
To: Mark Rutland <mark.rutland@arm.com>, Leo Yan <leo.yan@arm.com>
CC: Arnaldo Carvalho de Melo <acme@kernel.org>, Will Deacon <will@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Namhyung
 Kim <namhyung@kernel.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, James Clark <james.clark@arm.com>, Vikram
 Sethi <vsethi@nvidia.com>, Rich Wiley <rwiley@nvidia.com>
Subject: RE: [RFC/PATCH 1/1] tools headers arm64: Sync arm64's cputype.h with
 the kernel sources
Thread-Topic: [RFC/PATCH 1/1] tools headers arm64: Sync arm64's cputype.h with
 the kernel sources
Thread-Index:
 AQHateSBMJfpKfrQakC9LSuzV+TLnLG3UowAgACG8wCAABxQAIAAEnCAgADibICAZD9qcA==
Date: Thu, 8 Aug 2024 04:37:46 +0000
Message-ID:
 <SJ0PR12MB56763246FC68494FB086DB84A0B92@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <Zl4MYzhP0NB-Z1DW@x1> <Zl7aOk2h4_73JmUu@J2N7QTR9R3>
 <a1990b2e-2c10-42b6-93e9-fef324cb91b2@arm.com> <Zl9jLtiFagBcH7oH@J2N7QTR9R3>
 <fc940d6d-7ac3-4f69-8ace-459955f72281@foss.arm.com>
 <ZmAwYjyElYQqQy7c@J2N7QTR9R3>
In-Reply-To: <ZmAwYjyElYQqQy7c@J2N7QTR9R3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB5676:EE_|DS7PR12MB8289:EE_
x-ms-office365-filtering-correlation-id: f7bd8980-6a4d-4340-a35d-08dcb763d9f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XYEZRqshgfMwuviCg8WOREO8vULEFL0czRhwPeM3lqK4VbvizWLnHjwumZEh?=
 =?us-ascii?Q?3iyl7hZOf/VFEhdOElD5GatZdOXWHqPaL5JtRe/V5UlwjWeiRcG1Cl694XGd?=
 =?us-ascii?Q?D0AAByrcKM3+cAcgzUM+iZVyRrQeddoAD2Qc39YBlCEdPbBcKDAkgTheGjgd?=
 =?us-ascii?Q?G6JMv9oiDBkU927zYiRunz5n1/gCOCFjiKflTDcR8rPQ9IKXxgTdHyWbwkNW?=
 =?us-ascii?Q?BF8KyxExYl7l+UoHNjq2Ov3VIqgwW3FnDUO/j/zwUdAIwI5BtbbYWBqQ/zWi?=
 =?us-ascii?Q?tnkTVj7VSZIgznpob+u60PjaMPrCIykxg2CuZNbnQH+qipQ6jqSJEMp1IdMR?=
 =?us-ascii?Q?mRa3TBwM74XZ5YpKFICQQ8PbaKl5uXI5sULV/u/3mevMVGzGTSHus25wgcxW?=
 =?us-ascii?Q?QUFTQaK7iThx6QnqErNKskznzK+gHohzrmvHdjK+GqGbnU9EslwRV0fh5KXM?=
 =?us-ascii?Q?1++4ldJmcLIS5ernUkC910RoAnycm9aRblXkLlWZ4x9LP+WauEvEf4Lh0KBD?=
 =?us-ascii?Q?y7hy3mCrR06/F1KeTEXsl4OdV9FjTGM9cU2t+d7I8Z1sP/AhGY3PwVJ0p/BQ?=
 =?us-ascii?Q?VdD8BJhWot6TfbPEFASwqBswBlSJI/BbKrE4Lr0L1E+VTbT6Pd2L4eg8blQj?=
 =?us-ascii?Q?4aCCyM/Le4svfyjzwwPSH4owIDsCr8cLSyRyByCmbTWeq5gxapFBrTldMB1Q?=
 =?us-ascii?Q?oKvouBaiCaop+a6sQAZiDiond3ps/IAspPzuNwyOBQo+onpeSc9Ez1IROy6a?=
 =?us-ascii?Q?l9oxhmSG56bglKPDviGqeI+Hb7y6lxfvDGkGLP5OIJAl/Yy5XShi3arfxV1Y?=
 =?us-ascii?Q?mJ6e41uAQuuZCD1l1t7FnoGXE22URvQ8NRWl7b3rq6UlQcBYc9iUE9JAIppY?=
 =?us-ascii?Q?zpN3GrgUSIpSQb8iX+6VEKbY17rGMLUoeJGH3XfoUjQDLWCc3U7BRi/aYRT+?=
 =?us-ascii?Q?jxTl3qVoRpb/Z8jcTWQERNrXHk0ccvWpzGyudral81OF6kSjiqf9/AZN2fMs?=
 =?us-ascii?Q?VkU4z/Em2bv89BEuA9ha8MX337DSIHgFkNTV2IqEPngjQGjfRLs2fjLpMdEe?=
 =?us-ascii?Q?jipafmVoNGTIfCk7v3Stix6q0QbzyT9sj2CUi89cULa5Jeuv7csNEBD7Ysfy?=
 =?us-ascii?Q?mAqTSdcUvcOmPULvqBSrRGovffxTNQ1bx56lnhzBp0spaOjxX+DGbuAJydTc?=
 =?us-ascii?Q?iiu6QS8Fyx0KBfA66hxuFRkjb+FA4fW2y1E0FMpIeyoq01NzlTg3SpzbDHXH?=
 =?us-ascii?Q?6qLOVu/m7JJIdFOl4oJb4Ehv06pG4CnahLlOjSwFFHi92OlJVmoBS4+n05qO?=
 =?us-ascii?Q?zfLUjTo5kS9d7lCrYaWhCtc/PwovdvCQHzK5hD7kqwW/5zxI8sRgAWL3chGh?=
 =?us-ascii?Q?mEgMy/BHbrm+938Wb4tvhiI8eWfCJr128PzOLXAHpoEr+P6dtg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nUM/mG9nd9HRMaZoHE6SH52rRwtJccrQYy/BqNdUGFABVWbXhYe5SDN8mOVL?=
 =?us-ascii?Q?lfV9kdyqvqiwQv3b/WbMlwuO13n8etJC4tLmbWvrZIBbIS2MHZZuQnAWBUf2?=
 =?us-ascii?Q?kV5yyURSPHzdCq1rJ9lv8BDBTvv5JGXUwV1KaJUC3mORcPCME568FtEGGwDp?=
 =?us-ascii?Q?kKKgZCyFEcA73FNqEDhX3pZVUSEA09tuEy27/hspH/MBwADM56ARZXsdy3bQ?=
 =?us-ascii?Q?purviNvVY7VGjXvt9ILgrhTWxWuVsCXkOwWCIRezqwv0Tv11bObzRoVkiv5O?=
 =?us-ascii?Q?yZFtZu9zA+I9mfcGbdVHGFIteufFd4CWv7ftuCTtgY4kZT5HhnyIWwCaJ5fu?=
 =?us-ascii?Q?gUkwowBavEuI5rZF/0k61CsYp0pP9sGBii6O7PiOIJQklenWfKzNMnwZWmji?=
 =?us-ascii?Q?U6WmKZCHw4PUyVpRCvqFFMR+NuzaWik6//VQQLKRaJBSXCl4Rh8tTbQTQ9tj?=
 =?us-ascii?Q?CzKcMZSNYPjLK4Wsn1zHH7UQ+Pluq7OrLF+0U2X5cPybiWBiy6Hj34s9TRUg?=
 =?us-ascii?Q?LJjNLihkjjoMgPzTTge/fT5tqoumkmLywSdtIHdh3gM6CtX4VXbH8bvAgXmJ?=
 =?us-ascii?Q?wJLHzU7XVzo8CanFXDKdVwniLmrjUmjiuyvtebsAt5KLilhlce2F4bfW7N6+?=
 =?us-ascii?Q?fd7iwsPgtq2nAl9KOjfcfbwFDv7MRnpy2np7jOQ4papN+5LgQfsWwE3HXKzB?=
 =?us-ascii?Q?70JZNhLsG7qM6FsPsv5wT3IawyBiPaP2vD2UUH/oX+Zjys7w6f+VuxXz9IVK?=
 =?us-ascii?Q?tQr6PkSK1hk/VwNDlndGhQ5fWGrFVeOOZLe4cn/hTqjzXli3rNgHXKlqKOj2?=
 =?us-ascii?Q?PteCN8V0cOquJjj+SQh2jxnFBTK6YyA/ec0/HgJLrcZoTUoH1bAbOYLOzEuB?=
 =?us-ascii?Q?AP0SbksJaPr6iZyENBjrxFbrQK8ATjBQqSix1QoxlviPq7pj2vY0AM/hBDJ8?=
 =?us-ascii?Q?kompBw4ANck7TFQrsfn7NIFZWARycl3Yx7kqZvSAgWI/65moIXO2w3ywpFpG?=
 =?us-ascii?Q?RRHaidbxm+R6RoQyItlIk/+clRzgXN5GK2t+tkIbTUfSVQqxidUoS/7souIn?=
 =?us-ascii?Q?0oWEqPISG6t+tYU/R8mHOorTZ1SfXc8M3NK6cMTnBCoE4XH9zPWYSWCydknS?=
 =?us-ascii?Q?G7hrz1S8UaJBK5LS9L/mYbZCZkUBeqeDPTMAc3hVNp+Oi4FYrnx4RkiokCY/?=
 =?us-ascii?Q?vnQbhMMypu2rDHtDV/w7z1MaYalPrCTx0GZIA4MwT++0PRn+RZAkd5VF+CQL?=
 =?us-ascii?Q?1N9bVZ8pGl/lNlGyn7V3JYchn7vfiv/uPM6Gk0GDRzF6dO6tvdOfXKkPuldy?=
 =?us-ascii?Q?JyDbmrEhE4pciCcutWPb8K/1B6gSeBbhaQhhLqGg1Z44TWARlwfAnnggQo/O?=
 =?us-ascii?Q?JjualTF+VRXs18nOMUhmbAofizeWTbHrcMrG7NKMUgfUP3dSxWqXfeu0wzv8?=
 =?us-ascii?Q?BaXzCor2hiLvz3EE4LwbRUHt+Eatn0UvpEVqf6MaGwRhKIaDZuEH2WKQPdqU?=
 =?us-ascii?Q?EMZ+vegRQI2Wv4QPTH0WAavm45HYyiyNK1MsmlcDEQ2LzVy67Rarhu6ZjOtC?=
 =?us-ascii?Q?2Oer4hQeSqUiUyehqv20kfTezsjvuH9RJ6ptHVSA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7bd8980-6a4d-4340-a35d-08dcb763d9f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 04:37:46.5736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 63Y+71uG32GvWEOKqQtKggs5qYi+sPS7V54tZrIbD4521UYKsMbjqA7ymfBMP+3gf/IN8slf568gHpQqeGdYjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8289


> -----Original Message-----
> From: Mark Rutland <mark.rutland@arm.com>
> Sent: Wednesday, June 5, 2024 4:32 PM
> To: Leo Yan <leo.yan@arm.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>; Besar Wicaksono
> <bwicaksono@nvidia.com>; Will Deacon <will@kernel.org>; Adrian Hunter
> <adrian.hunter@intel.com>; Ian Rogers <irogers@google.com>; Jiri Olsa
> <jolsa@kernel.org>; Kan Liang <kan.liang@linux.intel.com>; Namhyung Kim
> <namhyung@kernel.org>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; linux-perf-users@vger.kernel.org; James Clark
> <james.clark@arm.com>
> Subject: Re: [RFC/PATCH 1/1] tools headers arm64: Sync arm64's cputype.h
> with the kernel sources
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Tue, Jun 04, 2024 at 09:01:41PM +0100, Leo Yan wrote:
> > On 6/4/24 19:55, Mark Rutland wrote:
> >
> > [...]
> >
> > > > Now more and more Arm CPUs support the data source in SPE and share
> the same
> > > > data source format. It's not scalable for us to adding every CPU va=
riant
> > > > into the file util/arm-spe.c.
> > > >
> > > > I would like to expose the PMSIDR_EL1.LDS bit (Data source indicato=
r for
> > > > sampled load instructions) via the 'cap' folder, and then we can sa=
ve this
> > > > info into the perf meta data during record phase.
> > >
> > > I'd be happy to expose fields from PMSIDR_EL1.
> > >
> > > > In the perf report, we can parse the meta data and if the
> > > > PMSIDR_EL1.LDS bit is set, the tool will parse the data source pack=
et
> > > > based on the common format.
> > >
> > > I don't believe that's right.
> > >
> > > PMSIDR_EL1.LDS indicates that the loaded data source field is
> > > implemented, but even when it is implemented, the format is
> > > IMPLEMENTATION DEFINED.
> >
> > Thanks for correction. PMSIDR_EL1.LDS bit is necessary but not sufficie=
nt
> > for using the common data source format.
> >
> > > Today, Arm Ltd implementations happen to share a format, but that isn=
't
> > > implied by PMSIDR_EL1.LDS, and there's no guarantee that future CPUs
> > > will all use the same format.
> > >
> > > For the moment we'll have to keep adding to this list.

I apologize I didn't follow. Do you mean adding new CPU identifier to neove=
rse_spe[]
list is still the way to go for now?

> >
> > I would like to use an opposite way - we can only maintain CPU variants=
 with
> > special data source format, otherwise, all other CPUs use the common fo=
rmat.
>=20
> I think that's not a good idea.
>=20
> Today, Arm Ltd CPUs happen to share *a* common format, but that's likely
> to change at some point in future, and CPUs from other vendors are
> likely to use different formats.
>=20
> Assuming any format by default means that when CPUs with different
> formats are released, we'll produce incorrect results for those CPU by
> default, we'll need to update tables to exclude those CPUs, and we'll
> probably want to backport that exclusion to minimize the risk of users
> getting incorrect/misleading results.
>=20
> While the current situation isn't nice, I think the alternative is
> worse -- it will confuse and anger users.
>=20
> I think we need to talk with the Arm architects to see if they can
> define some discovery mechanism for the data source format.

Is there a follow-up on this from Arm?

Thanks,
Besar
