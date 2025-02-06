Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547D5155757;
	Thu,  6 Feb 2025 20:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738874045; cv=fail; b=AnJTcNu6gqQRLDME0W4ArfNwfJvGGgLrqImkF7nBQ8Ro6yZh6e2VeRZ09+uVWafs1iE0deGaXine+6FpMAuFiDnW59mbm9fkNJRH2Jj1Z/uc2OXXTKdNI+LpD17yIee9OjBFjslDGmYyI27KyiVcIwJHHRIM5TiCvzVm5sTcUN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738874045; c=relaxed/simple;
	bh=7PUbHGbw1dvFWSgVl1OIHXVPdDNcxBoHAC1be3LdUUQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=asAKOM4E8WZ5SsBlwpf4iKI7VtDycvF4ia/yCS/cHaEnaaBnEHxtZEB46A2x5+g+uyOFjEDtzqbWWZdQpdwbdVZSGtGOuoI7RJI2R5YAJ7soYDqr6DLDrnnSwTlFwE32S5NYQC4e3P3wX4gYpwt9FdVRSZ8r59k1k7gbxb1qULY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JCTbsu0U; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JCTbsu0U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738874043; x=1770410043;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7PUbHGbw1dvFWSgVl1OIHXVPdDNcxBoHAC1be3LdUUQ=;
  b=JCTbsu0U/uIvXdV5cfi8QvIkDLf2bK8SJyaEDw1yXc+/vb3TVO1dw9eO
   DiKq8lnPpIEe1xVrHw5yDOz5vrY+lOtXXc5Uupmt9JVcwfkoK6MMOyj4m
   CjfhYshR04phSseF6HFxfvWjIsr6wuO0SnKGHewLyAPWDFVga0PqoFOIi
   a8hfbPrWi+VTt9pBNXjLsrlZS7xLO6t5+QWa5DftnLqWerVwd3oN5aj44
   rQjcD//eXlSj9iIelYjQ5EIpct+E1G1yU+WcCYK5d5Qd0lUHJxmQHnRrF
   FLuqRrVIErAj4f1cn/tZzM6QppoXRq5akEr6gnM9qfh+dF4p5twXiGtMs
   w==;
X-CSE-ConnectionGUID: TU8GPWcUSOW+QdEl+h36Vw==
X-CSE-MsgGUID: KIgplR6fSAya5cSKmWFevw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39407604"
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="39407604"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 12:34:02 -0800
X-CSE-ConnectionGUID: euPsup09Sz6xokzlQHVFOA==
X-CSE-MsgGUID: qo7CXG4JQwKx2nw0oAYvCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="142202945"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2025 12:34:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Feb 2025 12:34:00 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Feb 2025 12:34:00 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Feb 2025 12:33:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNciM/GFT4bsrK0X6BQ7TbhVZUblD5e5DEC7ykc5H14y6T6o3lnzrUWlQWWu1zUSSeWXVF+yWDwvVTABoQHCGAzWBTfpQo9HtAcDC0JJCPIVuzFFex77hRISL6DDfrcR00v9MOP/gcFHFDfTk5TLCh4OCPlFkwPsLlOL1ZTtj66yDxuPeOSRR1XE9MFNh8rElDwRi6+QEQnrZ2cIUgMZ9ZtpE2N3YFn1l3RY57WVAShCv9+jq5om0pQFBG9CcRUUt2ODFDcS9wwU4wRr4TPDWKXL9bMeNY2V1AKBn0Gdc5xKcXZqoOEPMc/ipcQApvn98aS+0MVqirRP9hKlxdFpEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PUbHGbw1dvFWSgVl1OIHXVPdDNcxBoHAC1be3LdUUQ=;
 b=HmF1MIhjoP0hV0CGOcr5WY9ahqpk41pGhzJLGRp4Uq7gCAD/+6WnFOay8Dcc+xr91KwA83irxo1ysXjwzn9RYhgrGzPhr2GVnbqqS8ID6Pz9pTBvz1uMPnkpgGxdLFIieFGrmDC6QQweLvTQ7PvJYdcj0Oj7RiqSQSzkj7FGDkidglYHFAlezLNU6mSuvMT6vJo6q5iYL6NVxVzJEfRqupOid5yw9tXNOKMNCcnw9zvEwOjdtv6s5n7hLT+3U8mlJKJcOuiJwsZOJeGQ7GWPFKBzvgO/eVZ9c6pBsohurglKshnxXSFuGuc6BBcWu9+UIFFSqmg0AdXgYEaKFMkp/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Thu, 6 Feb
 2025 20:33:09 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%4]) with mapi id 15.20.8422.012; Thu, 6 Feb 2025
 20:33:09 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "irogers@google.com" <irogers@google.com>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"Biggers, Caleb" <caleb.biggers@intel.com>, "mpetlan@redhat.com"
	<mpetlan@redhat.com>, "Taylor, Perry" <perry.taylor@intel.com>, "Hunter,
 Adrian" <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "Baker, Edward"
	<edward.baker@intel.com>, "Alt, Samantha" <samantha.alt@intel.com>, "Wang,
 Weilin" <weilin.wang@intel.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "acme@kernel.org" <acme@kernel.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"afaerber@suse.de" <afaerber@suse.de>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v5 00/24] Intel vendor events and TMA 5.01 metrics
Thread-Topic: [PATCH v5 00/24] Intel vendor events and TMA 5.01 metrics
Thread-Index: AQHbd/Pk3ssZzFoxWEmGT4uQs0hxArM5HL2AgAARvQCAAY5GgA==
Date: Thu, 6 Feb 2025 20:33:09 +0000
Message-ID: <cfea58d7357fc974613cbf65197b1069cbd4e749.camel@intel.com>
References: <20250205173140.238294-1-irogers@google.com>
		 <4f42946ffdf474fbf8aeaa142c25a25ebe739b78.camel@intel.com>
	 <CAP-5=fUjx3PTHfjgkam9Q0xE+TrYx+FSzF8wUscbD9X36gJ1Tg@mail.gmail.com>
In-Reply-To: <CAP-5=fUjx3PTHfjgkam9Q0xE+TrYx+FSzF8wUscbD9X36gJ1Tg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|PH7PR11MB6522:EE_
x-ms-office365-filtering-correlation-id: 016c2801-988b-4b96-10ff-08dd46ed7803
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WHJRTFBHc1lhdXNvOVBrbVRaQXVTK09UZEhpbzF2Z1JiRkw1RzFZUjZDbFA2?=
 =?utf-8?B?YVhtZml2c3RTbVVmbWxsL0liY1o3KzdMTks5di9ISmMrdnI3Y1BjRit3aGF2?=
 =?utf-8?B?K00zamhYbWlaTE5maWh2Q3JZOWJIYW1nMm93byt2M1R2aUNhd0ZGWHFqL2JS?=
 =?utf-8?B?cWpQY3pmdGp2bjF2UksxUTNzRFRZRDJVbWRaVGhBWWs2ajBnYlAyR29tREVD?=
 =?utf-8?B?Vzh2Wmc2MVhVWHl2Ni9UNmxKNGw2c2Q4WDIzVktzdnlpeDZOUG5KbU5XWHpQ?=
 =?utf-8?B?T1BGRklGV1VuSE51WnpRcFR4QmE5UlQwd1U1K1AvS2lFVW96V1h0OVdjQmNa?=
 =?utf-8?B?elZnUnByRFJONVkxMUxMb3p5Q01Mc2NCbDVLOHZpMUoyUE5VM0dYaExtSmZu?=
 =?utf-8?B?VUJISnFibzExOE9yNGZVOWZrbmRvK1loSExoMzdESGJJZkZ4b2RWUHhWZS91?=
 =?utf-8?B?RkpmSWtCL3JWU01veVpGY0lFc0d3Z3ZkVU5Uamx3YkpFR1EwdmNFUkIwZS8y?=
 =?utf-8?B?QTRRVTRTcGVjQmk3TUFFV1NDZFI0SWwzMDJiazllQTlKc2s3dllzQmoxTGFk?=
 =?utf-8?B?c01PM3MxUWJONU1NNCtVQkR4WUt1T2haTWxPVkJ6bjJhN2VVdnZpVjNOMTY0?=
 =?utf-8?B?RDVDUEdwRHJyUndMNUV0TjNlR0U1aXI1ZmNSdS9meXlXeE50Vm5IRDBpNjd1?=
 =?utf-8?B?aTdQYjB6bXJIK2NaR3pqZjBZd3ArYWE5YzVFK21EMDdDY05QY1loczJBb3Jk?=
 =?utf-8?B?N0ZiMkJQcEhCWmhNTHp0eExWekRLQU9ZU0hpU2hFbXBvSVl3YWFtcGxaakR0?=
 =?utf-8?B?QXRZTTg1RUcyc05KaGJ2eHRzRmhBQk9ic2ZjeHpJMTlvVUg4NjBsZTA4cm1F?=
 =?utf-8?B?YXFERlVQWXNQbENXczNWM1BBUFBGOWRYMlphZzlvOFlFT3BzRmVJVWRhZjRQ?=
 =?utf-8?B?WGx5UUo2T0JXdUZIV0Z0RE14UDdOcTI2VjhqZnJVeE01eTkwYkhGdnYwUHA4?=
 =?utf-8?B?RCtpTW1xc0xiN1ZqTmQyOTV1bTNVL1BERGY3d0ZlSWY4U3JzaGYwdDBPalhT?=
 =?utf-8?B?ckFhWU0yWTFMdGxXbHhSN29JWm5yZ0VKd0c4TjJXd3RHbWI3VEtGeWF6Z0t6?=
 =?utf-8?B?UER2U0x5Lzdrek5oay9mSWx4TmpBTVZRZkMyU0U3MkpoakkyRDVOWkdHZ0M2?=
 =?utf-8?B?RVJIRHRRNjFkcWZEYmU0OXdwaGxwWUVxNUY3TkNnREVXRll5Y0ZuRlppd05U?=
 =?utf-8?B?YXZMTTRXNzBGZVFHakx3eG81VVVTMmJySUppSysrajF4anhKUEZ5RlJVYWpz?=
 =?utf-8?B?ZkREVTczRnRhZE5MK21KNHRIeEdEdU1SMTdWUXdUWjcrcU9HcEx2YWR4UzZZ?=
 =?utf-8?B?bzFOcW51ZGJXam1DNTV2SDJBa0NacW9aUVYwTDY3bDUxM0RubGdvS2YyTG1C?=
 =?utf-8?B?TjZwemtlS2lITVk2cXhDMmVNM1lNRHhMM0Fwek1wM2I5SHlYWGg2K1ZpTng4?=
 =?utf-8?B?eW5wdTBhMGQ2YWRMRFBnVG1GU0NmMlNzZFVRUXhZUTdLYlpWUC9jcDJjTHdQ?=
 =?utf-8?B?dW54NmJxM3V4aXZDdmlsZjhNK1JWMURYdGVpYlAreUgxOFVNWk5INi85Lzd0?=
 =?utf-8?B?empORmR4M3FYM3RRUEt0NEovanhaQzYvU21rbUhtQTBCdGdvTkNaOUl0N1Nk?=
 =?utf-8?B?T0s0Y1NmYkh0bmJkdnNPbURNM1JaR2h1RjNIc3VIdTB1VGJ6bm0reVVSSWZi?=
 =?utf-8?B?QWRoTUJScTR0NkllVEgvbU5oVWxDRDBFL21CamdYQ3IvU0FoTXV1ZVBwZzU5?=
 =?utf-8?B?L0tnbDB5VjJnSTlSM3l4YWFJSFB6WGJnTFljZXl0QmtoelM2NFoycVp3OW5E?=
 =?utf-8?B?ZEswT055OUY3eXBobWZ1Vld1bFM2a3BLQ09VVFAxU1JncEwrcmZMZDljOWUw?=
 =?utf-8?B?SUlOd01nNElhOHJVaHFRZXBrOGMwZEl4U2l6TDQ3NlpTNzNoa2ZzSVNlUjIy?=
 =?utf-8?B?U2F3SUZWdTFRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cG02bENYaytUUGo5clpFZ2UrRC9sbEJiK0x0YlBUTmtXTGdienBPYXBCMk1H?=
 =?utf-8?B?VC94Vkt1U3RkVHhWY2g0RHZpenYySzhsS1puVEhHVTJLa05yK3YyYW9pclFv?=
 =?utf-8?B?TUlJa3FVc0QxVEJ1QnlKN0VmalZHMEdpMG1xWm5kQ1RSVnk0YlpZaTljZFdl?=
 =?utf-8?B?QUlObkpWSEdkRlZOekdMdjkrVWlUU251M25WNVJ3WjlodkpRTUowYUFiYVI2?=
 =?utf-8?B?VGYvMjRtR3dqS1hVVmkzU1hUTDBqMm9MbGR0R3BObzJua1ZWVjJlRkdwV0tR?=
 =?utf-8?B?aE9MM0ZKTTZrWVlPMmh5ZVRuTWl0T0phNFFYZVVneENOL005MXhpQ0xsNE9i?=
 =?utf-8?B?d0ZybDFHeVNrRWN2UG5pQllmekRHRDFVR3JjZUYydk10OG1hODhqbWtjbzJI?=
 =?utf-8?B?UkFTZEdiL0tDK0dTRUdqcmNMR0o0ZmpkSVMyZjhaeDBMREp3YjREem13MHd3?=
 =?utf-8?B?WlM0SHFLT0pzRzhxRGJITWk0MDJ4WWlSdENUUi9xcVJ0MFNMR2FhK0xkVldR?=
 =?utf-8?B?MFVITEhza2o5RytHQnlUVTR4RU16YUo4TlRTZXpleFpaaXhlelVrbm1sZXZE?=
 =?utf-8?B?aEoxajhXdkZ1OWFFaUlWemVzMXRkTDZ2Q0Z6RnZCUHdVcnUrVGx2bzROL0R1?=
 =?utf-8?B?UVo5anExWHBteE9jZ25Zb0RTMkF2YVdYRExSM3NhWUpINzY3eERCRFpaR3FE?=
 =?utf-8?B?blBJak1yRkVNVVoreXVYSjQ1MzF1eU8rZWxxbTRsMmxXNGxVeDlnNVdiS2xq?=
 =?utf-8?B?VW9BeHJUT2crNDRnOXBsbk9vREZWUi8xd3NHTDBMQ1RaM1c1TXQ5RWdyM21h?=
 =?utf-8?B?RTg4eHhlNWc5MmRxK0I0Q1dDUDZHL3I5YXdIMmhvZFZVUENZamdoYzg4aTc2?=
 =?utf-8?B?ZkpLUVN4VVlJbzA5OEo3dXhEZkI5ZnBLWUphMWE1OXJ2TzcySUt4c1VaUlFI?=
 =?utf-8?B?Z283VWdsWHk4cW8zcU11QmlxZWF2M3N4OTRIWUlmV3RWRTJHM29lVVRuSnJk?=
 =?utf-8?B?Y1cvTHdoUDI2U0RVci9ZS0w0MkRCR1NTbTZMODVOOUxkaWpZV1d3a1phN1Bm?=
 =?utf-8?B?aXRuQzRJaXdzcVFlTU0rcVdyV1FpK3B5ZXNGYUg5alpEeGRBbFEycmdoQ2ht?=
 =?utf-8?B?eXp2NllSWUxEZ0plck1SZEsreVJYUHdqUmswNUE4dWlaL2ptYjJ5YzgyOG5E?=
 =?utf-8?B?Zk8waDJDSkF3RGl3aEV5MzROVGYxZEdJa3JJT2owR0xHbm5wbDF0R0tLc3FV?=
 =?utf-8?B?d2dDN2R3ZHZXdjRoN2FPS20wUkR4WEtrYmVVMldnelQ3MmJsRjBhdmRxREkz?=
 =?utf-8?B?YXBUNnBlTTNGQ3hlWFZlVi9QUlhSNUNoMVl5N1lmTzM3VFJwZUxCSnU2dnVs?=
 =?utf-8?B?SkhMQVZaaS91WWQyOFU0aXNVUlpBbWV2KzM4ZSs1WDlJQmY5ajk4T3kvV3l2?=
 =?utf-8?B?S3JnVUpRak5MTWNTVUd6eDM2b3ViV2RyREkycGhvV2VyRWVUSThmbzA3aUZQ?=
 =?utf-8?B?OVFObkVtVXRpdElKeFFTMk1QcHE0RzBDSlA0NSs1RkJjMzE0WUxQdFQ0U2RE?=
 =?utf-8?B?RXozYUd5dHkxL2JNOExQTEt4OW1RL05aMlREam0wamZqSXRNL2UxUE83RUsx?=
 =?utf-8?B?aG5KalM2aHgyWVM2YllGbTZyczhWS0FhK1FlNWxNWEZ6eUYwWFhMTjdxODhV?=
 =?utf-8?B?T3FjWEp3OWFReFZicmFIVkxqSUpGdzRaMTc4WDNyY2s4aGR5U0JQZm1sM0xu?=
 =?utf-8?B?TWVQVnU4cEJTRkZJLytlWGFDdXUrN0ZXZnBGNStrdEM1d0JQWWI3WTV5YjNS?=
 =?utf-8?B?ZUhpVHNCZ3N6b3B3Z0YwZFpCTCtENkJWNStuanlFUmZ3djBZaG4xbUY0eFBM?=
 =?utf-8?B?UFh5UkcxVkVraFVBSC9KejY5cm9QUFhadlN1eU45bWliZE5lQVB6L2RXaGRy?=
 =?utf-8?B?N2xKNndVVXBKcGtVQ01nV0pTN2FLUVp6MGd5bHpDN0w1QXJ4UFh1MHBoNk50?=
 =?utf-8?B?STYrMWRiY3RQdEpHaUdveXp2Mk9Bc296WGZTSGkzaS81bDFhZFhsT3dFb0Ey?=
 =?utf-8?B?VnJ4MGdWdUlwWDlVbUd0NlRhek9PTEJDK3plM1FabU1iRFlhUVdMaE5aYVBY?=
 =?utf-8?B?cTBpTGVrV0xHNzUvc3ZnMmxuS2VRN2RLOCtLYjVGSHVwdDM3KzNuZ0ZsdCtV?=
 =?utf-8?Q?JoH8ZowSgJc9MzPZxFCzacc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D96EBC6D14AE84E8C99F450D1A1FF07@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 016c2801-988b-4b96-10ff-08dd46ed7803
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 20:33:09.0676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +nqb/MPBisfze56uvAoBFVvQSgSTh2KG7PZ7ayIHtoGUB2KaOb42fuTyHB1lu7FxT6uRraPZG7kbxeCBknz8xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6522
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI1LTAyLTA1IGF0IDEyOjQ3IC0wODAwLCBJYW4gUm9nZXJzIHdyb3RlOg0KPiBP
biBXZWQsIEZlYiA1LCAyMDI1IGF0IDExOjQ04oCvQU0gRmFsY29uLCBUaG9tYXMNCj4gPHRob21h
cy5mYWxjb25AaW50ZWwuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBXZWQsIDIwMjUtMDItMDUg
YXQgMDk6MzEgLTA4MDAsIElhbiBSb2dlcnMgd3JvdGU6DQo+ID4gPiBVcGRhdGUgdGhlIEludGVs
IHZlbmRvciBldmVudHMgdG8gdGhlIGxhdGVzdC4NCj4gPiA+IFVwZGF0ZSB0aGUgbWV0cmljcyB0
byBUTUEgNS4wMS4NCj4gPiA+IEFkZCBBcnJvd2xha2UgYW5kIENsZWFyd2F0ZXJmb3Jlc3Qgc3Vw
cG9ydC4NCj4gPiA+IEFkZCBtZXRyaWNzIGZvciBMTkwgYW5kIEdOUi4NCj4gPiA+IEFkZHJlc3Mg
SUlPIHVuY29yZSBpc3N1ZSBzcG90dGVkIG9uIEVNUiwgR1JSLCBHTlIsIFNQUiBhbmQgU1JGLg0K
PiA+ID4gDQo+ID4gPiBUaGUgcGVyZiBqc29uIHdhcyBnZW5lcmF0ZWQgdXNpbmcgdGhlIHNjcmlw
dDoNCj4gPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC9wZXJmbW9uL2Jsb2IvbWFpbi9zY3Jp
cHRzL2NyZWF0ZV9wZXJmX2pzb24ucHkNCj4gPiA+IHdpdGggdGhlIGdlbmVyYXRlZCBqc29uIGJl
aW5nIGluOg0KPiA+ID4gaHR0cHM6Ly9naXRodWIuY29tL2ludGVsL3BlcmZtb24vdHJlZS9tYWlu
L3NjcmlwdHMvcGVyZg0KPiA+ID4gDQo+ID4gPiBUaGFua3MgdG8gUGVycnkgVGF5bG9yIDxwZXJy
eS50YXlsb3JAaW50ZWwuY29tPiwgQ2FsZWIgQmlnZ2Vycw0KPiA+ID4gPGNhbGViLmJpZ2dlcnNA
aW50ZWwuY29tPiwgRWR3YXJkIEJha2VyIDxlZHdhcmQuYmFrZXJAaW50ZWwuY29tPiwNCj4gPiA+
IFdlaWxpbiBXYW5nIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+LCBLYW4gTGlhbmcNCj4gPiA+IDxr
YW4ubGlhbmdAbGludXguaW50ZWwuY29tPiBhbmQgVGhvbWFzIEZhbGNvbg0KPiA+ID4gPHRob21h
cy5mYWxjb25AaW50ZWwuY29tPiBmb3IgaGVscGluZyBnZXQgdGhpcyBwYXRjaCBzZXJpZXMNCj4g
PiA+IHRvZ2V0aGVyLg0KPiA+ID4gDQo+ID4gPiB2NTogUmVtb3ZlIFZhbGt5cmllIG1ldHJpY3Mg
bWlzdGFrZW5seSBhZGRlZCBvbiBhdG9tLiBFbnN1cmUNCj4gPiA+ICJwZXJmDQo+ID4gPiBhbGwN
Cj4gPiA+IMKgwqDCoCBtZXRyaWNzIHRlc3QiIGRvZXNuJ3Qgc2tpcCBmb3IgbWlzc2luZyBldmVu
dHMuDQo+ID4gPiB2NDogRml4IFRTQyBldmVudHMgb24gaHlicmlkIG1pc3Rha2VubHkgc3BlY2lm
eWluZyB0aGUgY29yZSBQTVUNCj4gPiA+IMKgwqDCoCBpbmhpYml0aW5nIHRoZSB1c2Ugb2YgdGhl
IG1zciBQTVUuDQo+ID4gPiB2MzogRml4ZXMgZm9yIGh5YnJpZCBtZXRyaWNzIHRoYXQgd2VyZSBt
aXNzaW5nIFBNVS4gVXBkYXRlIHRvIHRoZQ0KPiA+ID4gwqDCoMKgIGxhdGVzdCBldmVudHMuDQo+
ID4gPiB2MjogRml4IGh5YnJpZCBhbmQgQ28tYXV0aG9yZWQtYnkgdGFnIGlzc3VlcyByZXBvcnRl
ZCBieQ0KPiA+ID4gwqDCoMKgIEFybmFsZG8uIFVwZGF0ZXMgdG8gTHVuYXJsYWtlIGFuZCBNZXRl
b3JsYWtlIGV2ZW50cy4gQWRkaXRpb24NCj4gPiA+IG9mDQo+ID4gPiDCoMKgwqAgQ2xlYXJ3YXRl
cmZvcmVzdC4NCj4gPiA+IA0KPiA+IA0KPiA+IFRoYW5rcywgSSdtIHNlZWluZyBzb21lIGVycm9y
cyBkdXJpbmcgdGhlIHBlcmYgYWxsIG1ldHJpY3MgdGVzdDoNCj4gPiANCj4gPiBNZXRyaWMgJ3Rt
YV9pbmZvX3N5c3RlbV9jcHVzX3V0aWxpemVkJyBub3QgcHJpbnRlZCBpbjoNCj4gPiBldmVudCBz
eW50YXggZXJyb3I6ICd7Y3B1X2NvcmUvVFNDLG1ldHJpYy0NCj4gPiBpZD1jcHVfY29yZSEzVFND
ITMvLGNwdV9jb3JlL0NQVV9DTC4uJw0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBcX19fIEJhZCBldmVudCBvciBQTVUNCj4gPiANCj4gPiBVbmFibGUgdG8g
ZmluZCBQTVUgb3IgZXZlbnQgb24gYSBQTVUgb2YgJ2NwdV9jb3JlJw0KPiA+IA0KPiA+IGV2ZW50
IHN5bnRheCBlcnJvcjogJ3tjcHVfY29yZS9UU0MsbWV0cmljLQ0KPiA+IGlkPWNwdV9jb3JlITNU
U0MhMy8sY3B1X2NvcmUvQ1BVX0NMLi4nDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFxfX18gdW5rbm93biB0ZXJtICdUU0Mn
IGZvciBwbXUNCj4gPiAnY3B1X2NvcmUnDQo+ID4gDQo+ID4gdmFsaWQgdGVybXM6DQo+ID4gZXZl
bnQscGMsZWRnZSxvZmZjb3JlX3JzcCxsZGxhdCxpbnYsdW1hc2ssZnJvbnRlbmQsY21hc2ssY29u
ZmlnLGNvbg0KPiA+IGZpZzENCj4gPiAsY29uZmlnMixjb25maWczLG5hbWUscGVyaW9kLHBlcmNv
cmUsbWV0cmljLWlkDQo+ID4gDQo+ID4gZXZlbnQgc3ludGF4IGVycm9yOiAne2NwdV9jb3JlL1RT
QyxtZXRyaWMtDQo+ID4gaWQ9Y3B1X2NvcmUhM1RTQyEzLyxjcHVfY29yZS9DUFVfQ0wuLicNCj4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgXF9fXyB1bmtub3duIHRlcm0gJ1RTQycgZm9yIHBtdQ0KPiA+ICdjcHVfY29yZScNCj4g
PiANCj4gPiB2YWxpZCB0ZXJtczoNCj4gPiBldmVudCxwYyxlZGdlLG9mZmNvcmVfcnNwLGxkbGF0
LGludix1bWFzayxmcm9udGVuZCxjbWFzayxjb25maWcsY29uDQo+ID4gZmlnMQ0KPiA+ICxjb25m
aWcyLGNvbmZpZzMsbmFtZSxwZXJpb2QscGVyY29yZSxtZXRyaWMtaWQNCj4gPiANCj4gPiBUaGVy
ZSBhcmUgYWxsIHNvbWUgZXJyb3JzIGxpa2UgdGhpcywNCj4gPiANCj4gPiBUZXN0aW5nIHRtYV9j
aXNjDQo+ID4gTWV0cmljIGNvbnRhaW5zIG1pc3NpbmcgZXZlbnRzDQo+ID4gQ2Fubm90IHJlc29s
dmUgSURzIGZvciB0bWFfY2lzYzogY3B1X2F0b21AVE9QRE9XTl9GRV9CT1VORC5DSVNDQCAvDQo+
ID4gKDUgKg0KPiA+IGNwdV9hdG9tQENQVV9DTEtfVU5IQUxURUQuQ09SRUApDQo+ID4gDQo+IA0K
PiBUaGFua3MsIEkgZm9yZ290IHRvIHJlYXBwbHkgdGhlIFRTQyBmaXguIFlvdSBjYW4gZG8gaXQg
d2l0aA0KPiAkIGZpbmQgdG9vbHMvcGVyZi9wbXUtZXZlbnRzL2FyY2gveDg2IC10eXBlIGYgLWV4
ZWMgc2VkIC1pDQo+ICdzL2NwdV9jb3JlQFRTQ0AvVFNDL2cnIHt9IFw7DQo+IEkgY2FuJ3QgZXll
YmFsbCB0aGlzIGxhdGVyIG1pc3NpbmcgZXZlbnRzIHByb2JsZW0uIFdoYXQgbW9kZWwgdHlwZQ0K
PiBkb2VzIGl0IGhhcHBlbiBvbj8NCg0KVGhhbmtzLCBJIHdhcyB0ZXN0aW5nIG9uIEFsZGVyIExh
a2UsIHdoaWNoIHNlZW1zIG9rIG5vdyBvdGhlciB0aGFuIHRoZQ0KIkNhbm5vdCByZXNvbHZlIElE
cy4uLiIgZXJyb3JzIGFmdGVyIHlvdXIgVFNDIGNoYW5nZS4gSSBhbSBzZWVpbmcNCnNpbWlsYXIg
ZXJyb3JzIG9uIGFuIEFycm93IExha2UgdGhvdWdoIGFzIHdlbGwgYXMgdGhlc2UgZXJyb3JzOg0K
DQpNZXRyaWMgJ0M3X1BrZ19SZXNpZGVuY3knIG5vdCBwcmludGVkIGluOg0KZXZlbnQgc3ludGF4
IGVycm9yOiAne2NzdGF0ZV9wa2cvYzctcmVzaWRlbmN5LG1ldHJpYy0NCmlkPWNzdGF0ZV9wa2ch
M2M3ITFyZXNpZC4uJw0KICAgICAgICAgICAgICAgICAgICAgIFxfX18gQmFkIGV2ZW50IG9yIFBN
VQ0KDQpVbmFibGUgdG8gZmluZCBQTVUgb3IgZXZlbnQgb24gYSBQTVUgb2YgJ2NzdGF0ZV9wa2cn
DQoNCmV2ZW50IHN5bnRheCBlcnJvcjogJ3tjc3RhdGVfcGtnL2M3LXJlc2lkZW5jeSxtZXRyaWMt
DQppZD1jc3RhdGVfcGtnITNjNyExcmVzaWQuLicNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFxfX18gdW5rbm93biB0ZXJtICdjNy1yZXNpZGVuY3knIGZvcg0KcG11ICdjc3RhdGVf
cGtnJw0KDQp2YWxpZCB0ZXJtczoNCmV2ZW50LGNvbmZpZyxjb25maWcxLGNvbmZpZzIsY29uZmln
MyxuYW1lLHBlcmlvZCxwZXJjb3JlLG1ldHJpYy1pZA0KDQpldmVudCBzeW50YXggZXJyb3I6ICd7
Y3N0YXRlX3BrZy9jNy1yZXNpZGVuY3ksbWV0cmljLQ0KaWQ9Y3N0YXRlX3BrZyEzYzchMXJlc2lk
Li4nDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcX19fIHVua25vd24gdGVybSAn
YzctcmVzaWRlbmN5JyBmb3INCnBtdSAnY3N0YXRlX3BrZycNCg0KdmFsaWQgdGVybXM6DQpldmVu
dCxjb25maWcsY29uZmlnMSxjb25maWcyLGNvbmZpZzMsbmFtZSxwZXJpb2QscGVyY29yZSxtZXRy
aWMtaWQNClRlc3RpbmcgQzhfUGtnX1Jlc2lkZW5jeQ0KVGVzdGluZyBDOV9Qa2dfUmVzaWRlbmN5
DQpNZXRyaWMgJ0M5X1BrZ19SZXNpZGVuY3knIG5vdCBwcmludGVkIGluOg0KZXZlbnQgc3ludGF4
IGVycm9yOiAne2NzdGF0ZV9wa2cvYzktcmVzaWRlbmN5LG1ldHJpYy0NCmlkPWNzdGF0ZV9wa2ch
M2M5ITFyZXNpZC4uJw0KICAgICAgICAgICAgICAgICAgICAgIFxfX18gQmFkIGV2ZW50IG9yIFBN
VQ0KDQpVbmFibGUgdG8gZmluZCBQTVUgb3IgZXZlbnQgb24gYSBQTVUgb2YgJ2NzdGF0ZV9wa2cn
DQoNCmV2ZW50IHN5bnRheCBlcnJvcjogJ3tjc3RhdGVfcGtnL2M5LXJlc2lkZW5jeSxtZXRyaWMt
DQppZD1jc3RhdGVfcGtnITNjOSExcmVzaWQuLicNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFxfX18gdW5rbm93biB0ZXJtICdjOS1yZXNpZGVuY3knIGZvcg0KcG11ICdjc3RhdGVf
cGtnJw0KDQp2YWxpZCB0ZXJtczoNCmV2ZW50LGNvbmZpZyxjb25maWcxLGNvbmZpZzIsY29uZmln
MyxuYW1lLHBlcmlvZCxwZXJjb3JlLG1ldHJpYy1pZA0KDQpldmVudCBzeW50YXggZXJyb3I6ICd7
Y3N0YXRlX3BrZy9jOS1yZXNpZGVuY3ksbWV0cmljLQ0KaWQ9Y3N0YXRlX3BrZyEzYzkhMXJlc2lk
Li4nDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcX19fIHVua25vd24gdGVybSAn
YzktcmVzaWRlbmN5JyBmb3INCnBtdSAnY3N0YXRlX3BrZycNCg0KdmFsaWQgdGVybXM6DQpldmVu
dCxjb25maWcsY29uZmlnMSxjb25maWcyLGNvbmZpZzMsbmFtZSxwZXJpb2QscGVyY29yZSxtZXRy
aWMtaWQNClRlc3RpbmcgdG1hX2luZm9fY29yZV9lcGMNClRlc3RpbmcgdG1hX2luZm9fc3lzdGVt
X2NvcmVfZnJlcXVlbmN5DQpUZXN0aW5nIHRtYV9pbmZvX3N5c3RlbV9wb3dlcg0KVGVzdGluZyB0
bWFfaW5mb19zeXN0ZW1fdHVyYm9fdXRpbGl6YXRpb24NClRlc3RpbmcgdG1hX2luZm9faW5zdF9t
aXhfaXBzd3BmDQpUZXN0aW5nIHRtYV9pbmZvX21lbW9yeV9wcmVmZXRjaGVzX3VzZWxlc3NfaHdw
Zg0KVGVzdGluZyB0bWFfaW5mb190aHJlYWRfaXBjDQpUZXN0aW5nIHRtYV9oZWF2eV9vcGVyYXRp
b25zDQpUZXN0aW5nIHRtYV9saWdodF9vcGVyYXRpb25zDQpUZXN0aW5nIFVOQ09SRV9GUkVRDQpN
ZXRyaWMgJ1VOQ09SRV9GUkVRJyBub3QgcHJpbnRlZCBpbjoNCmV2ZW50IHN5bnRheCBlcnJvcjog
J3tVTkNfQ0xPQ0suU09DS0VUL21ldHJpYy0NCmlkPVVOQ19DTE9DSy5TT0NLRVQvfTpXLGR1cmF0
aW8uLicNCiAgICAgICAgICAgICAgICAgICAgICBcX19fIEJhZCBldmVudCBvciBQTVUNCg0KVW5h
YmxlIHRvIGZpbmQgUE1VIG9yIGV2ZW50IG9uIGEgUE1VIG9mICdVTkNfQ0xPQ0suU09DS0VUJw0K
VGVzdGluZyB0bWFfaW5mb19zeXN0ZW1fc29ja2V0X2Nsa3MNCk1ldHJpYyAndG1hX2luZm9fc3lz
dGVtX3NvY2tldF9jbGtzJyBub3QgcHJpbnRlZCBpbjoNCmV2ZW50IHN5bnRheCBlcnJvcjogJ3tV
TkNfQ0xPQ0suU09DS0VUL21ldHJpYy1pZD1VTkNfQ0xPQ0suU09DS0VUL306VycNCiAgICAgICAg
ICAgICAgICAgICAgICBcX19fIEJhZCBldmVudCBvciBQTVUNCg0KVW5hYmxlIHRvIGZpbmQgUE1V
IG9yIGV2ZW50IG9uIGEgUE1VIG9mICdVTkNfQ0xPQ0suU09DS0VUJw0KDQpJIHN1Ym1pdHRlZCBh
IFBSIHRvIHBlcmZtb24gZm9yIHRoZSBjNy9jOS1yZXNpZGVuY3kgZXJyb3JzLg0KDQpUb20NCg0K
PiBUaGFua3MsDQo+IElhbg0KPiANCg0K
