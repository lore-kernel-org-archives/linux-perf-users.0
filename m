Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41EC1624F7;
	Fri,  7 Mar 2025 03:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.214
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741317067; cv=fail; b=rz3ioWFypibK9fLe9ZMk+u3vXTvK0eGD3uLuztDxb95wVDGk1x3R1AubywVTm0NovCEIE/+D5K0DjGKW8V4VRPcVGkPUdHVHyVCpWpzBWsONZmHimKXtKcA3WZa0V9ZMJbGxzdMJsdU6LGhUcEA83+ZDunm/k49YWkuySoy7mqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741317067; c=relaxed/simple;
	bh=+N5Gw5jLxWfOzmtlmgj/+JhNqmYInSZPsTzY6JpcIxQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IBF9EugZ/0yQWfvepoKUDcv4vO1NDpR5GbZg0UCq1trbQSPaFp1Q2qyVZ1CkiN6OgpJn7HRyYChRtQtKg29mGN0i/wWngJ8bDXubq5/OP3ZYKNG/QVRV2D2yvNiO3ZhBi3BtF6zKF5JJMr2gEQ0zBncp5NLaQwIauSLn1hjDHkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=P1zhbAHm; arc=fail smtp.client-ip=68.232.151.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="P1zhbAHm"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1741317065; x=1772853065;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+N5Gw5jLxWfOzmtlmgj/+JhNqmYInSZPsTzY6JpcIxQ=;
  b=P1zhbAHmTva0io8yrXz6vnTJxyejxRAUWCFBo32uZ6mnQV6cO+6WQtnb
   SJY0OXbj2yLMBkxYzqcOoLFFJlxVgXgIdLoD3Oxge4/wC6K8XymUJ49av
   MTQF3XA2yC8OgpP3Yw+IrVa+H2A1ts/F9cn5p03BsfX/K+97S4nyBkizp
   h/QZ4OdM59d1TuSBs3kDwbgIVs79Ux4gN43y03satedNl9Tei6z5BhZbW
   2UDoi7b+dtLQ/+Sv5tryEhZlIBG6FgBbVyPuIqWTMPYGzldrxV4wl0Bgd
   hF0p22ZVnmW2owBgrDGGKGMtyKYB3SyhWTpdAHMbWBUZsqT7pUvxxr+AB
   w==;
X-CSE-ConnectionGUID: Ien/3P9gSwi3R8R9DEAVcg==
X-CSE-MsgGUID: sl/ifU8sQSm4gSoWgTKYhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="61633230"
X-IronPort-AV: E=Sophos;i="6.14,227,1736780400"; 
   d="scan'208";a="61633230"
Received: from mail-japaneastazlp17010002.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.2])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 12:10:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dM3rIj9mmaZhy5V+AGJJIxyDn1aOwaaM1ae8FO/wakXY4BeQu21wZUg6Dy+CQQx2ipbPyfT78/xD4Ht+8hOE/yZPqfvDZHhH4sWaaKFf/eVARejAWivBZjfrksgqDuxmmwsheDbUo6aZBrtGsrkHqHwmfnuHFVAT1V2soEgE7wiUPYHMYGmr2G0uBTK0FQksGLfqinFZkXpY4nDphZz7QFQeZQEJ1PF5m+0VBOX76wI5k4Tn8MzXbwDJ730oVpIVs2oQo8veInlrulR6JCu04vRpomi8LnPfOpTtZN2Faj1rEkaE18PHVO5C2nrfVykWTmEh6r5BEkXd6exG+THYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+N5Gw5jLxWfOzmtlmgj/+JhNqmYInSZPsTzY6JpcIxQ=;
 b=OGn/UJdsEVPIxbumgZqzOVLFNjeTT3DpmNz5ncrTLKk66cX5DxLRc6Jy4c7cK1Oey5on90s6fY9ryiC/6/LO1GN/nksZT3qhEDCU+8ELvtFINqLA8RZ6SXFnXexqs/7xOQKSZx4kd90X15/z7M07DxFHpHBZswwSKg///V6xBviFILyfl1alW24HeOaWSkC8SJLrHEOOGyfgHIgVkwwQVGRe3MnjmDLn4vzAKlCgvK/Yu1UZepixseyUSDoclDX6XFAIwO+AzybnzecIMeNmiw1NODVh9QJJnkMRq6gOV+L32umyRmKe3AwVXFtu1mpd5060N3Ut6KJfKBtPN3EeBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB6903.jpnprd01.prod.outlook.com (2603:1096:604:12c::9)
 by TY4PR01MB12797.jpnprd01.prod.outlook.com (2603:1096:405:1e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 03:10:48 +0000
Received: from OS3PR01MB6903.jpnprd01.prod.outlook.com
 ([fe80::df96:5745:d1b5:cafe]) by OS3PR01MB6903.jpnprd01.prod.outlook.com
 ([fe80::df96:5745:d1b5:cafe%4]) with mapi id 15.20.8511.019; Fri, 7 Mar 2025
 03:10:48 +0000
From: "Yoshihiro Furudera (Fujitsu)" <fj5100bi@fujitsu.com>
To: 'James Clark' <james.clark@linaro.org>
CC: 'John Garry' <john.g.garry@oracle.com>, 'Will Deacon' <will@kernel.org>,
	'Mike Leach' <mike.leach@linaro.org>, 'Leo Yan' <leo.yan@linux.dev>, 'Peter
 Zijlstra' <peterz@infradead.org>, 'Ingo Molnar' <mingo@redhat.com>, 'Arnaldo
 Carvalho de Melo' <acme@kernel.org>, 'Namhyung Kim' <namhyung@kernel.org>,
	'Mark Rutland' <mark.rutland@arm.com>, 'Alexander Shishkin'
	<alexander.shishkin@linux.intel.com>, 'Jiri Olsa' <jolsa@kernel.org>, 'Ian
 Rogers' <irogers@google.com>, 'Adrian Hunter' <adrian.hunter@intel.com>,
	"'Liang, Kan'" <kan.liang@linux.intel.com>,
	"'linux-arm-kernel@lists.infradead.org'"
	<linux-arm-kernel@lists.infradead.org>, "'linux-perf-users@vger.kernel.org'"
	<linux-perf-users@vger.kernel.org>, "'linux-kernel@vger.kernel.org'"
	<linux-kernel@vger.kernel.org>, "Akio Kakuno (Fujitsu)"
	<fj3333bs@fujitsu.com>
Subject: RE: [PATCH] Remove some PMU events for FUJITSU-MONAKA
Thread-Topic: [PATCH] Remove some PMU events for FUJITSU-MONAKA
Thread-Index: AQHbiNpQ8JjCRF9TOkCjxP8mdt+sprNa+hOAgAGBj7CAB6SosIAAMnoAgAK3+KA=
Date: Fri, 7 Mar 2025 03:10:47 +0000
Message-ID:
 <OS3PR01MB690377379ED81FDF8D60142DD4D52@OS3PR01MB6903.jpnprd01.prod.outlook.com>
References: <20250227054045.1340090-1-fj5100bi@fujitsu.com>
 <96b323eb-15b2-4b60-8522-83bf2f57694b@linaro.org>
 <OSZPR01MB6908AA7CEB24ED38F9289D6DD4CC2@OSZPR01MB6908.jpnprd01.prod.outlook.com>
 <OS3PR01MB6903726FDA70250F72A73410D4CB2@OS3PR01MB6903.jpnprd01.prod.outlook.com>
 <36123515-a268-40cb-b010-2600c2f5c1c6@linaro.org>
In-Reply-To: <36123515-a268-40cb-b010-2600c2f5c1c6@linaro.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9ODA5YmMwYTgtNzMzMC00NGM2LWE1OTQtNjZiNmYxNGI2?=
 =?utf-8?B?NzdlO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI1LTAzLTA3VDAzOjEwOjA3WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6903:EE_|TY4PR01MB12797:EE_
x-ms-office365-filtering-correlation-id: a74699ab-2b7b-407b-ac52-08dd5d25a896
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Nlp6TzcvNVQrTGdlRitWOUlKakZYVm9RUnZoa3ZSaVIweDVrdTFvZG5oa2o0?=
 =?utf-8?B?cGM5WStXcjBhWHlqNU0xWjN6Z3hjOU9XSXQ1S3R3LzFyekYraHhudmZYeEts?=
 =?utf-8?B?eWdUVXF1dU1MdGVFbk5XaitvM2FkaFJhVkZ1TFl0L3FYOWFNWDVrMEE2M0kv?=
 =?utf-8?B?UUdHV2RXNWVkLzMvWjBKRTdNaEFkQ0V6ck1GdXA4aU90TE53djV4cjFwSmc5?=
 =?utf-8?B?YkRmVUFYUUkwUHFlbmorb3ZmeEt0eitpaVBKNnRBWjdVbjh1bE9SQ1VUVGo5?=
 =?utf-8?B?bDV6YlNGcHNacVl1bEFMdTZraUJUNjlJZHhoWmVzWjFoN2F6b29mTndMU2ht?=
 =?utf-8?B?Ulp3Rm9uVnUyakNudGFQT1BYMXNPdzNocHdySW5uT0xYNmVsR0diQXV3SVlB?=
 =?utf-8?B?OWFpL09OZFdBaVJpN2cyRmhTNWlKa2dqRUpIWnJqYXloTWJiY3RZQkFEYU1R?=
 =?utf-8?B?cVA3emczMzNwaUhjZXBkQUF6L08wUDNJR3JPVTRJV05SMElCblluM3JuTjdS?=
 =?utf-8?B?NWI3U3N1ODJSK3dzQmQwcVhNbDl5b2UySWdnYm91ekZIMStCZUxyWUhzOUhk?=
 =?utf-8?B?NmwzZUVST01wNlZ2WDhnVDMwb3I4eXNqanlYenltamFtVWFEWjFRbjhaM203?=
 =?utf-8?B?ZUUxRDlBYnY4VG5KWHc0eXVPK2VmbmhnQmJQZkQrZXlndFFqbHcwTnc1V29K?=
 =?utf-8?B?c0szb2VuNEMvaGZBM2V4Q05acitybFV0dWd1TktEMWNYYThJV3hvcXl0VlNt?=
 =?utf-8?B?YzRzU1l6TjNQTzE1Q3ZwZlB0aWxDU29lelpYODE4RTV2SW92UEk5NEY3UDBL?=
 =?utf-8?B?cmJKdjBRUHJ4YVYzUTZGVU9MUDJDYTBCMFprQ2hERW03NWwxWlJHR1lJTGNn?=
 =?utf-8?B?Q3VrWjJyMXFoeFQ1V3RjSTFqbXhJU0pjWkZtajZ2MkdzRWZ3V1k4aHdyYVFa?=
 =?utf-8?B?enU4SEJtY2QyZHNQVlhJcEltSWJjbnJ1ak1IRWFhd0tSeHdpQmc5ejNVV0Ra?=
 =?utf-8?B?dkM3Z2ZkWk5NZ1dvKzVIcERRMndOZUlZVXVvRnV6SmNscUhMaHQ0YWt3WXpC?=
 =?utf-8?B?T0FodWliRmFhMlBYNUI1RURSNGJrQ0dEa2FRcWRyRkRkZk4wS2xQTHpXcnNT?=
 =?utf-8?B?Q1lLY3NzTHluaEhDMzJCSmlxLzBFMkU3ZnpVWW1lNGNmZ1VYS0xOaHAxdUZ3?=
 =?utf-8?B?Q1VvRWFvcXBIcHJtSmdtSXZtdnQvS1Y1bnhnKzcrQjdDV2Vkc3R1WnZwRk9h?=
 =?utf-8?B?ckhWK0wrMGxMUGt2Z3NXbE9EbGtGVWR6NllpRTB2YUhXZTVCNEttVWFyR2w5?=
 =?utf-8?B?U0JENzhxaFJObUlEcXJEV1RVcFEzOE9nOElRVW1VVFl2bEdHaDcxUzdxU0xs?=
 =?utf-8?B?cEo0czA2Uk8yc1c5YTlZcXFzZzhvVGJDZDQzYWRhM1RSRUV6QXhnRllHSWRJ?=
 =?utf-8?B?QnpXUzhtWFNTRFUxZ1FvbmE3Vk11TnBUUjdpcUtYZDlXOHRnejNFTnF5STNE?=
 =?utf-8?B?bEZJb0k2aWt4cWNuYXJXaElkVHBNdlAwMVFvZWNMMW5JMG5UR3h6a2tnY0l2?=
 =?utf-8?B?M2QyNEs1QlFkNDlxaXFtODZEMUY2Nm5VZGp5VHg5Umc2eFI0d3QwbURTWW5X?=
 =?utf-8?B?eDN2T3Qwa3ZOVDJzRW53RGd4UTBmS1Ftc3VTcFgyUWRxeVJyMnJScUI4V1dh?=
 =?utf-8?B?NFpuUkNteDhmVHZ5cytFeGpCWDZyYzM0YmlPN1lWekt0QTJZZGRPK1QwY093?=
 =?utf-8?B?Z0hQTDIrWU9oWlM3RlVYeWt1dHdidnduSFRIdnJMNUQ1NjdOenBVU0R5Wjhv?=
 =?utf-8?B?SitDcklTRFZxTXI3bkhoK0U1RUIvTHN4SWRZVWlUQzU1dmhPSTByRlRNRHha?=
 =?utf-8?B?ZnFKNWNCczI2RjdsS1VUMkk3NUg0VEwzMEwybWJwSE5IQ3did21MczhqdHY2?=
 =?utf-8?B?MkhuUDAvRmJSOTgycElVRFF4VjFMM0ZpK3hGYjZaVlNtaUpRN3U1U2VteC9O?=
 =?utf-8?B?bk4vM1BOUWJBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6903.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?REVCdGdhdFdOQTVUSnlObm9FYnZpMVJ4VWtxalNrck9vYmRmM0N0RkN4L0My?=
 =?utf-8?B?R2pVNnA4MDk2SS96Zk1uWHB3V0lpekNHT0RTbEc0ajhXWFNtbGZNSkpDV2lj?=
 =?utf-8?B?QVRianlXU0pZem1iVnVMRGYxNkNoTzFXWU5JVkhLcU1CamtlZkwyZWE0WEEr?=
 =?utf-8?B?a2V2WjVydWw2QS8ySzM2b2paUGs2YktNeWo4TSt0UjZBMnF5R2dVL3dsd2di?=
 =?utf-8?B?OFoyaW4wNTN6L2ZyQyt3YnhpSWxVYmJWU0d2QjQvY20ydkdaZjBOMmw5R0VI?=
 =?utf-8?B?R2dDMmN3QnBrZHpBYWJoQi9ERXlLeUR3cGczaVFha3BBN0xOMkJEVS9WOVVw?=
 =?utf-8?B?V2d5Y1ptdGhtdG9Ed29iZXY2UmpvTVpGZENZYjZMdm5tazFpZ2F2elZsNm42?=
 =?utf-8?B?NlpvelNtY3Nxd1A4cm8zWWtxbkg3WmNjOVVNRlAwUy9QMHZ0RDlNanpuSnhZ?=
 =?utf-8?B?T0U1c2tYYkk3OS92YTRnclo2a09aK1VRR1BtYTdMaXhsZ0tXaHBxaEM0cFM5?=
 =?utf-8?B?TmljWW9mQmxodS8zd0xWamhGY1pwT052eXRXaHdaNkpYdWJ5WGF2M1VNNVhl?=
 =?utf-8?B?ZDBYRHRQYVU4TU1wWGJBOC9mV1NldzRWME1rMzI5L2RhQ1VNemRGMERxYTlh?=
 =?utf-8?B?d3pGd3VZV0p5a00vSFJZYmwxckRXWjNHeGRmbjV6R3k4amowa1dwMTBqWE4v?=
 =?utf-8?B?QVN5d0xTVmdYVFhhRDFVZENJZm9QVmE5VGt3VDAxQUhGN2k2aWMxNFZrR0Nv?=
 =?utf-8?B?RlBhU0k5aXl4WFBYSUR2Vk1TN1ArWmZ1Ujlvang1T3AyNGN6VDdMYnd4Q1dj?=
 =?utf-8?B?VlF1K1pKVUlITUJEZnp2UFlsU1laUG0zaXdnWEpmK0U3bGlVT0x4SUQyVGRj?=
 =?utf-8?B?R0ZqcG0xWit0N3dBUkVFb3lIZ2lHcjNuVGx1U0theWVGNVJoNG9md1psdEsv?=
 =?utf-8?B?c0kzZjU2WHd0UlB3M1JIZTlSYm41aWdLeTR4eTFpbEFGODVibk1Uek1DanRI?=
 =?utf-8?B?YzFDeW9udnB4YlRTUWNBMm9tRjlxODl5OG5abTgySVN4RkM5ZGlJaHluSysy?=
 =?utf-8?B?dllUOTVERnljVkpXSTVudnJjZlo0U3NIVWE2a3JlV2RMRWVXS0pXRzMxSjM2?=
 =?utf-8?B?eFdVY1FHTDkrNzh2ME5ZbFhyZlo2ZXR2OVRjY1NRb1Z3aHFicnY1cVBHYnZE?=
 =?utf-8?B?dUQyeDdhNkpReTNjOVAySXhVOXc3YmdsMWs4RDVhYXRkZEwxNlBWVUhZT2xN?=
 =?utf-8?B?bGNERDdRWXQ5ZjdKWFkyOC9rTmZURExKdnpQcFFlUHpHZE1FdEY4bnJieDRk?=
 =?utf-8?B?T2Z2dzFQUXFVTVo1cURGZDZtVFcraHdMbnRNMXVDQUFXQTRUVzd6eEFlSGJJ?=
 =?utf-8?B?N1gvbi9pK3FlRGgwYXlMbHI0VWZ6QTRobUZWMnk0TXA0eDRXbTF5TkppNGRz?=
 =?utf-8?B?VHFvNEVEU2tPNVNpZkJWVlhON3NjcU5zTEFPNFZpT0QrQkxpa1VtZWNSYjNO?=
 =?utf-8?B?QlN3ZXZLTU1DN1l0cDNJMUhWdTR4OVR0aVArb1gvc1FVMXF3UWJaNVd6ZlBt?=
 =?utf-8?B?UWFkS01QY3VteG1hYXgzUGpVT3BlNFJENDg3OWtnQTFpcjlrNWdlYXQycE8w?=
 =?utf-8?B?U0VjWEEvTmxHNTAvdTBxZGJ0aWxJeEZidnpzZlJXZVlCRFk0SnZBMmJGaXk1?=
 =?utf-8?B?bW1JZnFCQ1dHMXplcEJSRkQwT3oyc0NSRmJGZm03UFkvSlBMWThMMHVPOC9v?=
 =?utf-8?B?R2ZVaXlER0FCWnVDNStmZ2hXVWRWeElqelkrZUVXWlB6eEFnZTFHVVlsTmk2?=
 =?utf-8?B?bCsvOEdZL1FoaTRvSE5wTkludjR1UGUyYkRObGIzaDd3SGdnc0hXVGYzMW56?=
 =?utf-8?B?ekIzMnFId0tWcmdkZDhudndSUnA5WWhjd2hpOWorQzVTcmx5ZmhWU2dOeFNX?=
 =?utf-8?B?RXljNnF1VjZkUEQ2OTBkS3RiTXZqVTlNTkU3OFA3NXJ1N2VIOUJXWWRFMWFX?=
 =?utf-8?B?S2JUQjRBdEpZTUJvaFd2UC9pZTV0TVRheVdwdWhDSStNVkE2MVI2d2RjL0lq?=
 =?utf-8?B?Z1ZvbjF1eERpbVFkdkVma29hRUpMVUVKZlFwWUF3TTFNelRNNTlueHFERXlT?=
 =?utf-8?B?UHUvNHRER1d2WXNkMFN6eWdIMUE1ZXJjOUU2SGRJNW5KTTk0MnpveDFzVThh?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ERZUMTE6NBY7fiq1cSMToKGfRaRt8o8NnI8CRuLPmxCd74L+yHvqe+DL8XBoN7W1v28Ls4ih5JTUEbusQqjlQ5s7aiX2j2JyYUBy3QSrUnWtt6kydN/6I4bVNVluctLt/RTdINDjIeaHi6pP39QpIpFErHz9JpUAUPXX4gqdzNb12D2+RmhGdqjLmIm3RGMbgqbmAuRJgSKTY+5hz6gekyH8BoFFwPwQzyNl16O/lKg8my5riF67gDtboDIom8jqQYree4UD/l0XopyLSfBx9/5qdt/BMNcwPRMeQLrCgxUk6KtqYdkHVBATurvc/rHhuGFvRXnjf7q8ROyciViCweD9/grXg2lmcqff4x2T2tcLP4vTazSjGFXFVBZX/Vswfy0teNRUxuCPPrq7gLqp/Hx6CBaf88I4cq0gowhSAub3OX3zx+6OzJe7ZbeQP204nbCF0D8weeexwHZ7mxP9i0UotmG9O76xQ1W6eBzZvIPlvQ1jbEpG26EC2ktcZT7hHpF5jJQty+wlhEr8JLq7oWmo2FWlwoOxkTCkNXLSEvmEi38byKfk6/c0LlHrYpra08UEGIuV591coaOXmQOXzh9mHHTAdciuP5a90mQssjs8KCGmySxm/xuA8hBjz21A
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6903.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a74699ab-2b7b-407b-ac52-08dd5d25a896
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 03:10:47.9829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dOa6aXgozEYPvS0UaPdFsTTT7bq+3H3Plq41Vrn9luiKcwaLQ8XlXMrEVZxLjJQz1ZUTpQA0QL2eVukPn3l1FkpltwayrkHe0Oq9i9FjjpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12797

SGksIEphbWVzDQpUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudC4NCg0KPiBPbiAwNS8wMy8yMDI1
IDY6NDAgYW0sIFlvc2hpaGlybyBGdXJ1ZGVyYSAoRnVqaXRzdSkgd3JvdGU6DQo+ID4gSGksIEph
bWVzDQo+ID4NCj4gPj4NCj4gPj4gSGksIEphbWVzDQo+ID4+IFRoYW5rIHlvdSBmb3IgeW91ciBj
b21tZW50Lg0KPiA+Pg0KPiA+Pj4gT24gMjcvMDIvMjAyNSA1OjQwIGFtLCBZb3NoaWhpcm8gRnVy
dWRlcmEgd3JvdGU6DQo+ID4+Pj4gVGhlIGZvbGxvd2luZyBldmVudHMgYXJlIG5vdCBjb3VudGVk
IHByb3Blcmx5Og0KPiA+Pj4+DQo+ID4+Pj4gMHgwMDM3IExMX0NBQ0hFX01JU1NfUkQNCj4gPj4+
PiAweDQwMEIgTDNEX0NBQ0hFX0xNSVNTX1JEDQo+ID4+Pg0KPiA+Pj4gVGhlc2UgdHdvIGFyZSBk
aXNjb3ZlcmFibGUgc28gd2lsbCBzdGlsbCBhcHBlYXIgaW4NCj4gPj4+IC9zeXMvYnVzL2V2ZW50
X3NvdXJjZS9kZXZpY2VzL2FybXY4X3BtdXYzXzAvZXZlbnRzLyBpZiB0aGUgaGFyZHdhcmUNCj4g
Pj4+IHNheXMgdGhleSBleGlzdC4gSXQgbWlnaHQgYmUgYmV0dGVyIHRvIGNoYW5nZSB0aGUganNv
biBzdHJpbmdzIG9mDQo+ID4+PiB0aGVzZSB0d28gdG8gd2FybiB0aGF0IHRoZXkgZG9uJ3Qgd29y
ayBpZiB0aGF0J3MgdGhlIGNhc2UsIG90aGVyd2lzZQ0KPiA+Pj4gUGVyZiB3aWxsIHN0aWxsIGxp
c3QgdGhlbSBhbmQgeW91J2xsIGJlIHdvcnNlIG9mZi4NCj4gPj4NCj4gPj4gSSB3aWxsIGxlYXZl
IHRoZXNlIDIgZXZlbnRzIGFuZA0KPiA+PiBhZGQgYSB3YXJuaW5nIG1lc3NhZ2UgdG8gdGhlIGRl
c2NyaXB0aW9uIGluIHRoZSBKU09OIGZpbGUuDQo+ID4+IEkgd2lsbCBoYW5kbGUgb3RoZXIgZXZl
bnRzIGluIHRoZSBzYW1lIHdheSBhcyB0aGVzZSAyIGV2ZW50cy4NCj4gPg0KPiA+IEknbSB0aGlu
a2luZyBvZiBhZGRpbmcgb25lIG9mIHRoZSBmb2xsb3dpbmcgd2FybmluZ3MgdG8gdGhlDQo+ID4g
ZGVzY3JpcHRpb24gb2YgZXZlbnRzIHdoZXJlIGluYWNjdXJhdGUgY291bnRzIG9jY3VyIG9uIEZV
SklUU1UtTU9OQUtBLg0KPiA+IElzIHRoaXMgb2theT8NCj4gPg0KPiA+IDEuU2ltcGxlIHZlcnNp
b24NCj4gPiAiTm90ZTogVGhpcyBldmVudCBkb2VzIG5vdCBjb3VudCBhY2N1cmF0ZWx5LiINCj4g
Pg0KPiA+IDIuRGV0YWlsZWQgdmVyc2lvbg0KPiA+ICJOb3RlOiBUaGlzIGV2ZW50IGRvZXMgbm90
IGNvdW50IGFjY3VyYXRlbHkgYmVjYXVzZSBpdCBjb3VudHMgYXMgYSBtaXNzDQo+IHJlZ2FyZGxl
c3Mgb2Ygd2hldGhlciB0aGUgTDMgcHJlZmV0Y2ggaXMgYSBoaXQgb3IgbWlzcy4iDQo+ID4NCj4g
PiBJIHRoaW5rICIyLkRldGFpbGVkIHZlcnNpb24iIGlzIGJldHRlci4NCj4gPg0KPiA+IGV4YW1w
bGU6DQo+ID4gew0KPiA+ICAgICAgIkV2ZW50Q29kZSI6ICIweDAzOTYiLA0KPiA+ICAgICAgIkV2
ZW50TmFtZSI6ICJMMkRfQ0FDSEVfUkVGSUxMX0wzRF9NSVNTIiwNCj4gPiAgICAgICJCcmllZkRl
c2NyaXB0aW9uIjogIlRoaXMgZXZlbnQgY291bnRzIG9wZXJhdGlvbnMgdGhhdCBjYXVzZSBhIG1p
c3Mgb2YgdGhlDQo+IEwzIGNhY2hlLiBOb3RlOiBUaGlzIGV2ZW50IGRvZXMgbm90IGNvdW50IGFj
Y3VyYXRlbHkgYmVjYXVzZSBpdCBjb3VudHMgYXMgYSBtaXNzDQo+IHJlZ2FyZGxlc3Mgb2Ygd2hl
dGhlciB0aGUgTDMgcHJlZmV0Y2ggaXMgYSBoaXQgb3IgbWlzcy4iDQo+ID4gfQ0KPiA+DQo+ID4g
QmVzdCBSZWdhcmRzLA0KPiA+IFlvc2hpaGlybyBGdXJ1ZGVyYQ0KPiANCj4gWW91IGNvdWxkIGhh
dmUgYm90aCBieSB1c2luZyBCcmllZkRlc2NyaXB0aW9uIGFuZCBQdWJsaWNEZXNjcmlwdGlvbi4g
VGhlIGxvbmdlcg0KPiBvbmUgYmVpbmcgYXZhaWxhYmxlIHdpdGggJ3BlcmYgbGlzdCAtdicuIEkg
dGhpbmsgdGhhdCdzIHdoYXQgdGhhdCBmZWF0dXJlIGlzIGZvci4NCg0KVGhhbmsgeW91IGZvciB5
b3VyIHN1Z2dlc3Rpb24uDQpBZnRlciBkaXNjdXNzaW5nIHRoaXMgd2l0aCB0aGUgT1MgdGVhbSwN
CndlIHdvdWxkIGxpa2UgdG8gbW92ZSBmb3J3YXJkIHdpdGggdGhlIHBvbGljeSBvZg0KZGVmaW5p
bmcgIjIuRGV0YWlsZWQgdmVyc2lvbiIgaW4gdGhlIEJyaWVmIERlc2NyaXB0aW9uLg0KUGxlYXNl
IGxldCBtZSBtYWtlIGEgZmluYWwgZGVjaXNpb24gYWZ0ZXIgZGlzY3Vzc2luZyBpdA0Kd2l0aCB0
aGUgaGFyZHdhcmUgdGVhbS4NCg0KPiANCj4gRWl0aGVyIHdheSB5b3Ugc2hvdWxkIHByb2JhYmx5
IGFsc28gdXBkYXRlIHRoZSBkZXNjcmlwdGlvbiBiZWZvcmUgdGhlIG5vdGUsIHNvDQo+IGFkZCAn
aGl0IG9yIG1pc3MnIHRvIHRoZSBmaXJzdCBzZW50ZW5jZToNCj4gDQo+ICJFdmVudENvZGUiOiAi
MHgwMzk2IiwNCj4gIkV2ZW50TmFtZSI6ICJMMkRfQ0FDSEVfUkVGSUxMX0wzRF9NSVNTIiwNCj4g
IkJyaWVmRGVzY3JpcHRpb24iOiAiVGhpcyBldmVudCBjb3VudHMgb3BlcmF0aW9ucyB0aGF0IGNh
dXNlIGEgaGl0IG9yIG1pc3Mgb2YgdGhlIEwzDQo+IGNhY2hlLiBOb3RlIHRoYXQgdGhpcyBpbmNv
cnJlY3RseSBjb3VudHMgYm90aCBoaXRzIF9hbmRfIG1pc3Nlcy4iDQoNCldlIHdpbGwgYWxzbyBk
aXNjdXNzIHdpdGggdGhlIGhhcmR3YXJlIHRlYW0gb24gdGhpcyBtYXR0ZXIuDQoNCkJlc3QgUmVn
YXJkcywNCllvc2hpaGlybyBGdXJ1ZGVyYQ0K
