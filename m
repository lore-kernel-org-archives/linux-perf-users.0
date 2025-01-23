Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E488E1537CE;
	Thu, 23 Jan 2025 18:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737657411; cv=fail; b=jjBMP3BxLNUEJ6vsXfOHF9ZLPYAksgNUiTrfbNl7Pt+vgbtZuULoH8CC9kRjYi+roO8dSOtAXwLvCQ10ThFN+SL8wO1vjqmxNnmu9pYVXaOop2YlEiIBQlOzHEX3mDFvI0NhuAdxQaW6A5nvV/EoDjYc83yAoK92vXFc2VdmPMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737657411; c=relaxed/simple;
	bh=UxnrBvzamefjbprxz1oCGi+praDPMecEJjAUjUtF8YQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SUi6U+sDgvCCCvez1cv0qfoThXqPgyXGMWlbjVYhF3+AKHicReDYngCuucX6dxOPxy9UPjjOnrY9CcVzpS+QAHrgUmcsc2NSLBsLDGug4uB6EgKSsRbEu3vqBw/55qU5/Uaed4eoxjh194+JwVDS1NeLtvPx2iF0Qml8iyJv1AE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FIcc0dOq; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FIcc0dOq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737657407; x=1769193407;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=UxnrBvzamefjbprxz1oCGi+praDPMecEJjAUjUtF8YQ=;
  b=FIcc0dOq4O7vfYEmo8dyw/k8cYFcGorbh4NF6laBP9W8UrFL0en9sdse
   z6cAA0RvIlYm44DD5sVjZBP/JOYenyND1iqISLLqywmyiW9plTeU1NVy6
   zwWn1xnpL9IJ9LaOn+Zey6lptQ7XqOhY25aIhdkK4R9EUtXq+vyviiD1U
   zl8H3vqKSZm49k4aNVRQKKIsh//c6LvVO6yOXB/5ntLidxfTVD8HnYrrc
   QBnoza+xQplJWqaTJiCDVlDH1idpr3SDW/8F+8BkzbaIGNxe3TXEdckMh
   6WRhGpTihKH+3XlZLltBEnetL/Qxh+dy3uLYbio0RMPt0vGDEgBEwhirV
   g==;
X-CSE-ConnectionGUID: Uhi6dIKBSSawcBgYR9dLcQ==
X-CSE-MsgGUID: XfqvD2Z7S1OUYdbMl8S1hQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="38206071"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="38206071"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 10:36:46 -0800
X-CSE-ConnectionGUID: iUvcAq68QBq2XSdnOnUzyg==
X-CSE-MsgGUID: ykpyhCgzTV2mFJ+3CHzDfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="107547285"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2025 10:36:46 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 10:36:46 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 10:36:46 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 10:36:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFxzCgAO9nlK8LXZCtfYHNLpUKaJUIF0n6ua2r2dRa5flXAmjbZKuTVGh7Z1mhxCn0C12N2nh0oQy6wQSAAESafpMjxqY8AHQIAvOxZe2Qr55I7oI2TcEcZqy3dlURJGhb8qJN8vTbvUtdiep0L+SYANtDRhUlB43fPyKQuI8ECeQB0eFyRIzuAL6UCgObxBKy3ilbAckChHdUNI6B2dU+42HgbUc/lCJWh/pw5FATkKUzPsxscfwYTrxHxxtnn00pwcmW5k8xEeqQLbA4EBNRWB7FpUdCioVFjFl/8w7rGMBYSlWi7ceeW7y5ffMYyJXFelzocEF/henqiyh/76Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uE+ahYG0d5orBzEXth8H0D1nCpCe6hLDqod123mQyq8=;
 b=CR3surQl6sm9r+gykaPV5tTAJRl6Vt/UpUb7Tt9Y7GHFkdMi4TBA7bgeOOVX4ly8zdKBlwJ2gxz0hzdMGiEvkOOJizzL8rbYYsP59um1q+373bblx/HMV5xpvYvkcfGk+59UcfTjZOt5ShLKJRQzhcjgMZYojBZUbV7Zcfo7rjLiF5gkoiLMHS9Sd0JrEss9vngGkBVhRy7EOeLWY6P6mLVL5RYH78sRhU7jBf6nVWYTpmWLrWbjLGSLdfISXuh3W4LzUuas/omTx1O6TAl04a4zuczFW4FlIS951yfNcSYM1KZZGBBt7MjxPPSKBkFeOvcQh2xzsUvIiDIL5OHbpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by DM3PR11MB8713.namprd11.prod.outlook.com (2603:10b6:0:45::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Thu, 23 Jan
 2025 18:36:43 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%4]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 18:36:42 +0000
Message-ID: <48bd8eed-cff5-445e-bd77-0a87a1ad2358@intel.com>
Date: Thu, 23 Jan 2025 20:36:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel/bts: allocate bts_ctx only if necessary
To: lirongqing <lirongqing@baidu.com>, <peterz@infradead.org>,
	<mingo@redhat.com>, <acme@kernel.org>, <namhyung@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250122074103.3091-1-lirongqing@baidu.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250122074103.3091-1-lirongqing@baidu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0214.eurprd08.prod.outlook.com
 (2603:10a6:802:15::23) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|DM3PR11MB8713:EE_
X-MS-Office365-Filtering-Correlation-Id: 225aa58e-b65f-4ffe-9d34-08dd3bdce1d5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmtXUFlCQXNRWHJ4MDNyYUROMHZWb25zc0s4SVRFMlRSUjZwZEl4MDJrdHdS?=
 =?utf-8?B?MU5tZkZNVEJvSDNIY2tweng3TTBoNXd5RCtKbmlOZ1k0QWRUNngwOEdiYk8w?=
 =?utf-8?B?TTB3MW1COVR0Sit1WTNrN0hBN2QrTUVLR1p2L1IwSUV4aTNNYlJTbUpFdWtt?=
 =?utf-8?B?VHdUSVhLaHRGc29WN2g5WGIyeldDc3NSb3JMeG9HNzNBSytJWThtSWRUQTNm?=
 =?utf-8?B?MmJJbThSY1Q5RlFUUjc3Zk9wL2d6eUlOZ3h1dncvNEVQUExyaE1YTm1Ec2JB?=
 =?utf-8?B?Qm1EdnJneng1TkRKK2Y1R0FqOVRZWmNaR3ZnOGJxTGVHYkVRVTFUaFBvWGNx?=
 =?utf-8?B?dkYyc25zWGZFc0xCZ0Rid3ZtWkp2ckRwdVNsbW92OTdFZkUxVXl0K3ExTThD?=
 =?utf-8?B?UG1HM3I0eFhPQ3h2RnJsWU8vaDI1Y2JxZ0xycWRjZEdHaFkzMllXY0VTNXUr?=
 =?utf-8?B?NlVFUlJzTjQyWmFrOENFNjV2NkhiM256QXlJRVRaTlVtL2JsdGt5WTgyM2Vr?=
 =?utf-8?B?b0g5b1Z6WXloSmpLUkhmcWxzQ0lGZ1NpcFpmRDR5eUNOWm41UHFhRDZ0Y2Ew?=
 =?utf-8?B?Z09UYm9yZ3NoNnl0NGJieVV0a3RzNVBrd3M5TDBrNUZlMnZhcnE1ZDk5U3hz?=
 =?utf-8?B?aWVra2NGRUtGSHNoS3pQdkVRZHErK2FZeFQ2SEhrVVVQM3R6QTZOQnE1ZDh3?=
 =?utf-8?B?OE8xenpFRWFsZkYxSU1Pc0lEcTdpaWFvZCsrSTlWdGpJekZCbE9TaEw2REF3?=
 =?utf-8?B?K2dkUHNZVWVqVEUwQWJWTGlySmNqazdxb2Q1WHVXSko2VlNobkliKytldm1y?=
 =?utf-8?B?VTRaZXpZdjRKZ05wd292MVNreHYvZkthdFNMbGRObFZzcFpMQVRUMDA0aFI2?=
 =?utf-8?B?ZEtNZjhlcFgxanhUemRERFBESjZnV1FGRjdHV2p2ZEhTVXdZSmlaejQ3SnVQ?=
 =?utf-8?B?MVhQU3RtVGtZS3JKUFprdU5xUXEzMlRMbVJMNFVQNFFkYUxmWFF6b3ljNTdR?=
 =?utf-8?B?ZFBvdGM5Y3VhZGJIUnhWZm8xWCtSdDNYbXBIbmNGZkc5SzJnTzFOV2JVREs4?=
 =?utf-8?B?YlRFTVlmZ0VXd0xEMWphL2VHZ3pLcTV6VTc4a2tseVNUNXNDRGpIU2lGSlFu?=
 =?utf-8?B?VlQxd0lYeTdpNGt6bUk1OStWQkl2RW8rOS9rcnM0aEF6b0M1Z3VzcWYzeDVT?=
 =?utf-8?B?cnFrdXViQUQ1ODVwaFlUUTZrWmY2RTJ5NDN3Zm01VGlmWVpZbTBwcVBtOURJ?=
 =?utf-8?B?M1p3WU41bk1Yb2JmSXltSjBmMXBoZTQ2blJwUzM3MmF4R3Z1NWhEUGpOTnRj?=
 =?utf-8?B?ZmJ4bnpyWGFPK3dPb2hzSWUxRmtURU9YOFN2c0I0OFozV05SaG01WU1ndDI3?=
 =?utf-8?B?M1ZXZ1JWbzMvNjlzZHlzVi9aSTZSSllpa3kycGZpdFJUOExHaC9wN0xUOW1K?=
 =?utf-8?B?TTF3TWVoVTc2SlZ2SWlvNFI1Vm03QklQbHZtTFp3amJsbm81ZGU3NGM4QWtx?=
 =?utf-8?B?QmhKbmNXZFVDOEhiT2Fqak82cXRXa3hBNmxIbGdJRFpHTVgxTHdZVFQ4STY5?=
 =?utf-8?B?TE5NNG9iOGdWS0JidCtiRU95a0k3djBNWUN1aFF3U3hzRmtlTjhteENjVWFB?=
 =?utf-8?B?d3IvNitHcE5zeTV3T2txVTFHNjNoU3JFdXNMRFl0U1FFbzA5NUlmZUd2dzho?=
 =?utf-8?B?Ly9hN05LdjBvT2M4MzlhNCt0cHZYR3NBOFpuMHYrYVh1eUpVOCtibEhpaEho?=
 =?utf-8?B?eTVBeW41WXZBOEpPVEhuVktpblk2VWY5MUw5WnpSc08zcDZ3ZjlNL0FSdmdm?=
 =?utf-8?B?eTluMkVNOENkQ3JPY2IveGwrQzBha00raEVNNzkzTzRtelJ5NDlNS3dwRFVT?=
 =?utf-8?B?UllkWmZYa3dQZk5oM2tqcHlobzEvVjJBZytnUys5cTIvRVBTbmt1ZmZyZkU4?=
 =?utf-8?Q?ucv6dh8Y+YE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWYwUDdWVnF4VkdTdjlMYURBRkcyODZuMGthQ01YZHJmNVhFV1RBQ3JraGYr?=
 =?utf-8?B?NENZNGVPVEdYdmRiMTJrWnkrSmVtdTIyVi9kYTZwRWFYRGt4dWg3VmNTTkt5?=
 =?utf-8?B?Q05VaUpPUXBrZ0huME5veWNUWmxqeVYvOWsyWjdPT09vRm91eXpmemxnMHBL?=
 =?utf-8?B?WG01VDJGdHFKVEY0SUZPVkhITEQxQTdNR2FNRW1QVnE3S0tVNm52YmoxdWNt?=
 =?utf-8?B?MEQxWWFtYWxpYjltMHducXRtcWtXRUFpeFhta0gvOTFPRk1kSExIZTBENDVJ?=
 =?utf-8?B?UTQ0R1VmQ2d0cm1qUG50eHVQVHZnRTZ1WHVHeE9LOGJRUkY3THZGR2JDMVFK?=
 =?utf-8?B?Y3RFQUJtUnhBT2puMUM3VUgzaHV2dUNJZmtnTWdRZFZvNVJxYlhFUjZEN21E?=
 =?utf-8?B?QnZHb2hnVkxVdmZTR2JnOEdnWkg3N1NjWlZMSkNjSGE5bmI4M1ljcHhlenJk?=
 =?utf-8?B?YUhjV1F5UGFGNDBMay9zQ1lIRlM0bUMwM2hNWFhQZjluM0dFUmVpRVpkOEFN?=
 =?utf-8?B?cXJZS09aQW5tVmVwVWpzMHFpa3VUeFdhTmRwaXhSdzZtT2phLzcrTEkxUS9s?=
 =?utf-8?B?VzQrNjdYeHRnTkRrYmZxaE9ENTVhRVRjcXpoM01FM2FBdHVGRWpIYlV2MjVO?=
 =?utf-8?B?MU1kbUtFNEF1Ym9XYXFmb2lSekVsMEM3S2U1bHFMQnppVHFkVlozN1Iza0x4?=
 =?utf-8?B?NlJXeTQ0VUFWeVNNbDdiOWtDaVlvZnRkSDliam9wTzVhc2dYZnN3UE1HRExC?=
 =?utf-8?B?bVhlZ0x6THNrN2tIWUtaUEpvQ2lOYVd0TjlxUndMS3BHdVNoWGRRck1jekU4?=
 =?utf-8?B?SGMzWTBhUjJ5WWNXZm9zbDg4ZkI5ZFRtU1puaWpUZkt5bDdIbGM2NEFOWE5R?=
 =?utf-8?B?MG9XY2NmdGZLcmJPSW1nRVYzdzZVKzExZ3ZrSlVyQm1MdTY2cmM2WFhxYWh1?=
 =?utf-8?B?c2t5cGhiZk9KUE0zem5QcWtXVFo5eVVnRElCbUt5OUgvT256VkdISkNwTmdM?=
 =?utf-8?B?VmxkTHQwbGNkWkN0TWNzSjY1VythbDlwQWJTa3FTcUhpditRMkIzelFYNGhy?=
 =?utf-8?B?b0hZdHpRbzd5cUhyQ1o1b2dIdUEwZG4wbkhVT0E4YUFQdDU1LzcrUUMwb0pX?=
 =?utf-8?B?SFR0bVE3UWdMdEFEZFRTTzd4MlIyeDhNd3hmN0c4cnlhS0RpbWphMWwxYXJr?=
 =?utf-8?B?aDlEclhpYmFCSTdqRjdKM0RxMnlOdkY4YjZtSUVRZDR5M0dOSjR4OGFpSzBK?=
 =?utf-8?B?SEIvMGlkZ0tTMFAxbzNlNlNRMS9mOHZkMVlDNkl3TFNBd3B0UmtLNlFBWnk0?=
 =?utf-8?B?RkRmVnNuc2RNR1NDaVgremJGUmlKcFhPVG5ZaU5RWThFSWZkaStzVHM0TGx1?=
 =?utf-8?B?U3NHZExIMWlpYWVsYVBYR2o1TUVBQXNURTJkY3hXYzQwbTZKMlB0c2wxMVZ2?=
 =?utf-8?B?bklKbm9RM3M3S0JBODkzOTZqU1RCMTFBdTkrRFZEN3JrU0VhcnNCeWRWUjYz?=
 =?utf-8?B?eXVjbk16S2RXQWZrK01iazZBL1V5OURzNUhhR25yM1JFVHdMSTNPY0FWVE0z?=
 =?utf-8?B?Z0hFTTF2c2dHQWwyTEVOV1NaNnJaSEFSNUdvdEpxWUprM0ZCVDhmS3lmTGZE?=
 =?utf-8?B?bjN5ZG0wMjRYZHB5SWN6dDM2Z0RHZDUrclhwTEVYZVhIU09iazBxelJqV0ZZ?=
 =?utf-8?B?bnZBcWpoT05BRi9JOEhSbDVSU29vZ243QzZhUjB3K3k5QmdubFVEbFozNFJG?=
 =?utf-8?B?QUpSUXJQVElxdDJqZXZXV2tqbmgzSjdpa2FUU1ArWW9ucTlkamxYcjd6UkJk?=
 =?utf-8?B?bkE2VVFLVXp4akpFMFJucE95aDJJcUhmZVNBV2FwbWNnRTY1b3JLQjErL3Vz?=
 =?utf-8?B?V2JxVlE5K2FBZVRsSzl2Z1JYU1V3T2NZSGxhYlJ6TVFndkJCTjcxSFFWSmZq?=
 =?utf-8?B?cjFMdStUT0dRUVdBU0lVSjdCbC8vL1Z4THgwYnc3ZzVXUFlNZVBCeGFXNGp1?=
 =?utf-8?B?WHZDSTlVbTF3UnU5NDA3WDVvNnRneFhNZms5cXZzTVVXV3ZENFJnMWxsZ0FR?=
 =?utf-8?B?TlFqOHZYcXlRaW40ck91ZTNYQnpLUWc4cUU2aHRWaDkyUHBXVzRvLzlBR1g4?=
 =?utf-8?B?RC9TZ3FiUE50U0cyUHNNZnI5NUw4N3pKT1Z1WVBuSXoxSlJ2b2hVbzVuQ0Yw?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 225aa58e-b65f-4ffe-9d34-08dd3bdce1d5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 18:36:42.7229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VHSag9zFIhUzFGiBSQvauagdiHFNAzlcbnuTrwXzT+1avZo/9Revy5PpEF3xVZQQXmw5Hm55fHwFFdMfvZd7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8713
X-OriginatorOrg: intel.com

On 22/01/25 09:41, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> Avoid unnecessary per-CPU memory allocation on unsupported CPUs,
> this can save 12K memory for each CPU
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Tested-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  arch/x86/events/intel/bts.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
> index 8f78b0c..8e09319 100644
> --- a/arch/x86/events/intel/bts.c
> +++ b/arch/x86/events/intel/bts.c
> @@ -36,7 +36,7 @@ enum {
>  	BTS_STATE_ACTIVE,
>  };
>  
> -static DEFINE_PER_CPU(struct bts_ctx, bts_ctx);
> +static struct bts_ctx __percpu *bts_ctx;
>  
>  #define BTS_RECORD_SIZE		24
>  #define BTS_SAFETY_MARGIN	4080
> @@ -231,7 +231,7 @@ bts_buffer_reset(struct bts_buffer *buf, struct perf_output_handle *handle);
>  
>  static void __bts_event_start(struct perf_event *event)
>  {
> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
>  	struct bts_buffer *buf = perf_get_aux(&bts->handle);
>  	u64 config = 0;
>  
> @@ -260,7 +260,7 @@ static void __bts_event_start(struct perf_event *event)
>  static void bts_event_start(struct perf_event *event, int flags)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
>  	struct bts_buffer *buf;
>  
>  	buf = perf_aux_output_begin(&bts->handle, event);
> @@ -290,7 +290,7 @@ static void bts_event_start(struct perf_event *event, int flags)
>  
>  static void __bts_event_stop(struct perf_event *event, int state)
>  {
> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
>  
>  	/* ACTIVE -> INACTIVE(PMI)/STOPPED(->stop()) */
>  	WRITE_ONCE(bts->state, state);
> @@ -305,7 +305,7 @@ static void __bts_event_stop(struct perf_event *event, int state)
>  static void bts_event_stop(struct perf_event *event, int flags)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
>  	struct bts_buffer *buf = NULL;
>  	int state = READ_ONCE(bts->state);
>  
> @@ -338,7 +338,7 @@ static void bts_event_stop(struct perf_event *event, int flags)
>  
>  void intel_bts_enable_local(void)
>  {
> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
>  	int state = READ_ONCE(bts->state);
>  
>  	/*
> @@ -358,7 +358,7 @@ void intel_bts_enable_local(void)
>  
>  void intel_bts_disable_local(void)
>  {
> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
>  
>  	/*
>  	 * Here we transition from ACTIVE to INACTIVE;
> @@ -450,7 +450,7 @@ bts_buffer_reset(struct bts_buffer *buf, struct perf_output_handle *handle)
>  int intel_bts_interrupt(void)
>  {
>  	struct debug_store *ds = this_cpu_ptr(&cpu_hw_events)->ds;
> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
>  	struct perf_event *event = bts->handle.event;
>  	struct bts_buffer *buf;
>  	s64 old_head;
> @@ -518,7 +518,7 @@ static void bts_event_del(struct perf_event *event, int mode)
>  
>  static int bts_event_add(struct perf_event *event, int mode)
>  {
> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  	struct hw_perf_event *hwc = &event->hw;
>  
> @@ -605,6 +605,10 @@ static __init int bts_init(void)
>  		return -ENODEV;
>  	}
>  
> +	bts_ctx = alloc_percpu(struct bts_ctx);
> +	if (!bts_ctx)
> +		return -ENOMEM;
> +
>  	bts_pmu.capabilities	= PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_ITRACE |
>  				  PERF_PMU_CAP_EXCLUSIVE;
>  	bts_pmu.task_ctx_nr	= perf_sw_context;

