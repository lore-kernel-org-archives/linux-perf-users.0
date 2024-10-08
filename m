Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F171DA23;
	Tue,  8 Oct 2024 02:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728354659; cv=fail; b=QKnnH0z1S8vZ4IVoXQ0v2QlZxwbj/03CkMjx2lyYf87LLR7bLnI9FOP7DTc9vAcTuORVvARKKMoG8unvKza3iuReRSlQq87CRLEYZHaGhQiBQGs97k1IV8ib8NHlS1YtdVtxHdSJq1jPdfbfxR8+zCH4eKgYWVb3w+KQqQ681F8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728354659; c=relaxed/simple;
	bh=balZRkt8lCntkFz5ANL+Bnj5lcqj10S/B1ML/VpC13A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bAzGrScwokWonuc07v7z4JtFZ9DFK2UJn++KfSJtLtOvZ3u1wwSDOBzT6Vr3qMmgZBwMiP0W5cLNYy7V91KeROuTKShLsWkZstVBYZmslnYYECn5kte8Hkgh5Ax1UzWgTh6N5i7XB5yO8b/XWNfrhlDS0R98dHlOKb78iu39LzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SfzHGxLF; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SfzHGxLF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728354658; x=1759890658;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=balZRkt8lCntkFz5ANL+Bnj5lcqj10S/B1ML/VpC13A=;
  b=SfzHGxLF4DC/K3ibYeoGWeaIa0T5UbBHHk5673JqVm4XuYs9kz+vKQOl
   QDdusWr2tvx00gkjt2V1WgReF0ZrQ90kAWTlS5vRpRsqxV3MVXNdGFk0u
   df2/pGMPWWUsKIBr7nVA3HpH3PA/45mOh6QAFIS+XavhMr0NP3SZLFboB
   gC8/5CTcC+66AEfAmVdk/4hO0Kc0dee1VY7syCIlcnfn6sjtzXARBLCpU
   5INJLGnXt2CKAUzcSYQWoGwXYSpwoSSpvIr66JKDUD+QE3+3w2gCe3wOO
   OL4TzyGskXYlGhtsnM7H617wIa4HKMaNSoifV3IJ/ZWhcbHpVNkBsHtBt
   w==;
X-CSE-ConnectionGUID: RAqzIFqOSH67ckJpzRWJHw==
X-CSE-MsgGUID: N2VRt36NTriBaHbkPABgSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27657865"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="27657865"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 19:30:57 -0700
X-CSE-ConnectionGUID: MoIm6AHoTp6oXD+U27Ni3w==
X-CSE-MsgGUID: pi3c+QjHS/qvKB/7T730Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="79656449"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2024 19:30:42 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 19:30:41 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 19:30:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 19:30:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 7 Oct 2024 19:30:40 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Oct 2024 19:30:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iA30vBAMInreFwpdyP3vLuyQz3ybcCNNclulUyIlN/R0ADyaGaoWkJSgJhVNZSA2CPGTIGRk1PiIZt/9j/6j7DrFgmG+LiXy8oSqnor1OXWFvpjxjV0mpMnMwE4wnvymR3T4Z7VjBNbhliMeYLvslPxevR7hnkAIQ7bUWd8Dp/Z8Bgo1l+FpFVmEl42QJfRGOqc7uZVE5oYRLyMfQK+YNtpwGz7i6q728RchjILTRJU4MWnlYwq30duJisyx4GJ4cYNtqwBATU6c3MRqvHNVCHJpyIFXhWtLj9B7YbqvjwB+X6u/OnZTxQp/I9xlJ8lN+KStvJzUkt5cF+5pdV7W8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=balZRkt8lCntkFz5ANL+Bnj5lcqj10S/B1ML/VpC13A=;
 b=Wwm4w0yXBhcmK2IPPMv2D+fQT/aWlSO6sDqENj1Zly/uhcR/fMEH2hOPt37xcfLfzzLreSNfwk3LPY9582Osau/epZE1jxOALITELbkKGJznXxzZmzFVH2OYIWPksN9R/9fpjVlf4lwfAqcL1ou+SU1tE/QSqyzIANARZcQoCqdRqhSgOflntZMywwB293IYcPJdYxf4+7/hGPI+66j5tnivuLfch4qNpdjolSDubC0cnqBzsn8qgrDIN2lClvyT1daIChuQdN7yn96yVlFvIPtKg3MrmNq6q8LER6bMASdYkcc9raFwIXjtSHBSxKtriw4yuw+Fny55peQmuXtrNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB4824.namprd11.prod.outlook.com (2603:10b6:510:38::13)
 by MN0PR11MB6086.namprd11.prod.outlook.com (2603:10b6:208:3ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 02:30:38 +0000
Received: from PH0PR11MB4824.namprd11.prod.outlook.com
 ([fe80::fa93:2029:3d0b:fb99]) by PH0PR11MB4824.namprd11.prod.outlook.com
 ([fe80::fa93:2029:3d0b:fb99%7]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 02:30:38 +0000
From: "Mi, Dapeng1" <dapeng1.mi@intel.com>
To: "Liang, Kan" <kan.liang@linux.intel.com>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yongwei Ma
	<yongwei.ma@intel.com>
Subject: RE: [Patch v5 0/6] Bug fixes on topdown events reordering
Thread-Topic: [Patch v5 0/6] Bug fixes on topdown events reordering
Thread-Index: AQHbBZzE0FC6Ch5gqUmvLr/5BrB70rJyfxsAgAAZJgCAAar9gIAAD9sAgADquoCAABBBAIAADfEAgAAyRYCABrSrUA==
Date: Tue, 8 Oct 2024 02:30:38 +0000
Message-ID: <PH0PR11MB48246886EE0A79DE5EA613FECD7E2@PH0PR11MB4824.namprd11.prod.outlook.com>
References: <20240913084712.13861-1-dapeng1.mi@linux.intel.com>
 <172781650408.2469191.8205759350946908012.b4-ty@kernel.org>
 <CAP-5=fUekHedP74PZU-F_poETt505AVSwVNYWcYNE=1D9P00AQ@mail.gmail.com>
 <Zv3ek7aBkQo0Z9To@google.com>
 <CAP-5=fUjLhGw4SmMTH_H2=1OwRDrY04RL6+C=DdQ=VSgXk8JZg@mail.gmail.com>
 <b0695ef6-8a59-4550-8a33-9afb25c93f48@linux.intel.com>
 <CAP-5=fXutWptEKZKNvLXvXXpuDoMje6PiOxMuF872xoMjtumGQ@mail.gmail.com>
 <Zv7KHGQx0y3rAGWx@google.com>
 <690ddcd6-276a-4b7b-bd21-fb4ef2349990@linux.intel.com>
In-Reply-To: <690ddcd6-276a-4b7b-bd21-fb4ef2349990@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB4824:EE_|MN0PR11MB6086:EE_
x-ms-office365-filtering-correlation-id: 8e3be33d-4b39-4e35-cec4-08dce7413279
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cHRXS21FQkhLTDkrTzZ1aVdxRjZBSUxrTFRFc1lkS1VKdWtYdU85VFVlZVJi?=
 =?utf-8?B?dWRNWmUxUjBtUmdKV2FTZHY0aldmY2ZFTVpvdURYZFpLK1lMcXBKamhpL0hZ?=
 =?utf-8?B?QW1MWWlMbDhFcTh1RXZBQnB4OUFYTWMyUmdGcVZhUEE4akZHQ2VJUUJGUFFs?=
 =?utf-8?B?YVREWFZQbUQ1Rm0vc0IxOUxHeUtRdUJmRUN2R2NXbU9MRFNRSjdnN3gwVWFY?=
 =?utf-8?B?Ym5XWmNJRStYZjkvSEpFK1grTnV4YUMrMG53L0k5Wm9XWXIvRFN0TUlaN012?=
 =?utf-8?B?Tm0ySDhKV01lYm1CdzRjV25LTFUveVFvMEw5NzRFYUh6U29LZ0hhYnJ3WGZQ?=
 =?utf-8?B?RnNTTEVBU1RCWEMyMU9BMm9WelF5eFFTdk1TcEpBZU9CcWVFTmVza0w4R3hB?=
 =?utf-8?B?RFMrNHMyZHlFc3VyUVRJSXRCL09JWnh4elVsVWU4TkUvVTk2SmlSZmNZbEk2?=
 =?utf-8?B?RkVvZTg2bmJKR0JsWGFRWkZrZE1OY29VUDFHaEVTT0YzOFFCUzNTUnJGTXpQ?=
 =?utf-8?B?RUtvc0txUlV4NDZjaVgvSGU1YUtaakJxcVR6U3Z0UGxHeXduMFFld0tvUGZZ?=
 =?utf-8?B?M2NwWEVQWFVVNVp3ZjcvUTlyMjZhOTV1TTlIVzZSaEwyZzNIS2RHZTJxWHBW?=
 =?utf-8?B?bmlpQlE2L0Q4OE1scFlRSGpKS011eE83T21rdFd6VGQ5MGdyTW9OVFowUEUy?=
 =?utf-8?B?dmF5S2tTQkRReW40eVNJcm5PaHl3MnI0UTMyVWhKR1FyZ1cvN0d4K0RRNEhU?=
 =?utf-8?B?Q0I5Y1V2VkFrcGFRSTlyVkZKREdydGp1dlZZb0lZdElNckw4U0NFZDYrc1hF?=
 =?utf-8?B?QTdYbzdVSnU4VGF5VUdRSS9XbTFkK3N1M1VuU2dqbVNMazNINW54OFAxdUQ2?=
 =?utf-8?B?cm9SUFdnLy92NS9TSFZ4TndQSGxkQUpmU012a0s4ZTRRN2dmbHRsV2RLYUxx?=
 =?utf-8?B?UzFHV25ybVhHTjFYTFN6Qm1qMkM3SjZDRkpob01leHZxQlk4OVVIcGNqV3Qv?=
 =?utf-8?B?eE9sOFBXc3Z2bXFBN3RNSFZhTUVHTWM1NHhreTFqazArdFJGa2Ivd0tCR2U5?=
 =?utf-8?B?Um9UclYxVHc5eWNFVllzK1RDc1lSWXJqN3B3RGVKUDRHcTNldDhleXhZUWU0?=
 =?utf-8?B?ajZSSzBQbmJ1YW5idE5QNCt6MEM3YUdlL3NPRHVWbVdDWjZ5cE1EWWgza3Z1?=
 =?utf-8?B?WHlHYjJ1eklRM1Y5USs2Q2h2V3ljWVo1WFlyWUJhY0FaZy82Q1Z3elBrMWNp?=
 =?utf-8?B?L0hTb2pTZ1hVWWNOdm5PeU9rNDBNbWhkQ2RCQ0YwTm5tQmhZTzF3bzErOTNh?=
 =?utf-8?B?U0NEaG93b21UOXN4NGE5enBGSVFEM3lBTm9CclRzMDkyM24zbXRmMjNtTXVx?=
 =?utf-8?B?ZXZzZ0s2SXQ3KzZJbVZQQmx3RWhRL1dTR0pJODQwRVZ4U0ZwWFFGVW1BaWQ1?=
 =?utf-8?B?TVcreXhKVzE4Sm56NktqMTBEdzBXdHArdCtKSVpXbWFOTW9oNFZ4dmVnYWls?=
 =?utf-8?B?azdJcXFocElPaFczYlhSK3NjSmNTa1FTWDF6VCtDajRGWldqQjZ1U3Y3dzBE?=
 =?utf-8?B?LzdVemgrRjdFYnE3bVVWQ1ZIT3pTT1FsZlVUbzFuVGVoNGdPM2J0bVBqUlkw?=
 =?utf-8?B?OVg4S2JYTGloN1J5NUdVYXh3ckNrQ2xmWWttY2FQMkJieFNuQW9VdTV1S3hE?=
 =?utf-8?B?RTMxY3RlbElYNXAxYWtlYjFWUDlPN2FtaEh2dVBDSDVXUGl2cmRPMXRCZ3cz?=
 =?utf-8?B?ZkFUYUZQS1JmOHRqUVBaanFNM3B2ZGdsMGpVU2xZcW5WUEg5NzJuMFhFNERt?=
 =?utf-8?B?VXgwZmNGUG9aelJkbkcydz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QS9OV3RxYnowM1V5WmpPakRxY2hHckRqeGt3b2cyVFh5SHpvQ1hoUEN4dHlW?=
 =?utf-8?B?SlY5UE9FOEVBWlhwR2I0L01CQlIrWVRjaVI1RllDZ1BJcEV2TlM2ZXNmckZn?=
 =?utf-8?B?eHJWM2Z6WExVQnpjV0VTTGhEc0l3SzdzR1BYRUxOdEZqeHh5blppcmFSSzFx?=
 =?utf-8?B?L3U5b0pVWk1QK2twSklwNVdSTGdGZmdyVTZraXh4dGdRRVNiMDNON2p2cGY1?=
 =?utf-8?B?Nmo4U0tDdnROZVZuRVRBRVI0VGFjQ25yNUZReTZZOVRkQUtUSEx6ZEZVVThQ?=
 =?utf-8?B?U0RTaW5SMllzZDRwbHZqd2tlZ0ZSM1NCZWRldmVGRnd2VFp5Zkh1ckZPbXVD?=
 =?utf-8?B?NFBVb3BGU2lyN0x3dGhNYkVyWk9uOFpHdjA1cUQvMjhuUXpsOWp1ZjNYSkdk?=
 =?utf-8?B?NC81dXZ4YmZMWVRjUy9JZ2F1dGp6VExoZTlvVGttTGRxcjJWMzQxS0xzTGJM?=
 =?utf-8?B?b3ZPSURIMGJ0cUNua05MUDUxWFpnUGZncng5UnJNcU9HTG53TU1MNTVRRERy?=
 =?utf-8?B?YzhHeFpsc1dVSzZidE9OWUI0dmI4NnZhdkVCV2pXajQxekQ2Mk9DL0k5M2RE?=
 =?utf-8?B?OGdnVmJWdnFMaCswZjB5emJLSmdYdzc1SThXY0t5ek1LQTR2SEthOUtab3dV?=
 =?utf-8?B?WDQzZXA4WnlFcmtHVXo1UlI5QlQ4SllDR0UvaHlsN0ZPd291RnFQdFEzemV0?=
 =?utf-8?B?UG1KbG94NkhrZzZ4OWcxeENjdWlZeUR0Q1BBZk91ZTdYSHNUNjF4dnhwbUJU?=
 =?utf-8?B?bWFBamlPRWhQL0k2d2tSWElvSjE2SWJNTE52OGZNUkVKODlZM2V4eU1sY21x?=
 =?utf-8?B?c1laTWNsYTlpTDQ4SmFOQXNqRXNnQUwzNzB4Y2xZYVVBNC8xMjBrajFkS2RK?=
 =?utf-8?B?S0RoOG1Wcm1mY0dqemFkUFJDMWVrSmFqbFRBWmtZUXNmdG5ZaVJyQ2pTOWNq?=
 =?utf-8?B?b21qNElsWVJBcDJXWDJxUnFkbkdpYWZRS1ZkN1NQOHl4ZE15SHNaekdRbTJm?=
 =?utf-8?B?MDVKakN5MmJ1NDg4emRBZWVTUERQMmlRaWVxcCtYaXhHc3ptZVVzNGU3d09r?=
 =?utf-8?B?Mk1RUno2amMyekNXTkwrL1d1R0NDaHV1R3YxYU9Tcmw0bDJzMDdrRGdvSStO?=
 =?utf-8?B?dnZVZ0JPWTcvUEhHa1Vka3J1ekRvbDg1TjRjSVp5NXZBeU9iMVpEdW04OWpP?=
 =?utf-8?B?aGJ5Uzg3ZmtKRnduQ0V3UTdLYmFPUVVnd2NLUDVNNGNvNUNTcTJkc3BOOSt4?=
 =?utf-8?B?NEh4SXFzM2RFbCt1aHhZeDhqZmUyaURjaGJSejFKL2tNeUo2SFA1SjRzdzFN?=
 =?utf-8?B?WldKRHdtUEVZQm96QlE0Z1VnQ2h6N3pNTy9xZmttOTlNbTBnaGJIWUNMclJ4?=
 =?utf-8?B?cTFGdUlIMm5JZG9kSXhHcE1ZdkJWMTBuT3ZWVGdwZzVPYi9kZzkxWUxnUmti?=
 =?utf-8?B?UkJORHh4ZFV2ZldSdm5DN3B5anRIbktPVnUzRGZHT0swQTIxdE9qbjlyVUpK?=
 =?utf-8?B?eGxsbUJiVXV1UW0wVkZTaEZRT0RMMnF5M2hVNVdWWXZPMlJQdFRHQUFQL0pX?=
 =?utf-8?B?eXpnVTc4WWl6SjlnSWNKUnFEcGloUldBTDZmb1NQb3RLK1EySWIzU28xRW5h?=
 =?utf-8?B?UHI5TUY2eDVFZkZiQ0p6V3U5cndkOEdURmhUYm5laUhZZ1J3V1N4d1VPRmk4?=
 =?utf-8?B?ZTdKZlVhUW5pazhZMUFaTjVtQ0tjY2c0dy9lb01yalFrY1Q3azN1Q1Q2THBa?=
 =?utf-8?B?YkRmY3RwaDVMeXZJS0dnVTBEZzlLVkRYR016eU1iaXE3WTRKeG84UXNzYjhV?=
 =?utf-8?B?Y3RkOWl1eE0welJDUTM0eWNsVDltMm53WldSUnFQQVY3TUdlQkt3ZkVYbjRK?=
 =?utf-8?B?MDJ4d0Iwc01nMGMxeExXby9yTEVPdkZicGZYbEM4YUxYdWtMc0JpNTN5dlVX?=
 =?utf-8?B?dkxzQ0thelR3VnlPUUJTY2lNZDVoUlhiWlErdHVkVmVHaG5FS0s2UVNHUmhn?=
 =?utf-8?B?WDhSdWpuczduZHBzNGFjR3FJNkJTTFl3VFAwcjhGaGdHVkhNeUg4K3dLQnFq?=
 =?utf-8?B?SWR4TWllREgwcFA2QnNsRjFoSWw1eG1rK0cvMDdNNjBuZENMdS9vRlNHSjRU?=
 =?utf-8?Q?A2e4L7uZQtEMtvTAETLF72SG3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3be33d-4b39-4e35-cec4-08dce7413279
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 02:30:38.5427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WaMuxBo1ybvvKOT6m24ZhxWvH1W8Hu73mfaymAMT/k4i6WukCvOaPqf1vRWwu0TEpupLM/+5Ll+igM8jfTJUAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6086
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGlhbmcsIEthbiA8a2Fu
LmxpYW5nQGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBPY3RvYmVyIDQsIDIwMjQg
Mzo0NSBBTQ0KPiBUbzogTmFtaHl1bmcgS2ltIDxuYW1oeXVuZ0BrZXJuZWwub3JnPjsgSWFuIFJv
Z2VycyA8aXJvZ2Vyc0Bnb29nbGUuY29tPg0KPiBDYzogUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBp
bmZyYWRlYWQub3JnPjsgSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+Ow0KPiBBcm5hbGRv
IENhcnZhbGhvIGRlIE1lbG8gPGFjbWVAa2VybmVsLm9yZz47IEh1bnRlciwgQWRyaWFuDQo+IDxh
ZHJpYW4uaHVudGVyQGludGVsLmNvbT47IEFsZXhhbmRlciBTaGlzaGtpbg0KPiA8YWxleGFuZGVy
LnNoaXNoa2luQGxpbnV4LmludGVsLmNvbT47IERhcGVuZyBNaQ0KPiA8ZGFwZW5nMS5taUBsaW51
eC5pbnRlbC5jb20+OyBsaW51eC1wZXJmLXVzZXJzQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+
IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFlvbmd3ZWkgTWEgPHlvbmd3ZWkubWFAaW50ZWwuY29t
PjsgTWksIERhcGVuZzENCj4gPGRhcGVuZzEubWlAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BhdGNoIHY1IDAvNl0gQnVnIGZpeGVzIG9uIHRvcGRvd24gZXZlbnRzIHJlb3JkZXJpbmcNCj4g
DQo+IA0KPiANCj4gT24gMjAyNC0xMC0wMyAxMjo0NSBwLm0uLCBOYW1oeXVuZyBLaW0gd3JvdGU6
DQo+ID4+PiBJZiB0aGUgYWxnb3JpdGhtcyBjYW5ub3QgYmUgY2hhbmdlZCwgY2FuIHlvdSBwbGVh
c2UgZ2l2ZSBzb21lDQo+ID4+PiBzdWdnZXN0aW9ucywgZXNwZWNpYWxseSBmb3IgdGhlIHNhbXBs
ZSByZWFkIGZhaWx1cmU/DQo+ID4+IFNvIHRoaXMgaXMgc3ltbWV0cmljOg0KPiA+PiBgYGANCj4g
Pj4gaWYgKGFyY2hfaXNfdG9wZG93bl9tZXRyaWNzKGxocykgJiYgIWFyY2hfaXNfdG9wZG93bl9t
ZXRyaWNzKHJocykpDQo+ID4+ICAgcmV0dXJuIC0xOw0KPiA+PiBpZiAoIWFyY2hfaXNfdG9wZG93
bl9tZXRyaWNzKGxocykgJiYgYXJjaF9pc190b3Bkb3duX21ldHJpY3MocmhzKSkNCj4gPj4gICBy
ZXR1cm4gMTsNCj4gPj4gYGBgDQo+ID4+IFRoYXQgaXMgd2VyZSBsaHMgYW5kIHJocyBzd2FwcGVk
IHRoZW4geW91J2QgZ2V0IHRoZSBleHBlY3RlZCBjb21wYXJpc29uDQo+IG9yZGVyLg0KPiA+PiBg
YGANCj4gPj4gaWYgKGFyY2hfaXNfdG9wZG93bl9tZXRyaWNzKGxocykgJiYgIWFyY2hfaXNfdG9w
ZG93bl9tZXRyaWNzKHJocykgJiYNCj4gPj4gbGhzLT5jb3JlLmxlYWRlciAhPSByaHMtPmNvcmUu
bGVhZGVyKQ0KPiA+PiAgIHJldHVybiAtMTsNCj4gPj4gaWYgKCFhcmNoX2lzX3RvcGRvd25fbWV0
cmljcyhsaHMpICYmIGFyY2hfaXNfdG9wZG93bl9tZXRyaWNzKHJocykgJiYNCj4gPj4gbGhzLT5j
b3JlLmxlYWRlciAhPSByaHMtPmNvcmUubGVhZGVyKQ0KPiA+PiAgIHJldHVybiAxOw0KPiA+PiBg
YGANCj4gPj4gSXMgc3ltbWV0cmljIGFzIHdlbGwuDQo+ID4+IGBgYA0KPiA+PiBpZiAoYXJjaF9p
c190b3Bkb3duX21ldHJpY3MobGhzKSAmJiAhYXJjaF9pc190b3Bkb3duX21ldHJpY3MocmhzKSkN
Cj4gPj4gICByZXR1cm4gLTE7DQo+ID4+IGlmICghYXJjaF9pc190b3Bkb3duX21ldHJpY3MobGhz
KSAmJiBhcmNoX2lzX3RvcGRvd25fbWV0cmljcyhyaHMpICYmDQo+ID4+IGxocy0+Y29yZS5sZWFk
ZXIgIT0gcmhzLT5jb3JlLmxlYWRlcikNCj4gPj4gICByZXR1cm4gMTsNCj4gPj4gYGBgDQo+ID4+
ICh3aGF0IHRoaXMgcGF0Y2ggZG9lcykgaXMgbm90IHN5bW1ldHJpYyBhcyB0aGUgZ3JvdXAgbGVh
ZGVyIGltcGFjdHMNCj4gPj4gdGhlIGdyZWF0ZXItdGhhbiBjYXNlIGJ1dCBub3QgdGhlIGxlc3Mt
dGhhbiBjYXNlLg0KPiA+Pg0KPiA+PiBJdCBpcyBub3QgdW5jb21tb24gdG8gc2VlIGluIGEgc29y
dCBmdW5jdGlvbjoNCj4gPj4gYGBgDQo+ID4+IGlmIChjbXAoYSwgYikgPD0gMCkgew0KPiA+PiAg
IGFzc2VydChjbXAoYixhKSA+PSAwICYmICJjaGVjayBmb3IgdW5zdGFibGUvYnJva2VuIGNvbXBh
cmUNCj4gPj4gZnVuY3Rpb25zIik7IGBgYA0KPiA+IEkgc2VlLiAgU28gYXJlIHlvdSBwcm9wb3Np
bmcgdGhpcz8NCj4gPg0KPiA+IGRpZmYgLS1naXQgYS90b29scy9wZXJmL2FyY2gveDg2L3V0aWwv
ZXZsaXN0LmMNCj4gPiBiL3Rvb2xzL3BlcmYvYXJjaC94ODYvdXRpbC9ldmxpc3QuYw0KPiA+IGlu
ZGV4IDQzOGU0NjM5ZmE4OTIzMDQuLjQ2ODg0ZmExN2ZlNjU4YTYgMTAwNjQ0DQo+ID4gLS0tIGEv
dG9vbHMvcGVyZi9hcmNoL3g4Ni91dGlsL2V2bGlzdC5jDQo+ID4gKysrIGIvdG9vbHMvcGVyZi9h
cmNoL3g4Ni91dGlsL2V2bGlzdC5jDQo+ID4gQEAgLTcwLDcgKzcwLDggQEAgaW50IGFyY2hfZXZs
aXN0X19jbXAoY29uc3Qgc3RydWN0IGV2c2VsICpsaHMsIGNvbnN0IHN0cnVjdA0KPiBldnNlbCAq
cmhzKQ0KPiA+ICAgICAgICAgICAgICAgICBpZiAoYXJjaF9pc190b3Bkb3duX3Nsb3RzKHJocykp
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIDE7DQo+ID4gICAgICAgICAgICAg
ICAgIC8qIEZvbGxvd2VkIGJ5IHRvcGRvd24gZXZlbnRzLiAqLw0KPiA+IC0gICAgICAgICAgICAg
ICBpZiAoYXJjaF9pc190b3Bkb3duX21ldHJpY3MobGhzKSAmJiAhYXJjaF9pc190b3Bkb3duX21l
dHJpY3MocmhzKSkNCj4gPiArICAgICAgICAgICAgICAgaWYgKGFyY2hfaXNfdG9wZG93bl9tZXRy
aWNzKGxocykgJiYgIWFyY2hfaXNfdG9wZG93bl9tZXRyaWNzKHJocykNCj4gJiYNCj4gPiArICAg
ICAgICAgICAgICAgICAgIGxocy0+Y29yZS5sZWFkZXIgIT0gcmhzLT5jb3JlLmxlYWRlcikNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLTE7DQo+ID4gICAgICAgICAgICAgICAg
IC8qDQo+ID4gICAgICAgICAgICAgICAgICAqIE1vdmUgdG9wZG93biBldmVudHMgZm9yd2FyZCBv
bmx5IHdoZW4gdG9wZG93bg0KPiA+IGV2ZW50cw0KPiA+DQo+ID4gRGFwZW5nIGFuZCBLYW4sIGNh
biB5b3UgdmVyaWZ5IGlmIGl0J3Mgb2s/ICBNeSBxdWljayB0ZXN0cyBsb29rIG9rLg0KPiANCj4g
SSB2ZXJpZmllZCB0aGUgYWJvdmUgY2hhbmdlLiBJdCB3b3JrcyB3ZWxsLg0KPiANCj4gVGVzdGVk
LWJ5OiBLYW4gTGlhbmcgPGthbi5saWFuZ0BsaW51eC5pbnRlbC5jb20+DQoNClNpbmNlIHRoZSBs
aW51eC5pbnRlbC5jb20gbWFpbCBzZXJ2ZXIgaXMgZG93biwgSSBoYXZlIHRvIHVzZSB0aGUgaW50
ZWwuY29tIG1haWwgc2VydmVyIChvdXRsb29rIGNsaWVudCkgdG8gcmVzcG9uZCB0aGlzIG1haWwu
IFRoZSBtYWlsIGZvcm1hdCBtYXkgdmFyeS4gU29ycnkgZm9yIHRoaXMuDQoNClRoYW5rcyBLYW4g
Zm9yIHRlc3RpbmcgdGhpcy4NCg0KSWFuLCB0aGFua3MgZm9yIHBvaW50aW5nIHRoYXQgdGhlIGNv
bXBhcmF0b3JzIGFyZSBub3Qgc3ltbWV0cmljYWwuIEkgYWdyZWUgaXQgd291bGQgbGVhZCB0byBh
biBpbmNvbnNpc3RlbnQgc29ydGluZyByZXN1bHRzIGlmIGNoYW5naW5nIGNvbXBhcmluZyBjb25k
aXRpb24gZnJvbSAiY21wKGEsIGIpIDwgMCIgdG8gImNtcChiLCBhKSA+IDAiIG9yIHZpY2UgdmVy
c2EsIGJ1dCBsaW1pdCB0byBzb21lIGNlcnRhaW4gc29ydCBsaWJyYXJ5IGxpa2UgcGVyZi10b29s
LCB0aGUgc29ydGluZyByZXN1bHQgc2hvdWxkIGJlIHN0aWxsIGZpeGVkLCByaWdodD8NCg0KQW55
d2F5LCBJIHdvdWxkIHByb3ZpZGUgYSBuZXcgcGF0Y2ggdG8gbWFrZSB0aGUgY29tcGFyYXRvcnMg
YXJlIHN5bW1ldHJpY2FsLiBUaGFua3MuDQoNCj4gDQo+IFRoYW5rcywNCj4gS2FuDQo=
