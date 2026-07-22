Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB868380FC8;
	Wed, 22 Jul 2026 06:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784701966; cv=fail; b=Yy36Hb976L6uD2PK1R/zQrtlPoXv9MzHzkKCJYoZYG84cVvA5USwNTKk5e5bDgeQsfZJYqzSsKcFnN27EHPcv1yKP/971SfKawjPXgW3p+a/XIiU2zPVQ5Ue7O6li6ZGIdR9ecHLl49jc4NoFzIu82XneOguyHJBR5PxvRw2RFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784701966; c=relaxed/simple;
	bh=dAAFgKXTQXUoPSR5X+yQ7DiHhCUlEgNiCit/qPnH4h0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lCejnj0dAkImhDDOYGBZTd0DrkP5eG3AirWg6iNTO4h9MZr/p4C/JTcTp0O8CQyCPwL4BikK4RIAmz+i6v1fSsqMnm5dnZhUJ1jm7OPW6lPLU+zl5VyAfRr4eaGCxeiyTJFyIqfrkUn9w73n9IoFBuwGkOTZvnhdgwHG/lSmWoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PW8WaxEo; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PW8WaxEo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784701963; x=1816237963;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dAAFgKXTQXUoPSR5X+yQ7DiHhCUlEgNiCit/qPnH4h0=;
  b=PW8WaxEoQncuwNU4N5d9g+eE11Eq9JXmkVjJJsf3fbzVhClguCpabmVk
   +rhoz9Sko4WSQOvGzvcG7QBNkae74j9JuBe+eBLtdSoAnRVfvtgzARCf5
   qUtoGIfFBu3E0njYs9YC5IXdjxbA2n0/NUjd6jvIceOnK8zWCi/eJmVac
   qqWOTsRdGjF/oalbmjpnX3ASC9ywqxqj4lgzWD3uiZTfeOLbxAeoxwgnq
   8EDh8XyHNNK1P5LePNLzAA2dUFYgSuEaIEj6et4gDOGcuqxwQSi35Obns
   3uxWQif3uZTUAqlmKee/kmq0jJhyZdi78Pk0X1Y4YcI1vU6j1a+O9cZ6t
   A==;
X-CSE-ConnectionGUID: hnK9UhgkRCC5cfh6Oc3EfQ==
X-CSE-MsgGUID: jCocEP90Sv2eZvuPSM/AmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85447228"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="85447228"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 23:32:43 -0700
X-CSE-ConnectionGUID: ugYuxdCvQdSP6UKqPqZggA==
X-CSE-MsgGUID: I+MykZMMQwadKIPfL7RrGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="256777141"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 23:32:43 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 23:32:42 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 23:32:42 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.8) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 23:32:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zv8fmwI2b4ZfHFR2ZGopwt5QJrTwRnFXvQIUKvCq3y2Vv7DI+CukVmFkGpVeLfmrRHfVxO9SvQ1f1yZjNCUW/ZXuEw4OlbcLfMdqVU46kgifC1ERRz0eTWjTZqPXPvizN+d81P91YvOKvVSGxJI8RwgzEDDmNyGQ9hGbKaRWecza+vf9wTUi9jAWeMbzLJqqe+FFUB3sQIitk8xpelgA+q0dTvGYON4W70aGYyIpR9vu7sLIWDYaHqHkkxPQmjJst+ZEvwMtQVBIYFZqYRBuw0U0Yti52G+vo6aLsHj6g4/o4z9upA5KZlx8x4bzvtgSyLt5SHwRUg9ZPN/jd4kuyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8EbKFVew+QjOyTOqUflBmEnyc2vsKZ3qig/vMjSdD8=;
 b=TcVtaUc8CxfiFBQNfe4pI/NELxyOGXmanIsQqwis6cWZZFN/Y12vC3dfsGLUkowJsMNsjt5OCQEvfqd+N/76OyK5sd3AK/5m1N3ve0fAQNNrL/GmTNiyXiJTzjcDRZPb4Nqzpb97Wdmf8L/AVsWaVJuofVEDHggilPA8kRGdrn3Qrxi2x9igFjTHlrDhni5Y3ZwYqm/gJlWA6mT4i6lEX6nbWvGoAclAYtN6viP3kr/GCvwtWdZzwPinfnYGkfmsu9CVgV5e2LEDF5RnDOZ/c3wJLAWUrV+BM5EW/m1CXK3+cZTMRg6oOw1SptNPwMIJaiXDSkWqFyRR5hJNei+SCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 06:32:30 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 06:32:30 +0000
Message-ID: <8fa4da51-6fee-450d-915a-eb4c4de03961@intel.com>
Date: Wed, 22 Jul 2026 09:32:23 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/21] perf auxtrace: Set default period to 1 for
 PERF_ITRACE_PERIOD_INSTRUCTIONS type
To: Tengda Wu <wutengda@huaweicloud.com>
CC: Peter Zijlstra <peterz@infradead.org>, <leo.yan@linux.dev>, Ian Rogers
	<irogers@google.com>, Kim Phillips <kim.phillips@arm.com>, Mark Rutland
	<mark.rutland@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Bill Wendling <morbo@google.com>, Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Zecheng Li <zli94@ncsu.edu>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>, Li Huafei <lihuafei1@huawei.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>, Namhyung Kim <namhyung@kernel.org>, James Clark
	<james.clark@linaro.org>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-12-wutengda@huaweicloud.com>
 <07c8c780-5eeb-4310-80cd-3ff18952a688@intel.com>
 <f7a94138-e29f-4b1a-948d-ef4933e7d0c5@huaweicloud.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <f7a94138-e29f-4b1a-948d-ef4933e7d0c5@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0339.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::18) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS0PR11MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cfb917a-8265-4b32-1ec6-08dee7bb0137
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|6133799003|4143699003|56012099006|11063799006|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: srSy0qM34IOWpIVMrQacTNFAFbtjDP550ph20fQzz1UZ//3s7e7LovAAExVP4LjObE5lXo/zJlI7rl+6P6pniBtU5mHvwbgNH7ARasmZsKa2sg6Q3nPANxxOkC47pgmcUyDgIidlK6lhYSVOK/5PHqyZ06NFD9JP7GkqdGzBvkkR91vEkwltn65kc8hXi+5Htsq03UEcl7pPkasdXqzUw2glwBTZV5PpP7zNBjFhq1Vii/BZQwcv9B0iST4RvCZmcLZawZkarHtwAuVprRo5e8nfhCEJ5Pc0fGmxKfNmvunrSH/y+zf3nADHJ5NYz8Bo8JSidIR5/T+TYI7+U+zSsyxfe2DrSGi1/VXyH208sSVqN32U/+tBQRjJic0aAzjJjyRVsimcADPSMU/5mj3QCCV33E+lBmMZ3a1csBKOrIWSLfekMZuF2FIZI2aa825gVnJAo3WqsltzwSTx5D9eyfgNPXuon5EIG4+vS7VQlOxFsbCkzzLBWxKTVK4BTC7toX6T0anZ2JiyLWswQMIg5Usw84bvygYB60PAS3iq6tp2i/5f4FuagmqJOZFV5B7SfbAGYwnypP4nHG/f1cCpNCtQ4f1eWPcmh1paflmAdzROsLEBLk+/Hjq/KT3tBpiRKY8hZbWp2ErXvOu1TN3V3jO2F39AgGBwKplP3GQBoLQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(4143699003)(56012099006)(11063799006)(10067099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVR2amhTRFB5cm1HM0RhME93eHNsVG5rYVE4Y0lzWXVsWTVZTFRyUllsK3pN?=
 =?utf-8?B?cThRQk1peExyNElNY2hzM0dzbHVRUmg2Mko4M25rejBmZDZ2MXpreHlRSXU2?=
 =?utf-8?B?eHhRU2RXTlo3TWlYV0hJQUpuaTRpRGpDdkR0bjZZdzRGTDdnQVVMdDBMWmRh?=
 =?utf-8?B?NUY5b0FkTkxxWVBobC9RcFhhMEJNbVcrUkJiMFRFcWRNVlRYZExTeGFvdEFs?=
 =?utf-8?B?dDZCTnhzK09VWXpicUdJalh2blN0dUI2NHFldGhJOFV5RHducVU0WUFGZkhQ?=
 =?utf-8?B?YjVaRnpMZVh5UGVReEdORkpINVNhTTVWSHpQZi9MbVJUcWxGS2NhekNvMWc2?=
 =?utf-8?B?d2NjZWY3Mlhoc3NvekpwMVZJRktYeWFrSGRJM2gvZFN4Mmw5djVBVTNPbjQ5?=
 =?utf-8?B?NUszWmxwMXhYeUtpc1RWaU9ESjZBbG5OSUFLUHk5UGZxYmVFSURhL1VJRmtL?=
 =?utf-8?B?NjJJUXBEOUt2VEZmTjFEQnpLWlhLclZQS0hmRGZ2eUo1Q2JQbG55SzVaNkRT?=
 =?utf-8?B?NmdZN1BJLzRQcis5QkhHVGRGNmpvY2cvY2Y0ejhCZTNiM3Zia0pWRkNvOGIy?=
 =?utf-8?B?YUllUGhwWjIycDFScm5WNFVMN1BpTmhMNyt3ZnBsTmdWOUJVeWQ3Nkg5TldU?=
 =?utf-8?B?aDRjVWo3RVR1YkRnMlJqVHR4eW1XMXdiZThqSEkyeTVTTFcvQmY0SzZxVEk2?=
 =?utf-8?B?cWh4Y3BLSHdqa2Y5NkFMMG44QUlhVGFHM1ZEN2Z3RWQ1OXB1QUdjeHdMbzVx?=
 =?utf-8?B?bDVSUVF4MEJNckxtSCtWbjN3UFFNRS9oRThFZkp6UW44SlUxRmF0SHVkaUFs?=
 =?utf-8?B?ZktxVFl1ZHE3Y1ZFQVRIQ3hNRThFTzBteCtGSFl5VjNIclBKRmcyT3RKVFYr?=
 =?utf-8?B?UHJVQkFHdVNDT0FxcXNhTFlNRXpqbHNWQWFmWEFjUmlxVzdxbEU4Ti9PSUNt?=
 =?utf-8?B?Sm11d2R0c3NXK0RIbmo3enlDYmhDbC8yK0Q5ZDZkKzI2dURDd0xwdTd4UCth?=
 =?utf-8?B?UlpsNFRSMnZQeXBoYlk4VHcwYkdGa2Fia0puYWlZN0tXUFN5cDRITzhxNmRL?=
 =?utf-8?B?eEpaQURRM1lNVm5lckJPMTZWRGZSdHV4YVZyWUZwQ1hmbEZyL0JhM1lERzNR?=
 =?utf-8?B?dFBPczU4TkI2Y3NoRnlCdWNCOVBmVkhlZzhua29HYlZTVEtYdkExLzNzYlNX?=
 =?utf-8?B?a1JsUjBPM0lVR2xLL1ZzcGl4MmZyeTBmNG95UDJZZm5Bd0VsN1NzUVpncGE5?=
 =?utf-8?B?T25zaXhlbHJ4ZGMvcExkVk1mbFFwTFZsalpuTjBTZ3doZHlIOWR6Z0sxYlFo?=
 =?utf-8?B?bWxQb2w1c2lrZ0FWSkNEMTBFWjhIT2RYYVI3a3pVQ3JlRk9XajBMYkcyNHVM?=
 =?utf-8?B?bXNYemlvTnhwbS9rajV2dmZJMnhmd01MdHRLZG94L3dCVGpRbk5GMzY5c0Ev?=
 =?utf-8?B?YjVPTGhRaUNHRDlXZ1pZVWVpRHliUnZuRUh2dFRUTHZiR3Z3azBRY3JQbnVT?=
 =?utf-8?B?T1paSnpxYStES1VIWHpYSmhpTE1iaTJVc2l2REFqTVoydkFOMnB3RHE0anVO?=
 =?utf-8?B?cndwOW9lRmFNVW02ZXhxd2dHUGVGdTNvZDREMmczUHVpRms3WEprUTBHU1px?=
 =?utf-8?B?ZlFVaGtzaWh0REpSV1IrNmF6OW5hTFQ2ZHVpWjVmK1FPZjc1bWpxTEtJWE16?=
 =?utf-8?B?Skw5c1VRVVhWVnBmN3ZuS0UreDZVSFJNQmxuU0JEb1k5SG9iUnhZeGlkZzZR?=
 =?utf-8?B?SzNPc0ZCcHdCaTVaMHBia0FGMmxyU1F3V0RlQmoydVZOcExkc2M3ZXc5Z0gv?=
 =?utf-8?B?bHViMXBPTHFZMThVaXR0R1FnTnEwc3B4MXU4OG03czdCTU90c3RDZ3lEcXB4?=
 =?utf-8?B?SGJ5b1B4cC9xODRwSXNkZTBKaGhmNkJsdWVDSVRqWjZ2d1NTRm9LbVpudDho?=
 =?utf-8?B?TWFoTXBZaGpsaHBqNWpJSDQ1SnNSYzRMQ3hrQUNMWEFRS3lZU1lWbkpsak9G?=
 =?utf-8?B?TTBZd1N0TStPbFhHN3NjQkVoV2k3NnN3NDYyZzBuVHErOTNzU0ZSbXcxVVVz?=
 =?utf-8?B?QkpoZnVUNk5oVnF2VktPRXpsRkhzVGRWU0hWOTh0UDBoQ3BrYWNjbFBybXRQ?=
 =?utf-8?B?cnF1aDlaeE1HczVVaGhaMUhKa2hGT2MvRVZKTHdXSUtkTTJUN1NqbTJWdnJQ?=
 =?utf-8?B?UU5sR0FDVjEyK0JNZ1pvUmRHbTBtVjk0cDIxTENCbityRFpjSFZidU9LRjFD?=
 =?utf-8?B?QmM4SzFsRzdNVEoyYWFmUHJtYzFEZHg5NUo1YVdjMjBicGNtYmpyTXNibGRi?=
 =?utf-8?B?RWo5bEcwc016c0Fkd3NMUGtSRXZ0azY4UWh5dUFYQ0lZcTRwY3p4SHhHTEU0?=
 =?utf-8?Q?v/usHvBPRp+KJ7Q8=3D?=
X-Exchange-RoutingPolicyChecked: cOkPkLW0w9GIPBZPkznD1lEKp4BDIV4mZSGQzzYgyq9gDl4s2Yio2jUC8b3uQ3Zr/Ad1STfoSKbYKnLqhAvSgn4kBcSHZLMnK1dBRdHrjvu3kVt4++bblmkoQCJuwYfk+GhZqYiLYh9+ZBgucxICh1C7k7G3OfnW0X+6kHdre8wc8Su9C6IpFBYRM0YpDB32RuJcBAOYVntw1HeAgGreg7EQc6iX+udiSfY0zd7BFqniH2CCII34D6TvwIIAEPrr77qXV944lEI4kbiZ0rNdBCSCgZ5b89aApz8DKT3NOsbP2rUAl0wzv/oUYHmCapQPRIgdCslO8mibGbYE0nDosQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cfb917a-8265-4b32-1ec6-08dee7bb0137
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 06:32:30.1258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pn30Niole6Sqs2LFcShZtSsIHApTdjUo7cvGTIoW5D1lWBjNKsvgTPpkhQnvo17BM2HwHwOk0YKWWIlGAgdrXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6373
X-OriginatorOrg: intel.com

On 21/07/2026 14:39, Tengda Wu wrote:
> Hi Adrian,
> 
> On 2026/7/21 16:08, Adrian Hunter wrote:
>> On 01/07/2026 06:53, Tengda Wu wrote:
>>> When using --itrace=M for data type profiling on arm64, the 'Percent'
>>> values in perf annotate output are all zero:
>>>
>>> Annotate type: 'struct mmu_gather_batch' in [kernel.kallsyms] (15 samples):
>>> ============================================================================
>>>  Percent     offset       size  field
>>>     0.00          0       0x10  struct mmu_gather_batch  {
>>>     0.00          0        0x8      struct mmu_gather_batch*    next;
>>>     0.00        0x8        0x4      unsigned int        nr;
>>>     0.00        0xc        0x4      unsigned int        max;
>>>     0.00       0x10          0      struct encoded_page*[]      encoded_pages;
>>>                                 };
>>>
>>> However, adding the -n option reveals non-zero sample counts:
>>>
>>> Annotate type: 'struct mmu_gather_batch' in [kernel.kallsyms] (15 samples):
>>> ============================================================================
>>>  Samples     offset       size  field
>>>       15          0       0x10  struct mmu_gather_batch  {
>>>       13          0        0x8      struct mmu_gather_batch*    next;
>>>        2        0x8        0x4      unsigned int        nr;
>>>        0        0xc        0x4      unsigned int        max;
>>>        0       0x10          0      struct encoded_page*[]      encoded_pages;
>>>                                 };
>>>
>>> The root cause is that when period is not explicitly specified in the
>>> --itrace option, it remains zero after itrace_do_parse_synth_opts().
>>> The zero period then flows through annotated_data_type__update_samples()
>>> where h->period accumulates to zero, and print_annotated_data_type_value()
>>> calculates the 'Percent' as zero.
>>
>> The period is for instructions samples i.e. options 'i' or 'y'.  Why is
>> it being used in the 'M' case?  What samples are being synthesized in
>> that case?
>>
> 
> The 'M' case is just one example. On arm64, 't' and 'f' also have the
> same percent-zero issue.
> 
> How ARM SPE synthesizes events:
> 
> ARM SPE can synthesize multiple event types from a single instruction.
> For example, the 'M' case targets instructions that cause memory
> interaction events, while the 't' case targets instructions that trigger
> TLB access/miss events. Users can specify the desired event types via
> the itrace option to obtain corresponding data type profiling results.
> 
> How data type computes Percent:
> 
> Data type profiling computes Percent based on the period. The flow is as
> follows:
> 
> arm_spe_prep_sample():
>         sample->period = spe->synth_opts.period;

It seems like only arm-spe has the unusual period handling.
Please make the period non-zero when it is set up in
arm_spe_process_auxtrace_info() and add a comment explaining why.

> 
> __hists__add_entry():
>         he.stat.period = sample->period;
> 
> annotated_data_type__update_samples():
>         h->period += period;
>         h->addr[offset].period += period;
> 
> print_annotated_data_value():
>         double percent = h->period ? (100.0 * period / h->period) : 0;
> 
> Therefore, if synth_opts.period is not specified (remains zero), the
> final Percent calculation results in zero.
> 
> As you pointed out, if period is intended to be limited to only the 'i'
> and 'y' options, then setting period to 1 in the current patch may not
> be appropriate.
> 
> In fact, within print_annotated_data_value(), Percent could also be
> computed from the sample count. Moreover, I noticed that 'perf annotate'
> already has a --percent-type parameter that allows users to specify
> whether Percent is based on period or hit (which I understand to be the
> sample count). Perhaps it would be more reasonable to adapt
> print_annotated_data_value() to honor the --percent-type parameter
> instead.
> 
> Thanks,
> Tengda
> 
>>>
>>> In itrace_do_parse_synth_opts(), non-'iy' options have their period
>>> type set to PERF_ITRACE_PERIOD_INSTRUCTIONS, but period remains zero.
>>> Since a zero period is meaningless for this type, default to 1 (one
>>> sample per instruction).
>>>
>>> With this fix applied, the result is as follows:
>>>
>>> Annotate type: 'struct mmu_gather_batch' in [kernel.kallsyms] (15 samples):
>>> ============================================================================
>>>  Percent     offset       size  field
>>>   100.00          0       0x10  struct mmu_gather_batch  {
>>>    86.67          0        0x8      struct mmu_gather_batch*    next;
>>>    13.33        0x8        0x4      unsigned int        nr;
>>>     0.00        0xc        0x4      unsigned int        max;
>>>     0.00       0x10          0      struct encoded_page*[]      encoded_pages;
>>>                                 };
>>>
>>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>>> ---
>>>  tools/perf/util/auxtrace.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
>>> index 0b851f32e98c..415b68a2bba9 100644
>>> --- a/tools/perf/util/auxtrace.c
>>> +++ b/tools/perf/util/auxtrace.c
>>> @@ -1759,6 +1759,12 @@ int itrace_do_parse_synth_opts(struct itrace_synth_opts *synth_opts,
>>>  			synth_opts->period = PERF_ITRACE_DEFAULT_PERIOD;
>>>  	}
>>>  
>>> +	if (!period_set &&
>>> +	    synth_opts->period_type == PERF_ITRACE_PERIOD_INSTRUCTIONS) {
>>> +		/* Indicates a sample is taken for every instruction. */
>>> +		synth_opts->period = 1;
>>> +	}
>>> +
>>>  	return 0;
>>>  
>>>  out_err:
>>
> 

