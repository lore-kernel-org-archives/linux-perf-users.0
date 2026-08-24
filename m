Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92FF379C5E
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 05:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787549211; cv=fail; b=cUQUJ3OwJWyt20BsfA6BEKcmvSGzaLRNshxIkBoXvCc+W/u8iCYekVa5Z0KpOS65ZDnyp9mMUEZ0KHxJlt+Lb4kvdyjpLhk2Y/ob+JSZLJNlui3s4hjsv9M3+WliHinUy8IBVpq67iUVSN3siSdWzm3eqPYwNGstaUTQvB40dsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787549211; c=relaxed/simple;
	bh=EMKpgVr4c2ws1B6fk0JwGG23nqul+6oyHhIALhAqZx4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ISKyyPDGlgSu/Rjuil0ibzfO8neW/RuSdosW/SaS5513c7g4SxNSojpnrgAPjUibl0jlf8FhgYT4dYSNGeWDxBk6mwxU5WFqjEEdDhBXk5IBwVxsR6IEgrqTSCQGUi1QIStwqPTPURKeooRYGLZyzURyIhG92xetPrT0F6ew3tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i17iwOAr; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i17iwOAr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787549207; x=1819085207;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EMKpgVr4c2ws1B6fk0JwGG23nqul+6oyHhIALhAqZx4=;
  b=i17iwOAr25CzuaB8qT2jam7OCEk/W9/4+tAHpDBZia8ezhNUtuwecfdI
   qFQ3vaXeJ1n9NAqxxiA/Py/ZkBCEZ4s4TUw/IjIeTxQgnXnI55DzbZS9o
   168BEVnTALIq8dcFEVx5zeGArkHR0FQ4Q8S5aYALVdvLm+5UsRrjcZVSf
   o//rcXcUZszjv5TCtdhzFIiWgU1chgCwoiMi0g6OjgkpT3amc7oKPLVAm
   BJ0l1leVF3i8jSIuupTd7I8E7SwDCVjuFdqzW5otBdNVE2mA4a1CMTNxL
   OBB2bOserx5hb0vvbhKVe5nl8HROzvsR0rDGs9Lq0uHlbwD/TRh375JuI
   w==;
X-CSE-ConnectionGUID: uqObB58RTDyOCSC+Y2KRgQ==
X-CSE-MsgGUID: gHylFhiMTCGwA6f7pywajw==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="88190946"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="88190946"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 22:26:47 -0700
X-CSE-ConnectionGUID: 9qdzP9mWRE2wrwTzw2ss+Q==
X-CSE-MsgGUID: 1CtbwcjTRNWr7rB6gqmMIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="265597826"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 22:26:48 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 23 Aug 2026 22:26:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 23 Aug 2026 22:26:47 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.45) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 23 Aug 2026 22:26:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyp2O9eQkZUeuU1PyFNCvWvrxovWELSd0YyVvq68jExJAODOLPWTE6RdLGO/QLFSxl9f1SdqhEwpTYV+3jOlyALBplvIJt+CEhLyl3HsCD4fg4mluHcvpXPfi1D55xJfAcqioZTnNBriq1G7GtY7B/1zXd8Q7zVd1UAjxquP4eSVZO0Uu5brnJ88PbbL7WMPCytt6vChZcxpX40PMxEqtVLNGwtXdlLHI7Ucy2D7NodbXd3OnMUhVs6IztqXjbmX10YEWPE7BrekJNMRECB8lqk6EOkcf3LDEMkTE63qEBzDjBvhgQiQi0w+l4k7kVCldM8por434Kh4S7knvongZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZTq1d5P1g91aLAejw+yQxETePflefR9NuGK+O6p5UQ=;
 b=gn869oLpWkAACyJuq+QErtXe0jiTUH7swI07BZ04knOj8M9cxGRhSYVN/IXLX6JS/my+w3RfaGH7jBt43CuPPpoHChgyNwpZFteZpSOpj+xKHSTpwj7VMOvHT5qy2eD5BRcPH+8ZG5PyO7uqvyZqt4VXgbQewo6GqVMVxW4yrH7k678vwH0qISfK0NbyPBtZedgB2DcrCNVBA763C0NPcsGRs+AB9KU5UUkcqrhPH9ewfP1Gzzt9ug71v3r2Oh8vQMYEuLi++dpmGSTSmulw2A5U5/6U2Cc4gL46kSMmSgqYGqexUXW4n0kwTAn2xT6i1HngD8xJqvyt4vph1cRsiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by CH3PR11MB8443.namprd11.prod.outlook.com (2603:10b6:610:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 05:26:42 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 05:26:42 +0000
Message-ID: <3a317e20-da30-484f-a3e0-a2e12ba5bcf0@intel.com>
Date: Mon, 24 Aug 2026 08:26:37 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: perf script intel_pt decoding reading instructions from wrong
 shared lib
To: Namhyung Kim <namhyung@kernel.org>
CC: Todd Lipcon <tlipcon@google.com>, Stephane Eranian <eranian@google.com>,
	"Mi, Dapeng1" <dapeng1.mi@intel.com>, Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	<linux-perf-users@vger.kernel.org>
References: <CAGH6UiG=RJLqBU3kLu9XJciPyPO1HZkbAPERguVUMRuWQgqf=A@mail.gmail.com>
 <c45fea55-b03d-40ac-a89f-8882b057fe5b@intel.com>
 <ajw8r2Y2shs6sBJW@google.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <ajw8r2Y2shs6sBJW@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0081.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::6) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|CH3PR11MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: 57f76a00-0e1f-4cfc-c282-08df01a047bf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|3023799007|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: nVU5JtgGPczFq7IdVJCUJgbXhlwJaztXrRmRON7ATEsOHy4cDoB48VtIcMdWxmmKJsbJRjiT70FwVuQwIMQvL57TWM0tY53AGw7ScRbdexpX7ss+akXBdNdHcsWY88GjT1ojP1ugpeeN+hX0x4nM9kQgS/3z8PXmh0wGsJuDCJ6lf6kNreK8HBcNnsZiWfaHHGxvZNNA1lkJhDt0e26vn89VNdtIZSXYPLHiH6KMwGidKmBFinRQS9G4Kaohez/RARtyjX+RvFHHHaIIbBWWUX5DxEDokh7+sV1dTlc659htZUV61KElpxehDdrfDbCgi5ITj9J9eet4XKtzwxHWlSaI8gAYaPfzV09QkF6Ad5o1wCCHBXQpBSbfrIFc5WhD+oltKZdrqNj4S3y6FV7P/U1Ml55mlA6QxXcca0YevQIqCmr6jpAlqaAXLaplL6WXK98UgGuyPmemnQ8kH5rUa/BwbDn2l4mOaAuz4ExhM6EMAcQ/lrf7d7VSkcfdKmI1JcJm1KdcvZModqPAUfCtoIxq7pw43FnI2rf/ruCFww1+36Gn5/VjMyDmxbTfInoEfDlXCt5/5eZ9FMklapW9XOh9Zcq2kO8YhJIT4n/FW+pNTLqy6ieO9d4nVxaLeCb7V3Df+wWKlg9DGqLWqpJFdVZgS7PZWa3Gl8sXg9nPw6I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGY0bFBJMW9rT21rSENzajc2ZkRrU2VHQnNnNWd4aC8vWlZRdWZYTnVqazBL?=
 =?utf-8?B?TDlKek8rQzN4YW5VZWhSVnU4STc4OXU4U3prcmhiRkdvY1g3THhBbldvOHdB?=
 =?utf-8?B?VVFpOVdXN09iaGlpMUttUWh0Vis3WmhzUGp3YWlvajg3b2daVmx1V243WXpw?=
 =?utf-8?B?WWJ0K2Z5SGZCZDNJU3puMFJBZGFSaEpYZTFpcFpQSDBzYTZFNHFEQmUxYmJr?=
 =?utf-8?B?Ni92WXpBT2ZJbDZXK0VPYnFMemJ0VkV2NDUySzM1Nktzc3RFelNSZ2xJTkFQ?=
 =?utf-8?B?Qkp6OGNOOG5uNU05VjBWY1VyL2xJYm5lam81QVc2V1pGN0VIM2hmdGcwUGt3?=
 =?utf-8?B?Zk5FcG9nZDBORkRGbCsrQVNwTXBFblpRR1Q0N3gwY3A3K0VHZFBXZ3AyS0Rw?=
 =?utf-8?B?NDRnWGJONjlxeS9zZ1YzN01NeFBVa0tPbjFEUUMyQ1hzdklNQW1FbW9ib0JP?=
 =?utf-8?B?ZWc1emIraTd1MGRZd1hiTGhlTzY0U084bDYzdlhhQjAwem1rRWZSeUJDOGxM?=
 =?utf-8?B?T1BjRG56bE1OOURKVENVSU41VzJTQjl5SEltQXFoZ052cFoxQVExODEzZlFp?=
 =?utf-8?B?Z2NjVUxsQ29Manl5ZWc4ZDRBQklTcFFLbXN3NTA2ZS94Und2ZmZOaXZEZm5z?=
 =?utf-8?B?bStmbS9kK3FKelM0bUE0cFRzZklZTk1VVXNUejhpMnBRZFJMNWhIWUVVMWtm?=
 =?utf-8?B?ZW9qbmZmdWV0KzVCV1lOTCtSb2h0eGNHMzIrZ3V1S2VmaHIyWUV5dTJoYnNm?=
 =?utf-8?B?N2tLZzQ1b2h2ZXlSdUNveTd3QW5lYUJWUVhUR0dra2Rqa1R6S05nNmlpandu?=
 =?utf-8?B?aGdWVkFKZ0ZTK0V2eW56b2ZqYURPMEVJY0ZiMlhFSnFsMThaZ3QvM01sdW1E?=
 =?utf-8?B?RHN5MzdOdWlIMG9vc3RtTFNqVWtvRGpta0dBUDNVVzFGeG1XRk5ZODIyVmFR?=
 =?utf-8?B?ZTQwc0NBZ3BMZEE3Tm1zZnZvdGZycDIrcTJvYWVkWEZkazJBRWJPVGpsaUNl?=
 =?utf-8?B?R1JhUXBIRnQyZk9YZnAvNVNoRVE5ZTdVeForYklwYTVzZnY2T1JpcmlWeXJy?=
 =?utf-8?B?aHc5cXVmWEJya0k1ZDArZEM4S2xQYlg3QlFsMXBtSUtXV09meWM3VlBOWUUz?=
 =?utf-8?B?bkNwdVE3RFJUMVg2Ry94d2RWUHBUaTI5YVpsTFhQVmpHV0tBdWwzeGVLdExu?=
 =?utf-8?B?MUJta0tpU1I4Y3ljT05USGU0RkxUYVJiOTBNa0oxYk05TzF6MmdxdDhzUGdS?=
 =?utf-8?B?RVdrZXhaeHlQSDk1ZEhIVTd1OGJQVzd2eGdmbk5OeUxsMGRNM2FNbFFRa1o1?=
 =?utf-8?B?ZVV1NVVmeVZmQTNJc1NMNVE1M2xEYTN2UnFJV3Q1UjVIelpJaWxtUjhLMWhq?=
 =?utf-8?B?QWFsdTdndFRUb1g5aTdKNUdid1hDUG5qTGhyT2R0M1lWeFQzUDRSVHdKMFlp?=
 =?utf-8?B?a1UrL0p4Z1dkUDVSN2ZkQmZzY0Eyd0pSRy9kRWRiREpoeUZYcTZubVVrRkxq?=
 =?utf-8?B?OFBaNEJHd0svb0FYNVJidGZ4S0xqVm5yMVQrd2xpVUFrMjBSTVlpdm9KUDhl?=
 =?utf-8?B?Rlc1RGFEL2RVc2dRTndJck1va2xyeHFMbHUyVTFvWmVFeWdoVkNuUlRGZE15?=
 =?utf-8?B?eUFSbVdQS29hWG52bjNJVzB4Sy9TTkpXZGpvUlRwM1laRXNSckFOTVllb2t2?=
 =?utf-8?B?cE5tMTFXY3JJMExIUXAzblVmaGFua29hV1dvTzlhNjk5aXh2SCtvZnhHeW1N?=
 =?utf-8?B?RU00QnJ2T21maVRJNzR2bzFYLzVwRXdBOVN4c1lYRC9yVlZZaGJmREVBT3gz?=
 =?utf-8?B?T1QzVGc2bzdWaE12MjFXOFIrd0wzdHIxREJLdW9xOVZJMDVCTEV4cnhBSklE?=
 =?utf-8?B?dnJxR3EwZG94YmZCbkRlSzAxdGRub3lpeU5YMU0yQTZHaEc1d3FLcmFscWpl?=
 =?utf-8?B?SXJYYlk2NEMrY1l6bWVkT1dGRUczb3FMZHIrVGkwT1BPR3ZHS0N5K0ZiZWJj?=
 =?utf-8?B?VWpmbFMyQk9BcG5Ib2lCeUJBUGJJU2hDUjlHMlZVKytTWVZMM010UkgrQU1Y?=
 =?utf-8?B?dEMwUzNETmQzK0VtR3NKWCt2SmpYOW9WYm5ON0h5R3dnWnJkWkZZUmNtanpM?=
 =?utf-8?B?Y0krbmV5aDJKRVUzdit1aGcrOGVsTE1KR0NyMlM5TDMrQW5jS1J0UFJCNXZn?=
 =?utf-8?B?cnQ2STJzQXpqMnlBdEx1QnN2RHlnMTV5dFB3T21BZDJUTFNtSEswbXRvNHRl?=
 =?utf-8?B?YzRwZlZMVndYb00vVmNhb01UeWxyR1RCVm1sNE1ibDV4c2JrbnBtNnhNYlRQ?=
 =?utf-8?B?Y1dYWm1lZzZiUFpoMUhSZlJweE5HdU85dGhSV3BFcUlIcWtzRWJ2ZFhTRkZa?=
 =?utf-8?Q?XvBtC25zsx5zVQug=3D?=
X-Exchange-RoutingPolicyChecked: kijP/CQZDBFTYxUczNh/oRLnhYB6u7RdedM3GlCz1g2ABaWlLmyd8CzbMiOLO8HXzfSlkIK3KQ2C4jkQbZVOiQHe2ypAP5s0MCWA6tYr7TmSzlcTwKKQvMEuSq35DcvKm5cQ/fi+disvY49/vXmJOqRzvkwIdOLoCKvrJ6pZLF/2Bni1izqEuJ428NE11hmzHeuP9jvxwbE575srajpJZc5VebQiIo7vQCcb5VjmoNfNk+wMoYOZX6grrNUvTbmMDzRnPMvAOBjmcIvhP0pxK0x0H5nAUZvJv8P9WeFB/1a4KLnpH6/zbe1aQNbqvFaP0bK6Z1g/A0YKNh23oNuJNA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f76a00-0e1f-4cfc-c282-08df01a047bf
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 05:26:42.2378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WsCiYFeUmOeuQ/aHqUZpR4fYnR00FWoHmJMknrQ2/YOpddxfidXqS72jvkxXTUUSE8GXA7v5TsBACPsiDDG3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8443
X-OriginatorOrg: intel.com

On 24/06/2026 23:23, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Jun 02, 2026 at 10:32:02PM +0300, Adrian Hunter wrote:
>> On 15/04/2025 00:59, Todd Lipcon wrote:
>>> Hi folks,
>>>
>>> It seems there may be a bug in perf-script when processing intel_pt.
>>> Specifically, in order to reconstruct the instructions, it maps
>>> instruction pointers back to DSO-relative addresses, and then reads
>>> from the associated ELF files to find the actual instructions that
>>> were traced.
>>>
>>> In the case that the ELF file has an associated separate-debug ELF
>>> file linked via `.gnu-debuglink` (common in some Linux distros), it
>>> appears to be reading the debuginfo file instead of the shared library
>>> that actually contains the code.
>>>
>>> I've posted a simple repro here:
>>> https://github.com/toddlipcon/perf-debuglink-bug/blob/main/repro.sh
>>>
>>> I haven't dug into the code yet enough to see where it's going wrong,
>>> but figured I would report to the users list first.
>>
>> Seems to be caused by commit 5363c306787c8 - see further below.
>> Reverting that makes the issue go away.
> 
> Sorry for the trouble.
> 
>>
>> With that commit, dso__load() sets the binary_type to the first symbol
>> source file type, which is DSO_BINARY_TYPE__DEBUGLINK in this case.
>> That causes dso__get_filename() to get the file name of the debug file,
>> not the file actually executed.
>>
>> Leaving the binary_type as DSO_BINARY_TYPE__NOT_FOUND will result in
>> try_to_open_dso() using either DSO_BINARY_TYPE__BUILD_ID_CACHE or
>> DSO_BINARY_TYPE__SYSTEM_PATH_DSO.
> 
> Ok, I feel like we should split the dso access for the binary file (for
> annotate or intel-pt) and debug symbols (symbol table or DWARF).
> Probably we can use the binary_type and symtab_type respectively.
> 
> I'll take a look.

Would it make sense to apply the workaround in the meantime?

> 
> Thanks,
> Namhyung
> 
>>
>> A quick workaround hack:
>>
>> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
>> index dd30f17cb1ca..09fd79ca1d48 100644
>> --- a/tools/perf/util/symbol.c
>> +++ b/tools/perf/util/symbol.c
>> @@ -1825,7 +1825,10 @@ int dso__load(struct dso *dso, struct map *map)
>>  		if (next_slot) {
>>  			ss_pos++;
>>  
>> -			if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND)
>> +			if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND ||
>> +			    symtab_type == DSO_BINARY_TYPE__BUILD_ID_CACHE ||
>> +			    (symtab_type == DSO_BINARY_TYPE__SYSTEM_PATH_DSO &&
>> +			     dso__binary_type(dso) != DSO_BINARY_TYPE__BUILD_ID_CACHE))
>>  				dso__set_binary_type(dso, symtab_type);
>>  
>>  			if (syms_ss && runtime_ss)

