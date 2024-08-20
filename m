Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67F1DDA6;
	Tue, 20 Aug 2024 02:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724121544; cv=fail; b=AaFvF0JBMbW/Dqd1v5f5PJDBAYS0d+sBtxm619xLxUVdNe9HslHR8u2w1sPCjSoK2tzhJXskIh6OfvAOafylPAlIySuXwlIA4MvT8ku/QfLaSrD6M1vZzr2v91OvCjoOn3tWSC11jASS5Qd/Fqpd38cB8WXGHDTYwvLMCaQzvbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724121544; c=relaxed/simple;
	bh=jnzpzKv/IbX1G04abjSqUSONP7eIu4DWCZlDBBRgZz0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mVVd44KD5WgeUP3NiDXLC3PUBnWXSZC7uM0stqI9O4iAhMhzKg9Wg7J0+fDIHxXQLem1joBcgajwDka3ePt1rDxLKnBodZhabl6Z7hezp1C02sCIM7EeQWzNKYUp/7Y/T6OpMjgI5kwGIat/U/+bhEMCswaIqysNEf7jUD8FcmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=VQj3SdGn; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=eMjboPFK; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="VQj3SdGn";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="eMjboPFK"
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47K0436F013273;
	Mon, 19 Aug 2024 19:06:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=proofpoint20171006; bh=Do
	1Q8bNs1aHQ/CKpfyQDw3/nJX9/Ii+zlb1f1703YoI=; b=VQj3SdGnJsg5Ifs0Fi
	gT5o2WHi8N1hDsj7Gn5a1wx4PwxvtdpWXVKlifrNep11/Nk06HRTTH0CDWHYggIH
	3x1MHQ0wljWDuAiRrgWNajaftUVJLDC0Jaf806dH7RiqKQUKyJ1VHOMjSPf61Tyt
	a0trkRsqhsiMyKIxIbVyIgIJtdVWhAi8F99EQHIsvOzsuHn0ZFpuGvc4r0ni5v00
	3MpbcCYl/DEIfvGvmHvXaI+ayM4Ws0gUm1l59wgubQwFeyHnmjipZwNgjonoxTPq
	1LYqENvlh9JP/eWoiojXDF/fIt7WFePtY0cmgWMP3gkMRg9N0d6DD/amMZSYdkDW
	KYSQ==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010006.outbound.protection.outlook.com [40.93.1.6])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 414g9c850m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 19:06:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dqUTR7pYEZ8CcKyBp8Ig3eWCbxBZORmr8FE0QHisF5ia33b9CLlfEoAAXRZ3mAtV9j3a+KskZl06xRWfeG58pJWSamPPyvisc99ofpQ82zD2PjqLBEwqGulvEwJXcAWRMDtkCyep/8dbe9DwTrC314Uc4hzqgmqIHfjx24Oz+3IsOo4Nc/fc+EU04aM7tIC7AD2S78urUepeLQUGLt2xkbzsPXIh41kX0nM15N0CEsQLCUhM9WoRKmrRN4SpslN2FODtX3dsil/d98zANBF8cN5vUYY3fSqJCWY0kAF757wELDm8PdAmT8RwZzgp066tja8OFcSjWwdhYXRwztmvgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Do1Q8bNs1aHQ/CKpfyQDw3/nJX9/Ii+zlb1f1703YoI=;
 b=VXdN1X5uLbiwAIBSwah8wFTR6n3+iwgWx79G5XkiTVjrv+wC+6b/WGFtDAXDjibscbnm/ofqSkHrWPWkLA3rii1pmu7GAZUNcVvepvvpR54PDJteHi9+ZzWOexRvgDJje6SmJF9L0xXoGCC8CAT6Dq3YMjRU7D7OgBo+DlDgejC1y/sCmqDB2JRjt+p2tNo5z4VIWkUF6T4JKzoQdaS6e+3eCWDFDjPi1639bm9mD7JDAK84J6tiVOsLSowgyLcA1aI6bj0X2NdFmAJUjLkDGWESon1e+zlqdDCmXZuvM9avCcpwRznQpoSimjyzyMcrj4bTzRSf2N4BMs/QGrqIxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Do1Q8bNs1aHQ/CKpfyQDw3/nJX9/Ii+zlb1f1703YoI=;
 b=eMjboPFK7Xb1QPCqhLLRsWB10P5McIKkFu64tPzjVdssFpDQuPUO/K1p+i216C1l87iQ2jXHnUSzbrzIby3MohQoNdegQQO0V+Pr4B1IQWxTfJopqqVLSldFJOtivMEGz0PigjyMARFCNsC1oPSyEjfFHBivN4/9N6LEMe4ZU3sGyf/EmiNHcctSxA3SgLz1AgU3zjSBzZBWA9bfXDUsGoG/DPslFwVgOTrZ6X4YQCu2o/oZOAyCOyxOofeRJp5oTM/dMUWDqc5BOPFv/RGteHgrp4DGMbEKsCePcXzqqdkT6yzUY3svEIHkudKmVipI0WI4kAAAafBJ7LxXA1zZPg==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by PH7PR02MB9968.namprd02.prod.outlook.com
 (2603:10b6:510:2f3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 02:06:02 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 02:06:02 +0000
From: Jon Kohler <jon@nutanix.com>
To: "irogers@google.com" <irogers@google.com>,
        "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>,
        "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kan
 Liang <kan.liang@linux.intel.com>,
        "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>
Subject: Perf test failures for 10.2 PMU event map aliases
Thread-Topic: Perf test failures for 10.2 PMU event map aliases
Thread-Index: AQHa8qWBct5+ffWejU2LkyYAIOgQ5g==
Date: Tue, 20 Aug 2024 02:06:02 +0000
Message-ID: <05E55194-C265-4BDA-911D-B9E57EED3CBB@nutanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|PH7PR02MB9968:EE_
x-ms-office365-filtering-correlation-id: 71e44072-06aa-43e0-9e78-08dcc0bca43d
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?TfAsQIfoGM87RCvpr1NXs5QtOnGpNd+3p0GdarIvM8XY/JYqei0bZI0jGOCk?=
 =?us-ascii?Q?9erJfXnFieCE+s+93PZZAf93N0+FKviL2vbAlyFT6yvDNlcIJ/TgUDeeg36r?=
 =?us-ascii?Q?Z0Wa4GjKr+QdiiaqYe4NW3mse0OuhSyL4mHdnmgAsNYewruJ+1HPvvTituoi?=
 =?us-ascii?Q?W1XG4QcPCyBclbZXPG2MySSuogqIlRx/BIqtSNLi/0/cEf77PnZSk8QA1MeH?=
 =?us-ascii?Q?QkU/PbC7h8EIMcJedepGRg5mqfUwMcdggDfuRk8u4okc7hZUB4T2G0KBzaRA?=
 =?us-ascii?Q?DZ4N9cK3BhnJo7bIIlyjxPOk8TRDoudM8SwqtT2kyZFGT11B85bEZuPuX9zy?=
 =?us-ascii?Q?Li/v2MDPYxjkOtTna24hjSQCdcOf1XWYR3tER5hrdFla7l28LyoR7AhnbBB0?=
 =?us-ascii?Q?kZ0Y066FE9HCAPwqaAA3Bc7KZHx7ITIEqlwHFEAidiwLNPF5irt7gdyaYUK8?=
 =?us-ascii?Q?opuwpvNbGL9bFyCvXhybjJkIflUc8sGqetwUsdXKB8ETlC2vkdxn8POhq75w?=
 =?us-ascii?Q?Dx+2FCG8fZsI/vxr0NpTOUOCUVO4NXq7lfPfWnIGdxmIrr8GTRww23S0Jwk9?=
 =?us-ascii?Q?VSefTkoeHeeoC/NP23lWudLgjfkx58p4riVUrZvp0m2OKBUnGsJAdB6nH0HT?=
 =?us-ascii?Q?aA4jCgt5C/gSRnigptVll3TOu2gdhOjl7CiOs5gMOcCRa5dMr/uFWeB8J5xE?=
 =?us-ascii?Q?QfITUUDTeewQ6BEl+uWrY8JuphiZUzL4C9MZsUyp9WbOpRVTAxgx8y4V4sEn?=
 =?us-ascii?Q?5/wAuPORAiqC7YB9YdmX3Wi9YsKYnQU5bdDWSArZMUedpLyXG9xm/nPkOue2?=
 =?us-ascii?Q?fUEFro9bDa94i/gClTzMHpRMm8x6HohuHN72ncHrwc0wCFpwov/uS/QlUP54?=
 =?us-ascii?Q?nNK7eYVOGt9AzHRMIJl9F3fwrxJVTlMUQLRsQj/Ov84r2yZetp3mhXmfHrNW?=
 =?us-ascii?Q?WPbMvVu/GzvkSEaP3ngP8htV8CCtnNNEJy2w4LEafDoTp+4Z51xi8yfuZTB8?=
 =?us-ascii?Q?oYONg9yRw9etMZ5nhsiwPD7GR39kGyCifhEDxTsHsRL0ewxO93g+8W7yP8ss?=
 =?us-ascii?Q?9HimVqabp3F4DjRBkjUK4DwAeYnNKBvmnKOKSZoLS/Pl5wvdml0EQqPwvK0A?=
 =?us-ascii?Q?ipKN5whn/oRgBosiN6rOR64x2ugH6E8Xh+jXNIqNq/X29uFjPRDGxd3TePH7?=
 =?us-ascii?Q?z0adf4bHLYemy+WjdBFVQmr2L3MRz6DBvf9MB2vIoXymgKjfSK+cN96OtfG+?=
 =?us-ascii?Q?ioCpXwJSBeBgzDGOgxI+RHIPjEEgZVpzV5ZL8QQgkiOgSoqGK8DgY4Mot3hB?=
 =?us-ascii?Q?Ql51+aERIE/yOAsTsnSkaZA3ZYZ1xHta1eyecsNO0qMLPL28Sq3LSCkBuBI0?=
 =?us-ascii?Q?GO5MTVz2NKeCDbf6B//gHjgvOLtRJamnKLkHpT4Zqi6pkptsFw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mKNBsxBrjE+Gu1KueZd8OEqy3Joqgf+a1zfrUA4e6jXHCS2qZkaE/Hx7LhQI?=
 =?us-ascii?Q?lbkMEFC5/Dmp6wdlQ6FI6xB5IOSM/r3Ok2H3BRX8N1VECfuMwGiC2Qg7YjoG?=
 =?us-ascii?Q?oXXoGHUwqfvrfVujMOjzbnkfGIp7TZfymvVM+ML0IedE2obywfWODVz7exyh?=
 =?us-ascii?Q?TBQd6iicy9DMyHT4sl3jiFxKdmDdrQY6xBVn+a9kjK5FKVkvNpJUA0jWwrjJ?=
 =?us-ascii?Q?M+kKuhqyLxm8B5w5kvGA69yo62GmgOT9cEqw0qKsa/JGBEQIH4B1cUDwo1oy?=
 =?us-ascii?Q?dxiR19rq0thInJYZfqRuYlaKqPx0amGTnhGMCh/t/udldV58bcx2xuFn8X7t?=
 =?us-ascii?Q?Mz9BApauR83OF7ngPHd0mRz6euuf/9w65mzfYYOQ6MTwVKYoWCePvdBxN2Zq?=
 =?us-ascii?Q?QdkNR4LWlMcaFOdMoObsEsPNwxG5ky3j0QZJr+S7v+Obi2nL2TEkXr7kv7HX?=
 =?us-ascii?Q?Xa8tMXLlG86h1S1e0HPKdJf+PV9nSd56mdw6lPi/WHAIiPYin/Z71XoY9O1I?=
 =?us-ascii?Q?d98YIOTQAGTYz9UNHGd1zbBW4MajOWzh5Z7qRVa5AnkFKWm/LmNIMPVxWkuS?=
 =?us-ascii?Q?xxrf2GO7eeTsnYXgsrXLelRLOIvYNEbeB2+yCbJNMg+JXjYdf/cotLldwEyy?=
 =?us-ascii?Q?1Jk7yfpY7s9lk6Ru8yvI150NwoMru4GMImkriEsBXWwfGoqse72ESG9U+rdB?=
 =?us-ascii?Q?kg2rzemLQ9cna6/E9HA0I7xEsTup6bFCjD54TsXnH8kvo40FwjyxuWqoo9hA?=
 =?us-ascii?Q?s2mxxPSHTa7UL3Td1pXpdwOijVIhteE+PMKjKkU+OVR8a115rEdSf5oYSrbE?=
 =?us-ascii?Q?DVJ33Ajr4zGCsA8EpWbYy6C6LpgixZ7jp/Yd8Zgu60SuOF4Jqax5V612FwPd?=
 =?us-ascii?Q?4REPQDsubf7uOsYiaISQ337vpX3kfjpSFbQ/URxe3QkJGditD0OPfSamMvBt?=
 =?us-ascii?Q?XQiDVQqSzdbpCukJ7RRRSkcWYwa/kT9o6Fspz+isr7zSzGurFNbBz/1M6F7W?=
 =?us-ascii?Q?YxmOgQgYGul6fZy7K82UjyqyvfjAsUu4NNja06wQfePDL65GUuZGe1d2iAjM?=
 =?us-ascii?Q?HJ5M2mvjWu++ZD+yCt2ijj0nMVz6SAdWqsEerJfwk21T2kDT6NY9KF/9QpcW?=
 =?us-ascii?Q?2CnXYAgLlLHMbT+Nsb42fvuh0/qLjG3Cle9AV965r5XE/yYx2efyOWtr3x33?=
 =?us-ascii?Q?v/3CEma/fGC2JSyDzodDuXz9spMbN8Y7vRMpPLQMHkO/ulXKOYg2JPoV9Hly?=
 =?us-ascii?Q?51dqyGPnSYp2HZxGsSzWDLZJl+Qaf9zL0lb8iHeQZ7CLQACX8B3EUmUZ9a1i?=
 =?us-ascii?Q?U7jFnXnhpquZa1aXWFrt5d1Anu1IeGhMI6XCNv9ziSdDjFZgGMPnTIScA3ld?=
 =?us-ascii?Q?I8RAlhTQDLlm9C8JZM1jF+IMTRN9Ww3vif36bId60Sz/0R6377LcnAQ2H6yd?=
 =?us-ascii?Q?goU49p59RWKzEGrhgfrPnxBeHZ8arHdUTcF0wQDw4zz2+2DwhlM7J7Q7FtuW?=
 =?us-ascii?Q?a7kgUGkIeKYbWEoNHkyBkVaGRGUm0csc0xcKazm/Y8bn2x/tluOSInThMwyN?=
 =?us-ascii?Q?0r2xAzSBD3BW1fvEpkxyXNjkf0i4nyQULzQ2k5zEeD60KMiaPzCCAhObLpBQ?=
 =?us-ascii?Q?NEb7aMrcCCR34G60HW2bEVHoRMAXTYkLk+wxwYCFM6dYxcX/vMZmdxNdiluW?=
 =?us-ascii?Q?l+Taqw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3642CDC9C2CBC748B6402392CA63A6E0@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e44072-06aa-43e0-9e78-08dcc0bca43d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 02:06:02.1200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cKwNNJ7fk9kVoAIjXjUdqBPYMQZRcUvOQj54Ut3IaFiA5ePvc26P685Ct8oA1CNBOlmQ9tTF/A2k/m6FBS8JlwwoDWqof4w3rcbV5TUUIPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9968
X-Proofpoint-ORIG-GUID: dxYC00gQeyAtIh_Eod_sXoEs7MiJMict
X-Authority-Analysis: v=2.4 cv=Fellx4+6 c=1 sm=1 tr=0 ts=66c3fa0d cx=c_pps a=CbxOEkXH4sIw/lcH++vrDQ==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=yoJbH4e0A30A:10 a=0034W8JfsZAA:10 a=WDCRTbNhc3LI2kzQcNgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: dxYC00gQeyAtIh_Eod_sXoEs7MiJMict
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Reason: safe

Reaching out to the perf community for feedback on the following
observed test failure. On 6.6.y, I see persistent failures with test
10.2 PMU event map aliases, complaining about testing aliases uncore
PMU mismatches. I've included two outputs below, one with a bit of
hacky print debugging.

Using Intel(R) Xeon(R) Gold 6154 CPU:
	10.2: PMU event map aliases                                         :
	--- start ---
	test child forked, pid 962901
	Using CPUID GenuineIntel-6-55-4
	testing core PMU cpu aliases: pass
	JKDBG: pmu nr total 3 pmu->sysfs_aliases 3 pmu->sys_json_aliases 0
	JKDBG: pmu cpu_aliases_added nr total 4 pmu->cpu_json_aliases 1
	testing aliases uncore PMU uncore_imc_0: mismatch expected aliases
	  (1) vs found (4)
	test child finished with -1
	---- end ----
	PMU events subtest 2: FAILED!

Using Intel(R) Xeon(R) Platinum 8352Y:
	10.2: PMU event map aliases                                         :
	--- start ---
	test child forked, pid 1765070
	Using CPUID GenuineIntel-6-6A-6
	testing core PMU cpu aliases: pass
	testing aliases uncore PMU uncore_imc_free_running_0: mismatch=20
	  expected aliases (1) vs found (6)
	test child finished with -1
	---- end ----
	PMU events subtest 2: FAILED!

Digging in more, looking at pmu_aliases_parse, I see that we'll discard
scale and unit files in pmu_alias_info_file, which leaves us with 3x=20
aliases in the uncore_imc_0 in the first case and 5x aliases in the
uncore_imc_free_running_0 second case.

# From 6154-based system:
ls -lhat /sys/devices/uncore_imc_0/events
total 0
-r--r--r--. 1 root root 4.0K Aug 19 18:50 cas_count_read.scale
-r--r--r--. 1 root root 4.0K Aug 19 18:50 cas_count_read.unit
-r--r--r--. 1 root root 4.0K Aug 19 18:50 cas_count_write.scale
-r--r--r--. 1 root root 4.0K Aug 19 18:50 cas_count_write.unit
-r--r--r--. 1 root root 4.0K Aug  9 15:30 cas_count_read
-r--r--r--. 1 root root 4.0K Aug  9 15:30 cas_count_write
-r--r--r--. 1 root root 4.0K Aug  9 15:30 clockticks
drwxr-xr-x. 2 root root    0 Jul 17 03:40 .
drwxr-xr-x. 5 root root    0 Jul 17 02:52 ..

# From the 8352Y-based system:
ls -lhat /sys/bus/event_source/devices/uncore_imc_free_running_0/events
total 0
-r--r--r--. 1 root root 4.0K Aug 20 01:44 ddrt_read.scale
-r--r--r--. 1 root root 4.0K Aug 20 01:44 ddrt_read.unit
-r--r--r--. 1 root root 4.0K Aug 20 01:44 ddrt_write.scale
-r--r--r--. 1 root root 4.0K Aug 20 01:44 ddrt_write.unit
-r--r--r--. 1 root root 4.0K Aug 20 01:44 read.scale
-r--r--r--. 1 root root 4.0K Aug 20 01:44 read.unit
-r--r--r--. 1 root root 4.0K Aug 20 01:44 write.scale
-r--r--r--. 1 root root 4.0K Aug 20 01:44 write.unit
-r--r--r--. 1 root root 4.0K Aug 19 21:33 dclk
-r--r--r--. 1 root root 4.0K Aug 19 21:33 ddrt_read
-r--r--r--. 1 root root 4.0K Aug 19 21:33 ddrt_write
-r--r--r--. 1 root root 4.0K Aug 19 21:33 read
-r--r--r--. 1 root root 4.0K Aug 19 21:33 write
drwxr-xr-x. 2 root root    0 Aug 15 03:15 .
drwxr-xr-x. 5 root root    0 Aug 15 02:42 ..

Looking at the structure of __test_uncore_pmu_event_aliases, however,
I'm not quite sure how this is supposed to work. I've annotated a walk
through below to highlight where things are going off the rails.

static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu *test_p=
mu)
{
...
	/* Count how many aliases we generated */
	alias_count =3D perf_pmu__num_events(pmu);
		// alias_count =3D=3D 4 in the 6154-based system
		// alias_count =3D=3D 6 in the 8352Y-based system

	/* Count how many aliases we expect from the known table */
	for (table =3D &test_pmu->aliases[0]; *table; table++)
		to_match_count++;
			// this is looking at aliases in struct perf_pmu_test_pmu
			// table, which for uncore_imc_0 is a single entry for=20
			// &uncore_imc_cache_hits.
			//
			// for the 8352Y case, likewise, we only have a single alias
			// in the table for &uncore_imc_free_running_cache_miss.
			//
			// in both cases, to_match_count =3D=3D 1

	// Compare 4 vs 1 or 6 vs 1
	if (alias_count !=3D to_match_count) {
		pr_debug("testing aliases uncore PMU %s: mismatch expected aliases (%d) v=
s found (%d)\n",
			 pmu_name, to_match_count /* 1 */, alias_count /* 4 */);
		return -1;
			// we seemed doomed to hit this conditional always, no?
	}
...
}

I did a walkthrough of the latest mainline code, and don't see a marked
difference that jump off the page to me that'd correct this behavior,
and would love a helping hand to point in the right direction on this.

What am I missing here?

Thanks all,
Jon=
