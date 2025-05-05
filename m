Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A881F4174
	for <linux-perf-users@vger.kernel.org>; Mon,  5 May 2025 08:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746433739; cv=fail; b=s9SuuGj+u//JxiXE1PX4vGC7dgJfloeiTO4HOVMv5bCwg+DsujB1ysyRG/gKVS49dSHFzQ67mHeEgUNN8+JT+3NGIyJCEJYVww0UNNXgl1skpYwnAjWtRuNqmqHdQUXu/lHAD8gXJ0xj37Xk09yiP8PFKM3CUOS4SulMeOyIYjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746433739; c=relaxed/simple;
	bh=4Op2N69yJoDcSxyy7sEXzDL5FjQRjhhAymyIZI2OZI8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kGZ085qX51ZVc1YGvn6iReesHPsFBYbhI7AxxMN1aJkILmSYHbWfB1dbL7DiHKNJiYoCln55fR7WvSi0BsqK06pWbAcQd7CbEGBrK6+wvw67UazY9ZCldrtwckSFKZUVLyQI9We4jPv3C1Er0mpzls8wTfEDuszKMNXTO7b7r1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FGZWLXjc; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FGZWLXjc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746433737; x=1777969737;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4Op2N69yJoDcSxyy7sEXzDL5FjQRjhhAymyIZI2OZI8=;
  b=FGZWLXjcSfsg35gXGU1tRkzUu15mAnJt2vCnjsyGLllilobiZZIXKWx/
   U8z9EQ7GyFKmrCq3gsTdqBGj3YAaahv0HzVIwZsUSwsM+SSM+Kn31ZD2R
   nsrWSCAi+QKw/JrI2jW8VwKVU8uQNRHCdE7+OcSfdzuqNmTDbfvPm/Hib
   F8RGk/Ex3rW8cC2cvDra6h+zrnqJwBUXfRI0hjcmG0tEwQNFaD5x+8dfS
   /2BcxzZ9QQYQh9MPnGeOGU5OGdKvQpyGmjRJpNIIVlU19MZOSVn9AbzE0
   X8xoENnblG6sYSnNYYa/r0ajmeIGBxr0MuGlZ9ZfivCxLeuJ0AyCCZIt5
   w==;
X-CSE-ConnectionGUID: lugyVAWxRECE5O/WqdVbGg==
X-CSE-MsgGUID: aElKInrhSPKqHZdj+PLJlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11423"; a="58690141"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="58690141"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 01:28:56 -0700
X-CSE-ConnectionGUID: X2U55s+CStqmFIAgZFDdvQ==
X-CSE-MsgGUID: s71vzmT2QeSUvLkKiINU+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="134914330"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 01:28:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 5 May 2025 01:28:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 5 May 2025 01:28:55 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 5 May 2025 01:28:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPsNOK53QWdXM8++q8JezB3+9pKu/pg8d+Jdyr1luP3Yx1kh3fK/R3U1fJ9uN/70V34q3vFEaksiNRDI4CAKvE6JqnQzGOSBkWKCtIR86AXNFDmMbRef/PeOFfCwrYqDqZ/MrFoCe0YcJM/lqsgzKHC2gYEfI6oTs7QL5cus61fs/IE/FwJB5ho8aRYW+qvjWw34eLdqPbkZHtio4+7MdhVN/OIP93dsBdljfJOeZWySlNCeSVzTAekR5g7RhCbyrPlIZVR+e53u5sfMwWmISr8nNo2sxXxesX2TQJ2jMkXFh0nH4klP+QQYgRBWKZXu5yX0qhkczLD05ST8L7fjlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KW+GB3x+2fzrwlj9Y5BnT3eNi5GibYAzPAEZP96pI4E=;
 b=YKOksl9n2sl5ToJpewEkLydZlM19Bpq5vOXDeOB9kkC2w0NNtEoDhps/gwbJU5hAbUhuXzpe0x61fXr9q2aklxKA9G/SnuBi9/8sWadyqF8DiORo1NhrmXJ3EIy1OZmdlhua12rsKTTV9EDt+nIyDtJfeu+/0SjxF6/Za6oSLa/VfxcKCIRMBmLMdPsUWpYbHT6WNNs+q8bTF8HYT/3OqjEXajr5vAq1SDxV97st06WKuV8r0M/GkFYQbGCxwhEIyyWOaAhQ1WUIsZ/1C/4i6u9zWIyp4dVENriUbeo0C4aW0cjkrfoIC3LXmtUcW/Ux2NaLeL0sowtbuJOAMWmfoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8)
 by SA3PR11MB8048.namprd11.prod.outlook.com (2603:10b6:806:2fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Mon, 5 May
 2025 08:28:47 +0000
Received: from PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301]) by PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301%2]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 08:28:47 +0000
Message-ID: <5c5564cc-7a02-453d-9f16-b3c3b4f59082@intel.com>
Date: Mon, 5 May 2025 11:28:43 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: perf filters don't work correctly inside containers
To: Ian Rogers <irogers@google.com>, Edd Barrett <edd@theunixzoo.co.uk>,
	"Shishkin, Alexander" <alexander.shishkin@intel.com>
CC: <linux-perf-users@vger.kernel.org>
References: <aBCwoq7w8ohBRQCh@fremen.lan> <aBHQzU8hhyWykGwl@arrakis.home>
 <CAP-5=fWtF7xD2PrZYCjPrrEOXi0Eg-A9jJvwGOfcc5a3nUyyMQ@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fWtF7xD2PrZYCjPrrEOXi0Eg-A9jJvwGOfcc5a3nUyyMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0062.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::15) To PH7PR11MB6054.namprd11.prod.outlook.com
 (2603:10b6:510:1d2::8)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6054:EE_|SA3PR11MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dc89483-824e-4883-7620-08dd8baedb17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGlRc2ZRQVgxV092TC8vQ2pYNkJKYnhvOFdHVlZod0VSTzFld1V3TlByQi95?=
 =?utf-8?B?ZEhkUXluY2c0SEluNy9yNjlEb1N2RHhVOEFiZVR6WFpqa3ZZWW9rdjVNVkMx?=
 =?utf-8?B?MDFEYlYwcTdwYlhnNFhYRmtsajBuZmdScHA2UVl2bGdyTndnK2ZhTDh6bE15?=
 =?utf-8?B?MnBXVmxjaW0rWFNsZFhPQ3hqOUtFaDlXTDZaZkJiRS9TMWgxWUxjbE9rNTI5?=
 =?utf-8?B?dCt4NEc0ZVJleHZiUnJUMW9tZkwrRmszVUo4c2JwdzdCbkJaaEhrcmc5aWQw?=
 =?utf-8?B?a1VXT2NkUTc3NnpCNEF5NW9XaGJhNXdLV3lWRGUxbUoxSGVSQis0VzVhWi93?=
 =?utf-8?B?ZXU2VjR0bndJbm5KV2UzSG04TWJkYUNaalR6Vjd4SWp3d2xtS3BIWWhKOWFQ?=
 =?utf-8?B?MHZZaWhHOXlWSHJZS1dqajlEb2g4cExuNHVxall4bTc2aWI3S3ZNbnEzV3hw?=
 =?utf-8?B?bUhnb2Z4b1psUTZMZGpEQUJvOXpGQ000Zy9qUWVDNFlvcFZSc1o0V2NsR0E3?=
 =?utf-8?B?Q3dLSFJDK0QwejdQeEJOdFZ0N2NFcVdzYmp6bWcrZS81Y1dRSi96VFJiUUJm?=
 =?utf-8?B?eC9qQllHSWpHUzV2Q0Q0S3FKaGw2b0ZDUnNXNjlIUDhEcldzeE8rK0xKdnFK?=
 =?utf-8?B?ajJObkxSbUJvdHZTQno3MXN4c05kcDQzNXZsUGI2RENKVHMyTjdtbmVXUWRP?=
 =?utf-8?B?Uk5YUTl3QU9aUGc3eCt4ZDZ0SWExS3VCdkRmUHpnRTR4Zk13SWVTejBoek5J?=
 =?utf-8?B?ZTVDbmppNDgvN1A3SHBMd3BGV0dySVFNdE5Ua3QwMitZTFFQT2g3c0lHRmVy?=
 =?utf-8?B?ZUVIYTZoY1REaGppcVlGZzZrN3V1bSs5YnJ1N0tYKzN5TjliSWlwY0hLWlZs?=
 =?utf-8?B?b2VCTGlIZ1E0VFJqTVpOM2tyYmhoU09qSG1KV3pUT2NtSTUvRjg0bUtMVU11?=
 =?utf-8?B?QnBENnplVy9tVTZGdUYzZmxzTXVuMUdLVmxFTUtqL3F1LzYyZGtTdGhHOW9a?=
 =?utf-8?B?ODdrOVArOG0xMit1OVZkVkxEeVNrcHpTaDRuaHl5K3U5UCs4RFBEMENTQW92?=
 =?utf-8?B?NERlNHZ5Sm11NjFGK0hjV0dtU1JaK2V0TmhEYzNXTGlvY1lIamVCTGdKbHVE?=
 =?utf-8?B?YURWK0d3Q1pXY0lvL2poeElEcVMyKzhlRGhnUjI3V1dXbTEwcFpvbHE1VGNp?=
 =?utf-8?B?bkJTUFl0NVlacWFQeFBzeUMvVlh4amY0V2RjYnU3NFJBVDhpVjNMcTRuSEpK?=
 =?utf-8?B?YitLblVLeWV2VXdYZDlCVDRZSTNjMHcxT0NVYkhkUEVDeVFkeFNOaFpBMFZN?=
 =?utf-8?B?SEVhNnV6cFk0aGZ6VGNuMTBFclNpeUliWnBjaXl0WFl6dC9HMFpOK09hQXpS?=
 =?utf-8?B?MjNHVmRNOTFQVFd5YTd4cUtCQmN3MGdYTDFwd3VkSStjOTdJU2J1MFlmcUMz?=
 =?utf-8?B?UFBieXcwWGhrdGJuNWp5MEZLUkZXRVdGd3lrMy9nTkZiVFpUbm5kVmREL01J?=
 =?utf-8?B?WURJWUZQb2RUYVY2aGMvS0JKa0tWblVXTHRqdkFjT1NoK20vMDhDYUtzSnJT?=
 =?utf-8?B?RkUyUmFlOXNzR0R3MWlsY2F1REErSEFCcGxla0FWYkhuWkQzYng2NExnSUxH?=
 =?utf-8?B?SExhNFlKYm9vTU1mQXdicEpTeEtidERmUk9tQWJFNHpFK3FFZHlWNGVMcHkz?=
 =?utf-8?B?dDNTd2R3TUtzSnFidUV5NHhER0hRbFpuQXp1NWFjRVd6SlhVMjBRRzhzK3NN?=
 =?utf-8?B?MldwWm40bjBvZ2ZhVGxqbU50TkRObjJHOC84WXJXRlRobGlsSkkzZU9XT2RQ?=
 =?utf-8?Q?zJyLBFwBtBrZbma4zHQKuJej9asFgqSpkbCfQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6054.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDIzNjIwbzF1TjZiWENrSnlhRnpFdkp2UDNqR0pVMUx3RHhjdHBWZ00zOWFq?=
 =?utf-8?B?aUhnb1JUVGtJeldCSmdvT0xCUHlqNk5RRTY5c2dZTVBaQ2N6UFRURVE4emsx?=
 =?utf-8?B?c2lNcXhwcEM4c3pCSDliK2JrR2ppL2dQSjRwcUdYSlBZQmttMnR0Y0xzWk1F?=
 =?utf-8?B?NjJvSFh2UlcyKzhJakVId3lQelZTK1JHWXA5bW40ZmEzY1lrTWVrWVZzcERr?=
 =?utf-8?B?K215RU1KcjJBRi9Sa2tLZVJTL0FQT1lNcnlsVjU2MGFXbkJBRUdBMFhGeGdn?=
 =?utf-8?B?dHpkbjkyS014YmV3YlkwVW1pcTNzQnZuRkhCalprT0ZQOUlTYjZHTUFRWlha?=
 =?utf-8?B?Z2tCWXhHeXJSbEhTTzdqNWpodDJEa1NBem55Qm5pTFBtVkxHZ1krOUFFVFps?=
 =?utf-8?B?NmZKYnB0eDVLTGF1UEhJN0llNEhLOTlOU3JWZTlUQVdMdUJjVDNkRlVoeklv?=
 =?utf-8?B?b1o5VmZxaXNvbDZBdVc3akhKNXFVZmh2cGM3ZTUwNFRiS0tUYVpGWHluTWdO?=
 =?utf-8?B?ZVdONkNsTnBobUh5eUdIS2dabURFSTViMWVab2VjQk9HalNIdkhndlF4Y1I0?=
 =?utf-8?B?Y3pycXZnZWpzeHhFcE95MGlCdGRMSlg5cStQQUt3RzlRYWhHbHlCeDE0Qmx1?=
 =?utf-8?B?TU9HQld3ZWdaSE5Wem5SKzZRSjZodDlzYVhTdmJzQXliQi9RTlhRRms5em9n?=
 =?utf-8?B?NlhvTDVWKzNPYmJZaEF4eXNxOEh5R3pqeFhnZE1sWVUzV0MxQTFqSlA1SkFX?=
 =?utf-8?B?bjNwM0FBMUZ5b2N2ZHFqdTRCVnlCWmNBVlFRZmJMSzc0Yy91YVpTSWFNcnEv?=
 =?utf-8?B?L1J2OWMrdzNaV1FDVnBFNEMyM0g3a2xOaFJGZ0sxTDVMdCtoRE1uSU1VVVAr?=
 =?utf-8?B?bUFMVEdsR1duRXRmbnVveG5FeitGdmw3YXhtd3RtSHVBOGNuLzBad1pRR1lU?=
 =?utf-8?B?azk5YjB3NWcya3Q4MnNqdkdQcFNpcFI0ZGdVT3FKeDJDR01wcTRyQzRlQ3lk?=
 =?utf-8?B?ZGs5eWJJMG1BOTdUWmxCZC9QR1VibDVIbUNROGFlaHdDYjNoZnFJaFVTWmMr?=
 =?utf-8?B?cFBsLzlZT0hsbmJCcDV6akdPTzFKdEFxaHJ3OTNlSmxqZ2hGZDNVTGcvOTdB?=
 =?utf-8?B?YjVTc2lmajZDR0liOVNBbXhYQ0ZnMEJaRE80UFRGZmNjRWRNQ3pXN2VHc2E1?=
 =?utf-8?B?NGRaSVVaK1Q1clFPd2l2R1BNNVkyNHJNcDArQWlXNWNzVHo4cGZtY2pnMFlr?=
 =?utf-8?B?ME45UXAzbDczL3R5ZzlZVWpoT2VxM1dTbEY2RncyL2pEMFpjMm5TWFZKbnZm?=
 =?utf-8?B?a3RZUmpvejBKOUpHWWtGcnhIbWJ3M1pvRVVWSEREOXpTNHdMV3ZGelcvRU84?=
 =?utf-8?B?R2YrWTVHOXlIeDlLS043Qno5MkxiQ1FyM2xrUGFlRHdTMVFYS0Y1aEs3MlNq?=
 =?utf-8?B?NVNDMnVSVDNLYXlOYThMeFEwS1FrR2JYQ28vdHQ1VWVRUkNjZjdoZEx3OXhk?=
 =?utf-8?B?cTdmMksvQjBIUGRBRUlnTmF1RFpDWXo0c2N0SzMzbnIydXNuTE9GUUxVK2lW?=
 =?utf-8?B?U1NFaFR3ejRPM0dDeWJhemYrOFpPNDZQUTcrVHRWV3RESFhYUmJsY1VtWUF5?=
 =?utf-8?B?NzFpZ2lCTVY5eFdQQkdHemVOc0dxa3k2QWhYWkpHR1J6UnZyZ0ZaUTl6MFVV?=
 =?utf-8?B?Q0ZwWnZ5SVlYcHIxdzJoU2NVamgyZTNrTzJIM0lRTWFzTmkrRWw1VEN0VU5s?=
 =?utf-8?B?U2ZwU1VQZ015dVhvUWpqRHNtckJGSlA2K1hjWW1qaGNYV2ZFNnhUQWMxeE5x?=
 =?utf-8?B?cC9HTHVPTEZoOW92WHZHWHFBbmp6WW51MHgzUUUvT0Y5b0QxQkt3ZUhtdXFW?=
 =?utf-8?B?ekNTYkVZMEpTdDd1RVJrdm11U2FIblVBWWJjSHE2STJKSEU2TkRoYWU2M3lB?=
 =?utf-8?B?dTQ3M3RCdUR1K0IwSWNYMy94QldDbHd3UjdhYUp4UzBLcDJYcmJpdm9BeG5q?=
 =?utf-8?B?ZGdTZ09Wd1ptNC8rTFhBQTdMZGtOam14Lzlhb0Y1aW9zKzFqMXc0TEQ4TTJF?=
 =?utf-8?B?Q3F1MGRxMENNWXFlKzBOV1pIM0hLUVArcDRPNmgrTnZ0cUxtb2dySWZIRng3?=
 =?utf-8?B?dzlMaGtBUXBEWDN3Vk5jVEdmUC9XZEdUbXVtR2h4cTNPNEd0NllXNTFwOC9Y?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc89483-824e-4883-7620-08dd8baedb17
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6054.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 08:28:47.5753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8daLf0gxe1/mBKVCy+g9gE4Osoi0v0avhkpKe9kE0/uqb50LrYh9GDRXqBfIvnZn1bUl8etjQpr3NE0NVMdrXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8048
X-OriginatorOrg: intel.com

+Alex

On 01/05/2025 01:59, Ian Rogers wrote:
> On Wed, Apr 30, 2025 at 12:27 AM Edd Barrett <edd@theunixzoo.co.uk> wrote:
>>
>> On Tue, Apr 29, 2025 at 11:57:38AM +0100, Edd Barrett wrote:
>>> I was then able to reproduce the problem using the standard userspace perf
>>> tools. I *think* (but I'm not sure) that this might be highlighting a bug in
>>> perf when used in containers.
>>
>> Forgot to mention: perf seems to work fine inside the docker container
>> *without* an ftrace filter, so it's not that the container cannot trace with PT
>> at all. The problem seems filter-related.
> 
> Hi Edd,
> 
> Adrian Hunter is the intel-pt expert. I've not tried this but I

Thanks Ian!

> believe it should work. On the kernel side the filename is grabbed and
> swapped for an inode:
> https://github.com/torvalds/linux/blob/master/kernel/events/core.c#L11474

Looks OK to me too, but Alex might know more.

> the path should use the container's namespace. Perhaps you can use
> "perf ftrace" to see what's going on inside the kernel. You can also
> compare the -vv verbose output to see if the events were opened in
> different ways, look for things like:
>  ```
> ------------------------------------------------------------
> perf_event_attr:
>   type                             12 (intel_pt)
>   size                             136
>   config                           0x300e601
>   { sample_period, sample_freq }   1
>   sample_type                      IP|TID|TIME|CPU|IDENTIFIER
>   read_format                      ID|LOST
>   disabled                         1
>   inherit                          1
>   exclude_kernel                   1
>   exclude_hv                       1
>   enable_on_exec                   1
>   sample_id_all                    1
>   aux_watermark                    32768
> ------------------------------------------------------------
> sys_perf_event_open: pid 288789  cpu 0  group_fd -1  flags 0x8 = 7
> ```
> which is saying the perf_event_open succeeded giving an fd of 7.
> 
> Thanks,
> Ian

