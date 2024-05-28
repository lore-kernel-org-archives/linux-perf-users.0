Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A955516ABC0;
	Tue, 28 May 2024 10:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890499; cv=fail; b=Nus93iF60DooRf2I+whkSKkSErTJRsipAVf+adjrPoKyRIcwAaUEIeswe6sMsS3+Qa9Wbs8+TQabD5S+OK6T6UcEKs9OG8PtCR/wQmG5Y9JHhtrv7uxjjQshvn9jMcd5dXyvwotX4EVzoDwQFTT3IboNNxNzyYayi+jaX016YsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890499; c=relaxed/simple;
	bh=tEsStf9iHiiNkQZ6cel32RGhuQRh8Py5cjt14qqclCA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QG4IKrywSXSBs6irlvruw0ffDpxh9QXB3qSEhGPI6HuDAEPmr9ien4Logn6VtgY/PK0TTfUUbah/6/iDqQ15sl+0wEmSIVuTkUWypjbVgVwtR4/pcJvt1Mkjys9oBP95lpzKMLAsG7Y1fKO78+pjtSSBIiJMMs40SbV/hD28LzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44S7woNS021764;
	Tue, 28 May 2024 10:00:56 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcontent-transfer-encoding:content-type:date:from:in-reply-to?=
 =?UTF-8?Q?:message-id:mime-version:references:subject:to;_s=3Dcorp-2023-1?=
 =?UTF-8?Q?1-20;_bh=3DYZl4d8S4x/rI6jROfZyXyTBiAbDuS2OmgigIMgqDaw4=3D;_b=3D?=
 =?UTF-8?Q?WJIq01AlBMoy519eASxpKaOIfluqXhoMYVZiVK0M1jUbYZe9fbbcNLL7+OLUeBG?=
 =?UTF-8?Q?NBv7w_ZwWOF91SAClEBiPYVUnUT68w8I2BQTXmXPpmpH01Ig1EFumQLxmfqalo3?=
 =?UTF-8?Q?nUA7R9PpsaY_ZVw8jJ0BjBwrFStB0wE/JOswtXbfR6wZppa5STSld6+Z4SVEA+r?=
 =?UTF-8?Q?0HZLVAuH6Vi8jO9y3_CaNscOG8J/D+PpiYClMHZgiROCjhBZXcrwxXVPxY8s1Hx?=
 =?UTF-8?Q?gi2Z10DX4NPJlvoWzzg2k88_5uJwE9VaY7vI4RNlqbFPrLnTekZmTk/ngCaVlqq?=
 =?UTF-8?Q?Wl/s3zT2p+AddfJJkk/wf2m2RJXtQ_qA=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8fcbx8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 10:00:56 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44S82FRr025822;
	Tue, 28 May 2024 10:00:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50pms7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 10:00:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XeOPjVVVLqeMJ6g5JM2a7HOnJIov7doF/k2z7x+HYsKku5eWsHLLGiTURk+ys2VtkytvgEmzoxWC3oizf8caUgjqUdJ2lr6J449uAY4CKtGhGZc+S9BHEQG7Fn0dkfCzNFnYV7cHxaYrX2SEclLqfRDaq93Ge3DIsSm0XhYVRLtl9hKmzzw32mGdE57qUgQSD7j9Ml8isslTGc9K2dL3Wqb2iisYOrUW5ky3V5APSgpuINKyRUuVKbtINRWArDK5tRwDF7dfz49ebDJs8F2R+E+poIP3Fpx9KKa6QcdL52obHRjeGzIlZG3I2cxxowp1By7HebpJa4M8k1K82IdHEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZl4d8S4x/rI6jROfZyXyTBiAbDuS2OmgigIMgqDaw4=;
 b=Znuj1+DK/JEo3p7wcUcSFKvwchCmYn1X1W4ZjW+qwYXJfXnTHWXYvjx4I6Bm/8F8Vk7gMtS4bJaF/kXWo4zueD/Ights5p7CrZFnkaI0vUUTWMDQW+gn/28VO1DyMVRocJ5W9Bg0eyK0NvP9ekejo5YVnq33ZU/oosmN6eEQhxIF5KL0NBBcYFdi8nznWyFy7WcpBPQ71KIprJvs5Ihqz4Lt4/e6X+Asr2PsW1X9tBWcJ3fFE9M+kVkR3m45ukxa7XwMIMK1j5OHvCcZRXoR/5TeL3m8286NSxagl8R04cD2Y6LbED9Lb8yTLHywU0XjkcIr/GyTK/aMapxYa6uL+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZl4d8S4x/rI6jROfZyXyTBiAbDuS2OmgigIMgqDaw4=;
 b=b+kpb4btK3ujCii/81W7ZkbgeGVx0tvCZrCM5ddyCIaq8TFwqGl4aYrB8YFDzcWMY0uGcarVjvHoCGoc+E3K2Fmtn+mR+Rb+AOB/m59S3R3BAwOwLcjFM3xpi/pBSJTqIsHR0Vggd6O40HYxXq2C6A2CVr73C7u7XzxmEKT4j68=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA3PR10MB8113.namprd10.prod.outlook.com (2603:10b6:208:50a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 10:00:53 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 10:00:53 +0000
Message-ID: <a173525f-33a9-43ee-8b03-a277810025fc@oracle.com>
Date: Tue, 28 May 2024 11:00:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] perf jevents: Autogenerate empty-pmu-events.c
To: Ian Rogers <irogers@google.com>, Weilin Wang <weilin.wang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sandipan Das
 <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240525013021.436430-1-irogers@google.com>
 <20240525013021.436430-2-irogers@google.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240525013021.436430-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0045.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA3PR10MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a07f07-4fbd-4341-dc53-08dc7efd0f4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|7416005|376005|366007|1800799015|921011;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eWFHVnRnQVUwd2hQdEhXYW52R0tldHk0a09ueTRyVm5ER3VrSFdrM3gvbGJa?=
 =?utf-8?B?WTgrZzl1TllyT0tNT2NGeWVaSGhaQ1NlZE12cUtlcTZ2ZjVLYnJ1SmRnclJn?=
 =?utf-8?B?NXhGS3RuQ0QrcnpnWFFNOE5vUFhseGpjbHo3RitLdVppY3NqSGNIQ2NacWd1?=
 =?utf-8?B?OHFwWE1vY3hiNmg3U09pNG43Y2ZQamY5aTQ2M1ZjbjZxL3oxRUl4VlNKVUxr?=
 =?utf-8?B?TEt1UTJxb2dzMXV6ODhKZXhWd1d0akNQZmZsanNESEpyK0dsSi9DRGpYMklL?=
 =?utf-8?B?UFMwS3FGdTRZQjdpQm1FYUNDWmxLUnBUOTZYazAyTlVWL0VuSkRYV0RKcysz?=
 =?utf-8?B?QXIxUUdZZE9obVBQMkd0THZvUVZWT1FoNjlPam9kWVpZQTlPM0NCZVFka040?=
 =?utf-8?B?K0RWcmludDNCbXZpRTYzazhVT2V6c3BEVm5ZNm9zSXRVTlEzaUhNVmhLaWhY?=
 =?utf-8?B?a3R6VVZiOHlVdkIxVVdKandmaGQwU21HY0FjVmN1cU14NDl6aXN4cTFrdVYy?=
 =?utf-8?B?RUIwREZlMWFZYkJlZVE1Ynh4ank1bjlueTY5SUZ0T1RoeDFxaWVHRUc2WVNU?=
 =?utf-8?B?M0Y2NVNRZGJjMGtVcjRDRmZKa1NGditmK1VhMXRTQ0xlcHhkZGRYY1RpMHhJ?=
 =?utf-8?B?bTFXYU04aFAvU3lkYXVneEpCL0FpTm9LUzl0YXFseEExMlNYSzU3TXRmN1dt?=
 =?utf-8?B?ODl2cVpKWXdRT2x6eUYvSU93WWJvRlNnZ1IwZjZLdG0vTzY0OHVKYXJNMGF2?=
 =?utf-8?B?TXV4SUdLYjBzL0JiQWg2MWc5N29mUTlHVlllb1FIRUJOeGFKbDE5c1hBODNn?=
 =?utf-8?B?QkxRY2xKOWFidURWcGNJRjU4aVpjaEN6a2hjYTZmakQyT01ZTmNEWlpGc29r?=
 =?utf-8?B?bGNWWFRZRHZ4R2MyMWozT0MzSFlxVGpMWFpuc0JnL1E4TjhCOEJ2NmtzaEhM?=
 =?utf-8?B?N3VjNWFPR29TQW9ueWRkUmtITjBhQ1YvNEtYL1lDWGJGMzdIWGlWaGtnN1U0?=
 =?utf-8?B?aC85K293d1puZlplSXBwRCtpQ2lueGYwbUtsMnJFTExrRStPd1B3L2t2bEVt?=
 =?utf-8?B?WE9Bc0JRenArMnc3MUs4Z3N6U2N6Q1VOVFZ5T0FWRXJRRUVUK3dRUUcvZ0RJ?=
 =?utf-8?B?ZlplRWY4V0FOVm14YVZ3azBXNW50SitITjlkS0NyaW9UWTdsVWkvdjMrZmUy?=
 =?utf-8?B?T2YvaFZhaWgyT1lDQUI2NjMvWlZMQ0JUTEI0MDcva2NJS0ZYSGQ3U3NrbTls?=
 =?utf-8?B?M1VnVzE2ZklEWFFmKzdVckZYY0V3a1YvVytoOHRjNHdjekVwZDJaR2l5Y095?=
 =?utf-8?B?dGNQV3IxTGgvT3FmWHBmc2ZMU3h0THRuRlQzUkVBazlVbjhSRVRhaEpuU0Rl?=
 =?utf-8?B?Vkh0Y2NOcEV3RndaVXZaY3I1T2ptTzd1RkNPM0E0NVFJSlBadVREY3VEMU1H?=
 =?utf-8?B?N1NjU2RVMWxvenJrUWhTU1NIQll5SzhBa2EyeE9wclFUSTFuVzdCOVMwMWpr?=
 =?utf-8?B?RXVtMUVIMnZTd1FvOXhWcklKVzlkT2szTHhmNkxYZmhQYnd2blhBRk1tdi9N?=
 =?utf-8?B?V1QwSXFKbUJqMTIxZVhOWTIxZ1VDOEpjeHUxUFVMSjB4YTkyOTR1azcvYUVy?=
 =?utf-8?B?NDAxdDYrQXlTbmxVWEpTaFdVV29NT01zZ2wrOTRaREg3VHd5TnpWYzVNOVhp?=
 =?utf-8?B?dGdkRm5PMzEzN3RUL3BkOGl5ejNaZmRZOEREWHlpYXdwcnJYa1Uzc2xwRHpR?=
 =?utf-8?Q?QhaFwcNxYnPrSzG3nVVNMbVBUExvd73TmuzYCvq?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q2NZdzJPZG1xeVpnMFI2S2RvUzRwMng2ZnpzelRhSkFGYUYxZGovdjBFRFRi?=
 =?utf-8?B?T3R3bWpHckhtbVlNRmoxbEgzOHlhRFhPSWRTaFVTM3lCUmFkeWE1VU5USkNR?=
 =?utf-8?B?amtiM2pBT0J5RlJJWXFaL3d1VmVrNzBhUDd0SkNyeS9LWk1Pd0JWbEJucm1m?=
 =?utf-8?B?K0hKa3dvMDlMbFo5YU9kbnB5N1E4Y0NJL2ZTYU51dnhEKzVBWlIyMjB3YktF?=
 =?utf-8?B?OTBXVzh3VHd4TytLUWhlREZwYytBaEZTTnY4Sms3blNYeVRIc2pjS3N6dUc1?=
 =?utf-8?B?UCtSUS9BTXpCSzhPdWxKdllxTW9LVm1HSjExTjhFVzhhTXZaTDJZOUIxMlV6?=
 =?utf-8?B?emZxc09JWlVTcng1Mm9RTDBtU0hmUHQ2NDV6NDI2cXZRb3BGa2FjTzJIb0ZC?=
 =?utf-8?B?QjJnUmVsUkwxWjhKOWlSODJXTERqdjlyKzZBUVovT0pEMXJpaFB5d1JqQXFP?=
 =?utf-8?B?c3NnMXZsOU1SL1Z6U25aeUhURzl0QXNUMlcrdmJpZGpzU05rM3U2NUNRanp4?=
 =?utf-8?B?bXVLZEZ5QzFDOXB5NkJRZDFTSi83d3NDWlRWeEl5Q1MzejVLdGFsQTBkaFNy?=
 =?utf-8?B?SnNjTU9ha29XMlNFamNsOHpPck9pbDBmeFQ0TVprUzVHenJ0c0NHWTFnZzB6?=
 =?utf-8?B?U1dFblZMSVJpaVE4VHdyOGxzY0o3QVhxZGRMV0tFWS9ha3JPN3N3UEpSaCs0?=
 =?utf-8?B?ZFNmZTJUTlpJdUMvaURsS1BEemx0NkV1cUllMnN2Qm1NT2FQNUowSGlHMHlr?=
 =?utf-8?B?V0QwQ3pDWmlSK3hmbXQ5Q094cks4NWJEWWMxZ0ZFd1ExczV1ZU9pME1rUzdI?=
 =?utf-8?B?eCtQaWNLeHN0Yzh5Q3VnZnMrZVQ1czcvQTRhZ3ZrelVOU3NGbStDTE10UFZD?=
 =?utf-8?B?VlIzZ28xc2xzSjNRcjFUMzhVOHE1M0YwZ1o5R2tDTGdEV2d1eExzWXJOK0hj?=
 =?utf-8?B?WExIQXlWUVA1RDRmMkFpbVBYa2VQQS9pTmFMaHkxK2UrRklOdU5YM2VEUXNr?=
 =?utf-8?B?VVRuVC9ackVXNk5MZUhONzF3Z1MxVHh4L2ZHdUZ4UjhVME5HSklHTmkrSlY2?=
 =?utf-8?B?ZUwzcit2UitSMWxlMCtEdGovb29BTm9BNHhhdUNDTXBZNG1ERXZocHJiOUZY?=
 =?utf-8?B?WDlkUUNwV2dRS0RibTZWcDBzZ2ZMTjFqbk8vL1JXb3pjUURBVVJNeWttbHNF?=
 =?utf-8?B?cGIvZXdYeUQ1OWFJTDJ5UWdsMVZLcjREcjV6WDVzbHVOY2RxM00vcHJoNGNk?=
 =?utf-8?B?ajBlQndVL2JvZlgzcVQyVDBIS1BYSFJ2amhwWktacHNSMzdLUEJmM0I2dDVt?=
 =?utf-8?B?RFhaNWNzd2pzcS9kKy80NEtNSFZXOFlqYUN0ZllzWUR4bmdEVHBnaGpQWDgr?=
 =?utf-8?B?SndTVEUvZU1rSXVBQ2VoMFovVzFwUGYvWlhSb2o5S0ExYkNqMG9rU214aFkw?=
 =?utf-8?B?R1VXUFFJL3lJWFo5OUQrLzBUMGtOTERES0dyYXM1STR6d1ZpQ1RqRHZoUDhx?=
 =?utf-8?B?VFBLTTdNZ2hFaWhHMnRxdnJxYzQ2dlFBRE9XdFVWM1YvVmxabXFmaERneGZm?=
 =?utf-8?B?U3E1ekpvQ09ERDl1SkQ5Z1RNcjZlWk1IN3RSWXlzejZGc0VwTUpXbzlYandj?=
 =?utf-8?B?NVdWazdadlhmekhpd3RPQlVmaFNhWEFlZHVPOGJ3bEtxN0hnVFZrbUZOWTAw?=
 =?utf-8?B?dStlQ0hLM1lZdVZhWG4yc1RNSlUwOXdldEE2N0lxMFdObEJGcUthWmFkWG5t?=
 =?utf-8?B?dnFQSERDSTJ6Z1NrTUJDZzZTd0NUQmdvaVJUL0sxK3FUNnJDNUwwOUFsRDRz?=
 =?utf-8?B?cnpxTVNidEFDdVBVV0FsN1dBMnpzUnBvbFZZRGVFWUx1dklodkk5TCtvZTll?=
 =?utf-8?B?MnR4dHkvUHoxd3FWNTFYQ0lnSWZGelJ0QVBXTHk4RitiZXZyVDNNUk8vc3VG?=
 =?utf-8?B?QytuenVlMmVFTGo1NXZ5QXBZYnl5S2pyMTZadkFXVENReUNCcTYydUs1TTc4?=
 =?utf-8?B?a2o1ZzRUZ1docUZlR1Rjb3YvbjdmdnR6WTVsM2pEOXN1c2UvdXc3QzRUT2xl?=
 =?utf-8?B?NkpOcnIwWHQzN0ZvRDFHVitYNlp3aDg4OXlDL1dpZHN4dFdjcnNKK0c5aDZQ?=
 =?utf-8?B?aU5CSEFoVE0wYW5VeVNyYWtXZ1huUkd3QWlORzQ0VUpQZE9PWkJnYm1IZ2RU?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dIBoA60eEFJELwWCNejWtmTBy2ZyZLWQmflqgpLH6HLwMPkWrxYqQP4i7O54MLyFmSX3VbyWtTV5d0gk1ICBeFcES+MGXFMk/FYohU07ACxOTO3kpn1jN9l1d1kc306UY+Dg1UiJkN1xHGWZMr+hoXOAQFqb5t/wvgO1Et/GBAwiDRhV8qFxPlrRu3HesHSk1ds9pdtxANpAWL47gXEtkGUCvgtSu4GonNnYPifRB5plQN5xqw68mgGir1O0zg3CTrqt7zcdIyq1hs0suxX5uKHp/jVCzK15hR1CxEbP9W7qSCQoNFRJGCkauL2loHwIq1rJQJg4mw0YWeMpDaW1m+3JZAaqPbxFRPSDnbWGT07lA3O048wyRJff8R0BU+5ba+yjZ7KV50IO/AqDaTXvvqnuF1VGQ3KQUEc+CFRH8ULF9cz9FVsc9cEs8gH/aBzaH4R3W6KSj339nMwsT27YiMuE/k6edy5QH4w8CGxLBkMjjjPGjHJwN2/CxJZRxDHt82RLbf6boQsNGCHKSEm409hjHNLAu4KY+1AkkSIXaWWVA102c2C/CG96QvWLN4fz4gUV+SgVLlW2ZULaSEsdbQM50MSvo1YTPdmx8QVfJD0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a07f07-4fbd-4341-dc53-08dc7efd0f4f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 10:00:53.0617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jxrd07xPMp0v/2ebgSLjbVFFhcWmXFm6VWiICFL+TYqJC5TQfWe/wQzvMGBGHP5SMzi7OxRWX3sBo5wdcIKdJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8113
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_06,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280074
X-Proofpoint-GUID: Ez19oqLybNVDQgjbMMn8TtgiHwE6vA5G
X-Proofpoint-ORIG-GUID: Ez19oqLybNVDQgjbMMn8TtgiHwE6vA5G

On 25/05/2024 02:30, Ian Rogers wrote:
> empty-pmu-events.c exists so that builds may occur without python
> being installed on a system. > Manually updating empty-pmu-events.c to
> be in sync with jevents.py is a pain, let's use jevents.py to generate
> empty-pmu-events.c.
> 
> 1) change jevents.py so that an arch and model of none cause
>     generation of a pmu-events.c without any json. Add a SPDX and
>     autogenerated warning to the start of the file.
> 
> 2) change Build so that if a generated pmu-events.c for arch none and
>     model none doesn't match empty-pmu-events.c the build fails with a
>     cat of the differences. Update Makefile.perf to clean up the files
>     used for this.
> 
> 3) update empty-pmu-events.c to match the output of jevents.py with
>     arch and mode of none.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>


Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   tools/perf/Makefile.perf                 |   2 +
>   tools/perf/pmu-events/Build              |  12 +-
>   tools/perf/pmu-events/empty-pmu-events.c | 894 ++++++++++++++---------
>   tools/perf/pmu-events/jevents.py         |   6 +-
>   4 files changed, 562 insertions(+), 352 deletions(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.per

...

> -	},
> +struct pmu_table_entry {
> +        const struct compact_pmu_event *entries;
> +        uint32_t num_entries;
> +        struct compact_pmu_event pmu_name;
> +};
> +
> +static const char *const big_c_string =
> +/* offset=0 */ "default_core\000"
> +/* offset=13 */ "bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=0x8a\000\00000\000\000"
> +/* offset=72 */ "bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=0x8b\000\00000\000\000"

Please remind me: how to figure out this number when adding a new entry?

> +/* offset=131 */ "l3_cache_rd\000cache\000L3 cache access, read\000event=0x40\000\00000\000Attributable Level 3 cache access, read\000"
