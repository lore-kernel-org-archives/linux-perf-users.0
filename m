Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22A9449B10;
	Tue, 11 Aug 2026 14:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786459103; cv=fail; b=JmHd9bEVPpfh2eZ5yympg22arxlQ/NQE7yeiw+WyFSLDj62/KymW5sujtTNDxThF3iIgqrUP0j+l6Tl3hcjSS4lsswn1jP/4kaqSHArivjvLqR/IooWtRd4H1Yj0iVTMtEyzMz2y5GYuPL552Qj3fScvmQ6TJZg4Ym52ujRsFvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786459103; c=relaxed/simple;
	bh=WKSJf06XCEYYamcyDHMGpqOCbSRfyizRTf1F56u7jac=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=InImy8bu+FJfqoyMdr3aye1XDMLXK5il1QeIXQiEDRxIs3Ea3j5cGiH5K7OELkAakF3mxIBqTg/X38YQ5XTiNzval8/iA+nC1DerxKd387CH9UHec9/d4Cv/gebWir3/MCnRVcTv5siCoRNkYHWpld1xJn966hgidfSZ0GWJu/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HTiLVEvm; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HTiLVEvm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786459097; x=1817995097;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WKSJf06XCEYYamcyDHMGpqOCbSRfyizRTf1F56u7jac=;
  b=HTiLVEvmVM7zq/rGeJNy3vP1itNmH0XLCv/jUC6eyBdP6KL9iIv06rVy
   tXwH/tlvsTZVO6bTUrQtY8ZeT7O37WuYhsjwzd2JkpkA3X98ArypiYF7t
   YRiGiDkii8eg23Kcb0cCNG3vAPc06nu1ZRw3P51G0fcToTTRSfEvPpTiB
   qCi7uWe253YNCtiRiEzofxoCjlWwXIOuoVudeqc0X8EHv0I3Eu93tBvmd
   MogEAKKwsCDERVUO1z5gkT/XdwevT4yMh//SQjB9Hu3jn7xUgTIWwb1se
   6CFHpIF207SoIRM9CFowELzTlL8Mc0T9NzCN+1DHVm5HTwW/8XwtI23KD
   g==;
X-CSE-ConnectionGUID: 0YhDhLOVQOqPMPwnX9lZCA==
X-CSE-MsgGUID: 1LmkiaYnSWiU4PO8WhMtzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="104521847"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="104521847"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 07:38:10 -0700
X-CSE-ConnectionGUID: A4GvaBH7RO2gZMt0NNKmnA==
X-CSE-MsgGUID: ZMV92Ja3RJaHnhq2iHfaQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="260740605"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 07:38:11 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 07:38:11 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 07:38:11 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.16) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 07:38:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ieWKA7kV0nNO2D7YsgWCIAmhSD7qdxrir7QDPywXHuUnIHXwhUYITiyBFH2JRNmFr2LWto+2tPMrXBE8C46asFbH1fKvkOCpm9WmrWE1e/55sN2lXDdujt4I1T4gd7UHriqgzyPrD/fsUBXWOBJGcIJ313A79iSSq7P0zc9n0dmdhdcoY7cB+LOf5Kh4n70IhfrH6ZBOC3KjNYC1pDGgEjMnCnCMzH3d/mUeo709lO7X/QQVuZ5gMz+fyw2NAv8weF/WB4CT3Mtr+SNx3zh7POu0BcMIWH7uPIRs+qR66IREbb/H4nLh7tfZ8aNEKxjMsUQ63B5ZhcSQwIKwR+aywQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSA0/caNv1hQV/O9tlwKSHJ31i7vLr7dcEOwfnUXmW8=;
 b=l7aiZw/zinPzVsARe9TPXyab+l0xtqyI96z1NYyUFA3Z0LGHGyKl+jcwI9YBotY9+T/41+4RQdyCjrZtqRybDLtzjPYfSpKLtIa+eaYJSMRAFRzZkkAj/phekinN01KWDxyPWmjRtA/nfQHszfNu8+Sw1wau+16dmMK9kU60bBn2wlosm8E4gHX0SAj/3eYpq+HOafef8mZhUdTAdsGe++UdjsQ+hENZ0AHt0TiNR8aB9ZPOPpB5x4IC+YzZZStbXcM0JMsoPYKRY8+U4wHdydlWHFtMZjvQcqbeh+aNjgodyVX2XEp49vXlYga7kunNfPDkjV+FGKQqIzUdfiVWjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DSWPR11MB9953.namprd11.prod.outlook.com (2603:10b6:8:39e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 14:38:09 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 14:38:07 +0000
Message-ID: <bae0311d-25d5-4678-bfb5-505e3aa144a9@intel.com>
Date: Tue, 11 Aug 2026 17:38:00 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] perf header: Tolerate inconsistent HEADER_GROUP_DESC
To: Amir Ayupov <aaupov@fb.com>, <linux-perf-users@vger.kernel.org>,
	<coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>, "Suzuki
 K Poulose" <suzuki.poulose@arm.com>, James Clark <james.clark@linaro.org>,
	"Leo Yan" <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	"Alexander Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Ian Rogers <irogers@google.com>, John Garry
	<john.g.garry@oracle.com>, "Will Deacon" <will@kernel.org>
CC: <linux-doc@vger.kernel.org>, Mike Leach <mike.leach@arm.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>
References: <20260803090640.2412336-1-aaupov@fb.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260803090640.2412336-1-aaupov@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7PR01CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::7) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DSWPR11MB9953:EE_
X-MS-Office365-Filtering-Correlation-Id: e6e8ea88-0a80-4dfb-81d3-08def7b628e8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|18002099003|22082099003|921020|3023799007|6133799003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: inT2wCE2X9H1ZUOLVRJBbwXluj0J8WE4LkL0+K4WuNM165wFrCBcwXpuqXS/z9bJFUVMryVnMKoenW/hwg0ukV6ritEbfzvlLj8QD3hyzgxkhsSczMsUN8TEcz6Z4Xqv5ocUTia4YD+VrUana7gKkF9zGK1SD/WF84DMJ9PyF7NYp+AtdH9SAaVGH1ZMQJJiibGRyVyuWt7y3HJ7vGyRwBUEfT+A6yfN8rnMoScCifVTwYa1H0h8WECtOcr2XUC6JR/Jx+MklFg5+x4KBHx3AmiHbuw7C6nKYD436KEzpJ+3TkK89FmcAAhxPba1vQDFBS3ovzUCXDac/ra4uHiiVWURlIbY4v1XyC6hJSZI3Tj/0D9hW5ZuqT/oU2+bXUfwmWTrxgl86QgYuWWrTwwXt6tJP4COMNJYDXHc+hedix3CGVLaVU1xcBUkeycw38DJcqr101dklYpTI++e+A/AKXRLyo04+nvgob3M5LuOqU6nNmDngxIMtiHvI3UmR1KSJnvod0YXJXLVo67Aj5t62fC8Omqyg/m+dVvAjNU3EyIDxSr5NZNRY8GAx7ZyJC0sg9zLiEcf4a6Jazd573y8fQ43sGyhhRKlHDwX5yhazOc4oBRyh9i059TZq13V7ynxpu/uRQT61PQuUL/n0DTgM35kK84pb5pdrxOaozjKFxmMlUaEAmO9oEVjrHT/HRnPK+63xq9PPxazhke4tWbE8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(921020)(3023799007)(6133799003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFB6R3FvWFlKbUF0T05rcDBHcEc2Yi8wNVVuZ1VYaTJNSGhvMVhrV3J4TkNG?=
 =?utf-8?B?NEk4WENuZ0RFSlBrMldYVTlDMzNIQ0RNRzgrK1pqV3UwQ25zbFFscUVkZUVH?=
 =?utf-8?B?UkUwN2tGZVVhTmE3cUhHZ0tNakJ4WDd4ZWUzU1JORTZXZ0tKaEt2YzM0ZVE0?=
 =?utf-8?B?Si9PT3Zlajl5ZWcwQWYybVoyVGhHMjJVSlJTUXFMdnc1U3lQVXM5a2U1djFw?=
 =?utf-8?B?UHhLUDVHWmJId2ZBMWNER3lzZCtzZjlJdDIrQXRzU1ErdTc1VXBYMWRtbzg1?=
 =?utf-8?B?enRVTW84elREK0JjTVpHYmRjcnZrS2g4VmJCemZHcW5UalU4QkViVHd3QjdU?=
 =?utf-8?B?MkVpNTMxK2xyaWViUWc3TnBBOWNZbzlFRGdYM1RSbjJBZHZEcEFhMlBHbXMx?=
 =?utf-8?B?Wjk2R2NEbnBxQUpNY0tnQ2hMczBoME9uakQ3Z1daRGlnSXluOEQ1YWg0ZEJx?=
 =?utf-8?B?LzVzVnl5KzhrUEl2a0NDK1Roand1Wi9PODg4Vk5uNTFQSVltZnpSVUxFRjZy?=
 =?utf-8?B?U3FXZjk1WUE2N2lnaDlhdHZmd3JNSlZ6WXZxU2ZyOVpSMFlFUWJMMTFCQlFF?=
 =?utf-8?B?R2lDa3VZU3BBMUxYdDBjQWdldVNHUnpWKzR4U2lWQXFVbE42UUMzRmRxZjY2?=
 =?utf-8?B?NktyZ0Y2aWdOS21RY2dzanVlL0h6VjR1YVE5OXJRVHdmSjFuL3RCMzdtUFVq?=
 =?utf-8?B?SFlsRXdqcEoxSjQ3M2hBdnRtTW9sL0x6U1E2a3UwaksvN3VzMWNyc3NsQzh6?=
 =?utf-8?B?YS93eUx5SUZFOEFZQmM3UzNvRGxRK216MEo0Z3pCMlhneG0rMXZtRUVRVk1p?=
 =?utf-8?B?TlFqT0hyc1QvR3d3ZU05YUdpYXM3V0NEWTdpWEl5b0RMdnlRNnkzVmpEUlhY?=
 =?utf-8?B?WlFlZ0hrZ3ZIRTIwc21oblFLU05FM2QzR3hIcG50Y2Exa3dqTFAyOGorZHNQ?=
 =?utf-8?B?aVlsalV5QzhHK25FS0wzQ3RiV3lmbTRqNStmTjJwb3dsVnQ2UmpPYlVhY1dn?=
 =?utf-8?B?eStJWHNMOEJvdHJ1ZmtGZHJ6ejViOVlmOER6Q2crTzQ1RW9tczNIa0o1dWdY?=
 =?utf-8?B?MVpzQUlTS3h0K1hJOUZXYy9PTFpSSnlBMzYvWHRUQWVDUWZZNUhjdnBRME16?=
 =?utf-8?B?eUZyMytVMGYxVUc1bG44T3NWMXdWNk9xbWZCdndoTUQxTVlyaytBdFl4b1I0?=
 =?utf-8?B?VHpRcFQvazNtcngrZ2Q4Y2lIZDhCZHdpdlVhZWQ2amt6N3FhaXhsL3c1U2Ux?=
 =?utf-8?B?cnIvc0ZYV3RtL3VUV3BqMTMyWDE4My80RVFYN21iQ3B0WVJLOGwxbVkrOEtX?=
 =?utf-8?B?N0hJVFJiL0RWc3RFVVEwV2NZSnNIakFxZm1mOW1HUVZDUEp3VlNHcytMbVd6?=
 =?utf-8?B?M2tGQXVTTHZBaW5ULzJOTUNnLzQ5MG5NQ2FhcWlSL3NlUFMvK1hWajFLZjNE?=
 =?utf-8?B?ZE9mL2xSRFJibmhZVVBzVDRwbEZPelFQZm5icmY1S2JiVGduTXR5TnlYenUz?=
 =?utf-8?B?YnM4Sm53d1ZlVnBVZ0pndVlUeW9WSEorWDdZZFo4ZjNNTkxxRlFsRW0xMzNX?=
 =?utf-8?B?c1BxVnBsdk5LdHJUdk94b2QvMm01R040bWtZdXVaRXkydk82emgxbzY4MVU3?=
 =?utf-8?B?aXllWXpGM3ZZaDlMLzYvSHpKeXJEdkNDZUQ3SUhZNjVJT254NU9vU0FwenBo?=
 =?utf-8?B?ZC9SVlpyTmQzYjIrMUdYTnI5ZytSZ3dLT3Z0WlAwVDcvdjFkb2g5SnBRelJw?=
 =?utf-8?B?NFk3em4rbTd4NHd1OEg0UDNtQUpxNVA3SkJlNnVOL2lETUhETGM5cytFbXVp?=
 =?utf-8?B?VGQxTWdsU2NFbncyajA1RDBXTjhodk01eStPbzZDNWg2Q2JGSk5waVFyTS9q?=
 =?utf-8?B?aE5mV0pNWnlvc0lIa0FQZGw0dWNOVy9ReWdUUDRDNFlYNkkyclZoMmZDRUp2?=
 =?utf-8?B?UEFMbzlpUG50cGdRMHFWY3Uya1lhWjduTGJMNGw0WFdYWmNHVWxkbjArSGJj?=
 =?utf-8?B?NldnV0h0RGsxTzBiQ2lQeFlCYmI5eHphczRPODg3ZlFMYUhsSGM2Z1VsWkkz?=
 =?utf-8?B?NDZBK1NTa2FONHZxdklWSkd6aHA5WmZTaXZ3a3ZFV2hwVURsS3hNUUdKdFpH?=
 =?utf-8?B?cVBtNkhaSzNxeHpnSEYyZ1JsRGhlMytFMU5yUG0xU0lXQ1d2OEVzaHdkUVh5?=
 =?utf-8?B?d3hTcHkyMCtMWG5DNGMxTk5IVk10K25wNGZDQWpIK2syNHFNYXYxWkJpQ1Qx?=
 =?utf-8?B?SWFHVGhZV05UUXVtYlczQzZVSXEwbzUyUWxETmFpeWxGcDlvaDhVYmFSSGk4?=
 =?utf-8?B?WmNSUForamxyTTBUQitEYUdaV3JPL0ZZT0l0a3lDWXhnYnNERDlzRG1mUzhC?=
 =?utf-8?Q?w2QzItmV+lbn3oG4=3D?=
X-Exchange-RoutingPolicyChecked: ikd6WJKFYYnrOeri3KodP2GP7y1AzOfa4/tPxmYZjT6H3BoZAzzPIkOPX9JX3juo2zSzAml7TleKZx524vVFCff2tMXnJwUaWsfTmo2mtdBomSf4GlxmKFZphyNF6T4ct4PA3FHCSw7nzOfvN0aIW+h74qzR1caQFFks7RcNRAtSHZY4QjhjoOOVCmHUZU5aO4jxSd7Ammi+VpySnyfd+u24Q1+TG2rfJ+iLMkfCIeAU35PNqi0MQx7it8rMxdG9hTMrE9dR/OrJtDCOcWUuSjfanDCJIgywbjiB3+wwtgUXmOhZhNcaaaqN9GRfkEoKWPNr9nJUVhzCr3Z10oUgJQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e8ea88-0a80-4dfb-81d3-08def7b628e8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 14:38:07.8138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XmzHuZpiNlrUW0+Rl3RKNq1bSPyFDbZGHFOokE2Hi3sKn6iBc/lufYQPF5RiXlAZx3OZey9JYk8tdIXjQxSN4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9953
X-OriginatorOrg: intel.com

On 03/08/2026 12:06, Amir Ayupov wrote:
> process_group_desc() rejects the entire perf.data file ("invalid group
> desc" -> "incompatible file format") whenever the group description is
> inconsistent with the event list. Group information is optional metadata
> and is not needed to decode samples, so a single bad group descriptor
> should not make an otherwise valid file unreadable.
> 
> This is observable with AUX area recordings (Arm CoreSight ETM, Intel PT)
> that use aux-action pause/resume: the aux-action regrouping inflates the
> AUX group leader's nr_members, producing a group descriptor that the

Regrouping by auxtrace_parse_aux_action() is done before group
description is written, so it should match.  What exactly is
wrong with it?

Can you give example perf commands?

> strict reader rejects, even though the file is otherwise fine (older perf
> and other tooling read it by rebuilding groups from event records).
> 
> Warn and fall back to a consistent ungrouped event list instead of
> failing the read.

Seems like just papering over the issue.  Why can't the group
description be written correctly in the first place?

> 
> Signed-off-by: Amir Ayupov <aaupov@fb.com>
> ---
>  tools/perf/util/header.c | 42 +++++++++++++++++++++++++++++++---------
>  1 file changed, 33 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index e90e541f546b4..ddc59624d639b 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -3373,6 +3373,19 @@ static int process_group_desc(struct feat_fd *ff, void *data __maybe_unused)
>  	i = nr = 0;
>  	evlist__for_each_entry(session->evlist, evsel) {
>  		if (i < nr_groups && evsel->core.idx == (int) desc[i].leader_idx) {
> +			if (!desc[i].nr_members)
> +				goto out_inconsistent;
> +
> +			if (nr > 0) {
> +				/*
> +				 * A new leader was found before the previous
> +				 * group's members were all consumed, so the
> +				 * group description is inconsistent with the
> +				 * event list.
> +				 */
> +				goto out_inconsistent;
> +			}
> +
>  			evsel__set_leader(evsel, evsel);
>  			/* {anon_group} is a dummy name */
>  			if (strcmp(desc[i].name, "{anon_group}")) {
> @@ -3381,11 +3394,6 @@ static int process_group_desc(struct feat_fd *ff, void *data __maybe_unused)
>  			}
>  			evsel->core.nr_members = desc[i].nr_members;
>  
> -			if (i >= nr_groups || nr > 0) {
> -				pr_debug("invalid group desc\n");
> -				goto out_free;
> -			}
> -
>  			leader = evsel;
>  			nr = evsel->core.nr_members - 1;
>  			i++;
> @@ -3397,10 +3405,8 @@ static int process_group_desc(struct feat_fd *ff, void *data __maybe_unused)
>  		}
>  	}
>  
> -	if (i != nr_groups || nr != 0) {
> -		pr_debug("invalid group desc\n");
> -		goto out_free;
> -	}
> +	if (i != nr_groups || nr != 0)
> +		goto out_inconsistent;
>  
>  	ret = 0;
>  out_free:
> @@ -3409,6 +3415,24 @@ static int process_group_desc(struct feat_fd *ff, void *data __maybe_unused)
>  	free(desc);
>  
>  	return ret;
> +
> +out_inconsistent:
> +	/*
> +	 * Group information is optional metadata and is not required to decode
> +	 * samples. Rather than rejecting the whole file, warn and fall back to
> +	 * a consistent ungrouped event list. This can happen with otherwise
> +	 * valid perf.data files, e.g. AUX area (Intel PT, Arm CoreSight ETM)
> +	 * recordings using aux-action pause/resume.
> +	 */
> +	pr_warning("Inconsistent HEADER_GROUP_DESC, ignoring group information\n");
> +	env->nr_groups = 0;
> +	evlist__for_each_entry(session->evlist, evsel) {
> +		evsel__set_leader(evsel, evsel);
> +		evsel->core.nr_members = 1;
> +		zfree(&evsel->group_name);
> +	}
> +	ret = 0;
> +	goto out_free;
>  }
>  
>  static int process_auxtrace(struct feat_fd *ff, void *data __maybe_unused)

