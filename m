Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95666395DAA;
	Wed, 15 Jul 2026 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784127134; cv=fail; b=jUvHrNtPcq7zHF2kUbvIMQ2xpY1AL23BfuBLz8n4etgYf6/2Soq0cq2RyqNZ4Qxh+/wcMKsG3fmrRHrwpA3uyAAwFp/4BEZJVuJuyNgJp7udQsDakdYMYtCWtC2kFVZ3fUZvbbd+YnnDXGM0aMrr2IG7mo/peFJTLUzcDCDfsIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784127134; c=relaxed/simple;
	bh=VKHBS3N9BF85/ECu1pSFmSMsUDHqRyyAW+p8ohGXLZc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QdyeC6K9p1BFK3w38VknfmkiK+QhjoJNNxmmBlTIaqG4UVbGrMKebsB7X5wAdKqNXd6e4J80csf+2NwBsZJSmWQAk/Fz/tXxVj7y2QMRNorZliXxIcHgukeb4ahj2MSl0Fe5+S6hbt4L0TFlLcB6fesTuJTwL1OovS5cq7fU4U4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UEGcfFD1; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UEGcfFD1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784127132; x=1815663132;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VKHBS3N9BF85/ECu1pSFmSMsUDHqRyyAW+p8ohGXLZc=;
  b=UEGcfFD1d/zGPcqLRMr/PJSWc0ve7zYDiF/hSrysUqkzq5U9+AhDP38d
   9sm3g/lfB69eT//lQdBoK9BJHlt4BGV3B9i7ff5nmuIOGqpLqNUrBTYJH
   c4ch5xUr3W6HtTvw5vwud9OH1iRWAa9gKR4aZ4XLdd2LKuxGQgrH/pKar
   +l5hqyv2Nm0kuLRrW3RgrM84XviYlQzG2vCSZyNp+Ka65JwaGl4yY8Dxt
   2Eq0LSOqw5/gFptNoYrwobyUWT7oxXKEDtDgYnDse1Ttt5+yxU2M1RBnH
   dEe8AAvCqyXlf6BR8LuzOw/OM4PPU/qpw6C2WkrrC5V80ntjHMYhykPzf
   Q==;
X-CSE-ConnectionGUID: vJYk/wTXQ/esah0UmXuUsw==
X-CSE-MsgGUID: xPFIeBv7RN25ozqct1EM6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84963649"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="84963649"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 07:52:12 -0700
X-CSE-ConnectionGUID: hllvyEjvRkWGnVHvrXha7Q==
X-CSE-MsgGUID: rjTEXC5vTuiNkr1lrdzfYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="258160780"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 07:52:11 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 07:52:11 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 07:52:11 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.44) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 07:52:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSE7lBiPPxMoBuWcrpkhrq6DjIyVbGT9jZthpmGbgynvhD/sdSprRudaLo2s0bETNi9xGyad6sey0sQ0+Wokvr07hpmcvniKaYNuT3rYDtcMSNBkDrDlz9C0wny2VV1gQpMcALbwHs888Ouik00SAsAMdBNl7nDnunYw40Fl1XD9kgQVsUj2FWXzR7bGw4mwx1BaoLc2KC31tJMmJp8fR+0FhF3HVLguK7McMeBVR8BmYkii0K7N2DaxyhhSyfcIXlvx1NHK7MggYPlposzHERJWncHPFS82ILb3aGhl+jtStiM67Ib8hCCCbMKsQUI3Hh+bQGt+ZgXG/o0wxYxhHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKHBS3N9BF85/ECu1pSFmSMsUDHqRyyAW+p8ohGXLZc=;
 b=gPeruFKLd5uPQIlAGkW6KZyZNUb06/ZME0KGgzZLlEk3B4zZ/87auyiWPYO1tPqwshDCrJ2tZ/ueXhGJbVkJlJCzHCKz656T+9N71sNNj8NoUYBNhTQt8p+wQwehTspdrHtTNAO+LhJ9+eOUNIzAkpE66xFQFYB85+/LGafb+wxHbNA/wE+MuWPg5Xanpg4Erez97Y5AFtooQsb2NwKXBoASLU0djOM6qLm7GS+zHjRVVfX18gr8NVWY9UQd/qsVxO4e+H+WucC9JYw4NFSbS1nzeuo2TUVhQHqRucvDNnLxtJNx8Z3FzVLAjskWb1TfWN7kNCFqezdsSus2V0C8YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by DS0PR11MB6471.namprd11.prod.outlook.com (2603:10b6:8:c1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Wed, 15 Jul
 2026 14:52:07 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%2]) with mapi id 15.21.0202.018; Wed, 15 Jul 2026
 14:52:07 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org"
	<acme@kernel.org>, "dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"Rogers, Ian" <irogers@google.com>
CC: "Chen, Zide" <zide.chen@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "Mi, Dapeng1" <dapeng1.mi@intel.com>,
	"Hao, Xudong" <xudong.hao@intel.com>
Subject: Re: [Patch v2 0/7] perf/x86: Miscellaneous PMU bug fixes and
 optimizations
Thread-Topic: [Patch v2 0/7] perf/x86: Miscellaneous PMU bug fixes and
 optimizations
Thread-Index: AQHdEqJKc3IE/dcvJkOB94atxETQwbZurbsA
Date: Wed, 15 Jul 2026 14:52:06 +0000
Message-ID: <9d3bf679605a6216d149a93cb3acbfa4cfa0a38b.camel@intel.com>
References: <20260713082734.3162099-1-dapeng1.mi@linux.intel.com>
In-Reply-To: <20260713082734.3162099-1-dapeng1.mi@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|DS0PR11MB6471:EE_
x-ms-office365-filtering-correlation-id: 9fd63ef8-105e-45d8-3739-08dee280a445
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|23010399003|10070799003|1800799024|10067099003|921020|38070700021|22082099003|18002099003|56012099006|11063799006;
x-microsoft-antispam-message-info: 8uu6rGxO1ta5/uIllu5LwRXQ0ZZXKUjHcMYQQtpOvveVyOnA9Zn0Yf+IRfwCbtVF7w16DjnjL1sSaRK9fTRf24y2k/qY6kH49S1v3i3TR0nIa3e8dQbkL+I72uKJ31WhqD3y52ndE7B72DDslRRkqqpsTnhHPktTfxsAc8WwRimff8TGk9lpg4lsInMrFMTYtuar2E1FCcu750SRLHgQUYsa8T7kNScsfsTnFsX0z5NgSk8qMPQQCR78LACI1B9nTihnivEpMsTdPdMd+2FySgSBzCkfJ5G7vWmM9JD7mFGTqlbD9NgG5Nu5mTkrAklA3LZnkUiIfMQpeIgT50p12dgkcXvLV7leKvvl1sIVLR/0YviswvDKIKasJwirIWLaDp+Lb57ThT6sa30WpG+krmLUHnw4Et7tdpurzbSlfYLhGYr9tKE7LffmKj1el8sM+i+Nj3p9tSytcSY00LU1tyQSq5AX1uOP3jhxZvV0PDxzmGY5BerOJZc0BA+cTk7xt10d1bVKVJzPeFkvA2IAsYPxcIaMSs4SQPTZl+IClRd+t0naTJCZtY/h9xIAH+XPgQIplcjhwXjmvyNLAIUuhKCcRrLQDdvgbXJ2aW6Tc4vkuWP6hLr93GL0TgBtEknLhMFyDdg5YMKulaXb1IO8ZSRpp3Rb7prIzICdvjhLVnYYXO/V2kjtvMsXeTtaUZ3WrMGNdAyqT0d1ouszdAANSc2Tm1tP7zslxMtVvP9wNknpBcYm7No5eesNNzb47dEk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(10070799003)(1800799024)(10067099003)(921020)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEV0eWw1UjV2OTJlV3pkdG5adFNUdDEzc2ZSM09BdStERmlyNVRDVElKWWxq?=
 =?utf-8?B?a3RhOW1nR2lXQVdGRDc4dEtCUFNoYzhrZDBrVTZnbUV6bC9PYnNLemxzclg4?=
 =?utf-8?B?a2VBeHJRelFZeTlvUENsYnArUGRMbk1YRmxKcVFBVDh0SVhFSGJ1cFpGQXFN?=
 =?utf-8?B?T05xU3Nyd1Y0YkFJTTZTVHVNbHBhWUU0Qm54d3gyQ05kUmdIWTlBcU1Kdnkw?=
 =?utf-8?B?Nkw4Vy96Tkc1b25VNnhoOUhWSkhNWXYvV1RmTHNrYm1VeENYZzJveDYvWU9h?=
 =?utf-8?B?TmlYSGsrVEsvMmxKQmNJdy9wTkJ3OHlJRlZXMGpvVjZ2SjQ4MWg3UGQxbzdO?=
 =?utf-8?B?M1pIQjhLUXB1S1krSWZ2cnpiM0R1UUMvMGhxOHMzZ2FLODZNTmw5ai9IOG5t?=
 =?utf-8?B?NlhSZDI2V3l0bG40VGRIUGhtTWMrMVRyWXBRZkJXZjFYRnBERmxLSjQzeEhz?=
 =?utf-8?B?elAyeEswQm0zNGdTNHdTczd1V3ZaeFlaRTNXaytPQk5PN0hZVkEydnhPdVA0?=
 =?utf-8?B?Y041a0RtdHB6dGltcGVEQmFoSlU0V2hpa2s0TGhzZ3lRN0ZsYkNyb0VUcThY?=
 =?utf-8?B?M21Rb054SWFrZ055V0ZwUklKT2Nxc2Rmc3hVd2ZQdy8zdjJvSzVnTnpXKzkw?=
 =?utf-8?B?ckxId0V3Nld5NG9rRFFKeHhhR1lSVURLT3VvcTgyTlZQNUk5QjN4bUExa1B2?=
 =?utf-8?B?TzRlNkFINWpja0JzWDVOeUhTNWlwVklmUnI5R3pqdXhyQUpIQ0hxTFhHbkVQ?=
 =?utf-8?B?amdwSnljam11Vmd3b2NxRkdPcVByV08vRStsN3hNbXJKYjlzUHgzYk8xc1N2?=
 =?utf-8?B?dE54dlFlTi9ZQUlwSjIreUNwcEtGOWVtWGlJVW1HeDRUdVFDNEV3Nisvb056?=
 =?utf-8?B?Uis2dzlDQVVFcTVLVVhUUWRxeDd0VGp5ZDNoNlY2QmI0elZMWGhIWU1XNENq?=
 =?utf-8?B?bDFUK3JDVU1oYTdDZzlCdENUcHJTWG9jWGc4NXkxejBSSnZHazFMMGR0NndJ?=
 =?utf-8?B?eTFpT1o5V1MreHk5RVkxaEpxVVJXYUliMzZyaUIvYTJHZlF5NXB1azJ3V1Uy?=
 =?utf-8?B?NlZZV3F6cDFoSk8xRnZuMFpUdzQ2UWZhZVZJL0FBTnB4cndER0o0dWIwK0FB?=
 =?utf-8?B?eVArTTJNLzBndDI2RW8zaTRvUytpb1k1NW5ZTXpYUWx2eHZXYk5jTnpoUVBL?=
 =?utf-8?B?YnppTnBEY25SaWh2YjBSbFIwcVZGQXBSOCtKaUxGcW1EZEZqWk5jSWxkZy9v?=
 =?utf-8?B?K0VDcU0rS0JLbmRnYlcrcWRVbmVLWDEvU1RQdjJkRnRKNWNJUm8xN01veGpN?=
 =?utf-8?B?Ym9KR2RONjAvSVZTcEpjZGY2YWdxdlJ5am41dHBBYlBwNVgrRnBiNnE2MGZM?=
 =?utf-8?B?Uk4zaUd1dDB4N0ZFQ2txVmZJWXdGNVhLNUNMWlA5bHVVZENmWCtLYWc5ZjA3?=
 =?utf-8?B?bzRPQ01rTGpBTWxvclA5OXBWRWMzRXZqajVCVkdzZk1UUStJWGZRdGRrUmp2?=
 =?utf-8?B?QTlLN3RsQWY2TTdocFBJazJKb0Rpdjd6M2RPTGJZVTE2Nk8wNW05UkRjQXlC?=
 =?utf-8?B?YTR1cXk1c21GcWFtanY1KzJNYnFmSzlPTDRncUw0WnJRS3hvYjcrTmdBa25F?=
 =?utf-8?B?b05TY3dzNFBNMm1LempxOVpwMVlKcmtXNnpOYmJPS01OcHlTODlaT0J6Z3c3?=
 =?utf-8?B?UWQ5YlNnWTBmMWtSNGhSSDRaSmlsSVY4U2xLYkZuVWNjUlkyckdqbDVCY2FR?=
 =?utf-8?B?cFk5OUNmVjNGZklzRlZpblhGaGpTK296aWhyVGNpZkdPZVNQRVRxalZVbmJt?=
 =?utf-8?B?Vis1QmFnOHVpaDNSbGVVS0hiV215QURVRWRhSDVvZUphUnU1NjdIYWl4OGJL?=
 =?utf-8?B?MGt1R3ZPQVhlYk5tdnA0cVRPUVNadkF0LzVNK25paElnMVBVQlVyc3gwekRX?=
 =?utf-8?B?YW1Tbnk0cGtIUjJpdlNPWUpGbG15VmtnMXVKMHRHRnk3bUl2S3lJeDZEU1B6?=
 =?utf-8?B?a0xkd3VMSEpJaGJoc0FGV3Nsc0QycENlaEsvcTJFU3NFOXk0TzkvNkorSnd2?=
 =?utf-8?B?ZXlNdXFNN2JuS1RndFdMcml0cFFXcFlOdm05L0NPU1IzbEVCWFJ5M3p5NTd1?=
 =?utf-8?B?VkxqWkJxMG80M2FKNkpBTHB4aUc4Vk82SkJuR2IvbEl1ZmltcTVyT3FYa3pR?=
 =?utf-8?B?YkQyNWhRMFRneXg0UGhFUHRMUHczT0JlcVlrTlUyWER0dWM3NEdxWjlzNjdL?=
 =?utf-8?B?UmhCNUhIbzNNdkZLZjIyMk9NNXdIbnVFVU9uRWlaWWRQNE53TEJpdCs0TFRq?=
 =?utf-8?B?L3BZNkM4LzN2V1lyZ2VGN0dqOElhcWFsTVh2UTJNclhzQUJyRGJSd2E1S1NJ?=
 =?utf-8?Q?mYQqNDs8cMkz/Nwyeot/Przz0CG5RTzimABK3hDGEqxiR?=
x-ms-exchange-antispam-messagedata-1: Dck0hT3Fw4iAwyqXdWo2siOUyJqHQrSLa3M=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03695545712E5643BA3A44C8AB067B11@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Tzq0amckcU5MpCMfTBVeT2anE3oLmo4Knngd9A0PjsxSEy7qF6OHSNABJRxgSWO/zk/vB+eJZ31Ydnsc3dGWvBGL5FzrEtB0G2aPWQiXqpfjiEFKcgvrM6UIwf7rm3UncuYcSdB4HXRNx9f3cintIZB9E8r7nfonq1/2WPRDK4gLNdAujAOSbVGZ2+6S8H03OK1CAeGtf2g/9Q+kMsAftLVovs2JukAFXQOoqgn6EIrLbR2lRArYsYkyQ8cgHN6Abo8R+08CulWypC7l8m1TU68LoMC3XfsyWrPAUgwxV5SfTdNVcz5RLV2LlWu3kV7YqJWjdBuIY+TFZppnc9aPeg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd63ef8-105e-45d8-3739-08dee280a445
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 14:52:06.8484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GRlUJPQDRxR336c9rUw6H519Yp1jcSCi7a859i4DG+2njJ2vCk136GUjfH2ZyXb8YjdDePUpIZOWRyHU2j7nGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6471
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA3LTEzIGF0IDE2OjI3ICswODAwLCBEYXBlbmcgTWkgd3JvdGU6DQo+IENo
YW5nZXMgc2luY2UgdjE6DQo+IC0gUGF0Y2ggMy83OiBFbnN1cmUgY3B1Yy0+cG11IGlzIG5vdCB0
aGUgc3RhdGljIHBtdSBiZWZvcmUgY2FsbGluZw0KPiDCoCBoeWJyaWRfcG11KGNwdWMtPnBtdSkg
aW4gaW50ZWxfcG11X2NwdV9kZWFkKCkgKFNhc2hpa28pLg0KPiANCj4gVGhpcyBzZXJpZXMgZml4
ZXMgcmVjZW50bHkgZm91bmQgeDg2IGNvcmUgUE1VIGJ1Z3MuIE1vc3Qgb2YgYnVncyBhcmUNCj4g
Zm91bmQgYnkgU2FzaGlrbyBpbiByZXZpZXdpbmcgdGhlICJTdXBwb3J0IFNJTUQvZUdQUnMvU1NQ
IHJlZ2lzdGVycyANCj4gc2FtcGxpbmcgZm9yIHBlcmYiIHBhdGNoLXNldCwgZS5nLiwNCj4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYwNzA2MDIyMTIzLjQ4MDQxMUYwMDBFOUBzbXRw
Lmtlcm5lbC5vcmcvDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MDcwNjAyMTg1
Mi5ERTJFRDFGMDAwRTlAc210cC5rZXJuZWwub3JnLw0KPiANCj4gVGhlIGxhc3QgcGF0Y2ggNy83
IG9wdGltaXplcyBBQ1IgaGFuZGxpbmcgaW4gbWF0Y2hfcHJldl9hc3NpZ25tZW50KCkNCj4gYW5k
DQo+IG1pdGlnYXRlIHRoZSBwZXJmb3JtYW5jZSBvdmVyaGVhZC4NCg0KT3RoZXIgdGhhbiB0aGUg
dHlwbyBpbiBhIGNvbW1lbnQgaW4gcGF0Y2ggNi83LCBMR1RNLg0KDQpSZXZpZXdlZC1ieTogVGhv
bWFzIEZhbGNvbiA8dGhvbWFzLmZhbGNvbkBpbnRlbC5jb20+DQoNCj4gDQo+IFRlc3RzOg0KPiBC
ZWxvdyB0ZXN0IGNhc2VzIGFyZSBydW4gb24gRGlhbW9uZHMgYW5kIE5vdmFsYWtlLiBObyBpc3N1
ZXMgYXJlDQo+IGZvdW5kLg0KPiAtIFBlcmYgc3RhdCB0ZXN0DQo+IMKgICQgcGVyZiB0ZXN0IDEx
OQ0KPiAtIFBlcmYgcmVjb3JkIHRlc3RzIA0KPiDCoCAkIHBlcmYgdGVzdCAxNTUNCj4gLSBQZXJm
IHJlY29yZCBMQlIgdGVzdHMNCj4gwqAgJCBwZXJmIHRlc3QgMTU2DQo+IA0KPiBIaXN0b3J5Og0K
PiB2MToNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYwNzEwMDY1MTI4LjE3OTk4
MzgtMS1kYXBlbmcxLm1pQGxpbnV4LmludGVsLmNvbS8NCj4gDQo+IERhcGVuZyBNaSAoNyk6DQo+
IMKgIHBlcmYveDg2OiBVbnJlZ2lzdGVyIFBNSSBoYW5kbGVyIG9uIFBNVSBpbml0IGZhaWx1cmUN
Cj4gwqAgcGVyZi94ODY6IEZyZWUgaHlicmlkIHN0YXRlIG9uIFBNVSBpbml0IGZhaWx1cmUNCj4g
wqAgcGVyZi94ODY6IEd1YXJkIGludGVsX3BtdV9jcHVfZGVhZCgpIGFnYWluc3QgaW52YWxpZCBo
eWJyaWQgUE1VDQo+IGNhc3RzDQo+IMKgIHBlcmYveDg2L2ludGVsOiBVbndpbmQgY3B1YyBzdGF0
ZSBpZiBQRUJTIGJ1ZmZlciBzZXR1cCBmYWlscw0KPiDCoCBwZXJmL3g4NjogUmVtb3ZlIHN0YWxl
IGZpeGVkIGNvdW50ZXIgaGVscGVyIGFuZCBmaXggaHlicmlkIFBNVQ0KPiBhY2Nlc3MNCj4gwqAg
cGVyZi94ODYvaW50ZWw6IEZpeCBpbnRlbF9jYXAgaGFuZGxpbmcgb24gaHlicmlkIFBNVXMNCj4g
wqAgcGVyZi94ODY6IE9wdGltaXplIEFDUiBoYW5kbGluZyBpbiBtYXRjaF9wcmV2X2Fzc2lnbm1l
bnQoKQ0KPiANCj4gwqBhcmNoL3g4Ni9ldmVudHMvY29yZS5jwqDCoMKgwqDCoMKgIHwgNDUgKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0NCj4gwqBhcmNoL3g4Ni9ldmVudHMvaW50ZWwvY29yZS5j
IHwgNjEgKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQ0KPiAtLQ0KPiDCoGFyY2gv
eDg2L2V2ZW50cy9wZXJmX2V2ZW50LmggfCAxMiArKy0tLS0tDQo+IMKgMyBmaWxlcyBjaGFuZ2Vk
LCA4MSBpbnNlcnRpb25zKCspLCAzNyBkZWxldGlvbnMoLSkNCj4gDQo+IA0KPiBiYXNlLWNvbW1p
dDogZWRkYTkwNTFlMjY3YjczOTBjN2NlMjRiMWI3MTQzNDQxNGFkMTU2ZQ0KDQo=
