Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71E5280338;
	Tue, 22 Jul 2025 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753208105; cv=fail; b=VVesSF95pf63s7yBD3LBiSbdDCmT7lqpWT9gOJDoJf0et7Tcl8pOv4v93/vVU3k/NuWS+BQYVtsrRQd/dyKiun14MKBD5EKARZEY3F7fm88VALHEJQsGxhvXPC6mWXizX3hRy+z+hh0i8fpHnwAcgnOh4uhOlQcF+T+0bNdSkds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753208105; c=relaxed/simple;
	bh=ZXMhcvYqU+9ISj18ChHS5hebAsaakqg+HNJf6bUM01E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EijDuBvOKY1kqw3OIZuk57beAnPQ1zUJKrj0mCUyGKri8C1xDlNL7q49A3O7Z5w8E7CQpDG9GPZFy6biKlyTfpqigqo9HuB4nIX6tvot4Q5jh7oFmDAXGwTFV9KZygDJu47x2OBo2EJ/Hq3fNP4fVoBa5WhAOH7utzDedIEOu7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iTlT4xWm; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iTlT4xWm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753208104; x=1784744104;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=ZXMhcvYqU+9ISj18ChHS5hebAsaakqg+HNJf6bUM01E=;
  b=iTlT4xWmg1zg5WJWUjyQWLL+Y73DyKueaROGHtFb3ZLagWy6oKAVaI+/
   qG4xTlBwaeXv/ste327LrnScQRZ9XZRvJqX6uUeJgzHQKnPN9yJVoGHSb
   K04KmSRe49F//Rm9J5zP6wA7yzTUPEJaS6Ygn8089R9cxlRjSIO7TvgoJ
   pv3/cPvRFJ51h8501PEufYoXcjt2ISkdwMy3lByASnw7iba/85GK/+zY9
   03p6T20MWnhBq08gtfoD4VhomssFUXJs7yBZfOL7kNzGoiFSmj/3mfrBl
   jyfO+6fxpnPcrSDsupDyOIcInz+6es/8spWCwVV52mVePxUbcI72uDVtr
   w==;
X-CSE-ConnectionGUID: i9XchEXqS9CgeluaHRlNKA==
X-CSE-MsgGUID: ZUj93c/nT728n3CzbShbwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55178333"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="55178333"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 11:15:03 -0700
X-CSE-ConnectionGUID: eB0s4WUIS8ePNHwW2YeKig==
X-CSE-MsgGUID: 5UoQ0nIeQgKd/nBbGfUiCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="159769821"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 11:15:02 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 11:15:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 11:15:01 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 11:15:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flbyPuSRIQVxo/njTYK7SPY467oeO8q6Cn2kqMpKIQ4nVcNiJyBYpNJDpl2eSliXxyscys9t3RhiuG4Xx6zyex3eefAHjS2rnKzA5x+QZYPYkkcikDR9nTPoI3iD6KO2zCh1td7LfKfCXQO0gxKI/txR2nP/J6ACBMiW09jwpw/QQTns18ojOBDKimF6TdH0rvTSi/fu/d281qqevonmrj6iLfdzEXYLweuZopDB87jRK+TroE7u9ElwI2pnyQAzvZj+QIwEoPjOz5/J702Np2CHjpZRQXM2JjWm9StxUMnxR7c2DU5a6l0k69uI5RvBVCpoN36gFsT3PUoY7GU6gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXMhcvYqU+9ISj18ChHS5hebAsaakqg+HNJf6bUM01E=;
 b=yg50R7CaSKyJZtJyuZ/VVG+g8XPOevL9AGKjLL2TDTO9hAmmOZ0/LtTUiDLleEtJdltPaCCkNXXpgZurnlyI+KTwYGUCF0MASgKRYRbkvt+q+UExkFWOjhTbjbZdlmddGn6VZ0kRhu+VOG55a/oMIx5hfvmyKrXvnMDD975KAoND4PJ8rY4YckNqWgeSGbHeSh0ZgL52ZcIblLa5mypWCYKB4Pu8FS2J9HZi+ufcemZKw08RZZZzw4PtA0xic6c0M+TGb1elybJon6AhGOd+AQvxB/rDNpk2p40J4lZYPWh5YkQUj7xis4562BaEzT4iZjRELJGhxpWcC2I3GqaGLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by DM3PPF2DEFDE2DF.namprd11.prod.outlook.com (2603:10b6:f:fc00::f17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Tue, 22 Jul
 2025 18:14:30 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%5]) with mapi id 15.20.8964.019; Tue, 22 Jul 2025
 18:14:30 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "linux-actions@lists.infradead.org" <linux-actions@lists.infradead.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"Biggers, Caleb" <caleb.biggers@intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"irogers@google.com" <irogers@google.com>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "Wang, Weilin"
	<weilin.wang@intel.com>, "mani@kernel.org" <mani@kernel.org>,
	"acme@kernel.org" <acme@kernel.org>, "afaerber@suse.de" <afaerber@suse.de>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "namhyung@kernel.org"
	<namhyung@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 00/19] Intel TMA 5.1 metrics and event updates
Thread-Topic: [PATCH v1 00/19] Intel TMA 5.1 metrics and event updates
Thread-Index: AQHb+F+adbdzJjC7S0+g2VgHvTDUubQ+eC6A
Date: Tue, 22 Jul 2025 18:14:30 +0000
Message-ID: <e09bab119c9fb6b0c2b5bcd39c6f2b508445ca37.camel@intel.com>
References: <20250719034515.2000467-1-irogers@google.com>
In-Reply-To: <20250719034515.2000467-1-irogers@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|DM3PPF2DEFDE2DF:EE_
x-ms-office365-filtering-correlation-id: 9a4735e7-9b75-4e0e-ffee-08ddc94b9a5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SEp6SUFxR2ZpbEFVZDRXRjlCMU93UUNFOWJsOEJoNmZIN1RkRHdwblhLUWRY?=
 =?utf-8?B?ZDBVVHAreVpjVU40bHhVYWpQZW5RRGFkbUJYSmtMenFrYjhxRXlLdU51UTBi?=
 =?utf-8?B?WHI2RDgwVUNnUU5DNFNsaDE2M3Q1UGpxVVpGR1lZcjBjUlpwbTZ5dkVwRXYx?=
 =?utf-8?B?K1B4WVhvQThjY1hVcDNKdzFVRVVnNzVsTVlDNGZ2ejM1Y0hWUXRLY1U3UnlF?=
 =?utf-8?B?OUtLbUNiNWhyT0pZTVdENUNOYWtseUVUMTVSaEp6dTRQN24zRDltYThHRnBv?=
 =?utf-8?B?OXBvczFYcGZFMC9MbTZaRFJuVzhLTjdxL0VrQStoWjFkRmR5YjJoZkh3ZE5O?=
 =?utf-8?B?UmJTaEM0TnM1RkVmaHNVY29RL296U3ArT1FtNFpQVVBOaExzdWdnOXZPTWtn?=
 =?utf-8?B?TEo4azRiS2tiT2RWak9iWkVaZzFOSzdUUVhhUlpydEczQ0NvcHZpNHF0QjJQ?=
 =?utf-8?B?WTllbzRTSHRMZFlyQ21jUU9qYWpnczZLSnFQaGRoU3JLS1N0K0RqL202MjBv?=
 =?utf-8?B?UGluNlFnenZYYXUxdlZwQitnbUlCN1V4NG9Td2c5UW12Wi9WQkFoMmo1dzIy?=
 =?utf-8?B?WkJMb2pnSk1PMUtrT0tkOVUrZktKNmVjODJwZXIvaGFiUThvTWdxR1c5NFR3?=
 =?utf-8?B?ayt2TjJFVVlnb242M1BKQmZqUWs1SjJkOE0wd1JRMHRUVlord05uNEliamV6?=
 =?utf-8?B?aHhkRVRIK3VhVHpjdmhjQlRaMDA5NUFoclVwQ21uaTZTRnZQZ2pPaFNoeTNv?=
 =?utf-8?B?ZUkzZDB4ZTJaRVhjVmRvNkpSaXlwRUVkYldlZUtBd0MzYVVnMmxPTlRUUHU0?=
 =?utf-8?B?dW11RE1YeXh1aWhIWG45b050OWxtM0xNYi83ZTQ2dHhyVXQ0K3diQ0pPZzhq?=
 =?utf-8?B?ZWd6bEFaWE5yTU5KY0RTSVZFaXVxNHNIZnpDckh6Y3p5M1ZFaGhUSC90aXJ5?=
 =?utf-8?B?SU9QTm5qTS8yLzMvSmdDRklPbHA3WGFCY3YzSHgwYWRVSFlHS0FjaVpBQVp4?=
 =?utf-8?B?aVgydzdjTXZVaEd0Vmh2UUVCUEd0c2hVUmVLV2g5UCtvRm4yaXRpMUFPck9o?=
 =?utf-8?B?Zm15OFNDNHE3QUxGZWYzZWpDeFRLTGtCV3RhUHZGVlJYRUpoMTRYMVBDUUYv?=
 =?utf-8?B?VkFObFk2R2hjWEkrRHl6UUhnRE1Xd09HaTBEakc0ZnkyNjROeHFxQUh4WUds?=
 =?utf-8?B?MmF5Q1hnQUZ2L1JnVVFjL3pvRlhHaytmZDNSa1VicGt2bFVsQU1Lblp2WXV6?=
 =?utf-8?B?UU9OaDdrMEJ6RThsZ2p4Tk5MT3BzKzAwNzhxcFhFSVlablRhcTIzRWlwMllV?=
 =?utf-8?B?ZDdyMVVna1pMekZPQ0J5TFovUkFsZXQ4N0VObjIvMGgwcktYQ3FvQTRTak9S?=
 =?utf-8?B?bHlWYk14aTF4ZVFjb2E5UUpVYzdObmJjT0FpV2l3cldXOUZnQ1dpWlNJWXZZ?=
 =?utf-8?B?R0pEbTM3MGl4YUpobnFBWnc4cDA3OS9rbjRicjZ1bW1sUkVGV2F2Zjd4MjAv?=
 =?utf-8?B?UGxnTWNXS2FCbzcyOGhnZ3JQODBpUnM4eWFiTnZ3NUp6aWV4cGVwdzRKT2dT?=
 =?utf-8?B?MnVJSnQ2WFp2ZEpIaFoxQSsxSENyaEZNd3FDTnhvMnF5UW9xdmRGVWNvcWFB?=
 =?utf-8?B?R3JmUXZpQ0RldWt3K0lvNWdtKzZqT2hEZ2VmdGkvbU1KTDVIWis3K2x5dkky?=
 =?utf-8?B?eUo1ME1xSGZvWWtkSE1CaUNhZzlTc1VLTlVMdUphWW4yYkl6d3BBQk05K1dX?=
 =?utf-8?B?Tk1ZUWJybkR4eG1nU253NTZzTVFSd01wVDNUVlg3TVNCUjFqRzlLOHRqN2E1?=
 =?utf-8?B?RGc2aktMeFJyMUdtQURjSER4M1lHQk1Vdk1yWDdjdytmLzAwWkdzQzY1ZjlU?=
 =?utf-8?B?SDQ3b3hrQnNrZzQyOUgvV1g2bEVXN3ErSFgwaTBCVVRwWVBGQk9maWs5MzEz?=
 =?utf-8?B?a1AyaUg1YnlIVDBHWnVlRUdZM0ZNTEpvYkhGMklwK003aDcyNC9Tdk5rc1hp?=
 =?utf-8?B?WjlkU3pKdEdlVXNxNGc0SUhuY1NzWXVtelZyd1VxL1hZTHpRWTRuZngwb0xy?=
 =?utf-8?Q?7HXKix?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0RieW9pM2I3U01JWitlbUhRUUhHeGNQMzU4bnBjMVNSM0p6YXlHN0k1S1I3?=
 =?utf-8?B?d0NtWHdXWXIwVE1ScFhvaDFWcTVnOE5QeXlNeEo1MVkweitEbktmYkVBMG1V?=
 =?utf-8?B?TFA3Wkc2TERzL255TDE3VGlPTVlEazMvWERvWVFqL0paMjBEeVZsRzV4MU1a?=
 =?utf-8?B?NXNOZ2dpNmowdlgwRDI1T2JuYXdIT3dxYnhQeCt4NjFjUG5TeUo5Mm01aUxV?=
 =?utf-8?B?K003ZnRJUEFYbjVTUkVpdlRmWEJTOHEwOGw4OFdMejB1bWt2S01lem5xQitU?=
 =?utf-8?B?c0U2Q3FPcmxaaCttd2FqTTB1aEw0Sklid09zcG9BN0tYbUN6V2syZnZFZ3Mw?=
 =?utf-8?B?bTBBVVhYdURUY3QwOS8raTBoeUY1WjJaR3RXQ3FSRGRKdFJMdHhWU0llTW1N?=
 =?utf-8?B?dmlhaVFwVjNQQXd1Yy9SOVFqUzF0ZndDbEplaTltdzJDMVFSUWMzaGNxMExi?=
 =?utf-8?B?R2U1UjR1cTBoejRLWmF4eVcrOTdPTWs0bGc5SkFlekVWcHFsaE1meS9Id2Q4?=
 =?utf-8?B?aFpCSmRyc3B4UTdrYmViSFdIT3VRRU9BTlZVNzRXNlBDRUVqejRrNVN0Nnpi?=
 =?utf-8?B?b2NJWDFONWp5MG1EUS9UaHB2RTlWRlBvMFhoQ0NXd25seU5wb1o2OFVYRzJD?=
 =?utf-8?B?M2oyMlhmZjg3U1BMTkQwbElnbHdydjF3RlBEMnBmMk9xZTRueXlQUVM3SDN0?=
 =?utf-8?B?NDNkcUlZM1FFNm5WdkEzcW9BSjlOeGtIWVgrQVhBbGxOcG9hVlF0ZklVUzB5?=
 =?utf-8?B?UUpOdzl5Rjl3K1g0eWdyNDVlM3pwZ3lUN0ZmRytwWFl1Yzl6QWtTbm1DdEpy?=
 =?utf-8?B?YkovdURzMkhoMHVXUXZCY05LQU1mby9uNkhkUlRvODlBRkhmSlh3aFpCWXQ0?=
 =?utf-8?B?dmlHclh0NlNKWC9IR0s2bnl3T2dEQlRZdmNRNmJOZkt1LzNYaGJqUURWWS8x?=
 =?utf-8?B?eDdQMEl0K1EwYUJVdXhxdUhkYUlJRE5USFFCVEJKZDhYYi9mMi8yYklpZ1Er?=
 =?utf-8?B?cU1nVnVFcHNiYVZUK3oyUXlyZDIwMnJscU5zT2Y3cGp0Z1FQeWRQSzhtdGc2?=
 =?utf-8?B?VkNiQXRwVWVYcTcvVWR5QUlKZW9qd21pQmZvK2hoQWkvQWEzTEU0UXNuNXVL?=
 =?utf-8?B?NlpuV2pDU2gvdVU3aWcrcGd1T0lhY3U4TlYwb08va0F6dUJ2cmtxSzBUMkhZ?=
 =?utf-8?B?bVVsV2lCc09Wc1UvMExqckhCek9GZHF1YUhuNElESWJXamd0aEg4MkRwZzdX?=
 =?utf-8?B?VGZuZUQrVHY5WVZ4Wm8yNFNWK3k1Z0Z3bVdLODEwbXRhcjUvU2FKdUQyVnBM?=
 =?utf-8?B?SmNYU09ERVA4ZWJJc3dhVWJqc2YzUXY5MUtNQUtmVVNqTmhSUWtvWkRqWVAy?=
 =?utf-8?B?NUFQaTV3Y2o2RkNsSFMzdU9hNmowTCtpRWpaNGpUamxhdVRYMVN1UGhLSUV0?=
 =?utf-8?B?UWw2SmY1RzQ1Nkd3bDgrMG83eDlyRDd6T29FOWF4ZnhVbHdDZSs4RlpITkZZ?=
 =?utf-8?B?N2VDQTQ3aDZiQWFBTktabm4xQnl6d2RnaG1DWVFsQ3ZRMlY3VTVUaGF1QW9W?=
 =?utf-8?B?NTNaQTBVaW1MaE1rWkxmdk5CMDNXRmhyejFKWXN6R3k4ODdZYVR4RjNEWFMz?=
 =?utf-8?B?MGNVNlVKVVNqWkFKbVo2WHl1b0pHU1JhbmEzaXhuUjRNODVsMk9WU0NzbWZL?=
 =?utf-8?B?b3NxQnRNVGZJQnJza0ZTdHo4Mk4ybmt4WXU3WXpZVksreTM4SGZ4MjBrV1E3?=
 =?utf-8?B?S0N5dHpSdVFsT1FpUkwxaU1XVGMvTi9ZajZNQzk0d0xUb0psMjFGKzBsUmFT?=
 =?utf-8?B?NnZ3WGtHWXB1MUhZa2x5b2ozbXhuNHplMzhDRDJVVC80TkhnczF0R0VJUTV3?=
 =?utf-8?B?OWJrWGJyUEpMUHA3anZ0dnJWSlVNTEdxVE1yc3J1NHRJcXdnejl1d3Noejkw?=
 =?utf-8?B?VEhNcGcvQTBvcFdlZUdCTUxEdnp1MzJ2ekxvQ0hRQUhzYUloZm9NNklMNjJM?=
 =?utf-8?B?MTU1SEMwaW1CM29mMEFUSUlaRisvZnFaUDA0UURnUFljOVIvN1liMnI3S0RZ?=
 =?utf-8?B?UWx1TTEwYlQ5RGRWZmxlMW9uUGZUNUpUSVFWZ2kyL0FwNDZlZ3NWUkh0MkJC?=
 =?utf-8?B?WGtQVTZ2d2NocUFvNUE1VzZzY3pERHdqQk9IVUlUWmtvWkRrektOVFUvaUZs?=
 =?utf-8?B?bmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <333D220CF30DFB4A8847DA39F5251FDA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4735e7-9b75-4e0e-ffee-08ddc94b9a5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 18:14:30.5599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RaXYIIyB5qOQojVCjuiGAZqOHfoemc2kTq0f6FHuPpZpf6urtE8WmY6VKY5t/oOE158KYwOQpKtTGIsy6kK96Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF2DEFDE2DF
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTA3LTE4IGF0IDIwOjQ0IC0wNzAwLCBJYW4gUm9nZXJzIHdyb3RlOg0KPiBV
cGRhdGUgZXZlbnRzIGZyb206DQo+IHYxLjMxIC0+IHYxLjMzIGZvciBhbGRlcmxha2UNCj4gdjEu
MDkgLT4gdjEuMTIgZm9yIGFycm93bGFrZQ0KPiB2MS4xNCAtPiB2MS4xNiBmb3IgZW1lcmFsZHJh
cGlkcw0KPiB2MS4xMCAtPiB2MS4xMiBmb3IgZ3Jhbml0ZXJwYWlkcw0KPiB2MS4xNCAtPiB2MS4x
NyBmb3IgbHVuYXJsYWtlDQo+IHYxLjE0IC0+IHYxLjE2IGZvciBtZXRlb3JsYWtlDQo+IHYxLjI4
IC0+IHYxLjMwIGZvciBzYXBwaGlyZXJhcGlkcw0KPiANCj4gVXBkYXRlIFRNQSA1LjAgdG8gNS4x
IHJlbW92aW5nIHRoZSBzbG90cyBldmVudCB3b3JrYXJvdW5kIGFzIHRoZSBwYXRjaCBzZXJpZXM6
DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyNTA3MTkwMzA1MTcuMTk5MDk4My0x
LWlyb2dlcnNAZ29vZ2xlLmNvbS8NCj4gaXMgYXNzdW1lZC4NCj4gDQo+IFRoZSBwYXRjaGVzIGFy
ZSBnZW5lcmF0ZWQgYnk6DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC9wZXJmbW9uL2Jsb2Iv
bWFpbi9zY3JpcHRzL2NyZWF0ZV9wZXJmX2pzb24ucHkNCj4gd2l0aCBwdWxsIHJlcXVlc3RzIDMy
MyBhbmQgMzI0IGFwcGxpZWQuDQo+IA0KDQpIaSBJYW4sIG1ldHJpY3MgdGVzdHMgbG9vayBnb29k
IG9uIG15IGFsZGVyIGxha2UgYW5kIGFycm93IGxha2UuDQoNClRlc3RlZC1ieTogVGhvbWFzIEZh
bGNvbiA8dGhvbWFzLmZhbGNvbkBpbnRlbC5jb20+DQoNClRoYW5rcywNClRvbQ0KDQo+IElhbiBS
b2dlcnMgKDE5KToNCj4gICBwZXJmIHZlbmRvciBldmVudHM6IFVwZGF0ZSBhbGRlcmxha2UgZXZl
bnRzL21ldHJpY3MNCj4gICBwZXJmIHZlbmRvciBldmVudHM6IFVwZGF0ZSBhcnJvd2xha2UgZXZl
bnRzL21ldHJpY3MNCj4gICBwZXJmIHZlbmRvciBldmVudHM6IFVwZGF0ZSBicm9hZHdlbGwgbWV0
cmljcw0KPiAgIHBlcmYgdmVuZG9yIGV2ZW50czogVXBkYXRlIGNhc2NhZGVsYWtleCBtZXRyaWNz
DQo+ICAgcGVyZiB2ZW5kb3IgZXZlbnRzOiBVcGRhdGUgZW1lcmFsZHJhcGlkcyBldmVudHMvbWV0
cmljcw0KPiAgIHBlcmYgdmVuZG9yIGV2ZW50czogVXBkYXRlIGdyYW5kcmlkZ2UgbWV0cmljcw0K
PiAgIHBlcmYgdmVuZG9yIGV2ZW50czogVXBkYXRlIGdyYW5pdGVyYXBpZHMgZXZlbnRzL21ldHJp
Y3MNCj4gICBwZXJmIHZlbmRvciBldmVudHM6IFVwZGF0ZSBoYXN3ZWxsIG1ldHJpY3MNCj4gICBw
ZXJmIHZlbmRvciBldmVudHM6IFVwZGF0ZSBpY2VsYWtlIG1ldHJpY3MNCj4gICBwZXJmIHZlbmRv
ciBldmVudHM6IFVwZGF0ZSBpdnlicmlkZ2UvaXZ5dG93biBtZXRyaWNzDQo+ICAgcGVyZiB2ZW5k
b3IgZXZlbnRzOiBVcGRhdGUgamFrZXRvd24gbWV0cmljcw0KPiAgIHBlcmYgdmVuZG9yIGV2ZW50
czogVXBkYXRlIGx1bmFybGFrZSBldmVudHMvbWV0cmljcw0KPiAgIHBlcmYgdmVuZG9yIGV2ZW50
czogVXBkYXRlIG1ldGVvcmxha2UgZXZlbnRzL21ldHJpY3MNCj4gICBwZXJmIHZlbmRvciBldmVu
dHM6IFVwZGF0ZSByb2NrZXRsYWtlIG1ldHJpY3MNCj4gICBwZXJmIHZlbmRvciBldmVudHM6IFVw
ZGF0ZSBzYW5keWJyaWRnZSBtZXRyaWNzDQo+ICAgcGVyZiB2ZW5kb3IgZXZlbnRzOiBVcGRhdGUg
c2FwcGhpcmVyYXBpZHMgZXZlbnRzL21ldHJpY3MNCj4gICBwZXJmIHZlbmRvciBldmVudHM6IFVw
ZGF0ZSBzaWVycmFmb3Jlc3QgbWV0cmljcw0KPiAgIHBlcmYgdmVuZG9yIGV2ZW50czogVXBkYXRl
IHNreWxha2UgbWV0cmljcw0KPiAgIHBlcmYgdmVuZG9yIGV2ZW50czogVXBkYXRlIHRpZ2VybGFr
ZSBtZXRyaWNzDQo+IA0KPiAgLi4uL2FyY2gveDg2L2FsZGVybGFrZS9hZGwtbWV0cmljcy5qc29u
ICAgICAgIHwgMTA0ICsrKystLS0tDQo+ICAuLi4vcG11LWV2ZW50cy9hcmNoL3g4Ni9hbGRlcmxh
a2UvY2FjaGUuanNvbiAgfCAgOTkgKysrKy0tLS0NCj4gIC4uLi9hcmNoL3g4Ni9hbGRlcmxha2Uv
ZmxvYXRpbmctcG9pbnQuanNvbiAgICB8ICAyOCArLS0NCj4gIC4uLi9hcmNoL3g4Ni9hbGRlcmxh
a2UvZnJvbnRlbmQuanNvbiAgICAgICAgICB8ICA0MiArKy0tDQo+ICAuLi4vcG11LWV2ZW50cy9h
cmNoL3g4Ni9hbGRlcmxha2UvbWVtb3J5Lmpzb24gfCAgMTIgKy0NCj4gIC4uLi9wbXUtZXZlbnRz
L2FyY2gveDg2L2FsZGVybGFrZS9vdGhlci5qc29uICB8ICAgOCArLQ0KPiAgLi4uL2FyY2gveDg2
L2FsZGVybGFrZS9waXBlbGluZS5qc29uICAgICAgICAgIHwgMTYzICsrKysrLS0tLS0tLS0NCj4g
IC4uLi94ODYvYWxkZXJsYWtlL3VuY29yZS1pbnRlcmNvbm5lY3QuanNvbiAgICB8ICAgMiAtDQo+
ICAuLi4vYXJjaC94ODYvYWxkZXJsYWtlL3ZpcnR1YWwtbWVtb3J5Lmpzb24gICAgfCAgNDAgKy0t
DQo+ICAuLi4vYXJjaC94ODYvYWxkZXJsYWtlbi9hZGxuLW1ldHJpY3MuanNvbiAgICAgfCAgMjAg
Ky0NCj4gIC4uLi94ODYvYWxkZXJsYWtlbi91bmNvcmUtaW50ZXJjb25uZWN0Lmpzb24gICB8ICAg
MiAtDQo+ICAuLi4vYXJjaC94ODYvYXJyb3dsYWtlL2FybC1tZXRyaWNzLmpzb24gICAgICAgfCAx
ODAgKysrKysrKystLS0tLS0NCj4gIC4uLi9wbXUtZXZlbnRzL2FyY2gveDg2L2Fycm93bGFrZS9j
YWNoZS5qc29uICB8IDEyMiArKysrKysrLS0tDQo+ICAuLi4vYXJjaC94ODYvYXJyb3dsYWtlL2Zy
b250ZW5kLmpzb24gICAgICAgICAgfCAgNDAgKy0tDQo+ICAuLi4vcG11LWV2ZW50cy9hcmNoL3g4
Ni9hcnJvd2xha2UvbWVtb3J5Lmpzb24gfCAgMjIgKy0NCj4gIC4uLi9hcmNoL3g4Ni9hcnJvd2xh
a2UvcGlwZWxpbmUuanNvbiAgICAgICAgICB8ICA5NCArKysrKy0tLQ0KPiAgLi4uL2FyY2gveDg2
L2Jyb2Fkd2VsbC9iZHctbWV0cmljcy5qc29uICAgICAgIHwgIDMwICstLQ0KPiAgLi4uL2FyY2gv
eDg2L2Jyb2Fkd2VsbGRlL2Jkd2RlLW1ldHJpY3MuanNvbiAgIHwgIDMwICstLQ0KPiAgLi4uL2Fy
Y2gveDg2L2Jyb2Fkd2VsbHgvYmR4LW1ldHJpY3MuanNvbiAgICAgIHwgIDMzICsrLQ0KPiAgLi4u
L2FyY2gveDg2L2Nhc2NhZGVsYWtleC9jbHgtbWV0cmljcy5qc29uICAgIHwgMTM5ICsrKysrKysr
LS0tDQo+ICAuLi4vYXJjaC94ODYvZW1lcmFsZHJhcGlkcy9jYWNoZS5qc29uICAgICAgICAgfCAx
MDAgKysrKy0tLS0NCj4gIC4uLi9hcmNoL3g4Ni9lbWVyYWxkcmFwaWRzL2Vtci1tZXRyaWNzLmpz
b24gICB8IDEzMSArKysrKy0tLS0tDQo+ICAuLi4veDg2L2VtZXJhbGRyYXBpZHMvZmxvYXRpbmct
cG9pbnQuanNvbiAgICAgfCAgNDMgKystLQ0KPiAgLi4uL2FyY2gveDg2L2VtZXJhbGRyYXBpZHMv
ZnJvbnRlbmQuanNvbiAgICAgIHwgIDQyICsrLS0NCj4gIC4uLi9hcmNoL3g4Ni9lbWVyYWxkcmFw
aWRzL21lbW9yeS5qc29uICAgICAgICB8ICAzMCArLS0NCj4gIC4uLi9hcmNoL3g4Ni9lbWVyYWxk
cmFwaWRzL290aGVyLmpzb24gICAgICAgICB8ICAyOCArKy0NCj4gIC4uLi9hcmNoL3g4Ni9lbWVy
YWxkcmFwaWRzL3BpcGVsaW5lLmpzb24gICAgICB8IDE2NyArKysrKy0tLS0tLS0tDQo+ICAuLi4v
YXJjaC94ODYvZW1lcmFsZHJhcGlkcy91bmNvcmUtbWVtb3J5Lmpzb24gfCAgODIgKysrKysrKw0K
PiAgLi4uL3g4Ni9lbWVyYWxkcmFwaWRzL3ZpcnR1YWwtbWVtb3J5Lmpzb24gICAgIHwgIDQwICst
LQ0KPiAgLi4uL2FyY2gveDg2L2dyYW5kcmlkZ2UvZ3JyLW1ldHJpY3MuanNvbiAgICAgIHwgIDIw
ICstDQo+ICAuLi4vYXJjaC94ODYvZ3Jhbml0ZXJhcGlkcy9jYWNoZS5qc29uICAgICAgICAgfCAy
MjcgKysrKysrKysrKysrKy0tLS0tDQo+ICAuLi4veDg2L2dyYW5pdGVyYXBpZHMvZmxvYXRpbmct
cG9pbnQuanNvbiAgICAgfCAgNDMgKystLQ0KPiAgLi4uL2FyY2gveDg2L2dyYW5pdGVyYXBpZHMv
ZnJvbnRlbmQuanNvbiAgICAgIHwgIDQyICsrLS0NCj4gIC4uLi9hcmNoL3g4Ni9ncmFuaXRlcmFw
aWRzL2duci1tZXRyaWNzLmpzb24gICB8IDEzMSArKysrKy0tLS0tDQo+ICAuLi4vYXJjaC94ODYv
Z3Jhbml0ZXJhcGlkcy9tZW1vcnkuanNvbiAgICAgICAgfCAgMzMgKystDQo+ICAuLi4vYXJjaC94
ODYvZ3Jhbml0ZXJhcGlkcy9vdGhlci5qc29uICAgICAgICAgfCAgMzAgKystDQo+ICAuLi4vYXJj
aC94ODYvZ3Jhbml0ZXJhcGlkcy9waXBlbGluZS5qc29uICAgICAgfCAxNjcgKysrKysrLS0tLS0t
LQ0KPiAgLi4uL2FyY2gveDg2L2dyYW5pdGVyYXBpZHMvdW5jb3JlLWlvLmpzb24gICAgIHwgICAx
IC0NCj4gIC4uLi9hcmNoL3g4Ni9ncmFuaXRlcmFwaWRzL3VuY29yZS1tZW1vcnkuanNvbiB8ICAz
MSAtLS0NCj4gIC4uLi94ODYvZ3Jhbml0ZXJhcGlkcy92aXJ0dWFsLW1lbW9yeS5qc29uICAgICB8
ICA0MCArLS0NCj4gIC4uLi9hcmNoL3g4Ni9oYXN3ZWxsL2hzdy1tZXRyaWNzLmpzb24gICAgICAg
ICB8ICAzMiArKy0NCj4gIC4uLi9hcmNoL3g4Ni9oYXN3ZWxseC9oc3gtbWV0cmljcy5qc29uICAg
ICAgICB8ICAzNSArKy0NCj4gIC4uLi9hcmNoL3g4Ni9pY2VsYWtlL2ljbC1tZXRyaWNzLmpzb24g
ICAgICAgICB8ICA5NiArKysrLS0tLQ0KPiAgLi4uL2FyY2gveDg2L2ljZWxha2V4L2ljeC1tZXRy
aWNzLmpzb24gICAgICAgIHwgMTU1ICsrKysrKysrLS0tLQ0KPiAgLi4uL2FyY2gveDg2L2l2eWJy
aWRnZS9pdmItbWV0cmljcy5qc29uICAgICAgIHwgIDMwICstLQ0KPiAgLi4uL2FyY2gveDg2L2l2
eXRvd24vaXZ0LW1ldHJpY3MuanNvbiAgICAgICAgIHwgIDMzICsrLQ0KPiAgLi4uL2FyY2gveDg2
L2pha2V0b3duL2prdC1tZXRyaWNzLmpzb24gICAgICAgIHwgIDIwICstDQo+ICAuLi4vcG11LWV2
ZW50cy9hcmNoL3g4Ni9sdW5hcmxha2UvY2FjaGUuanNvbiAgfCAxMDQgKysrKysrLS0NCj4gIC4u
Li9hcmNoL3g4Ni9sdW5hcmxha2UvZnJvbnRlbmQuanNvbiAgICAgICAgICB8ICA0MCArLS0NCj4g
IC4uLi9hcmNoL3g4Ni9sdW5hcmxha2UvbG5sLW1ldHJpY3MuanNvbiAgICAgICB8IDIxNiArKysr
KysrKystLS0tLS0tLQ0KPiAgLi4uL3BtdS1ldmVudHMvYXJjaC94ODYvbHVuYXJsYWtlL21lbW9y
eS5qc29uIHwgIDIyICstDQo+ICAuLi4vYXJjaC94ODYvbHVuYXJsYWtlL3BpcGVsaW5lLmpzb24g
ICAgICAgICAgfCAgODUgKysrKy0tLQ0KPiAgLi4uL3g4Ni9sdW5hcmxha2UvdW5jb3JlLWludGVy
Y29ubmVjdC5qc29uICAgIHwgIDEwICsNCj4gIC4uLi9hcmNoL3g4Ni9sdW5hcmxha2UvdW5jb3Jl
LW1lbW9yeS5qc29uICAgICB8ICAgOCArDQo+ICB0b29scy9wZXJmL3BtdS1ldmVudHMvYXJjaC94
ODYvbWFwZmlsZS5jc3YgICAgfCAgMTYgKy0NCj4gIC4uLi9wbXUtZXZlbnRzL2FyY2gveDg2L21l
dGVvcmxha2UvY2FjaGUuanNvbiB8IDEyOSArKysrKy0tLS0tDQo+ICAuLi4vYXJjaC94ODYvbWV0
ZW9ybGFrZS9mbG9hdGluZy1wb2ludC5qc29uICAgfCAgMjggKy0tDQo+ICAuLi4vYXJjaC94ODYv
bWV0ZW9ybGFrZS9mcm9udGVuZC5qc29uICAgICAgICAgfCAgNDIgKystLQ0KPiAgLi4uL2FyY2gv
eDg2L21ldGVvcmxha2UvbWVtb3J5Lmpzb24gICAgICAgICAgIHwgIDE1ICstDQo+ICAuLi4vYXJj
aC94ODYvbWV0ZW9ybGFrZS9tdGwtbWV0cmljcy5qc29uICAgICAgfCAxMDMgKysrKy0tLS0NCj4g
IC4uLi9wbXUtZXZlbnRzL2FyY2gveDg2L21ldGVvcmxha2Uvb3RoZXIuanNvbiB8ICAgNSArLQ0K
PiAgLi4uL2FyY2gveDg2L21ldGVvcmxha2UvcGlwZWxpbmUuanNvbiAgICAgICAgIHwgMTczICsr
KysrKy0tLS0tLS0NCj4gIC4uLi9hcmNoL3g4Ni9tZXRlb3JsYWtlL3ZpcnR1YWwtbWVtb3J5Lmpz
b24gICB8ICA0MCArLS0NCj4gIC4uLi9hcmNoL3g4Ni9yb2NrZXRsYWtlL3JrbC1tZXRyaWNzLmpz
b24gICAgICB8ICA5NyArKysrLS0tLQ0KPiAgLi4uL2FyY2gveDg2L3NhbmR5YnJpZGdlL3NuYi1t
ZXRyaWNzLmpzb24gICAgIHwgIDE5ICstDQo+ICAuLi4vYXJjaC94ODYvc2FwcGhpcmVyYXBpZHMv
Y2FjaGUuanNvbiAgICAgICAgfCAxMDAgKysrKy0tLS0NCj4gIC4uLi94ODYvc2FwcGhpcmVyYXBp
ZHMvZmxvYXRpbmctcG9pbnQuanNvbiAgICB8ICA0MyArKy0tDQo+ICAuLi4vYXJjaC94ODYvc2Fw
cGhpcmVyYXBpZHMvZnJvbnRlbmQuanNvbiAgICAgfCAgNDIgKystLQ0KPiAgLi4uL2FyY2gveDg2
L3NhcHBoaXJlcmFwaWRzL21lbW9yeS5qc29uICAgICAgIHwgIDMwICstLQ0KPiAgLi4uL2FyY2gv
eDg2L3NhcHBoaXJlcmFwaWRzL290aGVyLmpzb24gICAgICAgIHwgIDI4ICsrLQ0KPiAgLi4uL2Fy
Y2gveDg2L3NhcHBoaXJlcmFwaWRzL3BpcGVsaW5lLmpzb24gICAgIHwgMTY3ICsrKysrLS0tLS0t
LS0NCj4gIC4uLi9hcmNoL3g4Ni9zYXBwaGlyZXJhcGlkcy9zcHItbWV0cmljcy5qc29uICB8IDE1
MyArKysrKysrLS0tLS0NCj4gIC4uLi94ODYvc2FwcGhpcmVyYXBpZHMvdW5jb3JlLW1lbW9yeS5q
c29uICAgICB8ICA4MiArKysrKysrDQo+ICAuLi4veDg2L3NhcHBoaXJlcmFwaWRzL3ZpcnR1YWwt
bWVtb3J5Lmpzb24gICAgfCAgNDAgKy0tDQo+ICAuLi4vYXJjaC94ODYvc2llcnJhZm9yZXN0L3Ny
Zi1tZXRyaWNzLmpzb24gICAgfCAgMjAgKy0NCj4gIC4uLi9hcmNoL3g4Ni9za3lsYWtlL3NrbC1t
ZXRyaWNzLmpzb24gICAgICAgICB8IDEwMSArKysrKy0tLQ0KPiAgLi4uL2FyY2gveDg2L3NreWxh
a2V4L3NreC1tZXRyaWNzLmpzb24gICAgICAgIHwgMTAxICsrKysrLS0tDQo+ICAuLi4vYXJjaC94
ODYvdGlnZXJsYWtlL3RnbC1tZXRyaWNzLmpzb24gICAgICAgfCAgOTcgKysrKy0tLS0NCj4gIDc4
IGZpbGVzIGNoYW5nZWQsIDI4NzAgaW5zZXJ0aW9ucygrKSwgMjMyNSBkZWxldGlvbnMoLSkNCj4g
IGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy9wZXJmL3BtdS1ldmVudHMvYXJjaC94ODYvbHVuYXJs
YWtlL3VuY29yZS1pbnRlcmNvbm5lY3QuanNvbg0KPiANCg0K
