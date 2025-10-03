Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2E71DB13A;
	Fri,  3 Oct 2025 11:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759491896; cv=fail; b=TezFQzDZPo+FnmSkbvBawN3QiKKy2VhEfwM3Z27xApW416Eeytjzyp93TN0vB8791NNzyRcfKIeLr6rolY0d6kSdWB/Wtve9ZaUZZM4hpka+s2xns4l2f0dyLw4hjS+gA3RSHYvhVN2kx0y8kvTzJ3wf/uUzF6M6WSXAMS1ZMbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759491896; c=relaxed/simple;
	bh=44erzBAyKgek0Gwm06B7dxvXosDc2iM0eZkzqwE0YrQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NNuyllb+MCSCAhNI2tGIPmtt7T/h2neu8AkSKA16mBpEOYHRCm0rwtO1nQvA5mJL1KMjgxWfrcbb852rxDmWfCz9Xm3Fc+h+9Qkq/BHiACymQ2zwa5fkXe+lDNQcpAwwS30LYhUnk7n9uQ9aM8ut0vESG2D5SgYxG+0Xx5OLy+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qx88WirL; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qx88WirL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759491894; x=1791027894;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=44erzBAyKgek0Gwm06B7dxvXosDc2iM0eZkzqwE0YrQ=;
  b=Qx88WirLKxbikMwSfn1mxnpUE65XsI33so7GjU/G+Y64uSLL3MUsm6Zm
   O8mDPYFQ22UdOkt6avBWZ0nLITvS0az8ODrVCWlGi6vRpbySeZ6nbphIb
   MgmR3klzj+mI9imYFCXe00Zvs/CkN7zDtXHVhm259JxSbQnNgVvVnIgNK
   y5VcdhJlnNnrri2jbxDG4I2x8c4wrwoKudQplUvfCevbHy3i07t8kgcdn
   bc8ZwXcLdjED9fv2x38My+rIGfCX2BREymzrfJvCeoi7il/2ki/ZWsWqa
   OO0Cm/+ZI0B9Z39T3g5D0uAK06EyfIoNPOQ7UlijKp5YIDbe6cW4Kb0nm
   A==;
X-CSE-ConnectionGUID: xk0Igb0QSqOXzvUhZI3blQ==
X-CSE-MsgGUID: og+KLJoxTuaKyfE78S65nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="60809469"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; 
   d="scan'208";a="60809469"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 04:44:53 -0700
X-CSE-ConnectionGUID: uatXsOVgRheSkbqy0GhEDA==
X-CSE-MsgGUID: EdIe6LzQSnufYgWYVIiqPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; 
   d="scan'208";a="179706247"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 04:44:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 3 Oct 2025 04:44:52 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 3 Oct 2025 04:44:52 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 3 Oct 2025 04:44:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAEADDTXbNhv0CY2ofpdrQ0aocIQubHaliXzp3CWxaHPINuvIPyK1BCpjyWcCxSpoFqgC0ffByTlxpFHb1+cAFqK+14wO1VFl1/4MBRS8em1fu2w1o89gXUPgjeTy3L9raqlhMmWIqCQTOCBDAZU7yckCUHexMscmrbnucpQxDLbJnCu4dBaxFZ7pdYNiLRUpnn+vmkWJzx+oCicz12vHh4ZN4T1nZOaAZT2ckMX0Bm4VNfZg1CJ2W9FZCyezL/KyVh35LTOTHZq6hYI+x70Kfr6NAUTid+Hrvdm+TlhmehJXF6DQ1aRTObAv0jvj62KeAYHlQ+VjQbbghdnpNiSwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ger4PaPqtwZkMBS4ECmiq7dC597QVZzrWq+8Sb1dfKc=;
 b=Pk6xH6i2gm5WEsYFuvmGiGyJTBPoPa3moLyOPzU+Qg3oweDVU1hGrWsS/6iGcaQ5uTFE4vz8Xlu3tTdmqC8KWBIOUuDk6Od3q+oqEjRvK59u7KCoauZt635qBAp5khsSEuoWnLKrr+0Eg9RJu9XTUO+IzQpm7qYVmgIphvkqXTYBNQAx6wXqOvP1SENUBnIPvca2WzH7O4aV7rcPn94zOxeZvQOv9xg5xloI/1Zt49qm9/m9lmCuOs0TabSkEwAUiArTtkF3/zXedJvcissCfkuE95Ofla8XGwXA6/b3w+GlSonRD5/v1M9mY458eFUm3nuZbWxjD8djPQWf3xZx5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB8289.namprd11.prod.outlook.com (2603:10b6:303:1e8::9)
 by SA1PR11MB5803.namprd11.prod.outlook.com (2603:10b6:806:23e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 11:44:45 +0000
Received: from MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022]) by MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022%6]) with mapi id 15.20.9160.015; Fri, 3 Oct 2025
 11:44:45 +0000
Message-ID: <9fd778d2-8383-4675-b07d-4d8bdd5cf674@intel.com>
Date: Fri, 3 Oct 2025 19:44:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] perf tools c2c: Add annotation support to perf c2c
 report
To: Namhyung Kim <namhyung@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Kan
 Liang" <kan.liang@linux.intel.com>, <wangyang.guo@intel.com>,
	<pan.deng@intel.com>, <zhiguo.zhou@intel.com>, <jiebin.sun@intel.com>,
	<thomas.falcon@intel.com>, <dapeng1.mi@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <aNo-U0KquRbcJam9@google.com>
 <20250930123900.1445017-1-tianyou.li@intel.com> <aN9ZiPYyYtr332h_@google.com>
Content-Language: en-US
From: "Li, Tianyou" <tianyou.li@intel.com>
In-Reply-To: <aN9ZiPYyYtr332h_@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1P15301CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:6::13) To MW4PR11MB8289.namprd11.prod.outlook.com
 (2603:10b6:303:1e8::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB8289:EE_|SA1PR11MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: 4229b097-1dfc-4625-f761-08de02723f21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVZGZ3FOeERMY25MOVdtMVd6SFBSTm5BUzV6MnJsRW04RjlwMzhjRXFYT2RJ?=
 =?utf-8?B?TWdqd2tmWjIxeVBrN2QzMDRaSFhEUzJXSWxPM0hLYXhRdmNJaURXaHVIZlFz?=
 =?utf-8?B?NWlzNlYwVitGVzdXVEQ0cWd1NmxzNE1Yc1BxNENZOHFMV3oxcmk4QVZ0UzZp?=
 =?utf-8?B?QXF3UitTOUp3Zm5Cdmo0bVVXMDN3SnNNYXF5aW5SczA1LzVPTk1DbEZvSHdW?=
 =?utf-8?B?SlR1b2graktiODB4N1NodjBOSE5iYWVkcENmNFgvUmhpOUMzMnliTjhlVVBI?=
 =?utf-8?B?Um9lVTlEOFlXOCs4YnZLWTBoYWpVNXB1L29XbFNaT2VyWXpGVEhLQ3BaQlN0?=
 =?utf-8?B?UDM1ZENKTnlRUnpBckpTb1V3dVM4WFA4eXhhWFJjZlA3U1AxOHB4QmdNQnZ4?=
 =?utf-8?B?UUxBUm0yNkVZYkltUXVoS1hIUkN3WVEyRDh2OC9PY1R3RGlUZzNocWtRRG9j?=
 =?utf-8?B?N3BWT2kzK2hWTERNSk01WEx4WEhsc1AvS1hHL2pHSmwyaUJUcmt0NE95N3pD?=
 =?utf-8?B?VmFRK3NMbVFIR0dKUGJSZHlxTzM0Vm1ieDV3WFh6U05LcGI3RjRVMEQyS0I1?=
 =?utf-8?B?b1NCTkR1dGJUVlBDcDVwZEI4SDAzZmhnUTlUaWU2R0JtY0VtMHlEcFNKTGNW?=
 =?utf-8?B?dzJQbXhnM2xxcHVDamJIbXFaZGQ4eDBiczVTVlVLMEFCbmZReGQ4NjA0T2dP?=
 =?utf-8?B?SE12azM3UHE3QUhWeDE4YjVkamJBdUliYTlIZU1GaVZaLzBJM0F0dVI0SWZl?=
 =?utf-8?B?NklFSVA2dnJJQmZ2K1hWZk1DZ0sxUkl4WkZ1ZldDSnpjd25Nc3UranE2V1l0?=
 =?utf-8?B?Vm5kUnhXeFhWQ01zWSs2MTNpbkFFVG9pS0lKVFI3QUN4L3QyTE51K0sxbTVD?=
 =?utf-8?B?YnE3ckJ1cSs0a3I5ZzFMUlloUmtiTDNVZitIVmZPSXRvcFRsT2s5K2IwTkZm?=
 =?utf-8?B?cFZHeXUwWGg2NTl6VjBtNzJJU3hiQ3M1eGltU2VRbndpbXM5ZVRIelBNdWJt?=
 =?utf-8?B?RzVTTUZvV1dXUFF2cCtGcTNGWGhrT29PRUhleEx0aGM4dGxvbmphTGc3U3B5?=
 =?utf-8?B?ZjZrYTZtaHdjWlZDQ25uamtUcWRJVHRLOWFEbXJ2MzVadE0wWCtZdjJScVQv?=
 =?utf-8?B?V3dHcmYyWVYxbnVMbnVPaTJxREpwSDkxRVFLWVBncVZNSTBDNXFtS3psZ0Yr?=
 =?utf-8?B?NGNvdXBrYWZBblBhWEM4WmR4NFFncGdIYVdCQklLdVArVm5Kc2NRYWZTbUN4?=
 =?utf-8?B?QkpxRlhpR0tKY3FaMU43eFJpbVk1U09rU3RPVEJpRWZsa1lYRzNlQUhsSjRD?=
 =?utf-8?B?d2lIemtZcHN1ajVpMDFnNjJ1ZGJJb1FweVNxcEdaSTFNWW10R2h1cDlEZE8x?=
 =?utf-8?B?a1FKSjFZUnN1NVg2cmREMThnbVl5ME82OFVCVkxuelQ4TnlLelFaUUVUdzUz?=
 =?utf-8?B?UW9SZUpkSVJwQUhiV2RrdmRQdjc0L1pMaUtqK1daRmx5ZHFxNXMxUnM1bUNL?=
 =?utf-8?B?MlcyaVdScE9UandFRjhvS2EyVTA1UW9pRDBzTDVuNmdrLzVEZWRHeU5EZUFQ?=
 =?utf-8?B?T1BtRWsydVhoTGdmRDlWU0lVQTVZb3NpWk9GOG9TR0l5Nm5yaENNakt5SDh5?=
 =?utf-8?B?bjB6SEViVWorUFBlaE5xNGhycDM2bTNROVpyMjNuOStVSCt1bm5tbUp6VDNW?=
 =?utf-8?B?Nnc3ZW9QOWI2aXJ2SEZJWDl2SGh1STczSFI0YmpMQktFK25GZzQrZCtlQ1hU?=
 =?utf-8?B?QU5PcmhPRU5sNlgvd2I5RDhQUnVzYnBKM0xlS3hIU2dEN29OYlBrUzZpd1JL?=
 =?utf-8?B?RjRnbXRkaHZzcVFRVEZqSWhNaUx2OVFKMXZ5Uk5XUmZicmRiVklPcllJREFJ?=
 =?utf-8?B?dEtmWFViSGlNWTVVTU5oK0M1WUxwb3gwRWdIa1RGVmJoNWhQSEk2bnBVV1Bp?=
 =?utf-8?Q?FQEhJ/KbZrY6oZQQNJOSt+sL4i00WyJk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB8289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak5hLytoS0kyVFF1ODNPbTdSY1lpUG9acllsQ1pjbWhpYkhjeTZ3K2crd3py?=
 =?utf-8?B?S0JiZE1QR2I2T2NPQjA1eTY0dG04M3hIdTJuTm5XT25Sa2N0STc2MHhId2pL?=
 =?utf-8?B?QkVSVmNRSXZRcUc5c1ZMcWJQMHMrcSs3bVptdi9DMmFna3EzbE1Kd3VVeC9o?=
 =?utf-8?B?ak92NG9UNlpVemVQeTFTVlpKUzhnbjFrdVZuSWZNZHU2bUEyaFZSM3YvdXBL?=
 =?utf-8?B?K25VUkxQSnZzQ3lIcEhXUHhYRG14N29mMEtXTGpxOTczMXFycjNyQnRZZkI5?=
 =?utf-8?B?Z3BsN2ZmeGJlSkhveXNpc0Zwcy8xVHhxWG1IbVU3RnJWRG9uN010bGpaMU14?=
 =?utf-8?B?aTUzUXFOYmRJNFpEYm1iWVE4NGFVNFovUlBneDROTys3WEdKaUxXVlVENkx3?=
 =?utf-8?B?bFhqam13ZEVJS3lvMW9SbmVGc2w3UFhSV1RVWHczMUx4L3VzMytjeFZkcVpi?=
 =?utf-8?B?b1lFNEVBNFlGS3czMk91bno2U0FOL2tNWDkxUmZ0Wms2RUJMY2JyUVJTaHpa?=
 =?utf-8?B?bE9CVGFkbzZCZ2Y4QXR6SmloK242SldvMXdqQWdlajlZMHpZUThNUmFCUzRm?=
 =?utf-8?B?Ly9FSEEzbmRVWjlOSjJONzRyNGdvcVlvU1l1b3F6SWtySndGeFRaU3BFdTQr?=
 =?utf-8?B?QVZxR2xzT0tzSFFwWGJrb0VuMDFkZ05GSWJLMlNmWENNOXRvLytaenFQU2FP?=
 =?utf-8?B?dkZQNml1RVRCUWhFdG90YU9tMk9KeStmU2Q1YlFKYW5oZlVKdmhVdFZwVjd3?=
 =?utf-8?B?dG4wbHUvQU5tUXNwVzlJS1BmV0tnNHdDQUlhZ2RtUytab3BrYWtOeVRYN2Fj?=
 =?utf-8?B?VnJnSUFzVWZQYmhIc3pONUhHMWhuRVlLVE1HQjl6QWZzdWsrdlkrY2wzU05X?=
 =?utf-8?B?YzNDNVB2cFRWV00vMVhZYUNuYUtrS1JBcUhEbUozdG5zY3BxQStzekhIbHcw?=
 =?utf-8?B?Q3hrcUpKQ0RyWXFjS2gzS25OTUJ6ZEFGdktuWnQxODN6WHp0N1c4NTB2Z09y?=
 =?utf-8?B?VXQ5ZHlEdkZlcElkcG56eGI4TVVlQlA3MVFLTnZ6dXpqdVRseVd6WjlQWkRa?=
 =?utf-8?B?UXdKSFZ3NVVuUS9xNXc2YW8xWDVvWTBSR1Y2eFdCYnpraFRjN0s1c3gzbTk5?=
 =?utf-8?B?TFZhVCsrUjFKK3VjSms5MDdVOTR5S3psY21Ia1BlVVRrUGlJY3dYL2l4eGlo?=
 =?utf-8?B?ZkQxRnVaWUNwVVpXKzhwcmNCdzlKSzNzRXZ1QkhqSFZ6d3c2OUwrU1ZWRW52?=
 =?utf-8?B?WC9kMTB2czlUeWJrWkRvcUlyVnNGSVFjeFZPTXppU1FpZ2Y2d1o5WXdMQklM?=
 =?utf-8?B?Nnl2T2hObzc0WnNLejFYYitZbTdpZElDRTVhdm83dnJ3NTd5NVJOWVZuNWxs?=
 =?utf-8?B?RWhONmZ0dFVlbE8wOXk5UVpKbEpLa2pJRW5pdFlZN1REcGJuQm9PVlhmcCtL?=
 =?utf-8?B?QzdCWDBoNzJldlhGQjdsR3ZlSWlEYUFTdStCOE5OYlozbCs0TTB0N1k5Tmlu?=
 =?utf-8?B?dGJNYmVMQ0V3clBCbXQ1ckxXQ0hWNUc2OHA4N3p1N3Q2ZDkwcWxWa3lIVk9r?=
 =?utf-8?B?UW1qODVqRXhyMjZJcWFJeWtXMXVVTDdKSjhuUG8yak9JY3Q0ZkZFaHJpeWNE?=
 =?utf-8?B?MHBVWnlXUis1WjJsQkJlbWdtUk01Q2VUK2ttY3FmVjFlVEl6S2RweXBQMkhH?=
 =?utf-8?B?eTMweWVTeHZQWFh5RHV3cVJWc1NVMUwwaEhuZUxoTkx5b0NHczhNS0RSTG9x?=
 =?utf-8?B?QythRFJyTlVOaVZzNUxqdHducHA5eDR1YWhBVjBZZjVEcTZlL2l3SjRpeTNq?=
 =?utf-8?B?NjB2OTU2K2VKa3FYd3lqekk3RldDYTlheDErNVVQVUJiaDZFRWVueG9Yb3kv?=
 =?utf-8?B?T0ljbVVaZ0VPQWVKYm9TNkpUSXRPd3dNQnZKTkxQV2F0TUExdVpmMzUxRVBL?=
 =?utf-8?B?cmwrOXhsYThmQ2U2YjVNVkM3SHcwK2NMcmRBM1BTbkM4dmdKRmZLbkozeEds?=
 =?utf-8?B?U016U1FXckFQYjloVjRHMkhEbzNRNm8rZXlWY3hIYXB4akg4OTB0ZWVlT0Zn?=
 =?utf-8?B?YXZZTm5VM3lRWEVIZUp5UVRBQW5TZC9xaXNRRXFod3VZM3FoVk4wMkpKS3hC?=
 =?utf-8?Q?K5TUb60RpH93LS8GJt7qkZNVK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4229b097-1dfc-4625-f761-08de02723f21
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB8289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 11:44:45.3262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N873kuHD10BHnDHhOq8xCNft/+KJHF228uAITf15tbYkGZgaqHj0MXW5684DKOfnM1T56e3BDgLYUQcZQMespw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5803
X-OriginatorOrg: intel.com

Hi Namhyung,

Appreciated for your review comments. Sorry for the delayed response. I 
am on National Holiday so check email late. My response inlined for your 
consideration.

Regards,

Tianyou


On 10/3/2025 1:05 PM, Namhyung Kim wrote:
> Hello,
>
> On Tue, Sep 30, 2025 at 08:39:00PM +0800, Tianyou Li wrote:
>> Perf c2c report currently specified the code address and source:line
>> information in the cacheline browser, while it is lack of annotation
>> support like perf report to directly show the disassembly code for
>> the particular symbol shared that same cacheline. This patches add
>> a key 'a' binding to the cacheline browser which reuse the annotation
>> browser to show the disassembly view for easier analysis of cacheline
>> contentions. By default, the 'TAB' key navigate to the code address
>> where the contentions detected.
>>
>> Signed-off-by: Tianyou Li <tianyou.li@intel.com>
>> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
>> Reviewed-by: Jiebin Sun <jiebin.sun@intel.com>
>> Reviewed-by: Pan Deng <pan.deng@intel.com>
>> Reviewed-by: Zhiguo Zhou <zhiguo.zhou@intel.com>
>> Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
>> ---
>>   tools/perf/builtin-annotate.c     |   2 +-
>>   tools/perf/builtin-c2c.c          | 160 ++++++++++++++++++++++++++++--
>>   tools/perf/ui/browsers/annotate.c |  41 +++++++-
>>   tools/perf/ui/browsers/hists.c    |   2 +-
>>   tools/perf/util/annotate.c        |   2 +-
>>   tools/perf/util/annotate.h        |   2 +
>>   tools/perf/util/hist.h            |   6 +-
>>   7 files changed, 200 insertions(+), 15 deletions(-)
>>
>> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
>> index 646f43b0f7c4..d89796648bec 100644
>> --- a/tools/perf/builtin-annotate.c
>> +++ b/tools/perf/builtin-annotate.c
>> @@ -519,7 +519,7 @@ static void hists__find_annotations(struct hists *hists,
>>   			/* skip missing symbols */
>>   			nd = rb_next(nd);
>>   		} else if (use_browser == 1) {
>> -			key = hist_entry__tui_annotate(he, evsel, NULL);
>> +			key = hist_entry__tui_annotate(he, evsel, NULL, NO_INITIAL_AL_ADDR);
>>   
>>   			switch (key) {
>>   			case -1:
>> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
>> index 9e9ff471ddd1..7989fc46516e 100644
>> --- a/tools/perf/builtin-c2c.c
>> +++ b/tools/perf/builtin-c2c.c
>> @@ -45,6 +45,8 @@
>>   #include "pmus.h"
>>   #include "string2.h"
>>   #include "util/util.h"
>> +#include "util/symbol.h"
>> +#include "util/annotate.h"
>>   
>>   struct c2c_hists {
>>   	struct hists		hists;
>> @@ -62,6 +64,7 @@ struct compute_stats {
>>   
>>   struct c2c_hist_entry {
>>   	struct c2c_hists	*hists;
>> +	struct evsel		*evsel;
>>   	struct c2c_stats	 stats;
>>   	unsigned long		*cpuset;
>>   	unsigned long		*nodeset;
>> @@ -225,6 +228,12 @@ he__get_c2c_hists(struct hist_entry *he,
>>   	return hists;
>>   }
>>   
>> +static void c2c_he__set_evsel(struct c2c_hist_entry *c2c_he,
>> +				struct evsel *evsel)
>> +{
>> +	c2c_he->evsel = evsel;
>> +}
>> +
>>   static void c2c_he__set_cpu(struct c2c_hist_entry *c2c_he,
>>   			    struct perf_sample *sample)
>>   {
>> @@ -334,6 +343,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>>   
>>   	c2c_he__set_cpu(c2c_he, sample);
>>   	c2c_he__set_node(c2c_he, sample);
>> +	c2c_he__set_evsel(c2c_he, evsel);
>>   
>>   	hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
>>   	ret = hist_entry__append_callchain(he, sample);
>> @@ -371,6 +381,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>>   
>>   		c2c_he__set_cpu(c2c_he, sample);
>>   		c2c_he__set_node(c2c_he, sample);
>> +		c2c_he__set_evsel(c2c_he, evsel);
>>   
>>   		hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
>>   		ret = hist_entry__append_callchain(he, sample);
>> @@ -1997,6 +2008,9 @@ static int c2c_hists__init_sort(struct perf_hpp_list *hpp_list, char *name, stru
>>   	if (dim == &dim_dso)
>>   		hpp_list->dso = 1;
>>   
>> +	if (dim == &dim_symbol)
>> +		hpp_list->sym = 1;
>> +
>>   	perf_hpp_list__register_sort_field(hpp_list, &c2c_fmt->fmt);
>>   	return 0;
>>   }
>> @@ -2549,7 +2563,65 @@ static void perf_c2c__hists_fprintf(FILE *out, struct perf_session *session)
>>   	print_pareto(out, perf_session__env(session));
>>   }
>>   
>> +/*
>> + * Return true if annotation is possible. When list is NULL,
>> + * it means that we are called at the c2c_browser level,
>> + * in that case we allow annotation to be initialized.When list
>> + * is non-NULL, it means that we are called at the cacheline_browser
>> + * level, in that case we allow annotation only if use_browser
>> + * is set and symbol information is available.
>> + */
>> +static bool perf_c2c__has_annotation(struct perf_hpp_list *list)
>> +{
>> +	bool has_annotation = false;
>> +
>> +	if (list == NULL)
>> +		has_annotation = use_browser == 1;
>> +	else
>> +		has_annotation = use_browser == 1 && list->sym;
>> +
>> +	return has_annotation;
> Nit: it would be simpler this way.
>
> 	if (use_browser != 1)
> 		return false;
> 	return !list || list->sym;


Nice, the code looks more concise. Will update it in patch v6. Thanks.


>> +}
>> +
>>   #ifdef HAVE_SLANG_SUPPORT
>> +
>> +static int perf_c2c__toggle_annotation(struct hist_browser *browser)
>> +{
>> +	struct hist_entry *he = browser->he_selection;
>> +	struct symbol *sym = NULL;
>> +	struct c2c_hist_entry *c2c_he = NULL;
>> +	struct annotated_source *src = NULL;
>> +	u64 addr = 0;
> 	u64 addr = NO_INITIAL_AL_ADDR;
>
>> +
>> +	if (!perf_c2c__has_annotation(he->hists->hpp_list)) {
>> +		ui_browser__help_window(&browser->b, "No annotation support");
>> +		return 0;
>> +	}
>> +
>> +	if (he == NULL) {
>> +		ui_browser__help_window(&browser->b, "No entry selected for annotation");
>> +		return 0;
>> +	}
>> +	sym = (&he->ms)->sym;
> 	sym = he->ms.sym;


My mistake, thanks for pointing out. Will update in patch v6. Thanks.


>> +
>> +	if (sym == NULL) {
>> +		ui_browser__help_window(&browser->b, "Can not annotate, no symbol found");
>> +		return 0;
>> +	}
>> +
>> +	src = symbol__hists(sym, 0);
>> +	if (src == NULL) {
>> +		ui_browser__help_window(&browser->b, "Failed to initialize annotation source");
>> +		return 0;
>> +	}
>> +
>> +	if (he->mem_info)
>> +		addr = mem_info__iaddr(he->mem_info)->al_addr;
>> +
>> +	c2c_he = container_of(he, struct c2c_hist_entry, he);
>> +	return hist_entry__tui_annotate(he, c2c_he->evsel, NULL, addr);
>> +}
>> +
>>   static void c2c_browser__update_nr_entries(struct hist_browser *hb)
>>   {
>>   	u64 nr_entries = 0;
>> @@ -2617,6 +2689,7 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
>>   	" ENTER         Toggle callchains (if present) \n"
>>   	" n             Toggle Node details info \n"
>>   	" s             Toggle full length of symbol and source line columns \n"
>> +	" a             Toggle annotation view \n"
>>   	" q             Return back to cacheline list \n";
>>   
>>   	if (!he)
>> @@ -2651,6 +2724,9 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
>>   			c2c.node_info = (c2c.node_info + 1) % 3;
>>   			setup_nodes_header();
>>   			break;
>> +		case 'a':
>> +			perf_c2c__toggle_annotation(browser);
>> +			break;
>>   		case 'q':
>>   			goto out;
>>   		case '?':
>> @@ -2980,7 +3056,8 @@ static int setup_coalesce(const char *coalesce, bool no_source)
>>   	else if (c2c.display == DISPLAY_SNP_PEER)
>>   		sort_str = "tot_peer";
>>   
>> -	if (asprintf(&c2c.cl_resort, "offset,%s", sort_str) < 0)
>> +	/* add 'symbol' sort key to make sure hpp_list->sym get updated */
>> +	if (asprintf(&c2c.cl_resort, "offset,%s,symbol", sort_str) < 0)
> I think it's better to just process the input rather than enforcing it.
> It seems the default value will have 'iaddr' and so 'symbol as well.


Sorry I am not so clear about 'so symbol as well'. Did you mean we can 
check the 'dim == &dim_iaddr' instead of 'dim == &dim_symbol' to make 
sure hpp_list->sym = 1? If so, do we need to check the coalesce set to 
default 'iaddr' or not, otherwise we need to append the 'iaddr' in 
addition to the user specific one?


>
>>   		return -ENOMEM;
>>   
>>   	pr_debug("coalesce sort   fields: %s\n", c2c.cl_sort);
>> @@ -3006,6 +3083,7 @@ static int perf_c2c__report(int argc, const char **argv)
>>   	const char *display = NULL;
>>   	const char *coalesce = NULL;
>>   	bool no_source = false;
>> +	const char *disassembler_style = NULL, *objdump_path = NULL, *addr2line_path = NULL;
>>   	const struct option options[] = {
>>   	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
>>   		   "file", "vmlinux pathname"),
>> @@ -3033,6 +3111,12 @@ static int perf_c2c__report(int argc, const char **argv)
>>   	OPT_BOOLEAN(0, "stitch-lbr", &c2c.stitch_lbr,
>>   		    "Enable LBR callgraph stitching approach"),
>>   	OPT_BOOLEAN(0, "double-cl", &chk_double_cl, "Detect adjacent cacheline false sharing"),
>> +	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
>> +		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
>> +	OPT_STRING(0, "objdump", &objdump_path, "path",
>> +		   "objdump binary to use for disassembly and annotations"),
> Please update documentation with the new options.


Noted, will do in patch v6.


>
>> +	OPT_STRING(0, "addr2line", &addr2line_path, "path",
>> +		   "addr2line binary to use for line numbers"),
> Do you really need this?


In my use scenarios of c2c tool, I did not use this addr2line tool. If 
this was not quite necessary, I will remove it from patch v6.


>
>>   	OPT_PARENT(c2c_options),
>>   	OPT_END()
>>   	};
>> @@ -3040,6 +3124,12 @@ static int perf_c2c__report(int argc, const char **argv)
>>   	const char *output_str, *sort_str = NULL;
>>   	struct perf_env *env;
>>   
>> +	annotation_options__init();
>> +
>> +	err = hists__init();
>> +	if (err < 0)
>> +		goto out;
>> +
>>   	argc = parse_options(argc, argv, options, report_c2c_usage,
>>   			     PARSE_OPT_STOP_AT_NON_OPTION);
>>   	if (argc)
>> @@ -3052,6 +3142,36 @@ static int perf_c2c__report(int argc, const char **argv)
>>   	if (c2c.stats_only)
>>   		c2c.use_stdio = true;
>>   
>> +	/**
>> +	 * Annotation related options
>> +	 * disassembler_style, objdump_path, addr2line_path
>> +	 * are set in the c2c_options, so we can use them here.
>> +	 */
>> +	if (disassembler_style) {
>> +		annotate_opts.disassembler_style = strdup(disassembler_style);
>> +		if (!annotate_opts.disassembler_style) {
>> +			err = -ENOMEM;
>> +			pr_err("Failed to allocate memory for annotation options\n");
>> +			goto out;
>> +		}
>> +	}
>> +	if (objdump_path) {
>> +		annotate_opts.objdump_path = strdup(objdump_path);
>> +		if (!annotate_opts.objdump_path) {
>> +			err = -ENOMEM;
>> +			pr_err("Failed to allocate memory for annotation options\n");
>> +			goto out;
>> +		}
>> +	}
>> +	if (addr2line_path) {
>> +		symbol_conf.addr2line_path = strdup(addr2line_path);
>> +		if (!symbol_conf.addr2line_path) {
>> +			err = -ENOMEM;
>> +			pr_err("Failed to allocate memory for annotation options\n");
>> +			goto out;
>> +		}
>> +	}
>> +
>>   	err = symbol__validate_sym_arguments();
>>   	if (err)
>>   		goto out;
>> @@ -3126,6 +3246,38 @@ static int perf_c2c__report(int argc, const char **argv)
>>   	if (err)
>>   		goto out_mem2node;
>>   
>> +	if (c2c.use_stdio)
>> +		use_browser = 0;
>> +	else
>> +		use_browser = 1;
>> +
>> +	/*
>> +	 * Only in the TUI browser we are doing integrated annotation,
>> +	 * so don't allocate extra space that won't be used in the stdio
>> +	 * implementation.
>> +	 */
>> +	if (perf_c2c__has_annotation(NULL)) {
>> +		int ret = symbol__annotation_init();
>> +
>> +		if (ret < 0)
>> +			goto out_mem2node;
>> +		/*
>> +		 * For searching by name on the "Browse map details".
>> +		 * providing it only in verbose mode not to bloat too
>> +		 * much struct symbol.
>> +		 */
>> +		if (verbose > 0) {
>> +			/*
>> +			 * XXX: Need to provide a less kludgy way to ask for
>> +			 * more space per symbol, the u32 is for the index on
>> +			 * the ui browser.
>> +			 * See symbol__browser_index.
>> +			 */
>> +			symbol_conf.priv_size += sizeof(u32);
>> +		}
>> +		annotation_config__init();
>> +	}
>> +
>>   	if (symbol__init(env) < 0)
>>   		goto out_mem2node;
>>   
>> @@ -3135,11 +3287,6 @@ static int perf_c2c__report(int argc, const char **argv)
>>   		goto out_mem2node;
>>   	}
>>   
>> -	if (c2c.use_stdio)
>> -		use_browser = 0;
>> -	else
>> -		use_browser = 1;
>> -
>>   	setup_browser(false);
>>   
>>   	err = perf_session__process_events(session);
>> @@ -3210,6 +3357,7 @@ static int perf_c2c__report(int argc, const char **argv)
>>   out_session:
>>   	perf_session__delete(session);
>>   out:
>> +	annotation_options__exit();
>>   	return err;
>>   }
>>   
>> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
>> index 8fe699f98542..a9d56e67454d 100644
>> --- a/tools/perf/ui/browsers/annotate.c
>> +++ b/tools/perf/ui/browsers/annotate.c
>> @@ -605,7 +605,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
>>   	target_ms.map = ms->map;
>>   	target_ms.sym = dl->ops.target.sym;
>>   	annotation__unlock(notes);
>> -	__hist_entry__tui_annotate(browser->he, &target_ms, evsel, hbt);
>> +	__hist_entry__tui_annotate(browser->he, &target_ms, evsel, hbt, NO_INITIAL_AL_ADDR);
>>   
>>   	/*
>>   	 * The annotate_browser above changed the title with the target function
>> @@ -864,6 +864,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
>>   	const char *help = "Press 'h' for help on key bindings";
>>   	int delay_secs = hbt ? hbt->refresh : 0;
>>   	char *br_cntr_text = NULL;
>> +	u64 init_al_addr = NO_INITIAL_AL_ADDR;
>>   	char title[256];
>>   	int key;
>>   
>> @@ -873,6 +874,13 @@ static int annotate_browser__run(struct annotate_browser *browser,
>>   
>>   	annotate_browser__calc_percent(browser, evsel);
>>   
>> +	/* the selection are intentionally even not from the sample percentage */
>> +	if (browser->entries.rb_node == NULL && browser->selection) {
>> +		init_al_addr = sym->start + browser->selection->offset;
>> +		disasm_rb_tree__insert(browser, browser->selection);
>> +		browser->curr_hot = rb_last(&browser->entries);
>> +	}
>> +
>>   	if (browser->curr_hot) {
>>   		annotate_browser__set_rb_top(browser, browser->curr_hot);
>>   		browser->b.navkeypressed = false;
>> @@ -973,6 +981,18 @@ static int annotate_browser__run(struct annotate_browser *browser,
>>   				ui_helpline__puts(help);
>>   			annotate__scnprintf_title(hists, title, sizeof(title));
>>   			annotate_browser__show(browser, title, help);
>> +			/* Previous RB tree may not valid, need refresh according to new entries*/
>> +			if (init_al_addr != NO_INITIAL_AL_ADDR) {
>> +				struct disasm_line *dl = find_disasm_line(sym, init_al_addr, true);
>> +
>> +				browser->curr_hot = NULL;
>> +				browser->entries.rb_node = NULL;
>> +				if (dl != NULL) {
>> +					disasm_rb_tree__insert(browser, &dl->al);
>> +					browser->curr_hot = rb_last(&browser->entries);
>> +				}
>> +				nd = browser->curr_hot;
>> +			}
> Can you please split annotate changes from c2c change?  I think you can
> start with annotation support in c2c.  And add INITIAL_ADDR later so
> that we can discuss the issue separately.  Maybe we don't need the ADDR
> change.  Do you have any concrete usecase where default annotate is not
> enough for c2c?


Sure, I will split the patch into 2 patches. I use c2c extensively for 
my day-to-day performance work, the INITIAL_ADDR would be very helpful 
to located to the code where the iaddr was indicated in the cacheline 
browser. Otherwise, probably I need to copy the iaddr from the cacheline 
browser, get into the annotation browser, press 'o' to show the view 
with addresses in disassemble view, and manually find the iaddr match 
since the search only match string for disassembly code. The code 
highlight with INITIAL_ADDR would quickly allow me to navigate the 
contended lines of code from different functions showed in the cacheline 
browser, plus with  's' and 'T', I can get to the point more conveniently.


Agreed to discuss it separately, looking forward to hearing your thoughts.


Regards,

Tianyou


> Thanks,
> Namhyung
>
>>   			continue;
>>   		case 'o':
>>   			annotate_opts.use_offset = !annotate_opts.use_offset;
>> @@ -1106,22 +1126,23 @@ static int annotate_browser__run(struct annotate_browser *browser,
>>   }
>>   
>>   int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
>> -			     struct hist_browser_timer *hbt)
>> +			     struct hist_browser_timer *hbt, u64 init_al_addr)
>>   {
>>   	/* reset abort key so that it can get Ctrl-C as a key */
>>   	SLang_reset_tty();
>>   	SLang_init_tty(0, 0, 0);
>>   	SLtty_set_suspend_state(true);
>>   
>> -	return __hist_entry__tui_annotate(he, &he->ms, evsel, hbt);
>> +	return __hist_entry__tui_annotate(he, &he->ms, evsel, hbt, init_al_addr);
>>   }
>>   
>>   int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>>   			       struct evsel *evsel,
>> -			       struct hist_browser_timer *hbt)
>> +			       struct hist_browser_timer *hbt, u64 init_al_addr)
>>   {
>>   	struct symbol *sym = ms->sym;
>>   	struct annotation *notes = symbol__annotation(sym);
>> +	struct disasm_line *dl = NULL;
>>   	struct annotate_browser browser = {
>>   		.b = {
>>   			.refresh = annotate_browser__refresh,
>> @@ -1173,6 +1194,18 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>>   		browser.he = &annotate_he;
>>   	}
>>   
>> +	/*
>> +	 * If init_al_addr is set, it means that there should be a line
>> +	 * intentionally selected, not based on the percentages
>> +	 * which caculated by the event sampling. In this case, we
>> +	 * convey this information into the browser selection, where
>> +	 * the selection in other cases should be empty.
>> +	 */
>> +	if (init_al_addr != NO_INITIAL_AL_ADDR) {
>> +		dl = find_disasm_line(sym, init_al_addr, false);
>> +		browser.selection = &dl->al;
>> +	}
>> +
>>   	ui_helpline__push("Press ESC to exit");
>>   
>>   	if (annotate_opts.code_with_type) {
>> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
>> index 487c0b08c003..c34ddc4ca13f 100644
>> --- a/tools/perf/ui/browsers/hists.c
>> +++ b/tools/perf/ui/browsers/hists.c
>> @@ -2485,7 +2485,7 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
>>   		evsel = hists_to_evsel(browser->hists);
>>   
>>   	he = hist_browser__selected_entry(browser);
>> -	err = __hist_entry__tui_annotate(he, &act->ms, evsel, browser->hbt);
>> +	err = __hist_entry__tui_annotate(he, &act->ms, evsel, browser->hbt, NO_INITIAL_AL_ADDR);
>>   	/*
>>   	 * offer option to annotate the other branch source or target
>>   	 * (if they exists) when returning from annotate
>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>> index c9b220d9f924..937effbeda69 100644
>> --- a/tools/perf/util/annotate.c
>> +++ b/tools/perf/util/annotate.c
>> @@ -2622,7 +2622,7 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
>>   	return 0;
>>   }
>>   
>> -static struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip,
>> +struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip,
>>   					    bool allow_update)
>>   {
>>   	struct disasm_line *dl;
>> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
>> index eaf6c8aa7f47..bbe67588bbdd 100644
>> --- a/tools/perf/util/annotate.h
>> +++ b/tools/perf/util/annotate.h
>> @@ -170,6 +170,8 @@ static inline struct disasm_line *disasm_line(struct annotation_line *al)
>>   	return al ? container_of(al, struct disasm_line, al) : NULL;
>>   }
>>   
>> +struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip, bool allow_update);
>> +
>>   /*
>>    * Is this offset in the same function as the line it is used?
>>    * asm functions jump to other functions, for instance.
>> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
>> index c64005278687..7afa50aa5cbb 100644
>> --- a/tools/perf/util/hist.h
>> +++ b/tools/perf/util/hist.h
>> @@ -713,12 +713,14 @@ struct block_hist {
>>   #include "../ui/keysyms.h"
>>   void attr_to_script(char *buf, struct perf_event_attr *attr);
>>   
>> +#define NO_INITIAL_AL_ADDR 0
>> +
>>   int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>>   			       struct evsel *evsel,
>> -			       struct hist_browser_timer *hbt);
>> +			       struct hist_browser_timer *hbt, u64 init_al_addr);
>>   
>>   int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
>> -			     struct hist_browser_timer *hbt);
>> +			     struct hist_browser_timer *hbt, u64 init_al_addr);
>>   
>>   int evlist__tui_browse_hists(struct evlist *evlist, const char *help, struct hist_browser_timer *hbt,
>>   			     float min_pcnt, struct perf_env *env, bool warn_lost_event);
>> -- 
>> 2.47.1
>>
