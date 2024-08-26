Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A756FB0;
	Mon, 26 Aug 2024 03:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724643333; cv=fail; b=kKpjgWY/5LKT+SwwOGlJZNtqfDef49Zq4EsDb9wWff+ImlB1ylV2Up4bbeRdlIWKH7kIi6WDNw6pWEJQjUv9RmdtTepF9UqF1GIXNHXnZfvSvNA0YRF41xWB0eG9w97pj+RJ4EkZr31tBB/p22IxaF27bJN6GBX/c/iuV2qDXXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724643333; c=relaxed/simple;
	bh=qczi27yaz93LmEBa4oizwOm0M+fU8h7V7slNq4hDlTE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rNwDeNtouLpOCn4flj7skXbKvsg6fJHuolG14xCWQrlFB1oVcXrL1eWX4i6maY+9iVvrXeXkMBqPGi4+G1BxhCEaQXNSTZsr4EhBMniWbHjiImNSrypg60BAMqMEbK43iOkZIC7EYq4gZ7mrqFnjSZMmMy5NlBH2n6qkHlpu28c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=puHgiMUW; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=qqP8CdnG; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="puHgiMUW";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="qqP8CdnG"
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47PEiStX028817;
	Sun, 25 Aug 2024 20:04:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=qczi27yaz93LmEBa4oizwOm0M+fU8h7V7slNq4hDl
	TE=; b=puHgiMUWqDSX9sD4pf5+vCLlGVXyz0TSj0D9KMRAWHJfUzxPmYSezbZl9
	T4s89lFo/mZUAa286wHRPBR41qf6RVLGJw9XP5/LvqzL3etQ6ie1By9DnPLzfW6K
	OIxHW1S24PTHtYTNlrDJOcy7nrA7QZUiEQbsrVU3rFuw4EqPKwaPJv2mFkrFG16T
	qtE/jz4GbL5cOF+AdSKXm5mDvECkjQHP+zaUCGY8UphOrEqjobpaq6sbD/fVN+cM
	1DSSs7e3DwVGkQC0Tv6/JTbsrmmgUkyjfBckAph7oNX1g7ALLeQTBZKgeFrs9yO5
	HVbi6c4iZBmcPbQuWhMR7NvR/H9lw==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011026.outbound.protection.outlook.com [40.93.12.26])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 417bea2bn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 25 Aug 2024 20:04:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDcItZHCf+fxFCooUxSrn/89Iz3VRiaTp2C+KwpCWAcu2Hx14lPWTKU1anfidZcKRK2XxbZaxZ9m2IkznZOUp9jpD4Pk/l3aT0tZ55nI+ddnJ6xG1wJ+9c8CrrirVmlTsAv5kgzPKmYejTmOxkbORaWpaFhDsZbZ6+ZSvfbO5nQi82qqQNXXYH6AUn6SuFzAY0tu7sQMmETmu6x251UxNnKxCGPejreIsDhJT+W0jbqiQKGFz5PF5km5bm2dRetl1jBsqotQxF8oATcfleN6EFaDbdHpSr/ue+tDkyphFZKQAcsS7ZM+JwdFs4WrlieycPvxWxrHTprjwp1zfBePPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qczi27yaz93LmEBa4oizwOm0M+fU8h7V7slNq4hDlTE=;
 b=Nq7aFtViz8Pw7dUMQkGN7voKlzlShCo+1e/8r3FQgJngar9yMmAMg8eTL+0ckV0rqTaPBQVEyRpaYL/gJ0+P9/AXULZQRWjgWfavv4OL45t4Ok7TTuiVZ3kcD0+cB2sEX421LauuKCXKS+y856iEtftYAM6q3drTiY5OdR+y1vQtYQa6HZ5A0JuKum9sFObwoW6aNKc7VOc9lvjIdoPl5t9mpqjRA/6p3reQGnvtjIbP9fgXNkRsUAOImzikphG9zs2QCvSyhyX5UXUQw2L/YuZCnLeJ8V03YJVb54dbuewp3xmCMHLsm0yP8VMvv70T3TbUzoD0O5JkxDaftjboww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qczi27yaz93LmEBa4oizwOm0M+fU8h7V7slNq4hDlTE=;
 b=qqP8CdnGFWAYrDsblRjtWg5z48EQR0BOq+bb1k0D4oyGg1MNPhkASVd0l1jjjKN99a8xdZ3XeQyIpKWu+NkSyMrTXkpLx0R2xAEtrHiOsqzWFMGprKCfk+WYbxc+1U8MgN+VAleKhJcYviZiRJeGkgq/XfiHe5eKT6TOT6n1JnQQaOr28eVMf+GwdOjSpviymUjFxzwevakpZ+HTYF67k0UFcJEgF/QEd4cJ8Z3hmlLOJq+pysifac23OxH29kHxkAARKr+DvcZESRCxKF1QJ7oHC0zl3WyrhhhN/PpsVnCM8f9LTwDICG8mjIAc1AJsomvBhvVKj6r41mPZzBfnKw==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by BY5PR02MB7044.namprd02.prod.outlook.com (2603:10b6:a03:232::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 03:04:13 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::b78d:8753:23a8:cc78]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::b78d:8753:23a8:cc78%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 03:04:12 +0000
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
Thread-Index: AQHa58iFg0Q+913iDEurf7AueZctN7IZw9OAgB81zYA=
Date: Mon, 26 Aug 2024 03:04:12 +0000
Message-ID: <C00F1D39-9A12-4D1C-85BD-48A6D7C0290B@nutanix.com>
References: <20240806061749.143072-1-eiichi.tsukata@nutanix.com>
 <4D19AE26-E1B4-44B6-A8C7-639EF2B69317@nutanix.com>
In-Reply-To: <4D19AE26-E1B4-44B6-A8C7-639EF2B69317@nutanix.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB8041:EE_|BY5PR02MB7044:EE_
x-ms-office365-filtering-correlation-id: 7ac59db8-17d7-466e-36bc-08dcc57bc2de
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?STF3aENsUDBIMkFXVUZSclBXcmllK3U3OEk4M2V2V2hWVjVVZE5yUllKVTE0?=
 =?utf-8?B?TEpKU00yTHRGaDRzQjJnK0JJb3ZockpWYUhmWElMREVKVkVWSENtbnBkaG1t?=
 =?utf-8?B?TEc0bjE0YUlLTGxlTSt4QTNVR09SdU5BSHJaemhtSE92UFhqODZYUHNvNEt0?=
 =?utf-8?B?VitVQWFTR1g5eFI0alZzeVhJUTVjd01OcEdFbUlrMjFjZnlMYyt1L1BzRkxu?=
 =?utf-8?B?Y0NvN1JrNzBRdDZTdGdTNHcrUFhEemZydmRmYjVOZEVkOWJVcjEybktFdTBm?=
 =?utf-8?B?cGRHeWZ3ZVdEZ1dZQlVQTEMxWStJMXMwRklTbkNBcE5HWlEydGx1OExTL2da?=
 =?utf-8?B?dUZMUEFZL3dlZHJ0OThDZjNKclVHcFM1WnhVM0p1Z0F2NEhOSk1QRHRJS251?=
 =?utf-8?B?UFVZTTZ1ZWFBTTdXRnlZREVvOWpDUEh1clVrc1Jld3lzd2VscVh6citGRjJO?=
 =?utf-8?B?WUZGVk9KbWRyWlJIR05USmRqOTQrYzNYTmZvQThVY2daa3F0OWcvWXZhY0ln?=
 =?utf-8?B?bFdzUmZwR1dVWDNWL0Vaa2RNYzIvc3FtNEp1RjBDYXJ2aGRIY1VSTy9qTmFs?=
 =?utf-8?B?dVk2OU1MSjBabUk0bzFmdDNtdGNxcVRwQXE2Ti9kY3pBNGJIMXk2T1ZSdVFs?=
 =?utf-8?B?TGRSMjJFWVJ5U0tVTkE1bXZTY3pVOUxZZ0pRellFK01vRDRoUVNtSTlSc3JN?=
 =?utf-8?B?TUJ1WHJkMjJML09TcWtaUk5ISUljclg2ZnVxdHdxdVNPVGtaTEd5WDZiN1J2?=
 =?utf-8?B?WXRPYjgxU2JhVTZFS3dxdzlRbnBjWCszR0grMCt6T1RDOTIzdFdPNk1XM0U0?=
 =?utf-8?B?aHhPNGFkV3NmQ21waDY2b3dEazVxQWRnWWJUb3lPWFREYnRReVo0emt0WThG?=
 =?utf-8?B?ajlQdVUyWThDMHB5YTFpT0pxUWVqb3JKbXVBbkZvMmt5TWdwNjlMS2w1YWV1?=
 =?utf-8?B?aktESHREV0xMV0dwTzFCZGxSdkt6bUFidHhRM243UFQrb2x4WW9LMjBqekhO?=
 =?utf-8?B?VEpDU1VweDlrNklBSUNNWGk4RFNoekVKQWhjc1NSanl6N0VzUkgwNzd4RUx1?=
 =?utf-8?B?MG1Yb2lBTFZZRHhua2k3Z3k3RUpDTFVNeC9uWFpZcm1hdVlJV1JURmRvb3ds?=
 =?utf-8?B?SzZ1dlo3c0FmZTRpRzhIMDRNeWJSckthd3dNTC81VjZGNDNCVG9mSXpiTy91?=
 =?utf-8?B?K2o3bzZQZ0NZcUZIOHJodzV0NDI3aGw5QkRsbkJITE9MSmFPZUZuNTJjWGNI?=
 =?utf-8?B?R1gwc05XZG5OWlNBLzFLMytWYm90eW01M25pb3M1MmZCd3l5dFhHaE56VEtz?=
 =?utf-8?B?YktIbTRONjB4dFhUeGV4b0lXR0Jhb3dDd0VMV2plR21qbDV3L1VRRWFIdWZs?=
 =?utf-8?B?Ym1hRU9WMGlLckw0ZENZWWdBMFBqcVhxUHF6c0pud0hTZlUyR2JCNXQ0MS9v?=
 =?utf-8?B?THVoc2hrRDJaOXBYQWlHc0V3OTlPcE1NdVZWLy9JR2ZaZnUzcWhiYTZJdEFP?=
 =?utf-8?B?Sk1VMTJxa2txOURRV1l5VzVvOGkvQVZOaWtxaFNEaDM1WlByVHVJUDRtM3Q5?=
 =?utf-8?B?VkJ4R1p2azBKdVltSkptdEdneDZ3cDUxUXI1amI1VkVTallXUmdtTVIxS1FC?=
 =?utf-8?B?QWE2Z0RucVVDNXhDUXQvUURROXB6ZDlKTGt4V29oT3RZUnNreWo4bXhlcjJO?=
 =?utf-8?B?NHZDaDVwWEpqN0paL2lhRW00VkZkcnlrOWZIcktnSUZObnUyQlU5OEltK2U0?=
 =?utf-8?B?L2tkK1JhTnl6Wm9vT3ljaGUxYUlwUjFuTUN5QmtYaEt2RWpVM3oxbCthUkFO?=
 =?utf-8?B?RFo1QkRPbjlWQVBoM2x5UW5Fc2htb29jLy9GWHZiam9xTVZvMWFFdmNkb2Er?=
 =?utf-8?Q?xxIlriTPh5dZ0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S3NYaWdBaXJ6VnAxMEoybkFvY2c5N3BKaGVTankyelVMa0tIdzZhclhxSWMx?=
 =?utf-8?B?enE3ZFdrNEVVOXF3cng2Umh1S2NLcW9JVFhXSDRndzRIYnU5NndqVVlrUjVo?=
 =?utf-8?B?UXVTN2orKzVvNlhaVnhxUURrNjhmQlpmcTF5dnRsRGtSVVd4cmhrS29zOVpN?=
 =?utf-8?B?ZkRiM21weC9aT0JCbkU0RUw3Rjc1Q2ZWWmdPQThld2dwU0R4S3BPT3BVMnZm?=
 =?utf-8?B?ZWRxVldZTEJBOXhad1VaRUlHdnNxNzlRUTBZYmRsa0ZiL3pKRGUzdkJGZmR0?=
 =?utf-8?B?MlZDNjJ2VG1mZndXU255N084QjV3ODkzMUd6QWZLdS9sWllzbXlBb0N3NVp4?=
 =?utf-8?B?eGJGSGxlWUxTTHpUTmFVdmFGdThNb3U0d005SHNxSzQrN1VrOU1wSHlSL3JJ?=
 =?utf-8?B?dFVXUi8wd1VkNjd0OFhWZHZIQTltOW91N0NUVGF1czdMVVJJYmtDa2dsbEVK?=
 =?utf-8?B?Q2YwbEd0N3E3a1NNTFByZXJCTHJxeGpMR1ZpemNuSHJIUmlrMlB0ZS9xK0ds?=
 =?utf-8?B?cWx1WEFrUTc1T1l2WnpMRWdGckdlTlp6Y1UxTHZiVW1GZXdyUlcyMjU3SHB3?=
 =?utf-8?B?YkNjODVEcCthYS9JV1pMQzFTQ25JYmFUWEN4Q3hnb0lDdjFIL0lhU1BMZnZM?=
 =?utf-8?B?VmNicVQyalNUQUp3OWpkQXdoS21XOGVqek1Xei9mMURPdWtnaS9LRWxqbVR4?=
 =?utf-8?B?U2R2SlI2c3JoU0hzMWpvWjRGdEJBRHBqK2RWc295MVk2R0Zzcll1aVRCbVd1?=
 =?utf-8?B?WFhUdGMvZ1NLZGM3L0sxK2xuTGl3VUp2YWFFZjRJZ3JscFY0M2hmZTJJVmI5?=
 =?utf-8?B?dVdBTzBIUlZnTmhrSWhURENlaXh1YkRiWHptb0ZzNGF5ZVZLblVmK0o0M0JH?=
 =?utf-8?B?TlU5c0JoV05IeGR1Wmd0S3ExTUpPVjh1ZEZnWHJ5bG5na1BIVFRTMitpUHE3?=
 =?utf-8?B?MUd4S29DVHVmWlZneXNnMjUwK0d2dzJReCs1bnJhZlVWQUVBUE1HK09VbGJk?=
 =?utf-8?B?cHBtczlOT3hoNWRpYVJJVDRsa05vY2pBSmNCN1QwOGFLNkJDYVluTklyZ2Rj?=
 =?utf-8?B?Nk0venl5Qndxd21MMWxuSnUzQVRrUGN3bDFLZUdLekxIL0IyeVpSbHpIVVJU?=
 =?utf-8?B?TmVJWDArc0x6NmNTL2JyamdJd3hCMm1OVXh3bVJTRE90eU9nNkpkejZZV2VV?=
 =?utf-8?B?YWd4a1hBTG53N1lNQ2VqbzVQRDE5QVlYa0FCcDlUL29PSE1vZm1ndFNPNkxH?=
 =?utf-8?B?bCs1N090V0llam04a1VMdXVyeURLbWx4amh0akNuK3h3czkvSndZNEplbUJx?=
 =?utf-8?B?bnJlR29qdXVhYTRseHAvRWh1aHNHZVZXK0VhVXVmNzl2MkUyMStYUjYxTkVO?=
 =?utf-8?B?b1ZpM2ZWNTBaRkxDSi9jc3hvUzMwbDIvOVlRVzQ2LzFES2tjNDBCNmF5WkpO?=
 =?utf-8?B?K0VXejNzUjJpYjJPK0JPOW5vL0JUMm9pTmJPNEdEQnlhY1VzSTgxeVMrazZ3?=
 =?utf-8?B?bEVoYmR4OGhqb3NMeEp2L2tVaWF6aWxRQjBnK2JoVXZSTWRremFMMS9JRFFN?=
 =?utf-8?B?VjVlK3dwbHIyeG1RWCs3aGo0ZUpXRms0R2pLSXZXMGJhdUp0ZG5GcWdYU0xj?=
 =?utf-8?B?aEdHekN0cXo4V09VNUZpYXc0VUU1TVJ6R2ZpazM4dWZGWUV5ZjhhbDhQbVJu?=
 =?utf-8?B?aE1vOWM2cXIxMzBSNXJlUGZGTDRlcE9FWEhSdWtySzdiek9Xam96YkNlZ0o2?=
 =?utf-8?B?Q1ZFVHl0UmhKRVZyK2FUWlhNQlBObElTU2NudjNlRWJzY3h5QjBXcGZiRjEr?=
 =?utf-8?B?dlptcythV1FoZmlJRExjeWRJTzBVRWFEUnZzQ3Q2V1FHMXNQV2YyWnhGaTZz?=
 =?utf-8?B?OFF2RnRjU3FhNXNnZmVINncyOTdtaW9ReVdteGtoL2xQWkZNVSttUzduUEEr?=
 =?utf-8?B?d2h5YVdFMmluQ2ZXdFZwVEN0QUpZRkphSjViOGx6UkZwT2ZmTkNFcUkxU2kz?=
 =?utf-8?B?L0VKcnAvekM0Z1VuQXJoMEdPaXZ3NmIvd1pmM2ZrUEkyazlwWHM4ZHkwQ0V0?=
 =?utf-8?B?eUV4dCtNZVZ3WW9BdW5COGEvWmVXaTltMld1TWdLWjJNbWFUR1U3d0NJS1E4?=
 =?utf-8?B?cU9MakFhTThrSUxZUHRkemp3NzdlWEEyQzhlYUJCRzd3aTQ1WkQrTngzVkY4?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7249A6C1A39A154FA7FB7492B8AF2013@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac59db8-17d7-466e-36bc-08dcc57bc2de
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 03:04:12.0566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L4QXv2ej4Uk8fcf9qs0eeySc4HIjQVgmpL/uGY2+THMmbV5Ye85A/dNa7B16lgslb549DaKIk2aUHLCaN3q7h9H4FiBD+A/XBb9LcXCIVNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7044
X-Proofpoint-GUID: z8HmbswoEVJGeFyqDL0isLVRI8Bpk9OL
X-Authority-Analysis: v=2.4 cv=d4ynygjE c=1 sm=1 tr=0 ts=66cbf0af cx=c_pps a=iiQOqwU6IAtWz55ZD8rkjg==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=0034W8JfsZAA:10 a=64Cc0HZtAAAA:8 a=vTr9H3xdAAAA:8
 a=Naob4n88W26HrkX6swAA:9 a=QEXdDO2ut3YA:10 a=14NRyaPF5x3gF6G45PvQ:22 a=7PCjnrUJ-F5voXmZD6jJ:22
X-Proofpoint-ORIG-GUID: z8HmbswoEVJGeFyqDL0isLVRI8Bpk9OL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-25_20,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Reason: safe

UGluZw0KDQo+IE9uIEF1ZyA2LCAyMDI0LCBhdCAxNToyNywgRWlpY2hpIFRzdWthdGEgPGVpaWNo
aS50c3VrYXRhQG51dGFuaXguY29tPiB3cm90ZToNCj4gDQo+IEhpLA0KPiANCj4gRllJOiBGZWRv
cmEgdXNlcyDigJxSUE1fT1BUX0ZMQUdT4oCdICBhcyDigJxFWFRSQV9DRkxBR1PigJ0gdG8gYnVp
bGQgcGVyZi4NCj4gaHR0cHM6Ly9zcmMuZmVkb3JhcHJvamVjdC5vcmcvcnBtcy9rZXJuZWwvYmxv
Yi9yYXdoaWRlL2Yva2VybmVsLnNwZWMjXzI5MDgNCj4gDQo+IEFuZCBvbiBGZWRvcmE0MCwgIGl0
IGhhcyDigJwtV3AsLURfRk9SVElGWV9TT1VSQ0U9M+KAnS4NCj4gDQo+IFtlaWljaGlAdDQ5NSB+
XSQgcnBtIC0tc2hvd3JjIHwgZ3JlcCBSUE1fT1BUIHwgaGVhZCAtbiAxDQo+ICBSUE1fT1BUX0ZM
QUdTPSIle29wdGZsYWdzfSINCj4gW2VpaWNoaUB0NDk1IH5dJCBycG0gLS1ldmFsICcle29wdGZs
YWdzfScNCj4gLU8yIC1mbHRvPWF1dG8gLWZmYXQtbHRvLW9iamVjdHMgLWZleGNlcHRpb25zIC1n
IC1ncmVjb3JkLWdjYy1zd2l0Y2hlcyAtcGlwZSAtV2FsbCAtV25vLWNvbXBsYWluLXdyb25nLWxh
bmcgLVdlcnJvcj1mb3JtYXQtc2VjdXJpdHkgLVdwLC1VX0ZPUlRJRllfU09VUkNFLC1EX0ZPUlRJ
RllfU09VUkNFPTMgLVdwLC1EX0dMSUJDWFhfQVNTRVJUSU9OUyAtc3BlY3M9L3Vzci9saWIvcnBt
L3JlZGhhdC9yZWRoYXQtaGFyZGVuZWQtY2MxIC1mc3RhY2stcHJvdGVjdG9yLXN0cm9uZyAtc3Bl
Y3M9L3Vzci9saWIvcnBtL3JlZGhhdC9yZWRoYXQtYW5ub2Jpbi1jYzEgIC1tNjQgLW1hcmNoPXg4
Ni02NCAtbXR1bmU9Z2VuZXJpYyAtZmFzeW5jaHJvbm91cy11bndpbmQtdGFibGVzIC1mc3RhY2st
Y2xhc2gtcHJvdGVjdGlvbiAtZmNmLXByb3RlY3Rpb24gLWZuby1vbWl0LWZyYW1lLXBvaW50ZXIg
LW1vbi1vbWl0LWxlYWYtZnJhbWUtcG9pbnRlcg0KPiANCj4gQmVzdCwNCj4gRWlpY2hpDQo+IA0K
Pj4gT24gQXVnIDYsIDIwMjQsIGF0IDE1OjE3LCBFaWljaGkgVHN1a2F0YSA8ZWlpY2hpLnRzdWth
dGFAbnV0YW5peC5jb20+IHdyb3RlOg0KPj4gDQo+PiBJZiBFWFRSQV9DRkxBR1MgaGFzICItV3As
LURfRk9SVElGWV9TT1VSQ0U9MiIsIHRoZSBidWlsZCBmYWlscyB3aXRoOg0KPj4gDQo+PiBlcnJv
cjogI3dhcm5pbmcgX0ZPUlRJRllfU09VUkNFIHJlcXVpcmVzIGNvbXBpbGluZyB3aXRoIG9wdGlt
aXphdGlvbiAoLU8pIFstV2Vycm9yPWNwcF0NCj4+IA0KPj4gVXNlICItV3AsLVVfRk9SVElGWV9T
T1VSQ0UiIGluc3RlYWQgb2YgIi1VX0ZPUlRJRllfU09VUkNFIiBmb3IgdGVzdHMNCj4+IGJ1aWx0
IHdpdGggLU8wLg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBFaWljaGkgVHN1a2F0YSA8ZWlpY2hp
LnRzdWthdGFAbnV0YW5peC5jb20+DQo+PiAtLS0NCj4+IHRvb2xzL3BlcmYvdGVzdHMvd29ya2xv
YWRzL0J1aWxkIHwgOCArKysrLS0tLQ0KPj4gMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdGVzdHMv
d29ya2xvYWRzL0J1aWxkIGIvdG9vbHMvcGVyZi90ZXN0cy93b3JrbG9hZHMvQnVpbGQNCj4+IGlu
ZGV4IDQ4YmYwZDNiMGYzZC4uZWMzNmMyMWUzNzVlIDEwMDY0NA0KPj4gLS0tIGEvdG9vbHMvcGVy
Zi90ZXN0cy93b3JrbG9hZHMvQnVpbGQNCj4+ICsrKyBiL3Rvb2xzL3BlcmYvdGVzdHMvd29ya2xv
YWRzL0J1aWxkDQo+PiBAQCAtNyw3ICs3LDcgQEAgcGVyZi10ZXN0LXkgKz0gc3FydGxvb3Aubw0K
Pj4gcGVyZi10ZXN0LXkgKz0gYnJzdGFjay5vDQo+PiBwZXJmLXRlc3QteSArPSBkYXRhc3ltLm8N
Cj4+IA0KPj4gLUNGTEFHU19zcXJ0bG9vcC5vICAgICAgICAgPSAtZyAtTzAgLWZuby1pbmxpbmUg
LVVfRk9SVElGWV9TT1VSQ0UNCj4+IC1DRkxBR1NfbGVhZmxvb3AubyAgICAgICAgID0gLWcgLU8w
IC1mbm8taW5saW5lIC1mbm8tb21pdC1mcmFtZS1wb2ludGVyIC1VX0ZPUlRJRllfU09VUkNFDQo+
PiAtQ0ZMQUdTX2Jyc3RhY2subyAgICAgICAgICA9IC1nIC1PMCAtZm5vLWlubGluZSAtVV9GT1JU
SUZZX1NPVVJDRQ0KPj4gLUNGTEFHU19kYXRhc3ltLm8gICAgICAgICAgPSAtZyAtTzAgLWZuby1p
bmxpbmUgLVVfRk9SVElGWV9TT1VSQ0UNCj4+ICtDRkxBR1Nfc3FydGxvb3AubyAgICAgICAgID0g
LWcgLU8wIC1mbm8taW5saW5lIC1XcCwtVV9GT1JUSUZZX1NPVVJDRQ0KPj4gK0NGTEFHU19sZWFm
bG9vcC5vICAgICAgICAgPSAtZyAtTzAgLWZuby1pbmxpbmUgLWZuby1vbWl0LWZyYW1lLXBvaW50
ZXIgLVdwLC1VX0ZPUlRJRllfU09VUkNFDQo+PiArQ0ZMQUdTX2Jyc3RhY2subyAgICAgICAgICA9
IC1nIC1PMCAtZm5vLWlubGluZSAtV3AsLVVfRk9SVElGWV9TT1VSQ0UNCj4+ICtDRkxBR1NfZGF0
YXN5bS5vICAgICAgICAgID0gLWcgLU8wIC1mbm8taW5saW5lIC1XcCwtVV9GT1JUSUZZX1NPVVJD
RQ0KPj4gLS0gDQo+PiAyLjQ1LjINCj4+IA0KPiANCg0K
