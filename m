Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2502AF0A;
	Sun,  7 Sep 2025 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757256829; cv=fail; b=CPQZGsMLPEtUQdbeU+q5itnEzxjfFippeC35MXXNa9YbFDnAvqL0/OE6ws2h0tje+1x28JZ88OEZNILnpsTcaXCVDt5k/hLAidcdfOlmS1onL6s+eR826mpBYRH5STcueK1T6tD+uhs29fM/7dUTWckyd6v2KOUPF+oQhQiUNVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757256829; c=relaxed/simple;
	bh=pO/hLrPMO+OfkFaoa4WxNv4QU1KOWt9QvYqe1Bq/sHI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DGtdY4i/iYcD4ta1/gmVftZs85hAZF73He/SmpJKX++cKPO3NzhY/MhkfGDu7btvp/7tJ5Dd4WpR7blm+i0JMbNFjx7xPYBwSeNGX868CCbD7mjR5YplTDtyflNX7SkViwXRE/Y93HlRljHIJVL9pVZ12Rs4hefGWFwuOBDPeIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lO+L52Gj; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lO+L52Gj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757256827; x=1788792827;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pO/hLrPMO+OfkFaoa4WxNv4QU1KOWt9QvYqe1Bq/sHI=;
  b=lO+L52GjWg9VLA9WmI7qqITCPifB7J1U0+7AGgGm1CpQ33GTpkqBr+sQ
   WFtwGp9dJXA3XueOjoxSUHCEzEIRBzyT1tT8VbOniozDYUmKUAmP2YCXU
   obMmCUBBWTZjbTBxXqjZBZGWR59G1UxaeFBlUm4JZBhzaLY0NM0rr86TJ
   wiMGhaJKp7bbs/YllooFZtmwxN/Uf5+5qpGENRxKxbxoRnEOB07fwfE7U
   ebw/YscAoDrxa589FbzN1Wirqz7ne5gCk05Jh32Vy1zYJS7yi0FbhpoLN
   2pyZFGOs9x5txwX6m/GojGxYwD4P6y/dmBSTF23GZVSRXa/e++DgaNAdh
   A==;
X-CSE-ConnectionGUID: S9HcZ4gqSuaQLd0CJNVNvA==
X-CSE-MsgGUID: Vpsk0SSRQFmVpSvp6xCd7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="59465952"
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="59465952"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 07:53:46 -0700
X-CSE-ConnectionGUID: Xpn96fUlQ0e6Nt+muaJQdw==
X-CSE-MsgGUID: SHPLkHeNS2m01jEuWEpoUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="176907124"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 07:53:44 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 7 Sep 2025 07:53:42 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 7 Sep 2025 07:53:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.47)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 7 Sep 2025 07:53:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iui192xvdcu4czOzG3r4OKYz97Gl4NTvyvzy9KBXksuOUWwhtEcx7aQ7ymSYY8ie/97OTpVf6cA/5YMOLtF89AGWPAE8ausjEcA2cd8OoowPwmiQA/slTcoAP66sdy4+71exjaYZViv29847BBSaU1KkwJwRaZXOan1npeZ5LMXqzB7H8iegYN+4lRJxVwTXrU90fu2MRa1AzD8/KynIYMxXHT8uSTMs/edAbw5zYH3qBFIYvIuEpXNxG4y8s3ov3gClr/irTj2BccKbcT9Ztnu+oLCVJiiH00Oumzl+i9S2vRgOjG1T3r3RcMPsK/IhrCbp2iC5TG8bWdUehSFUJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+ZHWxitzgcT2fPFtDrHLGVSyfHzK9Bbh2i/EX4DS8A=;
 b=MCbVkLGc6wG+erWw/Dm6DMXrcE1c8R/FsS4feNd+zTfZhAFaHoE623WJT2FQ53jMLEU1UVER2sYRwDqj/+oLbYwgrs2V8VAcCxdf2+N1KlSEhk4InQir2eQnQBHzUGTHKKYT3quoo+rw4K1OvlNCgsMhB4L7WAEzFITdgLvzUSLBiuabHgBiWhonCwCELAqPWbeypYeZLQ5t/Si74VnYPWcoecLvmCXb2NLbpjssQjznoBX2GP5wElFIjyPFPv/2S1Sto549P+C7nWy29RqDJecE+8IW9Pht5QWb1KAisPBNOsSp4K9knHgmCx8GaB2fvJq/bzJtQ2EFIIPJs5LsOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB8289.namprd11.prod.outlook.com (2603:10b6:303:1e8::9)
 by MW4PR11MB6691.namprd11.prod.outlook.com (2603:10b6:303:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Sun, 7 Sep
 2025 14:53:39 +0000
Received: from MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022]) by MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022%3]) with mapi id 15.20.9094.018; Sun, 7 Sep 2025
 14:53:39 +0000
Message-ID: <50921564-d444-4825-b580-94276833a372@intel.com>
Date: Sun, 7 Sep 2025 22:53:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf tools c2c: Add annotation support to perf c2c
 report
To: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>,
	<wangyang.guo@intel.com>, <pan.deng@intel.com>, <zhiguo.zhou@intel.com>,
	<jiebin.sun@intel.com>, <thomas.falcon@intel.com>, <dapeng1.mi@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250801075158.218441-1-tianyou.li@intel.com>
 <20250819080014.515277-1-tianyou.li@intel.com> <aLhHvWTnxGA-_6Ew@x1>
Content-Language: en-US
From: "Li, Tianyou" <tianyou.li@intel.com>
In-Reply-To: <aLhHvWTnxGA-_6Ew@x1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To MW4PR11MB8289.namprd11.prod.outlook.com
 (2603:10b6:303:1e8::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB8289:EE_|MW4PR11MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: 02090ee6-c918-46d5-9f4a-08ddee1e5487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RE52S2JJQ2U1bVZrUGZQTnU5RHEzZytwY3Z1WUNEdzZVSXptb2RCM1I0Q1Rn?=
 =?utf-8?B?OEc0ZDFSc2xFVEZXOGFreC9sU21mckhRd2V1QXRpcmNUaUtsSDVVQlhINkc2?=
 =?utf-8?B?R3ExdUxzT3g1T0E5QVFETytWVFl4T2VMYlFvMmRuSXpzeURGbzYwL1Buc1hG?=
 =?utf-8?B?ZW54dkFuMXNtRjQvT1MxdWVPWmNCZUc1RXBhNUJkUE5USnpUWjNPclpiNU0v?=
 =?utf-8?B?U29zdDFqMGwwQlAzenFCL2lXQWl6K2tLY1QvSDM0c1lhRnZVYk9lcEF6bW5Y?=
 =?utf-8?B?WUlMZ1BsbDZKaURvdzZYQ2ZsVlFzRkdYQk4xQVlrVnRrcnduSUMxckNjalhS?=
 =?utf-8?B?anBMejF5US9XTUp2UkVxQkVLY3FHcGFoRUl6clM5T3hlY3RZTVBJaE0ycndB?=
 =?utf-8?B?TFJySTR6QnFYMS9VdytvUmg0R1VWV0FsUlRWcU03dEVudmxwNlpwbzI5R29a?=
 =?utf-8?B?ZlViMm42aVc0eXFrWXJMOG9lSEptc1N2M0FYelgzWWV2K09OK1p1WERuK0hV?=
 =?utf-8?B?a0Q0aW1lOWYrUzZRUEtiUThDRFJsZG5WSWNyaDhFQ2VBTVNnbnhtNFNWTHBa?=
 =?utf-8?B?Y2VVdWhxUmwwSmQ3d3BPWGZYSjdLZEZyb0NJU21uK1FsUXhQTUhmM3lRM2ZF?=
 =?utf-8?B?LzI1Z1dqY0tqWlJFQmp0RnhpMVJsSHpsSlpiMlRScm1UQjd6WHBPdDhjT1Yw?=
 =?utf-8?B?L2Y0REFrZENUWXRVQ1JvelVXVEpMZE5OUS9HbWRBZG1IREU5V3EyaFJRZjdj?=
 =?utf-8?B?SEtKLytzQWlQeHZXMHM0bHBBVWtDTWhmZDloeG5aWXVKTTNtenNxanBDTWJm?=
 =?utf-8?B?M1FuRHpOekNDYjJrL3NIZmJNWXE1a0ZYdHBkRmtMMjRpMkFpTkY4TVYxb2Jn?=
 =?utf-8?B?dHJIajhuQ3hPWkJWMXZRUUdVcDFoQi9ua0gwRE1aY0ZyNWJPeHlPd2piU0FR?=
 =?utf-8?B?MG4rQ2RtbWduNjdRUFZ3TmorNU9SSHNWREYxRm5PTmUyRVRNL2JZM3JRVFla?=
 =?utf-8?B?YVZUMzBBVWpsbERGMERkUDJySC8xY0l2SEZGbmtXWHM4a3JZckU0U01MQXh3?=
 =?utf-8?B?L0ppTzFROG9CeUQ4bXhvT2RsVmhtVm5XalpOSGh0WVR5Wm5iL1RuWjc2LzRy?=
 =?utf-8?B?bUowbWpMS0EvY3VZRDV6NUNMU3lYL00zVk5YZ05tQWluN3lkd0NUOFRpRGRo?=
 =?utf-8?B?NzRSTFkrYm1pa0hjSlByVW1xcGRLWU9BRmU0bHZienhjVkdSMzJORk1CeWJl?=
 =?utf-8?B?c1pCb2xkaXRxSnJNdGx2Q0F6T05yYStxODNVYW9Bc0h3c2hTZ2NwUXhkV1Fn?=
 =?utf-8?B?TlN3MDlqVUR4ZWNOYnNjUjJQWmpPTXZ5T1FqK1psWm5yeUFhaUNYajdYWEVP?=
 =?utf-8?B?RE9HNnp2aWg3Qy9GVjFtQTIwbjhySS95Yks5L2dEZUR1aWh0ZktQR0k0N0hH?=
 =?utf-8?B?TlhhRUVoNVZPVC96TWZRUEZocENJWDV0ZU9vYjdGOXZ3YzRKdEhIQzhVdGtH?=
 =?utf-8?B?NVBvWXFqWVZFRmxyYlM5dXRNaVBXRkNPcDJ6b2VTVjJWSVNhaTczVUxrUzVs?=
 =?utf-8?B?NjhHNjQrTmNxdjV3aWdvZ3BZRzEvcStScTY2azRvNTVCaEtxYTI4REtpTk04?=
 =?utf-8?B?eTBEaWtCZ3JMSEMxNTkyQ3Z0bXNjY3Zlb2x0RmJuVGhBa3FiY3kxQkNVUnd1?=
 =?utf-8?B?QTRyWkVuUjgwc0NDV01LZEdabUxhdFdjeVo2TTcvUmUwdUNHL1pGcDZWOXhF?=
 =?utf-8?B?K1I0aStsYTM1eGp6Y0NabW8rNDhOOVBiY1RsNDgrQlFXdUtBRE5xWlZVOG9H?=
 =?utf-8?B?SCtBUnljUGViUVF1VnA4SXMrSjlIa0VsdmVMejZoOHFHRFF0bmxwalRDUS8x?=
 =?utf-8?B?a0N6SUNJZXlHSkJ3MkI3UFFNUDlUek1NNW13eEdoVi80RmRicWRiRWhqQzZk?=
 =?utf-8?Q?JeJbEjpSVZk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB8289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnhOclA3NVFuais5bTZPVVc2SHlYL2tGbjRVZG9yZ2FhRzZ1Q2pUOUZYQWJP?=
 =?utf-8?B?OGxpUUY3Z2R1MnZzcE5JNUU1VmIzUW5BQjNmQ1B5Y0N3elVWaFN1VURWVlJF?=
 =?utf-8?B?N09ZTE56cWpWc2RSd0dxTjJlSGUwbkQ5Q3RTZUk4dFFMeS9TSHJUR0xUM1lx?=
 =?utf-8?B?Mm10MHJxVVJKdXl6LzVsYXRvd3cyT0ROZkgvQTFmMkdkK012Rk5oS09KVHRR?=
 =?utf-8?B?bXJZM0hzY2xXR1R6UzFYRzIrODY1RUk0TTEvRHRvSk9JQWVmYmZOMVIzdUpH?=
 =?utf-8?B?NElwSlpXNitnekE4dnZKdXVmVnl6UUx2M2YyUC8vU0UvMWw2ZUZVUkw0bjVY?=
 =?utf-8?B?MG1OeDYyNDNsUjdmUnQwQnNOVjNoeE5IOHNheHZTcTRQRWU4UHNWTkFzVThR?=
 =?utf-8?B?WFhkVUVWbytVakNwVVl1SUFtazFnY3RpK2RkZHhPYUtycDk2V0NPTFltb3V5?=
 =?utf-8?B?MWN3ZGtUTzVYZjdPL211SlpkN3k1WlV0UWxjZXFFRXVKQWk5ZG9nMXN6dlR5?=
 =?utf-8?B?eXNSRWVJUnQyaFc0RFZQZDZuTzZqanB3N3FSKzRveDYxVUp0eDg4SGQxemZh?=
 =?utf-8?B?YmNnMjdUZkRka1poU3pvK0x5b2NQU3hIcnJ5Y1ZqV21ueWQ4QmVOMXltMFky?=
 =?utf-8?B?ZS90KzNMMkgyb2pqK0ZtVE1SS3NZUk53U1docTJCVk9VN2RUUTV6NDFiQWR2?=
 =?utf-8?B?MW0zeGpnL3YzNmF5dWl4aFExaWFpVXJmbEppUzd3QXkvaUlLcDYzV1lrekZ6?=
 =?utf-8?B?M2N5dEFIejBPcGVZSHNtMEdPQjNLVEdiajM1OFVXZkUrK1NQVDZZRTNQTG5T?=
 =?utf-8?B?ZElDdFJGeVk1OFNtWmc0K3VDOXZtVHd5OXVaVklXKzFDUG9wQnBObjBWdG1L?=
 =?utf-8?B?WHR6bHdKNnZseGlLUENFRDRyY1pad0k4YWg0S1pydmN1RG9BMU1xRWhtVWVB?=
 =?utf-8?B?d1prVmVWTWdDd2FtNk9mVFhFWGZBaFB0YzN3Yi94Y2Z4S2hkSXVXTGV0elV3?=
 =?utf-8?B?ZUZTU1Q1U09XNDBXYnNIVFc1VmRGNHBNdmpoYTdyWks1USs4TFF4d1M3VTdk?=
 =?utf-8?B?SWs5b3UvT3VtOW9iekxYWVl6b3I0VVdLTXoyYTE0NDdhMk9yYmxNZm1EdHZS?=
 =?utf-8?B?WGVDUFFoWUhWRTJuZ1c3dm5Wd1RRNk1Wc2Evd3hRY0VwSC9CVHpkblRFMCs0?=
 =?utf-8?B?N3FHakMyTFlKWkJWRXJpN1lNSTdmWXZuWklIQzFLYXhRWVA3NGp4Vlh4ODRE?=
 =?utf-8?B?UUl3MkwvWGh1eDdtRytUQzlZdkhOTmtlUWlYdkNja1prOEU0ejZlNVp3V21k?=
 =?utf-8?B?N2VaWTRzWjd1U1N5Rzk4Q0c4ZkxpRkpwM2tWRERaaEhuUEJ5cDdybElYaHZh?=
 =?utf-8?B?ekdrL291WThHNlZVY3l4QXQxcndDRUdmbWtHYThIL2hPU1YwNFBtQmNGMVpv?=
 =?utf-8?B?OTRGR1JKS2JKNitINkExTnNsK0JMZ2ZRZXJHajdkQm96aWtHMnJIWWFUV3dm?=
 =?utf-8?B?WUV6OFAzdm52VkZmRm1hKzdjZHdXVUVnSHFwa0hnVWxhb08wODBkMzEvS2hq?=
 =?utf-8?B?Rm1uTk93ajRLcFJRc280SUtxWjI5VmZyM0d3MUdHbjc0QzE5TmVBSjlweXN0?=
 =?utf-8?B?Q3RFNktSTStjWnBtVUVJcGhMN1BOTkZzTS9kaW5WeG9iNzlIN09NSzVkYit6?=
 =?utf-8?B?SWx1WmJIOUV1dHlTa3hPY1VUaGN1cVNldUljODl4OUxzSUE5WCs2em9VZmdj?=
 =?utf-8?B?OUJ4OTZFUjE4Z1A4U0pQUjRvWDAvZnFFSmRhYURXRk41UVBrOWl5UVM1WWZT?=
 =?utf-8?B?U3VaZnE5OHF6SHozVlBBM25PTXlSMzVualVQd3Z3Y1JvREcrb051aXNvMVRx?=
 =?utf-8?B?aTJCN3N4bXRELzIzMng3VlhDT0dSTU0xRmtLeDNsVkRtL244UURnWmRJaDZP?=
 =?utf-8?B?a2VhTE1JUHJEVzhxUklMZlVPVENEblpNc3pidkIwSlFBUEJqdWpmRXhDc2FU?=
 =?utf-8?B?c0I5YVBIWkdZSVBya0wzMzlnZTNkQ0xTWEhiRlV2YVZ6VFVaUmtOZUZETW1H?=
 =?utf-8?B?UlpuUkdWNlBYaW05SURsQlNaZVoreXdsdWJ5dERmc1ZiajBKSGNIOFVRcnpn?=
 =?utf-8?Q?kzXbljPuV5/At9isXXtK1HKuN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02090ee6-c918-46d5-9f4a-08ddee1e5487
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB8289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2025 14:53:39.6821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzQUjrv1HNem13hDu8+0dqjDGdjI7EvLDYNCtK4YeVCC1DERjJakd5qnMb6u92GutehSZiQ0LUrv+EIbZcyTsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6691
X-OriginatorOrg: intel.com


On 9/3/2025 9:50 PM, Arnaldo Carvalho de Melo wrote:
> On Tue, Aug 19, 2025 at 04:00:14PM +0800, Tianyou Li wrote:
>> Perf c2c report currently specified the code address and source:line
>> information in the cacheline browser, while it is lack of annotation
>> support like perf report to directly show the disassembly code for
>> the particular symbol shared that same cacheline. This patches add
>> a key 'a' binding to the cacheline browser which reuse the annotation
>> browser to show the disassembly view for easier analysis of cacheline
>> contentions. By default, the 'TAB' key navigate to the code address
>> where the contentions detected.
> There were changes in that codebase recently, can you please consider
> rebasing your work?
>
> This is something I really want to see in place, almost did it myself at
> some point :-)
>
> Please use what is in:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/?h=tmp.perf-tools-next

Thanks Arnaldo for your comments. Sorry for the late response due to 
other errands.

I have rebased the code on top of tmp.perf-tools-next branch, sent out 
as v3 patch.

Looking forward for your review comments, appreciated.

Regards,

Tianyou

> - Arnaldo
>   
>> Signed-off-by: Tianyou Li <tianyou.li@intel.com>
>> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
>> Reviewed-by: Jiebin Sun <jiebin.sun@intel.com>
>> Reviewed-by: Pan Deng <pan.deng@intel.com>
>> Reviewed-by: Zhiguo Zhou <zhiguo.zhou@intel.com>
>> Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
>> ---
>>   tools/perf/builtin-annotate.c     |   2 +-
>>   tools/perf/builtin-c2c.c          | 124 ++++++++++++++++++++++++++++--
>>   tools/perf/ui/browsers/annotate.c |  30 ++++++--
>>   tools/perf/ui/browsers/hists.c    |   2 +-
>>   tools/perf/util/annotate.c        |   2 +-
>>   tools/perf/util/annotate.h        |   4 +-
>>   tools/perf/util/hist.h            |   6 +-
>>   7 files changed, 153 insertions(+), 17 deletions(-)
>>
>> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
>> index 5d57d2913f3d..8c896fbe76b7 100644
>> --- a/tools/perf/builtin-annotate.c
>> +++ b/tools/perf/builtin-annotate.c
>> @@ -519,7 +519,7 @@ static void hists__find_annotations(struct hists *hists,
>>   			/* skip missing symbols */
>>   			nd = rb_next(nd);
>>   		} else if (use_browser == 1) {
>> -			key = hist_entry__tui_annotate(he, evsel, NULL);
>> +			key = hist_entry__tui_annotate(he, evsel, NULL, NO_INITIAL_IP);
>>   
>>   			switch (key) {
>>   			case -1:
>> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
>> index 9e9ff471ddd1..f753ec50b967 100644
>> --- a/tools/perf/builtin-c2c.c
>> +++ b/tools/perf/builtin-c2c.c
>> @@ -45,6 +45,8 @@
>>   #include "pmus.h"
>>   #include "string2.h"
>>   #include "util/util.h"
>> +#include "util/symbol.h"
>> +#include "util/annotate.h"
>>   
>>   struct c2c_hists {
>>   	struct hists		hists;
>> @@ -62,6 +64,7 @@ struct compute_stats {
>>   
>>   struct c2c_hist_entry {
>>   	struct c2c_hists	*hists;
>> +	struct evsel		*evsel;
>>   	struct c2c_stats	 stats;
>>   	unsigned long		*cpuset;
>>   	unsigned long		*nodeset;
>> @@ -225,6 +228,12 @@ he__get_c2c_hists(struct hist_entry *he,
>>   	return hists;
>>   }
>>   
>> +static void c2c_he__set_evsel(struct c2c_hist_entry *c2c_he,
>> +				struct evsel *evsel)
>> +{
>> +	c2c_he->evsel = evsel;
>> +}
>> +
>>   static void c2c_he__set_cpu(struct c2c_hist_entry *c2c_he,
>>   			    struct perf_sample *sample)
>>   {
>> @@ -334,6 +343,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>>   
>>   	c2c_he__set_cpu(c2c_he, sample);
>>   	c2c_he__set_node(c2c_he, sample);
>> +	c2c_he__set_evsel(c2c_he, evsel);
>>   
>>   	hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
>>   	ret = hist_entry__append_callchain(he, sample);
>> @@ -371,6 +381,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>>   
>>   		c2c_he__set_cpu(c2c_he, sample);
>>   		c2c_he__set_node(c2c_he, sample);
>> +		c2c_he__set_evsel(c2c_he, evsel);
>>   
>>   		hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
>>   		ret = hist_entry__append_callchain(he, sample);
>> @@ -2606,6 +2617,28 @@ c2c_cacheline_browser__new(struct hists *hists, struct hist_entry *he)
>>   	return browser;
>>   }
>>   
>> +static int perf_c2c__toggle_annotation(struct hist_browser *browser)
>> +{
>> +	struct hist_entry *he = browser->he_selection;
>> +	struct symbol *sym = NULL;
>> +	struct c2c_hist_entry *c2c_he = NULL;
>> +
>> +	if (!he) {
>> +		ui_browser__help_window(&browser->b, "No entry selected for annotation");
>> +		return 0;
>> +	}
>> +	sym = (&he->ms)->sym;
>> +
>> +	if (sym == NULL) {
>> +		ui_browser__help_window(&browser->b, "Can not annotate, no symbol found");
>> +		return 0;
>> +	}
>> +
>> +	symbol__hists(sym, 0);
>> +	c2c_he = container_of(he, struct c2c_hist_entry, he);
>> +	return hist_entry__tui_annotate(he, c2c_he->evsel, NULL, he->ip);
>> +}
>> +
>>   static int perf_c2c__browse_cacheline(struct hist_entry *he)
>>   {
>>   	struct c2c_hist_entry *c2c_he;
>> @@ -2617,6 +2650,7 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
>>   	" ENTER         Toggle callchains (if present) \n"
>>   	" n             Toggle Node details info \n"
>>   	" s             Toggle full length of symbol and source line columns \n"
>> +	" a             Toggle annotation view \n"
>>   	" q             Return back to cacheline list \n";
>>   
>>   	if (!he)
>> @@ -2651,6 +2685,9 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
>>   			c2c.node_info = (c2c.node_info + 1) % 3;
>>   			setup_nodes_header();
>>   			break;
>> +		case 'a':
>> +			perf_c2c__toggle_annotation(browser);
>> +			break;
>>   		case 'q':
>>   			goto out;
>>   		case '?':
>> @@ -2989,6 +3026,11 @@ static int setup_coalesce(const char *coalesce, bool no_source)
>>   	return 0;
>>   }
>>   
>> +static bool perf_c2c__has_annotation(void)
>> +{
>> +	return use_browser == 1;
>> +}
>> +
>>   static int perf_c2c__report(int argc, const char **argv)
>>   {
>>   	struct itrace_synth_opts itrace_synth_opts = {
>> @@ -3006,6 +3048,8 @@ static int perf_c2c__report(int argc, const char **argv)
>>   	const char *display = NULL;
>>   	const char *coalesce = NULL;
>>   	bool no_source = false;
>> +	const char *disassembler_style = NULL, *objdump_path = NULL, *addr2line_path = NULL;
>> +
>>   	const struct option options[] = {
>>   	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
>>   		   "file", "vmlinux pathname"),
>> @@ -3033,6 +3077,12 @@ static int perf_c2c__report(int argc, const char **argv)
>>   	OPT_BOOLEAN(0, "stitch-lbr", &c2c.stitch_lbr,
>>   		    "Enable LBR callgraph stitching approach"),
>>   	OPT_BOOLEAN(0, "double-cl", &chk_double_cl, "Detect adjacent cacheline false sharing"),
>> +	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
>> +		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
>> +	OPT_STRING(0, "objdump", &objdump_path, "path",
>> +		   "objdump binary to use for disassembly and annotations"),
>> +	OPT_STRING(0, "addr2line", &addr2line_path, "path",
>> +		   "addr2line binary to use for line numbers"),
>>   	OPT_PARENT(c2c_options),
>>   	OPT_END()
>>   	};
>> @@ -3040,6 +3090,12 @@ static int perf_c2c__report(int argc, const char **argv)
>>   	const char *output_str, *sort_str = NULL;
>>   	struct perf_env *env;
>>   
>> +	annotation_options__init();
>> +
>> +	err = hists__init();
>> +	if (err < 0)
>> +		goto out;
>> +
>>   	argc = parse_options(argc, argv, options, report_c2c_usage,
>>   			     PARSE_OPT_STOP_AT_NON_OPTION);
>>   	if (argc)
>> @@ -3052,6 +3108,36 @@ static int perf_c2c__report(int argc, const char **argv)
>>   	if (c2c.stats_only)
>>   		c2c.use_stdio = true;
>>   
>> +	/**
>> +	 * Annotation related options
>> +	 * disassembler_style, objdump_path, addr2line_path
>> +	 * are set in the c2c_options, so we can use them here.
>> +	 */
>> +	if (disassembler_style) {
>> +		annotate_opts.disassembler_style = strdup(disassembler_style);
>> +		if (!annotate_opts.disassembler_style) {
>> +			err = -ENOMEM;
>> +			pr_err("Failed to allocate memory for annotation options\n");
>> +			goto out;
>> +		}
>> +	}
>> +	if (objdump_path) {
>> +		annotate_opts.objdump_path = strdup(objdump_path);
>> +		if (!annotate_opts.objdump_path) {
>> +			err = -ENOMEM;
>> +			pr_err("Failed to allocate memory for annotation options\n");
>> +			goto out;
>> +		}
>> +	}
>> +	if (addr2line_path) {
>> +		symbol_conf.addr2line_path = strdup(addr2line_path);
>> +		if (!symbol_conf.addr2line_path) {
>> +			err = -ENOMEM;
>> +			pr_err("Failed to allocate memory for annotation options\n");
>> +			goto out;
>> +		}
>> +	}
>> +
>>   	err = symbol__validate_sym_arguments();
>>   	if (err)
>>   		goto out;
>> @@ -3126,6 +3212,38 @@ static int perf_c2c__report(int argc, const char **argv)
>>   	if (err)
>>   		goto out_mem2node;
>>   
>> +	if (c2c.use_stdio)
>> +		use_browser = 0;
>> +	else
>> +		use_browser = 1;
>> +
>> +	/*
>> +	 * Only in the TUI browser we are doing integrated annotation,
>> +	 * so don't allocate extra space that won't be used in the stdio
>> +	 * implementation.
>> +	 */
>> +	if (perf_c2c__has_annotation()) {
>> +		int ret = symbol__annotation_init();
>> +
>> +		if (ret < 0)
>> +			goto out_mem2node;
>> +		/*
>> +		 * For searching by name on the "Browse map details".
>> +		 * providing it only in verbose mode not to bloat too
>> +		 * much struct symbol.
>> +		 */
>> +		if (verbose > 0) {
>> +			/*
>> +			 * XXX: Need to provide a less kludgy way to ask for
>> +			 * more space per symbol, the u32 is for the index on
>> +			 * the ui browser.
>> +			 * See symbol__browser_index.
>> +			 */
>> +			symbol_conf.priv_size += sizeof(u32);
>> +		}
>> +		annotation_config__init();
>> +	}
>> +
>>   	if (symbol__init(env) < 0)
>>   		goto out_mem2node;
>>   
>> @@ -3135,11 +3253,6 @@ static int perf_c2c__report(int argc, const char **argv)
>>   		goto out_mem2node;
>>   	}
>>   
>> -	if (c2c.use_stdio)
>> -		use_browser = 0;
>> -	else
>> -		use_browser = 1;
>> -
>>   	setup_browser(false);
>>   
>>   	err = perf_session__process_events(session);
>> @@ -3210,6 +3323,7 @@ static int perf_c2c__report(int argc, const char **argv)
>>   out_session:
>>   	perf_session__delete(session);
>>   out:
>> +	annotation_options__exit();
>>   	return err;
>>   }
>>   
>> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
>> index 183902dac042..7eb659c76b53 100644
>> --- a/tools/perf/ui/browsers/annotate.c
>> +++ b/tools/perf/ui/browsers/annotate.c
>> @@ -557,7 +557,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
>>   	target_ms.map = ms->map;
>>   	target_ms.sym = dl->ops.target.sym;
>>   	annotation__unlock(notes);
>> -	symbol__tui_annotate(&target_ms, evsel, hbt);
>> +	symbol__tui_annotate(&target_ms, evsel, hbt, NO_INITIAL_IP);
>>   	sym_title(ms->sym, ms->map, title, sizeof(title), annotate_opts.percent_type);
>>   	ui_browser__show_title(&browser->b, title);
>>   	return true;
>> @@ -814,6 +814,11 @@ static int annotate_browser__run(struct annotate_browser *browser,
>>   
>>   	annotate_browser__calc_percent(browser, evsel);
>>   
>> +	if (browser->curr_hot == NULL && browser->selection) {
>> +		disasm_rb_tree__insert(browser, browser->selection);
>> +		browser->curr_hot = rb_last(&browser->entries);
>> +	}
>> +
>>   	if (browser->curr_hot) {
>>   		annotate_browser__set_rb_top(browser, browser->curr_hot);
>>   		browser->b.navkeypressed = false;
>> @@ -1033,27 +1038,28 @@ static int annotate_browser__run(struct annotate_browser *browser,
>>   }
>>   
>>   int map_symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
>> -			     struct hist_browser_timer *hbt)
>> +			     struct hist_browser_timer *hbt, u64 init_ip)
>>   {
>> -	return symbol__tui_annotate(ms, evsel, hbt);
>> +	return symbol__tui_annotate(ms, evsel, hbt, init_ip);
>>   }
>>   
>>   int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
>> -			     struct hist_browser_timer *hbt)
>> +			     struct hist_browser_timer *hbt, u64 init_ip)
>>   {
>>   	/* reset abort key so that it can get Ctrl-C as a key */
>>   	SLang_reset_tty();
>>   	SLang_init_tty(0, 0, 0);
>>   	SLtty_set_suspend_state(true);
>>   
>> -	return map_symbol__tui_annotate(&he->ms, evsel, hbt);
>> +	return map_symbol__tui_annotate(&he->ms, evsel, hbt, init_ip);
>>   }
>>   
>>   int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
>> -			 struct hist_browser_timer *hbt)
>> +			 struct hist_browser_timer *hbt, u64 init_ip)
>>   {
>>   	struct symbol *sym = ms->sym;
>>   	struct annotation *notes = symbol__annotation(sym);
>> +	struct disasm_line *dl = NULL;
>>   	struct annotate_browser browser = {
>>   		.b = {
>>   			.refresh = annotate_browser__refresh,
>> @@ -1093,6 +1099,18 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
>>   		}
>>   	}
>>   
>> +	/*
>> +	 * If init_ip is set, it means that there should be a line
>> +	 * intentionally selected, not based on the percentages
>> +	 * which caculated by the event sampling. In this case, we
>> +	 * convey this information into the browser selection, where
>> +	 * the selection in other cases should be empty.
>> +	 */
>> +	if (init_ip != NO_INITIAL_IP) {
>> +		dl = find_disasm_line(sym, init_ip, false);
>> +		browser.selection = &dl->al;
>> +	}
>> +
>>   	ui_helpline__push("Press ESC to exit");
>>   
>>   	browser.b.width = notes->src->widths.max_line_len;
>> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
>> index d9d3fb44477a..eec1b5c12a28 100644
>> --- a/tools/perf/ui/browsers/hists.c
>> +++ b/tools/perf/ui/browsers/hists.c
>> @@ -2484,7 +2484,7 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
>>   	else
>>   		evsel = hists_to_evsel(browser->hists);
>>   
>> -	err = map_symbol__tui_annotate(&act->ms, evsel, browser->hbt);
>> +	err = map_symbol__tui_annotate(&act->ms, evsel, browser->hbt, NO_INITIAL_IP);
>>   	he = hist_browser__selected_entry(browser);
>>   	/*
>>   	 * offer option to annotate the other branch source or target
>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>> index 0dd475a744b6..682100196134 100644
>> --- a/tools/perf/util/annotate.c
>> +++ b/tools/perf/util/annotate.c
>> @@ -2544,7 +2544,7 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
>>   	return 0;
>>   }
>>   
>> -static struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip,
>> +struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip,
>>   					    bool allow_update)
>>   {
>>   	struct disasm_line *dl;
>> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
>> index 8b5131d257b0..c4c897745698 100644
>> --- a/tools/perf/util/annotate.h
>> +++ b/tools/perf/util/annotate.h
>> @@ -170,6 +170,8 @@ static inline struct disasm_line *disasm_line(struct annotation_line *al)
>>   	return al ? container_of(al, struct disasm_line, al) : NULL;
>>   }
>>   
>> +struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip,
>> +					    bool allow_update);
>>   /*
>>    * Is this offset in the same function as the line it is used?
>>    * asm functions jump to other functions, for instance.
>> @@ -473,7 +475,7 @@ int hist_entry__tty_annotate2(struct hist_entry *he, struct evsel *evsel);
>>   
>>   #ifdef HAVE_SLANG_SUPPORT
>>   int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
>> -			 struct hist_browser_timer *hbt);
>> +			 struct hist_browser_timer *hbt, u64 init_ip);
>>   #else
>>   static inline int symbol__tui_annotate(struct map_symbol *ms __maybe_unused,
>>   				struct evsel *evsel  __maybe_unused,
>> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
>> index 70438d03ca9c..aca1e3151bcc 100644
>> --- a/tools/perf/util/hist.h
>> +++ b/tools/perf/util/hist.h
>> @@ -713,11 +713,13 @@ struct block_hist {
>>   #include "../ui/keysyms.h"
>>   void attr_to_script(char *buf, struct perf_event_attr *attr);
>>   
>> +#define NO_INITIAL_IP 0
>> +
>>   int map_symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
>> -			     struct hist_browser_timer *hbt);
>> +			     struct hist_browser_timer *hbt, u64 init_ip);
>>   
>>   int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
>> -			     struct hist_browser_timer *hbt);
>> +			     struct hist_browser_timer *hbt, u64 init_ip);
>>   
>>   int evlist__tui_browse_hists(struct evlist *evlist, const char *help, struct hist_browser_timer *hbt,
>>   			     float min_pcnt, struct perf_env *env, bool warn_lost_event);
>> -- 
>> 2.47.1
>>
