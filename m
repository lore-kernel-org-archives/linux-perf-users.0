Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DC3247291;
	Fri,  5 Jun 2026 17:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679327; cv=fail; b=eTJP67jJsGp4K9+xu4vwUdQtUWbSKRcMe+cR0fByY66pksjHrsp1biFOjZIQJ8FFqTGmsB/vVK1x3ZulM1z0j5VonLlzMv5JB40hCF+XdK04wUOT7SwbHkiF4KfPD2pfDmxoLshDjdnm047mGQOEjaHkwqT4HshaR/PwDsZ0MPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679327; c=relaxed/simple;
	bh=YB0hyYVHt4xftgYWUnzeqkQLNY3j5C9OwqXctvEtO5Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QYvsI+asl2dtT3AA6meqULtSU3f3OJ455GidG98quS/tu3daezKvobOT/WEzE0s99UdCQe6qalCkYqAtJLuK685jpx8UuJvJH2yizhOvfuUb/fp+IeZBMa7x4gBmWAd1Oha5m0MJav7ID32sNWfUTU4WC/tViLIt5e0BvvWoEdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gZrSnQ8P; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gZrSnQ8P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780679326; x=1812215326;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YB0hyYVHt4xftgYWUnzeqkQLNY3j5C9OwqXctvEtO5Q=;
  b=gZrSnQ8PBFmdNixqCD3e7rpEZskxGDnLgZS3OvhFZGaKJ5Pks6+wbQLk
   x+NVbncJaudVc9tVlEPzK67YeHHSj4oW5NCy6kjrZaewtPFSurPHgB3Sr
   DumWPnBx1s/1j2BaUFG5ClR54ztDhuOVyhdLQ9Pz2Cr0YuAhPjwTldBjO
   cnBm9A291673WCiBwjv3n9Ue7zFVrnJgI0+tZWpAgF0Pz/WiG5erwRkU4
   1Yo8dYfM0wEcaAa0/gNEwOn9eK6PJQYviO5R9vU8mAZdcl225ClLXyFrI
   EipH03ilFR2gRNotZDDhoaDa4hvVKTkjyhvpucmhjN/B0V6fa48vbsLhn
   Q==;
X-CSE-ConnectionGUID: Dwdg7V0fSJeUvfTrlC4ayQ==
X-CSE-MsgGUID: dJsRq9+cQsikrymSKDXrKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="92201383"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="92201383"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 10:08:45 -0700
X-CSE-ConnectionGUID: JxJ8nIfsTWabDXTQF/8bow==
X-CSE-MsgGUID: UonE0uHVTkKiuClV5FPBcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="243794278"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 10:08:44 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 10:08:44 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 5 Jun 2026 10:08:44 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.61)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 10:08:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tT1rXKdetmqcV8glJEbGGwvg+8ypGqXZUpNCHr85LMZ5r1AGjCTKvETBzH8W+Mmf+NAO6pNdQ+W7Q3Z/QvKUS0b8ANfH0S5y6IpFXYztWIv/3dQsJ5XYBRSKIvIFYnbRb+oUeZQKhE+ZESoYnRtQ9k9PPqlUhT74GH3pMs3z+JZGqaOFAEyHgHKRRqnO2BNGS+ar8c3Ic5xxpqnOS/RxkpJpKMMNbL4pV0hUEqEy2EVVBkezi7bN84CF6x+RCELia7H0RIDvscTYa+seXyHgubl8v/Gd6Yy/ASN4GnjjKdKjDjJAhPxc+OMxtrecJ66/Bez/ChS9pvVp6/33cPcCyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YB0hyYVHt4xftgYWUnzeqkQLNY3j5C9OwqXctvEtO5Q=;
 b=owZzCfjDJk8L4Z0GgBsWDopAMoc5JfroRgpOMdLHi38ta+KksR9fkOg3SwEfPRpqAjoejA4KmKrt5AyinA0Mn9Ap2yFK8uHI+3WAubNaECb5S82em7H+WhKwWDrvV2y2nz/B6IeFFPisJblThaY3YsvGzO0YTNb9YlLEMM0z8WsD4/NIsyo2ENJ1bRoxT3gFqcqwxSaLe1U0/9UCXrKFfQvHC+FvAg6J0040SGzhTfWAgZCHzfEXW5lWuNYYMLE6GNvjj/2edpuyFsdw50wMpGu5+FPPBMMuqy+TyzpigAnl6+rvwdnouWokIO8zomIzTBAFjioH9t1VtUBDTgVfDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by SN7PR11MB6703.namprd11.prod.outlook.com (2603:10b6:806:268::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 17:08:31 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%2]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 17:08:31 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"ak@linux.intel.com" <ak@linux.intel.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "acme@kernel.org" <acme@kernel.org>,
	"dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"namhyung@kernel.org" <namhyung@kernel.org>, "Rogers, Ian"
	<irogers@google.com>, "Eranian, Stephane" <eranian@google.com>
CC: "Chen, Zide" <zide.chen@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "Mi, Dapeng1" <dapeng1.mi@intel.com>,
	"Hao, Xudong" <xudong.hao@intel.com>
Subject: Re: [PATCH 2/8] perf/x86: Introduce is_x86_pmu() helper
Thread-Topic: [PATCH 2/8] perf/x86: Introduce is_x86_pmu() helper
Thread-Index: AQHc9IkMCvo6JLTJ3ECzzFliisWx5bYwMssA
Date: Fri, 5 Jun 2026 17:08:31 +0000
Message-ID: <199e8dfcfbbb3e3c658c1592ad288eeeb44ccae4.camel@intel.com>
References: <20260605011136.2043393-1-dapeng1.mi@linux.intel.com>
	 <20260605011136.2043393-3-dapeng1.mi@linux.intel.com>
In-Reply-To: <20260605011136.2043393-3-dapeng1.mi@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|SN7PR11MB6703:EE_
x-ms-office365-filtering-correlation-id: c569c64c-677b-4e29-5a8d-08dec32511f9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|22082099003|38070700021|56012099006|6133799003|4143699003|11063799006|18002099003|921020;
x-microsoft-antispam-message-info: BCJYRPBpj4Sgc1eLD4K6vEttAgz+gb0mhH8yFPbM9xBKjgULiuPHoCzcP45l1j6uXpSgwbFJhxfct7MJKmIa0+CblGyfnH1rnnK6FOE5o7k/omW1gZqbNSXVUb0VVNOlDZnxp+B2eqGaDt7tj5w1nqxF2gUF5NaOLw3OWvDqNydCTobK1jHfUFq7sYTCqyHO+nEjGMxtPwnix9DnKoDe7TMPEFdyjifUQEc6rrYbPsLOHPIHzsjaG/19cBmS/CFKa5jV8NPVDkWM++1O8u/Ek908fpuNQssVZ18+Vqx8wGxOU/CNk1FtAYMaMVfovhQz1YBTuq+RkUFaf5r/6QTc9FGLYYAm8B3ALKFhncPo3YxgWkCsXeKhTd/KJb6vqQbqt2IHnfCqrceOQDpIB+qHab4kzYIJNlYDrkaS1JFMtlG+tdBBYVWU1d6Y0uy4coWd2Kg9eRZCgp5pl6qD5s+IcXw1/uY2cCTQR8CMJGoyUYCkPk0+7CbPq0SuGwshNJxv2VNRr4/0KFfmRZ+7l15iCa4CbN2uXe+kzm5dYCG5Tdjx2GrpJCgVl01vEpcV9oNYTTgWQvcaRQfJm93SNUe7hMbbqtsoOZyRsJGOuvmP9OZtCNcjUsIck8kzlPsrlmfQcAfvPSADj8QUIdViPE4vUnhE398+6I6OOQ39+QGlyCVkCrVUZdPERXjGrxASfncJXKi2uBB3wxqBjq6iWyghvUdQxOlcpY0KEhv7YMbuE0uCUhchVYbdUWTXN96DChBHnMKwMbHho83tP7wwHFbr9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(22082099003)(38070700021)(56012099006)(6133799003)(4143699003)(11063799006)(18002099003)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGdQYWZ5UjFRbnIwS0l1aFplYXRtelFpZ3BxcHVPTUtwOFZJWExBMUhxbEJJ?=
 =?utf-8?B?UERTZDErT2FxcUpwdHM5b0dFMTFpUklQVWxaVWFhOHY2Nk9zOWVKYUVhajBJ?=
 =?utf-8?B?TlNSYW1XaTB6NG9OenJuRnBOem1jc1ZjOGgvVFRCeG5Za2M0Z25BMTZ1T09y?=
 =?utf-8?B?bmtiaFFNME51d1JXb3g3ajhKUlo1c2RiM0JVU1poSXpKa0kxRTd5djFSZWMr?=
 =?utf-8?B?YThQY24xeG5DN2pmcUhZMWtrYzVLeWF3aDg0Sm5NZHZvQUNCc2pSUnJ0a3BJ?=
 =?utf-8?B?MWxFbVNoc0NFQ0JDa05iUEJQVTREbnlHc2Y2bXNtaHNLdnVyN1lzVHpyblB0?=
 =?utf-8?B?UkZCL29JVlIzV2tlbVJ3cE90a1V6MEYrMThyQUhIcnpWOGZNNCtHWHU2NVdn?=
 =?utf-8?B?aWEvWitVNW5kV2VLN1loWjRIcUtuZW5EQldqUVV6UTZRdFU5ZkVwSmhQcElj?=
 =?utf-8?B?MHlFRndJaDlmVWJsQUI4M1FuNnA4U1FVWHBmWk0vbEJpYTJPNHY0bEpzYzlw?=
 =?utf-8?B?bFhwd2R2YU05Z1laMnZlRGZJSXVROHRlWEVqSjA5TDRMU1U5RDU3Y0huajl5?=
 =?utf-8?B?d2pvNHpuT1lEMzliOFM5d1QyOXQrZDlIbVoxUGFHL0o4UmVBd2NybjNjeGF3?=
 =?utf-8?B?VlplZTNQMmlDSzBnQWVEWEtsUE93ZTNWVy8zY0lvQWZJME1yMzNEWGFtZ3dJ?=
 =?utf-8?B?eU41aTRTNUFoU0N3NzFocVJvUEpHckI4Y2xONy94TEw5UnlNUzBFcVpFcFlK?=
 =?utf-8?B?cmJVMzVRb1QrWFFJR0RpdzQ0TEp4K2phL01ObHg2VmlRSzJDVmJIUjEycHFH?=
 =?utf-8?B?WFdTMWZqdjJMT2lqNS9wN242emc0RHBYcjdkOGR6dHFLN3N3Nk1uaHdmR3l5?=
 =?utf-8?B?dDVEZXl0dlFnN05PT1k3dmIxdm9oYXp0SHY5TkpNcFc5WVVmVVhpVmxVSEJD?=
 =?utf-8?B?a3d0aGRqOTl3WXdYUU92dWs0eThIaE43T3VWdEZCWTBhZWdIdC8zL1JFTmJs?=
 =?utf-8?B?Q1VQS01pMlMxWXFYUHZsUTZwNjNWdUpmZGtuQWhrR1dPQmtBbU51dkhuaFpH?=
 =?utf-8?B?azhNcFQ4WUJJdlBjQno2VTZtRm9yN0RQY1Bsei9XVzdwandNZ1NwVlBGQzdE?=
 =?utf-8?B?QWlhZEFwRTRySjh2UFFZL0NmaWlMZmFPbEVDQlhpS0NkVlljNGdDQ2FiQ2lp?=
 =?utf-8?B?TmR1QkdzZnZuakFNVmp2b09GaXhreTB0STR3REFvUXpuRk9ZUjk2eU5aWXF4?=
 =?utf-8?B?eTNLeGJxY3UwL01BSkFxM21STmh3RG13c0RSVERkb1psUXNDM3k1aU0yWktx?=
 =?utf-8?B?djd3T3dnNXZQcDhRVmNGbzZPSFQxWEh2dW9BaHExSnVUdnh6TUcvakZaZms5?=
 =?utf-8?B?bUdRNCtBTFEydHFrTm1mT3JSRi9veFhac0prK00yTVZZOVZoOHVGU2xtWS9t?=
 =?utf-8?B?YUJMendaMUtzU3RjQzNSVW9OcWNMbC9OajdNWUtiU0czTkRHTURqSGRPMXd3?=
 =?utf-8?B?OEErb3h2ZWNrSE1mNWQvbUl3TWNmMENKanM0cXVqU0xnUGNaNFZVUTVvVzF2?=
 =?utf-8?B?L2lPV3RRYXNaV0sxV1JFZUxzM0tURUxrYW5DRFN6ZHViQ05GTnV1cVQvcldW?=
 =?utf-8?B?cWMrclhoSWxDMm9vNmFjVTUyUmlIcTV1NHFZQVVsZm9CK2hnM3IzdTMvdjls?=
 =?utf-8?B?cmVqOW95Z3RtcUxKNnQwekoyNmM3VWpqREFVRzdrUTNqZU5YbEpTWFFWVHBZ?=
 =?utf-8?B?cWVTT3lWenJ5ZVBoNG9XTzRiOCtZTHFrRVZaYVdxRmFTSFBlYVVCVjQxYTFV?=
 =?utf-8?B?cGk5dVpNdE1ReTNRTkMyYmZCNUQ3ZjFPeExMZUJNK05qVHY4Z2NoYlE5Y016?=
 =?utf-8?B?QUUwWnZIUzN3MldtTER3UmJyL29DQUhVQWZKbCtaSXVVQ3JVcVZad3FPRlpi?=
 =?utf-8?B?eGdzYTlvN3FoVVhicFIwc01KS2h4VCtyblNtK2NOVERIcXJpNWFRa3hlTkZ1?=
 =?utf-8?B?TkpvRHl0M2JjK3pHc3BJREMvL3dwNHQxMmVKZzJ5WXJpam5CZHhLdXNtMDFx?=
 =?utf-8?B?R1JRRENvUSs3UXdSQjN5NnFGZ2lIVlpOTG5rK1ROSk9MWnp0NGFGQUJwd1hP?=
 =?utf-8?B?MThJT1ZYZ3QwNWJ3ZG1pd0ZtRjFGdUZVNFhaL3lmT29FTlgwR3JXbDBTajE2?=
 =?utf-8?B?TXZLT0lUTnZldXlHQitLdE5rS1NPaStFQWdES0hid0h4YnUydWU5OHRBa3dW?=
 =?utf-8?B?am5nVkg2T3plT2U2eFdPTGJwQ2JCNkhHTGxHLzlQaER4ZXB4amFmZmpoMG1D?=
 =?utf-8?B?a3JjbExjTU5pK3ltcWVOV2hGVWlhNVVyZ01qUDhXbFNDUWJBejNORktDdFJs?=
 =?utf-8?Q?RSNIvhhAWIgPNa8etiQuDCKkMa8fhNZl4oYcUaLXJOJqF?=
x-ms-exchange-antispam-messagedata-1: Khb7n5CLU/UcFg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEFF80043FB92F46B26275827A97E9EF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BLEaJw6JSFAN0lVT1ZeqG7LMavb0hz1SQR+b/rz+OysubRN/y32ZBTF6Nh5E2ApLwez9z77s7ni8I7/P6Pukcjui9fF/soFYxW/MtxqDE4g/rNGSLWsxNruwNDg4QnZEuUcz68soIiIObM/3vw0O2EwpxIUB8ESJLb72fg1K4MI6q4EIRDn65/K8Fqv3Tj4UjGYxP/ggYuPgZ1Vd4ViOL+gfU6caMj4P3h1+q1fV3zfh69TweVfKS3Y5nIsUuJGUi3A0RiIGmyPyJsLTAGjdb1OCTgQLEEqRP/JcL62lNjjNmK8ZnYa+nMhmArsrXtwFRIcNC/reS3HLg+QxPQmhAg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c569c64c-677b-4e29-5a8d-08dec32511f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 17:08:31.5388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2LmMneVwL8Xauf4tj2uNIDq3U1zpow24tktLzqo6RZF9hEe03rEtQhclfeAIpRrWC2EHAxkMLei8kpBMyjSz2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6703
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA2LTA1IGF0IDA5OjExICswODAwLCBEYXBlbmcgTWkgd3JvdGU6DQo+IEZy
b206IElhbiBSb2dlcnMgPGlyb2dlcnNAZ29vZ2xlLmNvbT4NCj4gDQo+IFRvIGZhY2lsaXRhdGUg
dGhlIGRldGVjdGlvbiBvZiB4ODYgUE1VIHN0cnVjdHVyZXMgaW4gdXBjb21pbmcNCj4gcGF0Y2hl
cywNCj4gdGhlIGlzX3g4Nl9wbXUoKSBoZWxwZXIgaXMgaW50cm9kdWNlZC4gQWRkaXRpb25hbGx5
LCB0aGUNCj4gaXNfeDg2X2V2ZW50KCkNCj4gaGVscGVyIGhhcyBiZWVuIHJlZmFjdG9yZWQgdG8g
dXRpbGl6ZSBpc194ODZfcG11KCkuDQo+IA0KPiBObyBmdW5jdGlvbiBjaGFuZ2VzIGludGVuZGVk
Lg0KDQpSZXZpZXdlZC1ieTogVGhvbWFzIEZhbGNvbiA8dGhvbWFzLmZhbGNvbkBpbnRlbC5jb20+
DQoNClRoYW5rcywNClRvbQ0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBJYW4gUm9nZXJzIDxpcm9n
ZXJzQGdvb2dsZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IERhcGVuZyBNaSA8ZGFwZW5nMS5taUBs
aW51eC5pbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBaaWRlIENoZW4gPHppZGUuY2hlbkBpbnRl
bC5jb20+DQo+IC0tLQ0KPiANCj4gT3JpZ2luYWwgcGF0Y2ggbGluazoNCj4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzIwMjYwMzE2MDUwODM4LjM2MjQwNTEtMS1kYXBlbmcxLm1pQGxpbnV4
LmludGVsLmNvbS8NCj4gDQo+IMKgYXJjaC94ODYvZXZlbnRzL2NvcmUuY8KgwqDCoMKgwqDCoCB8
IDE2IC0tLS0tLS0tLS0tLS0tLS0NCj4gwqBhcmNoL3g4Ni9ldmVudHMvcGVyZl9ldmVudC5oIHwg
MTggKysrKysrKysrKysrKysrKystDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25z
KCspLCAxNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9ldmVudHMv
Y29yZS5jIGIvYXJjaC94ODYvZXZlbnRzL2NvcmUuYw0KPiBpbmRleCA0YjllMTA1MzA5YzYuLjNi
ZDA1MjJhZmU2ZCAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvZXZlbnRzL2NvcmUuYw0KPiArKysg
Yi9hcmNoL3g4Ni9ldmVudHMvY29yZS5jDQo+IEBAIC03NzQsMjIgKzc3NCw2IEBAIHZvaWQgeDg2
X3BtdV9lbmFibGVfYWxsKGludCBhZGRlZCkNCj4gwqAJfQ0KPiDCoH0NCj4gwqANCj4gLWludCBp
c194ODZfZXZlbnQoc3RydWN0IHBlcmZfZXZlbnQgKmV2ZW50KQ0KPiAtew0KPiAtCS8qDQo+IC0J
ICogRm9yIGEgbm9uLWh5YnJpZCBwbGF0Zm9ybXMsIHRoZSB0eXBlIG9mIFg4NiBwbXUgaXMNCj4g
LQkgKiBhbHdheXMgUEVSRl9UWVBFX1JBVy4NCj4gLQkgKiBGb3IgYSBoeWJyaWQgcGxhdGZvcm0s
IHRoZSBQRVJGX1BNVV9DQVBfRVhURU5ERURfSFdfVFlQRQ0KPiAtCSAqIGlzIGEgdW5pcXVlIGNh
cGFiaWxpdHkgZm9yIHRoZSBYODYgUE1VLg0KPiAtCSAqIFVzZSB0aGVtIHRvIGRldGVjdCBhIFg4
NiBldmVudC4NCj4gLQkgKi8NCj4gLQlpZiAoZXZlbnQtPnBtdS0+dHlwZSA9PSBQRVJGX1RZUEVf
UkFXIHx8DQo+IC0JwqDCoMKgIGV2ZW50LT5wbXUtPmNhcGFiaWxpdGllcyAmDQo+IFBFUkZfUE1V
X0NBUF9FWFRFTkRFRF9IV19UWVBFKQ0KPiAtCQlyZXR1cm4gdHJ1ZTsNCj4gLQ0KPiAtCXJldHVy
biBmYWxzZTsNCj4gLX0NCj4gLQ0KPiDCoHN0cnVjdCBwbXUgKng4Nl9nZXRfcG11KHVuc2lnbmVk
IGludCBjcHUpDQo+IMKgew0KPiDCoAlzdHJ1Y3QgY3B1X2h3X2V2ZW50cyAqY3B1YyA9ICZwZXJf
Y3B1KGNwdV9od19ldmVudHMsIGNwdSk7DQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9ldmVudHMv
cGVyZl9ldmVudC5oDQo+IGIvYXJjaC94ODYvZXZlbnRzL3BlcmZfZXZlbnQuaA0KPiBpbmRleCA1
OTAyYTI5N2RhYTEuLmRiYjVjOGU4YThlYSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvZXZlbnRz
L3BlcmZfZXZlbnQuaA0KPiArKysgYi9hcmNoL3g4Ni9ldmVudHMvcGVyZl9ldmVudC5oDQo+IEBA
IC0xMTUsNyArMTE1LDIzIEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBpc190b3Bkb3duX2V2ZW50KHN0
cnVjdA0KPiBwZXJmX2V2ZW50ICpldmVudCkNCj4gwqAJcmV0dXJuIGlzX21ldHJpY19ldmVudChl
dmVudCkgfHwgaXNfc2xvdHNfZXZlbnQoZXZlbnQpOw0KPiDCoH0NCj4gwqANCj4gLWludCBpc194
ODZfZXZlbnQoc3RydWN0IHBlcmZfZXZlbnQgKmV2ZW50KTsNCj4gK3N0YXRpYyBpbmxpbmUgYm9v
bCBpc194ODZfcG11KHN0cnVjdCBwbXUgKnBtdSkNCj4gK3sNCj4gKwkvKg0KPiArCSAqIEZvciBh
IG5vbi1oeWJyaWQgcGxhdGZvcm1zLCB0aGUgdHlwZSBvZiBYODYgcG11IGlzDQo+ICsJICogYWx3
YXlzIFBFUkZfVFlQRV9SQVcuDQo+ICsJICogRm9yIGEgaHlicmlkIHBsYXRmb3JtLCB0aGUgUEVS
Rl9QTVVfQ0FQX0VYVEVOREVEX0hXX1RZUEUNCj4gKwkgKiBpcyBhIHVuaXF1ZSBjYXBhYmlsaXR5
IGZvciB0aGUgWDg2IFBNVS4NCj4gKwkgKiBVc2UgdGhlbSB0byBkZXRlY3QgYSBYODYgZXZlbnQu
DQo+ICsJICovDQo+ICsJcmV0dXJuIHBtdS0+dHlwZSA9PSBQRVJGX1RZUEVfUkFXIHx8DQo+ICsJ
wqDCoMKgwqDCoMKgIHBtdS0+Y2FwYWJpbGl0aWVzICYgUEVSRl9QTVVfQ0FQX0VYVEVOREVEX0hX
X1RZUEU7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBpc194ODZfZXZlbnQoc3Ry
dWN0IHBlcmZfZXZlbnQgKmV2ZW50KQ0KPiArew0KPiArCXJldHVybiBpc194ODZfcG11KGV2ZW50
LT5wbXUpOw0KPiArfQ0KPiDCoA0KPiDCoHN0YXRpYyBpbmxpbmUgYm9vbCBjaGVja19sZWFkZXJf
Z3JvdXAoc3RydWN0IHBlcmZfZXZlbnQgKmxlYWRlciwgaW50DQo+IGZsYWdzKQ0KPiDCoHsNCg0K
