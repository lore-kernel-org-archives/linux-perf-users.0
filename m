Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300B3296141;
	Tue,  4 Mar 2025 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106990; cv=fail; b=sC0/putuz60C+N3mHdjfd9bQcnquAqPd2xVIsS6pOTEkfyDKg0e3/0CnXFz9teP5mhANh8vvvzUPCdBwwdoqFls2e4aiz0vgsRdwxu+lFRl4zmSDfyEOdPQ2/dZtIO5lPP1ptbYUTHrwef19qTVTvJz8QVYx21DIY6MCRTl9uJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106990; c=relaxed/simple;
	bh=Pt7CBoSchCffefDoVOqXHc9DXpxxMFl5eVhGCpYx6dY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jLwhQv/x8cTHuyrw/Pxrbomp793QjH4/gQ4kODxV9peEkgUo4IVZq0QGOBzbAw2iD4w19K7hfmHZx+0IfqftoIUsRfdguoqSoaZDn7FeJ1f8S9mp1ezrK3A5S9tO8rXNuBqc/bX3gPxMel89bEX0xw8gb8J16v6hAUq4jXmgVaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZTlA0Vpk; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZTlA0Vpk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741106988; x=1772642988;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Pt7CBoSchCffefDoVOqXHc9DXpxxMFl5eVhGCpYx6dY=;
  b=ZTlA0VpkZdRaz3wdgk0ZIV40+qDTPuyxILbpuTSmGuzyK0O205Yjk3ZF
   Ftrqq10CGUJBLWu+vi4baXbDSe2ug5EuCoj5xGF9sYTWOcyuhqpDudrhO
   FYe1kJAZP3jpb2Im/wMWXQ122wLxDDNtfSOiHBqnjEG5Vn2W4CiT8yMZD
   7zLuFjv7ne3xCVreACi4RC0EMgQWOuijTQzLD2yStnnoihddCyWotJMuw
   yNZ2MuSeGPLkzuzPllZgu0c+189DpbAY9VDXXyA+FU9Fesld7VsFqL505
   9xT66ctoXi0uGnymCxK1QOWiMDmrgDuI43QbwaeidgBYy4lnEnP5zxLR+
   A==;
X-CSE-ConnectionGUID: nGuOCNWtSLaqSxI4ehjVvg==
X-CSE-MsgGUID: 4yZHwWsTREaL+PLV1508xw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="45686062"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="45686062"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 08:49:48 -0800
X-CSE-ConnectionGUID: UHy9c/kQTaG4qwz69a5JXw==
X-CSE-MsgGUID: UCNuRZTHTLyYBlmzAMnZOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="149209603"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2025 08:49:48 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Mar 2025 08:49:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 08:49:47 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 08:49:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VvfV30LdqaHtRleh/bhUmU5/Dt3h0oCBUsbrQXtEMuuagq+BDFGiuOyouGTcM9E0ROamIg75ugmmIeTkkApEPIEXAB01kKYmwdUPcYwZWeAUvjJMVNk4q4dMIpNCCLxVl81fE+R/PS0Brwzc7PfQ8C62yf2ulqXsUCMus7MePZxR8L4i+ZfqK/9E5A3Hj62BbJFandAnKnRcQxmRGMoutg5FOgc8LTKuJi45mMWj/uOaseZzPzHkOWAKIxyd4ZxwKRFUMtaYGFQWeAfls4BT0JdT9fJ6P6oXW6W2dro16eOkWbffqyEwJWAqNBdfQMyX+u7KVSdPLUlkZR+Enm8tyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pt7CBoSchCffefDoVOqXHc9DXpxxMFl5eVhGCpYx6dY=;
 b=oD4kBv2Iy/hvqhMuvbCwPTbEV8wGT5a5zYva2R0e+kepO54CDtwSKhtRUy0V8nPmj3WKu7JmH065N6HZudTpGYNsZTaqzejLKXDez/KMqRLg8vwkPj+FtrlvlL0sTWTSEUlgKt1uFxsx28xZ0ASfzK0o9nX18r5HJlshkuzgv2/TdqeTfivjUO2T2mdItQURJEKS0qZz+r21lBeGWP6Lsdaoom6AQtnmjtA9lGjgOPNdyGbDVxWsmBbgZQqmfRisGS8qSZ1IZ+xf1mtTxCBVuxFEZjJOegWgLqEREIGo6Z9wAie0sw1p9HKA8RqSFwZ7O8DMIfWwLfqwbUE76utY3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by DS0PR11MB7831.namprd11.prod.outlook.com (2603:10b6:8:de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 16:49:43 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 16:49:43 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org"
	<acme@kernel.org>, "dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"irogers@google.com" <irogers@google.com>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "Mi,
 Dapeng1" <dapeng1.mi@intel.com>
Subject: Re: [PATCH 1/2] perf x86/topdown: Fix topdown leader sampling test
 error on hybrid
Thread-Topic: [PATCH 1/2] perf x86/topdown: Fix topdown leader sampling test
 error on hybrid
Thread-Index: AQHbhl19t+37wnO7yUuPcRQJ2YtztLNjPh8A
Date: Tue, 4 Mar 2025 16:49:43 +0000
Message-ID: <12110f8591ad185e32746b7f8073afda6e99c337.camel@intel.com>
References: <20250224083306.71813-1-dapeng1.mi@linux.intel.com>
In-Reply-To: <20250224083306.71813-1-dapeng1.mi@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|DS0PR11MB7831:EE_
x-ms-office365-filtering-correlation-id: 7b94d944-3495-423a-c392-08dd5b3c9074
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?NGlDTlBQTkpJbCtiM2xBb3IzVFZSc3MrM2U2YjVUSUQ0SFlpMzBJbUhZVHdN?=
 =?utf-8?B?b0FNOW9YMXlVUEtaYjYxMzBuRDM1MERjSGVLODdFc09VWEZOTXpBTnJNU0U0?=
 =?utf-8?B?TkZ2UWlsSDFPQ2d4TFNEb0JFSnRXZmtQZ1VCUWVXZWYzOTNJRjRjOWkycXE1?=
 =?utf-8?B?YUVocDZ3UTc1cWxGQXdFTS9mOUlXL2FVazJHL25ldnNQQk9nbmhiQU56NGt4?=
 =?utf-8?B?d3kvRjdKZnZZY3IxR0lENkNVYldkQjJDRkZkdmJSUWdpZ2psWkJuUHRsRm9w?=
 =?utf-8?B?c3JwbGpVUnBIUzZuRytuQ0NXVkFvK1UwcXQvRHFrakRxMWxEbkRaNXZHa1dy?=
 =?utf-8?B?THpNLzM2N1FzTVRSRTBaa2NvdFlDYTl3MHUybE9IRmJLemQrYUFBR3lnT2Ru?=
 =?utf-8?B?Uml0bWNNUGF0VnlRSEhkT2hzNS9wWlZuRUZ3aGVGTlFNUTh3YjlFRlV4emly?=
 =?utf-8?B?U0Z6ZnV4a2JTbUUraTRwa0NPQVJEcVpSRVJORi82anFSL1UxZlpJNWo2ZVRr?=
 =?utf-8?B?SklEWHFQaE8wUm0vcXFCT0MvMm12VURzVzR0K0lYQ1Z6Q01raVptODlNeW0z?=
 =?utf-8?B?RHVIT1lROElmWm5SajZuWWsvQVFweWl2blJHd0VJWUVMS3MyZ0V5OStwTjA5?=
 =?utf-8?B?Uk5NKzVSZ1BBMkU4Q1VRQ1BQMXdyRHNjSDJhTDczMXBKQmg1YTQrSW5ubkND?=
 =?utf-8?B?UWF2dVRWZXdMT0wwYUtMemZqUW9zUk5WTS9oQ2NDYzZqS1Z1UHNsczlSQzlk?=
 =?utf-8?B?d3hXZFRCbmplWU5WazdkNGhjUDhweFIzRkl1WmR1Qnp3UkdhelNqZEdtWVht?=
 =?utf-8?B?NGNzbDhSazh4ckc2L1dzdFcvK0hRcEovN25ueUVoUHpUK2R6b21QQ1BLYURa?=
 =?utf-8?B?a1ZhNk9TM2ExZ3prUnJLTG44U3YzZEVGcXpFM3d3d2VVUmthRW1JK2FTSTc1?=
 =?utf-8?B?dDFqYS9uY09ncGhsVDhlWml5dHRlUjFOZUM0azJiZ2xGYnhkcG5weTMxMDBv?=
 =?utf-8?B?NzRHNFM2WFNaNmx5QjdnMmIxU0h0bkErYk45dUxyN2c3YldzRzlQMGxQSkJu?=
 =?utf-8?B?QmwwK3pJeE5VdXFQSUtVUHp2NGRvcXp4NDYvdkdGbG5kalV4cjQ2OGcyckdP?=
 =?utf-8?B?aEQweFVhTFovSEhPczBCUm0rWXZzV00wZklxaTFIeEk4TkkwT1p2SitjUGVl?=
 =?utf-8?B?RnRrV0xpM0l6MkI0Um1GdVZGK0pKb3ErbGF3VXlsWFdsSFhlaGNIWWhBTXZx?=
 =?utf-8?B?YXM1Y3AxOEtteXpMNC8yc3N0ZWdjZituWVB3bXMrbFdFK2ZnaVdmSGtRRFV4?=
 =?utf-8?B?VXVaUUNtNXdCVDBWR0VDUmxicmRETGtnQjg1TkVLMGlsaStrVUtES08yWElT?=
 =?utf-8?B?NWtVdHFJZ1dPTmhiRUdlVm1UREhQWFFCUDBDTjJmTW03OENuY25YeXFpTlk5?=
 =?utf-8?B?Vm9pTXJNeUpjcXR4UHVHcXFGVlBsMGV3RGVSV1pWSkRwb0hYSUtEelZzeGcy?=
 =?utf-8?B?MWVVTDFxMnRlK01Oc3dqK3ZXS3JTNHdBLzJXR0ZMMUR0WUd6UnN6VUdxNXpZ?=
 =?utf-8?B?MFhlb1Z5MmdOaW9YWlVmN2tJMjFzTStybVVyZ0R4Q0xnZ3hMaDF1YzA1MHBI?=
 =?utf-8?B?UVNLQmVCUjhWd1FGM0I2ZWpWSzJqVitHdnlVZGQ2azVUdm4wV2FuZUYvQVl6?=
 =?utf-8?B?cXNIN1F1T29UQytZWTJJS0JQc2FpME9zVmkvRHJCMGw1YjJYTDBydkt1ZmtW?=
 =?utf-8?B?YThRb0xPajNQWkNUcGJ3aWVPSW1lcGxuanU0cHRVMGVvc0dON21ZZ1ZSMmNn?=
 =?utf-8?B?VWI4WHBnUDNVU3BLOW43NDBlUk5xMkxGOEsrNmZoRkI2STlBNERVVFNOWllN?=
 =?utf-8?B?aVJnbFlrcnVObmFMZ3BWM21wcERkV2RoZWlFTE1uNUtYMUFpRG11bTFNTFpM?=
 =?utf-8?B?ZjFvM0NqMXZXcVJmaVQzS1YvNHA2Mjk0RHhHWkJzVWpNRktoVGJ5NXVCMERF?=
 =?utf-8?B?Z1ZSa1JxL2dRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1JwamdJSngvZ0dTYnQyM3dUOUdkTWVKRnRqZ3pCbDBIN0NPT3ozVVdZV3JE?=
 =?utf-8?B?YmFaQXNZY002MUJuMmxUYVlsNFlEWmFpdjhjMkNPM0R0YkE3cy9UT1dXZFFI?=
 =?utf-8?B?Mk9UN0ZVQTBjWmpmOEVTQ2hWQm5Rc2lXb1lGREwvcVdobDRPNXNldjZQdXVE?=
 =?utf-8?B?aXUvbUJoTGdROG1lU3hKdDlsMGg2dlcxLytHeHBYNld5aUdSMlUzUFdFTXhV?=
 =?utf-8?B?ZGMxMVcxQmtXMDQ0b0xqMm4raWZSVHpFSi91UFZWNFhOT25WRGtpZFBoZGE4?=
 =?utf-8?B?Vzl5NDUrdlJDVytTNmhuN1B0OEgzRmlxbWFpY1pVQzNMQXJZZFNIR1VmZ20w?=
 =?utf-8?B?SlAxRnFYajd4VXE0eGxPYmVwUTJxOTZoZk96Wk0zY0ZhbXkrL1FsWmg4RDZX?=
 =?utf-8?B?RUJkRDNsdW9TNjZtUGxhVEZFZHRBT1hSMEZDQlZHL3I4WFM3Szd0akdVdlJO?=
 =?utf-8?B?NWwrbTNNS3JCM2g3QzB3cmVGYnJyZGdabTdLWkJ2dWFWUUdFaDQ4aGJlZHhQ?=
 =?utf-8?B?ZGtGcUJvSmYxdUd0MnZ0ZkRFTVlPQmtRYmFxa0QveUZsUGppWTJ1WUt0Y2VD?=
 =?utf-8?B?cm1aTG9ydEVpNFp6SVp5TUl0RFQvb3VJV1VZMEJSYlc5RUNYOEFHVVpveXR3?=
 =?utf-8?B?YjRYM25yYTEzQ21pK0V4bFVCelRvdkg1dWtPWkwyV3c0aU90WHJ1MVYzS010?=
 =?utf-8?B?bU5HVDVkT0pZNE1TUC9sUGtvcnE1dWtRVW9acmpNR1BSb0JtcUh4YzVncVVn?=
 =?utf-8?B?NUw3N1l6ZC9CajZIZVd6R2dGSHo3NDBtd2FOTVNDbE03M2REbWpaRldTR0VN?=
 =?utf-8?B?UDlWRW1TQlc2bk82RHFmelRCRmRPZ243eE9zV1M3Q1dmTWlTK3JncnhmZXlo?=
 =?utf-8?B?MGIyTkVoR1dOcWNHU3UxQjJ2MVM5c09YNWdOY3Y2UlZBT1BrOWFVdGtPTzFw?=
 =?utf-8?B?Q3NEN21IbFJLRE94M3V2RXNNc3FISG9aU2Y1ZlhHejlKbkRNOU1yR0g2MzVt?=
 =?utf-8?B?QmhHYUhzNmo2Mjl0SENVZkhEUHhWb0RWY3VDMFRhclBySThkMjU0dHQ4SE5M?=
 =?utf-8?B?cmVEclo1akxKdm9CVGRkUjNDcytjZWxJVU9KdXBJeHJpK2dFNWdvK1FiZ0l0?=
 =?utf-8?B?bUgrenRHcTdaWWdhRWVuS2xxQ2RqK3hKVko5c2xuWkFuekNXZm1VNGpCUFRR?=
 =?utf-8?B?SmZvazBJSktrT1hlWG9ySjIrakljek8wa3pMRkcxS043MXd1ZVVlM1FPYW5z?=
 =?utf-8?B?QlA5YU81V2dVZnF2dmdsQmdsTTRSMFJLMTdqSVNxK3JrTjczUk8zbWdJQXRG?=
 =?utf-8?B?QXYwamsyQmhQVm9qT3NxWFBaQTgvNVZ1RFd2MUtVWlB5VFBWTnU2WW9YbUlD?=
 =?utf-8?B?K0xNNTl5TmduamI0QUUvTzFqWnRsZkRyY2xXTkpDMUZaL1pBNjBkbWY5WWM2?=
 =?utf-8?B?eTNMNElTTk95VHFlWWlqeGJIbUpjMlMyZzJiM2Z2RHRHV212Nko2TnRwR3dq?=
 =?utf-8?B?R2NiL29PTEZKaFhHdkhxYXBudUI1MG55TWVkNm55OFRuZm9HSFNBRzNMMkZ2?=
 =?utf-8?B?WStCUkthM2F3QXZGdFFINmxUS1pweE96QkRoblZDTlg2dUhkQjEwR3FyWUxJ?=
 =?utf-8?B?WlVSYUNRKzB6UG12R2NUN3R4cVhuRkZyUkUzSmJTQlIxalZJcFZJSnAwcVpu?=
 =?utf-8?B?VTBnbWk4QU9FaUt2MnlzUXk2T2xYWVJEcW8wUUg2djBKMldVSGRITWRIMmVG?=
 =?utf-8?B?UmQ1T3lzRWxYVWlLV3hxR2FNZHVaVmI2Y29HODNRZ2o4RXFibXpoVFZvWldV?=
 =?utf-8?B?bFU4OWkxQlJvZHJiK0RINW5HOXp6VnRXK3J1d0xuaU1GYlFGQ1RLTWtCTHg3?=
 =?utf-8?B?Rk14bWd0b1pPWGVwVW01Z3lCVnlHU1kxZHJiUGE2bUJudzNqMEFZNVJILzlB?=
 =?utf-8?B?MXdTZHBrNGRoMnc5SmpHYVNQM3VURFRTRzBJbmhBM21XWE9KZUVKakdCQURs?=
 =?utf-8?B?UkliTWMwS1lBV0l4OUVQRjdUZTVkcHFFNWhlRXdBOWE0U1lIandZNnFDRWk0?=
 =?utf-8?B?S2ViYXJCcmRNdHlodzJQM2hUejk4V3draUhYMWV6WkYxSnVkSGtnVU1YUDRw?=
 =?utf-8?B?VWtHOFVaQTZ4Tzk5U0JpQ29Rcm5ZL2JEcE9rS1d1bktLMGRaMG1SNEJoNWQ4?=
 =?utf-8?Q?eogVsrWMByczUhwYsKoeU/s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4CA393BBBC4F54A874EEA2492F92D7E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b94d944-3495-423a-c392-08dd5b3c9074
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 16:49:43.5578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +InfuF6wA6j9p4dhPbCzV1Y7i/dYqZrBhkOzT2u8A1LIw8rRi6kFgvkOQtjEZOUWZcVWx97KaokwBa/JyNUC3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7831
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTAyLTI0IGF0IDA4OjMzICswMDAwLCBEYXBlbmcgTWkgd3JvdGU6DQo+IFdo
ZW4gcnVubmluZyB0b3Bkb3duIGxlYWRlciBzbWFwbGluZyB0ZXN0IG9uIEludGVsIGh5YnJpZCBw
bGF0Zm9ybXMsDQo+IHN1Y2ggYXMgTE5ML0FSTCwgd2Ugc2VlIHRoZSBiZWxvdyBlcnJvci4NCj4g
DQo+IFRvcGRvd24gbGVhZGVyIHNhbXBsaW5nIHRlc3QNCj4gVG9wZG93biBsZWFkZXIgc2FtcGxp
bmcgW0ZhaWxlZCB0b3Bkb3duIGV2ZW50cyBub3QgcmVvcmRlcmVkDQo+IGNvcnJlY3RseV0NCj4g
DQo+IEl0IGluZGNpYXRlcyB0aGUgYmVsb3cgY29tbWFuZCBmYWlscy4NCj4gDQo+IHBlcmYgcmVj
b3JkIC1vICIke3BlcmZkYXRhfSIgLWUgIntpbnN0cnVjdGlvbnMsc2xvdHMsdG9wZG93bi0NCj4g
cmV0aXJpbmd9OlMiIHRydWUNCj4gDQo+IFRoZSByb290IGNhdXNlIGlzIHRoYXQgcGVyZiB0b29s
IGNyZWF0cyBhIHBlcmYgZXZlbnQgZm9yIGVhY2ggUE1VDQo+IHR5cGUNCj4gaWYgaXQgY2FuIGNy
ZWF0ZS4NCj4gDQo+IEFzIGZvciB0aGlzIGNvbW1hbmQsIHRoZXJlIHdvdWxkIGJlIDUgcGVyZiBl
dmVudHMgY3JlYXRlZCwNCj4gY3B1X2F0b20vaW5zdHJ1Y3Rpb25zLyxjcHVfYXRvbS90b3Bkb3du
X3JldGlyaW5nLywNCj4gY3B1X2NvcmUvc2xvdHMvLGNwdV9jb3JlL2luc3RydWN0aW9ucy8sY3B1
X2NvcmUvdG9wZG93bi1yZXRpcmluZy8NCj4gDQo+IEZvciB0aGVzZSA1IGV2ZW50cywgdGhlIDIg
Y3B1X2F0b20gZXZlbnRzIGFyZSBpbiBhIGdyb3VwIGFuZCB0aGUNCj4gb3RoZXIgMw0KPiBjcHVf
Y29yZSBldmVudHMgYXJlIGluIGFub3RoZXIgZ3JvdXAuDQo+IA0KPiBXaGVuIGFyY2hfdG9wZG93
bl9zYW1wbGVfcmVhZCgpIHRyYXZlcnNlcyBhbGwgdGhlc2UgNSBldmVudHMsIGV2ZW50cw0KPiBj
cHVfYXRvbS9pbnN0cnVjdGlvbnMvIGFuZCBjcHVfY29yZS9zbG90cy8gZG9uJ3QgaGF2ZSBhIHNh
bWUgZ3JvdXANCj4gbGVhZGUsIGFuZCB0aGVuIHJldHVybiBmYWxzZSBkaXJlY3RseSBhbmQgbGVh
ZCB0byBjcHVfY29yZS9zbG90cy8NCj4gZXZlbnQNCj4gaXMgdXNlZCB0byBzYW1wbGUgYW5kIHRo
aXMgaXMgbm90IGFsbG93ZWQgYnkgUE1VIGRyaXZlci4NCj4gDQo+IEl0J3MgYSBvdmVya2lsbCB0
byByZXR1cm4gZmFsc2UgZGlyZWN0bHkgaWYgImV2c2VsLT5jb3JlLmxlYWRlciAhPQ0KPiDCoGxl
YWRlci0+Y29yZS5sZWFkZXIiIHNpbmNlIHRoZXJlIGNvdWxkIGJlIG11bHRpcGxlIGdyb3VwcyBp
biB0aGUNCj4gZXZlbnQNCj4gbGlzdC4NCj4gDQo+IEp1c3QgImNvbnRpbnVlIiBpbnN0ZWFkIG9m
ICJyZXR1cm4gZmFsc2UiIHRvIGZpeCB0aGlzIGlzc3VlLg0KPiANCj4gRml4ZXM6IDFlNTNlOWQx
Nzg3YiAoInBlcmYgeDg2L3RvcGRvd246IENvcnJlY3QgbGVhZGVyIHNlbGVjdGlvbiB3aXRoDQo+
IHNhbXBsZV9yZWFkIGVuYWJsZWQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBEYXBlbmcgTWkgPGRhcGVu
ZzEubWlAbGludXguaW50ZWwuY29tPg0KDQpUZXN0ZWQtYnk6IFRob21hcyBGYWxjb24gPHRob21h
cy5mYWxjb25AaW50ZWwuY29tPg0KDQo+IC0tLQ0KPiDCoHRvb2xzL3BlcmYvYXJjaC94ODYvdXRp
bC90b3Bkb3duLmMgfCAyICstDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi9hcmNoL3g4Ni91dGls
L3RvcGRvd24uYw0KPiBiL3Rvb2xzL3BlcmYvYXJjaC94ODYvdXRpbC90b3Bkb3duLmMNCj4gaW5k
ZXggZjYzNzQ3ZDBhYmRmLi5kMWM2NTQ4MzkwNDkgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3BlcmYv
YXJjaC94ODYvdXRpbC90b3Bkb3duLmMNCj4gKysrIGIvdG9vbHMvcGVyZi9hcmNoL3g4Ni91dGls
L3RvcGRvd24uYw0KPiBAQCAtODEsNyArODEsNyBAQCBib29sIGFyY2hfdG9wZG93bl9zYW1wbGVf
cmVhZChzdHJ1Y3QgZXZzZWwgKmxlYWRlcikNCj4gwqAJICovDQo+IMKgCWV2bGlzdF9fZm9yX2Vh
Y2hfZW50cnkobGVhZGVyLT5ldmxpc3QsIGV2c2VsKSB7DQo+IMKgCQlpZiAoZXZzZWwtPmNvcmUu
bGVhZGVyICE9IGxlYWRlci0+Y29yZS5sZWFkZXIpDQo+IC0JCQlyZXR1cm4gZmFsc2U7DQo+ICsJ
CQljb250aW51ZTsNCj4gwqAJCWlmIChldnNlbCAhPSBsZWFkZXIgJiYNCj4gYXJjaF9pc190b3Bk
b3duX21ldHJpY3MoZXZzZWwpKQ0KPiDCoAkJCXJldHVybiB0cnVlOw0KPiDCoAl9DQo+IA0KPiBi
YXNlLWNvbW1pdDogNGJhYzdmYjU4NjI3NDAwODc4MjVlZGEzZWQ2MTY4ZTkxZGE4YjdlNg0KDQo=
