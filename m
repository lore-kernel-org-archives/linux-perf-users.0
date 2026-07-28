Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BC0418A39;
	Tue, 28 Jul 2026 21:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785274401; cv=fail; b=G+db6A10VmeX0ZPAN/2uJvJYBB2+X5+v6rf//Ihe3kwgCxEkZ4QufCU0rqxGBbFWXmw5HyhId/LG6SBngkZ7pXt2BGx38wgG6H8hOMbR1n7aH43n7Vp7ywfjpSwDYbcEf5S4m6dbma7ac8nohL064UPkTJdkm2HtT3YU8e6hdNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785274401; c=relaxed/simple;
	bh=gM974rNZqdJ1c5L/Mk4vpGpGe37lJyjYAu75W5B3fYk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TfZtNapMu1TIbBz+e++06TD+FyHDmDqeQ8peyWRkJZVGRaoCfdvNRrKxxYtWN0FkR1Jcafg8gt4TPrsOZSisZPYkgNt0/pzqoMiB6eIeYDhuSCZUdZTqXQJ39pHvXbZVaIjUZ47Mnv+0c0j9hlpOzrgm5Yu/po1bsox1yIECrPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lmfqG/0S; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lmfqG/0S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785274400; x=1816810400;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gM974rNZqdJ1c5L/Mk4vpGpGe37lJyjYAu75W5B3fYk=;
  b=lmfqG/0SsXm1IkylJSRSCXed0G4mFyF4npcvjTIx2A7LOwgfngRKTdJz
   gtndDS+uhbIruAy25qiKkz6Ygsy9gSQqH+mG0KLlhy+IIFUeo21hHbDYz
   EZqLjULciaNFE/OAI6w+bzfemxDFaRRG/rAFk+qH0e9m2DfvCDxP66t03
   fBZQ6OetiD3k18W5YWyqu/m5dfXtgy3+hAUziZReUphKG+47cy3/BJuI3
   QAQAFdP5mxT794JNfSqBdc5X15/6AwzFajMqKU7myfppEIdQ2nX9xMAl/
   cVn7QEW9vpMV9COh03l8yNOxXsxzFI8x2twiDl670waCWgcyx7LUBkqxJ
   g==;
X-CSE-ConnectionGUID: EzWi6JYyQ6KEnB2AoqaXrA==
X-CSE-MsgGUID: pwVbddTaRfWYMelxh9Wy2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85727238"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="85727238"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 14:33:20 -0700
X-CSE-ConnectionGUID: omZBytV7STOy4pCkIaClhg==
X-CSE-MsgGUID: hlG5R99zQauYjBGEnhiY1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="253484814"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 14:33:18 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 14:33:17 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 28 Jul 2026 14:33:17 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.3) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 14:33:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLftW6PJIzaJ1aaDLc63LBp7DSJK0mkcJjh6EYv7SEEJcMEpw18YXM3I6X6lfHS3OxxsS3CwikXd6xJrBxuZ8G5S9K8YJOOx5V4UU/fGyKjmfxaF4egyOxAzJN/rePApvyehBxuEoAJUscfaBbULwAVDtqnws9ekC9Lqm9I7mitNiV8XCIKfwwNjRO0Txpt2UoV8XC+vZ6n80AS5SFofBuZwKemPSQEXb+zj/rIWY2jzg1EWu9WynHHSs1rnTuylHi0jG1+xQKgGO0WOCi/qDgVyPNUIyfKCdBpO93oXjaruBsLrQYb2Jx1XKYiT1Z3JbXLVxc1X2C99DskrFuhzpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gM974rNZqdJ1c5L/Mk4vpGpGe37lJyjYAu75W5B3fYk=;
 b=fAmFUrPSppBvLRtihz+mf4kCcI+Zf15gGAjTvy9Wg1PWnO2Tj1joXG3yB9zPXfn2/SYfUmvS7LQnNS0TYqWHG1G0YDv/z/GBGYVjtBOHA13/CzT4NDXUnOjmxiwWrqniKkJhGLXgR8UphX+PAdANWKCVkGUoeZDBgvfosjr99cvbIq9uXz10Ya3CfgEaFoYy51aUvP1AwOVNHi87/u4A+AaB1a2spWuuBDi7kx8dRt9C2k2j3Ax7FjBpwUqkWM2UNbaYWZD4tQ3fP4L/rFGr7RxCpaY561q3F9yM46ag8Kb3c7sQsumdHTkIwjqZ96uPj391EHcfLH0pQkPcWFmQtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by DM4PR11MB8180.namprd11.prod.outlook.com (2603:10b6:8:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 21:33:14 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%2]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 21:33:14 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "namhyung@kernel.org" <namhyung@kernel.org>
CC: "james.clark@linaro.org" <james.clark@linaro.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"acme@kernel.org" <acme@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>, "Rogers, Ian"
	<irogers@google.com>, "Hunter, Adrian" <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 5/6] perf header: Support memory ranges
Thread-Topic: [PATCH v2 5/6] perf header: Support memory ranges
Thread-Index: AQHdEyoohYRDShkY9EiReDJfgkqOm7aDSCSAgABC6IA=
Date: Tue, 28 Jul 2026 21:33:13 +0000
Message-ID: <329ae3d6ad1419fc356995badc5f7de5be422ba3.camel@intel.com>
References: <20260714004359.179451-1-thomas.falcon@intel.com>
	 <20260714004359.179451-6-thomas.falcon@intel.com>
	 <amjn98atBKIZDC3c@google.com>
In-Reply-To: <amjn98atBKIZDC3c@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|DM4PR11MB8180:EE_
x-ms-office365-filtering-correlation-id: 738bd1c6-fa2f-450b-23c2-08deecefd494
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|10070799003|7416014|376014|5023799004|4143699003|11063799006|10067099003|6133799003|56012099006|22082099003|18002099003|3023799007|38070700021;
x-microsoft-antispam-message-info: UMPQ7cSEJ8Q5CUSVFmDBfeT6PDgrtuM5CTe2ynQR+YXuMicuUTO3fRUl8XdB4YoHzVxZRhNvZsC9HWZI7cXIRQDLWCbRqlQRI6KtpF/6n52l4o6FhaOZOL+7OeyTvIx7Wm2fK7AckcX50f9cD/OMmiU3XYBLaDxa1s60fgBTDM4RC0v/L485ilckFoyMpYVe7DxrvGorDIj+8TfW/PdaUHUsBPPzzH9P/f7WSXqmqnVkQV30QmWKo+dZKvlfpPXaJtxyWu92VuE7S+EmpqNCpg+6bVkieN5lm5j04PBZGEdugNeLOpcVv5wT41P7sQuCTrS8+gQj8dSArQS46BKXvVWnLKSIlCpN9popxhHkAHBFkPAtj8wwC/y6r7SJwi5viF5jPQEDMolxpVEitSISGnoG9XurQ/zf6i4iR+Pvi9A7OT/LKVbAxM6/GtZoeYnGs7IEvayf9ZTh7M0nEokBjHmFHyih0ymJvBIUPSeKPUZvB2ruJRF6D/cIQtl7WONbgjex9eD87fDfBgAHgZ6KCb61lsxVfj3TQyCRHczUktQKFuCAXUq9ToP1MU00dKZyPpUUz4ZE7PVrvpmb2AcY2wVEidBEHd0ERtYtupSlmM9A7hjRKKO/o9xvFuvVWXN+bT8Ezd8wTYGpJcw2I0dpHUfxfWlOiZfkETovPyOukuemfHVyoqL1Q8LdW2UjVSG9DrqcXdwEblLf8i4PsvEo6DcyYN9M5i650KkyJAbCJzA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(10070799003)(7416014)(376014)(5023799004)(4143699003)(11063799006)(10067099003)(6133799003)(56012099006)(22082099003)(18002099003)(3023799007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2lwdXZzU3ZNODdRS2h3TWRRV0ZKVm84K0NKVjRncUFSOHUycDRPNjYzVTJi?=
 =?utf-8?B?ZUcwdnhKY0Z1c2NPcllPbUtLMXJtTFU4YzJSSXBFRHlscTJmTlY1YjRoZGFW?=
 =?utf-8?B?L1Erd0FveVRURHFoT3N3bHJIeFFYeXdHVGJuQ0F2RFlqYXdoOGpHRkVwNEl5?=
 =?utf-8?B?VHlvVXN6M3luS1U5QkJNR2VYMUFJN0FvbDFSM1Zwb290ZG9IV0pWOGpiTTl5?=
 =?utf-8?B?OTBVR1J1QVlpRnkyWU5lUksrVk5obSt2aXBLYkRTRE4xTVhIK3hka1JFMjNh?=
 =?utf-8?B?YW5qSjhHWXRLWlBYTmtvdk5xMlN4ZVJ3TTNPNlNiVmsxNVovZjRvUEJSZXBy?=
 =?utf-8?B?K2JHdlFOeTJUTjVFWXBPNDlPd0RBYVZDaXA3U0RDTWRvSXVDQ0xDdWFQODFX?=
 =?utf-8?B?cWVjOGVPeFZuZFBKTnpHanJPNGhFSTArTmhmVG8wVjVhME9VaXFnUDc0ZlJi?=
 =?utf-8?B?V3ZZRDRVdVZsL2lpRzBrVmZIdW1TWFBTc3VjWkhSZzNpeGZ0dVN3eTVDTGdX?=
 =?utf-8?B?ZTk4VWFUN0h5M21neCtnU2xQazhHZDdDQnA1U00vVFdlTkx0TzVHK2ExUktF?=
 =?utf-8?B?K3ZNSkU2V1ZhWlFqeVdHVkVTTGpIR0k2a2dyeHFNdFlCN2E1eEExTHRrZVhC?=
 =?utf-8?B?aFNjRTArL1BFMjh5bFA3czk0VDhCM05mVzlWU1BFaFBCTjBsY3Jidm9pL0kw?=
 =?utf-8?B?dWFEYk5SQXNSem9lNnpRM2JHSFFtcnE0cHJHbVdIaE9NSVBVUHpjcExoY0pZ?=
 =?utf-8?B?ekFGaUNsdUM2aFBXMWRxNHAxS29LdHhmeGJMZlJlWGtFZFlTeEo2anc4MGdN?=
 =?utf-8?B?a3lpTnE5ZE9xR3lLOFJoamlxc2ROeWJ4Sjg2T2J6VzBmT2xQb2p5T3hITm02?=
 =?utf-8?B?cllWbllMdTBjeTRjdHlQOEV3UHdvMVJ4ZU5oTDlEa1ptbTN2aUNYNmpYTFdr?=
 =?utf-8?B?Z0tvOGxza3U0Z3ZPdERiZzUxK2piNTh6bG9YWmFJc3Fpc24xSCswb3NjampD?=
 =?utf-8?B?V2dZSk5abm5sN2NmQTMxaHBtRlpDbWhlVFlCTWZQSmhsQ0dhYVhneFlvYXVM?=
 =?utf-8?B?SHQzdytvVGFyTWNIdk5RK09Lenk2WG5zOGxubGw3Ri9McjZQOVJVOUs4OEt0?=
 =?utf-8?B?K2d0amtNL1FOcnVtSjZJWUpneFlkam56SDBHWXIxa2pWNldOU2IvK0tROElL?=
 =?utf-8?B?NmtTSVlhSmx5UWJPb2U1RXlrOGN3OVdxalBvZk1YUzdyWGN0R1lYK3pKNVQr?=
 =?utf-8?B?OW9BTElvbDFVaGhkeFYvbXNPY05DdHJRVmp5UENvYkZZMXBWalZCNmdmWDRQ?=
 =?utf-8?B?aWdWNm5wY2FWWWtFNk9TRnZJeFFIVXFIUTFvQWhuNE8weWZEVmF4S1Y2ZTlG?=
 =?utf-8?B?cGlEaDF1Nk9HL1NZYkhBWm1oVGlncnkxTTFqR0RhZkhqMkduZ3dNeFBMZzBT?=
 =?utf-8?B?YTFFWTZRc1NOQUpiTEJZTFdMbHQzb2hSSFhqRi92NjMxeW9QbVBmYmJUcVl4?=
 =?utf-8?B?NFN1QWVqT05SeXBhSVdYb29jMXZQZWQ1T3A3ME9ScHBBV2kxUnhYSzkreE9t?=
 =?utf-8?B?V2o5ZmY3bUN5eWYyQk13UVhGa3FpUkhjZFJMSEJHRHhsbUFiSWFTb3plOUI3?=
 =?utf-8?B?WDIyKzZKMElmR1B1ZFQ0cTZxQ2VaUVNVcXB6ZHpmWDFCSFU3eVU5WmVtbzl5?=
 =?utf-8?B?eWlrYlpwWm82cUJWK0grb1N2VUtMUlhPRi9NZTNJSWZNZHA4T1dMVnVWMW5X?=
 =?utf-8?B?UklCU3ZPeE1KNnRJb01zL21LZ2krZmwza2QrNnlGNFFwalBsdG1XL3RyMHVz?=
 =?utf-8?B?ZS9SUno0NDE0djlaN3dzZ0lBazhjRXN0ZEdVTUVGa0lDN1hWamFPRk1TVkFW?=
 =?utf-8?B?Y3VZbFltVWM3V2phaFd2eGNSOWR3Tk9YYXNDeW1vNktnTHdBQlQzVnBKcWti?=
 =?utf-8?B?UkRLeVIzZ1JvSVN5NExiajZaaGpjNERUY0tpSm0zYUFxb0pPMjB2b25aZGwx?=
 =?utf-8?B?WjN4dHB1K2QzMC9IS1dYMHkwUnhNd1FvL1lHdDg0QmRqRHl2M1FxU1NaUkpR?=
 =?utf-8?B?WHdWVmMyOW9yVitjVlNwcFlvN2c5dWF5QklqMlBtUXRhOTNPYTFKVVFKdGo1?=
 =?utf-8?B?WGMzMENBbjZQdEdwZXZJMFZaVVN2Tk83WTJ4NkxiTEhFOHA1ejBMUmZSQUNV?=
 =?utf-8?B?YkVCTTlMNURNQnhaOStsdVZEVHoydEhLWko4RlZOZ3BXOFBDUWhDWE1Uekd0?=
 =?utf-8?B?elNRakZZaS8rdVdWTWpKd05YZDgzRHZBelJ2VjFMbitYR1lkT2x0aGU0U2pz?=
 =?utf-8?B?c0dUd2xjTldlR0x5L2tJTDFuNS9RUi9BQ2VqYnZ5eFNEUWtMcTZINzg0TW4z?=
 =?utf-8?Q?HeON3mkMbxvUBCaFBz7YeKelMZyWszP4MDdfeQk7lQpJh?=
x-ms-exchange-antispam-messagedata-1: P5ms+qQiMpc+8ALX9gCFGDL2xreJp5uhbtY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFA54F0DE4B70945BDC2B763855F74D5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: I4cXpG5r9OfapoTVzIBtpldWAaWsJBxphY5mXOubAYidXrSCmLCqsTBoa4ojMy7FFFbaBq2D9Jb3vcFqIXmOvdtTwQI0h6l7QjvvNto4oZsQp3B2xJd2k57Vw2cZbZdWM/1vkVTAaB1dvX7Kx4leWvwxBrud2KxNk6j9a7ITrzK45MhGzCt7Qt/n7E49Fac42O4txyypVdHeUay5H6IWrY2vDLr8yhY/KYCWEGYuNJoFPURSDSWnaBgX19WahSQlUFRc1D5V4ScSVlQ4GO8BXpPmTI4wNeU1yDmhVu//zy0PblsRAbEqmJiodl3VzKv4aL8D+5/YWRmP0MwiOLKUwQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 738bd1c6-fa2f-450b-23c2-08deecefd494
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 21:33:14.0317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VeYNX6iPtPrarc7Pz/B1J/rXNIos+XrLn/Q0MEHhjwIXLZupuj+XuFet2O5OjZVpXyEEBIvBuN+rmguwtoH4EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8180
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA3LTI4IGF0IDEwOjMzIC0wNzAwLCBOYW1oeXVuZyBLaW0gd3JvdGU6DQo+
IE9uIE1vbiwgSnVsIDEzLCAyMDI2IGF0IDA3OjQzOjU4UE0gLTA1MDAsIFRob21hcyBGYWxjb24g
d3JvdGU6DQo+ID4gTWVtb3J5IHJhbmdlcyB3ZXJlIGNyZWF0ZWQgdG8gdHJhY2sgZGlmZmVyZW50
IHR5cGVzIG9mIG1lbW9yeSwNCj4gPiBzdWNoIGFzIHBlcnNpc3RlbnQsIGhpZ2ggYmFuZHdpZHRo
LCBvciBDWEwtYXR0YWNoZWQsIHRoYXQgbWF5DQo+ID4gYmUgcHJlc2VudCBvbiBhIHN5c3RlbSBm
b3IgcGVyZm9ybWFuY2UgbW9uaXRvcmluZyBhbmQgcmVzb3VyY2UNCj4gPiBjb250cm9sIHB1cnBv
c2VzLg0KPiA+IA0KPiA+IE1lbW9yeSByYW5nZSBkYXRhIGFyZSBwYXJzZWQgZnJvbSB0aGUgQUNQ
SSBNUlJNIHRhYmxlIGFuZCBleHBvc2VkDQo+ID4gdG8gdXNlcnNwYWNlIHRvb2xzIHZpYSBzeXNm
cyBbMV0uIE1lbW9yeSByYW5nZSBkYXRhIGlzIHJlYWQgZnJvbToNCj4gPiANCj4gPiAJL3N5cy9m
aXJtd2FyZS9hY3BpL21lbW9yeV9yYW5nZXMvcmFuZ2VYDQo+ID4gDQo+ID4gV2l0aCB0aGUgZm9s
bG93aW5nIGF0dHJpYnV0ZXM6DQo+ID4gDQo+ID4gCXU2NCBiYXNlOw0KPiA+IAl1NjQgbGVuZ3Ro
Ow0KPiA+IAlpbnQgbm9kZTsNCj4gPiAJdTjCoCBsb2NhbF9yZWdpb25faWQ7DQo+ID4gCXU4wqAg
cmVtb3RlX3JlZ2lvbl9pZDsNCj4gPiANCj4gPiBSZWFkIG1lbW9yeSByYW5nZSBkYXRhIGZyb20g
c3lzZnMgaWYgcHJlc2VudCBhbmQgc2F2ZSBpdCBpbg0KPiA+IHRoZSBoZWFkZXIgb2YgdGhlIHBl
cmYgZGF0YSBmaWxlIHVuZGVyIGEgbmV3IGZlYXR1cmUgYml0LA0KPiA+IEhFQURFUl9NRU1PUllf
UkFOR0VTICgzNSkuIE1lbW9yeSByYW5nZSBkYXRhIGNhbiBiZSB2aWV3ZWQgd2l0aCB0aGUNCj4g
PiAtLWhlYWRlciBvciAtLWhlYWRlci1vbmx5IG9wdGlvbnMgb2YgcGVyZi1yZXBvcnQgYW5kIHBl
cmYtc2NyaXB0Lg0KPiANCj4gQ2FuIHlvdSBwbGVhc2UgYWRkIGFuIGV4YW1wbGUgb3V0cHV0IGhl
cmU/DQoNCkhpLCB0aGFua3MgZm9yIHJldmlld2luZy4gVG8gYmUgaG9uZXN0LCBJIGhhdmUgbm90
IGJlZW4gYWJsZSB0byBnZXQNCmFjY2VzcyB0byBzdXBwb3J0ZWQgaGFyZHdhcmUgeWV0IHNvIHRo
ZSBvbmx5IGV4YW1wbGUgSSBjYW4gcHJvdmlkZQ0Kd291bGQgbG9vayBsaWtlIHRoaXMgKG9uIGEg
bm9uLWNhcGFibGUgc3lzdGVtKQ0KDQojIG1lbW9yeSByYW5nZXMgKG5yIDApOg0KDQpJIHdpbGwg
bG9vayBpbnRvIGdldHRpbmcgYWNjZXNzIHRvIG9uZSBhbmQsIGluIHRoZSBtZWFudGltZSwgbWFr
ZSB0aGUNCm90aGVyIGNoYW5nZXMgeW91IHJlcXVlc3RlZC4NCg0KVGhhbmtzLA0KVG9tIA0KDQo+
IA0KPiA+IA0KPiA+IFsxXToNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjUw
NTA1MTczODE5LjQxOTI3MS0xLXRvbnkubHVja0BpbnRlbC5jb20vDQo+ID4gDQo+ID4gQXNzaXN0
ZWQtYnk6IFNhc2hpa286Z2VtaW5pLTMuMS1wcm8tcHJldmlldw0KPiA+IFNpZ25lZC1vZmYtYnk6
IFRob21hcyBGYWxjb24gPHRob21hcy5mYWxjb25AaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+IENo
YW5nZXMgaW4gdjI6IA0KPiA+IC0tIEFkZGVkIGNoZWNrIGZvciBOVUxMIHJldHVybiBvZiBzeXNm
c19fbW91bnRwb2ludCgpIHdoZW4gcGFyc2luZw0KPiA+IMKgwqAgbWVtb3J5IHJhbmdlcyBpbiBz
eXNmcw0KPiA+IC0tIGluY3JlYXNlZCBNQVhfTUVNT1JZX1JBTkdFUyBzYW5pdHkgY2hlY2sgZnJv
bSA2NCB0byAyNTYgYmFzZWQgb24NCj4gPiDCoMKgIEFDUEkgTVJSTSB0YWJsZSBpbXBsZW1lbnRh
dGlvbiBpbiBMaW51eCBrZXJuZWwNCj4gPiAtLSBhZGRlZCBjb21tZW50IGZvciBNQVhfTUVNT1JZ
X1JBTkdFUyB0byBjbGFyaWZ5IHRoYXQgaXQgaXMgYQ0KPiA+IHNhbml0eSBjaGVjaw0KPiA+IMKg
wqAgZm9yIG1hbGZvcm1lZCBwZXJmLmRhdGEgZmlsZXMNCj4gPiAtLSByZW1vdmVkIGEgbGluZSBv
ZiBjb2RlIHdhcyByZW1vdmVkIGZyb20gdXRpbC9lbnYuaCBidXQgd2FzIGFkZGVkDQo+ID4gYmFj
ayBpbg0KPiA+IMKgwqAgdjEgZHVlIHRvIGJhZCByZWJhc2UNCj4gPiAtLS0NCj4gW1NOSVBdDQo+
ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdXRpbC9oZWFkZXIuYyBiL3Rvb2xzL3BlcmYvdXRp
bC9oZWFkZXIuYw0KPiA+IGluZGV4IGU5MGU1NDFmNTQ2Yi4uMDY2OTg5ODM2MmQ2IDEwMDY0NA0K
PiA+IC0tLSBhL3Rvb2xzL3BlcmYvdXRpbC9oZWFkZXIuYw0KPiA+ICsrKyBiL3Rvb2xzL3BlcmYv
dXRpbC9oZWFkZXIuYw0KPiA+IEBAIC05Miw2ICs5Miw3IEBADQo+ID4gwqAjZGVmaW5lIE1BWF9Q
TVVfQ0FQUwkJNTEyDQo+ID4gwqAjZGVmaW5lIE1BWF9QTVVfTUFQUElOR1MJNDA5Ng0KPiA+IMKg
I2RlZmluZSBNQVhfU0NIRURfRE9NQUlOUwk2NA0KPiA+ICsjZGVmaW5lIE1BWF9NRU1PUllfUkFO
R0VTCTI1Ng0KPiA+IMKgDQo+ID4gwqAvKg0KPiA+IMKgICogbWFnaWMyID0gIlBFUkZJTEUyIg0K
PiA+IEBAIC0xODkxLDYgKzE4OTIsMTMwIEBAIHN0YXRpYyBpbnQgd3JpdGVfY3B1X2RvbWFpbl9p
bmZvKHN0cnVjdA0KPiA+IGZlYXRfZmQgKmZmLA0KPiA+IMKgCXJldHVybiByZXQ7DQo+ID4gwqB9
DQo+ID4gwqANCj4gPiArc3RhdGljIGludCBtZW1vcnlfcmFuZ2VfX3JlYWQoc3RydWN0IG1lbW9y
eV9yYW5nZSAqcmFuZ2UsIGludCBpZHgpDQo+ID4gK3sNCj4gPiArCWNoYXIgcGF0aFtQQVRIX01B
WF0sIGZpbGVbUEFUSF9NQVhdOw0KPiANCj4gSSBob3BlIHdlIGNhbiByZWR1Y2UgdGhlIG51bWJl
ciBvZiBidWZmZXJzIGZvciB0aGUgcGF0aG5hbWVzIGFzIGl0DQo+IGFscmVhZHkgaGFzIGFub3Ro
ZXIgaW4gdGhlIGNhbGxlci7CoCBJZGVhbGx5IGl0J2QgYmUgZ3JlYXQgaWYgaXQgY2FuDQo+IHVz
ZQ0KPiBvcGVuYXQoKSB3aXRoIGFuIEZEIGZvciB0aGUgZGlyZWN0b3J5Lg0KPiANCj4gDQo+ID4g
KwlzdHJ1Y3Qgc3RhdCBzdDsNCj4gPiArCWludCB0bXA7DQo+ID4gKw0KPiA+ICsJc2NucHJpbnRm
KHBhdGgsIFBBVEhfTUFYLA0KPiA+ICJmaXJtd2FyZS9hY3BpL21lbW9yeV9yYW5nZXMvcmFuZ2Ul
ZCIsIGlkeCk7DQo+ID4gKwlzY25wcmludGYoZmlsZSwgUEFUSF9NQVgsICIlcy8lcyIsIHN5c2Zz
X19tb3VudHBvaW50KCksDQo+ID4gcGF0aCk7DQo+ID4gKwlpZiAoc3RhdChmaWxlLCAmc3QpKQ0K
PiA+ICsJCXJldHVybiAtMTsNCj4gDQo+IEl0IHNlZW1zIHRoaXMgY2hlY2sgaXMgcmVkdW5kYW50
Lg0KPiANCj4gPiArDQo+ID4gKwlzY25wcmludGYoZmlsZSwgUEFUSF9NQVgsICIlcy9iYXNlIiwg
cGF0aCk7DQo+ID4gKwlpZiAoc3lzZnNfX3JlYWRfeGxsKGZpbGUsICh1bnNpZ25lZCBsb25nIGxv
bmcgKikgJnJhbmdlLQ0KPiA+ID5iYXNlKSkNCj4gPiArCQlyZXR1cm4gLTE7DQo+ID4gKw0KPiA+
ICsJc2NucHJpbnRmKGZpbGUsIFBBVEhfTUFYLCAiJXMvbGVuZ3RoIiwgcGF0aCk7DQo+ID4gKwlp
ZiAoc3lzZnNfX3JlYWRfeGxsKGZpbGUsICh1bnNpZ25lZCBsb25nIGxvbmcgKikgJnJhbmdlLQ0K
PiA+ID5sZW5ndGgpKQ0KPiA+ICsJCXJldHVybiAtMTsNCj4gPiArDQo+ID4gKwlzY25wcmludGYo
ZmlsZSwgUEFUSF9NQVgsICIlcy9ub2RlIiwgcGF0aCk7DQo+ID4gKwlpZiAoc3lzZnNfX3JlYWRf
aW50KGZpbGUsIChpbnQgKikgJnJhbmdlLT5ub2RlKSkNCj4gPiArCQlyZXR1cm4gLTE7DQo+ID4g
Kw0KPiA+ICsJc2NucHJpbnRmKGZpbGUsIFBBVEhfTUFYLCAiJXMvbG9jYWxfcmVnaW9uX2lkIiwg
cGF0aCk7DQo+ID4gKwlpZiAoc3lzZnNfX3JlYWRfaW50KGZpbGUsICZ0bXApKQ0KPiA+ICsJCXJl
dHVybiAtMTsNCj4gPiArDQo+ID4gKwlpZiAodG1wIDwgMCB8fCB0bXAgPiAyNTUpDQo+IA0KPiBQ
cm9iYWJseSBiZXR0ZXIgdG8gY29tcGFyZSB3aXRoIE1BWF9NRU1PUllfUkVHSU9OUy4NCj4gDQo+
IA0KPiA+ICsJCXJldHVybiAtMTsNCj4gPiArCXJhbmdlLT5sb2NhbF9yZWdpb25faWQgPSB0bXA7
DQo+ID4gKw0KPiA+ICsJc2NucHJpbnRmKGZpbGUsIFBBVEhfTUFYLCAiJXMvcmVtb3RlX3JlZ2lv
bl9pZCIsIHBhdGgpOw0KPiA+ICsJaWYgKHN5c2ZzX19yZWFkX2ludChmaWxlLCAmdG1wKSkNCj4g
PiArCQlyZXR1cm4gLTE7DQo+ID4gKw0KPiA+ICsJaWYgKHRtcCA8IDAgfHwgdG1wID4gMjU1KQ0K
PiANCj4gRGl0dG8uDQo+IA0KPiANCj4gPiArCQlyZXR1cm4gLTE7DQo+ID4gKwlyYW5nZS0+cmVt
b3RlX3JlZ2lvbl9pZCA9IHRtcDsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+
ICsNCj4gPiArc3RhdGljIGludCBtZW1vcnlfcmFuZ2VfX3BhcnNlKHN0cnVjdCBtZW1vcnlfcmFu
Z2UgKipyYW5nZXMpDQo+ID4gK3sNCj4gPiArCWNvbnN0IGNoYXIgKnN5c2ZzID0gc3lzZnNfX21v
dW50cG9pbnQoKTsNCj4gPiArCWludCBpLCBlcnIsIG5yX21lbW9yeV9yYW5nZXMgPSAwOw0KPiA+
ICsJY2hhciBwYXRoW1BBVEhfTUFYXTsNCj4gPiArCXN0cnVjdCBzdGF0IHN0Ow0KPiA+ICsNCj4g
PiArCWlmICghc3lzZnMpDQo+ID4gKwkJcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICsJc2NucHJpbnRm
KHBhdGgsIFBBVEhfTUFYLA0KPiA+ICIlcy9maXJtd2FyZS9hY3BpL21lbW9yeV9yYW5nZXMiLCBz
eXNmcyk7DQo+ID4gKwlpZiAoc3RhdChwYXRoLCAmc3QpKQ0KPiA+ICsJCXJldHVybiAwOw0KPiA+
ICsNCj4gPiArCXdoaWxlICgxKSB7DQo+ID4gKwkJc2NucHJpbnRmKHBhdGgsIFBBVEhfTUFYLA0K
PiA+ICIlcy9maXJtd2FyZS9hY3BpL21lbW9yeV9yYW5nZXMvcmFuZ2UlZCIsIHN5c2ZzLCBucl9t
ZW1vcnlfcmFuZ2VzKTsNCj4gDQo+IFRoaXMgbGluZSBsb29rcyB0b28gbG9uZy4NCj4gDQo+IA0K
PiA+ICsJCWlmIChzdGF0KHBhdGgsICZzdCkpDQo+ID4gKwkJCWJyZWFrOw0KPiA+ICsNCj4gPiAr
CQlucl9tZW1vcnlfcmFuZ2VzKys7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJaWYgKG5yX21lbW9y
eV9yYW5nZXMgPT0gMCkNCj4gPiArCQlyZXR1cm4gMDsNCj4gPiArDQo+ID4gKwkqcmFuZ2VzID0g
emFsbG9jKG5yX21lbW9yeV9yYW5nZXMgKiBzaXplb2Yoc3RydWN0DQo+ID4gbWVtb3J5X3Jhbmdl
KSk7DQo+IA0KPiBJIHRoaW5rIGNhbGxvYygpIGlzIHByZWZlcnJlZCB3aGVuIHlvdSBtdWx0aXBs
eSB0aGUgc2l6ZSBhbmQgdGhlDQo+IGNvdW50Lg0KPiANCj4gDQo+ID4gKwlpZiAoISgqcmFuZ2Vz
KSkNCj4gPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gPiArDQo+ID4gKwlmb3IgKGkgPSAwOyBpIDwg
bnJfbWVtb3J5X3JhbmdlczsgaSsrKSB7DQo+ID4gKwkJc3RydWN0IG1lbW9yeV9yYW5nZSByYW5n
ZTsNCj4gPiArDQo+ID4gKwkJZXJyID0gbWVtb3J5X3JhbmdlX19yZWFkKCZyYW5nZSwgaSk7DQo+
ID4gKwkJaWYgKGVyciA8IDApDQo+ID4gKwkJCWdvdG8gb3V0X2Vycm9yOw0KPiA+ICsNCj4gPiAr
CQkoKnJhbmdlcylbaV0gPSByYW5nZTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gbnJf
bWVtb3J5X3JhbmdlczsNCj4gPiArDQo+ID4gK291dF9lcnJvcjoNCj4gPiArCXpmcmVlKHJhbmdl
cyk7DQo+ID4gKwlyZXR1cm4gLTE7DQo+ID4gK30NCj4gPiArDQo+IFtTTklQXSANCj4gPiArc3Rh
dGljIGludCBwcm9jZXNzX21lbW9yeV9yYW5nZXMoc3RydWN0IGZlYXRfZmQgKmZmLCB2b2lkICpk
YXRhDQo+ID4gX19tYXliZV91bnVzZWQpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBwZXJmX2VudiAq
ZW52ID0gJmZmLT5waC0+ZW52Ow0KPiA+ICsJc3RydWN0IG1lbW9yeV9yYW5nZSAqcmFuZ2VzLCAq
cjsNCj4gPiArCXUzMiBucl9tZW1vcnlfcmFuZ2VzLCBpOw0KPiA+ICsNCj4gPiArCWlmIChkb19y
ZWFkX3UzMihmZiwgJm5yX21lbW9yeV9yYW5nZXMpKQ0KPiA+ICsJCXJldHVybiAtMTsNCj4gPiAr
DQo+ID4gKwlpZiAoIW5yX21lbW9yeV9yYW5nZXMpIHsNCj4gPiArCQlwcl9kZWJ1ZygibWVtb3J5
IHJhbmdlcyBub3QgYXZhaWxhYmxlXG4iKTsNCj4gPiArCQlyZXR1cm4gMDsNCj4gPiArCX0NCj4g
PiArDQo+ID4gKwkvKiBBY2NvcmRpbmcgdG8gdmVyc2lvbiAxLjEgb2YgdGhlIEFDUEkgTVJSTSB0
YWJsZSwgdGhlDQo+ID4gbWF4aW11bQ0KPiA+ICsJICogbnVtYmVyIG9mIG1lbW9yeSByZWdpb25z
IGNhbiBiZSBhdCBtb3N0IDI1NS4gRG8gYQ0KPiA+IHNhbml0eSBjaGVjaw0KPiA+ICsJICogaGVy
ZSB0byBndWFyZCBhZ2FpbnN0IGEgbWFsZm9ybWVkIHBlcmYuZGF0YSBmaWxlLg0KPiA+ICsJICov
DQo+ID4gKwlpZiAobnJfbWVtb3J5X3JhbmdlcyA+PSBNQVhfTUVNT1JZX1JBTkdFUykgew0KPiA+
ICsJCXByX2VycigiSW52YWxpZCBtZW1vcnlfcmFuZ2VzOiBucl9tZW1vcnlfcmFuZ2VzDQo+ID4g
KCV1KSA+ICV1XG4iLA0KPiA+ICsJCcKgwqDCoMKgwqDCoCBucl9tZW1vcnlfcmFuZ2VzLCBNQVhf
TUVNT1JZX1JBTkdFUyk7DQo+ID4gKwkJcmV0dXJuIC0xOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiAr
CXJhbmdlcyA9IHphbGxvYyhucl9tZW1vcnlfcmFuZ2VzICogc2l6ZW9mKCpyYW5nZXMpKTsNCj4g
DQo+IFBsZWFzZSB1c2UgY2FsbG9jKCkuDQo+IA0KPiBUaGFua3MsDQo+IE5hbWh5dW5nDQo+IA0K
PiANCj4gPiArCWlmICghcmFuZ2VzKQ0KPiA+ICsJCXJldHVybiAtMTsNCj4gPiArDQo+ID4gKwlm
b3IgKGkgPSAwOyBpIDwgbnJfbWVtb3J5X3JhbmdlczsgaSsrKSB7DQo+ID4gKwkJciA9ICZyYW5n
ZXNbaV07DQo+ID4gKw0KPiA+ICsJCWlmIChkb19yZWFkX3U2NChmZiwgJnItPmJhc2UpKQ0KPiA+
ICsJCQlnb3RvIGVycm9yOw0KPiA+ICsJCWlmIChkb19yZWFkX3U2NChmZiwgJnItPmxlbmd0aCkp
DQo+ID4gKwkJCWdvdG8gZXJyb3I7DQo+ID4gKwkJaWYgKGRvX3JlYWRfdTMyKGZmLCAodTMyICop
ICZyLT5ub2RlKSkNCj4gPiArCQkJZ290byBlcnJvcjsNCj4gPiArCQlpZiAoX19kb19yZWFkKGZm
LCAmci0+bG9jYWxfcmVnaW9uX2lkLA0KPiA+IHNpemVvZih1OCkpKQ0KPiA+ICsJCQlnb3RvIGVy
cm9yOw0KPiA+ICsJCWlmIChfX2RvX3JlYWQoZmYsICZyLT5yZW1vdGVfcmVnaW9uX2lkLA0KPiA+
IHNpemVvZih1OCkpKQ0KPiA+ICsJCQlnb3RvIGVycm9yOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiAr
CWVudi0+bWVtb3J5X3JhbmdlcyA9IHJhbmdlczsNCj4gPiArCWVudi0+bnJfbWVtb3J5X3Jhbmdl
cyA9IG5yX21lbW9yeV9yYW5nZXM7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK2Vycm9y
Og0KPiA+ICsJemZyZWUoJnJhbmdlcyk7DQo+ID4gKwlyZXR1cm4gLTE7DQo+ID4gK30NCj4gPiAr
DQo+ID4gwqAjZGVmaW5lIEZFQVRfT1BSKG4sIGZ1bmMsIF9fZnVsbF9vbmx5KSBcDQo+ID4gwqAJ
W0hFQURFUl8jI25dID0gewkJCQkJXA0KPiA+IMKgCQkubmFtZQnCoMKgwqAgPSBfX3N0cmluZ2lm
eShuKSwJCQlcDQo+ID4gQEAgLTQyNjUsNiArNDQ1OSw3IEBAIGNvbnN0IHN0cnVjdCBwZXJmX2hl
YWRlcl9mZWF0dXJlX29wcw0KPiA+IGZlYXRfb3BzW0hFQURFUl9MQVNUX0ZFQVRVUkVdID0gew0K
PiA+IMKgCUZFQVRfT1BSKENQVV9ET01BSU5fSU5GTywJY3B1X2RvbWFpbl9pbmZvLAl0cg0KPiA+
IHVlKSwNCj4gPiDCoAlGRUFUX09QUihFX01BQ0hJTkUsCWVfbWFjaGluZSwJZmFsc2UpLA0KPiA+
IMKgCUZFQVRfT1BSKENMTl9TSVpFLAljbG5fc2l6ZSwJZmFsc2UpLA0KPiA+ICsJRkVBVF9PUFIo
TUVNT1JZX1JBTkdFUywJbWVtb3J5X3JhbmdlcywJZmFsc2UpLA0KPiA+IMKgfTsNCj4gPiDCoA0K
PiA+IMKgc3RydWN0IGhlYWRlcl9wcmludF9kYXRhIHsNCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMv
cGVyZi91dGlsL2hlYWRlci5oIGIvdG9vbHMvcGVyZi91dGlsL2hlYWRlci5oDQo+ID4gaW5kZXgg
NWUwM2Y4ODRiN2NjLi43NjUwMzc3NjI3NTggMTAwNjQ0DQo+ID4gLS0tIGEvdG9vbHMvcGVyZi91
dGlsL2hlYWRlci5oDQo+ID4gKysrIGIvdG9vbHMvcGVyZi91dGlsL2hlYWRlci5oDQo+ID4gQEAg
LTU2LDYgKzU2LDcgQEAgZW51bSB7DQo+ID4gwqAJSEVBREVSX0NQVV9ET01BSU5fSU5GTywNCj4g
PiDCoAlIRUFERVJfRV9NQUNISU5FLA0KPiA+IMKgCUhFQURFUl9DTE5fU0laRSwNCj4gPiArCUhF
QURFUl9NRU1PUllfUkFOR0VTLA0KPiA+IMKgCUhFQURFUl9MQVNUX0ZFQVRVUkUsDQo+ID4gwqAJ
SEVBREVSX0ZFQVRfQklUUwk9IDI1NiwNCj4gPiDCoH07DQo+ID4gLS0gDQo+ID4gMi40My4wDQo+
ID4gDQoNCg==
