Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43B3175AB;
	Fri, 13 Dec 2024 20:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734122421; cv=fail; b=CDcK/Xcl8CdtVyiMxKV/QqQxu1Ryf/I8Mcir/R3NP1ms/8zQR7Qe4BdSdoWXU9+qA2+swcM7U5snIjI5csScUiY2074KEsOdebav61pQFDZcw89MZQ+fdditPpKKKhEnZ0icvDTZydOOmRyKsH4NzXnqSD/Gi8hgRQfEQQd9mvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734122421; c=relaxed/simple;
	bh=zEBVnIPELxx26778KD/NlmbXHCEb7xmXyuO/B0UcY9g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TCv+5tPLaqynwJDHInnFYVLpKTYm84PwSBv5indKA7wmB/Q3H8eUZac1q8FmN4dybHd44/C1aYLaO/6SvXDUPBb7qk6A/G2k0hafjsB9Fn38+M/25d/ruyw3UUhRgHpwoYi/+SZ4cw0MTbStPADEyGxxLR3a/1YEWIdAN+rsNc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XUBFyijI; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XUBFyijI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734122419; x=1765658419;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zEBVnIPELxx26778KD/NlmbXHCEb7xmXyuO/B0UcY9g=;
  b=XUBFyijI+ZjMneTdE35Da8XNmvuxZ4RutFxjqj/un6hugAMbROFfACGP
   AAioZb2hNRnz5sF4UPGq1W2ITXsu60gmm6xvtVsrEf/5XrwXdvKascB+V
   gDFejutO5gCey5j7ughYEIC033I5mMA5oKOQCRTj0LP1IjRm3WoKALjum
   M5NJRS7oSgRHo6GiCzkleRF5Os3CYqrcQH/rBsPlpUk8E9a+09354c9IZ
   P0IAH0miJZlTQ1zjXRWKD1eHzTqMUPFcQMrEw2kHIZY9+zrkhXCjp3F6K
   rTgEm+fhyyH6qj0cpuK3QddPwUJ/NAI1zZR5uZIFZ8KU/3U/BGQLBRdy+
   A==;
X-CSE-ConnectionGUID: tnv3fuTnQIS9GkcF2T9gfA==
X-CSE-MsgGUID: 9JG7KLc5QfS7A1LibDLG9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="22172094"
X-IronPort-AV: E=Sophos;i="6.12,232,1728975600"; 
   d="scan'208";a="22172094"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 12:40:14 -0800
X-CSE-ConnectionGUID: OFnkG1mTQ3SefI3Oh2sQZw==
X-CSE-MsgGUID: S+geBwdoRqaYPbjhzY4TOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97412570"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2024 12:40:14 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 13 Dec 2024 12:40:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 13 Dec 2024 12:40:13 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 13 Dec 2024 12:40:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VD6QFjza3SxDpiu55TX933X5abXfYgCey82chMvcWub08MKSgdl8F3tpBCBuXx3UViSDXD6ZM/Bkuggxxldti8UcG1zBzvy/Ql7kcjUnAYbDo1xKt2oOSc4YXFxdVajjSuZI92MkGLA+FSKhdUCG8wqxV4HZuyNp2mGC/MHdoZ3IlhmfeMqVlvnOjFTwSsg5N3kHYEOEySTPbq4cKjZUUb9FeRdibkQhdogr6q4/gKmjdw4PBxGDUeuN+sPsrx6UfLr+/fDuhkSlnTh+UTGbs/b7qEZjqy937wxmAkh2U+BmFYV8NUJ7hvNbiianB+YzqU9G5by6EgX22XDS+pEiYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEBVnIPELxx26778KD/NlmbXHCEb7xmXyuO/B0UcY9g=;
 b=fTCjq2gCGcxJXaiXpKU+n0zR+tAl9cbBWZMpVSPnft+q7Eytv1oeGhzryULSA1fCM4UWgVvoYNw/6e3QWwIO75tsO9B1zrg0Z721GU63SY3nKppySMbsHs7sMgcnQHDWmmRG/6STzNT7CL/0Bx3ZBtDEFbY5aIWXZ4pHxaJhOad1G303ga9kgcYqKUaP/7c4aCIf3waXDc0r5DWN667QgFAdpp/9wE2/MBJ4bwPzolFfLKDyM1bjuPWl7QOSPPk0zg9SFGm1NAnYm27TWekvDq3kbHJI/DmMOU4Il12X3Ls9oNLcBMpzrZKajLvDCs5WjzIGgIV/4Dza6lt9/QabIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by BL3PR11MB6484.namprd11.prod.outlook.com (2603:10b6:208:3bf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 20:39:56 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::56d4:6f50:dd04:d11b%7]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 20:39:56 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org"
	<acme@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "namhyung@kernel.org" <namhyung@kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "irogers@google.com"
	<irogers@google.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>
CC: "ravi.bangoria@amd.com" <ravi.bangoria@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v2] perf script: Fix output type for dynamically allocated
 core PMU's
Thread-Topic: [PATCH v2] perf script: Fix output type for dynamically
 allocated core PMU's
Thread-Index: AQHbTZsuURwJvMl+rE+oBzZgvW09Z7Lknd0AgAAFQoA=
Date: Fri, 13 Dec 2024 20:39:56 +0000
Message-ID: <82cb71b5deab913dbe85504882b03c84bdf55137.camel@intel.com>
References: <20241213201109.630658-1-thomas.falcon@intel.com>
	 <219e5f79-d2c2-45df-9298-142597ebb404@linux.intel.com>
In-Reply-To: <219e5f79-d2c2-45df-9298-142597ebb404@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|BL3PR11MB6484:EE_
x-ms-office365-filtering-correlation-id: b5f66dca-4664-4098-8f2f-08dd1bb64df9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bDVaeXdiVEsxNkJSUTNYRzhNT1VOaWh5V1htWjVCbXZIM3RQWjJGYkJxb0gz?=
 =?utf-8?B?dkxHRVAyTkU3eVZCYXg5VVBEYmhiVDlTY3B1cjFSS0plUnQvTERFellrd1N4?=
 =?utf-8?B?R1Q4UGR1TUNtVHhJUEszc2RCUG1iUElNN29NSjlNZlpTQ1Q5R0JxL29uZEc3?=
 =?utf-8?B?Y3kwSjJHMFJhMnF3UWFSdTRuSFFjN1VNbHhUM3BJR0d0RGo1RktDUFQ4YkJZ?=
 =?utf-8?B?dlpuNFVZMi9GbnBYWGhLZWE5VGtUTUxrblVZVG9qdXZNZzRNVlIvMjNFSlc3?=
 =?utf-8?B?V2xqWkFwdk5NaDIwaXliL0xpK1RIZ1F2VDFlY0pISVoxM2JxcU80QnNnRGpa?=
 =?utf-8?B?MlFFRy90T1R6emRyemZsSVY3SkpxZWlkSFE3RmFpSS9pZTJzOHU2TUJSYmFk?=
 =?utf-8?B?UXltdTFiZUc1SU5raWpVZzU3dU5oSlZlTnVoYVZyNndMcVFGZG9lR01iRGJp?=
 =?utf-8?B?YW5GTVdqVENiQ0hCc0lENVJtWGkrRFJEMVlxZkNBUXJGYTVTZjJJejduekFG?=
 =?utf-8?B?eHl2bDJuSXJEbW00eWF4Qkt0M0FZekpLazNuUEZjRG9Dd1JLTk5Qc1NEQ1lk?=
 =?utf-8?B?bE5jdEJ3YUF0Nmx0QnBueC9tQk54NjNzWVBnUGtqcGo3cnJRUjR6YnVTQUNr?=
 =?utf-8?B?eHBOOFF4Y2pjZGFIK0hiWEpQZ0sra2hhWTlxbU5FRnROOWtQS0xDREJ5VFVt?=
 =?utf-8?B?MlZ0b2laNDJ2bVBzSkVkTitCVXMxdlh4Um5OSUZwWjVEMlo0VzFBeGVTTHRm?=
 =?utf-8?B?VGpUVVRXL092NkZBTXkwbXBQSnBBS1VGOHFzZWZvekFCaWNKV2hxeXdVRFdu?=
 =?utf-8?B?L2YrNTBva0Y1aHJqZUt3azRFaVNlWEh4dWtaajVWajhlMnpYZUlxWmFEbkg1?=
 =?utf-8?B?UXlBdFhOVG50WWpSQmtVYzBqbVdaUlpvYW03QjloK0pvenIxaXlBT2t0Y2Rv?=
 =?utf-8?B?TWM4enEwK2M4aU5KTXhwb1crRjAwdS8wVyt5Vm5yQXpSTzZjd1FvakVkcFVi?=
 =?utf-8?B?ZDlaLzJnUVpZR25oVVR2UWNKbVk0Vk40UTMwSXEvMUdoY2VhdHJiTkNuYXpH?=
 =?utf-8?B?SHMrTHRKMDhpUUxCMklvNnJpejhmZjVvQlBmMDM3NEM2WVZZRFpabjgrMkl3?=
 =?utf-8?B?blNoTFl6TmF6ZXZlcUtRSDMvKzB1ZnVhQ0p4NzRaa2xRVDREbGhhdllIQUFU?=
 =?utf-8?B?VW14c1N0R2VNNDk4VXFGVmllY2JOaE4wYU9OOW9FMjc4eXFzRlcvYU4wZDJP?=
 =?utf-8?B?MW1UTGh1NFNXbXlBaVBtUEVrV2xUcktQMnlaVEMrSHkyVHVmbXpCbzdEcGRj?=
 =?utf-8?B?aDBFanJ5VGdFRldrcFZiZHpsNzM1bUR2dWVMdmpQLzJIeU92aERoN3dxOVMw?=
 =?utf-8?B?T095R3V2YWZ5TTExTXlERStibWwvOG5YRW1pZXVwSGlpa1V1Z1MwM0ZGekF6?=
 =?utf-8?B?MEJZSk5PUkV6cmt6Q01MMktVamw0NVVKdnY0anhobmlaM1FiOFlPaVFrWEdh?=
 =?utf-8?B?OHNLTU51Skp6bkp6SWRPMmZ2MXFFckUxS0F4eUJrNlVhRzNvbFdHcWZsQWR0?=
 =?utf-8?B?R0pSQlhpbldrNDA1WkdtWnJENEx0bHozK0tXUkpERUNiUWVlcTBodFlLOTFJ?=
 =?utf-8?B?b1MwL2NrNURNeElKSUpudUI2MXk0YkZ0cU51U0M4ZW4yZVN0bWtMQnlSRCtB?=
 =?utf-8?B?d1ZSWFA0L25jTkFJRjF4R0NUa3R0bzZJY1A4dnRTVU54a043MjZnTW5VZ2VM?=
 =?utf-8?B?L3NWZWE0aXJGQTRXWElWbTNtek5qZVgxQjdMQkh5eTJXNlZydjczb3NjUzBv?=
 =?utf-8?B?U3NUc0RWYzlEaFBNK0pSUmlVRjh5RGE2UmdIUVI1WmNWMWhnaVd6cVA0SGpM?=
 =?utf-8?B?RXBBZTIzZTY3M3FjalZJbEg2Zk5xckdOM3ZYN2dXSS9NYXNwb0dQNy9SeGlB?=
 =?utf-8?B?MWNhTEQ3TVZ1aXpoYkdGdjFOZDQyblp3N0phMXdJQW5hd3djVWJsQzVDVmt2?=
 =?utf-8?B?RWFnTlNUQXhnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anJsa0FRN0dHRmZGaTdTVkpPblBGSGw1OStLbkZEcGdvQzZHc0ZUaXJQS3dB?=
 =?utf-8?B?SDNmSlNTSEcvNWpzUHdNUTg4YmhKVXZuV3FKdHRPTnRWUWlyZEVrdkE3VzNF?=
 =?utf-8?B?akI4b2dRRjFyazdQaTZtT3RoZ1phS0FIVGFoTjdOVEJ1eDNGczU2TlpPc1dI?=
 =?utf-8?B?UFJBVEJ4ZzJxUkZxdEpGd080UUlaa05QWkNkN2c2ZTIxMVpDdUJrNmVvdm55?=
 =?utf-8?B?d3lURVBJdGdJQ1FEeStDMVBsbUR0ZXZxc2QvdnE2dW1SUEU1cTc0dnEvK1pV?=
 =?utf-8?B?WnNRUjN3MmNlYXVFenRETGhkZkVOR3FIOHpLbStqOW5hSWlBaExrcXFSN3Fi?=
 =?utf-8?B?ZysrUDVhTnU1a0V1ZkoyL3lYVEkwTG5sVUwvZ2ZLVm1vemFKaGV5VzVJamIw?=
 =?utf-8?B?UUNOQlVmT2x0U3RXc1hJTTlXVlE5cVljTWwvY2VkL1BlaVBsM2dtbTBLYWVv?=
 =?utf-8?B?MitlME5NME4zS2pFSzBNY3Q2T1NDK0xUeWNmWVdkVk5ZM0FrZ0FSUytabFZ0?=
 =?utf-8?B?Q3JYZk9nRXdUQTZWN3pWcTkvczM2ajRyVmVVQzg3elB4Nlh5aVVuZVVjcm5O?=
 =?utf-8?B?eVZNOUFFQzRNaDU1c2szZU9GNXRxK2RFUFRvdWlsN2F4L2VqaVBQUDAxaHJp?=
 =?utf-8?B?aFA2VzlOOXJuQUoxcFRUR3RWOHl6THBYWmNYUHFTc1daVGQ1aFQwV0JJTGp3?=
 =?utf-8?B?ZGN4RlJPTlhRMHZETEF5MHhiMmE3NXBSanlSM0x2K0xGSzU4SkVObWZKcU53?=
 =?utf-8?B?bnc5NU9kMjU2Rm5lM3loOG5BZ2hXTlhHQXhoQ2w5OFVib3FjbCtqam5Ba3NL?=
 =?utf-8?B?NGF5eWxhWWMrQVdOUXRHVVhha0ZxSk12bXhjUVFrckxuQmhQUkNIRVl4TUNG?=
 =?utf-8?B?RDNWZWhVdGhYbkZRZGRZa0EwWGpDbTdOdHNEbGsrdUtXbms2VkRqQ0E3YUFy?=
 =?utf-8?B?cTVmNXJxM1J2MktZR2J0SFJ2L2w0UjlyQVVLOUJUeTMvaStPTitORS9pUnFy?=
 =?utf-8?B?UTdRZElmTXp2WGNsOW1OZGthVGJjRWNHWDZwTFZSdXQrZDMwUk9CazViUmow?=
 =?utf-8?B?NXVzMUNJL3pJM2gzaDgrQVZaK1I4WWVkM3psZnM4aVJaTVdQcWJhU2Z3THhw?=
 =?utf-8?B?ckwyUWRXemVtZWl4elphY3ZjeFpHV0tyQ1ZFYnJncDBUL3BsdktoYUVkZVhv?=
 =?utf-8?B?Q1J1aTZ2ZTNCaWtKWlNKcC83OFE3WEJKaS95T1gyaTJBWmZQVkNtZUtuSldM?=
 =?utf-8?B?S2VXaVFmeGpuNXhWTG5ITW50bzVOazdWUFVURmQ2ZVFja2NWM3V3Tkswem9E?=
 =?utf-8?B?YjJvbVVTYytsZDRmVXp1Z1hpYmw5RHJZSGdzaEQ5OGNFaThaNytpUE9KY1lu?=
 =?utf-8?B?QlNXMURCSVFFcXFlMHp4VWtkUFJSTkVNQ0NjZkVTMzB4SWxQeGZPWEUyc0tH?=
 =?utf-8?B?ZG4zckZldE9sWGErTHJPOFovZnYwYkM0RDBQMThQampaOGE1VHNXbFF2eXlR?=
 =?utf-8?B?cENtbks0WkJsekZFU2MrdU9FMElPNUF1SmhtZmp4Wk51UXQ1OHAxdXVZMnp4?=
 =?utf-8?B?YUJ1ejFRVktRN241d2NWRmZTZE1iVDJGczlhRDBudmFnc2lxanBLQk5NK1Uy?=
 =?utf-8?B?cWNvR0pOcVNlNDg5RUl3eWZEWHV0NUQ1SHhUQnhuU092THlmbmZQcGs3Z3R6?=
 =?utf-8?B?MzV6dlhTcTQvRjAxY0F6WEl1UFQweklnU3JBbW1BKzh3VWs2N1orb05oMlFT?=
 =?utf-8?B?czRLcmp3RUkrSnFDM0pjZmJ3d1B0YS92dlE4T0M0SUVRd3lDekhIWkJHemIw?=
 =?utf-8?B?ZUlvREhhMlUya2l3NEZlZ2xBQWN0KzJXNlBubUE2NnNNRUplQXRUS3Z6UjJq?=
 =?utf-8?B?RGpRMndYNnpMYWFEL0dvOWlmUEpIRjhTVjRHVW11cmQxYWpxeDlPd0QyMHRi?=
 =?utf-8?B?akIzQ3FCMUpSLzVKNS9udElTM044dkJtcmJxVzM3WXRTbXFlVkxNNi9UMTR3?=
 =?utf-8?B?dW9LWDF6QzJtdXRHcnhUYkFPQ2EzRjZaUFJhY2Irc3Y0bTQvNENLcGRIQTBv?=
 =?utf-8?B?eldzU2owUXQvdTN6VHEzVUtRNkVKWnoySmJKWmtjSGRWcE1ZSDBrYWVCaUY1?=
 =?utf-8?B?a0NZQUtlbUhwbVNWc2ZNa0VMUVZTRmF1RFRpU1ZGOU5aalBrL3hsa09LQzU2?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3181D80C4A6E5C498BAC1BF45D534749@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f66dca-4664-4098-8f2f-08dd1bb64df9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 20:39:56.2276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /gGpE5dwuHOCibppL7KDtTwxqM2VvMMAKKieviOdEQIFA/55quWaqtxMCJ0jCUY5PWBw0JkQwsJ+7ZaEXvLebQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6484
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTEyLTEzIGF0IDE1OjIxIC0wNTAwLCBMaWFuZywgS2FuIHdyb3RlOg0KPiAN
Cj4gDQo+IE9uIDIwMjQtMTItMTMgMzoxMSBwLm0uLCBUaG9tYXMgRmFsY29uIHdyb3RlOg0KPiA+
IHBlcmYgc2NyaXB0IG91dHB1dCBtYXkgc2hvdyBkaWZmZXJlbnQgZmllbGRzIG9uIGRpZmZlcmVu
dCBjb3JlDQo+ID4gUE1VJ3MNCj4gPiB0aGF0IGV4aXN0IG9uIGhldGVyb2dlbmVvdXMgcGxhdGZv
cm1zLiBGb3IgZXhhbXBsZSwNCj4gPiANCj4gPiBwZXJmIHJlY29yZCAtZSAie2NwdV9jb3JlL21l
bS1sb2Fkcy1hdXgvLGNwdV9jb3JlL2V2ZW50PTB4Y2QsXA0KPiA+IHVtYXNrPTB4MDEsbGRsYXQ9
MyxuYW1lPU1FTV9VT1BTX1JFVElSRUQuTE9BRF9MQVRFTkNZL306dXBwIlwNCj4gPiAtYzEwMDAw
IC1XIC1kIC1hIC0tIHNsZWVwIDENCj4gPiANCj4gPiBwZXJmIHNjcmlwdDoNCj4gPiANCj4gPiBj
aHJvbWl1bS1icm93c2XCoMKgIDQ2NTcyIFswMDJdIDU0NDk2Ni44ODIzODQ6wqDCoMKgwqDCoA0K
PiA+IDEwMDAwwqAJY3B1X2NvcmUvTUVNX1VPUFNfUkVUSVJFRC5MT0FEX0xBVEVOQ1kvOiA3ZmZk
ZjEzOTFiMGPCoMKgwqDCoCAxMDI2ODEwMDE0MlwNCj4gPiDCoHxPUCBMT0FEfExWTCBMMSBoaXR8
U05QIE5vbmV8VExCIEwxIG9yIEwyIGhpdHxMQ0sgTm98QkxLwqDCoMKgIE4vQcKgwqDCoA0KPiA+
IDXCoMKgIDfCoMKgwqAgMMKgwqAgN2ZhZDdjNDc0MjVkIFt1bmtub3duXSAoL3Vzci9saWI2NC9s
aWJnbGliLQ0KPiA+IDIuMC5zby4wLjgwMDAuMykNCj4gPiANCj4gPiBwZXJmIHJlY29yZCAtZSBj
cHVfYXRvbS9ldmVudD0weGQwLHVtYXNrPTB4MDUsbGRsYXQ9MyxcDQo+ID4gbmFtZT1NRU1fVU9Q
U19SRVRJUkVELkxPQURfTEFURU5DWS91cHAgLWMxMDAwMCAtVyAtZCAtYSAtLSBzbGVlcCAxDQo+
ID4gDQo+ID4gcGVyZiBzY3JpcHQ6DQo+ID4gDQo+ID4gZ25vbWUtY29udHJvbC1jwqAgNTM0MjI0
IFswMjNdIDU0NDk1MS44MTYyMjc6wqDCoMKgwqDCoCAxMDAwMA0KPiA+IGNwdV9hdG9tL01FTV9V
T1BTX1JFVElSRUQuTE9BRF9MQVRFTkNZLzrCoMKgIDdmMGFhYWEwYWFlMMKgIFt1bmtub3duXQ0K
PiA+ICgvdXNyL2xpYjY0L2xpYmdsaWItMi4wLnNvLjAuODAwMC4zKQ0KPiA+IA0KPiA+IFNvbWUg
ZmllbGRzLCBzdWNoIGFzIGRhdGFfc3JjLCBhcmUgbm90IGluY2x1ZGVkIGJ5IGRlZmF1bHQuDQo+
ID4gDQo+ID4gVGhlIGNhdXNlIGlzIHRoYXQgd2hpbGUgb25lIFBNVSBtYXkgYmUgYXNzaWduZWQg
YSB0eXBlIHN1Y2ggYXMNCj4gPiBQRVJGX1RZUEVfUkFXLCBvdGhlciBjb3JlIFBNVSdzIGFyZSBk
eW5hbWljYWxseSBhbGxvY2F0ZWQgYXQgYm9vdA0KPiA+IHRpbWUuDQo+ID4gSWYgdGhpcyB2YWx1
ZSBkb2VzIG5vdCBtYXRjaCBhbiBleGlzdGluZyBQRVJGX1RZUEVfWCB2YWx1ZSwNCj4gPiBvdXRw
dXRfdHlwZShwZXJmX2V2ZW50X2F0dHIudHlwZSkgd2lsbCByZXR1cm4gT1VUUFVUX1RZUEVfT1RI
RVIuDQo+ID4gDQo+ID4gSW5zdGVhZCBzZWFyY2ggZm9yIGEgY29yZSBQTVUgd2l0aCBhIG1hdGNo
aW5nIHBlcmZfZXZlbnRfYXR0ciB0eXBlDQo+ID4gYW5kLCBpZiBvbmUgaXMgZm91bmQsIHJldHVy
biBQRVJGX1RZUEVfUkFXIHRvIG1hdGNoIG91dHB1dCBvZiBvdGhlcg0KPiA+IGNvcmUgUE1VJ3Mu
DQo+ID4gDQo+ID4gU3VnZ2VzdGVkLWJ5OiBLYW4gTGlhbmcgPGthbi5saWFuZ0BpbnRlbC5jb20+
DQo+ID4gU2lnbmVkLW9mZi1ieTogVGhvbWFzIEZhbGNvbiA8dGhvbWFzLmZhbGNvbkBpbnRlbC5j
b20+DQo+ID4gLS0tDQo+ID4gdjI6IHJlc3RyaWN0IHBtdSBsb29rdXAgdG8gcGxhdGZvcm1zIHdp
dGggbW9yZSB0aGFuIG9uZSBjb3JlIHBtdQ0KPiA+IC0tLQ0KPiA+IMKgdG9vbHMvcGVyZi9idWls
dGluLXNjcmlwdC5jIHwgMTUgKysrKysrKysrKysrKysrDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwg
MTUgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS90b29scy9wZXJmL2J1aWx0
aW4tc2NyaXB0LmMgYi90b29scy9wZXJmL2J1aWx0aW4tDQo+ID4gc2NyaXB0LmMNCj4gPiBpbmRl
eCA5ZTQ3OTA1Zjc1YTYuLjQ1OTc5NGM3MzdjZSAxMDA2NDQNCj4gPiAtLS0gYS90b29scy9wZXJm
L2J1aWx0aW4tc2NyaXB0LmMNCj4gPiArKysgYi90b29scy9wZXJmL2J1aWx0aW4tc2NyaXB0LmMN
Cj4gPiBAQCAtMzg0LDYgKzM4NCwxOCBAQCBzdGF0aWMgaW50IGV2c2VsX3NjcmlwdF9fZnByaW50
ZihzdHJ1Y3QNCj4gPiBldnNlbF9zY3JpcHQgKmVzLCBGSUxFICpmcCkNCj4gPiDCoAkJwqDCoMKg
wqDCoMKgIHN0LnN0X3NpemUgLyAxMDI0LjAgLyAxMDI0LjAsIGVzLT5maWxlbmFtZSwNCj4gPiBl
cy0+c2FtcGxlcyk7DQo+ID4gwqB9DQo+ID4gwqANCj4gPiArc3RhdGljIGJvb2wgb3V0cHV0X3R5
cGVfbWFueV9jb3JlX3BtdXModW5zaWduZWQgaW50IHR5cGUpDQo+ID4gK3sNCj4gPiArCXN0cnVj
dCBwZXJmX3BtdSAqcG11Ow0KPiA+ICsNCj4gPiArCWlmIChwZXJmX3BtdXNfX251bV9jb3JlX3Bt
dXMoKSA+IDEpIHsNCj4gPiArCQlwbXUgPSBwZXJmX3BtdXNfX2ZpbmRfYnlfdHlwZSh0eXBlKTsN
Cj4gPiArCQlpZiAocG11ICYmIHBtdS0+aXNfY29yZSk+DQo+ID4gKwkJCXJldHVybiB0cnVlOw0K
PiANCj4gSSB0aGluayBpdCBzaG91bGQgYmUgZ29vZCBlbm91Z2ggdG8gc2VhcmNoIHRoZSBjb3Jl
X3BtdXMuDQo+IAlsaXN0X2Zvcl9lYWNoX2VudHJ5KHBtdSwgJmNvcmVfcG11cywgbGlzdCkgew0K
PiAJCWlmIChwbXUtPnR5cGUgPT0gdHlwZSkNCj4gCQkJcmV0dXJuIHRydWU7DQo+IAl9DQo+IA0K
PiBUaGFua3MsDQo+IEthbg0KDQpUaGFua3MsIHdpbGwgcmVzZW5kIHdpdGggeW91ciBjaGFuZ2Vz
Lg0KDQpUb20NCg0KPiA+ICsJfQ0KPiA+ICsJcmV0dXJuIGZhbHNlOw0KPiA+ICt9DQo+ID4gKw0K
PiA+IMKgc3RhdGljIGlubGluZSBpbnQgb3V0cHV0X3R5cGUodW5zaWduZWQgaW50IHR5cGUpDQo+
ID4gwqB7DQo+ID4gwqAJc3dpdGNoICh0eXBlKSB7DQo+ID4gQEAgLTM5NCw2ICs0MDYsOSBAQCBz
dGF0aWMgaW5saW5lIGludCBvdXRwdXRfdHlwZSh1bnNpZ25lZCBpbnQNCj4gPiB0eXBlKQ0KPiA+
IMKgCQkJcmV0dXJuIHR5cGU7DQo+ID4gwqAJfQ0KPiA+IMKgDQo+ID4gKwlpZiAob3V0cHV0X3R5
cGVfbWFueV9jb3JlX3BtdXModHlwZSkpDQo+ID4gKwkJcmV0dXJuIFBFUkZfVFlQRV9SQVc7DQo+
ID4gKw0KPiA+IMKgCXJldHVybiBPVVRQVVRfVFlQRV9PVEhFUjsNCj4gPiDCoH0NCj4gPiDCoA0K
PiANCg0K
