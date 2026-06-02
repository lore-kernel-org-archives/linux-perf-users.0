Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28880283CB5
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 19:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780428741; cv=fail; b=fi8+PiBYLh9z4I7PR/ut9VOdVDQPTbBzmvviODg2HNRJOZ7s30oGe71yXhMZvxF17pySuGcrRzWg4kwSAb7GRhFp0azPTltPj4jCBTVPJbDqpPpnx851UE9Eb70nPSuv9ianVcqprCoSDsgJjVs11DzJ+UInT89k9njN+PDDoCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780428741; c=relaxed/simple;
	bh=u5jpAkJCra3rDs2N9+Ir+QKo63+tPvXkJUi6Puod4fo=;
	h=Message-ID:Date:Subject:To:References:CC:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KpCYy5P0wP/0DmtjqyatJ7ryBfPtNcQXZBsnYnChRwd5rM8arCcpkrKsNUPY2ayvmCRGwFKGVLgb2j6l87xYfXhQCdXAc3DEGUG9u5FpPdy/Y3yeyYsmL0XTqpt9mUl5oHWZTxeDL994A3w0Y8LnP4xQMUTh3fArXTg/EzL9Vt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XG+gkEFE; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XG+gkEFE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780428739; x=1811964739;
  h=message-id:date:subject:to:references:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u5jpAkJCra3rDs2N9+Ir+QKo63+tPvXkJUi6Puod4fo=;
  b=XG+gkEFEajx5N4Q4+6lr3UeAXgbaOxCuGOlb6cHdKlNDe23B/EY3S0Yg
   +52+SHD2e12/s6Ch3Xh3Lsy8xohchy38XHWqoWI6PiVgIk5o8kVUKgh8J
   VQKigWTYKVFKq3MVwvEDA47jUdvXV0uoDycyOIBPI9Tsb1SFha4XErWWe
   iTLKD2DpEAA5E1tLWBEW5toKYNWIvtWCqQs2THlnDV1MC612WmcrLPnpH
   YCrwznSp2/3fOFAjoLshzMBiCqtW+kHGQk7wn+E/uvLJU+fitvrUlHYo9
   +Zx+S3RjaK9ZItNw7zPxdDa5/sjuaXH7wHLysCid7IS9gIi6mjiKDNRMV
   g==;
X-CSE-ConnectionGUID: EYIvmeC9Rsyu0On20QY91w==
X-CSE-MsgGUID: 4GctQJoWRQS6QsoaeomBYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="84852780"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="84852780"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 12:32:19 -0700
X-CSE-ConnectionGUID: BJiOHaGoQHu1fXgPCU6BeQ==
X-CSE-MsgGUID: vrHosphoRz+SABQ3rESRJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="243151635"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 12:32:19 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 12:32:17 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 12:32:17 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.3) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 12:32:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mr/EBtS6Qd7mHhFqeiFhypUi+wVjzLr1wSNWmVm7IIFUEgR7EJ7VaCvyZQdNeP+ubnPIJUbZu38XJ6fqV/ggE34Zd4SQBzafUs6GIj1hsiWCIwhvYPMcyIP6bU1Jzc5lXDK8VkWYLsSlG0E7F0zs9hUwN4+gzEGQ7L6N6eevKuorpJGc7wKiIVuK4sp4gtNLJpW9kBowmY4j2rjPbq049TG8+OaAf67EAR5wrrY4ACk7kYiz0J8yLR0R4+4Dv3vrBgVLfuN8uqKfPYRW2YyRgLj01W2lOZ/763fg4euCxTHl5ayLbab+NyMGMFMJrOkd3M/kFESr61qhZtp/62bZrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTYb3ubb0s4YQdHrL2nXtXyZu6f0INfqxL0lukejfYw=;
 b=pVmGL1Nx6NWdcUMHZnfeUh6/xIkn75F8+QOOjkgSjcVpXk48cZFaZ5crGBW3WbzPh8c2B6Tlaxq/vNO4hweaIvFUOr8Q8apskT1e6Pxje9fDizeMant+GvrTVxvjABiuqegZeThAWkmRa7WUZ/lop1raFbww/73JaQG4oHdlL9GGem7bKYE21skD1LCmnBhngcMPtSO8X95mLDAkc40TgdRX1idwvq/Cxi/00i4gO5EX59nkX4O2DSVv5J6/zRjHW4QN3/R7lWdmXeDl77n4FiWDnWnSLNBj1x7gvqQeBkXvFn6azd7EkOgfzdggWMsBCtMf8XQQZ6968gWIJD9q+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by MN0PR11MB6158.namprd11.prod.outlook.com (2603:10b6:208:3ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 19:32:07 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 19:32:07 +0000
Message-ID: <c45fea55-b03d-40ac-a89f-8882b057fe5b@intel.com>
Date: Tue, 2 Jun 2026 22:32:02 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: perf script intel_pt decoding reading instructions from wrong
 shared lib
To: Todd Lipcon <tlipcon@google.com>, Namhyung Kim <namhyung@kernel.org>
References: <CAGH6UiG=RJLqBU3kLu9XJciPyPO1HZkbAPERguVUMRuWQgqf=A@mail.gmail.com>
Content-Language: en-US
CC: Stephane Eranian <eranian@google.com>, "Mi, Dapeng1"
	<dapeng1.mi@intel.com>, Ian Rogers <irogers@google.com>, "Arnaldo Carvalho de
 Melo" <acme@kernel.org>, <linux-perf-users@vger.kernel.org>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <CAGH6UiG=RJLqBU3kLu9XJciPyPO1HZkbAPERguVUMRuWQgqf=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0360.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::28) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|MN0PR11MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: c683d34a-3d6e-4982-ead0-08dec0dda20f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|6133799003|3023799007|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: WwhtRmLyGj+5GeJ5HTOxEhBO1DVWO+yHg0pgPH6OkAbW+Vl5AY+7SC5tEob5nmwxMuA5nx6XyeH82OHUQQeo0FYjGS4QmTwU40KIxHgDf8mq5ZX2/gMx9I6H7npzR4ardxW+Vg8t6NCqGMmvdae334vmq/9hTfG47PLslUuQpQk/90RrcnBpMIRBbOw0OR4zcmh7NAdh8XHkYnkME2yz0CfqgGGsjcvAEJfKXKy7XeToRLm+TUcgKYapovqls93+Fb0aZOroPdfgEkp/L3ebl2hSx7SSGDZl7aqfEm75qDE29D0CRC+Lus4mgxR1Xr2TUbH9gyYu7OElozWkgr3pJ4g8R/hIrvKjg5f/MB7dz6YjEXCcozZ+YGVDzV7PP8Yadjgps9o2VI/IQNSmf5JMNJRirmpbhO7nyCf7/eQNp9mQXaQP4LzrwrYWh1bZ0ILNZhX93y+63IVTC4f+3VyZFCSExMazSMouPYaH+npzn5RPh1gl02t1I5FgZM7HaJIWDxffM1RtW1DYh1YvwmBiikxPUyU334mDrXXRvsk4+FMUwhSnNeDGNit0ORRh65IOGGMHeIOtwJoPM1vlFzoZxUIHS20u/dAr+61T+t+Tv517obsR/eU2saHuQTYwRrmq7/YkvFqZWk9rKhgqqj/fW0SugJ4Po2prjP6EX/MS92qYsPbMNB1lTDXUz/8Pc1LdD6kDsXzIqecVCZuNDyiQ6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkIwMnJKOXRJVnIvc2VBZzY2RGZIaXdkaHpvL0NjNEt1RUtwTXIvQnVLSTMw?=
 =?utf-8?B?WlVTN2FwWFhKeGhjY2xwSHhhb2dkcmc0a0w4UFFGMVB6NndXcS9GRXVEVDJK?=
 =?utf-8?B?ZWUvYVVEN2lMY1U5NXVJZ3hRVXNRci9qVUVOc1I1cnRzUzBCcXlQaXBacmZH?=
 =?utf-8?B?d0lWemk0TkVyOXUyaGJ0NmRadjc5V2RMeThrMUdqSGFhaUg3NFRGMzU1Y0FZ?=
 =?utf-8?B?UzFIRjQxR0w4N1FyQ3k0eVpjazBHM2FhSkF2RkprcWhQamV1MFZ3L2hSYURI?=
 =?utf-8?B?bHZlcVZHVDJPamw4THM4bEdhWCtkTDdQR2gwUlQrMmg0eGpmQmREY1V1VnFF?=
 =?utf-8?B?VW4xczdPdlVZOXJOTVpYeUJhcm43NnlqT0x1d0hWNHNYOVBjYVhQZ3kvbkVi?=
 =?utf-8?B?QStUcEViUWc3dHFTd3RodzEvcmFOeGhuc3BPZWJPL2phSG5DOWVyamljemRy?=
 =?utf-8?B?TkpPakVPWU43U0FGSU94SzdqTE9sU3lMbVdmTTRtZFQ4aXAzeE1RNHlNZnF3?=
 =?utf-8?B?QmNXaWNPaG1STzVRVkx2T2Nsc21vQi9rbytITXFHTDBSeHc0S3Zxem55emdz?=
 =?utf-8?B?di84SUw4VVVadm9lMitGOXJ6NXVEeHdvRXhPSHZKNndpcjhnM3laSFJPbkh3?=
 =?utf-8?B?dFE0SGVrV3FlU0lMdFFkbHlDQ0MvM3N0WTlNcmNWYnpjd2s1TzJiNis1VGlr?=
 =?utf-8?B?VEFSQUFIVlppTkJFbkNaektvNW02VWV0RHJ2bUZ0V2ZnblVnZkJtSDErUWl6?=
 =?utf-8?B?bVNLWGd1QVVibnVPVkJDUVBybUhhU3VobGFUQ1JXOUN3Q3FmVWtVTWRoZ2hF?=
 =?utf-8?B?eEt3c3hhZXpGV1NnRUVqWit0THh4Mit5UkNFTVdPNzhzNjVrdjVmUjlYbGZW?=
 =?utf-8?B?RjFoYTZkSGVJdHNWRm5kTDkweVVJSkZTQUhtYklndXBXRldSS043UGk0M2dp?=
 =?utf-8?B?RC9EeFhlMzZDR28wSGhFY1RGNEpYbmJscE5jdGFnbUxPdHk2NVR5S1pZQUM1?=
 =?utf-8?B?STNDVlhIVTJ0dDdQZDdHSjBOVERKeTdDYkhjcjRPeVlNd2drYzZ4UTZJWWQ1?=
 =?utf-8?B?dkFBd1k2bDdoZVhBekhQc1E4MXBaT09JQW8zRUxFK1d6UHovd0NTdVlJQ09U?=
 =?utf-8?B?RWNpM0srWTFnZUFPU0dMVmJYbjBZWFJ2QjFDSW5qV3FkbVB2ODFtcDRKQTk3?=
 =?utf-8?B?UkpPNk9FVDhiKzM3U21UYTJsUElxU0Yxb3VJc2wzUG5JeERhanduY0FEWDZh?=
 =?utf-8?B?em5wMERiVG5Ya0twVTVSNzdNYVZBM01wVjN3MUFUQ1dwTm5oc1JBTm1neW5D?=
 =?utf-8?B?NHQyYnV5ZWNZVkd5aHUxZitCWkpabXM2UDdrMGtOeC9SQ3pzZTlTbUR5Tlpq?=
 =?utf-8?B?NjJEdUNvYllSZmtWcURpRkEyNnk4cG1wU05wd3JxTlZoQ2lqcWNGQ3gvOGY3?=
 =?utf-8?B?UStIVUpRWHN5aW9nK0JtcUxvMmo0dUFOUjRFYzF6ak5GeDkxS3U1cTdoMXZx?=
 =?utf-8?B?UFMzU290VFJwQnpseG9UVS9nVmJJTnRlVUFISnlRM1VFbUpFYnQxNm5KWDcx?=
 =?utf-8?B?K3ZlT0FDOXF0WWk4TmN1NGRWY0tkYlpPS29tb1ZBK3lNTEozNFpHVU1lL2pW?=
 =?utf-8?B?VTQvK1Q3cjVreTh2UGU4YkVjZWw0SE1DaEFkRHJIcUxZNDAvaCtSWDFYb1A1?=
 =?utf-8?B?MzZkeDFHTmtJOWFyNnNEUUs1d0dXQzZiWHVZVzd4azZPY0w0MmdZYzNBVHNX?=
 =?utf-8?B?cit4Szg2ai9RV2c1TzlOamhmVnNjSm5pOGV0OGREUDFjZWVSWHJvY3krdVRs?=
 =?utf-8?B?UVN4YVNQNU1ONTRzNGpSYU5ZNkE2RzFGU3NKdlFZck90b0lWNHZTdXhuNGVv?=
 =?utf-8?B?K2VPQkwzaFd4Ulc2bGpZTnYvWFNjc08vby9RUXBiK3doemx6ZmZKZmhabEFq?=
 =?utf-8?B?YzlOSXJRT05XOThQR1R3b1E1WlAyRm5WTWNkM2JORjZ5ZVJBQzRVVnBoUW1s?=
 =?utf-8?B?Sk5GOXo1a3FBd20yV1VvS0p3VmNLNVNjRlJaNy9UY29zNGp6cFU4UXRCMDFK?=
 =?utf-8?B?WloxRHRlbUptNVFMeXlEQzRRalJrL1pwT0lEakVYeUU4VExvYkxxQmVIeEFn?=
 =?utf-8?B?dDAxNWN3ZmxBd0V4WXJWRmN3MVhxWUpmT0lWS0hHSEdESkdBdnhPbUZHNlN1?=
 =?utf-8?B?aXYzaGpUd3JLREFxeDJzSmdYVlhnUktLYnp4c1YvK2plQlEwa2UyOEVIaGt1?=
 =?utf-8?B?NGpPaVBxVGFjcUdOL09NVEF6d0g4OExzODJLdXRqcHczWmJFaXJneEVuTTdZ?=
 =?utf-8?B?bkNkaU9Rc1lTNDhVL2JyTnpZSkZWRWlDcndjMHFGRUtQcE9vQmtOeXNmdklG?=
 =?utf-8?Q?RxbPytEOfHNvZCoo=3D?=
X-Exchange-RoutingPolicyChecked: GWjna2SOCziJJJA/3h8yE8/YgmkD6x7vQ6/0W7GeRLJ54nNAK5sb1796qlTV26k91qTVr+KKulmsxDVR8O/5MoOqHdivY1J0xU3GD57w+d7gKcx3p7cNga8aPICZ15R6VThiGPu6NVmBmHc+UskLv5YFP/QauBYJ+SFuqXEOvGvLIWINdOE3ed/isoOwiPHe+XFEZ32lNlzot+2Qifc0zVG9gSZvfoXOo8ePBOyrmgF1pXn7T7F8ihf5eEWYTv86rsHG2nXMi0cRiiblymMSDBzxUALKi9P60tuQwWi33YesE78ebQtkyLbB4zodXBJoGsgnIcTY/4O54pORwrNZhQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c683d34a-3d6e-4982-ead0-08dec0dda20f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 19:32:07.5556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQZePHpLc7EX8ymxIA6ghgcFLU7gbTjC8QgL/8Hxy0lJgU2H57vwxHNXPc27Y+wcXATUy6tEikwCBm6t17ijcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6158
X-OriginatorOrg: intel.com

On 15/04/2025 00:59, Todd Lipcon wrote:
> Hi folks,
> 
> It seems there may be a bug in perf-script when processing intel_pt.
> Specifically, in order to reconstruct the instructions, it maps
> instruction pointers back to DSO-relative addresses, and then reads
> from the associated ELF files to find the actual instructions that
> were traced.
> 
> In the case that the ELF file has an associated separate-debug ELF
> file linked via `.gnu-debuglink` (common in some Linux distros), it
> appears to be reading the debuginfo file instead of the shared library
> that actually contains the code.
> 
> I've posted a simple repro here:
> https://github.com/toddlipcon/perf-debuglink-bug/blob/main/repro.sh
> 
> I haven't dug into the code yet enough to see where it's going wrong,
> but figured I would report to the users list first.

Seems to be caused by commit 5363c306787c8 - see further below.
Reverting that makes the issue go away.

With that commit, dso__load() sets the binary_type to the first symbol
source file type, which is DSO_BINARY_TYPE__DEBUGLINK in this case.
That causes dso__get_filename() to get the file name of the debug file,
not the file actually executed.

Leaving the binary_type as DSO_BINARY_TYPE__NOT_FOUND will result in
try_to_open_dso() using either DSO_BINARY_TYPE__BUILD_ID_CACHE or
DSO_BINARY_TYPE__SYSTEM_PATH_DSO.

A quick workaround hack:

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index dd30f17cb1ca..09fd79ca1d48 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1825,7 +1825,10 @@ int dso__load(struct dso *dso, struct map *map)
 		if (next_slot) {
 			ss_pos++;
 
-			if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND)
+			if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND ||
+			    symtab_type == DSO_BINARY_TYPE__BUILD_ID_CACHE ||
+			    (symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_DSO &&
+			     dso__binary_type(dso) != DSO_BINARY_TYPE__BUILD_ID_CACHE))
 				dso__set_binary_type(dso, symtab_type);
 
 			if (syms_ss && runtime_ss)



commit 5363c306787c88d41a41493f81b4308643696f6e
Author: Namhyung Kim <namhyung@kernel.org>
Date:   Fri Apr 26 14:51:38 2024 -0700

    perf symbol: Set binary_type of dso when loading
    
    For the kernel dso, it sets the binary type of dso when loading the
    symbol table.  But it seems not to do that for user DSOs.  Actually
    it sets the symtab type only.  It's not clear why we want to maintain
    the two separately but it uses the binary type info before getting
    the disassembly.
    
    Let's use the symtab type as binary type too if it's not set.  I think
    it's ok to set the binary type when it founds a symsrc whether or not
    it has actual symbols.
    
    Signed-off-by: Namhyung Kim <namhyung@kernel.org>
    Tested-by: Alexander Monakov <amonakov@ispras.ru>
    Link: https://lore.kernel.org/r/20240426215139.1271039-1-namhyung@kernel.org
    Cc: Ian Rogers <irogers@google.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Ingo Molnar <mingo@kernel.org>
    Cc: Kan Liang <kan.liang@linux.intel.com>
    Cc: LKML <linux-kernel@vger.kernel.org>
    Cc:  <linux-perf-users@vger.kernel.org>
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a18927d792af..3bbf173ad822 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1931,6 +1931,9 @@ int dso__load(struct dso *dso, struct map *map)
 		if (next_slot) {
 			ss_pos++;
 
+			if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND)
+				dso__set_binary_type(dso, symtab_type);
+
 			if (syms_ss && runtime_ss)
 				break;
 		} else {

