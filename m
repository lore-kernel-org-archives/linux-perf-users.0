Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AE654279;
	Thu,  9 Oct 2025 05:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759988111; cv=fail; b=mEeAsZYF5yVRZS+wMk4UkxZjodkjOI1I8Brf/eapppQmVpA2HE2m6QCIOyA02hrvkzUH+pK4aqLLrmOXKgmlz5HMAiI8RKRw5Tvk6d6WUioaavE9BSF6G+8b0JUuYXNufQ5jijZgdPaBwQ4PvsARkBYA96O9pgotlyb/q30ZWSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759988111; c=relaxed/simple;
	bh=rtq7gJ+5KmlcAc/bTSdERF5POcFfMVsNdQHDL95pLqs=;
	h=Message-ID:Date:Subject:To:References:CC:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c/j1YEB8KrgDYWPoFYXit/HMZU7vbHl+2p3xrz1CNc0OE7ii/vvHMI+aUSYmtoLzR/IrvOQEZslFWdei+6JwH21zETFqrlbYdPw0gYD+m8Wysn5PRoP3U11M2sAD4YMkgloRgK7BOIlcK1qFmd4CES0ALxu4itvOBet4L8Pucro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TsQ0CByb; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TsQ0CByb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759988110; x=1791524110;
  h=message-id:date:subject:to:references:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rtq7gJ+5KmlcAc/bTSdERF5POcFfMVsNdQHDL95pLqs=;
  b=TsQ0CBybB1TqANfGAKmcGliPOHLVDRHCvSzaF84lbYdlCYYerXW/EHPF
   40ndf+PIZWz6IE7UtkK4qz1rtcbs78Y2fgyCCxnMGyi/p3GaJnDL3iJ0U
   g4zXPfFOvnHp3TEoQMH75SNewC0ipxiItNT0LSH+wReDMfFToskoGTm+l
   7dpGaIwaZi/0SfXp8U14AXYDTHPbnXzofctPbhGvHmY3Z4BrU1s8mDw0P
   OpRfzsPRY+475GnWUnaGlnZVyECPwKztMrNfYw8dlobNbF+vLWGbBon8p
   Im3OjbQq28EmDAWJ340vOaWne1eAPCKMcHGvw36pOYry6tjGgwD/Err2w
   Q==;
X-CSE-ConnectionGUID: Q5BEpmpOQO2aBNqf8hRerg==
X-CSE-MsgGUID: 3kUpX/L0Smu/bdLEO462uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="61398268"
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="61398268"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 22:35:09 -0700
X-CSE-ConnectionGUID: 0Z22hnkpStKKWSoGQ88SkA==
X-CSE-MsgGUID: iIf/AZ3UQXCieQzDAkJrGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="179733748"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 22:35:09 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 22:35:07 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 22:35:07 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.39) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 22:35:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qez8Vaj4QbJfqiDgq8qlLuAJ9IimS6sWleHm2pIGi6dogXLw0NfkmYvXU2B9ad85QBa7Qx49u17z70+1prXx5B1uIB0twpV390mEYG/ZJvQV0tXv5u6tQZc/ddd6UY64DieRBH/VISP85xmd0b16SwvlA28rVzCtSx6lVrBLoHDCEZC9wvX3toHlJ7/NQ7yXMXNJxfQE7LYtOxNmQzELbNUMhfLUWsIXN3CT29/GgZjMTRF+rB4yeYJhUy5hDkCyJPK6cAPqF2QrO6aLxpnw1bifcHJYu20k4rbRPx4id59CIospk6Uyke8GQyhQtJ1LfB1aY98BKhCSxxsWQJImYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeSAq3BqQKKnGCaoFTH4JMC9v59bNlJSOn0+wLJPEqM=;
 b=SyxfmoxQ3hV2npLyFcKSl02ua3yr1sh6p9+EId+eYxtWtdHf/Uf5N8O/UpKjTJnXXVwfAlS6EdRogSNrweo23oQwM0NKq8Lw8r7H65cRYzJGYSLOXfY818xMhBrFG/J7HrkqxPm3CaeNpt4X67YZHA+lZFIw21It/TqQHHCf6kgMiS6tCVfbHsySama/r+xWhSgRJbl2QC2oMhMCscV+4HDj/WHPGDeDndagcmXF2iW/WvWaNzlUReAlbJucx8eFF5KpxtLBJFzc5DduE8EnEu8lnBjJ1udVOmlgZAHRi99xpDQeB02MHCoc98gHBhZa+nClqMwrajY47WFIYLy7fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB8289.namprd11.prod.outlook.com (2603:10b6:303:1e8::9)
 by PH3PPF801A91A7D.namprd11.prod.outlook.com (2603:10b6:518:1::d34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Thu, 9 Oct
 2025 05:35:05 +0000
Received: from MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022]) by MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022%6]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 05:35:05 +0000
Message-ID: <ef9b8d69-76b4-4efc-8a89-47f58423b5b1@intel.com>
Date: Thu, 9 Oct 2025 13:34:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] perf tools c2c: Add annotation support to perf c2c
 report
To: Ravi Bangoria <ravi.bangoria@amd.com>
References: <aNo-U0KquRbcJam9@google.com>
 <20250930123900.1445017-1-tianyou.li@intel.com> <aN9ZiPYyYtr332h_@google.com>
 <2f981591-4159-411c-b530-e884262d1a80@amd.com>
Content-Language: en-US
CC: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Kan
 Liang" <kan.liang@linux.intel.com>, <wangyang.guo@intel.com>,
	<pan.deng@intel.com>, <zhiguo.zhou@intel.com>, <jiebin.sun@intel.com>,
	<thomas.falcon@intel.com>, <dapeng1.mi@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: "Li, Tianyou" <tianyou.li@intel.com>
In-Reply-To: <2f981591-4159-411c-b530-e884262d1a80@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1P15301CA0028.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:6::16) To MW4PR11MB8289.namprd11.prod.outlook.com
 (2603:10b6:303:1e8::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB8289:EE_|PH3PPF801A91A7D:EE_
X-MS-Office365-Filtering-Correlation-Id: b69d186f-af87-4ccd-1879-08de06f59944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mjg3bWJ0SmdEc3JIZ2daS3ZaQi9NQ1QrU29rTytrNW5WWlVvRUhVMnd1MzlL?=
 =?utf-8?B?T1hVU2NUdTJuOGVFQTBxMjZjY05ZRWZQWEZEM1psZGJmNkswZ2ZQS3JzTTBp?=
 =?utf-8?B?NmdhYkdVWm1kNzJQWjFLRlZXbUZPQklvOThyRkxQZVhFaThYTExVSXYxbzVK?=
 =?utf-8?B?VkdabWFJSDdiR0lLampuU3k2d0pZcERoaytTRGdFaXJ6SDc0dkdJTW5DWEF0?=
 =?utf-8?B?TU5vZ3pZYkg3aEUybmpDcmE2SmJ3MEZ1T0ZzSGlId1R1akpoTnVMN3BiL0ZQ?=
 =?utf-8?B?djNFRGFMOWNFelBSalV0czlZZ0tqdi9rSmhPd2M5QnA1bXFyTlVHVU5EVlVL?=
 =?utf-8?B?azBrbGY0Y2dMODlXODFQbzgrUkJGQmRkN0w0WnZpNFRrdmxlNWpsSXhNS3h4?=
 =?utf-8?B?OTkwVUNRM25nZUNBNmhPMWx2UjdDcWZBbTg5a0N0SmhuNW9veldwWGNCb1BQ?=
 =?utf-8?B?NmFROEpHWGdJa1JPV2NqblJaR3g4T3hEYU5yVHdKeHdncndQQ29iYmJNNmZm?=
 =?utf-8?B?dEZOa3AxQTM0T0tBLzcvOS9sQWEra2Q1RWVnVG9IR3pUWHlEN1BYSzNZSGEy?=
 =?utf-8?B?aWlRT3BSMUExNittMWFTTTFaa0g2TW9WUkN0bHpwanUwWXNMTEV1WjdJN05z?=
 =?utf-8?B?elZLblZPWGlvbmo0UEsxeTFSN1BialFaS05Wa0RrczhYb1E4QlZ4eng3eXRz?=
 =?utf-8?B?a0xKL0dHL052MTJJTkJ1MFVrVU5XM3Jkc3VvN0l3emd6SmF1d0xyak12TUl4?=
 =?utf-8?B?dGtFRC9IYms1MUZidHc2L2Jvd2lZOERDSVVOeExJWXhyQjRoRTZjUUg5ais4?=
 =?utf-8?B?czF5azJyckVBK1pnaVZQMmQ5QjQrTzNhWjgreXFHeGZCdGhRUXI4Nzc0SlRM?=
 =?utf-8?B?VmZTaFQxUi93bUVOaG1mZnFNM3VzNlN2WTd6THpHbXlNdUFJRmhxMkhXMnNI?=
 =?utf-8?B?Y0NJTHpZSDRkNERUZEFlblFFMVhJdXZ4VGdLOEVUOTN3VUJpSmRWejV5N2tZ?=
 =?utf-8?B?WlhqS1FFTzBQcENObUFOZmxCRjNBbnBlSTROc0cyWlVaekxhbzJRNE80VkVp?=
 =?utf-8?B?NDErMTl2SThvWVBid1d2VlU0YmZmM1RhckJqUWtMdGI3S1RkdlY5MlhoWXox?=
 =?utf-8?B?b3B5a25uSzZXdjhnYlpwanVXWlBocnJEMThJS2o2THM0b1J3dVlSWTRnbkJO?=
 =?utf-8?B?di9XVGlUYStxOVRjT2tSMnlPWjVwbTBXWXNZOWd5aFMyZ0pRdU1oWWNCQnJo?=
 =?utf-8?B?SDFsVWcxUHhEUHN5c1M4RUxXa2l1THROREJjM2xWajNNaEJjVEpLSFlYUkxl?=
 =?utf-8?B?N3Zyell1TzNIL29oNklEVlZWT3VJOGJxaXM2a2tSeGc3bUZyemFOeGN6RUFH?=
 =?utf-8?B?dkNGQjl5MG9VQkdiY0RwUXJ4MDlGWUVBemVOekxPS3N2Q1JWK0lCRW80RWFT?=
 =?utf-8?B?SHZuc1JEQ0UyYzNEdmFCK200UWoreDdqaVN5dk5jQ3NNTzJJSUg0dThkNlBU?=
 =?utf-8?B?TnZlQUd4cVVSWlptb3RCOStiTzhlQWxUZU5aUE5oQ2t1aFJPY1V2VVhVeXE1?=
 =?utf-8?B?aENCMnVyWUJXcmNDRDJlUHMvZkM4ektMOHJ0L1VuK0RKWkZqZFVLVWtLaGNS?=
 =?utf-8?B?bnM1Mlg4dXloWThNRFM0Q2lPaEJXVjN1RmJqckJma0xPemZ6QXZ0YnMwWVIr?=
 =?utf-8?B?TjFYdEZEeC9hcWJvd1dCbG9UN2ZoY09VZXEvT1VHN1BGY0FnMGY1azc3Y25S?=
 =?utf-8?B?bWVLRHRjMWRwbllRVVpad3Y1WWcxbmJpT1BjMWNGVlpQODhPclltK3UzcTEz?=
 =?utf-8?B?WXJtVFlnUmhmTU13QWV1djAySSt3NkpzWFZzUkUzMFdDWE9uZmZOR0R0QVZm?=
 =?utf-8?B?Q296MXBnV0czVVh0QWV6YXQraW9aOFBTajJ2ZXZMdUErbExxYmJnNGpaTENI?=
 =?utf-8?Q?6CgwBD/IPrb0ZApEDiloeN7TmLY/DV4c?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB8289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXVHaVVibzhaYWtpT2NwSURCSFU3RTNMdjhKSzU4VmVWRU10MTlDVEQ4ZXFr?=
 =?utf-8?B?bFNsbUdnTEcrSTBZSVFSOUNEdk5wdC9hQkZ1aktXZFBEUFZjb2hjTDMydUtI?=
 =?utf-8?B?N1J4cDlBbUZHNG1wRFBCaGJEdXBHNXpaaTVBMU9WcVYrYTljSmZxeDB5dmh3?=
 =?utf-8?B?Ly9RV0duQm9vaHUwTzFlL205eUdhK1JoeTkxdlhYWC92cWw2TGJ6SEYwSXE3?=
 =?utf-8?B?dk1OVmZWbWNlUi8rYjNxcklCMURGN005eU9CMytSNVVQRWpwbHNTWFY0YTBN?=
 =?utf-8?B?MER6azZpaWgrZzNXYlF5eFVicUdGWTNuOHA4akdDMkFuSU1JVWZpaWVRRVZx?=
 =?utf-8?B?TVY4QzZvOEs0QjVMS3JQRTBIOW1qNjYvZUVJRXpRNFB5OURkTkxOR2MrUFJZ?=
 =?utf-8?B?Wk82Q1Btc05QSXZSMUZqaUlWemhsY2IvdFNxbkx5SHdodytRTktwZVFHbGNS?=
 =?utf-8?B?QU1ydlFBOFNTb0JpUzd5b1pzOTgrc1NLNXlsZnE3a3hnT3VqRGVGeWZZU0Zn?=
 =?utf-8?B?NkZrY3RQdGUzTEI0MUdyeDFVODdTSDNMTUVhSzlTQXdRVVNGbmx0T0o1OHY1?=
 =?utf-8?B?VktFc2lJZ0JGenFsT1FLdHcxRXhoVUIzajc5MjZwbGIyOWxmZ0dMSjVFTTAz?=
 =?utf-8?B?THNtUGtCNkFuS0QwazdjYzlGK25WaGlpNlQ2Z1FWMkxKcmdicmVPa0Z5aG5V?=
 =?utf-8?B?L2YrWEdIcU9aVEFrNnlOZk90RkZ0OGZqc2dtcGViNXJIRFJwSkYwSDY2dmVw?=
 =?utf-8?B?R2FxenNDaHNBZS9MM1FwMWl6TGdVRUErNHdFMmJqays0aUEvRFozVHErOWlT?=
 =?utf-8?B?NVpjY2hjQ0R1YzBqbGM1YUpKYzh4elBqQnIxajRycG00ZDFaVGhBZFVIQ0Rp?=
 =?utf-8?B?bnZpSTRzMy9EQUprV0hXOEhySnpMd3lhV0FWeHVGOTdvZ0FpanBobjFTc0hN?=
 =?utf-8?B?a2t4b0V1WFEwS2sraTliSE5sZ0RmV1ZPZWVqSS9EOEI3alVRaVBHaWM1VUo5?=
 =?utf-8?B?ZlMxNm9Gb1dBMm9PbldIYUlESkl3aHltdGJZSWdFMlh2eVB3aUdkTmF2SHNJ?=
 =?utf-8?B?TUdKRDVKelRiRk5RZ2lLZzY1cVBFVkp6ZzhTZGh3S2svRUNEcjdoY0ZuWW54?=
 =?utf-8?B?SFVRdzd3NkEzRDJQcFJYRWZuTVFzTzFhZW40OWFnYkVLU1R2Q2xTZ0xpZU03?=
 =?utf-8?B?czA4bHJWM0NXeGJmWTJQRU5YMkM4QzhMWHVLWFA3eVljc1Zib0ljellTZVZa?=
 =?utf-8?B?aVpyK0hudnhrNEMwem9VbzlQRE9MZzBuSVFxbzRVVzI5SG1RbFpvcXhLcXFH?=
 =?utf-8?B?b0ZzbjUvbjkxZU9QaFlJUkdUSHRxNU9mU1RZL29mVVdET2F1ZWVGc0NTRFZZ?=
 =?utf-8?B?NTgrR21rOVYvYSttbGUrWlRhZmZpcVYvNjZPY3NuL3NPU2NUcy9CbENhK0lF?=
 =?utf-8?B?cTRGS2M3a1pxTDg4TEdQM0lVOWJubTJ4Zmhkd0F3UXBlcGh3SVRXa1pTVjcv?=
 =?utf-8?B?U3FSUncrUWRkdnQ5K3hLY1ZrdDVzRXFGaDBDL1h2SFQ1K1U4ckxwQkNndkhn?=
 =?utf-8?B?czd0S0pGRTJranBMYVRIT2p6TXhqdllJZEQvSEFMbktaMVpDU3Y1WTZQVFB1?=
 =?utf-8?B?dXJjQyt4Ny9JNVRBWVpvVnJwQ1d5dWdLUW45bzlEWDBmdnRpK0VUdG9rZ3FE?=
 =?utf-8?B?aGRtL0RQSnd3WGR6YWJBU0VWbkk2YUUyTXJnM0gvMm1uMVhBN21ubVlGVEFv?=
 =?utf-8?B?SEo4ZG5LM2dZWlJISXEzQVR5R3FWVFRnbng2Rk1NQ1QrWFlaM0grNmNmZkFy?=
 =?utf-8?B?SEp0TkszM0FXRDBlMk9tckw3UG01U3p1UUdUaGdVQXpwM21VZzVPcDdDSHk0?=
 =?utf-8?B?Y2lURVZWWnZSeC9ZcTNLeU9KTk9hV2tJbmRmeStHVUhGc0FvMXBVV1A2UUta?=
 =?utf-8?B?NEdEOHBUdWo0ZVJvQXhIYzdvZGRnQWV4eHpFYlpDUkxDZzZwVmcveUtFOUZR?=
 =?utf-8?B?am1GNFRia0l5RnMwZVZqVjhoOXREVEpWT1lwRS9GbFhnQUljUW5yTmJzZSsy?=
 =?utf-8?B?S1FuSzg1bmtmWFpmYkRZTXdMNzc2KzRoc3B5YlRPNmxpMCt1WXEweUx4WXg1?=
 =?utf-8?Q?jm1vzg/5RAf8QkAse6529DRza?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b69d186f-af87-4ccd-1879-08de06f59944
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB8289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 05:35:04.9702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsKHRFlFyszB3YoKf4q4SkW7+S3bKz1nxulu2Z7pE8EOFAzmC+89dFUAzgC4bRl2LjW3O3GUQA3TWvSdKce4dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF801A91A7D
X-OriginatorOrg: intel.com

Hi Ravi,


Very appreciated for your testing. Could I add you to the 'Tested-by' 
for my next revision?


I am working on the annotate changes. Hope I can get your attention 
again in the next revision. Thanks.


Regards,

Tianyou


On 10/6/2025 6:54 PM, Ravi Bangoria wrote:
> Hi Tianyou,
>
> I tested this on an AMD machine and it's working fine. Few minor issues
> I would suggest to address.
>
>>> Perf c2c report currently specified the code address and source:line
>>> information in the cacheline browser, while it is lack of annotation
>>> support like perf report to directly show the disassembly code for
>>> the particular symbol shared that same cacheline. This patches add
>>> a key 'a' binding to the cacheline browser which reuse the annotation
>>> browser to show the disassembly view for easier analysis of cacheline
>>> contentions. By default, the 'TAB' key navigate to the code address
>>> where the contentions detected.
> 1. Annotate browser title always shows "Samples: 0", which is misleading:
>
>     Samples: 0  of event 'ibs_op//', 100000 Hz, Event count (approx.): 0
>              ^                                                         ^
>               `--- this                                                 `--- and this
>
> 2. Comment from v3:
>
>     > In the annotation browser, we did not need to show the overhead of
>     > particular event type, or switch among events. The only selection
>     > was set to the ip addr where the hist entry indicated in the
>     > cacheline browser. The hist_entry was correctly initialized with
>     > .ms field by addr_location when the mem_info can be successfully
>     > resolved through addr_location.
>
>     It's ideal if we can show sample count/overhead along with the
>     instruction (because that's what users are used to seeing with
>     perf-report->annotate output). I haven't checked the code but is
>     it possible to highlight the instruction by default (Annotate+TAB
>     OR Set the font color to red etc.)? Waiting for user to press the
>     TAB seems counterintuitive esp when instructions are not tagged
>     with overhead.
>
>          |1340: > callq   0x10f0 <_init+0xf0>
>          |1345: v jmp     0x1376 <thread+0x12d>
>          |1347:   cmpl    $0x1, -0xb0(%rbp)
>          |134e: v jne     0x1364 <thread+0x11b>
>          |1350:   movq    0x2d29(%rip), %rax  # 0x4080 <data>   <=====  Highlight it by default
>          |1357:   addq    $0x1, %rax
>          |135b:   movq    %rax, 0x2d1e(%rip)  # 0x4080 <data>
>          |1362: v jmp     0x1376 <thread+0x12d>
>
> These are not blockers if Namhyung / Arnaldo are okay with current design.
>
> Thanks,
> Ravi
>
