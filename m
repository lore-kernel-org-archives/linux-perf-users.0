Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C00732D0C8;
	Thu, 16 Oct 2025 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630713; cv=fail; b=M1wfVWJlIrMPZdupx6kYvANXxPFmzcFU+EjOHnGfwvsn5wBDGRnIZT7eioT1cm07MFdvlxM+6lFrveypC0gcjxt/siP0t9cu1H2OVrKf2oGuEJqjvnTTsZ64G8DHB1p7shF/Vcw46dNZdV6Fg8dXqKNAFquo61NzjMHzaIM02S4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630713; c=relaxed/simple;
	bh=p6sHlWEzI2/R95r8Uq+HTTzbjH0352yw8SJ9GxHCSb0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gqdeFtgkeW/iMLoKGIwv9HKnQi3uAVEm7meFfzl4IkMqftJnH+dMGPoX2+THf6HZmYng5BvVaNXKQe8AJzZ+1UTAHFfKL2av5TS19+Yx1eXt0Lhnq2KI4kgrVn8qu3bgXoww2mvvolvOKkrMnmNt2CmnltacF3K+KdDI0azY518=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UYuK90De; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UYuK90De"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760630712; x=1792166712;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p6sHlWEzI2/R95r8Uq+HTTzbjH0352yw8SJ9GxHCSb0=;
  b=UYuK90Dei8VuQ7VavJTEAwijX99hJk7UgI9zMg0K1xn4/dtrmmrKnKrr
   XoXOV2lKN9v3flpEn6/Wn1wcSJmqC9FgaEujAEiyASTWKFyniHu5WWeCm
   8DsHDLV+zcsVSH4qpuRI2f7h4bCLbBlqkQwJqsCrFuIs01+R1NPgZFTI8
   8bVXG5fysMXhYu7THHyDZPiwAJzBzQa7pvpEX5Mtj8UQLclJGY4xktAXy
   79cPUDT6jQmzbA8naXbXgv+lHzYzjdQa6heFoX7BgpftFDn2GUOBBvJuK
   b0PuF6rkIOSnzGE3soZP3vhXZD2H7LnFfQgN5la0aOsL3fLCejTHV9pgY
   Q==;
X-CSE-ConnectionGUID: 2QMKmcbNTDy6xFPmjOyLsw==
X-CSE-MsgGUID: wbmZSy3YRQOMRoA6xmM9ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="66694966"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="66694966"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 09:04:57 -0700
X-CSE-ConnectionGUID: 7DDcod4pTumRgZ4PrtVLNg==
X-CSE-MsgGUID: HDAAl8eeQ1WAZ6dQvr3X9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="182466770"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 09:04:57 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 09:04:56 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 09:04:56 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.41)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 09:04:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qwwGzfCZXjRqDTOC7aIS2rdUKB3SrYsf0vjNJYGngXPeE6UBaHVMuFZ4BTGU5Z4VTDSU+AptmP+4udP6qbtkKA/jG85pP4GOY9axvg077skP8fnkb7bzbqtQz04CZMkMoQ6/vl3/ctpC4pJtIS2/0ai4oEY32b8L0M6YTVvnbbSz44nid+pBuhXQX1G4IW9X9DIcZKbGmPcygkG6F/lo+l9q+eQujmXQmtoBl4E10H7Cts6iuI0YANRwbJNsTRouqUEm9MvGP6p5/twDy/3gd0saoCCeHZNTaDYxIAONJHc2QsfHr+/LV9fGWMQu+DG94C/YVFzYGBfJlZ9qI36Czg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICCIPnOXD/Yts67b8t7JsQvhueI8wCllxGh1sMOiZlc=;
 b=eNf98g0rXc57MTGZ7oCUgJiku9SuBOJ4KlYzknouLDG3BZU2PVSeNBKz1VR+plG2tiK+J3uWs53CR2ULgozsULiD6bjY553duWhY5EoBScast8DVSWaoWo899umP32b2lBN2dhii3ThJSVRyhHV2zrTUrOh8LZJClexdocK10YLsG9hfRPR/dGgfaDb5tAUuy0AjXz/Y0wpGGSffsXVBj6hajg08v3ySps3OsSsuso3A2auh5Lj4fDGy24ZpcqlUS2Wsjgy5aYrzHMtBZRrqrRMNmovfl3R+SSjDViyEgkfUtntydfVuJbs2USoqSKwnPQpGnGTJgxFIYlGMGdgaKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB8289.namprd11.prod.outlook.com (2603:10b6:303:1e8::9)
 by CH3PR11MB7348.namprd11.prod.outlook.com (2603:10b6:610:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 16:04:53 +0000
Received: from MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022]) by MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022%6]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 16:04:53 +0000
Message-ID: <9dd7ecce-dd4f-47a1-a7ad-bb48da8c21f2@intel.com>
Date: Fri, 17 Oct 2025 00:04:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf tools annotate: fix a crash when annotate the
 same symbol with 's' and 'T'
To: James Clark <james.clark@linaro.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Kan
 Liang" <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
	<wangyang.guo@intel.com>, <pan.deng@intel.com>, <zhiguo.zhou@intel.com>,
	<jiebin.sun@intel.com>, <thomas.falcon@intel.com>, <dapeng1.mi@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Namhyung
 Kim" <namhyung@kernel.org>
References: <baea1e93-5e30-404e-8a5d-8b1d20cf8761@linaro.org>
 <20251015172017.2115213-1-tianyou.li@intel.com>
 <4151e2e4-b7df-4c04-b038-71ff2612ee8d@linaro.org>
 <db33a977-c712-48b7-9be1-83721b23635f@intel.com>
 <046f1441-bc18-44e0-9bd0-f98a62ebbf9b@linaro.org>
 <9f843a5b-4fa1-4abf-9c4b-1e5433ab9704@intel.com>
 <9f33a736-ad3f-426c-93db-b5acca34e5f1@linaro.org>
Content-Language: en-US
From: "Li, Tianyou" <tianyou.li@intel.com>
In-Reply-To: <9f33a736-ad3f-426c-93db-b5acca34e5f1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:820:d::13) To MW4PR11MB8289.namprd11.prod.outlook.com
 (2603:10b6:303:1e8::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB8289:EE_|CH3PR11MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df455f7-1335-4c01-9317-08de0ccdbe2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bEhUb2t6M2JSY3NTckRrektiSlVSbTF0aklIUzFEY0Z6Z2tNWUozTWtEclhw?=
 =?utf-8?B?ZHFXcjAveU5OUEFjTk5EWjI2OEF5Z1N0TEREL1o0YVo4bytHRWRWWTZMOUhp?=
 =?utf-8?B?QzB6UVp0VU1TWWxiY29vSUR6alJSRHdrR2FrbGJseEUvNTFKSEFXUzJkaFo3?=
 =?utf-8?B?eWFVZ0puQU44YllVYnYzR1YyTjUrWStvaUlQSGllVTB3cmRRd3VPd1Q5VXF4?=
 =?utf-8?B?VGh1WWdoMktlNnF4MnhybXdpS3V3M2NSY0ZqNWUyTm1tTWRGTExxZHFnWHVM?=
 =?utf-8?B?Q1llYmcwbmFvQ0EwVkJYWm9IQlpMYndScDRkd2lLRVNXc0NTUkxkREZNNDBN?=
 =?utf-8?B?eHltQjFYUzk4bXNINEdYcCtlUDBjK3ZRZEkrWHAzSm5oOHFvN1p4alVkZndZ?=
 =?utf-8?B?L0RsOW1JL2kzTzBKT09tblJzRm9jUzBFSHB5Vk15L29ZWWROTjg4VGJNYXZI?=
 =?utf-8?B?M3FUc2hmRis4Z1N4U292bGg4OW5rb0U3VXcwTWRCU0E0Vmc2bkVWRkRDVmJp?=
 =?utf-8?B?SnRKZ2dxY2lEWTE4cFl0Y1Y1RTNwcGdzejRWRXo5UGVoSklwaEI0bitjQzBr?=
 =?utf-8?B?N0xtTTFQSHY5TjJjRVV5NS9tTmQ5RHl4c3d2MGszWTlGYUY3S051WFlYbURO?=
 =?utf-8?B?ajNwSUxyOVJWVzhoTVdtN1BxMmVKczFyZmYxbE1ReEttWFBRWmkrYW5QLzFt?=
 =?utf-8?B?Q0dOYkFIVG1NalcyOVFjMEpFUXJsdkJMMTF5elNYWVhpeDVBai9wenM2Qlh0?=
 =?utf-8?B?ZUdDOENIQ1U2d3NGTFg5TlB1aHlrWVpmWEpNbGJUYU16TjJETHRlUm8wUzIy?=
 =?utf-8?B?ZmU0M0xSa3Y2ZnpUMGNYcmxlU0tPZVQrdXVONkVZRW9la3FnaGxIU2hyUy9o?=
 =?utf-8?B?VUZyOFFmcGtoOEZTSHVNcTlxV1BPaSthamZNUVBEZW9YdEduTkQvRGdod092?=
 =?utf-8?B?WVl1ZWZhUyt1ZjBmWGtldWJJYnJJMHZkOWsvTjlwVDZjSllSbTV6ek9ZSXJS?=
 =?utf-8?B?VTkwRi92ZDNWR1AzQXJzMmdSbW1Nd3c2MElWWGNFTEJoVVljRUNVWWE1Mm1C?=
 =?utf-8?B?dXFWTUMvUjZUNTNndHhXR3BuUHR4cVlRSUhwU3UzckpjenhpT0Z2Q0Vud2xJ?=
 =?utf-8?B?UkVzZkpFelJkMmdFV0gxL2t0VURKN0lOc2k1ZEV0aDNRWWdSSmRveGlzR1d1?=
 =?utf-8?B?dmFjeVhCa2NDalRDUjVHUFVKeWFHWDd1OTNCblk3R1NCRklTWEJseWhYdjNE?=
 =?utf-8?B?SFNNZlQzWHoyZWd3andSMklzL0x2cWU1OUV2VWY5b2xXSXFzNDZkTm1oeTZq?=
 =?utf-8?B?UUs3THdVQ1hDRXVOWFZjYnVXeG44cXV2UGVtQ1VKTk41K1I0MkUyRks4Z0Y1?=
 =?utf-8?B?RjBhQ2dJVDI2L1RIaUFFODZjODB2cU1IT09zcGFvRGg3WnVGdlNpdFJEV2RS?=
 =?utf-8?B?NHdKUzdsdWVkQi9ySG5IRzkrU2ZpUlVFNjhLQ1JsL1JRK24vTTArQ2YyaVhV?=
 =?utf-8?B?SXhFdUEwZlVUK21odnFXNnJvNk5aY1Jwbk5mUEt4cXpaUEFGdzl5aFl1NGpQ?=
 =?utf-8?B?S2kzVFYrUVdtcllnRW0wakRFblBVQWEzNC8zQWxkd2o5K2dEYlZUWmpjdURZ?=
 =?utf-8?B?cDNMZkpNMWtTWlUzVFUrcFQyQjlaZ3o2eUw0UzJkWFo3N1c3NC94WXRsZjdX?=
 =?utf-8?B?UUl5WDhpVjV2N09wZHBZcUF1TXVFRytCNFltRmRsVFVlNkIzeDRiSTRpVDdm?=
 =?utf-8?B?UnNXQ2tTWEZWRW5lMnB5cncyejRuSmdGTENNTWp1K05uMXhsVktqQXRYQ2do?=
 =?utf-8?B?Qy9LNUgzNTMzVXByRzgvWmZ1YWJjME5PQjZxakFZZTlNZ2ZuMmdCNE5DYlp4?=
 =?utf-8?B?dGp0L2VDZTFFZU9ZMDUrTDZkUklmdVYvbDU3TGdwb0plMGRsdXljak85QjR0?=
 =?utf-8?Q?gG3LMMUdPibqMaZzynEzb28MEdb2fIPW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB8289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTQwRTM4YlhXeERpQkpFRHo3TjQ1WjR5d1UzMjFUaXZkaGl0YlFzYzhsZEIz?=
 =?utf-8?B?RjBCWjB5TnpSRUNMd3dWT0g3a2h3dW5tUUxsWGhHVmFha2NEMURleEF3U1pG?=
 =?utf-8?B?bTNScElmYzczMHpBdW9ob1hOcUZrMEtSTk5Jck4wblY3b08yL0dvdXRmRHVG?=
 =?utf-8?B?bm92cXc3T0d5NmJEdEZWcGc5S3pyT3krWkNiSXJ5VTN1anpjaEZQMlZnemJ3?=
 =?utf-8?B?ZEs5VkZrOUJDRzgwRHIvUGdzME9ZT0l3S0c4dXBVWkdWWmZnNSt4MFJudURj?=
 =?utf-8?B?WlVZQkZzNXF1L1ZjamNvMHBrY3lvSFByaDBHWlgvYys5dEVkUWpZSTB2azcw?=
 =?utf-8?B?MkRCZ3FMbnV4b2lSeFdkTnhvbkVUZ1lsVVExcC91M21jb2t4UG95VnQ0dy9Z?=
 =?utf-8?B?VGhNTlZzOHpYMlIvNXNSeUp2SEg3bVlkc0o4OWQ2RUlROTlZZFlTd0NPY1Mv?=
 =?utf-8?B?dWlsb2VpenhZQ3BjQ0ZlTUFmcjAwbEtGb2lZRTJEdHdlYWJkN3hxZG05Vlk5?=
 =?utf-8?B?UWhkZUQ2eWg0RVFUVUtTcFpKcXRoeXhlNGREQWk3dzNINGtxNThDRG5uUW5I?=
 =?utf-8?B?YzB0ZDUySFVxTllvWk1xZ29COVdza09tcUt1UFJpc2hvTmxWV00wQnJwQ1kv?=
 =?utf-8?B?RWlWaEkyTXZOR1hmSjVHN0pRU1FWZCtYOHdZR2ZLb1E0Ukg2R3loY045cExM?=
 =?utf-8?B?VWtaSDdCcVVFdkI2eWlLWm1RMnBQSm9UU1IwcmxINytTOEh0UjJEMTd6Vmlo?=
 =?utf-8?B?cUM0dzk3ejF6TVlTNzUwbFBnSGJ3RkltRldjNGthTGQzRDltWXNwQ1dpNGlS?=
 =?utf-8?B?OE53SkNYR0Z1K09EWFpWcVlvYnBWbEZUZm1hdE1KbmtnbW5vOFhuNHVCYlZC?=
 =?utf-8?B?aksvVkVEbzZWV1dsZEErQkhBc0pmcXZTV0J5cDJkek5GUkV6b3ZCeTYyOEpH?=
 =?utf-8?B?VG0yR05NZ2lML0NoWnc1b3hmWHlEK2hRdjJUdm9SZ1pNd2didGVBOU53eEhU?=
 =?utf-8?B?OG91cTJiQ2dsK2ZCWjAxSm42QjZLZ2ZML09uRU9oNmZzUFNEZEFDcEFLdVpy?=
 =?utf-8?B?YjlaejNBUklHYmIvZ2JXV3RwOWlsYlpxaC93ZVArMnF5b0RHUkFVV1ZPaC91?=
 =?utf-8?B?aUhXTWZ0MndrS1gxbkZsY2VWYU93WUpnaVB3dDlnNmhlZEFuYk1MbGxsK05y?=
 =?utf-8?B?cjNiemQwNmlxak50clZDZnBsc1JHQytiQ09YNkJoQ09CeVV6eDFaL1k2cG82?=
 =?utf-8?B?dElFQ0pqc29OWFA1eUNZcnEyN2RmZjFBZ3VsZS9aNHJmY1dmWisvNHRROTY0?=
 =?utf-8?B?dUFQREFRWDQ4UzdIL2lqN044RHlsTTIwK1BtK004ay96RnFwNldHMEI1S25j?=
 =?utf-8?B?aHExNXVpc3BHeWxTcDRxdy9PZXZrVzNKSjNjZTJJUnpwYlZFbVJFdjZzMHBz?=
 =?utf-8?B?Z0Z3OGh0RzZxWlpwTDYzYnYwZkVraU1TRFNTcHhwb0k5bzBzcFBNZTMxQUJI?=
 =?utf-8?B?dlluTCt6NERWVE8zZnBKVEpESnRrOGpsTysyelhaL2xuVTJybkRVRHFNcVJO?=
 =?utf-8?B?UGRCRUtXZXRsWUVzdmZnTys5V1p1dkRoTFZsVmtvbDl0ZXJrTjlGM0RhWWZw?=
 =?utf-8?B?OVJ0cjR6RWFXNEJ4WVMyUFg5UEZiaGdEUktVYU50am9uNTNBQlVXRWJxM1V6?=
 =?utf-8?B?ai9GSEg3MWgrVXVVanBqWDRLUU96LzJDaTVGNU1BR0Q3ZnBnb1RlaHdEMXJV?=
 =?utf-8?B?c2dEajBGREh4Rkp0bDhCbCtuZnZXazQzRTFFb1J4R2g4dE84UXVWa080Tk9S?=
 =?utf-8?B?VGFMUUw3ZXl5TGNQWWNFSGNjbm80bXZ3UFBHRHFQV2FkRW1JSSsxN2Z2SlVv?=
 =?utf-8?B?T1Y3RkdYRXJuWjNCZXcwbE8xcE5hNTZCRnRFd0hnbkJicUtRNVU5eG1YRWkw?=
 =?utf-8?B?VUhaQTBkU2tWWEhQWWFtclROUzNLcVNQRVNJNzFPTnZWN3Jnb3R4L0g3V2Jl?=
 =?utf-8?B?SU5lV1R6T0V6NklBU3VuQWlKZGVlSnBOZjhDb0RrVzgwcVhUTVlGL0VqV3ht?=
 =?utf-8?B?YXFuNG9vZWVhZlRTV0xKVThUVk5rQmJHbHpTL0EzRE9ocTd3N1pseEdCcTJX?=
 =?utf-8?Q?fZudmIuEDXrkiZQJ2qwZx1WWc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df455f7-1335-4c01-9317-08de0ccdbe2d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB8289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:04:53.5350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cH+CHx9YPMhax4reZQrMZI5MovcJNkXj4ZEpbhAVK8GNeBC7ESmc2ytB8z9qlnaL75j9eBvghCC8V94kiKe+SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7348
X-OriginatorOrg: intel.com


On 10/16/2025 11:18 PM, James Clark wrote:
>
>
> On 16/10/2025 4:04 pm, Li, Tianyou wrote:
>>
>> On 10/16/2025 9:06 PM, James Clark wrote:
>>>
>>>
>>> On 16/10/2025 4:36 am, Li, Tianyou wrote:
>>>> Hi James,
>>>>
>>>> Thanks for your time to review. Please see my comments inlined.
>>>>
>>>> Regards,
>>>>
>>>> Tianyou
>>>>
>>>> On 10/16/2025 1:30 AM, James Clark wrote:
>>>>>
>>>>>
>>>>> On 15/10/2025 6:20 pm, Tianyou Li wrote:
>>>>>> When perf report with annotation for a symbol, press 's' and 'T', 
>>>>>> then exit
>>>>>> the annotate browser. Once annotate the same symbol, the annotate 
>>>>>> browser
>>>>>> will crash.
>>>>>>
>>>>>> The browser.arch was required to be correctly updated when data type
>>>>>> feature was enabled by 'T'. Usually it was initialized by 
>>>>>> symbol__annotate2
>>>>>> function. If a symbol has already been correctly annotated at the 
>>>>>> first
>>>>>> time, it should not call the symbol__annotate2 function again, 
>>>>>> thus the
>>>>>> browser.arch will not get initialized. Then at the second time to 
>>>>>> show the
>>>>>> annotate browser, the data type needs to be displayed but the 
>>>>>> browser.arch
>>>>>> is empty.
>>>>>>
>>>>>> Stack trace as below:
>>>>>>
>>>>>> Perf: Segmentation fault
>>>>>> -------- backtrace --------
>>>>>>      #0 0x55d365 in ui__signal_backtrace setup.c:0
>>>>>>      #1 0x7f5ff1a3e930 in __restore_rt libc.so.6[3e930]
>>>>>>      #2 0x570f08 in arch__is perf[570f08]
>>>>>>      #3 0x562186 in annotate_get_insn_location perf[562186]
>>>>>>      #4 0x562626 in __hist_entry__get_data_type annotate.c:0
>>>>>>      #5 0x56476d in annotation_line__write perf[56476d]
>>>>>>      #6 0x54e2db in annotate_browser__write annotate.c:0
>>>>>>      #7 0x54d061 in ui_browser__list_head_refresh perf[54d061]
>>>>>>      #8 0x54dc9e in annotate_browser__refresh annotate.c:0
>>>>>>      #9 0x54c03d in __ui_browser__refresh browser.c:0
>>>>>>      #10 0x54ccf8 in ui_browser__run perf[54ccf8]
>>>>>>      #11 0x54eb92 in __hist_entry__tui_annotate perf[54eb92]
>>>>>>      #12 0x552293 in do_annotate hists.c:0
>>>>>>      #13 0x55941c in evsel__hists_browse hists.c:0
>>>>>>      #14 0x55b00f in evlist__tui_browse_hists perf[55b00f]
>>>>>>      #15 0x42ff02 in cmd_report perf[42ff02]
>>>>>>      #16 0x494008 in run_builtin perf.c:0
>>>>>>      #17 0x494305 in handle_internal_command perf.c:0
>>>>>>      #18 0x410547 in main perf[410547]
>>>>>>      #19 0x7f5ff1a295d0 in __libc_start_call_main libc.so.6[295d0]
>>>>>>      #20 0x7f5ff1a29680 in __libc_start_main@@GLIBC_2.34 
>>>>>> libc.so.6[29680]
>>>>>>      #21 0x410b75 in _start perf[410b75]
>>>>>>
>>>>>> Fixes: 1d4374afd000 ("perf annotate: Add 'T' hot key to toggle 
>>>>>> data type display")
>>>>>> Reviewed-by: James Clark <james.clark@linaro.org>
>>>>>> Signed-off-by: Tianyou Li <tianyou.li@intel.com>
>>>>>> ---
>>>>>>   tools/perf/ui/browsers/annotate.c | 3 +++
>>>>>>   tools/perf/util/annotate.c        | 2 +-
>>>>>>   tools/perf/util/annotate.h        | 2 ++
>>>>>>   3 files changed, 6 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/ 
>>>>>> browsers/annotate.c
>>>>>> index 8fe699f98542..3b27ef1e8490 100644
>>>>>> --- a/tools/perf/ui/browsers/annotate.c
>>>>>> +++ b/tools/perf/ui/browsers/annotate.c
>>>>>> @@ -1161,6 +1161,9 @@ int __hist_entry__tui_annotate(struct 
>>>>>> hist_entry *he, struct map_symbol *ms,
>>>>>>               if (!annotation__has_source(notes))
>>>>>>                   ui__warning("Annotation has no source code.");
>>>>>>           }
>>>>>> +    } else if (evsel__get_arch(evsel, &browser.arch)) {
>>>>>> +        ui__error("Couldn't get architecture for event '%s'", 
>>>>>> evsel- >name);
>>>>>> +        return -1;
>>>>>>       }
>>>>>
>>>>> symbol_annotate() only fails for negative return values of 
>>>>> evsel__get_arch(), but evsel__get_arch() has at least two positive 
>>>>> error return values.
>>>>>
>>>>> If symbol_annotate() is wrong and it should be != 0 like you have, 
>>>>> then maybe symbol_annotate() should be fixed in another commit in 
>>>>> the same patchset as this one. Otherwise you have two calls to the 
>>>>> same thing right next to each other that handle errors differently.
>>>>
>>>>
>>>> Thanks James. I will give a try on handling the error message with 
>>>> symbol__strerror_disassemble. I am conservative to change the code 
>>>> in symbol_annotate, agreed it should be considered in another 
>>>> patch. Would like to focus this particular issue and get it fixed 
>>>> properly. Thanks.
>>>>
>>>>
>>>
>>> Looks like there was a misunderstanding. I'm not saying that the 
>>> error is _reported_ differently, it's that the condition that 
>>> triggers the error is different.
>>>
>>> symbol__annotate():
>>>
>>>   err = evsel__get_arch(evsel, &arch);
>>>   if (err < 0)
>>>       return err;
>>>
>>> You added:
>>>
>>>   if (evsel__get_arch(evsel, &browser.arch))
>>>      ...
>>>
>>> evsel__get_arch() returns positive error values (and maybe also 
>>> negative?), so "< 0" behaves differently to "!= 0".
>>>
>>> You either have to assume that "< 0" is correct and not change it, 
>>> but then you have to also check the return value in the same way. Or 
>>> if by doing "!= 0" you're implying that symbol__annotate() is wrong 
>>> to do "< 0", then you should fix it now to not leave 
>>> __hist_entry__tui_annotate() doing the same thing two different ways 
>>> at different times.
>>>
>> Thanks James. I looked at the code of symbol__annotate, and noticed 
>> the if (err<0) statement. I did not mean to change the code in 
>> symbol__annotate because I did not understand why it handled the 
>> error code that way. The positive return value of evsel__get_arch 
>> indicates some error happens, eg in arm__annotate_init, so I use the 
>> symbol__strerror_disassemble function to handle both positive and 
>> negative error code.
>>
>> I do agree we should check the error code of evsel__get_arch, but I 
>> am hesitate to touch the code which I am not sure the consequences. I 
>> agree it may deserve another patch but not in this patchset if we 
>> have clear answers on why "<0" is not correct, or we have a case to 
>> break the current code as a evidence. Thanks.
>>
>>
>> Regards,
>>
>> Tianyou
>>
>
> It may take a little bit of effort to follow the code and look at the 
> git blame to see what happened, but it's really not going to be that 
> hard.

Truly appreciated for your instant response, and the suggestions about 
'Fixes' tag, return value handling etc. I do check the git history about 
the code "<0", I still did not quite understand the reason of handling 
it in that way.


>
> You're basically suggesting to add code that (when expanded) does this:
>
>   if (first_run) {
>      if (do_important_thing() < 0)
>         return err;
>   } else { // second run
>      if (do_important_thing() != 0)
>         return err;
>   }
>
> It's not going to help anyone who looks at it in the future. It's 
> going to make future refactors of evsel__get_arch() more difficult, 
> and without knowing why it's like that, it's possibly introducing 
> another bug.
>

I am suggesting to focus on the 'else' part. If that part of code is 
correct, then we might need to consider another patch for the "<0" code. 
I am eager for the answer as well.


> It surely has to be consistent otherwise it doesn't make sense. And if 
> you sent a patch that did "< 0" I would still say "but it can return 
> positive errors, so the new code isn't right".
> I did suggest in the beginning to not check the error at all and add a 
> comment saying it must succeed at that point because it's already done 
> once before, but that's not very defensive and it doesn't fix the 
> other possible bug.
>

Yes. I am not so sure 'must succeed' could be a right assumption, or for 
safety it's better to check the error code.


Regards,

Tianyou


>>>>>
>>>>>>         /* Copy necessary information when it's called from perf 
>>>>>> top */
>>>>>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>>>>>> index a2e34f149a07..39d6594850f1 100644
>>>>>> --- a/tools/perf/util/annotate.c
>>>>>> +++ b/tools/perf/util/annotate.c
>>>>>> @@ -980,7 +980,7 @@ void symbol__calc_percent(struct symbol *sym, 
>>>>>> struct evsel *evsel)
>>>>>>       annotation__calc_percent(notes, evsel, symbol__size(sym));
>>>>>>   }
>>>>>>   -static int evsel__get_arch(struct evsel *evsel, struct arch 
>>>>>> **parch)
>>>>>> +int evsel__get_arch(struct evsel *evsel, struct arch **parch)
>>>>>>   {
>>>>>>       struct perf_env *env = evsel__env(evsel);
>>>>>>       const char *arch_name = perf_env__arch(env);
>>>>>> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
>>>>>> index eaf6c8aa7f47..d4990bff29a7 100644
>>>>>> --- a/tools/perf/util/annotate.h
>>>>>> +++ b/tools/perf/util/annotate.h
>>>>>> @@ -585,4 +585,6 @@ void debuginfo_cache__delete(void);
>>>>>>   int annotation_br_cntr_entry(char **str, int br_cntr_nr, u64 
>>>>>> *br_cntr,
>>>>>>                    int num_aggr, struct evsel *evsel);
>>>>>>   int annotation_br_cntr_abbr_list(char **str, struct evsel 
>>>>>> *evsel, bool header);
>>>>>> +
>>>>>> +int evsel__get_arch(struct evsel *evsel, struct arch **parch);
>>>>>>   #endif    /* __PERF_ANNOTATE_H */
>>>>>
>>>>>
>>>
>>>
>
>
