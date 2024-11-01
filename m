Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276B414883C;
	Fri,  1 Nov 2024 07:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730445657; cv=fail; b=ALh49IAKDyCa9kc1f/o5MWq1glyQSAOTKzA1aXVCQHZ2Bk3Dvxij/Pcvo1BZdCEQm8MumHDIdr64Wn1czuH4evAmCjLDCPubjhz82xpo9XM95cU9c1cIS2PF9ogFvoOVEo14JsnDz8lPMmj+pErxPwwtg/JEMlQBoBFn49um0X0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730445657; c=relaxed/simple;
	bh=om/47B/pbzwkonKcxT0/lHhcECSWPgR20CHwGCnPGcM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DDrjY1CC1d8Q4sPFGbTe8rsjkDoZe3S5GWSzsAiR5rhY/UI5iR589dgbh0dUgwjmSfl3wsKP/ChSJCLUceA7Rmf++nHyg5+yjTwC3GB0W8UUSO5Hb8uRqSYJahRasVMdlHFOLbOi2PQvlwHZpUV+sOyGz1cek0M8Xvq31PuYzhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LiJrPQ14; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LiJrPQ14"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730445656; x=1761981656;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=om/47B/pbzwkonKcxT0/lHhcECSWPgR20CHwGCnPGcM=;
  b=LiJrPQ14mDO9EBJb7oeZ3O7SjGzeaAn/lqwkLr+G6FdLLIw3VGtie2A7
   AhNAtKwEJwXO+H1hyD3970GwixiNh3aSFDjunbhJJrdKYZMWQCIlpk+X7
   j+ox/7h9ztHhnmdEu1/BqBfWuFgvAVjsMVgVOucqBUZQkqH8IZVUMrJpz
   xGAEZkPKaTHvIYCCSSGX9J2um09O+/X9feRfk580/4ZKYr1KbRb4Fc++D
   FudgKKoc66b6D/J3uubvL1boeMvADTw19ZjUChcla9SS83XsyBnBno7Zn
   y5fgYG8ExEdHoeIWjIgGx/lYJbN2HNO5ZVvHNf0m8qUXnaj/Rn1RwZdRu
   Q==;
X-CSE-ConnectionGUID: B5NjtxtGT0a71KtjduHemg==
X-CSE-MsgGUID: gbwPOZYVTOOvJbqyTjBhFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52779060"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52779060"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 00:20:55 -0700
X-CSE-ConnectionGUID: 04vOtOfOTj++L2sbIN1TSw==
X-CSE-MsgGUID: fIhti8m1TMquBaukzcaKzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="88013567"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2024 00:20:55 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Nov 2024 00:20:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 1 Nov 2024 00:20:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 00:20:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5NEri0QqmtTTnh+X6RjPerLgwAKKLScYskCKf6sc8tk04vrWKMOls1vei8yMzP+uOxmxoevXBmZZ8bOi42NcesAztvn529c4mnUjeaL3w7u34u7obUoZjLUcH4TdBgR/AkYCRVj63SI2pXkQ9wApIGgRW+Nasl7jyeAzcBTJ84Uvo26WMv+W3GVg1VsaDwS528XL8e3ogzysebEC1VZCOhWFVq46KzFbvMbvs+Lfmd68eT/VHcmHmdPTgEP/HSC1U1WNRSJ1KvycwtAp3+4FtbuEwllljvQUvid+Ofq70uf+2Zxkcgd8XwXPBSS/vWdyzOLF41DwQL5731agCu8AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=om/47B/pbzwkonKcxT0/lHhcECSWPgR20CHwGCnPGcM=;
 b=Zo/77iVgsUftYk3PB60Bt29F8o5XOdhDELII6vOV7/Xn6yYn+5e10nxBH4LFNKFJpQC9hxsnSKZpbmgKcxN2UoQZo4GQ2nIX01D9ev64k6AWGle6Vnfr309aP2Dir0FJ/Sr7+/d3H4UckwnWCzZ5HjrNAarX7tGdKGa3nJatndHzeB6e2F1hTIP/+RoHO7U/RKQF5e1lkTef8N76+gF9I4BtEr6qavruR8XsLWiYNc9QsrAufMheamDqvaxXqjmSYubAmy50thCHuXYvOmBTcDZdwToVllxzzGp+DLSPVVt5zUDZYwwuPdvvxzEU+M9LocW583OPBHBHnK5cZCyS6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by CH3PR11MB8433.namprd11.prod.outlook.com (2603:10b6:610:168::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23; Fri, 1 Nov
 2024 07:20:44 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%5]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 07:20:44 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "Dhananjay.Ugwekar@amd.com" <Dhananjay.Ugwekar@amd.com>,
	"gautham.shenoy@amd.com" <gautham.shenoy@amd.com>
CC: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"ananth.narayan@amd.com" <ananth.narayan@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"ravi.bangoria@amd.com" <ravi.bangoria@amd.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"irogers@google.com" <irogers@google.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>,
	"acme@kernel.org" <acme@kernel.org>, "kprateek.nayak@amd.com"
	<kprateek.nayak@amd.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v6 01/10] perf/x86/rapl: Remove the unused
 get_rapl_pmu_cpumask() function
Thread-Topic: [PATCH v6 01/10] perf/x86/rapl: Remove the unused
 get_rapl_pmu_cpumask() function
Thread-Index: AQHbJs8dTDWG/35bW0ytQIG1JfFFR7Kbs0AAgAAHBICABlU8AA==
Date: Fri, 1 Nov 2024 07:20:44 +0000
Message-ID: <f770be5fdb6177367505e85069f2baff0246b9f8.camel@intel.com>
References: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
	 <20241025111348.3810-2-Dhananjay.Ugwekar@amd.com>
	 <Zx8ragiP5JBVuKvy@BLRRASHENOY1.amd.com>
	 <1b1aaccc-c31c-492d-bd21-b56d5fba69b2@amd.com>
In-Reply-To: <1b1aaccc-c31c-492d-bd21-b56d5fba69b2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|CH3PR11MB8433:EE_
x-ms-office365-filtering-correlation-id: 7024e5be-ff36-4540-814f-08dcfa45b312
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eU96eXZYQUZNcHBmZFZrOEQ0QXczT0pLOWlGS1dnZll0ZjM4MTBoc2ZWZ293?=
 =?utf-8?B?bkFqemt3aGp6L3FVTkZaWnNmNnZBdnNsVnJ3YWFSTEVkRXZOUzlJZU04NW9R?=
 =?utf-8?B?cGRLREV4SGIxSlpTL2RSdjZKQlV6V0dXU3MwWTJJcy9VNzNzZFhjQXB3NFpR?=
 =?utf-8?B?c2JnelJ2cFdZdmhPeWhBQjh4K0w3aGJGWnA4d0FlRUxUc2dzbk9DYmxKMFow?=
 =?utf-8?B?LzV6U2dzdnEzV0dtTFlFUWx0LzNwSDkyYW5qNnh1S0lyc3RZZ0lNZndLWVlQ?=
 =?utf-8?B?VWt5cEd2NkFqS2RiZTc2MnpMZDRlU3FHSE1xUXJ5bHpDQ0paRFVmT0NGYW1o?=
 =?utf-8?B?ejcxcFJ1ZXF0Z0dvN0FNdXMvb3UvdU5vU1NWLzhYUDRCMDg2OXZVeThqL1Q1?=
 =?utf-8?B?aU5HMHBzbWRqS1JuZHBhbkpESGRYNmNlSWxlU2NQSDNnTkNPelhRS2N5UWRr?=
 =?utf-8?B?WXJpMVA5VnF4YTc3NUFNeU1aaE9Ocm5rNlV0M0xsMWYxWFJkVmJwb2RPem1a?=
 =?utf-8?B?bnN6UXNwaHVYaUVFRVk1VWwxOG5aY2d0RUpkRThoSk9QbjBuRU1vNVk1d3VZ?=
 =?utf-8?B?R3JQUnBEcEM2anlvZTBjNmV5b1VJM3JoOEppbnRYN1JIN0F5aDJqaURSV0dZ?=
 =?utf-8?B?OFNSemt3eFUrdkZyS0dCNVphYXVONlFwd0ZmTnBkUzNPd2xNVzlkeksxVWox?=
 =?utf-8?B?Q3cwMWt1MGtjb2V6U1Iwa0phL29SMGRMZE1VVklLRXBSL29TNEZnSStYOHF4?=
 =?utf-8?B?THFLaVgyZFhuMFpDb1Fma0QvcTV1VjE0MkNWYUZwWS94YW9FVjUxVE9lZlNL?=
 =?utf-8?B?OCsxSno0bHcwMmtrUVNmOGJrbFhBQVd3d0dOcytGOGNkWlhZTVVaY21vL2VL?=
 =?utf-8?B?VThlSUN3YW9uWDUzZU5tQVpITTVybzBTeCtPbUU0dm90ZFpIbno3QmtMbGI1?=
 =?utf-8?B?NnBLLzZWNFl5aStpRFZxRzE3UUFqaDU0S2pNOXVUcklzYkxaQjUySUdrd1V4?=
 =?utf-8?B?Vy9kZ1JGblFONnF1V1RhemQ3T1JHc0UxUE8vZDBxOW14OFZTZU00ZEdadDZK?=
 =?utf-8?B?QjFDWU9kMnJNYitGVzZwUmpjSTc0MkZ0YnpFYVdGYS8yZDdienpoTmkrWXpB?=
 =?utf-8?B?dUI1V2ZGbEp0QzJQRDBNbFJmclZhSTRlM0FTZGdNVElMVHNiVXI1dDFHVGx2?=
 =?utf-8?B?UENPdjF5OER0MldROXRNZXdWUEZGeE5IZTFXUFZrTjBaaXkrd2VWS2tRQ09S?=
 =?utf-8?B?M3ZwQVBHQm5yTmdxdnJkYXp3QnBDVzQ0eXZwRGFWUGFEdGcvRkJWU2FTbmJF?=
 =?utf-8?B?ZkxUWFJzOG83UWJ1VDJDblA3Rmk2THZTaW5zeE5ocDNJM1RWcFBaMjlNaVA3?=
 =?utf-8?B?V1VSNE1BQTJnanRtdGxwUUszQlpyNkNuT2JJOEFCTVpwUUtqd0NwRHg4b0RU?=
 =?utf-8?B?akVxTFRxSnlVZzQ1QzFLZ0kxb2RzOS9mUWU0ZkJjWCtnWm9IVWRBaklBWGZW?=
 =?utf-8?B?c1BqR0FpeGM1NXJSd01Ta1A3dExmRnRmUDRMV0sybmxkdW0vRVNkdTNBaTM5?=
 =?utf-8?B?RVN2RWxhMlk3Z2ZadGJSdnNCdDVXMm52TjQ4KytSNmhJT2xZSlBod1JQTTQr?=
 =?utf-8?B?ejE1UEp1KzhocDNQa2VQaGRmNmZhcFZzREY1TTRCVndDTWxNYmU1ejBYVUNu?=
 =?utf-8?B?M3kxR2F4b042aTJrdFYrTVhMd3k5c1l1NjlvU1pOakUrVkRxQ25HMC9RNTh4?=
 =?utf-8?B?Wms4ME1oMkN1SzhKR1RrWnJ2RUltQkNVZ2NIellaaHYydU5pMmpYVzJqS01N?=
 =?utf-8?B?b3U4QVU3aExXNkR4NUVCQzR2bUFOR3BkemJlT0NQbkRXTHY3S0dMQXlzMTFW?=
 =?utf-8?Q?Yn9EqqNmAPEZQ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlpsMEdjanhYWEJKVjYrb1ZMQWRPV1RkVzIyVlNxSUp5VmZnUDZqVUhGNjdx?=
 =?utf-8?B?U0hXU0RJckl0Y1dIaGFBWTNuYTQ5TWZFNDd3QWdNYXVpMHBNS2xxZko1TWJy?=
 =?utf-8?B?UkZEN1RPbk9wbEtuQVl1dGtNcDA2QnIzQXFTUTdWdERRcG1mS0g1dSs5WmNE?=
 =?utf-8?B?TEl1djhlT3NCZVRrand4UE5rMlo1WnRGL0tFS2ZudXJtWkxJaE90TFNTQUM5?=
 =?utf-8?B?UXZmeXFWU1JoYm53TmN1eGhiTzQxYmMwLzZNT2hsdzltQjVEUEpkOVRoMkNj?=
 =?utf-8?B?WHNjSEhxUm0rQURlOURYZXd5b1VxSFRLVUFxRno2RUptQlltelg5clBMZGx3?=
 =?utf-8?B?V1poWWh4eXNQRGkyNk1CUE1UdXJaTlVyU3VDcWVGaDAxV3ZrNENLdlpaaVNB?=
 =?utf-8?B?UDNiRzBMdG1UNkFEdTEvUzB4ajB0bkh4QkhBUEZ6MzA2SHk4VGh4TXdHM2RU?=
 =?utf-8?B?c20xRXlmdWlYRVZIaHBYVnhHaldGODFyYm5LVENtVVh1T2dOOUJwemxBR29U?=
 =?utf-8?B?cGJmcS9qNGJwYVpXazhaSTdDN3J0dHpDNTdYTnFrT0l5WVUrbW5KaG9Vb2Ft?=
 =?utf-8?B?VlgyRy9wYlB0TkxaSWM2SXFWUHRjeG9YcTRRVWp3Z2QzcERyRXVDVUtoZlox?=
 =?utf-8?B?UGJPUkRCTTRiRnpwOUNDNllVTHkwUDRhMStrYWY2Q3ByZC9oTXkxVW5GcWov?=
 =?utf-8?B?K1RNeFBkZlQ4cThEOE81dTdtZVhqYmxsOUdpbW1ud2xQQzNYVnZNMDlTMXIr?=
 =?utf-8?B?NlpNamxVa0dRRndPL3dtUWFXbWFkZVZVMHhtUGlCbEpIeHp4QnBmRVg5a0JI?=
 =?utf-8?B?RU4yOWJaQUpNQTFTZ1cxV3NYdHhqVVYzZ0pUem42R2g3bVVheHJsaDRJSjls?=
 =?utf-8?B?c1pPTFQ1Y3M2NlM5MFF1Wkl6ZlFzRXhDYVFLd21yOTliTFZCNEVGMDBPK2NU?=
 =?utf-8?B?aEM5ckYwOFZhVTFXOGxXTVorRm4zdmhEaUtHSnN0VHlJZnR1aFZFYU95YjNV?=
 =?utf-8?B?OGk0VEVVTEZnUGVpOWRydnh3TlpuWGhhbDBueHpzNEtUTC9JS2U3enZwck12?=
 =?utf-8?B?YlFPaldOaUlFTStoZUQ1NkdrUy9ZSG9qUG5pY2hwK2tvK24wZ1p5K2ZhSUMr?=
 =?utf-8?B?QU1pZHBvSnY1VnJBNWJYSVFwejhuR1Ric3l3NmtjcnRIWWRNWVRCdXM5WkxH?=
 =?utf-8?B?eDZKREVCTWFiYXQvM2Z1Z2hlWDhSNndEbWs5NHd4MDNtdys3bm1nZHhvZkJv?=
 =?utf-8?B?YnVkZks3QWZyUzcvektaRkMxVnNZSE5pNzV4RUNibUdGTExJNDd1MUZOVWJK?=
 =?utf-8?B?cXNwZFFEMVRzOHYyU3RZM1FjZlBTcTVuQWMyQTVKSlF3TEVzc0o0ck1lSmtj?=
 =?utf-8?B?ZTNTaWhzV0QvTGY0ZXd4dXFNY0pHUmg1Z2V5enNrSzBCaUhQa0dHYVJQa09H?=
 =?utf-8?B?aGV5RU9CbWFXTDhMMldURW45NUJNSmp4a2dpNUdTa1lpT2tXK0lQZ2NoTSti?=
 =?utf-8?B?c1o2cHlucnZGZEFLaWZYMCt1Ym0vWnNJZWxKaHJmNkRrRWI2WVVZVC8zMTAy?=
 =?utf-8?B?bEQybzhkV0RTeHFDMGJ5dDBvbGFCS05XZGhpa21pVW43NkJzT2xFanlzdE96?=
 =?utf-8?B?Nkk4b0pLRTFmNU50NnExVHE4S2IyN2tqMlR0TUlpcEJVUnJyUzJjd29nQUJK?=
 =?utf-8?B?SHZHQ0t3YTRybTlxUWZoSC9ubDUzYjFKdXUwakNzYlFsWE5rMHJjUWZxbVVP?=
 =?utf-8?B?U0JTUklxclBlOHRBWlpLOEFaVDlsYUJxMy91SUpKZnBjK05ld0NkR0gwOVd0?=
 =?utf-8?B?aHl6VVFVd2RYN21iUFRwZUxQNytSTXkzVlZHeGtVYjU0T1dVaEdPdENYL1lv?=
 =?utf-8?B?OGNoanVqSVlvMm15d09nWFdjZVlaMTBGK09hUDNiVEhiQkV5UEVRdFV4SkNh?=
 =?utf-8?B?TzZoamROWU8zSE5iMXM3T3g2SDl6VWtXYUxnT3JnVDZnR210cTFVTmdxS0Yv?=
 =?utf-8?B?cWZSeVRZZkE0SDBWS1ZERDJUZkExY0hYbzk4UlBwczlsdHB3U0tXaWIvN2Y3?=
 =?utf-8?B?bXFjL2RuZTJLMXFsd01Ic0FDS0t4dDZ5eWJ1eGI1STZRaG84eVNtSnhLY2Ns?=
 =?utf-8?B?ZnVaQjIvOExsWDRoY040SVUyTTNjUk8vTkMxMVhOM3hnamFzZXBHNmMvcVdI?=
 =?utf-8?B?WEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <765268EBEBA60C43A4DA6966500D9A70@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7024e5be-ff36-4540-814f-08dcfa45b312
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 07:20:44.3655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OgcqYOeT685APi44kbYGbxP2rzIaqGYJpGb5H9j5gkxmJMZPPoiKg3I0TNtvSH27vBJJPG9kfgLIYVQE+ONXeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8433
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTEwLTI4IGF0IDEyOjA4ICswNTMwLCBEaGFuYW5qYXkgVWd3ZWthciB3cm90
ZToNCj4gPiBIZWxsbyBHYXV0aGFtLA0KPiA+IA0KPiA+IE9uIDEwLzI4LzIwMjQgMTE6NDIgQU0s
IEdhdXRoYW0gUi4gU2hlbm95IHdyb3RlOg0KPiA+ID4gPiBIZWxsbyBEaGFuYW5qYXksDQo+ID4g
PiA+IA0KPiA+ID4gPiBPbiBGcmksIE9jdCAyNSwgMjAyNCBhdCAxMToxMzozOUFNICswMDAwLCBE
aGFuYW5qYXkgVWd3ZWthcg0KPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+IEFuIGVhcmxpZXIg
Y29tbWl0IGVsaW1pbmF0ZXMgdGhlIG5lZWQgZm9yIHRoaXMgZnVuY3Rpb24sIHNvDQo+ID4gPiA+
ID4gPiA+ID4gPiByZW1vdmUgaXQuDQo+ID4gPiA+IA0KPiA+ID4gPiBJZiB0aGUgY29tbWl0IGlz
IG1lcmdlZCwgcGxlYXNlIHByb3ZpZGUgdGhlIGNvbW1pdCBpZC4gSWYgaXQgaXMNCj4gPiA+ID4g
bm90DQo+ID4gPiA+IG1lcmdlZCwgcGxlYXNlIHNoYXJlIHRoZSBzaG9ydGxvZyBoZXJlIHdpdGgg
dGhlIGxpbmsgdG8gdGhlDQo+ID4gPiA+IHBhdGNoID4gPiBvbg0KPiA+ID4gPiB0aGUgbWFpbGlu
ZyBsaXN0Lg0KPiA+IA0KPiA+IFN1cmUsIFRoZSBjb21taXQgSSdtIHJlZmVycmluZyB0byBoZXJl
IGlzIA0KPiA+ICJbUEFUQ0ggVjIgMi8yXSBwZXJmL3g4Ni9yYXBsOiBDbGVhbiB1cCBjcHVtYXNr
IGFuZCBob3RwbHVnIg0KPiA+ICgNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAy
NDEwMTAxNDI2MDQuNzcwMTkyLTIta2FuLmxpYW5nQGxpbnV4Lg0KPiA+IGludGVsLmNvbS8pDQo+
ID4gSXQgaXMgbm90IHlldCBtZXJnZWQsIGJ1dCBJJ3ZlIHRha2VuIGl0IGFzIGJhc2UgZm9yIHRo
aXMgcGF0Y2ggPg0KPiA+IHNlcmllcy4NCg0KSSBzZWUgdGhlIHBhdGNoIG1lcmdlZCBpbiB0aXAg
dHJlZSB5ZXN0ZXJkYXkuDQoNCj4gPiANCj4gPiBJdCByZW1vdmVzIHRoZSBjcHVtYXNrIGhhbmRs
aW5nIGZyb20gcmFwbC5jLiBIZW5jZSwgd2Ugbm8gbG9uZ2VyDQo+ID4gbmVlZCA+IHRoZSANCj4g
PiBnZXRfcmFwbF9wbXVfY3B1bWFzaygpIGZ1bmN0aW9uLg0KPiA+IA0KPiA+IEkgY2FuIHBvc3Qg
YSBuZXcgdmVyc2lvbiBvciBwcm92aWRlIG5ld2x5IGRyYWZ0ZWQgY29tbWl0IG1zZyBoZXJlLA0K
PiA+ID4gd2hpY2hldmVyIHdheSBpcyANCj4gPiBva2F5IHdpdGggdGhlIG1haW50YWluZXJzLg0K
PiA+IA0KPiA+IA0KDQpUZXN0ZWQgdGhpcyBwYXRjaCBzZXQgb24gdG9wIG9mIGxhdGVzdCB0aXAv
cGVyZi9jb3JlIG9uIGFuIEludGVsDQpSYXB0b3JsYWtlIGxhcHRvcCwgd2hpY2ggaGFzIHBrZy9j
b3Jlcy9ncHUvcHN5cyBjb3VudGVycywgYW5kIGRpZG4ndA0Kb2JzZXJ2ZSBhbnkgaXNzdWUuIFNv
DQoNClJldmlld2VkLWJ5OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+DQpUZXN0ZWQt
Ynk6IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4NCg0KdGhhbmtzLA0KcnVpDQoNCj4g
PiA+ID4gDQo+ID4gPiA+IC0tDQo+ID4gPiA+IFRoYW5rcyBhbmQgUmVnYXJkcw0KPiA+ID4gPiBn
YXV0aGFtLg0KPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1i
eTogRGhhbmFuamF5IFVnd2VrYXINCj4gPiA+ID4gPiA+IDxEaGFuYW5qYXkuVWd3ZWthckBhbWQu
Y29tPg0KPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiDCoGFyY2gveDg2L2V2ZW50cy9yYXBs
LmMgfCA4ICstLS0tLS0tDQo+ID4gPiA+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgNyBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gZGlmZiAtLWdp
dCBhL2FyY2gveDg2L2V2ZW50cy9yYXBsLmMNCj4gPiA+ID4gPiA+IGIvYXJjaC94ODYvZXZlbnRz
L3JhcGwuYw0KPiA+ID4gPiA+ID4gaW5kZXggYThkZWZjODEzYzM2Li5mNzBjNDljYTBlZjMgMTAw
NjQ0DQo+ID4gPiA+ID4gPiAtLS0gYS9hcmNoL3g4Ni9ldmVudHMvcmFwbC5jDQo+ID4gPiA+ID4g
PiArKysgYi9hcmNoL3g4Ni9ldmVudHMvcmFwbC5jDQo+ID4gPiA+ID4gPiBAQCAtMTUzLDcgKzE1
Myw3IEBAIHN0YXRpYyB1NjQgcmFwbF90aW1lcl9tczsNCj4gPiA+ID4gPiA+IMKgc3RhdGljIHN0
cnVjdCBwZXJmX21zciAqcmFwbF9tc3JzOw0KPiA+ID4gPiA+ID4gwqANCj4gPiA+ID4gPiA+IMKg
LyoNCj4gPiA+ID4gPiA+IC0gKiBIZWxwZXIgZnVuY3Rpb25zIHRvIGdldCB0aGUgY29ycmVjdCB0
b3BvbG9neSBtYWNyb3MNCj4gPiA+ID4gPiA+IGFjY29yZGluZyA+ID4gPiB0byB0aGUNCj4gPiA+
ID4gPiA+ICsgKiBIZWxwZXIgZnVuY3Rpb24gdG8gZ2V0IHRoZSBjb3JyZWN0IHRvcG9sb2d5IGlk
DQo+ID4gPiA+ID4gPiBhY2NvcmRpbmcgdG8gPiA+ID4gdGhlDQo+ID4gPiA+ID4gPiDCoCAqIFJB
UEwgUE1VIHNjb3BlLg0KPiA+ID4gPiA+ID4gwqAgKi8NCj4gPiA+ID4gPiA+IMKgc3RhdGljIGlu
bGluZSB1bnNpZ25lZCBpbnQgZ2V0X3JhcGxfcG11X2lkeChpbnQgY3B1KQ0KPiA+ID4gPiA+ID4g
QEAgLTE2MiwxMiArMTYyLDYgQEAgc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQgPiA+ID4NCj4g
PiA+ID4gPiA+IGdldF9yYXBsX3BtdV9pZHgoaW50IGNwdSkNCj4gPiA+ID4gPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgID4gPiA+DQo+ID4gPiA+ID4gPiB0b3BvbG9neV9sb2dpY2FsX2RpZV9p
ZChjcHUpOw0KPiA+ID4gPiA+ID4gwqB9DQo+ID4gPiA+ID4gPiDCoA0KPiA+ID4gPiA+ID4gLXN0
YXRpYyBpbmxpbmUgY29uc3Qgc3RydWN0IGNwdW1hc2sNCj4gPiA+ID4gPiA+ICpnZXRfcmFwbF9w
bXVfY3B1bWFzayhpbnQgPiA+ID4gY3B1KQ0KPiA+ID4gPiA+ID4gLXsNCj4gPiA+ID4gPiA+IC3C
oMKgwqDCoMKgwqDCoHJldHVybiByYXBsX3BtdV9pc19wa2dfc2NvcGUoKSA/ID4gPiA+DQo+ID4g
PiA+ID4gPiB0b3BvbG9neV9jb3JlX2NwdW1hc2soY3B1KSA6DQo+ID4gPiA+ID4gPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgID4gPiA+DQo+ID4gPiA+ID4gPiB0b3BvbG9neV9kaWVfY3B1bWFzayhj
cHUpOw0KPiA+ID4gPiA+ID4gLX0NCj4gPiA+ID4gPiA+IC0NCj4gPiA+ID4gPiA+IMKgc3RhdGlj
IGlubGluZSBzdHJ1Y3QgcmFwbF9wbXUgKmNwdV90b19yYXBsX3BtdSh1bnNpZ25lZA0KPiA+ID4g
PiA+ID4gaW50IGNwdSkNCj4gPiA+ID4gPiA+IMKgew0KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoHVuc2lnbmVkIGludCByYXBsX3BtdV9pZHggPSBnZXRfcmFwbF9wbXVfaWR4KGNwdSk7DQo+
ID4gPiA+ID4gPiAtLSANCj4gPiA+ID4gPiA+IDIuMzQuMQ0KPiA+ID4gPiA+ID4gDQoNCg==
