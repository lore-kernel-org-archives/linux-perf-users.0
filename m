Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F873009DE;
	Tue, 24 Feb 2026 19:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960414; cv=fail; b=ZzSQ+T1QuNxdqqaVcile9XzGt5tb/grFNJuY6k+oEBdoMvalw6zqTy6OnCZ62dNz3NK5Py9zumNJ2GBM7BGC/UvcQl7wi/7HySFuYHU+MkEzRo5umlChgExdEoi5UiMqSx4L10ITGsTISHEAW/1YyS4WxQmrWPfW6CucW4D4Oow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960414; c=relaxed/simple;
	bh=VHseOHQfVUuMgXGMsN2J2fI6sDYxFnt0ZB7aAZDayYw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QBO7afrPMpu7Et5n0h+/uAQGDVC0UNE9A/ErCDF5mzfvLevRRuuRShkGdB368ko4r9VwHhKHMuVLvehJ9hOdlXWRItm2J55uxj7pTNTUhhD+kwqXijTCkt3obVmhujCXF1kpbYjrnzMGQQNDbICjp5gpVpo8vT5HoOoxKzJmRuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LepOExRw; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LepOExRw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771960412; x=1803496412;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VHseOHQfVUuMgXGMsN2J2fI6sDYxFnt0ZB7aAZDayYw=;
  b=LepOExRwsNJ7PTDyF1MTsxk1Zx3rN+JgtRvl5S5AfTACitpqolGqdfuB
   dX4TcuIjlzsYXYKn7qDDI/qupAi83F5p3aAuKXgWvAp2MRouvrBNfCUCO
   n4E4SWv00BInLUy8P3+ANPG8cTcpkIEIa7uHzd2xM0QcAX1/Woxxg/XXf
   y0LbsH7Xr92/ggVJyCXRXFtQIN10MFPMulC6aI7ctLN2KHsZgjCQ/H1dE
   aQvi+BIdkbM2YEG3Cp09+ycaF9tHXWIEIn1qnjFF7MB1i7nOFh6diL/eK
   71+AFDGwRe/N5xFtpFq165xA+qHjGEFM1BGnUtSlqjJjCOvizmoKFPrgP
   g==;
X-CSE-ConnectionGUID: F3HKochjQuOY+3t6GeF4tA==
X-CSE-MsgGUID: XWtD5QpbRLSoM9xIoUsz/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="98453549"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="98453549"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 11:13:31 -0800
X-CSE-ConnectionGUID: wHCXBpoISkypcUzvTa0h6g==
X-CSE-MsgGUID: u/UsSxcBQci7Dgvusk6H7A==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 11:13:31 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 11:13:31 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 24 Feb 2026 11:13:30 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.56) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 11:13:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9sSoDUrjG5w3SQTd6otHUwf0Nzb1NxTh59mr/K0m4dl8tcwO025VQGoPdTyVESZ1p0sz5r+oiPMJlFwdLIcR/9jE1lO2Poh4Nzvc0d9N9EgiQw0ceVFxmW54mBBcgRMSNV1FHug2+E/Cscx7SxFk9coAZURuY6MXTIbDknCjRJMBS+LaE+f6HchamsFfNn1Bc8gymjsEXlB0DEbSiAUVTklCVOxMpCMKJ74co2uzErxmkxoI1C3YLEVEPy1PFANNT4OLiHW2+1VmkkRKISis1dF1iS0bmTLJlR4Jfgdndqc6eOsTPhA/EpTC7hr5hiaakTQVbj6TEuar9uRnGw+0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4J56CJ7jUiEKbZ/r3UdziS644+Gb+f/OZVlclpdBQ8Y=;
 b=trjVphARdcstfZ+7DHaYO3ggV/QNOLi9Zynt0PeLqTubZaBrwo5Rb4GrEkCK1XW4eN1XGN/3Zr5xqmY0TNWT/IJmfoVl7q5E8D8tIR8kjmonAkcp9MldpbPNGSqeyaN//7Ojwxd17mrQuFgq8cMYWCQcc6OS93sTzlr6EJPcaeZ5d1oM5tLXZLKJi7Uum6EqQ4oZgOedFSzwTdOUsfjd79eeBBlEPC+4WTsWtdUiqFzFae35asq3f4XMoElxIg+VWBlQs2w4J9+IRZrtfeIuWko+I1apHPfVF7xxYkuBQ/HjX7/WpR859fDs0ipi8jWH5Fkg3sYno8jfwktZ+E4M4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 IA1PR11MB6292.namprd11.prod.outlook.com (2603:10b6:208:3e4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 19:13:26 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 19:13:26 +0000
Message-ID: <f48500c5-dfaf-4ca2-9f9d-3d3b1e9f2299@intel.com>
Date: Tue, 24 Feb 2026 11:13:24 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v6 10/22] perf/x86: Enable XMM Register Sampling for
 Non-PEBS Events
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
 Hao" <xudong.hao@intel.com>, Kan Liang <kan.liang@linux.intel.com>
References: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
 <20260209072047.2180332-11-dapeng1.mi@linux.intel.com>
 <c287e7fb-d504-46fe-b6dc-af28c3532be6@intel.com>
 <e57a249b-ce70-4f5a-86f5-cd86bc477546@linux.intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <e57a249b-ce70-4f5a-86f5-cd86bc477546@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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
X-MS-Office365-Filtering-Correlation-Id: d11e876e-0cc3-4038-5820-08de73d8c976
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWxqWVdGNEdjVkFiZDdtTnBLZEVRWkViSGd6MVdhOTJSZ2FMZGJkeGh6NHNY?=
 =?utf-8?B?djQyaERyaE5sMmgrTlZEb3B4aUhrbEZoV1g0dDdxeXlMNE1KM0RvQ0sxWk9Z?=
 =?utf-8?B?NzNYYTlocm9UMTlwVmt3N0RLcEQ5TXU3VW1SWDVHaDQxdWF5NVgwR1NOc2li?=
 =?utf-8?B?TXNIc04vbU5UVXYyY2RueC9OQmdzUjJuRWdVd1krVmVSZ0lnaDNwdXVCM0tY?=
 =?utf-8?B?SVF4K1U0ZkhkVUNjQkNUWWRxK3J2aitJSFlzYUFPWG81K3IycVNqMXh0STZm?=
 =?utf-8?B?b0NpSUhab3FTSVh1V1Q3ajFNbC8wTy9GOFZmOVhYaUJBNVhwMUw2b3owL2Jq?=
 =?utf-8?B?NktrN21JSy81UUZaMXg0NGFNQWZUalhRMGQzc3J3UDdPTjZMMUFDSlMyT2x6?=
 =?utf-8?B?MzBwV3d3Q1JteFRqQ0xZa0RwQTV0aUJ6cVRmR1U4Y1cvSlJZRnNHNlRzNGxL?=
 =?utf-8?B?NWVFb2w3MFdJbzV0VVkrck9NYVFHa2dlbXZzRU4zc2VSOVZvN3RvRGNUd3Y5?=
 =?utf-8?B?QVNBc2ZnSVJ5NUNmWnlZSE1NdVFJb3ZKT3dsaHNVb3o0azVKSHUrSENDcUp5?=
 =?utf-8?B?ZkZYdHpYdDhQTFFQTXdFR0ZjTTNIUjNTTDRib1pEbkQ4S1lQM050ODFyTENz?=
 =?utf-8?B?YUtvNkt3WGR1cEl6Sm8yZ3krczFCdkIxdDMvSWJJUXE4dUxCMzU1cm5UcUpo?=
 =?utf-8?B?VHhNWDNacnJIRmp1N0VUM05KSWRJaFU5STZ0VDZaNG81TzBERUhLeURvY3VY?=
 =?utf-8?B?N2tFK3k0TzM0RnJWMlZWRnZJRFFmNGd2SWsxcGZwbnkwL21UTkJzczdBWkFQ?=
 =?utf-8?B?cXM3UC84V0IyTEM5R05xTlh3QzY1MzZ1MFlIZjlrTUZaZzZudWQ3ODIwaGpa?=
 =?utf-8?B?dUhzYjNBU1JhNnB1aGd0Z3VWWlBxU3RRaFU4Z1l5dHZ0ZTRmblU4VG1OS2N2?=
 =?utf-8?B?ZGlHMVJUWVdibmFTTE9aTkxiWUxpcGRER29Qc0ZiOGZhMWxjampkbU1ldE5z?=
 =?utf-8?B?ZW16NldMam5KVHZMZlJFTnZxVE9majhQM1FsZy94TXNHeUtGUlpKRjUwQzd4?=
 =?utf-8?B?UDd6bGlGRXV6cm5jTzY3aXhSY0liZXJOMGZsMUdYU1hWcGNZdlI4N01kRUYx?=
 =?utf-8?B?czBpYnh0NVcxaHZrNWQ3TVVSSVB6aGZHQzV4MWJSZ2huMzJySWhvM3VJU2RW?=
 =?utf-8?B?Q3o1K2s4d3lnQW95dmFyaS9VZkU3a1ExclZ6YXFtWnVFZ0lKeGVuTU9hM3BF?=
 =?utf-8?B?b1lwTVBDbkpUWGhQQXlzc3NFanBYMG5HNC9jZEVOUnkySjNqOVZjQ29QcVV2?=
 =?utf-8?B?ZTNiYXlYNG10N3p4ODBRcUtyeXpRYTJhd09mVlFzL01SVU96RU93bjZpMDli?=
 =?utf-8?B?QzRHZ2VOdDRLemtyVWh1bkV6VnRIZXBBT05rL0U3QTkvbGRIYWlDY3pnbWdY?=
 =?utf-8?B?eEVPYlNNSU5HdFphcUxid2VCZmtnRnVkZ25ESmdNS3NrYVdRTURydFh6VWJH?=
 =?utf-8?B?SXA5SDlSNWErY2o3U25TRUV2cXdJVG56MVJUUUJRZTY2YWFhMHJCcUFCTFRT?=
 =?utf-8?B?Y0xiRG5zMmRRbUV4eldLcXhTdWU3NlNsTnp1eWdFMnJ2SzhuTUNWTkFtUFZk?=
 =?utf-8?B?MG5vOGk5d0wwYkppSG8yTVVxSnFzWXlXRE03QmZGSFpSREdmeUtTZUE2YkdE?=
 =?utf-8?B?aUJZNFpnNDdKSjlqd01LYW5WYkFUQjVENlJMZUY5Sjh2SG85V0ptcVdnbWVp?=
 =?utf-8?B?ZXVWOXNlSXYyTm5acEVxc3V6ejMyYi9CV0cxZ1d6NDgvOERmek9LRVhWVnRY?=
 =?utf-8?B?SlRpeXJHamdhWlpZeTFxb3ZSY29tK0lFSnZSeS9JV1BMTTFmOFVTcGx5M09Q?=
 =?utf-8?B?SzZJUDVtWlNVTTFIb09aZ3l2aVpMZzY3aTFtQ2wvRmVRWmc3Z3dYZXJKSTZs?=
 =?utf-8?B?bGFrM29vdENWZU92eWk4WDlmNzJyM2lkVElzY2dsZTdGdVpFZkVpTTc2SlBS?=
 =?utf-8?B?aWtNODdaRWVJWGRDQkQwVUU2Y2xIckFRTWxGa1hVcTZtN2lQdWxMa21Od1pR?=
 =?utf-8?B?eDFNb2RWMkFNU0ZVd0JJdGpsVVBXUkYyTWZTd053RVZjVWhsNnA2M2ZrSkRX?=
 =?utf-8?B?RW5ad1dONlB5RFNaNWN1ZU9NTkhMWXBNMjJieUtCYnh2VGxyUkJORnVpVkRh?=
 =?utf-8?B?SFE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnJRTUJ0cEo1dGk2MGVQZWlzT1QzWEVHRzVNdkVnSHo0TnlaVEZZaFc2VlRu?=
 =?utf-8?B?VlNsU1ZoeDAvcEVmWXNsbmE3ZUJuQ2k3NmtBWlhyZEZaQ1pHT3lvdWhxaTFm?=
 =?utf-8?B?MThZOVAzNWJLZld3SFVpMXdSK1ZZeVFLbnozVFdIK2RFUzcyWVl2Z0tUOEll?=
 =?utf-8?B?eE00ZXZPZGtIanBGWVlzd3JPVEt6eWpTTGRpWWJnK05TSm55anA2U2grUjFJ?=
 =?utf-8?B?ejBmYlNaNnB2bk5KTUZxdFRjMUE4eEZpL3JVb2dTWHZNTTJESHVRbnIyUTJY?=
 =?utf-8?B?T2JIMTZ2RlJaTjIrMThRbnRaYjVBODFDNWdzc25hT2s3ME5PV3dqY1V6T3di?=
 =?utf-8?B?cDVFbnFqeGV6WWorb3l3aVRBQkFpbWpDSjZlQmpZdE44V2JtSGVYOEdTcDdP?=
 =?utf-8?B?bUZBZUxzS3MzZi83NzkyTkZ0R2VTMVFRREpTbE91bHFtQUtCSlM3bzJhVnBq?=
 =?utf-8?B?Tkl0ekVYVDNLSEoremRackhHU1BkSFUweUIweVo4bzF3MmhWY2dzVjFlN2dS?=
 =?utf-8?B?UExYeHV1ay8ycURIZUJ5RmdhUGkzWXAvK21Oc3dvZFM0bk1aNk15UXNodTlT?=
 =?utf-8?B?QXlybWl1NFNnY3M2TDhxY3JqczRwSE9mcW5MSzYzcnFKN2treTIzRWx3VHdI?=
 =?utf-8?B?eVh6UTY0ODg0ZjdVL1EraVVhMWVlUCthRVFyWlhWUHZNOWFVRk05U3JTUlRD?=
 =?utf-8?B?QW11bkx6ZWNMS2xvVmMrbnBIejV6eXduTjdpUDlFVkx4S1RZcG1KcUpLMWlq?=
 =?utf-8?B?a1RGWHQ2K2VMLzV3QTk1dDFCc0RQUEU1V2Y5ZHk2Y01lWFRPd01za3lTdjE4?=
 =?utf-8?B?emgzL2pmVjg5Z20zQ3lFNExWcFRSU3hpZHNjbWQydXphdFRuN0N1Zk95Y2tq?=
 =?utf-8?B?MENheFpqOVZZM2YwaGwrMGpxanRNdXUwVW9JOHBIaFNmeGtVTkRTaFE4QXFF?=
 =?utf-8?B?T1NjWlAxZTU3Nld2dk5YbUNHVkFVa2wva2piVUE5ZnNQOG01RXFTYm1tNCtK?=
 =?utf-8?B?ZXZOa1hiTzJTaG1XMG5EWElMaXhMclNxTTZkRFhqeDltNHJPS2NJREpnVXVM?=
 =?utf-8?B?U3czaVpTeUtoTFk2SWNOWXJjbXhKeHN0NEhtb1pJTlFHQmQyR1FYSWhNZjdH?=
 =?utf-8?B?a2IvSzZTdURwOEVjb3NGSjBlamY5SWdoUWFHUno2b2ExS2UrZ3BqbGkvVmE0?=
 =?utf-8?B?VGkydmZTT3huSW5nMkJRUFBFMFN2Y1dlUHk2OEloOU9ucms0Uyt0aERpUjdB?=
 =?utf-8?B?akpCNzEyWHVPSFJaOTR3T3QxekZpU2Jzb0JPd1kwN3RrQlFuS2MvSXFLNnR2?=
 =?utf-8?B?R2NIZTRXZzJEVGY5TjhYYVFQMTZjSm9pMkJnckhUSHlrYTAyLzRtTEdXSFNH?=
 =?utf-8?B?a29PbnBNNVNoY3ZwMFlZQkVwdi9DVXVXNXFsY0NVYndJcmMyTWd1dUdxbDdu?=
 =?utf-8?B?d0RWTkgvVXdJNFRoWTdSaEw4ZFpLN0JTb3F2eWZHL1JweEVQL01iczhlWEk3?=
 =?utf-8?B?Q25ObWFjQjM4bzQwV21MOE1ESzhkUGl0ODEwLyt2TjMxZ2xHcUxEMEE1MXVC?=
 =?utf-8?B?a0trVGRzek8xZ3hBZ3p4eE1TOXdtTytrSXVrMVl1QjJNNXBGMGlNUVdXaVA5?=
 =?utf-8?B?MzBUYzVmT2tHNWRNQVFJblJxbzc2aEVsR0dDWHlMY1YwdXlQLytDVTRmTE5B?=
 =?utf-8?B?K2hqT1pjeSt5ek05WW1GSUVuVUlIZXd0Y3RWRGU5N0pYV1hzYVNHeDY3RVJy?=
 =?utf-8?B?amp3MXhhbVRHRDlsY0g3WHM4VTFHQUxVTUY4d1VsNDNVOHFvanlVV1hGbU8z?=
 =?utf-8?B?VVVQbXhUV0RRSWt5ejBDeVNML2I1Mm5ESndWTk9qYzl2cHFHSTlGc1FlT0FS?=
 =?utf-8?B?N0ZGQ0wwVkNqSmMrOTdBd1YrRXZoM3EzYzdlUnE5UWMvZk9JLzBCMWw2L09N?=
 =?utf-8?B?Mk5HMjViUGJUalR0RGVCdTB5SFkyakNzWUZyaWFVNDYzL2wwL1FSdzZJOUp5?=
 =?utf-8?B?dHBGOU5lY2dwTnd3U25XRjdRVnA5VzMvU1hUcWNiRkNVeDc1ZjUyTStxajRq?=
 =?utf-8?B?RDNhYjZ1dGN1WjhtVjBZL1FsYjZiazNWS1VpeEVMVFAzb2dNR2c2TGxCZFVr?=
 =?utf-8?B?enU0Sk84R2pxSTU2Z0ZRa3orVnFEMXRGenpLU2Z6TWs2d2pVV0psS01wVm5S?=
 =?utf-8?B?Z0VLb0grR1kwZnFub0ljdkVRdGx6V1ZMSC8xMnFONDlCb2dlbnBnQ3VYSmNP?=
 =?utf-8?B?M2VQUEFidk5kaTA3TVlNM1lrMnZ2WWFqMm9yUU96UjAyUjlhWDVIN1N0NU15?=
 =?utf-8?B?cjdpOGttYnZ5Y0xaVmpISE5POUlZc01raHFjVndEL0NYRVUraXY3eDFOR1l6?=
 =?utf-8?Q?3EpBZPNfq7BWFvr4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d11e876e-0cc3-4038-5820-08de73d8c976
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 19:13:26.4650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1SLC6iGUJtESbpVykhmOQBvQ74jSboILUo7ZvA5XXEmMvoioPDRVQi5QGRpRMZcWUbNKON5naOqCUGgVn7XLHcpAEZU4H8E+dnLv8roFzqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6292
X-OriginatorOrg: intel.com

On 2/23/2026 11:11 PM, Mi, Dapeng wrote:
> 
> intent of this whole function is to sample the required SIMD and APX eGPRs
> registers by leveraging xsaves instruction in a NMI handler context. All
> the SIMD and eGPRs registers are collectively called "extended registers"
> here. Not sure if the "extended registers" is a good word, please suggest
> if there is a better one.

They are sometimes referred as 'xregs' in short. Also this is a local 
function. Following the do_something() style, perhaps just 
update_xregs_state() or update_perf_xregs()
