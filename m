Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A3F1DDC3A;
	Fri, 31 Jan 2025 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738338601; cv=fail; b=oaku+kDsRGG32Pzr+xwcwfIP73bq4sO5+pYlHPJk1biGyPN6xh2ABZhRwpFF3fBEGUQUVcRc0SJYPk0LwO+Svvnnk+3EsVfWKiY7hdY1nSgAKEF7rSWtfPt9tbXZO9/OCxXB/BhifJoDj3hZ1DBrMyQaiEi8+ffCWnXfMsfE1hQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738338601; c=relaxed/simple;
	bh=8nVehIGSSW22P4WjuN3sQvCJ4mX4uzoK0CHLJ0lNBSc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eXz2i0NpxToKnrqyMvDwNtKPyLHyOIUZbuYht7H5bAwz21eQpqDlf7HDhvUsT5nqIEHXr4ITwhNjPd7iRL+5bAO88UAFZhvVbNxWQ9vCSzh18IoCqEfQnucGZtrLBtFqIhfTjbZDIpjC5U6D5JFb2Of341fWKA5h8gQ2IAc4SkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SDQ1HFcS; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SDQ1HFcS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738338596; x=1769874596;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=8nVehIGSSW22P4WjuN3sQvCJ4mX4uzoK0CHLJ0lNBSc=;
  b=SDQ1HFcSyYYe55HfQHaafDBaDG8vI/8PLsF19YBpE5muRt4iXhcFrT7W
   b8WTp7EZ7lEOryO5OhZb2Aknw7nK1zs+vWY0elrAtEi816UrLMIG3XmEI
   Dt1w582RAjeyJobOxs3Jz5IPK0mxaRjD8b+3/n+w1/5QlhSWB7YHXV86w
   o9R+jAfA1CmIqIEAjukEn8qU2xOE/XtfnEWuhttRbBFeeCIkuPAE7H9FE
   yU/aGwiDZvsSdQ0OfMO0NTPEoaIcj4ykIeWg1qMaQ9ytyizAWnIxdPccq
   HU9P0Wl2gM/yt0QUb1KLUcVWmz8r3ae0dViDJeimr8i945VNwQq7HBLBl
   Q==;
X-CSE-ConnectionGUID: BdYy6cGRTFqgnFz5xvK7qQ==
X-CSE-MsgGUID: Bxolt9eLRtGwNxsgO03ryA==
X-IronPort-AV: E=McAfee;i="6700,10204,11332"; a="38793542"
X-IronPort-AV: E=Sophos;i="6.13,248,1732608000"; 
   d="scan'208";a="38793542"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 07:49:56 -0800
X-CSE-ConnectionGUID: 35smeSNHTiCwS93PiYEAzg==
X-CSE-MsgGUID: XQjDKuK+S1S+N4L5N4cfaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114811154"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2025 07:49:55 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 31 Jan 2025 07:49:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 31 Jan 2025 07:49:55 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 31 Jan 2025 07:49:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMbynmUHwPlyy/i6X4Rneoe/D9RmBov5F8NOJd9m6RMCZVmBAv+KiEWroSvZJlgyUKQ2FoA7eqdbj9WaDd4uUe7S/vM0jJVM0MOlv5TdeJEtEqthhRd1H21gUVELqiWP8htS4FqSIppM2Y3oINpvHP5txYJglosze1bC2b1M+N9BjPqbX4dBnPpOi92GSkSNoyP7H/xhQ0LzvaxQdb3OIj4P2p6V9XWkwGlNmHF8jMRJ3ZwVjagSQsHfP2Hse9Bohig1aa1J/Uy+IzUdZhqfQiDeHlABBEZ8NdltKIDJw+v48ZDqyIWFUhAWqSPA+ji1WVMfYbU29wj9SK+EtdIt9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nVehIGSSW22P4WjuN3sQvCJ4mX4uzoK0CHLJ0lNBSc=;
 b=ghkNgJxFPuQ/JCFxsoNwL8Dn6Tnda/ovuZ7uM/2DupMgqlSIkq2PP0QeOwtE8pbFrjisIFYrOGstkvzxNBOEC0kafn/9qaebJCCPUHM9NuIK3hwRZbJh+Rm49nPNylp+tiRzP5zW0mAO/Jie0OfKHkr3mk820dfftki8Aq/zugaEiiU4zfJbfQhz3DpXOfkrbATDvgnTy4Iv535THbPiAAR2dzJDHcXZyOcISrLG/Ukgo8fS5qn8Z7pjNdABuj+lJk9A1Rd398Dl/I9367Ztc0Kq8Wmwwoe+O2AymYgoJgfdqAbhE0YPnlJXIE83zYIoJc0hpdc/MPgz+gacF307YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by SA1PR11MB8447.namprd11.prod.outlook.com (2603:10b6:806:3ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Fri, 31 Jan
 2025 15:49:39 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%6]) with mapi id 15.20.8398.017; Fri, 31 Jan 2025
 15:49:38 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "james.clark@linaro.org" <james.clark@linaro.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org"
	<acme@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "irogers@google.com" <irogers@google.com>,
	"Wang, Weilin" <weilin.wang@intel.com>
Subject: Re: [PATCH v3] perf test shell tpebs: Extra verbosity and hypervisor
 skip
Thread-Topic: [PATCH v3] perf test shell tpebs: Extra verbosity and hypervisor
 skip
Thread-Index: AQHbczjhY31f/+zUUUynP+yZ9OB8ybMxCQMA
Date: Fri, 31 Jan 2025 15:49:38 +0000
Message-ID: <62c02ce25e086feb7a299e441633823994e87073.camel@intel.com>
References: <20250130170135.5817-1-irogers@google.com>
In-Reply-To: <20250130170135.5817-1-irogers@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|SA1PR11MB8447:EE_
x-ms-office365-filtering-correlation-id: 8842b9c8-3a52-447b-be79-08dd420edeac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UUgwb1p3U0JPZSs1T2EvS3B5TVRDVjVIcHVBZWVvbEpocExIT3BGL3Z4V0tl?=
 =?utf-8?B?WXVvMktlK1gyUGJnZXVPdU0vNlBMeDlXRDRZeWRFeHEwWEE0OFF3d1I0eTVP?=
 =?utf-8?B?M1NFZThHN1dVZy9kWTBLQ2pOLzAwdllGeVdNQ3FOcFFCVzZyNGFvYnJwUXps?=
 =?utf-8?B?V01vVVV4MGJHRGtqS2tjT0RDL2V2MldOSWE4OEVTc0V5Y0d6OXovOVZBVVFq?=
 =?utf-8?B?MGRrR29NUTJsRUsraDAyL3FYQXN2cW1RY01XdDM3eGEwNzgxb0MxZHpXQ2Q2?=
 =?utf-8?B?WENOVkE5OXBoVURZYkJjbUVkMDFxdllnZ3FaaTgzRVNjemc2a3lTOGJhckZi?=
 =?utf-8?B?WlQ4UmdOQTArbnlXMDBKNTNVcEhlYkNLQU9lR0kydno0MW5XcXFvTEY5UTJ0?=
 =?utf-8?B?NUp3MXRMUVBpZnhGSWpOZ3cxbXdYSm1CM1Z5dW5WSHc5TEVYTWRVUzl4Y3N0?=
 =?utf-8?B?UUYza21IOU5GR2ZVcC9SUUJUQW50UU1TQmdVRHM2dG1tY2hNWk15WTZWSkl5?=
 =?utf-8?B?SENaSUlpbVJMWStWSVZnT05zaEQ4ajRSS0tieEhFLzVsdUhNdElGcEM2NldX?=
 =?utf-8?B?alJXc1hNRW1aTC9NREY1VUk3c3J5bTlFTFRUQ25GTVRtSFRBZlpWbUZjaUJP?=
 =?utf-8?B?dVlzVEFRMXA3UlNpd2xzaFVTUk9GbExoRlJzR2Q4WGNZdUtPZTRscHZJQ0Fn?=
 =?utf-8?B?RGV2K0NxWjYxZjloZGtJWk9TVGxhakVxM3Rhb21LYUk3Q2lCclNkeWsyaUpR?=
 =?utf-8?B?NEdXOEJ1Vnd2bEpJOFVmaGVOWGtNWXN5aCtxRmJQU3lPY1ZjKzU3dTFqUTc1?=
 =?utf-8?B?enhjUFY0Z1pTbjlENGlzVzZQRnVJQWN5TXE3RDgyN21EVW9VYzFKUUpXcHha?=
 =?utf-8?B?dVNOcGpiVjBxNStMbUNMM0FpdGRYdUxTcHlxT05kM3lCeTA2VThhMUtUeDRj?=
 =?utf-8?B?OEM2RE50MGhQRVloSk42YXhIU3VKUklaOUNObEY2SSttVkpnd3JGL1FvSTU0?=
 =?utf-8?B?M1RScFhETENaQmExUkRXTG5XL2dKOGV5ZEFDU3FiWXpXTGJqWDI0TlZ1cDJh?=
 =?utf-8?B?d04vSEwvbU1JdnFqdDQvYWNtYWRqaitaS01yN0VERVZBeDMvaDgzRFV0K211?=
 =?utf-8?B?YWRjTkJyWmlISUFzOE9aVUtHeFlVMWxOa29FYTVSMFFlRFVUV0E0YldvUEdz?=
 =?utf-8?B?a3AweHRPSkd4Rm02VXg3UkpwMVRzcFhQYXRNNDFzcmtMZWJTWXhBZ0tYb3R5?=
 =?utf-8?B?UnFFaFlGMUFqbXk0UWF0T0VnZndqZm0xaUg3eG9ONXNLZGhzdWZKK2YrS2do?=
 =?utf-8?B?bmIyOGVjOUlKeTN3S0NSNUljUzJoTmsrUzlpM0NqeHh4cEY1WnpIdG1oYjhN?=
 =?utf-8?B?L3pUcFNUa1NqQjlYbk11c1BaazFySm9zYmYwODU1UTJsZGxjT2c4MDlscmpX?=
 =?utf-8?B?ZUFIZFhQL25xa0pZZVpMTmViSk1MMDJTQ1ZmaVM1WGtkRmhreHBiVDBWdjIw?=
 =?utf-8?B?OWt0Y0VWek5uRGNqT2xwdzdlRVlvc291ZnptNWJCR0N1aWcxVEMvdThZKzhr?=
 =?utf-8?B?NHJESTBVc25raDVuSVozRWVBcy9BSXBpWXg0eVk0d09GbFd1K3owRWRMTE81?=
 =?utf-8?B?VnNRbFMweFhqbWw5c3RpaG1JbWJwbWlvV3BiYXF3dkRMVncyWEt0Tk50WFhz?=
 =?utf-8?B?WlpQUWVIcTFNVGpIa24relh0d21YSFlxb0JMQW5qWkphK0hlcU5ibTIyYkFZ?=
 =?utf-8?B?dGhPcy9PU0dxK3BGeHZrL0M1NDlLTjF0cWRCczVrQ3M4M0xtdTI3Vk1mbU1H?=
 =?utf-8?B?RmswcTg2SUZSV3BCcGJRSjAwejJlZWVyMy9Hb0RlZjhlNEVDNkQzTHFxM1c2?=
 =?utf-8?B?ZytUWHJWL2xTSE1ZOU1zSkJSbVdsVno2bzhmUkxVUmloOVN0NnFCYkwxNXYv?=
 =?utf-8?B?NGZaaU4xK0tvN2tSS3JONmw4ZmpzTGlWVHh5NnhBdFh0YnFhZHNhdklycXpp?=
 =?utf-8?B?NE1ieDlPWVp3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z01MMThFRlBSSGdrcXRYSHQ3cWQwNHVscWNWMmVsMmJtbXl5YkhKWWx5OE93?=
 =?utf-8?B?VWpYTlFab2VtTHk3MXVEZmorN0pVVnJFM2VFWFc5U2FVNkFOMVJOSkpYM1NP?=
 =?utf-8?B?MFNCQlZaWTExbWNienZVTVk2bnlQK3U1TlM4SEZxS2lDSFdmS0M0N0dKRUxM?=
 =?utf-8?B?blI4Y0plVGozOXcxY3dZMzZZc1pyU1FBazN3K2UxenhQL011RzgxbUtQemlh?=
 =?utf-8?B?MCs2Qzl1Z2NnN296Zm5vL2JBNnFCOGEvbFhEU1M5YktPeDlGZ1JJQzNUckxR?=
 =?utf-8?B?bkRpaENMS2h1bXBaRTgwNkxoTERrZGtHU3JndEZNdEJmVVNRdEVYZjkyMHBM?=
 =?utf-8?B?dGpnRGpGY2N2aEphcWtWODhIaTMzNXFYbjlMYlpSTWx1NnZEMTR5SHFJSDE2?=
 =?utf-8?B?ekdwUkM5Rm9TcUlueVdSY3Q5YzVjVjI2d1p0Vm1BNnNLK01vVyticXBsWXlZ?=
 =?utf-8?B?aDJjdFNPR2gwTDJOOVNrZWVJdlZGK3hIZ0E3ZHR6SWlkcExIVEpPa0lZZmlv?=
 =?utf-8?B?Z3NCTGZJdnR6KzBWaEF4SGtyc0Q4UmZsUzVZUnVYUWE4SHc5ellVbk1hcW5t?=
 =?utf-8?B?U01sUWRsalcxdi8vU2JkMVVEZ0Z1M3NjNVZQa0NPVzJjNWQxcWJFVUZ0cUJ3?=
 =?utf-8?B?dHdnUkdDOGxESENKQVZXN1ovZjJIMDNBUm5OWDNhYjlmcmNTY2pDeUVXbWUw?=
 =?utf-8?B?azE2T1locTBwdUhEeTFFOW9FMGVIR3Y0Z2lvN1JSQW16ZjI2M2dxbWlvQndX?=
 =?utf-8?B?dE9udkF0WXZac2t6WHl2SmRNQUxKbGRyKzd6bjNhUGN4S1cwZzkvVXg1N05Z?=
 =?utf-8?B?SUIyK3V2bDNEYU43Um50WXZzb1F1WGQ1TTJEYTRONUtJL3haSGFMR205dnNG?=
 =?utf-8?B?eXdrZnAzdEJYcitOWWs1eEt4RklUYjBXeXI3Zkh2ZmgvZHVqdUI4OUc5NUlJ?=
 =?utf-8?B?N1k2N3pBZkJ0RXdIRWxWblAvQ1M2eWVOY0VxOTJPMnZZa2FxYVk4YkdlVW85?=
 =?utf-8?B?M0U0RG94bjBxN0xnT0dnQ2twY0FWd1F6QnFIWUQ5ZnFVdGlzYjhkUS82SnFE?=
 =?utf-8?B?NmZmVmVLam9PSlJjUkRYVFcydTlkTnFGcE42bVgxK2FXa0ZVcm5pTWFxdmlR?=
 =?utf-8?B?VjQ2TEFlTmNQL0lCSktKZGVZVWo4VzU0d1F4MTRmTXFJbGxoODZ2S3BoVExh?=
 =?utf-8?B?cHhlM0RIRktMTHpTTjNJUkFyc0x6MGJnbXNCLzFjOGpFcy9OVTd2c1ppWitI?=
 =?utf-8?B?MGIwdlBmQVYwelFrWkxSeUhJMnA0Rk50bllwUk4vN1YwMndSNkd4aGFIbDhG?=
 =?utf-8?B?bWwreTBRU3YyVkc3dGFEVGFDdFptb3NDWnRBWmpiUGE2aEpzeWFCK0lXTURO?=
 =?utf-8?B?K2VyNlhNVXFQRTJmYVk0dWJEanVWdG5YQUpMb3FKN2R1dUoycGVnZlRRZTEy?=
 =?utf-8?B?RDJ0VXgycFRHcENNNUZBUzVVRi9OR2ZyWnV1bUp6LzJ6OWZlMnhwMHUzM0N2?=
 =?utf-8?B?MWYwaTFaVFN3bkN3YjVTK2xVOENadlZXUWVzWldCVFVLMUZsdzk0OU1lSE0v?=
 =?utf-8?B?Znp6dTFGdTlvRzgzN0o0RnRJYWhnVGZSOGcrUTcyN2lieWNPN0pDeG9abnVF?=
 =?utf-8?B?R2NWVDNGRktzaHo1RlJDdjQ1N0UrWDJhdzVLa3JjUW01OEdDSktiRGdIaWVx?=
 =?utf-8?B?Tis2S0tQcUNSdUpZeHZ3ZWIrMnl2N1U2bDZSRlRTK3BnMk1ENVc0M25Id1NK?=
 =?utf-8?B?S1RhTy9TNnIrTVNNVVdmcnFSWFY0K3NKMTdoVmNoZWxKdjcyV1c3b0NMRjBu?=
 =?utf-8?B?L1BKTnRRVFlRTENBOGE5dmZ4NUZ3UnRRdUs4L3FwVGRsVEt5enAxVkdvMnA5?=
 =?utf-8?B?MGM0WCs1VENlMUhoZ09XVkNRK0hGbTZ2aW0zeWlyckdCZXlETTVhWWFZMmt0?=
 =?utf-8?B?OGNNaVRqSG80TDc2QU5TaFVvNytaRFQ3N3NqYUhsVzR0UjQyS2xISk9XOFRt?=
 =?utf-8?B?ZXBOUktmYXpJUFNUMVJoSlFGUUkrQWtTbndVSUVQbTY3a0svUUc3VEYyTTdi?=
 =?utf-8?B?MFVEdkhHeVA4bllxQzR2TFN6d3JuQWl2eVNJNklHSDM5VmdRTStvTjlEeFJW?=
 =?utf-8?B?YTJwSkVRUXUxN0lxWk9lNis0OEVCREQwcHBsVjZsVUNKbklpRWViQ2JJSUky?=
 =?utf-8?Q?DhJ2fjpDhfvbU3Vm68a36/I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CCFF67D1C8C2C46B7917B68F6869D5A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8842b9c8-3a52-447b-be79-08dd420edeac
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2025 15:49:38.9042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0+63T/uwggwUbJUDpYbG14iOEOBanMi5IOcIN2f9/L87f2GY9VNvy4K7jXD5QZgJwesmkx0aXBboC3q7fblmJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8447
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTAxLTMwIGF0IDA5OjAxIC0wODAwLCBJYW4gUm9nZXJzIHdyb3RlOg0KPiBX
aGVuIG5vdCBydW5uaW5nIGFzIHJvb3QgYW5kIHdpdGggaGlnaGVyIHBlcmYgZXZlbnQgcGFyYW5v
aWEgdmFsdWVzDQo+IHRoZSBwZXJmIHJlY29yZCBmb3JrZWQgYnkgVFBFQlMgY2FuIGZhaWwgdG8g
YXR0YWNoIHRvIHRoZSBwcm9jZXNzLg0KPiBTa2lwDQo+IHRoZSB0ZXN0IGluIHRoZXNlIHNjZW5h
cmlvcy4NCj4gDQo+IEludGVsIFRQRUJTIHRlc3Qgc2tpcHMgb24gbm9uLUludGVsIENQVXMuIE9u
IEludGVsIENQVXMgdW5kZXIgYQ0KPiBoeXBlcnZpc29yIHRoZSBjYWNoZS1taXNzZXMgZXZlbnQg
bWF5IG5vdCBiZSBwcmVzZW50IG9yIHByZWNpc2UuIFNraXANCj4gdGhlIHRlc3QgdW5kZXIgdGhp
cyBjb25kaXRpb24uDQo+IA0KPiBSZWZhY3RvciB0aGUgb3V0cHV0IGNvZGUgdG8gYmUgcGxhY2Vk
IGluIGEgZmlsZSBzbyB0aGF0IG9uIGEgc2lnbmFsDQo+IHRoZSBmaWxlIGNhbiBiZSBkdW1wZWQu
IFRoaXMgd2FzIG5lY2Vzc2FyeSB0byBjYXRjaCB0aGUgaXNzdWUgYWJvdmUNCj4gYXMNCj4gdGhl
IGZhaWxpbmcgcGVyZiByZWNvcmQgY29tbWFuZCB3b3VsZCBmYWlsIHdpdGhvdXQgb3V0cHV0Lg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogSWFuIFJvZ2VycyA8aXJvZ2Vyc0Bnb29nbGUuY29tPg0KPiAt
LS0NCj4gdjM6IEFkZC9zcXVhc2ggbWlzc2VkIHBhdGNoZXMgcG9pbnRlZCBvdXQgYnkgIkZhbGNv
biwgVGhvbWFzIg0KPiDCoMKgwqAgPHRob21hcy5mYWxjb25AaW50ZWwuY29tPg0KPiB2MjogRml4
IGxvc3QgOlIgYW5kIHVzZSA6cCB3aXRoIHJlY29yZCBhcyBpdCBpcyBpZ25vcmVkIGJ5IHBlcmYg
c3RhdC4NCj4gLS0tDQoNCldvcmtzIGZvciBtZSBvbiBhbiBpOS0xMjkwMCBhbmQgQ29yZSBVbHRy
YSA5IDI3NUhYIC4NCg0KVGVzdGVkLWJ5OiBUaG9tYXMgRmFsY29uIDx0aG9tYXMuZmFsY29uQGlu
dGVsLmNvbT4NCg0KVGhhbmtzDQoNCg0KPiDCoC4uLi9wZXJmL3Rlc3RzL3NoZWxsL3Rlc3Rfc3Rh
dF9pbnRlbF90cGVicy5zaCB8IDg5ICsrKysrKysrKysrKysrKystDQo+IC0tDQo+IMKgMSBmaWxl
IGNoYW5nZWQsIDc2IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL3Rvb2xzL3BlcmYvdGVzdHMvc2hlbGwvdGVzdF9zdGF0X2ludGVsX3RwZWJzLnNoDQo+
IGIvdG9vbHMvcGVyZi90ZXN0cy9zaGVsbC90ZXN0X3N0YXRfaW50ZWxfdHBlYnMuc2gNCj4gaW5k
ZXggZjk1ZmM2NGJmMGE3Li5hMzMwZWNkYjdiYTUgMTAwNzU1DQo+IC0tLSBhL3Rvb2xzL3BlcmYv
dGVzdHMvc2hlbGwvdGVzdF9zdGF0X2ludGVsX3RwZWJzLnNoDQo+ICsrKyBiL3Rvb2xzL3BlcmYv
dGVzdHMvc2hlbGwvdGVzdF9zdGF0X2ludGVsX3RwZWJzLnNoDQo+IEBAIC0zLDIwICszLDgzIEBA
DQo+IMKgIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiDCoA0KPiDCoHNldCAt
ZQ0KPiAtZ3JlcCAtcSBHZW51aW5lSW50ZWwgL3Byb2MvY3B1aW5mbyB8fCB7IGVjaG8gU2tpcHBp
bmcgbm9uLUludGVsOw0KPiBleGl0IDI7IH0NCj4gwqANCj4gLSMgVXNlIHRoaXMgZXZlbnQgZm9y
IHRlc3RpbmcgYmVjYXVzZSBpdCBzaG91bGQgZXhpc3QgaW4gYWxsDQo+IHBsYXRmb3Jtcw0KPiAt
ZXZlbnQ9Y2FjaGUtbWlzc2VzOlINCj4gK1BhcmFub2lkQW5kTm90Um9vdCgpIHsNCj4gK8KgIFsg
IiQoaWQgLXUpIiAhPSAwIF0gJiYgWyAiJChjYXQNCj4gL3Byb2Mvc3lzL2tlcm5lbC9wZXJmX2V2
ZW50X3BhcmFub2lkKSIgLWd0ICQxIF0NCj4gK30NCj4gwqANCj4gLSMgSHlicmlkIHBsYXRmb3Jt
cyBvdXRwdXQgbGlrZSAiY3B1X2F0b20vY2FjaGUtbWlzc2VzL1IiLCByYXRoZXINCj4gdGhhbiBh
cyBhYm92ZQ0KPiAtYWx0X25hbWU9L2NhY2hlLW1pc3Nlcy9SDQo+ICtpZiAhIGdyZXAgLXEgR2Vu
dWluZUludGVsIC9wcm9jL2NwdWluZm8NCj4gK3RoZW4NCj4gK8KgIGVjaG8gIlNraXBwaW5nIG5v
bi1JbnRlbCINCj4gK8KgIGV4aXQgMg0KPiArZmkNCj4gwqANCj4gLSMgV2l0aG91dCB0aGlzIGNt
ZCBvcHRpb24sIGRlZmF1bHQgdmFsdWUgb3IgemVybyBpcyByZXR1cm5lZA0KPiAtI2VjaG8gIlRl
c3Rpbmcgd2l0aG91dCAtLXJlY29yZC10cGVicyINCj4gLSNyZXN1bHQ9JChwZXJmIHN0YXQgLWUg
IiRldmVudCIgdHJ1ZSAyPiYxKQ0KPiAtI1tbICIkcmVzdWx0IiA9fiAkZXZlbnQgfHwgIiRyZXN1
bHQiID1+ICRhbHRfbmFtZSBdXSB8fCBleGl0IDENCj4gK2lmIFBhcmFub2lkQW5kTm90Um9vdCAw
DQo+ICt0aGVuDQo+ICvCoCBlY2hvICJTa2lwcGluZyBwYXJhbm9pZCA+MCBhbmQgbm90IHJvb3Qi
DQo+ICvCoCBleGl0IDINCj4gK2ZpDQo+IMKgDQo+IC0jIEluIHBsYXRmb3JtcyB0aGF0IGRvIG5v
dCBzdXBwb3J0IFRQRUJTLCBpdCBzaG91bGQgZXhlY3V0ZSB3aXRob3V0DQo+IGVycm9yLg0KPiAt
ZWNobyAiVGVzdGluZyB3aXRoIC0tcmVjb3JkLXRwZWJzIg0KPiAtcmVzdWx0PSQocGVyZiBzdGF0
IC1lICIkZXZlbnQiIC0tcmVjb3JkLXRwZWJzIC1hIHNsZWVwIDAuMDEgMj4mMSkNCj4gLVtbICIk
cmVzdWx0IiA9fiAicGVyZiByZWNvcmQiICYmICIkcmVzdWx0IiA9fiAkZXZlbnQgfHwgIiRyZXN1
bHQiID1+DQo+ICRhbHRfbmFtZSBdXSB8fCBleGl0IDENCj4gK3N0YXRfb3V0cHV0PSQobWt0ZW1w
IC90bXAvX19wZXJmX3N0YXRfdHBlYnNfb3V0cHV0LlhYWFhYKQ0KPiArDQo+ICtjbGVhbnVwKCkg
ew0KPiArwqAgcm0gLXJmICIke3N0YXRfb3V0cHV0fSINCj4gK8KgIHRyYXAgLSBFWElUIFRFUk0g
SU5UDQo+ICt9DQo+ICsNCj4gK3RyYXBfY2xlYW51cCgpIHsNCj4gK8KgIGVjaG8gIlVuZXhwZWN0
ZWQgc2lnbmFsIGluICR7RlVOQ05BTUVbMV19Ig0KPiArwqAgY2F0ICIke3N0YXRfb3V0cHV0fSIN
Cj4gK8KgIGNsZWFudXANCj4gK8KgIGV4aXQgMQ0KPiArfQ0KPiArdHJhcCB0cmFwX2NsZWFudXAg
RVhJVCBURVJNIElOVA0KPiArDQo+ICsjIEV2ZW50IHRvIGJlIHVzZWQgaW4gdGVzdHMNCj4gK2V2
ZW50PWNhY2hlLW1pc3Nlcw0KPiArDQo+ICtpZiAhIHBlcmYgcmVjb3JkIC1lICIke2V2ZW50fTpw
IiAtYSAtbyAvZGV2L251bGwgc2xlZXAgMC4wMSA+DQo+ICIke3N0YXRfb3V0cHV0fSIgMj4mMQ0K
PiArdGhlbg0KPiArwqAgZWNobyAiTWlzc2luZyAke2V2ZW50fSBzdXBwb3J0Ig0KPiArwqAgY2xl
YW51cA0KPiArwqAgZXhpdCAyDQo+ICtmaQ0KPiArDQo+ICt0ZXN0X3dpdGhfcmVjb3JkX3RwZWJz
KCkgew0KPiArwqAgZWNobyAiVGVzdGluZyB3aXRoIC0tcmVjb3JkLXRwZWJzIg0KPiArwqAgaWYg
ISBwZXJmIHN0YXQgLWUgIiR7ZXZlbnR9OlIiIC0tcmVjb3JkLXRwZWJzIC1hIHNsZWVwIDAuMDEg
Pg0KPiAiJHtzdGF0X291dHB1dH0iIDI+JjENCj4gK8KgIHRoZW4NCj4gK8KgwqDCoCBlY2hvICJU
ZXN0aW5nIHdpdGggLS1yZWNvcmQtdHBlYnMgW0ZhaWxlZCBwZXJmIHN0YXRdIg0KPiArwqDCoMKg
IGNhdCAiJHtzdGF0X291dHB1dH0iDQo+ICvCoMKgwqAgZXhpdCAxDQo+ICvCoCBmaQ0KPiArDQo+
ICvCoCAjIEV4cGVjdGVkIG91dHB1dDoNCj4gK8KgICMgJCBwZXJmIHN0YXQgLS1yZWNvcmQtdHBl
YnMgLWUgY2FjaGUtbWlzc2VzOlIgLWEgc2xlZXAgMC4wMQ0KPiArwqAgIyBFdmVudHMgZW5hYmxl
ZA0KPiArwqAgIyBbIHBlcmYgcmVjb3JkOiBXb2tlbiB1cCAyIHRpbWVzIHRvIHdyaXRlIGRhdGEg
XQ0KPiArwqAgIyBbIHBlcmYgcmVjb3JkOiBDYXB0dXJlZCBhbmQgd3JvdGUgMC4wNTYgTUIgLSBd
DQo+ICvCoCAjDQo+ICvCoCAjwqAgUGVyZm9ybWFuY2UgY291bnRlciBzdGF0cyBmb3IgJ3N5c3Rl
bSB3aWRlJzoNCj4gK8KgICMNCj4gK8KgICPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIDDCoMKgwqDCoMKgIGNhY2hlLW1pc3NlczpSDQo+ICvCoCAjDQo+ICvCoCAjwqDCoMKgwqDC
oMKgwqAgMC4wMTM5NjMyOTkgc2Vjb25kcyB0aW1lIGVsYXBzZWQNCj4gK8KgIGlmICEgZ3JlcCAi
cGVyZiByZWNvcmQiICIke3N0YXRfb3V0cHV0fSINCj4gK8KgIHRoZW4NCj4gK8KgwqDCoCBlY2hv
ICJUZXN0aW5nIHdpdGggLS1yZWNvcmQtdHBlYnMgW0ZhaWxlZCBtaXNzaW5nIHBlcmYgcmVjb3Jk
XSINCj4gK8KgwqDCoCBjYXQgIiR7c3RhdF9vdXRwdXR9Ig0KPiArwqDCoMKgIGV4aXQgMQ0KPiAr
wqAgZmkNCj4gK8KgIGlmICEgZ3JlcCAiJHtldmVudH06UiIgIiR7c3RhdF9vdXRwdXR9IiAmJiAh
IGdyZXAgIi8ke2V2ZW50fS9SIg0KPiAiJHtzdGF0X291dHB1dH0iDQo+ICvCoCB0aGVuDQo+ICvC
oMKgwqAgZWNobyAiVGVzdGluZyB3aXRoIC0tcmVjb3JkLXRwZWJzIFtGYWlsZWQgbWlzc2luZyBl
dmVudCBuYW1lXSINCj4gK8KgwqDCoCBjYXQgIiR7c3RhdF9vdXRwdXR9Ig0KPiArwqDCoMKgIGV4
aXQgMQ0KPiArwqAgZmkNCj4gK8KgIGVjaG8gIlRlc3Rpbmcgd2l0aCAtLXJlY29yZC10cGVicyBb
U3VjY2Vzc10iDQo+ICt9DQo+ICsNCj4gK3Rlc3Rfd2l0aF9yZWNvcmRfdHBlYnMNCj4gK2NsZWFu
dXANCj4gK2V4aXQgMA0K
