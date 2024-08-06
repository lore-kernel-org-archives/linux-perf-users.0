Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DBF1BBBEB;
	Tue,  6 Aug 2024 06:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722925678; cv=fail; b=tZY3s3g6I3AUMP0HeHo8RN/x7mvk5qvHgcr6eUDoQf/uHzprFE9tOOzY3p1IA6vMXovzz5Ij75RIC7yDCMZ6qEZD+Ms2CXVpbn+sjNzUXlfHX4KQUw55qzdRtJVapkhNDuyHxAfoAohy3f4oSIJArsU1TfPSEjB7+rhzhKGfVIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722925678; c=relaxed/simple;
	bh=ZC8zqdqEqRRkqxsWBb489FFBXG0ljMAp/xgHsKsVMiI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PmIyj6bEzIt9CoOGwVarmCunGPGcMl98+ela+4eCBqcEg8F2GvtBwClh1gkq4D9U8qWSCqcLIdQfaMkRuAJzKkD5fSWTTUDqvArC15aZH2+TivOgN1AuENyGn4G0QMV04oBBudeNa+o5bRBLxoxcJUdd2HKSM+dxsgx/vKY8REs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=qvWpD8zE; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=Z5vrar95; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="qvWpD8zE";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Z5vrar95"
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 475MMdC8019236;
	Mon, 5 Aug 2024 23:27:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=ZC8zqdqEqRRkqxsWBb489FFBXG0ljMAp/xgHsKsVM
	iI=; b=qvWpD8zEE7bcJn0za0O61uTwtwtuMthapC5fAFvvYJN+gGJFbn6C2S6nR
	9vrtCdm/WedU71dtZD4USm5i0btjwqwnu4OjsENXDh6GhgImbBT+efVVs/DI4FQv
	7xBDjJGk0XBIQP6yY4Bh/n2PluG0HFhwQUIXyh/V8TzOY/jBT/OLYKg34LkRXURM
	gmTUoadiMgEGh+sYMW+LkrpEvPfGdZQmY/UTLieWJjBiS9/2ymOLH2LVUTdsKHaM
	0zux63MP2rDe6+GI94XJAHOzGzUm6qNrLC7esnEYKV73QN719ufAXSM80JizJrMU
	0lBK9e0eX3EbXKKWsCvbvAgElEr+A==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 40sgvrn69c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 23:27:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTwwj3wIvtYFIm8kGm72R/BKlk3ERZpidZlOffHY3PzKsoCGK4x1+py/Ht1KQQKFFxdFpNszmKGr2K3OvQ+q0BNm94kYtoYK9373340zsy1orJ4pDqVx+/g0vD5dDFZhMTEPhKWH9xNvzaRyk5HLY9ec5wkm0beYTs8cYWLhEGJolByFLkjY9zprtOBELbQFzyQL+ZRrEy4lFkyATpAhaJ8GMIkwawl2NhxcKv9D6wTjMB+7YCIpY0718Drm2/LDF4D4/HkA5D5ofdiOAqQJQIvgbOECoTxmAuabD6/czMEMEFZ8lVR+rHNGOZ4B+yIZrGPScwMN8giqbnwQV6JmDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZC8zqdqEqRRkqxsWBb489FFBXG0ljMAp/xgHsKsVMiI=;
 b=VefFRWYutLmlDmUgeb8uGOt9YTtv2XUs4bAbexPXGjkXz7s7xL+p9DC2C2XTAgKgKXRuAVt4oQDi/BAH0ulyoN1Gqo0HMFgAhhlSh0BJem42C29EHnnvdBomjWgHMmow6UQ0VyU4Ikxb+l1jj3rqT0QMGOfyB49+9FV6h3Pj946FOG3yz7mo2DxhVAfVlRlIXcHVJtdAZQmOcahMXgxBrULVn5syoVAJD71mJ/Az0a5F8fIvTN1BcB+I5wLVAP1S2uCDZbSQ2duwM5g6Sx4+65QL4B/FW86K8zg4BLcw0OQQftFJSv1cpt4mEBlu+kftA+1ZedWh0b/XbcbJ2jvwuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZC8zqdqEqRRkqxsWBb489FFBXG0ljMAp/xgHsKsVMiI=;
 b=Z5vrar95h25pecO8FJmyruNBgz0up9LjEqnfGqbZdE0qU/PlaCoiSPt8ezLelZIKferKXmojj81m51t1LnVAHbju8jasHTOGaEIWubknO/ed/RwEdDxsGEXTkNMg0jSEMJp4Brn+yKF3ntdic+tlTG90npKunWAgA64+tPJ58azWGuM77P0QABqffeWJ50Ptf4zs3VEeBNPkc+Wo2bx1SC5uiJKOIhJnz5NmGj5zPFMTe2p751cpMjP7lCJVDMA9UqUXc1vnY0/+gRpCftAAvYEPDYzWK4gVgkqjVc30gahjKNeeCB+dPeQrhLMNq6QzQ88y9Qj/fzx8XmAOXiW9Sg==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by MN2PR02MB6719.namprd02.prod.outlook.com (2603:10b6:208:1d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 06:27:35 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::b78d:8753:23a8:cc78]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::b78d:8753:23a8:cc78%4]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 06:27:35 +0000
From: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To: "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com"
	<mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "mark.rutland@arm.com"
	<mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>,
        "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>,
        "james.clark@linaro.org"
	<james.clark@linaro.org>,
        "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf test: Use -Wp,-U_FORTIFY_SOURCE for tests built with
 -O0
Thread-Topic: [PATCH] perf test: Use -Wp,-U_FORTIFY_SOURCE for tests built
 with -O0
Thread-Index: AQHa58iFg0Q+913iDEurf7AueZctN7IZw9OA
Date: Tue, 6 Aug 2024 06:27:35 +0000
Message-ID: <4D19AE26-E1B4-44B6-A8C7-639EF2B69317@nutanix.com>
References: <20240806061749.143072-1-eiichi.tsukata@nutanix.com>
In-Reply-To: <20240806061749.143072-1-eiichi.tsukata@nutanix.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB8041:EE_|MN2PR02MB6719:EE_
x-ms-office365-filtering-correlation-id: 77ed6397-0f14-4237-c4f4-08dcb5e0dc32
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?NlczVDNaQWZFdDlSR3FSQkVOR2VCTUczRDA5TTVwaGtubmhVZE5FRW9yQ1NC?=
 =?utf-8?B?ekdUZU9NMmJjK2d3ZjZ6S3VOVzBRd0Q4UC9SbWRVVUNkZGh5TEs4ZkJDSG9v?=
 =?utf-8?B?bFZFMVhYczMvMFBmcm1qSEVVYmNMM0RHVllqZldFL0lPSk1ySWk4RjRWZHZw?=
 =?utf-8?B?WVcyMngyaWdmY2o4RjFLRE1UZEhkZnlFWW8vcTFia3pHeklVQ3kwWnBnVnln?=
 =?utf-8?B?VlNOaWhZbmdFYUlTYmU2TG5uTHpHWWlJT3BOSU55VDA0amZvZW9FdEZId2xX?=
 =?utf-8?B?WHdadE95bjE4eis1Mm12OWtLTnhqanNZWnhEL3diZi82RE11Qzg0S24vTThh?=
 =?utf-8?B?MHRGSG9QV3UxM09IUmhFZ0s1UGx5dEVSZVdHK2ZXQ2lZaE5QZEYvVEJ2b3Ri?=
 =?utf-8?B?ZXVNZjJvN2F1aWhGa1BWR0MyUzZ1bUVQVXJjYklhMGpDSzNmSWNyWkhwNmlR?=
 =?utf-8?B?b0hmcXdJYkdIZUl1M1MxRXhDWmI1MERpTG5SMVFkbWM2Q25iZ3FXV0pqRW1C?=
 =?utf-8?B?aWlFeFM1TGZCdVBWUzF5UVkzcnNtbm5jbk45dU9hTzVURjZXTnl0Qmo4WDlJ?=
 =?utf-8?B?SmovNHR3cmUxYmY5c29hTk94cFc0cGFrZXg4OVlxSVU4SFZkYyszTnFhRlV6?=
 =?utf-8?B?T3NVS3JiNlFJZHBNYWYwVCt3YlVzUVlsYWw4SSs1YmI3bm9NQ3JmRE8wTlds?=
 =?utf-8?B?Z1ZTNXgvdVdxd3g2aGdJY01Sc2hzYXc0eXdGUjduQ0REeWdDSDQrQTRPRGhY?=
 =?utf-8?B?cEovRm1IRnlCVUJUckxYVkpMTjNGQjBoQkNvU0w2eGMwWkpEKzYvcCtRdHd2?=
 =?utf-8?B?N3p3eEo2clA5R0NPcFFxWW5KMFF1N3VaKzNtL2x5S1FVK2s0LzhLdGNRVVFo?=
 =?utf-8?B?TjNuZ2M0NU1LTzVOUDh0UFpiaWZBZ3pMcGtKMHhnSFZYOUtLa3Rzb0RDTXkz?=
 =?utf-8?B?dnFkTjNXeDVoYjRYdVpFc082dTh0TlhYcFEzaEx6MkI0QWVnSFNOeUZkYzNH?=
 =?utf-8?B?WUM4UGRTNTk4L25LN2pnTGdPb2d1TmhmMEFPQ3k5TG1RYm1kWFdYZ2N4MEMy?=
 =?utf-8?B?RjNkMGh4WStTV1RidzNGTkFBOTlPSmZKcnZmcnNZU1psLzdzR1E0bXZ1SHR6?=
 =?utf-8?B?RFFlVTZIYUVtUks0QldPSkpEZHRnQ3F3elhuZkNPb3liOWQ1L2UvdTBEU1h1?=
 =?utf-8?B?clY0ckV6UkFuSlY4WWhaTWxPY0V0bU1mTEt0OXBrV0JSNVVBWjNhdUNETFBm?=
 =?utf-8?B?ZCthbFhMdzZHNVB4VUhuWGpDQTA3RlhSc0FWd1N1TEVFSlA0a3RidENOUlFJ?=
 =?utf-8?B?bWlzUHVoTnFBc042U3phc3RXMG1zZHo1eFI5bi8vaDArc1dsM1p4V3g4YkRV?=
 =?utf-8?B?aWJSblpiMW82NlYyUWNPclZHSXlFa1EzK0xVNWltaml0UlJqYVR2cHYyZW9O?=
 =?utf-8?B?NFRCdlNSbmxDTzB0NEErd1JycGNvdXBFL0w0RWFlM01vS0s2YXdqZDZCV2tt?=
 =?utf-8?B?Zno2VlVOSkxDNFBrMmxKUEU5VmNVSkhicS9vd1daYjZCNDNXdDQ0cGs4NjJT?=
 =?utf-8?B?SVZHM2xMOFM0NUcxUkE1UjVJSEhob1VHd0hqQUk3eHZNZW0zWWo3TDlUUmEx?=
 =?utf-8?B?UE10YldYRk40T09ZSHhFT3Y3TUJ6MS9pZmRaUDREV2J6UzE2b1J6RTE2T2dH?=
 =?utf-8?B?bTd5SGtub3lqQXl5cjVqcmtocFpOc0JJWlFDRE1mRDlDdVFSbS91YmhEODd4?=
 =?utf-8?B?UTdmbHdhQTBKTXBvQlZ5dUxwU1pTRURnS1ZLUUtJRXg2aVVKcTlrUHJHdk95?=
 =?utf-8?B?UkJoRkR0cDhkVEZkRVlxZGtMYjBCclhoSHJqUVhDLzZIcGVMeWp4UjVOcFQx?=
 =?utf-8?Q?xER6Cn/A1z3fk?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bWFlNWZGdzN3QkRjcWxnN0l0ZHZxK3dDU0wwSGxYemt1NHl0SmZ3RjdRdnZL?=
 =?utf-8?B?TDFBaFFaRXZDa09XblV3eDZHSTFwQWFsU29SNlhaU21SMVNTRUw4eEJRRU0z?=
 =?utf-8?B?WFIwS2lvMWNEWktnS3ZlSnBac1RIR0lSSG1CSlduY3lWNlRDRXdiL0E3NStX?=
 =?utf-8?B?MEdHaDNEMGszNWVkUXcxLzh1NFppaVBuWFNQSFJhZEdEaUt4TitSUGR1UDhk?=
 =?utf-8?B?QmtMWisxaHVIT0RpdFBmZkgvaGFyQytMQ2ZGdjEvNEE4ZFNDYmxwc0dUSXFE?=
 =?utf-8?B?T3Ewam0xN1ZjeWh2enRCRUV1NTlNbW42Q0F0VFR4cnFXSHZTTHlOa1JxdHpY?=
 =?utf-8?B?V3d6V0Q5RUxzVkdHMWhkN1ZxdTVxdXA3OVpsZDdmS2VIZVdEK21GenU0djBp?=
 =?utf-8?B?Y0lRUjFNV01jSGozZlhNSitQbTFRbDZWcWhxcjE3Zzk2M25KK2g3anp3TTNj?=
 =?utf-8?B?a2pKY0tyMTRRSlF5dEZ4Qks0NUhsOWhORmpsdzN1Uk5jVmpzRTdZbEEySnpO?=
 =?utf-8?B?Sjd6VW04ODVSUHUwdnZQMmlRdDdPQXNVTFoyZmFleWk3MFRtanZxOUhzZnFv?=
 =?utf-8?B?Q012UHhFcWdmbEVQcE9CWXJJdkZlZ0t4VURNeFZmRm5aQ3M2MmdIZzhWNERX?=
 =?utf-8?B?UlFWQjR1VU92TTVmNjY5T2x6c3NCNVFMcklTcVBmRWQ5N0YwbmN1MEtidlV4?=
 =?utf-8?B?bldYVzFlbDNIbk9aK2tPMHNNcUIxcEJla1pDeXhqQVh2ajlvQzh1OXVZc1V4?=
 =?utf-8?B?cmpoNW5NZ1pEb3ZkZzBjTkV3MUhLSFJTOFcwMWhFV1Yvc1BKcHBCMmllY2Ez?=
 =?utf-8?B?OXRFQWs1YUdFNVY0VnlTWGpQaGZ3MXZlRjQ5YnlIcFJqU05WZmFWWG5NQmJz?=
 =?utf-8?B?bjRvVzVsWi96Zm9ZaytGMjI5L3FGQ3NyUThwVVJKUGVSaEhuM2RUeWF6Qjdo?=
 =?utf-8?B?SHZPWlY0bTkwcXl1dldDaXFSU0dNalkvb1pPLzhTWUd0VVlHaFNlQjBRaUor?=
 =?utf-8?B?Q0ZYbktVOHh5Qk96bHplL2kvU3JDOHhkQWdhU1hFczF5WDl3VTNDandtRnF1?=
 =?utf-8?B?MWJ1VG54ZDhrMUk5amJZMHNmVXFrcEJXRE5RV3FnK29Ba3hVcmN3UjNhSjZZ?=
 =?utf-8?B?V1FSZnl0d3MzYTdyYXBnOU1MR0w0emcxalA4K29BS1VrZ3RubUtwdlNiVEJR?=
 =?utf-8?B?Qkx1VVlYRFhhV29lTTZsSnZVVHRXanY5a1NBM21sR01IQSsrZ3BBdW1ZazFw?=
 =?utf-8?B?aWZoZkc4Zi81VjNEajY2K3FJRy9oV2tjV0czYi9sYXpHNWZGUytqeHJ1TTJT?=
 =?utf-8?B?N3d4NlhDZ05rd0xNZVVnbmhrd0loRFVCYVhwdXQ0eXZ4a3c2N3VWQTJhSklB?=
 =?utf-8?B?U0wxZWRGdDFlZGRPeHRmTGRPN0ZXNUdUSzVNS2RzNC9vUlljNmdxZW9pVW5T?=
 =?utf-8?B?b2lOVUpwZlZLREhuRWM0c3dqWkYwcnRIcnNETGVDMHc2eC9QMWs0RXFwbU5j?=
 =?utf-8?B?em5LZFpZL01Da2FWK0I1cWROZ1UvN0pibVM1ZlVjUHlXQ2NxaEoydzV4R1V6?=
 =?utf-8?B?MDRBeDhIbEZxV1VNYU1hSllTb1BXdy90MlNZcHkyQ3RWT3R5cEtpYzRBMEIv?=
 =?utf-8?B?S2FOOUR5OHhoVGc2V2dOWnZURTlybUVGQUwvYU00YWdNZ3QxcFBjZFBJQXRo?=
 =?utf-8?B?Q3M3Tk1hV3hHSXFZN3Arc3A2M3JLNHNoL29VOVBwOVpqOE5RdjhhOFprOEtj?=
 =?utf-8?B?NzFadlhJaGlaZCtCdXp1U1ArSGI5Sko3eUw1M1Rvdjc1UkFHMU1pWHRMclpC?=
 =?utf-8?B?QWFBY2JGa2p2bXFHKzA4OFBYekR3bEhxckRCdTUydEE4eTRqVjk3d05Iemc5?=
 =?utf-8?B?THJWZlVNemtDdzNoUEVoTzhFZE5zTGVPY3F6TGZsRUNwN0ROek8rZTRmUUtt?=
 =?utf-8?B?bjIxZkFFU1BUT2R4ZDlmeGtDQytETHZpUHlnbERGTS9hNWxGRUNEblkweHhh?=
 =?utf-8?B?aTd5S3JZVnlCWjBkUzBnQlhWNHVnWDJ5SUFtRHZJT1VLZVYyMER0MHJMOGNy?=
 =?utf-8?B?NHFGSEZ5S3ZBcXYrUFdYZnNpQzQvYVFSY2dWTi8yeG5FSGZZUUZwaW9Ga2Rn?=
 =?utf-8?B?YzBQcFhkd0FZanVEdDBtK3BzbXhLNEVaUzFJUHZTK3BFMGpQOTM0Q1IxeU5C?=
 =?utf-8?B?ZEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F45ACB33A4B7F84F9A9D37C7E22D493D@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ed6397-0f14-4237-c4f4-08dcb5e0dc32
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 06:27:35.0980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rd9wgu/1CXIB3Oq5Atlfspiic7Q5B5KGXBEE7cM4FqnL8LpRbx76WWT088avkKYLGW88hurwYQGZ1zUhnfnqXrHIwj4/nH07wDxpYj9NebQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6719
X-Proofpoint-GUID: GbOpcaG9ygPiJM28JSBBtjb7FdFXfjOK
X-Proofpoint-ORIG-GUID: GbOpcaG9ygPiJM28JSBBtjb7FdFXfjOK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_05,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Reason: safe

SGksDQoNCkZZSTogRmVkb3JhIHVzZXMg4oCcUlBNX09QVF9GTEFHU+KAnSAgYXMg4oCcRVhUUkFf
Q0ZMQUdT4oCdIHRvIGJ1aWxkIHBlcmYuDQpodHRwczovL3NyYy5mZWRvcmFwcm9qZWN0Lm9yZy9y
cG1zL2tlcm5lbC9ibG9iL3Jhd2hpZGUvZi9rZXJuZWwuc3BlYyNfMjkwOA0KDQpBbmQgb24gRmVk
b3JhNDAsICBpdCBoYXMg4oCcLVdwLC1EX0ZPUlRJRllfU09VUkNFPTPigJ0uDQoNCltlaWljaGlA
dDQ5NSB+XSQgcnBtIC0tc2hvd3JjIHwgZ3JlcCBSUE1fT1BUIHwgaGVhZCAtbiAxDQogIFJQTV9P
UFRfRkxBR1M9IiV7b3B0ZmxhZ3N9Ig0KW2VpaWNoaUB0NDk1IH5dJCBycG0gLS1ldmFsICcle29w
dGZsYWdzfScNCi1PMiAtZmx0bz1hdXRvIC1mZmF0LWx0by1vYmplY3RzIC1mZXhjZXB0aW9ucyAt
ZyAtZ3JlY29yZC1nY2Mtc3dpdGNoZXMgLXBpcGUgLVdhbGwgLVduby1jb21wbGFpbi13cm9uZy1s
YW5nIC1XZXJyb3I9Zm9ybWF0LXNlY3VyaXR5IC1XcCwtVV9GT1JUSUZZX1NPVVJDRSwtRF9GT1JU
SUZZX1NPVVJDRT0zIC1XcCwtRF9HTElCQ1hYX0FTU0VSVElPTlMgLXNwZWNzPS91c3IvbGliL3Jw
bS9yZWRoYXQvcmVkaGF0LWhhcmRlbmVkLWNjMSAtZnN0YWNrLXByb3RlY3Rvci1zdHJvbmcgLXNw
ZWNzPS91c3IvbGliL3JwbS9yZWRoYXQvcmVkaGF0LWFubm9iaW4tY2MxICAtbTY0IC1tYXJjaD14
ODYtNjQgLW10dW5lPWdlbmVyaWMgLWZhc3luY2hyb25vdXMtdW53aW5kLXRhYmxlcyAtZnN0YWNr
LWNsYXNoLXByb3RlY3Rpb24gLWZjZi1wcm90ZWN0aW9uIC1mbm8tb21pdC1mcmFtZS1wb2ludGVy
IC1tb24tb21pdC1sZWFmLWZyYW1lLXBvaW50ZXINCg0KQmVzdCwNCkVpaWNoaQ0KDQo+IE9uIEF1
ZyA2LCAyMDI0LCBhdCAxNToxNywgRWlpY2hpIFRzdWthdGEgPGVpaWNoaS50c3VrYXRhQG51dGFu
aXguY29tPiB3cm90ZToNCj4gDQo+IElmIEVYVFJBX0NGTEFHUyBoYXMgIi1XcCwtRF9GT1JUSUZZ
X1NPVVJDRT0yIiwgdGhlIGJ1aWxkIGZhaWxzIHdpdGg6DQo+IA0KPiAgZXJyb3I6ICN3YXJuaW5n
IF9GT1JUSUZZX1NPVVJDRSByZXF1aXJlcyBjb21waWxpbmcgd2l0aCBvcHRpbWl6YXRpb24gKC1P
KSBbLVdlcnJvcj1jcHBdDQo+IA0KPiBVc2UgIi1XcCwtVV9GT1JUSUZZX1NPVVJDRSIgaW5zdGVh
ZCBvZiAiLVVfRk9SVElGWV9TT1VSQ0UiIGZvciB0ZXN0cw0KPiBidWlsdCB3aXRoIC1PMC4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEVpaWNoaSBUc3VrYXRhIDxlaWljaGkudHN1a2F0YUBudXRhbml4
LmNvbT4NCj4gLS0tDQo+IHRvb2xzL3BlcmYvdGVzdHMvd29ya2xvYWRzL0J1aWxkIHwgOCArKysr
LS0tLQ0KPiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdGVzdHMvd29ya2xvYWRzL0J1aWxkIGIvdG9v
bHMvcGVyZi90ZXN0cy93b3JrbG9hZHMvQnVpbGQNCj4gaW5kZXggNDhiZjBkM2IwZjNkLi5lYzM2
YzIxZTM3NWUgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3BlcmYvdGVzdHMvd29ya2xvYWRzL0J1aWxk
DQo+ICsrKyBiL3Rvb2xzL3BlcmYvdGVzdHMvd29ya2xvYWRzL0J1aWxkDQo+IEBAIC03LDcgKzcs
NyBAQCBwZXJmLXRlc3QteSArPSBzcXJ0bG9vcC5vDQo+IHBlcmYtdGVzdC15ICs9IGJyc3RhY2su
bw0KPiBwZXJmLXRlc3QteSArPSBkYXRhc3ltLm8NCj4gDQo+IC1DRkxBR1Nfc3FydGxvb3AubyAg
ICAgICAgID0gLWcgLU8wIC1mbm8taW5saW5lIC1VX0ZPUlRJRllfU09VUkNFDQo+IC1DRkxBR1Nf
bGVhZmxvb3AubyAgICAgICAgID0gLWcgLU8wIC1mbm8taW5saW5lIC1mbm8tb21pdC1mcmFtZS1w
b2ludGVyIC1VX0ZPUlRJRllfU09VUkNFDQo+IC1DRkxBR1NfYnJzdGFjay5vICAgICAgICAgID0g
LWcgLU8wIC1mbm8taW5saW5lIC1VX0ZPUlRJRllfU09VUkNFDQo+IC1DRkxBR1NfZGF0YXN5bS5v
ICAgICAgICAgID0gLWcgLU8wIC1mbm8taW5saW5lIC1VX0ZPUlRJRllfU09VUkNFDQo+ICtDRkxB
R1Nfc3FydGxvb3AubyAgICAgICAgID0gLWcgLU8wIC1mbm8taW5saW5lIC1XcCwtVV9GT1JUSUZZ
X1NPVVJDRQ0KPiArQ0ZMQUdTX2xlYWZsb29wLm8gICAgICAgICA9IC1nIC1PMCAtZm5vLWlubGlu
ZSAtZm5vLW9taXQtZnJhbWUtcG9pbnRlciAtV3AsLVVfRk9SVElGWV9TT1VSQ0UNCj4gK0NGTEFH
U19icnN0YWNrLm8gICAgICAgICAgPSAtZyAtTzAgLWZuby1pbmxpbmUgLVdwLC1VX0ZPUlRJRllf
U09VUkNFDQo+ICtDRkxBR1NfZGF0YXN5bS5vICAgICAgICAgID0gLWcgLU8wIC1mbm8taW5saW5l
IC1XcCwtVV9GT1JUSUZZX1NPVVJDRQ0KPiAtLSANCj4gMi40NS4yDQo+IA0KDQo=
