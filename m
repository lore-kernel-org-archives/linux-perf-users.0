Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C07349655;
	Mon, 24 Jun 2024 23:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271058; cv=fail; b=trlYvUYMCf6979kRFLG4iXiarbw4+YVbmUjlugtxm+lmc+G30edjvj6N4vplqYAr/CMv9BYmxJ0y+1I56FXuxoYu3xKzT3NQniXYqzniXsNHfMBMAYxi3qEPuZj9MHcVDZWsAteiVF3CkieIQIkzFZbI4kYdIond7ME10gdUZh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271058; c=relaxed/simple;
	bh=oOUBSEV3IK47MipBuPnKwDoQUsy65LsE+YJma+mNvnA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PPbFn2PQX5jDb+JoKQPZhiioe2oG74by4U4vazg9W5s/qE64a16DaqHX1crzogvjB3lIjL8GeXold33bC08NgWrs89HRELZWWfaFDyc7CHcuAhsTfnia8CRGMn5oh5zn4Q+Y66lT7ovGd6qui9hM5NKfjb6YHYbRuKmPj5PXojs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ezu5KSTa; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ezu5KSTa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719271056; x=1750807056;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oOUBSEV3IK47MipBuPnKwDoQUsy65LsE+YJma+mNvnA=;
  b=Ezu5KSTahpoxFAu3Yv24B6bPTUtukRp+l5k8dRqqpDz7nUF0Z4Kyo4J1
   vBWVJOmOtFM24/+R8rqkEHMkHdVJlJmAnRVJXLpG782LYAoF6rEfgjlua
   GY0hXZFHaxSWkGpjnJugRiN8zDmxTWkzltsez6A5xSU6+QwNBbmO3j/ZT
   /P596KVggH7zanperLRDXil5LY3uiCj8kVljKhtDUZucRcO4ODHC7k9LE
   YLLp7i0MeBaX/+Me23xOzkTOeFXiV5LC5Wve2BR694JiMVk+kvFYv49QL
   lSV1fsiRaMdetBgg+zG68xK0s/stkTf8qnkWGg5twhvo0E7Buje5FyiOv
   g==;
X-CSE-ConnectionGUID: aWjpL2ElRvaNhYjvtGI4KA==
X-CSE-MsgGUID: iL9EKFVDQbyJQqzQnXUQIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="12227559"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="12227559"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 16:17:35 -0700
X-CSE-ConnectionGUID: eyD0xNI+SOqTBRVWw84PMQ==
X-CSE-MsgGUID: OqXNjYP9Q1eRE4Wn3rwELA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="44141658"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jun 2024 16:17:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 16:17:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 16:16:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 24 Jun 2024 16:16:56 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 16:16:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ee0NrDlwK3SDeyRPClZ6aVjgAt8IZ6nE3AUZk2I2LQBokeZ8nQsk3Lzu1+/Gc8nLzJ4DTJsdKMUaivNZ8oZvGMGiu9iE6KPUiGx3t/uy/gIkVivxxsW9GWussGDAlNswJdG3a3f4RmP1MLbXx+f+T6V4fW9T4n/wIVG6vDYP1QIc59BGYog7bxU2AQkNoHMi4V3B098Td0g59vfZyb2gq2M22OcQ1C1GLCRQxcRmW/04h57kFwLF60OQpsaTa5pr3swdW+mb6yxXpHCCW6Y4Y1s/U0u1Lu6Kzf2XLJFK3gldsXOQ9qMbyngUaw0wSFCZXjv2ytFmDK9RNBnPwwDwmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTsb2Mp2/cVLdnDwr446yAitOqlEBkaH8LEF8Hq5SWs=;
 b=Zp6NfXJr4jRexY9Z6SZBH92/F5vmxO/YBeYXZkXN+NmBPxqcIgq4mT+M27zufv6l4edlnjNcQtVPaUXNqbHeJmoAX+zNOhkrqFrS/MuADSThrC/857DNcwKrqQSZnTthp2ftX/UYyG/v44x/1YvJV346vfTEIm9dDNUZdy5AnEHhd1olxsCvUH4bE5Z91oz+y0XChCy06R4j624ArtkHLrI5LGN6UQpi+TtmqhcEqFPqA0nDIU1NGW+bWhf5Mi3YqxodRkS6pL7I9k7MnLhkOzs7FaWST70EMwSaZSHw2Jt/6BJvAZo+5iz7NPXLEWcwvPUPH0+ZwYr5XQ0VvmiiCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by MW4PR11MB6788.namprd11.prod.outlook.com (2603:10b6:303:208::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 23:16:54 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 23:16:54 +0000
Message-ID: <9057390e-1a15-43e7-b4bc-803651b951ed@intel.com>
Date: Mon, 24 Jun 2024 16:16:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] x86/irq: Extend NMI handler registration interface
 to include source
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, X86 Kernel <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	<linux-perf-users@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
CC: Andi Kleen <andi.kleen@intel.com>, Xin Li <xin3.li@intel.com>
References: <20240611165457.156364-1-jacob.jun.pan@linux.intel.com>
 <20240611165457.156364-3-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20240611165457.156364-3-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0358.namprd03.prod.outlook.com
 (2603:10b6:303:dc::33) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|MW4PR11MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: b80673e9-c7a1-4518-8d9e-08dc94a3bc94
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011|921017;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0tkKzI1dHdIWGRIVDl3Q2pZRHNyWTUwWTd0SjBMbzFWeGdRTEpHTE9CazBk?=
 =?utf-8?B?cVlJa3h6ZC9Qb1dXTGpVaVoyT0tQUDV4a3pabmlnbjdlMVlRc0NjSmFOMC9G?=
 =?utf-8?B?MG95SUpPQW9lTktGaFpiNk1PWUozSzl2M1RXbTR6djlVYWh2UnJRbTNtakxn?=
 =?utf-8?B?dC9WWjljZ2hpYy9heWQzTHNiM0lFdnp0R0xUT1phM0t4QmoxTWtkOElNM0sz?=
 =?utf-8?B?aXpqNXVSLy9nRXVlazhpVVNJeTN0VytEM1hjK21mN1lnVklLU3o0TlVEakFG?=
 =?utf-8?B?dDBLM0d6L1pHVXU5L3VUMmw0ODBoVjFRQkJ0L256am9yUFA3bS9VSVg4dXh2?=
 =?utf-8?B?ZEdLZ0JjVTN5RnJVY3U1b3RLU0R0b1BoR3BrR0hYVGVydHVjeC9QK2VrajhN?=
 =?utf-8?B?Q3FsZXJZOE8rWG1ZbUY5L2dYM1pNSGlhUE14bVRKUXM1bEJTQ2Qxd2hZRUJU?=
 =?utf-8?B?RlRnQVJwcWJHNWdLemVCZnpxMkUrR3dvNmxaRDA1aUtVeXhJS1pnTWFIdjls?=
 =?utf-8?B?ekNZVEljdHB2Ymh4clJvTDVBd2dONzBkcnp0Q2kxZDdwejIyd2ovUGhxVTA4?=
 =?utf-8?B?dHFEamVseFZYNXF0NXRmUnJaMEduaGkvTlN0U1FtUDFscG16bDFvRUJQd1JS?=
 =?utf-8?B?ZTBvdk1MY2xmUGIxMG1SekorSVRKQ2pKOWRvT3pYT1JsaFRsNE82WkV4TVhU?=
 =?utf-8?B?MzBnYXVTcitXUjhDSWpaVE1salIxNUJTTUxTTWlEZHVLeHFhVjgxcERxSE9Y?=
 =?utf-8?B?L2laTWw3UFFCNmt3d09vSVlKYXJveDh5V1pscEhiNFROTmVQSnJlTllheDNq?=
 =?utf-8?B?ZkY0RlhXK1pnM0FTaG5XaTFoMWx3anpxMkFGRHNKZ1FjRVNmdW5Na29ZOWpK?=
 =?utf-8?B?TG13MVUxdXptUlJCdU5YdWNMSThvUmhJUVFVaXo1emtLZmhZY1NWeFNjcHpi?=
 =?utf-8?B?bmpDdmYyNUZVQ0N1bURETklVOEQ5YjZMOUxPTk9XOGNMMGgzamx1MU1BeTZJ?=
 =?utf-8?B?U0RSRWZreXBuOVhsZ09WVUJ5eCtBcE1oQkpMbUxLSklUNk5GaUJiMk5KWlJ0?=
 =?utf-8?B?cnR5K2FXWTB3WVRGb3k4UkpoNlg4SEJKRDF0R3ByNGVHUE1ibWEzQ1IwUU5I?=
 =?utf-8?B?TGdVaEI4RzYwRzFCNEVBL0xYaHEyN3pna2tHZG43MENUWkJJRmlKYkl2NlhW?=
 =?utf-8?B?MmZRamM5L3c1OVkzdStOWThBSzkxTzE3ckIxMVpWTTJRUllvakNaRk1aR0xo?=
 =?utf-8?B?NHpOU2tWY0EwWUJxNEFIc1d0U0hSZkltSXo2ZUs3UDd3VTBkdjVmR1ord0tu?=
 =?utf-8?B?elRMa1l6b2hvbFBvSTZtSERqc2tSZ2ZwNWF1b1QxK0FVb3FIWjlhMytuTlVH?=
 =?utf-8?B?L2xOa1J5SjdZbnQvU3BWbFJCSnU2WFk1Wmg4UzVxa0Rwb3Fvc0xmTURCdFVa?=
 =?utf-8?B?dENLMEx4NmZUaDFQZ1BJUkFiV1pzK3ViZGJQUmUrNnNkNTJjQVZINGhOUDVs?=
 =?utf-8?B?MDJ0ZFZtK2J4MmpFSUZrblpPcm1xc3RRcTFjcDFRM0hYdDNLUkNUQUhBaFNN?=
 =?utf-8?B?SlU0b0xVYUY4U3RJcHVOUnREYjJPUGJ3cU0yWTJnTjkrNmxLSkhGc25wcW5N?=
 =?utf-8?B?Y2U4TlFJVzczd3V3cVp2MSsxbkpKTE56V3pIR1hTQkFMME85ZkFPTUh3cGxP?=
 =?utf-8?B?cmJJa0ltamRwNHE5K0Qxa3d2YzE0R3VKNFFCSktIa0hRTCtCOGRCQ0haRWY1?=
 =?utf-8?B?OWdjRkxXY05tZ0FXNkk4QThiV0cxNm45bFlOS1JXdVNQWVJVbjNFZGZrdENF?=
 =?utf-8?Q?JHHLAO9qCnfATXcHodMXPBZEqhFrz120XJrAU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2RHN0NteXM0SFh5N0N1NXplM21FVVpzRXVuVzdYeVhseTEyUEFaSnVXckF2?=
 =?utf-8?B?VDNIWnlnOWRObDJpYTZwMlZMS0IwbWJieFhXemdUKzlrZmhySm5HSmhTUlkz?=
 =?utf-8?B?bHdSZ01EbXZKNlh3a1JqSlNHRU14dTh3WmdEcGs2ak5QdkFXOE5Gb25jVlMv?=
 =?utf-8?B?c1owRks2TnRrMkJMSFErMnRtY0pNRitKNmFBMmt3TXJOSEoyejQxbUpEV0FC?=
 =?utf-8?B?dUFmNjhLeU5TdXNGcG9xaWV5aVZZb2h3dzJRRDduSlNvT3ZHbUZTVWRiRkt3?=
 =?utf-8?B?NzllY2x2ZjZCUER4Zjg4UWxSbFROMlZoNDJoOXZBQTUyUWYyWHZrWnFlbzVM?=
 =?utf-8?B?Y0VZVzFzVk04QjNOZkFtRVBoeHFDMHJaM1lyY3IxUmdpVGw1MkpkQk5tUXd0?=
 =?utf-8?B?Q0tRcnRGbUtrbkpvK25nR1pNWFBGVVpNanpWckZmc0ZaNzBwMTJXdWZpVzFC?=
 =?utf-8?B?L3lYdGFwQi9OU3g1NFRDVVA4dFdMYlM2N00xYVdkMEc5d2VOYzR1dzJobWdI?=
 =?utf-8?B?NnpYSXR0NnpYTjM5MHV0S0FHcWtlaTBJUHUyOTBTeEtWOVZPWStXOXk1Ni81?=
 =?utf-8?B?Y3dxNWxMSVZiZVNHYjJzVG43bnhQL3h0ZHZZbVBYM0tCMEQ0dTRvNDNWbzZk?=
 =?utf-8?B?UG5qSjZPYmdscFFNRTMvNmlSZ294TENWdExWZVdoWmtyQURyeEVodTBsQkpo?=
 =?utf-8?B?d0dTRHpnbzBWaVA3QTY2L2I5YU9tMG1SVnFIQUh2UUMwekg5VHE4NUhpVzY4?=
 =?utf-8?B?d3hlbHFteWVpbGxaUllxNy8vdnc1bW9EUnMzZFJNZUVDQ0xIZzhiZDVUMHln?=
 =?utf-8?B?SGxxRm93dzZiWHErNlNLbnJxV2xXME43Y244c1JmeFYxaVdzVndldnBzbHhi?=
 =?utf-8?B?ZktHS1kzOStLbmUrUmU2dHIweXdoeHoxQVRlN3ZNMWZsRGNqU3N0bEpkaXJx?=
 =?utf-8?B?dTZSK0dUK2haTHZsRThmT050N0FmSjNoNW1ZMXBKVFlKYUE2THB5ekliRlBM?=
 =?utf-8?B?WjJOWHBCalB5L1BlS201RWlZK2U3bS8rYWFuOXF6NmxoOGR3YzQvTFdnbFli?=
 =?utf-8?B?TzNKcC8zT010S0c3S3VwNDhjTng4RU01QzlvM25IWEJuS3ZQYjlXUUhseGRu?=
 =?utf-8?B?a1RKTDBMY3NVakdiQnFSMkZBenlDMEptemVzT2xsS0pFYXBweWJIb0EwM09M?=
 =?utf-8?B?cXFDZitwcWwrRWsvNEZZSktwVU9GOVJTT254bElpRDlMeTdndjBhOERKSG5j?=
 =?utf-8?B?dWh3OFNaV3JKVDhUWkRJSS90T3VvSlNCQkxacS96MGtnTlpYSXhNNmFvRGRh?=
 =?utf-8?B?bTN1ZjBabzArQ0NtM3pSTjBoNi9RUVU4emhkMTJZRis1aDh0MWNsNFYydGFE?=
 =?utf-8?B?ekZDR3ludUk0OHFnR1gwZlcrYnBLb0ZkY2RkWWpMdGdwMTRHSTdNalZZaXYv?=
 =?utf-8?B?NTRqWkpmY3BEVWkwK21OcDVBQlpxaWxPdFNxWE9sOGRIZVRNQzVxalJiQTB5?=
 =?utf-8?B?WDhnTjVhS2wyY1hiZmE0ZUcyMExCNXo0b2xVRkYxTGhMOThoeFY4elRhY2pT?=
 =?utf-8?B?eXNsdFFBQVkxMHVhZ2s2Mk1LMmJESmF3T0JTMEZva3BBYVc5d1piajcvbHBW?=
 =?utf-8?B?bnBHZzlKcXFTdmpjRDhJa2tJcGYvTmxiMTRiVElEc1l1ZTluR2Nvem1xNGdk?=
 =?utf-8?B?RSsvZkQwREFiODBuanR3MHdOendKRmZIL0VQb0RMMzZESlVRS0V0T2FRdnlI?=
 =?utf-8?B?Nk1UUFdid1AvWkhFNHV2enRIVTVYY3dlQ3U0Y2xXWnNnYjJNWk5namFxblZi?=
 =?utf-8?B?bGd2YzR2TDJGR0Jtb1JwUFhhWW9sL1NqNnZtUmNwMTFlNGI4YThDMmJ6dTJB?=
 =?utf-8?B?SERodXVocm91ekFQVVRsVXVueHhlSU1FVGVSQldwc09iS2sxM2tZN25EbFFJ?=
 =?utf-8?B?NnhPMmFwWm13U1RFZEI2WHhnNnVEQXhRdkJmcEpGUjBQSDQ1eGZ3Zm1PMGZZ?=
 =?utf-8?B?dmlNNGJzMjBGZ1VNdEhBb25zck9GcTByb3JaVkMyZnM3QjJkTlBRK2F0S3I0?=
 =?utf-8?B?N3JBNUhWV3Fma21FYlZLMllZSjlCNHJoUEQ2aEJ4K2JDSUNKUkpwY3F4L1l4?=
 =?utf-8?Q?LPj+QSlvGjnShafwCB3e+OT3H?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b80673e9-c7a1-4518-8d9e-08dc94a3bc94
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 23:16:54.5455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oIC73+NgTwL5z9rFWSoefgURibeNoYJ1k8MREGexz6Gajg0BayT9dqjDnYDdbs6ysqH6UyQh1EiU094B+Kt8UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6788
X-OriginatorOrg: intel.com

On 6/11/2024 9:54 AM, Jacob Pan wrote:
> Add a source vector argument to register_nmi_handler() such that designated
> NMI originators can leverage NMI source reporting feature. For those who
> do not use NMI source reporting, 0 (unknown) is used as the source vector. NMI
> source vectors (up to 16) are pre-defined.
> 

What determines whether a source supports the new reporting vs some that
don't? It might be useful to add that reasoning to the commit message as
well.

I am guessing there is some connection to NMI_LOCAL based on
use_nmi_source() definition but I am not sure.

Also, would it be worthwhile to split this patch into 2? One part that
extents the register_nmi_handler() API and another that allocates the
source vectors to certain sources.


> +static inline bool use_nmi_source(unsigned int type, struct nmiaction *a)
> +{
> +	return (cpu_feature_enabled(X86_FEATURE_NMI_SOURCE) &&
> +		type == NMI_LOCAL && a->source_vec);
> +}
> +

Sohil
