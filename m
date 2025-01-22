Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827BB10E0
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 05:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737523738; cv=fail; b=Iyq1Rr6NrNmmQBlOrDesMlewtzsWRlz4XOvRC2HzHYWTYxOvpv6r+xZiDmcMaqIPegu7JRGVH4OxNm25WGU29HjE+WOWTyCtfuo+362jcWr0o+zGnvfTg7r3zm3f+CQ6xF9qRE/ZiKvx4fpxIJejsvALLkT3ykR+0gb4TE3Y5X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737523738; c=relaxed/simple;
	bh=MA5cvjuU9xMBF3SXFz799zceCLVF+mdHMiInf4Q8RKw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JTns3rZf0Em9+Yu6EClYclilH1wwKHKGJCLnq/FGQbS0AEW/gwWqwIbECcUaj1iT52EBIL680++j85SviBkfzJDoYZQGoF5I3x+qjiEd5YVIOk0eOVo19JF+G43iupwOY2tN1HDlfraw8KKF3OITq26aBTCL7rYnzprXiq/7zMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KUzwYrha; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KUzwYrha"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737523733; x=1769059733;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MA5cvjuU9xMBF3SXFz799zceCLVF+mdHMiInf4Q8RKw=;
  b=KUzwYrha6iPrxfCcg/9dUQkmrxCJxYvEjaDqwyJedVYZ8wvMnyjJ6pUQ
   Uy15HTkbH7USFlkznFBBalmUTEmIgsCRvN1RVRKWHACyRzjc7qH6xI4xQ
   crK+xfzuaIfViFWXUy/sjN21lIODrW9qKOKkqQwr5xzJw7EW72a+2SkrQ
   rphyMZ0BM/s5GboKDXVeOwOLpRDFbv4rAwOOTOKWiZ59CsUy7q1WZjyvU
   nBYWTskgUcAxi7BpWYxBQiUtxm60Jzj+cAFn5pK0SgihYdAU+3ZEe3DyT
   jLdTju30Jw+880zt1h3j4RrdpC2uv3zGnVdDkOyVgAKhX2vhtIo9PlP6Y
   g==;
X-CSE-ConnectionGUID: KA9XjRDGRzSTXrrxhzrPAA==
X-CSE-MsgGUID: I+4MjLX8Rxa4gnJNkD5kEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="48955141"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; 
   d="scan'208";a="48955141"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 21:28:52 -0800
X-CSE-ConnectionGUID: tZE/FviuSHyqmQds/NASnw==
X-CSE-MsgGUID: TAKk9ktVRYOYvOmdn3pdtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111047189"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jan 2025 21:28:49 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 21 Jan 2025 21:28:48 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 21 Jan 2025 21:28:48 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 21 Jan 2025 21:28:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Udb+ZSxcmQgpXF5fPtHuLdBFv0B3rUzcYgkZh5a04kmtRQ8nSy6MoJUE6E//8dZ2ySfe9jWxm2xT5rPP3bshDEp21pumKkdEsrnCJfSAOVDwzHKVNOGoQKscgdGWherwJZEF3hA2bc97sOY137cbFWbqrNUhBLjHYeykKtPzvsnTlG0WWFX5V41r8vuFJ581wXzxm4IR67mfW+uBIbHxyEShmLv67SuTwjZ+GZRVt+G7RGD7gIe8dBpQfSInueg7KH4u91iGXbN7jVqdhY21g8pZGd3OXAFGQpNOAVFl2ys2C29oujPtwvVYJ6mHMbTVYnzmaeXCAXLN4RICXROpxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C46idgIbqjegOG6VbFH9qITS4qLzaeXHLD7vlBwv8sg=;
 b=MPVgoQYUZ20f0QyPoS6S4lLWVHDzFyV5BKHl8jVRlkQvMpYttoKse9AhUIFd4cHj61ybhMfYZsZ6Rp5T5qPHIN0Cz0zZhupfC825lFnB80Scv/5k7lyl2ylUmqIxLg/4x73x7bmcCqo7jccwsTIpaUgpESoPPp0eUHwGWTJQ2EUZ9eI2bmaoBvuJJ4GxHjgwW0fD0JbPbkO7VK/sPbXYOkYVNwaOWGDXItw/ZxVZ0IdImsbuKxNkWl6jM1glKLBeTzCnI9xv+SDsWFE/zsovLRE6HgEoU0VFTkreZxCu293AhCAsu0+yll+4peMgKpsN48zl0XvwRiFMCB+RF40lcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 DS0PR11MB8113.namprd11.prod.outlook.com (2603:10b6:8:127::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.20; Wed, 22 Jan 2025 05:28:45 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::d3ba:63fc:10be:dfca]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::d3ba:63fc:10be:dfca%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 05:28:45 +0000
Message-ID: <dc92347d-0e21-44e1-8b0f-ea6f77d041cf@intel.com>
Date: Wed, 22 Jan 2025 10:58:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 7/7] drm/xe/pmu: Add GT C6 events
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Peter Zijlstra <peterz@infradead.org>,
	<linux-perf-users@vger.kernel.org>, Vinay Belgaumkar
	<vinay.belgaumkar@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, "Gupta,
 Anshuman" <anshuman.gupta@intel.com>
References: <20250116230718.82460-1-lucas.demarchi@intel.com>
 <20250116230718.82460-8-lucas.demarchi@intel.com>
 <cbf55ca1-1692-4db4-9589-c07aec53cfe6@intel.com>
 <kihwh2cftvdw72ou2clk7tchrdl5u2bwzrp6n2cizuqyx7jbvf@oolswepiidsm>
Content-Language: en-US
From: Riana Tauro <riana.tauro@intel.com>
In-Reply-To: <kihwh2cftvdw72ou2clk7tchrdl5u2bwzrp6n2cizuqyx7jbvf@oolswepiidsm>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::35) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|DS0PR11MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: a08e1ce1-fd93-4dc2-4882-08dd3aa5a40d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVVWNGF4eXBaNnpOaFA5bnNieG9EbHZ0aVVnZWFxdVVsMlJjNmFSMGhMZ2V3?=
 =?utf-8?B?Wi85SXNRWThqTGh0cE52UlhQNUNzQkQwWE1kMkZmZXdoZ1hvNVdyZWZhUDZ5?=
 =?utf-8?B?WHkzY3hSQVRNdlpQQng0c1JwL1YvbnRWYjFjUUo1R0ZVWXoycHVlbWhweE1G?=
 =?utf-8?B?N0pWcHduZkU5VzJoV3JvUnB6emJOMytKbHByb3lNUzUxbEFBQlMzYzR0YXZ0?=
 =?utf-8?B?eUVrc0dyUFFHWEZvWlVwSVRPUkZRMGFSbmlEcnBTMk5vcjJHM0NWdEFrZFB1?=
 =?utf-8?B?SHFlOElvbzBJaC9BNWE1Z2g0RFkva1RyTEQxNmZSQ0FQaklJWUJTcVFJckI4?=
 =?utf-8?B?ZnY5cG1sdUxrM3dpK0x5ZzMyWEYxVGNLMTZtc1FNOG5WazlGODk4bnpnd2hm?=
 =?utf-8?B?WFk2SXBYLzlFOGRKbFNOQm5ERmc5VXFJb3Z4K1RCSnE1dUYwLzVzSk9vMEoz?=
 =?utf-8?B?YnZ0UkRLdUptejF0bWUvblF3ejZjR0RRdDJKeTlvRm8vOG5ueExYamZDWWtW?=
 =?utf-8?B?ZlBRY1lRVWtVMGJjd2J2Y2FEbExHaEVZNzJvWlNCU0o4K3oxWUtiUGE1MGwz?=
 =?utf-8?B?ZEV6M3U0NjlpWjUyOTZTVzRpVmxyUUZ6cnNDbUNJODVwcGc5NFZOeWhQK2dW?=
 =?utf-8?B?YWViSGRPWHpLajlQWmZ3bjJrbzBJUW5qbVQxZ0liTUI3WFU2eERnSEpMUzMw?=
 =?utf-8?B?Z2hkZWdZVUh1OWpxNENURzFvTWtTNUJzK00wb2xpVkp6bEx1MGg0YzdYalhP?=
 =?utf-8?B?N0VIVHQ2TlBFRG10cUE1Tjh6VUgyNkMyeWZoV2E2ZXd6KzFFYUtvSmZKWktY?=
 =?utf-8?B?OGthenRybUswYTNPNlVNRFNNQlVDV2VKTUF2UXRvcDFHK1RuTzVYczNrMGVJ?=
 =?utf-8?B?Tm5pcnJqVFliSVZQb3U3blBSVDZRZXdkUm03Y1VUeWdsRG5vdGYxYkpHNmRM?=
 =?utf-8?B?QmFYSFhIbG1qV1gycTdXSDZyTWZEQU5YSjZpL0pUaytTRXR0cnZJK1pBQnlu?=
 =?utf-8?B?NFFETkhPd1htUU9COEZCdVMvckRGcHVsZWVtTllzQUhCQWQ5SmROT2NSUXlX?=
 =?utf-8?B?RTgvQ0xORzliRnYrTmNqL1Z6M2FoMzJuRjY0aU5ORS9DMElKMDltc2VxNWt3?=
 =?utf-8?B?bTRtclNTalRUQ3RTWHMvYngrK3daaEdjSitqYzB5YnJwamtGMzhPL1VkVGtY?=
 =?utf-8?B?NXhKb0FQakdvUFZsc1RSaVkxblVMalkyWU1tclV3U1hmZkNJQmVyMHY3ZmUv?=
 =?utf-8?B?TS9vMEd4dG1XTG5QL21WQmsxdG5wWWxWNlRqNy82a2ZId1BWb0x3aFNwUUZD?=
 =?utf-8?B?QkZjMTRQSXQwbitSTEF4OEpCblZJR3ZQVG5kZzhUSmdvbThTV0FRbUtJYlVx?=
 =?utf-8?B?Ly92VENRQ1d5OE04MlFRUkpxaEtwcG1OY3A1VVRMZTBQLzNzM3JiZHFGTzlD?=
 =?utf-8?B?R3RHZnI2NGsxemMyeHJGdTBtd0VCMGd2V2ZCUVRTMFZ1R01EM3VPQVNnVjN5?=
 =?utf-8?B?eStrRndqanRYMVEzejk1bGd6T3hGTE1DUkZjWElJaU9NWTJyWjAyN1hBK2NU?=
 =?utf-8?B?aUdMZXp2dHRqd0gzbWVYWGVQMHd6RFI5TkRqZDMrM0Nqd3hiYlJWRjNZRk5J?=
 =?utf-8?B?ZnJyQXJ1WHBybWRzL3hEamJ4R2pNUUphdHVUVDhRMHl3NjJuekUvWkJzUUxk?=
 =?utf-8?B?RkVzVFZ4OEUxL2tXTktGdEhlWGM4Q0RtT1h0U3ZKUjZ2Sy85bHJkTjRCNS9J?=
 =?utf-8?B?d2hnQWJBRnM4RWtYbW43WDFFQ3EvQWRRazNiMTQrTXFMM3V0ZHdkZ2R3RFdN?=
 =?utf-8?B?TXJGdkM1MFhYSlcwL2tLTXFST0J5cW5CWW1xS0k5NDV5UWpwU1IxQXlRYkRJ?=
 =?utf-8?Q?74BopcXnMEF4Y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEU0SnNvZ0lNejYzS25qUjVaeXN6V3ZUS3FPTlNnK2RVT2tBYTdlc3J3SFJi?=
 =?utf-8?B?eUN1U3VXbE5MR1JyVWI4dnNtSk5VUFVISVNNcXBHM2k4eWw4UEh3bnRPaWpo?=
 =?utf-8?B?SlhQUzI0c0hSSXRDaTUyeFUydlBqdHhXT3FJRk5TUzZJMUtpWTVqSDJJMUx1?=
 =?utf-8?B?d0JWeUVjbVBkM2NrZEVCdk5XM3QrRmxET1RWR0g3K2FzT2VHa1NGRWVUSytL?=
 =?utf-8?B?OHRydWU5QWZxU2FIVWdJZVNxNS9TbzhKOUxnWEhqWlc5V1djSDhSZGc1V2hx?=
 =?utf-8?B?eHlBbWlNR05pV3g3K3RoeVRGeXhGR09xYlZQaFN3OWZqYnF6TFZ5NGVxNERh?=
 =?utf-8?B?WmQ2aEoyUUtSZHQ3NytlaGk0R0E2M3A4QzMzcjNZRXB6eDNLTUx4VWE4Y2Vx?=
 =?utf-8?B?ZEx2TEkzQ25jbnRtc2Z3b2pWN29tSDVpN1BXemJJQStKMEU1MUhuK0E0eS8x?=
 =?utf-8?B?OXNteWkydThVRmc5YkRqYVloM01Cd0VkcE5laWkrdWVHN2ZMQ0IrV29EVi9W?=
 =?utf-8?B?SkVZMFptM0lETWJFbTJoZzJWQys1S3JyMTNqVVkyUldndmtVNVdUemZDNmRC?=
 =?utf-8?B?WERWOE0rU0pLUVdlWm9ydUNTQ2NxY2ROKzVTTlp3VXd2M21JR3hoajBYMlhr?=
 =?utf-8?B?S01pemxENzJKV2ovTHNQb25yU3MzUEdJanV0MitZRmJja0E3Ly8yanc1Smkw?=
 =?utf-8?B?VE84bkpiMHZTZ0dlVkdlblc0ZDNWY0VUb0Q3dWN4YVUvWUxwcU4zMkZjWlFC?=
 =?utf-8?B?ZFdtV0Zlc1J0RkJVcGdBRklZRE5PTjhUK3V0NVA1NEI3VXpBQ2crUFd1Rm5y?=
 =?utf-8?B?N2FRc1RaVzVuSk5MdnBOTWQ3NGkyYmVRWnd2RE5Vd1JnN3h6aWxNZnFzRjBS?=
 =?utf-8?B?L0FHNnpsUmdaYzVkdzYyQSt2WnlTYUdMV3E0OEVsaXNHa0VmcWpWbjArVG40?=
 =?utf-8?B?YWpsanZadytCSjdVUy9IM053UG9xTEYydG9tZkZ1MXYvNk9PWk9SbWRWQVJT?=
 =?utf-8?B?cVR5MThLeWg3d0Jkd25ZNXY5eDRnakNOOFNlU05KRVBMbGpLbkRpVHYwUWlz?=
 =?utf-8?B?c2pkUzM5S0hmaU0wNzdjSXNzNHdyRm90c0c2blZYSkVZUkZwdWcwUUUwQkFy?=
 =?utf-8?B?ZGpvaUswaDd5OE9pRi9Beno4Mm5xZ2Q2SVBXSm44UEx6N0NQa3kvSmUyTjh1?=
 =?utf-8?B?bUN6ZjdJRWFhc2xLVmdVbGx4QmR4amh5K0xRb3ZoQ0NRZ201ZmdRa2hOSjMr?=
 =?utf-8?B?cmM3OHVIbk1kVlhlZEVadzY3clhYSWtTRkVHRWNNeTRnVHVjdzlXVkN1YUtQ?=
 =?utf-8?B?dWZmM09mSkJFNzFWZjIxaDFFSUtiQ3AvbTRkM3AwNlk0VzE3QlkraEh1OW9D?=
 =?utf-8?B?Z3Y4THIwbEVxQUF6TndqZk9TeXpMVEZscXB0VE11cEJISXJtaUdRN0UxMHN3?=
 =?utf-8?B?azh3bVZOVlNBNVBqVTNYSmdSbVJhS2hlUHlEemgyNFB5VXRDVUJCdy8ra3Vt?=
 =?utf-8?B?bnFxMDBvWXFjOGJCYmFIbC85cG5Fams1NUVxTy9CMitUZFRiYk9ZN2tEdkRy?=
 =?utf-8?B?eTBaTElrNkxZMzhkbW9XTmRSVGhPOHdTVkNBSzNWOTliSFgwS1NuRmpPWHN5?=
 =?utf-8?B?dWo2bkhobktHTnJITlpvSXZoS3V2MmRXSGcwWFpqU1pJOE1WQ0RTb2VES1Uw?=
 =?utf-8?B?cHpxK01Lc1JyeU9OWlQwT1hVUjUwZlZJeC9EK2R6YStYZGtyVldkd0szSGZk?=
 =?utf-8?B?RVV4Y3E3YlIxbDZDTm8wL1Y2YzlPZTVmRFNnbVZETnYyQ0FsOU1lTS9EbXRa?=
 =?utf-8?B?ak5IUllLYWlwQkJFR2crdXMxNFkzVHl2MDFuSmpyZzBWcTM3cFZpNEN6YUFr?=
 =?utf-8?B?Ymd2Z2Q3bkxYYVBMdXdlMkFUcERaZzRKd0dmcUNwcWFRYzlGbjJPNW1QMlc3?=
 =?utf-8?B?MXFBQ2FjdWtSY2wwdFZKNG9PZk9YY3cvNUR3eFlTYmpxeC84cFg3c2dHZTJT?=
 =?utf-8?B?OTBiT0M1K0dSOTBHUVFFOXVjK041OE5mcS9ia1BWWVk0OFhvQ2dwcFplRnpz?=
 =?utf-8?B?WGRuSWQ3RjNtcmdLNFJoOGVpK2s1NHArNVR5NXdjQ1ZLN1hCdVRjamR5N1FL?=
 =?utf-8?Q?nRPy9ve8kSTaB4/MNnaG5HAIw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a08e1ce1-fd93-4dc2-4882-08dd3aa5a40d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 05:28:45.6162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V03h0C8fyVao6JU4vxuNV2hGcle4rR6VtqqsSlMLgLSDZokoLcQlxAqHQ+3txf454uJ3ddspaVFwIguEn3B4qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8113
X-OriginatorOrg: intel.com



On 1/22/2025 2:08 AM, Lucas De Marchi wrote:
> On Tue, Jan 21, 2025 at 11:46:45AM +0530, Riana Tauro wrote:
>> Hi Lucas
>>
>> On 1/17/2025 4:37 AM, Lucas De Marchi wrote:
>>> From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
>>>
>>> Provide a PMU interface for GT C6 residency counters. The implementation
>>> is ported over from the i915 PMU code. Residency is provided in units of
>>> ms(like sysfs entry in - /sys/class/drm/card0/device/tile0/gt0/gtidle).
>>>
>>> Sample usage and output:
>>>
>>>     $ perf list | grep gt-c6
>>>       xe_0000_00_02.0/gt-c6-residency/                   [Kernel PMU 
>>> event]
>>>
>>>     $ tail /sys/bus/event_source/devices/xe_0000_00_02.0/events/gt- 
>>> c6-residency*
>>>     ==> /sys/bus/event_source/devices/xe_0000_00_02.0/events/gt-c6- 
>>> residency <==
>>>     event=0x01
>>>
>>>     ==> /sys/bus/event_source/devices/xe_0000_00_02.0/events/gt-c6- 
>>> residency.unit <==
>>>     ms
>>>
>>>     $ perf stat -e xe_0000_00_02.0/gt-c6-residency,gt=0/ -I1000
>>>     #           time             counts unit events
>>>          1.001196056              1,001 ms   xe_0000_00_02.0/gt-c6- 
>>> residency,gt=0/
>>>          2.005216219              1,003 ms   xe_0000_00_02.0/gt-c6- 
>>> residency,gt=0/
>>>
>>> Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
>>> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>>> ---
>>>
>>> Besides the rebase, that changed a lot how the event was added,
>>> here is a summary of other changes:
>>>
>>> - Use xe_pm_runtime_get_if_active() when reading
>>>   xe_gt_idle_residency_msec() as there's not guarantee it will not be
>>>   suspended anymore by the time it reads the counter
>>>
>>> - Drop sample[] from the pmu struct and only use the prev/counter from
>>>   the perf_event struct. This avoids mixing the counter reported to 2
>>>   separate clients.
>>>
>>> - Drop time ktime helpers and just use what's provided by
>>>   include/linux/ktime.h
>>>
>>>  drivers/gpu/drm/xe/xe_pmu.c | 56 +++++++++++++++++++++++++++++++------
>>>  1 file changed, 48 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
>>> index c2af82ec3f793..37df9d3cc110c 100644
>>> --- a/drivers/gpu/drm/xe/xe_pmu.c
>>> +++ b/drivers/gpu/drm/xe/xe_pmu.c
>>> @@ -11,6 +11,7 @@
>>>  #include "xe_device.h"
>>>  #include "xe_force_wake.h"
>>>  #include "xe_gt_clock.h"
>>> +#include "xe_gt_idle.h"
>>>  #include "xe_gt_printk.h"
>>>  #include "xe_mmio.h"
>>>  #include "xe_macros.h"
>>> @@ -117,16 +118,50 @@ static int xe_pmu_event_init(struct perf_event 
>>> *event)
>>>      return 0;
>>>  }
>>> -static u64 __xe_pmu_event_read(struct perf_event *event)
>>> +static u64 read_gt_c6_residency(struct xe_pmu *pmu, struct xe_gt 
>>> *gt, u64 prev)
>>>  {
>>> -    struct xe_device *xe = container_of(event->pmu, typeof(*xe), 
>>> pmu.base);
>>> +    struct xe_device *xe = gt_to_xe(gt);
>>> +    unsigned long flags;
>>> +    ktime_t t0;
>>> +    s64 delta;
>>> +
>>> +    if (xe_pm_runtime_get_if_active(xe)) {
>> Seeing this lockdep warn on reading gt-c6-residency
>>
>> [ 5032.731663] =============================
>> [ 5032.735699] [ BUG: Invalid wait context ]
>> [ 5032.745260] -----------------------------
>> [ 5032.749300] perf/3320 is trying to lock:
>> [ 5032.753260] ffff888105f2c238 (&dev->power.lock){-.-.}-{3:3}, at: 
>> pm_runtime_get_conditional+0x26/0xb0
> 
> ugh... thanks. Currently we are papering over that in drm-tip since
> i915's pmu is completly broken.  I need to remember reverting that hack
> from topic/core-for-CI to test things properly so xe doesn't have the
> same fate.
> 
> here dev->power.lock is a spinlock, but ....
> 
> 
>> [ 5032.762528] other info that might help us debug this:
>> [ 5032.767613] context-{5:5}
>> [ 5032.770262] 3 locks held by perf/3320:
>> [ 5032.774045]  #0: ffff88846f632048 (&cpuctx_mutex){+.+.}-{4:4}, at: 
>> perf_event_ctx_lock_nested+0xba/0x230
>> [ 5032.783587]  #1: ffff8881037482c0 (&event->child_mutex){+.+.}- 
>> {4:4}, at: perf_event_for_each_child+0x39/0x90
>> [ 5032.793480]  #2: ffff88846f631fb8 (&cpuctx_lock){....}-{2:2}, at: 
>> event_function+0x57/0x120
> 
> we are already holding a raw_spinlock.
yeah and it's seen after 6.13. That's why xe_pm_runtime_suspended was 
used as it was not throwing any warning

Seeing a similar one for force_wake too, for engine activity. fw->lock 
is spinlock. Any suggestions to avoid this without changing it to 
raw_spinlock?

[  465.380652] ffff88810d5b8098 (&fw->lock){....}-{3:3}, at: 
xe_force_wake_get+0x1f9/0x8c0 [xe]
[  465.389168] other info that might help us debug this:
[  465.394221] context-{5:5}
[  465.396847] 1 lock held by swapper/0/0:
[  465.400682]  #0: ffff88885f031fb8 (&cpuctx_lock){....}-{2:2}, at: 
__perf_event_read+0x60/0x230

For runtime_get, rodrigo's suggestion would work. But taking force_wake 
on event start and end would cause power issues.

Thanks
Riana
> 
> The previous check for xe_pm_runtime_suspended() would get rid of the
> warning since it doesn't take the dev->power.lock, but it would also be
> racy. I think using the simplified interface Rodrigo proposed would be
> the ok:  just take the runtime pm when creating the event
> and releasing it when closing. It brings back the issues of releasing
> an event after the device unbinds, but hopefully that will be fixed soon
> by Peter's patches to perf_pmu_unregister().
> 
> Thanks for checking.
> 
> Lucas De Marchi
> 
>>
>>
>> [ 5032.829907] Call Trace:
>> [ 5032.832384]  <TASK>
>> [ 5032.834513]  dump_stack_lvl+0x81/0xc0
>> [ 5032.838236]  dump_stack+0x10/0x20
>> [ 5032.841586]  __lock_acquire+0xa5a/0x2550
>> [ 5032.845548]  lock_acquire+0xc3/0x2f0
>> [ 5032.849156]  ? pm_runtime_get_conditional+0x26/0xb0
>> [ 5032.854066]  ? is_bpf_text_address+0x71/0x120
>> [ 5032.858487]  _raw_spin_lock_irqsave+0x4b/0x70
>> [ 5032.862892]  ? pm_runtime_get_conditional+0x26/0xb0
>> [ 5032.867814]  pm_runtime_get_conditional+0x26/0xb0
>> [ 5032.872570]  pm_runtime_get_if_active+0x13/0x20
>> [ 5032.877141]  xe_pm_runtime_get_if_active+0x12/0x20 [xe]
>> [ 5032.882545]  __xe_pmu_event_read+0x116/0x2a0 [xe]
>>
>> Thanks
>> Riana
>>
>>> +        u64 val = xe_gt_idle_residency_msec(&gt->gtidle);
>>> +
>>> +        xe_pm_runtime_put(xe);
>>> +
>>> +        return val;
>>> +    }
>>> +
>>> +    /*
>>> +     * Estimate the idle residency by looking at the time the device 
>>> was
>>> +     * suspended: should be good enough as long as the sampling 
>>> frequency is
>>> +     * 2x or more than the suspend frequency.
>>> +     */
>>> +    raw_spin_lock_irqsave(&pmu->lock, flags);
>>> +    t0 = pmu->suspend_timestamp[gt->info.id];
>>> +    raw_spin_unlock_irqrestore(&pmu->lock, flags);
>>> +
>>> +    delta = ktime_ms_delta(ktime_get(), t0);
>>> +
>>> +    return prev + delta;
>>> +}
>>> +
>>> +static u64 __xe_pmu_event_read(struct perf_event *event, u64 prev)
>>> +{
>>> +    struct xe_pmu *pmu = container_of(event->pmu, typeof(*pmu), base);
>>> +    struct xe_device *xe = container_of(pmu, typeof(*xe), pmu);
>>>      struct xe_gt *gt = event_to_gt(event);
>>> -    u64 val = 0;
>>>      if (!gt)
>>> -        return 0;
>>> +        return prev;
>>> +
>>> +    switch (config_to_event_id(event->attr.config)) {
>>> +    case XE_PMU_EVENT_GT_C6_RESIDENCY:
>>> +        return read_gt_c6_residency(pmu, gt, prev);
>>> +    }
>>> -    return val;
>>> +    return prev;
>>>  }
>>>  static void xe_pmu_event_update(struct perf_event *event)
>>> @@ -136,10 +171,11 @@ static void xe_pmu_event_update(struct 
>>> perf_event *event)
>>>      prev = local64_read(&hwc->prev_count);
>>>      do {
>>> -        new = __xe_pmu_event_read(event);
>>> +        new = __xe_pmu_event_read(event, prev);
>>>      } while (!local64_try_cmpxchg(&hwc->prev_count, &prev, new));
>>> -    local64_add(new - prev, &event->count);
>>> +    if (new > prev)
>>> +        local64_add(new - prev, &event->count);
>>>  }
>>>  static void xe_pmu_event_read(struct perf_event *event)
>>> @@ -162,7 +198,7 @@ static void xe_pmu_enable(struct perf_event *event)
>>>       * for all listeners. Even when the event was already enabled 
>>> and has
>>>       * an existing non-zero value.
>>>       */
>>> -    local64_set(&event->hw.prev_count, __xe_pmu_event_read(event));
>>> +    local64_set(&event->hw.prev_count, __xe_pmu_event_read(event, 0));
>>>  }
>>>  static void xe_pmu_event_start(struct perf_event *event, int flags)
>>> @@ -267,6 +303,10 @@ static const struct attribute_group 
>>> pmu_events_attr_group = {
>>>  static void set_supported_events(struct xe_pmu *pmu)
>>>  {
>>> +    struct xe_device *xe = container_of(pmu, typeof(*xe), pmu);
>>> +
>>> +    if (!xe->info.skip_guc_pc)
>>> +        pmu->supported_events |= BIT_ULL(XE_PMU_EVENT_GT_C6_RESIDENCY);
>>>  }
>>>  /**
>>

