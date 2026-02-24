Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC43F9E8;
	Tue, 24 Feb 2026 19:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960411; cv=fail; b=sLsaY9Vhql9JbvCj+tF0/HbVmEvUk/einG13fd1EAUVo4NTmXTTnPTUB8jtzCu5oWe/F7p+FZpvpnMQELQWIS8Z85uI4b9VPaH0Vh5ujk4Ka0OFA8peAmpEhcmGYNe9+N2laOvem3fxiqlgPSObz3QdOUb/13M3X4o7u/rfaxfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960411; c=relaxed/simple;
	bh=NI3iDW4zpYDKt8YIFaarDzPvYOZWw+zcBAoUbJJW7HQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bxEs4UMRgbo1DtuFfJj7QJLAxQGLAf5/0rPZbp6D5t1TqxCqWq6j5fZCYELyhYGuNWHEoXjLLv2ulYApS74az1aD/hKhwpmvTe9K5UvVQt7uu3kVRPHHhE8gGXLyJ123SuqyohxcqbQ7pyQM8LsXjWImrHboLeXI9PuQ7/wx6+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OYPHBMAt; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OYPHBMAt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771960409; x=1803496409;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NI3iDW4zpYDKt8YIFaarDzPvYOZWw+zcBAoUbJJW7HQ=;
  b=OYPHBMAts45w7bMjzfGcH3/rPlhT8+PDitP7fPjSzudHe14+cAKv5GfZ
   gVgH6waQfp6D00w9C5dZHy44IPOl8jnIGzhE0m5l3B9lQ58KIFraEIb4P
   G7zG2Y6ZuQ+8DGLsqezNLL3aBOjwptT9+1srYq6FfWfryuoAeZSVe00av
   R2zNiCn6wcqLPbPXT7MbEiLzGSUcWA1IraNZcdTG0wc0YyWOr/3vSzcHV
   ygT1faLroqOQwc2/y9C31nLIadv8iHbspK7TwZ+Nzv3LvUW4n85blrrLx
   WRKUDYqxtMTQo5cnpRe/aXIt5sZMK44lFsAA1vtGbUqLowFy+cVT8TA61
   Q==;
X-CSE-ConnectionGUID: YlkOn78+S8Kz3UrVoIgmGw==
X-CSE-MsgGUID: hbaEpvY7Q+mIcE1aPUbGpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="73166993"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="73166993"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 11:13:28 -0800
X-CSE-ConnectionGUID: m0PQ2S9ASKG65zth5W8lmQ==
X-CSE-MsgGUID: j7HSb0u2Tim1ukhDg+CGtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="220499219"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 11:13:29 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 11:13:27 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 24 Feb 2026 11:13:27 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.59) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 11:13:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ji9O4mGJg00I1vQmZGDHi7eUwjdQezmwLw3XGxIFjH4z4lWOduyFTMvfDN6gympr0uZjeXuZT3fkn0T47CjO//xXEtrVH0BWY5FvwrvKqzMe2tPD0DN70ZO4Ld/w52wHe7EkFR9Fmdkl6HGPE4Xsn6Uu3weWi0mRoT7hibJ/vCr4XiNhHGmmp+mhdiwaE9v+YxCIsGZAL4rJQDmi3uvwWhW2kNSJNHGa3Klo+ZW592/sHaxByiaJP3bADFSJUdtqa322DIvHpyJZEGMnSuD4PVqLO1/KYFcjSOlPzjkkonTR/kSyFxrB+HQcS+3VlZxk7Luu3kBdkbh46l3EwZAfcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljUjTVqxNXrO75JEG3uVzeIKbMeUvKUkl6vhlds4Go8=;
 b=Fy0t0gaz36nR8aT2aNxxAOtaoVazCzV72JdqYZABZZjCAuZ9RXOtzOVRTSvxth8ezHaXOVIeh5DLhxx+yCqIYeLHXyKClxk4uhd5ufCW99WeEdbRaimvw63QWjNSVD9diNIDOzrD9QB276pS5o8NqmkxrwHaS3ryJ3wJ+j4yuVhb6oMftp5iNPq3VhCJNd+iv1Gnx9YwxP6aOXW/dXTUUZnInNRk9JF7n4sk3CWYATWN4n9uDC1JFLs39V01ZGWrh7SoW8mreqd9Ly4+kcEZNU3SOlqt0bfwrcxgzcQxeddGpQ5lfkk1WedkN7gP8fT+MVCvJ0N8b0DLtaPCkhkWEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 IA1PR11MB6292.namprd11.prod.outlook.com (2603:10b6:208:3e4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 19:13:24 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 19:13:24 +0000
Message-ID: <4748c787-0eb9-4b44-a8f2-0fa18395a78f@intel.com>
Date: Tue, 24 Feb 2026 11:13:20 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v6 08/22] x86/fpu: Ensure TIF_NEED_FPU_LOAD is set after
 saving FPU state
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, Peter Zijlstra
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
 <5c3ea318-4543-42a4-9b81-7a1da0b8bed1@intel.com>
 <57ef5e60-505e-4ae8-944d-fd630e168af1@linux.intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <57ef5e60-505e-4ae8-944d-fd630e168af1@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::20) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|IA1PR11MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: ccc37afd-5d04-47e9-f503-08de73d8c7e4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTA5RUkwS3pXZlh1ckZ0K1JNbWZnMGEvSWNXZmFxSFVTUE93UndzbjVvSzNk?=
 =?utf-8?B?RkQ4WkdIRW14MDloTXBhRmI3UXR4b2xYWGxMZUU5ekpGTldrck5XVlFsYkpI?=
 =?utf-8?B?dUVNUG5paWtHZ1NVWEdSWVVUdWRwWk16eWlKbzliZ0tSZHR6RnNrMHVTSm9U?=
 =?utf-8?B?a3FQRWx1alRWcVZiTklvcGtaaTk4RVVZNld3SEs3Q1Nxd3JvSGJYenJ3K3BR?=
 =?utf-8?B?ekdRcHc3VmtPK3dKZ0p2NkcyTm1rMzduWDMwQkhxNWRXdG1JTyt4ejA2ZktJ?=
 =?utf-8?B?VWFhUVI1ZHBZUUpNazEraTJ2MG9uSkhjTXBlMmUwZEJzYzBmQ3FnOEZtejhh?=
 =?utf-8?B?NW9tSVcreFluZjRIanc4c3JhcWFwa0FpSTR6MmJvNkFzd2pWc29sQ0R2c21t?=
 =?utf-8?B?ZFNQQ09DaDE5cS8waitnSkFqbWdLSFZGUFdBeUQ1aFMrazlITW5PcGhrVmZR?=
 =?utf-8?B?RGNENHNpUHFiVGRnVll5S2pIWkkzNDNhOHJKejJNT3R4bXJpTCtYcWVSZGJI?=
 =?utf-8?B?aHRMMTZjV0pLU213b3ByUjZEdXQza2dDWDYyZDdyN3ZVSVlwdjJEd0hiNXRn?=
 =?utf-8?B?cnoreHV5QWNndTVHUDU0Tm8zck1qdVBXbDUvbVBrc0doZTNtdnIwTmlENXpN?=
 =?utf-8?B?ZzhiSTNtTUNCY2JjQ2lNaXpub2lLMHRpeGgrSFNycmRaZVhmeHY4UmtmUE1T?=
 =?utf-8?B?RklyU2ZmbTd2dWtpUEVmV3VJTzNxZVM0UkZUajh6Y2t4VFFSM2xaK3o4T281?=
 =?utf-8?B?RkVWS0VQWFI0ZmxtSjBScVhZU1RwaGV4MXJ3T2hmcXB3alk2L2hxbXRHU3RL?=
 =?utf-8?B?NDNvY3NkaHBTck9scXRKd0FIclFuUFFxRWVrRVN5V002SHcrTGN6OW5RWm82?=
 =?utf-8?B?aWMyUXBkdGFlWW90a2RkemRnVVNjbzFFenlmWkJxQnpOeitGUGxvMVRReWtK?=
 =?utf-8?B?cy8wRXVYVnFyUzd0OG9WNnVwQ1doM29NUTVnbjZ4dXYzclAzL1lOdnhaN0NW?=
 =?utf-8?B?R2U0bVkzSHNMelEzKytvTVFlN1Zobk9xUEdCZndFWWVRMEJkdnBUNXlFYUN3?=
 =?utf-8?B?VWVhTUhLWWRXRkF4WDBhMVMySTFUcEFYb0VkakRRN0FjM3dCQXMwb2NPaW9L?=
 =?utf-8?B?OFdIcVNPWkV1Ui91K2VEZEJQK0FtVVU1S1FHeHUyT3Z3cnNkM205enBTVVc2?=
 =?utf-8?B?TnRtemdPaWZZWDNJMWJpbFczYWM0blpYNjRpbURveGk2a2lFRkFIM1o4VURu?=
 =?utf-8?B?dnd0MWY0YjRrZHYvb2crWnNhVjQ5RnJyb3hiU0RuYzkvUnRrdHl1UERoNDFm?=
 =?utf-8?B?cHpyWHVPeGNmR0ZIRDNkMnBWeXJuV1g3Y2NFK1hjei94R2dNY0JES1FTRGdy?=
 =?utf-8?B?MU1PaElwcnYya1hyNDhxcnJNRWVudDZleXh0dG5QS1g2K1hnWTVFRHQ2d0h1?=
 =?utf-8?B?VEJJSXV4OGlKOVY3RS9Ga1k5amprb0h4VEI2dVNoeGtSYks0aWRlMzR3cDQ2?=
 =?utf-8?B?ZkFCME9YNFZ5OXNKelFTWkUzN1ZiaTEyaE8yYUw3VitHWU55NkhQNXVtWUM5?=
 =?utf-8?B?T3NuRXVPekdaMmpmejBVdUpCMDZzTlovbnZ5aE1hY3Q5N2VWVWhSQUxMRzJu?=
 =?utf-8?B?d3Y2Yml0VHdCOVNLdHV1NGlRbGd0bkZOdm12SzUySlM5b0tLZXV1UzExWk0v?=
 =?utf-8?B?VXk1TGE5VC9aZStwaHZQai9XTHU2Nm03WGdSbVRjVWhXY0VOR1o0bDlOVWVC?=
 =?utf-8?B?UVM4OW9VaVdEWGVWMm94TFM3a2xMY0FBQ05KME5UTkNyZVlmOEVua0dIOWdU?=
 =?utf-8?B?WXJ6YStoSXIrRWZ2MXNaN1dZb3oyT0JIMjc5akQ4RG0rOHE5UC9ZcUozb0p3?=
 =?utf-8?B?YmZkTitzZWtzTXBPWGdJU0xMT0x3NjBINXpuM2lQTXllVUxKbEpRZXZTdjVp?=
 =?utf-8?B?Mm5JY2I5cEdqazd5TGVWeHRaMXROVWxCenlMZkhZaHNzcDlnVjNGdkh1VldN?=
 =?utf-8?B?a2JNNTROakhtYTVEazhHSWVsRnVlWXU2Wit6MkdScFdCblR6NVYzWHYxV2ND?=
 =?utf-8?B?bVoyN3E3VGYyWGRXVUJBWE05QVczb1BlUlRtQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlhaZlIrYjdZT2tUSE5ncGppbUtQRlAxd3BjV0lsZWw1MldWREh4VE5lbkVO?=
 =?utf-8?B?Umhvdk80dWV6aTZLbThpeTBCd1VxRklabkVoMFBEcVhLU3lrcXExZDdYOHE3?=
 =?utf-8?B?YklqOVY3dWZoU2pCWCtqazNNSkxiMCtlY3QybFl1VnpqUnhvVFM3ZURqOCtk?=
 =?utf-8?B?ejkzZGpkcG1hOFpnL3RkVGtxTDJ3c2tNMGtaZkFoczlYTVUxcXNsRW94L0Qv?=
 =?utf-8?B?L1pnR0RuT3pYZmsrbkZEWXNtcXZLd2JIQ3NpM3VpbUFYYVU2dFRvckdhSUo2?=
 =?utf-8?B?VFpZUitKYStVbGU4b093VnQ2UHgxdDBMK2lickpXNjFSeklyaFBzYXB2ai8w?=
 =?utf-8?B?MHgwSDFnajRCK01ieFJuejdDVXJYQk5Cc0ZVbG5paWtkNmZWcGhFUEhQaG82?=
 =?utf-8?B?ZDRDNjJMRmNrWDM4bHM0NWdNaE9sY2FYbzNLWDhSWDNmeFJITFFuOGhIQU1T?=
 =?utf-8?B?ejdmMzhCNmFqUzBnRWxWdjRGSFB2em1CRzZvSW1qcE1XNEhIbW9wdUdGdmJo?=
 =?utf-8?B?c1YycFlSY3paUTZYYmh1Tm5GZTM1cWZVWEpwZG5NRU9DL0xkeFU4OHFPcFRq?=
 =?utf-8?B?bWF1NXhtQ3FYNHBnV0o3NmVpL3ZXTnYwTXp4RDgwbzNPRjZXWEtYbnhSMFpy?=
 =?utf-8?B?YWNKL2VoVEpWQUFTMG84M0xyalF3a0QrM1RDSEllaDE2N1ZmdVQyMmpzbjlm?=
 =?utf-8?B?cVVhSlNrUlJ0elljcXV1QnFpWVZzMU95UUJYbmo1dFVuUlBYQlVwTVpRQ21x?=
 =?utf-8?B?Z0N5OWE1K3pBdjJBQVBvd1pxbytSYjljcHBjQTlsODlwWStiUmE1K3lmL2Va?=
 =?utf-8?B?WTdhZG5pQWVZdVA4TXNIVC9DYjdpTm9wQVhtR0lmS3BCcVpFNHowZWJhTGhD?=
 =?utf-8?B?VWorSUs4UC9sTVY1SW9mZDROendlcWhRTlRKUXlteklrQWt3SEM4TEVPZVoz?=
 =?utf-8?B?L3lzYXBRd2pWNXFDemV2QXNkR1Y3WE1CR2pQN2VSVVU3Lzc3eWxHM3pXcXNT?=
 =?utf-8?B?MnN3RWpHc2FhcWo0RXZWVUpZcGw5d3MwSUVuSHdET3NMdllrbC9BUnROOFpD?=
 =?utf-8?B?ZzhJaUwxSkxtV3F3dWs3NkxLYUdHU25sNmxQOGUvTEs1b2FZZ1ZxMzdHQjFv?=
 =?utf-8?B?Ni9OdkFRL1Fta0QwK2RpNjg4NG9qb0F1UGVtVjdLVkN4dWFNb0dMNllNcUV2?=
 =?utf-8?B?VzZIRVc3dlZNNjFBQ29zVzM2YUczd2g5cWpFUGZKMDNQS2NyRHM2VlBmUUo5?=
 =?utf-8?B?QlVXNStWeDhCeUpVRFZ1T0hOR0tQNFZiQ3JxenFVN1JJZWtva0RaU1BRc29J?=
 =?utf-8?B?eHN2S1k2aElQN3YzZ3BVdzBNTHJrL1ZTczQ3cFRwVERPQmlJMGEvZ3BWdmR0?=
 =?utf-8?B?M3g3K1NlSndtaGlKMmNDVHh3R3hFZGZBbnJZYjNEamZvajFSNHM3cCsra2U4?=
 =?utf-8?B?N1k2RFpVMndtVXB6ZDFzcWE0S2FiRUo4TDltVHZsTG1vcnB4ZEFjRGYwR3hs?=
 =?utf-8?B?SkNxY3BaM0gva3BGSTMxNHRidEwwZ1BmS1VrcTFnaksvbXpjLzR4UFBBV3JC?=
 =?utf-8?B?aExuY0MxTHNGWXoxNkNRVjBTNE9uWjZWaURBR0RicnJmR1RkdUZWcDU1c2VW?=
 =?utf-8?B?eTNqbUNkRTRLRkVJYndJS21FcmFZcFRRcmY0OXFkbUJGNTBvbStVYUFGOU5Y?=
 =?utf-8?B?QnZxZUJ1eDhpd3dvb2hZZDIwSTJhZDdMbVE2TlV3bkxUc3VaRUVWZEx6SVlT?=
 =?utf-8?B?VXRUaTB5UUlDalpzWDY3eEVEV3BseWhmM1hxcWRlS2VQQ3FFZ3kvcGZxVVdq?=
 =?utf-8?B?NlppNzNBSWEvUVkxTTBBWTRuTGtucVhWdXlUdS9NNFl1NXo3WmtheElEWlVV?=
 =?utf-8?B?dzlncFVLOHplYmtKTVhIeFV1Y09mWGdyNWZBbFZwTWtiV3Uvd3ZXZUxlUFRO?=
 =?utf-8?B?U2FKY0pGUTZGanYvZkZRNDZvTlVyK1YxZnFhaDZuQ2JxRWVYQnVLSnNjWHJJ?=
 =?utf-8?B?UEdmNmxhNjRnbVFJRDJWMHBOS21YdFpuOWFjM2V5bkN3MFJQdlJQeDRnaksz?=
 =?utf-8?B?RFlXNFB0cGg3Z2RyMkhJak5mNGRoUFIzbE9PUTU1NkF1ZmZMbXBxY29jcWVO?=
 =?utf-8?B?QldVSkxwdTBOQTQ4WXBXUkNHamRiN295WmtJc28yTDI1N3o4ZC91aEtOUlpU?=
 =?utf-8?B?ZmZ0enQ4ZFI4azNNOHRuQW9vM3k4bktuMURMT2NBU2VRVjhkN3hKckprM04y?=
 =?utf-8?B?Y1dLRUJVUEJHR3dmaFNVQ1U0VjUxSVFiS2o0OUQ5Y3ppTUppbVd5UWczbGZl?=
 =?utf-8?B?YkhiUWtnNUpIRi9lN2hUSDRHY0dZaW5Uc0RMbW1oOEVycVlTVjlWQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc37afd-5d04-47e9-f503-08de73d8c7e4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 19:13:24.0022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: seDhv0WUqHKnSK0S+wBR6/Q3Jx5DrUoVkavzBaXp5uagkVx+/OXApIwT3ZsUxr0yz9TI/Q+eLFkXoztB/3dPE9cFCOAS0KsFrUp0K5OZ+Xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6292
X-OriginatorOrg: intel.com

On 2/23/2026 9:35 PM, Mi, Dapeng wrote:
> 
> Thanks for the reminding. I would add a "Closes" tag here.

But Closes is for a bug fix:

Another tag is used for linking web pages with additional backgrounds or 
details, for example an earlier discussion which leads to the patch or a 
document with a specification implemented by the patch:

Link: https://example.com/somewhere.html  optional-other-stuff

As per guidance from the Chief Penguin, a Link: tag should only be added 
to a commit if it leads to useful information that is not found in the 
commit itself.

If the URL points to a public bug report being fixed by the patch, use 
the “Closes:” tag instead:

Closes: https://example.com/issues/1234  optional-other-stuff
