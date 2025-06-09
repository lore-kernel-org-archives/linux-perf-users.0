Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3BE21CA03;
	Mon,  9 Jun 2025 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486119; cv=fail; b=NaC2eiZzFlMVmpU5/c5xGcpZOafzJeAXPUoRxYmlS3W+Qo6SWV6RZCRiFcLvwRg3WL90sIeBeDpn5iQQmMDVEa6hkUCmKdBhz4hI2exBR+wYMrzRkeNzuI39QAqV1qiJbchywVvUAvi8cZtLiNJnnxwe9wACvSlKbklPAGi8+Gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486119; c=relaxed/simple;
	bh=0rtaxkf17hiNniSal5lXnzELf8y09RPgufzOXv1l3WY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kDDP2o0UzzGfBtvSeSNedvdYLo0Zx35XEscTRA+kF2sFINz9UDhDcUxYqCM0NyIKXSyBEwdQCbJLvm5x6WqlWr3BPCVQL9ssHD4jQmgQvk6Hcef7vYkixiOYsc7dbZ/j/ePMBsE4ShUiaQaxHGLpsbQlx+vMes7fGThlsEZH4/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MqiYL2Xt; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MqiYL2Xt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749486118; x=1781022118;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0rtaxkf17hiNniSal5lXnzELf8y09RPgufzOXv1l3WY=;
  b=MqiYL2XtmkIJm8xPlwJucncxfDZoewQSdfdCaTXjXoYGlEzIe1GA9teq
   aWSh6Q9VOn5ea/EvVExTWI1cmjnU6XteZrAk4JFOhOU3rpkbDkmw6l3D2
   1WECyBVt/Ab4Uk+AtxVkkK8qJgt09xS/o00ZW8fTVL18jNr8zx8hE5x8e
   mzWKqYyA+LLL7q/EzwHrKmcVDeCrxSUpgCgcPvFGmsefgjU/p4iH/CWNe
   aK9mpWJbFEUlQHDdKSeWMG5WfYIke/1cOU7k31HXfLO6tKftmZtExHCZy
   icAJzoMq0nQ8jHu13y1vhiZM69BzLTziCBGRUrYLhOxYcqD/9/ursva8B
   Q==;
X-CSE-ConnectionGUID: K3OAJlvoTUqzXVDqB11GPQ==
X-CSE-MsgGUID: /iYO32oHSvi9+sZEapTMCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="55234459"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="55234459"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 09:21:57 -0700
X-CSE-ConnectionGUID: gB+xh4qTT9uSy1Zf/aL2Yg==
X-CSE-MsgGUID: L4mdZ86WTUOp9E7OoIXpxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; 
   d="scan'208";a="151435330"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 09:21:56 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 09:21:55 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 9 Jun 2025 09:21:55 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.88)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 9 Jun 2025 09:21:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4oor/0xNY5ypccw0R+okkb4n/FFjr01NSQQYB33dQzzaqweuG9pD82UGX28IgyXJH/RQfhy+dd13PsNeUP2X/05dkZLmDwLa4pFqa405oahvYaPetEochDqiEklu827SeZAI2dTWO4/0SgZ9A1VSIA1kiyoxp6Th5Vs9LP5hGpb+hI22b9BIPVkaSKTJ9Nq3+sylm6xaRGNc0yH0N2fXISNP40LgakizkfOj1KDaYHy1ugh1ABFAuYEngerKkWwluc1IwuNpvwwb4WDhp2zK9cECiCZ9kcj9cN/EVPlEyCLHhqCnQM2LurmMovr9qlYmFYhTKKNpGzP0TzPwxLnGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rtaxkf17hiNniSal5lXnzELf8y09RPgufzOXv1l3WY=;
 b=XrgtYJUwra8XcEE3Be5+eu6bIzIW/w5Wk3sc4fUe7gzk+lD6rwziTGQ4mwyNG5MglK6AL1Y1y6bjAvKn9rC6tbhnzNd8/de4bGDdRxGRsjavkKZndnsQMIoEDVyDBTogupoX86pnGde/f/lImyE9GHS/OuzvX9bvDxGDa+xrQd+yS8oVUbobmoqfc37/ok0P2Qk0gX20cwpwEFJI4IGGO9U1A2k5NnSXGfzKHBSVT9UIq4C7loeGTtJnptX4+ULqhxTTFPWMTq73UuP54Bv0ZPWcZ9GZU0qU5nFoK7jj7CZqOjhc26e/emkRJCjq6aqVfB5swld/S575AE0Z3sQm/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by CY8PR11MB6964.namprd11.prod.outlook.com (2603:10b6:930:57::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Mon, 9 Jun
 2025 16:21:39 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%3]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 16:21:39 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org"
	<acme@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"irogers@google.com" <irogers@google.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 2/2 v3] perf top: populate PMU capabilities data in
 perf_env
Thread-Topic: [PATCH 2/2 v3] perf top: populate PMU capabilities data in
 perf_env
Thread-Index: AQHbxF1Wi390zgPnOkKJ8kPrSTjDorP7LGwA
Date: Mon, 9 Jun 2025 16:21:39 +0000
Message-ID: <a327dc2e5837a743a08403b5ad58dbe5e8c4f926.camel@intel.com>
References: <20250513231813.13846-1-thomas.falcon@intel.com>
	 <20250513231813.13846-2-thomas.falcon@intel.com>
In-Reply-To: <20250513231813.13846-2-thomas.falcon@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|CY8PR11MB6964:EE_
x-ms-office365-filtering-correlation-id: 1907c08b-d4f7-4501-26b6-08dda771b6a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?a2d5a09zUnZzNmdUN1kyeXdUWnZFYU0xOHYvZXArVmREL2hHeE5qbDZzbEl0?=
 =?utf-8?B?M0p4REZpNDJucG1kcm1yM29IS01jSFBSVXdVZ1dDVUFJS2Q3bmw2amF2bTBo?=
 =?utf-8?B?ZVJLR1RHRjhsSE8weWhSYWtXQU1MT0FJcjhrUGZxRndKQkw1TGJ0NTZJSEJt?=
 =?utf-8?B?M2FaNTNNOHYxS0NzaXRyN0FUcTVUUy92Nkozdm9XUjFmM0hnZGZhZ2I0WWxH?=
 =?utf-8?B?VXpXdE94ZGdmUmY5V01ZaDZUZllYbjZGZzYrM0svREwyaVo0djEwZmt3YVdT?=
 =?utf-8?B?YTNXYnJpNDBHanV1aWRUTGxsSmRVU21kaGg4UVdtU3pDbFNSSEdtK2kxVkJu?=
 =?utf-8?B?ZnM3SkRoZTZGMllFQkZ0dGowZTB1UkQzUytPZ3Q1VmZWcjNMdGU1YmJudjhs?=
 =?utf-8?B?bWhpd29ZSlcrUS90SmRHVzNOTWZ3UklmL0h2MFo5VmdiZ2NtQ3R5OUEwbHBi?=
 =?utf-8?B?bGtGVkx1VjVMM2ZqSjA3YXpGMHkxZHpvcE9VSXZaVWlrZ2hlRmtIdTNEVWE4?=
 =?utf-8?B?b0RGYnNpd2RTZDVZdXllZU1CZmpIOS9uUVBxRlBUS3Zwa2JrS3ZlWnNyRFNj?=
 =?utf-8?B?NlorZll4eEhtRC92VlU0RldvYVJCYU1CWG5tS2ZlWEdZM01ORC9kS3luTnZL?=
 =?utf-8?B?dFZGWUN0UUVZRHlTUC9jRm52T0d1N3R4QzlxanJFcDJpdTNhVTdVTGllSUtv?=
 =?utf-8?B?dTlXdnpadVZESm1ISmxlaDRNeitBTTd6N3NvUXEzVnFvcXVpRG9SUjdWRkVm?=
 =?utf-8?B?Nk9tbU02cTVZdDdYOHhiK0NEMkhHbU5xalEzZEFPeVNjWjFHYzFYNVFKZ0pk?=
 =?utf-8?B?V01iYXhJSWVJVlNVYnU0N0lOUk9zT3lPSXpueHVVZEs2U1kyaXNVUDR4UFE0?=
 =?utf-8?B?YytJUVBvRzFVenJOR3BZYlVTK2pCaEkwSXlsMFJZTHFsM0EreHBIY1R5bWdq?=
 =?utf-8?B?VnBpemFSLzhwUHVNdTBHdDFQOGsvVHlCNUVFZ2p0UEdYV1p2U2ZZZktQN2gw?=
 =?utf-8?B?WDhpQjhYTVNieC9jKzBxcDIzbmxITkh1L3F0dUs0Wm9qTGNFbXVSWURmQ3lX?=
 =?utf-8?B?WGxBb2N5aVRVQVdSK0lBMnFSSE1GQ0NnbHNJejNONS95RFg0aTIremJQZktJ?=
 =?utf-8?B?K3VkTmprQjM4OWlKNklTVldRK0o3eERkdytRdGRlU2ZHWk1vaG5TZ1NwU1Ja?=
 =?utf-8?B?S1RMTU5sMTdjK3g5c0pXN3NyR1ZaRlVPWnZZY1ZwRnAvemc4a2Z6NHlZMU5x?=
 =?utf-8?B?NUtCeHFyNldiLzVCUVh3QXBaMmZzUWtSN1hEMGs2cVk1ZmZuZ1FXcFg3c2lE?=
 =?utf-8?B?SC9lc0ZSMk5ZdHFaejZUSTJEOVVFZjNUcGc0UkFiaGlTZGVKb0c1V0k0ZjJ3?=
 =?utf-8?B?b1pCZDUyeFJOSFZxSkx6WHM3czJIcnRmRERUb1JyaW9GY0VDNVhYTmFxV3k1?=
 =?utf-8?B?UVU0QUUrdXNDVnl1TE5lYUNOYkE0Q2hyakgySzFqd0ZpQStjeXpxVERPVEJ1?=
 =?utf-8?B?TU9keWJva2VIRERvUG1sM09xNnN6Z0lpOU41R3V0OHh0dVNMOUxrNGFHS05E?=
 =?utf-8?B?c2NhR2piSnNiQkdkcjFqSC9WcjlNZHJndHkzWjVsVU0rbVFPOHhRWjh4YnR6?=
 =?utf-8?B?UEpmWm5uZ0RRNEdLcHFEekMrbVBCWDdlcTloZ2FqcysvOTF0enZNQkxpeXhK?=
 =?utf-8?B?RWRLNUwrNFM0eXZjTzM5anhpL0VacmtPYW1hNitIQzZ4aHk0QVJYdUY4VUVP?=
 =?utf-8?B?TUVkRWRZZmlKd0NEdjdzU0F3OG00MlBsTm5JZnordENlaWQzbXVaK0dUQWZL?=
 =?utf-8?B?WEF1dWRJWFFxR2w0YXRsWDZuOXcweDBCVXdYSDFnbFRreXZOV3hHcDVDRHph?=
 =?utf-8?B?cEhBa0FPcWszR0ZxVUR1eGxpN0FJYldVNjEwa2NWS2FCcE12dmQ3LzBiQ3d3?=
 =?utf-8?B?cmVvRTNjekxMSWErMW82NFdnSjFXUGlNMzVFdmdmWUlFSllDMTRhSElkcStj?=
 =?utf-8?B?RDR5VUd3RVcxbHA5MDYxV2ttdmFZT29uWVR0N2cyQnM2Y0YwY2NjS0xnZ0JY?=
 =?utf-8?Q?VDa6oB?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlZEdjN3WXpTWTVWMlA4WmdTZ2hNNVdZeEdFUGlJN1BrMjdYNUV6ZnZjYXl5?=
 =?utf-8?B?czBRUWVjS3U5eEE4N1l0UFhNM0RiMXRxQnIxbUt0Zis0YlFidzFFME9mZmw1?=
 =?utf-8?B?cnZSZXVlL3d5TzNnNWNta3ZjeEhnK01RaWExb2FrWEVPcXR3bkljOFJWTHJ2?=
 =?utf-8?B?dXBvaVQ1cUhuWDF0ZUlPaEl6M0F6M09VNm9wWXZRK1crK2lVNWhVVCtrS2V5?=
 =?utf-8?B?MGpzeTNUWnU0anh2WU9aQllLQUNlMUVhN0hWRSswMUVTazVJL0psTm9sczIx?=
 =?utf-8?B?dEtPZ0pYODlmUWlBZ0NRVUVmRkpOWVdzN3JLb3lmRlZod0hUbXg2MyszekRW?=
 =?utf-8?B?TVpHVW45VXE5cnVVU3Y5RTB1cFNRUDkrM05EUGpaZFdyWndBbHMvbUNHaU9F?=
 =?utf-8?B?dFVINDd4ZHBvUzRpdzROS2dPRmVDWStCbnFYWm15aFdJSHlmNzZ4R2lrWjY5?=
 =?utf-8?B?NFJ4SWVnN3RFTUt6bFM3S0FrQm9NMndXWDE2dTRpNHowVlIvTzAycUc4eXB6?=
 =?utf-8?B?U3AwSXJFeUZVRzJMcVZOVnJiTmFSdjZ0bGJXby9jWE15QmJtQSt5ZmRwOTVH?=
 =?utf-8?B?VkhLbUZnZTJya2xIUURSTTNDdnZmem1oczg1bEgxOUV0R1NWZXBBMmFCWkJw?=
 =?utf-8?B?d09rR3NvdFMyWTV0MEdKbW84NS9WeTZackxiRVdTM1hQY0lqaXhKNEhHdDBF?=
 =?utf-8?B?NDZDSTIxQUdOZW9lMFFZbEk5OXBzSTVTNmZiYTMwT3d1MHovcm8yQU1RR2VS?=
 =?utf-8?B?RjVuL2NvemUweWNXSzhmaTUwM3h0R3JNVkI0U3MyR1RaVmtQcVNLd09BV0ll?=
 =?utf-8?B?RmNra0w3Q3U2NUY2RGUzYWhJTVFpak1nOGduNjBUd0NFaFFrN0R1SDIvNFRt?=
 =?utf-8?B?ZWUzNnNhQ0NsbjdCdndEQmdlUTdsZnVRZ3Y5N2JzRFFtZE9mRjF1cUtKdXh0?=
 =?utf-8?B?WkJ3SUlaWEtoV2xMZnBMOUp5dVJvVGR2cG9uTWV3bW00TUs4T3lrRjd4OWsx?=
 =?utf-8?B?WjRIbWZoODdDcTVZa2VGNTFTcGlkSFFIYmNnbXNVVDcyMWhpcTBYWlpRdDJx?=
 =?utf-8?B?bVZvc1R3RmNwc29FSUdCSHMwUWFKRjdvV1d5NmdqZlZza2FrY3E1THgrbGhk?=
 =?utf-8?B?V3ZHMzYvV2xLQloyVVVkTkFpaXZ2dDVnamJ6cDByNUF6R2N2bm5KR1lwZ2hY?=
 =?utf-8?B?bnYxMmJIQkFIblRVb1N1c0g3KzUwellWYitROW5XL0tDdXl4Umx2dE5naTk3?=
 =?utf-8?B?T2xsTkJFRGtZSmJsY0RiSE9TTVpGKzk1K0JIVUNNQjl1dmRTcVNHK1pRcms3?=
 =?utf-8?B?RWJUUDlMR1o3bmQzNzM2VGluZ0JldDIxL0pqZVhiS1ZXQ1VXdWp1ME1McnFa?=
 =?utf-8?B?VHJtTGZnVWR0OHRMZVltSnUwYVVRRDI2K3hyajBQMVdEUUFzeFk0emIrcHJ5?=
 =?utf-8?B?dkRhQk1wNzhGVkRaNWwyYzBSTWZ1ZlRqaDc5cjJNbStFdEFWMVNxdFZWajYz?=
 =?utf-8?B?Q1VOQi9pRnViQnFYOEdvYTQ0b1V5WkFqQkF6SDNsUURVUThwbXM2VTN1K3Zo?=
 =?utf-8?B?TlNKaU1pbEc0NklJRHo4SlFWZGUrK1NLVG5KSklnQ2RlTUFqbWFqNW5mczdQ?=
 =?utf-8?B?VDR5S0hXaG1ZWGJWYkF0bURGYWIwODQzSnlteVpjRWM2OGw3S3FEaTFTSzdk?=
 =?utf-8?B?Ky9yOWhEUjhxTE4wdzYvOXVWVEdJeVh4dDdKV0J2NmVEV3YvNUF5MFdMTUcw?=
 =?utf-8?B?K1VzTVNiQ0lYQmhWUVYzLzBZdW8yZWY5djdZOEViM1RNdHZORjBqQm1odTAr?=
 =?utf-8?B?V3FuMWhHaEtUSVlmU1M4alNyY2JJOTEzQ1BYWTh0VjR3S0ZtOXZPQjZ2MnVt?=
 =?utf-8?B?NngvbUhtWEl3RkxrSkkrZzJ4cXF5c09YV1BjUG8wVEZYSy9wSjNMWndNMmZn?=
 =?utf-8?B?QmNaUXJGMC9CbEhqc0t1UXcwOVdvSkhsKzdTaXJ4bUx2UEw5TDE0TWpkcDVj?=
 =?utf-8?B?R3A1dUpDRmtnUmw4YVlqcEFyaGw5ZUJDZ01jREpqUG5xZ0dsVmNWbmZnMUJF?=
 =?utf-8?B?U2hNdytUQ0pmdGZFeEcwTHJJZUNrY2tzVGhYejV0THBJK3VYL0J3TlF6WFha?=
 =?utf-8?B?Q2MvNGNJREdGSklleHJJenVCMC9ncXhBYk1LN0paNnhibytBTXRNdlJWMEN3?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7296190AA697C14387B930C1EF62F125@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1907c08b-d4f7-4501-26b6-08dda771b6a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 16:21:39.3613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TpAmg4SvkO64THFB0iqPOppewSzR0Oce82SDVhjVNHoMkh1DOoSK1QxCPVVbbIjoC2TaY7BXisUkqIB3LPfgjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6964
X-OriginatorOrg: intel.com

UGluZz8NCg0KVGhhbmtzLA0KVG9tDQoNCk9uIFR1ZSwgMjAyNS0wNS0xMyBhdCAxODoxOCAtMDUw
MCwgVGhvbWFzIEZhbGNvbiB3cm90ZToNCj4gQ2FsbGluZyBwZXJmIHRvcCB3aXRoIGJyYW5jaCBm
aWx0ZXJzIGVuYWJsZWQgb24gSW50ZWwgQ1BVJ3MNCj4gd2l0aCBicmFuY2ggY291bnRlcnMgbG9n
Z2luZyAoQS5LLkEgTEJSIGV2ZW50IGxvZ2dpbmcgWzFdKSBzdXBwb3J0DQo+IHJlc3VsdHMgaW4g
YSBzZWdmYXVsdC4NCj4gDQo+IFRocmVhZCAyNyAicGVyZiIgcmVjZWl2ZWQgc2lnbmFsIFNJR1NF
R1YsIFNlZ21lbnRhdGlvbiBmYXVsdC4NCj4gW1N3aXRjaGluZyB0byBUaHJlYWQgMHg3ZmZmYWZm
Zjc2YzAgKExXUCA5NDkwMDMpXQ0KPiBwZXJmX2Vudl9fZmluZF9icl9jbnRyX2luZm8gKGVudj0w
eGY2NmRjMCA8cGVyZl9lbnY+LCBucj0weDAsIHdpZHRoPTB4N2ZmZmFmZmY2MmMwKSBhdCB1dGls
L2Vudi5jOjY1Mw0KPiA2NTMJCQkqd2lkdGggPSBlbnYtPmNwdV9wbXVfY2FwcyA/IGVudi0+YnJf
Y250cl93aWR0aCA6DQo+IChnZGIpIGJ0DQo+ICAjMCAgcGVyZl9lbnZfX2ZpbmRfYnJfY250cl9p
bmZvIChlbnY9MHhmNjZkYzAgPHBlcmZfZW52PiwgbnI9MHgwLCB3aWR0aD0weDdmZmZhZmZmNjJj
MCkgYXQgdXRpbC9lbnYuYzo2NTMNCj4gICMxICAweDAwMDAwMDAwMDA1YjE1OTkgaW4gc3ltYm9s
X19hY2NvdW50X2JyX2NudHIgKGJyYW5jaD0weDdmZmZjYzNkYjU4MCwgZXZzZWw9MHhmZWEyZDAs
IG9mZnNldD0xMiwgYnJfY250cj04KSBhdCB1dGlsL2Fubm90YXRlLmM6MzQ1DQo+ICAjMiAgMHgw
MDAwMDAwMDAwNWIxN2ZiIGluIHN5bWJvbF9fYWNjb3VudF9jeWNsZXMgKGFkZHI9NTY1ODE3Miwg
c3RhcnQ9NTY1ODE2MCwgc3ltPTB4N2ZmZmNjMGVlNDIwLCBjeWNsZXM9NTM5LCBldnNlbD0weGZl
YTJkMCwgYnJfY250cj04KSBhdCB1dGlsL2Fubm90YXRlLmM6Mzg5DQo+ICAjMyAgMHgwMDAwMDAw
MDAwNWIxOTc2IGluIGFkZHJfbWFwX3N5bWJvbF9fYWNjb3VudF9jeWNsZXMgKGFtcz0weDdmZmZj
ZDdiMDFkMCwgc3RhcnQ9MHg3ZmZmY2Q3YjAyYjAsIGN5Y2xlcz01MzksIGV2c2VsPTB4ZmVhMmQw
LCBicl9jbnRyPTgpIGF0IHV0aWwvYW5ub3RhdGUuYzo0MjINCj4gICM0ICAweDAwMDAwMDAwMDA2
OGQ1N2YgaW4gaGlzdF9fYWNjb3VudF9jeWNsZXMgKGJzPTB4MTEwZDI4OCwgYWw9MHg3ZmZmYWZm
ZjY1NDAsIHNhbXBsZT0weDdmZmZhZmZmNjc2MCwgbm9uYW55X2JyYW5jaF9tb2RlPWZhbHNlLCB0
b3RhbF9jeWNsZXM9MHgwLCBldnNlbD0weGZlYTJkMCkgYXQgdXRpbC9oaXN0LmM6Mjg1MA0KPiAg
IzUgIDB4MDAwMDAwMDAwMDQ0NjIxNiBpbiBoaXN0X2l0ZXJfX3RvcF9jYWxsYmFjayAoaXRlcj0w
eDdmZmZhZmZmNjU5MCwgYWw9MHg3ZmZmYWZmZjY1NDAsIHNpbmdsZT10cnVlLCBhcmc9MHg3ZmZm
ZmZmZjllMDApIGF0IGJ1aWx0aW4tdG9wLmM6NzM3DQo+ICAjNiAgMHgwMDAwMDAwMDAwNjg5Nzg3
IGluIGhpc3RfZW50cnlfaXRlcl9fYWRkIChpdGVyPTB4N2ZmZmFmZmY2NTkwLCBhbD0weDdmZmZh
ZmZmNjU0MCwgbWF4X3N0YWNrX2RlcHRoPTEyNywgYXJnPTB4N2ZmZmZmZmY5ZTAwKSBhdCB1dGls
L2hpc3QuYzoxMzU5DQo+ICAjNyAgMHgwMDAwMDAwMDAwNDQ2NzEwIGluIHBlcmZfZXZlbnRfX3By
b2Nlc3Nfc2FtcGxlICh0b29sPTB4N2ZmZmZmZmY5ZTAwLCBldmVudD0weDExMGQyNTAsIGV2c2Vs
PTB4ZmVhMmQwLCBzYW1wbGU9MHg3ZmZmYWZmZjY3NjAsIG1hY2hpbmU9MHgxMDhjOTY4KSBhdCBi
dWlsdGluLXRvcC5jOjg0NQ0KPiAgIzggIDB4MDAwMDAwMDAwMDQ0NzczNSBpbiBkZWxpdmVyX2V2
ZW50IChxZT0weDdmZmZmZmZmYTEyMCwgcWV2ZW50PTB4MTBmYzIwMCkgYXQgYnVpbHRpbi10b3Au
YzoxMjExDQo+ICAjOSAgMHgwMDAwMDAwMDAwNjRjY2FlIGluIGRvX2ZsdXNoIChvZT0weDdmZmZm
ZmZmYTEyMCwgc2hvd19wcm9ncmVzcz1mYWxzZSkgYXQgdXRpbC9vcmRlcmVkLWV2ZW50cy5jOjI0
NQ0KPiAgIzEwIDB4MDAwMDAwMDAwMDY0ZDAwNSBpbiBfX29yZGVyZWRfZXZlbnRzX19mbHVzaCAo
b2U9MHg3ZmZmZmZmZmExMjAsIGhvdz1PRV9GTFVTSF9fVE9QLCB0aW1lc3RhbXA9MCkgYXQgdXRp
bC9vcmRlcmVkLWV2ZW50cy5jOjMyNA0KPiAgIzExIDB4MDAwMDAwMDAwMDY0ZDBlZiBpbiBvcmRl
cmVkX2V2ZW50c19fZmx1c2ggKG9lPTB4N2ZmZmZmZmZhMTIwLCBob3c9T0VfRkxVU0hfX1RPUCkg
YXQgdXRpbC9vcmRlcmVkLWV2ZW50cy5jOjM0Mg0KPiAgIzEyIDB4MDAwMDAwMDAwMDQ0NzJhOSBp
biBwcm9jZXNzX3RocmVhZCAoYXJnPTB4N2ZmZmZmZmY5ZTAwKSBhdCBidWlsdGluLXRvcC5jOjEx
MjANCj4gICMxMyAweDAwMDA3ZmZmZjZlN2RiYTggaW4gc3RhcnRfdGhyZWFkIChhcmc9PG9wdGlt
aXplZCBvdXQ+KSBhdCBwdGhyZWFkX2NyZWF0ZS5jOjQ0OA0KPiAgIzE0IDB4MDAwMDdmZmZmNmYw
MWI4YyBpbiBfX0dJX19fY2xvbmUzICgpIGF0IC4uL3N5c2RlcHMvdW5peC9zeXN2L2xpbnV4L3g4
Nl82NC9jbG9uZTMuUzo3OA0KPiANCj4gVGhlIGNhdXNlIGlzIHRoYXQgcGVyZl9lbnZfX2ZpbmRf
YnJfY250cl9pbmZvIHRyaWVzIHRvIGFjY2VzcyBhDQo+IG51bGwgcG9pbnRlciBwbXVfY2FwcyBp
biB0aGUgcGVyZl9lbnYgc3RydWN0LiBBIHNpbWlsYXIgaXNzdWUgZXhpc3RzDQo+IGZvciBob21v
Z2VuZW91cyBjb3JlIHN5c3RlbXMgd2hpY2ggdXNlIHRoZSBjcHVfcG11X2NhcHMgc3RydWN0dXJl
Lg0KPiANCj4gRml4IHRoaXMgYnkgcG9wdWxhdGluZyBjcHVfcG11X2NhcHMgYW5kIHBtdV9jYXBz
IHN0cnVjdHVyZXMgd2l0aA0KPiB2YWx1ZXMgZnJvbSBzeXNmcyB3aGVuIGNhbGxpbmcgcGVyZiB0
b3Agd2l0aCBicmFuY2ggc3RhY2sgc2FtcGxpbmcNCj4gZW5hYmxlZC4NCj4gDQo+IFsxXSwgTEJS
IGV2ZW50IGxvZ2dpbmcgaW50cm9kdWNlZCBoZXJlOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvMjAyMzEwMjUyMDE2MjYuMzAwMDIyOC01LWthbi5saWFuZ0BsaW51eC5pbnRlbC5jb20v
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgRmFsY29uIDx0aG9tYXMuZmFsY29uQGludGVs
LmNvbT4NCj4gLS0tDQo+IHYzOiBjb25zdGlmeSBzdHJ1Y3QgcGVyZl9wbXUgKnBtdSBpbiBfX3Bl
cmZfZW52X19yZWFkX2NvcmVfcG11X2NhcHMoKQ0KPiAgICAgdXNlIHBlcmZfcG11c19fZmluZF9j
b3JlX3BtdSgpIGluc3RlYWQgb2YgcGVyZl9wbXVzX19zY2FuX2NvcmUoTlVMTCkNCj4gDQo+IHYy
OiB1cGRhdGUgY29tbWl0IG1lc3NhZ2Ugd2l0aCBtb3JlIG1lYW5pbmdmdWwgc3RhY2sgdHJhY2Ug
ZnJvbQ0KPiAgICAgZ2RiIGFuZCBpbmRpY2F0ZSB0aGF0IGFmZmVjdGVkIHN5c3RlbXMgYXJlIGxp
bWl0ZWQgdG8gQ1BVJ3MNCj4gICAgIHdpdGggTEJSIGV2ZW50IGxvZ2dpbmcgc3VwcG9ydCBhbmQg
dGhhdCBib3RoIGh5YnJpZCBhbmQNCj4gICAgIG5vbi1oeWJyaWQgY29yZSBzeXN0ZW1zIGFyZSBh
ZmZlY3RlZC4NCj4gLS0tDQo+ICB0b29scy9wZXJmL2J1aWx0aW4tdG9wLmMgfCAgIDggKysrDQo+
ICB0b29scy9wZXJmL3V0aWwvZW52LmMgICAgfCAxMTQgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ICB0b29scy9wZXJmL3V0aWwvZW52LmggICAgfCAgIDEgKw0KPiAg
MyBmaWxlcyBjaGFuZ2VkLCAxMjMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rv
b2xzL3BlcmYvYnVpbHRpbi10b3AuYyBiL3Rvb2xzL3BlcmYvYnVpbHRpbi10b3AuYw0KPiBpbmRl
eCBmOWYzMTM5MWJkZGIuLmM5ZDY3OTQxMDU5MSAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvcGVyZi9i
dWlsdGluLXRvcC5jDQo+ICsrKyBiL3Rvb2xzL3BlcmYvYnVpbHRpbi10b3AuYw0KPiBAQCAtMTcy
OSw2ICsxNzI5LDE0IEBAIGludCBjbWRfdG9wKGludCBhcmdjLCBjb25zdCBjaGFyICoqYXJndikN
Cj4gIAlpZiAob3B0cy0+YnJhbmNoX3N0YWNrICYmIGNhbGxjaGFpbl9wYXJhbS5lbmFibGVkKQ0K
PiAgCQlzeW1ib2xfY29uZi5zaG93X2JyYW5jaGZsYWdfY291bnQgPSB0cnVlOw0KPiAgDQo+ICsJ
aWYgKG9wdHMtPmJyYW5jaF9zdGFjaykgew0KPiArCQlzdGF0dXMgPSBwZXJmX2Vudl9fcmVhZF9j
b3JlX3BtdV9jYXBzKCZwZXJmX2Vudik7DQo+ICsJCWlmIChzdGF0dXMpIHsNCj4gKwkJCXByX2Vy
cigiUE1VIGNhcGFiaWxpdHkgZGF0YSBpcyBub3QgYXZhaWxhYmxlXG4iKTsNCj4gKwkJCWdvdG8g
b3V0X2RlbGV0ZV9ldmxpc3Q7DQo+ICsJCX0NCj4gKwl9DQo+ICsNCj4gIAlzb3J0X19tb2RlID0g
U09SVF9NT0RFX19UT1A7DQo+ICAJLyogZGlzcGxheSB0aHJlYWQgd2FudHMgZW50cmllcyB0byBi
ZSBjb2xsYXBzZWQgaW4gYSBkaWZmZXJlbnQgdHJlZSAqLw0KPiAgCXBlcmZfaHBwX2xpc3QubmVl
ZF9jb2xsYXBzZSA9IDE7DQo+IGRpZmYgLS1naXQgYS90b29scy9wZXJmL3V0aWwvZW52LmMgYi90
b29scy9wZXJmL3V0aWwvZW52LmMNCj4gaW5kZXggMzY0MTE3NDllMDA3Li42NzM1Nzg2YTFkMjIg
MTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3BlcmYvdXRpbC9lbnYuYw0KPiArKysgYi90b29scy9wZXJm
L3V0aWwvZW52LmMNCj4gQEAgLTQxNiw2ICs0MTYsMTIwIEBAIHN0YXRpYyBpbnQgcGVyZl9lbnZf
X3JlYWRfbnJfY3B1c19hdmFpbChzdHJ1Y3QgcGVyZl9lbnYgKmVudikNCj4gIAlyZXR1cm4gZW52
LT5ucl9jcHVzX2F2YWlsID8gMCA6IC1FTk9FTlQ7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBpbnQg
X19wZXJmX2Vudl9fcmVhZF9jb3JlX3BtdV9jYXBzKGNvbnN0IHN0cnVjdCBwZXJmX3BtdSAqcG11
LA0KPiArCQkJCQkgIGludCAqbnJfY2FwcywgY2hhciAqKipjYXBzLA0KPiArCQkJCQkgIHVuc2ln
bmVkIGludCAqbWF4X2JyYW5jaGVzLA0KPiArCQkJCQkgIHVuc2lnbmVkIGludCAqYnJfY250cl9u
ciwNCj4gKwkJCQkJICB1bnNpZ25lZCBpbnQgKmJyX2NudHJfd2lkdGgpDQo+ICt7DQo+ICsJc3Ry
dWN0IHBlcmZfcG11X2NhcHMgKnBjYXBzID0gTlVMTDsNCj4gKwljaGFyICpwdHIsICoqdG1wOw0K
PiArCWludCByZXQgPSAwOw0KPiArDQo+ICsJKm5yX2NhcHMgPSAwOw0KPiArCSpjYXBzID0gTlVM
TDsNCj4gKw0KPiArCWlmICghcG11LT5ucl9jYXBzKQ0KPiArCQlyZXR1cm4gMDsNCj4gKw0KPiAr
CSpjYXBzID0gemFsbG9jKHNpemVvZihjaGFyICopICogcG11LT5ucl9jYXBzKTsNCj4gKwlpZiAo
ISpjYXBzKQ0KPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gKw0KPiArCXRtcCA9ICpjYXBzOw0KPiAr
CWxpc3RfZm9yX2VhY2hfZW50cnkocGNhcHMsICZwbXUtPmNhcHMsIGxpc3QpIHsNCj4gKw0KPiAr
CQlpZiAoYXNwcmludGYoJnB0ciwgIiVzPSVzIiwgcGNhcHMtPm5hbWUsIHBjYXBzLT52YWx1ZSkg
PCAwKSB7DQo+ICsJCQlyZXQgPSAtRU5PTUVNOw0KPiArCQkJZ290byBlcnJvcjsNCj4gKwkJfQ0K
PiArDQo+ICsJCSp0bXArKyA9IHB0cjsNCj4gKw0KPiArCQlpZiAoIXN0cmNtcChwY2Fwcy0+bmFt
ZSwgImJyYW5jaGVzIikpDQo+ICsJCQkqbWF4X2JyYW5jaGVzID0gYXRvaShwY2Fwcy0+dmFsdWUp
Ow0KPiArDQo+ICsJCWlmICghc3RyY21wKHBjYXBzLT5uYW1lLCAiYnJhbmNoX2NvdW50ZXJfbnIi
KSkNCj4gKwkJCSpicl9jbnRyX25yID0gYXRvaShwY2Fwcy0+dmFsdWUpOw0KPiArDQo+ICsJCWlm
ICghc3RyY21wKHBjYXBzLT5uYW1lLCAiYnJhbmNoX2NvdW50ZXJfd2lkdGgiKSkNCj4gKwkJCSpi
cl9jbnRyX3dpZHRoID0gYXRvaShwY2Fwcy0+dmFsdWUpOw0KPiArCX0NCj4gKwkqbnJfY2FwcyA9
IHBtdS0+bnJfY2FwczsNCj4gKwlyZXR1cm4gMDsNCj4gK2Vycm9yOg0KPiArCXdoaWxlICh0bXAt
LSAhPSAqY2FwcykNCj4gKwkJZnJlZSgqdG1wKTsNCj4gKwlmcmVlKCpjYXBzKTsNCj4gKwkqY2Fw
cyA9IE5VTEw7DQo+ICsJKm5yX2NhcHMgPSAwOw0KPiArCXJldHVybiByZXQ7DQo+ICt9DQo+ICsN
Cj4gK2ludCBwZXJmX2Vudl9fcmVhZF9jb3JlX3BtdV9jYXBzKHN0cnVjdCBwZXJmX2VudiAqZW52
KQ0KPiArew0KPiArCXN0cnVjdCBwZXJmX3BtdSAqcG11ID0gTlVMTDsNCj4gKwlzdHJ1Y3QgcG11
X2NhcHMgKnBtdV9jYXBzOw0KPiArCWludCBucl9wbXUgPSAwLCBpID0gMCwgajsNCj4gKwlpbnQg
cmV0Ow0KPiArDQo+ICsJbnJfcG11ID0gcGVyZl9wbXVzX19udW1fY29yZV9wbXVzKCk7DQo+ICsN
Cj4gKwlpZiAoIW5yX3BtdSkNCj4gKwkJcmV0dXJuIC1FTk9ERVY7DQo+ICsNCj4gKwlpZiAobnJf
cG11ID09IDEpIHsNCj4gKwkJcG11ID0gcGVyZl9wbXVzX19maW5kX2NvcmVfcG11KCk7DQo+ICsJ
CWlmICghcG11KQ0KPiArCQkJcmV0dXJuIC1FTk9ERVY7DQo+ICsJCXJldCA9IHBlcmZfcG11X19j
YXBzX3BhcnNlKHBtdSk7DQo+ICsJCWlmIChyZXQgPCAwKQ0KPiArCQkJcmV0dXJuIHJldDsNCj4g
KwkJcmV0dXJuIF9fcGVyZl9lbnZfX3JlYWRfY29yZV9wbXVfY2FwcyhwbXUsICZlbnYtPm5yX2Nw
dV9wbXVfY2FwcywNCj4gKwkJCQkJCSAgICAgICZlbnYtPmNwdV9wbXVfY2FwcywNCj4gKwkJCQkJ
CSAgICAgICZlbnYtPm1heF9icmFuY2hlcywNCj4gKwkJCQkJCSAgICAgICZlbnYtPmJyX2NudHJf
bnIsDQo+ICsJCQkJCQkgICAgICAmZW52LT5icl9jbnRyX3dpZHRoKTsNCj4gKwl9DQo+ICsNCj4g
KwlwbXVfY2FwcyA9IHphbGxvYyhzaXplb2YoKnBtdV9jYXBzKSAqIG5yX3BtdSk7DQo+ICsJaWYg
KCFwbXVfY2FwcykNCj4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ICsNCj4gKwl3aGlsZSAoKHBtdSA9
IHBlcmZfcG11c19fc2Nhbl9jb3JlKHBtdSkpICE9IE5VTEwpIHsNCj4gKwkJaWYgKHBlcmZfcG11
X19jYXBzX3BhcnNlKHBtdSkgPD0gMCkNCj4gKwkJCWNvbnRpbnVlOw0KPiArCQlyZXQgPSBfX3Bl
cmZfZW52X19yZWFkX2NvcmVfcG11X2NhcHMocG11LCAmcG11X2NhcHNbaV0ubnJfY2FwcywNCj4g
KwkJCQkJCSAgICAgJnBtdV9jYXBzW2ldLmNhcHMsDQo+ICsJCQkJCQkgICAgICZwbXVfY2Fwc1tp
XS5tYXhfYnJhbmNoZXMsDQo+ICsJCQkJCQkgICAgICZwbXVfY2Fwc1tpXS5icl9jbnRyX25yLA0K
PiArCQkJCQkJICAgICAmcG11X2NhcHNbaV0uYnJfY250cl93aWR0aCk7DQo+ICsJCWlmIChyZXQp
DQo+ICsJCQlnb3RvIGVycm9yOw0KPiArDQo+ICsJCXBtdV9jYXBzW2ldLnBtdV9uYW1lID0gc3Ry
ZHVwKHBtdS0+bmFtZSk7DQo+ICsJCWlmICghcG11X2NhcHNbaV0ucG11X25hbWUpIHsNCj4gKwkJ
CXJldCA9IC1FTk9NRU07DQo+ICsJCQlnb3RvIGVycm9yOw0KPiArCQl9DQo+ICsJCWkrKzsNCj4g
Kwl9DQo+ICsNCj4gKwllbnYtPm5yX3BtdXNfd2l0aF9jYXBzID0gbnJfcG11Ow0KPiArCWVudi0+
cG11X2NhcHMgPSBwbXVfY2FwczsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArZXJyb3I6DQo+ICsJ
Zm9yIChpID0gMDsgaSA8IG5yX3BtdTsgaSsrKSB7DQo+ICsJCWZvciAoaiA9IDA7IGogPCBwbXVf
Y2Fwc1tpXS5ucl9jYXBzOyBqKyspDQo+ICsJCQlmcmVlKHBtdV9jYXBzW2ldLmNhcHNbal0pOw0K
PiArCQlmcmVlKHBtdV9jYXBzW2ldLmNhcHMpOw0KPiArCQlmcmVlKHBtdV9jYXBzW2ldLnBtdV9u
YW1lKTsNCj4gKwl9DQo+ICsJZnJlZShwbXVfY2Fwcyk7DQo+ICsJcmV0dXJuIHJldDsNCj4gK30N
Cj4gKw0KPiAgY29uc3QgY2hhciAqcGVyZl9lbnZfX3Jhd19hcmNoKHN0cnVjdCBwZXJmX2VudiAq
ZW52KQ0KPiAgew0KPiAgCXJldHVybiBlbnYgJiYgIXBlcmZfZW52X19yZWFkX2FyY2goZW52KSA/
IGVudi0+YXJjaCA6ICJ1bmtub3duIjsNCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdXRpbC9l
bnYuaCBiL3Rvb2xzL3BlcmYvdXRpbC9lbnYuaA0KPiBpbmRleCBkOTBlMzQzY2YxZmEuLjEzNWEx
ZjcxNDkwNSAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvcGVyZi91dGlsL2Vudi5oDQo+ICsrKyBiL3Rv
b2xzL3BlcmYvdXRpbC9lbnYuaA0KPiBAQCAtMTUyLDYgKzE1Miw3IEBAIHN0cnVjdCBidGZfbm9k
ZTsNCj4gIA0KPiAgZXh0ZXJuIHN0cnVjdCBwZXJmX2VudiBwZXJmX2VudjsNCj4gIA0KPiAraW50
IHBlcmZfZW52X19yZWFkX2NvcmVfcG11X2NhcHMoc3RydWN0IHBlcmZfZW52ICplbnYpOw0KPiAg
dm9pZCBwZXJmX2Vudl9fZXhpdChzdHJ1Y3QgcGVyZl9lbnYgKmVudik7DQo+ICANCj4gIGludCBw
ZXJmX2Vudl9fa2VybmVsX2lzXzY0X2JpdChzdHJ1Y3QgcGVyZl9lbnYgKmVudik7DQoNCg==
