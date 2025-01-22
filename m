Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B681A8419
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737541435; cv=fail; b=HbeRNZ3a/e0sX+kvKUoXeuSOs9O0ahoLMMkXjD0uB2IoTk7UniDrEAOi6/Q42L0rcET4fb+VwPUt4w/hnAkf+ydj3qUxcy2ui2PLzKN9Bi3S4XzNT4Pf12W2sIz8RhYy74SenwzmBu+VaRNXTRWOsJf1kybGUmY8dOyiXnsNjVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737541435; c=relaxed/simple;
	bh=nzg06hWwFTj4CpapNRBm18cD8n5C0x6gfaYU99KSj1o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=psgFvrzzsIlnFfviCPXawMMosOx1Ui/GMFGQ4/zQpfcbb2WT5j2jOU+dlWFlJa/HJr1EphaK0qynGIM7UBcehgDcj/2zzjeZfOagCC7iKD5gV/WNn93t/OC3KvjG4g/7ESbbR3AELVyr5AvfYvo/nuEhOw07H8wh++gE1k79sdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gs0XyA9p; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gs0XyA9p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737541434; x=1769077434;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nzg06hWwFTj4CpapNRBm18cD8n5C0x6gfaYU99KSj1o=;
  b=Gs0XyA9p1rJOB8+hhW5a2N/AxW64qL33s7/To70LVh0ivmjaPZx+JQ/H
   WTYHknzaciTwN/y78ApKk5rD4QFPmExOvBhiUAuLECMh9PDvzQAfavuPx
   0Xmz6jvLv4zhaBkQVZ0a4NP5y/txqM9rgIWLTExtxy6sur2KBJeRBtG+4
   ZG7Y6AskDG2DBWZYMtaY6JoaIycc24iXeBiRFPvZLF/xzopXnqREBFG7v
   pASbXMGo31OJ+ltELB5XfRTGBAH7zG01xcl9M6nVVekKYtVsh4/L8TtE2
   qS/tPQcLI0AX/swtiT7p69tF/Ro05kGHVDDa6ZwtxRlQyA/mJo971oi8R
   A==;
X-CSE-ConnectionGUID: Em28Syq0TIeTBJC9M44l+A==
X-CSE-MsgGUID: WXq6KQS9S7qI3wkBoWeufA==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="38142591"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; 
   d="scan'208";a="38142591"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 02:23:52 -0800
X-CSE-ConnectionGUID: XGeK3cv6S6aiGoc2s97pFA==
X-CSE-MsgGUID: Oqra6Ks2SUOu55m8hPnORw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; 
   d="scan'208";a="107202660"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2025 02:23:52 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 22 Jan 2025 02:23:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 22 Jan 2025 02:23:51 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 22 Jan 2025 02:23:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHvcT8C25b6IOPdPgQwDdwt8RgxpdkPZ4rK0jaChE9txiPBudwYfyUkkcq1FUtIwxd6XFEVyNsx4SbgmJDx160n8Utp3rPtP4bgnXm5XzyW5E4ynoS8XjkWLwRWWrsnzSKkW8JZ3g7kb00SXzQ+UvgIMJQCkPquJ94U1N01CZAsTRowAZtrF9EDwdIBW3gAjI+adlNLzQDuK3uiKzOU+55kfcJYiZC3VL2TSU1pX3u999DHQBzGP644cJQhw0SH7SjNTbEnHSq3yB875df4x+CRHcwNE4Fqcs/KAbOA7RXO+dzr5zALhFpHncfjTCP9dKVuPROLZwpSYS1QDM+gkKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+mFT7Y29tyGJb9QvQqBES21o32d+x8/Ly09EplxRAc=;
 b=Yvme1+OWEHNbkcm6gaI9MwfyrPRf5F2D6Zwg+TnhKK0p30plNLRhQJ3K8PjkET4ZPeGIn/r+IW1UmBPwKIzGsY7k2sR0eb4dnrUK0O8fcrZ5EMSzZYK4Hw7iPFR9KeYGFI9IyiSvoybjDSvspAFMcXeLdP/z/DGa1JnCZ/b4sIp0fDdcvyOi2WGU9Qi5PrAOMr5wsLnDg/m17GVQot0zUUx8EzDnauYL47GSFiPXbCS74B4C/r0jLCyEV2AB6zlZ7qNAL9VPBH93NhhXISSi8xB/QK1kmMM6SGcVN2DVyGtW8VpiemoaHRJBN+hF6h6+z8SJm+g0dt1Ns909HDyCuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 PH8PR11MB6753.namprd11.prod.outlook.com (2603:10b6:510:1c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Wed, 22 Jan
 2025 10:23:07 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::d3ba:63fc:10be:dfca]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::d3ba:63fc:10be:dfca%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 10:23:07 +0000
Message-ID: <487360a2-39d8-4219-aade-fab3385ace25@intel.com>
Date: Wed, 22 Jan 2025 15:53:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 7/7] drm/xe/pmu: Add GT C6 events
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	<intel-xe@lists.freedesktop.org>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>, Vinay Belgaumkar
	<vinay.belgaumkar@intel.com>, Peter Zijlstra <peterz@infradead.org>,
	<linux-perf-users@vger.kernel.org>
References: <20250122062341.1100173-1-lucas.demarchi@intel.com>
 <20250122062341.1100173-8-lucas.demarchi@intel.com>
Content-Language: en-US
From: Riana Tauro <riana.tauro@intel.com>
In-Reply-To: <20250122062341.1100173-8-lucas.demarchi@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::10) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|PH8PR11MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d05f01b-185e-40ac-a863-08dd3acec348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDFXTWsrNHNObk1IaXFxMnp2NU5JVlJwQ09Sb1JDOEcyRG5OQzVlZjFxU3Ur?=
 =?utf-8?B?MGNHUlNWdlE2TFV3U3grN0hzOWNpRDhyMGlwQ21RQU4yVDg5ODdNK1JsamMv?=
 =?utf-8?B?b1RndUJtcTFIQmhNVzlycmFUczdWRTkxMFFVN2hzdi9USGpqWmw2L09rTmZV?=
 =?utf-8?B?R3p0eHBQYVgwVmZwMTNnbTI0RjkzYU5PVm8zQ0lhbFd5T3lTT0tubWNMUzRa?=
 =?utf-8?B?OHM5cVlaL29VODdkcSt5WndQdXJVZkdrRU5ya05ZZTc4NDMwY2NpRkdQMUdt?=
 =?utf-8?B?M2VzdVZjMWVKRUlQSUlkY2Exc0trR0VMeHdCUVpBalU5Z2FJc3MzM1BmUTJV?=
 =?utf-8?B?VVNZTEN1SUJKZ3VTWUtkKzJpVlJCcXora0NnbS9OSDA4V25Sc2JscnZuUU1O?=
 =?utf-8?B?TzNvNC9YaGNtalM3MFhlVWF3VVBBWDVoVmEvMFJ0Wm9LUFhpUlQ0TURsa3Jy?=
 =?utf-8?B?YlF4VWRVUlg2ckNkQ3RSeGZPUEs5RURUdjMwek5NUEJaOWNkSzJrVkNlbzA4?=
 =?utf-8?B?MHZZbFFzTVc3Y28vTHVqVzc0T01xdFIvQnRmSjY5RW1PYzFvcnVIWEcxaEpY?=
 =?utf-8?B?ck4vRGJOTThKR25XOTYxY2RQeXA0OStVeU5jNS9yYVNIZFVRTkRpZkRHUXV6?=
 =?utf-8?B?Z1RsaVhyMFpneXhMUVBobm9qKzZsQU1hNkpjeHZDNldVZjFyZ3hWZm1ydThD?=
 =?utf-8?B?SG54aDB2bS9qZTVUNlRPc2ovZ3JuZGZRQ3VvdVAyZEJXRDZPbGlYWGEyN1ZH?=
 =?utf-8?B?UzR5VHRZMGE1TTR1VnMrakpWQ0YwTWtWZGNkUldTNTc0YThMQ0RjS0pSRXhM?=
 =?utf-8?B?cTY5cUZlZFFxakt1M0RWbFJXQkp3TldQdGtYSURqTmtCUTY4UjF0Ky9OWEpM?=
 =?utf-8?B?WkZWSU9YS1hqbnFIZ3M5UlVpd3VZNHN0NmJtNmdBdHVUdmpPZlhTaGRtaDhX?=
 =?utf-8?B?NjRhN3RXS3Q2SEpZUUdyYkdqL1ZERGc1a3NQbGZVMFNaZFE2ODdFNWphV2Vz?=
 =?utf-8?B?ZHFvMzJJdE1ZNGFWdHduUXo4M2JkcUJ6V1VDeWs5cGRrcFZ5QlFrSU5nRUFz?=
 =?utf-8?B?M2VJdjFxdFBVWU9EZkVheXJ3TTdieDF0MWF6dlY4WHpNYy81N25vWHhhL3NL?=
 =?utf-8?B?a2xqenhxSFhBWncrTjRZQVdNSmdHN1psUGNWWXBJYStlVXAvZmY0dS9SeUhX?=
 =?utf-8?B?N0gwaUdianhRSWIyYWVoY1JRT3NLeTlxN1BDbkVwakFDeE9lcGJ5RWo1dzFz?=
 =?utf-8?B?UTdVTzMzbXBzMk5YWkRjWGtiblhvd0RBMEFsUkhha2UwekVnSFRQV1Nac2o4?=
 =?utf-8?B?RFFrSHpBMkJrSzRSb1k0bVlvS1ZwN1drUnB2L2hRS29lcEg3d1hOZDQwU2JL?=
 =?utf-8?B?WFBmaVZMaDI5VFBvc29iVjUxV2p6Sy9mcjBVOERnRTAwaldrbS8yUVRYeGxN?=
 =?utf-8?B?bjF1Z05zVHBVcnlOUWJLdEt3Y1RndzkrcjU5RmtUVmlrNUFvdWwxZUY4UXEr?=
 =?utf-8?B?MFVEQ09qd2lWbXQ4U3M0ay9ZNnRGNVBSTnNLMXZWY1VHenpuL3FsdXJ5UDZw?=
 =?utf-8?B?R3FmSXlBdXRnNm1KOURrelpua0FhdEFEMzc0ejBCM3hTeWw4RTloN3h3VFI2?=
 =?utf-8?B?T3ltU2JxT1g2Q2FoV3EvVFRrWjVvZ0lqbnJEUUliQXpmOHJWazZzTmRxKzFU?=
 =?utf-8?B?Y0Q0a2g2N0FOakx5eFJVRjBxVGRKYjZiSUZDb085QWlEV3N2VG1TaDN2T2Er?=
 =?utf-8?B?MFpJa3hnVWE2QW1VWVk3dnBJMzF0bHFDOElIMW42bnJFeXcyRjFTTDFHdXFP?=
 =?utf-8?B?T0ovbStVV0JXTUttaEY4MUp5TWZTUVJYNmt3T3pwck1lWUx3QjlQL1V2aWJV?=
 =?utf-8?Q?yieMUvONkvY0T?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjllV082TCtPa2ZDREhuYUpvR1lsUkZiZmtGTHh4MCt2Q0NrMVJGQUMzUmxG?=
 =?utf-8?B?aWFYU2VQbHdSQ1RhQUpKQzRYRFlSNCtzNUlvRU9JdENvbkhCbHZvaUJaOVlT?=
 =?utf-8?B?MGFLdk1CdHJxcUgxWVRLTnZYR3pNUFFnVXExblREb0I5TytFSUhDN0h2Y0Ra?=
 =?utf-8?B?Z3ZiNE5HRENDNElSc3RzZnprVkVxVTNFQ216MEU4aGdwTlMvUE01d0IzOG03?=
 =?utf-8?B?Q1ZFMnNOS3hhR1gyeC9veXhGbGhtWUpDL0UyUUltYXFsQ0UyUTlSNzB5cnU3?=
 =?utf-8?B?cFBJUkZmNlZXM2hheFp2VjFTMkpxZ2FGWmxiZ0JLeG56KzRvSWJRbDRjRzlL?=
 =?utf-8?B?VTBKb3BtWlI4ZWFBYzZKUzNZM0tOMUlwTzN3dkFqcHpXM2FsN1IzVXRXUEt3?=
 =?utf-8?B?L2JsZHlYeE9KdkRVbWsvYWxxbUlGMEsrWXMvYVJSWkxEU2RwNk9HMVpaRjlH?=
 =?utf-8?B?WWRJLzl0SWxvMXdaQzN5V29hcCtVZWUzZGFHYi9xNHQrZ3ZXMjJQcjJ3R2R6?=
 =?utf-8?B?TkUyUG1LK2Z1T2FiWEFUNEozM0tpQmRrOFB3UCs5MkdqVjg0b1FkR25uR3U4?=
 =?utf-8?B?SmpNa1hsZ1I0YXRRUkZMdURwZGs3dzd0cHE2SzdOelBtVTRCN3ZHTHNkaVFo?=
 =?utf-8?B?ak1HeE5zQ1ltQklHQXZ1bVhnc2c0NDZHQ044SWptWmxwLzNsNEVZUWljcTg4?=
 =?utf-8?B?dHhpMm9BcFRMWkdXVG51ZzJySnZCMmJjTmZQcEdtLzFhaWJEVFVnb1puWE5L?=
 =?utf-8?B?Y3YzdENSNCtQMXBrZk9Ea09Ib2VsK3BJcjY4VjRZQ3pWaS8rWWd4RjdldWpT?=
 =?utf-8?B?Y1ZyZFFpSXlRQ3RXR1RVY2VOK3RwWDBCSUd6S0J1Mi9SWWJjQUlQT2hsZDl3?=
 =?utf-8?B?TWRjVGYwb1piTlhCb1huVmFIZ0dVMC9RYyt6b2N1Y2RQbXZBMVZqSzRQcCs1?=
 =?utf-8?B?VytKbU4vb3ppZDRxSldKb2FBOW1LbWFleHFRa2RiZ2I1MkNCaHNvb2VhcGxN?=
 =?utf-8?B?YWt6a3Z2WUgxc3pkNFdSR085c2RNditXQ01GOXUvSkc3WWtqYm1XdlNscjhx?=
 =?utf-8?B?SUFvdDZqVjhEVmx2NlNaajZadFVpU2pJaThNUkNxT3BCUzB5NndKWUpkc1J4?=
 =?utf-8?B?RnpMMHprc2lmMk5IQktRU050RU5vcW83REFqR0FzV1ZVam51Y1BFWEcyWHBC?=
 =?utf-8?B?NGNpUzIrcFhFa3NMWnBQaXZ3cW96bEVsKzBrOThmcFRmMFl6d2FDbXVsRm1L?=
 =?utf-8?B?Y1B2MndxSUJnV3VwK1NtQmNzeFFDNkpYZVlEZmZmbDU1NWJCd21sR0FLNTUv?=
 =?utf-8?B?ejUvQ1J1dk4zZG1vS1kzdms1VTFQM0tSbFBSZEVNR1pjQ0VrNHA0OWlmQ3VI?=
 =?utf-8?B?TE53OHluUzdzZ3JNQ1JZYStXTkg0ZFZhZ2RYbUN4bkVIc0ZaakN5TFFkV2ZJ?=
 =?utf-8?B?elU2L003emhySXhYVmg5dHZwSERsVE5lK2NUWEF5L2hmaHptdzRFOWQ0aDAr?=
 =?utf-8?B?dW05c0NPWmFHVTc5dWZwbms3YzFFdjBoZm16YnI2RUxxY1ExRnRpVS8wTVpE?=
 =?utf-8?B?VXN5UVFHL0FoVERRRWtFNklCY1lvZXZKTWIzTk5OUkM1RXM1c0N2QTV4cURL?=
 =?utf-8?B?RFFnd3ZlaGhHdVZFY1JzQXdTV2VqVE1yK1dFUG8vQU1vR2s2d2ZCMzIxWUhV?=
 =?utf-8?B?R0p2RmNjWGdkSjRwa1Fac1N6aXoveVo5VmREREI4Z2NLckhIQ2VmSE4xZTFL?=
 =?utf-8?B?Z09wTEJtWWZSYSs1YXcyOFM5TGRIb2pHTGk4c2MzdEtSU0ZsM1JTWWh2VVB1?=
 =?utf-8?B?dUJLQ21hOTd3REtVMHBSaStJNTlYbzdJN1lXY1h1WjZJZ01kTmJDS1lrUlRY?=
 =?utf-8?B?S1hBbnVGVnNnd1QzR1JIZTBEWnVkdCtObGxCT25ITXRMdDY2OFNLZnh4N2Ra?=
 =?utf-8?B?SnFFZ1JDdW1iU0pQRFdCSG1iZitGUGY1Ly9wSkNSNVRER0c3aUpoeWJ1ZHdC?=
 =?utf-8?B?T084dWUzSi9hbXQvVFdwRFFLQUh3UUlzOEFOWG8yTU5GWG9IekRxakRPOGww?=
 =?utf-8?B?cXRubW92bU5VMHFQQW1aVUkwa1Q2WmpQRGh0RWI0Q3RURVlFU1oyUXBkWndE?=
 =?utf-8?Q?XhnAp3MyE56A9TWhIqAh6CTrC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d05f01b-185e-40ac-a863-08dd3acec348
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 10:23:07.3792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ypehsh+vjjEtr/GqZYFdXedA/hEMWFq+5A8Y6P/sU/9XpGrPvhkexxRu9jXHPTwujju9K7LFFt8o0m4vVyzbxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6753
X-OriginatorOrg: intel.com



On 1/22/2025 11:53 AM, Lucas De Marchi wrote:
> From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
> 
> Provide a PMU interface for GT C6 residency counters. The implementation
> is ported over from the i915 PMU code. Residency is provided in units of
> ms(like sysfs entry in - /sys/class/drm/card0/device/tile0/gt0/gtidle).
> 
> Sample usage and output:
> 
> 	$ perf list | grep gt-c6
> 	  xe_0000_00_02.0/gt-c6-residency/                   [Kernel PMU event]
> 
> 	$ tail /sys/bus/event_source/devices/xe_0000_00_02.0/events/gt-c6-residency*
> 	==> /sys/bus/event_source/devices/xe_0000_00_02.0/events/gt-c6-residency <==
> 	event=0x01
> 
> 	==> /sys/bus/event_source/devices/xe_0000_00_02.0/events/gt-c6-residency.unit <==
> 	ms
> 
> 	$ perf stat -e xe_0000_00_02.0/gt-c6-residency,gt=0/ -I1000
> 	#           time             counts unit events
> 	     1.001196056              1,001 ms   xe_0000_00_02.0/gt-c6-residency,gt=0/
> 	     2.005216219              1,003 ms   xe_0000_00_02.0/gt-c6-residency,gt=0/
> 
> Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Looks good to me
Reviewed-by: Riana Tauro <riana.tauro@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_pmu.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
> index 8d938d67c1f2c..a2e4addd3dd7e 100644
> --- a/drivers/gpu/drm/xe/xe_pmu.c
> +++ b/drivers/gpu/drm/xe/xe_pmu.c
> @@ -11,6 +11,7 @@
>   #include "xe_device.h"
>   #include "xe_force_wake.h"
>   #include "xe_gt_clock.h"
> +#include "xe_gt_idle.h"
>   #include "xe_gt_printk.h"
>   #include "xe_mmio.h"
>   #include "xe_macros.h"
> @@ -122,12 +123,16 @@ static int xe_pmu_event_init(struct perf_event *event)
>   static u64 __xe_pmu_event_read(struct perf_event *event)
>   {
>   	struct xe_gt *gt = event_to_gt(event);
> -	u64 val = 0;
>   
>   	if (!gt)
>   		return 0;
>   
> -	return val;
> +	switch (config_to_event_id(event->attr.config)) {
> +	case XE_PMU_EVENT_GT_C6_RESIDENCY:
> +		return xe_gt_idle_residency_msec(&gt->gtidle);
> +	}
> +
> +	return 0;
>   }
>   
>   static void xe_pmu_event_update(struct perf_event *event)
> @@ -268,6 +273,10 @@ static const struct attribute_group pmu_events_attr_group = {
>   
>   static void set_supported_events(struct xe_pmu *pmu)
>   {
> +	struct xe_device *xe = container_of(pmu, typeof(*xe), pmu);
> +
> +	if (!xe->info.skip_guc_pc)
> +		pmu->supported_events |= BIT_ULL(XE_PMU_EVENT_GT_C6_RESIDENCY);
>   }
>   
>   /**

