Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DC73D3CE4;
	Tue, 21 Jul 2026 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621355; cv=fail; b=I8nRvBEL2Szy2E+f0bckTIL3N9ceKfFAENTi0FMPjmJgoMeEcnWdx6H2dQ2WW+HjBAnC4ppWi5UijlV+IHiHxsNiGDuQ9rFWwtgDqf1Jbs2uBgDz/abkvFohSEfhxWSkSdVomayf4X4zKwGtx9Tsy63k3HJXcYC0zX/XQpWjM9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621355; c=relaxed/simple;
	bh=iPYAy4bk7RRF/MNN9SRM594VzI3wxaQ5q5elKYuNPi4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vGQfXH6qArAKcj+Ymv7hQ1sq3ELIa2hLPSLFTQJlHlz/6rfFDzyHJtyx7lh7QLHRkROSMQrxO92csyXUrfz39Bmg6y+VsNMjzwHbqUCjKDLBL07wi7emkXHDUNH6tYmPo7QfCZWHlUZyhwpPdeBO38zwsGF7EYJcKMWrvgZMaAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fbWeJ6gy; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fbWeJ6gy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784621353; x=1816157353;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iPYAy4bk7RRF/MNN9SRM594VzI3wxaQ5q5elKYuNPi4=;
  b=fbWeJ6gyaI7HATbD7nYcDexqy73zaxtzKfwE5DPnBTEcNKU7XunixL8J
   cwN+SFOizF+qsMeKbEvBnV68aRHb98y+3kDjXPcvfJR1dQ4mvUEfP20+Y
   wck9g8jvT1Mhur2laRdwVPBZRU3cdakTcYqm4PLSjD2s0/QeKXvZdS5t6
   6pAR+Z4iBIU3i2V4r7bxKBNvK9FD6tqFxTSmeaweoQ8drMT1CzGYg5Y1V
   E+o2PySBcsKwvh4QvY3scF2B4cNAMh0b1dd6rrYeSA68pgQxImno7Ucby
   iMtjAF+GpUeItEIkL3CRe+/47W1F+EE7t8j2hH8w+7WFX2Y/B8H3fqngI
   A==;
X-CSE-ConnectionGUID: 2fv30HWySD2lgQss+sp2jQ==
X-CSE-MsgGUID: PlF80qNyQTO0ShB0OsIymg==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85068560"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="85068560"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 01:09:12 -0700
X-CSE-ConnectionGUID: pH5akjZuQ9+is+WiEplyhw==
X-CSE-MsgGUID: RezT8YTRRl2ykSbUzVIJyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="251365573"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 01:09:12 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 01:09:11 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 01:09:11 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.48) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 01:09:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spta5aoT4LGHIRxcrbfsl71NhYbvtrWV381QXAvjKoBnLgyhPYD9JdX2/u+V48mW74nGJ96OzxuuIhHEseaikf3bFrJC/aCtcV2g78pEa4GeRc0z5toXWSfchJs3ZgvOS3ID5j4v8yDxRyV8MKOPUFM1om03baa0/TG4D2tjCiNNX1pkRxSF0sNUjle0ytYCjKLPTQP6g5gYepLbUki93cICeP5w+1DecU6vitQtSla0N//s3uKcJ+uqZVPJ9BNpTzM4jGhGHQSJ/qTlnnXQ2TngXqAt9y4gP/wc7iEhF95XbMg0PYaSPPcsTIn0UkUmMht6W0F0svevWtR5jid3qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTrItQi2efJI5qehPGcm7hg657YaN/ckHxxAak2JjVg=;
 b=fCK6pqbazb3NzimTTxZnLezTqlgIdPBwq77iiM8M6dbWsKs3nG4Hqs+tYXvEiTXrnw6GK9s6bJIkcJvh+Q21Y1OZ/8Jgu4JvVqADALno9ojQK9AFTsJnB9CAedc/vXheiAo4Xf/ksLwrAKpCQ6vg8DUOZxPB5pzoD9SFTnGKsNUriU0wigif59qvnbtj6AG/+uEQfMd+JarkigBrGMGMKHjjQ0xAOz+srAGubXuttM40/VaYca06nNA4sFQipk/0WrYC+W70vjdDL5tgknV7i/sBG7fuofNRGA5pXN5y0l7QbmUIFVk2ukSoj7LouiqeNpty8PQZkit/XAMxGMgxHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DM3PPF195D11F0C.namprd11.prod.outlook.com (2603:10b6:f:fc00::f0c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 08:09:03 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 08:09:03 +0000
Message-ID: <07c8c780-5eeb-4310-80cd-3ff18952a688@intel.com>
Date: Tue, 21 Jul 2026 11:08:57 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/21] perf auxtrace: Set default period to 1 for
 PERF_ITRACE_PERIOD_INSTRUCTIONS type
To: Tengda Wu <wutengda@huaweicloud.com>, Namhyung Kim <namhyung@kernel.org>,
	<james.clark@linaro.org>, <xueshuai@linux.alibaba.com>, Li Huafei
	<lihuafei1@huawei.com>
CC: Peter Zijlstra <peterz@infradead.org>, <leo.yan@linux.dev>, Ian Rogers
	<irogers@google.com>, Kim Phillips <kim.phillips@arm.com>, Mark Rutland
	<mark.rutland@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Bill Wendling <morbo@google.com>, Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Zecheng Li <zli94@ncsu.edu>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-12-wutengda@huaweicloud.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260701035355.752944-12-wutengda@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0059.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::13) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DM3PPF195D11F0C:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e5903b-291e-4414-3b38-08dee6ff53f6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|3023799007|56012099006|11063799006|4143699003|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hmYnZH1bEEBVicBEPvlduXbhwETr72N7q2YFTZjybCgbC7HVvDpbZ2t+WeQbQaDMqItS++DFijxWUbt7553lXSAwSeTWsbXjRnelr4Xuc+5qKqM7RylivDqEQItOpTb24rHwTq1sseKBPEUtVZOyv+tr0o4DTEplgn79CaFbNOQXE3jPhByv7yxWBmVsNExVUQfw2P1sf6pggYJM482Clt+RoAKaY2s/GG5/7rmKKqD9RPkfTl7ttmnw9oO6VvsKvGeVPZWHLLQ/uM692nj5v0rPUOXsPVqQz0am7mwz5JsRKOBz4Fdu2FpzTlOLFbE73EPq6Yrf/IFnmVeu7++8GTkntTFxmYILmTSa8Au2wyJLBHQbOPUDj+YhsY3p2iPLFnSkEK8I1PnyLIWZrEtTOkX/Oi5Rp7LTGUt+o8MSTo6pS9W7XCQp7C6XJ4AczzbCLeUHByN694XXZCtMmlD4g7ldcyrAp4ThKhvBYsID5izVVqu6wYMKIxk6XLcHUVXEMdvhTrzoykoU9c68KQgU16yr9XmpVd8x7ilwfU10aRz7qNc558xJ0e3xbAODHPVDn1dJNrXnqM2+/KT9Qb26pYSQyX51WGOceY/lPAcMjLsK0Fl/vhqcjSjxa0rH6kShS4vYyrd6vu7caQhurqCn6WKpM2K/FTMUenmrnnMlNgI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(3023799007)(56012099006)(11063799006)(4143699003)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3d5Q0xaZkEyMWRIZjVKbUJzMkpDT0hMNk1hanZlQ2pZK2U2VWZ3Sk8rUVFB?=
 =?utf-8?B?c25yRWJhODE2WXI1N1FUNWhjVThVWGtBMVh6b3RkYlVuYTRCSmorcFFtbm1L?=
 =?utf-8?B?SWNCRXE0ZHpZTTJUT3ZocnlXTVJ0b09JdG0zOVY1SVcxUWFrOTcwTkYvYzR5?=
 =?utf-8?B?cDhmQnF6bFBSYXZ2aDl3NjFnbnNLeUVPSjJ2UUxhZlVaK1pvUFV0a0pSUTVP?=
 =?utf-8?B?WnhHYmI1K3BCMlZ5WmpsUC8zR1ZYTWhPQ2RSQWw3WlFwc1gvUGw4RlZOYTZj?=
 =?utf-8?B?b1lQLzYydlpBTlBBaGltYnRad05zN1JUVzBRNEdpU1RvYmNUMHN3Q2FzaHdp?=
 =?utf-8?B?UjI0dFhnMnU4Um9aUkJHdWU2UnUrZWM2NUJIYjcxWVJFanltSFUwNmpRMU44?=
 =?utf-8?B?Zy9YbWNzSWNUVUhHNTA2bXdvK1lHYzdsRGJoY1ZhWE85cWFaa0Q3ZGRJRFlK?=
 =?utf-8?B?VFVTQ3diVkFWalA5dVN1TFFTNEZCNDZ5QlE3TmFFZEpwMUU5dEViRlJNc1Rp?=
 =?utf-8?B?ZmROcmFxMGNHMU1raW1SeWdWVStyTlJkU1lTOGJJQlQ1S3hja3NQVXA0b1cv?=
 =?utf-8?B?N25sbnpjcFhQcXpncTNzdDJydTNlSE5EM1N4RTlaY3hLRXdqMk4xRnprVXZh?=
 =?utf-8?B?OXpRWmZadmh0b1R5amNyVmxuVHJ3WHFFTTVBRU5sWTBUdS90WFhBcnk4M05a?=
 =?utf-8?B?b2xreWhTNm9KZ3ZaTk9tamxCQTFuaFZhNDNPdmw3MG1helpEemZrcnBBVXZI?=
 =?utf-8?B?Y01zNnB0U3NrZ3pBYm5LdGVsZHlucnJLaG5oRVFGUDFjZSt5ZWlCWEtjRVpQ?=
 =?utf-8?B?bzZZOFdnbml0UGtpbHJFcWNBc09kcTJjYmdPUUMvbE9kUmwrTXplbktJMW8w?=
 =?utf-8?B?R3FvU0ZJN1lxK0l3WjhVN0hleUpKZmdVekJ5eUh4eVlyTzU0Y0ZNMlpPODJX?=
 =?utf-8?B?NDVnRzR2Y280bnBERHVsYVpKeU1USnVHeTZQUTRYblE3WVRmR25MRDdPQ3pu?=
 =?utf-8?B?N1hhcHZXdmZ6U1RtcnF0aVIrT2hwOW5UbHY3d1lwVnR4U3NjbG9pUjlBc29M?=
 =?utf-8?B?dC8xZkcwWS83YWJSRVNGSVNKZWU0ejdmWk5FTWN5b2NISVRXcS9qYm16R1Q0?=
 =?utf-8?B?bXBCQWxobFRyQVcyWlhKZUtRQ0w4K1RFZE5QQ0QveUNMR2NkcTJ2VWltMlhN?=
 =?utf-8?B?SEVxQWprRlZ5bjd5Um9FZS9PTVF4bGt4VC81UUV3NGFJajdKS01oRmVYQ0ww?=
 =?utf-8?B?aW5iTHgrMVk1T2Y3dFloRGluWFo3Ui9WbWhQcTZXcWdVcEtqWjI1VlRWVEZa?=
 =?utf-8?B?RFpnWEQ5b1hFVnZDem1UVjBIL2FCN0hKWXhWRWZ5alRkc1VFUUZvUm9rbjU1?=
 =?utf-8?B?YTI5UHBnOFdPNDR3di9DZlNXSFV4U1BONUxWQ0FFZUJhV1VCcnJLblkvUFMz?=
 =?utf-8?B?cVdNYzRlcEZmOE5mNzYyQUhISlE2TXAyNW13dEVwWDBxNXltdUR5d3RLZld4?=
 =?utf-8?B?dDhFY2RRaTgvZThMdHppT1RkNlAyU1M0M0FVZ3Z2dGRuV2c1RFRZTnZpeEV4?=
 =?utf-8?B?LytCZzRzbzU3YVhsTWpxV0l2NXNBcEJFcUNJeHRMdm5FeExEeU5TeDR5MDB5?=
 =?utf-8?B?YU1aTGI2KzcvLzh6ZTFtVVZLNjgzR3RETFNKVVFJbldxTFZFaDZUUHYxK1hm?=
 =?utf-8?B?VC9MdU9JSW9ENVFkZGlOQXF1bHNMVThzRDJ4c0x1cmpTNWo2ZkFHT3RacExp?=
 =?utf-8?B?VCtiYUFiNUZWdXQxLzkwQkVSeUxXVXNQNlZkZmZ3c2U0VFJleDhOS0pETGVx?=
 =?utf-8?B?T1dDQnBaV2drNmV1Mk42MXlIdEJwOXB3NGoxRTRhcDdZTVVTQWkwR01NcUNa?=
 =?utf-8?B?dDdDVk1LaXN3a2xhWkY5Z3NRSmJSUW5MbGRuZDRabnFCdFIzWGxyMUJzcGhX?=
 =?utf-8?B?dEgxWHNVRDFQUURGSjlwZ0dvajBBOW1zM3REa3JVK3RQOENEU2FBcXJrakNG?=
 =?utf-8?B?ZkoxREVJWVZ2WnJkZ2ZYTEJLYW45K3ZTNWxINjNHKzE5bG5tMVBMWExkeDl4?=
 =?utf-8?B?RnBLejdzR2xMUWxvVE16S1NrdkUzVnBYazVvRTlwUWF4RTI3RjM4a2hQVC8w?=
 =?utf-8?B?YlI2bnl2R2E5UkFnSmlHNG1MZW5oNGlvWHRmQzBSS3ZYelZ0SWRicEJ2R1BD?=
 =?utf-8?B?UE02amlMbWhsSC9uK0tzUndZZFZVRUUxQVFZUXNhNVlJTVpueThNUDRpTGl5?=
 =?utf-8?B?UHhCS2prbGF0SEFrZ3N3Y3pMN3Y2b2dnSVdIWFlWZkhsTjBJL1lMMG5qVnl0?=
 =?utf-8?B?S2hFdklsT2F5cFNvV3p6SU00VkVJcm1TSUY1RG1IUU4vM3BsaUV5Qzl4bG94?=
 =?utf-8?Q?U9yV44H/Mwqif7QY=3D?=
X-Exchange-RoutingPolicyChecked: PJUsxonQCeCDxxQHzm3fbBIT8Nk0Dqi3/svEm21sqpWuOs70UKbS08znW/zhSBuAB6GNORtQa+MVfeP8PD+obncKxUfwqCoCxWR1Pi/J69c0+3b0LJ9qOj9VibNjKtBIJSfDEOMmnnEf98BblntDEMemkrvLiWMLSx8YIsZuntTly5UclCgdZo/9jB2MGa+nm4YCXwD2v2m6eVP8gtTQ/v00UbMW1JCZ2gjuNSyrzbvL/Jx7h+/y+YOjKdJs2q1YTummhFK/FaTX/ktVbC+EohJ09AuBI/Qx9fG6gfg6+B7HE7L4R8gjh0vwR1/MZxwoezmBcEYhHUtqgUr97qPTUg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e5903b-291e-4414-3b38-08dee6ff53f6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 08:09:03.5815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2kx5oPB49jo6e0+UAbOCR9QqO3TL3Py/s1POKjq/xfet/8u4yJ+mvpd4KLVcqwnSC+FfyeOWdkhvuIWbGxw3Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF195D11F0C
X-OriginatorOrg: intel.com

On 01/07/2026 06:53, Tengda Wu wrote:
> When using --itrace=M for data type profiling on arm64, the 'Percent'
> values in perf annotate output are all zero:
> 
> Annotate type: 'struct mmu_gather_batch' in [kernel.kallsyms] (15 samples):
> ============================================================================
>  Percent     offset       size  field
>     0.00          0       0x10  struct mmu_gather_batch  {
>     0.00          0        0x8      struct mmu_gather_batch*    next;
>     0.00        0x8        0x4      unsigned int        nr;
>     0.00        0xc        0x4      unsigned int        max;
>     0.00       0x10          0      struct encoded_page*[]      encoded_pages;
>                                 };
> 
> However, adding the -n option reveals non-zero sample counts:
> 
> Annotate type: 'struct mmu_gather_batch' in [kernel.kallsyms] (15 samples):
> ============================================================================
>  Samples     offset       size  field
>       15          0       0x10  struct mmu_gather_batch  {
>       13          0        0x8      struct mmu_gather_batch*    next;
>        2        0x8        0x4      unsigned int        nr;
>        0        0xc        0x4      unsigned int        max;
>        0       0x10          0      struct encoded_page*[]      encoded_pages;
>                                 };
> 
> The root cause is that when period is not explicitly specified in the
> --itrace option, it remains zero after itrace_do_parse_synth_opts().
> The zero period then flows through annotated_data_type__update_samples()
> where h->period accumulates to zero, and print_annotated_data_type_value()
> calculates the 'Percent' as zero.

The period is for instructions samples i.e. options 'i' or 'y'.  Why is
it being used in the 'M' case?  What samples are being synthesized in
that case?

> 
> In itrace_do_parse_synth_opts(), non-'iy' options have their period
> type set to PERF_ITRACE_PERIOD_INSTRUCTIONS, but period remains zero.
> Since a zero period is meaningless for this type, default to 1 (one
> sample per instruction).
> 
> With this fix applied, the result is as follows:
> 
> Annotate type: 'struct mmu_gather_batch' in [kernel.kallsyms] (15 samples):
> ============================================================================
>  Percent     offset       size  field
>   100.00          0       0x10  struct mmu_gather_batch  {
>    86.67          0        0x8      struct mmu_gather_batch*    next;
>    13.33        0x8        0x4      unsigned int        nr;
>     0.00        0xc        0x4      unsigned int        max;
>     0.00       0x10          0      struct encoded_page*[]      encoded_pages;
>                                 };
> 
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  tools/perf/util/auxtrace.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index 0b851f32e98c..415b68a2bba9 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -1759,6 +1759,12 @@ int itrace_do_parse_synth_opts(struct itrace_synth_opts *synth_opts,
>  			synth_opts->period = PERF_ITRACE_DEFAULT_PERIOD;
>  	}
>  
> +	if (!period_set &&
> +	    synth_opts->period_type == PERF_ITRACE_PERIOD_INSTRUCTIONS) {
> +		/* Indicates a sample is taken for every instruction. */
> +		synth_opts->period = 1;
> +	}
> +
>  	return 0;
>  
>  out_err:

