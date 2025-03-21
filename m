Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156271388
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Mar 2025 07:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742543983; cv=fail; b=AKt9znhSW+1qH3nIWYySOozNWgql3d6bunjsfDb8r+qwMI8PtcjgqRjAvpNGxMC+bvmiMGXxSaSJ5T2U4wTNxkyma4r/tiGK/DrAGX4Mu4PBMFQCS/de+huMQ+bV99vIoN3CkbCRRejHyPOb6Sw+/PFG0rMt62O+ItxmUNbsSDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742543983; c=relaxed/simple;
	bh=851HFABOkEBySpwp65TXR25znb6IZvAXnzc9XbBkr9E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FsZwF7rOxIxaRL7LHLN7iI0sWCk842JY+iMdhjq0pKSk2EfQr8ULcSPxl1XzUJ4yWcDAWqnk7z2eyp+SP44vHvYT0zL1XHi428QQFjRHms0iekQk6AKWvAwEBsAGGufzm4U0mX7qIDN7x1/+1GgWuAdTaBlLgSHTSXEdie8UaIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UWIXVUqZ; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UWIXVUqZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742543982; x=1774079982;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=851HFABOkEBySpwp65TXR25znb6IZvAXnzc9XbBkr9E=;
  b=UWIXVUqZMdM37iZXxEs40wgI7AjKF6j4Xoq55nBg41WZ/laTCFDNeCOm
   3hrR2dmk9ieay8z66psQFcq1Gzo+WSeRRYpeSwlYO+V8Z7HclI06xbyc9
   5Mu1zYD1UD5y5CsLqdAFe+QadamTAvCd6G6W9KPIonGIhBXog4Cx2p10h
   XI/1+fm1V/TaRwP5qqr8M0wX9kO1F/8IjMzT31PE8NAsUVnDASQ6178L1
   3/n1CV/jAtyKIHP55RNISJHC7W2EHeOWO3HF/pOgJQI0Q9tY/Hv3QRluC
   u/QngshVkBrzyMtOt0GshGUTj1U82qUeoIEXD/jZZXQdIUnP3v2p2ElWQ
   w==;
X-CSE-ConnectionGUID: YxKPvpQgTRuKalNFrcOGwQ==
X-CSE-MsgGUID: 1haQE6DSRji5scIYyeBWLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="54468912"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="54468912"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 00:59:41 -0700
X-CSE-ConnectionGUID: RoUY28KlRlu+Uh/Y8ugofA==
X-CSE-MsgGUID: UaQoASeCT/mx6SATdamykA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="160565810"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 00:59:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 21 Mar 2025 00:59:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 21 Mar 2025 00:59:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Mar 2025 00:59:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDqhPFv5sody2i6T4MPm8rRgal6iv1d1e1Ew7QnEENGTuQcFdDXuxXOOVsGof9b8o3bb/i1BAfGj40+HMr7BeGHZI7kKP2XuhL6fKOEnJ1V++e7N9XDJ3vz4pp7Vu5FtdRz5hNYy4+LrY3jcWJtv38He2VAsA9AsFL8xhJId1ItWgiEC+5qtrhwl4CXhjXi92dtARJ34gmYputzw/7jpe0RWx0Tw7rpW5euTOJd+NDKbvPIBwo8OVuC/t4Wi6Zjs2Xqi929GOsZl/ySoDxv8h2nxVJyXW3rGE2YOMwdl/39+pbugz+kpY9hG7uAfXIgG+MulLUovI0l8fbHi33LXkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cp4iGPclUi2fkqRLP8OxkoDbonwdzlpC8JwBLHY/MNw=;
 b=ADvfj8pbOkiK1sGmUbJ1vAyoqaEsVODQWM3v1epKSz7cdd8kISn9xInoMMxvgVs2VBEndGSiaGcqBCexs38CRlvmobo3sRcd6a09wUb///hHLcidKwzW55mYOAO08y9htj5dcOsmK1mRPp1KU3INkt1QKcTE7LSx7n4BC6rLcEn+dax9Y3GNWQzg+JJCrENXSanKpJa0mxxMxHihJMkqb+GHO98bRP09LNUAvZ/jThmR3u86GSCFkrby8DzRWuN8r62CRy+ilAjo9mi4kUw35UgN9thM69ZPBPpci09bp6VeLzamCVpNV5rYNgTW5P5WhDSs3FT12nAJb6hc7ntQEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by PH7PR11MB6547.namprd11.prod.outlook.com (2603:10b6:510:211::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 07:58:58 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%4]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 07:58:57 +0000
Message-ID: <0258d25c-a2dc-438b-ae91-65ae70126387@intel.com>
Date: Fri, 21 Mar 2025 09:58:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf script: perf script tests fails with segfault
To: Namhyung Kim <namhyung@kernel.org>, Aditya Bodkhe <adityab1@linux.ibm.com>
CC: <linux-perf-users@vger.kernel.org>, Disha Goel <Disha.Goel@ibm.com>,
	Aditya Bodkhe <aditya.b1@linux.ibm.com>
References: <20250320091551.17846-1-adityab1@linux.ibm.com>
 <Z90BhWbDJjR15_6q@google.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <Z90BhWbDJjR15_6q@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0038.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::8) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|PH7PR11MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cf075c0-f62c-48b8-e9ed-08dd684e3b9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGxjamY1ZGM2VTQ0SnFQemF3anNkK1MxUU5uaWVkTHdsY3RrSVQvamNEeTVH?=
 =?utf-8?B?UjFRUTFhNmMySEVvZ012QnpJWk1saGhsZlNEZFExQ1Z4Q3RmU1BoOTkxL0tm?=
 =?utf-8?B?a1lXY1RUMWRLZmpBaGtvMVRHTGJjanVrdDRXWjdKRmFiYmR0ZXFzNmJxVWZE?=
 =?utf-8?B?SExFUGwzRVYxaWdSRTBKSFN5a3lGUnZReUVUZkxQTVU4UmJmQ3Q2RHpIL2RB?=
 =?utf-8?B?U2ZXVzlUTVBIVkhEWGtkbGV5TXcxM21pZ3FCTkZHL3BWOTVoeVJoNFg3Wkdv?=
 =?utf-8?B?Z1A3NW9QMnV3T3FVeXJzODNWbVZVMnNuR21OMUNvWkkwUjh6T2k4TklEVXk3?=
 =?utf-8?B?N3hEWGc1VU1qWjhjSWxTbHZVZ2lHRm5rb0lxRnllaEhwWjRPbTRuYVF0d0pF?=
 =?utf-8?B?M1VtblNOSndvWk5lR0Jpcko0VEZ6TW5UT3RoUWZhT2poQk9XdlpSejZmTWw0?=
 =?utf-8?B?RitoSUpTOTJabGtlZ0RNN0pXSzF5MEo2Zlp3THpReW5tbmdyb1EwK09VWm5n?=
 =?utf-8?B?NUN0S3ZtUXZ6OXU3MDhxOHB3bWZpbytHQUI3N1RlN2xVWUc0cFlid1hNOGVT?=
 =?utf-8?B?bllmMVZvUWJaNmhmVXdxdzZnVGUxRWhJNHhsTlZubWJpMytqc1lTdXhxaEhD?=
 =?utf-8?B?VTZ0TFU4Z3ptVDZlT2l0MGxxZFN0dG5VRDRYYVZMVUtNZXdDcC9rN1Q2T1Z4?=
 =?utf-8?B?UFdNaS8vM2pERzNackJqd2dTMEtCM3hlM29FeWh0dDUzenpBdUVZRU5wZmlP?=
 =?utf-8?B?ZDJsOFpMZ2xsc29INEI1eFR4VHdKakZkOENmSGU0cG0vYXJhSUtyZVgvWENJ?=
 =?utf-8?B?ZG81eEsvS0RpdkRiMnpLOUR2bGVBT28yRXBvVkE1d2hCalJGWmVtNUpNQmZV?=
 =?utf-8?B?b0YwQWVHbzkwQ3NuRTF6OE9LMnJLbUpVV1RrYVhpeGpzQ2dDNzJ6UityTjRF?=
 =?utf-8?B?NnBpNDRhTi8zSDRBZ2c1dTdQbnJqYTJCTzNSWmJyenhlQ3I5STBsM2toUnVS?=
 =?utf-8?B?S1NTR3FNNVJjWk1udDFNR3NJSCtaWkNhR2ZsZHRoVUFlRlgwWnlTL0k0UDZF?=
 =?utf-8?B?VVdTcHhwUmNMU0lDMjFpZ0RFNWt2T1NuWmEwZENHSW96Ymp3MFkxUHNmbmVz?=
 =?utf-8?B?bmxXS0tKemwzalZzYU1PRnNUeXYzbXcyTk9FeHVLSzA5dnJsRUZGUjZJQkNM?=
 =?utf-8?B?bERtQzlRdm96a3FGdG4xZldiVFRuSUFKZmVLdkREdFZBSGpjb2lqbWROSXp5?=
 =?utf-8?B?amk1L1p3RlQxZnY0Tkg3SGJhUHRhMm0wYUVYQmFtaTh2dUFMTHdTZ0c4VHBS?=
 =?utf-8?B?d0JRQ0ZVUThaMWtGUGRSSWpHWUsxQXdTcVlOaXZGQlgyUHg1UGhGcWNXN2Fu?=
 =?utf-8?B?T2s5Rml0bzEwMXRqNndkTE9yVERvN1pneEpDcW1WdCtmcnhrczJiMzNJZVhS?=
 =?utf-8?B?aURWZDNwdlR5VlNDSUJmbzN1dGJaTEJTcmg4YkN0dE9wb2dreXlTbGdwVnFv?=
 =?utf-8?B?V1g5UlN6UnovUG5KZGJjLzlvQVoyb3R1WThvQm9mekFjRGRuVVFDWUNBYkh2?=
 =?utf-8?B?ZitkclZNSVJZZ3VEN2lTdk5KUHkrd2x3d1RFUTRkSnIrT2YyN2ZiemhPTkZP?=
 =?utf-8?B?c0JBYjQyYWZWbU91OU13Nng5clBwTVJtVEFWenFuRVRxU1oydkZxM3RUUDAx?=
 =?utf-8?B?RU4vWVViaXVlWi9VdGYvRytNemNhbkZxdFN6ZE93Vm5mUkpDcEpQc1RzY0Ry?=
 =?utf-8?B?SU1DbHFvM2J3NDFldDBUN1Vyc0pIdkZEdmVOelNUbFBnRFZvWkxyUVh3T1V4?=
 =?utf-8?B?WGQ5NGw3a2U2SjdtaVBqS0NTSUVHY3Iyc1FlYTA3cjhGNVgrUWltSFl4SC9P?=
 =?utf-8?Q?OnDTuScluBFOX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djhrYzVNVDVWTm5qRHdHeUZXN2Q2eXdLWHV3S2NsSmFNYXAwdlk3eWtnNXdH?=
 =?utf-8?B?eW9zMzYwbEwrWFJrencrRmQvTzBlTEl0WDluNVNqbFhubzVYRDRZc0Y4a1VF?=
 =?utf-8?B?TW5zbFlLalhBaUkwUXZsYnZlQ2VOa2NKQUFUS3RqREYyTTN4S3RlMlJiRXVY?=
 =?utf-8?B?WHAvOHZVRUp1OHNjU3dBUlgwT0s4VFN5ckFFMzFTTlNPSElBUG85dUc0RmI4?=
 =?utf-8?B?YXd0NVhpN2cwd2lzV0t4RmlqdUE0eEhMc3dQUHBkNDdZT3FjNkVXVnFOaVNM?=
 =?utf-8?B?bmZBUXZLcmw0dUMyZEUyUlpacDc4Z3lpMDZoUmRkV1Vkd1FrNDduWmJWbXI5?=
 =?utf-8?B?VHRnQWpzTFpGOHo5c2hXMFdDVUlJVURMVHFET2dkQzUrbnJzTEs2YmJsWngr?=
 =?utf-8?B?bzN4N1lZQUwvVFltVFExSG1Jc2Q4L1lHcGlpYnloOFJwamJCdkRaa2J2dlUy?=
 =?utf-8?B?bHhaNHBmMURoRDFMSjFZU2Q1djRWWVhXYVpHazhuWGJudTVwWE03Y2dNbGRp?=
 =?utf-8?B?NzFBYWVTQWczZlF1RmNNdzF1SkhUTlUySFgzM2VPTUtCRlJDVUxUYmdNM29L?=
 =?utf-8?B?aDlGWjVxdjFXTHk2SmhhbmZSeURaVE0yN1FpZlJFTHBEUXZoNlBkNENLck9S?=
 =?utf-8?B?M0NEMUZkYVBkN2w0NkhLMnpDdlRjNWNqWk5mNHBoQWNTbFdLSTgrczlFRG9i?=
 =?utf-8?B?TUE3YldpV1R3WlNjWlFPeVN1T2kzMFhjNlN6Z2R2YW9aL0Y2dkQzVVNsUWpy?=
 =?utf-8?B?Y1hIeFRoY3JCdWxFTHdQbnZWeC8xVzdFYTd0cHIrSlkwK1Jld2R3S3NaWGdu?=
 =?utf-8?B?QmdjSFh4cWdrbjJwTHBnTXI5bmp0OVgrOFpSQ0tKb1pXY3RnZlJwN0pCUDZv?=
 =?utf-8?B?bmg0V2NiSkhzUnZ3YVRXY1hYcUovb1U2blU3N2pSSnhVM1hud1p6UWhHcWtw?=
 =?utf-8?B?OTl4ZGI5a1B1V2tEbW1PQS9BbG9lTWlGU2h1WHFSNXZPbWpNc09xb2owWWl4?=
 =?utf-8?B?a0FucXpCSXZkQU1wY1RxRUV4NnJnM0dqa0orNHhzWG16Y0lNT3FnTnViTTBv?=
 =?utf-8?B?WHVTMXZ5Qm94YkY3RDF4ME0yOXFQbVUwUWNOOElWQ1RUTFlFK0VHQVA3M3Vs?=
 =?utf-8?B?bUpDOFVuTFdGdzcxWTNNL1VkVW53bm9yOG1pdHNPWDNBSmNRd1BUTXM5UlVu?=
 =?utf-8?B?cEpzNjJHOENuaklVVVVlb28zUDdlSjBISnB0TVZVYmNyM1NxaXJrYjBveXV5?=
 =?utf-8?B?MUdwak9Ma0tzVFdtNTRXN0ZpamhJSkZJeXI2eGg2UGNjTTZ4WmpsWElxOURV?=
 =?utf-8?B?Mjc1ek1GNEtCUk0xV1dJRXUwV2lYaThhc21mOFRZdlBoQ3lCcWExYitkVWkw?=
 =?utf-8?B?aHBPVHRlQkJqODd1YVJzc2Z1dmxaL2RmQ3E0QURsWnBFOWcyQlJVZ2ZnaDV4?=
 =?utf-8?B?aktyQlN6dTRYdG9nL0xGK1hjckttdTY0WWtFRG0rN3djYSs2RGdzYnptenNM?=
 =?utf-8?B?eGtBR0s0VWl2Uy9OWW83UTROYmJKeURNRE9MbEhHdm1GYWtmWkUweGhvOURp?=
 =?utf-8?B?QzhXSjBtMHoxS3J2T2JBWFI2bmo4TFpMaG11RGFMM0d5YzlOVzY2SC9OYzdU?=
 =?utf-8?B?MkVnaUtXQnVVamxOcVlwVVVHa2F5cXVYRmsvU0dKNm9yR253MElLSHNEVGxm?=
 =?utf-8?B?V0Y2OStkc3o1QjhuQUM2TVZzYVpiSVkrYzR2K0FJemdwZ0UxQTdZZ2U0TWJi?=
 =?utf-8?B?d2E3OHhKT1h2L294RUtRK2N5c21EbExRV2M4aTNYTUpCcWR0Ym5sbVpveFUv?=
 =?utf-8?B?eGY5OWlPRmp0RGFab1pLaTYwRzQwQlVjVkJqditsc3huZkJwSkdPdU5aZVFq?=
 =?utf-8?B?YU1MYTM4S3ZEZXhoU3c0TjVUVm4zektXVVpyVjNrY0JLR2w0blJpZjJRQ2Fz?=
 =?utf-8?B?NkdpS2pZOUo1bUN3OEpOVEt6ZGJvK1lYMmtseHFXQUN5U3FpN010V25keElj?=
 =?utf-8?B?MFRmZ3FuSlZjWDYyR1lvczBBc1BBSVpZTk1DZllOK1RPbTlmdVVVbURFMzBm?=
 =?utf-8?B?UWgwMHFha2FDV3YzS1NXR0tOWmRqaVg0THFFeTdpSjNnZ1hEcUIrOUUwQkNK?=
 =?utf-8?B?c3hMUFhWWU5VV2dQWU5RVHVrUEtXc0lVbmZKK3J5Nk5WWEhzL2F3WGRUaFFZ?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf075c0-f62c-48b8-e9ed-08dd684e3b9f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 07:58:57.7371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/Fx4Vag1rloQX+oyn/OUXnNphX04ZL1ScAGBRAAvObSBFUXbOQY2+eTSnvwa50KYKW64sMrDexAeTUPe4Wp+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6547
X-OriginatorOrg: intel.com

On 21/03/25 08:04, Namhyung Kim wrote:
> CC-ing Adrian,

Thanks!

> 
> On Thu, Mar 20, 2025 at 02:45:51PM +0530, Aditya Bodkhe wrote:
>> perf script: pert script tests fails with segmentation fault as below:
>>
>> 1. Run perf test -vvv 'perf script tests'
>>
>> 	 92: perf script tests:
>> 	--- start ---
>> 	test child forked, pid 103769
>> 	DB test
>> 	[ perf record: Woken up 1 times to write data ]
>> 	[ perf record: Captured and wrote 0.012 MB /tmp/perf-test-script.7rbftEpOzX/perf.data (9 samples) ]
>> 	/usr/libexec/perf-core/tests/shell/script.sh: line 35: 103780 Segmentation fault      (core dumped) perf script -i "${perfdatafile}" -s "${db_test}"
>> 	--- Cleaning up ---
>> 	---- end(-1) ----
>>  	92: perf script tests                                               : FAILED!
>>
>> Backtrace pointed to :
>> 	#0  0x0000000010247dd0 in maps.machine ()
>> 	#1  0x00000000101d178c in db_export.sample ()
>> 	#2  0x00000000103412c8 in python_process_event ()
>> 	#3  0x000000001004eb28 in process_sample_event ()
>> 	#4  0x000000001024fcd0 in machines.deliver_event ()
>> 	#5  0x000000001025005c in perf_session.deliver_event ()
>> 	#6  0x00000000102568b0 in __ordered_events__flush.part.0 ()
>> 	#7  0x0000000010251618 in perf_session.process_events ()
>> 	#8  0x0000000010053620 in cmd_script ()
>> 	#9  0x00000000100b5a28 in run_builtin ()
>> 	#10 0x00000000100b5f94 in handle_internal_command ()
>> 	#11 0x0000000010011114 in main ()
>>
>> Further investigation reveals that this occurs in the `perf script tests`,
>> because it uses `db_test.py` script. This script sets `perf_db_export_mode = True`.
>>
>> With `perf_db_export_mode` enabled, if a sample originates from a hypervisor,
>> perf doesn't set maps for “[H]” sample in the code. Consequently, `al->maps` remains NULL
>> when `maps__machine(al->maps)` is called from `db_export__sample`.
>>
>> To prevent this NULL pointer dereference, add a check for `al->maps == NULL`
>> before calling `maps__machine()`. If `al->maps` is NULL, return `-1` to avoid
>> the segmentation fault.
>>
>> Reported-by: Disha Goel <Disha.Goel@ibm.com>
>> Signed-off-by: Aditya Bodkhe <aditya.b1@linux.ibm.com>
>> ---
>>  tools/perf/util/db-export.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
>> index 50f916374d87..f355878a8c82 100644
>> --- a/tools/perf/util/db-export.c
>> +++ b/tools/perf/util/db-export.c
>> @@ -365,6 +365,11 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
>>         if (err)
>>                 return err;
>>
>> +       if (!al->maps) {
>> +          err = -1;
>> +          goto out_put;
>> +       }
> 
> Maybe better to check it before db_export__evsel().  Also it seems it
> should not goto out_put as it doesn't get the main_thread yet.

There has to be a machine to have found a thread.  I'd suggest
getting the machine from the thread, like this:

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 50f916374d87..7ea6fd474c4c 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -181,7 +181,7 @@ static int db_ids_from_al(struct db_export *dbe, struct addr_location *al,
 	if (al->map) {
 		struct dso *dso = map__dso(al->map);
 
-		err = db_export__dso(dbe, dso, maps__machine(al->maps));
+		err = db_export__dso(dbe, dso, maps__machine(thread__maps(al->thread)));
 		if (err)
 			return err;
 		*dso_db_id = dso__db_id(dso);
@@ -358,14 +358,18 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 	};
 	struct thread *main_thread;
 	struct comm *comm = NULL;
-	struct machine *machine;
+	struct machine *machine = NULL;
 	int err;
 
+	if (thread__maps(thread))
+		machine = maps__machine(thread__maps(thread));
+	if (!machine)
+		return -1;
+
 	err = db_export__evsel(dbe, evsel);
 	if (err)
 		return err;
 
-	machine = maps__machine(al->maps);
 	err = db_export__machine(dbe, machine);
 	if (err)
 		return err;
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 520729e78965..00f2c6c5114d 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1306,7 +1306,7 @@ static void python_export_sample_table(struct db_export *dbe,
 
 	tuple_set_d64(t, 0, es->db_id);
 	tuple_set_d64(t, 1, es->evsel->db_id);
-	tuple_set_d64(t, 2, maps__machine(es->al->maps)->db_id);
+	tuple_set_d64(t, 2, maps__machine(thread__maps(es->al->thread))->db_id);
 	tuple_set_d64(t, 3, thread__db_id(es->al->thread));
 	tuple_set_d64(t, 4, es->comm_db_id);
 	tuple_set_d64(t, 5, es->dso_db_id);



