Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8C73EEAF9;
	Fri,  5 Jun 2026 18:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780685256; cv=fail; b=BG82p5iE+/BYcYbx814ZP9AHTy8JG0xqHQyOoBSkM5AesfCzwjXrLX+iWf0ERWFKH09DbXfbm+8/ajzBRdjbJ3m9jFxfmRqYwE54gwlcDDL4pwUsr4PfHp2l6bQvww4VC0ZVRJGhodaTK/4WyIRqhv4uF6eE08Crkv3xNCo2+ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780685256; c=relaxed/simple;
	bh=kGz/zBHTJGyXJgKNVmstHwI4xKWyzSj1LVDwKtPz72o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SXHV4Fap6OMev5nSLHGsbuNHkes0wnm7J4HLlorXFEjC1MSKqsRre7P8yuQ7IrH4FH1ho3RNsZvreL/NIk2pp0JlbNZhipD0T5Rx3BrcKzX+syQNETdEB6FvTYoPJXS6q+3xsggt23dPCdCEpa6T/etZ8RgfJU9fkMW/uH7RPg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I7T5COJt; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I7T5COJt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780685255; x=1812221255;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kGz/zBHTJGyXJgKNVmstHwI4xKWyzSj1LVDwKtPz72o=;
  b=I7T5COJtwLb3qxyf6el4Hz9gsMxRRixEvSGGTncMp5feudaz1TV2127L
   uMv5XNjKVrzZm5+70+brKwoFGOH+311cj6AJsrGjcc7flUZxz1GdDW2gp
   JZuSNTpG2D6BFBvIMX1oh2Nv/ijkp3csN+GX6qWtd6oUKAx83YL7Y6Wxp
   Kok7da2nMRubk/tQmNtoPkwKmZA9VRK//r227mV0WjekF/FooXWfBoKxd
   e15DkD/AgANL8JWOt/SSo+pYRylrXc40wyFWG8WaFhtSsNxepzugHr18O
   0hKOBkqIUhR2rAwPNCxGQ37pjYQNOAP4ZTr1k6Cu/TnK7wqjnMkpqR+4G
   g==;
X-CSE-ConnectionGUID: M+fMCMS5QDeBLN3sI7QUzA==
X-CSE-MsgGUID: hS779gxmRqyagdMz1qIbgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="81522958"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="81522958"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 11:47:35 -0700
X-CSE-ConnectionGUID: K9/elXtiQ2yT50tmClvKxg==
X-CSE-MsgGUID: 1VHW01wETMuSD3BlpwB4Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="248841004"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 11:47:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 11:47:33 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 5 Jun 2026 11:47:33 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.59) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 11:47:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5M9WReXc1Zw1ifZsZjLft/kurfuWeLR00R5VTetCidCdiMqGLr6DOt6I6kw/aWPEU6fyr4mtRwFb9AZxNR8cC2uIReOM14TnHOD+hOtj1GPl9Trs8ZmOj7Xy+KVt/I+pAfLHGbbss0TciLeiJiQc9vw4UYDmYzgsig3sFKLadZqGv6Il79EG4L16s9WK5L0QgIsV4WoBML3QaqN6QTlBpSkYCX6nGgtQ4jJQSX+0w3eZkk3FbiDk5ahXbdoJZLn0sw+Dzpqapp3tR8LEs/z9Mdcl3QrWg1T75STgSDrYhUsyWmMC18C4lrRTeFmSnNrN+HMQzkDKuXODi5UDBpO+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGz/zBHTJGyXJgKNVmstHwI4xKWyzSj1LVDwKtPz72o=;
 b=mYiEMIUfoWHx64HLr9lcaNrJ2g/llfa3hxVr9ZD2Q1M/TEKSKE2r13VEihv/Z1BdayQ/dZhXkaKSIHhXYsfGgy2ZvRYc18eca0xmskYkKxOeva0Pj68PhcFlURwe+UBGdWOJHS3ncFcW1sja5TmatLUrrY/Np8f2ISftVpFI8oJUCrgFNiKBysj8PZft+xzi9jEFUUq3uh16s/2PPYR672RheYrp0reyWqgGL1n/hum+ncDR24WpDEBD0CtcSD0xmUfvgKcIu9G0X4GJOEGEqHyFgwq/7dCrjt+EifdFJPmQbO+b/hMuL4lgRv80B9nGn51N9/sT5yf30vFcYvj5HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by CO1PR11MB4961.namprd11.prod.outlook.com (2603:10b6:303:93::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 18:47:30 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%2]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 18:47:30 +0000
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
Subject: Re: [PATCH 6/8] perf/x86/intel: Validate return value of
 intel_pmu_init_hybrid()
Thread-Topic: [PATCH 6/8] perf/x86/intel: Validate return value of
 intel_pmu_init_hybrid()
Thread-Index: AQHc9IkP6yYREGtzyUisDr1/Itm7S7YwTnEA
Date: Fri, 5 Jun 2026 18:47:30 +0000
Message-ID: <3ebc81d35d48456b920f46b1ac1b0c5d73755bd8.camel@intel.com>
References: <20260605011136.2043393-1-dapeng1.mi@linux.intel.com>
	 <20260605011136.2043393-7-dapeng1.mi@linux.intel.com>
In-Reply-To: <20260605011136.2043393-7-dapeng1.mi@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|CO1PR11MB4961:EE_
x-ms-office365-filtering-correlation-id: aa9524a4-d2f0-42eb-3d71-08dec332e596
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|7416014|22082099003|38070700021|6133799003|18002099003|921020|3023799007|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: pfANFUCofWTJX9Q7cup5wD4PupAv2F0XmOGhq5qPFLSYrE45RJfO/xy3UQIz5DlJGaJodQISN1rB5UZMu9clgtajvEWZBreTNjPkIhLMtdHs26oyGnihKO3TkwcVGYfELpJaJ38KZN3Vo20iQEEdjDNjl331B3FLmAYehbpSZ8cOCYxCbZlRlHcGNqN/9KakJYE5D65cl9TouykdwkYVi3BBRLXmevt8Y+ChuBvfn5HojdBbmhAcpjZ7RDwG/kS4vIYifTP9s3nBoNut5IiXPoTm/OoxBu0uLssd67foYKYpbgPUqyzZVo9pH0uY1aqmr20SKlslq+B3dDMwkz/MEcLxUT5v8uOKDbIGmDDQktTmomK79lvk2+VyLzVbHpuK55poflhgrXG1sMxc1zSHB4X8EhDz+XVGflv3eWUsKuZOAL05EmNPQmbP1lmWhYZ4UP3u9qMueh2BP7mgURWT9g80MpsOjfmfPj3BqJv80LLUPB1FtJNd6js1fFPEutFgLgXeEumPYIzvEQd/o3KSLcXDjjxOFdBz3vYBbFFOkU20zE3d1aXRMW1P21IHJO3tFFu3j0+G9ycslH2XtELxh8x4o0Y7OP5YNgjPlWeZeF4uBmycn9wIfLpAMQPfyKMgEqm30AbmALPljURYQgm2hHJBz3SDwQli4XqlNgBjqMCZgkWjM5d53S4Sbpwmdu6KXGmHYhp7hG8kvuMECRXDEQCQFObpxeeGHVouWY3/gNLkwow+N93+tR5fknhTUJgfZQIVMPJ2coqKjgSF/quiEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(7416014)(22082099003)(38070700021)(6133799003)(18002099003)(921020)(3023799007)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEtSZm5TZ0tjaHNyWDZmVjZjL0NJMXBZSlpBY1hhSjJSKzRUc0hUMGE5K3hj?=
 =?utf-8?B?K1dlM1Vyd20xbXl3WW0wZWV6Z3NVZTlFeEFSdy9tOTlXWGdwZ2Y2citpZ2xs?=
 =?utf-8?B?djVzQ1UybTJLUWJIWGxsbjVhZlFRQ0ptVFRkWDV1VHBPTWRETmlGU1RCQ0Z1?=
 =?utf-8?B?SEY0ZFR1UlpJeTZYYUlYNnFZOE9MV04wYytnN0tCRWE2SXZvM09WSG1SRDJF?=
 =?utf-8?B?REZtanVGUmVCM2ZPVkhMZlRaZzVPby80WmVMNzl1V2w5d1RJVERHVi9aL05O?=
 =?utf-8?B?ZmcvRS9idHp6VnNJYnNPVEdtcVIvdGVFVFY1UEpVVGgvdWo1WXdjMHNMdkZ0?=
 =?utf-8?B?N3lWQlhPMFZFMjlYSXNGbHpRVDJyNzB2MWVqTzFydWtaVGwrZUh1Yk1Cbklp?=
 =?utf-8?B?aFZxVVQwbkxnUXBMYkV2SlhGRThvc0s3NkNRQ3o4YnpwK3hzMlhWSUVOall4?=
 =?utf-8?B?TEJLSCs1MWJXdWppUmsraTlYWndMVWZ4SXZBUWVxYXFJc2IvcW9tTjlZUENB?=
 =?utf-8?B?WDVnaG5RRDFHMk42TGRUNlFEaTBzZG5xVW1Zb3pObFJQTE81Y2NyOWNDbUMr?=
 =?utf-8?B?QUxmMUF4MVllQ3g4WFEvMlF5ZmozZmtuRU5qT3hnaFlHVHJONU5zSFVFbzR0?=
 =?utf-8?B?eEgrYWlHN1ltTVFZSDYwWXlPdDYyVEM4MDNGbTFJVFRmdnBPYVpVeHUyNEtT?=
 =?utf-8?B?ank1ZEU0ZnM5a280NEpCMnBKSGp2TGthR0o4Z1VPNEM3STVtVEFMQ0tLWDls?=
 =?utf-8?B?c2wydWVBZzJmc3Fudzl3dlUrUWpHVERMS1d3RzJEczdhTUc2ZE4zVnI1VXor?=
 =?utf-8?B?Uy83dk96ZUpaTGEzcUVuMmVsSUNSVzZ0VHpTTXpHZjcrYk5sUjJEN1ptclRE?=
 =?utf-8?B?STlBWlVhZjVSTXlUdmlrOFh5VG1HMHJRWm1oM3U0NmFNdDNxR09ic284UW04?=
 =?utf-8?B?YitHTVM5SXhWUkpSdnA1WloxVWs3ZFpocTFjQkc0NDQ0UDhGL0d4NzRIdFBt?=
 =?utf-8?B?ZVlZTVhuSHI3ZC9TTWFuRitrdTJLNnpkYzlSRmZ3R2V5c1NsV1QvNUtoOGYw?=
 =?utf-8?B?T2tuY240bCtJVlcyMlpZL01OWUxRMVZhUjVKZnJ0UkNLcEZLdEZ0d29sdGpa?=
 =?utf-8?B?ZHZNVDBvK0VRc3c3cW5SbThHY2tFVXQwcllLTHJzckxvLzI0SllDeWlreEFE?=
 =?utf-8?B?UkFQdys3WDdjNzhNYmZtdElHV2JBQXJBUHIxM0FSNktzY0FvNzBVcC9yR0Jz?=
 =?utf-8?B?SzNMam1NUlZud3hpTU9RS0VBcmxEejlXa0RRUDdaOWsyT0NYVkVPRWFEOEVC?=
 =?utf-8?B?dUZNNWtScWNrYU1KU0VkYVdCT3NMV2dwNFIzd3ZrOFBzdXhiTkp1ZWxFNzRH?=
 =?utf-8?B?bW9ROWF5N2kzRnFkbVROU3NaR3NTTmU1ZnpOUXM5Q0pSU0ZDNnZTQ3prRXdW?=
 =?utf-8?B?S2JlQlJwZW84V2pKU2xPMkJWMmFoYkF3Wk9BWXJpdnFMVzZrZjdQQlJHa255?=
 =?utf-8?B?djI2RW9OYW1PK3hyTWsrTG8rYlpGRk5QbzV3V3VFdjJkQkhtb0Vlc3BqSE1w?=
 =?utf-8?B?Q1E0V1UxK25XOGlGMzNGamRUWVdURTkvQnJLZ3BRbUxjc3R1RUtHajhETjZm?=
 =?utf-8?B?UnNQcHA5Sjg0bEFnS2JhSWM2d1NnY0JyVm5nMW5jdUdJNHhTME9sYi9DOGpO?=
 =?utf-8?B?Rk9VNHFQY3pLZzlmYjgwQnNFdGZzM0xwaGUydFRXWmhLVjhvV1JmOWZKSGJZ?=
 =?utf-8?B?SDVrZVk2TzhhTXI5TkpsTE5qY0xkVm05NnpwUGRpQ1dGMGJ1dkxOV1FCTHdS?=
 =?utf-8?B?Ym5KdDlBMXpSU1ZVb3FHTkJCMWdsVjlpT1BRUlRPcFZtd3ZYZ21iUWNsaldl?=
 =?utf-8?B?NFRzdUVlV1hKUkVaR2R1U01kdWxzQWs2MUc2VWFvdUI2bUczYmdZYUQ4N2xS?=
 =?utf-8?B?QWZBcmpnMkhMS2lwdDJFeW9yVjZlcnp6MnFuUndYak0zVUhSN2liOElCTkNp?=
 =?utf-8?B?bTA3V1NvZm5qUDNQNzNQWDRERlNaNG1NU3UycCtjV1h1Q05QMk0xV1djRkNl?=
 =?utf-8?B?Z3NER3ozT0pPRUhrY3MvWEMyck5DQ09kZUFmNWVmUWpQT2d1K2tucEdhR3BE?=
 =?utf-8?B?bjFhQXBoc0ZXYnVWWFBhNmNpMUR1QXM3MXFZaUorckx3NU1jdVhOckZwSUJD?=
 =?utf-8?B?QytNdDhtNGhIYk5xZHViUEo1cUI0eEtsdEtHdWVYelNiV3ZHZHNaUlk3bHF3?=
 =?utf-8?B?MnAwZHFnR2xFMmVCWmVDUG5lTi9QeFJMai9aYUJtU1FGSnB3WlcrVG5GUmQr?=
 =?utf-8?B?Q085YmttUVZwTG9HVS9xTGk2ZzdEbjBFK0c1MWRDUEdpWGNjbThHQ0cvRits?=
 =?utf-8?Q?u+KTQsBAWtCYzez/D4HHw0lYpF8ZTYEZRI8BhBuNLUwoJ?=
x-ms-exchange-antispam-messagedata-1: 0x3Fpfg1adeVnA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C15464CCCBB7D498F280A6CC75247A7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: b69iJr9jah+L0rrEDbj4yYrGzDaXCFNqCSYKrrwKZYzFczymBW35Ku12YamnhsF3ueqy9z1kI7iKWWi040qL2IawqL87L2E7V/UOZKHwOUizIRqpW0lJf0q6c/2nKHcsoimVYjROMXw3iX4UkOXs16vSHJ6ncSQoUUocVBVdUAq6K52IsWjizMkb1MUhA/efUKxHB4k43vpvt2B6aKs5bK5VS1TlUrZ4h6llAih/JAcT6FBYQ6dOeOMf++ECx5yS1priHilAqmGlRmt/BCoM9BsMPHHdIBEaehl2Rg0slWKFRtarsh65dnA71LiMNOi+dfwTtKvzV+EA/8Z46yEeIg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9524a4-d2f0-42eb-3d71-08dec332e596
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 18:47:30.0266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZGYIDwmfppf8nlkaKJZkF7A+T68GFaIyNE8DUtKqePcrNl6zj49btsmYPYWL3A+Qi0SothPRRBK88qQc1mkmqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4961
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA2LTA1IGF0IDA5OjExICswODAwLCBEYXBlbmcgTWkgd3JvdGU6DQo+IFRo
ZSBtZW1vcnkgYWxsb2NhdGlvbiBmb3IgdGhlIHg4Nl9wbXUuaHlicmlkX3BtdVtdIGFycmF5IGlu
DQo+IGludGVsX3BtdV9pbml0X2h5YnJpZCgpIGNhbiB0aGVvcmV0aWNhbGx5IGZhaWwgZHVlIHRv
IG1lbW9yeQ0KPiBzaG9ydGFnZXMuDQo+IElmIHRoaXMgb2NjdXJzLCB0aGUgaW5pdGlhbGl6YXRp
b24gb2YgdGhlIHg4NiBoeWJyaWQgUE1VIHdvdWxkIGZhaWwuDQo+IA0KPiBDdXJyZW50bHksIHRo
ZSBjb2RlIGRvZXMgbm90IGNoZWNrIHRoZSByZXR1cm4gdmFsdWUgb2YgdGhlDQo+IGludGVsX3Bt
dV9pbml0X2h5YnJpZCgpIGZ1bmN0aW9uLCB3aGljaCBjb3VsZCBsZWFkIHRvIGF0dGVtcHRzIHRv
DQo+IGFjY2Vzcw0KPiB0aGUgdW5pbml0aWFsaXplZCB4ODZfcG11Lmh5YnJpZF9wbXVbXSBhcnJh
eSwgcG90ZW50aWFsbHkgY2F1c2luZyBhDQo+IHN5c3RlbSBwYW5pYy4NCj4gDQo+IFNvLCBhZGRz
IGEgY2hlY2sgZm9yIHRoZSByZXR1cm4gdmFsdWUgb2YgaW50ZWxfcG11X2luaXRfaHlicmlkKCkg
dG8NCj4gcHJldmVudCBpbnZhbGlkIG1lbW9yeSBhY2Nlc3MgaW4gc3VjaCBzY2VuYXJpb3MuIEJl
c2lkZXMsIGZyZWUgdGhlDQo+IGNyZWF0ZWQga21lbSBjYWNoZSB3aGVuIGVycm9yIG9jY3Vycy4N
Cg0KTEdUTS4NCg0KUmV2aWV3ZWQtYnk6IFRob21hcyBGYWxjb24gPHRob21hcy5mYWxjb25AaW50
ZWwuY29tPg0KDQp0aGFua3MsDQpUb20NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGFwZW5nIE1p
IDxkYXBlbmcxLm1pQGxpbnV4LmludGVsLmNvbT4NCj4gLS0tDQo+IMKgYXJjaC94ODYvZXZlbnRz
L2ludGVsL2NvcmUuYyB8IDMzICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KPiDC
oDEgZmlsZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2V2ZW50cy9pbnRlbC9jb3JlLmMNCj4gYi9hcmNoL3g4Ni9l
dmVudHMvaW50ZWwvY29yZS5jDQo+IGluZGV4IGVhM2FiMzA1MGEzYi4uZWZkOWNhYTM1MDJjIDEw
MDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9ldmVudHMvaW50ZWwvY29yZS5jDQo+ICsrKyBiL2FyY2gv
eDg2L2V2ZW50cy9pbnRlbC9jb3JlLmMNCj4gQEAgLTc4NzAsNiArNzg3MCw3IEBAIF9faW5pdCBp
bnQgaW50ZWxfcG11X2luaXQodm9pZCkNCj4gwqAJaW50IHZlcnNpb24sIGk7DQo+IMKgCWNoYXIg
Km5hbWU7DQo+IMKgCXN0cnVjdCB4ODZfaHlicmlkX3BtdSAqcG11Ow0KPiArCWludCByZXQ7DQo+
IMKgDQo+IMKgCS8qIEFyY2hpdGVjdHVyYWwgUGVyZm1vbiB3YXMgaW50cm9kdWNlZCBzdGFydGlu
ZyB3aXRoIENvcmUNCj4gIllvbmFoIiAqLw0KPiDCoAlpZiAoIWNwdV9oYXMoJmJvb3RfY3B1X2Rh
dGEsIFg4Nl9GRUFUVVJFX0FSQ0hfUEVSRk1PTikpIHsNCj4gQEAgLTg1MzksNyArODU0MCw5IEBA
IF9faW5pdCBpbnQgaW50ZWxfcG11X2luaXQodm9pZCkNCj4gwqAJCSAqDQo+IMKgCQkgKiBJbml0
aWFsaXplIHRoZSBjb21tb24gUGVyZk1vbiBjYXBhYmlsaXRpZXMgaGVyZS4NCj4gwqAJCSAqLw0K
PiAtCQlpbnRlbF9wbXVfaW5pdF9oeWJyaWQoaHlicmlkX2JpZ19zbWFsbCk7DQo+ICsJCXJldCA9
IGludGVsX3BtdV9pbml0X2h5YnJpZChoeWJyaWRfYmlnX3NtYWxsKTsNCj4gKwkJaWYgKHJldCA8
IDApDQo+ICsJCQlnb3RvIGVycjsNCj4gwqANCj4gwqAJCXg4Nl9wbXUucGVic19sYXRlbmN5X2Rh
dGEgPSBncnRfbGF0ZW5jeV9kYXRhOw0KPiDCoAkJeDg2X3BtdS5nZXRfZXZlbnRfY29uc3RyYWlu
dHMgPQ0KPiBhZGxfZ2V0X2V2ZW50X2NvbnN0cmFpbnRzOw0KPiBAQCAtODU5Nyw3ICs4NjAwLDkg
QEAgX19pbml0IGludCBpbnRlbF9wbXVfaW5pdCh2b2lkKQ0KPiDCoAljYXNlIElOVEVMX01FVEVP
UkxBS0U6DQo+IMKgCWNhc2UgSU5URUxfTUVURU9STEFLRV9MOg0KPiDCoAljYXNlIElOVEVMX0FS
Uk9XTEFLRV9VOg0KPiAtCQlpbnRlbF9wbXVfaW5pdF9oeWJyaWQoaHlicmlkX2JpZ19zbWFsbCk7
DQo+ICsJCXJldCA9IGludGVsX3BtdV9pbml0X2h5YnJpZChoeWJyaWRfYmlnX3NtYWxsKTsNCj4g
KwkJaWYgKHJldCA8IDApDQo+ICsJCQlnb3RvIGVycjsNCj4gwqANCj4gwqAJCXg4Nl9wbXUucGVi
c19sYXRlbmN5X2RhdGEgPSBjbXRfbGF0ZW5jeV9kYXRhOw0KPiDCoAkJeDg2X3BtdS5nZXRfZXZl
bnRfY29uc3RyYWludHMgPQ0KPiBtdGxfZ2V0X2V2ZW50X2NvbnN0cmFpbnRzOw0KPiBAQCAtODYy
OCw3ICs4NjMzLDkgQEAgX19pbml0IGludCBpbnRlbF9wbXVfaW5pdCh2b2lkKQ0KPiDCoAkJcHJf
Y29udCgiUGFudGhlcmxha2UgSHlicmlkIGV2ZW50cywgIik7DQo+IMKgCQluYW1lID0gInBhbnRo
ZXJsYWtlX2h5YnJpZCI7DQo+IMKgDQo+IC0JCWludGVsX3BtdV9pbml0X2h5YnJpZChoeWJyaWRf
YmlnX3NtYWxsKTsNCj4gKwkJcmV0ID0gaW50ZWxfcG11X2luaXRfaHlicmlkKGh5YnJpZF9iaWdf
c21hbGwpOw0KPiArCQlpZiAocmV0IDwgMCkNCj4gKwkJCWdvdG8gZXJyOw0KPiDCoA0KPiDCoAkJ
LyogSW5pdGlhbGl6ZSBiaWcgY29yZSBzcGVjaWZpYyBQZXJmTW9uDQo+IGNhcGFiaWxpdGllcy4q
Lw0KPiDCoAkJcG11ID0gJng4Nl9wbXUuaHlicmlkX3BtdVtYODZfSFlCUklEX1BNVV9DT1JFX0lE
WF07DQo+IEBAIC04NjQzLDcgKzg2NTAsOSBAQCBfX2luaXQgaW50IGludGVsX3BtdV9pbml0KHZv
aWQpDQo+IMKgCQlwcl9jb250KCJBcnJvd2xha2UgSHlicmlkIGV2ZW50cywgIik7DQo+IMKgCQlu
YW1lID0gImFycm93bGFrZV9oeWJyaWQiOw0KPiDCoA0KPiAtCQlpbnRlbF9wbXVfaW5pdF9oeWJy
aWQoaHlicmlkX2JpZ19zbWFsbCk7DQo+ICsJCXJldCA9IGludGVsX3BtdV9pbml0X2h5YnJpZCho
eWJyaWRfYmlnX3NtYWxsKTsNCj4gKwkJaWYgKHJldCA8IDApDQo+ICsJCQlnb3RvIGVycjsNCj4g
wqANCj4gwqAJCS8qIEluaXRpYWxpemUgYmlnIGNvcmUgc3BlY2lmaWMgUGVyZk1vbg0KPiBjYXBh
YmlsaXRpZXMuKi8NCj4gwqAJCXBtdSA9ICZ4ODZfcG11Lmh5YnJpZF9wbXVbWDg2X0hZQlJJRF9Q
TVVfQ09SRV9JRFhdOw0KPiBAQCAtODY2MCw3ICs4NjY5LDkgQEAgX19pbml0IGludCBpbnRlbF9w
bXVfaW5pdCh2b2lkKQ0KPiDCoAkJcHJfY29udCgiTHVuYXJsYWtlIEh5YnJpZCBldmVudHMsICIp
Ow0KPiDCoAkJbmFtZSA9ICJsdW5hcmxha2VfaHlicmlkIjsNCj4gwqANCj4gLQkJaW50ZWxfcG11
X2luaXRfaHlicmlkKGh5YnJpZF9iaWdfc21hbGwpOw0KPiArCQlyZXQgPSBpbnRlbF9wbXVfaW5p
dF9oeWJyaWQoaHlicmlkX2JpZ19zbWFsbCk7DQo+ICsJCWlmIChyZXQgPCAwKQ0KPiArCQkJZ290
byBlcnI7DQo+IMKgDQo+IMKgCQkvKiBJbml0aWFsaXplIGJpZyBjb3JlIHNwZWNpZmljIFBlcmZN
b24NCj4gY2FwYWJpbGl0aWVzLiovDQo+IMKgCQlwbXUgPSAmeDg2X3BtdS5oeWJyaWRfcG11W1g4
Nl9IWUJSSURfUE1VX0NPUkVfSURYXTsNCj4gQEAgLTg2ODUsNyArODY5Niw5IEBAIF9faW5pdCBp
bnQgaW50ZWxfcG11X2luaXQodm9pZCkNCj4gwqAJCWJyZWFrOw0KPiDCoA0KPiDCoAljYXNlIElO
VEVMX0FSUk9XTEFLRV9IOg0KPiAtCQlpbnRlbF9wbXVfaW5pdF9oeWJyaWQoaHlicmlkX2JpZ19z
bWFsbF90aW55KTsNCj4gKwkJcmV0ID0gaW50ZWxfcG11X2luaXRfaHlicmlkKGh5YnJpZF9iaWdf
c21hbGxfdGlueSk7DQo+ICsJCWlmIChyZXQgPCAwKQ0KPiArCQkJZ290byBlcnI7DQo+IMKgDQo+
IMKgCQl4ODZfcG11LnBlYnNfbGF0ZW5jeV9kYXRhID0gYXJsX2hfbGF0ZW5jeV9kYXRhOw0KPiDC
oAkJeDg2X3BtdS5nZXRfZXZlbnRfY29uc3RyYWludHMgPQ0KPiBhcmxfaF9nZXRfZXZlbnRfY29u
c3RyYWludHM7DQo+IEBAIC04NzIwLDcgKzg3MzMsOSBAQCBfX2luaXQgaW50IGludGVsX3BtdV9p
bml0KHZvaWQpDQo+IMKgCWNhc2UgSU5URUxfTk9WQUxBS0VfTDoNCj4gwqAJCXByX2NvbnQoIk5v
dmFsYWtlIEh5YnJpZCBldmVudHMsICIpOw0KPiDCoAkJbmFtZSA9ICJub3ZhbGFrZV9oeWJyaWQi
Ow0KPiAtCQlpbnRlbF9wbXVfaW5pdF9oeWJyaWQoaHlicmlkX2JpZ19zbWFsbCk7DQo+ICsJCXJl
dCA9IGludGVsX3BtdV9pbml0X2h5YnJpZChoeWJyaWRfYmlnX3NtYWxsKTsNCj4gKwkJaWYgKHJl
dCA8IDApDQo+ICsJCQlnb3RvIGVycjsNCj4gwqANCj4gwqAJCXg4Nl9wbXUucGVic19sYXRlbmN5
X2RhdGEgPSBudmxfbGF0ZW5jeV9kYXRhOw0KPiDCoAkJeDg2X3BtdS5nZXRfZXZlbnRfY29uc3Ry
YWludHMgPQ0KPiBtdGxfZ2V0X2V2ZW50X2NvbnN0cmFpbnRzOw0KPiBAQCAtODg4NSw2ICs4OTAw
LDEwIEBAIF9faW5pdCBpbnQgaW50ZWxfcG11X2luaXQodm9pZCkNCj4gwqAJaW50ZWxfYXV4X291
dHB1dF9pbml0KCk7DQo+IMKgDQo+IMKgCXJldHVybiAwOw0KPiArDQo+ICtlcnI6DQo+ICsJa21l
bV9jYWNoZV9kZXN0cm95KHg4Nl9nZXRfcG11KHNtcF9wcm9jZXNzb3JfaWQoKSktDQo+ID50YXNr
X2N0eF9jYWNoZSk7DQo+ICsJcmV0dXJuIHJldDsNCj4gwqB9DQo+IMKgDQo+IMKgLyoNCg0K
