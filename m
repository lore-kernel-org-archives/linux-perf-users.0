Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BA82EEE79;
	Mon, 24 Aug 2026 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787565210; cv=fail; b=mnXaXhvEjxGgwz5ZNyrWe4iqnigRXIouYr8pq0MBExnec+AAhvgngaijsFrBzxqW5pRmCKL4UvSlei/ZCrHxveBf+Mv7RpGUzyBOWgDlZWlBrS2drWmlT1D2DoskpJCRshlslTj3sNZpe2PUa7fae0AshRVlDJ9CM8C/0vSSlwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787565210; c=relaxed/simple;
	bh=96UEPupwbgUO9Sab7bRQnQM5cB2QJ2kBVuwJXjsXGw0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ORQUFXLvhR/9+4JJTTKIlYQ0vgBbP0YDDz5O3zxe5OSA3D8nDPGQghM7fdYXeFeBSnh9T/ihCxQPy+l2Zv9CdC+EKd880CqfUc/kBkYi8FUDeshrmZOrGrG4zlgdSQCPsGTdYeGE3+WuhC54TTsJ5TiiDFKkwgkKKl/FcuEy0sI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJIupLB4; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJIupLB4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787565209; x=1819101209;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=96UEPupwbgUO9Sab7bRQnQM5cB2QJ2kBVuwJXjsXGw0=;
  b=FJIupLB4zj/O8JidZSfT7N3gDDvZsKYtSC6u0law5sY6LfpjIG+9N+Gp
   MlUG7eNmDajZP54SMfFfijG2cEkw0NYpleKspErle4tz0N4Ildtj9hsYm
   Pe72FH+jdiATSNMJuIJb1KDgxHsS2XoISkHuV+NXrkneOVrOqfrv6IDE2
   iBmdJoAFfSbDAn0aV4BG9hKAXLzZqsaS555uMvybPKM1ZZhyXXBvmuZcZ
   fyYlvqaALzm0zIAx+Zva/UCyk3qocVugMfnOElTFxMB8AKs6amHvwDKNE
   YBCsIIFFGy+3Onidefp1muukUGwWahizNYrQQhghvJ06m8yKxovqoTjii
   A==;
X-CSE-ConnectionGUID: ma+99e8sQj2XLVb89gwmdA==
X-CSE-MsgGUID: 8IT18KtFTq2omje9jR5gVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="90530488"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="90530488"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 02:53:28 -0700
X-CSE-ConnectionGUID: uueokSdWTJe7E5g8bh1ibQ==
X-CSE-MsgGUID: 9J6X2NWkRbCja2qZcUV2Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="265654598"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 02:53:27 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 02:53:26 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 02:53:26 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.34) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 02:53:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=faP1q+ylLQGR9AW1/fMVGIFVP1aSPAmia7mZ69ACy/Y9lv2eMz7nNusVqXiNQYvA1skOyuEBv3UybRwgj4WuqvvSu5aWLvNFZAmuz2dUe4FImO7XGc1Uw17S9JC/+uVI76bWPMR8Xasw0XIh75P6iPyZ5a0guCZGVan5vBedSY5skdwT+NxyKS7Z9xBuiI8/AMj3GJwrSDLbECn+nkd6THlWzgmcTqL/gpqZ4RvBnESXdQ3dWJpNRtjSI/hw3zbo7BN+JhaTkULv5wyfZlhhSYM/pp6ugY1EqXXMta6VYODp6kZwnG3eM3OYhLtUw75YXy8R6jYmi1sXm+yYGVs6FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zw+SGBh4p80Ih+lCPwDXib1HV0at2Q7LbWRY0Tlz2v4=;
 b=grzRnMa04kzLWyENvU4YPfLQ21gPuMcQItDaR1+/SbTU0v7IU7M4L8ddSOTtd6gTJ6uNwhp2Ev6kLnylbkraRZXePJLKgB/qtmaSySU6w40CPlzVs6518qGQ4fVltoqVshphTqYmci2NH2NTsvv2YSg53BS1uzjWaRfn/jlN8Ca5CzR/nUbdWWSFwQOPAM91T7pBPS7ztTHIHrNIklrZHBVVKJbbS9l1Sig1YGUiHL7df9X7jtpXgXAb1bUgn3zyO3JrDx9MytF3l7nH4lGulw2ne5TkNYnULHbsT1C7hYapMx46mkYFjMgw7BLY+cVDjv1qbEDvFc+LgLwjcW8dug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by LVUPR11MB9859.namprd11.prod.outlook.com (2603:10b6:408:38b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 09:53:23 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 09:53:23 +0000
Message-ID: <1986a53d-9167-4f7a-8b1b-2c09f962a9e2@intel.com>
Date: Mon, 24 Aug 2026 12:53:16 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] perf: cs-etm: Respect --no-itrace option
To: James Clark <james.clark@linaro.org>, John Garry
	<john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, Mike Leach
	<mike.leach@arm.com>, Leo Yan <leo.yan@linux.dev>, Suzuki K Poulose
	<suzuki.poulose@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@arm.com>, Suyash Mahar
	<smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
CC: Arnaldo Carvalho de Melo <acme@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260821-james-cs-hw_id-output-failure-v1-0-9d532ddabcc3@linaro.org>
 <20260821-james-cs-hw_id-output-failure-v1-4-9d532ddabcc3@linaro.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260821-james-cs-hw_id-output-failure-v1-4-9d532ddabcc3@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0032.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::19) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|LVUPR11MB9859:EE_
X-MS-Office365-Filtering-Correlation-Id: e52fd74f-56e0-48ad-2f53-08df01c58932
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|10067099003|56012099006|6133799003|3023799007|18002099003|22082099003|11063799006|4143699003|921020;
X-Microsoft-Antispam-Message-Info: JDXAQyTyEZsIa3QJkuWZ7yVjI23ro/ikfKUzjxtpz1t00nZcXodtXvHYsJ54hFrUotjihX3JyT8piE/elpZ7SeLBRBZ4sWHTGoEmzdJFea+RRF8wr+AQuuj3aGLrNiOg/uofm6B2Min1bH6WotdCMKKUq9+QWUUp3yPOKrKvth7cirmOasL3ULNc1j5urbViG2oquinqA8wlZLDdNH0SVsTlv9CNIQddkldUqZCNvfB4Jzk7h0l8OF/rfz0BW1u+QmWHT1r6Oog2b2jsdc7bzEGz4uU65j7fceALycQc6vQW2E2G/SSh7lyaPL1XChIhVJCuhaIpU7ApAH3ZN8Q3n+ujh61QKlUvGnzoy9MDekjjxr8nrLgmDWDLnys9ZNMly460IYNhOMf/V2gqkCT6tq55tJCCdAGgi9XcEgl653BYjnr/dkSM4ihkoBr+6tMDVZYomeWLoDhKzumN3Iwlez2J2m85ESto7A14sCPXBSgVxc+BrYgHo6070ejjRI6M81R3GOINFELr7Xgh6sRkbvf4suowx4QahedHPiKefjLHqrdnsmiZoIbUzxMzbAzOP12AMsBTZB1MBDj1jiwCbvPCQUMUKOF54la09UQNI75yTPX5GU/T4qwK1D74EcdWnzTJhXbqRw53T1iTUsnCXKVPoN+ZelmUl+FyQOd/t2OcHrs19R9Cb4zq6pwaDm9+/xbs4k/CmFvccoFcjLNHFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10067099003)(56012099006)(6133799003)(3023799007)(18002099003)(22082099003)(11063799006)(4143699003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGlXRDNmVlVvdktiUzYycFFzdTRnMG5ZTnI3Q05tVnJMRUk0TW92UDgrb2VM?=
 =?utf-8?B?RWpMbEo2TmFZdWNVbFBiZ29jbDFTcVBlTTNNVm1lZjVFcVFGSFJzclJLK1lL?=
 =?utf-8?B?WmxSS2pSNGJ3RHhtT1VCQWVtdEJHOEVWRnpVSjRnSUwvaGRuNnJaODBWbHFD?=
 =?utf-8?B?UFN2b0l3ZGU2bTdLV2pjV042ejdBZGVyUEtkZDQ3bjdnVmszaGwyU0R1T3JB?=
 =?utf-8?B?cUxDczNXeW4rMGJsa2ZQS2VoM2RoeWF5clp3S2ljK3VSekZUdlBqTzBGZ1ZL?=
 =?utf-8?B?OXkwdzl1T0Q1cXplMWs2aEpHR3JkSlB2SnZyeW1XeEh5UGpvTU81RmgyejBR?=
 =?utf-8?B?Nm1ZOUlCT2NBMTVBMkVjVVdFSk9pV1hiQklMZi9lVU84a2RDZXNjOUNyRktr?=
 =?utf-8?B?bVlzTHN3U2hvZjl0NDdPcFNuYlE1L3FVVFpVWmU1YXRGencrYm9zYXFGSlNm?=
 =?utf-8?B?bEhLRHNZdy9kNmVqcnF5NlRaNE5PV2tjaDhXcHo2NjFjVWNRUnZHY2hHMDVq?=
 =?utf-8?B?alFaYzdsUThqVWRhU1YzMUtPMm1QZkQ2bncxMDZENm5mcUMrZkVTeTdEZFJB?=
 =?utf-8?B?eDAvcHdkTHVNc05EWXhQUTRxbE1HMHM2TkpoNExsSC83clhrUWIxOENrWHY2?=
 =?utf-8?B?UjN5Mi9YNGxPOFB0ZWpYWVpWRFlqckpWWG9xSWZoeW5GOXp1WkQrT0NiaHhr?=
 =?utf-8?B?M1VFRVZJckl1QjI3NHZxd2o4T2JMU3lWVUQ0NzBOVCtld1JPN1luTzQwV1Bj?=
 =?utf-8?B?R3JCSXBXS1pxWG80ZTZ4Yi8vaStpYUxTVUZTRGlYL2x6cUJLNmtYSm5uQm1t?=
 =?utf-8?B?NGtIZjNJWDFXd3RCVXNLVktZeUdRY1AzaitBUE1ZdDBLZW9GYVgyaWJkYzNF?=
 =?utf-8?B?K01JVi9aRE5yQVhXM09LMmMwajVWMEI5NTUyclpEUmRMRGdINmZxWFhJOEZl?=
 =?utf-8?B?NmNMeDByMmVlbDRoREtDVVdCS2lPcFBzem1lL3AraFVHaXQyWEVuYWhtRjVJ?=
 =?utf-8?B?RytTcjV6QUhXM0svY1V6aFVjZzM3TFprYkM1SDR1ZlBBakN2V1FlVXJKeUVJ?=
 =?utf-8?B?eXcwYWFVUldRN3czdG5wM2dXNVExL0xXZVB6V1ZyWHhTWEJwU2JDL1J3aURz?=
 =?utf-8?B?MXl2aHErS0NRMVdKaG9zcnJZSXFPOHNac1VZQnVWWXB1dStXRkhLK0xRNzZp?=
 =?utf-8?B?dG1wRkZVUG10L1dKUzlLZFVzZnhCT2lud2Nxdk02cEhQZ1dlUHB2VjRKNzNG?=
 =?utf-8?B?UEp2Y1liL3luend5NC9SUlBhYVZQb2Z6NHBKL3k4N0wrL3RFUjNrQm82OGNB?=
 =?utf-8?B?SG5FekJZZmt3eFBnNTA4VHVvNG0yTWVDM3NEV2E4SGNkZDg0aUI1VVcyMTBY?=
 =?utf-8?B?VEFnZ1YxUW1GU3hBN210NmIzU01URGJlc2x5OTFlWXJaUURDSVRiTlU1dm4z?=
 =?utf-8?B?bldseFNVU1l0YkhrQW04RFJVRDdpWldEWjBuMklLaUd1TjBmelNDSjdwNjBp?=
 =?utf-8?B?dmVxS2w2VDRNT1FCTXV1V2Z5am9wZUdoZlEvSXFuWDR5UEFkc1dHTDR1RVhU?=
 =?utf-8?B?ZUhYVVAyWnlkOCtVZ1pyaWtDV1lFTVdnZUJZbW04ZGJaOVdwQVpxSXhJOExV?=
 =?utf-8?B?VGNyYVdoNzRFNjFnV1U1WHJlM2UzZGNveFQ0ZDFPcnE5c2lDbUg5bE5jai8x?=
 =?utf-8?B?L0R0Y2cwZU5lSjhaOFZRdXRweWF4Ry9MNlBTQTluQXVvWURmYXBaamN3dUdO?=
 =?utf-8?B?VUJTRlhTdW96QXBGQityNFB4VmNIRG5OZWRQRHhrYkVTazgvUkpUWUxWdVR2?=
 =?utf-8?B?SU4vWEFnSVhDNkcwZjd6ak5TeWtvK2NvQXQxeWtiMTl5UG5TUlhMZUJNLzFQ?=
 =?utf-8?B?QmVNK25VaWI1TXB5bVgvN1J2RVVnbFhiWFBnSGFPdXY4eFBsQ3A5QVg1V2E1?=
 =?utf-8?B?U2NzbVdIOW1DNktMWi9qRGNzemdjdFVielFQdyt0N3hweHMxTUZONWduUUNN?=
 =?utf-8?B?Nkh0c2d0SkR2Qjd4MHg3VG5Lb3AvVUxzOHhuWDU1czcyajEwKy9veS9BUlFy?=
 =?utf-8?B?VkxiclJtcFZJalVqWWxUMjU3MHM5TDhzTVdhWEFTQTYyamQ2YUhYYXl1Wnhh?=
 =?utf-8?B?QUtpMi8vZVM2MkVpQUFzQ2tNOWhkN0JPZWRVMXVOZ1MzRDZPWDdCazdobnkw?=
 =?utf-8?B?R083a0c3ekthSVVVemxhR0tBQ1dPejQ3UEorZGFDYTFlYVk2SXF3MXJQUU9H?=
 =?utf-8?B?WXRoTGwvcUp2T1hoZDh4SnR3QXVRZmg3SG1DR0k5YkJndjFDSEJWN0RlcGxU?=
 =?utf-8?B?aEV0Rncwd1ErYTdaOWEyRlVEOUQyVGprSFhaMUFBeFRYZzJNbnhKK2YyKzhX?=
 =?utf-8?Q?+te4Vzk61ZMp5tz4=3D?=
X-Exchange-RoutingPolicyChecked: So7dIOoxhVfirmh05W3EV5AbK1326PNLRJ575TbTd9hqqY6GpKJsAglbm1/egjOmRLa2Duns4CfYCqGjLIKkH+uMB6WhKFudXPbuKwwABvW17ZHEkU6WdwHdBKSnbabAtfCEO4eoqTUgi2Vdq92+9J4riQ3YXOStIgnO7OMPAkVFvlhCwB94KoGy5G6GvSbhZbAs1K09OTLcz7HS2PTCmHJNt0gHDWxVOQ1cHWOq7MBiCMeTs1zwDM0MP+Rhr/rGSt9T7Fdr7lsS7syDWyHz6lPzfF0wW6R+A0ic/VkBkJLyUzYTDHW9psgWJ/MVqC6NJ0GJisLR4T5qoyvoGNkNHA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e52fd74f-56e0-48ad-2f53-08df01c58932
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 09:53:23.4274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8R+J4LkEeGu0xSl9KzdV4CzlbZGhJaDLeLmwfXzcrdWGv5/vTEKG02bxlCWmWD0nXPc5yB6VUKb7ubLkaH42w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9859
X-OriginatorOrg: intel.com

On 21/08/2026 12:50, James Clark wrote:
> If there is a bug in decoding then Perf will exit early and you can't
> investigate by using the raw dump mode. Make the --no-itrace option stop
> Coresight decoding after printing the aux header so decode errors don't
> stop the rest of the samples being printed.
> 
> pmu_type and evsel_is_auxtrace need to be set so that the
> unleader_auxtrace() behavior is the same as without --no-itrace.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

For auxtrace:

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/util/auxtrace.c |  2 +-
>  tools/perf/util/auxtrace.h |  1 +
>  tools/perf/util/cs-etm.c   | 66 +++++++++++++++++++++++++---------------------
>  3 files changed, 38 insertions(+), 31 deletions(-)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index e3c770b46e94..caa53056d349 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -123,7 +123,7 @@ static int evlist__regroup(struct evlist *evlist, struct evsel *leader, struct e
>  	return 0;
>  }
>  
> -static bool auxtrace__dont_decode(struct perf_session *session)
> +bool auxtrace__dont_decode(struct perf_session *session)
>  {
>  	return !session->itrace_synth_opts ||
>  	       session->itrace_synth_opts->dont_decode;
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index 971b817d3396..47fb97136836 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -651,6 +651,7 @@ void auxtrace__free(struct perf_session *session);
>  bool auxtrace__evsel_is_auxtrace(struct perf_session *session,
>  				 struct evsel *evsel);
>  u64 auxtrace_synth_id_range_start(struct evsel *evsel);
> +bool auxtrace__dont_decode(struct perf_session *session);
>  
>  #define ITRACE_HELP \
>  "				i[period]:    		synthesize instructions events\n" \
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index dd15e91b7b38..22884c9fdff8 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -969,7 +969,7 @@ static int cs_etm__flush_events(struct perf_session *session,
>  	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
>  						   struct cs_etm_auxtrace,
>  						   auxtrace);
> -	if (dump_trace)
> +	if (dump_trace || auxtrace__dont_decode(session))
>  		return 0;
>  
>  	if (!tool->ordered_events)
> @@ -3040,7 +3040,7 @@ static int cs_etm__process_event(struct perf_session *session,
>  						   struct cs_etm_auxtrace,
>  						   auxtrace);
>  
> -	if (dump_trace)
> +	if (dump_trace || auxtrace__dont_decode(session))
>  		return 0;
>  
>  	if (!tool->ordered_events) {
> @@ -3603,27 +3603,49 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>  	int err = 0;
>  	int aux_hw_id_found;
>  	int i;
> -	u64 *ptr = NULL;
> +	u64 *ptr = (u64 *) auxtrace_info->priv;
>  	u64 **metadata = NULL;
>  
> -	/* First the global part */
> -	ptr = (u64 *) auxtrace_info->priv;
> -	num_cpu = ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
> +	etm = zalloc(sizeof(*etm));
> +	if (!etm)
> +		return -ENOMEM;
> +
> +	session->auxtrace = &etm->auxtrace;
> +	etm->auxtrace.free = cs_etm__free;
> +	etm->auxtrace.evsel_is_auxtrace = cs_etm__evsel_is_auxtrace;
> +	etm->auxtrace.process_event = cs_etm__process_event;
> +	etm->auxtrace.process_auxtrace_event = cs_etm__process_auxtrace_event;
> +	etm->auxtrace.flush_events = cs_etm__flush_events;
> +	etm->auxtrace.free_events = cs_etm__free_events;
> +	etm->pmu_type = (unsigned int) ((ptr[CS_PMU_TYPE_CPUS] >> 32) & 0xffffffff);
> +
> +	/*
> +	 * Don't go further than the minimum required to identify this event as
> +	 * auxtrace with cs_etm__evsel_is_auxtrace() so unleader_auxtrace()
> +	 * works.
> +	 */
> +	if (auxtrace__dont_decode(session))
> +		return 0;
>  
>  	/*
>  	 * Bound num_cpu by the event size: the global header consumes
>  	 * CS_ETM_HEADER_SIZE bytes, and each CPU needs at least one u64
>  	 * metadata entry after that.
>  	 */
> +	num_cpu = ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
>  	priv_size = total_size - event_header_size - INFO_HEADER_SIZE -
>  		    CS_ETM_HEADER_SIZE;
>  	if (num_cpu <= 0 || priv_size <= 0 ||
> -	    num_cpu > priv_size / (int)sizeof(u64))
> -		return -EINVAL;
> +	    num_cpu > priv_size / (int)sizeof(u64)) {
> +		err = -EINVAL;
> +		goto err_free_etm;
> +	}
>  
>  	metadata = zalloc(sizeof(*metadata) * num_cpu);
> -	if (!metadata)
> -		return -ENOMEM;
> +	if (!metadata) {
> +		err = -ENOMEM;
> +		goto err_free_etm;
> +	}
>  
>  	/* Start parsing after the common part of the header */
>  	i = CS_HEADER_VERSION_MAX;
> @@ -3682,13 +3704,6 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>  		goto err_free_metadata;
>  	}
>  
> -	etm = zalloc(sizeof(*etm));
> -
> -	if (!etm) {
> -		err = -ENOMEM;
> -		goto err_free_metadata;
> -	}
> -
>  	/*
>  	 * As all the ETMs run at the same exception level, the system should
>  	 * have the same PID format crossing CPUs.  So cache the PID format
> @@ -3698,7 +3713,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>  
>  	err = auxtrace_queues__init_nr(&etm->queues, max_cpu + 1);
>  	if (err)
> -		goto err_free_etm;
> +		goto err_free_metadata;
>  
>  	for (unsigned int j = 0; j < etm->queues.nr_queues; ++j) {
>  		err = cs_etm__setup_queue(etm, &etm->queues.queue_array[j], j);
> @@ -3736,7 +3751,6 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>  	etm->session = session;
>  
>  	etm->num_cpu = num_cpu;
> -	etm->pmu_type = (unsigned int) ((ptr[CS_PMU_TYPE_CPUS] >> 32) & 0xffffffff);
>  	etm->snapshot_mode = (ptr[CS_ETM_SNAPSHOT] != 0);
>  	etm->metadata = metadata;
>  	etm->auxtrace_type = auxtrace_info->type;
> @@ -3763,14 +3777,6 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>  			    "you can specify the itrace option 'T' for timestamp decoding\n"
>  			    "if the Coresight timestamp on the platform is same with the kernel time.\n\n");
>  
> -	etm->auxtrace.process_event = cs_etm__process_event;
> -	etm->auxtrace.process_auxtrace_event = cs_etm__process_auxtrace_event;
> -	etm->auxtrace.flush_events = cs_etm__flush_events;
> -	etm->auxtrace.free_events = cs_etm__free_events;
> -	etm->auxtrace.free = cs_etm__free;
> -	etm->auxtrace.evsel_is_auxtrace = cs_etm__evsel_is_auxtrace;
> -	session->auxtrace = &etm->auxtrace;
> -
>  	cs_etm__setup_timeless_decoding(etm);
>  
>  	etm->tc.time_shift = tc->time_shift;
> @@ -3853,13 +3859,13 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
>  
>  err_free_queues:
>  	cs_etm__free_queues(etm);
> -	session->auxtrace = NULL;
> -err_free_etm:
> -	zfree(&etm);
>  err_free_metadata:
>  	/* No need to check @metadata[j], free(NULL) is supported */
>  	for (int j = 0; j < num_cpu; j++)
>  		zfree(&metadata[j]);
>  	zfree(&metadata);
> +err_free_etm:
> +	session->auxtrace = NULL;
> +	zfree(&etm);
>  	return err;
>  }
> 

