Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2713348642C;
	Thu, 24 Sep 2026 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254857; cv=fail; b=tbRWJfUu0tRoBUHwq6yHcvLQAE0S1LUq9tmGycoaPkmSMHIUhT+6i7/6B2T4DnFdJsPomGjRZs8TFlxTogqmYPTVVANnH0GTkfhFxmOUH8E8foKCN2vitmf0IZJbe1GEquym8N2lCvGuRPqcEfFfj5JEMA+gTiSt4d1I7Ws68L0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254857; c=relaxed/simple;
	bh=BPvdwAZkAaDvRHl/+/Ja9QCU+FTNJIQ3vMZMQTS7FCM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IKoYhD9F/rT5NbYF4mBg3CW4qEVDvu76htsdrdPddAvgMo3L+DbbQ2xhmmncenpaVbAS1Htt7i+f5QpW+132OVyzD48MI6U9B3o6cVLRm05i5YFWpF0Vv/2TkTRsxfZ4WtefUc0Rbsg1dXUEGTsAPpxQnv7DSyA39+eN2VGihus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mv3q1jTI; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mv3q1jTI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790254856; x=1821790856;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BPvdwAZkAaDvRHl/+/Ja9QCU+FTNJIQ3vMZMQTS7FCM=;
  b=mv3q1jTI5cUkWzNaV/WMzXTr/Jle4C9Q4N5/Ho7dqoTglOrjdbC1U4eH
   7vK1AX2V9AAlckvT7LseCHaRJrQsZS1JLZK5qpHqfHBvETJwoDh7eUK/S
   yA5yLN30UrjM2dpv1cyV7SCpKh7A4ssfx8TBqQur0qVmxVKVE+GeEHMIz
   A/WnEEaJLvCe434jtt4lBGbkxjjndXgZq4TW8oxnOsoTgfF0KoQRp54aE
   a/0CQTwy+bqOZQVlHrWMLKbDOVH1OCDaQzExPeKF+tRQD+0W4dNvjVCiB
   nBNiKGoEqJdxhjq4SiDkJ8EEZQHoyM8hm+YzxVsW9ivtcG3jW3O3Agu/v
   A==;
X-CSE-ConnectionGUID: JsUQHKO8TIO54oLvJxc0Xg==
X-CSE-MsgGUID: uGhdBKTuTuW19d2jt2dh1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90888206"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="90888206"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 06:00:55 -0700
X-CSE-ConnectionGUID: 8wO/CSotQTunqswMeJZ7jg==
X-CSE-MsgGUID: Lmdbip9MQiWIAu5xmaitvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="274223710"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 06:00:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 06:00:54 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 06:00:54 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.27) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 06:00:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iH7RMZK8ZJyx3LLlyEupuuCGyGOylQFh8uUSHXhL9NVepVYa8aoAcdbrfSQmbputeylIThErb2TzR1DPjIT7Inkuha8SMTy0U0sluCgL1E5Gah7Zcv6BN5UJM18w5WBkjS5EZGjlpMxGcEtpZXaHw7A5JHyDwoZo7cYNQ1oYBC/rzvzs+JnrVe23dzFtzFmVejLzq9e+c/xF4CJfiv5VeSZh+KdLExc0iqTreiWDYhhnOXIcIqDEMffKHTtmTYzwByJ2/utm8+Z97TsKlPAnaLXk/bEB2G/2g3W5gwnraSONEL9PNpU4ZKRqMnOw3a5IH5HH5zXPH93ZzCsgrqeyaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKETBD/cclMd7k1jBS+dkatAvt5KNaJL6N/B5pztgJI=;
 b=odV+sW2CwO4qX8njL+hDdpKPwMEUCRaw4a8FuRA26Ceho9OV1OcaxwcxliknnOmEm7/W+GfgmC+P3xh1aiSiNucd/qRRHHAlOlI4u3m67njLtjIlpIYR70Bte6ac/UtSmfb9sLz4N8oh4BtK32a52cDkXebFH/Of94lxC2titkW+nQgWv74dDz9pVTyOCLZNsOEQs5nWyRTQA/Tg3EzWyUUt/PWaTFGv0co6VhNoRYKEIxzfNrihSbblgRmdIOIQdbpVwy5fN69gp7ZGT2Azg644+n+9VhVkmoQj77Lyl5JQszve62EeErSDRVu1ZQqEMheTFpLpUVqFqPE3VV0d1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by CH8PR11MB407363.namprd11.prod.outlook.com (2603:10b6:610:32d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 13:00:52 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 13:00:52 +0000
Message-ID: <109758bf-56d5-4d10-a16e-f4888bb20d60@intel.com>
Date: Thu, 24 Sep 2026 16:00:49 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] perf intel-pt: Preserve return addresses for
 asynchronous branches
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers
	<irogers@google.com>, James Clark <james.clark@linaro.org>, Mike Leach
	<mike.leach@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Suyash Mahar
	<smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
CC: Arnaldo Carvalho de Melo <acme@redhat.com>, <coresight@lists.linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
 <20260923-perf_cs_etm_fix_non_taken-v2-2-6ab8c07a5455@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260923-perf_cs_etm_fix_non_taken-v2-2-6ab8c07a5455@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0011.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::19) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|CH8PR11MB407363:EE_
X-MS-Office365-Filtering-Correlation-Id: 359e2ef0-154a-4204-5666-08df1a3bdcc0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|10067099003|56012099006|6133799003|3023799007|18002099003|22082099003|4143699003|11063799006|921020;
X-Microsoft-Antispam-Message-Info: ySFvIYDeRW5oIy6oRdA3YzZfP+55fedOvAm/82iGpoQddkwxoxMP1hT9eGlYGBgo+QdbcGAIWjbXfxFHlwkGCL5UewAWCBUF3b0dE94GNaSoyYWaaSRfmygxI1/deD/9xFJSUYBv10FCg0MuxL01axe1xnw0SVcT8x6HCB0ZsEPxDV8XQbp0lgAjkBibAMCFElhXJs3RBbEstILtsiygDdFVaKPqCvXHC6X7fiNXeL4DU1QkbkQTqYm6yAFJx8iVfEEQ6NtvxkPMKOEqgtHwiq7hlOFLkyJRX8S2urv3p29Naq+rmmJDRlOy1hZ6HSuRuKHCw+pum2IN/8JGVLgkIDLZB2GNdgk2VsMHG/jSNGIKQozeX3dRvBaoxLcJIzd6lpBDCxTXQzxNttlQ2PmwBEtGFUPTWl1+nsAhGwND6FzblafRcuS9m2o+ynqwCW2OH0QTxUyJ5O0upbWE5CaLWyic0JGTHsqccI5hWaZSOkN6DYYAeTIwfmfRlrI5Fl09oLd31CP4akVJtK/6ESYsXuO52RSDuodMbHMaI3uWv/Db3uJ+QVlXkUOGwD2/BwrTtSxuCcsRHl1H2drXJOceUMFHDovxi1dOzKVPmk9Gd+bcyEzECrHns0nnjzfHHC18c1E4lNVGKexIJW+3Gryyr4nTWZp5l2CFtgnt9HQtV8+DM+SICVEZq86MkANplIH0hr5VT0GoENip7NTBZ06HWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(10067099003)(56012099006)(6133799003)(3023799007)(18002099003)(22082099003)(4143699003)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFVIeVovN2l6NFkzSzhQRGl5UE80ZXYra29Od0pPOU1mbEJlK3pxL1phYWF6?=
 =?utf-8?B?TFY1WEZpY09CLytKZUpoY1R4WXpEd0ZNTko0eEhRbWN6RWFWTzY1aXVKQWtr?=
 =?utf-8?B?ejNvNFY3R3d5eStPbXlHZFA4MUVKS2Y3dDhpVzZoQk9ubS9wNWZqWTFQYXZU?=
 =?utf-8?B?MEhpeE5CM0xqSmlzaVpIdmVlY1hmbVhlbDlFY2xkUTlvSVdVeGR2bmd2ZzVV?=
 =?utf-8?B?TU5NM1ZmQXE3L3A0STVvNStwMXFzQTJmOFhzK2VOQWxDSkdYUW9yalp6TXAr?=
 =?utf-8?B?c1dtQUQxRmt2bVRNQkNkMHRTTlQyTjRYeElPZEs0bnZTSm5WdVlmQTk3NitG?=
 =?utf-8?B?MW9DR0pkU0xuWWtUaS9hbEMxMjhPM3p6dmxqR25hYlIvRGlWMW15ZWxCbDBv?=
 =?utf-8?B?QXFxQVNhUldjaTdnYmJBMW5sKytOaHRtTXpCTDNkUXJTeXdMMStKSGxSamxi?=
 =?utf-8?B?MGxNQSsxd2FCRkhsSy9lREtrcHZicXhoNEFjVXkrYlpEUjhRWE4wR01aWDF3?=
 =?utf-8?B?WmRSUkhCUGo0KzFZOWhTbUkwMnk0bmEyaVRwL1NGVmdOUFppaThkSGlkUFh6?=
 =?utf-8?B?WHl6cmFJeEF0WkVLVWlkQ25ianF1MmNKMk5wMG9aZEV4TENQdEJ3UkpHcnQ2?=
 =?utf-8?B?d3FmTmladXg5TEU1QitsVXZLUG1nVW9SKzRKNC91NGw2QU85N0tzenFRQnZS?=
 =?utf-8?B?RGVweDVYOWNrMkdZaEZzeEQyclBobGxmQ0RubVQyVGt4MUpxNjF4Z0R1aWJT?=
 =?utf-8?B?RzhyNDRVT0FKNlJCV3FUREVucG8xZnkwYnBvbjBRMFNkK01rNmNxWmV4MDlS?=
 =?utf-8?B?cnNuWjRxWm5VUXVkKy9CVXc0RlNUVDgyVWlkemo4ZzZSMURmYWtSeE9Ea0o4?=
 =?utf-8?B?TE40ejU5TVI0NVZGVHIyWWdzeW45ZXdDbnExK1laK3MzeDduTW1OVjYxR2I0?=
 =?utf-8?B?TWNXOFptWWdFdkIvVVdKWCsramhsTllVYXdRSEVBWGFLNUh6QkNKR1NCU2VF?=
 =?utf-8?B?QzFsWVBSR0ZERXg1anhzVUpQMVFVZVJ2SXN6enEzMm9TWGlxUHlUSWZmaWw3?=
 =?utf-8?B?U21kK1h6NHFNT0k1eG51MnFSQjJXMDRjclBORWljUTdHako2Q3R5bDF2Qmxy?=
 =?utf-8?B?S25rMTI3Zm51dHIrSk5jWld4V2NhZm5ScEF4bEpFQzJ2VUR4Y1liaWFBalN2?=
 =?utf-8?B?R0xIR1FnaHlTU213UW9VckpFY2VTRzhCMklMM3FoWDZoZmJrTkJ6YXYxVEla?=
 =?utf-8?B?c0J1RU5pbmdFcXRVV1U0T2RlQ0lWTjFnT0JKcDBWMnJqQjBSQ1l2QzVtNkxs?=
 =?utf-8?B?Y0RYY2N5ZEkyOVZaZGh1Nk96S0VWcjJ5UXorYXZURHg3cjZGWEtheXVINEZz?=
 =?utf-8?B?VHh6Vk9EUlpQYkFpVGdOak4yalJwOC9WR2wxTjYxSGVhQlltNE5ETkxmNzhj?=
 =?utf-8?B?ZXErQ3N1UnhFYTVBZlZtY1QzQnBrRUlMZE1iZnRXS3p0UHNmejJwbE9VUkZt?=
 =?utf-8?B?MUlsbC94YUdZbWswNFVuR0ppeC9FY2E2d2xNTnVydVZpOStpNzNyeDBxeW9Y?=
 =?utf-8?B?SnFxeWl0TmE4TVhPTDJpbjdHQzBmMXE2K1NqMHgxdm1DakJaU2JUckN4UEdw?=
 =?utf-8?B?U2tKWTdQZk1LRVZ5bENLVklmK04vR0JpUlpYUWFDdkxpWkRuQ05UcDU0L2Y4?=
 =?utf-8?B?OXVYMjd1elF4RUZlSnpCejFFelRycWhBcDJ3WHg0czRlQU9nVms1L1RUWVJw?=
 =?utf-8?B?OWxid3RXb3h2VTg2OTN3WDVWelRndG9xa2Y1cDJ1dHBmeCsyb3g0bUtuUFd2?=
 =?utf-8?B?TCtJMFhlTUhOenRzM3c0UkQvQmxXRkVpVy9WRnA5NEFZZW84aUtUUWs4dDlG?=
 =?utf-8?B?Y21pOUhWSFcwOVYxRGdrY3RYRUZxbFkyL1VHdXhYd3B2alZRdjh5bFI3K2Qv?=
 =?utf-8?B?blBRUE1TUHY2YWJBL0dmVmxrNURtZlNMem85VklyV0t0SjFzWWpxaFlOMUo5?=
 =?utf-8?B?QmQwaEpoRzE2Y3FTb1RlWHQ4djV0TDNUUUNhQW5wUXhTUDJqbUNYS28ydTdT?=
 =?utf-8?B?Z3c5UFczcjZqbENlclF4VWt5ZS82S3AwdXYxU0l3RXA2aEdCYmo2VG4vb3BB?=
 =?utf-8?B?c01SYzV2cmtEdk9tZzJ6NzB3UFlSN1pubFRYQkJDZVdtckV6TWcxQ3FLL0dm?=
 =?utf-8?B?SHI3Zmd3UE5PK1FhejBLYzI1ZTVJM3pkdTVVa1pXWkVIaVZDbTZXOUE4YzZm?=
 =?utf-8?B?WGdWMkc0T2RUQ0ZxZmR6djhyblFvQnEvczloZTZvL1lkaU9VVHFRYUhBOUdX?=
 =?utf-8?B?RFE1SmEzNTFERndhczN4ZW5jdzQwcXB2VjlydnQ1R2c5eS9KN3Y4YXh5QmJO?=
 =?utf-8?Q?J9iiii4JRmr2PQUo=3D?=
X-Exchange-RoutingPolicyChecked: iC4bi/LP+Zc9+2UKysHZvL6urxqIobj33IW5WEImLc4CwmaFBvevE2KhtJ5qC+KgWOOwUKzIHZcsQlBmlab78JNmu+75cj+Ls9httyOjmMqpKaOUI6bglKiLQG2dwGEoWPQjLL7K/IgM+/nAoQytpjunkc35QTITrnFt/xhTAJAoTLqsYu1njU+3gqOcoFxkhubklDDS085XQ0IjzSK9z8E4TAirAYOUClI4NR0efw0U7rluk66AvARLe+2sDVdo+OEhPM9/wN9t7nduDk5GzzH6pcb0Du9wLBUuRSypboo0nuOIgDs334wg7IFbS53pu9+bKndD+Hb69AT4lLAQmg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 359e2ef0-154a-4204-5666-08df1a3bdcc0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 13:00:52.0554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qYs3LlXhiDql1yKyuIXbqcJ8I0l0AyGfCcY/4c18bVDafYnYwwv9g23QcHPFSqjjhxfZ3W5Uy9QeSutih/l6qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB407363
X-OriginatorOrg: intel.com

On 23/09/2026 18:21, Leo Yan wrote:
> Intel PT uses a zero instruction length for asynchronous branches so
> the thread stack resumes at the source IP. A dlfilter can fetch the
> instruction before call/return processing and replace that zero with
> its opcode length, advancing the saved return address.
> 
> Set sample.ret_addr to sample.ip for asynchronous branch samples so
> instruction fetching cannot change the return address. This also
> covers asynchronous trace-end samples and VM exits.
> 
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/util/intel-pt.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index 8c21c9f52d572d2dd4e15b3b5c341b253ccea1b5..e8b9c8a67b0a0635e0110eda4b6ccb2511132fc7 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -1803,6 +1803,13 @@ static int intel_pt_synth_branch_sample(struct intel_pt_queue *ptq)
>  	perf_sample__init(&sample, /*all=*/true);
>  	intel_pt_prep_b_sample(pt, ptq, event, &sample);
>  
> +	/*
> +	 * For asynchronous branches, use the sample IP as the return address
> +	 * instead of advancing it during instruction decoding.
> +	 */
> +	if (sample.flags & PERF_IP_FLAG_ASYNC)
> +		sample.ret_addr = sample.ip;
> +
>  	sample.id = ptq->pt->branches_id;
>  	sample.stream_id = ptq->pt->branches_id;
>  
> 

