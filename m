Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CDA1CAA1;
	Wed, 24 Jul 2024 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832963; cv=fail; b=kItHa1rTwz3KmEZcOWQNPCYkBtjswGerhrkPD7qlqX2TpUs0zGD2BysnNTX6VgXn+ApMzMOabVkoyNXVzzKAXfCt5tSLkTCJJxT9PmrNxsbNukoRWRSHFd0s7JCLTwRy6M9Uj0VHukVASQohSo4o9pKkTg7jW+0SJK3BIAVDsZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832963; c=relaxed/simple;
	bh=NRz+Yujm7kMj6ZtyDW/K46pJvEc0Cn7cnPeY1xvH994=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VF9hyXvnDcSG3l8TdGlEBJSx9Yzih6rJDL1SJGJA3/HsntIkaf/xUDB6CY94gIO/LhySdjMR0mhChllEYo1LXKt5pxdXGl41KJB0A3K950fMnFLUxxJpvLzoWEXEP5CoX6V6sQxD+f1Er9bxjm4GfV8JHnm6gh7IEc4yPcYLnys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ULxhenhT; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ULxhenhT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721832961; x=1753368961;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=NRz+Yujm7kMj6ZtyDW/K46pJvEc0Cn7cnPeY1xvH994=;
  b=ULxhenhTBH5eZMPNCXlM40EJ/vq+FWUOXI/+mHKT9rMFiPcZl6nXa2nl
   yr21KbeQLRBYzWMNiIeokqfS04N8dMpmIfA+AtnYUpjEC65hwxmEA8Sdn
   b9J8FeYZruf+s4mz7iuRjHiAMrQVuutBPbu4NO0aoiBVtNHZWO1hQeIzh
   6XfqKXhUXD8Ovsvy2D7xnGz8BAYhJ7oGPgcirtahPJHI/+3xS9NzqLsZV
   PkPXBi8LQ5xs5WSau9X7dpBvgcjPnx8UNxrbxE/CLP6X7r2/GFY26s2CY
   IUoTcPctMDgBxAe46TUHUFQbUeHllDiYHhDrZi9Tw85FjOH2/ii9vW7F/
   Q==;
X-CSE-ConnectionGUID: jIfPZeLJRgGwhyLpCi0JqA==
X-CSE-MsgGUID: 2WM1B08CTAqvQLXEBOEE+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="23379158"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="23379158"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 07:56:00 -0700
X-CSE-ConnectionGUID: PQyEoeBmTzeqKwjBKN+lLQ==
X-CSE-MsgGUID: xbphoxMSTMWyOOhm8FKp4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="53381865"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jul 2024 07:56:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 07:55:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 07:55:59 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 24 Jul 2024 07:55:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 07:55:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFlNVm8AIwGJQ3fCuvJROnP9o/GTXeVw6GduZJqf4zARGnnU+P7yA0sOw4E/GuuBzKTwHDtGEs3olSYsVpft7nTxi35qHHIpV/q/8rzL8lXp3b9hUmfRPZcq8ZamPizKY41yuVji/bT3UaWKhrVEy6SiWMdnZbszdrxbJLfRzSKMKxMRke3CLMXt2mANUhuxqKjgFv4ObSmJsP3g6NhgALpqqeqHg+2m/WtrwZxeC5Xy9sPlx23Q2gOP5/E6RawfHgy0/FTUq4kjEdHCam+KtaBNtrZ6yYHku/UvvopdW3RuOI5F3f/hDflUOx8lOF+uXZnHndUDjHEhzGvgdmvZSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUT2sslUuc5kuDfmE5UB3TiHWd5KutsZk+zR1BjlIOk=;
 b=jS5BF12mT4vvV0GDIGU7pUdY2jWD3TGtrSvFHg2nrNY1gK697V6s9FRh3Kp1LXlEh+wpqQCoDZfKdgu0fPMGQ+oj92xq7v5SYdoBmMKz2mi41GzMFXwAqGUscpjpqQ2x138JdQuSayZd9bu9oyJzp8dlJ80hMeXxX7ek1tbIyLqRpxoDn/+HnosluYyw5kq9Vf83t1svMiaN+Jdsg8GBDobVdPTvoTaM78kBqQXjj6MnQeZaCLTCI9iTSIPvEK4kxOoTLJhvjo1uVHdSUQFVSI9Ly+Nkv9ZzBn4fjgEd3F3JlxFYegfQrees6hPTArrHYxCkpo+4gQyadkkYpYq0TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ1PR11MB6177.namprd11.prod.outlook.com (2603:10b6:a03:45c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 24 Jul
 2024 14:55:55 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7762.027; Wed, 24 Jul 2024
 14:55:55 +0000
Date: Wed, 24 Jul 2024 22:55:42 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Changbin Du <changbin.du@huawei.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Arnaldo
 Carvalho de Melo" <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
	<adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, "Nick
 Desaulniers" <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, <llvm@lists.linux.dev>, Hui Wang
	<hw.huiwang@huawei.com>, Changbin Du <changbin.du@huawei.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v5 8/8] perf buildid-cache: recognize vdso when adding
 files
Message-ID: <202407242254.98492680-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240702041837.5306-9-changbin.du@huawei.com>
X-ClientProxiedBy: SG2PR04CA0174.apcprd04.prod.outlook.com (2603:1096:4::36)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ1PR11MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b303a3b-116e-4865-53f7-08dcabf0b866
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tgo4linNJTdPC/Zv9mPoGujFEi8oyWOGQdLWer3MAkcA4X99PtDRwzvyU/NN?=
 =?us-ascii?Q?/yZFx9FFvabv/wbZV4GDHZ2k75TgpS/XJv77Z5ddJLzSfcVKfN0PrNw469od?=
 =?us-ascii?Q?n4FhcNmjWWv/wsXMj93rrM3SIpC33wLayavdubm5QQmAKiG8qLdSCdXU/FRz?=
 =?us-ascii?Q?+hlDnB/UhXjN9tyDWeGb/MG0EEmkW3NPDuDUwiGI/UjTbdQKeC44cK2Yw1pM?=
 =?us-ascii?Q?Bx5qC6UfZObOyX14O7589uG7Kbjzh4KypPNvX0I2c/snechI5x/wKkjXOJz1?=
 =?us-ascii?Q?hOlKCkNtih5CwRtBRdA1zwFdHznV06bfPmLd8tj8mQVxHKm+8GH2zuThMfUg?=
 =?us-ascii?Q?nzMKFA7bilj1J9U/Q7H2iHQg0BK7kjte3Mj2MMwXZfyzpKyiZ6OegSLDQO5m?=
 =?us-ascii?Q?G0o8ZP2DODA8Q/Yteh8TRbWO2ftFvAiHyrb1JZLwKZh/TrLgZd+5ymVSfKay?=
 =?us-ascii?Q?Ur5CfyJBGqrOkvhvy48Vr2WhB94mlSa7FxYoRWHN7xErrTQ4fylPkCLb+Nky?=
 =?us-ascii?Q?vxikUAThtXC0AjGEhiwYMq7Ov/9GOBxwmcW4Qc84N9TfR8mbwqnsxLMbDdbH?=
 =?us-ascii?Q?J2ShqU/ymap0WZ+gftF3ZbCC5zQ2klwHQ75CLLPZOlMvgkU5/XDVULdo2isp?=
 =?us-ascii?Q?qXGzL2uViZbZNqKC34WmhcubSDeqOoQbpm4WDE7KNysGboqzBsB/TOnSrX/t?=
 =?us-ascii?Q?8yqMeDdPG5111Dv3lEcnUSu2KnVKMD5u8UmJ2Qr8iRsHB31A1BVMIVK3H5Je?=
 =?us-ascii?Q?Q/u9xbiG1RiGHGW6AOGsA8UUOFegY578ij533A0mtxUL67W/F/01Uf0VxRJQ?=
 =?us-ascii?Q?+fshJTEoL+f3gKVJNMx3+npfBV9LLQePzxLBOEOxHORxzT7WsCG3dUKR5oFW?=
 =?us-ascii?Q?9K6pl6bGVKQXkGTLBnkvW5eHWpx61c4pQgtgvwRJSmstiRwaZ+1z0s1qiZeZ?=
 =?us-ascii?Q?wR5qd69r6drWuIY28/iwy108xAfCB0OvWa+c381BLw6XJVGDFC8MhVm0zpuS?=
 =?us-ascii?Q?Q2jJVOcnS2E0xIuF35Iebh2DlfgSUYHLO61Q3ypk1CI+9ofJ6zHK24HuWw8A?=
 =?us-ascii?Q?Dxyj17TNB7D5AkvTfQ2A625HFcPP22p+/YRXdpRJYxeGIqs0UN5K7x5WGFew?=
 =?us-ascii?Q?Xn3ihX4KOzrF0VKPs5Jsh6xaaPNyuGLis+6qpoiBKMr/T1nwvkBWTGzYByJK?=
 =?us-ascii?Q?7xgeC2Q3nx4PpVA7Pl9kGeKRovQ1plldZP4RvXIDXtqXMZ3HZ67mW7JO51gi?=
 =?us-ascii?Q?H6fdCAR98eqPbwIpiXA2+W2sLZxI+IAI4AX19nJMQ4OqrLA/suiUf+TbgMC1?=
 =?us-ascii?Q?lMHx8at3uFbB0bvT/7dMq91A?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l2lBaEgFa2aR5GUEpVr6PB91SKw9GPC9xmVIBBW4UObvMur5HM3fT+ClOxNz?=
 =?us-ascii?Q?QtaoWjO39z/692QMSGEZKarUpUOdlwF5vyltcoMguWzcHJ3qE2UDIdorWyXM?=
 =?us-ascii?Q?FUOTDjVXu/C9dLr2BtutOLEcS+sy0mZPiOh5JsUkhHlyoPw/1+qVpdBVjqjp?=
 =?us-ascii?Q?SMqUI8aWjcI93It2EI/THpABqKXO/Wll04HRrrVg/ErdBjLo4chYDukxDg4O?=
 =?us-ascii?Q?3xWd1PsfMvniW2Fbmvd+U2TvGtjqT6GcaX2AWXW03yezUep24fBvlAxHVkAf?=
 =?us-ascii?Q?QqnPMfns1g6+FmfjN9/0KDhOmFLz6xveL4pnIVa/oN7057wM/pBKqguXc1fz?=
 =?us-ascii?Q?frMEkZWdaKr1xirUNwXpbtrIKDr7ejh1x4uImadyNMPvszeWtQsHoMSD+HhT?=
 =?us-ascii?Q?RR/T2U6tGaMfTnplKqNJ+cros6gwhtgw/DUf/YE4yGoptQ4AjinkYXoVci58?=
 =?us-ascii?Q?dt4p6JRB8tiBufvil64jo8JleewM7gg8f/8ESK359m0S+hqTgPcYd7dYrzIH?=
 =?us-ascii?Q?jdmR7PqxdMu/s448RgbY0rJD+LIr7cO5/eLcDEu9kyzNqPn4dsT4ucrw6FcI?=
 =?us-ascii?Q?C1CEw4IBZEZFLym8nSU1TvGeYIA3n2TfPlPfPfcgAjBkINxmF9lszfUMkv9t?=
 =?us-ascii?Q?FHDQdoGaCijmbe19kl4cL6newl1M7m7MieLmoyxPNnC9lL0n6aPUIyMhVE9c?=
 =?us-ascii?Q?gCRT04pgEslxoIH9YRpPlIPUUyGgAreG19UBTrDLkWbfheyNxBomOZ4tsEu5?=
 =?us-ascii?Q?DcTgjSOiu7RgZTbwQ4WzrQFEPT+VuzzXO9UXIQIt0yw+iP3nfffs5+9SXEto?=
 =?us-ascii?Q?+45RzkmLjLDlfaNYU3rO/x5PLDYs4DQubkr6Tfu324ALAvSUpNP6hvimibKs?=
 =?us-ascii?Q?Vs5RIw/oj6ysfIvi0epv1ikjQpEtj5MzPuQuHcNDS6wVfGdinReojZGHirgj?=
 =?us-ascii?Q?AmUS07y/UExRF6er9LlQyj6cZQiZpBoA4eKNVoceqao0x7s1L7Sggd7ZuS4E?=
 =?us-ascii?Q?XBbbHXGW9ZBBvE58Gk58IPhQka7nG9yPuh06kMYJed8x1DV9Zuo3ncrg4MAV?=
 =?us-ascii?Q?anGShc8E6OpDDUhkCqx5YyjBP1wPsfKlIwQWY0AlQzO5c+dTpSUJ3D8Fq2Fz?=
 =?us-ascii?Q?vIvTj6kRIPE5UVEDEtPo2fU8PvnrXmzwU8e4izpRPp/en4LjAk6CjQuY2W7N?=
 =?us-ascii?Q?YTuLTXavycXLTAdOTC2Cg/gXIdSkVUPpgtg5aUyQN44J5mcSvEUIHo63z59e?=
 =?us-ascii?Q?QsetJbCdj2BjMo0fsR9/iJE/HGqndILGF7LrhZw8NArfMJX4RC6h1p5LyfsP?=
 =?us-ascii?Q?D1kFua1xSCotZdB+WTZN0GQ/YGmu0dW1LikL+zclHuA+tIdyZ1zpilxHsGbd?=
 =?us-ascii?Q?IQeDmXFkVxTEYmYHxzXxTcBe5waeTYu34UchiCr6Y+wC84peYeGLZvgUeBsc?=
 =?us-ascii?Q?HKUhytxdOmmjPqHL3/LFJ8lf48fBWgJ6GnBLZ4VDx6iyUc44VJ56JNr+3BFJ?=
 =?us-ascii?Q?1IiAidQnUsF+lkwIhdGoTlr/lVLYhl368g/FrNmIbvBWnN/kwUga6Z1qHSy1?=
 =?us-ascii?Q?9gW2AIopCp37ODCk3Muxmpqg502AgTHGB8W1O1UioOo2HdMO5i7DG1jtiX/b?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b303a3b-116e-4865-53f7-08dcabf0b866
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 14:55:55.5726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8SGOxJvpo7ooRsry6disNdyQR/oOyF1H5Ez/mcfCX0nJuydWHKcmaXOKnDWt3LGSwT0L+Kn3SACF3X6ESnDGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6177
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "perf-sanity-tests.build_id_cache_operations.fail" on:

commit: f715cdcabbfb1d34e86b0a2cbb700d690308d724 ("[PATCH v5 8/8] perf buildid-cache: recognize vdso when adding files")
url: https://github.com/intel-lab-lkp/linux/commits/Changbin-Du/perf-support-specify-vdso-path-in-cmdline/20240702-122209
base: https://git.kernel.org/cgit/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link: https://lore.kernel.org/all/20240702041837.5306-9-changbin.du@huawei.com/
patch subject: [PATCH v5 8/8] perf buildid-cache: recognize vdso when adding files

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: gcc



compiler: gcc-13
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407242254.98492680-oliver.sang@intel.com



2024-07-18 05:11:32 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-f715cdcabbfb1d34e86b0a2cbb700d690308d724/tools/perf/perf test 78
 78: build id cache operations                                       : FAILED!



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240724/202407242254.98492680-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

