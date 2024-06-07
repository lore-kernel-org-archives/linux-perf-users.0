Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4102D9443;
	Fri,  7 Jun 2024 06:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717743020; cv=fail; b=acG+1lx8h6+nzM7uEXYRKw64YLb4kcY8w3p9nEWVe69ktPLuV8eABmU6zQ5PmDAinmhlaG1odzY8WVvurKCuQt1Bb4XNqg7jlotVbTeG2Jkld2nnXxLwUqqSGcA2s9p/RHLRkbx35Lety253FMvFMhVKdfHrcvoXS45gM/ldFn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717743020; c=relaxed/simple;
	bh=uvoaWX8n0NDADs39dR22wFaXzQpv/bQvqphPTHlb2wY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C5qHesnDWNOCCGJjGYklb3H6TogIGol9a0vTs21LonHAmU4sbJxg1DAzhefxXG5IUDPsUmjzt2GGv7n8biwHkOxasXUXJZVgEAGOHnmNHRx3cCwStB9f7oAipzhXpiSXhrkaQIAfY51iZP2oVjTZ1NmNro8p3P2IYPcBoc6q1Ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=biJaGzSh; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="biJaGzSh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717743018; x=1749279018;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uvoaWX8n0NDADs39dR22wFaXzQpv/bQvqphPTHlb2wY=;
  b=biJaGzShPkmlAf8P8+4/VmgMY1wIvGO44MxdZFJLw8M2Tn3BzigRlBzm
   kUlsNHpY7pKheWVePfIIvUtUnRI1TftXRcuvqFd0Iz5tyia4JO8bIdcBw
   0iCL9Nvf1BD+y9xoO5IuGZ0Vu9hjhn7o51mVdCIl0Cz9Mw41I3oFhZRN+
   S58C/FMsT0j2UMLMPQPIAqAcENywKJYyGtH7oK2JWUFP4Jn6lfa34hu5d
   SOB1VqX9aJ2H9U6IRfyublOOWgmVMD+z6ju6DZACxcOd9Vn5aBwoyzVuN
   4NwkfE4eZ7ogNwDR+o54yrg8a+i7X5lE91o1qBNC4GWUUPITtGKzi1spo
   Q==;
X-CSE-ConnectionGUID: R67Ld7UxSLi0ycesck3Prw==
X-CSE-MsgGUID: CEuQl5xDTsKTFIRYZEHKXQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14254660"
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="14254660"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 23:50:17 -0700
X-CSE-ConnectionGUID: M6FjQ/2LRke0XEBIB+X5QQ==
X-CSE-MsgGUID: Fp03zlwNQbCK9ELG0R55mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,220,1712646000"; 
   d="scan'208";a="43334345"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Jun 2024 23:50:17 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 6 Jun 2024 23:50:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 6 Jun 2024 23:50:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 6 Jun 2024 23:50:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Jun 2024 23:50:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0ZqbYkgKOMS4cAHQYCjSuxbTp1G/eX+6/85TXkuKvkKZ7jzHaaid8GZoEsScX/1rxFpSR+zR01itXswft2TpQhASVd18vOPgUhyReBP+4cI8g05um+JWvYdRy03WHP35eBHsCDntPGF5anstkQDGvhOaF5u+oOMXQZLdmQPW2SVV30UnYrUvKO8MJhk3CRqIue+Nn/+tZL8E3oyU3KooMm0uArPf/4eC1uBAQMm1ElUM9LT2Dlnd7ZaJKShCw0L9SfCxOZwXJ84osmanc4h9bBDC1yWAZc8hmSkO0CyuWaHYpJhOei0T9of8neDXoXi23dEtmLbeyITAY1YXOUyqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzLBKioV9xuJmicJ8h9wwP0GOlHzey/Qj8nM1U6ZAl4=;
 b=DMjLniwqNAxnphbOhlk8bj9I9wLom4Y9v3OVuy1DilY2HFA5wxH6mzLeSdYFp2CAUDPCgR9J9zjszHJokOFw0PnPlyKqGQeV+MGZyl8FWc7/ONHZFvx+EgP5dF3wQoUFMfTRts68Kt2K+Ndl5MLL2i8+SSvCLHVXB8gBJMVsTySblwfy7/tYTLiukZl6hOUtujPbyKToGD/A//IWCkAzUZ4YqBZe0xIpJcoqcxCCmuRZXi7SNz7RNICPYVEjEFkuhLxCM9ubCqHTAmqsJZkxdf3KA+WLw3lIFHLv6IsIYye5T1OxVmeLe8Js0g7y291U77IjnsrremoBh4FecpYodw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH0PR11MB5047.namprd11.prod.outlook.com (2603:10b6:510:3c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.34; Fri, 7 Jun 2024 06:50:14 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 06:50:13 +0000
Date: Fri, 7 Jun 2024 14:49:57 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
CC: <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<acme@redhat.com>, <atrajeev@linux.vnet.ibm.com>, <kjain@linux.ibm.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf sched map: Add command-name option to filter the
 output map
Message-ID: <ZmKtlQdwk5uwha06@chenyu5-mobl2>
References: <20240417152521.80340-1-vineethr@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240417152521.80340-1-vineethr@linux.ibm.com>
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH0PR11MB5047:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd2af53-15fe-4c63-b7d2-08dc86be1514
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1umNhY02xc3M9rY28AC9jy9RzKEyO73NBfvZeTWMfZDUlwadKXTz/AdLKDIF?=
 =?us-ascii?Q?2t7ubOUT9C0Rg/vzYQhGNe3kxK+DYhYDN0dgmcusBuyu5DN44BSUICrHpZJz?=
 =?us-ascii?Q?6C3m4kkIAddpanxKmknk0oaswYTF9Q507gPVv6R12Stey2GMZ7DQ9k6VJwe2?=
 =?us-ascii?Q?d0ibRlyGNchf+er1K/vjyhCI08zqXlviSHaJw6Bd8bHXbgg6w/Db6nNgwNhY?=
 =?us-ascii?Q?u/n771fi9yNrK5sTWsKjyfl7POZ892F7IjAEhErFoeRskEK7rm8J/BKJL3HZ?=
 =?us-ascii?Q?RvC5+7ZcV1ncjuCyoUflbis2KK0yWey9nVGD5PuimcpjEyrz/TfHdYHGbocC?=
 =?us-ascii?Q?CH/inCznwyZCZG61OYXJ08YBWlfJkMv9tP5FLOOESgpIIepvGM62C9aayZCu?=
 =?us-ascii?Q?J+H218LCIM7fq6AUCGwATQAARUVFqj3w9Cnvfcnzbyd/jKjG3yhPt9TMrnhj?=
 =?us-ascii?Q?kkcz6Q7wJ8qQA5Mf/Q7yZiSQtSMmEAPPLsXDb26aBDZBTaRx2v88IsZd/uAN?=
 =?us-ascii?Q?U7cDCid1dE6UX/NKyDbP04xO8UmmeFl93zy27Sg08++de8x+XJx0FFtpNhs4?=
 =?us-ascii?Q?elmBUMQIAZo52OGo9WMJ5vbNbSdTOqVnDRqOxP19nsJY+JEGgOek3Od5W8rk?=
 =?us-ascii?Q?WzbDT4bOPAWRlR7sgMWER3b6Tu5mZLSE4nnPpo06pqrg9KB58n2s6MmcW3NB?=
 =?us-ascii?Q?EPOALYl4bv5fiYnEc+9coE0MUiCpn7a6zSov348O3YixIQery4HbJ3U/IWMG?=
 =?us-ascii?Q?3ZgYiiSiFTT2okkQsiIv3DnQSR8TgG47EOhxRMLXGU9x2kEd4jfEfVuO9Xhd?=
 =?us-ascii?Q?/wn0rR1EUd9TQQaUHzYTLFkYQNgVeqn0AAeyif3ngqu+8LMo30fkFF32Pl4n?=
 =?us-ascii?Q?cUzGyQ5zuOClN52qDxITtwNn8505a6+EnfkE6muC9Bl/XCQvBQvCNaCUjuPS?=
 =?us-ascii?Q?AHiH38ENxjEDtgeX47KKPRT3BiEPDCWj6JopNEwiozw70+Kfd+PS62g3Cj2s?=
 =?us-ascii?Q?hryLYHa3h0WbYhp6JVddjbbVupP9bSmhlGHxZ7eh6h0uk7blg8ZjOvR1nma9?=
 =?us-ascii?Q?4Hpwy00Lu/cydLIaE9NwBky/rkLQeiooGysxkxsWNAblSrWo7mF31tgqLCdm?=
 =?us-ascii?Q?XtHvz3v6kTTCp4coZqg4hEoOyb0viD9zsHiVKS4Zi/TuLpvYG/U3B6R3YQnN?=
 =?us-ascii?Q?RRsd2dyoic0zMoLrabigcjg293e+JO6Pmvkitks+RhIydE6MS+01UqemSE87?=
 =?us-ascii?Q?CPWbiqzytczBHUT1jMqyE6ASzb6d8tZ1bfj2FJNyE9Cr77yx2FUMoSL6BZqO?=
 =?us-ascii?Q?fZrjaGemMlNKaDOswhOhvyCE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6pTLR7J2L4W1RjgJR9np7kkJfoHrAolvVHq7Tt2wLNq2yHtjYKso8WY5yuQO?=
 =?us-ascii?Q?9RnSVzRlWAB/daPHvKs+8yXMi8lDMr0pWspN2fBszE5sEuD/xoyqH16gNgsf?=
 =?us-ascii?Q?/76fGb4BF2jz9rP0IEe74d8Sn4C19wUEYCX5QQHXZ216ZvqydQ5oWEVhZzjK?=
 =?us-ascii?Q?k6hPjqCW45E4y1pv09xvxy3l9oirjFyJyaVqmiM6WHOeACWdATfIoqQL7SFm?=
 =?us-ascii?Q?4gno5p1nW0ZKFcfY31tvRY9737SpfYGTc/3j6YvxDrfKTeBt1BUtYZsyz9wi?=
 =?us-ascii?Q?FRIXmI7XapxNzOQ7GvYN8hsQCCU84FqZ46QBI8hDBGG48YThrOD/vQWP+phu?=
 =?us-ascii?Q?dDVMWc9rG6MMeF3OVBjafYlPPC43phzULN7iH7nmPIQGEe4hH+3iFX7UX5yP?=
 =?us-ascii?Q?kEJQd4CE56Lqg+kKS3C25BfaWBed9oOolFvVqTBKzAwkg5EC+LF60EdWI61Y?=
 =?us-ascii?Q?z9TDUjrFrJLbnX/0dSXmksTZi01TA0RHHuzkNxkAUp4Lu+ITFMx2nrzEohOh?=
 =?us-ascii?Q?qs0X0UC7z5NeAtFNJjpjWtsFoZpxGGsC7hb57fFBEdAyjN8zmC47H2vT7vZs?=
 =?us-ascii?Q?Qjhw114ZRRXjw+69v4ED39Cko/hCLd6oYmehc6aqF5iQpG8L3uf+Yu3n5G61?=
 =?us-ascii?Q?fEavegTJ6zlOZP50UP5cV5Yw57HDp6GOiasaELPj60pBvaIqgW0nUiPrt277?=
 =?us-ascii?Q?GoWAI/xOlurnFz5WC7MjhGibr5z4ffimkD0Ct0N6S9orozmbMLAPwWq41qqk?=
 =?us-ascii?Q?5jKk1LFaKyYEOtpGmkIfK60b65K87570v6rvVt2nbB8RSisV1bpm8H+eKil+?=
 =?us-ascii?Q?hbDWHu7bFJq9OzxWHSgjz8NerfMteBcT5+OY18bAcpemQqUSNI5mNKDP1tHG?=
 =?us-ascii?Q?C0hKUSbH08Fm4+q1w5pFEnRBVwLjIjQKY3hWHHp5gpHfG4mBXTrwkmaKXiSB?=
 =?us-ascii?Q?1vGKYvC+VQ6hoJZAN3+7Tf+i3FKkIUz13AkjJmb0cwc+T0JOSkCDJsd8e50p?=
 =?us-ascii?Q?8CcITQzoxmNWRFCllFzhUktSf+LbmFcgQ9CHIJl9F4e/PskD2+jInFXsAFIg?=
 =?us-ascii?Q?hhkYyllLV4y90zAuA7yhv9PU1PPfwhCY2PKwvGihjc4pgYYgoaCOEvw+A+d5?=
 =?us-ascii?Q?tiiGdMXUXqaIDXy8wz01JXNXgTfkOh3xm1KwUTLZ2Z3EksGWkNajn6imYz6A?=
 =?us-ascii?Q?gRQNmiwMBJ+Xe0cP2sMhueuxsZrmfVUnbA/x99nvS8BB+0QQs/e8cgc+qWPT?=
 =?us-ascii?Q?65Dr7gBNjiFLGp6qiD/fJX9vDkFE0KjcNd5E+b3Wns1gg5zY5j/WHTw0/Dd7?=
 =?us-ascii?Q?7RuOnEOqmlOIzZPC9KaR+3FSsUBkVQkkA/kbQcQPOQXE9WRWMApBFkWTxs+a?=
 =?us-ascii?Q?OnQkfibzZQVZPiTeCiSWzlamt5cLnIZafSB/9NBWn+WnBHR3mMpX8SEl0ZGz?=
 =?us-ascii?Q?rSnyeeoR9i9IVh/NL0BikCDACxSnyKNS9JZRiBp/M2L5NVZ0WRPxM1S9XrdF?=
 =?us-ascii?Q?fWVkHcZySiseouBx5lZwiERCBoDrSh3d9LhMSJ+SzsUDEhnYw/rAujXo9RJQ?=
 =?us-ascii?Q?F6gw2TZVap73rdVw63IRVppVXYeoukurmLZEisC1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd2af53-15fe-4c63-b7d2-08dc86be1514
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 06:50:13.6467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cM4HQw+3+AJVUCUO3gLGMoW8bvOZrIGRtxhJHauwtq/yvRa6X4b/0QkAenl6P8nIl5FIjmXG8yswnAfz8VB0rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5047
X-OriginatorOrg: intel.com

On 2024-04-17 at 20:55:21 +0530, Madadi Vineeth Reddy wrote:
> By default, perf sched map prints sched-in events for all the tasks
> which may not be required all the time as it prints lot of symbols
> and rows to the terminal.
> 
> With --command-name option, one could specify the specific command
> for which the map has to be shown. This would help in analyzing the
> CPU usage patterns easier for that specific command. Since multiple
> PID's might have the same command name, using command-name filter
> would be more useful for debugging.
> 
> For other tasks, instead of printing the symbol, ** is printed and
> the same . is used to represent idle. ** is used instead of symbol
> for other tasks because it helps in clear visualization of command
> of interest and secondly the symbol itself doesn't mean anything
> because the sched-in of that symbol will not be printed(first sched-in
> contains pid and the corresponding symbol).
> 
> 6.8.0
> ======
>   *A0                   213864.670142 secs A0 => migration/0:18
>   *.                    213864.670148 secs .  => swapper:0
>    .  *B0               213864.670217 secs B0 => migration/1:21
>    .  *.                213864.670223 secs
>    .   .  *C0           213864.670247 secs C0 => migration/2:26
>    .   .  *.            213864.670252 secs
> 
> 6.8.0 + patch (--command-name = schbench)
> =============
>    **  .   ** *A0       213864.671055 secs A0 => schbench:104834
>   *B0  .   .   A0       213864.671156 secs B0 => schbench:104835
>   *C0  .   .   A0       213864.671187 secs C0 => schbench:104836
>   *D0  .   .   A0       213864.671219 secs D0 => schbench:104837
>   *E0  .   .   A0       213864.671250 secs E0 => schbench:104838
>    E0  .  *D0  A0
> 
> This helps in visualizing how a benchmark like schbench is spread over
> the available cpus while also knowing which cpus are idle(.) and which
> are not(**). This will be more useful as number of CPUs increase.
> 
> Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> ---
>  tools/perf/Documentation/perf-sched.txt |  4 ++++
>  tools/perf/builtin-sched.c              | 17 ++++++++++++++---
>  2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
> index 5fbe42bd599b..b04a37560935 100644
> --- a/tools/perf/Documentation/perf-sched.txt
> +++ b/tools/perf/Documentation/perf-sched.txt
> @@ -94,6 +94,10 @@ OPTIONS for 'perf sched map'
>  --color-pids::
>  	Highlight the given pids.
>  
> +--command-name::
> +	Map output only for the given command name.
> +	(** indicates other tasks while . is idle).
> +
>  OPTIONS for 'perf sched timehist'
>  ---------------------------------
>  -k::
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 0fce7d8986c0..e60836da53e5 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -156,6 +156,7 @@ struct perf_sched_map {
>  	const char		*color_pids_str;
>  	struct perf_cpu_map	*color_cpus;
>  	const char		*color_cpus_str;
> +	const char		*command;
>  	struct perf_cpu_map	*cpus;
>  	const char		*cpus_str;
>  };
> @@ -1594,8 +1595,6 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  
>  	sched->curr_thread[this_cpu.cpu] = thread__get(sched_in);
>  
> -	printf("  ");
> -
>  	new_shortname = 0;
>  	if (!tr->shortname[0]) {
>  		if (!strcmp(thread__comm_str(sched_in), "swapper")) {
> @@ -1605,7 +1604,8 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  			 */
>  			tr->shortname[0] = '.';
>  			tr->shortname[1] = ' ';
> -		} else {
> +		} else if (!sched->map.command || !strcmp(thread__comm_str(sched_in),
> +								sched->map.command)) {
>

I've tested on my machine and it looks good. One minor question, can we do
fuzzy name matching? Say, there are many tasks 'a-taskname-b',
and we can filter them via
perf sched map --command-name=taskname

thanks,
Chenyu
