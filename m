Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6369296148;
	Thu, 31 Jul 2025 07:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753945966; cv=fail; b=KuuAfSDvohxyngxIFVpbMA1J7gSvosrWEG3gBlI/X6d1nh+2MjZ22qNKLaSXriha13OcE2sYyCXhWdWevzcKzi4tMt1kyXIyYqBdQBcS8cRelAeo+utZnuJBsMVzpJyRWJ73rcGKogdXIMjN9edrrbXf1QlErW9FU+XGex46GQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753945966; c=relaxed/simple;
	bh=xOzfCMr2n8oSzvDNrbouZ3oHbFG5SzhdVWIfZmll+9w=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=tIQSpWjx8/7Zo4PyoghvTpD0acyXqjPSbVR3l4HbcPooXleGN4OhUiC2JJqQF0CKSS6n/unHBXabXazvfR4YjwdQ0h4QnZQiEhaOld5tqilsBgzOOlMaY+/xtCdoHK4EmCPq2Uhep4NSDwUPyp3wSr6IX4SwRB7VSpMH5JrRmGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BjQKW8hH; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BjQKW8hH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753945964; x=1785481964;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xOzfCMr2n8oSzvDNrbouZ3oHbFG5SzhdVWIfZmll+9w=;
  b=BjQKW8hHGehJ+m9uYQi7h4hYhrrWHWaR9oB6UxtKGoLHRv/AhcGzaR14
   /bLUKwzJAx+uEsnbP6o180JCg5qvsm/9tRyByANqO0I3aVwhCdZNWONst
   kvsh8dpmUSuCJkyP1CRnZoizHYYTjYhzS/JKk9Xc6ilD6bU3QAAORZBh0
   UPwWGCSIk9V00VV86PTCFbIW32NtlMCaKhghLZUAV4F406gSpqTwR0skG
   opiBG44W8PP/O9B9uwgAdP11QQPnoLNMqKhsoMs7baq+xNzSrblsC7UQ+
   Dq7LTF0q4GimO475PmgOA4rswWFsd3SniBcyGeh9QailKEAPfpNJ5NZS5
   g==;
X-CSE-ConnectionGUID: b4CGi+cWQD+eEx/T6TKzjQ==
X-CSE-MsgGUID: j/iKeZHNQ7CzSMY0JnDuYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="73847542"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="73847542"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 00:12:44 -0700
X-CSE-ConnectionGUID: cfz5l7CjQAuPqpTrOJlCRQ==
X-CSE-MsgGUID: 1HUXhN/fS2eRJxqHtT8XeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="167666954"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 00:12:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 31 Jul 2025 00:12:43 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 31 Jul 2025 00:12:43 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.54)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 31 Jul 2025 00:12:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTLQCWbCIWiZ5uymi71FtF5tol/eyKVc2boB6/S72ox43bAanfwzClASAc5RePwH1nt0zXs0Cw1GsSjxGC8UAlDil7YeONkYRcpWGNSWseg1Yu3yAffs4QYw+wN++2G8hQ5+0utq89Rcd9S73WTOhP51dJ7OrZ19kcuS5aQnojcbKXbG14jC+ellG6q0Dwk948J9Pc5DiP0kvuvx+D+j+7aCIx1j9Ka30wBMLd5scGJiU42mOJaBZmgljfaAIes812/QvrgQzbthPGUlAWGW51KAYRxj5c/uvhlqiGbYm72rod4Pbb5rIROjvyvrs/Wrh+f7IdGbHQK18/ewKdhtmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efVx7mHXAFaAcTA4K57QrUiPxjeoQF3/YGRarvnTqRo=;
 b=y3bXFAiyvCzEaSUsqnMd7P/Pg0UcxXfe6m0ue7GOpe7gdWrxuQHuyRDuo65rwlUcdfZuz+J/o2loR1MCOxGa+zjNL4ZAI9Vk8qRmcyXEK+MMIt2dfM89PyYIoeQ8LrYwE25W8YcjxdTRTYnRswDXf6UlgbljZRPD9i3cW+J1Zz2V2mB0pDp4kOOaP9tw8oDztkSHaOJo1Z1CiE+ce/DS8t8Vdvme8K3+3vLpatMNPu4XVkEAWf0bHK3Wdu1s/nsCfhwS+VID4VasF/O/MpBKwcpE3Dd91/8+vbmvlmW6mBHfuX6dr/wnmyaToasUpAEgGOie2n8E9cEmEHbOye1ZZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA3PR11MB8968.namprd11.prod.outlook.com (2603:10b6:208:57b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 31 Jul
 2025 07:12:35 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8989.013; Thu, 31 Jul 2025
 07:12:35 +0000
Date: Thu, 31 Jul 2025 15:12:29 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ian Rogers <irogers@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Namhyung Kim
	<namhyung@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [perf stat]  faebee18d7:
 perf-sanity-tests.perf_stat_CSV_output_linter.fail
Message-ID: <202507310835.8b83968c-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: CH0PR03CA0374.namprd03.prod.outlook.com
 (2603:10b6:610:119::34) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA3PR11MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d5716d-3c91-4b1c-1486-08ddd001a002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EIuSnvxRs2xOH1UxhLxNq59q/GyiAUh9gjf9wGHBUY0b8wdHz1o0NAQyD6Wh?=
 =?us-ascii?Q?LDqBEBvlHcN2xngagip6HXzJWN066+Y6rZ8YyG+TPvAbRnjEeN/XFFt1xNHn?=
 =?us-ascii?Q?odG1MxwALa52W5qCstTeulTjYRnPVBPoR7zOo9/8PVQ62m6FWioM2+in5hL1?=
 =?us-ascii?Q?9NlSIjqhtvu5xjCq3wzZjLlsA/16puI2anTI9iyLp2ePi2NLtdsUNRaXFKmF?=
 =?us-ascii?Q?f440QDSwWv5O8jQzEj8x7jRMT+nMVmb9zBwDK6O2QzpydTv80IC1GKCuMD9C?=
 =?us-ascii?Q?nveAYATHqrU4ZFocUT0tTFQko2yvjdDeyjuZDXWQ7/zl2vk6d+c+aeH4xzq9?=
 =?us-ascii?Q?LZgoiZs8De0IRu9lcRADR4sevI/23i5LFBqXAeere9Jv3AfDYNaEBJX8KsFV?=
 =?us-ascii?Q?kfTksfG6zj08+rY1UqvGywg+9EwhMfn/3I8HBzx2JFXPWB5LuH7Hdu770ScN?=
 =?us-ascii?Q?c8emO2o0HP1iH3vfuXu6/r23rsY8npJ4GgcQgocA6Mn0cNi3Di6ZUluzJIm1?=
 =?us-ascii?Q?lQSWPuJCq46u2NFIMnPO02kVJErSsUvMc62/yn1NaEu8ibcnyJPNj6bA01Vz?=
 =?us-ascii?Q?MVwxRd+AqBlGghTlLcCzVY+D9ypnGA64AJdSbK93/jq/tdWBMRC40FpznFyI?=
 =?us-ascii?Q?UM/dBO7yzaFGYms8m4S+5yZzLek4QFro6tzgSgajF4BnMZVyr3m8C0u89wWK?=
 =?us-ascii?Q?ThKXDMp2bZ6BCh8QFMRi1JH2m44N8FX6z1mTs8Nzk5Pcu0DSPzcgze8mmyqy?=
 =?us-ascii?Q?McJ7+LD4bB7OrPfPs5GA1RRCpReA+ItzxzpouMRe93+s6f/um1oLMLwfdZvG?=
 =?us-ascii?Q?SExH/t/9tIkeWkjIY20yIWqcovCJaQiIT52ylemft/Ub2mJwMD8vrm2OhLK5?=
 =?us-ascii?Q?95SFjaQ7euu0LJ3iohd6ZUkQsTy7WF1vfk9QgZzidPFJzjG6HbtcmzXpBxko?=
 =?us-ascii?Q?h8NodCzb/JQem9jWsjGVS98htKglm6s/uRTtbQ//wAn3KxecirnWgZ1sFhoV?=
 =?us-ascii?Q?00zCMUjrcyxlW1JBKJ+b3KmPtvDasgqWWyGJHIp6zei5CdBMXx281ZmmXZMR?=
 =?us-ascii?Q?WsfhobP8WV34mx34KYgluYsWJi6TXJBrBzPyo2jl4dMTvCXyqSpi3N/YM41T?=
 =?us-ascii?Q?ne1FaCER7UuEJap9lPFlFSvXBDYoRkMugmk9T0M+4sFAymvx7SjYp6e7INJL?=
 =?us-ascii?Q?5em+WfpaCGg7Ct76ttBfVmHsSLNs+OwOwfapHsYqj1nlmBQY44uvMBwUQ/Hy?=
 =?us-ascii?Q?yvBgQgyN1tms3VHIOUOwxdQIWfPHcU0cv1NVN3AsXIxaA8K/HODYpaBFugIP?=
 =?us-ascii?Q?J21dNe0Y5OlCXhR8uU2N6XgiwiwukK/kvKUnNZNNQp4iv6K252p2+qc8zXWI?=
 =?us-ascii?Q?boOq3hjX4y8tw3vZVMQzJLzq/cXV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MKZqsrGmwJKwOANrB16FTzCrtb1KgnbQ2ZRzGMx8XxyW1pwPyRiFQciYg4mq?=
 =?us-ascii?Q?ezssX0fVA9ddkN2b+ecPBCtfo3Rgyv6Rs8QC5g4TFzhld99WRfS1gYpoHmjB?=
 =?us-ascii?Q?bcVp9AKTDhuM8anksEghJRNinrGt03tVE+tSsjWCzfAf1jiyI+VFpt2IpMao?=
 =?us-ascii?Q?OTwTx6ckan1WX0SrwZTknlrFCNdA9/4xjyeu3cDiWljUObct2GNad9p0L/9F?=
 =?us-ascii?Q?EGowe37aZhjo515DPvrPyLY50pyFn5yw5X6+qjBR6gwqVo/6R3+WHNx0VypK?=
 =?us-ascii?Q?4LefQ9ztHfzala4R3REJTzj88LKH2+WIRZ3/OSaUpeHAZ7VV2qZh+L4JcFdq?=
 =?us-ascii?Q?ogajF/Mwt/aT+jg02zFDRgT4TYJW4VVpzD6SvlTRluheeqQxRdIptkHVsf2P?=
 =?us-ascii?Q?T+ZvUe10rcNhcOiRigbl27ekJToNyvLyNmT6TYkfgLM0cAqFtjblFdrPxnT7?=
 =?us-ascii?Q?Ej06th2Lu6ynVgYAETK0wznbxgyqz+3SlLnD3ZpU2CbUYq5QNaJKnurQERXf?=
 =?us-ascii?Q?IlXuEar8X1Tm6zrfrVR1D1VipF6TrMF33pfxAGGFKG3SbXg+uhKdOMifFq+g?=
 =?us-ascii?Q?vOnuH+8OIu6frVnoCKIQuH12Fv0FpJ58G8FvHqjvMujEvD+4qrDJ1ADmCgOY?=
 =?us-ascii?Q?ItwB5l7fk9j4URBmmKqwHPa6oePkLeIwz2J22nimpBWDqKWlpL0WZ4z9qz3H?=
 =?us-ascii?Q?HzNPQ2j/b0TSrP8UoN8Aq16PWInMeRpPxr6hSZXA8Y8TBUgfsy8hq7/WynYK?=
 =?us-ascii?Q?3Ptw7AEROOV4WWnEkypr8v+mLDeY2Sr2WE5Z1I+Q/Sc00h8Cmovbc6qR/mrO?=
 =?us-ascii?Q?a2l2ZKgeOYc80gwjWCOL7uc8r2bFASTEQYMgyQXDKvJkJ2Cjl41VTLIkyuPs?=
 =?us-ascii?Q?TthZaDRAz5K6/8hATwh9ZoFRx8Pg6pMM0oSWs4IAmUYH+YkHCimsf+wtke/P?=
 =?us-ascii?Q?hW3jX2CnBOtCXC+ToNW6zhTxLP2erkeLeS/LSGnj3x/Gs8mkvBXU5JHIdi7b?=
 =?us-ascii?Q?sebJmq+RD03I0PFGBeyowANecPp7gGa6UghmON+3DcW0Vr/stlrYrzyx7rBu?=
 =?us-ascii?Q?Az7ob+ON9j4VgBNYbJCOEs8OgPzI+apCY9mXw7dlaj5SP6zMnQ45xUZdxqS3?=
 =?us-ascii?Q?Es03eapWiTPf91roukty/Ltlvh31F75Y+piDAHLEe7+LJQISq/+vhIxpKrur?=
 =?us-ascii?Q?DZ13vZhv0toZC8GCS2qxS/bi+1GO01kKZjWy5wdQrxawWMLPlcXmHW3gvxHl?=
 =?us-ascii?Q?3RPzA8ybXKi2vbolyD9/6DfbmhERa55qCYrzrHQQuPO81Ni86FACQ56WGSxZ?=
 =?us-ascii?Q?Fh8g7VP8ofuinNuhlrf/1XwGvhcx8faVmkYBpwCbxQhN7omF1jxbF+sS4zNf?=
 =?us-ascii?Q?yFJICcWkNb5zkuB2qD+dCo4Db5NlyI3VCx5V2+MPw5D4/s7Vsh9XYn0E53p+?=
 =?us-ascii?Q?QSUpuHne4x3LUs7HNnrJsTfhZcAKNZh4oosA4N5dybuow655LAij28jkqrHF?=
 =?us-ascii?Q?HRxC1Hb6arQe2n8ePotx0Ouifz8MGpT0MgCx/v6FrNBu6zhUo+KmGJHWp30U?=
 =?us-ascii?Q?FqH3cvBLkB7loNZq+DPJbYIGpmassH9lw+6MGozQZKjjMI90u1um53YWuvIJ?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d5716d-3c91-4b1c-1486-08ddd001a002
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 07:12:35.6842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DpR3LCjBosqnXzHVHddBxvx4ITchcbjNwE/pBl7cOj8pAObn8v+L83yO/ThwcaLdt2xUzDckq0Ulr1fMJXx7Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8968
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "perf-sanity-tests.perf_stat_CSV_output_linter.fail" on:

commit: faebee18d720d9e209946ece3e468c06cf13f5ec ("perf stat: Move metric list from config to evlist")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 0b90c3b6d76ea512dc3dac8fb30215e175b0019a]

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: gcc
	group: group-01



config: x86_64-rhel-9.4-bpf
compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202507310835.8b83968c-lkp@intel.com



2025-07-27 19:30:58 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-faebee18d720d9e209946ece3e468c06cf13f5ec/tools/perf/perf test 94 -v
 94: perf stat CSV output linter                                     : Running (1 active)
--- start ---
test child forked, pid 12625
Checking CSV output: no args wrong number of fields. expected 6 in @1252940@100.00@9.4@%  tma_backend_bound
---- end(-1) ----
 94: perf stat CSV output linter                                     : FAILED!



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250731/202507310835.8b83968c-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

