Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D891B423C;
	Wed, 24 Sep 2025 22:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758752435; cv=fail; b=NV4XvLAfka8fpdjC1jicABONAL1wpBHCgSmZ5Yul+UjxWSKATgCgZRHD+V9+QEmm59VlUHY9IAWj+FYcOnD54Iik5ub7rzSlzLGxZKb0JjIX5vM2oRW2QktY7/XV8EhTPFffHHdj35g42+g0WAEmSFRGFEY/jmY0/joHCMYM4Ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758752435; c=relaxed/simple;
	bh=TdANX6AA2OOs4NaXyoB6ZxK1Bj/MnhjfOcH0GDcP8zg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IQfzC55m9iTA0guIMM0YGFqLaBTnrxw516cjBIlExk20U8e03xP6LQjrJLxhkGu75Kp3bMflkqVn0zneuzB+QKpwsjBPdZtf+gC7MD9EJ4J42xoK8M+Xj7D/CLvShkWJuTxjTwalltKL2DmOTeGJ/6Xz2Wic8Pgj+b0HZWUe7X0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bBAFTXWx; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bBAFTXWx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758752434; x=1790288434;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TdANX6AA2OOs4NaXyoB6ZxK1Bj/MnhjfOcH0GDcP8zg=;
  b=bBAFTXWx8cuR5jb1eJ4ojKXn9PRhTU1ZRQKvaSQG1ISerTo34uz6+CLU
   pf6wFXAobPUYABF2GNcGOL6A+cNon6qL/BDCQQJFegmUFDBwBzFgPfwjP
   AZ488VPNSJc9lAmdqtvbxZHDANdj4yCSRlSgEDT6hMl/1J0qqrc3kj7bv
   iUAUUT487frsIGmSu017B7/KCrs/6f/82nXnCfnVOOvVR9qdT/Ic3HTcf
   hs4hEPVtAx61/H1TOyvNMRV6GDUK24MblpalT167lk42LXQXcyDLGuO9Z
   M4QjcV0ropOydBpwfwSDC9t+UBcfwnt3VxSoGy1/UtBPFicoNWNckzXAb
   w==;
X-CSE-ConnectionGUID: +LDz6y0ORjGVoWUfAYck6Q==
X-CSE-MsgGUID: eOihltaFRMyNLQfjIT3pBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="72489470"
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="72489470"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 15:20:33 -0700
X-CSE-ConnectionGUID: VS9mxHCpS1+kSSBoG9q1tA==
X-CSE-MsgGUID: 7R345QCMRfaRXjA/C8G9kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,291,1751266800"; 
   d="scan'208";a="214276198"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 15:20:32 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 15:20:31 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 15:20:31 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.71) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 15:20:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lvg7W6ToYzlDA5EEV3rjZmdr1yi93DOaMvPShfff/BcdjRAwpD8r9KCsEkiQ06OmUmzhq5ATgGEqvA4Rrs3S1bOPUK9NgU6thyeLbES7onfi/cBSGSjOwb4ZnM4JkGlEwGn43zNBdyr9aZVBafcAaCkCMO8jEIKmR0NgpAafmPsEmRi2xarGPpnWkWVflG4Y38a5hvT+nXyig7nk50IJ3X903IZwgaSOOP/eriCcRCtDjVPKFS6Z20mEusXRbGF4jLFg4xnQadhze0mSTJvRGIf7T6LvzAJtq1mmaaQBVo1FVC+/w4za0elJlXoHEf+C4xnoCGKPuPzASR+pGF+OjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdANX6AA2OOs4NaXyoB6ZxK1Bj/MnhjfOcH0GDcP8zg=;
 b=TdUY2P1hfEAJs+AccOG4qlC/CtR8AmXLRSnbuAz3JAiIIj5/wV4biezGuzY2xtDaasN7eUXcHvG8n9W2fum8Ll59c7pBuV5KZF/+dQmE+mL0Z5/7gPeMK0fKhGk5nEGr6AqrT+GdK3zF3OQ9TQCz1tzKoFwM3AkB4WEabATsoe7AJLU6xuC/nNr8ZIhSHYbT2yTU81/Xeh3ewgCO+NEKrY3wYlx2idKzk+hRptkIeU4FwZU6IcvXWdz/Ty0a7kwRSLbqLMMflyw+p3YVcvPz2AwrOdpPgjbNF6DKZsqYDbdyYxW13E9UsNYrJQOurKZne5ZQlBm7dxEmhaBBp2AY+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM3PR11MB8714.namprd11.prod.outlook.com (2603:10b6:0:b::18) by
 CY8PR11MB7921.namprd11.prod.outlook.com (2603:10b6:930:7d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9; Wed, 24 Sep 2025 22:20:28 +0000
Received: from DM3PR11MB8714.namprd11.prod.outlook.com
 ([fe80::7b2a:697f:e19a:9bbe]) by DM3PR11MB8714.namprd11.prod.outlook.com
 ([fe80::7b2a:697f:e19a:9bbe%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 22:20:28 +0000
From: "Taylor, Perry" <perry.taylor@intel.com>
To: Ian Rogers <irogers@google.com>, "Falcon, Thomas"
	<thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"afaerber@suse.de" <afaerber@suse.de>, "Biggers, Caleb"
	<caleb.biggers@intel.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"acme@kernel.org" <acme@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mani@kernel.org" <mani@kernel.org>
Subject: RE: [PATCH v1 00/10] perf vendor events intel update
Thread-Topic: [PATCH v1 00/10] perf vendor events intel update
Thread-Index: AQHcLZ0tivpU8hAsGkmYncHts8patrSi5n8w
Date: Wed, 24 Sep 2025 22:20:06 +0000
Deferred-Delivery: Wed, 24 Sep 2025 22:19:45 +0000
Message-ID: <DM3PR11MB87142E7D40C472EA4CA0538F901CA@DM3PR11MB8714.namprd11.prod.outlook.com>
References: <20250924060229.375718-1-irogers@google.com>
 <5275b98eff5e686521c407f4d38eed8448be5a3b.camel@intel.com>
 <CAP-5=fVm+AY=cHE4izpwjUnSnZ=qyCmo55d6wJA-WCJo4Rp3cw@mail.gmail.com>
In-Reply-To: <CAP-5=fVm+AY=cHE4izpwjUnSnZ=qyCmo55d6wJA-WCJo4Rp3cw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8714:EE_|CY8PR11MB7921:EE_
x-ms-office365-filtering-correlation-id: 23b5c4f5-24d8-4c7f-eec8-08ddfbb89154
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dzBoV3JXNlhuWU1ZWDVFRDUwYXhiYzBUTDNRdFJlMXgyZTFzRnFHUVhWNlV4?=
 =?utf-8?B?NnlQZkZEaEk3SGpQei93MVhUSTBDWEJNOXZoOGN3WVYzUmdpOFZZeUpzeXFq?=
 =?utf-8?B?b0o0SWwrc1IxSkpsRGR4WE5jakt0Q2tTc21nNFROWkxBUXJ3Vzh6TVdZY2N4?=
 =?utf-8?B?WDFhRXhBRklDOXVveEhlZFF4ZFZZOFNKa0pCalk1eVRwbUFtRDRpSSthdk5p?=
 =?utf-8?B?OGdQYVNBRWpwbGZRYkVmbk1PMlR0Vzc0Ny9GS2JiS1h1bXpiZEErREtWVEtS?=
 =?utf-8?B?TnRFTmhTcXQyc3FTTHk3VjBHRHZyT0lwb2w1Wk8vVWY2NXBxdklEbjhDMlFK?=
 =?utf-8?B?U0JzKzN4MlB3b2RpVHpOK24zbk9SUU5wb01CcUFrYnJlc1BEQlVDcllhVEtv?=
 =?utf-8?B?ZnpXVGM5Y2FjcCs4S0FIZGxwdVhlbWpXbjE1NXl6YzVUOFBvckVob09QMERa?=
 =?utf-8?B?dU85WFN4WTdzd3ZNdHFTcE5uSThDbFZsVDB1ZHNxc0tiWXpyL0VuWFlETk45?=
 =?utf-8?B?RUNXYStRTmg1eEJQSWRRWlk0UkM4RVI0eVl0UThTUk5iOFcwMGR3aXZmdmVT?=
 =?utf-8?B?MkIvVmRKTGUwajE5WnZLK0V5RWVoMVhVd1JHZkUwK0UvN1BwaW95SjhNRmUz?=
 =?utf-8?B?WmNwYk1kWXdIVk1JRGlIamRWNjFHSXljREZ1eTlsMnJRcnVaZ2hKSU5DbEh2?=
 =?utf-8?B?V3lCSHNVYlRKK29qZjUvQTVuVGtsbEF1OUdLSHdKVWt4SkdMTjlXYTJVdEtV?=
 =?utf-8?B?VzN5NkJGdmtUZitwZE1EdXF2bjlNMEZodDdncVlyMERzMXJzRE54cldJdmhQ?=
 =?utf-8?B?alJMWWZlZVY1WDBNVVlkNUhEUS9uRlo5NVpIWGV6T1dudG5CRGhUZjRWMFI4?=
 =?utf-8?B?ZzBERGdGOE9IcTl3b0dxZDFRWWMyZ2Jsa1k0aW1Kdm5OR0pyUXExeXB5b2k5?=
 =?utf-8?B?aDByY284UFI3RXdZRVpKYmd2YTdzNGQwWjdDUlhhN284TUI0SExOVWt4cmE5?=
 =?utf-8?B?MmhaYVJJVUhnNE1EandraXFPcDcrK0Rlb0ZFSXFuQk9DYlJ4SWJockZpTU9z?=
 =?utf-8?B?V3Nrb3JZQy92RmpieUNPcHJDSjdEcS91ZzlFa0piTVV3VElkdXNuMWVuY0cy?=
 =?utf-8?B?TGJmR0NyMWVYMVpBNkFSall5akdtYm0zZXd6VjI4bmJKNHNaRTRrdkJTcER3?=
 =?utf-8?B?TjJpS2NQSklxN2pqNnJBRFlCUVRPNzdLTEszMFhiNnNPcDd4bFhDWXJIOXBY?=
 =?utf-8?B?WVR3K3c5Q0kyd0VaakxGWW9wVG1TT3lmNnl1UHpsWTQ3OFpyM2o1ZWVGNmE5?=
 =?utf-8?B?YWpKYjByblNuOHJMZ090cE9qNzFKVkRHV2JFa0ttMUZlc296R1hhNjl3UWVN?=
 =?utf-8?B?SjFHSVlkR3JkeWZscXY2dXQ0NHBSMXQ1QlJvWEhMakNqcTU1ZGVUZWpwOWJr?=
 =?utf-8?B?WCtNWnJvN0VJQkZoaGd4NGJyN0YxcFVEZmUwRFRJcWIzVE91aTRuUkc2OURM?=
 =?utf-8?B?VFpILzZWYjFGUFBGK2FUQTJ3RFpxRXBGYzVMakRoYW9FRVZSWko0MCtJT1pu?=
 =?utf-8?B?TzJQU3FjalVRamJwOW55cEJ4MWZFcGI1c3ZOWkRCckFGbmN2bDZETEhMVXI5?=
 =?utf-8?B?aEpJWHl6M3JiQnJZNVhCR3lEZjFTNlhtZ0ttTDhvajRFY0srZjRXVjBQQjBB?=
 =?utf-8?B?bCtKVDh3d2pvQUJ5WFlXTVFtRFZTaHB1K1NtRFRXRUk1UFpjZlFZZGVzZjBX?=
 =?utf-8?B?dlFZZjI0djRodkhxNlA5ditZUnQ4UXNWcGs5SlBLTFFoOCsvODRyeGIwT3By?=
 =?utf-8?B?RldKbGwyOFkwaUQydXFvS1pIM2JuUU5DRFltUHJzY0lPQnFXRnUwcGZuUjNW?=
 =?utf-8?B?ZFA1TzQxSUZEZWdDRUxyTGtlbWd6azAraTN2RmNmTElLbytHT0ZLZERoT3c1?=
 =?utf-8?B?UW9lVGtjSk5qS3B3TTRydEJra0hjdmx4UDlPaWV6L2owVmR3dVYrLzdoN3k1?=
 =?utf-8?Q?BEtEu3Nf3qXic2xPIw+IeL8OH9vK14=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8714.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUQyUmtqbDNJaEpsOE9kYTFhbVVhc3J3dUtnd2FmT3pMUk5sOVJKQ2pXNngv?=
 =?utf-8?B?aU14TkNTNlFSK0ZjMkw0ZjNhTjdFa2dyb28vWk85aDNjdlliQW5mRkhvdktq?=
 =?utf-8?B?ZEUvUUtSK0R4OGlSNng1ZHZCQ1VzR3NWUVFIQml5eXZST29RNDZFNVgxY2Vv?=
 =?utf-8?B?NC91dU9WOWRyQWd1QWFWN1RoRVRQUXUreFh6M2crQWY1TzZQd3o3U2Y5Nk8r?=
 =?utf-8?B?b0pDQk5RVjZHWmdZS2preTZyeW9BcEZnV2RKSytMTWVIQmFrNmt4S2RZZU9M?=
 =?utf-8?B?MFJEYTdkUTU4b0VuUTFLR2JxbjJzeHJmZm8rSDFldFFFRUtIVEZIclJyMDZD?=
 =?utf-8?B?cENUcFMxbkY3MXdFN28zNFg5MVU2MHBMTXZaU3JuQWtpSk1YcG1ic3F5Ykdr?=
 =?utf-8?B?STFBRWYwejdOSzRnczRXTXFoSldhUng0akxwQ1hCVHJaYmxGVThQUmJxWFQ4?=
 =?utf-8?B?cmZIYjVDdlNqd0UvVGxpei8ydVNZRnJ4dzNJdUFtS0dwckFuWWl1Tkpnb0w0?=
 =?utf-8?B?T3F3d2kyRDIwUlB2SmgzL2dLblRkc3J1d1M3Wlc0T2F4UkpFVnNWV0t5TFBz?=
 =?utf-8?B?TVh3bkhzY3pQbjVQSWplZENJK1BiOWE1Mk9XZkRIRjJnMzVjeFV2NjNlaFI2?=
 =?utf-8?B?NTlIK2JmMGZmNlhjcnRQY0FuSjJkcjNjRW9mQ0tqMnpZY24zM2thczZEVG5n?=
 =?utf-8?B?TG5GK282U1VSd0YzQ2x0WEZiUVRRa2Y2bEtFUlNudmN6VW5NakRXaVNzdWts?=
 =?utf-8?B?ZzlZYmgrVWp5MEMrMTk4cjIzbDFXdnVIU0hWQkJzYWl6WW1mTjY3Q002NXZE?=
 =?utf-8?B?eHRUb0pIUXdsL09USXdFYlhOTEJlZksxQTE2Y3pBVFY2cWw1aXFtMWRRTmFH?=
 =?utf-8?B?ekZ5ZTdUcTFRc0lEcDdRb1ZSaTVuRDdDT09DdCszQmdFT0YyZFd4TGdBbUJ2?=
 =?utf-8?B?Ly9mdXFWRjdaMXNlRmdEV0s1Umo2bEhhMU54QWR6dlJ0OEZPTFBNbDh4L0Qx?=
 =?utf-8?B?VGcrOE9mSEtlTkpCcEdRRzByNHFTc1JQSDVaL0ZublRXdzhseDBYT3c0cmQ2?=
 =?utf-8?B?ckxsVjlzTTJTNU03R2NrUlpWTmtlN0RoVnJ2SEs5RFR4eUNpbmsxeU11OEh2?=
 =?utf-8?B?VGtBODlweXIxM01MZ0paQzJ1SmNXUWl1LytPaUlWTjc4cUNoMjNpc2ttNUM3?=
 =?utf-8?B?TXVnVHpUdlJ4NE1FcVQzTkdnR3daS2JqOGtwMGg4SlpBVzlKYlozdVdCZjF4?=
 =?utf-8?B?Yi93Q0xCdisxNEZXTTdpWEU5SFYvSkZwTlJXcFNqWUJBUGExbEtXVVE2SEdm?=
 =?utf-8?B?YWtnV0ZmN0NxN3c5djlkVlBUSlJMQXExWkpvWHFkUHAzVmtUTitTd0pycEtJ?=
 =?utf-8?B?M2xEaTNjNGpUelZEZENrQ0xCYUREek5idTByd3YrRzlJN2pZOFFzWUYxT1hw?=
 =?utf-8?B?RmlhOGxwSkl3OFVoSHFyd0Nrc0NVK2RlK1hYNmh4M0RDeXVYYXdCaHY1TVVR?=
 =?utf-8?B?Y2VpeWI5ZDRHRVFDN0ZJY0JuQnlyZ2hRYVZsLy9xVklIUTJNNzdMQWlGTjNK?=
 =?utf-8?B?TERHdnJ1NjllNnRVRzQ0RGo1RHdOQVk0MUc2dGZRSk1Band0ZjJra0FGSHpL?=
 =?utf-8?B?Z2xNM2JleS9wcEh2d0Fjc043Q3BLbHBtREUxNlN2NWZ2UGtjM0R0aVFnWERw?=
 =?utf-8?B?cGlTbGU5eWZpVXZRZGV1dmpIVndYWllRam9xYTVxUXhUYlNHVEhtcHFvMWJJ?=
 =?utf-8?B?anFsTC95RmVTOU01WVBHcGVVSGEyKy93d05SeXEzeE9rNXZPSGk3RTI4RDhh?=
 =?utf-8?B?WkJUdklEWTBwcU9WbjZldE9xakhoQndiUm1vWnNraU5Ga0VlSmkxMzR3dDdm?=
 =?utf-8?B?VmJHUDk2Wm5UcVB0NFFQaHdJV1p5aDJzakl3azB3VlBoY0FBcE5qQlRtNU14?=
 =?utf-8?B?UmRFNzlBdjlIWjFRRzdtd0VsMFdQbjZJTGtrSHZyam5JZWVaS3BZUEZCblFX?=
 =?utf-8?B?N2k4eFBrUXdHbWpSZEd0NDhHMG5RVkQwMTFHSlVTcmhacjVKRlYzMWFhQllm?=
 =?utf-8?B?YnBqZy9xYWhhSVpVWEI3WER5ZTRSNEh0eG9BM1RFb1BRcDVoM3JmRU5tK0p5?=
 =?utf-8?Q?4vFbVhetsqGSVL0cr/vftE5js?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8714.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b5c4f5-24d8-4c7f-eec8-08ddfbb89154
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 22:20:28.7136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ShauTg0vHeAixLhFCDFR4SnZu3vPKZQChuM2Td3wvc9PRrZBjTrdbBZH49P7Bsc/bV+zmuiwtL7XXAXwAPIl/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7921
X-OriginatorOrg: intel.com

T2ssIGFmdGVyIGxvb2tpbmcgdGhyb3VnaCB0aGlzIG1vcmUgY2FyZWZ1bGx5LCBvbiBTUFIvRU1S
IEkgY2FuIHJld3JpdGUgdGhlIG1ldHJpYyB0byB1c2UgJ3BjdScgaW5zdGVhZCBvZiAncGN1XzAn
IGFzIENUIG9yaWdpbmFsbHkgc3RhdGVkIHNpbmNlIHRoZXkgaGF2ZSBvbmx5IDEgUENVIHBlciBz
b2NrZXQuIA0KSWYgdGhlcmUgYXJlIG5vIG9iamVjdGlvbnMsIEknbGwgc3RhcnQgb24gYW4gdXBk
YXRlLg0KDQpUaGFua3MsDQpQZXJyeQ0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpG
cm9tOiBJYW4gUm9nZXJzIDxpcm9nZXJzQGdvb2dsZS5jb20+IA0KU2VudDogV2VkbmVzZGF5LCBT
ZXB0ZW1iZXIgMjQsIDIwMjUgMjo1MCBQTQ0KVG86IEZhbGNvbiwgVGhvbWFzIDx0aG9tYXMuZmFs
Y29uQGludGVsLmNvbT47IENodW4tVHNlIFNoYW8gPGN0c2hhb0Bnb29nbGUuY29tPjsgVGF5bG9y
LCBQZXJyeSA8cGVycnkudGF5bG9yQGludGVsLmNvbT4NCkNjOiBhbGV4YW5kZXIuc2hpc2hraW5A
bGludXguaW50ZWwuY29tOyBhZmFlcmJlckBzdXNlLmRlOyBCaWdnZXJzLCBDYWxlYiA8Y2FsZWIu
YmlnZ2Vyc0BpbnRlbC5jb20+OyBwZXRlcnpAaW5mcmFkZWFkLm9yZzsgYWNtZUBrZXJuZWwub3Jn
OyBtaW5nb0ByZWRoYXQuY29tOyBIdW50ZXIsIEFkcmlhbiA8YWRyaWFuLmh1bnRlckBpbnRlbC5j
b20+OyBsaW51eC1wZXJmLXVzZXJzQHZnZXIua2VybmVsLm9yZzsgbmFtaHl1bmdAa2VybmVsLm9y
Zzsgam9sc2FAa2VybmVsLm9yZzsga2FuLmxpYW5nQGxpbnV4LmludGVsLmNvbTsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgbWFuaUBrZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENI
IHYxIDAwLzEwXSBwZXJmIHZlbmRvciBldmVudHMgaW50ZWwgdXBkYXRlDQoNCk9uIFdlZCwgU2Vw
IDI0LCAyMDI1IGF0IDI6MTPigK9QTSBGYWxjb24sIFRob21hcyA8dGhvbWFzLmZhbGNvbkBpbnRl
bC5jb20+IHdyb3RlOg0KPg0KPiBPbiBUdWUsIDIwMjUtMDktMjMgYXQgMjM6MDIgLTA3MDAsIElh
biBSb2dlcnMgd3JvdGU6DQo+ID4gVXBkYXRlIGV2ZW50cyBhbmQgc29tZSBtZXRyaWNzIHRvIHRo
ZSBsYXRlc3QgcGVyZm1vbiB2ZXJzaW9uczoNCj4gPiAgLSBhbGRlcmxha2UgMS4zNA0KPiA+ICAt
IGFycm93bGFrZSAxLjEzDQo+ID4gIC0gZW1lcmFsZHJhcGlkcyAxLjIwDQo+ID4gIC0gZ3JhbmRy
aWRnZSAxLjEwDQo+ID4gIC0gZ3Jhbml0ZXJhcGlkcyAxLjE1DQo+ID4gIC0gbHVuYXJsYWtlIDEu
MTgNCj4gPiAgLSBtZXRlb3JsYWtlIDEuMTcNCj4gPiAgLSBzYXBwaGlyZXJhcGlkcyAxLjM1DQo+
ID4gIC0gc2llcnJhZm9yZXN0IDEuMTINCj4gPg0KPg0KPiBNZXRyaWNzIHRlc3RzIHBhc3NlZCBv
biBBbGRlciBMYWtlLCBTYXBwaGlyZSBSYXBpZHMsIGFuZCBBcnJvdyBMYWtlLg0KPg0KPiBUZXN0
ZWQtYnk6IFRob21hcyBGYWxjb24gPHRob21hcy5mYWxjb25AaW50ZWwuY29tPg0KDQpUaGFua3Mh
IEkgdGhpbmsgd2UgZm91bmQgYW4gaXNzdWUgb24gZW1lcmFsZHJhcGlkcyB0aGF0IHBjdV8wL1VO
Q19QX0NMT0NLVElDS1MvIHNob3VsZCBiZSBwY3UvVU5DX1BfQ0xPQ0tUSUNLUy8gaW4gdGhlIGNw
dV9jc3RhdGUgbWV0cmljcy4gVGhlIHF1ZXN0aW9uIGlzLCBob3cgbWFueSBQQ1VzIGRvZXMgYW4g
ZW1lcmFsZHJhcGlkcyBoYXZlPyBJcyBpdCBndWFyYW50ZWVkIHRvIGJlIDEgb3IgZG8gd2UgbmVl
ZCB0byBzdXBwb3J0IHN1ZmZpeGVzIHdoZW4gdGhlcmUgaXMgPjEuIEknbSBndWVzc2luZyB0aGUg
c3Rvcnkgb24gc2FwcGhpcmVyYXBpZHMgaXMgc2ltaWxhciwgd2UganVzdCBkaWRuJ3QgdGVzdCBp
dC4NCg0KVGhlIHVzZSBvZiBhIHN1ZmZpeCBpbiB0aGUgUE1VIG9mIHRoZSBldmVudCBuYW1lIGlz
IHRvIGF2b2lkIGFnZ3JlZ2F0aW5nIGFsbCB0aGUgY2xvY2t0aWNrcyB0b2dldGhlci4gIEEgbGVz
cyBlZmZpY2llbnQgd2F5IHRvIGRvIHRoaXMgd291bGQgYmUgIlVOQ19QX0NMT0NLVElDS1MgLyBz
b3VyY2VfY291bnQoVU5DX1BfQ0xPQ0tUSUNLUykiDQp3aGljaCB3b3VsZCBjb21wdXRlIGFuIGF2
ZXJhZ2Ugb2YgdGhlIGNsb2NrdGlja3MuIFdlIGNvdWxkIHVwZGF0ZSBwZXJmIHRvIGlnbm9yZSBf
MCBzdWZmaXhlcyB3aGVuIGxvb2tpbmcgZm9yIFBNVXMsIHdoaWNoIGZlZWxzIGtpbmQgb2YgaGFj
a3kgYW5kIEFSTSBoYXMgZGlmZmVyZW50IHN1ZmZpeCBjb252ZW50aW9ucy4gV2UgY291bGQgZG86
DQoicGN1XzBAVU5DX1BfQ0xPQ0tUSUNLU0AgaWYgaGFzX2V2ZW50KHBjdV8wQFVOQ19QX0NMT0NL
VElDS1NAKSBlbHNlIHBjdUBVTkNfUF9DTE9DS1RJQ0tTQCINCndoaWNoIGZlZWxzIGEgbGl0dGxl
IGxvbmcgd2luZGVkLiBJZiB3ZSBrbm93IEVNUiBhbmQgU1BSIGhhdmUganVzdCAxIFBDVSBJIHRo
aW5rIEknZCBwcmVmZXIganVzdCB0byB0dXJuIHBjdV8wIGludG8gcGN1IGFzIGEgZml4Lg0KDQpU
aGFua3MsDQpJYW4NCg0KPiBUaGFua3MsDQo+IFRvbQ0KPg0KPiA+IElhbiBSb2dlcnMgKDEwKToN
Cj4gPiAgIHBlcmYgdmVuZG9yIGV2ZW50cyBpbnRlbDogVXBkYXRlIGFsZGVybGFrZSBldmVudHMg
dG8gdjEuMzQNCj4gPiAgIHBlcmYgdmVuZG9yIGV2ZW50cyBpbnRlbDogVXBkYXRlIGFycm93bGFr
ZSBldmVudHMgdG8gdjEuMTMNCj4gPiAgIHBlcmYgdmVuZG9yIGV2ZW50cyBpbnRlbDogVXBkYXRl
IGVtZXJhbGRyYXBpZHMgZXZlbnRzIHRvIHYxLjIwDQo+ID4gICBwZXJmIHZlbmRvciBldmVudHMg
aW50ZWw6IFVwZGF0ZSBncmFuZHJpZGdlIGV2ZW50cyB0byB2MS4xMA0KPiA+ICAgcGVyZiB2ZW5k
b3IgZXZlbnRzIGludGVsOiBVcGRhdGUgZ3Jhbml0ZXJhcGlkcyBldmVudHMgdG8gdjEuMTUNCj4g
PiAgIHBlcmYgdmVuZG9yIGV2ZW50cyBpbnRlbDogVXBkYXRlIGx1bmFybGFrZSBldmVudHMgdG8g
djEuMTgNCj4gPiAgIHBlcmYgdmVuZG9yIGV2ZW50cyBpbnRlbDogVXBkYXRlIG1ldGVvcmxha2Ug
ZXZlbnRzIHRvIHYxLjE3DQo+ID4gICBwZXJmIHZlbmRvciBldmVudHMgaW50ZWw6IFVwZGF0ZSBw
YW50aGVybGFrZSBldmVudHMgdG8gdjEuMDANCj4gPiAgIHBlcmYgdmVuZG9yIGV2ZW50cyBpbnRl
bDogVXBkYXRlIHNhcHBoaXJlcmFwaWRzIGV2ZW50cyB0byB2MS4zNQ0KPiA+ICAgcGVyZiB2ZW5k
b3IgZXZlbnRzIGludGVsOiBVcGRhdGUgc2llcnJhZm9yZXN0IGV2ZW50cyB0byB2MS4xMg0KPiA+
DQo+ID4gIC4uLi9wbXUtZXZlbnRzL2FyY2gveDg2L2FsZGVybGFrZS9jYWNoZS5qc29uICB8ICAg
MzYgKw0KPiA+ICAuLi4vcG11LWV2ZW50cy9hcmNoL3g4Ni9hcnJvd2xha2UvY2FjaGUuanNvbiAg
fCAgIDQ2ICstDQo+ID4gIC4uLi9wbXUtZXZlbnRzL2FyY2gveDg2L2Fycm93bGFrZS9tZW1vcnku
anNvbiB8ICAgIDYgKy0NCj4gPiAgLi4uL3BtdS1ldmVudHMvYXJjaC94ODYvYXJyb3dsYWtlL290
aGVyLmpzb24gIHwgICAgMiArLQ0KPiA+ICAuLi4vYXJjaC94ODYvZW1lcmFsZHJhcGlkcy9jYWNo
ZS5qc29uICAgICAgICAgfCAgIDYzICsNCj4gPiAgLi4uL2FyY2gveDg2L2VtZXJhbGRyYXBpZHMv
ZW1yLW1ldHJpY3MuanNvbiAgIHwgICAxMiArDQo+ID4gIC4uLi9hcmNoL3g4Ni9lbWVyYWxkcmFw
aWRzL3VuY29yZS1jYWNoZS5qc29uICB8ICAgMTEgKw0KPiA+ICAuLi4vYXJjaC94ODYvZW1lcmFs
ZHJhcGlkcy91bmNvcmUtbWVtb3J5Lmpzb24gfCAgIDIyICsNCj4gPiAgLi4uL2FyY2gveDg2L2Vt
ZXJhbGRyYXBpZHMvdW5jb3JlLXBvd2VyLmpzb24gIHwgICAgMiAtDQo+ID4gIC4uLi9wbXUtZXZl
bnRzL2FyY2gveDg2L2dyYW5kcmlkZ2UvY2FjaGUuanNvbiB8ICAgMjAgKy0NCj4gPiAgLi4uL2dy
YW5pdGVyYXBpZHMvdW5jb3JlLWludGVyY29ubmVjdC5qc29uICAgIHwgICAxMCArLQ0KPiA+ICAu
Li4vYXJjaC94ODYvZ3Jhbml0ZXJhcGlkcy91bmNvcmUtbWVtb3J5Lmpzb24gfCAgMTEyICsrDQo+
ID4gIC4uLi9wbXUtZXZlbnRzL2FyY2gveDg2L2x1bmFybGFrZS9jYWNoZS5qc29uICB8ICAgNDYg
Ky0NCj4gPiAgLi4uL3BtdS1ldmVudHMvYXJjaC94ODYvbHVuYXJsYWtlL21lbW9yeS5qc29uIHwg
ICAgNiArLQ0KPiA+ICAuLi4vcG11LWV2ZW50cy9hcmNoL3g4Ni9sdW5hcmxha2Uvb3RoZXIuanNv
biAgfCAgICAyICstDQo+ID4gIHRvb2xzL3BlcmYvcG11LWV2ZW50cy9hcmNoL3g4Ni9tYXBmaWxl
LmNzdiAgICB8ICAgMjAgKy0NCj4gPiAgLi4uL3BtdS1ldmVudHMvYXJjaC94ODYvbWV0ZW9ybGFr
ZS9jYWNoZS5qc29uIHwgICAzNiArDQo+ID4gIC4uLi9hcmNoL3g4Ni9wYW50aGVybGFrZS9jYWNo
ZS5qc29uICAgICAgICAgICB8IDEyMDcgKysrKysrKysrKy0NCj4gPiAgLi4uL2FyY2gveDg2L3Bh
bnRoZXJsYWtlL2NvdW50ZXIuanNvbiAgICAgICAgIHwgICAgOSArLQ0KPiA+ICAuLi4vYXJjaC94
ODYvcGFudGhlcmxha2UvZmxvYXRpbmctcG9pbnQuanNvbiAgfCAgMjg2ICsrKw0KPiA+ICAuLi4v
YXJjaC94ODYvcGFudGhlcmxha2UvZnJvbnRlbmQuanNvbiAgICAgICAgfCAgNTM1ICsrKysrDQo+
ID4gIC4uLi9hcmNoL3g4Ni9wYW50aGVybGFrZS9tZW1vcnkuanNvbiAgICAgICAgICB8ICAxMDYg
Ky0NCj4gPiAgLi4uL2FyY2gveDg2L3BhbnRoZXJsYWtlL290aGVyLmpzb24gICAgICAgICAgIHwg
ICA0NCArDQo+ID4gIC4uLi9hcmNoL3g4Ni9wYW50aGVybGFrZS9waXBlbGluZS5qc29uICAgICAg
ICB8IDE3NzYNCj4gPiArKysrKysrKysrKysrKysrLQ0KPiA+ICAuLi4vYXJjaC94ODYvcGFudGhl
cmxha2UvdW5jb3JlLW1lbW9yeS5qc29uICAgfCAgIDI2ICsNCj4gPiAgLi4uL2FyY2gveDg2L3Bh
bnRoZXJsYWtlL3ZpcnR1YWwtbWVtb3J5Lmpzb24gIHwgIDI0OCArKysNCj4gPiAgLi4uL2FyY2gv
eDg2L3NhcHBoaXJlcmFwaWRzL2NhY2hlLmpzb24gICAgICAgIHwgICA2MyArDQo+ID4gIC4uLi9h
cmNoL3g4Ni9zYXBwaGlyZXJhcGlkcy9zcHItbWV0cmljcy5qc29uICB8ICAgMTIgKw0KPiA+ICAu
Li4vYXJjaC94ODYvc2FwcGhpcmVyYXBpZHMvdW5jb3JlLWNhY2hlLmpzb24gfCAgIDExICsNCj4g
PiAgLi4uL3g4Ni9zYXBwaGlyZXJhcGlkcy91bmNvcmUtbWVtb3J5Lmpzb24gICAgIHwgICAyMiAr
DQo+ID4gIC4uLi9hcmNoL3g4Ni9zYXBwaGlyZXJhcGlkcy91bmNvcmUtcG93ZXIuanNvbiB8ICAg
IDIgLQ0KPiA+ICAuLi4vYXJjaC94ODYvc2llcnJhZm9yZXN0L2NhY2hlLmpzb24gICAgICAgICAg
fCAgIDYxICstDQo+ID4gIC4uLi94ODYvc2llcnJhZm9yZXN0L3VuY29yZS1pbnRlcmNvbm5lY3Qu
anNvbiB8ICAgMTAgKy0NCj4gPiAgLi4uL2FyY2gveDg2L3NpZXJyYWZvcmVzdC91bmNvcmUtaW8u
anNvbiAgICAgIHwgICAgMSAtDQo+ID4gIC4uLi9hcmNoL3g4Ni9zaWVycmFmb3Jlc3QvdW5jb3Jl
LW1lbW9yeS5qc29uICB8ICAxMDMgKy0NCj4gPiAgMzUgZmlsZXMgY2hhbmdlZCwgNDcxMiBpbnNl
cnRpb25zKCspLCAyNjIgZGVsZXRpb25zKC0pICBjcmVhdGUgbW9kZSANCj4gPiAxMDA2NDQgdG9v
bHMvcGVyZi9wbXUtIA0KPiA+IGV2ZW50cy9hcmNoL3g4Ni9wYW50aGVybGFrZS9mbG9hdGluZy1w
b2ludC5qc29uDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy9wZXJmL3BtdS0NCj4gPiBl
dmVudHMvYXJjaC94ODYvcGFudGhlcmxha2Uvb3RoZXIuanNvbg0KPiA+ICBjcmVhdGUgbW9kZSAx
MDA2NDQgdG9vbHMvcGVyZi9wbXUtDQo+ID4gZXZlbnRzL2FyY2gveDg2L3BhbnRoZXJsYWtlL3Vu
Y29yZS1tZW1vcnkuanNvbg0KPiA+DQo+DQo=
