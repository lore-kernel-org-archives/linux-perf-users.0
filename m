Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FF91D1E92;
	Fri, 25 Oct 2024 08:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729845458; cv=fail; b=o4/aIgrjSls6D0ZLvNxQO+pBwt4id3xnJEzCcKxjTUenZjn7Gf+o/WAHppMCX0gwJRAqSwzQRAXpcZAn/ATABHSF7VoCGbuz59Vq0Dc7fnMmGM1qyJHStWR1Lupl6xoFf8sTXhlnSvFVj4Yfqtdyqay02VW1z2VUBQIA8yA8MT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729845458; c=relaxed/simple;
	bh=KdqgQxjHV0r77+Q3ykN761NKJgpUqyWVMJiUXnvXPQw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=oNSM4OgLf967haPx4T2Bj8KztxAL+3mKVgx8+0S5JhawmzL+WSO3k7w7gLN1Qjk/UAh9tMp3mlU2pKGEZH5Xp9mP6rKRxCkEYMSlxZvtj6NFtc3HBjJTD37yp1a/sUmOC1ppKIBzI8ztCQRBoLPrOg27SOqxOfNb4p14BFtL5Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RTyrCEVM; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RTyrCEVM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729845455; x=1761381455;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KdqgQxjHV0r77+Q3ykN761NKJgpUqyWVMJiUXnvXPQw=;
  b=RTyrCEVMum3XCwG0/ND47MoV84tKwq9RwY/DlxslK2f8u7dshSiZMjZi
   WEupzBE3lsqsSp6lYQN2i/WxHD3yZGAW2UoFmp3FB9WtJuM5t4oQS0czW
   ABA2jkTEr1PwJ9mMvp/ruqe1JLrnN9tX4dC9z4zDEMtg8KGfvseKYuu6X
   YBlKNm3AXLrD2eCCRF5JQRpfpE7eB3Cs/5oA0eHkEDEtNgWKbhcf6Yzky
   2n4qHGUZwpPyJRyeI73k9LoRoMh8YHon55skCFBlFTVmLpf13DhwnQvNq
   WDuaBo4AlaQhfxm1AYLx2JLdiEEJxhVf3NIOUDbwNItvQ7rosdoLdOj2I
   A==;
X-CSE-ConnectionGUID: 4GBslq9NQS2FZYkMPxqdig==
X-CSE-MsgGUID: n7wFLXFjT1m5NrDkuP/Lpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29725731"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="29725731"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 01:37:34 -0700
X-CSE-ConnectionGUID: Qjo5PyStR266Ph2wwaGIpw==
X-CSE-MsgGUID: 7zF1nQnhRma1ReaX0LHf/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="81176046"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2024 01:37:34 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 01:37:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 01:37:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 01:37:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KB1kjEfHXFwfsMw59PZeEDaohY3Sk8+vgY4yfX0lsFN0/IQHw7nXsHpaqNOV7XDuOCDtqOBbwxAox55O2PweGys5JITclvNDcp5Jl1YR1fvlnsyOPaK8QQhE2t3IDBzepk8ao+bgYXuk0Z8yTL2TKzhCBxpHyz2/drnZ+2njWMvXgmv0PytKSZ8PcJXt18kG9UGjpL4xTqQ9hnP2+tzGp44L0TRsiCVLwSvCf0OC8QNzfGkuyRY/oRcyXdd3Yn4+ZsOygZ/KipL05u89rxqFMdTjX7k4ZxQhq3gvXbHh498wLxO9wNBvGgivfrd9AhQM35MoFdaeCBwEOmzI8at/bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyB0cPURaRKch5n3iD+Eq03ZHdi7rMkA6jPowodi+v8=;
 b=XIwDPrsszjSQFcIos6+bxMDeD0X3Qi7e8NpKnCoJemBuG91Z5oZ3awGsbU/YXrTB9U9k6ulEIJcYF0wzd8yjhRbNQFGx8k1sh+TXV82ah6htrrjwtb7KA7AHo66tqTM+8Qla4YbqU9RiDX50IxWv/lpjVK8Jp2YbK2zgEwtVMRY40Lb/YJ2YEuitJqPcV9UUC50WXU9BcxaohGVuyvdBQjEr+bnF/kym4Mq34MNFGvPvhX7d2uplzarStxA/0RHlXgz5/gd6ADOAf3WbfdDJDQL+znaAN7yzg3ztqvaI/InVzseFNkH2niIdhoaLjlpkzlEmHfVqNQoCSaJnresLlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM6PR11MB4690.namprd11.prod.outlook.com (2603:10b6:5:2ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 08:37:31 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 08:37:31 +0000
Date: Fri, 25 Oct 2024 16:37:22 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [peterz-queue:perf/pmu-unregister] [perf] 24b8359383:
 WARNING:possible_circular_locking_dependency_detected
Message-ID: <202410251647.21bf487b-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM6PR11MB4690:EE_
X-MS-Office365-Filtering-Correlation-Id: eb2476dc-b996-4e73-9b3d-08dcf4d043e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/3oe+/tye1lWLyUqsAUB+NUUjk79v9kKy27Haqo6545mqzj2Tal9xKZG2+ao?=
 =?us-ascii?Q?LleEfvlfB6lOvkJHZJnCrIY2JkBwvRfe4/2EeqB4Kj4aNS4QY6tVsf3sAaYL?=
 =?us-ascii?Q?unKilYkgkZTYMNuJOQnE3FIHCauRpEGsy3fdJqUbg9zF2pZr2ltbUboxLmIO?=
 =?us-ascii?Q?0U98jKN3m/UYStNtYGak3hUSTUvzHXgbRk161zFlvyKaofzT2YQo/BICEWKo?=
 =?us-ascii?Q?NufkKAVil4rzoq6ezecqnPZNaImgKs0bvJkkk45cB/bmzWzks4Nf9rTAc200?=
 =?us-ascii?Q?BAbNusavapS+TXAdeqWrcv8NDwfcmCxWM9a4JLkOoI2GA+t1ryskF1PnUDTx?=
 =?us-ascii?Q?Emc8TcinNM8FZkssNYvKiwIk2Uq6d7Q6kCVH3pq/g+lp0r6foaO+5uDOYGwB?=
 =?us-ascii?Q?H4G5bL6qrlir4ND/GMdBcaFzDIuaQU8JkwG1E+jxToVN84aZSRckcUQtAvfC?=
 =?us-ascii?Q?wszfiFSNEm/kIWr9Z8SInJENoSR94VT3QNZRGtrRMHeVt/0vXezNpIyRyKsz?=
 =?us-ascii?Q?irwy+TyZrCOZyL96eXPVwGaj1uCfQAsZtaXzBmhiiwW+54UDavQs09xVzD6K?=
 =?us-ascii?Q?RIIo/KA1MzyatW0x8q+tGNM1juj1D7o4RG6hZl4JR0BK4E2XptGKj1eb8GGv?=
 =?us-ascii?Q?EqU6BNz5OXrtI6hB8VSnsw00Q+RfzVU/QNxLUCHDpULaKIzT5/zXiB0ZOCfF?=
 =?us-ascii?Q?qYO1ayCzRjpV7+6onKi/sJWGOLYcy+psn5q4mSYPU1XNHQvPqj0lQ55rSKZO?=
 =?us-ascii?Q?27k7n8FFfxKn2t/pKmzP71doCVxGXER/e6jUQ3qlYtw3AQuFmschZDWRk3A6?=
 =?us-ascii?Q?zxnLfjARqmZMpO/+WBaLHp43kTFlpwYTy5dyWO3NVmtgFkqw9LNbfGK3PY3s?=
 =?us-ascii?Q?cDeRugvRN5la+qn2x45mgUtZO2Ct3NeIb2Iz3IMNgPqLgUg4fSycEVp8QJ5M?=
 =?us-ascii?Q?XhvrwaJdZ0RscXOTUHn6QuLae9ZepxmvKOqMjTTd+camyb4Xi/o1tPUrdhSj?=
 =?us-ascii?Q?eDwEc6CKpyivzscGhbzgwauEq/F3DNXFrpY0MfPnXaOB+Zc5UA9vLoG+mWBv?=
 =?us-ascii?Q?URtNQJ7HM3fp6FzInnKVXMqDj7eFaX66Vrd9sixXFUp4yWMHWwYsegxfCybj?=
 =?us-ascii?Q?fCzlTkCCfvRiUENfaxjYz4LGioFOKj9Xa6IEqfqBmDP0BSB8cnGuapEm7fah?=
 =?us-ascii?Q?tZWfG1ru9TF9WfsSGIWoX6uNlHtioCOwpu2lRv5YY+ctaI9JP8Fd6ki7ePUo?=
 =?us-ascii?Q?mpR/T8vzu/3WWuu7ti3P++zePP7LrJ/MOMX++uDByg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ib597IkoVGca5TPTC3eVVxtVbqUBJkBRpqwCo5gQ9OM51lVnkahUAvriZIEl?=
 =?us-ascii?Q?zDpUdiuKK3RdcA2MIsihoBmZnwmy6f7DgCPVgl3Mz9e2NEO2l4ynOV46fiTp?=
 =?us-ascii?Q?BvPhi8Vi/htPa/cHr2PlRyaTV6sO7OKot10Gpo+v8SjbQkjzr79asH4WatJW?=
 =?us-ascii?Q?3EdZN2I5IVO2vstf7yPIS/8OaT/elmpTk3FtW/U4JuqMrQbqHzI9PHUf4yX8?=
 =?us-ascii?Q?BZC/tXEty0CYXKB3/udfSWLYVn6KbjrObf8Y4jQrJwy4r7H/AcZp6TI7D38P?=
 =?us-ascii?Q?1ZKhiCaqdAmkUCG51Bq6L6ArVrYjaAll9d/jC050J3R9jPxbYFeDfkMtA5pm?=
 =?us-ascii?Q?Y1utssMc0tfmoqH7+ycoRoan6EYsHN8Bwvua0/gO1ALRyUD0T/cWuf6PWx4X?=
 =?us-ascii?Q?kccpvXe14xvKL2aZbZZ96JZcjNuP7cyC9MUUdgUWrATRqnmj4Zu5QuaXD7Z3?=
 =?us-ascii?Q?58CSCfURzm/F0jgTVliQ6mVZaXOLXErs3Ew72oOADXvufA182f6xkGV4NGiL?=
 =?us-ascii?Q?c4vfgNleOufvq+/DTUuf6HppIrSP6lvSCpyRFYRfwx5tIHJ8f5hSoTAucQbU?=
 =?us-ascii?Q?Tty8uiRy9eqJNIvUL4tpOqYJWmev4ivfzCYTQJrV+yMUF29YYv9l2/D4Fmyy?=
 =?us-ascii?Q?CZPv92aIID0BPBtunyRaJdPom2GjEOZgRKJXGTABN3WJZuE3He1vitvos7s/?=
 =?us-ascii?Q?wBV3kVCgHcEkvNKhf7671r1BvALb16TqkyYAY2Ye9rdmNFucPDbK7qvhVMQx?=
 =?us-ascii?Q?ZutJyk4ZVt6X8EMPYnOic0rzB3uSOLjhe6VUgrmZEeNTOtDxdPPrB2UfTJ22?=
 =?us-ascii?Q?Cq0kQ1tIrBkKj6VqB2PGUVThU6ttHlqmz2CA+FaNXufhcIy9MzVXBka8vg0+?=
 =?us-ascii?Q?DPt4tb0kyeJwOVj8qUBwNbQhR1crY7LdhA0P6xaQ1cPp4AapFmR6VZD952Wj?=
 =?us-ascii?Q?WUtidlzOFGGhY4FfLqTuDm9Kb55qmd42F2/OL3SSzcVIhsBYkxERWekNhdlM?=
 =?us-ascii?Q?/1GP1KENCGubxsp1afEk0evifU40vtk1phzgDWacZ1jT+mGYOP1fhk7ocUk2?=
 =?us-ascii?Q?z95s+OLwbXjpLqSnDbx3JGCJSMkx1b8jqetNjGv7iwLiuypv2DcicxskZlYJ?=
 =?us-ascii?Q?7dBO48wrq9H14G5W80Dk3Tp8Fp/7a2vyI4oPHfly5VTcDYwAGELAePIgVreB?=
 =?us-ascii?Q?K5HmQ6zL40DucEszfp0mPoA2dvcm1UE9JvjhjBCPSku4Y8/fu9x2davEo5pt?=
 =?us-ascii?Q?eoc++R3w0GZzVux8+n0+gHctG8W+tFZl/vMO3VEuEvCXPmMmSsUZrE0gvNUZ?=
 =?us-ascii?Q?z87JWuwwBcQHlw2djcNCHWh8oWxlF3Bwuc7AXYayMtsf2cbrMv++jAPi0vRY?=
 =?us-ascii?Q?q4Ki2xul7WYSIh8yEFc7eWZW/TE/QSa0SfBlyVmkiOtlCWX8UT0lXiRw3sJV?=
 =?us-ascii?Q?1g4RQ/m8qxNTxa6T+DfnNRjR02vgwtambLg0uieK9yrkpP6NUjTEmPIuDajX?=
 =?us-ascii?Q?4PQP9ZXVdRDy+cYzZC4Qsk8+3YmjgkaouSj9i08qORB9s9D4LZ7TcwPf6vwQ?=
 =?us-ascii?Q?zjHbsjedT0Zb7v2xZDjcoRjR8tf2gj8Kfw+C/Fzg+pPHimvTKzYaVWHw30DX?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2476dc-b996-4e73-9b3d-08dcf4d043e7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 08:37:31.2410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1EXLvVmXjOmmzfBzR2xqRsKI7VINZOAmN6htIgjx9nwi7C1ngCZQcU3FFwYuDIbBb2OR5jGFck63i2/mro3Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4690
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:possible_circular_locking_dependency_detected" on:

commit: 24b8359383aee40fcd58b700a9269e61afa864aa ("perf: Serialize perf_mmap() vs other entry points")
https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git perf/pmu-unregister

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 600s



config: i386-randconfig-015-20241023
compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------------+------------+
|                                                                                                                                                                            | de20037e1b | 24b8359383 |
+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------------+------------+
| WARNING:possible_circular_locking_dependency_detected                                                                                                                      | 0          | 16         |
| WARNING:possible_circular_locking_dependency_detected_trinity-c1_is_trying_to_acquire_lock:at:__might_fault_but_task_is_already_holding_lock:at:perf_event_ctx_lock_nested | 0          | 1          |
| WARNING:possible_circular_locking_dependency_detected_trinity-c1_is_trying_to_acquire_lock:at:perf_event_ctx_lock_nested_but_task_is_already_holding_lock:at:vm_mmap_pgoff | 0          | 6          |
| WARNING:possible_circular_locking_dependency_detected_trinity-c3_is_trying_to_acquire_lock:at:perf_event_ctx_lock_nested_but_task_is_already_holding_lock:at:vm_mmap_pgoff | 0          | 4          |
| WARNING:possible_circular_locking_dependency_detected_trinity-c2_is_trying_to_acquire_lock:at:perf_event_ctx_lock_nested_but_task_is_already_holding_lock:at:vm_mmap_pgoff | 0          | 3          |
| WARNING:possible_circular_locking_dependency_detected_trinity-c0_is_trying_to_acquire_lock:at:perf_event_ctx_lock_nested_but_task_is_already_holding_lock:at:vm_mmap_pgoff | 0          | 1          |
| WARNING:possible_circular_locking_dependency_detected_trinity-c0_is_trying_to_acquire_lock:at:__might_fault_but_task_is_already_holding_lock:at:perf_event_ctx_lock_nested | 0          | 1          |
+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410251647.21bf487b-lkp@intel.com


[   90.688729][  T589] WARNING: possible circular locking dependency detected
[   90.689307][  T589] 6.12.0-rc2-00016-g24b8359383ae #1 Tainted: G                T
[   90.689852][  T589] ------------------------------------------------------
[   90.690348][  T589] trinity-c2/589 is trying to acquire lock:
[ 90.690768][ T589] ee61f668 (&ctx->mutex){+.+.}-{3:3}, at: perf_event_ctx_lock_nested (kernel/events/core.c:1318) 
[   90.691425][  T589]
[   90.691425][  T589] but task is already holding lock:
[ 90.691944][ T589] ed2041d4 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff (arch/x86/include/asm/jump_label.h:41 include/linux/jump_label.h:207 include/linux/mmap_lock.h:35 include/linux/mmap_lock.h:123 mm/util.c:586) 
[   90.692525][  T589]
[   90.692525][  T589] which lock already depends on the new lock.
[   90.692525][  T589]
[   90.693271][  T589]
[   90.693271][  T589] the existing dependency chain (in reverse order) is:
[   90.693907][  T589]
[   90.693907][  T589] -> #1 (&mm->mmap_lock){++++}-{3:3}:
[ 90.694445][ T589] __might_fault (mm/memory.c:6700) 
[ 90.694797][ T589] _copy_to_user (include/linux/uaccess.h:184 lib/usercopy.c:26) 
[ 90.695152][ T589] perf_read (kernel/events/core.c:5773) 
[ 90.695516][ T589] vfs_read (fs/read_write.c:567) 
[ 90.695858][ T589] ksys_read (fs/read_write.c:712) 
[ 90.696201][ T589] __ia32_sys_read (fs/read_write.c:720) 
[ 90.696593][ T589] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-015-20241023/./arch/x86/include/generated/asm/syscalls_32.h:?) 
[ 90.696969][ T589] do_int80_syscall_32 (arch/x86/entry/common.c:?) 
[ 90.697371][ T589] restore_all_switch_stack (arch/x86/entry/entry_32.S:944) 
[   90.697787][  T589]
[   90.697787][  T589] -> #0 (&ctx->mutex){+.+.}-{3:3}:
[ 90.698312][ T589] __lock_acquire (kernel/locking/lockdep.c:?) 
[ 90.698693][ T589] lock_acquire (kernel/locking/lockdep.c:5825) 
[ 90.699044][ T589] __mutex_lock_common (kernel/locking/mutex.c:608) 
[ 90.699444][ T589] mutex_lock_nested (kernel/locking/mutex.c:752 kernel/locking/mutex.c:804) 
[ 90.699821][ T589] perf_event_ctx_lock_nested (kernel/events/core.c:1318) 
[ 90.700261][ T589] perf_mmap (kernel/events/core.c:? kernel/events/core.c:6812) 
[ 90.700597][ T589] mmap_region (mm/mmap.c:1441) 
[ 90.700965][ T589] do_mmap (mm/mmap.c:496) 
[ 90.701296][ T589] vm_mmap_pgoff (mm/util.c:588) 
[ 90.701652][ T589] ksys_mmap_pgoff (mm/mmap.c:542) 
[ 90.702033][ T589] __ia32_sys_mmap_pgoff (mm/mmap.c:553 mm/mmap.c:549 mm/mmap.c:549) 
[ 90.702432][ T589] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-015-20241023/./arch/x86/include/generated/asm/syscalls_32.h:?) 
[ 90.702802][ T589] do_int80_syscall_32 (arch/x86/entry/common.c:?) 
[ 90.703196][ T589] restore_all_switch_stack (arch/x86/entry/entry_32.S:944) 
[   90.703638][  T589]
[   90.703638][  T589] other info that might help us debug this:
[   90.703638][  T589]
[   90.704379][  T589]  Possible unsafe locking scenario:
[   90.704379][  T589]
[   90.704933][  T589]        CPU0                    CPU1
[   90.705325][  T589]        ----                    ----
[   90.705716][  T589]   lock(&mm->mmap_lock);
[   90.706051][  T589]                                lock(&ctx->mutex);
[   90.706514][  T589]                                lock(&mm->mmap_lock);
[   90.706994][  T589]   lock(&ctx->mutex);
[   90.707283][  T589]
[   90.707283][  T589]  *** DEADLOCK ***
[   90.707283][  T589]
[   90.707850][  T589] 1 lock held by trinity-c2/589:
[ 90.708198][ T589] #0: ed2041d4 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff (arch/x86/include/asm/jump_label.h:41 include/linux/jump_label.h:207 include/linux/mmap_lock.h:35 include/linux/mmap_lock.h:123 mm/util.c:586) 
[   90.708811][  T589]
[   90.708811][  T589] stack backtrace:
[   90.709244][  T589] CPU: 0 UID: 65534 PID: 589 Comm: trinity-c2 Tainted: G                T  6.12.0-rc2-00016-g24b8359383ae #1 8345be9a99138da25a7e4490e34d40eb8aa23b00
[   90.710301][  T589] Tainted: [T]=RANDSTRUCT
[   90.710606][  T589] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   90.711338][  T589] Call Trace:
[ 90.711577][ T589] dump_stack_lvl (lib/dump_stack.c:122) 
[ 90.711906][ T589] dump_stack (lib/dump_stack.c:129) 
[ 90.712197][ T589] print_circular_bug (kernel/locking/lockdep.c:2076) 
[ 90.712561][ T589] check_noncircular (kernel/locking/lockdep.c:2206) 
[ 90.712930][ T589] __lock_acquire (kernel/locking/lockdep.c:?) 
[ 90.713277][ T589] ? __lock_acquire (kernel/locking/lockdep.c:4646) 
[ 90.713632][ T589] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91) 
[ 90.713997][ T589] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:267) 
[ 90.714360][ T589] ? local_clock_noinstr (kernel/sched/clock.c:301) 
[ 90.714729][ T589] ? local_clock_noinstr (kernel/sched/clock.c:301) 
[ 90.715098][ T589] ? __lock_acquire (kernel/locking/lockdep.c:4646) 
[ 90.715457][ T589] lock_acquire (kernel/locking/lockdep.c:5825) 
[ 90.715775][ T589] ? perf_event_ctx_lock_nested (kernel/events/core.c:1318) 
[ 90.716196][ T589] ? __mutex_lock_common (kernel/locking/mutex.c:607) 
[ 90.716571][ T589] ? __mutex_lock_common (kernel/locking/mutex.c:607) 
[ 90.716963][ T589] __mutex_lock_common (kernel/locking/mutex.c:608) 
[ 90.717328][ T589] ? perf_event_ctx_lock_nested (kernel/events/core.c:1318) 
[ 90.717747][ T589] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 90.718136][ T589] mutex_lock_nested (kernel/locking/mutex.c:752 kernel/locking/mutex.c:804) 
[ 90.718477][ T589] ? perf_event_ctx_lock_nested (kernel/events/core.c:1318) 
[ 90.718898][ T589] perf_event_ctx_lock_nested (kernel/events/core.c:1318) 
[ 90.719302][ T589] perf_mmap (kernel/events/core.c:? kernel/events/core.c:6812) 
[ 90.719599][ T589] ? kmem_cache_alloc_noprof (mm/slub.c:4141) 
[ 90.719988][ T589] ? kmem_cache_alloc_noprof (include/trace/events/kmem.h:12) 
[ 90.720379][ T589] mmap_region (mm/mmap.c:1441) 
[ 90.720728][ T589] do_mmap (mm/mmap.c:496) 
[ 90.721046][ T589] vm_mmap_pgoff (mm/util.c:588) 
[ 90.721387][ T589] ksys_mmap_pgoff (mm/mmap.c:542) 
[ 90.721760][ T589] __ia32_sys_mmap_pgoff (mm/mmap.c:553 mm/mmap.c:549 mm/mmap.c:549) 
[ 90.722126][ T589] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-015-20241023/./arch/x86/include/generated/asm/syscalls_32.h:?) 
[ 90.722462][ T589] do_int80_syscall_32 (arch/x86/entry/common.c:?) 
[ 90.722826][ T589] ? exc_page_fault (arch/x86/mm/fault.c:1543) 
[ 90.723163][ T589] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[   90.723502][  T589] EIP: 0xa7fc5092
[ 90.723762][ T589] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241025/202410251647.21bf487b-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

