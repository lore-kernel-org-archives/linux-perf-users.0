Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FE928E7;
	Sat, 11 May 2024 07:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715413576; cv=fail; b=iNiaxK1WVrR3x+OD5uL9hDuv1LR8Bg9U4BQ3zNfZlHa3WXZFemsHTX9sZsctpQyyQjEj+9GxspnY0QEHnZP1oPg1o4QQNilbWizOidcEFF03cpCL/7gWg/Yo38CZOSjr1rM6aIIH/zYygalNIjfUyYZTR5b3SPqnlEIx/QEKGyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715413576; c=relaxed/simple;
	bh=0hH1XH+bK9Ts6lVm0t7VlP5AohCg7Ijj6Wvp5WLPAH4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o5Hz29DPHn9/WzMv6Nan0N2v92v7qJxA7Z2DYsdjEYxy9WDVdt0HZD/igGtEiT+hetNBc5mYH+/u40zulKCJD0ic7CQYugFRMXJx7mQ2rj/VgxLhBw9RjLnTaYVs1JCfqpSBfkNm66ReUugP9uPabelSjRyCyhVQkOIwnuidWSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bKk7PJ8U; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bKk7PJ8U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715413575; x=1746949575;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0hH1XH+bK9Ts6lVm0t7VlP5AohCg7Ijj6Wvp5WLPAH4=;
  b=bKk7PJ8U64TyfwR/3xRkH6kluXrn622x2lb3a0jvFEy1g951nJXlLdP8
   yjAE4EGMfCMyGtW1pClXYMVxdP/6aC3K5c9f7MulKhb3kjLXPAxojTiBc
   +I6QK/3bnfOj7oae8R7eBsKB0AJaNuhrNZbrcl3YxvPeMjl5zGz/difb9
   MfMhxUZ8zRnPDhcTdOAWAj2r1czeyHTADcI1QYzgdDfNXtvzOPt0J2gxz
   3D6XIlvW85v4znrXnmxMEW4GHDsNJRlFdJqt0DtRVRgaMT89LB21SWMAZ
   Gkqv4A02qmfWKsVUA4v+H1SSjFU9hYXZd+KIhdsGo6JcLcBw8xLDPTmPV
   A==;
X-CSE-ConnectionGUID: fZpwIGuHQcONmD/3I8llgw==
X-CSE-MsgGUID: woWO4My6QViBB6qD22nVYg==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="22562464"
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="22562464"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 00:46:14 -0700
X-CSE-ConnectionGUID: 8ToaQ54cTKCWKZmUCFb7jw==
X-CSE-MsgGUID: mbPzbUi3RhiKaYXV8hhyjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="30421698"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 May 2024 00:46:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 11 May 2024 00:46:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 11 May 2024 00:46:13 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 11 May 2024 00:46:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbSB+MNApx1/sluQmQNmOTH4tV/f7m+FzfX4N7ZlrDEu8oMICZwrq/SFxPfRjaIh6GH2Qv1UQdLW8tJoWxvjgz73N3VduqEaZDaNc44Hc5NqkG3jZ8BevR0QfvPx329hYh9boSFyHNpbsE85y9pR/rn3ZqMNsjerRngVo9OBCxCpFnwfo3Aeqmw3MzMLBk93DpckNj4njlgfz2BVL9bSPrBujGabAIaL4AKVM1fGvB0e2NgwFNyBNIr/7+TpmQSbU9AOv7l4I1fWpXa+JTDHgT28Zc+GHVkjOiix5lLHi4KHRqDPzxLyaOpECCiq8u0ThrAmq3TdSOmoOsXN7bQ2+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s25hGzESRZIU6wFLwflHd5LU0E46xRqrnzY0n6zOQho=;
 b=LgrN3AkDtqjEWgd9UcMYW+XDnIxsbqY9kiCgHPND22ZU3lpIqBOaiYBaS2up9kK1tolyRcW/8CMXutGpPWcQqwx6Y5bcIB1+LkRPy609bVdmq/Zz8/vVaJ36xDu7yGpVtRqqeOJ79srzQH20/tMDHtAv3cnRzbMPLuszww8Q0dPGBMpeEdXTrdxwGl+JCSKVb66Elh0qwFTG6JhSg+arCY92+UjoobU+O5DlBBtirPNwqQNvmxMQpDLE+DigtmUPTVTtNOpTo8+q7yPqYrwbXGYpzwhlWxK41FASyAsxK47w0EFvSYSJ4DA4Jda2cHpNtnJ9BjXdZbAklUZ68w0eMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 MW4PR11MB6812.namprd11.prod.outlook.com (2603:10b6:303:1ee::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.49; Sat, 11 May 2024 07:46:11 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.7544.048; Sat, 11 May 2024
 07:46:10 +0000
Date: Sat, 11 May 2024 15:45:53 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Ravi Bangoria <ravi.bangoria@amd.com>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <swapnil.sapkal@amd.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<bristot@redhat.com>, <adrian.hunter@intel.com>, <james.clark@arm.com>,
	<kan.liang@linux.intel.com>, <gautham.shenoy@amd.com>,
	<kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <santosh.shukla@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: Re: [RFC 4/4] perf sched schedstat: Add support for report subcommand
Message-ID: <Zj8iMV9vhyGC3tT9@chenyu5-mobl2>
References: <20240508060427.417-1-ravi.bangoria@amd.com>
 <20240508060427.417-5-ravi.bangoria@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240508060427.417-5-ravi.bangoria@amd.com>
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|MW4PR11MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c06475f-b80d-482a-0902-08dc718e6cb0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5sf0VHcqIxomfBRIQNbORZELViMAy3zsXIr1byI7oaOfTBjCqqZ6nBPfvSen?=
 =?us-ascii?Q?n7s7YJ7jiZoW4PH8nNVtP2lcjsSSgXtW5wxPCRmkOa6OSGpa1vawKN5zsq21?=
 =?us-ascii?Q?nF+wEVosCT58e/qe9A5pf/VYGHK4eiT1WcptojT7vjYmvFIABgbE0OcK+vcI?=
 =?us-ascii?Q?OmlrYOZ2tn+Jh5E78wxQLlhAQy1HJZFIPpJAdl2jFII9T+yQHm2642TtPgwO?=
 =?us-ascii?Q?SsCdk9jTiwIzeEQHNTW6+OUP23QFsrRs5sG0T8M5DInDm5fp7TFAVlRoUPLr?=
 =?us-ascii?Q?BXyuG4jt0mVw+m5qBVKqbJNbPvSEfUZKvC9kkCYi6Azw+YhRVHKuiws5wvhj?=
 =?us-ascii?Q?LnX+SX1q5OvNkYipdBKxsq6ljv5HMKyFTjllRDJ18N2qvfPeffRuW5U0hpu8?=
 =?us-ascii?Q?+k77KS9txjhAXDba9JcoZ8C6MKDH3nCPxDTl2h3UgUJgLtBWdYr9vCYtP7dV?=
 =?us-ascii?Q?AiUWDtF0gFvS/8sfhDYdm3+ub0BW7OSVkZwO0Bj2eZ2v+gj3GLaeiDkTWHJX?=
 =?us-ascii?Q?hViF7580POhzfk6rZgZTwiW/vn5rTn17Tcz/HA4Jj+kLx0pTA9gIl0sNXn2Q?=
 =?us-ascii?Q?E6HMU5V9QFuFYJq3nZsfkuw1aT/4uqNlbIHZlf6LVZTfOzNub5cJWX61nBgg?=
 =?us-ascii?Q?8bw/c3wJIqQWFPVR9zo+A0kDhGUXCXN/Xtp46s0hQQpNYL+sUxLhsRpxdMx3?=
 =?us-ascii?Q?qOs1Pk2kn2EbhSpzW++l561lNUv0TbgAwZVo+NUEULWJeI8JwM4Led9fn2GG?=
 =?us-ascii?Q?9kbB5scDvq5tuNIrVAUxS4C6XwWdIQZlTtOyYWkAQnBoWBwiYi9kEepFK9BQ?=
 =?us-ascii?Q?tiOT2QW+Ndm4UIV0GNBzMcJmYhp9hMoEky00QDer2yeZFSif854L6UiwpQsK?=
 =?us-ascii?Q?EVSPgi01lq2t+u1kj4qCayE5vrIJ6SMoe2xKJo/o/ssQ+pLisaemVmWUc//4?=
 =?us-ascii?Q?Mah01OUW3PNXWLNQZGR8jT0LNhBhkNbbQ27QdTcCNp8qQL/XpMndGQjmjz+E?=
 =?us-ascii?Q?rsIJRLav0aMCk9viYgoXrWERHtlZRtkUNvzYGy6fA4JKgpQHVKDkClHkDMeI?=
 =?us-ascii?Q?TJY6uZbxomhGTZGb9vdwnrytCCAhJekohHapSoK/N8P1HErtfHBQhuPl8l9u?=
 =?us-ascii?Q?tz1R0qrhKJLBEYCdTy0l0ArmFs3kdpkOkmZfwUR7vuk/PpIt/vstGj13lnKd?=
 =?us-ascii?Q?kFVYAY9bQitPVKnWQs2ilq8aZLqqKnNpUWESWUAboXBVK04YS0jkegk41BsE?=
 =?us-ascii?Q?dNo/kQWLGsAULj+fmP928Nft9FMtX0o+ig421G9/4A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h05TRhWL436EMtReEhAo2kyNEZsNyj41sFgIAyApRsyTmudI7rUAxj0l6pFq?=
 =?us-ascii?Q?VPM/SXGajHeLx8vvMopFlqxFGf7VEQDAeQcmPagVM0KmoLV0ZNigsOvwSXKs?=
 =?us-ascii?Q?bi4CpbK02TjY1qDMN7RexVR4/ibnBSbQygUmmnQiKUzGWyvbcRJNz8ZLUWpX?=
 =?us-ascii?Q?o3XvGQh1kxWWCB/5WpnNohwb4YWG85I1EPD0xBptBk5dBbj5JYHwfhJNldjW?=
 =?us-ascii?Q?jLW6bKF4tEgVXp8j2hkP+Uiqr6lmmbdkngcOZH0lCm5XHAkOdCIvKDI4mU8Q?=
 =?us-ascii?Q?hDvRqaPt989wPm6TigQFpZL7IKs7v0Uef+pSf0OHNOmOFJ96ko0PA0TE+mbN?=
 =?us-ascii?Q?XMhHUCJlZmmrkM6XHfxdt/966u0oLiQtDDEsQRqxPSRDu2EKISxsNmJs2+ht?=
 =?us-ascii?Q?sbwmm4bOuPZ5MoWd0L+fXQCU9PYUxXpffJN4oqumE7nwLHnj/ZOPms3mMnp/?=
 =?us-ascii?Q?jSQMjbfD6gBy4UMwop+OJWPy/AItyNDSY9WFi44OiosoKmZVaZOsxTrpsAcP?=
 =?us-ascii?Q?OHyFyY/JnkhNRPUIh+PJzzKxed919WG76la3iV1hsFa4cViB3ZEprjdr+Atq?=
 =?us-ascii?Q?r1VJ6gWBaaIsPmdpNlhn1Xbsl3vWZRBcGhwEbPBDtIUzVrF/T46sKCnxw1lW?=
 =?us-ascii?Q?BtM24XpmwtjOqd8F81lIDqwoGpKMGuH7D67UWgiXoPWqv4zJ6GYACZRJ3sxU?=
 =?us-ascii?Q?tFzZk09RfphDo7CRyF04W/71cZkSsRsI47qt5W6m1gd4POa3sEqJUkfWRa/l?=
 =?us-ascii?Q?YtVq54MjGpOkoADYocG94MYnSSp0wCLZB/R5aswXZQ0MByxg5UCbuzK9XJzc?=
 =?us-ascii?Q?DJaG38Clx62DpShOebCQ6z++eicrEROIFSjpR7PPpu7qeyr2vDWyBDzxZNld?=
 =?us-ascii?Q?Az7Ge2wNns1NRKGxHErdGJyJD4aWMXEq9/Mvx6kO1sxIkOXe1wUFcBb4VU8N?=
 =?us-ascii?Q?1cEnzfdMsi+39basyEQUNQFYojMu+aLbLloDgvXWeLAKvY4mHJweA+1RCERo?=
 =?us-ascii?Q?IvD3Nv8BfnRCWVsn+AJijCSED0t/s0HEn0ImNINju+C4Jc79VITrOqFTxv/J?=
 =?us-ascii?Q?hd5RNEWZ1qBzg9Bf8e2gRHYWN5Z7aEWkTZzt9Z4LZ3+KhyUghY8i09SKdkpa?=
 =?us-ascii?Q?bbs3VD7R7TYbN9QAkWcWHREwa4ZP1W1J3Jy7BeCmdpXeDTt9yGyLwXu6hfRe?=
 =?us-ascii?Q?EfAhSrjzsapSU8XEbY9aFW4WoCFqPuakOxubUXuIFk/0HK/ztpKn3OvLQnYw?=
 =?us-ascii?Q?60ri1u5PmrHI/WH3B+Hb513IXd8iRHJ2IVzs5n+lXGacbHr4e7m8vYnBqWEn?=
 =?us-ascii?Q?4eE5x40Bdtc4PyngH4AQFcuxgcpVEeBp57a2cWPG/1eAiYMtevvS9Gr9LkD0?=
 =?us-ascii?Q?mJKAhBv8+RNJrCHbzpRVhyYKNCsbvPMeWXwwZ+INLQS/H4YuwTRVtuVb0reC?=
 =?us-ascii?Q?2TbREVe5OpaFycGbUvwEXRfI/zISF1OertEmcRR7wiyPwy9FrRj6+MlEiguf?=
 =?us-ascii?Q?f0BTQ3w+/rJgh1Vg0Tn67gip8RlUjmCv30RNmGMK/VeVZphIj18YN+Kh1lyp?=
 =?us-ascii?Q?sPAGMWtvNtDX6NGAK1dtln/CRlf4TUQiTQpthaKw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c06475f-b80d-482a-0902-08dc718e6cb0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2024 07:46:10.4007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3I0RxHkNX+magSkWiesKu7OxceXVPE8nDrW7exyMihGY0RN0ORUFvlUCnX/bua/5NcHnUQvzu+uPxIVE5V1kGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6812
X-OriginatorOrg: intel.com

On 2024-05-08 at 11:34:27 +0530, Ravi Bangoria wrote:
> From: Swapnil Sapkal <swapnil.sapkal@amd.com>
> 
> `perf sched schedstat record` captures two sets of samples. For workload
> profile, first set right before workload starts and second set after
> workload finishes. For the systemwide profile, first set at the beginning
> of profile and second set on receiving SIGINT signal.
> 
> Add `perf sched schedstat report` subcommand that will read both the set
> of samples, get the diff and render a final report. Final report prints
> scheduler stat at cpu granularity as well as sched domain granularity.
> 
> Usage example:
> 
>   # perf sched schedstat record
>   # perf sched schedstat report
> 
> Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>

I've tested it on a 240 CPUs Xeon system and it looks very useful. Thanks!

1. Just to confirm, if we want to add new fields for debugging purpose,
   schedstat-domain-v1x.h and schedstat-cpu-v1x.h are the only files to
   be touched, right?
2. Although we can filter the output, is it applicable to only track some
   CPUs? Like perf sched schedstat -C 4 record

thanks,
Chenyu
 
