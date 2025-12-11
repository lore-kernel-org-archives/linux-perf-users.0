Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F433D544;
	Thu, 11 Dec 2025 01:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.157.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765415727; cv=fail; b=PSqzJTeN2dDoYTAS2xNtOuOgcq8DdEW8NanWuY2eXq4L5oa6hfU8pZxXimS7cWXnXvXN51MmUIFxHPEnx3RAYDQOLRKA4+G0YM8Q8JF5FfzGiZjJz1NWH+JSlO/1/OrRcXbsZMtSuHGlsmF1U2TYAB7lYVBIMBAt5dIyiTmiOSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765415727; c=relaxed/simple;
	bh=8W/ZvTnSYsBKbqiScbayOBp4he2Y44s8PVchDWik1eE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C/hNY1oAdnU8+pUGNtW/tIp7tWhHN2N3i3+UsRK5C13cTHobzgyuQssNkHnZcjhhiMW+BwyXY1yDnyvBCUCJ9N54CdvSYLeZakCCpCcxXV7o37I3F3k5gIpK/PMR2E0c7c3iWN/VyFIfVSB0EP01saxLfsh+m3Vdv/nvPW/GtyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=MAvtY5Zg; dkim=fail (1024-bit key) header.d=akamai365.onmicrosoft.com header.i=@akamai365.onmicrosoft.com header.b=LJSkkyrF reason="signature verification failed"; arc=fail smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="MAvtY5Zg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akamai365.onmicrosoft.com header.i=@akamai365.onmicrosoft.com header.b="LJSkkyrF"
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
	by mx0b-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BB1FFWH3082181;
	Thu, 11 Dec 2025 01:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=jan2016.eng;
	 bh=8W/ZvTnSYsBKbqiScbayOBp4he2Y44s8PVchDWik1eE=; b=MAvtY5ZgliwE
	I0e7z5fddsTLa4/F4i7GK4mzA4ZSInHOPkloxa0zZU9318rVL+ferdzo/XAJzPxB
	mcPmxJ4y2dR4wxA9HwR05CpTN/mquGfuqbicynYugb4AdZ5bcD1Zhs8eXVEDaS5T
	2e0BIdqKfOsLbxJz/Kyz2HTgDjwCmloxCyjk+/U6ootXag35cQHh+VbrUiebGisd
	xfIwDxxTtmKDCj54xsioTbtJU7VSBi23U6HaBsUu3fzaWi0vDMDo1UO/1jkxITm8
	uaADSL6wuUPyD6j6mSt9yK1BSoOZmyxZqflebbWIgKmloKpe33cN9BBt/bhPu5C/
	L2MbTMzygA==
Received: from prod-mail-ppoint8 (a72-247-45-34.deploy.static.akamaitechnologies.com [72.247.45.34] (may be forged))
	by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4axhts38hr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Dec 2025 01:15:14 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
	by prod-mail-ppoint8.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAM1Mv0009828;
	Wed, 10 Dec 2025 20:15:14 -0500
Received: from email.msg.corp.akamai.com ([172.27.50.221])
	by prod-mail-ppoint8.akamai.com (PPS) with ESMTPS id 4avgq1v0yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Dec 2025 20:15:14 -0500
Received: from ustx2ex-dag4mb6.msg.corp.akamai.com (172.27.50.205) by
 ustx2ex-dag5mb4.msg.corp.akamai.com (172.27.50.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 17:15:13 -0800
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-dag4mb6.msg.corp.akamai.com (172.27.50.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 10 Dec 2025 17:15:13 -0800
Received: from DM5PR08CU004.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 10 Dec 2025 19:15:13 -0600
Received: from BY3PR17MB5186.namprd17.prod.outlook.com (2603:10b6:a03:3b5::11)
 by CY5PR17MB6047.namprd17.prod.outlook.com (2603:10b6:930:3c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Thu, 11 Dec
 2025 01:15:10 +0000
Received: from BY3PR17MB5186.namprd17.prod.outlook.com
 ([fe80::2b1d:9322:c62e:6a19]) by BY3PR17MB5186.namprd17.prod.outlook.com
 ([fe80::2b1d:9322:c62e:6a19%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 01:15:10 +0000
From: "Jayaramappa, Srilakshmi" <sjayaram@akamai.com>
To: Ian Rogers <irogers@google.com>
CC: "acme@kernel.org" <acme@kernel.org>,
        "amadio@gentoo.org"
	<amadio@gentoo.org>,
        "Hunt, Joshua" <johunt@akamai.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "peterz@infradead.org"
	<peterz@infradead.org>
Subject: Re: [PATCH] libsubcmd: Fix null intersection case in exclude_cmds()
Thread-Topic: [PATCH] libsubcmd: Fix null intersection case in exclude_cmds()
Thread-Index: AQHcY9RZJu2aPClQG0GJOquR5z6HErUWxomAgANjTwCAARbygIAAbho/
Date: Thu, 11 Dec 2025 01:15:10 +0000
Message-ID: <BY3PR17MB518635DB0CE29FFD648D6343A5A1A@BY3PR17MB5186.namprd17.prod.outlook.com>
References: <CAP-5=fUs8jD_qLJGjLBiVheu6JzynmmYSmfr_9PgKmxK4qEwVg@mail.gmail.com>
 <20251210020026.3265559-1-sjayaram@akamai.com>
 <CAP-5=fVmbif0k3LMnMMeZUPnyL5fG=fNc-6TnBsXmhzqHu=0gQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVmbif0k3LMnMMeZUPnyL5fG=fNc-6TnBsXmhzqHu=0gQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR17MB5186:EE_|CY5PR17MB6047:EE_
x-ms-office365-filtering-correlation-id: a9028681-c0ee-4bdc-412d-08de3852bae2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NS9aUmJrVG5Ya1JOQjVjbDNLcDR2UFM5RlNLUmUyemxhNWsyc0RwSUYrbi8y?=
 =?utf-8?B?QXRxdXpGSzhvZU1yTTN4YmlhdEZwOWYzZzVwSjhLdXdoNFAvU1R6NnR2dVFZ?=
 =?utf-8?B?Vlh2ZERFV1hjakgxQ05rYmhXR2dlY1FUaFRMZ0FwQ0k1V3BleVc1WVBjakZj?=
 =?utf-8?B?dWZjeS9FWk1zNERiajNFSjk2N3pUQ2ZuZ09XaFNYdVNaU1BRWXB4bEpXdENk?=
 =?utf-8?B?S0ROU29NcXdxWm9QSjE4ZzZRd2JWand3T0xiVjcxR2FxTjQ5SHNMTnJlVDJM?=
 =?utf-8?B?QXNJVFpPVlU0RGRFWUhOQkpUSzdJbmNxbjhHK3NVa0xTV0JRYWVhNjZpN3Nn?=
 =?utf-8?B?RCtCd0R1S2ZieG5vTjJYcjI3UU56U2M4N2xxaDNCMHprd1I0VTl2SGd0ZlJV?=
 =?utf-8?B?QURMZkRtc3V5TDlOekNKT05VdEFtZkt5SXlWYnpHTWNhNWhUdWRrQmNPb2xq?=
 =?utf-8?B?VG16clkxYzMwWis4bUUxTXlNVjBXNVVyNXdNK3NQRVVLb1VGbzNNZGpvT2I5?=
 =?utf-8?B?NW1jQzJMclNoSVE3T3J5ZWhoYUFEWUxEWVBXNC8zRUFCRjZJR25WK0JGbEUz?=
 =?utf-8?B?MFJKOVVIamVDcDZhUzBZb1VhSmhoaDN2SDVrUTg0dENGYTd5Q1UwOXZadE9J?=
 =?utf-8?B?Nk1WUFBGWTQ3L0lzdXMvOXJXSFVza1M5RlAwM0xEUEQ1Uk1lZ3JlV3pobUZl?=
 =?utf-8?B?M2o1SEljenhoWlRCSytuNERLWUp5VTVwLzR4cWJ4Z2x5d0pVekdzM3J0a1N1?=
 =?utf-8?B?T1FjMFlxeEZhNmF5dDJnb3lWNXRYMGdJZWlNM0JwbU44VmxXSjM0MVNLd0JL?=
 =?utf-8?B?K1JLY0tIenBtVGk0YzFtQkxjVkNyTXMxWEhTdW8reHhkY1h0ZzcxUjZNdkRa?=
 =?utf-8?B?MG5RTUQ4QzNIREdVNnAybW9FNmF5TWJONU9GdXZwOGVpeUd1MXhlL2tUQXA3?=
 =?utf-8?B?UlY0RTlqMU5TeU9oTWQyeW1HWHQxZnBYU3AxVmdTbUFWSkpIanJOV0FKY3BZ?=
 =?utf-8?B?blFQQ2lzcGJuVHZ3ZnN2cVQ3d25pNTl2OU1iZURvUDFXM3pYblZwalY0UG1M?=
 =?utf-8?B?ZUdPbzZOVEVGTFRjTC9INE1uSHhWQ0EvMVl5aUMxS2FFLzFtdUpPL2ZMdU5B?=
 =?utf-8?B?S2FweERRL21GRnBnOW8wdHc4ZURaa3JLdS9kamt1Ym9BZjE5blNlNmRPSEtm?=
 =?utf-8?B?QWpENEF0T3VteHNlb1NFbjBpVUlDQzNaMnZDR21RUFhUTzJQRjYwcStVMWd2?=
 =?utf-8?B?L3FiRkVnaGRqUWJOTkhvbEpQMXkxSUQ4QWUvZkpFRThGV2RGc1N0bkZUS2pR?=
 =?utf-8?B?N1JuaUVmN0xldjY2dmxFa0tVRFJnSkVwNitYSE5FekZtMUExeUNJQ1Y5Y2ZW?=
 =?utf-8?B?NkpvZUhPN1E0aGc3WVZsUU1Vdis1ekY1VnNGZ1VyV1RzUjFaWlRmRytZdjVX?=
 =?utf-8?B?TzNUNTVlQk9MeFB3WHBLWnM2bzVTTCtGbVh1K2NCYW1YMnJQais3SFdVT1Ni?=
 =?utf-8?B?ZW1GdVlQc3IyOVpXb1NrNSt2OG5LV0xsZ1FOSkxGSmxyS1pLOWw1Y29IdVQw?=
 =?utf-8?B?bDEzYVNYeFJYVU9HOVdGTGNOWE5TNkF2a2ZCQmtuZCtpSTdMdGNxMXliWHFp?=
 =?utf-8?B?U3c4Z1cwVzlDa3l4R0VvREN1S0ZwVmE5QS9kWUtLRW9wRFFGeGladzQ2ZnR5?=
 =?utf-8?B?bXcxZSsrZ1l0dUliVGJkMXVmNCtEMERUbGF6ZnI1WEx3dmRIdVY0WkYrUkU3?=
 =?utf-8?B?OXRsRC9wRUMyNlZEaVloYTZYWEtjalYzRC96MDE5amhSdFdPWUdaMmt3eFB1?=
 =?utf-8?B?V3A0dEdqU2lqWFBjV3VsNlpscjVER2VyMWZwRUN3SUZ0b1FxM2duY09nd0Rw?=
 =?utf-8?B?Q3FPei9Pa2ZmMEMxS21nQkZ2bU1OaGxHT2FhWGdIeC9FRVJOdE9YTW5OTmVk?=
 =?utf-8?B?aFFENktYMzRFczRXejFwd2c3RUVSOUJRbzY4Ny9iUnlqZHcwbXhicTUzOEMz?=
 =?utf-8?B?TW9xQkdRYUlGbXZ0VE9Jd2dVQWN4OWp1ckVJS2FrNHRwNDNCUFMwUHhTZjZs?=
 =?utf-8?Q?XQ4jxc?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR17MB5186.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vzl2UDV4dEZXQ3p0dDNrb3pha3cxUTByS0JCR3RRVFVpRmNXRmJTQnJwM1Q4?=
 =?utf-8?B?Vkt0MlFxUldZTUhwM3lFNWFlQVZoUEl5bVd4UGppeUVZSU9ucWRnR1lvNEE2?=
 =?utf-8?B?RUpNRjVSRzlobXdqVkJjaks3c2RycWtRdnBzV0hWTk1yRG1vRUROM3ZRNkNO?=
 =?utf-8?B?aGpWZUt1NzlicGhwN1RNby84TTFSYks5czdPNEcxV083b0UvOG81NFFHZXdr?=
 =?utf-8?B?eWsrNy9naWR5NGJhWkhtMFcrdndYRGVyYjJMUGVNaVFjZ2kwbWR6b1ZmQk5z?=
 =?utf-8?B?WEc1MTJjakhTUDBPLzAwNXNEMi9BV1JJV0Y2NUI5TG1SU1lRZzR6YkpneWIr?=
 =?utf-8?B?T3p1bVNsdStad0pJejZzR3ZERkg0czJUWURmRDdiUlB0YStVanA4Rm5lZFdt?=
 =?utf-8?B?ZXR3QmxPV1BGS09YV3lHanpQcWlDZ0lVOUV2MFYzenV6ZlRYd09Ma3ZRTnZC?=
 =?utf-8?B?MStPU0NWVGlLRGVialJ0cGdSZHhkYi9vVVpmM1dRTUozZG5qTWF1WXpXa1FU?=
 =?utf-8?B?WEdCZFdycjhmeW1mVDZwcjAxU095L2ZmWGIvVEZTY25wdG9GNld0TXJNYUU3?=
 =?utf-8?B?YlVjOXFLZXFidTl0bzcyZUMxSDhmZ29CdExzazZuYlBXYkFwOEtCZmVFSHRs?=
 =?utf-8?B?bUZLaklKSTZsdjFKdUpZcjFkUFF1aEdibWJGK012N3lrQTBiTUpqTnN4U2I1?=
 =?utf-8?B?YVZvQ1JNNzcvZW5OUFprVkRPd2VmRkk3dHVZTEJhRXRLOVpmV1Nzd3R3bDk2?=
 =?utf-8?B?dW9JU3ZtQjJZeWJWQWF5U3BJWm9iNVJmTHNpTTNQYjhDS1VTQjVFUCtMWkRS?=
 =?utf-8?B?dlphZzhQNnBsNWcrOUVzb05zOVpzNHhHL3czS1VVc21VZG5INVEvanlaRG9U?=
 =?utf-8?B?eEJsVG1obXJNak96eERDQnY1NmVsVEpoeGMyK1NoSjNEKzMvQkRVeVc0Nmp0?=
 =?utf-8?B?OERsNWxmSGJpYVVjeWNvbE1WcmdlVzhlYk15ZG1UVnV2UUJYbXBlSW9vWmlJ?=
 =?utf-8?B?M2h4bldsRkRoWEUyV0dKOVQ1REZVa1RlZGZwZkxnVWZyYitnYm83ZnBZUDJh?=
 =?utf-8?B?am9KbnBXQTZHSTJBaUhkSUw2WFpDVzNFdXRadFI3bXNCcVNZTHZBZXBtQlhR?=
 =?utf-8?B?UHVEeTFLcnVXRzZvZ2ZaTG9TNisxN0NyR3dXaDFhVFdrZjZ2ek4vWnNlWDkv?=
 =?utf-8?B?Qmx0NVMzRlJxU0hZcDhwZEtDaElPNWNPdWtzRmtKK3o4bVhmM0c2djFaUU9O?=
 =?utf-8?B?dFZZSnV6VjFHSlA5NG9qcWVBU2l3Mi9rWVphYkI4UGU3aElVbC9OOHBYTk1s?=
 =?utf-8?B?OU9Zc1d6QlFaU2FYR2FrZFNxbXIvVFFQTjk4TmRySngrWWZMWW9FQ3NLbllX?=
 =?utf-8?B?MlgwM2RUamNNZkJ6b3dpenBwM0x0T3FiQVhnQlRLVXoxdDkrNkFJb0ZnR0o2?=
 =?utf-8?B?eUwvaDB6RVhncVpTUUVpVWNHazExanRVNWRXWkczUHNKUTRaMzAwbCtVY29F?=
 =?utf-8?B?U2RJeUU3c0Fmc2NTdTY2MVlGaXdXcFNwNkt1aFppNzNTeThiejZZZkNtbGph?=
 =?utf-8?B?VzNhK0FNN2t4Vy95akp4Z3NldTk3U0lRVkNpb1N5eXlWWlo1UVV6anBJNnZi?=
 =?utf-8?B?Y2V2N1gwTGdWRExQUSt4S01ZZzV2bmlwR2pHWHB3UENxb1E0Z2htQjNYeTJD?=
 =?utf-8?B?dTkyQ3Q1NkRnTEJ6Y250eW9SRjV2UmdqVGxtTmNoNnVSMFpxRVh6MnNsdDNU?=
 =?utf-8?B?MVkvZEthRVZnRkdSVmd6VUlOY0RrV1JxdzFOMHF3TkNlTkFjWEFEd3RxYmF3?=
 =?utf-8?B?Z2dnTitjN1pZSlc0RTNIckpmUkdMOCswVEN5N0hTdVViWUpiMEJUZUpBcDV0?=
 =?utf-8?B?YkRnbkpuWFhITzE2bzB0S1I4NVhCSlJoWCszdHBneVZxN2dnVU14UHZGcytM?=
 =?utf-8?B?NVBwSFkyMW1PN0NaaWlRUWgzc2tuNjRxbFJJT042VVFXaWdMYU9JbkRqeWx4?=
 =?utf-8?B?ZGRoTG5ueWswazI1dHZNV21vQms5blBNL2xFWjh0STRhcHB5c3NWUjJFVWQ1?=
 =?utf-8?B?YU90WmY5WWo2bXhmUGw0dmtyeEtWSlFtOEJBTHA1WHVZY0Fxbk5Eb1FVY29l?=
 =?utf-8?B?RCtwSnlsODQ2aHB1TmhDS0xPblZzNm5vdTNHZ1NoRVJtWnFkV1JvOE4wZEpv?=
 =?utf-8?Q?VKyiNB/m54kH27T7QaQ5fXXzlnMkBRrblLIaLyJprwA+?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cl2+BmPEtrDxJkZc5lbCyRr78kbRnYf8prr4GFsBwlHCPP3PHehGuIL8wdLPt2D90ztDBXys7bUN3S4AnUKGB+1VtciodndYthX7hFoGLplj9EENch53yOLoql+cGkBmnXSq60YBCmuy/iZdM013omt48TNFn1isPFdpMPva1xCQi5prlMnr+s3aSAYea+NL3ciARjaOqOY4wFr6ZrlxPu8+a77y1C1rcsHAlCGKJt5i9JWJJqbXArhcRiFgmrO8JERJaUh64Tg+EUswP3OM8wACmFaBu4fFU8omee1pclVtBYh08Nr2MzhNdFgIfj+bfMNUwBwoGz+0UiTQpAPQ2A==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNJBYK3G3RKJsUSGOAT/N+VT+sePXkN7tK6OSAG3ot4=;
 b=wZ4v4/ZFjo/F0JjaplOIn4qyhhGA6a9arSFSJdY5NtNwfCNXM0nG6vgWkK2yKR/8eHnXtyqJilrO1aoG47iUKQadKxLn0q/189WCO/bhNyK/tUljK8LccuQoUiRg/NV36PG+RqEyg7T9uiRWSSaJraJ++63Qb8hUebNJykUaiGtjq2rWkLyT/yiQQrirPyWLOU2bXjNVoO+irqheFfj4uvRRKGRM4rkfKpYnNrSd7I2c1B2k30stiIGqe2xfqI3kb2FYqfVQn8a3fJGZYOD9I7dXzhZKtAGM7i0b2XSTiUt6k03fw9SxY0DY38W1vgtdlJ5lP+mu/ZkViI+xmvGNog==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNJBYK3G3RKJsUSGOAT/N+VT+sePXkN7tK6OSAG3ot4=;
 b=LJSkkyrFk/AYvpNViT5ixGav9OCMKnNTuKsQ4OWBoRo5ix9uGbJUmXQPF5hZ+dFS7mrqI98aR5bVZLP/Ab/3b9kPDOkhew2sEZwuyfT3W4VqJccCn+CPOrYxu6lSP16iLxPKcvCzoUtNoBbtLFj4cvqxon5NW/nrqPGgZJd0RMY=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BY3PR17MB5186.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: a9028681-c0ee-4bdc-412d-08de3852bae2
x-ms-exchange-crosstenant-originalarrivaltime: 11 Dec 2025 01:15:10.6989 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: hTHPEy0pEWn0By/2skSj9LYCTj3Z9FbvUTdATGwznYEAKrHEQMfiDDArEl/kt+2vctc07X3XTdWFmO0BfbiAHA==
x-ms-exchange-transport-crosstenantheadersstamped: CY5PR17MB6047
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512110007
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDAwNyBTYWx0ZWRfXyQxtX2+lyDdm
 nqCfSW+peg0mLDAuq4wcOQlhN+PXzU2LEwZhft2JZON0AH3O/ySk2ZCNNeDhP9N5ROZBaMI0t7b
 hmYzPijxJpDBBtCqT0StJ831B5lrg5mlAV93xpKvjp8sE955TiP+3fMa+fZpQq0cZxtmM/N3uAg
 NUjrI1hReDE1crJSQbCbUK5hiuuzqGj5HSreaKN22Qp3r90LvOdTow8DD6OVOyDJSbVJp8yDzlN
 YifCR7D3aqJRtTCVg88hrrDMnsMG31QDZDG+ViNDUSuZcIrPjRGYnk6fg7A242mQn4g5UfBwOLW
 DKRZ4zqD4hO/eViqI3vIObzKI6iAdciPDxo1DWkq4sR5cf8VkYP+BwI58qrpHuOFNh/BAOwQnaH
 TXYwxIkFZPyhADSDMKiDBjUyGePq7A==
X-Proofpoint-ORIG-GUID: YfkLA0bk-nLARwT4VHJWWzrx5eybuQet
X-Authority-Analysis: v=2.4 cv=PNwCOPqC c=1 sm=1 tr=0 ts=693a1b22 cx=c_pps
 a=YfDTZII5gR69fLX6qI1EXA==:117 a=YfDTZII5gR69fLX6qI1EXA==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=g1y_e2JewP0A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=7mOBRU54AAAA:8 a=JfrnYn6hAAAA:8
 a=X7Ea-ya5AAAA:8 a=RHfFz3W2sbryE7fcxOMA:9 a=QEXdDO2ut3YA:10
 a=wa9RWnbW_A1YIeRBVszw:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: YfkLA0bk-nLARwT4VHJWWzrx5eybuQet
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110007

DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQpGcm9tOiBJYW4gUm9n
ZXJzIDxpcm9nZXJzQGdvb2dsZS5jb20+DQpTZW50OiBXZWRuZXNkYXksIERlY2VtYmVyIDEwLCAy
MDI1IDEwOjM4IEFNDQpUbzogSmF5YXJhbWFwcGEsIFNyaWxha3NobWkNCkNjOiBhY21lQGtlcm5l
bC5vcmc7IGFtYWRpb0BnZW50b28ub3JnOyBIdW50LCBKb3NodWE7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LXBlcmYtdXNlcnNAdmdlci5rZXJuZWwub3JnOyBuYW1oeXVuZ0Br
ZXJuZWwub3JnOyBwZXRlcnpAaW5mcmFkZWFkLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gbGli
c3ViY21kOiBGaXggbnVsbCBpbnRlcnNlY3Rpb24gY2FzZSBpbiBleGNsdWRlX2NtZHMoKQ0KDQoh
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLXwNCiAgVGhpcyBNZXNzYWdlIElzIEZyb20gYW4gRXh0ZXJuYWwgU2VuZGVyDQog
IFRoaXMgbWVzc2FnZSBjYW1lIGZyb20gb3V0c2lkZSB5b3VyIG9yZ2FuaXphdGlvbi4NCnwtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tIQ0KDQpPbiBUdWUsIERlYyA5LCAyMDI1IGF0IDY6MDDigK9QTSBTcmkgSmF5YXJhbWFw
cGEgPHNqYXlhcmFtQGFrYW1haS5jb20+IHdyb3RlOg0KPg0KPiBIaSBJYW4sDQo+DQo+IFllcywg
dGhpcyBjb3ZlcnMgbXkgY2FzZS4gSSBoYWQgdGhvdWdodCB0aHJvdWdoIG90aGVyIHBvc3NpYmxl
IHNjZW5hcmlvcyBiZWZvcmUgc2VuZGluZyB0aGUgcGF0Y2gsIGFuZCBJIGRvbuKAmXQgc2VlIGFu
eSBhZGRpdGlvbmFsIGlzc3Vlcy4NCg0KVGhhbmtzIFNyaSwNCg0KYW55IGNoYW5jZSB5b3UgY291
bGQgcmVwbHkgdG8gdGhlIHRlc3QgZS1tYWlsIHdpdGggYSAiUmV2aWV3ZWQtYnk6IFNyaQ0KSmF5
YXJhbWFwcGEgPHNqYXlhcmFtQGFrYW1haS5jb20+IiA/IEl0IG1ha2VzIGl0IGVhc2llciBmb3Ig
cGF0Y2gNCm1hbmFnZXJzIHRvIHNwb3QgdGhhdCB0aGUgY29kZSBpcyByZXZpZXdlZC4NCg0KVGhh
bmtzIQ0KSWFuDQoNCg0KDQpBYnNvbHV0ZWx5ISBKdXN0IHJlcGxpZWQgdG8gdGhlIHRlc3QgZW1h
aWwuIEFuZCBhcG9sb2dpZXMgZm9yIHRoZSB3ZWlyZCBlbWFpbCBmb3JtYXR0aW5nIG9uIG15IHBy
ZXZpb3VzIG1lc3NhZ2UuIFRyaWVkIHRvIHVzZSBnaXQgc2VuZC1lbWFpbCBmb3IgdGhlIHJlcGx5
IGFuZCBpdCBkaWRuJ3QgZG8gd2hhdCBJIHRob3VnaHQgSSB3YXMgZ29pbmcgdG8uLi4NCg0KVGhh
bmtzDQotU3JpDQo=
