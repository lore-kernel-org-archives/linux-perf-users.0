Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71F127A462;
	Fri,  5 Jun 2026 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679755; cv=fail; b=CmlMZL+ZLzGr94aFbNv5XGXLl1+b/2jvb3XdxAQ5MY7+nH1Yt/KOhdfjHFRngdHLqXfDI+9AhhQXfTqprwjN/smNOb7+UsNhrhEKBQNRutpdU+aQAl+YY2t4tzCrDiYMWiGEUUuX6ZdmQjbrQ6Ma+We4FqOEAbgxJhC9qafzW4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679755; c=relaxed/simple;
	bh=RGd1GyS4FpjO/GnZORH7YJ4gWtcGqeQLSGQ/MDvIIIM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cELGWxk6GbWmHxNG3I4WKTVpztd5LFYI4kzGq/z1Ti13fxQJYrdmwAHd5knxboZn80y76LxY6yRBrWeaecxGpuNeKT4Y0mzg9sPCoolgewZ2LBH/w35i1h0JFy1IBOFnQcpADVzuTer6ZI8/TcqCEzbf+MKJR7wiNCUuwJNNzBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lVL7tFL5; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lVL7tFL5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780679753; x=1812215753;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RGd1GyS4FpjO/GnZORH7YJ4gWtcGqeQLSGQ/MDvIIIM=;
  b=lVL7tFL5WUuTVi9mVdRTPv0QcOk2nU+X8o/lzPofblTq5ithbNSTiRJ/
   dch7lPnK5KKoXGXpcmo7YqZSGpe6dkaeRw3+FD6XlaoelXDr5+YiUtTyf
   UoMvAKXHGjczDSEr1oRstv82qU5Ux0PaB4VpHiA0+z5BVRBm398c6R1nc
   +D56UqTIYEbIjk4+vOq6pEd8PDARNzDVmQqrK83fODpaCU4reK5xH/wOh
   Rfc0oA8cPNmaxkISMPVMkQA4AJmPDW2Trt3izy2zQPRdCxUQ8u3Vo8khP
   qe/kJfKm3mWnhvVsWPmwN2S20nUAypXIYfIvKazzP8KAP0hhoFI2UVzkf
   Q==;
X-CSE-ConnectionGUID: nEFyyo2cRI2CXGdr+a7LYQ==
X-CSE-MsgGUID: ixv8I+iPT8KAwPdsjVKJHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="91829587"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="91829587"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 10:15:53 -0700
X-CSE-ConnectionGUID: P6YoHIqNRsqalzJFaL2Z8g==
X-CSE-MsgGUID: Y6b5yfjZSQGkyHEOsc5ZVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="282975991"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 10:15:53 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 10:15:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 5 Jun 2026 10:15:52 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.52) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 10:15:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIsidOaeNRFGtvXItirfYFh7ScyVsoUtJwIUzzHzcr2jX7fK5Qd9NqojdB3xKpog8L6aGojkr4ixlwlkCkGvfy6bAuwXJ1zaMRu6oQTSaGWXXNwP8P6LCW8YuvcUBLiMIn+KMiwrDFgODEIRQAIgdpVjRDrm72mZKcien++R0Qt9BMlG+HvYBbE12gwGdcng9dIc4lzV9cANzhx1oIXuVN7OQofKfXrfCdWGPtWEECNpHOrRkZK1plDoqxQf77hzEukpB2ZF/OHSXP0lBIC8X9YjDuL0J79dTYsT0xq9SmF2N18Kf4hnTs4a+q81rGyiLFgE0Sp01sgFn29G9427PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGd1GyS4FpjO/GnZORH7YJ4gWtcGqeQLSGQ/MDvIIIM=;
 b=O3r9WmNT1H3lT0LxhLj1Ehs7aqS0oCNmDSF+HB8OTU2HtodWXgZuFAVSyJZ4vgFeGRAGQGjHwOKaLZYyU31oCWfzuDQfjmGYpYMzL3FisbEpKzQzujQWJhynk0bQw2HD43oJ3HnV+9UlOh+J7NnAOB5jy35KOg+KotKGNu1Qo3UCID4xzUPWdBJ0F5ECdzmq+sgSJt83Wcm63evZmfzrGsffECeUN8lbfAUT1BHbwV2pGBgsZLrFO0vpwxkRlbtiYVP/DFe6KDVd01QicuCp37n8n+KHYEMpsXv29Xeh7xIDQtX7CN/xq2xX3kXOqKXHxpCI8G2z947KYMc7K6hrCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by DM4PR11MB7375.namprd11.prod.outlook.com (2603:10b6:8:101::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 17:15:46 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%2]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 17:15:46 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"ak@linux.intel.com" <ak@linux.intel.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "acme@kernel.org" <acme@kernel.org>,
	"dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"namhyung@kernel.org" <namhyung@kernel.org>, "Rogers, Ian"
	<irogers@google.com>, "Eranian, Stephane" <eranian@google.com>
CC: "Chen, Zide" <zide.chen@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "Mi, Dapeng1" <dapeng1.mi@intel.com>,
	"Hao, Xudong" <xudong.hao@intel.com>
Subject: Re: [PATCH 3/8] perf/x86: Update cap_user_rdpmc base on rdpmc user
 disable state
Thread-Topic: [PATCH 3/8] perf/x86: Update cap_user_rdpmc base on rdpmc user
 disable state
Thread-Index: AQHc9IkNR0F+SV9ZmEypnyeqfqpYK7YwNNAA
Date: Fri, 5 Jun 2026 17:15:46 +0000
Message-ID: <fdcb1f3211a493a538fe840f432b36ea073cf92b.camel@intel.com>
References: <20260605011136.2043393-1-dapeng1.mi@linux.intel.com>
	 <20260605011136.2043393-4-dapeng1.mi@linux.intel.com>
In-Reply-To: <20260605011136.2043393-4-dapeng1.mi@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|DM4PR11MB7375:EE_
x-ms-office365-filtering-correlation-id: 26d4ab19-269e-4df2-f9df-08dec3261510
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|38070700021|921020|22082099003|18002099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: Pdqvklzb7/aiDYlYjXLqG6f/KvKaBKrEwoWCPTZlRGDpJMV+0RrrAPTbVHsuMWYLRrAcBzY1/ii3KwnVe4iuwD5efOBlA4zY988oxRX1h4AP9LsqZCMtUZVd3qSmrC90U9nXmYcq+kYrwUmmHNoCqsgZrHC804s8Tgg+Yv3X6wYO0VPqKit29bSMjNk2hYzOb+aOq4zn3IecxLNe+qK5iitvxOdONf9fx5Kk2S+HLiAV666QqJTUOVqdVkavj6vNWJirV1B7nTA8yf9E8h91a1IKPeaIG8uHBGxjF3o8wY/yc6+nhkLwI6UlU3u3Z3ZQoydz3lIQvJHl+KrcePmhppoKkpZDaVovraRsrUVVhsmeXVI2sYSKeOPK+yGhjgtQGDMojmw18B6Erhw4HmNEQp7D+Zbh47xT2kbJzz2Gqa4VMI+lTFQ4/Fylps2xMdJhZiL84AA7L3aeAT02EXYgpoFp8dZmaS9qV78xp+EmDDbTSY/R5U9o8frvfe4pVpgnqXOWGTiTvWIQyAaUSYrqnXWdXXl8kAeLpGCwQZnlGclCMOysCBQwTnAxw3KXKTIJNxzjj6TtsA7WPwSf7T2DZQ8+zrmzCD+6DyHOkKvp5mcmj3gbWCq5s3/ZA5XxTDHPan7QxWWqWdkOJ/QKZ5YeerITduZ31E5rubeGiuJmaiARDkuUaurZ8tE4e3fxpYUGfn1FCTHXc+rOniTl3c3Qawdx7MrwUqeEnzV+YsuCaJSDsF8ehPA1vDPevGQqWoQ98PFOJ4gYLIn3nEAO+8qdTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(38070700021)(921020)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWlTQ1lHK2NPQmhkeVVJOHdpS1ZrNnpoWUt1Vm9pN0VCRjB3SzhBLytRR1g5?=
 =?utf-8?B?T0V3L1M5UEc5MUo2MlBDSWZnYzVhM3QxbGhBUmM2WFdYdUc5ZkE4ZUpIa3Ax?=
 =?utf-8?B?RTI0MzY1RFRFNnF6cVpZTjBweURJNFRXbDZvV0J5Y3V6NnJjY2tqTUxhLzFq?=
 =?utf-8?B?TWg3M09QUTE5YmxPOXAvN1hSN01BS0pJWDUxZEVFOUg1bDVRbXltZk96bktN?=
 =?utf-8?B?YldqNW5tUkp1ZDRuRElmUmNPcVlJWURvU0lGV3VCWnErazZ0djBqbXhGUGc1?=
 =?utf-8?B?c3NLMzVDSUNQMWxObVp4RTJ6dUZ3NnNIUEhsbjJqcU82UEdaUjVJZGVhWi9B?=
 =?utf-8?B?QVJ2UXN0UkFnN0t1K1NSekZ0aVRhTVJ3Y0NLeWxzOUpQR2Frd1NkTmZSbkZ3?=
 =?utf-8?B?Ky9FNldoRUlNSWNHd01ZZ3dGaHJXYTdibFdQMDlVUmFhWS93MkxraTFueUoz?=
 =?utf-8?B?anNVWDltekgrNU1UUTl3T1lRSG9ONTdRZjBuRFRDUk9kQWRycG1wWGlWK2lQ?=
 =?utf-8?B?Ly9tYlAybVk5a2FTSVltR2p5Zy9vcnhTR2VhS3NuZSt1VjVNRmZHckc0K21i?=
 =?utf-8?B?TW1JbDltUktTZ29WSG9GNFlYbDB0dFZtM05CREpZdCtGQ1p2ZFBkZ0VGd2VJ?=
 =?utf-8?B?cUlVVVF0RHJVZk9Hb0FYQ1QvZm9GUW9FZHNZcGZJV3kwUVcyZVJLOU9iV3No?=
 =?utf-8?B?SHNuNTFkQ053V3ZPRDZWSWRPSG5EN2Rta1dQdXZYblVUYWdibWZQNmo1UUVv?=
 =?utf-8?B?QWEya2t2K0tSaFMzTEdQRzQ3TTk4VXRnRy95NGl4Sy83SmR3amJlcE93L0x6?=
 =?utf-8?B?akVjNW5EU2tmaVhOK0dWam9hUXM3bDFVQWlNM3pVV3FONlJNS2xVOHcvRi8v?=
 =?utf-8?B?TTJ0Q0kwMTVkbTVMcGI4RUJ5Rm04aHVBaHR6OXhvYkx5MWVmMjB6dlU5dm1v?=
 =?utf-8?B?UEk2MzJlQXlvYnlVdG15RkpGQm5zN0plc1B1bld2VklqNnprZlQ2Um9HaFVQ?=
 =?utf-8?B?L21vanZwcG1JVGt3VWQrQWxSbGNKWEtFRGsrYmM1bHpiV01ZaVdQYnhrYmpn?=
 =?utf-8?B?NjNQTnlnNHZic3BpZ1BIbXV5N0x2aWxINFlXakl3WmliamNnY0VrZlNUTFQ3?=
 =?utf-8?B?QkRPTnYzaXNDc09rb2psclU2U0tnTDU0Y1V4S2VzK0J5U0pvMkRLQzdaZTZj?=
 =?utf-8?B?eWo3SElKdFFOM0hnVzBhb2pRbndaVS81OG5SdTZZVmIrYkhlQTU4VU5Namph?=
 =?utf-8?B?c3FBWmhqQ1pRMXJJQ2hTN0lITzRTUmZmVVo4K2pqM3pIeTVsTU5veHE4YlhI?=
 =?utf-8?B?K1JoaldxVCtYVjFKUi85VXBZK0dhMGZKMlpKUWZ6Y245aVE0SHVVRVE1cUVx?=
 =?utf-8?B?VlIyWE1SanFzazhRY0tPYjJYbk5HUGcrRzB3K21qK1JQM3RxWDcxVnowQnFM?=
 =?utf-8?B?aDMrZ094ZjVuaSswSFZsQU5uZjFtWVpJTjZxNllGVnRzeEtkZHdLb2NQdEJs?=
 =?utf-8?B?eHIyRzY0VityeC94RUxwWmtvM013YzQ3dHFkeDJHNEZyZnA4SzBwSXdiSk9n?=
 =?utf-8?B?eWYwK3hkUjhodFlnanNuSCtDbnk3RE5LVjZOdFQxM1gyWGpBanM0bHlrRkdu?=
 =?utf-8?B?MGYyeHhubjcwWWI4Z2Jac3ZubnU3ZWRCM3dhN2t2SDFqaDYrbUwvZEl5NUdr?=
 =?utf-8?B?U0RyZE44N3EraEhSSmd0ZnZaQkNVUnBYQjZ4MGxnb0VGdTN5Vm5aQ3dPZjhL?=
 =?utf-8?B?M1VMUmhKN21IaURzdTRYZllHOGJiR0Jkdm1CSG1hcFR1MFNIdEZHUG5hdEhj?=
 =?utf-8?B?QWNHYlJBVlBzakVlM0RLc25JWEhhYmFUcGpqem84NkgyMjFVa1hzVHhBUHB1?=
 =?utf-8?B?VjdLblUzZk83SXh4Z0JrL2ZMMCtYWEZiQTloa3U2aklWV1NBcWFCYmdsY29h?=
 =?utf-8?B?QlV0bmpiLzIrbHFoNFJNTDllNWVOeGsyZzVPUkluVG9VN1lXSFVKR21pZ3l5?=
 =?utf-8?B?cW9Bb0ZuOFprN2lnVjM5MVNJVTV1bzU5OFhtU2VBMFRBSHRxQzZJRUVhTGJv?=
 =?utf-8?B?TnVmQXBsZ0VJSHBZY3g5TllyUHNHSDhBelJRNVlTSjJqZTVtMFlBWENITnZh?=
 =?utf-8?B?b29aNTJkOWtjZUlNSXFVb1NzdGFlMmtoRWk1bVpVQ2g1Q3lZUmZFaWdHZUFB?=
 =?utf-8?B?Y1JhazlFQjJXYi9xOHJZdFR0Q1hiNDNMMU8yZGdFN2NtMmVIa0g5UGhMbDNn?=
 =?utf-8?B?M055VVlleURSei9naHhsSjhjRnV1U0R0Tzc2elFoRkMvZisvWlpFcDlyMExF?=
 =?utf-8?B?dHVPLy9aVEpySmo3MVhHM3lxQVdsSHNUa3FmYmxteXVMQVM1N09DN0pkOU5x?=
 =?utf-8?Q?tRBcN0fXDPRLaubMl9iWuEel1zRww29RnbYUDvgSA8ZuD?=
x-ms-exchange-antispam-messagedata-1: jNYK9dAJm26Wdw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E3D2AFAE80B9244B11370AB108180E7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Eg7aJMNhOtaFeg+sWjmcWzkEf72+lrJ2npKI5UJvUTHT5eS90fjpUctrxMyYyh0p0pvUUfwnwdoThGKlGgzwvwm3cuwY0ZA6CaoSqQp2oI5+mxVZPylcyq3AjzPQ/rvKSI1n1nnPnYZUxskHOWqtE8rwrE4kMNG4sLP1Al6mbn8YaUmM8MECTcBVL6LzqHGdf7DwRjpxg4cB1juM2aQjMDhGus1Wt2+AtdQ1BA4bEgHNEuaFsf0lDvga6U4z/919SloA2RpnpKDTuPLhfeKz9tbQdnGWnBA1VWXCFt/Wmg9YYsuzMigZptEmEXzYS9d3RmEStGQoPIvlwZ37WO3lYg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d4ab19-269e-4df2-f9df-08dec3261510
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 17:15:46.2756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kCHrJTd+XfDmmCgzAR5veuEcpAPIND72p0vA3SLGQHSL8VDFy64SEKIhD4804BmSQWFvHMmYUcc/7xjMXdgNkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7375
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA2LTA1IGF0IDA5OjExICswODAwLCBEYXBlbmcgTWkgd3JvdGU6DQo+IEFm
dGVyIGludHJvZHVjaW5nIHRoZSBSRFBNQyB1c2VyIGRpc2FibGUgZmVhdHVyZSwgdXNlci1zcGFj
ZSBSRFBNQw0KPiBtYXkNCj4gcmV0dXJuIDAgaW5zdGVhZCBvZiB0aGUgYWN0dWFsIGV2ZW50IGNv
dW50LiBUaGlzIGNyZWF0ZXMgYW4NCj4gaW5jb25zaXN0ZW5jeQ0KPiB3aXRoIGNhcF91c2VyX3Jk
cG1jLCB3aGVyZSBjYXBfdXNlcl9yZHBtYyBpcyBzZXQsIGJ1dCB1c2VyLXNwYWNlDQo+IFJEUE1D
DQo+IG9ubHkgcmV0dXJucyAwLg0KPiANCj4gVG8gYWNjdXJhdGVseSByZXByZXNlbnQgdGhlIHVz
ZXItc3BhY2UgUkRQTUMgY2FwYWJpbGl0eSwgdXBkYXRlDQo+IGNhcF91c2VyX3JkcG1jIGJhc2Vk
IG9uIHRoZSBSRFBNQyB1c2VyIGRpc2FibGUgc3RhdGUuIElmIFJEUE1DIHVzZXINCj4gZGlzYWJs
ZSBpcyBlbmFibGVkLCBjYXBfdXNlcl9yZHBtYyBpcyBzZXQgdG8gZmFsc2UsIGFsbG93aW5nIHVz
ZXItDQo+IHNwYWNlDQo+IHByb2dyYW1zIHRvIGZhbGwgYmFjayB0byB0aGUgcmVhZCgpIHN5c2Nh
bGwgdG8gb2J0YWluIHRoZSByZWFsIGV2ZW50DQo+IGNvdW50Lg0KPiANCj4gU2luY2UgYXJjaF9w
ZXJmX3VwZGF0ZV91c2VycGFnZSgpIGNvdWxkIGJlIGNhbGxlZCBmb3Igc29mdHdhcmUNCj4gZXZl
bnRzLA0KPiBlbmhhbmNlIHg4Nl9wbXVfaGFzX3JkcG1jX3VzZXJfZGlzYWJsZSgpIHRvIG9ubHkg
Y2hlY2sgdGhlIHg4NiBQTVVzLg0KDQpMR1RNLg0KDQpSZXZpZXdlZC1ieTogVGhvbWFzIEZhbGNv
biA8dGhvbWFzLmZhbGNvbkBpbnRlbC5jb20+DQoNClRoYW5rcywNClRvbQ0KDQo+IA0KPiBGaXhl
czogNTlhZjk1ZTAyOGQ0ICgicGVyZi94ODYvaW50ZWw6IEFkZCBzdXBwb3J0IGZvciByZHBtYyB1
c2VyDQo+IGRpc2FibGUgZmVhdHVyZSIpDQo+IFNpZ25lZC1vZmYtYnk6IERhcGVuZyBNaSA8ZGFw
ZW5nMS5taUBsaW51eC5pbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBaaWRlIENoZW4gPHppZGUu
Y2hlbkBpbnRlbC5jb20+DQo+IC0tLQ0KPiANCj4gT3JpZ2luYWwgcGF0Y2ggbGluazoNCj4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYwMzE2MDUwODM4LjM2MjQwNTEtMi1kYXBlbmcx
Lm1pQGxpbnV4LmludGVsLmNvbS8NCj4gDQo+IMKgYXJjaC94ODYvZXZlbnRzL2NvcmUuY8KgwqDC
oMKgwqDCoCB8IDMgKysrDQo+IMKgYXJjaC94ODYvZXZlbnRzL3BlcmZfZXZlbnQuaCB8IDUgKysr
LS0NCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9ldmVudHMvY29yZS5jIGIvYXJjaC94ODYvZXZl
bnRzL2NvcmUuYw0KPiBpbmRleCAzYmQwNTIyYWZlNmQuLjZjZDk1YjhlMzFjYiAxMDA2NDQNCj4g
LS0tIGEvYXJjaC94ODYvZXZlbnRzL2NvcmUuYw0KPiArKysgYi9hcmNoL3g4Ni9ldmVudHMvY29y
ZS5jDQo+IEBAIC0yNzk3LDYgKzI3OTcsOSBAQCB2b2lkIGFyY2hfcGVyZl91cGRhdGVfdXNlcnBh
Z2Uoc3RydWN0DQo+IHBlcmZfZXZlbnQgKmV2ZW50LA0KPiDCoAl1c2VycGctPmNhcF91c2VyX3Rp
bWVfemVybyA9IDA7DQo+IMKgCXVzZXJwZy0+Y2FwX3VzZXJfcmRwbWMgPQ0KPiDCoAkJISEoZXZl
bnQtPmh3LmZsYWdzICYgUEVSRl9FVkVOVF9GTEFHX1VTRVJfUkVBRF9DTlQpOw0KPiArCWlmICh4
ODZfcG11X2hhc19yZHBtY191c2VyX2Rpc2FibGUoZXZlbnQtPnBtdSkgJiYNCj4gKwnCoMKgwqAg
ZXZlbnQtPmh3LmNvbmZpZyAmDQo+IEFSQ0hfUEVSRk1PTl9FVkVOVFNFTF9SRFBNQ19VU0VSX0RJ
U0FCTEUpDQo+ICsJCXVzZXJwZy0+Y2FwX3VzZXJfcmRwbWMgPSAwOw0KPiDCoAl1c2VycGctPnBt
Y193aWR0aCA9IHg4Nl9wbXUuY250dmFsX2JpdHM7DQo+IMKgDQo+IMKgCWlmICghdXNpbmdfbmF0
aXZlX3NjaGVkX2Nsb2NrKCkgfHwgIXNjaGVkX2Nsb2NrX3N0YWJsZSgpKQ0KPiBkaWZmIC0tZ2l0
IGEvYXJjaC94ODYvZXZlbnRzL3BlcmZfZXZlbnQuaA0KPiBiL2FyY2gveDg2L2V2ZW50cy9wZXJm
X2V2ZW50LmgNCj4gaW5kZXggZGJiNWM4ZThhOGVhLi40MDAzZTJlMGFhOWMgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gveDg2L2V2ZW50cy9wZXJmX2V2ZW50LmgNCj4gKysrIGIvYXJjaC94ODYvZXZlbnRz
L3BlcmZfZXZlbnQuaA0KPiBAQCAtMTM1OSw4ICsxMzU5LDkgQEAgc3RhdGljIGlubGluZSB1NjQN
Cj4geDg2X3BtdV9nZXRfZXZlbnRfY29uZmlnKHN0cnVjdCBwZXJmX2V2ZW50ICpldmVudCkNCj4g
wqANCj4gwqBzdGF0aWMgaW5saW5lIGJvb2wgeDg2X3BtdV9oYXNfcmRwbWNfdXNlcl9kaXNhYmxl
KHN0cnVjdCBwbXUgKnBtdSkNCj4gwqB7DQo+IC0JcmV0dXJuICEhKGh5YnJpZChwbXUsIGNvbmZp
Z19tYXNrKSAmDQo+IC0JCSBBUkNIX1BFUkZNT05fRVZFTlRTRUxfUkRQTUNfVVNFUl9ESVNBQkxF
KTsNCj4gKwlyZXR1cm4gaXNfeDg2X3BtdShwbXUpICYmDQo+ICsJwqDCoMKgwqDCoMKgIChoeWJy
aWQocG11LCBjb25maWdfbWFzaykgJg0KPiArCQlBUkNIX1BFUkZNT05fRVZFTlRTRUxfUkRQTUNf
VVNFUl9ESVNBQkxFKTsNCj4gwqB9DQo+IMKgDQo+IMKgZXh0ZXJuIHN0cnVjdCBldmVudF9jb25z
dHJhaW50IGVtcHR5Y29uc3RyYWludDsNCg0K
