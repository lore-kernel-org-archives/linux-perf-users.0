Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E04442FB7;
	Mon,  3 Aug 2026 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782824; cv=fail; b=Cv46FT/oSdXpgQZVp6xsQjsID02xp3a4NO24Do5bPEKSwzdi2MV0XreWARQzlWQuw+dVDiKCRHxerWwvjq4t77LcDb9E4ZFH4s0jTOuohuxXcvaUWu0r/KMDHTfqozrPsk/dAKOzx+R4F6Ng8ZkrkkYb6KK/kQMpZcXEsjBWfeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782824; c=relaxed/simple;
	bh=Auqtf6lwOZld9PCpv9T2TfTFjCHQ1pZ5l6GBhp+x1KU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CHggI3B9f9qdT410sSAoROrjw+ng0xq3+adNyP7kCWiGXeHfhSahfX0pDgONolkBK6OqlQ5k6ytpOrPbbud2CAv0rJocRD2lN6Gdccl0dtO8hhIJDozn7VZ9Fu6LYo1Qdm/y9bxzTYiLqNWtSPr68erncV5Ls6fNtbGaKEeR5PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZfHlKr2P; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZfHlKr2P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785782822; x=1817318822;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Auqtf6lwOZld9PCpv9T2TfTFjCHQ1pZ5l6GBhp+x1KU=;
  b=ZfHlKr2PLz6YAL80hIZK27QyexzLLNCXuyIddsSIa4m3XiOyvHnfExBj
   ziuqfucbFAq45p0ref/CtmrUC4beirLG8e6vEAF4OHDiVoakLmV1nXGbB
   9cAXJEbYIMvz/ZqsBMxNH5u5dl8Hc+wjv5kL8P1LZUhYmb9ZZhK+Lx4Xb
   twAJniHHsbNBTbzlcI5zg1t/w3q9kuZTMou3bxE3m49LY5mp874Kw2+6x
   xDjQUamK6B+lTBOyeSXHI4g6TeU+wrMDxP8/njaZybAgR3eEGqOMO4jeB
   wOKwQP+FCi0XJLqC4rQxDWsm7ZrmL2jLAC6MQsHGZPRuHclS/+SYel96w
   A==;
X-CSE-ConnectionGUID: m51Mz9yzRiyoSV4CoDfiAw==
X-CSE-MsgGUID: dHK2+useTGy4q/y5f8kIGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="103731471"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="103731471"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 11:47:00 -0700
X-CSE-ConnectionGUID: gCpU/DqvR2C9mb9Vu4C6LA==
X-CSE-MsgGUID: Gd8kqK5zQO2RpuCsPffv+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="299519222"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 11:47:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 11:46:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 11:46:59 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.28)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 11:46:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZlOqfV2UijYMFC+Sa6Zbyold2hPZF/GLeHvPSbSdbSB39XxYhAP+SoMGWBgzN2kcvrF3geFY98UpEPgaNvWiZ3xwPWRjJmb+RY9ZIyBRuXbUeY+dudfltXzt+LHK1+AEw+/cLZm9Id2NozUpmqnJ+olhEPeVrZCW1VmzOI7w28Q+lEHMQSo5KhcJYjf5lrrjXQXhpck/RlX1/D9+Xw9mZxp33Bi8uAYSQOPtW9bKmzJU9QGS8Vz8hFT4xnW6b9rue4ERDrDaZ46MY1WB48y/scvjkUF/BL0qzgS+NCLBAv2o4UsfciOIq+P8/53asoJXdydwE20mhnVU26BuK2iz7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6S/QRSUWWsDGi/+su3mJh9Vsfw+b6juUliQHIRjnTag=;
 b=Woy+88cNVmx4gjofyZPWwYpg0MiviaTF6LxtkK3Sy2BRAr3QpF13lFf9fDqT5poRFgqgk2EOQQqoX4CkFThmvXU9kucQzn2B/f1LpPl/v0Ng/qWs8mJKNsFiG9i3nvAxRgi8/0vVy2gwr7gAZHRv5YrLqJv22Boow8DgrK82qp3KoJWO+E0E4ICw1T4awlAvAtV8nbOCIxH4FKkKU4VkXA4T1TpK6RjVgLqAFm4f9qDT8KpssYZ/kHr7tbPbM8/gc3ZGuSZboczFkuqjlF6SlBDaY/twu1VhgusYHaAvUrATJg7pSWOi13v35hM/HCXJ54CwGYElzx+BHFKPwmIB2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS0PR11MB8720.namprd11.prod.outlook.com (2603:10b6:8:1aa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 18:46:56 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 18:46:56 +0000
Message-ID: <df7bf01f-b0f6-403c-8415-305f3ea63fdb@intel.com>
Date: Mon, 3 Aug 2026 21:46:49 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] perf arm-spe: Reject zero nr_cpu in metadata to
 prevent division by zero
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>
CC: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Clark Williams <williams@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>, "Arnaldo
 Carvalho de Melo" <acme@redhat.com>, sashiko-bot <sashiko-bot@kernel.org>,
	"Leo Yan" <leo.yan@arm.com>
References: <20260727161705.64807-1-acme@kernel.org>
 <20260727161705.64807-6-acme@kernel.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260727161705.64807-6-acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR06CA0026.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::31) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS0PR11MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: fe839f47-c6bd-4c69-ec61-08def18f97d6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|7416014|56012099006|10067099003|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lWC3LaauZuLEWOPS1BpBF+9dLiDBcrlmsH0Pbr5uYPEDyJxjFjYZ0uiqBji0HddTHB296zfI89i+8a3LwTzWeDxJSVSKWpTstn8xn7zag0B1A8AiONjAiEDQPnlYOMHb3ErNoZL0pWmzvqa4vNg3sEUhNtCvWDGTbLOabmsHDV06kfDv/MnngSyCud/bfv3R2wc4gQirAdUnKAiT5JPsE+V9pc1bDrL3Cq186BRUjPtiMsnBxljA0HBjq5KEcC+KWmchzUchZOrSgubl6Os7sLD5njZwnLbjnKcGZSvtZfZfZk+V8MzU6Kkc0UvYXNZdaMiO6bb+CoozC0cyi0cXeest/7k+g00H7T0Mcg6C3QBZunebhA88//PtG85tDSOePeIcJmlAdGtp9pei1RV1fR7yHi3Il+jFO2enWQ525b4P3TNSJfKZIsA+ilw7bd+dIZrYi/VFLu/VEMFRYJ8NGcqmykkyk5y+avvb4gKaIvxfhhXdqhIZOlDRDSpkyjNhmaufVnJgKsk7G+CQKKSfBy5ZuOpFdrVF1tI1iXTER2D3LbtrkUTUJD6HB1XJA9cT+aYxBsOj9Hov5zn2JSKKQciltf8aBcIaDBupP/HD8jy01zxxJ1wfb/5q+3Ym7lCQHRFj1XIGbxM6/FwZ5Zopu5DjqUQ4P4rTjOzhnh/JOj0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(56012099006)(10067099003)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWYzaVJRTXNzUGpZQ1NUSmcrZUVpaEdVUmU1YVByWlpBVGZEeVdpTzA1RlZq?=
 =?utf-8?B?ZGd4OTlKWDZRWjhlcThIcDFBcUtNNTBleWs0OHlRNldGUXdnNzJ2aFIzaEt0?=
 =?utf-8?B?WUZ2L3k1YW1LcXNRcUVqRGZIeHFHUFg0a2hqaGFvd0NIcE5KdUh5WGh1bStX?=
 =?utf-8?B?NlVvRDRYZW84RVVSSHZrRGh2dVc1QlZUaTBFN29FQUlNWkI5MWlWMTV0aDUz?=
 =?utf-8?B?UlBTQlI4T0EyNTRMRFIxVFhjUkp2aHIyWVBoTVkveWF5cVkzblVoekhaWStF?=
 =?utf-8?B?ZFdaV21YZndZNXlJM0ZsYTU0VitFUnlhK28wUzFLRkE3OHg4MTViOUVDM0hs?=
 =?utf-8?B?WkxjbDc4THdTSFBYT3NMUGxNRVdpU0grRnZWZkZhOVU4QU10aXZvYTc3d1Q4?=
 =?utf-8?B?WXk2dE4xTC9MRGF6NGM0U1RqVkRMeFJ2eGlXbzdscVc2VHR3L2dvNVBTbEQ2?=
 =?utf-8?B?eW14Q2pDaHV4MGFnRU11cHpkUWhPUHJweXU5UVBhcXpTQ2dhOUw5R3dOVFNy?=
 =?utf-8?B?TUc1ekp3WTkrQ0d4YVBJSDVjeHRhYkJsTFozOUJSK2hjZ2lScEtxTzVpMHNk?=
 =?utf-8?B?N2xyYkw0K0I3VFl3MVBETENWSkRLcFlURWM1MU5BM1hkdGp2MDZLMSs0VmFB?=
 =?utf-8?B?cytzaDl1SE5EZkNIUGo4eGNldjRtSFd5ZjY4S3BRZjl6cTdvdWpCTVNVaHNO?=
 =?utf-8?B?ZkZIWEJOODRTSC9CMEJkZllGSE9lVm9HejEyUU96NWFuSU5BaHM1Nng1dVNU?=
 =?utf-8?B?YVhnMitYclRZdnczcG1iMDEzdlVsaUJaN3ovQ1kxUlFZM3ZIN2RjZ0crSUZN?=
 =?utf-8?B?VXdVNHkzOXNtRWJEV3l0SlRqbnE0YWRKWmIrOFFWdlY1bzlKZTZqb0lZNCtm?=
 =?utf-8?B?ZUZlZC8xd3N6UmdBU3ZoMlg4emthM0JGRU1SdWV0cW9nOUpWd2NMTWV2VUpR?=
 =?utf-8?B?SmFGdXV1YlJHeS9lTE5qUkVNTzh5RzcrNURSU21aZkxCQ010UWYzTnFybkkz?=
 =?utf-8?B?OFBMZ1JlZTZrczVDQ1g1bWxnaFFXSCtGRzdSUUpQQ1M2UEhUeTMzNWY4dXRk?=
 =?utf-8?B?RnloaHFQU1VuNlZFVktrWWpadkx0WGpHaE5WS2ZnUGVUdTU0Z2trb00yQjFz?=
 =?utf-8?B?NktMbk9aNVRSWlZob0xvcDJSbkU5ejNuUVZwa0loTjlGeUZORTRHNHFBOGpy?=
 =?utf-8?B?eWY2L2tYNUlIK1QveEFGOW5GL1o5QlFUVmNjVC8yekM4NEgrUlV0YWVTbnQ2?=
 =?utf-8?B?NGVCZVVhTmFtb1QyWWFsWkl6VHE3OTFMcHo4MTRneU5Fbk90SHZXUzBaaFRX?=
 =?utf-8?B?UmZLaVNzUHdPUkxtV2RyRFB4NjhSbzFmNmFBbWdKKzg1NXpNUHBNdDVxSzhL?=
 =?utf-8?B?azk5M3dXbVd1RWZFMldSdDU1Zmx5Y1ZlTk01Wk5LR2NxK01ZSHF6S0VmQ0Jk?=
 =?utf-8?B?VURIS3c3ZHFReGdXcGhOWEptL29pUGczNTUwZ212bi9kSXdMSTlHK1FEU1No?=
 =?utf-8?B?YnVEU0NacFp0UGJXNEhjZnZ2T0tTRndKQ3pHbndseWcwNTJvWHkxOUJ5R2R5?=
 =?utf-8?B?aHhkK1ZZdU5aZWR2bEFwRURLNmw2Y2lJcE9YVmJkZWZWd2UrOFJVSURwZ3Fk?=
 =?utf-8?B?YTZqYXRjOTAwK0VxRWhqMVR6NkhQV3Z2MXhKbHhaVkxFcDhBNHpJeHpDSVN3?=
 =?utf-8?B?d3ZpMU9JQzFBclNaYUxBV3h5U0M3YXV1TUFhZitOdnlLUEcydWxoa2ZBRUpY?=
 =?utf-8?B?NHBJWU1aN0N2QUE0a25zT0YyUXprZUM5dVJNd09VUXgyVjUwdjQ5cjd5THR1?=
 =?utf-8?B?UFNMN2ZkL0VZblpKWHpPMjNuL0ZtdlRFMXVUWEt6TVluRG5kZi94OElTMENz?=
 =?utf-8?B?S25FOTh5RjNCc1liRmpTMG1YelVEMGl2Y29GcldOTVZhY0wyc1dXR0hNczFw?=
 =?utf-8?B?ams3SFVJVlYyUk1VZkd2NTdEZzMxSVZWZmdBQW03N0V6Vzl4NVZoY1hWRGsv?=
 =?utf-8?B?b3krN1Z1cFozblJxZmJ4Tmp0Q3A4TS96aTZLNkRVczZ2M3JaME5YMXZxMHdx?=
 =?utf-8?B?MVNabi9BY0pkSTlGNkZlS2JrUjk4K0V4R1lvTjFwZzJidlJMOUtGdVc3RG1M?=
 =?utf-8?B?d3ZxRUlTTncwSmdBeGRxYlRtOE8yb2ZBTHVpWUJUNGRwejJEeFJWZE9RSHZF?=
 =?utf-8?B?U1RqaGEvQjRJbWdxYXRIT1FmaUU0WFk0d1htT1BaaXF6NmpUUGJjdlJlV3lR?=
 =?utf-8?B?U2J4ckpGdFU4MlREUFpkdEw0cWRlbmhTMXVUdWEyWUhrSE9PSUluZEZ1NWJt?=
 =?utf-8?B?dFlwYzZXUENYUjRkMmxRQnRvWTNXM3J6UmJxMTJFTEw0YzU1bHlMOHgzR1Fl?=
 =?utf-8?Q?WOlzQ3bSEO+IzKss=3D?=
X-Exchange-RoutingPolicyChecked: GH9QVI9e32wbMUXpFSAsteV/Wk1tDNM0gKb1fv3mdmYrbMVEl2aldNNLm/kGSYi15koa8/OtyPgj4+x6+0zvQiLr6QXyIJqRS1VyoeVIXiORCvk07n2EpydzCDPXNhiHUJXA4PDheHovuYk9Hyc+79cr+VtwdN1G2vc7+ZCspG6nbdE68lBt3mS72074q9UfqPa4At8XxccuxDeEO4QKp4pbuzjpNCOGn/o5Lx1uN/9uxZobc1ut/4ootO2MFda1SDRnytsDje8mt8GckJlejOkxsvoOSsJP7wLawHeJd/uMfwOjuzrtVEpj6JCTQf2t2zKfXaAJRr7PZHY0VkhuPg==
X-MS-Exchange-CrossTenant-Network-Message-Id: fe839f47-c6bd-4c69-ec61-08def18f97d6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 18:46:56.5493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R1szZ4or/OeTXPSo3hXksSAxplEv8zWSGqHJLDCIP03Z0WgxABjRjtDQZ7PuN+z8ABSdAN8L+ZP64gjglx2tpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8720
X-OriginatorOrg: intel.com

On 27/07/2026 19:17, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> arm_spe__alloc_metadata() reads nr_cpu from the auxtrace_info priv
> array without validation.  When a crafted perf.data provides nr_cpu=0,
> the per_cpu_sz calculation divides by zero:
> 
>   per_cpu_sz = (metadata_size - (hdr_sz * sizeof(u64))) / (*nr_cpu);
> 
> Reject nr_cpu <= 0 early, before the division.  The caller already
> treats NULL return with metadata_ver != 1 as a parse failure.
> 
> Fixes: e52abceb4b6c2723 ("perf arm-spe: Dump metadata with version 2")

git blame shows 7842a4b6ff698 "perf arm-spe: Support metadata version 2"
for the relevant lines

> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Leo Yan <leo.yan@arm.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/arm-spe.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 552f063f126e6769..401aab529309cbd6 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -1605,6 +1605,10 @@ static u64 **arm_spe__alloc_metadata(struct perf_record_auxtrace_info *info,
>  	hdr_sz = ptr[ARM_SPE_HEADER_SIZE];
>  	*nr_cpu = ptr[ARM_SPE_CPUS_NUM];
>  
> +	/* nr_cpu is used as a divisor below */
> +	if (*nr_cpu <= 0)
> +		return NULL;
> +
>  	metadata = calloc(*nr_cpu, sizeof(*metadata));
>  	if (!metadata)
>  		return NULL;

