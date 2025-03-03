Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345A684A3E;
	Mon,  3 Mar 2025 18:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027160; cv=fail; b=bAeHkynyHMqlbXCXQrYasbk3pVa5fGRKGLY6Jx4EesHjg0XbVLjgVLCA5mbO8Fv3e0gaPzVdFsoVxmD303Lm49tMtcGVgly935BHWvY9EcnEbR6/IwoZlt2YoaUfy18Djj4pMimpZX8R9ryuiZIfmwuyrpfhxGHyf0U/VrueK6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027160; c=relaxed/simple;
	bh=U2keDVldpR+vuhrW/Kk6MhqBcI33XzE5seOsm8rku5M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l/cWP0a5uUl/NFNkgRHcBmoedb82uoWoVqvAEtPuDjKoibRolcC3/cjKoQl9IU48kZz9wgjJNmhbHsXinypS0lrlRlclSxQG08uRL9wnUzphhrbNa00sk/iq9QX/aQIEfC85IfSWtK+5GWP/+3HjG2VKSMY4zl0eNzDqIOy8Fsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S/d8bHme; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S/d8bHme"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741027158; x=1772563158;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U2keDVldpR+vuhrW/Kk6MhqBcI33XzE5seOsm8rku5M=;
  b=S/d8bHme/+mYbamLwAwx/mc0QLKPfvhIetPpJ/dnzDUA1bdH9ZmPv3Gk
   hcVxDMq/EtCCslVw0fc0EHHcMOWDjv+dFRpJkmpztS7ASp9ERtyQ1OEiV
   4lA4vshfUZb3eRRzVH0NQZYAZzHmw2YjTSLeMzUaAKuZT9nxy1RjeXTmF
   0FrXnun9zXKUydEUd3Aw6uh5c1qLU2xnPj3ux2bpFXPYLTdfHqjYGDqqw
   op3hfA/2kycIVHTPht/DoJ766hX1ESIorb+s9oPGnbvfyczT1pkb1TMyE
   gbhmCUiTqj6pg0KgG1NDWLNzdUbWiQ4jkR/ogLAN1UcWXnxms/hB6lWYz
   Q==;
X-CSE-ConnectionGUID: yHguVL2UTDeS4kkUQFXHrg==
X-CSE-MsgGUID: ue1uVRTjT6u1OKM1yWoOoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="42037808"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="42037808"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 10:39:18 -0800
X-CSE-ConnectionGUID: D/kgO2MXSD64U48yK7O2xw==
X-CSE-MsgGUID: PKTcuOXBTxSdw7U37rVbSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123358508"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Mar 2025 10:39:17 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 3 Mar 2025 10:39:17 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 10:39:17 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 3 Mar 2025 10:39:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9r25bTaWp6JPN71VTSXZBTUj5p12QPYNUX3HSlK9Iq4kwVDTQOhnEqDXLN8IZnOV6Szu/0U6BamWKm4Eyrx8r4+4/dbU89Zw8NB/r8m7NQn3pXuLp0e+OgA7MKByvEKfOiTlvoYdzknFmS2OCSlTVBHxjnzI0GiOSeN6lFuLyKNdyo9NDYL3UK6jXo6KhZzNeh1Sotrn1L1Qx03vv4ALyyZBfZ86sv3amiLWe/md6g4ppxrqdPGOqhm3Kh84XOrh4kU4naqJ5ZvTb0Qt5PyEXSpcxW4iAw9bQ6RUGYsA83XT8g3rupQDa6/kKfMn5pS3SoIgwg5wbBnv0oVie7HFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNEMcijvPEbnWteBdG/JQGiH94jTP0xm9bkdgeRaTww=;
 b=RHZiufcw1ZJlgGtxc7/PtTZM3KbmK0rU/SjxDTvPPQTSGo648nvcewdqfbvq+pO9Eex6BifG+oOAuhzFU0CVYy9bD08Q2O2GbdRmw69PXqqmeukVqI4IhLCzgEVDj7MbgcSqaq/cNefngyOju39EjntUkCXAfGJNpqiYMkw8tq6p2Uq6BXaKuN58u0rOAVlWI4RKp6lYFkD2AnZNUTGU8s4fGybUdc6fOaorJuNZZMmp8+QEgOFyRYuqOhCL4hSTR+ZHK3SmNbNaZXozjTdWjaJC+C5wne7N0bPGdsRM46SvEYnBFYKeLHo5h3hQnQVhMno4H2MdE2XboKGLitNg/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by SN7PR11MB6679.namprd11.prod.outlook.com (2603:10b6:806:269::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Mon, 3 Mar
 2025 18:38:59 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 18:38:59 +0000
Message-ID: <c227a1c2-13a4-4078-87ee-ed3fe0638060@intel.com>
Date: Mon, 3 Mar 2025 18:56:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/12] perf script: Make printing flags reliable
To: Leo Yan <leo.yan@arm.com>
CC: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>, James Clark
	<james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Liang,
 Kan" <kan.liang@linux.intel.com>, Will Deacon <will@kernel.org>, "Graham
 Woodward" <graham.woodward@arm.com>, <Paschalis.Mpeis@arm.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20250217195908.176207-1-leo.yan@arm.com>
 <20250217195908.176207-2-leo.yan@arm.com>
 <34795c29-d256-49ce-9d01-435f8cd91611@intel.com>
 <20250303162210.GH2157064@e132581.arm.com>
 <447bcafc-4c47-4b95-bf21-7aee2cb6a629@intel.com>
 <20250303181152.GI2157064@e132581.arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250303181152.GI2157064@e132581.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::19) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|SN7PR11MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e4e5bd-170f-418a-0573-08dd5a82a980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1YrVzlOOVNIa1NUc3BjcVVVakcrNE5jVGxyVkt4Mzd1TjRkY0ZuT0N5ME9U?=
 =?utf-8?B?MXhkNDQvRDVLOUo4Tnd4WlZYMjhTc2JwMmd4ZDRHZUF0TmJyVERHalJ5dEFi?=
 =?utf-8?B?Wmk1ekxkcURSTGtwVWdra1l5UzJaakVoU1hDWVRyY2haRE9OOElsWlAzSXhI?=
 =?utf-8?B?c3VzVFE2UUpzQnYyNnVSaXJjQllDOHZYTVNuSHNlT2lNWWU1ODYvVDhoQ20v?=
 =?utf-8?B?WnNKcnlhVUN1WVh3akhjakNtVyt6KzFFYTRLREViT2hSOHJ5bDhQVFh5OG1T?=
 =?utf-8?B?VGdacnltejdyckFwcFROb25Fay9aY2RRditGdjVxVm45WUdwUW95V2NIMWVX?=
 =?utf-8?B?N0poeTVkZFpuZytCTVNzbkxzOW5YSzQyUmh2R00vN2huQ1lDc2V1RHVzU3dX?=
 =?utf-8?B?T08xR3dZS05XWS9kMGZaK0kyQkRXNEFPQWtrNnVud2RLWmJ4NGx0ZHJTU2pC?=
 =?utf-8?B?QTdPUDY2bE1qL3cxUE5YWVhVYktGTE5wWmc5YkpsNzJTaVhxS0tBMjFVQ2tl?=
 =?utf-8?B?NmVHQi9BTjdvcnRKTnh2T1NEb3p0UUJEOEZ0d3BmamhXKzFPSWNhTjZTY3B2?=
 =?utf-8?B?eHc4VVpMeTVhMUJzY215YXhiWi8xRnZ2N2R6akNCZVMxN3RHOElyN1dNSGpo?=
 =?utf-8?B?Tk5Sayt2YTVyazBsRHFLWWFBU3BXUUxzYlA3cjJ3K3V5eXBCYmdGaS9kKytD?=
 =?utf-8?B?YzVEMThwbldqU3hISy9GOUZ0Zi9jekgvaTlFLzhicDkrTWdMSHZjOVZweVIy?=
 =?utf-8?B?c1oxTy9SaUxVWkR6MVhvNlFmb3RkL2JZaVlKc3ZwQUtYUFhyazRGUlh3NFgx?=
 =?utf-8?B?d21Tb3RWLzNvbk1tOGtPOGNmRUpCQXJGcHJaM2JJRnRqNlhOZkptenE0a3oz?=
 =?utf-8?B?eFZNWnd2VTdXTHFVM0llOTdka21QK2gzWW1hR1BIWFRmUEp5ZENPZlFaMGcx?=
 =?utf-8?B?SURIR0dDVmxreExVRkVTVm04Y05UWUxJR09sSWdQQ09LTXpBcXh4U0ZaQ1BI?=
 =?utf-8?B?d291VmlUeS9mYmJBZTVOeVdvUmxSNkV0NVdVY1NLMDVEeC9lSjVhWldMY3Bv?=
 =?utf-8?B?MklYM0FLc28xejI1WmpSOGY1R255RnBkWEJ6QWxKTi9JVktYMDZUekJNRGha?=
 =?utf-8?B?WkI1Mmd0WWIyKytPUnQwTlNjcWRiWjN5Vkt5RmMvMHBKZ0R1OU02eW5oczJl?=
 =?utf-8?B?OUFXNU43TVhuWDBpdkhpRlRJcnFtQkRHVFFEVjZoUEFxbmxYSXoxNU1ZZkZv?=
 =?utf-8?B?dlkxWWNPYW1wcHMyUVcxL1Mzbmt5RDNrZGFjak9HQ3hjTHY0L2duNFUrTjlU?=
 =?utf-8?B?NHJmb0RkOVlHaHI1TlQxRm9ESTdsWEVmeklRc1A5Z2tJQ0htTFBoUC9OSGFE?=
 =?utf-8?B?NU5UNXlCU0xvU3Fjb09MNGlucTFyTWRiYVBsQ09zdnk0ZldjMnZLMWhkdmo3?=
 =?utf-8?B?MFg1cG9yNlpCdmRMS0dUdlV2bWtZVFVMS1NRSytmNUtRMlFoNS93RDJ4WWVx?=
 =?utf-8?B?WW1Cb3B0V2llT3FxWUJMSTBjWmJZdTBRTEFGTEdsWVg3U1l5Z0gzejd3WFNN?=
 =?utf-8?B?TWJaTGY1YTExYW9BUGcwYnpLYUREZWNOekMxek9JN2lLenErM3hmd1NWSEVz?=
 =?utf-8?B?UU5BdEtpd2h4djE3Ym1Qc2RjKzJFU1draTA5SXlEc3FTdEpMWHBRMGlxQklS?=
 =?utf-8?B?dVgxVys1MWdob0x3ZzhjTUhkS0hXdVpuTzBpWTlXYmxqRDhHamhTS244YVkr?=
 =?utf-8?B?K0RpUHBUbnpaQmlKMG1NaEpxMUxISkxJY0d4NDV5bzFCcGhhUmg1cmhaNGtM?=
 =?utf-8?B?TzBVQ0dqN3hyRHhKbkRIS3lpZFEyWjkwUnpKOUFQcTdWaXd0aWIxWnEzWEJM?=
 =?utf-8?Q?qtVp6ryUnp20L?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N28xRjhoVDh4STNlNWZ2M29Ka0hRUVpRcytnS0ZEWmtDQm1Pa1F1VjBTc3Bh?=
 =?utf-8?B?YmZLQ1g4eUNRVk5qZWtFTFZMWUNGRnpOR1Q5TjBldEp0NGV4TGZHZzZITjRP?=
 =?utf-8?B?QXlaZVFtd1kzc3FMd0drUnB6azZXUTQ1aXJoTGJHaG1oUUkyT0F6N1dyWDNN?=
 =?utf-8?B?aFNVVXBoSHczdVFmYmdKakdWTk0yUkkzTzB3VHdiS1JmaUN4UUlraUllYlc1?=
 =?utf-8?B?NWVPL20rTXQreUtPVUc3M01lUENmU2VaaUN5bmdMNnBCaWw1RTcrd1JORnRK?=
 =?utf-8?B?Y1huaXFpRnJOL3BKU1pPckxtUVNGL3F4STBwZ21vK3VNOUZncmlxNFVPcWQv?=
 =?utf-8?B?dnduVGNBYWFVMjRmb2VlWGxldXJxRFlRaFlEd004WVZ1OVEraG1rMXlxengx?=
 =?utf-8?B?cTE0dDhlWjRrNy9Tek1hN0s5NG1VZzBDR09OMnhFSWc1akpxb2pqN3ZJeFhQ?=
 =?utf-8?B?OFJWWERSS3dnRTlsNTRGK0dvdWFzaFlPQkJSeWI0bHJZTEZzdFY3dFFOZVFW?=
 =?utf-8?B?N0k0RjNvS0N0RGlNa3E2dFd5TWdCOWRVNFMrVFNtTzdSZWM3dG9jRDlnTnVw?=
 =?utf-8?B?aWd0V2NTWU5LbWFNNVFPd0JRaitFeURRR2lCRDNRcHJOS2Y0Sk5rb3MrdFFD?=
 =?utf-8?B?QlcyNmh5TDVQbWtVbXNVcmhyZ1p5TjY0SGdRUzQ0OE14eXEzdzVvemdNeG5C?=
 =?utf-8?B?TlFHQzNIc0dMeTMvQmx2anhUeXI1SGRhVXgyUU84T3BwUDNKQ0dqL3YvbVlk?=
 =?utf-8?B?YW5pMThuZG9WbTR6eERRSnQ5OVBvZmhqMWc5dFpmaWpmS24rWXI3ZHZVMHdE?=
 =?utf-8?B?NjBQSEJqOHd1Y28wcUc5bmtRdk9PRmMrd28yUDB2eEVLOVUwSlAxdTBwQ05F?=
 =?utf-8?B?d0pVcUVMYUxRa3NqL3VhSEtNWTBNbklQMGRBZVRja3Ayb1NWUlZJS0MvNzMz?=
 =?utf-8?B?UWtCaWlveHY5c3hmdGNjakFPbDBjU0FyRXJhd0xkYlJYQlFrajVKV3ArYng2?=
 =?utf-8?B?Uzk1ZjVlOTBINGNBcmFRSTFiNFVwakpiVWs2bTdxVGZYUjc2ckxuOUZHRTQr?=
 =?utf-8?B?RUxpRktmV1ptNDVUTjhBVFA4UDlYWXBEMzBDd1ZUTXFqVlQzemRUTmxkaFF6?=
 =?utf-8?B?SmNWU3hjUGI5ejVBejB1cVlQc2QxUzg4QjlxNWdpWHJmRGtBNGp4WmxYdXZH?=
 =?utf-8?B?OHJzTnFZNE55a2w3RFJnRk9QS2dqVVh6bEFCeGtrL3Rkc281NTdLTTM5SXdS?=
 =?utf-8?B?TkIyRGVjSENYRDhzMlVYUmVGY1hNMERMd21Tc2dyK05tOGtSWFlvWW1yT2Jj?=
 =?utf-8?B?eDU4ZGFIbHBiYlN2UGdmTmJLT2FwRkx1ck5tZ1oxUnl1VDYxakU3d1hlc2Vm?=
 =?utf-8?B?M2dxYzJ0d2tSTnpTdnlCb0tZQ25XN3hjWEJwVHk5aDhlNGY0Z0djWWZRNk0r?=
 =?utf-8?B?TTYxUXFDeVo1d0RGVWhsajF1MXNlQnZpVnBGVGozdUR0dk55ckoxZCtzekZP?=
 =?utf-8?B?NlFvVzRqeWJTZVU5TC9XdnR6clRoZk0wajR6VDFnMzlaOUZzbUFoc05NT3Yr?=
 =?utf-8?B?T3B0c3JoZ3Y5N0RCS0F3MnI2Z0IrSWFWZU1XVlpHOEVTdHYzTXliN0Zzb1oz?=
 =?utf-8?B?NjZ6SUlvQThwV3BDZWtzeVUvOFMzeGhDM3BhVmFLL0REMituOEFGZ1crZkdo?=
 =?utf-8?B?QjREVHdEbzU1SkxyMHYvS0E0bU1mOTlMTnZPTFRiZUo4Q0Jsb3YzaDV1bGFX?=
 =?utf-8?B?NTRXRGRUQ3I1MHBFSTBHRzN3SXYwRENyUG5vdzdPdFVMV0VmaSs3bklCcVcw?=
 =?utf-8?B?Q2tDR0dQUGwxbWFCdU9MSlpHYWlKMnBOWlpQNnhwVzRJU24wVHVYLzdIQ2VO?=
 =?utf-8?B?SGJSSTllMjAxdTNCRnROaTcvVEx0VnNBNlcydFRCQ2x6eW11RW10aUxrTnhk?=
 =?utf-8?B?V056dVdsUVhQelRkcGlDM3ZMOXRnS2ozVGdBZEwrdHduYW1aWFJ2dFVlZXlW?=
 =?utf-8?B?R1lCYnV1UXJFR0lpa040Znp3QjhGcjVTZDE4YVhCODZMK3c1UTN2dmY5QWRs?=
 =?utf-8?B?UGlhdi9OSnZtWXpKNjRrWkRMOFNOUkhZcWFncnpMTDQ2eDJWRno5S1FQY3lm?=
 =?utf-8?B?WmZiK3BkTHAxTjhGS2xwZWNZcE1HeHl1NVhhU09Ia085bUpWTmdGYkFKaWZ4?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e4e5bd-170f-418a-0573-08dd5a82a980
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 18:38:59.6355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQazGmmjnJ9kZNsl96L717IhTvWciXAqTFYa7o64pP5kcv1YzQdUiTNuCrYzW7n3XmpZMGeZZH4sQoQY823jGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6679
X-OriginatorOrg: intel.com

On 3/03/25 20:11, Leo Yan wrote:
> On Mon, Mar 03, 2025 at 05:05:13PM +0200, Adrian Hunter wrote:
> 
> [...]
> 
>>>>> +	ret = max(ret, SAMPLE_FLAGS_STR_ALIGNED_SIZE);
>>>>> +	return fprintf(fp, "  %-*s ", ret, str);
>>>>
>>>> -21 means the field width is 21 and left-justified.  It should not
>>>> truncate the string.
>>>
>>> No, it does not truncate the string.
>>>
>>> It calculates a maximum value between the returned length and 21 (
>>> defined in SAMPLE_FLAGS_STR_ALIGNED_SIZE).  It keeps left-justified and
>>> can printing a complete string if the string length is bigger than 21.
>>
>> Maybe I am missing something, but that isn't that what
>>
>> 	return fprintf(fp, "  %-21s ", str);
>>
>> does anyway?  Why change it to something more complicated.
> 
> You are right.  I should have done an experiment for this.
> 
> I will remove the max() sentence and update the last line:
> 
>         return fprintf(fp, "  %-*s ", SAMPLE_FLAGS_STR_ALIGNED_SIZE, str);
> 
> Another option is to drop this patch.  But I prefer to keep it, the
> reason is except the benefit for the debugging log, an extra reason is
> the SAMPLE_FLAGS_STR_ALIGNED_SIZE macro is used to replace the opened
> value '21'.  The macro also will be used by a later patch for
> right-alignment printing.  How about you think?

Sure

