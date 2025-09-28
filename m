Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAD915C158;
	Sun, 28 Sep 2025 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759047399; cv=fail; b=E2JRKJzE7xlhFBOZZVT/By11CpwtuD6l1yMCnAXrmnVOJ7Bmjl8RuuVAMQn7AWNOMN8ckSF7DC0dc4JnV5b2Clu8Qe16ZJ6azr/8gVKZFOsHgEgEtM8e1m46ATEHcU9euOmI3lBokqGiSD4LYyEd3tpBl2073o2JyeGXYm3yAWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759047399; c=relaxed/simple;
	bh=b4UBzbSLbiYqB+sZo1jFJqdWaYXHoGWBLotY1ZacLuE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VWau/t/oYkNgZ4i29ei6OZ3oExwDh6tM0bpW2xPiNlQcof9Ilve5/0DI4+AJwF3pjlTKt0isb9fsCSG8LhTBPFhqezsVEz5BzCx3WAwNzSRvRBEb5AO1OhkLMrgqgRITfaybP7BhKxfGJMGUb7wB2yzb8bfDrWTwBp6gCB7T4oI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mFKWlSiF; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mFKWlSiF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759047397; x=1790583397;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b4UBzbSLbiYqB+sZo1jFJqdWaYXHoGWBLotY1ZacLuE=;
  b=mFKWlSiFEavLdjEQ/cWervIts0Eo8iwV2v/7Ld4IEl/Rx16ImZD7WmhX
   kzZR41gCrBk7gO5gsJ5mpQ42OHBKv7N8T1o0MzhlYdNY5Wn863PUAckrh
   Yhv4W4EUZKZTr8mYcZ5GVBFMIteJ0LMQGlCwDpBUi7E0fKZN+ccCU1taL
   xacG6A7Rw0TkZjy0jnn9nu3GrqUTsqRqnc7dNddo/BGZmsgaYAaVfEVuq
   NrquoHDMM3b++D6n+BqYvLLz2cZIZ/rmTBwA1dV0474dDa0dnsdST4RZH
   ri/NwxQrx248j852fvppw+e/yNbv12fYjJQaF4vmjeSMfhpPRsi0OZ5fj
   Q==;
X-CSE-ConnectionGUID: +FgH1Fm/T2+AkWgoenffOw==
X-CSE-MsgGUID: YgLuipGeSzmLIRl0sqCWUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11566"; a="71997682"
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; 
   d="scan'208";a="71997682"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2025 01:16:32 -0700
X-CSE-ConnectionGUID: MWJ3Qeq0Qr2OQSNE6QEUjg==
X-CSE-MsgGUID: MROcEsqMSFKJWuPmvcWhXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; 
   d="scan'208";a="201644821"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2025 01:16:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 28 Sep 2025 01:16:30 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 28 Sep 2025 01:16:30 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.67)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 28 Sep 2025 01:16:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDOIupvyi0SrYh6TtWK0GXnhwHb2BDYnHFrolTnJ49L0TXhJXJlWgAKXjRkWyP9V9/WxliuMUUArFM+l6fvirCc7YSvU3VFOkD0Lz76H0/I/TqNTAtu5Op+yQ/f8pLx+muQwLb02v397/mALJqNo67Vqqa6jJ6LQUC4BqAqWE11kiJRux1MFeYStcQuIWwi3cEhFus4jViWld37m6TPpjC6fllPogRYQTxtFBre/mO6lnbExfoMkDIKsLU1/gbb8OsNLJza5rvatLriXlIjDYGmOFoOewQ/BDzK/7F30g/S8TtzSdtYLqZMBgZQVCmuUNZswFQgdsut1gzWf0mcqvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EAoeQ8BZseMiomewaqpJH77ZlzzSLeSmzIZ0BOsRVQ=;
 b=mCXMah24N5pw8BC8Ee0wszyClNlYzIjMenX1aKrY/niNhNzuVa/6a8gRl2wkEE+6RQNgwyKiHFGDpo+f9/j96WZ3+rp2o48MHuOI/s7qe1qcVEYaoPFrqA7qt5xfybC0LkX/6n0kg3/kAKNucXisD1EvGkpPn4uio/VZBRzWJCMWvk9sXCmGCBzdU7Qqm+RkTn5XGUvDI3g3o0lNP+JxtDoFQG3CakmMCWV/rvCfBoPA5+zSSXa7Gsh2Bu+PaFRzrZB8I9aEXise70Pp+l8Qly1Fu1x3EX7QAB6QDIz+gcJCrA3ceI6LSTEwtDqX/6L73Wmh8l10lPMQExdRD+Qi8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8286.namprd11.prod.outlook.com (2603:10b6:510:1c6::15)
 by IA1PR11MB9519.namprd11.prod.outlook.com (2603:10b6:208:5d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Sun, 28 Sep
 2025 08:16:27 +0000
Received: from PH8PR11MB8286.namprd11.prod.outlook.com
 ([fe80::f7a1:1fa0:66e5:d03f]) by PH8PR11MB8286.namprd11.prod.outlook.com
 ([fe80::f7a1:1fa0:66e5:d03f%4]) with mapi id 15.20.9160.014; Sun, 28 Sep 2025
 08:16:27 +0000
Message-ID: <be2b23a3-9951-4357-a3f2-3eebe7ef20a5@intel.com>
Date: Sun, 28 Sep 2025 16:16:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] perf tools c2c: Add annotation support to perf c2c
 report
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Kan
 Liang" <kan.liang@linux.intel.com>, <wangyang.guo@intel.com>,
	<pan.deng@intel.com>, <zhiguo.zhou@intel.com>, <jiebin.sun@intel.com>,
	<thomas.falcon@intel.com>, <dapeng1.mi@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <aMpWcdjoCBsRVo72@z2>
 <20250928090212.1324797-1-tianyou.li@intel.com>
Content-Language: en-US
From: "Li, Tianyou" <tianyou.li@intel.com>
In-Reply-To: <20250928090212.1324797-1-tianyou.li@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0057.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::8)
 To PH8PR11MB8286.namprd11.prod.outlook.com (2603:10b6:510:1c6::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8286:EE_|IA1PR11MB9519:EE_
X-MS-Office365-Filtering-Correlation-Id: 5564ea57-b929-43b9-5dbf-08ddfe6751ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUtKMnduMFFQL0N0ZkxQZTRzQkk5ZHIyMVNhRVlBWjVlWTlFWU4vSlNsUWdu?=
 =?utf-8?B?ejBtclBaMG4wZS9sK3pET1k0aWhWU05sN00wUDNwdkdLR3RYK3psdnlPREpJ?=
 =?utf-8?B?NzdVVU5VQjQ0L0F1SHQ2bjRNWldDT01GSlVZdHQxN1ZENkhPY3lPa2JveUJM?=
 =?utf-8?B?Wk1DR2hmK2VtdkZjcXVWdkpzV1FwL0tJTDB5Z1FONlkvSE1yVGxtb0hRR3Z2?=
 =?utf-8?B?c1R0aHZ3YkJwY0dXT20vb1NTR0tzRUFTeWRwWkwrU2lzU3VwVnplM3hGa1gy?=
 =?utf-8?B?YzN0TGdQSkJvbjExMDZMSE4zYzBla3ZCbWpmY1pLVlpTK0ZLTitlUklaUUl5?=
 =?utf-8?B?RUEwUTJXSElFRUR5RThqM2p5VzlPcHkvNHFoZ0IvcWlRdEhERk1EMHFYK0la?=
 =?utf-8?B?WStUTWp0c0YrakFGN2FmSW4yeTlXV2daeklQMFp2R2FjV3hEQU05RVF4Sm14?=
 =?utf-8?B?dk5XaGw0bkdFcFM2cU43SVRYQkJja3Y0ZHdkdFJXTE1oTy9sR1VUTHNNZFpn?=
 =?utf-8?B?N3dBOGZEcENzSEdqQ0x2N2d0RWN6MjlYQkt1NEQwUzhaU05CbW9WalpMbkgy?=
 =?utf-8?B?YVdEcTdseEJuN29aSjJoajZRYVVoQk43Mmhpdk1mbEluWXlabUJmNFdtbmRL?=
 =?utf-8?B?WGE4M2hiOUJWRnl6V3ROemxmTDJLN1pkRnVFYmhwZmRxNllVeVlzVUZTemg5?=
 =?utf-8?B?Q0lGa0g3Y0N1ci9XMGtDVW4zSjhkd3d0cHc0TmlFRTZkdkNFSDM2eDNtU0Mx?=
 =?utf-8?B?NitSRzQyOVNVNy90N0NiQmJnU1VDaVNGamJocTB3cndWek4yaHZFaTdHampW?=
 =?utf-8?B?WFhRdFh5d1RPZkdBMXdDNy9aWFRyQ0ljckdiTFFxSWVjOFkyZW5BUmZuaDRV?=
 =?utf-8?B?Yjh2eGt6dlRJMkxOVGxSNG45KzVlVHZtY2ZRd0dMWnNlSVgvb2ZxQ0EwTE4x?=
 =?utf-8?B?eTRBb1Z6REdITEhWVWhMYmpybFVjYzhxUEdjdDR3bmdEbzQvUnZSV290UDEr?=
 =?utf-8?B?VDNSQzBqWExjM3ZIaWVSSm1xaUpHeVg3ZU5HdVhQRkl4bUVYKy9hZ044b1Zk?=
 =?utf-8?B?eFNsdzlFTTB5Z0svKzhqdTZxOHduTzladFNJazRPMUVhZHBKdHhVdTkvQ3d2?=
 =?utf-8?B?enhyOXBhNkZqQUc1SXRSKzE3MjRpN2kvbmZnZjMxRmp6aHRBcVhwcHBDQ1Zt?=
 =?utf-8?B?emNjVjlPdlpnWEVyUWpkamtQYjBVZlF4WHBGbUZLblV3ZEowaUQrSmdtMGJD?=
 =?utf-8?B?Nm5SYlZMVXlXUkIwUENYZWwvV1lqRzIvSWlZenFvR3crMlNpdXJDc0JDNDll?=
 =?utf-8?B?dXR4RDFLYzZOL1VzRDhQbDZLd3AycEtQSCtueU1UTVY0MVQ2WG5Way94Mmo4?=
 =?utf-8?B?ZHRONk9tU0lTYjIxOFVydE9uQ0o1blJGNERvWjdSM0FHOFpJN1IxcTI3Vklr?=
 =?utf-8?B?dzZ1NDRtSlhXNVZRNDJBMkYyelk2Zy9haEtCZGV5TmljRUZEMWppZ3pEOHZU?=
 =?utf-8?B?bWI0dEg1aSsrRFN2Y05wb3NEUy96TFk1bVB1MGlLQ21qU1lhb2hDV2t5OWdJ?=
 =?utf-8?B?VUhMQ2tEYkRUUHJFYnlSNWZtZzhHV1lhOWV6YmUrUDB2Z3B6Ykwwb3NmMkNY?=
 =?utf-8?B?VzJpemJ5dGc3Y2REaE0zZmxIbURhRmxzTDh1WUN4aWNmQkRoRmw3cndGVmIx?=
 =?utf-8?B?RTJWbG1Cc2pzOFBqT1QwaVd6blNEQkJKNGZrNVM0SUpxTVp1cXNSK21pR0pW?=
 =?utf-8?B?R2I0R0xqcHMxMzJzeWdHM3VxU01KbGdhaktnUTl2UzQ2Nm43UVFqUnY5Snhm?=
 =?utf-8?B?eXRjT1ZISmRUT3o0V2NRQmk2NTFjbUNLR1BJaVVBTVhtT1BGM2hCVmtsRXg2?=
 =?utf-8?B?T3VaeUNabHQ0NEluZks3TktFT0V6bW1tSUkzZFFlaHFhTlRncFoxc0VSYXhP?=
 =?utf-8?Q?JurB/Rt5A58MmxzGMVyTQ4/9hUHvbAd7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8286.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnA1OHcrNW9qR09LV1pOc2RPM1lnTUs0cG4yaHM5YUp0VDhxMCtZbERlTzZG?=
 =?utf-8?B?VXl2WmhmakJGQXRCd0NEY3o0L3IxbEdnWittMTAra0ZoVmpJaDZyaFA5MXNy?=
 =?utf-8?B?bFFNTDhtSFdKYmw3REpaTVJ6bHBBQVlMMlVKYm5VQjQ2TElpbk9oNnB1QTdk?=
 =?utf-8?B?LzFNZ21vMVA1UzgrenhRY0dUbG1PT2lLQVdiOXQ1NWVFL3FJc2l6RU5IVENs?=
 =?utf-8?B?MjdnT0VpOGFScnVoNnVJSmVHelIwTVFKY1RZK2hXV3RkOVNjK1lvRTVwY25O?=
 =?utf-8?B?Tlh0cEY1UFgvVzFQcWtQYTBJWVlOTURvRlk0dnh3bGhENElDTnFkVDVvbXZj?=
 =?utf-8?B?R0JWeHVpTk9oL1M5ajJsaG9sMzdIQ0k4eHFPU2ZRakdySHJac3IveFJsY1hu?=
 =?utf-8?B?MXVOaEdxNXk3dndJQjhOc202VWtqYkpoeVhKU0V2NUVqVUdodk5MS2JDS0lh?=
 =?utf-8?B?aXdacXNQYlNTUlN3dkFFM0k1QkpFSzdmWjMwdTJwMHlRTG5xMHBLUG43ZVFo?=
 =?utf-8?B?Q2pQMDNTN1pFREY2b0plMDE4bFRPOG8zVHlFaThkTHp4NDRTaWJrV3UrMFN2?=
 =?utf-8?B?TFp1M1ErUjlGLzFsZ1BZS1VxNldHb2JTSHcycEpaMG93ZVdWRFlqU3dFNWww?=
 =?utf-8?B?c3RWZkR0M1JZbTVKcCtxay9aWDc5R0trZzFWaFo0eGM3YlBFemNqajhxZndU?=
 =?utf-8?B?SkMyNThYTkNvRDl1K0tWUUFGUitVOTZjZ3hvbFpsRUJFdTdWOGlDS1JheVBN?=
 =?utf-8?B?dzk0NDd0NVJFRXMyd0tYYmVqMkhuYm05a28xblJyN0o3c0YzcnlXazA4U2JV?=
 =?utf-8?B?RTNvSGR3NW1meUFZd1lkdmlEK3dRZTBkVU1mMXdmK0tIc2FXOUJhYUdyb0JP?=
 =?utf-8?B?Qk9QUm8zVWpPQy9UcWpQcG1jbGw2c0syemRLanFsM055YTk1TGhuelhtSmVy?=
 =?utf-8?B?bm1VWXdvZDVueTVlRHpkWWhySVhMMEFUWXBBdmpDdWhOUTU4ZWtETFJGR2xX?=
 =?utf-8?B?YjR5aUwxbG1IMjV4UTlqcEphSlZ1aUNqeW9EU1lwRlpCSUtQR2dvaUlTekpa?=
 =?utf-8?B?cHRoMmpLbGpqNmlnS1paR3hISzZIZG9ITUVxUzZUaVlJQ2VOMXlEOXdFLzg5?=
 =?utf-8?B?WnhzeUhlbjJSVkFZY2hBZE1wdlEwVEEvcGtycnA1cm8zV2Z4M0s4emVuc1RH?=
 =?utf-8?B?bmwzT04vb3Y4VlJWWTFKUVZNbTc3KzFTQU1nQnZCaWFWdnI0ZE5NTmorMldK?=
 =?utf-8?B?RUs5OTBIQ2NnS0xBcXN2YWhMdkVra1cwNnZveUpPUEtBdFFESWJuUWgvWEcv?=
 =?utf-8?B?QkEzRGd5d0YrYXBNTlFkeHp2S1p5TEhRS0l0b3RGWWxGamx3b3F1MDhGWEpF?=
 =?utf-8?B?b3pVMlJHSWd5Q1pVQnpJbzV6dVVCOG1ZUFc2ejlpSEY1andhNWxoaHlYcUtT?=
 =?utf-8?B?M3VwMU5NOXRwRDIxQjViRlF0bllrMHlCUjg3eHVOeUsyeFVvbHllVTdLeVZh?=
 =?utf-8?B?cEVNSjBXcEZzTDVFeDFyUVlhMmZiallvdm5QVmJMNlErZThxdFhmWUR1NEU4?=
 =?utf-8?B?dFA2T1Q5Q1RVUExWL21uOVcvbWRrSXJlbWtWNy84d3ZMQlZoNzV4WUU0Wi93?=
 =?utf-8?B?MVVYbnhJeTF1Q2FSVTNGY1F5MUx1YXpJa0htVDR0QTBCNTd6alZ5QnVkM2hy?=
 =?utf-8?B?U2pISHhPT2IzbjBlYkVieU1jZG1pVzNwUTE1WTFOdkJHcnp5NVVFSUVzQzA0?=
 =?utf-8?B?d09SelpvSkM1TVNwdnk3Zk5mSU1tMUJ2dUNQS3E0b0ZnV3hXdnJUSWkyclZF?=
 =?utf-8?B?K0Z0ZFk1aEpnc2UwSGlFQ0lEVmtjT0tYZTVoU0xTVXdpbTJtMFViSzFjME1P?=
 =?utf-8?B?UVh0ZDgwWWRYT25rSFQ1dWhFMGZ2QUZvUEgycW13VE0wVkN5TVd4cXUxWTVP?=
 =?utf-8?B?Vm5TakF6ZmZ3bUpjWlc5V25HRERZWkJDa3IrMEpoLzl6czEra2g2eHRHUHE2?=
 =?utf-8?B?K3h0L1M0UDdFTFZqWmZ4SUxMY3RjV0JvaXM1bWFQa0YyTmFMcHFiYXQ5N0hS?=
 =?utf-8?B?a0o2Q0p1dDJqWnA1aUxLcjY4QlE5c1g5clU0Nmk4V2hlVWlVZVAxbHRZTVBC?=
 =?utf-8?B?QkZyc1VlSW9nVmQ2S3VWVjBRRWh0L3VrWVpIVjkwU0VOVjdUZUhpakZCSzU2?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5564ea57-b929-43b9-5dbf-08ddfe6751ee
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8286.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 08:16:27.0770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxF03+lMB8mGtpfkWaSw2SBTKaCZ7PR52cp+kQWqnzJnPxYFinNgfPukBDztoS8HgeRUck8izYRed/YYnDaQ9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB9519
X-OriginatorOrg: intel.com

Rebased with latest perf-tools-next. Looking forward to your review 
comments. Thanks.

Regards,

Tianyou

On 9/28/2025 5:02 PM, Tianyou Li wrote:
> Perf c2c report currently specified the code address and source:line
> information in the cacheline browser, while it is lack of annotation
> support like perf report to directly show the disassembly code for
> the particular symbol shared that same cacheline. This patches add
> a key 'a' binding to the cacheline browser which reuse the annotation
> browser to show the disassembly view for easier analysis of cacheline
> contentions. By default, the 'TAB' key navigate to the code address
> where the contentions detected.
>
> Signed-off-by: Tianyou Li <tianyou.li@intel.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
> Reviewed-by: Jiebin Sun <jiebin.sun@intel.com>
> Reviewed-by: Pan Deng <pan.deng@intel.com>
> Reviewed-by: Zhiguo Zhou <zhiguo.zhou@intel.com>
> Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
> ---
>   tools/perf/builtin-annotate.c     |   2 +-
>   tools/perf/builtin-c2c.c          | 130 ++++++++++++++++++++++++++++--
>   tools/perf/ui/browsers/annotate.c |  41 +++++++++-
>   tools/perf/ui/browsers/hists.c    |   2 +-
>   tools/perf/util/annotate.c        |   2 +-
>   tools/perf/util/annotate.h        |   2 +
>   tools/perf/util/hist.h            |   6 +-
>   7 files changed, 171 insertions(+), 14 deletions(-)
>
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 646f43b0f7c4..f977e97a9c96 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -519,7 +519,7 @@ static void hists__find_annotations(struct hists *hists,
>   			/* skip missing symbols */
>   			nd = rb_next(nd);
>   		} else if (use_browser == 1) {
> -			key = hist_entry__tui_annotate(he, evsel, NULL);
> +			key = hist_entry__tui_annotate(he, evsel, NULL, NO_INITIAL_IP);
>   
>   			switch (key) {
>   			case -1:
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 9e9ff471ddd1..bf2136d062ef 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -45,6 +45,8 @@
>   #include "pmus.h"
>   #include "string2.h"
>   #include "util/util.h"
> +#include "util/symbol.h"
> +#include "util/annotate.h"
>   
>   struct c2c_hists {
>   	struct hists		hists;
> @@ -62,6 +64,7 @@ struct compute_stats {
>   
>   struct c2c_hist_entry {
>   	struct c2c_hists	*hists;
> +	struct evsel		*evsel;
>   	struct c2c_stats	 stats;
>   	unsigned long		*cpuset;
>   	unsigned long		*nodeset;
> @@ -225,6 +228,12 @@ he__get_c2c_hists(struct hist_entry *he,
>   	return hists;
>   }
>   
> +static void c2c_he__set_evsel(struct c2c_hist_entry *c2c_he,
> +				struct evsel *evsel)
> +{
> +	c2c_he->evsel = evsel;
> +}
> +
>   static void c2c_he__set_cpu(struct c2c_hist_entry *c2c_he,
>   			    struct perf_sample *sample)
>   {
> @@ -334,6 +343,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>   
>   	c2c_he__set_cpu(c2c_he, sample);
>   	c2c_he__set_node(c2c_he, sample);
> +	c2c_he__set_evsel(c2c_he, evsel);
>   
>   	hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
>   	ret = hist_entry__append_callchain(he, sample);
> @@ -371,6 +381,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>   
>   		c2c_he__set_cpu(c2c_he, sample);
>   		c2c_he__set_node(c2c_he, sample);
> +		c2c_he__set_evsel(c2c_he, evsel);
>   
>   		hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
>   		ret = hist_entry__append_callchain(he, sample);
> @@ -2550,6 +2561,35 @@ static void perf_c2c__hists_fprintf(FILE *out, struct perf_session *session)
>   }
>   
>   #ifdef HAVE_SLANG_SUPPORT
> +
> +static int perf_c2c__toggle_annotation(struct hist_browser *browser)
> +{
> +	struct hist_entry *he = browser->he_selection;
> +	struct symbol *sym = NULL;
> +	struct c2c_hist_entry *c2c_he = NULL;
> +	struct annotated_source *src = NULL;
> +
> +	if (he == NULL) {
> +		ui_browser__help_window(&browser->b, "No entry selected for annotation");
> +		return 0;
> +	}
> +	sym = (&he->ms)->sym;
> +
> +	if (sym == NULL) {
> +		ui_browser__help_window(&browser->b, "Can not annotate, no symbol found");
> +		return 0;
> +	}
> +
> +	src = symbol__hists(sym, 0);
> +	if (src == NULL) {
> +		ui_browser__help_window(&browser->b, "Failed to initialize annotation source");
> +		return 0;
> +	}
> +
> +	c2c_he = container_of(he, struct c2c_hist_entry, he);
> +	return hist_entry__tui_annotate(he, c2c_he->evsel, NULL, he->ip);
> +}
> +
>   static void c2c_browser__update_nr_entries(struct hist_browser *hb)
>   {
>   	u64 nr_entries = 0;
> @@ -2617,6 +2657,7 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
>   	" ENTER         Toggle callchains (if present) \n"
>   	" n             Toggle Node details info \n"
>   	" s             Toggle full length of symbol and source line columns \n"
> +	" a             Toggle annotation view \n"
>   	" q             Return back to cacheline list \n";
>   
>   	if (!he)
> @@ -2651,6 +2692,9 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
>   			c2c.node_info = (c2c.node_info + 1) % 3;
>   			setup_nodes_header();
>   			break;
> +		case 'a':
> +			perf_c2c__toggle_annotation(browser);
> +			break;
>   		case 'q':
>   			goto out;
>   		case '?':
> @@ -2989,6 +3033,11 @@ static int setup_coalesce(const char *coalesce, bool no_source)
>   	return 0;
>   }
>   
> +static bool perf_c2c__has_annotation(void)
> +{
> +	return use_browser == 1;
> +}
> +
>   static int perf_c2c__report(int argc, const char **argv)
>   {
>   	struct itrace_synth_opts itrace_synth_opts = {
> @@ -3006,6 +3055,7 @@ static int perf_c2c__report(int argc, const char **argv)
>   	const char *display = NULL;
>   	const char *coalesce = NULL;
>   	bool no_source = false;
> +	const char *disassembler_style = NULL, *objdump_path = NULL, *addr2line_path = NULL;
>   	const struct option options[] = {
>   	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
>   		   "file", "vmlinux pathname"),
> @@ -3033,6 +3083,12 @@ static int perf_c2c__report(int argc, const char **argv)
>   	OPT_BOOLEAN(0, "stitch-lbr", &c2c.stitch_lbr,
>   		    "Enable LBR callgraph stitching approach"),
>   	OPT_BOOLEAN(0, "double-cl", &chk_double_cl, "Detect adjacent cacheline false sharing"),
> +	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
> +		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
> +	OPT_STRING(0, "objdump", &objdump_path, "path",
> +		   "objdump binary to use for disassembly and annotations"),
> +	OPT_STRING(0, "addr2line", &addr2line_path, "path",
> +		   "addr2line binary to use for line numbers"),
>   	OPT_PARENT(c2c_options),
>   	OPT_END()
>   	};
> @@ -3040,6 +3096,12 @@ static int perf_c2c__report(int argc, const char **argv)
>   	const char *output_str, *sort_str = NULL;
>   	struct perf_env *env;
>   
> +	annotation_options__init();
> +
> +	err = hists__init();
> +	if (err < 0)
> +		goto out;
> +
>   	argc = parse_options(argc, argv, options, report_c2c_usage,
>   			     PARSE_OPT_STOP_AT_NON_OPTION);
>   	if (argc)
> @@ -3052,6 +3114,36 @@ static int perf_c2c__report(int argc, const char **argv)
>   	if (c2c.stats_only)
>   		c2c.use_stdio = true;
>   
> +	/**
> +	 * Annotation related options
> +	 * disassembler_style, objdump_path, addr2line_path
> +	 * are set in the c2c_options, so we can use them here.
> +	 */
> +	if (disassembler_style) {
> +		annotate_opts.disassembler_style = strdup(disassembler_style);
> +		if (!annotate_opts.disassembler_style) {
> +			err = -ENOMEM;
> +			pr_err("Failed to allocate memory for annotation options\n");
> +			goto out;
> +		}
> +	}
> +	if (objdump_path) {
> +		annotate_opts.objdump_path = strdup(objdump_path);
> +		if (!annotate_opts.objdump_path) {
> +			err = -ENOMEM;
> +			pr_err("Failed to allocate memory for annotation options\n");
> +			goto out;
> +		}
> +	}
> +	if (addr2line_path) {
> +		symbol_conf.addr2line_path = strdup(addr2line_path);
> +		if (!symbol_conf.addr2line_path) {
> +			err = -ENOMEM;
> +			pr_err("Failed to allocate memory for annotation options\n");
> +			goto out;
> +		}
> +	}
> +
>   	err = symbol__validate_sym_arguments();
>   	if (err)
>   		goto out;
> @@ -3126,6 +3218,38 @@ static int perf_c2c__report(int argc, const char **argv)
>   	if (err)
>   		goto out_mem2node;
>   
> +	if (c2c.use_stdio)
> +		use_browser = 0;
> +	else
> +		use_browser = 1;
> +
> +	/*
> +	 * Only in the TUI browser we are doing integrated annotation,
> +	 * so don't allocate extra space that won't be used in the stdio
> +	 * implementation.
> +	 */
> +	if (perf_c2c__has_annotation()) {
> +		int ret = symbol__annotation_init();
> +
> +		if (ret < 0)
> +			goto out_mem2node;
> +		/*
> +		 * For searching by name on the "Browse map details".
> +		 * providing it only in verbose mode not to bloat too
> +		 * much struct symbol.
> +		 */
> +		if (verbose > 0) {
> +			/*
> +			 * XXX: Need to provide a less kludgy way to ask for
> +			 * more space per symbol, the u32 is for the index on
> +			 * the ui browser.
> +			 * See symbol__browser_index.
> +			 */
> +			symbol_conf.priv_size += sizeof(u32);
> +		}
> +		annotation_config__init();
> +	}
> +
>   	if (symbol__init(env) < 0)
>   		goto out_mem2node;
>   
> @@ -3135,11 +3259,6 @@ static int perf_c2c__report(int argc, const char **argv)
>   		goto out_mem2node;
>   	}
>   
> -	if (c2c.use_stdio)
> -		use_browser = 0;
> -	else
> -		use_browser = 1;
> -
>   	setup_browser(false);
>   
>   	err = perf_session__process_events(session);
> @@ -3210,6 +3329,7 @@ static int perf_c2c__report(int argc, const char **argv)
>   out_session:
>   	perf_session__delete(session);
>   out:
> +	annotation_options__exit();
>   	return err;
>   }
>   
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index 8fe699f98542..63d0e28fb991 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -605,7 +605,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
>   	target_ms.map = ms->map;
>   	target_ms.sym = dl->ops.target.sym;
>   	annotation__unlock(notes);
> -	__hist_entry__tui_annotate(browser->he, &target_ms, evsel, hbt);
> +	__hist_entry__tui_annotate(browser->he, &target_ms, evsel, hbt, NO_INITIAL_IP);
>   
>   	/*
>   	 * The annotate_browser above changed the title with the target function
> @@ -864,6 +864,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
>   	const char *help = "Press 'h' for help on key bindings";
>   	int delay_secs = hbt ? hbt->refresh : 0;
>   	char *br_cntr_text = NULL;
> +	u64 init_ip = NO_INITIAL_IP;
>   	char title[256];
>   	int key;
>   
> @@ -873,6 +874,13 @@ static int annotate_browser__run(struct annotate_browser *browser,
>   
>   	annotate_browser__calc_percent(browser, evsel);
>   
> +	/* the selection are intentionally even not from the sample percentage */
> +	if (browser->entries.rb_node == NULL && browser->selection) {
> +		init_ip = sym->start + browser->selection->offset;
> +		disasm_rb_tree__insert(browser, browser->selection);
> +		browser->curr_hot = rb_last(&browser->entries);
> +	}
> +
>   	if (browser->curr_hot) {
>   		annotate_browser__set_rb_top(browser, browser->curr_hot);
>   		browser->b.navkeypressed = false;
> @@ -973,6 +981,18 @@ static int annotate_browser__run(struct annotate_browser *browser,
>   				ui_helpline__puts(help);
>   			annotate__scnprintf_title(hists, title, sizeof(title));
>   			annotate_browser__show(browser, title, help);
> +			/* Previous RB tree may not valid, need refresh according to new entries*/
> +			if (init_ip != NO_INITIAL_IP) {
> +				struct disasm_line *dl = find_disasm_line(sym, init_ip, true);
> +
> +				browser->curr_hot = NULL;
> +				browser->entries.rb_node = NULL;
> +				if (dl != NULL) {
> +					disasm_rb_tree__insert(browser, &dl->al);
> +					browser->curr_hot = rb_last(&browser->entries);
> +				}
> +				nd = browser->curr_hot;
> +			}
>   			continue;
>   		case 'o':
>   			annotate_opts.use_offset = !annotate_opts.use_offset;
> @@ -1106,22 +1126,23 @@ static int annotate_browser__run(struct annotate_browser *browser,
>   }
>   
>   int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
> -			     struct hist_browser_timer *hbt)
> +			     struct hist_browser_timer *hbt, u64 init_ip)
>   {
>   	/* reset abort key so that it can get Ctrl-C as a key */
>   	SLang_reset_tty();
>   	SLang_init_tty(0, 0, 0);
>   	SLtty_set_suspend_state(true);
>   
> -	return __hist_entry__tui_annotate(he, &he->ms, evsel, hbt);
> +	return __hist_entry__tui_annotate(he, &he->ms, evsel, hbt, init_ip);
>   }
>   
>   int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>   			       struct evsel *evsel,
> -			       struct hist_browser_timer *hbt)
> +			       struct hist_browser_timer *hbt, u64 init_ip)
>   {
>   	struct symbol *sym = ms->sym;
>   	struct annotation *notes = symbol__annotation(sym);
> +	struct disasm_line *dl = NULL;
>   	struct annotate_browser browser = {
>   		.b = {
>   			.refresh = annotate_browser__refresh,
> @@ -1173,6 +1194,18 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>   		browser.he = &annotate_he;
>   	}
>   
> +	/*
> +	 * If init_ip is set, it means that there should be a line
> +	 * intentionally selected, not based on the percentages
> +	 * which caculated by the event sampling. In this case, we
> +	 * convey this information into the browser selection, where
> +	 * the selection in other cases should be empty.
> +	 */
> +	if (init_ip != NO_INITIAL_IP) {
> +		dl = find_disasm_line(sym, init_ip, false);
> +		browser.selection = &dl->al;
> +	}
> +
>   	ui_helpline__push("Press ESC to exit");
>   
>   	if (annotate_opts.code_with_type) {
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> index 487c0b08c003..3675a703de11 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -2485,7 +2485,7 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
>   		evsel = hists_to_evsel(browser->hists);
>   
>   	he = hist_browser__selected_entry(browser);
> -	err = __hist_entry__tui_annotate(he, &act->ms, evsel, browser->hbt);
> +	err = __hist_entry__tui_annotate(he, &act->ms, evsel, browser->hbt, NO_INITIAL_IP);
>   	/*
>   	 * offer option to annotate the other branch source or target
>   	 * (if they exists) when returning from annotate
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index c9b220d9f924..937effbeda69 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2622,7 +2622,7 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
>   	return 0;
>   }
>   
> -static struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip,
> +struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip,
>   					    bool allow_update)
>   {
>   	struct disasm_line *dl;
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index eaf6c8aa7f47..bbe67588bbdd 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -170,6 +170,8 @@ static inline struct disasm_line *disasm_line(struct annotation_line *al)
>   	return al ? container_of(al, struct disasm_line, al) : NULL;
>   }
>   
> +struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip, bool allow_update);
> +
>   /*
>    * Is this offset in the same function as the line it is used?
>    * asm functions jump to other functions, for instance.
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index c64005278687..e544e1795f19 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -713,12 +713,14 @@ struct block_hist {
>   #include "../ui/keysyms.h"
>   void attr_to_script(char *buf, struct perf_event_attr *attr);
>   
> +#define NO_INITIAL_IP 0
> +
>   int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>   			       struct evsel *evsel,
> -			       struct hist_browser_timer *hbt);
> +			       struct hist_browser_timer *hbt, u64 init_ip);
>   
>   int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
> -			     struct hist_browser_timer *hbt);
> +			     struct hist_browser_timer *hbt, u64 init_ip);
>   
>   int evlist__tui_browse_hists(struct evlist *evlist, const char *help, struct hist_browser_timer *hbt,
>   			     float min_pcnt, struct perf_env *env, bool warn_lost_event);
