Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4D618E02A;
	Tue, 10 Jun 2025 03:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749525657; cv=fail; b=cmtT2FFA/5pqRCbJgUq8q3D7Kv8xibUrWYsw7nvHJnslaYN7TNQ8UIUjcKmhLwLmADDAHf3KP74yo2GZlz+IvIeYlMwU8Epi4rH58eiEMlJWomFaZAFKv/9PeRxxa/XG6ZJ3wP2G5NodpE6Y04eEMoiZQkIT19STfImpz1sknso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749525657; c=relaxed/simple;
	bh=RaeFFBFPH76VvOvx4t/aSAyf8sKc3cRjUFQQowr0IgY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MMFsWSPm4dgoo89uciuVXqYSTimhpHfdT3Zj8xTbAYUG6yYlS9ozgKel1T8yUayqoIwiCXPFMwi5p/XNiJIs3Wh0CYpFUP4HqJVC4bYauCwwEPdwjVMSeDiof5DCBGbtU6Ma+Tgw7zDFFmD5+21mdCVvOKOrMuNB4mnHXgyvKuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g4vu+ymE; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g4vu+ymE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749525656; x=1781061656;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RaeFFBFPH76VvOvx4t/aSAyf8sKc3cRjUFQQowr0IgY=;
  b=g4vu+ymE11JB+SyDxMrUFS1TbeOYo4zg/PA96FUC2W4NKfNnh/HjMk08
   F4uuP3EXOAUEwllqHfsaDEsph/5H5gEgGckuAv4Ef9gsjoL+hKR3Lr+HA
   3Cxfe1bYjodcJsqRh4iPbN3+AK4LBojqO4InJQiIT95HwgfZzjF40lNrG
   yYOcEigxtdktT7gwWOkpcc0FEv/HXD3GP2PEISlYB6s2FHxpj3Mq8oJv6
   YLLGWLdDM+cLOrXmOYklvnr3kcdBXSa0WKiiBWYP+0bI5noIpPyAY7rZy
   JXcO1/aVOwo2PG7tb7Tps/NEVSKchZalJlKJPbIcmVmt6+l24ia7kWe2F
   Q==;
X-CSE-ConnectionGUID: a9veqmvBRH6K/SeU8Bvbqg==
X-CSE-MsgGUID: Ab2ynfruR2WIzHxRs+Di2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="55284575"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="55284575"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 20:20:54 -0700
X-CSE-ConnectionGUID: k1gLhLWPR+yg3wd+/OhatQ==
X-CSE-MsgGUID: riUj5RAuRFixj2HaS+deoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="150545679"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 20:20:43 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 20:20:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 20:20:41 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.54) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 9 Jun 2025 20:20:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CN7QovVwz0fyCLo2UVAcXe7vC2BCDReYi2HzZbQQwU3GLXDSKM6wYQbr1CQ1LKC1cDwm09Sh6y7PBmvqb0QOt5KShllDr6ILzZ3+ULSBs6PnFGEmutWNrzh93PTO43GAPK9But+p+iW4zm+8/Egu1HA7JR3xLhQuepH4l9wOWZVHEQ6Z3fQaVBAxBPQFhHI2UprtBmUb+QPGSDf4Q4hFkorN4HnEhvJGkM+SBJnBfHKVg4OoLhQcVZWUPHEgqmSnKKQoPs4NY8Q2GgUfL0XtMFPm7WeKUvreerdQUzPNrDcol6MdpboZ+ab1tHzIo0IjO8vh0UQKVeQl3TG9oOIfzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaeFFBFPH76VvOvx4t/aSAyf8sKc3cRjUFQQowr0IgY=;
 b=vB3fFa6pRpwY0qdnNHP4NHhyPcHF3/9+NBnrCcySdTu63OgcrnTy88fXRjpM0cCO3mL9wpJP5n1QBcNYiL91NUhHTGDWyCIenEV3wGR+xHcOk31MqFwhae7pmXncKTVxDa3aP7rUFb0t0yAPhD1V9LHIG0OSRqNvdaRmcd+qNkeJdTk3Q51MPpUdY3ashWqM2U6kVh5jlR+rHsIpbWJeR00vtygBuprxviZyU+ScWbma/3QkaqcgPUwnduLW5OF1m5+H73Ke7Jl6EcK/TA123kfpUsnrGCKSSDz3bwvK6YYw3bCkBuC0A5nzJ+uGtPR6oKTUYbalEYXfg6HSclJCeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB8289.namprd11.prod.outlook.com (2603:10b6:303:1e8::9)
 by IA4PR11MB9444.namprd11.prod.outlook.com (2603:10b6:208:563::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 10 Jun
 2025 03:20:25 +0000
Received: from MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022]) by MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022%7]) with mapi id 15.20.8769.029; Tue, 10 Jun 2025
 03:20:25 +0000
From: "Li, Tianyou" <tianyou.li@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, "Hunter, Adrian" <adrian.hunter@intel.com>, Kan
 Liang <kan.liang@linux.intel.com>, "Guo, Wangyang" <wangyang.guo@intel.com>,
	"Deng, Pan" <pan.deng@intel.com>, "Zhou, Zhiguo" <zhiguo.zhou@intel.com>,
	"Chen, Tim C" <tim.c.chen@intel.com>, "tim.c.chen@linux.intel.com"
	<tim.c.chen@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Minor improvements for perf script flamegraph
Thread-Topic: [PATCH] Minor improvements for perf script flamegraph
Thread-Index: AQHb1E83ycKiU8/HG02/fZP5p8fCjbP7ouiAgAAhEcA=
Date: Tue, 10 Jun 2025 03:20:25 +0000
Message-ID: <MW4PR11MB8289E9BDA297E0AFE6075EC1956AA@MW4PR11MB8289.namprd11.prod.outlook.com>
References: <20250603071048.180674-1-tianyou.li@intel.com>
 <aEeIN_u4KpLZXDBx@google.com>
In-Reply-To: <aEeIN_u4KpLZXDBx@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB8289:EE_|IA4PR11MB9444:EE_
x-ms-office365-filtering-correlation-id: f0207537-4d9e-4b76-f77e-08dda7cdbde3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TTEvSzY1VEdKYWJXekZYU2NEWXo5eURadnRXT25UL3JaeUIvK1FwR0J3MGQz?=
 =?utf-8?B?Tk85cHpnTVNleS9oRXJ0WEwyaHdMUnkzZWViSFhtNVJWVUJuOEovMHVycUtu?=
 =?utf-8?B?aWNHTFVpNm1NQmdGRUNrVGRVcFd2RnRndXFDaDA0WWMxVmhmL2FMc1JKT3dr?=
 =?utf-8?B?LzJaUFB1NFRNVTJTaFpVVzB0d1JsRGZkeU9WV1dxSHBpTEZHaFp6bXI4WWRB?=
 =?utf-8?B?RTFNL29Ld203MWVaeHF1MkZlb2NKSmNUL05UTzlGZmFNMi8rQzBIOGNWYkRN?=
 =?utf-8?B?SjNYYkNLWm5VdnBrNmRWdTEzODVBZ2k5RUUzai9ULzA5T1F0QUozbUdiRHcz?=
 =?utf-8?B?WVNqYmI5WUhKM3lyc2pLdHlFNlVjZXdnNlEyRkhrbGpQRWtUakZNOHZjMkNF?=
 =?utf-8?B?THBaZnNzY1pNSEw2SUNQNVN4cDNsNFFYSXRhK2E3WFMvei9CQnhuWndTTXkr?=
 =?utf-8?B?Y1Q3MkFWa1czR2dpZFNVSGRoazV4YzNGUjZ1NEJqMXlZbGtsZlNHT2pKUlFT?=
 =?utf-8?B?UFB5c0Jtd091MUdiTWtjWnVuZE1NR3B4bU5QZ3JZcHBmUG4yMitPNWFqblh6?=
 =?utf-8?B?SVJqa1AwanFSYUVlaEJFUGwvbUZOUmJONnZEL2hKbCtTKzRteGMwQjkxVmMw?=
 =?utf-8?B?Tk5qa2wzdU9wd0p6MVFIckdCalNBYTdWVEk3V3FRbWM5TURNSG5HM2hrYjEy?=
 =?utf-8?B?dStjL1FueUgveXVLQ2U5QmZxVnhENzByNjB4azJnNUh6bzk1bkkra3FCWm1l?=
 =?utf-8?B?MWNEdm8zWmhWWkdrcnlhd2hheWZONExKSGFlNWJhcEtpb3RPZHRKanBTd2Rx?=
 =?utf-8?B?LzVKNDVLdlkxK2s1YWxLZE5IdSs5ZCsrZUV5bW9TS29pdERsVGZjZGlXVzg2?=
 =?utf-8?B?RkxlTXN5dWpoUHhrT1Fsc3NueHFVUTdsM0RDWThtV0NnM1JRNzFHV2drNktq?=
 =?utf-8?B?b3NLVlF3Wi9UdnZ4R2NwbXNCdTdVSzVwcDd5R2tiNzRxSk05bkhKZENNTzJl?=
 =?utf-8?B?ak1UbUNMQ3A0Ykt4MW5NNUJVcnp0ZUJTWktVa3hCUnpUclUrMkMwZGZQcnNx?=
 =?utf-8?B?OHd3a09NUUV3Rlg4WGNvSXJUN1ZlbFB1ZWRNSzhmUFFZWTkrVzc2aG1Sb0JJ?=
 =?utf-8?B?cHNsZmMzUGtWT1pSemNRZ29KenhGWVZtWU9iVlFsWmhuakxwaDNJOXQxZWQw?=
 =?utf-8?B?R1o3SnJreUkxZFZjLzZJL0NRQWRmZWlRVWp3eG9ocFlROFhYbTBmSFhDelRP?=
 =?utf-8?B?YXVXcldTVCtkRmlaTThSZUtqTVpDb3R3K2FuUkFkdk5Tckp4TEc1MDE4VzVx?=
 =?utf-8?B?QzU5bGF0dGFTTjR3a0xxZjRpY1JyZWI3ZFNKdm5vTlplZWpnZjY3dlp2dW1X?=
 =?utf-8?B?Y0RCdS9EY1E0cDNNUVZGdEY4U3FzeDFTdTRxZUQ2SVpxMXBsaUlCSmV4NEJr?=
 =?utf-8?B?US9SdVRMYWlVajNDaEY2U09PUmxpWnlBYjVJNWJFNHBJVW9TTG5odndGN2JI?=
 =?utf-8?B?bms2TStZVGtiY2xaWWkxaFk5L2svOEdSTnBjL1NjalNsNXg1b2tpQURSR1Nj?=
 =?utf-8?B?Ky9KVGVaaVhLcFpqUy9FZ1NCdkZkWVYxK0FyZmtnWU9oTXJuYVRiZkZnejZP?=
 =?utf-8?B?Wkg4L0lkWFR1VEk0cDMyTDY5YXJtRTJJL2dKZlcyeGZKM1lKd3VBeVpOMWhN?=
 =?utf-8?B?TDZtcFJaWDlQNW1haGtUMitnTTdLYi9xT1VIL2lFbUw1L3A0OVBVNW80b3VI?=
 =?utf-8?B?bktjd2tyYVovblpFNmdtYkFIZk1uc2dBRFo4M1QwQ2dNWTVxTkg1dXo2Wksz?=
 =?utf-8?B?WEtlU1pjczU0a2ZtWFd5OU55c3ptUEtGQ09tKzRIclpHTlhtM1VZVXZjK3lD?=
 =?utf-8?B?YXJMbzEzTGpOWDJCQW5aK0E0OW5KYVlWS2hYSEZIaXZVWDZtdFNjbUlQcmFh?=
 =?utf-8?B?Zjk4dk5QVjZtWloybmpOL3hlOUY4b1FDTXlWcENGNnlaYmpjMjlyTkJlSVRU?=
 =?utf-8?B?UlVjd1RLMmRnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB8289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SU9yaEM4K1ZhTkpjZlF0VDlxaWtIZmNabVI0S0pxaWV2djFXc1YxZnlDQ0JZ?=
 =?utf-8?B?ZHd2elpuMjJnSW5mSXpDTTcxclVkRjcvUUgybzlNNW93SW8wajVBU0VCUEJK?=
 =?utf-8?B?emZ0WUtpcml6eGFPb2RhRUNZTmQrOXBkeFYzM0JIOUl6U2hqSzI0bks0Zkkv?=
 =?utf-8?B?YVZEZzhlWVBWWDdjVEFGVVZ0dHhSS2F0c01PN1ViSE5XcDlmaHJqU0tGcjB2?=
 =?utf-8?B?RHc4aTZHZk9IVk91NVVIbGUyREx5ZzlEZnBoMTJQbnIxMHVpYml4VkxST05L?=
 =?utf-8?B?TTVncExVdThiakxZbnhBWkNWVE93cUVwOGpOR09XcG5yeXJRU2hzb3YrS05Y?=
 =?utf-8?B?bm1sT3phN05hRTlvaFd3RWdmcXdBeHNFWXBpYmVxZEYrOTA2cnVaWHplQkYx?=
 =?utf-8?B?NHZkeGtmUEltNmJpK1hpMTNBZW5zZnFEQ3o5TVdUSGExUVhmRG1DY20zVkJK?=
 =?utf-8?B?d2RScy9sSEdsZTdxNGl2cUhtZFdBOFVuc2VVV2N4WW9VcGFKNEtJUUhOdmJN?=
 =?utf-8?B?TmlIN3NWQU9qZEpQQUFiVTZySUZvMGUzb3hMSllrdlB5NzczVEhlOXdKQlBX?=
 =?utf-8?B?Y1NaamNGMDY3bjY1aEhLOGxYbUhFelAyL2FRWkNqditkV0JmT3V2clk1cmRV?=
 =?utf-8?B?TVdLUEFndlpIdkRORVNHSGpRVVFKZW9UQUY2NWd3d2M4RTh5L09uNm9ZQlpq?=
 =?utf-8?B?YXBPZStLc2lsK3hQTEhGSzNEcjZMZkgyaU5QMmI2aDI1SnlKRkc4VENBSjZk?=
 =?utf-8?B?RXl3N3E2WGFDclJRNWEzTzRDemMwSyswbW53QmxJRE05dDNJaFBmajBjK3BO?=
 =?utf-8?B?N3FsK1NMYVV4OHNsaEpSclVqYjVXdmM3ZXQwQm85bFRNdDB2MFY4K056M0pa?=
 =?utf-8?B?WjdSaE1sUUVYTHNYU0MvalFWdzYxeVVnMzhCM1UrcjJyV3dEaEFBeERDT1cx?=
 =?utf-8?B?L3RxRVl4elg0ZThJRWNESzJpSUY0QndQdEc1R1B5bXpCOGlWaVBxaHhQZzg0?=
 =?utf-8?B?bmNudkhLV1d0NUJaZkFBVEpSVHhMaTRaWEZRT2QwZ01DVDkrR25uL0RhaHBv?=
 =?utf-8?B?WXI3bXNzU3hxWFlObVB1UnBaWWUvMzFyZzNLZUVDdFAwbzZkTmVGS1NscCtu?=
 =?utf-8?B?QXluUWQvS0pPYVJzU0tUR1pBb21zQ3pSVXFWdE1ERWlOVFBhTElTQ2ZQYVJs?=
 =?utf-8?B?TkowZktRYXRGVDZyREw1NGFiWE9xNlpmcmRJMzVNUTFpL3N4SnZ2YlUvY01X?=
 =?utf-8?B?QXNQVkFoWGFocFllcHA2OFIwQndlN2dGNlBTY0lRMkV6SUF4SlFOYk00TWJY?=
 =?utf-8?B?V1dVQ2hEa3VHMFNYZmFSdEV5ZEZQRjFOSVYzd1pydHB3UmgyMGxLRlUwRmJ4?=
 =?utf-8?B?c3FQTStpb3VaVE9XdThvN1ZqRXhMZmtNMmJRSXlEZVZDWERyY3ZFZm4xbGFZ?=
 =?utf-8?B?bFFQUEFIRWFCYy9rYWJubFVkVDQzbHB0NEI2TXhjZUc0dzdUZEhCaUpQWWs5?=
 =?utf-8?B?bDdYSzhKUS92YW15bVdJRVpzbkRaM3VoaTVSUnJQRXF5WlRYaWJOcG56d05a?=
 =?utf-8?B?YzRwQUNFTytGMjdGekRqTDNZRURTKzdRTkY1ZlZjY3FDM2paMWhnOTArbC9X?=
 =?utf-8?B?aVV0TWVvS25OaWt2cjFyTWhNUVR2SFJJSFpVRXVKVDQ3Q1orazFhTEU4NThw?=
 =?utf-8?B?RU5JZjNHc3M4cmNxNW5pT25hN3VhUDhjZjl2WUNXN0wvQVZRSWtyNVd4VCtV?=
 =?utf-8?B?QURJZGhrSVhKVlc4V3BTSXc0NHVLc0hTdUV2TVlVVHJ4Y0FNQVlLbWkzdDJx?=
 =?utf-8?B?cDBCb051cDBnLzB3bjFCbS9DNjZ5SWlDOS83QzJPMW9hekQ2T3gvajc1SlJL?=
 =?utf-8?B?T3RjZU85RFpjTW43YmJYOEZ3THdkL0ZKN3diTFN5aHlqbC83eTdLQzhETmRC?=
 =?utf-8?B?SnlscE4yeEtFb3ZUOTQxWWNkOUN2VjFTampMY0IxWUFGR1BXa2hIOUdMQzNP?=
 =?utf-8?B?eVpyR0tPdXdRNktGL29GcDQxeUxXaXFnT0h5c3VEYk9aRGZVT1BySW5jY1J0?=
 =?utf-8?B?bVVMWURnWEN6VnZIUmdOak1WT0FCUDIwRUtTV1ZEekMxT0wzWHdaNUx3STdU?=
 =?utf-8?Q?Xv3pXuSZIZ2GaJfXnNeSbdkQZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB8289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0207537-4d9e-4b76-f77e-08dda7cdbde3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2025 03:20:25.1934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AwJ55I17oLdLPgx8oi59+vu9cJ2XtJKKPW6AWw7rN8LxzzlCej0aX615rsskJZg6JL03t/lLNhfYY7YFlevq8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9444
X-OriginatorOrg: intel.com

SGkgTmFtaHl1bmcsDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcgYW5kIHN1Z2dlc3Rpb25zLiBJ
IGhhdmUgc3BsaXQgdGhlIHBhdGNoIGludG8gdHdvIHBhdGNoZXMuIFBsZWFzZSBsZXQgbWUga25v
dyBpZiBhbnl0aGluZyBlbHNlIGlzIG5lZWRlZC4gVGhhbmtzLg0KDQpSZWdhcmRzLA0KVGlhbnlv
dQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTmFtaHl1bmcgS2ltIDxuYW1o
eXVuZ0BrZXJuZWwub3JnPiANClNlbnQ6IFR1ZXNkYXksIEp1bmUgMTAsIDIwMjUgOToyMCBBTQ0K
VG86IExpLCBUaWFueW91IDx0aWFueW91LmxpQGludGVsLmNvbT4NCkNjOiBQZXRlciBaaWpsc3Ry
YSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBJbmdvIE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT47
IEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbyA8YWNtZUBrZXJuZWwub3JnPjsgTWFyayBSdXRsYW5k
IDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47IEFsZXhhbmRlciBTaGlzaGtpbiA8YWxleGFuZGVyLnNo
aXNoa2luQGxpbnV4LmludGVsLmNvbT47IEppcmkgT2xzYSA8am9sc2FAa2VybmVsLm9yZz47IElh
biBSb2dlcnMgPGlyb2dlcnNAZ29vZ2xlLmNvbT47IEh1bnRlciwgQWRyaWFuIDxhZHJpYW4uaHVu
dGVyQGludGVsLmNvbT47IEthbiBMaWFuZyA8a2FuLmxpYW5nQGxpbnV4LmludGVsLmNvbT47IEd1
bywgV2FuZ3lhbmcgPHdhbmd5YW5nLmd1b0BpbnRlbC5jb20+OyBEZW5nLCBQYW4gPHBhbi5kZW5n
QGludGVsLmNvbT47IFpob3UsIFpoaWd1byA8emhpZ3VvLnpob3VAaW50ZWwuY29tPjsgQ2hlbiwg
VGltIEMgPHRpbS5jLmNoZW5AaW50ZWwuY29tPjsgdGltLmMuY2hlbkBsaW51eC5pbnRlbC5jb207
IGxpbnV4LXBlcmYtdXNlcnNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBNaW5vciBpbXByb3ZlbWVudHMgZm9yIHBlcmYg
c2NyaXB0IGZsYW1lZ3JhcGgNCg0KSGVsbG8sDQoNCk9uIFR1ZSwgSnVuIDAzLCAyMDI1IGF0IDAz
OjEwOjQ4UE0gKzA4MDAsIFRpYW55b3UgTGkgd3JvdGU6DQo+IFdoZW4gcHJvY2Vzc2luZyB0aGUg
cGVyZiBkYXRhIGZpbGUgZ2VuZXJhdGVkIHdpdGggbXVsdGlwbGUgZXZlbnRzLCB0aGUgDQo+IGZs
YW1lZ3JhcGggc2NyaXB0IHdpbGwgY291bnQgYWxsIHRoZSBldmVudHMgcmVnYXJkbGVzcyBvZiBk
aWZmZXJlbnQgDQo+IGV2ZW50IG5hbWVzLiBJZiBzcGVjaWZ5IHRoZSBwZXJmIGRhdGEgZmlsZSB3
aXRoIC1pIG9wdGlvbiwgdGhlIHNjcmlwdCANCj4gd2lsbCB0cnkgdG8gcmVhZCB0aGUgaGVhZGVy
IGluZm9ybWF0aW9uIHJlZ2FyZGxlc3Mgb2YgdGhlIGZpbGUgbmFtZSANCj4gc3BlY2lmaWVkLCBp
bnN0ZWFkIGl0IHdpbGwgdHJ5IHRvIGFjY2VzcyB0aGUgcGVyZi5kYXRhLg0KPiANCj4gVGhpcyBw
YXRjaCB0cmllcyB0byBhZGQgYSAtZSBvcHRpb24gdG8gc3BlY2lmeSB0aGUgZXZlbnQgbmFtZSB0
aGF0IHRoZSANCj4gZmxhbWVncmFwaCB3aWxsIGJlIGdlbmVyYXRlZCBhY2NvcmRpbmdseS4gSWYg
dGhlIC1lIG9wdGlvbiBvbWl0dGVkLCANCj4gdGhlIGJlaGF2aW9yIHJlbWFpbnMgdW5jaGFuZ2Vk
LiBJZiB0aGUgLWkgb3B0aW9uIHNwZWNpZmllZCwgdGhlIGhlYWRlciANCj4gaW5mb3JtYXRpb24g
d2lsbCBiZSByZWFkIGZyb20gdGhhdCBmaWxlLg0KDQpMb29rcyBsaWtlIHR3byBzZXBhcmF0ZSBj
aGFuZ2VzLiAgQ2FuIHlvdSBwbGVhc2Ugc3BsaXQgdGhlbT8NCg0KVGhhbmtzLA0KTmFtaHl1bmcN
Cg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVGlhbnlvdSBMaSA8dGlhbnlvdS5saUBpbnRlbC5jb20+
DQo+IFJldmlld2VkLWJ5OiBQYW4gRGVuZyA8cGFuLmRlbmdAaW50ZWwuY29tPg0KPiBSZXZpZXdl
ZC1ieTogWmhpZ3VvIFpob3UgPHpoaWd1by56aG91QGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6
IFdhbmd5YW5nIEd1byA8d2FuZ3lhbmcuZ3VvQGludGVsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFRp
bSBDaGVuIDx0aW0uYy5jaGVuQGxpbnV4LmludGVsLmNvbT4NCj4gLS0tDQo+ICB0b29scy9wZXJm
L3NjcmlwdHMvcHl0aG9uL2ZsYW1lZ3JhcGgucHkgfCAyMSArKysrKysrKysrKysrKysrKysrLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvc2NyaXB0cy9weXRob24vZmxhbWVncmFwaC5weSAN
Cj4gYi90b29scy9wZXJmL3NjcmlwdHMvcHl0aG9uL2ZsYW1lZ3JhcGgucHkNCj4gaW5kZXggY2Y3
Y2U4MjI5YS4uZWI3OGI5MzkyNSAxMDA3NTUNCj4gLS0tIGEvdG9vbHMvcGVyZi9zY3JpcHRzL3B5
dGhvbi9mbGFtZWdyYXBoLnB5DQo+ICsrKyBiL3Rvb2xzL3BlcmYvc2NyaXB0cy9weXRob24vZmxh
bWVncmFwaC5weQ0KPiBAQCAtOTQsNiArOTQsMTEgQEAgY2xhc3MgRmxhbWVHcmFwaENMSToNCj4g
ICAgICAgICAgcmV0dXJuIGNoaWxkDQo+ICANCj4gICAgICBkZWYgcHJvY2Vzc19ldmVudChzZWxm
LCBldmVudCk6DQo+ICsgICAgICAgICMgaWdub3JlIGV2ZW50cyB3aGVyZSB0aGUgZXZlbnQgbmFt
ZSBkb2VzIG5vdCBtYXRjaA0KPiArICAgICAgICAjIHRoZSBvbmUgc3BlY2lmaWVkIGJ5IHRoZSB1
c2VyDQo+ICsgICAgICAgIGlmIHNlbGYuYXJncy5ldmVudF9uYW1lIGFuZCBldmVudC5nZXQoImV2
X25hbWUiKSAhPSBzZWxmLmFyZ3MuZXZlbnRfbmFtZToNCj4gKyAgICAgICAgICAgIHJldHVybg0K
PiArDQo+ICAgICAgICAgIHBpZCA9IGV2ZW50LmdldCgic2FtcGxlIiwge30pLmdldCgicGlkIiwg
MCkNCj4gICAgICAgICAgIyBldmVudFsiZHNvIl0gc29tZXRpbWVzIGNvbnRhaW5zIC91c3IvbGli
L2RlYnVnL2xpYi9tb2R1bGVzLyovdm1saW51eA0KPiAgICAgICAgICAjIGZvciB1c2VyLXNwYWNl
IHByb2Nlc3NlczsgbGV0J3MgdXNlIHBpZCBmb3Iga2VybmVsIG9yIA0KPiB1c2VyLXNwYWNlIGRp
c3RpbmN0aW9uIEBAIC0xMjMsOCArMTI4LDE1IEBAIGNsYXNzIEZsYW1lR3JhcGhDTEk6DQo+ICAg
ICAgICAgICAgICByZXR1cm4gIiINCj4gIA0KPiAgICAgICAgICB0cnk6DQo+IC0gICAgICAgICAg
ICBvdXRwdXQgPSBzdWJwcm9jZXNzLmNoZWNrX291dHB1dChbInBlcmYiLCAicmVwb3J0IiwgIi0t
aGVhZGVyLW9ubHkiXSkNCj4gLSAgICAgICAgICAgIHJldHVybiBvdXRwdXQuZGVjb2RlKCJ1dGYt
OCIpDQo+ICsgICAgICAgICAgICBpZiBzZWxmLmFyZ3MuaW5wdXQ6DQo+ICsgICAgICAgICAgICAg
ICAgb3V0cHV0ID0gc3VicHJvY2Vzcy5jaGVja19vdXRwdXQoWyJwZXJmIiwgInNjcmlwdCIsICIt
LWhlYWRlci1vbmx5IiwgIi1pIiwgc2VsZi5hcmdzLmlucHV0XSkNCj4gKyAgICAgICAgICAgIGVs
c2U6DQo+ICsgICAgICAgICAgICAgICAgb3V0cHV0ID0gc3VicHJvY2Vzcy5jaGVja19vdXRwdXQo
WyJwZXJmIiwgInJlcG9ydCIsIA0KPiArICItLWhlYWRlci1vbmx5Il0pDQo+ICsNCj4gKyAgICAg
ICAgICAgIHJlc3VsdCA9IG91dHB1dC5kZWNvZGUoInV0Zi04IikNCj4gKyAgICAgICAgICAgIGlm
IHNlbGYuYXJncy5ldmVudF9uYW1lOg0KPiArICAgICAgICAgICAgICAgIHJlc3VsdCArPSAiXG5G
b2N1c2VkIGV2ZW50OiAiICsgc2VsZi5hcmdzLmV2ZW50X25hbWUNCj4gKyAgICAgICAgICAgIHJl
dHVybiByZXN1bHQNCj4gICAgICAgICAgZXhjZXB0IEV4Y2VwdGlvbiBhcyBlcnI6ICAjIHB5bGlu
dDogZGlzYWJsZT1icm9hZC1leGNlcHQNCj4gICAgICAgICAgICAgIHByaW50KCJFcnJvciByZWFk
aW5nIHJlcG9ydCBoZWFkZXI6IHt9Ii5mb3JtYXQoZXJyKSwgZmlsZT1zeXMuc3RkZXJyKQ0KPiAg
ICAgICAgICAgICAgcmV0dXJuICIiDQo+IEBAIC0yMzUsNiArMjQ3LDExIEBAIGlmIF9fbmFtZV9f
ID09ICJfX21haW5fXyI6DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBkZWZhdWx0PUZhbHNl
LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgYWN0aW9uPSJzdG9yZV90cnVlIiwNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgIGhlbHA9ImFsbG93IHVucHJvbXB0ZWQgZG93bmxvYWRpbmcg
b2YgSFRNTCANCj4gdGVtcGxhdGUiKQ0KPiArICAgIHBhcnNlci5hZGRfYXJndW1lbnQoIi1lIiwg
Ii0tZXZlbnQiLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgZGVmYXVsdD0iIiwNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgIGRlc3Q9ImV2ZW50X25hbWUiLA0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgdHlwZT1zdHIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICBoZWxwPSJz
cGVjaWZ5IHRoZSBldmVudCB0byBnZW5lcmF0ZSANCj4gKyBmbGFtZWdyYXBoIGZvciIpDQo+ICAN
Cj4gICAgICBjbGlfYXJncyA9IHBhcnNlci5wYXJzZV9hcmdzKCkNCj4gICAgICBjbGkgPSBGbGFt
ZUdyYXBoQ0xJKGNsaV9hcmdzKQ0KPiAtLQ0KPiAyLjQzLjUNCj4gDQo=
