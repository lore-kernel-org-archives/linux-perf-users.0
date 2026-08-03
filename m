Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AEA433BCA;
	Mon,  3 Aug 2026 18:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782812; cv=fail; b=Arni9anPIOZ/uLILSyN/oq2bMgXPCi/Yhg8KBSSanbkowobZqfzE38T6jJ58BjkHju5DjcdREiApm93r0MrfPvcryqLB5HOXwsfY/5hyEWcLyNM+73WvT9/rtEj9U3js0bVRNENQAi/24Sj3ydwof0fhyUTC9cMUUKSTwtt9It0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782812; c=relaxed/simple;
	bh=+RYg+l9n2S5R2o0GFJsoxdJUI0o8DYvJWxUhX8Q0N4I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c0hQ72io/scn9+FcEiIIEO0vDHJg/CtwTTHv68bd7h4ameg+mkzOY40/SpXkinwDYgz4PJdJCl9cuuSL/5fh1YzNhaT0SHc2ZTdhe0KB08XckCAEUBgY0PtINsZ2HbF8LzcXh6uEjGSbMK+3z8C3rLoesx2Z/cNddVdJY3xJlIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NYdhvRXL; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NYdhvRXL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785782809; x=1817318809;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+RYg+l9n2S5R2o0GFJsoxdJUI0o8DYvJWxUhX8Q0N4I=;
  b=NYdhvRXL90WgUu2wxMSOt5fMfwbm+eVqmZ4Qusad32zVcr/ZzX3uRocu
   zm3ADfHlEz7dmqe5wYoROMOfDgDrUi9s4NOzIZ+ZYX3ujjbnWNTjZhrOP
   9e4c3iDvvSj+DVXq1WQLsIdG8vsoWlDJBSY01IhaXev2rtaiNOQPVsDxI
   W/Yrc1WDrPaFyY8DAyxHn5w+wdD0qC0f0xy48h1QgOVvefOhC3t30GQ3t
   UVbmoB3iWvdsGgW7eaDra/q9K1C0aC7ieeYDeeMLLafa6t2zgKOv2kzP8
   bS4DpxTZeoHQvU+mMxmafWa/8VRWs7u9CQ+roD7dejzgmQph2PclNPrEK
   Q==;
X-CSE-ConnectionGUID: 3mKnP6cMRN+2wVtG8tp6cg==
X-CSE-MsgGUID: bsxVEJtXRqWCIFoDI56zyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="111882127"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="111882127"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 11:46:47 -0700
X-CSE-ConnectionGUID: dmXkwfj+RvqEu+R5B8NImg==
X-CSE-MsgGUID: Fys4pQ1KQqONYacvqmLlDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="260041514"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 11:46:47 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 11:46:46 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 11:46:46 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.57) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 11:46:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXRMhU2SnaDiH/3skccK+22HiAXR5jNHzu4HjqpB4RUIHSdr6E5AskrHYgxXKMaBxDKzRkJ2WcwdVp3nzkOWPe6D+fh8YxTAWARFgvCA+5ey4phpiyJj9q20bjPMoBpfBwKFLctzLc/VEuhUm+0HKrpk7iuO8LWmBDu3Bguoi1ahbfTvhITQuWlqkzrnjdyznCmVYw1N2KHc8vTOT1gROhE+B/XXSEqNlUcTew40LuMlqJ3yUQdq/JV6ntzPgXkNnOh8ZoNvqXo4BtWJpu0M5ib2oWbSco4cLAVSAZERcLeCfvLdes/eWdieHg8ct6mAf0O2b5yEY3aGUmFVkAheEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wELgQKFxkmPBdzPZ+8syGYv8rd/Axnd5yBWcU4Ib5p8=;
 b=sM9TjWtSTOQs+xIRXE0XLRXWyEUVky4v0uwlXa9LzNGY7SRdpZ1C8bmB6azEftjEuefv/1UffZEt2nT+Lz6bzPdw2s1PFqChSb0AUm1vpMsjk+29WcY3aifzZ7yh0AZHq+Q0jQD6Y16auvhHnyv1AGepcaP2EPDUMPyFC3eIAYPzFHRCw4Y8pd/NPXQuBfEX8tED38J+Jmfm62ojL+702xPyhiauyit+c9nh1rBCRG7GIJoR9+W5kmCe4rTWTruROgayx1tG8iCs8LcbwVG2Z3pmvliZ6PHGFHB0b8bhPMU/Gi2DhuF2k/iXU4MIpXJ7htXPVwglvA2I6XlO9jPnRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS0PR11MB8720.namprd11.prod.outlook.com (2603:10b6:8:1aa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 18:46:43 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 18:46:43 +0000
Message-ID: <dd4a6a5b-5abf-45e5-bb88-59d6e911123f@intel.com>
Date: Mon, 3 Aug 2026 21:46:38 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHES 0/5 v1] perf tools auxtrace hardening series
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo
	<acme@kernel.org>
CC: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Clark Williams <williams@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
References: <20260727161705.64807-1-acme@kernel.org>
 <am0vWwqDMib_NF6q@google.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <am0vWwqDMib_NF6q@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR06CA0021.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::26) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS0PR11MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b800436-4641-4f2f-3c3c-08def18f8fc6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|7416014|56012099006|10067099003|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: x3HVnN6YG4+/AM3gdo5lAOcrRfKx40e93Gv0MFC5hX25Kzg8ivbz+/OE3H1slt5XcgWFOcC4dcKoQuF30ezNUXmBhczhTlIr8TCGwCS37Tt4ZWW2fLjPM1aBZHaPEX38OvjqfmjpMw39v3bLI0Gyu9/Ic34hetr2GI3XTzkIpo8ZTRxG6G6C+dzxxBddsjRRLPFyJ4VhfCfOl8tXUfAJAU2urVUKUuAvTpLy1sVS2cnifqBH/DR4BJ4HP+YEGeIh9qoHjGKUp2W8cWnTfqtkNern9VX+Pa2QOW9WSQ63o9eKWTTSr3jwK801n1e8e2vy80EMeItAiUHErIp+h5//oHkhcZm3G44XF9dcd4QAbyyx+RFZZIBORvK5+6ZVntP05N9vSqidDXFJ74xJ+97JX8v+/6txNXqfVD8GBHCcGdUvE2pSAZ09EjMUpIxmfSZfUbTBwOoxTv2Bky2B8jPdW6W8bmFQaWAdGuhG7KLaSniUs5v+7fuKAy8aIpuAWs3O77zRI4C8fVlXBxGBe5cp7BcEpVcX9mY4BYUqhOLgzNA/d+vKXJMBXiUOduEyC90NSZmakfQIQNR5Pzi0+W85E+vF7UOY6f3vW9bQykDrWGnNvFo+bLypPPUda8GlhRR95dfQArk928jstQIQQFLym8LztDML8c2pJks50nvarI0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(56012099006)(10067099003)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDJ1OXBaQ2p3ZEMrSUY0SEpsbjBFSWh1WWhvVjFFKzlQQUYwWlU5enhuUDZH?=
 =?utf-8?B?bGxobis0U1Q4TytIU200UE5JcjlVUDdzaFEyOEZVc3ZBMDM0RVZHVUJWZlN3?=
 =?utf-8?B?ZXI0eCt6K2lLeE9KaG14Qm15SFJmUTNpNVdncWNJdVlvRzUvbVFPRm5mSUZT?=
 =?utf-8?B?dS96dG16VU1zZEJ2MGZ3Qm9PRlA5S3RFUno3dFZ4Z3JIUktnT3V2M1drUHZ3?=
 =?utf-8?B?YnFJemRWUC9nYlJtV0RSWGIyc0NCMWhZZ2s2UHR5SzEreFIxSDVPWk4rS284?=
 =?utf-8?B?bVJYUDFzU0krbWpuMGRsSTJDWG9GaDdVZ0xEZ210TkZSZXJHN2ZsZEh6eGdR?=
 =?utf-8?B?Q1duYW5RZC8wQUhnbUNMM0F1RFEyN2xtd3JlcDNkR1V6aFdWaVM1SHBUL2I4?=
 =?utf-8?B?aHY1dWpCYjE0aXgwWG1YM0lJRFNnaDR3cTNBRWFLK3lOc3l5QS9jRXBJelA5?=
 =?utf-8?B?QzhBUWtrQ0tYdFUxK2FRdy9MaGlyU09LNFR5QTZscWpydUF0Uzl1endxcE5Y?=
 =?utf-8?B?RnNPTmJkZnpmdEFTS0RxWUtnNVhpYlU3T3Iyd1VIQW15cVpBWCt3cXhHRzhN?=
 =?utf-8?B?Q3VzOUpaMnl1M3pvMmY3S2lONnZ1ZjhoeFFzeXd5dVJNb0RvcjduUy9qQ1dF?=
 =?utf-8?B?NXg1YStXaFlBT2hzRTlyU0VpUnJQY3dZSmFCWkEvS0tUdDkvNzRrZ1ZvS2xq?=
 =?utf-8?B?WFlXYWZmQWREVmUrMTFYNHJjaFBobmI0Z1piclY1bi9VNkNIdlRDajVYVXhh?=
 =?utf-8?B?Y09mZTFNU2UzM25FSW1RaTY4YnlXTFJoVTZFd3VpaGpaV0xWQ0Y0UjRtYmRx?=
 =?utf-8?B?dlBPZWVjeDRLSU5QTFpzUnZ3TnI1TEVRR1ZmMkpNK3ZDcHd2eXpJbUw4V3Qv?=
 =?utf-8?B?OUF1V3R0dUdzMkZhbFMrRlAweUVFT3dGLzBYK0Q4M2Z5Snk2MCtiMnhwc0tN?=
 =?utf-8?B?cFJOME1pbmhLVnJUcDRDM1BKS1EwYWN4UEZVZGhQdHhkYXN4RDBxM3hqZEdh?=
 =?utf-8?B?SVhmaFk0YThGakV5cW5Jb0syb1QvVEpXUE9FUUZtUzVoUVRxZmNVdms1cmVG?=
 =?utf-8?B?Vk1lQ3FLSm9kWGxraTZMZG1raC9OTXRJc00zQy9sUW5lOWdvUmdKMVN5SjVZ?=
 =?utf-8?B?NFV6UE1ETFhHZmt6bmRVTFZ3VEVxcVZjQUc0T3Vaa3hiSDNSVkMrVWZqMk5O?=
 =?utf-8?B?Q24xcGI1OGxGenVYaS9SWEZmRVptenZ5eHN1TDQxVzlobnJycDJLbnlZV1Bj?=
 =?utf-8?B?aGU3VlB2ZmN0S2UxbmJGdnlubW9mRE5FUzVsaElmVzB1UVRPekRDR1ZEVHhx?=
 =?utf-8?B?U0I1Q25Sa1BrbmVDbUx6djhDR2JtdEJNVEQ3ZlpJYW9KTjdPelU4MCtUOTVO?=
 =?utf-8?B?M1ROV1lQWmwwNk1VM1JuczZPbFEwMVdqdFcrdFBoUjkzblovclZLOTVUWEdm?=
 =?utf-8?B?cDdEYzhPam9lT1hkSnlSZWloUDBXWUNOU2JKNW0rZjNIWUgxM0VFWW14dHZ1?=
 =?utf-8?B?dm9qL3IvUlFPUlRNOHIzYzZHS2EyS1BWMzBudUNCLzFvc0dBRWdtaUNGaUhK?=
 =?utf-8?B?K1h4Y05TV2FIZTlVRzN3N0UvUjVrM0lJUjd3WktxQlp0VFZRRk5IblRFbmtH?=
 =?utf-8?B?RmNOSzVzeTEyVzlXNXNoVy9CSU9sWDVFeHFrdEx0b2twa1VYNFVneUxONGN6?=
 =?utf-8?B?MlVXMXNkRkFJK3VaL1BISHkzOHVYakhLQXdxMUZaeTdiSURwQVRiZXlHdjRp?=
 =?utf-8?B?MHRZSlJ2TUNCRXBsblJ2WWpFK0dVODh5QkI0OVdwR1Qxa2tMMWE0bzFSRzNu?=
 =?utf-8?B?bmc0enJOU25RN25NRTdrdzA2QUliZlc3ZVowTGQ2L0ozVU5jV1RPYktIWlFF?=
 =?utf-8?B?RllldDB5SWVPQk83cGJYaUdqVm5uYmJRQVpJUWNtVExzL1JBamo3OFRndVlo?=
 =?utf-8?B?cFk1bW5aL1BjRWt4dFh4TWhCYzQzLzRWS2N1WkNJdWl0QnJWek1GdFFoTHcy?=
 =?utf-8?B?U3NjNkhuVHJVTmliMTBWTWoxWmdXbXJma25zS3FSRHl4aS82TWVsQmtvVXlK?=
 =?utf-8?B?TU94ZHhYb2c2am5idmk5OWt2a1MzZGJHTHRraXNSNXVDMk5WM3ZISkJHd2Zk?=
 =?utf-8?B?RlRwbzVScVVtVThGQlN0NlhWeWNVOXNrL0Z5ZithcnlZRmRNcVBxeEYzRk9H?=
 =?utf-8?B?STJVOWpQa1p6clBCRGxKRW52b2ZZMlp5OUE3N2hRR1U0MWFmWVdCN1AwcUhn?=
 =?utf-8?B?enlnWlVaUmVKKzgyem85aHJRbjU1MmVkREhxb0FTTExqMHJzdndnTGsreUs2?=
 =?utf-8?B?OTd1V0IwbTdMZHh3UXA2Y3Z2QVdDL2oyRTNvMHRDNGhoNk9FSkJMN3d2UXZi?=
 =?utf-8?Q?wOcbJyccNrPWZyTM=3D?=
X-Exchange-RoutingPolicyChecked: c9WMhoNnchZanvNyTCOwO/7x9VzEOlQz1GU1abLifqPDY8JvhnIR+kNqi4aH/OyleuN5XZJXkTb5iMixNMJoGp6Qm3v39HpBA7To5fel5fnkkcijrxDqsoQ00GOjW5R/Ek+2Q6iG03frwih7NP+QfJ3QLf4Waa9fl8ni9i8gL3qgoUYAfovAk7hyHUoG6P9E7ZgLcMPbGFCMit1BXOOuw5bhAvwynqNkgiDAwIl0pITZaAW9ysAlN3pbPR9RF5t1LOg6yLZDrUZ8xywLEROW6u0FfU63qPWOD0WCdG8nRdJ8ZaEid5386MLfMzummP/5QAvRpHQZTUZSV8OdqGtSuQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b800436-4641-4f2f-3c3c-08def18f8fc6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 18:46:42.9934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlHlcvTQk3eVrk8BB3THIXSIcWrX3Or+MLjATXBMsgpod7c8A2CZu4Nw1o8/X+JCCMP49RGmjQDHq+tJl7BZxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8720
X-OriginatorOrg: intel.com

On 01/08/2026 02:27, Namhyung Kim wrote:
> Hi Adrian,
> 
> On Mon, Jul 27, 2026 at 01:17:00PM -0300, Arnaldo Carvalho de Melo wrote:
>> Hi,
>>
>> 	Please consider applying,
>>
>> - Arnaldo
>>
>> Arnaldo Carvalho de Melo (5):
>>   perf thread-stack: Fix heap buffer overflow on branch stack wrap copy
>>   perf auxtrace: Fix queue grow overflow and old array leak
>>   perf intel-pt: Fix off-by-one in auxtrace_info minimum size check
>>   perf intel-bts: Fix off-by-one in auxtrace_info minimum size check
>>   perf arm-spe: Reject zero nr_cpu in metadata to prevent division by zero
> 
> Can you please review this series?

Certainly!

Other than the Fixes tag in "[PATCH 5/5] perf arm-spe: Reject zero
nr_cpu in metadata to prevent division by zero", for the series:

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> Thanks,
> Namhyung
> 
>>
>>  tools/perf/util/arm-spe.c      |  4 ++++
>>  tools/perf/util/auxtrace.c     | 15 ++++++++++-----
>>  tools/perf/util/intel-bts.c    |  2 +-
>>  tools/perf/util/intel-pt.c     |  2 +-
>>  tools/perf/util/thread-stack.c |  2 +-
>>  5 files changed, 17 insertions(+), 8 deletions(-)
>>
>> -- 
>> 2.55.0
>>

