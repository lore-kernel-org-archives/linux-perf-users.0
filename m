Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551394A06;
	Sat, 22 Jun 2024 01:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719018502; cv=fail; b=GaEszdulORkQSlAmM7foTIj7WugdUY699qizhxPtcbhERqCoLO04u9GWWXIAJi2OP5T5lcZX6oBJnOAbMNXht2jArwshz0OIC1SMmqZK69iaQksEzLxuTzBWf25OpV/Nlcn03jA5hjlaACDw+1eCKK3NvzCQoPM3VGB1mZ8SIUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719018502; c=relaxed/simple;
	bh=+XMMl0RYhA7YlqNIbezAuwuh++7M12GIeYAk+WfCjH8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I1AGRsgRJExIqfshYMes02E1xDNSK0G+M8YQYHw9p0wm+Gs9LbM+6ZmLDGFtFv8Nyk0Jv3Hsf/dsyAdpW8dlfGFHdG1DKCEjE0X6ff2v8p8NGv9LYUHANKxVbHQ6heZkLiqUBnwwABmZMPrUSvTR6aFi7XZaQ7fG9m8WwM5QPkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TfGmXoWE; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TfGmXoWE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719018500; x=1750554500;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+XMMl0RYhA7YlqNIbezAuwuh++7M12GIeYAk+WfCjH8=;
  b=TfGmXoWExf0EWbwGMGtAQBqabzzdXS9/XcYkzyA8RbnlptWTm32ARK5q
   htL7xLHk80+XK+GyZYS6h7SjVnJ/1CCkIsID/GMuQdCy7sudB7HCdV52E
   0aCyR4REsi0Pr7p0Qpyo+MaVgRXsHQSCitYlthq+z1K1k5MwOb7dMReDM
   Q2u1+PDi/juqIb8kmTgMbJ8BnF7NxO1ciYdSeLkGYeeHYgljSht9KJh7v
   iELoFjbf25oXO0ccvkmTibNp4VjahjHReBnS50XR9J6zHDa6loQwkAzx4
   00x6iUO8Rcu+NcQOqAqi9/NHcT2xdp6xciFZNMb5PUbIDbWFrRKfvTW13
   g==;
X-CSE-ConnectionGUID: KEk7UWNGTAyKD1S0X+rScw==
X-CSE-MsgGUID: GZuPthEZSR+21EJaidWB7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="19880732"
X-IronPort-AV: E=Sophos;i="6.08,256,1712646000"; 
   d="scan'208";a="19880732"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 18:08:19 -0700
X-CSE-ConnectionGUID: zdUAxxhCRS6Xm+yL94sEYg==
X-CSE-MsgGUID: aITe1eA2SFyoMsyBVuZISQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,256,1712646000"; 
   d="scan'208";a="73493984"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jun 2024 18:08:20 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 18:08:18 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 21 Jun 2024 18:08:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 18:08:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QaXb8a/NWlCs9C2CVF9CVIkGfr5Drz9Qh61VVnRRwVOjegRDi20QTrLDiloCn1TZgtEDimO5spHL/yanBNQ7bM5LJ+1mqT/+AzxrGgkH5Xc52Lmkmd+0lL8YO8u16WgFqc2ctFfZv05jGwUQmqbmqwJtmy3/yFPa+xFcyNOU6f6CzolzWwD40XejRw8XPrsLpIpwImJb5NbakCKeqNFMIMHRzK/UcBGZytAQrkHLER0Esu53i86lq2jCfzCbwUIAwucmGI05Tu/8HhFLvUNvxqOM0NoAbho93RSV3TymA64LcPuDpuQHVKT3Oe4wxco/NDBMCdBtQp9KWj+OpEclfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJfaz3yWyqhF1YNIXp+EvWg6CpIFk0pdvGD/exTvDRE=;
 b=W3pNXd8vV18+rUUQ3QkAdCipeX2zlOQFu999dueLuS/jxNlHVPR114dxfjIaMtf02obctfwNt/1M/5ZGA0R4E4eRSTExgBWcP0bCqIg/8WwFTH5J4ePXncTd7lZ+Eo/0ltR78eKnpRWIcGkrE3tciX0iEN/7iQXvgQ3c8nx7V+leOsuFS5e/SiZMTSEURL3mnDHatakJTtPxoNVI72dgsKjgE2cLxb5Nfwn7r75wxyLDA+kjwpG3X2o8F98o1XCFo0ijRyeprqp+kVdm+UKQXUzoq45hu1fb6eI12cy/TWbZXr9qJHNY0aA/OPbMl9f9BMw+Hkzu0+02byLETobLeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SN7PR11MB7568.namprd11.prod.outlook.com (2603:10b6:806:34e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Sat, 22 Jun
 2024 01:08:16 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.7698.017; Sat, 22 Jun 2024
 01:08:15 +0000
Message-ID: <004f6400-0d35-4c5e-ad31-094be8860f08@intel.com>
Date: Fri, 21 Jun 2024 18:08:14 -0700
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
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20240621164615.051217c4@jacob-builder>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::26) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SN7PR11MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: 5944f57c-d166-4e2b-2bcd-08dc9257cbbf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2dpZWJmU25PM3hYSm9FaWxOV01HcmZia3pJQ3lndmtaM3dhZlFqdk5FbUcv?=
 =?utf-8?B?V002VTlCVHhIZnpJNVk0cXpraTlIRy9YWmg0R0VtU2ZQODNHamw1elBRdlI3?=
 =?utf-8?B?cEFseXY4QmsyTEp4UmRxak8xOUg1b1NEam1tb0RXWVpGNXJuVzZsWUFqa0lZ?=
 =?utf-8?B?eEk3WlNia2JUUnNIZlBqYmdmMkxBWW45aHhXSVh0a05uSy9FWXRsRFVzVDFF?=
 =?utf-8?B?ZG9LMTJ5ejNUd3BFYW1iUFR2UFhmRVFlUkl4eUdsdFJaNkRLUDN0QnptQTRF?=
 =?utf-8?B?UjgrcmJqNjVOZmV0UTVjemRWUjQzK2RGbVVyRjEzakI5SE9qU0JDRHZDUng0?=
 =?utf-8?B?VGdHUmpQWFhPL3ZTK0NHTE41S2t4RllOWUphQjFmOXRkbXU4cHRHNEVabW1D?=
 =?utf-8?B?VmNDSmkxY2QxcWtXTC8rRnhnRzBpOVBTSUZVK1BscHYwa2ZTS3lOSWRqakhW?=
 =?utf-8?B?NzFXeDVvOTNqdkhNSkIwcTRyY2JEYk1jbHNxU3dkS3JLM2VkRXhvTTY3Z1Fa?=
 =?utf-8?B?cEEvbFIyNCtVNk4yM1RYY1BSeXdySWE0QXhJY3lyOUlvL2ZrZ2JvQjB4Mk45?=
 =?utf-8?B?dE50WmZOaUdOUjdZTGx3Yk5MWVpUTHNxMzU1ckUrL2gyVUdhcFM0c0JNR1ZZ?=
 =?utf-8?B?RVoxL1gvVnozbWFabzE2VGdhTFgvSDJ5bVQ5VzJSWDNyT0F1bG9MdzVEbHd6?=
 =?utf-8?B?MDREVEREZ0c3YjFWc2F4U285VEtldE5KblJuNDBzRUppVjVvUGVvRlM3Vklk?=
 =?utf-8?B?VzZXR0U3blhGY2x6aUNFd0VZaEkzeFQvbHdpU25JUU1uSUFXK0Zqc1FLSXdw?=
 =?utf-8?B?QVBiOXdrN3ZaczJ3eEY4RTNqbDdxZElSakF5Z202SFRtRVZQNktoSVJncGpC?=
 =?utf-8?B?czJxdVRHRlE2eEZZYVc4T1VkL3BxeTFmcmdxTmNSYW95dDFRbzNlcXlwODJn?=
 =?utf-8?B?WEVKb2dTbVhlVjM0UUlGalRsZGFWV3N3SHNBYlBRTW1tSjV6ZUh2d1VUM2ds?=
 =?utf-8?B?Y2hXNWViMGlLZWFFaVB0RjNhaEsrck9OMW03ZEJFd2Jad1VjNmFKWlNGTWxO?=
 =?utf-8?B?bGV4Sk40OWhFOGFPNStPTkt4eDQ4NTBnaUJKVU1MNTFqQldzd001RzlNSGRv?=
 =?utf-8?B?bGVVR1dFcFBiTHRtNVZrWUR0OHJJdUJqZDBNcE9VY0tMOHdJdjIvZlNESno0?=
 =?utf-8?B?Z0t2amcxbStPUTNnNDRvbU5aeVRHbkhiR2w1emIza24yRUF0dGMrbnBNb2ZF?=
 =?utf-8?B?WGJxMjV0czFYOEt4UUdCZ2xIQ1k5d3pmK29iblJNNm1PSS8yVVZqcEc2bGhK?=
 =?utf-8?B?R1U5dzFwL2wxVjZIcTE0czJYK1Z0dXBqRFRyaVJKMDEzVEtzZ3BhT3hTbURx?=
 =?utf-8?B?dkJDd3FNZ04vNnhhMFJXR0x5Qjc3WjVJVUZsV0tnRVdwZ2krTkt2S3lVMzVx?=
 =?utf-8?B?VkRqYlZ3aThJdU9lNzJDNlQvcitSUlV3VzZTc2JHd1lzYXdVVlVpSUJPUkxw?=
 =?utf-8?B?Z003REdaZGI4MVpDRE9HSk15QW1qUlJJZkkrY0xxekVnTWRFM1NjTnVDN1Zr?=
 =?utf-8?B?ZWZjWEZvZXRQTFg0dStaRGtmT1FxY2pHVTlCcGI5emFSR1h6NEUreTZUSEI5?=
 =?utf-8?B?dGlFM3p6bmFSZVpDNThpakNOdlovUGxKeWhBZFduM0RLeGNSYnZ1SVlaZmlT?=
 =?utf-8?B?K2J2bWFhQUQzbW9sN09ZcFU5UG1ianZGeEpHcjlnZmx3SExINEdmQzZjQTds?=
 =?utf-8?Q?xy3r8Tii1Horda+Z1Jbkx0eptQ3cyL8DYJ9Zuz+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTE4eFJ5VXBxNVByVWtkQ0psNjcvOFVGS3BlcjY3Yk1pbU1BS1Y0VVorTWt6?=
 =?utf-8?B?QWJhM20yQ05ER2ZHZTM2Wm90OXhrQ0VwK1NqMlo0cWlzeGIzT1NRRjZIaE9v?=
 =?utf-8?B?M00yTDJvbnBDams0S1pCUDAzSjdiRUJ6aCsxQVFZazFpQVkrczhDVkV4dmg5?=
 =?utf-8?B?SURLVjQ4NGE0R3FYRm5YcHlhRUNDWDJqZjg1UjZUOGU5MW1iQnFqTnhyamI4?=
 =?utf-8?B?TjdmcCtqR1Ntb3B6aCtZYlB4YnFPQ2dVM1JXeEszTWp3am00VEZpRjFHNzBL?=
 =?utf-8?B?RDZoMFRHaVl3SDgxMmlRSHZEVmh0TG9YZmpjdzhlMUFrNUZOOGJ6Q2RxUWx3?=
 =?utf-8?B?dE9iU1pFZXN3UHN6M09QdW9FMjB1Wmt6R0tobWRIL2prenU5ai9TUlB0WGcv?=
 =?utf-8?B?bnhUVkZsZjgvSG9RWlcyYXhxdmZ3aThtb041b3pVeXJQamUxTzE4SHVhdmIx?=
 =?utf-8?B?TmwzZUpKRFUrNXVoZXZVRzEwbisvZ2l4eHV5NlV4azZqNW1OUVpBcDBnSURr?=
 =?utf-8?B?bVB2ajdqY3ZRMExaZTRGTXgzZTJoWWJ3RzVab0l2M2VKTEtGNzFDR0VxUjVO?=
 =?utf-8?B?RWFvd2hSWnJKaWIwL09NYWxRZGk1RjBqTlUwdkRocHZZd25XbTNSOFdZY1Nt?=
 =?utf-8?B?Qm0xbmhmaGlwRkxBWDJ3L3M1dk9GcGVoSVhmbjZSR1VYaDE3L3kwdmkxM0RW?=
 =?utf-8?B?WjhnZWpSUC9qampOM3dGeG9JQmJSRWc4U2xHU0FNeldnODYrdTY1TmNsY0JV?=
 =?utf-8?B?ek1PZTJORTFsYUZaOVZzRDdqMXhlMFAyYnVNaUZrWHNXMlI3Y2w4OWxobGt5?=
 =?utf-8?B?VFIyRmVnNWJDTnQrZnYvS2pHdzdmbnRVSnpnU0pRdGQ1U1lUSkdvY1lyUUJB?=
 =?utf-8?B?aWVmODJjQldoTmk2bzFBbXZubmZpbWsvTVk4bCs0bGV2c1phckJvd0hSZDBZ?=
 =?utf-8?B?YVpuOUNESDVzcEdtcGN6elY5Wi93N1NFNWt6STVVRnAzak1aSGFCdWUxZDUw?=
 =?utf-8?B?cnhzUDVSbnp2TlgzOEtlM2hHNHgrazdLVG9QZzBmM040Y3BWK2c1bGZHZXpy?=
 =?utf-8?B?N2ozOWJLY3hSVXU5NjVEUEN3b25DR3FMMUVDMU9UQklDVmpJRiswMWMyTzZo?=
 =?utf-8?B?cDhLUEpLaCs5dnVIZXB6VHgvVGZUWW92Rm9GM1d2Q2o4Nk9QYXFLVlZ0b0t3?=
 =?utf-8?B?WmFFMFlxTnZkSTkwTTczQWcvTEVzc1N2TjdSc0VtM1FYTThIbnBwMHpkTDBp?=
 =?utf-8?B?dzFRVG5WSzFmTnAraExsS1NlQ0pCbG9nMjVHTTlBNTRTU1UwUm1UVXp3L3k4?=
 =?utf-8?B?dDErUFVYbzhZckxGZTArY0JnQjdYdy9zNTN4WGxsOXlpUHo4ZG9ybHY3UEFz?=
 =?utf-8?B?ckxyclJ5dHo4YnFCdjg3b0RSVGErOXlKQVArdnZiaWNqMEdBSXArNVpiUFk4?=
 =?utf-8?B?bjdKRDcvQXAwT1A1SDdoWTUwQnEyNzFteVViUUc2VGZqMjVDdXZNSnYxWVlI?=
 =?utf-8?B?Y0VRdDBGaWpsM0RPL1h4eWRacHFsNkt0S2tKN0p1Y3FHUSt3NGNkbWkwTGR0?=
 =?utf-8?B?N0haVk1vakVxQnZJNnFiOXY1bk03aitTK01RR0txOTdIQ1d4Ni9LRkJocSs3?=
 =?utf-8?B?USswRjg1OG9SUFdQd1dQeG9lbWJHY3AxaGpqc2RHSFJRd0lHNXZjMVRLVnhx?=
 =?utf-8?B?dC94QUNJYTdtVHY1ejh0R2tnS2xYbG44YVROZk9SWXZwRUtWMEZxYTBaRVdN?=
 =?utf-8?B?Y3R4Y1hsenRYeWk1Q0sxY0paNDlOcnl5bTRZRk5RTGczUVpsTGorQnJQb1Q0?=
 =?utf-8?B?akRndEIvM29FZ1FQNXh4WUhJT3lhVkUyeGMrVkM2MkxhSkRsUHdOWCtjVVJk?=
 =?utf-8?B?b2JpWkJKVWtPbWRtSGNzUlJzNi9SbitONndETmxBOERWSnRiRis3RFZFSzNo?=
 =?utf-8?B?NEh1N0pxamk2dzhnam5CNmMwQTA1dzV2UUcwdE1vMGRnZjFZVXV0b3lZY1pV?=
 =?utf-8?B?blRHaHMxSENFdkttZzR4UHhuM1lJSktOeVl5L3NGMDlpZ2d5MGprQmJhV1NP?=
 =?utf-8?B?S0lGcnpaODF1Qkdodjc0MlhZazRKQnRSMnNPWm1LLzBQcTVIMHBsSEhUbS9s?=
 =?utf-8?Q?nPJfGKOSIquyrqPsz6Uykjx1T?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5944f57c-d166-4e2b-2bcd-08dc9257cbbf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2024 01:08:15.8827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NAl17+UEDI6oUOYgEs0eEz8P94l672S9HWJ8uCLBktooPtaBIJSRpejKBYYjF/GJ++95eKW2TwZSG1hqCR4+CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7568
X-OriginatorOrg: intel.com


>> diff --git a/arch/x86/kernel/cpu/cpuid-deps.c
>> b/arch/x86/kernel/cpu/cpuid-deps.c
>> index b7d9f530ae16..39526041e91a 100644
>> --- a/arch/x86/kernel/cpu/cpuid-deps.c
>> +++ b/arch/x86/kernel/cpu/cpuid-deps.c
>> @@ -84,6 +84,7 @@ static const struct cpuid_dep cpuid_deps[] = {
>>         { X86_FEATURE_SHSTK,                    X86_FEATURE_XSAVES    },
>>         { X86_FEATURE_FRED,                     X86_FEATURE_LKGS      },
>>         { X86_FEATURE_FRED,                     X86_FEATURE_WRMSRNS   },
>> +       { X86_FEATURE_NMI_SOURCE,		X86_FEATURE_FRED      },
>>         {}
>>  };
> If FRED is never reported by CPUID, then there would not be any calls to
> setup_clear_cpu_cap(X86_FEATURE_FRED), so this table does not help clear
> the dependent NMI_SOURCE, right?
> 

I thought there was a common function for all features. I expected it to
go through each feature and clear the ones whose dependency is missing.
But I can't find it easily. Maybe someone else knows this better.

However, anytime do_clear_cpu_cap() is called for any feature it does
the below and scans the cpuid_deps table to clear all features with
missing dependencies. That would cause X86_FEATURE_NMI_SOURCE to be
cleared one way or another.


	/* Loop until we get a stable state. */
	do {
		changed = false;
		for (d = cpuid_deps; d->feature; d++) {
			if (!test_bit(d->depends, disable))
				continue;
			if (__test_and_set_bit(d->feature, disable))
				continue;

			changed = true;
			clear_feature(c, d->feature);
		}
	} while (changed);


> In the next version, I will add runtime disable if HW malfunctions. i.e. no
> valid bitmask.
> 

I don't think we do this for other features that have a missing
dependency. It doesn't seem NMI source is any different from them.

> Maybe we can also add a big WARN_ON like this:
> if (WARN_ON_ONCE(!cpu_feature_enabled(X86_FEATURE_FRED) &&
> 		cpu_feature_enabled(X86_FEATURE_NMI_SOURCE)) 
> 	setup_clear_cpu_cap(X86_FEATURE_NMI_SOURCE);
> 
> Thanks,
> 
> Jacob

