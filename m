Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792534504;
	b=dLDfBubfxlvsHpruxX54w3SRQ3F4XGRPwwe51t39wDTjJQHlOUbO+08Kzd3WUP/Bc0jm
	 J3lWQduWM+pMLFSIPT1KjRRB/tqtKc9vXcOVraFODeI2apv+73UuFSKsnGCICQD+40ml9
	 m3c8d027/9/+j2ZECGoa7E6FpwCj5nAZkabmmRhHTp4rdqsMkBZxP7N0DXqy7+b5ISV7y
	 lIlwtMM9zOXohQ1FWQXTSuZpu/3HYV9sqY1S6vyw/c9w8i+u8XIV8S5lteybMt14hzjHS
	 HvTVmhWDavoSyHtFeIp+Yk5TwiI/WhKtBXYjiR4cFOag7OtWgFw7ke8cb5AYCRgJFdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792534504;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=JHFhg/NXQ6zQZdJm0cHEKOKveKTUzG7LliK3G8B3AEg=;
	b=GhZ+dNR3z9A5EyPsZ3Q9UKzlUNoaAD+IUm19YSeiJikvjGzVi/N0E0evHTprWIfZ0V+v
	 wiM23b0EnfeErerx1H7+KnYsrXjk/y99ZadT6651O40yNoa/FrcrT+eF2QRSeI+ebf9XV
	 PO4nmnRqDbWtSL1qLPaCEf1g5OS76qlSfliIW/ynvJUObNmrgpmtkTGSy8DScYJ1j3xmC
	 sgJ3BUcBFgzmbt+UPxR6XepC0yq4bGuGnx/4QZXBoHw3tgkYubdFFMlqCEZqpCGdDTwHA
	 3hbGuvUC4U+/1zm0zKq3R/c0C6+vWDpCZmo9odktYx20SUDuY2s7om2WMOwW0uUQPmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BFaHGKgU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.57
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011057.outbound.protection.outlook.com [52.101.57.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B46606A319;
	Tue, 20 Oct 2026 22:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61B46606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BFaHGKgU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B89NkAwhlACIFPOsiD29NIcOz08zw22RssjaqrW8RCdKJpllmcTWmr7pN057ZXccZ0uRjtUCHoRqbYR0xjHGOCMQwXoGtZMr8mAy9ca4RZzO+1xGKJgyFjP0xnvtK3GdjjMmB/quv+9QTqgFtMpllVSB9RzK25o9wcAJIavRNKgR2tylHyOgzOmReXyQnudSHl6rQ4NnsKnKKl4fknUVpIWWwGkhZHpx8wUbaU/TtrvZrNYuIfAmp8dmocuDl75zjlmu/PWHb8gQAzpg7qpOzy/MiLuk7FmnK23OvdVDksLGcGYoZxVxkX0yeR65XhENUZmUa4bBvm2PLjDOwBrcFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHFhg/NXQ6zQZdJm0cHEKOKveKTUzG7LliK3G8B3AEg=;
 b=oesuFHGdvT3uHcYLkiEUy2rgq/XvzdBs+zhTx7sYiOs4QcQSr39/0KNKvkbg97dX1D8WcwbHI4ran9IKY0Saj6E+Oo0tZWMj1TzNNUUMXMe7/1pD5l5rN933yjZlJscp9nfnyUNa+TzKqefO9Mud3tJWc8TEcj3c43eaK2fqIjO4GBPw4l5CM9xUW/edTZGoI/WWpFRImTledQjsRUeDkQ2Tf2yjIDPJI+S5CbPwwGTRqztku/eO+O/cD6H3NpqhYx0UJHBqQraYqhqHldeKtBa3auOIlgcEd2C/MVLrkCaxqTCsv4G86YLo4KSqKpdTpeHTaf4WtRRJ/dBOtxYBPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHFhg/NXQ6zQZdJm0cHEKOKveKTUzG7LliK3G8B3AEg=;
 b=BFaHGKgUPp6i6VI6dCu3IDIa8nVRfc14tdEE8U2MjoQ4hDjq/EG7i58Xhd+eB47jxnFagZNFOxO3RMt7PGzifBWrUD8DjK/g+DmPUa/VuDfSIHFagxgRUfadiJjdAaqXwTSHV0CgQMEh1zqgv4plho+uqW11GqvH8kkmNEnAdeE01AsYhM3adkoHWT2DmrTFNWw9b8tITfH35v6FGkv4xzxfXYIK3P1FQ9F/OapzNL40zDXJlOJwMLTzBmR0p7ICYkYund+Udom56lv5GVmKGeUqq80nve1W1KGGCBIN8PMY9bzArvWg59s5rcPkJbt2squYp8l4MznIK7495z6clQ==
Received: from SA1PR12MB6773.namprd12.prod.outlook.com (2603:10b6:806:258::16)
 by DS0PR12MB9725.namprd12.prod.outlook.com (2603:10b6:8:226::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Tue, 20 Oct
 2026 22:14:57 +0000
Received: from SA1PR12MB6773.namprd12.prod.outlook.com
 ([fe80::ba62:69e8:261f:1cdf]) by SA1PR12MB6773.namprd12.prod.outlook.com
 ([fe80::ba62:69e8:261f:1cdf%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 22:14:57 +0000
From: Besar Wicaksono <bwicaksono@nvidia.com>
To: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>
CC: James Clark <james.clark@linaro.org>, "namhyung@kernel.org"
	<namhyung@kernel.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>, Rich Wiley
	<rwiley@nvidia.com>, Sean Kelley <skelley@nvidia.com>, Matt Ochs
	<mochs@nvidia.com>, Raj Joshi <rajjoshi@nvidia.com>, Thierry Reding
	<treding@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>,
	"john.garry@linux.dev" <john.garry@linux.dev>, "will@kernel.org"
	<will@kernel.org>, "mike.leach@arm.com" <mike.leach@arm.com>,
	"leo.yan@linux.dev" <leo.yan@linux.dev>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>, "ctshao@google.com"
	<ctshao@google.com>
Subject: RE: [PATCH 0/6] perf jevents: Add NVIDIA Tegra410 uncore PMU events
 and metrics
Thread-Topic: [PATCH 0/6] perf jevents: Add NVIDIA Tegra410 uncore PMU events
 and metrics
Thread-Index: AQHdX+j820IqVkloIESFMfXWuRCVnbcFHTsAgAGxwICAABWKAIAAGO8g
Date: Tue, 20 Oct 2026 22:14:57 +0000
Message-ID:
 <SA1PR12MB6773C6D7355C7229EF1341F0A0672@SA1PR12MB6773.namprd12.prod.outlook.com>
References: <20261019164241.403644-1-bwicaksono@nvidia.com>
 <21f58af0-fa3f-41c5-ab03-216c60fbe2f1@linaro.org> <ate93zQFkfAecIv2@x2>
 <CAP-5=fXUMVJwtAp+8dA8V=hBD9q4x6J4YiUufwXAOXcAJoAKTg@mail.gmail.com>
In-Reply-To:
 <CAP-5=fXUMVJwtAp+8dA8V=hBD9q4x6J4YiUufwXAOXcAJoAKTg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6773:EE_|DS0PR12MB9725:EE_
x-ms-office365-filtering-correlation-id: 7e8d351f-f081-4f44-cd35-08df2ef79333
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|7416014|6133799003|22082099003|18002099003|10067099003|38070700021|11063799006|261009223027099003|4143699003|56012099006;
x-microsoft-antispam-message-info:
 IGnceCjVh2nPr6SinfETqmNuUDKYCtwWFg76DKiQco+bpNQ8CCrzcYCZ2RJ3GAhtAoxNp5mhBrDmG/vTSr48AodG9Es7aLxO3vO0dvEjC+3GUa9rNFHvZIDSTMRRyAd4lvvov6fxyoV0nghXe7PwO+ZhFZtenLzSD+wgbrgQSCj4ZGjsdS8gqqpccViZel8de0JpNnoeu4mymRn2Yss0XSZX978R/14dQIYQAP5Gu6s7pTbvmtYiXuZkzigEYdQk013y/wtsbYL7JqKqJYyzo4p6WlmAwBISDIPS8zmjXC/bUaYYWn7ZjwLDL2sLacjVFY6H+X4vWgqhwN98jleE0Oz1VLTkMQ9rLALO636678PcsIRX2v8qGkRZNr7Wryuky54EHm5kSgWH7jPJiOUoLOxi4achVuLR2p3mzVW4h60xtDhNgU0PjehhUd1O7aoo83MAlixpj4e9jrcag65UQBz7u17vApgWD3I6DzeyRxBf0mODfdiGsPZkjsUjst2iWb5JP+SDEkM8AboH0aEH51Vvwi3+TAVvAZI23t/9o9jno4HAkZOLC3kT4HKtAxklwAA11FUpMBBwgo7Sz8XRVKgnwYq/iBLvaqK/xWebdjnKB9cmqaWOpQ9YEPB55A/kucPXdvvQjea8aC6lVkz4fOgyo6l7oFx8ZliGvQoaZCBdcTASvb2zxLz/qkLLsuBW39xu0FfDWrFqjhJuPb68+Wf1Tm5nnIq2L0H+V73fXNE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6773.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(7416014)(6133799003)(22082099003)(18002099003)(10067099003)(38070700021)(11063799006)(261009223027099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VjVoY2hSQ2hRZk9UdHZXeE5XYzZINUpzbVBwSzRlSkpxMzYwZDZTeDB4Q3Uv?=
 =?utf-8?B?eGZoS2MxYmZ4MUJpVURmVnFYeXY5SGxneGE2dGJLcUR4MkN5NFh5Vjk0emFm?=
 =?utf-8?B?ZGxtT1ZWYkZENzc1eHNoSHFaaGlUMDV1TGNYR0ZTenUwWjFDUGNkaHhMNkNP?=
 =?utf-8?B?U0JHbzFzQWpoeFZKeUU2TzF6K1cwd2N3MEhuVllTdTJ5dG1nY2tobU1lMjZp?=
 =?utf-8?B?azZGRGRYSmc1NjM5MWxNZjRWR0d6c1V4cVhTL3lRREQ0bmRtQXFRckJ0OFFa?=
 =?utf-8?B?ZzNKa1VNcnR6dVpkQWJJVEszWmxJK3VReWdnVmJqaUlvZ1BQU0xRUzgxS3lD?=
 =?utf-8?B?RXBLanhGUVZmeU1xVTNaYkdTcEJzODlqUzkvUEExZGhJTU5FNVcvcEduTGlk?=
 =?utf-8?B?YzR2U0Y1RjF3QmlzSllrVWh6UUNkSVZHR1NZeDZ1ekNkZ2ErRmN2aU1paSsz?=
 =?utf-8?B?QVYvL0FRUTlWZ2c2TFQ0QXVUTkthZFdWNjBmb2tacy9vdUpsSzRKZkFWeG1r?=
 =?utf-8?B?OTc2ZzU1d3pyMUtYaXZESTNqWmVnNk9OcnBwVTU3QlZiTFhvTGNmRHM0T3Bp?=
 =?utf-8?B?QzN0ZUNZOWhzWDJ2dlVrTCtkM0hCN3lHbks0cnZQbFNYd0sydlYzamlXZDdE?=
 =?utf-8?B?M2hLR0hxSExCeHJ6Sm5MMVFESzZTeDZzelFOZm8vRkxJL3pvMFBic0pEbDhQ?=
 =?utf-8?B?UUo3ZUJYZ09kaWJWVWNmY3JyQVJ0bVA3ZEUwcFZ1R3MvMVUzL0Iwc1hHOTB2?=
 =?utf-8?B?bnNtbW4zclFhQ2NsUk1vek1MR1hoN2NwSWt6OXlsTkgxb3lqTGowTTg3cWJn?=
 =?utf-8?B?K2VSM2o2dW9qSUlScUN0UUwxUkZOL3JnVm1uRWw2MnJMNXB5a3h5VHE3NUpv?=
 =?utf-8?B?ZzdZQ3cxVXV4OUNXaU1HNjlUWE1KT1cxekd4MGg3MUpGbjFGWU83ZUc5TWpI?=
 =?utf-8?B?OHZhVk45Wk5Xd201LzVwVExGdVFRZnBZaDVJSjhNNmJBTGlOV2ovQ1BUeWRD?=
 =?utf-8?B?MmtZbnNGNTgwdjlrOUNWZ1ZSWThtQ1Z5WHk4YkJMa0lyN1RJOG1Ha3BZdDlH?=
 =?utf-8?B?NUxFMml4NmR2Mlg3ZGJGR201bGdWZW51eHNDWFd3UHg2YkNERE1nRVVCcStF?=
 =?utf-8?B?ek5mMU1zVGMwTk80blVzUGZCdG4xb09Rcyt6NDlwVkh5M0g1YVBFdk9FNFZM?=
 =?utf-8?B?anVhdUNCTDBySWVUUFFudDJKTEhnM0ZkeTNkLzRBYmRWRU9VOXFMU0JuMUUx?=
 =?utf-8?B?dmhiMytDR2phQ3NhN0lWVkZSYS9nS0poeGp3cytCUXBvSGdtQmlSeGhKRitt?=
 =?utf-8?B?L2c3SzJDM0t0cFlDbG1MU3R3OVlzM3QyRXViS25Xak0vbzhjbHMzU290MnRz?=
 =?utf-8?B?TkFBb1BZWUk1VVpSQndFMHhXZkJSNStsMEp6bVdwSldYcGpWYXdwWWJKUjRo?=
 =?utf-8?B?Z29INDRFNWlkUmFiRlZoaWJsdkpwMUcwY3V2cWNKMWhZdjNtbXljM1NtRUc4?=
 =?utf-8?B?OFhCeHlqV0xjVzNZdFA5QmlxQUgvTU5FaS9VcFJITitPaGFxcUd3NHo2alMx?=
 =?utf-8?B?M3dMcVFnTUYrcUdJUStTOUpjMWkzekUycXdzamgwOVl4RGVWdVRESzJjQlZK?=
 =?utf-8?B?VkxpVmhqQitPMWFIS25ZSkRGelNKVFhxWjc0Sy9wSjY3YXhKbm9ISHVHZ2h0?=
 =?utf-8?B?SDN5T0pDNGhRQWpPTGhIeVNBVEVwS01hc0dFK2hLaUlnUTRaUHZXbFpURG0w?=
 =?utf-8?B?czZma3NCMlBvcWFQaUZmYWJ0N2dUaFlPcktwNTFrNi9URjNudmREVWJ5enRK?=
 =?utf-8?B?UEZDSG5OL3FmMHIvMEtVLzEySUdNTzRieGZ1ZGQzL29PSFZKd3NGeTVpSSsy?=
 =?utf-8?B?d0ZXZEpaK25pV1BaTDdYTmRoajVjY2lRanN1M3Nib3IzSFJjVzRobmw3Zjdi?=
 =?utf-8?B?M2g3a3d0dU40Qlh3bFdTTWZ3NExNYktjYW5Iaml2UGNiSTRVL2MxUjA1NEl4?=
 =?utf-8?B?MEhtTnNFNWNpN1pFNWlZVFlzVWVQVHFpc3EzV3pJVnZEODVIUXpKbXlNUXgx?=
 =?utf-8?B?UTNDM3NraVozZlp3M0QvbHlmT3I1OGxVdVl3dzh3Z0lPeWg0SnZSbTQ2azFq?=
 =?utf-8?B?NXBYcHNUSXFWWEo3Qk5LZy9uczE5cXo4R1V4ZEZOZE4yLzhnbXMvWWY3RUxS?=
 =?utf-8?B?dHNuY21Ja2NOLzNKN2oyWjc0YURLOTF3YWgxTjFaZFM0MnQ2OURydWlURnlQ?=
 =?utf-8?B?RWdNQWMwUURFd2thRlFzdXBQQlZOUTZISlVJL0tNVVhjUjJEMEM0c3JQZVE1?=
 =?utf-8?Q?zmQMY7oTNdNlqEZUZd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6773.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8d351f-f081-4f44-cd35-08df2ef79333
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 22:14:57.0857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pUxz6bFnQ7x3sChSHSFjQHvGGV1LOOGnyPFrqS5ME5qoqD+WoIubEr7bXpyS2Ks+tgoOBbAxf44e06d+eZQEUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9725

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSWFuIFJvZ2VycyA8aXJv
Z2Vyc0Bnb29nbGUuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDIwLCAyMDI2IDg6MzMg
UE0NCj4gVG86IEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbyA8YWNtZUBrZXJuZWwub3JnPg0KPiBD
YzogSmFtZXMgQ2xhcmsgPGphbWVzLmNsYXJrQGxpbmFyby5vcmc+OyBCZXNhciBXaWNha3Nvbm8N
Cj4gPGJ3aWNha3Nvbm9AbnZpZGlhLmNvbT47IG5hbWh5dW5nQGtlcm5lbC5vcmc7IGxpbnV4LQ0K
PiB0ZWdyYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsgbGludXgtcGVyZi0NCj4gdXNlcnNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBWaWtyYW0gU2V0aGkNCj4gPHZzZXRoaUBudmlkaWEuY29tPjsgUmlj
aCBXaWxleSA8cndpbGV5QG52aWRpYS5jb20+OyBTZWFuIEtlbGxleQ0KPiA8c2tlbGxleUBudmlk
aWEuY29tPjsgTWF0dCBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsgUmFqIEpvc2hpDQo+IDxyYWpq
b3NoaUBudmlkaWEuY29tPjsgVGhpZXJyeSBSZWRpbmcgPHRyZWRpbmdAbnZpZGlhLmNvbT47IEpv
biBIdW50ZXINCj4gPGpvbmF0aGFuaEBudmlkaWEuY29tPjsgam9obi5nYXJyeUBsaW51eC5kZXY7
IHdpbGxAa2VybmVsLm9yZzsNCj4gbWlrZS5sZWFjaEBhcm0uY29tOyBsZW8ueWFuQGxpbnV4LmRl
djsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+IGFsZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRl
bC5jb207IGpvbHNhQGtlcm5lbC5vcmc7DQo+IGFkcmlhbi5odW50ZXJAaW50ZWwuY29tOyBjdHNo
YW9AZ29vZ2xlLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAvNl0gcGVyZiBqZXZlbnRzOiBB
ZGQgTlZJRElBIFRlZ3JhNDEwIHVuY29yZSBQTVUNCj4gZXZlbnRzIGFuZCBtZXRyaWNzDQo+IA0K
PiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50
cw0KPiANCj4gDQo+IE9uIFR1ZSwgT2N0IDIwLCAyMDI2IGF0IDEyOjE14oCvUE0gQXJuYWxkbyBD
YXJ2YWxobyBkZSBNZWxvDQo+IDxhY21lQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gT24g
TW9uLCBPY3QgMTksIDIwMjYgYXQgMDY6MjM6MTZQTSArMDEwMCwgSmFtZXMgQ2xhcmsgd3JvdGU6
DQo+ID4gPiBPbiAxOS8xMC8yMDI2IDE3OjQyLCBCZXNhciBXaWNha3Nvbm8gd3JvdGU6DQo+ID4g
PiA+IEFkZCBldmVudCBhbGlhc2VzIGFuZCBkZXJpdmVkIG1ldHJpY3MgZm9yIHRoZSBOVklESUEg
VGVncmE0MTAgdW5jb3JlDQo+ID4gPiA+IFBNVXMuDQo+ID4NCj4gPiA+IFJldmlld2VkLWJ5OiBK
YW1lcyBDbGFyayA8amFtZXMuY2xhcmtAbGluYXJvLm9yZz4NCj4gPg0KPiA+IFRoYW5rcywgYXBw
bGllZCB0byBwZXJmLXRvb2xzLW5leHQsIGZvciB2Ny40Lg0KPiANCj4gSGkgQXJuYWxkbywNCj4g
DQo+IGNhbiB3ZSBub3QgdGFrZSB0aGVzZSBpbiB2Ny40IGFzIHRoZXJlIGlzIHVuYWRkcmVzc2Vk
IGZlZWRiYWNrOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1wZXJmLXVzZXJzL0NB
UC0NCj4gNT1mV3VjdmRZZWZET0wzVm49Tz1ZVVBFWEUrdG5nRERmUEx2LQ0KPiBUNWkzV2tDSlZB
QG1haWwuZ21haWwuY29tLw0KPiANCj4gVGhlIHNwZWNpZmljIHByb2JsZW0gaXMgdGhhdCB0aGUg
TlZpZGlhIFBNVXMgaGF2ZSBhZG9wdGVkIGEgY29udmVudGlvbg0KPiBub3Qgc3VwcG9ydGVkIGJ5
IHRoZSBwZXJmIHRvb2wgb2YgJ3BtdV9uYW1lXzxzb2NrZXQ+X3JjXzxudW0+Jy4gcmMNCj4gc3Rh
bmRzIGZvciByb290IGNvbXBsZXguIFdoYXQgZW5kcyB1cCBoYXBwZW5pbmcgaXMgdGhhdCBhZ2dy
ZWdhdGlvbiBpcw0KPiBicm9rZW4gYXMgdGhlIGpzb24gaXMgY2xhaW1pbmcgdGhhdCBwbXVfbmFt
ZSBpcyB0aGUgUE1VJ3MgbmFtZSB3aGlsZQ0KPiB0aGUgc3VmZml4IHBlcmZfcG11cyBjb2RlIHRo
aW5rcyBwbXVfbmFtZV88c29ja2V0Pl9yYyBpcyB0aGUgcG11IG5hbWUuDQo+IFRoZXkndmUgd3Jh
bmdsZWQgc3VwcG9ydCB2aWEgdGhlIGpzb24gYnkgY2xhaW1pbmcgdGhlc2UgYXJlIHN5cw0KPiBl
dmVudHMuDQo+IA0KPiBXZSBjYW4gZWl0aGVyOg0KPiAxKSBzdXBwb3J0IGEgbmV3IHN1ZmZpeCBj
b252ZW50aW9uIG9mIDxudW0+X3JjXzxudW0+DQo+IDIpIHB1c2ggYmFjayBhbmQgYXNrIHRoZSBk
cml2ZXIgd3JpdGVycyB0byBuYW1lIHRoZWlyIFBNVSBjb3JyZWN0bHkgYXMNCj4gZGVmaW5lZCBp
biB0aGUgQUJJOg0KPiBodHRwczovL3dlYi5naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUNCj4gL0RvY3VtZW50YXRpb24vQUJJL3Rl
c3Rpbmcvc3lzZnMtYnVzLWV2ZW50X3NvdXJjZS1kZXZpY2VzDQo+IA0KPiBJZiB3ZSBkbyAoMSkg
dGhlbiBpdCB3b3VsZCBiZSBuaWNlIGlmIHRoZSBzdXBwb3J0IGZvciB0aGF0IGNvdWxkIGJlDQo+
IGNvbnRhaW5lZCBpbiB0aGlzIHBhdGNoIHNlcmllcy4gSW4gYW55IGNhc2UgdGhlc2UgZXZlbnRz
IGRvbid0IGJlbG9uZw0KPiBpbiBzeXMuDQoNCkhpIElhbiwNCg0KQ291bGQgeW91IGVsYWJvcmF0
ZSBtb3JlIG9uIHdoeSB0aGVzZSB1bmNvcmUgZXZlbnRzIGRvbid0IGJlbG9uZyBpbiBzeXMNCmRp
cmVjdG9yeT8gSXMgaXQgYmVjYXVzZSBUNDEwIGFscmVhZHkgaGFzIGFuIGVudHJ5IGluIG1hcGZp
bGUuY3N2Pw0KDQpJIHB1dCB0aGVtIGluIHN5cyBzbyBwZXJmIG1hdGNoZXMgdGhlbSB0byB0aGUg
UE1VIGJ5IGl0cyBpZGVudGlmaWVyICgiQ29tcGF0IikNCnJhdGhlciB0aGFuIGJ5IHRoZSBDUFUs
IHNpbWlsYXIgdG8gaGlzaWxpY29uL2hpcDA5L3N5cyBhbmQgdGhlYWQveWl0aWFuNzEwL3N5cy4N
Cg0KRm9yIHRoZSBhZ2dyZWdhdGlvbiBjb25jZXJuLCBJIHJlcGxpZWQgb24gUEFUQ0ggNC82IGFu
ZCB3aWxsIGxvb2sgaW50bw0KaXQgZnVydGhlci4NCg0KVGhhbmtzLA0KQmVzYXINCg0KPiANCj4g
VGhhbmtzLA0KPiBJYW4NCj4gDQo+ID4gLSBBcm5hbGRvDQo=
