Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61FA18027;
	Fri, 13 Dec 2024 19:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119596; cv=fail; b=NkamQNMeQkH9SXvNqY5OQHeViLEE3Q3n/QLXUTtkP5DRAkeKBLVjaFrZgeWI9haBK7V6ixKFDGh7TrhFiJSQeuJwPE2fRjdJhbX64FfuOqfkpGHPrGbIUQ2HjlUuF1TxOPAQ9jh5tvQVkIWQRhn76KEj9KVmPqiwwh2CAtyoHVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119596; c=relaxed/simple;
	bh=tf433BKe0rLXUi09iqWIXmMMMwKiAuJxMovfdX563tU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GwT6PG2LMhOG8jwhxM8YjmBS6d5scQ4ArtE9zmpcOG2Uv2w6O/ISFOfgHZiixzNWN7BRuPEneOWHTa8ECIc+baE1AudF0+b1CZFalefXHEir95v/qOSrSi/4QowQV4ShEloAFijaXQhrGavR0exOepFdGFpiUOTKT8eQ5Gxk3mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n7JKL7U4; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n7JKL7U4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734119595; x=1765655595;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tf433BKe0rLXUi09iqWIXmMMMwKiAuJxMovfdX563tU=;
  b=n7JKL7U4YCwWzlk3/EhZmUZhQxICQG+hGVkycP+Z69p+2LFsqajVXyht
   uJps6z+vBwo3eh2NkWYfGz8LsuAExALZjyYuVlOutI2s1DsHH5z0ML7Tr
   29cBsfaqbfTBxrIIiPMUhw2HdwVy1qMNzZwRjeMBSDQ3WTfS9fUSsDrXJ
   j+TRTcep50DZltF4v6Dc5QKJ/OUXEfbr21YyLHzJt0JA46hS4+FTWpEgG
   sDf8bogfsBcWyZmuhcm+S5bgLQdLu+25CIc7cstGd96u48szFf+dvdqS+
   +WIj7oAUl7xSVXrQGMpwAaQyQ/sPIlqmoM1zOUH8F08rlv8APZ/iyJgqt
   g==;
X-CSE-ConnectionGUID: zM/exG36RO2af1rhEFyHWw==
X-CSE-MsgGUID: VqGmoxxoTU+UmsQO3itayg==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="38263556"
X-IronPort-AV: E=Sophos;i="6.12,232,1728975600"; 
   d="scan'208";a="38263556"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 11:53:15 -0800
X-CSE-ConnectionGUID: psMimCRKT3uANcCbdOP5Lw==
X-CSE-MsgGUID: Q8yPZ/CQQsSDO+hAE0jZ6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,232,1728975600"; 
   d="scan'208";a="101468281"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2024 11:53:13 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 13 Dec 2024 11:53:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 13 Dec 2024 11:53:12 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 13 Dec 2024 11:53:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIx893SdWdXZQQUolCoSl70brjfjMdP8yRrsTlqy/9BzzqD9kWk2ynmpVD8rlb5rLr0JGSvp7+uw4Zm8M0UhG4KsJ50slQYAD27RJP//oJLUc6X9myJp6gKsZ09GDtkmmdEWkyyw/TBLjGJqd+t1YFflPZBaqyG3k0qeqR7yt7womd2PB5nKrg6vyduRXZA63LEIbCK4UyP4jE91Bp2+4JfbEAyBET7YRlkPzmMy9UL6pZeSJITz/fC+PFVhSS+17wX/dTz0Kt/O4CahIx3pLo0PmcwSupM8NJ83FR6OUuxXkdZOIbSEdnLFPsRe9GQJvZhe5g7+8QOkxsbqDTW1iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tf433BKe0rLXUi09iqWIXmMMMwKiAuJxMovfdX563tU=;
 b=A/YJT7dYUe2P1GHAelyQRBlVm7mC6aKpoAxK6m6djCZfya/XdWkoV9OdDN+iSXWgGiGVGjTP1mJgiUfz2qwzcTSQVwqD0ltg0gJa3yfOwSitLM/e8U9Ff8smv1YkcGiT6gS9LgHB+6NIsttRenkgLg3pUjlw7YKIEQq4B6EJbsYxsMI567jvwo/VgdLXPottC2+Lwhfe/rWDgC3OghEeteGHk0sNPQP9/YR5/TMbxwkYpApm0PhrLrhFrMz610msfFmfQWIUDeLRV/f2RrO0fbqUJ9LiNiEvgWvDFEWkepl0cDui58Sjadrsjlx2uYanLw4dWi+0Kg7hOjJqbModjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by SA1PR11MB8319.namprd11.prod.outlook.com (2603:10b6:806:38c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 19:53:10 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%7]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 19:53:10 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>
CC: "irogers@google.com" <irogers@google.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"acme@kernel.org" <acme@kernel.org>, "namhyung@kernel.org"
	<namhyung@kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Hunter,
 Adrian" <adrian.hunter@intel.com>
Subject: Re: [PATCH] perf script: Fix output type for dynamically allocated
 core PMU's
Thread-Topic: [PATCH] perf script: Fix output type for dynamically allocated
 core PMU's
Thread-Index: AQHbTPcTVeAr4JlFVkOKIA8g2nIB6bLjwWgAgAC/2YCAABYVgA==
Date: Fri, 13 Dec 2024 19:53:10 +0000
Message-ID: <c7e865010699fc10c1e16b2720c31feb6beb5357.camel@intel.com>
References: <20241213003609.564709-1-thomas.falcon@intel.com>
	 <fb6f17b7-8ee1-4197-afb6-923b372965c2@amd.com>
	 <66df2821-80a4-4ec2-b326-d0edda8fcde2@linux.intel.com>
In-Reply-To: <66df2821-80a4-4ec2-b326-d0edda8fcde2@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|SA1PR11MB8319:EE_
x-ms-office365-filtering-correlation-id: bb5048ba-4ada-4b7b-a1cb-08dd1bafc585
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VllZQmpFaElrWXltQW5XUEJ3SHd0TVJGaGdqeXdvT0twRmpSMFlpeU9vT0tT?=
 =?utf-8?B?cElERUNRY3p0Tjc2NmxSVDdPdExtQjlyKzZ0dVZHb0R2d2pYaTF3bEtaMFlv?=
 =?utf-8?B?TGFCV3Zib1B3aVdwT2pGQ1BCakc0TytlUnNPaFF6OExJYzdMQ2hDRUw4Qksy?=
 =?utf-8?B?MXZlc2xOK3gvUmVNcFIzY3Azb1NFekVwSjNUbjlQTlptUWQ0TFNDUnBiaCtq?=
 =?utf-8?B?U0xicTI4anJTWDlBOFdMMEV4L3dKWXhDL0c4YXI5R3JDRmZzekhoQ2ZrMzlJ?=
 =?utf-8?B?Tm1KWEJFZ1QxY2o4OW5iSjIyTnRoRnQ0OEVzbGsxd2lIM1JBWXlaK0tuVndY?=
 =?utf-8?B?OEZnSU9hcWhqRlBTbnMzTHU4ZjZCbFphVkt3cWExWjRLTVBsMWNYWFRZeEFi?=
 =?utf-8?B?TEdzRW9taThBZkRoVG4yZDZkNWpSUEZKT0U2WllNQ1E5VEwxTmdJdnhFVkdt?=
 =?utf-8?B?NHhoeFJWU3Q2VEd4cUJJK1pFa3FOclBacUpwTDVkbEVISCtqUGVXTk1IOSt3?=
 =?utf-8?B?YXl1R0dhZ3YwWFVadXpwbWZwZTlLUi9OY0N2bXpDVVpCOHR4RG8xVGVUQlJE?=
 =?utf-8?B?dzhrVXNRZVYvRENyV1lLUG1xNFVvQjZpUWxSdWlDYUpoeEs0V2dROXNDZVdz?=
 =?utf-8?B?NWdYZWtCVWpzS2ZvU0Q0RmZXM1hGMUg4cC9BWUY4TndPbGtONUJaVm52d2p1?=
 =?utf-8?B?OFNPUjE2Q0luWGU4UGh1cnhPclhkQVBacHd1bWh2a0ZtSlpKYS9xa2pZWXNB?=
 =?utf-8?B?QzBCUXBnWFozOENDaCtXakZDS0phd2dCaHJIUFBNL0dFdExoZlVEUHRvWmZw?=
 =?utf-8?B?ekhldkFUWS9SWmg4L3N0dzVxUXdRU1JWT1ZuNnNtd09KcEZLcENyWDdPZjcr?=
 =?utf-8?B?TmM4UDVjR2lFWjJNM2V1RTNUV0Zodi9TU0E3blhZYU1kN09sSkY1RzJ1WldN?=
 =?utf-8?B?UDdTUHlGSUNOSGduWW9tc1N6a2UvMWVhVDh0bjJhK1Vmc0Y4WklWSkZoUlVz?=
 =?utf-8?B?S1Y1UUhlSkd3OGFvcklqblBXa3NBRkd4NnZjdUp5RDVvN0JpR3hVamd1bDhD?=
 =?utf-8?B?eEtQZGxIYWlFRzVIa0lXQmFqTDZBME96QXFwRVZnWHRpYlVlT2tlREpYQ2xa?=
 =?utf-8?B?U291SXpzVlozSmFYRDJ6cE9kbmJ2cENyRmFDYW9tS05neE9WRi9YQlpLYTdE?=
 =?utf-8?B?TWJBV2sxZ05JazdlczdsS1N5L244enN6ZEtJNzB6eGJMSjZMcXZwbTZvaHRm?=
 =?utf-8?B?RXBtTThkRnJoVUtCckh3eWJqN3pORFhVWW85cHk3T2hReDNUY3dweUVZdzVp?=
 =?utf-8?B?dHFnS1JpZHRiZEx3aFBmdkdIbm1XVWxuVHFhOEUwcnkrdVRUTXR2bjM0N0Ja?=
 =?utf-8?B?L2xJZFVXZzUrRzNpcG9EbithZ05YQllYbWsrbU1ZQWxaandUS0xVZEhTRC9O?=
 =?utf-8?B?ZEkyN0RDbWJFTGhnRytsMkF4UDByc2MxK0ZlcWF0aHZJb3pjNEZkWVN1Kzl0?=
 =?utf-8?B?bTVsR2tFMTJEWVJrMm1COXhIU3M5SUZnM3BtdmNnOUVVb29NYi9zS0ZCZVZH?=
 =?utf-8?B?d0NkZFk0K0VpOUh1ZDdTUWpXR1JVcmpwOUpXV01ySkFHNmM5V0pJOFg2VXp0?=
 =?utf-8?B?eUJjaW12VEJNR0xtUzhvdkJaTktjL25jOGcxK0pNSXY1cUk1VzNzMUFWazk5?=
 =?utf-8?B?QktnTGcrOC9vOEQ1Rm84aVJoRk1QSHA4Uk5WMEhLbkM1bGFRUWhQcmFoSkJY?=
 =?utf-8?B?R0JvTnFLYmNqQUthZmZnWGo3ZzhCYmhBTkRxWThwODlLSDF6Y0ZudXc4SEhH?=
 =?utf-8?B?ZmhGZDhLazU4ZGsyWVlZWXAzYzFuNU5rMHQyOUJaUkNHenNxRDF4OEJpamxa?=
 =?utf-8?B?eFNLejJmVDUzek5zWUFJcWlaVWxldTdaTzhjeUpUUUlsd1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OU1VSnNqMlU0STgzSStWNFhPWmpWbTBTbXJwZ1l6WnNjQlE4VDRlWWltak5i?=
 =?utf-8?B?UHRzQ3NEWmZ1T2ZEa2sxcUFoR0xEZHZvRkZobU94UjY3aDVVWWcxdW52Q0hH?=
 =?utf-8?B?R1BGR3dTeUl0dVhBbnVXVWx2LzFzb2tnNWtmQXZDK3p1clF5Zm8rbkhrdjdx?=
 =?utf-8?B?RTdXbndEZzJnTjFONE51VkZaa1VxTnpSWlgxUFVmSzZGT1g3ekNWZ003Vkov?=
 =?utf-8?B?YVFpS0hIVXdYaUk5VUFwZStOclVnRkdDUXBXRXdDakNScG1lMnYybU9yd1pE?=
 =?utf-8?B?dlFPTGg4dmEvNTNYWTZTa2RpTUVYTWNLOVVmc09IQVBTcXNqZ1hsU1c3VGs1?=
 =?utf-8?B?WGRHNFJxQXZhYXpqSkt0RE1YbkxkbHh1RkNJVDR4dlBuK2VaU3NDVHk0RFpF?=
 =?utf-8?B?a2ovTDN4NWtwSlRDUDdSVyt1aVFLVnpRcXYybHoxdzc3QXJlbXgyMEFOazZZ?=
 =?utf-8?B?aGFoelVHLzNVNWNNSTh4RktkMStFOVJ0aDRxelBaLzZCY0xpblZESjVyVW50?=
 =?utf-8?B?bzJmRlVjeTFJbTkzb0pqZ09YTGRtc3N0YldMNDhjY0duTE9LTzNIRDZQU2NL?=
 =?utf-8?B?UVpDMkR1c053dWwwMkVxNmoxWWl4MVA2cDNlaTh0V0V2WlFXQlBpTThIQlh1?=
 =?utf-8?B?SzZPblp5SzZRdkRwT2p2Y0xWd1FnWGF3TXZXVjd2V1MyVmFQTFoxRWU3YzJm?=
 =?utf-8?B?UW9rWkZJajV3WFQybkVnaWthV05jNmVhOS96c2xHMHFTMEJQZjUwN2FFeTU3?=
 =?utf-8?B?MjNQVFkyVnJiU0ViZDROU2J5djVoSWxHbnNOREVEUkhVS3RScEVwUHN6ai9l?=
 =?utf-8?B?U1pIZmF2TXNsZ0VkcmpZSXBLOEhsVGZtLzJYUTBOSEtBT2JRQi9PRmhqRDBB?=
 =?utf-8?B?OWJ5UlpJMUthZU1LakF3MmlQY0JlT2RIelE2YVVMNVQxeGxhb1pnZHgzTFM0?=
 =?utf-8?B?WEY2akZHTTJMRWFBb3lma2F6MVVlNk9mSDU3MVU4TE8xaHphclNXeEM3T3JB?=
 =?utf-8?B?dlRjbkJiMW9jY0k1d0Z5YUhXZi9uOXpKYnNZSm12R0ZrOEVGSzJ1eEFYVnpC?=
 =?utf-8?B?VzJoMmdkcEhwM2JLMEVEdXRoSk44cWh0SnJ6UG50WnZZVjdBTGdMZnhMWU5t?=
 =?utf-8?B?bWdkQmFjTjJFR0x0aVBMYnl2eW5NTUtvb09TVHRiUTk5cER3Q3lYeTczc0Z5?=
 =?utf-8?B?L2VsSVg1VWF3Z1ZadzZJT0x0dFNXN2YyVGV5WUU4cWxDTUw3d1ZwZDREU25t?=
 =?utf-8?B?OG90VHRBRmoxelBsNDRzMFArZEpTc1hrQ1FoUEtCMFV6WjAwWlRRc1BHL0RE?=
 =?utf-8?B?eUtCdks2MW9qNlNIWFRoNGd5cXE5N1J3QndYWCtEdGdWMjlwd3FuNDZqTVFn?=
 =?utf-8?B?cHdEdm9UU2k5d3VmZUNpa0N4NkxESkI2ZXRTdEhqeC9ESzRCbHFMalBiempK?=
 =?utf-8?B?amNiSG54aE5CQUtwbmFqaDhCd0cxT25jUVI0VzQyaXJIb1NIcHNTdXBndUpa?=
 =?utf-8?B?WVRxVlFyeUtUS2VGNjUyZEZ6K2NlTHpDdDhMQmRiMS9LSmFrbklpcjM1aFRx?=
 =?utf-8?B?bGtzRU50WDI4bCtZcTB6UEN3VGtaZUJUc2pSWXg3ZDV4ZVNiVVYvaFptOTY3?=
 =?utf-8?B?OU1CeEZOYTBUcFUwemxadXJTRlVybUJEZUVzOS9JZVdDMnNaenNGVHJZWDZ4?=
 =?utf-8?B?WExBbjBKTWdTdGJobmZ4clZBWTRBR01xdHR4NlFRRVo1VTIrbWNpQUI5ZVhV?=
 =?utf-8?B?TmFBZ2M5OEdHeXhBN1NxVWwyZHo3cDR0K3MxTUdpdWVkcEp5Y1VpYU1TUTEr?=
 =?utf-8?B?K1QrOW5GOERqNVoyWFZDWnViendXWDAyT2FQcFpLajRhTU1KVVRXbDdEYXlE?=
 =?utf-8?B?dXBwMG9XV1RWOUhrTnJPdnhqd3lzTFpCN3JkQWRDaTlkbGdpZ3A0MDgrT2Va?=
 =?utf-8?B?OFRxZmVpNHhWTmJtOE1Yc2dIYUxtdHNnenlPWnFJaTN6VTJqOUw0M3hnMFFv?=
 =?utf-8?B?S0J1c0VUWDhVRHpSdTVCTnJHSjZKVGt2NG5SL0tuRGlTY2g5SXhObGF3ZXh4?=
 =?utf-8?B?dVMrUGcxbmk3MmdBN1B6c2VPaFlobnBPR3p1d0R6U205NGJYNTd2K095QzRp?=
 =?utf-8?B?SHc0eWZmYkljRnhvRjRPc1RHQTd6cGdZdEpBM0NMbFRpQUFISlZJUFFMQUtH?=
 =?utf-8?B?RHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1FE8F9D1CCE9045A957768577358DD4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5048ba-4ada-4b7b-a1cb-08dd1bafc585
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 19:53:10.2994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ggMWmf7m58kZcq9EkXWjsaoww4e/6P22mUf3qfqCqDR1e9F/9Lp2p7JTa1eRTUF4fWOnMxJBY6PbGfPHW5IHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8319
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTEyLTEzIGF0IDEzOjM0IC0wNTAwLCBMaWFuZywgS2FuIHdyb3RlOg0KPiAN
Cj4gDQo+IE9uIDIwMjQtMTItMTMgMjowNyBhLm0uLCBSYXZpIEJhbmdvcmlhIHdyb3RlOg0KPiA+
IEhpIFRob21hcywNCj4gPiANCj4gPiA+IEBAIC0zODYsNiArMzg2LDggQEAgc3RhdGljIGludCBl
dnNlbF9zY3JpcHRfX2ZwcmludGYoc3RydWN0DQo+ID4gPiBldnNlbF9zY3JpcHQgKmVzLCBGSUxF
ICpmcCkNCj4gPiA+IMKgDQo+ID4gPiDCoHN0YXRpYyBpbmxpbmUgaW50IG91dHB1dF90eXBlKHVu
c2lnbmVkIGludCB0eXBlKQ0KPiA+ID4gwqB7DQo+ID4gPiArCXN0cnVjdCBwZXJmX3BtdSAqcG11
Ow0KPiA+ID4gKw0KPiA+ID4gwqAJc3dpdGNoICh0eXBlKSB7DQo+ID4gPiDCoAljYXNlIFBFUkZf
VFlQRV9TWU5USDoNCj4gPiA+IMKgCQlyZXR1cm4gT1VUUFVUX1RZUEVfU1lOVEg7DQo+ID4gPiBA
QCAtMzk0LDYgKzM5NiwxMCBAQCBzdGF0aWMgaW5saW5lIGludCBvdXRwdXRfdHlwZSh1bnNpZ25l
ZCBpbnQNCj4gPiA+IHR5cGUpDQo+ID4gPiDCoAkJCXJldHVybiB0eXBlOw0KPiA+ID4gwqAJfQ0K
PiA+ID4gwqANCj4gPiA+ICsJcG11ID0gcGVyZl9wbXVzX19maW5kX2J5X3R5cGUodHlwZSk7DQo+
ID4gPiArCWlmIChwbXUgJiYgcG11LT5pc19jb3JlKQ0KPiA+ID4gKwkJcmV0dXJuIFBFUkZfVFlQ
RV9SQVc7DQo+ID4gDQo+ID4gTWlub3Igbml0IC4uLg0KPiA+IA0KPiA+IG91dHB1dF90eXBlKCkg
c2VlbXMgdG8gYmUgZ2V0dGluZyBjYWxsZWQgYSBsb3QuIEZvciBleCwgZm9yIGENCj4gPiBwZXJm
LmRhdGENCj4gPiB3aXRoIDQ1MzAgc2FtcGxlcywgb3V0cHV0X3R5cGUoKSB3YXMgY2FsbGVkIDE4
MTI0NiB0aW1lcyB3aGVuIEkgcmFuDQo+ID4gInBlcmYgc2NyaXB0Ii4gSUlVQywgdGhpcyBwbXUg
bG9va3VwIGlzIHVubmVjZXNzYXJ5IGZvciBob21vZ2VuZW91cw0KPiA+IHBsYXRmb3Jtcz8gSWYg
c28sIGNhbiB3ZSBtYWtlIGl0IGNvbmRpdGlvbmFsPw0KPiA+IA0KPiANCj4gQWdyZWVkLiBJIHRo
aW5rIHRoZSBzZWFyY2ggc2hvdWxkIG9ubHkgYmUgYXBwbGllZCBmb3IgdGhlDQo+IHBlcmZfcG11
c19fbnVtX2NvcmVfcG11cygpID4gMSBjYXNlLg0KPiANCj4gV2Ugc2hvdWxkIGp1c3QgbmVlZCB0
byBzZWFyY2ggdGhlIGNvcmVfcG11cyB3aGVuIGNvbXBhcmluZyB0aGUgdHlwZS4NCj4gDQpUaGFu
a3MsIHdpbGwgc2VuZCB2MiBzb29uLg0KDQpUb20NCg0KPiBUaGFua3MsDQo+IEthbg0KPiANCg0K
