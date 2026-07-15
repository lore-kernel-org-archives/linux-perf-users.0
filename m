Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F216379EEF;
	Wed, 15 Jul 2026 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784125541; cv=fail; b=P/HSrEcsFkOfj5Imv3ZMeZpCTbWa64RNzFJljSD9fFM5mMZyUBOGeowwnxEk2AKvCt2juO/VlIpHWcgdfDKoycf6gi/bgtzlB71B0t71ili29IeULIbSZqEViYVc1ISNP0nGzf8/jk/DGSyouPmX9WttIkORpBIklssjk82/gKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784125541; c=relaxed/simple;
	bh=4mDVzsu9Vgm0ix2BEnK4dc0SjHlkXkvNv7c99o5pO6A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MlWGxFKmvNCo/weSefFXwE7AYM7VpMYGIKpkxiBubY8IPyTG755EkhOhVbX1C7kSWmPZPb7pXwpbmVkYyt0ZcYsmgXY82aVYi3fSjDbxF8sG1Jfv5vW2W2YU6PpPGqhrDqvFzobklQVL0nQGK/OziIIntDsel/gZGpFuyzeAx9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SC6qFMO7; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SC6qFMO7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784125537; x=1815661537;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4mDVzsu9Vgm0ix2BEnK4dc0SjHlkXkvNv7c99o5pO6A=;
  b=SC6qFMO7kR+kDK6+fGCdJmA83ABOy1WIszg7zjlLFOjpnU+r5iEEXWt6
   +K/6ybBEWPk1hfDjXtY92XqhQspFQQ2HibbsEOC7vkXFSklj1/9Wse5mB
   dI2KsfzJDGUW7MbVBUD96Sg1DOgR7BynnTXa63AGumbJVp7UwEManYdkl
   r7yQOanZu4zrERnleUqoZLfSH7TeSVms1oqsiBjBimxvr8XeTR1SwDD2Z
   ZVyYyu/71vfYepyZ5VaFqIV8wy3P5S+1k14dYHWf/Jr26Ms6xmALwfTau
   cseYF9MNZ03dhVVd+2odCp4ILe7RNuty9xFPAh0FT7bsDIGh3Yud2301I
   Q==;
X-CSE-ConnectionGUID: grh/+mAuT+adMZFulbj8mw==
X-CSE-MsgGUID: Z+E7sXjaQOyUOo2pOaL48A==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="107560778"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="107560778"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 07:25:36 -0700
X-CSE-ConnectionGUID: XfRuTD4STbW904ybQC9eug==
X-CSE-MsgGUID: D/XzPKR2THem1JZOoNcCzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="260010425"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 07:25:36 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 07:25:35 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 07:25:35 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.6) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 07:25:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHyg1JaJm2xFZbuvGwvk8535yl3ypTJYvUKfny6PrRg/5zJdyo7gcMr7R9vEtgeBqqiRNVe/3syy68Ynk9zlw8CasjO5Cez+2KOvToyEfUOtw1OsMTQzI+L5FccjrBenC3L+ffZRJWVIm+qXqqJXVBw00pg7+LhR/jtpHOrrKE4GuaBEkRaaZw2kzikHbaJB9QxjPGFAcCfcgxvsryLNmarYtYRxdFfiS/44HUDDT2Yiu0N+oCG+aDY8PcRZmo4lcsucZ5Tze6SXnHXFkJ85S9vib6WFHOt5Ii/17JsL+sH7d19VauzC1/OucMfpvNvSxLRkJxgPDzzGFaosiD5FSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mDVzsu9Vgm0ix2BEnK4dc0SjHlkXkvNv7c99o5pO6A=;
 b=b3Mw8juaSdSLd86UniQqWn29t59dPsc/SJge/MS3dnmKNDTi8t9WO3rc2f54EdgI3qmpa2GON3ejlgGPFq6/38cW24eiQZ4IddKt+z3rgMYCQkRTc/j6FWXyfaw60gm/QwYMR3oBreCiOVodfSC4oe6oOHSFQfM3wqYgUiGWAT986ei31XAOqlE2aTou5f38vSKG2dWSWl+TKjKxKB0v8055k8Ny2LpBsd3kmkgvFbN9CAW+9Qb47PNp8a9PIKGHZA4lhRGGRtEmQ8W7lnrTIvCNRdDE/OjM96jrOFyEFl1MO3J8cG66EfjaBd8A+Fd1fND3FF4XaDue5AaUPJOB/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by SN7PR11MB6923.namprd11.prod.outlook.com (2603:10b6:806:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 14:25:31 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%2]) with mapi id 15.21.0202.018; Wed, 15 Jul 2026
 14:25:31 +0000
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
Subject: Re: [Patch v2 6/7] perf/x86/intel: Fix intel_cap handling on hybrid
 PMUs
Thread-Topic: [Patch v2 6/7] perf/x86/intel: Fix intel_cap handling on hybrid
 PMUs
Thread-Index: AQHdEqJaEPD2gSjYxEiy57xFiqtcQLZupk2A
Date: Wed, 15 Jul 2026 14:25:31 +0000
Message-ID: <173f5864a2d5a9c0af6cf0f795571213b56ce9d0.camel@intel.com>
References: <20260713082734.3162099-1-dapeng1.mi@linux.intel.com>
	 <20260713082734.3162099-7-dapeng1.mi@linux.intel.com>
In-Reply-To: <20260713082734.3162099-7-dapeng1.mi@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|SN7PR11MB6923:EE_
x-ms-office365-filtering-correlation-id: 702ce8a6-3fc3-4cd5-c4a6-08dee27cecfa
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|10070799003|921020|10067099003|38070700021|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info: MP6WZg1zNXHVnBGWBVWgvzf3HVoIoBozGIdRTXJWoaX0ApI003iQ3d8rCi6LmBoWEmazRRekvOuvqF/NqtbcrD28Yju26HvZGEMdVJ8i3N6n67w/JSpwFw22lotvTO7zDVcCY2Q3PZflH0FIipGm5ertRRvzdLC/Xo30p/vkJOsLi2ziJKyIdrkffLmYnaqPhuzmsImoM434H5yllIG1UEFoCJLf2Apx2hZrgfAWlru90/2RrQkI8UXSC08XVqYpyG+FUtFIl0ByM+aiRmgCGsAhBsE3AvbKh8Jui8yauy5KjF2LgB7MCGWYfD36UBvWTTsL7FEvHf1Sg3eh+32b4I5H27VgQYg96lR/qDBDMYMYJMw7RZCs2JsRL9IurOTanFGTlHaPm8T9QFa+gKSWmfFazYo+jLHkPH35wB7Dybv3CtHvoH7qZ+aCj8Lcc+P0x5tt8o75L5fLFPUVkEsPisErTN8z6tGN0Bth89DDY9RjahoDD+nmwSGDUsesQ9zxWevXMSC4yzXgQHPSRKbODw9lFDmrX33HzDl+XGjGuF2DOtOxUFAgD67r0PB0rEZr+qFdAJyWW40/VG3JxS3eMummdrjBnhUHOyRkTaVVwlWdn+YCPtEnhtHsgv8NMKnyYgYQ6GFi5vlLc2DacRz/qRkBulh1RyCTpq7NU4V+gcB2VK/cEdACZvAZQ2ZcWMhvLe6nthvImoSoXau0dBqnQ/tdIcIWIZj3x9ak3B3AcpKmCcrLpb71C9TCWexqEICz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10070799003)(921020)(10067099003)(38070700021)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkVybjUyTnB6OS9OenlxQmZhSnRSbFZJMTFLb1FicHUwMGk1SEY0eFR3N3RO?=
 =?utf-8?B?Zm52Zk9NYTZiMFlxTy9UNWRFZzRkTHVCY0VFUHhDR0E4Y1BLNlBRU282a2Yz?=
 =?utf-8?B?YU96cU9GSUtyMXluUTV2aENuRFI1VkRMVGJVczV5ZFRFRFBhQjNzM0Jrek1h?=
 =?utf-8?B?Q1lsUUNyU3V2SEZLOUdmVlRvSFVKekdQU3lVNmc1ZE5UU3lLdEVXbmEwQUVZ?=
 =?utf-8?B?bmxEb2JHNFFVS3k1b0RNUURCRVZKTkxHVUJvWUdaY2JIWWYyWTZocjJXZ3ds?=
 =?utf-8?B?ZVIyKzdqMGlXYlF0cEhvOGdCMWpVdGUrWlp2TEFiRVFYYTVtZ3hiRDJqMUZR?=
 =?utf-8?B?VlEwRm93bXdOcFhQRzh3WGY1RU91aTFVUTBsVmdEa1p0M3RDSURZOHp3SVBC?=
 =?utf-8?B?VFZ0OHJOUE14QUYvb1MrdTYwajIyYVd4WVl1OVYxTnp5OTYwckQ5d3REUnFt?=
 =?utf-8?B?MkQ3MXRFbGxSc2RUeHQwQTRaSGZMZnc3UkovalBkaU42QmJacUpLZW1Fd2k2?=
 =?utf-8?B?eDBUbUI4MmhncmxDZzl5MkJ2bWZJTUtPd01WUjN1QzdPWjhRZjVrOWJnUUpi?=
 =?utf-8?B?eXlXYWpXV1VPRnIva2IvbVdRV1FmSlpuTkNCeGE4N1ZWQ0xZSWhVVUZsL1pK?=
 =?utf-8?B?ZFliYVVndFVuQUdxSHZ2RDQ0NUQ1d01NZGFmMnE4Zjk4OCt3MllFYXdIekhk?=
 =?utf-8?B?ZFZ3WFlpR1VsbW5qenhIb29hR1FJbEF6eUkxazJteWNia2Nacm5iU0dPcysy?=
 =?utf-8?B?WTdBY0d5bThtcUpKakVLZFhLZ3JnL0YyZjVDanFLWlVGMzNMcVdudGI4QWZo?=
 =?utf-8?B?MG9la0Y4ZTlIa3VXbFh5ZjhXQlduQTBCT2UreWtLUDg3c0VQVmZxVmZDT1dq?=
 =?utf-8?B?ZmF2NGlrQ25vZEx5b0FrOG90K2ViRVFNRFRMSFhucGJZRThTdmhvTExaTTBO?=
 =?utf-8?B?TVJUZURLakc0ZVNrdklRVFFOZ3dCcmE1MDVaMTBYUlhDZ20zQ1ltd3h0ZGEy?=
 =?utf-8?B?dWpoS0xSM3FGWEJ4RUJMOTBtT1h6KzhEOFRoS21OdCtjK21Nb21hakw0aU5j?=
 =?utf-8?B?WXIrZGdDU1N2Z0tRQzFSelllblUzWStwYVRseURKYXk5TjU5Q0RzNGlQbGts?=
 =?utf-8?B?SUdvdUkvdTdGY0ZPSW4rZWxBWUQ3OTl5VHc2T0IxRTR5UjZZTkpSRnljWXZP?=
 =?utf-8?B?WmlqMk1aNE9Lbzkwa2JKYWlkKzRMSXQ3cGtKVGhqdXY0K3hvYWZuQVVUNlVp?=
 =?utf-8?B?WERVSUJQSDJHRTJUQ2NmODAwd3B0RlNoUEs5cXBuUDdBYmp2ZUlyOW9BNlNq?=
 =?utf-8?B?NFZ2NDN3ZEFvSityVVUvS2loMXBDUnRiaHBOMnFqbUxLVnVvTTNZblg3T2xV?=
 =?utf-8?B?T05CQlhSVDgrNlY0V1JYRmF3dm1ESjhNaXNuWmxWcmZ0UFF0eFQ3MmlDamxM?=
 =?utf-8?B?bFZVbDlFU0FGZ2UxQmxxNUQ2UkhEaGNrWUx4MHNmejVHSUNQemVHQUM5WDFK?=
 =?utf-8?B?OENpb2MydDc4R0swOUVnMGNBa3lEcVZQZlVtaTJwK01TTm5kSE83MXMvV1Z6?=
 =?utf-8?B?NWIydktLczlicW00TG0zN21kcGtpWkZRelhvbGFVRWwvdXU0MHdHWmhxc2My?=
 =?utf-8?B?MnFBZTlSYkZaUnRrR0hVdlgzbnBZZDdwNEZHLysxblpHRVVGSnpaL3B4ZVFE?=
 =?utf-8?B?OXZCM1Q2VFQ1RllOeXJRWG5nUFVmYjM1d3JFOGszY3Q1eFVpTytERzRUQzlI?=
 =?utf-8?B?U1lxOTI4TGQ2TkhsMGl6SzVmRi9DZkNxTy9VeDlMd0hlQnJmR3dXVHR1NU1m?=
 =?utf-8?B?Q0N3bnZUUHhNdUdSMSt0K0JjMmU0ckNuUmlPSjNUdThxMU1XUm1PRlJTUkZ4?=
 =?utf-8?B?TWxnQUV2UmpzUVJ2dDBuekJDWG9zYm9aaklXOVFIbWhKYURWSy9keXZlbXUy?=
 =?utf-8?B?UjJONDNYV0FvQjQrWjFscHNYRjF3eTVlbXVvWHdBUlVuWW1tVEd1VUptR0ky?=
 =?utf-8?B?S2tmYUNqTkhreVpDOHIrQXFjK0dOcVNJUUxWWk4zdjRpZVFzNEs1cjFadytD?=
 =?utf-8?B?emlUWFBMSS92VzRtS0FBN3F6WHJ3T2xQVnh0aE1EZC82V0E4eEtnVC9KMjV3?=
 =?utf-8?B?SnMvMVVnd2Z1eFVuV2ZFdkdxa1FiWUtuOXdqK3hEQzR2N0orbk5YaEFkV0kz?=
 =?utf-8?B?ZGxyQk9RTW5kbnVaeWxXWG1YU1BpT0ppME9FazI0ZFhTSEs2eHNzVWVOWHZZ?=
 =?utf-8?B?Q2RCZGhuaXB0VThrMFI3bFdTM3ZSUzlZSCt2a2dXWHF4NmlaWnFBSy91aFQr?=
 =?utf-8?B?WExvUHhiTktFRHJNRER3ZGYvaENTNUZ1aWl0Z3lJTmJLZUFocHFQUU5UMml3?=
 =?utf-8?Q?NAerKfGViGOoVmZw86I74d4Mjm/1jIMaTLVGS/Hz2bC1C?=
x-ms-exchange-antispam-messagedata-1: 2roTxuPwc2qi4yGw6zIP1Ze1CofxOQV+1e0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8153FF9FB69BBC45A53CF84AFB934826@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gMD2JgqFkd+ao5MjC3HvP0ntweyL9ebOSHqzCb6/9GixXeMsndC7WcA2Y59fc2SJZkUgtx0uIMlPAij9+lThydQp8QTxGfuuULhJ3or+9mETsO9RngO16cOi2uZ2+ydhdAFC5QMT5vz0CbQu9hpsNqXvn9eaKdD4yrknZwicJ/MIwNVgqC0l+xQKS69DgyIAHcnDiAaUMirQGUbr7VPT9sD/T9gd28L5GlqAv01cdwHb7p2/upsTlVFpwZXJs2WV/1UVCmW7veNszpZ3hrIa50fwH1aPlMAjYQKKO+rtRey8kdiL83NS0rmHa8PFXYi9noaozR88XAL+QNYw3GYhfg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 702ce8a6-3fc3-4cd5-c4a6-08dee27cecfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 14:25:31.2462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6NiJ5jJOTiQUolrOojWZkJaq3Gl6YghZu1dvs+wC9PuxDtDY2whm5AjZSEOve9eiCKSAqKtTSKtmpvRWTbhrWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6923
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA3LTEzIGF0IDE2OjI3ICswODAwLCBEYXBlbmcgTWkgd3JvdGU6DQo+IGlu
dGVsX2NhcCAoSUEzMl9QRVJGX0NBUEFCSUxJVElFUykgdXBkYXRlcyBhcmUgY3VycmVudGx5IHRp
ZWQgdG8NCj4gWDg2X0ZFQVRVUkVfQVJDSF9QRVJGTU9OX0VYVCwgYnV0IHRoZXNlIGFyZSBpbmRl
cGVuZGVudCBmZWF0dXJlDQo+IHBhdGhzLg0KPiBBcyBhIHJlc3VsdCwgaHlicmlkIFBNVSBjYXBh
YmlsaXR5IHN0YXRlIGNhbiBiZSB1cGRhdGVkIHVuZGVyIHRoZQ0KPiB3cm9uZw0KPiBjb25kaXRp
b24uDQo+IA0KPiBBbHNvLCBpbnRlbF9wbXVfYnJva2VuX3BlcmZfY2FwKCkgaXMgdG9vIG5hcnJv
dy4gUGVyIFJQTDAxOCwgdGhlDQo+IG1pc3NpbmcNCj4gUEVSRl9NRVRSSUNTX0FWQUlMQUJMRSBi
aXQgYWZmZWN0cyBib3RoIFJhcHRvciBMYWtlIGFuZCBNZXRlb3IgTGFrZQ0KPiBwYXJ0cywgbm90
IG9ubHkgdGhlIGN1cnJlbnRseSBjb3ZlcmVkIHN1YnNldC4NCj4gDQo+IE1vdmUgaW50ZWxfY2Fw
IHVwZGF0ZXMgb3V0IG9mIHRoZSBBUkNIX1BFUkZNT05fRVhULWdhdGVkIHBhdGgsIGV4dGVuZA0K
PiBpbnRlbF9wbXVfYnJva2VuX3BlcmZfY2FwKCkgY292ZXJhZ2UgdG8gYm90aCBSUEwgYW5kIE1U
TCBmYW1pbGllcywNCj4gYW5kDQo+IGludHJvZHVjZSBpbnRlbF91cGRhdGVfcG11X2NhcHMoKSB0
byBjZW50cmFsaXplIFBNVSBjYXBhYmlsaXR5DQo+IHVwZGF0ZXMuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBEYXBlbmcgTWkgPGRhcGVuZzEubWlAbGludXguaW50ZWwuY29tPg0KPiAtLS0NCj4gwqBh
cmNoL3g4Ni9ldmVudHMvaW50ZWwvY29yZS5jIHwgNDEgKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLQ0KPiAtLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCAx
MSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9ldmVudHMvaW50ZWwv
Y29yZS5jDQo+IGIvYXJjaC94ODYvZXZlbnRzL2ludGVsL2NvcmUuYw0KPiBpbmRleCBjNDE4MTc2
MDY1ZjYuLmJlYzkyMTYzYTA5ZiAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvZXZlbnRzL2ludGVs
L2NvcmUuYw0KPiArKysgYi9hcmNoL3g4Ni9ldmVudHMvaW50ZWwvY29yZS5jDQo+IEBAIC02MTQ3
LDggKzYxNDcsMTUgQEAgc3RhdGljIHZvaWQgaW50ZWxfcG11X2NoZWNrX2V4dHJhX3JlZ3Moc3Ry
dWN0DQo+IGV4dHJhX3JlZyAqZXh0cmFfcmVncyk7DQo+IMKgDQo+IMKgc3RhdGljIGlubGluZSBi
b29sIGludGVsX3BtdV9icm9rZW5fcGVyZl9jYXAodm9pZCkNCj4gwqB7DQo+IC0JLyogVGhlIFBl
cmYgTWV0cmljIChCaXQgMTUpIGlzIGFsd2F5cyBjbGVhcmVkICovDQo+IC0JaWYgKGJvb3RfY3B1
X2RhdGEueDg2X3ZmbSA9PSBJTlRFTF9NRVRFT1JMQUtFIHx8DQo+ICsJLyoNCj4gKwkgKiBUaGUg
UGVyZiBNZXRyaWMgKEJpdCAxNSkgaXMgYWx3YXlzIGNsZWFyZWQgb24gUC1jb3JlIG9mDQo+ICsJ
ICogUFJMIGFuZCBNVEwuIERldGFpbHMgY2FuIGJlIGZvdW5kIGluIFJQTDAxOCBFcnJhdGENCj4g
RGV0YWlscy4NCg0KVHlwbyBoZXJlLiBTaG91bGQgYmUgUlBMLg0KDQpUaGFua3MsDQpUb20NCg0K
PiArCSAqDQo+IGh0dHBzOi8vZWRjLmludGVsLmNvbS9jb250ZW50L3d3dy91cy9lbi9kZXNpZ24v
cHJvZHVjdHMvcGxhdGZvcm1zL2RldGFpbHMvcmFwdG9yLWxha2Utcy8xM3RoLWdlbmVyYXRpb24t
Y29yZS1wcm9jZXNzb3Itc3BlY2lmaWNhdGlvbi11cGRhdGUvZXJyYXRhLWRldGFpbHMvDQo+ICsJ
ICovDQo+ICsJaWYgKGJvb3RfY3B1X2RhdGEueDg2X3ZmbSA9PSBJTlRFTF9SQVBUT1JMQUtFIHx8
DQo+ICsJwqDCoMKgIGJvb3RfY3B1X2RhdGEueDg2X3ZmbSA9PSBJTlRFTF9SQVBUT1JMQUtFX1Ag
fHwNCj4gKwnCoMKgwqAgYm9vdF9jcHVfZGF0YS54ODZfdmZtID09IElOVEVMX1JBUFRPUkxBS0Vf
UyB8fA0KPiArCcKgwqDCoCBib290X2NwdV9kYXRhLng4Nl92Zm0gPT0gSU5URUxfTUVURU9STEFL
RSB8fA0KPiDCoAnCoMKgwqAgYm9vdF9jcHVfZGF0YS54ODZfdmZtID09IElOVEVMX01FVEVPUkxB
S0VfTCkNCj4gwqAJCXJldHVybiB0cnVlOw0KPiDCoA0KPiBAQCAtNjE4Myw3ICs2MTkwLDcgQEAg
c3RhdGljIGlubGluZSB2b2lkDQo+IF9faW50ZWxfdXBkYXRlX2xhcmdlX3BlYnNfZmxhZ3Moc3Ry
dWN0IHBtdSAqcG11KQ0KPiDCoA0KPiDCoCNkZWZpbmUgY291bnRlcl9tYXNrKF9ncCwgX2ZpeGVk
KSAoKF9ncCkgfCAoKHU2NCkoX2ZpeGVkKSA8PA0KPiBJTlRFTF9QTUNfSURYX0ZJWEVEKSkNCj4g
wqANCj4gLXN0YXRpYyB2b2lkIHVwZGF0ZV9wbXVfY2FwKHN0cnVjdCBwbXUgKnBtdSkNCj4gK3N0
YXRpYyB2b2lkIHVwZGF0ZV9wbXVfY2FwX2Zyb21fcGVyZm1vbmV4dChzdHJ1Y3QgcG11ICpwbXUp
DQo+IMKgew0KPiDCoAl1bnNpZ25lZCBpbnQgZWF4LCBlYngsIGVjeCwgZWR4Ow0KPiDCoAl1bmlv
biBjcHVpZDM1X2VheCBlYXhfMDsNCj4gQEAgLTYyNDEsMTAgKzYyNDgsMjQgQEAgc3RhdGljIHZv
aWQgdXBkYXRlX3BtdV9jYXAoc3RydWN0IHBtdSAqcG11KQ0KPiDCoAkJV0FSTl9PTih4ODZfcG11
LmFyY2hfcGVicyA9PSAxKTsNCj4gwqAJCXg4Nl9wbXUuYXJjaF9wZWJzID0gMDsNCj4gwqAJfQ0K
PiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBpbnRlbF91cGRhdGVfcG11X2NhcHMoc3RydWN0IHBt
dSAqcG11KQ0KPiArew0KPiArCWlmICh0aGlzX2NwdV9oYXMoWDg2X0ZFQVRVUkVfQVJDSF9QRVJG
TU9OX0VYVCkpDQo+ICsJCXVwZGF0ZV9wbXVfY2FwX2Zyb21fcGVyZm1vbmV4dChwbXUpOw0KPiDC
oA0KPiAtCWlmICghaW50ZWxfcG11X2Jyb2tlbl9wZXJmX2NhcCgpKSB7DQo+IC0JCS8qIFBlcmYg
TWV0cmljIChCaXQgMTUpIGFuZCBQRUJTIHZpYSBQVCAoQml0IDE2KSBhcmUNCj4gaHlicmlkIGVu
dW1lcmF0aW9uICovDQo+IC0JCXJkbXNycShNU1JfSUEzMl9QRVJGX0NBUEFCSUxJVElFUywgaHli
cmlkKHBtdSwNCj4gaW50ZWxfY2FwKS5jYXBhYmlsaXRpZXMpOw0KPiArCWlmIChpc19oeWJyaWQo
KSAmJiB0aGlzX2NwdV9oYXMoWDg2X0ZFQVRVUkVfUERDTSkpIHsNCj4gKwkJcmRtc3JxKE1TUl9J
QTMyX1BFUkZfQ0FQQUJJTElUSUVTLA0KPiArCQnCoMKgwqDCoMKgwqAgaHlicmlkKHBtdSwgaW50
ZWxfY2FwKS5jYXBhYmlsaXRpZXMpOw0KPiArDQo+ICsJCS8qDQo+ICsJCSAqIFJlc3RvcmUgcGVy
Zl9tZXRyaWNzIG9uIHBsYXRmb3JtcyB3aXRoIGJyb2tlbg0KPiArCQkgKiBwZXJmX2NhcGFibGl0
aWVzLg0KPiArCQkgKi8NCj4gKwkJaWYgKGludGVsX3BtdV9icm9rZW5fcGVyZl9jYXAoKSAmJg0K
PiArCQnCoMKgwqAgaHlicmlkX3BtdShwbXUpLT5wbXVfdHlwZSA9PSBoeWJyaWRfYmlnKQ0KPiAr
CQkJaHlicmlkKHBtdSwgaW50ZWxfY2FwKS5wZXJmX21ldHJpY3MgPSAxOw0KPiDCoAl9DQo+IMKg
fQ0KPiDCoA0KPiBAQCAtNjMyOSw5ICs2MzUwLDcgQEAgc3RhdGljIGJvb2wgaW5pdF9oeWJyaWRf
cG11KGludCBjcHUpDQo+IMKgCWlmICghY3B1bWFza19lbXB0eSgmcG11LT5zdXBwb3J0ZWRfY3B1
cykpDQo+IMKgCQlnb3RvIGVuZDsNCj4gwqANCj4gLQlpZiAodGhpc19jcHVfaGFzKFg4Nl9GRUFU
VVJFX0FSQ0hfUEVSRk1PTl9FWFQpKQ0KPiAtCQl1cGRhdGVfcG11X2NhcCgmcG11LT5wbXUpOw0K
PiAtDQo+ICsJaW50ZWxfdXBkYXRlX3BtdV9jYXBzKCZwbXUtPnBtdSk7DQo+IMKgCWludGVsX3Bt
dV9jaGVja19oeWJyaWRfcG11cyhwbXUpOw0KPiDCoA0KPiDCoAlpZiAoIWNoZWNrX2h3X2V4aXN0
cyhwbXUtPmNudHJfbWFzaywgcG11LT5maXhlZF9jbnRyX21hc2spKQ0KPiB7DQo+IEBAIC04ODI4
LDggKzg4NDcsOCBAQCBfX2luaXQgaW50IGludGVsX3BtdV9pbml0KHZvaWQpDQo+IMKgCSAqIGZy
b20gdGhlIGxlYWYgMHhhLiBUaGUgY29yZSBzcGVjaWZpYyB1cGRhdGUgd2lsbCBiZSBkb25lDQo+
IGxhdGVyDQo+IMKgCSAqIHdoZW4gYSBuZXcgdHlwZSBpcyBvbmxpbmUuDQo+IMKgCSAqLw0KPiAt
CWlmICghaXNfaHlicmlkKCkgJiYNCj4gYm9vdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX0FSQ0hfUEVS
Rk1PTl9FWFQpKQ0KPiAtCQl1cGRhdGVfcG11X2NhcChOVUxMKTsNCj4gKwlpZiAoIWlzX2h5YnJp
ZCgpKQ0KPiArCQlpbnRlbF91cGRhdGVfcG11X2NhcHMoTlVMTCk7DQo+IMKgDQo+IMKgCWlmICh4
ODZfcG11LmFyY2hfcGVicykgew0KPiDCoAkJc3RhdGljX2NhbGxfdXBkYXRlKGludGVsX3BtdV9k
aXNhYmxlX2V2ZW50X2V4dCwNCg0K
