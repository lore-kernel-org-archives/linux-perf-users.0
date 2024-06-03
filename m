Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F10C757E0;
	Mon,  3 Jun 2024 14:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717424388; cv=fail; b=u4Ec8CCwkXIoi1k/RWvsGpWSbUEpjw1UH98D+u3eSd12L1g3tAOvOjBZMX0ir/AfSVCXQjJ2XpGFg5FO3pEx48aHVytwHeqRMB1vavgdY5kdcYahsgF8DLV8j97pKf06LgJ/tBAbBcZS6hWWccagiRNGGHFgdtst/BUhMB+kVMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717424388; c=relaxed/simple;
	bh=ybnGd2hPIRPGzRlOSfnKFDeioJoUwX9dp4z6wxrWTd4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rmBBHljN1MXnPw1H3uAQpQ+PZwNDhWcJ4kC4sppVs7HBg3aVHu9P4ELLBscwTxTtkmfkPPpgT6MoWIAIS/GKI4ofY1j6gT0VYD5+BJmOA9UlaPTsgoty2JM6oNUzc65l6veLlQDJUmsIeU4wNUf5yazoausLGfw20BXzDnOipYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lPKi+JX+; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lPKi+JX+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717424385; x=1748960385;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ybnGd2hPIRPGzRlOSfnKFDeioJoUwX9dp4z6wxrWTd4=;
  b=lPKi+JX+rktdJoc58ZmH7dupnkAImNDP+Q8vKhrpWZoIchRim2n5iZwd
   FopsNveCM7a7D2saCHKP4R1y3T+eu/u92iokPiBqI2+Zkmzc3sjoxpcfR
   3CWA0s55HYo8yvBXxZlr8t6kjyMzOoJAV3ySiYIeHgFQ43JciroTHOxEn
   W4LFZJon4ZAxs2Pe6hQhFTnT/oIZcRX0NnrT47IFXmhmOkMVKjS0WB4JQ
   vetUv59EXAVJwmKMYImtIKKeGwApFopopbhAcY89L09hMb9ajj43tWV99
   fsi566TGsXbBQhyAal0//I9ibGsRABAx03w+3W5x9r2AgiWUkfrbBiy4p
   Q==;
X-CSE-ConnectionGUID: N8FHPEubRHuB7OY2VGfmQQ==
X-CSE-MsgGUID: 0bR3FM8KQP2U2VIvoH8Mag==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="11874239"
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="11874239"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 07:19:45 -0700
X-CSE-ConnectionGUID: 5IdQDcQsQu2+z1CtWjuD2g==
X-CSE-MsgGUID: vlMYRpyOTPOYs18B6qLypg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="37350604"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jun 2024 07:19:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 07:19:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 07:19:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 07:19:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 07:19:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nu0SBgQd+f0wCCJHqewPWan/2oAiKkRr84Q9GuSSj1Uzh+7TX8ijZmf/KXEgJw3KGPmIaf/iODV00dnHfWuIxSxffzdVtPsgs/3I+au43kXDaz0AginEjjmt4Fo0nRJbc5dFBVzFS2lJHFuEQLg83sqNQ06pQEyxOkkU2JNI5YlP94qx0vfbzXzyjIQc6DNGasmPyXZBE+RJqscNGTH+7jhj43mo/pcElif76Vi/Jv4/Alo/wxGxvTD2NUlSfeA8TTguip1MASDwfs8Vyy4954nS0LD9JkHBD9SiWDcYwjKXkP9rJtCz7HiB/fNbg88j5X42mmaY0AmbyADlibaIcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cz0ACSvCbf4KEpVSu2o1jQNZuZh5UDgW9N7fESv85Sw=;
 b=ajt0BbmBx49XSniPICsg6rYzIvneeR/m+kUh9a2bpVxC58c23lwZ8oV9CnObnPUaKQR2YzjgO1DBteg72MmWKpSLjpnlHsAwhrgCneCXi65I3bkf5ufESdwIXETnVo9KFlWBiUfp96ZOZ/L8GE9t6TMmrN0MjO1S17a1ftWdqt5XLxSf3zf+x2MQn1DlgJGIOcIGDg+BFP4a65MFWL1lRXb6oHw7iWIJVNwJ2FBjilAr/q75Ud96RuXBvuwXCIXzjR9L7PiMta7GhnwYvpCSgJ8a3RuS+oPid/R1OZuSUl9HwXbYlkZhaUr2Y9BAtnEBmi0507HtJgznEaugS1eqFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 14:19:36 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 14:19:36 +0000
Date: Mon, 3 Jun 2024 22:19:24 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Ian Rogers <irogers@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Weilin
 Wang" <weilin.wang@intel.com>, Peter Zijlstra <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Kan Liang
	<kan.liang@linux.intel.com>, Jing Zhang <renyu.zj@linux.alibaba.com>, "John
 Garry" <john.g.garry@oracle.com>, Sandipan Das <sandipan.das@amd.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v2 2/2] perf jevents: Autogenerate empty-pmu-events.c
Message-ID: <Zl3Q7AtOWY8ZCcg8@xsang-OptiPlex-9020>
References: <20240525013021.436430-2-irogers@google.com>
 <202405311548.1e881dea-oliver.sang@intel.com>
 <CAP-5=fX7ZyT82=W8uSZbT7c76E5+1JaoR5-y_gcj7A_=Js1YfA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX7ZyT82=W8uSZbT7c76E5+1JaoR5-y_gcj7A_=Js1YfA@mail.gmail.com>
X-ClientProxiedBy: SG2PR01CA0195.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CYYPR11MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: f9cb178b-4d20-41f8-bf6a-08dc83d83245
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2VSZkhmYkp4a0NKYzN4SmFLR2FLZnJHVW1hbFdFOFZEelQzR3NNNHJIdFcr?=
 =?utf-8?B?QmtEcllOaFhLQTY1MmZyQmxNMjZOaWJXVjFnOWRwRmFMakJobW5KNmZvMzBs?=
 =?utf-8?B?cEJmZVJaTmt1K291SmdrbXNlUWtNcUJUTzhyakZGODMwQ0JRQkVtR0RjMkhQ?=
 =?utf-8?B?WHdkZ3FXMU0rZGt3b1Qvc2hnQjYrS0JLRlhDTThBMGhZRXJLWXFJV2ZaYklQ?=
 =?utf-8?B?dGZwa1FlOUtweHQwSHdIQmN6MFJ5bkFFTjVBblc3anhIeWVRSU9LQnl0Umhl?=
 =?utf-8?B?ZFBQWFJRQlc0V2lYajhQVU1HUkZpNjZZQmhiNE43c2NudjFhUzRSd0ZVdita?=
 =?utf-8?B?WUo3UERZY3F6QjZINU9OT3Rramo0WG9iQUtEZjhWRkluMzExd3NJb09leTJl?=
 =?utf-8?B?Wmp5S2Q0S1ZvUjlsWjRCYk5xa1pyM2FpZ3RXZW0zKzJZSE85cUdKbElQVS8y?=
 =?utf-8?B?TnRtYTAvbUVHWUYvZGMwOXpSN21SS0tXdWhWMGJqNFRrOVhRc0pYaUVVSUVx?=
 =?utf-8?B?Q2l2OGtpdk9vQXdWUEVaUGVWZXU4bWplVnVPOWZVSElhZ0FIditFTHhkaXoy?=
 =?utf-8?B?cHFRYWV6eG9PNlIvY0hFYTZuWVhhN2FzVVRxZ2diWmVHelprdjB4SzZRa0NR?=
 =?utf-8?B?Z1JWQUsrajZ1ZUhpOG1jRXl5UlYydVZFZE1EME85c2Z5dUJ1SUdLcnpDK255?=
 =?utf-8?B?NDdkZVo4R3lkOXdlOFk5WDVqMi9QNzlxbDc5ZWp5VHpXSUFnSTZiV0tIVHhi?=
 =?utf-8?B?Qk04YWRRZlRveTlGN053WDh1WjFNZzFIZ1o4c2JNZDRmSzBES01GeXR0M3NV?=
 =?utf-8?B?Y1l5bzBSWG9URjlUMUZSVlMrNkRzc0JKSHZPR1BOR0NRazBYVXhjZXFsVW93?=
 =?utf-8?B?dlVhR0x0dk9SR3l5b21ZcVZubEg1SDk1RmxhRmhWU1AvSExZYjNuUjZQQXJm?=
 =?utf-8?B?aHRBT3ZCM0U5YTBnUUVtcjBJU2ZlbjdhMUdtSjdZaFV0bS9rdFlVU3E3MXJi?=
 =?utf-8?B?Mm10czVkMFV2dmowdThDbTMwUFoyN2J0WHpRdG5jMmJlUTFuMGFHaCtxTDAy?=
 =?utf-8?B?MEdBcjZIcGphWXlla0pscUxXcVR4cnAvU2tGS3REVUdUMnNOMklRMTMrQ1NV?=
 =?utf-8?B?R3NyZ1hWUVByclo5aGZMK3dpZnR4K3AyVnRpSXoyUHpLYk1TSnVvUjRRaGdv?=
 =?utf-8?B?REhrcG9ySXJVUnpiRkIyb0R0cC9RWDBGUE5FMEpqMWFvTEpqSXczMXZtU3hs?=
 =?utf-8?B?bmdDMFBlTFA5YlVCUlJxV2FkTU95Tyt4TEQ5bnVEeXFSc2xyTHN3bzJUVEh1?=
 =?utf-8?B?MzlMdnJsVFp1V0owR3A2WTJ3OGFKM28yWW5BcXIrSW93MmZoaksvS3FrejNI?=
 =?utf-8?B?TFdoR3l2UWNrQm1Lb0VvdTJNbTRIYURvNjlKc2FqMkJGbGhwNFFWa010Y3Q4?=
 =?utf-8?B?dnhBQzZtN1dvc1dOY0RDUTlFNzV0cWpnMXAyckxkazVYRlBEN2pTK1F2STB2?=
 =?utf-8?B?dHNOQnh4cTV5MEtsYTROMlR5SjUxRzFoZEhpb1gyZWxJTVhmbVpKb1hOMjFl?=
 =?utf-8?B?RGx0UTlaNTd3UGZvWE5ZZlhwZEVXNWxZRkVkaGZLbWFsN0NhQkdUcVRqRkJn?=
 =?utf-8?Q?C0vWt5EK5rZFe5+HnxkQsp7QetWIjt/MK7KA0Ln5hgOE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEhlWEIwOThlRmZodlVKK1Z5dHhGNHBjT203WkJIOWdGK0NLbldBa0pSclBs?=
 =?utf-8?B?WktHWkwrd0VwMTE0bXFrZVVuaUtNY3hEYzF4MjNQMTlOQ1owUVV2TkNTZmxH?=
 =?utf-8?B?RU1LR2VXZWZoSEJVRWZtd1c4azhDa0E0MURHQXk0WDFQYmU4K2VkQkRkM1FI?=
 =?utf-8?B?cFFmV2NGRVJ0aGlyYVh1M1JTMjkrK1lpS1pOWUxUZUk1OEpkbmxEYXhhVWRt?=
 =?utf-8?B?cmp0S1JnaVlNVmc3ZHQvcjNwb1FDSmIwcFlNYUxHUzJWQSsyQjUzbTNsS0Ry?=
 =?utf-8?B?OVJ5enJiMEJVVWhEMndYY2E0ZzJteHc5emQzNjdzUk1tUzRKaG12M1pWVVVZ?=
 =?utf-8?B?NGU4eXhMT25iRWJqZnR1NjRNdGVRNE1hR2pBTkJzQXRwUkJHYnQxVUE2bW5z?=
 =?utf-8?B?UkRFakdteVlxUWdERVdscit5UCtBVU9nZFQ3RmNOa2Z0Qks1eGRVMDV0NUZQ?=
 =?utf-8?B?RHAvOHpSSFFheVlSYW9UVHBOaUNwa050SURLZEE1TFRmeHB2aklRUTl5NFlL?=
 =?utf-8?B?VGJudlozZ0I4V0pGZERkeVFlWTdaTmk3dk9BYXMrODN6VzFCZ3hqeldlRkY0?=
 =?utf-8?B?S29jei8xV1ZTcXIyZ0xPZG1JTVJZUVBGWDRyRFNmQUJSRGhyRnhRaXlVQU9w?=
 =?utf-8?B?ZnUrS2NWNzJXQ0VwT2pCamdZdmdoNEd2VTZuZEp4WER1bWkxN290K2VQaGQy?=
 =?utf-8?B?VHU5R2N4YXNzbFhoWER2Yk1FazN5cW5USzJPeEMvVmxXNHNPbWhDTEEzNnhu?=
 =?utf-8?B?UFpNaTRZVk1uRnJYKytwanUzSEQrN2s2TXFyUWYvZEszOCtQUC94Tit0OTdU?=
 =?utf-8?B?M1JST0xaNVg0NmZYLzhYNVIrbUhkblArYURjU0RZQzZqY1djTUthOEVuWG5k?=
 =?utf-8?B?dzd4R2Z4N2hTbWZ1eCttSnI3MHpMN01vTGR0d2hhZ3hUYnFXZGwvM2M1NXdJ?=
 =?utf-8?B?aFowVWs2cGZNSWZlbE5UZ2cwUGVVSSt6MlNKZldycDRQeWwvbUhab1ErcWll?=
 =?utf-8?B?cEs0MlYrTTgzWkQ5akc0QzdDNGswRXVrZUhEQVRvWDFDQWFrWTRLY09DUnNp?=
 =?utf-8?B?QmxKdnNsVE1aaUlCRW80LzdPNHZmNFplOVNHVHE0bDBtZTVtRUhOS1hKMXN4?=
 =?utf-8?B?WCtod1czWWJFNzZjYklMMDY5MFNaRkYvRFd2SHN3d05VUno4dFM1dUUyYzc1?=
 =?utf-8?B?bHYrSCtRakplcElLWVJjUEE4d2pabzFaVDVqd1N2YjNxTWpzdS8vVWJiZnkx?=
 =?utf-8?B?a2NIRm1Jbi9Sb1ZLcHNzQWxTZmg5eVAyYTVpUVNWbUwxMUFjQ1dPZ29NYUoy?=
 =?utf-8?B?ZldHTjdwUnJ6clNadUFMMzg2a3VtbFFUTGRzeTQ4Q1NvaVVjSWkvc3BtNnRD?=
 =?utf-8?B?WlA2T0ZJdDBvbVFvd0xhbkVXL25GWktjcElHSmVLTVdaaFoxdnBGNUdaTElZ?=
 =?utf-8?B?dHZNL2NQQTh3aWo3S2JwWW51ZXNYRzFNZkgxbGZtbjNYeVEzQkpoa1p2d2Jv?=
 =?utf-8?B?K00rV012ajlwbVNmczFMYXMyankwY08zTWg0WHpCMDhUb2szQWhZS3NyTVN1?=
 =?utf-8?B?RUJsVE1FaGVycFdkcFNrNS9GNHJKc0crYmNIbk1xb2JyZUdadDJjc2NteCsr?=
 =?utf-8?B?ZWw0K2U0OXd3VDlEOG0xbWMzWVNlUWlYVEJ5RHBNTXQ3SGVsQ0ZCQXFwcjRm?=
 =?utf-8?B?K1ZwWW5DbUlBa2FmSjRBbmVmRDVwMHBtdGk2SjkwcmFkd2FIYjV4cjJXWVNs?=
 =?utf-8?B?YVNiVjJZY2t3QUNUR1FlWkxRTThxZkU1cHB2U0EwdU1XcDhaalVwcjFiWWUz?=
 =?utf-8?B?T3BNTi8ra1lrb0g5MkNsMzh5R0NsRmJCVHFuTWFtRE9YRUpueExhVHRGcnU5?=
 =?utf-8?B?aTVnS3c3UWl3KzVwbTFKdGdCVWtnc0wzQ1Bid1BvQWNsOGF4M0J6V3EwOWRn?=
 =?utf-8?B?dEw4YjdqeTMrMEkzYmc4a0J3cm91a2FsOG5LZWp0WnhJWENnRGlEVXp3OUJP?=
 =?utf-8?B?V0dSN0ZFNVhzVERjUlBUM0RyaVFXaDVGbUFnektXRmJsRWR4ZHd1K29QdWp3?=
 =?utf-8?B?ZHNsNzE0c1kwNThobmpmbDUycWdSOGRiTmRvVitISURIUlFkdDB5cVhVUkFP?=
 =?utf-8?B?WXZscy9YV3VSMy9rM0JFRnVQOVRBQ2FiT05vY0J4NEY2alFkUWVudjdxblk0?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9cb178b-4d20-41f8-bf6a-08dc83d83245
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 14:19:36.2494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x57F2UGLeffCWT/STguFLpbw3iZwy3khYZWJ2z9LSPbf6Om1/cZaAMpDSKMsGOZXmgTmmT5/BjVlNOjBIEZQlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8430
X-OriginatorOrg: intel.com

hi, Ian,

On Fri, May 31, 2024 at 09:38:01AM -0700, Ian Rogers wrote:
> On Fri, May 31, 2024 at 1:16 AM kernel test robot <oliver.sang@intel.com> wrote:
> >
> >
> > hi, Ian Rogers,
> >
> > we actually want to seek your advice. in our env, there is no problem to build
> > parent.
> >
> > * 3249f8b84526d (linux-review/Ian-Rogers/perf-jevents-Autogenerate-empty-pmu-events-c/20240525-093240) perf jevents: Autogenerate empty-pmu-events.c
> > * 7d88bd0d22746 perf jevents: Use name for special find value   <--- parent
> >
> > however, failed to build perf upon 3249f8b84526d. but there is not many useful
> > information in below detail log.
> >
> > is there any dependency or env setting for us to build this commit? Thanks!
> 
> Hi Oliver,
> 
> Thanks for the report and the work testing! Seeing the output:
> 
> [..snip..]
> > --- pmu-events/empty-pmu-events.c       2024-05-30 08:20:10.000000000 +0000
> > +++ pmu-events/test-empty-pmu-events.c  2024-05-30 15:55:37.332495538 +0000
> > @@ -136,7 +136,7 @@
> >  { 2623 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
> >  { 2078 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\000\000\000\000\000\000\000\00000 */
> >  { 1947 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000\000\000\000\000\000\00000 */
> > -{ 2011 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retiredany\000\000\000\000\000\000\000\00000 */
> > +{ 2011 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\000\000\000\000\000\000\00000 */
> >
> >  };
> >
> > @@ -373,7 +373,7 @@
> [..snip..]
> 
> It appears the version of empty-pmu-events.c the patch adds and the
> version generated in your test configuration are differing because of
> whitespace. Perhaps a hex editor will show what the exact difference
> is, it must relate to locales or something. Like you mention this
> could be resolved by an env change.
> 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20240531/202405311548.1e881dea-oliver.sang@intel.com
> 
> I didn't see the generated test-empty-pmu-events.c there and so
> couldn't follow up on the locale/env exploration. I wonder that a
> suitable workaround is to change from the patch:
> 
> +$(EMPTY_PMU_EVENTS_TEST_LOG): $(EMPTY_PMU_EVENTS_C) $(TEST_EMPTY_PMU_EVENTS_C)
> +       $(call rule_mkdir)
> +       $(Q)$(call echo-cmd,test)diff -u $? 2> $@ || (cat $@ && false)
> 
> to instead of invoking "diff -u" to invoke "diff -w -u", that is to
> ignore whitespace. I can send a v3 with this.

I tried below patch

commit a79a41133a41adc2d69c8f603c7d880b3796cbf7 
Author: 0day robot <lkp@intel.com>
Date:   Mon Jun 3 16:35:45 2024 +0800

    fix from Ian Rogers: invoke "diff -w -u" instead of "diff -u"

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index c3fa43c497069..54d19b492db5c 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -39,7 +39,7 @@ $(TEST_EMPTY_PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(ME

 $(EMPTY_PMU_EVENTS_TEST_LOG): $(EMPTY_PMU_EVENTS_C) $(TEST_EMPTY_PMU_EVENTS_C)
        $(call rule_mkdir)
-       $(Q)$(call echo-cmd,test)diff -u $? 2> $@ || (cat $@ && false)
+       $(Q)$(call echo-cmd,test)diff -w -u $? 2> $@ || (cat $@ && false)

 $(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG) $(EMPTY_PMU_EVENTS_TEST_LOG)
        $(call rule_mkdir)


but make still failed. I still saw below in our build log

--- pmu-events/empty-pmu-events.c       2024-06-03 08:41:16.000000000 +0000
+++ pmu-events/test-empty-pmu-events.c  2024-06-03 13:47:19.522463482 +0000
@@ -136,7 +136,7 @@
 { 2623 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
 { 2078 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_miss_cycles\000\000\000\000\000\000\000\00000 */
 { 1947 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retired.any\000\000\000\000\000\000\000\00000 */
-{ 2011 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retiredany\000\000\000\000\000\000\000\00000 */
+{ 2011 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_retired.any\000\000\000\000\000\000\000\00000 */

 };


I will try to get generated test-empty-pmu-events.c tomorrow.

> 
> Thanks,
> Ian
