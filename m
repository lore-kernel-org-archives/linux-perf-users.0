Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47303224;
	Tue, 16 Jul 2024 02:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721097578; cv=fail; b=B6ph4/mr+58L7JdawwTIRJoMy5HqECgdHTQZq14iyBlGZSAb7gtqUWxcwJdWacOk9QSqo9EejelEFBInHZe2XGpvh3t3w6LRH76duU0sCyew3Twq5e0yitI/sm7eubstZcUmooP6r56ezsMOpR7ZpDAquIX9FpzrgLGL1sRzqtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721097578; c=relaxed/simple;
	bh=hQV4ATChFM6xjWGN8VSWnw/TC2TifAx997yKsNYbHD0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FxZROT+XgEHc6YZknJHOtHF7Hko8hn/GFhhuehFRHxTIqhopna42mDZh8kpzG8ZUixX4Bo4hEHgfKzuKH1Xw2VriclqnrwriKVz2ByxlCXHZeUrv3f0haam5sDryE3JyLJeK/RNjbNzi5aUJk2k/qaGrm8Xl8DPRjDw01DL1JQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DU0Vnbox; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DU0Vnbox"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721097576; x=1752633576;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=hQV4ATChFM6xjWGN8VSWnw/TC2TifAx997yKsNYbHD0=;
  b=DU0Vnbox+Cvc6EM9D+6PztFIdENFvEZVsrPOXqBjooc1mYQUxbJoiKjT
   f3IOL5xdOy469wsfq3pA+47764SxyI84Z7etVSJw9sTAn4uTmxd3NyJlv
   6oEHVJ1JmgQqdgnFhrCKXCX3T+Xw8CAfuYLuKaAR16O4PcfWp9VvFD9M/
   g/6JD/XbkS94we4TrsUmrFv86NfR/kAYctNSi0urFe/rRTmm8Lc4FEHRw
   wh482onyQqhDKvXRkTS/you+MujThBsql3FNY0zi5AWu5+zmzmHna+Qk/
   hRPVGitQlArEQ6w5dLmhpJ/odZa89BO+WYESJ27jRyDLcCIB9GUJGBNfc
   Q==;
X-CSE-ConnectionGUID: mn4zS3KaTyGDD3czSgnMAA==
X-CSE-MsgGUID: JZtDRi2CTwuGaeT0w0Oa/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18357298"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="18357298"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 19:39:35 -0700
X-CSE-ConnectionGUID: gR+2OWHWQCWBWydizOSjTQ==
X-CSE-MsgGUID: FsdkRIMZR7WJC8xNIpWdvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="87342359"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jul 2024 19:39:35 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 19:39:34 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 19:39:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 19:39:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RquCLxwEHTcF/sQ8/xE+fZBsN6jZX18x0kQ+GdqVs5AOuYuCbMeH4NJzbMsR42Gqa5o0nL6k5rWCMB78cOGZpoaICqH5XdgHCXG4nqyHs1yMJpzSUCKEqKegwIFB/Yq5kdInlejTsQSJBbPWb09tzFbmjvk+IwkfAjSJYUxwWvnySbLtuqeY/upVjviRYjGY9hH3Il2K698CuwkB/5uE2pORWkg4E3Uj4ns3F8EA0V2iKGIFJXpaXv0VuUC+1B3KxzKTKVqOIotI1fPkgzxBUIQv6sj5+/g/MgotU3EbI+LGbyfB+wYIbfIz7YlGXaieSTcH1vuJt0boE3xWDWbALQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arp6q3fUu3EZiNcX+Zm42JCHaIzqW5dOLwfht4/ET9Y=;
 b=mOY1P78UHMuoLYeIgYakJggKLcHXTpPjj67SWiApXlFzvA4wnOsEvbV0VbxnLQe4f02OJ5YTz8uDavQeAU0Jz+sZThutYyvMbf17VgXRngX3SW0K4lDJOpURdAwnLvBzDc3e0pZKmeShXxGfi7hTy2h3NmBAmv3xvoOoAY1LIUj73WH1sJAIFAjOHzALtdwgCdKH2j7dqTDoSFLfNengCLSkHLUCYUvTF6RJnJZWHMLgEWWugMlNCObM8ImPfsJCvbj6VZwBjgsK7LnCTHRjK4Itf/Kd5eFPOgcQSIrGfh2X2YLQ2LiPACEGwUtIGi5u7cl0op7ido8uXQhX/9/Z6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by IA1PR11MB6537.namprd11.prod.outlook.com (2603:10b6:208:3a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 02:39:26 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125%6]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 02:39:25 +0000
Date: Tue, 16 Jul 2024 10:39:14 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Ian Rogers <irogers@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Weilin
 Wang" <weilin.wang@intel.com>, Peter Zijlstra <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Kan Liang
	<kan.liang@linux.intel.com>, Jing Zhang <renyu.zj@linux.alibaba.com>, "John
 Garry" <john.g.garry@oracle.com>, Sandipan Das <sandipan.das@amd.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v2 2/2] perf jevents: Autogenerate empty-pmu-events.c
Message-ID: <ZpXdUiNhFbqJvkZK@xsang-OptiPlex-9020>
References: <20240525013021.436430-2-irogers@google.com>
 <202405311548.1e881dea-oliver.sang@intel.com>
 <CAP-5=fX7ZyT82=W8uSZbT7c76E5+1JaoR5-y_gcj7A_=Js1YfA@mail.gmail.com>
 <Zl3Q7AtOWY8ZCcg8@xsang-OptiPlex-9020>
 <CAP-5=fU=UPpZTULuyZm=Ep0Ri6SdTciL5kqpciUfnWyDvz6HZg@mail.gmail.com>
 <CAP-5=fV5Qdu5iH_DKeAXQfEmQN9SmxCViSgbOCvAmN529WoeOw@mail.gmail.com>
 <ZmphzTKiDDYkPPP+@xsang-OptiPlex-9020>
 <CAP-5=fUUnnL18x_mdQdaCePOSbk5VWP3jfAS44n7qahD7pja5Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUUnnL18x_mdQdaCePOSbk5VWP3jfAS44n7qahD7pja5Q@mail.gmail.com>
X-ClientProxiedBy: SG2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096::13) To
 SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|IA1PR11MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 323ceca8-dd57-405e-d69f-08dca54081b4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFRTS1RPYVBDRy9nb2YyVFBHdmFFT0s2dXlPVWptSHBBVWRNOTkvN1NhanhU?=
 =?utf-8?B?cFBLTUFBaXRwL0l2VzAzM0x3UlliQXBEQ1dteGExN1EzWlh4RFZXT2Z0MXdK?=
 =?utf-8?B?djk2ajdGTDc0czFwV3NMOXp2Y01FUy9vUWhTZFUwd1hCMmE4Z3FUNC94WE9I?=
 =?utf-8?B?Y3B2ekNOYkx0VU80YzFDWHJzeDl6Q2JtRHBwSEdNNEE5R1lOa2dGMEdyZE9o?=
 =?utf-8?B?VlU1VWEzcjJWd3QyU21VQ1ZUL0ZvSmc0SjFWL2xCNGorOFAyL3gyRVdaZ2VY?=
 =?utf-8?B?YTJEYzdkd1dFUlVKdm9nMnlUT0VIZC90WGhiUmljZXVUMDZmaUpWRGtKUTlR?=
 =?utf-8?B?S2g3ZEFZNHJNMnhVUUxOTFNyaDhmRG1ORml3ZzZ2MVpLa1JaSk9sa0NWbzFP?=
 =?utf-8?B?czFDZEJEZzhHbFJCMkRTbTA2Uk05NXNSbjBwOERUelR4cWJZS2lRemFVckMx?=
 =?utf-8?B?YzRMc3Y2aEJQb3FKTTVKU09GaDMzd1hLeVZHcDIxQzZ6bzlLU3d1ZjBZcnRI?=
 =?utf-8?B?Z0prV2RqLzIzNXp5dVoxSVFpQlhBMHZhRFJaNHJuTWlVdlMvbFJ6RkNCWml3?=
 =?utf-8?B?UkJZZ0lRSlNFN3VLb3gwNnBaNmdVbWVEdmM1WTNqc0pSMVUxckJKQjdEdUky?=
 =?utf-8?B?V0pON1hyakxvTW5qV2k4ZWNib1VQTE5zUERqeUxUdzNLZlJwUm10Z0MrNTdP?=
 =?utf-8?B?TUdmR0xjNVRmRU5tZXIvUytlc0dxb1ZacW5mTThsV21rYVFhckRTWm53eGF1?=
 =?utf-8?B?aml2U0RKRzdwWHhQeXg4anNNNUtRWDR1QU9VcFdHOVN4YjFOYmZIVzdlcDQ5?=
 =?utf-8?B?VXU2UnJjSUJqdFhyK2J0aVpuU3BjSDQ5ODQ4VnZHUEQzc2NGVHpIUllmTTBq?=
 =?utf-8?B?ZmdyMXhnZWMwS0ZVczNwRWFlTFd2eER5ZStvN2tMd3JXWk5YM3J6ZkNGdWdz?=
 =?utf-8?B?WklsUGIvLzljVmczUHdObmFKUGs5bzk3bEJkakM0eCtsd1RRdk0wWGpPeHND?=
 =?utf-8?B?VWVmdGhBTG44Yk5JbjFrbWFMYkQ1dUU3QVJLNkdMZHBGZXF6dERxRmxIVDIr?=
 =?utf-8?B?VWR5Umdjb2VWWk5mN0ZScFo3UGlmMHIzSStNTHVlSWMzYVo2OHpLYy81Zlpk?=
 =?utf-8?B?WGVFakJKajVtYzNPMDdzTWNhd0VRSVFhRHNGaXZEY3pLSVV6NGJMbFR6STNt?=
 =?utf-8?B?dDVEUWUrRExBSEh1bS81N0VrNkdKRFpQZXIrYkxIb0k4ZCtSVXVtNTdSTndE?=
 =?utf-8?B?aTFrdWlOUFlSZE95bUtXWFF5MnJoMStCWGZhNTZnRWMrZW5jT3RVbGdSV3lh?=
 =?utf-8?B?cXJqT3JHTUN5aEVIQVltT2FOTFJPTjV1czQzbmpnak1QRUpQbWNUcXZmMDVz?=
 =?utf-8?B?Sk1EQ2c5ZmxMeU0ybGxWOU9MS05kV2tzZUlycjNMYVJRQTE0ajd2YUZEOGRp?=
 =?utf-8?B?b0tQR0lvRGovMHlheWYwWmR2cmJ5enFEMkpWQ3lOQTdTd2JzT2ZRZ1doMGFH?=
 =?utf-8?B?UDJ2ckZ5Ymd6WUNUQlc0eVhzMXBlbGgwVUxPYmg4dUw5VU9IZU9sN2ZYNDd5?=
 =?utf-8?B?YWtmT0N3L0pNeURXeExTaVBncDFhTngyeXpBYi95OUp4NFgzaHA0TENEZFcx?=
 =?utf-8?B?MWlYL0lPdDJNZ3JGZjZDdkEwdkcwdXBTNWViZXBLcmF4TEVvRjUrVjFQN0NV?=
 =?utf-8?B?MlJKbFZqY0FJOXU0a3grM0pzNGZEUjRZL0F5bERsaStvK2VUdUJxWWhENG9m?=
 =?utf-8?Q?V6dFc/CAsra48FgQas=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?di9ObU9SQS9WRU1CcWhNLzN5dkNvYnV3dGlaSlFoTjZRNHRDdTVsc3dCM28z?=
 =?utf-8?B?VzZ5dWR2cnRxa0dmbk5qTGI2WjFBS3psRE1hQUI3dzlzWDVsbEticU5TZnVS?=
 =?utf-8?B?NHNXanQ5NVZhY05WY1A4RjJuVjhVZVRTcU9rTGFwVUJDbUpHZzhCcUdXb0NY?=
 =?utf-8?B?bTlPWVJKcWpKUjI5TlNINUM0UzhCYTFqalZ2ZndWbjBucHFZZFlGWTd1NDRy?=
 =?utf-8?B?emowZ2RIZXR3K0hRaWh0cGpLNStGanpUcEZ1b3N2bnJIcUNxRXcyNERrL2ZH?=
 =?utf-8?B?QS9VaDM3QkxLNzI3T3g3eDFVTXBlRTA2dlBMYUZLQjB6MktySFFkd3BtY1J4?=
 =?utf-8?B?R0h2VVNLMEljQzE0alVnYkRSNlZIaDU4U1BPaysyWHJlVUZmYXphQkRKb1Ax?=
 =?utf-8?B?d0RPN0dPSXZEWTBKd2liSTFVYlFVYmV2SVZjanpiNnpPUUJUbVdWbUdENU1O?=
 =?utf-8?B?MTBTNWJFc3ZSYU5tVlp1WFNCaDYwY2NEK1JFTTNsVW55RW52UWxrdEZmV1p1?=
 =?utf-8?B?Yy9UWWxrbUVTZk5hK3UwOEdqRitneFlhS0VwM3FLZmR5RFFlNVc4eFZpTUxs?=
 =?utf-8?B?SGo4VjFGZW1NZmZ2bnlMSTdkdDVzd201NXlRRCthbkR1eE9oaEhETmhWekVM?=
 =?utf-8?B?QTBrS2h3V2laS1JwajhMS3Z4RmZac0dQYllxM1BJbno2L3ROMUtDUHpUODBJ?=
 =?utf-8?B?TWdpcEprV0tiOEM1RTFDNkZraW1vWWtUSmZ0QjFieFBqVkZjZ0ZSSUtVY3Ir?=
 =?utf-8?B?bzA4ZlhMNUtkdytiRHU1N0dFbXlJc0svRXBZZzd0RjlJeFhEa3c1aXVtT0I0?=
 =?utf-8?B?Z0doa091em1oTy9xYlp5aGNjQURrYURMSVBNTmZVSWY3VUplMmNJYnhEWlN3?=
 =?utf-8?B?bjkyZ05sd2FGcXN0WHUyRCtxaGMwb2tsUUNhVWFscGZFTTh2dGhLYkhWVC84?=
 =?utf-8?B?Nk1YcGo1VjdFZWJJU0prL1VtTkNEbCs2cTlxWjI5Ukt5Zk40YzJUNkJ1ekpV?=
 =?utf-8?B?aC9reVhpZmF1OURmUGdKaGV1ZmZkbnBnZXE4eEpGcE5UaGUwa29qcEpRTks4?=
 =?utf-8?B?WDljdUtuT2tpcnhkT05jMGduSHFJUFdGUTA1cGF3NDUyNklGSlAzb3p0MFdx?=
 =?utf-8?B?UHZkMHVvbUMrYVBsMnJYUHhoUFRWM05DRnh1MCszS1V6SXJDdmxIaWt3UzJW?=
 =?utf-8?B?Nktnb205UHgvNTVUZkp0b1dLYUVhWEFKNVdEaHZySGdVd0dGUzRUZWtnZnNL?=
 =?utf-8?B?WDVCNEhlT0JVMDcyUHlkZy9NblU0MUloUVlWcCtUOGNEcFdUZk9rbGlaT1p0?=
 =?utf-8?B?L1d6VUNrcjFzNTlrOGUwT3Bsdy9aV0U5YU42ZG82aUVWL3NtbnZldXB3M2gz?=
 =?utf-8?B?OUloOFZoaHh2RGkvZEFyWXZJcFgvaW5VeVdtRzJPNkoyaUFYZW90SWZWRkRK?=
 =?utf-8?B?ZXBYYXQvOWF6a3MxdmJZTXhKRmJNcHpEU2wyUTBTZ0tnWG1pY3JVaWxabFVh?=
 =?utf-8?B?MGdKdnRWa3ZBRUlkNVk0NmdQdS9idHZUR1c2RnBENG54bXpYSWxZQitrSHF1?=
 =?utf-8?B?LzVvL0paK1pzTGxKM2QzTUg5Qm1wUktHUlJPMk50b21YanpxK2hub2FVMk81?=
 =?utf-8?B?Rzd4OUxYWFYxSlFhWGdIbjhYTUZicTZuRklWZ1NVNU9NYzB1d3EzL0Z4YWht?=
 =?utf-8?B?Y1N1dDVsRTBPL3pLSlVzYkVtMGl0UmVjaEFrdGozRzRmbmlsRHpKR1VDdVVF?=
 =?utf-8?B?ZEtjdjdvVVB4M1VJSENYOXRoelRoL1VEL3VTcGRDd0pDbjA3Zml3cTg5L3c2?=
 =?utf-8?B?TGpJUWUza1Y3QTVaTGh4NE54UUNqczVVQ1BrQnVvbU4rUldLTExXYXlrblRF?=
 =?utf-8?B?WDZOaTVmYlg5ZUJsYlVRYkV1cmNOL3poRGFEU08wZkZWLzNBbVJ5TjZGR3BU?=
 =?utf-8?B?Uy9VS1ZjYmhLcVFJZGNhSjhvb0RmTHNTT0UxNDhQTldKOXhrT2J3TUJPNDFI?=
 =?utf-8?B?SUJ6SHhkQUhsUXY4UDhOaHhGeWlWSDFxRkNuWXN4SkNDWStnYmtXS3lmN3Az?=
 =?utf-8?B?OUoyaHI0YzRMT1FScmY4RTFWUWZkdjAwZ1dPUHNWRUFIaTg1Tm82ZkpNeEN0?=
 =?utf-8?B?c0wyeDdZYlRqM3NtenNYSzcyNlQyNXBnZ3prSTVxTEhaY3pWbDdhajYrNm5a?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 323ceca8-dd57-405e-d69f-08dca54081b4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 02:39:25.5153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 56osbBLXxAgMkDCb2RKjBvDH6NajyLN3SbSC5n9OWwiJPlaYsIOh5TRjeLTtbpUhht4wojH0thcxq0uGq/fyFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6537
X-OriginatorOrg: intel.com

hi, Ian,

thanks a lot for detail analysis! we will check further.

On Mon, Jul 15, 2024 at 05:23:32PM -0700, Ian Rogers wrote:
> On Wed, Jun 12, 2024 at 8:07 PM Oliver Sang <oliver.sang@intel.com> wrote:
> > > > > but make still failed. I still saw below in our build log
> > > > >
> > > > > --- pmu-events/empty-pmu-events.c       2024-06-03 08:41:16.000000000 +0000
> > > > > +++ pmu-events/test-empty-pmu-events.c  2024-06-03 13:47:19.522463482 +0000
> > > > > @@ -136,7 +136,7 @@
> > > > >  { 2623 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
> > > > >  { 2078 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\000\000\000\000\000\000\000\00000 */
> > > > >  { 1947 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000\000\000\000\000\000\00000 */
> > > > > -{ 2011 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retiredany\000\000\000\000\000\000\000\00000 */
> > > > > +{ 2011 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\000\000\000\000\000\000\00000 */
> 
> Hi Oliver,
> 
> I tried to reproduce the problem by installing more locales on my
> machine, setting the environment variables, checking my environment
> variables, etc. I couldn't reproduce it. Looking more closely at the
> diff above and the other diffs in your email something strange appears
> to be happening around dots.
> 
> From:
>  --- pmu-events/empty-pmu-events.c
> we know the minus lines are those from the files in this patch series.
> From:
> +++ pmu-events/test-empty-pmu-events.c
> we know the plus lines are those generated by jevents.py.
> 
> In the diff output above the "inst_retired.any" doesn't match
> "inst_retiredany" (no dot before the word "any"). The repository file
> pmu-events/empty-pmu-events.c is missing the dot in the event name but
> jevents.py is generating it, hence the diff. But looking at
> pmu-events/empty-pmu-events.c in:
> https://lore.kernel.org/lkml/20240525013021.436430-2-irogers@google.com/
> The dot is present.
> 
> I think what is happening is that when you apply the patches for some
> reason the dots are being consumed in
> tools/perf/pmu-events/empty-pmu-events.c, the build then informs you
> of this by failing. The locales idea was a red herring and this has
> something to do with how you apply patches.
> 
> Does this make sense? Perhaps you can try testing the patches in an
> ordinary client applying the patches using something like "b4 am
> 20240525013021.436430-1-irogers@google.com". At the moment I think the
> patch series is good and I don't have a way to fix what I think the
> problem is, with how you applied the patches.
> 
> Thanks,
> Ian
