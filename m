Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB75D57CB8;
	Fri, 24 May 2024 23:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716594724; cv=fail; b=Qf7xZm7ICiR4Q/pWnptp156aIUh6KKbOPes2XesE4ysUFHLzGp548aUUuWwUtzpvq0ofk/jPj9voZyiIix5mW6/iW2CTENB/a0ITN3DHHgLToojkGV7wa0tsHfLcTYLI3Us8DD6h3hc0w60QlXzmsEssKR2w4ZfsxVrTwMo4qHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716594724; c=relaxed/simple;
	bh=wUkCa5TMhk4lPWu514DlTRM8C9sSj7DvkKa1pSNhi00=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M6KzKRn2pzknMbHs+5fUyPutgA9EfWBPcsX6jI5T9Mvi3wP779gEFE8CRsq4SPmsJuLveKKMFpHwGfMF9y/PXoh4wIbvevgwcJxXuy5hBS7A6gRDokk/Zi32/9bQFlUpcyXUo87LWs5lEsiUoI+GXkkxykaKJtWUtBOEP+m/vlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gBjjSVYA; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gBjjSVYA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716594723; x=1748130723;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wUkCa5TMhk4lPWu514DlTRM8C9sSj7DvkKa1pSNhi00=;
  b=gBjjSVYA9wVX/+Eu4wXwJ3ZfAxak2y3IV/eKQtY36lIAjx4lljSh+6Lo
   DLdTFx8N80Jg88fQBO5yhRZYtetlH/+c0wCawBi01uNw4mHXwLurQC8Hw
   CvSL9FoktPj0aMbMEgveyGT+QPXcI7pvB7/fs/+mQm4TJBSk09e5ZEHRi
   9kVkpGhu60BSJg7qJZLTrUulh6jKstK3ShNOlrbTVmtW5p9CuA3sTmRvF
   ZhLrf3/mL43/l0ZThPxyR3py+8Hq5w/xKQclHYC1Rd4/K7B2glun5VJLc
   cX/8ZzxULkYiYZxDoelFhJe3X04VM/aIGWmLn4L94buSn2WrtxV7gJcSO
   w==;
X-CSE-ConnectionGUID: f0DeckpCTmO/1iP079ZmWw==
X-CSE-MsgGUID: i3ttGZTrStS4mLwstrkhCw==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="13214808"
X-IronPort-AV: E=Sophos;i="6.08,186,1712646000"; 
   d="scan'208";a="13214808"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 16:52:02 -0700
X-CSE-ConnectionGUID: suALNWE3Tluuidt94y7NPw==
X-CSE-MsgGUID: ozWlCBERTUCKTXCVtvOOhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,186,1712646000"; 
   d="scan'208";a="34263383"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 May 2024 16:52:02 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 24 May 2024 16:52:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 24 May 2024 16:52:01 -0700
Received: from outbound.mail.protection.outlook.com (104.47.58.101) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 May 2024 16:52:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKeyoGjYbUNu77kZI4uwqmtL2ZCcQcUo4GPCF04fRiAtk2Ko9w+Ij/dbJ6NAXqhnkcDgrHpW7P8w/7F1c7ylKnjbaPhWLKy5qVvTDbm6aUSeBYS4ttF9dao5nmU4DaxYYsNjS8O00zzh+35lObiM+Q6/Hyb0NvzyIq8hb1lrfZvjskDTSlcCBabVKgI/AvWXY2ZKgZ6t4g2w86EAafCgxWibnqwql2MhBDvezLlq26Ta2Y/qDxWvxaLuiT91eVRIoC7Myu80pRI2EFHCpBHYC56bMZqy9OPxWeVM/2fCj90+nZd932ZJJOIz7ZLYPMek6+dxJJQVyqbuR7TzcA27lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUkCa5TMhk4lPWu514DlTRM8C9sSj7DvkKa1pSNhi00=;
 b=Sutl0NwVrE+W6ekJWZupizV5wUma7A28QIdR4Vy5rYZPaF5y6TMoBXrP7zqgK3rAsdB7sNuigxz9Q35NLWldu9vsurp69Dhxp25WyM1hJ+6KC6ts7c18M/9NEL23hZVYOa709BOjMskKZEyuRbXweHVBWHBTMfF5nk5tOn7Sd7J4uyeYhpOsDzXL9eg7NfmGnrNGvmO/S/Ui4eiSGHw00DcqSsg8ozFWo+5BQUiMRB6EhYcNVSFkAZhBpwU2QsEuhjnbMI76NFpZMXkd4qY6zNYmIl6e50kSfwpVH8VQnKm26wggsBW+tHtuUQcozfY3j8HK79Lv55tzb9Vbvl9KMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by IA1PR11MB6291.namprd11.prod.outlook.com (2603:10b6:208:3e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Fri, 24 May
 2024 23:51:59 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%4]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 23:51:58 +0000
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
Subject: RE: [RFC PATCH v9 4/7] perf stat: Plugin retire_lat value from
 sampled data to evsel
Thread-Topic: [RFC PATCH v9 4/7] perf stat: Plugin retire_lat value from
 sampled data to evsel
Thread-Index: AQHaq6XqeAzJWhj1iUuPm3r3rsuQorGnCbGAgAAIESA=
Date: Fri, 24 May 2024 23:51:58 +0000
Message-ID: <CO6PR11MB563589ED3FC7126A6B27EB22EEF52@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240521173952.3397644-1-weilin.wang@intel.com>
 <20240521173952.3397644-5-weilin.wang@intel.com>
 <CAM9d7cjob_tfgN+rMRrh=0SV56+z32CmP34BRY1eoFv48RVocg@mail.gmail.com>
In-Reply-To: <CAM9d7cjob_tfgN+rMRrh=0SV56+z32CmP34BRY1eoFv48RVocg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|IA1PR11MB6291:EE_
x-ms-office365-filtering-correlation-id: d6b28ce0-deae-405a-3c15-08dc7c4c802a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|7416005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Q1RRR3doR3psb0Fid280SVdkRkh0dU5FOVhsU05tWXl6UU56S1ZpOVMvbUhn?=
 =?utf-8?B?Y2VyS2Q5cFRtVHFaM2VKNGRvM0tleVVRcWhJZjBNNllkQkFnbHd0R0Y4UVFK?=
 =?utf-8?B?VXgwcWEyd0hnaWhxdjNIcEpFQ2Jac3NzZlFkMzNTdWVrcUMrcmpON3JCT0xM?=
 =?utf-8?B?cmpILzlkaC9SUk14SW5HMksyLzQvZmNyS2piK3EwK0IvMGNmOTgzbjNqNGow?=
 =?utf-8?B?UHhtRXRyTmhsRklGZ24zSm1aSkRJalZRMkhvWHZSMzVhdGU2K2MvVGIyTjBE?=
 =?utf-8?B?Ynl5M2FzT2l0Z25JZ0JZZHZNSFFlQXNlTkVJTUt0OWdvSy9MNEViZnkyUUNW?=
 =?utf-8?B?TVg4YWJuR0pqWTZxTEhtSWxWZ21ra1FyYzM5N1h6MFRxYmY0UlREVEoxandn?=
 =?utf-8?B?NGRKbDB2UHZCNFhjY2F1dndYVmFtU2RtUVFFbTcrcHBJMFNXTnU2SHMwV2FN?=
 =?utf-8?B?S0YrNnd6Mk9lMzVNSlNVMkVNRTB6UUxxdyt6UXdISmRFNFVmRFc3Y2o4K3NQ?=
 =?utf-8?B?aldSV096Q0tyY1RoVVdXNmRDejhIRmhqWkxUaGJZWXBZTUFPMUZodjFHUzFG?=
 =?utf-8?B?OUVEMks5M2REQkRsT0JuWmt4UG1UYzZOZk9HOWpMdTFSSVljSUQrNXhrY1RP?=
 =?utf-8?B?R25KYzNPOVhUUzA4TFBLaGhIbUh1QmxQbDVkKzZyVVZuN1ZjdllTZkJnK00r?=
 =?utf-8?B?TUp6OU8weGdLa0xQdXh5TGwvd3JDUlljcVd0dmdzOEYxNVl3b24rcHFpWmdF?=
 =?utf-8?B?cFhpcEJxVkwrNUtkNElyZkZOSEV5b2t2dlE4bGU4MnpCNHZXczYwNVVZdVdz?=
 =?utf-8?B?WnBZcy9MTU5iV3BDb0NBc1o1d1RML0tuQzVVWUpKNnRIWnFjOCtpdkpnQzNC?=
 =?utf-8?B?azBGWUFyQTlsQTYvRWtHei9xdkhPZVU5bnk5T29qbFlTYXE3Uk92THBSb294?=
 =?utf-8?B?TFppRW5nY09YNzM3RUZaMG1CWmNvdGlZYitTOVZzNkFPeEhDV2pQZkhPQWNW?=
 =?utf-8?B?eVJqbUhzN3U5R3E5Zlk2cTFVZVdiTVN3ZEl3K09rbzVvWkpySll0d1JpcXJS?=
 =?utf-8?B?cnYyenpCdFM4QnVtNFZZWjN4QzNmbjk1VWVzUXpGVndzVFVHK1VGc2l5Ykhx?=
 =?utf-8?B?RTVTbVNlY2NMODNLSkdzTVhGUTRPRFZ4Nk5uMkF3T3VPcU56U0wvYVgzcXBU?=
 =?utf-8?B?TlNrb2VUcERydGpoOGpVeXRQNGlVTGk0eXYxUjEvb0hmTVdkaGFFQXhmc1pY?=
 =?utf-8?B?VVYxeE81Slg5RjdWZDhqVmVXd0QzaFlkcUR0K0R4MlFHRDRYN1orRXorOGk4?=
 =?utf-8?B?TFc0U1o3U1F4ZTFhcHFDK2phdGhJYkVZdy9NRmlHOXhuNUxwNkt6YXprQ2ZM?=
 =?utf-8?B?T2V3MkJNMng5WmJ6QkhiVWFsbytwTEkvOHdtWCs5Ry9NUjhJemE4WHFBSjZN?=
 =?utf-8?B?SlV2eitla3FqMzdnTG9MdGJIY2xMd2U2UVg5Q1d0T3orUmFzSGtaMzUxZzJJ?=
 =?utf-8?B?L0FJYnF2RGx1cUJ3NVdLcmNIMjlWZ2NBWnFDR05wa1kydnh3Rmhudi9KckNL?=
 =?utf-8?B?UHZ4ZHJTNUtiRWRMaVo2TVE0VU5id1E2TmZaQjA2YkUwbW03TzZxTjhzSnly?=
 =?utf-8?B?Mm0zVzd0emxUa1kxdWxBclFYRjZxZU9RTXJVbHJHNXNnVnhmaHN3UE43aDN2?=
 =?utf-8?B?WWJFbGtjOFJVKzdWUW1VYXYzd3ZGZkljZDA0aDd3Z0NrWDZpbTlycm02ektt?=
 =?utf-8?B?WUMwZDhRVmdZMVBzOFRFanpLbDJ6RWovaEZLc0FFMUU5OUUwbVFNeFJWK09K?=
 =?utf-8?B?QVFXK3N4QU5ZQjNuZ0Z1Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nm1EUjZqeFM5K0t5cVZONjJ6dVdWeENlaWZBSE5WcmZrUWU0UXRGdk5qQ0VL?=
 =?utf-8?B?TGg5K2pDQ01BL3lHVTRGVm9Ha1VCb2kwRWpnejdCcGIvc0pZK0hubkpKa04v?=
 =?utf-8?B?aGVieEkxZ2xvRG11T1htQnhkY2RLZlVDb3Q3SWhaNmNLZGREZFRLeGxzYWNx?=
 =?utf-8?B?QjdqWkRhWmZLVWNTV3hYUzVYZFltVml6NGhURXhwRStJVDIvSGV4UWNJMGVD?=
 =?utf-8?B?cUNkZ3pHSk5RUWg3RzZ0VnowOFpwRmxLMlVSZ1FIWDlrV3FGbmN4aHp0b2FZ?=
 =?utf-8?B?bnBGVnlvaERhOEcxRU1JWWdvTHFxcXZIVG9wRVRBNU4wbk1uNmRlQk4wYzdp?=
 =?utf-8?B?ZmkzMnZMRzBIT2pOUHNwV0ZldnB2ZnVFcEpRWXRBSHNZZTR2b29ZckFXaU0w?=
 =?utf-8?B?NktjeTdyOExRWGVwZHBKUC9leVl2eW9VK0FpUXFzMXYyMkc0aDM5K3BaakFn?=
 =?utf-8?B?TGU2TnJ6SUFYWUwranZwZGVXbUcreVQyVGRNeWNJQzNBSmtvUG50MWpWR1Qy?=
 =?utf-8?B?R0dXdExtOTNBTE1qZlo5MlBvZUIwR3g2Sk0zVG5PZ0YxM0RqNWNIcUFGcHk4?=
 =?utf-8?B?QmVVL2g5MlZpSzdZamh3VjJEdzVvbmRtM3JTRzVmK3dueGhUdkZKdzFqa2hX?=
 =?utf-8?B?K1k0dWFCNG5ZdjNpSk41MnQrUjF3UkNyc3lrbUdyRmhtbWpBdXN4Uk9oS3ho?=
 =?utf-8?B?a3NxeVFFWFdESi96dnYwZURVTWthMG5TTzJ3emRIRTdwQkdTc2FwTDkyNHg2?=
 =?utf-8?B?L2kxV0tXV3EyZGp2WXE2ZjVzVExhbzhwMXAzYjMvT0Q3bGdiR0JqWUM0OVV4?=
 =?utf-8?B?SFZRWUR4akIzb1Q2aTR3Nkczc0hzbEFKVkNsOHRRNEJXQWFzeU5LS1V4ejNh?=
 =?utf-8?B?R0VIUzErd1pUMFZLenh3WG5yR1lIYjZxUTFCVlpLMWc3dDVodHdKY25xTVhl?=
 =?utf-8?B?Y2s1cXBKTVR2bDlLWHZOWDBzanJEeTN1OGtlRFNybkR4dFV3dlhvcWtSblhL?=
 =?utf-8?B?TWZxQzEydDlHWnh1aC9KM3pqUEtBZ1pSRXpHQWtha2F4Zi9KVXdGR1lnd3pY?=
 =?utf-8?B?REI1VW5vcnpoUklQL0x6U2ZoNDdNV1ZiUkRTRTV5N1oxd0pZTVhyR0FVL2hZ?=
 =?utf-8?B?QVFpcmh4TWVzR2F6NkMvVmE3aGp1ZTZsTnhqSG5lQkh1V0xRelltaFJrZ0xi?=
 =?utf-8?B?emVTZEJ2cS9xbmpOU3pqcW5SQlVKTkYyL1U1YTNYTjkwd01xR0F3K2JTc0hU?=
 =?utf-8?B?eVpPMzc2alhtWlFDQ0lUWUhSdGt5L3RxRnh6YS9IYkFhWHhWNVNPbzlxdWdB?=
 =?utf-8?B?SWRKWkcrWkhKSHhhVC9ZTk5SMys1R3dxV2xLeHdvbm1FOW55U2w4RTRTQ2J6?=
 =?utf-8?B?aE0wUXhLb2xZTTJybDR1aEFCTEVXOE1yUi9lbHZUbnhCaXNURDZ5QmMyUEQv?=
 =?utf-8?B?a1AveG1jUDlpWm5hTURrVDhMdjdTejBEWCtrN0dGZUx6NVBrQVlJcktSYmVM?=
 =?utf-8?B?YlNzaVlaZDNEcG4yY0tISlpaaUlaVENORmRXZzB1L1RLdnRpWThpU0M4Umk1?=
 =?utf-8?B?YWVqbGk2UE5vZFpVMllIVFkxUHJkQjIvekxhV1ZqV0JTWEdadi8ySWRKYzlN?=
 =?utf-8?B?enBvYUo2Y1FPblhreXkvcE02Tnl0bEd4MlZkZHZLdm8vUXVRYjlFVStVZ29w?=
 =?utf-8?B?L1UwaWZMd096MWF1THlsVmFrWk5DZXZoZXRMcGlyQXVHK2c5eHF3QXJHc1JL?=
 =?utf-8?B?Nk1QSjZ2eDVoS0dGTWFBYmJ2bG1ISG4vRGxBOWwxNlhFd2IycU1vQU44U05s?=
 =?utf-8?B?U0UreHYzSHd5ZU9DRDRoS1A0SGtnZWJNeTVRL3RPR1JZdi9YMVpReXN3RENO?=
 =?utf-8?B?OUU4ZkVLaG03UjF5NDkvV2tEWVpqQ0hCKzZXVitDOTVadkl6MjRJdjZoR2cz?=
 =?utf-8?B?ZFlmaDBxS3hCYVh3WEQ3eDlFS3ZaTjE5d2xYVDBCNGxwajJwK1dWclhFa2VO?=
 =?utf-8?B?aGY2RUxFbXQ1VzVDSVlyVENNWS9RUW94TWxWWHRwdS8rbHFrVTVldHZaZ3pk?=
 =?utf-8?B?aE9hdWtZQ3V2YXNwZkplc3lIQnFEOFhnTEhjT1IvQzlIY3FGYjRuQWVGOUFq?=
 =?utf-8?Q?svGC5YHGH0FryZ5aY6L1HU19K?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b28ce0-deae-405a-3c15-08dc7c4c802a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 23:51:58.9268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3UuTeJj3snjSMaDNzQNVeqPArew0lRme+4Jmaj77jH0tONk72nt23z4eEO+eKy3BND3PvPaWc/3fpRmKe6veXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6291
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFtaHl1bmcgS2ltIDxu
YW1oeXVuZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBGcmlkYXksIE1heSAyNCwgMjAyNCA0OjE3IFBN
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
b20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHY5IDQvN10gcGVyZiBzdGF0OiBQbHVnaW4g
cmV0aXJlX2xhdCB2YWx1ZSBmcm9tIHNhbXBsZWQNCj4gZGF0YSB0byBldnNlbA0KPiANCj4gT24g
VHVlLCBNYXkgMjEsIDIwMjQgYXQgMTA6NDDigK9BTSA8d2VpbGluLndhbmdAaW50ZWwuY29tPiB3
cm90ZToNCj4gPg0KPiA+IEZyb206IFdlaWxpbiBXYW5nIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+
DQo+ID4NCj4gPiBJbiBjdXJyZW50IDpSIHBhcnNpbmcgaW1wbGVtZW50YXRpb24sIHRoZSBwYXJz
ZXIgd291bGQgcmVjb2duaXplIGV2ZW50cw0KPiB3aXRoDQo+ID4gcmV0aXJlX2xhdGVuY3kgbW9k
aWZpZXIgYW5kIGluc2VydCB0aGVtIGludG8gdGhlIGV2bGlzdCBsaWtlIGEgbm9ybWFsIGV2ZW50
Lg0KPiA+IElkZWFsbHksIHdlIG5lZWQgdG8gYXZvaWQgY291bnRpbmcgdGhlc2UgZXZlbnRzLg0K
PiA+DQo+ID4gSW4gdGhpcyBjb21taXQsIGF0IHRoZSB0aW1lIHdoZW4gYSByZXRpcmVfbGF0ZW5j
eSBldnNlbCBpcyByZWFkLCBzZXQgdGhlIHJldGlyZQ0KPiA+IGxhdGVuY3kgdmFsdWUgcHJvY2Vz
c2VkIGZyb20gdGhlIHNhbXBsZWQgZGF0YSB0byBjb3VudCB2YWx1ZS4gVGhpcyBzYW1wbGVkDQo+
ID4gcmV0aXJlIGxhdGVuY3kgdmFsdWUgd2lsbCBiZSB1c2VkIGZvciBtZXRyaWMgY2FsY3VsYXRp
b24gYW5kIGZpbmFsIGV2ZW50IGNvdW50DQo+ID4gcHJpbnQgb3V0Lg0KPiANCj4gSSdtIGNvbmZ1
c2VkLiAgRG8geW91IG1lYW4geW91IGRvbid0IGNvdW50IHRoZSBldmVudCB3aXRoICdSJyBtb2Rp
Zmllcg0KPiAody8gcGVyZiBzdGF0KSBhbmQganVzdCBwcmludCB0aGUgKGF2ZXJhZ2UpIHJldGly
ZSBsYXRlbmN5IChmcm9tIHBlcmYgcmVjb3JkKT8NCg0KSW4gbWV0cmljIGZvcm11bGFzLCBldmVu
dCB3aXRob3V0ICdSJyBtb2RpZmllciBpcyBpbmNsdWRlZCBhcyBhIG5vcm1hbCBldmVudCBhbHJl
YWR5LiANClNvIHdlIGRvbid0IG5lZWQgdG8gY291bnQgdGhlIGV2ZW50IHRoYXQgd2l0aCAnUicg
bW9kaWZpZXIuIFRoZXkgb25seSBuZWVkIHRvIGJlIA0Kc2FtcGxlZC4gDQoNCj4gDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBXZWlsaW4gV2FuZyA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiA+
IC0tLQ0KPiA+ICB0b29scy9wZXJmL2FyY2gveDg2L3V0aWwvZXZsaXN0LmMgfCAgNiArKysrKw0K
PiA+ICB0b29scy9wZXJmL3V0aWwvZXZzZWwuYyAgICAgICAgICAgfCA0NCArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+ID4gIHRvb2xzL3BlcmYvdXRpbC9ldnNlbC5oICAgICAgICAg
ICB8ICA1ICsrKysNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA1NSBpbnNlcnRpb25zKCspDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi9hcmNoL3g4Ni91dGlsL2V2bGlzdC5jDQo+IGIv
dG9vbHMvcGVyZi9hcmNoL3g4Ni91dGlsL2V2bGlzdC5jDQo+ID4gaW5kZXggYjFjZTBjNTJkODhk
Li5jZWJkZDQ4MzE0OWUgMTAwNjQ0DQo+ID4gLS0tIGEvdG9vbHMvcGVyZi9hcmNoL3g4Ni91dGls
L2V2bGlzdC5jDQo+ID4gKysrIGIvdG9vbHMvcGVyZi9hcmNoL3g4Ni91dGlsL2V2bGlzdC5jDQo+
ID4gQEAgLTg5LDYgKzg5LDEyIEBAIGludCBhcmNoX2V2bGlzdF9fY21wKGNvbnN0IHN0cnVjdCBl
dnNlbCAqbGhzLCBjb25zdA0KPiBzdHJ1Y3QgZXZzZWwgKnJocykNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICByZXR1cm4gMTsNCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+ICsgICAgICAgLyog
UmV0aXJlIGxhdGVuY3kgZXZlbnQgc2hvdWxkIG5vdCBiZSBncm91cCBsZWFkZXIqLw0KPiANCj4g
SG1tLi4gd2h5Pw0KQmVjYXVzZSB3ZSBkb24ndCB3YW50IHRvIGNvdW50IHRoZW0uIE1ha2UgdGhl
bSB0aGUgZ3JvdXAgbGVhZGVyIHdvdWxkIG5vdCB3b3JrLiANCg0KPiANCj4gPiArICAgICAgIGlm
IChsaHMtPnJldGlyZV9sYXQgJiYgIXJocy0+cmV0aXJlX2xhdCkNCj4gPiArICAgICAgICAgICAg
ICAgcmV0dXJuIDE7DQo+ID4gKyAgICAgICBpZiAoIWxocy0+cmV0aXJlX2xhdCAmJiByaHMtPnJl
dGlyZV9sYXQpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAtMTsNCj4gPiArDQo+ID4gICAg
ICAgICAvKiBEZWZhdWx0IG9yZGVyaW5nIGJ5IGluc2VydGlvbiBpbmRleC4gKi8NCj4gPiAgICAg
ICAgIHJldHVybiBsaHMtPmNvcmUuaWR4IC0gcmhzLT5jb3JlLmlkeDsNCj4gPiAgfQ0KPiA+IGRp
ZmYgLS1naXQgYS90b29scy9wZXJmL3V0aWwvZXZzZWwuYyBiL3Rvb2xzL3BlcmYvdXRpbC9ldnNl
bC5jDQo+ID4gaW5kZXggYTBhOGFlZTdkNmI5Li40ZDcwMDMzOGZjOTkgMTAwNjQ0DQo+ID4gLS0t
IGEvdG9vbHMvcGVyZi91dGlsL2V2c2VsLmMNCj4gPiArKysgYi90b29scy9wZXJmL3V0aWwvZXZz
ZWwuYw0KPiA+IEBAIC01OCw2ICs1OCw3IEBADQo+ID4gICNpbmNsdWRlIDxpbnRlcm5hbC94eWFy
cmF5Lmg+DQo+ID4gICNpbmNsdWRlIDxpbnRlcm5hbC9saWIuaD4NCj4gPiAgI2luY2x1ZGUgPGlu
dGVybmFsL3RocmVhZG1hcC5oPg0KPiA+ICsjaW5jbHVkZSAidXRpbC9pbnRlbC10cGVicy5oIg0K
PiA+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9jdHlwZS5oPg0KPiA+DQo+ID4gQEAgLTE1MjMsNiAr
MTUyNCw0MCBAQCBzdGF0aWMgaW50IGV2c2VsX19yZWFkX29uZShzdHJ1Y3QgZXZzZWwgKmV2c2Vs
LA0KPiBpbnQgY3B1X21hcF9pZHgsIGludCB0aHJlYWQpDQo+ID4gICAgICAgICByZXR1cm4gcGVy
Zl9ldnNlbF9fcmVhZCgmZXZzZWwtPmNvcmUsIGNwdV9tYXBfaWR4LCB0aHJlYWQsIGNvdW50KTsN
Cj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbnQgZXZzZWxfX3NldF9yZXRpcmVfbGF0KHN0cnVj
dCBldnNlbCAqZXZzZWwsIGludCBjcHVfbWFwX2lkeCwgaW50DQo+IHRocmVhZCkNCj4gPiArew0K
PiA+ICsgICAgICAgc3RydWN0IHBlcmZfY291bnRzX3ZhbHVlcyAqY291bnQ7DQo+ID4gKyAgICAg
ICBzdHJ1Y3QgdHBlYnNfcmV0aXJlX2xhdCAqdDsNCj4gPiArICAgICAgIGJvb2wgZm91bmQgPSBm
YWxzZTsNCj4gPiArICAgICAgIF9fdTY0IHZhbDsNCj4gPiArDQo+ID4gKyAgICAgICBjb3VudCA9
IHBlcmZfY291bnRzKGV2c2VsLT5jb3VudHMsIGNwdV9tYXBfaWR4LCB0aHJlYWQpOw0KPiA+ICsN
Cj4gPiArICAgICAgIGxpc3RfZm9yX2VhY2hfZW50cnkodCwgJnRwZWJzX3Jlc3VsdHMsIG5kKSB7
DQo+ID4gKyAgICAgICAgICAgICAgIGlmICghc3RyY21wKHQtPnRwZWJzX25hbWUsIGV2c2VsLT5u
YW1lKSkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGZvdW5kID0gdHJ1ZTsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAgICAgICAgICAgfQ0KPiA+
ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIGlmICghZm91bmQpDQo+ID4gKyAgICAgICAg
ICAgICAgIHJldHVybiAtMTsNCj4gPiArDQo+ID4gKyAgICAgICAvKg0KPiA+ICsgICAgICAgICog
T25seSBzZXQgcmV0aXJlX2xhdGVuY3kgdmFsdWUgdG8gdGhlIGZpcnN0IENQVSBhbmQgdGhyZWFk
Lg0KPiA+ICsgICAgICAgICovDQo+ID4gKyAgICAgICBpZiAoY3B1X21hcF9pZHggPT0gMCAmJiB0
aHJlYWQgPT0gMCkNCj4gPiArICAgICAgICAgICAgICAgdmFsID0gdC0+dmFsOw0KPiA+ICsgICAg
ICAgZWxzZQ0KPiA+ICsgICAgICAgICAgICAgICB2YWwgPSAwOw0KPiA+ICsNCj4gPiArICAgICAg
IGNvdW50LT52YWwgPSB2YWw7DQo+ID4gKyAgICAgICAvKiBTZXQgZW5hIGFuZCBydW4gdG8gbm9u
LXplcm8gKi8NCj4gPiArICAgICAgIGNvdW50LT5lbmEgPSBjb3VudC0+cnVuID0gMTsNCj4gPiAr
ICAgICAgIGNvdW50LT5sb3N0ID0gMDsNCj4gDQo+IFNvIGhlcmUgaXQgc2VlbXMgeW91IGRpc2Nh
cmQgdGhlIGFjdHVhbCBjb3VudCBvZiB0aGUgZXZlbnRzDQo+IGFuZCByZXBsYWNlIGl0IHdpdGgg
dGhlIHJldGlyZSBsYXRlbmN5LiAgVGhhdCBtZWFucyB5b3UgZG9uJ3QNCj4gbmVlZCB0byBvcGVu
IHRoZSBldmVudCBpbiBwZXJmIHN0YXQsIGFuZCBwcm9iYWJseSBqdXN0IGhhdmUgYQ0KPiBwbGFj
ZWhvbGRlciwgcmlnaHQ/DQo+IA0KPiBCdHcsIEkgdGhpbmsgaXQncyBiZXR0ZXIgdG8gbW92ZSB0
aGlzIGxvZ2ljIHRvIGludGVsLXRwZWJzLmMgZmlsZSBhbmQNCj4gcmVuYW1lIHRvIHRwZWJzX3Nl
dF9yZXRpcmVfbGF0KCkuDQoNCklhbiB3YW50cyB0aGlzIHRvIGJlIGhlcmUgYW5kIGFsc28gc3Vn
Z2VzdGVkIG1lIHRvIHJlbmFtZSB0aGlzIGZ1bmN0aW9uIHRvIA0KZXZzZWxfX3JlYWRfcmV0aXJl
X2xhdCgpLiBJJ20gb2sgd2l0aCBlaXRoZXIgd2F5LiAgDQoNClRoYW5rcywNCldlaWxpbg0KDQo+
IA0KPiANCj4gPiArICAgICAgIHJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICBzdGF0aWMg
dm9pZCBldnNlbF9fc2V0X2NvdW50KHN0cnVjdCBldnNlbCAqY291bnRlciwgaW50IGNwdV9tYXBf
aWR4LCBpbnQNCj4gdGhyZWFkLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdTY0
IHZhbCwgdTY0IGVuYSwgdTY0IHJ1biwgdTY0IGxvc3QpDQo+ID4gIHsNCj4gPiBAQCAtMTUzMCw2
ICsxNTY1LDEyIEBAIHN0YXRpYyB2b2lkIGV2c2VsX19zZXRfY291bnQoc3RydWN0IGV2c2VsDQo+
ICpjb3VudGVyLCBpbnQgY3B1X21hcF9pZHgsIGludCB0aHJlYWQsDQo+ID4NCj4gPiAgICAgICAg
IGNvdW50ID0gcGVyZl9jb3VudHMoY291bnRlci0+Y291bnRzLCBjcHVfbWFwX2lkeCwgdGhyZWFk
KTsNCj4gPg0KPiA+ICsgICAgICAgaWYgKGNvdW50ZXItPnJldGlyZV9sYXQpIHsNCj4gDQo+IGlm
IChldnNlbF9faXNfcmV0aXJlX2xhdChjb3VudGVyKSkgPw0KPiANCj4gDQo+ID4gKyAgICAgICAg
ICAgICAgIGV2c2VsX19zZXRfcmV0aXJlX2xhdChjb3VudGVyLCBjcHVfbWFwX2lkeCwgdGhyZWFk
KTsNCj4gPiArICAgICAgICAgICAgICAgcGVyZl9jb3VudHNfX3NldF9sb2FkZWQoY291bnRlci0+
Y291bnRzLCBjcHVfbWFwX2lkeCwgdGhyZWFkLA0KPiB0cnVlKTsNCj4gPiArICAgICAgICAgICAg
ICAgcmV0dXJuOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiAgICAgICAgIGNvdW50LT52YWwg
ICAgPSB2YWw7DQo+ID4gICAgICAgICBjb3VudC0+ZW5hICAgID0gZW5hOw0KPiA+ICAgICAgICAg
Y291bnQtPnJ1biAgICA9IHJ1bjsNCj4gPiBAQCAtMTc3OCw2ICsxODE5LDkgQEAgaW50IGV2c2Vs
X19yZWFkX2NvdW50ZXIoc3RydWN0IGV2c2VsICpldnNlbCwgaW50DQo+IGNwdV9tYXBfaWR4LCBp
bnQgdGhyZWFkKQ0KPiA+ICAgICAgICAgaWYgKGV2c2VsX19pc190b29sKGV2c2VsKSkNCj4gPiAg
ICAgICAgICAgICAgICAgcmV0dXJuIGV2c2VsX19yZWFkX3Rvb2woZXZzZWwsIGNwdV9tYXBfaWR4
LCB0aHJlYWQpOw0KPiA+DQo+ID4gKyAgICAgICBpZiAoZXZzZWxfX2lzX3JldGlyZV9sYXQoZXZz
ZWwpKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gZXZzZWxfX3NldF9yZXRpcmVfbGF0KGV2
c2VsLCBjcHVfbWFwX2lkeCwgdGhyZWFkKTsNCj4gPiArDQo+IA0KPiBJJ20gbm90IHN1cmUgaWYg
aXQgd29ya3Mgd2VsbCB3aXRoIGdyb3VwIGV2ZW50LiAgUHJvYmFibHkgdGhhdCdzDQo+IHdoeSB5
b3Ugd2FudGVkIHRvIHByZXZlbnQgZ3JvdXAgbGVhZGVycy4gIEJ1dCBJIGd1ZXNzIHlvdQ0KPiBj
YW4ganVzdCBjaGVjayB0aGlzIGFmdGVyIHRoZSBQRVJGX0ZPUk1BVF9HUk9VUCwgbm8/DQo+IA0K
PiBUaGFua3MsDQo+IE5hbWh5dW5nDQo+IA0KPiANCj4gPiAgICAgICAgIGlmIChldnNlbC0+Y29y
ZS5hdHRyLnJlYWRfZm9ybWF0ICYgUEVSRl9GT1JNQVRfR1JPVVApDQo+ID4gICAgICAgICAgICAg
ICAgIHJldHVybiBldnNlbF9fcmVhZF9ncm91cChldnNlbCwgY3B1X21hcF9pZHgsIHRocmVhZCk7
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi91dGlsL2V2c2VsLmggYi90b29scy9w
ZXJmL3V0aWwvZXZzZWwuaA0KPiA+IGluZGV4IGJkOGU4NDk1NGUzNC4uYWFmNTcyMzE3ZTkyIDEw
MDY0NA0KPiA+IC0tLSBhL3Rvb2xzL3BlcmYvdXRpbC9ldnNlbC5oDQo+ID4gKysrIGIvdG9vbHMv
cGVyZi91dGlsL2V2c2VsLmgNCj4gPiBAQCAtMzAzLDYgKzMwMywxMSBAQCBzdGF0aWMgaW5saW5l
IGJvb2wgZXZzZWxfX2lzX3Rvb2woY29uc3Qgc3RydWN0IGV2c2VsDQo+ICpldnNlbCkNCj4gPiAg
ICAgICAgIHJldHVybiBldnNlbC0+dG9vbF9ldmVudCAhPSBQRVJGX1RPT0xfTk9ORTsNCj4gPiAg
fQ0KPiA+DQo+ID4gK3N0YXRpYyBpbmxpbmUgYm9vbCBldnNlbF9faXNfcmV0aXJlX2xhdChjb25z
dCBzdHJ1Y3QgZXZzZWwgKmV2c2VsKQ0KPiA+ICt7DQo+ID4gKyAgICAgICByZXR1cm4gZXZzZWwt
PnJldGlyZV9sYXQ7DQo+ID4gK30NCj4gPiArDQo+ID4gIGNvbnN0IGNoYXIgKmV2c2VsX19ncm91
cF9uYW1lKHN0cnVjdCBldnNlbCAqZXZzZWwpOw0KPiA+ICBpbnQgZXZzZWxfX2dyb3VwX2Rlc2Mo
c3RydWN0IGV2c2VsICpldnNlbCwgY2hhciAqYnVmLCBzaXplX3Qgc2l6ZSk7DQo+ID4NCj4gPiAt
LQ0KPiA+IDIuNDMuMA0KPiA+DQo=
