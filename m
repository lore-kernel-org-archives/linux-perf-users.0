Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793724405;
	b=NBHZIQIIsbgSlUxUUV1tKchng7VTjCVSqUtyg5QOMAXv+U+b7pOX2HLDIY93pnDGf8H2
	 iArjycT3I/SeTkg8ubkJzlq48Og+4yfp4KQ1r6PDYJRrN8cr+vEdDoFbXDRu22ywCrq8A
	 m5mbc6ECtbsSmoamDTj+JxvpDk1FOdttH1/cDZ1R/FyNUIu0fFAJvSL6HptSHrl0M806E
	 db9Xqvq0+8ZchivN8PZrhzcdKlefUduULvQPwmY/NL0JrL6o35tYK2+2TvDFbfiRw6VdE
	 zj1Kc5pFhbtMpexH8Kgp5Uw9wrn9pIzLzkQyvGoG0vIH6UjyjrwC9BuD2/XgpEdz/Qw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724405;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID;
	bh=Dy1P8ECNa7Aa8p84ZITqgKGVGWXxFvggn1/sELnYZ+s=;
	b=INC+aQPWiCtRgH6IDuwl1ZY67DwSD+j+TpKeSt1RjzWgiIy/joMo1jqHgmCMiqpnU+Nz
	 SImVmlX7U0xw7aJMrZP1fNxhlqvi3NHP9ZLXS8gDOPt8C88+a99mP8s7pK/ZmlcXWjH4Q
	 LAmir5VUNu8Zpq6VG7q3qC0WlELw8IwB8G7ZYQbl9BgclbLmCZKJPZiWAWATIqiLHluST
	 hBurhnR1EVj/6uZoL13lY7gZWOmKvmQtQIjJGqtEJQX21WyLktFg9eq3UR80rhq/CuRPQ
	 c0dxiULAWa+qyN/LAO8d9U5W36ki/vLchqIwZ/Ve2kK3Z8z3QmdI3nu3Am+ECm7EB2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b="iz/Lcj/r";
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b="XQ8/qwq+";
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EF0606A324;
	Tue,  3 Nov 2026 16:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1EF0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=iz/Lcj/r;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=XQ8/qwq+
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3EAlsh1539825;
	Tue, 3 Nov 2026 16:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Dy1P8ECNa7Aa8p84ZI
	TqgKGVGWXxFvggn1/sELnYZ+s=; b=iz/Lcj/rriyEOTf9EwRAaltgc36MpOd2ID
	M+QCpl+qbxHYaQNiiGwaJSnGGgy1s70YBwqS0GEYb5XB3Z4JEw8HfUtXAitTh/4g
	2cLTRxwyZZ/xE+pQqMd4OrruJ4Q4b9eJWrfq/NEZRq3Od1S+tVGFT4MyvCCtpf4X
	VWSjoaI1jW34ivlJfdhzie7byF0sXynPHBB/MXP8cIRl3I63C3vm1Kt/Mu5pVDxG
	u36VweCntHJAusD9/L6B1YJyGw9lKNxwfUD3lScdJVoU22l0a5kVN/1sjeLl8Y4l
	FUeSI52uqtdYsSTcU64XA6LY8H3JhLVPpjk9gqR4U1MJV4e+cLyA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn78acmu4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 03 Nov 2026 16:46:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3GgCfl3029112;
	Tue, 3 Nov 2026 16:46:23 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010017.outbound.protection.outlook.com [52.101.193.17])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4hqhq4cfx9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Tue, 03 Nov 2026 16:46:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWuNbbJugD2hJ0bBHh8m3BQgJNVhBY9HF8j+UgXoCVxyYPMN97rQgR1mHlU+AL3CyztfNUGHem1wiGJp7HC7gKzmiBTuIP+C2ztG4iUmHU2A8MQU0VtLh5drGn2H6oExz6SMHMaYXmCKNMWq48OZLIIQ2+hRwa2Ziv6/boc7u+f5JF9WDctGLUwDVSVVsztGIeEH4vW07sFnMAREOfu48EzBUbAgPSrIKFfPwqxi7dlJsJplMpA3jMaxtIVtaooSTUiNZ+QZtHjYPdvMhcy9rKGE9fi3TXeXv0hk3G2d1zitDBX15xEqFEREMbDdngIN4ddz/nuIX9OPz5WeAdPskQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dy1P8ECNa7Aa8p84ZITqgKGVGWXxFvggn1/sELnYZ+s=;
 b=C3XZXlKK9scyKLwZKhxyBPFiC9OARFVB9SXcs4QB/pdTzEPdBZ4Ew0Nn+sRqqLvBtdvb5CJrx3fPLjtS5q6ZoRvuBOOE+4BJaDN6aasfyV5q9OwO5PqQ9n6gSsC9oW4qXmyvcA5EyrJQW7YcdIrldycqU7mGv0kH5AbWwivaZWtfmOy5V44XdVhCH9MHNrhKJwMYKmf3nzPRtvi6Avp40QrE2ANzLjxJ2aPX0f9a53dzCrOgZJjjKygcTppab1TDkpldEp9WOQZ6Jp+VCcNhe11oWoiIWgXffbO9N74aLolHmufI+YkoDBdZSMEV3T/TJ5KOYxJEzCrYWbeaNdaN4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dy1P8ECNa7Aa8p84ZITqgKGVGWXxFvggn1/sELnYZ+s=;
 b=XQ8/qwq+Zj5UC/W2el1qNRhMypWbVfkJMB/RhZCwZ4DSliPyDFc8v6BYXfM4U6ah4ZjxJAYnOaT7H8PvbUpPApG2atsmdSIDZ2Bf/p8pxiaMnbi8mSFPXf+4h/YVCjUSPAgcyvYQbPy301FSVr6sMQcbNCqxsjCC4feAPh8JzJM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2557.namprd10.prod.outlook.com (2603:10b6:805:3f::22)
 by IA3PR10MB8090.namprd10.prod.outlook.com (2603:10b6:208:50e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 16:46:18 +0000
Received: from SN6PR10MB2557.namprd10.prod.outlook.com
 ([fe80::fbe3:8d9e:af79:5c73]) by SN6PR10MB2557.namprd10.prod.outlook.com
 ([fe80::fbe3:8d9e:af79:5c73%4]) with mapi id 15.21.0546.021; Tue, 3 Nov 2026
 16:46:17 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim
 <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
        Ian Rogers <irogers@google.com>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin
 <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian
 Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] tools: perf: allow opt-in "no-dso." files in /dev/shm
In-Reply-To: <20261013213842.1870582-1-stephen.s.brennan@oracle.com>
References: <20261013213842.1870582-1-stephen.s.brennan@oracle.com>
Date: Tue, 03 Nov 2026 08:46:13 -0800
Message-ID: <87zevpq2wa.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: PH8P221CA0013.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::24) To SN6PR10MB2557.namprd10.prod.outlook.com
 (2603:10b6:805:3f::22)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB2557:EE_|IA3PR10MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: 2af3d591-db72-4677-fd1e-08df39c9fa4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|10067099003|18002099003|22082099003|56012099006|261022075727099003|261021121427099003|261028144727099003|261022105027099003|261021135927099003|261102123227099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	RHx3lNgo/uGJixA+t8sxCil1gPeBkJbs4nAn++y8mM9cMPttTRzXsThftN897OFiTVucpbEVJG7TPRQtpoeI8eoKoOr5tvVo1bhKkO2dgLTZ/bzA4RQ0unv9BwKpWhKIlVdwlDg++fkOW+0jfWNNactTU1Yf0w8ofD1QhHl1WnnvtDXGrJObA/MOIklL1ikv9g/byI9oGN/qBwRfIRjNjotaqVp75AvcU4udvKF2g0wFtD3lnImRU2Iu/k1ec/Ej1J8W/JzVqzXvkjW9lwT8F4PiqC0y3MIb3IlJEi7Mh/ydKR7sSUKybwkIQBYiuhH9PRgjVNN26MHUfuCmId8J2RDDPS4Rw1IzRX3u/zYXH2ZQn4S6AoqrmhtH0x4M7v/7FKO6Y2HQczdvEmTDERBP4rsYaPGDJ5DwSvxwstflEiyiNinsiI4mQuQZNy7Fu0aKCiJdSqm0S2k3gKkB9JIzWaT2rjdWI+5XzhTCIAgGfjdd7iL1xTEdWeeS7UKFKIWQJ0MAb0vFdhT7XkwerX0XgkQiAoRZSCn41qBGmZ9lG/A3IDeIKg9KI2b1gv/4To3idkdVDFDlFMCYEojp7Xu0lLM5wuLrvC30IlLSebq1q82l9CzsemWwrDX6k9ZBJb5xxxMJ3nVHVu32QP/wnvFo2XYEu/Jk8kmrLoTKd8HQaCY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2557.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(261022075727099003)(261021121427099003)(261028144727099003)(261022105027099003)(261021135927099003)(261102123227099003)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5PbQFqF5oyHcmbMjd40S5gkvHVdRBu/MiuxySSc4mM6s3gi6IGrUoPPlqcmx?=
 =?us-ascii?Q?EeMUqMzVLVYEj6aV+egcK0W3/6io/IQVKVRdMq9Js3xcGr1SZekJie6r1oBR?=
 =?us-ascii?Q?N5Ska4+745BKmOsJBYeEIcLt/SO9Zyrf/aRY/wOnZPF6SrGdfAtL29f3cctO?=
 =?us-ascii?Q?+A76UCvR88NbXcj17MptglQyY4AdAiKdgajO19Xx8I8V7LldqlFdEZ5Hz9TG?=
 =?us-ascii?Q?hXG1VobAjZOt+70XKTUbMqO4BazDydBahAEaXD7CpzcHXCAr97sjSyssPIWW?=
 =?us-ascii?Q?raVdmHHiMJCMJV0xFUvjQLX3ugQpBdCPlBI42u2XB+mJLDpaO9tIJuslhZEl?=
 =?us-ascii?Q?PLHJeYwS7PU4NtZrHDlaQ7xty17255juMd2GY2NGGmWfz8FfKwMP9aqn+n/L?=
 =?us-ascii?Q?dKa+EwnssPy90kkeJY/a4/yYTtbyU/mqYlltt6rqchRwwLFaIk0pQ2dDJC/7?=
 =?us-ascii?Q?0eVWE8vaGLEf8CjONH5XqPu21bfc7hfqLJUZeFo317hVPY+idDrfsud9u6kl?=
 =?us-ascii?Q?DbVVPMZELI1V9RcosXGPo5XWVJcLUXnMVFQ2Hie2gWjQIl9ylT1sTctq1v/h?=
 =?us-ascii?Q?WOFoa1kwvuKG6J0/Dr06kgejUjjiDb3vPodwZhAjfUYvOZn/34Wqmv/0dK1W?=
 =?us-ascii?Q?0/wy4L0Hpt6Sg/5oRS9jER3fHMzZwysxs9qgH/h6W4EUVbqgT90FztFHmrXa?=
 =?us-ascii?Q?NL0S9wbcqcYEh1/ki7tO99H2uXFyAh12ZIh7S7VDvsGIeGPAsS76OFFR2T2G?=
 =?us-ascii?Q?Z0XECTDtjw8YspwmEr0vqVMHv65wKRRL1ZVHF1EOx8QrCi9c3fFYXobOm8/L?=
 =?us-ascii?Q?jkATABAiTDD7udVP6I3VKJzW7G+0Y94fcsk28XtqY3mbGSPDtVgseRVR9jzz?=
 =?us-ascii?Q?TSGYCl40GgvuGmhTqwuPOX7+Qar6acIB4zyPOFszHl+NsxLN92e4aDM7jdNp?=
 =?us-ascii?Q?MKj+cIB94b0qyGV3xoOgGBOV0GaC6L8maROPxWIx/xuNU1GpCTuSXQ9eIYIQ?=
 =?us-ascii?Q?sBVnXQkgCSlY7DsyjiajfWls0MAf9xeshyN1L4uqtrXV+g5gqT4nuLnHMNJD?=
 =?us-ascii?Q?kNKy5gtUKlNVBbkuL94giAapHmu/fhVSHMFjs6o+o1PU2t2UDnxOTL+Hq8tz?=
 =?us-ascii?Q?NwDgzHJ9QCGqZb4Gr4jl6Yjt+PsrtXPwO+sk/j0mRO6VghA0btNz4/ME4hyA?=
 =?us-ascii?Q?vC828hlHYritsQ4ylQwhFJCn5WJaNn3XFQDbjNv8YQpzid+CRAfOskkxnp5m?=
 =?us-ascii?Q?vbvnpaTxwAcG5eEV4FqzmAsBVQiEKVpaVLKKXYb+chjUBXtHSqLX27x9gPMV?=
 =?us-ascii?Q?coKwDJgRdEYMWgKuY6O8GqLRfCgAN3/UVKd1jIXPGkrQFHVvFVrNI3V6lmKj?=
 =?us-ascii?Q?BYaZMzNHvmggXhfBcqD5t+SIGG6CFe0LhungDk5ho2tmOAzFWN9CJlig4RM8?=
 =?us-ascii?Q?sKcRb6OP2DkGD8NVtlDe4ICPwxzGCo12EKxLckr1kF897X98UisOUyId/d/N?=
 =?us-ascii?Q?pOkuFsIrOvfVfBa11u+rBC4hKMqvqb8ovEMbQKYRr+Q3jcC/oteTOskSx1Gq?=
 =?us-ascii?Q?0/1FCeB5kTe6vZ6H+WJAvCYX8BTmHwQEMdCckO42OCOUaxoXFCKj5havaZHG?=
 =?us-ascii?Q?I6sQ1TxKNr5Rz6/j64SYjArNyLKzzMjUIx7pDoJpSYLAYE2MISYwYbeBgOag?=
 =?us-ascii?Q?oAmkJPajDhOOOV4gQEv18uv38LXkS2MYs63jn9DoNp6U8YZ4Wr1dol16tB/I?=
 =?us-ascii?Q?qy9UW50YI54+/CUT4gLx+aP7aC92etA=3D?=
X-Exchange-RoutingPolicyChecked:
	W2PphsYDBTmgblFGUYcVDDh44VNh1/v/WMlZ30jAvrkgpcTG8HkhgSAiocDBvCkvynqTIyV/XNxWBTfskVVmQUn3OLqhNzO+/jyEtc4Mg3XjAUQOvodP8d77zrFuiV0oeMk1W+kIVaWR4817mLgoecMwvZURO4lUrLAGsNstE9/HIMzsQPxFvvA20pah/iyL0NF5FAA3ordtEbQpGzws/zDe0oDOOo4oe22aZEWzIFlgikSmsrXGLGXJFHBQBOMq0b9LZQLo1HTbYEWR6Evbxqqw9/nlrpoaQ8F74zIvhgtRt4UKGOcbH47BvI4ONiYzvZvT0/XeSipoq+VqVSmTAw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Si8gOCq2otkfuWOyo8Gqq8wFLtezGfxDwaHDF9ylczTIDgQz1KpEJiIkTRapBUUfZikruwRw14eroKzviHos0kWGFGt2g3tpPu1cWSqmsT/BkLOHe8iQQvmuP4bO4HCCkndvEAY/yOXYH1jyJEmVV9+/ayNtvfIoxQa9fYLZbpA7wvaV75ZGzweGMr4RSMP6MposR8XTSmiWy0OdxuqAYc1DEWs44QnU0jlhEjzTrNFCkYq8tm8IH1gVzCI79ynW/Og9SSd9KQx2VE4uZnv0R+jgYndHjpa2aCWBDESgaS1x1SGNG2txBBXFRGV/0OE18i/So51Z0ndbQNfqyDcrmJOxBQSu7yFECJKMqgBJ3lTuFAE3Nigvkbpwrow6S4Ma2CoMhiwxvUK9/CMfOilmvENKmmQBYA7IdirUa6Q0bG7yPh4iJXyLpaPp8YpVIt4e6iilb0nSEuEUgJxUPYHCSXCqoWqCXhQ0HjtL2bNpMYY+xXpsWHumqgGrQ+Ot8b+qChCSJWhTwncbIGfUXO8lLA/hOJzEldCpSm8OWzWHDxWdoCtHECyVriwRzo9raGy+SeeYm3eiFvjepWQNKrqy1sH1gPuPFWZ2+m9CC1pEIaw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af3d591-db72-4677-fd1e-08df39c9fa4c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2557.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 16:46:17.7986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AgdLaTrruAz0gTlpaZtE9KhcOmWitllbaez1wiYi9LEPnNtWi8VcyNxeCAC948pQ6Xn87HoMRkGxxWeFCOAuIYjPcCGFgsPRJCP4OzHg4y4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8090
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030066
X-Proofpoint-GUID: 9eORYRcKWUrfuAIq_p2pmnADeqKuYFCh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2NiBTYWx0ZWRfX5+IKtnunN/UP
 /3oMRErJXxiqZRa7XrN1wbvnUuU23TxYVc92NuF5B3sgyJk1rUyJ07L8D9l4mPvgRADFoGDSD6d
 xyVlD77ZYMOLV0oakn2PRozimjw/HiA+Fl3QzFgN8A2j1bjaFcVu
X-Authority-Analysis: v=2.4 cv=Mo3HeGae c=1 sm=1 tr=0 ts=6aea0fdf cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=6-3K_0_krEvAdeM0YcQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2NiBTYWx0ZWRfXzBguEqSAod1Z
 KmLv8PCquZCQZDrJrVanCtuw8uRiJMpvdLKeCqGCkHt6D8C1/KB9ZCkpcfsNFYi86R2WL1Ymule
 5M2EnS0cm4s42ZBNVsWqSBMcOdwtxH4gveuYQee5sldn5sb6Z/8y4sCDS/s1q8i2ivHT1G/+tOW
 eEVUlWBMe1bBHdh/xfa8Er3EjtZhvkyC8XnEJ0+lL5490pA9L+AWt7eNMSaff+4G14jB3PzPNab
 8iSN43r+R3WAEp77b03Zxxh2AmagIh3C75nFjD+PvsaAOWBhkoAelHc6wZrsVSCdVKrNrAbmWie
 UWlsx39nuqVj81o/D3KyRb/Cy65NlJgrlxZ4E2wTSR47S0r9gXkwfWFxbkoOhnAB79pSfQs5Fi0
 U9zXi1cXiDlwUe4nFP8jRQhjybdzh5McQYSpJBuGy+AXpUtVDT2IMrvu6gnEMRZqmDfww5JNp7t
 iTQxeVu4M5Iyr3KFdxw==
X-Proofpoint-ORIG-GUID: 9eORYRcKWUrfuAIq_p2pmnADeqKuYFCh

Hello,

A friendly ping on this patch. I know it's a bit niche but it would
resolve some real user issues with how perf handles POSIX shared memory
regions.

Thanks,
Stephen

Stephen Brennan <stephen.s.brennan@oracle.com> writes:
> Applications can place JIT-compiled code in POSIX shared memory so that
> multiple processes can execute the same code. On Linux, these shared
> memory objects appear as file mappings under /dev/shm.
>
> Perf uses /tmp/perf-$pid.map to resolve symbols for executable SysV
> shared memory mappings, but it treats /dev/shm mappings as ordinary
> DSOs. As a result, applications which provide perf-map symbols for JIT
> code in POSIX shared memory don't get those symbols resolved, while they
> do with SysV shared memory.
>
> It would be incorrect to classify every /dev/shm mapping as no-DSO
> memory though, because /dev/shm is just a tmpfs mount, and it can
> contain ELF files.
>
> Add a filename prefix "/dev/shm/no-dso." which is recognized by
> is_no_dso_memory(). Applications can opt-in by naming their shared
> memory objects "no-dso.<name>". Executable mappings with this prefix
> will use the perf-map file, while other /dev/shm mappings will keep the
> existing behavior. This allows applications that already emit perf maps
> to use POSIX shared memory for JIT code, without needing to implement
> jitdump support.
>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>  tools/perf/util/map.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> index fb0279810ae99..c2e31be232c88 100644
> --- a/tools/perf/util/map.h
> +++ b/tools/perf/util/map.h
> @@ -258,6 +258,8 @@ static inline int is_no_dso_memory(const char *filename)
>  {
>  	return !strncmp(filename, "[stack", 6) ||
>  	       !strncmp(filename, "/SYSV", 5)  ||
> +	       !strncmp(filename, "/dev/shm/no-dso.",
> +	                sizeof("/dev/shm/no-dso.") - 1) ||
>  	       !strcmp(filename, "[heap]");
>  }
>  
> -- 
> 2.52.0
