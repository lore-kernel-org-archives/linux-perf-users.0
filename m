Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C732116F4
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737644600; cv=fail; b=cjT0pXcNELMgJZYsYF2zXhxSaxT7eBrT4JW6l90UwWLXNF4dNHF1W88WHpieCeBE7Ly/z8KIa07XuG2QLGddaJGxvjJhlWG/7rXPwcdAHTVaqqX+bC0SOFBxuAt3oFi991jwEYOuKqLHLbe3EVOONX2OGRPUJXiX9wR16gqn4yA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737644600; c=relaxed/simple;
	bh=sq6BfLp6la96UD8EbLBhFMahpmkUP+LitIsixg4S8Ro=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P3XntwELiwuIh1i0SUT9vHyZ5N8nfhbTt9giY3ODqQb7TCV07O2hADm7LR0BmkfF1f8kJNTn54sGgnajB+2ZsNtgRNuD35tFFFWXEHY+lPKvzO2GbxlT5i2/Lam1qQ+ytg2lZDRXko4klAKCYJfs+SITr2Pzplz4f+P4XLi6MRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RxrMgSrl; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RxrMgSrl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737644598; x=1769180598;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sq6BfLp6la96UD8EbLBhFMahpmkUP+LitIsixg4S8Ro=;
  b=RxrMgSrl/Et3KYRrwEZ7WDNS1EB6CjMlk0DrVyVO84CdSdbUCb22kFGq
   4BGGxpH1BJHOuZZvx9hFdCDM6JynYB46o3ralM/0qeTOp3rsWpWZ+azeA
   F+S6FefQEK4tl8OhHLCKMcn+AXphiGLsXb+t41BAjDNAW0RzD7jZPAujC
   2xlzHL29NuqHpztsBcgrZ043l2EOERao8cg4ica5nJH5FdWosWP8U7phz
   JEp/6+g876MKS4pBz4WtUMhbX06PVjk8PvUnbKcT2Huv/99AispFiIbqn
   7J6VePalxQkInUf8lD+Q192t/lu260FsbmOxn6O+XpsY+czjitJZF2U+A
   Q==;
X-CSE-ConnectionGUID: 6JsPLvjuTJWoZ6ZnYwVPRg==
X-CSE-MsgGUID: OcCaMkbwQgCk0ybBgwyYaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="41813727"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="41813727"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 07:03:16 -0800
X-CSE-ConnectionGUID: 96SMszuZQJeytiCnLAL9hQ==
X-CSE-MsgGUID: C+uKpSBQSASoplWKaVCV7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="107592554"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 07:03:12 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 07:03:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 07:03:11 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 07:03:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIZIIUp0/XVQi179ZAMuGeecTG78yqHnLxMh/hA1e8QO7ceLpTQYJMjtGhmpdePKywO0Eyr5Fbl2wt14HWthmt6UDFcdTdu/J4DtKhGlRy63KP4LsPYxeFokK+ilFJySusJTovA9hjSYg1KGnn/D0cMi784J2QXa/qx2VKR3MMD7UZSKYS92knfUpMPLfC2SVVsUqXEhuFZ9plg/LaBH9VnQYzzviZ3qpVFCFiMvTUiCvTHjA+y8EnBtdYIDOgHw1aR0mMSV3krYUXUq/TIyWgstsMhysFWzgzv0suinwJQsDtGzHZusDmFxBuqQus1HCtfLHPpI0741ui+d8o/mxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbm6Z3vcnXdhnMjlKXy7unC0JZz7edpvhNTxmV8PzR8=;
 b=KWcOkPYzdD3+qMAr0j7C0+5vn5+j4I6syE4w9MfxmDlKviO85h+N0u2tyNKqM9KRs7vzV7Ltzh5LEMG9gUqokDlsgiRnXh0WpTfOeeJb7EhWnN496h5Kj6dGPGiadcDkB/UuxEyP8EI9/25Q8Ws7jvee53V28z4SQrDKwCxoVQZIY/asUYU1I7HosNWdimebAu2BrO40ZTSCvaNgTH73AXmDquH21962JVJwG6DWArGymbVi6DBCg96hy6KgXMKdsGeGOAwzlnOvEEbin0Lrww7H673NJzO0suX1Iy5JqWkj4S2DsMIz89kpTbNjla9HmAiC4ySc1LjGd44yaA1Xhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 SA0PR11MB4703.namprd11.prod.outlook.com (2603:10b6:806:9f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.17; Thu, 23 Jan 2025 15:02:55 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::d3ba:63fc:10be:dfca]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::d3ba:63fc:10be:dfca%3]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 15:02:55 +0000
Message-ID: <b1fcdb65-c9b8-4dae-a54b-042742202ffe@intel.com>
Date: Thu, 23 Jan 2025 20:32:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 4/6] drm/xe/pmu: Add attribute skeleton
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: <intel-xe@lists.freedesktop.org>, Vinay Belgaumkar
	<vinay.belgaumkar@intel.com>, Peter Zijlstra <peterz@infradead.org>,
	<linux-perf-users@vger.kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20250123041923.1892837-1-lucas.demarchi@intel.com>
 <20250123041923.1892837-5-lucas.demarchi@intel.com>
 <c0f2047a-9c6e-4a31-a8f8-0f287c09e242@intel.com>
 <xmu2uobe7p76cqpbyzyx7psfzm4aueta5egslo7ru3vgo3gqvb@7wwv5aym65hw>
Content-Language: en-US
From: Riana Tauro <riana.tauro@intel.com>
In-Reply-To: <xmu2uobe7p76cqpbyzyx7psfzm4aueta5egslo7ru3vgo3gqvb@7wwv5aym65hw>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0168.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::23) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|SA0PR11MB4703:EE_
X-MS-Office365-Filtering-Correlation-Id: ba62175c-6082-4c99-e983-08dd3bbf040c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzJ0YUVwU0hDbTh1VXJKTzdGakpUTUR2T0NUY2xIOWtDZnI2NTF1Qk40M00x?=
 =?utf-8?B?OUx2ODFkQ0k2VndFZmtlbVdCeUxMeXVLeE9sRkY0dm9UNnZPa3EyMWkybkxy?=
 =?utf-8?B?MjVIRlFTNTY4ajl1cGQ1dyttd1plUlNQLytqenFOcWZGSml1ZlB3N2tKMitR?=
 =?utf-8?B?bHVvU2NaMjhpYU42Q2FSYk9qUjJZUFdQbnVjR29Wd3l2SE1sT3FNMUdLaXlS?=
 =?utf-8?B?d3dXTHZVZGx1NHZGTmtXRzVaZUJFcDR4cS9HSnl3dXptcjdBaXB6dkNFSExr?=
 =?utf-8?B?QjVQdkxvc1ZXY2xsamJXMmtha016YnBQbXZQWkgvR09qS0FUaFoxNDhqaXo1?=
 =?utf-8?B?R05qVkN3SjNkM0p6V0hYRlREQm5rK2VKTDhscFFQV3F6SzNMWDVwQXdtVFgz?=
 =?utf-8?B?dHVoVXZlMjNuaXNOMWNTdll0UW1yOXlPT25KOFdvdFRuTFl1Y3hYcjJvOGFv?=
 =?utf-8?B?VnNtOGhuVnR6VzI5bnBKcmdHV2gwbWNSWC9BaVNyaVNURHFwbWZEeUoxdERa?=
 =?utf-8?B?V2p5TlVTZ05OUUVGenBwZUxCVFNuQTBPcUlTcis2ZWpTNU5iZnRHUUNzdjhr?=
 =?utf-8?B?VU9rL056UDZwNzdXUVJIcGFJRVVYdmlobWJHQ1E5Uk1uVVNVRFFJVnRtc0VE?=
 =?utf-8?B?Q1pLS3VRVlpnSGx3VEN3RlNGaHNEOGtpQ3JtYjBLY2dGRjFGMitta2VNR0ha?=
 =?utf-8?B?UHRJUzBWbS9tUklEMk93eUtTY0tUaU5ucnF0R1VHRUsvYS9IdnVjVGV1V3lj?=
 =?utf-8?B?SGh5WHBOUjNoUkg3bzNBdmRDNU9BQ21YOG1DamRvV0VrdkZvVlN2eHJZUURl?=
 =?utf-8?B?OVNMZVZURVFlem5lS0luQ25oNkVwRThLajJFdnN6dmQrTXo0ME52ajZuS3cv?=
 =?utf-8?B?MkQzNDRvb09SYzRsVnVqd0R0RHEwK093SmZWZU9DV0JlMnA3NUJnbHd0aUZX?=
 =?utf-8?B?ZWYwM0lSaFAvU3hYZHdoOXplYnB5R0lCVzgwd0lnendUaDFHYnE0Zis4TmVw?=
 =?utf-8?B?MktNcW8ybFRJSDRJdmlXRFN3MWN1WGZ5cXFzVEhkczNsK0xqQUU0TFVFYTVX?=
 =?utf-8?B?a0s3cFpVbUtEaU9ZTmhtUWFHeWNEaGxTQWtYeitXdWhHbXR1aFI3dGF1cnJi?=
 =?utf-8?B?bHZDZFNvcjN1Yk5YQUlpWmpGQ2pqc3FIRkNaSUVSdXJMYWpKckxhQVNzZ01m?=
 =?utf-8?B?YkR3RlN3L29PcW1jNXRpZW4wcHBuTVN1cFVIVHU4K3pPOVF0YkNjL0ZLUXRL?=
 =?utf-8?B?SVFlcEw5cFRPeUF6WDBjQ2JFTHVyeUlYQ1d1RUUvTEFPdllFeXBtemg3R0Z2?=
 =?utf-8?B?RkYxazV2eWNqRTRlZmJ5RkpKQTNvOG8wVGZiRmZrMXZqb1NYRGw1dGlqMEZP?=
 =?utf-8?B?T0RXUllRYm1sN1ZBUURZTVJSa0JFT0p1dlplSmx3S3FQSHV6NjhpTm8xT1RF?=
 =?utf-8?B?ekNoY1YweVdPRUVPOUNTVXNtNmQwTC8yNFNZZUFLdDM0U29iZlFQYVYrcm93?=
 =?utf-8?B?TGFnbnBRbjZTZ25tRkxmaU4wb1VvNVJIWC9oeERCYk43TFlIeTc0ZEZEYzRZ?=
 =?utf-8?B?R09rRU40TTFLZ1I0VlJ3NndEZmVMRytERzFtSkluS2MrYUpGRVY1Rkxwb3gv?=
 =?utf-8?B?anVvbGlpdU5aeEVuR1VHM1FOMVR5aDd5dEh5c2lVZzVobzR3STZDbG9MTWJC?=
 =?utf-8?B?SytBMENhZmZET3oyOWYxRGZQSjZvam42aTBEVjNxcEJDR1Y3bDl0eW93THlo?=
 =?utf-8?B?aVdPRVVNdW5ncVFyUFNZZmJQYldwZHdmSDE5MWhXa2x0blJ6VXZDbm9iempD?=
 =?utf-8?B?UU51TS8vNHNjSTlUSmVocWtROHMvbm51Rk1vYk4yWEdidkwzRGV6RmNPYjlx?=
 =?utf-8?Q?ysRfxNM7Atz/X?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVFhS3dyeHcyWStsb243bHBNL0pEZlN5cFZNV09VcHo2MGVUdC95d1RIREZj?=
 =?utf-8?B?UTZFcWN3SVhQT2Rqdk5mSU04Z2ZDL21pcTIwSnNTemQ1RHhNUzYwQUZWS293?=
 =?utf-8?B?cnFxb09ick9PQ3hxUW45SnpGMUIraDR0VlRHVWtROHhWVUEySzJvV1RCeVVU?=
 =?utf-8?B?aUdIWWNJOTlFSDVobEtKd2JqRkRhemdDbERyZEtmcS96eXZXOUJXRXQzbUp3?=
 =?utf-8?B?RldNNEtPSUxyRFF4M1FadHowNFVPdk05VDRkOVRxNVJWWXViN3RHNHpacFdi?=
 =?utf-8?B?UTVBclArNVhXeFdJb2diRHkvMEFtYWhzWDkrQk9NWUxxcHVXU3Yzd3pURDds?=
 =?utf-8?B?NTBMcDB5RXYxbkVZckswUlBlSFRIaGdQOWQ5dUdUUDRVdjUrdnhQeko5aGp1?=
 =?utf-8?B?SjJLSWxNaTd5ZWNjSkh3Kzc4MXB1eUdYRzNSaEdhdkplZUlvMnhRQlVZaVFQ?=
 =?utf-8?B?ZTFQUys3LzI2SExNRE5ZekpOY1NrWTA5WXY2TDg1RTdaaDgrTTNyTkVtYllW?=
 =?utf-8?B?b3RYZ0plWkhHZXJhZ21JQi90R0FldWFRaDZnZXdpZ2NTbThkZWZFYzhoamFM?=
 =?utf-8?B?YXRGY0dYeUsvaHpBZ2xSK1BycWE2Y205SmY0M3JTd05iQUs1NUZjRWNYM1Zx?=
 =?utf-8?B?eENRbEpjWk5aNVkxQmhwUUs3dGthUWxLaEw3SUhianBGMVl4SmdwOEZvKysy?=
 =?utf-8?B?eStLVnJqOXNyNVl1dEdUTWhJdmlWQUt1Q1BxSk5hWE82VWswMGprUHpRTWFT?=
 =?utf-8?B?b1hoeEY0ODV1TGgwZFJOQWkxZWZjSXpBYU13NDRORFliNDFZQy9uYzZTaTlX?=
 =?utf-8?B?NDNYTkdkL2pCRTBFM2tlR2d0cEp2OUkwRWdCcjJ6UXd5T080YzVETTd5QUVU?=
 =?utf-8?B?dkJveFQ0TmZzSXZmL25yUVBneUJjeXZ3MlZvN0d1aUlMajRQT0ZadzNQaUJo?=
 =?utf-8?B?NmUvMElIMWp6QXc0NGg5bjN6ODhrQlZ6Z0VnOUVJOGNiaTg2QlhHWFRKelVU?=
 =?utf-8?B?U3BiYk1QazNsUlYxclZrcm14ajBMOTZHYzFlSFBLM3ZyaFJXakN2RUhmN1RG?=
 =?utf-8?B?MVF5OE0wMUtyTUF6U1JNUmtseUFqUVUwOVMwMitXalNQazd6Q2d2elFyZkp4?=
 =?utf-8?B?KzlWTzN1aUpTTk5xOG52YVJXc0poRDlFTk1Ram12MVh5cG14NHhZRTQxSHNY?=
 =?utf-8?B?V0diTUNmSXR0UUl6UWJrLzJNcGVMWUYwSE1KNzFmWWU1VE5NRlBVc2I3UHlS?=
 =?utf-8?B?YUNrNG9ibE5GS0xvSXpjY1ZZcFhleURJWTF0aDZ1dGVHaGZuMjljeDUxWWls?=
 =?utf-8?B?R2tpMHIvcE5FYVdSa3NJQzJpaEJxYnh6ZEp4blo4TGttRFBDSVdBVTFrTGs5?=
 =?utf-8?B?dzV2RlJMV2txa1VqSE1YOUg3Ymd6RkdHSFM1MllNUlVuYTNjZ1ZRQzNTL3V0?=
 =?utf-8?B?ZHRGcENGRlF2VnNiemM5ZjIrbHJIUTdxbFhnYndDQnoxM21XSDRzK2pYelJX?=
 =?utf-8?B?L1hwTmhtNm5CMmRMZ1FNTTM5TVh5UjFtdnh6cGx1a2JWaU1YVXl4WXIxTjFL?=
 =?utf-8?B?RzgvTE95T1o3bGNrR3lML1hqdFNnR0JRZlQvRzJ6WWVTbnlidWkrUWZvY2R1?=
 =?utf-8?B?MUZ2MWtQOG5uemZxR1gxMVdSaWM2RXVuOWhoMGNtZzhXbC95QmFWZlFzMWdn?=
 =?utf-8?B?eHhRNEs1cUZsR0tEZGhMWjlJQWMvMmZ0UGk3ZWtXSnlsb3VQUGtuS0NJOFVa?=
 =?utf-8?B?VnNHQ0U1OTJveXE3dnJXMjlOVnVxcmZkb05CdnlNM2p1R2FiVmNBSVkxNWJu?=
 =?utf-8?B?RkRabS9ibnJVYVhlNkpSZkVsSEF1UHVCb09SaytHWkJXM1pLMmo5bHBuMjcy?=
 =?utf-8?B?ZFM2aEFESUovMlhlbHhwN2NpMUJld3BvcHVyTHR2T24zZ1RFWEpWRU9XZzNy?=
 =?utf-8?B?WmhLVlp3aHZqSk5BcVo2VHVXdkxpRDdBSUZMYjM3N21HODNTSWhqREtBSnMr?=
 =?utf-8?B?b1RYNTNqRXNTcUVSZUNJeGxPOTR5Z0JoVyszUTBGZlo5S0ZxUjlvR0M0WFR2?=
 =?utf-8?B?WXNKeDdmUXdEcWg2bGpURG9tZTg5M2RFaXFycldPbmpUM1ltVHpIYlhSd2lh?=
 =?utf-8?Q?BZBU+szPjG1YnODoKlDaFKWHi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba62175c-6082-4c99-e983-08dd3bbf040c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 15:02:55.2905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x6MJfr4rtANnjrpvTEu0YFu/9gZSVcariPtWSA0pYFHfU1fuWaEcOsY4B0h7ZM5Lj90KfPfatWcWbmeZuoz2TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4703
X-OriginatorOrg: intel.com



On 1/23/2025 8:18 PM, Lucas De Marchi wrote:
> On Thu, Jan 23, 2025 at 07:24:22PM +0530, Riana Tauro wrote:
>> Hi Lucas
>>
>> On 1/23/2025 9:49 AM, Lucas De Marchi wrote:
>>> Add the generic support for defining new attributes. This uses
>>> gt-c6-residency as first attribute to bootstrap it, but its
>>> implementation will be added by a follow up commit: until proper support
>>> is added, it will always be invisible in sysfs since the corresponding
>>> bit is not set in the supported_events bitmap.
>>>
>>> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>>> ---
>>>  drivers/gpu/drm/xe/xe_pmu.c       | 60 ++++++++++++++++++++++++++++---
>>>  drivers/gpu/drm/xe/xe_pmu_types.h |  4 +++
>>>  2 files changed, 60 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
>>> index 33598272db6aa..5e5a9fcf30ace 100644
>>> --- a/drivers/gpu/drm/xe/xe_pmu.c
>>> +++ b/drivers/gpu/drm/xe/xe_pmu.c
>>> @@ -46,6 +46,8 @@ static unsigned int config_to_gt_id(u64 config)
>>>      return FIELD_GET(XE_PMU_EVENT_GT_MASK, config);
>>>  }
>>> +#define XE_PMU_EVENT_GT_C6_RESIDENCY    0x01
>>> +
>>>  static struct xe_gt *event_to_gt(struct perf_event *event)
>>>  {
>>>      struct xe_device *xe = container_of(event->pmu, typeof(*xe), 
>>> pmu.base);
>>> @@ -60,7 +62,8 @@ static bool event_supported(struct xe_pmu *pmu, 
>>> unsigned int gt,
>>>      if (gt >= XE_MAX_GT_PER_TILE)
>>>          return false;
>>> -    return false;
>>> +    return id < sizeof(pmu->supported_events) * BITS_PER_BYTE &&
>>> +        pmu->supported_events & BIT_ULL(id);
>>>  }
>>>  static void xe_pmu_event_destroy(struct perf_event *event)
>>> @@ -210,16 +213,62 @@ static const struct attribute_group 
>>> pmu_format_attr_group = {
>>>      .attrs = pmu_format_attrs,
>>>  };
>>> -static struct attribute *pmu_event_attrs[] = {
>>> -    /* No events yet */
>>> +static ssize_t event_attr_show(struct device *dev,
>>> +                   struct device_attribute *attr, char *buf)
>>> +{
>>> +    struct perf_pmu_events_attr *pmu_attr =
>>> +        container_of(attr, struct perf_pmu_events_attr, attr);
>>> +
>>> +    return sprintf(buf, "event=%#04llx\n", pmu_attr->id);
>>> +}
>>> +
>>> +#define XE_EVENT_ATTR(name_, v_, id_, unit_)                \
>>> +    PMU_EVENT_ATTR(name_, pmu_event_ ## v_, id_, event_attr_show)    \
>>> +    PMU_EVENT_ATTR_STRING(name_.unit, pmu_event_unit_ ## v_, 
>>> unit_)    \
>>> +    static struct attribute *pmu_attr_ ##v_[] = {            \
>>> +        &pmu_event_ ##v_.attr.attr,                \
>>> +        &pmu_event_unit_ ##v_.attr.attr,            \
>>> +        NULL                            \
>>> +    };                                \
>>> +    static umode_t is_visible_##v_(struct kobject *kobj,        \
>>> +                       struct attribute *attr, int idx) \
>>> +    {                                \
>>> +        struct perf_pmu_events_attr *pmu_attr;            \
>>> +        struct xe_pmu *pmu;                    \
>>> +                                    \
>>> +        pmu_attr = container_of(attr, typeof(*pmu_attr), attr.attr); \
>>> +        pmu = container_of(dev_get_drvdata(kobj_to_dev(kobj)),    \
>>> +                   typeof(*pmu), base);            \
>>> +                                    \
>>> +        return event_supported(pmu, 0, id_) ? attr->mode : 0;    \
>>> +    }                                \
>>> +    static const struct attribute_group pmu_group_ ##v_ = {        \
>>> +        .name = "events",                    \
>>> +        .attrs = pmu_attr_ ## v_,                \
>>> +        .is_visible = is_visible_ ## v_,            \
>>> +    }
>>> +
>> There will be some events that do not have the unit. The previous rev 
>> was simpler to handle such events
>>
>> Can the previous revision be retained?
> 
> that would depend on merging the first patch in perf/core or bring that
> define here.
> 
> I think we can live with the similar approach of other drivers above and
> in future try to add PMU_EVENT_ATTR_ID_STRING. However I'd like to have pmu
> merged in xe without depending on that.
Sorry, my bad. I missed that the core patch was removed in this series
  And if we simply add the macro
> in xe, it means it will probably stay forever with nobody cleaning it up
> later.
> 
> Also, what event are you talking about? 
The upcoming per-engine-class-activity counters. They are similar to the 
per-client and have no units.
There are 2 or 3 alternatives:
> 
> 1) add a unit
> 
> 2) add an indirection to the macro above to allow defining an event
> without unit. That's doable by having 3 macros: __XE_EVENT_ATTR,
> XE_EVENT_ATTR, and XE_EVENT_ATTR_WITH_UNIT. Then you'd have:
> 
> XE_EVENT_ATTR_WITH_UNIT(foo, ...)
> XE_EVENT_ATTR(bar, ...)
> 
> 
> 3) Ungroup the macro so the group is separate, then we'd do:
> 
>      XE_EVENT_ATTR(foo)
>      XE_EVENT_ATTR_UNIT(foo, "ms")
>      XE_EVENT_GROUP(foo, &pmu_event_foo.attr.attr,
>                 &pmu_event_unit_foo.attr.attr)
> 
>      XE_EVENT_ATTR(bar)
>      XE_EVENT_GROUP(bar, &pmu_event_bar.attr.attr)
> 
Yeah will have to seperate it out.
Sorry for the confusion.

Thanks
Riana
> Lucas De Marchi
> 
>>
>> Thanks
>> Riana
>>> +XE_EVENT_ATTR(gt-c6-residency, gt_c6_residency, 
>>> XE_PMU_EVENT_GT_C6_RESIDENCY, "ms");
>>> +
>>> +static struct attribute *pmu_empty_event_attrs[] = {
>>> +    /* Empty - all events are added as groups with .attr_update() */
>>>      NULL,
>>>  };
>>>  static const struct attribute_group pmu_events_attr_group = {
>>>      .name = "events",
>>> -    .attrs = pmu_event_attrs,
>>> +    .attrs = pmu_empty_event_attrs,
>>>  };
>>> +static const struct attribute_group *pmu_events_attr_update[] = {
>>> +    &pmu_group_gt_c6_residency,
>>> +    NULL,
>>> +};
>>> +
>>> +static void set_supported_events(struct xe_pmu *pmu)
>>> +{
>>> +}
>>> +
>>>  /**
>>>   * xe_pmu_unregister() - Remove/cleanup PMU registration
>>>   * @arg: Ptr to pmu
>>> @@ -270,6 +319,7 @@ int xe_pmu_register(struct xe_pmu *pmu)
>>>      pmu->name        = name;
>>>      pmu->base.attr_groups    = attr_groups;
>>> +    pmu->base.attr_update    = pmu_events_attr_update;
>>>      pmu->base.scope        = PERF_PMU_SCOPE_SYS_WIDE;
>>>      pmu->base.module    = THIS_MODULE;
>>>      pmu->base.task_ctx_nr    = perf_invalid_context;
>>> @@ -280,6 +330,8 @@ int xe_pmu_register(struct xe_pmu *pmu)
>>>      pmu->base.stop        = xe_pmu_event_stop;
>>>      pmu->base.read        = xe_pmu_event_read;
>>> +    set_supported_events(pmu);
>>> +
>>>      ret = perf_pmu_register(&pmu->base, pmu->name, -1);
>>>      if (ret)
>>>          goto err_name;
>>> diff --git a/drivers/gpu/drm/xe/xe_pmu_types.h b/drivers/gpu/drm/xe/ 
>>> xe_pmu_types.h
>>> index 0e8faae6bc1b3..f5ba4d56622cb 100644
>>> --- a/drivers/gpu/drm/xe/xe_pmu_types.h
>>> +++ b/drivers/gpu/drm/xe/xe_pmu_types.h
>>> @@ -30,6 +30,10 @@ struct xe_pmu {
>>>       * @name: Name as registered with perf core.
>>>       */
>>>      const char *name;
>>> +    /**
>>> +     * @supported_events: Bitmap of supported events, indexed by 
>>> event id
>>> +     */
>>> +    u64 supported_events;
>>>  };
>>>  #endif
>>

