Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7837219CD0A;
	Wed,  4 Mar 2026 02:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772591767; cv=fail; b=hiYDDzEQYhAGkYpRD8jfxmD08G2cf3pDxUjs8qmt3KSVQechsClw5MI7wNHZJ1OT8Ra5H3uHIIf9Izlu2lHN4zVTWjnJby1p6NljGZJ6dfPekK6DTK+IPzgQRlasQ7AeBMNoHX0zVtjojjul0kTY5OcjHEY6lx80dgp+bWOxZgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772591767; c=relaxed/simple;
	bh=vgW801n7Ma6sC9GV8/e0YW0Zoyr+cmGkwdvM2eJH2x8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kSWF/C7aG4SuOnyN4vF0uqYBt3h97kx1VPIlos9qE+TbctdRpZmziQH9I5XhOmTKu++4WZUlrrqmVdmETMN7m2QUzBlnGPsHPbTy9c07gmL0TvWyZDAU92LdJLTruE0i/VG/BDIgvEGu72876s4g2tSYXxCRab0QoY8zO5coBt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=BSUvQHyJ; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="BSUvQHyJ"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6242K26d1863087;
	Tue, 3 Mar 2026 18:35:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=jJ66wNc9YJ5wsSQzkVeTsrraN1Dkpln9ZkQdGd1pPSo=; b=
	BSUvQHyJ2AQiOKqZ24y9edWvWsrqgFtEKayc9CNti1VD6hxy65VFE1Mgr9iqOqSl
	Bi9y9kOrs/3pt3/TWjHsoEzX6VzvONShwqce5dloOAZE95H4Y/n++/hUuNwE8cvY
	Abv+7zGHwfbLt3lFR8+P1VeAGbm+uroWCddoK0ZyOlmvmaFpAwW1IlGWT22EmX+C
	3TJpympKaKSgbq4nROB33EJK1mo+sOc2KOC28aFQ0VcV8AM+tbZCxEGNty5g2gb9
	RuOOBwCJ3ta0FoxvY7vtMkRceGM9FtAtZD3fvabGz8S0c7jr/qOn8q+BdozShRlQ
	Ogd0dz64OaKrhleMgZAylg==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ckvh446q3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 18:35:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZwvIredrtuUIItWytiR+XF9d5tYhKp6xYwvwkfPyY7f8xOAjaPhtRHrto8WrOIFVO+yPyF7UpGwYb1WHi79YuJzlmsLr+RDSkBURokFNGhkOGm4jsUMOM1B1S9PJBmleP+8WL619BIcw0kDafkEeR9AxZ7ZYJ+Ii4RQDGn7gx4/mLxc/mh4nIJ+TBkRg+r5+lOvaRtBUouoqJI+2iAaEYVunTKo91wdsyycrOWHBclB30fzZGYbN5pOW8V36p/SC4sgzZzs15Xm0sF/Y4FBvo5jvMArSnnFNhe5MvRf/gX8TggkAwE7+Ta7pWbxxGiZyh1ZINXbMWKcas9GDOeo+WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJ66wNc9YJ5wsSQzkVeTsrraN1Dkpln9ZkQdGd1pPSo=;
 b=AMuFTRZ2hujB33A3JA8QEnE6nRi7LRLaxDauTkRZSp2XWcBpQ9wCfyTee9imt+liRmFtJbXhfWXOmaBt10qCmg3vEH+uv+omlkfpS88DNmZNKnhiBCHaFQWv03+qMD8dMAlwQkX28FkHpKj9omxuiJW/PZb6oeTx55Y8AK7jcsNv8dmw+LodKcd4OPe9jNJWkvoCRq1WQkEfAEv31+f7OqwcUgyro/9m/fgAC9Ch807xEwlOHG6jRlH5ahJejhjFqf6rL0QkxK2teBdVAV5eMuDLdZNDB+yKce55hXoFF8Oh0NZxhYM6oSVNEF2KQwrDH5OxkQghSddRNCaDoICKww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7312.namprd11.prod.outlook.com (2603:10b6:8:11f::18)
 by BL3PR11MB6385.namprd11.prod.outlook.com (2603:10b6:208:3b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 02:35:48 +0000
Received: from DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::531e:6ef5:812b:48f6]) by DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::531e:6ef5:812b:48f6%5]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 02:35:48 +0000
Message-ID: <9dab9875-db1e-4e13-87d4-7d07bf3859f9@windriver.com>
Date: Wed, 4 Mar 2026 10:35:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/build: make in-target rule robust against too long
 argument error
To: Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@google.com>
Cc: namhyung@kernel.org, james.clark@linaro.org, charlie@rivosinc.com,
        linux-kernel@vger.kernel.org, Markus Mayer <mmayer@broadcom.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
References: <20250728093153.2330009-1-changqing.li@windriver.com>
 <CAP-5=fW983q0NUEvxibY+QKLss+_TsyRGtgZF_n_q-XFZ98JLA@mail.gmail.com>
 <ef286bfd-0703-4393-87eb-4b0a85084767@windriver.com>
 <00dac1a5-16b0-4b54-8525-c0c706f08626@windriver.com>
 <CAP-5=fUCyYVg-h=YuLy9HRDWzvc7Jm3a9tZM29Bez4R-eTBSOQ@mail.gmail.com>
Content-Language: en-US
From: Changqing Li <changqing.li@windriver.com>
In-Reply-To: <CAP-5=fUCyYVg-h=YuLy9HRDWzvc7Jm3a9tZM29Bez4R-eTBSOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4P301CA0072.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::19) To DS0PR11MB7312.namprd11.prod.outlook.com
 (2603:10b6:8:11f::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7312:EE_|BL3PR11MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c7542eb-baf7-4ef7-e226-08de7996be54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|13003099007|7053199007|14052099004;
X-Microsoft-Antispam-Message-Info:
	6fXE/F3adbHKPf50LsHZPYRyeeieRX5kyrRAdpVUa0cs/qiw34MTWSi7G5qQuT6Ff6EtKZz2GYuS4BcUTFLodVPMnWFRw9C4kbzascwIK+762ZttKJuzCTJZUOglUFr/0foSrL2vrh/JICP9BkslVe4uhxkJe8n9YVG53Usx0p5gkj2VapI2spNTvajkdfbOgYAaRlYzjzwndN/300I67XiVqvLdZPDa7b2PMyZ85QTSnyFvGkrzKrDd/th9X3YxjNIqzql1KMT3ghiAWbMZGmWjHTFl9ssYXn7eBVCvC1OFDTMs4OgKregluNEauS640XQD859Z5Tta5jRAn4olaIaFhYkRFjX0qF00/7ZvXaQ7PIsbTScw6BOQDLgnMvLHmwMWjuBlH2fNsL7Tqa2PDysqTcvWTTvSrMW5LseR7yzlACQS9EPi3jWhRbVBziRaGGF7hJm43MLt57AeqHqYbRz8wEabr+97KtkjMNJAHCYteik3RGSvri27uM+OK3tazeJLcvZMlSf1vB8qy36pBLyJVaIA4QE9OmpPeYlZipA8l98dvtNZkPIPZpPb7jd8gca6xvioWOeGFDjNaefyIfQfTiSbxHUBUDFdfpdbzRj766Cm4Ll2PHtICv0dR95gs/i62W6pb53vMJn2GqtxyRJ+orP2tT+JHIS8SreqGM0Xy+ywheYY//a838Q7mW1E
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7312.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(13003099007)(7053199007)(14052099004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnhEUkZMQTVQaDY3c0k5dFc2dE1hbmlZVVpPL3NpbnRSOVk4UjZ1bWJiUG1Q?=
 =?utf-8?B?RDFuZTEzbThqN0wvTE8xeTdoMjNIck5RSjNnOE11c1B0NUlsd1BneXREQmNC?=
 =?utf-8?B?eVUzbmVsSzVXRWFUelNNS2lvMmhBK3pGNytBMWlwYk9mbVhENHRnNjBLTWwz?=
 =?utf-8?B?ZmovS29HSGNpdXVFbkZ5bmN4Ti9mSkptTzljRVhETzl3cVZOSDhVb0dWOHpW?=
 =?utf-8?B?ZWdtQmN4SXVycEYxcDJmY05ielRyS00zTkI2alN5bTZWN0NWOHk2SExFaVNj?=
 =?utf-8?B?cC8rVHZDUnVncDRBM3Mra3F5Y1ZmRjBtbWlsdUNBYzFTY3lvTzJRbEVGRHhK?=
 =?utf-8?B?Sm1hMVdiTSs4dFh3OUhFWnlBaUpyR2FDWGMyYkhtUFJmY3FVM3ZySmNYS0RG?=
 =?utf-8?B?WkYzZTBkOVVqeDhZUkFEM0dKK3FTSXphSk9kVC9MdTN5MFdUOEFZS0hDNmQy?=
 =?utf-8?B?cENiN25yT25OWlhGWHhKNHNIaE9lajV3U1Y1RU1kYnR4YTFaSjErQ3JMWU1L?=
 =?utf-8?B?cnR4SDZ2SG5ycEZCWGZ0ZlRib2hzcFpvVVJlVFdEamRjd013Z1c4V2hHeVFR?=
 =?utf-8?B?Tkhub2tZTUhQb2o3TG5nNjVndlJkdlBNd2lOWGY1NThPWUpyNzdvdElxaTNX?=
 =?utf-8?B?OFBHMmtBWlluNGJQVkhMUi9WTEVVVVpiVXZORGc0RndkSzdYZmZNMFYrMFp3?=
 =?utf-8?B?enJYcXJ2b1RlWlBBQ0lKVlRlallPNVBMRGRoVVY4YklVRzRZMmVtbkVnMkxB?=
 =?utf-8?B?U05jTUg2WEY1MmF0SXFMT2xpN2Y1TnB6czZqNjNybi9WSjV6QWJFbSt4K2Zt?=
 =?utf-8?B?bTZnSjlUVHpQNmduTGt5QUVEbGJyUWZITFBscGZmaWUyWVlWK0txMUNGMnVK?=
 =?utf-8?B?S0R3anlsVDE2M05qRlpQbnpIUWRvQndNdkhNL2dxK3JkU1Myem1pR3N3c0M3?=
 =?utf-8?B?d3pkeUo1RHI2dTR4KzIwVHREOFBjQXFHYVlQZTk4cHN0Nm11SWdZV3h4ekJP?=
 =?utf-8?B?WHMxK3ZQR1hNUDhkTFp6NldnUWUwRFcvUXFWbVhSYjFaOUlMdGFneWxsczIy?=
 =?utf-8?B?RVNiUVVWMEVhc1JobktoUGlLZFhSazBpU29rQW9qMjVlWkV5T2NtNkhsWDNL?=
 =?utf-8?B?TGlaRkEzWUZzUXNsNnJuWTdkZ3ZBV3ZuQ0szTEFpWjBSTjdGdGhlSitxd2wx?=
 =?utf-8?B?ZTBibm9nNEFjaHhydFdIRDNMUXB2cTN4Rno3VllKY05NNm5rN1Y2NnBxVXhk?=
 =?utf-8?B?dUhZNnNGN1EweG51bTdXWVBOdVQ5cysrZnQ0MTYvK0tOMkE5ZkZHVzdkQXpj?=
 =?utf-8?B?ckFYWVBhTHk1S3BWVWhlR01zQzBESEhwd1RIMVdUQTFySVdYVVlla3lsQzNE?=
 =?utf-8?B?RXM4RFpyVzlxMmpqUDJsUi9mQzZPMXJaRnI2SkZRN2tpYmNsczM0ZmFmb3RL?=
 =?utf-8?B?Tm96Z1pEVjVsR1AyOTY0WmRDcXN1OVBlZVFWdXJaMjEwUVJEdHh3aTFiT1ZS?=
 =?utf-8?B?Y3N6d0RSMTBTV1JOV0RzU1dHbi9hQlJ6dHJOdXhyUjZoSGZQa2U0UGdVc1BM?=
 =?utf-8?B?NnJnYjhHWXVlZUZXUTM2NkxMWjlQTXBYVndYQ0ErTysydVVoaTQ1RVN3RlVi?=
 =?utf-8?B?WllCQVBoSm5RWFljUGdRcmdCTlF0TEtWOTFBOTJRdnhtYTRadWR1RWxpM2pQ?=
 =?utf-8?B?VHVhc3NiYjh2bkJnRS9IanRsK2dGMXJDRHNSbzNtMThQYTNyYm42dXYvamZ2?=
 =?utf-8?B?R24zS0kzR3NzU0J0cnphc1Z4M1puMzdyRm0rMzFscGl5aHNSRjRvQnY0clJ1?=
 =?utf-8?B?b3ptTmIrYzVCUkNYWDE3K2RtR3VlTzAvTGpkZjFyYW5BakNDTGZWK3VDQmR1?=
 =?utf-8?B?aStlck5pQmZMZDRpSFl0aXhiZWdxYVIxOXFvcWU5ZFFzdHkyTEMyaHBFNHdB?=
 =?utf-8?B?OUdlWnN2UHd4KzZGeU5DSTJ4RGlMejFYckR5dWs2Rm9TM2puOGJYUEJ0VDdE?=
 =?utf-8?B?bXFPRUM3YTlGOVc4eTIxWkE1RVRuQmVUSDRwdEI0WTBTR2d4cEFQUSs5aWFz?=
 =?utf-8?B?RDRScTZFNS9rT0NyYTZyN0JnaHd5bi9KOHZ5RUgweEpiQ0hPUFdqdmZjQjNF?=
 =?utf-8?B?RTBJNjZ3N2ptR1d5UFR4VlIxWG56M1lrYmVxWTZYM1RLZCs3c1hMQ2I2eDdv?=
 =?utf-8?B?QjF6U0svbkQvdzh5VTNmY2V5L3lobkNPNVYrYy8yM3k5bXkySktjeEVCdk1Q?=
 =?utf-8?B?N3R0Y2RudnY2cDhtMTBucEFveXVlb0FXRUlaM1BvakFhSWJjT3pSQVowUmt2?=
 =?utf-8?B?VE12WTBBYTRPNVF2b2F4cnhHVDJiUFRrRS9jSkZtZklVem1ta2Rkcm1wYWNL?=
 =?utf-8?Q?qVYnaV6GXjvCU7EE=3D?=
X-Exchange-RoutingPolicyChecked:
	dk/Vqm7iJ6+BiB5sSloNe1CgDpmt+X3/I/hvBlslqS5/oRuHECgWqJCcuMf4rCz1hqiLwUG3Vr18OFc1ckbbFPT5rtDyM3ft9+dna64fnx9aPNUxNXjfvyDl9uxqrdte2JTcXCYSLXwLQTmveFK/ssoxb/DSgY/kK2SFXyK9T328uBkexJfWlwxocYh7T2BhaEG/s6/W5b6xhWnhqMLHDQ+54W6I1KI+0u6gZGeSkqWX/FKGzn8b030kdMQ/PtbZWxXsDvVTK3aF55cPxcfdQ2tkU5nMXyOQXGXzU6ZkGyYVNcXTHjQ3n+MNAZ6Y/JWHhe4D0P4dryQTBB4jXKWfNw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7542eb-baf7-4ef7-e226-08de7996be54
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 02:35:48.1035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4aBxP+/qs/URzjh0E1ziHtq0rfrX7GHLcG5ndjWCHj637Pm/+zwj8bI5l1SSz6oLCPy8w6pfBFE71xz870vdKZreM4NEZatAqHQcjufXPZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6385
X-Proofpoint-ORIG-GUID: NOWAl0DIY8HqC7VvoI_5V4I2qAxtEZc0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDAyMCBTYWx0ZWRfX1oRWKOxMo3aE
 CXs+DJ4UGbfZU3jyb4cPEZZup2spMHOCMIXGbQOHqUWd++m+b82OTQRg3HwQ9eaquYdFygQwNvF
 s9mgsdKqPDEdJ83QilP62qknKQhHz66/DTX3d55ycGfnocK2IeHrwFlFCaRIrVME3r+7TRHCgYc
 b8zq88yit+ht61EWKTJxwOtJoE7vi54L2syA0yuu8m3cJqT+ICnVkW/LEYyG9euLrr4/Tc0sL/Y
 1Lp/Tn3rHwMzQ1aUZW9u22v3yxTu7V/yiMe0Qw5QoqFdnLEdw8ZaMP7IssdWmeOpO9txXRk151H
 RNP7IfWVrBKy2o9LpGIoZe07eAp9wKi4HrZ62EZVeTB/Fn4Wx5NWaWcAUoFkaA4E7V4T6C8vjDS
 KqR06F3W6th8+4rkErVscW6eeB2Y1GawInkRcvpxGFvbs5wX8vjJZv9PQQYLbTJsSpsxO0JJ9Dj
 o/fYlYgxqVYfFfDah4Q==
X-Proofpoint-GUID: NOWAl0DIY8HqC7VvoI_5V4I2qAxtEZc0
X-Authority-Analysis: v=2.4 cv=Z/3h3XRA c=1 sm=1 tr=0 ts=69a79a88 cx=c_pps
 a=4s+CrTYCAhIFSJe2+GBd1A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=VwQbUJbxAAAA:8 a=Q-fNiiVtAAAA:8 a=NEAV23lmAAAA:8 a=Ptvq9zoxAAAA:8
 a=t7CeM3EgAAAA:8 a=1XWaLZrsAAAA:8 a=f0Godis_OerY_O3KWRMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ke9shIQgfMkOMJk9-b84:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_01,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040020


On 3/4/26 06:33, Ian Rogers wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Mon, Oct 27, 2025 at 7:16 PM Changqing Li <changqing.li@windriver.com> wrote:
>> Hi, Ian
>>
>> Kindly ping.  Could you reproduce it?  Any comments?
> Sorry Changqing,
>
> I was reminded by:
> https://lore.kernel.org/lkml/20260303211503.165337-1-mmayer@broadcom.com/
> that "argument list too long" is a problem for others.
>
> I tried reproducing it, but I think it doesn't fail for me, possibly
> because MAX_ARGS is larger on my system:
> ```
> $ xargs --show-limits
> Your environment variables take up 6133 bytes
> POSIX upper limit on argument length (this system): 2088971
> POSIX smallest allowable upper limit on argument length (all systems): 4096
> Maximum length of command we could actually use: 2082838
> Size of command buffer we are actually using: 131072
> Maximum parallelism (--max-procs must be no greater): 2147483647
> ```
>
> Anyway, the change makes sense to me.
>
> Reviewed-by: Ian Rogers <irogers@google.com>
>
> Thanks,
> Ian
>
Hi, Ian

Thanks.  I also cannot reproduce with previous length of tmpdir, maybe 
caused by perf source changes during this period，

but I can still reproduce after I make the tmpdir longer.

$ xargs --show-limits
Your environment variables take up 3124 bytes
POSIX upper limit on argument length (this system): 2091980
POSIX smallest allowable upper limit on argument length (all systems): 4096
Maximum length of command we could actually use: 2088856
Size of command buffer we are actually using: 131072
Maximum parallelism (--max-procs must be no greater): 2147483647


Regards

Changqing


>> Regards
>>
>> Changqing
>>
>> On 8/19/25 11:01, Changqing Li wrote:
>>> On 8/19/25 04:38, Ian Rogers wrote:
>>>> CAUTION: This email comes from a non Wind River email account!
>>>> Do not click links or open attachments unless you recognize the
>>>> sender and know the content is safe.
>>>>
>>>> On Mon, Jul 28, 2025 at 2:31 AM <changqing.li@windriver.com> wrote:
>>>>> From: Changqing Li <changqing.li@windriver.com>
>>>>>
>>>>> The command length of in-target scales with the depth of the directory
>>>>> times the number of objects in the Makefile. When there are many
>>>>> objects, and O=[absolute_path] is set, and the absolute_path is
>>>>> relatively long. It is possile that this line "$(call
>>>>> if_changed,$(host)ld_multi)" will report error:
>>>>> "make[4]: /bin/sh: Argument list too long"
>>>>>
>>>>> For example, build perf tools with O=/long/output/path
>>>>>
>>>>> Like built-in.a and *.mod rules in scripts/Makefile.build, add
>>>>> $(objpredix)/ by the shell command instead of by Make's builtin
>>>>> function.
>>>>>
>>>>> Signed-off-by: Changqing Li <changqing.li@windriver.com>
>>>> Thanks Changqing, the change makes sense to me. The printf is pushing
>>>> the values into xargs rather than using $^ with ld. I've tried
>>>> reproducing the error to test your fix by creating long directory
>>>> names in /tmp and then passing them to O=. I've not been able to do
>>>> this. Could you send a reproduction for me to test?
>>>>
>>>> Thanks,
>>>> Ian
>>> Hi, Ian
>>>
>>> Thanks. Here is my steps:
>>>
>>> 1. git clone https://github.com/torvalds/linux.git
>>>
>>> 2. cd linux/tools/perf/
>>>
>>> 3. mkdir
>>> /tmp/01234567890123456789/0123456789012345678901234567890123456789/0123456789012345678901234567890123456789/012345678901234567890123456789/01234567890123456789/012345678901234567890123456789/01234567890123456789012345678/9012345678901234567890123456789/012345678901234567890123456789/012345678901234567890123456789/01234567890123456789012345678901234567890123456789012345678901234567890123/perf-1.0
>>>
>>> 4.  make NO_LIBTRACEEVENT=1
>>> O=/tmp/01234567890123456789/0123456789012345678901234567890123456789/0123456789012345678901234567890123456789/012345678901234567890123456789/01234567890123456789/012345678901234567890123456789/01234567890123456789012345678/9012345678901234567890123456789/012345678901234567890123456789/012345678901234567890123456789/01234567890123456789012345678901234567890123456789012345678901234567890123/perf-1.0
>>>
>>>
>>> 5. Above step failed with error:
>>>
>>> make[4]: /bin/sh: Argument list too long
>>>
>>> make[4]: *** [/buildarea2/cli10/tmp/linux/tools/build/Makefile.build
>>> <https://urldefense.com/v3/__http://Makefile.build__;!!AjveYdw8EvQ!c2n7zPX4Vrhwd7a9UxsjCXBGO5V8Llmon1egvupz4kHL4869ilesQgRgQZO8nj8AWwQJUlY9DOoWPD688quA73jNugR6IZRxy09Eig$>:148:
>>> /tmp/01234567890123456789/0123456789012345678901234567890123456789/0123456789012345678901234567890123456789/012345678901234567890123456789/01234567890123456789/012345678901234567890123456789/01234567890123456789012345678/9012345678901234567890123456789/012345678901234567890123456789/012345678901234567890123456789/01234567890123456789012345678901234567890123456789012345678901234567890123/perf-1.0/util/perf-util-in.o]
>>> Error 127
>>>
>>> make[3]: *** [/buildarea2/cli10/tmp/linux/tools/build/Makefile.build
>>> <https://urldefense.com/v3/__http://Makefile.build__;!!AjveYdw8EvQ!c2n7zPX4Vrhwd7a9UxsjCXBGO5V8Llmon1egvupz4kHL4869ilesQgRgQZO8nj8AWwQJUlY9DOoWPD688quA73jNugR6IZRxy09Eig$>:142:
>>> util] Error 2
>>>
>>> make[2]: *** [Makefile.perf:797:
>>> /tmp/01234567890123456789/0123456789012345678901234567890123456789/0123456789012345678901234567890123456789/012345678901234567890123456789/01234567890123456789/012345678901234567890123456789/01234567890123456789012345678/9012345678901234567890123456789/012345678901234567890123456789/012345678901234567890123456789/01234567890123456789012345678901234567890123456789012345678901234567890123/perf-1.0/perf-util-in.o]
>>> Error 2
>>>
>>>
>>> Regards
>>>
>>> Changqing
>>>>> ---
>>>>>    tools/build/Makefile.build | 6 ++++--
>>>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
>>>>> index 3584ff308607..39066a3ef2fc 100644
>>>>> --- a/tools/build/Makefile.build
>>>>> +++ b/tools/build/Makefile.build
>>>>> @@ -70,11 +70,13 @@ quiet_cmd_gen = GEN     $@
>>>>>    # If there's nothing to link, create empty $@ object.
>>>>>    quiet_cmd_ld_multi = LD      $@
>>>>>          cmd_ld_multi = $(if $(strip $(obj-y)),\
>>>>> -                     $(LD) -r -o $@  $(filter $(obj-y),$^),rm -f
>>>>> $@; $(AR) rcs $@)
>>>>> +                     printf "$(objprefix)%s " $(patsubst
>>>>> $(objprefix)%,%,$(filter $(obj-y),$^)) | \
>>>>> +                     xargs $(LD) -r -o $@,rm -f $@; $(AR) rcs $@)
>>>>>
>>>>>    quiet_cmd_host_ld_multi = HOSTLD  $@
>>>>>          cmd_host_ld_multi = $(if $(strip $(obj-y)),\
>>>>> -                          $(HOSTLD) -r -o $@  $(filter
>>>>> $(obj-y),$^),rm -f $@; $(HOSTAR) rcs $@)
>>>>> +                          printf "$(objprefix)%s " $(patsubst
>>>>> $(objprefix)%,%,$(filter $(obj-y),$^)) | \
>>>>> +                          xargs $(HOSTLD) -r -o $@,rm -f $@;
>>>>> $(HOSTAR) rcs $@)
>>>>>
>>>>>    ifneq ($(filter $(obj),$(hostprogs)),)
>>>>>      host = host_
>>>>> --
>>>>> 2.34.1
>>>>>
