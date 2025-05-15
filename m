Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912434B1E59;
	Thu, 15 May 2025 20:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747341991; cv=fail; b=IMUSkoV/ZO5Potx3fIWd7Piq4ukeVnqb9QMS1xPNNW0LwEmkG2PBqdFc/9efBvIBslCY8xOYEe81eBAMEu2qAwq9PDVUPUcg8/+InYECKY6Rx04EYVkbe2tXYNR8Qpo25BtZ8yHIwDLu6hYJZNIU9vp9h6YhX1hpUodxP0gcdII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747341991; c=relaxed/simple;
	bh=9ZzM7xiF12AxghkNgFjwQcUUQsVBM2kmzlxfE1MZPp8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nTfsuYltQA3GdIxuZVoeTkfAW2hFaqVsnH+ihXhoD/dsrQO6CWriV2Ef/oSMcyKaBhmottYKJpRebw8x5QtbaNNuRA8vDPPvBGd5h6P8Xb5OkBwdjIfB+eVRXpbLAejKvSs/aD22BnpZgx8hV/6E2tW4BWt61H25R6l2fYI7LH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S+Lg7ab9; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S+Lg7ab9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747341989; x=1778877989;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=9ZzM7xiF12AxghkNgFjwQcUUQsVBM2kmzlxfE1MZPp8=;
  b=S+Lg7ab9oWnVxXevK32J5bYwgsaiaSSgt65BLHnXNZxznvvjwQ9UWcrf
   8roZVcWNB96+vn///2m3MmC3WvjDPAhYkXPO+eU2DcP6crOc6IXLY+7Pb
   f4+kFjTAddK9vWomC82WMCu5pFVr3E0h6Sv6ja8617Nur4KS/2hYnIZki
   SHJ4pAWsgHm9dk2VnTpRqlqhpIt4wa1NqZaSdQp7q2zJTr0Ei95l13HhF
   3V3JdOmxxkcJYrPr9RoIOS1wRGDoRcNt8w4H2cdtYVxtAzb8hm1Nek1he
   vHdIGkosy2FBOirZn8kbK6mq6X39Y+6Enqje3PMzx/FASR5yYpCylhhXY
   Q==;
X-CSE-ConnectionGUID: BPtCqjk5S1maesv/OS6j+A==
X-CSE-MsgGUID: 5kIFRjkFQUiyLzVYwEXZBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="60639575"
X-IronPort-AV: E=Sophos;i="6.15,292,1739865600"; 
   d="scan'208";a="60639575"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 13:46:28 -0700
X-CSE-ConnectionGUID: 8t8dTOBaSIW2ACIlSZm/ZQ==
X-CSE-MsgGUID: KJPzGFW8T/KPfGjB/EsUWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,292,1739865600"; 
   d="scan'208";a="143601361"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 13:46:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 13:46:28 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 13:46:28 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 13:46:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5/4ZeHwBXFYpZnaddfxAOh6nQJQj/YNs+u87qElnWDzFxwFhT9qbUcMVfTqGPCMNLgry+J0GRCpOe5iTMDOOcFcPCpczlQtS6RjmIcMTjwvTitXdOKGmkxPeU6L6lEQiZTgQDZcnGOkX1RBZESuO2W/duW4Wv8JLqH/xJP4LrSCxm+FOAKO+sHQ8bimQL+3RzSS0B8R5STDwOCjM6nzKVx5TAIZxsWMjvF6mb3qwE7Yd8+ArsRheJHb8TmMMufQl0VHEe4DnDIP9zDxsVclZmJFvowwCkwW85ms2Yq6+/4Vbdm6GhvzScdVsx99o4fPoK2/eRYMyCRcKFpOePZEOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZzM7xiF12AxghkNgFjwQcUUQsVBM2kmzlxfE1MZPp8=;
 b=Z67B42Yg7FavJ9DXc8/haeHwu5sRuK7HAejkzzXKGXxvXusKBEN5AP03lFVMVCBxqWzRk/yeVweun8+r+/MsRZjUOC7epD0uH4ek5iekdXpEs7sTNwx0dILyWHzQc2xfXVeJ/2TqIvsUC+61p44H7xvRvF8tb+nZOpbkjCYl8p0cKo2i8ugdVOWc43RWaOHcDbs0+h8vn5D3SqTOCXY4vk6qj23B76f0rgsj9AtPUDd56iWHE2gtM8iv+Hcn5bBnulSNR8QREwTS4LwOgra0K+5iFogWReP9R7+wq+vA7e5OLwnsFXoXA42toqla1CM0maT9kGOc27wEX6Ob6WzAbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by BL1PR11MB5239.namprd11.prod.outlook.com (2603:10b6:208:31a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 20:46:22 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%4]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 20:46:22 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>, Kan Liang
	<kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] perf intel-tpebs: Filter non-workload samples
Thread-Topic: [PATCH v1] perf intel-tpebs: Filter non-workload samples
Thread-Index: AQHbugqrTBVQVwU1dkugIqYerWeITbPUQFMA
Date: Thu, 15 May 2025 20:46:22 +0000
Message-ID: <CO6PR11MB5635C6FF9A6C91B68FCE7937EE90A@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20250430200108.243234-1-irogers@google.com>
In-Reply-To: <20250430200108.243234-1-irogers@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|BL1PR11MB5239:EE_
x-ms-office365-filtering-correlation-id: ee8a54b1-30ce-4002-5856-08dd93f18d79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?am03UEk4UG9JVG1PYzBGaUJhMWpMSjJRWWhTV1VTK0RUd0loS3lYK1JSSlZs?=
 =?utf-8?B?STh6VXNkcFlublpKZmZrVTE0a1ZWV2IwUTNmbDBoVGU1TFdrVTFPV1FiMDM2?=
 =?utf-8?B?NEx2bzVEUElmL0lnaW82MlJjQ0txVmNtdUJ1UFhweDZneGpZSE9MWUN3ajBq?=
 =?utf-8?B?cSt0WXJvcWRUb05rZ3FjdEVOa0o4TlZDSUZjSVRYR1hyMHpzUS9ncXE5Q0pn?=
 =?utf-8?B?S0Z4VitsY0p0NzhDWHNxRmtQbWREM3NOVUoxdzNSdFJPYlVITXlJU0dKSDFw?=
 =?utf-8?B?QmplKzVhd2VxZ0dSRU9HTEx2a1Rla3BsRm5WK1YyS25lMEl3OWExcUlhZWlG?=
 =?utf-8?B?U1ZJLzJHZHNncTFNQ1lTZW44Sy9iMEl5OWVUemtydGEyUERGVS9zK1hGU2FR?=
 =?utf-8?B?ejhRSTdRVU5OS09uc2xBcGJmbi9QWSsyNjN0WXEyRU5SMmRTTWdwclVjMGxY?=
 =?utf-8?B?bWRCcEJ1R3FMRk1UT0VkTi82WXhuYVpHdTlaZzBNdUppdXBuOFlZckR0bmFH?=
 =?utf-8?B?THo0K09xMzJEWkNsWlltTzdRK2pDb3lSelI1SWdTZ2dHM3pxY2pxaFhTVnRD?=
 =?utf-8?B?VmVYMGtjYTZqanc3RzVqbWp0b2UxK2M1REpYby9LbEgxMWQ4T2RYNHJwaUhq?=
 =?utf-8?B?UzRZV1VjaFRiYmh5aWRWQVFqSzdCc2hGRkkwdDFDeWFvTDdwWkR3dE95Zy9X?=
 =?utf-8?B?K3VWbzJSYXNaYlRUUE16WFk3cnNZV2tKcVcrNmlzTVdFWmgyK0RWT3p6OVhK?=
 =?utf-8?B?eVh1OHVlUzhwZ2lkZXRLU0hNckMxcVVNZjVZOXl2M3E1NG4zS0FKREdsaHhh?=
 =?utf-8?B?WW14bHorRVZRMG5WMFFsVGp6VzVZc20vb3RQamxSbjczck5MVjhRN2F2SjdN?=
 =?utf-8?B?MWt4T2ZITEdmNUV2ZFlvZ3FIYXU5TzhBTmppR2FZMFJLdnI4elo2TmF1ZjFP?=
 =?utf-8?B?QWs5YWdmL1pUSkQzK3Nyb1NsbkhoZHdXOHk0aUVqWExCemdGZGFWQkNSd1pY?=
 =?utf-8?B?Vi9YWGVEdWpMdThHRTUxdXFEcTV6QWxEQSs3RHlvL0tDUkJwUmdnRjZUODlG?=
 =?utf-8?B?Y2lUZkV3Qm1DYzE0T1ZxY1ZIYnpnaTdRNzFFZ3pvUHp5TTBhOU1kVk1KbGtH?=
 =?utf-8?B?T2NRckNZRjlGcXJxRGRyaExFWjdkSWN1TmhXR0dadjJGQkVMVkFVbHRhKzVJ?=
 =?utf-8?B?a0lxYWtYa0F0ZkhIdjJnRVFPVXlWZHpBSzJYTG0xRFFKVkNOQUhGaCtqa1ND?=
 =?utf-8?B?SUZVWFJ5dmxOTW5icWlqcUsvVURjN3JrRXFYYlA2SWdqdTVCa2htc3NUZ05h?=
 =?utf-8?B?NTUzM01tU3gzbW9HbFlmZjdkNkdVS3NNVFdOUjhoeHFyQ0x4aTJrd0M0M1R6?=
 =?utf-8?B?SFVNNFBIdk9NZGdTQU1PNVhNVG5WZkptRmFoOEpxUVIrZjQ2YXBCOVF4eHJD?=
 =?utf-8?B?VExPWWRMUyt5NzdLM2owUzkzQW1kTkczODFjRExKM2lLVXpzQWJZN2RLNlk4?=
 =?utf-8?B?L0tTSXlWT2ZPMDRqYmxPRm9YWkcvRDZoUmZldFdpSzNKbzRkMFdZbWV4b3V1?=
 =?utf-8?B?VWRhSmt3UXVVeHhYTlluVjBsbm4rZWV2akk1M3p0MFowQVF0WStsNUZ5WnBD?=
 =?utf-8?B?cEJmenBsNFhrUmUvRk84dERMQlFxZ2RETExNWTB4RnU5ZnBJb2JZQnhrS0Va?=
 =?utf-8?B?Q21ibDU2Tmt5dWt4YmhNVDRBaWw4clRMY2crSmprY0lmeitWME5LUlBLaHdx?=
 =?utf-8?B?R3NiaHVBS2ZzcitqcnUwNnprSHdLb0prWSt3cWdNQjg3MFU3QzBEaVA3RzdU?=
 =?utf-8?B?cWRmOExtbXpDQWJEUnFpaXFJTHRheUNOZmtNQ0gyRUxGdy9QcTBUYjd5cVRj?=
 =?utf-8?B?a1BvS0s2WkxBTFgrTzFERHl4Y0ZLSmZqcFE5UGNHeUpobUljU0FaeDd3NTRX?=
 =?utf-8?B?TmtIbzBNQ21Td1hZUW0rRGh0U3JYYkVIazFOQVNRR0NYRVRaNGo5QnJWYlhX?=
 =?utf-8?Q?7GuGKwolFwpfBf67awICMSuA3wggpo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emVSOWhoQ3dJWVBYK1hvckFraVY3S1ZqUXJyekN6MmVZWituU2VwWWIzQ0ZU?=
 =?utf-8?B?Qk1DVXhuU01mOFh5WVVvdDEzSTArM1VPRmxkWGQrQUxpcjV0cFZsd0ZMSDUw?=
 =?utf-8?B?YVA0K3VDR1ozemhYaTJsN2NBdUFyWW1ySDFLS0JvT3l5Y09sb2N1cnRIS3Er?=
 =?utf-8?B?MzNqcjN0MURFMERUeDhsOTFWTC9NRDN4NDc3TFlwV0dvSnRubmVFVVNjYkdZ?=
 =?utf-8?B?Vm14ZWlsODJlYkVQVWQzTkQyQXZHaFJjbXFPLzNJenE4ekdXUXhNdjVhSzF3?=
 =?utf-8?B?TDdrZWN2UmNsd3FSNnJEOE9rU3EveHBRM3VpeEdjUStaNzBYUWlTcnYrY0RT?=
 =?utf-8?B?NTQ5KzNvdUFPUlVlVEtqNXI5WkJ5NW1oTHcwMTI4MW41Nk9KSzFiRzFRNDA4?=
 =?utf-8?B?UUJnN1ljdEFQSUhvamZBTVVHQ29BRmk1bnprOWZRbUI3UDhzSjYxeDMwZCtB?=
 =?utf-8?B?b2xsc09rUEdzdDBuaEhyTi9HOFZFQksvQldSMU0vUmtQM0tDbXJ0SVBMMHNG?=
 =?utf-8?B?a1hYdTZkQkZBN1JnOXFvaEcvanpaVko0eDROTXRIQ253MzgxRXh0UnJnVGlX?=
 =?utf-8?B?YWZsbVlRMWJ1ZHB1MmxTL2xsS2ZBd200UU9RVTRmZVV2bnBvYXVHQzc4dVpX?=
 =?utf-8?B?YUJMVmZvWEZOUytQOU1zTFRNejhjRXJYWFZmSk1tNXhzUzFYWnpLSUZQR21Z?=
 =?utf-8?B?NDhLQmZseFFCMjNHTmo1S2VoWjRDV3QyS3pmQzh0L1Jza1dzcTBXaXVhTlpQ?=
 =?utf-8?B?OTVyQzR0SjNwYzBlV0lCeWRWNERDYXlWUWc5L0hjZU1iUEFyOTFaODRET3g5?=
 =?utf-8?B?aHlSNUpySHJMUEhFb3VSOEN1R0NrMjBleUxsWVNvcU5SNkE0TVJ5R2Yxajc3?=
 =?utf-8?B?YnNuUHlTUE84QnFSUE9pRFJkaktYVFBFQ3c0Q2g2dGplK285MEpSQVJud3VK?=
 =?utf-8?B?Z2VOMno3U255SUtRRFVoR2h5ZTdYajBFcjhDYUVPRzVTYkZiYnl4TUdHa2RQ?=
 =?utf-8?B?eHNOdXVLZEFxU2UvczZkd0dXTW43WTlSdnd1bkpiRzdVQjk0QlZ5SFlnV3Qz?=
 =?utf-8?B?TXhJSThYTHRSU25hMnZkNGZ5RGxBbVRQZ2hiZVJyK0EvZUFxMW13MFhnOFEx?=
 =?utf-8?B?MngzdGtuVmFRUHNKemI1dGVsdUIwK0RodmtJQ3ozNWRZWUhsaE1XMjlVQWov?=
 =?utf-8?B?MTBPYlhST3BIM3h0Skh1TWoxVk9iLzNQaUVNOVRyZ0hYUTFMdHZHUjV0bDVZ?=
 =?utf-8?B?Vk9rSHpBcFFXV2FrdkJvODJUNEMzRHpQdWFkZjcxRm11Qm9xT3VzRHUyVUFj?=
 =?utf-8?B?N0NjUEpiVDVqSzYzUmpORlVWVmVlTG5tNjI0QkRLUEdReEZJYTFqcDNrMHJF?=
 =?utf-8?B?TmNmNnhxOG5ReE1GS1g1dGxLRFB0S0REUGc0bWg3QmpMRTE1SnF0NlNlN0Nz?=
 =?utf-8?B?Q25hZ09ISDlzK1FIcklQRitxcm45dFJSSmdBazhGV0lMRWFjaGF4TFJEZkdh?=
 =?utf-8?B?WDFaM3J6bjdOVnFPQXhOdjhGRjk4Rzdkdit2MWpWbCs1ZDVVcUQ4eE1qOUVG?=
 =?utf-8?B?TFNMRm1EVkVyUzZWVnVOQ1Y1UlhJVW1IbWk5VFpheFI4MHk1Q1NVSzdVUFk0?=
 =?utf-8?B?cDFCR1ZSdmN1S1R0S1Q0R2laNEpkV1Fhb1l2U053bTZxbEFFMWdOT1ZPQXB3?=
 =?utf-8?B?SklvandvNFUwdzB4WUQwc0wzVy92ZTJVSlJFL3MxSTlZaDVyWFJMbWJYRzh4?=
 =?utf-8?B?SjBGOGtZVmlvVzlGb0ZqZjZ5bXhERkRFVVh1VkhDL0dZOVlrbW9Ld2VFZ0h6?=
 =?utf-8?B?Tm1OMGR6bi9ZaHRIRjRNZldXa01mSU1kSW83WFpBcUFWV3Jpa3daMzJkNzls?=
 =?utf-8?B?c1ErVTZXbUs2YWFQcUJOTGYwZTA1enNuMmxMcjh0bGp2dU5OV3c0YVdSelgy?=
 =?utf-8?B?VkFTaXE2SFdrcGs5U05Ra2U4cWNlYlBPTEhxaE55VjYzTFN6SjhDeFlNYzNh?=
 =?utf-8?B?RytraDl5b212a25xOFNRTHg5L2F3dEg4akdlS3pCcGowbzdza1M5QmNmT244?=
 =?utf-8?B?YkNMa0NpclE0T2dsb25LWkVUdldJRFBhQmZQYlFvREdzL0NyeVl0ME1oYjNM?=
 =?utf-8?Q?rKJsiQBGLdIQpAo6A501wBlBP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8a54b1-30ce-4002-5856-08dd93f18d79
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 20:46:22.5981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7okRGWYDmKMhIl/6qKLSSjhkT73tb8ibPhlzzYNDRDqvFRfk53pPSXemoqXrdB3A01fHeZq/A0KyMbrJcNUaHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5239
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSWFuIFJvZ2VycyA8aXJv
Z2Vyc0Bnb29nbGUuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDMwLCAyMDI1IDE6MDEg
UE0NCj4gVG86IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IEluZ28gTW9s
bmFyIDxtaW5nb0ByZWRoYXQuY29tPjsNCj4gQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxvIDxhY21l
QGtlcm5lbC5vcmc+OyBOYW1oeXVuZyBLaW0NCj4gPG5hbWh5dW5nQGtlcm5lbC5vcmc+OyBNYXJr
IFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPjsNCj4gQWxleGFuZGVyIFNoaXNoa2luIDxh
bGV4YW5kZXIuc2hpc2hraW5AbGludXguaW50ZWwuY29tPjsgSmlyaSBPbHNhDQo+IDxqb2xzYUBr
ZXJuZWwub3JnPjsgSWFuIFJvZ2VycyA8aXJvZ2Vyc0Bnb29nbGUuY29tPjsgSHVudGVyLCBBZHJp
YW4NCj4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgS2FuIExpYW5nIDxrYW4ubGlhbmdAbGlu
dXguaW50ZWwuY29tPjsgV2FuZywNCj4gV2VpbGluIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+OyBK
YW1lcyBDbGFyayA8amFtZXMuY2xhcmtAbGluYXJvLm9yZz47IGxpbnV4LQ0KPiBwZXJmLXVzZXJz
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0
OiBbUEFUQ0ggdjFdIHBlcmYgaW50ZWwtdHBlYnM6IEZpbHRlciBub24td29ya2xvYWQgc2FtcGxl
cw0KPiANCj4gSWYgcGVyZiBpcyBydW5uaW5nIHdpdGggYSBiZW5jaG1hcmsgdGhlbiB3ZSB3YW50
IHRoZSByZXRpcmVtZW50DQo+IGxhdGVuY3kgc2FtcGxlcyBhc3NvY2lhdGVkIHdpdGggdGhlIGJl
bmNobWFyayByYXRoZXIgdGhhbiBmcm9tIHRoZQ0KPiBzeXN0ZW0gYXMgYSB3aG9sZS4gVXNlIHRo
ZSB3b3JrbG9hZCdzIFBJRCB0byBmaWx0ZXIgb3V0IHNhbXBsZXMgdGhhdA0KPiBhcmVuJ3QgZnJv
bSB0aGUgd29ya2xvYWQgb3IgaXRzIGNoaWxkcmVuLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSWFu
IFJvZ2VycyA8aXJvZ2Vyc0Bnb29nbGUuY29tPg0KVGVzdGVkLWJ5OiBXZWlsaW4gV2FuZyA8d2Vp
bGluLndhbmdAaW50ZWwuY29tPg0KDQo+IC0tLQ0KPiAgdG9vbHMvcGVyZi91dGlsL2ludGVsLXRw
ZWJzLmMgfCA1OQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDU4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS90b29scy9wZXJmL3V0aWwvaW50ZWwtdHBlYnMuYyBiL3Rvb2xzL3BlcmYvdXRpbC9p
bnRlbC10cGVicy5jDQo+IGluZGV4IDdmZDZjYWUxMDYzZS4uNGFkNGJjMTE4ZWE1IDEwMDY0NA0K
PiAtLS0gYS90b29scy9wZXJmL3V0aWwvaW50ZWwtdHBlYnMuYw0KPiArKysgYi90b29scy9wZXJm
L3V0aWwvaW50ZWwtdHBlYnMuYw0KPiBAQCAtMyw3ICszLDcgQEANCj4gICAqIGludGVsX3RwZWJz
LmM6IEludGVsIFRQRUJTIHN1cHBvcnQNCj4gICAqLw0KPiANCj4gLQ0KPiArI2luY2x1ZGUgPGFw
aS9mcy9mcy5oPg0KPiAgI2luY2x1ZGUgPHN5cy9wYXJhbS5oPg0KPiAgI2luY2x1ZGUgPHN1YmNt
ZC9ydW4tY29tbWFuZC5oPg0KPiAgI2luY2x1ZGUgPHRocmVhZC5oPg0KPiBAQCAtMTIxLDYgKzEy
MSw1OSBAQCBzdGF0aWMgaW50IGV2c2VsX190cGVic19zdGFydF9wZXJmX3JlY29yZChzdHJ1Y3QN
Cj4gZXZzZWwgKmV2c2VsKQ0KPiAgCXJldHVybiByZXQ7DQo+ICB9DQo+IA0KPiArc3RhdGljIGJv
b2wgaXNfY2hpbGRfcGlkKHBpZF90IHBhcmVudCwgcGlkX3QgY2hpbGQpDQo+ICt7DQo+ICsJaWYg
KHBhcmVudCA8IDAgfHwgY2hpbGQgPCAwKQ0KPiArCQlyZXR1cm4gZmFsc2U7DQo+ICsNCj4gKwl3
aGlsZSAodHJ1ZSkgew0KPiArCQljaGFyIHBhdGhbUEFUSF9NQVhdOw0KPiArCQljaGFyIGxpbmVb
MjU2XTsNCj4gKwkJRklMRSAqZnA7DQo+ICsNCj4gK25ld19jaGlsZDoNCj4gKwkJaWYgKHBhcmVu
dCA9PSBjaGlsZCkNCj4gKwkJCXJldHVybiB0cnVlOw0KPiArDQo+ICsJCWlmIChjaGlsZCA8PSAw
KQ0KPiArCQkJcmV0dXJuIGZhbHNlOw0KPiArDQo+ICsJCXNjbnByaW50ZihwYXRoLCBzaXplb2Yo
cGF0aCksICIlcy8lZC9zdGF0dXMiLA0KPiBwcm9jZnNfX21vdW50cG9pbnQoKSwgY2hpbGQpOw0K
PiArCQlmcCA9IGZvcGVuKHBhdGgsICJyIik7DQo+ICsJCWlmICghZnApIHsNCj4gKwkJCS8qIFBy
ZXN1bWFibHkgdGhlIHByb2Nlc3Mgd2VudCBhd2F5LiBBc3N1bWUgbm90IGENCj4gY2hpbGQuICov
DQo+ICsJCQlyZXR1cm4gZmFsc2U7DQo+ICsJCX0NCj4gKwkJd2hpbGUgKGZnZXRzKGxpbmUsIHNp
emVvZihsaW5lKSwgZnApICE9IE5VTEwpIHsNCj4gKwkJCWlmIChzdHJuY21wKGxpbmUsICJQUGlk
OiIsIDUpID09IDApIHsNCj4gKwkJCQlmY2xvc2UoZnApOw0KPiArCQkJCWlmIChzc2NhbmYobGlu
ZSArIDUsICIlZCIsICZjaGlsZCkgIT0gMSkgew0KPiArCQkJCQkvKiBVbmV4cGVjdGVkIGVycm9y
IHBhcnNpbmcuICovDQo+ICsJCQkJCXJldHVybiBmYWxzZTsNCj4gKwkJCQl9DQo+ICsJCQkJZ290
byBuZXdfY2hpbGQ7DQo+ICsJCQl9DQo+ICsJCX0NCj4gKwkJLyogVW5leHBlY3RlZCBFT0YuICov
DQo+ICsJCWZjbG9zZShmcCk7DQo+ICsJCXJldHVybiBmYWxzZTsNCj4gKwl9DQo+ICt9DQo+ICsN
Cj4gK3N0YXRpYyBib29sIHNob3VsZF9pZ25vcmVfc2FtcGxlKGNvbnN0IHN0cnVjdCBwZXJmX3Nh
bXBsZSAqc2FtcGxlLCBjb25zdA0KPiBzdHJ1Y3QgdHBlYnNfcmV0aXJlX2xhdCAqdCkNCj4gK3sN
Cj4gKwlwaWRfdCB3b3JrbG9hZF9waWQgPSB0LT5ldnNlbC0+ZXZsaXN0LT53b3JrbG9hZC5waWQ7
DQo+ICsJcGlkX3Qgc2FtcGxlX3BpZCA9IHNhbXBsZS0+cGlkOw0KPiArDQo+ICsJaWYgKHdvcmts
b2FkX3BpZCA8IDAgfHwgd29ya2xvYWRfcGlkID09IHNhbXBsZV9waWQpDQo+ICsJCXJldHVybiBm
YWxzZTsNCj4gKw0KPiArCWlmICghdC0+ZXZzZWwtPmNvcmUuYXR0ci5pbmhlcml0KQ0KPiArCQly
ZXR1cm4gdHJ1ZTsNCj4gKw0KPiArCXJldHVybiAhaXNfY2hpbGRfcGlkKHdvcmtsb2FkX3BpZCwg
c2FtcGxlX3BpZCk7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQgcHJvY2Vzc19zYW1wbGVfZXZl
bnQoY29uc3Qgc3RydWN0IHBlcmZfdG9vbCAqdG9vbA0KPiBfX21heWJlX3VudXNlZCwNCj4gIAkJ
CQl1bmlvbiBwZXJmX2V2ZW50ICpldmVudCBfX21heWJlX3VudXNlZCwNCj4gIAkJCQlzdHJ1Y3Qg
cGVyZl9zYW1wbGUgKnNhbXBsZSwNCj4gQEAgLTE0MCw2ICsxOTMsMTAgQEAgc3RhdGljIGludCBw
cm9jZXNzX3NhbXBsZV9ldmVudChjb25zdCBzdHJ1Y3QNCj4gcGVyZl90b29sICp0b29sIF9fbWF5
YmVfdW51c2VkLA0KPiAgCQltdXRleF91bmxvY2sodHBlYnNfbXR4X2dldCgpKTsNCj4gIAkJcmV0
dXJuIC1FSU5WQUw7DQo+ICAJfQ0KPiArCWlmIChzaG91bGRfaWdub3JlX3NhbXBsZShzYW1wbGUs
IHQpKSB7DQo+ICsJCW11dGV4X3VubG9jayh0cGVic19tdHhfZ2V0KCkpOw0KPiArCQlyZXR1cm4g
MDsNCj4gKwl9DQo+ICAJLyoNCj4gIAkgKiBOZWVkIHRvIGhhbmRsZSBwZXIgY29yZSByZXN1bHRz
PyBXZSBhcmUgYXNzdW1pbmcgYXZlcmFnZSByZXRpcmUNCj4gIAkgKiBsYXRlbmN5IHZhbHVlIHdp
bGwgYmUgdXNlZC4gU2F2ZSB0aGUgbnVtYmVyIG9mIHNhbXBsZXMgYW5kIHRoZSBzdW0NCj4gb2YN
Cj4gLS0NCj4gMi40OS4wLjkwNi5nMWYzMGExOWMwMi1nb29nDQoNCg==
