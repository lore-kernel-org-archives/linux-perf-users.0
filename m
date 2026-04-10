Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F1D86329;
	Fri, 10 Apr 2026 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775813338; cv=fail; b=Sdyt+IAkB2WKD82kfh3XCUnEkwL6nWGjGEgZ66g+48kYX215E+KIGktpim2x9Z8q/JLscHVfC04hY7C1qxc2aihDVIc6Hlu1sjFmklO41BAp61B6hOscwErnS19vf7IPp6M1Ma1Y1COqzfrjMWYsp8na40CKaDQnEEL0GaHxM/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775813338; c=relaxed/simple;
	bh=bW+f9bB+tu5WszX/spPZpZ+9lJhl5R+gqKQb4bnOLHs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FIgf2UXd6qpiGf18ZkuiJkLdlSNxBirF9xOGnbBMv1nieR1ZHvreaIDPom6G9vlbx/w3ikLc4gZMcn/0Dgr4X7GBe7zfK0O7n6Cua0qL1vbSYX3dLc7IoGq3Hi/0xNC2yUzD3wxEmpIeUAaRJZ8bTAWOFYHSJe2/7LQ7sWfqJsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=K6I0Q76L; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="K6I0Q76L"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639MjGNH1093345;
	Fri, 10 Apr 2026 02:28:37 -0700
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11020077.outbound.protection.outlook.com [52.101.85.77])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ddrw2dbda-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 02:28:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYYDV3aUQKgYM9fubBGzCntxCGPmcJY69JXCcZclRq1UwUHj0urmYY/a3At1mG0B35B7dT9GsP67lEhRpvDPsFKX4SMR2Qrkw1P+5S1e9cF2WZhsXOoSgux+VtSEtm+CTaXxTF362oGd3ed8wsSS6NSIR6tF0DoW54Xd51FvXJfmaVWvhvoEqzBE/npluYJpdWAJuociUDLOfJ8/ug8Z4+RFYTG9LTGnSIzwbn+Chgdhhp/fe+pLIIPY3cjcaTmaJqty17U/K0EPTWSQ441Y08kgzyO1QsyRDQPDla5275mLJWs1pQKFqgEFoMSUIKFv2ptdKcXjEzDyUSC7akx85A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bW+f9bB+tu5WszX/spPZpZ+9lJhl5R+gqKQb4bnOLHs=;
 b=v3w+KJGPLnZrbDfmVLgvVFOJZ3pLWeDf/itXqY0+TYmiEEtVeDzWj9JixfotpnXgIGZMJ9h6af/paRw3NeMGMLFk35o9xJXOmPKbxbKGl9OZi2qededQeNsaTH5I9lBXNnUkRHdi1Fp1g42tcM3RgiHYZDyx+lzeHjCfMFa3HQeyl48dlufRLV0LzAe1bulc4tl4xYfN7j2hCr/R6hy/RLUegW8D3Hjyy7LF2IzYcYeruTNDdugWvwQDopEDnrGQyTIkz3xnvy94oJTXp6F8IAAA9IqSaYeyrftOg/TdwocR7aHIzUf6pPHEyvSpdti4hhYLVBD4eOalU4YlxicKrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bW+f9bB+tu5WszX/spPZpZ+9lJhl5R+gqKQb4bnOLHs=;
 b=K6I0Q76LRpcrcps/d2JDpESzSkgfUnW4Z/5jD/L2YEInzqtjqn3LDFPAi5YFMKCkvgXwrP8svYw+EQV3D6Y7HE+juQeiTfQrfbN/g/b+rhhndVu86sbsCxbOUaxzF2+K1VQpGEdQSZGDUgUxhyOZ+jilvpKoQHG0ZOIRNaAjlRs=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by SA1PR18MB6033.namprd18.prod.outlook.com (2603:10b6:806:3e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 09:28:33 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::210a:9dad:297f:3540]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::210a:9dad:297f:3540%7]) with mapi id 15.20.9769.041; Fri, 10 Apr 2026
 09:28:33 +0000
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
Subject: Re: [PATCH v4 1/2] dt-bindings: perf: marvell: Add CN20K DDR PMU
 binding
Thread-Topic: [PATCH v4 1/2] dt-bindings: perf: marvell: Add CN20K DDR PMU
 binding
Thread-Index: AQHcyMxm0gXDCi+WgEGK3sh8uRmT1A==
Date: Fri, 10 Apr 2026 09:28:33 +0000
Message-ID:
 <CH0PR18MB4339E31E535199AB9811E43DCD592@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20260407153511.4250-1-gakula@marvell.com>
 <20260407153511.4250-2-gakula@marvell.com>
 <20260408-fancy-slick-locust-ff68fe@quoll>
In-Reply-To: <20260408-fancy-slick-locust-ff68fe@quoll>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|SA1PR18MB6033:EE_
x-ms-office365-filtering-correlation-id: f154ba52-79d2-410a-2db9-08de96e388ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 QUKncOxoUawkc94mOD0RnTTwrvK5mL89X3xIG+nF6KTR/gMgzxuJxZU1WyGYpZoHYoDMKqDUmR8PSAVCyA+9yWHE7Og13XtopoaYjBdeQ6vZvtY3AA7xaOuUyT3knGO35IH62pIOa2LnSyd0ij4skNb7QuqgnGv7HcTALtMEXFyKJbVQdZPgf0zcuyi1YAfhM0zDsDZKH7EfJCpoil/q+/LTgsPEJ4wIRfabJKv31lJiCIN7QsYyINqMmUDuy6fdfRDSPbqMFbqVifVuHUN3IWQe+fajTxUpGlBNGY7inQ+Ll2ZxacYreK4yu/k79vM87cJ3fxX49lbN26XNm1Z10+QRCjZ5OCZTfl2MCVgGYHL+BR2lruUhtIYba+8eID7sufRl6EER+gQT4TQiIk3eFJPq8PQ2M1NTUWUHK0r4v8KTi59H2jx2JqhXlBz7eUHlkOb8YZUxA4kZDnJTZZUGoE7Hra6JDxc+5jeZoBHN8yYGxMmRBYZMj9KdvEFSUpZ6QffiQjwEwztTiE9IO5KlZQP42ldGwSGDctvZXt9fFNjZ7egmA61YyNJ4Ef9q8MP+XZ7yqvQ4llhD/QXcj8XG74XIo5mVRpHh94d7gDVvZOSA9wyawmhBiHmcy9z6An9GDuwK2TgTkwujWG3Mow+qjEg9XzRul7BYScTO9HOVag6RzKYlCyoHBF1ZFr3Ee+f73mndaO6US6HNG9PLmkPutpTbl22+rlDB3CCveSugmUi4WZARsuzq+Pz8dB2yvZBn2k2Qc4ztK9HAGU63h6YfBMLXQuzZ6c5KpYHrqRXrK6M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YVNUdEU0ZXZKNkphUmQ5d0NZTS9rekxvaklsVWhlQ1NFNFhjRTNqdmtZUmNG?=
 =?utf-8?B?S1VERUdnYWNKbjFXKytyL1Byb294bEF2VzFCL1RkaUFvWDVBTTduQ0Vxengz?=
 =?utf-8?B?cG5vVWY1Z0lBYjEvNVlReTZ5R2pCSFNXN3QwS2pLZmJwSk9HRkd3RFJ6Mkgz?=
 =?utf-8?B?VE93dU9JT1c1bm1sQVEwTXE2NHFOZ05XZWRkamFwaVJuWHRHQWtoSHAxQWY0?=
 =?utf-8?B?bXl6eTNWZnpNK1ZvemtlbzgrcmpyUVJnK3lVeldkZ1QwN1hVZSswUjc0ZjZk?=
 =?utf-8?B?R0JvUXZRbGVzSWxaYTROTGUxVGtzMnVSMFN1Q0d2Q3NjN1lIZ1hMa3pIbWdE?=
 =?utf-8?B?dU5sSVR3NEM1dlYxRERXOThsbklNOVUzMGQzUHdNUXpQak9nak8wK1R2UERi?=
 =?utf-8?B?MjlvbmlKK0lsQTRRdHdIcWlCT0svTTVHTGJ5ektsdVZHbXBzeTFLMGhDQ0NN?=
 =?utf-8?B?TDJFNTBLQ2V6YzJNanRjQUd0Mk14bEdmSkRnUENURmhtMmFvbWZIbXh5RjlV?=
 =?utf-8?B?K0M3OENBUkVnTWpIaWpTa0VLTnh1amRRbno3MUQ2TUNUUm8rK0w3aVhiQjd2?=
 =?utf-8?B?eFNCYlRxMlJ0dFVxSE02YVhaUnk3NVYrd3VNb0RoZXJ6ZmJ6c1lCWHJXVkVi?=
 =?utf-8?B?OWM0TDRMQTloMWQ1T1cwRU5mcUdhNndwRitMaThtUnJjazh5cUN3d2ZUYldZ?=
 =?utf-8?B?SjFKTWpDS05id2ZlbG9TOGtXcjZpaHlpM081ZU8yaExEdlRpZ1dyRTlWbHV4?=
 =?utf-8?B?anJ6L3Uwa2hWOEZ2Q2JoUjMxdHl3ak5pOWU3b0F6K1Zya1Y5aDZhczdsc3pK?=
 =?utf-8?B?UlBrcmFQZkcxNXluczcrUFAvNVNkMnJKNzIyeFJZR1F6UlUrbmJkcGFORzZq?=
 =?utf-8?B?QzlhVTllR2tkcWtRVElicHkvYlVOdkZZc2wrWTZ1djhDZVl6NVFGaUFiV2dO?=
 =?utf-8?B?Vy82aFFwQ1NvOGRJc3diYlpHWWhmc2xnOUNmQmZ3d1pjeENqRlBNSGpSaUdl?=
 =?utf-8?B?a2ZSRkNnTW5La0lnMXN3M015V1RtcEw1MklMSjFYWGRDUnJTcDJ5NGJQY3o5?=
 =?utf-8?B?RXRMa1EyRVpYYnF4dVZNQjBlY29yTXpSVkwvbDJ0Nk5QcnBDRkVLampBbnFn?=
 =?utf-8?B?T1RzRlBkcS9MZytDQTVhbGRwS3J6V1FkVUtobkt1bWdac2xTRyt5Ui9xV3ly?=
 =?utf-8?B?UFRjWE9nTkxycW4wMmlkWVZoWGlwL1VDRDdhWGtnL1U3M2VzT2p5OU5YaXE0?=
 =?utf-8?B?cUhyQytCaU11WndFRHhDYmRoeDd5SDV3WlpyNmdYaHZqOTdCUlpNbGg5WEc2?=
 =?utf-8?B?dmFlTFhMaDRQcXY3QTYxeE10SXZERVhZZHBta1p6RDBZSGY0UW8yREpSdG9o?=
 =?utf-8?B?WTVtMkRDRzdRRDcyU3VHaU55T3c4a3JDcHROc3Fvb0grSEM5K1h3Wm9aOTBx?=
 =?utf-8?B?eDM1SFdseVRzT05XZStPVFZxQWxUdXZqUVZrRVVCK28wVjQzWmxnV3J2ell1?=
 =?utf-8?B?MzA3bGNtTnRmdGlYS2szN1dGN3FsdzJNd0Y4M2ZnTkJKbVFVQ2dFcEZld0JR?=
 =?utf-8?B?WXIzaklXOUJmZzJSay9wN0huRnM5ZUlJSDg1dDdteVAyTm1seDNlRE5pWmxC?=
 =?utf-8?B?b1c5VzZMdWVmNEhRYlNQbUdPNzVSQ0FQMnJBMjdYUFNSOXkyd05NZEhzZFNE?=
 =?utf-8?B?MVY1SHZIKzI0K0N3aDJIVm4zOCs1cXVhV0taN2hROE1KTkdmN0VWNVBKWmls?=
 =?utf-8?B?akR1WUdBVW5ieUUzL3o4bFBPZTI1YkYwZVdTb2NKeU5Bc0xnZEpsK1J4NnYw?=
 =?utf-8?B?TEF0UzNDNG81WlpSc0pZRlZzNXQ5b003YUd3Vk9oWlpZYjlpaGp4Z21LS016?=
 =?utf-8?B?OEpyNHErdDZZeVdVTjBmR1pZSlRkVTlSTmo2V0EwSnM5dmh2SWh0cEI3MnRk?=
 =?utf-8?B?OGZlY3gwTmU1MW15RnB1ajJ4Zy9BcnZpY0x6M0hJTUR6RzJpRFpDOVoxY3FD?=
 =?utf-8?B?RnlUSEU5U3F6ZGMyYmNnMG8rOUMyVHFOTGJNTDdvNnFqT0lDRjJTZkdDOEZK?=
 =?utf-8?B?a2QwTGhLK2dDSzBLem5UUUxrTUs4MTZkZVI4aDRidFc0ZEpqbldaUFhwcjBQ?=
 =?utf-8?B?N3h4bEpDZUR3eHZvUWNsZUZqeGNBdGhya2UzelgyeWpaMlBmWVRwdmM0bTFq?=
 =?utf-8?B?Q1VGMkpqRmJuWUpwTFY2dnlvdUt6Ui9NcUNKZ0NFUVZ1WHFEU1ZnbzZ1dTVM?=
 =?utf-8?B?ZjZrMjdRbHZOMFBCdjJNTEZaUWFQZit2MGR1ellpWWtLazNDaFA0ZDc3Z2dx?=
 =?utf-8?Q?0tbrlG0MQ4nXzk1LJ/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	bySrNxzyZL2jPg13YbgHLGkxofF33dHtNXl72IMGMxrltAL9PG5YIc9PH1oxWsVXlXgc/XsfX0RZ/ct27ILii1LBzeW7mupR3v/ImEZv1pT8iyj8Hvp+rulj4dlOOCIwcW2es3lNFCsg1pyojO5Nmpyx/gQT5c415p+PcY0mrzvbeiZuEebx6AKm9rEasu4Kvzkwf9J6Ox7bbYAWN/yXATN0XPnWck4e4238O6/Wsnl+4lChwPwifAomeP9DuttC39IUiQqX5odGBBiNBle1zbCLOB6TiAkQqVF3DVHKYc2bIBuK1Ht8Iry/nG5BYDC3bowhnNztNtgEXx76seBsLw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f154ba52-79d2-410a-2db9-08de96e388ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 09:28:33.1709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DOOfcy7Aa2Yu9NeSFC31KDJb8dqMc4bY7Ro2IeyuvWNqglzrJy6sNynTa5DEsh8fS3pUOKSzbVAyRgl46XQX+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB6033
X-Proofpoint-GUID: 4KGvLDAJzEQaePmLE7qXL9S2sSow-1P8
X-Authority-Analysis: v=2.4 cv=asqCzyZV c=1 sm=1 tr=0 ts=69d8c2c4 cx=c_pps
 a=bbl9BA5qyFAQDT3iAuOISA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8
 a=M5GUcnROAAAA:8 a=JfrnYn6hAAAA:8 a=7CQSdrXTAAAA:8 a=Zg3oadTJ_-84loxucP4A:9
 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4NiBTYWx0ZWRfX74pYY5+iYnij
 v0JjeUIa6BAnPCRTM//HjfFQAQ3c53Z1Zels4j3PsZRwLDGSc4NcJkm+kvN718A5QQ6BRIPJO+7
 q9is2cDWd8FUhw556aoA1mwPHwhXaOgd2gIFIEaTCVnEh2fQBUsjJgSA2GZOiANSbv1Dp49l3zY
 /KsYFKHVbXjKXQjuRZj47po/3aqib4J+9LljWv19fsw2gCHECBQ8SkH8l/aVWHcpBqHlcCu+cKk
 rc6k5Wr6r+iTVAfwSKJfIqDqop1SLnidHUwIjp4Br5X8dxB+mKqonddelfLI/uTbD4lTk1Ryw1V
 Zat+yfa8CGsgLT1a/BFEpFAa8Z4+UbWK/Nun9VVAlUuXGB5FDZ5BU/ToCu8aen9xdhWLVgJUFyy
 MZ89MaXjHDJ25xwc0qOIgTZ3qHi9Zej/aqbfseL8Y5KQY8WzVg8MQr/1oWgzrfBWd22Rl9Wrkvj
 vu5qPvmHKe16BUQWsfA==
X-Proofpoint-ORIG-GUID: 4KGvLDAJzEQaePmLE7qXL9S2sSow-1P8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyemtAa2VybmVsLm9yZz4NCj5TZW50OiBXZWRuZXNkYXksIEFwcmlsIDgsIDIwMjYgMTI6
MzkgUE0NCj5UbzogR2VldGhhc293amFueWEgQWt1bGEgPGdha3VsYUBtYXJ2ZWxsLmNvbT4NCj5D
YzogbGludXgtcGVyZi11c2Vyc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWFybS0NCj5rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+bWFyay5ydXRsYW5kQGFybS5jb207IHdpbGxAa2VybmVs
Lm9yZzsga3J6aytkdEBrZXJuZWwub3JnDQo+U3ViamVjdDogW0VYVEVSTkFMXSBSZTogW1BBVENI
IHY0IDEvMl0gZHQtYmluZGluZ3M6IHBlcmY6IG1hcnZlbGw6IEFkZCBDTjIwSw0KPkREUiBQTVUg
YmluZGluZw0KPk9uIFR1ZSwgQXByIDA3LCAyMDI2IGF0IDA5OjA1OjEwUE0gKzA1MzAsIEdlZXRo
YSBzb3dqYW55YSB3cm90ZToNCj4+IE1hcnZlbGwgQ04yMEsgU29DcyBpbnRlZ3JhdGUgYSBERFIg
UGVyZm9ybWFuY2UgTW9uaXRvcmluZyBVbml0IChQTVUpDQo+PiBhc3NvY2lhdGVkIHdpdGggdGhl
IEREUiBjb250cm9sbGVyLiBUaGUgYmxvY2sgcHJvdmlkZXMgaGFyZHdhcmUNCj4+IGNvdW50ZXJz
IHRvIG1vbml0b3IgRERSIHRyYWZmaWMgYW5kIHBlcmZvcm1hbmNlIGV2ZW50cyBhbmQgaXMgYWNj
ZXNzZWQNCj4+IHZpYSBhIGRlZGljYXRlZCBNTUlPIHJlZ2lvbi4NCj4+DQo+PiBUaGUgQ04yMEsg
RERSIFBNVSBpcyBmdW5jdGlvbmFsbHkgZXF1aXZhbGVudCB0byB0aGUgQ04xMEsgRERSIFBNVSwN
Cj4+IHdpdGggbWlub3IgcmVnaXN0ZXIgb2Zmc2V0IGRpZmZlcmVuY2VzLiBUaGlzIGJpbmRpbmcg
ZG9jdW1lbnRzIHRoZQ0KPj4gQ04yMEsgdmFyaWFudCBhbmQgaW50cm9kdWNlcyBhIHNwZWNpZmlj
IGNvbXBhdGlibGUgc3RyaW5nIHRvIGFsbG93DQo+PiBzb2Z0d2FyZSB0byBkaXN0aW5ndWlzaCBi
ZXR3ZWVuIHRoZSB0d28gaW1wbGVtZW50YXRpb25zLg0KPg0KPkRyb3AgbGFzdCBzZW50ZW5jZSwg
SSBhbHJlYWR5IGFza2VkIGZvciB0aGF0Lg0Kd2lsbCBkcm9wIHRoZSBsYXN0IHNlbnRlbmNlIGFz
IHJlcXVlc3RlZCBpbiB0aGUgbmV4dCByZXZpc2lvbi4NCj4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBHZWV0aGEgc293amFueWEgPGdha3VsYUBtYXJ2ZWxsLmNvbT4NCj4+IC0tLQ0KPj4gIC4uLi9i
aW5kaW5ncy9wZXJmL21hcnZlbGwtY24yMGstZGRyLXBtdS55YW1sICB8IDM5DQo+PiArKysrKysr
KysrKysrKysrKysrDQo+DQo+U3RpbGwgd3JvbmcgZmlsZW5hbWUuDQpTb3JyeSBmb3IgdGhlIGNv
bmZ1c2lvbi4gVGhlIGludGVuZGVkIGZpbGVuYW1lIGlzOiBtYXJ2ZWxsLGNuMjBrLWRkci1wbXUu
eWFtbA0KPg0KPkJlc3QgcmVnYXJkcywNCj5Lcnp5c3p0b2YNCg0K
