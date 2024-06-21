Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7FD36127;
	Fri, 21 Jun 2024 22:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719008639; cv=fail; b=KbMrPPRAOqdiF+5pLhqR+tMVKdMukXeikfaZ1p54vV5qfckDQJJrPSD1TEVpGLyhY4SXl+7YTI0NbkQqLmmOFWetaji2vdFLrf/tzsQ1iVyC+Y+gv30VAPn6AHZILmzM21HL68+aSANujwuJ7ncPJJ2cPodp8UUvJt7uPMjBt0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719008639; c=relaxed/simple;
	bh=a1a5UNtQ7baxe4dlgL92OTMkAqRcdVebfNreYudkM7E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EU7sdTr5C4xIp42NapvrYLANnwxpvuHDm/xO57xZ8XEyYc/rcB6VGr9iHSVoNWyuPirhMkM04PoHZyAtJZfVILMfeVZUqQPSxv/7ZGmFU+W6N3SaTys82c/MgjwNA6iAMAiemkzt3jLo6Uy/w8pBBFcXeTJD2fkiq9iO964Q6XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k887Mdo4; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k887Mdo4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719008638; x=1750544638;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a1a5UNtQ7baxe4dlgL92OTMkAqRcdVebfNreYudkM7E=;
  b=k887Mdo4GZn5QsPIkmrCM6tl6bkBs+MtQkmxCvG3cYaCWF+PuYXBoeGJ
   lMInUQ8KXwsLfNzwjAt4QUWqwD/jCF5o4NsbsHYfUAnkEdsWNFuTio/DH
   iYt9P1aSk0c9xAPO7Cjf5w0ieRzwqJuFSbwE5lAIRps5MMTWS0wYciEFD
   U48Bo+irhJAeLoWY6U5tMYfOpWS/RRvmkPDHx8Pao2Wz4q8HcyfxUXPtR
   RhhcOLzSl5q44xnM8pT5b1IoC4hRUuurRxIctKAteG0fqJapCOCC2o3Ga
   rWzZhd0mj2EkDbM6Pgo1VA7OHr1FcZwoomO3L3bcMWOCn4At/YG4Or4Ur
   w==;
X-CSE-ConnectionGUID: O5k29c5zQNma83fBTX04vw==
X-CSE-MsgGUID: p28+lZwVRFaX2dH/lcvSbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="18968126"
X-IronPort-AV: E=Sophos;i="6.08,256,1712646000"; 
   d="scan'208";a="18968126"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 15:23:57 -0700
X-CSE-ConnectionGUID: IrLgvob1SnmOFaboiuy52g==
X-CSE-MsgGUID: jYKUIWbYQMiKyVr2QyN6sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,256,1712646000"; 
   d="scan'208";a="47244933"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jun 2024 15:23:57 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 15:23:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 15:23:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 21 Jun 2024 15:23:55 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 15:23:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NW0e1Vkqdi4JAoHUFVlXmLcRok5J6ahxsYC7F4FkXXxgEL5eVWHCAAGvUAHScBCNaypQQK2yXOjDhh5d3XBICE745rHPECCUSeK5ufMVVy91D2r4O77FLUQmA0jtVlbBKU8qT8x/bEhvcxnVfsWhLLKTQ1lYHXX8URAaXvB3DOQvB8vmdiOj811pLYT+SCP6OSyJii/sJZkdF1yONYSd6lpbUBAk7GhGzKZpewazElDv0Vvxq91mxxfWT0bQJ+7Iz3zJZFQ8dU9OGi9OejX6QVIt8jUYuGXNIneV8fRcZRBD7lDdUCyxC0CGltPP5mso2Fumx5eiLvwiYDCXL02jIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dB3PIpLT/L/PchlOspwSosoh/5jFXrZy+NShlcWLvf8=;
 b=nv/YGBa3meoIm69Is7ctteLeMk+ZtVn5ZCDODvWhYxZBf1ACKNAGHDdqMJ1+1W3yA/suy3NNKoPKPVZJ1ySspsBDh0p+No6Xd+LqQzwXUJ9SHujwJEokKk5AEJGJZGILe4y0oS3KN7Ms6rd0eV1BTIbm1c8XinS89x74AZMDAYaoPe0WmJZR325fR84Pe9mgnl8XLBHsDwdRI/teqLcWcGVs9ulPrkKLHeFyqTUGWwfHTnRZ7mmvWIhnNseG1pIE//LI6TOueWTH53Rld8I5aK3EwN9Dw0Dm/lEO1qWQxxeHmLw0Ez0eeW1uvFbzHZZcwvE60irnPzAq9WNAlzY0Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DS0PR11MB8163.namprd11.prod.outlook.com (2603:10b6:8:165::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.25; Fri, 21 Jun
 2024 22:23:53 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 22:23:53 +0000
Message-ID: <b3b10d29-857e-402b-95b9-1696baa88e81@intel.com>
Date: Fri, 21 Jun 2024 15:23:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] x86/irq: Add enumeration of NMI source reporting
 CPU feature
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, X86 Kernel <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	<linux-perf-users@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
CC: Andi Kleen <andi.kleen@intel.com>, Xin Li <xin3.li@intel.com>
References: <20240611165457.156364-1-jacob.jun.pan@linux.intel.com>
 <20240611165457.156364-2-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20240611165457.156364-2-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0004.namprd21.prod.outlook.com
 (2603:10b6:a03:114::14) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DS0PR11MB8163:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b389da7-b06c-489f-b3d2-08dc9240d540
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011|921017;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmwzUFVhd0lSa1MyWkFpSzlaSXBQdVVrR0ZtbmdwVGNVdlRqNDVTdVFGUkpS?=
 =?utf-8?B?S2F5R3A3VXNhUXNwbHFWeVd1MmJzYzZKcS9PSnczV01mYmlFZmJaS2t6SGZo?=
 =?utf-8?B?Z2xFVGNQb1g1S3I3aVp5VFg0emxkdEtKSlJRRmRNQ1pRQmY2V29HRmh0eEpN?=
 =?utf-8?B?OWJrNW14WWJ5a2ZaWDJWdmZya3NNR2gvUjhRZU5CN2xlRlppMEljK1VjYTgz?=
 =?utf-8?B?L2JJSXlpalNJQTFIaFFSV1ZsaE93N0xHTXk0d3ZldXRDSEhiRjNleUsySHg5?=
 =?utf-8?B?N0tFOTVKbFc3d1hOUDcyeitKamg5K1hGdkFOVEZZZTdNUWM5OXhFVnQwSGFE?=
 =?utf-8?B?Nk5HR0VxVy85SjdOMkxQdnZuazkraXFKWDFSUkFPSEJ5UnRnL1E3TEN1QUF2?=
 =?utf-8?B?NHFsak1Ea2JXWTcwUWhJZXhCRnoweTRpRmY5bnZxUFRIbFRLdmtzK3llNERE?=
 =?utf-8?B?dU9JKzd4dTNGSEw3ZFFLQmZHd2gzajJsd0lzZ0diZ2lRZXhTL1dhRUR3WGFt?=
 =?utf-8?B?Q3lqaHFCMUdiTTJ6UFdnbElleWV4UTdCY3plL0Q4ME1kWGM2U08rVlE3ZmFo?=
 =?utf-8?B?VWVoc1lldzkxS0xDZ0IrdVN2UTY0Skc0WEc4aUlYbndmai82UEV4Sjh0M0Rp?=
 =?utf-8?B?d3phVXZ1cW1EcnZ1YWoxUjFEdHpWcXRZSmZRUVRiVU5YblMyek1xVytjQ0RY?=
 =?utf-8?B?U2VEeHBSL0xwWWF1UUF6OE5uLzRqUWYyckdTdVE1SGxLUEJLS2pTK2haUmY5?=
 =?utf-8?B?YzQvbWhlR2VzVW1LOHJlQSt2VTdqTG9VYU81U1NjemNLeGc5TUdEWU0rNnhi?=
 =?utf-8?B?MjBUWGZUN1BDZW1Ud2ZGTWRFZ2xUamc4TlAzejNUVSt5bzBKUmgvT2I1MFlS?=
 =?utf-8?B?YlVRbE5BZllmVVI0ZHE5WThXWk1qVkZXdngrMDNhaTBxd2h3WStwSTNubmlx?=
 =?utf-8?B?RlJCcEZLc0pGTmZrMTZwTHNjMi9rNm5oSER1NW1LRFdtdkNwQWNoNW1neVds?=
 =?utf-8?B?MTQ3UjZZd0RLM0xzQTNtakVidnZtVmNnSlp4TVpJaTZXVVpZYnNBWm5NMlpC?=
 =?utf-8?B?ZklHNXlDV1pmUVhjcm9sYVBHbU9SR21EMHJVUURrMnFUckwwaHhyaWZVeWti?=
 =?utf-8?B?NStJdzN2K2pZMG9ZbHBCdXpoOG01ZW4rb2RiL2Q5enFZbDA4OHF1YkRSNDVh?=
 =?utf-8?B?RkRYTkFWYUt1WjRkb1hZS3gvYjVMU0owTG1VRzZ5aUlwdUZXWnpXYTVNQjZD?=
 =?utf-8?B?NStWaU51RjlHYms1LzFkRnM1SFBTTUYxSkhpelNnakJDUTQ3eWNFTlRvZEVm?=
 =?utf-8?B?MmYzRU16UXg2aFB3NlNyc0dCa2cwNTlOY3AwbFBzUkIxTXdGMng5b1RzZ3JJ?=
 =?utf-8?B?Yi9LT3hhazFFMVJkZC9yWUhpanoycmVyUEg0QmtWeFJVdEFGbFQ5OGZnZFdz?=
 =?utf-8?B?QzRqekJnN2djSHpNOExBMHpqa1h0RGIvanMvdW9iVnMySlJpSUg4L0QyY0VT?=
 =?utf-8?B?ejVCQjN1Ly9vWVZLNWxvWEozckYwWEdpVk50clJBdGFwYzY1T01kOWxHdXVj?=
 =?utf-8?B?eWFpeDFBQW5lY0VFMml6Rk5mVk40S2dQd2RTZysyZTVWcytkbjdJa3Q0bnhZ?=
 =?utf-8?B?bVFXdWtIWHo1REcvQlRRdGVreVdEcnVVaEJhVTRZLzFtc25GRU5qbEowRWMr?=
 =?utf-8?B?WjI0TCtVS3ZhL0FYYWo4K1YyYi9LODBoM3JGeXpzMDBUOEZQaXFTckF2MURH?=
 =?utf-8?B?VmM0b2NPUlNWS2Uxdjc4aVNGQ3VXTVlLbVhIbjRhYkRZMXF0SVJ0SEZUa3Bu?=
 =?utf-8?Q?CuD77Us5SuNBH0N3GUkJtriiHkhvkoQdaZ7hI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V01Pbnc1aW9scDdpUjJDTHUrb0NlVmQ5YWRYdHh3QkZySDJnUFdqOHhLMnlK?=
 =?utf-8?B?OFhWL0o1Z3pmYk1TYjBVeVVLSm9DNlltRHBNVFZ6WjJUR2RYZTN1OERrOFZ1?=
 =?utf-8?B?UGIvczZZWGNPZTkySDMxOUJOTGtvbGR3WDI5VnVZdXRtTlBWU2NXeFhYckV4?=
 =?utf-8?B?aGVJcG15WUkvSWhKZzhvUkk1K2g0TzhjZUQ3KzZaV2tMVUxHM0FsQlRLQ1JJ?=
 =?utf-8?B?NHlIendqN1dnb2hxUURXVnpqR2RPY2xZOXMvNHgrNENCdWRCOFNienlZOTJN?=
 =?utf-8?B?Wk00dTNMcHBhL3IrL3o5dVlqYWhSTjhUSExJb0ZBc1gxRGlkWG5ocTI3dUJZ?=
 =?utf-8?B?Wk81UzhVZGc1V0pVa0NvWmZFcVg4RkMydHM4ZTVYd3dHdEtPcGJWZENpTDla?=
 =?utf-8?B?ZWlhS1RWbzVjQUg3TEtCaytGdzlKSUJ2MGtGeWRLVlg2Q1o0YUhoOG1SUzFq?=
 =?utf-8?B?ZUx4OFQzY1Bscy9WSXRWTUIxNmJDS2xBekVTSHJoQ1crVEh6eTVtbisvc2Np?=
 =?utf-8?B?czJXbUNYQlArM0E1R282eDhDd2l3M3pYalM1UHJaNUJ6N01rWXR5U3MvYitl?=
 =?utf-8?B?eHhuVU1oWUY4TzVHUFdPcG1BQ0VIZDNkbzZCUUtLNW8vZGU3WXluSGtnOGxm?=
 =?utf-8?B?dHV6amc1NU0ya0xPalFnN2YrVnhUa2xNbDQzbDVpQlFabGYrZEE1ZU1GZ1Y0?=
 =?utf-8?B?TnA4OWpuMHZuc29jUm03VEtxUFVJc2FGaW9YRllDS2NjVzJWQVpkSllPUEhD?=
 =?utf-8?B?RUd1R3Z3bjB4V3FCMlN5a0s2MVA0UDFLckROTlZncW9BaDU0bTN1Nmh3TGMz?=
 =?utf-8?B?UFYwYTdHNWhKT2JYSVlVK1ZZSzhtb0pNNi91Zm9aKytJbU5DTnpIbUttQXN1?=
 =?utf-8?B?d3YvUnpOVEc3MHpZanlwMytkWEMwU25NQitvVmJuYloxeTNWN3Y1Y09ia0o5?=
 =?utf-8?B?VWYwaTF0cE51anBldXJ5UHFlRjZVVGYwTngra0s5MUFFYUFSUy8yQ1ZMNDBh?=
 =?utf-8?B?U2pucDA0VzRtcDcveW5KUG52UmtBaXpPSHJnRmNqZis3V1MxZnR3R2lWdkJo?=
 =?utf-8?B?eWFDQ1AxL0RPeTI1VFZ0UFBWVFppSVdSNEoraDRnRFhabmhnbFkyMThVd05H?=
 =?utf-8?B?Z2lRYUpZOFkwbndtSXNOY2RLQVdzT2VKaDZ6ZkxRazZUMGJma3BrVElWZWg5?=
 =?utf-8?B?bmdFQnkwaFQ4ZEpwN2p0VUR6M1pJMGpIT016OWZYNUpNRWpBT0ZuU0g0WkZ2?=
 =?utf-8?B?V2tHV1Y3d3ZFYlp2U0pJbCtoSTlRcEd2MDgrb2xwbFpRc1JQc0ttdUxxNGpv?=
 =?utf-8?B?SEtDNDJkSDRXODIrY3hJbm9CQm1Pbit5b3ozT2NsYU5mWnhJR2dpZEc0dmJS?=
 =?utf-8?B?S3ZjcnNMMkxjYlZna3RMOVZNUGlReHpiV3VsNTkxZk5tcXM4bnJCNThma1Q1?=
 =?utf-8?B?OGFkRjU3RUt4ZFlwWEpPS1kvd3RWUzV0bWVZK2dZUmliSDdQVUZLNWQ0L05X?=
 =?utf-8?B?NlJKNGdkSlY1d3BFSGZML0hjSkhFMWFFcWJiY05IREhUd2pLU2RzSVZaa3ZO?=
 =?utf-8?B?aWdhS0g0aG9lSjBlbkEvbUNlaGhqd25oUUNSNHBoTTlCVlJ6M1pCLy9MMGd1?=
 =?utf-8?B?ZkVjMUtBQlhaTWxJSHBZakhnQVdVS0hDRWZmNWVQcTlGZWdQYnJGOEpqZm1D?=
 =?utf-8?B?S3EvME1WMW9NUUhmRFJZcGFqK25lZHBjRkphSGZNa0lsanhlNzgyNDRHakF1?=
 =?utf-8?B?dmh6dDZZejV5TEhnTUphOG1ROFhVNGpkczJBMkhqNEFWbm9UaEd5UlhUa3Zu?=
 =?utf-8?B?bUcyQ1JuN21lS1RkV1lzRWtPOS9GcDR4Ky8xeSt2KzlDK1pYaWwwTklqUXhn?=
 =?utf-8?B?VXNpcHd4bHBjNnNmVzVZZWFuOGtuY2dmRjBYc2F3WWkvTE5wUVZXQ0g0anA2?=
 =?utf-8?B?b1BEVTR0K28wUTZjZ3doam10THdlMkdKbERZdTBoLzVZQitUalpXZjNsNWIy?=
 =?utf-8?B?bDZxYzhvOGpqUUhDWThGN0RNVVBLRFVjZmRpRHpiajdyYmFDTHNLelBJTGxU?=
 =?utf-8?B?d3RFakJ4K1I5UHBFZUZEKzR4RUxxNzVmM1RvZFpLcmI5Tk9sY1dBRUNzOFF0?=
 =?utf-8?Q?A10xFd/5ghNrYCHrADRJ0ITrk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b389da7-b06c-489f-b3d2-08dc9240d540
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 22:23:53.4269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWQZEIQvfCnz3GQuVUfPuZioB2TpsEmy8YAnQUE9E9qRJSlSBte5vMx8nuAiStIqvnvJp4fjKz54IO6VyIvv6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8163
X-OriginatorOrg: intel.com

Hi Jacob,

On 6/11/2024 9:54 AM, Jacob Pan wrote:

> 
> The functionality of NMI source reporting is tied to the FRED. Although it
> is enumerated by a unique CPUID feature bit, it cannot be turned off
> independently once FRED is activated.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
> v2: Removed NMI source from static CPU ID dependency table (HPA)

I am not sure if this would work in all scenarios. See below.
Sorry, I couldn't chime-in during the v1 review when this was suggested.


> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 4fa0b17e5043..465f04e4a79f 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -1427,8 +1427,10 @@ early_param("fred", fred_setup);
>  
>  void __init trap_init(void)
>  {
> -	if (cpu_feature_enabled(X86_FEATURE_FRED) && !enable_fred)
> +	if (cpu_feature_enabled(X86_FEATURE_FRED) && !enable_fred) {
>  		setup_clear_cpu_cap(X86_FEATURE_FRED);
> +		setup_clear_cpu_cap(X86_FEATURE_NMI_SOURCE);
> +	}
>  
>  	/* Init cpu_entry_area before IST entries are set up */
>  	setup_cpu_entry_areas();

I think this relies on the fact that whenever X86_FEATURE_NMI_SOURCE is
set, X86_FEATURE_FRED will also be set by the hardware. Though this
might be the expected behavior, hardware sometimes messes up and the
dependency entry in the static table would probably help catch that.

IIUC, when X86_FEATURE_NMI_SOURCE is set and X86_FEATURE_FRED is
cleared, cpu_feature_enabled(X86_FEATURE_FRED) will fail and the above
check would not end up clearing X86_FEATURE_NMI_SOURCE.

Isn't the following entry necessary to detect a misconfiguration or is
the purpose of the cpuid_deps table something else?

diff --git a/arch/x86/kernel/cpu/cpuid-deps.c
b/arch/x86/kernel/cpu/cpuid-deps.c
index b7d9f530ae16..39526041e91a 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -84,6 +84,7 @@ static const struct cpuid_dep cpuid_deps[] = {
        { X86_FEATURE_SHSTK,                    X86_FEATURE_XSAVES    },
        { X86_FEATURE_FRED,                     X86_FEATURE_LKGS      },
        { X86_FEATURE_FRED,                     X86_FEATURE_WRMSRNS   },
+       { X86_FEATURE_NMI_SOURCE,		X86_FEATURE_FRED      },
        {}
 };



