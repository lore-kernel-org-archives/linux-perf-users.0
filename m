Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2D01A08D6;
	Thu, 27 Jun 2024 23:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719530459; cv=fail; b=Jzq+veCzdzsmOdgXyUyTGbfYQiMI/630SIRORNhAf/G+liFGybFBqleFXUEwiBjl8xgBSjAdRUe5zZNaowJJLUL3YJJNu4M0kojVKp6IK+DkJ8G7KlYntF7IXXx31E3C6d0FLRaCPWl/eUKgVX4R9mAm/12+aD6388k8ie6iRSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719530459; c=relaxed/simple;
	bh=XiuXJ96rUzEE0Q6AnugY4bxDi16xVRU7ix3szu4H9ws=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fEqAtm9lQCH71nEY0wC9Kf8xaYtpQuqx29pJN0b7qOPdBla2XghAveR44SNHO+3Nrgn1p5ijQqbS56VyXq/kFsKS2a/tFhDh9iKCM5mSDbqE7RzHtefqY6TADRo6ULKfGpMY9vY9+kvY4ZgDYQtPzJu2vl5gzvvishiIl5/jJ/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QHiJYkM6; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QHiJYkM6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719530457; x=1751066457;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XiuXJ96rUzEE0Q6AnugY4bxDi16xVRU7ix3szu4H9ws=;
  b=QHiJYkM6MsTIOHbXweqklgXQVQfcO15FUiyyn6Q5mpYs1Xk17h7KRDiR
   UnjXz0MCG+eWtDIi4F0QDKI/Dkz5BigvAdGSOUKWS1tC4neWiG7z0a9eb
   lTVUtjMsufOsSoOUxrGlq79hY78cu/5FwMUnHWaCklE06iGkDH6oFA22i
   zTKYKBVum7/M8/FZmzRT3fr7NyEcDrYlY6NF6bvvZi42YZfyEYz0v7ubT
   M/W3aT4x95OBdcAJgsCUQmjQ6moQ7oi4X4CJcg7fcg56jltTAZZIWkhdT
   FsP3WhnlTeXJGmTLJXCgPuUJ/7LQwJXzj3G2g7VrW72w/Zb1VVbtLNjYp
   w==;
X-CSE-ConnectionGUID: A20q9bdKTWi5wcZwGyy2/w==
X-CSE-MsgGUID: 8ngF/l7FSwK5KjvjFD+g/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="20458244"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="20458244"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 16:20:56 -0700
X-CSE-ConnectionGUID: CY+PNPaARIS9/jGhzOdELQ==
X-CSE-MsgGUID: X9i5KR1uS1yHORmLL8m2Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="67748732"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jun 2024 16:20:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 16:20:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 27 Jun 2024 16:20:55 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 16:20:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+69IAJtN/NIqROcxpwQtKKqnDWs2/EXvlEXUp0NEZ5looP4KQcz0w51k0VdqI5zPpf9gHLeEYJU+SbzxAwNbRXyuaPF0gxghDDu/Q8lwphzzkUxAzohP2orUXdms7SErReVytUd1wlmqShceVznUeeptvmNZCpl5fko6uy7UgpraELJXUa1ce5Lz1n2kzZra/1jQJAt2829peaSimqcZR9NcYB6g7+GQqUeI4p2rPF6VwGOXFSlZZR5nv0yKjZsCBu5Kb3GrmCaOcuo4D+iSV/nVmSaWzEOpjbFopaysbJWT4gBG876sBrBrWX1SOg9+8CpYJ+QUktdyy9uHh6/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uHq8miOj7kIRusmcn3viwcsDyuwf6nXkM7qdGa1nFg=;
 b=ioK58lu6gQawVsIrtqapmh/V6mb8dADzN2y7zyRfj5r63LBTn8uTEBGTfAxKRIp821Sa1I75l8lC2EekQBKM0RBQYfJOsNTZwCVKNvk+UtA1O4vXZAPMFzKkrglZkrAre0u+gIT7/Ze0dmfsJ4Wcx5TV9ciZrU+Ur/rFPTm9DGM+mcj4dqvfFeJgfXu45/Wqx+0biMA/YEviE7zDTVxfzYtzRfPabX3pzxONz6kxvqTkfWL1ocq+v+FWCI0KZlubFiMRtv5h0FpfW+257nfFp+N4in3OQd1MLun6MrxwrDfVspMXFhm342WX9iqDKQdVTIdOTrvL69WnRS7+4rMRmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DM4PR11MB5996.namprd11.prod.outlook.com (2603:10b6:8:5f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Thu, 27 Jun
 2024 23:20:48 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%3]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 23:20:48 +0000
Message-ID: <7e0097d6-a542-4778-913b-3c374d36f5c3@intel.com>
Date: Thu, 27 Jun 2024 16:20:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] x86/irq: Add enumeration of NMI source reporting
 CPU feature
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
CC: X86 Kernel <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, Dave Hansen <dave.hansen@intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <linux-perf-users@vger.kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Andi Kleen <andi.kleen@intel.com>, Xin Li
	<xin3.li@intel.com>
References: <20240611165457.156364-1-jacob.jun.pan@linux.intel.com>
 <20240611165457.156364-2-jacob.jun.pan@linux.intel.com>
 <b3b10d29-857e-402b-95b9-1696baa88e81@intel.com>
 <20240621164615.051217c4@jacob-builder>
 <004f6400-0d35-4c5e-ad31-094be8860f08@intel.com>
 <20240627152102.592a20f5@jacob-builder>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20240627152102.592a20f5@jacob-builder>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::26) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DM4PR11MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b9a6c2-a5f1-4c33-67e5-08dc96ffc747
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3pudEt4ZUtkdUVwWWxTbjlrMzlsYWdtOCtianRHVXNrRVBYd3lqelRjdmRY?=
 =?utf-8?B?VG5qWUptMFozNG1TZURrcUtnODdoQ01GQWxHZXFMQ0htZXozRHJNVnI5bFk2?=
 =?utf-8?B?VEN6T0xnSWJZWVg2Mkw5UEpoTCtGcUZmWVNsTmZJZnZkK0c2MElFRGNDSDdn?=
 =?utf-8?B?Z3YwS21QR0UxV2d4RjNrTWpOQjIxN1hWZkFGL3NqOHhmdlZrNHBYTDloRm9k?=
 =?utf-8?B?TkFPZ3orSldQYTBEdXhRVVBLdXpZQTFwdVVqdEJNYm5UeERMMWdHZnpqWWVW?=
 =?utf-8?B?VFFwT2tuNkw1WnRYQUsyWCtqVWorV2VCVWhIVVA1dWUydjZyUUltUUg3aWZn?=
 =?utf-8?B?UEdLcnJmQjc4b2M1MUNON0hvcXVrMEFpUDZxcWE3MkZMWmJralZmK1Q1YXZl?=
 =?utf-8?B?b1ovWkZPckZvR2ZHK01rbXoyUFNLQVQ1UHBaN0lkaDZ3cWpiS0RmSzVYc3Mw?=
 =?utf-8?B?ZWlBbUwwZ3IxUG1helNMZE5KdFdUTE5wOTZjYWJyWDFwVUJUZUtLNFNOMmlF?=
 =?utf-8?B?OVZ6bG96QmMxaGVqRXAxTmcvd1ZHdUZOQ1BzNjlaTFBYekZDOXhSNUVUSG1k?=
 =?utf-8?B?VkVOU2RyS0NvL2hBSTA5VXM0b0ZFNitkU1FISFZ0ZzY2V0NnWHVDKzBhbEox?=
 =?utf-8?B?Y3Zwa3dKVEdBbnpQYUlJVEZXNGxRdlhKOEYwZ0VOWXVwQW40UEY5am82Qk1u?=
 =?utf-8?B?NnVYM0dndEdpMTZtVGs3K0pkREhmbVViVnpBWU42U240V1J4YlJFMFMwK0J0?=
 =?utf-8?B?QkJlWXFBMWxpN2hJazJkS3N2aFEzL3F5TGtiREZqZERNZjVkV2RvWkVmNWd6?=
 =?utf-8?B?THhCaFdkZXpSM1VldWw0MjFvcC9OYUlNSitJY1h5ZHNWRGVDMVQwZGlwRFYr?=
 =?utf-8?B?WUlDQ3d4d0M0RDE3djk0b0dpQTVnMkQwaVJBM0NKaXpUQkRqQXErOHFOdDk3?=
 =?utf-8?B?QzVpYXBBd29ucTNtSVpQc05Hclh1VE9PczNtMk9LWmNjQWQ1YUkySXJxaEFn?=
 =?utf-8?B?Q1FiR2QzdUtzOWxVL3lYaEJscVFOSU5nYTFiNDVlVG4rUlNyS3ZBdlk3bDI5?=
 =?utf-8?B?ZFFpK2FzcjBjMVZyTmNnT2NTbjF2YnFINlNyVlRKeTNtVWxjUndMUUJzMnJF?=
 =?utf-8?B?U3Z1Q3FBVVA3UXA1UnRhZGtLUWU4RDNyaWF6Sm02R0xCMThxRE43d3ZGcmxS?=
 =?utf-8?B?eURObDkxdHV3NHk2UGgraUFtTCtNcXFoWlRRbktjVG9ROWZMeGI4RkVrRXIw?=
 =?utf-8?B?WldTQnZod2ZJbm5IU0NCR3laZkg5cEZXaW1LYThnZVlRZkw0NllKc0hxL01i?=
 =?utf-8?B?ZGxla0JaN0lIK0tvdmY1OVNadzRBY2UwUVVtanJUeldncVQ5dm9RTU5Fc3R0?=
 =?utf-8?B?dTd2eGVkcFBvdm9yTHZPam1uTXJTUDNWVWRObnhxM003cVlYR0c2aWF3ZzNY?=
 =?utf-8?B?TW0rNnhWSXFWd2VEbjRDNngxK1NvemtXcHB2TithVlZIQXg0aXhmd3FYRS8z?=
 =?utf-8?B?TDVVWDdocFVhS3FiQXAzWnl6YzVOZ2h2WVA4NG9sUE5pRXk3aGRJZ09JZ1VH?=
 =?utf-8?B?Z0owZk5DWGl5MCtnM01OYjYzbm1wNGIvQ1ZyTXh3bXlmWG5JMGhCVkVuMG45?=
 =?utf-8?B?RVFKbFJOalMzRnFZdW9URnB0TVBuc3YyQnAwTVhSaVRVK3h1N3kyMkhrUzJL?=
 =?utf-8?B?S01KU3NyeHd6RitkUzdqanBpOTQrYlk4bmZ0TU5tSmZIa3BCWUtQUXVqcWda?=
 =?utf-8?B?S0NwdmdOQUd3VGh3d1RJYWJGRzFpdDVPc090SVdqd2FhY0xQcXdveERtS2hz?=
 =?utf-8?B?d2NVSXd0eDllQWFPUDFRQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aENoOUN2alFpK0VjOHh2MGdQdmw3cE9PME5Bbmh1c2NnYnVreElsTHJ5czBq?=
 =?utf-8?B?djJQNjEyNEp0NE9KNXFlM0xDUlgrcTd4cmpwNVhLQy9md0R6d0lURG1TV3BE?=
 =?utf-8?B?MW4wc0xJeVJzQzJlNmpDbzNxYTFrVWFhaGRZNCtBdklRMitZY0Y4VHQ5THp1?=
 =?utf-8?B?MUphWitzSW56Qi9zYlh1djl5d2JEaWtOeFQxUGxpdUh2ckVvOWpyR3g3VnFr?=
 =?utf-8?B?MDgyN013akZDS3QzaTRBZDBKQTkyY3Q5SUdNc3p1d0hNYlFiM2g0UU9ZYzZr?=
 =?utf-8?B?OXM1d05Pbml0MUdSbGEzUlU0ODl2cExZaGNEVGcxRGVqYUNNbGo2QmpSVC8v?=
 =?utf-8?B?YmlVZFZrOU5ESlRpQllXdWZycnVTdlpxcFpGcTFRWnVmVDZJTEVGSWh5bDQ1?=
 =?utf-8?B?aThMS21abXJxWTNPUm1MZDlkOUI3U050RUpFL0NYNFFrUDhPN25CTGZOZlZ0?=
 =?utf-8?B?c01NQ0lVVnIvRFpCaXNIQU9HVUpIeTJ5MUJ0YUJkRUdtekdGMnBKamdJa3lQ?=
 =?utf-8?B?UHhvMHB0MW9SZkU4Y28zNzhrRjBkeWpCcWFEQzhicFRCQVRnUHhBdHFYcS8y?=
 =?utf-8?B?TnBNSWcrSU1PRGJpY3hETytEU0w2QVM4UEI4R01xTGVNb1RiL1dBaHd2Lzd0?=
 =?utf-8?B?L1lXazRKNFd0dWNuSjZNaVJyYzd1VW9URVBiNjArVWlscVppOWxSU3pCUkVu?=
 =?utf-8?B?NWRwWHh0QjFSbFdFY1RTOFFrTHFaMFMzaGZMeWpvLzNpUFQvQXVVV0NWWnRy?=
 =?utf-8?B?L2ZiZDRCWC9UNTZkM29ZalRZdEpPZE53S093V1NMNHhob2h6VEk2eVNMWXRJ?=
 =?utf-8?B?VGh3alA1M0FlaXR0UUN3RmNoalRzZUViTTJRbEtRMUNFbTdZUXE1SWM3Mm54?=
 =?utf-8?B?aEVxaXQralZXb1B0Y3RER3VpajJMQUdFbHhCKzNiRTAvL3p6dWIxWmFZbnd1?=
 =?utf-8?B?dGpaMGs1VjVPejBWNkZSTnZNRE93eE53K2lRZ2M4ZjhNT2U2QmwzOW4venV4?=
 =?utf-8?B?ajVheGNTNG1QdnlFanR4bHVud0x3VUw3a2lXWWhjU2VnZ2JSMW9acDkvN1Z6?=
 =?utf-8?B?N051SGZWcmdvU0Z1UGtKSUFYSVBkOEQ4Q3oxN2hMaHM4S080VlZnTUo4ZXRK?=
 =?utf-8?B?RzVsSGQwU1Q1amV0UUNnUnFjQVFUMlpiU1c4OG1QMmJ6NFBTUzYrUjdXOUQ1?=
 =?utf-8?B?bW1Jb2loYTZ4MS9nM1U4V2tzL3BxZDlnakl4MFlrbEFkdXNDRlVzWWxaV21u?=
 =?utf-8?B?VGtkVHdLTmcyU00xUU1jUitBWmh1bkR2OVFTU2xTOVJ0MnJRdG1NUkp2Q1lR?=
 =?utf-8?B?ZUN2MzN2TFFTd2pXRVhhQ3lwREpMTk1YaUNLTGpIL3Uzd25GdnBBSHhKYlZX?=
 =?utf-8?B?aDN3SGprd3ZkNDZ0Y1BTQnl2UmFWOXE2NlNHbWQ4eGZZVFhJTGZ3eDcrOVhx?=
 =?utf-8?B?NDFpS3J4YXp2VnJaVThKM05RT2dyQWp0Z291VG1sb3IwblNWcVdvbWYvVUpC?=
 =?utf-8?B?UEhsQm1QMTQwdm91YW5GQmFNc2hVR0Z2Umd0ZFduNGgya1p3aE53bWszUmZv?=
 =?utf-8?B?ZERaZS9YVWZ4b0RoL25KM2pMNWsvL2s5bjNzSGtUeFhUM2xIMERQa0ZqbFl2?=
 =?utf-8?B?OUhDckkrcWYzWTBrTHpHTUV3bWZLZ1hnYkhCb0dpeWE1NC9rbG5KUVVyNSsy?=
 =?utf-8?B?aWZSamo3bHR0c0x1R2Z6MTVoanY0TXJKSmZpN1ZybnVSVjBtQnJnMEx2RDF1?=
 =?utf-8?B?VFNRSXV0elhUTUQ3SjgwVWtkZFZyTk1Ea096dWZtcHhMaUx0TVF5bytUd2pO?=
 =?utf-8?B?UnBtQmVsUG9ORTlxSGxQcmc2aEhFaDZtOE4yMjJSaW81elJrKzdJNXUvQXZT?=
 =?utf-8?B?eHdTczFHZFpJWmVwdWg5WERUcE5vR3A2c1hnbEpraUJaaUwzOEVXeUpJWHNl?=
 =?utf-8?B?cG51THdIZGFMNWNVd2tCdDFRKzlSeTRSZ09mdzY2R1hVU05RMndBMDZId2Zi?=
 =?utf-8?B?QjRaUy9zZDJvRXU0bDRCNjlHZWxQVEprMTJaVjI4YVdaQmtuNjQzVTBXaFdW?=
 =?utf-8?B?Y2t2bUJoaHVFakxJckF2b2luQXd3dFFWRFg2eC9vMWNxa1NTaGNMejQyVGFs?=
 =?utf-8?Q?4XrozBslMyaDl1nlJFHvRcHQG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b9a6c2-a5f1-4c33-67e5-08dc96ffc747
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 23:20:48.5094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ch8VwK1kQWhf7lrOGUR/IPvgncHIcD3MAuNCMxSugjLO90zukllqLJUsXNgBOagbm6qt7ZWne2H2ZFHoGKgurw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5996
X-OriginatorOrg: intel.com

On 6/27/2024 3:23 PM, Jacob Pan wrote:

> I don't think this is true. For a simplified example:
> cpuid_deps has the following feature-depends pairs.
> [1, 3]
> [2, 3]
> now, do_clear_cpu_cap(c, 2)
> 
> Before the loop below __set_bit(feature, disable), bit 2 is set. 
> 
> Since there is no other features depend on 2, the loop below will not clear
> any other features. no?
> 

You are right. The table-scan only processes the dependencies of the
feature that is being disabled but not of any other features that might
have a missing dependency.

Maybe it might be useful to have a common function that scans through
all the dependencies at boot. It would mainly help detect hardware (or
VMM) inconsistencies sooner than later.

