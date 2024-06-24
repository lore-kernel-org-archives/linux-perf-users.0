Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151C31A2563;
	Mon, 24 Jun 2024 23:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719273251; cv=fail; b=MQ2Hd3nc2Ue8aKq84T+IbC69nhF4N9ZG+wU++UooQiKfl4ygcQIJn01UCl0OC5smBpWOvSCokAArGgyZGxnbYWKJIG2zNJovj+1NArRxJ+H8yLKhaiLWeU5O8ZaOSI+/azlBel4YnL8B7WoCexB7LJ4wLboTSnMn+BXtKicUMv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719273251; c=relaxed/simple;
	bh=dI7/0BpvRp3/ijFiN4v6FOM9byY9gYn2ZxciMGh8Aqs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W/oNUOE/u0olaxE8fDRXKtTlPhSoyFGaHQ1iHBBGZyJro/Xb02UvqmckEZTbC2o/KK7D3eLlXxTZHKPXtxtGf9gnhhhAmxnbzXhtU+O6p2LShmuBkx6NcjMC4megebwZrOxY5AP/AiOQWcnCP7hSRKIAUSv/Wyvn4IbHoZfqmME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L/A7buX1; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L/A7buX1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719273250; x=1750809250;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dI7/0BpvRp3/ijFiN4v6FOM9byY9gYn2ZxciMGh8Aqs=;
  b=L/A7buX1a2BdN1BKsg3/9Sume6mJ8BC924lPW4HpgKVSksZ6BR8+pC1a
   avNekoTPgaYcIRinK+rC+zGa1bOxwB6pNQkc/QnXahKv2ZqhZ49CLRV68
   zOWrYVTICs50a5YDeiWbIv4x8IYhMNi2PI73n0g/vCKl85g2bnqLsABA7
   qcnI3PfeMBczfoVB3kRjb+WUPjdNfgbQccb6efsBRlhIlTZbmC9G5OGGV
   K2UHzb6YPGKmxOeYL4/d3taB5By22HbXolw611vNArtFlnjzJchXE7HBC
   f2GG2cZn0+0iWwxTWP9wkgajH0v57I698y1lmbGzDis0POViK0kIeXP6L
   A==;
X-CSE-ConnectionGUID: 2z1NUQggR9Ccm/fybV1ucw==
X-CSE-MsgGUID: gIkW1sOGR6yooQr7KbI8GQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="27677282"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="27677282"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 16:54:09 -0700
X-CSE-ConnectionGUID: so1aFjtIRr+IslD5xzNS4g==
X-CSE-MsgGUID: MTHmJx6ARFiydVNXWZmWLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="48410179"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jun 2024 16:54:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 16:54:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 16:54:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 24 Jun 2024 16:54:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 16:54:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFa7r82L+mJpOo71Cr1Ic2DVcu40A4n8onSvc8l/T0P49Ol3zY+FF192ZDz0Aj2SXhbgy8GqzKq2zQ+A5cKQW4k9BIqKfRSV6K6OXH72FsScgy2PM2SieoJYjwWeMXfKfbNwwsP9U7GTPmyRR+IFprgpp0wkI39GTHtTmHDP1dVspo+ZZRnkpfgkjNx4XAgKG4eqkYD4frHAzBrFJ++a5RBcYKa4927s4kVyq7jezmjn6I+XnQTP265NSx0LIryAkUr0IsUN2Sm99E/6hut3OmumVWLupnTotKtSKWhLw4U3iowFMzvb8eqsV45zSb1ufTp97OLe2H5zwB7kvv2xCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3r3KSuH2EcqnEeLQnttj5NXS4ImPHw5cW8ndWl+mwM=;
 b=hRp/afyMsDqc5DTSXxhIPVIsG5s0ILH8Gt6zJyMIK1PIY9AP1AjOQEcOfhGCZB6Rd/P73vRA8EVoM52ISdQ2igwFmv7YJH68yyoS2FVVkwmvB1cWuHGQNp67PIdaL7VJujven+iWeEMRKpKdGGhB2dkLVxlQventZSHVHI94h39FO3Y5ASUx1vf1XJAQAN9ZCw5SpllCwRsitcMgazPnWeOWAb7PBBxd5XzLmDGz9d7aG2kaq6qboZNx2b37LPB2XsUPVMK4BUWM/4LxuI0lJ6Ve67BihcWjPrYt4BPr43C8LuIjiVgc2TIJ2jN6KpwcQhdHrI2nHw6N3/trdGLrDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BL1PR11MB5304.namprd11.prod.outlook.com (2603:10b6:208:316::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 23:54:01 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 23:54:01 +0000
Message-ID: <3bce15b2-c69c-4021-8b9e-0eba61487051@intel.com>
Date: Mon, 24 Jun 2024 16:53:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] x86/irq: Process nmi sources in NMI handler
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, X86 Kernel <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	<linux-perf-users@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
CC: Andi Kleen <andi.kleen@intel.com>, Xin Li <xin3.li@intel.com>
References: <20240611165457.156364-1-jacob.jun.pan@linux.intel.com>
 <20240611165457.156364-5-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20240611165457.156364-5-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0292.namprd03.prod.outlook.com
 (2603:10b6:303:b5::27) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|BL1PR11MB5304:EE_
X-MS-Office365-Filtering-Correlation-Id: fd5dfb3a-f495-47a6-5553-08dc94a8ebc1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021|921017;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RS9uN3kzQU5OUjRRZ0NjcVkzZ1hvc1REcWZpSkFheGx5bGp6Y3FNVjhKUU9k?=
 =?utf-8?B?eVNYM29SenZPVk11MG1zZkRieEovRk1DM0FleDZsUUJjT1Zia1lrWjFSRWxV?=
 =?utf-8?B?cUV2UFU5L1ZPMmZyWUJWMzBnNzRWTzl5cDVKdGw0RGVWclZNRGhNSHJGZG5t?=
 =?utf-8?B?VnhpdVRWRUNQUGl3Wmhzc2dVUC9ueW4xbXRzbUJhbEpNNnFhbExLQmNFa3lo?=
 =?utf-8?B?ZHhsVDBONzZOYjFxdkEwOFhzYTRvUVh3clZIUEJ0TWFjcFhRaHNSUU15c29X?=
 =?utf-8?B?eDJJNlkvdEhRQ1NER1QxSnZUWXRTMnBkUXVqTEdmNTU4dFEwelp2ekZ1UFpF?=
 =?utf-8?B?MnVpOEZBeGdVMktTZm9HNk5OZ1BXWHdESHNoNVFqUDkreFJvdmpDNTBtOGFC?=
 =?utf-8?B?UndGWHhTVitKQXBZa3NvU2NjTFhUZmxES1VwcGtUaE9rcmFYL28waDdlc01z?=
 =?utf-8?B?cVZxclZKMUwyZk5vOGczVmt3VWxSRUpqNzFRU09yb3VHUXg4YlNFejc0YzVN?=
 =?utf-8?B?UUdneHI1aXZvVDd3UjBXQUx2UzZWckY5Z3NpdWdTNHRUQzhSNVN1TVZxSGxH?=
 =?utf-8?B?cjNCRUlLTXMxKzlta2MxTDY4VTNvYjArMU1VczZxTzBUNG95b2hpMDBQNTJQ?=
 =?utf-8?B?S0VEZ0RBQXM0cThnajd0cWNKMjJpZWVvTXM1NEkwblRqSEhtZk9uMitEaEo3?=
 =?utf-8?B?NXJnSmZnWXd1Y0piQ3dPNFlqSFJjc0xvNGRvajQwM0taRnU0SGNEd1ZVMjc2?=
 =?utf-8?B?K3FIUVhNZ1pLUCtQSXBseHRIVURVR05IMWloblVOWjFVd2ozNFVubVdGS3lk?=
 =?utf-8?B?VjdLYWJsQnQ1N3d4UDh6VStZYUxVbktFVUVCam00VnZaK0ErZFdQa1h2ME5E?=
 =?utf-8?B?U0licDYzZklkeXB2S0JoUjg3cU1SeDFBZjdwYzdsYVpwL29GODQ1V1M4RS9Z?=
 =?utf-8?B?RmtZdWlqckdZQy8wbTJuZlo3eFNJZ1p6M0dtWE5mZlN2YW93bEN1Mk5IVEQ1?=
 =?utf-8?B?SUNadHZmdU10cDZsckF0RVpWWmR1VnJia2lmeHZkNGwwUDhNa3hkM1FwRjcx?=
 =?utf-8?B?NVZpMG1PR0RTR3ZOZExyY2MrbTNZdUtRbmZtWk1jeWZ3OGZ5cnZYNVllaG9x?=
 =?utf-8?B?anRiZkNiZk1pNEFjdVkvNTJxMzRLcURhMmxJenRpNHQrR2JyVTNoaE43M09T?=
 =?utf-8?B?RzVKbDhNNXZOaVlVNDFCM0ZFZE9LUGN6dDEwUjdsemVxNFk3M01LemtpV29F?=
 =?utf-8?B?SFlzS2pZSk11Y1cxMy9QOVlEL1RPY3JzWmlLZnpWK0FZT0xFUm95MkpTaUxE?=
 =?utf-8?B?YXdoZk8vQ3ZUeFFMOEw1eSt6ajB3THh1RzkyNCtoWVNTbmpaUFFKelNqVVkw?=
 =?utf-8?B?b05lWTVHN2dIL0FsOTdrSVhOM2gyenJCamxlcW04cnI0T01FWWgwWjhhOCtX?=
 =?utf-8?B?T2ZHQTJienMwNzRsQnFWSU1OeTZ5NHNzLzRtY1R1QSt4aDNuRmlRZTV3WTJq?=
 =?utf-8?B?d2xoSkVzZjVvdzlieFNDTmtnSmE4d0NlT1R3aE5Teno4dGFJSFZXREF6VExl?=
 =?utf-8?B?MlFyM1RuQTJ0NGRKS1Q3VEdRR1BHWHc3WHFZc0tTbCtZSVVhUGdCLzJpN3c2?=
 =?utf-8?B?VVV6M0w4bENKQjVCa29VeTFDSWY1ZHlpQ2dBQUVsemVSWEVSUWppZG94MG9Q?=
 =?utf-8?B?dEs3MlQ4dmdwRHczcm9tRE1ReElZTHoxVlZwNDN5SDdqQkdIekhDaFhLOGdZ?=
 =?utf-8?B?Sjc2UTAvaExrbDlGVnNsOHNORTEvTUlCSzdGSytMTWlVVGlGNkFGaU5mN3h4?=
 =?utf-8?Q?ZusGioBaSr2k4yxbfstq8Wyvk747aea2WaC0A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk1qMExYV1dJWWlKYnRtU2xVT09OSVNrL3JrenR1OFNMbnNOditjVDJVcUpM?=
 =?utf-8?B?OXNVTEN3aTVWQWhJZU9vVDFmOHVyeElrOW1Ld1hQMDdLbWtZSmlnTkdQN1pT?=
 =?utf-8?B?TzFwZTFweTBKbnd6dFFzdHdvU2FjTEFmMmNkVWZjVWlPc3YycUEyOHhESUwz?=
 =?utf-8?B?eDZ0WTJkQm9uZVQreW02NHZodzFCaTNRZTk5M2J6RGFXSVI1QkdNR05WSlk4?=
 =?utf-8?B?WDY3MGhGZFhXZG1mNEtjL1dIdWtFM1NsUUdrQjNJQ1FBek9hanZzY0FZM1RH?=
 =?utf-8?B?aEdnY1dZZzI4a0Rhb1JVMGRYa3FtL1pFRHpZUlpqYnQzWlNVam9WU2syOXFH?=
 =?utf-8?B?MFlUclZtYUtaeVNMR1libU04S251blJPV1RaMExLNzRITHVDZlJPSUduc3Ur?=
 =?utf-8?B?RnpTLzNveGhzUWpkckJhSjFabXpwaFgwUUZwK2p3N2hsMU42cXBPNy9lUTRU?=
 =?utf-8?B?WGIxL2Q1bXdZbFIvMHNIU2pGRGJYamFzRit6NlJ5Y0J3QU0yS3lPR1QxL0Q4?=
 =?utf-8?B?bHNyUFZyMk1EdG4vQ1Jpc2VKRkI5bTdOYk5LSEtvYWxLNXRHN1hhZFZWN3dR?=
 =?utf-8?B?d3hsbU5zWG00dEtuNitDcmh5MGpPL1p6T1BsNWI1STBqbDQxa2d4aXQzdHN3?=
 =?utf-8?B?bHloTjI4UEJMczc4VkZvK1dIQ0Q2OWExczZhczhWL2JpcmZGeFdhT2xCTkUw?=
 =?utf-8?B?ODBwTkg5cDNlZTlISEJyZkxUTlBWYkdSTHVIUDdXSDdpS25mcUZnZFZ2Vkc5?=
 =?utf-8?B?QWVlWlR5b3NnbS9mOS9kVCs0TXlEY2d0Nm5jTksvL2I0Q1lTTkNzOTlTL0FX?=
 =?utf-8?B?UW0xNXRsSzV5d1dXVVZZb0ZWNmVadGpKQ2o2R0VXRWdlYzVsWVJqK1VQd2Rx?=
 =?utf-8?B?WmM5enJrWFNOeGVFbWVMWnFycW9SL2FzdThla0tqR1pnYitPdDdydCtid00z?=
 =?utf-8?B?aW8vZTNXc01IRlN1YUc2ejRTYnB0UjdYNHQwNHZTTG1EZkRXNkk2QW1Yb05J?=
 =?utf-8?B?WkdCdjE4akRKZkIreEdaWXJoNzc4WkNkWFc2NTZzZ0JaRVJVUVorN0ZOUUZU?=
 =?utf-8?B?MkhsQWFkMS9MZThuK29JMU5JZVhPQnhLL0VsSVRGb0RMS2c4MmNNdktBbExQ?=
 =?utf-8?B?YnlZU2xEbWxQbnExS2FaelRvaGYyR3UwSmorZFVpNTRaQzJnMzlibDJoQStq?=
 =?utf-8?B?a0M1OTVtZ0w0Tyt1Mkx1UGpqcVU2ZnJQeGpDRStoR2lpNzRTOHdZUlZWMWJJ?=
 =?utf-8?B?bHYrNGhZSXlmN2xsZDkrRFF0Y1Noc0RxRk9OQmRFdmZocEpCT01LaTBQVHow?=
 =?utf-8?B?cEpWaXZPY25nakJsR1FDWm1pWThyeHZwci9BQXQ0Y3NEOGQzYVlUN3NPYmNJ?=
 =?utf-8?B?SGwxVFBYMXd0cjdXcmdhSTVCd2Y2cS93REVyWlpzRDZQQWoyU2g4RWVHTHV2?=
 =?utf-8?B?ZXR0cVZDYlNwMERzREdjTGtmWEFhRmlxd3o5MWVXZXJ1R2dzZlhUb0lWdk9q?=
 =?utf-8?B?THhXM0RqRDZlWlkxNkFtSTZONDIzbDJrNVN0dmlmYWZNVlhuRmwyNTVyd1Fk?=
 =?utf-8?B?YTllRzJUU2JScnY4dEN3MkxvUXZ0am5uSDZERmVjR0xlT0NkNStZV2krRnRX?=
 =?utf-8?B?QlpkWWlxMzVqTGtEeG5FcmJGY3ZhalVPQW1QSmI4WWxCWWJ2WnUwdi9IQ3Fv?=
 =?utf-8?B?ZHJTRWVEZm42Tm51VUNSR21JbjJVQktJaktwQkpLVXNNcHN0QU5xdUhleUUr?=
 =?utf-8?B?OGlpRzBSKzl5ekp2UkxZaUs5RTkvdVJPQXRHdzhGTEhHNHlSL25wQkwxVTVn?=
 =?utf-8?B?WEFsUVJVb055STUvZE9jZUJZcEZiVVB5NnlOeXJwenphRVgrOWV3UTRKTTRM?=
 =?utf-8?B?bmRpZmxVd1MxWlg2QUp0VU9KZnRRaUFyZ2FHN3dpQU9NU2JTN01obWUxTzhU?=
 =?utf-8?B?TlJFNWhXR2MwLysxeG1CTWNiRnFFbkgwV0R6YmVZekhJZFNCQm42YWJndDV5?=
 =?utf-8?B?cjdlMjN6Yzc1Y3M2bEVDQnNjSVc1djBpYzBsRzJCUE1jOWljYU04RnAxaFZv?=
 =?utf-8?B?cStrV1Z0WS9uRmpWenRaaWNTV09DczNlU1IzQTdUTWdFTVd4OUhGWHJibjAy?=
 =?utf-8?Q?yKv3P5/wwp3AT2Z7i5x7kyYYp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5dfb3a-f495-47a6-5553-08dc94a8ebc1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 23:54:01.1924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /6iqukCPK+FwpMnH9Qo5QMZH2I9VjodHL3xJMob6Qyn4FSibiyiDM4C8XeRIYKpHZ8wPT3jBCa88RjEjZI8p/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5304
X-OriginatorOrg: intel.com


> +	/*
> +	 * Per NMI source specification, there is no guarantee that a valid
> +	 * NMI vector is always delivered, even when the source specified
> +	 * one. It is software's responsibility to check all available NMI
> +	 * sources when bit 0 is set in the NMI source bitmap. i.e. we have
> +	 * to call every handler as if we have no NMI source.
> +	 * On the other hand, if we do get non-zero vectors, we know exactly
> +	 * what the sources are. So we only call the handlers with the bit set.
> +	 */

The use of "we" here can be a bit confusing. Writing this in an
imperative mood might make it easier to follow.

> +	if (source_bitmask & BIT(NMI_SOURCE_VEC_UNKNOWN)) {
> +		pr_warn_ratelimited("NMI received with unknown source\n");
> +		return 0;
> +	}
> +

IIUC, bit 0 will be set for out of bounds vectors (>= 16 bit) as well. I
am not sure how realistic that is or if that is even possible to detect?
I am wondering if there should an explicit error message when such a
scenario happens.


> +	rcu_read_lock();
> +	/* Bit 0 is for unknown NMI sources, skip it. */
> +	for_each_set_bit_from(vec, &source_bitmask, NR_NMI_SOURCE_VECTORS) {
> +		a = rcu_dereference(nmiaction_src_table[vec]);
> +		if (!a) {
> +			pr_warn_ratelimited("NMI received %d no handler", vec);
> +			continue;
> +		}
> +		handled += do_handle_nmi(a, regs, type);
> +	}
> +	rcu_read_unlock();
> +	return handled;
> +}
> +



