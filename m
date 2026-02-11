Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2FE352C4F;
	Wed, 11 Feb 2026 19:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770838798; cv=fail; b=XYkOY8rMJ6UolGq8pyrQqlYh068ZAo1qIUEeQkF9A+H/mL6yqaA4Na/MtF8lREnNqfUk8pvGeHKpNYvViXtDCPd4b6I8oa5VUFcuwg6uUtfZ3OHW1Z07A/eQnQIo31XxqhoNXruHxLVn0CSwLAEKyafK+WgZO7cbnnnXHQeCY6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770838798; c=relaxed/simple;
	bh=1m67Qc9KHwRWpqb5BcdByviVnWH7kVzQpoJa1P0MC2I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AS6M9KkO/EzPM7roBKYyu1CRy0kwD0VEK+P1HtjLg3iP1VzmmN5N+5C8KhLrW8drCPWdygaMwcY2kYWiHj4U7YBnHwZ7r7HFDx4xYUKKFt3kmv/dSGYPEPPkCbrioilJzJbDzfobPWvrWjop3yHEpc38R98Ksc7fo9BZrci6+Q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tu7jRsP6; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tu7jRsP6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770838798; x=1802374798;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1m67Qc9KHwRWpqb5BcdByviVnWH7kVzQpoJa1P0MC2I=;
  b=Tu7jRsP6Q+ugm/9u1IHZCEpO/9iJkbKLcnn2NsESirvvIidSxxI2ILQz
   06w++6iaNbznDT+0bGJO9eaZIPhf7JVKeRAhn6V+pge4hSVW2VqvqMdPW
   Y/xdo9FdbzfVlS+sXoyGm4lA7UEiCHZrDQz4RUFJzYWEe98MdJQzUyVZ7
   u0RcRwBE58NprS2CGVG8GsyeWuWty/vBH92gQfs5kGYU1hM1slTH7sulG
   O337KU9PBpGi5tjuK96O8hWGNFXaTHV57UzJPTxHb0ZiyoZSEuaKrd3ma
   MERpsbnWz7zICXm9gIpkc4QrlX/nOVbSWqwaM0AGDAfBW3cpbK/JuCLJ8
   A==;
X-CSE-ConnectionGUID: sYpjaniPQ16jyVrG5Ss97g==
X-CSE-MsgGUID: 4NdwvHjwTiCH1KhPRTZYhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="72184613"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="72184613"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 11:39:53 -0800
X-CSE-ConnectionGUID: iHjqbFa3TiaqeRsvQO+lSA==
X-CSE-MsgGUID: FyViiEpsQQutgwDBztUTrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; 
   d="scan'208";a="250006182"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 11:39:53 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 11:39:52 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 11:39:52 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 11:39:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHw39LL//odkP0c18a+LHD9q6/bnwFdQDTzurk+WJLANtq0ukWZvElugojJsPObLC50zHAAwL3QLW0Aob3OL83tS/7s2eF6AtXdMq+k54CNNZNmLj5Lo1HxR7VRXSSWrGliCOkM91d4Y6RQsI7lolJEHiLK9V3TEOg4ytAA9aHweBtIT7ObeuiHRfNlMnv4JgN7YDjev09soZi5UlVOc4cOE+ySdw7IoyVRPXi0IERL0/IXfDgKQKHDHmR5C2aHbNmT1etLixbceM8d98BgvQB0mID1Mpx/9+LONMZ82dB0yI7LD1tE4riTv6h0XR6w1eyhC0shcoWh9aGIExfJqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzP0Y/gvEyBTge3vC1MLAsBIGzJk5Nx/fh2L/VNzqVM=;
 b=aAWedhhPopBSQvbIKdDPRcH6uORMKL1/7tVtsiv1JqdXSyNwdi05v6lR/aomYbc1oOtbEizqWwrpqLE4SuxDk90fgoZK2lTFS5y3yjOFudVPd7jf910QcHbF3DdGrETHWAGCvDR8JiEVh4q6eIm98/PRvRTZCBe0445Sv+sHdi8EN34iay5VehCH8CZ+kjuNkUDL5rGQB8FsV3nF1dVSuJ8bYHJP1jBljSuskZCqmZKZGCURctMn/pkPf+AMBhgCoNOHkiwr1A+uzeDoPqAl4928v8T7s/0BFHQuINfjUL3czkxGO8vpKR+mvdoEkOU80zXM3VDdw3NDKdF6qbNHag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 CYYPR11MB8387.namprd11.prod.outlook.com (2603:10b6:930:c8::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.10; Wed, 11 Feb 2026 19:39:49 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 19:39:49 +0000
Message-ID: <5c3ea318-4543-42a4-9b81-7a1da0b8bed1@intel.com>
Date: Wed, 11 Feb 2026 11:39:45 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v6 08/22] x86/fpu: Ensure TIF_NEED_FPU_LOAD is set after
 saving FPU state
To: Dapeng Mi <dapeng1.mi@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Arnaldo Carvalho de
 Melo" <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, Ian Rogers
	<irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
CC: Mark Rutland <mark.rutland@arm.com>, <broonie@kernel.org>, Ravi Bangoria
	<ravi.bangoria@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, Zide Chen <zide.chen@intel.com>, "Falcon
 Thomas" <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>, "Xudong
 Hao" <xudong.hao@intel.com>
References: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
 <20260209072047.2180332-9-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20260209072047.2180332-9-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::27) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|CYYPR11MB8387:EE_
X-MS-Office365-Filtering-Correlation-Id: b7a4a6ec-cc4a-49b5-9205-08de69a55125
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGJmUkJkTkowSkRZckhxTGV4VEFEM3NqWU5UTkJadllkNVgrM2RVc0tHTDhw?=
 =?utf-8?B?WEdSano3M3A1V1VWOHJZWlZuVU5zWGNTY2tta3F1MWlKQy9hQzk5azdLckhE?=
 =?utf-8?B?Z3lUUkJNNUV4ZUlWYW4yTjhKS0VCM3BTV3J1cHhoczdYZWh1QkpDUGpoUFdL?=
 =?utf-8?B?T2NISDh3ZHRoUmtwWUhOMWExdmhqOFgwQjh5Y3FXdm1wRS9xeFd3c0ZrcUgr?=
 =?utf-8?B?YnJrY3hlOVhUZHM5aGJweTYzUDhvWi9RdU9VTTFqd25Id29Ia1hteE4yMnVT?=
 =?utf-8?B?R2c0OWdJWWZTY3dnMVdXTm00MnBXc0F1K1NBQWFFNjVob0h6TnN5V0l0TTBI?=
 =?utf-8?B?c040bkN3bGVKZWJSRTExeFYxeE93Z2t5ZW1UMnlTMXptcDdoNzhWMU43VFdq?=
 =?utf-8?B?S1Rmc292M3FCa1ZVYkxLRlpIWUVIbVVEdEZINGxEc005OWlVUy95cjZ4RHJw?=
 =?utf-8?B?WlJHdXBrNHdsdkU3cGNCUGtMNE1mZFlUbHhpUGZvNU5LajBJOVBZblhaWVFS?=
 =?utf-8?B?WEhTcldlbWFITWcrTjBIKzJNN2pNMmpRa0xqVVRiSFlaWWZIZllmVGZITk1E?=
 =?utf-8?B?VFBTYW5ZbGlYUnJyNHlJTFZkUUNENHRMblpsdDlNSTJCb0JxZGhsNVBiRlVz?=
 =?utf-8?B?elQ1c09LN3paUXJQU2FpRGJlcDFPQythZThBRkd6dzJzZjhhUmo5NEUzd3Bi?=
 =?utf-8?B?OWZITEVINVZBc1dteWdCS2dmUlhsZmpYNDRUQm5wM0pJZVp0VUJRV3VJZ1Vp?=
 =?utf-8?B?WXdGVVRLWEdrcisyYlVzREdvdVNwYTVhRjJNUXBVdlhuTVN2YU9PcjQ4OXVh?=
 =?utf-8?B?dHFldUhlaXNoRHhTc0R5UVlvc1FYL0R2K2xUYlVXaUp1by9ZaFlnTEp1OU81?=
 =?utf-8?B?SnE4TGlnSEU4dmhNRTU0ZUtTbzhUSU9vWTliajN0YnZ2YXZ5ekFYT05aMUJI?=
 =?utf-8?B?SjlUSUNMTlYwc2thbzJZbHFReXYxOW41Q2NpTXlCQWpVKy9WdzhpYjdOZVVK?=
 =?utf-8?B?RVZtbkxibFFnTTVHTkNsQ3NSZHMyelpZTCt3NHlKc1dKYlFGc2kydXhRVlRK?=
 =?utf-8?B?U1RuRzFuL2JlMUFCUkMrWXpLN2s2WldYaHFtdXFad3JnelJmZ005UDVqQmZD?=
 =?utf-8?B?cjc1S29IWFZvK0hUTk1tUFJOT1NTV0pkdHRNTnpzWXBvQXdORGhmQ0ZzNSto?=
 =?utf-8?B?VTl0V21GZ1lMVS9udDhJTmR3SWxFajA3QUpzT3RSSVZwelZpd2tLbFFDZjZk?=
 =?utf-8?B?T3FISXlLUWt4OEpvTENBSTZ2T3VuaVQ2M0V1L0JDdkcyWEpoMXNkYmtUMjhQ?=
 =?utf-8?B?N1V0R3JneElMOGs3N1o3aUFERCs2T2hraGhRV2ZSbUdkVWt6OEU0bzZTSHNS?=
 =?utf-8?B?aDRVdlJRaUh5NkwwM0NJRGVVR2JUU1daRW0veStMcE5QY20vVFlsTmd1NG8y?=
 =?utf-8?B?Um5MSnV5MWozb2hWc0FEUlVpZzBENnQ2czhYRUs2WGRZL3lPc2FVWEgzRGl0?=
 =?utf-8?B?bk9RcUJ4MVEvdXZPMURaM2RxZkk5UFc4S3AyWjFwS1A5M2tVbmJhK1pneVZZ?=
 =?utf-8?B?RTUzS1BVZkp3T2sySmoxQ3JUVUVkMVY5WnBWRENCcGtSWXRqd1k3cC9mREQz?=
 =?utf-8?B?cE5CNkpCSEZhZXZ3bFRxYWs1WkVaa0xWQmZZRVYwNWxvQW0vNkIvNXJsY29Z?=
 =?utf-8?B?SVFuakU0ZHlFSkZINzYwOXRqbElFQ1B6ODdZdWkyUFJmM1ArMGZMVzc3MHVI?=
 =?utf-8?B?enNlT0ZjK21qQy8vQlpWcGRlaWJ5QnhmMW5DM3BHcklxTDRHVll3U0xveHc2?=
 =?utf-8?B?dytudjYwV01DMTBiM2VMdHRJWllLeVBTVUozaUZyTWtKbVNseXBuMVZoc3kr?=
 =?utf-8?B?aG1VVDJESW1Lc2dKWXJIQTJlVTZsUW4zUnE3WWpjOVBoenhvQndVY2dGRlZy?=
 =?utf-8?B?czNic0xaYktiNlhIUzVFU01sYnJYY0RJTjVoTVRDeGk0YTZ6Y2pzODh6TXAw?=
 =?utf-8?B?elVKM1VpcktwNlBGMmt1R2NQZjJ3MjEzTEl3VFB5QXExT0RTUnRhYlowT29S?=
 =?utf-8?B?WTVlektSdnpaWmZlWnFmcW0xMUIvblNzQ1hxdXdxWnpiaVJ4QUQ1MDl2RkZw?=
 =?utf-8?B?ZUxiVFZXeUkrNU9ob0YwRVFXS0VGazB0U3N3WHpwcXUxd1VlUWtmV0JXQWp3?=
 =?utf-8?Q?9IBkaYTam+JUsb2oKjpI4DU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXdhZFRYMFRPWWtnRmtzbGVTdUQwVDZid29qc2FvVnBvMTMxOG45QlNGbVo1?=
 =?utf-8?B?YjI4amQzNHNJN3pFWmNKMEpzTmlYU2FZc01jSTE4SXZCdXVoS1VjbStEWWJK?=
 =?utf-8?B?NFJLR2xSaWRidjE1Mm1ZYUF1dmI0NVFRQk5OZmxPUkt2YTd5T21veWlsbGxG?=
 =?utf-8?B?RlFZWVk5eEh0WlBEVnNTNDF3Wm10d0JkMmZEbTllS0U0dDBhOTNPU0ZQVjF1?=
 =?utf-8?B?U1A3aVJnZjFMajcwZzhzZFVIc3p6elF6Y1dsU0xoM29JdmVEY3U0S0h6UDhF?=
 =?utf-8?B?NmpZdVo1ZmFrRHg3dXZaSmZsOUw2b0xlSHpBN1RJN1Q3bzJ5ZDZWc2hTMGhY?=
 =?utf-8?B?Rno0K1RMM0tjb1FCNFMyMVF3c21KZG1RRldIL2cvRkt3Z1VsY2IyWVBiQy9B?=
 =?utf-8?B?UG1lcGtYdXROMEV3b0dya21UaUtCSnRrYmVGQWUrUHltQWkyL2huY08wN2VR?=
 =?utf-8?B?RUxxdVlrNWNYK0laUGlVMzhUbWNFbldBeHdTTW9LVGJJQk42ZStHWVg1WkFa?=
 =?utf-8?B?WktMVHJpTzNwL2c1MjYwYVFKemRYMDdBS0xEVFp1SDNWUWxVRFNtalZOdG5U?=
 =?utf-8?B?MW9teVQzdUpkNmdyNUZpNHF4dktVYXlIZ2RnVzRvbDM0WFhTTGtzRVdSbEtt?=
 =?utf-8?B?NlVOaEpqRFI2NTRWL0o0R3UvclFpK0wycFFnOTNIUm9qaFVjUmZPNTY5OFBl?=
 =?utf-8?B?ZHRuZE1EakFsaEpkTTFBWFQ0SjFrbnhoK2drMTVCV0VnZS94QmJyS1NDSEQx?=
 =?utf-8?B?blFlUU11dFlDTUhMcVpibzk4WGZMQzRrVGI5T0F6aGd6enJBVktVelpLaDl6?=
 =?utf-8?B?eGRoay92dnNCVFRwSjFTbVhpeVE4UTNVOEpkZEFaYmRvR3JscDVqYVF0SWRy?=
 =?utf-8?B?OUtWVmNtK1F4dkVVVDNBL0lxVGgyN0RtVnhQeHBkaEdZdFJlWnE4bVpVdHdm?=
 =?utf-8?B?aXFoMGo2SHpGU1dNWDF4Wm5pbEljdjFOZ09BdXdvbjdvU1NjN1BRbGxuaTNG?=
 =?utf-8?B?bWpUT2lpaEhGdHFPSVJMUXdUVkJnVG1lL1hwd2sxZlZRMTFrbWQ2MDZhZVp5?=
 =?utf-8?B?V3J5RkdLZWFJeFRxT0NtNC9vaFFmZnRJZEFla1VIT2pzOFdWR0dQcktGQjkx?=
 =?utf-8?B?SEdrSENjMGZHRk5majFkeXp5eDQ3YTJnTTg2N0orWEl2cTM4bGo0WklySkRx?=
 =?utf-8?B?U1p5YjNydjBUcnZDUlVxWUdlYWxHK3RMU21CMG5ZcXNCWlFpRGdHczFDM2NQ?=
 =?utf-8?B?aUp6dmhLcUFtQ1BCbHpOMkpuUHdnQU5jQnFWTUFaRHhYaUd6M3J6M0pRc1NT?=
 =?utf-8?B?L29ybjRDQnpvaFYrWGlHRzVIUllMS1FpUkN5Z0lRMVNmMERMSzdxQ3Q3Vk1Q?=
 =?utf-8?B?b2dTRFdCRkZ4d09VazVUdEx4bkY0S3QrVzNRaEpObjhSalpteDdGTGJJY01O?=
 =?utf-8?B?Y0sxT0RtQzdMcUtRcERob3N3eFozMG1hZkJ2Z09LTVpNYXNQQVUrOEdCMmZy?=
 =?utf-8?B?a2QxQnNaV2hFenBLYXFiNFdBTzJrYVpjSFVRQzhFY3JjeWNxY1dnc1dVa0Ir?=
 =?utf-8?B?UVBweVBPWnhEZHc1VFYwNjNqS0l3U2IwVkRIQkNxM09TWHZLb2dJNzRXS2p5?=
 =?utf-8?B?WVVncm1hdlJsbkY1YjcxZDBFdzNDbXVjdytnck9DR2VJSzV2RnMzNUFmSDVX?=
 =?utf-8?B?Z21CZk1UUGJKVk0zYk9UUmgxZkFVeGR1OXZwNUVYYWMwUTFHK3VPME9Ub3g5?=
 =?utf-8?B?SERRNFFLTUVYcG84aTRXVW5RSXVIQjBNQTRSNndmY3JsV3dhY0dYblByRXZs?=
 =?utf-8?B?emgvRmR1L3BQdTRTeGR4cVF5Y1BRRFUrdURPNWJkdVRWNnJybnZWREJjYjJl?=
 =?utf-8?B?TVJyQzBMOVhhbmsrSjJKaG5yZlJGei9GY1pjNDFiaHZoaUJVZEp1YURGUWly?=
 =?utf-8?B?R09TK0FFNGxCZDhJUENURWJNUnQ5REdnTkkraVB6QzBVOVlhWGJRS0ZvekE3?=
 =?utf-8?B?Z2t5YWUwczFFYVIxYnZyT0s5dkh4Z1RqMkxwei9nN1l0UEpOWnVYSXpDU0Qy?=
 =?utf-8?B?QmxDdWlBc0I5eTdDSkc0bFlKbHNBNnRmMGV1Z3cxai9RNmo1dkFpdVB0aDNj?=
 =?utf-8?B?NGRNRmRuSWVNeWlIVVFiM0Fyck5ZU0J1Mld2S1UvS0VsYVVOWmY0aER3MHZE?=
 =?utf-8?B?VVU0Q3FHNmVjTHNTNDRXTGdEdTRzcWFaekM1aVlSdTY5SWpDRm1YTWQ0bUpN?=
 =?utf-8?B?TCt5YmljblFoak9DdW56WkhrZExWcGVraVptTmlmQ1ZNNjdFc05FKzhmangz?=
 =?utf-8?B?cmZJazgwK3duVXZsVTVuTE5kcW8ySXdKemgzKzhkMElMVjdwaHlNUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a4a6ec-cc4a-49b5-9205-08de69a55125
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 19:39:48.8016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pf7vbYun1tnGRxb3n+LfTmF03s/ogKI7qT3yRVylCJYatZkq4ucp/x+fMjmCB/Lo9dGF+5izKrl50GO28BFbxDMFWNRS+B8uY1XVyMEpCmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8387
X-OriginatorOrg: intel.com

On 2/8/2026 11:20 PM, Dapeng Mi wrote:
> Ensure that the TIF_NEED_FPU_LOAD flag is always set after saving the
> FPU state. This guarantees that the user space FPU state has been saved
> whenever the TIF_NEED_FPU_LOAD flag is set.
> 
> A subsequent patch will verify if the user space FPU state can be
> retrieved from the saved task FPU state in the NMI context by checking
> the TIF_NEED_FPU_LOAD flag.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>

I could check some previous discussions there:
https://lore.kernel.org/all/20251204151735.GO2528459@noisy.programming.kicks-ass.net/

With that, I think I can get the context of this change -- tightening 
the flag up with the buffer against *NMIs*.

But the changelog doesn't look clear enough to explain the reason to me.

At least, I guess Links to the past discussions provides better context 
to readers.
