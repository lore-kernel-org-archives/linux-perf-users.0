Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2561D2030A;
	Wed, 24 Sep 2025 21:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758748388; cv=fail; b=jJeGhf5bN4tUHT7R8lMYrbUjjNwvb0HzeqhyRtjlcLplkxtdPD0XRsMmysBSNXj3v+hC8xay5LjjUZzyh00GJKUhdfvtzoxwg6N/UarCMfs/rVCJn2HYM9uA4Y6YiW9tov2BJO1YSXVGOKgE9t4wcAPQOE1IuxzmKYngEe5OLgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758748388; c=relaxed/simple;
	bh=8XX5aOAElG/2JYlkENDWV5HC3Eng4EdjZqJ/xhnJWCY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FCiyAcbLdAhtyqdzDqHBa8OvtzsVyUSkb55/FHk2BrEyPajVtKEPLINFG80UXY+1ytuHbg539b1okaM4lJdP56XD+5RaMkb5VL7ieCKL1TM9Lb1eb80f0+zpVSkt3Y2rccn3UOVq4gNZ5ww8BBN59ReyIiFEVo4iMksdpc2qRqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NGlE3psj; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGlE3psj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758748386; x=1790284386;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=8XX5aOAElG/2JYlkENDWV5HC3Eng4EdjZqJ/xhnJWCY=;
  b=NGlE3psjWPqSaidI0bLfE7hZ+hUfjy4XdPTSjfuKDaWQM/89RN5Ap6yr
   lvWZAQTlv0UVyDaoA+fwlBzYPOSeaPS/qDesgGaFKtMzFIhX7dUl2fOeZ
   KKQOJsJmY5iHJYWNQP5AotIxiUmPbUVbnDbPWj7Ba6w8sttw6snn/oVOf
   07ESO9j1aKS9W+Dr9ayZvnHWo/LvArPtD8UJgnyXeEkuVjQri+gcrxxx2
   WLLqkIgDOquGc/onFUKfY86i87/LNgQAqfhC4WxEWgj/y6j1wcgKfmAqW
   VrmU03rgy0JqGUW9bZYE/ANRkDAp00e/qHRnfeZ5vyWxYPYX80U5jznXJ
   g==;
X-CSE-ConnectionGUID: cE2obbNlSy2VF4GCT8ttMA==
X-CSE-MsgGUID: VpyXFZcFTw+XpOYSfr/kZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="86503163"
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="86503163"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 14:13:04 -0700
X-CSE-ConnectionGUID: VdFNJsGaRrOqXy0kMLZaVQ==
X-CSE-MsgGUID: 9CPL2F6iSDKB1vpPKwHKfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="208061710"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 14:13:04 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 14:13:03 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 14:13:03 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.17) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 14:13:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6a9XSGQfPdMsmlGP1aflxbtpkjt+H2Hihk0shaSzNdX2ZpogWimnVAkmy6BKheH3gEb2bmDx/WErJAIgGm8r7D6VH5K/wn7NBOuOj995WJ/L4uzxdiZCs1QRYI9UcIvy6vGxEvdat5uGGcQVWrwim16Z9ozbipB0bXZKF6iFFg2oR/pqUqQ2PhZdUE0PVKO6CACXYHchilMTkwMQEo1Qx3cg8LC0jgssYYfUmeGKC+pe1grziowUoOvpKYPVsCksyv2ezp5hB8DvHN9iXqG4PeSFFz7tyS12xYs8gCsDfbGdFhg365U548+AykzFrScNiUd4VjDwGLcp56WFl2PLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XX5aOAElG/2JYlkENDWV5HC3Eng4EdjZqJ/xhnJWCY=;
 b=ip9/ncby2wVTRML8/8IdvegR8Mof5RP74WdPy5C4MONAYof91LOYwXYappg7E9u6g2KFN4irkrKLBvN0GyrNrmcbUB1VX3yquDXe58FnK6ErriC5bqRjKXToTxYkQiHQFHeq3l1Bjk84Y5wxfn+OrRxFl744oFoNMbC68vtHxpvJ6mZTyuYXKqBqWtgCdfZdv919ZAeBX98NVkQL/5Xcxi3t20FTh61jZzX0tyi83v4NPWy1tLty4YwHJuMhZ9yd3Ds1cOeNdXFcbQX8nGMuMgBVen4sAyDvOf747KjrjXAXAh5Sbu2HCkktVp0rk+z2j9G2DC7caVKZgP4WVhj6rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by DS0PR11MB8688.namprd11.prod.outlook.com (2603:10b6:8:1a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 21:12:54 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%3]) with mapi id 15.20.9137.017; Wed, 24 Sep 2025
 21:12:54 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"afaerber@suse.de" <afaerber@suse.de>, "Biggers, Caleb"
	<caleb.biggers@intel.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"acme@kernel.org" <acme@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"irogers@google.com" <irogers@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mani@kernel.org" <mani@kernel.org>
Subject: Re: [PATCH v1 00/10] perf vendor events intel update
Thread-Topic: [PATCH v1 00/10] perf vendor events intel update
Thread-Index: AQHcLRjeTPATN5hPYEeTaFfyepsKJbSi1cmA
Date: Wed, 24 Sep 2025 21:12:54 +0000
Message-ID: <5275b98eff5e686521c407f4d38eed8448be5a3b.camel@intel.com>
References: <20250924060229.375718-1-irogers@google.com>
In-Reply-To: <20250924060229.375718-1-irogers@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|DS0PR11MB8688:EE_
x-ms-office365-filtering-correlation-id: 5fac407b-6162-43b5-98f8-08ddfbaf2093
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|38070700021|921020;
x-microsoft-antispam-message-info: =?utf-8?B?Q2RxVUlaU25hNnJKUVpUeE9aeUtObkNyT0lBejhIa1NEVTZIQXhEMWVneWhL?=
 =?utf-8?B?ditWWnRoUVpVR3NBclV3Q2hGRUNiOWpHUTZPZ21ZQkZIZS9SSzJ3bHQzMDRO?=
 =?utf-8?B?c0JIRzhtaWc2MnVsYjdQbGJSSTdHb1VBUlQyZG4rWTBRN3V2TEZPSTdPMnZE?=
 =?utf-8?B?OGtwcDNlaVA1RTl1SjFZSmZDNWNZSSt0OGlzeW12RkxqM3JoQzlMOWlTN080?=
 =?utf-8?B?a3ZEV0Jqd202by9XQ21LZlVteXJoaDdyVDBXdUtxSUZ2U0oxdU4xMVZmSXVz?=
 =?utf-8?B?ZVRHWG9QRUhlbWJlM1hsSUZyUXV0Rzd6eFhtZElFVm5hb0RDK3ZFYWJzeUN5?=
 =?utf-8?B?T3lnY0tYL0pmWVd0ZzZMM0pwV2VBWjg2cjh3elhMOEFvU2puSzlleUJQbUxi?=
 =?utf-8?B?R2lMRjgweTAxYmJSWWJWZ3g3QnA1U1F5ak9MZHNtaVIvQk5vdDZyTUJteHVw?=
 =?utf-8?B?eFg1OXB1WTBhWk9JK2d4dmg5MDVMQ1VESW81SFVSMGV5dWJXNWh0a2xveDht?=
 =?utf-8?B?bnQ4Q3FySHg4WDlhZFZCTEhZRjVPZmliaHRqcXZieHB4aGNvdEw1d2lnQ1ZE?=
 =?utf-8?B?aEk2WURSVDQwaW8vTGRKQTJsbXFTRFBJV0RCRmgxeTZaZUpvUXdNcXYvbkZI?=
 =?utf-8?B?cWJ3Z2ZVTHArZEEvMnhTc21CUGRhbkhMN2RBR29kTjI2aDlXQXdOZVVxZmN2?=
 =?utf-8?B?UndPWkwxYmVpZTJSbUU2eDR3YVBpTUZNblRaa29KZlNlTFR4cVZ3cXlBK3dQ?=
 =?utf-8?B?dnJqWEFWUEtUTVdWejVvU09xT0xubHUwaGRLUG0wNitGS1BIeTgvK09kVUxP?=
 =?utf-8?B?VUJZV0pXZDRhQUNrNXhIS1NyMVZRUWlJRnNFdkVyNEpySnl4djVFSlJ6UGxM?=
 =?utf-8?B?MTBMU1dHd294S3FEWEEvNi9SVXRCTmJhOGwreGNmRjFGcnF0SEw1OEg3NktM?=
 =?utf-8?B?WFhPL2FMRkxOTVM2SCsrc2tVbi82bzMzL0VxZERDaXRXeDVtYjNWMUczYVc5?=
 =?utf-8?B?b3ZvTEVieU1WbXFQZEx5bCs3bXJkOG9qMkdReFBkaldOV1dkYUNaNmM0Q0w5?=
 =?utf-8?B?Qlo5aHpCZFZ4dzBuK2lING5LZ1RuVGc1TnVJZG5rakFGeTFNU2p3ekZFdXps?=
 =?utf-8?B?dmVma2p6cFU2YzNIcnZYdzZ4RDBHMzl6NTM3Rk5IS2wyZW4yVVV1QjNSeTlK?=
 =?utf-8?B?VUludlVpZzUwS25tc3lidzlsSStWRFBCVkdTaE8vVVYvb1E0aFVJS0FzSno5?=
 =?utf-8?B?ZTdveVBjTlBNazFya0ZCamVXU0RsQk4xZk11ZDUrTXJHakEwY0JFcW5RTDFl?=
 =?utf-8?B?RGJkYTRRS3R4Z3lXa255TlFzRFlSZWo2d21xSjVGc1lBMDFua0gvbEw3VmRU?=
 =?utf-8?B?TDF6cy9oeWhDbVRRQ1ROalBuUDkyeHdBa2JJdWV3Vk50R1ZzNFJLMENZc0xv?=
 =?utf-8?B?eUFsQ3ZCY09qd2hOUmxxYW5vVGdJZ3ZDVGgwZkRJWFY0bGtNRit6NGlyelEw?=
 =?utf-8?B?OVFVNmRkZWpON0V2b2hqVk9lSEE2MUJKUkF6ZFByUlhuaER5SWpEVFhEV3Bl?=
 =?utf-8?B?aThySktUeG5rRnA1T1hjK1ZjTER5STVDQnlzMlNGczNEckFNblk3c0N0Vm9w?=
 =?utf-8?B?Qi8rRHdwY3U5d2lwdy9jM3VCeWhWWU1kQzVrS3AwTFRFdmdlbXV3aVFtMXda?=
 =?utf-8?B?V2ZCUGFDQncxZEdIMjN6OUUxS0pzY3J0YXdSdSszSWc1bjNsakJvd0Zwa1Y0?=
 =?utf-8?B?OGY3dDJiYUJGU2ZUOC9lczE0SmV3eVpOQVYyblRNTjgydW1PdEQyRTgzMmFj?=
 =?utf-8?B?TmVtbWd2aEFZYVcwUjl6ZSt0RFExdU55NzJGdFRNaEE3cVBFLzJLN1UvN1dF?=
 =?utf-8?B?RWFDM2M2TUFya0dGZWtWQkdicm9GdHhXOVVtanhRWlNZRjV5VzhLU2s3QldO?=
 =?utf-8?B?TEp3MXM5VlpRcXo0RS9wUC8zOWRyVWdrWTFUbjI1VTJIQkJFbHlTdGczYURT?=
 =?utf-8?Q?rDjIoilgB+pD7pk7TY/DKrlT01vNpc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHQvOXN0b0JOUDJxQTRwL3dhK2dkbHZiR1VCd0xMSnIySDM0Zy9BY2FQSlJO?=
 =?utf-8?B?NHpUTTZ1aGI5bUpnNFhzUkVpVjhWQVdMbkFJbjljNWg4aXJJc2lSejlyMTdk?=
 =?utf-8?B?TnZuVHkzdzBPSHZIY21LcmppT1hnNlhKUDg5YlhVZk5BVTlKbVhCeGJ4RXI3?=
 =?utf-8?B?VFhpVXEyNnI5dkxFVkZ1MndtdGdHc09nTkVHWm5FSDVzZDNuR0VRbVduSTdw?=
 =?utf-8?B?c2thU3NzZlFCSHE5bEluMXI2VkswUmorMEkxdFoyektRcDFHWWZVVytPbVNN?=
 =?utf-8?B?V3Fvc0VhTlAzWElnb0VTclBvYS8veUpLdjBrZkxpM3VyMWxBUDJ4UUJuZGxq?=
 =?utf-8?B?MGkwemFnOUVvUy9WN2VJYjFJQlhNby9STWRXc1hHRUJUSXZoQzQzMm40aUox?=
 =?utf-8?B?U1gzQW8rT1J0MkZCYzMyamdTTDUreUJiZWtCSEc5NWNMd0t3R2lYSG85MFNM?=
 =?utf-8?B?WkNaYjlmM25RL2l6MS95VE5TMzdmcjdLTUF4K1R2cndPeXo0eFVVSHVJUFJW?=
 =?utf-8?B?NFhNNFVGck0zTzRlTmNFV1pOTFpldDBieC9LQk50MjhoRmRacEFTT0FpQlE1?=
 =?utf-8?B?REFzdVFGZ3JYUFdwUUFFanB2OXM0Z3NUV2Fib0R5VHhuVWdXcklVWXZML0dh?=
 =?utf-8?B?RXdvY05HZUVHVU9Ka1dBdUJRMUF4NGk0anJWQ0pkWjJFSTgxK3VIdUl1YjVs?=
 =?utf-8?B?N3Y3ckZzMWhHVVFobHM3U1E3aXpYaFo0cEhHeEZRMUw2cU5rWjhER0xKTFI4?=
 =?utf-8?B?NFNmbXNTY2EzS3pRTU1aUGl5cDNBTUtLWGVkb0JUZlUrM0xFWGJ1R0g5NUdx?=
 =?utf-8?B?RnNlODA5ZGYyQ2cvbmQzVWk4YmJSd21Hem5DSkNBeXdsQll3cXp4aVVGYTd4?=
 =?utf-8?B?WUh1a0U2U3RnSCt2Q2RqWEI0NVc5cVozeHpzbkdRZHkzKytDZ2pFakprUDhl?=
 =?utf-8?B?eFFLYWZEQ3BZSE0xaUdPY1BqeVpwUlpRbTZEamgxZEJiemFuVW9TUnVyeEJa?=
 =?utf-8?B?QTFxZXk3OEQwNVJyWkFxTlQ5eXJTNE1leXVKZ1NRNlpFMFFHWXZHVzNzQS9i?=
 =?utf-8?B?K2I3NTFqaXBDc0F0NEFQSUVtS2ZZNFp4eDI1V0h1UmtDdnRHdE5zUHFYNnd1?=
 =?utf-8?B?Um9ENHlhcjc2T1ozOEdPQVZBMmlmZ29zZVhXNkg4SkpsMVhEczJGbS9MMFhn?=
 =?utf-8?B?ZW8wRjZ3SC8zSGZKa1FOUXV3dHNqV1kxWENUcFZVNnVieVRJKzFBanNZRDlD?=
 =?utf-8?B?OVN1NFEzTDJBOEE3RFQ1cTk2WEV0ZURxOHUxZ1FLRTRDbnQrZUpLcmxSK0ZM?=
 =?utf-8?B?Vm1NcXNlczJ3L1NRRHNSRWRwWnR2ZHdHT1dmMlp5bHFwYmxxbnlrb1pTdWxI?=
 =?utf-8?B?aXBkWmRNaVRtc3drclRzUzBqQ21TM0RrdG10Q1ZCaHJXUHhqKzRvNGxNbFNH?=
 =?utf-8?B?aDdZVGtwTTFidnBCdkdGQVorek9lQnY0NlZaeTUrekFKU1RELzF5dTY0Wks4?=
 =?utf-8?B?bDZvTDhpVkc1L0RQSXNpV3FIYkxTMHRkcGFhMXZmb3JCNG5uTHQwYXdtZzRn?=
 =?utf-8?B?KzJaV3I5R05PTG1hNzlTNmVlNHpXTnFZREtaTGFrSS85cXNPVzlXdTI0Z1JU?=
 =?utf-8?B?T3cwWjFuaVdkcFJ0L0ZHT1VjSldQMlJyTWR1bFZBc1o0TVoyTFBHSUt1VUJ3?=
 =?utf-8?B?Q3BCay83WmlrTFB3YzV5Yk11SXZHdmxmRmtKN0dyRzVack4zZU1XcW4rWHF0?=
 =?utf-8?B?a0RLeUY1elh1bm5SOG9FNDh2OVpLZkM5dXAyVXhGZ0M0WE1KdmR2WDcwbElw?=
 =?utf-8?B?TTY3UVNkbGloVGhnSXBPN3JZU3FVM21URnlTQnpsYTZSU1AzK0QxMnBEdERr?=
 =?utf-8?B?TW5iZ0dob0dKRm8wdDRlMnB1Vmx3SGVockdwNTE2YjhFdzl6TGY3TEVIc1ls?=
 =?utf-8?B?NXNxYkUyUmVnMFdmeEdxMXYxaTl4STA1bjRJRFRGWm5XM0NMM29VZDNUUFQv?=
 =?utf-8?B?NnVWSHU3OUp0amg5WUxvVVp5alcrYndjUWk2OWpNQXBWd3ltWG14amhtY0Nz?=
 =?utf-8?B?aWhtRzdmUjBnaXpnbG50ZjJSVXJFR0NuRXdTS3E0Lys3dmdzbjlZeHNjaVRZ?=
 =?utf-8?B?NVFBcDdlSXVuWXNiT1BkeFhuUWZlcmpLMnVqbG5QakdMcHpDUEc5UnovTlVW?=
 =?utf-8?B?Nzd2SS90S0t6ZXBqcUlZeFR0dTNaaDNtY1lwV1FZOHB1dUM2UCtKVFc1YUVx?=
 =?utf-8?B?ZGszSWZsM0hDMkhwRDFaRGVZeGN3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6AE75E1BEBDE143BF68F26E94F6853C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fac407b-6162-43b5-98f8-08ddfbaf2093
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 21:12:54.0470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tu08hshIealtLihs058jOjUm9oXLteDBI27a6oq1i+rlGwVi/oFuTQZTuunoR+IIcSj8ddUoFKOo9XlSyzegfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8688
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTA5LTIzIGF0IDIzOjAyIC0wNzAwLCBJYW4gUm9nZXJzIHdyb3RlOg0KPiBV
cGRhdGUgZXZlbnRzIGFuZCBzb21lIG1ldHJpY3MgdG8gdGhlIGxhdGVzdCBwZXJmbW9uIHZlcnNp
b25zOg0KPiDCoC0gYWxkZXJsYWtlIDEuMzQNCj4gwqAtIGFycm93bGFrZSAxLjEzDQo+IMKgLSBl
bWVyYWxkcmFwaWRzIDEuMjANCj4gwqAtIGdyYW5kcmlkZ2UgMS4xMA0KPiDCoC0gZ3Jhbml0ZXJh
cGlkcyAxLjE1DQo+IMKgLSBsdW5hcmxha2UgMS4xOA0KPiDCoC0gbWV0ZW9ybGFrZSAxLjE3DQo+
IMKgLSBzYXBwaGlyZXJhcGlkcyAxLjM1DQo+IMKgLSBzaWVycmFmb3Jlc3QgMS4xMg0KPiANCg0K
TWV0cmljcyB0ZXN0cyBwYXNzZWQgb24gQWxkZXIgTGFrZSwgU2FwcGhpcmUgUmFwaWRzLCBhbmQg
QXJyb3cgTGFrZS4NCg0KVGVzdGVkLWJ5OiBUaG9tYXMgRmFsY29uIDx0aG9tYXMuZmFsY29uQGlu
dGVsLmNvbT4NCg0KVGhhbmtzLA0KVG9tDQoNCj4gSWFuIFJvZ2VycyAoMTApOg0KPiDCoCBwZXJm
IHZlbmRvciBldmVudHMgaW50ZWw6IFVwZGF0ZSBhbGRlcmxha2UgZXZlbnRzIHRvIHYxLjM0DQo+
IMKgIHBlcmYgdmVuZG9yIGV2ZW50cyBpbnRlbDogVXBkYXRlIGFycm93bGFrZSBldmVudHMgdG8g
djEuMTMNCj4gwqAgcGVyZiB2ZW5kb3IgZXZlbnRzIGludGVsOiBVcGRhdGUgZW1lcmFsZHJhcGlk
cyBldmVudHMgdG8gdjEuMjANCj4gwqAgcGVyZiB2ZW5kb3IgZXZlbnRzIGludGVsOiBVcGRhdGUg
Z3JhbmRyaWRnZSBldmVudHMgdG8gdjEuMTANCj4gwqAgcGVyZiB2ZW5kb3IgZXZlbnRzIGludGVs
OiBVcGRhdGUgZ3Jhbml0ZXJhcGlkcyBldmVudHMgdG8gdjEuMTUNCj4gwqAgcGVyZiB2ZW5kb3Ig
ZXZlbnRzIGludGVsOiBVcGRhdGUgbHVuYXJsYWtlIGV2ZW50cyB0byB2MS4xOA0KPiDCoCBwZXJm
IHZlbmRvciBldmVudHMgaW50ZWw6IFVwZGF0ZSBtZXRlb3JsYWtlIGV2ZW50cyB0byB2MS4xNw0K
PiDCoCBwZXJmIHZlbmRvciBldmVudHMgaW50ZWw6IFVwZGF0ZSBwYW50aGVybGFrZSBldmVudHMg
dG8gdjEuMDANCj4gwqAgcGVyZiB2ZW5kb3IgZXZlbnRzIGludGVsOiBVcGRhdGUgc2FwcGhpcmVy
YXBpZHMgZXZlbnRzIHRvIHYxLjM1DQo+IMKgIHBlcmYgdmVuZG9yIGV2ZW50cyBpbnRlbDogVXBk
YXRlIHNpZXJyYWZvcmVzdCBldmVudHMgdG8gdjEuMTINCj4gDQo+IMKgLi4uL3BtdS1ldmVudHMv
YXJjaC94ODYvYWxkZXJsYWtlL2NhY2hlLmpzb27CoCB8wqDCoCAzNiArDQo+IMKgLi4uL3BtdS1l
dmVudHMvYXJjaC94ODYvYXJyb3dsYWtlL2NhY2hlLmpzb27CoCB8wqDCoCA0NiArLQ0KPiDCoC4u
Li9wbXUtZXZlbnRzL2FyY2gveDg2L2Fycm93bGFrZS9tZW1vcnkuanNvbiB8wqDCoMKgIDYgKy0N
Cj4gwqAuLi4vcG11LWV2ZW50cy9hcmNoL3g4Ni9hcnJvd2xha2Uvb3RoZXIuanNvbsKgIHzCoMKg
wqAgMiArLQ0KPiDCoC4uLi9hcmNoL3g4Ni9lbWVyYWxkcmFwaWRzL2NhY2hlLmpzb27CoMKgwqDC
oMKgwqDCoMKgIHzCoMKgIDYzICsNCj4gwqAuLi4vYXJjaC94ODYvZW1lcmFsZHJhcGlkcy9lbXIt
bWV0cmljcy5qc29uwqDCoCB8wqDCoCAxMiArDQo+IMKgLi4uL2FyY2gveDg2L2VtZXJhbGRyYXBp
ZHMvdW5jb3JlLWNhY2hlLmpzb27CoCB8wqDCoCAxMSArDQo+IMKgLi4uL2FyY2gveDg2L2VtZXJh
bGRyYXBpZHMvdW5jb3JlLW1lbW9yeS5qc29uIHzCoMKgIDIyICsNCj4gwqAuLi4vYXJjaC94ODYv
ZW1lcmFsZHJhcGlkcy91bmNvcmUtcG93ZXIuanNvbsKgIHzCoMKgwqAgMiAtDQo+IMKgLi4uL3Bt
dS1ldmVudHMvYXJjaC94ODYvZ3JhbmRyaWRnZS9jYWNoZS5qc29uIHzCoMKgIDIwICstDQo+IMKg
Li4uL2dyYW5pdGVyYXBpZHMvdW5jb3JlLWludGVyY29ubmVjdC5qc29uwqDCoMKgIHzCoMKgIDEw
ICstDQo+IMKgLi4uL2FyY2gveDg2L2dyYW5pdGVyYXBpZHMvdW5jb3JlLW1lbW9yeS5qc29uIHzC
oCAxMTIgKysNCj4gwqAuLi4vcG11LWV2ZW50cy9hcmNoL3g4Ni9sdW5hcmxha2UvY2FjaGUuanNv
bsKgIHzCoMKgIDQ2ICstDQo+IMKgLi4uL3BtdS1ldmVudHMvYXJjaC94ODYvbHVuYXJsYWtlL21l
bW9yeS5qc29uIHzCoMKgwqAgNiArLQ0KPiDCoC4uLi9wbXUtZXZlbnRzL2FyY2gveDg2L2x1bmFy
bGFrZS9vdGhlci5qc29uwqAgfMKgwqDCoCAyICstDQo+IMKgdG9vbHMvcGVyZi9wbXUtZXZlbnRz
L2FyY2gveDg2L21hcGZpbGUuY3N2wqDCoMKgIHzCoMKgIDIwICstDQo+IMKgLi4uL3BtdS1ldmVu
dHMvYXJjaC94ODYvbWV0ZW9ybGFrZS9jYWNoZS5qc29uIHzCoMKgIDM2ICsNCj4gwqAuLi4vYXJj
aC94ODYvcGFudGhlcmxha2UvY2FjaGUuanNvbsKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTIwNyAr
KysrKysrKysrLQ0KPiDCoC4uLi9hcmNoL3g4Ni9wYW50aGVybGFrZS9jb3VudGVyLmpzb27CoMKg
wqDCoMKgwqDCoMKgIHzCoMKgwqAgOSArLQ0KPiDCoC4uLi9hcmNoL3g4Ni9wYW50aGVybGFrZS9m
bG9hdGluZy1wb2ludC5qc29uwqAgfMKgIDI4NiArKysNCj4gwqAuLi4vYXJjaC94ODYvcGFudGhl
cmxha2UvZnJvbnRlbmQuanNvbsKgwqDCoMKgwqDCoMKgIHzCoCA1MzUgKysrKysNCj4gwqAuLi4v
YXJjaC94ODYvcGFudGhlcmxha2UvbWVtb3J5Lmpzb27CoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEw
NiArLQ0KPiDCoC4uLi9hcmNoL3g4Ni9wYW50aGVybGFrZS9vdGhlci5qc29uwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgwqAgNDQgKw0KPiDCoC4uLi9hcmNoL3g4Ni9wYW50aGVybGFrZS9waXBlbGlu
ZS5qc29uwqDCoMKgwqDCoMKgwqAgfCAxNzc2DQo+ICsrKysrKysrKysrKysrKystDQo+IMKgLi4u
L2FyY2gveDg2L3BhbnRoZXJsYWtlL3VuY29yZS1tZW1vcnkuanNvbsKgwqAgfMKgwqAgMjYgKw0K
PiDCoC4uLi9hcmNoL3g4Ni9wYW50aGVybGFrZS92aXJ0dWFsLW1lbW9yeS5qc29uwqAgfMKgIDI0
OCArKysNCj4gwqAuLi4vYXJjaC94ODYvc2FwcGhpcmVyYXBpZHMvY2FjaGUuanNvbsKgwqDCoMKg
wqDCoMKgIHzCoMKgIDYzICsNCj4gwqAuLi4vYXJjaC94ODYvc2FwcGhpcmVyYXBpZHMvc3ByLW1l
dHJpY3MuanNvbsKgIHzCoMKgIDEyICsNCj4gwqAuLi4vYXJjaC94ODYvc2FwcGhpcmVyYXBpZHMv
dW5jb3JlLWNhY2hlLmpzb24gfMKgwqAgMTEgKw0KPiDCoC4uLi94ODYvc2FwcGhpcmVyYXBpZHMv
dW5jb3JlLW1lbW9yeS5qc29uwqDCoMKgwqAgfMKgwqAgMjIgKw0KPiDCoC4uLi9hcmNoL3g4Ni9z
YXBwaGlyZXJhcGlkcy91bmNvcmUtcG93ZXIuanNvbiB8wqDCoMKgIDIgLQ0KPiDCoC4uLi9hcmNo
L3g4Ni9zaWVycmFmb3Jlc3QvY2FjaGUuanNvbsKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA2MSAr
LQ0KPiDCoC4uLi94ODYvc2llcnJhZm9yZXN0L3VuY29yZS1pbnRlcmNvbm5lY3QuanNvbiB8wqDC
oCAxMCArLQ0KPiDCoC4uLi9hcmNoL3g4Ni9zaWVycmFmb3Jlc3QvdW5jb3JlLWlvLmpzb27CoMKg
wqDCoMKgIHzCoMKgwqAgMSAtDQo+IMKgLi4uL2FyY2gveDg2L3NpZXJyYWZvcmVzdC91bmNvcmUt
bWVtb3J5Lmpzb27CoCB8wqAgMTAzICstDQo+IMKgMzUgZmlsZXMgY2hhbmdlZCwgNDcxMiBpbnNl
cnRpb25zKCspLCAyNjIgZGVsZXRpb25zKC0pDQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xz
L3BlcmYvcG11LQ0KPiBldmVudHMvYXJjaC94ODYvcGFudGhlcmxha2UvZmxvYXRpbmctcG9pbnQu
anNvbg0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy9wZXJmL3BtdS0NCj4gZXZlbnRzL2Fy
Y2gveDg2L3BhbnRoZXJsYWtlL290aGVyLmpzb24NCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgdG9v
bHMvcGVyZi9wbXUtDQo+IGV2ZW50cy9hcmNoL3g4Ni9wYW50aGVybGFrZS91bmNvcmUtbWVtb3J5
Lmpzb24NCj4gDQoNCg==
