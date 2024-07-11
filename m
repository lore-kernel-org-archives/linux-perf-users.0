Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4943E19FA80;
	Thu, 11 Jul 2024 22:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720735522; cv=fail; b=RfM4aY6zQLIHArvwc83bB1Y6bM0KFopvc7jBwsb7RJ7ET0RR0oNBNZJppmF+uQyebEkRqVQrT/vUD3t8jK97IQ4hOVOA3qvsG3aGx5m5/gvK4XU8qUg6k1MJMnC0/iuC1hLI9Dyh4ybMnSw5Lcxh8VuxuKiNAYa341r1NTLDaFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720735522; c=relaxed/simple;
	bh=uZsgkfonFXVO4F/p1suDQ3p4gV6Z5VjfRYfNIohPZj0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eVXqYn9M2gnPbpNjbMZjCdsc0PZ7koABMtSn4S7z0rOsdXpFBggxdy/suJjYeAMhLMo4JCASCpieKFO/hXNQqp+IGHbMEPGukYViu6XWXeFkl2yGtmvbQ1XzYdyIwtS8D+oUPdYkP9qkg8XsQE2qQbRoQhKeG+jcpVOcBRxk0qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EZX4S+Fu; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZX4S+Fu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720735520; x=1752271520;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uZsgkfonFXVO4F/p1suDQ3p4gV6Z5VjfRYfNIohPZj0=;
  b=EZX4S+FuUM/X1X54hMJZI1lmTpO9aKK/R1qXH3U66WaX80/6S7j3IMwE
   BLSqbzY0X//Zk/rFJjEtsuvnCoGvoZ6HK3ssFBl7+Yv/ngMxH//TEHfPo
   I9CLQRSvmLk40MZM9/cv23+WXqOFtyZYb1usVBZLrVnqdSPeQp1YbO/Ri
   2rjDVBL8J0OhacLtaiC6YW+4i7fZr5JxPtsnotd/5JHiO3dvjoNyBfZmE
   gGxfX9uK0LzZwJmRNhe7xEifIDPpFxJU3T5tDBaIsYCqNpRDfczIrKZN0
   5jynHfWapNDjCBWM09RaEN+Jg4fqlOMoi0wld9i3lopeWfyjqTU62vfYQ
   A==;
X-CSE-ConnectionGUID: IOEztdtSTiS8wxZlVhU9tQ==
X-CSE-MsgGUID: 9ycElxPxRJSikcQfl8jxog==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18291530"
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="18291530"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 15:05:20 -0700
X-CSE-ConnectionGUID: ejpi1j+tTZ+vuJ4k7PReAQ==
X-CSE-MsgGUID: KFMH1hcUTX+Y6+B8IaXnkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="71913061"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 15:05:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 15:05:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 15:05:18 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 15:05:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 15:05:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ye1oB+WKlZhlLhJRM9bEOjKsotY+QKr8+kXmkbrbr8O3ZV1h7EHN87f4SrnPlureSg5mHXsCfzdNT7W44aof3KxvpbIknOsHArQ/mZXQwt9NNPpUgJRL163PIzjGn/sMdYCMlXpiHQNrrqWWjV5jJqlFIjRV4iQwYVZOJXuTv5ucLRxDHoxSI55OwCGYQKRM2JUysg90NNJmh3lOsoPHTa8kkZDoKua9+NqT1FkKoStrWXlR4INd9GS9m30u703MUS1mAGK+q+jS75ZXQPsZrirwwAkCyLk1rE57AAhmkJJBrtOYt0zVkl/wwGAi6iveNBAiPovPmuLXD7CmWOgewA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZsgkfonFXVO4F/p1suDQ3p4gV6Z5VjfRYfNIohPZj0=;
 b=gAz9mWIqd23OChKclfVNWVuX2TCRMjvHa6vbVClZDe70//c0s4TTbFbHFemOELa72S/QXbckBuHQ1hnI3+1+aeaFWFgSv0nOO5QoBZ/312KtUaMiBVYhHVp8e+hiVB1T2qdPijJRZ8F08mXb5KPzlYJnGdqRhHietp491oDGYVZDUvYWl0uh3mRrjN1MZDUTbT923E14Fw4OcV82WMPp33CkRkmywvi3PoFFKiLU8ZKT/cnIVV79ow3XBK+5uGLlpF0Hak7rQv7K42Yjz5t9CnmEsFzlja2UHn+T3uwjkyvSM6b/b1EcEODWGJzcCC4FyoYICh2dJHIwm13CO3/3SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by MW3PR11MB4570.namprd11.prod.outlook.com (2603:10b6:303:5f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21; Thu, 11 Jul
 2024 22:05:14 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%4]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 22:05:14 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"Kan Liang" <kan.liang@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb"
	<caleb.biggers@intel.com>
Subject: RE: [RFC PATCH v16 8/8] perf test: Add test for Intel TPEBS counting
 mode
Thread-Topic: [RFC PATCH v16 8/8] perf test: Add test for Intel TPEBS counting
 mode
Thread-Index: AQHaz/yE5K7EZmPt/k6tYcJFR9dutrHt1TgAgAADezCAAAIMgIAAFGfwgAQoHwCAAAG5EA==
Date: Thu, 11 Jul 2024 22:05:14 +0000
Message-ID: <CO6PR11MB563585C578FD91FD762946A7EEA52@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240706232956.304944-1-weilin.wang@intel.com>
 <20240706232956.304944-9-weilin.wang@intel.com>
 <CAM9d7chhVAG9wpWdQM4DRriM_kp9vjFj=_ak1+0qyO-sRdXs4w@mail.gmail.com>
 <CO6PR11MB563567A7804F50AD5AA1F708EEDB2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7cgrX=hL_Y16ZrPr6NOsd2ApOWdDP2bWDSNcK2yp4Skn3A@mail.gmail.com>
 <CO6PR11MB5635F6A59A405ED9CB63B8B0EEDB2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <ZpBSbjF3QP81_637@google.com>
In-Reply-To: <ZpBSbjF3QP81_637@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|MW3PR11MB4570:EE_
x-ms-office365-filtering-correlation-id: 26e0cea4-a770-4436-47f6-08dca1f58ab5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VmxIMGg5eDUxUlZwclg1SG5YN1JUam94NGNBRUt3WGRWWVc2dEdDbGY1V1NP?=
 =?utf-8?B?V2RoemtPMytsMEFpS2dVcEJBdEpZRXQ1S211MUZxV29QdUlSeHpHTTBybmN2?=
 =?utf-8?B?ZzRmV3BjdklpazRsbVhTakFYRDBvTDZIYU9GYkk2QktNWGJ5WWlSUGNwajRE?=
 =?utf-8?B?dlhwQzMrMU5xK2JONGNvVDRKWGlDbkhwUFRmd1hHcTM3Sms1OGZIaVhNVGdK?=
 =?utf-8?B?UUM3Z0VLT0Y1MUdvZCtqTjNpSXppMS8yN3o2cXZ1QmphZGE4Ukd6bEh2bzBJ?=
 =?utf-8?B?ZVVQSWlGUFNQTXJRcERZdVlFL1pCN0Z4UE9vWm1IVjdPaTF6NGZaUUNpZW1O?=
 =?utf-8?B?OURoaS8xRzJJa2dDV211WVlWbGlxdXRZeXlLMVhMVzFHYmhNNXFCOEtaODJI?=
 =?utf-8?B?bFJHN2VkM3VTWHFVcjI1S2dMSktYRk5FNEtNbDBWaDNoc3AxOGRtUldDejhL?=
 =?utf-8?B?TlAxV0JHeEpKRWs0L0pDVWQzRWRmUDIwOGtzWXRicEtIUVMwVmxPQjFRYXhZ?=
 =?utf-8?B?cCtjT3lwNk1Nd1dzQkl0RVVLQnR0VlFpdTBGMGM0cVpiUVJFdVhiRjBzZEpC?=
 =?utf-8?B?d0RDU1phTXJ4VnhobFY3N2pDenlaeGJDQUlHYm5kV2NzYlRFZXYrRGZScWpt?=
 =?utf-8?B?TDRKZ1FrMW92dEkvWTAyYmE1Y000ZkE0ckw4aWpYakxNbGFBaDRrQnVSS2RG?=
 =?utf-8?B?ZFJqa1NZMi9oaXpMcmdZNlJNQlErRiszSDM2UW9Cd1BlZGtXQ0JZV1ViT1R5?=
 =?utf-8?B?TVovQzVjT2ZPVmNkMCtsS3I5cm43aVFZa2hOZ0k4SkIybmFsaC9KK2tPNHZ5?=
 =?utf-8?B?SnVHRE9sWllBdk4wTExpaEZNTW03RjV2NUMvSlhXYWtYSUZJQy9MMzhiWGpR?=
 =?utf-8?B?YlVEQjBkYjRMK1RwQ3lkNTZQbFdVVm81VXJlYzUxNUVqWUlWY3NFdWtkSENi?=
 =?utf-8?B?NG1maXFFTGpXNU95MVVyWDdBdVNoRGMvVkNzNEUwdXVpWHVlWkxhdHdzS24r?=
 =?utf-8?B?bFVjZ3V2emU4VitNS3d2djFDWlQ0V05qdkpoSDNKcmsvQ2xpc1JIZ0crQWhw?=
 =?utf-8?B?SUJtSnVSQitNaTVadmhIcEMrWUtOUHdIbkJVVzUxVkRKNWVMWVFZV0JQMmxr?=
 =?utf-8?B?S00xa1E1T29mVXVmTHhlRzdQSTREZy9nRWYxdHlxeHBxNk15NTJBNS84UGMx?=
 =?utf-8?B?MnJOYWtoVlRYQmU5N0VtVUM5SVZmYWdWQXFrb0xVNWFKREZpQjlDaGkwaFFk?=
 =?utf-8?B?K1Nqc1NTb0VGNEJ2VTE2Tkl3cVpnckNIQkZJWE9WS29MNXowWnFlTTVud2l6?=
 =?utf-8?B?ZjBQS1dpcW1KSVBHNXVpRUV4aXE2WmowWVg4cE5iU21lbkdjQ2NneHF1TXFD?=
 =?utf-8?B?RzZ3Qml6RzhXU1FRZGFSNWo2dUZ4YTlsbGpFcDZJM2J0Mm5NTVhQNU9Hb3Rv?=
 =?utf-8?B?OFloNnV4ditySXJDUDFZSFh1SkIwbDZ1T2s1clhLUWJqUFJJaWY4UGJacW1a?=
 =?utf-8?B?OHJJTVdxcnJ0aFFMa2duVDk2MkZsMmwwaXBNUVJ5N3ZscmFJSnJaUFpVSGUw?=
 =?utf-8?B?NmxWWXJEZ1gybVJqT2lIdHA0eFF3dW1EYkN6RUxIOGxhNmRvZkJKWFBycjN5?=
 =?utf-8?B?OVIycWlSckpyUm5nSEdaQTRmczdubXdmS0R6cG5DaTBma0FKTitjS1ZaTUZV?=
 =?utf-8?B?NXZGTUtaV2pHTjIyM2ErVjBBaHg2eWNWNFVEVklvZGlpQ1V4b1F5eFBsK2xU?=
 =?utf-8?B?R09DSDg2Y1pwb3p1VHUyTWlUOWpTWUI0TERzdUNjRERFMGtVNEhYZ0l1a0FZ?=
 =?utf-8?B?dk54bEdLMksxZWFWM3RaRjQxeFhlL3hrWXNPYWdRRVN6elZqM2NwaTJodDF0?=
 =?utf-8?B?NHREakczdGZpeG96Uis5OG9uRmQ3NWFOV1JmaGR2bXprK3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGh2dTBreHo0MXFuSW43WXgwbVZCZGdHbDM0dWlmbUVjNnNzdXovVElscmpX?=
 =?utf-8?B?bHJWNnNKU2NFK3hZdUM0aGlFZlNNVm1DdEpQbFBzSDZBVFJFR2swREJ0YTdC?=
 =?utf-8?B?RVRZMGYyM0Y2ekJVWUhQdDg3UDhyWG9IZjVySExTRlROdktvekFPS1BCMUV6?=
 =?utf-8?B?ZjNNZ3ZUV29UbEM3dUVqR0t6Q1pMTnRzSkJWMUpTcVM3Y0lnK3RscHplNmV1?=
 =?utf-8?B?c0Z2NU91aGIzNkJTTS9ZaDRtb0I1WERBMDl6VzR2RjZGTlI5NXJyWDdQMllH?=
 =?utf-8?B?VlVaZHRLR0RtaEJFTmVZUWhJZHcvL2VLTTJMWkR3K0x3VVZFTVdsSC9BUEN0?=
 =?utf-8?B?SGExeGZpN1AvZ05rZ0oxWDVCL1RKejFlcDRQcUJlemhTMWxnTDYvWXI1bjBQ?=
 =?utf-8?B?TFdUbjVKTC9pUW9nVVBVYlNnLzE0WW1CeDJ5dXc5dkptMStTVnZRTDZJbzRo?=
 =?utf-8?B?Rkk2dzg1UlFmak80cThkS1c2M2orcUVobW5FeTh5SEZJRDIxNDR3dnlrdGpu?=
 =?utf-8?B?SnNQV1BKL3R3OFRVanFIdDVDak1aTXVscERJdFRadHJPbDF2Qk5zNUI0cWVl?=
 =?utf-8?B?YWdLK3Z3djhUcFNCQmJvN1hnWXVFdzNONG44UDdERE5DbWltNGZVUU9hUU9B?=
 =?utf-8?B?R0JMangreXB2bzlweTBQcDQ1YzJMMldaUnhlMHJNRC9uN3FRbWtEcUVTZVd3?=
 =?utf-8?B?aTB2bjVXZnROVitlODV0b3hQbzVjcGUyU2huTVVCOHlEaEFCbUZveS9FbXNX?=
 =?utf-8?B?aW1HaEdvZi9FTG4yMFg1b29ZV0FrSFVFb2NxTG5JRm9ybHJzcTBnV2FaREZI?=
 =?utf-8?B?Vjg0aXl3N1pVYnN2cklTUTdPNGlxc0ZES3dyeWY1OVFXSkIwQjcwbUhIWG1Q?=
 =?utf-8?B?VUFUYmFETWd2VjJRcjlwb2VLTHN4R1J3dGdkK3l4TW5mUmtqVGo4WlFLeHFw?=
 =?utf-8?B?QmEwQXhSQTA1Q2JjWjhNL2JOZENPTkY5WmJXWEQxN1RQSUJPTUUxWTkvTE05?=
 =?utf-8?B?WDNQZFRRdnpCZ29CT1NRMFRubG9VckJoNGZweTJTb2RYWW1tRlBhZFJPQTlF?=
 =?utf-8?B?eGpabHpSK1FJQ2dtaWcyZVh3Rnd3Vko4Y3ZmOEszT2hKK3FTMVJRZk9hL0Nv?=
 =?utf-8?B?QnRySnBDTVJmVzcyTFpZZjFwVXlRa2pNSTJXbDFXKzJKcVMxeVhURm1Jc0tS?=
 =?utf-8?B?QzR0dGo2L0hDS3pkaVlOcjQrUHFaazgwSTJ6b2pqY0dheERBNkVuSHVuQVN1?=
 =?utf-8?B?WE5UUGRIa05PcnA1aHZMMENBYkZVM3VxUlNPbUVCUEx3ckVRajlKY241ZDFN?=
 =?utf-8?B?UFpFc3FMRlhFY21KU3ZhNXRsK3ZySXpiZG13Y2Rpa3FsWVY1T0gwNERsL2dz?=
 =?utf-8?B?L09kN2czVFZhTkEyeVhoZWNYYk1UcEY4bEErdW4yUWpkNHlERmdVTnE4WUFI?=
 =?utf-8?B?Z3VnN2ZpdHpZclR2RnVHN3BlZzd6YmgwR2hQemxXS1c5TUlkQzdiSVpQUGx2?=
 =?utf-8?B?S1FXdndZMFF5a0pwL3RrVkpsc0Z5L2pVTWJqV0p5Tjk5Q2lMRFdYWmNyRXhh?=
 =?utf-8?B?bzBTdHE4ZnU5cFg0Nm1WMFZBYk1udHcwYmRFV0pzSnh3ZjVTWVcvZFdReUtp?=
 =?utf-8?B?V3N5Tkh3Rmh0c3pxVDJEMFBWTy9ZTmNlM3hCOURIOGFOUHB0Y1loUCtGOEZE?=
 =?utf-8?B?cWQ0bW1kbGlIWlNFREVLM29MWVNwOW5OcnBPK1ZROUdNb1g3UzNFZG9aQ25T?=
 =?utf-8?B?QlhyRTY4LzhEZUJNeGN4UUdZZkRLR0I4dVM1ZkxYU09kOWNkZnVPQk8rUk92?=
 =?utf-8?B?YXFoVEczblNueEJJME9lVUFuck1EbHZQN1creWwrYlRGNWQ1OEhab21TQlF4?=
 =?utf-8?B?L0NKVmp1aUV3S1g3TGw0cGVETThiS1JYSWp4MDk2WG9OV2dRQ3RiN0xFZHIw?=
 =?utf-8?B?TTA0NTlONm4xNlo4RVhmNFhBMUNYc3FteGxGcGJFRUs0RWRyMkQyU00xMDVy?=
 =?utf-8?B?RTdZai81R3p4QzJWckUvUzYxMi9yNTBzSUZFa016WDYyVGNXYUt0L1F2UDV4?=
 =?utf-8?B?aE5kRDVmRHpGd1IwT0JIcEpSVzhscDUwN3RIZlZuZmp0bG1HR0w1eDRCNERo?=
 =?utf-8?Q?d2VspEsVNc50gm6mFEg/TFTQG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e0cea4-a770-4436-47f6-08dca1f58ab5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 22:05:14.5865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ak5PjrKkjOyH//qtS+Tj3/cqIkPtFCg5p058mMgDKxRJQMT4237LU65TaePsGHH/TzIC21QNyU7dVK2m3agYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4570
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFtaHl1bmcgS2ltIDxu
YW1oeXVuZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgSnVseSAxMSwgMjAyNCAyOjQ1
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
bC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYxNiA4LzhdIHBlcmYgdGVzdDogQWRk
IHRlc3QgZm9yIEludGVsIFRQRUJTIGNvdW50aW5nDQo+IG1vZGUNCj4gDQo+IEhlbGxvLA0KPiAN
Cj4gT24gVHVlLCBKdWwgMDksIDIwMjQgYXQgMDY6MjM6NTFBTSArMDAwMCwgV2FuZywgV2VpbGlu
IHdyb3RlOg0KPiA+ID4gT24gTW9uLCBKdWwgOCwgMjAyNCBhdCA5OjU44oCvUE0gV2FuZywgV2Vp
bGluIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+DQo+ID4gPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+
ID4NCj4gPiA+ID4NCj4gPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4g
PiA+IEZyb206IE5hbWh5dW5nIEtpbSA8bmFtaHl1bmdAa2VybmVsLm9yZz4NCj4gPiA+ID4gPiBT
ZW50OiBNb25kYXksIEp1bHkgOCwgMjAyNCA5OjQ0IFBNDQo+ID4gPiA+ID4gVG86IFdhbmcsIFdl
aWxpbiA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiA+ID4gPiA+IENjOiBJYW4gUm9nZXJzIDxp
cm9nZXJzQGdvb2dsZS5jb20+OyBBcm5hbGRvIENhcnZhbGhvIGRlIE1lbG8NCj4gPiA+ID4gPiA8
YWNtZUBrZXJuZWwub3JnPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsg
SW5nbw0KPiBNb2xuYXINCj4gPiA+ID4gPiA8bWluZ29AcmVkaGF0LmNvbT47IEFsZXhhbmRlciBT
aGlzaGtpbg0KPiA+ID4gPiA+IDxhbGV4YW5kZXIuc2hpc2hraW5AbGludXguaW50ZWwuY29tPjsg
SmlyaSBPbHNhIDxqb2xzYUBrZXJuZWwub3JnPjsNCj4gSHVudGVyLA0KPiA+ID4gPiA+IEFkcmlh
biA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBLYW4gTGlhbmcNCj4gPGthbi5saWFuZ0BsaW51
eC5pbnRlbC5jb20+Ow0KPiA+ID4gPiA+IGxpbnV4LXBlcmYtdXNlcnNAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBUYXlsb3IsDQo+ID4gPiBQZXJyeQ0KPiA+
ID4gPiA+IDxwZXJyeS50YXlsb3JAaW50ZWwuY29tPjsgQWx0LCBTYW1hbnRoYSA8c2FtYW50aGEu
YWx0QGludGVsLmNvbT47DQo+ID4gPiBCaWdnZXJzLA0KPiA+ID4gPiA+IENhbGViIDxjYWxlYi5i
aWdnZXJzQGludGVsLmNvbT4NCj4gPiA+ID4gPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MTYg
OC84XSBwZXJmIHRlc3Q6IEFkZCB0ZXN0IGZvciBJbnRlbCBUUEVCUw0KPiA+ID4gY291bnRpbmcN
Cj4gPiA+ID4gPiBtb2RlDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBIZWxsbyBXZWlsaW4sDQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiBPbiBTYXQsIEp1bCA2LCAyMDI0IGF0IDQ6MzDigK9QTSA8d2VpbGlu
LndhbmdAaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBGcm9tOiBX
ZWlsaW4gV2FuZyA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4g
PiA+IEludGVsIFRQRUJTIHNhbXBsaW5nIG1vZGUgaXMgc3VwcG9ydGVkIHRocm91Z2ggcGVyZiBy
ZWNvcmQuIFRoZQ0KPiA+ID4gY291bnRpbmcNCj4gPiA+ID4gPiBtb2RlDQo+ID4gPiA+ID4gPiBj
b2RlIHVzZXMgcGVyZiByZWNvcmQgdG8gY2FwdHVyZSByZXRpcmVfbGF0ZW5jeSB2YWx1ZSBhbmQg
dXNlIGl0IGluDQo+IG1ldHJpYw0KPiA+ID4gPiA+ID4gY2FsY3VsYXRpb24uIFRoaXMgdGVzdCBj
aGVja3MgdGhlIGNvdW50aW5nIG1vZGUgY29kZS4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBXZWlsaW4gV2FuZyA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiA+ID4g
PiA+ID4gLS0tDQo+ID4gPiA+ID4gPiAgLi4uL3BlcmYvdGVzdHMvc2hlbGwvdGVzdF9zdGF0X2lu
dGVsX3RwZWJzLnNoICB8IDE4DQo+ID4gPiArKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiA+ID4gIGNyZWF0ZSBt
b2RlIDEwMDc1NSB0b29scy9wZXJmL3Rlc3RzL3NoZWxsL3Rlc3Rfc3RhdF9pbnRlbF90cGVicy5z
aA0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS90b29scy9wZXJmL3Rlc3Rz
L3NoZWxsL3Rlc3Rfc3RhdF9pbnRlbF90cGVicy5zaA0KPiA+ID4gPiA+IGIvdG9vbHMvcGVyZi90
ZXN0cy9zaGVsbC90ZXN0X3N0YXRfaW50ZWxfdHBlYnMuc2gNCj4gPiA+ID4gPiA+IG5ldyBmaWxl
IG1vZGUgMTAwNzU1DQo+ID4gPiA+ID4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmZlYThjYjFiODM2
Nw0KPiA+ID4gPiA+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ID4gPiA+ID4gKysrIGIvdG9vbHMvcGVy
Zi90ZXN0cy9zaGVsbC90ZXN0X3N0YXRfaW50ZWxfdHBlYnMuc2gNCj4gPiA+ID4gPiA+IEBAIC0w
LDAgKzEsMTggQEANCj4gPiA+ID4gPiA+ICsjIS9iaW4vYmFzaA0KPiA+ID4gPiA+ID4gKyMgdGVz
dCBJbnRlbCBUUEVCUyBjb3VudGluZyBtb2RlDQo+ID4gPiA+ID4gPiArIyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogR1BMLTIuMA0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gK3NldCAtZQ0K
PiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKyMgVXNlIHRoaXMgZXZlbnQgZm9yIHRlc3Rpbmcg
YmVjYXVzZSBpdCBzaG91bGQgZXhpc3QgaW4gYWxsIHBsYXRmb3Jtcw0KPiA+ID4gPiA+ID4gK2V2
ZW50PWNhY2hlLW1pc3NlczpSDQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArIyBXaXRob3V0
IHRoaXMgY21kIG9wdGlvbiwgZGVmYXVsdCB2YWx1ZSBvciB6ZXJvIGlzIHJldHVybmVkDQo+ID4g
PiA+ID4gPiArZWNobyAiVGVzdGluZyB3aXRob3V0IC0tcmVjb3JkLXRwZWJzIg0KPiA+ID4gPiA+
ID4gK3Jlc3VsdD0kKHBlcmYgc3RhdCAtZSAiJGV2ZW50IiB0cnVlIDI+JjEpDQo+ID4gPiA+ID4g
PiArW1sgIiRyZXN1bHQiID1+ICRldmVudCBdXSB8fCBleGl0IDENCj4gPiA+ID4gPiA+ICsNCj4g
PiA+ID4gPiA+ICsjIEluIHBsYXRmb3JtcyB0aGF0IGRvIG5vdCBzdXBwb3J0IFRQRUJTLCBpdCBz
aG91bGQgZXhlY3V0ZSB3aXRob3V0DQo+ID4gPiBlcnJvci4NCj4gPiA+ID4gPiA+ICtlY2hvICJU
ZXN0aW5nIHdpdGggLS1yZWNvcmQtdHBlYnMiDQo+ID4gPiA+ID4gPiArcmVzdWx0PSQocGVyZiBz
dGF0IC1lICIkZXZlbnQiIC0tcmVjb3JkLXRwZWJzIC1hIHNsZWVwIDAuMDEgMj4mMSkNCj4gPiA+
ID4gPg0KPiA+ID4gPiA+IEl0IG5ldmVyIGZpbmlzaGVzIG9uIG15IEFNRCBtYWNoaW5lLg0KPiA+
ID4gPiA+DQo+ID4gPiA+IEhpIE5hbWh5dW5nLA0KPiA+ID4gPg0KPiA+ID4gPiBEbyB5b3Ugc2Vl
IGFueSBtZXNzYWdlIHdoaWxlIGl0IGV4ZWN1dGVzPyBJcyB0aGUgcGVyZiByZWNvcmQgZm9ya2Vk
DQo+ID4gPiBzdWNjZXNzZnVsbHkNCj4gPiA+ID4gYnV0IGZhaWxlZCB0byByZXR1cm4/DQo+ID4g
Pg0KPiA+ID4gSSBkb24ndCBrbm93Li4gYWxsIEkgY2FuIGdldCBpcyBsaWtlIGJlbG93Og0KPiA+
ID4NCj4gPiA+ICQgc3VkbyAuL3BlcmYgdGVzdCB0cGVicyAtdnYNCj4gPiA+IDEyMTogdGVzdCBJ
bnRlbCBUUEVCUyBjb3VudGluZyBtb2RlOg0KPiA+ID4gLS0tIHN0YXJ0IC0tLQ0KPiA+ID4gdGVz
dCBjaGlsZCBmb3JrZWQsIHBpZCA1ODM0NzUNCj4gPiA+IFRlc3Rpbmcgd2l0aG91dCAtLXJlY29y
ZC10cGVicw0KPiA+ID4gVGVzdGluZyB3aXRoIC0tcmVjb3JkLXRwZWJzDQo+ID4gPiBeQw0KPiA+
DQo+ID4gSSB0aGluayB0aGUgcHJvYmxlbSBpcyB0aGF0IHRoZSBmb3JrZWQgInBlcmYgcmVjb3Jk
IiBlbmNvdW50ZXJlZCBlcnJvciwgd2hpY2gNCj4gPiBjYXVzZWQgdGhlIGNvbnRyb2wgZmlmbyBm
YWlsZWQgdG8gc2VuZCBhICJBQ0siIGJhY2sgYW5kIHRoZSBQSVBFIGhhbmdlZC4NCj4gPg0KPiA+
IENvdWxkIHlvdSBwbGVhc2UgdHJ5IG91dCB0aGUgZGlmZiBiZWxvdyBhbmQgc2VlIGlmIHRoZSB0
ZXN0IHdvdWxkIGZpbmlzaD8NCj4gPg0KPiA+IEFzIGZvciB0aGUgInBlcmYgcmVjb3JkIiBlcnJv
ciwgSSB0aGluayBpdCBtaWdodCBiZWNhdXNlIG9mIHRoZSBmYWtlDQo+ID4gZXZlbnQoY2FjaGUt
bWlzc2VzOlIpIGNhbm5vdCBiZSBzdXBwb3J0ZWQgaW4gQU1ELiBDb3VsZCB5b3UgcGxlYXNlIHRl
c3QNCj4gcnVuDQo+ID4gYSAicGVyZiBzdGF0IC1lIGNhY2hlLW1pc3NlczpSIC0tcmVjb3JkLXRw
ZWJzIHRydWUiIGFuZCBzZWUgaWYgaXQgY29tcGxhaW5zDQo+IGFib3V0DQo+ID4gdGhlIGV2ZW50
Pw0KPiANCj4gU28gSSB0cmllZCB0aGUgYmVsb3cgcGF0Y2ggYW5kIGl0IHdvcmtlZC4NCj4gDQo+
ICAgJCAuL3BlcmYgdGVzdCAtdiB0cGVicw0KPiAgIDEyMTogdGVzdCBJbnRlbCBUUEVCUyBjb3Vu
dGluZyBtb2RlOg0KPiAgIC0tLSBzdGFydCAtLS0NCj4gICB0ZXN0IGNoaWxkIGZvcmtlZCwgcGlk
IDIxOTAxNzQNCj4gICBUZXN0aW5nIHdpdGhvdXQgLS1yZWNvcmQtdHBlYnMNCj4gICBUZXN0aW5n
IHdpdGggLS1yZWNvcmQtdHBlYnMNCj4gICAtLS0tIGVuZCgtMSkgLS0tLQ0KPiAgIDEyMTogdGVz
dCBJbnRlbCBUUEVCUyBjb3VudGluZyBtb2RlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDogRkFJTEVEIQ0KPiANCj4gSXQgd291bGQgYmUgYmV0dGVyIGlmIGl0IGNhbiBza2lwIHJh
dGhlciB0aGFuIGZhaWwgb24NCj4gbm9uLXN1cHBvcnRlZCBtYWNoaW5lcy4NCj4gDQoNClllcywg
SSBjb3VsZCBhZGQgYSBjaGVjayB0byBvbmx5IHJ1biB0aGUgdGVzdCBvbiBJbnRlbCBwbGF0Zm9y
bS4gDQoNCj4gQWxzbyBJIHNhdyB0aGlzIG1lc3NhZ2Ugd2hlbiBJIHJ1biB0aGUgY29tbWFuZCBt
YW51YWxseS4NCj4gDQo+ICAgJCAuL3BlcmYgc3RhdCAtZSBjYWNoZS1taXNzZXM6UiAtLXJlY29y
ZC10cGVicyAtdiB0cnVlDQo+ICAgQ29udHJvbCBkZXNjcmlwdG9yIGlzIG5vdCBpbml0aWFsaXpl
ZA0KPiAgIFJldGlyZV9sYXRlbmN5IG9mIGV2ZW50IGNhY2hlLW1pc3NlczpSIGlzIHJlcXVpcmVk
DQo+ICAgUHJlcGFyZSBwZXJmIHJlY29yZCBmb3IgcmV0aXJlX2xhdGVuY3kNCj4gICBFcnJvcjoN
Cj4gICBUaGUgY2FjaGUtbWlzc2VzOnB1IGV2ZW50IGlzIG5vdCBzdXBwb3J0ZWQuDQo+ICAgaW5j
b21wYXRpYmxlIGZpbGUgZm9ybWF0DQo+ICAgaW5jb21wYXRpYmxlIGZpbGUgZm9ybWF0IChyZXJ1
biB3aXRoIC12IHRvIGxlYXJuIG1vcmUpDQo+ICAgZmFpbGVkOiBkaWQgbm90IHJlY2VpdmVkIGFu
IGFjaw0KPiAgIGNhY2hlLW1pc3NlczpSOiAwIDEgMQ0KPiANCj4gICAgUGVyZm9ybWFuY2UgY291
bnRlciBzdGF0cyBmb3IgJ3RydWUnOg0KPiANCj4gICAgICAgICAgICAgICAgICAgIDAgICAgICBj
YWNoZS1taXNzZXM6Ug0KPiANCj4gICAgICAgICAgMC4wMDAwMDQ5Mzkgc2Vjb25kcyB0aW1lIGVs
YXBzZWQNCj4gDQo+ICAgICAgICAgIDAuMDAwMDAwMDAwIHNlY29uZHMgdXNlcg0KPiAgICAgICAg
ICAwLjAwMDAwMDAwMCBzZWNvbmRzIHN5cw0KPiANCj4gSSdtIG5vdCBzdXJlIHdoeSBpdCBzaG93
ZWQgdGhlIGluY29tcGF0aWJsZSBmaWxlIGZvcm1hdCBtZXNzYWdlLg0KPiANCg0KVGhlIG91dHB1
dCBtYXRjaGVzIHdpdGggbXkgZXhwZWN0YXRpb24uIEkgdGhpbmsgdGhlIGluY29tcGF0aWJsZSBm
aWxlIGZvcm1hdCANCm1lc3NhZ2UgaXMgZnJvbSB0aGUgc2Vzc2lvbiBvcGVuIHN0ZXAgb2YgdGhl
IHNhbXBsZSByZWFkZXIgdGhyZWFkLiANCg0KQmVjYXVzZSBBTUQgQ1BVIGRvZXMgbm90IHN1cHBv
cnQgY2FjaGUtbWlzc2VzOnAgaW4gInBlcmYgcmVjb3JkIiwgdGhlIGNvbnRyb2wgDQpmaWZvIGRv
ZXMgbm90IHJlY2VpdmUgYSAiQUNLIiBtZXNzYWdlIGJhY2sgZnJvbSAicGVyZiByZWNvcmQiLiBU
aGVyZWZvcmUsIHRoZSANCmFja19mZCBQSVBFIGhhbmdlZCBhbmQgdGhlIHRlc3QgbmV2ZXIgZW5k
cy4gDQoNCkhvd2V2ZXIsIHRoZSBzYW1wbGUgcmVhZGVyIHRocmVhZCBvcGVucyB0aGUgc2Vzc2lv
biBpbiBwYXJhbGxlbC4gQmVjYXVzZSB0aGUgDQoicGVyZiByZWNvcmQiIGlzIG5vdCBzdWNjZXNz
ZnVsbHkgc3RhcnRlZCwgdGhlIHNhbXBsZSBkYXRhIFBJUEUgaXMgbm90IHJlYWR5IGFuZCB3ZSAN
CmdldCB0aGlzIGluY29tcGF0aWJsZSBmaWxlIGZvcm1hdCBlcnJvci4gDQoNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS90b29scy9wZXJmL3V0aWwvaW50ZWwtdHBlYnMuYyBiL3Rvb2xzL3BlcmYvdXRp
bC9pbnRlbC10cGVicy5jDQo+ID4gaW5kZXggYTA1ODVhNjU3MWI1Li41YjhlMTA0ZjM2ZjEgMTAw
NjQ0DQo+ID4gLS0tIGEvdG9vbHMvcGVyZi91dGlsL2ludGVsLXRwZWJzLmMNCj4gPiArKysgYi90
b29scy9wZXJmL3V0aWwvaW50ZWwtdHBlYnMuYw0KPiA+IEBAIC0yNjMsNiArMjYzLDcgQEAgaW50
IHRwZWJzX3N0YXJ0KHN0cnVjdCBldmxpc3QgKmV2c2VsX2xpc3QpDQo+ID4gICAgICAgICB9DQo+
ID4NCj4gPiAgICAgICAgIGlmICh0cGVic19ldmVudF9zaXplID4gMCkgew0KPiA+ICsgICAgICAg
ICAgICAgICBzdHJ1Y3QgcG9sbGZkIHBvbGxmZCA9IHsgLmV2ZW50cyA9IFBPTExJTiwgfTsNCj4g
PiAgICAgICAgICAgICAgICAgaW50IGNvbnRyb2xfZmRbMl0sIGFja19mZFsyXSwgbGVuOw0KPiA+
ICAgICAgICAgICAgICAgICBjaGFyIGFja19idWZbOF07DQo+ID4NCj4gPiBAQCAtMjk3LDYgKzI5
OCwxOSBAQCBpbnQgdHBlYnNfc3RhcnQoc3RydWN0IGV2bGlzdCAqZXZzZWxfbGlzdCkNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICBnb3RvIG91dDsNCj4gPiAgICAgICAgICAgICAgICAgfQ0K
PiA+DQo+ID4gKyAgICAgICAgICAgICAgIC8qIHdhaXQgZm9yIGFuIGFjayAqLw0KPiA+ICsgICAg
ICAgICAgICAgICBwb2xsZmQuZmQgPSBhY2tfZmRbMF07DQo+ID4gKw0KPiA+ICsgICAgICAgICAg
ICAgICBpZiAoIXBvbGwoJnBvbGxmZCwgMSwgMjAwMCkpIHsNCj4gDQo+IElzIGl0IDIgc2Vjb25k
cz8gIEFueSBzcGVjaWZpYyByZWFzb24gZm9yIHRoZSB2YWx1ZT8NCj4gQXQgbGVhc3Qgd2UgbmVl
ZCBhIGNvbW1lbnQgdG8gZXhwbGFpbiB0aGUgdmFsdWUgKG9yIGp1c3Qgc2F5aW5nIGl0J3MgYQ0K
PiByYW5kb20gb25lKS4NCg0KSXQncyBpbXBvcnRhbnQgdG8gaGF2ZSB0aGlzIHBvbGwuIEJ1dCB0
aGUgdGltZSBpcyByYW5kb20uIFBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3UgaGF2ZSANCmFueSBz
dWdnZXN0aW9ucyBvbiB0aGUgdmFsdWUuIE90aGVyd2lzZSwgSSBjb3VsZCBhZGQgYSBjb21tZW50
ICBzYXlpbmcgdGhpcyBpcyBhIHJhbmRvbSANCnZhbHVlLiANCg0KVGhhbmtzLA0KV2VpbGluDQoN
Cj4gDQo+IFRoYW5rcywNCj4gTmFtaHl1bmcNCj4gDQo+IA0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHByX2VycigiZmFpbGVkOiBwZXJmIHJlY29yZCBhY2sgdGltZW91dFxuIik7DQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+ID4gKyAgICAgICAgICAgICAgIH0N
Cj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIGlmICghKHBvbGxmZC5yZXZlbnRzICYgUE9MTElO
KSkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHByX2VycigiZmFpbGVkOiBkaWQgbm90
IHJlY2VpdmVkIGFuIGFja1xuIik7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZ290byBv
dXQ7DQo+ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiArDQo+ID4gICAgICAgICAgICAgICAgIHJl
dCA9IHJlYWQoYWNrX2ZkWzBdLCBhY2tfYnVmLCBzaXplb2YoYWNrX2J1ZikpOw0KPiA+ICAgICAg
ICAgICAgICAgICBpZiAocmV0ID4gMCkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICByZXQg
PSBzdHJjbXAoYWNrX2J1ZiwgImFja1xuIik7DQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gV2VpbGlu
DQo=
