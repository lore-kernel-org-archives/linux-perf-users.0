Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D324E1531C1;
	Fri, 10 Oct 2025 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760082599; cv=fail; b=A/j55CUNiqFy0tBkB+ZIQczol5DwEYZ//C9BH98xlBL1MxezKowppXmbKxQbHOAqyauXFq5D5gSkj3a12WdfBN0nHhBAdRqwuN8Rz+oAYAgrDVG5lM/I6KXivLgRKcuvfTuWqtfpwqFG0NOZK6p8MTRwtiRf6jam79X2I7YsDvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760082599; c=relaxed/simple;
	bh=v7oq4Rt3lwOz7Tc643Q7eCI2UbEx6eQM2t3OnmMaAbM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZE0pHe41rfSjvNgPKkisWDjtakTwvKK/hzlhBcOgc/i7Xxuo16DijydFPCC5goyY6G9rAbmMXkDO+0Uo9b57LsAxZD3UJSz3dDwR6gec2NsolnmKuNb9PAGm06cM7lO/FTzzVgLEYNsOnpGN2hbx7r2/cw+9wX2tiiOZYPW46DQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LgPvXBny; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LgPvXBny"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760082598; x=1791618598;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v7oq4Rt3lwOz7Tc643Q7eCI2UbEx6eQM2t3OnmMaAbM=;
  b=LgPvXBnyibXUnlDOchCps+GJZBWlGvKyLBnzTNFiFlZoPiu+SdlS/zLG
   yfxFTMwWG3AxjnwPMOmbI0vH7PJ3UWju6/+DL/Hryzmvo+A2OjbMESuhG
   3fKjE14DqZltv2eUoI2WBiI0O51jZo6lJXuOfGgR1GUQnhN7VvBr/EB46
   hGmfz2xPHfbsDVKSPix9oVW5PwjuMqM9Vt94HndmcsNZ29XUrJ2F8S7gl
   Qs9G92SCVNAEegAeKDBCTcAIxMG9baooIX3qgD11+YVfUIqernDS0NRLR
   sXsvS9oLdWyGBwdkXpZlitQTtE5byEuDkgSfq1bX1lic31nwanup0UmIj
   g==;
X-CSE-ConnectionGUID: +p6wUPcyT9+weZJqbPUj4w==
X-CSE-MsgGUID: HO81juuZSdiQgB5lHfmlKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="73644919"
X-IronPort-AV: E=Sophos;i="6.19,218,1754982000"; 
   d="scan'208";a="73644919"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 00:49:57 -0700
X-CSE-ConnectionGUID: jngC/b3NQviNXsdpDxca6A==
X-CSE-MsgGUID: ZsWSL30qSHqZxhsebELqBg==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 00:49:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 00:49:56 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 10 Oct 2025 00:49:56 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.31) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 00:49:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJ6PeuUw29sBhp7XHPeo59ewJ8CJ7MzGKlPdJgNlfFKF5v02fBUKdsFUtiZZJ+++g1I+2duORlPgq+mEQDSpRXk3upj0y6Y8G9IPXPqxD9KL5TUssX3EJsz1t6Ogv6m9lg1LnFp+hAnp/94IAlrjzdmyeFVjR/9fG/dKtWaG5SR1LqEBOxA1YjSnA6oleFS5sFg96zFeS74zshwfHDPzve1GwNGAhFqdQXtQKdtowkGqqxAqr7ik/GGYDMeK4C2vDsuuaZczkl576GMYC0TN90JWovUWP8YpUjRJC8yIQiRueMHGqNg/b9PUz4sUW3oSNzMvVv5A9zrR4A+XHCqwyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luVTT98XC9LJ87stflpZXGI6MUgaHK6jjewlMeuk6C0=;
 b=lsXuQYXyBwKxy/L0eRopzIJK2v2IIbcddm+ujIMpUmQuMahSf9fE957KGmDKBV1fTReImKd0Iu91CG4WkKXqfkwe4XrKmW5oLlRgl7P6TMPmW4kF7Rey2nV9O60Xf4QBcioFROZ81444wZqWZzseoMyvvIz6OpljUlzgOe7S/5med5ufzW+9VHW+JbkqlM+JCOXFEoXfMwr/+1bdbny0y63/Hq/lxyrZl8LspYBwf1p3hxqk14U7zJyhlAlq79U1H/XAJyewoK7De5vVefwe2CstMu/mmVylTOTWcXY4TYYK0Hf0jNeTa3NEl6aqbxgEFhC13Z95P1XlG3VBrEOXNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB8289.namprd11.prod.outlook.com (2603:10b6:303:1e8::9)
 by PH3PPF681F257FD.namprd11.prod.outlook.com (2603:10b6:518:1::d29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Fri, 10 Oct
 2025 07:49:53 +0000
Received: from MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022]) by MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022%6]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 07:49:53 +0000
Message-ID: <9a533ced-293d-4d18-aa8f-e6aafc429e2a@intel.com>
Date: Fri, 10 Oct 2025 15:49:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] perf tools c2c: Add annotation support to perf c2c
 report
To: Ravi Bangoria <ravi.bangoria@amd.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Kan
 Liang" <kan.liang@linux.intel.com>, <wangyang.guo@intel.com>,
	<pan.deng@intel.com>, <zhiguo.zhou@intel.com>, <jiebin.sun@intel.com>,
	<thomas.falcon@intel.com>, <dapeng1.mi@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <aOTOEcNOiUiEJ9tz@google.com>
 <20251009042839.1643396-1-tianyou.li@intel.com>
 <43ac631c-3404-4e15-a02e-d1976ead4956@amd.com>
Content-Language: en-US
From: "Li, Tianyou" <tianyou.li@intel.com>
In-Reply-To: <43ac631c-3404-4e15-a02e-d1976ead4956@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PSBPR02CA0018.apcprd02.prod.outlook.com (2603:1096:301::28)
 To MW4PR11MB8289.namprd11.prod.outlook.com (2603:10b6:303:1e8::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB8289:EE_|PH3PPF681F257FD:EE_
X-MS-Office365-Filtering-Correlation-Id: 86911c42-5dcc-4d86-aef9-08de07d198f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1J0b0MvMGtMbDEzKzRvUGxnWGp3Tk12NnFxU2pXd3ozN3hTNVZRQ0c0aGp2?=
 =?utf-8?B?ZjEyQlozSFBuUGRwdDZKV0JaTHlvOHpwbGpRZHhhS0hURzBCZy8zTnNmOVYw?=
 =?utf-8?B?NmlibmFvT3lrUndJVmNlN29vNHYrTnV3Qmxmblo4L0hJMzZOWXhPTmhMVWZJ?=
 =?utf-8?B?QklpY3VEbVJpd2ZmNVE4NFJUYnc1R2RESFRVSmJvMnNVdzdYWjl0MTdDQmJu?=
 =?utf-8?B?TXB3OHBkOTNkTnNJY0NFY1phVCt6L1RYalRNWTQ1ZUI1RmtacHlyb1VudGF4?=
 =?utf-8?B?SkxVZDllYzYzSFNWZ2VSR1l3eXRDNlE0V09NYjZFQjJLdGJBQmxRYmlzVUU0?=
 =?utf-8?B?NEIrY3d5THRscXQxcVBVSkpYZnZzeWRORHR4VWRFSWRHdFJxYjM2UWViSmN2?=
 =?utf-8?B?bEpaU1hsRmtNRVNEbHl3SDFQZ1czWGZHM3V1K055bTNQdVMxV24vdmFIYmxy?=
 =?utf-8?B?WC9VZEtYSVVWMytia0laN1lzVGhhWWZWSi9iUzlnUStybXhMdlQwNXZTOVB5?=
 =?utf-8?B?clRWSnB2NWg0YWFMKzl2aGxRNU9EZFpIRVVyME9nNjBhT0ZQUkJoU3h5cmo3?=
 =?utf-8?B?NTc5SUF5ekJqN0czbm9PUC9CYzFZMmorZkdwdTFDdHM0RDl6dU9lV1REODhX?=
 =?utf-8?B?dExnbTVLd3dUeW9iUG1uNllJYTZEN3YwZTNFaVF4WHhtVDBqeGZqUWZzd2hU?=
 =?utf-8?B?MlQ4cHRncytCMDJMbWgxcHpheDRhVDY0Z2xDSkVKazdrMnYxeEQ4RGpZa1dQ?=
 =?utf-8?B?M2RMU0dhS3JlQUNMUUdPamwxeDg1STdZazhleDI1UTEvSlVKSmp0QnNrZVdQ?=
 =?utf-8?B?cUoxbW1VYXBwK1VEdEpvL2Q0b1Q3SFJSWlJjWHpQeUFIQzhtOVl1NTVCME5u?=
 =?utf-8?B?UG41bWRXWGNGVFpIR3cxVTNnQ2c1eTNwdi9LNGRndkdXd2ZQSXN3dGdNLy9E?=
 =?utf-8?B?Zk45WEhUV2kwOEhvc0xxclhWeERDejdVSWEydm5LbVJLY2xSemJ3Y3NUV29t?=
 =?utf-8?B?cjlDRkZKWCtFOW5oZW92N0dVcVYrd0w4cXhaNTlLay9iTGhIS2VIUURnQWE0?=
 =?utf-8?B?QWttSGw3MkY1UmRjc1VWenk2QzlmSVlWbkErL2pVMnE4TG1zNSsyNENpamtp?=
 =?utf-8?B?c3ZpaWhvNjY5YlMvUDIrQnRwTHNsa0EyMEFKa00zRmQvSFhXNTdneUhBQVlo?=
 =?utf-8?B?TE9NbG1YRTdETlJtOWFtMHlLZFhuOGtYYmJNbkN6MjNzUFVuVVppOTRlMm9y?=
 =?utf-8?B?enpnaE9TYXFIY1F0V3c2a3FxQXB6cDdmVDQ3NmcxTmdYTWVzV3Y4R0FqbWUx?=
 =?utf-8?B?RTYzVm5sWFU1bEdKUHBCQXJuZmQ5NXJkQ1ZhTlNrang1eG1EWG1aV3V6ZjRB?=
 =?utf-8?B?K3Y3Tk9QY1ZSYUIvZ2hDcXlBVFpEbnA2YTdSekVmN0FnYkUzR2VnKzFJSDdn?=
 =?utf-8?B?enlETldxaUJMVEx6RkR2cHdaTXlBbEFQaFdEb2FZeVNpUjBldHlZbTV6Ly9B?=
 =?utf-8?B?ZjVwbHNJVktzcTRueGRPRFcrVU9DK1dab056VFkrUy9QWi9lQURHcXZGaUg5?=
 =?utf-8?B?dSt0SEtoR2JSRkRXNzk5Tis2cjJUL1djTUJSMS9FL3ppSnA5ck8wYWlxa295?=
 =?utf-8?B?cjFHOCtITzgwem8wVVVZWkdkUkJFUkdpWi9yU2YzdGR2cnRSOEoySlRHN3Ri?=
 =?utf-8?B?RFg5bkxmTWVoRkVTT0ZUb3lqRzF6bUFCTHlxdkZOOFJ2U21iVVYyM2FQM2pP?=
 =?utf-8?B?ZGxoNk1raVVMaUxlcy9oZFJuMld6S3U4N0NHNElyYXRzTzVYU3liamtVYTNJ?=
 =?utf-8?B?RDZ5N3M3WERFelMwTnJkc3RieHlRSUhqL0drZWR5eGhsYVBiemVyblNrU25k?=
 =?utf-8?B?Um4yaUdyQWtvTzlBVWtBLzBDZUREOWpUZllUWEI0K1kwa2dMZDVOTmVaTDNY?=
 =?utf-8?Q?s6GYbZPPnEKX0Jg/4byr05x2E0gCYfQ3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB8289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmtGUTh1dlF5YlpiN3dLSHUyS0NOaC9yd1BLakxKQUFIczJkMDJvNmNDWVdL?=
 =?utf-8?B?d21GMXQ5K2R4NytkYlRGaXdwdXV1bUJFa3FiQWsvVDU1M1VWUzJQTDl5ajVo?=
 =?utf-8?B?VFhucUo3c0liWDJQa2hmSUlCQ1Ewa25QOFpYb0U0c0lYREY1NW1ZditUSUww?=
 =?utf-8?B?Z1lEV2pOQndvSURyYSs0TDJHWEpaV0ZNRVliaDNqVXlUZzNMOVkxSXJnZFFN?=
 =?utf-8?B?RjNNaFR4SkFPaGl3S0ZzalhYRmQ0a1lRYVozSGI2U3ZHSDV3Y3daaU5LV0py?=
 =?utf-8?B?dE9YUmdUdndlV01oLzRNaytrRk96ODRPVll6cG1WY2I5bzJTVldpWVJDQS9y?=
 =?utf-8?B?amxtbERCVHFzemFaZmtmUVpJYkVSaFVYOWxEeHpKd2FsL0tkK1VwWFlxZWRY?=
 =?utf-8?B?SnJPM0h3M0VicDIySTJ5N3VKa3pWaFYzek16T25vZ2tFZTNCOUxkL01ROHZr?=
 =?utf-8?B?eFBPMW9HVVBIL2VJRTdSTy9ITFcwbElCYWRPWnhFRHhXMjhrR2lRa1FIYUxZ?=
 =?utf-8?B?ak15dmw3cHdNUGdwRXAwN2crYW5Dc2xpbE51THJNNWhrajBzYjNtVjhXMFdr?=
 =?utf-8?B?S2Y5OWJGN0NIaTJqbmRJRmxObFRVM0hibTVwOTFIbndzMGIwbXppdy9IM0NT?=
 =?utf-8?B?VnNhZ2k1cENxRm91cXBWZi9xTS9UblA1dXZRdXhWRXJsNmJzYi9VcjBPZ2Jv?=
 =?utf-8?B?VnVxb1M2bHpvaFh4MzVFYitJMDladXFjbk9GRGwwbWJYNmoxK3pTR2hZMXlP?=
 =?utf-8?B?WXpYb0p4dWxlOFBDZVhwK2ZtWk5pN0k1TjU1Tk5RdUIxTm9CMjJKWndUN084?=
 =?utf-8?B?NjFBYndGZ09RVFNVL1hTODVjbWNLbmhkeHAxQXNLdUZmVTJ3TDhmd1JzNjhw?=
 =?utf-8?B?TU9WbFMyMlZLczVNc0haR21OQTJOUS9xOXZGN0JuLzluZVc3bUNKUlZWUkFx?=
 =?utf-8?B?VXk4ZnR4bDNDdlYzcmlVN0ZIRXd2Q00wYW8zNnprZWgveHlvbVd4bmJ2OEIr?=
 =?utf-8?B?aDV2MTJpZ3VLRUJQaG9KRU5wRitGZVRxM1ppSnowc2hxUUdnbWZxVjlXcFM5?=
 =?utf-8?B?N2MxUkhpN094Zk5sT2IzZ2t5a1laSWVhRTdZcjZNM05KdklWdDlNT2dwSHVD?=
 =?utf-8?B?dVdYdVMreC9zTHdwMmNJdU5CekFQZzFGeDM4YjB6TjkyZ0hmNTNITmVtS3Jv?=
 =?utf-8?B?Q1dDRlh1MUVtMXo0TUV3bUhJUGczSlYxdVRRTVZZMlpxQXpPVmRucmtuY2FW?=
 =?utf-8?B?bEhGU0ZEczJWVHU1RHpPWGE2b3duZjk2QnhOT2wvWHFaMHd3M2x0Z3c5L2d3?=
 =?utf-8?B?UVBQVkFWVWdaWUVvWThmTkFtMmYxUGg3Q1VBYjRKSUsxcFkzd3RwNFJGamVN?=
 =?utf-8?B?SEdWZUZyaElZVWZMNENlQ3dlN3loL2FiNkRYZCtLaDNCcm5IdW9OM2lTWFlr?=
 =?utf-8?B?QWZKdnNaWmZLOUtQMkNCdnlGaXcyN0FpbFl3QVVGNSt5dERudjJnMkJxNmlO?=
 =?utf-8?B?T2RSUW9CTVZuR0ZmU2xMYm9YVEpLdnVSenBaTXY5U2pzcGZyYmorMm9CUWt0?=
 =?utf-8?B?c2Z5bHR4ZDZqbis0Mk9ZT2k4SW9mT0tKRERMQm8zSUw1WTNUb0loUmtKUEx6?=
 =?utf-8?B?NU4wVmxBblRJT3ZQL0FseDhUOFFYNWcrMXUvUnRtZDNmT3RsemxRTHJKblgw?=
 =?utf-8?B?NUNDY3RiV1B6VE5YT3VjbHQyYi9BUkFvamRHREdPZHdVVWZpdC9BdEUyd3ZN?=
 =?utf-8?B?dFZaZmlLSXhSVW1XdjlnQjBEdWwwcTdUUVBJaEhMV2JTeGRTRDkvSC84WVM4?=
 =?utf-8?B?ZGdFbVRGd1dwajAvZ1pKY1JkZ2ZZSjVpUFQwQ1Jpa2JxVnB2OFFMVk8yRXhp?=
 =?utf-8?B?cmdmNWZLb2tneVowbC9TTDhJU1d0dXpiNFpONk90Ny9CS2JraFRDN2JTaXd1?=
 =?utf-8?B?am1VRm9CTzVYWGtoLzhJeENrSTUxZ2FZK0p0WFZTd2tVVkJGTElQRUVoQlVB?=
 =?utf-8?B?YlJTWWR1N3crRnU1ZWJ5SVQzZHVjVmJhaS9DMUpjeW02YWw3V3M0a25lZXF0?=
 =?utf-8?B?cGxZTnpjUTA2eVRiMHdMS3ZVR3Z3Q3pqYnpRemVFZjNlRTF2aFIzbjY3clRZ?=
 =?utf-8?Q?GUH6j+ML3+xRUUoKLx8LXsKlJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86911c42-5dcc-4d86-aef9-08de07d198f6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB8289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 07:49:53.7058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHntSozj0E95jvG10rjDIcuhcqC/C9L6U9g/ZKwbdLH9W1+fCkdYtY9asbQ38dKeumUDA3ChWBAsVQXHH21Hrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF681F257FD
X-OriginatorOrg: intel.com

Thanks Ravi. I resent the patches and updated the 'Tested-by' tag. Very 
appreciated.


Regards,

Tianyou

On 10/10/2025 1:56 PM, Ravi Bangoria wrote:
> On 09-Oct-25 9:58 AM, Tianyou Li wrote:
>> Perf c2c report currently specified the code address and source:line
>> information in the cacheline browser, while it is lack of annotation
>> support like perf report to directly show the disassembly code for
>> the particular symbol shared that same cacheline. This patches add
>> a key 'a' binding to the cacheline browser which reuse the annotation
>> browser to show the disassembly view for easier analysis of cacheline
>> contentions.
>>
>> Signed-off-by: Tianyou Li <tianyou.li@intel.com>
>> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
>> Reviewed-by: Jiebin Sun <jiebin.sun@intel.com>
>> Reviewed-by: Pan Deng <pan.deng@intel.com>
>> Reviewed-by: Zhiguo Zhou <zhiguo.zhou@intel.com>
>> Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
> Works fine on AMD.
>
> Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
>
