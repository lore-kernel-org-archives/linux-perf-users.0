Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096A71586FE;
	Fri,  1 Nov 2024 08:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730448419; cv=fail; b=ZdWXGt+ONU/J5jM2Fv6Zct4Os7n4O0mp5rNzevvTVGWagHJzFcM/mZ3l/O2azui88iCToatPLOgZ+cq/jJqP0JsUh7fqvVWEHtLMqK5BOeVAnSGWxoww4/6+R001UxIoYjjGXWXL+Xgq+vFBT8VnPm1my4MD/k7FaQ8RyqWRz/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730448419; c=relaxed/simple;
	bh=xgT4yBhy0zw9ZPnBgcdDviGLVOp5+sOmyrXH8+vkX/8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OwyqK9+Ont73ngRavzM9wF3h+ikMsyOhf0u8wBQ0/oTJnYr6RjVdpCq7RtB3kkG5Ai6SWUvKeCrDsZPYu2d9EOO2RE3dvxPNpzpuGmVANYZcvXpKAIC4OzxigIdi/fxDW7v4pwdnYv1TjjziphN4Htg5J01Z3iXwHxSdy5BQlw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aj1+yBL3; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aj1+yBL3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730448417; x=1761984417;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xgT4yBhy0zw9ZPnBgcdDviGLVOp5+sOmyrXH8+vkX/8=;
  b=aj1+yBL3XxCKLz/BkffcRTo37U1pR3urLCD20FoFyATnk4lGaAezG9Iz
   nb544+usoeLcEXZo32Wq/a7DROJ4B1ZSt+9yanY/CKPVzBh+8yvnQ9Thi
   oKQadpXwzJfarWbyDv9JgDur63eujSaOiq3n0b2OIiC6DwPWxGms4BXzb
   nl5CIuDOco62vSXkr/5ijkjkkpyuvvi25aod6K3X1tEyRu49tThRFJ99c
   +WbxoF+2E5359ZwOK7Q7zkKLuGJcj/T+JgGD52g4EveYZfQOYmhX8qFZb
   5Un+ePwBp2SDX97dmi2KjIjq5J1OZ8OYhsYiDQci6B6m5hvcfnM3bccxw
   A==;
X-CSE-ConnectionGUID: MWPPLQxlRSexqBHdCb8REQ==
X-CSE-MsgGUID: LJOFUE8LT/iCwlgnGtSRRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="29628886"
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="29628886"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 01:06:56 -0700
X-CSE-ConnectionGUID: Q7SdmSL8SmSfzNX77bqcsg==
X-CSE-MsgGUID: qyAkppdyTQa9WbH5VF/0UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="83013808"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2024 01:06:52 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Nov 2024 01:06:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 1 Nov 2024 01:06:51 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 01:06:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e58JNg409Vgf7OwWCuGb39txh2pDNOIonIib8eTkCsZQz+1HOsFF5sBNPKnoe2m7MfsaCBnX0n4V2kmoNhUF6b5Lda2fZPP4KK5U7MLhDjMPpvXsgTftLFyZ1mTgF0brTpKJTTcRGPeNDMyoNQcsdKA/n3jioFpgYsj/fVwD9458fAj1ETxnQJ7Pe9WMO4qlLVqgYZb/r31JhgfyemGbx8NbVDGQGUmkiZNEfwGx2uFvFO30kMbc1XnySqt7Hxxs92Ll+FGmd4yQ9OS/fVh2pT4iwN8lpdcd1rhYkMz7GB8p0F+KDiQh/3m4Onzk83pvGH7RHt/MXDUq5beTGgjcuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgT4yBhy0zw9ZPnBgcdDviGLVOp5+sOmyrXH8+vkX/8=;
 b=oO5chEa/iU5CDIh6U76GN2Szc5op1x3DiTlkTbDd3WRVEEWNs9xVihJTZchT44FXwdsOgrhaxlU7W9ZaR9hASd0tJ1Ea2+NKSr06nfRMt4JNhw9oGgudZdnDPm+HeJ9pDyc+yLTC5qBJcmfUVV5u4OsWcqdyQP1fib1K/+BsK/pMaLkUuPgEk3NN/rm6pMRfBWCdCcCVMzubxTyzQy9HCZe5+Rw4BZAaLpjCBuPHMfGZ/tFnz/K5nKmXvVe2xyf1kfJQzzXSvDa9WqXywupPeEJd+HqDp3u5YGwGdh0MCYoQ3mg8HaHAPGU4KOBbT5SoGzO1GNTj7q4Q6QvUGMFxAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by MN0PR11MB6088.namprd11.prod.outlook.com (2603:10b6:208:3cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.27; Fri, 1 Nov
 2024 08:06:48 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%5]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 08:06:48 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "Dhananjay.Ugwekar@amd.com" <Dhananjay.Ugwekar@amd.com>,
	"gautham.shenoy@amd.com" <gautham.shenoy@amd.com>
CC: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"ananth.narayan@amd.com" <ananth.narayan@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"ravi.bangoria@amd.com" <ravi.bangoria@amd.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"irogers@google.com" <irogers@google.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>,
	"acme@kernel.org" <acme@kernel.org>, "kprateek.nayak@amd.com"
	<kprateek.nayak@amd.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v6 03/10] perf/x86/rapl: Remove the cpu_to_rapl_pmu()
 function
Thread-Topic: [PATCH v6 03/10] perf/x86/rapl: Remove the cpu_to_rapl_pmu()
 function
Thread-Index: AQHbJs8wlyvPvXT1VEWmwWZENYr1XrKb4DIAgAAHF4CABjUUgA==
Date: Fri, 1 Nov 2024 08:06:48 +0000
Message-ID: <2884838e95def2a0ca3d2c263de10d9aab991501.camel@intel.com>
References: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
	 <20241025111348.3810-4-Dhananjay.Ugwekar@amd.com>
	 <Zx9RHtFAURrORTrd@BLRRASHENOY1.amd.com>
	 <52e578d0-a885-4d6c-836d-fc3ec0f491b2@amd.com>
In-Reply-To: <52e578d0-a885-4d6c-836d-fc3ec0f491b2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|MN0PR11MB6088:EE_
x-ms-office365-filtering-correlation-id: e7a2b284-cd37-4c7a-e763-08dcfa4c2257
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UGU2cUpWd2lnWWI1UUVtVkt1cURWUlUrMWtSMG43WXlPNWw2N3N0aGZQb0ZL?=
 =?utf-8?B?TTZyWEptMldOWUg5SlZQYkVER1JlWlpMRW8yUHFGSmlvQ0ovSGNLeGI4UWlQ?=
 =?utf-8?B?VEpMSG5WLzNJcXVXaVpLaENqTS8wcExZT3VnR0tIeEtXOUxhcWpJejBOT1RL?=
 =?utf-8?B?ZmlCblcxeG5vNldEams0N2dNbXJUVWJabFNDVFZMWDRhUmkxc3ZLYVVhZEF2?=
 =?utf-8?B?OEsyaVNQeFZ6SFppd05oSmNKczJjdzFiNkdMaHBSWGM3eFo3UHNKd0toY1Ay?=
 =?utf-8?B?K0RsaEZQZEFzeVlJM2Qrems3S1pGM1lmTk1UeGJoa1lSQS9Gc3RVd0FNam12?=
 =?utf-8?B?U0NXMEdyNGRrVXRUNXJJWkJoSDdDQW5xamRIM2ZOYjh2MitQWmtnNThXNDRi?=
 =?utf-8?B?OGpwMzVTVmJDcUZvKzVFWHZ4b2tvb2NiaUdYOXZmVGJuRlF2U09pYU81QTBH?=
 =?utf-8?B?RGRRZVlXNVNJY3h4eXM0SFh5UjFxUFlGOG1ueWJUYW42Q0luS3ZKakpyRnJy?=
 =?utf-8?B?eUwzQzRaMVF5Q3JHVW9wMm5aMnFqWFRYTWdueE9wUmw4TkJYKzFDbWw4K2U4?=
 =?utf-8?B?WHZ4NUhlNnlWZjdZUWVWSUlRNVpSRU0vK0h4d3FTaVowbXdWK2NneWF4NEsw?=
 =?utf-8?B?b1BkUzJncEV2bUE3aUhtYS9JTzNETDA4OWNjS2IyR25TK3lKQmRhelVqbG5O?=
 =?utf-8?B?REJCNkROR1JRbVE4MUVveTdzdXVhN0JPcnZyQTkwdlBIdW43MkhiTUlEeE1j?=
 =?utf-8?B?Ri8xZkpkQms1cDBtbzhjNXppUUVnUU9aaHIwK3ZIVTljL3F6RWY0TTYrVDRQ?=
 =?utf-8?B?cWZGRjh0L1JRWnFWN1V1R1ozdm5oTSs5SHN2Q3VocFRCdDRZM3Z1d0hQZm5S?=
 =?utf-8?B?QnVVdE9wVSs4blJwd1ZxK3E3dUhPYVhQZ3U1TlZMeHVzQVNqNlhyNkxzU3B2?=
 =?utf-8?B?RHM5MXR1U3lPRUx1SXlZT2loVlNLcU5zSFhjT0tTY29ET0NLV0lWNEVGZWZi?=
 =?utf-8?B?ZUwrK3ZtRlVPWXlvVXZGK2c1YkhuaGtQSjlSaldwUXZpaFlOSFZPSVFPeFll?=
 =?utf-8?B?OFY3QUI5OUJjVFZGSWgwNGRxLzNTVHdOREpISHZVTFpCdGU3cWN4ZWlWcENh?=
 =?utf-8?B?bHVSSExkK3ZFRGN3enhib1FKbzhlaytsK2oxbysweDhYaUNhRldXby91bmtt?=
 =?utf-8?B?VUlHamRmMGhyRVNPTG5YR09wSURpVWlBbTdpTnhCeC9XMGpSMFIrYmp4OXZa?=
 =?utf-8?B?RHhOb2d6VEt2bDlzakZXdEVMR3dURUQ3UitRcDRNUWt1dlZuOTlqZTlGaGtu?=
 =?utf-8?B?MGFUeE5KMkR4ZjRSeW04cVBHSEpjMlM0K1V4N3lpOStYZE1DY2lqYXcyRlZL?=
 =?utf-8?B?bXBGN05NM2JTWVdSaXMvZnA5dTZsWTFYNTY1WktLWW04a1dCN0RnTDBlOFhC?=
 =?utf-8?B?S3VxSERsVDNSbDRubURrZ2ZCM20rRktkdTRFR2FhTnlmSW15YjhsZ1Y2U0lN?=
 =?utf-8?B?Znp4UFd4d3RLT1R1RVVKWk9sZi9WaExnUHJTcGVrTFMzMjBveFh0ajBwNlNh?=
 =?utf-8?B?QzhQbGIrQWRDRkg3YnRTb1RmWHhBRWUweThldDF6ejczN0R1TTBTT1l6eVRC?=
 =?utf-8?B?alJyRm1Rb1JPZGlUMGlqc2lUYXhYQW5rQms5b1FQWjZtaW5IVlpaT291eXM4?=
 =?utf-8?B?U255TllkekhiVzdXOFFEdkdXMzQyOW8wQ1llT0N3aHcxZUFuSVIvSDdtM1k5?=
 =?utf-8?B?ZTJZNERsdis2YkhoMGJmeTlXNVZMZmVtUVhLQjBsSFFUVXVaZzJTNlBqYlRE?=
 =?utf-8?Q?epx2uEKf6nOwRo86aDBVrN8EDE0+nII0PVyps=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWhhSWYwdC9iZTczeTM3OGVQbmdYcUtGWG1qQTdMc1FtNmh6YXY2cDRhVjdV?=
 =?utf-8?B?ZURxQng2MjlBclVvVkxGampSRnZrRzZzU3VCSXA5Skdaay81Sk5VNzBvdnJx?=
 =?utf-8?B?ZFVFd2RTOXUxZGxkb1pHL0FERE8wRG8yQ1Z6RFN1UHhmeU9RTVhOTXBPU0tn?=
 =?utf-8?B?NW9IUmJqMXJOZnZRVVFKVXVzRHpqRis2VVVJcXVYb3lBMk51R242VnVUMGlE?=
 =?utf-8?B?dmxnWWpNQWVrZkNOTXF6ZVJsVmRvUllFSzlEOU12Z1ZtUEhzWVdndEJSQmVt?=
 =?utf-8?B?OHZFRlU4eGE4cW8rM2tZZFBOMUsyWXhqWEJBSzdxb2pWRHIza24rRkdvUDNu?=
 =?utf-8?B?TmFlcVp6MlhGZVJ0WE1ZMTBXRGtmdlRHOUVOdWFHVlk2VkJyeFZJYU8xYmJn?=
 =?utf-8?B?cEFqc2k1UTc4VHh1RnhhdGlacWNtb1YwSmcxS252QjZMVjlpb2FJL0VSbVZx?=
 =?utf-8?B?TmxadDc4bFhsZzFJaXdGeDBVK0xZQmZMSDBEYjM2emc5YVY0UmtGc042bWhs?=
 =?utf-8?B?VFpBTklQT2EyZnRsRmpEMFZpK1JvTndhQkhRekJLZ0U2V3dwTU9iYUlBd2Jq?=
 =?utf-8?B?dmxoRDVsN21IenFRMEtRS0FHenJ1citDWHhPcFFOUGZkendaMGxvaXNpa1hj?=
 =?utf-8?B?NUt4ZnVuNHZIWnRLQkl5RlVIeEhWcll6Uk9PM21RbnVjMGVzbkgwN1JGUkU5?=
 =?utf-8?B?UkV6bWpjWlB1d0RkalpaUWxHM1JpaTRaUElhblhXQy9CLzR1UVkyaDduVE1N?=
 =?utf-8?B?dGtOVEZlVGdrSkRwTFJmUGJkd1JzcUpWbzMvRWdra281Q1RqQ05uNXBuSFBZ?=
 =?utf-8?B?cnZ4akpIdE9tbHJkTEh2SnhqNGVHVXRpSWVOeHZlZkJ5VmxFSnNIM213eThh?=
 =?utf-8?B?U2ZJM3Jjd0ppMk40UzZaVUJHUGtDbUNRMXROeWU5SmZOdDFLU2JQK2x2Zmk1?=
 =?utf-8?B?YmQxWHlMUG1mMStWOTdmS0FBeGxKM1VsOG45VDNXYWVKREkyMDdOTVdHUjBB?=
 =?utf-8?B?M3ROVVo4a1NOVjRERDVISHBSb0tXVmFUdm1FUXQ4TDJCem9FN2hDWDk1NEVm?=
 =?utf-8?B?MDZsbVNYK0pSUU5leXZKcUpPZkRJZ3Z0NzY0dmswUkJLa3FyeE5CZ2QxQWw2?=
 =?utf-8?B?TVVIemJ2NXhaWGJZeTdHSFJLTzZDeU9oNWxFTzdCRHFpWlY5T05rNVhHbzJY?=
 =?utf-8?B?aEVNTU1SR1ljRmtRSkFhZytVUmFHWXc5clVac1V6QTZIdnI3RmxpQm05RnpY?=
 =?utf-8?B?WkNQZG5lS0luTVZnUGY5N3pFMWtyd0NhRm5KMGZKbWl0SWwvY2F1RkFSdWxW?=
 =?utf-8?B?Qy95Wlc1YWx3M1h6Q3pYOEc5UHpxL3JoSE01K3E5STRMSHBwTGdnNWc0MXJD?=
 =?utf-8?B?WEV2eWwrVlN4RUVFcjMreVV3bUpJYVZTYTVMUXg2K3ZtdGVaNnFrcnJ0SG5M?=
 =?utf-8?B?RlIwS3RIQTNLT0wyNGVWenJtelpCNEc4S2ZkNTJ0T2JxWmljdVNiWXZGS2dH?=
 =?utf-8?B?Wk1hWW5UcDBtUUNFNzNKSDdPTGNHd0hBRkx2UVFUNklZZ29ISXoxWG9zcHo2?=
 =?utf-8?B?OVllbkcxWktWdDI3a0ErRHppZUN3RFdzbFlFQ3pVS1dSeWJhblV4MVkwWnhi?=
 =?utf-8?B?SHZqS2krZVZLVlBVQ0RBOEJKdlpCVnRSKysrQ1lSRVk3OWMrLy84Y2pKNzFC?=
 =?utf-8?B?akJZeUZVNWQ5NmxUNzQ0ckNoSXJBNkFnWDQ3SFVaa0Q1OUVJdlJyaGFrTW5r?=
 =?utf-8?B?OGo1SGFCaUc2SFdNOWg4elNvSjJ0Skg5a091RUtaeWxrdCsrWmIrclJ4WUZS?=
 =?utf-8?B?YkJ2c2pWeFRVMkt3V2Ewd2JvM2J4QnBVMFpYanZ4SlBPYWFUTXpPZ3ZJTVJn?=
 =?utf-8?B?cjZ6QnNTR1lVMWUxRlVmWng3bU1sY2hvWTZOSjZLOVdPbXlwbGl3a2FaK2Y4?=
 =?utf-8?B?MXd6SlNEcjNLRTg2OUlOaHFlOTYyTFlUM0IyR3dURzh1UktNQjg5eWQreUU4?=
 =?utf-8?B?b1ZCS3dMSm1Bd2lRSXhBTndwV0VsTFZNQnpmcEVONUxGNlM5WFBudXNCSG5H?=
 =?utf-8?B?V2Zmd2ZMSTZuV2RSOEUzMHhldW5wTHltRjN6UXJreEcrSlRyVlpPRm1CcHZU?=
 =?utf-8?B?SXhqdktGa2psWVYzbkRzWnZLNTY5bmIwZ01LT0tqSUNhYlFyMXk0NnJ1clFH?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76843FBB4F011E4C9D30259F4846E872@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a2b284-cd37-4c7a-e763-08dcfa4c2257
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 08:06:48.0233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EbcHjYStcnTIdP1tQAiZlqiAsLND8prKGYL2EkVk8LS2o+JVJZhowxXTPKUXLjZWYlAt9DCoOnoaZtbbq4eohQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6088
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTEwLTI4IGF0IDE0OjQ5ICswNTMwLCBEaGFuYW5qYXkgVWd3ZWthciB3cm90
ZToNCj4gSGVsbG8gR2F1dGhhbSwNCj4gDQo+IE9uIDEwLzI4LzIwMjQgMjoyMyBQTSwgR2F1dGhh
bSBSLiBTaGVub3kgd3JvdGU6DQo+ID4gSGVsbG8gRGhhbmFuamF5LA0KPiA+IA0KPiA+IE9uIEZy
aSwgT2N0IDI1LCAyMDI0IGF0IDExOjEzOjQxQU0gKzAwMDAsIERoYW5hbmpheSBVZ3dla2FyIHdy
b3RlOg0KPiA+ID4gUHJlcGFyZSBmb3IgdGhlIGFkZGl0aW9uIG9mIFJBUEwgY29yZSBlbmVyZ3kg
Y291bnRlciBzdXBwb3J0Lg0KPiA+ID4gUG9zdCB3aGljaCwgb25lIENQVSBtaWdodCBiZSBtYXBw
ZWQgdG8gbW9yZSB0aGFuIG9uZSByYXBsX3BtdQ0KPiA+ID4gKHBhY2thZ2UvZGllIG9uZSBhbmQg
YSBjb3JlIG9uZSkuIFNvLCByZW1vdmUgdGhlDQo+ID4gPiBjcHVfdG9fcmFwbF9wbXUoKQ0KPiA+
ID4gZnVuY3Rpb24uDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IERoYW5hbmpheSBVZ3dl
a2FyIDxEaGFuYW5qYXkuVWd3ZWthckBhbWQuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiDCoGFyY2gv
eDg2L2V2ZW50cy9yYXBsLmMgfCAxOSArKysrKystLS0tLS0tLS0tLS0tDQo+ID4gPiDCoDEgZmls
ZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4g
PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvZXZlbnRzL3JhcGwuYyBiL2FyY2gveDg2L2V2ZW50cy9y
YXBsLmMNCj4gPiA+IGluZGV4IGY3MGM0OWNhMGVmMy4uZDIwYzViMWRkMGFkIDEwMDY0NA0KPiA+
ID4gLS0tIGEvYXJjaC94ODYvZXZlbnRzL3JhcGwuYw0KPiA+ID4gKysrIGIvYXJjaC94ODYvZXZl
bnRzL3JhcGwuYw0KPiA+ID4gQEAgLTE2MiwxNyArMTYyLDYgQEAgc3RhdGljIGlubGluZSB1bnNp
Z25lZCBpbnQNCj4gPiA+IGdldF9yYXBsX3BtdV9pZHgoaW50IGNwdSkNCj4gPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgDQo+ID4gPiB0b3BvbG9neV9sb2dpY2FsX2RpZV9pZChjcHUpOw0KPiA+
ID4gwqB9DQo+ID4gPiDCoA0KPiA+ID4gLXN0YXRpYyBpbmxpbmUgc3RydWN0IHJhcGxfcG11ICpj
cHVfdG9fcmFwbF9wbXUodW5zaWduZWQgaW50IGNwdSkNCj4gPiA+IC17DQo+ID4gPiAtwqDCoMKg
wqDCoMKgwqB1bnNpZ25lZCBpbnQgcmFwbF9wbXVfaWR4ID0gZ2V0X3JhcGxfcG11X2lkeChjcHUp
Ow0KPiA+ID4gLQ0KPiA+ID4gLcKgwqDCoMKgwqDCoMKgLyoNCj4gPiA+IC3CoMKgwqDCoMKgwqDC
oCAqIFRoZSB1bnNpZ25lZCBjaGVjayBhbHNvIGNhdGNoZXMgdGhlICctMScgcmV0dXJuIHZhbHVl
DQo+ID4gPiBmb3Igbm9uDQo+ID4gPiAtwqDCoMKgwqDCoMKgwqAgKiBleGlzdGVudCBtYXBwaW5n
cyBpbiB0aGUgdG9wb2xvZ3kgbWFwLg0KPiA+ID4gLcKgwqDCoMKgwqDCoMKgICovDQo+ID4gDQo+
ID4gDQo+ID4gU2VlIHRoZSBjb21tZW50IGhlcmUgd2h5IHJhcGxfcG11X2lkeCBzaG91bGQgYmUg
YW4gInVuc2lnbmVkIGludCIuDQo+ID4gDQo+ID4gDQo+ID4gPiAtwqDCoMKgwqDCoMKgwqByZXR1
cm4gcmFwbF9wbXVfaWR4IDwgcmFwbF9wbXVzLT5ucl9yYXBsX3BtdSA/IHJhcGxfcG11cy0NCj4g
PiA+ID5wbXVzW3JhcGxfcG11X2lkeF0gOiBOVUxMOw0KPiA+ID4gLX0NCj4gPiA+IC0NCj4gPiA+
IMKgc3RhdGljIGlubGluZSB1NjQgcmFwbF9yZWFkX2NvdW50ZXIoc3RydWN0IHBlcmZfZXZlbnQg
KmV2ZW50KQ0KPiA+ID4gwqB7DQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgdTY0IHJhdzsNCj4gPiA+
IEBAIC0zNDgsNyArMzM3LDcgQEAgc3RhdGljIHZvaWQgcmFwbF9wbXVfZXZlbnRfZGVsKHN0cnVj
dA0KPiA+ID4gcGVyZl9ldmVudCAqZXZlbnQsIGludCBmbGFncykNCj4gPiA+IMKgc3RhdGljIGlu
dCByYXBsX3BtdV9ldmVudF9pbml0KHN0cnVjdCBwZXJmX2V2ZW50ICpldmVudCkNCj4gPiA+IMKg
ew0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoHU2NCBjZmcgPSBldmVudC0+YXR0ci5jb25maWcgJiBS
QVBMX0VWRU5UX01BU0s7DQo+ID4gPiAtwqDCoMKgwqDCoMKgwqBpbnQgYml0LCByZXQgPSAwOw0K
PiA+ID4gK8KgwqDCoMKgwqDCoMKgaW50IGJpdCwgcmFwbF9wbXVfaWR4LCByZXQgPSAwOw0KPiA+
IA0KPiA+IENvbnNpZGVyaW5nIHRoYXQsIHNob3VsZG4ndCByYXBsX3BtdV9pZHggYmUgYW4gInVu
c2lnbmVkIGludCIgbm8/DQo+IA0KPiBDb3JyZWN0LCB3aXRoIHVuc2lnbmVkIGludCB3ZSB3aWxs
IGJlIGFibGUgdG8gY2hlY2sgZm9yIG5lZ2F0aXZlDQo+IHZhbHVlcyBhcyB3ZWxsIHdpdGggdGhl
IA0KPiAiaWYgKHJhcGxfcG11X2lkeCA+PSByYXBsX3BtdXMtPm5yX3JhcGxfcG11KSIgY2hlY2su
IFdpbGwgZml4IHRoaXMgaW4NCj4gbmV4dCB2ZXJzaW9uLg0KPiANCnlvdSBjYW4gc3RpY2sgd2l0
aCB1bnNpZ25lZCBpbnQgaGVyZSwgYnV0IGluIHBhdGNoIDEwLzEwLCBJTU8sIG1ha2luZw0KZ2V0
X3JhcGxfcG11X2lkeCgpIHJldHVybiBpbnQgaW5zdGVhZCBvZiB1bnNpZ25lZCBpbnQgaXMgbW9y
ZQ0Kc3RyYWlnaHRmb3J3YXJkLg0KDQp0aGFua3MsDQpydWkNCg0KPiBUaGFua3MsDQo+IERoYW5h
bmpheQ0KPiANCj4gPiANCj4gPiAtLQ0KPiA+IFRoYW5rcyBhbmQgUmVnYXJkcw0KPiA+IGdhdXRo
YW0uDQo+ID4gDQo+ID4gDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHJhcGxfcG11ICpw
bXU7DQo+ID4gPiDCoA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoC8qIG9ubHkgbG9vayBhdCBSQVBM
IGV2ZW50cyAqLw0KPiA+ID4gQEAgLTM3Niw4ICszNjUsMTIgQEAgc3RhdGljIGludCByYXBsX3Bt
dV9ldmVudF9pbml0KHN0cnVjdA0KPiA+ID4gcGVyZl9ldmVudCAqZXZlbnQpDQo+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgaWYgKGV2ZW50LT5hdHRyLnNhbXBsZV9wZXJpb2QpIC8qIG5vIHNhbXBsaW5n
ICovDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRUlOVkFM
Ow0KPiA+ID4gwqANCj4gPiA+ICvCoMKgwqDCoMKgwqDCoHJhcGxfcG11X2lkeCA9IGdldF9yYXBs
X3BtdV9pZHgoZXZlbnQtPmNwdSk7DQo+ID4gPiArwqDCoMKgwqDCoMKgwqBpZiAocmFwbF9wbXVf
aWR4ID49IHJhcGxfcG11cy0+bnJfcmFwbF9wbXUpDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiArDQo+ID4gPiDCoMKgwqDCoMKgwqDC
oMKgLyogbXVzdCBiZSBkb25lIGJlZm9yZSB2YWxpZGF0ZV9ncm91cCAqLw0KPiA+ID4gLcKgwqDC
oMKgwqDCoMKgcG11ID0gY3B1X3RvX3JhcGxfcG11KGV2ZW50LT5jcHUpOw0KPiA+ID4gK8KgwqDC
oMKgwqDCoMKgcG11ID0gcmFwbF9wbXVzLT5wbXVzW3JhcGxfcG11X2lkeF07DQo+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgaWYgKCFwbXUpDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJldHVybiAtRUlOVkFMOw0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoGV2ZW50LT5wbXVfcHJp
dmF0ZSA9IHBtdTsNCj4gPiA+IC0tIA0KPiA+ID4gMi4zNC4xDQo+ID4gPiANCg0K
