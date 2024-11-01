Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB31555896;
	Fri,  1 Nov 2024 07:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730446651; cv=fail; b=OzqJibOI8W+L180VNCyut8SVRWOBa4B63IQZ8GF55WqYHfiv2rG+lqVlvk+NnV2W3QjQrQjbymalmp57qSrTayvurek4mNCIGSa/K4cdDPw8BP7T5fIH49zhL4x6NBzHgtuKm+hR1jxywq8oeJsCIq7KjmGKqbrNRKwtkEH0Wgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730446651; c=relaxed/simple;
	bh=H+Fhgx+ghpYa2BROkfvreonvF/KtHag7KTtL5F3tvY4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oCJiED3+iE+fbJTlhO3i37xG3Toeot9GXOYH/El++jjzfUtowbuLLzSdQ8HVhxdRrpvDuO5fZNhnhCux3EoAWHCRAIQCKulSZRP8QusnkSaxDvi+lzfC7s9bqb/T5l28ATp4t7zeXpYJl0fb6+W02KVpb2JOZTGkSTtWjqRkhNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MmogdBvu; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MmogdBvu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730446649; x=1761982649;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=H+Fhgx+ghpYa2BROkfvreonvF/KtHag7KTtL5F3tvY4=;
  b=MmogdBvuXV+LrxsbrzSCp+cxf/rRclA0NiaXBcH+9VQOPtjXyCf5ig1i
   ocGx9CN1clIc33J8mjfEFIyvpnPKOygEmB7fTi+l5I855mnH24LjXsYnw
   ljE5pzGmmMoOTsDmeOukj7DxkldHqAOyIxm3XymCD8ekr6lFNrZJfEtnX
   8/DaXsZOxRA4p/x9164WZKwX68x6wayFf/JCXjK0YnoqQZY2uvd1WiJnH
   KMPRt7cWCahHtXKWDvAaWgto0Xsk6rsJhy4eUUcNXuaRDYO5k7UqypDYb
   OOu2FmRiGUK/Zq1tDU7nySV4/IISe9p+lk8XxBR2r5Sq9sfpZ9tTIUKZp
   A==;
X-CSE-ConnectionGUID: HFI3UEOTQsiDOdl2f6SYAw==
X-CSE-MsgGUID: Kf5EyVRKRJ6oV70AHBJvyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29980006"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29980006"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 00:37:28 -0700
X-CSE-ConnectionGUID: iG7hQLrrQD+PSHM0gHDaHA==
X-CSE-MsgGUID: VxnYsawzTFu3vJ0kZPwgOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="88017020"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2024 00:37:28 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Nov 2024 00:37:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 1 Nov 2024 00:37:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 00:37:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cs9b4MxZWho5Qi8zEZo9q/rMW9Aczp31hXNfkMGUmznWxLYSJmP+XrU+ZBM/mvSsoGWwFJ6GbGwAYnXCSiQrDeRvdLaNtAYVA6NGpx9gzmSs3pVIHDiWDfsTmBIH5AxDavDvjl+blcdkopBGaLtoK1lfGmr+N34+udvC/BTwYHdGl6kzb6k4cIMn/0MUysdeKqrZ10EeVJYKoi/OQIyl9DqOexedVNOLxAnSUC18lBQcNu+E8J0PoE3fJ8uWTuOjRrvOxyMsFWvcbfbdlAOovQDmkV7XZyxG9Yzk54zwxcrSUDwo5F4D3XvJK2dGoTu8Hl+JczGqiiWBvH79IZmh8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+Fhgx+ghpYa2BROkfvreonvF/KtHag7KTtL5F3tvY4=;
 b=Z12Emau0cKU6pe5qx5q4lklLlLQRhI5vsSqkMNQyHchAt8v29Kdmg6B/z+pWVppf3zewQkifdc4wF+pRxVBdyaX5Djv+epcqYPGwrRu65uKdI8l7VSYB2nyESKpsVbtQdAg7UApyCrUIl5NC2nQ4gfKQjOGywYJXdUdI5bCjD6NNih/kqxghnTr8ycw4rs0cPKsQEv05cKzU/dPGxCUI5FjruD+q2zxw3xRLmIywcrP18G/KLd/vPmM38nvItK00Gc+5d+SbT5EFmJZlgIfrKf7BnvOW/oj+OKRZdyPOhuQ7kbq1TYBsceg4//HoaC55uK0zlKjVuxd/n8IO54nmdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by BL3PR11MB6386.namprd11.prod.outlook.com (2603:10b6:208:3b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.18; Fri, 1 Nov
 2024 07:37:24 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%5]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 07:37:23 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"Dhananjay.Ugwekar@amd.com" <Dhananjay.Ugwekar@amd.com>, "acme@kernel.org"
	<acme@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "irogers@google.com" <irogers@google.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>
CC: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"ravi.bangoria@amd.com" <ravi.bangoria@amd.com>, "ananth.narayan@amd.com"
	<ananth.narayan@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "gautham.shenoy@amd.com"
	<gautham.shenoy@amd.com>, "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 09/10] perf/x86/rapl: Move the cntr_mask to rapl_pmus
 struct
Thread-Topic: [PATCH v6 09/10] perf/x86/rapl: Move the cntr_mask to rapl_pmus
 struct
Thread-Index: AQHbJs932HkzfiFFvEiG5hXbor3ShrKiFCaA
Date: Fri, 1 Nov 2024 07:37:23 +0000
Message-ID: <834cc58b9b46f6004e045e202fcd88d13ca363d0.camel@intel.com>
References: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
	 <20241025111348.3810-10-Dhananjay.Ugwekar@amd.com>
In-Reply-To: <20241025111348.3810-10-Dhananjay.Ugwekar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|BL3PR11MB6386:EE_
x-ms-office365-filtering-correlation-id: 6687eaf5-7025-4141-5bab-08dcfa4806d1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?U1QzZTlzdk9ZdXpZN25NaE5kVG9vbUdObFpyanhzOGtGTTR1K2N0dGRtbTc5?=
 =?utf-8?B?VGVjbG5XSVB0c3dGVzRRV3I2TEQ3NDZuc1RmYmNibnlCY1dtbzdPQ2lhYVdq?=
 =?utf-8?B?cGJrVVlEWnkybjFiQnQ4OUF4Q1FYZVVYeHVWVXZiOXpMQkZmcExvT3VhOFBs?=
 =?utf-8?B?MVZOQTNWajZ0SmxubW9qTkRRcTF2S1hMSTFGMG4rNVY3U0FlRjdpbVVCa21L?=
 =?utf-8?B?dWlvQ0xmYktKczNacXV2aXEwMFpaS0JjZ01zZ3FWRU9lcjdEM2dnb2xkN1Fs?=
 =?utf-8?B?TUptYWh1WnNsMVg0RW9YaXN5K0hhZ1g1ajFuQTlubnhiMk5EbmNZVnZxU09Q?=
 =?utf-8?B?Sy9nS3lXRXJ5OWZzYWNaTTlHMWxTMEMzMm83Q1V4azNCZ0tPd3k2M29WNWQ0?=
 =?utf-8?B?b3krcmxHQzFsbXhmNmFMNHljSUxsNkNtV2Y1TmJ2SFNhM29LS1VaeUpPTTh6?=
 =?utf-8?B?M1ZKc3JyLzFpN01oZTJMb1hTNERrRGpDSmtvVXBPOVF1RnRqRUJQeEZlVy9G?=
 =?utf-8?B?S3phUTdTUFkxbkFGOCtodlpQVHgxVEt1WUFwaWhGNzZLTUFmRTNpcUNwV2Jm?=
 =?utf-8?B?NWlOWnlEY2NnbGprb3NxTnBFRFdoWWJQSVhhNzlpbytZQ01sQUxTMzJ2RE9E?=
 =?utf-8?B?Vmx1WGFtTG1jU0pxZVJjVCtHRHFYTElwNHJ2NmJjbUF1cHRQR1BOV2NDaEtB?=
 =?utf-8?B?b3c4L0xzQmVkQTVCM2NxSzhlMVJ0T0tnM0ZDZDd6T3dWRUFwcWg3elZxVlJX?=
 =?utf-8?B?ZU1CN0NVMjl2RTYyMUZhUktnbCs0NWRUTitzdzRBTHp2dVF4SVYwK29zUW5i?=
 =?utf-8?B?OVk0RHM5bnZmWWYrNW0vK3ZWZ0FqUCtXbVNYYXo4YnlFWGRPZGUwd2ZjZE4r?=
 =?utf-8?B?UGdQR0Y0OWZIaTNEYU1kUUlCY3ducDNSRnNaVEVQR1V3Q2dOQ1M4cDZaUHZH?=
 =?utf-8?B?SXRaVmQwRFNsZys3U21CSzVjM2ZkSVA4SlJqZzNtK0xVc0xlRnYxSWEreDc4?=
 =?utf-8?B?VEtubXRTRlV6L3hnTnV0NFduQ0wwN2NvcU9tTFphaWt5SkhHTGxuQTZGTDEv?=
 =?utf-8?B?dHNhcytKTnYrdUxVRjExVFd2YnhRK25hRHh5Q0RNdUtxcmFqZ1NpbVQ2azRt?=
 =?utf-8?B?KzRzaHp1OW1STE82M2JneDJOdjVoNk8xQVFsWE5DWlI0bkRUQ29wR3ZsRUVG?=
 =?utf-8?B?TC9pUHlJQ0hZeGtZZEVxOFpERzlkenM2MTk1MkxhY3pleW1ZMVVrZnlQcGxo?=
 =?utf-8?B?R1pUVlpyRktPWUxBYXZzYUFzMWphUVVxdURiZTltSEE2RkorcVpUbDJERDJB?=
 =?utf-8?B?ZUduczVXV2tnYjIzRzh5WkNHdUJNMzhQM3dkcStrNGZRSTVta0ltT0xCTkE3?=
 =?utf-8?B?UGxxSGZTSmhKNjdYNVVIT3FXM1JoQ216RzQ2dkdEOS9sdFlUSmpseDhTZVJJ?=
 =?utf-8?B?cVo0NVJMVTBGcUxESC9abmcwRU5haUJNRUhJKzYrWFkrWkRqVnhjOXJNejhS?=
 =?utf-8?B?bXdpWG9CeUlLT01TaEIwZnhiRzAyc1ZLZTJCdVI1Vy9mc2x2ZnppbktjMkR1?=
 =?utf-8?B?Ym1HRitXZ2FkZnJ4Vk5QdkRaeVltWGRzOFV3NUwzQzE1eEVJT0t2VnVjdXMy?=
 =?utf-8?B?VmFUdzVYb0tUOU04ZU96NVdUem5sM01ucmd0WFFhckdRbjdXaGVNMldkMWlH?=
 =?utf-8?B?NUdMODBYWGxwN3l3aW5OSFhFZHU5WEE4N3NWTnBJVUk1VlJFWGUyek5mZlpM?=
 =?utf-8?B?OUtycEJvL0xXZ1NMQXMxUFMzcGpGYWhWTDFzSHNLSkF1b2dSamhkbGtIZlRz?=
 =?utf-8?B?VGdKUmlqc1JyMzd4OUxmQ2JQNGYwU2owTiszVzdsbndQUVlxUW9yR0x1MFFn?=
 =?utf-8?Q?bzKN6v7As2oPh?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWhBZ1VRSjNMak0rVFI0RUZrRkczem9KS05ZRXlCYm5TeHBuUTJ3UUZPRmhw?=
 =?utf-8?B?TUpjNGFNc1lXK05mcU1zaks5dVM2dlk5VUp1ZUIzT3U5Y3VGbjdady9kTDRV?=
 =?utf-8?B?R0NybEZ6Q3I0WVIrNUhoZW5JK2hGZkVlZXp5ejFoNEZNUzFPTVJjbVVQU2xl?=
 =?utf-8?B?K1dTUFVqZlk4cXhuNzMrQmxTeW41eTVnNmVjVUdDRy9ka2V0aURkY3UzR3RU?=
 =?utf-8?B?anpaY3hZUHdiUXpBU1NYYUVEWkptNnd0TU9tR0l4Rlp2SmlwVmNXV1lxSWla?=
 =?utf-8?B?Q05FSDZjcmdRbWVFMlFhZzRtRlA5aDhMbDhGRVJMVUdSWjFkblFKaDJlalV5?=
 =?utf-8?B?V0tZRVNoRmx0UlhWZkt2cmNMTDRUWWx0bHJGdXpmeFBRdlczUEJwUFpFU2E3?=
 =?utf-8?B?VkZhTmRSeFJWUGo2UEIyVjBRM2VBa2lIYmt3ZkQrUGZkcnBZWnRtT0d3cjkx?=
 =?utf-8?B?VGFkaXphUytkSjZZVUpjVjRwc1ZqR0Q3ZXhzUE9ZSEUrQVNJbXJUNzNkWFI4?=
 =?utf-8?B?WHVjVGQyVHkvbjFyNnJISEo1V2NPdDR2cjVmY3NVckJUb04zYzJIV1M0NEQ5?=
 =?utf-8?B?UGxrQVZFQ2pmUFh4TTd3elNiSlZhR2RlZnJ1Slh6UkExWURnOURxODVzcEtR?=
 =?utf-8?B?bmlIY2F1b1FaV1F6WFN1STlUSW5aUlRsYmNsdXZ4QjM2QTBvbmNWdTRqRnB3?=
 =?utf-8?B?cFVEYmVRNWIxbXVnN2xuRW4wZVpwYkxCRnJXbDJPV3k2MXQ1bUdPNXh0dERL?=
 =?utf-8?B?VTMrRHNacVNKamFXd1FoRCtvWXA4VHphYXN0MjBObUY1ZE81dzUvT1R3azMw?=
 =?utf-8?B?RG95bVlaU3M5eUNEMEtaQzlkcU5KRVh5NlZkVHNiMEpIR1pYTnovQ2tkUW1m?=
 =?utf-8?B?OENScm84TE4rWmJzeEdOaVRxZCtQSldwZXRPOUZUZXMzeVJ0UnhQaFNlQVYz?=
 =?utf-8?B?RmdWM2xja01ublY5VGpMa0REZnhCakFKR3RsWFNKRFhqWFU2a2xDRnUzZWI3?=
 =?utf-8?B?Q3hCUkJhT0xoSEJITGYxMzk5M1crUFU4d3BSNmNBVjZIZ2NlK04zbFd3OThw?=
 =?utf-8?B?a3M2WnhrR1QvdGhMRmE5eW5JcFp3U1RDYlJ6TkV5QW9Rb1lzRDRYNTUyTkRR?=
 =?utf-8?B?MXlUTlppaTRKcFNDVGFweFJMRlJVV1VHMVJHU21WaEpOQWpRTE9FNGsxajV1?=
 =?utf-8?B?clNaaFltRVo0Vk9LdnJsdFk4OVlUM29tUkxYbWl5MFpnU3BjRnBlN1VYcEFt?=
 =?utf-8?B?bngvQ0R2Kzl5ZUFmdHh4YUdvUElNK2MvRnhxMHBIaTQrS01rdlFGN3ZKOGRl?=
 =?utf-8?B?VUxCY3RlajlUMnNRVElBY3lkZnNnVVFXUmRkMW9aMmwwT01ZNS9BK3NDMG1k?=
 =?utf-8?B?V2d2WGpUWXBTeVB4enlCMGdMY3drREZ5SFVaT0I2eEhCQUJrYXdNaHRzY2xT?=
 =?utf-8?B?eUZVdDhGOVZIOFBGR3Q2Zm4wWk1OOXZLRnJ4aUZkbEk2MlZOU09rOUU5bC9h?=
 =?utf-8?B?d0hlU0p0OG9FUTFheVhqOGhudjArdWFGUTlEc29wd05QdFNQTFRDdWorQmVo?=
 =?utf-8?B?b3hRTi9CbHp6Vm5BQTRQVFZDSWpRb3cvNjhGMThBakN3dHZBTDJjMUtWbGNQ?=
 =?utf-8?B?Y1dYWUFUandCYmJPQjBRQlZ3MDR0ZlRwNGF6ZzJrdXRFK24xa1BSaEhsdTk3?=
 =?utf-8?B?L2JqNnVXOGdjR3ptQmxpU2RUcWV0V0RQVGdTSWpsN1ZuSU12YWxKQmF3ZlNI?=
 =?utf-8?B?bEgxVHozSGpCTlAzOFpoWkltMkFUNmtpOC9DU3hlQ0laV0RTUVcwQUFPekxv?=
 =?utf-8?B?c2lZUWNCSlk3UTdwQWVIT2NhSG0yZzR6eUhXdFRPWnhJcFFodERiWFpjRzhW?=
 =?utf-8?B?ai91ZmdkTU5tSERla1E4VkdFQ21RWlc1N0daR3A1bzdHaFlIU0dRM1Y4UWJC?=
 =?utf-8?B?VXlYMXkvSHJvQXBUWUQ3dzVoSXM3NUhTaFd5RUlSRW11YVV4cjg4aVhaQlBU?=
 =?utf-8?B?VlpMQTJlVlpxcXJlc3Bvbm84QU1hajZnQnRNbDAwV0oreUY2dk1tclViRzZk?=
 =?utf-8?B?RS9yUUtrQTNMdVpXTEc0TFA5YkVQWGplTVBKQnF6bktScVRocm15bEw4VXF4?=
 =?utf-8?Q?kmvxaWhEfwp8qqFdrjeFUH/7k?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <616404B5EC2B434BA9B85435AE09FC1E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6687eaf5-7025-4141-5bab-08dcfa4806d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 07:37:23.8368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 18glL8wiAPfFqITpNGhTBM4Qsa+mtMG5m/1hYggUD5URjqks/i1w/6mp0WiiTH8twJ1AAUHRtawwrAGmVBOCkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6386
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTEwLTI1IGF0IDExOjEzICswMDAwLCBEaGFuYW5qYXkgVWd3ZWthciB3cm90
ZToKPiBQcmVwYXJlIGZvciB0aGUgYWRkaXRpb24gb2YgUkFQTCBjb3JlIGVuZXJneSBjb3VudGVy
IHN1cHBvcnQuCj4gCj4gTW92ZSBjbnRyX21hc2sgdG8gcmFwbF9wbXVzIHN0cnVjdCBpbnN0ZWFk
IG9mIGFkZGluZyBhIG5ldyBnbG9iYWwKPiBjbnRyX21hc2sgZm9yIHRoZSBuZXcgUkFQTCBwb3dl
cl9jb3JlIFBNVS4gVGhpcyB3aWxsIGFsc28gZW5zdXJlIHRoYXQKPiB0aGUgc2Vjb25kICJjb3Jl
X2NudHJfbWFzayIgaXMgb25seSBjcmVhdGVkIGlmIG5lZWRlZCAoaS5lLiBpbiBjYXNlCj4gb2YK
PiBBTUQgQ1BVcykuCj4gCj4gU2lnbmVkLW9mZi1ieTogRGhhbmFuamF5IFVnd2VrYXIgPERoYW5h
bmpheS5VZ3dla2FyQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogWmhhbmcgUnVpIDxydWkuemhhbmdA
aW50ZWwuY29tPgpUZXN0ZWQtYnk6IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNvbT4KCnRo
YW5rcywKcnVpCgo+IC0tLQo+IMKgYXJjaC94ODYvZXZlbnRzL3JhcGwuYyB8IDE1ICsrKysrKysr
LS0tLS0tLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMo
LSkKPiAKPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvZXZlbnRzL3JhcGwuYyBiL2FyY2gveDg2L2V2
ZW50cy9yYXBsLmMKPiBpbmRleCBlODBiNjJjZjlhYmMuLmQzYWNjNzBhM2QzMSAxMDA2NDQKPiAt
LS0gYS9hcmNoL3g4Ni9ldmVudHMvcmFwbC5jCj4gKysrIGIvYXJjaC94ODYvZXZlbnRzL3JhcGwu
Ywo+IEBAIC0xMjksNiArMTI5LDcgQEAgc3RydWN0IHJhcGxfcG11IHsKPiDCoHN0cnVjdCByYXBs
X3BtdXMgewo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcG11wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHBtdTsKPiDCoMKgwqDCoMKgwqDCoMKgdW5zaWduZWQgaW50wqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgbnJfcmFwbF9wbXU7Cj4gK8KgwqDCoMKgwqDCoMKgdW5zaWduZWQgaW50wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgY250cl9tYXNrOwo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcmFw
bF9wbXXCoMKgwqDCoMKgwqDCoMKgwqAqcmFwbF9wbXVbXQo+IF9fY291bnRlZF9ieShucl9yYXBs
X3BtdSk7Cj4gwqB9Owo+IMKgCj4gQEAgLTE0OCw3ICsxNDksNiBAQCBzdHJ1Y3QgcmFwbF9tb2Rl
bCB7Cj4gwqAgLyogMS8yXmh3X3VuaXQgSm91bGUgKi8KPiDCoHN0YXRpYyBpbnQgcmFwbF9wa2df
aHdfdW5pdFtOUl9SQVBMX1BLR19ET01BSU5TXSBfX3JlYWRfbW9zdGx5Owo+IMKgc3RhdGljIHN0
cnVjdCByYXBsX3BtdXMgKnJhcGxfcG11c19wa2c7Cj4gLXN0YXRpYyB1bnNpZ25lZCBpbnQgcmFw
bF9wa2dfY250cl9tYXNrOwo+IMKgc3RhdGljIHU2NCByYXBsX3RpbWVyX21zOwo+IMKgc3RhdGlj
IHN0cnVjdCByYXBsX21vZGVsICpyYXBsX21vZGVsOwo+IMKgCj4gQEAgLTM1OCw3ICszNTgsNyBA
QCBzdGF0aWMgaW50IHJhcGxfcG11X2V2ZW50X2luaXQoc3RydWN0IHBlcmZfZXZlbnQKPiAqZXZl
bnQpCj4gwqDCoMKgwqDCoMKgwqDCoGJpdCA9IGNmZyAtIDE7Cj4gwqAKPiDCoMKgwqDCoMKgwqDC
oMKgLyogY2hlY2sgZXZlbnQgc3VwcG9ydGVkICovCj4gLcKgwqDCoMKgwqDCoMKgaWYgKCEocmFw
bF9wa2dfY250cl9tYXNrICYgKDEgPDwgYml0KSkpCj4gK8KgwqDCoMKgwqDCoMKgaWYgKCEocmFw
bF9wbXVzX3BrZy0+Y250cl9tYXNrICYgKDEgPDwgYml0KSkpCj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJTlZBTDsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqAvKiB1
bnN1cHBvcnRlZCBtb2RlcyBhbmQgZmlsdGVycyAqLwo+IEBAIC01ODYsMTAgKzU4NiwxMCBAQCBz
dGF0aWMgdm9pZCBfX2luaXQgcmFwbF9hZHZlcnRpc2Uodm9pZCkKPiDCoMKgwqDCoMKgwqDCoMKg
aW50IGk7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgcHJfaW5mbygiQVBJIHVuaXQgaXMgMl4tMzIg
Sm91bGVzLCAlZCBmaXhlZCBjb3VudGVycywgJWxsdSBtcwo+IG92ZmwgdGltZXJcbiIsCj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGh3ZWlnaHQzMihyYXBsX3BrZ19jbnRyX21hc2sp
LCByYXBsX3RpbWVyX21zKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaHdlaWdo
dDMyKHJhcGxfcG11c19wa2ctPmNudHJfbWFzayksIHJhcGxfdGltZXJfbXMpOwo+IMKgCj4gwqDC
oMKgwqDCoMKgwqDCoGZvciAoaSA9IDA7IGkgPCBOUl9SQVBMX1BLR19ET01BSU5TOyBpKyspIHsK
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHJhcGxfcGtnX2NudHJfbWFzayAm
ICgxIDw8IGkpKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChyYXBsX3Bt
dXNfcGtnLT5jbnRyX21hc2sgJiAoMSA8PCBpKSkgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHByX2luZm8oImh3IHVuaXQgb2YgZG9tYWluICVzIDJe
LSVkCj4gSm91bGVzXG4iLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByYXBsX3BrZ19kb21haW5fbmFtZXNbaV0sCj4gcmFw
bF9wa2dfaHdfdW5pdFtpXSk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4g
QEAgLTgwNCw5ICs4MDQsNiBAQCBzdGF0aWMgaW50IF9faW5pdCByYXBsX3BtdV9pbml0KHZvaWQp
Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgcmFwbF9tb2RlbCA9IChzdHJ1Y3QgcmFwbF9tb2RlbCAq
KSBpZC0+ZHJpdmVyX2RhdGE7Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqByYXBsX3BrZ19jbnRyX21h
c2sgPSBwZXJmX21zcl9wcm9iZShyYXBsX21vZGVsLQo+ID5yYXBsX3BrZ19tc3JzLCBQRVJGX1JB
UExfUEtHX0VWRU5UU19NQVgsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZhbHNlLCAodm9pZCAq
KSAmcmFwbF9tb2RlbC0KPiA+cGtnX2V2ZW50cyk7Cj4gLQo+IMKgwqDCoMKgwqDCoMKgwqByZXQg
PSByYXBsX2NoZWNrX2h3X3VuaXQoKTsKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCkKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiByZXQ7Cj4gQEAgLTgxNSw2ICs4MTIs
MTAgQEAgc3RhdGljIGludCBfX2luaXQgcmFwbF9wbXVfaW5pdCh2b2lkKQo+IMKgwqDCoMKgwqDC
oMKgwqBpZiAocmV0KQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJl
dDsKPiDCoAo+ICvCoMKgwqDCoMKgwqDCoHJhcGxfcG11c19wa2ctPmNudHJfbWFzayA9IHBlcmZf
bXNyX3Byb2JlKHJhcGxfbW9kZWwtCj4gPnJhcGxfcGtnX21zcnMsCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+IFBFUkZfUkFQTF9QS0dfRVZFTlRTX01BWCwgZmFs
c2UsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAodm9pZCAqKQo+
ICZyYXBsX21vZGVsLT5wa2dfZXZlbnRzKTsKPiArCj4gwqDCoMKgwqDCoMKgwqDCoHJldCA9IHBl
cmZfcG11X3JlZ2lzdGVyKCZyYXBsX3BtdXNfcGtnLT5wbXUsICJwb3dlciIsIC0xKTsKPiDCoMKg
wqDCoMKgwqDCoMKgaWYgKHJldCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdv
dG8gb3V0OwoK
