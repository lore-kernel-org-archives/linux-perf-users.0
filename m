Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064462DAFA1;
	Mon,  6 Oct 2025 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759767854; cv=fail; b=Em/Zntjq8coB9XlPIwOpGPb6CXZQE9hsNJBBJihyk89qEg7/rPu+wQkblP/pynrYS19MVHHLokrfr5sq1wNl3YYkMHG3YhwzuH112YUa23ffcmA761CFGdKp4rVXKxLEAoGL6VTfAawfYLAhhMQ0qtN+YyDf8GJ9KWgR5ADUj+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759767854; c=relaxed/simple;
	bh=vZmYd7PQVEuyRDynyasoVKfUcDIGNUzCmCJrUgTSL8Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SmVPRqeLEmIizOW4jyiUBxB7XKd1DFLqgEdor+THWRMvzdDHBCC6KXotrufDA6Y2VclsAxJXD52xd2p62quxL73AP5EvrVoEuA8gqkT47F8eTKIp2+CDupz0s4IUJzgelrIvS4C96pNADCGda0IBQQvn73wUozexjgU1MRN/mps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JBRRwppM; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JBRRwppM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759767853; x=1791303853;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vZmYd7PQVEuyRDynyasoVKfUcDIGNUzCmCJrUgTSL8Y=;
  b=JBRRwppMrh6orUTU9N2iRpglFZK8oUPfsHXif+/kwA+Z/u2PwlYHjxUV
   UsQS7HC2jGGC2BRB/1qZcqMz/o8jMQCaRAsIAHX/ffdqbnvrvTSH6+fGs
   NiL2XRpWNeZM40oMgzp3+LJhbgb/khEpONrNLrRGDxqj52ixulwKYDdDN
   LYfJYONUIEAzTYcGqe3Q0Z4urBaSPYgugmHxge2BDecYDRcFRhpvvTZc7
   AQa76YKtcuo/Wlz/8sABy0HlXdJQKmyWzXqh887TSTDz8bBM+YpoRxiK8
   tlSOs0iZFgEg/KcidcJoGhh7K5FmX2Y0rSm1ZlcnoabBqgxBv5Hhab4hI
   w==;
X-CSE-ConnectionGUID: N7txDJaWRQyR9oXgD2JDcg==
X-CSE-MsgGUID: 8UwhVf2YQ0urkP1Q6+7Nag==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="73046708"
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="scan'208";a="73046708"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 09:23:53 -0700
X-CSE-ConnectionGUID: x4ZbuUvsRgO1dPQqLzQZ4w==
X-CSE-MsgGUID: 1tS5b+iqSV+ZSzveLG/Dsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="scan'208";a="180337612"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 09:23:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 09:23:51 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 6 Oct 2025 09:23:51 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.33) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 09:23:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjXhKTpWbraQP3VRaUb6CWuTavT5SWGzKVYFhpL49SDRtW2BXL6cbJmN4zzdlvqGlBzK0jOOqNVfqZWmex+fiDHRzhvAdbe/8Fezbga6axKnY1cj6o/svLvoArKch8tOzIm6GlLN6m9tI9QR3qXj7islesziQzit7gKxX79FGo4WUSRfIiuijo3VNFQoCsYbH8/frjo2MjvgQp5Z0+zu1mEfbyBza037DgI+SHk8rwXOdQizAv5YTkgwYgv4qIG1xKsoW59y9Cdk7q2WKZXgJiJl5tCiwf6A72lQ6m9+c286o3j1hOLQf6hBhDrWgyz19fuYmi+P2fR1ekAjW8ib7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZmYd7PQVEuyRDynyasoVKfUcDIGNUzCmCJrUgTSL8Y=;
 b=necF39myhADCXe8Qe+ByzOMO/puYp8CoC7Oru3BbNLE2kG+YPTwaIKAYhpJDrNwHi/d3sGVNtSGwB0tFKzHfdFVW4oSZDGtjkhiOi2joLZed5Ynnjfy9yqIjY6jY7jbDY8WpLUPfKw1TQVeqw7bZL88I1C0DKekEXgK/r29wjxUzzMSQU/u02saXr51OdjA7KIX1XFNiEcKZLmmpxz4LcWLpUGrK4qCU2PZfoUxy3NDXlAgcIskj2qayamiu7gr4cerxjzNcOvXFxGTp0y0MXlBkVYa118XgbLIwviPwdmXNnpyX2uKJn3KPiQQd8JRWe3hX7xy7Tc25zk70QmqL1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by LV3PR11MB8742.namprd11.prod.outlook.com (2603:10b6:408:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 16:23:42 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%3]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 16:23:42 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "acme@kernel.org" <acme@kernel.org>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"ak@linux.intel.com" <ak@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "irogers@google.com" <irogers@google.com>,
	"dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>
Subject: Re: [Patch v3 0/2] perf record: ratio-to-prev event term for auto
 counter reload
Thread-Topic: [Patch v3 0/2] perf record: ratio-to-prev event term for auto
 counter reload
Thread-Index: AQHcM/Zh9PhJczP/FU+/ZL0F1iryarSwz7WAgASDhYA=
Date: Mon, 6 Oct 2025 16:23:42 +0000
Message-ID: <1cd532e63acc22a4c6632285195305972ae36122.camel@intel.com>
References: <20251002234308.64218-1-thomas.falcon@intel.com>
	 <aOAju-lDNHBFnYWx@x1>
In-Reply-To: <aOAju-lDNHBFnYWx@x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|LV3PR11MB8742:EE_
x-ms-office365-filtering-correlation-id: 34ec5762-26ca-4bb5-1339-08de04f4b74b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bnBlZ3dEZlJoSlNjaUpRUGYzemNIM2FVYjI3M015Tm03S2ZBYyszRy9iaTVP?=
 =?utf-8?B?YVdENWl0aGJvcGg4L3UreDQvQTVQZHlsRTdYMndxU2w0K05ZcGZFc2g3SFRE?=
 =?utf-8?B?QWZRZGhkREJQcVM4WnF2OW40blh2K1pKS0tiTTVhRjhhdXF5WExTQjkzZWF1?=
 =?utf-8?B?dGV3UFRhdDZ1REErZ2lLQjFDYzBzVEM4VGxEVXV0M0l2OFl4aGdBQW9Ga2h2?=
 =?utf-8?B?WXppOWxWNEcxRlVwblE0WDN5eUI5NFpVVmZFaWVXWUV1T3dXbHYvMVNXL0Ey?=
 =?utf-8?B?dHFta2xIcGJPNDJhZFNPd3NOc285R0tNUlA3Z0tyUzUyUnQzWXdBMHpQMzJp?=
 =?utf-8?B?a1E2Vk95RUxmdjVOWWoyMEJ2NTNEQWp0L21RK3lCWmhlUm55R0xKZlNNNzZz?=
 =?utf-8?B?d0ZiUTNQNWh6MHRnR0FMd0p2bVdvOUcxQjRtWVRFeXpheGJoMHBqanlxYXNl?=
 =?utf-8?B?UEJIdlNGY3pyK1NyM2x5a3JNZ2VPSzVJL2ZOaG5sdU9LUkU5WWxVQTh6b2g5?=
 =?utf-8?B?RVVFYWgwNGR0MHFGTTlWdnBINmxNNDh6MmRDSWw0TkptUVVrMHJWTzRicHF1?=
 =?utf-8?B?SjYvNUxKUml1bTZKWGgwTDBsNno4L3JlbGd6RmcyNlZpWE1aSXh6UnNLMWhu?=
 =?utf-8?B?SEljTHZIbzU5MnkrUlkyYTZwdHkvSFpFYWZGTDV4dVIzb0Vid3R4NERWdFcy?=
 =?utf-8?B?NzlCTXhaM1JhdjBLQitzOUpoNFpKSU5NMzVFWHhqdWN6OVAvN2ZZdkg1bjRz?=
 =?utf-8?B?YWV3dEtwK1crYXRkKzRtOHZpZ25QVEN2YVF1ZDZEcXBhWisrZkNQenNhMnp6?=
 =?utf-8?B?b0V5cjRidnhrUllIbXBnRjdqNVRTcjRzNWZyVFQ3dG1CVzl3QVBNdERkSjRN?=
 =?utf-8?B?aHh2aU15N2FuUnRKdTg1UW1tNWo4WURLNFQwbmt0WFArRzVTelVIZjF3U1Bm?=
 =?utf-8?B?SHo4eXlJVlZmOXFKcHVpaU1adC82TjdYSmZQOGx5bStKeWp0ZVdjN0pzU0pw?=
 =?utf-8?B?Q01hZnB2MlNUUWNkSkg5Y2JBclcxeHpiS3lVSjBHaGNtQzc1OUN1OUdGOGdr?=
 =?utf-8?B?NzNKU0tlNXh2STBsamhieWZMQkVyb0lZbnliRmdPV20xSU8yTStXWC9CSEJq?=
 =?utf-8?B?djR3UDBqSUx3cmMvQzVKdU94WlIrdDNYODUwTVNnZEtGdXJWY2sxN2tINElT?=
 =?utf-8?B?R3VWbjVJUlg4ZWZRczdlRzcybi9VVTJtd0IxRm56YlZZWjJ2N3pTYy9lM3F1?=
 =?utf-8?B?SWZYS3BIUzdULythOHhKanBBc1hiazdrK1c3REF0Vm9Hd3hOazF3THFuUDdH?=
 =?utf-8?B?R0tlUDFZUm1SZ2FHdHgrYnhadUV4dmk3VVNreW45TExsYU1LWUNpTVBXR012?=
 =?utf-8?B?T1dvYzYwQUNuUkdTb0x3bStQUHFHZWNkNXhKU1FVVzNndTBESHpGeUlzanZS?=
 =?utf-8?B?bmVMWDhmVTBDWWVBd3FGZ3hVbGVwaGlqTFRrZ3B0QzVzUmdnSW9FMmtRWk9s?=
 =?utf-8?B?enU4YThNQ2w4NHFodi9xYW44K2ZQSkk3WGlqWmYzbUdLcmtqM21xVDhCTXg0?=
 =?utf-8?B?VWVYeWJHSS9nN3pXSGpqbmFDam92dUh4ekdaeFQ2djE1eVU3NjA1cjd6bTRk?=
 =?utf-8?B?aEV6Y0VwWndTQkVLUVdzNzBXODZqejJUSkhucDVhVHVSU2FkR3dRNk1zajlk?=
 =?utf-8?B?TE5ZNVQxK1lSNkhZS0FnTUwxcWloakREZkNrMGRUUGtXcklaL1FwSXhib2ZM?=
 =?utf-8?B?K0FZQ1pySDBaNXpoZ3JNVWVUL0JnbWRjTnBlWUZtbmRWUjlnVFgvSkppRnBv?=
 =?utf-8?B?S1hrYkpUSUQybDFjN01ZdzNEVVdxMmZ0VUFiaDJ0NzBTOFZmQ3k0MktJeFcr?=
 =?utf-8?B?dnBIUkJEOEdyc2VVaDBPM0thMnNZN3pLdzlTTGJLSzdYUk52dWUwNXBCQWI0?=
 =?utf-8?B?VVB3Vy81UDYwdzMrck1hUXVKUGxZc0xLbHl6Kys1cnJYd2hSTlZGZi9tL0sr?=
 =?utf-8?B?U0pKQU5pS3hGYzdtTTcreExrM2RXVW9wNHBEYStnK1BHVG1uclhnWVNtN0w4?=
 =?utf-8?Q?A/mO9a?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjZFUTB3WVJnVkYrK0pYY0xpZ1hzQXdwVUFKVnQyajNGRFpkQWhtNmhaUFpU?=
 =?utf-8?B?VVZCYlNmSmVsVytkamplRDBHekVjbHR3UnhiOXZYTUhmWkJTNUhlSmNRbFdS?=
 =?utf-8?B?TWpEUncrb2I3YXB4ZkZ3Y1ZzNlc1ZjdZd0plZTA3SysraUdxL0pLQjlWdFFV?=
 =?utf-8?B?Uk5EUkhvL2RpT3VVL1N1STFVMmZ3THBxTHRyKzY2QXpxL2UwSjlRUjJqQVdY?=
 =?utf-8?B?bUk3aUlRNTVzaEVKaVE4SGJsQkpJd0JXV0dKaGtFOXlTSFQwWERqM3ZRUDRU?=
 =?utf-8?B?QjRmOXZCb3pDNDhTRkVueW16STcyb0RGMzM1QzhZMXVzb2dOVUNkZG1TSnZn?=
 =?utf-8?B?UWs0Umo1S1Y0ZWl0dHA5SXdNbkN1eE1ZZi9xTklvOVhZOXZnL0JrcXo0cmNi?=
 =?utf-8?B?dWsrL2k0eURkVGRUeEkreUU4aWNrRTBmb0pVZkV0V1E0ekUzNHZtUFluOWVM?=
 =?utf-8?B?SzZIci9ITnRQaThvdzJzZ2VoNzNKdUx5WjNmNXgwcis2Tlo1TFgxVnZlZDR0?=
 =?utf-8?B?ZFhZYkpkM1RDcTFJNU5TZE0vNW9zOVJmN0NDa1RJRUJPOStiMno1ZGgvTjdC?=
 =?utf-8?B?M05wbG9LYUVaOFprdyt6K1NZOU80dEp4WGVhbUl6cGQ5cmZmUUpUMGk0dXZK?=
 =?utf-8?B?Q2dvN05jclRXVlBya2dmUDBCcFhOTTlTcm9aWEJrN3oyV2pFM2NTVFhWc3JG?=
 =?utf-8?B?WE16Z2dSN3BOT25lVzh6NnNUOFJBdCtpUEdudUZUWDZ0eW1QN2g5NGJ1Z3VV?=
 =?utf-8?B?aHpxZDY3Yi9kMGtZeGF5WXJLdVNXUE1YWWpNVDRNNTBjQ3FlQ0EwaDN3eVgv?=
 =?utf-8?B?eEpRcGVIVGNSTSs0Yk9Bbjc4Z2tvRFBHRTRvdGtZNmdxc005K25hSEh0a2hC?=
 =?utf-8?B?UE8xdC9CSXJ1cms4ZC9OTHVvVWszUE04Rm5xT3BtYjdpbGl4Y3dRcVZRU05y?=
 =?utf-8?B?MUszeXlJVmFZSWpoSGYycWl6M2xSdTBIVkpIQWgrNjVrNUIxT0I2a3IxelNi?=
 =?utf-8?B?bTE0MW1oY21scmliK2VQRkdUaXVESmNGVjcxK005TnhObVBLMTJnVnBVS1N5?=
 =?utf-8?B?dTU0QnV5cEh5MzdjakRTL29vZE02aHZjYXpEWmYzMjllcHMydmhnYWkzbGd5?=
 =?utf-8?B?Mm5NVmtGRVdRakJrME90MkcvM0I3bE5hQkxZdHdFeW1Na1JMVWlCMFc5YnBB?=
 =?utf-8?B?bndYU2ZDczVpMlN1bTVwZjc4NGxwVzdzQ0tnOU1hRGNWZU54aFd6eWhPdXFo?=
 =?utf-8?B?VmhtR05SZzRMbWpGUWpjTzRESkYwdnBnVFlObGd6eUNLbHVCSU94TDVLcVow?=
 =?utf-8?B?S0wrdncwOUc4S1dxd0kzYTcyTGNtckhOcE1SeGM5V05JOVVwb1ZCL3hmRmNu?=
 =?utf-8?B?NnZPOXFUeHFJRlFlRE9JMkxvc2xObGZac1ZCMkt2WUF0WVJmbzBXd1pZblRh?=
 =?utf-8?B?Y0NpWUtpeDJxakNVRmdZZXQ4bXVRRzBSazVGN0p3TGhSZ1RiQTM3S3FmdWVj?=
 =?utf-8?B?eFlaREJpcGMzUW5QeXVJYXA3ekxBZnplUFVTQTlGUkd3NXpUYkR4Z1FSMDlW?=
 =?utf-8?B?TW10cXVucEg1d1FOdUdWRisvSmQzRUFxTlI0M3p6aXB4cGNITVBUTjl2YlRa?=
 =?utf-8?B?RzNFTTVGRXk2WkpzSm0wMWVEWTRCZEh6TU9ueEVYSFpGb3ZUUUdZTHo0NU9s?=
 =?utf-8?B?L0IwclVPV0RNWlZ1OTRWU3M4ZmRNTk11TTR5NzBoem5VbkNON3RRWW03N1pK?=
 =?utf-8?B?dTFpTER0d3NxK1pxT0N5NDFUZWdwNzNTQWpmbWZRZXRNc3d2T2RUSENrdS81?=
 =?utf-8?B?TUZMRStaVWZFZnNOaHFZbFBXdmtTeXJJUXRJejBoYnNxblVKOC9NRUlnV3Bj?=
 =?utf-8?B?T1VHdzZYV3RaSm1hZjRJOTVOZ29UL21NMFQvd0QwdkNITlpkWGVtU2VTdXdq?=
 =?utf-8?B?OTZocXBzNTJjWFpnL0JnWUdqOUhpVXlVdXBWdnY2SlNhSXZ3WjFIKzlWTGxj?=
 =?utf-8?B?YUppNnZnUmNzLzM3WjV6U2ZkUzZEQk5zaEhBMlFXMEd1RUlGZXFjcnR5dWxh?=
 =?utf-8?B?c1BtSFpvYXVWRUFjdDA3WFlXRjBieFFmc1VWbnA0SU9iZFFUSzlYd1RPaXlm?=
 =?utf-8?B?TDBWUlhma1BUSGk4SmtGL0RlcHo1eHNIYjEyaEVOZENlMFhzRWpPbUFlRlNB?=
 =?utf-8?B?S29FeENXbDh3SzdjL0tndXJIY3NvQ3AzeENheW9nSUtqSTdCOXB5bzJsWDZD?=
 =?utf-8?B?cGl6SkFNcWZxOEN6bk9BMjF1VUN3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE519DDFDC7FD3418917EBDDD7C01836@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ec5762-26ca-4bb5-1339-08de04f4b74b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2025 16:23:42.6322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vI21jufwQRkDFYBmsA3YbI9VcyL3BF14hZt2XiyMU4/JaTTctyMhA/FfsGCEIVaR0jnnX471PEv58tQsuNAqow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8742
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI1LTEwLTAzIGF0IDE2OjI3IC0wMzAwLCBBcm5hbGRvIENhcnZhbGhvIGRlIE1l
bG8gd3JvdGU6DQo+IE9uIFRodSwgT2N0IDAyLCAyMDI1IGF0IDA2OjQzOjA0UE0gLTA1MDAsDQo+
IHRob21hcy5mYWxjb25AaW50ZWwuY29twqB3cm90ZToNCj4gPiBUaGUgZ29hbCBpcyB0byBsaW1p
dCBldmVudCBzYW1wbGluZyB0byBjYXNlcyB3aGVuIHRoZSBicmFuY2ggbWlzcw0KPiA+IHJhdGUN
Cj4gPiBleGNlZWRzIDIwJS4gSWYgdGhlIGJyYW5jaCBpbnN0cnVjdGlvbnMgc2FtcGxlIHBlcmlv
ZCBpcyBleGNlZWRlZA0KPiA+IGZpcnN0LCBib3RoIGV2ZW50cyBhcmUgcmVsb2FkZWQuwqAgSWYg
YnJhbmNoIG1pc3NlcyBleGNlZWQgdGhlaXINCj4gPiB0aHJlc2hvbGQgZmlyc3QsIG9ubHkgdGhl
IHNlY29uZCBjb3VudGVyIGlzIHJlbG9hZGVkLCBhbmQgYSBzYW1wbGUNCj4gPiBpcw0KPiA+IHRh
a2VuLg0KPiDCoA0KPiA+IFRvIHNpbXBsaWZ5IHRoaXMsIHByb3ZpZGUgYSBuZXcg4oCccmF0aW8t
dG8tcHJlduKAnSBldmVudCB0ZXJtDQo+ID4gdGhhdCB3b3JrcyBhbG9uZ3NpZGUgdGhlIHBlcmlv
ZCBldmVudCBvcHRpb24gb3IgLWMgb3B0aW9uLg0KPiA+IFRoaXMgd291bGQgYWxsb3cgdXNlcnMg
dG8gc3BlY2lmeSB0aGUgZGVzaXJlZCByZWxhdGl2ZSByYXRlDQo+ID4gYmV0d2VlbiBldmVudHMg
YXMgYSByYXRpbywgbWFraW5nIGNvbmZpZ3VyYXRpb24gbW9yZSBpbnR1aXRpdmUuDQo+IMKgDQo+
ID4gV2l0aCB0aGlzIGVuaGFuY2VtZW50LCB0aGUgZXF1aXZhbGVudCBjb21tYW5kIHdvdWxkIGJl
Og0KPiA+IA0KPiA+IHBlcmYgcmVjb3JkIC1lICJ7Y3B1X2F0b20vYnJhbmNoLW1pc3Nlcy9wcHUs
XA0KPiA+IGNwdV9hdG9tL2JyYW5jaC1pbnN0cnVjdGlvbnMscGVyaW9kPTEwMDAwMDAscmF0aW9f
dG9fcHJldj01L3V9IiBcDQo+ID4gLS0gLi9taXNwcmVkaWN0DQo+ID4gb3INCj4gPiBwZXJmIHJl
Y29yZCAtZSAie2NwdV9hdG9tL2JyYW5jaC1taXNzZXMvcHB1LFwNCj4gPiBjcHVfYXRvbS9icmFu
Y2gtaW5zdHJ1Y3Rpb25zLHJhdGlvLXRvLXByZXY9NS91fSIgLWMgMTAwMDAwMCBcDQo+ID4gLS0g
Li9taXNwcmVkaWN0DQo+ID4gWzFdDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8y
MDI1MDMyNzE5NTIxNy4yNjgzNjE5LTEta2FuLmxpYW5nQGxpbnV4LmludGVsLmNvbS8NCj4gPiB2
MzogcmViYXNlIHRvIGN1cnJlbnQgcGVyZi10b29scy1uZXh0DQo+IA0KPiBUaGFua3MsIGFwcGxp
ZWQgdG8gcGVyZi10b29scy1uZXh0LA0KPiANCj4gLSBBcm5hbGRvDQo+IMKgDQoNClRoYW5rIHlv
dSBhbmQgdGhhbmtzIHRvIElhbiBhbmQgZXZlcnlvbmUgZWxzZSB0aGF0IHRvb2sgdGhlaXIgdGlt
ZSB0bw0KcmV2aWV3Lg0KDQpUaGFua3MsDQpUb20NCg0KPiA+IHYyOiAoY2hhbmdlcyBiZWxvdyBz
dWdnZXN0ZWQgYnkgSWFuIFJvZ2Vycyk6DQo+IA0KDQo=
