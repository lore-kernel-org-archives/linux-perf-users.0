Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1408157CB8;
	Fri, 24 May 2024 23:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716594879; cv=fail; b=EfSA1l9YRP74f+GZcGqEpXkLpsMVPYVwkEHHo9++5EOc7JgEW3UaA1sNJTK8p7lqA/JDi/j+e+M7FJYryJpzbgCzRhqvFEdQerMkjuDTHPAmfRnqcDlbw102B6Yusmzc0bTp+PP9Eupumf1cqsbVWJQOj0zACN+sQ+fgLfFYCUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716594879; c=relaxed/simple;
	bh=gzxoK6xJCyUvKsNxKZVC8gteZg9+/HrV1J2s1Khriu4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q5iuciniuGiSl9fLDUpBDmqMmwujIYdXlQ57frSY5HOwu0ZEbLO75Z0cefbjnqlPF1miTZb3Jg/8QdncRlJIOm9G5SWPrjjXgFrYEn6y2BHhxkO2wGAaKlN00roeyDd4Vh5mjUhQtIOb98XjGZof6FnHGxYESOOrT84mOz9k9fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jfBzlDg5; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jfBzlDg5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716594879; x=1748130879;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gzxoK6xJCyUvKsNxKZVC8gteZg9+/HrV1J2s1Khriu4=;
  b=jfBzlDg5NO2D34icG6DBDpus3mbI4Wzj2ykGge4+gYqIR1bRfIiy694X
   4GRU9w3AVNfOZE16MfrTUvplImq49bpgkvGVqQTRSGM2r2ChDmxTYb96k
   hU0c9jidRI1FBYLlFffZ+MYK0eHzMo1bs/WWucNIRUPGxuE+ichysFJ3z
   mVjLxLBtnAW46kCU/7yUboqerBwnvV5uuxhGfoaSSOgEHC7LguoqPsPIL
   +bMTCkbx1SryLN2GlfN5ZO3DZ1W2f1YxTvzaZiLeQ96u7DQvP3LGuJoCW
   EfEOv8C6MkezXLcEJ0LfYl3FiYL78cXiP/cMCBmmLCwki5KSuA8MKMDR5
   Q==;
X-CSE-ConnectionGUID: u4FxtrCSQIaKR+oK3NQ1og==
X-CSE-MsgGUID: RmOMnOsJQ6qQLuRZTKxcgw==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="13110364"
X-IronPort-AV: E=Sophos;i="6.08,186,1712646000"; 
   d="scan'208";a="13110364"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 16:54:38 -0700
X-CSE-ConnectionGUID: Vr8O6DIZRzqYb90a1O3Ozw==
X-CSE-MsgGUID: DKe4VJ1xSvOR8bvISWUgSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,186,1712646000"; 
   d="scan'208";a="64979385"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 May 2024 16:54:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 24 May 2024 16:54:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 24 May 2024 16:54:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 May 2024 16:54:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcXqKtAdCJZXjXVCNQkmFf7iVf/a3UKuEqbsxFlTbi/+JptSZhFFgDJzRJlYPShHBjVLhtTLKwnc3z9hGQKdzbBYV8wV2j8Fh2YgEuWBHWeLrL1kxfAcmBhqQNq7Gp66nilmXooFoRk3sYd/TCmfZHjojabI2ijyckk4GqswGSuwzFn2O8KYr+Bx1IqMg7biFVV/7pw9RbQ8wo6kxUE6hSc1FmHzZQ9K1uyKJjCis8ji+MTAvO7qmYT89eMGLtFA6On1c21hGmFMApwTRcla/bTsveOtkjhuTq4Qj1ExCuj5SPRuutR1F90Lvj2qQtcPS/yvmQySHTV9U7dmZiG6lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzxoK6xJCyUvKsNxKZVC8gteZg9+/HrV1J2s1Khriu4=;
 b=R8V21T99npk2MmrJ1tF8eAluj6gNapA+CbvnY336MY8A81rnpCnlmxwmcj+BScBzBLH8UKI49EusQtjBCoBJFA3zcnKpDBdsUAARqHW/VRyYxNKAa8l3yn2qk3w07gV1s3cdVH+wsxhQ6Li5SOg/5sdGv+vJUfCoyq3HVE6MJ5v5cszY3oID/7txSPtMrflZmwVkPfyrHy2cnn5R/y6nYZ6c5PFZhejwpYb1NYK3HalDMDNTmflpmqlB11VG2OKlW0fp7roHCk8PqD7zQgiIOOtGTlW6lsMwjzzDTv3dAZW+FrHBQAG73cMkvJApsKsEfHFr4i7dHXmP0Q8/nP7bCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by IA1PR11MB6291.namprd11.prod.outlook.com (2603:10b6:208:3e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Fri, 24 May
 2024 23:54:34 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%4]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 23:54:34 +0000
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
Subject: RE: [RFC PATCH v9 5/7] perf stat: Add command line option for
 enabling tpebs recording
Thread-Topic: [RFC PATCH v9 5/7] perf stat: Add command line option for
 enabling tpebs recording
Thread-Index: AQHaq6Xq1HAqaWm9b0CfS5eoce4vA7GnCriAgAAIzbA=
Date: Fri, 24 May 2024 23:54:33 +0000
Message-ID: <CO6PR11MB5635A10AD597AB3D2D041406EEF52@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240521173952.3397644-1-weilin.wang@intel.com>
 <20240521173952.3397644-6-weilin.wang@intel.com>
 <CAM9d7cg7Xg=pxc5sxfGo7Om2qh3zoj2nbtyAyu6D5MOedfJ6SQ@mail.gmail.com>
In-Reply-To: <CAM9d7cg7Xg=pxc5sxfGo7Om2qh3zoj2nbtyAyu6D5MOedfJ6SQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|IA1PR11MB6291:EE_
x-ms-office365-filtering-correlation-id: 285594c4-6e66-4180-f807-08dc7c4cdc99
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?R2xRWnpCR0FBYWljTkgyWXllWjVWWjBiaWw4S21IckxLU2x1M2h0VXg4WUpn?=
 =?utf-8?B?YjlOSHpNTXJuNWZ1QXd4UUF5SmZtSHVYOXUrTWpiRGhvNnZFWG9abC9tWmxI?=
 =?utf-8?B?Rlc2TkpiY3p2T05wL0diM0J1dmJQdkNaVkdRVW8yaitFYy9EM3JwdGxqSVdY?=
 =?utf-8?B?VTNqN1ZwVGF5VUxTdlY1Tmd2NTJjeXcxVzlaVnE1SmY2UUoyL21oL3Z6eWdV?=
 =?utf-8?B?WHEweHlYeDBtTXRNWDNrcmZCeFFvSVhuMEZzNTg0blBOeHpidzd6WFY1Z2NU?=
 =?utf-8?B?VmZIK0FyNmxnVFN4Y3g5T0VwWElmYkpQbFZNbGJ2SGZQKzRZbUk5NUhBL1JB?=
 =?utf-8?B?VDVjSlNVeUZ6Qm5CM25GZkhzbytZdUdLM043eUpxdkhFb29NZkFvTXFIZEZS?=
 =?utf-8?B?N21WVGg1a2UvRjI2Ulo0dndIRVlYNlhsTVkwZUJHK2JpSC9ReDhrbUUzR2FO?=
 =?utf-8?B?bjVoWlo1RW5sZC9reFVub1JXYkYwQ1dpbUJhWEg3WUpCN2hGS0txdE44MnBK?=
 =?utf-8?B?Sm5qdjdpdVBPREdveE14emVSaWpiYWFFZ2x6Vy9wMGpPQVhHOWYwaDkwbHgw?=
 =?utf-8?B?YUJLQW1pL0FiTUx1SU1ZZWtiY053ekppQU52enB6S25yQUdUZTA2M3Qyb3ky?=
 =?utf-8?B?djJ2U0dZTEo0YzBsd2tleFhyNlZzK2FuTUY3dFcwamZFcnhXQkNpRE8xcDJV?=
 =?utf-8?B?dmNZUjk2ZTVzUE9pY2UvTnRhTW1Zd1BLSmdSTkxzcSttQWo0eDIwSWxWYXVH?=
 =?utf-8?B?MU8wNkkvNmxNWTg3UjhBMko3ZnBWOUlTdUJmTVd6bWxLdnMwQUw0cGpObTR3?=
 =?utf-8?B?eHhTY3dBdFhUSHZtUUdWWUgwUnZrcHhqTVVUMkU0YVppWGplYzk4bzBnQlFx?=
 =?utf-8?B?aVFsUFhudm5XQmgvTW9iUTFQRDNMVU9qenRxdENVNEhWSGpaNnAzYUkxVkYz?=
 =?utf-8?B?dWF2SnoxNjVsVllIN29TWW5HeWluNXg5WjMxT2QrRlg4TFNBR05TczA3TDBY?=
 =?utf-8?B?SWlBMmlld2lPbGQxdzc0QUtyOSs5dkg4ZFQwdWgrVFEyY1pXcXFPbmp2VmFB?=
 =?utf-8?B?clgxR1ZVT2V6aWdTbGVYaGpaNmUvR2xMY2E5YWZrUVBQUDY3VTdHVEE5R0E0?=
 =?utf-8?B?RlhjVHlLMnFhdWlLcm5wemFCTmFuNWErUlUvVlhTUDI3cHE5VEJjOEtHTWFK?=
 =?utf-8?B?dis2QUg3RFRENnFlMGFQOEtnWEljM2djb0x0NHJKM1Q2ekwzblgzY3htcXA0?=
 =?utf-8?B?d3dpK2t6c1JHZkpFeTdneHJKVFFpOG9wNzFEcVVyTkMrUkphdTJMM2N0OFUy?=
 =?utf-8?B?YktlRS9OQUtiYW0xK09FRkMvT2wrR3ZHVEVCUEdKbTYxVkk1M0EwQWhYRHk3?=
 =?utf-8?B?QjJsZytmWVZkdkVmVzIybkMyNVJ6Y1J6SXVDOWJKNDJyZW9JYVI2MGJkNzE1?=
 =?utf-8?B?WTlzVmdwczZveTMxTDBsK2gzM3gzRzNFWDYwN2VzS1M3TldQOFpMWUVUc0JK?=
 =?utf-8?B?K25CZGhyRTBIUWE3bWU4cFA4YWU2REhtTnArZHIwUlhlMEtGK0V0dEFoeWhE?=
 =?utf-8?B?S1hOemFNekZqM1Racmw3WXV5STYwdGFOQnJxVkNNcGFVc3VBQUltaEVvc2cz?=
 =?utf-8?B?T3FrS3ZzZTFsbDJ4dHN5QUdjWlg5QjNFYTNuVlVSVHpFM3pJckREWm4yRzdG?=
 =?utf-8?B?RjJEaUhzVHpsVDR1UlhvZzQ0VlBiakxBa05QZzZ1cWJYb2ZmT1BPbkpETlMz?=
 =?utf-8?B?NkFISkJsVUxucFpQSmtLNlQ5YjlEajZQUk45eGtTOW8zMVM0M0JMT2dQY0Zv?=
 =?utf-8?B?clE0RFFKMEJzZ1c2blAxQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjliWTUwczd3cUZ1b3JrNkJsTHptMnhxY3JlVVhHdVA2NUpXL0pHYVlLWVE3?=
 =?utf-8?B?cFlWVzZwTDgyalI2dS9KSVpZMDZEREdvMFc5bm1pWDFmRFc4cjBNSVEwbHpi?=
 =?utf-8?B?WEI1ZTlFSmVNdHJvWnE2b3hXeWxnLzNIRlpxQ0xBS0ltUVd4bjNpR2ZlYUdm?=
 =?utf-8?B?eGZRQm5wOWJLa2tZd0h1QUZaTXljVHMwbVk2QzRNN3dvZStLSmVZNVE0L3pa?=
 =?utf-8?B?QU8wZnlMR0MxR0taTmo4TXZ5Y21RMjNHQ0wwckU0VjN2dnVURXU3U3VPTzhp?=
 =?utf-8?B?R2dqcXlEL2J6YzBwUTRZVlV2b2ZZZjNVSjdPb1FCUkpVaTVMZXRXWEdpaWRs?=
 =?utf-8?B?K0NNalhPalZQVWRPTkcvdWlIMXZxZ1pWQTZuZTZSZW5BMjQxN21yRW45Ym9F?=
 =?utf-8?B?QUhCbDJVTXJYaDlpekM2R3UrbUtZMXhYdXRETmFCVUllVng2NGg4N1duWDRi?=
 =?utf-8?B?UHp0Vis1aFV5a0N1WWdGbGlkWklWWjg0bTh1cVAxbXFHMGx4K1gva3ZLd2Jq?=
 =?utf-8?B?NTNxTHcrRHdrRkFyQTRNR0lCdnVYajB2VTdHbWY1STBza1hmTk9PaWgxNVpa?=
 =?utf-8?B?VVkwRm1SOUdVaVhkbWVKRDhVTzhlQmhoNmptRm9lOWY1ZVJvTHd4ZTc3d1Nj?=
 =?utf-8?B?c3Yya1dENlhBVFBzWEN2UUhQdUk0ZTFOMVJ6RitNVzR0eXBFNkpFeHpEKzNN?=
 =?utf-8?B?MEZpTENMRTl2RDhrZWI5ZkllbWdKa2h4bVlrdHFNb0tUZFRoYjFhTXpVbXZx?=
 =?utf-8?B?N0lQMUhjSEhaSjExRnVoZngwbFFrVEhnTUxkUTBsRzJoWE5TT1huM2JvZ240?=
 =?utf-8?B?Zkg4M3JvdXNvcjhQTDRuK1RXU2pkVWFEY1daVXMvMm1CVlhHZWFhZ3ZIdU1Z?=
 =?utf-8?B?ZnlVQUtGVXlROWdEVmZPRmhrWlIrSWg2SXFlakNYdEhvT2RxY2NqYmxqajdT?=
 =?utf-8?B?NXFQVk9LcEVGa0VobmFOVlNDRDdxeXJnajE5ZVNIT05PUU16V3hFZDhGVCtD?=
 =?utf-8?B?cEV2dDRUR2pBTjloTXQ4S0hlNTBucGV3UHJoWDJ3bFlkZFBYTitqVTZCWjZM?=
 =?utf-8?B?eXJIeDB6QlMzUmkyZ2ErU3dJY3NNVmF3Qkp3WnpJekJBMUw5UUp3TXVBa1NM?=
 =?utf-8?B?VEdUR3lsMXJ5MUtWTEZoa2R5Q1pIWWZ5M05OZ1U3OHpJSkE4YVEvZ1ExVG14?=
 =?utf-8?B?cDh0d29ycmVsQ3NtS2lmVmlJd3hoVEtkQ3ZNK2FBWmE0Ri82eUxkRlRvUVRs?=
 =?utf-8?B?Y3ZPRTZTaXdKMGRtN005TkU1L1ZmdG5QSHhqeXFaM0xyVHJWVFZSS21XTmRY?=
 =?utf-8?B?YldvbXY4S2pmbUxUVmgzbFMzZDdMSHBsb3RNTERxMWhTRGNDN0lxMmV6MFlk?=
 =?utf-8?B?UG92OFJzb0R0MlhQbFlNeGhoNU04UEIzUmdYOHZQeVNmVEliVjF4UzRFcU42?=
 =?utf-8?B?SGtZbnZjL1lGaURyVUZPRm5mYUFFbmx1TGFWNm5kUldKTHhTS0RtVUxyRE55?=
 =?utf-8?B?UkZLVlB6WU41MDJidExlVXJtMVJZbGRFYW4vYld0MGVFcDNDb3hWMTZLNUZy?=
 =?utf-8?B?SFgrS1FHd2RWRlpLcFE4KzE4QWt3cU5uNGxHbW1yekZseEs4NHhESExtVHN3?=
 =?utf-8?B?dDdtNFRJQzhCRGlrc3hodldmU2FPVWtVNTkyKzhYdy8rUk5VeXJzcnJNVzMv?=
 =?utf-8?B?U2hlS2oyUzE4bzYwNEZBbTZLZm9RUFZVYWFBSjk2d3lBeUxrVllTdlBDNXhy?=
 =?utf-8?B?ZHVlck1Qc1l2MG05S0NodVJQdi9CQktvL1ZKcy9rWWdYMzBLK2JhS1pHYVJF?=
 =?utf-8?B?SFhHaFcyT3plNit5QWh6UmozOGw1eWdtR3gyR28vcWNkaXRGZk1BdXM0QXE2?=
 =?utf-8?B?T3hVTU81Qi9salpML2tjMFFINFVST1FQUm8xcTJvNGVVT2o5SHQzZVR0ZllB?=
 =?utf-8?B?Q1RYSHorV0hGa3BhM1NGNWNVWmZ6NDVYRWtydXhiYmRnYS9QT3hybUF1OEd3?=
 =?utf-8?B?NEJhVVZrRDJxYjB2VjhBZmVaMXNmaUo5LzRDVzdDU2dzWXpxVHJ6S2VTWE5Q?=
 =?utf-8?B?T2NlL0tVbDJBV1kva1lsNjdVRzNCZjVxU0c2ZDMvY3lrU2JZUUNTWWVOWUR2?=
 =?utf-8?Q?PtMQOsAhGQJBoGUEj68Q2RRUk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 285594c4-6e66-4180-f807-08dc7c4cdc99
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 23:54:33.9573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6g5omNkbJQebbyPITn2BxofFBrZ2uijoePwx698zlT3ddT/FiLJSJYxsBhqaZ67Wp0yPQBuMqFm4LACyKjgv3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6291
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFtaHl1bmcgS2ltIDxu
YW1oeXVuZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBGcmlkYXksIE1heSAyNCwgMjAyNCA0OjIxIFBN
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
b20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHY5IDUvN10gcGVyZiBzdGF0OiBBZGQgY29t
bWFuZCBsaW5lIG9wdGlvbiBmb3INCj4gZW5hYmxpbmcgdHBlYnMgcmVjb3JkaW5nDQo+IA0KPiBP
biBUdWUsIE1heSAyMSwgMjAyNCBhdCAxMDo0MOKAr0FNIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+
IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogV2VpbGluIFdhbmcgPHdlaWxpbi53YW5nQGludGVsLmNv
bT4NCj4gPg0KPiA+IFdpdGggdGhpcyBjb21tYW5kIGxpbmUgb3B0aW9uLCB0cGVicyByZWNvcmRp
bmcgaXMgdHVybmVkIG9mZiBpbiBwZXJmIHN0YXQgb24NCj4gPiBkZWZhdWx0LiBJdCB3aWxsIG9u
bHkgYmUgdHVybmVkIG9uIHdoZW4gdGhpcyBvcHRpb24gaXMgZ2l2ZW4gaW4gcGVyZiBzdGF0DQo+
ID4gY29tbWFuZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFdlaWxpbiBXYW5nIDx3ZWlsaW4u
d2FuZ0BpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIHRvb2xzL3BlcmYvYnVpbHRpbi1zdGF0LmMg
fCAxOSArKysrKysrKysrKysrLS0tLS0tDQo+ID4gIHRvb2xzL3BlcmYvdXRpbC9ldnNlbC5jICAg
fCAxOSArKysrKysrKysrKysrKy0tLS0tDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0
aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVy
Zi9idWlsdGluLXN0YXQuYyBiL3Rvb2xzL3BlcmYvYnVpbHRpbi1zdGF0LmMNCj4gPiBpbmRleCBj
MGU5ZGZhM2IzYzIuLmMyNzUyMWZiMWFlZSAxMDA2NDQNCj4gPiAtLS0gYS90b29scy9wZXJmL2J1
aWx0aW4tc3RhdC5jDQo+ID4gKysrIGIvdG9vbHMvcGVyZi9idWlsdGluLXN0YXQuYw0KPiA+IEBA
IC0xMTcsNiArMTE3LDcgQEAgc3RhdGljIHZvbGF0aWxlIHNpZ19hdG9taWNfdCAgICAgICAgY2hp
bGRfcGlkICAgICAgICAgICAgICAgICAgICAgICA9DQo+IC0xOw0KPiA+ICBzdGF0aWMgaW50ICAg
ICAgICAgICAgICAgICAgICAgZGV0YWlsZWRfcnVuICAgICAgICAgICAgICAgICAgICA9ICAwOw0K
PiA+ICBzdGF0aWMgYm9vbCAgICAgICAgICAgICAgICAgICAgdHJhbnNhY3Rpb25fcnVuOw0KPiA+
ICBzdGF0aWMgYm9vbCAgICAgICAgICAgICAgICAgICAgdG9wZG93bl9ydW4gICAgICAgICAgICAg
ICAgICAgICA9IGZhbHNlOw0KPiA+ICtzdGF0aWMgYm9vbCAgICAgICAgICAgICAgICAgICAgdHBl
YnNfcmVjb3JkaW5nICAgICAgICAgICAgICAgICA9IGZhbHNlOw0KPiA+ICBzdGF0aWMgYm9vbCAg
ICAgICAgICAgICAgICAgICAgc21pX2Nvc3QgICAgICAgICAgICAgICAgICAgICAgICA9IGZhbHNl
Ow0KPiA+ICBzdGF0aWMgYm9vbCAgICAgICAgICAgICAgICAgICAgc21pX3Jlc2V0ICAgICAgICAg
ICAgICAgICAgICAgICA9IGZhbHNlOw0KPiA+ICBzdGF0aWMgaW50ICAgICAgICAgICAgICAgICAg
ICAgYmlnX251bV9vcHQgICAgICAgICAgICAgICAgICAgICA9ICAtMTsNCj4gPiBAQCAtNjc3LDkg
KzY3OCwxMSBAQCBzdGF0aWMgaW50IF9fcnVuX3BlcmZfc3RhdChpbnQgYXJnYywgY29uc3QgY2hh
cg0KPiAqKmFyZ3YsIGludCBydW5faWR4KQ0KPiA+ICAgICAgICAgaW50IGVycjsNCj4gPiAgICAg
ICAgIGJvb2wgc2Vjb25kX3Bhc3MgPSBmYWxzZTsNCj4gPg0KPiA+IC0gICAgICAgZXJyID0gc3Rh
cnRfdHBlYnMoJnN0YXRfY29uZmlnLCBldnNlbF9saXN0KTsNCj4gPiAtICAgICAgIGlmIChlcnIg
PCAwKQ0KPiA+IC0gICAgICAgICAgICAgICByZXR1cm4gZXJyOw0KPiA+ICsgICAgICAgaWYgKHRw
ZWJzX3JlY29yZGluZykgew0KPiA+ICsgICAgICAgICAgICAgICBlcnIgPSBzdGFydF90cGVicygm
c3RhdF9jb25maWcsIGV2c2VsX2xpc3QpOw0KPiA+ICsgICAgICAgICAgICAgICBpZiAoZXJyIDwg
MCkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOw0KPiA+ICsgICAgICAg
fQ0KPiA+DQo+ID4gICAgICAgICBpZiAoZm9ya3MpIHsNCj4gPiAgICAgICAgICAgICAgICAgaWYg
KGV2bGlzdF9fcHJlcGFyZV93b3JrbG9hZChldnNlbF9saXN0LCAmdGFyZ2V0LCBhcmd2LCBpc19w
aXBlLA0KPiB3b3JrbG9hZF9leGVjX2ZhaWxlZF9zaWduYWwpIDwgMCkgew0KPiA+IEBAIC04ODYs
OSArODg5LDExIEBAIHN0YXRpYyBpbnQgX19ydW5fcGVyZl9zdGF0KGludCBhcmdjLCBjb25zdCBj
aGFyDQo+ICoqYXJndiwgaW50IHJ1bl9pZHgpDQo+ID4NCj4gPiAgICAgICAgIHQxID0gcmRjbG9j
aygpOw0KPiA+DQo+ID4gLSAgICAgICBlcnIgPSBzdG9wX3RwZWJzKCk7DQo+ID4gLSAgICAgICBp
ZiAoZXJyIDwgMCkNCj4gPiAtICAgICAgICAgICAgICAgcmV0dXJuIGVycjsNCj4gPiArICAgICAg
IGlmICh0cGVic19yZWNvcmRpbmcpIHsNCj4gPiArICAgICAgICAgICAgICAgZXJyID0gc3RvcF90
cGVicygpOw0KPiA+ICsgICAgICAgICAgICAgICBpZiAoZXJyIDwgMCkNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICByZXR1cm4gZXJyOw0KPiA+ICsgICAgICAgfQ0KPiA+DQo+ID4gICAgICAg
ICBpZiAoc3RhdF9jb25maWcud2FsbHRpbWVfcnVuX3RhYmxlKQ0KPiA+ICAgICAgICAgICAgICAg
ICBzdGF0X2NvbmZpZy53YWxsdGltZV9ydW5bcnVuX2lkeF0gPSB0MSAtIHQwOw0KPiA+IEBAIC0x
MjQ2LDYgKzEyNTEsOCBAQCBzdGF0aWMgc3RydWN0IG9wdGlvbiBzdGF0X29wdGlvbnNbXSA9IHsN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICJkaXNhYmxlIGFkZGluZyBldmVudHMgZm9yIHRo
ZSBtZXRyaWMgdGhyZXNob2xkIGNhbGN1bGF0aW9uIiksDQo+ID4gICAgICAgICBPUFRfQk9PTEVB
TigwLCAidG9wZG93biIsICZ0b3Bkb3duX3J1biwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAibWVhc3VyZSB0b3AtZG93biBzdGF0aXN0aWNzIiksDQo+ID4gKyAgICAgICBPUFRfQk9PTEVB
TigwLCAiZW5hYmxlLXRwZWJzLXJlY29yZGluZyIsICZ0cGVic19yZWNvcmRpbmcsDQo+IA0KPiBK
dXN0IC0tdHBlYnMgb3IgLS10cGVicy1yZWNvcmQ/ICBJIGp1c3QgcHJlZmVyIHNob3J0IG5hbWVz
LiA6KQ0KPiANCj4gDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgImVuYWJsZSByZWNvcmRp
bmcgZm9yIHRwZWJzIHdoZW4gcmV0aXJlX2xhdGVuY3kgcmVxdWlyZWQiKSwNCj4gPiAgICAgICAg
IE9QVF9VSU5URUdFUigwLCAidGQtbGV2ZWwiLCAmc3RhdF9jb25maWcudG9wZG93bl9sZXZlbCwN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAiU2V0IHRoZSBtZXRyaWNzIGxldmVsIGZvciB0
aGUgdG9wLWRvd24gc3RhdGlzdGljcyAoMDogbWF4IGxldmVsKSIpLA0KPiA+ICAgICAgICAgT1BU
X0JPT0xFQU4oMCwgInNtaS1jb3N0IiwgJnNtaV9jb3N0LA0KPiA+IGRpZmYgLS1naXQgYS90b29s
cy9wZXJmL3V0aWwvZXZzZWwuYyBiL3Rvb2xzL3BlcmYvdXRpbC9ldnNlbC5jDQo+ID4gaW5kZXgg
NGQ3MDAzMzhmYzk5Li5lMWYzZjYzZGZiNTQgMTAwNjQ0DQo+ID4gLS0tIGEvdG9vbHMvcGVyZi91
dGlsL2V2c2VsLmMNCj4gPiArKysgYi90b29scy9wZXJmL3V0aWwvZXZzZWwuYw0KPiA+IEBAIC0x
NTQwLDIxICsxNTQwLDMwIEBAIHN0YXRpYyBpbnQgZXZzZWxfX3NldF9yZXRpcmVfbGF0KHN0cnVj
dCBldnNlbA0KPiAqZXZzZWwsIGludCBjcHVfbWFwX2lkeCwgaW50IHRocmVhDQo+ID4gICAgICAg
ICAgICAgICAgIH0NCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+IC0gICAgICAgaWYgKCFmb3VuZCkN
Cj4gPiAtICAgICAgICAgICAgICAgcmV0dXJuIC0xOw0KPiA+ICsgICAgICAgLyogU2V0IGVuYSBh
bmQgcnVuIHRvIG5vbi16ZXJvICovDQo+ID4gKyAgICAgICBjb3VudC0+ZW5hID0gY291bnQtPnJ1
biA9IDE7DQo+ID4gKyAgICAgICBjb3VudC0+bG9zdCA9IDA7DQo+ID4gKw0KPiA+ICsgICAgICAg
aWYgKCFmb3VuZCkgew0KPiA+ICsgICAgICAgICAgICAgICAvKg0KPiA+ICsgICAgICAgICAgICAg
ICAgKiBTZXQgZGVmYXVsdCB2YWx1ZSBvciAwIHdoZW4gcmV0aXJlX2xhdGVuY3kgZm9yIHRoaXMg
ZXZlbnQgaXMNCj4gPiArICAgICAgICAgICAgICAgICogbm90IGZvdW5kIGZyb20gc2FtcGxpbmcg
ZGF0YSAoZW5hYmxlX3RwZWJzX3JlY29yZGluZyBub3Qgc2V0DQo+ID4gKyAgICAgICAgICAgICAg
ICAqIG9yIDAgc2FtcGxlIHJlY29yZGVkKS4NCj4gPiArICAgICAgICAgICAgICAgICovDQo+ID4g
KyAgICAgICAgICAgICAgIHZhbCA9IDA7DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAwOw0K
PiA+ICsgICAgICAgfQ0KPiA+DQo+ID4gICAgICAgICAvKg0KPiA+ICAgICAgICAgICogT25seSBz
ZXQgcmV0aXJlX2xhdGVuY3kgdmFsdWUgdG8gdGhlIGZpcnN0IENQVSBhbmQgdGhyZWFkLg0KPiA+
ICAgICAgICAgICovDQo+ID4gICAgICAgICBpZiAoY3B1X21hcF9pZHggPT0gMCAmJiB0aHJlYWQg
PT0gMCkNCj4gPiArICAgICAgIC8qIExvc3QgcHJlY2lzaW9uIHdoZW4gY2FzdGluZyBmcm9tIGRv
dWJsZSB0byBfX3U2NC4gQW55DQo+IGltcHJvdmVtZW50PyAqLw0KPiANCj4gTWF5YmUgeW91IGNh
biBzYXZlIHZhbCAqIDEwMDAgYW5kIHRoZW4gbGF0ZXINCj4gY29udmVydCBiYWNrIHRvIGRvdWJs
ZSBhbmQgZGl2aWRlIGJ5IDEwMDA/DQoNCkkgYWxzbyB0aG91Z2h0IGFib3V0IHRoaXMgbWV0aG9k
LiBCdXQgdGhpcyB3aWxsIHJlcXVpcmUgc3BlY2lhbCBoYW5kbGluZyBzb21ld2hlcmUsIA0Kd2hp
Y2ggbG9va3MgbGlrZSBpcyBub3Qgd2Ugd2FudC4gTWF5YmUgd2UgY291bGQgbGVhdmUgdGhpcyBu
b3QgaGVyZSBhbmQgaGFuZGxlIHRoaXMNCmxhdGVyIGlmIHdlIGZvdW5kIHRoZSBwcmVjaXNpb24g
aXMgaW1wb3J0YW50Pw0KDQpUaGFua3MsDQpXZWlsaW4NCg0KPiANCj4gVGhhbmtzLA0KPiBOYW1o
eXVuZw0KPiANCj4gDQo+ID4gICAgICAgICAgICAgICAgIHZhbCA9IHQtPnZhbDsNCj4gPiAgICAg
ICAgIGVsc2UNCj4gPiAgICAgICAgICAgICAgICAgdmFsID0gMDsNCj4gPg0KPiA+ICAgICAgICAg
Y291bnQtPnZhbCA9IHZhbDsNCj4gPiAtICAgICAgIC8qIFNldCBlbmEgYW5kIHJ1biB0byBub24t
emVybyAqLw0KPiA+IC0gICAgICAgY291bnQtPmVuYSA9IGNvdW50LT5ydW4gPSAxOw0KPiA+IC0g
ICAgICAgY291bnQtPmxvc3QgPSAwOw0KPiA+ICAgICAgICAgcmV0dXJuIDA7DQo+ID4gIH0NCj4g
Pg0KPiA+IC0tDQo+ID4gMi40My4wDQo+ID4NCg==
