Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D749D17B516
	for <linux-perf-users@vger.kernel.org>; Fri, 15 Nov 2024 05:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731648448; cv=fail; b=KBg4HsSAjEXdVMLOR2aOCh+UEtS0OKFTjzuwRGYQELZg2kgGA4ZalxjUg9mE4Xt+lKcvVKxjLZGUv9DGlsFj4/mouWEyp/414scq1UvDHXjDRHn7pMdeFWe8XA6cXDsyoIeRbP0XPhKoSp/gnxrzVpyuT9yhK+xg6DxYl+C9asA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731648448; c=relaxed/simple;
	bh=D0olgV1sOl9tpm7C+pdV4ZXLA8OZN0Wq+6JQU1/aQ/Q=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=UCh5WGMNbT2T6kN7z7gzlC1YKD5JBsuSpofiylI3EbRQpHANioyQDqQDihM8gW2KkZGRmJVpDgK5SLn1zHezkU7B54Ewtm00wQNk9U01plLVrdLEM/Bj7DpntoZVp0iqBtu0AWOOiCkmCdruTupiie/I93U2N8pYNopaSDYLZps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jn/vDlmL; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jn/vDlmL"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF0jqUs014848
	for <linux-perf-users@vger.kernel.org>; Fri, 15 Nov 2024 05:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=eHkws7WAptNxcNASQ6jdHBmHoEnh1SI8hXytTv4AH2A=; b=jn/vDlmL
	BT5KXf+2IKmzwd0mH/MYx7VXS55xFZLBdftvwt65SKgQ9zUyfxjNYCWH29u1YcvK
	Q8GjX3fV3uEG/QXu2x9d1ovJNqDP8pyJk/m9/q/Xqi4mByIIc/hLZOhL/FrOEO38
	nGDCIP411ru2mvZ8U+evjuT1cA1bb0w3VWNaeS8/gjWxMwi7mKPLZmgr6nElMA/f
	OOlb2t5f0Gol30XNFoSLPdCXw6IpK1xbm07Mv8PP6gKr7ToFRIgZkZ7I+DZngZOk
	zL7/WwpIAKdPusHPniOmurAiDioYHtrA42pOATJdChZOsfe+yc2Wytr7/Vgd+z67
	vyH6MiNLtTSGCQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wuvc123r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Fri, 15 Nov 2024 05:27:25 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AF5RPgu013254;
	Fri, 15 Nov 2024 05:27:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wuvc123n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 05:27:24 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AF5Md4D003652;
	Fri, 15 Nov 2024 05:27:24 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wuvc123j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 05:27:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=diDTuxBQnr6LTKHuVDCvRa8K464MLz9AXzpI/1R7V89jeUiRbOVGQxtfAetTlUwFbFjD7gW0HtUFKAEMYj2yICkhnS+PLJ1pLwo1hNxjj3F5HpeKhnfqwuC6Eh1xHCCApzYPCzBwzoqcSpPcwhiBJDp/nl0ZayTXSgwKgShKLRvKqc7ihpGbmspsSFKdn8YG2IlP+i0fU4z3RsI4lHsCb5yKtXyjrV/hj2gAuFDTcgpDOiY4ArUcyLVK1t+wYs9yG5aKuVhpAvx4AMCaW6fsxZrn9fuj7uM8GXLOYSoi2REbYjUENiUnKBRfHvM+xzH0Kqd8oBidM9wKX6JOkGjSmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=St4GYHrgOaPL6F7ZAqlvCEeUzrscxB50ihyefk6sdUM=;
 b=J0wJdBySJK5H2iIYUIAAzZdkm80SmJJpGlnwE0ADzY+yr11t9p4QlfdJprxG8OM5RKDUC3zwRAE1uJ4EQjqKHdOmoga8c6lff6bnvL6qD/Ov4AbKjO1Dsu5hfDnFudicE3Xvjy1PlueCA0GA4TUxQZT1LVL5kMpKsGCg3436vT+kPWmLjIXUzDNneXR6szunJtLTtR+ZZCHNHcxU8c64AtlerzBFPFqQhSvj9susV6TpHxdPMgBwxox3aMvj5l4mZvTN1qLP0YbguuSob+J34822ghjc2nblDG79mnSZIR4eboOh+xLqk0HgN74bE0dN0+LGHERGg1HfpKVrFb+jvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB4839.namprd15.prod.outlook.com (2603:10b6:806:1e2::11)
 by BLAPR15MB3921.namprd15.prod.outlook.com (2603:10b6:208:27f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 05:27:21 +0000
Received: from SA1PR15MB4839.namprd15.prod.outlook.com
 ([fe80::c3e4:66da:7486:d945]) by SA1PR15MB4839.namprd15.prod.outlook.com
 ([fe80::c3e4:66da:7486:d945%3]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 05:27:21 +0000
From: Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim
	<namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner
	<tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers
	<irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang
	<kan.liang@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Arnaldo Melo <acme@redhat.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        "Steinar H. Gunderson" <sesse@google.com>
Thread-Topic: [EXTERNAL] [PATCH 2/3] perf disasm: Define stubs for the LLVM
 and capstone disassemblers
Thread-Index: AQHbNx8LfX3As4X4hk+ixApc9pjOPQ==
Date: Fri, 15 Nov 2024 05:27:21 +0000
Message-ID: <6847C738-D2EB-4637-873C-20DF5FC64605@ibm.com>
References: <20241111151734.1018476-1-acme@kernel.org>
 <20241111151734.1018476-3-acme@kernel.org>
 <B78FB6DF-24E9-4A3C-91C9-535765EC0E2A@ibm.com> <ZzT9oHzYdfLZwmJ_@x1>
In-Reply-To: <ZzT9oHzYdfLZwmJ_@x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB4839:EE_|BLAPR15MB3921:EE_
x-ms-office365-filtering-correlation-id: 1bef3767-2fe9-4cd4-9e60-08dd05362dc9
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?LzlkVWpyRk1WZ3RQblpqek5sRWRvMjQvam1Tc2VVU0hzOHorQk1HSlZxaERL?=
 =?utf-8?B?aUpFOENaSTZ1ZmtKMUowdElXMEVoRFpPZzM5U21QbktFdUhMN1lIY0ZuRHR5?=
 =?utf-8?B?WnE0NHMrT2lhUGkrWEQyM1lpM1JZcnMzVW5VMENXd1pjK0pzZzltNXQxUVJG?=
 =?utf-8?B?MGUrQUNyZ3J1dFJjcDhkSTJlaXZvYmZjY3VRNXZjM2xkbTh1MGNteXZOSU9G?=
 =?utf-8?B?amNmOFNYSUZZUGkzSTkvVCtiRy9qRFpKYWZsejZlOFRpbWExRm9iRW1oMlFq?=
 =?utf-8?B?cXc5OHNpRElaUDdkdlZKMFlaZlNNa1BTcXN5eFdkTkhoYllCSWppaGZtSzVL?=
 =?utf-8?B?RkoyK0svSEY2THdrY2x4UUtBYVpzVHE2b2ZOWGZ1akwrVkJQdlhrZUdmbk02?=
 =?utf-8?B?b1VIMzJOUU1OcWRFemNDV3kydmlabS9TdWtwOU5QN1gyajhhYWRpTlFoalpM?=
 =?utf-8?B?Zi9TWHI5bklQSTBPMVJ5QkZxSjNHa2ZjQitRWWZXdURkY3hMRHF3YWhMZzVR?=
 =?utf-8?B?OHFPd2NLdUFIN1dxK0M2U2hFcWtBYzZra3ErK1U1a0dvQjZLUnBEMlMwdW10?=
 =?utf-8?B?OEZQb05adEV5SnFRUk5ZQnk1VWZOU0lPdm0vdWJHS0NFLzRhSGdwQnVVMUJQ?=
 =?utf-8?B?bFo3WGthQy9kd0Z1Qml4ckg1OHZOYmhOTkh1cVd0ZTM2ZDIzSzZMR3I1S1kz?=
 =?utf-8?B?MHgyQUUyVC9sRVhneWdNK2dyci9hcG91djhXUEJ5OFBHalFSQy9qanl3NnRB?=
 =?utf-8?B?ai80U3RNOGdKdDdwRVF5Qzd3SGRWK2x6T28vb3FRbVNyLzd5U2lXZy8zSDBP?=
 =?utf-8?B?RnRndDBGWmhUNm94c3d6SGgrQ2lHOXVnTE5xTTBGRUZheGdnWFN6QUFrR0Fw?=
 =?utf-8?B?L0d2L2puWDBLeEtFdG9GZHNSNTBJT1d0WUZxUkY0OFg2YjdBNG9ZdzVFT1Jj?=
 =?utf-8?B?UStrUjRYcjZSc2ZHOW5BVWZOU0VScUlESVk4MDROMFdjYXlJZHo1YVlSZith?=
 =?utf-8?B?ZFZCODVlM0UvWE0zRE50cnhDVWRsaGdGWGtCYjZuVlJyZmZPb1cwNUZ4Wms2?=
 =?utf-8?B?ZWJWZVRjNjlYSDdDcjRpREhFTmxRZk9TbnRPL3ZoNElGemliaVVST2pxZkJz?=
 =?utf-8?B?SDdCTFk0WGJiRUNmZHNCSGhlaDdWbUJkVUFITHM5bUo5ZkFnVUZwTmZwMEVP?=
 =?utf-8?B?R3lyeDFjTWEvem01YkpGZER5TFBuQ214eXIzREplNVBpelgyNHloeUc3SGxm?=
 =?utf-8?B?cGNmYWFGYWRpckFPaEpzbUgvV2JubWFIamhvdWhRb25XWFJHY3U0Y1E2QXNO?=
 =?utf-8?B?WjRUdjM5SjlaWWEweGttYXlNYkYwWC8xcElDNmIyOHMwTG9yZnJiRnk3eUdk?=
 =?utf-8?B?RG9FODV6bWEydHNVQkI1VTVtbjhjQXJrNlJsaXpPTzNjekJvcngxMDlYYXFm?=
 =?utf-8?B?Q09QSUVnNlBPa1NicHFiZHlGcEtPVXB0cDdQeE4zSms4NVo0bnZ1U0dEZkJS?=
 =?utf-8?B?eXFydTkwbkVocXhsMEYvTW9aNFBSZVhzK2lLUlp2UFBCMExQZjlyOTlYZGFp?=
 =?utf-8?B?VzdMQmpPL2ZhU0x0NkQ2R3ZmeWNsSjQrZkQ5ZGErSVlYVHpua3U4OE9xdDZB?=
 =?utf-8?B?cHJoVlpxTHFKNE9mN1JxUCtyVFZac1JZK1kzSThHZGFyVll5OHBxZXdBbDJN?=
 =?utf-8?B?a1lRUENoaTY4aE1ScnJHeU5RcXZha1hBYU5KMlRySllWZDN6b3N6d3NKR1pM?=
 =?utf-8?B?blBTTjdwVHI2SmFOWXA3K00zVmZ6SjhYVlFYOWZwYmFKYXFTZGcxbG5DYkR5?=
 =?utf-8?B?ZE01Z0NtR2pRbTZJMXZpQlllQ0tTM1A2bUU3Zjh1Q0pTSUIxRFNxOERmbE1U?=
 =?utf-8?Q?QJ7Au5xa4YYaG?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4839.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OFFVd0N2M1JHWWtteVJsQVhjajgyK3lqQjRWTytNVyt6Y0ZjYzV4UEJsODlt?=
 =?utf-8?B?cjlKd0JYYzBVNVNYc0d3ZjJ4Yk8xYlE0TUFrdXp3ZUlhM2FHN1lpaFBpeHFH?=
 =?utf-8?B?eCtSRjV6aE8rckxZdEhaS2R3SUxHSnNiYkljQTJoTU5vbTR0QUFmZy9oanhO?=
 =?utf-8?B?ck5oMUFUUCt4cjdCdEVibVJKdFBpTWh2ZFRkZlJOUVN4RmhxY21VcDB0SWtS?=
 =?utf-8?B?UFk0WXUrVjhtbmtOZUoxd016empSbTFMSXAvKy9jUnZtWWxoK3h2S3MwU1I5?=
 =?utf-8?B?QlRCblVFWEI0M0h4QnpTcDU1dnBzdjhyWk1RdHA3VENyVmdVWVluczBoSkJu?=
 =?utf-8?B?emtaTEhnS0grRXhOWENvUWJTcXNjNnR4R3dYMkxMYk1xTk9rSldwUG4xcWw0?=
 =?utf-8?B?M1lESDBXQWpaTGpFYnVrOEVzYTN2YjhsL0ZNckQvUlV6cHlXK0tQbzVoQ1Vu?=
 =?utf-8?B?UUduQllZMXg2SWNwNWJlQjc3NExZV0tOa3RDeTVqb1ZCVlVPRWsyL2pKa1Bt?=
 =?utf-8?B?SVpSZ3c1QUdSUlJoVEtoZVdCS2FxenpvTm8xYUl6THV6dzUzMU94bUo3WTVK?=
 =?utf-8?B?ZmEvTTZJU1poZXowQmM0Tmt3ekZHbzZDL214d3dSaHNtV3dGWERxWlFpVm1k?=
 =?utf-8?B?OG5ENjIyeFQ2Wm1pN0h1aWRveUhUNXdxdUR1N0pPSkl5MDZNdEJscFJ0YjNk?=
 =?utf-8?B?RlJvTkxDZkZIT283V1lpUmpZaStyYmRKK1hDejBVdDZwT3JzaVhTYTFiLzha?=
 =?utf-8?B?SHl4c0hSUjBGb0swb2V0YnlkdlFMTi9vV212L1F5ODJMaWNxRWZncXdROGNB?=
 =?utf-8?B?QlZqSGp0OU5QUjlON0xxcDBKVGNpNUhDQmlQVXptM1VJMklrd29hdXZsY01J?=
 =?utf-8?B?VXFYOW1sdEZoNlA1UHlJdlFramRXRGFma0FiVEV1N3ZBNVJmMGZyTmMrSklI?=
 =?utf-8?B?VTVVaUs4MXVmRldnU1ZjMXVCVmRabTVZbC9nTHc5RXZnV2Q3bThERmE2ZjdD?=
 =?utf-8?B?cG5SSHBoZ0N1K2ZmZ0F0bmNzVHk4RWoramtFaFRwMlNDK2JOalQ5cGFGclIx?=
 =?utf-8?B?Z3lqc044aFhCNkM3OW5mdlBiV28yMFlGNTM4STh3b0VaTDNYaCtrb2RraWJH?=
 =?utf-8?B?S1pPU3FLTjNRWUNZUWNPT2dUNWdGNmg0bnBIWWU2VHVheVVxbkNSY3p5YmRO?=
 =?utf-8?B?RTgxVG9hQXFzL3ZoQ2xiMVhRYTJoYm54QmNZaVNEc1ZURVpaMWxucXFCVGhk?=
 =?utf-8?B?MWFpYkZVSEw1SEdVYmF3UlptOW8vbUh1blFxTG1LVXNvZXJWYnNRYzRCTDFt?=
 =?utf-8?B?cUNLTlloZ0Z3bmM1cTlSUnhVOEdnQ1NmY0N1ZjJyejl1S0cwbUdRM0owOXR2?=
 =?utf-8?B?WXpOVlhDSnc5N0NHQUZIaFZ6YVdYZzVTZXgxNWMrLzJpa0lJNzlON0xrTGZs?=
 =?utf-8?B?dC9mUEZJNlJRR0tDWCtHQjN6UFUzSEUwakIxeFduRTZMOHpzNFlSMVlGbWhq?=
 =?utf-8?B?eWhTOURLVGk3aFRHZXJqOFFHNjF6V3FzRXpXeDZkUU8yaGJJMlorOVRzT1hX?=
 =?utf-8?B?ZnJWcG41WXJDUnlqWm5HUmJIY3kxbUhhUGxBK1ZGYVV4bjAwVGFjVnh0WjVT?=
 =?utf-8?B?enVNQUkvM1Z5eCtscmlIdGk2Z01ZTk4vNVUrSVRFSU1qMExwV3Z3Q2NnVHhw?=
 =?utf-8?B?aVNNRkxFUWx1UklVVWhxRFFLYXJ5K2Vzd2J0S29wWUFGbGxhTkR0K3Q0YVFG?=
 =?utf-8?B?KzM5UGV1cFJCSGh6ci9sdUhpUmNYUHc3UmNmR3BVSnRPbzZ0TVg1enpQamxw?=
 =?utf-8?B?UkVOYi9teDRGUmpZMUZocDR3NW1LT3VtWEJyL3dDK2NDVlEzakhrS2ptYjJ6?=
 =?utf-8?B?MDg1L2wwcE5odTlXUkRnTG0ra1BwZDEvbzcyNDZnRzVrQlFlR0hzZmRvczJ2?=
 =?utf-8?B?eVBYWkptLzBxaEhZazFnS3Mxd1dwTmYvK3RDYVo5MnpHaUduTWliYVpwSW13?=
 =?utf-8?B?TWdHN3d4S2M2eWFpc3FvWE9GUDVQdDFhNDhoNDdvK2NSWlAzbmVEU2JBZnNV?=
 =?utf-8?B?RzdFSHR1TSttUDNwYThQL2NhNk9YWTBIZXV0NGtJOE9CeElCaVZJNkJhSXJK?=
 =?utf-8?B?NnJOOHJwL252YmdQZFlCRUR5K1RteTdBeFFDRGRYUGp6MXhlck13dkV3dXJu?=
 =?utf-8?B?ZVE9PQ==?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4839.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bef3767-2fe9-4cd4-9e60-08dd05362dc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 05:27:21.0790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qwlS8RDuMqoQU5yw6c5XdXpDeTBtBas87pBw3hHzgKWrY9aJEm6j96nafyaWsmrvDBgDIdtCYqZaL/12LVKoqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3921
X-Proofpoint-GUID: 26owafF4oXIxHUoJFvaK8fxyXSaJ5YlS
X-Proofpoint-ORIG-GUID: QncXRo8RyHn_y8NPHgZ6diH3W7PlGxeN
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1B70FE0EC7FD04497D549A7A57BF5C5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re:  [PATCH 2/3] perf disasm: Define stubs for the LLVM and capstone
 disassemblers
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 clxscore=1011 suspectscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=2
 engine=8.19.0-2409260000 definitions=main-2411150041



> On 14 Nov 2024, at 12:57=E2=80=AFAM, Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>=20
> On Wed, Nov 13, 2024 at 03:24:08PM +0000, Aditya Bodkhe wrote:
>> Hi Arnaldo
>> I was testing this change in powerpc setup I see below compilation error
>>=20
>> CC   util/disasm.o
>> util/disasm.c: In function =E2=80=98symbol__disassemble_capstone=E2=80=
=99:
>> util/disasm.c:1728:9: error: expected declaration specifiers before =E2=
=80=98symbol__disassembler_missing=E2=80=99
>> 1728 |     symbol__disassembler_missing("capstone", filename, sym);
>>   |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> util/disasm.c:1729:9: error: expected declaration specifiers before =E2=
=80=98return=E2=80=99
>> 1729 |     return -1;
>>   |     ^~~~~~
>> util/disasm.c:1730:1: error: expected declaration specifiers before =E2=
=80=98}=E2=80=99 token
>> 1730 | }
>>=20
>> Below patch fixes the issue
>=20
> Thanks, I've folded your fix into the patch since it is still in the
> tmp.perf-tools-next branch, added a note to the patch to give you
> and Masami credit, both sent fixes that I had to slightly adjust:
>=20
> ----
> perf disasm: Define stubs for the LLVM and capstone disassemblers
>=20
> This reduces the number of ifdefs in the main symbol__disassemble()
> method and paves the way for allowing the user to configure the
> disassemblers of preference.
>=20
Hi Arnaldo

Thanks for adding the fixes. I tested with tmp.perf-tools-next and it compi=
les fine

Tested-by: Aditya Bodkhe <adityab1@linux.ibm.com <mailto:adityab1@linux.ibm=
.com>>
> Acked-by: Ian Rogers <irogers@google.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>
> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Steinar H. Gunderson <sesse@google.com>
> Link: https://lore.kernel.org/r/20241111151734.1018476-3-acme@kernel.org=
=20
> [ Applied fixes from Masami Hiramatsu and Aditya Bodkhe for when capstone=
 devel files are not available ]
> Link: https://lore.kernel.org/r/B78FB6DF-24E9-4A3C-91C9-535765EC0E2A@ibm.=
com=20
> Link: https://lore.kernel.org/r/173145729034.2747044.453926054000880254.s=
tgit@mhiramat.roam.corp.google.com=20
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ----
>=20
>> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
>> index df6c172c9c7f..da22b6ab9ecf 100644
>> --- a/tools/perf/util/disasm.c
>> +++ b/tools/perf/util/disasm.c
>> @@ -1724,7 +1724,8 @@ static int symbol__disassemble_capstone(char *file=
name, struct symbol *sym,
>> }
>> #else // HAVE_LIBCAPSTONE_SUPPORT
>> static int symbol__disassemble_capstone(char *filename, struct symbol *s=
ym,
>> -                    struct annotate_args *args)
>> +                    struct annotate_args *args __maybe_unused)
>> +{
>>    symbol__disassembler_missing("capstone", filename, sym);
>>    return -1;
>> }
>>=20
>> I tried with tmp.perf-tools-next , I have tested the above patch fixes t=
he compilation error
>>=20
>> Thanks=20
>> Aditya Bodkhe
>>> +
>>> +static int symbol__disassemble_capstone_powerpc(char *filename, struct=
 symbol *sym,
>>> + struct annotate_args *args __maybe_unused)
>>> +{
>>> + symbol__disassembler_missing("capstone powerpc", filename, sym);
>>> + return -1;
>>> +}
>>> +#endif // HAVE_LIBCAPSTONE_SUPPORT
>>>=20
>>> static int symbol__disassemble_raw(char *filename, struct symbol *sym,
>>> struct annotate_args *args)
>>> @@ -1983,7 +2003,14 @@ static int symbol__disassemble_llvm(char *filena=
me, struct symbol *sym,
>>> free(line_storage);
>>> return ret;
>>> }
>>> -#endif
>>> +#else // HAVE_LIBLLVM_SUPPORT
>>> +static int symbol__disassemble_llvm(char *filename, struct symbol *sym,
>>> +     struct annotate_args *args __maybe_unused)
>>> +{
>>> + symbol__disassembler_missing("LLVM", filename, sym);
>>> + return -1;
>>> +}
>>> +#endif // HAVE_LIBLLVM_SUPPORT
>>>=20
>>> /*
>>> * Possibly create a new version of line with tabs expanded. Returns the
>>> @@ -2242,24 +2269,21 @@ int symbol__disassemble(struct symbol *sym, str=
uct annotate_args *args)
>>> err =3D symbol__disassemble_raw(symfs_filename, sym, args);
>>> if (err =3D=3D 0)
>>> goto out_remove_tmp;
>>> -#ifdef HAVE_LIBCAPSTONE_SUPPORT
>>> +
>>> err =3D symbol__disassemble_capstone_powerpc(symfs_filename, sym, args);
>>> if (err =3D=3D 0)
>>> goto out_remove_tmp;
>>> -#endif
>>> }
>>> }
>>>=20
>>> -#ifdef HAVE_LIBLLVM_SUPPORT
>>> err =3D symbol__disassemble_llvm(symfs_filename, sym, args);
>>> if (err =3D=3D 0)
>>> goto out_remove_tmp;
>>> -#endif
>>> -#ifdef HAVE_LIBCAPSTONE_SUPPORT
>>> +
>>> err =3D symbol__disassemble_capstone(symfs_filename, sym, args);
>>> if (err =3D=3D 0)
>>> goto out_remove_tmp;
>>> -#endif
>>> +
>>> err =3D symbol__disassemble_objdump(symfs_filename, sym, args);
>>>=20
>>> out_remove_tmp:
>>> --=20
>>> 2.47.0


