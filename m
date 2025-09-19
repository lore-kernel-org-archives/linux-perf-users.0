Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE0F31A80D;
	Fri, 19 Sep 2025 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758295871; cv=fail; b=Xfd6OyhKgfQ9CDF7A08LxR2knxQMf1V9b8wRc2kpEcO7Bi50RN9tbteF1GC2TYBEfvZkMrHuqiSVUUmpPMwIxDqjOaw+BzzEN1AcgTcV10ky5hbmy6GrP26QcFGJyzOwpX1r8R9k6wMfsJaGdRNRnGadTNzYxFBPZtrnVPsASrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758295871; c=relaxed/simple;
	bh=5xFm0SxALFFEMV7+19imb3rLkykLJviKnxjN7Z39JzE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tb+pkY8pMH8jL+aFISHS8+arMm/xKcoeGyIQjf78ER4elamQ9Wx0iWC8jJ3Eci5QeWeUWZoYWdMVwYd7z1htZ0c+Rbfw/JbRS8zXR1Vv0anBwDEouxPC6ZEQWplvkSrUlTQVcMpOgJ/RIClCTDMOSTJOF+Usn4H7Ccs/B8//fa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qf7cNKcM; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qf7cNKcM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758295868; x=1789831868;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=5xFm0SxALFFEMV7+19imb3rLkykLJviKnxjN7Z39JzE=;
  b=Qf7cNKcMo878L0c1WnVQFoy/vwBxKmLiucV3YmBYlE7nYRlUmzyREL5U
   F3GtTnTaY85mlW53pMJ+gQq3gSaX/VlkASwWD8vUYxQ2NeGj+7B47C0lN
   CP59vluwUMNtAnTadANM0Jbd798qHhbzzE+kN83RP+u5yooYBuuU1oywB
   vwqY0t6wD8668BZ1AJAaFc9wi4LAXvaLpIAaFczDxoRG1cXyJj/Np+cW7
   nRn0juzpcurmEKWDSouCgoDYS1QwEs5B1x2H4Jw7sHq71yeek1GHLvoPg
   Uy2mt0CpwLSKR1tFKu3YJTPTQgSOHG1qR8wcLrV4Yu2MgCKMlZeDqljSH
   A==;
X-CSE-ConnectionGUID: VmNCgPNyQUWNTKTcPhTfUw==
X-CSE-MsgGUID: kkLfi2EbTY+ehfhhlHMU+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="63276369"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="63276369"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 08:31:07 -0700
X-CSE-ConnectionGUID: z8IFEI1CQoOL3zQSNmnX1Q==
X-CSE-MsgGUID: Fbu4bCLwT6ywZBSoOdkAjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="213016130"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 08:31:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 08:31:05 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 19 Sep 2025 08:31:05 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.13) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 08:31:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkxKSp0YKw+KTzC4uPnWC1O15bot0e2nojZC61aQjKJ0sWMHojeSQCO0XzrZONsHihLdNBXuH8Yt17njhMUSRbh/I8fB0996JP/q/GggsTCFrlddwtF0CMtjHMfNJuJnxjFew8EYmkxC3eSYrsdF1vLuyplwvMQw/Pu8daxZ2DgnNvmTs4x90dUAtTp1FqvPcd0vriuPYRuy5zKlTpjN1J2g6Ws31FRvtY7p9zBSoAKMqCbkm1zn8SKsRWkLmB+WGRQ8AQrqdXBoQUXr007MC/nea0krmKD+vMxsBFT+6OnFU5B/mX4AwGrbZ18BIqAmxnx5ai4Pi7ZvqC3T2W4L+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xFm0SxALFFEMV7+19imb3rLkykLJviKnxjN7Z39JzE=;
 b=R45icxZZFJW7KtcnvcCxH6WqnPRI5AK9KX9pRXyVfb8Bl9/UQjVGAqYTjH/c1r6dgb4FOfvivpjSFCY0nDHNd6K5cBpTfH9UFS+fzngyF2YqgMU/HvJLA9iXG+jvwWlrmbI3jYnrtedzuHBw9MumkIOSfVjjcHxRPfsaH09ogDiZh4QXoGvBzyrT+16zm1elOplzEv3EPQjWvaAJihEBVzVlIHH8UL4SRPiotzvRGO6Okhi5rD896BGZ3KsKwPU+VnmG88NnOltqoxe1Jvp33iA66jsCks/sfLvXZlO40SBgQhOnqdHg26q+4j2elUmo6K2K0lkCDsdqYw36M0R5EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by MW4PR11MB7162.namprd11.prod.outlook.com (2603:10b6:303:212::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Fri, 19 Sep
 2025 15:31:01 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%3]) with mapi id 15.20.9115.017; Fri, 19 Sep 2025
 15:31:01 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "Baker, Edward" <edward.baker@intel.com>, "Wang, Weilin"
	<weilin.wang@intel.com>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "xu.yang_2@nxp.com"
	<xu.yang_2@nxp.com>, "Biggers, Caleb" <caleb.biggers@intel.com>, "Hunter,
 Adrian" <adrian.hunter@intel.com>, "Taylor, Perry" <perry.taylor@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "irogers@google.com"
	<irogers@google.com>, "sandipan.das@amd.com" <sandipan.das@amd.com>,
	"james.clark@linaro.org" <james.clark@linaro.org>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "john.g.garry@oracle.com" <john.g.garry@oracle.com>,
	"bgray@linux.ibm.com" <bgray@linux.ibm.com>, "Alt, Samantha"
	<samantha.alt@intel.com>, "renyu.zj@linux.alibaba.com"
	<renyu.zj@linux.alibaba.com>, "acme@kernel.org" <acme@kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "namhyung@kernel.org"
	<namhyung@kernel.org>
Subject: Re: [PATCH v6 00/22] Python generated Intel metrics
Thread-Topic: [PATCH v6 00/22] Python generated Intel metrics
Thread-Index: AQHcHVb4cbfxZ1yFikqpW3oGGUkQTrSauh8A
Date: Fri, 19 Sep 2025 15:31:01 +0000
Message-ID: <8630f8dd4ff3ef050b3517b86ffa9fcae695e675.camel@intel.com>
References: <20250904044653.1002362-1-irogers@google.com>
In-Reply-To: <20250904044653.1002362-1-irogers@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|MW4PR11MB7162:EE_
x-ms-office365-filtering-correlation-id: c685ead6-0a53-4e70-e7f5-08ddf7918a35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|38070700021|921020;
x-microsoft-antispam-message-info: =?utf-8?B?SnBKUmc4UTlhTkNqM2c3UHRGOUxMRWxYd0Z6OUluNmNWVFRZT2RWKzM1enh3?=
 =?utf-8?B?OGw1NndKUlpoYkoyTTJYc3c3ZlVBTXE0V2psL1FYZ3JsUGNreGd2OFAvdUs5?=
 =?utf-8?B?cWtWQ2grRkJNTlhsZDh3Mld6bnF5MlFZeVNQbUtqc2JmZXp0RGxFRnpURlJJ?=
 =?utf-8?B?T2RiSld6WklTNzhTYk1GdzFLTXRjRG1YRXEwQXorWnBmVTRjN0NCaDhmOS9V?=
 =?utf-8?B?Mkk5OHg1S0RINWp1Z2IzN2tnVUh5RGZJZmJGL1lFWkhtNlpVMDJaRk1ad0RX?=
 =?utf-8?B?eFk2Tks4dlUvZGUyQmNDZ3dFeVJjajJoejdOWklQOVJCM3M5ZFl5ZjgvU3Ex?=
 =?utf-8?B?T2xkL3Y1ZzFodTd1QW1ZWDVEek5TRHA0RHp0c2xsUklRK2RHTG1xWlhPSXZw?=
 =?utf-8?B?SWZTT1RGN0RHcml3bnRLTGhrSzcxeHZzTHVMclY0NFVldmFCb2doWHowaW5r?=
 =?utf-8?B?OHFCeW9DbFViaHNVQU0rc0p5NXN0SG1EcEJ0VENSdUtVMmY2WGJYWncwb3ZX?=
 =?utf-8?B?ZkEzOUpZa2NCZWtHZUlmSS8wMVI0eUV0L29naXVIVnU5b3EwQnkzKzF5SlAz?=
 =?utf-8?B?OUFLcVB1RURZT0YwSmxvUHlGcHY5RUkzVUdzVURXRjlwVXJqZ0hpQUYwVWov?=
 =?utf-8?B?Tk5VQ1ZTVE40TDZVWk5Id0g2cXdmUEdpbEJhS21ZbVdrbXNHUnVBQ3pqWFlz?=
 =?utf-8?B?Wmd5TGtpT1UzcDNPQlI3WVNEOVlINFRZcG5tWU5zanFIb29hdWJWOVVGcGtv?=
 =?utf-8?B?M3M3ZkxsV25KR05maGplNFB2QU5tSHNzaFJzQ2hYZjRUaDZlWWVxNWJIOU5L?=
 =?utf-8?B?WllucFBUNU1Zb005b1Q1MGhDMWFiMWUwQ1dwK1B3Tk5nT0plK3oxRSt4UDZ5?=
 =?utf-8?B?Zk1WYmlGcTFaNVRRckJWQXd2UTg0QldJS2o2VnNCQTNwR2JyTWZmYWJiWWZj?=
 =?utf-8?B?bHhkT2FDdlNTdGQvV1U2Zm1ZcmdHUUliYUl2c1Bua0dhc0RES2VsdXZadE1W?=
 =?utf-8?B?U0RnSDZ1TitIM0thYlJHRklCV3JHOGlzTnFTa08zWTZ3dE43ZEtXWmR1S25J?=
 =?utf-8?B?OUZSbnZCWUdyeENoK3lYaUhCeFpNb3lMVy9GenQ3Y1p1Y0VpQmdpenUyTWlB?=
 =?utf-8?B?cysvSU9ReUMvdlk5WmdjVVNJUlVnUjlnOVlReWtqRDBVUUlPMDBGaWFuRTVv?=
 =?utf-8?B?SmtKUkZ2UEhiRDRnZ2NlNHFHSnlwbUkxdzFiTmtIVnQ1MkZtamVEYTNBMllN?=
 =?utf-8?B?bnZhaTFHN3hqZW9zK0pIc01aNlA0ZGRyR1dTbUdWM3E0b2FuZ3ZOQWZ0SVdH?=
 =?utf-8?B?RWlRdWg5WGowbzlhSzlFckp2eGdKdUhpLzhDczFBZUN5VTJJS0gwTUYvQ21k?=
 =?utf-8?B?NlNTSlRyOWlKM2ZhenJkQmNKcHU3NlpQS25SbnhEd0hKcVFKVkREdzljeHZv?=
 =?utf-8?B?ZG96RlFiU0ZHYjlGbE1iRkJDQ0xXWmpZTlBXUXlqZGpucTJmZ2JsenNtNkhF?=
 =?utf-8?B?V0hjS2xLOUdZckhITHZUaWMrSjdBbUUwcmlkL0FpRlJNQkg1ZHVURGxTMzBi?=
 =?utf-8?B?RnVOU3hVRFNqeEw5YlhqVWpGZTJlNDR4cDN1akJTT0NlbU45V3dwNkRtek9I?=
 =?utf-8?B?Y1NqQWxrRy9UbDFXbHZ2RmNHU0JtUEtCb2RVMm1LdzdrYllocHM1N0V5VnY5?=
 =?utf-8?B?ME52QTUwNTFUbFV5ZHBQR3V2ZkVYUGdyWnJnYmpBVm1aQzY3U3ZiNGF1TmUz?=
 =?utf-8?B?V3dMWTAzYzdMU0p1M0tTL2JaaytCK2ozVHQ5YjM4VHJCc0FldVFMZFVFVWpE?=
 =?utf-8?B?SjBhQmo1Qm42RGNBK3Z6N2VzdGNrSjdNUG1idWtkYS9ZRm9FalRJdVZJcGlW?=
 =?utf-8?B?OG12VW5iaEk5SGVkak84YlhQTUttL3A4MFNvZS9RRXp6UGUvSG5DOTlWbTZx?=
 =?utf-8?B?WWY3dnBydjVsaE9WVTV0eEMyUHdrZjkyajVoZCtXRjVoYjd1d3FmRzVnT3o3?=
 =?utf-8?B?aHNEVU9UYTF3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGFBbjc1YXpESVVxSmpNL0QzZDBzMGNlMlo4elAxMGpHeVd1SEVNWUV6TFRl?=
 =?utf-8?B?Z0hibW1NWDJLQWFWR2ZNUDFKb2MrbXBGTEpLbDJENVZLTGZ3MTNyK3hXTjNa?=
 =?utf-8?B?bjBROXBEdC9MZTVsVjNDR2I1b29JV2ZINWVqYjh6N3VLMmt5YW9tTjlkSk1H?=
 =?utf-8?B?UUlIVXE2MUNBQ1NwbG9IdjdIUmpvQWtweXJoeWwvWnFrc1UxcWQzS29qaVhP?=
 =?utf-8?B?ZGJNUTNKaGtoMUFjci9xWHZtdVVWTWp3cnUxOUFHNm8zRnlUWlhCRmpSMWZl?=
 =?utf-8?B?V09PcTFGMjJVZ2l3YzJhU0puQ3c1Z0FBZ1JjbWJUZm0zSVdzTjJrRmJVQm04?=
 =?utf-8?B?SllFNGF5WG9WaXpSQ2FuZVlmSDcvT3pYRlE2V21tMEtXYzFGdWJUZ0RteDVQ?=
 =?utf-8?B?VEtENUg0eGpMbHBlaXEzdThHcWJ0SVg1TVVGWHlVNXNnTDRqcG5ZNUV3OXh3?=
 =?utf-8?B?NlE2blZtckdFcHBvVVVTRDM2RTAwVENiM0pDNnZUa1pobkN0ejFLSGpSNWF5?=
 =?utf-8?B?VlZqN0loUXgyaVpWaVBLNS9LdDZhcU0xa0FNVDc5dmE2cXNyL1MxU2swSzJy?=
 =?utf-8?B?YUVDMXF3NStFYmQ3S2orRG5zT05lRHhKTERMYkRXMEVVTU5yWUpWSjBhd080?=
 =?utf-8?B?UzJMakhUUkNQK3lJS200dEtPaUhpZTZSMU81ME8rMzlJeU5TbllNU0hmZG14?=
 =?utf-8?B?VTM3UzVtS1lOZ0NuTnhKNEtjeFY3YXhPRWFjTE9sTWYrbTdtQ1F0OG83STZu?=
 =?utf-8?B?cXRUdGtZQTVreGhuVDZrejdIanI4dzB2WHdIQUx2UTVudzRiL1JNVzlWRE5V?=
 =?utf-8?B?Y2FMMFl3RGpQb3czU1BFV0F2RGlHcHF2b1dIUE9OYURDWkxsbCsxSFVHVnNB?=
 =?utf-8?B?V2FSZ1hEQ2dYbkNaaEU0WE1lTkgxOS9KUlpoK0ZYbHZsVTNNa2Z2NEtoeEdt?=
 =?utf-8?B?YTlWbTVLV0pVV1U0REZRa2ljWm1LbHMvQmUvWnpPMWpXeXNuQlZsTTg0OTR3?=
 =?utf-8?B?amV1c3oxUEdXakNDcUtzdWRTRHJyRlFoVCtNSktkTW01U0o5azRRYXhsWVBk?=
 =?utf-8?B?ZWZnbTB0aTRBNUVtYWh6SnJYV1dRT2xQcWpRYlNqYTFkWHAwaFN5cVJjVnpL?=
 =?utf-8?B?L0dZUzFycVNlVjRFQUtNOWRRUmtjTm9sQmFrYkwwemR0RjJCMkFDVmRXWEZX?=
 =?utf-8?B?eXhhSWlOMHlVeFVuclVLdFBHSk1WUGFkNFFqZHhrMlIxWGZaZ09HOFpHTm5Y?=
 =?utf-8?B?OXpQdllRMTZ3Q3VxbzRGNWs4WXkzTklxbU5FaDdDaXhmTEpFTG9zaWJwZVNh?=
 =?utf-8?B?RkZNYUpaZ2RYVnlQZ3NVUTBBTlhDaUVEVS93a21icnE0Y1FoWkhSczM5a05j?=
 =?utf-8?B?WDZNZFdJc3hSSUZCSS9VaS9iTFZKbmtJbVV6WU9lTlFHYjlIZWR4TXdMNkN3?=
 =?utf-8?B?VzQ1azZHMFhJTEVtWVJtVExSSTkzbTVFZ1lwMEk5cEVaQXRWTm5xcnZXWTdn?=
 =?utf-8?B?bThIT2ROeTF1UUxoQ0FGRm14clFvaUczNmd0NjZTdFk1dlBQd0JNdFNBQTRD?=
 =?utf-8?B?dHlRUjdDd0Q0VWR5NlVWV3hSOVQ1eG9SZHpNMzltRW9vQUhQMnk1ZFEwYXdh?=
 =?utf-8?B?QnBpMUl3N1I3d1JlMXRNMGE0eTBDT1hVRGF4MFR1cTRSUXN4K2liS1d4bWc1?=
 =?utf-8?B?Z2lwYllhNHhCbm5aT043OHBnNXk0R2VoZ3g2bDBjSytENEQzRXlKZWlFS1FX?=
 =?utf-8?B?eWhLZHVyVzBvc3RJL0pSSGRsby9CTEtVekFwS1FFb2dpSmJ3bHVUSHlrVGE5?=
 =?utf-8?B?WW1nZDZzSlg3b0ZOdlZoOExTSjNWS2xjMnJZbHVtT0ZTVXdzZUg5d0tqZmNO?=
 =?utf-8?B?TzlVNXU0ZHlGK0N0RFE0bHpXRzlwV1RlKy9xa2tvdk5UYitqQTZpRW9LMWhj?=
 =?utf-8?B?UzFXY0RkMlhIdEUzajJCS2hkQ2JsMzVPeXNpUTFMaHVzckFrblNqVWN4UTJv?=
 =?utf-8?B?OTVaanQ4cVRFS2hRMGtBcjZKSmpGMXdQQzhjbkd5MnFNZFA5TnZzL2JvL0FQ?=
 =?utf-8?B?QTlYUWNpWldsVUNoWCtncUR2T3BPN0p0N3dsaHo0bXUzc1dlY1J6WWExVjhj?=
 =?utf-8?B?dE5WOXFTLzl0bWV5NzVPSEowd05TT0JlUFIyb29kOTlwVDRheTcvMUxTNlY5?=
 =?utf-8?Q?5dZ0SXkJMq1rfryKSn7I5Xk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3467ECAE7DA93A439616849D08DF8E27@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c685ead6-0a53-4e70-e7f5-08ddf7918a35
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 15:31:01.7273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ZzZgCg9PgYUM6TavxPJB5OqylZSoroWBBNqgnMQRQLeKU1hdRLeDbK7eP0Kc1Ae8a7k7rDHNUI5JkHrklWzjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7162
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTA5LTAzIGF0IDIxOjQ2IC0wNzAwLCBJYW4gUm9nZXJzIHdyb3RlOg0KPiBH
ZW5lcmF0ZSB0d2VudHkgc2V0cyBvZiBhZGRpdGlvbmFsIG1ldHJpY3MgZm9yIEludGVsLiBSYXBs
IGFuZCBJZGxlDQo+IG1ldHJpY3MgYXJlbid0IHNwZWNpZmljIHRvIEludGVsIGJ1dCBhcmUgcGxh
Y2VkIGhlcmUgZm9yIGVhc2UgYW5kDQo+IGNvbnZlbmllbmNlLiBTbWkgYW5kIHRzeCBtZXRyaWNz
IGFyZSBhZGRlZCBzbyB0aGV5IGNhbiBiZSBkcm9wcGVkIGZyb20NCj4gdGhlIHBlciBtb2RlbCBq
c29uIGZpbGVzLiBUaGVyZSBhcmUgZm91ciB1bmNvcmUgc2V0cyBvZiBtZXRyaWNzIGFuZA0KPiBl
bGV2ZW4gY29yZSBtZXRyaWNzLiBBZGQgYSBDaGVja1BtdSBmdW5jdGlvbiB0byBtZXRyaWMgdG8g
c2ltcGxpZnkNCj4gZGV0ZWN0aW5nIHRoZSBwcmVzZW5jZSBvZiBoeWJyaWQgUE1VcyBpbiBldmVu
dHMuIE1ldHJpY3Mgd2l0aA0KPiBleHBlcmltZW50YWwgZXZlbnRzIGFyZSBmbGFnZ2VkIGFzIGV4
cGVyaW1lbnRhbCBpbiB0aGVpciBkZXNjcmlwdGlvbi4NCj4gDQo+IFRoZSBwYXRjaGVzIHNob3Vs
ZCBiZSBhcHBsaWVkIG9uIHRvcCBvZjoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8y
MDI1MDgyOTAzMzEzOC40MTY2NTkxLTEtaXJvZ2Vyc0Bnb29nbGUuY29tLw0KDQpUZXN0ZWQgb24g
QWxkZXIgTGFrZSwgQXJyb3cgTGFrZSwgYW5kIFNhcHBoaXJlIFJhcGlkcy4NCg0KVGVzdGVkLWJ5
OiBUaG9tYXMgRmFsY29uIDx0aG9tYXMuZmFsY29uQGludGVsLmNvbT4NCg0KDQo+IA0KPiB2Ni4g
Rml4IGlzc3VlIHdpdGggJ1wtJyBlc2NhcGUgbm90IGJlaW5nICdcXC0nIChyZXBvcnRlZC1ieSBT
YW5kaXBhbg0KPiAgICAgRGFzIDxzYW5kaWRhc0BhbWQuY29tPikgd2hpY2ggZGlkbid0IGFsdGVy
IHRoZSBnZW5lcmF0ZWQganNvbi4NCj4gDQo+IHY1LiBSZWJhc2UuIEZpeCBkZXNjcmlwdGlvbiBm
b3Igc21pIG1ldHJpYyAoS2FuKS4gUHJlZml4IGFsbCBtZXRyaWMNCj4gICAgIG5hbWVzIHdpdGgg
bHBtXyAoc2hvcnQgZm9yIExpbnV4IFBlcmYgTWV0cmljKSBzbyB0aGF0IHB5dGhvbg0KPiAgICAg
Z2VuZXJhdGVkIG1ldHJpY3MgYXJlIGNsZWFybHkgbmFtZXNwYWNlZC4gS2FuIHJlcXVlc3RlZCBh
DQo+ICAgICBuYW1lc3BhY2UgaW4gaGlzIHJldmlldzoNCj4gICAgIGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xrbWwvNDM1NDg5MDMtYjdjOC00N2M0LWIxZGEtMDI1ODI5M2VjYmQ0QGxpbnV4Lmlu
dGVsLmNvbS8NCj4gICAgIFRoZSB2NSBzZXJpZXMgaXM6DQo+ICAgICBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9sa21sLzIwMjUwODI5MDQxMTA0LjQxODYzMjAtMS1pcm9nZXJzQGdvb2dsZS5jb20v
DQo+IA0KPiB2NC4gRXhwZXJpbWVudGFsIG1ldHJpYyBkZXNjcmlwdGlvbnMuIEFkZCBtZXNoIGJh
bmR3aWR0aCBtZXRyaWMuIFJlYmFzZS4NCj4gICAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xr
bWwvMjAyNDA5MjYxNzUwMzUuNDA4NjY4LTEtaXJvZ2Vyc0Bnb29nbGUuY29tLw0KPiANCj4gdjMu
IFN3YXAgdHN4IGFuZCBDaGVja1BNVSBwYXRjaGVzIHRoYXQgd2VyZSBpbiB0aGUgd3Jvbmcgb3Jk
ZXIuIFNvbWUNCj4gICAgIG1pbm9yIGNvZGUgY2xlYW51cCBjaGFuZ2VzLiBEcm9wIHJlZmVyZW5j
ZSB0byBtZXJnZWQgZml4IGZvcg0KPiAgICAgdW1hc2tzL29jY19zZWwgaW4gUENVIGV2ZW50cyBh
bmQgZm9yIGNzdGF0ZSBtZXRyaWNzLg0KPiAgICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGtt
bC8yMDI0MDMxNDA1NTkxOS4xOTc5NzgxLTEtaXJvZ2Vyc0Bnb29nbGUuY29tLw0KPiANCj4gdjIu
IERyb3AgdGhlIGN5Y2xlcyBicmVha2Rvd24gaW4gZmF2b3Igb2YgaGF2aW5nIGl0IGFzIGEgY29t
bW9uDQo+ICAgICBtZXRyaWMsIHNwZWxsaW5nIGFuZCBvdGhlciBpbXByb3ZlbWVudHMgc3VnZ2Vz
dGVkIGJ5IEthbiBMaWFuZw0KPiAgICAgPGthbi5saWFuZ0BsaW51eC5pbnRlbC5jb20+Lg0KPiAg
ICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI0MDMwMTE4NTU1OS4yNjYxMjQxLTEt
aXJvZ2Vyc0Bnb29nbGUuY29tLw0KPiANCj4gdjEuIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xr
bWwvMjAyNDAyMjkwMDE4MDYuNDE1ODQyOS0xLWlyb2dlcnNAZ29vZ2xlLmNvbS8NCj4gDQo+IElh
biBSb2dlcnMgKDIyKToNCj4gICBwZXJmIGpldmVudHM6IEFkZCBSQVBMIG1ldHJpY3MgZm9yIGFs
bCBJbnRlbCBtb2RlbHMNCj4gICBwZXJmIGpldmVudHM6IEFkZCBpZGxlIG1ldHJpYyBmb3IgSW50
ZWwgbW9kZWxzDQo+ICAgcGVyZiBqZXZlbnRzOiBBZGQgQ2hlY2tQbXUgdG8gc2VlIGlmIGEgUE1V
IGlzIGluIGxvYWRlZCBqc29uIGV2ZW50cw0KPiAgIHBlcmYgamV2ZW50czogQWRkIHNtaSBtZXRy
aWMgZ3JvdXAgZm9yIEludGVsIG1vZGVscw0KPiAgIHBlcmYgamV2ZW50czogTWFyayBtZXRyaWNz
IHdpdGggZXhwZXJpbWVudGFsIGV2ZW50cyBhcyBleHBlcmltZW50YWwNCj4gICBwZXJmIGpldmVu
dHM6IEFkZCB0c3ggbWV0cmljIGdyb3VwIGZvciBJbnRlbCBtb2RlbHMNCj4gICBwZXJmIGpldmVu
dHM6IEFkZCBiciBtZXRyaWMgZ3JvdXAgZm9yIGJyYW5jaCBzdGF0aXN0aWNzIG9uIEludGVsDQo+
ICAgcGVyZiBqZXZlbnRzOiBBZGQgc29mdHdhcmUgcHJlZmV0Y2ggKHN3cGYpIG1ldHJpYyBncm91
cCBmb3IgSW50ZWwNCj4gICBwZXJmIGpldmVudHM6IEFkZCBwb3J0cyBtZXRyaWMgZ3JvdXAgZ2l2
aW5nIHV0aWxpemF0aW9uIG9uIEludGVsDQo+ICAgcGVyZiBqZXZlbnRzOiBBZGQgTDIgbWV0cmlj
cyBmb3IgSW50ZWwNCj4gICBwZXJmIGpldmVudHM6IEFkZCBsb2FkIHN0b3JlIGJyZWFrZG93biBt
ZXRyaWNzIGxkc3QgZm9yIEludGVsDQo+ICAgcGVyZiBqZXZlbnRzOiBBZGQgSUxQIG1ldHJpY3Mg
Zm9yIEludGVsDQo+ICAgcGVyZiBqZXZlbnRzOiBBZGQgY29udGV4dCBzd2l0Y2ggbWV0cmljcyBm
b3IgSW50ZWwNCj4gICBwZXJmIGpldmVudHM6IEFkZCBGUFUgbWV0cmljcyBmb3IgSW50ZWwNCj4g
ICBwZXJmIGpldmVudHM6IEFkZCBNaXNzIExldmVsIFBhcmFsbGVsaXNtIChNTFApIG1ldHJpYyBm
b3IgSW50ZWwNCj4gICBwZXJmIGpldmVudHM6IEFkZCBtZW1fYncgbWV0cmljIGZvciBJbnRlbA0K
PiAgIHBlcmYgamV2ZW50czogQWRkIGxvY2FsL3JlbW90ZSAibWVtIiBicmVha2Rvd24gbWV0cmlj
cyBmb3IgSW50ZWwNCj4gICBwZXJmIGpldmVudHM6IEFkZCBkaXIgYnJlYWtkb3duIG1ldHJpY3Mg
Zm9yIEludGVsDQo+ICAgcGVyZiBqZXZlbnRzOiBBZGQgQy1TdGF0ZSBtZXRyaWNzIGZyb20gdGhl
IFBDVSBQTVUgZm9yIEludGVsDQo+ICAgcGVyZiBqZXZlbnRzOiBBZGQgbG9jYWwvcmVtb3RlIG1p
c3MgbGF0ZW5jeSBtZXRyaWNzIGZvciBJbnRlbA0KPiAgIHBlcmYgamV2ZW50czogQWRkIHVwaV9i
dyBtZXRyaWMgZm9yIEludGVsDQo+ICAgcGVyZiBqZXZlbnRzOiBBZGQgbWVzaCBiYW5kd2lkdGgg
c2F0dXJhdGlvbiBtZXRyaWMgZm9yIEludGVsDQo+IA0KPiAgdG9vbHMvcGVyZi9wbXUtZXZlbnRz
L2ludGVsX21ldHJpY3MucHkgfCAxMDY1ICsrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgdG9v
bHMvcGVyZi9wbXUtZXZlbnRzL21ldHJpYy5weSAgICAgICAgfCAgIDUyICsrDQo+ICAyIGZpbGVz
IGNoYW5nZWQsIDExMTQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg==
