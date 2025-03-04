Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180F42780FD;
	Tue,  4 Mar 2025 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107007; cv=fail; b=U38Ez1o5GRbTHJdnbuTKxhOiWIXyeR8GjFfIeKqWp3fMjncXtZvjLExaf+9xXJlcDNXur7LhHYxryozbC1tFQcLtVInZ6pvB7VWGPrGWyKUjMSWcw8lYNAnanBcQr9c49wLqJ4qtK+34jtlkiaS38A5Eh+iT3PRW88kMTI3fzn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107007; c=relaxed/simple;
	bh=roUzBXq36qnP3laOYNwUhRLbHQgDGi417AA/m04HXsc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HWeTP8zbjf+6/5zkUd6wja+P8Vpp04DrA5/5uB+lQXSPaKI9VdU9ylhV6tMuj79ZhTFmUypKwKbWr9rvYLFxohT4qEfmzq6yiJBFVbZMfSgRW9y5yrHhYSWE9VtmtOel/Nwt86U5oZNLpuZI0qTJgeRki11+mbC3rVj5jKVuUME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QmCyJ7oR; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QmCyJ7oR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741107005; x=1772643005;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=roUzBXq36qnP3laOYNwUhRLbHQgDGi417AA/m04HXsc=;
  b=QmCyJ7oR5tMPavyDfyIaK6R45/mjr+ufhE+XuuoVduddaRKR/VHjUful
   2KFP/k0GOQ53o9+ABF4F/sSCiHcZwZwipqv6o35gH9l6vwnebD1Ep6EI3
   LwXj1ofrcqu577EOE1iCUP1PakPdwNDIMoVgVMRY2O7/SxiyKrz7lHJj1
   9/HbPKMRePpIAXPkfG4hY31zfCZtORjBaC1uvRJb9a40vWUWHl2tTS8vg
   zXlKYSGdSITZSO8l2TQkTh2B97Fsfs80cZn2K3et9fMlUOKZUQOAZBB3g
   b0QjXNCYMH9m3X18AJ4ZpFYzArjSHaqxVnWaLobW+sLLGKcbhcY1TKMpc
   w==;
X-CSE-ConnectionGUID: jU4ILN7ITsm/FETQ7OygDg==
X-CSE-MsgGUID: hkgVxuCFQTSb1wkUqVXv0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52676847"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="52676847"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 08:50:04 -0800
X-CSE-ConnectionGUID: tUuQ2P9wRfWPvXlWMyF1pg==
X-CSE-MsgGUID: szQ4TxfxTUGurCjljcH2Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123629644"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 08:50:04 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Mar 2025 08:50:03 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 08:50:03 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 08:50:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VvPcIr7D+S03/S0Znt6AZQw/XXf3S+Gkp2wwpw8ZrDrTp2d/TO5+zYWzayEAntkhTK3RokvsCeseTROmnCqfANj2GtMbWdekmne4DLn2h+mg6aZ5uX9yFdycN/MYjU8lxx42vt6bl+ZKB734F1tqPaxOKm8p6keRRFBa1mnq6ffCi7hg+vn0F+G4Ew5yi7LE4YNrpubyXbqGrs57/xJjs5O1dYfiQoIt9DIYxmNizDaxNhBh6ydW0yTxBOS89TMde3IsdknRymsu8afVZ+mCilVPBOUaQEPUB6o+yX9BzkaElOx+npffqbpORJNkrg3Q+BlvPvhlzk8U14oJTHZMzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roUzBXq36qnP3laOYNwUhRLbHQgDGi417AA/m04HXsc=;
 b=HqQAe4wW4dMWSbpVGaQQtou6mrMziAuSeXqsDhz9p6AamM4YR60np/AN1ExcSb3zGD3Qv/Ga8Iq1X/0YtqACuWheQQbNoV9bUKnAzxD9lAWMoDObzBysGF7YLjAgfC1MMya0mebMhjH1eUsOpFAwB1EyXKVu/ssJrKOjdLX0Dt3V703kZqpv/S/YrFtnxNIXvjCC3r7kaETTrC7LQRJDhIAiMdXUHcBkDs7uLj3lHsVKs6VGHw/OwfMf5R4o68pN/QZRICLAdKXf7HhqxrJ4ZRqSgdNgFf1iwekSBm/EtIQQL+s1Mt9RJMMzkx2830omtdY2j+1qIlH0lfPnfzus5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by DS0PR11MB7831.namprd11.prod.outlook.com (2603:10b6:8:de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 16:50:00 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 16:50:00 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org"
	<acme@kernel.org>, "dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"irogers@google.com" <irogers@google.com>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "Mi,
 Dapeng1" <dapeng1.mi@intel.com>
Subject: Re: [PATCH 2/2] perf tools/tests: Fix topdown groups test on hybrid
 platforms
Thread-Topic: [PATCH 2/2] perf tools/tests: Fix topdown groups test on hybrid
 platforms
Thread-Index: AQHbhl2kUDw7dZktxkGCjdzIK6yFObNjPjOA
Date: Tue, 4 Mar 2025 16:50:00 +0000
Message-ID: <b9a0773abd2ee44ba1d91596a82633fe999f35c4.camel@intel.com>
References: <20250224083306.71813-1-dapeng1.mi@linux.intel.com>
	 <20250224083306.71813-2-dapeng1.mi@linux.intel.com>
In-Reply-To: <20250224083306.71813-2-dapeng1.mi@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|DS0PR11MB7831:EE_
x-ms-office365-filtering-correlation-id: 6b09c53c-e970-42e0-7b54-08dd5b3c9a75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?VXdhdnFzcTNhWEFwY1lHZUZNU0JjSFg4Y0E4Vy8rUERxc1hVTVNGengyemw4?=
 =?utf-8?B?aFE1TlFkMjFqY0JsSlVlWlNqQnFnNjN0YUxZRnpCLy9QNEtjbnNoendzMGw5?=
 =?utf-8?B?NTdIeGd5b0YxekhsWjFjZEZGdlNwRzlob3BJVzdDbGVSbjJUUDF1NFlsdGo4?=
 =?utf-8?B?bVVDcWNSZHNIY0FCSVM4TEJoRUNWSDFjajB2T0Z4UFRaTjNZNGhna2pUVHEv?=
 =?utf-8?B?YlZCMnZEdEcxU1JITVBjL2Zic3FZMUl6a0lXM0IvSlZ3RFVXckkwUXpxS21z?=
 =?utf-8?B?WlBOR0FpeHVuMVB6dW9KMFVVSThza3JpM2d3MFhWYnM3K3FtNEhubkordVhx?=
 =?utf-8?B?MHJJQjdvSDRnUkhKdkpyNmlTL2ZQb0tPU2Jyb0hDeXRqb0hlMmlkUHVXQndO?=
 =?utf-8?B?Rm1KM2Uwdm92ZWdycE5pN1EwTFE5MC9xd2lTdThmalBYSGN1aHVURXpkL3BB?=
 =?utf-8?B?ZzZ6aDR3Wm9YeHliRTlQRzFzVVBlanVSNENpYWVtaEVHT0EydTRVWmZZaVpW?=
 =?utf-8?B?K05jeTZqMlM5L05wTmpQOWsydVg3R2RVYUtOb002ekN0bEFlekFEcXc5SkM0?=
 =?utf-8?B?RmJ3SHRWNzFFOEF2eU5iRkRvRU5jeUJnMWtGbGRvRUZpb3NMWjBUbC9WN1Ni?=
 =?utf-8?B?RW9CWDk2OHhuM0o2VnExRUNQNmNzRmNXZDZLRjBITld6aE1MOVJxdytOSlFk?=
 =?utf-8?B?OTE5ZzJzQlVGRWtXUHBLbXM1djhuZFZzait4NGUyVjk0ekVxWVhDOFZNa0Nw?=
 =?utf-8?B?SWpQQmJHU1ZvYjkveSswSkd5YkR3SzkyckFUNVVGSUt2Qk5mcGNxNFF1S2FI?=
 =?utf-8?B?NTFDdWRDUzI2TFhjOEN1Rk01NnBPbUhUWDB6ZHlqTnhWQlVCVU1PNUNGa0pq?=
 =?utf-8?B?dnI5WEFqbElTZmJKK0s3RUl0NTlFdTB3TDNRQ2t6dkxOUjVDZlRySmJMTWhW?=
 =?utf-8?B?TlhPbUd4Q3B3a2tIL21mZkRUYXRJam5HUmtGaXpqdEZTeGRGQUowdzhxRDlt?=
 =?utf-8?B?ajZIaGFqcmpjWUZOWGpkRzFCRWJwSEpFb1Bocm1jcEl1OXlPL21kWjVKemQx?=
 =?utf-8?B?K3VnRGpHSmx3QVgwbmNUL1k1eW93dmwzbmRyMzd5cDdCTExJNmxWcWdIQW1h?=
 =?utf-8?B?WHgrMG1laFNWODcvZ3JrS201ZDZGZElZYk90N2NaTk5GdkpHQ0JjcmlUbE9O?=
 =?utf-8?B?dXFmLzZQOENNTG9lVGprMTNzY2ZlTGdITFlMenVGZEtJcERNSnh5ZllwUEEv?=
 =?utf-8?B?eUx1bkEzSkJIdlhtQU1uT0J3Y3BLK0hBVHJrd1RGcERiOUprS0lrbHRvZ0Ni?=
 =?utf-8?B?czN0SkxEYnI1S0hjQ3ZRclV6bVBvUC9kQjg4eStqZ3dubk1EOXcwTmFOOVNh?=
 =?utf-8?B?Y2piSXI3Z2JEeEdFaEJncXhzc1JsK1gyZGk0WElHQThwanRrb0lLMFA3RmVO?=
 =?utf-8?B?OWtDVzBkWVZZdXg5R0RPeHhtR3NsbzI4WXE0dkFDRHIyQXN0VXprV0ticTZn?=
 =?utf-8?B?UkJ2ci84UmZCRGJqbnRaTlBCSDlVV2haMEZpOWdrbWNCWkFTaTBrSU9PWkYv?=
 =?utf-8?B?U3NBZnc2VWQ1YXBOSUNPOTAxWTN2NTc0azRHZGVlUEJOSGk2ajd6T2JTak5h?=
 =?utf-8?B?aVU0SENNU3FZZGFYVXNjaTQ5OGhHWkhyR3FOa01VdVdSZDlyVmt5MTZMd052?=
 =?utf-8?B?Q21vVGc2KzNuQlNpTDNUWTNUbUk2OXlhYUVnYTNWL1YrQ1MwbmdsS09RK245?=
 =?utf-8?B?MzcwUFE5TVFiU3FFdktmUTE4VTR2a1JYOVJPUmpsT3U2U0tTU0krT1RFcW1Y?=
 =?utf-8?B?WVc4T2p2UmhJaEVzQzFXNFZISHMzN050YnV0ZVVqdDRseXUzVzVjUzNlMHU2?=
 =?utf-8?B?TnI0b2F4R1gzQXF2THNGREN5ZWY3WlBpUzhqOEdObHFBb0lUYW9mRks5bXV5?=
 =?utf-8?B?cUV4alczYk1GVmFqMDVWUk9LdDN4VjJZc1ljWG1JbTRlM3NVZ0hyNG9YZ1No?=
 =?utf-8?B?S2s5aXJ3bTdRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlBDMFgwWjJaWFNkWnpOdVgxUkFZcWJXa1QybExSNFJ5ZEhncER6QmQwV2k2?=
 =?utf-8?B?NlJYWnF1TUt5RnpJV1RPb2pkZlJYWXhCQ2NEbFc4ZjNNdWZ6dW8wZnZudWJF?=
 =?utf-8?B?ZTRDeldJS1luaXI5WWlnck9yZUl1ZUhVZmcvQTZUUlllSExmdjFoVGVaajEv?=
 =?utf-8?B?anBrazJ1aDNKSFp1SlEyWGJXdit3bTQ3UlE3am9JaXZqWEtaSUV4VWZlVzRC?=
 =?utf-8?B?dVoyamtxN2U0RSswckRGeEJwSmNUbUg0QVZKMURaSmgzaFQ1TE1rTU14M0do?=
 =?utf-8?B?UTVnZzUwOWhtRDZ3SXhUNEJOb29nTlFrU0sxakFhcXRiMEV3dnRoQURXTkhE?=
 =?utf-8?B?U1drTUttb1VaK21ITVh6TEpybC9iSG56MkpyTERyczlYV05heVdLdTlOR0Rx?=
 =?utf-8?B?RDhNOVdUc3RtTHliQ3cwT0xDeEZQeU15UDMrV3RvZEtJTFRZN3dGUU5ObzBl?=
 =?utf-8?B?OG9xcUFKSjRra2FSL3VDKzVHWWh1TVM2am8yVjVRZUh6Y0ZNb3lKS3FPd2lG?=
 =?utf-8?B?OUxQY1ZTb1E4RW4xU1ZpeFVjZ2dtOUt4TzFnNUFmNWxsR2J6LzRjc1RDaVo5?=
 =?utf-8?B?a0w2ZkxuTUlib0ZFYzFlaEZPNlBORlQySjVxWDdZN2t2THRLN25mcVViWUlu?=
 =?utf-8?B?NmJjN1pIeTh2Q2FTWUJ2TW5LcEFveVlndElVUmV5bytzZEpSRkRaYUtCbHdR?=
 =?utf-8?B?SUk5UVRvdXZJazFKbWZCeGRsUTZ5dTBoc0ZJMUdEMmV2U3l0aE9lY2ExbW9Q?=
 =?utf-8?B?TXdmM3ludUFxU1hnYkg3RC9sNUI5WDRKZkV4cEhkWXhSUEZNdVlaQUVNVGND?=
 =?utf-8?B?bDVFZVpSd042YktlMFFZMlo5aFdVT3ZSZEVsTHR2T0RRYVBMQ2I3Z21XWFdC?=
 =?utf-8?B?cFhidjhneHJtQzFlcCtMU3d5TXpkaXB2cnFuTTBiYkJWWWVSdEdTVEM1T2Vr?=
 =?utf-8?B?c2laLzlYZlJtOVFSQ0tmdmRuRURJL0NybzZEWVlLRnphczZMamI0dTBWUEN6?=
 =?utf-8?B?ZWV0QjFsS3A1T1RweXhkazcyZjR6VUZtZHU5Sm15K1F1akM0WkJkejRIUmtj?=
 =?utf-8?B?MjJ4Y3V2bXBNOW5RM2VyRVk3THhMTlpUVDh3dDdIclZacnJ1cTd5Y00xcHRG?=
 =?utf-8?B?YThuNXEwU1NNM2hZa2dianBrL253UEFBUFVhRktLTVg3WWt6bncwUU1oam1p?=
 =?utf-8?B?eWdQdWhncXU4YS9MRFRZbTFaNURtbkNVRjRoS01MVTkxVWtGOUhRMTMydjNk?=
 =?utf-8?B?SW8zZmxNbUkzbldDQm90bFN0d3U0RE80RXFRV2wyWktqQW9WYk1ST2grdWp4?=
 =?utf-8?B?UTVjdVpScWRNazEyYmFMaTBnQzlIWkRXbWFxemF4QzFtUzZkaW9VREhIMlZs?=
 =?utf-8?B?bnRwdERwVHo4eU5RWjdScjlWcnhyMEtSdTBVYklPZURuNkdDRjRFZ3hmbEp0?=
 =?utf-8?B?b0NOVDZ3U1JNZXhNcHVEUDB0M0lzRk5zQUJSN3NlNzB2REIzaU1WbXd2QnRr?=
 =?utf-8?B?QnFCc04rd2RNOTd2aG52WGQzeEhMUTExcU5vVU9XMzc4OTg4N2YzNW44U2k0?=
 =?utf-8?B?T3Q5YUxQTkl3TTFiVXdubnVpdUpRMlJiaXRYK2d1L2NqY0FaTGdLK3NMWndH?=
 =?utf-8?B?QWUxM3JPa3VkY0grcXZFa2llMGduR05PenoyWTBPU3BnOFVzOEhHelpyMjNn?=
 =?utf-8?B?SmNpSERPdE9JOWpadzl0Y1RGZDJYbEhKTjV1VHAreC9HeW1DbDR1bVNpM0dZ?=
 =?utf-8?B?T1FLbTh5WExTbzRLTHZuUHpVWk1qSDZqU1F5R292RVZlMkxIaHJqSER2TmpL?=
 =?utf-8?B?OFFSb3QzWkR4ajllbFcwV2p4VG9uSGxpRTRkLzJvVUJ2VUp1R2JMQ1V2TVJO?=
 =?utf-8?B?bk1IcHRwa3JzMVErcWJ1RjdwMlZERVhUWWNzbFdrVmJpRndGQkpVQW9Gcnpo?=
 =?utf-8?B?R3FkQ1A3Ymx1VE9EQkk1RmRWdm5INVdwSjdOa0k2cVdKR2lFQlBkZmxQZm1r?=
 =?utf-8?B?d083WGtPbzNWallRTGI1NkRhN1NLRjdmSEplOVV3cHdpVElqOVlvUndhdHc0?=
 =?utf-8?B?a0k0bThwbnJydVRQdDd3Q2tqZ1NKU1p5S1dWaEV4c2hiTUpxRXc4citsa0VY?=
 =?utf-8?B?eVoxdkZUSUU1Um5zSnBDL0ZZTVQvakVnRjlGVi9yWVliR2REVWpuMzBTaHFa?=
 =?utf-8?Q?aUyv9RXXrlK23cwG5ZQGEXo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CD559D56F84EE4194AA60E91AF94A52@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b09c53c-e970-42e0-7b54-08dd5b3c9a75
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 16:50:00.3896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJ32IL5PLV9vwEPQta4E+uLRBKl+9SWyeV2ynrlh2etdxzAf4Ua87T10ZRUYAAIRVq628OKWgER6+GTAjklDug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7831
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTAyLTI0IGF0IDA4OjMzICswMDAwLCBEYXBlbmcgTWkgd3JvdGU6DQo+IFdo
ZW4gcnVubmluZyB0b3Bkb3duIGdyb3VwcyB0ZXN0IG9uIGh5YnJpZCBwbGF0Zm9ybXMgbGlrZSBM
TkwvQVJMLCB3ZQ0KPiBzZWUgdGhlIGZvbGxvd2luZyAyIGNvbW1hbmRzIGZhaWwuDQo+IA0KPiBw
ZXJmIHN0YXQgJGNwdXR5cGUgLWUgJ3tpbnN0cnVjdGlvbnMsc2xvdHN9LHRvcGRvd24tcmV0aXJp
bmcnIHRydWUNCj4gcGVyZiBzdGF0ICRjcHV0eXBlIC1lICd7aW5zdHJ1Y3Rpb25zLHNsb3RzfSx7
dG9wZG93bi1yZXRpcmluZ30nIHRydWUNCj4gDQo+IFRha2UgdGhlIDFzdCBjb21tYW5kIGFzIGFu
IGV4YW1wbGUsIDUgZXZlbnRzIGFyZSBjcmVhdGVkIG9uIGh5YnJpZA0KPiBwbGF0Zm9ybS4gVGhl
eSBhcmUgY3B1X2F0b20vaW5zdHJ1Y3Rpb25zLywgY3B1X2NvcmUvaW5zdHJ1Y3Rpb25zLywNCj4g
Y3B1X2NvcmUvc2xvdHMvLCBjcHVfYXRvbS90b3Bkb3duLXJldGlyaW5nLyBhbmQNCj4gY3B1X2Nv
cmUvdG9wZG93bi1yZXRpcmluZy8gZXZlbnRzLiBUaGUgZm9ybWVyIDMgZXZlbnRzIGFyZSBpbiBh
IGdyb3VwDQo+IGFuZCB0aGUgbGF0dGVyIDIgdG9wZG93bi1yZXRpcmluZyBldmVudHMgYXJlIGlu
ZGVwZW5kZW50IGV2ZW50cy4NCj4gDQo+IEFzIHRoZSBsaW1pdGF0aW9uIG9mIGN1cnJlbnQgaW1w
bGVtZW50YXRpb24sIHRoZQ0KPiBjcHVfY29yZS90b3Bkb3duLXJldGlyaW5nLyBldmVudCBjYW4n
dCBiZSBtb3ZlZCBpbnRvIHByZXZpb3VzIGdyb3VwDQo+IGFzDQo+IGxvbmcgYXMgdGhlcmUgYXJl
IG90aGVyIGV2ZW50cyBiZWZvcmUgaXQuIFRoYXQncyB0aGUgcmVhc29uIHdoeSB3ZQ0KPiBzZWUN
Cj4gdGhlIGZhaWx1cmUuDQo+IA0KPiBUaHVzIGFkZCAiLS1jcHV0eXBlIGNvcmUiIG9wdGlvbiB0
byBsaW1pdCBvbmx5IFAtY29yZSBldmVudHMgYXJlDQo+IHRlc3RlZC4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IERhcGVuZyBNaSA8ZGFwZW5nMS5taUBsaW51eC5pbnRlbC5jb20+DQoNClRlc3RlZC1i
eTogVGhvbWFzIEZhbGNvbiA8dGhvbWFzLmZhbGNvbkBpbnRlbC5jb20+DQoNCj4gLS0tDQo+IMKg
dG9vbHMvcGVyZi9hcmNoL3g4Ni91dGlsL2V2bGlzdC5jIHwgMjYgKysrKysrKysrKysrKysrKysr
KysrKystLS0NCj4gwqB0b29scy9wZXJmL3Rlc3RzL3NoZWxsL3N0YXQuc2jCoMKgwqAgfCAyMCAr
KysrKysrKysrKysrKysrKystLQ0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgNDEgaW5zZXJ0aW9ucygr
KSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90b29scy9wZXJmL2FyY2gveDg2
L3V0aWwvZXZsaXN0LmMNCj4gYi90b29scy9wZXJmL2FyY2gveDg2L3V0aWwvZXZsaXN0LmMNCj4g
aW5kZXggNDQ3YTczNGU1OTFjLi4wYTcxYmE5NzU4NzEgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3Bl
cmYvYXJjaC94ODYvdXRpbC9ldmxpc3QuYw0KPiArKysgYi90b29scy9wZXJmL2FyY2gveDg2L3V0
aWwvZXZsaXN0LmMNCj4gQEAgLTksNyArOSw3IEBAIGludCBhcmNoX2V2bGlzdF9fY21wKGNvbnN0
IHN0cnVjdCBldnNlbCAqbGhzLCBjb25zdA0KPiBzdHJ1Y3QgZXZzZWwgKnJocykNCj4gwqB7DQo+
IMKgCS8qDQo+IMKgCSAqIEN1cnJlbnRseSB0aGUgZm9sbG93aW5nIHRvcGRvd24gZXZlbnRzIHNl
cXVlbmNlIGFyZQ0KPiBzdXBwb3J0ZWQgdG8NCj4gLQkgKiBtb3ZlIGFuZCByZWdyb3VwIGNvcnJl
Y3RseS4NCj4gKwkgKiBtb3ZlIGFuZCByZWdyb3VwIGNvcnJlY3RseSBvbiBub24taHlicmlkIHBs
YXRmb3Jtcy4NCj4gwqAJICoNCj4gwqAJICogYS4gYWxsIGV2ZW50cyBpbiBhIGdyb3VwDQo+IMKg
CSAqwqDCoMKgIHBlcmYgc3RhdCAtZSAie2luc3RydWN0aW9ucyx0b3Bkb3duLXJldGlyaW5nLHNs
b3RzfSIgLQ0KPiBDMCBzbGVlcCAxDQo+IEBAIC00NCw3ICs0NCw3IEBAIGludCBhcmNoX2V2bGlz
dF9fY21wKGNvbnN0IHN0cnVjdCBldnNlbCAqbGhzLCBjb25zdA0KPiBzdHJ1Y3QgZXZzZWwgKnJo
cykNCj4gwqAJICogdG9wZG93biBtZXRyaWNzIGV2ZW50cyBtdXN0IGJlIGZpcnN0IGV2ZW50IGFm
dGVyIHRoZQ0KPiBzbG90cyBldmVudCBncm91cCwNCj4gwqAJICogb3RoZXJ3aXNlIHRvcGRvd24g
bWV0cmljcyBldmVudHMgY2FuJ3QgYmUgcmVncm91cGVkDQo+IGNvcnJlY3RseSwgZS5nLg0KPiDC
oAkgKg0KPiAtCSAqIGEuIHBlcmYgc3RhdCAtZSAie2luc3RydWN0aW9ucyxzbG90c30sY3ljbGVz
LHRvcGRvd24tDQo+IHJldGlyaW5nIiAtQzAgc2xlZXAgMQ0KPiArCSAqIGUuIHBlcmYgc3RhdCAt
ZSAie2luc3RydWN0aW9ucyxzbG90c30sY3ljbGVzLHRvcGRvd24tDQo+IHJldGlyaW5nIiAtQzAg
c2xlZXAgMQ0KPiDCoAkgKsKgwqDCoCBXQVJOSU5HOiBldmVudHMgd2VyZSByZWdyb3VwZWQgdG8g
bWF0Y2ggUE1Vcw0KPiDCoAkgKsKgwqDCoMKgIFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9y
ICdDUFUocykgMCc6DQo+IMKgCSAqwqDCoMKgwqDCoMKgwqDCoCAxNyw5MjMsMTM0wqDCoMKgwqDC
oCBzbG90cw0KPiBAQCAtNTYsMTEgKzU2LDMxIEBAIGludCBhcmNoX2V2bGlzdF9fY21wKGNvbnN0
IHN0cnVjdCBldnNlbCAqbGhzLA0KPiBjb25zdCBzdHJ1Y3QgZXZzZWwgKnJocykNCj4gwqAJICog
aGFzIHRvcGRvd24gbWV0cmljcyBldmVudHMgbXVzdCBjb250YWluIG9ubHkgdGhlIHRvcGRvd24N
Cj4gbWV0cmljcyBldmVudCwNCj4gwqAJICogb3RoZXJ3aXNlIHRvcGRvd24gbWV0cmljcyBldmVu
dCBjYW4ndCBiZSByZWdyb3VwZWQNCj4gY29ycmVjdGx5IGFzIHdlbGwsIGUuZy4NCj4gwqAJICoN
Cj4gLQkgKiBhLiBwZXJmIHN0YXQgLWUgIntpbnN0cnVjdGlvbnMsc2xvdHN9LHt0b3Bkb3duLQ0K
PiByZXRpcmluZyxjeWNsZXN9IiAtQzAgc2xlZXAgMQ0KPiArCSAqIGYuIHBlcmYgc3RhdCAtZSAi
e2luc3RydWN0aW9ucyxzbG90c30se3RvcGRvd24tDQo+IHJldGlyaW5nLGN5Y2xlc30iIC1DMCBz
bGVlcCAxDQo+IMKgCSAqwqDCoMKgIFdBUk5JTkc6IGV2ZW50cyB3ZXJlIHJlZ3JvdXBlZCB0byBt
YXRjaCBQTVVzDQo+IMKgCSAqwqDCoMKgIEVycm9yOg0KPiDCoAkgKsKgwqDCoCBUaGUgc3lzX3Bl
cmZfZXZlbnRfb3BlbigpIHN5c2NhbGwgcmV0dXJuZWQgd2l0aCAyMg0KPiAoSW52YWxpZCBhcmd1
bWVudCkgZm9yDQo+IMKgCSAqwqDCoMKgIGV2ZW50ICh0b3Bkb3duLXJldGlyaW5nKQ0KPiArCSAq
DQo+ICsJICogRm9yIGh5YnJpZCBwbGF0Zm9ybXMsIHRoZSBzZXF1ZW5jZXMgJ2MnIGFuZCAnZCcg
YXJlIG5vdA0KPiBzdXBwb3J0ZWQgYXMgd2VsbA0KPiArCSAqIGJlc2lkZXMgYWJvdmUgc2VxdWVu
Y2VzICdlJyBhbmQgJ2YnLg0KPiArCSAqDQo+ICsJICrCoMKgwqAgcGVyZiBzdGF0IC1lICJ7aW5z
dHJ1Y3Rpb25zLHNsb3RzfSx0b3Bkb3duLXJldGlyaW5nIiAtDQo+IEMwIHNsZWVwIDENCj4gKwkg
KsKgwqDCoCBwZXJmIHN0YXQgLWUgIntpbnN0cnVjdGlvbnMsc2xvdHN9LHt0b3Bkb3duLXJldGly
aW5nfSINCj4gLUMwIHNsZWVwIDENCj4gKwkgKg0KPiArCSAqIE9uIGh5YnJpZCBwbGF0Zm9ybXMg
ZWFjaCBldmVudCB3b3VsZCBjcmVhdGUgYW4gaW5zdGFuY2UNCj4gb24gYWxsIHR5cGVzIG9mIFBN
VQ0KPiArCSAqIGlmIHRoZSBldmVudCBjYW4gYmUgc3VwcG9ydGVkIGJ5IHRoZSBQTVUsIGkuZS4s
IHRoZQ0KPiAidG9wZG93bi1yZXRpcmluZyIgZXZlbnQNCj4gKwkgKiB3b3VsZCBjcmVhdGUgdHdv
IGluc3RhbmNlcyBvbiBoeWJyaWQgcGxhdGZvcm1zIHdpdGggUC0NCj4gY29yZXMgYW5kIEUtY29y
ZXMsDQo+ICsJICogImNwdV9jb3JlL3RvcGRvd24tcmV0aXJpbmcvIiBhbmQNCj4gImNwdV9hdG9t
L3RvcGRvd25fcmV0aXJpbmciLg0KPiArCSAqDQo+ICsJICogVGFrZSB0aGUgZmlyc3QgY29tbWFu
ZCBhcyBhbiBleGFtcGxlLCB0aGUgZXZlbnRzIGxpc3QNCj4gd291bGQgYmUgY29udmVydGVkIHRv
DQo+ICsJICogYmVsb3cgbGlzdCBpbiBmYWN0Lg0KPiArCSAqDQo+ICsJICoNCj4gIntjcHVfYXRv
bS9pbnN0cnVjdGlvbnMvLGNwdV9jb3JlL2luc3RydWN0aW9ucy8sY3B1X2NvcmUvc2xvdHMvfSwN
Cj4gKwkgKsKgIGNwdV9hdG9tL3RvcGRvd24tcmV0aXJpbmcvLGNwdV9jb3JlL3RvcGRvd24tcmV0
aXJpbmcvIg0KPiArCSAqDQo+ICsJICogVGhpcyBpcyBhY3R1YWxseSBzYW1lIHdpdGggZXZlbnQg
bGlzdCBpbiBjYXNlICdlJywNCj4gImNwdV9jb3JlL3RvcGRvd24tcmV0aXJpbmcvIg0KPiArCSAq
IGV2ZW50IGNhbid0IGJlIG1vdmVkIGludG8gcHJldmlvdXMgZXZlbnRzIGdyb3VwLg0KPiDCoAkg
Ki8NCj4gwqAJaWYgKHRvcGRvd25fc3lzX2hhc19wZXJmX21ldHJpY3MoKSAmJg0KPiDCoAnCoMKg
wqAgKGFyY2hfZXZzZWxfX211c3RfYmVfaW5fZ3JvdXAobGhzKSB8fA0KPiBhcmNoX2V2c2VsX19t
dXN0X2JlX2luX2dyb3VwKHJocykpKSB7DQo+IGRpZmYgLS1naXQgYS90b29scy9wZXJmL3Rlc3Rz
L3NoZWxsL3N0YXQuc2gNCj4gYi90b29scy9wZXJmL3Rlc3RzL3NoZWxsL3N0YXQuc2gNCj4gaW5k
ZXggNjgzMjNkNjM2ZmI3Li5jZGZlMjdjMjU1MjggMTAwNzU1DQo+IC0tLSBhL3Rvb2xzL3BlcmYv
dGVzdHMvc2hlbGwvc3RhdC5zaA0KPiArKysgYi90b29scy9wZXJmL3Rlc3RzL3NoZWxsL3N0YXQu
c2gNCj4gQEAgLTUsNiArNSwxNiBAQA0KPiDCoHNldCAtZQ0KPiDCoA0KPiDCoGVycj0wDQo+ICtp
c19oeWJyaWQ9ZmFsc2UNCj4gKw0KPiArY2hlY2tfaHlicmlkX3BsYXRmb3JtKCkgew0KPiArwqAg
cG11cz0kKGxzIC9zeXMvYnVzL2V2ZW50X3NvdXJjZS9kZXZpY2VzLyovY3B1cyAyPi9kZXYvbnVs
bCB8IHdjIC0NCj4gbCkNCj4gK8KgIGlmIFsgIiRwbXVzIiAtZ3QgMSBdDQo+ICvCoCB0aGVuDQo+
ICvCoMKgwqAgaXNfaHlicmlkPXRydWUNCj4gK8KgIGZpDQo+ICt9DQo+ICsNCj4gwqB0ZXN0X2Rl
ZmF1bHRfc3RhdCgpIHsNCj4gwqDCoCBlY2hvICJCYXNpYyBzdGF0IGNvbW1hbmQgdGVzdCINCj4g
wqDCoCBpZiAhIHBlcmYgc3RhdCB0cnVlIDI+JjEgfCBncmVwIC1FIC1xICJQZXJmb3JtYW5jZSBj
b3VudGVyIHN0YXRzDQo+IGZvciAndHJ1ZSc6Ig0KPiBAQCAtNjIsNiArNzIsMTEgQEAgdGVzdF90
b3Bkb3duX2dyb3VwcygpIHsNCj4gwqDCoCAjIFRvcGRvd24gZXZlbnRzIG11c3QgYmUgZ3JvdXBl
ZCB3aXRoIHRoZSBzbG90cyBldmVudCBmaXJzdC4gVGVzdA0KPiB0aGF0DQo+IMKgwqAgIyBwYXJz
ZS1ldmVudHMgcmVvcmRlcnMgdGhpcy4NCj4gwqDCoCBlY2hvICJUb3Bkb3duIGV2ZW50IGdyb3Vw
IHRlc3QiDQo+ICvCoCBjcHV0eXBlPSIiDQo+ICvCoCBpZiAkaXNfaHlicmlkDQo+ICvCoCB0aGVu
DQo+ICvCoMKgwqAgY3B1dHlwZT0iLS1jcHV0eXBlIGNvcmUiDQo+ICvCoCBmaQ0KPiDCoMKgIGlm
ICEgcGVyZiBzdGF0IC1lICd7c2xvdHMsdG9wZG93bi1yZXRpcmluZ30nIHRydWUgPiAvZGV2L251
bGwgMj4mMQ0KPiDCoMKgIHRoZW4NCj4gwqDCoMKgwqAgZWNobyAiVG9wZG93biBldmVudCBncm91
cCB0ZXN0IFtTa2lwcGVkIGV2ZW50IHBhcnNpbmcgZmFpbGVkXSINCj4gQEAgLTg1LDEzICsxMDAs
MTMgQEAgdGVzdF90b3Bkb3duX2dyb3VwcygpIHsNCj4gwqDCoMKgwqAgZXJyPTENCj4gwqDCoMKg
wqAgcmV0dXJuDQo+IMKgwqAgZmkNCj4gLcKgIGlmIHBlcmYgc3RhdCAtZSAne2luc3RydWN0aW9u
cyxzbG90c30sdG9wZG93bi1yZXRpcmluZycgdHJ1ZSAyPiYxDQo+IHwgZ3JlcCAtRSAtcSAiPG5v
dCBzdXBwb3J0ZWQ+Ig0KPiArwqAgaWYgcGVyZiBzdGF0ICRjcHV0eXBlIC1lICd7aW5zdHJ1Y3Rp
b25zLHNsb3RzfSx0b3Bkb3duLXJldGlyaW5nJw0KPiB0cnVlIDI+JjEgfCBncmVwIC1FIC1xICI8
bm90IHN1cHBvcnRlZD4iDQo+IMKgwqAgdGhlbg0KPiDCoMKgwqDCoCBlY2hvICJUb3Bkb3duIGV2
ZW50IGdyb3VwIHRlc3QgW0ZhaWxlZCB0b3Bkb3duIG1ldHJpY3MgZXZlbnQgbm90DQo+IG1vdmUg
aW50byBzbG90cyBncm91cF0iDQo+IMKgwqDCoMKgIGVycj0xDQo+IMKgwqDCoMKgIHJldHVybg0K
PiDCoMKgIGZpDQo+IC3CoCBpZiBwZXJmIHN0YXQgLWUgJ3tpbnN0cnVjdGlvbnMsc2xvdHN9LHt0
b3Bkb3duLXJldGlyaW5nfScgdHJ1ZQ0KPiAyPiYxIHwgZ3JlcCAtRSAtcSAiPG5vdCBzdXBwb3J0
ZWQ+Ig0KPiArwqAgaWYgcGVyZiBzdGF0ICRjcHV0eXBlIC1lICd7aW5zdHJ1Y3Rpb25zLHNsb3Rz
fSx7dG9wZG93bi1yZXRpcmluZ30nDQo+IHRydWUgMj4mMSB8IGdyZXAgLUUgLXEgIjxub3Qgc3Vw
cG9ydGVkPiINCj4gwqDCoCB0aGVuDQo+IMKgwqDCoMKgIGVjaG8gIlRvcGRvd24gZXZlbnQgZ3Jv
dXAgdGVzdCBbRmFpbGVkIHRvcGRvd24gbWV0cmljcyBncm91cCBub3QNCj4gbWVyZ2UgaW50byBz
bG90cyBncm91cF0iDQo+IMKgwqDCoMKgIGVycj0xDQo+IEBAIC0yMDAsNiArMjE1LDcgQEAgdGVz
dF9oeWJyaWQoKSB7DQo+IMKgwqAgZWNobyAiaHlicmlkIHRlc3QgW1N1Y2Nlc3NdIg0KPiDCoH0N
Cj4gwqANCj4gK2NoZWNrX2h5YnJpZF9wbGF0Zm9ybQ0KPiDCoHRlc3RfZGVmYXVsdF9zdGF0DQo+
IMKgdGVzdF9zdGF0X3JlY29yZF9yZXBvcnQNCj4gwqB0ZXN0X3N0YXRfcmVjb3JkX3NjcmlwdA0K
DQo=
