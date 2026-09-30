Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B40B36826E;
	Wed, 30 Sep 2026 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.26.1.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790796573; cv=fail; b=BRSrd2sg9ij3K+wKJIDxTqYAefQUTnsOYbmwwRGCrPDY/4gZ1ewfit45C/trwckFRgnPwqRDRiITelZBwz3kECY/Xsmsr5YUMZhJ73lgPZah+7GlqmJXcUmE3Zvuqf8KAMl+fmwI67dLcBUJjJVFN4tA4Q+YPP5Yzxi6Q6bG9k0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790796573; c=relaxed/simple;
	bh=T+tajYXb6EoCJ6SQSsx4iRa4GBbUv81/tBORF5tv6aU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jolqDcT+H5v6y2KusTEYLEeHyjTRrchXLgYDnEyDzLEjJuQTkbU3RBEnYnME/NTo5cF8kjC2uGqlszKPUyxx7o6Qin1uLUtBlbyh7IYkcqVsftmJzyhOarQiLLN0VRLnPQCVBRYlQeE2wLQf27n+kTkpfO9pWlDId6WLF9GBCNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=X37wmNus; arc=fail smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="X37wmNus"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790796572; x=1822332572;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T+tajYXb6EoCJ6SQSsx4iRa4GBbUv81/tBORF5tv6aU=;
  b=X37wmNuszT6HeCt5HUXj5JxTEhZBGV6xoeG9npFFqQS35+JCXdEJb4d9
   hzBtD/iQ1Y4vNYi61NX2H/4QKGDM6Yj15IjB9bzXkoMebHT/7wBiyFtoM
   svp9pLzDCVMomuqmcg0Tuvx5tULwPka133A5oe3BkqVzyFfIgcaRInVa3
   7WCWtnET0Ih/0OfEiKGEUm2F109V95Xuimzlonylj2uKwe7EHAYAEzZxp
   mnC7wy1Q8Sy73CbM5fvh8E1BWcnnktdK/hnTiTWpqQAdiJwAFFoJ65viq
   pi/2kTFJb9ytl2gUNBabUg+qGjRBX6uUdcrtYBJJfRClnmbQon2NpQa88
   g==;
X-CSE-ConnectionGUID: /DNjClJaS1GJ7vH67AR/Gw==
X-CSE-MsgGUID: JuCNy2XJROegu5blFFoB8w==
X-IronPort-AV: E=Sophos;i="6.27,133,1787011200"; 
   d="scan'208";a="30106393"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 19:29:32 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:30374]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.119:2525] with esmtp (Farcaster)
 id 5afd9171-aa51-45e9-b4be-4f43e0a043bb; Wed, 30 Sep 2026 19:29:31 +0000 (UTC)
X-Farcaster-Flow-ID: 5afd9171-aa51-45e9-b4be-4f43e0a043bb
Received: from EX19EXOUWB001.ant.amazon.com (10.250.64.229) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 30 Sep 2026 19:29:31 +0000
Received: from EX19EXOUWB001.ant.amazon.com (10.250.64.229) by
 EX19EXOUWB001.ant.amazon.com (10.250.64.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Wed, 30 Sep 2026 19:29:31 +0000
Received: from CO1PR08CU001.outbound.protection.outlook.com (10.250.64.168) by
 EX19EXOUWB001.ant.amazon.com (10.250.64.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49
 via Frontend Transport; Wed, 30 Sep 2026 19:29:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6B4Uidvl0+F2FSWrU6UYXGd1zR1Jl3bh+9qRC0ulzNyzte9ItKy3wIon3ppMvV6EHzRbD/hNe/d66ezBYRy1SgX+5kQSocjd3kr8+RQaQviawAoM+cLAetYoNCSaWrdpygWfybtc7X+Pa1H7fSs76XSxyV/o7/daTVKMmH3uTlkSaaJy7a2o69yR8IZYCJi+i1uVMWgAYIkCU+oS89XPQMhZNL0IHX/lXLZCbnTUyPKkoNuZkKe1lKyQ/oJfu8JLmbZzmfX0zflvlzqk9lS14x6E0ZiO8wKwZqe6qaEoXBzkHLNHlhgeUxnVm6PV0/Kv/XqS8QY0fmiWbmQzQSG9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+tajYXb6EoCJ6SQSsx4iRa4GBbUv81/tBORF5tv6aU=;
 b=Jee3vptL2tCNqNJHM6RePTYm4xybc9662+SZdwn7u9oKFV/lWjnuxOcOSYSNlBSQDDaPfK7dGdkcgVsziKjOf3EUO6IstvYIiwxTdamDWWW/nywX+wyrxVkiL4ToU6F0pTXN1bzA1gY/UlsJl6biYfGS9ypI3LO6uKZLwq+EA+AFWgu+GktIUwFTBoC3Isj4dSCImn7iqWNsfGv8zfYFTuI11Rn1lRGgnNv/9oixXilX1m3g6o0CVipu93/XonkgqJffKznv/FbkQLcQ88hCB/ThfjX1oApktnO2z2LgoplN7BBS8Inx3l03U0d/T4CYgOI22LLhKGobAwPugBEKIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from CY2PR18MB843218.namprd18.prod.outlook.com
 (2603:10b6:930:10f::23) by CH4PR18MB6261.namprd18.prod.outlook.com
 (2603:10b6:610:22e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Wed, 30 Sep
 2026 19:29:25 +0000
Received: from CY2PR18MB843218.namprd18.prod.outlook.com
 ([fe80::f89e:823f:6d11:2f68]) by CY2PR18MB843218.namprd18.prod.outlook.com
 ([fe80::f89e:823f:6d11:2f68%6]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 19:29:25 +0000
From: "Okanovic, Haris" <harisokn@amazon.com>
To: Robin Murphy <robin.murphy@arm.com>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "will@kernel.org" <will@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Okanovic, Haris" <harisokn@amazon.com>
Subject: Re: [PATCH] perf/arm-cmn: Allow userspace to select the PMU's CPU
Thread-Topic: [PATCH] perf/arm-cmn: Allow userspace to select the PMU's CPU
Thread-Index: AQHdURIAJvo3yua2RUmC2W5fD5s0ew==
Date: Wed, 30 Sep 2026 19:29:25 +0000
Message-ID: <CY2PR18MB8432185386B28FBC1DA23F3333A88B2@CY2PR18MB843218.namprd18.prod.outlook.com>
References: <20260929223244.2411400-1-harisokn@amazon.com>
 <b782f893-e3ab-40f7-a7c5-ce19660be2c1@arm.com>
In-Reply-To: <b782f893-e3ab-40f7-a7c5-ce19660be2c1@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY2PR18MB843218:EE_|CH4PR18MB6261:EE_
x-ms-office365-filtering-correlation-id: 581ff5a3-b5f3-41fe-91ab-08df1f292308
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|6133799003|22082099003|10067099003|3023799007|18002099003|56012099006|38070700021|11063799006|5023799004|4143699003;
x-microsoft-antispam-message-info: UvDqJhzS3AzCuAr4zpircy+EZzBOLROIGy/uNUBHkY995zezQemFgqIYWn/Ra1RXYIyZOHXpw1KYzqaJVFq+V9/1LUQW6i3KF+yCUGrY7z7okAZzzoDwqVMBAap5lmfctcNDPJlZMm5szr4QhCIC+pjeXhTFpWO0p/lQVk8FmkiRcSnw/WTxZZTlKDDqgRcxCv4/mHp2l7PQW4K0uBHNhMpX4QXpN69qr6yNVYhF9KQt0OrnAeIle8e5nPZWdfBYQr17F6nNZSrmNZmTQ5/zl5MVT914rr2F41cXXkQpQg30LaG1K93l0bf1AHHeOiJgzA7iwEIWe/ze+5Rmj57+E602g1d45TkL9u1Ut5dpKe6hoZVP7CymJi8Jf5TaqL3JdDB54uB9wxipywo+4f3N//Y53q9bsTGpxEr096cfOb75Ainp8YqX85bm9z8+3B421NZSysjGYGTY5BR/9uypgKeTeIL2XKpZn2TLobY/MP5DntKRwERhA/vz5ZbOpkNr1AbTIZ3u857vsVCqa7OVLv8BFHdCv4mevimWcyfq5hCugPHnJEyvhBsaXptWYPxp8yyOPWlQVpRhJIWn+dirsT/Aw73KQhrsXmiape5+7lszrFfuXQ829oY6YcoIzezByXm5F9F28ZFixIs4f2LCDMe/8DC8NMEMvUsobMB2hWy5NnDmWJZi1lRmyme/B0N4EjitoC3Co5cO0vgnnQpBN4EVOLXm7jy3zhlwj8WoYbo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY2PR18MB843218.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(22082099003)(10067099003)(3023799007)(18002099003)(56012099006)(38070700021)(11063799006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7jJ00vHMEUaDKbTwk0fmWCGJp2aelLl+MMjnxC2L1OYei3Y1NkejS0STlf?=
 =?iso-8859-1?Q?P1Dsw6e2nFsvP3lsX+OI2w+DouDBVB9c+lCU466GTYkOQjBOxCAdU1ld/5?=
 =?iso-8859-1?Q?RXuXCuI+Qv5MD6OzXeRKnigFTmynHtZTIn+658s6GYkCfJvbo2xjLEHFzZ?=
 =?iso-8859-1?Q?7heW34aq0XOWa/CUC4BryvKiNCBVPKjZh1OgHQAJ36bL9/9Ffm0n6TvsSX?=
 =?iso-8859-1?Q?W7yw6wtZzgBuQupcVT6uLmO4ivpYqFlwKbkkMS+gwdKR7gzzLi5l6T5oLQ?=
 =?iso-8859-1?Q?oI5PWwR0ME/6DXxxRYgyx48B7278FKTxtFGEq7pk0hnZ//ekfaj6vZ9dlq?=
 =?iso-8859-1?Q?6aZY1ZbMFSDeoETVk+RRpk+PiQwc22B7hVifP8tMG/XN59/5PYl2aStxnA?=
 =?iso-8859-1?Q?vRyg6vSLtxV6m6l8ocx7Gk4UpMFGsjpLmVBfs0imHdHfmthfioMwdlp2x6?=
 =?iso-8859-1?Q?w8Z1cXaEx9YTZmymL5KHE50+KTEja4ddUbZD/KXYYueP6NDWxpi6WrcBiQ?=
 =?iso-8859-1?Q?h60STDlX3OCPcPGdGzTLGeR1IjLjrG97WED5d6nGcEVlqxoY2J0mX4vIT+?=
 =?iso-8859-1?Q?mJDQAyIUkaADUCzb9vChW7u9uThjUBQxHWVVruyWVvj963dnKFjIuY4le8?=
 =?iso-8859-1?Q?EtvqyBAbLCIstsJb75G0pgQFhemk2MjmeLkDqD8i6bvNSVl5jT+oveS8xy?=
 =?iso-8859-1?Q?/MR6NPmyUOl9ChE5QkGlGZOcYkQCE+5Sj7niLp67mesqz/hohOCUP6a8GS?=
 =?iso-8859-1?Q?8csfbZlugb6JOZ35mQ+Uq9MCr7CFv0dewqVZ7f/8eE5SprrASupsC2Mpcc?=
 =?iso-8859-1?Q?MMGkqbR5jMhMrPZIrhWmBhRdbYY3WRaMZ/pyYVyXfDl7glqzSqLD0h9xFU?=
 =?iso-8859-1?Q?AJ0MzVGDbMwVc7CNmzwZqch7GumuimJaV5WVHKuY83mTQEbXcjPjRm3zEb?=
 =?iso-8859-1?Q?xSVOArHNtdpgAdo0nYkxyRkvORCeKupM4TR+WAkN81Crv4AYojauZAoLDT?=
 =?iso-8859-1?Q?10YS0aNQ1hHCkFIxbukKDVb4nisIP4XRtXkV9i6mcFmcBN4wMc7giNtA86?=
 =?iso-8859-1?Q?5GXJXd5fVISs9Jdm+Va+F17vfjBaz4d1u4YnU+xTlq1E0pPjpUHi/ONtOt?=
 =?iso-8859-1?Q?Mi6+1c48V2ptvlTUdFpzmKoXZE7TAoIliOZlV3uTXQh8d0eJRwqDLQ0KGe?=
 =?iso-8859-1?Q?NmXWT7LcNXkS6KRt7DsixXfTWNbe/7WRqbP+EotmV2QBudBWBOm+lWTEGx?=
 =?iso-8859-1?Q?qYTrVlZ/YBdveQ55QeI07QfiXT9GvpXlxISEGoZqaGVT+aX9/LTI8I4w+r?=
 =?iso-8859-1?Q?CawWy99fAev0xTd+3P92HMWv40PiV3wj6lJKc4/4E9DXOhAWADIQu3+m5k?=
 =?iso-8859-1?Q?WChKVKqRolJdrp27rh03tkHHyEt9tt+kxQeADi4cUoMqbGQMgKsx+81h0g?=
 =?iso-8859-1?Q?PZM19v/oDHk/noxwcZgMsAStoMISaIf2RUQ2mLsm2BqYTU4kAlvpd4JfEN?=
 =?iso-8859-1?Q?uyIKO5aVTf1sapjtVEaCZ0ONwn0xie5J012g0jLOg/9d5X42pEKCsRE06a?=
 =?iso-8859-1?Q?vxFeZ1a+Ebok8IAGrmmzyaArt6k1Upx0+qA3Y+9btwHqKfR7WFdwjIdBXd?=
 =?iso-8859-1?Q?7QXPmvTDfMxaumf0QHBFB4bhyLZySm6e+DUdpVEV4okK8RgnmQ4+3BBI8M?=
 =?iso-8859-1?Q?l3E91TQ2MdcXNc8eZkS0FE/q5oPXg5/5J7u+9HhtoOjI+0HcDubQ/eKt2S?=
 =?iso-8859-1?Q?cNMpoBY+Kv3TJoRXRazuS8PWwI4514Pi6bE5IL7thW4wMG?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: f4KLlOvkCz7e1pk5Pxbf0ockcUKr4xLszewduZ/ajtCBeEsDSGtVpmPwzzbRGjb9q0nxy5q1MYWrjszh4BvvYPqVKTsiRU0+di+GpHZ2Z51SoO5/AUVZef6vCJyjYRi9jb4Zb4Oc1A94KHMC0Ob0mKvOlCmu0Il0cAkx6tlN0t4JN9lIw//J1DwDI+2McLd80ky/nvtfPXPCAxepXgZFikHl8iMoz5s+Q/6JdMXC/qWVDY0936x1R1MHQiMPrJrsvpN+Jkry88fo2kHhBF9zEQyptArLUhgVAXDPMGRo4TCsGzw8WemBh7aIcGEItoRgsQmaZP0Ilw6ABeClFfUp+g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY2PR18MB843218.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 581ff5a3-b5f3-41fe-91ab-08df1f292308
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 19:29:25.1369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ACnTOE03h9cYX8fbG4ZUaDnesiXdbCio9vxCJyBbVA82G0fWQBfWqBu7jUD43GlFvpNM8pQ8+U8QppFIjnp+AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR18MB6261
X-OriginatorOrg: amazon.com

Hi Robin,=0A=
=0A=
> > All of the PMU's recurring work therefore lands on one CPU. This is=0A=
> > problematic on systems which reserve particular CPUs for latency=0A=
> > sensitive work or confine background activity to a chosen set of=0A=
> > housekeeping CPUs.=0A=
=0A=
> > There is no way to set it explicitly. perf_event_open() and 'perf stat=
=0A=
> > -C' have no effect because arm_cmn_event_init() overwrites event->cpu;=
=0A=
> > /proc/irq/*/smp_affinity is refused for the DTC interrupts, which are=
=0A=
> > requested with IRQF_NOBALANCING because their affinity has to follow th=
e=0A=
> > owning CPU.=0A=
=0A=
> All system PMU drivers have the same concern in this regard - why=0A=
> should arm-cmn be special?=0A=
=0A=
As I mentioned earlier, we can improve performance on certain system=0A=
topologies by assigning PMU work to housekeeping CPUs.=0A=
=0A=
arm-cmn has no constraints around CPU assignment, so this is possible.=0A=
Every register access is MMIO and the DTC interrupts can be affinitised=0A=
anywhere, so any online CPU can own it. That's what makes "write any=0A=
online CPU" a sound interface here. I've moved it to CPUs in both NUMA=0A=
nodes on the two platforms I tested.=0A=
=0A=
You're right that the concern is general, but a single interface isn't=0A=
easily shared, because the set of CPUs that a PMU may be driven from=0A=
is platform/device-specific:=0A=
=0A=
arm_dsu_pmu, for instance, can only be driven from the CPUs attached to=0A=
the DSU, which it already exposes as "associated_cpus" and enforces in=0A=
event_init(); hisi_uncore_pmu publishes the same attribute.=0A=
=0A=
Intel uncore is per-die: MSR-accessed boxes must be read from a CPU on=0A=
the target die, since rdmsr reads the executing CPU. Accepting an=0A=
arbitrary CPU there would silently read a different die's counters.=0A=
=0A=
Do you have an alternate API in mind?=0A=
=0A=
> What prevents =0A=
> perf_event_open racing against this update such that the new event->cpu =
=0A=
> still ends up with the old value, and thus will no longer be correctly =
=0A=
> synchronised against other scheduling calls/overflow interrupts/etc.?=0A=
=0A=
> Now yes, I think technically that race might already exist in a tiny =0A=
> window due to the order of hotplug callbacks (yet another reason why I'd =
=0A=
> like to clean up hotplug handling...), but at worst it's still =0A=
> relatively benign if the old CPU is actually going offline, since it =0A=
> will very soon reach a state where that misconfigured new event just =0A=
> won't work - since trying to schedule or read it depends on =0A=
> cross-calling a CPU that's now gone - but at least it's then not capable =
=0A=
> of corrupting _other_ events.=0A=
=0A=
You're right, nothing prevents it today. I assumed the cpus_read_lock() in=
=0A=
the store covered this, but perf_event_open() doesn't take it. I'll look in=
to=0A=
closing that window in a v2.=0A=
=0A=
--=0A=
Haris Okanovic=0A=
AWS Graviton=0A=
