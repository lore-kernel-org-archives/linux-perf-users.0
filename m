Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE38333FE;
	Sun, 30 Jun 2024 05:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719724383; cv=fail; b=DEgTGqzPzBCUc718LJgF5PU8gKEDsvP7ZzH5chNxMqOJIr25noJV4sD1LG/FrIrqA2FxGT2i7BLnfu0kCcQeu0KKh3sX234XrQ/NnCiAtIb9QjD3tpX/IFoTL4WSU1kiprxcSGHf7ifuESO/5IGvyiTLRHxnbPyfHOZ5qHKHCNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719724383; c=relaxed/simple;
	bh=+iQbodgmJ236C+Cwa+nHO6dvWd2E7fCUgIQNgDy5kgI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dy/QhcFRFArrkvQbhBOe+qlcslxxu91vNkZxaHMrS9aiPJLk4AAlNlHWmps8gLiIIUqWBLP8nCcY+kfUYoCL88pGEQBxyNhO18l3EHZE42jwisG7zuNJxb/mGiiiLvXcj0Q01QuvvLw6+70m34XK+VNdWP4W6N9T38NbuXNcmYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BslxJrNX; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BslxJrNX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719724382; x=1751260382;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+iQbodgmJ236C+Cwa+nHO6dvWd2E7fCUgIQNgDy5kgI=;
  b=BslxJrNXZxlNqTDOkSkE2tS4W3tGE1OAKgKvUi8CDjS5G8C+PT/himjh
   oPNZyHyERHwXKRJvDg9qMsQ4fvID7wHE5O4n5V85CQPl/J9ZaHKYor0S8
   VMwTgkZhhp/HbP2+WxLqNal77Qd+NpYyjxoWot9UV0ui2xZ4TuRb32p/7
   czu0H/Zix7+szd9WE9uZVUaU5iocCtm8/AjhSb48jRIqcbUQsazIBNKCT
   Tw1PuPnpkHq7G89Ra4dc7VjNtlbRql0QbiFEm1oRYXaOjGvlMu4UrVrqy
   0j4bYKNnJy0dDfWIv1kbiG+2yjjTTJrv8Y5PbldGiqKB6oxemfemb5KVN
   w==;
X-CSE-ConnectionGUID: LFYP+E2tTMG/T3ygxEos+Q==
X-CSE-MsgGUID: WMlGVBYpQ6+enbKJDCVm/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11118"; a="16701248"
X-IronPort-AV: E=Sophos;i="6.09,173,1716274800"; 
   d="scan'208";a="16701248"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2024 22:13:02 -0700
X-CSE-ConnectionGUID: z3B2d3IWQY2xfFyI8Nbzgg==
X-CSE-MsgGUID: nEYavWJqQqGVxZlTL8PYOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,173,1716274800"; 
   d="scan'208";a="45264382"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jun 2024 22:13:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 29 Jun 2024 22:13:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 29 Jun 2024 22:13:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 29 Jun 2024 22:13:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIIKl4va9f0zPLpPetzcMdnABi1oP07vQ18qEh2mf0Wp9olHhFFgwOB721r7q6qxcYi1zxKSH3NifPv38p0PhCON1bkhraMT1hMRDUel+VduIwNtS2Mt17q5m8KhWPQ46qwWJLj47Zo3DeBcWQ30KkAEpi2O8mFdmETZj5QX3G4GCiKUvZF3t4SKagTIvqN9Y+DSBmzFcVPhBsi4Sresgjl5vC6+foMnT7jEREZKiLQayErmeBD1xZ2lbZVaZlrgR/O/s01XyRPaKj7mIDtj9KaNVO6rTPjGLopItOur8XKBe89ZlPYWkkWfhofBP/gpnxR5MhzPrvbjtUuEUT9E3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iQbodgmJ236C+Cwa+nHO6dvWd2E7fCUgIQNgDy5kgI=;
 b=RPRKJGSWl5S4vbePyMMSsIaU4caYRgErIO96p3Z318WqeeiKXH5q58q/vJO7cDuuQEDYsslindai5Q7intwrdUYKcZBW2qKw4mUs2lpFluJxZiz0u3xCLWEisxIKkTb3IyAN08gz6sObsB3IUMSMRwxVPVRh/E9gFC8EOCUxDClH0zTif7Ij+jNwG/KqGCR1b+qCF4KpLd1muja28B2rKNhWRpvk0rhISQQObegTtos/NAgxlmwURGPx++Aix8PZSjQFX449buC2pQysg48lJJlLdMIzJdJRjSo3ukEkS+K/qdhAO7ypAc/qe2LkCNEY7PhJVFG5ZU5c/yFH4sMLmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by CO1PR11MB5092.namprd11.prod.outlook.com (2603:10b6:303:6e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sun, 30 Jun
 2024 05:12:58 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%4]) with mapi id 15.20.7719.028; Sun, 30 Jun 2024
 05:12:58 +0000
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
Subject: RE: [RFC PATCH v14 0/8] TPEBS counting mode support
Thread-Topic: [RFC PATCH v14 0/8] TPEBS counting mode support
Thread-Index: AQHaxoTINfG478XFb02KWQ/J2kybpbHaV/8AgAAEcrCAAbjAgIADtR3A
Date: Sun, 30 Jun 2024 05:12:58 +0000
Message-ID: <CO6PR11MB5635353A7B7A010FB727C5A5EED22@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240624222026.229401-1-weilin.wang@intel.com>
 <ZnxW4u_TB5agiFJT@google.com>
 <CO6PR11MB563505F0D97C0E2D5949F583EED62@CO6PR11MB5635.namprd11.prod.outlook.com>
 <Zn3MV8lCSHLEEXDG@google.com>
In-Reply-To: <Zn3MV8lCSHLEEXDG@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|CO1PR11MB5092:EE_
x-ms-office365-filtering-correlation-id: 44a81ba9-eeed-47cc-124e-08dc98c34e99
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bWZlR1phSWhVV1RxSGU1d1BLa00zV2RjR1UyZVRuRnFqcGQ2ZE1LQVBRajJk?=
 =?utf-8?B?TFFWZkp1NFl5VzBGSjVMNnpkNXpUWjB6QzRsS2hvUzdMVmZlb2IvVnZqRkVl?=
 =?utf-8?B?Zndva211WnpzaFpPYlRBSXNKOXFhSWtpWWpCTGVpbVVMWHYrMDN0Q28ybHhW?=
 =?utf-8?B?ZWRWSUh4amltTURoQUVRemVjWkdPVXZWeHRoS3g1M1Y0eXVqTWRxbW1NZHE5?=
 =?utf-8?B?ZTB3T1V3ZFVjMVg5WjNwMHVWYyt0a3lUeThBWXFldmJFSVppcWxCdWJzVzE2?=
 =?utf-8?B?amZGOW04eUFvUWZvTE1TTWNETy9oUFplK0ZaZU1HTEcyWlV1bXlzMzNDUXUw?=
 =?utf-8?B?dzJscnRnQmNZZ2NyNTBubDZSWndTMTh3aWRCWWRGb0FKbE1WWlkrNkZhQ3dj?=
 =?utf-8?B?VkNsTVROVC9MSzBWSjdYZ2svQ3RDQUVwZ0YwaEkxWkpJMWJiM2NIbmVhb0Zy?=
 =?utf-8?B?aGU3U29DcmZ6eWdneWorRVF1SzJWTDkyaWNNbm56dUdZN21zSzRjTDNmUlQ3?=
 =?utf-8?B?QnJxUTBERWxydjBYalZqclArL1ZDdXNTV1NjWDJpak9wUlU2emFUWCt5aEdC?=
 =?utf-8?B?UXRpM1Rva3M2Y2tCVGtHMWNteDE4UFBtakNqSzAzcUcrWFR1T05KZFFYMDlF?=
 =?utf-8?B?VEJmVzlCM09vS2I3Rll1Tlp6Z2lGdU91M0N5TXRTYzNTNFp0QUQ3dUowTjFx?=
 =?utf-8?B?eFVYZmFlUmgyREFzeEJrbmEvRDBHaktlcllyMHZ3eEZrTVlVS01vOUxNbUhZ?=
 =?utf-8?B?VkNsbHJCMUtCSTV2NmpZTi9hYnhGaTNLVmV4d2ZrUXY5K3Vab2xhMytkZlNj?=
 =?utf-8?B?YUNQYVl2L3BGL2YxdVZTeURmQ25SeXJaMWh0ZG5vNWsycTlBb0ZoV3J6Mm5E?=
 =?utf-8?B?SExJTXJYTE9MeHFyZStiSUEwdXhnMEl1dGFCK2ZlV0JmbzFvdnNuZHVISmMv?=
 =?utf-8?B?Q2J1Z2xERWtHa1A4blFLMmdZeGZNd1djWVJOOVc0YW0rNWZDRkE4WDJ4TE1j?=
 =?utf-8?B?cW9qQ3hKclZlVm4yckF1WEZWcnRKN0gvbUhVNlRzZk1qM3NkREorbEVKNWcr?=
 =?utf-8?B?bkROdDJTTTVybWtEY0lNUWoxSE5ZYnRXVU5TVDJrOGVqWEVmMy9xNFVyWThv?=
 =?utf-8?B?RndWbldTS2ZTUDlWMSs2MDN2NnZkUmdncGZsVHlCQ2cwdzA2WnZrSzdSSU5K?=
 =?utf-8?B?K3ZEQzFkNThWb0dsQ0Z5ZUdHcmpic0FxdVYrdGdTVzRCOGNSbThBMm5ldkhw?=
 =?utf-8?B?MStKeFlpWTZBM2sxSGMrTlB1TTJCc1BaeGxJZDhjc1pxNmpoMU1yaHk1VGhN?=
 =?utf-8?B?Z1FYY2VTUHloSU5rdVlQN3NsVHZjWGdYUzVvUnAzbXV5Q1ZDWlZpMnZBeVAv?=
 =?utf-8?B?aW50dENFb1drU3YxNUs5bEIzWVVWSWxXSXJKRFZaK2RsYi93TlN6SzFDQndQ?=
 =?utf-8?B?aHhRTkJKRm1oRktOMCtQdjVKdGxKRTM4ZnozTWlGYWhQbGZ4QmwvbXFsWVJB?=
 =?utf-8?B?ZHVVR0I0U1RaVUVDNVFDUTdtY05ZMDNpb3hiVklqOGhxbGpBUE9WcTZhZXdE?=
 =?utf-8?B?WTBuUnZHZ3VjUCs2WHc0WjVGZlZVTkhUZzZ5aTZVTFF6cHIyeWJGa2trV2t2?=
 =?utf-8?B?M1ZqYjk2NFVYSys4Skswb2NKejJmbjE5RlNNWHI5bkYxd0dVYWRDSC83OFdU?=
 =?utf-8?B?bXgvZVo4MnJCak53amxPaFZVTGs5UHVHL3pQUytUSHRJZ0lOeU16bWZGS29Y?=
 =?utf-8?B?Zlc0Qklwc1NjbEk4ZnpEQXpHdDUyQWo2WDNUS3lqdDdUY1FockprQnROT1Zs?=
 =?utf-8?Q?EipAIu6necn7yklEN+ne1vVLl7yWjncR0KBUU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2NRWnpNSGhBSklnbmd2TzdvY203cE5jWk8xQmIvSUpRZlIxUXNHaFNncHM0?=
 =?utf-8?B?UG9YSU10cFEyd1h3d3U4eWxRencwT2lPWXVET096czJwMXVHV2JDK2RJN212?=
 =?utf-8?B?ME9RYng5ZmRaRHpwUVlxVklaaUdYUVpaYkZZVWxYeS9JQk84ZS9OZUpXR3dq?=
 =?utf-8?B?aEFWd1ZkdWJybmt1M08rUkRZZ1h0S1k2M1dZM2N6Y1NEUEhhZHdERGR4ZWpr?=
 =?utf-8?B?TlFGaUwxR0tmTEF4b1htS1dwV0VzY01CT1RpaXJoTUNJeEdsd2JjVUVVY05O?=
 =?utf-8?B?ZDJuM1JxWXRhL0o4TFkzazZBamhXUWVMczRwWTQwc2Y3MGxreXpQbVVMc3Ja?=
 =?utf-8?B?Q0xMYTlTRTBMUjdNSWN3dWR2T0dJaUdzTnViVlJmWC9TQlBocHV1eXg5dHM0?=
 =?utf-8?B?VkdzWVpTenhlN3ROODMzdWJQN2NXaDNoZE1LN3pMNTVnZThzcU95enltZ0k1?=
 =?utf-8?B?Wkd0UmxycmRLWHo3eE9CRG1lSGJVajd3M3BuN3BDYUc2UmRpMVRoeU8zOW00?=
 =?utf-8?B?RlVGaml0QlhYRTNGNmpuRzhaYWZMaTBkeStXeURrNE91QzloTkUvM2JFZEow?=
 =?utf-8?B?djlPejYrMTd3aUFXaENNcXhST2pvRzZwR0kraDQ5K2UxSE1Nc3NyR0JteGxl?=
 =?utf-8?B?djdoRDJNNVhOUzZNQzkvWjFRMlRNcHp3VmFrSWU0SXd1Zm9Vd05TYlBjdEZV?=
 =?utf-8?B?WE5oRjBOM3dzbEV0ZGNkK21IRjNWaVA1TDdGVzBxa21HRlhNb3kyekhybm55?=
 =?utf-8?B?Yy9uaXVBSFk2d3RuZXlUckNPSWVSTmdqN1luRXRSbGRBWlRGZzJ3T2dPN2s5?=
 =?utf-8?B?S1J0cHo0ajBFWEtGK2Q2Y0tnSVBNOEJ4Y0Era081ZExqN1IrZzB0N0JtV1c5?=
 =?utf-8?B?N2NkNWVHcFcrdnZHZzAxbjhNQ2ZobU5XK0EzNE9GMEZYUGNHNEcwVERoSnhh?=
 =?utf-8?B?Y3dmdWs5ZXJ1SGZDY0xxQ0FQQkJQdFNmdkh4UzNaVmpUeG9NWlcyL2NYZU50?=
 =?utf-8?B?VFZuR3VGekt1NHprN1A3dmxJQUZmYWt2ajhDeFc0d0w0STc4dHRPdHlJaGY0?=
 =?utf-8?B?dEFlOUdOZkc2M3RBU29XcVJzbjFUMWN2S2UzcWppckI1eTcwbmR5c1doRnpp?=
 =?utf-8?B?MUVnMEJRM3VpN0Z4ZDFLaGs3NFNqSk5Ma2JMSElPL1d0SHpxM0gzZW1iVGQr?=
 =?utf-8?B?dyt3VDRGajFTd1ltRnFvZGFaWUtraWg3ZjlKMytoYXgwMnluRmJ6V3VIWlRV?=
 =?utf-8?B?bmFTbnJRVlVZNEl3Z2M5c04xOFNMSnZJSmV3MDZrak5pYzVnVjd0ZWZxb0Y3?=
 =?utf-8?B?S1UwcjlqT2lwbjJUcE1zSEVjdVNrNHRiS2NRTHA3TVdvdmdGT1lNaVpNN3BO?=
 =?utf-8?B?M25MSm9KRGdQZlB0TVN2VnlkNHBsV0lWT21LdXdjcmR2MWwwNWE3Y2hvM2hJ?=
 =?utf-8?B?WWVvUzM4Z29USlFXdjJYejlscUdGVFZCNm1TWFNERTIyM29GNXg1ZktyajJr?=
 =?utf-8?B?VGIzb29laUp6aW9KSjArc3Z4R0hRbHo5dUM1ajlDRUVVWVE1TDRrQlBrTzlr?=
 =?utf-8?B?bWNOZ2tkQVMyeWg5c3huVEI4WDJYNldsVUd2UVVKWUFmUTJXRVpLSUE3M2po?=
 =?utf-8?B?VXIwcFVRdW5MdXNVWUhHWEJJeVUvYmwyaHNuNTQ4NW1sd2FQQXg5V3pSSGZ3?=
 =?utf-8?B?L2N6UXVDbk54MFQ3RTJXb1dXWlRPTEdDTnBMNkp1RzZON1RvSzdaZHNSTXRk?=
 =?utf-8?B?TThzdmpVcm9uZDE4ZzF2YzBNNVVJNUVSUUV1by9Ga0R0WnUzdWFGd1RWSkRp?=
 =?utf-8?B?Zk9ocFpOa1VhU29SbkJYQzYrOVJBYkNvbDRWbnpJbVZIcXJqc2tvQjRBYTUx?=
 =?utf-8?B?b01ndmt1RTdaRTNVaUtnR25iNXlIbTlwSXVQZkt4YkdZTjlYYThzZ004VGZU?=
 =?utf-8?B?aXpoRGkwT21UaHd1azVaTVE0TFlaOVJvTWVXcm5yU2RLZktRQTVqVGd3U0wr?=
 =?utf-8?B?bzgxOTcxcXR3K3huZjZIemNlTzYwbVVyaDJEbHZqVTdJNU0wMnBQNHJyOTlW?=
 =?utf-8?B?bWk1QU9Ka3BVSGZXd0RhaTNZNDNuU0RiYXdnS3RycEMra1RjVWZidlIzUjMv?=
 =?utf-8?Q?3mDWwZ87VlMJs002VyvOpbFqJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a81ba9-eeed-47cc-124e-08dc98c34e99
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2024 05:12:58.4395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uDNN4JQPZkK4s7XHrhjPBPo1d0rM2Gj6mJuJqSJdCcX6YglD88UVsIq4FPdmjiATSJ5h8ymACuv6KPwnavGTXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5092
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFtaHl1bmcgS2ltIDxu
YW1oeXVuZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgSnVuZSAyNywgMjAyNCAxOjMy
IFBNDQo+IFRvOiBXYW5nLCBXZWlsaW4gPHdlaWxpbi53YW5nQGludGVsLmNvbT4NCj4gQ2M6IElh
biBSb2dlcnMgPGlyb2dlcnNAZ29vZ2xlLmNvbT47IEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbw0K
PiA8YWNtZUBrZXJuZWwub3JnPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3Jn
PjsgSW5nbyBNb2xuYXINCj4gPG1pbmdvQHJlZGhhdC5jb20+OyBBbGV4YW5kZXIgU2hpc2hraW4N
Cj4gPGFsZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb20+OyBKaXJpIE9sc2EgPGpvbHNh
QGtlcm5lbC5vcmc+OyBIdW50ZXIsDQo+IEFkcmlhbiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+
OyBLYW4gTGlhbmcgPGthbi5saWFuZ0BsaW51eC5pbnRlbC5jb20+Ow0KPiBsaW51eC1wZXJmLXVz
ZXJzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgVGF5bG9y
LCBQZXJyeQ0KPiA8cGVycnkudGF5bG9yQGludGVsLmNvbT47IEFsdCwgU2FtYW50aGEgPHNhbWFu
dGhhLmFsdEBpbnRlbC5jb20+OyBCaWdnZXJzLA0KPiBDYWxlYiA8Y2FsZWIuYmlnZ2Vyc0BpbnRl
bC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYxNCAwLzhdIFRQRUJTIGNvdW50aW5n
IG1vZGUgc3VwcG9ydA0KPiANCj4gT24gV2VkLCBKdW4gMjYsIDIwMjQgYXQgMDY6MTc6MjJQTSAr
MDAwMCwgV2FuZywgV2VpbGluIHdyb3RlOg0KPiA+DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBOYW1oeXVuZyBLaW0gPG5hbWh5dW5nQGtlcm5lbC5v
cmc+DQo+ID4gPiBTZW50OiBXZWRuZXNkYXksIEp1bmUgMjYsIDIwMjQgMTA6NTkgQU0NCj4gPiA+
IFRvOiBXYW5nLCBXZWlsaW4gPHdlaWxpbi53YW5nQGludGVsLmNvbT4NCj4gPiA+IENjOiBJYW4g
Um9nZXJzIDxpcm9nZXJzQGdvb2dsZS5jb20+OyBBcm5hbGRvIENhcnZhbGhvIGRlIE1lbG8NCj4g
PiA+IDxhY21lQGtlcm5lbC5vcmc+OyBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5v
cmc+OyBJbmdvIE1vbG5hcg0KPiA+ID4gPG1pbmdvQHJlZGhhdC5jb20+OyBBbGV4YW5kZXIgU2hp
c2hraW4NCj4gPiA+IDxhbGV4YW5kZXIuc2hpc2hraW5AbGludXguaW50ZWwuY29tPjsgSmlyaSBP
bHNhIDxqb2xzYUBrZXJuZWwub3JnPjsgSHVudGVyLA0KPiA+ID4gQWRyaWFuIDxhZHJpYW4uaHVu
dGVyQGludGVsLmNvbT47IEthbiBMaWFuZyA8a2FuLmxpYW5nQGxpbnV4LmludGVsLmNvbT47DQo+
ID4gPiBsaW51eC1wZXJmLXVzZXJzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgVGF5bG9yLA0KPiBQZXJyeQ0KPiA+ID4gPHBlcnJ5LnRheWxvckBpbnRlbC5j
b20+OyBBbHQsIFNhbWFudGhhIDxzYW1hbnRoYS5hbHRAaW50ZWwuY29tPjsNCj4gQmlnZ2VycywN
Cj4gPiA+IENhbGViIDxjYWxlYi5iaWdnZXJzQGludGVsLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJl
OiBbUkZDIFBBVENIIHYxNCAwLzhdIFRQRUJTIGNvdW50aW5nIG1vZGUgc3VwcG9ydA0KPiA+ID4N
Cj4gPiA+IE9uIE1vbiwgSnVuIDI0LCAyMDI0IGF0IDA2OjIwOjE2UE0gLTA0MDAsIHdlaWxpbi53
YW5nQGludGVsLmNvbQ0KPiB3cm90ZToNCj4gPiA+ID4gRnJvbTogV2VpbGluIFdhbmcgPHdlaWxp
bi53YW5nQGludGVsLmNvbT4NCj4gPiA+ID4NCj4gPiA+ID4gQ2hhbmdlcyBpbiB2MTQ6DQo+ID4g
PiA+ICAtIEZpeCB0aGUgcHl0aG9uIGltcG9ydCB0ZXN0IGZhaWx1cmUuIFdlIGNhbm5vdCBzdXBw
b3J0IFBZVEhPTl9QRVJGDQo+ID4gPiBiZWNhdXNlIGl0DQo+ID4gPiA+ICB3aWxsIHRyaWdnZXIg
YSBjaGFpbiBvZiBkZXBlbmRlbmN5IGlzc3VlcyBpZiB3ZSBhZGQgaW50ZWwtdHBlYnMuYyB0byBp
dC4gU28sDQo+ID4gPiA+ICBvbmx5IGVuYWJsZSB0cGVicyBmdW5jdGlvbnMgaW4gZXZzZWwgYW5k
IGV2bGlzdCB3aGVuIFBZVEhPTl9QRVJGIGlzIG5vdA0KPiA+ID4gPiAgZGVmaW5lZC4NCj4gPiA+
DQo+ID4gPiBJIHRoaW5rIGl0J3MgZWFzaWVyIGlmIHdlIGhhdmUgSWFuJ3MgcHl0aG9uIGJ1aWxk
IGNsZWFudXAgZmlyc3QuDQo+ID4gPg0KPiA+ID4gICBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC1wZXJmLXVzZXJzLzIwMjQwNjI1MjE0MTE3Ljk1Mzc3Ny0xLQ0KPiA+ID4gaXJvZ2Vyc0Bn
b29nbGUuY29tDQo+ID4gPg0KPiA+ID4gTGV0IG1lIHRha2UgYSBsb29rIGF0IGl0Li4NCj4gPg0K
PiA+IE9rLCBJIHdpbGwgaG9sZCB0aGUgY21kIG9wdGlvbiBuYW1lIHVwZGF0ZSB1bnRpbCB3ZSBj
b25jbHVkZSBvbiB0aGlzIG9uZS4NCj4gPiBUaGFua3MgYSBsb3QhDQo+IA0KPiBQbGVhc2UgdGFr
ZSBhIGxvb2sgYXQgdGhlIGN1cnJlbnQgcGVyZi10b29scy1uZXh0IGJyYW5jaC4NCg0KSGkgTmFt
aHl1bmcsDQoNClRoZSBweXRob24gaW1wb3J0IHRlc3Qgd29ya3MgY29ycmVjdGx5IHdpdGggdGhl
IGxhdGVzdCBwZXJmLXRvb2xzLW5leHQgYnJhbmNoIA0Kd2l0aG91dCB0aGUgY2hhbmdlIEkgYWRk
ZWQgaW4gdjE0LiBJIHdpbGwgc2VuZCBhIG5ldyB2ZXJzaW9uIHRoYXQgcmV2ZXJ0cyB0aGlzIA0K
Y2hhbmdlIGFuZCB1cGRhdGUgdGhlIGNvbW1hbmQgbGluZSBvcHRpb24uIElzIHRoZXJlIGFueSBv
dGhlciBjaGFuZ2VzIHlvdSdkDQpsaWtlIG1lIHRvIGFkZD8NCg0KVGhhbmtzLA0KV2VpbGluDQoN
Cj4gDQo+IFRoYW5rcywNCj4gTmFtaHl1bmcNCj4gDQoNCg==
