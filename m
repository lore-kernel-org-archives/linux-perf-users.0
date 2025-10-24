Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CE022370D;
	Fri, 24 Oct 2025 06:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761287256; cv=fail; b=Dvm8Elhc8CQ9TABZjLfoQ3QQykZsiB0K74gNL8mSRA5SWnXtbOzHyqX/zMIc4fcHdcQvXXXFs/dlWYb9/cWuVMyXtLYGsohnOD2s7BCyYAaMsCiKEefjp7j6ooQmiuejalESOxmVWNqcUTTe1Nx+mgfSL9fIx93XOB51fJE79RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761287256; c=relaxed/simple;
	bh=cqusTmCdb7QIuIAl0QfmegO7uuR1nxeni+Wrgr+ei28=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PgUAxqC6ELMdH6rVAQ0mmQHfvRL/5Jvy11ja8K8b2LLtHSWnoFtOd7hHZ3qlFyVbEECoXPHBiZGUuh7VBZfbZlafAJ2W3bsJHz5enBuo4wuoKqW52GEdEJO5euDVIm7tfcH6BdhnliqiYdipFqb84RU1VY6iLAlX72oPAnm4Wbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MBNVtgO9; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MBNVtgO9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761287255; x=1792823255;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cqusTmCdb7QIuIAl0QfmegO7uuR1nxeni+Wrgr+ei28=;
  b=MBNVtgO9n+3fl73dTEK3P+gXF8XrSVhNqujjUcaOEkpKpurngffB67Ln
   U7AwPb0eXljLFu6haM9LlPjO6TPfHFDE5/N5fkLPFVRqeqBkbM5J1JnRn
   Aqc+ZJXV8yvWYw49A7z4p1NbTNdNqaQL7Upzn0xbSrnMpQUd5Rrmmtblt
   pUInwd77xIE0jw0+kQvNBiTNLe+0t99moCb2JBw7JqO8hdOxYuJ2MEx4q
   plcy/lJkEU/JUWEXYwnu9Sn60Aj7HLsYln61JeKDtpdjYwgjA0Go/nSWJ
   /s9hBUJxBGCHJGahmD1GS5daL7gYK7CTg4/wLx33HjA/2wtoJvIvck6Pl
   A==;
X-CSE-ConnectionGUID: iymwtjmZQPqhRccl0rqUIA==
X-CSE-MsgGUID: mMXMM7fRQoC9/bmlc5/y7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63505737"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="63505737"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 23:27:34 -0700
X-CSE-ConnectionGUID: TDpOYWAUQHaeHKl24/ZURA==
X-CSE-MsgGUID: z+v3ik0dQCWoe4iwhh14EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="183579882"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 23:27:34 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 23:27:33 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 23:27:33 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.32) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 23:27:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0+7UYUDsLXqR8oFb8P5vCPZMjb5yooqllJ4Vk8h72Uytc9mbaXmhBPvdbISzvXX6fz2zuvyFz+ZmMj1Ezht+rv7UjDnajbcKXuIGzeN1XJr+VhOE2nmRL4QtGdLYqAgH+0L6ugCCegVEtMBm3HMONtXvX/lL6vpFlbWE0Kp2oanrw/8Kp2lKdLDymairpeDjMXm11pAZynW/lwTaB73tXF6KYXhMrHm5LB/ckAAlUVhjoiBLEB7eXOCUM96uBIEeOSxJAdgfBZSMo/AkNLXeg3rEHErzGX+Di3gMnSzMKlOHUjpr8WjfxxHWu1aFLOPKypZWXg9R4gW8OhOItzgtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vH1DfstfVLBPA+ro/2/uh2z9wln5mohoDRnyTm3neMc=;
 b=ZkNGP6XzxXgHsfRzesjMhA3XzzUTZhc1cD7Aix3oCPrj4iKrZHGnlV+SWIer0T14el2H/0qHavrQCGKD6sg7r0NcS0KEOqoywa9x/NCyR99omr/W7F9rfmHnJfQ8CDmU9W+FaT1fgCTskaSlUjEuaei3wl0ATxrhOEtCNlRDFMAKM7R7mlhlmFHsJFbPC7DOOZ13AWLynit/oua8W/XKiUT8dXMJPgjO0gqkVX8JAk5HrYFKHrGUPiPGiDFqH/r34ddltWbhh0Ned5FI5lLLvOGzfMvfIsibb/lFDnuies5c3z3ZTBuzS+zzleicLAzgx8bayIlXtBgne24Hj+rdeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 06:27:31 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 06:27:30 +0000
Message-ID: <22b7b11e-b1fe-4d9d-8749-afe57ea1c35c@intel.com>
Date: Fri, 24 Oct 2025 09:27:25 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf arm_spe: Add a macro definition to handle offset
 value
To: tanze <tanze@kylinos.cn>, <james.clark@linaro.org>, <leo.yan@linux.dev>,
	<irogers@google.com>, <john.g.garry@oracle.com>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<graham.woodward@arm.com>, <mike.leach@linaro.org>
References: <20251016083019.27935-1-tanze@kylinos.cn>
 <20251017021540.45930-1-tanze@kylinos.cn>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20251017021540.45930-1-tanze@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0081.eurprd04.prod.outlook.com
 (2603:10a6:10:232::26) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA1PR11MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: abbe1022-970a-4840-a39c-08de12c668bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHJxMStHZVBnRlBITnI1RlBpMXJVOExtVEkvSHU1NWd1Vnd2UmRRVHV2QWpT?=
 =?utf-8?B?dElxSGJFU2oxTmkwR2FnYzVJRGxjZEU2MGJaWE94ZXFobzJ6bEdoVGtQQk8w?=
 =?utf-8?B?VXQzZFVqTnNBbFIwdkVMbGs3cDMxWkNscm84SUdpRE82M2JteUVESURZblN6?=
 =?utf-8?B?ZXd4aFZaUU52dmQ0UVFMQldBcHRGcHdCOXpYYTlSNEY5U3J6NThkQXF4bTNL?=
 =?utf-8?B?QW54bWc4U3ZGWUdQTWdWZmxoQk1sVzVnSjdSSlA2Qm1tSDBYRDJNTWgwTjdj?=
 =?utf-8?B?SlJVZXNpYk52eVBSOWd5YjAwS0R6WWdrSmQraTZmUXBIWTlPTEs0M0tJK1Rx?=
 =?utf-8?B?M1ZWc0VCcVZNdE5HL1ZvZmxNbnVCMjRRbjJtQklqdUwwQXM3Mk5Ma3BIa2Nv?=
 =?utf-8?B?TGRBR0tyR2FFUThnb01WZ1BtejhuUnF0YjJYY2s5c1NveENDN252VnBwZk51?=
 =?utf-8?B?TUthRE5jbnd5K2dPa2wrNmZUcndPL2M3VTlaSXNTbnE5Syt4ayt1TVdyVGtK?=
 =?utf-8?B?bHhRRUNwUnpuelBERDBQbUQwUFhiS0Nhblh6NUV3b29mcFdPZS9OYUYrYXor?=
 =?utf-8?B?elBHbHQ0eUwyc0padmUrWkcyNkdxYXdDQUFPOUFvcDc0LzdpOXl2aEkzTmVo?=
 =?utf-8?B?ZlR4MzJOVnRGK3dNbkplVjlPZU5TR3JHNEdwakkrK1RsZVl3V2Nva2szN2x4?=
 =?utf-8?B?VUtvR25jM212ZFVhWkY0MGtCc0M5YTlMVjBZb05NaVk5R0ZLVGlOaVdJZWtF?=
 =?utf-8?B?cUFnZDR1SGoxbEx5WE4xVjdXK3R1NFBRMU5QeXRvVjYyUzduZ3ZmWmtQaG16?=
 =?utf-8?B?dlgrQlViNjhtMXg4c1hTbHR3NjZ1UlJubHJmZ3UvZ25wRzJJTHdob3Z2V1pl?=
 =?utf-8?B?TE5rcHZQR2FJNzRjQk1lYWJWQ2xTZVpPRjkvdFFJUUYzK0RxUXlGWmY1dFFj?=
 =?utf-8?B?Vk02b1JsSVJkU21jQ25QK2tNZlQwR21US255ak96b1dqeVVJRGR3U2U2TEhB?=
 =?utf-8?B?WWFMVy8vT3d2WHpTS3REMy92R3RIR0EzSjlwZncvNXpaMVhhakFvYVM0bDFx?=
 =?utf-8?B?R0lKR3FBaENqMTZid0ovS1kydDMza3JvOXlvR0ZycDZmN1JlM3B0eVlJN0w1?=
 =?utf-8?B?UGQzaGl1cFYxVW8wdXdWOXFuS1NYMzB1MzNOeUNWOENBd2twS3pTa1ZBYjAy?=
 =?utf-8?B?MTJuZ1ZXU212d3FKREl6SndiZWZkdjY1QlBnbTJJaE9OYTNiaWNZRkFVOGlL?=
 =?utf-8?B?TVYxRDExdUNBWWU0azc5dFU5UFlDeHVLY0k5YTliS3dTa3BIWVpHbHlkakFZ?=
 =?utf-8?B?bU51Smo1THhVcTBQYlBlN0Y2QzhJZVRDSVd4RHh4NXhFSlJ6d0ZCbEVZSFR4?=
 =?utf-8?B?dUdkR1FLaU1HOE1VMFVWNmNxMXlEU1AyNnpNcTZxaGZuVU1YenFidGtBQTdX?=
 =?utf-8?B?ZFgzdFNYZzFsZXlOSjZ2N3kycTVQaFVVdHY0YVZYRytSL0I2ME0yL3RwUnll?=
 =?utf-8?B?cUVqNWJ3RFpDZHdlZkdIeVNENjlWaW50UHo3K1BwZGplK3ZVNVZEbGowOUdk?=
 =?utf-8?B?MHR2WjZrZ0F4czdDMVBxL2szOHR5dDlVOGlwcjlhU0N6ck5MckFVenZnbXZG?=
 =?utf-8?B?MnFTaDBOa05wQ2djUnMwTVlUUTExYTBGWXl1cE5LRkJ0MlhKaWhOK1RBL1NR?=
 =?utf-8?B?VTZFWjhRMkhTc1pBU293Q1duTUM3dkMxZWdlaGE0MEYrb1VVdlJ1UnJsWm9v?=
 =?utf-8?B?R3FxYWJMTEdKSk1ZaGk5SDZXNFhNN3R0WHViS3ZNdUNKS3BtWDlOQmprWklw?=
 =?utf-8?B?THBybGVoZStDVkhleWRGMEtOY3g4aVZQR3BFSkdXSDg1VWZydHBKUFIxVi9P?=
 =?utf-8?B?QlZkVytSb1FJcGZOdXpMaElGSmJMQm8rNmRGOXoxRFhoemdvZHNiRDdsMWNr?=
 =?utf-8?Q?npind0FW+EozwUuzaRzrfFKnHD4UHAW6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUlxRHdFaTlBSGhIcWxteEhBZ0xsMHk4MkNYK2M5NTF4NUFOdHUycDN2RVhh?=
 =?utf-8?B?eDJNY250MHV5T2UzaXVuOWVIOVN1cDBXdEpnczNCaStRNjk4ZktWL0ZtbkRG?=
 =?utf-8?B?WmFDbU5BbDdqNjBzeWZ4NWNOVEVkdU1Wb0hEdVpXaFJrVVBHaHF3d09oNmtj?=
 =?utf-8?B?M3JQMHBUNmxnSXUydDM3MjZ0bGw5UHYyM3FnZjlrcmRwL3kxQU5rcWozUkRt?=
 =?utf-8?B?YWFUempLTUZDTzRUNnl4UGNDaWVqSDlGUGNLSHFYNTAzYURCZGVVNEJoN2ty?=
 =?utf-8?B?NkU3UGdaWk5DaWZLMDBudXVQZjZVcDRkbkVtbDJKcWxoUE5meUs2YWhkZWtk?=
 =?utf-8?B?aGQ1clpxQ3dWbzJjNFRIWDA5UzVEUlB2M0lsV0c0aDY0TGhxYXhwalhBTnI3?=
 =?utf-8?B?dEpQOEo4MWNCMDdON3dkY2VvcW5WcEVOdU51U3doMnJBMXVndEpiZkVTUndR?=
 =?utf-8?B?YVkzMUlIYWhBSm4xemhjQVdOeHlmUGlNb2dtWklOZ2dkdXNLb0JMODllU1lk?=
 =?utf-8?B?c3d5dE1tKytuYkI0Skw1VjU0dmphNUFKZzFKTXFHTFlQRjhnekZQTEFXaGZi?=
 =?utf-8?B?OGNUMEVzOUdrK1JObm9pZExZeUtVMTdiRU5wRklkTGZIRUJUY1Fva0xxNXYw?=
 =?utf-8?B?S0V1d1NtM2ZQcDI0TlpXQmFZaWZyV0dzdWJaQ215SGdCOTBPRHZnNmYxOUll?=
 =?utf-8?B?NmttSnFvK0VSdHV1UUtXY0t4bDd5RXVvODhLSmsvZFVpa2ZqU0pnY3JkdzJP?=
 =?utf-8?B?bXNaU2FOeXZMZ1ViQ0lNakJuWXQ3U2lnaThwdnpRbUJERlgrL2dJcURJejcr?=
 =?utf-8?B?aVNZc3czRHhXZnJYTVNSYkhOUVZSQWpmRkdOYm92NXY5MlpHMHZDNjdaSTg3?=
 =?utf-8?B?VkpDNGwxTVJGeWJINVN2OUtYSlRXV2pWc2F2d0F2RWVsYWx6cGVXRWdTcDJR?=
 =?utf-8?B?d2dQNk5nTDZERjA1OElad1BGaDdBaGxIOWJ1Y0Y0MW4rSVZlc2dQMHNmc1Jz?=
 =?utf-8?B?QldrS3pCUlF3c1B5RU1COU9PTFgrL2NJZVFJeGZXUTVOdEF4VXpiN0RXaTB4?=
 =?utf-8?B?eitBQzl3NmNielMrdzZqQzd3RGNvczQ1MjdzQ2wybHlRWHhjbStzWm16S2du?=
 =?utf-8?B?ci9wSTRNWTdZUFZrRjI2bWhzLzFrYThJNnJ2bEdCSU41N0NLd0g2T0lNOUVW?=
 =?utf-8?B?cFpqMW0reC85VnowWUxudU50ZWlrRnFqQzNlK2lkdmh2WHVzNWtaZmFIc2xm?=
 =?utf-8?B?eGlycGp2ZXlpUFNCWldGQWxpMTRSZktLV1FKRzhjOWNYdDJHRk5RWlVhbk9C?=
 =?utf-8?B?TGtPYUNtTlpnbm5qcjh2aGc2eW9tQTVtekJNUjEwUkZmSW5FRUtKUVNlamFY?=
 =?utf-8?B?bWV5NzZQZTBiNGMrZGFQNzFrSVBNSEVRSlJHMXl6ay9Jck1DNjFXcDdxMXJO?=
 =?utf-8?B?S0g5YXJiVm1aZW1vSmFZMUhnbXJQNHhCSit6RGViZnNjL1hrNmNiNklUQUQx?=
 =?utf-8?B?Nnl1bkI2THVzcVRFUitZRTc2SXhZaENXckczMVB6MVF2SFRpUkJadjdHbDJt?=
 =?utf-8?B?a0pDOWY4SFVXOFE5eXpQZGVHVXlhMTloL01FOUFTc0g3aE5qaEk4cXpHNE80?=
 =?utf-8?B?SjN5K2tBNFExRzFXcUtYU3hHSXpvM3d0QzNFUFJ0aE9lb2IxT29pSzVIUVpP?=
 =?utf-8?B?b0RKbThUSGxnR3VUVzRpYWt5Ui9ua2RicW1Xc2JndVNubWlnclJ3ZlBHeTF0?=
 =?utf-8?B?WWRBQTVTR0oxTzRiN29vdnY3a2FxYnprU3hGdHdsYWpYL0dpZkJXa05QUDVy?=
 =?utf-8?B?L3hsZmI5YlVsYmJtQ3YwUEE3cEF0cHA0U3AxTUdtQTYyTklGaWtYL1ZnQUU5?=
 =?utf-8?B?VlRIUWFELzMwb1hRMWc2L2tnTjRYM1BMMW82VXFHY29nVHZpVy81Uy9vT2M3?=
 =?utf-8?B?MndvWEw0d1ZzNFJZL3NFZWRtelF2TGxFdkFNY25jQkpuQm1vN1FUK0RRK2RC?=
 =?utf-8?B?cnFhNnpRejRCSWZoWWlzL2dEaEFnUFZOcFR2NEZYckFTbUZ3d081a0dSbDlG?=
 =?utf-8?B?ZE5iQk9hdy9lRFFjbHRQUWpCZUlMb0V1dXQzOWROdkQxRk5wMDI5c2FPN0d1?=
 =?utf-8?B?TnZmNFpqem12STczSFltdm9PR2NDbnBCZVJ5WkZ1UmNYb0l3aTh3ODFhTllP?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: abbe1022-970a-4840-a39c-08de12c668bf
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 06:27:30.8918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zyL1XFkSbxPAwo4xmmmvxQSGCe0st8jmSJKgomyXZs5Zm+IOZTsZNQ/vdCrSi4oobY7EkP9OIlclK8GWpDEbqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6734
X-OriginatorOrg: intel.com

On 17/10/2025 05:15, tanze wrote:
> Add a macro definition SPE_SYNTH_ID_OFFSET to handle the offset value
> and improve readability.
> 
> Signed-off-by: tanze <tanze@kylinos.cn>
> ---
> Hi, Leo Yan
> 
> Thank you for your guidance and suggestions. I have made revisions according to your requirements. 
> Do you have any further suggestions?
> ---
> Changes in v2:
> - Migrate the macro definitions to the synthetic-events.h file
> - Add modifications to other source files that use the offset value
> ---
>  tools/perf/util/arm-spe.c          | 2 +-
>  tools/perf/util/cs-etm.c           | 2 +-
>  tools/perf/util/intel-bts.c        | 2 +-
>  tools/perf/util/intel-pt.c         | 2 +-
>  tools/perf/util/powerpc-vpadtl.c   | 3 ++-
>  tools/perf/util/synthetic-events.h | 2 ++
>  6 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 71be979f5077..b082cb1666a6 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -1732,7 +1732,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
>  	attr.sample_period = spe->synth_opts.period;
>  
>  	/* create new id val to be a fixed offset from evsel id */
> -	id = evsel->core.id[0] + 1000000000;
> +	id = evsel->core.id[0] + PERF_SYNTH_EVENT_ID_OFFSET;
>  
>  	if (!id)
>  		id = 1;

Functionally this is to find a free range of IDs for synthesized events,
but also the range can only have one user e.g. in this case auxtrace

So add to auxtrace.c

#define AUXTRACE_SYNTH_EVENT_ID_OFFSET	1000000000ULL

/*
 * Event IDs are allocated sequentially, so a big offset from any
 * existing ID will reach a unused range.
 */
u64 auxtrace_synth_id_range_start(struct evsel *evsel)
{
	u64 id = evsel->core.id[0] + AUXTRACE_SYNTH_EVENT_ID_OFFSET;

  	if (!id)
  		id = 1;

	return id;
}

And then use that:

- 	/* create new id val to be a fixed offset from evsel id */
-	id = evsel->core.id[0] + 1000000000;
+	id = auxtrace_synth_id_range_start(evsel);
-
-	if (!id)
-		id = 1;

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 30f4bb3e7fa3..46902f7b69f1 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1726,7 +1726,7 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
>  	attr.read_format = evsel->core.attr.read_format;
>  
>  	/* create new id val to be a fixed offset from evsel id */
> -	id = evsel->core.id[0] + 1000000000;
> +	id = evsel->core.id[0] + PERF_SYNTH_EVENT_ID_OFFSET;
>  
>  	if (!id)
>  		id = 1;
> diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
> index 3625c6224750..98b928eca724 100644
> --- a/tools/perf/util/intel-bts.c
> +++ b/tools/perf/util/intel-bts.c
> @@ -777,7 +777,7 @@ static int intel_bts_synth_events(struct intel_bts *bts,
>  	attr.sample_id_all = evsel->core.attr.sample_id_all;
>  	attr.read_format = evsel->core.attr.read_format;
>  
> -	id = evsel->core.id[0] + 1000000000;
> +	id = evsel->core.id[0] + PERF_SYNTH_EVENT_ID_OFFSET;
>  	if (!id)
>  		id = 1;
>  
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index 9b1011fe4826..4fb9600a7369 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -3987,7 +3987,7 @@ static int intel_pt_synth_events(struct intel_pt *pt,
>  	attr.sample_id_all = evsel->core.attr.sample_id_all;
>  	attr.read_format = evsel->core.attr.read_format;
>  
> -	id = evsel->core.id[0] + 1000000000;
> +	id = evsel->core.id[0] + PERF_SYNTH_EVENT_ID_OFFSET;
>  	if (!id)
>  		id = 1;
>  
> diff --git a/tools/perf/util/powerpc-vpadtl.c b/tools/perf/util/powerpc-vpadtl.c
> index 39a3fb3f1330..5ce5d2bf4c6c 100644
> --- a/tools/perf/util/powerpc-vpadtl.c
> +++ b/tools/perf/util/powerpc-vpadtl.c
> @@ -15,6 +15,7 @@
>  #include "powerpc-vpadtl.h"
>  #include "sample.h"
>  #include "tool.h"
> +#include "util/synthetic-events.h"
>  
>  /*
>   * Structure to save the auxtrace queue
> @@ -656,7 +657,7 @@ powerpc_vpadtl_synth_events(struct powerpc_vpadtl *vpa, struct perf_session *ses
>  	attr.config = PERF_SYNTH_POWERPC_VPA_DTL;
>  
>  	/* create new id val to be a fixed offset from evsel id */
> -	id = evsel->core.id[0] + 1000000000;
> +	id = evsel->core.id[0] + PERF_SYNTH_EVENT_ID_OFFSET;
>  	if (!id)
>  		id = 1;
>  
> diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
> index ee29615d68e5..c8a1fe7a3fa4 100644
> --- a/tools/perf/util/synthetic-events.h
> +++ b/tools/perf/util/synthetic-events.h
> @@ -39,6 +39,8 @@ enum perf_record_synth {
>  };
>  #define PERF_SYNTH_ALL  (PERF_SYNTH_MAX - 1)
>  
> +#define PERF_SYNTH_EVENT_ID_OFFSET	(1000000000ULL)
> +
>  int parse_synth_opt(char *str);
>  
>  typedef int (*perf_event__handler_t)(const struct perf_tool *tool, union perf_event *event,

