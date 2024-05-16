Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E715614533D;
	Thu, 16 May 2024 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881048; cv=fail; b=fsag8KwG6jBrT9WQua8k+2DN2CNVrpnUqTWw/yeU5UwFXfIKd2INQbeFsGoXADoPYU6lhXu7jIkqyVIoKttp3EWfv+Lirf7IA402nn93evpGTlIbxJgVlt7ss8EIgBqjJ8XqnLqttzvnKAv38nS6Vzen+NnVzMCXQogmXiabv4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881048; c=relaxed/simple;
	bh=hUjpH2koIVPRO07KsAAPLNgwJQigrsSZ9/bNvjawTKQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rZZv6pL6koVQY/UjpUFfRGyzgdkNhNy7835E+kn955/btYitbIztXICBc3V1BWdJPr+3JFpbcs6Mzhms+hc6PD9b777/TExE8VVY75hkI0tpIL1LTiyaVbim5+dFT/j+aK0xdJUnlzvCDFddQocL8PdH5Qg0AgcUJC/+iLwtYS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kRHxs9kl; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kRHxs9kl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715881047; x=1747417047;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hUjpH2koIVPRO07KsAAPLNgwJQigrsSZ9/bNvjawTKQ=;
  b=kRHxs9kl+WZXWXGIa/X4jleaRg4ZeLTsxqrxbO6KN3y9uOTVbzUQ/mkA
   2pY48Xdw/Gc/YU6zFuv2FAeHwXTn13WaSqDnqWx/UV5ycZJJgCaSkLRLe
   2y6up28K7Ss+GZ/z/41xtMx/kV3++BTdpLa7etYrdDU/TT4KB+Z40i6HG
   cEj8RUg5jkrWpGAcCrGa1n11bTxkfYUzFj8lGAgeDKBNStxMTPRUNFbta
   16hETZHnyw0E9UZFNKYmm3FhQf50nVDDm1ujJukI0aJt7oD5hV9ItRYub
   RRT4whkxu47jDZ5a3xDwxdRhJIzAqTyn5zy72YllORm0CYPjSJqFljxtM
   Q==;
X-CSE-ConnectionGUID: cfox1WLIRGCZsuyItuXagw==
X-CSE-MsgGUID: jrF0yAgiRQuYTLWh7D1zQQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15799802"
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="15799802"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 10:37:26 -0700
X-CSE-ConnectionGUID: 1Rrq+UOQSAKBxuUBV5Z9aQ==
X-CSE-MsgGUID: QZpyB7H7RA+yOLIiluMVIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="31504928"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 May 2024 10:37:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 10:37:25 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 10:37:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 16 May 2024 10:37:25 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 May 2024 10:37:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFcj21jmAJjJj59rHyfZZAXcjFtPk/N62FCJqRuu3Xtr8QNdb24oYA2UOJCGZhrCxeGlVm8BkCxh/4Ry3bR4P7Rk8WJ0cGAjouUOAtpj08QZ1RL8BuEMhGivWK/mZAfDlb0fuhS+Gq3WzB3FR3Mq4KUHU3NCmpwyXRHdyjivt62JMgh9YI/ablU2JdNbMGRsD+h9DbBwo1T56G5b7OuQV8B5nQR8ZFDfsoWgumQ8uZMZO46fjerA/BI1VIVU3S9uJoixO5t4Vh5+1ZPOTSZAMbfbdtZxi49UqxMpZXKwJG6iMt6PsEq7EQx+KmuCduIlRSi9Br0BwzaaRKtgvpp3sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUjpH2koIVPRO07KsAAPLNgwJQigrsSZ9/bNvjawTKQ=;
 b=flp/eQbs9hsN15uExaRND6bsv0yX8+tFxVVeBU62mpgk1NAs+iArLBf3HG36kZ+mWpz7RtinFwa9S/BPGv1qtJsr6jtCinL8sYiBgbklboO2QicW/LawP1kUwXim1Bst6LOG8Ij2y46FVnOBkKaeJ2iHsOU2Ttawx6psLwCfaGgVEl2wvJHjNyjuxNkXzxA5/WMdL8pe5FpcD64U18O0HkX5KXoF1GbmODTbM/4gXidftHiUmGsgAKRsfHSq0Wgg+VFEvsWoHB8l8kVufGFRaarTMt1mUwKQqqpuyFW1dGwh4O1596pvTtY/jaTLTcpIccCtHn6R+xtbutrk9cbAdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by SA3PR11MB7610.namprd11.prod.outlook.com (2603:10b6:806:31d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.29; Thu, 16 May
 2024 17:37:22 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%4]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 17:37:21 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Ian Rogers <irogers@google.com>
CC: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"Kan Liang" <kan.liang@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb"
	<caleb.biggers@intel.com>
Subject: RE: [RFC PATCH v8 1/7] perf Document: Add TPEBS to Documents
Thread-Topic: [RFC PATCH v8 1/7] perf Document: Add TPEBS to Documents
Thread-Index: AQHaposCLemFewFd8EqFSxB6KviOcLGaCh0AgAAWBBA=
Date: Thu, 16 May 2024 17:37:21 +0000
Message-ID: <CO6PR11MB5635F7C3C6928C2F3E5D732FEEED2@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240515054443.2824147-1-weilin.wang@intel.com>
 <20240515054443.2824147-2-weilin.wang@intel.com>
 <CAP-5=fVJmJ0MapzadOcBfQj69FKhaFA9YtonMy4W7kUfDSXS9Q@mail.gmail.com>
In-Reply-To: <CAP-5=fVJmJ0MapzadOcBfQj69FKhaFA9YtonMy4W7kUfDSXS9Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|SA3PR11MB7610:EE_
x-ms-office365-filtering-correlation-id: c0ade771-cf0f-4e0c-0725-08dc75ced780
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?MWZhdkpFUk4rUk1WanQ5Y1luZG13TDVCVmhZaEhsZktBb2xTNFlRUGxockVi?=
 =?utf-8?B?alVNS3hDM0Vyd3hhb2VBZTVxdGZkU1FjN1JIMjFvUU42TFVxRlR0dGl2T2Ju?=
 =?utf-8?B?SzVFeE5mT3RrUVAyUHNTejM2MHlSV29JcUVtR291SlpNeU9FL0piSS9zd1lQ?=
 =?utf-8?B?cUc5cWtwYkxXOGh4NTV3cGJoekhkZGNhQTdyVFVUNHNub2pjazFrZHRYOVZE?=
 =?utf-8?B?ZmVkVXhUNnB6SXVQSmZiWUtUakdvNnB3c1NQVEVNSXVlVC9ldEJLQUF2MitV?=
 =?utf-8?B?ZElxdWl4N2M2U3lCZ29ocW81azM0dDM5VVI0TDhTSGYvaFN5c1BaTGEva0Zj?=
 =?utf-8?B?ZmU4TSs3RmRiNDZRb1lDb29KZGt2c2VxVWZrZzV6K0FKZThBZngyT0FrVUd3?=
 =?utf-8?B?K3V6U0tNV3d4Y29kd2xZQUFMRWhyNzl0V3VSSXltbEJ0S1F4NHFZelRJaHNP?=
 =?utf-8?B?VUZIYzIrQmp1dWlVVDJUczVLb2x0b25ZQzd1SDR4NnZDZnlOZXZidm5wMzhY?=
 =?utf-8?B?MXA3amFJcENPRXhGTkY4RWRLS0hGanVwdFJDWXdEcERtanpmNzRyclAybzIw?=
 =?utf-8?B?QmtjZVlmQUxVVmdQVGFoMlJvek8yNkxYOUJHUEVoL2ZicVVHWm5IQVZCWUlF?=
 =?utf-8?B?dDNKSiszamg5clM4UkxINDMyZFZPNEZFeHRyYy9tMll1WG90cXJMVStTRjZJ?=
 =?utf-8?B?OFQrYkFIakdCZG5kd0k1dm1NLzRwK3hQUllLdnd5NVZsMlIzQWZSc2p1VHBw?=
 =?utf-8?B?eTRuM0x6UnRhUlBxQkIvV2FmcmhUZjBHeXNURkpGMGx5Qjc2Y2QrKzBzY1ov?=
 =?utf-8?B?UFFPNGZtbE41aWJmM1EwUFFDTkZxVkVJbG1qYXYwN1FOcDdVc05GVngxbFYy?=
 =?utf-8?B?RnI1cTRIbThJVmI1WVdabkJNaW5ueDdIZnlha204R2NSelUvVHYvT3d5dnFZ?=
 =?utf-8?B?RTNXVzVzbEZkcWJSSkJpQlhySThTc1hEQWJlT0dBU1g2Y0JKYnBKdmh1Ukk4?=
 =?utf-8?B?bzVBeVhocExrc3hLSGhzeCtuaVFWR1lTQTNTZlNnRlY4amh4VTRYaU42RUx6?=
 =?utf-8?B?cW5BYTF6bDY4UzZ3SnhGWFBVemkySlFNT2FYeE9sN1BCN2FVZ3BmL21oTkoz?=
 =?utf-8?B?bjJDUit6QWhScXl4cEtZN1JxekgyWlliK3BkeUR0RFN1dGNNcEoyK3U5Y1Vy?=
 =?utf-8?B?TU1jaFJzSEtqeFhQYlZMTEJVNnpCVW41UE9SbXl5SDJqTjlmRXFzUXVDRWlw?=
 =?utf-8?B?WkhjYmFpMVRXay9ObXV2cTdtWkdvcnVnaGcwekU3eEZsZHFSb1UxYno2ZFBm?=
 =?utf-8?B?bXpFL0pRakU4Y0hLcjRud3VpaGlwSld5MkY3U1hwSCtHY2svNG1IY2hUNS9z?=
 =?utf-8?B?WkNmV0hXanV6ejA5OVBPN2VQTzR1SzhMcWtvVW9TQjY0eFFiS2pVS016UGx5?=
 =?utf-8?B?YVBucGZGM0x4ZGVoRkNXVDQ2eHZzS1RWQXF5UURBY2RnWVFJY01CR092MWtB?=
 =?utf-8?B?b2tPVmpVKzdqUDgwSUhUaVRvdG51eUJmNXZMT0N5MXFNYlhpVWxXSFBSTFBN?=
 =?utf-8?B?eCtGSDhJczJ5YWhKLytiSkg4SVA4ZFJkUjRraGYzeitEUXNiM2h6dWwySTI1?=
 =?utf-8?B?VHc2QkxpR0ptNFhnMGNOYjM3TnJuUXRjcGlzNWlIa3l3ejhzcXJaRmxIU3g5?=
 =?utf-8?B?ZzhJa3RIU2pndXFBV1FXNGVYdFFrQ0swUy9nbzJNQ28xL0swTi9DZTV3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGFYMGdHUnVsV3NCdWpjdlNiZXhTK3J0OHp2ZTlVRVNpeGJycDBpNVg0NHFO?=
 =?utf-8?B?OTJqTEUrQm1tOTdQSDlWRVFBZEZpNUxPU2ZwZzVWWjFuMUY1dzRJZ1oycklT?=
 =?utf-8?B?bXVubEF5SXpxZTFkanJkRjhlN25NYVFkZ0JlYlk4ZGdvSTVYYjNUT1ltNGpP?=
 =?utf-8?B?T1RLNmF3YnZNT1EyZmlyUDdxbTQ1Wm1CaWloTXpoMll1TGUzYzI1MVdNNm93?=
 =?utf-8?B?cUdNNDhxU0Nua0drTTNTak5TQ0U2WW9jMXE2Nm5GbE16Y1RxMVVwQ2VKQVZ4?=
 =?utf-8?B?UmFzWVNVbmdiTmNBZVhzTzZlMG0xd0MxTnRXRjlKNVQxL0tkbnRsUngvelB1?=
 =?utf-8?B?bWk1TE5Wbm45RXplemVqUHFEVmlvWkhPbFRqQU81SUcyMTJGby9uSVE5UzJv?=
 =?utf-8?B?RThoY1lkUWNQNm1hZGpHU0JxNG41U215NjEyUUpyYjJRYXlabDFqT3VRWlRP?=
 =?utf-8?B?VjBMR3ErYUFmOHFrV2txSTVlMjdmTnZWVkVvcWFoRWh4aVUwcmt6Q2xtTUx2?=
 =?utf-8?B?LzkrOFNReklvUDAyOGMvaEprNTFPdno4VHF4TE0xOWN0NU9ScmRzQ3Mxdlh5?=
 =?utf-8?B?N0FlM3dPYkJvSDE4YTVhZlA2dWx3azZjWkF0VFRPa1RjUXFmVjU3bWZBN2RI?=
 =?utf-8?B?YWlqcENsT0NIUnlQZnFVRkZ1cERCSy9SdXRzZXpHa1dXQjJPay9zR3VSeGhU?=
 =?utf-8?B?TFdFcXBldU10UUNrUEFoZzdBeGtHWEc1Sm5penNxcUdVNlplT1VKVVovZVpQ?=
 =?utf-8?B?TkQ2QWlUYnhpZ3N3ZWVoMTJlRnpIem94bUNJcWJvbXIwNGFmS1pVV1VRZ3pB?=
 =?utf-8?B?VTlURjJzOXd4OXB2L05SYW1ybVFpazRnT3hBSHNVOUZwNEgwdW5DeTNVb1pt?=
 =?utf-8?B?L3R1RUthQVQ5bkFUOS91ZlRUTUo2S0ZpNEtQWUpHam52UkE4VmdnTHdQUGhG?=
 =?utf-8?B?UHBkNlBxZnZZanAvN1JzOVNocXJzdEdtUVEvQUprQ1ZqOFVpeThvaUV6d3RU?=
 =?utf-8?B?VVNzdEorTmN1Z2p6N05kSDhtUVNkYnFSeXc5Z2FiY29WOUtLd3NobUpIcEl1?=
 =?utf-8?B?NXkzWFNlZnZ4OVRkNE1wUjZkVjNPZFZhM0E4SnhNeVpKbG9zaU03VlVPL20v?=
 =?utf-8?B?aTBKemx2b2JtSXFmYjF5QTRac09Uc0Z1MWo2U2JicVBqWjVnQitHeEZ6SmM4?=
 =?utf-8?B?WG1SNHd0eGRzWll3WnVsZStoQSsxUkRzQTBES09BZGlFaG5HWWEvaWIyMnRi?=
 =?utf-8?B?dGVLdVhJWXFPei9JbFVNR1Bpb3FldW1CS0wvUG9BeVIrV053Ry9vVFZUSkda?=
 =?utf-8?B?SmVCNjRXTGtwb0tsc1pJcldmamlILzVxNW1Idmh2N1ZQNEp6WWhCYkh2Z1RF?=
 =?utf-8?B?VHlGQ3BaOWFtWTlhZ0llWWhSamt4ZzV3SmtXZUdVU1I0RTQveVIyeThVQVlI?=
 =?utf-8?B?eUlnd3NkQmdVdHg3ZDZDTWg1dWptRXVFRlBUckI3RitlMkhhS2hoNDVjUWlq?=
 =?utf-8?B?VnZXTytuWWdHcTBFeEIzeklzU2lYUjREU2xsSVR1am1MYzQrNHRycFh5Wk11?=
 =?utf-8?B?U2pqZ0RyNFo5aUJLRkQxUUlNc3VUbC9wdU9CeVExUUw5eEZHREY1cm0wdTY1?=
 =?utf-8?B?cURta3F2a0p0TGJMMFl2NnM5d2pLaGwrNmtjQzJIa3dlSzBwZkkrR0dtZmto?=
 =?utf-8?B?SDFFVjlIZmp4SzRqWHl1NmovMm9RU05oMnp2VGhqSzU2RjVRZ3M3eCtRQmRG?=
 =?utf-8?B?MWtBYnBiSGNWekpZTkVnWUJ5N2VPZFhMTnhyTXo3RlRJOVYrakZVNmpqbGpv?=
 =?utf-8?B?eC8yZXZhK0huai9LK1NGWW1wZ0VadnYySy94QWIvTHFUcFFnUUZncHpCNE8w?=
 =?utf-8?B?YTE1ZVExT3VRK2p0OGt4VmxrSnRKc2F5dUp4dmJmb25PNjNaYTZWTTltQ2tT?=
 =?utf-8?B?aWlqdEY3T2ZpbmUvRkpYRlc2bzNsenZ6VC8xMmxxclpld2lVdktSdmRmQ3ky?=
 =?utf-8?B?aFZGTzFheFZ6WmRWR0R5bXZ2OENRRTh4d3p6ZkRHSmI4WWtmb3FhNjRFVUhK?=
 =?utf-8?B?clV4VFJiZTVmNVpURklHcE94eVZxTWxJTmlDY0ROYlE4YWhtdXZTUWJCTlkz?=
 =?utf-8?Q?BZ62XEcfUasCouNCiGj9DEeX6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ade771-cf0f-4e0c-0725-08dc75ced780
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 17:37:21.8939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kigSmQHPOihTuaKEFbue5kJSRdUh9MO+VI/IIBhUquGKYbdZIyDdex9dDvMizMqOJb6dk8Dasmmt91b6WiTcWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7610
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSWFuIFJvZ2VycyA8aXJv
Z2Vyc0Bnb29nbGUuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgTWF5IDE2LCAyMDI0IDk6MTEgQU0N
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
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjggMS83XSBwZXJmIERvY3VtZW50OiBB
ZGQgVFBFQlMgdG8gRG9jdW1lbnRzDQo+IA0KPiBPbiBUdWUsIE1heSAxNCwgMjAyNCBhdCAxMDo0
NOKAr1BNIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogV2Vp
bGluIFdhbmcgPHdlaWxpbi53YW5nQGludGVsLmNvbT4NCj4gPg0KPiA+IFRQRUJTIGlzIGEgbmV3
IGZlYXR1cmUgaW4gbmV4dCBnZW5lcmF0aW9uIG9mIEludGVsIFBNVS4gSXQgd2lsbCBiZSB1c2Vk
IGluIG5ldw0KPiA+IFRNQSByZWxlYXNlcy4gQWRkaW5nIHJlbGF0ZWQgaW50cm9kdWN0aW9uIHRv
IGRvY3VtZW50cyB3aGlsZSBhZGRpbmcgbmV3DQo+IGNvZGUgdG8NCj4gPiBzdXBwb3J0IGl0IGlu
IHBlcmYgc3RhdC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFdlaWxpbiBXYW5nIDx3ZWlsaW4u
d2FuZ0BpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIHRvb2xzL3BlcmYvRG9jdW1lbnRhdGlvbi9w
ZXJmLWxpc3QudHh0IHwgIDEgKw0KPiA+ICB0b29scy9wZXJmL0RvY3VtZW50YXRpb24vdG9wZG93
bi50eHQgICB8IDE4ICsrKysrKysrKysrKysrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDE5
IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS90b29scy9wZXJmL0RvY3VtZW50
YXRpb24vcGVyZi1saXN0LnR4dA0KPiBiL3Rvb2xzL3BlcmYvRG9jdW1lbnRhdGlvbi9wZXJmLWxp
c3QudHh0DQo+ID4gaW5kZXggNmJmMjQ2OGY1OWQzLi5kZWEwMDU0MTBlYzAgMTAwNjQ0DQo+ID4g
LS0tIGEvdG9vbHMvcGVyZi9Eb2N1bWVudGF0aW9uL3BlcmYtbGlzdC50eHQNCj4gPiArKysgYi90
b29scy9wZXJmL0RvY3VtZW50YXRpb24vcGVyZi1saXN0LnR4dA0KPiA+IEBAIC03Miw2ICs3Miw3
IEBAIGNvdW50ZWQuIFRoZSBmb2xsb3dpbmcgbW9kaWZpZXJzIGV4aXN0Og0KPiA+ICAgVyAtIGdy
b3VwIGlzIHdlYWsgYW5kIHdpbGwgZmFsbGJhY2sgdG8gbm9uLWdyb3VwIGlmIG5vdCBzY2hlZHVs
YWJsZSwNCj4gPiAgIGUgLSBncm91cCBvciBldmVudCBhcmUgZXhjbHVzaXZlIGFuZCBkbyBub3Qg
c2hhcmUgdGhlIFBNVQ0KPiA+ICAgYiAtIHVzZSBCUEYgYWdncmVncmF0aW9uIChzZWUgcGVyZiBz
dGF0IC0tYnBmLWNvdW50ZXJzKQ0KPiA+ICsgUiAtIHJldGlyZSBsYXRlbmN5IHZhbHVlIG9mIHRo
ZSBldmVudA0KPiA+DQo+ID4gIFRoZSAncCcgbW9kaWZpZXIgY2FuIGJlIHVzZWQgZm9yIHNwZWNp
ZnlpbmcgaG93IHByZWNpc2UgdGhlIGluc3RydWN0aW9uDQo+ID4gIGFkZHJlc3Mgc2hvdWxkIGJl
LiBUaGUgJ3AnIG1vZGlmaWVyIGNhbiBiZSBzcGVjaWZpZWQgbXVsdGlwbGUgdGltZXM6DQo+ID4g
ZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvRG9jdW1lbnRhdGlvbi90b3Bkb3duLnR4dA0KPiBiL3Rv
b2xzL3BlcmYvRG9jdW1lbnRhdGlvbi90b3Bkb3duLnR4dA0KPiA+IGluZGV4IGFlMGFlZTg2ODQ0
Zi4uZTZjNDQyNGU4YmYyIDEwMDY0NA0KPiA+IC0tLSBhL3Rvb2xzL3BlcmYvRG9jdW1lbnRhdGlv
bi90b3Bkb3duLnR4dA0KPiA+ICsrKyBiL3Rvb2xzL3BlcmYvRG9jdW1lbnRhdGlvbi90b3Bkb3du
LnR4dA0KPiA+IEBAIC0zMjUsNiArMzI1LDI0IEBAIG90aGVyIGZvdXIgbGV2ZWwgMiBtZXRyaWNz
IGJ5IHN1YnRyYWN0aW5nDQo+IGNvcnJlc3BvbmRpbmcgbWV0cmljcyBhcyBiZWxvdy4NCj4gPiAg
ICAgIEZldGNoX0JhbmR3aWR0aCA9IEZyb250ZW5kX0JvdW5kIC0gRmV0Y2hfTGF0ZW5jeQ0KPiA+
ICAgICAgQ29yZV9Cb3VuZCA9IEJhY2tlbmRfQm91bmQgLSBNZW1vcnlfQm91bmQNCj4gPg0KPiA+
ICtUUEVCUyBpbiBUb3BEb3duDQo+ID4gKz09PT09PT09PT09PT09PT0NCj4gPiArDQo+ID4gK1RQ
RUJTIGlzIG9uZSBvZiB0aGUgZmVhdHVyZXMgcHJvdmlkZWQgYnkgdGhlIG5leHQgZ2VuZXJhdGlv
biBvZiBJbnRlbCBQTVUuDQo+IFRoZQ0KPiANCj4gQXMgdGhpcyBkb2N1bWVudGF0aW9uIHdpbGwg
bGl2ZSBhIHdoaWxlICJuZXh0IGdlbmVyYXRpb24iIGNvdWxkIGJlY29tZQ0KPiBhbWJpZ3VvdXMu
IEkgdGhpbmsgaXQgd291bGQgYmUgYmV0dGVyIHRvIG1lbnRpb24gY29yZSB1bHRyYSBvciBzb21l
DQo+IG90aGVyIHRlcm0gdG8gbW9yZSBzcGVjaWZpY2FsbHkgZGVzY3JpYmUgd2hpY2ggUE1VcyBo
YXZlIFRQRUJTLg0KDQpIaSBJYW4sIA0KDQpZZXMsIHlvdSBhcmUgcmlnaHQsIEkgd2lsbCB1cGRh
dGUgaXQuIA0KPiANCj4gPiArVFBFQlMgZmVhdHVyZSBhZGRzIGEgMTYgYml0IHJldGlyZSBsYXRl
bmN5IGZpZWxkIGluIHRoZSBCYXNpYyBJbmZvIGdyb3VwIG9mIHRoZQ0KPiA+ICtQRUJTIHJlY29y
ZC4gSXQgcmVjb3JkcyB0aGUgQ29yZSBjeWNsZXMgc2luY2UgdGhlIHJldGlyZW1lbnQgb2YgdGhl
IHByZXZpb3VzDQo+ID4gK2luc3RydWN0aW9uIHRvIHRoZSByZXRpcmVtZW50IG9mIGN1cnJlbnQg
aW5zdHJ1Y3Rpb24uIFBsZWFzZSByZWZlciB0byBTZWN0aW9uDQo+ID4gKzguNC4xIG9mICJJbnRl
bMKuIEFyY2hpdGVjdHVyZSBJbnN0cnVjdGlvbiBTZXQgRXh0ZW5zaW9ucyBQcm9ncmFtbWluZw0K
PiBSZWZlcmVuY2UiDQo+ID4gK2ZvciBtb3JlIGRldGFpbHMgYWJvdXQgdGhpcyBmZWF0dXJlLg0K
PiANCj4gUGVyaGFwcyBjYXB0dXJlIHRoYXQgdGhpcyBpcyBwbGFjZWQgaW4gdGhlIHBlcmYgZXZl
bnQgc2FtcGxlIGluIHRoZQ0KPiB3ZWlnaHRzIHNlY3Rpb24gYXMgVFBFQlMgaXNuJ3QgZXhwb3Nl
ZCBleGNlcHQgd2l0aGluIHRoZSBrZXJuZWwgUE1VDQo+IGRyaXZlci4NCj4gDQo+ID4gKw0KPiA+
ICtJbiB0aGUgbW9zdCByZWNlbnQgcmVsZWFzZSBvZiBUTUEsIHRoZSBtZXRyaWNzIGJlZ2luIHRv
IHVzZSBldmVudA0KPiByZXRpcmVfbGF0ZW5jeQ0KPiA+ICt2YWx1ZXMgaW4gc29tZSBvZiB0aGUg
bWV0cmljc+KAmSBmb3JtdWxhcyBvbiBwcm9jZXNzb3JzIHRoYXQgc3VwcG9ydCBUUEVCUw0KPiBm
ZWF0dXJlLg0KPiA+ICtGb3IgcHJldmlvdXMgZ2VuZXJhdGlvbnMgdGhhdCBkbyBub3Qgc3VwcG9y
dCBUUEVCUywgdGhlIHZhbHVlcyBhcmUgc3RhdGljDQo+IGFuZA0KPiA+ICtwcmVkZWZpbmVkIHBl
ciBwcm9jZXNzb3IgZmFtaWx5IGJ5IHRoZSBoYXJkd2FyZSBhcmNoaXRlY3RzLiBEdWUgdG8gdGhl
DQo+IGRpdmVyc2l0eQ0KPiA+ICtvZiB3b3JrbG9hZHMgaW4gZXhlY3V0aW9uIGVudmlyb25tZW50
cywgcmV0aXJlIGxhdGVuY3kgdmFsdWVzIG1lYXN1cmVkIGF0DQo+IHJlYWwNCj4gPiArdGltZSBh
cmUgbW9yZSBhY2N1cmF0ZS4gVGhlcmVmb3JlLCBuZXcgVE1BIG1ldHJpY3MgdGhhdCB1c2UgVFBF
QlMgd2lsbA0KPiBwcm92aWRlDQo+ID4gK21vcmUgYWNjdXJhdGUgcGVyZm9ybWFuY2UgYW5hbHlz
aXMgcmVzdWx0cy4NCj4gDQo+IERvIHlvdSB3YW50IHRvIGNhcHR1cmUgd2hhdCB0aGUgdmFsdWUg
d2lsbCBiZSB3aGVuIHRoZXJlIGhhc24ndCBiZWVuIGENCj4gc2FtcGxlPyBUaGlzIGNvcm5lciBj
YXNlIGNvdWxkIGJlIGNvbnNpZGVyZWQgYnJva2VuIGluIHRoZSBuZXcNCj4gYXBwcm9hY2guDQoN
Cg0KV2hlbiB0aGVyZSBpcyBubyBzYW1wbGUsIHdlIHNob3VsZCBleHBlY3QgaXQgdG8gYmUgMCBv
ciB1c2UgZGVmYXVsdCB2YWx1ZS4gSSB3aWxsIA0KYWRkIHRoaXMgaW5mb3JtYXRpb24gaGVyZS4g
SSBkb27igJl0IHRoaW5rIHRoaXMgaXMgYnJva2VuIGZyb20gdGhlIGFwcHJvYWNoJ3MgcGVyc3Bl
Y3RpdmUuIA0KV2UgZG8gbmVlZCB0byBhZGQgY29kZSB0byByZXR1cm4gdGhpcyB2YWx1ZSB3aGVu
IHRoZXJlIGlzIG5vIHNhbXBsZS4NCg0KVGhhbmtzLCANCldlaWxpbg0KDQo+IFRoYW5rcywNCj4g
SWFuDQo+IA0KPiA+ICsNCj4gPg0KPiA+ICBbMV0gaHR0cHM6Ly9zb2Z0d2FyZS5pbnRlbC5jb20v
ZW4tdXMvdG9wLWRvd24tbWljcm9hcmNoaXRlY3R1cmUtYW5hbHlzaXMtDQo+IG1ldGhvZC13aW4N
Cj4gPiAgWzJdIGh0dHBzOi8vc2l0ZXMuZ29vZ2xlLmNvbS9zaXRlL2FuYWx5c2lzbWV0aG9kcy95
YXNpbi1wdWJzDQo+ID4gLS0NCj4gPiAyLjQzLjANCj4gPg0K
