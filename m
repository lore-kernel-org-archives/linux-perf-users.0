Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214773081B5;
	Mon, 13 Oct 2025 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760363009; cv=fail; b=jJsPcptPURyk72pPlagelvzZQVqHKPwK95B/y4csKfGkPRQUrPKmAIl+xJ342DK9Llw6drVPtPlAXIp9eBB0aj9+WrJcJHpSwmSt7c3qWqD42JFQJyGRbgSfwNzh2bkAJn0JoI9AJYX4ZsO5ooorEyyqpkuXEQe9aD/9SZrpjiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760363009; c=relaxed/simple;
	bh=tn9jM/BHRxhiWSBF7gpReDeaIbmkPVC9HMSJagWLws4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ITmHS9U1ElsKT4LLaqMWzWaVXWE7UCDM9LlFhpxNT6S5n5vUpuizuvSiJ1l5Is2G0YubRbw83hLAue5r2+49xPMTd8o81OfAZkOLCOrvN3n0ieOlVBD0Lb4Y64FIvMDpDncoSmnJNibotxyMIbeQCw/o3tNawzJjzHSk61qqsWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TmPXpNsJ; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TmPXpNsJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760363008; x=1791899008;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tn9jM/BHRxhiWSBF7gpReDeaIbmkPVC9HMSJagWLws4=;
  b=TmPXpNsJTMGvF1YgzPu5x28ASaWVsXP4Zcv3hKH8I0DiPNd1G3muFctg
   nA9UysxIaxpbWWJnqgk+y2o5SKwyYGwIrNfMDHW0+giHOuxnDNehU6BX6
   FdobbIkNt2Xp+7UQrg9pEtGAqNLm2Our+MjlsRZohoUatPoQfEmBIBEGo
   HEIHTFevpC5q55Z+2f3cjntkpYL2NFrjbJlQbSMqvIFjmw9gczXcaUI43
   ck7MK5JrkNp4JTOBVeBLnualC9nmP2mAvCH5hu8+CH0NFTvzuDEodgSm6
   yih0ozC60nojBtk6P6JQSKpCcmU1dUDAtnzXq73FssEm6E8wAdktxvZ9k
   g==;
X-CSE-ConnectionGUID: 5k9Vbek1SXGsZniMAo8/og==
X-CSE-MsgGUID: HjQwyV8AQWaFFbs2VlaZeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="87958315"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="87958315"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 06:43:27 -0700
X-CSE-ConnectionGUID: 1KSpPwsiTPeqtUl+yMP66g==
X-CSE-MsgGUID: GNUCLFmIQcuepYqdeIeixA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="185616576"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 06:43:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 06:43:26 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 13 Oct 2025 06:43:26 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.35) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 06:43:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpprXoxpyj1FYOWfveArmqjBYDSe6pOyYd/S2n79rsyMkzIf11i/C2rVG+3yzh8PfTj6DRip8loi7bgxSceqSjWR3vICZfiIXrxkicRFCsPTQuMVSgqtdV0bSMS2mWEriXvhnEYnXrRonQl82kjzjU0RY50Gt3uEoLaNeo3ISSfsio2EkQpzcHRkeBYoyATWJMjFIA2kAe+G3My1IDv5nnhGb9LFIPlbN/10RHr1w6wpQJ9kQRm1fLdFBzSxdL8bbhjLpOiRfLsap/EaRKunrD6Jpyi68NWTqhIdg6lWNXSZ18jc4C+5PIp7148nvA+RlWvpR7mMREJK4OMtG1EljQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHG6M3u2KfUt8N9Dau4rHqASJS8a2flsNfYzemZGAjg=;
 b=BP5yp7Iv7rwj5ORgnMYMk8h1prsbPKFzxU1rmDOuaBQ6gydAdrtPfVsa5Iydz09lLK6rkZFcBju71/t5T3WjjBnaFWN3hArw+FNUABIrn1NAHPXUqjgTP5j3O+ZQJUjQ2e/APlXLhm/BK/0FfEyLwlpysa5A2mDBJxb4TT4KB65bvseV807wC5zNcOsndfcS87WE52bqR1I7kpXjU6p2bxE+vcd/bpN3noYV2eQ1g5e6rHCw4nAYPXGzQEdDGuz9xWZj4bh1RzWswFP9325UCzswKPhAwyrjc/VRx7QpRZMmSy4GG341UDUHez1m1MijgcX4+yWshcJxmHxaIpmaXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB8289.namprd11.prod.outlook.com (2603:10b6:303:1e8::9)
 by CH3PR11MB7673.namprd11.prod.outlook.com (2603:10b6:610:126::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 13:43:17 +0000
Received: from MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022]) by MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022%6]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 13:43:17 +0000
Message-ID: <4d7fea06-1c46-4786-ab58-657293a93488@intel.com>
Date: Mon, 13 Oct 2025 21:43:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] perf tools c2c: Add annotation support to perf c2c
 report
To: Ravi Bangoria <ravi.bangoria@amd.com>, Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Kan
 Liang" <kan.liang@linux.intel.com>, <wangyang.guo@intel.com>,
	<pan.deng@intel.com>, <zhiguo.zhou@intel.com>, <jiebin.sun@intel.com>,
	<thomas.falcon@intel.com>, <dapeng1.mi@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <aOkFWaFD42Jy7V0f@google.com>
 <20251011081625.1953652-1-tianyou.li@intel.com>
 <660c8ba1-635b-4acc-8824-d195f1b133a0@amd.com>
Content-Language: en-US
From: "Li, Tianyou" <tianyou.li@intel.com>
In-Reply-To: <660c8ba1-635b-4acc-8824-d195f1b133a0@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To MW4PR11MB8289.namprd11.prod.outlook.com
 (2603:10b6:303:1e8::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB8289:EE_|CH3PR11MB7673:EE_
X-MS-Office365-Filtering-Correlation-Id: 92fb608f-4a5e-4deb-84a1-08de0a5e76a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjUwY1pQellwdmhrdzVwOXBlSGFhOWJQbTg3ZFBRZS9sbHllWGwrMEw3b3Mx?=
 =?utf-8?B?bVlkQ1krbFVHOUI5aEJySGlrKzgxMlNOd01VMUEwRzkrbnpPcHUySSttNVVj?=
 =?utf-8?B?ZUl6NExGMW14Ulh6NFlHQzBWQnh1aDlaN1ZadFpVdmU5cXd2U0szbHVNM3Zu?=
 =?utf-8?B?bDZwcDl5NUs2K21ONFFPQ3RIQ0Yzcm9lL1ZDb1V4VnIvVXdZRkJPdTVsT1Nr?=
 =?utf-8?B?T3BTZjdqcDhMdkZueXF1dXJxMmRWV0lMM3JOWmJ1ckE2UHhnMSt3ME1ZUXNH?=
 =?utf-8?B?c0dHYmVMNlJXakFwaVpUNllTTU9oQzIrc2lvSXIrM2Q1UG5pL3FwbGFzbGhP?=
 =?utf-8?B?QlBtTys3QUJVdlRCOHpHblVKYU8wWUxDMWE2V2lOZEFmMkhGd2tjQ2dSK1Bi?=
 =?utf-8?B?dU9VU2NwdnplcFQ4SkpqbDZ4VGo2NldkNGRTTWRsclc3dVBkTGhFT0QrZHFh?=
 =?utf-8?B?UkNnUEY0dDlWenVEME1ScXF4bFArWEFNdmV5YS8vQld5VnlOL3V2dDV5Y1Z1?=
 =?utf-8?B?VlpCdUxhTUVTV2VwN0JvdkRuOG01MVBxa1hNNVBCR0RVNTIrSXJKbUdZaHpO?=
 =?utf-8?B?aDU3QVMwOWNzTWI2TUs4NkNiajZjTHQ0ZEpGai9mcXp5dW12YmdhRHpIN0dq?=
 =?utf-8?B?RjlqOG5CWGdHQkVadWdzaVE0OG51dVJLUVJLNmdpY2ZnQUNuaGpldkdtYzJ4?=
 =?utf-8?B?dzYzL05OdjBQMC9jK2t6RVA4Zmk0QzB1QVBjNWlPYXlsM1VOaDdESktpUzZ2?=
 =?utf-8?B?NmRDbCtOOGpiTXVQWUcwd3pVLzFHRU9FZ3ZJZ3AxTTArTCs2QXIxZFFyV1p5?=
 =?utf-8?B?WXFYdThHRUR5RGVaQ0hoQTV0NnRWZ2lVdTFVd0diZVZzeEhpamwydzJHVkl6?=
 =?utf-8?B?YlNpdHBNS29nS3JHYko5ZURSVDlwdXI3ek0zemRFVEZXNVRVc21yV1R1RjA3?=
 =?utf-8?B?aFF2TG5kcWlTdzQ1dHlRWkp0enZ1WFhQOXVDL1VtZTVYZVdTSGlkTFNxMUJV?=
 =?utf-8?B?aVBoTENJVlV2UmJrWTFnVXVNalRqSDY0Y1VPcGhhL0liM3N3bzVJc09vbEc0?=
 =?utf-8?B?aHAwNzJNRURzMTVodUxnVlZvZXoxdXgwSkNLaHdLNnIrY25qQjhlTDlmeElB?=
 =?utf-8?B?eXloTUtNVWVBMDRkRnY1TUgyL0tIYjVNVEpuM0t5NXhGY2M0V3VRamFscmE1?=
 =?utf-8?B?YUhIbGMvQ0tlMEdUNkVMNFNkbHZHcEUxNGppRlN5eFZzekZFcHFmRk9KdHU5?=
 =?utf-8?B?VEJqc2NkbnBSc2g0T0UydVZabmh4b2tKWXVnS2JMTEFIUWw5dzlDU05VQnBv?=
 =?utf-8?B?WFdoZ1BVeXR0aDI3ZjNvS1poaFl4cEc2QzFpZWJmbWtnQ2J1N1JPVHFpbWds?=
 =?utf-8?B?UWlFUU14UnFYSzBtdUQ4dWdzL1hqUlNuaWFoUUR6UlpQc3NJb0pyQTVsRVRU?=
 =?utf-8?B?VTlVUVpZTTVqUndhTWFONUdzUHRpd2NSbXBnSlE5SlZhRUQxSTNpTm1WT1pw?=
 =?utf-8?B?eHRUVkMxdlZhcUZKdHVlWlVhcEJZZFJuTTduV25aalRtU24xdHZKWVpWeGxs?=
 =?utf-8?B?QmxSblBlU0V5ajhGRUo2N25NMXJnOVF1ZFJlNFRsWGJ6SDdZdHRzbm91ckRD?=
 =?utf-8?B?Vm1LUk1pTGhIaE5FaW1uOGxQenNJSk9zRndYK2tBSXJpeWg1ekxnbHNoRTlI?=
 =?utf-8?B?YmJBOFNVY3RRSStUNG9NQVFDcHlWalU0dDRaUEpvam1mUGwrMS9kVUhzaTNS?=
 =?utf-8?B?SnBpdDRnVXN1cjVRYWFrUVM4MWYxeFpzaWd5NkVjZXhiR1lmcFVZYXVmdlBR?=
 =?utf-8?B?Mk5KZzZuYVdMKzZMYTJkZlZ3VDRaZlVDTTF4K2lzMkprUmdYTXVxOEIxai9h?=
 =?utf-8?B?MHc1SElacEgzNndFSFRuMHJPOGYreG1XRG8yeVZQeklxL3h3aU53NnRsaHVs?=
 =?utf-8?Q?Tgs3xLnaM2bDLi0ipjhZAzZHHZANjkho?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB8289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU81YUs0TENRc1FXeXlHc2tSUmRzRXFXc3pxd3FjZFVCdEZmY1RGTCs3NkFH?=
 =?utf-8?B?RmtsNEJWWG5pV2Q5bjhyN3g4NFNHKzE2bW5WNWxUOVl6RWNyb0U4UktUNnNN?=
 =?utf-8?B?SXJiU2NQWE1XTnI3RDFCdnFvbXZOdnZtUnhJa2JTUHY1WngzZXEyWWY3K3Bo?=
 =?utf-8?B?S1NEZ2VZYTdYbEtHNU1GcmpQRUViNGozRWEyMUdEZHRlOHRSdTlWdnQwWHRp?=
 =?utf-8?B?VUJ1aVlzTnRRc0tBQ1kyWEx4QzYvMTMvTmJsM015Z3Fjc3pPd2g1RWp1eXk4?=
 =?utf-8?B?UmlxWHhQTFBLVzdwOG5Bc0dmN1h2d3BndEltMVpnV3V3N2t3T2hVT2k1aUI0?=
 =?utf-8?B?S3UyYUtjLy9iK0wxOGd3UmxkeWk1ak5LRnhIZTF1QXZiZXMzcFdlejdWaDR3?=
 =?utf-8?B?TDhlNTk4ZTFPaDgyK1l4RGo5UGRybW1CMnZLa1B0c2NBODFEQUwxOTlhOFU3?=
 =?utf-8?B?Z3BCL21JaHdWSW9YWUg0ZUY0RHdscythUWRKN3o2UWdjSFkydTNnd0lLcmVI?=
 =?utf-8?B?eGgwam1EbzVHVTZuKzZHcVpnbE9BM2IzQnNqMzBZQTZURWxMb0I0aFdBK1JJ?=
 =?utf-8?B?SEFuQ0Z2VG8ybWg0VDUrYnc1UWtTbGNlWUpCMkNmdmFteVhNUEljSklGbmpk?=
 =?utf-8?B?NUpsYUIzLzVaUWFkMnNBbXlGaHkxRDUrV3l1TVBEZ1BSQnlNYmh6aGMrVkpP?=
 =?utf-8?B?b2pDb0RmZjlZZVA4WnNOQ2hMSTFyWVlqWlltVUdPQkVhT3lrQWRWU0ZIdjJX?=
 =?utf-8?B?UlMyQkR6OERUR3VVaUl5M3lxVnFSSDEvNFl1aEV1VVRPTHNTZUhINkJvSHhx?=
 =?utf-8?B?Smt4ck1jUUdTcVhhTSs3MHkzWnRXd2FRVzJpN1c1SitxcDJPWCsyZzNoWHFa?=
 =?utf-8?B?S3RNVzAzNHljZERBNSticWpxWVR6QXVLaGVjRHdJUG03SDJkVUtNY2xIZnhZ?=
 =?utf-8?B?Z2RlcW11WERERnJUQnBQT0drTkNWQmJjZ2VqN0ZYdUMrS3NVaDIzQS9OUkYr?=
 =?utf-8?B?K2JnNk84TUF1VnRDMFNSc2E3YW1xSGJzWTFadFFjcURpZFl4ZEpWZHdzTjg1?=
 =?utf-8?B?eUQyZ3lwdUVnM1VkZDUvV2tGQ0NzTnJsNnZpS0h1UjRDSUllNUhTMTRneWFz?=
 =?utf-8?B?RHQzZ0Y2TXVkeFROckxTNklOSUlGQitYeW8xSkhITm0rK0kvYjh2V0M1Tldx?=
 =?utf-8?B?c0I1aDBFelc0RTJzSW55elJNTUlYTGVlTWREcnZydDh6L3ltUHh5RFNRRjJn?=
 =?utf-8?B?MDNCd0daOU9RaWxFZDJ2TUc4OWZEQXkyc2tOQkZVN3dZbTRKVzJwM2FmUmJI?=
 =?utf-8?B?RkNLR1Ywb3lVTWpRT0hnem50UTRkck1sWnlTRG9qRUNEZGkzOWw5Nnd0YUdv?=
 =?utf-8?B?d2oyVnQ2TzB6Y3NCb1VSUlRvdW5nZjhZYUZOZU9mcndkdXFLcEZ3RHVtbzlz?=
 =?utf-8?B?cUJ1alA3d1dsNjc5SC9lcXhROHVWL1NaQlIxY1AyOVdFaFZ6U3FrVGZKcDdO?=
 =?utf-8?B?c21yMkZEaHEwV3VlMlI5bzA3eWFRYnJ0U21mTEpRMDhKeCtZQm9tcHEvU3Fz?=
 =?utf-8?B?MHZzeUJSMzBGOTMvRG11Uzh6dFVFcHpxMVhvRE1saTZLOWJURnpadGtsNFo3?=
 =?utf-8?B?UGRPR1pBdzlsVXJpcEpwc2paL3NtVWU5alFnREE3STFZWDF2VlVNa2dxdVhU?=
 =?utf-8?B?aFRZeVpvRGVEcENJRGdPVE9VMUIzL0w2dzU4YnEzWC9QRWx0SGV2dTV4NWZZ?=
 =?utf-8?B?RHpXSm9mNWxIZ0xja2VUZUdOb2VnWHBCTVJUVVlSZkVFMTZHNmtpYXJVMFNt?=
 =?utf-8?B?T2NuYmN3dERRcHpNT1RhQk0vdVNjbEg1bDlUZEg3bDlTSS9TZVRwMWVyNE9D?=
 =?utf-8?B?Y2ZXa3h5WXVLejhuaGsyWmNLQTBTK2VMLzJXUm1JT05qWFB6UlhYcXRINzMr?=
 =?utf-8?B?U21rWHpXR2EraDBzSXdHdGJ4clgvQXNSbUwwYzBwZXRCeERwUVY2RjRBeWli?=
 =?utf-8?B?aWF1eGorSWdSTTVkQUZOQmtwbE02MzJFa0FHWnd6NXY3WjZwRHdZWERMbGo3?=
 =?utf-8?B?akEzYWNoay9Nd0lyT0xrR2ZpUDQzVHd6czFBYjhqK2xxU3JERG5UcW9ZMUdu?=
 =?utf-8?Q?zl+z6U3n95q+hTl0VZh2D4nih?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92fb608f-4a5e-4deb-84a1-08de0a5e76a3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB8289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 13:43:17.1368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YhzLiK/4CNZQkXBW+uPVyTAUh1Cdbx+uG9+4e8IW6Rze7hjEkMsFE8TkLrwxNcz7fkD7CVGmLnY+Pr35xcyew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7673
X-OriginatorOrg: intel.com

Hi Ravi,

Appreciated for your testing and the code. It works like magic. Learnt.

I compared the sample count, percentage and period by 't' in annotate 
browser, all numbers in perf c2c report aligned with perf report.

I am curious if we should update the evsel_hists->stats when 
perf_c2c__has_annotation return true. I will send out patch v8 soon.

Regards,

Tianyou

On 10/13/2025 4:52 PM, Ravi Bangoria wrote:
> On 11-Oct-25 1:46 PM, Tianyou Li wrote:
>> Perf c2c report currently specified the code address and source:line
>> information in the cacheline browser, while it is lack of annotation
>> support like perf report to directly show the disassembly code for
>> the particular symbol shared that same cacheline. This patches add
>> a key 'a' binding to the cacheline browser which reuse the annotation
>> browser to show the disassembly view for easier analysis of cacheline
>> contentions.
> I still see annotate browser title with samples/event count as 0.
> Something like below (lightly tested) should fix it. Can you please
> check?
>
>
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -299,6 +299,18 @@ static bool perf_c2c__has_annotation(struct perf_hpp_list *list)
>   	return !list || list->sym;
>   }
>   
> +static void perf_c2c__evsel_hists_inc_stats(struct evsel *evsel,
> +					    struct hist_entry *he,
> +					    struct perf_sample *sample)
> +{
> +	struct hists *evsel_hists = evsel__hists(evsel);
> +
> +	hists__inc_nr_samples(evsel_hists, he->filtered);
> +	evsel_hists->stats.total_period += sample->period;
> +	if (!he->filtered)
> +		evsel_hists->stats.total_non_filtered_period += sample->period;
> +}
> +
>   static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>   				union perf_event *event,
>   				struct perf_sample *sample,
> @@ -363,6 +375,9 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>   	hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
>   	if (perf_c2c__has_annotation(NULL))
>   		addr_map_symbol__inc_samples(mem_info__iaddr(mi), sample, evsel);
> +
> +	perf_c2c__evsel_hists_inc_stats(evsel, he, sample);
> +
>   	ret = hist_entry__append_callchain(he, sample);
>   
>   	if (!ret) {
>
> Thanks,
> Ravi
>
