Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3C480024;
	Fri, 31 May 2024 06:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717138011; cv=fail; b=NRUoFG7zAQYQrvY1n1aPHxJzF27YH0jKDVivdlF6/cOHyOoUWtphIcKFAdQ102skj1qNecaW6kypfpx8CV0YKmJSZZgAkkiKRUx1znHyTqjEdOY7xAf56FgjM24Xh43IM9wGJvi/YpTNnA1/klXwjzE87D2Hn9xDkr101fTqPCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717138011; c=relaxed/simple;
	bh=6vR3p2FbgtOZBUuh7BEEYCDFewtwX90VyIaMFX87Qwg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dTSLO6Cpj1/j6zeosQl9FmMWh/pRosNJySVIhLlx9KcCCJAEdbuxjkrJioCKBGOLQlIYSh6bgC53C+ZfvtSfq0D9wW+tmX1VVSOwN+kZRHaX8hplzn5b9BWHt9qFGT1cHutvSkOgxfxC+CeVxEMq3z/oOHqRLEItf+rsm/LtWHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nv5W2IFF; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nv5W2IFF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717138011; x=1748674011;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6vR3p2FbgtOZBUuh7BEEYCDFewtwX90VyIaMFX87Qwg=;
  b=nv5W2IFFki6wtanNdz9TGp7u3+Zlc64n9eTKICBS7jnufW7rcPhc4rk0
   b796/jDcXOV2D8mVedxBObyEVcHkcj1WWzqNb9ysFLs/aeJD1BZnWanez
   7SDAKhsEaUKhQVIWV9oORpkWm2UjlG7HeZhOrTmZU0B6habW3kUiuWy5e
   ljeHEhCVrs1YgscUa5JXuWrYm1JXT/A16bId30bExcIK6MbShFYZseGPZ
   wtThuuwlYwYc5Srxf6R0jaK5JUwGTAdDtid3tRKjdnkmdren/cgdFzqFx
   SYFGKVAsQZkjVobhyaUs3xykCcSfYGWEEAhwtWQpIPw6bhMf2CgG0tpRe
   A==;
X-CSE-ConnectionGUID: 27vfkztgRVi+hgt4/P7IMg==
X-CSE-MsgGUID: Ga450RsFQCOgDKxvIDnC9A==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="24790413"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="24790413"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 23:46:50 -0700
X-CSE-ConnectionGUID: ULHEIzzAQXeuYywT2ztHqw==
X-CSE-MsgGUID: iWN8pn85TDmi7foowPhpAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="36644624"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 23:46:50 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 23:46:49 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 23:46:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 23:46:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 23:46:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUlwhyOukyDoIiflPEdbIj2pe1bml8XxBr374k9w88YsoQcixeCSPCyj86T8l5EzSzDQKlXtzxBZY8IgIRuVhwKl/ibHlICwNRmAnSoREScD2URQvKNbsIgagAYhG475VegHQwhySwJx6IZQ3Fsilx0YYfugCAyLwqi43JYqhL8AtQxn0Mnv4C77LhmmkYZ3QI3/cGMm4IH3TT3+fajmCz4C3FllxISPkQnsxDcELFyhqo3mghB0QEGQEOdzwvTIUOuhs9TsURL5tKf7MqQWrN/lbBaN/5to+8UxkJxC1Ygj0Td846qpQ8Vsep/g91rIgg4UMYtwTXISJ+cBRJRfog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vR3p2FbgtOZBUuh7BEEYCDFewtwX90VyIaMFX87Qwg=;
 b=O70HH1CB/8BkC97PkIUz1TUaYomngAjfIYikWWdaDXUopjrmwOjHbUh5N50OKVxQwjWy096tAFAunTxMHn6+Jc56Z7LtMRWx/qu4/4yo88mPxBzZQPij4qkCGUCQoshsQSdMqM3YdagYdT5C4SZPJCedGdAK/5LDXunbmxaH1TA86H805DkxzWwi8HXMFOisHRyWEcPDKnCWxEEEGXAFNzFguhQw48xZaZgBQgwEOCASMYsCDCQKPjgMOaDsNkwwF791lZVGRcYL7ZN1i/KEltsazVbvqScsXUjMHit31pz0J35Qhe7KtH1pfkRxzRmwQQ7RElzj7eZjmtIGe9+Lbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by IA1PR11MB7890.namprd11.prod.outlook.com (2603:10b6:208:3ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 06:46:41 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%4]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 06:46:41 +0000
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
Subject: RE: [RFC PATCH v10 3/8] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Thread-Topic: [RFC PATCH v10 3/8] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Thread-Index: AQHasZOLBmxpfW94l0mGq/Yp4ybyB7Gw59CAgAAAZpA=
Date: Fri, 31 May 2024 06:46:41 +0000
Message-ID: <CO6PR11MB56357F58D99B17CD08671A26EEFC2@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240529064327.4080674-1-weilin.wang@intel.com>
 <20240529064327.4080674-4-weilin.wang@intel.com>
 <CAM9d7cgSwZ3PU3H9VNvxQakocEZ_CQEqB9M1o3xTMdJ7F1sufQ@mail.gmail.com>
In-Reply-To: <CAM9d7cgSwZ3PU3H9VNvxQakocEZ_CQEqB9M1o3xTMdJ7F1sufQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|IA1PR11MB7890:EE_
x-ms-office365-filtering-correlation-id: 75d3aa14-92b2-4e5d-2508-08dc813d6db8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?QTZDaTgyOU1abXRNL0s1bDgvM2xRcE1KMEVuZ0lXeHQ1Wi83OVJGNFlrZDZN?=
 =?utf-8?B?UmJlSHhzVUtlVEU3aFlzUzQwVWJETFFvQU4vV3doSTUzYzNsbFVpT1paV3Vp?=
 =?utf-8?B?UEFRakFlbDhZODhTUjN3VGlZQXhjL3I0NW5CZ2pRSU1RVTFJVGYzd2dsVGhU?=
 =?utf-8?B?TDdCSU9RWVUvcTNLcnFxN2l3Z3BqUFY3THFwTHR5MHBTTnRKSFp2bDl1d1pR?=
 =?utf-8?B?R29URGlsWVV5UWJoZVdvd1hrbGZ0MkZYcWQwRnN2UExaUDkzenBKWXVOQ2hJ?=
 =?utf-8?B?RDJrOUhrUlVDY2JZNFNMOWsySEZjVEhvcEthL21YUWxrNVVVU2lyMEhkVVFW?=
 =?utf-8?B?cmF3dXM5Mmc4V0xlME9KLzdMU0w4WTV1MStJOXVrbEZTa1NYdjJoN0dDeWk1?=
 =?utf-8?B?MFRPdWZPejkvcUVHMkcvZTJVeno0VE5yWTRPd3gzRnRuQitLQ0hoSkQva0o5?=
 =?utf-8?B?eGJUU2xjRzJjNlExNnYyYTdERm13bXRFVUhsREQ3S1NIdE1pSU5Xcm85alpj?=
 =?utf-8?B?UmZRbHRMdDBtdTdJaXlJeDlGZk5UOE5MdlR2N25NSGQvUU9BcnRsenRKV2ox?=
 =?utf-8?B?WEFaR0QvKzhhU0NJeHVRMVc0SlNaVGsyRkIwV3BCODgvQkZKc1l5UmhaakNy?=
 =?utf-8?B?ZHNlaS93eHorTHBhY2Nad3Y4SjhjRFZnSjFQM01VOUVkN05MUGtLQzlrdHB1?=
 =?utf-8?B?Y2ZnWitZd3NibGdZcDBrVWFLbS85MnlVdXlOVWZ4R2xpbFJHdzNPNHJvdDE0?=
 =?utf-8?B?Y2h0TzFFU0NZdWVNdVRxV1VlS2NlaTRrbzQ5Q3N2cVlkbWZSTlc5bmh1T2Ft?=
 =?utf-8?B?M3RsMHNFd0pOVkhDaWZVeFlTbkcrS3d6S2FaamxUaHo3bzU0ZndOTFZSYmVF?=
 =?utf-8?B?Y2xjUUJWVDZHT3lKWm9FMW9xZVJXdE45bGgzakNvU2V6NmQzQmI0eTIzZmlO?=
 =?utf-8?B?akFIVmlaUS9sd0ZOWS9yV1BIbzhnNU8rSnYveHFqSXBDSmJSVTUvcDEzTDdO?=
 =?utf-8?B?MmtjOVNmY0hrS1djTG52c29LSkE1M0p5ZDJUZFBsVTNMdWFHdVZyTTliSm8r?=
 =?utf-8?B?OTJzcFBFTmhSWWpKNzBlNzM0cWViQ3VtRjIydzBiZHBLMHd5aUM5ZVZqK1Jp?=
 =?utf-8?B?NXBKN08zSVVvaUV0SW9uTXdiZ0c2RzMraDE0d1NPREZkT3NQZjFpMUJOZWVX?=
 =?utf-8?B?TWdtMGNXd3hXOWhBdUFvaCtQY3VMdWI3bmIrTjVrSjFFYktxV0hPMmNGc3Bo?=
 =?utf-8?B?d2JQQ21udDJmeHhDMTZNM0pIQURpSUc4Z1E0ejFtRHB0MFJTZnFGNnlyTk5a?=
 =?utf-8?B?d3prUDZHdFdwT0Z4UUhKWlR6Wmgrbm0rSjM2ODgxQmxNK0k2cm4yTDIvTS9T?=
 =?utf-8?B?R2VzT1Z2OXpDMEtOdlRLaXRpbTVsNXBzLytlazRjL0xwWEFUWXE2Ylc2UzIr?=
 =?utf-8?B?MXNZNDRwNlBTelZzcjdxYWJMNGltcmRSbFFPQ1lRMjR4NHJCSDRiNnFnb2ZO?=
 =?utf-8?B?d2RZVlVjRmMxWkpBdDRyTFBqQ3NSVTQyR0Q2SWhTc3ZRWkdlR2lIS1p5M2RI?=
 =?utf-8?B?SitCZW9UN3FJZzVoN2EzVC9tUFN4QmhwSlJMT0xZNlJIR096V2dEbitMbXd1?=
 =?utf-8?B?OHRPRUgvMVJnbm1ITWNvZk1Bd21uZDVkSDlFeXBidEdrdWVMdzBRbUg1UkN5?=
 =?utf-8?B?eklJb0FBR1dDbndEVUcxQndERmxCT1BCdXhzOVQzNWJ0dGM4Ui81V1ZjSXJu?=
 =?utf-8?B?V0lHZk5VbjdqSFBiL2NVVDhHWStYR2krRjRKOFVKZUJxMGlYcGFRUXdsVURV?=
 =?utf-8?B?TlhSWXFyczQ4ajUyTzdmZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHdUOFcrUmpMbm9kVlk5LzJYc2gzb2FqU1VTOEJnWmdwRDcwNXNOVm1QVjVE?=
 =?utf-8?B?dVNGNFVNcnMvNEJvZnFUZFVZSzBUc2E3TUdPVnRodUJqcmcwSCsxTWZGM1c1?=
 =?utf-8?B?MXdEUGtSblVlWnBRc05wbmJ6NGhUbENMUGhJQzdRVHVoR0ZacUlLZGZNVmFV?=
 =?utf-8?B?QVBVeVB5ZU53ZEtZbEJuajZQSmRoOEJSU0EyM3NpaW5Rc3hKcjFLQmVmKy91?=
 =?utf-8?B?TTl4ZG5kUEVKWHhYeXB3WUNhVEJiR1ZUK3BYLzl1UFRWOEhaeUQrSTBFZ0hJ?=
 =?utf-8?B?dHJoS3ljMDZKdTZNcUlEZEg2MUgwVDkzNUFrYy83RVhTd1U3dFg1T2ExNVpl?=
 =?utf-8?B?cm1qaER5WWxBdk1heWpEY3VyRmRMS0FDby9WV2NzdDZZTEhVQnN5MmxjR2Uz?=
 =?utf-8?B?OEZsVXZMYzhiYlM0aEx5TU8vd3NWekI5NkhHTEJpNVpFUU5wQmMwNEk1cFF4?=
 =?utf-8?B?QWRYMWF0WitRSzl0LzdYT1dUaDJOYzRaMVAvZE11NjFRem03M282MC9CRlI4?=
 =?utf-8?B?VWtUVDNOU1NsWTEvU3FPOUsyei9vaDV1QWVQakxUYzM5Tkk0WHBHQnRwOWJ5?=
 =?utf-8?B?bEdxSTNOY21UbEdCZ1F4TjAra2NsUmxsVURBR0VoRmVsUS9oZHI0dklZN2NU?=
 =?utf-8?B?SHR2TTYzRlJLZUxscXAvdlY0OW9XNDJqNmphc1pGdEhya2F5ZlpaOVQyOWs2?=
 =?utf-8?B?and5NUhyN0NndVRZVTN2V3RiOGtLRWQ3OGtrQ1RCYXZEVFRXWVVPVllaWENO?=
 =?utf-8?B?RzVqMko2c21HcTdjWUxDRURZTWpQeFpRQWQvRnE2WCtWZmluWHZkYXU0V2ov?=
 =?utf-8?B?TW1rVW9QVDA3M3J5eDBrL09CUDRQSjV3dHFQeWo5dmVwMVNIZ0Vqa3RSRlFj?=
 =?utf-8?B?bWRGM1B0UWpMQWFFeHMySVFYSytoWEo0YVhYMGU0WHhsNFQxMFpZOFZFQzhj?=
 =?utf-8?B?SFNObnd2V2lhK09sRTlVYnRiTlF0Wm9sYzVqc2R0WU4rZkpsdUJRSGlMM21K?=
 =?utf-8?B?TlYzaStVN2N5d0F0R2dmL3poVzE4emZsSmpsUkk4Vkc1UzJ5bmp1dHR1M0tt?=
 =?utf-8?B?V04zSW43cTNGcHVuMFZsdEw3OEIvOWVWcVNLNHNCMWJzUU1aeUROVWtyVnFF?=
 =?utf-8?B?TWdvdHdWcW1ZZEVEUWVSZGxSajNOUlhsMENOeWp5ZjV3S29ic3BFTGlOQWhi?=
 =?utf-8?B?Vzg4MnFXZlgwZnFxalNPNG9sd3dGZm8wQUZvcmJHb1N6V2tmbTIzdDUzdFpF?=
 =?utf-8?B?Qy9OL3Z2VlRwcHhlemZuQTZXdjI5d1YyUDBUSjNpbXBRU0QzU2hqakU0KzNo?=
 =?utf-8?B?UjUxV05tTkc2eXljSUwvcnNpWnNLM3dnelh3TUxRN3d4MTAyZ2JJZ1NoTktq?=
 =?utf-8?B?VW42dHVEMzh0TFVMQkRNdlpjWkI4aXFNc3M0eHVheWw5K25FNStvY1BwMG1G?=
 =?utf-8?B?VURrNlpkakt6RUNvVStzbmVIVVBrS1VWd0NNb0NzUmdrUU53R0g4MDdaM1RO?=
 =?utf-8?B?MFViVVNpRWg5VVRnL0JjSmtHTC9PWXNway9HNTJSdW0xaXgvWng0MXhSRnhh?=
 =?utf-8?B?eUlzb052eDFwMWQ3alpxYmVVNElqT0tneVJVd0pqaHdxWjhTZlA1LzAxT0Rl?=
 =?utf-8?B?M25YQndCZURMMUU1cjhWak9kVHdXUHl2QXgvaGFud3RHd3BrZDR3N3hoWG96?=
 =?utf-8?B?SXFGSTBnY0hvK01Hd1FsQUJRazRhTkw1OTRtNC9kUGgyM3NsT1R2VEZLQWNo?=
 =?utf-8?B?anFOeHFDQVdsWHU1UFhBc085UHFoRThvWmdtNUowRTVWalY4TWhDUzNVVHVt?=
 =?utf-8?B?M1hTdFU3NEZRVDJhMU9aMDA3NEQ4eE1qVGhIOEdoTURBMDY4R1JzRk0xVHVa?=
 =?utf-8?B?WUpTb2dPZVFqRTV2a3pvbXgrdG5QaTk3Y2hhZ1o2VndYUDdNR0dsVUtuZFBY?=
 =?utf-8?B?WWQrZUN5K21DVXFRMlZISXhVMUlDdjh2bk81djZucjE5UktpcTU5TC8zY1lH?=
 =?utf-8?B?T0l1cDA4V2psbTFUVXhNZHVTV25BK2dXKzAwRXZiRzJVN3B5bjdwbGRpekg3?=
 =?utf-8?B?RHc5dEluLzRacER0NnpIUU05R1BDSmFlb1ZNcFl2Zm84MTdrWVA1YTJ4Qjhq?=
 =?utf-8?Q?eqCwCZIMSxPTIOwvBVmL4qEA4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d3aa14-92b2-4e5d-2508-08dc813d6db8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 06:46:41.3105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WTwxWSLYlUMTh2IAVikSK8jqNjay/itmqdHiREButllxQwwOqgvPGL8NZaELN3/wESR4SfYiHo0a9NUlUZScyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7890
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFtaHl1bmcgS2ltIDxu
YW1oeXVuZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgTWF5IDMwLCAyMDI0IDExOjQx
IFBNDQo+IFRvOiBXYW5nLCBXZWlsaW4gPHdlaWxpbi53YW5nQGludGVsLmNvbT4NCj4gQ2M6IElh
biBSb2dlcnMgPGlyb2dlcnNAZ29vZ2xlLmNvbT47IEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbw0K
PiA8YWNtZUBrZXJuZWwub3JnPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3Jn
PjsgSW5nbyBNb2xuYXINCj4gPG1pbmdvQHJlZGhhdC5jb20+OyBBbGV4YW5kZXIgU2hpc2hraW4N
Cj4gPGFsZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb20+OyBKaXJpIE9sc2EgPGpvbHNh
QGtlcm5lbC5vcmc+OyBIdW50ZXIsDQo+IEFkcmlhbiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+
OyBLYW4gTGlhbmcgPGthbi5saWFuZ0BsaW51eC5pbnRlbC5jb20+Ow0KPiBsaW51eC1wZXJmLXVz
ZXJzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgVGF5bG9y
LCBQZXJyeQ0KPiA8cGVycnkudGF5bG9yQGludGVsLmNvbT47IEFsdCwgU2FtYW50aGEgPHNhbWFu
dGhhLmFsdEBpbnRlbC5jb20+OyBCaWdnZXJzLA0KPiBDYWxlYiA8Y2FsZWIuYmlnZ2Vyc0BpbnRl
bC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYxMCAzLzhdIHBlcmYgc3RhdDogRm9y
ayBhbmQgbGF1bmNoIHBlcmYgcmVjb3JkIHdoZW4NCj4gcGVyZiBzdGF0IG5lZWRzIHRvIGdldCBy
ZXRpcmUgbGF0ZW5jeSB2YWx1ZSBmb3IgYSBtZXRyaWMuDQo+IA0KPiBPbiBUdWUsIE1heSAyOCwg
MjAyNCBhdCAxMTo0M+KAr1BNIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+
ID4gRnJvbTogV2VpbGluIFdhbmcgPHdlaWxpbi53YW5nQGludGVsLmNvbT4NCj4gPg0KPiA+IFdo
ZW4gcmV0aXJlX2xhdGVuY3kgdmFsdWUgaXMgdXNlZCBpbiBhIG1ldHJpYyBmb3JtdWxhLCBldnNl
bCB3b3VsZCBmb3JrIGEgcGVyZg0KPiA+IHJlY29yZCBwcm9jZXNzIHdpdGggIi1lIiBhbmQgIi1X
IiBvcHRpb25zLiBQZXJmIHJlY29yZCB3aWxsIGNvbGxlY3QgcmVxdWlyZWQNCj4gPiByZXRpcmVf
bGF0ZW5jeSB2YWx1ZXMgaW4gcGFyYWxsZWwgd2hpbGUgcGVyZiBzdGF0IGlzIGNvbGxlY3Rpbmcg
Y291bnRpbmcgdmFsdWVzLg0KPiA+DQo+ID4gQXQgdGhlIHBvaW50IG9mIHRpbWUgdGhhdCBwZXJm
IHN0YXQgc3RvcHMgY291bnRpbmcsIGV2c2VsIHdvdWxkIHN0b3AgcGVyZg0KPiByZWNvcmQNCj4g
PiBieSBzZW5kaW5nIHNpZ3Rlcm0gc2lnbmFsIHRvIHBlcmYgcmVjb3JkIHByb2Nlc3MuIFNhbXBs
ZWQgZGF0YSB3aWxsIGJlDQo+IHByb2Nlc3MNCj4gPiB0byBnZXQgcmV0aXJlIGxhdGVuY3kgdmFs
dWUuDQo+ID4NCj4gPiBBbm90aGVyIHRocmVhZCBpcyByZXF1aXJlZCB0byBzeW5jaHJvbml6ZSBi
ZXR3ZWVuIHBlcmYgc3RhdCBhbmQgcGVyZiByZWNvcmQNCj4gPiB3aGVuIHdlIHBhc3MgZGF0YSB0
aHJvdWdoIHBpcGUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZWlsaW4gV2FuZyA8d2VpbGlu
LndhbmdAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiBbU05JUF0NCj4gPiAraW50IHRwZWJzX3NldF9l
dnNlbChzdHJ1Y3QgZXZzZWwgKmV2c2VsLCBpbnQgY3B1X21hcF9pZHgsIGludCB0aHJlYWQpDQo+
ID4gK3sNCj4gPiArICAgICAgIHN0cnVjdCBwZXJmX2NvdW50c192YWx1ZXMgKmNvdW50Ow0KPiA+
ICsgICAgICAgc3RydWN0IHRwZWJzX3JldGlyZV9sYXQgKnQ7DQo+ID4gKyAgICAgICBib29sIGZv
dW5kID0gZmFsc2U7DQo+ID4gKyAgICAgICBfX3U2NCB2YWw7DQo+ID4gKyAgICAgICBpbnQgcmV0
Ow0KPiA+ICsNCj4gPiArICAgICAgIC8qIE5vbiByZWl0cmVfbGF0ZW5jeSBldnNlbCBzaG91bGQg
bmV2ZXIgZW50ZXIgdGhpcyBmdW5jdGlvbi4gKi8NCj4gPiArICAgICAgIGlmICghZXZzZWxfX2lz
X3JldGlyZV9sYXQoZXZzZWwpKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLTE7DQo+ID4g
Kw0KPiA+ICsgICAgICAgcmV0ID0gdHBlYnNfc3RvcCgpOw0KPiA+ICsgICAgICAgaWYgKHJldCkN
Cj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKyAgICAgICBjb3Vu
dCA9IHBlcmZfY291bnRzKGV2c2VsLT5jb3VudHMsIGNwdV9tYXBfaWR4LCB0aHJlYWQpOw0KPiA+
ICsNCj4gPiArICAgICAgIGxpc3RfZm9yX2VhY2hfZW50cnkodCwgJnRwZWJzX3Jlc3VsdHMsIG5k
KSB7DQo+ID4gKyAgICAgICAgICAgICAgIGlmICghc3RyY21wKHQtPnRwZWJzX25hbWUsIGV2c2Vs
LT5uYW1lKSB8fCAhc3RyY21wKHQtDQo+ID50cGVic19uYW1lLCBldnNlbC0+bWV0cmljX2lkKSkg
ew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGZvdW5kID0gdHJ1ZTsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAgICAgICAgICAgfQ0KPiA+ICsgICAg
ICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIC8qIFNldCBlbmEgYW5kIHJ1biB0byBub24temVybyAq
Lw0KPiA+ICsgICAgICAgY291bnQtPmVuYSA9IGNvdW50LT5ydW4gPSAxOw0KPiA+ICsgICAgICAg
Y291bnQtPmxvc3QgPSAwOw0KPiA+ICsNCj4gPiArICAgICAgIGlmICghZm91bmQpIHsNCj4gPiAr
ICAgICAgICAgICAgICAgLyoNCj4gPiArICAgICAgICAgICAgICAgICogU2V0IGRlZmF1bHQgdmFs
dWUgb3IgMCB3aGVuIHJldGlyZV9sYXRlbmN5IGZvciB0aGlzIGV2ZW50IGlzDQo+ID4gKyAgICAg
ICAgICAgICAgICAqIG5vdCBmb3VuZCBmcm9tIHNhbXBsaW5nIGRhdGEgKGVuYWJsZV90cGVic19y
ZWNvcmRpbmcgbm90IHNldA0KPiA+ICsgICAgICAgICAgICAgICAgKiBvciAwIHNhbXBsZSByZWNv
cmRlZCkuDQo+ID4gKyAgICAgICAgICAgICAgICAqLw0KPiA+ICsgICAgICAgICAgICAgICB2YWwg
PSAwOw0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gPiArICAgICAgIH0NCj4gPiAr
DQo+ID4gKyAgICAgICAvKg0KPiA+ICsgICAgICAgICogT25seSBzZXQgcmV0aXJlX2xhdGVuY3kg
dmFsdWUgdG8gdGhlIGZpcnN0IENQVSBhbmQgdGhyZWFkLg0KPiA+ICsgICAgICAgICovDQo+ID4g
KyAgICAgICBpZiAoY3B1X21hcF9pZHggPT0gMCAmJiB0aHJlYWQgPT0gMCkgew0KPiA+ICsgICAg
ICAgLyogTG9zdCBwcmVjaXNpb24gd2hlbiBjYXN0aW5nIGZyb20gZG91YmxlIHRvIF9fdTY0LiBB
bnkNCj4gaW1wcm92ZW1lbnQ/ICovDQo+IA0KPiBBcyBJIHNhaWQgYmVmb3JlIEkgdGhpbmsgeW91
IGNhbiBzZXQgdC0+dmFsICogMTAwMCBhbmQgdGhlbg0KPiBzZXQgdGhlIGV2c2VsLT5zY2FsZSB0
byAxZTMgb3IgMWUtMy4NCg0KSGkgTmFtaHl1bmcsIA0KDQpTb3JyeSBpZiB0aGlzIGlzIGEgcmVw
ZWF0ZWQgbWVzc2FnZS4gSSB0aG91Z2h0IEkgcmVwbGllZCB0byB5b3VyIHN1Z2dlc3Rpb24gDQpv
biB0aGlzIGxhc3QgdGltZS4gSSdtIHRoaW5raW5nIHdlIHNob3VsZCBrZWVwIGl0IGxpa2UgdGhp
cyBmb3Igbm93IGFuZCBtYWtlIA0KdGhpcyBjaGFuZ2UgdW5sZXNzIHdlIGZpbmQgdGhlIHByZWNp
c2lvbiBsb3NzIGlzIGNyaXRpY2FsLiBCZWNhdXNlIEkgdGhvdWdodCANCndlIGRvbid0IHdhbnQg
dG8gYWRkIHNwZWNpYWwgY29kZSB0byBoYW5kbGUgdGhlIGNhbGN1bGF0aW9uIGFuZCBmaW5hbCBw
cmludCANCnRvIGtlZXAgY29kZSBzaW1wbGUuIA0KDQpJIGtlcHQgdGhpcyBjb21tZW50IGhlcmUg
c28gdGhhdCB3ZSBkb24ndCBmb3JnZXQgYWJvdXQgaXQuIFBsZWFzZSBsZXQgbWUNCmtub3cgaWYg
eW91J2QgbGlrZSBtZSB0byByZW1vdmUgaXQuIA0KDQpUaGFua3MsDQpXZWlsaW4NCg0KPiANCj4g
VGhhbmtzLA0KPiBOYW1oeXVuZw0KPiANCj4gDQo+ID4gKyAgICAgICAgICAgICAgIHZhbCA9IHQt
PnZhbDsNCj4gPiArICAgICAgIH0gZWxzZQ0KPiA+ICsgICAgICAgICAgICAgICB2YWwgPSAwOw0K
PiA+ICsNCj4gPiArICAgICAgIGNvdW50LT52YWwgPSB2YWw7DQo+ID4gKyAgICAgICByZXR1cm4g
MDsNCj4gPiArfQ0KPiA+ICsNCg==
