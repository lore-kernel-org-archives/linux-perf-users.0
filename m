Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D17D25D526;
	Tue, 15 Apr 2025 04:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744692415; cv=fail; b=gVIKRAh90nrBu6w7Jjkei2tQvLki0iMXYaYn41ZD9Hxi20zGrxp2CNbl/C7jXU9X7Kvlw4JM5Sucgt06mr8TeTKXuECyJodJDYeSDRfPBwO3u56laqkxyv6NhopiyB8Oc6nmgnxVX7m/i1/hZMPwLW5DCKe7k3hYEW5k/CxTcio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744692415; c=relaxed/simple;
	bh=/mRPJar/51r5q2p4hPr5d7PMEWbduY+28jasrTYMnJ8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MqO8ceIv3DOLk8XRIrxz3rceOT/+UpchisC9oR6FD2YyIZU13PE4YHukD2YQZCjyVQptH9RnIBUuaZhkwJpv8jm9c81tBNLTCdKJALMAUTzOA0tvDIqxeCWVokkCK2L/6nbseCNKMdWj5dV3HxaXFpDi/3RyiO2dC2WjlEV1OLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VDSt5eEk; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VDSt5eEk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744692413; x=1776228413;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/mRPJar/51r5q2p4hPr5d7PMEWbduY+28jasrTYMnJ8=;
  b=VDSt5eEkzQl6Wgl0H+Qmvouf82GzOq1E6o3fuN8W/5tz9kmE/b5I7Bdj
   xaj3Hp3i1tKw63t8hb+nS2CQJ/Trtuq4+0CaN5obGl1Vt5wj2tDSBx+Lv
   UNvZzdnf34yaFo7ycPy8Ct8HfPNqD/NMyY7jfgcYv8oaQXmK8+iDqT7BH
   NPodTAZV6R2gTvd4o9TnfQaYUolJ9edo4CNKRx3wCBx1GWZaiekUiVcX3
   nqupUhIR/n5T0T/KqSwaNhdclT+3Fn7IRZM2RX/qOAYBQevRqBBOEYiLs
   aR5BX5VeXxq+J3NyoeARYPYTHEDL940tlRbo7BaiYePJVPp84R0pXLP9A
   A==;
X-CSE-ConnectionGUID: m18AJt24SZyFxfbBSsZwAA==
X-CSE-MsgGUID: sjc7Nq/tQMSTrXDQF3qvJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="63583376"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="63583376"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 21:46:52 -0700
X-CSE-ConnectionGUID: 3//+2dJ4Tv+hvk/5Ipek8Q==
X-CSE-MsgGUID: dPp+BmFARwCVW+yDsG8kbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="167179827"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 21:46:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 14 Apr 2025 21:46:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 14 Apr 2025 21:46:51 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 14 Apr 2025 21:46:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0ZWAvS/xMShHxCXMPoEsJXhRs+Vi6a/1/bIMFgW/cE7P7LvBzqH7K6bIW7ewGK3JPywiUOXFzz0ImKY8qjS5PBqFr18vRNPZqlCuq9rnmDuRwHH0i0dDmzy68AfmL/hb37c+9H/9+Q8WUkWw8XDrW9m4YH+nJ8oULLHqQMAqxJ2Mhf+H/9l63LRe4D6unCCa6fShBhiaahiVnfLlSMsbuhC95KvRkgoc2KqA7DQRBwPCH4nIbA4DIPsSd14ghIXPvdzP3g/2MKpLzawamMzJk83Z4/wGsm0RavpCGOhgW0tj8rlfTaUyxqrMJj4xGvaAuoW580Y9B3UsnXhWasQTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ve29cfhOmBFkouHFqK6H8sUQv4MYoK4suI7AfoIckEQ=;
 b=ElNDFAKUW5PQPTPhTshSsixmrbUlAJp2moW0/GMPkX71lzYF28yCoWTg0ovtQOPhcSXwALvOROu9tjkkXOiI99fHqvBAuvMJYKhoP2TrE8QAGlNG/vUntkJRjT9GTAivX2huTr2r0lOgoPEeOoW733Schi1xfujmeuP5KjB45kqA1LkBUaTw5cnZxUfMHhAIQsaK6r+mbBIKxCFet0s8f3ZZaHII4CmrLMIBlZH9uEdzaPtIUrL5DZpMlQqDU6a9mxde7riIr02/vsKKxpvkVswZNdFvreX6sOUO9FCKs6MzGluut6NrE16kAJBOrjSZsfY4bhlQQ5QKamQhj6fr0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS7PR11MB6079.namprd11.prod.outlook.com (2603:10b6:8:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 04:46:48 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8632.035; Tue, 15 Apr 2025
 04:46:48 +0000
Date: Tue, 15 Apr 2025 12:46:39 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
	<linux-perf-users@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	<oliver.sang@intel.com>
Subject: Re: [tip:perf/core] [perf]  da916e96e2:
 BUG:KASAN:null-ptr-deref_in_put_event
Message-ID: <Z/3krxHJLaWJTj4R@xsang-OptiPlex-9020>
References: <202504131701.941039cd-lkp@intel.com>
 <20250414190138.GB13096@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250414190138.GB13096@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS7PR11MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: 73547541-c21c-4ebc-4b2e-08dd7bd8881b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?21CaQIPiWu0nm5EBY65zTv0LHasgTxj9wpWGOXUTohX909WZuppEDGPB5p7K?=
 =?us-ascii?Q?QNcvo256MfccaBVZ6Wtq4zLK5qzDzBO956ev4RvPXpAug7+MM+CxxXQMdH4E?=
 =?us-ascii?Q?oZJierX3NOkukefxcRfYPiDc4Tzqbz8Bf1htzlg0WDoWPjt9WGMEYjYsN/4l?=
 =?us-ascii?Q?3PJpBVf/OBk8LQWRmvX1srrbpQ5y3KI45APEsL7w7dBYG4W9lpdbB4xvi804?=
 =?us-ascii?Q?xkkDv3IopHzy8tNHeJDvir8qtVc+//XhGb9O8cEJEQ1MPoAYURjLaQQmHn7Q?=
 =?us-ascii?Q?4+Rz+y8BzTF2TG2biaCNJchX6k78ASZgfDFdVrWbeb7BoWoNltw23E/GCcxr?=
 =?us-ascii?Q?jEzOGdLM5Q6tAf3NPRealcI3bwsvnH0w+NpPZTz7GAJBB5wGqV1NXpZVuuR/?=
 =?us-ascii?Q?6Iqxs7QS+koZKYZYipmLzYyOBy0zOPl3nzJ3MyAvNj0hw9T2ntax5c5m/IFO?=
 =?us-ascii?Q?vuneeo0YZJ5kinUoRT2P6Ik5N0ZBuShDx5vG6KBpdnKQ2Ht855UwphIsFun4?=
 =?us-ascii?Q?QaobbbJst4J3p4tzacPp1vub846rPgxhjlt7Ae28IozSwhWXeMQ32thqWpyL?=
 =?us-ascii?Q?Hgi1emoHBQ9kL4eFQFlylqUs7b3Lb8SMbcwMiTmCyqnlBquehDOfG4dbqNNJ?=
 =?us-ascii?Q?5/zRawXyBwkF2B7s+qWLSvjMzYkZ9t9bGB85XCdr0/wWQOn1bVCJ00/MN9kh?=
 =?us-ascii?Q?pkIXXX3GCE8+gBpbfpO670RgRsVuj86niHbtOYVa6+bAmTlkQ2MkDRm7/Qyc?=
 =?us-ascii?Q?epuNrVvIFTQM4ckb8RYOaOnD5Eeo1EDggtFnCNEUDQi79OunQfR1WZip3Qq6?=
 =?us-ascii?Q?vkiKWtwyzdTd5NOidFs+FQK6+rw/FpeYR6tbDga1cBHjuR4jELHb79aEVOD7?=
 =?us-ascii?Q?eiFnnyWqNxAqCcrqvJMi01IXSkl2KiGooV64lzHytQaQ/LXw8FQqV1qAIuCK?=
 =?us-ascii?Q?PV3YSkrgSeEryuC8DRsx46WJfykoi/u0DQCrZKaJJtmZdKNuTzo0KGDTGDj2?=
 =?us-ascii?Q?cfYCOznJ73PBPjrSxPvAZSB/95Dg3BDx0weKBapKGTR5H1BJ8XLjfzA9s6N3?=
 =?us-ascii?Q?kRCrw/RWfprxVgmFPM6SGsK5/LnVOkhqEc7H8XY/c+6NTMhFtRPv916lgAUI?=
 =?us-ascii?Q?n7PzrmP14kXxgheMU6TyUVyny0W9jdt5SdrVtZVRghUkxtwiPeI1dfXl9vHO?=
 =?us-ascii?Q?o0nQl5/YBCQIBk8QGFGywZTNMp2dAZ4TlY8tzdjJq2Xls5lss7MziNMKS73U?=
 =?us-ascii?Q?0KpnpAIqI8G31aQBN5woiSuO4h1n7L7mtdIZdjoKT18vviVvoTx2FfAEyMS0?=
 =?us-ascii?Q?z1VNGTTTsK2MJ28WjZ3eT+xICKVARYV74Br17xob1S3vTvatwRDQmm+6jV52?=
 =?us-ascii?Q?QuMscUHeVgY7DN5Vs1dqFcTjnrHywPhNltf9ZmJP/a3etdAvOCySBC/GcpUs?=
 =?us-ascii?Q?adHJDXD+Ej0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NtrnSwinbZ7W//zVFoelZwbsHulTrypSr+jmi0Uzb+GGnH9gYZ20cIWNguUn?=
 =?us-ascii?Q?JPcuI+fdEBXfbCoeexYRheKjNl2Vh1VQaz910J79e1YhRfAi2YhJrVAgj/SR?=
 =?us-ascii?Q?TJZkv5Fuh2pn0JWIiAhUcdWtmgBnQtZM6YE+xd/wl2IBu45gAZIdStMR18cZ?=
 =?us-ascii?Q?LPyXbBA1DGQ/q4AJGmkpdZGY9Ku6QmsTFjThmuyLv6pJRSVIhsFe8OXlVoHA?=
 =?us-ascii?Q?iC9rSYhDjXQ+ruMlFfOmhDAcUqbEszkW9md4V0Ej5498fZ6XWW/Utmdt9xqC?=
 =?us-ascii?Q?7l0K/PTe6llxSOXYaBLLhYfvMfwg9PqLYdz36SJenzocGUhEQmqmCbSyt5M3?=
 =?us-ascii?Q?vGFk++FV8igV/rCwbBRtStysP2DBgg+78btdDXh6n3VMR0UrT7OeV0fW6PqS?=
 =?us-ascii?Q?ZZ4nNR4YHSkuHHIvZ2QnFkiU2WWGOlju3t0/k6khkOMEGD54coXL1Sj9y3u6?=
 =?us-ascii?Q?kRRO5MjM6A0dvFtFWOuJ3SavKUwAqhWwVVL3xFn4/hGvMcKma6+pEl2MXtYW?=
 =?us-ascii?Q?56hY+dJeZULS4DDheR1wGElUgXa9/NJ+hR4VSVMvik+bjWnnJHfCELq06Bmg?=
 =?us-ascii?Q?QyIS7J3wmwkqmZQpXg2OgbWRhmH8T8Abv4JVNaGusTtMTBBM3Wao5/+B7xh9?=
 =?us-ascii?Q?iEhwc8OHyCKVs3MR6XPWZZzfdUdEWaxMbmVpDpU7vtY572vMve4WmFh0big1?=
 =?us-ascii?Q?v27OF5HVhLC1UaTiwu10hRMRBJm3K7I4U29KXqC+NeYa0E/eQ/n1erGDk5nT?=
 =?us-ascii?Q?fiV7TofW2qb7Xe0ZCezYNCzNgQmAjB7o/v+gMonSe1g3HOVPc6Xovk759Pqh?=
 =?us-ascii?Q?WvztuGBXnh6bMY0+oCKeH4DNN3JGwuN4HttUaKAIrm49ATd1RheTUwO1jXDH?=
 =?us-ascii?Q?kR947JEzB6iBqJuZlDxbgaAQfOsQtZnRWjgaA5Mm9B3qmNhX1EgThQwtJhDZ?=
 =?us-ascii?Q?i0C0Xs+rbKB3PPYCLJMCwctCQTJnJ8XfIUNiTjVjN4UBlrDc9Zs3J8oYzYXi?=
 =?us-ascii?Q?nOJq8tCsCDckhVfs7RahsfvKsy5GAdmL5TA8TcIpZFjPSnmybtxtJD7H+Qoa?=
 =?us-ascii?Q?QOsVqbSrRmiY7ETJKVWQv5pCpr4WkoORqBLj7L0tfokhIJDF0A5nSoDmP+l9?=
 =?us-ascii?Q?mlLUaYWUklq3w+bQ4UCyXtujQtHHvCqf3seYTt5P035bh7zmf+uo1vIEan/X?=
 =?us-ascii?Q?8IrYHXKvtyElCJ7ebLC5vgpazDtZk6TzT03VrY7Rkv0dmRnjCeDBzxvYBBC4?=
 =?us-ascii?Q?d5QCv1gqGetkzpPfd1jagOL54VTWdQcguZOpkNPyQGWg2YRWRDT+hS8ocmrG?=
 =?us-ascii?Q?zxkAUsYDWJmvoIW3IP29R2qRT58eiHVmSnA4TPjVyyraLYQLz/aH7W3lArX9?=
 =?us-ascii?Q?BR7O0HiD5cJeKXtBaLfnAUyZJ9SQozKEJauIo+FGANlMXh10xR/BZtc6NOH6?=
 =?us-ascii?Q?SH+O+1zcNMLuPFD3BC+nKZu5E8uhns7dKSfh4IbRU2hyuyElaV9AdTmhJ8qg?=
 =?us-ascii?Q?cKUQMDnEkdrs3SS1UxHzoxQRc5XjeGqIjFFWRey6k073vM3ToPyVgxavlY3U?=
 =?us-ascii?Q?lgh/YcncHlvS226yjVDlruTWx9fFmqEJPVGJ0fwwsnkcDYU9/601DrWXkXIa?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73547541-c21c-4ebc-4b2e-08dd7bd8881b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 04:46:48.4449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HRWk/gdw/UXBgVNxxcFbywQzDOW/h+j10imsKJhKDL0k2CdA3CVthjLgixEy+e0ZHiUuU/dIEXYAiDHk8Q9mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6079
X-OriginatorOrg: intel.com

hi, Peter Zijlstra,

On Mon, Apr 14, 2025 at 09:01:38PM +0200, Peter Zijlstra wrote:
> On Mon, Apr 14, 2025 at 09:59:25AM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "BUG:KASAN:null-ptr-deref_in_put_event" on:
> > 
> > commit: da916e96e2dedcb2d40de77a7def833d315b81a6 ("perf: Make perf_pmu_unregister() useable")
> > https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git perf/core
> > 
> > [test failed on linux-next/master 29e7bf01ed8033c9a14ed0dc990dfe2736dbcd18]
> > 
> > in testcase: trinity
> > version: trinity-x86_64-ba2360ed-1_20241228
> > with following parameters:
> > 
> > 	runtime: 300s
> > 	group: group-02
> > 	nr_groups: 5
> > 
> > 
> > 
> > config: x86_64-randconfig-078-20250407
> > compiler: clang-20
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202504131701.941039cd-lkp@intel.com
> > 
> 
> Does this help?

yes, below patch fixes the issues we observed for da916e96e2. thanks

Tested-by: kernel test robot <oliver.sang@intel.com>

> 
> ---
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 2eb9cd5d86a1..528b679aaf7e 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5687,7 +5687,7 @@ static void put_event(struct perf_event *event)
>  	_free_event(event);
>  
>  	/* Matches the refcount bump in inherit_event() */
> -	if (parent)
> +	if (parent && parent != EVENT_TOMBSTONE)
>  		put_event(parent);
>  }
>  
