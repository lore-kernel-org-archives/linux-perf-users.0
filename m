Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07563AEF56;
	Fri, 10 Jul 2026 08:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672887; cv=fail; b=cTaC9sxBbQVcguqQ7wmJBLwc+Wd1wrwVt+RzcSDW+CfGqSzSnFVHixFwJVO8zdHHjVhTuErHnKDTJm6kKs1CCzlldsWDncGipNWz9NYi52IYnCgEQnxEYdWU0oq99LvtWG10jPZPWejnzUR/HO1gtbO9KxL5FsCToP3C6vy9osA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672887; c=relaxed/simple;
	bh=dOydYF5xisgUIZerlvE1DLUrhmjyg9USG+gMURJnQtg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P3eQyfOnqsA6tjijpuSM5va8A5UUKulvTUVTPrGebZLKv+x1dBKHFwsj/gID8+RFFMtqIg8y7v59FKvnKAcmlkpuxorjI9/1RXFQ3v6L+VwtwHAUbnD4oX2fuzJKGyQvwJWfcah7ERUQXX9oDYAyNq7FbkX2MwCywWg7YflYZkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T05wsvbr; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T05wsvbr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783672883; x=1815208883;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=dOydYF5xisgUIZerlvE1DLUrhmjyg9USG+gMURJnQtg=;
  b=T05wsvbrM61my59kSOFcAaBf7ymTYjgtq+ET9WC3rlvnarQjS0f2+Pzw
   0MJp+X4edF3ZORWLXIw8IsSUnv5D64On+RJydCjrBlDkZ+5xhLKtqCEFH
   ULIwKqIQVHNJi9TkKhZ/ZxPosZGtMbvsRVimoYbfljWKqdjvyqLDXFNam
   CkIgPXidI+AxhtOC3ZHb1lnVutXQ0Smi9EJ143vishGu5170aJj0UFJBC
   kINDsby9AW9arTVSAOJUHWeOf1hFbu1znJyERBXx/rCi9a8SRotjLY93v
   zVva2wwq21o8Eg/WADLjTlyc6cbhVJJyJoqL7zcTyUlw96PDSM8dtcgUB
   w==;
X-CSE-ConnectionGUID: rJ6KnSnFSvKiodQyxle/fg==
X-CSE-MsgGUID: bvZH+hP+S9ylG0krgK8lOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95522808"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="23'?scan'208";a="95522808"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 01:41:22 -0700
X-CSE-ConnectionGUID: Ol7bwDJpT+6DBcfu9aEdqg==
X-CSE-MsgGUID: Hxffc7UUQL6mFJsu9J9TJw==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 01:41:22 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 01:41:21 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 01:41:21 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.70) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 01:41:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9Bhy3wqkYvcU5U8fcKlI8Bj2u5nEqirhZo+OXkIRkAKbnHI5aY9aPsX0jcgtabmZeGLr5zs80DoexjsF7QiE2vww1EKQsh5paJdUlDG3rHKrs6sdLQrxO30MicNyC7qIpOdEBnsZLYIMgmPmN+lW+35kLu+TF2dPT0fNdWQxMxrkDUOis0jztNtWJgQc6J3WwwMErJzNm2Pmzs5DIVec0VjSgjQV42JmhWxSFjvk+kRbHMXA7nUuv3ttpd8V/pvUmI9SgQqv3Zv6OsjxYm2G+zsZ6LKeID4QjVBHGLqefqxlz8XJhKx7WtHBG5bZTol4FAzYqYcIRzp9wUFtlC5rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3b1Fw8bVpk1NXA/AOIUdYnDrQDAhjueqV5rebEqEWs=;
 b=qbOhHpY650Wqv6YZX0z3cVml2R9S9mES++pnN56HwYxuEZcM7Bdgd+EVvU0oSg/5gtvYNIH0OuYdCZSqh3ZTEyM6pNmJ5h9gb3nqTXqizKSjJOg9qdleCPSzZ6pKkS33ZZVgpCpzflsliHkSO+V0I2//TJnSxU/hDMU0x8LaEaRWoE6P96B6bounPu+2bfAMI9VyI+VWR8x/0aqn9bguinu3xRrMybtd35pVp7uj/sd8zX513ODuvUAFU3a99/WStA99lHAldpsjHjaSt3nWrl3oDzvJJdFGDKnuufoPOnUigwG4m2Kk4xjAUITYYzAEZxshcY8ol6z+1DgBKHzRzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by PH0PR11MB9776.namprd11.prod.outlook.com (2603:10b6:510:398::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Fri, 10 Jul
 2026 08:41:19 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 08:41:19 +0000
Date: Fri, 10 Jul 2026 16:41:09 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	<linux-perf-users@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [tip:perf/core] [perf/core] 166f10836a:
 perf-sanity-tests.Object_code_reading.fail
Message-ID: <alCwJew7UgGb+EQV@xsang-OptiPlex-9020>
References: <202607091054.7c96d6c6-lkp@intel.com>
 <56069e78-7006-4569-add0-6ccdf88c746b@linux.intel.com>
Content-Type: multipart/mixed; boundary="XPirpPujC9JCs+U/"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56069e78-7006-4569-add0-6ccdf88c746b@linux.intel.com>
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|PH0PR11MB9776:EE_
X-MS-Office365-Filtering-Correlation-Id: e49fd590-b1b1-4099-110d-08dede5f02e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|6049299003|23010399003|366016|1800799024|4053099003|6133799003|11063799006|56012099006|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: sVZcW6jS/4jrZ6eDvZGqFWMNhLuW9HKRnYha+3SLoLCmtBfl6mitKV+vsWexbamXv/zS3RnlqjdXOrqIe2IBVoVsz2WFteokM+ffO9vcT3q9uB02FPtxgmhSCSaoOILkH58eRPN6rSDmlDa9oqueF2xFRn0JMVS0AUzPXChAvudOmBz51f+SHr8TfN4RK3YeK3ZUeOjs/9wsbuI73GKbGBZGqJgTB+rjERrHlVoILKvmYPRb/aDs2ihHgpJQ897LR0JNUzstJUPUpO0T+r8lEvw7BrrWIagas2xvqUkVMY2oF7+InqE9HXW4n9g7LCQUSJsXBpYykyheTtu0LJwd0w/7E8LP7wYFvOdj3aEgoyhd67+LqX3tvAMTwPv6IomoGXC9SrGIiifrFAyRF0A+0pdL5X1moQPyVx8btR41rBEbuundqqxcqajMyq56TBDmrnc/dA0qurGjzpAio5g0rVGQBrO2Ah2myszwbGx2LOfVQ1aYSYjDJzupRqYDg9Y1A+8U8n6/au+Xcoezg/y6KPAXrkk2NGusRqjt4ME0ZjOaamkrcHqQgj06Varnh8PCdyjT6xz0JkLBZoiKrOi9HhIM0vkPail+ZrUb9kxIJ5mA7nbM6fdDWzB5f5WoHv7O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(6049299003)(23010399003)(366016)(1800799024)(4053099003)(6133799003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?PvksNxY9PIIVU3L8gfYBfvU3n5ikopCXMVtA0BOprCcp5zOr+WVYjBVDy7?=
 =?iso-8859-1?Q?R1g3cDorU2bOC0Ri+wHCBR7VDqL1VPYOas21E4yTqlqF1iTrgwnryfTKb6?=
 =?iso-8859-1?Q?KnWisrQIT4TGgg87jBMZCK68xkEXrV3bDG6Fgx8HEPaIh+1TMYiWd8l3OX?=
 =?iso-8859-1?Q?OnP91QH/wmGtxehq38xWDdeF9iPVpnr6L8IQaUnMc73eRiFPmI7zfViBCX?=
 =?iso-8859-1?Q?uK0ZCbgSgyO97IfJol7Dd2IwgHGbYAmpsvAjJCRPHtEcmXShgQQ6/Yw6KD?=
 =?iso-8859-1?Q?awSUUI6YGl5h4Knv6eWsgPZiw1XSNAGH52XZiI3M0CP0E2I01qm4P08zXH?=
 =?iso-8859-1?Q?WjPAJ/1CuGvVgSC4TFaDUuWX5KLqZujLh3kw4TmVAikoBazhXbmnbtoDiz?=
 =?iso-8859-1?Q?qVb9rhK0udX0zpQPNAh9DZ+BzLN7+rcK1NWTSc4cW3a9WKH3qDm5olv2ok?=
 =?iso-8859-1?Q?18gblr+ajWfa7LOGL46K5NmiFZoKtkgLz5qy20i5AQIf46GvG2AE30oyWh?=
 =?iso-8859-1?Q?iXR02UuO+skrcyjjoyaMh6WB0jOk+3jx8QDNwinGZoHcpOSwL1bHrK5/B9?=
 =?iso-8859-1?Q?UrQF5fPEA3mDg6SrD3T5qRy5sxpiXgF/+/DN5a1hTPF1iuHx0CYEHf2Jn6?=
 =?iso-8859-1?Q?B+7BiuWh8xJ8RM8j9DzRY8T36wMXgECKgAPOM5KVMA/neGKSdRwAVtsYiZ?=
 =?iso-8859-1?Q?R8YzBp7P1G3u5wCiFoWrfDplvGazfE7m+2R9a39vf1iHdYmq63fi7tbzMl?=
 =?iso-8859-1?Q?uTL+AEEEazPZswI0qR/iZrM2d2lVm+lqTfRZPviMgxrsktMqzpdQuiJX++?=
 =?iso-8859-1?Q?SU6QZ9uhaZa4hbKf7LMIMkQ83I0u1yF/RZRvscSqKZnB0/Wm0Wo8ArSWaW?=
 =?iso-8859-1?Q?AAEGHLLi33Ri4oXuwQbEOZMSLz8B4+PycXnCuYeo4QZrGGmZsbrA7jXvcQ?=
 =?iso-8859-1?Q?SlRAJNz+wn8JUF95lM7TW3Nurj/TFFsz3JY2OUOayfEZp4qXEsr68WpWO/?=
 =?iso-8859-1?Q?+lAJ0+NngcKM/DMaEzDEby6UV12VaO7no/47eMnniqm9+Aa/W1FxvM3pa/?=
 =?iso-8859-1?Q?WPKqjqwaGcxeWMHX5TJgUpn77Dtpo7TDOq+0wJdrNYyzkeac/f07F5KK8T?=
 =?iso-8859-1?Q?Xorh5YTzfBqvFKKX7H68I0N8q24hSwMEPAElQ/1/Y1HksmWuLQCj1CLaLp?=
 =?iso-8859-1?Q?YycJNdQBdEwnF/V447U/RU1QBRBUJR/TTzBYTMdkG68eIugEGU+p8P2HlP?=
 =?iso-8859-1?Q?dUKriaTnrHeMQ+3d9yaeW3lbkcwbRazBTSgCflnVrY08tTNLDSp4T57i8W?=
 =?iso-8859-1?Q?dSJ+vCJlyzTLcCVqzWn2BxGUWP53fddWPJ1lcTSsCMgqZifKz4w6IFMlow?=
 =?iso-8859-1?Q?aeUdgP3WmABjcHRiFTiEM7KttrBxhrsdE/htOR1LUcpRfYcM6JCC3yTrjm?=
 =?iso-8859-1?Q?6C+vipQKn5sPhV7JNA01XD2cDrelDqyYHvtsDCgpNx5TMNE1ihpqp8egs+?=
 =?iso-8859-1?Q?SsGjwH5Wry2rOh0EclI8+AtBNYzwqQ/I0AZji88zGGdBoJ3ebT78zopnRx?=
 =?iso-8859-1?Q?OVsioHdRT3rFK+yGjeUy9CLyUezhxqTOnWErWYi/ye6t0hBmHV4yXQqvlu?=
 =?iso-8859-1?Q?WamGRSHD+Mx9NnMy099/1e8OKnQ8HRJkE6ss+AjDAwEZIx77ocm2XvY+bP?=
 =?iso-8859-1?Q?gAOXbsckVmy4zP5iM9UeLg2EAqhqz5orMaxpWjld+E0E3OU5+JPDnwH3sI?=
 =?iso-8859-1?Q?jhb/+C4CAWH9cDKGvFe7JjE635NEcimVyFa/Xw0SOXUXanKBwfRt8PmAsc?=
 =?iso-8859-1?Q?RyjGgK6FcA=3D=3D?=
X-Exchange-RoutingPolicyChecked: LBNy/ImWQSRuvngQzOSW+izy1fFLh3skhvMB2CKK9jR7WLDkkY1nlgPzpD5sGiIH9QEGtaH7nUEl323geP2f5FcpIQC9Wa0rSZnWpcPmXrZh1gD2uQHQ1JnGg/K8Dyhs5Th6JSV0+PlHAytmLnllCiyLwulvkyVLhrv8EK2iVkobaIjkZtaWWqxsSSorvqM8B245ZORot0D14NFeao8Ouneqq+YQ7rLWmt9S1n2LlcBwtHKRJDqlkDW/WZWcYcOFIlKSmCEOZoFyWYlk+Kw4Fyn4Adp47kwfeXuPSQjvwsjBllcCeJSGVkGaTHCZ0E0AhSeGVsDS/DzdmLpCN1Ghrw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e49fd590-b1b1-4099-110d-08dede5f02e6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:41:19.0526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jk0DFcRsvjR/hEtbg6FUXzdRdk8hDc/Xd8ho/810Odbgv1FVhwEKXbwukUef8XRbTnI0kMJudCA6Agi1hS6Y7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9776
X-OriginatorOrg: intel.com

--XPirpPujC9JCs+U/
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

hi, Dapeng,

On Thu, Jul 09, 2026 at 05:04:11PM +0800, Mi, Dapeng wrote:
> Hi Oliver,
> 
> It looks the direct reason causing the test case failure is the "0" sampled
> IP. This is expected. The commit 166f10836a653dfa280d4335603b52f685b8b1ef
> ("perf/core: Fix kernel register info leak via hardware skid") mitigates a
> security hole and may lead to the sampled IP could be 0. 
> 
> What user right is used to run this command, root or normal user? If it's a

root user. as 'sudo' in attached:

"2026-07-10 15:38:50 sudo ASAN_OPTIONS=fast_unwind_on_malloc=0 /usr/src/linux-perf-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf test 23 -vvv"

> root user, suppose it should not generate such kind of error. Could you
> please add "-vvv" option and rerun this test? The "-vvv" option would print
> more  verbose log.

as attached, thanks


> 
> Thanks!
> 
> -Dapeng
> 
> 
> On 7/9/2026 12:36 PM, kernel test robot wrote:
> >
> > Hello,
> >
> > kernel test robot noticed "perf-sanity-tests.Object_code_reading.fail" on:
> >
> > commit: 166f10836a653dfa280d4335603b52f685b8b1ef ("perf/core: Fix kernel register info leak via hardware skid")
> > https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git perf/core
> >
> >
> > in testcase: perf-sanity-tests
> > version: 
> > with following parameters:
> >
> > 	perf_compiler: clang
> > 	group: group-00
> >
> >
> >
> > config: x86_64-rhel-9.4-bpf
> > compiler: gcc-14
> > test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
> >
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >
> >
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202607091054.7c96d6c6-lkp@intel.com
> >
> >
> > 2026-07-07 00:10:32 sudo ASAN_OPTIONS=fast_unwind_on_malloc=0 /usr/src/linux-perf-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf test 23 -v
> >  23: Object code reading                                 : Running (1 active)
> > ---- start ----
> > ...
> > Bytes read match those read by objdump
> > Reading object code for memory address: 0x7feb8f2134fa
> > File is: /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
> > On file address is: 0x204fa
> > Objdump command is: objdump -z -d --start-address=0x204fa --stop-address=0x2057a /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
> > Bytes read match those read by objdump
> > Reading object code for memory address: 0
> > thread__find_map failed
> > ---- end(-1) ----
> >  23: Object code reading                                 : FAILED!
> >
> > === Test Summary ===
> > Passed main tests : 0
> > Passed subtests   : 0
> > Skipped tests     : 0
> > Failed tests      : 1
> > List of failed tests:
> >    23: Object code reading
> >
> >
> >
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20260709/202607091054.7c96d6c6-lkp@intel.com
> >
> >
> >

--XPirpPujC9JCs+U/
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="perf-sanity-tests.23"

2026-07-10 15:38:50 sudo ASAN_OPTIONS=fast_unwind_on_malloc=0 /usr/src/linux-perf-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf test 23 -vvv
 23: Object code reading                                 : Running (1 active)
 23: Object code reading:
---- start ----
test child forked, pid 14273
Looking at the vmlinux_path (8 entries long)
symsrc__init: cannot get elf header.
/proc/{kallsyms,modules} inconsistency while looking for "[bpf]" module!
/proc/{kallsyms,modules} inconsistency while looking for "[bpf]" module!
/proc/{kallsyms,modules} inconsistency while looking for "[bpf]" module!
/proc/{kallsyms,modules} inconsistency while looking for "[bpf]" module!
/proc/{kallsyms,modules} inconsistency while looking for "[bpf]" module!
/proc/{kallsyms,modules} inconsistency while looking for "[bpf]" module!
/proc/{kallsyms,modules} inconsistency while looking for "[bpf]" module!
/proc/{kallsyms,modules} inconsistency while looking for "[bpf]" module!
/proc/{kallsyms,modules} inconsistency while looking for "[bpf]" module!
Using /proc/kallsyms for symbols
Parsing event 'cpu-cycles:u'
hwmon_pmu: not a hwmon file 'cpu-cycles'
Using CPUID GenuineIntel-6-55-B
Attempt to add: cpu/cpu-cycles/
..after resolving event: cpu/event=0x3c/
cpu-cycles -> cpu/cpu-cycles/
Attempt to add: software/cpu-clock/
..after resolving event: software/config=0/
Opening: cpu-cycles:u
------------------------------------------------------------
perf_event_attr:
  type                             4 (cpu)
  size                             144
  config                           0x3c (cpu_clk_unhalted.thread_p)
  { sample_period, sample_freq }   500
  sample_type                      IP|TID|PERIOD
  read_format                      ID|LOST
  disabled                         1
  inherit                          1
  exclude_kernel                   1
  exclude_hv                       1
  mmap                             1
  comm                             1
  freq                             1
  task                             1
  sample_id_all                    1
  mmap2                            1
  comm_exec                        1
  ksymbol                          1
  bpf_event                        1
------------------------------------------------------------
sys_perf_event_open: pid 14273  cpu 0  group_fd -1  flags 0x8 = 3
sys_perf_event_open: pid 14273  cpu 1  group_fd -1  flags 0x8 = 5
sys_perf_event_open: pid 14273  cpu 2  group_fd -1  flags 0x8 = 6
sys_perf_event_open: pid 14273  cpu 3  group_fd -1  flags 0x8 = 7
sys_perf_event_open: pid 14273  cpu 4  group_fd -1  flags 0x8 = 8
sys_perf_event_open: pid 14273  cpu 5  group_fd -1  flags 0x8 = 9
sys_perf_event_open: pid 14273  cpu 6  group_fd -1  flags 0x8 = 10
sys_perf_event_open: pid 14273  cpu 7  group_fd -1  flags 0x8 = 11
sys_perf_event_open: pid 14273  cpu 8  group_fd -1  flags 0x8 = 12
sys_perf_event_open: pid 14273  cpu 9  group_fd -1  flags 0x8 = 13
sys_perf_event_open: pid 14273  cpu 10  group_fd -1  flags 0x8 = 14
sys_perf_event_open: pid 14273  cpu 11  group_fd -1  flags 0x8 = 15
sys_perf_event_open: pid 14273  cpu 12  group_fd -1  flags 0x8 = 16
sys_perf_event_open: pid 14273  cpu 13  group_fd -1  flags 0x8 = 17
sys_perf_event_open: pid 14273  cpu 14  group_fd -1  flags 0x8 = 18
sys_perf_event_open: pid 14273  cpu 15  group_fd -1  flags 0x8 = 19
sys_perf_event_open: pid 14273  cpu 16  group_fd -1  flags 0x8 = 20
sys_perf_event_open: pid 14273  cpu 17  group_fd -1  flags 0x8 = 21
sys_perf_event_open: pid 14273  cpu 18  group_fd -1  flags 0x8 = 22
sys_perf_event_open: pid 14273  cpu 19  group_fd -1  flags 0x8 = 23
sys_perf_event_open: pid 14273  cpu 20  group_fd -1  flags 0x8 = 24
sys_perf_event_open: pid 14273  cpu 21  group_fd -1  flags 0x8 = 25
sys_perf_event_open: pid 14273  cpu 22  group_fd -1  flags 0x8 = 26
sys_perf_event_open: pid 14273  cpu 23  group_fd -1  flags 0x8 = 27
sys_perf_event_open: pid 14273  cpu 24  group_fd -1  flags 0x8 = 28
sys_perf_event_open: pid 14273  cpu 25  group_fd -1  flags 0x8 = 29
sys_perf_event_open: pid 14273  cpu 26  group_fd -1  flags 0x8 = 30
sys_perf_event_open: pid 14273  cpu 27  group_fd -1  flags 0x8 = 31
sys_perf_event_open: pid 14273  cpu 28  group_fd -1  flags 0x8 = 32
sys_perf_event_open: pid 14273  cpu 29  group_fd -1  flags 0x8 = 33
sys_perf_event_open: pid 14273  cpu 30  group_fd -1  flags 0x8 = 34
sys_perf_event_open: pid 14273  cpu 31  group_fd -1  flags 0x8 = 35
sys_perf_event_open: pid 14273  cpu 32  group_fd -1  flags 0x8 = 36
sys_perf_event_open: pid 14273  cpu 33  group_fd -1  flags 0x8 = 37
sys_perf_event_open: pid 14273  cpu 34  group_fd -1  flags 0x8 = 38
sys_perf_event_open: pid 14273  cpu 35  group_fd -1  flags 0x8 = 39
sys_perf_event_open: pid 14273  cpu 36  group_fd -1  flags 0x8 = 40
sys_perf_event_open: pid 14273  cpu 37  group_fd -1  flags 0x8 = 41
sys_perf_event_open: pid 14273  cpu 38  group_fd -1  flags 0x8 = 42
sys_perf_event_open: pid 14273  cpu 39  group_fd -1  flags 0x8 = 43
sys_perf_event_open: pid 14273  cpu 40  group_fd -1  flags 0x8 = 44
sys_perf_event_open: pid 14273  cpu 41  group_fd -1  flags 0x8 = 45
sys_perf_event_open: pid 14273  cpu 42  group_fd -1  flags 0x8 = 46
sys_perf_event_open: pid 14273  cpu 43  group_fd -1  flags 0x8 = 47
sys_perf_event_open: pid 14273  cpu 44  group_fd -1  flags 0x8 = 48
sys_perf_event_open: pid 14273  cpu 45  group_fd -1  flags 0x8 = 49
sys_perf_event_open: pid 14273  cpu 46  group_fd -1  flags 0x8 = 50
sys_perf_event_open: pid 14273  cpu 47  group_fd -1  flags 0x8 = 51
sys_perf_event_open: pid 14273  cpu 48  group_fd -1  flags 0x8 = 52
sys_perf_event_open: pid 14273  cpu 49  group_fd -1  flags 0x8 = 53
sys_perf_event_open: pid 14273  cpu 50  group_fd -1  flags 0x8 = 54
sys_perf_event_open: pid 14273  cpu 51  group_fd -1  flags 0x8 = 55
sys_perf_event_open: pid 14273  cpu 52  group_fd -1  flags 0x8 = 56
sys_perf_event_open: pid 14273  cpu 53  group_fd -1  flags 0x8 = 57
sys_perf_event_open: pid 14273  cpu 54  group_fd -1  flags 0x8 = 58
sys_perf_event_open: pid 14273  cpu 55  group_fd -1  flags 0x8 = 59
sys_perf_event_open: pid 14273  cpu 56  group_fd -1  flags 0x8 = 60
sys_perf_event_open: pid 14273  cpu 57  group_fd -1  flags 0x8 = 61
sys_perf_event_open: pid 14273  cpu 58  group_fd -1  flags 0x8 = 62
sys_perf_event_open: pid 14273  cpu 59  group_fd -1  flags 0x8 = 63
sys_perf_event_open: pid 14273  cpu 60  group_fd -1  flags 0x8 = 64
sys_perf_event_open: pid 14273  cpu 61  group_fd -1  flags 0x8 = 65
sys_perf_event_open: pid 14273  cpu 62  group_fd -1  flags 0x8 = 66
sys_perf_event_open: pid 14273  cpu 63  group_fd -1  flags 0x8 = 67
sys_perf_event_open: pid 14273  cpu 64  group_fd -1  flags 0x8 = 68
sys_perf_event_open: pid 14273  cpu 65  group_fd -1  flags 0x8 = 69
sys_perf_event_open: pid 14273  cpu 66  group_fd -1  flags 0x8 = 70
sys_perf_event_open: pid 14273  cpu 67  group_fd -1  flags 0x8 = 71
sys_perf_event_open: pid 14273  cpu 68  group_fd -1  flags 0x8 = 72
sys_perf_event_open: pid 14273  cpu 69  group_fd -1  flags 0x8 = 73
sys_perf_event_open: pid 14273  cpu 70  group_fd -1  flags 0x8 = 74
sys_perf_event_open: pid 14273  cpu 71  group_fd -1  flags 0x8 = 75
sys_perf_event_open: pid 14273  cpu 72  group_fd -1  flags 0x8 = 76
sys_perf_event_open: pid 14273  cpu 73  group_fd -1  flags 0x8 = 77
sys_perf_event_open: pid 14273  cpu 74  group_fd -1  flags 0x8 = 78
sys_perf_event_open: pid 14273  cpu 75  group_fd -1  flags 0x8 = 79
sys_perf_event_open: pid 14273  cpu 76  group_fd -1  flags 0x8 = 80
sys_perf_event_open: pid 14273  cpu 77  group_fd -1  flags 0x8 = 81
sys_perf_event_open: pid 14273  cpu 78  group_fd -1  flags 0x8 = 82
sys_perf_event_open: pid 14273  cpu 79  group_fd -1  flags 0x8 = 83
sys_perf_event_open: pid 14273  cpu 80  group_fd -1  flags 0x8 = 84
sys_perf_event_open: pid 14273  cpu 81  group_fd -1  flags 0x8 = 85
sys_perf_event_open: pid 14273  cpu 82  group_fd -1  flags 0x8 = 86
sys_perf_event_open: pid 14273  cpu 83  group_fd -1  flags 0x8 = 87
sys_perf_event_open: pid 14273  cpu 84  group_fd -1  flags 0x8 = 88
sys_perf_event_open: pid 14273  cpu 85  group_fd -1  flags 0x8 = 89
sys_perf_event_open: pid 14273  cpu 86  group_fd -1  flags 0x8 = 90
sys_perf_event_open: pid 14273  cpu 87  group_fd -1  flags 0x8 = 91
sys_perf_event_open: pid 14273  cpu 88  group_fd -1  flags 0x8 = 92
sys_perf_event_open: pid 14273  cpu 89  group_fd -1  flags 0x8 = 93
sys_perf_event_open: pid 14273  cpu 90  group_fd -1  flags 0x8 = 94
sys_perf_event_open: pid 14273  cpu 91  group_fd -1  flags 0x8 = 95
sys_perf_event_open: pid 14273  cpu 92  group_fd -1  flags 0x8 = 96
sys_perf_event_open: pid 14273  cpu 93  group_fd -1  flags 0x8 = 97
sys_perf_event_open: pid 14273  cpu 94  group_fd -1  flags 0x8 = 98
sys_perf_event_open: pid 14273  cpu 95  group_fd -1  flags 0x8 = 99
sys_perf_event_open: pid 14273  cpu 96  group_fd -1  flags 0x8 = 100
sys_perf_event_open: pid 14273  cpu 97  group_fd -1  flags 0x8 = 101
sys_perf_event_open: pid 14273  cpu 98  group_fd -1  flags 0x8 = 102
sys_perf_event_open: pid 14273  cpu 99  group_fd -1  flags 0x8 = 103
sys_perf_event_open: pid 14273  cpu 100  group_fd -1  flags 0x8 = 104
sys_perf_event_open: pid 14273  cpu 101  group_fd -1  flags 0x8 = 105
sys_perf_event_open: pid 14273  cpu 102  group_fd -1  flags 0x8 = 106
sys_perf_event_open: pid 14273  cpu 103  group_fd -1  flags 0x8 = 107
sys_perf_event_open: pid 14273  cpu 104  group_fd -1  flags 0x8 = 108
sys_perf_event_open: pid 14273  cpu 105  group_fd -1  flags 0x8 = 109
sys_perf_event_open: pid 14273  cpu 106  group_fd -1  flags 0x8 = 110
sys_perf_event_open: pid 14273  cpu 107  group_fd -1  flags 0x8 = 111
sys_perf_event_open: pid 14273  cpu 108  group_fd -1  flags 0x8 = 112
sys_perf_event_open: pid 14273  cpu 109  group_fd -1  flags 0x8 = 113
sys_perf_event_open: pid 14273  cpu 110  group_fd -1  flags 0x8 = 114
sys_perf_event_open: pid 14273  cpu 111  group_fd -1  flags 0x8 = 115
sys_perf_event_open: pid 14273  cpu 112  group_fd -1  flags 0x8 = 116
sys_perf_event_open: pid 14273  cpu 113  group_fd -1  flags 0x8 = 117
sys_perf_event_open: pid 14273  cpu 114  group_fd -1  flags 0x8 = 118
sys_perf_event_open: pid 14273  cpu 115  group_fd -1  flags 0x8 = 119
sys_perf_event_open: pid 14273  cpu 116  group_fd -1  flags 0x8 = 120
sys_perf_event_open: pid 14273  cpu 117  group_fd -1  flags 0x8 = 121
sys_perf_event_open: pid 14273  cpu 118  group_fd -1  flags 0x8 = 122
sys_perf_event_open: pid 14273  cpu 119  group_fd -1  flags 0x8 = 123
sys_perf_event_open: pid 14273  cpu 120  group_fd -1  flags 0x8 = 124
sys_perf_event_open: pid 14273  cpu 121  group_fd -1  flags 0x8 = 125
sys_perf_event_open: pid 14273  cpu 122  group_fd -1  flags 0x8 = 126
sys_perf_event_open: pid 14273  cpu 123  group_fd -1  flags 0x8 = 127
sys_perf_event_open: pid 14273  cpu 124  group_fd -1  flags 0x8 = 128
sys_perf_event_open: pid 14273  cpu 125  group_fd -1  flags 0x8 = 129
sys_perf_event_open: pid 14273  cpu 126  group_fd -1  flags 0x8 = 130
sys_perf_event_open: pid 14273  cpu 127  group_fd -1  flags 0x8 = 131
sys_perf_event_open: pid 14273  cpu 128  group_fd -1  flags 0x8 = 132
sys_perf_event_open: pid 14273  cpu 129  group_fd -1  flags 0x8 = 133
sys_perf_event_open: pid 14273  cpu 130  group_fd -1  flags 0x8 = 134
sys_perf_event_open: pid 14273  cpu 131  group_fd -1  flags 0x8 = 135
sys_perf_event_open: pid 14273  cpu 132  group_fd -1  flags 0x8 = 136
sys_perf_event_open: pid 14273  cpu 133  group_fd -1  flags 0x8 = 137
sys_perf_event_open: pid 14273  cpu 134  group_fd -1  flags 0x8 = 138
sys_perf_event_open: pid 14273  cpu 135  group_fd -1  flags 0x8 = 139
sys_perf_event_open: pid 14273  cpu 136  group_fd -1  flags 0x8 = 140
sys_perf_event_open: pid 14273  cpu 137  group_fd -1  flags 0x8 = 141
sys_perf_event_open: pid 14273  cpu 138  group_fd -1  flags 0x8 = 142
sys_perf_event_open: pid 14273  cpu 139  group_fd -1  flags 0x8 = 143
sys_perf_event_open: pid 14273  cpu 140  group_fd -1  flags 0x8 = 144
sys_perf_event_open: pid 14273  cpu 141  group_fd -1  flags 0x8 = 145
sys_perf_event_open: pid 14273  cpu 142  group_fd -1  flags 0x8 = 146
sys_perf_event_open: pid 14273  cpu 143  group_fd -1  flags 0x8 = 147
sys_perf_event_open: pid 14273  cpu 144  group_fd -1  flags 0x8 = 148
sys_perf_event_open: pid 14273  cpu 145  group_fd -1  flags 0x8 = 149
sys_perf_event_open: pid 14273  cpu 146  group_fd -1  flags 0x8 = 150
sys_perf_event_open: pid 14273  cpu 147  group_fd -1  flags 0x8 = 151
sys_perf_event_open: pid 14273  cpu 148  group_fd -1  flags 0x8 = 152
sys_perf_event_open: pid 14273  cpu 149  group_fd -1  flags 0x8 = 153
sys_perf_event_open: pid 14273  cpu 150  group_fd -1  flags 0x8 = 154
sys_perf_event_open: pid 14273  cpu 151  group_fd -1  flags 0x8 = 155
sys_perf_event_open: pid 14273  cpu 152  group_fd -1  flags 0x8 = 156
sys_perf_event_open: pid 14273  cpu 153  group_fd -1  flags 0x8 = 157
sys_perf_event_open: pid 14273  cpu 154  group_fd -1  flags 0x8 = 158
sys_perf_event_open: pid 14273  cpu 155  group_fd -1  flags 0x8 = 159
sys_perf_event_open: pid 14273  cpu 156  group_fd -1  flags 0x8 = 160
sys_perf_event_open: pid 14273  cpu 157  group_fd -1  flags 0x8 = 161
sys_perf_event_open: pid 14273  cpu 158  group_fd -1  flags 0x8 = 162
sys_perf_event_open: pid 14273  cpu 159  group_fd -1  flags 0x8 = 163
sys_perf_event_open: pid 14273  cpu 160  group_fd -1  flags 0x8 = 164
sys_perf_event_open: pid 14273  cpu 161  group_fd -1  flags 0x8 = 165
sys_perf_event_open: pid 14273  cpu 162  group_fd -1  flags 0x8 = 166
sys_perf_event_open: pid 14273  cpu 163  group_fd -1  flags 0x8 = 167
sys_perf_event_open: pid 14273  cpu 164  group_fd -1  flags 0x8 = 168
sys_perf_event_open: pid 14273  cpu 165  group_fd -1  flags 0x8 = 169
sys_perf_event_open: pid 14273  cpu 166  group_fd -1  flags 0x8 = 170
sys_perf_event_open: pid 14273  cpu 167  group_fd -1  flags 0x8 = 171
sys_perf_event_open: pid 14273  cpu 168  group_fd -1  flags 0x8 = 172
sys_perf_event_open: pid 14273  cpu 169  group_fd -1  flags 0x8 = 173
sys_perf_event_open: pid 14273  cpu 170  group_fd -1  flags 0x8 = 174
sys_perf_event_open: pid 14273  cpu 171  group_fd -1  flags 0x8 = 175
sys_perf_event_open: pid 14273  cpu 172  group_fd -1  flags 0x8 = 176
sys_perf_event_open: pid 14273  cpu 173  group_fd -1  flags 0x8 = 177
sys_perf_event_open: pid 14273  cpu 174  group_fd -1  flags 0x8 = 178
sys_perf_event_open: pid 14273  cpu 175  group_fd -1  flags 0x8 = 179
sys_perf_event_open: pid 14273  cpu 176  group_fd -1  flags 0x8 = 180
sys_perf_event_open: pid 14273  cpu 177  group_fd -1  flags 0x8 = 181
sys_perf_event_open: pid 14273  cpu 178  group_fd -1  flags 0x8 = 182
sys_perf_event_open: pid 14273  cpu 179  group_fd -1  flags 0x8 = 183
sys_perf_event_open: pid 14273  cpu 180  group_fd -1  flags 0x8 = 184
sys_perf_event_open: pid 14273  cpu 181  group_fd -1  flags 0x8 = 185
sys_perf_event_open: pid 14273  cpu 182  group_fd -1  flags 0x8 = 186
sys_perf_event_open: pid 14273  cpu 183  group_fd -1  flags 0x8 = 187
sys_perf_event_open: pid 14273  cpu 184  group_fd -1  flags 0x8 = 188
sys_perf_event_open: pid 14273  cpu 185  group_fd -1  flags 0x8 = 189
sys_perf_event_open: pid 14273  cpu 186  group_fd -1  flags 0x8 = 190
sys_perf_event_open: pid 14273  cpu 187  group_fd -1  flags 0x8 = 191
sys_perf_event_open: pid 14273  cpu 188  group_fd -1  flags 0x8 = 192
sys_perf_event_open: pid 14273  cpu 189  group_fd -1  flags 0x8 = 193
sys_perf_event_open: pid 14273  cpu 190  group_fd -1  flags 0x8 = 194
sys_perf_event_open: pid 14273  cpu 191  group_fd -1  flags 0x8 = 195
sys_perf_event_open: pid 14273  cpu 192  group_fd -1  flags 0x8 = 196
sys_perf_event_open: pid 14273  cpu 193  group_fd -1  flags 0x8 = 197
sys_perf_event_open: pid 14273  cpu 194  group_fd -1  flags 0x8 = 198
sys_perf_event_open: pid 14273  cpu 195  group_fd -1  flags 0x8 = 199
sys_perf_event_open: pid 14273  cpu 196  group_fd -1  flags 0x8 = 200
sys_perf_event_open: pid 14273  cpu 197  group_fd -1  flags 0x8 = 201
sys_perf_event_open: pid 14273  cpu 198  group_fd -1  flags 0x8 = 202
sys_perf_event_open: pid 14273  cpu 199  group_fd -1  flags 0x8 = 203
sys_perf_event_open: pid 14273  cpu 200  group_fd -1  flags 0x8 = 204
sys_perf_event_open: pid 14273  cpu 201  group_fd -1  flags 0x8 = 205
sys_perf_event_open: pid 14273  cpu 202  group_fd -1  flags 0x8 = 206
sys_perf_event_open: pid 14273  cpu 203  group_fd -1  flags 0x8 = 207
sys_perf_event_open: pid 14273  cpu 204  group_fd -1  flags 0x8 = 208
sys_perf_event_open: pid 14273  cpu 205  group_fd -1  flags 0x8 = 209
sys_perf_event_open: pid 14273  cpu 206  group_fd -1  flags 0x8 = 210
sys_perf_event_open: pid 14273  cpu 207  group_fd -1  flags 0x8 = 211
sys_perf_event_open: pid 14273  cpu 208  group_fd -1  flags 0x8 = 212
sys_perf_event_open: pid 14273  cpu 209  group_fd -1  flags 0x8 = 213
sys_perf_event_open: pid 14273  cpu 210  group_fd -1  flags 0x8 = 214
sys_perf_event_open: pid 14273  cpu 211  group_fd -1  flags 0x8 = 215
sys_perf_event_open: pid 14273  cpu 212  group_fd -1  flags 0x8 = 216
sys_perf_event_open: pid 14273  cpu 213  group_fd -1  flags 0x8 = 217
sys_perf_event_open: pid 14273  cpu 214  group_fd -1  flags 0x8 = 218
sys_perf_event_open: pid 14273  cpu 215  group_fd -1  flags 0x8 = 219
sys_perf_event_open: pid 14273  cpu 216  group_fd -1  flags 0x8 = 220
sys_perf_event_open: pid 14273  cpu 217  group_fd -1  flags 0x8 = 221
sys_perf_event_open: pid 14273  cpu 218  group_fd -1  flags 0x8 = 222
sys_perf_event_open: pid 14273  cpu 219  group_fd -1  flags 0x8 = 223
sys_perf_event_open: pid 14273  cpu 220  group_fd -1  flags 0x8 = 224
sys_perf_event_open: pid 14273  cpu 221  group_fd -1  flags 0x8 = 225
sys_perf_event_open: pid 14273  cpu 222  group_fd -1  flags 0x8 = 226
sys_perf_event_open: pid 14273  cpu 223  group_fd -1  flags 0x8 = 227
mmap size 528384B
libperf: mmap_per_cpu: nr cpu values 224 nr threads 1
libperf: idx 0: mmapping fd 3
libperf: idx 1: mmapping fd 5
libperf: idx 2: mmapping fd 6
libperf: idx 3: mmapping fd 7
libperf: idx 4: mmapping fd 8
libperf: idx 5: mmapping fd 9
libperf: idx 6: mmapping fd 10
libperf: idx 7: mmapping fd 11
libperf: idx 8: mmapping fd 12
libperf: idx 9: mmapping fd 13
libperf: idx 10: mmapping fd 14
libperf: idx 11: mmapping fd 15
libperf: idx 12: mmapping fd 16
libperf: idx 13: mmapping fd 17
libperf: idx 14: mmapping fd 18
libperf: idx 15: mmapping fd 19
libperf: idx 16: mmapping fd 20
libperf: idx 17: mmapping fd 21
libperf: idx 18: mmapping fd 22
libperf: idx 19: mmapping fd 23
libperf: idx 20: mmapping fd 24
libperf: idx 21: mmapping fd 25
libperf: idx 22: mmapping fd 26
libperf: idx 23: mmapping fd 27
libperf: idx 24: mmapping fd 28
libperf: idx 25: mmapping fd 29
libperf: idx 26: mmapping fd 30
libperf: idx 27: mmapping fd 31
libperf: idx 28: mmapping fd 32
libperf: idx 29: mmapping fd 33
libperf: idx 30: mmapping fd 34
libperf: idx 31: mmapping fd 35
libperf: idx 32: mmapping fd 36
libperf: idx 33: mmapping fd 37
libperf: idx 34: mmapping fd 38
libperf: idx 35: mmapping fd 39
libperf: idx 36: mmapping fd 40
libperf: idx 37: mmapping fd 41
libperf: idx 38: mmapping fd 42
libperf: idx 39: mmapping fd 43
libperf: idx 40: mmapping fd 44
libperf: idx 41: mmapping fd 45
libperf: idx 42: mmapping fd 46
libperf: idx 43: mmapping fd 47
libperf: idx 44: mmapping fd 48
libperf: idx 45: mmapping fd 49
libperf: idx 46: mmapping fd 50
libperf: idx 47: mmapping fd 51
libperf: idx 48: mmapping fd 52
libperf: idx 49: mmapping fd 53
libperf: idx 50: mmapping fd 54
libperf: idx 51: mmapping fd 55
libperf: idx 52: mmapping fd 56
libperf: idx 53: mmapping fd 57
libperf: idx 54: mmapping fd 58
libperf: idx 55: mmapping fd 59
libperf: idx 56: mmapping fd 60
libperf: idx 57: mmapping fd 61
libperf: idx 58: mmapping fd 62
libperf: idx 59: mmapping fd 63
libperf: idx 60: mmapping fd 64
libperf: idx 61: mmapping fd 65
libperf: idx 62: mmapping fd 66
libperf: idx 63: mmapping fd 67
libperf: idx 64: mmapping fd 68
libperf: idx 65: mmapping fd 69
libperf: idx 66: mmapping fd 70
libperf: idx 67: mmapping fd 71
libperf: idx 68: mmapping fd 72
libperf: idx 69: mmapping fd 73
libperf: idx 70: mmapping fd 74
libperf: idx 71: mmapping fd 75
libperf: idx 72: mmapping fd 76
libperf: idx 73: mmapping fd 77
libperf: idx 74: mmapping fd 78
libperf: idx 75: mmapping fd 79
libperf: idx 76: mmapping fd 80
libperf: idx 77: mmapping fd 81
libperf: idx 78: mmapping fd 82
libperf: idx 79: mmapping fd 83
libperf: idx 80: mmapping fd 84
libperf: idx 81: mmapping fd 85
libperf: idx 82: mmapping fd 86
libperf: idx 83: mmapping fd 87
libperf: idx 84: mmapping fd 88
libperf: idx 85: mmapping fd 89
libperf: idx 86: mmapping fd 90
libperf: idx 87: mmapping fd 91
libperf: idx 88: mmapping fd 92
libperf: idx 89: mmapping fd 93
libperf: idx 90: mmapping fd 94
libperf: idx 91: mmapping fd 95
libperf: idx 92: mmapping fd 96
libperf: idx 93: mmapping fd 97
libperf: idx 94: mmapping fd 98
libperf: idx 95: mmapping fd 99
libperf: idx 96: mmapping fd 100
libperf: idx 97: mmapping fd 101
libperf: idx 98: mmapping fd 102
libperf: idx 99: mmapping fd 103
libperf: idx 100: mmapping fd 104
libperf: idx 101: mmapping fd 105
libperf: idx 102: mmapping fd 106
libperf: idx 103: mmapping fd 107
libperf: idx 104: mmapping fd 108
libperf: idx 105: mmapping fd 109
libperf: idx 106: mmapping fd 110
libperf: idx 107: mmapping fd 111
libperf: idx 108: mmapping fd 112
libperf: idx 109: mmapping fd 113
libperf: idx 110: mmapping fd 114
libperf: idx 111: mmapping fd 115
libperf: idx 112: mmapping fd 116
libperf: idx 113: mmapping fd 117
libperf: idx 114: mmapping fd 118
libperf: idx 115: mmapping fd 119
libperf: idx 116: mmapping fd 120
libperf: idx 117: mmapping fd 121
libperf: idx 118: mmapping fd 122
libperf: idx 119: mmapping fd 123
libperf: idx 120: mmapping fd 124
libperf: idx 121: mmapping fd 125
libperf: idx 122: mmapping fd 126
libperf: idx 123: mmapping fd 127
libperf: idx 124: mmapping fd 128
libperf: idx 125: mmapping fd 129
libperf: idx 126: mmapping fd 130
libperf: idx 127: mmapping fd 131
libperf: idx 128: mmapping fd 132
libperf: idx 129: mmapping fd 133
libperf: idx 130: mmapping fd 134
libperf: idx 131: mmapping fd 135
libperf: idx 132: mmapping fd 136
libperf: idx 133: mmapping fd 137
libperf: idx 134: mmapping fd 138
libperf: idx 135: mmapping fd 139
libperf: idx 136: mmapping fd 140
libperf: idx 137: mmapping fd 141
libperf: idx 138: mmapping fd 142
libperf: idx 139: mmapping fd 143
libperf: idx 140: mmapping fd 144
libperf: idx 141: mmapping fd 145
libperf: idx 142: mmapping fd 146
libperf: idx 143: mmapping fd 147
libperf: idx 144: mmapping fd 148
libperf: idx 145: mmapping fd 149
libperf: idx 146: mmapping fd 150
libperf: idx 147: mmapping fd 151
libperf: idx 148: mmapping fd 152
libperf: idx 149: mmapping fd 153
libperf: idx 150: mmapping fd 154
libperf: idx 151: mmapping fd 155
libperf: idx 152: mmapping fd 156
libperf: idx 153: mmapping fd 157
libperf: idx 154: mmapping fd 158
libperf: idx 155: mmapping fd 159
libperf: idx 156: mmapping fd 160
libperf: idx 157: mmapping fd 161
libperf: idx 158: mmapping fd 162
libperf: idx 159: mmapping fd 163
libperf: idx 160: mmapping fd 164
libperf: idx 161: mmapping fd 165
libperf: idx 162: mmapping fd 166
libperf: idx 163: mmapping fd 167
libperf: idx 164: mmapping fd 168
libperf: idx 165: mmapping fd 169
libperf: idx 166: mmapping fd 170
libperf: idx 167: mmapping fd 171
libperf: idx 168: mmapping fd 172
libperf: idx 169: mmapping fd 173
libperf: idx 170: mmapping fd 174
libperf: idx 171: mmapping fd 175
libperf: idx 172: mmapping fd 176
libperf: idx 173: mmapping fd 177
libperf: idx 174: mmapping fd 178
libperf: idx 175: mmapping fd 179
libperf: idx 176: mmapping fd 180
libperf: idx 177: mmapping fd 181
libperf: idx 178: mmapping fd 182
libperf: idx 179: mmapping fd 183
libperf: idx 180: mmapping fd 184
libperf: idx 181: mmapping fd 185
libperf: idx 182: mmapping fd 186
libperf: idx 183: mmapping fd 187
libperf: idx 184: mmapping fd 188
libperf: idx 185: mmapping fd 189
libperf: idx 186: mmapping fd 190
libperf: idx 187: mmapping fd 191
libperf: idx 188: mmapping fd 192
libperf: idx 189: mmapping fd 193
libperf: idx 190: mmapping fd 194
libperf: idx 191: mmapping fd 195
libperf: idx 192: mmapping fd 196
libperf: idx 193: mmapping fd 197
libperf: idx 194: mmapping fd 198
libperf: idx 195: mmapping fd 199
libperf: idx 196: mmapping fd 200
libperf: idx 197: mmapping fd 201
libperf: idx 198: mmapping fd 202
libperf: idx 199: mmapping fd 203
libperf: idx 200: mmapping fd 204
libperf: idx 201: mmapping fd 205
libperf: idx 202: mmapping fd 206
libperf: idx 203: mmapping fd 207
libperf: idx 204: mmapping fd 208
libperf: idx 205: mmapping fd 209
libperf: idx 206: mmapping fd 210
libperf: idx 207: mmapping fd 211
libperf: idx 208: mmapping fd 212
libperf: idx 209: mmapping fd 213
libperf: idx 210: mmapping fd 214
libperf: idx 211: mmapping fd 215
libperf: idx 212: mmapping fd 216
libperf: idx 213: mmapping fd 217
libperf: idx 214: mmapping fd 218
libperf: idx 215: mmapping fd 219
libperf: idx 216: mmapping fd 220
libperf: idx 217: mmapping fd 221
libperf: idx 218: mmapping fd 222
libperf: idx 219: mmapping fd 223
libperf: idx 220: mmapping fd 224
libperf: idx 221: mmapping fd 225
libperf: idx 222: mmapping fd 226
libperf: idx 223: mmapping fd 227
Reading object code for memory address: 0x556d6e0cebdb
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf
On file address is: 0x1657bdb
Objdump command is: objdump -z -d --start-address=0x1657bdb --stop-address=0x1657c5b /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf
Bytes read match those read by objdump
Reading object code for memory address: 0x556d6e0cebde
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf
On file address is: 0x1657bde
Objdump command is: objdump -z -d --start-address=0x1657bde --stop-address=0x1657c5e /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf
Bytes read match those read by objdump
Reading object code for memory address: 0x556d6e0cebde
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf
Already tested /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf @ 0x1657bde - skipping
Reading object code for memory address: 0x7ff258c57d05
File is: /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
On file address is: 0x25d05
Objdump command is: objdump -z -d --start-address=0x25d05 --stop-address=0x25d85 /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
Bytes read match those read by objdump
Reading object code for memory address: 0x7ff258c54447
File is: /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
On file address is: 0x22447
Objdump command is: objdump -z -d --start-address=0x22447 --stop-address=0x224c7 /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
Bytes read match those read by objdump
Reading object code for memory address: 0x7ff258acd688
File is: /usr/lib/x86_64-linux-gnu/libc.so.6
On file address is: 0x8f688
Objdump command is: objdump -z -d --start-address=0x8f688 --stop-address=0x8f708 /usr/lib/x86_64-linux-gnu/libc.so.6
Bytes read match those read by objdump
Reading object code for memory address: 0x7ff258acd688
File is: /usr/lib/x86_64-linux-gnu/libc.so.6
Already tested /usr/lib/x86_64-linux-gnu/libc.so.6 @ 0x8f688 - skipping
Reading object code for memory address: 0x7ff258acd688
File is: /usr/lib/x86_64-linux-gnu/libc.so.6
Already tested /usr/lib/x86_64-linux-gnu/libc.so.6 @ 0x8f688 - skipping
Reading object code for memory address: 0x7ff258c51e69
File is: /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
On file address is: 0x1fe69
Objdump command is: objdump -z -d --start-address=0x1fe69 --stop-address=0x1fee9 /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
Bytes read match those read by objdump
Reading object code for memory address: 0x556d6e0ce3e0
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf
On file address is: 0x16573e0
Objdump command is: objdump -z -d --start-address=0x16573e0 --stop-address=0x1657460 /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf
Bytes read match those read by objdump
Reading object code for memory address: 0x556d6e0ce321
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf
On file address is: 0x1657321
Objdump command is: objdump -z -d --start-address=0x1657321 --stop-address=0x16573a1 /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf
Bytes read match those read by objdump
Reading object code for memory address: 0x556d6e0ce400
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf
On file address is: 0x1657400
Objdump command is: objdump -z -d --start-address=0x1657400 --stop-address=0x1657480 /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf
Bytes read match those read by objdump
Reading object code for memory address: 0x7ff262c71d60
File is: /usr/lib/x86_64-linux-gnu/libasan.so.8.0.0
On file address is: 0x50d60
Objdump command is: objdump -z -d --start-address=0x50d60 --stop-address=0x50de0 /usr/lib/x86_64-linux-gnu/libasan.so.8.0.0
Bytes read match those read by objdump
Reading object code for memory address: 0x556d6e0ce77a
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf
On file address is: 0x165777a
Objdump command is: objdump -z -d --start-address=0x165777a --stop-address=0x16577fa /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf
Bytes read match those read by objdump
Reading object code for memory address: 0x556d6e0ce400
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf
Already tested /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf @ 0x1657400 - skipping
Reading object code for memory address: 0x556d6e0ce3a1
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf
On file address is: 0x16573a1
Objdump command is: objdump -z -d --start-address=0x16573a1 --stop-address=0x1657421 /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf
Bytes read match those read by objdump
Reading object code for memory address: 0x556d6e0ce611
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf
On file address is: 0x1657611
Objdump command is: objdump -z -d --start-address=0x1657611 --stop-address=0x1657691 /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf
Bytes read match those read by objdump
Reading object code for memory address: 0x556d6e0ce3e0
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf
Already tested /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf @ 0x16573e0 - skipping
Reading object code for memory address: 0x556d6e0ce3ed
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf
On file address is: 0x16573ed
Objdump command is: objdump -z -d --start-address=0x16573ed --stop-address=0x165746d /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf
Bytes read match those read by objdump
Reading object code for memory address: 0x7ff258a824ed
File is: /usr/lib/x86_64-linux-gnu/libc.so.6
On file address is: 0x444ed
Objdump command is: objdump -z -d --start-address=0x444ed --stop-address=0x4456d /usr/lib/x86_64-linux-gnu/libc.so.6
Bytes read match those read by objdump
Reading object code for memory address: 0x556d6e0ce38d
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf
On file address is: 0x165738d
Objdump command is: objdump -z -d --start-address=0x165738d --stop-address=0x165740d /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf
Bytes read match those read by objdump
Reading object code for memory address: 0x556d6e351f48
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf
On file address is: 0x18daf48
Objdump command is: objdump -z -d --start-address=0x18daf48 --stop-address=0x18dafc8 /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf
Bytes read match those read by objdump
Reading object code for memory address: 0x556d6e351f48
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf
Already tested /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf @ 0x18daf48 - skipping
Reading object code for memory address: 0x556d6e351f48
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf
Already tested /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf @ 0x18daf48 - skipping
Reading object code for memory address: 0x7ff262c68df3
File is: /usr/lib/x86_64-linux-gnu/libasan.so.8.0.0
On file address is: 0x47df3
Objdump command is: objdump -z -d --start-address=0x47df3 --stop-address=0x47e73 /usr/lib/x86_64-linux-gnu/libasan.so.8.0.0
Bytes read match those read by objdump
Reading object code for memory address: 0x7ff258c51d2e
File is: /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
On file address is: 0x1fd2e
Objdump command is: objdump -z -d --start-address=0x1fd2e --stop-address=0x1fdae /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
Bytes read match those read by objdump
Reading object code for memory address: 0x7ff258c57d00
File is: /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
On file address is: 0x25d00
Objdump command is: objdump -z -d --start-address=0x25d00 --stop-address=0x25d80 /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
Bytes read match those read by objdump
Reading object code for memory address: 0x7ff262ce0339
File is: /usr/lib/x86_64-linux-gnu/libasan.so.8.0.0
On file address is: 0xbf339
Objdump command is: objdump -z -d --start-address=0xbf339 --stop-address=0xbf3b9 /usr/lib/x86_64-linux-gnu/libasan.so.8.0.0
Bytes read match those read by objdump
Reading object code for memory address: 0x7ff258c53385
File is: /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
On file address is: 0x21385
Objdump command is: objdump -z -d --start-address=0x21385 --stop-address=0x21405 /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
Bytes read match those read by objdump
Reading object code for memory address: 0x7ff258acd633
File is: /usr/lib/x86_64-linux-gnu/libc.so.6
On file address is: 0x8f633
Objdump command is: objdump -z -d --start-address=0x8f633 --stop-address=0x8f6b3 /usr/lib/x86_64-linux-gnu/libc.so.6
Bytes read match those read by objdump
Reading object code for memory address: 0
thread__find_map failed
---- end(-1) ----
 23: Object code reading                                 : FAILED!

=== Test Summary ===
Passed main tests : 0
Passed subtests   : 0
Skipped tests     : 0
Failed tests      : 1
List of failed tests:
   23: Object code reading

--XPirpPujC9JCs+U/--
