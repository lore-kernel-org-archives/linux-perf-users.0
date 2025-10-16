Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343442DE6FE;
	Thu, 16 Oct 2025 15:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627096; cv=fail; b=QZPrG2n7R+Bl5t9rMt5Gw4u+1+QTZTsx6zTIHa2Tf4B0q5GFlLOgh8EHKFL/5V6lym5UvzJGAiC6MDiY08UHj34oUHR54TKj6wR48p6Pw4d5G3gDhE3CBzfNSz9Z8+FcIxUWobqrd5VLvcJdbuAnA9xM0zi93OnmXLEHWqB0txY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627096; c=relaxed/simple;
	bh=bW0lYVTtbR1X6hKgTnI4AvnpNWn07ZJWQKWj4HcgMfI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OhB0vc2mS6DAPviflXDe8Uj2uZ58+M/hliRuX2WhAnzgoYiyA2AAK5VdtQmt9UruuSbWNlxPbkV+fHni7E2Tyo50hXqPlT4O3Ee7n1f9BYDNVGPs6e34oIgLuV7w2jvePV0NiAfd8V12QVLWcATBOlF32LG41pZxB+vn1LxcmZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mAQ/hMKe; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mAQ/hMKe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760627095; x=1792163095;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bW0lYVTtbR1X6hKgTnI4AvnpNWn07ZJWQKWj4HcgMfI=;
  b=mAQ/hMKeEtSpc96twLVOhbfnOuwwyqC+6MFSEr7A5YD/XWwB5YEcIsi/
   13ANHjprwNn0VN9JclWjUK4miXuM/ccYXlto7goFM3dSYE63mLm7rZ5V4
   p72kfLAaqEZjFiX3f3R7pQ16XUd01Be242QVbHrujN6YgzYGmsg07BO7c
   EGqEE1pa5v4+/2oslLDP/FgpMavQJRpEQmDBk+CxyoLot2oSrf9yuDCHL
   IdE4f6pScPG8xiwYC2GKPXZNvxA4hM8rr2p2xkN22WzOJzGiozsZc/Tvx
   vO70kzJeH2dDU9MWl0L3bTszthgs57DRIOruIc+Nqvid+AiOrNegnxv76
   g==;
X-CSE-ConnectionGUID: rb+xbe6GQAm70BgKsgEhvQ==
X-CSE-MsgGUID: pjfmiWCdTUieGzeX6zgkIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="62868917"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="62868917"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 08:04:54 -0700
X-CSE-ConnectionGUID: 01GJSvc7QJmafwJVx+RT2w==
X-CSE-MsgGUID: eDyqS2J8S6OS/K/MSEpPIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="181691181"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 08:04:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 08:04:53 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 08:04:53 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.4) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 08:04:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcKWNZcrflDmdScA/o1WttciAHoGHr1Y8KQE0EW8KLtIaa18Ae9o0jkAHybqpD4q9z1XZ/X+qqsaecrHqjStQPXzB+DH/0NT7SVfnBA7nNm8Q3wY32dO+udl742gAdZj7O/h49iFTSQhpT9D8xA414gpiIH99al0VutzALyEqvlkz4pj8HNZdKC23cRoq4uzHT1ISl/mp9kmY7F/8aDcEHvXp4qVDSt6HUOjfUFEMrXgAlTFmGmBCYT7ZiyHJfh8VigLdKF1ErayqhvcNceoF5Ynd98gL63uB0Gwj9Iev6CG0COqk2NBugBYRaDZWe61B/mbyTlNBBhyAFlZ4wKRbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4B/1ptN8zaRmQlKd3RyUzSfXFTyAF8arFsmk8ysxbkA=;
 b=Cpiyp25LJEFaos5qzYdm1TiNSAHiOab9jp4kkxKNwtXvvCtH9RIeOJhflwJ9IHF/F+bmdLrUIYLzSTeTGPLYXgvJFyIXGQNcL1yPaNtEzRkGWwuD9Is3koFpeTyvnZR9AQ+DcV05mJhsFF8iOLUE09NOKM/R2SxTtfCVFuFAV0EBXhSJaEcDGjAHXK3P9kaCahdNICMGSe9NJfak6flPshMveSS3FBoNSmGsjEmHR1efiAmGp0KpFApSTjBG+7vYP8vqjgNrdzEq7sqCJX818YykURkRFO2+mieibzN/DzEJdXmBgLQk7tpxHLu4On9+RKq/wA43+FrmUrq76xOs2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB8289.namprd11.prod.outlook.com (2603:10b6:303:1e8::9)
 by SA1PR11MB7061.namprd11.prod.outlook.com (2603:10b6:806:2ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 15:04:50 +0000
Received: from MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022]) by MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022%6]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 15:04:50 +0000
Message-ID: <9f843a5b-4fa1-4abf-9c4b-1e5433ab9704@intel.com>
Date: Thu, 16 Oct 2025 23:04:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf tools annotate: fix a crash when annotate the
 same symbol with 's' and 'T'
To: James Clark <james.clark@linaro.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Kan
 Liang" <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
	<wangyang.guo@intel.com>, <pan.deng@intel.com>, <zhiguo.zhou@intel.com>,
	<jiebin.sun@intel.com>, <thomas.falcon@intel.com>, <dapeng1.mi@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Namhyung
 Kim" <namhyung@kernel.org>
References: <baea1e93-5e30-404e-8a5d-8b1d20cf8761@linaro.org>
 <20251015172017.2115213-1-tianyou.li@intel.com>
 <4151e2e4-b7df-4c04-b038-71ff2612ee8d@linaro.org>
 <db33a977-c712-48b7-9be1-83721b23635f@intel.com>
 <046f1441-bc18-44e0-9bd0-f98a62ebbf9b@linaro.org>
Content-Language: en-US
From: "Li, Tianyou" <tianyou.li@intel.com>
In-Reply-To: <046f1441-bc18-44e0-9bd0-f98a62ebbf9b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR0401CA0025.apcprd04.prod.outlook.com
 (2603:1096:820:e::12) To MW4PR11MB8289.namprd11.prod.outlook.com
 (2603:10b6:303:1e8::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB8289:EE_|SA1PR11MB7061:EE_
X-MS-Office365-Filtering-Correlation-Id: ae6a185f-f993-481f-c695-08de0cc55aa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0Z2RG9ra1E5TWt3cXZVbm93MC9ES0E2VWNkZmRZVjZKenRhRE4zZkhnakVV?=
 =?utf-8?B?YTY2Q0E4a28vSEg5ZVRhTmJVbWZzcWdLVkUwL3lVN3dNQVVjMFFMQVpOMGNu?=
 =?utf-8?B?Zmp2WE1YOG1vZHFvNGp3TW14ZFY2R2hPRXdzK3FSdWRacXFuNC9JMldqa2Zm?=
 =?utf-8?B?b3M3Y0g1bWppYlc1Nm5XdmhtZ0lTNFVOR0Jya1JDVTVhRGp0U3N6YURvVHlU?=
 =?utf-8?B?NGVDWWF2U2dWOUErTFhSemlSSTRSdWwwZDRUOFpvazVjRU5uM0ZoKzZrZ0Vo?=
 =?utf-8?B?WC93K0R5dEhSWUJIeUlCeXI3YUJiWWFKYkJjRmx4M3duQlVDRlp6VTFPeWJ3?=
 =?utf-8?B?NHJGNnovdDVLeTRhaFI1SHl4UHVqVGtoUmZjZm9PYXJ5QkxaS2thVzI3MmJa?=
 =?utf-8?B?dTVUem4rWld6cmE2bktHdUZTOHl5S1VzMGJRK3RhZWV1Y25TdzF0aE93bnNt?=
 =?utf-8?B?QVVlajczZ2RDOVRrNmY0SC93Tjc0L1ZpbUdUTHhick5ZL1dzaS9NYWVEOTdy?=
 =?utf-8?B?ZVlOUzVHM3BjSjIzbGR1WkRjZWRtUFZYZERVN2MvTU81dnZBMkZ4dUsvTkh2?=
 =?utf-8?B?UTFLR2NIcUVQS3NnVm44MllrTDhVdm0xVTdGZEt6WVF0dFNRckhoUnQ3b3p1?=
 =?utf-8?B?RXZ3UWRmN2FmaXNhUFUzV25qclRRdjN3ZGNlMG53RXNhMUo3OXFqdVcrQXdk?=
 =?utf-8?B?UE1LR002QWVKMnRJOE5UT2lNNSsxUTE2Sm5tUjNUSzJlem10VzJOVWlObVB5?=
 =?utf-8?B?U05UYjdxUTZYTzZMem1KMlFySlRWa2xWRG5qWURwNFpiMTEveGZNY2NwS0c1?=
 =?utf-8?B?dzV5MWFSalMyUEs0M3VqdHozT1Z2NWh0dGQ4TFYzSEt6UTVIME1YSTczaHda?=
 =?utf-8?B?UnloYi94TnA5RVNPQWxWdkRpcHlDMERsRWZRdmk2SVFjNVlIZm9HbEEwY3JP?=
 =?utf-8?B?aGo4UWtpZGhPTmcrY3JLMXQ4MXNGc0F2UUc1NVl2UnVKWWVadUhoQTFhcEQw?=
 =?utf-8?B?ZFQrd1dqVWs3eUowTGcvRlJKT21zWUQ1ZWZEaWZORC9BYllDbzZhdStMMU1a?=
 =?utf-8?B?VmhkZjlaVW42bVM4ckN2R0pMWDcxa2pyNFE0QUNjNy9qWEpkbEY4aXdzZi9L?=
 =?utf-8?B?K2Q1L2M1WnhpTEtzSWhWb0hDTUYxK0RXYzArNVp1UG5kVWJNbElRSjdrejVp?=
 =?utf-8?B?SkE3dUhqbjhQbEVWb1MxVDJrblgxN3RYenJJN25TQWswTlJSejVMdlJEcGhD?=
 =?utf-8?B?dVJpNkxCRE84Ukl2UDFHZTB4R1M0YWFxTWEySFdCZ3BzZnQ5YThRcWtJZlB1?=
 =?utf-8?B?ZTZCb3RSWEo4bThsem4vUnFyYnM0ZjZMSERIcUF4VEMvMXBWU1hwaGdQMTY5?=
 =?utf-8?B?emlwaTZibVgrdC9CU25oS0pDMlBZQ0R2T0RBNnlMOEk5RmhhQStyQ2RhTlNR?=
 =?utf-8?B?S0pVOFM4NFpOZWpIVXhGd3BIcm5qemxxR0lBcXN0SGtsS0xrczg1dFY5Unlm?=
 =?utf-8?B?bjhDdk1keWpYVVhCN0VMalB1d1NkalpHQXM5NThkOVQzVWVseENySjkxOE5z?=
 =?utf-8?B?QVhFUWRmdzhzTlRGUUdyZGVYRWN5TUtld2ZXTjJGT0N6cm9PRzFHZmJuaHNm?=
 =?utf-8?B?SDB4Tk5GS3NqR2tXOVN0TTh6bllFQkp3a3ErblF0TWhlekRKeHBGN2kzeEhF?=
 =?utf-8?B?YiswY0xJUzRDL3BFaG9pSGZNQ2I4bGNuUTFrclpvVkVVcHNKd1VwWFFzZkc4?=
 =?utf-8?B?N05wTjZocUpHL2Z1V01HMzlsUEdiZFVMajVES3kzN3R5Z0t2Z3Q5RG9mNXFh?=
 =?utf-8?B?UGY4dnNUTzVEY29JOGlSODczSjJzZFBCTHBkZ3o4QjdJQkVqWDRkdjVheEhr?=
 =?utf-8?B?UDIxZWJmRHdDYk9xM29ET3N0UzBCTW0zV1VIR0lDcUdXem9KTkNXSW5kbzVv?=
 =?utf-8?Q?6EkEd0C35XcBfG2Reh3zUYCZ7+OquZP2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB8289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1F5TGZkL3krSVRsOENWTFNMVUk2aDNJWkdMV2U2cjZZek90ZklJTUFNRFJ4?=
 =?utf-8?B?OEpPUzdncUxxMzQ1emVyR2hGM0JPMzFPRjBEZnNEUEVVcnZNclhpeUZmNUc0?=
 =?utf-8?B?ckp0ZjdHWC9rZ1VibWpRTUZDUE9DVlVIWkNSSVN1SC8rOVJ3VmJZUlB3UUYx?=
 =?utf-8?B?T0dQQTJyRCtNajVBejAreHJLYlVoT3M1TWl2QTNZN09Sb2ZMTy9TbTdRN3dR?=
 =?utf-8?B?YTNyWjlPTmZiZjFKV3Z4UG9OWklWTHVVYmtGODBzcUxlbWZmQS91MEo5cFlU?=
 =?utf-8?B?YnloTFNTN3Izdno4R0k5RUVtY3R2Ri9XaHpEdlNOVmhadXEvbHhKOHEvQWxV?=
 =?utf-8?B?eHlUa1V6bEw2MlJ0eUZVVHdwVFYvdjFHSlptSXJhaEVvYmlqQXZsRnY0S0pG?=
 =?utf-8?B?NGFJNEJoUEk3VUhzYUdIT1ZWQ3RzOGROZ1ErUVhSMDZycE1QVGI5UTFnMkVz?=
 =?utf-8?B?R085dW9FdlQzRGNtSTlZTXJwSExqZ2RVRWtEaXhHdHg2UkhFT29ML1IzN0hh?=
 =?utf-8?B?NlE1UWl1RW05dG83dWsxRG5MZ0RhSzdRbDVLMDVKTEZLNjBJdWt0V1JMdkIw?=
 =?utf-8?B?YWloSmRudzFNUjJTV2dIU1VMcjVBcnpzN1NoQmxTbXdGdGJIdGU3ZUhVRFI0?=
 =?utf-8?B?ajB6MS9aMHFHRFB5VXpGYXZpWnpzeVMvczFObVRQbEp5MUx2Lzh3cHBNTU04?=
 =?utf-8?B?YW13S3RwZnU2VUU4Y0gyZ05tQmo3ZFp6cEJGR0VVVy9pbk1VNE5KM2pTek9y?=
 =?utf-8?B?OFovNnFwY1dMWExKek1FNFUzR2ZwUE9uSGtiWm9SdkJHR1JNZVNkOGsxTjRj?=
 =?utf-8?B?WGdlNHZCbTZCZHk4N0xMTFJTOXg4VTd1OVFhSHliQmZXeFRya25FS2lpZk1r?=
 =?utf-8?B?M3pQZjdaMnlZRTVVY0hYdldUOXZQOVBqY2NCcFF1SEdaSFFRbU9tcVo0UmY4?=
 =?utf-8?B?ZVk0ekMvUzU4U1cvNFZyT2xqSUJYQVM2bWFIN3BENmtSaTZkeU1yc0tvNWx1?=
 =?utf-8?B?WlR2Q3lZeElhRWF4QTdoMUJMQzBuTE1ITE5GKzR5eWczTTZ5U0VYUGRkL0VR?=
 =?utf-8?B?Z3dZWkUraXAvSmZmVVkySDRVWE9LNkRtTTNDdkIwSy90Qy9nV0dZYkovcnJy?=
 =?utf-8?B?RXplbE5VWWpoOTNTTUQzbFJtekgzc3hGd3Mvbld1Kzh4SUc5NFBKNjlZQTk5?=
 =?utf-8?B?TEtqaDFVTWhrS25vL3pIN0pGT0J4ZHlSOTFXVm9lMEVVT045aFM3cnljWkZt?=
 =?utf-8?B?L3pwWi9ONlNtamxJOC9LanVyWjFrajdQL2N3MVRaZ3FGSDlyeXk0M3dXZS9m?=
 =?utf-8?B?UnNWT1BOWXZWamRYNkRRY3RWWW9BdU1vRHh4eDI0cjhEQWlYOElNcFBVMnEw?=
 =?utf-8?B?aHlFZU1ReHh0eldvQU9mZjVyMWhHNXAxRXJEdFE4SWd5bXpqZ0FZbCt1bXlm?=
 =?utf-8?B?dGpjbEhmOW9lUWNnRDBLM05uUmk1cHREaFNaVmtMV0lzb1NmME5UckZCSzYw?=
 =?utf-8?B?RUZab24vcDRkdVRMemFlNkFWSllRUy91Qm9KeDVnNWFaLzVkM1A2NERTNVli?=
 =?utf-8?B?TUUxcnNDTTEwUVcxbVBOM08yeVp2YmVkUVM3eU50QTRJUisxYU9BYjVxaFBV?=
 =?utf-8?B?UGFYaE1RcXlhYnhkVDRPVnAzd2V3dmhTN3FsMTc5alRkVEZFQWZhdnloMGtl?=
 =?utf-8?B?NkZYYm5ING1NQ0tmalFPY09obnp4M2NVdW8zVTlnTWFvc0xyQzMxcG10a2I0?=
 =?utf-8?B?b3ZEQXdRbU90Ny95RzFYQ3ZNYzkwODluMlVMNGZwWWtMNVRXaWdadFJzbkpl?=
 =?utf-8?B?Qm41VXZHbEw1akpjeHZLNG5pUUVUZEEvTkR2NWdNdWprdnZBRWtZdVB2a0Ns?=
 =?utf-8?B?SWk5MmQ5Vy9UR2wxcUJhbGpxdWZudlNjUEdwK25mMmYybERtR0VtQ2pOdkdu?=
 =?utf-8?B?RTFidDEwVXZSK2UxeGk5MXBmTVBDaXA0eHNxNzlsejJYSWd5RElzODl5Q1BI?=
 =?utf-8?B?a0pKRW5ubUhBcTNjczBGWDdFREVIU1IxL09xTkZFY1YvNSt4eGFFZXF3SGR0?=
 =?utf-8?B?dk5aRHd3T2RLVHNKU2xLMExORjNJM2FzYml6aDNucVM1TjJ2SGlONVJMMnZl?=
 =?utf-8?Q?CRwIw9fv5Fum+7yY12sO5hKnq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6a185f-f993-481f-c695-08de0cc55aa4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB8289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 15:04:50.3642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PYoVoaoa0+Mcd5RkX2l4aFkCVR67dGyMEy17+1bILt3ecS31rUW+bLE9L4UeQXmUGZ94euhZjUAQQ1QK1+Lypg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7061
X-OriginatorOrg: intel.com


On 10/16/2025 9:06 PM, James Clark wrote:
>
>
> On 16/10/2025 4:36 am, Li, Tianyou wrote:
>> Hi James,
>>
>> Thanks for your time to review. Please see my comments inlined.
>>
>> Regards,
>>
>> Tianyou
>>
>> On 10/16/2025 1:30 AM, James Clark wrote:
>>>
>>>
>>> On 15/10/2025 6:20 pm, Tianyou Li wrote:
>>>> When perf report with annotation for a symbol, press 's' and 'T', 
>>>> then exit
>>>> the annotate browser. Once annotate the same symbol, the annotate 
>>>> browser
>>>> will crash.
>>>>
>>>> The browser.arch was required to be correctly updated when data type
>>>> feature was enabled by 'T'. Usually it was initialized by 
>>>> symbol__annotate2
>>>> function. If a symbol has already been correctly annotated at the 
>>>> first
>>>> time, it should not call the symbol__annotate2 function again, thus 
>>>> the
>>>> browser.arch will not get initialized. Then at the second time to 
>>>> show the
>>>> annotate browser, the data type needs to be displayed but the 
>>>> browser.arch
>>>> is empty.
>>>>
>>>> Stack trace as below:
>>>>
>>>> Perf: Segmentation fault
>>>> -------- backtrace --------
>>>>      #0 0x55d365 in ui__signal_backtrace setup.c:0
>>>>      #1 0x7f5ff1a3e930 in __restore_rt libc.so.6[3e930]
>>>>      #2 0x570f08 in arch__is perf[570f08]
>>>>      #3 0x562186 in annotate_get_insn_location perf[562186]
>>>>      #4 0x562626 in __hist_entry__get_data_type annotate.c:0
>>>>      #5 0x56476d in annotation_line__write perf[56476d]
>>>>      #6 0x54e2db in annotate_browser__write annotate.c:0
>>>>      #7 0x54d061 in ui_browser__list_head_refresh perf[54d061]
>>>>      #8 0x54dc9e in annotate_browser__refresh annotate.c:0
>>>>      #9 0x54c03d in __ui_browser__refresh browser.c:0
>>>>      #10 0x54ccf8 in ui_browser__run perf[54ccf8]
>>>>      #11 0x54eb92 in __hist_entry__tui_annotate perf[54eb92]
>>>>      #12 0x552293 in do_annotate hists.c:0
>>>>      #13 0x55941c in evsel__hists_browse hists.c:0
>>>>      #14 0x55b00f in evlist__tui_browse_hists perf[55b00f]
>>>>      #15 0x42ff02 in cmd_report perf[42ff02]
>>>>      #16 0x494008 in run_builtin perf.c:0
>>>>      #17 0x494305 in handle_internal_command perf.c:0
>>>>      #18 0x410547 in main perf[410547]
>>>>      #19 0x7f5ff1a295d0 in __libc_start_call_main libc.so.6[295d0]
>>>>      #20 0x7f5ff1a29680 in __libc_start_main@@GLIBC_2.34 
>>>> libc.so.6[29680]
>>>>      #21 0x410b75 in _start perf[410b75]
>>>>
>>>> Fixes: 1d4374afd000 ("perf annotate: Add 'T' hot key to toggle data 
>>>> type display")
>>>> Reviewed-by: James Clark <james.clark@linaro.org>
>>>> Signed-off-by: Tianyou Li <tianyou.li@intel.com>
>>>> ---
>>>>   tools/perf/ui/browsers/annotate.c | 3 +++
>>>>   tools/perf/util/annotate.c        | 2 +-
>>>>   tools/perf/util/annotate.h        | 2 ++
>>>>   3 files changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/ 
>>>> browsers/annotate.c
>>>> index 8fe699f98542..3b27ef1e8490 100644
>>>> --- a/tools/perf/ui/browsers/annotate.c
>>>> +++ b/tools/perf/ui/browsers/annotate.c
>>>> @@ -1161,6 +1161,9 @@ int __hist_entry__tui_annotate(struct 
>>>> hist_entry *he, struct map_symbol *ms,
>>>>               if (!annotation__has_source(notes))
>>>>                   ui__warning("Annotation has no source code.");
>>>>           }
>>>> +    } else if (evsel__get_arch(evsel, &browser.arch)) {
>>>> +        ui__error("Couldn't get architecture for event '%s'", 
>>>> evsel- >name);
>>>> +        return -1;
>>>>       }
>>>
>>> symbol_annotate() only fails for negative return values of 
>>> evsel__get_arch(), but evsel__get_arch() has at least two positive 
>>> error return values.
>>>
>>> If symbol_annotate() is wrong and it should be != 0 like you have, 
>>> then maybe symbol_annotate() should be fixed in another commit in 
>>> the same patchset as this one. Otherwise you have two calls to the 
>>> same thing right next to each other that handle errors differently.
>>
>>
>> Thanks James. I will give a try on handling the error message with 
>> symbol__strerror_disassemble. I am conservative to change the code in 
>> symbol_annotate, agreed it should be considered in another patch. 
>> Would like to focus this particular issue and get it fixed properly. 
>> Thanks.
>>
>>
>
> Looks like there was a misunderstanding. I'm not saying that the error 
> is _reported_ differently, it's that the condition that triggers the 
> error is different.
>
> symbol__annotate():
>
>   err = evsel__get_arch(evsel, &arch);
>   if (err < 0)
>       return err;
>
> You added:
>
>   if (evsel__get_arch(evsel, &browser.arch))
>      ...
>
> evsel__get_arch() returns positive error values (and maybe also 
> negative?), so "< 0" behaves differently to "!= 0".
>
> You either have to assume that "< 0" is correct and not change it, but 
> then you have to also check the return value in the same way. Or if by 
> doing "!= 0" you're implying that symbol__annotate() is wrong to do "< 
> 0", then you should fix it now to not leave 
> __hist_entry__tui_annotate() doing the same thing two different ways 
> at different times.
>
Thanks James. I looked at the code of symbol__annotate, and noticed the 
if (err<0) statement. I did not mean to change the code in 
symbol__annotate because I did not understand why it handled the error 
code that way. The positive return value of evsel__get_arch indicates 
some error happens, eg in arm__annotate_init, so I use the 
symbol__strerror_disassemble function to handle both positive and 
negative error code.

I do agree we should check the error code of evsel__get_arch, but I am 
hesitate to touch the code which I am not sure the consequences. I agree 
it may deserve another patch but not in this patchset if we have clear 
answers on why "<0" is not correct, or we have a case to break the 
current code as a evidence. Thanks.


Regards,

Tianyou

>>>
>>>>         /* Copy necessary information when it's called from perf 
>>>> top */
>>>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>>>> index a2e34f149a07..39d6594850f1 100644
>>>> --- a/tools/perf/util/annotate.c
>>>> +++ b/tools/perf/util/annotate.c
>>>> @@ -980,7 +980,7 @@ void symbol__calc_percent(struct symbol *sym, 
>>>> struct evsel *evsel)
>>>>       annotation__calc_percent(notes, evsel, symbol__size(sym));
>>>>   }
>>>>   -static int evsel__get_arch(struct evsel *evsel, struct arch 
>>>> **parch)
>>>> +int evsel__get_arch(struct evsel *evsel, struct arch **parch)
>>>>   {
>>>>       struct perf_env *env = evsel__env(evsel);
>>>>       const char *arch_name = perf_env__arch(env);
>>>> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
>>>> index eaf6c8aa7f47..d4990bff29a7 100644
>>>> --- a/tools/perf/util/annotate.h
>>>> +++ b/tools/perf/util/annotate.h
>>>> @@ -585,4 +585,6 @@ void debuginfo_cache__delete(void);
>>>>   int annotation_br_cntr_entry(char **str, int br_cntr_nr, u64 
>>>> *br_cntr,
>>>>                    int num_aggr, struct evsel *evsel);
>>>>   int annotation_br_cntr_abbr_list(char **str, struct evsel *evsel, 
>>>> bool header);
>>>> +
>>>> +int evsel__get_arch(struct evsel *evsel, struct arch **parch);
>>>>   #endif    /* __PERF_ANNOTATE_H */
>>>
>>>
>
>
