Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D2813C809;
	Mon,  5 Aug 2024 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722889181; cv=fail; b=BbaBYsMpd6mSYHXeOYjb/+JOT6P1rBo1sJr+MTGPqyelPsGUawDi1kIxzCxNqmSYXPlu/3LqJEfuwZGf7E18QENvUjnZPd/Ipt30oE4nqx/4wq+E7Qee1VBsqFxdw40TsCwdQ6zBWAWBHNtWqQiw+PG4i3SSanh8pLsN8cPfWYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722889181; c=relaxed/simple;
	bh=1YFDV87MwhbJJPSwIJ5fyC8bKgxpGnHWRTUe1TXoT0I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pBRT06tzcEsKrY6UCrHud07OjNpNio+Nc4U2Xinjb8r5/yoJ9o4N7P0r7lvRqAzZZbUCL5sooiuk6WGfysCMdMow8e4M9yjPGg1Jy5Yy3QLWGeSEfSCtC9efuj2flazBqP694HND4dlkUgEO6kAEaE2Ua1DmI8yFICOFsLD9q6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oLAT5bpG; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oLAT5bpG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722889179; x=1754425179;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1YFDV87MwhbJJPSwIJ5fyC8bKgxpGnHWRTUe1TXoT0I=;
  b=oLAT5bpGi6w1yVDZNN8DkFJVzNacMrQrwgYdhnfCFoMoYuwAAJ/9jCf4
   FVoD3hJHLZighKp3SwoSMrK2KkedaX4GxJWyzui3xoGJj0Vu93VMu4dFB
   cy+pvNO2wc8hXjR6X3nfFkBX+2kqwGcPIAFMKEEeQOpIkcJY6sv7Q3OuH
   plSuIQ55J+X7wikbx+rA2mM0y+/mNmhrn43c68Y/RIL/S5gGR2WUqSL5Z
   GVX6JsM1qcvjopDYCb8TLiEzddLv0JDTeL+sP7X7Mc4hszbnK8/kM+UoJ
   vmbZ8fFo8yCgkYTDMyGMwZNUWALYnVLike1iONvMhJyNSeqLcnhsOJjhi
   Q==;
X-CSE-ConnectionGUID: ASgWv1+TSLmpVct4qiAa9g==
X-CSE-MsgGUID: sk/uWth5QuSRQKDXRqCDrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="38384274"
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="38384274"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 13:19:39 -0700
X-CSE-ConnectionGUID: kD3kZ5lXQ+uZk4DGNjfpDw==
X-CSE-MsgGUID: 1vP90QU+SqK7vUsFhWeJNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="56209160"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Aug 2024 13:19:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 13:19:38 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 13:19:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 5 Aug 2024 13:19:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 13:19:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDIuuYGjyAPKBMxcM4EFcr8MZW7FRCUloLgxJeW4G3HZyxk+TWaONCIBhE8YF7q7s3xVc8edEMN5VW+e14AEEPyTGmzu/IIVmXaJrcIqXE9qhBae21cIJII6zeqP24qHGlfDxB+fPksSS3eZ5Pqc/ASIUIzLQX9ng7NgizwMNlIoUr9JQGhUGKZ48x272qMALBWedFf/EROEuoVlIeGDdXI+OQ6JL+ekJjw+6Zh7GLRnepgKv751uo74BQpNLrxdwHBPAyF4dzd+dDHcDbEoovRygGYF8uioKUx057eVKGgPt9XVVdbFTyZP+lPaK6dmCn6afbfFp18Zvos4zfb6+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YFDV87MwhbJJPSwIJ5fyC8bKgxpGnHWRTUe1TXoT0I=;
 b=gxdT8tj+zgjHsduKJ0VWy68Sb9xGygjw1dBo3oadniB1PdvDg/exUaLczA5LXmndfLLOTaErF8/gpIt1mGXFsinwXfoE5QqPEXBg/939bLKAZ9s5wGn//pHGg5cFZILGCw6RC7nwe1k08Zyh3zIACHKVVCggncPbqFB15krnU36OgyMPfgLQ1LdsyPU69qeZ2jczTR8ag7znyH4EgWv8oLxB6Q2PveziPdzWWe+wJNiYB+fzRGth7LL4Huc2BuwvAA31GusLps/WWGxA6Su9u/Mhgb4AzBuHpOEGPhjXefXJUi5GQPborEvOq8DQlqtKkqU9XiPlGHyX+3EOaxmtkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by CY8PR11MB7195.namprd11.prod.outlook.com (2603:10b6:930:93::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Mon, 5 Aug
 2024 20:19:34 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 20:19:34 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	"Peter Zijlstra" <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	"Alexander Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>, Kan Liang
	<kan.liang@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb"
	<caleb.biggers@intel.com>
Subject: RE: [RFC PATCH v18 3/8] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Thread-Topic: [RFC PATCH v18 3/8] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Thread-Index: AQHa2m0RzlLGrVs/lUq8Aq20b+fv/7IZKc+AgAAAuQCAAAm9MA==
Date: Mon, 5 Aug 2024 20:19:34 +0000
Message-ID: <CO6PR11MB563537571CA9C266C14DA1EEEEBE2@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240720062102.444578-1-weilin.wang@intel.com>
 <20240720062102.444578-4-weilin.wang@intel.com> <ZrEqr36sukDW66uV@x1>
 <ZrErSvqHMvzw3dm2@x1>
In-Reply-To: <ZrErSvqHMvzw3dm2@x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|CY8PR11MB7195:EE_
x-ms-office365-filtering-correlation-id: 6a3c27ce-1630-4a2e-309d-08dcb58bebf6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?anRzYUtEdFVQbVM1MTIvMFdBRTRXS2NGcWxBM2JtUnJjOEtwTThXeVB5Z2RJ?=
 =?utf-8?B?NHNFTDNlQ2h5Q0JmS1N6dXBJN0RnOFVuSXhGWDZKaGw2L2xRK0kwS05CVVhD?=
 =?utf-8?B?QVhFUW9xQVVMbXYzTVN3ckJQSHAyTkNMV2FQMDc2Y0xBaCtPOXA2VHBvN2dt?=
 =?utf-8?B?Y2VpVEU3ZUszcFhoY0EvK2JMSXZBbmo0bzcvZW1zaVIwckNYUkc5QkplVmR4?=
 =?utf-8?B?TFFHRzN4cXNOQ3A4TXNpMERtdjlPYWJGZEZsVDhZK1o4L1dlcEhoa3RoTTZO?=
 =?utf-8?B?OHNTOUNsSEhWK0NvVW9aV1FqY2hjQldGTUxnMHFWYnIrYjRjWWtCQWVWVjlW?=
 =?utf-8?B?aXhUYVdVMjNSOG1Bb0tndzBGbjBCMU40K2h3S1RlNFUvbXVOa2tlZkNJc0xG?=
 =?utf-8?B?S3dDaXE5SXY5clBVb0h0OTVINzhQaC9xM1JRak9tRjdETnI1c1J6b1BZVktj?=
 =?utf-8?B?bjRFZFNnTURKRVhvWUlhdVk5VkU5aFhyVFdoczIvWUErZW1CSlEzUmRXZEZz?=
 =?utf-8?B?Y25vaHI5ak9Tb2N4TkdKWk9uazNYZlZvam51VFdEVWJQK2JoMmFYMVpIVG5R?=
 =?utf-8?B?em9HM0MwVjRyMHZTRXJVSXA1TEZQRmFOQW94MzlCaGhrVE9ZUjUrakh6a1pr?=
 =?utf-8?B?eE9iQnJOTlJSZ3RHbWtrT1pyb1UvWlVjcmE1VkJuOUZ0WWdhU2pjSVFDeU1W?=
 =?utf-8?B?MG9Ga0xMVHpZRm8zZktFb2VldnFEc3V1RFRJMTJQb1piK1JERFpDWUp6eDMx?=
 =?utf-8?B?dndQZ0tiemptU2FoMk95WmVEd05Sb3hYSUd2TUlUam9EbXp4Zzk0azhqTlZU?=
 =?utf-8?B?TXNaZXdYTFhEeXNqQ21xSFF3ZGIrOGlvQ05UZlRFWU5lNWRIelp1SWJEK2FY?=
 =?utf-8?B?Q0NPdlVSdHZZWlZWUlp5UzJlajVBU2dRUnZrNXFsdlZKcEJiSlpDS0htUUJS?=
 =?utf-8?B?RExETHJ6Tm9tSzdtY0FjSlkvYUlrK1FFM3RMRkY3R3k2UTg2d3U2c096Ukwr?=
 =?utf-8?B?Qm1VaVg5L1g3T3owcTZqS1BSVExqNkwxcVo0VGJJWTBQcHBta1FNVVRCL25t?=
 =?utf-8?B?N2x5VUhycllHQlY2aFo5VFpQdi9oMmdTNEtVSGI3WjNKK014T3pTVWx5UjV6?=
 =?utf-8?B?T2I1VHhyZjFxSmlWVDBra0p2cTNCTm9ORjMyakJXcCt5NWgxRXZXZzBVSHZE?=
 =?utf-8?B?cmhmbzVtUFpPT0FUYzBXQy9lbThNcTJiY0NTU2RocC85Mm1LQnZrYUg1dk0x?=
 =?utf-8?B?SFN2em9VSG5MUDB0V2JTdks4VWR3MVluM09oNjFHQ2JmN3NNVzBIUnBOcUpj?=
 =?utf-8?B?ZkptampjWks0TmpOaVJUSkhKeUU0OWVSVUtocUpZd1V1aC9pUlhIOHMzVG9J?=
 =?utf-8?B?UzZORFJ4cXQzVkxaMGI3eTVWUTdwaWlzbkN0TzJxUXlZM0xPUVFJdXZBd3Bw?=
 =?utf-8?B?Z3RGdzhqUzlVK0JBWGI3TlVvTTNMeDFheTFjalNCYUlOMC9TNDVZaTJUSEt0?=
 =?utf-8?B?eU1TdExnUFdZdm5vU0ZwZE8rejJ0NEVQNmVxVmFucjV5OHRwMzBWdnJlQ0Yy?=
 =?utf-8?B?Z1F4cWFKeEVYTnNtQmZUemhNdjR3djVQMlJqbzRNMXdFWTJBekZtVEhBdHdx?=
 =?utf-8?B?R0ZmZlFia3R3MWgzVTNIekpaSU9ROGVGYkxLTWd6UGNvbDhCN1RIZXQ2emVv?=
 =?utf-8?B?MnJzR01HRFpLT0dESXV6cmdITHRjaFA2c0RRYW8xZHh5Q3RwNlozaldReGV4?=
 =?utf-8?B?eThSY1hySUUyWTcvNFdiS0R0dm8yelo0U2k0SkVRMTF1WlJWTjhzZThBMHk3?=
 =?utf-8?Q?u/iAvJDAb2qKAql/LCM47eI/1Vo4NW9VZPfcI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bldCREEyb3NSUmJ4WFRvbFdyWDJRalNYOVRFV1ZYV00xUHhTT3YvVEVwY1py?=
 =?utf-8?B?dHZYR2Z1cVJQMXdYaDlYWlRDVk8vSjdZcWJjTzRPbGhZTDY3YUk4SmZmZ254?=
 =?utf-8?B?WW1aWHR2cjVka1JZN2xLb1krdTdYbnZmTHh3NGt2eVdnMGp0UjI0ZTNuTDNw?=
 =?utf-8?B?dWZkS0l1VkpFeDRTVkdaY0toa2hoYmExN1dqcmFTdkVKOGFES25ZYWIrVEZn?=
 =?utf-8?B?NEtqK0M5d3ppa2JhdHU3T1dEWWdYK0oxenQzbDJXWnZEaTJYWlM5Vk9aeFNO?=
 =?utf-8?B?My8ybllaT09rN2pXeW0rNllTbkFWSWJMU0tJaFU2ZzZDUjVIMGxuelFESVlO?=
 =?utf-8?B?Zm9LeWRJN1VtNG55L2hlQzFVL3FjSXZHOGJLZ1VXK0NuM0I4TU1Od3puZ1Jv?=
 =?utf-8?B?WnNYRzJsN1hFQUtXL1owM2NWZVZOaXRJbjd2VENFUXZOemRnZHI0cGVjMjN4?=
 =?utf-8?B?YmFCWkdJemFyTWxRNm5oMUJvNmszYnl3UHBFdXMrbnlRS2dLN2RLOGdSNHNU?=
 =?utf-8?B?NWNxUk55eGs2RlZxRm1hVXVPS1Jmbk1YM0JUNTFSSjZqYmVQWFRzWUN0N0NY?=
 =?utf-8?B?RkE5UUVMSnNkNTZ3bExwUVVDamdNZWtJU3p6RFhWYUJvVENFUDBaN3ovQ2l4?=
 =?utf-8?B?RzZ6VXUvK2sybTFVQkVsZWJPMlhyRThabnAwdkJkMWtScXJDTlcvQTV5QTZP?=
 =?utf-8?B?Ny91WTJnQnBiNU1rZ1I0YUErR01mU01Wb1BvYjk4REE2WmVCc0lqUGowOUJX?=
 =?utf-8?B?MGd5cmpDS0NyWUNMYldoY2xhOWVyQ0NYOW9rRFdEazM0K09qOXJzaURQempF?=
 =?utf-8?B?STZOM3NYWm5hR2NkZVd0WU5Cbnpsb0xYQ1NlVENnVXlNbHQxeUJvejg3U20y?=
 =?utf-8?B?Ky93M3NiSWJjTDAwV1NmUTVrR2tCalFoK3NHaHNtVDZvMVhVZVhoOXVkWXRT?=
 =?utf-8?B?ek5EVnJoTkNyWEJZSlU2YmRrVVpMOW9UWmtvdlZMZDY3VmJmVU5FY3dyY2pE?=
 =?utf-8?B?Q2ROakZNaWY0ZlcvQ2U5TDE2UWI3dFo4d2J6SmgyaTZxMzljdUVCYVNmdURM?=
 =?utf-8?B?eUlReUl0WDQyUFNKUXh3bnFDN3pvTUlzaTVSd09TZGxVZDlHOU9IUE91cmpX?=
 =?utf-8?B?M0NrWDJEY2ZncktNVUdab3RJM2lma1VyS2FmdXVWakdLVVJOMVlMZUhFRmlq?=
 =?utf-8?B?R0xUdENnSWljQmRFbFZ6Tit2MzlnUGVQRGJFT1FyOFV4aE1ncGZwcjRWS1di?=
 =?utf-8?B?UDhSTU1JTzVsaVNVcFlVMXdnK2hGOGhlSVJiUmF2T1J4NlpKVyt3SDJVWFNQ?=
 =?utf-8?B?Qzc4MUpKdjZaNUpjL3ZhdWVEKzVDbHkwQkwxRTUvZG1ncEhRUWF5YldMUWVk?=
 =?utf-8?B?M3FtSm1NTmx0WWlnREpmekxJaGwrRDdDeGUxM01XZWMyelVFNUJVVTJaZDdq?=
 =?utf-8?B?eHdVTUdmYVNYTTdFMGtnSDN2cklNcVVSYzRvQVZ1OTdaVEE5UEJjYkdCT3VB?=
 =?utf-8?B?RUJ3aHpuaWVteVRJc0haRFE2UjZGOThtb0lESldaM3Q0SlpqbGZoNU9lM1hs?=
 =?utf-8?B?Q3hCRVQ3MnJLb28rTGJFVXRoVFNMQkliQWo3VEJST0J5Y1owNTIxZFcrcUgz?=
 =?utf-8?B?S0dXRWlFc3BpNWMrSUl0TzUxNTVoVUY0WStQRisxVjR2RDgvVVY4Zlk4YUtU?=
 =?utf-8?B?ZCswSVZvajFiNzB3SzJ5L2MyTldEd1g5ZCtWbkR1VXZSeEwwNTZPZEMvTFVx?=
 =?utf-8?B?L2pxdW5VdmR4MkRCRXJJcWxNeGx0Ty9QYmc3T01HNmxtM0c0dWRBYmlsNDdN?=
 =?utf-8?B?OHpITnV2aXlnSGtsSXRTY29hNERxYVpEYlluT1JOdjNTZ2dDbGJoUDlsZnF3?=
 =?utf-8?B?TEpMUHJZaDNGWjlZUGFmanlhU1ZmZG5aSXliZUI4OWRYUFBuR2hDWGNUek8x?=
 =?utf-8?B?T1hld2UvMm1PbFd6emRKYjNoN0I0NUpNbVBmTHpFdjNZZW9WYWhwK3ZOYVNm?=
 =?utf-8?B?djJ3ZE1VQ3gwL0pHRUZyM1h0ekZaSDZpc0ZuVk9jaHgxVE9KWXdScXUvYXhF?=
 =?utf-8?B?aGRVY0lYYW1uNFAzcHhrSXk1KzVHZFovY3Z2cmZYTVl4TlE2ZTIrcFczZWRR?=
 =?utf-8?Q?H9Iu1eA3glHMG3EQ99uMzmuHW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5635.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3c27ce-1630-4a2e-309d-08dcb58bebf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 20:19:34.3188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NLApsNsr1zjLOmARZRt+2dzz55IfEkpqKARY58UOCS3J6K7+B53kHF3+cja+rUBwXo2FVcJQrzl20lVh1Fxt8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7195
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJuYWxkbyBDYXJ2YWxo
byBkZSBNZWxvIDxhY21lQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgQXVndXN0IDUsIDIw
MjQgMTI6NDMgUE0NCj4gVG86IFdhbmcsIFdlaWxpbiA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0K
PiBDYzogTmFtaHl1bmcgS2ltIDxuYW1oeXVuZ0BrZXJuZWwub3JnPjsgSWFuIFJvZ2Vycw0KPiA8
aXJvZ2Vyc0Bnb29nbGUuY29tPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3Jn
PjsgSW5nbyBNb2xuYXINCj4gPG1pbmdvQHJlZGhhdC5jb20+OyBBbGV4YW5kZXIgU2hpc2hraW4N
Cj4gPGFsZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb20+OyBKaXJpIE9sc2EgPGpvbHNh
QGtlcm5lbC5vcmc+OyBIdW50ZXIsDQo+IEFkcmlhbiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+
OyBLYW4gTGlhbmcgPGthbi5saWFuZ0BsaW51eC5pbnRlbC5jb20+Ow0KPiBsaW51eC1wZXJmLXVz
ZXJzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgVGF5bG9y
LCBQZXJyeQ0KPiA8cGVycnkudGF5bG9yQGludGVsLmNvbT47IEFsdCwgU2FtYW50aGEgPHNhbWFu
dGhhLmFsdEBpbnRlbC5jb20+OyBCaWdnZXJzLA0KPiBDYWxlYiA8Y2FsZWIuYmlnZ2Vyc0BpbnRl
bC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYxOCAzLzhdIHBlcmYgc3RhdDogRm9y
ayBhbmQgbGF1bmNoIHBlcmYgcmVjb3JkIHdoZW4NCj4gcGVyZiBzdGF0IG5lZWRzIHRvIGdldCBy
ZXRpcmUgbGF0ZW5jeSB2YWx1ZSBmb3IgYSBtZXRyaWMuDQo+IA0KPiBPbiBNb24sIEF1ZyAwNSwg
MjAyNCBhdCAwNDo0MDozN1BNIC0wMzAwLCBBcm5hbGRvIENhcnZhbGhvIGRlIE1lbG8NCj4gd3Jv
dGU6DQo+ID4gT24gU2F0LCBKdWwgMjAsIDIwMjQgYXQgMDI6MjA6NTZBTSAtMDQwMCwgd2VpbGlu
LndhbmdAaW50ZWwuY29tIHdyb3RlOg0KPiA+ID4gRnJvbTogV2VpbGluIFdhbmcgPHdlaWxpbi53
YW5nQGludGVsLmNvbT4NCj4gPiA+DQo+ID4gPiBXaGVuIHJldGlyZV9sYXRlbmN5IHZhbHVlIGlz
IHVzZWQgaW4gYSBtZXRyaWMgZm9ybXVsYSwgZXZzZWwgd291bGQgZm9yayBhDQo+IHBlcmYNCj4g
PiA+IHJlY29yZCBwcm9jZXNzIHdpdGggIi1lIiBhbmQgIi1XIiBvcHRpb25zLiBQZXJmIHJlY29y
ZCB3aWxsIGNvbGxlY3QgcmVxdWlyZWQNCj4gPiA+IHJldGlyZV9sYXRlbmN5IHZhbHVlcyBpbiBw
YXJhbGxlbCB3aGlsZSBwZXJmIHN0YXQgaXMgY29sbGVjdGluZyBjb3VudGluZyB2YWx1ZXMuDQo+
ID4gPg0KPiA+ID4gQXQgdGhlIHBvaW50IG9mIHRpbWUgdGhhdCBwZXJmIHN0YXQgc3RvcHMgY291
bnRpbmcsIGV2c2VsIHdvdWxkIHN0b3AgcGVyZg0KPiByZWNvcmQNCj4gPiA+IGJ5IHNlbmRpbmcg
c2lndGVybSBzaWduYWwgdG8gcGVyZiByZWNvcmQgcHJvY2Vzcy4gU2FtcGxlZCBkYXRhIHdpbGwg
YmUNCj4gcHJvY2Vzcw0KPiA+ID4gdG8gZ2V0IHJldGlyZSBsYXRlbmN5IHZhbHVlLiBBbm90aGVy
IHRocmVhZCBpcyByZXF1aXJlZCB0byBzeW5jaHJvbml6ZQ0KPiBiZXR3ZWVuDQo+ID4gPiBwZXJm
IHN0YXQgYW5kIHBlcmYgcmVjb3JkIHdoZW4gd2UgcGFzcyBkYXRhIHRocm91Z2ggcGlwZS4NCj4g
PiA+DQo+ID4gPiBSZXRpcmVfbGF0ZW5jeSBldnNlbCBpcyBub3Qgb3BlbmVkIGZvciBwZXJmIHN0
YXQgc28gdGhhdCB0aGVyZSBpcyBubyBjb3VudGVyDQo+ID4gPiB3YXN0ZWQgb24gaXQuIFRoaXMg
Y29tbWl0IGluY2x1ZGVzIGNvZGUgc3VnZ2VzdGVkIGJ5IE5hbWh5dW5nIHRvIGFkanVzdA0KPiBy
ZWFkaW5nDQo+ID4gPiBzaXplIGZvciBncm91cHMgdGhhdCBpbmNsdWRlIHJldGlyZV9sYXRlbmN5
IGV2c2Vscy4NCj4gPg0KPiA+IEZhaWxpbmcgYXQgdGhpcyBwb2ludDoNCj4gPg0KPiA+IOKsolth
Y21lQHRvb2xib3ggcGVyZi10b29scy1uZXh0XSQgZ2l0IGxvZyAtLW9uZWxpbmUgLTUNCj4gPiAx
MzQzMDEzMWFjYzRmODhiIChIRUFEKSBwZXJmIHN0YXQ6IEZvcmsgYW5kIGxhdW5jaCBwZXJmIHJl
Y29yZCB3aGVuIHBlcmYNCj4gc3RhdCBuZWVkcyB0byBnZXQgcmV0aXJlIGxhdGVuY3kgdmFsdWUg
Zm9yIGEgbWV0cmljLg0KPiA+IGI3YjlhZGVmYjVkNTdhYWYgcGVyZiBkYXRhOiBBbGxvdyB0byB1
c2UgZ2l2ZW4gZmQgaW4gZGF0YS0+ZmlsZS5mZA0KPiA+IDNhNDQyYmYyNjZkMWYzYzcgcGVyZiBw
YXJzZS1ldmVudHM6IEFkZCBhIHJldGlyZW1lbnQgbGF0ZW5jeSBtb2RpZmllcg0KPiA+IGNlNTMz
YzliYzZkZWIxMjUgKHBlcmYtdG9vbHMtbmV4dC5rb3JnL3RtcC5wZXJmLXRvb2xzLW5leHQsDQo+
IGFjbWUua29yZy90bXAucGVyZi10b29scy1uZXh0KSBwZXJmIGFubm90YXRlOiBBZGQgLS1za2lw
LWVtcHR5IG9wdGlvbg0KPiA+IGJiNTg4ZTM4MjkwZmI3MjMgcGVyZiBhbm5vdGF0ZTogU2V0IGFs
LT5kYXRhX25yIHVzaW5nIHRoZSBub3Rlcy0+c3JjLQ0KPiA+bnJfZXZlbnRzDQo+ID4g4qyiW2Fj
bWVAdG9vbGJveCBwZXJmLXRvb2xzLW5leHRdJA0KPiA+DQo+ID4gSSdsbCBzZWUgaWYgd2hlbiBh
IGZvbGxvd3VwIHBhdGNoIGdldHMgYXBwbGllZCB0aGlzIGdldHMgc29sdmVkLCBpZiBzbw0KPiA+
IHdpbGwgdHJ5IHRvIGZpeHVwIHRoaW5ncyBvciBhc2sgZm9yIGhlbHAsIHNpbmNlIHRoaXMgc2Vl
bXMgdG8gYmUNCj4gPiBicmVha2luZyAnZ2l0IGJpc2VjdCcgZm9yIHRoaXMgY29kZWJhc2UuDQo+
IA0KPiBJbmRlZWQsIHdoZW4gdGhlIG5leHQgcGF0Y2ggZ2V0cyBhcHBsaWVkIGl0IGJ1aWxkcyB3
aXRob3V0IHByb2JsZW1zLg0KPiBJLmUuIHBhdGNoICA0LzggZml4ZXMgcHJvYmxlbXMgaW4gcGF0
Y2ggMy84LCBtYXliZSBqdXN0IGNvbWJpbmUgdGhlbQ0KPiBpbnRvIG9uZSBzaW5nbGUgcGF0Y2g/
DQo+IA0KSGkgQXJuYWxkbywgDQoNClBsZWFzZSBmZWVsIGZyZWUgdG8gY29tYmluZSB0aGVtLiBB
bmQgbGV0IG1lIGtub3cgaWYgdGhlcmUgaXMgYW55dGhpbmcgSSANCm5lZWQgdG8gZG8uDQoNClRo
YW5rcywNCldlaWxpbg0KDQo+IC0gQXJuYWxkbw0KPiANCj4gPiDirKJbYWNtZUB0b29sYm94IHBl
cmYtdG9vbHMtbmV4dF0kIG0NCj4gPiBybTogY2Fubm90IHJlbW92ZSAnL2hvbWUvYWNtZS9saWJl
eGVjL3BlcmYtY29yZS9zY3JpcHRzL3B5dGhvbi9QZXJmLQ0KPiBUcmFjZS1VdGlsL2xpYi9QZXJm
L1RyYWNlL19fcHljYWNoZV9fL0NvcmUuY3B5dGhvbi0zMTIucHljJzogUGVybWlzc2lvbg0KPiBk
ZW5pZWQNCj4gPiBtYWtlOiBFbnRlcmluZyBkaXJlY3RvcnkgJy9ob21lL2FjbWUvZ2l0L3BlcmYt
dG9vbHMtbmV4dC90b29scy9wZXJmJw0KPiA+ICAgQlVJTEQ6ICAgRG9pbmcgJ21ha2UgLWoyJyBw
YXJhbGxlbCBidWlsZA0KPiA+IFdhcm5pbmc6IEtlcm5lbCBBQkkgaGVhZGVyIGRpZmZlcmVuY2Vz
Og0KPiA+ICAgZGlmZiAtdSB0b29scy9pbmNsdWRlL3VhcGkvZHJtL2k5MTVfZHJtLmggaW5jbHVk
ZS91YXBpL2RybS9pOTE1X2RybS5oDQo+ID4gICBkaWZmIC11IHRvb2xzL2luY2x1ZGUvdWFwaS9s
aW51eC9rdm0uaCBpbmNsdWRlL3VhcGkvbGludXgva3ZtLmgNCj4gPiAgIGRpZmYgLXUgdG9vbHMv
aW5jbHVkZS91YXBpL2xpbnV4L2luLmggaW5jbHVkZS91YXBpL2xpbnV4L2luLmgNCj4gPiAgIGRp
ZmYgLXUgdG9vbHMvaW5jbHVkZS91YXBpL2xpbnV4L3BlcmZfZXZlbnQuaA0KPiBpbmNsdWRlL3Vh
cGkvbGludXgvcGVyZl9ldmVudC5oDQo+ID4gICBkaWZmIC11IHRvb2xzL2luY2x1ZGUvdWFwaS9s
aW51eC9zdGF0LmggaW5jbHVkZS91YXBpL2xpbnV4L3N0YXQuaA0KPiA+ICAgZGlmZiAtdSB0b29s
cy9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9jcHVmZWF0dXJlcy5oDQo+IGFyY2gveDg2L2luY2x1ZGUv
YXNtL2NwdWZlYXR1cmVzLmgNCj4gPiAgIGRpZmYgLXUgdG9vbHMvYXJjaC94ODYvaW5jbHVkZS9h
c20vbXNyLWluZGV4LmgNCj4gYXJjaC94ODYvaW5jbHVkZS9hc20vbXNyLWluZGV4LmgNCj4gPiAg
IGRpZmYgLXUgdG9vbHMvYXJjaC94ODYvaW5jbHVkZS91YXBpL2FzbS9rdm0uaA0KPiBhcmNoL3g4
Ni9pbmNsdWRlL3VhcGkvYXNtL2t2bS5oDQo+ID4gICBkaWZmIC11IHRvb2xzL2FyY2gveDg2L2lu
Y2x1ZGUvdWFwaS9hc20vc3ZtLmgNCj4gYXJjaC94ODYvaW5jbHVkZS91YXBpL2FzbS9zdm0uaA0K
PiA+ICAgZGlmZiAtdSB0b29scy9hcmNoL3Bvd2VycGMvaW5jbHVkZS91YXBpL2FzbS9rdm0uaA0K
PiBhcmNoL3Bvd2VycGMvaW5jbHVkZS91YXBpL2FzbS9rdm0uaA0KPiA+ICAgZGlmZiAtdSB0b29s
cy9hcmNoL2FybTY0L2luY2x1ZGUvdWFwaS9hc20vdW5pc3RkLmgNCj4gYXJjaC9hcm02NC9pbmNs
dWRlL3VhcGkvYXNtL3VuaXN0ZC5oDQo+ID4gICBkaWZmIC11IHRvb2xzL2luY2x1ZGUvdWFwaS9h
c20tZ2VuZXJpYy91bmlzdGQuaCBpbmNsdWRlL3VhcGkvYXNtLQ0KPiBnZW5lcmljL3VuaXN0ZC5o
DQo+ID4gICBkaWZmIC11IHRvb2xzL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vY3B1dHlwZS5oDQo+
IGFyY2gvYXJtNjQvaW5jbHVkZS9hc20vY3B1dHlwZS5oDQo+ID4gICBkaWZmIC11IHRvb2xzL2xp
Yi9saXN0X3NvcnQuYyBsaWIvbGlzdF9zb3J0LmMNCj4gPiAgIGRpZmYgLXUgdG9vbHMvcGVyZi9h
cmNoL3g4Ni9lbnRyeS9zeXNjYWxscy9zeXNjYWxsXzY0LnRibA0KPiBhcmNoL3g4Ni9lbnRyeS9z
eXNjYWxscy9zeXNjYWxsXzY0LnRibA0KPiA+ICAgZGlmZiAtdSB0b29scy9wZXJmL2FyY2gvcG93
ZXJwYy9lbnRyeS9zeXNjYWxscy9zeXNjYWxsLnRibA0KPiBhcmNoL3Bvd2VycGMva2VybmVsL3N5
c2NhbGxzL3N5c2NhbGwudGJsDQo+ID4gICBkaWZmIC11IHRvb2xzL3BlcmYvYXJjaC9zMzkwL2Vu
dHJ5L3N5c2NhbGxzL3N5c2NhbGwudGJsDQo+IGFyY2gvczM5MC9rZXJuZWwvc3lzY2FsbHMvc3lz
Y2FsbC50YmwNCj4gPiAgIGRpZmYgLXUgdG9vbHMvcGVyZi90cmFjZS9iZWF1dHkvaW5jbHVkZS9s
aW51eC9zb2NrZXQuaA0KPiBpbmNsdWRlL2xpbnV4L3NvY2tldC5oDQo+ID4gICBkaWZmIC11IHRv
b2xzL3BlcmYvdHJhY2UvYmVhdXR5L2luY2x1ZGUvdWFwaS9saW51eC9mcy5oDQo+IGluY2x1ZGUv
dWFwaS9saW51eC9mcy5oDQo+ID4gICBkaWZmIC11IHRvb2xzL3BlcmYvdHJhY2UvYmVhdXR5L2lu
Y2x1ZGUvdWFwaS9saW51eC9tb3VudC5oDQo+IGluY2x1ZGUvdWFwaS9saW51eC9tb3VudC5oDQo+
ID4gICBkaWZmIC11IHRvb2xzL3BlcmYvdHJhY2UvYmVhdXR5L2luY2x1ZGUvdWFwaS9saW51eC9z
dGF0LmgNCj4gaW5jbHVkZS91YXBpL2xpbnV4L3N0YXQuaA0KPiA+ICAgZGlmZiAtdSB0b29scy9w
ZXJmL3RyYWNlL2JlYXV0eS9pbmNsdWRlL3VhcGkvc291bmQvYXNvdW5kLmgNCj4gaW5jbHVkZS91
YXBpL3NvdW5kL2Fzb3VuZC5oDQo+ID4gZ2l0IHNob3dNYWtlZmlsZS5jb25maWc6MTIyMzogbGli
dHJhY2VmcyBpcyBtaXNzaW5nLiBQbGVhc2UgaW5zdGFsbCBsaWJ0cmFjZWZzLQ0KPiBkZXYvbGli
dHJhY2Vmcy1kZXZlbA0KPiA+DQo+ID4gQXV0by1kZXRlY3Rpbmcgc3lzdGVtIGZlYXR1cmVzOg0K
PiA+IC4uLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZHdhcmY6IFsgb24gIF0N
Cj4gPiAuLi4gICAgICAgICAgICAgICAgICAgICAgZHdhcmZfZ2V0bG9jYXRpb25zOiBbIG9uICBd
DQo+ID4gLi4uICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnbGliYzogWyBvbiAg
XQ0KPiA+IC4uLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsaWJiZmQ6IFsgb24g
IF0NCj4gPiAuLi4gICAgICAgICAgICAgICAgICAgICAgICAgIGxpYmJmZC1idWlsZGlkOiBbIG9u
ICBdDQo+ID4gLi4uICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxpYmNhcDogWyBv
biAgXQ0KPiA+IC4uLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsaWJlbGY6IFsg
b24gIF0NCj4gPiAuLi4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsaWJudW1hOiBb
IG9uICBdDQo+ID4gLi4uICAgICAgICAgICAgICAgICAgbnVtYV9udW1fcG9zc2libGVfY3B1czog
WyBvbiAgXQ0KPiA+IC4uLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxpYnBlcmw6
IFsgb24gIF0NCj4gPiAuLi4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbGlicHl0aG9u
OiBbIG9uICBdDQo+ID4gLi4uICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxpYmNyeXB0
bzogWyBvbiAgXQ0KPiA+IC4uLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsaWJ1bndp
bmQ6IFsgb24gIF0NCj4gPiAuLi4gICAgICAgICAgICAgICAgICAgICAgbGliZHctZHdhcmYtdW53
aW5kOiBbIG9uICBdDQo+ID4gLi4uICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsaWJjYXBz
dG9uZTogWyBvbiAgXQ0KPiA+IC4uLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHpsaWI6IFsgb24gIF0NCj4gPiAuLi4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBsem1hOiBbIG9uICBdDQo+ID4gLi4uICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdl
dF9jcHVpZDogWyBvbiAgXQ0KPiA+IC4uLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBicGY6IFsgb24gIF0NCj4gPiAuLi4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgbGliYWlvOiBbIG9uICBdDQo+ID4gLi4uICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgbGlienN0ZDogWyBvbiAgXQ0KPiA+DQo+ID4gICBJTlNUQUxMIGxpYnBlcmZfaGVhZGVycw0K
PiA+ICAgSU5TVEFMTCBsaWJhcGlfaGVhZGVycw0KPiA+ICAgSU5TVEFMTCBsaWJzdWJjbWRfaGVh
ZGVycw0KPiA+ICAgSU5TVEFMTCBsaWJzeW1ib2xfaGVhZGVycw0KPiA+ICAgUEVSRl9WRVJTSU9O
ID0gNi4xMS5yYzEuZzEzNDMwMTMxYWNjNA0KPiA+ICAgQ0MgICAgICAvdG1wL2J1aWxkL3BlcmYt
dG9vbHMtbmV4dC9wZXJmLXJlYWQtdmRzbzMyDQo+ID4gICBJTlNUQUxMIGxpYmJwZl9oZWFkZXJz
DQo+ID4gICBHRU4gICAgIHBlcmYtYXJjaGl2ZQ0KPiA+ICAgR0VOICAgICBwZXJmLWlvc3RhdA0K
PiA+ICAgQ0MgICAgICAvdG1wL2J1aWxkL3BlcmYtdG9vbHMtbmV4dC91dGlsL2V2bGlzdC5vDQo+
ID4gICBDQyAgICAgIC90bXAvYnVpbGQvcGVyZi10b29scy1uZXh0L2J1aWx0aW4tc3RhdC5vDQo+
ID4gICBDQyAgICAgIC90bXAvYnVpbGQvcGVyZi10b29scy1uZXh0L3V0aWwvZXZzZWwubw0KPiA+
ICAgTEQgICAgICAvdG1wL2J1aWxkL3BlcmYtdG9vbHMtbmV4dC9wZXJmLWluLm8NCj4gPiAgIExJ
TksgICAgL3RtcC9idWlsZC9wZXJmLXRvb2xzLW5leHQvbGlicGVyZi1qdm10aS5zbw0KPiA+ICAg
Q0MgICAgICAvdG1wL2J1aWxkL3BlcmYtdG9vbHMtbmV4dC91dGlsL2hlYWRlci5vDQo+ID4gdXRp
bC9ldnNlbC5jOiBJbiBmdW5jdGlvbiDigJhldnNlbF9fZ3JvdXBfaGFzX3RwZWJz4oCZOg0KPiA+
IHV0aWwvZXZzZWwuYzoxNTYyOjIxOiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVu
Y3Rpb24NCj4g4oCYZXZzZWxfX2lzX3JldGlyZV9sYXTigJkgWy1XZXJyb3I9aW1wbGljaXQtZnVu
Y3Rpb24tZGVjbGFyYXRpb25dDQo+ID4gIDE1NjIgfCAgICAgICAgICAgICAgICAgaWYgKGV2c2Vs
X19pc19yZXRpcmVfbGF0KGV2c2VsKSkNCj4gPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAg
Xn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gPiB1dGlsL2V2c2VsLmM6IEluIGZ1bmN0aW9uIOKAmGV2
c2VsX19vcGVuX2NwdeKAmToNCj4gPiB1dGlsL2V2c2VsLmM6MjI1ODoyNDogZXJyb3I6IGltcGxp
Y2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmHRwZWJzX3N0YXJ04oCZIFstDQo+IFdlcnJv
cj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0NCj4gPiAgMjI1OCB8ICAgICAgICAgICAg
ICAgICByZXR1cm4gdHBlYnNfc3RhcnQoZXZzZWwtPmV2bGlzdCk7DQo+ID4gICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+DQo+ID4gdXRpbC9ldnNlbC5jOiBJbiBmdW5j
dGlvbiDigJhldnNlbF9fY2xvc2XigJk6DQo+ID4gdXRpbC9ldnNlbC5jOjI0NTM6MTc6IGVycm9y
OiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJh0cGVic19kZWxldGXigJk7DQo+
IGRpZCB5b3UgbWVhbiDigJh0aW1lcl9kZWxldGXigJk/IFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0
aW9uLWRlY2xhcmF0aW9uXQ0KPiA+ICAyNDUzIHwgICAgICAgICAgICAgICAgIHRwZWJzX2RlbGV0
ZSgpOw0KPiA+ICAgICAgIHwgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fg0KPiA+ICAgICAg
IHwgICAgICAgICAgICAgICAgIHRpbWVyX2RlbGV0ZQ0KPiA+IGNjMTogYWxsIHdhcm5pbmdzIGJl
aW5nIHRyZWF0ZWQgYXMgZXJyb3JzDQo+ID4gbWFrZVs0XTogKioqIFsvaG9tZS9hY21lL2dpdC9w
ZXJmLXRvb2xzLQ0KPiBuZXh0L3Rvb2xzL2J1aWxkL01ha2VmaWxlLmJ1aWxkOjEwNTogL3RtcC9i
dWlsZC9wZXJmLXRvb2xzLW5leHQvdXRpbC9ldnNlbC5vXQ0KPiBFcnJvciAxDQo+ID4gbWFrZVs0
XTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4NCj4gPiBtYWtlWzNdOiAqKiog
Wy9ob21lL2FjbWUvZ2l0L3BlcmYtdG9vbHMtDQo+IG5leHQvdG9vbHMvYnVpbGQvTWFrZWZpbGUu
YnVpbGQ6MTU4OiB1dGlsXSBFcnJvciAyDQo+ID4gbWFrZVsyXTogKioqIFtNYWtlZmlsZS5wZXJm
Ojc4NzogL3RtcC9idWlsZC9wZXJmLXRvb2xzLW5leHQvcGVyZi11dGlsLWluLm9dDQo+IEVycm9y
IDINCj4gPiBtYWtlWzFdOiAqKiogW01ha2VmaWxlLnBlcmY6MjkwOiBzdWItbWFrZV0gRXJyb3Ig
Mg0KPiA+IG1ha2U6ICoqKiBbTWFrZWZpbGU6MTE5OiBpbnN0YWxsLWJpbl0gRXJyb3IgMg0KPiA+
IG1ha2U6IExlYXZpbmcgZGlyZWN0b3J5ICcvaG9tZS9hY21lL2dpdC9wZXJmLXRvb2xzLW5leHQv
dG9vbHMvcGVyZicNCj4gPiDirKJbYWNtZUB0b29sYm94IHBlcmYtdG9vbHMtbmV4dF0kDQo+ID4N
Cg==
