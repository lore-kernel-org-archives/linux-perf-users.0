Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898A810F9
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 01:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TZBoUFCD"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2071.outbound.protection.outlook.com [40.107.105.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE3A120
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Oct 2023 18:43:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNvTJ2zvr8V8MBfJipOF8bOmhBImnXeXspyeHflepLxnKPdBCSmWu+ZqPaV+BIATD8ZpSbdejYIiH+haJi0relLZovzgm6C4d1Mpl61QgwJBupJy+cA76+ZhNG/37RfFevYch3KvILzHvhsAM/8aUJ20Lqpv9fZIQqhYJyJ+r0QWDB27Su0GSfkmo2sA3Lw6vhsw+c0upFb9tV2XvQFFbrPSOXLzAkkLfhNh7/fAd9LyMn24b2fvcuaFwLIb2SXNJ0Ii1BBHZkwX1yXFoOwaDWJXI7nytxWuWKy8nbJPG5os7S3utsPlOEWC6eRP+qRRthdof8pnCwZji/fMZznYVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxWpq28yFbSbZkHeUZVZiQ0ITFDEHrz7beISBiwGiSU=;
 b=eH+h1RMPFqYm8YR5RaebWoMwmcowohE1j4DzIhWbjMNY2ChuzVKwpirSUXNqY2RDyiY5XE1vzKVZ/9Kau3OfsGkoSU1nQvlOl1+yrSKV1PlKZ9LrfoXys2agW0QrpIO5QzgFbBDHyiVRVAjXrhyPwkMvGyLXP44Utz6t/5phgBP+LFoedIFETmC6qFjX4sRFVDt/eNyLpdzNmhE9S/sCg2lgEoOM+yc3/z4XMYuYEYQv4X+THWkF7ccuDTmyCyjxpXqn6Y7/dTE/f4ayMVjKsL8XZdvmCJgyYD92VEgqLPYLQ6nt03SVzcLicBo4rW6QzSjlligZeBJWrtRD1z8bTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxWpq28yFbSbZkHeUZVZiQ0ITFDEHrz7beISBiwGiSU=;
 b=TZBoUFCDQbVNvNul23Qe0X6HacevbgcdA9vld3vdTNDyryj/dRp288RwDJhU9qOK+xTbEZOxdAJ58PE5fNdeUWlw3vwQZbDlNlegKPeTOEPLgI0xyt0rqi85T468MrVDTeYhmCuDaCY3RhVC1ESDsyCQogRw1WMf86Mn2DnjHH4=
Received: from DB7PR04MB5146.eurprd04.prod.outlook.com (2603:10a6:10:23::16)
 by AM7PR04MB7174.eurprd04.prod.outlook.com (2603:10a6:20b:11a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Tue, 24 Oct
 2023 01:43:05 +0000
Received: from DB7PR04MB5146.eurprd04.prod.outlook.com
 ([fe80::cfad:6c90:d915:c7a5]) by DB7PR04MB5146.eurprd04.prod.outlook.com
 ([fe80::cfad:6c90:d915:c7a5%3]) with mapi id 15.20.6933.011; Tue, 24 Oct 2023
 01:43:04 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "acme@kernel.org" <acme@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "namhyung@kernel.org"
	<namhyung@kernel.org>, "irogers@google.com" <irogers@google.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: RE: [PATCH] perf pmu: add loaded_json_aliases firstly for
 perf_pmu__num_events()
Thread-Topic: [PATCH] perf pmu: add loaded_json_aliases firstly for
 perf_pmu__num_events()
Thread-Index: AQHZ+0ZdJU29rcXARkKJP9DIcTwrwLBYP/KA
Date: Tue, 24 Oct 2023 01:43:04 +0000
Message-ID:
 <DB7PR04MB51464A0BF392FAFF62000E8B8CDFA@DB7PR04MB5146.eurprd04.prod.outlook.com>
References: <20231010065738.2536751-1-xu.yang_2@nxp.com>
In-Reply-To: <20231010065738.2536751-1-xu.yang_2@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB5146:EE_|AM7PR04MB7174:EE_
x-ms-office365-filtering-correlation-id: 8ed1a173-e675-4d2d-42d8-08dbd43290e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Xa1HqXfITzbIWT4G/mx1TFTm/bPv58fi9mQin0znGQnpv+AwVH9z2IghJ5k46FH1bnVMsKVW+FjQW1rsFEloJzGeYcTrv96Srm5d/R2GCPpEaPnwNo1XItLCth/DZrBjqIVhl04Vsg6Aokg/SSEnon7q/j12kuCfsuAuuJGmaBkyfUrhSiXWHXNE40MADfxEPO0L0WJKQ+Vh9vVi36S/x4+7uokPF1tGQTrYVND7j9HQkX6n0JlDmXgdohfWxK4czu2Gb6BYxzhK7tj9tOn43TWkHK9ox/9nKBtG6aLH9RbEOQWQkkNLLbf25WGfjkpfrScgNE5nWe2J2OXospdDVxQTyzokfgYOfBRnyJN/kEbTt4JfQ1CNmECez/zrs9xSwHXqjck4bBmd82BfHhx+EqmxVZ9m2YkGz+0FhuhGxqN+LVnGDtmsECAbUHtynuvNggzjEEZGB5rE5W5tDiQY3tnxmfzDkchSlggwbCq/6nayvyLJNcIwN2GkWHcZbRsHUzvJBln3PHR4L4CMfJe1jmBHLtLE0MhYH7HfA918votJhWTizVxdXOklIcjVEjnp76shMITjUqdC/skHsoGXHEo6ml9LrqtM6tgFueoXfoqvoOKQ1xXBGqkLTf6wdU0n+ynkg92h+wgy2dGYlXHGWw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5146.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(38070700009)(26005)(55016003)(38100700002)(2906002)(4744005)(41300700001)(5660300002)(52536014)(86362001)(7416002)(4326008)(8936002)(33656002)(8676002)(7696005)(66946007)(64756008)(6506007)(71200400001)(478600001)(76116006)(110136005)(316002)(66446008)(122000001)(66556008)(66476007)(9686003)(101420200003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LqDupVXpf05eswB3McSr2eo0h3YKmvEN974wXG/0rbAe3FH7QqdZUOAmHO6S?=
 =?us-ascii?Q?3hi/jvwrlFj2V2aZR/UYsdkEzTzlE+hHO/PI1nNk/dh3U0a7/oP5QxCDkNML?=
 =?us-ascii?Q?k31DVEYvhe/ukEyGWEDTznpUVapo0VG2oI9TvJYDIYBE2NlkfbOtb0QBG2Hi?=
 =?us-ascii?Q?5RCLtQdqz79ktGAZ3p/E1wFDJ1Q1XpUp4mXoiap7OEQpKpPMfIHQ6LaAadMU?=
 =?us-ascii?Q?q/sZajBQkzyW8T0G8agEm2IF4U0athf5VdDb3JNd08VPgkU7T61AOjeZAdAz?=
 =?us-ascii?Q?7F2p4WlPc5ATukZSwUG6iOY5LC9Nkfy5ijoscE8uitFj7aPjuycXrq9i8x+7?=
 =?us-ascii?Q?JKMFLXMGa72TUzWJM6OZom5f9R77CLAeI61U95r4ns/xA6FuLwmtitqspZab?=
 =?us-ascii?Q?7YgEgHvyFr8R3V6+Rko6VBuxY0qTadpQJ5ss5t6aiT1F8N2lw9ajrwTG54cD?=
 =?us-ascii?Q?YJr2N2TD6aiE/BGmlWSuP0zHIEd6GlTX59CKl+o2jxxXVQRcg4Vz30DgTL/F?=
 =?us-ascii?Q?oAXpaVh5nZbaGk0wTMEeLyIbXZKbjvf/pmD4YROtail6lrScBWbfmgvAxhDe?=
 =?us-ascii?Q?zGTayZ0Dg7cd0kGWwJtQ4XnQqNXnPnBeHQbr6p1ZOEJ9MpbYqWymqQIBG3fO?=
 =?us-ascii?Q?qepX/muZ63ZqZnvycAGzFQQwr2yDS78VsmZiEP6XhGa5EaKX/YHoBDsPhtSE?=
 =?us-ascii?Q?fFwC7JqDaKxYaBx0lpKt365TjW5M9qdFJ+yBvCp0juUMHkvcWEcGkENrqxN/?=
 =?us-ascii?Q?UE65kRNnREF47Y9So167UNzcUoqFIEhxNyxFUX4HO4bteplYTYBDqH+ItW3D?=
 =?us-ascii?Q?dB/Aq64luul+LtiBFQk7mT9AeILWjtxQ3ykY7Fr35/GQEqeHpKKemXVUckhW?=
 =?us-ascii?Q?p6SA31+BS6zAXURdo9VZJxHXGzp7YwDzChd6tEI38+S1vxxKXe8AD1s2iHqs?=
 =?us-ascii?Q?jKWFMxa1tUdjGoMsl0bqzlk7Wb0mnmkOG93QzOEjdY3kYO+7pDcSMJ+O+Wek?=
 =?us-ascii?Q?+BH+EphPoBLpEwAi16PyO4p4gHClXrfULJ+tXk8+WoCiWRDjO3oMvd1E+PT4?=
 =?us-ascii?Q?wvSiiXoMYXIWvo1wQon7XAuwctpeHRKUXOBIs8UM4gPnecCRg4jCAVZ+fmky?=
 =?us-ascii?Q?JmNwD3JlCMTVhNsNobPJLGoGctgrrWA/39t8c4p55fTASoAyNrRgkChRPgGv?=
 =?us-ascii?Q?NdYxyQKVcgkeNmJQ31nz4DbaAZJoaZBCzlcSYK/xJ5Za32RNcI/zDDzfzOaA?=
 =?us-ascii?Q?r6NrLadEYH84rgeAYZeoyQywitweeYPVPbOHTwJof4Ae8p5e1Q3rzFddbv3J?=
 =?us-ascii?Q?KN2xQ/J44XcEBqWmPFn1HIStJwxAiEQJjgvE9rQeR/OMDS4rivOwO0avwKNk?=
 =?us-ascii?Q?z2PaRyYS3kKwPmk/BWyt1qZVADRla0NU65TlhqZ6Nudfz6Iz918Ligq02Oo2?=
 =?us-ascii?Q?HxGxlmUeirXFNNlnLn0c4n+8m7A8xJcyRg9dhX4o59ykqPy1JHnypykQDLrF?=
 =?us-ascii?Q?/o3xVE/PtURF+phug/XeFMMNfXmA+6smRRC29uicrgiUe//Rq0RMsh2G2txW?=
 =?us-ascii?Q?05n9E2llKoKunVpuVK4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5146.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed1a173-e675-4d2d-42d8-08dbd43290e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 01:43:04.7037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M9UQVB7zqIonV/wHPvRdtAvCP+oMtaHKLGvvc5nqQxB3IZzn3a7mO/X4RdOWb+UZqxZVmT3kanl8JCpQ2Cb4RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7174


> After pmu_read_sysfs(), event aliases in json may be loaded for non-core
> pmu. And pmu->event_table is NULL for non-core pmu.
> If perf_pmu__num_events() didn't add loaded_json_aliases to the total
> number, perf list will show below error:
>=20
> Unexpected event imx8_ddr0/imx8_ddr0/write-command//
> ...
>=20
> This is because perf_pmu__num_events() didn't count correct events number=
.
> This will allow perf_pmu__num_events() to get corrent events number.
>=20
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> ---
>  tools/perf/util/pmu.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 8de6f39abd1b..920ab1c2e93b 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1609,6 +1609,7 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
>  		pmu_aliases_parse(pmu);
>=20
>  	nr =3D pmu->sysfs_aliases;
> +	nr +=3D pmu->loaded_json_aliases;
>=20
>  	if (pmu->cpu_aliases_added)
>  		 nr +=3D pmu->loaded_json_aliases;
> --
> 2.34.1

A gentle ping.
