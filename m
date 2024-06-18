Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60761327E5;
	Tue, 18 Jun 2024 07:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718697249; cv=fail; b=eFeSAPugd4kcObRLq1u/Ap5bLq/bRaa6PtyeEcdv+yYTPjwTHLKN/xf6eZxBtfnD5+0thiWWSs5x+tg93PhViABKkqTYasjLUrLLGX+UJBtxTB1xCsfWQLdgobMZRluw+GWITIM0HkoyIyDnzu/eiDe/yxMYBTqc1xSkdE5x/CA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718697249; c=relaxed/simple;
	bh=jm2zLqtmgeoODUQdXarmzP3nkDlwRRqEMDsb8zWKMsQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=L/UUS4pkXWxC0GQ91GBDBYUQyYcOeXBRhes2YwObt/hniC8kylBar4l9eJkx/dknpZw51bbiPAvTkxqzgt/XN+ZX8iqyGt984ioDiqzVbF+ONsFpiW9HNBBU9bVHV92uX7L4Scc+AeqBxEjWnYgir9TdyCyGtvPSB7pMk0jPdlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MhVA0ikG; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MhVA0ikG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718697248; x=1750233248;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jm2zLqtmgeoODUQdXarmzP3nkDlwRRqEMDsb8zWKMsQ=;
  b=MhVA0ikG9xuqgtAsMC6pI7uv17WSqJLG3aGOWfJQqa0qvV3zVB/fxKX3
   wQLSzsGAuVy8xAk1nZsQsmoI97N5nrQNEpMgWrdmQOICOBTgxRO/+Zz8g
   FWhBTIMJvz7l8qqAI2RAzpNZjtBnS6W//V/8prbtsjDJfqfjv1X4aR1tE
   UFGncR+Xy+3F0vYMeCtp+mGSs8symAsRnYx+Pe69fVTta+RvJ3dQru6Fo
   kNR0C1/Oen236C2pVp0mXw1dYZS/7QFRV+AUyxGPeteY/A9ljakt5Jv2d
   CLWdFzJyCk17beMtV0GJzl48ienfwrtj2fesDXU3lBFpF4xlU9HWtHfeU
   w==;
X-CSE-ConnectionGUID: dMRsWv9DSsaXYrEDWlCKNw==
X-CSE-MsgGUID: fPcCIAnITQKWhfqFuS102w==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="26238372"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="26238372"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 00:54:07 -0700
X-CSE-ConnectionGUID: 849jyzQtRmC+8PZnZIPx5Q==
X-CSE-MsgGUID: gG5tO6YCSSuVC56UKmhqhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41329030"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jun 2024 00:54:07 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 00:54:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 18 Jun 2024 00:54:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Jun 2024 00:54:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0NLLuOt9o4ZwVtlgALxtfclJqixF5ignXPE5RdF5iewj6OGzcKqRRC/igtj8OJAsTnYHc5dUrsddDQozfLuaREQnS4haCC+TQlat66ctbvVkIAzc9rtr5qU/DEzOI2mi6QJE0UWDJEgRTpB6M2po+3sLwywtmupal1qMTbldILGVVZUFEdQLRKasNKNbNGDcgENoWqwzbXhkithehvoKGq2DbFghwrEd/s5l97rhsvVtL8PuY/Tkc8Wi5pPN6ntsaz35+1LERzor0Zj6PfpPiWJ2ikiMkA8yCvbtdXLCWHFERXxBUz0JtLr8OUQRlLXFIIheC0rdgJflU8v8/mmsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mU0p7d1uKM6R7QW7Fpg/V9+V98tdcgelNPG/FqMCJgk=;
 b=jSG8KddMFJPb9Bp6hRXehlx6qS8gIfYHhMhgL8EWtm2/jaGNotmv+An1VL9HEpS7ZSty5yF+Lk4tVVGK+OV5Tcu53qijPcDDs/R/TlrccQVrf1b5xsn9ZyKJ8udInFejOTm/7zc0bKDNLvb10iibKnojonABxEC7bTw6y7agczpWJnGqdjRo6+1usfLH1JIYz0p+EjwssWYbdHMzqMhcthcHQelVEsA0ihZW0vzckoXuFMv2IKUsRB7vgrg+VjP9LUjzNg1cw33+yMjbjhXfQlspjzojNC82n1LmZ9xy/jntZgL0sD6Xn0mBQzJle4xGpGojE7A7aT36TzlxYOiyyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB8467.namprd11.prod.outlook.com (2603:10b6:610:1bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 07:54:01 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 07:54:01 +0000
Date: Tue, 18 Jun 2024 15:53:53 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Thomas Richter <tmricht@linux.ibm.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Namhyung Kim <namhyung@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [perf test]  658a8805cb:
 perf-sanity-tests.perf_annotate_basic_tests.fail
Message-ID: <202406181535.eacba363-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: 919cda97-ef25-4f89-cdae-08dc8f6bd14a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8rd/D5h2RDajGxOflLRV8AR9M1rbT89uzwkbhXeDyaMj7C1StVO1XLVAsO35?=
 =?us-ascii?Q?m7dG7DTVSQHgEFtFKQ5J4laX5ATm4Ps3c8uR8hk4i+PZd6PjwbMsUq/bdA0X?=
 =?us-ascii?Q?avGxYsR4H5dlrPAsRPMXh0FkuFGNFRLHYR/lQUtvvVui4MWV2mLCwRV46Pbg?=
 =?us-ascii?Q?hzeAjY1J5uWWclISAU325//knJ0MUzSgr99ZBsxAktQ3B77o7mdxxGsdUkJL?=
 =?us-ascii?Q?xNuaC/Tv3HSwJPOkmgwrMvy+plyA3VN9fIT69vR92KzrzNu84yKgk5+cUF5u?=
 =?us-ascii?Q?hq4NQOoc60y4HZgr7aFaFFBkuWdgwnwybchScUNsSqkQDFGiFOBgRqLN7uRp?=
 =?us-ascii?Q?uuaqIBKeI6kPAKoig4lkZmqlWIoao8+DRlIDflP5UzC/OH0GDW5KC0U9rPJi?=
 =?us-ascii?Q?cxOYFfJMJ6OEHG/dm5Usowz2kLKsiVv+hxur0+KBHBie+KLev3UocKmhBL2p?=
 =?us-ascii?Q?njKdRHeWIg1XQg3H//V5vAySq4+9SJmHJTB/vfikp+5qQrL5ISliATJfCawB?=
 =?us-ascii?Q?2NV2ipVGoFnq1Hl6OebCiBo8wnCju4bewBalhe2JZJWrXfumyMyEmL4b4d9i?=
 =?us-ascii?Q?aaE6K+ub/GRPfLJZFEYjhzHM0heST8JoBIhzsk2a+6X3Tjc0j+BYI8XxHLp7?=
 =?us-ascii?Q?FIJAXVVT9vdNWCDOoF4GiLfW8DOl1YqcCikDRjbLmdbE1Mpj4K1gGNtsDWps?=
 =?us-ascii?Q?kEpwcBkJsRUFdiZzaU8aJOWZCQZaRTU2zsee5RHF09y7xBSEh/XfWCq5mGxA?=
 =?us-ascii?Q?EksWelc+cKhFAGVdzJyFdIgvprOfopxmGOJI7dxXjlMiFOGgG9TAzcQ0ejTs?=
 =?us-ascii?Q?hjC0bnsREWCR7RVo0lgjCg/RSgwlkMgdKCDEFilBjN8IMgg3Hzp3Giznejhr?=
 =?us-ascii?Q?mfeZsoYl+XVWP/KhplX0/ZQrxX1VuXgzhPlYNrhoTAEo/yZb+VEWEf3vxy+e?=
 =?us-ascii?Q?T3KHVeP6v1zMPZfPsbvSu1wbdxF7G7PKDwPMJXZjWW0FjW9RiVHcD4VGcjdD?=
 =?us-ascii?Q?GLcI9Fwzn3PGrYiGKuG/vpAyUu2S4LA62C8drntqjev3BNloEImJdmk3j7wz?=
 =?us-ascii?Q?S3MbT1MmcpsiEG4lk5pbD+Ex/7+H85zQH2iOX6KVOFM67NteIFD5hjcMbOcH?=
 =?us-ascii?Q?ORNLULbUxoN4GtrbylwduK63HSGq7CS8DMCsQc3DV8L94Eoax9oSzPBLWQjd?=
 =?us-ascii?Q?YCefeIjxJUjyMQr5jL4uGUXutERRztdRRUZOyqY3qn39k/SlRk7XRK6F+NEQ?=
 =?us-ascii?Q?4dkGHW+rcUVJ7elr8nF7qljOB8Dy0ChlBXvu92ORaA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MDkBqlFRwie39EQH398GyH536EBtEkvLYcHVlWVjFuZy67F6SQ5y/R/WEwyf?=
 =?us-ascii?Q?dchDot73EnvOLuYyCoPjImmcbkfNLJdPaLb0nn0Dz4neQWq9p42A8CcdkXL+?=
 =?us-ascii?Q?mTMNP7bhuQnExZiSZY/sO5T+i93fRrRE68240aCUrkc+9qyndw6Qh3dM8X27?=
 =?us-ascii?Q?CbiMfHH93PtNJR5rIRAfUE6XtzYkpyxT0FlCg2dzxoGWS4VPHUPFl+7maOfs?=
 =?us-ascii?Q?ei6wkKvRMhLWqV1CB93e6YXF6N0Fy1bkhr55NXvQzJ/Mw/Iey8xJj3QCoeLi?=
 =?us-ascii?Q?HHdBftDmucSVNmV7FPef1C/oeJXiQ4USZ3PDtX7qbaT4sMk8IUvjT/TLyBMC?=
 =?us-ascii?Q?v+nhrWftmu+OYt7hbgFbU7gmFytFwc6kHgte6o5yeKHGSg3iiAwG81pJQv2E?=
 =?us-ascii?Q?ndzhWwyNdEUoFbi0npqn9NxNAIL8VrQwe4wxHshVrKmrhWPmw8IhwjD9j67j?=
 =?us-ascii?Q?/UplzwTgjGhx736KMueYoRAibGPezp2dCnhBq1CWKFH0Cdrlg5tdOwx+OMl+?=
 =?us-ascii?Q?woZwdSNTIqLFFOUCwkQiBXw6VDpKCbMMLyCzDsMREf5A95zp+Z9QxbZFgzEH?=
 =?us-ascii?Q?zWvy5l/C0jnlXXV8jDRbunPNS0NeQiA10lqj+tdi2jlVVIkvDVa9jGnthP5n?=
 =?us-ascii?Q?JIoO8dXgwp87HO6+Hn6AUtAYTpI7K9+Yb+wLJ3TNO3qBaAQ2bjvgWWj3Ydhs?=
 =?us-ascii?Q?KyY8zTunZ7FMvsqNM88JCCuPzK5qDsRhMUvIQP8V/003amFPKCcRRMJsHc87?=
 =?us-ascii?Q?lZCDAeE5QhSGNAXXyffC+E45A5dTjwPdhVkFiDgluUshz8aUHzuMXP/p5A4I?=
 =?us-ascii?Q?gRtTydBMo8HWvM808bNe1i2odHbfStiQPQJP7ewhKPJIzLCbDVuD3ywKOLhy?=
 =?us-ascii?Q?Vt7T/QMfGmUAVavgNuYvTVjGQZDPrctIHAcUD4TDnbYA0BNRukHZStmj/dm3?=
 =?us-ascii?Q?gOSavrBLTwJUK+Np1YzhKsIuxYcEJeS9JwVezx3i0adSyLpWnkUqBy2s3ME7?=
 =?us-ascii?Q?QANxr26rdUhduBk+W7ku4yonOgh3R/xTThHoi1MScln/iOuBjSVsx3wMaR0x?=
 =?us-ascii?Q?mW85JWI4UZIyjBT2QwZpk1ebe6vI+AubUnd46O4A+ADHDrSkcdcqDkYMs/VS?=
 =?us-ascii?Q?zgfMy3/2X2ITGEOlG1q+/UufVPN2fI4Kh3Tbbyrr6xOHk4Bz1waUjehcK1QE?=
 =?us-ascii?Q?OkjQXtHcDOK5l4/75A1xhbAKTVv43yAj6s+IfTGSFGK7NSaoZzvLKPQvn8th?=
 =?us-ascii?Q?R7kRb2/vNOedj8rpF3kpZOD1K2eEM3xph5yt2HeOhnYlFRB4yLIslUn4q/Tt?=
 =?us-ascii?Q?Fblbrv5Uy9FaBepy8kiqTllIgf03QYY73lfSc0AruEH7A6Q50RZqtugBrTBq?=
 =?us-ascii?Q?SbzTanZyY9hO5Dt2I6omModW1nmQo1nxghGjYETYZNiWN5tge5GnoCKhBGoU?=
 =?us-ascii?Q?zNgVEAyVtv8ztwSh815MFV7vRM1iA55hUPAbOdhRnlCYdqCymc1zlWN2ZPts?=
 =?us-ascii?Q?9TL/pXm6wUkLLlJR7u+ij5iibpBDhqZsFHxhMUWSDIA7lRfd2uxiLJ3hfTEx?=
 =?us-ascii?Q?0vjBYlKf3sh46oSFNQHV30fXSC/PEs5VHVvNFZmLuzs3im5Xq5riCPeNXV2Z?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 919cda97-ef25-4f89-cdae-08dc8f6bd14a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 07:54:01.6241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z7qYRzR2S3Sg1yRm/0O8uLuIUp+WdHqxTEnSlnLvvGBSu3151JUlzuac8r/b9RhpycJbHRAfg1T38EVpf89OIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8467
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "perf-sanity-tests.perf_annotate_basic_tests.fail" on:

commit: 658a8805cb604260ae9f35ae5e50012e3d1ed5e3 ("perf test: Speed up test case 70 annotate basic tests")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 6906a84c482f098d31486df8dc98cead21cce2d0]

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: gcc



compiler: gcc-13
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


we didn't observed the issue on parent.

f5803651b4a4b67d 658a8805cb604260ae9f35ae5e5
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6          100%           6:6     perf-sanity-tests.perf_annotate_basic_tests.fail



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406181535.eacba363-oliver.sang@intel.com


2024-06-14 20:09:34 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-658a8805cb604260ae9f35ae5e50012e3d1ed5e3/tools/perf/perf test 76
 76: perf annotate basic tests                                       : FAILED!
2024-06-14 20:12:46 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-658a8805cb604260ae9f35ae5e50012e3d1ed5e3/tools/perf/perf test 77
 77: Add 'perf probe's, list and remove them                         : Ok
2024-06-14 20:12:46 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-658a8805cb604260ae9f35ae5e50012e3d1ed5e3/tools/perf/perf test 78
 78: build id cache operations                                       : Ok



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240618/202406181535.eacba363-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

