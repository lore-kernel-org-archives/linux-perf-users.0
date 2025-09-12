Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8286F221DB0;
	Fri, 12 Sep 2025 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690449; cv=fail; b=UG49lq3Z/iq2sjXRizVUO+cQTxXMlH1IqValR4n9RjXQj8s9CA/Qwq7cLRg2azRhrm7zl319N/xOMMM4pWviiU0LsunmfWKLGcYR//n+BtqilR/wwAjQ8bTNTjNHuUtEFuBwMUkNUw7CZ9zEdgbl4yf7S2O0ukUBnw3dLGJDuiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690449; c=relaxed/simple;
	bh=ejn9rxaTN4XxHh/z/sLm3rKpE9coeZoxquGHI7PMO+Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ARv8KlkJzv2g3nYNVSSObxriPsLqFUdKfVj+ItJSR8al2qt9xm5cQNxkpohtHbxWGqwYNCFwvhdP8Md1aqNJp6ZoEXZ0joUF982vTjoCvjTLt7bHiUOIGEAg7Th4f52cnZchHZ9NUYtzF49HBsKCdUa0RKU6gqk1rHuUYtRsj/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HODq+GSX; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HODq+GSX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757690447; x=1789226447;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ejn9rxaTN4XxHh/z/sLm3rKpE9coeZoxquGHI7PMO+Q=;
  b=HODq+GSX3Ahbn/jUVQ0RSO+XO8e9HiUt3fXQKr9jFL64BBo8haGIj1wS
   L5EIOv5TDa/WMfYnlK0qeUN8STKhPBncJcpEyIEQHEAjp9lmqb5mwKe90
   dzPBQnFXuSgZkq2ZOvJC8m0MxtHqufiUf8nzawmyg6dbgYM2TQGW7XnJb
   AGaRThOlMEwF9jAEA2rqRE5tOw5NfGlvwam4SXs6u03EoGQhDIzb1ls57
   5cmytiF8oU1qawHP1/C07Msc56A1ONYw415e2w6BfDBl+eC6Sre0CzB5V
   +R31LuHFvhlkJ6anb4eBpevp1EZjab5jaNATEyHKbCEaBDw8VxZzZLwT1
   A==;
X-CSE-ConnectionGUID: D12JPF6tSDKiEeZpuCVNVQ==
X-CSE-MsgGUID: n+cTVKxnRiWPMPhq3ZJ6eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="60112406"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="60112406"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 08:20:46 -0700
X-CSE-ConnectionGUID: vCHp/HwQQae+YyUlTDvZ2Q==
X-CSE-MsgGUID: Abnzflc+RwC4lsOVbEj/2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="174064970"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 08:20:45 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 08:20:44 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 12 Sep 2025 08:20:44 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.61) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 08:20:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDAzfBvvPC8OYDhHPd2s7VVQ+/LeuzLGyV9ModHHm5c6+r4BZ7jZSU6eXm608ZBnIyidoYbtS03raiDFZ13wy5pD5Py90vDB65c7uHSJcyXxddNrePSNM3R7c/WLp8bFJ78nbWyYKJ4HgdQu3vbAAe6PSfgVd85JMn5T3ZWIp2a5BiW5T8sBeDsLwzZxpWeCtOWrPMN0aJB+n6lwBmZ/MSbW5O9gi5EAeoSoM9pJO0S6FbRJuG7oTUp16GiZuxtIsFcAuBfyTTqj0x0FJLbiocWb2sZZdqRPzwEwZ+2Aw0axaG9w49FOn9qNFaDLN5EcR2dX0w1vql1BAxsmxZFk/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heFUrtaWjQkzUHFNDgTS1xvvwV+MWQ/xa3ok9AhPMys=;
 b=I7RBriQjHy3XsuRGGuU3TV4zCW5Wu/OJy3A1a3HBwR2myTWVQGNrLy/x7boo2TCQxCVMD3JaalARYOmgSt6DH30+yu/ugdsCKh+snty9baf37V8v8oELy9qmYBsV6Sww2LYcgW4cax9cwkm6P0Z9gwL6umwLcBPTgLtP1mCXLXTu1NT73iPeQ9njuvB6Wu8oxsU9ATcZlh0ZLWYAjX628Xk+/UhEmi3hXnZXr7H6cUHGO9jNsTdJeUG3pnjE5HT4/Mo9MKBqF5AL+LsPbec3baCLJzheAnUJb7BoJYyaHOHe2i7pGfXoFfbuhiscc5VCYh04aE2OKBbGDQ2UWtx40A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB8289.namprd11.prod.outlook.com (2603:10b6:303:1e8::9)
 by SJ2PR11MB8469.namprd11.prod.outlook.com (2603:10b6:a03:57b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 15:20:41 +0000
Received: from MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022]) by MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022%3]) with mapi id 15.20.9115.017; Fri, 12 Sep 2025
 15:20:40 +0000
Message-ID: <b470609e-6392-4c15-8123-ac5126df8b5e@intel.com>
Date: Fri, 12 Sep 2025 23:20:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf tools c2c: Add annotation support to perf c2c
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
References: <aLhHvWTnxGA-_6Ew@x1>
 <20250907152510.957952-1-tianyou.li@intel.com> <aMNBn0rWjfj7TkUQ@google.com>
Content-Language: en-US
From: "Li, Tianyou" <tianyou.li@intel.com>
In-Reply-To: <aMNBn0rWjfj7TkUQ@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To MW4PR11MB8289.namprd11.prod.outlook.com
 (2603:10b6:303:1e8::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB8289:EE_|SJ2PR11MB8469:EE_
X-MS-Office365-Filtering-Correlation-Id: 76e85796-9340-43be-33c1-08ddf20feef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0JlRzVQN2pFNDdIS2M5eUhsUlBkbzROYUIwTVU3blRMaitoNFJ3R1NOY3B6?=
 =?utf-8?B?YjExaU4xcGVTREZ1YVQwNGdJZU13Qi92VzFDanhXZmhXanJId2J2VXlTZEZx?=
 =?utf-8?B?Mk1RYVFJVDI1WTlveXg5M21pUzdZcG1xMDRYc1VURi9UbWo5NTE5OGVnT1Fx?=
 =?utf-8?B?Q1p3NndkNm9xbm9COG5qaTI1aWIvV0N5L3ZyUnB0TUdpb0ZTaHVyY2NwdlJZ?=
 =?utf-8?B?YVlNbllJRE0wRlh3SDgvaTBiSU0yS1dQSW5TYWxQcXAxZUk0WG13b2Y4dVRK?=
 =?utf-8?B?MGt3bkpxNkNOMzhEMVdMVVhpM1JERnNwb2JXN0o4TTZLSTRHeXVSZ2FQdHpU?=
 =?utf-8?B?UmRTV2RWcCtpZ3FiVC9JZzN6MmFQT0ZPK2V0ODd4b0R2cEFpd3FzZFFtNW9F?=
 =?utf-8?B?clZlMGZLWjlmWlRlWVcxSVExZk9IMUJVcElBcXhrUm1ISzlwZ1JpaDVjbUVz?=
 =?utf-8?B?ZUZmUG11QWlBSWxPVHBMSng0a0g0Q1ZxblplVER1NFZ1ckpnSXhqaDlkZmZT?=
 =?utf-8?B?V25JOGkwUjZxTHZDeVU0S0RUV09lNTg2SnVUMlBrZlBVaU80UkpqbnpoVmo0?=
 =?utf-8?B?VWNpNmZEaGxzcHJ1YXpNUEZXSjFDVlpvMldjSDVOc1hFeTcwL01XQmhyQWVM?=
 =?utf-8?B?bzRJekNyMHJwMXh1bGlxcU1xc3o2TVFrVk5UbHdvbFBIZmZES2xSbWQybHM5?=
 =?utf-8?B?QVlLUkMrVkpudFlZREdwbXNOTmhpL01QaGY3bml0MGZkVUM0NllJUEhUN2hW?=
 =?utf-8?B?UWxzVERQcS9PNUYzN3BWTG5abG5Fa1QxcGhMQkNaRTdsMmRiZlVtazh2amZk?=
 =?utf-8?B?WENSdldjaTRoUjJPN2NuZXVoaWpBMGlzdFBOSWZrUzFJNDJERVdWSXZCekc4?=
 =?utf-8?B?YklEdFRjVkJReXpuOUdtMFF1Y1pWMTVNMGhDY1ZlUVZkODZFb2xnT1A3c3Fv?=
 =?utf-8?B?dDNQVkpjdEx6MW15Y3NJTGN2WnowR0d6b1B0MXB5TjhDaS9GQlY3dDNoQVFB?=
 =?utf-8?B?S3QvZit6ZEhVdE9Yb2QzMWNZeTBac1pOM1Q0SDhCWjk0bmR4SWJiMVk1VStW?=
 =?utf-8?B?TXd5dmlFMFpNMytuWU4rWkdRTWNDekliQkZCYTM1UkNMUEMwR1ROWGZteElN?=
 =?utf-8?B?TW5zeWxZVnpLb29iVlFjMDVkMTlja3czcC9IamhlNDRXQXJJc3FBeEFDN3pq?=
 =?utf-8?B?M0lmSFVSUnQ1cGJOU0FZZ0FqMGF4anNpN2hYMGZMbS8vVmxpK1ZaT2Vsa0tI?=
 =?utf-8?B?VTZhT1c4V0tjK1dFUnRpOUE2cmtzNk92b09yT1A4YkRBaW1BRHVraGxCMitq?=
 =?utf-8?B?R0lGSlZoYzFFam43ZDlnTjJpUGl6VGRKTTBIbFdzWXpnamxoSWV4aGhSL0gy?=
 =?utf-8?B?bSsyVkVnTi9sUExqVWZ0TmZYKzdzY29jSFlyVGFqTWxzUjRCcUhIdXo3clAx?=
 =?utf-8?B?Z3pCemYrbGZOMGlZVnpHckFLQ2hTMzI0TVplYUEydHhQSjdWYnN2aGZCU1l0?=
 =?utf-8?B?UTUvN1ZEcDFpaGV1K0VVVWoxWXE0dDZmbjMzbnQ1eEprM0ZQWjhITHcwOWN3?=
 =?utf-8?B?ekFXcVQ1LzJIeVdGMDNZYzJMT3VQWllZd055elBFc0g2U1lMY3VqZCtZRUZx?=
 =?utf-8?B?dXNBTTdBa0tzT2ljcEx6NFNOWW1WM2RxRXExaEZsc0JzSjlERllML2svcVJN?=
 =?utf-8?B?Y2JvODNxa3RaSnY5aVVzMWFaNzdvdndOSk9IUk9vWnRSWDBSV0dycWdnbG1o?=
 =?utf-8?B?ZDQxbkRTS25WSklrY0d2VmlrUko5RTArakhCUXQxdWNPdTFvbXNINGFxaWZG?=
 =?utf-8?B?cUlyVDdwU3AzaGNHOXVDOFcxbmt5VTEyYS9jYStjdHI2M2ZlLzBnbDZEa2RP?=
 =?utf-8?B?djh3LzU3NlFHUUorWW56bllMUVowdHZubDl1cUJ3eVhSSzN3c0N6d2NTczgv?=
 =?utf-8?Q?BYiiodySW3o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB8289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUdDTmZIY1hOelBPMCtnWlUvcU9hQ3pycXorRFpnT0tqMHQyUUZ4V2FpVTBR?=
 =?utf-8?B?dzlHc3MweTI1T3RYZDA5OW9sK2JPOXA5Vkh4N3JtVXlMYWU3SmNlZEdvQUZW?=
 =?utf-8?B?VWNEV3IvSjc5OExocCt3WE03T1dQRVQ2ZkdLTkhXbWNETzlEWTZ2N1lQZ3Jx?=
 =?utf-8?B?MFB2UGZYcjBiNDBONmZ3Rm5kNHp1d3dxUHpaRWh4ajBybjFtaHBqN3JuaEZP?=
 =?utf-8?B?Z3FKaEpOK2pOK3N5WkFkT0FwSjNhV0lPREN4ZGU2RHpxN2dGeWFxVFUrSVcw?=
 =?utf-8?B?NHBTandrUmp4YklVek9KVEg3ZTF3Z3Y5MXRGZStMSXhzVFlUWE5SQUFtVC93?=
 =?utf-8?B?OGlvRjVvdnVpd3lqMHMweHpqL3pudTVZU0xQN0ZJTVdhMzVyalBvak9HVkVx?=
 =?utf-8?B?L3YrdVZVS2ZTWGJiK1BPK1ZvZTlxK1JCbkcrN1RwaVZlN3RaRUlhbElIMEwr?=
 =?utf-8?B?YjRoaXkrSnF1ckgvVGU0aUJrK3ZEWmtYWnFuOG5ST1hUbUs3Rk1XaXlLdUtV?=
 =?utf-8?B?OU1ZMFNQaXdVUVFmVTVrYmV0UzA4cVk3TWxGbGg1SU42cFJFaVFqSWtFbmUw?=
 =?utf-8?B?cGJvbEpuVVplOWRhRDIrdFlQZEtFdEV6dlN3Y1MrVDJ5RjEyTlMzRTVNcXM2?=
 =?utf-8?B?N0I0TEZVYzk2Qm9MVnpkb0hRVzlHVHMwcDM1S084eFdvOWtWWFozTTRVbjRO?=
 =?utf-8?B?UGl4bDFHanNYSWw0bWl6NU5vQ0k3VDRacnhBNkhLQzZSVG1aQ3dwL3NaNHBO?=
 =?utf-8?B?VTE4Nkp4VTFtbmZxTEpmRDE0Q2ZWWDBzd1lZNFE5ckk1c0VtQ1Z2VDBjczE0?=
 =?utf-8?B?ODN5TUJkR2dlUzMwNTlXa0c2NW9aYURIelhISk9wdWxJSG9LQS9VSFNVdjFw?=
 =?utf-8?B?aDhVczVXZHU5NTFuSmVyZnZnTUx1S2Q1aGRJelhWMkVnZGpPcktMMHZ2eVlD?=
 =?utf-8?B?cVlqMDVmTUliamhqZjJJTGZZRTN2UDc0MkxvdDJHZjlQb3JSL3JXU1NhejUz?=
 =?utf-8?B?eVhYbmVhTnI5dXNEanRlNUl0RHQ3ejJkSnlqZDRWK0ZOV0dOMk81M01JUEVt?=
 =?utf-8?B?M1BYQkZIWCtvMzZ3LytCUndKOFJjK1ZrQjFkYnE0ZXUvRFp6MklmV3h1UXBp?=
 =?utf-8?B?MEIxUVBoYWpwU0pLK2FLRThwdUpCekVUdFNxcVFENVVuN3B4ZDUvL2VLelN6?=
 =?utf-8?B?d1h5a0xlaGN6RnJxK1A5ZUFqWmZWZ01vWnhCR3Joc3BEZ2phYlNpWjNheVFF?=
 =?utf-8?B?cnZMQUVFRWpXVE5nS1ZQTzgxdVRYNkE1WmJOT3Vpdlp2R3NscDEzUzl4ay8z?=
 =?utf-8?B?ZDdBWnJNb3FiZWh0M3NFdGFZdnVaU2x0WHpmOFE3d01NUzNKRU9GK2NKcmxQ?=
 =?utf-8?B?RnBFam1kMTJIaHF4bkltbzlYMG82T2VvaHhDRm5mWUJHQ3RXS2d5b3VtUDhk?=
 =?utf-8?B?Mi9tZ25HMGk5SkdlSXBEbEdIbUM5OVNRUy9WdlZHUEV1WHFQN2FGSDBsd2h1?=
 =?utf-8?B?aWg5OGV0Z0FPOGN1bW0rRHNiOUhsOUkvZzhvcDJ3M1IyeWVpN1g4eWVWR3J0?=
 =?utf-8?B?RFJMc3M4cDc4SGNnaHREYlUvWTVMYkljREF5V2hKaUgwUXVTVHhGOHJHZ2JW?=
 =?utf-8?B?S2t0eUhaOWkyN2Q2M3IwbUZUYmNEbnR2N21oWFlzb0NzTkx2RGNMWE8xSlFC?=
 =?utf-8?B?M21xam83Tm9DTmhJMXNFUDlrQWg0M2hLdCsvQjJxQlNYeEYyWHV1aXg1NXRl?=
 =?utf-8?B?R2hveGk0a1hZNndNc2NNUExYSVh2d1ZJWUc1NVNsY1BHSWJSdm0xeFRLN2gv?=
 =?utf-8?B?L3QwWk9lVXFsM2NxbERLS3dRS3RnVEJwZzRIVnloN2VWZ3JkWVkrQjA4U0VW?=
 =?utf-8?B?cGxTbTVVeWRYUTlKTmtVVWcwSWFPOXFGUWg1aEFOVElmKzVQTnFlTVE2bmJ5?=
 =?utf-8?B?RkJHdEdRNlp3ODgzUWtjQnB6SmdyUWUvVnljQ2p2QVg1eFBqQnRjWlkrMUVr?=
 =?utf-8?B?MC9Ia1UrY0kyWHRxaDEzOEt6N0RoUC8vMEI1bXkxQysxL2pySVRjc1BWaVlZ?=
 =?utf-8?B?bGJQK0YzK29DMFFTekphaWtFd01yRFl0NEQyOTQ4K1YvdldpVDVPNzZYZElp?=
 =?utf-8?Q?myPBsq5LeW0k5T7gONlYPjEkE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e85796-9340-43be-33c1-08ddf20feef6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB8289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 15:20:40.6955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: umCxWNg90J2rhY0COT/2VPF75Qv+KROyeZ/oLQZZhnX6nPcVLFpw1BY8Zgdo9MlLVxLMxEqWUDm8Ulwq/dXWyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8469
X-OriginatorOrg: intel.com


On 9/12/2025 5:39 AM, Namhyung Kim wrote:
> Hello,
>
> On Sun, Sep 07, 2025 at 11:25:10PM +0800, Tianyou Li wrote:
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
>>   tools/perf/builtin-c2c.c          | 124 ++++++++++++++++++++++++++++--
>>   tools/perf/ui/browsers/annotate.c |  40 +++++++++-
>>   tools/perf/ui/browsers/hists.c    |   2 +-
>>   tools/perf/util/annotate.c        |   2 +-
>>   tools/perf/util/annotate.h        |   2 +
>>   tools/perf/util/hist.h            |   6 +-
>>   7 files changed, 164 insertions(+), 14 deletions(-)
>>
>> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
>> index 646f43b0f7c4..f977e97a9c96 100644
>> --- a/tools/perf/builtin-annotate.c
>> +++ b/tools/perf/builtin-annotate.c
>> @@ -519,7 +519,7 @@ static void hists__find_annotations(struct hists *hists,
>>   			/* skip missing symbols */
>>   			nd = rb_next(nd);
>>   		} else if (use_browser == 1) {
>> -			key = hist_entry__tui_annotate(he, evsel, NULL);
>> +			key = hist_entry__tui_annotate(he, evsel, NULL, NO_INITIAL_IP);
>>   
>>   			switch (key) {
>>   			case -1:
>> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
>> index 9e9ff471ddd1..f5702d218490 100644
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
>> @@ -2550,6 +2561,29 @@ static void perf_c2c__hists_fprintf(FILE *out, struct perf_session *session)
>>   }
>>   
>>   #ifdef HAVE_SLANG_SUPPORT
>> +
>> +static int perf_c2c__toggle_annotation(struct hist_browser *browser)
>> +{
>> +	struct hist_entry *he = browser->he_selection;
>> +	struct symbol *sym = NULL;
>> +	struct c2c_hist_entry *c2c_he = NULL;
>> +
>> +	if (!he) {
>> +		ui_browser__help_window(&browser->b, "No entry selected for annotation");
>> +		return 0;
>> +	}
>> +	sym = (&he->ms)->sym;
>> +
>> +	if (sym == NULL) {
>> +		ui_browser__help_window(&browser->b, "Can not annotate, no symbol found");
>> +		return 0;
>> +	}
>> +
>> +	symbol__hists(sym, 0);
>> +	c2c_he = container_of(he, struct c2c_hist_entry, he);
>> +	return hist_entry__tui_annotate(he, c2c_he->evsel, NULL, he->ip);
>> +}
>> +
>>   static void c2c_browser__update_nr_entries(struct hist_browser *hb)
>>   {
>>   	u64 nr_entries = 0;
>> @@ -2617,6 +2651,7 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
>>   	" ENTER         Toggle callchains (if present) \n"
>>   	" n             Toggle Node details info \n"
>>   	" s             Toggle full length of symbol and source line columns \n"
>> +	" a             Toggle annotation view \n"
>>   	" q             Return back to cacheline list \n";
>>   
>>   	if (!he)
>> @@ -2651,6 +2686,9 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
>>   			c2c.node_info = (c2c.node_info + 1) % 3;
>>   			setup_nodes_header();
>>   			break;
>> +		case 'a':
>> +			perf_c2c__toggle_annotation(browser);
>> +			break;
>>   		case 'q':
>>   			goto out;
>>   		case '?':
>> @@ -2989,6 +3027,11 @@ static int setup_coalesce(const char *coalesce, bool no_source)
>>   	return 0;
>>   }
>>   
>> +static bool perf_c2c__has_annotation(void)
>> +{
>> +	return use_browser == 1;
>> +}
> Can you just use ui__has_annotation()?  It should make sure if
> he->ms.sym is valid which means you have 'sym' sort key.
>
> Thanks,
> Namhyung

Thanks Namhyung for your time to review the patch. ui__has_annotation() 
use global perf_hpp_list while we use c2c.hists.list in builtin-c2c.c.

Per my understanding, the he->ms.sym was initialized through the call 
chain of hists__add_entry_ops ->  __hists__add_entry -> 
hists__findnew_entry -> hist_entry__init.

Could you please kindly let me know in which case we have an invalid 
he->ms.sym where I should code a fix? Thanks.

Regards,

Tianyou

>> +
>>   static int perf_c2c__report(int argc, const char **argv)
>>   {
>>   	struct itrace_synth_opts itrace_synth_opts = {
>> @@ -3006,6 +3049,7 @@ static int perf_c2c__report(int argc, const char **argv)
>>   	const char *display = NULL;
>>   	const char *coalesce = NULL;
>>   	bool no_source = false;
>> +	const char *disassembler_style = NULL, *objdump_path = NULL, *addr2line_path = NULL;
>>   	const struct option options[] = {
>>   	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
>>   		   "file", "vmlinux pathname"),
>> @@ -3033,6 +3077,12 @@ static int perf_c2c__report(int argc, const char **argv)
>>   	OPT_BOOLEAN(0, "stitch-lbr", &c2c.stitch_lbr,
>>   		    "Enable LBR callgraph stitching approach"),
>>   	OPT_BOOLEAN(0, "double-cl", &chk_double_cl, "Detect adjacent cacheline false sharing"),
>> +	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
>> +		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
>> +	OPT_STRING(0, "objdump", &objdump_path, "path",
>> +		   "objdump binary to use for disassembly and annotations"),
>> +	OPT_STRING(0, "addr2line", &addr2line_path, "path",
>> +		   "addr2line binary to use for line numbers"),
>>   	OPT_PARENT(c2c_options),
>>   	OPT_END()
>>   	};
>> @@ -3040,6 +3090,12 @@ static int perf_c2c__report(int argc, const char **argv)
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
>> @@ -3052,6 +3108,36 @@ static int perf_c2c__report(int argc, const char **argv)
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
>> @@ -3126,6 +3212,38 @@ static int perf_c2c__report(int argc, const char **argv)
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
>> +	if (perf_c2c__has_annotation()) {
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
>> @@ -3135,11 +3253,6 @@ static int perf_c2c__report(int argc, const char **argv)
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
>> @@ -3210,6 +3323,7 @@ static int perf_c2c__report(int argc, const char **argv)
>>   out_session:
>>   	perf_session__delete(session);
>>   out:
>> +	annotation_options__exit();
>>   	return err;
>>   }
>>   
>> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
>> index b770a8d4623e..c2afa3624917 100644
>> --- a/tools/perf/ui/browsers/annotate.c
>> +++ b/tools/perf/ui/browsers/annotate.c
>> @@ -592,7 +592,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
>>   	target_ms.map = ms->map;
>>   	target_ms.sym = dl->ops.target.sym;
>>   	annotation__unlock(notes);
>> -	__hist_entry__tui_annotate(browser->he, &target_ms, evsel, hbt);
>> +	__hist_entry__tui_annotate(browser->he, &target_ms, evsel, hbt, NO_INITIAL_IP);
>>   	sym_title(ms->sym, ms->map, title, sizeof(title), annotate_opts.percent_type);
>>   	ui_browser__show_title(&browser->b, title);
>>   	return true;
>> @@ -854,6 +854,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
>>   	const char *help = "Press 'h' for help on key bindings";
>>   	int delay_secs = hbt ? hbt->refresh : 0;
>>   	char *br_cntr_text = NULL;
>> +	u64 init_ip = 0;
>>   	char title[256];
>>   	int key;
>>   
>> @@ -863,6 +864,13 @@ static int annotate_browser__run(struct annotate_browser *browser,
>>   
>>   	annotate_browser__calc_percent(browser, evsel);
>>   
>> +	/* the selection are intentionally even not from the sample percentage */
>> +	if (browser->entries.rb_node == NULL && browser->selection) {
>> +		init_ip = sym->start + browser->selection->offset;
>> +		disasm_rb_tree__insert(browser, browser->selection);
>> +		browser->curr_hot = rb_last(&browser->entries);
>> +	}
>> +
>>   	if (browser->curr_hot) {
>>   		annotate_browser__set_rb_top(browser, browser->curr_hot);
>>   		browser->b.navkeypressed = false;
>> @@ -963,6 +971,17 @@ static int annotate_browser__run(struct annotate_browser *browser,
>>   				ui_helpline__puts(help);
>>   			annotate__scnprintf_title(hists, title, sizeof(title));
>>   			annotate_browser__show(&browser->b, title, help);
>> +			/* Previous RB tree may not valid, need refresh according to new entries*/
>> +			if (init_ip != 0) {
>> +				struct disasm_line *dl = find_disasm_line(sym, init_ip, true);
>> +				browser->curr_hot = NULL;
>> +				if (dl != NULL) {
>> +					browser->entries.rb_node = NULL;
>> +					disasm_rb_tree__insert(browser, &dl->al);
>> +					browser->curr_hot = rb_last(&browser->entries);
>> +				}
>> +				nd = browser->curr_hot;
>> +			}
>>   			continue;
>>   		case 'o':
>>   			annotate_opts.use_offset = !annotate_opts.use_offset;
>> @@ -1096,22 +1115,23 @@ static int annotate_browser__run(struct annotate_browser *browser,
>>   }
>>   
>>   int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
>> -			     struct hist_browser_timer *hbt)
>> +			     struct hist_browser_timer *hbt, u64 init_ip)
>>   {
>>   	/* reset abort key so that it can get Ctrl-C as a key */
>>   	SLang_reset_tty();
>>   	SLang_init_tty(0, 0, 0);
>>   	SLtty_set_suspend_state(true);
>>   
>> -	return __hist_entry__tui_annotate(he, &he->ms, evsel, hbt);
>> +	return __hist_entry__tui_annotate(he, &he->ms, evsel, hbt, init_ip);
>>   }
>>   
>>   int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>>   			       struct evsel *evsel,
>> -			       struct hist_browser_timer *hbt)
>> +			       struct hist_browser_timer *hbt, u64 init_ip)
>>   {
>>   	struct symbol *sym = ms->sym;
>>   	struct annotation *notes = symbol__annotation(sym);
>> +	struct disasm_line *dl = NULL;
>>   	struct annotate_browser browser = {
>>   		.b = {
>>   			.refresh = annotate_browser__refresh,
>> @@ -1163,6 +1183,18 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>>   		browser.he = &annotate_he;
>>   	}
>>   
>> +	/*
>> +	 * If init_ip is set, it means that there should be a line
>> +	 * intentionally selected, not based on the percentages
>> +	 * which caculated by the event sampling. In this case, we
>> +	 * convey this information into the browser selection, where
>> +	 * the selection in other cases should be empty.
>> +	 */
>> +	if (init_ip != NO_INITIAL_IP) {
>> +		dl = find_disasm_line(sym, init_ip, false);
>> +		browser.selection = &dl->al;
>> +	}
>> +
>>   	ui_helpline__push("Press ESC to exit");
>>   
>>   	if (annotate_opts.code_with_type) {
>> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
>> index 487c0b08c003..3675a703de11 100644
>> --- a/tools/perf/ui/browsers/hists.c
>> +++ b/tools/perf/ui/browsers/hists.c
>> @@ -2485,7 +2485,7 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
>>   		evsel = hists_to_evsel(browser->hists);
>>   
>>   	he = hist_browser__selected_entry(browser);
>> -	err = __hist_entry__tui_annotate(he, &act->ms, evsel, browser->hbt);
>> +	err = __hist_entry__tui_annotate(he, &act->ms, evsel, browser->hbt, NO_INITIAL_IP);
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
>> index c64005278687..e544e1795f19 100644
>> --- a/tools/perf/util/hist.h
>> +++ b/tools/perf/util/hist.h
>> @@ -713,12 +713,14 @@ struct block_hist {
>>   #include "../ui/keysyms.h"
>>   void attr_to_script(char *buf, struct perf_event_attr *attr);
>>   
>> +#define NO_INITIAL_IP 0
>> +
>>   int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>>   			       struct evsel *evsel,
>> -			       struct hist_browser_timer *hbt);
>> +			       struct hist_browser_timer *hbt, u64 init_ip);
>>   
>>   int hist_entry__tui_annotate(struct hist_entry *he, struct evsel *evsel,
>> -			     struct hist_browser_timer *hbt);
>> +			     struct hist_browser_timer *hbt, u64 init_ip);
>>   
>>   int evlist__tui_browse_hists(struct evlist *evlist, const char *help, struct hist_browser_timer *hbt,
>>   			     float min_pcnt, struct perf_env *env, bool warn_lost_event);
>> -- 
>> 2.47.1
>>
