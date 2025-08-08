Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBED22126D;
	Fri,  8 Aug 2025 06:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754633497; cv=fail; b=robCHA06oLEkwXVAip42aN8NCdLPVFOKmX0oEOzSzaPrF3/a9S2J2/m8mQYDwCqX52rOo4T/+KLwpd4YWdFLt2ObVbLhvOngT1awOLhax8enWAZYnsjYOUK7cFY7IGqHiF6LkSkK5Dm0bsrPXUEPIC1jm5s/Ksgy+5oN0rnVLHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754633497; c=relaxed/simple;
	bh=B+rqFpe77O7Z7B2Cy/1UMbzFvlJx4zgRSRqQMFCufk4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l8EL1E5bt/9zBxYnX3omB/3u/YnOMfJpD0YmXPaOBBgN8TNo559EhBIim/zuBE+bJDMCvZ6xKvPpjgE8EKEQyWpvIABAywX9OS+KnsKRi33rmMUgSnUOBW/r20duZHKkCp/ErX8LY8/LUHL4bnWMiYirOYIs4f+f6Ve6mLF3xjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hu6h+Ix9; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hu6h+Ix9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754633495; x=1786169495;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=B+rqFpe77O7Z7B2Cy/1UMbzFvlJx4zgRSRqQMFCufk4=;
  b=Hu6h+Ix9lFjrVEVjYpVja8BOqBXWu1o/DyS4Uy20cwJeMN2PzBfcEI1i
   bhRbUcPGl3YTqtoGxpiWF67tgYRJBL6qHx+uUf5DpCOBj9hGTZ1BaML/F
   rzqudcpUMj2xfnQu/8MV1D87WAfPc4WYzvg5kwcXNM2mv1VeYS4jnI/ua
   sHemMLaahFtulCXuPcwKvLxfNRtlWBdNvCl92jVJ2enuh1T5Mdjjpemid
   LbnX4ah9t4C+4Rhs8OS3j+naJt4PhmqrDDItdbpO/1Js0ubhM46vVIlqS
   n7WRIEWo3mv7tYzpGhHWkoP6NJJ/xgL0u8pOGFTov0t6s30DKX57rBweP
   A==;
X-CSE-ConnectionGUID: 1n2Y0QMvS/6utcqFV00M0A==
X-CSE-MsgGUID: WY+mFjosREatzzD3QfqU2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57118444"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="57118444"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 23:11:35 -0700
X-CSE-ConnectionGUID: hIVq6rMVR+aoPNWJnOY8+A==
X-CSE-MsgGUID: vOxyOhAvSmmar5fd13w1Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="202420724"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 23:11:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 23:11:33 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 23:11:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.58)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 23:11:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yG3RIrlJp+hgvmMgclbehZhzMtfMZsGQXF8I0yA+jhhlQ7ziPccaWWpYPB07HhtXoQPCiMAhfmkl63n0f18bTuL9YAaMyNVARZ75ix9XnEC+hlI0zFyeKdwAZ/YcL4k8+xkVHU0VoRzp/KGYqC3mMX5fNc/QNZnGF5gynXNX9d8JQRCjc7Vq4YeU1iUKmTrRCri1CcDcM7JfQ3l2btFpo8FfLrPKOm2H/yf7dpIZJpDIuVgq5J0EfHuzoH7LQdiQ4VwpaGPpVBKLPclQuLC+VHRGQVx4riQgKvIOPH4T5dmEs9yS7A4tjtt/NtsDiDx85IlVLzLvLJ7i3+Cfwo16zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D01V9RilzvSmB7lexaPB/p3swRGKQ845bmt6/QL0hlo=;
 b=vpdaQxC/8GzeFoyHywrLmhxerB5PeZc9NrRT8YhQZtzfU87Z797LLMpqWYzp8BRQ2VT/AutQK1e74/6f0Cf3spD82l8/ZN6fnpZCLwxF9gO7BuVGcBDlnCQYKyCbzlob6ZySh6NUg4P3QbZ2A6WSDA5i5sQEiCsN41XWyF0pDVIVuCKTIypn8NL+mVQjXZRp/UVlaMjdtFrTS6QdzAbM2evAWSpAmSYJ2RMtilEhDmuDDZfd1hvYuW7rByYbrMmuEvQKl3zr32nXC/ZZ/PGLxKipMTQkbS7+2h8C+AVocaj66T35fkL2YgduoiuFoROInyoO76/ChqpSRi45PmRitw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA0PR11MB7158.namprd11.prod.outlook.com (2603:10b6:806:24b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 06:11:31 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 06:11:31 +0000
Date: Fri, 8 Aug 2025 14:11:16 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yuzhuo Jing <yuzhuo@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<xudong.hao@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>, Yuzhuo Jing <yzj@umich.edu>, "Yuzhuo
 Jing" <yuzhuo@google.com>, Andrea Parri <parri.andrea@gmail.com>, "Palmer
 Dabbelt" <palmer@rivosinc.com>, Charlie Jenkins <charlie@rivosinc.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Kumar Kartikeya Dwivedi
	<memxor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Barret Rhoden
	<brho@google.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, Guo Ren
	<guoren@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v1 1/7] tools: Import cmpxchg and xchg functions
Message-ID: <202508080716.5744484-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250729022640.3134066-2-yuzhuo@google.com>
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA0PR11MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cfa7f09-fd2b-4237-629b-08ddd6426b4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFp1Vjd5S2t3NnZLTW9VM0lKRHJOb0V4SEZLeWVEajlhS1o2dXhjSEtYZjFD?=
 =?utf-8?B?a0NMQ01CZ3g5aWRNbkJXR1hRbExpZWx5MHRXK2c4UytwQVY1VzFrOVc3bVEy?=
 =?utf-8?B?N0Z4MmZiYVNhNnZUNFRheHlDelRXRmZPOVltbEZXVS9HWVR1MkE4SGJUVlBs?=
 =?utf-8?B?bytDQjM4WGZEWFRJZFJRcjV5d0hmWTRYU2lEOHV6NWM5T2Exd1lRdVpNa01m?=
 =?utf-8?B?MmxBaEp2SGVyR3FDOWp1czI3TEo1SmlmbE1KdEFuWTMrNVd0eFZGcCtuWTJM?=
 =?utf-8?B?RFRNeHdHRnpzZnVPZXo3bmZsVXVSV1RJeit2M1BuajI0Unc5d3FrdmhYbVEv?=
 =?utf-8?B?Mk9icHRHMjg4dlFYaVJvUzhlZUhncWZzU29leXZ1UEhkMjdEMmdDZEVob0F6?=
 =?utf-8?B?SFJOTXh4TjFOVWtUd01jWkYzV0FYRlI1UlRTb0wwbnZVRVJqQlAzaitzRDYy?=
 =?utf-8?B?VDFLSXduTUZFN3laSE85Uk9PVVA0WG9HRVFybGhzWWRDVEhtK1lqS2IvYWF5?=
 =?utf-8?B?T2xScjBIa0RIMzZuNElyNllwcGNuYm5QNGZsdUNIRGRkcGFLcHluZjBqRTMy?=
 =?utf-8?B?SmYvQjdXZHRyOUJlZTY4TDd0bFNhd1lOSnZrcGZZZXhmQ0R4aC9HMWhjY2J0?=
 =?utf-8?B?ak9WczQveFYvR0V2aVROdlhzVFM3VmxuazU0L2xJcWU4NTJUbUljWC8yVzls?=
 =?utf-8?B?VWRoMHNOazFYdTdwNFR3dlBBSGdrVUNKZXFpTC82R3NxTXovaDU2Qzk4T0Fl?=
 =?utf-8?B?MjZJQUQwdU1lanBtamU3SzRpc1lKbWlGZTNyWHFUMGJ4SnBMZWlvVEJYNkhk?=
 =?utf-8?B?WUdDeWUvRFBWNFRvdXV2dHREVUVIN21sNGNBbE55aXZzdWtDLzVDOXdXV1gr?=
 =?utf-8?B?c3ZaeEQ1NVo3b0xMTERCQytSanJaVjVzZWsvZnhUZ25NRjh1WDdrbFF5emE5?=
 =?utf-8?B?bmZjWUtqbm45K01XejEvSVkveUlGSDJZQlYzNFBPTzMwb0hSUW5DSjk0aytU?=
 =?utf-8?B?cjNLRVc5dWkrblhsMzBPMUpMSHlwR1VzTldXdnFiMkRrT1RjbjUxN1lCWG9i?=
 =?utf-8?B?MnJLTWdzRUZjQytJenAzZ0oxNWdDVUErM2xVeFRZaUJmVU1RNVpMelpoOTlR?=
 =?utf-8?B?VXZjcjllMnVGanlPb1cyOG1rZER0MUVrYjQ1ekNRVFdzeUdXT3pWRHN3QTg2?=
 =?utf-8?B?bjJIc25zWjhFNXJjeHhmYVdHanVQajhnU204Q1cyNXNWRVA3SVJFTWlYZjJs?=
 =?utf-8?B?eWxLanVDRk52OGJYSlZUYms4VnFVZVpDOUtMb09jaUlrWi9MalBza0ZHVGI2?=
 =?utf-8?B?QVJBT0NxMU94MWhSNFpCMU9KeFBlQWlkMWRJQUVxUTkvdlpDQWpqOW1ObFRt?=
 =?utf-8?B?UHE0QWwySlZVMVVmK2Nxa0RhaHBrMnRITG52VnJOODRvOU8waVlpOVpIUmlr?=
 =?utf-8?B?c1Z6clU5endaQWlsVXVKN0dXSVFOcVYybFF2bHhGUFBIMk4yYm1kZFo5UjhD?=
 =?utf-8?B?QmF6SURQRVJHSjFDQ2cyRXJ0a0dVSHNxQnVCLzJpMENZQmluWkpTaXFIcm9W?=
 =?utf-8?B?S1h3Y1M3Nkp0SzdhcDV1RkFvMFM3cU1pZkRiekRxRmI2dkQwSHo3b2lsZmkr?=
 =?utf-8?B?dTlJWk9DS3dSOTE5cnBzTGxuNXlJVWNQZHBSUDBJTkliVTBPNkRpc0ZmWWZM?=
 =?utf-8?B?cE5tWHAxemdtWURlUmtoblErcElBb3NtbVFISVZBQVZ4a05wMXVncExlb1Fo?=
 =?utf-8?B?VGVmMzR0Z3A2OThTZjZZUFFKc2pKK0ZTKzduY21XSXdYTDNCM0ZlMnBvMzJR?=
 =?utf-8?B?ei94cTNsbzl6OEp3VnZmR0lHYkZmMng5OFl4QkV5bEQwRGYzcElSZTN5czZU?=
 =?utf-8?Q?SltVgd/AITVEn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFh0RGlGYXM3WkI5S29rMzBVOWp3SDVyVHluRnVrc3lJcjc3SW1lRTJrZmhq?=
 =?utf-8?B?cC9Ha2JCNTlkQVJtYS8xMENrY21pSTVyZDgrVVF3OHBhVEdDZlRRdVRFMHNX?=
 =?utf-8?B?TTBBUnFTbWVRWTRFN2NQVzVFdkE3RmM1Z05LYVhQM2JQY0hRL2NOVVFXK1FJ?=
 =?utf-8?B?b3lrV1Q3elBPY0pMbFdPb3VYdmZocGM1NFJJNzhseityV0JUaTBndDRWdlNl?=
 =?utf-8?B?eWJTTHVqUmdGbUprVDRrVkE2ckhyZ1dVd1plNnU4NGdhK0lNdmhBc1N1YVgr?=
 =?utf-8?B?MS9uU2E3MW8vZUh1dzJKUmRkcEVHQWtCRmVONktMV3YwejJFSG9ZbkNFcUhu?=
 =?utf-8?B?eXQvRFMwWVI3eWxseHl1Z0g1cWd4bmdGRkUwRGpDVjl2SktQWkFhcWVsbitK?=
 =?utf-8?B?R2xacWIrbWJweUR3Zk1zcWpTMjhMWFBxRjJXc2FYOEJ2eEdja3N1cWZCY0o5?=
 =?utf-8?B?TUhZV1pqN2t0eENvWC9TL2hDb2tLdUxOV2QzUG5kb2s3ZUJTUGJsK0hoRWhp?=
 =?utf-8?B?Y3RJZVBFaWZ5cldiQVZ6eEUyTit1SmVabXZ3YkhiVTlPMEErMHZEeUZVekF0?=
 =?utf-8?B?NlZWNFZqSE1zWVNZMGVHc3NSM05ST0NYK0d5OGh2U0dWbmtOSEw4Z3o2VTdm?=
 =?utf-8?B?YXlGSTRJa01EWXBFMjRJUHN6cHh4K2dZZ1kxdDZsTHZOV2t6OTF0TFJCVHo1?=
 =?utf-8?B?cUVlWWt5YzN1SFV4TFlCWWV3OTN3TEZUOXI5NlFEcVlVMDF5OWNpQ1BNMHJ1?=
 =?utf-8?B?RW5pSXRhRmd6aWg2SDh0Zmh5enBNaXdtL3dCbGdXMXFHWlpBdnhLZjQ0MVVR?=
 =?utf-8?B?K0RSMjhTNzY3WkNvWXBhbTJ4c2QrdTJ6VnhTMGNEdnpSN2xoL2g4K3JDaXE2?=
 =?utf-8?B?M1RaeERqSXNWNitkeTU0b2MzR2M2MUZERGtWVkU2ZTRUQkdLWnc5Y0s5TzJ2?=
 =?utf-8?B?NUlsZVIrTVFjV1dVUElKcDg4eWswcDMyampwN0lhTk9Vd2tqTHBZWks3ZU5L?=
 =?utf-8?B?WTMxb3N4Q2VFcld3SEJkSFd4RVkrVEdsbU9BbWVlRFgvY2JwRU9GZzBTdnh3?=
 =?utf-8?B?TVU0UTRpTTVYVFE5K01IUkZkR1ZlN1ZTZ1E0ZUF3TUhOaWk5ZWpUaVR4V3l3?=
 =?utf-8?B?eFh3RzVyY1h6SloweEh0dVQ5UG1kUWc2ZVBESmxORUxhc3F4cnB3SDh4Z0VV?=
 =?utf-8?B?WFdSWUV1QlpDSEtseFhDSmFnMnEvRGtVeVZVamxFMmUzcklISUloTmZFYTV6?=
 =?utf-8?B?VUhhKy95ZlU4OVhtK09YRTEwbjNndHdnZVV3NWdyQTRFSmlmM3FKbDJhejNX?=
 =?utf-8?B?T0RvTFkyMU9sQXowZ1NkQm85ZmgyY0VrYTZKZHRXSTZONDl4dHl4eHJ6RlB4?=
 =?utf-8?B?eE5EWnFiTWg1WFk1SjFDem9oaTN6cWJhYm5DbElpMXUrbGtVbjV4cm9pdUl1?=
 =?utf-8?B?eDZtYXJxd0FuWlh0alljdDM1TGd5NVpVdis4UE44ZmsvSk9aV1RRbjZoakxz?=
 =?utf-8?B?MWdrS1hqeTdEUFRJK2lwYkdtTXBlNnBvZThmRHJ0RWd2L3lFRDlVWDkwbFpa?=
 =?utf-8?B?RWl6WDNTSTVlNy9HMEhCdXJ0azZWSE8zRVp0QktBTjZHR1JLaGdjVWROVUpY?=
 =?utf-8?B?Y0ZORzBybDVUdjM4RVVYa3F4d29xSlgzT3lGUm9XVFBQTXdKVmxCVWFVVS9w?=
 =?utf-8?B?KzVUT09TWHdzVlNWTElVbDlQeU1kalRKQTJMRVo4T2Urb0YrbVNwbzRLKzFV?=
 =?utf-8?B?VkpKWjk4dm8vb3JGekZOd0hnc2tHSUJFY21mRmszWFlIR1FjRFZtbURqbkZh?=
 =?utf-8?B?TXd3MGFZdTNmOVNYUk5OWElxTnVGNlRzOHRpdGMxVzFlV1dNd3FnWEgxS1Aw?=
 =?utf-8?B?NDNsUVU1RzQ2d3NaMmVONmorN0NLMjgvU0hsalZ1Ry82ZmhrN0h6ZGpzRmI2?=
 =?utf-8?B?M3VYRmcrVUZLRkU0S0E1YW9VRXVhNHRMcFJnZTkrKzhtTU1RUWg4LzFtUUZj?=
 =?utf-8?B?WWZ1OXJDRG0zaWxaS01qYkdZVzJsdnVkWjh1eXM5a05NYVhZUnJnMjFpd3BR?=
 =?utf-8?B?UFdlcUhFV0JFRXBrVEw2VDVZNUU1QzdvekZyTnQzc0RZRzM3NThJWnRMQTMx?=
 =?utf-8?B?S2xhU2xSd3BCNWJ6TldwUDNIV1ZZMzZXdWFtaXBNU3R3ajI1MVJNM0xGMnFJ?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cfa7f09-fd2b-4237-629b-08ddd6426b4b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 06:11:31.4518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p51rJIlE3137GkWqG8y+xz4aXjF3ZuGlaypwnCv/Q6p+veP7eX3l9Iph05u/z1xAJOV8o8HTSrYIiVLa/sDCXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7158
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.kvm.make.fail" on:

commit: 108c296547f3e749d89c270aa6319894f014f01c ("[PATCH v1 1/7] tools: Im=
port cmpxchg and xchg functions")
url: https://github.com/intel-lab-lkp/linux/commits/Yuzhuo-Jing/tools-Impor=
t-cmpxchg-and-xchg-functions/20250729-102940
base: https://git.kernel.org/cgit/linux/kernel/git/perf/perf-tools-next.git=
 perf-tools-next
patch link: https://lore.kernel.org/all/20250729022640.3134066-2-yuzhuo@goo=
gle.com/
patch subject: [PATCH v1 1/7] tools: Import cmpxchg and xchg functions

in testcase: kernel-selftests
version: kernel-selftests-x86_64-186f3edfdd41-1_20250803
with following parameters:

	group: kvm



config: x86_64-rhel-9.4-kselftests
compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphi=
re Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508080716.5744484-lkp@intel.com

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-9=
.4-kselftests-108c296547f3e749d89c270aa6319894f014f01c
2025-08-05 10:05:53 sed -i s/default_timeout=3D45/default_timeout=3D300/ ks=
elftest/runner.sh
2025-08-05 10:05:53 make -j224 TARGETS=3Dkvm
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-9.4-kselft=
ests-108c296547f3e749d89c270aa6319894f014f01c/tools/testing/selftests/kvm'
gcc -D_GNU_SOURCE=3D  -I/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-=
108c296547f3e749d89c270aa6319894f014f01c/tools/testing/selftests/cgroup/lib=
/include -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno=
-gnu-variable-sized-type-not-at-end -MD -MP -DCONFIG_64BIT -fno-builtin-mem=
cmp -fno-builtin-memcpy -fno-builtin-memset -fno-builtin-strnlen -fno-stack=
-protector -fno-PIE -fno-strict-aliasing -I/usr/src/perf_selftests-x86_64-r=
hel-9.4-kselftests-108c296547f3e749d89c270aa6319894f014f01c/tools/testing/s=
elftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-9.4-k=
selftests-108c296547f3e749d89c270aa6319894f014f01c/tools/testing/selftests/=
../../../tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-9.4-k=
selftests-108c296547f3e749d89c270aa6319894f014f01c/tools/testing/selftests/=
../../../usr/include/ -Iinclude -I. -Iinclude/x86 -I ../rseq -I..  -isystem=
 /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-108c296547f3e749d89c270=
aa6319894f014f01c/usr/include -march=3Dx86-64-v2   -c demand_paging_test.c =
-o /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-108c296547f3e749d89c2=
70aa6319894f014f01c/tools/testing/selftests/kvm/demand_paging_test.o

...

gcc -D_GNU_SOURCE=3D  -I/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-=
108c296547f3e749d89c270aa6319894f014f01c/tools/testing/selftests/cgroup/lib=
/include -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno=
-gnu-variable-sized-type-not-at-end -MD -MP -DCONFIG_64BIT -fno-builtin-mem=
cmp -fno-builtin-memcpy -fno-builtin-memset -fno-builtin-strnlen -fno-stack=
-protector -fno-PIE -fno-strict-aliasing -I/usr/src/perf_selftests-x86_64-r=
hel-9.4-kselftests-108c296547f3e749d89c270aa6319894f014f01c/tools/testing/s=
elftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-9.4-k=
selftests-108c296547f3e749d89c270aa6319894f014f01c/tools/testing/selftests/=
../../../tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-9.4-k=
selftests-108c296547f3e749d89c270aa6319894f014f01c/tools/testing/selftests/=
../../../usr/include/ -Iinclude -I. -Iinclude/x86 -I ../rseq -I..  -isystem=
 /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-108c296547f3e749d89c270=
aa6319894f014f01c/usr/include -march=3Dx86-64-v2   -c pre_fault_memory_test=
.c -o /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-108c296547f3e749d8=
9c270aa6319894f014f01c/tools/testing/selftests/kvm/pre_fault_memory_test.o
gcc -D_GNU_SOURCE=3D  -I/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-=
108c296547f3e749d89c270aa6319894f014f01c/tools/testing/selftests/cgroup/lib=
/include -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=3Dgnu99 -Wno=
-gnu-variable-sized-type-not-at-end -MD -MP -DCONFIG_64BIT -fno-builtin-mem=
cmp -fno-builtin-memcpy -fno-builtin-memset -fno-builtin-strnlen -fno-stack=
-protector -fno-PIE -fno-strict-aliasing -I/usr/src/perf_selftests-x86_64-r=
hel-9.4-kselftests-108c296547f3e749d89c270aa6319894f014f01c/tools/testing/s=
elftests/../../../tools/include -I/usr/src/perf_selftests-x86_64-rhel-9.4-k=
selftests-108c296547f3e749d89c270aa6319894f014f01c/tools/testing/selftests/=
../../../tools/arch/x86/include -I/usr/src/perf_selftests-x86_64-rhel-9.4-k=
selftests-108c296547f3e749d89c270aa6319894f014f01c/tools/testing/selftests/=
../../../usr/include/ -Iinclude -Ix86 -Iinclude/x86 -I ../rseq -I..  -isyst=
em /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-108c296547f3e749d89c2=
70aa6319894f014f01c/usr/include -march=3Dx86-64-v2   -c x86/nx_huge_pages_t=
est.c -o /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-108c296547f3e74=
9d89c270aa6319894f014f01c/tools/testing/selftests/kvm/x86/nx_huge_pages_tes=
t.o
In file included from /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-10=
8c296547f3e749d89c270aa6319894f014f01c/tools/testing/selftests/../../../too=
ls/include/linux/bits.h:34,
                 from /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-10=
8c296547f3e749d89c270aa6319894f014f01c/tools/testing/selftests/../../../too=
ls/arch/x86/include/asm/msr-index.h:5,
                 from include/x86/processor.h:13,
                 from include/x86/apic.h:11,
                 from x86/fix_hypercall_test.c:13:
/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-108c296547f3e749d89c270a=
a6319894f014f01c/tools/testing/selftests/../../../tools/include/linux/overf=
low.h:31: warning: "is_signed_type" redefined
   31 | #define is_signed_type(type)       (((type)(-1)) < (type)1)
      |=20
In file included from include/kvm_test_harness.h:11,
                 from x86/fix_hypercall_test.c:12:
../kselftest_harness.h:754: note: this is the location of the previous defi=
nition
  754 | #define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__=
typeof__(var))1))
      |=20
In file included from x86/svm_nested_soft_inject_test.c:11:
/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-108c296547f3e749d89c270a=
a6319894f014f01c/tools/testing/selftests/../../../tools/include/asm/../../a=
rch/x86/include/asm/atomic.h:79:28: error: expected declaration specifiers =
or =E2=80=98...=E2=80=99 before =E2=80=98(=E2=80=99 token
   79 | static __always_inline int atomic_fetch_or(int i, atomic_t *v)
      |                            ^~~~~~~~~~~~~~~
/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-108c296547f3e749d89c270a=
a6319894f014f01c/tools/testing/selftests/../../../tools/include/asm/../../a=
rch/x86/include/asm/atomic.h:79:28: error: expected declaration specifiers =
or =E2=80=98...=E2=80=99 before =E2=80=98(=E2=80=99 token
   79 | static __always_inline int atomic_fetch_or(int i, atomic_t *v)
      |                            ^~~~~~~~~~~~~~~
/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-108c296547f3e749d89c270a=
a6319894f014f01c/tools/testing/selftests/../../../tools/include/asm/../../a=
rch/x86/include/asm/atomic.h:79:28: error: expected declaration specifiers =
or =E2=80=98...=E2=80=99 before numeric constant
   79 | static __always_inline int atomic_fetch_or(int i, atomic_t *v)
      |                            ^~~~~~~~~~~~~~~
In file included from /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-10=
8c296547f3e749d89c270aa6319894f014f01c/tools/testing/selftests/../../../too=
ls/include/linux/bits.h:34,
                 from /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-10=
8c296547f3e749d89c270aa6319894f014f01c/tools/testing/selftests/../../../too=
ls/include/linux/bitops.h:14,
                 from /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-10=
8c296547f3e749d89c270aa6319894f014f01c/tools/testing/selftests/../../../too=
ls/include/linux/hashtable.h:13,
                 from include/kvm_util.h:11,
                 from x86/userspace_msr_exit_test.c:11:
/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-108c296547f3e749d89c270a=
a6319894f014f01c/tools/testing/selftests/../../../tools/include/linux/overf=
low.h:31: warning: "is_signed_type" redefined
   31 | #define is_signed_type(type)       (((type)(-1)) < (type)1)
      |=20
In file included from include/kvm_test_harness.h:11,
                 from x86/userspace_msr_exit_test.c:9:
../kselftest_harness.h:754: note: this is the location of the previous defi=
nition
  754 | #define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__=
typeof__(var))1))
      |=20
cc1: note: unrecognized command-line option =E2=80=98-Wno-gnu-variable-size=
d-type-not-at-end=E2=80=99 may have been intended to silence earlier diagno=
stics
make[1]: *** [Makefile.kvm:299: /usr/src/perf_selftests-x86_64-rhel-9.4-kse=
lftests-108c296547f3e749d89c270aa6319894f014f01c/tools/testing/selftests/kv=
m/x86/svm_nested_soft_inject_test.o] Error 1
make[1]: *** Waiting for unfinished jobs....
In file included from /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-10=
8c296547f3e749d89c270aa6319894f014f01c/tools/testing/selftests/../../../too=
ls/include/linux/bits.h:34,
                 from /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-10=
8c296547f3e749d89c270aa6319894f014f01c/tools/testing/selftests/../../../too=
ls/include/linux/bitops.h:14,
                 from /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-10=
8c296547f3e749d89c270aa6319894f014f01c/tools/testing/selftests/../../../too=
ls/include/linux/hashtable.h:13,
                 from include/kvm_util.h:11,
                 from x86/sync_regs_test.c:20:
/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-108c296547f3e749d89c270a=
a6319894f014f01c/tools/testing/selftests/../../../tools/include/linux/overf=
low.h:31: warning: "is_signed_type" redefined
   31 | #define is_signed_type(type)       (((type)(-1)) < (type)1)
      |=20
In file included from include/kvm_test_harness.h:11,
                 from x86/sync_regs_test.c:18:
../kselftest_harness.h:754: note: this is the location of the previous defi=
nition
  754 | #define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__=
typeof__(var))1))
      |=20
In file included from include/kvm_test_harness.h:11,
                 from x86/vmx_pmu_caps_test.c:17:
../kselftest_harness.h:754: warning: "is_signed_type" redefined
  754 | #define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__=
typeof__(var))1))
      |=20
In file included from /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-10=
8c296547f3e749d89c270aa6319894f014f01c/tools/testing/selftests/../../../too=
ls/include/linux/bits.h:34,
                 from /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-10=
8c296547f3e749d89c270aa6319894f014f01c/tools/testing/selftests/../../../too=
ls/include/linux/bitops.h:14,
                 from /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-10=
8c296547f3e749d89c270aa6319894f014f01c/tools/testing/selftests/../../../too=
ls/include/linux/bitmap.h:7,
                 from x86/vmx_pmu_caps_test.c:15:
/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-108c296547f3e749d89c270a=
a6319894f014f01c/tools/testing/selftests/../../../tools/include/linux/overf=
low.h:31: note: this is the location of the previous definition
   31 | #define is_signed_type(type)       (((type)(-1)) < (type)1)
      |=20
In file included from memslot_perf_test.c:12:
/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-108c296547f3e749d89c270a=
a6319894f014f01c/tools/testing/selftests/../../../tools/include/asm/../../a=
rch/x86/include/asm/atomic.h:79:28: error: expected declaration specifiers =
or =E2=80=98...=E2=80=99 before =E2=80=98(=E2=80=99 token
   79 | static __always_inline int atomic_fetch_or(int i, atomic_t *v)
      |                            ^~~~~~~~~~~~~~~
/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-108c296547f3e749d89c270a=
a6319894f014f01c/tools/testing/selftests/../../../tools/include/asm/../../a=
rch/x86/include/asm/atomic.h:79:28: error: expected declaration specifiers =
or =E2=80=98...=E2=80=99 before =E2=80=98(=E2=80=99 token
   79 | static __always_inline int atomic_fetch_or(int i, atomic_t *v)
      |                            ^~~~~~~~~~~~~~~
/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-108c296547f3e749d89c270a=
a6319894f014f01c/tools/testing/selftests/../../../tools/include/asm/../../a=
rch/x86/include/asm/atomic.h:79:28: error: expected declaration specifiers =
or =E2=80=98...=E2=80=99 before numeric constant
   79 | static __always_inline int atomic_fetch_or(int i, atomic_t *v)
      |                            ^~~~~~~~~~~~~~~
cc1: note: unrecognized command-line option =E2=80=98-Wno-gnu-variable-size=
d-type-not-at-end=E2=80=99 may have been intended to silence earlier diagno=
stics
make[1]: *** [Makefile.kvm:299: /usr/src/perf_selftests-x86_64-rhel-9.4-kse=
lftests-108c296547f3e749d89c270aa6319894f014f01c/tools/testing/selftests/kv=
m/memslot_perf_test.o] Error 1
cc1: note: unrecognized command-line option =E2=80=98-Wno-gnu-variable-size=
d-type-not-at-end=E2=80=99 may have been intended to silence earlier diagno=
stics
cc1: note: unrecognized command-line option =E2=80=98-Wno-gnu-variable-size=
d-type-not-at-end=E2=80=99 may have been intended to silence earlier diagno=
stics
cc1: note: unrecognized command-line option =E2=80=98-Wno-gnu-variable-size=
d-type-not-at-end=E2=80=99 may have been intended to silence earlier diagno=
stics
cc1: note: unrecognized command-line option =E2=80=98-Wno-gnu-variable-size=
d-type-not-at-end=E2=80=99 may have been intended to silence earlier diagno=
stics
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-9.4-kselfte=
sts-108c296547f3e749d89c270aa6319894f014f01c/tools/testing/selftests/kvm'
make: *** [Makefile:207: all] Error 2



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250808/202508080716.5744484-lkp@i=
ntel.com



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

