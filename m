Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4620028E8;
	Thu, 30 Jan 2025 07:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738220447; cv=fail; b=BBPEfIhD0sweuhMIIF7SdOIyBrDojTtNW3NaHu918YGvgb+dSd2d0xznje4Mhnb2jSsxN9jN5YI7SetL4kDIYvWkDOLVFfWEe+S/LCpmbfCqRKqQvqGBQSW2Vj+g4orjmjR6Pc+6RwW9tSv405varsNHHdPCkpdZk7w+WZn0g2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738220447; c=relaxed/simple;
	bh=jfHWJS0L8UQx0m5Dc2vPapuhCJVk8V9RcVQm4lkxVrY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aX7Rvax34Asmyo9r3qo36fv5MnKPBLyVuIEtPbvkQk9+oIO0ilFen64Rscu3m76Bso5zIjgsU5rntVvX8ArgrvNoTa9a/dlKSj73yJAjJ4Rj1lEtzlACBApJfQUYvrqylrxxX2QePqXzhkmGAiE6c+BRErQdMPqSIwh1G++ToWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BVvi5G44; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BVvi5G44"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738220446; x=1769756446;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jfHWJS0L8UQx0m5Dc2vPapuhCJVk8V9RcVQm4lkxVrY=;
  b=BVvi5G449Gv2bO+uqRIXla/HPAFjFgJNz3GoxA4DC5QUDNhO3dA9VZ01
   1Mq9MxxuRhZPWS338JgX2I/KIMwMtblyoU/X9lB70RyAOrE5JsLNO1Ser
   KZ98bKh9doioPT29vUVSiBRub2gAgU19dyscchFG6G+zy88iL523lJl80
   vNJEaACqr7YjJ1e7QWlrlu4qx5C4dKoc7oIMZ5kK2ToGv+p0z/J1K62Vq
   pAnTArG/Mra3U4af/FbABfSBIjFTT6T9E0oBm+ssd/KTLXRP+kEpVoLpc
   32aEnvT64oNx0LFsmbpdPJ1J2LuITG7yosvVZRqM5tH75lwzDtNsSX5bB
   g==;
X-CSE-ConnectionGUID: I/lPykMCTzSzqiq1w8T1Vg==
X-CSE-MsgGUID: ltgerroFSECnH5S1FhQ4Vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="42507930"
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="42507930"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 23:00:45 -0800
X-CSE-ConnectionGUID: gQU5zvQxQHKatWtmq55hAQ==
X-CSE-MsgGUID: gR0sctOhTLS2xQ8u/KLaIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113858527"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2025 23:00:43 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 29 Jan 2025 23:00:43 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 29 Jan 2025 23:00:43 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 29 Jan 2025 23:00:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5LIzfUvJU4fyN/wk2/oAyUJC2wnjlPRRY0BWiRi+MTKHZA02cVnrzDaN8kaRO3kmM46qeGaqYxtmIjDFdjeTUtCS0wWgr2bg0X+xyAMuIoKpzwCYeGLTfum19DN0S978grg6AHuOO8eyTVyoPkB5mbIdS7P87SW/CU0ZKMZoyKSC/ky0haeZjsrmmIXXC88CpwuvamzqmM7qGvMEym8OkLSCzWpXdvCh3P+z5QKr2bc3UlCyA4dFtuWtRpLRY69wH2ujLinB1BxLubNM15Q/IFauPUUKffrZb7vaz4ktH6ZWtPoA1Q1TBek3fNWYpSEk1U1MhfrHR9RChSrSiic8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXOByVoEy4XkJLWYnPHz7grlud62knKp3BKI8/y6HQc=;
 b=g+pOSUSpkmnApCptMmy646rM85R7RtFwCtw4D0XPzL0deKp0hmH5LsgEUr2d5PqCZrmFyOKl1ujxDoFTwhQDmHDC9FTbTeNi5HHFs3gbtdSQ4ZCbb9N+oE8/Cx5/StYgt7Jwvhb0Lf42b/A98xmi+HFPYQbQf1ncmu953MZ/gfuupALoTXqGAYGfD1QYdAV0RVcqkG4wsDPfQ3MCTE5k/NBh+/62gXcM+UHcjbgnFf7KR/jrJHFjvBZ3fY0JMb2J8iF+aNCe2iFYLRCcDoSKpYzpdKkP0V2/5FbxJXDOIq3cgucmwVN2UFP01EPFXJARitEYu4XBfZ+hM4aESfljUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by CH3PR11MB8341.namprd11.prod.outlook.com (2603:10b6:610:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Thu, 30 Jan
 2025 07:00:36 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%4]) with mapi id 15.20.8398.014; Thu, 30 Jan 2025
 07:00:36 +0000
Message-ID: <ef4110a1-d76b-4d01-bbed-734e7ba13ef5@intel.com>
Date: Thu, 30 Jan 2025 09:00:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] tools: perf: tools: perf: exported-sql-viewer: drop
 support for Python 2
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
CC: "Liang, Kan" <kan.liang@linux.intel.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, "Ingo
 Molnar" <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, "Peter
 Zijlstra" <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>
References: <cover.1738171937.git.mchehab+huawei@kernel.org>
 <761ec2ebe518b5506e67d088797b559f89c396bb.1738171937.git.mchehab+huawei@kernel.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <761ec2ebe518b5506e67d088797b559f89c396bb.1738171937.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0076.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::29) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|CH3PR11MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: 038a4fa8-4014-4741-9e11-08dd40fbcbcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmI2M05uY2RKejJkNFp2WE5rTW5YMDNNS1lxcDQ5UDk0SEZTWU1vNzAvNVNO?=
 =?utf-8?B?NlhlWW0zK0FaMmpreFMxZGJNY1JJTDE4ME4xa29Oem9VVTFSNWpzc25KTFo3?=
 =?utf-8?B?R1R1aVplWVIzVW83eXBkcE1FbzAvQjMrVU92eVcwcHgwc3NLc3hnVlpIYTVJ?=
 =?utf-8?B?a2N1SytNVERLdHM2UVJ2Ni90QU9JSHdjTlFadUk3MFpiL2Y5ZkJHOWJhMGlp?=
 =?utf-8?B?dHJFemtIazE3bWFVRis1OVo3UTZnb0tiWlZ1R2pSNzJ6TmE4WWxPTE1RaHFl?=
 =?utf-8?B?bkxsQ2gvcEdTb3pLbEZWNVRJVk5oL3EvWEVZYzh3VCtwa3YvVHBaeDJFdTNT?=
 =?utf-8?B?T0cwU3hvQlkydnVkVzVMbE81NDE5QXhLcDNHVUQydXN0dnN0bzFDeCtJQzNE?=
 =?utf-8?B?OWFyaWd4RlR4WlBBeUpBWlZ4WHBBRXN2d3BHbUNyWDVPZzUzOG9HVC9mU0Vn?=
 =?utf-8?B?RFBxV2Nua1BtWElHQTdLVlZRSXVjM3hiQ3hJZUNBSHpsNjdTYUhDb1k2Nkdh?=
 =?utf-8?B?UkVQbC8vLzh2UUxIQ2FOUnI2K0xuMEdvQVVZMXZ3NmhWZHBSNzlvSU9QQUZL?=
 =?utf-8?B?WmVFUDZucy96ZFRKMjUybUhqQzhWTGpNRlJjQ1l3Z0JPMkcvNStGdm9sbEFY?=
 =?utf-8?B?Qk1Dd3owa1VqUzZ4cEljQ2I2OVk1aUczTEZGWk9pbWg0Wnd4SGgvMUtFNzdn?=
 =?utf-8?B?SmViUmgweUthRjIxY0FzYzJwQ1ZOa01YbVJpQ3V1eHNpVEh2VmprUWtNUVBF?=
 =?utf-8?B?QnRSRzNRUFNxclNXamdOZjZvWkdqeW1MbGtMTmwvdzl2bVUya0JnNHdMRjdS?=
 =?utf-8?B?ZytZUmxsKzJtWXVSRnBWVnJ5ZU1DdC9RdzJrM1k3RFdoQ3I3cTJTNStzdE1h?=
 =?utf-8?B?dGRZL2xVWjFlNW41N3daQklEWW1tVCtkTzFlanNUYkRpYXk2bnRxaDladys1?=
 =?utf-8?B?TlpYeTczbm1EZ2UwRG0zd0Y5VnEyZWlUK09lVUxnWWpPajlGVlNrZ1RnVEtB?=
 =?utf-8?B?K1lIaFI2MFNKN3BJcC9YNFFJVy9PcVdYcjhidENHS0piVGcxVDJobUVOT0ZL?=
 =?utf-8?B?TVFvSTlXMTBtWEZHd2QzNkJrQjZCYWxFMFdMaWJyOXU4S0UyQU5aaE1Gek8v?=
 =?utf-8?B?cXcvUWhaYWFublZKNlVXajk1eDRVVjRzUE5kbTRYVCtSaSsrbnFBL2U5aFhj?=
 =?utf-8?B?WGV3NVpJakY4YjBzdjNteXoxMVd3aDNuUy9YU2JvcUlpdUhOOVFRT3k5aHNh?=
 =?utf-8?B?c0N3bjFNTFFRbXdvR1FleDJEQUdMSysxQkRFck5LVW03b3Y4dlpxNmIxWlQ2?=
 =?utf-8?B?T25kaXdmNHBOZWtHb2FMbGJob0ZSTUlHak9XaU5kZDVJdjVNQXJmTEx1U1U2?=
 =?utf-8?B?ZkI2ZlcxV3l5bUNQcmZ3ZXJvRGhpZ2lBT2RmWVFTVjlnVWVmTHZhdWREMTFo?=
 =?utf-8?B?NGNSd0FJY2ZYTUxza2VRYkF6cUFwQVhSWHZ4WU54VWVLMTZpclVUWG5ISFp1?=
 =?utf-8?B?MVV1SVpucFBCTjM2ODVDOGFlNzdUWWV1TmcxcVVzeVFidGVJdHFFbXIyMGw4?=
 =?utf-8?B?aTJQT1ZyaGZ5Rm9jS1RVODlYenlPbGxKMG9WaHlFV0pMVG9IRTNuOUh4T1Fa?=
 =?utf-8?B?VG9IOFdEY1hxR1JhcVllMm9qT3dlODU2aDNaQjlMNTJnNXF3RlNnMUwyOGhW?=
 =?utf-8?B?eTRYMWdJS2NSU0s4enZNVUdacmQ4TUlrQXhzWEY4QS9Qa1NZZXNONHdzS0lX?=
 =?utf-8?B?QzJuS3plby9iTmxYNHFqZkNwd2ExTWNKejA0RFBjS0xOeHlDOU9acGJxVEhv?=
 =?utf-8?B?TGFwaFpRVEEwaWoyYnNtalhBdjA4OHdWZXl6dEZWSll2Nkd3THhCNnQ0T2l1?=
 =?utf-8?Q?6ZX4EUyK1o92+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEpnaDY4cjh0UlhjQUhnemI2azlaVGdvT0UzUHFCa1FCNCtmcGtVNGxpSGo5?=
 =?utf-8?B?VUg0ZFgwZTJpdlpPN0FGQkNKaXBpbnVhOUNDbmVYZGc4VklxTHpFMmpPNEx6?=
 =?utf-8?B?QnlCT1YrbWdMZ1UvVWY4WnovSDF2dkhKYklnQ0gzMU1JQVlxNVFybFFYU0cz?=
 =?utf-8?B?MlhXNUtrekpjWlZPbDcyZWg2d2lwTUZTdlVuNExzaFVjYVlGM1FKbFpPY2JS?=
 =?utf-8?B?TFpqajE5WU5PcFB3bzliSmVreTYyeDYxOUx4TU5JMXQ2NlpaUDY3eUZoRElW?=
 =?utf-8?B?bEhnU0twVlMrdEN4QzRJOXZVV3JCcUY3VDJiUTBTcUZIcXZxKzRRZm1rN1Jq?=
 =?utf-8?B?OHZZemR4V2RkajVVaVIzekVRekJuOWNwbmxUTG82QUpuWVloOWM5eWx2Z1Vz?=
 =?utf-8?B?c3h3cXlpdEVWa1I2b082SjNFMlZHa0JIMEVqVXl1dXF4V25vYzJ2c1gxRTlD?=
 =?utf-8?B?TmQrZGluOGJpWFZianRaRXB2YWVVM0x0cjVBYnBpN2MzdHYybGdCcE01bE9K?=
 =?utf-8?B?bCtiWEhsR3NLNDNwcFZuUTF3N1hWODFyOC85dUtNM1pJZHpEdE1TSE9jWks0?=
 =?utf-8?B?a2EwMFA4dXJUMFNpTnNrY2ZpVXF0eW5wQUVUeGtoNWYrSGQ5MVBXeHJBTldI?=
 =?utf-8?B?aVdjQ2ZNQ0lUUXJBZDc3NWtxQnV5VFJNY1VSYmxQVU13VjQxWHlRQjlYMlor?=
 =?utf-8?B?MjZibG8ydk0xcHJaalY5K2pFblJ1QXFTZXVmcURxekdMWHMxRXJ4M1NaOW5s?=
 =?utf-8?B?Q1lVWkw0OWYrcjJDbXg1TTh6TEtMZ2JJVUVraTFHTDhNOWVsRE5NUllBSW52?=
 =?utf-8?B?eGFxRGJGK3NwZzJ6RmtmWXhuM3pOL3dUREkySnVjT3JwUzlhd0RqSDk3Sk8v?=
 =?utf-8?B?bkt0eHRicGcxSVFBOTY5SXpMZzB4Tkpra1dQVmVNcUo3UjJrZDRYZ2VuNHBB?=
 =?utf-8?B?MXZrWnN6Qkh4dlg2VUE4blk1U3RWdVF4elRJYWhSSEhhN0dXTS91SmtER2F4?=
 =?utf-8?B?SGQ4d0dzM1VrYXR5QVZ0cWRhMTQxbjhldjhjVG5nQ0cyU0pha2VTYUxuWUY4?=
 =?utf-8?B?N0RJQi83TUxJTWFzb0lySFBMeHQreU84MUxiUlVRaHpLQ2dlaFB3NzA0Rm9v?=
 =?utf-8?B?SVZxbGJrdXZhNXFMNWZZVmMveEFXWmkrQlE3UU9TNXVVcVBBWmRhTHE3NXFx?=
 =?utf-8?B?WGp0S3Z3c3JNSDlLZHNiZ1Z0bUU2ellqLzNYeUI1cVN3SmNTWGNCd081Qkdh?=
 =?utf-8?B?UWJKQXVMK2tqNGI1V2VoTFlVeG1Bd1hiYUZLRzR3bko2NzdTblQ4dU05Ynll?=
 =?utf-8?B?OFpwTDlZOVVqRFBQQ2VacGNORjZmSUttajZpb3UwTmc2NXNXVGVra1ZnaTZS?=
 =?utf-8?B?RFk2MmIwQStYTVlSY1QxbWoyTmkxQWVHbnB2Vm1wNTI4S1hFd3FOcVhnNCt1?=
 =?utf-8?B?QnQ2UDZMUU9QRFNLT2VhdVorcUNhcVR6ZnczK1lpUG9iKzZFWmhBeURURGps?=
 =?utf-8?B?U21HR0xYUjl5ejN6L1FONUM5NERCL0NaOTJBRkJCQTJXVitzR1N4dHdZY0xM?=
 =?utf-8?B?QnBOa0pKRkJvZWJBbWVWOXp6NGk2UmlsazR4RThsbXRibEplUXBHNGFObm9S?=
 =?utf-8?B?S2Jra0pzV3ZaaGhIUURhVXBUUWhCZmJHclZlR2RKRnp2RTB4WWhZbFdXT0RV?=
 =?utf-8?B?UEJnZmQyMG8waUpIeVFkSFluUnNMRXUzakcxaEV1cS9McmVlQ1loSnR3OUgv?=
 =?utf-8?B?bEtjVGZ4S1g4RGVrNUp5VXhnNmRmVkFwOTdCTE1xYnhUb2trQTZKNEEvUFRr?=
 =?utf-8?B?cmU1Z0ZlWXF1V0sxbkU4a0Y3NUJvdW81d1hKSC9wV2x1b3diaHp1Y3pySnBS?=
 =?utf-8?B?eGdmYzNTRkZncXNjakkzWGdOTXdSQXpSZ05pSnhBQWIzM2gvTysrRGlyS0lj?=
 =?utf-8?B?T1hrLzhoNk55VVpsSVZsWUZOdnhQUnRES3ltOEhpN1dtVkZHOW1LOXloVVY0?=
 =?utf-8?B?WnVESk15emRMaGk3cjJsRzJYQlhpU2lrcDJPOTNkR1lseURvS1dkbXZFWk1u?=
 =?utf-8?B?cTNmTVR5bU0xSlZ2MGlsSGNLS08xQjFjN3pLQ3NQeWVBUVNnRkRyOW41ZkVr?=
 =?utf-8?B?YjhSTlFGSk9TZ2xLd2lCL1hNMm83SStGb2JZYTBkZDVLK096alkwUEZhMDB2?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 038a4fa8-4014-4741-9e11-08dd40fbcbcb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 07:00:36.0169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ie6+eXhi8zi5E4WGY1iJjhYsUPfFNIjYc5UNNe0FdMU0AHYTvkePAUUl0k+2VMwpXDLVqSZ/BI4vkJK6Hp7b/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8341
X-OriginatorOrg: intel.com

On 29/01/25 19:39, Mauro Carvalho Chehab wrote:
> As stated at process/changes.rsy doc, the current minimal Python
> version is 3.x, so drop support for EOL python 2.x.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  tools/perf/scripts/python/exported-sql-viewer.py | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
> index 121cf61ba1b3..b096592fd35f 100755
> --- a/tools/perf/scripts/python/exported-sql-viewer.py
> +++ b/tools/perf/scripts/python/exported-sql-viewer.py
> @@ -3939,9 +3939,8 @@ def CopyTreeCellsToClipboard(view, as_csv=False, with_hdr=False):
>  	indent_str = " " * indent_sz
>  
>  	expanded_mark_sz = 2
> -	if sys.version_info[0] == 3:
> -		expanded_mark = "\u25BC "
> -		not_expanded_mark = "\u25B6 "
> +    expanded_mark = "\u25BC "
> +    not_expanded_mark = "\u25B6 "

You removed the 'if' but left the 'else'.

The white is messed up.

So presumably not tested at all:

  python3 tools/perf/scripts/python/exported-sql-viewer.py
    File "/home/user/git/review2/tools/perf/scripts/python/exported-sql-viewer.py", line 3942
      expanded_mark = "\u25BC "
                             ^
  IndentationError: unindent does not match any outer indentation level

Posting untested patches, especially tidy-ups,
should really be discouraged.

There are many other obvious python2 things in this
file that have not been addressed.  When asked, AI
listed 10 things.

>  	else:
>  		expanded_mark = unicode(chr(0xE2) + chr(0x96) + chr(0xBC) + " ", "utf-8")
>  		not_expanded_mark =  unicode(chr(0xE2) + chr(0x96) + chr(0xB6) + " ", "utf-8")

