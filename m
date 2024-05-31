Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB8884E11;
	Fri, 31 May 2024 23:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717196610; cv=fail; b=XjqQ4A31QAcSIQ8Q+HCaqIH/s4WlL+MuoFbMCFBRR8DeT4/7ZFn/3dSCSTadt3MDrNbb7c5jc1r0qckHpoMAGfFQgFUuXSzLuk9PAzBrFlP6wYuz38rWksXARHUaez5zfSjKPNDG0O4cgKSPJ40iIYqPn9b93G5uI+QdrKiYgDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717196610; c=relaxed/simple;
	bh=f/bgaliEgmmX8UqXn6xJx5ni/CTjLtuGutGawXkrFcg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V8jrbsPHglfrBUYusypW7gmTzUHnTWL5wZFEFBzXuSqAJD/eOu6ZTnZfnfBId4RLknILfBAmEnlh0cfUfrDSoa/TN4tgF5uc9vCMu5ZeGEWZQaaFbWcZ1B8WoyKc3NCq6TgRNart9bF4X0BILMsvRTqEZk5zcihJ011Eo+AeF8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BN3aWnGh; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BN3aWnGh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717196609; x=1748732609;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f/bgaliEgmmX8UqXn6xJx5ni/CTjLtuGutGawXkrFcg=;
  b=BN3aWnGhSt8Op8zJFbUWf+SrQeHNoCbZhNMRDRTMW5ISQAxKH/csuXLy
   M29/w9cb1z6MHf4xenWfI/WovXl8ey4+inrxyc9bSAUant7YHOOZRTLD8
   5VGxBy6RudIDocS32LNNmEe02MLQKLGuMk9Jri7N7P4KJWJ5VMHEUtYnG
   mPCyuJUbgFhUiMU4YFoKdau8FPG2xdliQ8P8EiKNJgK1YLvMISbKrGHa5
   8hV8Gxpz1jyClEWHO74uWI8ngvOqAgNCL0fZVhohu3+JgaiU9F2x83NEq
   0SAhOmdsOXuJJ6IP7V8nBExARbz2Bozif9Od4lhfAVv7xRg/gHRi7hThi
   w==;
X-CSE-ConnectionGUID: qteYXILXS9ChslrOA7EerA==
X-CSE-MsgGUID: 5zrw6Y2CR5qoygw9+q30SA==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13602355"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="13602355"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 16:03:28 -0700
X-CSE-ConnectionGUID: ZXQl9WiXSZaz0VzPA4APuA==
X-CSE-MsgGUID: rn6kLlFcRGioOGyUqhr+AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="67496623"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 May 2024 16:03:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 May 2024 16:03:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 May 2024 16:03:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 31 May 2024 16:03:27 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 31 May 2024 16:03:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlLuEJSysgIurokxH260Kbk+jIDXYSxI+y/k1380s82T0iAsayvfQvZf4Nz5vutd9FhtEQtSMWhhbF6MkSEKxyXNe2qgXUyjn0iPEEnK/7pkUuu1i5xRSOObbLgbHn7BnfH/46M3299BtA7Eijx8TP7ZenZX0c83cMsEc1c0EV+cidxVBbY41HlEGpGrTI/orJog92dYezst/bag+3KRoh3ll2obLK052huk5smrznRVG2qwgXitKgZOSe/wCwoBD/MthCJTA5g9fwKJhWAtjj1qlL6GWyxPSlsalhbDqgZUwyOVcOzFNQO3nYL+596/Foxe0qOb+AztHgUKVJJgzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/bgaliEgmmX8UqXn6xJx5ni/CTjLtuGutGawXkrFcg=;
 b=V9+AbCcvS0uWShFc/S/x7kgnW7riGyS0F50XlT5ZSfRFnOueJhgdLLJbrSQ9aGFrgcd9a0yn1gEYwc/ud0iOXl/U44NVHmwyuD4jqk8J6vx2sPWuY292V73X0oRQnjdORFbtMcCZtbOdJKh03gTejJYsgMPKenj6CnXiPP7TyIZ4LKNZgsAF5U5qFw2toiHXNldkAgt0W8LVBU6ivzxw9aNE6JEqjkJPKMoY+VZ1QHWWVhOMsL26LeegscfXuBnazjLFNiYlrdf398ncPvbXg7UvLUJPhCtaDvvrVhj9q63RZy3DFoW3v4QiSAYaBmDF88PMY+yZe/PZYYn0jscyBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by BN9PR11MB5225.namprd11.prod.outlook.com (2603:10b6:408:132::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 23:03:25 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%4]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 23:03:25 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"Kan Liang" <kan.liang@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb"
	<caleb.biggers@intel.com>
Subject: RE: [RFC PATCH v10 0/8] TPEBS counting mode support
Thread-Topic: [RFC PATCH v10 0/8] TPEBS counting mode support
Thread-Index: AQHasZORguWsh0HBOE2nG0SK0bqPIbGw5tCAgAACpYCAAPbIAIAAGXKQ
Date: Fri, 31 May 2024 23:03:25 +0000
Message-ID: <CO6PR11MB563586B37B444C5B45408B80EEFC2@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240529064327.4080674-1-weilin.wang@intel.com>
 <CAM9d7cj676sty01zqJVyk9DVesVYNFgVTZ329X=UP3xgV2aDfA@mail.gmail.com>
 <CO6PR11MB5635D7581425EF0F089EA781EEFC2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7chSC=n2sCc_nhgwqHYnBhSjMhH1quAY6_JWXNhrk1ri8Q@mail.gmail.com>
In-Reply-To: <CAM9d7chSC=n2sCc_nhgwqHYnBhSjMhH1quAY6_JWXNhrk1ri8Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|BN9PR11MB5225:EE_
x-ms-office365-filtering-correlation-id: 62e961f2-20f4-4346-29ed-08dc81c5e05e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?MVR0RkZ5RzVBc3pocGxyWldrdER2WHk0WXRHM1lvYzNMZ3lmOUJFVURSRnRH?=
 =?utf-8?B?V0lOQ1g2RUJ5M3JCS2tvNHZOdjVLdU44VXczVjRXbnVFNVJpRXBiRXl3OU0z?=
 =?utf-8?B?bW5oTXZ4YVhvS1NDaStCaElnTnJoUkZ6RDRvSW5UWnZiMTkyL2ZPZ21SQ3Y2?=
 =?utf-8?B?NUUvRWJoR2FDeEhMU2ZnSTRsd3VoWkxYbncwT2RRYWRDQnNUOFYyVkhrR002?=
 =?utf-8?B?OVF6NWpHb2RVd2dpVnBZOEJUZlh5WTlHK0R0dzRvR256eFBqQWZmWmlyWTZU?=
 =?utf-8?B?NzEyTzhvNHZRR1BKcnJHMlNPZloraGFuY2RZQkh6UW00YlRHeDFJR3U5bVQ0?=
 =?utf-8?B?V3FKQWw0ZzM4WVlJUGtFbWl5Nllyb2EveWVsTDNGMUd0b01RU1hMdzVpYysy?=
 =?utf-8?B?cUdRUWxvWWNFWnRwVVlUR2hkUWcxcjBIazkzcGFLdzhIeEo3T05DZDQvR3hH?=
 =?utf-8?B?SjdsM1dNSkRwMDBkSFFkZEhOb1l2OVkvcEE1UkIwU2Q4cHlLOTJkQlo1VHVP?=
 =?utf-8?B?cktTR1BqNG4vd1MwWVNsWVNRanlQUCtoZDNiNzEzYlBwc0R5Y3Z6MGxXTytJ?=
 =?utf-8?B?TGJ1QVZjazQzekpFbU9tVWtDTDV2YkQxaDlJM2REeVFxVEdNaldaVkMrUkNK?=
 =?utf-8?B?cVBaL0dPKzNtOHIzSVlxbm5DS0N6R20xOFJFczlvUmVrOHRYSi9wcUluWkxp?=
 =?utf-8?B?S0ZIb2l4blRVUUJOZk5HU2lvQ054VG1uREdHM3J1dWU1TEYrSEZ0TU9oVmNw?=
 =?utf-8?B?WDA3d0x0WXM1TVJpUGYwU2JIcjVndldnRGdqWDVjQVpIQXpHL2xNWFBHSkEx?=
 =?utf-8?B?VEZMQVZ0am0vU0F4c1BrdCtSRWdGMEk0K0VsQi9NQ014Q1RKeUZiNHEwVlU2?=
 =?utf-8?B?VWdXVkZNTmhlbGNjVTJVdUxWci9FbVJMNmpXeGFGTzNWQThoekgwK3JMSVpn?=
 =?utf-8?B?Vnpnc0ZaRGJmNmpYME1zM1VndlVrVmJGVmVEY1kxM3l2MFBqbzFOMzAxdDdD?=
 =?utf-8?B?aklOMisxdElmWndtVTA3NVJaVW5RTFF0aFl4T2FTUWpSZWhvT3hLQjZmd0Fq?=
 =?utf-8?B?UmxhR3ZYZmJHS3h1V0ZiUWdqM3lpd3ZyVXQvdS8rS09aeGt1ZHVPdXN1ZUpz?=
 =?utf-8?B?SjRyL2ZTUWxlRXg5SUtjRUhQL1lTUGJCU21uRmVqNyt1UG94c2dicjQvczNi?=
 =?utf-8?B?RkxhTWtLZll1TC9EQ09pT2hBMkpwYVZ1MFZveWdUcXZjQVBOaXp0Vjk5czZt?=
 =?utf-8?B?b0NHcTJsaFBEK21YcElyUWplUHRiK2Z1cVdZMFhhTC81YUJhRlNjWHBsMVpF?=
 =?utf-8?B?QktQMjZmbVREV2QyZlk1ZlRwdExNeHh5V3h2VFJjdjNpeno2RDVmaFpLNWxL?=
 =?utf-8?B?WC94bUZ4Q3AySE14VnlKLzF3ayt1SmI2WUg2Nm9mVlFvb3ZoQ3dHZGwxM0lw?=
 =?utf-8?B?ck05dHBLcnpQN1N5QnhRVUlXM1A5SE1ENlRnUTFqc2lhUGNXUUtHS2dIREVy?=
 =?utf-8?B?M0dING94MGdTZDhlU2EzMlZsczU0UytaV1ZodG9pMm0zbFRVUzZsVFVwMEw1?=
 =?utf-8?B?cWpRZHB3WmtWZ05NVm5mSlhINU1ZeVIyZWtWMHE4dFN5aW84TzRrODh4eEc2?=
 =?utf-8?B?bFM0WXMzRzJoRUVVKzF3ZHdmVHd2eUtHenJaUitQTmptbHJHZDdNcWMwRTVI?=
 =?utf-8?B?eGt6bTJWS3NyeWpEQ051R0pnMnNBc0l2MjQ1TWswdHdEc090aEJMekdoMnk2?=
 =?utf-8?B?S1lFajQ3dXJTQ2dudGlrK2ZNK1p3ZDNUVGJobFJEc0RzN3IrTENEd1lVa3pT?=
 =?utf-8?B?Q3NiTkVGTnlReVhUWWIrUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGdyay91YzR5VmROQVI4UXZ5TGRqWmN6OGdac1lkV0dHQmhCZjlkOTdJN1lO?=
 =?utf-8?B?ekhnOUMzaCtPQVBablJUQjlLcVZiZkhiM1JTQ1llYVlCRnRGbVFXSkR4MGo4?=
 =?utf-8?B?Q3prbWRaenhKYi9IUHNwblc0T1pnb01GY1llZWNKYzBVMHdEOC9WajdIanQ1?=
 =?utf-8?B?SGZKbU5IdDA0YVBRVzd2QXYvUzN5NXMyLzgxYXFJMGUybjJtOXRia3R4Y1k2?=
 =?utf-8?B?cGxuY04xcUFwOHU0ODkwNGxVTEhpUUlaekF6R0dsZC8rUHNjVVQ3N0pwUWdI?=
 =?utf-8?B?OGUwRjF4TGJJM2xSWkdTUndjWHRVKytNK2w4Q2VGOEtZZloxbXpFZ1ZZNjkv?=
 =?utf-8?B?bEN3VFJ2aWRVbzVBakdianA1SWltTE56SDQrVmVaMzhjaWJsN1dNOUJWckZJ?=
 =?utf-8?B?VjFNNUdQZVJFM1NFUW4rQkQrcUxNTnRIZ25GQU5NWDQ1UHI4V0l1MUptd3dN?=
 =?utf-8?B?SHRWT0thWWkvcWszVkxDQ3hGTGkxN2QzR09sSis4MEQwOHJyMHZjWlpJYU0w?=
 =?utf-8?B?NCs1aWYzUEJXT0pocGFFclVNU1FPYTdhcTVxSE1TcnJpQjZueEFUMjh0MkMw?=
 =?utf-8?B?Tkh0a05acnU0T0dUbWlXVzRvdEUzaUJKQ21QRTFMdTRMU1BmSXMwdUNsdjk0?=
 =?utf-8?B?dUFKckRzWDcyb2k4OG9mZm1ia2lOME1rUEdSL3EyWG1IcGFZWWRJWU5EcFZh?=
 =?utf-8?B?a0NUbjBVeHFJd0RpcE9VK2licWdqSEFaSUQ3WnZzdlVzbGNDdXB2N1hwNEFn?=
 =?utf-8?B?dGVHY250TDV3WnVvaDhjQ3lWMDVWYVlzUk14aUxob3FaK0xxd1BFNkdBeEsz?=
 =?utf-8?B?TUJqWTNkRGFDeHNBRTZHcUVYM1d3eTZjMGU0VXJSYUFhOE1mTFoxTVQram1F?=
 =?utf-8?B?bEsxanFuMGs4ekM4NVVlTldQSE12d3VHRERmdjJab2dKYUFuRVU0TW5pNlN6?=
 =?utf-8?B?VkJyRm9FSUhsVS9hU21kaXZaLzgvZllsWkkvdGFqSExuZ3hLQ0xva051TTJn?=
 =?utf-8?B?S2JNakQ5L2xZeEFKVDhBY2NqZTUwRk91M2hxTFRMZGhTMnJjbDZ3SzV2THBk?=
 =?utf-8?B?bklXb2NkTkthaWVMQ3FVNjdTU2llS3Z2SEMwTjQ0VndGTy9Ob1duWnd6K205?=
 =?utf-8?B?TEpoZXlwSytuajZLenNaZnJTb3dsanV5QVI0SWRhMXMrTkxQelVWYnk0cklF?=
 =?utf-8?B?Q2pwUkFyWW55ZVpOL1o5UHR3Z3FLWXhLdngzaVZCSE5ZU1hpRXFSRFY5QS9w?=
 =?utf-8?B?RXVGNGd4dDdLOE1hQ0JJQ0JLWHNpbHVaYUg4cEJUZ3NmYnRUWlJPY0JQNldR?=
 =?utf-8?B?YWduOEEwalJkV2xUTzNQc0xjMGdzWHNybGFGU1o3NHp1eld4dldSUm5YMEtl?=
 =?utf-8?B?b01seENRSGdmSDBCUGY3aWQ4bnBkbVBRNXFBbEhhTXhKcStEeVB0K0RJK2Z1?=
 =?utf-8?B?U1BVOW9lVElNSjNpUThkYkhNeWQ1NmhiQkxnL3VJd0Q0SWdRRWJrRkdRZ1Rk?=
 =?utf-8?B?L3hBTUJvbEl1eXhDR25tSE42K0JNWFJsczUxWFp0NTBmLzQ3ak12K1YvU1Zz?=
 =?utf-8?B?aXE5Y2FjcGlBRC9UWU14UTlPQkZueXBFWlJnTEFPalFMWGNwenQzelUvT2RS?=
 =?utf-8?B?dnFwQUNERGJrelBrYUR0ZEt2bWpZTFlzK3NQVCtkanhCNWt2OTNiVElGMXVv?=
 =?utf-8?B?djdtUFVUY0UxcmlKM2xZMXJpc2tUaWpVcjJhM2R2RW1WSVlPVURiRFZudkRo?=
 =?utf-8?B?OGc2Z3FNcFZnZ3dHWkVDcVhnU0hCcjg2aEJxNVExUTg4aFIxc0xxSy92UnFJ?=
 =?utf-8?B?N1lvS2xjZG5yMVRVOHNPaGlwOGJQYlEvN2YvU0huZk9FQzM2V1ZFZEJKLytJ?=
 =?utf-8?B?Y0VWeE1zam84R0xwQ2ZnSjdKT3FvdFRKMmpZT1VzcTA1Vk1NVUFDMEZTVjZ5?=
 =?utf-8?B?eTBVVnNsSy9KdHJlRiszZGNFejBvUi9aV1hOMmRkUlA1S1NRVlQvM1lIN1VU?=
 =?utf-8?B?QzhZVGVFMGJ6UzNuaWpCbjFpOTFMZ1QxRWxtUDhmeVB6Yk5INTN6ckxhbThQ?=
 =?utf-8?B?V3lYSEFuTHV3dTg1em9JQ3ZPbWNodGIzUS82MnN6ajNYT2ZISXJiTTRPdlZB?=
 =?utf-8?Q?LkQIopigIQ5RA53GCHHgPtVTP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e961f2-20f4-4346-29ed-08dc81c5e05e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 23:03:25.2464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 67ieMHkRRrtkvT3Ptb4s8B7HOE6v4D5MGEESYaHZuvwCT68508jSibXZVfiJjP/bxA5UlzA3Qyf8M6gfW0FVxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5225
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFtaHl1bmcgS2ltIDxu
YW1oeXVuZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBGcmlkYXksIE1heSAzMSwgMjAyNCAyOjMwIFBN
DQo+IFRvOiBXYW5nLCBXZWlsaW4gPHdlaWxpbi53YW5nQGludGVsLmNvbT4NCj4gQ2M6IElhbiBS
b2dlcnMgPGlyb2dlcnNAZ29vZ2xlLmNvbT47IEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbw0KPiA8
YWNtZUBrZXJuZWwub3JnPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsg
SW5nbyBNb2xuYXINCj4gPG1pbmdvQHJlZGhhdC5jb20+OyBBbGV4YW5kZXIgU2hpc2hraW4NCj4g
PGFsZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb20+OyBKaXJpIE9sc2EgPGpvbHNhQGtl
cm5lbC5vcmc+OyBIdW50ZXIsDQo+IEFkcmlhbiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBL
YW4gTGlhbmcgPGthbi5saWFuZ0BsaW51eC5pbnRlbC5jb20+Ow0KPiBsaW51eC1wZXJmLXVzZXJz
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgVGF5bG9yLCBQ
ZXJyeQ0KPiA8cGVycnkudGF5bG9yQGludGVsLmNvbT47IEFsdCwgU2FtYW50aGEgPHNhbWFudGhh
LmFsdEBpbnRlbC5jb20+OyBCaWdnZXJzLA0KPiBDYWxlYiA8Y2FsZWIuYmlnZ2Vyc0BpbnRlbC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYxMCAwLzhdIFRQRUJTIGNvdW50aW5nIG1v
ZGUgc3VwcG9ydA0KPiANCj4gT24gRnJpLCBNYXkgMzEsIDIwMjQgYXQgMTI6MDDigK9BTSBXYW5n
LCBXZWlsaW4gPHdlaWxpbi53YW5nQGludGVsLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+
DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogTmFtaHl1bmcg
S2ltIDxuYW1oeXVuZ0BrZXJuZWwub3JnPg0KPiA+ID4gU2VudDogVGh1cnNkYXksIE1heSAzMCwg
MjAyNCAxMTozNyBQTQ0KPiA+ID4gVG86IFdhbmcsIFdlaWxpbiA8d2VpbGluLndhbmdAaW50ZWwu
Y29tPg0KPiA+ID4gQ2M6IElhbiBSb2dlcnMgPGlyb2dlcnNAZ29vZ2xlLmNvbT47IEFybmFsZG8g
Q2FydmFsaG8gZGUgTWVsbw0KPiA+ID4gPGFjbWVAa2VybmVsLm9yZz47IFBldGVyIFppamxzdHJh
IDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IEluZ28gTW9sbmFyDQo+ID4gPiA8bWluZ29AcmVkaGF0
LmNvbT47IEFsZXhhbmRlciBTaGlzaGtpbg0KPiA+ID4gPGFsZXhhbmRlci5zaGlzaGtpbkBsaW51
eC5pbnRlbC5jb20+OyBKaXJpIE9sc2EgPGpvbHNhQGtlcm5lbC5vcmc+OyBIdW50ZXIsDQo+ID4g
PiBBZHJpYW4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgS2FuIExpYW5nIDxrYW4ubGlhbmdA
bGludXguaW50ZWwuY29tPjsNCj4gPiA+IGxpbnV4LXBlcmYtdXNlcnNAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBUYXlsb3IsDQo+IFBlcnJ5DQo+ID4gPiA8
cGVycnkudGF5bG9yQGludGVsLmNvbT47IEFsdCwgU2FtYW50aGEgPHNhbWFudGhhLmFsdEBpbnRl
bC5jb20+Ow0KPiBCaWdnZXJzLA0KPiA+ID4gQ2FsZWIgPGNhbGViLmJpZ2dlcnNAaW50ZWwuY29t
Pg0KPiA+ID4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjEwIDAvOF0gVFBFQlMgY291bnRpbmcg
bW9kZSBzdXBwb3J0DQo+ID4gPg0KPiA+ID4gSGVsbG8sDQo+ID4gPg0KPiA+ID4gT24gVHVlLCBN
YXkgMjgsIDIwMjQgYXQgMTE6NDPigK9QTSA8d2VpbGluLndhbmdAaW50ZWwuY29tPiB3cm90ZToN
Cj4gPiA+ID4NCj4gPiA+ID4gRnJvbTogV2VpbGluIFdhbmcgPHdlaWxpbi53YW5nQGludGVsLmNv
bT4NCj4gPiA+ID4NCj4gPiA+ID4gSSBoYXZlIHRyaWVkIG5vdCB0byBjb3VudCByZXRpcmVfbGF0
ZW5jeSBldmVudHMgYnV0IGRpZCBub3Qgc3VjY2VlZC4NCj4gPiA+ID4gSW4gcGFydGljdWxhciwg
SSB0cmllZCB0aGUgZm9sbG93aW5nIG1ldGhvZHM6DQo+ID4gPiA+ICAtIENvbnZlcnQgcmV0aXJl
X2xhdGVuY3kgZXZlbnQgdG8gZHVtbXkgZXZlbnQgaW4gZXZlbnQgcGFyc2VyLg0KPiA+ID4gPiAg
LSBFYXJseSBiYWlsIG91dCBpbiBldnNlbF9fb3Blbl9jcHUoKSBhbmQgc3RvcmVfZXZzZWxfaWRz
KCkuDQo+ID4gPiA+DQo+ID4gPiA+IFRoZSBmaXJzdCBtZXRob2QgZmFpbHMgYW5kIGNhdXNlcyBu
b24tcmV0aXJlX2xhdGVuY3kgZXZlbnRzIHdpdGggdGhlIHNhbWUNCj4gPiA+IGV2ZW50DQo+ID4g
PiA+IG5hbWUgcmV0dXJuIDAgY291bnQuDQo+ID4gPiA+DQo+ID4gPiA+IFRoZSBzZWNvbmQgbWV0
aG9kIGZhaWxzIGFuZCBjYXVzZXMgYWxsIHRoZSBldmVudHMgaW4gdGhlIHNhbWUgZ3JvdXANCj4g
PiA+IHJldHVybmluZw0KPiA+ID4gPiAiPG5vdCBjb3VudGVkPiIgcmVzdWx0cy4NCj4gPiA+DQo+
ID4gPiBDYW4geW91IHBsZWFzZSBkZXNjcmliZSB3aGVyZSBpdCBmYWlscz8gIElzIGl0IGZhaWxp
bmcgb24gb3RoZXIgZXZlbnRzDQo+ID4gPiBiZWNhdXNlIHRoZSB0cGVicyBldmVudCBpcyBhIGxl
YWRlciBvZiB0aGUgZ3JvdXA/ICBJIHRoaW5rIHlvdSB3YW50ZWQNCj4gPiA+IHRvIGF2b2lkIGhh
dmluZyBpdCBpbiB0aGUgbGVhZGVyIHBvc2l0aW9uLiAgSWYgd2UgY2FuIHNraXAgYW55IGFjdHVh
bA0KPiA+ID4gb3BlcmF0aW9ucyAob3Blbi9jbG9zZS9lbmFibGUvZGlzYWJsZS9yZWFkKSBmb3Ig
dGhlIHRwZWJzIGV2ZW50cywgdGhlbg0KPiA+ID4gaXQgY291bGQgYmUgZmluZS4uDQo+ID4NCj4g
PiBJdCBkb2VzIG5vdCBmYWlsIHdpdGggdGhlIGNvZGUgaW4gdGhpcyBwYXRjaCBzZXQuIEJ1dCBp
ZiBJIG1ha2UgaXQgcmV0dXJuIGRpcmVjdGx5DQo+ID4gZnJvbSB0cGVic19zdGFydCgpIGluIGV2
c2VsX19vcGVuX2NwdSgpLCBpdCB3aWxsIGNhdXNlIHNlZ2ZhdWx0LiBUaGUgc2VnZmF1bHQgaXMN
Cj4gPiBjYXVzZWQgYnkgc3RvcmVfZXZzZWxfaWQoKS4gSSBjb3VsZCBhZGQgYW5vdGhlciBlYXJs
eSByZXR1cm4gZnJvbQ0KPiBzdG9yZV9ldnNlbF9pZCgpDQo+ID4gaWYgdGhlIGV2c2VsLT5yZXRp
cmVfbGF0IGlzIHRydWUuDQo+IA0KPiBZZWFoLCBJIHRoaW5rIGV2ZW50OlIgc2hvdWxkIG5vdCBn
byB0byBrZXJuZWwgZnJvbSBwZXJmIHN0YXQgYW5kIHlvdSBuZWVkIHRvDQo+IGhhbmRsZSB0aGF0
IGluIHRoZSB0b29scy4NCj4gDQo+ID4NCj4gPiBBZnRlciB0aGlzIGNoYW5nZSwgaXQgd2lsbCBl
dmVudHVhbGx5IHJ1biBhbmQgZ2l2ZSBtZSA8bm90IGNvdW50ZWQ+IHJlc3VsdHMNCj4gPiBsaWtl
IGJlbG93Og0KPiA+DQo+ID4gICAgICAgICA8bm90IGNvdW50ZWQ+IGV2ZW50MQ0KPiA+ICAgICAg
ICAgPG5vdCBjb3VudGVkPiBldmVudDINCj4gPiAgICAgICAgIHh4IGV2ZW50MTpSDQo+ID4NCj4g
PiBJbiBhIGRpZmZlcmVudCBjYXNlLCBpdCBtYXkgc2VlbSB0byB3b3JrICh4eHh4eHggc3RhbmRz
IGZvciBzb21lIHZhbGlkIHZhbHVlKToNCj4gPg0KPiA+ICAgICAgICAgeHh4eHh4eCBldmVudDEN
Cj4gPiAgICAgICAgIHh4eHh4eHggZXZlbnQyDQo+ID4gICAgICAgICB4eHh4eHh4IGV2ZW50Mw0K
PiA+ICAgICAgICAgeHggZXZlbnQxOlINCj4gPg0KPiA+IEluIHRoZSBmaXJzdCBjYXNlLCB0aGUg
ZXZlbnQxLCBldmVudDIgYW5kIGV2ZW50MTpSIGFyZSBzY2hlZHVsZWQgaW4gdGhlIHNhbWUNCj4g
PiBncm91cC4gT24gdGhlIG90aGVyIGhhbmQsIGluIHRoZSBzZWNvbmQgY2FzZSwgZXZlbnQxLCBl
dmVudDIgYW5kIGV2ZW50Mw0KPiBhcmUNCj4gPiBpbiBvbmUgZ3JvdXAsIHdoaWxlIGV2ZW50MTpS
IGlzIGluIGEgZGlmZmVyZW50IGdyb3VwLg0KPiANCj4gSWYgeW91IGRvbid0IG9wZW4gZXZlbnQx
OlIgdGhlbiB0aGUga2VybmVsIG9ubHkgc2VlcyBldmVudDEgYW5kIGV2ZW50Mi4NCj4gDQo+ID4N
Cj4gPiBCYXNlZCBvbiB0aGVzZSB0d28gZGlmZmVyZW50IHR5cGUgb2YgcmVzdWx0cywgSSBiZWxp
ZXZlIHRoZSBmYWlsdXJlIGhhcHBlbnMgaW4NCj4gPiB0aGUgZ3JvdXAgdGhhdCBpbmNsdWRlIGEg
OlIgZXZlbnQuIEkndmUgYWRkZWQgdGhlIGNoYW5nZSB0bw0KPiBhcmNoX2V2bGlzdF9fY21wKCkN
Cj4gPiBzbyB0aGF0IGEgOlIgZXZlbnQgd291bGQgbm90IGJlIGEgbGVhZGVyIG9mIHRoZSBncm91
cC4NCj4gPg0KPiA+IEkgdGhpbmsgSSd2ZSBtYWRlIGV2c2VsX19vcGVuX2NwdSgpIHJldHVybiBi
ZWZvcmUgaXQgY3JlYXRlIGZkIGFuZCBtYWtlDQo+ID4gc3RvcmVfZXZzZWxfaWQoKSBub3QgdG8g
cmVhZCBhbmQgc3RvcmUgZmQuIEknbSBub3Qgc3VyZSB3aGVyZSBJJ20gbWlzc2luZy4NCj4gUGxl
YXNlDQo+ID4gbGV0IG1lIGtub3cgaWYgeW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zLg0KPiANCj4g
QXMgSSBzYWlkLCBwbGVhc2UgZG9uJ3Qgb3BlbiBldmVudDE6UiAoZm9yIHBlcmYgc3RhdCkgYW5k
IGxldCB0cGVic19zdG9wKCkgc2V0DQo+IHRoZSB2YWx1ZSB1c2luZyB0aGUgZGF0YSBmcm9tIHBl
cmYgcmVjb3JkIGluIGJhY2tncm91bmQuDQoNCkkgdGhpbmsgdGhpcyBpcyBleGFjdGx5IHdoYXQg
SSdtIHRyeWluZyB0byBhY2hpZXZlLCBub3Qgb3BlbiBldmVudDE6UiBmb3IgcGVyZiBzdGF0LiAN
ClRoZSBwcm9ibGVtIGlzIHRoYXQgSSdtIG5vdCBzdXJlIGhvdyB0byBkbyBpdCBwcm9wZXJseSBp
biB0aGUgY29kZS4gUGxlYXNlIGdpdmUgDQptZSBzb21lIHN1Z2dlc3Rpb24gaGVyZS4gDQoNClRo
YW5rcywNCldlaWxpbg0KDQo+IA0KPiBUaGFua3MsDQo+IE5hbWh5dW5nDQo=
