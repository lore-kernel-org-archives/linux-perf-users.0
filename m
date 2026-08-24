Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6C3367F59;
	Mon, 24 Aug 2026 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566235; cv=fail; b=O5Wx0HZJlp75+NlgPvOun6VxfG6ccf3qoq5O1zGS6gNIvAkR4tg8ibzC5DU2A0H1Aa055hcaryy2CIrsWPzbO5Dz8jQXwv1yvzLOHMfbXTUqfcci429B1xnuaTjaXbQCPfjAwzEJOw7ynQ5bM1aW8q/XQDks6VCwUl7nwXX8OV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566235; c=relaxed/simple;
	bh=DpurCEyDDvgUvpooP8pGIDbm+medW0s5MT27a9B3Z6U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BP6NKQDymm/rjdKE8yEmAgxbuF6lQihLHG11Z9l2f6pGK2+J278L9rb0cjU04jjekdq9rOwLV8xawuLleFqMkwyvOWzl3ozrCAIbg3XTn8ANG8pQb1C1uNSCoc8As6gbicUQfKQUDdlMmm3Eg5h+FLkNhl5rSgLnuX5Iwne0tAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GMfyGQm+; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GMfyGQm+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787566233; x=1819102233;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DpurCEyDDvgUvpooP8pGIDbm+medW0s5MT27a9B3Z6U=;
  b=GMfyGQm+LYGmjAkzxv9o7wPqNbMLG3VMB/zZ+8yP0a91HV7vf1waJr4y
   o9feIEt0A6nrqK6w22OLYtdZMpbi3og4bRN7QZpZ4KM1hj62/eS4a1xZ2
   +o8KrzkM8BDQUSE8x7D7x87Qi/e4846KuoqE2g+HmCi/fwv2viZIG/wGS
   u6pE2qDo61QO3NqcniLLCIr4HqewYkSCCrmohoPCxlapg4abR3TFNCO5q
   HpBXggazJzCVy7PBIBZ+KGu9vkOl743zcKGv+y41+4SorJaXooMicrkHz
   D2/SdpbZZXghNvOXcijilpoIjkm9UVvgStdEjq2cfFKJNxXOekRxVu6Gg
   Q==;
X-CSE-ConnectionGUID: ron7cUZLT3uagHxrS6YGTg==
X-CSE-MsgGUID: gqM5Ij8JQ7iEeisQ5trkZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="87779341"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="87779341"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 03:10:32 -0700
X-CSE-ConnectionGUID: 4KeKS+ocRNS7U5gU3ywyIw==
X-CSE-MsgGUID: PBahJZh1S7SuTBmMEru8GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="267007381"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 03:10:32 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 03:10:31 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 03:10:31 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.48) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 03:10:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o07m4DXKJXvf9OswEVnNcabmqW2qXrQ9uMVOlEgD7G1D13fgfBjDDjGt3D4MHnZcdZ2rEQW1QEVmOCv58ky7LzZJK/9/io+ifJhJgFEJoPImUATrOVZEAe1xSDt4iS1aPRcGzO6Tg9FtEUZR+rtTuCWnGO08qz0zeh7pQB6+2v5YWPrhH9K83jvI0JZgDRewrsGUGXWAyOLGv49V0XFiS/ovASrJrdoOcvO57c2/IqfD4LCDSUgtBux+S3bB/6NGqfscgmx6YJ9Fg0uL6EMgYRAi8MNp90xSyWtFDLXFQgwX8yYNhOHGgHXI+LajB0UaKMnD54lM9SmfWHxhDQJ68A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/G6JHHmUMXAZAuPErI9MI7O6LPyLxiR+Q+4e9xH84iE=;
 b=w+dlOnIY5dcEwGZL/f3VOixruI4UHMz2K4DBhI0TCKN/3zE73nfpjvOtSfHPLe72ZEXEjoZMgkszMeD5ILbgVWnu7vdPPo+lBvbPryN+nbxvRS8fYbU1ePCU7eCpCsDC96Sh2ChqcekyPPBu2jGt+EGgsuxQgZIfnqFTEMN+V+UNFZVA3Wg7OWg9mBYMhhmbLWLGinsimIiGzpHaMDl3S+cXAWf3saRAjfdw7myPPK4xNs+QkH86RTdv6Od08CmHo9NN4V0EE5fPdhOzM1+L69l0mpokovpIfsSZGhM3ULJdzKH2xf+oASn9AKBM55E3E7W8q683D05Aal0nuACYrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by IA4PR11MB8889.namprd11.prod.outlook.com (2603:10b6:208:565::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 10:10:28 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 10:10:27 +0000
Message-ID: <823e897f-13c0-4b07-8833-3bbfe37059ca@intel.com>
Date: Mon, 24 Aug 2026 13:10:20 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] perf dlfilter: Add non-empty branch stack filter
To: Amir Ayupov <aaupov@fb.com>, <linux-perf-users@vger.kernel.org>,
	<coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>, "Suzuki
 K Poulose" <suzuki.poulose@arm.com>, James Clark <james.clark@linaro.org>,
	"Leo Yan" <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	"Alexander Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Ian Rogers <irogers@google.com>, John Garry
	<john.g.garry@oracle.com>, "Will Deacon" <will@kernel.org>
CC: <linux-doc@vger.kernel.org>, Mike Leach <mike.leach@arm.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>
References: <cover.1787005265.git.aaupov@fb.com>
 <58f96797f94467859fec160320a7b9426be8cce7.1787005265.git.aaupov@fb.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <58f96797f94467859fec160320a7b9426be8cce7.1787005265.git.aaupov@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR05CA0029.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::34) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|IA4PR11MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: 38494c4f-6127-4b14-ac33-08df01c7eb9d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|7416014|921020|6133799003|56012099006|11063799006|10067099003|4143699003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rd/w9oT3RhR4y3w1g4Fe4RjwDQMLIxL9ewIATDWD5R3/YbUyt787Gu+5wbLGXPCRPDu+Rbxp5Bdjgf68yTG8aDgcibI6I+2K6T9DyEmiQaXBo4/AmHdrDt70BEvPqUdYzaAztHX1DnJ6ZbUO0IgR/CwaoIlkTx326b4N4w9gIjG6/vN9tzJzWbwQbDGVp0oDA1kCzlsqMiijn794iAoua8VD9NtStnziTWdfDF8VvjWP4Sm58IzAJ6pDdsKKkYefN5ZHES6ajM+hi+uzbmAx1t1Y6AjmhunbFda4sInd4yEDjyqwtoBTJweHpFOIishexe9d+Ciz2jQ8MJbXS7r89FeKixDDt3GXqEMVZkPCc619mXILHwHvGrMWt0kXFEboHBfLzemAGy4WDDbUlDcxmjOjxzr5vCC0yyf4RroYaHpwnTl8NRzW0r4nLNe02H1TMPNO9am8T9MolHG//CVMlNKz4jQDMO43czRLWRaG/y5YpzfQnE6lezCuQ5NyglhSLjod5265N7brbu/XtLXRLiduaUrucQwGWLX0vAaAyX/6iCQtVj6lB3yXCOD5z4YnJxxUWuq+DiFnDrEYUXwUVCy5/P1Dqlx4LYgZMKT8icafBIoUaOktQHSJwirh2G6HN+1UcGl0iKYrTvrVM4qT0i6sNOEqhSqfwb5xe789eVsPPJG5KPxATjq9uEI2dyT9oBhW+vMdZ0siQSvboL5y4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(4143699003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDJHK09vVmxQN0R6cGlkbFJ1V0VzamVLNmZQMHBLQW0vc1ZqM2xxVkVHTTVx?=
 =?utf-8?B?OUswaU1XWjlIUEF1L1ZUQjUvSzNyMFUwZ050b1VNUUVKVUU0Wndpek9mc2k5?=
 =?utf-8?B?bjBQWmpCN1cwMnVsQUR6SVNoNVU2Q2RwRXZkOWUyZVJxSE5KSG15b0I0azg4?=
 =?utf-8?B?Z3YxR0xzSDFxYU5oSlFOTXppMlBtS2RzQ0dtYVo1SVlvUFpBVS93TGZNZkc2?=
 =?utf-8?B?dVBpemU4UUM0YXFNLy9jTCtCdllJUlUvRGZwSkZ5VHBHeU9nRmRjMTJpcmY4?=
 =?utf-8?B?c0VSRnlUUUNzdTV1QVpRRGI1SDBYa1VLem1VZTZsV0U0M1dCVEplU0FRd2RK?=
 =?utf-8?B?NVl5RXlOd05WbG81MjExUDhIcmtuWUxCYWpzdzVWMUNFSEJ6UHc1TTIxRG1X?=
 =?utf-8?B?a1pYNzFSQnFndG9pZk9UOHhWUExNUVVsMjlycmZWVGJZbE11WFhPSzA0a0NP?=
 =?utf-8?B?Ulo4ZkRDNW9IbkxoTWU1Um1McDJqWllkWEJLTnVSTVY1TWpaNFI3b3lxUWN1?=
 =?utf-8?B?cFMrNWpWRlh1eXZBaTZiallHQXZJS0dYREozdER2akQ3VmJDUWlHQk1xU0ZX?=
 =?utf-8?B?em5SSmM2RisySGRVeGRRQy8zSTJjbFhyQStOTnIvYzlVL25EbnRPMC8wNEJO?=
 =?utf-8?B?K2VPeE5CN3VwZzdCdE1PSGhScXV5YitoV2pwclM1WnpTenVoR2I0V3YvOXNt?=
 =?utf-8?B?bnNPNFVvNGhBMGY5NlJSK3MzdnptNHFyZ2tYN3Z0UXpaVHd2WHBVZmVKMjVa?=
 =?utf-8?B?cGxmRTZFSXdCZUZHSzgyY3B3TTRLVGtXeUdJWTFZaEVkUm9FQmQ4V0dxWVlV?=
 =?utf-8?B?T0xZMkRwTVBVUmpvQkRIMXFYbTNXU29jSENjRTN1MkZxR2pQSTlsL1VQNnpx?=
 =?utf-8?B?elF2bUFwYllpdWdUN3BnWXBxZGVZL0poS2MzbUt1c1dqV3M5Q1FiR01mTnNP?=
 =?utf-8?B?TjFZc3ZDUTk5Qk5OTGU1alMvczVsZUQyOTllWi9kZFN0amhXeVRDeVlWOVMx?=
 =?utf-8?B?OHFnUTh6bm1odllrYlpzYTNUN2VmZlRBaGMyTnJLaHZuZTkwcGNlbURBa2lq?=
 =?utf-8?B?TnpraU0ybUxnSUgrTEQxQlMwWE4wM1p6ZWsrVllzWDZROEhGRzcydlJHNlFP?=
 =?utf-8?B?SkQwbzlHQTBXZHBEeGpqZUszd3ZKRE1yNFNmbVVDbXhUejBnODJtWTI2S0dB?=
 =?utf-8?B?YkZHTURFS3B1N1FCMFd6Q1B4eFBaUDdBakVqelVudWRreGlkdnpmSmhTelNk?=
 =?utf-8?B?NDFmYXN6Ui9VRXcxcnI1MElDYW9IUGthZ0JFcVVFVWFFVUNKUHZtOHM2RkY1?=
 =?utf-8?B?NHoxczFlVjdoRHNEK0JQakVBTldkeTBEVktDdkpFcFFmNTRaZ2tBRVdpWm9x?=
 =?utf-8?B?Ym5rRUhuSmVZSk02SXcxY0ErNUVDL3ZmTHRSR285bmVsTm51Tkk1ZzlTeFRv?=
 =?utf-8?B?OUllV3BSazViT29pbklQMXkyWDFZRUFaWHQ1a2JkRHA1aGZRa0RBN2lHVGtW?=
 =?utf-8?B?Q2U5Q1d3VE9RTk9hbndkU050T1pQbERkV1NDNGdlalFXeW8vbXhCV0ZQdHJR?=
 =?utf-8?B?YzJORGdJNThvTkJzcmpoUnljZjYyRU4xZTVkQk5xc2FKN3Q1ZGZRaDVkdHpR?=
 =?utf-8?B?SE9RYTdiaTRwMGdKZjhCMDF3ZXYyM0lFZ2YzS0ZQVEdiZngwVWNVZzA4VFky?=
 =?utf-8?B?K1RmV01jajVpYWZSYWRFWm9ybHZBT1M4L1lEZTh5c0ZnNHhzQkZJYmZ1bERT?=
 =?utf-8?B?TDU1K1VSaDVrYmc5dE9PNHM1djFzRVZ0RGJ2a0g3NG5kSDhDd0xmTzZYbUxV?=
 =?utf-8?B?VzFDWU01empyNDVCV3Q2dkh3ZXl3WXZXUHZHb1dnZ3ZKUjc0R2M1akZTNWho?=
 =?utf-8?B?QmZFdFpIejdzOWNxdkFQelBrNkRCM1BweFZocXpGc2lBdlRhNnppR3VwcUlm?=
 =?utf-8?B?clhKZ2k1aUdFVDIxVjhzenZkNkI2ZldYNGdZMi9pUFEwS1N5bVhtVUhXYjhJ?=
 =?utf-8?B?a1VSSy84NzVNdEI5bXpTejlKMmN6S1F5ckh0TU9PSTJwSFFnbkZoM2hlTHhP?=
 =?utf-8?B?ZXJ5Z2psRzNsOG5TWW9HZ1Z5UmZoTUhPcDdHTE42aStublRBdWNEcng3NzZv?=
 =?utf-8?B?SU5uQUtaOU5oQ1hFQUZBbzNBUXI0aEZVL0daOGU4eSt6bGQ2bDNWYjU4K0R0?=
 =?utf-8?B?MVZhSUJBVXlUNyt5R0xyUFlmdUJKNDFEVEFPSlZGRm5sbmRORjdVVVVlemV4?=
 =?utf-8?B?ajgvVDI0ckVYd1d4TGs0YjBESVBFRWZDRTZGcjJOVkMvUEJ2eHN5TExPeDc5?=
 =?utf-8?B?anV3ZHQwWGRoVXZNMG0waFBCRHM0V1hCaFZCY2x2ZnVuckJGYzBpRVE4dFd2?=
 =?utf-8?Q?x3KlYDOc7JISUkik=3D?=
X-Exchange-RoutingPolicyChecked: L009SahB4cZTOH0pZeMw+atubmwb+eYM29N7v/Gt/yKX+Uy+Yg7ukkbep+WlGb+bHgk0iFCZsot27w28+O4kYER495CYJo12mE9UfRSUcVCcX82DfmJ39T+yQYzytMuQLbp4KVUoqzj+w142geEevUvVVqyn9u2LVqHwabhybYTmxsrOaHBzmJC/7sTAqTdX7wBSNl/yS5lIPsjTlWJz7VtGIjWFG4ERoM1rYcPZS6/X00GeYEf7n4WXEt2GEQS4124qFiO83tQh3s/KqiSWEh1/IEkaG/EjR83uIRdOA9NU43cdePLkev4NcsulyPh469BvttZ3doC3MnR5S9AoHw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 38494c4f-6127-4b14-ac33-08df01c7eb9d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 10:10:27.7054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJ0/wCVjQdrRA6xCvgTaBCxFukqb1hAyjm3cD5JsRPHeNv1KMCsl3nwOOvmnAy8JDb35wlsLt8seWY8KsjRfcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8889
X-OriginatorOrg: intel.com

On 18/08/2026 01:22, Amir Ayupov wrote:
> --itrace=L adds decoded branch history to existing samples, but a sample
> that was recorded while the decoder had no trace for that thread keeps an
> empty branch stack. Consumers of the resulting perf script output, such
> as profile generators for context-sensitive PGO, have no use for those
> samples.
> 
> Add an opt-in dlfilter that drops samples whose parsed branch stack is
> empty, so users can exclude them without changing default sample
> semantics. Build and install it alongside perf's existing dlfilters.
> 
> Assisted-by: Devmate:GPT-5.6
> Signed-off-by: Amir Ayupov <aaupov@fb.com>
> Reviewed-by: James Clark <james.clark@linaro.org>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/Makefile.perf                      |  1 +
>  .../dlfilters/dlfilter-nonempty-brstack.c     | 26 +++++++++++++++++++
>  2 files changed, 27 insertions(+)
>  create mode 100644 tools/perf/dlfilters/dlfilter-nonempty-brstack.c
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 29cfd44c427f3..750bd1cce1287 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -425,6 +425,7 @@ PROGRAMS += $(OUTPUT)$(LIBJVMTI)
>  endif
>  
>  DLFILTERS := dlfilter-test-api-v0.so dlfilter-test-api-v2.so dlfilter-show-cycles.so
> +DLFILTERS += dlfilter-nonempty-brstack.so
>  DLFILTERS := $(patsubst %,$(OUTPUT)dlfilters/%,$(DLFILTERS))
>  
>  # what 'all' will build and 'install' will install, in perfexecdir
> diff --git a/tools/perf/dlfilters/dlfilter-nonempty-brstack.c b/tools/perf/dlfilters/dlfilter-nonempty-brstack.c
> new file mode 100644
> index 0000000000000..9e66205b841d5
> --- /dev/null
> +++ b/tools/perf/dlfilters/dlfilter-nonempty-brstack.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * dlfilter-nonempty-brstack.c: Filter out samples with no branch stack
> + * Copyright (c) 2026, Meta Platforms, Inc.
> + */
> +#include <stddef.h>
> +
> +#include <perf/perf_dlfilter.h>
> +
> +int filter_event(void *data, const struct perf_dlfilter_sample *sample, void *ctx)
> +{
> +	/* Return 1 to filter out the sample, 0 to keep it */
> +	return !sample->brstack_nr;
> +}
> +
> +const char *filter_description(const char **long_description)
> +{
> +	static char *long_desc =
> +		"Instruction trace decoders can add branch history to existing "
> +		"samples, but samples that were recorded while no trace was "
> +		"being collected get an empty branch stack. Filter those out so "
> +		"that only samples carrying branch history remain.";
> +
> +	*long_description = long_desc;
> +	return "Keep only samples with a non-empty branch stack";
> +}

