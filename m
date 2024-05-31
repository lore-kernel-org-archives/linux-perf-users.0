Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0F384E08;
	Fri, 31 May 2024 23:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717196653; cv=fail; b=NSALRrDT5W7HCvAucJqamSyYZUg90PWEF9yS6pIvp4Y/yincPhTiB313N7WO6KaGL5We21D1Ey7CXy4jVqePPopHx9bQbEYyahnLoemXKolOLO7DcuqbNXuW8BGNWbvfSPnmodtjlR2vUF+LmFHlRuJY8SX23lHWCNI9SbVzw1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717196653; c=relaxed/simple;
	bh=KtW5vtk9YC6QTIE2cebSD+5SZBuE/PNoR5wpQVnr6FA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GP/PjXe7lVbGr9706fuPY06xr7Oau0kgaIDbMbdlC79Yc+BM8t19sclCc9yXV0Yq5B+ZvnDYdIV4FQE/LAZOBi55hu7VjgN8FFQ7iJsZSiDqOrpLvNdL9LC6C1jYWnr6Ibz7BNHnDO4q8g4ZeZxGvtHQr2VY8bR6UHNEOtiwIEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jDCyoUNY; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jDCyoUNY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717196652; x=1748732652;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KtW5vtk9YC6QTIE2cebSD+5SZBuE/PNoR5wpQVnr6FA=;
  b=jDCyoUNYn05R69WARVKmr5pu7+u3dkrc/+VnzvICc2dc6sg9P17mbWni
   MEzaZ8aQHCqCTrbUd6wx8tVRXsm40wgiW3zVax1lf8b5NeJUsi5l4oBW6
   4ZVjRRvIqkszs5ET2VMrP7Rqu3v7VtIHZVqtQSu+qXq+VDR53Sdmofgp1
   XeXX6q5gudioKUQg1JQZ6XS0+648wntw1UyLftoq80UzF/rWkB8kIcPJi
   khOOf47PsMqTilD2FcSFkE6dwzq0+9MLq3wAW3gfsSfpusuYXmAlN/VgE
   GpgjBo3NQxusbbSQXi9DoeMiMDTIx5T4ZCPJ2x+Zk8nj7BNPMj3T7QNmr
   w==;
X-CSE-ConnectionGUID: tZhyoP0aTZi9+fXzSqQOSA==
X-CSE-MsgGUID: 46n//m3LSqGVmeZ4Er5MJA==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13602409"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="13602409"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 16:04:11 -0700
X-CSE-ConnectionGUID: QmA+9ahrSfWIy0PEKyMdDQ==
X-CSE-MsgGUID: c9BHsw9FS/OHZU3idgN0fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="67496657"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 May 2024 16:04:11 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 May 2024 16:04:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 31 May 2024 16:04:10 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 31 May 2024 16:04:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWp+RfK2aldGlCpjB4BN5pqztv75ArAb3QC7uzKGWU7LzJfWYO1df1jk74WGVQWfIbLhAYOl32f5+mXZCzzKduPGAc8WpjiWuZTRkAsrmmBjSWR4F7mZJ4s6b/lAdT7SpmScOd/oeQ0kngd3F1RPtJR6Xb9c+dMgHFSHilObXv/llF8KBy1m7EqXw1ufdnK1oGjrq1NU5Tj6XAI0wsBDSutFiYmS/gZljzNXtrwVsH8tDsBmewY2lmS0enXKIlPalgBsZU0LsA/cuGH8mKtx4sJ6H/IPVwSIiyaW2qIQF7hZQbAw4Wdd5ehks6+iwLbAiSKgpbcS3w4nRflOliDMkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtW5vtk9YC6QTIE2cebSD+5SZBuE/PNoR5wpQVnr6FA=;
 b=BzP9eyOmTq+V3/Umefh03ChAKP8QAKkQ77Pj49cPbMuD4/HVUsY6ieeu922UYQoFGx6wP7ERBaDbqeqrtxuit5scJ7Y0m4En29B/bX2l4JEKfH1HydVxrceRAGQm34/zrtlXY8+tGR985uiDaRxQ9iC1t5bhraH2y+Xx8lbU5G/K49jZQsqLXAy+uqB1h2bDeha1qUpq4vMpzCxDz29W2AvAkVXIxKUCUr158Waw1RwEUo4OCMFb2XNOcHHgJBNtZzljk1aehA/Q+Pf0xLDHL1PRq40JRKx8lHR5KA3+wgDeXktwJbrVvxY9+xs9SDn5KjBOGDmsjv4/WxBA1lZWTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by BN9PR11MB5225.namprd11.prod.outlook.com (2603:10b6:408:132::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 23:04:07 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%4]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 23:04:07 +0000
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
Subject: RE: [RFC PATCH v10 3/8] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Thread-Topic: [RFC PATCH v10 3/8] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Thread-Index: AQHasZOLBmxpfW94l0mGq/Yp4ybyB7Gw59CAgAAAZpCAAPrEAIAAF21g
Date: Fri, 31 May 2024 23:04:07 +0000
Message-ID: <CO6PR11MB563534A683995CCCD6717BB3EEFC2@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240529064327.4080674-1-weilin.wang@intel.com>
 <20240529064327.4080674-4-weilin.wang@intel.com>
 <CAM9d7cgSwZ3PU3H9VNvxQakocEZ_CQEqB9M1o3xTMdJ7F1sufQ@mail.gmail.com>
 <CO6PR11MB56357F58D99B17CD08671A26EEFC2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7cjbHzgfW2fKQkZ2=gtEMD9N5wG4xaWgPU+N-YvmfhXviQ@mail.gmail.com>
In-Reply-To: <CAM9d7cjbHzgfW2fKQkZ2=gtEMD9N5wG4xaWgPU+N-YvmfhXviQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|BN9PR11MB5225:EE_
x-ms-office365-filtering-correlation-id: 73f50555-c968-46b9-999a-08dc81c5f9b3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?dmdFa2l6Z3lFc0dNU1ZMUVM3cllWeFhjUlVSN0hUdTFoVVFaTXk4QWRsZTA2?=
 =?utf-8?B?UXBTdy9QUnRYZGpyMDdVdjdDR3BoOE41RTAxRUlZMW1ENnp0MzNSaE9DYkRC?=
 =?utf-8?B?VlI2Nk1NUVpVc0ZQOXE2L1crN2w5dGk5eWxHOHFrTkZubTRUd0lCN09WYWFR?=
 =?utf-8?B?UmN1QzltSGZFQ3F5ZTFzVG43b2ZFcDZrZmxCc3FPL3YrUTU1NGZkUmExMmVK?=
 =?utf-8?B?Z2VLZnNwNkRTM3V5cHYvejRMeUpFTXovb1gwOG84SW5SazVsNEFpMDdGdkQ2?=
 =?utf-8?B?SlRWSHVuRHVub29nNFFOcW5YL0piZzczY2RZaktrTmcvZGFyYlp5dGRabVU3?=
 =?utf-8?B?MmhKcVkxTExMTTdtSTR3VjVzQzVSTzM2TU9RbEVaWWxRbFM1UHU4TEcxajY1?=
 =?utf-8?B?cGhUOTI4MklkY01qNmNZMjVBZXp6QXpadW5wYUJYbk1nVFJROEhyVVU2TzM0?=
 =?utf-8?B?Q1pPeVdoZGNnR0hUdmZWTFRscjlQTHF3VGsrK3BuV2t3ckJma3N0MWw0SmZx?=
 =?utf-8?B?OEV6K1ZrTTFqVWhFWklNSzNEMldaMGtVREhIaEhVRll1SjdpY3dEODl5cjZu?=
 =?utf-8?B?dzVTd3oxS2xLSGtQRmZUaThad3FEeC9xNTRLMlVKL3R0elR4WUJYS1paNHhv?=
 =?utf-8?B?WWF6L1ZpYWJaWDVvUGU4WjhzY2g0UTZFb3BTVlpzRUhoZjVsWjQyVWdFb0V0?=
 =?utf-8?B?MERlU3dybWt0aTFWM1VndlRRUzZLUWxZa0h0NDhxOW0vSGlKY09OTzNrZmlN?=
 =?utf-8?B?aU1kazN3c3hPOWtRUndhd084ZUhjS2FUUXRVbEZ0bEoyYlM3VHZyRkpVaUsx?=
 =?utf-8?B?UFB2aDdxczRQbDE3eVJ5N3Zqcitja01CWlY4bW9nUlJOUFVTNkY0eERESjVo?=
 =?utf-8?B?V1JLK0I1NFpoOWFTejVMNy9zTTZLVU9hK1l4azBNQ1dFS0x6R1JHcmFmaDNL?=
 =?utf-8?B?eVJpQjN1djhDOW05dzQvSm1RV0tvTjNtYTRPRjJodXNDU2ZwNENpQm95VENs?=
 =?utf-8?B?RTBpZGVnZ0tFQVhwamlNWXphaENyMkp5OWdvMHY2UnpsRDlxRXkvZVp0OGtM?=
 =?utf-8?B?N21kMUVQVTdwd2lGMXNVNGJsa1R6Qm9UUGpKYTlvOU9DRG5pd25UYWI0WHRT?=
 =?utf-8?B?cVRIemtzS2NTS2pnK1Y5SlNSK2M2S2xwOFZVYnBVa00wc2dmbXhUbytPVVMz?=
 =?utf-8?B?Zzd5a0YzQVZtWVJXbW5Db3hNbU8rb0JlQ0pKT2pkYnJ1T2tlaC93R2sra1ha?=
 =?utf-8?B?QUpBM1ZaNzVZUmEzZ1ovU0dOZm9xdGhFdHFKay8rSks5bHFyV0lKYVpXK3g0?=
 =?utf-8?B?Wm12UlBQanpTcmlnVWtaTFFabGNveFBxRy8rYmsrTWE3YVpadU1lTWtBdCts?=
 =?utf-8?B?TVJNN1cxZlBxRExxZmVvckpyeUM3TnhKNnZOOUNTWElKOTNUbjFuUjUzYSsw?=
 =?utf-8?B?VWpvaHBMQi8rOE44NHdXWU5lTGpScFVMbmZUZDZsRy9waWxwcE1neUJ2WGZE?=
 =?utf-8?B?eC9JNWRIcU5rODJMYm03L0ttd3gzeDBOWGhSelVLQWtMWStYYXZUMG1seTZK?=
 =?utf-8?B?Ym1NNXorVlVnOU9JR09EQ3h2cW9ZQkFhYTNHYk1PSEJ6dkt5Qk5reGVCK0ZJ?=
 =?utf-8?B?Um51elVWeHpVMTRLbjFVVURqOVgxU1RLTGo5dnJFSmFrZUNNZnlIdkE5Z0hm?=
 =?utf-8?B?QVFXNUx1MXhBWWJ4ekZiNnNJcmpPakFkM0x6OStQZTU1bHg2UUhBd1Y1Y3Vo?=
 =?utf-8?B?OGJnbmFYcld1SnNSLzZhS3RLSmdSU0RZVG93dWNma1hUS1JHTTF3Vmx5RUd6?=
 =?utf-8?B?MFU4TjJNek9Qb3ltaytmZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnQyR0VhbnQxTGRtQWdubWE1UlUzVFdOQXZjVkJhT3ExbElLTG1BUjhlL0Fm?=
 =?utf-8?B?dHF0S21nbTRiVFoyc2N0bWp4ZGhBRlNxeGJpbng2STZkbkRSbElXaTFpL0F6?=
 =?utf-8?B?YXdEUWJ6U3RTc1RlSzVSYzloSTlUbjRncTlaclpYNi9TeFdBcmhpMjBRVElU?=
 =?utf-8?B?L3o0NVZmQnJXejh3Wm55bU5sNFZwRUFod3pKby9QSnNJNkdPTW4yNzVlc29D?=
 =?utf-8?B?d2QvVGdYK1FTU292T3pkMHVlUWY0TXUyOXFac3lrUy95NS83QmRIMEk4RDNY?=
 =?utf-8?B?MFd6SkZrK2dJQnJQSndDdnVuMW5SemMyOHRDdmdpTFpQQkJ4d0JHVWVJa0hQ?=
 =?utf-8?B?V1IwYk5VUVJDcTZlN21yc3BzazV0OTg4MW8zZjNqSm9EL3ZqUXRaN3lwelpn?=
 =?utf-8?B?NEc1eFE2YTl0Qzc2ZTJaQUsrZE40VmdtRUl4WTNKRHlBZ3lBSUVYT3MvYTNx?=
 =?utf-8?B?R0hOQXFtN0ExVHExSkRGaUlkVFFCZ3lXQ1BXYUVHQWszaTEydHdoRlRVTUVI?=
 =?utf-8?B?NGljVk5lT3dNMDZXUHJNRDY3bGVCem1uak1Nb3N6T2o0S3hFYkwveldsbzVr?=
 =?utf-8?B?eEp0SzJEVnZaT1ZnQ2pGK21RakNibjBWdW5za1AwdUh2eDV0djdjb2VTenQw?=
 =?utf-8?B?OUdpVlkvdVNsUi9hZUZRSDhMSHlPV3krWkk0NlZES1VMdlFYU1ZKaGwyRExk?=
 =?utf-8?B?aG5qQTNqTkZCbE56aVgrTmpVcS9qYWY2K2JaUWtkWVArbnl3Y0hmZ2pUVHN3?=
 =?utf-8?B?eGk2ZDNGSnlUVXJ6bTczWHJRRDNQNlBQcjYxUlh6Y0FBMmVvWUJ0SVlVb1dZ?=
 =?utf-8?B?L3JKeTVHSC96aHlRRnI4NENtU01uVkVwMFp0SmtQUVl3aVlIZm5lRGk4bDB6?=
 =?utf-8?B?aStlaHlBcVBFY3BCYlhkRWJrWEN3U1l6T0dDSmNGelFGOGpKaHNLbFl6bGlG?=
 =?utf-8?B?OE5FTFBsRXErWExQcFM3S0d4cFBWR0w1N2t1b1NldW5rajBSL09RY1A5aVF2?=
 =?utf-8?B?TE9nU2RJaHlkSWFDaFFkN09zbFNQblF4Ty9vanlwOVY3RHExNEhzaFJJaC9M?=
 =?utf-8?B?NFRKc3prZU5XR0VaQ1FlbGFiZVB4NVNVR0RGUVR6NmlCWmIzQUNnWnU0UERJ?=
 =?utf-8?B?N2pUUDA2cWR2Y3BuR3pUdy8xTTNpdVByL2dITlFjcnRac29WMU1mNzg2aGlM?=
 =?utf-8?B?ell4UUxwRDU2VFlkZ2VnVXlBSGYxQ05HVjFXUnMyeDRvNXVNZEp2ZDZCalZ2?=
 =?utf-8?B?R1lhL0ZGbC9GZEFGN210SG5pU1F2SFg5SWQyd0xIUGdIN3JFcFYyZnZZNjlN?=
 =?utf-8?B?OWM5L3BIeUNqN1FhRUtGcUdvQUJTQ2Q0K2twR3BsWTVhSzlFQ1U3RlRIL3BV?=
 =?utf-8?B?TUFKNnhFZjRZRnE5ajhYT1pScXBzZURFQkc0dS85dDNXZUZaSlMyRXV2RUhY?=
 =?utf-8?B?MXM3ZmpVaUJFTXFUMDRBSTROTXpiQXhHUGM3WVZPNUROYUhuQXQyQzN2Y2V5?=
 =?utf-8?B?R3IzSVROamN0dVZhcmR3V0FuSWJGbkwveFhJOGVYSHVseHdPUlM3VklDb1dZ?=
 =?utf-8?B?cDB6TmhSWk9RM1AwaW10WFVmZGtuRzlzZGkveFpkMitqQ0xRVFNzVGkvQ0Ry?=
 =?utf-8?B?OVk3QU9NTUdRSUtPNDRjWDJXMkV1MFFPdUxETDZyNzhrQ3lRYXBPUGRUTDBY?=
 =?utf-8?B?S1pqTCtvWkY0anZHV0pDQ0pDSFhzemxGSXp4ZFNZRTROd0daVmNxcHkwUVVS?=
 =?utf-8?B?MGxJRUZrbHNZV1B0K0VMc250SFFpV3RLOUw1aWZqWml1MVlEbnhzb29xaVJU?=
 =?utf-8?B?SkFrZkY1QnAzcGFtTmFicmF0RFd5cEZSalNzeE1mQVdZYklydnYrOW1JOFdV?=
 =?utf-8?B?ZFVqQnltSlNza0JqSkR2YlpHQVI0WXdHUFk1VG1HcDhYT3NNKzYvWElGcjRv?=
 =?utf-8?B?djZNWG9NTzdRYmVvdThsa3pXbG1WK3p0NTRGK2xnNk1WWE5KTWYwQURxQjZC?=
 =?utf-8?B?Q1hhS0xsTUFkQkxpaHk1Q1FLeTNnWElSYko2dWI4Q3ZEaXB4SEViRk5SNEhN?=
 =?utf-8?B?UCs5UitKR256UlF4alJNVGovanNCdjFZanNNK0dSblhUTUhMZFVXZ0t2K2Vv?=
 =?utf-8?Q?E0AcUmDaTBOVpM5sJ41LWgA8Y?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f50555-c968-46b9-999a-08dc81c5f9b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 23:04:07.7457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kL8/lZrOUwq1KJ5sCo2Ft+MwAap7aFDhj4528NGK0nlrp7wSgoxu3uUFK+qvy+p6yU+frrrI2wOMjzAT+lr1Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5225
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFtaHl1bmcgS2ltIDxu
YW1oeXVuZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBGcmlkYXksIE1heSAzMSwgMjAyNCAyOjQwIFBN
DQo+IFRvOiBXYW5nLCBXZWlsaW4gPHdlaWxpbi53YW5nQGludGVsLmNvbT4NCj4gQ2M6IElhbiBS
b2dlcnMgPGlyb2dlcnNAZ29vZ2xlLmNvbT47IEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbw0KPiA8
YWNtZUBrZXJuZWwub3JnPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsg
SW5nbyBNb2xuYXINCj4gPG1pbmdvQHJlZGhhdC5jb20+OyBBbGV4YW5kZXIgU2hpc2hraW4NCj4g
PGFsZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb20+OyBKaXJpIE9sc2EgPGpvbHNhQGtl
cm5lbC5vcmc+OyBIdW50ZXIsDQo+IEFkcmlhbiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBL
YW4gTGlhbmcgPGthbi5saWFuZ0BsaW51eC5pbnRlbC5jb20+Ow0KPiBsaW51eC1wZXJmLXVzZXJz
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgVGF5bG9yLCBQ
ZXJyeQ0KPiA8cGVycnkudGF5bG9yQGludGVsLmNvbT47IEFsdCwgU2FtYW50aGEgPHNhbWFudGhh
LmFsdEBpbnRlbC5jb20+OyBCaWdnZXJzLA0KPiBDYWxlYiA8Y2FsZWIuYmlnZ2Vyc0BpbnRlbC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYxMCAzLzhdIHBlcmYgc3RhdDogRm9yayBh
bmQgbGF1bmNoIHBlcmYgcmVjb3JkIHdoZW4NCj4gcGVyZiBzdGF0IG5lZWRzIHRvIGdldCByZXRp
cmUgbGF0ZW5jeSB2YWx1ZSBmb3IgYSBtZXRyaWMuDQo+IA0KPiBPbiBUaHUsIE1heSAzMCwgMjAy
NCBhdCAxMTo0NuKAr1BNIFdhbmcsIFdlaWxpbiA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiB3
cm90ZToNCj4gPg0KPiA+DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4gPiBGcm9tOiBOYW1oeXVuZyBLaW0gPG5hbWh5dW5nQGtlcm5lbC5vcmc+DQo+ID4gPiBTZW50
OiBUaHVyc2RheSwgTWF5IDMwLCAyMDI0IDExOjQxIFBNDQo+ID4gPiBUbzogV2FuZywgV2VpbGlu
IDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+DQo+ID4gPiBDYzogSWFuIFJvZ2VycyA8aXJvZ2Vyc0Bn
b29nbGUuY29tPjsgQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxvDQo+ID4gPiA8YWNtZUBrZXJuZWwu
b3JnPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsgSW5nbyBNb2xuYXIN
Cj4gPiA+IDxtaW5nb0ByZWRoYXQuY29tPjsgQWxleGFuZGVyIFNoaXNoa2luDQo+ID4gPiA8YWxl
eGFuZGVyLnNoaXNoa2luQGxpbnV4LmludGVsLmNvbT47IEppcmkgT2xzYSA8am9sc2FAa2VybmVs
Lm9yZz47IEh1bnRlciwNCj4gPiA+IEFkcmlhbiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBL
YW4gTGlhbmcgPGthbi5saWFuZ0BsaW51eC5pbnRlbC5jb20+Ow0KPiA+ID4gbGludXgtcGVyZi11
c2Vyc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFRheWxv
ciwNCj4gUGVycnkNCj4gPiA+IDxwZXJyeS50YXlsb3JAaW50ZWwuY29tPjsgQWx0LCBTYW1hbnRo
YSA8c2FtYW50aGEuYWx0QGludGVsLmNvbT47DQo+IEJpZ2dlcnMsDQo+ID4gPiBDYWxlYiA8Y2Fs
ZWIuYmlnZ2Vyc0BpbnRlbC5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MTAg
My84XSBwZXJmIHN0YXQ6IEZvcmsgYW5kIGxhdW5jaCBwZXJmIHJlY29yZA0KPiB3aGVuDQo+ID4g
PiBwZXJmIHN0YXQgbmVlZHMgdG8gZ2V0IHJldGlyZSBsYXRlbmN5IHZhbHVlIGZvciBhIG1ldHJp
Yy4NCj4gPiA+DQo+ID4gPiBPbiBUdWUsIE1heSAyOCwgMjAyNCBhdCAxMTo0M+KAr1BNIDx3ZWls
aW4ud2FuZ0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBGcm9tOiBXZWlsaW4g
V2FuZyA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiA+ID4gPg0KPiA+ID4gPiBXaGVuIHJldGly
ZV9sYXRlbmN5IHZhbHVlIGlzIHVzZWQgaW4gYSBtZXRyaWMgZm9ybXVsYSwgZXZzZWwgd291bGQg
Zm9yayBhDQo+IHBlcmYNCj4gPiA+ID4gcmVjb3JkIHByb2Nlc3Mgd2l0aCAiLWUiIGFuZCAiLVci
IG9wdGlvbnMuIFBlcmYgcmVjb3JkIHdpbGwgY29sbGVjdA0KPiByZXF1aXJlZA0KPiA+ID4gPiBy
ZXRpcmVfbGF0ZW5jeSB2YWx1ZXMgaW4gcGFyYWxsZWwgd2hpbGUgcGVyZiBzdGF0IGlzIGNvbGxl
Y3RpbmcgY291bnRpbmcNCj4gdmFsdWVzLg0KPiA+ID4gPg0KPiA+ID4gPiBBdCB0aGUgcG9pbnQg
b2YgdGltZSB0aGF0IHBlcmYgc3RhdCBzdG9wcyBjb3VudGluZywgZXZzZWwgd291bGQgc3RvcCBw
ZXJmDQo+ID4gPiByZWNvcmQNCj4gPiA+ID4gYnkgc2VuZGluZyBzaWd0ZXJtIHNpZ25hbCB0byBw
ZXJmIHJlY29yZCBwcm9jZXNzLiBTYW1wbGVkIGRhdGEgd2lsbCBiZQ0KPiA+ID4gcHJvY2Vzcw0K
PiA+ID4gPiB0byBnZXQgcmV0aXJlIGxhdGVuY3kgdmFsdWUuDQo+ID4gPiA+DQo+ID4gPiA+IEFu
b3RoZXIgdGhyZWFkIGlzIHJlcXVpcmVkIHRvIHN5bmNocm9uaXplIGJldHdlZW4gcGVyZiBzdGF0
IGFuZCBwZXJmDQo+IHJlY29yZA0KPiA+ID4gPiB3aGVuIHdlIHBhc3MgZGF0YSB0aHJvdWdoIHBp
cGUuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFdlaWxpbiBXYW5nIDx3ZWlsaW4u
d2FuZ0BpbnRlbC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gW1NOSVBdDQo+ID4gPiA+ICtpbnQg
dHBlYnNfc2V0X2V2c2VsKHN0cnVjdCBldnNlbCAqZXZzZWwsIGludCBjcHVfbWFwX2lkeCwgaW50
IHRocmVhZCkNCj4gPiA+ID4gK3sNCj4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgcGVyZl9jb3VudHNf
dmFsdWVzICpjb3VudDsNCj4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgdHBlYnNfcmV0aXJlX2xhdCAq
dDsNCj4gPiA+ID4gKyAgICAgICBib29sIGZvdW5kID0gZmFsc2U7DQo+ID4gPiA+ICsgICAgICAg
X191NjQgdmFsOw0KPiA+ID4gPiArICAgICAgIGludCByZXQ7DQo+ID4gPiA+ICsNCj4gPiA+ID4g
KyAgICAgICAvKiBOb24gcmVpdHJlX2xhdGVuY3kgZXZzZWwgc2hvdWxkIG5ldmVyIGVudGVyIHRo
aXMgZnVuY3Rpb24uICovDQo+ID4gPiA+ICsgICAgICAgaWYgKCFldnNlbF9faXNfcmV0aXJlX2xh
dChldnNlbCkpDQo+ID4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLTE7DQo+ID4gPiA+ICsN
Cj4gPiA+ID4gKyAgICAgICByZXQgPSB0cGVic19zdG9wKCk7DQo+ID4gPiA+ICsgICAgICAgaWYg
KHJldCkNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gPiA+ICsNCj4g
PiA+ID4gKyAgICAgICBjb3VudCA9IHBlcmZfY291bnRzKGV2c2VsLT5jb3VudHMsIGNwdV9tYXBf
aWR4LCB0aHJlYWQpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgbGlzdF9mb3JfZWFjaF9l
bnRyeSh0LCAmdHBlYnNfcmVzdWx0cywgbmQpIHsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIGlm
ICghc3RyY21wKHQtPnRwZWJzX25hbWUsIGV2c2VsLT5uYW1lKSB8fCAhc3RyY21wKHQtDQo+ID4g
PiA+dHBlYnNfbmFtZSwgZXZzZWwtPm1ldHJpY19pZCkpIHsNCj4gPiA+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgZm91bmQgPSB0cnVlOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBicmVhazsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiA+ID4gKyAgICAgICB9DQo+
ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICAvKiBTZXQgZW5hIGFuZCBydW4gdG8gbm9uLXplcm8g
Ki8NCj4gPiA+ID4gKyAgICAgICBjb3VudC0+ZW5hID0gY291bnQtPnJ1biA9IDE7DQo+ID4gPiA+
ICsgICAgICAgY291bnQtPmxvc3QgPSAwOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgaWYg
KCFmb3VuZCkgew0KPiA+ID4gPiArICAgICAgICAgICAgICAgLyoNCj4gPiA+ID4gKyAgICAgICAg
ICAgICAgICAqIFNldCBkZWZhdWx0IHZhbHVlIG9yIDAgd2hlbiByZXRpcmVfbGF0ZW5jeSBmb3Ig
dGhpcyBldmVudCBpcw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICogbm90IGZvdW5kIGZyb20g
c2FtcGxpbmcgZGF0YSAoZW5hYmxlX3RwZWJzX3JlY29yZGluZyBub3QNCj4gc2V0DQo+ID4gPiA+
ICsgICAgICAgICAgICAgICAgKiBvciAwIHNhbXBsZSByZWNvcmRlZCkuDQo+ID4gPiA+ICsgICAg
ICAgICAgICAgICAgKi8NCj4gPiA+ID4gKyAgICAgICAgICAgICAgIHZhbCA9IDA7DQo+ID4gPiA+
ICsgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gPiA+ID4gKyAgICAgICB9DQo+ID4gPiA+ICsN
Cj4gPiA+ID4gKyAgICAgICAvKg0KPiA+ID4gPiArICAgICAgICAqIE9ubHkgc2V0IHJldGlyZV9s
YXRlbmN5IHZhbHVlIHRvIHRoZSBmaXJzdCBDUFUgYW5kIHRocmVhZC4NCj4gPiA+ID4gKyAgICAg
ICAgKi8NCj4gPiA+ID4gKyAgICAgICBpZiAoY3B1X21hcF9pZHggPT0gMCAmJiB0aHJlYWQgPT0g
MCkgew0KPiA+ID4gPiArICAgICAgIC8qIExvc3QgcHJlY2lzaW9uIHdoZW4gY2FzdGluZyBmcm9t
IGRvdWJsZSB0byBfX3U2NC4gQW55DQo+ID4gPiBpbXByb3ZlbWVudD8gKi8NCj4gPiA+DQo+ID4g
PiBBcyBJIHNhaWQgYmVmb3JlIEkgdGhpbmsgeW91IGNhbiBzZXQgdC0+dmFsICogMTAwMCBhbmQg
dGhlbg0KPiA+ID4gc2V0IHRoZSBldnNlbC0+c2NhbGUgdG8gMWUzIG9yIDFlLTMuDQo+ID4NCj4g
PiBIaSBOYW1oeXVuZywNCj4gPg0KPiA+IFNvcnJ5IGlmIHRoaXMgaXMgYSByZXBlYXRlZCBtZXNz
YWdlLiBJIHRob3VnaHQgSSByZXBsaWVkIHRvIHlvdXIgc3VnZ2VzdGlvbg0KPiA+IG9uIHRoaXMg
bGFzdCB0aW1lLiBJJ20gdGhpbmtpbmcgd2Ugc2hvdWxkIGtlZXAgaXQgbGlrZSB0aGlzIGZvciBu
b3cgYW5kIG1ha2UNCj4gPiB0aGlzIGNoYW5nZSB1bmxlc3Mgd2UgZmluZCB0aGUgcHJlY2lzaW9u
IGxvc3MgaXMgY3JpdGljYWwuIEJlY2F1c2UgSSB0aG91Z2h0DQo+ID4gd2UgZG9uJ3Qgd2FudCB0
byBhZGQgc3BlY2lhbCBjb2RlIHRvIGhhbmRsZSB0aGUgY2FsY3VsYXRpb24gYW5kIGZpbmFsIHBy
aW50DQo+ID4gdG8ga2VlcCBjb2RlIHNpbXBsZS4NCj4gPg0KPiA+IEkga2VwdCB0aGlzIGNvbW1l
bnQgaGVyZSBzbyB0aGF0IHdlIGRvbid0IGZvcmdldCBhYm91dCBpdC4gUGxlYXNlIGxldCBtZQ0K
PiA+IGtub3cgaWYgeW91J2QgbGlrZSBtZSB0byByZW1vdmUgaXQuDQo+IA0KPiBQbGVhc2Ugc2Vl
IHByaW50X2NvdW50ZXJfYWdncmRhdGEoKS4gIEl0J3MgdGhlIGdlbmVyaWMgY29kZSB0byBwcmlu
dA0KPiB0aGUgZXZlbnQgdmFsdWUgYW5kIGl0J2xsIGRpc3BsYXkgdGhlIHZhbHVlIG11bHRpcGxp
ZWQgYnkgdGhlIHNjYWxlDQo+IChkZWZhdWx0IHRvIDEuMCkuICBTbyB5b3UgY2FuIGtlZXAgcHJl
Y2lzaW9uIGFzIGxvbmcgYXMgeW91IHNldCB0aGUNCj4gc2NhbGUgcHJvcGVybHkgKDFlLTMpLg0K
DQpBaCwgb2theS4gSSB3aWxsIGRvIHRoaXMuIA0KDQpUaGFua3MsDQpXZWlsaW4NCg0KPiANCj4g
VGhhbmtzLA0KPiBOYW1oeXVuZw0K
