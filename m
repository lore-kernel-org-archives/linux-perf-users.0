Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C109124CEE1;
	Wed,  5 Mar 2025 14:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186402; cv=fail; b=J3iuj57NDI1HYyy8PGOtC2Fn+Nq2mKgtttSx2n5QHp/J6kAMv2NzCfjNFd5pfE2GOjhejI7X8Hpl/i3VDZdn+wpAUnUB2k3YcSnSIHu9tF0ln8ZhgAeL1zqr2p9Hv3XoKdlLdccy6PrpSTxaFZYQR6nMz6VZI3b1wHFdohJOt0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186402; c=relaxed/simple;
	bh=QaN0oq5f1LHeIxLlfD7dt0n5Sbt0HMJF6Eg9YNHDpfs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hjm8zpU8vSqMlrr/aqGRyqBuJIWh+b0M1BEEno8dxmWPX7ZbN9VAyVJor02Whh20g2JYajp3FjfWWuUqkiM6iTLGcyw30dpRcwvaujoaCSZx72NNtgLrWXcLKY2nxOk2inPObL6ND25jD+akQ0SJtkDgOvvOWAh8Ccm9wF9lJzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ThA+B0Gx; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ThA+B0Gx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741186400; x=1772722400;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QaN0oq5f1LHeIxLlfD7dt0n5Sbt0HMJF6Eg9YNHDpfs=;
  b=ThA+B0GxVC4EzdhxOxSsllU52DgtEY9oNVRWEH8oZGlWiawfpAIIyITg
   gzwVIFdRm5hn/sEFvO3suRb2ghqa7c5Q7Ot4MXnKzyw7GoZeIv+8Fe5wu
   lTDeY5drS7ejgJmXQ2IsA0PjZqiUajWt79FL78YXxkwLBzOjOS3LU/M+I
   EWyNaCZTL/yEVXJ0PqUqtSLEBCTWEhX0zwUcP5Uso8LMNxXLq3AiO+TMr
   iu53aL1BG0GrkbzFIUEvgvS2HS7MTv+WiZSnnlFyIS2B2aZR19Irv0qST
   OSlNENQqWSVHAwG7kbzgUge9kfuGYtzI3o2w/7Fg1oZYE/U67BwDrEjFA
   Q==;
X-CSE-ConnectionGUID: UvrbQ0VFQ8qSEkBkk86zOA==
X-CSE-MsgGUID: u2SwxWSFTAu6Z/KBbMNjcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52793679"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="52793679"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 06:53:19 -0800
X-CSE-ConnectionGUID: 6heXF9ubQKe47bk6qfGSxg==
X-CSE-MsgGUID: JLbV1ldpRaK4bLHtLJUAXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="118726600"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 06:53:17 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Mar 2025 06:53:17 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 06:53:17 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 06:53:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSp1zAoXAP8xwf5MQKW4+z+B4uw8KSOZdF3HHTwsNPJKdan4yVsCdbE0aYE7yUTFRvX3lWfIHyc4Jp3JLAmaDUetYAolXI58dErmmOLuLmaDJPgTWSuVflrv0izUEurSoLJ10PUsTwTwavS+oGDPj5YwJfFfQm9CC1r1+0V3Bbtdg86W4PNn+6FU4ATzuwCane2ylcllIPiqy5shNnO8NZSn7vWz9zzZtK2hSKzK9GlXIlLPt60npSCr/UHtdoE+ZMLMAtxe31siwnXcys/VvTARiTuNXblkv0xhptSJ86dKJRWo+9ApIZ6IWFpffblZmjXXx3WWBhovymZQt5SX4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaN0oq5f1LHeIxLlfD7dt0n5Sbt0HMJF6Eg9YNHDpfs=;
 b=FEd/u6NAZCtHvYJ2cS8/81Ntzg8lzvYHxfNgMzvcQj2Rb0eFxA0nFPyAN0viqxxt1TZfgEFNa2/2h8sSsBWfSP6/xf6mclgamLzdu5bOZH5oWlwosDYFr2aKmfDPGH7aUyqEKRDaICiRyXh1Zds0Y3ZVSXTeAFaF4gnfflYgnSKA7UDduC2ENmxP1W6qm3d8Ovd7Wix1Yx/5e0qaK0uBJvNqdQ07vRd/SyydoNcx0NK5Be6ZlHk7a9+zeb7+dni9RzyrhQhcp2cxGtiFRn+Ssk0fFznfJPD1WeysYos4ivCeFG+b9CGeJR2+/mKPAtq/t4ZNopi1fszGZ/l9z++PQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by SA2PR11MB4986.namprd11.prod.outlook.com (2603:10b6:806:114::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 14:53:15 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%4]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 14:53:15 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "irogers@google.com" <irogers@google.com>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org"
	<acme@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@intel.com>,
	"namhyung@kernel.org" <namhyung@kernel.org>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH v5] perf script: Fix output type for dynamically allocated
 core PMU's
Thread-Topic: [PATCH v5] perf script: Fix output type for dynamically
 allocated core PMU's
Thread-Index: AQHbjKZGNt7EMBLD1kSNyPtut9L9U7Nj9T+AgACuF4A=
Date: Wed, 5 Mar 2025 14:53:15 +0000
Message-ID: <0d3bc045e06411cf8fb8dc8bcd7b9af7b216baef.camel@intel.com>
References: <20250304013906.1393102-1-thomas.falcon@intel.com>
	 <CAP-5=fVwrG5ZViysO7qKYUw0326WFfa7nOzwe70drYfHq=AXhA@mail.gmail.com>
In-Reply-To: <CAP-5=fVwrG5ZViysO7qKYUw0326WFfa7nOzwe70drYfHq=AXhA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|SA2PR11MB4986:EE_
x-ms-office365-filtering-correlation-id: 49531702-4ed8-475f-230f-08dd5bf5756f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?a2IzR0MxTW1xdnZ3bUZBZjRRSlVPdXdmRi9jODBGbjQ0SWVlK0pFaVdtaGNs?=
 =?utf-8?B?K1Z6WThmakhjdWY5MTB1VjduZTQ0bENsQmpQaHFtK3FxcFJJanVzdDZ3dWRk?=
 =?utf-8?B?SVo3RFB2aDdXZlZiQnVFVjI3c2srOU1aY1VscmU3aDhrU3ZMTzJsanYrV1JO?=
 =?utf-8?B?MVRSbHMvNW91cGZkS0ZhZmpiNk9PcGdEcUtXVFpFb0dUYkxWNHBuWjJtNS9t?=
 =?utf-8?B?ZWJzNjFYeUF2SXVPZ1JhQXlGZW1KZnBGeFlyNTFibElvekJxOGJwTEYvTHZz?=
 =?utf-8?B?SDBINDhodnRWQTJZTjVvM0ZOVUJqaElVL05Vbk9jM3VaVXNxRkRlSkgwNzhW?=
 =?utf-8?B?QnphaUtpalpyV2Q0L3dxUThtaUhHK0h1NnVkRlZ5TXB6aTg0MVVVU3RZM08y?=
 =?utf-8?B?djRBL1I2T1pwM2tMUHArbG4wc09sejIzNVJTQnRnazg1NjNQeHU3QUVxN01q?=
 =?utf-8?B?OTJHU1BEMlBaU3pIcGVXaG13UmozRlhuaTYyTndobGZHbXN1a1ErK2x6ZUVP?=
 =?utf-8?B?a1hTRVlnSyt2WExMOXZRUy8zaVY5eDd2T0M1V3hlcjBxSVc0MGpEL28xSTZS?=
 =?utf-8?B?ZHpXQXZWaTh1dXBadGJZdTZ4WGl1Zm1TSzNuNVNCckRWbExQcDVEWDNTWVJW?=
 =?utf-8?B?K2pDWHVYaE54WWdkOHJFa1FjaFYrNVk4dUdrVEk3RmxXRXFVcEVJa3F6VG5K?=
 =?utf-8?B?UHBZanJyRmV4VXlZMHY5TlRaZWtZTk5nMlU5RFQ2RXA5Q1FvQ0VPejAxMTht?=
 =?utf-8?B?RVYzUFNYTjBKTmZPK1NSNTh4M2R6TWp5WXp4NGNya0FNY3FWMXh3cVh0ZVJ0?=
 =?utf-8?B?V3VVbFdSS1BUYVd4MWhsc3hQYUNzSWFRbTF5T2dvVk9UQVZiczdQNUtNdGZv?=
 =?utf-8?B?NGV1eVREdzRvU0hlbnl5aC9ybGQvS2ZtYk13VW9HNWtLMGFKVHJPSzVyTGNV?=
 =?utf-8?B?cVZ1OUJsL3pyaXYvK1NmZGZUbTg3azlpdTFpTFM3OXIyM0s1UkxuOHloL2to?=
 =?utf-8?B?UGxpQVArOVhUZWY1SHdOUWNoVlJDMUIrTjZkMXBGY09ZYU5zTXVQVXpKalEv?=
 =?utf-8?B?NkNMMGNkVzM1Z0ZjRStSZm1SekxyRjU1SE9jM0Mwa2dkVTEyNUdYMDdKWnhX?=
 =?utf-8?B?S1hMYy8zWFFwb2RWNmE2bUZUa0ljRnlha2F1SnljalJnV3dkTXlzUU9JeWdY?=
 =?utf-8?B?UFJYUjVPL1VoZEs0ek9UVXE0dEUrd3JTSjJJRXd4dTVUdEpnblB4bVpLNjhS?=
 =?utf-8?B?TWd5dVVVU21Gd2NrTWV4QWVNMFdtc09YMlNFZzVuNVFzZDIrdG44Y1IxYS9w?=
 =?utf-8?B?QjZQVmJ0dm96QmhKN0FGdnhUL2FkSFpWRUlzYXJiTWRad29ONjRwMFJYY2hS?=
 =?utf-8?B?U1ZPS2drbDd1RHorb1VFdGxIeGRPTEM1eS9ZalhLc1NPSWVRNWtHWC9NeklO?=
 =?utf-8?B?Z1RIU0ZHN2Z3cXZxTllJeXg5NXlyM0pZVEpJWWYzemxKV01kMG1JRjZsQzFK?=
 =?utf-8?B?ZmZzWHM2WnNncjZ3L0tiM3o2Y2tTTUdsL2hQYmRwL1BFWVBHK1JycmZRQVJE?=
 =?utf-8?B?MURYOUViQzVzNjZ0RjhLRmZuVWs5ZGFXb0FhbnY2MXJuNXhxTU5CaVptYzNF?=
 =?utf-8?B?cWdvbCsrRXF1V1FiMDhmMm5SZVFjbzlkcktrTVB2UnB1TnVna3cxSzlYN1dv?=
 =?utf-8?B?c0wxb3h0U05wQzBXRU43ZDFGTXNybFl3VkFHS1BpelVpT0dWUGhDWmtNRHY3?=
 =?utf-8?B?MndndndjZGdhQ1VHYzJsNmVWZDRWLzR4dmp0V3YwcHFWYWpneUJJZnlBWlJu?=
 =?utf-8?B?SVBKc1JVOVUwUjkwSzh6Mzdsd0ViSGlJTWEyUDNUcTNnUVZWbi9qWXNnZVVG?=
 =?utf-8?B?ankrM2NON1hCUU5qb0lvcGlSTzVUT3Z0WFljR3FqMXdtNVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjE1ZVJoajNrdnhSNndUbGZxTnM2T2ZVVHBOZEdoeEpEc0VzTXpkUlFuenZ1?=
 =?utf-8?B?S0o4dnBDWTYvUldKR0MzRS9FZG9ycGdMMk1raVZaWENES1kwUEU5VVh6dTQ2?=
 =?utf-8?B?Sm1CK0tpOU5nd3hvdWNFZW9OMUwzTUQyNlpYY1lXMFdlcndRaldUZG5QSFBY?=
 =?utf-8?B?YXJSVEUrNjBrbm0vVzdZTFZmejB1UjdYWG9jK01FbmFrMFUyL1VjYjg1MFg5?=
 =?utf-8?B?WWdRNlZoWlIzTmZRSXVJV3dadis2SVNpaGMvY1RQdE5lZjJoNGFuVHREZjN6?=
 =?utf-8?B?WmdLY0ZoSkZ1MFB0RXMwSVpFeWx1SVlVOGtpVXV4WllKOXJLczl4NHJNaTgr?=
 =?utf-8?B?d2ZSTDlOWVhGdzNmcHNkSGVIRzFSVzYrd2ZwZG1oSWN4bXp0dWI5elIxRGFF?=
 =?utf-8?B?ZFg3NndqS0hrcWNneHRQdkR6TnZkT25jWktQRTk1SWVEU0w0UXpJaHJaZFlx?=
 =?utf-8?B?eGRxMWJhTElHbzhRYmRWQ2JpekFZL2dBeXNxSHVBaGgrMytHWGNFL2dGcWJZ?=
 =?utf-8?B?Ti9NRm1QWVdEd09SR3hmQnF2dDBBOUlScHkvV0hpUjdqNkV0ZjR6LzYzREFk?=
 =?utf-8?B?b28ra1diM1NOMEVGVWtZWWZGRjlFZy8yZW9oaXJHWXVwakU0NkIwakNuK284?=
 =?utf-8?B?OXo1RS9vdTlVMkR6a3lHNWtBdUFTeFRlMGd5SlhUbDVLVytPUGp4dGZNL25V?=
 =?utf-8?B?dmMvRkFwNHRqaDB4eGc0RDIzTXFSYnhOZlAwaUxrZy9lTkQ4QUx5RU5LNUpn?=
 =?utf-8?B?YW5zZUtXWUlLZm5id1VLaTRPbHV3RUJGdVdKbWZrVEswM1JUOHUwQzZxcWQy?=
 =?utf-8?B?d3pZODBjMGlDSGpBZTJkSmFmTHhYOW1QM2JlU1FmeVIyTzdWcm1vc29OdVZw?=
 =?utf-8?B?aU1DUUh5K3JsTitxMndXaU9sT0llRS9VdlUwOUdHRHU0SnJiOUJDYzVKbWpK?=
 =?utf-8?B?TXRXeWFOMEtDWERDSFF3UVNKcUdFZG1Vd3hXNG5OSWxFV1k4UEF5UHBXSHdY?=
 =?utf-8?B?cHlpTDloS3hqalo4aHN5YVZDUTlybURudmc5L3lwNGtmZ3NscXh5Y25mejJo?=
 =?utf-8?B?WEk0dVp0RFhpSXR1MlJzdkFDaXQxalVZTlR2MkN6Mk9jV1psTndFVmxmUzZL?=
 =?utf-8?B?OGtrZXVYNU1NL1VrUnk2NmlzWDlBay9pYWN5U3pPQU9acC80UzZYTDNoemhZ?=
 =?utf-8?B?NVpuVFR1ZDcyc2x2d3kxMy80emwzbUVBYTQzeTRxc3F3VGg0akkxWjZIbWZa?=
 =?utf-8?B?T0xEclB4QVBoUUdjRUZvWkdKL2NQRE9GOGFIYnFGRUsrd3U3ZUZjUk9rY3FU?=
 =?utf-8?B?TE1LSUJGc0hoRCtlVXF0UXhLZnExZUZ2eUJUdHZoeTk4M0Y1dXRkbGhwdnlY?=
 =?utf-8?B?S3FqSFFaVDE5bkp0NDN3dHl5WFBjNStkcjFaRmdQM0FEaTdmMDJ4dUlsY0Ro?=
 =?utf-8?B?QkdZdS9wQk9oelZocFVLMWFJVWFaQWtpV3VEbW5TRjl5SW94cU9oRnhHM0FG?=
 =?utf-8?B?bUlGakxSS2Fjc0gwSHhjTm9sUnJYeGZ1aVRCWW9uUWxraGpZNDIzd2VidHBS?=
 =?utf-8?B?bHpyekRYOXhwOXRCTUNvdUUwd2JDMGt3TjJJZHQ1VERNUVNsRU5ZZFFMMjFC?=
 =?utf-8?B?OFNna2pQZmZzcW12TVJzNlovMUNRZzNrNFlkbDEzcGlKeUVEUC9aVUczTWZP?=
 =?utf-8?B?QTlrNXhpbVVwYjBsN0tRcURBRWFwMUdORjNuSUZJam9MNlI3VW1kbHQ4QS91?=
 =?utf-8?B?OGdpMEJaZGJ4cHNYWE1PM1B6OHpvTkIxb01nUk1raXNDbHdyVklLamw0MmZB?=
 =?utf-8?B?ejRmUE43TFR3SmdFWUc1bDhDYVRGWFNIeGJNOEpBbjBjdkxVUDJZTDZrOHdl?=
 =?utf-8?B?N2E2UGx5T1Bwb0NDR21ETWVjTWtPcWJYSmxIQkdTUDJhUU9ReFFmbzRmNjJh?=
 =?utf-8?B?UzVaQUtYSXprT0dpSDRJM3FkMnh2NWQ3Ly8wOXM5VFhML1V5emJESDZRRVM5?=
 =?utf-8?B?MkxybTJHblUrOSttb0kvT1FER1dyOUI4NjhXaFpZb1dKMkVNUDJsblRNT1hs?=
 =?utf-8?B?aks4ZTVGb2FZWGpHRzZ3ekdGSTJUc3h3NGllUTdZZDVUeERualVIcDNYaEpi?=
 =?utf-8?B?dEJKbmh5Z2VaZENvckZHU2Q1YkZuVER2dmFQVHluNG5XRWNqVU1UbHE2Q3Mz?=
 =?utf-8?Q?EeTPMVeczmDgdVd7uXURf5Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FC5DD632C41C94ABC0BE288406DFD79@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49531702-4ed8-475f-230f-08dd5bf5756f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 14:53:15.1238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dRUyk1bOa7c9cCgpgksuBLJx0a7hgRC8p+O4H+iqQi2wQM3YEen8fmSTYdc8gyy5C7+2K33hX5HEm1CnPk6jdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4986
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI1LTAzLTA0IGF0IDIwOjMwIC0wODAwLCBJYW4gUm9nZXJzIHdyb3RlOgo+IE9u
IE1vbiwgTWFyIDMsIDIwMjUgYXQgNTozOeKAr1BNIFRob21hcyBGYWxjb24KPiA8dGhvbWFzLmZh
bGNvbkBpbnRlbC5jb20+IHdyb3RlOgo+ID4gCj4gPiBUaGlzIHBhdGNoIHdhcyBvcmlnaW5hbGx5
IHBvc3RlZCBoZXJlOgo+ID4gCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDEy
MTMyMTU0MjEuNjYxMTM5LTEtdGhvbWFzLmZhbGNvbkBpbnRlbC5jb20vCj4gPiAKPiA+IEkgaGF2
ZSByZWJhc2VkIG9uIHRvcCBvZiBBcm5hbGRvJ3MgcGF0Y2ggaGVyZToKPiA+IAo+ID4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1oyWENpM1Bnc3RTclYwU0VAeDEvCj4gPiAKPiA+IFRoZSBv
cmlnaW5hbCBjb21taXQgbWVzc2FnZToKPiA+ICIKPiA+IHBlcmYgc2NyaXB0IG91dHB1dCBtYXkg
c2hvdyBkaWZmZXJlbnQgZmllbGRzIG9uIGRpZmZlcmVudCBjb3JlCj4gPiBQTVUncwo+ID4gdGhh
dCBleGlzdCBvbiBoZXRlcm9nZW5lb3VzIHBsYXRmb3Jtcy4gRm9yIGV4YW1wbGUsCj4gPiAKPiA+
IHBlcmYgcmVjb3JkIC1lICJ7Y3B1X2NvcmUvbWVtLWxvYWRzLWF1eC8sY3B1X2NvcmUvZXZlbnQ9
MHhjZCxcCj4gPiB1bWFzaz0weDAxLGxkbGF0PTMsbmFtZT1NRU1fVU9QU19SRVRJUkVELkxPQURf
TEFURU5DWS99OnVwcCJcCj4gPiAtYzEwMDAwIC1XIC1kIC1hIC0tIHNsZWVwIDEKPiA+IAo+ID4g
cGVyZiBzY3JpcHQ6Cj4gPiAKPiA+IGNocm9taXVtLWJyb3dzZcKgwqAgNDY1NzIgWzAwMl0gNTQ0
OTY2Ljg4MjM4NDrCoMKgwqDCoMKgIDEwMDAwwqDCoMKgwqDCoMKgwqDCoAo+ID4gY3B1X2NvcmUv
TUVNX1VPUFNfUkVUSVJFRC5MT0FEX0xBVEVOQ1kvOiA3ZmZkZjEzOTFiMGPCoMKgwqDCoAo+ID4g
MTAyNjgxMDAxNDIgXAo+ID4gwqB8T1AgTE9BRHxMVkwgTDEgaGl0fFNOUCBOb25lfFRMQiBMMSBv
ciBMMiBoaXR8TENLIE5vfEJMS8KgwqDCoCBOL0HCoMKgwqAKPiA+IDXCoMKgIDfCoMKgwqAgMMKg
wqAgN2ZhZDdjNDc0MjVkIFt1bmtub3duXSAoL3Vzci9saWI2NC9saWJnbGliLQo+ID4gMi4wLnNv
LjAuODAwMC4zKQo+ID4gCj4gPiBwZXJmIHJlY29yZCAtZSBjcHVfYXRvbS9ldmVudD0weGQwLHVt
YXNrPTB4MDUsbGRsYXQ9MyxcCj4gPiBuYW1lPU1FTV9VT1BTX1JFVElSRUQuTE9BRF9MQVRFTkNZ
L3VwcCAtYzEwMDAwIC1XIC1kIC1hIC0tIHNsZWVwIDEKPiA+IAo+ID4gcGVyZiBzY3JpcHQ6Cj4g
PiAKPiA+IGdub21lLWNvbnRyb2wtY8KgIDUzNDIyNCBbMDIzXSA1NDQ5NTEuODE2MjI3OsKgwqDC
oMKgwqAgMTAwMDAKPiA+IGNwdV9hdG9tL01FTV9VT1BTX1JFVElSRUQuTE9BRF9MQVRFTkNZLzrC
oMKgIDdmMGFhYWEwYWFlMMKgIFt1bmtub3duXQo+ID4gKC91c3IvbGliNjQvbGliZ2xpYi0yLjAu
c28uMC44MDAwLjMpCj4gPiAKPiA+IFNvbWUgZmllbGRzLCBzdWNoIGFzIGRhdGFfc3JjLCBhcmUg
bm90IGluY2x1ZGVkIGJ5IGRlZmF1bHQuCj4gPiAKPiA+IFRoZSBjYXVzZSBpcyB0aGF0IHdoaWxl
IG9uZSBQTVUgbWF5IGJlIGFzc2lnbmVkIGEgdHlwZSBzdWNoIGFzCj4gPiBQRVJGX1RZUEVfUkFX
LCBvdGhlciBjb3JlIFBNVSdzIGFyZSBkeW5hbWljYWxseSBhbGxvY2F0ZWQgYXQgYm9vdAo+ID4g
dGltZS4KPiA+IElmIHRoaXMgdmFsdWUgZG9lcyBub3QgbWF0Y2ggYW4gZXhpc3RpbmcgUEVSRl9U
WVBFX1ggdmFsdWUsCj4gPiBvdXRwdXRfdHlwZShwZXJmX2V2ZW50X2F0dHIudHlwZSkgd2lsbCBy
ZXR1cm4gT1VUUFVUX1RZUEVfT1RIRVIuCj4gPiAKPiA+IEluc3RlYWQgc2VhcmNoIGZvciBhIGNv
cmUgUE1VIHdpdGggYSBtYXRjaGluZyBwZXJmX2V2ZW50X2F0dHIgdHlwZQo+ID4gYW5kLCBpZiBv
bmUgaXMgZm91bmQsIHJldHVybiBQRVJGX1RZUEVfUkFXIHRvIG1hdGNoIG91dHB1dCBvZiBvdGhl
cgo+ID4gY29yZSBQTVUncy4KPiA+ICIKPiA+IAo+ID4gU3VnZ2VzdGVkLWJ5OiBLYW4gTGlhbmcg
PGthbi5saWFuZ0BpbnRlbC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgRmFsY29uIDx0
aG9tYXMuZmFsY29uQGludGVsLmNvbT4KPiA+IC0tLQo+ID4gdjI6IHJlc3RyaWN0IHBtdSBsb29r
dXAgdG8gcGxhdGZvcm1zIHdpdGggbW9yZSB0aGFuIG9uZSBjb3JlIHBtdQo+ID4gdjM6IG9ubHkg
c2NhbiBjb3JlIHBtdSBsaXN0Cj4gPiB2NDogcmViYXNlIG9uIHRvcCBvZiBBcm5hbGRvJ3MgcGF0
Y2gKPiA+IHY1OiB1cGRhdGUgYmFzZWQgb24gTmFtaHl1bmcncyBmZWVkYmFjayBoZXJlCj4gPiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL1o4WWNPaWRlbnpHb2ZxN1JAZ29vZ2xlLmNvbS8K
PiA+IC0tLQo+ID4gwqB0b29scy9wZXJmL2J1aWx0aW4tc2NyaXB0LmMgfCAxNiArKysrKysrKysr
KysrKysrCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspCj4gPiAKPiA+IGRp
ZmYgLS1naXQgYS90b29scy9wZXJmL2J1aWx0aW4tc2NyaXB0LmMgYi90b29scy9wZXJmL2J1aWx0
aW4tCj4gPiBzY3JpcHQuYwo+ID4gaW5kZXggZDc5N2NlYzRmMDU0Li40ZDI3NjRkZjQ4YTAgMTAw
NjQ0Cj4gPiAtLS0gYS90b29scy9wZXJmL2J1aWx0aW4tc2NyaXB0LmMKPiA+ICsrKyBiL3Rvb2xz
L3BlcmYvYnVpbHRpbi1zY3JpcHQuYwo+ID4gQEAgLTM4NSw2ICszODUsMTkgQEAgc3RhdGljIGlu
dCBldnNlbF9zY3JpcHRfX2ZwcmludGYoc3RydWN0Cj4gPiBldnNlbF9zY3JpcHQgKmVzLCBGSUxF
ICpmcCkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0
LnN0X3NpemUgLyAxMDI0LjAgLyAxMDI0LjAsIGVzLT5maWxlbmFtZSwKPiA+IGVzLT5zYW1wbGVz
KTsKPiA+IMKgfQo+ID4gCj4gPiArc3RhdGljIGJvb2wgaXNfY29yZV9wbXVfdHlwZSh1bnNpZ25l
ZCBpbnQgdHlwZSkKPiA+ICt7Cj4gPiArwqDCoMKgwqDCoMKgIHN0cnVjdCBwZXJmX3BtdSAqcG11
ID0gTlVMTDsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqAgaWYgKHBlcmZfcG11c19fbnVtX2NvcmVf
cG11cygpID4gMSkgewo+IAo+IE9uIEFSTSBpdCBpc24ndCBhIGdpdmVuIHRoYXQgaWYgdGhlcmUg
aXMgMSBjb3JlIFBNVSB0aGUgdHlwZSB3aWxsIGJlCj4gUEVSRl9UWVBFX1JBVywgb24geDg2IHRo
aXMgaXMgbm9ybWFsbHkgdGhlIGNhc2UuCj4gCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB3aGlsZSAoKHBtdSA9IHBlcmZfcG11c19fc2Nhbl9jb3JlKHBtdSkpICE9IE5VTEwpIHsK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocG11
LT50eXBlID09IHR5cGUpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiB0cnVlOwo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfQo+ID4gK8KgwqDCoMKgwqDCoCB9Cj4gPiArwqDCoMKgwqDCoMKgIHJl
dHVybiB0eXBlID09IFBFUkZfVFlQRV9SQVc7Cj4gPiArfQo+ID4gKwo+ID4gwqBzdGF0aWMgaW5s
aW5lIGludCBvdXRwdXRfdHlwZSh1bnNpZ25lZCBpbnQgdHlwZSkKPiA+IMKgewo+ID4gwqDCoMKg
wqDCoMKgwqAgc3dpdGNoICh0eXBlKSB7Cj4gPiBAQCAtMzk1LDYgKzQwOCw5IEBAIHN0YXRpYyBp
bmxpbmUgaW50IG91dHB1dF90eXBlKHVuc2lnbmVkIGludAo+ID4gdHlwZSkKPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHR5cGU7Cj4gPiDC
oMKgwqDCoMKgwqDCoCB9Cj4gPiAKPiA+ICvCoMKgwqDCoMKgwqAgaWYgKGlzX2NvcmVfcG11X3R5
cGUodHlwZSkpCj4gCj4gR2l2ZW4gdGhpcyBpcyBjYWxsZWQgYnkgZXZzZWxfX291dHB1dF90eXBl
IEkgdGhpbmsgeW91IGNhbiBkbzoKPiBgYGAKPiBzdGF0aWMgaW5saW5lIGludCBvdXRwdXRfdHlw
ZSh1bnNpZ25lZCBpbnQgdHlwZSkKPiB7Cj4gwqDCoMKgwqDCoMKgIHN3aXRjaCAodHlwZSkgewo+
IMKgwqDCoMKgwqDCoCBjYXNlIFBFUkZfVFlQRV9TWU5USDoKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybiBPVVRQVVRfVFlQRV9TWU5USDsKPiDCoMKgwqDCoMKgwqAgZGVmYXVs
dDoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICh0eXBlIDwgUEVSRl9UWVBFX01B
WCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4g
dHlwZTsKPiDCoMKgwqDCoMKgwqAgfQo+IAo+IMKgwqDCoMKgwqDCoCByZXR1cm4gT1VUUFVUX1RZ
UEVfT1RIRVI7Cj4gfQo+IAo+IHN0YXRpYyBpbmxpbmUgaW50IGV2c2VsX19vdXRwdXRfdHlwZShz
dHJ1Y3QgZXZzZWwgKmV2c2VsKQo+IHsKPiDCoMKgwqDCoMKgwqAgaW50IG91dHB1dF90eXBlID0g
ZXZzZWwtPnNjcmlwdF9vdXRwdXRfdHlwZTsKPiAKPiDCoMKgwqDCoMKgwqAgaWYgKG91dHB1dF90
eXBlID09IE9VVFBVVF9UWVBFX1VOU0VUKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBvdXRwdXRfdHlwZSA9IG91dHB1dF90eXBlKGV2c2VsLT5jb3JlLmF0dHIudHlwZSk7Cj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAob3V0cHV0X3R5cGUgPT0gT1VUUFVUX1RZUEVf
T1RIRVIpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3Ry
dWN0IHBlcmZfcG11ICpwbXUgPSBldnNlbF9fZmluZF9wbXUoZXZzZWwpOwo+IAo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocG11ICYmIHBtdS0+aXNfY29y
ZSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBvdXRwdXRfdHlwZSA9IFBFUkZfVFlQRV9SQVc7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB9Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBldnNlbC0+c2NyaXB0X291
dHB1dF90eXBlID0gb3V0cHV0X3R5cGU7Cj4gCj4gwqDCoMKgwqDCoMKgIHJldHVybiBvdXRwdXRf
dHlwZTsKPiB9Cj4gYGBgCj4gVGhlIGV2c2VsX19maW5kX3BtdSB3aWxsIGNhY2hlIHRoZSBQTVUg
Zm9yIGZ1dHVyZSBjYWxsZXJzLgo+IAo+IFRoYW5rcywKPiBJYW4KClRoYW5rcyEgSSB3aWxsIHNl
bmQgYSB2NiB3aXRoIHlvdXIgc3VnZ2VzdGlvbnMuCgpUb20KCj4gCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gUEVSRl9UWVBFX1JBVzsKPiA+ICsKPiA+IMKgwqDCoMKg
wqDCoMKgIHJldHVybiBPVVRQVVRfVFlQRV9PVEhFUjsKPiA+IMKgfQo+ID4gCj4gPiAtLQo+ID4g
Mi40OC4xCj4gPiAKCg==
