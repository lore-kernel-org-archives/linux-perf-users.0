Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656DB35DA7F;
	Thu,  2 Apr 2026 09:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775120862; cv=fail; b=bB1M9ExAj8S9XiEX5+eaeEKNyXcrwsBbSe6ZrZst8i2XaE/tRtmylEHnYhvFl2qTgI8nhXiwMrd1JkIJCxX6qJeVjzAO0xCWpHBBuwIIFyvxWR7sWrr5O4p2rGP8EiNiljKC4JCQVe4zFnIWvL9SQcjY+hm9Pkwd2U4Je1XO96c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775120862; c=relaxed/simple;
	bh=ririXAjMuLZ1gKDqomkpBPkZnS+EHrnsai7MFAsCx9U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TKy2e4wWPyxYnfRs+QTHE67nXps2RrpshVEuxujd3cRvBC3LdCdOB6eJzRNsAJkrb/kEACDlnRJZ8owgmw6RXk8+qe3qvJ6v3Sq+d32QH7iXTgO8rF+U1dU4a8Uho94m82KE4ZDlII1zC4ZclYtIN+PovZBRhqlK0XbqId6lYjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=htsg/LdG; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="htsg/LdG"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631Nh9gq1820650;
	Thu, 2 Apr 2026 02:07:20 -0700
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11022085.outbound.protection.outlook.com [40.107.200.85])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4d9d9gs02s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 02:07:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DGTp953EqS4GYkw4+XP3WoebB+pYz98eGoY6DrM84hZ3FVtxPmw5qeSiPPP4U350pEsMdrXYJJzaP08ggN8ttknAZo7iwQP8EdDwywqWvm7vEqANjorchsEStsbwEhiew5LWqdM7O9L4VwXi0kjewngX3CldLJ5L0sh478SsK9faTbGxSZR5q90nIkmefpJLp2n9gysX1QfOy2S4nXCJZ11D6fn/nHTSeDuhvMvWqluIBVmIfbds3ljK5jD7xxnFCwQ73IrdKeEAxyPzXLi45WfF3j5qEbzFCnVIHpci1hmklffIpSdQTrulYh6e4I8gtsuCV+ynPJesJq1glTwAnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ririXAjMuLZ1gKDqomkpBPkZnS+EHrnsai7MFAsCx9U=;
 b=P+Nzzk+N/KI/Pdle9bZOtAFjIMN0vKbVO2Rv/2ys/yXzCdJz8Jfzhg54RQXvAwIEi+QEAAkoQIhxnsbIBCPVhD2mhN0xi4nzWkd16bUdQVBM5GszB05Amnojv7L/kuqeWQdhoSoJiKPavB7HRMSUWWQmBQpGKx2uXUBl2S1rb5r719BaHkHpLG4nw29Tvh119DdHhH4/9GdSsCiElD4w3Blc+eGlE6UnLyOS6codPjKHcvwSLoEInCmapY94xuirp/e67t8DkgsJHaOocLSAL6dWfpspyYCZVeEakWLmjcJOgggFWDdVKIbLPcrrbcv6T6TSNCsnkYm7E+OLQL+T6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ririXAjMuLZ1gKDqomkpBPkZnS+EHrnsai7MFAsCx9U=;
 b=htsg/LdG3n3Q2KHX2GECuTil81WUS31gzIJQ5MCLMCBuhDr8+dw1YDR2XYyqJ9A3oEO/6uthNcZ1o2M2yx+oETMZpWvCB5UgZVg1Ggly7LYT7VT0+YH2RlUauC2hFkoMjm+15A6k8CTU/XRdfcEvTfO6e/zSoOzGV4OeE90aNzY=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by CO1PR18MB4810.namprd18.prod.outlook.com (2603:10b6:303:ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 09:07:16 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::210a:9dad:297f:3540]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::210a:9dad:297f:3540%7]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 09:07:16 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v3 1/2] dt-bindings: perf: marvell:
 Document CN20K DDR PMU
Thread-Topic: [EXTERNAL] Re: [PATCH v3 1/2] dt-bindings: perf: marvell:
 Document CN20K DDR PMU
Thread-Index: AQHcwnC2TeI+so+BP0ew/R3h+5JuSLXLdppw
Date: Thu, 2 Apr 2026 09:07:16 +0000
Message-ID:
 <CH0PR18MB433991D26A2202C8B7FB256BCD51A@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20260401081640.23740-1-gakula@marvell.com>
 <20260401081640.23740-2-gakula@marvell.com>
 <20260402-invaluable-delicate-clam-7fd6c5@quoll>
In-Reply-To: <20260402-invaluable-delicate-clam-7fd6c5@quoll>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|CO1PR18MB4810:EE_
x-ms-office365-filtering-correlation-id: 0f030d5d-1282-40ad-7b82-08de90973c83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 SAJa/DsIExhb8WuDBm0+baNWvmKvaULz3dPlv1AGrisFQDTUNfDKh3nFEba2nw6SWKHFrgApTuEUGwuLYUhCWYr/X3C6PDbXaX1NX0JKBVdl48SU5iKw3Ec+nYPCN/rjYXWc2sgWIHP8VtE1lhHYwbXEVTiTRUtOQWpl91hYQdy06CThjPvgo5YuWoPt5/umEP3dqoa4bKCXccRIVZ/Is7VnIK+GMTJ1yBp/we3UxLNHNS6yPjGTAjWE4Xt1+z5J/RAikR/90hO8JtZENexiYjyBR4YIm7YmDkd+gJFAe5dhH5El438nQ5YtA9PtoZ1Xf1MY6i31UOZQHdqqPvCsqIpz3Sen3844XMf88cnexCrAOFWMospbutnDrsUy8npfmiO+EZNeBEFiCRtAT04egozWeg4ZKz3Fxnnu4jEsK2J8hLVTfz1yV4VHnlpB/o9mznBmbI57omgG6ZxPnLv7o1MszXH75NlmGQtJH3ryCPuycBHDaI8/09ak1PAROtPl59idgVf/yOWIvlZCm2YhmMDvClFO8UbbJZFnCm3QqWdK/lj0735c8DLVVf0l1jhwryVXPStAIQs/EbXq3gjrK2o26jPXZvBmwyi79Jr5z5B4WZyW/U6PudmFrvwCuJj6CHZZqmLMbj7y4b1S7RD5sCl3S2XRQ93kuejXMR7hnOENVjGXG56uuKJR4Nl4Nh5rNvLqm8ckdCmX8lkc6IFcuWK8rV7S/M9r6ag7WVS2D9lR4v2b0zuZtbXPKM4CeCLk
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VEZCb1FQbTBvblZoeGVUVHQzMjE4NHBoUk1XWFlVOEN5YUJDMjdpZStmTDVp?=
 =?utf-8?B?aGdnTFFaNjVjVzJlV2FrVStld0J6TVNUM2txajZYdUlVZ1BkajJwMkhaaUpZ?=
 =?utf-8?B?bGxEak9ER1lpWmNodFRCSEhNNDJnOHdNNklnYmtTOWJlcVNobmJIQlFkM2xU?=
 =?utf-8?B?TGJEcDMzektvbU10aFpOTGNCTUZGRzZ1Z0tzcE5oc2lzSmUzS1FEQmQxLzdt?=
 =?utf-8?B?UmFENFNPUTZvU1hQSFpYa1dabjMvWHVHdENkd2c2R01FZlVESm8zWkJaUFVH?=
 =?utf-8?B?UGJzV1NGZFdVWGdkZG5xZDJMdWVTZ1NpU2plOFhzb2wzbXFVV1drWTZ0Njg4?=
 =?utf-8?B?QnpjdExyVWNSZElzRTFvN1R2NzlFVUdzeCt5WXVsMVp3U00xa3pMeWxzYlRJ?=
 =?utf-8?B?RVB5aWszVW93N3VtNEpRTzNWaWdqcTcvRTFpc3BlV0doUFZtRVp1T3hRWnZK?=
 =?utf-8?B?a2FGZkxwZDdpdHdQVTRGajUwbHdQKysySjgvQUVKWTlXMkhaQVpnQWFTam9x?=
 =?utf-8?B?YUg3YkJuam1MVGNFc3ZUMmJ2dDBRZk1sMzN4SDYvODVGcXlNYkJibHdvNnYw?=
 =?utf-8?B?RUFKYUMxMzRRR0pKbzB4L01vNm14R3c0V0IwVGRSQVRNa0hBL3Y0ZnBFTU8x?=
 =?utf-8?B?a1NuN0wxQTg1L0I5eThWbWNxbEVzaG9ZdktDTkRrSFNtL0hmcVdXQVIxd1J1?=
 =?utf-8?B?YUJkQ3hPOUNCK1BpMmZldUNvbEJTVWhrak9ibkl2Nzhlb3BSTnJRVmxBakpM?=
 =?utf-8?B?eHdITHYxeXFUV2c5WDZ4dkdXa3gybThHTFVSM3QwZFIxREZ4WElJSXRNY0Zy?=
 =?utf-8?B?dHF1QmlEczVjTElpQUhNM1dOdC9XV2RCQXp1dk5RYTYvelAzYUhlR0xCa2lK?=
 =?utf-8?B?K1VOSnVrRVJXMzRkMmkrb2liTFlZbzFaNkc4cGpmNVNLOCtLSXgvMUtpTk51?=
 =?utf-8?B?THhmeFJRamk4TWtJZllBaFJQUzRNS2d2NU9oVmtlUDlmZndmaVh6c0hiK3Ux?=
 =?utf-8?B?WGRNVjU5cVRiVW1hclVWejEzZUdqUHlyU3FtbEFEazJacEQ2VkN3NzV3UURD?=
 =?utf-8?B?UEdyQVZBQUthUUxSakZQcHFPNndtMitXK0FlTkRsTElza0lLbnk3Y2JGUFpM?=
 =?utf-8?B?Wk5oWitYdytkaDl1eFQ5NDdPZlByeUFPVDliSGIvZWlydlhpMHhQYTdxWnlR?=
 =?utf-8?B?UitTbStXaVZFVkhFM29CTVVHRzBTTlp4SStBMnFDZ2hCaThIUVRaVDNJY3JE?=
 =?utf-8?B?c21meFc3bENRMmJZK2lSa1pYY0t0YW52T1YxM280dFZMblAxWGxObTVUTXA0?=
 =?utf-8?B?VDc4bUFzN3NYanQzNEJkMXpaUmY1eW85QmNBNkcxTHRadjNZczVENFFDcWYz?=
 =?utf-8?B?MGR3elkvVysxMDVxVzE1di9vYVJEbFpLUmFUNlNaTmU3K3pwWDVxWEwzWHhC?=
 =?utf-8?B?cE5uZE8yMlNrZ0hTRzlvb0p3NEY2ZTdjUVlTT29oQ0RqYkN2alZ6SVhWMlRj?=
 =?utf-8?B?KzJxN2RnRjdQb09GZDdjN3dUZkdzM0JSSHJBc24wUnFEOTVCaEpWUkVQUkFx?=
 =?utf-8?B?NjZjSjlZTVhwYkFSMVUzTjAvMUU5dVZuOGJEZnVXWWFxbndMSU1ncE11V1Ez?=
 =?utf-8?B?MG5sb1N2eUhIVHJySWU2elRHK3VqZXQzc0UyQnAxQW5ZdkdaRmdRVlVySlZa?=
 =?utf-8?B?T0VZUHh3NTAraHQzVVZpWSsyNnZyU2J0M1BhcVIza0EyK2s3UjNFWDNFNkpy?=
 =?utf-8?B?UkhvRUE2cVZBdlprVFBBamZnc1cyRjUvaDBlaC9HUTJtRnNJRy8vYXQ0VzVX?=
 =?utf-8?B?YnUraWdTRk05dHh0MDNTOXdnL3ltM2tYb0hxS1hXVWpDT21aZXhXN2NiQVll?=
 =?utf-8?B?b011dnJxYlFyZmV1bjNucUpHRUJjY3ZhL0pSVXk5d1ZMcmloY1p5bXpjVVRv?=
 =?utf-8?B?SkttT3FtcDJRS0R5V1AycS9nODJ1a3RLV2NNWm53QksvWjd1VEE2aU4vajZa?=
 =?utf-8?B?ZkpZY0Z6amV1WWdoZFQyTzJtckJjdnA3Z3huRGgwOVdPa0NvVkFSWWw3bndK?=
 =?utf-8?B?bXhGdnU4R2lBU1NLUGpsUzYrRFN4L1cyYVM1aXJ3cjJGUElEbzdlRDJLa2Zi?=
 =?utf-8?B?blJ1SkxMTXB1Mjg3YXZ5SjZTcDFXTElOQjdFS1hzUmZJeG9NQnE2ZTgxWFZv?=
 =?utf-8?B?ZE1HOXplZWZvUHF1bVV4VXEzTEd0OWZZQ1JSSGtQcUNwN3JPL0MwYXR6R1lq?=
 =?utf-8?B?MkNJNUpReXMyZ2dvR3loNHA2N0xEY3U1dGNJVWF3Z0phVkpVMUZnRDZ0SmVX?=
 =?utf-8?Q?iXbXtf1MVVLtDQfj2I?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	tJ+JzsTq8tNN4KsZRz/yve3sJyfHp+HlYpCitxo1shNsqSR5j8W/+Xv5rOv/98jPohpacLawF2ZxWvBQpo9xgX31jti8NvJIDeBSaKmZ3E8MaiUTIy3LOy35KUJNsUNi1/6+7S89TyzKQJ/XKKDiuMzZcHpbtka2x2vHooXEgZOywmtybriFpbTtWgK3UkUw9p03itgU90d6Ir5NH6UFeWrcLhEHWOy7m8I1SU/jW5+2l5etEGgA1aoQqztGwcfQHuWOVARkXLwsSemGuN6+VyNuWRq/ezbvS6+riB+5d/ZqQkd2w4vBMAx5w+yA0wbba5V0d/hFibEl+t6JbVHoHg==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f030d5d-1282-40ad-7b82-08de90973c83
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 09:07:16.2363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K2rPs0O4DnIbRWokMDV/0QAORiT6CXvONGZ0Ez1gcoXlAVSjKJArRj4jEedUiqvZb/fDmIK1lpMTWan3P2+0nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4810
X-Proofpoint-ORIG-GUID: cXWo3xgOZNDUtEzWD0vOIzo2_9JzMGSu
X-Authority-Analysis: v=2.4 cv=RfGdyltv c=1 sm=1 tr=0 ts=69ce31c7 cx=c_pps
 a=jGG6JRppMrTRDPguzGMrcw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=RpNjiQI2AAAA:8
 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=JfrnYn6hAAAA:8 a=7CQSdrXTAAAA:8
 a=0Q6bZe9f4A76JLk5l1cA:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA4MSBTYWx0ZWRfX3artG7XhfLwV
 URF/t8jZQV0GMWUtjZLMzN9huNjq8gXkzK1kdpAijEHe5FwgtodYUuGi+njePNpAyareYtNDRa+
 trHHcMIS/0Jd2Ia/L3C12WcbqYHLo9aWvuCWyKnbLcstcvIrXL4btQWTU+Btm2c6a2+CIGaA4sg
 IiO/zIwEhrFGsUL/mWps3xFI+gTAGBc5wehH+Cre3yCFCRvo7lCqvSfj3ntk+GAog3bU+Ot/Cby
 gjx7U6jYbNlZhIRfWO3TlST1kiGeEFcTxVKfqkJKE/cgA9D7bDsa48z7kEhEcCTsmqEywAjApaO
 qBzFON5BxJd6O178PFYQWrb4XmhOgDS6qZgKppc3qFzEqnFdSmkixS7OHhqjPE/+j382BFb1Tsx
 l8kD3pWJwzN8lya9Ho3A7UExI8PgL8LXunabh5RxfK6GsPJUP1BvS0Mm9xwTLYQMGDtKeMXq0ab
 QzBNSJ7o6fFzf/yRaBQ==
X-Proofpoint-GUID: cXWo3xgOZNDUtEzWD0vOIzo2_9JzMGSu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyemtAa2VybmVsLm9yZz4NCj5TZW50OiBUaHVyc2RheSwgQXByaWwgMiwgMjAyNiAxMjo0
NyBQTQ0KPlRvOiBHZWV0aGFzb3dqYW55YSBBa3VsYSA8Z2FrdWxhQG1hcnZlbGwuY29tPg0KPkNj
OiBsaW51eC1wZXJmLXVzZXJzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtYXJtLQ0KPmtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZzsNCj5tYXJrLnJ1dGxhbmRAYXJtLmNvbTsgd2lsbEBrZXJuZWwu
b3JnOyBrcnprK2R0QGtlcm5lbC5vcmcNCj5TdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0gg
djMgMS8yXSBkdC1iaW5kaW5nczogcGVyZjogbWFydmVsbDogRG9jdW1lbnQNCj5DTjIwSyBERFIg
UE1VDQo+DQo+T24gV2VkLCBBcHIgMDEsIDIwMjYgYXQgMDE6NDY6MzlQTSArMDUzMCwgR2VldGhh
IHNvd2phbnlhIHdyb3RlOg0KPj4gQWRkIGEgZGV2aWNldHJlZSBiaW5kaW5nIGZvciB0aGUgTWFy
dmVsbCBDTjIwSyBERFIgcGVyZm9ybWFuY2UgbW9uaXRvcg0KPj4gYmxvY2ssIGluY2x1ZGluZyB0
aGUgbWFydmVsbCxjbjIway1kZHItcG11IGNvbXBhdGlibGUgc3RyaW5nIGFuZCB0aGUNCj4+IHJl
cXVpcmVkIE1NSU8gcmVnIHJlZ2lvbi4NCj4NCj5Zb3UganVzdCByZXBlYXRlZCB0aGUgZGlmZi4g
Tm8gbmVlZCwgd2UgY2FuIHJlYWQgdGhlIGRpZmYsIGJ1dCB3aGF0IHdlIGNhbm5vdA0KPnJlYWQg
aXMgdGhlIGhhcmR3YXJlIHlvdSBhcmUgaGVyZSBkZXNjcmliaW5nLg0KPg0KDQpUaGFuayB5b3Ug
Zm9yIHRoZSByZXZpZXcuDQpZb3UgYXJlIGNvcnJlY3Qg4oCUIHRoZSBjb21taXQgbWVzc2FnZSBh
bmQgY292ZXIgbGV0dGVyIGRpZCBub3QgaGFkIHN1ZmZpY2llbnQNCmhhcmR3YXJlIGNvbnRleHQg
YmV5b25kIHdoYXQgaXMgYWxyZWFkeSBwcmVzZW50IGluIHRoZSBkaWZmLg0KQ04yMEsgaXMgdGhl
IHN1Y2Nlc3NvciB0byBDTjEwSywgYW5kIHRoZSBERFIgUE1VIGhhcmR3YXJlIGJsb2NrIGlzIGZ1
bmN0aW9uYWxseQ0KaWRlbnRpY2FsIHRvIHRoZSBDTjEwSyBERFIgUE1VLCB3aXRoIG9ubHkgbWlu
b3IgcmVnaXN0ZXIgb2Zmc2V0IGRpZmZlcmVuY2VzLg0KVGhpcyBzZXJpZXMgZXh0ZW5kcyB0aGUg
ZXhpc3RpbmcgQ04xMEsgZGRyIGRyaXZlciB0byBzdXBwb3J0IENOMjBLIGJ5IGFjY291bnRpbmcg
Zm9yIHRob3NlDQpvZmZzZXQgY2hhbmdlcy4NCkkgd2lsbCB1cGRhdGUgdGhlIGNvbW1pdCBkZXNj
cmlwdGlvbiB0byBjbGVhcmx5IGRvY3VtZW50IHRoZSBERFIgUE1VIGhhcmR3YXJlLA0KaXRzIHJl
bGF0aW9uc2hpcCB0byB0aGUgQ04xMEsgaW1wbGVtZW50YXRpb24uIA0KPj4NCj4+IFNpZ25lZC1v
ZmYtYnk6IEdlZXRoYSBzb3dqYW55YSA8Z2FrdWxhQG1hcnZlbGwuY29tPg0KPj4gLS0tDQo+PiAg
Li4uL2JpbmRpbmdzL3BlcmYvbWFydmVsbC1jbjIway1kZHIueWFtbCAgICAgIHwgMzkgKysrKysr
KysrKysrKysrKysrKw0KPg0KPlNvIHlvdSBkaWQgbm90IHRlc3QgdjEuIFlvdSBkaWQgbm90IHRl
c3QgdjIuDQo+DQo+RGlkIHlvdSBmaW5hbGx5IHRlc3QgdGhpcyBvbmUgYmVmb3JlIHNlbmRpbmc/
DQpZZXMsIHRoaXMgdmVyc2lvbiBoYXMgYmVlbiB2YWxpZGF0ZWQgYnkgcnVubmluZyBtYWtlIGR0
X2JpbmRpbmdfY2hlY2sNCmFuZCBib290LXRlc3RlZCBvbiBhIENOMjBLIHNpbXVsYXRvci4NCj4N
Cj4+ICAxIGZpbGUgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygrKQ0KPj4gIGNyZWF0ZSBtb2RlIDEw
MDY0NA0KPj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BlcmYvbWFydmVsbC1j
bjIway1kZHIueWFtbA0KPj4NCj4+IGRpZmYgLS1naXQNCj4+IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3BlcmYvbWFydmVsbC1jbjIway1kZHIueWFtbA0KPj4gYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGVyZi9tYXJ2ZWxsLWNuMjBrLWRkci55YW1sDQo+
PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi5mYTc1NzAxN2Q2
NmUNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9wZXJmL21hcnZlbGwtY24yMGstZGRyLnlhbWwNCj4+IEBAIC0wLDAgKzEsMzkgQEAN
Cj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNs
YXVzZSkgJVlBTUwgMS4yDQo+PiArLS0tDQo+PiArJGlkOg0KPj4gK2h0dHBzOi8vdXJsZGVmZW5z
ZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwLTNBX19kZXZpY2V0cmVlLm9yZ19zYw0KPj4g
K2hlbWFzX3BlcmZfbWFydmVsbC0yRGNuMjBrLTJEZGRyLnlhbWwtDQo+MjMmZD1Ed0lCYVEmYz1u
S2pXZWMyYjZSMG1PeVBheg0KPj4NCj4rN3h0ZlEmcj1VaUV0X25VZVlGY3R1N0pWTFhWbFhEaFRt
cV9FQWZvb2FaRVlJbmZHdUVRJm09RE1QUk1iY3NhDQo+Q1FEcU92DQo+PiArSHgxZi1PcWxzLQ0K
Plg3WnFoSThXOXdGZWw3NXJoNzljMlowU0o5MzZnTXhUNHFhTWlBNSZzPWZMQVlCT1RkNjRjVzRj
cDBlDQo+PiArYi13eFpJNnZnWTQ5UjJFOE03RVVvQ2s4eTQmZT0NCj4+ICskc2NoZW1hOg0KPj4g
K2h0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwLTNBX19kZXZp
Y2V0cmVlLm9yZ19tZQ0KPj4gK3RhLTJEc2NoZW1hc19jb3JlLnlhbWwtDQo+MjMmZD1Ed0lCYVEm
Yz1uS2pXZWMyYjZSMG1PeVBhejd4dGZRJnI9VWlFdF9uVQ0KPj4gK2VZRmN0dTdKVkxYVmxYRGhU
bXFfRUFmb29hWkVZSW5mR3VFUSZtPURNUFJNYmNzYUNRRHFPdkh4MWYtDQo+T3Fscy1YN1pxaA0K
Pj4gK0k4Vzl3RmVsNzVyaDc5YzJaMFNKOTM2Z014VDRxYU1pQTUmcz1WZUdncTIzTC0NCj5BYkZw
RnhWNGUxNXdnVXZuMHlFYlVEUA0KPj4gK3hEek5hLTFjSjk0JmU9DQo+PiArDQo+PiArdGl0bGU6
IE1hcnZlbGwgQ04yMEsgRERSIHBlcmZvcm1hbmNlIG1vbml0b3INCj4+ICsNCj4+ICtkZXNjcmlw
dGlvbjoNCj4+ICsgIFBlcmZvcm1hbmNlIE1vbml0b3JpbmcgVW5pdCAoUE1VKSBmb3IgdGhlIERE
UiBjb250cm9sbGVyDQo+PiArICBpbiBNYXJ2ZWxsIENOMjBLIFNvQ3MuDQo+PiArDQo+PiArbWFp
bnRhaW5lcnM6DQo+PiArICAtIEdlZXRoYSBzb3dqYW55YSA8Z2FrdWxhQG1hcnZlbGwuY29tPg0K
Pj4gKw0KPj4gK3Byb3BlcnRpZXM6DQo+PiArICBjb21wYXRpYmxlOg0KPj4gKyAgICBjb25zdDog
bWFydmVsbCxjbjIway1kZHItcG11DQo+DQo+VGhlcmUgaXMgbm8gc3VjaCB0aGluZyBhcyBtYXJ2
ZWxsLGNuMjBrIGluIHVwc3RyZWFtLiBXaGF0J3MgdGhhdD8NCj4NCkNOMjBLIGlzIHRoZSBzdWNj
ZXNzb3IgdG8gQ04xMEsgLiBXaWxsIGFsc28gcmXigJFjaGVjayBDTjIwSyBuYW1pbmcgDQphZ2Fp
bnN0IGV4aXN0aW5nIHVwc3RyZWFtIE1hcnZlbGwgU29DIGNvbXBhdGlibGVzLg0KPkJlc3QgcmVn
YXJkcywNCj5Lcnp5c3p0b2YNCg0KVGhhbmtzLA0KR2VldGhhLg0K
