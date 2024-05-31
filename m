Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9102B6FB8;
	Fri, 31 May 2024 08:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717143414; cv=fail; b=nzUwMk2r4LpIfnXc5cPbY+TtnhghMsVdZX4imz8Joc+KP/71XeuirnVmUAh4YBsXOq+b5P9EdRE58+iDgdnHzjCK1V/tJ/p2qCy3E9Y/AjWTuqyVJe4kggG6oPb814zBsgclDSsK8Y5KHOwUJAxrpdhvQbO4QfK2qfA7zQShI90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717143414; c=relaxed/simple;
	bh=meV4TXD0pEYuXssjw1CvNS+RxMu0BXSzTshvzHySO5w=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WL1RE6pB94qwfDW/cp55+OsmkmIaxdH7kd1j+dxLZpKJnnjVVbVDwdCbcHtHON8lhyMnrkwl+IDnwW8qcuV+Na02nsSzRu5wDth9FAJfrkFqOiOWtctK8Flj+aWUBtbsrA5Ny00rwSFXx5p/zRp38f6Gy3Wqj4wKEETpH9mdqzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CLEt9cQa; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CLEt9cQa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717143411; x=1748679411;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=meV4TXD0pEYuXssjw1CvNS+RxMu0BXSzTshvzHySO5w=;
  b=CLEt9cQaNwZ2kkwHny1nqiiR8iD7alfnllHF6LdUMnEBmRafNZtulMp8
   hhDdEJR0pE2Z2WCFbqE1paMFgBLYu+OtjbwxJ/sCbRe4njUZNUn0RJYAL
   P23W+tMYfUV4hoxXGTnuJaoM9VmPP9c4SqSrj/zUMuW5vhrB8rvmypiXG
   xTzKKmO71evR+o0XgHR8WIz8iza8KSTqmOHsHW2syZ15DFoGJ44B0gn+c
   e+yf7UMfDzZ9pH0TdPprJKe7aZRM/hFvfTM1pepb2kCL0JSd4M1MR2HeX
   F0nqFPFv3lyc6FjsAxM9mQrmA16V4hdd0JbIAaFiL6tIY4xe7tVYewLqU
   w==;
X-CSE-ConnectionGUID: IB+hQH39QRydq10rqgT60A==
X-CSE-MsgGUID: Txzosv6IRtOvQWqITijZuw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="11836264"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="11836264"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 01:16:50 -0700
X-CSE-ConnectionGUID: xn1MEqVqTlGgay4zyxTzSA==
X-CSE-MsgGUID: QzAVdX1TT7eo4zlwMZdatA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="36575100"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 May 2024 01:16:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 May 2024 01:16:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 31 May 2024 01:16:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 31 May 2024 01:16:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFu0kpStnx9rEIM7h49ShqXhpXXN5ja3AG9sEEPgOI7eszdMMiYljXTckErJPrYNdabV7XErtDkPVrRTAXBpk0Hot6fAV/e0tOT7NleHVtxE9ZK10HWdDlVOq835s1H75eHJwsaX/+3uNhx4WlYu2pXuuSg2AfWZGy5HELVv4o2k0iTcGkk5JZaORRxY7bQCYl25hwnXEIR7O7K7WP7xzVxgAY1iphw7V5lehbcERA5uJNgekkjfqBtY+AP43HVlaHpU5dU5DGi5eUjGJvE2XyOaBIEI2+WCbvsXV63ujiFvbBX1Xdyrd9tKHoE8NOBgRDrPbdHq4sdWVgXdDB8JRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4XrQ4bUZ43Eg/Ae1ytgH4zYhlDgGnB/GXNlhzLJBek=;
 b=RUTeFdEKFbd90w/PqqPkKO+WJJ6cLo4ToQwVl0CYRuih2oAVcm6pkhusLFHK7yMDPYeou4Xp+ObKuhomdlz0u9EOV2uLYfRj2ff9+bR+bM/JXszst7upwdsnB02rSlnQu4wCtYcBcDx8wqf5znef/JSaV9yQN/9SyFaFy42Wo8IjrQOw9D3hLMgUudxYkyqNV+R249feZLvNX8Fgt99939usNwomisMgUbBg5Smt5XhEcvALJEG0PVM9bFYEJ4r33SBTkcf0m17Ns4T5N8iacQ+uiFtzS1Kd4e/PeEbdq51eTC1BNJOrSyn3WT+yxl4bmnac3z6lIn3Uxwk9KV2gAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB6194.namprd11.prod.outlook.com (2603:10b6:208:3ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 08:16:47 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7611.025; Fri, 31 May 2024
 08:16:47 +0000
Date: Fri, 31 May 2024 16:16:35 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ian Rogers <irogers@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Weilin
 Wang" <weilin.wang@intel.com>, Peter Zijlstra <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, Jing Zhang
	<renyu.zj@linux.alibaba.com>, John Garry <john.g.garry@oracle.com>, "Sandipan
 Das" <sandipan.das@amd.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v2 2/2] perf jevents: Autogenerate empty-pmu-events.c
Message-ID: <202405311548.1e881dea-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240525013021.436430-2-irogers@google.com>
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: 125bd4e0-6eff-47b6-3856-08dc814a03d1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z5yPl4c9vt8D96uQLh5d7Xcb2FhYeA2R9iNzaHZgDeL+UqTAOtIRe6wqCtX+?=
 =?us-ascii?Q?q48OIS0yDl08YhOdYOWOXr6zOXHbLZahIcMjjXfXCROVCANKws5kTbCduZM4?=
 =?us-ascii?Q?VayqrJOG+K2iB3qXX9euElKfNtD4ciDxE8Z7jWxMLUWeyrMNZBcnqqc8tYoh?=
 =?us-ascii?Q?qx06oQpd2KWJ3wKEm7Q+5eXY/MTh1qcCNz39aTXkXm1Fqf3cgT57YZNNdqqY?=
 =?us-ascii?Q?cDmG7/STvY9vh3bQNsdVZH8hk4e/Rur+tqy46Zt8QRI3bnnNrnH6VeSD5yyS?=
 =?us-ascii?Q?kNARyIgeqX0iqouAoJN5V6RaLnKxsuI+EIKwy6YcU8z2BcSCPm1WlgzWUHwT?=
 =?us-ascii?Q?oc+spXCFyatM8P+Jz6TcjKmuhNxZgwD8GVkYpbaBs+/ccBEO7d3mo2trVeS9?=
 =?us-ascii?Q?73iY3zfD/1GwsdLP4UyXRs7qAZWURpMi7MC5hXM5Vfpe/6/ct12AsKV8oSFl?=
 =?us-ascii?Q?kGMO9/f6VaX8rtFHqDOrhQXJuMx3P4y+p2OB9SS2ZPqBNEUHCXSWwXeFkY3+?=
 =?us-ascii?Q?azXkqi+tMNZSdvhbpC2HVPpzyJxHJpmbGVHRyUnNViGn/H3iafXtfeqAoiam?=
 =?us-ascii?Q?cuJ+nJFCXe6M2Lv8Pvaq0Id2FA/aIY3SCwkv9eslld5Fm3ecm6BGNdIsWYEB?=
 =?us-ascii?Q?dS4Z7cXa6ai9M4Mec4z26YnSmYMZEAMgn3TJgswjgyzAJrh9wBcEf1QRD9P7?=
 =?us-ascii?Q?cOtTZtn42eqLK4E87JeqmN8r7lKOmuaIUT3O+yi1AKxYlv/dP3JmzqPWZ7yK?=
 =?us-ascii?Q?KSBjMBbSo5to3fA7/ijvtkq8IC/mE0MbAmbpoeic6f7Buj7j6BwM9/s2HK1T?=
 =?us-ascii?Q?u98MJe6uHTNA1+Xcz8hg6n24/OQBhgjeugoOmTXdbSXxFYXBGqfX6YS7P5rt?=
 =?us-ascii?Q?pgpnMj8iunRPvGEiDbCJHglshXYbuFcMNm6ZzBP7eYvEJ6trgpwOscEVgZEs?=
 =?us-ascii?Q?yPzn5gnmsQoyP75Z4UUR7fa0FmnzsN264A0nxLPeKCkbAkg0ou1R3hoYZBs1?=
 =?us-ascii?Q?a3cLiurLVXQ4ImDNiB4ARXwmyYXVmmP7n1eRJ9vbHriX42JnS93VUNlM2mqT?=
 =?us-ascii?Q?yTJWl6qpdgvoHHb76cZS0qGBSBNae3YdY/DjoCwyoGv14TRxvDX0xCZf8vdD?=
 =?us-ascii?Q?jUNeOsKN2LSdf9pTuCGHn9hNkweQEQLloLn7JYORl3ufFfH8NlKhDzU9NG/B?=
 =?us-ascii?Q?r3gOxkoeQV0HLr3gs5SdSDPqAHXFk0cAh5rzsj9naEM85mB7nbaeZBREzpU?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XJoc31wtgEzASvEWD0X/9tAg5Kybm7Lolhu6lxqtjMyWKVUk2wDsX3mGg7jL?=
 =?us-ascii?Q?tYT+Uolga9DftMmeeBr8oFEyH0mBjIFNIhJwUmfvWhVW3aYQFPH+058nvNgX?=
 =?us-ascii?Q?DtKkeR/VTXIaLGwEMnFm/Z2fs3SkPIdfrfyB3CgDMgZkVEAUnipXE8IrrLQ4?=
 =?us-ascii?Q?wwHvX8UrwJD5PQGFLuRIiVSpYikrO2WvGeaKb4ZuQ++vzNr/aj8W+mdFCkfC?=
 =?us-ascii?Q?dqLUidZamFmOFfUTmjldm4YXC9e2+UVYAbOmdjI/kJ/SpQ+HrauAgRYfkrQP?=
 =?us-ascii?Q?+huLYcVxkQtupm0K4dlrZm3U2KjlvO1wrOvZGIN0gQn5g0KRuldlXB3jNZzX?=
 =?us-ascii?Q?yEfnurU4A48NKG6QbOLT8FP8oX99la3cZY10hWOFVPKMzqRaaQ+nl3vNXyRN?=
 =?us-ascii?Q?OV9wvgMXjcZ8d2jIo/sdct9Mlf6soFUYNfCZD7+zQcojw3AkATUd5CfYJNdB?=
 =?us-ascii?Q?fD759m7kILtnwsQ/kItPOtN116DY28XTSpu3n2/VTyZeuqeKwytxhIpJ0u6M?=
 =?us-ascii?Q?aTH3ZOrZXNRBqsuXuyZKmXVsiIod6ckL5guuX6lJoRzRQ6B9r/Hs0txBCzos?=
 =?us-ascii?Q?T3BfAE8NikOOlSZ43IpY8O1CDCSpoRch0y692ouZkSTs/nwZoreI1MTC8SO3?=
 =?us-ascii?Q?ZbElqbaOSBtEIuNVHWkjTv72Vf/HRQxM/aCkUB2/cbCTXBbGZvO5P2r5gzwx?=
 =?us-ascii?Q?63Z2kZv0YmWnpsvy3p4OY2encE4jYORWUeQqqEi4pykCVum7scn2PWsmzf9v?=
 =?us-ascii?Q?PhbQJEn6OGKb5B4Ea9SnfJZjhOlkVRhaVjw3EmvgTmwvdZfXO94wJBjper28?=
 =?us-ascii?Q?PgILW+ZfKhrYSDrlGiOJiXxaBbM6tzeomuGorFIy9IZVUyDOUH+qrNZJnn+q?=
 =?us-ascii?Q?iK6wmZkA31hs+i7fGyhTR/FTzN/d+l7U20vouRJN+nZpzKTR3wwqsP1Cj7+8?=
 =?us-ascii?Q?ZZEzjzoXNuKDoir/+agWQ1/G2+tddqWPElgP7M3Jqdx2KCE3l9bU2sVYGl0q?=
 =?us-ascii?Q?9cpl4C6Det7EcrdGsl264gGtaa7Q/U5lY4M8GioLEsm3Y23A6Gg4s9SW4Gov?=
 =?us-ascii?Q?z0FvLQl9eBhKVF/nnLCL31VipMnTraDGFooI/u3GolBDl5c+tcnqyQe50pOY?=
 =?us-ascii?Q?ixYrPDQ0rVa+Gw+0WqU6jdKNISM/idB5+fAuHr55kUFjRi87Qt2OOaxuiZP1?=
 =?us-ascii?Q?gJUC45em2zvpOCxCc6mIKt3fqc7luFmWxRtGdRfTgJ3vMJne2qkCxh+C5opK?=
 =?us-ascii?Q?MY1pYFLLG3MtI1qy3DXGiBKGUeIRdTXCKzk8FTrbH5Eqji2YXBbrVr4KnQeL?=
 =?us-ascii?Q?B8b2lXs7RWuEt3IMufkSlE4kbYK+BwgjkR0GuRvl280WemTM3XXxlKikQKnW?=
 =?us-ascii?Q?XJQj4t1oDol20yiw92IBXMgNQrgXPCNiRn81HlKcIgzk8tIizAmJYBCT/UEJ?=
 =?us-ascii?Q?3jtppyBzSw9foRBGBIu9DTUYTsJi2x/kL+MSKkeJbapKRUStZLzzKHOkQA/j?=
 =?us-ascii?Q?k1EYq/xfsl5DZga3XxLNEjKSVYtihbNBOa2ZI1Q78G+8VNWLUPeQKwB1nbo+?=
 =?us-ascii?Q?EOV+A9vXqAXr3O+aXYoCZxHT8i4XcdNW5BNA4x3pygGK4kNxr1BZrWmOZXQy?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 125bd4e0-6eff-47b6-3856-08dc814a03d1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 08:16:47.4581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSh8EMivCDkX0yDlrJEnKUIGOrbcr+o5QswAAOSxUrC2aNZZ2mGZL1t5lin2WBv1Ok4cQy1SdL+foeJHmG/VZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6194
X-OriginatorOrg: intel.com


hi, Ian Rogers,

we actually want to seek your advice. in our env, there is no problem to bu=
ild
parent.

* 3249f8b84526d (linux-review/Ian-Rogers/perf-jevents-Autogenerate-empty-pm=
u-events-c/20240525-093240) perf jevents: Autogenerate empty-pmu-events.c
* 7d88bd0d22746 perf jevents: Use name for special find value   <--- parent

however, failed to build perf upon 3249f8b84526d. but there is not many use=
ful
information in below detail log.

is there any dependency or env setting for us to build this commit? Thanks!



Hello,

kernel test robot noticed "perf-sanity-tests.perf.make.fail" on:

commit: 3249f8b84526d3b69162812908c257ee9816a237 ("[PATCH v2 2/2] perf jeve=
nts: Autogenerate empty-pmu-events.c")
url: https://github.com/intel-lab-lkp/linux/commits/Ian-Rogers/perf-jevents=
-Autogenerate-empty-pmu-events-c/20240525-093240
base: https://git.kernel.org/cgit/linux/kernel/git/perf/perf-tools-next.git=
 perf-tools-next
patch link: https://lore.kernel.org/all/20240525013021.436430-2-irogers@goo=
gle.com/
patch subject: [PATCH v2 2/2] perf jevents: Autogenerate empty-pmu-events.c

in testcase: perf-sanity-tests
version:=20
with following parameters:

	perf_compiler: gcc



compiler: gcc-13
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphi=
re Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202405311548.1e881dea-oliver.sang@=
intel.com

gcc march setting is sapphirerapids
valid
2024-05-30 15:55:30 make -j224 WERROR=3D0 BUILD_BPF_SKEL=3D0 ARCH=3D DEBUG=
=3D1 EXTRA_CFLAGS=3D-fno-omit-frame-pointer -fsanitize=3Dundefined -fsaniti=
ze=3Daddress -C /usr/src/linux-perf-x86_64-rhel-8.3-bpf-3249f8b84526d3b6916=
2812908c257ee9816a237/tools/perf
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f=
8b84526d3b69162812908c257ee9816a237/tools/perf'
  BUILD:   Doing 'make =1B[33m-j224=1B[m' parallel build
  HOSTCC  fixdep.o
  HOSTLD  fixdep-in.o
  LINK    fixdep
=1B[0;33mWarning=1B[0m: Kernel ABI header differences:

Auto-detecting system features:
...                                   dwarf: [ =1B[32mon=1B[m  ]
...                      dwarf_getlocations: [ =1B[32mon=1B[m  ]
...                                   glibc: [ =1B[32mon=1B[m  ]
...                                  libbfd: [ =1B[32mon=1B[m  ]
...                          libbfd-buildid: [ =1B[32mon=1B[m  ]
...                                  libcap: [ =1B[32mon=1B[m  ]
...                                  libelf: [ =1B[32mon=1B[m  ]
...                                 libnuma: [ =1B[32mon=1B[m  ]
...                  numa_num_possible_cpus: [ =1B[32mon=1B[m  ]
...                                 libperl: [ =1B[32mon=1B[m  ]
...                               libpython: [ =1B[32mon=1B[m  ]
...                               libcrypto: [ =1B[32mon=1B[m  ]
...                               libunwind: [ =1B[32mon=1B[m  ]
...                      libdw-dwarf-unwind: [ =1B[32mon=1B[m  ]
...                             libcapstone: [ =1B[31mOFF=1B[m ]
...                                    zlib: [ =1B[32mon=1B[m  ]
...                                    lzma: [ =1B[32mon=1B[m  ]
...                               get_cpuid: [ =1B[32mon=1B[m  ]
...                                     bpf: [ =1B[32mon=1B[m  ]
...                                  libaio: [ =1B[32mon=1B[m  ]
...                                 libzstd: [ =1B[32mon=1B[m  ]

  GEN     common-cmds.h
  GEN     /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/arch/arm64/include/generated/asm/sysreg-defs=
.h
  CC      jvmti/libjvmti.o
  CC      jvmti/jvmti_agent.o
  CC      jvmti/libstring.o
  CC      dlfilters/dlfilter-test-api-v0.o
  CC      jvmti/libctype.o
  CC      dlfilters/dlfilter-test-api-v2.o
  CC      dlfilters/dlfilter-show-cycles.o
  GEN     perf-archive
  GEN     perf-iostat
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libsubcmd/include/subcmd/exec-cmd.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libsubcmd/include/subcmd/help.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libsubcmd/include/subcmd/pager.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libsubcmd/include/subcmd/parse-options.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libsubcmd/include/subcmd/run-command.h
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libsubcmd/exec-cmd.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libsubcmd/help.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libsubcmd/pager.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libsubcmd/parse-options.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libsubcmd/run-command.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libsubcmd/sigchain.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libsubcmd/subcmd-config.o
  INSTALL libsubcmd_headers
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libapi/include/api/cpu.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libapi/include/api/debug.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libapi/include/api/io.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libapi/include/api/fd/array.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libsymbol/include/symbol/kallsyms.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libperf/include/perf/bpf_perf.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libapi/include/api/fs/fs.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libperf/include/perf/core.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libapi/include/api/fs/tracing_path.h
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libsymbol/kallsyms.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libapi/cpu.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libperf/include/perf/cpumap.h
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libapi/debug.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libperf/include/perf/threadmap.h
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libperf/core.o
  MKDIR   /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libapi/fd/
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libperf/include/perf/evlist.h
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libapi/str_error_r.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libperf/include/perf/evsel.h
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libperf/cpumap.o
  MKDIR   /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libapi/fs/
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libperf/include/perf/event.h
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libperf/threadmap.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libperf/include/perf/mmap.h
  MKDIR   /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libapi/fs/
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libperf/include/internal/cpumap.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libperf/include/internal/evlist.h
  MKDIR   /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libapi/fs/
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libperf/evsel.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libperf/include/internal/evsel.h
  INSTALL libsymbol_headers
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libperf/evlist.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libperf/include/internal/lib.h
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libperf/mmap.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libperf/include/internal/mmap.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libperf/include/internal/rc_check.h
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libperf/zalloc.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libapi/fd/array.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libperf/include/internal/threadmap.h
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libapi/fs/fs.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libperf/xyarray.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libperf/include/internal/xyarray.h
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libapi/fs/tracing_path.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libperf/lib.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libapi/fs/cgroup.o
  INSTALL libapi_headers
  GEN     /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/bpf_helper_defs.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/include/bpf/bpf.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/include/bpf/libbpf.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/include/bpf/btf.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/include/bpf/libbpf_common.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/include/bpf/libbpf_legacy.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/include/bpf/bpf_helpers.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/include/bpf/bpf_tracing.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/include/bpf/bpf_endian.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/include/bpf/bpf_core_read.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/include/bpf/skel_internal.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/include/bpf/libbpf_version.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/include/bpf/usdt.bpf.h
  INSTALL libperf_headers
  LINK    dlfilters/dlfilter-show-cycles.so
  LINK    dlfilters/dlfilter-test-api-v0.so
  LINK    dlfilters/dlfilter-test-api-v2.so
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/include/bpf/bpf_helper_defs.h
  MKDIR   /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/staticobjs/
  MKDIR   /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/staticobjs/
  INSTALL libbpf_headers
  MKDIR   /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/staticobjs/
  MKDIR   /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/staticobjs/
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/staticobjs/libbpf.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/staticobjs/libbpf_errno.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/staticobjs/bpf.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/staticobjs/str_error.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/staticobjs/nlattr.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/staticobjs/btf.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/staticobjs/netlink.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/staticobjs/bpf_prog_linfo.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/staticobjs/libbpf_probes.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/staticobjs/hashmap.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/staticobjs/btf_dump.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/staticobjs/ringbuf.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/staticobjs/strset.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/staticobjs/linker.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/staticobjs/gen_loader.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/staticobjs/relo_core.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/staticobjs/usdt.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/staticobjs/zip.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/staticobjs/elf.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/staticobjs/features.o
  LD      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libsymbol/libsymbol-in.o
  LD      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libapi/fd/libapi-in.o
  AR      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libsymbol/libsymbol.a
  LD      jvmti/jvmti-in.o
  LINK    libperf-jvmti.so
  LD      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libapi/fs/libapi-in.o
  LD      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libapi/libapi-in.o
  AR      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libapi/libapi.a
  LD      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libperf/libperf-in.o
  AR      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libperf/libperf.a
  LD      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libsubcmd/libsubcmd-in.o
  AR      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libsubcmd/libsubcmd.a
  GEN     python/perf.cpython-311-x86_64-linux-gnu.so
  LD      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/staticobjs/libbpf-in.o
  LINK    /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8b84526d3b691628=
12908c257ee9816a237/tools/perf/libbpf/libbpf.a
  CC      builtin-bench.o
  CC      builtin-annotate.o
  CC      builtin-config.o
  CC      builtin-diff.o
  CC      builtin-evlist.o
  CC      builtin-ftrace.o
  CC      builtin-help.o
  CC      builtin-buildid-list.o
  CC      builtin-buildid-cache.o
  CC      builtin-kallsyms.o
  CC      builtin-list.o
  CC      builtin-record.o
  CC      builtin-report.o
  CC      builtin-stat.o
  CC      builtin-top.o
  CC      builtin-script.o
  CC      builtin-kvm.o
  CC      builtin-inject.o
  CC      builtin-mem.o
  CC      builtin-data.o
  CC      builtin-version.o
  CC      builtin-c2c.o
  CC      builtin-daemon.o
  TEST    pmu-events/metric_test.log
  CC      builtin-kmem.o
  CC      builtin-kwork.o
  CC      builtin-lock.o
  CC      builtin-sched.o
  CC      builtin-timechart.o
  CC      builtin-trace.o
  CC      trace/beauty/clone.o
  CC      builtin-probe.o
  CC      perf.o
  CC      trace/beauty/fcntl.o
  CC      bench/sched-messaging.o
  CC      trace/beauty/flock.o
  CC      bench/sched-pipe.o
  CC      tests/builtin-test.o
  CC      trace/beauty/fs_at_flags.o
  CC      arch/common.o
  CC      tests/tests-scripts.o
  CC      bench/sched-seccomp-notify.o
  CC      bench/syscall.o
  CC      ui/setup.o
  CC      trace/beauty/fsmount.o
  CC      ui/helpline.o
  CC      tests/parse-events.o
  CC      trace/beauty/fspick.o
  CC      tests/dso-data.o
  CC      bench/mem-functions.o
  CC      bench/futex-hash.o
  CC      tests/attr.o
  CC      trace/beauty/ioctl.o
  CC      ui/util.o
  CC      ui/progress.o
  CC      tests/vmlinux-kallsyms.o
  CC      ui/hist.o
  CC      trace/beauty/kcmp.o
  CC      trace/beauty/mount_flags.o
  CC      tests/openat-syscall.o
  CC      trace/beauty/move_mount.o
  CC      bench/futex-wake.o
  CC      ui/stdio/hist.o
  CC      bench/futex-wake-parallel.o
  CC      tests/openat-syscall-all-cpus.o
  CC      scripts/perl/Perf-Trace-Util/Context.o
  CC      bench/futex-lock-pi.o
  CC      trace/beauty/arch_prctl.o
  CC      scripts/python/Perf-Trace-Util/Context.o
  CC      trace/beauty/pkey_alloc.o
  CC      ui/browser.o
  CC      bench/futex-requeue.o
  CC      tests/openat-syscall-tp-fields.o
  CC      tests/mmap-basic.o
  CC      tests/perf-record.o
  CC      trace/beauty/prctl.o
  CC      bench/epoll-wait.o
  CC      trace/beauty/renameat.o
  CC      bench/epoll-ctl.o
  CC      tests/evsel-roundtrip-name.o
  CC      trace/beauty/sockaddr.o
  CC      arch/x86/util/header.o
  CC      bench/synthesize.o
  CC      tests/evsel-tp-sched.o
  CC      trace/beauty/socket.o
  CC      trace/beauty/statx.o
  CC      bench/kallsyms-parse.o
  CC      tests/fdarray.o
  CC      arch/x86/util/tsc.o
  CC      arch/x86/tests/regs_load.o
  CC      bench/inject-buildid.o
  CC      bench/find-bit-bench.o
  CC      trace/beauty/timespec.o
  CC      tests/pmu.o
  CC      trace/beauty/sync_file_range.o
  CC      arch/x86/util/kvm-stat.o
  CC      arch/x86/tests/dwarf-unwind.o
  CC      arch/x86/util/pmu.o
  CC      arch/x86/tests/arch-tests.o
  CC      arch/x86/util/perf_regs.o
  CC      tests/pmu-events.o
  CC      ui/browsers/annotate-data.o
  CC      arch/x86/tests/sample-parsing.o
  CC      arch/x86/util/topdown.o
  CC      ui/browsers/annotate.o
  CC      tests/hists_common.o
  CC      bench/breakpoint.o
  CC      ui/tui/setup.o
  CC      bench/evlist-open-close.o
  CC      arch/x86/tests/hybrid.o
  CC      tests/hists_link.o
  CC      ui/browsers/hists.o
  CC      ui/tui/util.o
  CC      ui/tui/helpline.o
  CC      bench/uprobe.o
  CC      tests/hists_filter.o
  CC      ui/browsers/map.o
  CC      bench/pmu-scan.o
  CC      tests/hists_output.o
  CC      ui/tui/progress.o
  CC      arch/x86/tests/intel-pt-test.o
  CC      arch/x86/tests/amd-ibs-via-core-pmu.o
  CC      arch/x86/util/event.o
  CC      arch/x86/util/machine.o
  CC      arch/x86/tests/bp-modify.o
  CC      arch/x86/util/evlist.o
  CC      bench/mem-memcpy-x86-64-asm.o
  CC      tests/hists_cumulate.o
  CC      tests/python-use.o
  CC      ui/browsers/scripts.o
  CC      ui/browsers/header.o
  CC      ui/browsers/res_sample.o
  CC      bench/mem-memset-x86-64-asm.o
  CC      arch/x86/util/mem-events.o
  CC      bench/numa.o
  CC      tests/bp_signal_overflow.o
  CC      tests/bp_signal.o
  CC      arch/x86/util/evsel.o
  CC      tests/bp_account.o
  CC      arch/x86/util/iostat.o
  CC      tests/wp.o
  CC      trace/beauty/tracepoints/x86_msr.o
  CC      trace/beauty/tracepoints/x86_irq_vectors.o
  CC      arch/x86/util/env.o
  CC      arch/x86/util/dwarf-regs.o
  CC      tests/task-exit.o
  CC      arch/x86/util/unwind-libunwind.o
  CC      tests/sw-clock.o
  CC      tests/mmap-thread-lookup.o
  CC      arch/x86/util/archinsn.o
  CC      arch/x86/util/auxtrace.o
  CC      tests/thread-maps-share.o
  CC      tests/switch-tracking.o
  CC      arch/x86/util/intel-pt.o
  CC      tests/keep-tracking.o
  CC      arch/x86/util/intel-bts.o
  CC      tests/code-reading.o
  CC      tests/sample-parsing.o
  CC      tests/parse-no-sample-id-all.o
  CC      tests/kmod-path.o
  CC      tests/thread-map.o
  CC      tests/topology.o
  CC      tests/mem.o
  CC      tests/cpumap.o
  CC      tests/stat.o
  CC      tests/event_update.o
  CC      tests/event-times.o
  CC      tests/expr.o
  CC      tests/backward-ring-buffer.o
  CC      tests/sdt.o
  CC      tests/is_printable_array.o
  CC      tests/perf-hooks.o
  CC      tests/bitmap.o
  CC      tests/mem2node.o
  CC      tests/unit_number__scnprintf.o
  CC      tests/maps.o
  CC      tests/time-utils-test.o
  CC      tests/genelf.o
  CC      tests/api-io.o
  CC      tests/demangle-java-test.o
  CC      tests/demangle-ocaml-test.o
  CC      tests/pfm.o
  CC      tests/parse-metric.o
  CC      tests/pe-file-parsing.o
  CC      tests/expand-cgroup.o
  CC      tests/perf-time-to-tsc.o
  CC      tests/dlfilter-test.o
  CC      tests/sigtrap.o
  CC      tests/event_groups.o
  CC      tests/symbols.o
  CC      tests/util.o
  CC      tests/dwarf-unwind.o
  CC      tests/workloads/noploop.o
  CC      tests/workloads/thloop.o
  CC      tests/workloads/leafloop.o
  CC      tests/workloads/sqrtloop.o
  CC      tests/workloads/brstack.o
  CC      tests/workloads/datasym.o
  GEN     pmu-events/test-empty-pmu-events.c
  CC      util/arm64-frame-pointer-unwind-support.o
  CC      util/addr_location.o
  CC      util/annotate.o
  CC      util/block-info.o
  CC      util/build-id.o
  CC      util/block-range.o
  CC      util/cacheline.o
  CC      util/config.o
  CC      util/copyfile.o
  CC      util/ctype.o
  CC      util/db-export.o
  CC      util/disasm.o
  CC      util/event.o
  CC      util/env.o
  CC      util/evlist.o
  CC      util/sideband_evlist.o
  CC      util/evsel.o
  CC      util/evsel_fprintf.o
  CC      util/perf_event_attr_fprintf.o
  CC      util/evswitch.o
  CC      util/find_bit.o
  CC      util/get_current_dir_name.o
  CC      util/levenshtein.o
  CC      util/mmap.o
  CC      util/memswap.o
  BISON   util/parse-events-bison.c
  CC      util/print-events.o
  CC      util/tracepoint.o
  TEST    pmu-events/empty-pmu-events.log
  CC      util/perf_regs.o
--- pmu-events/empty-pmu-events.c	2024-05-30 08:20:10.000000000 +0000
+++ pmu-events/test-empty-pmu-events.c	2024-05-30 15:55:37.332495538 +0000
@@ -136,7 +136,7 @@
 { 2623 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
 { 2078 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_=
cycles\000\000\000\000\000\000\000\00000 */
 { 1947 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.an=
y\000\000\000\000\000\000\000\00000 */
-{ 2011 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired=
any\000\000\000\000\000\000\000\00000 */
+{ 2011 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired=
.any\000\000\000\000\000\000\000\00000 */
=20
 };
=20
@@ -373,7 +373,7 @@
 {
         for (size_t i =3D 0; i < table->num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu =3D &table->pmus[i=
];
-                const char *pmu_name =3D &big_c_string[table_pmu->pmu_name=
offset];
+                const char *pmu_name =3D &big_c_string[table_pmu->pmu_name=
.offset];
                 int ret;
=20
                 if (pmu && !pmu__name_match(pmu, pmu_name))
@@ -394,7 +394,7 @@
 {
         for (size_t i =3D 0; i < table->num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu =3D &table->pmus[i=
];
-                const char *pmu_name =3D &big_c_string[table_pmu->pmu_name=
offset];
+                const char *pmu_name =3D &big_c_string[table_pmu->pmu_name=
.offset];
                 int ret;
=20
                 if (!pmu__name_match(pmu, pmu_name))
@@ -414,7 +414,7 @@
=20
         for (size_t i =3D 0; i < table->num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu =3D &table->pmus[i=
];
-                const char *pmu_name =3D &big_c_string[table_pmu->pmu_name=
offset];
+                const char *pmu_name =3D &big_c_string[table_pmu->pmu_name=
.offset];
=20
                 if (pmu__name_match(pmu, pmu_name))
                         count +=3D table_pmu->num_entries;
@@ -524,7 +524,7 @@
=20
         for (size_t i =3D 0; i < map->event_table.num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu =3D &map->event_ta=
ble.pmus[i];
-                const char *pmu_name =3D &big_c_string[table_pmu->pmu_name=
offset];
+                const char *pmu_name =3D &big_c_string[table_pmu->pmu_name=
.offset];
=20
                 if (pmu__name_match(pmu, pmu_name))
                          return &map->event_table;
@@ -544,7 +544,7 @@
=20
         for (size_t i =3D 0; i < map->metric_table.num_pmus; i++) {
                 const struct pmu_table_entry *table_pmu =3D &map->metric_t=
able.pmus[i];
-                const char *pmu_name =3D &big_c_string[table_pmu->pmu_name=
offset];
+                const char *pmu_name =3D &big_c_string[table_pmu->pmu_name=
.offset];
=20
                 if (pmu__name_match(pmu, pmu_name))
                            return &map->metric_table;
  CC      util/perf-regs-arch/perf_regs_aarch64.o
  CC      util/intel-pt-decoder/intel-pt-pkt-decoder.o
  CC      util/arm-spe-decoder/arm-spe-pkt-decoder.o
  CC      util/perf-regs-arch/perf_regs_arm.o
  GEN     util/intel-pt-decoder/inat-tables.c
  CC      util/arm-spe-decoder/arm-spe-decoder.o
  CC      util/intel-pt-decoder/intel-pt-log.o
  CC      util/perf-regs-arch/perf_regs_csky.o
  CC      util/intel-pt-decoder/intel-pt-decoder.o
  CC      util/perf-regs-arch/perf_regs_loongarch.o
  CC      util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.o
  CC      util/perf-regs-arch/perf_regs_mips.o
  CC      util/perf-regs-arch/perf_regs_powerpc.o
  CC      util/path.o
  CC      util/perf-regs-arch/perf_regs_riscv.o
  CC      util/perf-regs-arch/perf_regs_s390.o
  CC      util/scripting-engines/trace-event-perl.o
  CC      util/perf-regs-arch/perf_regs_x86.o
  CC      util/scripting-engines/trace-event-python.o
  CC      util/print_binary.o
  CC      util/print_insn.o
  CC      util/rlimit.o
  CC      util/argv_split.o
  CC      util/bitmap.o
  CC      util/rbtree.o
  CC      util/libstring.o
  CC      util/hweight.o
  CC      util/smt.o
  CC      util/strbuf.o
  CC      util/string.o
  LD      trace/beauty/tracepoints/perf-in.o
  CC      util/strlist.o
  CC      util/top.o
  CC      util/strfilter.o
  CC      util/usage.o
  CC      util/dsos.o
  CC      util/symbol.o
  CC      util/symbol_fprintf.o
  CC      util/dso.o
  CC      util/map_symbol.o
  CC      util/color.o
  CC      util/color_config.o
  CC      util/metricgroup.o
  CC      util/header.o
  CC      util/callchain.o
  CC      util/debug.o
  CC      util/values.o
  CC      util/fncache.o
  CC      util/machine.o
  CC      util/map.o
  CC      util/maps.o
  CC      util/pstack.o
  CC      util/session.o
  CC      util/sample-raw.o
  CC      util/s390-sample-raw.o
  LD      trace/beauty/perf-in.o
  CC      util/amd-sample-raw.o
  CC      util/syscalltbl.o
  CC      util/ordered-events.o
  CC      util/namespaces.o
  CC      util/comm.o
  CC      util/thread.o
  CC      util/threads.o
  CC      util/thread_map.o
  CC      util/parse-events-bison.o
  BISON   util/pmu-bison.c
  CC      util/pmus.o
  CC      util/svghelper.o
  CC      util/trace-event-info.o
  CC      util/trace-event-scripting.o
  CC      util/trace-event.o
  CC      util/trace-event-parse.o
  CC      util/trace-event-read.o
  CC      util/sort.o
  CC      util/hist.o
  CC      util/util.o
  CC      util/cpumap.o
  CC      util/affinity.o
  CC      util/cputopo.o
  CC      util/cgroup.o
  CC      util/target.o
  CC      util/rblist.o
  CC      util/intlist.o
  CC      util/vdso.o
  CC      util/counts.o
  CC      util/stat.o
  CC      util/stat-shadow.o
  CC      util/stat-display.o
  CC      util/perf_api_probe.o
  CC      util/record.o
  CC      util/srcline.o
  CC      util/srccode.o
  CC      util/synthetic-events.o
  CC      util/data.o
  CC      util/tsc.o
  CC      util/cloexec.o
  CC      util/call-path.o
  CC      util/rwsem.o
  CC      util/thread-stack.o
  CC      util/spark.o
  CC      util/topdown.o
  CC      util/iostat.o
  LD      tests/workloads/perf-in.o
  CC      util/stream.o
  CC      util/auxtrace.o
  LD      util/perf-regs-arch/perf-in.o
  CC      util/intel-pt.o
  CC      util/intel-bts.o
  CC      util/arm-spe.o
  CC      util/hisi-ptt.o
  CC      util/s390-cpumsf.o
  CC      util/cs-etm-base.o
  CC      util/parse-branch-options.o
  CC      util/dump-insn.o
  CC      util/parse-regs-options.o
  CC      util/help-unknown-cmd.o
  CC      util/term.o
  CC      util/parse-sublevel-options.o
  CC      util/dlfilter.o
  CC      util/mem-info.o
  CC      util/mem-events.o
  CC      util/vsprintf.o
  CC      util/units.o
  CC      util/time-utils.o
  BISON   util/expr-bison.c
  CC      util/mem2node.o
  CC      util/clockid.o
  LD      ui/tui/perf-in.o
  CC      util/branch.o
  CC      util/list_sort.o
  CC      util/mutex.o
  CC      util/sharded_mutex.o
  CC      util/bpf_map.o
  CC      util/symbol-elf.o
  CC      util/probe-file.o
  CC      util/probe-event.o
  CC      util/probe-finder.o
  CC      util/dwarf-aux.o
  CC      util/dwarf-regs.o
  CC      util/debuginfo.o
  CC      util/annotate-data.o
  CC      util/unwind-libunwind-local.o
  CC      util/unwind-libunwind.o
  CC      util/data-convert-bt.o
  CC      util/lzma.o
  CC      util/zlib.o
  CC      util/data-convert-json.o
  CC      util/zstd.o
  CC      util/cap.o
  CXX     util/demangle-cxx.o
  CC      util/demangle-java.o
  CC      util/demangle-ocaml.o
  CC      util/demangle-rust.o
  CC      util/jitdump.o
  CC      util/genelf.o
  CC      util/genelf_debug.o
  CC      util/perf-hooks.o
  CC      util/bpf-event.o
  CC      util/bpf-utils.o
  CC      util/pfm.o
  FLEX    util/parse-events-flex.c
  FLEX    util/pmu-flex.c
  CC      util/pmu-bison.o
  FLEX    util/expr-flex.c
  CC      util/intel-pt-decoder/intel-pt-insn-decoder.o
  CC      util/expr-bison.o
  LD      util/hisi-ptt-decoder/perf-in.o
  LD      arch/x86/tests/perf-in.o
  CC      util/pmu.o
  CC      util/pmu-flex.o
  CC      util/expr-flex.o
  CC      util/expr.o
  CC      util/parse-events.o
  CC      util/parse-events-flex.o
  LD      scripts/python/Perf-Trace-Util/perf-in.o
  LD      util/arm-spe-decoder/perf-in.o
  LD      arch/x86/util/perf-in.o
  LD      arch/x86/perf-in.o
  LD      arch/perf-in.o
  LD      scripts/perl/Perf-Trace-Util/perf-in.o
  LD      scripts/perf-in.o
  LD      bench/perf-in.o
  LD      tests/perf-in.o
  LD      util/scripting-engines/perf-in.o
  LD      ui/browsers/perf-in.o
  LD      ui/perf-in.o
  LD      util/intel-pt-decoder/perf-in.o
  LD      util/perf-in.o
  LD      perf-in.o
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-3249f8=
b84526d3b69162812908c257ee9816a237/tools/perf'
make perf failed

make[3]: *** [pmu-events/Build:42: pmu-events/empty-pmu-events.log] Error 1
make[3]: *** Deleting file 'pmu-events/empty-pmu-events.log'
make[2]: *** [Makefile.perf:730: pmu-events/pmu-events-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile.perf:264: sub-make] Error 2
make: *** [Makefile:70: all] Error 2



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240531/202405311548.1e881dea-oliv=
er.sang@intel.com



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

