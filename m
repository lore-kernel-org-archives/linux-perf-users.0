Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC5329AF;
	Tue, 30 Jul 2024 01:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722304083; cv=fail; b=syHelYRLGE8JnQyFQkHZA9uRZ0k1FSnXeRtdKptIMeXch131/1kl7JKBkSMyvlMtiFsNAuWXR3anjDnIqpM0VGGZaJJQkmL9SrvQasTPFMjOIcNIY4HHOkqvRkPkMHzFZ2r6tLGZSNdWmVt5Y79707reLi0O+BJuWJ7RPG+AFek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722304083; c=relaxed/simple;
	bh=poFrbAJ7lhYgrQEGZpiY30CINmYUY57MB+1mTpMcrLc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ql72gzkJ92Mrrqg4RELUTCoHlUBREca2eoG1x5zpmb/AgSpPCrnhmaq5G3gvOalheKz9TArpViYV8SamvXYA3Z1Frg+8kNbApyg8COX1/gC4MyqVPlG2W3Ks7f5YWiUUttmoukzBpI3qfSG1hTlOuR/eU98U3EgN09CaocavVfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ecmHP72y; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ecmHP72y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722304081; x=1753840081;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=poFrbAJ7lhYgrQEGZpiY30CINmYUY57MB+1mTpMcrLc=;
  b=ecmHP72y5W4cguHdV692QV4UnNSPJJ+zKSqU6RZ70M6Mo+VRVdLf+3gC
   w3/pGPkgm1vhgR/Uj9xaKE5GvEfybmTUX2IXsY7n23LqQbVnHDXkJnPz6
   S6MjTw8ycCy7/yr4FxBcbZCfDMuX974x79wxQ/XzDbLzp3O9j1YMpYmV+
   vm20cMNvbGgrBSImsxDkHZH9E/1xna2wDiORtvpEjMBZPJDm/aBbGU1ZP
   6zW0GVh9XS5LemUgiKQAnJs8ztU74uIiNAzWo0RBDCNvXohkuKULg2jIv
   EveBMUKq/xYzMMrBMKY+DD6GVblkeiDbijLuTKicSVRMiqgQ6HTGPLpxe
   g==;
X-CSE-ConnectionGUID: sZH77nn/RkWYEj1F1Z0bDw==
X-CSE-MsgGUID: ilCn6wfpR8i5TxrAQ0k5aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="30725414"
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="30725414"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 18:47:51 -0700
X-CSE-ConnectionGUID: BAFtuvdYRlqrzQ/0ipHerg==
X-CSE-MsgGUID: 8aG6MHkSSFC1UA7wn4d8Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="58779456"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jul 2024 18:47:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 29 Jul 2024 18:47:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 29 Jul 2024 18:47:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 18:47:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bO/gojGyAZNQVL+SjX2ETFWHdXB4S2YoGnTzIJ/JccxteJnMrlSErmeYz++qIPmXxtXObgaKZ64afIWA27W0Ag2JU8Cm96g6cGD5ui8SQuIRIln1f1rP5dWS3b0D+v/rzYVOXFE6uDSfMZJcSSiWR9MVZUKZpUtGZhw9af0YWOWcCXk3sINLw7BE6sD1jLOSiDrP0t3CXVLKKEBLjcL/3ElxjUJNEW2iTp3iETmDcmqepIxcUjB+0oc9jtqj50/PW6DmkVhlYgDLyxRiv5TBOmiXw0MNdVuOdyqibDqC77uPuy0vZAFr1c9AVBtiSFfF3XOoPDq+PXkz0CVUSnsbdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AuPOuWtSp4oDwxUkTPajPJs3VnoeqC1nCAI2911Q/k=;
 b=f4UHyq5yRXcdpBVjbxT5PoNGniqYz/tkdtGCfRXseicUaXh8Cm9x/+Sd7yiDSv0qijMViLUCS7XCJtMQeX9hWmxbUxWdB8kxobb/OIdRjm5R7H787NmaL3ihnhTcF4kt12vxKSt5eyV+fUQsiO1bBMaklj5tut0rzMMZMJf7xtq/JZaETnM3/QC182Bl5ecTr1iZ21IxXm1NEF1z67a5oyrnqsL0X5Txr3m6Pkk/uTO5kJ47uLM9h+hO9ZrIOHcvMXh7R6ScRxUMnX0v+QKbDKZCZYgU0TmRmTwXFY7WaBLFze4xHaA6CQU/P/xRWEarwHf59X6lr0/uNeN38APvGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 01:47:47 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 01:47:47 +0000
Date: Tue, 30 Jul 2024 09:47:34 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Ian Rogers <irogers@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Weilin
 Wang" <weilin.wang@intel.com>, Peter Zijlstra <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Kan Liang
	<kan.liang@linux.intel.com>, Jing Zhang <renyu.zj@linux.alibaba.com>, "John
 Garry" <john.g.garry@oracle.com>, Sandipan Das <sandipan.das@amd.com>,
	<philip.li@intel.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v2 2/2] perf jevents: Autogenerate empty-pmu-events.c
Message-ID: <ZqhGNm+WDcsNx05e@xsang-OptiPlex-9020>
References: <20240525013021.436430-2-irogers@google.com>
 <202405311548.1e881dea-oliver.sang@intel.com>
 <CAP-5=fX7ZyT82=W8uSZbT7c76E5+1JaoR5-y_gcj7A_=Js1YfA@mail.gmail.com>
 <Zl3Q7AtOWY8ZCcg8@xsang-OptiPlex-9020>
 <CAP-5=fU=UPpZTULuyZm=Ep0Ri6SdTciL5kqpciUfnWyDvz6HZg@mail.gmail.com>
 <CAP-5=fV5Qdu5iH_DKeAXQfEmQN9SmxCViSgbOCvAmN529WoeOw@mail.gmail.com>
 <ZmphzTKiDDYkPPP+@xsang-OptiPlex-9020>
 <CAP-5=fUUnnL18x_mdQdaCePOSbk5VWP3jfAS44n7qahD7pja5Q@mail.gmail.com>
 <ZpXdUiNhFbqJvkZK@xsang-OptiPlex-9020>
 <CAP-5=fWS6F09aNgz9FVRrAK5ZRvSJ=8o4UAkTfsHdZVaoMi_-Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWS6F09aNgz9FVRrAK5ZRvSJ=8o4UAkTfsHdZVaoMi_-Q@mail.gmail.com>
X-ClientProxiedBy: SG2P153CA0042.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::11)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN0PR11MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: 42358b55-46c1-454f-47b2-08dcb0399d3c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWxZc2VMaFdabWRVRnJSa0dWUW8rZldmaVd5NDI5d2tPSUg5TXRmajluT1BQ?=
 =?utf-8?B?Y1JJK0U4eW1Ob2VCdVNSeFFuV3dXdjNRSXZETG8wTjVYOVJGNlRnNFVrd1Fa?=
 =?utf-8?B?L29xYWo2d29hbGhIUG1nRUYzbXNJTXdLdzNRVGs4aG5RM29XaDBBa0d5S0NE?=
 =?utf-8?B?WUxNN0JlaTk4dmVXL0ZQQU1iY3BIQnpKOWNPUGV0TlFsKy91Q2c0NWhySXhN?=
 =?utf-8?B?Z25OREY1RElBcHI0b2J2SzEwOFlZREEvTDBmSWV6TWdaY2RBczNrQzZpTU5D?=
 =?utf-8?B?YTNFOG5ObUk1cGlSY0dpY0ZCZmRxV3V2eEdIeVlTcFZCYmFpK1FQMkhFb1E0?=
 =?utf-8?B?WnpWSmwwL1hCK0ZEZ2tLMHZiRm93eFFoNlRPLzNUbkNKMnlJNWRVcmVkWldj?=
 =?utf-8?B?S2M4SElmVExvWUV4QU9ZakZyU1JTYWNNbE5hL3pqbndRY1dZVXBHYUlDNXlF?=
 =?utf-8?B?b0g2SXhUbkFRclpDcnFtOE4rTS9yV2lCMk1RVEVmbkQvRHIwL0ZYcnNTWHh4?=
 =?utf-8?B?bUdxNWdJYkhtTDljN0pVNjNPR01CazJ3emJmMU9WVlpoZVRzUGFjNENiT0hH?=
 =?utf-8?B?aVZVa1VJMUdxN1pMeFJ5VmxXa2FEQXVLOHRzRVUyZndMWjFhYlFyZGNPMDVB?=
 =?utf-8?B?d05kZngzTVFXTU5TQmhxQk43Y1FqOCtSL240TVVQSFVUaGVJaHBFcUI3cG9X?=
 =?utf-8?B?Nmszd3NyRkVRVmNVL0F2WUZENnZQUEZIUVdacmVDMmFWR0prU2JFbS9keTBW?=
 =?utf-8?B?K2pWb21RMit4ZXhFdjlEazNEdVhVU0xJKzVQamprbWEzbzFQZitscDNaQ1cx?=
 =?utf-8?B?Ym9RbWdWYUNydTcrTS9PWnF4K2oxWUJzY3A1bUhGaVpmTjRuZzVRSVFmNUJN?=
 =?utf-8?B?RlFPUVMxajV4c2pxRzJZUzlaeGZ1TFJPWGR2QkkzdmgwblVObTFEc1dsVldG?=
 =?utf-8?B?cHJ2ZEEwRTRBekpmWFY0eFVTZmgyRFByK3EycTVpQmJHSWdkZ1VnQkgrYTZY?=
 =?utf-8?B?L1JnQS9QaUhPUDg4YkYwcjZ5SnNNQmtzM1pnTFB6VXNvV1FqMGNsbzJGaGZY?=
 =?utf-8?B?cFZOWFV2YlNXNE5LclZWMkVZUjl0YU1nK0pnSGNwVUVyelgvL3JHeUlsLy81?=
 =?utf-8?B?aG5WZkZOdXdNMG5HaEJvRlJrcENYSGlJeDFRLzhLVmRrNU9CYkpabmtOVHJC?=
 =?utf-8?B?NWJoSDhrT2lNcFdTZlZUTG83dStCd1R5c2huelh0T3I5YkpBb0ZaRHZLWjFy?=
 =?utf-8?B?blR6ZUNmRXBYaHJRS21DU2l2eTBhOHJiZ1B5U3JudkNLWHF3eWI3M1lLaGlE?=
 =?utf-8?B?QUFpcUJlMzB2cml0TkNjcUlzNnV2RkkzRXU5UllGUnNLVW5SUlZsTVJTdWRH?=
 =?utf-8?B?VGpoNTBlRlZqamkvZnpvdGlab3J2UVNMYlVEaDNDSlFmQVRjQ1pMdG1jTm84?=
 =?utf-8?B?eksrVGx1UHk4ZWVNTjVmZXRzZk5jaVZSU2lqelo3c2NYbEllYTlQZjdnWEhT?=
 =?utf-8?B?My9nRjJodzVMeWlDMmovN2tPbFV1VThlL0ZmTnVxMldOL0ZzaW8yZ2VNZWR5?=
 =?utf-8?B?Rk1YYWlKRm9jenk3bG1pNXdFUVdMK1F0M09vQmdvRkt1OEc0UnZzNWRsQ0JJ?=
 =?utf-8?B?K0xYdUNDUjRvVDFRemloRy9DR1RzS2g1SDVNZlFXTEFyMlc5dXVIaGVHYTB0?=
 =?utf-8?B?OVljTHdsRFkxU1Qva21QMTBJd3M5OGhicFAydmxlc0VjZmQyelVQRGVGRU94?=
 =?utf-8?B?SGY1bGRGQVp4SkEycnNmVUtTTkE3bXNWS2I5V2htV3FhWjNhTDJLN1RHUmla?=
 =?utf-8?B?QUkxYU9JczNOakQyU1dkZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NktUQXd1OTh5U0laVnU2RFJnUU5LVkszRkZKRWc2SDY5STV5K0xEV1RyUEJ2?=
 =?utf-8?B?eitVNitWcGJTTUFGUTd5bzUzbUV0blU0SlVPOVB4WXdyYnNURm5TTzQ3bzlE?=
 =?utf-8?B?NEdpRWFFUUV6U3NTSmtVOXZkTU8rRE1MVXVDT0hpdDMvQlA2eWg4clJNU3NI?=
 =?utf-8?B?LzVZanYya0g3Mm9MWjFCRWwwaUQzRUpuUjlUYW4yZFBkNnlWOGd6M1RneW02?=
 =?utf-8?B?ajlMTWlNWDYwMGFxSEpLOU5Hek1UdHNUT2ZLWmZCdExNcGk4SW5pQ2pBamZW?=
 =?utf-8?B?TFZvL1RCeXJucyswNEtKRW9TR2pKVnlYRnNOUTJ6YTdIcW5BUHlvUk1ldmVu?=
 =?utf-8?B?SEJIalVkZUxnNlZUdHJvWWNTc0V3Vk1SK1hySDUvTWdFY3RNSkExd3ZTeXZ3?=
 =?utf-8?B?Y2tSa2JOY2tqZmlzQVF6QXplc0hQRFp5eTdrQ0F5MTVPbm9aeUQ5Yzh4c3ox?=
 =?utf-8?B?WWlETFdYN1kzenBZaHdqem85QXlXcCs0NGh3OG5VNDhmaUlQZk1uRHI5UzVQ?=
 =?utf-8?B?aEFmYnU5UGRMUE9abCsrbUZlWlliWGZ1NFZlR0wrUWM5RFNqYTErNmo1UGh6?=
 =?utf-8?B?amJMakdsZUdzb3hSaXU4V25OL0xValdTSUtucGxuSHpTclBlUWlwQU9uUng3?=
 =?utf-8?B?RjFJSUhtY3p6ZlBzTCtQWXVSaEEwNXd1V2kzM2JGamxyWkRLaGEvMDhyNTE5?=
 =?utf-8?B?MjUxSGR1OUJMc1pNYTNCeUordEx0bldLL0E0RnpmR0lsb2IzcGt1Mzg5d0Zs?=
 =?utf-8?B?bzBOMTlQbWZocmhhWEs4VlpLY21NT05pZDVEeXNoV2dhNE5OVmxheTNQVUx0?=
 =?utf-8?B?bTdEb2FHakFicVhGc0FUTEpyaWE0ME1MbWZlL24yMGhCcTVEcmE5Y2JIbCtr?=
 =?utf-8?B?aVBFL3g2eHFPR2VEWUNpZ0VvSlJhUWVXSEduek5LcnhYakNKbmRFUGh1TWVR?=
 =?utf-8?B?QjJ1bnp1V1JaSVRrYUpmS2xUemhvR0tlZFREY2dGUXlpU25uRng0bUxPOTRq?=
 =?utf-8?B?TnhwbElyWVd2dlMzSUlxK1RaUlpvUWs2NjY3V2Y5djBGNnFmM0dBSnJCcVFn?=
 =?utf-8?B?MTRmRE9Ybm1IMDd4V3ZVK1E3eWd4Q2dPaHJPR1pLVDIvZmpVSng5QjUwc2xJ?=
 =?utf-8?B?YitBK3ZuMFpHbXFqakRqVXd2RUpTUFN6cTRZYkFjVEJFNnFMajlFZFA0a25h?=
 =?utf-8?B?TDZrZnI0U29vUVJKVEhXSUhSeGxEb0VsSnN6M2RSNU9BWndVTUpXRWNSVDdx?=
 =?utf-8?B?U2xNYXJYWDYyaWVNVDNXdVhmYlo2YzRaSnFkUlhBMDJjQ1JzS0RFaWVhcnh2?=
 =?utf-8?B?WTVmRTRqSE9tb2tKeDRDK1NZa2ZQOHprWGVodTZYQ1lsMFBydytETGtydXdk?=
 =?utf-8?B?dEROUHJDT3Y4UHkxWFRsTVVxRUpsM1FQQVpjc1JPbUdYRGlRVjJ4Zm80dVcz?=
 =?utf-8?B?V0ZrWnBsQkVmNmNqYWpvbERIcmppdHR4ZC9jUGhZMGRyOC8wMDJQNG5sVGJJ?=
 =?utf-8?B?M2RBMm54cXQyUEpTME5TZkFzMVYwY2kzRFZCcXZqNm9TdEoxTnVUMEwwQlJ3?=
 =?utf-8?B?R2F4b0NJMHF0NGJKOTAxaUpWTHd2bEpQN2FHcGZQMy9VVVcyU1kvU2JVVVpB?=
 =?utf-8?B?ZS9WU2hmcHZPMmlkZ1dwaTRla2l1VkdydTBwNjM1NmRJRUhZeEZ5ZkRHUG1t?=
 =?utf-8?B?enJZbDVZN0JDT2VzV3VyKzBxR0I3OXFsdm1UbTJRN1VReDYxSTNsbm9KS2Ra?=
 =?utf-8?B?blhSOGtKVG5yYm5Gd0gvWHNUaXljK0JLd0E4cmoyVEdGVDNVLzJDa2xUTjRu?=
 =?utf-8?B?STg3NGQ2dytXMDJhbnRZU0ZqZVJtTGJnZGFaU21tN0UrWWdXNUpSeHhwMUVu?=
 =?utf-8?B?bW9raklSc1p2UnNCWXRMYzIvWkJiVE1Uc205c2dYMlgxRzZoUTRmcE1QLzI0?=
 =?utf-8?B?cS9VazVKNDR0UmpHNFowclhxOTFxWGV3d3FrUTVkWWZCdVphVXZwdjBuVFoz?=
 =?utf-8?B?TU5qcC9SK091ZytXMlczWHFFSGUxdUR2UW9IYmlFVm9oSkFlR2VoWVlCNVlu?=
 =?utf-8?B?cGJ6dm1RWkc5UTVzTlFsVWJUUlhTUzlkRWR2blhHcWVpK2hrK09Fa1k3STBK?=
 =?utf-8?B?OTl2ZTR5U3pHakpKWEtjWG9hWldtUlRobjZYMXFPVWR5WU83QUcwRzJ2UzRY?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42358b55-46c1-454f-47b2-08dcb0399d3c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 01:47:47.8380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFagWaJdh9UyFOMtYE3vlA3LqzyfqBK7epLQR/mUk6If5jmD5U7qbjkNwFQnlwj2hYpfjcEArhQlFnNK6OqzLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5987
X-OriginatorOrg: intel.com

hi, Ian,

On Mon, Jul 29, 2024 at 12:18:34PM -0700, Ian Rogers wrote:
> On Mon, Jul 15, 2024 at 7:39 PM Oliver Sang <oliver.sang@intel.com> wrote:
> >
> > hi, Ian,
> >
> > thanks a lot for detail analysis! we will check further.
> 
> Hi Oliver,
> 
> I'd like to see these patches land, is there any follow up? I think
> the build breakage was patches applied incorrectly so I don't think
> there is any reason not to take the series.

yes, our code issue while applying patch. sorry about a wrong report due to it,
and thanks again you helped a lot figure this out for us!


> 
> Thanks,
> Ian
