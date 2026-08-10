Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EEB37D118;
	Mon, 10 Aug 2026 06:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786345085; cv=fail; b=HPOBdzVDC5ZzNwh2XxWbhkeFM6MYVsI+LWJwqg2FfclFogzs4DBT4T/O9OPnY179Ee/0G9hrIWj7u5ZUnhhBsEmxQ9QZ/he0SrJKi8pzyWqhJHbWnlFaqSOglPT2w8OC7yrnwYgvCxdOtLuXhtKcjqkajIdWEUf+RP8rrHhJQak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786345085; c=relaxed/simple;
	bh=GwnrPiJz9dzb3bAYq3fHazEdSkiifEMjfdSdw5EcE2A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gk/uz/6TUqwPZlCYT8JXGefLLE0ir7L3SHxpU2z9wuwUEZ+GkYAi0cn0LaDf/a1HX+KIZOfBiG6Wx5OgZ7KpOUq6uaGUrqP3JKW+LzJBE16WCub/6toLdGigZH1ZbGdUyE6aGRCSDMAiJi0jT9B4CuOKuk/kVjceNw2SB1wk5ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V0LLGxTn; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0LLGxTn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786345082; x=1817881082;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GwnrPiJz9dzb3bAYq3fHazEdSkiifEMjfdSdw5EcE2A=;
  b=V0LLGxTn4zI/x++7ezl28GlyeIkl38/gZD3QgUA+rN1H9xb7pKZpDslQ
   mRpS22YFGXD6aubv2zFBpq8poXc8anpSglxHm4dUxQ/YQ9uAXFos9L7DZ
   8IAd1Xq9YGsz7/Y3ktBzzOuEuUOTBq2hvhvqq8YyWzSqKc5g6Zbo1ZipM
   lncIWJ6f/B1NwN4g6tQF1Z6v8swYUVmM+Cue0Bm9/iOaptoshRHEct3Jt
   b7wsVFtvASmOy8pLv2+As6E8njouiBl9g5Il7p/zjLPKakAbNhxHucUSk
   pxu7EbeuZteB1njqoWk2p0SDD7isd1lPtsingMA5cJq5vwqW1W15F5mS9
   g==;
X-CSE-ConnectionGUID: ay2aSdQyQaaxFgY1sESvAA==
X-CSE-MsgGUID: H7Sv7XZHSwm1kfrl28TSqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="86926138"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="86926138"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 23:58:01 -0700
X-CSE-ConnectionGUID: RafonWpsR4SMiiC900q1lQ==
X-CSE-MsgGUID: ar0D1UorSG+Ccahz0/ZItQ==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 23:58:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 9 Aug 2026 23:57:49 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 9 Aug 2026 23:57:49 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.40) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 9 Aug 2026 23:57:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGdKr9v7RBFMtVm10hFnXyELBybhKSynbZJv8BGyw5nNaGs9QVOlXksQnm3Bvyy3DpKDRwRGcHjNFPOjp/K2ZZmWF6sdf8pmteqWouqaFjvgI5s+/2aXYQNA6r88LFtcrfFmpbOx5WfTQNCdYHsTf4ks4bQiT9ks2VkG2vTsXtI6BM0YLoevnchzebk63jLP23dR6O6RW2o80YzTz3arau52w+KhhD2yOfr5UR7iVHGi+hNlsdmYlMpNco4XprJySaUsMSn8VdNFrLFOeEL7zmbdwcpLuLfHSTWZu8FH79NFOQ7WCQFNmNfNgi8VJBAVWqqrp//oJSRrwQFMLDHHsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMxGWX4ADtkZ0GL+CeWclntiMzdHk+DnnoQutmjwHpQ=;
 b=WXjx+uYeV06xzmtJ/3Xr8iNIUKSHISKxy/aS7kWlXtOVnjxPPb9kbdpi+C4O6TS1WFnT3XVnRloCX5G0J7zM/GeLEJKHIzFH3Svmm/o9lBkY2lLd+tM4EzTgjJsaGV9TNreMp68Hgz5G6xyr19pW0TCMsVuHbciZ7MaWDdKMXOaycCFVgSz/ziaxZAJB9H9+5Y3x+mgCP1VoOv9KJ7oGrgf/W6MrFiU+vgrxcdmE2c+tcPpya/HC26Qaw8mxrUY+T070XnkNX39VfYJlmm16n4oSLxRbPXhVKflY5FtW42uswbCOChZi/kiCxSF/4BP5zrs/Sofbe3T3kX0HeJb/Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by IA1PR11MB9470.namprd11.prod.outlook.com (2603:10b6:208:5af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 06:57:46 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 06:57:46 +0000
Message-ID: <20083f61-9724-445c-ad45-d77f9e8d2266@intel.com>
Date: Mon, 10 Aug 2026 09:57:40 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/23] perf annotate: Deduplicate overlapping ARM SPE
 events for data type profiling
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
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-10-wutengda@huaweicloud.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260808122400.2961238-10-wutengda@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR01CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::8) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|IA1PR11MB9470:EE_
X-MS-Office365-Filtering-Correlation-Id: f2c1502e-563c-41ac-c4a0-08def6acaf0c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|10067099003|11063799006|4143699003|56012099006|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: iM/B1VhVbFdAdLXLlzXaVl2umk76Xp3ex8ByQnNKEtlgc+hb0Nlzl5E0foCkHQjrUlmI/O6q/7SMwR75W36k4kBzYp85tb/lVgT2DW/L7MQOGXMAQTYYOtuC5CbPAE1meAgEExaTcwKMLrRKphGN/wY5nSlVeEpIOSfR692KGBXiKwpswlwZeSVmmYvK7Aqz7U+IHWhhEN2wP8Kp0anZuNKexjamlBIhryY6p8kyRCBsaystUZiP7v7q3aYlQ4Y749NTTp5jiGNuw+4D3N/z9mty8k1sy9xk4PC208/nETP6qP/eTofhlNPJbSfCiC5+dxWRYXMhswPVO72CSJmtvJbwM0PWCrNjap20csk/f/jGEo6doNxe/Mh3xidhPIsk2SzoIIH3UaFf++ViKI5eYe/F3qMgoInLG93sFVfu+MlLxSYs5N2rshtA9kCkr3HyhA80+3f6WuT1RVWAazQSqCCt2xf5x5fp72Qs3sdj+vr9dAb20slP0NlXC2hg6D9L6aVM0AwaQLCcrDyyZkeCSwK5xlJQud+ZRSPgWNl43rN3lDciN9tNaIpSKCQ5aAml5me7543yGWx4SdLqIRV/RN/nB4d9gh2Y3jpocJ3vm7qzP905LFYeB+rI5NzRYYr0O8aCpnBz04cpjqBqUU6Rn9W5IUGar7Ai7xC8byzCFBU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnpGWFVjbm9DaVdHdjhXSUQ2ZUJHejZaWm91REFwbzRxTTYxaVJtaUhwUTFP?=
 =?utf-8?B?UXdBR0dnb3dYWmhkL1hsUmdub3ZZQnlZR0NTQlVFU1U3Q08xZklvTVV1UXds?=
 =?utf-8?B?RkN6RkFEdWJvSHU3OWhCZjZxaXFkTWlqeCt0RzhES24xY0ZSR3lhMDRIUXNK?=
 =?utf-8?B?ekkxL1RsYVBQVCtBQUM2dVcxcnM1UnBZaDZBMk5LSGxIYUVHY0hBZmFmSFV2?=
 =?utf-8?B?dHkxRGlEdmtKK0x3YWFINlpUY2xFNDlwZjNvbEVCd0ZacnlJbGhQdDZQRjdi?=
 =?utf-8?B?VStlU1VPbkpiYldGUEpyd3IzU2FUbVRpdXg1THhqOHZ6b1ptS0t1SmZMMEJl?=
 =?utf-8?B?aVBWUEtRTGlySVgrTVgxNkZOYjIvSXY5YUlWWHppTCthQ00xN2JkRzFqUWhZ?=
 =?utf-8?B?Q0V5SnZsd2xOdjRwdS81Ny8wU0UzaWR6WXExVWhqSjFYUWFXd01oVS9VTjFR?=
 =?utf-8?B?V0VmZkpkTmpjTWFRM0gyWDN0NHZCaWVDbkpJN0FGNE1lTi9zTDJxb1AyRzJh?=
 =?utf-8?B?elRSU0Q3aFlRdTVocWtBRnFLTmdQTkNJQzVzOHpQVmhDcEFZdlZ2K2doekd4?=
 =?utf-8?B?R21ISC9BSkZkalJVYVlFMGdFS3dGZmlJZ1RUR1F0OEoyajU3QXZUeWFodURx?=
 =?utf-8?B?OGxuZDRtYXFubHN0S3RGcVdRalJQTTRuSFhHNTNzVXZLcmVmbXJNdk1EOVlz?=
 =?utf-8?B?dldXVFp4SHM1Q1BjVGdVS0F2c1VxTFpsVlJiUHI0OXFmMzM1emZzQTNJZHRO?=
 =?utf-8?B?NVNQZlN3K2NMMEpGMElCN0xUYm12R3JLbk5DU0F0dnp4RGpCZGIxaWgyRE54?=
 =?utf-8?B?T3A4MDN6S2R2Qkg4UVYranNCelhBRTBCRTgzbnhuTmhTelpuQ2RJc0lEbXNh?=
 =?utf-8?B?Rnl2REh0MDViVVRoemdFYW5jbmJCRUY5SHA3RTMvemNPS1F1dGIvZnMycFVI?=
 =?utf-8?B?aERkbExHbVJ3eWoyZkFPZGFoZCtNOWx5NStJc2pSaHBsZ2dnUUl6RW1ERkVB?=
 =?utf-8?B?QmR0QTZ4OGo2MTJyaXp3aFpzb0VhKzYreFpRWVYxZ2VHZUs1K1puR3V5ZHkr?=
 =?utf-8?B?UWpUcisxTUVFWHJPUjM3aGR4anRCZE9JSVhKcjJJeGQ2a3NtVCtpMk8xeC82?=
 =?utf-8?B?MTdYQTQyWk9Lcmk5dHM0RnJOSHRZTUhiclgvOU9qOE82dEhvVFJ1aG04YnMz?=
 =?utf-8?B?R09iZ2doNkhTc01nUDVnMjc0YW5oVmxjaHk0TnV1cVR3SWNFU1JtQ2lEd2pF?=
 =?utf-8?B?RDJCUGlhQlpnNFBFNlAwVjR4ekRmYnF5Y0FoZDg1N2t4UEhSRWZjZFowT0cw?=
 =?utf-8?B?cHVEemJNQmljTDNRekxJUU9OdGZ4S1dNMG5VdHNqZ0dhRHdnMndWRmFwSFlD?=
 =?utf-8?B?eXdXMVdYbTBqMnVjOFFxSDhYY1E5SVlUU0xUZWtmWklidmRxZ3piRDRGUmx1?=
 =?utf-8?B?cXFSZHZNR3NEaVJvTTRWRDBQK1huRzFjVW1sOFRLcDVkN1pibldpQ2JwUzJw?=
 =?utf-8?B?UEtQTndoRU41N0FDc1NoMXloRkRaMVV1MWJoaU5oYmtZUTRnL2dzQWNVOXFj?=
 =?utf-8?B?UU9rYTRTbFEzRDBHMWhvVGhNZTZ0ODJGNkd4YzZMMW9qOTcxdUc2a0xuZCsv?=
 =?utf-8?B?SFF0aGlPaEdkRXZmVCtZVHk0VkFESHpnT1hyZGlrdlg4RHovczVTOWZLZEpC?=
 =?utf-8?B?a29oVFhYbVVBV2tiYW95cWFQT1g4Tmx4UjliU0J3T3VqNUxSYTRwSDdOVEUw?=
 =?utf-8?B?YXRkR3ZaTDZJdFJHcVA0aklmVE02WTNiV2VvdUdxUUV1RG9PN0NHZHREZGdY?=
 =?utf-8?B?aEIrZGJiaXQzOGdqU3VJdDJFU1gwN1JEeU9QSHp5Qk1kYTRKVms3Tng5aCtm?=
 =?utf-8?B?NmtndU85NXE0RTRqTVhzcC8raFVxVDdVSzN5aEVLZGFFSnZHSEJyd3JYaGV0?=
 =?utf-8?B?b0syOWwrMzB5Y3ludDI4M2ZxQmV2cWp4YTU0T05Fa1R5VHhCcnJQUlpGMXBF?=
 =?utf-8?B?QytMVFV0dlJxSUVEamVOSURyNUZYM3hVekpSOWNFRVBDSHJVeDhPcHRPMlcz?=
 =?utf-8?B?bFhYbGl0THVJZkVnUXBKU3RXSkE0MzdKL1c3d0FuRFIxc2ZRU3NWRkpyOE1F?=
 =?utf-8?B?MDY3RUJsNmErRHF0amFua3pBTW5CUURveUY4dzhaelRCUGhJN2ZKTlJ5NGxF?=
 =?utf-8?B?emIzdm90UWZKZDFVa1JHQldXUWttbmlhVUpvZ2JNNFoxMVhwdHcvdzcrUmNZ?=
 =?utf-8?B?dHk5OVhLVGZXeTIwdUFCU1c1L0Y4Uk84Q090SnNIOWtCODhIL1FQcWZOelF0?=
 =?utf-8?B?cnVYVlF0WkFDNFJSNE83dVhLYUZ6NktqWkd3WE5oa3J1LzNOM04xNmhmem5X?=
 =?utf-8?Q?rZ0uhAkkdXr7VL/U=3D?=
X-Exchange-RoutingPolicyChecked: DZjGs+Kekzaey7x700orhj/w0VpbF6m1Ts/ZhupcXcbOlofTMBZRHyJUUevIv3bYqhRxoW4IgkixoHIl4ecWDwKVwPujlhYEpX+aUG4yNWOu5bk83yCa+eE8AhLCh5z/Qt5Z3V6JXGHwynIQf7QEIfkhldK6lkkCiGN49bgcDi79Gv6Lq3RUfU5fy1ng7W8fEEVmsLaz4IzdPTyt761vXFBrYZqSTuYK/8N33ZyLOjQcDh4SuJI5JZCmIMNo207H0ARNqG57ZQd9+QSzigVznt0mcJuO1FdODtJ+61vUbNqxQDNh+VHKtIzZ3OsteK4f52mD+GA4wHNoKNvmEPw4sw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c1502e-563c-41ac-c4a0-08def6acaf0c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 06:57:46.7599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qb/Ou4u97k2bCch95zASOoU1VN1u1NItg8VZjANnetUdy54tWVcFHkvi3+e1WGAQ+dx32bfl4+LS0q6MCLv6Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB9470
X-OriginatorOrg: intel.com

On 08/08/2026 15:23, Tengda Wu wrote:
> When data type profiling is enabled on ARM SPE, multiple overlapping
> events (e.g., l1d-miss, tlb-access) are synthesized for a single sampled
> instruction, as shown below:
> 
>   Available samples
>   0 arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=30/
>   0 dummy:u
>   84K l1d-miss
>   95K l1d-access
>   77K llc-miss
>   58K llc-access
>   9K tlb-miss
>   108K tlb-access
>   0 branch
>   13K remote-access
>   108K memory
>   108K instructions
> 
> While 'perf report' provides an interactive menu for users to select a
> specific event to prevent duplicate counting, 'perf annotate' lacks such
> a mechanism. Consequently, it counts all instructions across these
> overlapping events, which inflates the profile and distorts the data
> type statistics.
> 
> Although using the '--itrace' option can work around this issue (e.g.:
> perf annotate --data-type --stdio --itrace=i1i), it is inconvenient for
> users to specify this explicitly every time.
> 
> To address this, introduce itrace_synth_opts.dont_overlap. Set this to true
> when data type profiling is enabled and the user has not explicitly
> specified an itrace option. Then, during arm_spe_process_auxtrace_info(),
> adjust the synthesized event options based on the dont_overlap value to
> only enable instruction event synthesis, thereby achieving automatic
> deduplication.
> 
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  tools/perf/builtin-annotate.c |  8 ++++++++
>  tools/perf/util/arm-spe.c     | 17 +++++++++++++++++
>  tools/perf/util/auxtrace.h    |  2 ++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 69cb72b2082a..616f54bf4868 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -873,6 +873,14 @@ int cmd_annotate(int argc, const char **argv)
>  	annotate.session = perf_session__new(&data, &annotate.tool);
>  	if (IS_ERR(annotate.session))
>  		return PTR_ERR(annotate.session);
> +	/*
> +	 * Hardware tracing (e.g.: ARM SPE) may generate overlapping events
> +	 * per instruction. When data type profiling is enabled, enable
> +	 * dont_overlap to deduplicate them to avoid skewed stats, but only
> +	 * if user hasn't specified itrace options (respect user override).
> +	 */
> +	if (annotate.data_type && !itrace_synth_opts.set)
> +		itrace_synth_opts.dont_overlap = true;
>  
>  	annotate.session->itrace_synth_opts = &itrace_synth_opts;
>  
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 401aab529309..1721882423f6 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -2033,6 +2033,9 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
>  		/* Default nanoseconds period not supported */
>  		spe->synth_opts.period_type = PERF_ITRACE_PERIOD_INSTRUCTIONS;
>  		spe->synth_opts.period = 1;
> +
> +		if (session->itrace_synth_opts)
> +			spe->synth_opts.dont_overlap = session->itrace_synth_opts->dont_overlap;
>  	}
>  
>  	if (spe->synth_opts.period_type != PERF_ITRACE_PERIOD_INSTRUCTIONS) {
> @@ -2044,6 +2047,20 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
>  		ui__warning("Arm SPE has a hardware-based sampling period.\n\n"
>  			    "--itrace periods > 1i downsample by an interval of n SPE samples rather than n instructions.\n");
>  
> +	if (spe->synth_opts.dont_overlap) {
> +		/*
> +		 * The 'instructions' event is the most comprehensive,
> +		 * synthesize it exclusively.
> +		 */
> +		spe->synth_opts.flc = false;
> +		spe->synth_opts.llc = false;
> +		spe->synth_opts.tlb = false;
> +		spe->synth_opts.branches = false;
> +		spe->synth_opts.remote_access = false;
> +		spe->synth_opts.mem = false;
> +		spe->synth_opts.instructions = true;
> +	}
> +
>  	err = arm_spe_synth_events(spe, session);
>  	if (err)
>  		goto err_free_queues;
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index 6947f3f284c0..ebb4e9e8e574 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -80,6 +80,7 @@ enum itrace_period_type {
>   * @intr_events: whether to synthesize interrupt events
>   * @errors: whether to synthesize decoder error events
>   * @dont_decode: whether to skip decoding entirely
> + * @dont_overlap: whether to deduplicate overlapping events

This doesn't seem to match what you are actually doing, which
seems to be to choose particular default itrace options for
'perf annotate --data-type'

I wonder if this should really be handled by
itrace_synth_opts__set_default()?


>   * @log: write a decoding log
>   * @calls: limit branch samples to calls (can be combined with @returns)
>   * @returns: limit branch samples to returns (can be combined with @calls)
> @@ -128,6 +129,7 @@ struct itrace_synth_opts {
>  	bool			intr_events;
>  	bool			errors;
>  	bool			dont_decode;
> +	bool			dont_overlap;
>  	bool			log;
>  	bool			calls;
>  	bool			returns;

