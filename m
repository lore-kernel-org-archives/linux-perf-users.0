Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8C3442B06;
	Mon, 31 Aug 2026 17:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788198514; cv=fail; b=h/jFWIzCQurokxUjgEP8/SKnpn7rMEahryVcD8nXYq2DUzgygqKoXLPPv+GbLAywBsY7zGD56vQjjcZ1IleqMYtEvzcZavm4z45WIXBKTxa7WQK8a11XnbcRvrABs4ldKmzfuTJ2LeRvJILpQfR484eNXikBTia6cv2oIUY0pAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788198514; c=relaxed/simple;
	bh=QHufL9SfIquc1jCiPNa3cLqQaHQDRHc5z6hOOUbAFrw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rkXWDWDhCeY+zEkdsiS8I1JOui1Jkf5+oJbzlVgMZNE2xsl/ei2hfnWe6mKYliptFoGaInTw6ynd0I7DetU91Ltlhh1wBQc2VhPXXbgOzm7yCf25VEsEMKu7cl9ce1p8H4/Njwfdnsg9z0FIPvKCriQT0H/oqXWRbDubpz7wZzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X9uW9Z4q; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X9uW9Z4q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788198513; x=1819734513;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QHufL9SfIquc1jCiPNa3cLqQaHQDRHc5z6hOOUbAFrw=;
  b=X9uW9Z4qgqVJyStu7xLSmzsovaVHXZn0qL15kT2moxE0mDGUf1H52oC5
   jz68sJbraTr3VYugwgltrqlIUeHci1dyRLiq+aW3Y/Nfpz6mkzRBiwHvP
   7MKR6c0BaVIV0ILDcxOsd72uJUgHrCLxEfwc5oVegdY1Oo+Oq9uyuqdt3
   1Hm0C/jLYVbEv0SY7P42GFmdwaz+q3ZMwNyB6XrPq8mDuiC/UVaIPozxd
   45llKLgJN1JgPfpHv10Q2n/v2P7E6WjR+BpDec9OPYBg8qLytUNgxuNkD
   6n3VUvLB6sBo48J9iNxxsgHd/ovACu6oUCVF/EbS4t4gcMevOwODz4FKN
   w==;
X-CSE-ConnectionGUID: DWJIH0CWTOqUearUgGEB4w==
X-CSE-MsgGUID: BXIIxrajRxijMFO99kCJPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88663064"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="88663064"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 10:48:32 -0700
X-CSE-ConnectionGUID: 5SXKQG0DTaaFpxECjc2wRQ==
X-CSE-MsgGUID: qIJ2w3YqTr+6OzpE11xdBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="270776647"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 10:48:32 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 10:48:31 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 10:48:31 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.59) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 10:48:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqT+eUUOFjVMjLL1AoXgsZnkU/93gNTVE3FdGr7xgMuEjLZXK7h0FEZDRj0uIksSwx85/6rpFzB69VoClb0cm7PH0NMgIH0eWcZJZig3BmBWH0q4oWglSZW48IuINHQD9Hze4eQRJ7/ekMfXKMx6tkuD46sEpd5pAOjyokbI2/0qk4Rexzn2EOwIkKjko8csMJFyDnN/m3dxhMgKLLWBwunXhSofrddxZFtedNRDAni4Au6cMfzMcDNhuhq3Nila857smjZ47O/OXnrRiGPvXrC5febYSNKLq86coDYXDiwAf1WKgvsErKOcD+ZK4Zt6WL0IPDjOW6tZn4YiQBbo+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHufL9SfIquc1jCiPNa3cLqQaHQDRHc5z6hOOUbAFrw=;
 b=qdUxakChwgdMbPrWRgfK29FcN1LUeuIwMnnYfO4cJqCvYU9rzTbq1OI3FdiRntqna5m+2kymibt9qaOWAlR/w/qLtc/aafD4ripW/cOWR+SgVOSwqbbdVVkpG+8vfBPnnp8PkPeDZroyhW/Ee7pwl3r546H2Mmb8vd1CUusRKH5Lo40ac2pHrf4oEz5qg7bD325JwRskK8lWZIIPp0emoVQT8B8LnR/sdFyCSBPmCHjjtL5vhbu14sGAdOEyS4pGFvNkkjkvVQDHIXG/oQW4OrpRvPQU6x++UThPktkSoe3dHnTZLrgYJlQhqowqeIFNB0usJqs6T5efIZuie92Exw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8040.namprd11.prod.outlook.com (2603:10b6:510:238::11)
 by SJ2PR11MB8452.namprd11.prod.outlook.com (2603:10b6:a03:574::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 17:48:24 +0000
Received: from PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5]) by PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 17:48:24 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "namhyung@kernel.org" <namhyung@kernel.org>
CC: "james.clark@linaro.org" <james.clark@linaro.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"acme@kernel.org" <acme@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>, "Rogers, Ian"
	<irogers@google.com>, "Hunter, Adrian" <adrian.hunter@intel.com>
Subject: Re: [PATCH v5 0/6] perf: Add support for memory region/range
 reporting
Thread-Topic: [PATCH v5 0/6] perf: Add support for memory region/range
 reporting
Thread-Index: AQHdMQKrXgkqglSnWEqSYSbSF2e64La1iX6AgAL2UQA=
Date: Mon, 31 Aug 2026 17:48:23 +0000
Message-ID: <fca9b9654a71ddeeebd8cf05e62a38c2b5cc0762.camel@intel.com>
References: <20260821001819.162277-1-thomas.falcon@intel.com>
	 <apNCR_EvfWuIfhdg@google.com>
In-Reply-To: <apNCR_EvfWuIfhdg@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB8040:EE_|SJ2PR11MB8452:EE_
x-ms-office365-filtering-correlation-id: 71cc350f-3894-47c5-824c-08df07880e17
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|10070799003|366016|38070700021|6133799003|10067099003|5023799004|4143699003|11063799006|18002099003|22082099003|56012099006|3023799007;
x-microsoft-antispam-message-info: s2Sotr1KvcQLwHzEU+OL7BaAnVb1/yOKzKhuN/74XzJGMN5ldO4ulue4+yDaPWc3dbIGXkot8A0XHEv6j+x1bpuZOGRRuQIfTIQ3300GxmjeOJIsTEheC9yq+UAwOpgUdYQhj/i7EDqM+ymfzSOQBfgJ2TtZyU48co5ikRI5Z1TEZPTSLz7meSWWpP9+mAuFI0IiKiJycv46EPFaXP1KO5hy6zUJe/pQLUcohpHemlSl2d5SbPQZ3fujxZIfczuV+/1FtLK9NNKWJBLkzg7jhQnl3p4Mg9berDqcD3jTOX1GaKYqJX1BRvot+urA92FnvpuccsbiErZNdG3jAXDyGCLGP06cp2oCXSag9cKoxXnXV383e5tWTMA6k+CINu48rwbw2NZ4SAjK0TcReP0im1JK2rYoUBCaAJ2w5oq+s2DL2pkKQCqeQUeLCdq5nkUS0/THAyogHs9Sn1eZsF8CcXDXhPmfx+UhK7vUBLXv5RpoYJVsurH58BEyOPfu9+lF1xoQowslwCxQ1PkYPm0KGDck4Wthp6yziCmxGn4rhoq1lSsHWeXt6dJpXpTEDFqpWhXw3l1ON08xiNMQhU17pg2hE5N7S4UJkeGkrdRawxC/ICCoFqfVwxqNHViASEYaLHyLcdmZN38eqP3h6uMGBdrnGUQbaFaFJG37VqAyt4uzkwVQFoAyRXaJqnYU61CYf0gt779jwfJddd2307YDekiQH4cXdI9qFac5Z5Mrd54=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8040.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(10070799003)(366016)(38070700021)(6133799003)(10067099003)(5023799004)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1VFVytpeUZ0T0RGdElDOEs5dXUyb3RFcDNZajR4ZGlQcFRvSDIwNXlIK1h4?=
 =?utf-8?B?UjJ1SHJjYWlFSDRmc2YyRmNqSHJmcnRkL2UwVnUvQnR1emlRTDJUcVVTTXp4?=
 =?utf-8?B?YnVoY2NmU1J6RHVlVnVSeVlMOWZXOGx2UWdRczdzeW51UzRUbmthZm5QQXFZ?=
 =?utf-8?B?bXNxd2FBaWtCb0JBY3Z6UW9PUTB4c0FhUXFpUGhwbFBYVUhEa2lxUC9CTzNM?=
 =?utf-8?B?amVIaklZSFJvVXVGb0U5WktFLzBVSXNSUGljQWZLL094aDN2Y3BDeHdHaGUy?=
 =?utf-8?B?NTM5UndxS081QVFuQ3RJRXlXSmdDV0xQb01YTXdGckhUZEpVdkFrRHVONnFw?=
 =?utf-8?B?YjhpNGpUc2JoUVR5M3ZxY1BnYnZjVzdhYm9QMzU5M0RET1BRWG1pV2JIQzIv?=
 =?utf-8?B?RnYxVW56T0ZVQkhqdUNxTnZrOXRjM2xqMDlrYjkzYTVPWk9oVGU1Z0d2RG5z?=
 =?utf-8?B?RVhvdURjZ3BzcVBtQ3dFSlI5V2dUOE9oTE05Mm4vck5kNHNRMzdpVVRhZjZQ?=
 =?utf-8?B?MElKRk5HS0c5ZTUrK3F4ODZsVzR1S2dYRWxrNjdXSmM2WElOdU9aM0c4bEJ3?=
 =?utf-8?B?Mnhpa21EcllBNjZBaWo2VVhUZVpheDRhckN3RlBxY1B1elVYcGV4aUk1M0c4?=
 =?utf-8?B?QkJ4QjcvTTU1dzNJZ2tQMjN2cHN0U0FZWU91QVdlcmwzNlpsR1J5eXdjY1RM?=
 =?utf-8?B?bTU2VHlEZCtCeG9sSS9VR21kUU9OOURuaTdsQkw5L1hCNDl1OEdjR0U5VXdN?=
 =?utf-8?B?ZGdtWE5aZEVVNnpiVGxqalRmc2VXUitKTWhLWGhhOTNVVEsraXdNRWtleUhv?=
 =?utf-8?B?NGFCaGh2RGl4SWk2UDZtaUtHR2pIUDlNOTdjS00rV0dvVkNvV01hdnA1RkMr?=
 =?utf-8?B?amx4YWdTRC8wbTBERmZXZXFXYkdpbG5ielhhNzdPeVdhaG5LTUoycStSbGF1?=
 =?utf-8?B?WmkxZktta2psQzBPeWRkMmxyWFUwRUFKUVRRNmtPbzZ4ZHBEbnNTdTMwdDd4?=
 =?utf-8?B?OU45MHBkZjZvZkszRmpRWjhMZkRoTTZWTU9acjdQYVBMQUtuSDcrMVJsblFo?=
 =?utf-8?B?cityVkZxS1RyUTRUUUhQK0pGS0RtaU5rQkc1QnE0YU1NS2pGOGVYWTJNb084?=
 =?utf-8?B?d0I0SS90Tzdocnc2OG92U1ZaOFlSQmpkdDFETWZiVDdSYjRqWEJKS3phQVZz?=
 =?utf-8?B?WXF1RWF5ZzUySTN5ekdWVzcvclNkMjI2YVF0c0JobWJrRUhaRThBVW1nUW5S?=
 =?utf-8?B?YWR2OEJzUHpibEpWN2liR0ZtTEtmK2F4eVpBa1RVK1VPNXNaejk5dHdaNmt4?=
 =?utf-8?B?SGY3SjJDZGNQZ1pjWWtERlNDL2haSFNLWUsyQXBEeXZZL1NNSzlBbGxSaUF1?=
 =?utf-8?B?WkxuZTVSL1ZxT01wb2NRbCs1bG1PZFlTZ29aMC9iMWJ5dnFZcGMrZWFmQ0N2?=
 =?utf-8?B?NnZhdjlPRFRyd3g5TElIcllmU1pJMUdBRDhuL28rWks5dThIZzZ6Sk9iMzJK?=
 =?utf-8?B?Y284Rko0MEIycXQwcEhaUXU1NjlkVEQxN3NjeVIxWkYvR1pjWm5mR1cvUS9I?=
 =?utf-8?B?emYyY0hlN0d6dk9LZ1ArRExnVFc3UVBXWjlScHBmNElheS9VSGd1VktLMmZs?=
 =?utf-8?B?SXdEc2RNT3VvcXV3ZG80WUJodVoyTjduU1lvS3RlZDZWTmpMSHV2NWIrWUFz?=
 =?utf-8?B?WVRQS1Q4Q3kyeExSVXlQSDlIM1dWUWtOeEszMUdCbTlCbmlYM3Fac1oxWm5R?=
 =?utf-8?B?UE5vWHFtUWVVVFp3cW14SGg1bHRWTlQyK2VreHJoaE15bk80WTZRQVpMbnB3?=
 =?utf-8?B?T1BsamxDQlBzaHExeXVNVFpUdEVWcjZVQzBEMmNzWmJ5OXJRQ0lVMnJxVzZG?=
 =?utf-8?B?NVZKWmJzNE5DUXVkZ2tzT3pEZmR5ZmFaWEFHK0JOUXlXcDVtNWVlWDhiVm15?=
 =?utf-8?B?cGlYcWlYNjY2ZkloWk5xb0xaYWMremxodU1oVEI2WVAxM3R3Uno1NWJuamJP?=
 =?utf-8?B?SzVsbEEybVZPRFJ0SnkwVHpBWXJFZzdHYkk5U2dvNjNQQlJReVJsUnVxc21Z?=
 =?utf-8?B?cE9FTU5xWmxqcUhHZStJZ3ZRdzlYZldPQWtLUEI1K0MzdjJ4Y1NPM0xIaXli?=
 =?utf-8?B?UnBtR3Q2Z1lWTkhZd1djMTVhektLLzZia3lWN0pzNHhaRnVwYmNLNlBwQmFk?=
 =?utf-8?B?QzRScDJCdSt1VVBBeU1CWFFjYUxmR1BTU1Y3SFVrZGt6dmozbkZYVFAzTTBX?=
 =?utf-8?B?cHp5UzVRYzdJcCtrTTdmRmc2NWM3MGRRa1lwN1dRakwrdnIveDF4b251Wm9p?=
 =?utf-8?B?REVmMjlYTkpRdytxeFRnM0UraEg4RFdhclZ4NjByS3A0SWdDN21JU29pQmpU?=
 =?utf-8?Q?vhQIxqB8MXagTpMhSJJDy4kWSD0nsVplnpdf3nnmxPdwI?=
x-ms-exchange-antispam-messagedata-1: sfdt5ThYz8SJyUJKceN8FFkfDl1M4vMHZPo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D82FEA8BF0A1534592388299746F3535@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VjhE3jBV8W8xSQ2vSPA6iMMUEtnhWRkQ7ZijdJyYt56qfWeXPiRaiuhbVcAxan7AUU25M8XkorAxDphfHPBLYg2wzHWR0jMnSDIo+1HHj1uB0czQA+G0i7CZk191HTYwkvvc1D5b8Tbr8Ib02evrt6Errw64/Hcook+2WJXvnHeD2dDmPbfYlWFQe16k6ZUgs4UC1bDyTKs/lz4bgrepmx/SCuTNu+UMCAAKCi/1AwQG0YgXczvkcTKtEv2R4xwNXUzj870mGpnFAbS0amOEtcR0WUpZAOcNpck1kQqVjE9W/45JW0qoMagOQgJLB6vDqfc5fotlHho8JHEuqhCj1g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8040.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71cc350f-3894-47c5-824c-08df07880e17
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 17:48:24.2633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b/Xfub4VgtV5Hg9lg31PHwegYVxolB6LjF+zcAQo9gWw5R1mqLS0y5CZlEZA/+eocV3hH7gCIPbdUuCivX6v7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8452
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTA4LTI5IGF0IDEzOjM0IC0wNzAwLCBOYW1oeXVuZyBLaW0gd3JvdGU6DQo+
IEhlbGxvLA0KPiANCj4gT24gVGh1LCBBdWcgMjAsIDIwMjYgYXQgMDc6MTg6MTNQTSAtMDUwMCwg
VGhvbWFzIEZhbGNvbiB3cm90ZToNCj4gPiBBZGQgc3VwcG9ydCBmb3IgdHdvIG1lbW9yeS1yZWxh
dGVkIHJlcG9ydGluZyBmZWF0dXJlcyBpbiB0aGUgcGVyZiB0b29sOg0KPiA+IA0KPiA+IDEuIE1l
bW9yeSByZWdpb24gcmVwb3J0aW5nIGluIHBlcmYtYzJjIGFuZCBwZXJmLXNjcmlwdCBzdWJjb21t
YW5kcy4NCj4gPiAyLiBNZW1vcnkgcmFuZ2UgZGF0YSBpbiBwZXJmLmRhdGEgZmlsZSBoZWFkZXIg
YW5kIHBlcmYtYzJjIHN1YmNvbW1hbmQuDQo+ID4gDQo+ID4gTWVtb3J5IHJlZ2lvbiByZXBvcnRp
bmcgd2FzIGludHJvZHVjZWQgYXMgcGFydCBvZiBzdXBwb3J0IGZvciB0aGUNCj4gPiBPZmYtbW9k
dWxlIFJlc3BvbnNlIGZhY2lsaXR5IChPTVIpIFsxXSwgd2hpY2ggcHJvdmlkZXMgYSBuZXcgZGF0
YQ0KPiA+IHNvdXJjZSBlbmNvZGluZyBzdXBwb3J0aW5nICJ1cCB0byA4IGZpbmUtZ3JhaW5lZCBt
ZW1vcnkgcmVnaW9ucyBpbg0KPiA+IGFkZGl0aW9uIHRvIHRoZSBjYWNoZSByZWdpb24sIG9mZmVy
aW5nIG1vcmUgZGV0YWlsZWQgaW5zaWdodHMgaW50bw0KPiA+IG1lbW9yeSBhY2Nlc3MgcmVnaW9u
cy4iDQo+ID4gDQo+ID4gTWVtb3J5IFJhbmdlIHN1cHBvcnQgd2FzIGludHJvZHVjZWQgd2l0aCB0
aGUgYWRkaXRpb24gb2YgdGhlIEFDUEkgTWVtb3J5DQo+ID4gUmFuZ2UgYW5kIFJlZ2lvbiBNYXBw
aW5nIChNUlJNKSBbMl0gdGFibGUuIEl0IHByb3ZpZGVzIGEgYmFzZSBhZGRyZXNzIHBsdXMNCj4g
PiBhIGxlbmd0aCB2YWx1ZSBmb3IgZWFjaCBtZW1vcnkgcmFuZ2UsIGFzIHdlbGwgYXMgTlVNQSBu
b2RlIGFuZCBsb2NhbCBhbmQNCj4gPiByZW1vdGUgInJlZ2lvbiBJRCdzIiBzbyB0aGF0ICJwbGF0
Zm9ybSBmaXJtd2FyZSBjYW4gaW5kaWNhdGUgdGhlIHR5cGUgb2YNCj4gPiBtZW1vcnkgZm9yIGVh
Y2ggcmFuZ2UuIlszXQ0KPiA+IA0KPiA+IEluY2x1ZGUgYSBjaGFuZ2UgYWxsb3dpbmcgUEVSRl9N
RU1fTFZMTlVNX0wwIHRvIGJlIHByaW50ZWQgaW4NCj4gPiBwZXJmLW1lbSBvdXRwdXQgYXMgd2Vs
bC4NCj4gPiANCj4gPiBbMV06IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MDExNDAx
MTc1MC4zNTA1NjktMS1kYXBlbmcxLm1pQGxpbnV4LmludGVsLmNvbS8NCj4gPiBbMl06IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyNTA1MDUxNzM4MTkuNDE5MjcxLTEtdG9ueS5sdWNr
QGludGVsLmNvbS8NCj4gPiBbM106IE1SUk0gZGVmaW5pdGlvbiBhbGxvdyBmb3IgZnV0dXJlIGV4
cGFuc2lvbiBmb3IgdGhlIE9TIHRvIGFzc2lnbg0KPiA+IHRoZXNlIHJlZ2lvbiBJRHMuDQo+IA0K
PiBUaGFuayB5b3UgZm9yIGRvaW5nIHRoaXMuwqAgVW5mb3J0dW5hdGVseSBpdCBjb25mbGljdHMg
d2l0aCBKaWViaW4ncyBwZXJmDQo+IGMyYyBmdW5jdGlvbiB2aWV3IHN1cHBvcnQgcGF0Y2hzZXQu
wqAgQXMgdGhlcmUncyBhbiB1cGRhdGUsIGNhbiB5b3UgcGxlYXNlDQo+IHdhaXQgYSBsaXR0bGUg
bW9yZSBhbmQgcmViYXNlIG9udG8gdGhlIGxhdGVzdCBwZXJmLXRvb2xzLW5leHQ/DQoNCk5vIHBy
b2JsZW0sIEkgd2lsbCBzZW5kIGEgbmV3IHJlYmFzZWQgdmVyc2lvbiBzb29uLg0KDQpUaGFua3Ms
DQpUb20NCg0KPiANCj4gVGhhbmtzLA0KPiBOYW1oeXVuZw0KPiANCj4gPiANCj4gPiB2NToNCj4g
PiAtLSBwZXJmLWMyYzogbWFrZSB0aGUgY2FjaGVsaW5lIGhlYWRlciBzcGFuIGFuZCB1aV9xdWly
a3MoKSB3aWR0aA0KPiA+IMKgwqAgZml4dXAgZGVwZW5kIG9uIG1lbW9yeS1yZWdpb24gYXZhaWxh
YmlsaXR5IChOYW1oeXVuZyBLaW0pDQo+ID4gDQo+ID4gdjQ6DQo+ID4gLS0gcGVyZi1zY3JpcHQ6
IGdhdGUgdGhlIFJlZ2lvbiBmaWVsZCBvbiB0aGUgSEVBREVSX01FTU9SWV9SQU5HRVMgZmVhdHVy
ZQ0KPiA+IMKgwqAgYml0IHZpYSBwZXJmX3Nlc3Npb24gaW5zdGVhZCBvZiBhIGdsb2JhbCBmbGFn
LCB3aXRoIGEgcGlwZS1tb2RlIGZhbGxiYWNrDQo+ID4gLS0gcGVyZi1jMmM6IGZpeCBvdXRwdXRf
c3RyIGFsbG9jYXRpb24gZXJyb3IgaGFuZGxpbmcNCj4gPiAtLSBwZXJmIGhlYWRlcjogRml4IHR5
cG8gaW4gcmVnaW9uIGlkIGJvdW5kcyBjaGVja2luZyB3aGljaCBtYWRlIHJlZ2lvbiAyNTUNCj4g
PiDCoMKgIGludmFsaWQNCj4gPiANCj4gPiB2MzoNCj4gPiAtLSBpbmNsdWRlZCBtaXNzaW5nIGZm
LXNpemUgY2hlY2sgaW4gcHJvY2Vzc19tZW1vcnlfcmFuZ2VzDQo+ID4gLS0gbWFrZSBtZW1vcnkg
cmVnaW9uIHJlcG9ydGluZyBpbiBwZXJmIGMyYy1hbmQgcGVyZi1zY3JpcHQgY29uZGl0aW9uYWwN
Cj4gPiDCoMKgIG9uIGZlYXR1cmUgYml0LCByZXF1aXJpbmcgc29tZSBwYXRjaCByZW9yZGVyaW5n
IChOYW1oeXVuZyBLaW0pDQo+ID4gLS0gdXNlZCBvcGVuL29wZW5hdCB0byByZWFkIG1lbW9yeSBy
YW5nZSBzeXNmcyBmaWxlcyBpbiBtZW1vcnlfcmFuZ2VfX3JlYWQoKQ0KPiA+IMKgwqAgKE5hbWh5
dW5nIEtpbSkNCj4gPiAtLSBSZW1vdmVkIHBhdGggbmFtZSBhbmQgZmlsZSBuYW1lIGJ1ZmZlcnMg
aW4gbWVtb3J5X3JhbmdlX19yZWFkKCksDQo+ID4gwqDCoCBpbnN0ZWFkIHBhc3MgcGF0aCBuYW1l
IGZyb20gYXMgYSBwYXJhbWV0ZXIgZnJvbSBtZW1vcnlfcmFuZ2VfX3BhcnNlKCkNCj4gPiDCoMKg
IChOYW1oeXVuZyBLaW0pDQo+ID4gLS0gdXNlIGNhbGxvYyBpbnN0ZWFkIG9mIHphbGxvYyBpbiBt
ZW1vcnlfcmFuZ2VfX3BhcnNlKCkgYW5kDQo+ID4gwqDCoCBwcm9jZXNzX21lbW9yeV9yYW5nZXMo
KSAoTmFtaHl1bmcgS2ltKQ0KPiA+IC0tIFJlbW92ZWQgcmVkdW5kYW50IGNoZWNrIGZvciBleGlz
dGFuY2Ugb2YgbWVtb3J5IHJhbmdlIGRpcmVjdG9yeSBpbg0KPiA+IMKgwqAgbWVtb3J5X3Jhbmdl
X19yZWFkKCkgKE5hbWh5dW5nIEtpbSkNCj4gPiAtLSBJbmNsdWRlZCBvdXRwdXQgZXhhbXBsZXMg
b2YgbWVtb3J5IHJhbmdlcyBpbiBwZXJmIGhlYWRlciBhbmQgcGVyZi1jMmMNCj4gPiDCoMKgIGlu
IGNvbW1pdCBtZXNzYWdlIChOYW1oeXVuZyBLaW0pDQo+ID4gDQo+ID4gdjI6DQo+ID4gLS0gQWRk
ZWQgbWlzc2luZyBuZXdsaW5lIGluIFdBUk5fT05DRSBtZXNzYWdlIGluIGMyY19oZV9fc2V0X21l
bV9yZWdpb24oKQ0KPiA+IC0tIGluY3JlYXNlZCBidWZmZXJzIHBhc3NlZCB0byBwZXJmX3Njcmlw
dF9fbWVtaW5mb19zY25wcmludGYoKSBmcm9tIDE1MA0KPiA+IMKgwqAgdG8gMjAwIGJ5dGVzIHRv
IGF2b2lkIHNpbGVudCB0cnVuY2F0aW9uDQo+ID4gLS0gQWRkZWQgY2hlY2sgZm9yIE5VTEwgcmV0
dXJuIG9mIHN5c2ZzX19tb3VudHBvaW50KCkgd2hlbiBwYXJzaW5nDQo+ID4gwqDCoCBtZW1vcnkg
cmFuZ2VzIGluIHN5c2ZzDQo+ID4gLS0gaW5jcmVhc2VkIE1BWF9NRU1PUllfUkFOR0VTIHNhbml0
eSBjaGVjayBmcm9tIDY0IHRvIDI1NiBiYXNlZCBvbg0KPiA+IMKgwqAgQUNQSSBNUlJNIHRhYmxl
IGltcGxlbWVudGF0aW9uIGluIExpbnV4IGtlcm5lbA0KPiA+IC0tIGFkZGVkIGNvbW1lbnQgZm9y
IE1BWF9NRU1PUllfUkFOR0VTIHRvIGNsYXJpZnkgdGhhdCBpdCBpcyBhIHNhbml0eSBjaGVjaw0K
PiA+IMKgwqAgZm9yIG1hbGZvcm1lZCBwZXJmLmRhdGEgZmlsZXMNCj4gPiAtLSByZW1vdmVkIGEg
bGluZSBvZiBjb2RlIHdhcyByZW1vdmVkIGZyb20gdXRpbC9lbnYuaCBidXQgd2FzIGFkZGVkIGJh
Y2sgaW4NCj4gPiDCoMKgIHYxIGR1ZSB0byBiYWQgcmViYXNlDQo+ID4gDQo+ID4gRGFwZW5nIE1p
ICgzKToNCj4gPiDCoCBwZXJmIG1lbTogQWRkIHN1cHBvcnQgZm9yIHByaW50aW5nIFBFUkZfTUVN
X0xWTE5VTV9MMA0KPiA+IMKgIHBlcmYgdG9vbHM6IFNob3cgbWVtb3J5IHJlZ2lvbiBpbiBwZXJm
LWMyYyBzdWJjb21tYW5kDQo+ID4gwqAgcGVyZiB0b29sczogU2hvdyBtZW1vcnkgcmVnaW9uIGlu
IHBlcmYtc2NyaXB0IHN1YmNvbW1hbmQNCj4gPiANCj4gPiBUaG9tYXMgRmFsY29uICgzKToNCj4g
PiDCoCBwZXJmIG1lbTogRml4IHNpemUgdHJhY2tpbmcgZm9yIG1lbV9sdmwncyBpbg0KPiA+IMKg
wqDCoCBwZXJmX3NjcmlwdF9fbWVtaW5mb19zY25wcmludGYoKQ0KPiA+IMKgIHBlcmYgaGVhZGVy
OiBTdXBwb3J0IG1lbW9yeSByYW5nZXMNCj4gPiDCoCBwZXJmIGMyYzogcHJpbnQgbWVtb3J5IHJl
Z2lvbiBkYXRhIHdpdGggc3RkaW8gb3V0cHV0DQo+ID4gDQo+ID4gwqB0b29scy9wZXJmL0RvY3Vt
ZW50YXRpb24vcGVyZi1yZWNvcmQudHh0wqDCoMKgwqDCoCB8wqDCoCAyICstDQo+ID4gwqAuLi4v
RG9jdW1lbnRhdGlvbi9wZXJmLmRhdGEtZmlsZS1mb3JtYXQudHh0wqDCoCB8wqAgMTMgKysNCj4g
PiDCoHRvb2xzL3BlcmYvYnVpbHRpbi1jMmMuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8IDEyNSArKysrKysrKysrLQ0KPiA+IMKgdG9vbHMvcGVyZi9idWlsdGlu
LWluamVjdC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKw0K
PiA+IMKgdG9vbHMvcGVyZi9idWlsdGluLXNjcmlwdC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoCAxMyArLQ0KPiA+IMKgdG9vbHMvcGVyZi91dGlsL2JwZi1maWx0ZXIu
bMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArDQo+ID4gwqB0b29s
cy9wZXJmL3V0aWwvZW52LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgwqAgMSArDQo+ID4gwqB0b29scy9wZXJmL3V0aWwvZW52LmjCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEwICsNCj4gPiDCoHRv
b2xzL3BlcmYvdXRpbC9oZWFkZXIuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8IDIwMyArKysrKysrKysrKysrKysrKysNCj4gPiDCoHRvb2xzL3BlcmYvdXRpbC9o
ZWFkZXIuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAx
ICsNCj4gPiDCoHRvb2xzL3BlcmYvdXRpbC9tZW0tZXZlbnRzLmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoCA5MyArKysrKysrLQ0KPiA+IMKgdG9vbHMvcGVyZi91dGlsL21l
bS1ldmVudHMuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNSArLQ0K
PiA+IMKgLi4uL3NjcmlwdGluZy1lbmdpbmVzL3RyYWNlLWV2ZW50LXB5dGhvbi5jwqDCoMKgIHzC
oMKgIDUgKy0NCj4gPiDCoDEzIGZpbGVzIGNoYW5nZWQsIDQ1MiBpbnNlcnRpb25zKCspLCAyMSBk
ZWxldGlvbnMoLSkNCj4gPiANCj4gPiAtLSANCj4gPiAyLjU1LjANCj4gPiANCj4gDQoNCg==
