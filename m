Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7193214F9FB;
	Mon, 20 Oct 2025 06:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760942135; cv=fail; b=LdYZ6BD7fexpWJg58zNYOrNJhpY5iD9BuxM5yO10qSzjr+y2dIT8lsC2iTm9Z9TyK1NV1qf7eLNeIKIVcqoN2xcSgAtLJmgLQ6a1vDwaDaBFJ2m71E6QC7sqh8jniMViTtu4sEnxdI9N7JI4Hwf3AS3xGg41ympzW6ncjfwBKLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760942135; c=relaxed/simple;
	bh=Ume9fd5x5U8QC8VCKK5b/nXNV3g8nkWuez8tOYzRNDo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jol9CObpf3jys4rZt1nB/SBo/sjoICZqdovlneQNGRDoNWtY2LbF89TKtQfHJaB8OtCkupVJ5bbCLsh6nqf9hyHkF/pw3hJh+cXqGPoKg2o+gkiiMp8c/RDvdORxNRuJ+ddhNc5hvrNyFCpy6XOb7b0RwhDhPpcqQpHUzN134pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FQoNxqvu; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FQoNxqvu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760942134; x=1792478134;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ume9fd5x5U8QC8VCKK5b/nXNV3g8nkWuez8tOYzRNDo=;
  b=FQoNxqvuK8+NnCfJ106xxYQA2Qlz1/nqDgeh3ObDYtaPjlYbg9Vf8eLB
   HyygIN7k5NqTpYYmJlsKEWU1V/S1c+H+d8nBm9FTj7KH4l2pGhL+bLTtG
   QoUM8b43z7MuGdcrUfE/MWuKS0FAKuvPmQQIJSFieWj5rWGRHYqUnNl6d
   9JUWdepEg6Llpp5hhb3yRRFdIFnR6uH9klgubWL0WYLPhqFaUYwFsh1EO
   iASqWs+wwn51ZtX4y8gG1ObhXgTWGiPiYX10XqXLQwra0rUTfJtg0NPDi
   /g9L5UwpjaYhBWBuGDZo12T8zLuOeuFIJjt4VXs4bVqcnJXJIbEGEBYI6
   A==;
X-CSE-ConnectionGUID: 8+DZNxeURCuJC3V1iYfsow==
X-CSE-MsgGUID: hWEwy5vDTTmenXecyxjGug==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="85676448"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="85676448"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 23:35:32 -0700
X-CSE-ConnectionGUID: MTsUFrmXTVik5OuOS15NCw==
X-CSE-MsgGUID: gwRrzgdRTuyW0RnFAxrPRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="187671499"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 23:35:31 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 19 Oct 2025 23:35:31 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 19 Oct 2025 23:35:31 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.47) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 19 Oct 2025 23:35:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0lIMCpbEMvVXGqtzLtDsXAgssDZt+Ibqd6eWUlllBQqC07OXcHH1etanmCOatpvKSgLstGM/fYrErRTAXGRyANsAUCs/dd96zVNqPM3ekgpO1g138QfQgn3tJTAVAeziWQ1Ku2HTJEnpryYuO8r3qlMQqSzJtkaKc9rnHYN0vSYIoFVKlEebJMm7aGj2kUvzUiPz1GaJxkyxT/Yx2RwbNs2CvDK/ouG/E6x5Wn2SYP+cUaZ/elOAY3gOI37e0GnBiwQ/B81phFg7+HAXkKnn7lEd24rhZ76xRb7/MGSLg7ozSxLmBAzozI7Ix4G3oRe3lqVHr/+Wx+rAYtt7rduBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Us0WZ5RySt24gCG/Yn1fqc2M5oZz4aCiEZ24g2FfPs=;
 b=NrZK+hX7NOlffad0S5XdyiJHpWM1vqB+SbzJr9syEwGXZE8aRWxzEhbf2SFcXNZfVMlJVKZeThFbotTNX5bJhdJtzifVVThfI8jqpLwcuTRPJfEcbZ0D6ylJm0xHAHh8E2KKZ0oZB+moITittHagjV4JWdyyXge/wF3Pc4zwXXNOYh9afuAa9KRe10AzELQ+jI4/CfAzW4jQpF+UiAYgZnZl4dbdrF/1wSr/8neJS5Pdg6vu6btmygJcRHlckbf1tBhpAzs0Mn2tXXDzZ7Kkbh9XlXLp0Qd4ByFU4Uw1/qsMu2wUXgm1t5/ung4QMQsp8+Yl1x+x01hn37TQ1m57vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB8289.namprd11.prod.outlook.com (2603:10b6:303:1e8::9)
 by PH0PR11MB5927.namprd11.prod.outlook.com (2603:10b6:510:14e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Mon, 20 Oct
 2025 06:35:28 +0000
Received: from MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022]) by MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022%6]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 06:35:28 +0000
Message-ID: <8c01886b-6359-40fe-9f44-daa63ad842e9@intel.com>
Date: Mon, 20 Oct 2025 14:35:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] perf tools annotate: fix a crash when annotate the
 same symbol with 's' and 'T'
To: Namhyung Kim <namhyung@kernel.org>
CC: James Clark <james.clark@linaro.org>, Peter Zijlstra
	<peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Kan
 Liang" <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
	<wangyang.guo@intel.com>, <pan.deng@intel.com>, <zhiguo.zhou@intel.com>,
	<jiebin.sun@intel.com>, <thomas.falcon@intel.com>, <dapeng1.mi@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <aPRbfdU92XRLR-2N@google.com>
 <20251020021434.29082-1-tianyou.li@intel.com> <aPW2QSJMhdegFrQH@google.com>
Content-Language: en-US
From: "Li, Tianyou" <tianyou.li@intel.com>
In-Reply-To: <aPW2QSJMhdegFrQH@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR0401CA0022.apcprd04.prod.outlook.com
 (2603:1096:820:e::9) To MW4PR11MB8289.namprd11.prod.outlook.com
 (2603:10b6:303:1e8::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB8289:EE_|PH0PR11MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: 48c07ab0-d823-425b-9574-08de0fa2dbc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWEydXB3UDJxVU5zd0tLM0RMQ1ZSdTJId0lCUHoyMzZNQURjVnpILzZEZXZC?=
 =?utf-8?B?cVhGS3ljZzBNQU1QYnh6MHJwU2FmYUZqd3lOSXZ4NmFBYUpORlpHK1JNWFR4?=
 =?utf-8?B?REpuU2l5WnZjclVvN3F2SlRraXRsWWcxVjkzWHpCVXlPRXNGdWJWS25mcmRJ?=
 =?utf-8?B?Zmc4TG9NTGhKcjMyMk9OTk83bWM3Wmt1MVJncjJCS0dhQ0I0OU5QTEFHYk0z?=
 =?utf-8?B?cUt1ajV4OHBlZjRuWU9SMFFmYzhsZWpjNDFZUTMrZ3NSWEJXQkFuMVhod2tu?=
 =?utf-8?B?VHpiWVJObTNKNTR2VVFuVGJia0QzWHFFYUlIaHMxM1pwSnNGV2k3Uk1MaFRm?=
 =?utf-8?B?UUtuUDljN1JVYVhoOEpRcVBnUC9BQVBBUlFTL21nbXdNZnBEcXpJbFZhS1lk?=
 =?utf-8?B?V0RocGJDMmFiMFN3MlVJNnJMU0tqVmNPQ2VBUGRZa01nVnZ3bXZwREpNTE9v?=
 =?utf-8?B?bUtsbDFoSGZuV05UNS81VG9hMCtvNFJwaVJnM3RVcy9nK1BpNjB2Z05NaHlE?=
 =?utf-8?B?V0ljZ2E3MkVnOXd5cmlhdHBwRDhYdWFuUUFSdEU5eWlsTjBSSUNsRzR2Y29M?=
 =?utf-8?B?RVpVNWVsWXV6KzRuMlhLVytpbUc5S2hYMjBHb0ZJN3J5N2tNTWllZEtiRG5X?=
 =?utf-8?B?V3lPTnQ4TTNHZnNIeUQyejdtUXBCWW96Z3lDY0JrcWVvcXBsUkFWUmNqWTFU?=
 =?utf-8?B?bGQ4Ym5iSUVJQTNBTVZmZ0hDT0hWMzBHQkYwTmFnQjBoVExTOHZjM2hJNzds?=
 =?utf-8?B?bVI2NUxESHhsKzRuSy9JSXJMYy85bm9kbVJRMndDbTFyKzV1RXJwd3BHa25U?=
 =?utf-8?B?RDduZUowZ0JXeWZmR0Q3aUR5d21Da1hmZDRGc0FZSWtOZGZPaDVmRSthbjM2?=
 =?utf-8?B?THEweWFOUzhxTEFMNnpLeVVkK0t1UWphNGJZYzZtSFZMYS9aS20wRzZvYmFJ?=
 =?utf-8?B?bDBRbXZDdlp5djJkM1Q3QUZGemdVMkUyaWhiOW1xQ3NObjIyOS83MW1mL3FD?=
 =?utf-8?B?RzhQak4wd0NabnBrNUZnNFZhNFgvSjVwaTdUcEIzUUlJUFFSTSsyd2I5bGpN?=
 =?utf-8?B?djJVQ3FSaGZmdFNwcVg4SHBKbldJL0RUKzlaKzVMZUZFZTdzNEpFekJTbWMx?=
 =?utf-8?B?VVQ4VTVrSHNiM29pWkMxeW1iam9FRmY1R0QzdUFnMmtTcEI0aVhIU003NFRn?=
 =?utf-8?B?ZHd4VUxlU05vampLbXFGbjN0WnNUUEhTaDlSczNtRGZHbW5TMkdsWnhnL1Ex?=
 =?utf-8?B?bDVPdk1QOEV3L3cvb2dYSEdmTzJMSGwzTHZUbFZLTUZsbDNtVXAwMUJwd3J0?=
 =?utf-8?B?MldZUVRxbk14ZElPdjNEenMxK0V2V0dZcWZ3MzBlbHFUSGJMU29CT0N1bHVn?=
 =?utf-8?B?NkdKNGp6NzMvL1c0RW5xYm8wTFI3ZUxLck5NYVl1SFlMODBmd2VNSFBpbWRB?=
 =?utf-8?B?M2dRbEZFS25sbHRZaFFMUFozSmlUT3JDU1FRcUVtVHVyYnNLNW55bWRzQ2p4?=
 =?utf-8?B?a01KVVhLRDA3RkxjdWVTbHlESHB3alVTd1J6YmF5VjZYbXEwMkErN3BsQVNR?=
 =?utf-8?B?T1BNLzNDbUNZVzd4UWlwYzZNaFhSck9zUjRqMmRXcTh3UHBrSy9VaXRwNmtC?=
 =?utf-8?B?M0JCWGw2QnRacXVzaEtlR01nOXdsVi9FeTlwQldCNFRkRXhEenpTczhCN1l2?=
 =?utf-8?B?T01FTnlBV2g3SlZBTHVoTkdSSTR3c1Q0MUYrNXN5dnF5Z0lhMVlHbnRuWFR5?=
 =?utf-8?B?NHBrdmNsQjRyamE4dndwcTdJeDR2ZG5kMEdsNGNmU0cwNG9NWG5mWmQ0bEps?=
 =?utf-8?B?UWhJa1h2TEpoNy9rRmd4aEV1RTMyVEp6U2FmZEVrcTVnclNRdVhtU01jODBW?=
 =?utf-8?B?bnpKVENoYUZyOU1Hc1l1VzJnSGZDNUZNb3N5dlVUT2lyQWZYVW15VnJFVEd2?=
 =?utf-8?Q?wMQUaDCc5cXhehhfN7Ici2DCkC2RBJAa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB8289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXBjbTU3L2ZXSzZsaGFnQkE0dlVzMVVxaTIzR2Z4dWkvM2kzU1pkMGR2bDNP?=
 =?utf-8?B?SU9xSktGdEZsMjZDS0FzbkVqUmoxWWFUTFRPSHEyTHFPdFFKbTVJb3oybHBQ?=
 =?utf-8?B?N2FjOVBqT1FyLzNpRzJlV0lGc3YrZnlpbzh1b0NkVkhEMEJkMzNVYUZUcjdQ?=
 =?utf-8?B?OHhGU0s2dlk0c1BKYlpKZ2JIUVlDa2JXVGNwSXBwdWV6NlNPRU1EazNSeGZk?=
 =?utf-8?B?R2k1N3FYMStnSlIzNGI0dUpudVJOZEJLT2h3YWNrazFSU3U0cmwxY3ZVOWxh?=
 =?utf-8?B?anVHRzZEUHNMRjR5OUZ5eEFpVTAzdUJNRXpkc1pBNEx1Q002OGozL1VydFND?=
 =?utf-8?B?NXQ5K2llS3FEeW5CYm9qRWlKR05rZkpNZHVKNlZsTkdXdmFjUnJBdUQrOUdI?=
 =?utf-8?B?cmlMWWlNNndTOVZxU0luc0tpb1ZUTVJzbys4b3pzZW9XazZYT2xyUUwrUFZX?=
 =?utf-8?B?cGE1S0hVbnRwQkE5d0dzR0tqcmFGUXlsK2k5Z004NDQxSGx4eGdwV2JJTHcy?=
 =?utf-8?B?clNKWWdOT0JQUVIyaHBWditwM013bEpXQy9hWnpVbXRKYlEyRXRuN0ZVc1Zj?=
 =?utf-8?B?b0FKSlJjbHVhZ3VGYkNEQ28zM3pia0d2NVA1YlM3ZU9jMFJNNEJTK2d3ZnRw?=
 =?utf-8?B?eW5PeHl6cmx2eFViQU5sOGozSm1iWXROakdPek5GWGhaNC9LZmczUlJDcmdC?=
 =?utf-8?B?bUlMQjNjVCtiNWlTMnhya081MnVjY2ZHUFJJYjRYSmNUYktjbUhwVEZFeUhj?=
 =?utf-8?B?S2tEdXhkUGlFTzB4YnNOVkJ3cFFwVVVGdUU0dElpTUJINkx0NTZQL2p1Q0NI?=
 =?utf-8?B?b0F0T2FZVExOZFpzSVVUK01GRTJYeGxZNEFWc2htaFNhMUVGcmtIVGk0Y3Ja?=
 =?utf-8?B?QVBvbzI5YWFkUktxeHE4dndLNlo1dk1SVnBwNWoySlJEQXF5UmswckoxS0dT?=
 =?utf-8?B?SGpSd2YxcFl4Ym9LMFVwRjJqVnA1Z00zWUVRSDNaRGFQc2xJdjROR0IvaEZK?=
 =?utf-8?B?ekg5NkliUzRMODdiZVVvY3k2UGg4YlZKT3NRNVdXZXFqRkpSaXF5RG1Ianpm?=
 =?utf-8?B?VzVtRVpETnBRaHRuc1pkNlE2ejhaaUdhOFhJdnN3SDJNdnUrQlZadlVjK3NX?=
 =?utf-8?B?L3FZWmp5T0JEQjdZNTh3b3ZjQlBaRGtmK2c5OTA3NloyZ3NZRXh6cmhPVGgv?=
 =?utf-8?B?MjRuOFJ5bjUyY25MZzJnMFNPbUhucUpkQVJzMmJYZlF5TjF5eThmNjg4czYw?=
 =?utf-8?B?aVBLUWhjRURaK3EvRHhOcDhISTh5MDNBNzVNYTRTZ3ZqRmF3dEN5ZnBCS1FB?=
 =?utf-8?B?cVVFVjJ1UzRlVXFWSkpWSkxyRWdnRmprdG5VZ3ZST2sycHhhK1dLS1VndjZx?=
 =?utf-8?B?bVdMc0hzRXhVLzR6cEkvRDZXa2QwM1ZiZ0R6YW4xbHFWMi9LSEJZSEdXVmQ3?=
 =?utf-8?B?T3hETzk4bEZsR3lSclBkcHp1bElhUkJ4TUlUTkpIK0pLczRlWk55ZVNTS3Rt?=
 =?utf-8?B?ZFNPRkErY2hwVkUvSzZPT0JNYnR4Unp1N0ROVVFBVTJtMzJ2alMwVXhnSFJk?=
 =?utf-8?B?YWQzaVBZRmF0UktvNTdnK0QxZHFaTmxRRXVER0NHbGxkMmxuSURWbjgyVUdm?=
 =?utf-8?B?RVZMYzJPZFp3SVM3MW9idjRxajgvakRtY2kvVG1GcHJWTzREZnhjdU9rYTdx?=
 =?utf-8?B?aFRPVjlBU2hOaVJoT3Y0VzIwRkNGU2VRbmkwVndzZVEvT3Z5a2ljTkpOd0JY?=
 =?utf-8?B?OE56cmVNdTRmZ2F0cWFlRllBSnU4ZWtLd25jNExNcWxXS0FDd2Rzek1ON2ht?=
 =?utf-8?B?OWxYeUNhT2NtZGFMNHJYK1J3MGFrNnlWbjQvK0c3NXFtZzBxL3lFZXMyMWEy?=
 =?utf-8?B?NURLWGZEL2hKTWtrMk1mYStBMmR1NG1ZbCt1QTdhc0hCSmI4TS9GdWFEMm1z?=
 =?utf-8?B?TzI2ZGZ1eWJ0Qi9hL1RKcWxXV1JXVnZrN2Y0RnAwTEh3MjJKczZyOTFFMFBD?=
 =?utf-8?B?TXc5eDB5ajAwQm9Yem9RSGd4U2RYZjFEQ2ZRUTFUUVhDbUhVVU5TSVJDV2I0?=
 =?utf-8?B?WEtKR09BYm1uWVAyUHN0K0E1TzhSTFBLS3BkeDJwdW5QVkU0dEl5ZDdOSno1?=
 =?utf-8?Q?raL8MAXHs/3aHnJkclipNj2bx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c07ab0-d823-425b-9574-08de0fa2dbc6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB8289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 06:35:28.2812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VagANrVHUmEyUGLpIoWUbYgnVu4G1KI9QjBhdKvkP3wUkGiwjiFeeu4fUX7ibTpgBGx/V5bewGo9JJUhYVvREA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5927
X-OriginatorOrg: intel.com

Hi Namhyung,


On 10/20/2025 12:10 PM, Namhyung Kim wrote:
> On Mon, Oct 20, 2025 at 10:14:33AM +0800, Tianyou Li wrote:
>> When perf report with annotation for a symbol, press 's' and 'T', then exit
>> the annotate browser. Once annotate the same symbol, the annotate browser
>> will crash.
>>
>> The browser.arch was required to be correctly updated when data type
>> feature was enabled by 'T'. Usually it was initialized by symbol__annotate2
>> function. If a symbol has already been correctly annotated at the first
>> time, it should not call the symbol__annotate2 function again, thus the
>> browser.arch will not get initialized. Then at the second time to show the
>> annotate browser, the data type needs to be displayed but the browser.arch
>> is empty.
>>
>> Stack trace as below:
>>
>> Perf: Segmentation fault
>> -------- backtrace --------
>>      #0 0x55d365 in ui__signal_backtrace setup.c:0
>>      #1 0x7f5ff1a3e930 in __restore_rt libc.so.6[3e930]
>>      #2 0x570f08 in arch__is perf[570f08]
>>      #3 0x562186 in annotate_get_insn_location perf[562186]
>>      #4 0x562626 in __hist_entry__get_data_type annotate.c:0
>>      #5 0x56476d in annotation_line__write perf[56476d]
>>      #6 0x54e2db in annotate_browser__write annotate.c:0
>>      #7 0x54d061 in ui_browser__list_head_refresh perf[54d061]
>>      #8 0x54dc9e in annotate_browser__refresh annotate.c:0
>>      #9 0x54c03d in __ui_browser__refresh browser.c:0
>>      #10 0x54ccf8 in ui_browser__run perf[54ccf8]
>>      #11 0x54eb92 in __hist_entry__tui_annotate perf[54eb92]
>>      #12 0x552293 in do_annotate hists.c:0
>>      #13 0x55941c in evsel__hists_browse hists.c:0
>>      #14 0x55b00f in evlist__tui_browse_hists perf[55b00f]
>>      #15 0x42ff02 in cmd_report perf[42ff02]
>>      #16 0x494008 in run_builtin perf.c:0
>>      #17 0x494305 in handle_internal_command perf.c:0
>>      #18 0x410547 in main perf[410547]
>>      #19 0x7f5ff1a295d0 in __libc_start_call_main libc.so.6[295d0]
>>      #20 0x7f5ff1a29680 in __libc_start_main@@GLIBC_2.34 libc.so.6[29680]
>>      #21 0x410b75 in _start perf[410b75]
>>
>> Fixes: 1d4374afd000 ("perf annotate: Add 'T' hot key to toggle data type display")
>> Reviewed-by: James Clark <james.clark@linaro.org>
>> Signed-off-by: Tianyou Li <tianyou.li@intel.com>
> As we have the annotation support, can you please rebase on to the
> current perf-tools-next?
>
> Thanks,
> Namhyung


Sure, will do in patch v4. Will send the patch v4 soon. Thanks.


>> ---
>>   tools/perf/ui/browsers/annotate.c | 23 +++++++++++++++++++----
>>   tools/perf/util/annotate.c        |  2 +-
>>   tools/perf/util/annotate.h        |  2 ++
>>   3 files changed, 22 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
>> index 8fe699f98542..ac85df1020a1 100644
>> --- a/tools/perf/ui/browsers/annotate.c
>> +++ b/tools/perf/ui/browsers/annotate.c
>> @@ -852,6 +852,18 @@ static void annotate_browser__debuginfo_warning(struct annotate_browser *browser
>>   	}
>>   }
>>   
>> +static void annotate_browser__symbol_annotate_error(struct annotate_browser *browser, int err)
>> +{
>> +	struct map_symbol *ms = browser->b.priv;
>> +	struct symbol *sym = ms->sym;
>> +	struct dso *dso = map__dso(ms->map);
>> +	char msg[BUFSIZ];
>> +
>> +	dso__set_annotate_warned(dso);
>> +	symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
>> +	ui__error("Couldn't annotate %s:\n%s", sym->name, msg);
>> +}
>> +
>>   static int annotate_browser__run(struct annotate_browser *browser,
>>   				 struct evsel *evsel,
>>   				 struct hist_browser_timer *hbt)
>> @@ -1149,10 +1161,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>>   	if (not_annotated || !sym->annotate2) {
>>   		err = symbol__annotate2(ms, evsel, &browser.arch);
>>   		if (err) {
>> -			char msg[BUFSIZ];
>> -			dso__set_annotate_warned(dso);
>> -			symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
>> -			ui__error("Couldn't annotate %s:\n%s", sym->name, msg);
>> +			annotate_browser__symbol_annotate_error(&browser, err);
>>   			return -1;
>>   		}
>>   
>> @@ -1161,6 +1170,12 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>>   			if (!annotation__has_source(notes))
>>   				ui__warning("Annotation has no source code.");
>>   		}
>> +	} else {
>> +		err = evsel__get_arch(evsel, &browser.arch);
>> +		if (err) {
>> +			annotate_browser__symbol_annotate_error(&browser, err);
>> +			return -1;
>> +		}
>>   	}
>>   
>>   	/* Copy necessary information when it's called from perf top */
>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>> index a2e34f149a07..39d6594850f1 100644
>> --- a/tools/perf/util/annotate.c
>> +++ b/tools/perf/util/annotate.c
>> @@ -980,7 +980,7 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel)
>>   	annotation__calc_percent(notes, evsel, symbol__size(sym));
>>   }
>>   
>> -static int evsel__get_arch(struct evsel *evsel, struct arch **parch)
>> +int evsel__get_arch(struct evsel *evsel, struct arch **parch)
>>   {
>>   	struct perf_env *env = evsel__env(evsel);
>>   	const char *arch_name = perf_env__arch(env);
>> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
>> index eaf6c8aa7f47..d4990bff29a7 100644
>> --- a/tools/perf/util/annotate.h
>> +++ b/tools/perf/util/annotate.h
>> @@ -585,4 +585,6 @@ void debuginfo_cache__delete(void);
>>   int annotation_br_cntr_entry(char **str, int br_cntr_nr, u64 *br_cntr,
>>   			     int num_aggr, struct evsel *evsel);
>>   int annotation_br_cntr_abbr_list(char **str, struct evsel *evsel, bool header);
>> +
>> +int evsel__get_arch(struct evsel *evsel, struct arch **parch);
>>   #endif	/* __PERF_ANNOTATE_H */
>> -- 
>> 2.47.1
>>
