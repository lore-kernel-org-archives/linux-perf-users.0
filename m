Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC92156661;
	Thu, 16 May 2024 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881923; cv=fail; b=hgFQ5nsbZZA68L8snRJJss5UObmfQ04PJa44nG5B5ZjHJEHhjYfcJUJWSpY/JTQfHZPSeuBxml/Dz6OQCtCq2dvPTs99oJUYcB0CAernay/5jkseCBNmdfHR0lj82UFAgVDGl7QDJy2Q1G2KCi3ErJFHcnJZ06gXnG8T1gzVxno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881923; c=relaxed/simple;
	bh=peSemeV9luk1n4k9p1tHzY/dJag4zPYVuUA7VwfN7AA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GhXTLlQ8juJmK9/wsJctsfcSjbZJEq+/Y8WwFAoiNYUCd4LswjXNQO5PgySVpUGQG32D3Dhk63IEUhXlrhaIES4UHUvR+2ICMn/vD1GUODCTi7Py0HfdYlqxedkLiaToPXNzutyT5DxJz0wFEx4zkho75tL+N79NOCdDklT3AgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dT5cFTxO; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dT5cFTxO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715881921; x=1747417921;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=peSemeV9luk1n4k9p1tHzY/dJag4zPYVuUA7VwfN7AA=;
  b=dT5cFTxOvGjJK2N0Gx+kadTh+7C2pUg+ltvKnpi2NPWrT6I3KeDq+KGA
   0ofoJz/Sw3HqIcmie9t842zEuCIy9jMzm7X73yOTylC0U3dwB6As4EJVT
   bXJ6aAOSkCVTmi+FaEp6Eo3mgUudazwBrFPEba4NxOvy+GVp7tW35RdKf
   I/aS6CLTO0WvSimULR4sN2qfjDHK1TZjaEnWJBQOwOpMT7Wa4yrkW5r2Q
   h7HYdWYPWfMOnVnE6yLnF5lXLPrYA1IssdTGP9wMAde7tD+bAK5jAgHT7
   Nh07ranUmSDR+2m0bToV9fg7sBH7PZwAsW6qV+j/2OhPKcFyA0qq2XHPO
   w==;
X-CSE-ConnectionGUID: u7MWdXrCRtiPoGzFqhytgw==
X-CSE-MsgGUID: qFLXGGDmSjioLMlZkoZPUg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="12230317"
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="12230317"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 10:52:01 -0700
X-CSE-ConnectionGUID: 8ZJnzBFNR6mcpvRlfs1/fA==
X-CSE-MsgGUID: d8zoD2CIT9azWTiCM6tKAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="31515155"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 May 2024 10:52:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 10:52:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 16 May 2024 10:52:00 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 May 2024 10:51:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKgTiSffuTdV0zx9QbbWgRUiitj/enzGWAIGsRIbg2vP/zojjTloQwpKDJ8Em3szi8RDwuELQG/7Q+AfTwv4V6BO0stW94Jxux3qesty5/jOAMsNW4Ndn5uh9b2pnyzo8Jlyb4bLuA4h2LTscSsko+8Gry2svqgCHwQydfB724EsIhcznbrXPB6Zd1IJqrYbo4d3K/XxoiNl1P4QZ/2QFr8z5mFZVR5gNu1636NLk/P6OusVrB6WogXV+dWsiOLiOlSdNs7Q/yyPG0809SxUjjvJFc8OpuigKv4f3EAKf4aqtDOuqjPHXeHnNYUCgocl1pWrBL3FfjRNtK2lX76niQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=peSemeV9luk1n4k9p1tHzY/dJag4zPYVuUA7VwfN7AA=;
 b=eF8c6U+bUe8TepYsO8OK0TpqeeSOTj08kSAo4+p0vEh1UGBFxFQT+epLxIFTaUc2CrPaTNoCFXA5F617NdADgo7IV1ZwmEq1TGQ/Yh1WCKproR+u/mX9yMf2uAQzSXDDd5+MvlsWEg/fc7S2raLATzajIftpXfPH3g9ZYjPs5gBeUx9nV0pzr2OucDN4YmCcjT2UFEbHgiNqvmS3sQjlZzgfNJEeyl96MK8QSi5gN/vZa9fe7VpEywGUacWuWN+1ZobNQXKLm/3GiH+w24jIj+OtOUPqcTUybraWDwRD/pvJKTmbOa7JoG72SE7uLzbx6R84gHdo5D0Gxug1y0YxWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by PH7PR11MB6724.namprd11.prod.outlook.com (2603:10b6:510:1b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.29; Thu, 16 May
 2024 17:51:57 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%4]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 17:51:56 +0000
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
Subject: RE: [RFC PATCH v8 5/7] perf stat: Add retire latency print functions
 to print out at the very end of print out
Thread-Topic: [RFC PATCH v8 5/7] perf stat: Add retire latency print functions
 to print out at the very end of print out
Thread-Index: AQHaposEgVnWA/MkD0itarBLx+5P37GaFEKAgAAQAiA=
Date: Thu, 16 May 2024 17:51:56 +0000
Message-ID: <CO6PR11MB563541C3F37628965690DB57EEED2@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240515054443.2824147-1-weilin.wang@intel.com>
 <20240515054443.2824147-6-weilin.wang@intel.com>
 <CAP-5=fVjpGKbQjadD0Wz11fw3OvkdTkj+YVgkgzNojnR4EpHiQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVjpGKbQjadD0Wz11fw3OvkdTkj+YVgkgzNojnR4EpHiQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|PH7PR11MB6724:EE_
x-ms-office365-filtering-correlation-id: de3ca011-bec4-4f16-63ff-08dc75d0e111
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Rlo4UVA4cE1PM0F6RzQweitXaGo1Nk5HeGRrZ1pKd1RoeWR0VjArY0FOOTRp?=
 =?utf-8?B?ODNSNG92bUJZekRVVEdsamNJRFhMVHAzRmZSNVIvVk5nc0tKRHdhMHA3c3Ns?=
 =?utf-8?B?OWlsTHJ2QlRZZDR6blRMQXpMUE12aEgzZUtIQW4zL0J0Q3pUN0tERDloVWNu?=
 =?utf-8?B?MitlNjBrYkRiRVhOeDZLVVNKa24yNVlyL1E4MW9zSHZqbWdrbDZzS1lma3Fy?=
 =?utf-8?B?aXNaNkZwUGFPdFFGaGppdlN5N0JCaXlrYUJTaHNzK3lXM3Jpa0cxRWR1TWVE?=
 =?utf-8?B?ZEdCWUM5anNhUTVCNVk1cUtDZHBMcis1Qm4vbjdpeVFuOWlsd1RFdklJbzZV?=
 =?utf-8?B?ODVTaWttUk9nSGIrcEg1QVhITlNZeitzYjRMK2ppZmdOZ2IraTEzelBiTkk3?=
 =?utf-8?B?aE9JVU1RQ0JLVmkwaFpibGlwZjAxVkJaLy9uRmw5V2pQZFJuZzJMd2JMM3lr?=
 =?utf-8?B?amlycXRxSk1BNElBenNhNktzVm91dnEwTjllc1ArRE9RWm5udm5McnVKQXAx?=
 =?utf-8?B?aTVIcDZESHB3TFkvWnY0Ym4vY3FPemYrbllVRWloNUZtbm14dFZ2dWhEN3Qv?=
 =?utf-8?B?Q01qcXJBNG5BeHY4T3FYeStzdVQzLzRqTXdnNEM5WGFma2kwbWh6b0ZNSk1U?=
 =?utf-8?B?TGlzTmw4ciszdU01dzlyOE16emsrN20xejhkU0N0TzJXZHdIS05aRk9FcW1p?=
 =?utf-8?B?OGZhRDVnbEg5R2FRaHdEci9BTTJ5NWJidXloZm1lck5CalNZMGxlMWJkb053?=
 =?utf-8?B?UFNuK0JyeFBmZ29tOGtyUzgvSUVxYW40OU9rWHRVQmE3NUh0b1VvY2h5N0pa?=
 =?utf-8?B?Z0hPa2p6WmtOQmJMc3BoTkRBWWkzTzZabzBFY1NsMlJvNUZaUWtFM2F5YzZO?=
 =?utf-8?B?M1JNUm5Ga2xkTGhINjhwUVY1NzFyNkxtK0JoZXZVWjA0MVFhSW9qT0hiRXZZ?=
 =?utf-8?B?WWVSK0hQVXdzOFZlUEo4ZG5XSXYxVVBDcnoyYTZsY2VDT3dxS2N3WDU2eldl?=
 =?utf-8?B?alRBRHdqQUtJM3V4RGorUGpsM3BDdFNoK28vYWxpSkxXai9qcXJtZkY3R1BV?=
 =?utf-8?B?d3hFMExkM2NiQVBGUUcyQWJiYjhLVW11cmkyS3RaZUJ4c2hDTmYvdy9NTVV1?=
 =?utf-8?B?THo3OURSa2w1eGEyWGpKTjU5K3lNbWNVMjFiaXh5d0Exa0VOaWd1WXlnS3Fo?=
 =?utf-8?B?ZEI0QlpDbmV2Z2ExME1rNW1yWmpUalM2ZlFHWjRzbWVLK2R0RVpVZ1dqTnM2?=
 =?utf-8?B?MmR0WTY5QnpyT1dXbzcvaGNBRnlSbHZPSHN4enpvSG9ITnpOcVMwWVdjdG5I?=
 =?utf-8?B?UDFCNEczUkpTanArVmJvWFliMVJCR2VMQlpZY1R1RHhrK3h4NDZoaDNTL0VB?=
 =?utf-8?B?ZTVQU3lpTWJmaURDRHVrcEQ0RWp1OEV2UDhIa2tLdHBTeDZoV2xabXV2QTZ4?=
 =?utf-8?B?NitMeWtNQ0pzc1VMOGNycXVVUmhMcUphR3d0Q2hST1BMcmhKQmMwTERZaGpI?=
 =?utf-8?B?eHBFU1BRc1F3b3p0QWlPeXlDNE1vUHd2R21pZlpjUzNINm0vQU5EM0c1RjNP?=
 =?utf-8?B?UlNTVWYvdHZDem1Kc3dEc0R1OHpvQUsyZ2ZuYnR0eUpBcHlGVEYzM2dpZjNq?=
 =?utf-8?B?SUcxV0NYbjkyK1BaRnZ0OXovNXdIOVJiZVBrcXB2R3doRlFIcnpBNUlmZjZu?=
 =?utf-8?B?UnBKYTh6MkZ4UXNwb0dPRCtNb1VlY1RBd01KallVY2x2OWpjbDJSZUNnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WllJRUxsdTVlU3hvY3FQdmlZdlNOazhrbXhYSmpQRWNPbWdVQWo3cHArNkg5?=
 =?utf-8?B?M2Y0MWFocjJxVDVjK2s1ak95ZEl1YXB3VG5qV2x1UDhIQW13R0pzWkljLytM?=
 =?utf-8?B?d2VxZ3BnZUoxalFXcnBuL1RrL0JMS0JKTjU2T0lUMUM1Uzc1a1pZQkEwb2pZ?=
 =?utf-8?B?QXlxaGlFbTc1RC9hZWhmUzdRbkg4VjZpT0ZJQ1pYNXE0VWpVY3RyQnk0T2dt?=
 =?utf-8?B?N2JpVVYzdXRIWEUyaXBoVVEwZ3JyQStaMlNkUFp1UHplNzJFUlR6SjRHWmhI?=
 =?utf-8?B?WG9YRUhhYkJlWDJPL3ZKOWdURlI2dzRWY3BLaVBxaUVndjZNbzhRS2VBZEtZ?=
 =?utf-8?B?NE4ya0RjT2dUaEs5UFIwckVDVENGazFjVy80VzZ0a00wc0phMmZ1TC9wYVY4?=
 =?utf-8?B?ZHpwN05uS1oyYnJ0ZjJ2UHROcUZYcXVQY0N5anRwcDBKS0txZVdsU2sxVUxh?=
 =?utf-8?B?WnV2amlJSFk3S2VWa0NzcTJ1OFFqeURGUHBSZFJFZ3NrK3BoZmtSakZQT3ph?=
 =?utf-8?B?Qmc4K1ZGYmRhak5UN2luckY4ZFJVWjdvZXBGaHl4YUxQcnVXTFNpVENaREMr?=
 =?utf-8?B?QmFxMkZXcEUvVjYwd3M4ZEpLaDhvRytJRnZRMDVjNnpadHBjRlJ1eXk2N0NY?=
 =?utf-8?B?MS95MTdMN1ZhWjdQRjlzRG1YUVJEdXE5bDRKNTBaRzlibHQrQkVNV3lIYnpJ?=
 =?utf-8?B?WjQvK2gvU1k3bTZVWXdvKzZiV09GbUZSQTdwOG5ZeGFEYlBaeXlQeG9QT0ha?=
 =?utf-8?B?R0tDQ01ic0ZHS0tXZGo3NkpNMTd0OTh5OUFoM1JpYnNmWmUxVkcyRlE0eWpH?=
 =?utf-8?B?cENwamxvL1hMbEVFa0Nha2xFeHd2K2gxR1prcXMrc2ZhZFNScy9ma1gzbUV0?=
 =?utf-8?B?SXRza20zaFUweHl1ZjVnakd2UXozY052TWxJaXlCbndkWFZYU1VYWmZORDZj?=
 =?utf-8?B?WjJ6bGwzeHdyaDBUcFF1Sk5pUEFKMnp2aHNzOVVmNHFFeUtXLzdsK05tL3FY?=
 =?utf-8?B?OTN1T2tkU0dlSzdRdkV2eUQzSUttWXdCN3psREJ6QitxZ3NXNHFEOFhjV0Ey?=
 =?utf-8?B?Tm9ibmJOdWw5eXN6TFlJdGVNdkswYU92UE0vK21SWGh0aWp3aTdNUDJUN0Qw?=
 =?utf-8?B?OGRGZUFySmlCbHIwVEhLVFFXQTFWdlVFUEhPbnh4ZTNxNEs4eFhSNzc2ZGs5?=
 =?utf-8?B?bTcwQlNjNFM3N0pVUEV1WnFJR05EVTE5c2RVUFFoNVFndmhkOVJWNFBleHhX?=
 =?utf-8?B?SDdpRDZ3S1pvL1pnZDZkSFM2WTFGMVcxM2NyZ1pSVE4vUjRWUitRazlCUnZV?=
 =?utf-8?B?K0hhaHN0aE0wWEhQeDlLNStNcVJpRUZmRFF6ZC9qU1JLR1M2Y2tQc1VOTDdI?=
 =?utf-8?B?WnNnV0c2eXQ2VTJESUxCWWVPZ0RqZUYyaGg1VGFDZE9kalgyNmhkanpMRC8z?=
 =?utf-8?B?NzVMeUhvSG1EMDRoNS8zQkhIZ0c0MWcxaEF5SzgyelJ3RW0ya21NYklnUGY2?=
 =?utf-8?B?Nmt3Zk0zdDh2eE5pOEhIRnFuVzJGSnVycEpFazg2bU5kTk9HSkQvTEp1d250?=
 =?utf-8?B?cXZOZWhkOEg4T2d6d05uT2ZkY0QvR2Z3ckpCbENCVGd1bXkySVg1cDRxUk9v?=
 =?utf-8?B?NWpnY0JWWXNHOFF6VDJBNTZva3ZKcUcxQzJKTGlwa3laSDFRcnlIS3lNaElm?=
 =?utf-8?B?VXNONm9HRG45bUlMUlZ2V05HR3lneSsvamt2cU9uL1ZGZ3RTWnhnQlZwaU8x?=
 =?utf-8?B?eHdUakdVQWZpVnExeEFkZVl1akRMenlCNS9CUmRyaUdwbVllb1dvYjZ3RGpq?=
 =?utf-8?B?QklTc1lWRkJMNnRISmtsdzhkTVVBSnZIYzFCY1JRTDFIc05DTmtQR1Y1V3F1?=
 =?utf-8?B?a3FLNTBlNzRFa0FVa0JKakUzUi9CejR5OHZ6cGZQK201QjlVV3ZZNWdDaXVa?=
 =?utf-8?B?WWJIdXB1NGZ4c0V4SGQ0M2VhMDJQZXVGWUV5OTFSRzlNSEl6MDBrdnhhbGxZ?=
 =?utf-8?B?cnRkMlZtSTFyMmxQNUU1QlBlSEpIUHdjS2E4bFJJdnFaN1Vnb0xWT2JmdHRC?=
 =?utf-8?B?YTRxVTRlb3JjcTBCVmR0T3FUc29xNHNiZEErVnA4TlhvbFA3MmxjZFErNXBB?=
 =?utf-8?Q?Uqar52dJbb2DmZ7sCFW85Y1nx?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: de3ca011-bec4-4f16-63ff-08dc75d0e111
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 17:51:56.8868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R2roCQGqmYtE9Io90n2LtpOoSvqYr0m26jQIEvA0ufFIucAQmcqdY/tobSdfNMZiD44lLZh6/CKNa3Eh+WklGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6724
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSWFuIFJvZ2VycyA8aXJv
Z2Vyc0Bnb29nbGUuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgTWF5IDE2LCAyMDI0IDk6NDcgQU0N
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
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjggNS83XSBwZXJmIHN0YXQ6IEFkZCBy
ZXRpcmUgbGF0ZW5jeSBwcmludCBmdW5jdGlvbnMgdG8NCj4gcHJpbnQgb3V0IGF0IHRoZSB2ZXJ5
IGVuZCBvZiBwcmludCBvdXQNCj4gDQo+IE9uIFR1ZSwgTWF5IDE0LCAyMDI0IGF0IDEwOjQ04oCv
UE0gPHdlaWxpbi53YW5nQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBXZWlsaW4g
V2FuZyA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiA+DQo+ID4gQWRkIHByaW50IG91dCBmdW5j
dGlvbnMgc28gdGhhdCB1c2VycyBjb3VsZCByZWFkIHJldGlyZSBsYXRlbmN5IHZhbHVlcy4NCj4g
Pg0KPiA+IEV4YW1wbGUgb3V0cHV0Og0KPiA+DQo+ID4gIFBlcmZvcm1hbmNlIGNvdW50ZXIgc3Rh
dHMgZm9yICdzeXN0ZW0gd2lkZSc6DQo+ID4NCj4gPiAgICAgICAgICAgICAyNSw3MTcgICAgICBN
RU1fSU5TVF9SRVRJUkVELlNQTElUX1NUT1JFUyAgICAjICAgICAgMi4yICUNCj4gdG1hX3NwbGl0
X3N0b3Jlcw0KPiA+ICAgICAgICAgMjgsMzY1LDA4MCAgICAgIENQVV9DTEtfVU5IQUxURUQuVEhS
RUFEDQo+ID4gICAgICAgICAgICAgIDI0LjAwICAgICAgTUVNX0lOU1RfUkVUSVJFRC5TUExJVF9T
VE9SRVM6UiAgIyAgICAgICA5NiAgICAgICAgNA0KPiA+DQo+ID4gICAgICAgIDIuMDU0MzY1MDgz
IHNlY29uZHMgdGltZSBlbGFwc2VkDQo+ID4NCj4gPiBUaGlzIG91dHB1dCBvZiByZXRpcmUgbGF0
ZW5jeSBkYXRhIGlzIGluIGZvcm1hdDoNCj4gPiAgPHZhbD4gPGV2ZW50LW5hbWU6Uj4gIyA8c3Vt
PiA8Y291bnQ+Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2VpbGluIFdhbmcgPHdlaWxpbi53
YW5nQGludGVsLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogSWFuIFJvZ2VycyA8aXJvZ2Vyc0Bnb29n
bGUuY29tPg0KPiANCj4gTXkgdXN1YWwgY29tcGxhaW50IHRoYXQgSSBoYXRlIHRoZSBzdGF0LWRp
c3BsYXkgc3BhZ2hldHRpIGNvZGUuIFdlDQo+IGtlZXAgcHV0dGluZyBtb3JlIHNwYWdoZXR0aSBv
biB0aGUgcGxhdGUgYW5kIHRoaXMgY2hhbmdlIGRvZXMgdGhpcw0KPiB0b28uIEluIHRoZSBldnNl
bCBhcHByb2FjaDoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI0MDQyODA1MzYx
Ni4xMTI1ODkxLTEtDQo+IGlyb2dlcnNAZ29vZ2xlLmNvbS8NCj4gcmV0aXJlbWVudCBsYXRlbmN5
IGV2ZW50cyBqdXN0IHVwZGF0ZSB0aGUgY291bnRzIGZvciB0aGUgZXZlbnQgYW5kIHNvDQo+IHdl
IGRvbid0IG5lZWQgdG8gc3BlY2lhbCBjYXNlIHRwZWJzIGV2ZW50cyBsaWtlIHRoaXMuIEknZCBw
cmVmZXIgd2UNCj4gd2VudCB0aGF0IHJvdXRlLiBNeSByZXZpZXdlZC1ieSBubyBsb25nZXIgc3Rh
bmRzLg0KPg0KQmFzZWQgb24gdGhlIGN1cnJlbnQgc3RhdC1kaXNwbGF5IGNvZGUgYW5kIHRoZSBv
cmlnaW5hbCBUUEVCUyBjb3VudGluZyANCmNvZGUsIEkgYmVsaWV2ZSB0aGUgY29kZSBpbiB0aGlz
IGNvbW1pdCBhbmQgbGFzdCBjb21taXQgd2FzIHRoZSBiZXN0IHdheSB0bw0KZG8gdGhlIG1ldHJp
YyBjYWxjdWxhdGlvbiBhbmQgcHJpbnRvdXQuIA0KDQpCdXQgSSB0b3RhbGx5IGFncmVlIHdpdGgg
eW91IHRoYXQgaWYgd2UgY291bGQgZ2V0IGV2c2VsIHdpdGggcmV0aXJlIGxhdGVuY3kgd29yaywN
CnRoaXMgY29kZSBpcyBub3QgbmVjZXNzYXJ5Lg0KDQpJIHdhcyB0aGlua2luZyB0byBwbHVnaW4g
dGhlIHJldGlyZSBsYXRlbmN5IHZhbHVlIGludG8gZXZzZWwgc28gdGhhdCBJIGNvdWxkIGRlbGV0
ZSANCnRoaXMgYW5kIGxhc3QgY29tbWl0LiBEbyB5b3UgdGhpbmsgdGhhdCB3b3VsZCBiZSBhIHNv
bHV0aW9uPw0KDQpUaGFua3MsDQpXZWlsaW4NCg0KPiBUaGFua3MsDQo+IElhbg0KPiANCj4gPiAt
LS0NCj4gPiAgdG9vbHMvcGVyZi91dGlsL3N0YXQtZGlzcGxheS5jIHwgNjkNCj4gKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNjkgaW5zZXJ0
aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdXRpbC9zdGF0LWRpc3Bs
YXkuYyBiL3Rvb2xzL3BlcmYvdXRpbC9zdGF0LWRpc3BsYXkuYw0KPiA+IGluZGV4IGJmYzFkNzA1
ZjQzNy4uYjljMzk3OGNjOTljIDEwMDY0NA0KPiA+IC0tLSBhL3Rvb2xzL3BlcmYvdXRpbC9zdGF0
LWRpc3BsYXkuYw0KPiA+ICsrKyBiL3Rvb2xzL3BlcmYvdXRpbC9zdGF0LWRpc3BsYXkuYw0KPiA+
IEBAIC0yMSw2ICsyMSw3IEBADQo+ID4gICNpbmNsdWRlICJpb3N0YXQuaCINCj4gPiAgI2luY2x1
ZGUgInBtdS5oIg0KPiA+ICAjaW5jbHVkZSAicG11cy5oIg0KPiA+ICsjaW5jbHVkZSAiaW50ZWwt
dHBlYnMuaCINCj4gPg0KPiA+ICAjZGVmaW5lIENOVFJfTk9UX1NVUFBPUlRFRCAgICAgIjxub3Qg
c3VwcG9ydGVkPiINCj4gPiAgI2RlZmluZSBDTlRSX05PVF9DT1VOVEVEICAgICAgICI8bm90IGNv
dW50ZWQ+Ig0KPiA+IEBAIC0zNCw2ICszNSw3IEBADQo+ID4gICNkZWZpbmUgQ09NTV9MRU4gICAg
IDE2DQo+ID4gICNkZWZpbmUgUElEX0xFTiAgICAgICA3DQo+ID4gICNkZWZpbmUgQ1BVU19MRU4g
ICAgICA0DQo+ID4gKyNkZWZpbmUgUkVUSVJFX0xFTiAgICA4DQo+ID4NCj4gPiAgc3RhdGljIGlu
dCBhZ2dyX2hlYWRlcl9sZW5zW10gPSB7DQo+ID4gICAgICAgICBbQUdHUl9DT1JFXSAgICAgPSAx
OCwNCj4gPiBAQCAtNDI2LDYgKzQyOCw3MSBAQCBzdGF0aWMgdm9pZCBwcmludF9tZXRyaWNfc3Rk
KHN0cnVjdA0KPiBwZXJmX3N0YXRfY29uZmlnICpjb25maWcsDQo+ID4gICAgICAgICBmcHJpbnRm
KG91dCwgIiAlLSpzIiwgTUVUUklDX0xFTiAtIG4gLSAxLCB1bml0KTsNCj4gPiAgfQ0KPiA+DQo+
ID4gK3N0YXRpYyB2b2lkIHByaW50X3JldGlyZV9sYXRfc3RkKHN0cnVjdCBwZXJmX3N0YXRfY29u
ZmlnICpjb25maWcsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IG91dHN0YXRlICpvcykNCj4gPiArew0KPiA+ICsgICAgICAgRklMRSAqb3V0ID0gb3MtPmZoOw0K
PiA+ICsgICAgICAgYm9vbCBuZXdsaW5lID0gb3MtPm5ld2xpbmU7DQo+ID4gKyAgICAgICBzdHJ1
Y3QgdHBlYnNfcmV0aXJlX2xhdCAqdDsNCj4gPiArICAgICAgIHN0cnVjdCBsaXN0X2hlYWQgKnJl
dGlyZV9sYXRzID0gJmNvbmZpZy0+dHBlYnNfcmVzdWx0czsNCj4gPiArDQo+ID4gKyAgICAgICBs
aXN0X2Zvcl9lYWNoX2VudHJ5KHQsIHJldGlyZV9sYXRzLCBuZCkgew0KPiA+ICsgICAgICAgICAg
ICAgICBpZiAobmV3bGluZSkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBkb19uZXdfbGlu
ZV9zdGQoY29uZmlnLCBvcyk7DQo+ID4gKyAgICAgICAgICAgICAgIGZwcmludGYob3V0LCAiJScq
LjJmICIsIENPVU5UU19MRU4sIHQtPnZhbCk7DQo+ID4gKyAgICAgICAgICAgICAgIC8qIEZvciBw
cmludCBhbGlnbm1lbnQgKi8NCj4gPiArICAgICAgICAgICAgICAgZnByaW50ZihvdXQsICIlLSpz
ICIsIGNvbmZpZy0+dW5pdF93aWR0aCwgIiIpOw0KPiA+ICsgICAgICAgICAgICAgICBmcHJpbnRm
KG91dCwgIiUtKnMiLCBFVk5BTUVfTEVOLCB0LT50cGVic19uYW1lKTsNCj4gPiArICAgICAgICAg
ICAgICAgZnByaW50ZihvdXQsICIgIyAiKTsNCj4gPiArICAgICAgICAgICAgICAgZnByaW50Zihv
dXQsICIlKmQgJSpsZFxuIiwgUkVUSVJFX0xFTiwgdC0+c3VtLA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICBSRVRJUkVfTEVOLCB0LT5jb3VudCk7DQo+ID4gKyAgICAgICB9DQo+ID4gK30N
Cj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIHByaW50X3JldGlyZV9sYXRfY3N2KHN0cnVjdCBwZXJm
X3N0YXRfY29uZmlnICpjb25maWcsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc3RydWN0IG91dHN0YXRlICpvcykNCj4gPiArew0KPiA+ICsgICAgICAgRklMRSAqb3V0ID0g
b3MtPmZoOw0KPiA+ICsgICAgICAgc3RydWN0IHRwZWJzX3JldGlyZV9sYXQgKnQ7DQo+ID4gKyAg
ICAgICBzdHJ1Y3QgbGlzdF9oZWFkICpyZXRpcmVfbGF0cyA9ICZjb25maWctPnRwZWJzX3Jlc3Vs
dHM7DQo+ID4gKyAgICAgICBjb25zdCBjaGFyICpzZXAgPSBjb25maWctPmNzdl9zZXA7DQo+ID4g
Kw0KPiA+ICsgICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeSh0LCByZXRpcmVfbGF0cywgbmQpIHsN
Cj4gPiArICAgICAgICAgICAgICAgZnByaW50ZihvdXQsICIlZiVzJXMlcyVzJWxkJXMlZFxuIiwg
dC0+dmFsLCBzZXAsIHNlcCwgdC0NCj4gPnRwZWJzX25hbWUsIHNlcCwNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICB0LT5jb3VudCwgc2VwLCB0LT5zdW0pOw0KPiA+ICsgICAgICAgfQ0KPiA+
ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBwcmludF9yZXRpcmVfbGF0X2pzb24oc3RydWN0
IHBlcmZfc3RhdF9jb25maWcgKmNvbmZpZywNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc3RydWN0IG91dHN0YXRlICpvcykNCj4gPiArew0KPiA+ICsgICAgICAgRklMRSAq
b3V0ID0gb3MtPmZoOw0KPiA+ICsgICAgICAgc3RydWN0IHRwZWJzX3JldGlyZV9sYXQgKnQ7DQo+
ID4gKyAgICAgICBzdHJ1Y3QgbGlzdF9oZWFkICpyZXRpcmVfbGF0cyA9ICZjb25maWctPnRwZWJz
X3Jlc3VsdHM7DQo+ID4gKw0KPiA+ICsgICAgICAgZnByaW50ZihvdXQsICJ7Iik7DQo+ID4gKyAg
ICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KHQsIHJldGlyZV9sYXRzLCBuZCkgew0KPiA+ICsgICAg
ICAgICAgICAgICBmcHJpbnRmKG91dCwgIlwicmV0aXJlX2xhdGVuY3ktdmFsdWVcIiA6IFwiJWZc
IiwgIiwgdC0+dmFsKTsNCj4gPiArICAgICAgICAgICAgICAgZnByaW50ZihvdXQsICJcIm5hbWVc
IiA6IFwiJXNcIiIsIHQtPnRwZWJzX25hbWUpOw0KPiA+ICsgICAgICAgICAgICAgICBmcHJpbnRm
KG91dCwgIlwic2FtcGxlLWNvdW50c1wiIDogXCIlbGRcIiIsIHQtPmNvdW50KTsNCj4gPiArICAg
ICAgICAgICAgICAgZnByaW50ZihvdXQsICJcInJldGlyZV9sYXRlbmN5LXN1bVwiIDogXCIlZFwi
IiwgdC0+c3VtKTsNCj4gPiArICAgICAgIH0NCj4gPiArICAgICAgIGZwcmludGYob3V0LCAifSIp
Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBwcmludF9yZXRpcmVfbGF0KHN0cnVj
dCBwZXJmX3N0YXRfY29uZmlnICpjb25maWcsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzdHJ1Y3Qgb3V0c3RhdGUgKm9zKQ0KPiA+ICt7DQo+ID4gKyAgICAgICBpZiAoISZjb25m
aWctPnRwZWJzX3Jlc3VsdHMpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybjsNCj4gPiArICAg
ICAgIGlmIChjb25maWctPmpzb25fb3V0cHV0KQ0KPiA+ICsgICAgICAgICAgICAgICBwcmludF9y
ZXRpcmVfbGF0X2pzb24oY29uZmlnLCBvcyk7DQo+ID4gKyAgICAgICBlbHNlIGlmIChjb25maWct
PmNzdl9vdXRwdXQpDQo+ID4gKyAgICAgICAgICAgICAgIHByaW50X3JldGlyZV9sYXRfY3N2KGNv
bmZpZywgb3MpOw0KPiA+ICsgICAgICAgZWxzZQ0KPiA+ICsgICAgICAgICAgICAgICBwcmludF9y
ZXRpcmVfbGF0X3N0ZChjb25maWcsIG9zKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIHZv
aWQgbmV3X2xpbmVfY3N2KHN0cnVjdCBwZXJmX3N0YXRfY29uZmlnICpjb25maWcsIHZvaWQgKmN0
eCkNCj4gPiAgew0KPiA+ICAgICAgICAgc3RydWN0IG91dHN0YXRlICpvcyA9IGN0eDsNCj4gPiBA
QCAtMTYwOSw2ICsxNjc2LDggQEAgdm9pZCBldmxpc3RfX3ByaW50X2NvdW50ZXJzKHN0cnVjdCBl
dmxpc3QgKmV2bGlzdCwNCj4gc3RydWN0IHBlcmZfc3RhdF9jb25maWcgKmNvbmYNCj4gPiAgICAg
ICAgICAgICAgICAgYnJlYWs7DQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiArICAgICAgIHByaW50
X3JldGlyZV9sYXQoY29uZmlnLCAmb3MpOw0KPiA+ICsNCj4gPiAgICAgICAgIHByaW50X2Zvb3Rl
cihjb25maWcpOw0KPiA+DQo+ID4gICAgICAgICBmZmx1c2goY29uZmlnLT5vdXRwdXQpOw0KPiA+
IC0tDQo+ID4gMi40My4wDQo+ID4NCg==
