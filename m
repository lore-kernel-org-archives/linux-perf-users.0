Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795552741;
	b=sGC9PuHxBDQWNMSy6ehyUWppMqZtL/C9I99rszJf+YMPLKlsyXFcGmV8XK6pr6AyGVzF
	 XhfYOK0JF3D4y+YdhdbxxfvHhYgaOOXuvA0Qp7vceZ6If+4q5rbFzkCH4NfUs+Ia/7Bvm
	 eK+fyjzvpXloNMWxU+pWA/OzLaln9xIC9hootzkcIpvVOYeZxz2Tqy/M+z2iD5jXlACdo
	 xMs/0lk05/UqFInqs/5vPtjlAqWaX+/Fy2JNlvhW6XCs2w6+moEaZIIeHUHVL/I20k+q+
	 3ZCFMOFS7rgRmUZi3Y15TS9SBiScUJ9bqYy11Q2f54m03mMvIK2lFMZx+20eQUOEkFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795552741;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:CC:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=Uz9Pd7EOL/4+aT4BALFe89FVLH9mNx7FK5jEuD+/Udc=;
	b=Y9s+F5nGECydS5ZmDUwXN5a1awz1VnjyqPAKbEE/+mdCARlxFdS1LeTTx+gII/AlaWxw
	 5iig5okQdLRnGlv0ydQdM5rE29n2s3P8x6y4xv67lTPWo8o+7TBcd/B04pvU3XxkRrILR
	 61gtxwSN22T8iaTNiHYryLu3XPxMDy9KlxYiChYh8r/NdqX6X4bEn30KtrNIg7WfMXyKM
	 pZNHC2pfHDnBiilL2Q6zjxjZ22bEXdzcioiZNrx/j6Ut2IyNGvKAiU4SIadgpyvrU52dG
	 Jsth6rmgimJYwUlKIqwHQBuzAmxjOWAGPJxI4gU08S+vq0B9sR4SSRfltI4p6jjDosg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gLJ+suS4;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=T0axgwNx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4335606A31E;
	Tue, 24 Nov 2026 20:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4335606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gLJ+suS4;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=T0axgwNx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795552741; x=1827088741;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3sxtIco6Phm0xYJ1zq4FSejh/1dggdUzQG3p3uVTrSU=;
  b=gLJ+suS4Kk4X8NGallyMUgvhCdTwfuWYnUbyLQhz1xP1K8olTq+lOQX4
   MFtZYkwEsE/TLi4WPVdwfOYddeahPxaY3Vwmgn+MWwhxHthouWmICB25u
   cWdqCRE8tj7Wdbz55VEhZgK0CI2v3kV/givXE6v/5aUSgXisHDzoTQoP3
   5GAhZls4zEBECUZ3Z2S5olKArVRjnrFvD6sjl6RIq7abeTZnAShbJ8lht
   qtAXx06fLxPvxVUJLqGrvjE5M/VnBJjhxYtcFryblbsYjxduX3cIiwvLl
   cvacuRftvM/91XLNazARGZqBxiQcDuZn4oZncQXMrglsFUWOlEbCAbUC0
   w==;
X-CSE-ConnectionGUID: r2F0P+fNSySx9gnjtr7TiA==
X-CSE-MsgGUID: YtRBjflhQweJ9ZgzXhkjrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4338827"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4338827"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 12:39:00 -0800
X-CSE-ConnectionGUID: xueIRXcCTRi1QTVylEOx3w==
X-CSE-MsgGUID: KcdwUI4pR460l+n/ULeXyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="11794809"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 12:39:00 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:38:58 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 12:38:58 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.20) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:38:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpiijBozwVQ7DXMyvXOSlS8L9daSANyVd1NdpNJMDftTpf2uVJ6q3VcBpvprQ6fUrfnqCjgk0rpEE9bpqD2GuqAxTWVAapzxpkwxu3MsQ6j9fgaIqQiKWVgX5lYdU8CjBbRIZh+gOznkU6K0ltS7PHAY9mEm1rfS9yVFUQIM+bjTKe9qcm4IuvqtJ8vr3Qvobi0F3HWYGzxStMcLo428i4/V2ugIsZv8slYHUZR6u31zoJyYk7+KX0o1yWGcZwfqZRcP4asZ6OJuf2TxtBrR9Eyrbfv43w/i6VpiyV6MGoTED5485mVohyWxY7zddRnVAPbTiYdkHbpMYVsfeEKQPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uz9Pd7EOL/4+aT4BALFe89FVLH9mNx7FK5jEuD+/Udc=;
 b=S6rjueVQXsdULw/phcyemQFT8HAUOZagezWb91pes97ugUfYd36WsJ3UMlIZAn0WlmzXcbfnhqNAeKoc+SH47vRF3FO8Q8Pf/KLxNXi7XALnp4OEUVPTKcTi8+y0HhQWJASLnR5TP7dvkN/38yr/HUTUASt8+BEf3/hrJol4qwdEuh3rtz3MZXlnaJTZ/o3bw6qMJME32G4e9pFgtJjO08l5+rJLnrR46KuSx2V73pGQkU4H6DrHWYZ1d2tQrbhXM14/rjnZBwJURBbmmlxfHBqfHbQELv4ouAgWY53WTm3l4UIfGbsgSlv8/IY3/9fNT8odbAGZlAvFSnUsArOFnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uz9Pd7EOL/4+aT4BALFe89FVLH9mNx7FK5jEuD+/Udc=;
 b=T0axgwNxQTHllZ1UH1CNHJM6Bjtu6W3a1Te+Ni5yq16s5N3RjR1obRDeEtdO9iHXUG2cfcowdDLIH88LHwtk1RgdsI3yL0JdXdYNQDU57ssZ0b4CK68wrxp5enMhBhLmmCCVlICPEZGt49EPEWFBhh8ltV27kcyL6baoFvO4mkE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH0PR11MB4888.namprd11.prod.outlook.com (2603:10b6:510:32::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 20:38:55 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 20:38:55 +0000
Message-ID: <94665b79-b6d7-44fa-a1df-dafac3616f11@intel.com>
Date: Tue, 24 Nov 2026 22:38:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/19] perf auxtrace: intel-pt: Use common snapshot
 pointer fixup
To: James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@linux.dev>
CC: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
	<mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, Will Deacon
	<will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Suyash Mahar <smahar@meta.com>, Amir Ayupov
	<aaupov@fb.com>, <linux-arm-kernel@lists.infradead.org>,
	<coresight@lists.linaro.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>,
	<linux-doc@vger.kernel.org>, John Garry <john.garry@linux.dev>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
 <20261105-james-cs-unformatted-per-thread-fix-v4-12-7759e0ce2449@linaro.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606-4,
 Domiciled in Helsinki
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-12-7759e0ce2449@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0235.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::30) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH0PR11MB4888:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fbfd4ae-94ae-44c2-45bf-08df4a6af526
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|18002099003|22082099003|56012099006|11063799006|4143699003|261009223027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: MAkp3n22qgr0f8HSFkTY1HREmQqR2C+s4ycCmk9X0w2DHdix1MaOh9hm2hTKSI0fFMVEIaB2fLcPfcgup8c+2BBunjY3RnFdhOQwa5cfZJepu8TFMzvxcoqvtdAoUrp3/qQFbH47I02gbL6yx+dlHVRpkqudOuVtO6P+mUnWjMeAbqdl4ERpd/047RK3JcqZz4n9ogqpWLlkvuY/gfWk0GMhc07cSI4JVIJRYy8zzU2gL6W4vPQkQm4nPH5k9sceuh9N4hVF2dpvEWGS1cKzs+d0agGzDP1Vpus9CaKlJzR0wl1jNb1kmcHKfpa8QGPCQ8L6LVIsnt+sZSokBC0K82vEbSslN8S04qqnlI249d/4eUSmMqHuGCy3Q7u161YK4AyjpruAR+/CDyfwsiqD9ZhlGOwT8CcGJWQjKZwS95NAiyobm+fgzieBqOtY9Bd+w61xhsGpMam3LVS40viKi9uZkoIDkne67Cjq+ISuC41OkOMwlWkyJKeLHfdH+Xz1+ZV6+jFI2U1fAG0nMYIoBL0GbQSBMmHNFnl09wxQNhwxdvD7LEBUgHKQIPBxpYSW8LLnwWEZrklUurMshM3d8PmLZV0woQV4OiPUedE6SBA5QBGtJlgI66ulxVWEDMllVh/fFoXUU6/q57rVHWrIlA3oR0qWO6Ue8FSW1YV1YU0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(261009223027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V244c2xHd29qNGw0VElRY2ZJSCtBb0hNZGdTL2F2VVpBbTVLdko4T0p3czg3?=
 =?utf-8?B?WnY4d3ZlVkZ3OTFxeVcyS09GREFLdThQV28xWkpuMEYwOER1RHlqNnRMc29R?=
 =?utf-8?B?ZmJUbHdrRWNyN2xWZTkrbmY3NEZqOXRWUzVHVzNzLzVERTBUK055NlBmWGUx?=
 =?utf-8?B?NHExWTBjSmlMbGJrMHlWOE5yQjFsSDJiTGdaa1JJUkdKRVZuQStJdCs1NTcr?=
 =?utf-8?B?c1BHanh2S1RzaHVGTno4NVhCalhNUHl5VmVKZkFYVFgxdXc2SHZlaFhYZEtZ?=
 =?utf-8?B?aHdMRTE5MUZoYTlSUWdWSyswdnNqY1p3bUZYLzV1bCtqenJMSWtWblpmVlVD?=
 =?utf-8?B?MElPSlBZaUJIb2VHRzVxbCtkVStxT1NJVjJId3JPbVhwQkZBVFBzZmJyTzV4?=
 =?utf-8?B?b3VVaWhGWEE1QXVSamt4blg4MVoyeU02dnhHK29BRGd2eDM5VEtlcXcrZUpu?=
 =?utf-8?B?bHNhU2M5NlBqbFA3U2RzaGhLenlhSlhKYlBzMnRpM284UVJjbDBZSytuMTI4?=
 =?utf-8?B?MW5xQ3BPb0Z4b3owN0JnQ253aHRNbTc1VzhRSjdqWFp4cUs2MEJpQWhHako1?=
 =?utf-8?B?cFFYTUpnc0ZOOTBrTmFDWWdzYjdnZ0lwZG5CRDExQVl1dThTZ2tpM3EvTERj?=
 =?utf-8?B?SmRsVjI1MWordk1MUEpQMjdJY3B1TWpFKzV4NldvdnBrOGNOcVFDa0JRWUZ6?=
 =?utf-8?B?cSt2UVBDR2ZramNhb3l5OVBBS0c1SnVFR1lQeHRXa3FpNUxkWFZJSVhCUXpm?=
 =?utf-8?B?MjVFZ1VsNW0xR1cyZFF1OUFmYVdDaWxTUzJWV2M0b2lsVmozSjc3UlROR2U0?=
 =?utf-8?B?S1VIYUM3K2EvVU5UZzZhdW0wbnBQOEg4WnpEN0dwdG1QNzlkNDliWm5vcFR5?=
 =?utf-8?B?bHFIWFd4VzlaeDZRZ1gveU1rNkpadFlqaVlFMWFucDNWVm4vMEo4NTd6RXM1?=
 =?utf-8?B?aVBvSE9YOUxBdnRpQXIySU0yWFpNNmJyMjRydUpKT1A5TXgxVzVNeVcxVVdH?=
 =?utf-8?B?NThDQmUyUHY0VHpicmczeWFsTVAxKzQ4V1A1SVpIdEVRZUJLQnJoSjAzaUxs?=
 =?utf-8?B?T2JtaVphZnBiN09GNlU5aGlvTDFIZUx2bWkzUmZtZzZUck5MSTdPL0pYQnlj?=
 =?utf-8?B?Y1BtYTFteGQvR2p3eU5RamFGc2p6UTdGeEpaUnoycllQajBrZVdHYTJqc2dh?=
 =?utf-8?B?RW5ORlE2U3doeFhHMTJuL2ZTMnlJL1NLd3JPcWdOSUhXMTVFL2x3RGNWVHpq?=
 =?utf-8?B?QUwyZ254VHVMck8rSSt1RHNuY1JxbDd4V0tXSlhsSFB0bDZyVGx0ZkhEM1JE?=
 =?utf-8?B?cHNkaStudEhlZTNQUURBQnJUYXFLU04yd0x3bnRwWVVydzBiZWs0bDZqNGtX?=
 =?utf-8?B?SEVRV0hqVUVmWmtFR0FiWHJxbEU0SnJ4akF6UDlPUVhFYTNDbkFMZGt2ektn?=
 =?utf-8?B?VmlvRWNsSlFsaW4yS05mZEtlTTV0YkdOQis5bUh3TWw1ZTBMbEF4UGs1Qnhr?=
 =?utf-8?B?b2VOOHBvU285NHFBeC9mRnFEWERwOTdTY2RqSUg3YXlIQW9WM1BkZ2lnMmdi?=
 =?utf-8?B?TXVEM2FuN1JjdE9BMGJlZ0hUZkROL2JINTBYcDZzMllaZnVGeUY2S1JmSFcv?=
 =?utf-8?B?OStsbEhjUmJYSUgxQ3RHanBiNEJaNXVKNjAybWI0UExtT2FZODVrTjlOdnhy?=
 =?utf-8?B?K21XTHlrZWRsMytIcGVDYmhSWi9tQXJOZUFDai9Eby9xTVA5L2owczd0L2Fa?=
 =?utf-8?B?WSsvZDVmYkxSc0FoWmFzd3FJZlJ3bGREa1RkbjM2M0p5azVseHFZUVA2TGls?=
 =?utf-8?B?WmdacnRkZWsvaHFIUWdCdjFoOVN0OFowcFliVmN6VGxvb0NFVlZCR1d5ZC8z?=
 =?utf-8?B?eTJTNUlablAvL24rT1QrdW43WWFHWkZEZ2d2Z05aUjlmVnc1TkhBdjBCWERh?=
 =?utf-8?B?NkFYRE1Zc1JJSmphM25abDhQTVUzVFAzc1pkYkUrZTNZaW8vcE9WZFpvemJ3?=
 =?utf-8?B?dTI1dVRVc3U0YmxzN0FsZEw5YUtGUUtZNS9PUjRQQkpmNzlra1EwMkhkaFNp?=
 =?utf-8?B?UVREQTNBMzIyMDBnRGFGWnRSc21wblJxVm9ubzRrNk9uenBqTU9KMU5TTTAy?=
 =?utf-8?B?YmN6b3YvRVliWUt1RXJFanpFcjF6N1pac2g3L3pnRzRUZ1RqNVA1WVFMcVhh?=
 =?utf-8?B?eUpIZThWQzJNTkZzV1owRGx1Tjc2SmVOOTg4K3Z3dEQ5Q0V2eWVvWnhybkpr?=
 =?utf-8?B?dEQzRm1zN0xnNGpYNlk1Q3poamRkWVV0SmkwQmRRSWRwaTFoMjErdUM3L1JC?=
 =?utf-8?B?RE1oS0ZGc014SVo3cFdYQllpSHp4UjI3YTAwUXZpUUIrUFZxcVNxN3dWd3V2?=
 =?utf-8?Q?lTP0HoQeSAabaR8Q=3D?=
X-Exchange-RoutingPolicyChecked: I9fyRnBuoUyz0boOavRhDJOmPaxtl+S0ZVR7rxvkh1UTMfYSBuruQOqUblxVKCllpCKLYHguk13K+wzqunhtP3eXc+/121QSWDbaSCFkBz7+oRR/HWfghZSfLREohkB1OGAS7UhOuhZumhdHupklDoZcFzBEYiTV+v12CNvM3YoTJ9yt2d5+3PpQos7yuhL/2NerpdKFeQA9INOkJmjUquEY30wzdSbKjKimZf7UmfIQa5fFdClfreN+pGhP09J5enQsT9LCSpbF3duMl9LFMiK34qTFaX2vI70zsSbgqu7phQp0GNd9z/IN/yJrqRCtX/OUcTwfdNTAos39XYy+vA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fbfd4ae-94ae-44c2-45bf-08df4a6af526
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 20:38:55.2464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPV3Qiun73glsiqfNTdeFfxyiHefIWkCyOG+VisY5aJsTs3TjZZdVDXVSPdoRqO1OEGmD3umakafifetgvIRnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4888
X-OriginatorOrg: intel.com

On 05/11/2026 13:45, James Clark wrote:
> Intel PT has its own wrap search but the same pointer fixup logic as the
> generic auxtrace_record__default_find_snapshot(). Replace the duplicate
> code with auxtrace_record__snapshot_fixup().
> 
> No functional changes intended.
> 
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

