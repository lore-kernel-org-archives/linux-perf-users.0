Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1380419048F;
	Wed, 26 Jun 2024 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719425714; cv=fail; b=iale3JN/ure+9eV1tIzqINbz6eroKYFESY55MVc9zyV471cS8Xtq1wBBMD6uR6xK+/5FSoZWBvtPHienk2Z1YQ1bYeMi3TqgnErpuNlGoiHlv+IJP8pwuSeOlBMOiLnhm646qodu6noTlhwMCPwTnfgIroNoXA9yLTI8rIDSrZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719425714; c=relaxed/simple;
	bh=pSQlDeqoh1HKuRQocwEEITHJblpU89LZFz//sSiDD04=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SXo5iDfyHvNhfopJw43F27nnY1WeCNaXfAoTqJoL4YJCNYy6g196B8q+9c0p81qTKfkQvzg7f7KpgY3HP4YHIa4qMZxeepSLT2L8to4XD/99boomRJapyElEgFg0hFODcPDlXUWS6NT5apTkzmaj9VRZELcpoMjy+qcbCWbppSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ek6Qnfmh; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ek6Qnfmh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719425712; x=1750961712;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pSQlDeqoh1HKuRQocwEEITHJblpU89LZFz//sSiDD04=;
  b=Ek6QnfmhAjOav+6vidrt/w7Dc4gsnBlZY6iUkEPbnvAB6WpMQfyIEIfB
   uHFAf0WKT+E8wYdGPKrGVbAUmYCKUs0++hKBjH+1Xymd1KN4Bod3MYvTd
   XdeHGhiX9+5m7ZvRYns+w8hPvaW9yuCbf5K0CIZwEhockpxbUnyWAj4JB
   vfnK78f3MsjC5vAI5wy33RP/M1gIVWzbpzZSkuk9fZVR91al1YRSwEfqi
   fHQsBezBC9M3gW11FJSK6/1FeovpstKCK9Lc5TobVo/sm5FrIsy7tve/u
   3Sculrdu25HjhPAD5F8/pbcvUWPHTvlKMHS/Fjb3T9vNwRiZ5hY7VvBtm
   g==;
X-CSE-ConnectionGUID: HtXbSJ1rTGWq/fmwcP4wpg==
X-CSE-MsgGUID: /cFaaOK6RrSq8WBiW/1UaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="27205560"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="27205560"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 11:14:56 -0700
X-CSE-ConnectionGUID: zE+h0sTkQEqZc5xfYpFSxw==
X-CSE-MsgGUID: GKl+kuYGQKS9pt9y27H+MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="44196812"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 11:14:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 11:14:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 11:14:53 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 11:14:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQqSi6bpdUzdY+c64VPajWaZHeBjnvyJSlEDXokFlM98yIaAAB6tc4IO3XUxwtBbhsnjgfkAUve0pyTxcN3bI+MojYS+ir0eACl5KcTqXMCu5bsFKuV1vAd8r2GHUDpRqd+anVPJ9N8Tsj1uW+SNlSk5c5uitsHTeonGHvhr6cMigJmtA2m52BrByzhHQWgDNrYev0OpOZPg1/svq0QUrcAJzh8zUBuq+F/4LlhDwP7Pc4eTwvfyZH/ntaJSYJHy2+sZsV5IS0mLRfaAih4TK+UihwNShm3cwbh9bsygHpgjOy/d5OOOOvKhjPbX1sORTCSODdOl90DmvWVpF8U8ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSQlDeqoh1HKuRQocwEEITHJblpU89LZFz//sSiDD04=;
 b=fptn2oH+Cy8eHCnThfvIn8wakCte3l1AUpKNheQhg6g0QBjuRCtvKpCGHM7XQFA5RajTAdkWcSgeiYjcbFmXjRrlRNDq46sYdE8k9xGyLzGu+cwowbSEr/qfNxZZMlnsE1vEePBJN2cT+LBOrjeNPXensVHh7bklnSLXYfx18cYD5/DjRkXOvl9BuagTboj3KZTzuufWRYgs2f/abXZhy/ljcteVXRlSbFCZewYol/o3yVDD8ApcEiV/Byar6U7gbSCZ1Wj3CJlLe+/CSw5ODxtMTOPa3wNvBEMhSyLi+8r5OezrxYLFDCJjiEF6kBTnjfpV+sS1H0U2Ed4mWWTSPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by LV8PR11MB8745.namprd11.prod.outlook.com (2603:10b6:408:204::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 18:14:50 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%4]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 18:14:50 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>, Kan
 Liang <kan.liang@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb"
	<caleb.biggers@intel.com>
Subject: RE: [RFC PATCH v14 6/8] perf stat: Add command line option for
 enabling tpebs recording
Thread-Topic: [RFC PATCH v14 6/8] perf stat: Add command line option for
 enabling tpebs recording
Thread-Index: AQHaxoTPbjXK7FgFEECpQnAXOYgLw7HaVyQAgAAAYLA=
Date: Wed, 26 Jun 2024 18:14:50 +0000
Message-ID: <CO6PR11MB56354551393403CB2217C7DDEED62@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240624222026.229401-1-weilin.wang@intel.com>
 <20240624222026.229401-7-weilin.wang@intel.com> <ZnxWKtOWBbFqEnBq@google.com>
In-Reply-To: <ZnxWKtOWBbFqEnBq@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|LV8PR11MB8745:EE_
x-ms-office365-filtering-correlation-id: 45ffc64e-c590-45b7-ae91-08dc960bdeb2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|1800799022|366014|7416012|376012|38070700016;
x-microsoft-antispam-message-info: =?utf-8?B?YkdZQXNsdjNzVWFOWWc1M0krWDkwNXNTMElTVFhZbkZjU0gyWm1YVUZvWTRs?=
 =?utf-8?B?WndvMm95YWtlOGwwMWtzQUZkOFQ2aFQ0R3NmS1FMMndmajByemhPc0g5cGpW?=
 =?utf-8?B?UDZuMFV5cWRVdmpiTnpReHJJRFNPK2FwWG9GQ2FOY0VsV1hqRzRPQit4STl2?=
 =?utf-8?B?aFJZQm5nYXZBVzhjTlRLVG5iT2UvMndEUmdVVVpQZWI3SEgrWEhEY24rSSsr?=
 =?utf-8?B?RHZoTFlWdEQ0MHlhT1BISXp6U0FQc01qb2c0K242ZVlHTTVReThpbUwwNmxH?=
 =?utf-8?B?TUo1dno1STVKS2NDdUhIdGZWcTlGcGlLdER3aXdoNHl2Y05GZC9CUWFMRFNI?=
 =?utf-8?B?MW1peW5qbGc4bXFXRVlEZE9QYkY3L0ZIK1FoWEsxSmVFalFrN1JnaG02Z3k4?=
 =?utf-8?B?RlZZTTlFZnF4ZmpKbitTdnQ0Z3kxeHFZNEhuVmFWVjFiS1BjOWJ5enlyT1Nx?=
 =?utf-8?B?NGFTemx6eUxaMGFqejhVRitjdjI4Z1Q1eWs2dU5mZGFlRUJaRDhYYlhTdVow?=
 =?utf-8?B?blRRd1R3SW1TV29wQi85cTduMnB1ZStMVm93Mk9RbklxZ0xwMU9mT01icFNk?=
 =?utf-8?B?WU9kTHJ6Zkl5bFdhQlNLMzVGdE1NNjMzNm9UMFQ5OTVzWnJZbzNvMWRnM1pZ?=
 =?utf-8?B?VEtvWkcyQlhjK0ZwRjBpa3pQa2VkS0d0ZVhPZzh4Vm5yNytieGNrM2FVc3hS?=
 =?utf-8?B?V1JLcG14V2pYUkU5RzdYVmVwdy9yZFFXWW54all5NDNYeXh3Ri9wdE1TZVJU?=
 =?utf-8?B?UGRVNGlYL1BFME1GL2loaG1kMkIxV0E1S1hzT3kvaitjRzdCdERvSjBiMlE4?=
 =?utf-8?B?V1pFd2hIakR2Q0tFYnpsYlNWR1hwOElBcmh0WDVmZS91dnJ2dVVZSXhTL3p3?=
 =?utf-8?B?dGFNeW50M3ZUclZVNWZpc21NTnVUaktPTWdQek1melp5MkcvazFvMm12eVNV?=
 =?utf-8?B?Qzd1N1diMWkwM3Y2UklSSU5KaVp6NUkrYW5CcGVvQXF3OWFJMms1cmpGNU1p?=
 =?utf-8?B?RWVnWGpBc0hZcmNtalI5Qms4ZzJUU0hkclFEUmdOU2lOVmVYTm1saU5lOHM2?=
 =?utf-8?B?cmdwZ2xtMHNYdmc1RzR4QytpNGpCcmZPZTRYL2RvbXVMY0FzWFVoL1liNGxG?=
 =?utf-8?B?UFBKeDJsOTk4ZDlPUVY0dUg3QnYzZ0pCVGwybCtwREtLWHpQRkEzVXBOOWYr?=
 =?utf-8?B?MTdEWnc2QzVreGordkNLQTBJOTJZKy9jeExpVnpQUkMzYXpSdXBJZjNpYUNm?=
 =?utf-8?B?emtZMm1zVHR1TVJQWDhNeDM5Q0ttL1YvSlpiZmtjWFBobVdiaHZ1UWdmQjY4?=
 =?utf-8?B?ZUdrc2pha0dVcDN0eDVpc1ZOUG5SamdBSU5PazBMUXFuQW5OQ3U1R1dzOURX?=
 =?utf-8?B?N2REeVVWd09DWFgvVWt1ZVJzenFzSXp3bXI4TENwSXdYNG5GS1h6Q2JiL3BS?=
 =?utf-8?B?b3lYTHBNRDhCYWF3bXl5Ly9UN1FmbmtaNFNTUSs0cVk1UE5LblJJZzAvMExI?=
 =?utf-8?B?c0VhVzhVN2E2dmllb1p1VkxqeVA3eGV4QjRVYkNxTHpydjEvNFN6cjRhTDhM?=
 =?utf-8?B?aTQvQXFCdGRwLzRjUXdXZVZHOHBwbG1seTBrMXp4ODgvdGtqSGdOSTZxYXNM?=
 =?utf-8?B?ZkdTTysrSStPUkR6dTl3dU85K1lNUm4yVU1zbXZNQlBvdGhSZm5ScVRHcU8w?=
 =?utf-8?B?VDhIUis0RUI2RFd5eUlYMGlUcHAyTmg0K2h0T2tPMExWT01BZlZYODUyeXhN?=
 =?utf-8?B?R1I1MGJ5UWltcjgxK08xWk9Ddlo4dDhlL0ZTbG1MbXhMS01IY1RTbS9yUmhV?=
 =?utf-8?Q?zA4zg81HyQFs0CrV544+MKKrvAkgeBZ/y/6eo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(7416012)(376012)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFN3RVd1SDJXdnc0NUJta1FYaStUYSsrR1c3SWZXT3U0c3R5UDVIMmxsSEEw?=
 =?utf-8?B?RWw2Y2xnOUUrNktjRXhqaGE5Syt2TUJ2YkFjeEVLVUZiWVdZbDBWcFROQWU1?=
 =?utf-8?B?MnhJZVA2dnVmaFg5Y1VINHRGN3laYng3dzQ4eUQwTWZnek0vdkVheTlBWXNY?=
 =?utf-8?B?OW13N2g3OUI0dFlqQUdkZjExUFh0RkRIbFRZWmJTNUlzN1c4R3EyNndvaGFi?=
 =?utf-8?B?dWFaSjA3L1d5NVlzcEpJa1ljK0lEUG5LTmFaWEJCMHExdTB6QzYyVkhtcTZq?=
 =?utf-8?B?THQwV045VXBmd3Zlb3AxNFBtU29HZzYzdVFzVUI1MjBkSVFjVmVDMWlHc3ZP?=
 =?utf-8?B?MGNmT3d0SGVsRXM3enhKR1JhdG50eEZ0RHVEdUREZ1gzVzFoQ2s1dWNpeE41?=
 =?utf-8?B?NnA4L0JPaFZ2czYxWGJCYTVDS1psN0hRdXErM1RIcXhSR0cxbDZnNmVaMHQ2?=
 =?utf-8?B?VjdnU2xUMkFCZHpXb3M1YnNCN3RlM1M5cm91MGNBcUNKWlNwRHVzSGQ2Vzdq?=
 =?utf-8?B?REdsc2sxeXFuRXNXREVYOFlOd1Rvc3JOS1pZZ1ZRNjRuTWpZcGExbWVnTXJq?=
 =?utf-8?B?eWF2TzRYRllPRXdCMUZoZUFHQ05tNm1pMnZqd3ZlRGxQTnVEdHNQeFdDd3ZE?=
 =?utf-8?B?cUlKZnhPMmVLVllsMHMxcnRUMkVuNEVkejJvbG1iMVNyeUNpaHZUNjFIaG5Y?=
 =?utf-8?B?bDBCRHp5aG9MRGJaYmY4bWxDN1B1WCtRdERnQUFCcG9XMmlzd0Zkb2ZkVE52?=
 =?utf-8?B?aWptT2k2NzlUWE1DYk1QY3JYN2RCejFYNGdudmYrb2JCVnpvYnd5QXFYck14?=
 =?utf-8?B?czlLMmhYMGJaakJQek5hN3BpQmpWSlIrMHZhdFBzenNkQ2gxSjNRclhPR1pa?=
 =?utf-8?B?Snc0VmF3VjRhalN6Q3pCbnpNeXFvRyt6c3UxUTVsUTJrWVI4NUF4UElrdTVP?=
 =?utf-8?B?YnJDOW8wM21XR0oybjZjUlEvVldEbGdRRk1QdnBnMkhXdDc5NzRTaE1ZMHNP?=
 =?utf-8?B?YVJCeHEvVTQ2RVRsS3FnWEVLZkJXU01VL2dXTWdBZXJVcDczaks1OWZwYk11?=
 =?utf-8?B?VWtSTU5Hak82OC9sc2FzckNyRW1YSXduczRYWFhwazc1MnRpaDlobU1tdVhn?=
 =?utf-8?B?aHVJR25SbW1HQURndGJuemFveG5sVUQxSTNXNnFsVitwazNxakx6a0VwM3J2?=
 =?utf-8?B?ZHdwSm1ZNUNKVzVtaEg2ay9adDFzREV0TFRWOHhPSlJmYTJtWG5kSkVEM0cr?=
 =?utf-8?B?aVZQZWllNnJtZjJRWGkyUWZJdy9wNWpLR3ZEWEM2VndNYndKNDc0WldYcWpt?=
 =?utf-8?B?NWNCYzEzcDFScWUyd1FaeTdtZnZ2bTNnb1F3WWlZY3FYZnFVYXJkQWsrSm8r?=
 =?utf-8?B?elZtOWFMMEdvTGVNbURvY1A4Q3JqSGp4NVQwaVNhWjBDQmdiVDF1UjNIM2tT?=
 =?utf-8?B?YVNNQ3lxVTBzVFlRUmJSYS9INHViVUoyOEdxbHFNYk1aTlppOC9JZUJvTHhK?=
 =?utf-8?B?UXhkV0t6NVZ3OFRDNkxhZGlPK0h0elBrM3kyT2hBZC9QRVNmMU9HVy9qajRx?=
 =?utf-8?B?a3RvVlcrc014VDBHSlJHdHJ2ellDTHg0RDYyaVo5Z0R6czJGaTVHVjdoU2RZ?=
 =?utf-8?B?V2ErdllnaUhlUk9Xa0FyRVdTbEJPTldIdGVaZ0FxZ0ErL3hzSW5QM2l6emVo?=
 =?utf-8?B?MjVGK08wTnFQS1hRODUwWjhYVGdNWXZ3Wklad3RxalVrMXpqWTJRanhPc1J0?=
 =?utf-8?B?dGFEUloxTHU2S1kyK3dUVldLcjF2WldYV1ZzbjRNTURxVmUyMDMzZFlYQzVu?=
 =?utf-8?B?eThzOTBwMU4xeXlFOGRHWitWU1I1cGRmcllGemRRT0ZUOUd1K3oybkZ4eUMz?=
 =?utf-8?B?SU9vS1N2emhweG5FRzlVTGZRRE9Pb2syVWdjbUVWb3VYaHNiUU5oeWYzTmZX?=
 =?utf-8?B?QjdYbThNRWd6cWFDVWNYOU14WUorVFlEQ2tSVkFuZmxMMDhVc0NTMXdhbEF3?=
 =?utf-8?B?ZnV1RVFEOU1GenlvbURFZ0RyZWl1T3ljNElSbExGZEp4Q2lrbi9id3lWSDFD?=
 =?utf-8?B?RWhjSzVlTVlVWXc3QXJXTlp0WWRVZ2tEY3l3SlR5ZmJYdmw1SWw0RUdrck1Q?=
 =?utf-8?Q?0aMCf161Y0x4T8sQjWDjv8Cp0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5635.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ffc64e-c590-45b7-ae91-08dc960bdeb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 18:14:50.4800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BvE0AMrwslJ3zx3CDEGDxN7ZR1DQTBwiwrkOyWDFiLUsjzyYLldXt+70gGgEQgSn1FxPvTxN4Jn8iOTMdS1Ftw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8745
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFtaHl1bmcgS2ltIDxu
YW1oeXVuZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bmUgMjYsIDIwMjQgMTA6
NTYgQU0NCj4gVG86IFdhbmcsIFdlaWxpbiA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiBDYzog
SWFuIFJvZ2VycyA8aXJvZ2Vyc0Bnb29nbGUuY29tPjsgQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxv
DQo+IDxhY21lQGtlcm5lbC5vcmc+OyBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5v
cmc+OyBJbmdvIE1vbG5hcg0KPiA8bWluZ29AcmVkaGF0LmNvbT47IEFsZXhhbmRlciBTaGlzaGtp
bg0KPiA8YWxleGFuZGVyLnNoaXNoa2luQGxpbnV4LmludGVsLmNvbT47IEppcmkgT2xzYSA8am9s
c2FAa2VybmVsLm9yZz47IEh1bnRlciwNCj4gQWRyaWFuIDxhZHJpYW4uaHVudGVyQGludGVsLmNv
bT47IEthbiBMaWFuZyA8a2FuLmxpYW5nQGxpbnV4LmludGVsLmNvbT47DQo+IGxpbnV4LXBlcmYt
dXNlcnNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBUYXls
b3IsIFBlcnJ5DQo+IDxwZXJyeS50YXlsb3JAaW50ZWwuY29tPjsgQWx0LCBTYW1hbnRoYSA8c2Ft
YW50aGEuYWx0QGludGVsLmNvbT47IEJpZ2dlcnMsDQo+IENhbGViIDxjYWxlYi5iaWdnZXJzQGlu
dGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjE0IDYvOF0gcGVyZiBzdGF0OiBB
ZGQgY29tbWFuZCBsaW5lIG9wdGlvbiBmb3INCj4gZW5hYmxpbmcgdHBlYnMgcmVjb3JkaW5nDQo+
IA0KPiBIZWxsbyBXZWlsaW4sDQo+IA0KPiBPbiBNb24sIEp1biAyNCwgMjAyNCBhdCAwNjoyMDoy
MlBNIC0wNDAwLCB3ZWlsaW4ud2FuZ0BpbnRlbC5jb20gd3JvdGU6DQo+ID4gRnJvbTogV2VpbGlu
IFdhbmcgPHdlaWxpbi53YW5nQGludGVsLmNvbT4NCj4gPg0KPiA+IFdpdGggdGhpcyBjb21tYW5k
IGxpbmUgb3B0aW9uLCB0cGVicyByZWNvcmRpbmcgaXMgdHVybmVkIG9mZiBpbiBwZXJmIHN0YXQg
b24NCj4gPiBkZWZhdWx0LiBJdCB3aWxsIG9ubHkgYmUgdHVybmVkIG9uIHdoZW4gdGhpcyBvcHRp
b24gaXMgZ2l2ZW4gaW4gcGVyZiBzdGF0DQo+ID4gY29tbWFuZC4NCj4gPg0KPiA+IEV4YW1wZSB3
aXRoIC0tZW5hYmxlLXRwZWJzLXJlY29yZGluZzoNCj4gDQo+IEkgcHJlZmVyIHNob3J0ZXIgbmFt
ZXMsIGhvdyBhYm91dCAtLWVuYWJsZS10cGVicyBvciAtLXJlY29yZC10cGVicywgb3INCj4gbWF5
YmUganVzdCAtLXRwZWJzID8NCg0KSGkgTmFtaHl1bmcsDQoNClRoZSBuYW1lIC0tcmVjb3JkLXRw
ZWJzIHNvdW5kcyBnb29kLiBJIGNhbiB1cGRhdGUgdGhlIGNvZGUgdG8gdXNlIHRoaXMgb25lLiAN
Cg0KVGhhbmtzLA0KV2VpbGluDQo+IA0KPiBUaGFua3MsDQo+IE5hbWh5dW5nDQo+IA0KPiA+DQo+
ID4gcGVyZiBzdGF0IC1NIHRtYV9zcGxpdF9sb2FkcyAtQzEtNCAtLWVuYWJsZS10cGVicy1yZWNv
cmRpbmcgc2xlZXAgMQ0KPiA+DQo+ID4gWyBwZXJmIHJlY29yZDogV29rZW4gdXAgMiB0aW1lcyB0
byB3cml0ZSBkYXRhIF0NCj4gPiBbIHBlcmYgcmVjb3JkOiBDYXB0dXJlZCBhbmQgd3JvdGUgMC4w
NDQgTUIgLSBdDQo+ID4NCj4gPiAgUGVyZm9ybWFuY2UgY291bnRlciBzdGF0cyBmb3IgJ0NQVShz
KSAxLTQnOg0KPiA+DQo+ID4gICAgIDUzLDI1OSwxNTYsMDcxICAgICAgY3B1X2NvcmUvVE9QRE9X
Ti5TTE9UUy8gICAgICAgICAgIyAgICAgIDEuNiAlDQo+IHRtYV9zcGxpdF9sb2FkcyAgICAgICAg
ICAoNTAuMDAlKQ0KPiA+ICAgICAxNSw4NjcsNTY1LDI1MCAgICAgIGNwdV9jb3JlL3RvcGRvd24t
cmV0aXJpbmcvDQo+ICg1MC4wMCUpDQo+ID4gICAgIDE1LDY1NSw1ODAsNzMxICAgICAgY3B1X2Nv
cmUvdG9wZG93bi1tZW0tYm91bmQvDQo+ICg1MC4wMCUpDQo+ID4gICAgIDExLDczOCwwMjIsMjE4
ICAgICAgY3B1X2NvcmUvdG9wZG93bi1iYWQtc3BlYy8NCj4gKDUwLjAwJSkNCj4gPiAgICAgIDYs
MTUxLDI2NSw0MjQgICAgICBjcHVfY29yZS90b3Bkb3duLWZlLWJvdW5kLw0KPiAoNTAuMDAlKQ0K
PiA+ICAgICAyMCw0NDUsOTE3LDU4MSAgICAgIGNwdV9jb3JlL3RvcGRvd24tYmUtYm91bmQvDQo+
ICg1MC4wMCUpDQo+ID4gICAgICA2LDkyNSwwOTgsMDEzICAgICAgY3B1X2NvcmUvTDFEX1BFTkRf
TUlTUy5QRU5ESU5HLw0KPiAoNTAuMDAlKQ0KPiA+ICAgICAgMyw4MzgsNjUzLDQyMSAgICAgIGNw
dV9jb3JlL01FTU9SWV9BQ1RJVklUWS5TVEFMTFNfTDFEX01JU1MvDQo+ICg1MC4wMCUpDQo+ID4g
ICAgICA0LDc5NywwNTksNzgzICAgICAgY3B1X2NvcmUvRVhFX0FDVElWSVRZLkJPVU5EX09OX0xP
QURTLw0KPiAoNTAuMDAlKQ0KPiA+ICAgICAxMSw5MzEsOTE2LDcxNCAgICAgIGNwdV9jb3JlL0NQ
VV9DTEtfVU5IQUxURUQuVEhSRUFELw0KPiAoNTAuMDAlKQ0KPiA+ICAgICAgICAxMDIsNTc2LDE2
NCAgICAgIGNwdV9jb3JlL01FTV9MT0FEX0NPTVBMRVRFRC5MMV9NSVNTX0FOWS8NCj4gKDUwLjAw
JSkNCj4gPiAgICAgICAgIDY0LDA3MSw4NTQgICAgICBjcHVfY29yZS9NRU1fSU5TVF9SRVRJUkVE
LlNQTElUX0xPQURTLw0KPiAoNTAuMDAlKQ0KPiA+ICAgICAgICAgICAgICAgICAgMyAgICAgIGNw
dV9jb3JlL01FTV9JTlNUX1JFVElSRUQuU1BMSVRfTE9BRFMvUg0KPiA+DQo+ID4gICAgICAgIDEu
MDAzMDQ5Njc5IHNlY29uZHMgdGltZSBlbGFwc2VkDQo+ID4NCj4gPiBFeGFtcGUgd2l0aG91dCAt
LWVuYWJsZS10cGVicy1yZWNvcmRpbmc6DQo+ID4NCj4gPiBwZXJmIHN0YXQgLU0gdG1hX2NvbnRl
c3RlZF9hY2Nlc3NlcyAtQzEgc2xlZXAgMQ0KPiA+DQo+ID4gIFBlcmZvcm1hbmNlIGNvdW50ZXIg
c3RhdHMgZm9yICdDUFUocykgMSc6DQo+ID4NCj4gPiAgICAgICAgIDUwLDIwMyw4OTEgICAgICBj
cHVfY29yZS9UT1BET1dOLlNMT1RTLyAgICAgICAgICAjICAgICAgMC4wICUNCj4gdG1hX2NvbnRl
c3RlZF9hY2Nlc3NlcyAgICg2My42MCUpDQo+ID4gICAgICAgICAxMCwwNDAsNzc3ICAgICAgY3B1
X2NvcmUvdG9wZG93bi1yZXRpcmluZy8NCj4gKDYzLjYwJSkNCj4gPiAgICAgICAgICA2LDg5MCw3
MjkgICAgICBjcHVfY29yZS90b3Bkb3duLW1lbS1ib3VuZC8NCj4gKDYzLjYwJSkNCj4gPiAgICAg
ICAgICAyLDc1Niw0NjMgICAgICBjcHVfY29yZS90b3Bkb3duLWJhZC1zcGVjLw0KPiAoNjMuNjAl
KQ0KPiA+ICAgICAgICAgMTAsODI4LDI4OCAgICAgIGNwdV9jb3JlL3RvcGRvd24tZmUtYm91bmQv
DQo+ICg2My42MCUpDQo+ID4gICAgICAgICAyOCwzNTAsNDMyICAgICAgY3B1X2NvcmUvdG9wZG93
bi1iZS1ib3VuZC8NCj4gKDYzLjYwJSkNCj4gPiAgICAgICAgICAgICAgICAgOTggICAgICBjcHVf
Y29yZS9PQ1IuREVNQU5EX0RBVEFfUkQuTDNfSElULlNOT09QX0hJVE0vDQo+ICg2My43MCUpDQo+
ID4gICAgICAgICAgICA1NzcsNTIwICAgICAgY3B1X2NvcmUvTUVNT1JZX0FDVElWSVRZLlNUQUxM
U19MMl9NSVNTLw0KPiAoNTQuNjIlKQ0KPiA+ICAgICAgICAgICAgMzEzLDMzOSAgICAgIGNwdV9j
b3JlL01FTU9SWV9BQ1RJVklUWS5TVEFMTFNfTDNfTUlTUy8NCj4gKDU0LjYyJSkNCj4gPiAgICAg
ICAgICAgICAxNCwxNTUgICAgICBjcHVfY29yZS9NRU1fTE9BRF9SRVRJUkVELkwxX01JU1MvDQo+
ICg0NS41NCUpDQo+ID4gICAgICAgICAgICAgICAgICAwDQo+IGNwdV9jb3JlL09DUi5ERU1BTkRf
REFUQV9SRC5MM19ISVQuU05PT1BfSElUX1dJVEhfRldELw0KPiAoMzYuMzAlKQ0KPiA+ICAgICAg
ICAgIDgsNDY4LDA3NyAgICAgIGNwdV9jb3JlL0NQVV9DTEtfVU5IQUxURUQuVEhSRUFELw0KPiAo
NDUuMzglKQ0KPiA+ICAgICAgICAgICAgICAgIDE5OCAgICAgIGNwdV9jb3JlL01FTV9MT0FEX0wz
X0hJVF9SRVRJUkVELlhTTlBfTUlTUy8NCj4gKDQ1LjM4JSkNCj4gPiAgICAgICAgICAgICAgOCwz
MjQgICAgICBjcHVfY29yZS9NRU1fTE9BRF9SRVRJUkVELkZCX0hJVC8NCj4gKDQ1LjM4JSkNCj4g
PiAgICAgIDMsMzg4LDAzMSw1MjAgICAgICBUU0MNCj4gPiAgICAgICAgIDIzLDIyNiw3ODUgICAg
ICBjcHVfY29yZS9DUFVfQ0xLX1VOSEFMVEVELlJFRl9UU0MvDQo+ICg1NC40NiUpDQo+ID4gICAg
ICAgICAgICAgICAgIDgwICAgICAgY3B1X2NvcmUvTUVNX0xPQURfTDNfSElUX1JFVElSRUQuWFNO
UF9GV0QvDQo+ICg1NC40NiUpDQo+ID4gICAgICAgICAgICAgICAgICAwICAgICAgY3B1X2NvcmUv
TUVNX0xPQURfTDNfSElUX1JFVElSRUQuWFNOUF9GV0QvUg0KPiA+ICAgICAgICAgICAgICAgICAg
MCAgICAgIGNwdV9jb3JlL01FTV9MT0FEX0wzX0hJVF9SRVRJUkVELlhTTlBfTUlTUy9SDQo+ID4g
ICAgICAxLDAwNiw4MTYsNjY3IG5zICAgZHVyYXRpb25fdGltZQ0KPiA+DQo+ID4gICAgICAgIDEu
MDAyNTM3NzM3IHNlY29uZHMgdGltZSBlbGFwc2VkDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBX
ZWlsaW4gV2FuZyA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICB0b29scy9w
ZXJmL0RvY3VtZW50YXRpb24vcGVyZi1zdGF0LnR4dCB8IDggKysrKysrKysNCj4gPiAgdG9vbHMv
cGVyZi9idWlsdGluLXN0YXQuYyAgICAgICAgICAgICAgfCA0ICsrKysNCj4gPiAgMiBmaWxlcyBj
aGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVy
Zi9Eb2N1bWVudGF0aW9uL3BlcmYtc3RhdC50eHQNCj4gYi90b29scy9wZXJmL0RvY3VtZW50YXRp
b24vcGVyZi1zdGF0LnR4dA0KPiA+IGluZGV4IDI5NzU2YTg3YWI2Zi4uZjRjZGU4MzQ4MTFkIDEw
MDY0NA0KPiA+IC0tLSBhL3Rvb2xzL3BlcmYvRG9jdW1lbnRhdGlvbi9wZXJmLXN0YXQudHh0DQo+
ID4gKysrIGIvdG9vbHMvcGVyZi9Eb2N1bWVudGF0aW9uL3BlcmYtc3RhdC50eHQNCj4gPiBAQCAt
NDk4LDYgKzQ5OCwxNCBAQCBUbyBpbnRlcnByZXQgdGhlIHJlc3VsdHMgaXQgaXMgdXN1YWxseSBu
ZWVkZWQgdG8NCj4ga25vdyBvbiB3aGljaA0KPiA+ICBDUFVzIHRoZSB3b3JrbG9hZCBydW5zIG9u
LiBJZiBuZWVkZWQgdGhlIENQVXMgY2FuIGJlIGZvcmNlZCB1c2luZw0KPiA+ICB0YXNrc2V0Lg0K
PiA+DQo+ID4gKy0tZW5hYmxlLXRwZWJzLXJlY29yZGluZzo6DQo+ID4gK0VuYWJsZSBhdXRvbWF0
aWMgc2FtcGxpbmcgb24gSW50ZWwgVFBFQlMgcmV0aXJlX2xhdGVuY3kgZXZlbnRzIChldmVudA0K
PiB3aXRoIDpSDQo+ID4gK21vZGlmaWVyKS4gV2l0aG91dCB0aGlzIG9wdGlvbiwgcGVyZiB3b3Vs
ZCBub3QgY2FwdHVyZSBkeW5hbWljDQo+IHJldGlyZV9sYXRlbmN5DQo+ID4gK2F0IHJ1bnRpbWUu
IEN1cnJlbnRseSwgYSB6ZXJvIHZhbHVlIGlzIGFzc2lnbmVkIHRvIHRoZSByZXRpcmVfbGF0ZW5j
eSBldmVudA0KPiB3aGVuDQo+ID4gK3RoaXMgb3B0aW9uIGlzIG5vdCBzZXQuIFRoZSBUUEVCUyBo
YXJkd2FyZSBmZWF0dXJlIHN0YXJ0cyBmcm9tIEludGVsIEdyYW5pdGUNCj4gPiArUmFwaWRzIG1p
Y3JvYXJjaGl0ZWN0dXJlLiBUaGlzIG9wdGlvbiBvbmx5IGV4aXN0cyBpbiBYODZfNjQgYW5kIGlz
DQo+IG1lYW5pbmdmdWwgb24NCj4gPiArSW50ZWwgcGxhdGZvcm1zIHdpdGggVFBFQlMgZmVhdHVy
ZS4NCj4gPiArDQo+ID4gIC0tdGQtbGV2ZWw6Og0KPiA+ICBQcmludCB0aGUgdG9wLWRvd24gc3Rh
dGlzdGljcyB0aGF0IGVxdWFsIHRoZSBpbnB1dCBsZXZlbC4gSXQgYWxsb3dzDQo+ID4gIHVzZXJz
IHRvIHByaW50IHRoZSBpbnRlcmVzdGVkIHRvcC1kb3duIG1ldHJpY3MgbGV2ZWwgaW5zdGVhZCBv
ZiB0aGUNCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi9idWlsdGluLXN0YXQuYyBiL3Rvb2xz
L3BlcmYvYnVpbHRpbi1zdGF0LmMNCj4gPiBpbmRleCA2ODEyNWJkNzViMzcuLjcxMTFjOTZlNjhh
YiAxMDA2NDQNCj4gPiAtLS0gYS90b29scy9wZXJmL2J1aWx0aW4tc3RhdC5jDQo+ID4gKysrIGIv
dG9vbHMvcGVyZi9idWlsdGluLXN0YXQuYw0KPiA+IEBAIC0yNDc1LDYgKzI0NzUsMTAgQEAgaW50
IGNtZF9zdGF0KGludCBhcmdjLCBjb25zdCBjaGFyICoqYXJndikNCj4gPiAgCQkJImRpc2FibGUg
YWRkaW5nIGV2ZW50cyBmb3IgdGhlIG1ldHJpYyB0aHJlc2hvbGQNCj4gY2FsY3VsYXRpb24iKSwN
Cj4gPiAgCQlPUFRfQk9PTEVBTigwLCAidG9wZG93biIsICZ0b3Bkb3duX3J1biwNCj4gPiAgCQkJ
Im1lYXN1cmUgdG9wLWRvd24gc3RhdGlzdGljcyIpLA0KPiA+ICsjaWZkZWYgSEFWRV9BUkNIX1g4
Nl82NF9TVVBQT1JUDQo+ID4gKwkJT1BUX0JPT0xFQU4oMCwgImVuYWJsZS10cGVicy1yZWNvcmRp
bmciLA0KPiAmdHBlYnNfcmVjb3JkaW5nLA0KPiA+ICsJCQkiZW5hYmxlIHJlY29yZGluZyBmb3Ig
dHBlYnMgd2hlbiByZXRpcmVfbGF0ZW5jeQ0KPiByZXF1aXJlZCIpLA0KPiA+ICsjZW5kaWYNCj4g
PiAgCQlPUFRfVUlOVEVHRVIoMCwgInRkLWxldmVsIiwgJnN0YXRfY29uZmlnLnRvcGRvd25fbGV2
ZWwsDQo+ID4gIAkJCSJTZXQgdGhlIG1ldHJpY3MgbGV2ZWwgZm9yIHRoZSB0b3AtZG93biBzdGF0
aXN0aWNzICgwOg0KPiBtYXggbGV2ZWwpIiksDQo+ID4gIAkJT1BUX0JPT0xFQU4oMCwgInNtaS1j
b3N0IiwgJnNtaV9jb3N0LA0KPiA+IC0tDQo+ID4gMi40My4wDQo+ID4NCg==
