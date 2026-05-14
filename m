Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012040.outbound.protection.outlook.com [40.93.195.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7768316197;
	Thu, 14 May 2026 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778773875; cv=fail; b=W29B5BbdgkMvq36SMsV+0ACIqAHNNuWRYpPdQ1YWU30LjXjIE8C+k6n/vzUJvompWiP3SI4mdteOa+OKJV3PzgK9kcTIJjDSQ2/gNfw3lZCJ1V7rcN6K+63ORVbd1KzelF7sYTO0Sjd0QTfAeyovWKeM6hg5m81qG8ZK0YEYRSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778773875; c=relaxed/simple;
	bh=AhZtkIcL6lerYJUiUIZ28508NICQ8yRRLZEL1BMDfGY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rFLA8OvZZxZsuCbG5r0BfobHqMuYsSeJO7dgX3D3G6TsjKfVSaF4q0u/CLW8NLr0pEneWh2SZkSIKIBgiekOTZf6mMIJkq2PC5YOdjT90oK8QfnatYKtnJb/KEDAEPaSSkq7wdTu8Z5wMuf+DuX2GJ0LSavX7sQLHJBrTderBrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o2hpHcjG; arc=fail smtp.client-ip=40.93.195.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o2hpHcjG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyGo/lAPkEbxwX9NUxyPjR47TkQo/9xxLNI6VpGbp9KqVkbVsMRH22eHl0V16yoKGnUJBujH+XneEwL7Td3HHZtJJPyqhz2t+iq0fnUGyXjbxVszqj/mkhy8aHVjdq5FJlmmBraD1jgJ/2SHh0ezPxWoS5UV5IgdhoxKmd7Z5MBpo/b61/GWhOXe/13V9oIu+8MFAh0JY5xTxDWSI3PoIUNXyTbMZBdKfJVWjyr7GSFoVz+BiPew1MgHwnL6SLuQxfI8gSJb85j5wtdMAv38qrhtp8v9kTO3g2seHebL5t6kkW+hXAtK0S/ttCKO8lz/5926MYRDmi9CJSxPBKqNRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhZtkIcL6lerYJUiUIZ28508NICQ8yRRLZEL1BMDfGY=;
 b=diG+XaEvbpqZtGok33KU7Z435e3dgt/aMeiYlQjGPayTbC+Y7ClkuBu/BwshOsIYppSAO9fWVzRIqr8QCTWwn0cPWhf7/bvI7tO7ZTh86XXueFCg76MQz1hMPU4kahlQEqX2pH4Fdzx+MstojMCqsZXjpCgqKAvlXzomD4fmL49FyMpcyXSk52ZZB9sWfFt8GTFwOU1fQ/X9ld/uYsyNpOw6ucrj4nuv5EuiRYZ0GR4Ia7TAcLmKum9bDD8T/LMAg/K6Sb3X2ZsgCehdY4ECRS67v1KZR1B4gnEmww8ksmTuUcfV1aHOaKtPG7RxwPPvLIP4goFGE/QOz66Hf1hcVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhZtkIcL6lerYJUiUIZ28508NICQ8yRRLZEL1BMDfGY=;
 b=o2hpHcjGq4oy8hRZAkO73rJMspie0VxfSNKvFhvSmn3/u9XmK1T5lG0Hjp5UzgvgzvM8AdTnYrCvp+AhPhZv052/fC72nUuptsE3h8qMIwcfhug634Al+RQWTwcK6BIJAz6r6/EeVJlGYikqYB26c31Ei1VRzruc66Rf+4vRlUhUk0M1nX81S8VpegksLPzYyDc63ncd5s01M5H+khB0YarsCpvjff5OU6guxXLIefyolqURRBbwN/0ZEclK+w5cQQ9fSkd2vojBw6R9jIzE2xyiGSm/E5ChdSvPqTQooKaNTHUha71RtyB+dDOnrP9dAvc1UthjAY2EWew1rLZUwA==
Received: from SN7PR12MB7226.namprd12.prod.outlook.com (2603:10b6:806:2a9::18)
 by IA0PR12MB8838.namprd12.prod.outlook.com (2603:10b6:208:483::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 15:51:02 +0000
Received: from SN7PR12MB7226.namprd12.prod.outlook.com
 ([fe80::c07d:130a:7def:6807]) by SN7PR12MB7226.namprd12.prod.outlook.com
 ([fe80::c07d:130a:7def:6807%5]) with mapi id 15.20.9891.008; Thu, 14 May 2026
 15:51:02 +0000
From: Besar Wicaksono <bwicaksono@nvidia.com>
To: Saurav Sachidanand <sauravsc@amazon.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>
CC: Will Deacon <will@kernel.org>, Ian Rogers <irogers@google.com>, Namhyung
 Kim <namhyung@kernel.org>, Leo Yan <leo.yan@linux.dev>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "aghayev@amazon.com" <aghayev@amazon.com>,
	"juew@amazon.com" <juew@amazon.com>
Subject: RE: [PATCH 1/3] perf vendor events arm64: fix swapped MetricGroup for
 Tegra410 L1 prefetcher metrics
Thread-Topic: [PATCH 1/3] perf vendor events arm64: fix swapped MetricGroup
 for Tegra410 L1 prefetcher metrics
Thread-Index: AQHc4Ypgo2n5oP93nEqgZU81AYCPObYNr1PA
Date: Thu, 14 May 2026 15:51:02 +0000
Message-ID:
 <SN7PR12MB72268D49F120EA8124E238F9A0072@SN7PR12MB7226.namprd12.prod.outlook.com>
References: <20260511210832.91408-1-sauravsc@amazon.com>
In-Reply-To: <20260511210832.91408-1-sauravsc@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7226:EE_|IA0PR12MB8838:EE_
x-ms-office365-filtering-correlation-id: acae1b5a-4d8f-47ca-7a90-08deb1d099d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700021|18002099003|22082099003|56012099003|11063799003;
x-microsoft-antispam-message-info:
 XEBmGCro1xIDy9NjOfDC/4MP7BAa+8bTAgzG5UjECnApo5v4S0US2Zvft73yhIL90gjgiVSf4R4Pq6J4Dv/bz7SqUcoOvJvKZlgszGZG+1jSRFrNywpO60HjsNQ+fnRWAk2SO0E6rBSMKZNRaNM/J2uI6A75S04kG9LNh60UteqXd80b3VL7n5MigkKA/9Qenz/+LJYXhqrjdlTxZy9fOB2yR50oh6HxXBQ3NDZbxuGz/tkpi2eJ78csouRTxVJZLxL2QZlaCvOsPqqY97Id2T7npoGhXWyTvoSEhOhCfV2Ogy64ghkWah3uyM3G/lbu8G0zs5jlM0tf5o8ICHrW6F816x3i8ivx3MRqUMm8vQ5+/ATdea/JcRKgcR1nICHl7wh9kmvWk+0coexr9yTM8EVxqG6qQuPl85e6CGXLFrw+xxoFgNl+Nop1xTm3qQVPw2c3CQisXsJDFm/Z3EvxTzAt5NG7xo25WX9wmRwlkyl9Op06VlqcPURIAY6AikI2wZCGrFcq54/fSLdV1/r/5GXsNMS6gSpnptS/Kf4nhMp8BymESRb2Zdujs/Wz3gAKAArY+wtFQU4DPeokghxKaiRai/hjsKLohIPIbcQTHF5hwbaQmx5nxNh9Ra6mLWM/fmG00ZyjFJmEN4+iF1WQLvN09xbgDIzrgWbAnNsLrjcyZlx1uVm/A9rJ67q9PBmeXCn9UDoN/i1meQ0ci6Jv1NBKh86ENtNE45CImO2QO5XOhdI95pTSxmJIrzmTx4aE
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7226.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XxIoZBbVPUxEb+oA9apeQSRPuTyQEbh5NhpTZVSQHCigr9d0rNkfitu5UuSE?=
 =?us-ascii?Q?YPex3bMixcfDLC9k9UVfJ/qBwXR6Ky3Ed5dQ7rWKretySlcpXCYT2g4GN4js?=
 =?us-ascii?Q?4GVxTpRPk+38VEQtj3U3x62f5sCoQdw+d2f4mseLBce8N58zb9yEsoGWCKcP?=
 =?us-ascii?Q?2xU+l/nroHjTvtm7gaE9a+QaAfFFy7KvBKNffjxQ/Qs7By74mFQGuwwqoeUS?=
 =?us-ascii?Q?Iesbr9Q+JfqSYn2+4gLu8axsFlRFrMC12tBfugbkeTAh23iVoaxn3J4aZBlv?=
 =?us-ascii?Q?5Xmeo3If9NS0ZdbYhYAPNo6uhhEa8nBTx5xKQrJ1W5lxiOZIFwaEJOTfFjzP?=
 =?us-ascii?Q?ZeK1sd/PBLfkxgUz4EN5kmq2jD6GJ3/a6rDeNyIiUEwHiYrXVqk29Qp1ocYm?=
 =?us-ascii?Q?QkNnwR3tFzK3ZZR3+MDJ/p+YnETC3LM2IDnI3UWJl5ZNNwxqk/m9vJvIGTRG?=
 =?us-ascii?Q?3cXSNQWtwhU0rmPf8rFL8k7NQYNIjWkmWJy5ei3HmvIn1KSqx8IAVsoAE8LJ?=
 =?us-ascii?Q?hIhs9n7dpv0JyDeyf705CG6QLD86mKg58wZh4zFF6uwoFF17DZMMZWrY3cak?=
 =?us-ascii?Q?nlZOEwdaqNONPhTKN3F6EDTJqva7YdW2Tsbze2OQECSzDzZEnTZ82kaPNQM8?=
 =?us-ascii?Q?Q8g/UjdjTzp59arJF2Xsgg9zFavoLNwDN8NC7oID7AqHgQo0u7FQZfLvMPRd?=
 =?us-ascii?Q?CUwLRGno478TbmjZ/G2zUT5XaNdWdmmCE9fpBEZeMZlAQ6Be79zSLhc0e1Q1?=
 =?us-ascii?Q?AB1/Po08tBJihBPMMCpQIS9F81WySq98KEjSz6DwvYvRTL+NGp/YawJHkkS8?=
 =?us-ascii?Q?Umn/HGPI1zNjdGM+AtBTS+ENUTB1TllZT4FWuEHL5PHUpzukh+Dl/w+zrmH2?=
 =?us-ascii?Q?UnNUbOwLYbvo6F/mvDcprN2nweRCp6660ltLMJqeqDznxjwUNZ4t/ssDOGco?=
 =?us-ascii?Q?kxQ99ydkqcmzwu5+a0tYaj+s2ozpCHipisJ7iuNTJhcRlpYiWXcU3JKi/Fc8?=
 =?us-ascii?Q?FaLpdfKT57FPPs28fPS8HbJLKhx+OHZLFQPzs6VS2mUxmI3P/9rRjsqCYd6r?=
 =?us-ascii?Q?glxs2L6uUJfVpG/Lm2IaFS20eXnY2OvBGKLAyTzpmbBINrND12SW6H3D46YU?=
 =?us-ascii?Q?/+KGNchhdIkj+BaLu4ENa+mDzPOgbpYuWGCwydfQrtWR2vhg1+L8ouCEwBJ/?=
 =?us-ascii?Q?FB2OG1LevZxoorS0NivtpAvISPMcvcQ9UNvGkL/Q6FMi/w5ZtEbFe28TUO72?=
 =?us-ascii?Q?6+xcMzYLDuFDxiIHUev+bjIShBEwJd+QRBUlkSpG8EX5ftRVExsVXMbR4CRz?=
 =?us-ascii?Q?EQioRVV1h4cmmeULXZESipDyJy/OgmwsvSE6+2ETT5RZ/dobiISWCYLfnLG4?=
 =?us-ascii?Q?g/UJKQUoeiGMuZht6cvT/8l6nNlmwvjj1lOj3nILV8eXEHfOYI3SKHOTkLtK?=
 =?us-ascii?Q?iLwWDl68qAp12Gqp5eUDzx5V6SrdnRIPVehvPmKHRwbypJxwMr73r5BiZjjx?=
 =?us-ascii?Q?b0qDDxu2NLJvXchvinXRRAY4hpBaXpb9+ygVnXajyIZHGpOvcb3Lvvee1ip1?=
 =?us-ascii?Q?dit7n7T9GWgO+Kqu2h+q6bmBzHuwFFHywuaVlhR2qv2sS1R72uerL1rfLXoD?=
 =?us-ascii?Q?weldsGp10alL7bA0nvEitpGZtdXY48nMmkfrVFd37vpMehPRDXLuO+8E+PRG?=
 =?us-ascii?Q?K4RiDxm8U6yFOgs4Mxf214SyvaIf/xPAvsaWuR+2pdyA6DF2ua4k1e74DOV+?=
 =?us-ascii?Q?FdLLATE2Bg=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acae1b5a-4d8f-47ca-7a90-08deb1d099d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 15:51:02.5235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NmAo36JkcHA44EhpeMjfU+2CEWaLoAIm/ZjKKFWoHJj/cyqbG5irxo7VD+JGl3aW0cvSYQyVxjlTGjaL9p5pzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8838



> -----Original Message-----
> From: Saurav Sachidanand <sauravsc@amazon.com>
> Sent: Monday, May 11, 2026 4:09 PM
> To: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Will Deacon <will@kernel.org>; Besar Wicaksono
> <bwicaksono@nvidia.com>; Ian Rogers <irogers@google.com>; Namhyung
> Kim <namhyung@kernel.org>; Leo Yan <leo.yan@linux.dev>; linux-perf-
> users@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; aghayev@amazon.com; juew@amazon.com; Saurav
> Sachidanand <sauravsc@amazon.com>
> Subject: [PATCH 1/3] perf vendor events arm64: fix swapped MetricGroup fo=
r
> Tegra410 L1 prefetcher metrics
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> The L1D prefetcher metrics (l1d_cache_rw_miss_ratio, l1d_demand_accesses,
> etc.) were incorrectly assigned to MetricGroup "L1I_Prefetcher_Effectiven=
ess"
> and vice versa. This causes 'perf stat --metric-group
> L1D_Prefetcher_Effectiveness'
> to display L1I metrics, which is misleading.
>=20
> Swap the MetricGroup assignments so L1D metrics are in the L1D group and
> L1I metrics are in the L1I group.
>=20
> Fixes: 86ff690f45cc ("perf vendor events arm64: Add Tegra410 Olympus
> PMU events")
> Signed-off-by: Saurav Sachidanand <sauravsc@amazon.com>
> ---

Confirmed the L1I and L1D grouping was swapped by mistake.
Thanks for fixing it Saurav.

Reviewed-by: Besar Wicaksono <bwicaksono@nvidia.com>

