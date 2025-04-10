Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2CC20D4F9;
	Thu, 10 Apr 2025 09:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744278142; cv=fail; b=PKgG/Ligm31iszdjJR6e1mevKANNVR0EZAij0CQ1lMyZrI4k8iKs/OjwAKLDQu+kCC2S2NFTxXQtuLvOjS0DpXVHBtyQDMfq+tagBqCrfPYiTSrNxa2caCrIzBR/lEupkVD+7CapXzisyKd5K69j7X7E9ZzSasbqJTq4DiQewlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744278142; c=relaxed/simple;
	bh=ER4J4bcSUxayrjsGOW8QySHiym5usE2OmsBKpstQYOg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rUpQTbAE+iwV/TyzK1V3pqDUy8k8tY1ddZb5uAjFojKW09zGDqdpPi7Sk5WV1wlHjcAXoTL4cn80pLMAlC1AtSyVag33nnE46MfqLdeEIdEN+QucQPKz0OdIv4Ep3GzLRnMnZ1xfFevrhOyXks64v4Z1lyObHkz7jBc3UedNSxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=acauC2GH; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="acauC2GH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744278141; x=1775814141;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ER4J4bcSUxayrjsGOW8QySHiym5usE2OmsBKpstQYOg=;
  b=acauC2GHlqasW+6YIPzorQlUCybtTUjtvEHPs+wKXpRTjr2we88RvEn+
   AYR6Xmob9LmUNhUmSUqB/VDFPu2bU6+QdqrC7CB02YLS/ozpk1YB1ZqR4
   okAzzZibOVhJjWU6tFS/WnT7Hq4LA0mliNMXgfz1VfCOCGYwLTNuPCaaW
   9cibbK9LzJXdxGxqgFpG3twf//qSDv8d2OEJlC49rmsdao15nQnX23r9B
   L++s7927yw/4S6DlwBqOxsvjLmnGoZN+koqDPMrlnKgVEl+xPMTX6lcBc
   KXoc381oIWPBsHU8xqx8LK57mpRQsbouxM9f6djoKBYyQ6TK8PTp6Nwos
   w==;
X-CSE-ConnectionGUID: Rzzb8Z8FSAeVvefXu6WgAQ==
X-CSE-MsgGUID: 7XC27s6AQQCNvdNZ5ClThQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="48492340"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="48492340"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 02:42:19 -0700
X-CSE-ConnectionGUID: jLAyvi/xSluSDcX4OcynqA==
X-CSE-MsgGUID: TJeQkOkNTUOK+0ae+it9Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="134038040"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 02:42:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 02:42:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 10 Apr 2025 02:42:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 10 Apr 2025 02:42:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwXAFALuW4gXQtOqRrZg8j1etdyhgQgZGDfELBvQJqe/wuW7f+rmTG0TDxD5c+xQysI0+B2KDwxQhauVCPCewBNNXYQc34qUcEioTX/c+bMaELmJ2E90SQFOIQd8v5I/hiLHgsOiXfGo6OpXXmERyYjkxWYmSG0uJGUpVTTQ4jvEpsMQONAHz3hokaZt54YdG+GHk+1Zg5deaK7eD7Q61CdaJrPKrzshuF27mFkTZeNXS6qfDABhm5V41eEl+wB9+ZgwnhplFHtDkO1b1hSo45TG7Z+fJKRTiny4TdjoWRmZ1SVgv61LeeCju/QvWxcVem6SBLYa9Y3704rdZwSZVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5S/3aEWdy7c9wX3cenpEthRf3gkWQP+RhuVSfwe+/0=;
 b=khd9+Qd5nJwPOebU1fPUzr8nwEU35ZsWkrBR9mV1rYJdfi47pXYWTtHKTWSl+41/SGT/MqvGjwV8IoVVQwOemP8voMxcF2Nm6KDi6Fr95q34irl5dxj/wkAUeifmLOtbWwPs1C3r+galJbUUiH7vPStTu2V328kfMuwZ4cTAW5NBsCX8sH0XwTOVYfe+86ngF7tYzEYgYJsWCFUMR8X5GLeI2oHQWxjuwvL8RV8PLUCeXNtjhfxOSSAYx8w7PpD4ISSQb7QAHq8x5yfcwmYrCFS324zkRf9o13ivPOsUHsEZDja1emaKz/s0z7ckdosq+B7gnDijeQAUIjS+cJvfmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 LV3PR11MB8580.namprd11.prod.outlook.com (2603:10b6:408:1ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 09:42:00 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%7]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 09:42:00 +0000
Message-ID: <917bb3c8-e084-4790-b0ac-f0433cfca758@intel.com>
Date: Thu, 10 Apr 2025 17:41:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] perf sched: Introduce stats tool
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
CC: <ravi.bangoria@amd.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<sshegde@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <santosh.shukla@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>, <peterz@infradead.org>,
	<acme@kernel.org>, <james.clark@arm.com>, <namhyung@kernel.org>,
	<irogers@google.com>, <mingo@redhat.com>
References: <20250311120230.61774-1-swapnil.sapkal@amd.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20250311120230.61774-1-swapnil.sapkal@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0219.apcprd06.prod.outlook.com
 (2603:1096:4:68::27) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|LV3PR11MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: a80a855f-928b-4bf1-764c-08dd7813f0df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWozdEZ6VkVzMlNoL0cxUFdMTklhSnRJbWM1Ym5pbllSUlRQOE1sYUM3cGRY?=
 =?utf-8?B?YU9JNnZ0dFMvemxDcHlZSVZKR0JMOEF6Vjg2Yk5sRVEyKzRnRDg0NTVTSGc3?=
 =?utf-8?B?V1NKQi9RTEFkWUR1N2JaV0lCbDVsRmV2M1BMRytaN1hKOTl1aVdjaForWEM2?=
 =?utf-8?B?ajAxYnZWTHU1dFI3WXB0YVlsTTJGWm9YYUc5SGFiMk9qUnUxbUxhc2UzdFpC?=
 =?utf-8?B?elEwNjdlT3E0aE5xdkJOUE5NUzZmbFFPL1BLdWtXRW91UXgyMS9lbURvbW02?=
 =?utf-8?B?ZGh4OUMyY2twSXg5TzBlUnF1NlFHUkFRVmRjbzFESDlsL2NKeWxyaDRmWURr?=
 =?utf-8?B?YkZROUJlWU45cFk4azdiSzgxaVorOVIyWnYwV3J4dWs0TkZ2cDkwZmQxVFA1?=
 =?utf-8?B?anBWMVVTb0ZYVmMvSFlrdkd2bzVTSnZFbzB1ZWRlLzFDQVc1bVI4NFY2YzZa?=
 =?utf-8?B?QnpTZDVFeDM1OW9QdDJ4enYyNWtEdkhpSTZ3VDNVWXF1dmtqWnZtU0k2OUNi?=
 =?utf-8?B?a2dyQjIxYURLb1E0UEg0SDFMWW9mT3NGRG1KdENwMGkrRkJZV1Vpa1ZnMjNp?=
 =?utf-8?B?TTNzVFkvclUxYkRKN051OTRVT0pNM2YyK0puUnJjcVZrNTU0N25vNEY4YUVv?=
 =?utf-8?B?cUNDU1c3SndiWDJ1N3FhUkJIWkNvcmZPYWkyZnh4WWZoSlFwNHFROGQ3cnZL?=
 =?utf-8?B?ZmZ2d3JZVEE0K2xUdzFBWXh0c2FRVytvU1MxYnh6a3BJczhEcUt5NGg5SVdN?=
 =?utf-8?B?ZEVXTzVsQlh5TXNmL3RVTW1PVTF3dHMvNDRkNVQ5bXFHY2pRNy9HOXVoT3Jj?=
 =?utf-8?B?Y2FlQWg3ZUswMnhiMWZldUdNMXlEcGNiQ0xlZm0yNzBOUUlWV29XK0ZidVNy?=
 =?utf-8?B?dHFaZEoxRXlFdHc2SUNpVW5jcjBnTTJPOVhaVFRQaU9KOEpMSlhseTFUQXR4?=
 =?utf-8?B?L082b2Q3L0hGVm5RUUVlS203RG5NeU45N2x3WmcwcWtFZkV2eUFVZW4wb3Rz?=
 =?utf-8?B?K0huL0xiWXdEUWxhOVBNT29KTk9WaU43Qm81OWdPbS94NllFL0JqS0dUS0kz?=
 =?utf-8?B?K2k3cUZuSHZ5V1FBelVuQ2RWTmJEVVEwWGtHYTVWNTZDc3dMWHdkcUNOR0JS?=
 =?utf-8?B?NmpaQmxRdGxOTkZmZE9KckhTY2xRbVQ3TDVjUkNvYkYzN3RhRE1vRnN6SzRy?=
 =?utf-8?B?K2dLY0FXM2lLZlhhVXZPNDlHQUJvTVR4Ykhma2JvT29ENXpZaVFGOTM3MS80?=
 =?utf-8?B?SndsYkZQQkRFTzFQRmNJcWI4VUZnYlNFUlFjNjZzVGEwMlR4TDVJZkN1Zmk4?=
 =?utf-8?B?TGo0bEQrUW5zNUFhNkpqd3Q3Z2N3b3BuMHdGU1JGdm1QZEJKTW9tNzMvdjVE?=
 =?utf-8?B?alg4S0lycDJYRGpLNXU2MnBuWm9XRlF2MDl4NCtReXNnckhJb0plQU0xZG1E?=
 =?utf-8?B?WlVmSkg5ZGkzMHdNVXVsMjlIbGo2cytGSjBjS29mZEticUQ1TDhrNnV4Q1Z0?=
 =?utf-8?B?S0t4MXFlK1E1aDFYYlZQeVM5M3d5VGJjL3hmYjQ0cFVJQ2svWVE1VklWT1pH?=
 =?utf-8?B?eVFaV3BhaGpXNGdtOUF4bUJUalZZbDM0cUxteld6aGFNYms3MzNHaVpRTFlq?=
 =?utf-8?B?Wlhub3I1VlMrUGx4RFVDbHQ0bTF1dDNNRWJCRkRBMWNpZDI2SUhjeHk4ZE83?=
 =?utf-8?B?UWhneTBKZGZiZWlTVVhEa29meFE3c1grTnY5NFIyNm1BTGptUmVmWkJCTFVN?=
 =?utf-8?B?bjFtV3hwYnR2ZlJuNE9jY213S1E0YzY0dFp4Z2ZJMkcrRXFsTlJSbDdITllS?=
 =?utf-8?B?U3EwUTlKU250TGdkQzR5RFVaWHAvRTN6RHBVd3BhblVnMnFGaDd4c1ZtY2lu?=
 =?utf-8?Q?/KQjO5E3YwRhG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlRZRDVBWXlVSEJJTFJkU3BMdC9tSlJQWXdyd3ZUSWczTHBTUXFhSjFrYkds?=
 =?utf-8?B?ZzV0YW80cnRHbS83VnJrN3RZMzd0RUJ0UEFVNnJBdjE0R1I0anNqZm5iaDV5?=
 =?utf-8?B?eExjUytIMnQxZWs5OVZXVzBuZnkrYXRScnRDYStHd25VSUVKN0FBT2hoNWw0?=
 =?utf-8?B?Qm16eXp0d1oxRU5TckNoUitqWThuWDYzSHc2THg4eitCNGFjeDRsNGY0OTF2?=
 =?utf-8?B?NkQ2ZFFVQmhGaTY0cjJkK3RVWXJ6c0ZpK01pQ204Y0ZZNGxSYTNIamdXV3Ji?=
 =?utf-8?B?UFdRVWhsUGZUd2Q5dDl6SWNtMTVjQ0tsUUowR2lpSkJDeGFvUWtGRTlVSmVF?=
 =?utf-8?B?SDlHS0ZFUjNZZVJvK2VseXY1WkN1NWw4bVREdmVpWmJtWGRqYklUcm9MZ1VG?=
 =?utf-8?B?M2F4akdPVEQ4N0V6S0JEU3RKSjNPaEYrSnJZMW1CVXp6cnVBbmlBZGo5SHVO?=
 =?utf-8?B?dEV4R1JXV3M2MnN0VWVWY2xzelVObjdzcFhwRHJtbXUxVWdTa0xuWkRWVE8z?=
 =?utf-8?B?YW51dE0xQ3ZNcUoxSHYvNFFRQ1RIZXZXNnpZRzdZOVJSWmNiOUR5UGIxMkQy?=
 =?utf-8?B?Qm5lcVh2V2pCNGhiYUNJRzlmZ013NGNONWt6dE02T2c2K1J1dWFHSGMvVXdz?=
 =?utf-8?B?UUdjUUpvZG5iYUVRT004SG1Vc2dMUWNMWTRCNGI4VWZsclJmdXg1aEliYzNF?=
 =?utf-8?B?TG1UT281VWVhZXdnL1p5NUkzUVBISzZXa3VMbnNIaEZtNmpNNHJUWEFIaG54?=
 =?utf-8?B?eFYzbGt3WFdWNWVteGU4OUMwbWtYZHFSK2cyZVUxTUdDK0orUnFvMkUwY1NH?=
 =?utf-8?B?aEY0VmJacVRicmpvRW8vd0h5eTZjL0J5T1AraEdHMlg4NXUyZXZleG1lSkVW?=
 =?utf-8?B?QUZ1N3FpMGpNR3grN3FCa2RYUW5jdWFXVWpjK3F5Q3pRT2lJcGhLdCtnYlVw?=
 =?utf-8?B?V29GY2VLTUxQSVdWZ0pPRDd4VVFQOG9keUM4aUhLNGtOUk5WWDR3Y0l1Um5v?=
 =?utf-8?B?QVdvT1M0QyswamJvRHNtWUo0WlZndTN3TzdZbWh4QzQ5aUM5dExzSGZLc082?=
 =?utf-8?B?KzZJdjc2ZzFCc0VqTFFHTmpnR2dhRDFvbVZYSTExNDIxWGRxNDZwcXR3RDR6?=
 =?utf-8?B?a0ZLSkJFS0xyL3ZZQzNRbXB4eVNJMGptcVBFN0p4T1lkZm1uRGlqMnAwMDN6?=
 =?utf-8?B?aU5UZmtDR0hqSUxvcU1BVzJDUFllM1lpclBXa1VYcVlnWTVSZmtXR1htbmxr?=
 =?utf-8?B?MmxyZmxKTjZiS0VMVUhwVThCeEVoczVzTkpVUTNQWTVzMVVCaXRSUjF0bVda?=
 =?utf-8?B?em9UUFFFWDVhbWxkUEE2L0h1TDJaNHRES3hYRDJaQjh1andSZytacHNpWk5E?=
 =?utf-8?B?MjFQVVMxb0NHM05TUGhIQnVXTklnU3BiWVZaRkgyeWR3R2JmTC9pVlBiZTdC?=
 =?utf-8?B?K3hTb21EK04rRlZiWUdIMnVNdnZWQWtoOGpCdWRudWRLQksvbVZrT1V3cUVF?=
 =?utf-8?B?UXJpLzBoODBNbE56WDA1S2huczZUSEtHbjFxSHVELzJkWk9wRGZRYlRnZ0hT?=
 =?utf-8?B?QVZZYUc1aU5nYXBINFFnQXlHdzBGUzhWTjBVMXpCcS9qVmh4bWV1ck9nN3Zp?=
 =?utf-8?B?MmtpQnpZQUFhc2hpdlZweGh2VXdXUS92VU9ybnVZaW1xNnpQMWswb2crRTI0?=
 =?utf-8?B?dXVtcVNNWWNjWjNzZDFUbk9BU2xVeW1zUUpiUkNWY3lzWkJMQzhuTVB0YVgx?=
 =?utf-8?B?WFMzL2ZmKzlScC9iQ001bGZ3enFyZDY0a1FxNloxUVNHM29KbDlEbHJwaU9l?=
 =?utf-8?B?cHljQUZqektDR2xUa0h4SUtjSm0yVDkzTXRneWR4SE9aZGZtVlFTNUx3aGlK?=
 =?utf-8?B?ZzRqL1A3eVRPSmJLcFNoZ2lxMy9RQVlUbnZsNFBpZ1EycUhPWjIva1RLNjUy?=
 =?utf-8?B?TlFQUXU4TmtqcEhaZm8vYWxlU3NGdFZvL3AxdHRRMFdXUnpvbVlxWXA2a05E?=
 =?utf-8?B?NEo1bUJTMTRFdFhSNHJWMUJsL1JYTWIyT2htSWNJbmdtZzlvZXZrUGlRcmkv?=
 =?utf-8?B?ZHFNelBJdGJibG1kT0RmQStERTBjVVFkVlpCbU1WbkxFR2M1c2NLRDI5NWxT?=
 =?utf-8?Q?OvNNY7CAM+1Svv1ivbNkH101A?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a80a855f-928b-4bf1-764c-08dd7813f0df
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 09:42:00.0573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYayWu60By8sS/WDfSGydnN8PJs3xY8wUs5vZkrrjfZ3IMgfLMpjrV215p597feNbPSc1gTTY6pPJcwyAI4vkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8580
X-OriginatorOrg: intel.com

Hi Swapnil,

On 3/11/2025 8:02 PM, Swapnil Sapkal wrote:
> MOTIVATION
> ----------
> 
> Existing `perf sched` is quite exhaustive and provides lot of insights
> into scheduler behavior but it quickly becomes impractical to use for
> long running or scheduler intensive workload. For ex, `perf sched record`
> has ~7.77% overhead on hackbench (with 25 groups each running 700K loops
> on a 2-socket 128 Cores 256 Threads 3rd Generation EPYC Server), and it
> generates huge 56G perf.data for which perf takes ~137 mins to prepare
> and write it to disk [1].
> 
> Unlike `perf sched record`, which hooks onto set of scheduler tracepoints
> and generates samples on a tracepoint hit, `perf sched stats record` takes
> snapshot of the /proc/schedstat file before and after the workload, i.e.
> there is almost zero interference on workload run. Also, it takes very
> minimal time to parse /proc/schedstat, convert it into perf samples and
> save those samples into perf.data file. Result perf.data file is much
> smaller. So, overall `perf sched stats record` is much more light weight
> compare to `perf sched record`.
> 
> We, internally at AMD, have been using this (a variant of this, known as
> "sched-scoreboard"[2]) and found it to be very useful to analyse impact
> of any scheduler code changes[3][4]. Prateek used v2[5] of this patch
> series to report the analysis[6][7].
> 
> Please note that, this is not a replacement of perf sched record/report.
> The intended users of the new tool are scheduler developers, not regular
> users.
> 
> USAGE
> -----
> 
>    # perf sched stats record
>    # perf sched stats report
>    # perf sched stats diff
> 

May I know the status of this patch set? I tested it on a 96 cores 
system and it works as expected in general.

One nit question:
Is perf.data and perf.data.old the default files
for comparison if no files are provided in
perf sched stats diff?


thanks,
Chenyu


