Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095A11FA1;
	Mon,  3 Jun 2024 17:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434034; cv=fail; b=GQ9PTSJg/bz3bwGO2i4eeWjfvA6bsjiMIvfDJf1VJjbTxv0MYbfZ8VrenTvpTfICuTWBAQuvggzRUkxxXQonIeSSeq5ld75r4h1XJuPSixzLMfBMuT+O0sP11yey6XpYBaKA8R1vQC57MpUiRzQEaBvmCFUFOwigbBgKlEzOGkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434034; c=relaxed/simple;
	bh=hdliPTllqX+26RY5us9H/hunohlIMqafYgHQJGIkKco=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CecfQALj0b5yaAbwdTGkUvqSVBQsBAjun3pg8eUAIK+uLHS/0ITq6V/kJUbYmFHTroZddSGDcw59umBATEC2a2jBn6GSMB+980wYrCuKPAQtdD9LRd1lkGy5xUVIxFCrUvJekDtqKMlQPuJLAQifA6BaQx9yEWTg2p8ztQBJurs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AaiRGzVV; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AaiRGzVV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717434033; x=1748970033;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hdliPTllqX+26RY5us9H/hunohlIMqafYgHQJGIkKco=;
  b=AaiRGzVVDVGwD62mntyHJR5lMT27kkJO8Ars8GVLOVWSCVd6lJOA50NM
   m9GCN4CxmHnASWykipi96wNfAVklqoQ3btRFI8/vpykwz0AIdahRWdwxI
   uoFfUi5Rj76yVIrI0qgzSYpExnRkHHVQuPTqiQvyy8BsZRLqcUjjcmg0q
   +Spibg99enWusrFVt2XJGNz2FHSuMArPtp1Kcgc/stjPbeyq8oAoYesrk
   1EbeM6KjKK9n0GtwNBZ1QqyB+mG/dOesTPanI05OxcqwTdcxpPCJ2OTnr
   taJTJsSduMTXsH0y5NSrQW4Lkmg0vpYsO5drUsZga0f58KdSKF++bp0Ap
   w==;
X-CSE-ConnectionGUID: EltGI1YBRoS7UA9FoJ4bQg==
X-CSE-MsgGUID: rTLjEYAaSYCJiAWjqE7r6g==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="25338023"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="25338023"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 10:00:32 -0700
X-CSE-ConnectionGUID: JHL069H+QxGuFvbL1FXRsQ==
X-CSE-MsgGUID: QcALa7jbTVOVWqYVH15b4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="41481144"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jun 2024 10:00:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 10:00:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 10:00:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 10:00:31 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 10:00:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZxJ/BibTo95ZiMJEa/rF7nF/GKCA+uIG9MJODQlNTREPbxky0iJAMCQVtfyl0eQtcT4KWhVdiXj8oH89gqONpDHY4n9QXZBX8mdVlFJ73/Pwk4bjHM8cA19SjDaxN4VHhtRZhAxuUCQndQ3ZZAbHgRoqv8RV387fwIdkdDRdCcUI1pgvkRIakh0y0kowJcBLD70nCHHT+XRdGU5vfvhlAFrbW87XAO/A8UtjQsO+MuSQaZH0S/KNnpzyfPJBlvigNtsMzDebzmpO7GWdstzSLr2CGoWJiU8g74cL2UVXd2yS8WodGolnKuAjif3b0Jm7y1f52xvxv7mKuPFjzxLXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdliPTllqX+26RY5us9H/hunohlIMqafYgHQJGIkKco=;
 b=X/dBM045pV5QYqDdqqRvneZ5acyNRKDkVpSDDqCUw35fdTe5eMuX62yAmuP92AHlC92KcLowhFBpxnjADQHoxLEz2ra3nVUF5V0Liu5OxY5KJII4o1Slvv786nqEpCsTAYaaon/E9o7qpdnl1/BvmTN+XW03WkvgbvLk5GYnjUv8rBnvvK/ayHyNYN6ayBMn8e0+QhL5NuXX96Zw+mSb3YDfx/M5yfHP0fa/ukFqUo2CYUOSBkeoRDfqOBplxQvi2ktXNSIaVDdMy332HgjwOSL7G+1rLRdW/I/MZr0m+pVth4KM7Xp9VAM84rjNWxKKvswhWJe4YMxqEqMRAgbdSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by SJ0PR11MB6717.namprd11.prod.outlook.com (2603:10b6:a03:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Mon, 3 Jun
 2024 17:00:26 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 17:00:26 +0000
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
Thread-Index: AQHasZORguWsh0HBOE2nG0SK0bqPIbGw5tCAgAACpYCAAPbIAIAAGXKQgAMH7gCAAUoQkA==
Date: Mon, 3 Jun 2024 17:00:26 +0000
Message-ID: <CO6PR11MB563597FB5E78150EF5C2E2CDEEFF2@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240529064327.4080674-1-weilin.wang@intel.com>
 <CAM9d7cj676sty01zqJVyk9DVesVYNFgVTZ329X=UP3xgV2aDfA@mail.gmail.com>
 <CO6PR11MB5635D7581425EF0F089EA781EEFC2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7chSC=n2sCc_nhgwqHYnBhSjMhH1quAY6_JWXNhrk1ri8Q@mail.gmail.com>
 <CO6PR11MB563586B37B444C5B45408B80EEFC2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <ZlzhmBcM9OP0SRfT@google.com>
In-Reply-To: <ZlzhmBcM9OP0SRfT@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|SJ0PR11MB6717:EE_
x-ms-office365-filtering-correlation-id: b0776370-60c8-47c5-c886-08dc83eeaa90
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?cUdaRFNtOU1Nbkc3ZGZaWmh5RFRIZlpHcXNXK0RHSjVQK1p5anZkdWlsSy91?=
 =?utf-8?B?ZXIxUjROdGJwTTE4N2NmWjNRY1VKbUNwUFFaa0FxRnNveXdiRGhBSDcrNHlE?=
 =?utf-8?B?MmFDcFFBbTB4cUJ5cU9rTjNPbVVyYmJMa3JackxXZXhoNHZXV3d4R1Fzbitm?=
 =?utf-8?B?bTJtcHkvZEN0cE1mSXpLVGh0UG5PbG50QmVZNERUUEFoM01LTEZ1MnRWN2lD?=
 =?utf-8?B?OVNycjJoeEVRaUxZVFY1UnZGcG5lLzQxVFU0QmhhOG5FQ0dVb0FXY0c4M2dV?=
 =?utf-8?B?VlJpeFVLNyt2RGd1cnV0UWY4ZEc2TGhZem9VaTZEb0I3MGJOdklwTWllQXlY?=
 =?utf-8?B?OE9GQkRqWC9rcW5zQUhyYktPZElqNFI3NkxHZHRjeU9aeGJSOWtKamlpRTYv?=
 =?utf-8?B?NStRMDRhL2VLV2xlRy9aZkgveEVCNGdOWG5uYTd3L1FDMWZMaWxNb0cwdjFV?=
 =?utf-8?B?NEJHVU1oTEt1a09pKzNCU3RlZzRyaGtZcEEzMmRXdHQ2Rlp0MkszUk9ETW1z?=
 =?utf-8?B?d3NIMUFYdmoxQWhtT0crSFhWQU51QzMrVGFmRzFrRjlzQmFyVm9rYkoyRGhr?=
 =?utf-8?B?cy9ERzlIWDNMWjJpelQvY2F5UTR3VG1RZnNncW1RNUQ4a09rSkd2b0tzRVYz?=
 =?utf-8?B?aVZRL1RWbExkSTdJU0xhM1FEdXhhbkdEV05wR1UvZ0I2TFJCVVZWTjZUd0Rl?=
 =?utf-8?B?Ui9ReXI4UkhMcWdrUkZ0eVFIRWNVZUxhVFoxY2h1ZFp3U0p1cmJRa2ZtakFF?=
 =?utf-8?B?SmFvcUxqQXFzUC9UM1YvUWh2NkhQOTBQQm1EZnFVOHhtR011NXp4Yzh3cWhC?=
 =?utf-8?B?OGh1YlNING0vbEROZEREdFJyaEJYT1MrTkJZVjdTMVRZZElqZHNtdkcwbjZ3?=
 =?utf-8?B?Y256SWlaUTEvOTRPeFNEL0J3LzVFR0g5OWVlZEpSZjhwRHMvZWIwRWNBYnEr?=
 =?utf-8?B?UDN3VXF0SkM2SXkwOCtRYloyL2liNFFaeVJMYXBtYms5RGVRUkxqZ3laZXJL?=
 =?utf-8?B?aVBCN25KUmdUU1FlVlhWUi9tYTVrWVBUa3lrejVQcXFzTStpZU5uOGxlU01D?=
 =?utf-8?B?YzVTZFJtcVRLRWNKeXJ2ZlNvNVA5emJJVmhoREYzdEV0WjVML0pLSHF6N2Nl?=
 =?utf-8?B?TStrbWQ3TityMEtVRFJZMDZmQStKMDZVKzU0Q291UTFmRTcwVm9IQkhwamdF?=
 =?utf-8?B?d0NPcE1JdGw4TjFXR3R2SmF1TTIvZzJjNjJXYkdlbFUwUkpPWjkvUEtPcDdy?=
 =?utf-8?B?MkJXN0JnVTdBOVdiWjZDT01USndRQW43bmU4Wk5nckFzWFV0WWdLQkdBMm1j?=
 =?utf-8?B?ZVJ1ZjAwUVI1R1ZsTGdsM0x5ZjV4d0F3eGxwS3g0MjhvM2k2OFFycWJWUHZT?=
 =?utf-8?B?N2crcTN6RjQxUXRseU9iV2JBVjAvQ3Q4STlSNU9Vd3kvNEJQMnhPa1Zod3pY?=
 =?utf-8?B?a1hvNzNJdm1vYXREbXlhRHROU3ZSaVJ2L3BXRDFGbnduUEcwanlWSHZjajBz?=
 =?utf-8?B?RVQ1ZWdralhFNCtqcGROeldkeDRhbkRERFNOWVl1Zy9QZVl4ckZ2QWtpaXRI?=
 =?utf-8?B?eFN6dDNBcldadXpBazJDYkpZZzFYZDFvam5ZM3JrcmFUdU45VkNIM09QUjRv?=
 =?utf-8?B?dzFWUjBsZkVJVEVlR2tKZ2MrcHNDN05FZHlOT3NuaTJDNFg5WFJsUzFGSkRO?=
 =?utf-8?B?djlReDRweUpnSnNzYW12K1Z2cnNvSWdScVYxRGdIV0NPUFkxencxTitJVUhn?=
 =?utf-8?B?ekt0SEhMM0RJSE56WUlzUEZKa2k5T0RtT1ZGaXFMcUVQSFRwOWw4eXc1MWZo?=
 =?utf-8?B?ejY0MjdSTzJXakRJOUMzUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTNUNFREZWxIY1NIYUVVOWZ3clZVTUwzTGlQbzJ5S290aFBSS2FPSjNHVWV2?=
 =?utf-8?B?dTJackJXaU1KYWJSUStLT0dwSS8wa1VwcVc3UDZwdmkrM2huandlamxJaU5Q?=
 =?utf-8?B?OWxHcjRBU2lpUmFGdEhtN0JwOEwyb2M1N1RFU3dQUUtBVWFqVVNiY2pUL1RQ?=
 =?utf-8?B?Z01tVVl2TEtDdlJEcnFTUVBsbDZpeVNKMWE3aU5hNURxS2NSLzJxOUk4cU1k?=
 =?utf-8?B?T0NjTHJrMm1kWUtJZmRWZFN6MXM1dzJlVzFsQ3V0S1lhRmFxdDZGUG5kWGNn?=
 =?utf-8?B?U0JId2EybVJ6SnVnMDlMU2RGRzJmUlZ1R3Z1S1ZmREhqNUFSdUR6S0FDdUR3?=
 =?utf-8?B?YVlxZHE2TTllOFJBZWVzN3F5OWtKaFN4NDJnUmVlcEkvbDJjZzRTdXRSR3gr?=
 =?utf-8?B?SFpCK2JPQVk0Mkt1QlZkV05sMVFWaGFVS3lMYUJ5TnNVdWpmZnc2WmU3cFFj?=
 =?utf-8?B?M3RxM1o4THF5R2RJTURJRXY0VU9Tcm5Xb2VyZUZCbnJSQVMzT0kyVUhCUEhx?=
 =?utf-8?B?R3RYUU12ZXcxVXVzNmYzdWszTEtiaDVQZTFkcnlYMlZMTE90YUQxcGVTU21M?=
 =?utf-8?B?dEFtUUFoQXl4RmY4VEVBTlhtTXZTMUszejJlcHpVK0YyUG5wNXV5YUpmbHh3?=
 =?utf-8?B?aTFPRUx4WXNZNGdjSzl6TXVESTh3YndGVmIzaHpKMkk2dk9kcW12Rm1yaFdM?=
 =?utf-8?B?ZkV0aDlZUjk4amQwT0V5ZEFvSjNLbUx2QjFNQXQwOTFqSkJzMkcrTG16TXV0?=
 =?utf-8?B?enFHRnoyd2krWDFmV043bjY5RVcvMnZPK3dZQXhtb3ljcDJoRDJjK2kvZ0RQ?=
 =?utf-8?B?MkJPYkxlVU5oMmdMdE9FLzNiM25qdjR2MGk3Tm4vK1R0QU9GY3RqWm40TTVt?=
 =?utf-8?B?RWtXTnRTWXkxUmVMOWVTc3BsSGI5MGJ2S0xmZ3lMRTBid244ZU1SOGh4VnBu?=
 =?utf-8?B?dStsTlptZllnclhhUmo2QUV0Wm9teVRXSUltNm82cUVpUG5WRTdVUkhuZ0lR?=
 =?utf-8?B?ZGkrampYRU90ZEM0cTlLTUtFb2Q0Ry9aVVdYaGFpZE9pNXVET3lmR3FlUTdi?=
 =?utf-8?B?eFYrT2Z3THIrVm1hTEFtd1p3ZmMxSmUwdW9aaUdqT0lPNGY5ZVlzOVpCZ2JU?=
 =?utf-8?B?c3BvWSttS1BKMkh6dS8vSVMyVXdpaFUraGFyVEpGNDJSenA5ZS9NcERxbU1L?=
 =?utf-8?B?eEtmRE5TNFo4TldVNk01ZnU3d0o1ZFpUNXBrRVovWkwycmYrZHpqaHQ5QXlr?=
 =?utf-8?B?ZHJXNVVEU2ZndnBxSDQzU3J4bmsrNE9rS1M3L01jb0VNenhXbXNZYnJiQlJR?=
 =?utf-8?B?K0RqNkN2Z05nanh1aFp5RXFVa0tJV2JJZkdRZndZd0gxYnlxMStWVmFSQ1p6?=
 =?utf-8?B?bEJnUmJzcVdaazJGVzFwZzJBTURMQ0I1dzdkVVpEalJjSk1JeWFDRlNVaHhi?=
 =?utf-8?B?K0J2enNPRzFzNkJHSmxUZ29MbGNicDZqM3RtcVhlY2xiQWZWc293MWlqakpF?=
 =?utf-8?B?Znk0WmtkQzJweWJBQUk4emUxTXdDb2hpL1RmSTE2YjBBK1E1d0F0YmphUnBs?=
 =?utf-8?B?KzZadzNDb2tXVWdLWCttU3BhRE94S2g0K29xL0hGSXRDSVY5ZmJJRktYNUp5?=
 =?utf-8?B?bHFSWUpMeldGUTBTOWUveEtrRWxLZVlzOXEzZk9SbmlmRFc3WmpQMlQrYlZv?=
 =?utf-8?B?aE1xbUdHWFdUTERaelg1WSsvNzR4WTh5c2ZzdXNKb1I1Q2U1VEdkdkcyK2kw?=
 =?utf-8?B?SDF0OGh2UjcyczVCMWs4R3lNTW1kYnhXUHJ1VTN2SjdSRnk2K0lhZjJjbVpD?=
 =?utf-8?B?UVpkZzdnOGVrWFdlOTBYRlk2bU9aUjFsZ29hcm9kejJ3SEQvdURDWHZLZi9I?=
 =?utf-8?B?a2hGQWJ3cHBCSDdCT0ZhQUVXaVo1ZU0rTVNtMVZ0NGg2SGs4MmNWWER6ZnZ3?=
 =?utf-8?B?WGxhcDBFQ2xyclpvL09ZblpLblM4Vkxwbnk3S1NQeFFnSHlxcXdKSFdGSW9B?=
 =?utf-8?B?RzZ3Wk91WXBsR0NFZGttM29yMTQyRExIdjB2b2o1ZmhLR3BSQVhlUW1RQk8z?=
 =?utf-8?B?cXZQTnRqRWM4d1k5SENyNFI5TDhuQ2I4NUV0aXE2RnZXUUR0dGMyNWRucU9x?=
 =?utf-8?Q?fcifrt98YnIwTnAj5njn1Y/Er?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b0776370-60c8-47c5-c886-08dc83eeaa90
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 17:00:26.6753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2nkfKkBToLLTtFyXkudv5ExzPmkviWAGob1a3XRdMr4ZZluv/kXjHMTSAAK1ZKRrqCqUHCgo0i4Ni2FpaV0Vxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6717
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFtaHl1bmcgS2ltIDxu
YW1oeXVuZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBTdW5kYXksIEp1bmUgMiwgMjAyNCAyOjE4IFBN
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
ZGUgc3VwcG9ydA0KPiANCj4gT24gRnJpLCBNYXkgMzEsIDIwMjQgYXQgMTE6MDM6MjVQTSArMDAw
MCwgV2FuZywgV2VpbGluIHdyb3RlOg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+ID4gRnJvbTogTmFtaHl1bmcgS2ltIDxuYW1oeXVuZ0BrZXJuZWwub3JnPg0KPiA+
ID4gQXMgSSBzYWlkLCBwbGVhc2UgZG9uJ3Qgb3BlbiBldmVudDE6UiAoZm9yIHBlcmYgc3RhdCkg
YW5kIGxldCB0cGVic19zdG9wKCkgc2V0DQo+ID4gPiB0aGUgdmFsdWUgdXNpbmcgdGhlIGRhdGEg
ZnJvbSBwZXJmIHJlY29yZCBpbiBiYWNrZ3JvdW5kLg0KPiA+DQo+ID4gSSB0aGluayB0aGlzIGlz
IGV4YWN0bHkgd2hhdCBJJ20gdHJ5aW5nIHRvIGFjaGlldmUsIG5vdCBvcGVuIGV2ZW50MTpSIGZv
ciBwZXJmDQo+IHN0YXQuDQo+ID4gVGhlIHByb2JsZW0gaXMgdGhhdCBJJ20gbm90IHN1cmUgaG93
IHRvIGRvIGl0IHByb3Blcmx5IGluIHRoZSBjb2RlLiBQbGVhc2UNCj4gZ2l2ZQ0KPiA+IG1lIHNv
bWUgc3VnZ2VzdGlvbiBoZXJlLg0KPiANCj4gT2ssIEkgdGhpbmsgdGhlIHByb2JsZW0gaXMgaW4g
dGhlIHJlYWQgY29kZS4gIEl0IHJlcXVpcmVzIHRoZSBudW1iZXIgb2YNCj4gZW50cmllcyBhbmQg
dGhlIGRhdGEgc2l6ZSB0byBtYXRjaCB3aXRoIHdoYXQgaXQgY2FsY3VsYXRlcyBmcm9tIHRoZQ0K
PiBtZW1iZXIgZXZlbnRzLiAgSXQgc2hvdWxkIG5vdCBjb3VudCBUUEVCUyBldmVudHMgYXMgd2Ug
ZG9uJ3Qgd2FudCB0bw0KPiBvcGVuIHRoZW0uDQo+IA0KPiBTb21ldGhpbmcgbGlrZSBiZWxvdyBt
aWdodCB3b3JrIChvbiB0b3Agb2YgeW91ciBzZXJpZXMpLiAgUHJvYmFibHkNCj4gbGlicGVyZiBz
aG91bGQgYmUgYXdhcmUgb2YgdGhpcy4uDQo+IA0KVGhhbmtzIE5hbWh5dW5nISAgSSB3aWxsIGlu
dGVncmF0ZSB0aGlzIHBhdGNoIGFuZCB0ZXN0IGl0IG91dC4gDQoNClRoYW5rcywNCldlaWxpbg0K
DQo+IFRoYW5rcywNCj4gTmFtaHl1bmcNCj4gDQo+IC0tLTg8LS0tDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvdG9vbHMvcGVyZi91dGlsL2V2c2VsLmMgYi90b29scy9wZXJmL3V0aWwvZXZzZWwuYw0KPiBp
bmRleCBhYzdhOThmZjZiMTkuLjc5MTNkYjRhOTllMCAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvcGVy
Zi91dGlsL2V2c2VsLmMNCj4gKysrIGIvdG9vbHMvcGVyZi91dGlsL2V2c2VsLmMNCj4gQEAgLTE1
NTksNiArMTU1OSw2MCBAQCBzdGF0aWMgdm9pZCBldnNlbF9fc2V0X2NvdW50KHN0cnVjdCBldnNl
bA0KPiAqY291bnRlciwgaW50IGNwdV9tYXBfaWR4LCBpbnQgdGhyZWFkLA0KPiAgCXBlcmZfY291
bnRzX19zZXRfbG9hZGVkKGNvdW50ZXItPmNvdW50cywgY3B1X21hcF9pZHgsIHRocmVhZCwNCj4g
dHJ1ZSk7DQo+ICB9DQo+IA0KPiArc3RhdGljIGJvb2wgZXZzZWxfX2dyb3VwX2hhc190cGVicyhz
dHJ1Y3QgZXZzZWwgKmxlYWRlcikNCj4gK3sNCj4gKwlzdHJ1Y3QgZXZzZWwgKmV2c2VsOw0KPiAr
DQo+ICsJZm9yX2VhY2hfZ3JvdXBfZXZzZWwoZXZzZWwsIGxlYWRlcikgew0KPiArCQlpZiAoZXZz
ZWxfX2lzX3JldGlyZV9sYXQoZXZzZWwpKQ0KPiArCQkJcmV0dXJuIHRydWU7DQo+ICsJfQ0KPiAr
CXJldHVybiBmYWxzZTsNCj4gK30NCj4gKw0KPiArc3RhdGljIHU2NCBldnNlbF9fZ3JvdXBfcmVh
ZF9ucl9tZW1iZXJzKHN0cnVjdCBldnNlbCAqbGVhZGVyKQ0KPiArew0KPiArCXU2NCBuciA9IGxl
YWRlci0+Y29yZS5ucl9tZW1iZXJzOw0KPiArCXN0cnVjdCBldnNlbCAqZXZzZWw7DQo+ICsNCj4g
Kwlmb3JfZWFjaF9ncm91cF9ldnNlbChldnNlbCwgbGVhZGVyKSB7DQo+ICsJCWlmIChldnNlbF9f
aXNfcmV0aXJlX2xhdChldnNlbCkpDQo+ICsJCQluci0tOw0KPiArCX0NCj4gKwlyZXR1cm4gbnI7
DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB1NjQgZXZzZWxfX2dyb3VwX3JlYWRfc2l6ZShzdHJ1Y3Qg
ZXZzZWwgKmxlYWRlcikNCj4gK3sNCj4gKwl1NjQgcmVhZF9mb3JtYXQgPSBsZWFkZXItPmNvcmUu
YXR0ci5yZWFkX2Zvcm1hdDsNCj4gKwlpbnQgZW50cnkgPSBzaXplb2YodTY0KTsgLyogdmFsdWUg
Ki8NCj4gKwlpbnQgc2l6ZSA9IDA7DQo+ICsJaW50IG5yID0gMTsNCj4gKw0KPiArCWlmICghZXZz
ZWxfX2dyb3VwX2hhc190cGVicyhsZWFkZXIpKQ0KPiArCQlyZXR1cm4gcGVyZl9ldnNlbF9fcmVh
ZF9zaXplKCZsZWFkZXItPmNvcmUpOw0KPiArDQo+ICsJaWYgKHJlYWRfZm9ybWF0ICYgUEVSRl9G
T1JNQVRfVE9UQUxfVElNRV9FTkFCTEVEKQ0KPiArCQlzaXplICs9IHNpemVvZih1NjQpOw0KPiAr
DQo+ICsJaWYgKHJlYWRfZm9ybWF0ICYgUEVSRl9GT1JNQVRfVE9UQUxfVElNRV9SVU5OSU5HKQ0K
PiArCQlzaXplICs9IHNpemVvZih1NjQpOw0KPiArDQo+ICsJaWYgKHJlYWRfZm9ybWF0ICYgUEVS
Rl9GT1JNQVRfSUQpDQo+ICsJCWVudHJ5ICs9IHNpemVvZih1NjQpOw0KPiArDQo+ICsJaWYgKHJl
YWRfZm9ybWF0ICYgUEVSRl9GT1JNQVRfTE9TVCkNCj4gKwkJZW50cnkgKz0gc2l6ZW9mKHU2NCk7
DQo+ICsNCj4gKwlpZiAocmVhZF9mb3JtYXQgJiBQRVJGX0ZPUk1BVF9HUk9VUCkgew0KPiArCQlu
ciA9IGV2c2VsX19ncm91cF9yZWFkX25yX21lbWJlcnMobGVhZGVyKTsNCj4gKwkJc2l6ZSArPSBz
aXplb2YodTY0KTsNCj4gKwl9DQo+ICsNCj4gKwlzaXplICs9IGVudHJ5ICogbnI7DQo+ICsJcmV0
dXJuIHNpemU7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBpbnQgZXZzZWxfX3Byb2Nlc3NfZ3JvdXBf
ZGF0YShzdHJ1Y3QgZXZzZWwgKmxlYWRlciwgaW50IGNwdV9tYXBfaWR4LA0KPiBpbnQgdGhyZWFk
LCB1NjQgKmRhdGEpDQo+ICB7DQo+ICAJdTY0IHJlYWRfZm9ybWF0ID0gbGVhZGVyLT5jb3JlLmF0
dHIucmVhZF9mb3JtYXQ7DQo+IEBAIC0xNTY3LDcgKzE2MjEsNyBAQCBzdGF0aWMgaW50IGV2c2Vs
X19wcm9jZXNzX2dyb3VwX2RhdGEoc3RydWN0IGV2c2VsDQo+ICpsZWFkZXIsIGludCBjcHVfbWFw
X2lkeCwgaW50DQo+IA0KPiAgCW5yID0gKmRhdGErKzsNCj4gDQo+IC0JaWYgKG5yICE9ICh1NjQp
IGxlYWRlci0+Y29yZS5ucl9tZW1iZXJzKQ0KPiArCWlmIChuciAhPSBldnNlbF9fZ3JvdXBfcmVh
ZF9ucl9tZW1iZXJzKGxlYWRlcikpDQo+ICAJCXJldHVybiAtRUlOVkFMOw0KPiANCj4gIAlpZiAo
cmVhZF9mb3JtYXQgJiBQRVJGX0ZPUk1BVF9UT1RBTF9USU1FX0VOQUJMRUQpDQo+IEBAIC0xNTk3
LDcgKzE2NTEsNyBAQCBzdGF0aWMgaW50IGV2c2VsX19yZWFkX2dyb3VwKHN0cnVjdCBldnNlbCAq
bGVhZGVyLA0KPiBpbnQgY3B1X21hcF9pZHgsIGludCB0aHJlYWQpDQo+ICB7DQo+ICAJc3RydWN0
IHBlcmZfc3RhdF9ldnNlbCAqcHMgPSBsZWFkZXItPnN0YXRzOw0KPiAgCXU2NCByZWFkX2Zvcm1h
dCA9IGxlYWRlci0+Y29yZS5hdHRyLnJlYWRfZm9ybWF0Ow0KPiAtCWludCBzaXplID0gcGVyZl9l
dnNlbF9fcmVhZF9zaXplKCZsZWFkZXItPmNvcmUpOw0KPiArCWludCBzaXplID0gZXZzZWxfX2dy
b3VwX3JlYWRfc2l6ZShsZWFkZXIpOw0KPiAgCXU2NCAqZGF0YSA9IHBzLT5ncm91cF9kYXRhOw0K
PiANCj4gIAlpZiAoIShyZWFkX2Zvcm1hdCAmIFBFUkZfRk9STUFUX0lEKSkNCj4gQEAgLTIyMTAs
OCArMjI2NCw3IEBAIHN0YXRpYyBpbnQgZXZzZWxfX29wZW5fY3B1KHN0cnVjdCBldnNlbCAqZXZz
ZWwsDQo+IHN0cnVjdCBwZXJmX2NwdV9tYXAgKmNwdXMsDQo+IA0KPiAgCWlmIChldnNlbF9faXNf
cmV0aXJlX2xhdChldnNlbCkpIHsNCj4gIAkJZXJyID0gdHBlYnNfc3RhcnQoZXZzZWwtPmV2bGlz
dCwgY3B1cyk7DQo+IC0JCWlmIChlcnIpDQo+IC0JCQlyZXR1cm4gZXJyOw0KPiArCQlyZXR1cm4g
ZXJyOw0KPiAgCX0NCj4gDQo+ICAJZXJyID0gX19ldnNlbF9fcHJlcGFyZV9vcGVuKGV2c2VsLCBj
cHVzLCB0aHJlYWRzKTsNCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdXRpbC9pbnRlbC10cGVi
cy5jIGIvdG9vbHMvcGVyZi91dGlsL2ludGVsLXRwZWJzLmMNCj4gaW5kZXggZDA5OWZjODA4MGUx
Li5hMzg1N2U4OGFmOTYgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3BlcmYvdXRpbC9pbnRlbC10cGVi
cy5jDQo+ICsrKyBiL3Rvb2xzL3BlcmYvdXRpbC9pbnRlbC10cGVicy5jDQo+IEBAIC0zNTQsMTAg
KzM1NCwxMSBAQCBpbnQgdHBlYnNfc2V0X2V2c2VsKHN0cnVjdCBldnNlbCAqZXZzZWwsIGludA0K
PiBjcHVfbWFwX2lkeCwgaW50IHRocmVhZCkNCj4gIAkgKi8NCj4gIAlpZiAoY3B1X21hcF9pZHgg
PT0gMCAmJiB0aHJlYWQgPT0gMCkgew0KPiAgCS8qIExvc3QgcHJlY2lzaW9uIHdoZW4gY2FzdGlu
ZyBmcm9tIGRvdWJsZSB0byBfX3U2NC4gQW55DQo+IGltcHJvdmVtZW50PyAqLw0KPiAtCQl2YWwg
PSB0LT52YWw7DQo+ICsJCXZhbCA9IHQtPnZhbCAqIDEwMDA7DQo+ICAJfSBlbHNlDQo+ICAJCXZh
bCA9IDA7DQo+IA0KPiArCWV2c2VsLT5zY2FsZSA9IDFlLTM7DQo+ICAJY291bnQtPnZhbCA9IHZh
bDsNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCg==
