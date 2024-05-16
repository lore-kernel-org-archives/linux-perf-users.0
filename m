Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826AF1E880;
	Thu, 16 May 2024 17:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881447; cv=fail; b=ARQua/hYsb674oI02y+S2zspaMxoY/zJZ5Nfwd/HrUDJPzoZPbmuEiq0qIrWn7pDf7B8rpHdAow7ulGnnDEv5A4dnRB6MVoKJat2ZAIG3PqYYbjnXnh4uDymrnFzR4JAmDrPONTPvkYuKvrFAlccOgD7w/mkWKp7/FQLZAqDrAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881447; c=relaxed/simple;
	bh=w4dXYY7EWYKso9mwKqGYGzv5FZWikz/SqLCL7HROKkA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OXQpFa9byQBSIKImQsafn/PmYVcc2986iKd7cpRMmrIOFu6XLziNv5hp79dPctkwiniz8Layfpc2GnGH4eRJUhFnBY7J0RuC3mPKS+pGqmzXjLTXzHbHcS114yXOkMrtPCC0+7dwOVPV+d/q5PhwI9MwbcPLpW+4yu80tViRCnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kv/fmSWa; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kv/fmSWa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715881446; x=1747417446;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w4dXYY7EWYKso9mwKqGYGzv5FZWikz/SqLCL7HROKkA=;
  b=Kv/fmSWa+fADeNM/kFtHixk90HkmNO8mp7sEkUzefS4HRIHCKk04CHm9
   CmiAk8YM91Nl0evGSJPFZJoEqQNq81yc3hJSC4NM2zZq8gfl9G0mQ0gUQ
   SEDfBRid0ehFRpk1ICqTjoABZsLydyCcyzEOo438KOvlpQwfeszGgARmz
   kQ2EayVXkvKwOwnilc7V2gTQwRr3akt8onV6GQn6KTZHy/jo/mRtaK1wF
   FIqiLFDSRCuRwhyUFnF9APUi1szbKxjpwwHK4PyInF7Uf6LXcy24q/+o2
   rVKDLm3hXPEP/HMWmr9fPuBFh8xWxpv5gTKenzwQhd11MZafaqBDlqtVw
   w==;
X-CSE-ConnectionGUID: e0Ur9JdSSDOdMnc9haVhOg==
X-CSE-MsgGUID: KmCEbVRCRXCHENlmIgagDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="12132287"
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="12132287"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 10:44:05 -0700
X-CSE-ConnectionGUID: 5DvkdlQsQSKL+NKEJeoovg==
X-CSE-MsgGUID: +VSXb4izQB+2SHa6tCAE1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="68962743"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 May 2024 10:44:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 10:44:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 16 May 2024 10:44:04 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 May 2024 10:44:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSmQTQa+nMdkP4fQw4fJVCyKKjE3vAgp4twX7D7K6eAy6+ASGtfX3GIfKK8E7b+Mx5+QtQlGJQhPLJpX/YwpFrM/HjE4gmQdHkHmhdAuY36iicIauImJUSoCsf+K6aAXDF0ePyJfTzksW5y06KtU9wN1hLqBnhXIprWhUn1MsXE5SzZkUw2fR/nbJqO0vc78Ud7bebYbJfLVoEEbGFXWUeHDUQasPK3/h052Xnli/2W1v/55kULdlxk7JRE9dRLOTwIxQzY7l9yE55UEymFrSHN0kCXzF404GrGlrGnh8fxVbPTWqnAeifa6iwYIjVAZLF3EQ4TccFgebns9cZP2Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4dXYY7EWYKso9mwKqGYGzv5FZWikz/SqLCL7HROKkA=;
 b=hm7jJdM2TT+88PUdZzpQsP9YSf93kUdSVQAFHBckHSEIfEQtM23HT9mxAmYffoFb2d19V3zRQhCvDbwhZnXyyYdvR+Oj7Agm3y7DkyK37Sr7/3zZFbQjoHCV3xJBzLNRg7YSjMwHatSLDVhf/SYhYwVwV6Ot27e0WJ5dm+6bQWVKrZhklpRDVdzighMPSBKvm76Us8En7090mW1vb53+fbtHphwPlLlyzzjMY14SivMntm3HpxHQLPmSGBh/YlsF6zovR4ROsLgwsGXdK+LBDOphVnED8sfNTro1JLDlv9MtAw/466OunIDrJ5FvL+7TCsvUgFQyHUv5wEHxChsy0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by PH7PR11MB5765.namprd11.prod.outlook.com (2603:10b6:510:139::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 17:44:01 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%4]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 17:44:00 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Ian Rogers <irogers@google.com>
CC: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>, Kan
 Liang <kan.liang@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb"
	<caleb.biggers@intel.com>
Subject: RE: [RFC PATCH v8 6/7] perf vendor events intel: Add MTL metric json
 files
Thread-Topic: [RFC PATCH v8 6/7] perf vendor events intel: Add MTL metric json
 files
Thread-Index: AQHaposFfrffx20hMEim/5uPLhzkIbGaFyWAgAAMfvA=
Date: Thu, 16 May 2024 17:44:00 +0000
Message-ID: <CO6PR11MB5635E730D28AF3A24F1E7B21EEED2@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240515054443.2824147-1-weilin.wang@intel.com>
 <20240515054443.2824147-7-weilin.wang@intel.com>
 <CAP-5=fXDmewhEzZc5ZYhfHYtPUmELjeDTKM5m04PRFaAPaO+vg@mail.gmail.com>
In-Reply-To: <CAP-5=fXDmewhEzZc5ZYhfHYtPUmELjeDTKM5m04PRFaAPaO+vg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|PH7PR11MB5765:EE_
x-ms-office365-filtering-correlation-id: e9e5ec80-1304-424d-a1f8-08dc75cfc554
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?emFieUFOTDJFb3JFbnAzUGg0azRKU284ZEpsWEx2SXpkUEpXZmQ4eHFCak5m?=
 =?utf-8?B?c1QzTmlIdkNMOVVKcDl0dTRiUTZORU1RRmRTbVBVclJKYmdiVE82Q1BKeTdD?=
 =?utf-8?B?cHJSWkFmTEIxS1BiRU1tTWMraUI3SFlydEhvRzNpZHQzZU03S25mYW14SWhq?=
 =?utf-8?B?akxmbC9aVWVMOEtlekpaYTVRbnJzZHQrOURnWWxmTzNIQmtFazh5ZXFJbmZO?=
 =?utf-8?B?ZEJWWmRoNGFRbXdLMFFTd01ORjhORFcrZ3RheUowNzhaWVh5NW9GRVZUaG5n?=
 =?utf-8?B?S211MlJ0UjI5Mjh1bDZqcm5HYlNYZGZIeWVBMG5CZ3FDOHE1YkRmcmRsZjM4?=
 =?utf-8?B?d0FIY0hWTFdHc2dkOUxKNFRlTW9qU3pKd3dZNW9SRFBTVmI1UVErWWpwWThZ?=
 =?utf-8?B?Q3BhRGptamVtNm5tZkFMZ08xamFOVklWWWVlQ0VWaENPNXVuODBRYWtDaDB6?=
 =?utf-8?B?dmZ5c1Y5QTVjUHZJa2NWTEVBQkNlWWJwbG5ZNkVJdFhiUEV3L2JzWlk3T2tV?=
 =?utf-8?B?WlNtd3VqL1h0OUcwVFhCUm5jSVhIRjVHdW9jdTAwUWJaekIvdU51MWJET3Nw?=
 =?utf-8?B?WW9hNTRqUWVHd1JncmU0eStSS29idWtXU2l1U2Y4TSttM1JlOFUvTTFGTzZP?=
 =?utf-8?B?Z1RUYzlZSlJmWmRoWjNMaXRjUElQai9nOUp1L3JhMkthWVY2eFFnZlVzbm11?=
 =?utf-8?B?N1J4N3ZYVm5qMDU3WSswYW5XcnFLK01CZ0NkbUcra3RqMS9manI5VG9pUHJu?=
 =?utf-8?B?dFFJQTV4MWtNSW5abXd5c2toOGkrVThCUTg3d1BvMkRBNVhibTZ3ZGo2R2NB?=
 =?utf-8?B?V2svR0p1QjY2Lzd4cldhQVl6KzE5Q2RZTzJacjU1dytwWVNiMmp1bDNjMkwv?=
 =?utf-8?B?bzlrS3p3TGg5dzdJZThZbmVXN1lnK3hDckNvdzFVRnYybkNmZENHazlCRmF6?=
 =?utf-8?B?S24zOWlVODZXLzR1Z2FZZmRoUVlHcUR1bGF3bGxRV0xJa3doenFmQVp4akcy?=
 =?utf-8?B?ZmZLQmc1a2g3NHBjNzdCbGxKS01RY2VkSGZHYjVJWWUxdVFpV1QvYVlhVks4?=
 =?utf-8?B?SVV5OUJnRmM3SENSS3RvYVZGQ3NvQmE5cmdBU3VFVGMxdXkwR2s2QlZiSFRW?=
 =?utf-8?B?Rko5TGdmU3NxN0xMM2tSdDc4eGNubkxodVZIRzRCbVdZRVczdm11Umo1SnVK?=
 =?utf-8?B?N0hoREo5T093MWE0WnQrWi8zY0wvcFpKUW5BWXp0QnF6Z2RueU9ibWRFMnUz?=
 =?utf-8?B?MEdudUc0WUZqK3BOSXVuVzdSdjRYekZ0YjA4d09hYnZNVGo5ZS9RQjcxcjBL?=
 =?utf-8?B?U0hHK3A3QmxhUWdiME93c1B3eGMzTjVqdFhkTUZCd1RZa2hzZDVWMXRhZXU5?=
 =?utf-8?B?TFBkK1F1SzBVUVhRNzZzVm9RcDRxdTZvazY3dXF0bGdFbnFJZVVoK2N3RXA0?=
 =?utf-8?B?SzIvbEZlTkg0YTNmYjhCOFEyanVRNlN4ZDN6dzhSVzRaakFkYUo5QXpvcXJv?=
 =?utf-8?B?V2NPTTFLdDdRaGFGTVllbk9hSzFDQjgyNk5GUmhSWDRDN2hyQU9sWEd3VG5J?=
 =?utf-8?B?eVB6TkFiVDE2b2xmT0FXTjhrMnFlNlRzUEkyVEwzL1FJYmhUWWx5Mjl2Q0tW?=
 =?utf-8?B?NkM3QmNTUWRVcTl4MjNqRWlidVdjVkwvNXRWYWIvMWhUbDUzdDBHbE1UWXVa?=
 =?utf-8?B?VEtjWi81aGl4c29DZ2p5aHV2emZEQTA2N2dUcmtaOTVDYkVKYkFlOGxtNXRL?=
 =?utf-8?Q?rvLz8nqg8lEdOUeFg8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzlNQm9qNHdBRkVTdXJxaVd4L29DN1lZUkwyNFFqSUd0a3NMSHJwbG5FM0d3?=
 =?utf-8?B?UjZzUVFyMnFlRUx3eVBxMUZBMHVoa1I3V21ML2pIZlR2bVcrQ1Q2anNvQVlW?=
 =?utf-8?B?a1hWVUdHK1p6Q0V6KzY2REdWUTFlNXlONjNNUkMrM2FNUWh1Tm85aGhrZkto?=
 =?utf-8?B?N2Z6ZHdMYlRkY2RIMU9zMjRuUnlhZkoxQTFhc3J3V1RLd0RzTkxJVjZyTmpH?=
 =?utf-8?B?VGFidUxEMHhaYTNFT01ybEdua3Q4VlQxUHN1dnVhamlWMzdLZmw4M1gwbElJ?=
 =?utf-8?B?Y3dKa3V4WVdrV3dJemRYTDdPWElFUkVDMTA1ZUhmSUpndUNOZDJuU2FTejRC?=
 =?utf-8?B?Vm9yYlhPV2M0Q1BUdTZxejhMblcxL3ovU3lEMXJpZnJ2dk1HM3lXeUVyeXla?=
 =?utf-8?B?c2xidzFEYmpKekVjQ2FKaDFUT3NPelFzQ1RUNGVRYjNtckpRclFzUGVIQk4w?=
 =?utf-8?B?ejdHeVJpbGdlRFhzUGcxTFczYXIvcmFLRTE4Y21INko3ZitCRW8yTGRDWW85?=
 =?utf-8?B?SEZDQmthaDhpWWkxR0kwTjVQdU5yUlY5QmVncEZsaFNYcDRhMmZreTMxQTcv?=
 =?utf-8?B?VzRkRi9NWkpzVitXUXVGUXAzWThpaGtyNXhiODcrVmNCZWc0RWY4cWRYNVNn?=
 =?utf-8?B?SDhSdVNzMUpXeVhMaXN0RlJGSTJ1bDBVUWJ6S05aQVRIZVZlZGxzREYvYmlw?=
 =?utf-8?B?WUVZUE5iZ2RYbndSY2lVUEliRTk5U09zOUZtcHM5QVI1V2lpR3huWnppWmRj?=
 =?utf-8?B?ekhVcUN6QXhieG1KbzlIUmkzb3FCVHNwaXNkdkZTMnZvZjNyaUh1L3VpbDFQ?=
 =?utf-8?B?Sm50aHJTY2NKL254RjVtSjNXVUFCV1YyRzNUMUlnbTNjU1hGUnJsczAxd0xY?=
 =?utf-8?B?ay8zUHpBamdNNGRkdVpoZWdQdUdJeFZGVG1hUSt6bytERE1sckhqSW45OVpJ?=
 =?utf-8?B?ODBEWnlIZ3h3dUhwVjRLN0twb2gxcEVuSkx6U3ZFSGdSWVk4dlI2Y1NTVERj?=
 =?utf-8?B?bUp1YW1wcEtKK04ybm9rRGZnaUp1ZVhqVWhjamVHK0t4YTdZOGVIZzZMUUVL?=
 =?utf-8?B?Qk41NXpaR09KRmJlM2wxYlVJS3MyUzV6YzRCRFd2bmJta1Vra1cwSEJXMHl2?=
 =?utf-8?B?Mlp2eHNCQUd3dVRkNDBBWDRvanB4aGp5aStweDlQeGpUUDlXaXVSRFNsWFVi?=
 =?utf-8?B?QWNmcmZZV2llMWQrVVMzVFZYZE9Ub1ZEU1ZzRjQvV0htMWlWQ2ZvV1hlQ21m?=
 =?utf-8?B?Rjg0UjNiejN3L0sweWx5SDdNajB0OU1xNlE1MFREVUhETHBYbzFEZnpLMFk5?=
 =?utf-8?B?L1lNS2Q1R3FqU0hldzVNMk1ocjQ4eTRSdkNRRGpWd2NlYUxZMkkrU0FFSVpG?=
 =?utf-8?B?YmxyRitBQTNEalZSR05IY1VGak5LdWdoWnRCOFFMTjdjOTFsZVJGWU1FazRI?=
 =?utf-8?B?RUpROW9BcEtORXY3OXAyb0IvME5BUTlmcXhFU1NGMFJGclRpQUg3aE0rS1ZL?=
 =?utf-8?B?YjdCeGszbVNRR1R5VjA0RUJ6SzFRdDljZnFjSURudkNOWkVSQzRreGRDcU5K?=
 =?utf-8?B?bXhuRW0xanJETklTbE05VTdLblQ4VGk3R2lkYzA5R1JRWnd5Y3AreHNHeTVQ?=
 =?utf-8?B?Tk1MOVUwZW4ycW5LODJZL3NUY3lGRUFlbGhSazdUS1NINDhlYnhBSGFqTUVG?=
 =?utf-8?B?WEErMTR6cWJpb01nLzh0Uk03Y0NaUkNtZ0t0WUx3QmFiVm9IQ0hFT1pqRDhk?=
 =?utf-8?B?SlRYcSsvRm9rSXNaVXhDb1A3VDBYSUdMdnhINjZTTDZ5aUo0bW5pUXJiRTBx?=
 =?utf-8?B?dTBLaXJZcUJYQzRFbXhVdzR3eDBZZW96YUg4cmZmaENsSU5IS1FVSk9qV2dp?=
 =?utf-8?B?ZU1BcUJVd3BWWnU3YTduL1VxeTVTaE1Sa1NEUDRuUjYxUnZHTmdsNXJISnJZ?=
 =?utf-8?B?SVEySTEwbnhaVk8xYjFHZGV0T2lBakZrVWtlZDJzU21zcTkzbHlnWEpHS3l5?=
 =?utf-8?B?cytNVm5HekJrWWk3ZDNJdkZOZnNUaVN5aExoZktyeDdMd2dCNUVyc3pPRGxw?=
 =?utf-8?B?UXczVDVaa2lteWVoeG1rQWQ2b3dqeE8zYVJsV0ZqSjZKK1p0aUkzakZLM0JG?=
 =?utf-8?Q?pU8F6TpVX14nh9MLNZb0NYoW6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e5ec80-1304-424d-a1f8-08dc75cfc554
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 17:44:00.8641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NmMxYDWwPHT3F0I1wglQKkEulbM2HtsW9v/j38d2L7aSO3Fo7aMqPA9L3UlhzUOK1HQIah9dX+ZIczOF6SSnpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5765
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSWFuIFJvZ2VycyA8aXJv
Z2Vyc0Bnb29nbGUuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgTWF5IDE2LCAyMDI0IDk6NTcgQU0N
Cj4gVG86IFdhbmcsIFdlaWxpbiA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiBDYzogTmFtaHl1
bmcgS2ltIDxuYW1oeXVuZ0BrZXJuZWwub3JnPjsgQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxvDQo+
IDxhY21lQGtlcm5lbC5vcmc+OyBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+
OyBJbmdvIE1vbG5hcg0KPiA8bWluZ29AcmVkaGF0LmNvbT47IEFsZXhhbmRlciBTaGlzaGtpbg0K
PiA8YWxleGFuZGVyLnNoaXNoa2luQGxpbnV4LmludGVsLmNvbT47IEppcmkgT2xzYSA8am9sc2FA
a2VybmVsLm9yZz47IEh1bnRlciwNCj4gQWRyaWFuIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47
IEthbiBMaWFuZyA8a2FuLmxpYW5nQGxpbnV4LmludGVsLmNvbT47DQo+IGxpbnV4LXBlcmYtdXNl
cnNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBUYXlsb3Is
IFBlcnJ5DQo+IDxwZXJyeS50YXlsb3JAaW50ZWwuY29tPjsgQWx0LCBTYW1hbnRoYSA8c2FtYW50
aGEuYWx0QGludGVsLmNvbT47IEJpZ2dlcnMsDQo+IENhbGViIDxjYWxlYi5iaWdnZXJzQGludGVs
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjggNi83XSBwZXJmIHZlbmRvciBldmVu
dHMgaW50ZWw6IEFkZCBNVEwgbWV0cmljIGpzb24NCj4gZmlsZXMNCj4gDQo+IE9uIFR1ZSwgTWF5
IDE0LCAyMDI0IGF0IDEwOjQ04oCvUE0gPHdlaWxpbi53YW5nQGludGVsLmNvbT4gd3JvdGU6DQo+
ID4NCj4gPiBGcm9tOiBXZWlsaW4gV2FuZyA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiA+DQo+
ID4gQWRkIE1UTCBtZXRyaWMganNvbiBmaWxlIGF0IFRNQTQuNyBbMV0uIFNvbWUgb2YgdGhlIG1l
dHJpY3MnIGZvcm11bGFzIHVzZQ0KPiBUUEVCUw0KPiA+IHJldGlyZV9sYXRlbmN5IGluIE1UTC4N
Cj4gPg0KPiA+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDAyMTQwMTE4MjAu
NjQ0NDU4LTEtDQo+IGlyb2dlcnNAZ29vZ2xlLmNvbS8NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFdlaWxpbiBXYW5nIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IElh
biBSb2dlcnMgPGlyb2dlcnNAZ29vZ2xlLmNvbT4NCj4gDQo+IFRoaXMgY2hhbmdlIHdvcmtzIGVp
dGhlciB3aXRoIHRoZSBhcHByb2FjaCBpbiB0aGlzIHNlcmllcyBvciB3aXRoIHRoZQ0KPiBldnNl
bCBhcHByb2FjaCBzbyBJIGRvbid0IG1pbmQgbXkgcmV2aWV3ZWQtYnkgc3RhbmRpbmcuIEknZCBw
cmVmZXIgd2UNCj4gY291bGQgaGF2ZSBhbiBldnNlbCByZWFkIGNvdW50ZXIgaW1wbGVtZW50YXRp
b24gdGhhdCByZXR1cm5zIDAgc28gdGhhdA0KPiB3ZSBjYW4gcnVuIHdpdGhvdXQgcmV0aXJlbWVu
dCBsYXRlbmN5IGdhdGhlcmluZy4NCj4gDQo+IFRNQSA0LjcgaXMgYnJva2VuIGluIHRoYXQgdGhl
IHRtYV9sb2NrX2xhdGVuY3kgbWV0cmljIHVzZXMgYQ0KPiByZXRpcmVtZW50IGxhdGVuY3kgZXZl
bnQgYnV0IG5vdCB3aXRoaW4gYSBtYXggZnVuY3Rpb24gc28gaGF2aW5nIHRoZQ0KPiByZWFkIGNv
dW50ZXIgcmV0dXJuIDAgd291bGQgYnJlYWsgdGhlIG1ldHJpYzoNCj4gDQo+ICsgICAgew0KPiAr
ICAgICAgICAiQnJpZWZEZXNjcmlwdGlvbiI6ICJUaGlzIG1ldHJpYyByZXByZXNlbnRzIGZyYWN0
aW9uIG9mDQo+IGN5Y2xlcyB0aGUgQ1BVIHNwZW50IGhhbmRsaW5nIGNhY2hlIG1pc3NlcyBkdWUg
dG8gbG9jayBvcGVyYXRpb25zIiwNCj4gKyAgICAgICAgIk1ldHJpY0V4cHIiOiAiTUVNX0lOU1Rf
UkVUSVJFRC5MT0NLX0xPQURTICoNCj4gTUVNX0lOU1RfUkVUSVJFRC5MT0NLX0xPQURTOlIgLyB0
bWFfaW5mb190aHJlYWRfY2xrcyIsDQo+ICsgICAgICAgICJNZXRyaWNHcm91cCI6DQo+ICJPZmZj
b3JlO1RvcGRvd25MNDt0bWFfTDRfZ3JvdXA7dG1hX2lzc3VlUkZPO3RtYV9sMV9ib3VuZF9ncm91
cCIsDQo+ICsgICAgICAgICJNZXRyaWNOYW1lIjogInRtYV9sb2NrX2xhdGVuY3kiLA0KPiArICAg
ICAgICAiTWV0cmljVGhyZXNob2xkIjogInRtYV9sb2NrX2xhdGVuY3kgPiAwLjIgJiAodG1hX2wx
X2JvdW5kID4NCj4gMC4xICYgKHRtYV9tZW1vcnlfYm91bmQgPiAwLjIgJiB0bWFfYmFja2VuZF9i
b3VuZCA+IDAuMikpIiwNCj4gKyAgICAgICAgIlB1YmxpY0Rlc2NyaXB0aW9uIjogIlRoaXMgbWV0
cmljIHJlcHJlc2VudHMgZnJhY3Rpb24gb2YNCj4gY3ljbGVzIHRoZSBDUFUgc3BlbnQgaGFuZGxp
bmcgY2FjaGUgbWlzc2VzIGR1ZSB0byBsb2NrIG9wZXJhdGlvbnMuIER1ZQ0KPiB0byB0aGUgbWlj
cm9hcmNoaXRlY3R1cmUgaGFuZGxpbmcgb2YgbG9ja3M7IHRoZXkgYXJlIGNsYXNzaWZpZWQgYXMN
Cj4gTDFfQm91bmQgcmVnYXJkbGVzcyBvZiB3aGF0IG1lbW9yeSBzb3VyY2Ugc2F0aXNmaWVkIHRo
ZW0uIFNhbXBsZSB3aXRoOg0KPiBNRU1fSU5TVF9SRVRJUkVELkxPQ0tfTE9BRFNfUFMuIFJlbGF0
ZWQgbWV0cmljczogdG1hX3N0b3JlX2xhdGVuY3kiLA0KPiArICAgICAgICAiU2NhbGVVbml0Ijog
IjEwMCUiLA0KPiArICAgICAgICAiVW5pdCI6ICJjcHVfY29yZSINCj4gKyAgICB9LA0KPiANCj4g
T3RoZXIgbWV0cmljcyB0aGVuIHVzZSB0aGF0IG1ldHJpYyBzcGVjaWZpY2FsbHkNCj4gdG1hX2lu
Zm9fYm90dGxlbmVja19tZW1vcnlfZGF0YV90bGJzIGFuZA0KPiB0bWFfaW5mb19ib3R0bGVuZWNr
X2NhY2hlX21lbW9yeV9iYW5kd2lkdGguDQo+IA0KPiBJIGNvdWxkbid0IHNlZSBpbiB0aGUgVE1B
IDQuOCByZWxlYXNlIHRoZSB1cGRhdGVkIE1UTCBtZXRyaWNzOg0KPiBodHRwczovL2dpdGh1Yi5j
b20vaW50ZWwvcGVyZm1vbi9wdWxsLzE4MS9jb21taXRzL2Q1NGM4NDdiMmY4NjNjOThhOQ0KPiAx
N2JkZDMxYTA2ODBmNGQ1MGZmNzVjDQo+IGJ1dCBteSBiZWxpZWYgaXMgdGhhdCB0aGlzIGlzc3Vl
IGhhc24ndCBiZWVuIGFkZHJlc3NlZC4NCg0KSSBkaWQgbm90IGluY2x1ZGUgVE1BNC44IGhlcmUg
YmVjYXVzZSBvdXIgcmVsZWFzZSBvZiBUTUEgNC44IGlzIG5vdCBmaW5hbGl6ZWQgDQpieSB0aGUg
dGltZSBJIHNlbnQgdGhpcyBwYXRjaCBzZXQuIEkgd2lsbCBhZGQgVE1BIDQuOCBhbmQgbGF0ZXN0
IEUtQ29yZSBUTUEgDQpuZXh0IHRpbWUuIA0KDQpUaGFua3MsIA0KV2VpbGluDQo+IA0KPiBUaGFu
a3MsDQo+IElhbg0K
