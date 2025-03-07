Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9477923BCFA;
	Fri,  7 Mar 2025 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741364927; cv=fail; b=GYIoKyb6/vb6U9qUbdIo3jspJsCNbYJefRPWLIvkki51mUZrJd32DTzFKIGCowtHarzmoD/tIhtjwz50vvd3hqIBDyq8AgJ4bG/o2DSzfYuW63BcWcy2jvjrneCzvomgqRz2TepCNeQ+DUdRqXWV4QjXiun6b6ckGU/+nPUmi84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741364927; c=relaxed/simple;
	bh=ieLmWMClEG/nBxVwGVws1y2av4M6jP0ja8wBIx3Sr2w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lp0+5Fw60Wz5EQJZpeuQQAICkHx6YhG3JuhkrjrEiAjm+vVO4OTjp/d1WIOszp19HDd3Ncv2dZjueIzYbsK9G10XnJLi3J4UQKQ2UGEozOpMGEh9NX2AFpwchJ5mnuEMuFyndOyWwFXMwRos1JCusjZeX1cD/UhQT7WACrCQIU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=akKelOST; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="akKelOST"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741364925; x=1772900925;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ieLmWMClEG/nBxVwGVws1y2av4M6jP0ja8wBIx3Sr2w=;
  b=akKelOSTOytacXdiLyfWlCkctOvwf867aT4vl6ShdYTjKExMuXNAbznN
   Gsb/YoKc/iW+EZ3Gk6CmKfiFsYvik1lyFsP/2k5lLETXgn2jrfVBnL9Iu
   8TeW6vrd4hXY3BVkmJ/65Yji4LcNiIQCqx+D7mILLkFJj+vQ/jo7SteaB
   257nQtQ1lz9urKl4bmAJp+ErmWlK2EEXfZFFXo7kOU5vEwOBxgKeGm+ZA
   afJOi6wY6u//MB/NpU7j4zSbuT5o3aBZycry3t+23KDs9RG4yNjBgUc62
   +sB9AmMA9C1KMtNuy0brh9H0KuLjyaOqSkShjMHGF2MVJxqGiU9NKPScT
   Q==;
X-CSE-ConnectionGUID: YUZzwUzMRty+tf3QsG4g9g==
X-CSE-MsgGUID: mjSlyg36QTaFXN/tqluB5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53055851"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="53055851"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 08:28:44 -0800
X-CSE-ConnectionGUID: Zhf4Xmw/SRy/Nca/N+h2Xw==
X-CSE-MsgGUID: cGJ6Q3S5TLW2P8fjlydkxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123553124"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2025 08:28:44 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Mar 2025 08:28:43 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 08:28:43 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 08:28:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wh7czzykxEQbc7XA03Qe2QT+8xy+nW1TBbZIAvdaDl0esWmkvL2wdUy0T2wNlraEPYS26dSGlg3E8VFxcgaCgJueH2sbljNzzlQNTj2W82YSdQJvTBEh8A+WajOlhfLXp5jOkzMVF9gFHXHJIGMJbBbatnPvEEbBrdtNPHVUJOCosYYzYduoovNRzNR1cKo4II4KClqpHwjmjYtwkp32LN3+yKEm2KKuuPjfKrf6M9F5Wue+SAifd7WnJONrMCiUsuP3u0KQVnQdKsuHhkVRbK9e/VHEoilOYiRT4o2jTsEmV54j/E1tXal9PJ3r8EmYYZ0xKzIydVxT4Dc4uOSwRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieLmWMClEG/nBxVwGVws1y2av4M6jP0ja8wBIx3Sr2w=;
 b=gFRP5h4OsT9xTAAX+iwZqoMtQlTjZ6T5Y1TDOo5OJkE7PYi2j5h+LQuaLihKaWDwku7wsph+Sc1MescXNVO9ljFk/UtDUSbBeBq7fZc/fWp+GeJkTKsKZdp7wyK5zdYKmmtTh7KtdUWm1rt9cfILJE2jv0T/ncXZO4Zfwjteaz7us2OgSLWH1neE1lXtePrvYYzZH7jYR3CMbomOSxXQuMuGNYPpvLPbL12xH5xW6CJgA2jUgagCObSOyd/v+G0gksekpLI5cdr0s5+IFO0Dupl4mAWi2mkvDUgZp7yC7LYOLT8V3jOF7qXHusd78sSbO58Lw3N/4R/cqLU5NbHHuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by SA1PR11MB7700.namprd11.prod.outlook.com (2603:10b6:806:330::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 16:28:41 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%4]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 16:28:41 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "namhyung@kernel.org" <namhyung@kernel.org>, "acme@kernel.org"
	<acme@kernel.org>, "irogers@google.com" <irogers@google.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>
CC: "jolsa@kernel.org" <jolsa@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"mingo@kernel.org" <mingo@kernel.org>
Subject: Re: [PATCH v2 2/2] perf report: Fix memory leaks in the hierarchy
 mode
Thread-Topic: [PATCH v2 2/2] perf report: Fix memory leaks in the hierarchy
 mode
Thread-Index: AQHbjygXYRTqza11NU+jhcpee66ds7Nn3acA
Date: Fri, 7 Mar 2025 16:28:41 +0000
Message-ID: <403e3848770cef1d70357452082ddda0e92275fc.camel@intel.com>
References: <20250307061250.320849-1-namhyung@kernel.org>
	 <20250307061250.320849-2-namhyung@kernel.org>
In-Reply-To: <20250307061250.320849-2-namhyung@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|SA1PR11MB7700:EE_
x-ms-office365-filtering-correlation-id: 299cc024-c6a1-419c-6046-08dd5d951f65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WjE2RmphS1VyQjBHL0F2elNwc3VuNWg0SVJNbXBKV1h4R2ZpamF4YlMrZWRv?=
 =?utf-8?B?dlFFa1h0WTYvbzExS2E1YnVjNEZPSjEzZWRxb3ltbG1ZZzNaMmNnaktyV3Jj?=
 =?utf-8?B?YjhUeTRWT0pVU1FGYzlud2FSVXBBS1lUZ0RVRFB5YXlBdHEwcjNHU2NQU2Rh?=
 =?utf-8?B?MTlYZ2djRXFvYTJJR1lZYVo2VGV6WHNjU2czOExmaVZJQTYzVEdZbk04ZDFm?=
 =?utf-8?B?TXpsZlZGeFdMVCtYOXd2cVd1K1NJaXcySGlQOGdJVjZEdkVFS2JqVWYrdytY?=
 =?utf-8?B?Qnl6MWYrNldxcFBZSFpSTkRhdjRXOWxCU3hSSk5KY1hSQWFBZ1JHNXY4Nk9s?=
 =?utf-8?B?WkpxUDBGb3kwSVhEdkNKU2N0d093ckErMzM1eGRVbmJBcWVFbTB6NWg1YjVQ?=
 =?utf-8?B?OFg2U3BDNTcybmh5UTF0QVVGRGJOUlNSWjdCV2RrNFoxaERvMjJXRUwvcHVk?=
 =?utf-8?B?YWJNYVV5RHRpRXRWcm5EUGc4Rmh0Q0dmRlVvK1ZYTEsxWjZqWWg1QTdSRnpW?=
 =?utf-8?B?NkZiU1EwZFg5Q3gyNVZXaGpzT2Z6dEcyZFFIb0lsZjlpSjlaSkdhODFJK0p2?=
 =?utf-8?B?TFhKQTZMWkVrQ0xhSmZ5RnFhY055b29FdzBLK3dBK25WbWhJSnp4K2drZVNu?=
 =?utf-8?B?b0l6TEMzUHhPN050WkZ5UzJzVDVlZTNJck9YaGt6eFRRdDdNVkMwMnpRVkx5?=
 =?utf-8?B?YVNianJXbGVjMFJCZnBacWM3a1J0ajRrVzFaUnFYa3lqYnM2cTdnazNSby9T?=
 =?utf-8?B?UUI3MjF6RzRhRFp4SEZwWForblRhNDhZYXBtR0FqNy9aTlJOdkNyanhhRGZ5?=
 =?utf-8?B?Q2loUnhOYVQ0alZ3K1FlOXptZHVxMllYeG9MZG1PR3JTbmhJdEVCbEthdzZm?=
 =?utf-8?B?RjZvQkRDcytLV1VpcXZVUi8zQVQ2Nk9jQWZ6bUttWU03TWp2bDdReFE2Z3Y1?=
 =?utf-8?B?QkhLWkZlYmFuaDhsN1JCWVRmQ2tPdCtNMTFqelhaMTFZMmJXWEQ3Qlo3MzRM?=
 =?utf-8?B?Q3U1Sm1GZSs5NkZONmJic2dlMHpZL25laC8rS0ZlNGFkcVo3VTl3eFhlaHhs?=
 =?utf-8?B?TXh0cDloNnFveVh0Q1dEdWYrakRGMGRKU29ZZHJrWWdZelgvQnJzWmovNHdi?=
 =?utf-8?B?UjZDTXVNTzlvakpoYlVDL2hLVEZSQldUM2pnZHhWNWFjeWZvNnNhR2pvRm9G?=
 =?utf-8?B?SzNtby8yVXN0MHpPS2Q2UTdBQU5JMFd5ckppeDJkdVozcDNIeG9UU2hGNnlJ?=
 =?utf-8?B?ZVpLYjVIR25iV2JkRnBheHd6WW0xY0FWRXVaa29RNkpQL2xWemF6bTV0cWIr?=
 =?utf-8?B?SFYzWG93WGYyd3IyeUE5clcrUVQwWEZKaUc1NnFKLzJMN3ozVnREd094YjV1?=
 =?utf-8?B?QUUxcFR4V3p3V1ZPOEt0VFFOcWNWdkFSNDdBWXV1LzBsTEdZdkJjU2JnTzlY?=
 =?utf-8?B?NSswL0E3czZpTUJITmt3d29TYy9FeGx3SThFZVJKaGVWN1pGZUhLL2lLQVlD?=
 =?utf-8?B?bk05bkIzUERuMmtHMXo1OVpySlMxa0N5MmUwZW9ncURqeEtNWThlSUdmMWxX?=
 =?utf-8?B?Z2dmd2lqRlJCMC9UN3dySWY1Wm04UTlmbjFqLzM0a2lvQ3RBdXMrVXpoMmhI?=
 =?utf-8?B?SG5vVHFRazRxQkNhaHNTeFJadVM0LzlMUnErUTBHUzlSTklxdms5TzM3NEFP?=
 =?utf-8?B?WWd0WHJaRXdQWitsaE5OTDI4dmxxd1gzRklUODc2TGlleHFCTktzT01pVmwr?=
 =?utf-8?B?T2U2N0RYSXVsc0ZDV3FlMGhydXN1dlNBOU9yUTlWMm5uYzBBckRJTXJIV2JU?=
 =?utf-8?B?MHJ1WHpSWkZ5akVYMHlPVVFLSWNtQlB1VitPOGZKTHdkb1V0eXUvSDhVSW1v?=
 =?utf-8?B?YnpBWEZpM1pJa1o1dWVnZkZjZC9yT04wRzNkOGhOTjZwcmhuUURjT1JWNVNI?=
 =?utf-8?Q?lIz+0zqheURP8+f3CRYudlEMgpc4tsy8?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0w1NmFDQkdKNkdHa09HNUVtd1Z2UFU3YkVIc2VVYlNLUHY5Z09BZThxYk43?=
 =?utf-8?B?SjJTaGxpNFhrS3JFTE9nTC9DVzhqWTdlL0pmNEFmdnpDSXNtcUpVNjZKVmZD?=
 =?utf-8?B?Smg4NGhMZXJuWWR1MmsyRGRrYlUyWWVxUUU4N3NvcjBVaG1WcWFqRlUwNk55?=
 =?utf-8?B?eW9hN01uTEk1M3U0VzQ0Z2oyK2xpM3dvYU9CZThJb0V2akpqM2QyZEoydnR0?=
 =?utf-8?B?ZVNLc2FKdGFVbklhT1NNeWMycGMrMGdNUmxmVkZGLzhuV3l0L3lFOThyUEFO?=
 =?utf-8?B?cXppME93cVhhRVFvM1JtelRGYTNXeHNwN3g0K1dISnRjRHVmbGVZaytXYTNF?=
 =?utf-8?B?eXdHc0VBNWtpZ0ZEYWdtSmM3K0lwOWhUT1dnYkRIL1NDbU5HRTFuQlZBbTdV?=
 =?utf-8?B?Wno4bVJGZzdaTTQzcUxFZ2NwemFQeE5XeDZ0OVdaQkxWYnlldTV1eExxTGRE?=
 =?utf-8?B?Vmo2RUxFMUlxYWdaSGpQNW9Ua1lIZ1RUUmpzTW5FeFlxYkxjTXN6amlzVVlj?=
 =?utf-8?B?NDRZVXBpQjBzZFVaUmxkR2ZNUnd6dGJWMjJCSDAvbXVFa0F2NjYzQmUrSXpn?=
 =?utf-8?B?eE5vcG0vdDJDL2RHM1UzUzNVbkFMb0RaWUk1UDc5aG9pcitFa05ibUV3eFdt?=
 =?utf-8?B?a0tjZFJrb0QyWnJQTE1wbjRvQ1NZaVZoamtmUWFJamlFYlBUNEREeGZoZGF4?=
 =?utf-8?B?YkFzd1ZlaFNVMHZueVdiZ1VDRVg3MHNsWUFVaFdTb3VxcTBxbGNZV2NTazJJ?=
 =?utf-8?B?K0FPL2JFT2lwZ2VTVHo2bVBzQm94TG11UmR1RS83b0VCMHY2N2huMUhvZTU3?=
 =?utf-8?B?Q3IrcE9Oeno4bWRLREFPYjF0blE4bjdmUEd3S3RhZi9pNVpGb01XaTB6Ky9s?=
 =?utf-8?B?NjdHWVhXbVhROTBUNm9OT1VQQ0hFZHBYUGt5dUM4VUhtSmRIUjVFZWpKbk1Z?=
 =?utf-8?B?TWZBbUsyMVUrWDc5Slp1bDJuU1M0NDRSdGNCazNrb3ErUldJK0FWekZUaTBZ?=
 =?utf-8?B?SWpmcC90N2w5NmlpMlRnM0Nta1FaeEFrWjF5ZnZPa1Q3UUtBdzVOa0hTYTYr?=
 =?utf-8?B?VXZ2YXhkWTRuZC9zOWw4RnVjWjFQblRtUnkvUHRnWnZhZ01JbkVhc3loSTdM?=
 =?utf-8?B?b0JFODNIaEt5STVxQlRwRG1YdnBRakFoLzR4Si8xUFdNQThweTZ2aHYvdlhI?=
 =?utf-8?B?Vk5HREQ5RVNRUXJ3TTZmcHE2cmVaMVB5SldsRWcxSDRoVHVmSG9jVnZqckFH?=
 =?utf-8?B?NDZLY0VKcTJLZm9HZFQ2M3RFVDJJUUFXKzkzOXdLM3B4bHlWR2FpK1hjQURz?=
 =?utf-8?B?dXFVRTRvMWZxdDVobzhuc2lOSExmMWlkbktLekFuczFnMkJiWEpVMStiaC82?=
 =?utf-8?B?enJuL28vR3hkMEJIOEJCY1lWV3dRVU56TGpoR3duelRTUWsxZmdyR05LdEJK?=
 =?utf-8?B?VjJjTGVBWW1MYkV0K1dMb1RUWjNRbTludXZMeHU1bUdacTRkWVI2NTZVMFUz?=
 =?utf-8?B?K2tnSEFrbHoxM2hoVEpkY3J3L0MxQVBYV3hGbmtHVzFFc3dGTjlzYytXYWs0?=
 =?utf-8?B?dDRieEs3WWliaEF5aVlTYVZXMnc1U1NOazdGY1I5dXVNYi9vSjBjQWZnZG5Z?=
 =?utf-8?B?TzVNYnlVRFFWd0c4dmVVQ1h3TUFYVUJueTRGTkVvQXZ0bzZxd2tndmtKM25S?=
 =?utf-8?B?akFCT0ttSEt6V2pQT0UxS1haMnRkZ2tieVdid3FvQ3N4bmRwM3JCZXZxQXdx?=
 =?utf-8?B?dTU4K1BzTW55c3I4b2RvQlh2UDdNRG0yK0xadVQrUldtcVZXeHA4VVJJMi8x?=
 =?utf-8?B?REU1UzNUT2NKK1hpQWlkbDk1T1UyaUN3eEcxSjdjeGs0aDFxbEdnUUZ6UUxh?=
 =?utf-8?B?c05WSWY5QWEvY3lzR1kvTFVkL1gxcmI4WWkzaktiYXl0ZmpUVU1Oazk5Mnkr?=
 =?utf-8?B?cGJvV2gwY08wMUZGcWNEYW5tWUtmRGllRnRjRGp6WmQ4d0hVNldjVDI5V1pE?=
 =?utf-8?B?clpCUFVDWnB6Vmxsa3ovWFFTWjJONnd1VjZURnNKUmRKa24zNW1BOEVWVjAw?=
 =?utf-8?B?bXJXd01scmZuM2ZZVlpGRWVkc2JOQUI0WHBMTjdKYWFkVEdYNzdNRGJHUjJM?=
 =?utf-8?B?VWtlamxCek5CNTdOR1lNSmFib3VaNUZaYTlrcnhPZzd5dkRyYnk1a3ArMHow?=
 =?utf-8?Q?aNSySswn0TxouWy8AjjY8/s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C596CB9C2A3204FAF2D1E3B55512C21@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299cc024-c6a1-419c-6046-08dd5d951f65
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 16:28:41.4235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3mqxMX41ZFClM98zu96ka6k58NnvdcljT87Cc8sWMmLC2dcu1tsgz8LeJxS46RNoaEGOoQSuIkwrvtKJY79p2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7700
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTAzLTA2IGF0IDIyOjEyIC0wODAwLCBOYW1oeXVuZyBLaW0gd3JvdGU6DQo+
IElhbiB0b2xkIG1lIHRoYXQgdGhlcmUgYXJlIG1hbnkgbWVtb3J5IGxlYWtzIGluIHRoZSBoaWVy
YXJjaHkgbW9kZS7CoA0KPiBJDQo+IGNhbiBlYXNpbHkgcmVwcm9kdWNlIGl0IHdpdGggdGhlIGZv
bGx3aW5nIGNvbW1hbmQuDQo+IA0KPiDCoCAkIG1ha2UgREVCVUc9MSBFWFRSQV9DRkxBR1M9LWZz
YW5pdGl6ZT1sZWFrDQo+IA0KPiDCoCAkIHBlcmYgcmVjb3JkIC0tbGF0ZW5jeSAtZyAtLSAuL3Bl
cmYgdGVzdCAtdyB0aGxvb3ANCj4gDQo+IMKgICQgcGVyZiByZXBvcnQgLUggLS1zdGRpbw0KPiDC
oCAuLi4NCj4gwqAgSW5kaXJlY3QgbGVhayBvZiAxNjggYnl0ZShzKSBpbiAyMSBvYmplY3Qocykg
YWxsb2NhdGVkIGZyb206DQo+IMKgwqDCoMKgwqAgIzAgMHg3ZjM0MTRjMTZjNjUgaW4gbWFsbG9j
DQo+IC4uLy4uLy4uLy4uL3NyYy9saWJzYW5pdGl6ZXIvbHNhbi9sc2FuX2ludGVyY2VwdG9ycy5j
cHA6NzUNCj4gwqDCoMKgwqDCoCAjMSAweDU1ZWQzNjAyMzQ2ZSBpbiBtYXBfX2dldCB1dGlsL21h
cC5oOjE4OQ0KPiDCoMKgwqDCoMKgICMyIDB4NTVlZDM2MDI0Y2M0IGluIGhpc3RfZW50cnlfX2lu
aXQgdXRpbC9oaXN0LmM6NDc2DQo+IMKgwqDCoMKgwqAgIzMgMHg1NWVkMzYwMjUyMDggaW4gaGlz
dF9lbnRyeV9fbmV3IHV0aWwvaGlzdC5jOjU4OA0KPiDCoMKgwqDCoMKgICM0IDB4NTVlZDM2MDI3
YzA1IGluIGhpZXJhcmNoeV9pbnNlcnRfZW50cnkgdXRpbC9oaXN0LmM6MTU4Nw0KPiDCoMKgwqDC
oMKgICM1IDB4NTVlZDM2MDI3ZTJlIGluIGhpc3RzX19oaWVyYXJjaHlfaW5zZXJ0X2VudHJ5DQo+
IHV0aWwvaGlzdC5jOjE2MzgNCj4gwqDCoMKgwqDCoCAjNiAweDU1ZWQzNjAyN2ZhNCBpbiBoaXN0
c19fY29sbGFwc2VfaW5zZXJ0X2VudHJ5DQo+IHV0aWwvaGlzdC5jOjE2ODUNCj4gwqDCoMKgwqDC
oCAjNyAweDU1ZWQzNjAyODNlOCBpbiBoaXN0c19fY29sbGFwc2VfcmVzb3J0IHV0aWwvaGlzdC5j
OjE3NzYNCj4gwqDCoMKgwqDCoCAjOCAweDU1ZWQzNWRlMDMyMyBpbiByZXBvcnRfX2NvbGxhcHNl
X2hpc3RzDQo+IC9ob21lL25hbWh5dW5nL3Byb2plY3QvbGludXgvdG9vbHMvcGVyZi9idWlsdGlu
LXJlcG9ydC5jOjczNQ0KPiDCoMKgwqDCoMKgICM5IDB4NTVlZDM1ZGUxNWI0IGluIF9fY21kX3Jl
cG9ydA0KPiAvaG9tZS9uYW1oeXVuZy9wcm9qZWN0L2xpbnV4L3Rvb2xzL3BlcmYvYnVpbHRpbi1y
ZXBvcnQuYzoxMTE5DQo+IMKgwqDCoMKgwqAgIzEwIDB4NTVlZDM1ZGU0M2RjIGluIGNtZF9yZXBv
cnQNCj4gL2hvbWUvbmFtaHl1bmcvcHJvamVjdC9saW51eC90b29scy9wZXJmL2J1aWx0aW4tcmVw
b3J0LmM6MTg2Nw0KPiDCoMKgwqDCoMKgICMxMSAweDU1ZWQzNWU2Njc2NyBpbiBydW5fYnVpbHRp
bg0KPiAvaG9tZS9uYW1oeXVuZy9wcm9qZWN0L2xpbnV4L3Rvb2xzL3BlcmYvcGVyZi5jOjM1MQ0K
PiDCoMKgwqDCoMKgICMxMiAweDU1ZWQzNWU2NmEwZSBpbiBoYW5kbGVfaW50ZXJuYWxfY29tbWFu
ZA0KPiAvaG9tZS9uYW1oeXVuZy9wcm9qZWN0L2xpbnV4L3Rvb2xzL3BlcmYvcGVyZi5jOjQwNA0K
PiDCoMKgwqDCoMKgICMxMyAweDU1ZWQzNWU2NmI2NyBpbiBydW5fYXJndg0KPiAvaG9tZS9uYW1o
eXVuZy9wcm9qZWN0L2xpbnV4L3Rvb2xzL3BlcmYvcGVyZi5jOjQ0OA0KPiDCoMKgwqDCoMKgICMx
NCAweDU1ZWQzNWU2NmViMCBpbiBtYWluDQo+IC9ob21lL25hbWh5dW5nL3Byb2plY3QvbGludXgv
dG9vbHMvcGVyZi9wZXJmLmM6NTU2DQo+IMKgwqDCoMKgwqAgIzE1IDB4N2YzNDBhYzMzZDY3IGlu
IF9fbGliY19zdGFydF9jYWxsX21haW4NCj4gLi4vc3lzZGVwcy9ucHRsL2xpYmNfc3RhcnRfY2Fs
bF9tYWluLmg6NTgNCj4gwqAgLi4uDQo+IA0KPiDCoCAkIHBlcmYgcmVwb3J0IC1IIC0tc3RkaW8g
Mj4mMSB8IGdyZXAgLWMgJ15JbmRpcmVjdCBsZWFrJw0KPiDCoCA5Mw0KPiANCj4gSSBmb3VuZCB0
aGF0IGhpc3RfZW50cnlfX2RlbGV0ZSgpIG1pc3NlZCB0byByZWxlYXNlIGNoaWxkIGVudHJpZXMg
aW4NCj4gdGhlDQo+IGhpZXJhcmNoeSB0cmVlIChocm9vdF97aW4sb3V0fSkuwqAgSXQgbmVlZHMg
dG8gaXRlcmF0ZSB0aGUgY2hpbGQNCj4gZW50cmllcw0KPiBhbmQgY2FsbCBoaXN0X2VudHJ5X19k
ZWxldGUoKSByZWN1cnNpdmVseS4NCj4gDQo+IEFmdGVyIHRoaXMgY2hhbmdlOg0KPiANCj4gwqAg
JCBwZXJmIHJlcG9ydCAtSCAtLXN0ZGlvIDI+JjEgfCBncmVwIC1jICdeSW5kaXJlY3QgbGVhaycN
Cj4gwqAgMA0KPiANCj4gUmVwb3J0ZWQtYnk6IElhbiBSb2dlcnMgPGlyb2dlcnNAZ29vZ2xlLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogTmFtaHl1bmcgS2ltIDxuYW1oeXVuZ0BrZXJuZWwub3JnPg0K
DQpUZXN0ZWQgb24gYW4gQXJyb3cgTGFrZSBzeXN0ZW0uDQoNClRlc3RlZC1ieSBUaG9tYXMgRmFs
Y29uIDx0aG9tYXMuZmFsY29uQGludGVsLmNvbT4NCg0KPiAtLS0NCj4gdjIpIFVzZSByYnRyZWVf
cG9zdG9yZGVyX2Zvcl9lYWNoX2VudHJ5X3NhZmUoKcKgIChJYW4pDQo+IA0KPiDCoHRvb2xzL3Bl
cmYvdXRpbC9oaXN0LmMgfCAxMCArKysrKysrKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEwIGlu
c2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS90b29scy9wZXJmL3V0aWwvaGlzdC5jIGIv
dG9vbHMvcGVyZi91dGlsL2hpc3QuYw0KPiBpbmRleCBmYmYxMzFhZWFlN2ZmZTliLi5kNjUyMjhj
MTE0MTI1MWZiIDEwMDY0NA0KPiAtLS0gYS90b29scy9wZXJmL3V0aWwvaGlzdC5jDQo+ICsrKyBi
L3Rvb2xzL3BlcmYvdXRpbC9oaXN0LmMNCj4gQEAgLTEzODUsNiArMTM4NSwxNiBAQCB2b2lkIGhp
c3RfZW50cnlfX2RlbGV0ZShzdHJ1Y3QgaGlzdF9lbnRyeSAqaGUpDQo+IMKgew0KPiDCoAlzdHJ1
Y3QgaGlzdF9lbnRyeV9vcHMgKm9wcyA9IGhlLT5vcHM7DQo+IMKgDQo+ICsJaWYgKHN5bWJvbF9j
b25mLnJlcG9ydF9oaWVyYXJjaHkpIHsNCj4gKwkJc3RydWN0IHJiX3Jvb3QgKnJvb3QgPSAmaGUt
Pmhyb290X291dC5yYl9yb290Ow0KPiArCQlzdHJ1Y3QgaGlzdF9lbnRyeSAqY2hpbGQsICp0bXA7
DQo+ICsNCj4gKwkJcmJ0cmVlX3Bvc3RvcmRlcl9mb3JfZWFjaF9lbnRyeV9zYWZlKGNoaWxkLCB0
bXAsDQo+IHJvb3QsIHJiX25vZGUpDQo+ICsJCQloaXN0X2VudHJ5X19kZWxldGUoY2hpbGQpOw0K
PiArDQo+ICsJCSpyb290ID0gUkJfUk9PVDsNCj4gKwl9DQo+ICsNCj4gwqAJdGhyZWFkX196cHV0
KGhlLT50aHJlYWQpOw0KPiDCoAltYXBfc3ltYm9sX19leGl0KCZoZS0+bXMpOw0KPiDCoA0KDQo=
