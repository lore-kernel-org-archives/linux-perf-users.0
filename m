Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD37B1487E9;
	Fri,  1 Nov 2024 07:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730446224; cv=fail; b=jGi3sS7X6JQEKMQW4vTK5hodwkkqyuQm6/dkvIoVq/i5jR/hkS/0pU/AmLEWydxnYKRZ39OE5p70wnu+ujnciFB4N8CZRt/XhSi2ZQrjCRT4ywJI/xD1KKOZCP7GKU3sZNVi8ITlSiU3rDet0W9Y54QOXSehmFtNCi4IpZsyQ10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730446224; c=relaxed/simple;
	bh=z2t4rRkKWYCi41Lq9NWE1fbAfq46aGKxfGbgxlqsPkA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=huw52lUkcjrPH1Wi3jVibZdk7hp3X86Mi7OHf42iRQ5S5Hdva6++GGwuRtvjOWXTuV6oLw5Jaiy7GOhOlcRpMQujJvrFw2NGv4s39+eM/veJbNdMdhx6370RHQamXHpsBF1GBSDB9s1ujrgG7XaIZRbBlg+AAGRpMoE5D8jIxQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S22jozys; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S22jozys"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730446223; x=1761982223;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=z2t4rRkKWYCi41Lq9NWE1fbAfq46aGKxfGbgxlqsPkA=;
  b=S22jozysliStcNJNoGPN/onRK5pZPE69RUoERYCdFl6uD2DW52P/64Fv
   1pj3QDrB+t1FJpKlyG4N8Y/kid8dJMj8a5veWy4jfzxJwbqTcuKTvVxEo
   MR0h1S/D8y/ncNkgUYGkBgRsSHPGyQxDADzy+mIikfmFjl6Cd0SJTPfeu
   kyPtpZG+zeJoguO1JsyLX6pA/JzLaRE9mD2CFJFlY6OeE/e/ZuFkPJ6E+
   V8/y8q1ctfCFIbNZePHgHvgWIpXtQ6hgvzuYcpXD9ETQT3wl6ED6UiE9P
   aS2Vieyni6VcmBNZ01yHaEgRRMsMrt32SYeUgJCTtCbrDk2qUpsZWfgCe
   w==;
X-CSE-ConnectionGUID: w2AlepvmSYyj/cK7CNv8Vg==
X-CSE-MsgGUID: toHFkKdtRy2ZBrWqgIjgvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="40838381"
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="40838381"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 00:30:22 -0700
X-CSE-ConnectionGUID: osrqfNX1TS6sUujStWQbvQ==
X-CSE-MsgGUID: BG2CV208Skahx0cXIXF3Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="83317920"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2024 00:30:22 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Nov 2024 00:30:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 1 Nov 2024 00:30:21 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 00:30:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TrT+3wTGLOftZGTDgrt32aV+olR1lkhSV5zp5bwkWXmkKnXJWP6vp+gfNXgBJwofnWuU+3hLj/LYauHcm4G0XAISFC9IJpIEFwBo3V7SrsG7YVlUGoafY4LnjLkQtD4KuqNRu2TbFqrR5xYswthcfYJBzs+NlKZS9f/lb6xxYqu5I+ReDQ9nsVMKNWWwRrx9KvSHzvvKwX9UKba01pKkxMDp9tafkXgGjnXUWfvEi3ZWZLZl4yIbItj1AA4hk3Y1dcDjl8BlkTFF2Ea25Pgj27KHTOv8cBQdvmgcL6PCnVfwc0cRYHziQN83RHkDZtHP3Pnd9yE4LYXpuDLQGvYK9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2t4rRkKWYCi41Lq9NWE1fbAfq46aGKxfGbgxlqsPkA=;
 b=NHW7cBmwy9j+4uVCThLyIBtyGPEKu7SBLNKEWldFkhNLvBRR8Llj6jsV8nA7NrJUr1fp1SH72+cePAfL7Ov0bgzX/hKXV6/ZDP5AoRGPmQIxHqp0PSMU/aMzWpzJ2BRTQay1L9AmsXuZJgn3fjdyigzmkyMY88UlyZ5iNvSAbP+i6dW3dpTMFn5iy8iG4P9XYDOTi9EZbDvEZEDhUMuVHKv+cIKsOCkyhed4mLUL8A6KBnTnWiuoFjV8JGh7F9UTlrx/pZE7BYa0zxrRFSW8DOSmMuvmgTbLQfAmQ+O+0r8Grxy37fUXs9iVqsds75jtaz/4XHCZXdtPaydHXhsg6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SA1PR11MB6848.namprd11.prod.outlook.com (2603:10b6:806:29c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Fri, 1 Nov
 2024 07:30:19 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%5]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 07:30:19 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"Dhananjay.Ugwekar@amd.com" <Dhananjay.Ugwekar@amd.com>, "acme@kernel.org"
	<acme@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "irogers@google.com" <irogers@google.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>
CC: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"ravi.bangoria@amd.com" <ravi.bangoria@amd.com>, "ananth.narayan@amd.com"
	<ananth.narayan@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "gautham.shenoy@amd.com"
	<gautham.shenoy@amd.com>, "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 08/10] perf/x86/rapl: Remove the global variable
 rapl_msrs
Thread-Topic: [PATCH v6 08/10] perf/x86/rapl: Remove the global variable
 rapl_msrs
Thread-Index: AQHbJs94BBtfaXiYQEK6lck+4XwturKiEiyA
Date: Fri, 1 Nov 2024 07:30:19 +0000
Message-ID: <b6d8d710fde051a47127cfde5451ee21e2301765.camel@intel.com>
References: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
	 <20241025111348.3810-9-Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20241025111348.3810-9-Dhananjay.Ugwekar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SA1PR11MB6848:EE_
x-ms-office365-filtering-correlation-id: 9e3816e0-8f4e-4732-72d3-08dcfa4709a7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?R3p3Uk12aW9YVXRTZHhrZHpaemM3Z1JGRXZFZzAyUktzc2Fqbm9QYWtabUh3?=
 =?utf-8?B?a3EzUVUyaFlQR2RxdytkT29FUFBKVys0eVpYZFE5bEtSTjErR0sxZlNoN05N?=
 =?utf-8?B?T1BBaEY4b3kvRDc4Vzdtc2F0TWNJRHlBbjRCaWNUSHlPVEtDMklyenhmTFl2?=
 =?utf-8?B?RHlTUlpKcis3R1lDN29BSFdTd05qQ3JWc1RicFZQKzJneUswTkNMUUljV3kr?=
 =?utf-8?B?a01OeHdLTjR5OGVTT2ZDbmtvY3dIU1krU3dtTi8xM0dHQmRkQUl6dTM4TlFF?=
 =?utf-8?B?K2pKUk0yU3lVYnB0TGkwVk8rUDI4TmI4bG5qdlJPaG85K0VmdU4zdE5kL0tG?=
 =?utf-8?B?NHBrVms0RDlYdUt1ZkI3SlZKTjZNdlJBRHlxdXU0Tjd3Y0o5anlGTUxEOXlB?=
 =?utf-8?B?RTNxRzdPV1R3aXJqZjRNMitFU3l0enF0NzVkSWxOelJnMk5kUnNDbllrQzBH?=
 =?utf-8?B?TEo4VitjNzNXTkFxV1RYWlVwNUp0aDFKem4zanR6Ky9CMWljelQrMXlyU0NS?=
 =?utf-8?B?V1BvVkUzcHMwWEd2MHBMZktSTXdmbmNJbWlCdGZXWVJ2ZmxwTTM0SlRLeWc5?=
 =?utf-8?B?bEhTdlVUWlVpa01SMFBKN05ZY08xaC9LTGE0NXZtNjkxOWpYOUVNUDZEZ1Q3?=
 =?utf-8?B?K2lmMUdyUGwzZTRFMzFYY3R0cEROc2Z6Slk5NkFHWkN4emlteEI4WkpoL3pF?=
 =?utf-8?B?SzVvOEFHUnFFbFd4QzFjM2ppbEt3T3h2N1hSQThMelllMk1BS1BYV3dSVzli?=
 =?utf-8?B?dTlKTDJPeS93ZmRYTGtnZWRaUHJhMUxtNkllR3FtNU9UdndnK251SCtZUHRQ?=
 =?utf-8?B?N2RZa0RxYVl4YWZ2V2ZHaWRKbi9nb3NaT3h1bEZyYU4ySDJ2T01Zdm93ZjYr?=
 =?utf-8?B?UmZIaUJRcFVkN0VHcGI5eVkwT0ExS1pwWmtCb2pZYjJCWG0xYVVEcnUwcHdr?=
 =?utf-8?B?ZHpSemx6QkhCMlNWanFwUlcxQjFSeTlqMlFJS2hydDBsOE12R3JEL093N2t4?=
 =?utf-8?B?aEhjblJQNEV5ZVkyZkpEWnBPSjVTM2UrUStjK1djZVVRRmhZRTRjYS9LNXEy?=
 =?utf-8?B?ZFhJQWw0Q2I3bjNBalRackhPaUNwUmFmZlFLZjZGRzlPYlFjNEcwaUpGZzJD?=
 =?utf-8?B?R054YkFpNUUvSjFna2czS1lQK2ZseDZyNjNaMWZZd0FZVkd2WWdwSkxsYU5B?=
 =?utf-8?B?Rjhkakh6VTBTWkNoNkNDWE5sWnpFRHNzYVJvRmFtdHVGcGtNSWwzNVlPTkdz?=
 =?utf-8?B?T25XcWVxaHdMNUNGR3R3NE9OeUJkTmxDYXh4WnRKVjJCWTFrbDcxMmFlOHF1?=
 =?utf-8?B?QzQ1ZFgyVXI5dDB5KzZTTUxoaUI0RTVSNWFSZlN1cFdrYk5aNWFsWEdYb1V4?=
 =?utf-8?B?WU4vK25NamczMXNIa0xOUTYzR0JYckI3Z3NoOWNrSDYySDFwRHAvSVpDbWYz?=
 =?utf-8?B?ZHVOR3llLzdRS0tXUlh3VGxudXViUWpZeE9hNlc4Zi85bmpybFFOOU5UbVho?=
 =?utf-8?B?OFZXOExyaUt2aGtIRTZ2ZFYvVjlVbDk2U25vaHNRdm5CbGh1UlJTZTh6Kys2?=
 =?utf-8?B?MzI0V3EyaDlxM2RldDI3aHh5UUFEb0VYdmxUM2psWVlQNHVieXVzcllNOCtt?=
 =?utf-8?B?Y0VpYTBsRDBzbllHNWM1SjBPY0xqL01aUWxKb3lkcnZYRDAwWVlRbnhSZU51?=
 =?utf-8?B?ZUhlNHJKVjJ4MnZWR3dsejVNNFEzaVZDSGJMd1Z3dVRFaDRjYjRCaDFLZjNm?=
 =?utf-8?B?bGpwcFQ1K3Y5Vk5aVk9maWJBTWJlcVNaaTROeG5IVzRrTmZNQWdLOEJ6Q2x5?=
 =?utf-8?B?T2w4elBBd0lhdkZveHlId2c1cTZZOWhmcmc3azNTL3NnZ3M5ejM2OWlERWpM?=
 =?utf-8?Q?S3xS5Z5rLMnqn?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2Njdzd1ajhxNlREQkp2Y2RseFhSL2tjWUZ4Mlp2cFBJRDZJQVcxbW5sdkxv?=
 =?utf-8?B?dk9oWkNQcWVXeFJnL0x3R21jS2tGWVZCcU9WU2tHNVA5SDNBbWFKY2FKU1ZS?=
 =?utf-8?B?c1F1NTk2MHRKT28wZ3JRWkljaTFnQVZWb2czZnd3SzQwTktLcy9KRDNnQmRn?=
 =?utf-8?B?QWY3Q295TEpzd0lKMmhlcXlWcjladXg5TjZOdTAzeC9pZ3d0RTE1czV5MjRJ?=
 =?utf-8?B?UVBhVlJ3SGtLUktSVFl2d3ZJdTl0RjJqSmM4L0lFVHVxQUZSMDdoVmdGMFQv?=
 =?utf-8?B?STQ4QlkvcWtnVzE4N0Z1ZWMramdDL29JN2xUVVd5TGpoSnNHVDZvTVZ5VFlZ?=
 =?utf-8?B?QVlFREZIYmprWnZMSkFLaGFkMjJuL2VQQ0RJSWJIR0JXWmtaUmdiYWxFL0hQ?=
 =?utf-8?B?UnJSK2MvM2pDUXZpbkV4RUdtNnFtRmZCb2txT1VnUVdRUCthMlRDRFFDemxB?=
 =?utf-8?B?RUh0U3ZkVTRGU08xVFM4aGZEVjlYY2d1aWtzZlNwWkUyNlA4YWFBZXZvWU9y?=
 =?utf-8?B?ZDM0eVRKSkVvNkc3K3lFcVdtajgxMjN5MVFiayt0T2dNQklBQkZFTXFMb2dU?=
 =?utf-8?B?Y3djdjB6bDd4akV6SlhyQVdMWTV2d0w2dGJ4U1hXTUE2SFJKeDNWNlFjb0JZ?=
 =?utf-8?B?NkY1Y0pxMWd6VG9vdUZ2ZDVITlZkK1p4NHBjMW91VmpKcTNFb2JHUWYyUnpN?=
 =?utf-8?B?a1dLZkxnSjZWazQxMGtFNHVVR1RFY0QrSGNtODI3cGdQN3l3c1kyQm9SN0tp?=
 =?utf-8?B?SFAxWTAyTGREWFM2ZnhuZTAwVXZEZzYxN2p3QlFRNG1xNU9tcWVUcSsySk82?=
 =?utf-8?B?MVhjcWlOcS96UmR5VSt5OWV4N0dsRzJ6TmxPYmhxR0lDNm5vWURFbU9RWDFt?=
 =?utf-8?B?TTJyNVUwa3VMNUJUSDI0QVRPdzJOVkZvcGFKNkNpQnVORkQ0eDFtY2o3WjZP?=
 =?utf-8?B?bWR1RXl6QitPTWN6Ui9YZ0hPRzYyQUhqWDZKdng0N2xIM2FFcm1ENFQzcVhJ?=
 =?utf-8?B?R2RyZFVKVEtyKytLeTlVZENFVUw2YW1valhGTFdFcThqTlMwb1laNWY1Z0Jq?=
 =?utf-8?B?WnRJQ0Z4YVpwQWRFNXduYmdxS0I5V09EbEhybGxyVlMrcW5mYXI2UUFTU1Rv?=
 =?utf-8?B?ZWhNaG5JT2pKMFR4MGgzL0t1M3Q5MFRSbW91NVBQSHZiZklwOUR2OVZkRWNl?=
 =?utf-8?B?VzErcFFKR2xUVHEyZFg1b0hnM2dNOUFzQVRYVVhIZkFLMjBPQ0t2Z1pYS1BK?=
 =?utf-8?B?ZkhCdXVac2o0MHBNT2Z6eHg4bnRRa3lzT1ZEY1VYWCsvQW5reC9ldG1LZUwx?=
 =?utf-8?B?N1NPSElrWHZjU3JXbzdHckR6V3c4cUR6WEErUEVadi9BYmNuVzBmNlJxdGJq?=
 =?utf-8?B?Yk9kRjA1TTBLck5iTVNkbHUzZFJsekNHcGVzdncxN2ZOajhDa3pkMDNSeFk4?=
 =?utf-8?B?WU1Bd3RLN3JGUjFmSGlhc21MbFBZc3BxdEZKcEI1N1I2bmdQa0RTclY2cE9m?=
 =?utf-8?B?RG0yR3g5b3VIRG5ob3lSbjYybjJkRXJUc2NXZExJNFNQR29IVzhrajZYRGow?=
 =?utf-8?B?NU5MelAxcFpvUjFFeTdHeG5pSWQvSEwwZWpDVUNnOW1wcVM2Wk5UU1BWRDR6?=
 =?utf-8?B?Vnl6VkJ1eWUzeXBWZXZ2MFhsWUYxd3hRdGE1NDVFT0xUMGtiUlE0djNpSG9C?=
 =?utf-8?B?UTBsZWFJeEZ3K2NPWk1neG5UMHh1cVhsQVZ0TTBXend5RmFLajU0NU5pWU9G?=
 =?utf-8?B?cHZqdVArRlhnUG1OS1lxVUV1QVZ2TlN5cVJxZ04xdlR4ZTlMRWk4WmlWRnZ6?=
 =?utf-8?B?eEcrSXBYalR4RC93VlY0NWVXQW02S2RIbS8zTEE0SmoxVGJpMzRMeUE0c2tO?=
 =?utf-8?B?UmdLTkhKNk5jeDduc29UVkltb1lIcGozZFRSWnZoZDNxNEMvWCtJSkU4Sjlt?=
 =?utf-8?B?bWFBMWx2U0k4U2JyY0c3bDNvZUtwa0ZwK1BLWVRpWEdrQmVWdXVqSVJoRUVt?=
 =?utf-8?B?dU9CaDFJczQ4RmlJVjcwUUJMenQxdVFPamlpNGlkOHNkS3FOZEQ2cXQwRDgr?=
 =?utf-8?B?OGpZL2lTNERzMkx3cG9CMlZyRitiVUY1ZUxwaGJQNmMvN3VoN092TnlJQUFj?=
 =?utf-8?Q?tTIN0h2pN9DX6zHus+5luqD6E?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC3090A47D21D147BE436E626072DD6A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3816e0-8f4e-4732-72d3-08dcfa4709a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 07:30:19.1117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8d9uD1NC4nsMc2igrqN0HBOl1FF1KmvI6tws46cReEbNmlVtuWsTNeosT/MKVwkJHyKi6WNSeRa3KEp5qllHtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6848
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTEwLTI1IGF0IDExOjEzICswMDAwLCBEaGFuYW5qYXkgVWd3ZWthciB3cm90
ZToNCj4gUHJlcGFyZSBmb3IgdGhlIGFkZGl0aW9uIG9mIFJBUEwgY29yZSBlbmVyZ3kgY291bnRl
ciBzdXBwb3J0Lg0KPiANCj4gQWZ0ZXIgbWFraW5nIHRoZSByYXBsX21vZGVsIHN0cnVjdCBnbG9i
YWwsIHRoZSByYXBsX21zcnMgZ2xvYmFsDQo+IHZhcmlhYmxlIGlzbid0IG5lZWRlZCwgc28gcmVt
b3ZlIGl0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGhhbmFuamF5IFVnd2VrYXIgPERoYW5hbmph
eS5VZ3dla2FyQGFtZC5jb20+DQoNClJldmlld2VkLWJ5OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0Bp
bnRlbC5jb20+DQpUZXN0ZWQtYnk6IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4NCg0K
dGhhbmtzLA0KcnVpDQoNCj4gLS0tDQo+IMKgYXJjaC94ODYvZXZlbnRzL3JhcGwuYyB8IDcgKyst
LS0tLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvZXZlbnRzL3JhcGwuYyBiL2FyY2gveDg2L2V2
ZW50cy9yYXBsLmMNCj4gaW5kZXggYWU4YjQ1MGNhYTliLi5lODBiNjJjZjlhYmMgMTAwNjQ0DQo+
IC0tLSBhL2FyY2gveDg2L2V2ZW50cy9yYXBsLmMNCj4gKysrIGIvYXJjaC94ODYvZXZlbnRzL3Jh
cGwuYw0KPiBAQCAtMTUwLDcgKzE1MCw2IEBAIHN0YXRpYyBpbnQgcmFwbF9wa2dfaHdfdW5pdFtO
Ul9SQVBMX1BLR19ET01BSU5TXQ0KPiBfX3JlYWRfbW9zdGx5Ow0KPiDCoHN0YXRpYyBzdHJ1Y3Qg
cmFwbF9wbXVzICpyYXBsX3BtdXNfcGtnOw0KPiDCoHN0YXRpYyB1bnNpZ25lZCBpbnQgcmFwbF9w
a2dfY250cl9tYXNrOw0KPiDCoHN0YXRpYyB1NjQgcmFwbF90aW1lcl9tczsNCj4gLXN0YXRpYyBz
dHJ1Y3QgcGVyZl9tc3IgKnJhcGxfbXNyczsNCj4gwqBzdGF0aWMgc3RydWN0IHJhcGxfbW9kZWwg
KnJhcGxfbW9kZWw7DQo+IMKgDQo+IMKgLyoNCj4gQEAgLTM3Niw3ICszNzUsNyBAQCBzdGF0aWMg
aW50IHJhcGxfcG11X2V2ZW50X2luaXQoc3RydWN0IHBlcmZfZXZlbnQNCj4gKmV2ZW50KQ0KPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRUlOVkFMOw0KPiDCoA0KPiDC
oMKgwqDCoMKgwqDCoMKgZXZlbnQtPnBtdV9wcml2YXRlID0gcmFwbF9wbXU7DQo+IC3CoMKgwqDC
oMKgwqDCoGV2ZW50LT5ody5ldmVudF9iYXNlID0gcmFwbF9tc3JzW2JpdF0ubXNyOw0KPiArwqDC
oMKgwqDCoMKgwqBldmVudC0+aHcuZXZlbnRfYmFzZSA9IHJhcGxfbW9kZWwtPnJhcGxfcGtnX21z
cnNbYml0XS5tc3I7DQo+IMKgwqDCoMKgwqDCoMKgwqBldmVudC0+aHcuY29uZmlnID0gY2ZnOw0K
PiDCoMKgwqDCoMKgwqDCoMKgZXZlbnQtPmh3LmlkeCA9IGJpdDsNCj4gwqANCj4gQEAgLTgwNSw5
ICs4MDQsNyBAQCBzdGF0aWMgaW50IF9faW5pdCByYXBsX3BtdV9pbml0KHZvaWQpDQo+IMKgDQo+
IMKgwqDCoMKgwqDCoMKgwqByYXBsX21vZGVsID0gKHN0cnVjdCByYXBsX21vZGVsICopIGlkLT5k
cml2ZXJfZGF0YTsNCj4gwqANCj4gLcKgwqDCoMKgwqDCoMKgcmFwbF9tc3JzID0gcmFwbF9tb2Rl
bC0+cmFwbF9wa2dfbXNyczsNCj4gLQ0KPiAtwqDCoMKgwqDCoMKgwqByYXBsX3BrZ19jbnRyX21h
c2sgPSBwZXJmX21zcl9wcm9iZShyYXBsX21zcnMsDQo+IFBFUkZfUkFQTF9QS0dfRVZFTlRTX01B
WCwNCj4gK8KgwqDCoMKgwqDCoMKgcmFwbF9wa2dfY250cl9tYXNrID0gcGVyZl9tc3JfcHJvYmUo
cmFwbF9tb2RlbC0NCj4gPnJhcGxfcGtnX21zcnMsIFBFUkZfUkFQTF9QS0dfRVZFTlRTX01BWCwN
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBmYWxzZSwgKHZvaWQgKikgJnJhcGxfbW9kZWwtDQo+
ID5wa2dfZXZlbnRzKTsNCj4gwqANCj4gwqDCoMKgwqDCoMKgwqDCoHJldCA9IHJhcGxfY2hlY2tf
aHdfdW5pdCgpOw0KDQo=
