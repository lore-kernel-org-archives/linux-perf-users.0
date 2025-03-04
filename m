Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4F0280CD5;
	Tue,  4 Mar 2025 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105109; cv=fail; b=pYwFMo5tFQ+adpRjkCnglKNGSsbkrYuVDXDPNfwGM1ZSeyWeRfmyl9wEMNNNg0BDtYLXLvKtKBH48bRfc+9QpLWYNc4yGUhcpkuyEnjlAFqZH2ehWFUNJZLm4LeIy6yfx+4XKenBI6SA358arpsa1nmKuvW95TRTr2mz8V+3sLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105109; c=relaxed/simple;
	bh=1U7o+4liwVtY6TLr+ixi9PkWvTi5ruL01oDNoQpxjSg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TxP6A45pRX6hCoBiFsCUur+HT7r4AnLwW2mHoESP5fX0CvlpwY4tohRyCiSMxOrZXa54fdObbG4wTJkxgt+WROT/+co2jSay8P5t8FP8HfHeNMTioDfwlo4cwpR/s7xiZGPd+p85RbAbYf5+S7JnjlynXocLuNqGa+cFXQnklz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gb+/iRNc; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gb+/iRNc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741105107; x=1772641107;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1U7o+4liwVtY6TLr+ixi9PkWvTi5ruL01oDNoQpxjSg=;
  b=Gb+/iRNcuyRY56eK69ydG4Nm2rVT5fPZGfJmnkrFra3BRCx9hd9XwfIz
   1w9Gub91sojlfn4UuLNF0sl3d5Tg3yR2CFUVq/WbyhcsCeM7+pCYlUBoF
   SAQNYzz8/rmzL0KA3kYW/7TeBit44hNkANwTC4yV4G5sT8aktHM/pmUGl
   lLldRrbf3hrFsUQp1cPqOdWzVvmeE6+dUuH1mRo5xoI83gO5YDZ2DE2En
   CR7vSAHGPp8vkp6BDc2j6BMvCBxM5wv9M94W65WEvL1NH7w5VjlQcDvwr
   msPLui7fKegEHswi9xpADQhqL1N8nAb39N7MaRqL72Hyim+kzPe7RuLZJ
   A==;
X-CSE-ConnectionGUID: ZrsuyYqPTBygmkRA7eXuHA==
X-CSE-MsgGUID: AXpkRKPGRBalhhcIXUG3CQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="59444263"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="59444263"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 08:18:27 -0800
X-CSE-ConnectionGUID: IYAjij+MQvqTk/yVycs9/g==
X-CSE-MsgGUID: mpv+jahjQf6MkTC+Zr5mwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118299066"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 08:18:27 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Mar 2025 08:18:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 08:18:26 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 08:18:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fi07DKlXCfJa2Ky19jfqgBKUVuxHDRjsdhxP/+H+p+LTnQLBMiTmB+iYxxyXyAJHUtcbVVgBtyldAqjxmDJb4ACH6ObJ5Eo4mQIWVJF67NlN+X4obVCpoPRqjMDMGqduBSZthWQuMsGhUXchhj2B/OBSCSYqPpc1bFpB2k9z/F4QgXr62Yg4ULQW16/rXcWSVEUUEwjoTHWK3kFFPWU35BRbHVtJHTwFrwcN/YnOQGdCwolK3FkkRbK+tzZWc8wrB0bh7ENLN9VKshhnkBxgiycKlpgr7tQOA3++WIP4l1NQ+Wf3kcxvgD2qqefZjEBFJszd0Qcl1RGKENzz8jhmkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1U7o+4liwVtY6TLr+ixi9PkWvTi5ruL01oDNoQpxjSg=;
 b=rE4/CT1XIVED4qcJ7uhYRneA1lFJdF2MgDH4bdMXlTPURDDXutAeQfMMi/DlD9q+gKCimOqkRb8d/h+Dv0B1mKX+/ireWy4cBoyocjjjyBAy+JSqU7R+J6oPv9pmPxNn3me4aRjBjcSCsZ6iEJ8FW2mW3gaO2OwfNCzzzf33PD3lOKjLPlZhdTE7TP30XcJukaX2S7/ktkMMsP4wTOyBncekhe8ATNQJ60OGpNFYaoum/3zEjnmgkp0pbdfb52SMvHq1EoYsR7xV6K7qcP5n7CV+kdqkMWNlasR4xjpWyqTkRMhamwMTpsgVuYKyHDwg3/WlK5t8xcFV8iyvfmnCvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Tue, 4 Mar
 2025 16:17:54 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 16:17:54 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "namhyung@kernel.org" <namhyung@kernel.org>, "acme@kernel.org"
	<acme@kernel.org>, "irogers@google.com" <irogers@google.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>
CC: "jolsa@kernel.org" <jolsa@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"mingo@kernel.org" <mingo@kernel.org>
Subject: Re: [PATCH v2 0/6] perf test: Small improvements
Thread-Topic: [PATCH v2 0/6] perf test: Small improvements
Thread-Index: AQHbjK0v37PJn8L9GEiD92x7vOKpYbNjKJuA
Date: Tue, 4 Mar 2025 16:17:54 +0000
Message-ID: <0a13d381a10e94a25173128f37710b278c4d22b0.camel@intel.com>
References: <20250304022837.1877845-1-namhyung@kernel.org>
In-Reply-To: <20250304022837.1877845-1-namhyung@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|CH3PR11MB8660:EE_
x-ms-office365-filtering-correlation-id: 4e0e92dd-a333-4b7e-cee7-08dd5b381e7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UldZOUdORlV3RTFPSDlvTzJVZk9oM3htUnVLL3VBa3dBRWN6UlNNbHdKWjdy?=
 =?utf-8?B?bmRlaGFWckdST3lLZTJJLy9IUmRBbUljSzFnZXlPMCt5RnpOeCtVSEJ6NHFy?=
 =?utf-8?B?VU4xMGJiclBwSWI2UXFOT2xqWWJPNDlTRzFFemdWR0JkcEtjL0l0UnU2M0NH?=
 =?utf-8?B?Z3djK0MrL2IvUFZ4SXozbWxSdEtIS2EzbEVTejY3TXZMaVpSZW13TE9mYmhD?=
 =?utf-8?B?dUFtOGZvT25vTTlLUmxSRmpUV1BERWlyZmxIcjdueXFzVHMyQTIyOWd3ZW1l?=
 =?utf-8?B?YnNGRkFWZDhiRU5PZkFRQ1l6MXNWUkZwc2hTdzB0M3RNVjRwU0VMWnc0YS9y?=
 =?utf-8?B?K0Vud2RyZ1ltZDdUdFJnbEQveko3TTRKSXJZR2JmUkgzSXVGeDA3ZkFoa3dp?=
 =?utf-8?B?YWVLcU4vbmVhTklPRHhNQk9aSFdETFdpUDJMTHZua0dLbGRNNERkMnJ5K21O?=
 =?utf-8?B?Q3c1UWl3ckhJdHNBWGI5bUxpWEs5SWhZYzZWeWJ6dEpSQU4rZ2NSSHMwYzNO?=
 =?utf-8?B?cWVGR3Vhblh5aVBmU0lXZUhoUktkc20zUlNhQ1BwdUNFZythbTBjVlN4TmNu?=
 =?utf-8?B?UnAyZTE4OWM3WGdLM1BSYmdPMlJMbVREcVI4Mk13VUJlWDE3RnNCdDRCTmV6?=
 =?utf-8?B?QkYwb2FrRmdmbzVqUUVjaEdVMTk5T0RXOFlPeGRpYStuRUlXTHA5SXk4ekR3?=
 =?utf-8?B?QVFhRy9kanZMUWZHUHk4RkpNTnRYajJST0ZMVERGOFZSTmNtV2pKWncvaHZa?=
 =?utf-8?B?dW1tT084MkVOZS8yT2ZtYlRoM2o4dVJVL2xjc3pCdDRFdWk2dFRjQ0w2SkN2?=
 =?utf-8?B?M0tZb3pwanpOeVpTZnFuQitucmczaTZQTWM4RE0rdlErakduUWducVA5NDU4?=
 =?utf-8?B?b1l6Y2dlR1BISW9ISGorM2t3RXZjanl2eGllbzdHZ0tCV0R2cHd1bHlTR2hJ?=
 =?utf-8?B?YllKOFVlam4vOHZncTN3TlpPcWJROTlYazdnazFrbFoydWRTN3U5NkZ5NmJY?=
 =?utf-8?B?QzJob090a2E1cVF4UDg4VElRTEl1TnNCSVEyT0FxdFp4SHJ6MmczMmYwanN3?=
 =?utf-8?B?emd4Z1NwaG5XdlY5R2RxQmpLZ2w2VlBaSTd5YVhUZWQydnpQUWtzVDkrU0E4?=
 =?utf-8?B?SFNlWFM5MStPMUlTSzdWdjBENksyV0UxOEE2b29vYUwvTTVkZFZkZGVseTFl?=
 =?utf-8?B?WFBpMXkvNmxyNDhuVUpFLzArUXNXZEtWVjR6cEFVKzc1Ry9uQ01DSDB3VE1x?=
 =?utf-8?B?OGNOOGR1MndaclZJOGowalNLdkpOTGtTNVNWN3lCbWlwTk1DYms0Y2VNWUtw?=
 =?utf-8?B?RlgxVjY4a3Via3FKeUxlMHNQNHJRTUNwVTNtV2NrbjBGd2I5RTl5RnpGN2hO?=
 =?utf-8?B?QjdTdFJkZlNLWWYwMkJSSUdyeDV5VjVhMGkzRFUxSS90MUZVRmdFRUhKSG8x?=
 =?utf-8?B?NHNBU2pObElTRXRuSUt0VjZTMmdha28vRkllcG9sekxtTU16R1pJN1RRWU9M?=
 =?utf-8?B?M0dETjZ1Sy8wSGkyM0RlK3N4MVl3TDg5Z09GZThuN1hrT0VjUnBhbkd0YTRh?=
 =?utf-8?B?SHVpVlVwVFhjQnBsOGdxL3U2dVQ2YkNNRE1aRmJUV0tQVEp1U1VCUGlzOWE3?=
 =?utf-8?B?K0lvTHhOM0E3a1RDRDBEdWdIcnh3MklJODJPMUM4U1VXSWZyNlVTb29pWm1n?=
 =?utf-8?B?Rm1ubnhMb3hWaC81SWZCRE40elVIaUxySDRvMHVsdy9NK2F2SEhTZlJEUG5k?=
 =?utf-8?B?RkYyUkhreU93ZjI4YTB2RWpLZUxORDdraUlQS2NicnZuNnV2bnIvRWsvQXBR?=
 =?utf-8?B?bytCSU1BOTRoNmFvcnYvZno1WTllZGpnNjZFUnpzczlOZVJLbUdaU3lHaWlI?=
 =?utf-8?B?dHRVNWdEc0I4WXI1b2RtcExxY01abXBsU0xkSjd5MDFpdWZUd0luM25yblFH?=
 =?utf-8?Q?bYFRps2wqMTW4lOqg3V+qpLU9nPoRKkQ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHBzclRISlNjWnNtcXl5eW4waEVEaFFUTXVHcVBMWFBIVVlnM0RXenFnNUJl?=
 =?utf-8?B?bmVVUUZTdmJMNG1RUUZTcmphQVhKQWp0WldOSE82MjJUUlNyUEd1eFlKeDRJ?=
 =?utf-8?B?NmZ3NGFRRDg2eHlzRmE3bW1LWUFjRkJqZHJ0TDNQTUtrWDhGUDRoR3NoNE5i?=
 =?utf-8?B?aG9Dd25yRTQreWlSWGJtUnQ1dnc2TzhrcDhCS24xZWZsK1doSzZWMlJ5eWQz?=
 =?utf-8?B?dm9STC81MkNUWXUxekplb0VPZWFaTlFjT2VFM2F6Umw4emtOa0gwSkFTZUNh?=
 =?utf-8?B?bnpQS1doWCs5ZjlYVGZ2RWFKR0lNVGFQU3lUV04wK2oxL3EzQWdDNlBRcktU?=
 =?utf-8?B?a2MxK2p5YXNkejRmSUtDeGZva0NWbytBV1dBOTVBalppWDZFOTN1ZlJUS2Jq?=
 =?utf-8?B?REc4N3FkZGFmT1pnQjNiZldBdlhBc2ZPOC81SDE3WDdibld6a3owa3YyTWN5?=
 =?utf-8?B?b3lQRDVuc0hvQkxOUzd2dHMwOFRxUVZBcXF3bnB1MGpPSk9lUmRMbURtdXcr?=
 =?utf-8?B?d2hrNnRIOHNZUlZDQ2JSSWVnVWVGSUxtSlJrcThLQjVRMHR6WmZWY0hMNEM5?=
 =?utf-8?B?eXhQN0VlcU9OT0ZzcVJtcWZGL1cwRzBWWWRyakk1TkM1eG1HSmIyQU5Ldlo4?=
 =?utf-8?B?dkhMS2NGbW5QUjVhSHZPWlVTN2tEMlpNajZyVlNISVNPVUh1VTBBTXZJank0?=
 =?utf-8?B?TUNxWEVsbUFyeGlmd3dOeGoxU0JxUGYyc2RacktOY2xtY3VSb1NGS2I3dFJz?=
 =?utf-8?B?RUZWV2pzOXNkMEtyTXNrQ2VKZEhrN2N2ZEpyZ0tVNEVGQ3U4K0RiRFdNRzVu?=
 =?utf-8?B?bUtqK3dFTE1vcTJjdUMvbWFrV1htYjk4VGFkMTVkT09ROEo1TmZvaURtRlNi?=
 =?utf-8?B?RUlPVldtdzNrOE5JYk43SnZWMzdIT2Jnc1B1aXBNNU9ZcWNqWmhHakZzQ0ZY?=
 =?utf-8?B?aUpMeGhQNFhDVG9KeFQxRGdXNXNUd3RZVlBnWS9RK25jQnRIaGtka2ZyWncw?=
 =?utf-8?B?NWduUGVIQmhGK1I3bnAxdmFJSTZvNUJOTXhhaWx2YWdiOVBGQzlZeFpOT0lP?=
 =?utf-8?B?QXdaVFFCV3l2VXZpTDFXdzREcEVJZU5HR0RRNXhiT0piN0ZGc3B4Y0pwc1lJ?=
 =?utf-8?B?WWRTelZLQXJKTUx2V3BRckNOVWt3aVVGeFJTZFlVUDV6VEV5YTFzeEFGRGMy?=
 =?utf-8?B?MVAwMWtiNDRLZTdqcU8xL2RmNWRNV1hMUFZ1TjdMT3JnUnpseDBVRFlUNGV2?=
 =?utf-8?B?TWM0SjNVWFNwL2ZLTkZHYjJQMW9wU1kwc0swTVBUd2d2eFh2WE51MGNGQlR5?=
 =?utf-8?B?QTlsMmRrYU1DdXhkWmdHMmZuTFhmM3ZlZGNNUWE2MVd3K2hIdXlNNmNEWkxk?=
 =?utf-8?B?cFdqd3FZa01BVkxJQnFSbUd5UGRrWGhrZXZ6c0c2eTJ2NG1OTC93YVhjZXJB?=
 =?utf-8?B?dDR5M3p1bnpOOERHU3E2VGRCTFdjeGFvcDRzdzBKUzFZS2s2ODJWREtvVVdw?=
 =?utf-8?B?SjZreTF3b2xnamN2QnpVRnJadkcrZDFxaFFDRGxNM3Z6TmgyVDBEQm5SRHJO?=
 =?utf-8?B?U1kvUWlrSjVkWTZhaGplWVAyRWJJVEpGTXhHWVBxeElueDNEWENSNzN4L3dT?=
 =?utf-8?B?L21CZFp1cGxEc3NlalJHbWN0TUJzSlh3YjJFN09rY0xmTE9pUGVkNWt5bnNW?=
 =?utf-8?B?RHlHS05WQkhqSnByQlp5cVBwbWpGc3JBaUo1Y0xXS29oVldRUjFCcXVSWHdh?=
 =?utf-8?B?RGw0eWFqZENHSjNpOVZaTWhialVUUTd5RzdSUWtBRWtzR3ZMNXNoUjE5Qjcv?=
 =?utf-8?B?NzUxZWFseG9pU3IrZzlpQ1E4SS8yWXl5RFd3MW5CWEhqRG42Snl5R2xoRHlz?=
 =?utf-8?B?U3pxb1BJSkY3MUpKc3FsRnlxcUJQbDJMajFqM1JGam1OR3lWNkc3Y21TWWx6?=
 =?utf-8?B?cEVhaFFlVmN0b2VzL0RzeUsxT0x2OXBEemFNSk0wUmpSSysxY0p4djJpdGRB?=
 =?utf-8?B?WjJJS2J3eE5PVklFSW5zdFA1SXZXTEp5VUlyZlN3OVZ2Zk04WllXY1BCc1Fx?=
 =?utf-8?B?R1F6QXFxakUxL2tLaE1TMkl4c3h6YUVWK3lSN3ZVK1l0YXhacWw5cjNUK3RK?=
 =?utf-8?B?REY4UmcyWCtIVWFOc3RFOEdPZG1MRStWa0lWYWlvbDNvTWxYVFJkcEZETzNw?=
 =?utf-8?Q?XouRiH4pUoGAVDujKsYIDBE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AE401F96FA8E743862B2109B67F0F2B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0e92dd-a333-4b7e-cee7-08dd5b381e7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 16:17:54.4151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1JyQsSa6Beb65bsDCqApQQ+gbL2xYEmlmpSIjG71hF+au9i/pKWwpDdQsxa256Y68BdrT0/IBw8Tn/9F/FD91g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8660
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI1LTAzLTAzIGF0IDE4OjI4IC0wODAwLCBOYW1oeXVuZyBLaW0gd3JvdGU6DQo+
IEhlbGxvLA0KPiANCj4gVGhpcyBpcyBhbiBhc3NvcnRlZCBsaXN0IG9mIGNoYW5nZXMgaW4gdGhl
IHBlcmYgdGVzdC4NCj4gDQo+IEkndmUgYWRkZWQgcGVyZiBzdGF0IC0tbWV0cmljLW9ubHkgdGVz
dCBhbmQgcGVyZiB0cmFjZSByZWNvcmQgYW5kDQo+IHJlcGxheS4NCj4gQW5kIG90aGVyIGNoYW5n
ZXMgdG8gc2tpcCBwcml2aWxlZ2VkIHRlc3RzIGZvciBub24tcm9vdCBhbmQgc2ltcGxpZnkNCj4g
ZGF0YSBzeW1ib2wgdGVzdC4NCj4gDQo+IHYyIGNoYW5nZXMpDQo+ICogZml4IHNoZWxsY2hlY2sg
ZXJyb3JzDQo+ICogc2ltcGxpZnkgZGF0YXN5bSB0ZXN0IHdpdGggdGltZW91dA0KPiANCj4gVGhh
bmtzLA0KPiBOYW1oeXVuZw0KPiANCg0KTG9va3MgZ29vZCBvbiBBbGRlciBMYWtlIGFuZCBBcnJv
dyBMYWtlLg0KDQpUZXN0ZWQtYnk6IFRob21hcyBGYWxjb24gPHRob21hcy5mYWxjb25AaW50ZWwu
Y29tPg0KDQo+IA0KPiBOYW1oeXVuZyBLaW0gKDYpOg0KPiDCoCBwZXJmIHRlc3Q6IEFkZCAtLW1l
dHJpYy1vbmx5IHRvIHBlcmYgc3RhdCBvdXRwdXQgdGVzdHMNCj4gwqAgcGVyZiB0ZXN0OiBTa2lw
IHBlcmYgcHJvYmUgdGVzdHMgd2hlbiBydW5uaW5nIGFzIG5vbi1yb290DQo+IMKgIHBlcmYgdGVz
dDogU2tpcCBwZXJmIHRyYWNlIHRlc3RzIHdoZW4gcnVubmluZyBhcyBub24tcm9vdA0KPiDCoCBw
ZXJmIHRlc3Q6IEFkZCB0cmFjZSByZWNvcmQgYW5kIHJlcGxheSB0ZXN0DQo+IMKgIHBlcmYgdGVz
dDogQWRkIHRpbWVvdXQgdG8gZGF0YXN5bSB3b3JrbG9hZA0KPiDCoCBwZXJmIHRlc3Q6IFNpbXBs
aWZ5IGRhdGEgc3ltYm9sIHRlc3QNCj4gDQo+IMKgLi4uL3Rlc3RzL3NoZWxsL2xpYi9wZXJmX2pz
b25fb3V0cHV0X2xpbnQucHnCoCB8wqAgNyArKysrKysNCj4gwqB0b29scy9wZXJmL3Rlc3RzL3No
ZWxsL2xpYi9zdGF0X291dHB1dC5zaMKgwqDCoMKgIHzCoCA4ICsrKysrKysNCj4gwqAuLi4vdGVz
dHMvc2hlbGwvcGVyZnRvb2wtdGVzdHN1aXRlX3Byb2JlLnNowqDCoCB8wqAgMSArDQo+IMKgdG9v
bHMvcGVyZi90ZXN0cy9zaGVsbC9wcm9iZV92ZnNfZ2V0bmFtZS5zaMKgwqAgfMKgIDEgKw0KPiDC
oC4uLi9zaGVsbC9yZWNvcmQrcHJvYmVfbGliY19pbmV0X3B0b24uc2jCoMKgwqDCoMKgIHzCoCAx
ICsNCj4gwqAuLi4vc2hlbGwvcmVjb3JkK3NjcmlwdF9wcm9iZV92ZnNfZ2V0bmFtZS5zaMKgIHzC
oCAxICsNCj4gwqB0b29scy9wZXJmL3Rlc3RzL3NoZWxsL3N0YXQrY3N2X291dHB1dC5zaMKgwqDC
oMKgIHzCoCAyICsrDQo+IMKgdG9vbHMvcGVyZi90ZXN0cy9zaGVsbC9zdGF0K2pzb25fb3V0cHV0
LnNowqDCoMKgIHzCoCA5ICsrKysrKysrDQo+IMKgdG9vbHMvcGVyZi90ZXN0cy9zaGVsbC9zdGF0
K3N0ZF9vdXRwdXQuc2jCoMKgwqDCoCB8wqAgOCArKysrKysrDQo+IMKgdG9vbHMvcGVyZi90ZXN0
cy9zaGVsbC90ZXN0X2RhdGFfc3ltYm9sLnNowqDCoMKgIHwgMTUgKystLS0tLS0tLS0tDQo+IMKg
Li4uL3NoZWxsL3Rlc3RfdXByb2JlX2Zyb21fZGlmZmVyZW50X2N1LnNowqDCoMKgIHwgMTEgKysr
Ky0tLS0tDQo+IMKgLi4uL3Rlc3RzL3NoZWxsL3RyYWNlK3Byb2JlX3Zmc19nZXRuYW1lLnNowqDC
oMKgIHzCoCAxICsNCj4gwqB0b29scy9wZXJmL3Rlc3RzL3NoZWxsL3RyYWNlX2J0Zl9lbnVtLnNo
wqDCoMKgwqDCoCB8wqAgMSArDQo+IMKgdG9vbHMvcGVyZi90ZXN0cy9zaGVsbC90cmFjZV9idGZf
Z2VuZXJhbC5zaMKgwqAgfMKgIDEgKw0KPiDCoHRvb2xzL3BlcmYvdGVzdHMvc2hlbGwvdHJhY2Vf
ZXhpdF9yYWNlLnNowqDCoMKgwqAgfMKgIDEgKw0KPiDCoHRvb2xzL3BlcmYvdGVzdHMvc2hlbGwv
dHJhY2VfcmVjb3JkX3JlcGxheS5zaCB8IDIxICsrKysrKysrKysrKysrKysrDQo+IMKgdG9vbHMv
cGVyZi90ZXN0cy93b3JrbG9hZHMvZGF0YXN5bS5jwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjMNCj4g
KysrKysrKysrKysrKysrKystLQ0KPiDCoDE3IGZpbGVzIGNoYW5nZWQsIDkxIGluc2VydGlvbnMo
KyksIDIxIGRlbGV0aW9ucygtKQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDc1NSB0b29scy9wZXJmL3Rl
c3RzL3NoZWxsL3RyYWNlX3JlY29yZF9yZXBsYXkuc2gNCj4gDQoNCg==
