Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798F61CF9A;
	Thu, 23 May 2024 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482741; cv=fail; b=TS9BQyYpCawqwB/OpGT+hGY9yPav1x8SOTDMCWz1/8KeuBIb0a/OWr2+wbi6Y6mK6e1Bg03FmgzKFqs4WodA4qkEZtJddwCVhHxbIyYW23Ba4GxMANB5pkgDnHogwxb/jc/SM7unjgIpfaYag1HgiQA8cljw4bfVDuwADl0XymM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482741; c=relaxed/simple;
	bh=NXkbPoJ163U6ucMumhDcH1v8L66/Cz4XzqFx1SWsSgI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pMEgBdRepmk1D+ZeIchm4VIlG3rPqi7zGfOXQspeza9ZWlbkCnpegdEOnq2YIqpHqjrsMdcs1OhrMcXdBEqcMDKstF8/ShUWVHpasz6Lw8zR+ieMrMLnRBlRtrA0RrLeXudkvsZL0FhsSMgY1HtXXhLKGFmtAZjd3o2HWx/7AsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jOmLTLEh; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jOmLTLEh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716482739; x=1748018739;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NXkbPoJ163U6ucMumhDcH1v8L66/Cz4XzqFx1SWsSgI=;
  b=jOmLTLEh504qwuvkrWzzfrr6B3EdOGm909Bt94LqN64S1SQBA1ORZF48
   wZBI1dUS/sqyEwmyLVFJzugEfTpnl0nvWenxNkt8jl8zJeY87Ea7UtpWH
   1M98tYMm5YSaHoP3OGTU74YgMg+zZ/mt7fBiLQZB3lmkvbc2ZJ9Qg62kZ
   SsPwv8h2SEI9r/tTmiuElifPS1g1nbVh5anFFsTfoPFz49Yb0w+ile5I3
   tD0YGxkndaj3AgkwtAyWRjOQTmXA1IPqW8NKLxtiNx9ML5B0F/E9essmw
   y4sh6ucI9ZDtiwM1FFcoHgsrW/okqQxHIw55+RvFeS0ol/Dcnx/K1vjOL
   g==;
X-CSE-ConnectionGUID: YcRZv8zkSHS1rvY3urzE2w==
X-CSE-MsgGUID: /ucz0WWVQH6u82q/DSJzSQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="24226036"
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="24226036"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 09:45:38 -0700
X-CSE-ConnectionGUID: DWCkTsVnQhya4t3HeYzLYA==
X-CSE-MsgGUID: yspysXnlSXeuE5jDQLfEKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="38510219"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 May 2024 09:45:34 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 09:45:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 09:45:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 09:45:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYlI0YoU4IpF+AQtk+KggzVDsweKmevHTGmb7HBH81F9B/B2p34JBc+otddB6shiM6dR5C3Lg/GzmFVd0PqQStDTB8L27rVVggzRQ/IJFa0hxYTGliBZIzj0+EWu4Bz6MvT27rbNHzG30s53L94113+CGwge1wxebwr6VHdif2IkESCIltcH9o+7TsQSa3+E5LzwvtZ6mh3rb9tR2joAFjlbS95EcTRumSUhyq/lYS6hsSOF0thIqKKfFBgWZPbCboFTwtOtIYb30N3fmaeDefQzK1q5QE7PDXDBsy3CYm78thq5J/2Rks6cfC8z+Q7KOtHrw5WEJjq9xvn33adt2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXkbPoJ163U6ucMumhDcH1v8L66/Cz4XzqFx1SWsSgI=;
 b=b7ea9SNx+EbGWPxnRlZMeVB83OU1xYf7BuHaCYIGyzSePiZB/ZLpaeBo2q6DxRboQvvbhk2nNN8/dLaivDrahoLYC8nw0GeeZ6Xnu5b+wd6PPMjDQVfmG3sQ+DM8Cvm488WAFImILlK5Ax6TkAQfm9/5GAQgcMm7oJ3TZBBwP6MverphdmfKFfhB4i+sdRi7jn2yttKHjDpV9DM9Qh8UXRcFNgsaAcNhzh2294hE0zuOVcuw6ymzH+rENjrx3F3Lrw4kJTnSa4Mu7nphJbu71dKbEVCQfVcmyFcBcghZAntUqcl1vDGGdJLcx5bMzNsqH5kW0cID6FXpIISveFZIEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by PH0PR11MB5808.namprd11.prod.outlook.com (2603:10b6:510:129::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 16:45:30 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%4]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 16:45:30 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Ian Rogers <irogers@google.com>
CC: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>, Kan
 Liang <kan.liang@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb"
	<caleb.biggers@intel.com>
Subject: RE: [RFC PATCH v9 0/7] TPEBS counting mode support
Thread-Topic: [RFC PATCH v9 0/7] TPEBS counting mode support
Thread-Index: AQHaq6Xsbnn5sUBz4keWbgsqCcvt8rGkNSoAgADUQkA=
Date: Thu, 23 May 2024 16:45:29 +0000
Message-ID: <CO6PR11MB563553020E9A0275390E3763EEF42@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240521173952.3397644-1-weilin.wang@intel.com>
 <CAP-5=fU2-9WFZAewj_B7phusZyarA3xrenGVz6PMwy5B+B=RPg@mail.gmail.com>
In-Reply-To: <CAP-5=fU2-9WFZAewj_B7phusZyarA3xrenGVz6PMwy5B+B=RPg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|PH0PR11MB5808:EE_
x-ms-office365-filtering-correlation-id: cbbe926b-0c66-406d-42b2-08dc7b47c193
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?V3Z3bnduMnlyYnpodmhJbFJkVy9CM0h2c09JK2xjTVJHcjVFM0dtWDBaenNO?=
 =?utf-8?B?UFpuV013Z0RJb0NVT2RtbWprRVdsME9ScmVKUjFHTXZCQTkzR05wZ0lLSm0z?=
 =?utf-8?B?T2R3NHRoZDVxS0xhTkNEM3JGU1NCRFJGckVUbTUxNTRTVnpRWXo3V2hzSVV4?=
 =?utf-8?B?bXQyajZTYUZCa0o2R2wvOTZUU05DLzN6NWpRenBnWE9COG1OQmlidjFwMEVT?=
 =?utf-8?B?eFNST1dwcWJvUUlGQWpNKzlYMzFVcXV4MTNSY1RLS1Z2Ymo0ai9UVWFFVHhH?=
 =?utf-8?B?dlNUU3hMeHB3VHRoZzdhZ0ZxekM5c25pWllkeDgxLzNyY3gzNDBrNjJzV05F?=
 =?utf-8?B?M0tXeFJoYnNCT0xsMXZLYURtNFVtMDArTmZtRG1kcTFOY085TkZlZ1ppZTFO?=
 =?utf-8?B?a0c2SWJkdGRqbEVKYkhTUDFLOG9nemY3UmoyelpFSzJMOTFiMHorNFFOTkRs?=
 =?utf-8?B?T1hBSGM0d1BBQkp6WXhYekM1c3h4a1FXcW9HQXlnRE4yUnU2cGN6SEhqalQy?=
 =?utf-8?B?Rk90SlRNeEZZWEZ0akVjOTFkRkJoNEJMdDd1M0R0RXhJY3JKZGc0bUxLT2k5?=
 =?utf-8?B?TjA3emppYlZuaWdzRWhHbkxka2VJa2ZXS2JDQUxKSndWRjdZNWlMZnBuZ2ZZ?=
 =?utf-8?B?VC9WR0tGdjErVHFjYldNK1M4T3BPYVJVc3ozR3MxdFdzRnY3RGlJS2Y1UjhG?=
 =?utf-8?B?SUc3UzhYRzhaOWJyV1BMazZMaEJ1OWVQaitONFNIZmZwMmRnVldVbDNyVXp6?=
 =?utf-8?B?KzV2S0QvaDkrd0FnejRjbHdPMzB5OHA3eEpoUndNVU9DSWcrVWNVMU1pYXZh?=
 =?utf-8?B?cHZ0QitmcDMyK3BRVDFQN3JSVzE0anBKSkI3ZitMWXRrVzd0MXBSbmMyVy9O?=
 =?utf-8?B?dzJBUEhZeVVrZUlLa1hoa0ZGc3FSTGc1MVJTSFVhdXFzREpybHVyMmZXRmtn?=
 =?utf-8?B?NXhFRmFyaVNjRDdERnR1SE5RR2ZpR1dIWmQ5ZmpPWXMrVTAwWlZHVzRwbEtx?=
 =?utf-8?B?Ukh4QTRhT25haHg2a1pEMWI4QTI1cU01QjhjM3lDSnRFVG1kaWt0M1ZmZTdi?=
 =?utf-8?B?bFI0eTl1RU5DYmtnb2pNNkprcTUyS3l1OXdOejI2azRoeFdaVnJQS0ZrRE15?=
 =?utf-8?B?OG9xVHJIOS9UK0VVbXhPVDJUZ1ZxaGRNZnhwOUdOd082VTFoaWplVFAxMXV2?=
 =?utf-8?B?OG5DYUtkM3gzYnRscDlJQ09mWGVxYmVKckFxc0JUcUlyc0I1YkV5cW9wSmZo?=
 =?utf-8?B?SXJRZ3BPQk5DOTFSMEc3Zzg2YzhOeDR3UUtmQ0JNaWdRR05MNWN6M2ZidnFD?=
 =?utf-8?B?b1N4a3d6OHhjUmNWRy9ySzV4YS8xK1VBU1RGVm9WdFRqbjJ6V3hSWTE3LzVx?=
 =?utf-8?B?OUcxLzNlRm53Wk16N3A1K0Y4Y3lacW1yRDR4K0lMK3J3RmN1MUVzU1RuaW5D?=
 =?utf-8?B?eC9EYlRzSnRMSEJvWWt3QnRQdk1OanJaanZlT1lPRnpIREY1a3E0aytwTTBO?=
 =?utf-8?B?RGtmLzBjVUIycGJlVDlqRDZSNWhtY2FZVm9rWGJzZW13WlJRb1cyRDhxYUtl?=
 =?utf-8?B?ZlNoOFZkMU1OaXNjNTdJWm9jSklsNDF3RS9Jbm5va2Y0MGtJNDBBdUlyQm9R?=
 =?utf-8?B?S3psUGdmaDBFQUdMODRoTFBJMExwSWhYNnp1N0J5eGdYMFRYbjBvc0JHNTFz?=
 =?utf-8?B?SnNNMGxKYmlscE4wLzNTT2k0VGFMUEdDempjYmpmdE5GNUdZdGlrZ05qZzhK?=
 =?utf-8?Q?XwY8Kc4ofF4XdnqQqg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkJteEVna0xIZDZvWFFZVCszSHVHTDBUc3B4ZG04NHJDVWJWTlpnT2VyRThD?=
 =?utf-8?B?Uys2SUphcG5WTE42eHBQUmdpVU9Qc0Q2RTVURlB6UHh4RnpkejVSZjdpZkZC?=
 =?utf-8?B?am1jNnQ4MldRZkRPRkxjMHBBcXFVUGcvbVl5L0VsRC9VaHJTODVSbEs2QldQ?=
 =?utf-8?B?TW9iaitaZXdFTWNmNEphVzM4cm00U3lQSGNKMEk4MXVxVWN6S0ZjUUdCM1Fi?=
 =?utf-8?B?a3pqeGF6dVVNYzRjd2RLN0dBeUphbGUrTkVkSkFFUkg2NFgwSHlJdkNSS0Y1?=
 =?utf-8?B?QURCN0NjUGdFcmdGcE5MMUJtS2ZVYUNxSGRNUU1CeWpHSWxOaUFlbldCbTND?=
 =?utf-8?B?WVk5eWZIMmpza2pwZTlHcjdDNWZpVTZERi9VRm4rRGhNQVBEejRpTG1Tc0Ft?=
 =?utf-8?B?WWJFZGoxbm9CU2plZ2RGWnZZalRvRDVnSnNEU0Ntbk5GUWVLZ3NjaXlzVTRz?=
 =?utf-8?B?NFdpLzRVMlYwVE16dkszMGtEMnAreGUvSmlGLzNmQmJFWWlTWkd3Vmc5ZVU5?=
 =?utf-8?B?QWVwUDRBOHpRRTBnSXNobGNlVFlhYTBsZFpZUElpejFBRnhWZDJnNWZ3bUsx?=
 =?utf-8?B?NkNXY2padGVUdkZPZjQrcENSY0hYcUpzM0owdi92OWNPNGFsb3ZQWnhnOHll?=
 =?utf-8?B?UDBPRjJ0NXlRL21wWWdTRGJEMWFQbWZwbWpaTGlaaVU5alRQVHJadldQc2Yz?=
 =?utf-8?B?YkV2VjBkZklObXNqSE8xd2tIcWdBQ3pGQmNoUkRsV3RJNlE0ZGhVdmo1Y0VW?=
 =?utf-8?B?UHNuL3ZOYWRqbml0VStwZmY3TEZDWVdsMnpkb29oNmNNb0RNY2xLSGYxMklv?=
 =?utf-8?B?Wm1NRThob2tkTHEvS1dJNndKV2tNay9aRFlRS2NmS1UrRVNDemc5Y05FVnJp?=
 =?utf-8?B?b2hrTjdXQy93QlhlUXQxUlVXanBPRFBzUXBxU3R6VE91b05ld0JEaEVrZTJl?=
 =?utf-8?B?VE1ub3ppd0pLYUE4KzFHaTdIbmY2bmpzaWJsOFE4VjlFb1BWZ1ZqZXlTaVJz?=
 =?utf-8?B?STVXMlNMYVcvTmJsbEs2OXBrbGtpRFBhTXZRd1A1WC95WkNpUFFoQThWYkI5?=
 =?utf-8?B?UHJNRC9PSWVzT3NYSlkxY3poeXliZHBTYU5TdEkzVncyaHF6a0pmN2JLaVhK?=
 =?utf-8?B?dmc2dUFFV1VjdWRMSTR5RGp5dGx5WUZLTlNJQWxteFF3OVRRcExtcVIycG9u?=
 =?utf-8?B?bVZSWEhPb04yMmJjTU1zZlMxWk51c1YzNEF0blpkSFVnaDVaSkFEUC9UdllF?=
 =?utf-8?B?WWpwbldiQ01SMGVndVF2MHpCS3NzOE5kc2Z3RjdQM2NsNkt2QlVOV2ZINVMv?=
 =?utf-8?B?Y0l6bTBua0h2cjJ6TmhtZFpSblliQVFadkg1dnM5RWV4VWczSHJHcHFqWkIx?=
 =?utf-8?B?SWQ5Rjh4YkpjNGdoZkVRUUJELzBJZm40QkNjUFZpcG5Ib1lUTC9SN1pmYzBl?=
 =?utf-8?B?Ri9YNkgvTTlnUm02T090aDNUdUlkU0F5MThkSTF6K0VBK3RuakEwTnNESzFH?=
 =?utf-8?B?Snh3aUZ0VkxUTURXT1k5dit4cHZNcU9zcGNLT2V5NHVLZkVmMVg2NG1GMWVU?=
 =?utf-8?B?ZTdDNW5ES0tDaXd3bFVxemdPUHJPTGNwVjBRRC9oZFZNTk1tcFNRcFNjUlVN?=
 =?utf-8?B?WGxRb0lEQ0xQWC9QUWRtakRUNFVJZ1UzU3ZIaXdHR29rVWpZSEdhdzdNUmUr?=
 =?utf-8?B?S205MWw2K0JUWDE5T2Y0aGdVeGY0R1hvMVZVSElGeHZ4dHZKRmZTN3U2YTVN?=
 =?utf-8?B?QUc2QStiNlRFR0ZaL2s2OEpuQVFDQVJXMW9Ob21DMEJBSEdHb3JuQU5wV0Qv?=
 =?utf-8?B?UWRsZ1NLTlZSYzFEOWQvaU5WN1EzNTBqZXE1enVuZVpxaWdDYmtQS2F5NmEv?=
 =?utf-8?B?MUxlQW85YXFVeUZlclRpSjVDUThHbVp6L1RLczRJL2l3cTl3eDUycU5ISmFm?=
 =?utf-8?B?blkxUDRlL2xiS1Z6SjUzMHZMVXdBL0VuUWRHdjBadkxMN0w0TkZlQmtINTNU?=
 =?utf-8?B?emUyYjY4OGhqa0U3MWZZcUI2d3hBUndSMWh3M0pVajFPTHZyWlJmcCtoRHNq?=
 =?utf-8?B?QmtaTVpMbEo0UTJtdDQweVdmdFg3OHFGYjdtWUJGMDlDeVA1S3pVaFhxSGlD?=
 =?utf-8?Q?87SndNPwGuFsg4JWcnunksHyW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbe926b-0c66-406d-42b2-08dc7b47c193
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 16:45:29.9944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ieqJXnYGMt58ZTJoUA35mPl/Y/szhH+JqOqBB+ESy+xO73StEiquv6TduFbtNpl8VJc6wgliv7y9CnFLZNPZUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5808
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSWFuIFJvZ2VycyA8aXJv
Z2Vyc0Bnb29nbGUuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE1heSAyMiwgMjAyNCA5OjA0IFBN
DQo+IFRvOiBXYW5nLCBXZWlsaW4gPHdlaWxpbi53YW5nQGludGVsLmNvbT4NCj4gQ2M6IE5hbWh5
dW5nIEtpbSA8bmFtaHl1bmdAa2VybmVsLm9yZz47IEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbw0K
PiA8YWNtZUBrZXJuZWwub3JnPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3Jn
PjsgSW5nbyBNb2xuYXINCj4gPG1pbmdvQHJlZGhhdC5jb20+OyBBbGV4YW5kZXIgU2hpc2hraW4N
Cj4gPGFsZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb20+OyBKaXJpIE9sc2EgPGpvbHNh
QGtlcm5lbC5vcmc+OyBIdW50ZXIsDQo+IEFkcmlhbiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+
OyBLYW4gTGlhbmcgPGthbi5saWFuZ0BsaW51eC5pbnRlbC5jb20+Ow0KPiBsaW51eC1wZXJmLXVz
ZXJzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgVGF5bG9y
LCBQZXJyeQ0KPiA8cGVycnkudGF5bG9yQGludGVsLmNvbT47IEFsdCwgU2FtYW50aGEgPHNhbWFu
dGhhLmFsdEBpbnRlbC5jb20+OyBCaWdnZXJzLA0KPiBDYWxlYiA8Y2FsZWIuYmlnZ2Vyc0BpbnRl
bC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHY5IDAvN10gVFBFQlMgY291bnRpbmcg
bW9kZSBzdXBwb3J0DQo+IA0KPiBPbiBUdWUsIE1heSAyMSwgMjAyNCBhdCAxMDozOeKAr0FNIDx3
ZWlsaW4ud2FuZ0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogV2VpbGluIFdhbmcg
PHdlaWxpbi53YW5nQGludGVsLmNvbT4NCj4gPg0KPiA+IENoYW5nZXMgaW4gdjk6DQo+ID4gLSBV
cGRhdGUgdGhlIHJldGlyZV9sYXRlbmN5IHJlc3VsdCBwcmludCBhbmQgbWV0cmljIGNhbGN1bGF0
aW9uIG1ldGhvZC4gUGx1Z2luDQo+ID4gdGhlIHZhbHVlIHRvIGV2c2VsIHNvIHRoYXQgbm8gc3Bl
Y2lhbCBjb2RlIGlzIHJlcXVpcmVkLg0KPiA+IC0gVXBkYXRlIC0tY29udHJvbDpmaWZvIHRvIHVz
ZSBwaXBlIGluc3RlYWQgb2YgbmFtZWQgcGlwZS4NCj4gPiAtIEFkZCB0ZXN0IGZvciBUUEVCUyBj
b3VudGluZyBtb2RlLg0KPiA+IC0gVXBkYXRlIERvY3VtZW50IHdpdGggbW9yZSBkZXRhaWxzLg0K
PiA+DQo+ID4gQ2hhbmdlcyBpbiB2ODoNCj4gPiAtIEluIHRoaXMgcmV2aXNpb24sIHRoZSBjb2Rl
IGlzIHVwZGF0ZWQgdG8gYmFzZSBvbiBJYW4ncyBwYXRjaCBvbiBSIG1vZGlmaWVyDQo+ID4gcGFy
c2VyIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyNDA0MjgwNTM2MTYuMTEyNTg5MS0z
LQ0KPiBpcm9nZXJzQGdvb2dsZS5jb20vDQo+IA0KPiBJIHB1bGxlZCB0aGUgZmlyc3QgcGF0Y2gg
b2YgdGhlc2UgMywgdG8gY2xlYW4gdXAgdGhlIHRvb2wgZXZlbnRzIGludG8NCj4gaXRzIG93biBw
YXRjaCBhbmQgaG9wZWZ1bGx5IGFkZHJlc3NlZCBOYW1oeXVuZydzIGZlZWRiYWNrOg0KPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjQwNTAzMjMyODQ5LjE3NzUyLTEtDQo+IGlyb2dl
cnNAZ29vZ2xlLmNvbS8NCj4gSXQgaXMgbG9va2luZyBmb3IgcmV2aWV3Lg0KPiANCj4gSSB0aGlu
ayBpbiBnZW5lcmFsIGl0J2QgYmUgdXNlZnVsIHdoZW4gcG9zdGluZyB0aGUgc2VyaWVzIHRvIGlu
Y2x1ZGUNCj4gdGhlIHBhdGNoZXMgaXQgaXMgZGVwZW5kZW50IG9uLCB0aGF0IHdheSB3ZSBjYW4g
YWxzbyBtYWtlIGNoYW5nZXMgdG8NCj4gdGhvc2UgcGF0Y2hlcyAoZm9yIGV4YW1wbGUgdGhlIG1p
c3NlZCBwZXJmLWxpc3QgZG9jdW1lbnRhdGlvbiBvZiB0aGUNCj4gJ1InIG1vZGlmaWVyKS4NCg0K
SGkgSWFuLA0KDQpJIHdpbGwgaW5jbHVkZSB0aGUgMm5kIHBhdGNoIGZyb20gdGhlIHNlcmllcyBp
biB0aGUgVFBFQlMgcGF0Y2ggc2V0IG5leHQgdGltZS4gDQoNClRoYW5rcywNCldlaWxpbg0KPiAN
Cj4gVGhhbmtzLA0KPiBJYW4NCj4gDQo+IA0KPiANCj4gPiBBZnRlciB0aGlzIGNoYW5nZSwgdGhl
cmUgaXMgbm8gc3BlY2lhbCBjb2RlIHJlcXVpcmVkIGZvciBSIG1vZGlmaWVyIGluDQo+ID4gbWV0
cmljZ3JvdXAuYyBhbmQgbWV0cmljZ3JvdXAuaCBmaWxlcy4NCj4gPg0KPiA+IENhdmVhdCBvZiB0
aGlzIGNoYW5nZToNCj4gPiAgIElkZWFsbHksIHdlIHdpbGwgbmVlZCB0byBhZGQgc3BlY2lhbCBo
YW5kbGluZyB0byBza2lwIGNvdW50aW5nIGV2ZW50cyB3aXRoIFINCj4gPiBtb2RpZmllciBpbiBl
dnNlbC4gQ3VycmVudGx5LCB0aGlzIGlzIG5vdCBpbXBsZW1lbnRlZCBzbyB0aGUgZXZlbnQgd2l0
aCA6UiB3aWxsDQo+ID4gYmUgYm90aCBjb3VudGVkIGFuZCBzYW1wbGVkLiBVc3VhbGx5LCBpbiBh
IG1ldHJpYyBmb3JtdWxhIHRoYXQgdXNlcw0KPiByZXRpcmVfbGF0ZW5jeSwNCj4gPiBpdCB3b3Vs
ZCBhbHJlYWR5IHJlcXVpcmUgdG8gY291bnQgdGhlIGV2ZW50LiBBcyBhIHJlc3VsdCwgd2Ugd2ls
bCBlbmR1cCBjb3VudA0KPiB0aGUNCj4gPiBzYW1lIGV2ZW50IHR3aWNlLiBUaGlzIHNob3VsZCBi
ZSBhYmxlIHRvIGJlIGhhbmRsZWQgcHJvcGVybHkgd2hlbiB3ZQ0KPiBmaW5hbGl6ZSBvdXINCj4g
PiBkZXNpZ24gb24gZXZzZWwgUiBtb2RpZmllciBzdXBwb3J0Lg0KPiA+DQo+ID4gLSBNb3ZlIFRQ
RUJTIHNwZWNpZmljIGNvZGUgb3V0IGZyb20gbWFpbiBwZXJmIHN0YXQgY29kZSB0byBzZXBhcmF0
ZSBmaWxlcyBpbg0KPiA+IHV0aWwvaW50ZWwtdHBlYnMuYyBhbmQgdXRpbC9pbnRlbC10cGVicy5o
LiBbTmFtaHl1bmddDQo+ID4gLSBVc2UgLS1jb250cm9sOmZpZm8gdG8gYWNrIHBlcmYgc3RhdCBm
cm9tIGZvcmtlZCBwZXJmIHJlY29yZCBpbnN0ZWFkIG9mDQo+IHNsZWVwKDIpIFtOYW1oeXVuZ10N
Cj4gPiAtIEFkZCBpbnRyb2R1Y3Rpb25zIGFib3V0IFRQRUJTIGFuZCBSIG1vZGlmaWVyIGluIERv
Y3VtZW50cy4gW05hbWh5dW5nXQ0KPiA+DQo+ID4NCj4gPiBDaGFuZ2VzIGluIHY3Og0KPiA+IC0g
VXBkYXRlIGNvZGUgYW5kIGNvbW1lbnRzIGZvciBiZXR0ZXIgY29kZSBxdWFsaXR5IFtOYW1oeXVu
Z10NCj4gPiAtIEFkZCBhIHNlcGFyYXRlIGNvbW1pdCBmb3IgcGVyZiBkYXRhIFtOYW1oeXVuZ10N
Cj4gPiAtIFVwZGF0ZSByZXRpcmUgbGF0ZW5jeSBwcmludCBmdW5jdGlvbiB0byBpbXByb3ZlIGFs
aWdubWVudCBbTmFtaHl1bmddDQo+ID4NCj4gPiBDaGFuZ2VzIGluIHY2Og0KPiA+IC0gVXBkYXRl
IGNvZGUgYW5kIGFkZCBjb21tZW50cyBmb3IgYmV0dGVyIGNvZGUgcXVhbGl0eSBbTmFtaHl1bmdd
DQo+ID4gLSBSZW1vdmUgdGhlIGFkZGVkIGZkIHZhciBhbmQgZGlyZWN0bHkgcGFzcyB0aGUgb3Bl
bmVkIGZkIHRvIGRhdGEuZmlsZS5mZA0KPiBbTmFtaHl1bmddDQo+ID4gLSBBZGQga2lsbCgpIHRv
IHN0b3AgcGVyZiByZWNvcmQgd2hlbiBwZXJmIHN0YXQgZXhpc3RzIGVhcmx5IFtOYW1oeXVuZ10N
Cj4gPiAtIEFkZCBjb21tYW5kIG9wdCBjaGVjayB0byBlbnN1cmUgb25seSBzdGFydCBwZXJmIHJl
Y29yZCB3aGVuIC1hLy1DIGdpdmVuDQo+IFtOYW1oeXVuZ10NCj4gPiAtIFNxdWFzaCBjb21taXRz
IFtOYW1oeXVuZ10NCj4gPg0KPiA+IENoYW5nZXMgaW4gdjU6DQo+ID4gLSBVcGRhdGUgY29kZSBh
bmQgYWRkIGNvbW1lbnRzIGZvciBiZXR0ZXIgY29kZSBxdWFsaXR5IFtJYW5dDQo+ID4NCj4gPiBD
aGFuZ2VzIGluIHY0Og0KPiA+IC0gUmVtb3ZlIHVuY2Vzc2FyeSBkZWJ1ZyBwcmludCBhbmQgdXBk
YXRlIGNvZGUgYW5kIGNvbW1lbnRzIGZvciBiZXR0ZXINCj4gPiByZWFkYWJpbGl0eSBhbmQgcXVh
bGl0eSBbTmFtaHl1bmddDQo+ID4gLSBVcGRhdGUgbXRsIG1ldHJpYyBqc29uIGZpbGUgd2l0aCBj
b25zaXN0ZW50IFRtYUwxIGFuZCBUb3Bkb3duTDENCj4gbWV0cmljZ3JvdXANCj4gPg0KPiA+IENo
YW5nZXMgaW4gdjM6DQo+ID4gLSBSZW1vdmUgJzonIHdoZW4gZXZlbnQgbmFtZSBoYXMgJ0AnIFtJ
YW5dDQo+ID4gLSBVc2UgJ1InIGFzIHRoZSBtb2RpZmllciBpbnN0ZWFkIG9mICJyZXRpcmVfbGF0
ZW5jeSIgW0lhbl0NCj4gPg0KPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gLSBBZGQgTVRMIG1ldHJp
YyBmaWxlDQo+ID4gLSBBZGQgbW9yZSBkZXNjcmlwdGlvbnMgYW5kIGV4YW1wbGUgdG8gdGhlIHBh
dGNoIFtBcm5hbGRvXQ0KPiA+DQo+ID4gSGVyZSBpcyBhbiBleGFtcGxlIG9mIHJ1bm5pbmcgcGVy
ZiBzdGF0IHRvIGNvbGxlY3QgYSBtZXRyaWMgdGhhdCB1c2VzDQo+ID4gcmV0aXJlX2xhdGVuY3kg
dmFsdWUgb2YgZXZlbnQgTUVNX0lOU1RfUkVUSVJFRC5TVExCX0hJVF9TVE9SRVMgb24gYQ0KPiBN
VEwgc3lzdGVtLg0KPiA+DQo+ID4gSW4gdGhpcyBzaW1wbGUgZXhhbXBsZSwgdGhlcmUgaXMgbm8g
TUVNX0lOU1RfUkVUSVJFRC5TVExCX0hJVF9TVE9SRVMNCj4gc2FtcGxlLg0KPiA+IFRoZXJlZm9y
ZSwgdGhlIE1FTV9JTlNUX1JFVElSRUQuU1RMQl9ISVRfU1RPUkVTOnAgY291bnQgYW5kDQo+IHJl
dGlyZV9sYXRlbmN5IHZhbHVlDQo+ID4gYXJlIGFsbCAwLg0KPiA+DQo+ID4gLi9wZXJmIHN0YXQg
LU0gdG1hX2R0bGJfc3RvcmUgLWEgLS0gc2xlZXAgMQ0KPiA+DQo+ID4gWyBwZXJmIHJlY29yZDog
V29rZW4gdXAgMSB0aW1lcyB0byB3cml0ZSBkYXRhIF0NCj4gPiBbIHBlcmYgcmVjb3JkOiBDYXB0
dXJlZCBhbmQgd3JvdGUgMC4wMDAgTUIgLSBdDQo+ID4NCj4gPiAgUGVyZm9ybWFuY2UgY291bnRl
ciBzdGF0cyBmb3IgJ3N5c3RlbSB3aWRlJzoNCj4gPg0KPiA+ICAgICAgICAxODEsMDQ3LDE2OCAg
ICAgIGNwdV9jb3JlL1RPUERPV04uU0xPVFMvICAgICAgICAgICMgICAgICAwLjYgJQ0KPiB0bWFf
ZHRsYl9zdG9yZQ0KPiA+ICAgICAgICAgIDMsMTk1LDYwOCAgICAgIGNwdV9jb3JlL3RvcGRvd24t
cmV0aXJpbmcvDQo+ID4gICAgICAgICA0MCwxNTYsNjQ5ICAgICAgY3B1X2NvcmUvdG9wZG93bi1t
ZW0tYm91bmQvDQo+ID4gICAgICAgICAgMyw1NTAsOTI1ICAgICAgY3B1X2NvcmUvdG9wZG93bi1i
YWQtc3BlYy8NCj4gPiAgICAgICAgMTE3LDU3MSw4MTggICAgICBjcHVfY29yZS90b3Bkb3duLWZl
LWJvdW5kLw0KPiA+ICAgICAgICAgNTcsMTE4LDA4NyAgICAgIGNwdV9jb3JlL3RvcGRvd24tYmUt
Ym91bmQvDQo+ID4gICAgICAgICAgICAgNjksMTc5ICAgICAgY3B1X2NvcmUvRVhFX0FDVElWSVRZ
LkJPVU5EX09OX1NUT1JFUy8NCj4gPiAgICAgICAgICAgICAgNCw1ODIgICAgICBjcHVfY29yZS9N
RU1fSU5TVF9SRVRJUkVELlNUTEJfSElUX1NUT1JFUy8NCj4gPiAgICAgICAgIDMwLDE4MywxMDQg
ICAgICBjcHVfY29yZS9DUFVfQ0xLX1VOSEFMVEVELkRJU1RSSUJVVEVELw0KPiA+ICAgICAgICAg
MzAsNTU2LDc5MCAgICAgIGNwdV9jb3JlL0NQVV9DTEtfVU5IQUxURUQuVEhSRUFELw0KPiA+ICAg
ICAgICAgICAgMTY4LDQ4NiAgICAgIGNwdV9jb3JlL0RUTEJfU1RPUkVfTUlTU0VTLldBTEtfQUNU
SVZFLw0KPiA+ICAgICAgICAgICAgICAgMC4wMCBNRU1fSU5TVF9SRVRJUkVELlNUTEJfSElUX1NU
T1JFUzpwICAgICAgIDAgICAgICAgIDANCj4gPg0KPiA+ICAgICAgICAxLjAwMzEwNTkyNCBzZWNv
bmRzIHRpbWUgZWxhcHNlZA0KPiA+DQo+ID4gdjE6DQo+ID4gVFBFQlMgaXMgb25lIG9mIHRoZSBm
ZWF0dXJlcyBwcm92aWRlZCBieSB0aGUgbmV4dCBnZW5lcmF0aW9uIG9mIEludGVsIFBNVS4NCj4g
PiBQbGVhc2UgcmVmZXIgdG8gU2VjdGlvbiA4LjQuMSBvZiAiSW50ZWzCriBBcmNoaXRlY3R1cmUg
SW5zdHJ1Y3Rpb24gU2V0DQo+IEV4dGVuc2lvbnMNCj4gPiBQcm9ncmFtbWluZyBSZWZlcmVuY2Ui
IFsxXSBmb3IgbW9yZSBkZXRhaWxzIGFib3V0IHRoaXMgZmVhdHVyZS4NCj4gPg0KPiA+IFRoaXMg
c2V0IG9mIHBhdGNoZXMgc3VwcG9ydHMgVFBFQlMgaW4gY291bnRpbmcgbW9kZS4gVGhlIGNvZGUg
d29ya3MgaW4gdGhlDQo+ID4gZm9sbG93aW5nIHdheTogaXQgZm9ya3MgYSBwZXJmIHJlY29yZCBw
cm9jZXNzIGZyb20gcGVyZiBzdGF0IHdoZW4NCj4gcmV0aXJlX2xhdGVuY3kNCj4gPiBvZiBvbmUg
b3IgbW9yZSBldmVudHMgYXJlIHVzZWQgaW4gYSBtZXRyaWMgZm9ybXVsYS4gUGVyZiBzdGF0IHdv
dWxkIHNlbmQgYQ0KPiA+IFNJR1RFUk0gc2lnbmFsIHRvIHBlcmYgcmVjb3JkIGJlZm9yZSBpdCBu
ZWVkcyB0aGUgcmV0aXJlIGxhdGVuY3kgdmFsdWUgZm9yDQo+ID4gbWV0cmljIGNhbGN1bGF0aW9u
LiBQZXJmIHN0YXQgd2lsbCB0aGVuIHByb2Nlc3Mgc2FtcGxlIGRhdGEgdG8gZXh0cmFjdCB0aGUN
Cj4gPiByZXRpcmUgbGF0ZW5jeSBkYXRhIGZvciBtZXRyaWMgY2FsY3VsYXRpb25zLiBDdXJyZW50
bHksIHRoZSBjb2RlIHVzZXMgdGhlDQo+ID4gYXJpdGhtZXRpYyBhdmVyYWdlIG9mIHJldGlyZSBs
YXRlbmN5IHZhbHVlcy4NCj4gPg0KPiA+IFsxXSBodHRwczovL3d3dy5pbnRlbC5jb20vY29udGVu
dC93d3cvdXMvZW4vY29udGVudC0NCj4gZGV0YWlscy84MTIyMTgvaW50ZWwtYXJjaGl0ZWN0dXJl
LWluc3RydWN0aW9uLXNldC1leHRlbnNpb25zLXByb2dyYW1taW5nLQ0KPiByZWZlcmVuY2UuaHRt
bD93YXBrdz1mdXR1cmUlMjBmZWF0dXJlcw0KPiA+DQo+ID4NCj4gPiBXZWlsaW4gV2FuZyAoNyk6
DQo+ID4gICBwZXJmIHZlbmRvciBldmVudHMgaW50ZWw6IEFkZCBNVEwgbWV0cmljIGpzb24gZmls
ZXMNCj4gPiAgIHBlcmYgZGF0YTogQWxsb3cgdG8gdXNlIGdpdmVuIGZkIGluIGRhdGEtPmZpbGUu
ZmQNCj4gPiAgIHBlcmYgc3RhdDogRm9yayBhbmQgbGF1bmNoIHBlcmYgcmVjb3JkIHdoZW4gcGVy
ZiBzdGF0IG5lZWRzIHRvIGdldA0KPiA+ICAgICByZXRpcmUgbGF0ZW5jeSB2YWx1ZSBmb3IgYSBt
ZXRyaWMuDQo+ID4gICBwZXJmIHN0YXQ6IFBsdWdpbiByZXRpcmVfbGF0IHZhbHVlIGZyb20gc2Ft
cGxlZCBkYXRhIHRvIGV2c2VsDQo+ID4gICBwZXJmIHN0YXQ6IEFkZCBjb21tYW5kIGxpbmUgb3B0
aW9uIGZvciBlbmFibGluZyB0cGVicyByZWNvcmRpbmcNCj4gPiAgIHBlcmYgRG9jdW1lbnQ6IEFk
ZCBUUEVCUyB0byBEb2N1bWVudHMNCj4gPiAgIHBlcmYgdGVzdDogQWRkIHRlc3QgZm9yIEludGVs
IFRQRUJTIGNvdW50aW5nIG1vZGUNCj4gPg0KPiA+ICB0b29scy9wZXJmL0RvY3VtZW50YXRpb24v
cGVyZi1saXN0LnR4dCAgICAgICAgfCAgICAxICsNCj4gPiAgdG9vbHMvcGVyZi9Eb2N1bWVudGF0
aW9uL3RvcGRvd24udHh0ICAgICAgICAgIHwgICAzMCArDQo+ID4gIHRvb2xzL3BlcmYvYXJjaC94
ODYvdXRpbC9ldmxpc3QuYyAgICAgICAgICAgICB8ICAgIDYgKw0KPiA+ICB0b29scy9wZXJmL2J1
aWx0aW4tc3RhdC5jICAgICAgICAgICAgICAgICAgICAgfCAgIDI0ICsNCj4gPiAgLi4uL2FyY2gv
eDg2L21ldGVvcmxha2UvbWV0cmljZ3JvdXBzLmpzb24gICAgIHwgIDEyNyArDQo+ID4gIC4uLi9h
cmNoL3g4Ni9tZXRlb3JsYWtlL210bC1tZXRyaWNzLmpzb24gICAgICB8IDI1NTEgKysrKysrKysr
KysrKysrKysNCj4gPiAgLi4uL3BlcmYvdGVzdHMvc2hlbGwvdGVzdF9zdGF0X2ludGVsX3RwZWJz
LnNoIHwgICAyNyArDQo+ID4gIHRvb2xzL3BlcmYvdXRpbC9CdWlsZCAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgIDEgKw0KPiA+ICB0b29scy9wZXJmL3V0aWwvZGF0YS5jICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgICA3ICstDQo+ID4gIHRvb2xzL3BlcmYvdXRpbC9ldnNlbC5jICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgNTMgKw0KPiA+ICB0b29scy9wZXJmL3V0aWwvZXZzZWwuaCAg
ICAgICAgICAgICAgICAgICAgICAgfCAgICA1ICsNCj4gPiAgdG9vbHMvcGVyZi91dGlsL2ludGVs
LXRwZWJzLmMgICAgICAgICAgICAgICAgIHwgIDMwMSArKw0KPiA+ICB0b29scy9wZXJmL3V0aWwv
aW50ZWwtdHBlYnMuaCAgICAgICAgICAgICAgICAgfCAgIDMwICsNCj4gPiAgdG9vbHMvcGVyZi91
dGlsL3N0YXQuaCAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgMSArDQo+ID4gIDE0IGZpbGVz
IGNoYW5nZWQsIDMxNjMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgdG9vbHMvcGVyZi9wbXUtDQo+IGV2ZW50cy9hcmNoL3g4Ni9tZXRlb3JsYWtl
L21ldHJpY2dyb3Vwcy5qc29uDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy9wZXJmL3Bt
dS1ldmVudHMvYXJjaC94ODYvbWV0ZW9ybGFrZS9tdGwtDQo+IG1ldHJpY3MuanNvbg0KPiA+ICBj
cmVhdGUgbW9kZSAxMDA3NTUgdG9vbHMvcGVyZi90ZXN0cy9zaGVsbC90ZXN0X3N0YXRfaW50ZWxf
dHBlYnMuc2gNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xzL3BlcmYvdXRpbC9pbnRlbC10
cGVicy5jDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy9wZXJmL3V0aWwvaW50ZWwtdHBl
YnMuaA0KPiA+DQo+ID4gLS0NCj4gPiAyLjQzLjANCj4gPg0K
