Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F547342CBD
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 20:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775851512; cv=fail; b=AwzdgrsdLcGa9sAq8Jnt8KyyLHOj1MZFVenvgJ6Ze8mV2+x9w2tFTEZ2CoKB4njuAL03HyYXbRkEv4mCQ7fo4851vIEPnpvqrJphos1ShVC3j/aNFhXQb37qmMZDz1SjUODXAse+G9f+EVcE9KZrCtjmbKykqbijQ6zVrX+9+Ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775851512; c=relaxed/simple;
	bh=Fd12suBR9/U6Ckk2VftzyzDe8sLmSvf7B3drQJZoDOw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PVGnDNJW2DesKI7MR85RjvJ5UYeokkMtcDCyFOXwDDe/FIU/oA61FGxLyKmSDiRgsaL/ojXMVeIrY8SopEysSRoVBMqjlD/2uO5kOIOHDJkU/MeDw+QsICObIc7vmnIitR4lcgbLpE+BeZzVo5uPm4TXy/blzHgq0mfRWyazSbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fGprD4f7; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fGprD4f7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775851512; x=1807387512;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Fd12suBR9/U6Ckk2VftzyzDe8sLmSvf7B3drQJZoDOw=;
  b=fGprD4f7Joo/yWhro9l/bfdp1MyAq4cD7KdggsjhnfERFpmFFo1gBo4g
   pROJsYaahpmrrHIK2To0MWN3OY88WKP+tOGTwzxYubkeKEbgQtBBgf0HI
   jGhTPJUmE0JbPRn5swxwthKefWnS3yWJMeu+YfFQk7enZCjATgF5OcXy2
   DdAymkY8X8V9jjlMX4uIPklPfcYqEsgT3G5xgGR+CRA7p5E5hmrEnFGF7
   NYXeQjmK0yxbO0SHdehX5tNYSu1ASFU2oy6iwVHQDFJUZYZCArEjxRcft
   ee84L6Nit9nlOYEaJxm4dGaR+u3GqG3eecnNImmsdsZL++lRl0LMlvFNX
   w==;
X-CSE-ConnectionGUID: Yre2sdMAT+Ckf9xXVdSp+Q==
X-CSE-MsgGUID: cbJwdBEbSUuxjLzsfEXOjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="80742538"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="80742538"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 13:05:11 -0700
X-CSE-ConnectionGUID: 4YRiuhkKSuOV66xZI0aDgQ==
X-CSE-MsgGUID: IANg8DQuQg+R2Fg9b4954A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="234102110"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 13:05:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 13:05:10 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 10 Apr 2026 13:05:10 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.70) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 13:05:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctKgXaqAc3k1TNJ8sJuMnxTlWRZpQPRkV29Pjt4Shs5w1kjIEuK5Kqjv/QSeDdrF+uRWYMqoKgEZD6c4UNAj82dL2sIknr1sfpsnFTffIeXsDUkHBEMDVClGNsq3r7OYm/sr2KkvVxBFOoPtgpuIgVbUxvtoLRtMnQ6gIc7uUkbiXAahItjF2Pnyhtb9lFSweRZLtg1up9f1HwbYOslccinhJi97vqxOencMpmlddjMQgm9Cz8WUY2TrCwcL9Im7T2n7FJoqUbPMkZZjtK2sb6mJhEbhRq6F2z0Whur9wKzoNvwGZjhsetd7T2YP/rxiGPOt5RezxbGoOfbpJqxemg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fd12suBR9/U6Ckk2VftzyzDe8sLmSvf7B3drQJZoDOw=;
 b=JMg2lYOa5SaaqNFZEoLN353yH3YB5MZNdZEquusUZRNw7+Nkix6yk9QAuifBBjCMoYehkIG+Y7QEdJaAA/o1vtGJXcMQHnOck0SElLmB42c0S+Y+GeJKFGbfXzxE4DyS56u8NleSc33ugWuznztbJAB33lf8d4yUHZPeqpI3hPMo8h3mHh2QA7jieehVqX2hLRKYBF+IzvifsvJvMsHX2FH9GbQjLPwEznC8QnvjBVL0TsCsx8mBGH0rBmShGgiWu/j9qQfdWcCKKOivr5cEMVqw3hT1LPNc0cdyYPK6fbiCyiRUpJAVru6HoYFGCPCdZ6wRNeTnKnYFfSCpEIUFbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by PH7PR11MB6907.namprd11.prod.outlook.com (2603:10b6:510:203::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 10 Apr
 2026 20:05:07 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%6]) with mapi id 15.20.9769.043; Fri, 10 Apr 2026
 20:05:06 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "sashiko@lists.linux.dev" <sashiko@lists.linux.dev>
CC: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 2/2] perf/annotate: Fix missing branch counter column in
 TUI mode
Thread-Topic: [PATCH 2/2] perf/annotate: Fix missing branch counter column in
 TUI mode
Thread-Index: AQHcySJR/jjVtmsaI0eA1lTnZ/mq57XYt2AAgAABAIA=
Date: Fri, 10 Apr 2026 20:05:06 +0000
Message-ID: <d4839a58d24d3682a089bbcdee5b1c139d639da3.camel@intel.com>
References: <20260410194000.219846-2-thomas.falcon@intel.com>
	 <20260410200131.1E3BEC19421@smtp.kernel.org>
In-Reply-To: <20260410200131.1E3BEC19421@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|PH7PR11MB6907:EE_
x-ms-office365-filtering-correlation-id: 2d91e09d-665d-4d19-a560-08de973c7625
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: Eot1S6bLtTIJgusUx9WY7oOAHmstkU7NAgQhVhEFxwQq/lghloZPxj6MUZNI2fM/rqF0kqLCWUlVac/CF3I4BGC3XWa8OKrZ5aKRjqlhW9XFJQPmL9IpamWPLAu5nRUe0eqbxZ12+Fzv6qDLP5Xmz4EaeLuNKQhPXAICJzxrbovvrhGJ4vB5eguCFJXBMk4w869ELjYvXaQnhpoKjLBtQrN15cCe7E8dwMuidF1XfsXd9cRIU84QW2ff7/NnerLMugTXtiQDKUmTddH2YZP2kKltXSgG52xhjvYqtSEZUevOTGH1F8QxVPpzmIADNaqd1h3v7WJ2HGUWafFSLc/tGa5yprxn+H5VlI6PVybYK3keHIfwGqDF7ddReebQzOUQ87yC4nr31mi5l6rzK7PxCM+L5MAmRxJqzfnjNCl3+/1GACjLzdpM6bMN7IMLKlg4MIhgbpXjYoscAcfurRHnRr9fgiBLxs5B8L10YlI7BMk97he6t6pMbYK8XMhjB61arTlP24WHVFqdnNT/AJ+0O/sCisGZbXwqG6SrQLXZpAmV/MY5Pwa5SbnyoCYxDwY3xpTB/00oY934lLpcu/JcfG+FOM7S5YaWEAmfAVZiGxm00MiPVEidP4H/tXAuKnqgX6eNBEEoSeYcRUpBv7n3Pxhe+IBi3oGucyZJNwxRR5r2w59oPJZtWOHSRI+4B61sV9duiysDq1rbQal7j5clOyQ4S+MKrpzcyZTmsOecg1PwYp6rPvy26SpcKamTqPbkotjjZ3jlEy8R9ECIUyUvXRqqKcBPhaiNWa/f+2lzctY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0NoSDVGb2ZFQm5Ya0FTNWl0RzJuSEh2ek1aYUJNQ3FRNkhpaElUOHZsSTU1?=
 =?utf-8?B?N0dvdmhQajUzM2JDOHlBVGZCZTA5dk1pM1VCVlpDL2RGNGR2RlBvSGtmamJD?=
 =?utf-8?B?ZG13SHVhUTlLRGU3V0JNUDVEUVUyM2NnS24xUTlQb3RPR2VtcUt0VCtwRHRr?=
 =?utf-8?B?aitjb0FnSExjdDNGMU9INUNLNFVYZ0tpVDRNM3VDVi96S3h5NDRoWUZ1Ni84?=
 =?utf-8?B?cXRIOEJ6Ymd1ak0rbUw5ZTh6bmFUenpmVEFKQTRvRE9ENU41Q2FpZmFJMDNl?=
 =?utf-8?B?ZGhSKzlnVjl2ZXZmRlFrZWNlKzZRa2ZzQjdpV1VrZFlGOFJGam1wbW16elJS?=
 =?utf-8?B?Yjl5NGFFMjZmTXVUVW1zdVRRakpnVXVDOWhGVE5jVXVaN3VKeGtOL3BOT3M0?=
 =?utf-8?B?NXJiVUNsdUp2K3BKMXNGY3J5d0hFb1RHNmlKeE5KTG1qK001eXlmQzZiZWlr?=
 =?utf-8?B?OXFNWXczV3BoUVZtSDR3djEzeDV5akJrOGFXclo0bGdzYkt4d080UVp0SEJk?=
 =?utf-8?B?bjJaZllwcWM4bDUyM01FS0VGTy9yb1p1L25aQjRzL3N3QndDZzNaUjlJSDQ4?=
 =?utf-8?B?QS9iblBqQ1ZVSGJpQnZHTGhtWEJnODhicTZMa0dYRHh1Y3pZcjdLMklocUcw?=
 =?utf-8?B?OHdJUzN5UVlvWXVodEdHaDE1RE5jcVg2bTdIS0l2d1NTUUx0NmZZanlMU05u?=
 =?utf-8?B?S3l6RGV3a3RQOE1veTZlcFNGVEI0ZEFoNXp3YkN1N0J6QmdYME9aZHNKMkFS?=
 =?utf-8?B?REk1TWR6QXFIQzJwcHY3alJnZnRrUDlVUDExcDVFK2tGSUlYK3p0K3pweXZU?=
 =?utf-8?B?UXlNcWh4QnRaemJSZTZ0MFVwelZna3NDUTQ1OWJiTE9SNDVJR1JDaXl4aUdN?=
 =?utf-8?B?YWVsYU1OVkR0Ly9JYW1UMU55OW9ucUJxaEVZS1BEdUdidGRFMnpRbDhhSUtl?=
 =?utf-8?B?aklBWHVuNFJaM2VSTjBIUVR5N3JkTW9RMXpZOGJCRGhiWDFpWXpKSG9jMDNO?=
 =?utf-8?B?T1RrZ1VWYUFETzdmM0hqd0pnbTNvMUpEL1E3ZkFFOVQrYXVRV0tUb1RMeHlC?=
 =?utf-8?B?T0pTNEJSZDdCckN4aTBkSmVXSDJ4TjRFd3U0amVWZys2Vmkzb01QU0RqU3Rx?=
 =?utf-8?B?SkdHUGpjZFo4RHJpc3pEN3VBQnRSNkY0M25JMzgxc3gzRkE4Ylp5UFdlcDY5?=
 =?utf-8?B?MXhrNDM0MnozekkvaDNHOGNlc2VBWTdDc3RCeGFHSmF0V0lqRDcvQzNRaytV?=
 =?utf-8?B?cUkzV3lxTVliVWlxM2pRK3A1K21vNVBxakNUMlMzb3BtMUhFZEN3bzRZa1k5?=
 =?utf-8?B?WmFoNStZMGxsYU84NWRGSTBXRGZKcSs1RnNRMnFwa1BJSHVpSnVodGljQzJn?=
 =?utf-8?B?aS9PNUREb01BZ1dVNVFlZzhkbmFqaDRzVUtyL0hUQ3Z1SEk3S2dGbENCMWtK?=
 =?utf-8?B?bFRCQXdLMlV5N3lNQ0ZwK0tJS1p1UWVjNUhwSFNZeFhwdk1kLzVmdDRvVWo2?=
 =?utf-8?B?RlJJODBBcVN6Q2tSWm5KU2dPR2k3WU0zUTVCc0Nubi92WmpzdXA5MGhDRElI?=
 =?utf-8?B?Z3RlMjNjRlNLVVdGMCtzeXVQWmU1NTZpNHRIbmJNWXlDRDdnMGs3dVJLWHR5?=
 =?utf-8?B?OXpmdm42VXMvWmdhdlpsc3VRaEhVcXAxZjNoMnl5SStRZmRJM2pzNnNqSWVK?=
 =?utf-8?B?Z2VadllrT3NJUXloNjVDb2hmSlJmQVBnRVMyMmRPalloZ3VKQkQ2RGIxbWo0?=
 =?utf-8?B?VzRzNmduMTdvK09haFNWZzNPNTFEdFg5VE4xd1F5Vk1xTGJORkJQU0FFK1A0?=
 =?utf-8?B?UkxCMFhnYWo3UTRySXZkYWhtZklEWG9Pb05kc1ljcEcvdmFuVU54ejBWVzVm?=
 =?utf-8?B?KzZrSXNXM0I5Q0lOREQxNXgyVUY2YWZoOWNuVmdZWEVQTm5Qc1VhYWd0bnA1?=
 =?utf-8?B?b01xNlNFaW1IcnBMN1E5VGpCZFJHTnhWa3dWUkhIbDYrdHdTbWVZSzBLcm9J?=
 =?utf-8?B?UlNKc0djSFZUTlBMUDhXMjRScmtWRXJjV3VUS09mdzFhdjZJbzY0S2tSYjVu?=
 =?utf-8?B?REhyQ0tBdkY4QUpsNzlwdGs5Y0xRQ2pwV2VCZXNPcEgydlRCYytUK05yZUlz?=
 =?utf-8?B?ZkRYYk9RcURZaUdwUGpWeTNZTXhNbkJjQVY5MDF1RVVYT3VCeFlHRnliUW1u?=
 =?utf-8?B?citPSXF1Wk95U2pEQVp6aDV5dGtyTE5GRDVLeTJFcm5XL3E5YVVjSC9xb3V1?=
 =?utf-8?B?UXhQbjVrMjRBUDZ1elBMeFFSTURuT0JINHUyZDZ3K0xJR0FRcFJqRkN0Mkpa?=
 =?utf-8?B?ZndXQndOamdHTGt1a3JTOUFMakN1c1AweVpyYll6UENMbzN3MVFFdTZFUUlq?=
 =?utf-8?Q?fI9eSEpUr/wR2zHrrdZdsXwpXHHVYbcBXyhmZgSPkpMYx?=
x-ms-exchange-antispam-messagedata-1: l2TvlZvym2whqBs70GD7/rBHGjgk5E9MX1U=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECB9DDE4942C7A48A6EDC30C0A0D3AD7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: H8+HpR8jMMaDMy3kGF7mFOQcJMj79I0L5CetS+ICWEohftLAo5/tXbcr2jzaINBQgjbUsWUDEbFQyGMZ4Sq8wlT4jsz4KjW34uOsWFZtskHKVPG3lwixzPvI0trg0aDMeHLy69nxHnupiRyH6dY0A96xHTjmV4Wa1hhpqYXLxShieBT5fb7Zis2csbt2e4ODC9rfBzRG7pkW8jx6+41AYovy6bu89ASf0eL3x3FP0yf+UBg0Kiy1UIMeCatnPkb4iNZIbuv8RYT19xNwLdLpU/u+4XE5Xqv4OihRP6SrTuPFsByKmmtJ9MH+Ot0jq3deRTxIFJamDCdyquEr1vbbQQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d91e09d-665d-4d19-a560-08de973c7625
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2026 20:05:06.8649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NbUR13X7glwi7NGozNlWxZKioInCY2L7i3BSYvnKPdIjuyfbR73ierqV+A9Ud1iao4nh93ipw7Rxg2xkPNNvog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6907
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA0LTEwIGF0IDIwOjAxICswMDAwLCBzYXNoaWtvLWJvdEBrZXJuZWwub3Jn
IHdyb3RlOg0KPiBTYXNoaWtvIEFJIHJldmlldyBmb3VuZCAxIHBvdGVudGlhbCBpc3N1ZShzKToN
Cj4gLSBbTWVkaXVtXSBUaGUgYnJhbmNoIGNvdW50ZXIgY29sdW1uIGlzIG5vdyBlbmFibGVkIGlu
IHN0YW5kYXJkIHN0ZGlvDQo+IG1vZGUgd2hlcmUgaXQgY2Fubm90IGJlIHBvcHVsYXRlZCwgcmVz
dWx0aW5nIGluIGEgdXNlbGVzcyBlbXB0eQ0KPiBjb2x1bW4gaW4gdGhlIG91dHB1dC4NCj4gLS0N
Cj4gDQo+IGNvbW1pdCBhZmQ0MjRhMzQyNTVmY2Q1NTg3MjQ2Y2FhNjA2NTYwYmM5YjkxNmM4DQo+
IEF1dGhvcjogVGhvbWFzIEZhbGNvbiA8dGhvbWFzLmZhbGNvbkBpbnRlbC5jb20+DQo+IA0KPiBw
ZXJmL2Fubm90YXRlOiBGaXggbWlzc2luZyBicmFuY2ggY291bnRlciBjb2x1bW4gaW4gVFVJIG1v
ZGUNCj4gDQo+IFRoaXMgY29tbWl0IG1vdmVzIHRoZSBjaGVjayBmb3IgZW5hYmxpbmcgdGhlIGJy
YW5jaCBjb3VudGVyIGNvbHVtbg0KPiBpbnRvDQo+IF9fY21kX2Fubm90YXRlKCkgc28gaXQgb2Nj
dXJzIGFmdGVyIGV2ZW50cyBoYXZlIGJlZW4gcHJvY2Vzc2VkIGFuZA0KPiB0aGUNCj4gY291bnRl
ciBpcyB1cGRhdGVkLg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi9idWlsdGluLWFu
bm90YXRlLmMgYi90b29scy9wZXJmL2J1aWx0aW4tDQo+ID4gYW5ub3RhdGUuYw0KPiA+IGluZGV4
IDVlNTdiNzg1NDhmNDIuLjdmZTIzYjA1MzA2ZjggMTAwNjQ0DQo+ID4gLS0tIGEvdG9vbHMvcGVy
Zi9idWlsdGluLWFubm90YXRlLmMNCj4gPiArKysgYi90b29scy9wZXJmL2J1aWx0aW4tYW5ub3Rh
dGUuYw0KPiA+IEBAIC01NjMsNiArNTYzLDkgQEAgc3RhdGljIGludCBfX2NtZF9hbm5vdGF0ZShz
dHJ1Y3QgcGVyZl9hbm5vdGF0ZQ0KPiA+ICphbm4pDQo+ID4gwqAJaWYgKHJldCkNCj4gPiDCoAkJ
Z290byBvdXQ7DQo+ID4gwqANCj4gPiArCWlmIChzZXNzaW9uLT5ldmxpc3QtPm5yX2JyX2NudHIg
PiAwKQ0KPiA+ICsJCWFubm90YXRlX29wdHMuc2hvd19icl9jbnRyID0gdHJ1ZTsNCj4gPiArDQo+
IA0KPiBXaWxsIHRoaXMgY2F1c2UgYW4gZW1wdHkgYnJhbmNoIGNvdW50ZXIgY29sdW1uIHRvIGJl
IGRpc3BsYXllZCBpbg0KPiBzdGFuZGFyZA0KPiBzdGRpbyBtb2RlPw0KDQpPb3BzLCB0aGlzIHdh
cyBhbiBvbGRlciB2ZXJzaW9uLCBJJ2xsIHJlc2VuZCB3aXRoIGFuIHVwZGF0ZWQgb25lLg0KDQpU
aGFua3MsDQpUb20NCg0KPiANCj4gVGhlIG9yaWdpbmFsIGNvZGUgcmVzdHJpY3RlZCB0aGlzIGNo
ZWNrIHRvIFRVSSBhbmQgc3RkaW8yIG1vZGVzIHdoZXJlDQo+IHVzZV9icm93c2VyID09IDEgb3Ig
YW5ub3RhdGUudXNlX3N0ZGlvMiBpcyB0cnVlLiBCeSBtb3ZpbmcgdGhlDQo+IGFzc2lnbm1lbnQN
Cj4gaGVyZSwgaXQgYmVjb21lcyB1bmNvbmRpdGlvbmFsLg0KPiANCj4gSW4gc3RhbmRhcmQgc3Rk
aW8gbW9kZSwgcHJvY2Vzc19icmFuY2hfY2FsbGJhY2soKSBpcyBza2lwcGVkIHdoZW4NCj4gYWRk
aW5nDQo+IHNhbXBsZXMsIHNvIGJyYW5jaCBzdGFjayBkYXRhIGlzIG5vdCBhZ2dyZWdhdGVkIGlu
dG8gdGhlIGFubm90YXRpb24NCj4gbm90ZXMuDQo+IFRoaXMgbGVhdmVzIHRoZSBjb3VudGVyIGRh
dGEgYXQgMCBmb3IgYWxsIGluc3RydWN0aW9ucy4gQ291bGQgdGhpcw0KPiByZXN1bHQNCj4gaW4g
dGhlIG91dHB1dCByZW5kZXJpbmcgdGhlIGNvbHVtbiB0aXRsZSBidXQgcHJpbnRpbmcgb25seSBl
bXB0eQ0KPiBzcGFjZXMgZm9yDQo+IGFsbCB0aGUgcm93cz8NCj4gDQo+IFsgLi4uIF0NCj4gDQo+
ID4gQEAgLTkyOCw4ICs5MzEsNiBAQCBpbnQgY21kX2Fubm90YXRlKGludCBhcmdjLCBjb25zdCBj
aGFyICoqYXJndikNCj4gPiDCoAkgKi8NCj4gPiDCoAlpZiAoKHVzZV9icm93c2VyID09IDEgfHwg
YW5ub3RhdGUudXNlX3N0ZGlvMikgJiYNCj4gPiBhbm5vdGF0ZS5oYXNfYnJfc3RhY2spIHsNCj4g
PiDCoAkJc29ydF9fbW9kZSA9IFNPUlRfTU9ERV9fQlJBTkNIOw0KPiA+IC0JCWlmIChhbm5vdGF0
ZS5zZXNzaW9uLT5ldmxpc3QtPm5yX2JyX2NudHIgPiAwKQ0KPiA+IC0JCQlhbm5vdGF0ZV9vcHRz
LnNob3dfYnJfY250ciA9IHRydWU7DQo+ID4gwqAJfQ0KPiA+IMKgDQo+ID4gwqAJaWYgKHNldHVw
X3NvcnRpbmcoLypldmxpc3Q9Ki9OVUxMLA0KPiA+IHBlcmZfc2Vzc2lvbl9fZW52KGFubm90YXRl
LnNlc3Npb24pKSA8IDApDQo+IA0KDQo=
