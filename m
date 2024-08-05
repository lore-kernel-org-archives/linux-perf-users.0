Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D9513C809;
	Mon,  5 Aug 2024 20:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722889611; cv=fail; b=TJoewNK0Nz+xhMUMi4qRPAAmKM5wZrq52K5xljLuaGNfhYByYnEtZmoepgJ6IoTC87NunG5MgUJniDcg34zbCdnpGpQI2an1QPyPEdVmnhqDzohGX0i8GQn6jE/plkodbGuNDn58Wc8j53zWAaDRs5NoFzfMJIe+H4jm611RJjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722889611; c=relaxed/simple;
	bh=bv55xLwLpz1d8xyUNtu9IrLOCccm8FpjxvJB6Tn9LT4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F1aoWIAzwkHB7NlrM4pCd/2CJLR7bhz79cRAlUu7zWNjkyIxAi9O1ms/h5JKmW55hMPbY39s9GFiJi8o6vIP5o79Kjv45Dwi5tYh6PW8lhtAG3qWDtuadIpTGVO/p1iySpYa/cWZyC9+3mrIeLgmIkMTnrkPPEnQzETMNmLVZ+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WRkOQ43q; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WRkOQ43q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722889610; x=1754425610;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bv55xLwLpz1d8xyUNtu9IrLOCccm8FpjxvJB6Tn9LT4=;
  b=WRkOQ43quupw+tmyvnfh7n/kAdGMAPE2oRLgSQc6+0kdzAK20JfPz2bV
   slMWs1wMioNw9TQXzc0m21aM68TfLNgWZg26aH4I7bvLra5rh4bRY89Vx
   urAbly9zHMTIh4/DyZju/IQadgC9td1UygL3/517k44amavF9liz1aEvK
   SGFaO4dvAw5VqXamcC/sTa76CUyI43clrhIaI7fNdT4j/9dufZyOCT48x
   6+pkRU6hJwK2DRjKq9LC3vVAWt355gs6pI4PuB4j74K7v/J30+I5DZs6U
   kq/xLMJH0kxIACvUSuGJaycDZ546ETJ1Yiq5qWASU/4NOSpDl7aQkg/HT
   A==;
X-CSE-ConnectionGUID: W1RNaA4kTyK2QGlnoePM6w==
X-CSE-MsgGUID: eGAVQgymTb+yEsvH123/9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="31539629"
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="31539629"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 13:26:50 -0700
X-CSE-ConnectionGUID: GGqezxDyS0SoHj6lNih+6Q==
X-CSE-MsgGUID: x7xy69HhSpGWWdm+KSzneg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="61238945"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Aug 2024 13:26:50 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 13:26:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 5 Aug 2024 13:26:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 13:26:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROxi5FzfMc5rJds5RorQYY8nyJDHKF/9uDK4v5WtBFvvT1f/J8TR854ZaQ6mfiy1N00D5KETxevQN6Lj9K9yKtRy/ijD+16Ck3uOLVwq2/R5VnjVymHG/wNURx1X3vr1MW0vTDwcKBlUu61BnqioqxOl6jeW5ucrUi4UtE/vC5SFIaYI8Jg56RIOpCENDS4sVY+xfdA4cyIzqY8SQ+EH0xUrRQLhlKFnaWAU5d6Xm9VZJfo4ic/8TTQpmNFNcrOEe5CHZtAqyaq2VinSmm+nm5iLMEDfNzfUH35k1JJ3biWvhsliJfngJKMy/P64iC1/Gx/trwk5WrDU0K4yMe4tfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bv55xLwLpz1d8xyUNtu9IrLOCccm8FpjxvJB6Tn9LT4=;
 b=QGFiQ8O/XBspdfudqgnfYuEa5oEYs9NkPyq4PlgxntiSYHH3EdcRBwPxZX4mFQFW/aqELKkVaPd33gLwq2eq/ejX5a2n+cZJoOQVO6kNoLFuuoIz/v98V1P7Nyjn9xXjqbS9HCFHifbdk1kHt/iwkFoAxrPbD9tcOBi2gqsIU9m8bdKnw683aRwWlAEVNBCLndJmqDIjJqszJZ/VHTH1AwdtqBOiTP3WuS/mVMYfev2wlELOuCfgz+jrcClinwTH9SaRRPwTXkoyZhl+qQTUcxzoENaq2cijqc5fqvPjD9UZrYtEOLot5dhvibFQqABNCB2lr0M8UmJ6FmHTLzJVXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by IA0PR11MB7305.namprd11.prod.outlook.com (2603:10b6:208:439::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Mon, 5 Aug
 2024 20:26:45 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 20:26:45 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Song Liu <song@kernel.org>, "Liang, Kan" <kan.liang@linux.intel.com>, "Ian
 Rogers" <irogers@google.com>
CC: "Taylor, Perry" <perry.taylor@intel.com>, "Baker, Edward"
	<edward.baker@intel.com>, "Daneti, Venkata Naga Sai Dilip"
	<venkata.naga.sai.dilip.daneti@intel.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "open
 list" <linux-kernel@vger.kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, "jonesz@meta.com" <jonesz@meta.com>
Subject: RE: Some unc_cha_tor_* events appear to be "not supported"?
Thread-Topic: Some unc_cha_tor_* events appear to be "not supported"?
Thread-Index: AQHa3rRBYvlGDnS4q0yQwR0fDD3VnbIHscXwgAzc24CABHmq0IAAEcSAgAASW6A=
Date: Mon, 5 Aug 2024 20:26:45 +0000
Message-ID: <CO6PR11MB5635775FADE3BBECD551A7A6EEBE2@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <CAPhsuW4nem9XZP+b=sJJ7kqXG-cafz0djZf51HsgjCiwkGBA+A@mail.gmail.com>
 <26fb7054-f877-496f-b23a-9b6a3d752595@linux.intel.com>
 <CAPhsuW6+7ULMQFLbmOsBzYAdd8LMV54h_ynfkGDxd_oH6O8cww@mail.gmail.com>
 <CAP-5=fVNfGT+a1RG9-ugKWjQR-83vLdHo-6vCVz=N=CBF4_7ug@mail.gmail.com>
 <CO6PR11MB5635E5844F7C8CB1277C1DF4EEAB2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAPhsuW6Hq4qno1=K9-q17TsNO7S4-dQMCfo_nAQZ7EMdcuP6NQ@mail.gmail.com>
 <CO6PR11MB563550B4AB0D89D6DAC39CBAEEBE2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAPhsuW76F2PkpSpB+V039_0orX9aRwj=++XzM7k1omGVZY-uEw@mail.gmail.com>
In-Reply-To: <CAPhsuW76F2PkpSpB+V039_0orX9aRwj=++XzM7k1omGVZY-uEw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: kan.liang@linux.intel.com,irogers@google.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|IA0PR11MB7305:EE_
x-ms-office365-filtering-correlation-id: 52286024-f99d-435c-a6fd-08dcb58ced14
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WlRwczRMY0tUR3A3VG5Ed095czJjMVB0UEVTTDNjamVIc0dLK1c0QkV2ZTFm?=
 =?utf-8?B?QTJDWE5qWjg5SmUrUHd3a2NOOGN1dVM0ejVFQVMyVUJXZjRuYmtjTkN6eTA0?=
 =?utf-8?B?NkFKZ25GWUdpaWdici9mZWpwbnczSTI3WUdKcjhTNTFBb0pOY2J3b2x3Vklo?=
 =?utf-8?B?MVBId2d5dFRlbXZwRlhoNWtRbzBOeVIvSWxZTHJYQWJrT1RUdkJSOTZVQUwy?=
 =?utf-8?B?WjE3T2VXY0gxdnljT2xVMjQ5Z0VpY3FQc0JKRnZzdHh3V3lRblNGQ3NOMzhu?=
 =?utf-8?B?dTdJWkRHZld6R3JjbVZoeTVDYlFLYkFDUjJmNkVZK0pBZ0dFRCtkNHJzT0hQ?=
 =?utf-8?B?SURFdkZoRTRkRWZtM2J4SVpGajZiVzhKZkRYZW5odjlzakdOaU1FQVpFK3pk?=
 =?utf-8?B?U1RUbWpFOFk5MlhiRTdWMDk5cUd1WTZUaUdkYmFjNjJvdmpKVkEzL3NJanhi?=
 =?utf-8?B?SWYyRUIwcEg0SzczcWgzR2l3UDN5NVowTi9lMUNyUUhxZjJJRXhybUpibDBK?=
 =?utf-8?B?NmtWWlBmbEZaNk9TNmdxQ0RSZU15RzY4WldSV1owWHhjT0JEZFRBQzBRTktl?=
 =?utf-8?B?K2VWWGZGeEUvV2U5bGpBbHV6ancvc1o4REtva0h2akxnRGpnRWRTaWowSzJG?=
 =?utf-8?B?RFZqSGN5aDZhbnFpelhwMjIzRGJnUi8wd1N0ei9EVzNKM3h3WGZSMnY1aCtX?=
 =?utf-8?B?dFhhRmcydW5SckVFdTNOZ2V4MXJ0VnRXWjVQZmdRc0pHQytoQkVuSWdqZThU?=
 =?utf-8?B?YmdiYS95RS9Lc1dyNXV0OENYLzdjWk9CM3pCL1lYMVExWmR2azNyNmNJcXdp?=
 =?utf-8?B?d0VEcFQrWWdzRkYwelA0b1d3Y3pISWZkTytBd2JWWkNJNjk2Y1psV3Z1MFc4?=
 =?utf-8?B?SVNrYjZkS1dxS1NTd29DdlF5d0ltSFZqdlJJYXVCdm5xWXVhbmtSUjVFQVhy?=
 =?utf-8?B?U0NjY1lyUHMzVGN1K3RUK09wcDFDV3hLWjJnWng2cjZjaGdDQWNGWk1GMkND?=
 =?utf-8?B?ZHBzUU5teFlTRmxxQVFZUXNaNFNiVlcrMkxWbWM5VzZldUJGQktCTHpJUnBi?=
 =?utf-8?B?MmhBZnphTiswNnF3YWFwMWpWRlJVVWR4YVpnUEdHTmtNRzdFWllXS2lIRTgv?=
 =?utf-8?B?TE41TldUM0JlWUU5a0hseGlLZld2WXpCdWpjNytycUJiRHpEVGVVcWxiLzNx?=
 =?utf-8?B?U0o3Q0l1RHBhak1FQVNMUEZvTUxjd0Q4TGlFMlpJWGRYekNUR2hTczRFbFZ3?=
 =?utf-8?B?bnJlZkdNQnlsOERiZ25lam5NZERiYkpiYjcvUlgzaUE1eUZjbi85YW9zWmhP?=
 =?utf-8?B?b0MybkpVVmxQUjhJYnZETTQ0UXl1aStCZUprQkxkTHJqN256SHFTSTNNcVIr?=
 =?utf-8?B?Y1k3MzVnMk16Y1pSU0FWTDdtTnNiRGZrV05Ic0E2bHJBc3RPN01DTWRNcVE0?=
 =?utf-8?B?enh5ZWNQQ1djSFNLSjhGMUxlSVlLaGljRnJ3MXBhMUdhSXdvQlZVd215R1NU?=
 =?utf-8?B?djZoOXpzNHhKRTd1OUhqU3NSNFZjRTBuY0lMcWJ3Y0laYlFiaEZqM3VmYldG?=
 =?utf-8?B?RUk0dkw2TnplNnZsQnJncjczTEIrN3p1eTQ3RzVwTVU0RTBXaS80N3dUY2gw?=
 =?utf-8?B?T2luYlZoSWxldEQ1Myt3R0oyRUdZK1ZNRlJQaHBrN25lRTJ0aGZObEZCNFBU?=
 =?utf-8?B?SzM1VmU0TUdZNWpyWTU3bllTOU9GMWRDTEJaOXFISENvWXVYNlRkKy82bXFQ?=
 =?utf-8?B?a1NkVlAreFNDbHF4K0EyZFpvMi9mbUUzSk9JamVMM0ZqTWNqeGtvR1NkaS9P?=
 =?utf-8?Q?orZQwy0jP4EuIpO6Pf2F6dVDUYDz3Dn2b47c4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDZ6OUlTVXBoYnpBR1FlTnRPY0QzM0drMEtGaTNNSW5paW5zQWhObk02Vk10?=
 =?utf-8?B?aittSlZGKy9Ca2lWUXhOV2NZMVIwWGhHN0pYRjViYld3d1hTN29EQTZlU2tT?=
 =?utf-8?B?ZVo3M0EvQUJKNkIwSFAxYkYxSGpHd3BlcHRQM1ordE5PUWxNdlFkVWVJUHR2?=
 =?utf-8?B?OVgvVWRYLzJTNGxlV3JVdjBLOE1LY0FrUGlMdWxWS2kvTmZ6QXRUaHFPNTdP?=
 =?utf-8?B?Vjd1NWVHT2FPRzUyekhnaXF3SHF1bFZZR1dmRXBpbktISlNMSHAxZS9BM1NJ?=
 =?utf-8?B?Z2pKZEFVNXg0cUFvaHpQdS91N3BVb2VQVEZNaFNMUE1oT1hNcmdMWWF2T0Jp?=
 =?utf-8?B?YXVrRlgwMExydmhVOUZ0QStVczY0aUI3eHJlcWtiQmcvSS92a2lFWVBibUdM?=
 =?utf-8?B?MW9PYURnMVNlTHM5b1NPdk9GczZpS2pLbEZpbktaWTUzOUFaTU9TUFNOTkJD?=
 =?utf-8?B?UjdvZm5RRFluNm5vN1podExWblVsSVlZWGliWXV4UXBYc3RvVFNncWYxUmRT?=
 =?utf-8?B?VDFTZ2lVY1dvbmdrM3FQTXRRQlp3QTdzbEREbmRKbTR0bXY3Vzl5UHpadWxx?=
 =?utf-8?B?MGIyNGhmK1dYdW8rNnNJdnBGNnFLRk9ZZk5EZ3prKzVRTnJNalBUUWRldytM?=
 =?utf-8?B?cW9UNk9nMUZDc3l5cmhnRXJlb3F1U1l5VVIyM0JVcFh2WjNVemtVbUNXTmZr?=
 =?utf-8?B?TDRIdmpocTUwNlBnbjdrdnFzY3krVHQ5K0VvY0tEUzYwOG5aUHE1WW1PcFdt?=
 =?utf-8?B?ZnJXdFhHVjRBTUpTQ2xLZk91WkFHRE9mbnBkc3dhaEZ6ZkE1bmVhVHJKR3FQ?=
 =?utf-8?B?MTQ1N2RkUkR0K3dkWmc2YU1zOFhVdXdEemR0K0t1RkJ0WDNYS0hMMTJqblRL?=
 =?utf-8?B?ejEwOGdYMlNrUVgwNDJzazJEK1JGWUdudVl5QWk5Qm1SLytaWjM3OG9vZXpJ?=
 =?utf-8?B?bjVvaVZZalNoSXArQjA1S3NicWlwY0swbVpCalZjR3Btcy9BWmxqZXJPU2VG?=
 =?utf-8?B?Um1jdnZ0UVlVak5VMG9LT3RlZmxOa2syblUrWDRmQmE3aGpxOGdycjg5ZjVk?=
 =?utf-8?B?WCtNazBoTUhTUVd4ekpiN1lFZnI0dzk4cHFIcngyKzdzcGlNUjRqbVhPZ3hl?=
 =?utf-8?B?L1piSFYrZnZaWXJpYnFCZy9BVXMxVmZJWU9XQit6aHVzRzd3QVJ5NlRrZklN?=
 =?utf-8?B?N1o0VmZHSEhpYmVWb045WWtoMUVLYzJ3NHhHdFhsRys0dzNSbWErY3ljdTJj?=
 =?utf-8?B?Vlp5SVU4V0xNbGhwZWM3cnJwSHIzd0NHVTF1VkZsRjlQY1ljM1Uxajl4MXBr?=
 =?utf-8?B?RUZvelJsUVg5a3c0d1lnVk5PVFNkdFhMUHRNRllyQ3UzNlQ2YVQxS2tTWnBt?=
 =?utf-8?B?ZVRiZEgweUJPSjg0N2lwVVpOZi9vZjQwaTNVNk05LzFtS2h4SU1pR0V3bis3?=
 =?utf-8?B?alR5bVVnM0tzdUk5b2x1MDRmRGlnMkhsSlZhUkJwZEgzamJQVEVWVmRFT0Y1?=
 =?utf-8?B?eHJ1NDB0T1ZYK1dlRlFVSzZDZDVjRmhtOGRyTnA2Qm16REtCdXZRN2pOYUhO?=
 =?utf-8?B?MUM4K0VFcHg3TWxTUC91amhlMmZQUVQybTdkc3A2V0N5NklhOFhFZlQrOUJB?=
 =?utf-8?B?WjY5dW9OVDYzOWRJSGRueWlQaGZPUlZaSFlNWm5yT281NUtqL3F0Z210d1hx?=
 =?utf-8?B?aUZCV1VmVTVhTWg1NVU4eWFpMGtFMklPRFVQbDJrWjI4Q1lOUW8vTHZya3Uz?=
 =?utf-8?B?eERiRkNhWXBsY2lpZVBtbkFSM29XQ2cxWUdkYmlHVHhZUDlzSDVRV1JKL1pr?=
 =?utf-8?B?eVNHWldyM2M0RWdZN1BueWp5NlQyTkZqenU5T0NVbUhna3VJSXllUGRQVnFS?=
 =?utf-8?B?MFVUVWNxT25pcUNla1o0bUUxZ1pNeDlLem1yT1dPVFlIZ2xlNytxcVZCblRV?=
 =?utf-8?B?UHllK0M5YmVOZEZ2KzJ3Q2drUjhIdGw1Q2JFTCtyaFU2YjFnVVdPak1TU2th?=
 =?utf-8?B?Q3FLYWVZVStYa0VOZFppVXhEQzZSVDVvSWsvbFIvMkhrc2JPTlBlbmp4UXhL?=
 =?utf-8?B?N3BVRlNlcDg2YmN1NlEwWTNSa2I4d1UvK0crdC90NzZ5VzZIcTlmNUdlQy9u?=
 =?utf-8?Q?tYgFDBR2jGQWBoxkP8iVlSIQZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 52286024-f99d-435c-a6fd-08dcb58ced14
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 20:26:45.7032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R8LdOslq0Fpx8wF366SDyZFrjmlCHmdN6UOWoGsFS+v0kNQXFCIqEzjupV4OpPGs5PJFP7cElLwNQj1JWrH/Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7305
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU29uZyBMaXUgPHNvbmdA
a2VybmVsLm9yZz4NCj4gU2VudDogTW9uZGF5LCBBdWd1c3QgNSwgMjAyNCAxMjoxNSBQTQ0KPiBU
bzogV2FuZywgV2VpbGluIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+DQo+IENjOiBMaWFuZywgS2Fu
IDxrYW4ubGlhbmdAbGludXguaW50ZWwuY29tPjsgSWFuIFJvZ2VycyA8aXJvZ2Vyc0Bnb29nbGUu
Y29tPjsNCj4gVGF5bG9yLCBQZXJyeSA8cGVycnkudGF5bG9yQGludGVsLmNvbT47IEJha2VyLCBF
ZHdhcmQNCj4gPGVkd2FyZC5iYWtlckBpbnRlbC5jb20+OyBEYW5ldGksIFZlbmthdGEgTmFnYSBT
YWkgRGlsaXANCj4gPHZlbmthdGEubmFnYS5zYWkuZGlsaXAuZGFuZXRpQGludGVsLmNvbT47IEFy
bmFsZG8gQ2FydmFsaG8gZGUgTWVsbw0KPiA8YWNtZUBrZXJuZWwub3JnPjsgSHVudGVyLCBBZHJp
YW4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgbGludXgtcGVyZi0NCj4gdXNlcnNAdmdlci5r
ZXJuZWwub3JnOyBvcGVuIGxpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBOYW1o
eXVuZw0KPiBLaW0gPG5hbWh5dW5nQGtlcm5lbC5vcmc+OyBKaXJpIE9sc2EgPGpvbHNhQGtlcm5l
bC5vcmc+OyBqb25lc3pAbWV0YS5jb20NCj4gU3ViamVjdDogUmU6IFNvbWUgdW5jX2NoYV90b3Jf
KiBldmVudHMgYXBwZWFyIHRvIGJlICJub3Qgc3VwcG9ydGVkIj8NCj4gDQo+IEhpIFdlaWxpbiwN
Cj4gDQo+IE9uIE1vbiwgQXVnIDUsIDIwMjQgYXQgMTE6MzTigK9BTSBXYW5nLCBXZWlsaW4gPHdl
aWxpbi53YW5nQGludGVsLmNvbT4NCj4gd3JvdGU6DQo+IFsuLi5dDQo+ID4gPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiA+IFRoZSB2YWx1ZSAnNGI0MzMnIGlzIGZvciB0aGUgJ0ZpbHRlcjEnLCBhY2Nv
cmRpbmcgdG8gdGhlIG9yaWdpbmFsIGV2ZW50DQo+ID4gPiA+ID4gPiA+IGxpc3QuDQo+ID4gPiA+
ID4gPiA+DQo+ID4gPiA+ID4gPiA+DQo+ID4NCj4gPiBAU29uZyBMaXUsIGRvIHlvdSBzZWUgZGlm
ZmVyZW50IG91dHB1dCBmcm9tIHNvbWUgb3RoZXINCj4gdW5jX2NoYV90b3Jfb2NjdXBhbmN5DQo+
ID4gYW5kIHVuY19jaGFfdG9yX2luc2VydHMgZXZlbnRzLiBPciwgYXJlIGFsbCBvZiB0aGVtIHJl
cG9ydCB0aGUgc2FtZSB3YXJuaW5nDQo+IGxpa2UgdGhpcw0KPiA+IGV4YW1wbGUgaGVyZT8NCj4g
Pg0KPiA+IENvdWxkIHlvdSBwbGVhc2UgdHJ5IFVOQ19DSEFfVE9SX09DQ1VQQU5DWS5JQV9NSVNT
IGFuZCBzaGFyZSB0aGUNCj4gb3V0cHV0Pw0KPiA+IFBsZWFzZSBhbHNvIHNwZWNpZnkgdGhlIHBs
YXRmb3JtIHlvdSB0ZXN0ZWQgb24uIFRoYW5rcyENCj4gDQo+IFRoaXMgZXZlbnQgaXMgd29ya2lu
ZywgSSBndWVzcy4gVGhvdWdoIHRoZSBvdXRwdXQgaXMgemVybyBvbiB0aGUgaG9zdC4NCj4gDQo+
IFtyb290QCB+XSMgcGVyZiBzdGF0IC1lICBVTkNfQ0hBX1RPUl9PQ0NVUEFOQ1kuSUFfTUlTUyAt
YSAtLSBzbGVlcCAxDQo+IA0KPiAgUGVyZm9ybWFuY2UgY291bnRlciBzdGF0cyBmb3IgJ3N5c3Rl
bSB3aWRlJzoNCj4gDQo+ICAgICAgICAgICAgICAgICAgMCAgICAgIFVOQ19DSEFfVE9SX09DQ1VQ
QU5DWS5JQV9NSVNTDQo+IA0KPiAgICAgICAgMS4wMDI0OTcxMjYgc2Vjb25kcyB0aW1lIGVsYXBz
ZWQNCj4gDQo+IEZvciB0aGlzIG9uZSwgSSBhbSB0ZXN0aW5nIG9uIEludGVsKFIpIFhlb24oUikg
RC0yMTkxQSBDUFUgQCAxLjYwR0h6Lg0KPiBJIHRoaW5rIHRoZSBpc3N1ZSBoYXBwZW5zIG9uIGFs
bCBza3lsYWtlIGFuZCBjb3BwZXJsYWtlIENQVXMuDQoNClRoaXMgbG9va3MgY29ycmVjdC4gSSB0
aGlua3Mgc29tZSBvZiB0aGlzIHR5cGUgb2YgZXZlbnRzIGFyZSBzdXBwb3NlZCB0byBiZSBhbHdh
eXMgDQpyZXR1cm4gMC4gDQoNCj4gDQo+ID4NCj4gPiA+ID4gPg0KPiA+ID4NCj4gaHR0cHM6Ly9n
aXRodWIuY29tL2ludGVsL3BlcmZtb24vYmxvYi9tYWluL1NLWC9ldmVudHMvc2t5bGFrZXhfdW5j
b3JlLmpzDQo+ID4gPiA+ID4gb24jTDQ2MzQNCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4g
ICAgICAgIkV2ZW50TmFtZSI6DQo+ICJVTkNfQ0hBX1RPUl9PQ0NVUEFOQ1kuSUFfTUlTU19MbGNQ
cmVmRFJEIiwNCj4gPiA+ID4gPiA+ID4gICAgICAgIkJyaWVmRGVzY3JpcHRpb24iOg0KPiA+ID4g
PiA+ICJVTkNfQ0hBX1RPUl9PQ0NVUEFOQ1kuSUFfTUlTU19MbGNQcmVmRFJEIiwNCj4gPiA+ID4g
PiA+ID4gICAgICAgIlB1YmxpY0Rlc2NyaXB0aW9uIjoNCj4gPiA+ID4gPiAiVU5DX0NIQV9UT1Jf
T0NDVVBBTkNZLklBX01JU1NfTGxjUHJlZkRSRCIsDQo+ID4gPiA+ID4gPiA+ICAgICAgICJDb3Vu
dGVyIjogIjAiLA0KPiA+ID4gPiA+ID4gPiAgICAgICAiTVNSVmFsdWUiOiAiMHgwMCIsDQo+ID4g
PiA+ID4gPiA+ICAgICAgICJFTExDIjogIjAiLA0KPiA+ID4gPiA+ID4gPiAgICAgICAiRmlsdGVy
IjogIkZpbHRlcjEiLA0KPiA+ID4gPiA+ID4gPiAgICAgICAiRXh0U2VsIjogIjAiLA0KPiA+ID4g
PiA+ID4gPiAgICAgICAiRGVwcmVjYXRlZCI6ICIwIiwNCj4gPiA+ID4gPiA+ID4gICAgICAgIkZJ
TFRFUl9WQUxVRSI6ICIweDRiNDMzIg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBUaGVy
ZSBhcmUgdHdvIGZpbHRlcnMgZm9yIENIQSBvbiBTS1guIEVhY2ggZmlsdGVyIGlzIDMyIGJpdHMg
d2lkZS4NCj4gPiA+ID4gPiA+ID4gU28gdGhlIExpbnV4IGtlcm5lbCBkcml2ZXIgdXNlcyBjb25m
aWcxICg2NCBiaXRzIHdpZGUpIHRvIHJlcHJlc2VudA0KPiBib3RoDQo+ID4gPiA+ID4gPiA+IG9m
IHRoZW0uIFRoZSBsb3cgMzIgYml0cyBhcmUgZm9yIGZpbHRlcjAgYW5kIGhpZ2ggMzIgYml0cyBh
cmUgZm9yDQo+IGZpbHRlcjEuDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IEl0IHNob3Vs
ZCBiZSBhbiBpc3N1ZSBvZiB0aGUgY29udmVydCBzY3JpcHQsIHdoaWNoIHNldCB0aGUgZmlsdGVy
MSB2YWx1ZQ0KPiA+ID4gPiA+ID4gPiB0byB0aGUgbG93IDMyIGJpdHMuDQo+ID4NCj4gPiBATGlh
bmcsIEthbiwgdGhlIGZvbGxvd2luZyBpcyB0aGUgY29udmVydGVkDQo+ICJVTkNfQ0hBX1RPUl9P
Q0NVUEFOQ1kuSUFfTUlTU19MbGNQcmVmRFJEIg0KPiA+IGluIHBlcmYgSlNPTi4gVGhlICJGaWx0
ZXIiIGZpbGVkIGhhcyB2YWx1ZSAiY29uZmlnMT0weDRiNDMzIiwgd2hpY2ggbG9va3MNCj4gY29y
cmVjdCB0bw0KPiA+IG1lIGFjY29yZGluZyB0byB5b3VyIGRlc2NyaXB0aW9uIGFib3ZlLg0KPiA+
DQo+ID4gUGxlYXNlIGxldCBtZSBrbm93IHlvdXIgdGhvdWdodHMuDQo+ID4NCj4gPiAgICAgew0K
PiA+ICAgICAgICAgIkJyaWVmRGVzY3JpcHRpb24iOiAiVU5DX0NIQV9UT1JfT0NDVVBBTkNZLklB
X01JU1NfTGxjUHJlZkRSRCIsDQo+ID4gICAgICAgICAiQ291bnRlciI6ICIwIiwNCj4gPiAgICAg
ICAgICJFdmVudENvZGUiOiAiMHgzNiIsDQo+ID4gICAgICAgICAiRXZlbnROYW1lIjogIlVOQ19D
SEFfVE9SX09DQ1VQQU5DWS5JQV9NSVNTX0xsY1ByZWZEUkQiLA0KPiA+ICAgICAgICAgIkZpbHRl
ciI6ICJjb25maWcxPTB4NGI0MzMiLA0KPiA+ICAgICAgICAgIlBlclBrZyI6ICIxIiwNCj4gPiAg
ICAgICAgICJVTWFzayI6ICIweDIxIiwNCj4gPiAgICAgICAgICJVbml0IjogIkNIQSINCj4gPiAg
ICAgfSwNCj4gDQo+IEkgdGhpbmsgd2UgbmVlZCBjb25maWcxIHRvIGJlIDB4NGI0MzMwMDAwMDAw
MD8NCg0KSWYgdGhpcyBpcyB0aGUgdmFsdWUgcmVxdWlyZWQsIEBMaWFuZywgS2FuIGFuZCBASWFu
IFJvZ2Vycywgc2hvdWxkIHdlIHVwZGF0ZSB0aGUgDQpjb252ZXJ0ZXIgc2NyaXB0IHRvIHNldCAw
eDRiNDMzMDAwMDAwMDAgb3IgbGV0IGtlcm5lbCB0byBwYWQgdGhlIHplcm9zPyBJIHdhbnQgdG8g
DQplbnN1cmUgdGhhdCB3ZSB3b24ndCBicmVhayBvdGhlciBwbGF0Zm9ybXMgaWYgY2hhbmdlIHRo
aXMgaW4gdGhlIGNvbnZlcnRlciBzY3JpcHQuIA0KDQpUaGFua3MsDQpXZWlsaW4NCg0KPiANCj4g
VGhhbmtzLA0KPiBTb25nDQo=
