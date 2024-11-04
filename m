Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2ED23AB;
	Mon,  4 Nov 2024 07:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730704569; cv=fail; b=gfQYJohBukrsMdmrfzrosZveDLy0ZMQhv4VjZTyX3ZuTK+fCDPZx4BY+kkZwRZqt8R+fmLE3PS5lrvliKRdvpAr9Kzlua6zCWaZ8zW8+tc0nI5Wie9vthxdShuwfhHQgstfUZ35mggX0tRFR2TnwwzgkSzJrJ5fAyVRmun6xs5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730704569; c=relaxed/simple;
	bh=S4jmwebgd59XX5/n7e6U1icTb4m1tVz3CO0zLpPAfYw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a6QKWwoXb4dtsQeBNNUvtmGnQyWMMtu6k5FTaIxgRGNHKTP/Bkb+sx7raGh6mq85slarp6FrPHwiuYMGtwYuToWwj/zfR6ezpVWYqGVb6aaX9tPVxJT9uowbQuE8DDKnKt0rupBNyuQqGIgLVQBOJqAoVu93UQMUrW+WI2wV4V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BvI5hNbV; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BvI5hNbV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730704564; x=1762240564;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=S4jmwebgd59XX5/n7e6U1icTb4m1tVz3CO0zLpPAfYw=;
  b=BvI5hNbVyyXLSoNY7CzVdYN+b+tAs5m4FzKgsMh/0BomoiaQcEzu2Kmv
   FyQo8QP1AT1FjSExzytFcsx55aBRrSMDJARYuRaafIbEsPbHMZHDl4Idk
   PGVccbXlHDxaEXXnwvPazrYJK7pIQ6M43y9QN2pfy/A6RTW89/YFWW+Ya
   XpNSaHQFvDhitgKXjq7Uq6P8XCCz3MoUmXivI6RC7cUsDGkki63F5iOYm
   SMfIT7rshtswodqZXn7CwEkuzL8m6ZLneMAKC5NkPg6p8uKTD2woPqOTG
   f775CE1z9jcV51vahvXIlq8P72GQ33FRFcq52Qn+j5N4+/tkkGtm9MwPV
   g==;
X-CSE-ConnectionGUID: w5f0GYl1STiH2sDX9SBRpA==
X-CSE-MsgGUID: 2b/Ywz0MRbGkgrwiBczRUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="30491360"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="30491360"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 23:16:04 -0800
X-CSE-ConnectionGUID: Mdd9aXNlQauZoEhosucJ4Q==
X-CSE-MsgGUID: 6QG7souuTgeUMIdmVfvgkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88150861"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Nov 2024 23:16:04 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 3 Nov 2024 23:16:03 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 3 Nov 2024 23:16:03 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 23:16:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJWLB6d5TmVITXy2dLoI4dEfZeXeWbIOywV25vmnDDVmoUEKnuVaBMbAJPo6P3ZdBr+Fzhu4CpASRgw9MW/WmxDGgBJRWo0vg1LroNHYbIUJU+uHSLvibZ2O4EN7bTnDHCM71+VjTYJ3ZfcFU4+E0g5lB53bs/CM66AOWsGvy8YExmuXqxD7r8xJmBvnTY0vYfRWnHn5A1RDMHxi+yg4YfXdOPhHPkwhp90b3eow9IdQdPS//MFdK2auF+XuxyKk4N2trFNul6gfV4R5FkzTOyDJWrBxlsTKOLmVi3YgwHDCo9SW1i3xgyybyBkeD0U42aSgYDq7im0SSJEdUoj+Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4jmwebgd59XX5/n7e6U1icTb4m1tVz3CO0zLpPAfYw=;
 b=Z78SG2wXBzXSvLJrFzGyvgRqFGGmoWGAYknvgBpJtM8P1/DLPSs4rRbwcahVGEqftBp91STZj90qgw6pa+PCo5mePfthhr1PitOD4QuocQNegBFM8DKPyVTggpL/y2i7AJJ1rW9g/o26zmMc0B1Q3KeewHkb7iXsHfwWbjYVhcB33EJqJUetldIk7RkXqdl1uVTWu9dtyUKk92kXyskCSjRxBw0d1k5PNyFoXtMvS0X/DMzmOmwH/cyyjtjyUjCm2bYnEY5OnVgJ6jYL6dwzuia+nR4ls1NJwiS6CXudr/lE1sdzDM8UumQcBzlvBShK98VBlH91aYyNcVWEuHhpbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by IA1PR11MB7856.namprd11.prod.outlook.com (2603:10b6:208:3f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 07:16:00 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 07:16:00 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "Dhananjay.Ugwekar@amd.com" <Dhananjay.Ugwekar@amd.com>,
	"gautham.shenoy@amd.com" <gautham.shenoy@amd.com>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"ananth.narayan@amd.com" <ananth.narayan@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"ravi.bangoria@amd.com" <ravi.bangoria@amd.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"irogers@google.com" <irogers@google.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>,
	"acme@kernel.org" <acme@kernel.org>, "kprateek.nayak@amd.com"
	<kprateek.nayak@amd.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v6 03/10] perf/x86/rapl: Remove the cpu_to_rapl_pmu()
 function
Thread-Topic: [PATCH v6 03/10] perf/x86/rapl: Remove the cpu_to_rapl_pmu()
 function
Thread-Index: AQHbJs8wlyvPvXT1VEWmwWZENYr1XrKb4DIAgAAHF4CABjUUgIAEZXsAgABDUwA=
Date: Mon, 4 Nov 2024 07:15:59 +0000
Message-ID: <d92fbaab082180740baa7a1ade0edaaac51e005b.camel@intel.com>
References: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
	 <20241025111348.3810-4-Dhananjay.Ugwekar@amd.com>
	 <Zx9RHtFAURrORTrd@BLRRASHENOY1.amd.com>
	 <52e578d0-a885-4d6c-836d-fc3ec0f491b2@amd.com>
	 <2884838e95def2a0ca3d2c263de10d9aab991501.camel@intel.com>
	 <2fd6bad3-cb37-4a4a-8b47-d7c2ffc96346@amd.com>
In-Reply-To: <2fd6bad3-cb37-4a4a-8b47-d7c2ffc96346@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|IA1PR11MB7856:EE_
x-ms-office365-filtering-correlation-id: 832062d6-43cb-4fba-67b8-08dcfca088ce
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d2hxcG9vNVBmNFRiRFBQdjIvVHZRRkNqNmJ4dGZWb29CZjhSSGZURzJTbmpL?=
 =?utf-8?B?aEFwMEkrZmZsWXZGUk1hbGxoZG9SR29kZXg3OFA0bENPWThneFFHcE0wNVBU?=
 =?utf-8?B?ck5wN284UmZlb1pOMmtwRlQvZUdPRVBzZTJZV3lwTjBuekY0M1AwYnM1NGFW?=
 =?utf-8?B?dXdkRTA0bzNYTFlvbEk5NlJ1Sk02dHEvUFk1aFZrVWlxbGJuSGRiTWtXaTdZ?=
 =?utf-8?B?UU94TldpR2RTWktnc09wNWVkNUt6YUltdUxDRXk2Qno5MGJsemFhYUIxa0VI?=
 =?utf-8?B?elk3MGxRWHdPeFZwTEI0Q1d2MTVueGduMWlFbFZaVUowa0k1cVpIUFhxSVpt?=
 =?utf-8?B?SzQ0M0tUVi9rakhIRTNLdXFNNkE3aFBzQ1JTVCtja2ZObWdHQktxOXV6WFFZ?=
 =?utf-8?B?R2gxWkFndlRxdk5hd0N3dlcyQzdSR0kvY0FmRGxqU3ZyME4waGtpTnhid0Qz?=
 =?utf-8?B?ZEtFNGd5R2hIUmZJWlgyVjR2UzR5SW41dDhDQ2NVU0hRdUF4SzFJSk16Qlp6?=
 =?utf-8?B?emNza2ZrdGlUMXpkUVNSTW9qRkhkb1pkeVl0S1BiT05tQXV6eEdnQ2pxTTNT?=
 =?utf-8?B?MmtQbDBpNzAxYXFBelBBaVJOKzZrWWQ0akNHVHpiL3FHajI0em9iNWFsWnYr?=
 =?utf-8?B?azFUZXk4S3BNUS8rdG12bGRCQmtPUEpsNXlrZ3lDOFRPVVRyY1ZjdCs0UitY?=
 =?utf-8?B?SUpYVXVKNFBubmpTSnNiUmJUbUkybVJDa05ERXJDbGVsVjZaL2FRSUp4NVhC?=
 =?utf-8?B?ejM0UzZaZVhjUElJeGFHZUk2c2V1ZzJDZEoxRjBINnRQS3dubUJxS2tTVFI1?=
 =?utf-8?B?VWJmSGZwemdMQlplTmdWZWcvcGpnN1ZiS0o1MWVLMXFKcUFWK2ROZ21xUXFR?=
 =?utf-8?B?M0ZzTzNxTmNQQ1Q4RnYwMUZMSTBWa1hrbGdLUWtXQ1ZIYjFETE9ZckhCTXBQ?=
 =?utf-8?B?Y2U5WnBHMVphem1YczZSZUhBb2trU3owRzJudzRJVDZHaElWOEMzYnNYK1di?=
 =?utf-8?B?VndaNGJvTUhQbldlYW5IRjJuKy9PallGVGsvV3BPcDdJS3JucWFIcndjdEFS?=
 =?utf-8?B?UmNRRjZ1dXAyVm9RVG1vcXdqOVpwM2JucjFrMCtCTlVpejdMaGh5UDhma3g1?=
 =?utf-8?B?VTlTc1BaaXg5UldRY1E5ZGJ4ZWVJekdFUU1FZ2dHTHFQclh2TEpMYXlyQnIy?=
 =?utf-8?B?WkExT2k0Mk1sWFdJSlR3ejMwZ3QxVjBldVQyREZCeG5uUm4yMnV2ekd0eThX?=
 =?utf-8?B?T3dBZTJ3OXhZc1l6dTArZERHRmxRTjFvUWRUMnhJc2Nvc0gxT0M4NkdQS3Q0?=
 =?utf-8?B?K1hHMEhvMXA1Yzlpb3Brc21WdlFtMU9rREpuRnJTc3pqQm41enNydW15UGNl?=
 =?utf-8?B?VDg0dVVNZzloMzhhZy83YnE2OGdWcXJ2U01KeDY0UzQwR3RQdklrYTljR1d2?=
 =?utf-8?B?YmRYRGVZVGw4Zy81aldHeUdtVGpXVGF2VHdHVEx6NXFhTzFWQ0dZMGVzdFZZ?=
 =?utf-8?B?eUY4YVp1Z1IxalBjOWpUeVBSVlBqbDEyWUhTbEVqK3hIdFlEYklzd1dmMFdZ?=
 =?utf-8?B?dWRpdzlBOFZqUzBlRENjd1l4K282cXp5YUxCdW4yMFJaZWlrdVk3Rnd2U1hz?=
 =?utf-8?B?cFdaVmU1c3dIRzR4czFJK3NJZFBHdnFJTmVmN3J1V2xickJQNG9rczhzSzVp?=
 =?utf-8?B?L1pTK0pQM1RzZS9HMGg4MmZSTk8waVM2T3hHNyswR016TDVVTUVSaXZqUnpp?=
 =?utf-8?B?STJHbTBHUTg0RXg0V2M2c3U1MmFXYnFkTWdabUhXQ0psY1dIVHpXbEJrcU1Z?=
 =?utf-8?Q?YSwb1jA4vbfkYg6bf2ww//6aeu29IKafqf+L0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTFydVJzNm9mRnNqL1U3Wk5oYjV3VFFmSkc5bkZMekZDTlNiWldPMGNvZGRK?=
 =?utf-8?B?Rm9zRUxuVWlDZExmeVJ6Z01TZ1dDOEIxL2R5ZkE1RWpzczRnRWtQa3hxdm9N?=
 =?utf-8?B?Z0VZd25oaytJUlI0TlE2eS96NHc3ZC9ZVEEySHV2TDJPU1hpN0Y4UEJqVm5S?=
 =?utf-8?B?TXFqWjZLeGlmSlJIYy80eVdlNzFhMWVGV054SUJGbVRJWU1jTWh1ZlZaMzJr?=
 =?utf-8?B?S0pGbytMdEhySDc0Tk53RWpLK2NVdFFiN3VHaU4yL092TDduZ3czUERPenc5?=
 =?utf-8?B?OEoyM1oxa1pjZEpLY203RDdDaTJqeUpvcGgvVUFaR3JaWFpmZUhUdCtPOXdz?=
 =?utf-8?B?QStjNWpOQ296WHROMEtCNFZ3V2YxU01sN1pjTVY3d0grbmdtU011OXA5MVYz?=
 =?utf-8?B?YXVOWjNXZlZGYUhtSTNIL2NQNkxsQzJwREU1OHpLNFpHUlQwcXR3Mk1oUDVJ?=
 =?utf-8?B?ZFF5TWlhTEJML3NZdFVYN25GWTY0MjZoMTFKMGoycjJtakZiaGhJekt4bFpN?=
 =?utf-8?B?cXJqeExZZFVKK2hXWEZrTktIazlvZDQvUmt4NXZJWEdvVVorNDFnZXhqMDZy?=
 =?utf-8?B?ZnVHdE9JdjhMM1BPd0xvREF5QkthbVNBd1RDc1hUaEg3WFNwOFN2eld0cEZF?=
 =?utf-8?B?MXpZVVlhZTNEZFk4UE1SaktFVG5mZFlHN1BQampJbHY3aFpIdVJkTUoyaVQ0?=
 =?utf-8?B?dkgrTmk3Si9yVm5za0MxekdUTE1SUG8yYWJkbEVYN3hDaEVpMHhVK2NJWEIr?=
 =?utf-8?B?UDc1K05NczBmRWsyWFpLTXN5dk91K0ZmL1hBeUhyWUw5d0Q5YU1TMnBzQU9a?=
 =?utf-8?B?dVVwcUwyUnl2Sk1NRy9ZcmRVYngwenNlc3p3bUx1U0FKaC9JUU9BazdPcU8v?=
 =?utf-8?B?YVVnN1ZYbkR4eGpFcWdHNHJMdkwyZzNyTWFFMGtRa2hOSDFXL1NCMEIrVWpi?=
 =?utf-8?B?NFlRb0hqUjJDOFh6SERaU3VXaXI4MDRBRkg5dE1EMXlJWms0WVkzVzhud3Ew?=
 =?utf-8?B?RWZ2bUpQaFBvR1JmOVZDdFVzVm1xdzRGT3ZTT2V4ZDBUSEY2eDh2VDlCS3RB?=
 =?utf-8?B?YThnT0ZuQWNydkc4eGZkMHJkWjZ5VnhnTll5My9MUC9ndHB3Y3ZrNllKbEc1?=
 =?utf-8?B?WU5reFd1c2FrZ0w1Z1NaUFlYVFU4dEdxdDhITVdzcFZJRmU4VnRHbDJlVE5C?=
 =?utf-8?B?WlBxMnNuektlc1BaSDQyWW9yYXBPNVQ4dHdldGNpNEpiOFFkMUFZRFdSYjd5?=
 =?utf-8?B?SXg4b1hnYlNxMTlZK3BzdEQ0UjduY212N2tRVDE0K0hvWWlPQkJ3b210N3Nz?=
 =?utf-8?B?NytBRjAvYU85UTR3RmpzdlVtZG1qZWl5THp5NklxeWhDaUJSU1BGaUFLTVZI?=
 =?utf-8?B?cHV4cnFoMVpHSDRlS1JPQTRjSWpWT3I5K0NXK0F6K1VTNisxdHAzQTRnMWxv?=
 =?utf-8?B?M1hwRGZKcVNUVDVEZUprR1Nsdk1DK1FoVFhyMUgxSlJGWHl1UUo3Z0Fqa3px?=
 =?utf-8?B?Smd2d05CTHllajBWdUZwTGxOWkMzMEJCU2xsaHZzMk85RmJKWlJZYXdKN0lz?=
 =?utf-8?B?S3ZMS01qUFJOUXh2elJzcUZMVSs1VmpmYmpzOWF0Y09SdVBJSjJYanJkYzZv?=
 =?utf-8?B?ZTM0bWJiVVI1bm4xWXQ5T3JCcXc3RlBuV0tmbndDdmZkYUZHa0Fqc0NJaUZN?=
 =?utf-8?B?V2Q4Qmd6bjRIN1lSQ1d1cHE4NnY5dFRVNGVLNGtIeXY2bWJTQ0ZxblhxUkN6?=
 =?utf-8?B?eFFBeDNlNHN0QmVlUmRHSTArQTdCd3VIWS9ja2gyUHNpNStZSmRXRnlxSUlY?=
 =?utf-8?B?R2pnN1JlY21ZTjBXcWhPeTdnOEI2TCsvYWhRRGFzY2ZFaE1TcW9rZlptZmtZ?=
 =?utf-8?B?aS9ROUJQNHJzMUVvcE1XVnZ4M2lBM1c4Q3JsTE10blZxbGc4cWNCdzAzVFQv?=
 =?utf-8?B?UU9UT0dOdFlkSXB5Z0VIK3JVYWRlWjBXSUplb2x4WDJ3ODFRVTRXWlVwa2tL?=
 =?utf-8?B?MUZyS0lNVkRHZlg1SmpnbTE4Si9TUVp0NU9TaVpnWVlBcnNQb0xxRmJJV2Yw?=
 =?utf-8?B?cnIyei9oQTMzcGhJUjdQTHFFNTdWQ3RiaXRiRlZJRFNBWVplNG54VG02L3Ja?=
 =?utf-8?B?UVRjRStybW45NXJTUzBKR1U1WW1EUHRPeWJXdm9mWWtPU0I5ZEFTVkdjOG90?=
 =?utf-8?B?bXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB532D15F813AB4393C50593335D5454@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 832062d6-43cb-4fba-67b8-08dcfca088ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 07:15:59.9935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MV9rys01was0U0BIkXqqnKfHTjvSgXIANJ2hN+Bfwil8gAKjmce2ridB+K4DwZRtzrwRHPAhgA2jCPz7nAxzJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7856
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTExLTA0IGF0IDA4OjQ1ICswNTMwLCBEaGFuYW5qYXkgVWd3ZWthciB3cm90
ZToNCj4gSGVsbG8gUnVpLA0KPiANCj4gVGhhbmtzIGZvciByZXZpZXdpbmcgYW5kIHRlc3Rpbmcg
dGhlIHNlcmllcyEsDQo+IA0KPiBPbiAxMS8xLzIwMjQgMTozNiBQTSwgWmhhbmcsIFJ1aSB3cm90
ZToNCj4gPiBPbiBNb24sIDIwMjQtMTAtMjggYXQgMTQ6NDkgKzA1MzAsIERoYW5hbmpheSBVZ3dl
a2FyIHdyb3RlOg0KPiA+ID4gSGVsbG8gR2F1dGhhbSwNCj4gPiA+IA0KPiA+ID4gT24gMTAvMjgv
MjAyNCAyOjIzIFBNLCBHYXV0aGFtIFIuIFNoZW5veSB3cm90ZToNCj4gPiA+ID4gSGVsbG8gRGhh
bmFuamF5LA0KPiA+ID4gPiANCj4gPiA+ID4gT24gRnJpLCBPY3QgMjUsIDIwMjQgYXQgMTE6MTM6
NDFBTSArMDAwMCwgRGhhbmFuamF5IFVnd2VrYXINCj4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4g
UHJlcGFyZSBmb3IgdGhlIGFkZGl0aW9uIG9mIFJBUEwgY29yZSBlbmVyZ3kgY291bnRlciBzdXBw
b3J0Lg0KPiA+ID4gPiA+IFBvc3Qgd2hpY2gsIG9uZSBDUFUgbWlnaHQgYmUgbWFwcGVkIHRvIG1v
cmUgdGhhbiBvbmUgcmFwbF9wbXUNCj4gPiA+ID4gPiAocGFja2FnZS9kaWUgb25lIGFuZCBhIGNv
cmUgb25lKS4gU28sIHJlbW92ZSB0aGUNCj4gPiA+ID4gPiBjcHVfdG9fcmFwbF9wbXUoKQ0KPiA+
ID4gPiA+IGZ1bmN0aW9uLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IERo
YW5hbmpheSBVZ3dla2FyIDxEaGFuYW5qYXkuVWd3ZWthckBhbWQuY29tPg0KPiA+ID4gPiA+IC0t
LQ0KPiA+ID4gPiA+IMKgYXJjaC94ODYvZXZlbnRzL3JhcGwuYyB8IDE5ICsrKysrKy0tLS0tLS0t
LS0tLS0NCj4gPiA+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEzIGRl
bGV0aW9ucygtKQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9l
dmVudHMvcmFwbC5jIGIvYXJjaC94ODYvZXZlbnRzL3JhcGwuYw0KPiA+ID4gPiA+IGluZGV4IGY3
MGM0OWNhMGVmMy4uZDIwYzViMWRkMGFkIDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBhL2FyY2gveDg2
L2V2ZW50cy9yYXBsLmMNCj4gPiA+ID4gPiArKysgYi9hcmNoL3g4Ni9ldmVudHMvcmFwbC5jDQo+
ID4gPiA+ID4gQEAgLTE2MiwxNyArMTYyLDYgQEAgc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQN
Cj4gPiA+ID4gPiBnZXRfcmFwbF9wbXVfaWR4KGludCBjcHUpDQo+ID4gPiA+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqANCj4gPiA+ID4gPiB0b3BvbG9neV9sb2dpY2FsX2RpZV9pZChjcHUpOw0K
PiA+ID4gPiA+IMKgfQ0KPiA+ID4gPiA+IMKgDQo+ID4gPiA+ID4gLXN0YXRpYyBpbmxpbmUgc3Ry
dWN0IHJhcGxfcG11ICpjcHVfdG9fcmFwbF9wbXUodW5zaWduZWQgaW50DQo+ID4gPiA+ID4gY3B1
KQ0KPiA+ID4gPiA+IC17DQo+ID4gPiA+ID4gLcKgwqDCoMKgwqDCoMKgdW5zaWduZWQgaW50IHJh
cGxfcG11X2lkeCA9IGdldF9yYXBsX3BtdV9pZHgoY3B1KTsNCj4gPiA+ID4gPiAtDQo+ID4gPiA+
ID4gLcKgwqDCoMKgwqDCoMKgLyoNCj4gPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqAgKiBUaGUgdW5z
aWduZWQgY2hlY2sgYWxzbyBjYXRjaGVzIHRoZSAnLTEnIHJldHVybg0KPiA+ID4gPiA+IHZhbHVl
DQo+ID4gPiA+ID4gZm9yIG5vbg0KPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoCAqIGV4aXN0ZW50
IG1hcHBpbmdzIGluIHRoZSB0b3BvbG9neSBtYXAuDQo+ID4gPiA+ID4gLcKgwqDCoMKgwqDCoMKg
ICovDQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gU2VlIHRoZSBjb21tZW50IGhlcmUgd2h5
IHJhcGxfcG11X2lkeCBzaG91bGQgYmUgYW4gInVuc2lnbmVkDQo+ID4gPiA+IGludCIuDQo+ID4g
PiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqByZXR1cm4gcmFwbF9wbXVf
aWR4IDwgcmFwbF9wbXVzLT5ucl9yYXBsX3BtdSA/DQo+ID4gPiA+ID4gcmFwbF9wbXVzLQ0KPiA+
ID4gPiA+ID4gcG11c1tyYXBsX3BtdV9pZHhdIDogTlVMTDsNCj4gPiA+ID4gPiAtfQ0KPiA+ID4g
PiA+IC0NCj4gPiA+ID4gPiDCoHN0YXRpYyBpbmxpbmUgdTY0IHJhcGxfcmVhZF9jb3VudGVyKHN0
cnVjdCBwZXJmX2V2ZW50DQo+ID4gPiA+ID4gKmV2ZW50KQ0KPiA+ID4gPiA+IMKgew0KPiA+ID4g
PiA+IMKgwqDCoMKgwqDCoMKgwqB1NjQgcmF3Ow0KPiA+ID4gPiA+IEBAIC0zNDgsNyArMzM3LDcg
QEAgc3RhdGljIHZvaWQgcmFwbF9wbXVfZXZlbnRfZGVsKHN0cnVjdA0KPiA+ID4gPiA+IHBlcmZf
ZXZlbnQgKmV2ZW50LCBpbnQgZmxhZ3MpDQo+ID4gPiA+ID4gwqBzdGF0aWMgaW50IHJhcGxfcG11
X2V2ZW50X2luaXQoc3RydWN0IHBlcmZfZXZlbnQgKmV2ZW50KQ0KPiA+ID4gPiA+IMKgew0KPiA+
ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqB1NjQgY2ZnID0gZXZlbnQtPmF0dHIuY29uZmlnICYgUkFQ
TF9FVkVOVF9NQVNLOw0KPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoGludCBiaXQsIHJldCA9IDA7
DQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgaW50IGJpdCwgcmFwbF9wbXVfaWR4LCByZXQgPSAw
Ow0KPiA+ID4gPiANCj4gPiA+ID4gQ29uc2lkZXJpbmcgdGhhdCwgc2hvdWxkbid0IHJhcGxfcG11
X2lkeCBiZSBhbiAidW5zaWduZWQgaW50Ig0KPiA+ID4gPiBubz8NCj4gPiA+IA0KPiA+ID4gQ29y
cmVjdCwgd2l0aCB1bnNpZ25lZCBpbnQgd2Ugd2lsbCBiZSBhYmxlIHRvIGNoZWNrIGZvciBuZWdh
dGl2ZQ0KPiA+ID4gdmFsdWVzIGFzIHdlbGwgd2l0aCB0aGUgDQo+ID4gPiAiaWYgKHJhcGxfcG11
X2lkeCA+PSByYXBsX3BtdXMtPm5yX3JhcGxfcG11KSIgY2hlY2suIFdpbGwgZml4DQo+ID4gPiB0
aGlzIGluDQo+ID4gPiBuZXh0IHZlcnNpb24uDQo+ID4gPiANCj4gPiB5b3UgY2FuIHN0aWNrIHdp
dGggdW5zaWduZWQgaW50IGhlcmUsIGJ1dCBpbiBwYXRjaCAxMC8xMCwgSU1PLA0KPiA+IG1ha2lu
Zw0KPiA+IGdldF9yYXBsX3BtdV9pZHgoKSByZXR1cm4gaW50IGluc3RlYWQgb2YgdW5zaWduZWQg
aW50IGlzIG1vcmUNCj4gPiBzdHJhaWdodGZvcndhcmQuDQo+IA0KPiBCdXQgSSBoYXZlIG9uZSBk
b3VidCwgdGhlcmUgd29udCBiZSBhbnkgZnVuY3Rpb25hbCBkaWZmZXJlbmNlIGluDQo+IHJldHVy
bmluZyANCj4gInVuc2lnbmVkIGludCIgdnMgImludCIgcmlnaHQ/DQoNCnllcywgdGhpcyBkb2Vz
bid0IGNhdXNlIGFueSBpc3N1ZS4NCg0KPiAsIHdlIHdpbGwgc3RpbGwgbmVlZCB0byBjaGVjayB0
aGUgc2FtZSBjb25kaXRpb24gDQo+IGZvciB0aGUgcmV0dXJuIHZhbHVlIGkuZS4gImlmIChyYXBs
X3BtdV9pZHggPj0gcmFwbF9wbXVzLQ0KPiA+bnJfcmFwbF9wbXUpIiANCj4gKGFzc3VtaW5nIHdl
IGFyZSBzdGlsbCBzdG9yaW5nIHRoZSByZXR1cm4gdmFsdWUgaW4gInVuc2lnbmVkIGludA0KPiBy
YXBsX3BtdV9pZHgiKSwgDQo+IEkgdGhpbmsgSSBkaWRudCBnZXQgeW91ciBwb2ludC4NCg0KV2l0
aCB0aGlzIHBhdGNoLCBiZWxvdyBjb21tZW50IGlzIHJlbW92ZWQNCiAvKg0KICAqIFRoZSB1bnNp
Z25lZCBjaGVjayBhbHNvIGNhdGNoZXMgdGhlICctMScgcmV0dXJuDQp2YWx1ZSBmb3Igbm9uDQog
ICogZXhpc3RlbnQgbWFwcGluZ3MgaW4gdGhlIHRvcG9sb2d5IG1hcC4NCiAgKi8NCkFuZCB3ZSBz
dGlsbCByZWx5IG9uIHRoZSB1bnNpZ25lZCBpbnQgLT4gaW50IGNvbnZlcnNpb24gZm9yIHRoZSBl
cnJvcg0KY2hlY2suDQoNClNvIElNTywgd2Ugc2hvdWxkIGVpdGhlciBhZGQgYmFjayBhIHNpbWls
YXIgY29tbWVudCwgb3IgY29udmVydA0KZ2V0X3JhcGxfcG11X2lkeCgpIHRvIHJldHVybiBpbnQg
YW5kIG1vZGlmeSB0aGUgZXJyb3IgY2hlY2suDQoNCnRoYW5rcywNCnJ1aQ0KDQoNCj4gVGhhbmtz
LA0KPiBEaGFuYW5qYXkNCj4gDQo+ID4gDQo+ID4gdGhhbmtzLA0KPiA+IHJ1aQ0KPiA+IA0KPiA+
ID4gVGhhbmtzLA0KPiA+ID4gRGhhbmFuamF5DQo+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+IC0t
DQo+ID4gPiA+IFRoYW5rcyBhbmQgUmVnYXJkcw0KPiA+ID4gPiBnYXV0aGFtLg0KPiA+ID4gPiAN
Cj4gPiA+ID4gDQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCByYXBsX3BtdSAqcG11
Ow0KPiA+ID4gPiA+IMKgDQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoC8qIG9ubHkgbG9vayBh
dCBSQVBMIGV2ZW50cyAqLw0KPiA+ID4gPiA+IEBAIC0zNzYsOCArMzY1LDEyIEBAIHN0YXRpYyBp
bnQgcmFwbF9wbXVfZXZlbnRfaW5pdChzdHJ1Y3QNCj4gPiA+ID4gPiBwZXJmX2V2ZW50ICpldmVu
dCkNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKGV2ZW50LT5hdHRyLnNhbXBsZV9wZXJp
b2QpIC8qIG5vIHNhbXBsaW5nICovDQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqByZXR1cm4gLUVJTlZBTDsNCj4gPiA+ID4gPiDCoA0KPiA+ID4gPiA+ICvCoMKgwqDC
oMKgwqDCoHJhcGxfcG11X2lkeCA9IGdldF9yYXBsX3BtdV9pZHgoZXZlbnQtPmNwdSk7DQo+ID4g
PiA+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKHJhcGxfcG11X2lkeCA+PSByYXBsX3BtdXMtPm5yX3Jh
cGxfcG11KQ0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4g
LUVJTlZBTDsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoC8qIG11c3Qg
YmUgZG9uZSBiZWZvcmUgdmFsaWRhdGVfZ3JvdXAgKi8NCj4gPiA+ID4gPiAtwqDCoMKgwqDCoMKg
wqBwbXUgPSBjcHVfdG9fcmFwbF9wbXUoZXZlbnQtPmNwdSk7DQo+ID4gPiA+ID4gK8KgwqDCoMKg
wqDCoMKgcG11ID0gcmFwbF9wbXVzLT5wbXVzW3JhcGxfcG11X2lkeF07DQo+ID4gPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoGlmICghcG11KQ0KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoGV2ZW50
LT5wbXVfcHJpdmF0ZSA9IHBtdTsNCj4gPiA+ID4gPiAtLSANCj4gPiA+ID4gPiAyLjM0LjENCj4g
PiA+ID4gPiANCj4gPiANCg0K
