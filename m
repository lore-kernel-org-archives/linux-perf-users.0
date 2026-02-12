Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD0E35CB6A;
	Thu, 12 Feb 2026 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770905817; cv=fail; b=Dxj5ymAuwVJKTCg646h1glGctCQO6s/mwbqdVSSspkyiBJs/HM5ZQApYRvHj4glK4SCHY4IX0sdoPS+TmbJyD8dk4pHtLWhNXENHewUstMQOlSj44N/282kQTECdsYj7gLTuZPtLOy91viKqxZz26mjrr9PAtTLmUFBW29ywLZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770905817; c=relaxed/simple;
	bh=0gX/8WwmT2RI/G7t8X178aArWj6msbMGS4rHVYRM1WE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=oYhRnd1mMZ0OsAyPA1LLWIayMZWCdKOLorQsmDT3zKi9rDI7jsa5OJhItIr04FDJK2YtQWLDTPWFzxRG1TlA251P3q5X0KAQx8T77TZ/7xpLrpR/UcpM7swcvWkP4ntAN580cuAEOjMYjS1FqUIuuJk4ALTVpZzY7xKYdhqTJ6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hs1n9VgM; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hs1n9VgM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770905815; x=1802441815;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0gX/8WwmT2RI/G7t8X178aArWj6msbMGS4rHVYRM1WE=;
  b=hs1n9VgMrVpojnr7Lg6YhzbI0MIn8bET4cqh87pJeCIIqQmdvcpG9jWr
   J0Gd1MUXKKKsShmoNIr5c9Gyw2+lQXHDd8N0l9mq3qPx1hDJsrbmIt5UQ
   HaKAmTOr//ECEUIMqGzgJ5TJke7j1swoUHsxCE5iZq8gBVjzxKa7J9Azp
   5wjranozrOtTH7Hacvw0eKyXw9gq6xKzmT60kCzBJ7EUX3l92Il1MBaST
   rBsy/0C7E7PZ+5r3xOQxmCItFyrL/cmhRb3zwFVZYKl8xYov9TLtmMqKM
   GZCM/+o0w+YmrpvunEGbSLqwfyzZSWcWuZgZhRiQeVMO/mXd76oamQMpH
   w==;
X-CSE-ConnectionGUID: Yn0QDqX+Ta6JJCSrOMi5cg==
X-CSE-MsgGUID: n8aiQAruSaOMAGsiYBhuMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72151292"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="72151292"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 06:16:54 -0800
X-CSE-ConnectionGUID: YReDxbKkRzi57zAK6bcKwQ==
X-CSE-MsgGUID: LNOkbvZdQ02MkxnfhZka6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="242191708"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 06:16:54 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 06:16:53 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 06:16:53 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.49) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 06:16:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wfri9MJW85576h8xmOmjW2fvUqzpRQynPT9LToZNx/e6xsMktlS4c7t8357D6YaD6ZGth+UWC24RKzVitsaZrB+BI1B6JeqsqBvrq3mAZrIMRIR5SH3Cx7nsvLByqgZyG4ebs7MwD0M7QY0tg60iX8ak7XbyMvMC1hA4WDASMNeABbgGzPNJE2VlL+EA/iWzgqdZjQ3tJL53SiFveaN1ST7KNe/5epbvi/Po2sVbqCIbHebxuLwRlwbg7n8XANpTEd6r0JNHPQFzZljKzZiMyUB8iv5NQpr8gEgVOZnE9z3eiq7cxb/ST+so1qEyVbUiVqsqB1Bjy5H4OFqlUncLRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQowB/tqCo/uymW/+T6dR0n4GzshZxoQX0DmDIooqKg=;
 b=Of5ipPzo285wRk/bPN31rLpGg3oBhwj5nPtEVhbQ9sOwQd7HyH1kZ0KrUNV+fOs9SGBb5XL2jo04G68EPu+MAX+cGidTkdj/KQswg/9UONjCj04WgDJ5x6feLJrgc6AcgTWzoWDrF6najmJOiJn9uAuSfeMTcpKmSoefDiPqU0nboUUEXIo4EoK6yl6Ic0KfLZfqt5+6r07vgg8Y81NFIEM76iT9tLA+k4ZJjwP9pYnJjUFChm06HsWfTffB9jsRvpc0tOLYuuFCB1s9VwkfmX2/9DYmUGeH8KeReXrKfqCSaWJkpVPm0ujhOTwGUvS7AmFdAEdgxUePO6aqNPcgaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB7892.namprd11.prod.outlook.com (2603:10b6:208:3fc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 14:16:48 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257%5]) with mapi id 15.20.9611.012; Thu, 12 Feb 2026
 14:16:48 +0000
Date: Thu, 12 Feb 2026 22:16:36 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ian Rogers <irogers@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Arnaldo Carvalho de Melo
	<acme@redhat.com>, James Clark <james.clark@linaro.org>, Adrian Hunter
	<adrian.hunter@intel.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Howard Chu <howardchu95@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephen Brennan
	<stephen.s.brennan@oracle.com>, Tony Jones <tonyj@suse.de>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [perf test]  54a23bff77:
 perf-sanity-tests.test_addr2line_inline_unwinding.fail
Message-ID: <202602122137.a1396559-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SG3P274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::25)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB7892:EE_
X-MS-Office365-Filtering-Correlation-Id: 732bcd4c-1999-48f6-2ab7-08de6a415c20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A8PGdqTK6p+UOqm7WEkL/ksW08zy4JtncxMjPvPh2WsSc3g2JfwBww6Qznjb?=
 =?us-ascii?Q?JGV8rcez2iOdT909Lce/SqaExEXi1mWTvHHiTRuR5KlF1/zTvT5AnHYbHAPs?=
 =?us-ascii?Q?v0XJ4kNcIBXCHqGra29tup7l93GAaBfOorXa6ONqDjLMlScPDJIJl6Q1h49u?=
 =?us-ascii?Q?dtL7wRSumGZyYB9IWot7JHOl6k3bWmWkARhrpW1eZOD4LqRi/U3OqQEc/1jY?=
 =?us-ascii?Q?jY4WRi2CvmQiJVio4XihIp9W+W+rVWk444rlABwjNvl5EhbpMBOvn7zsq6jT?=
 =?us-ascii?Q?G2o8QiI7hUQTtpuwMi+5Qmj73ZUM8/KHeE/OPdeTW9fIaBYShCF9uPP2N31r?=
 =?us-ascii?Q?ixrqi4R8j4f3mQXVauMZ3xqzIxqF2xfSDQVWAqCmvA18qN6cLvyOt3sTvCME?=
 =?us-ascii?Q?j7o7omdDq7njepPi+SWwxqK6pMmAkFmZaUI/q8LIJxSPaO2Sqbn7VvWulUO+?=
 =?us-ascii?Q?wpzqns46MFXrZa6SWTb/i2enLp/RbZ/3vNfBiA1n0ihx5IUezwL21z0+d3CI?=
 =?us-ascii?Q?r4EhahaFbW3+SQJvsuMTf+MB/mE3zVnNyaVbJiBh0cZbGnnc/Tmn1KXWXIoj?=
 =?us-ascii?Q?EWDb/81zFPbZFcB6A+HLbBEWkpoY9xsOaITR7fK5ouMaRNEt2k94hqslmsPo?=
 =?us-ascii?Q?Z0Lj5u+tlvHVGV4lLmd5CX03ullgzWnH9y8JO9Rc9TDbXg/zlmRTEurK7erQ?=
 =?us-ascii?Q?gBYhFUUKdxyb44eTuHm9N8KItGSdDO79/Z6Ldnj+yqLRWZAn+jODapV1JN1y?=
 =?us-ascii?Q?ltmXjoJieBVDnfs68AooL5Zjnl1aFC3o18imVb9RNr8u4I3J3ZAIN2d7vH1P?=
 =?us-ascii?Q?sfxuVP1xydu2R8fDQj//50qFO1HrTKMXZ9WEELFwUa/64HhOrbEEFIgGlgA1?=
 =?us-ascii?Q?cwyPa43P9aKd+Nid024ExYXxnt6KTNAGQLCyoSvPZ+APmaFG7SB1oOQRsZeO?=
 =?us-ascii?Q?YHQrLWAT9lvApW3S8W/EwqstxJTwXPWqWBLaaPSmCFUIfBwUJZkeEXg+M/88?=
 =?us-ascii?Q?ObwdxnbjlQ6Gq16AFTn53tyBHa1+qPOyj6HMw7orC7aLpx0FPmOhJdt/WbsG?=
 =?us-ascii?Q?UENM1oWD2dYrDNnJtxRCHPwLo9ipfDoEfCPbT4SPhv8eJ1fnZv/I6aKDMR48?=
 =?us-ascii?Q?k1as2Q7qxwxJfn1nwteRO4oIDjSpAOEKn3LGh5UhPTQBw6T0EOXfyAj4Q9yu?=
 =?us-ascii?Q?8VvNKCylC2RTpXWBshgYlSKt6JKMP2Ziru6l2SOaA8/fAx+KP9UL+g2eLwQM?=
 =?us-ascii?Q?jWpbzjSAByKtWA07YSOd21FfeTrpvZHSgB6BfZedF/xAvpnamvBJz6kte2pK?=
 =?us-ascii?Q?gW31rSGMJ8FA3vJAQ0pZFxPzxHJWCZcf10CnEinOQyi3FNq1qgCqrL1TqnxU?=
 =?us-ascii?Q?E4j9pMg9z6Qfeiwx/zdsGWngpqgfju5cC+QnOuz+PM0dwlmSmRIVJVa5V8F5?=
 =?us-ascii?Q?Zwi592HwtIen4Lb7VBYd9+CgEMDO9DYxoXtoADsaAmn5jn4u049t6dGg8kHU?=
 =?us-ascii?Q?Xalj7wU+mg4AW4VeR7H1yhpkGILGXvEGQqVSKC6432fVfaVql2D7DU2Hg+1O?=
 =?us-ascii?Q?ghZsaH5SDi/MmPV0ZEemLDwV/EHxWGDoLNpOttz2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FaYoQySsQsvqScoK7m/0aYvhRoPdV8xqjfoNrSOnYDjnLxz8HGhl540awghM?=
 =?us-ascii?Q?SXOC+SNoRoFPC3KQxnP5vkG0BCGyxNkYtj4VqzO3SVxq8tezqrBxvSHieF6e?=
 =?us-ascii?Q?4kVlANptcJ0Y8FWrluQUkcNAwgoecvmcdUNfqI+A/QeXq9Ano+onpQydW4uD?=
 =?us-ascii?Q?CqqlGp/2N2/vW3F5+mRpTYe97Gd0lb3HpTYI2gP+/JrQa5Ce22cg4KGsraYW?=
 =?us-ascii?Q?5jubv5GjmNVBh6ZX+Ni35Icyk0CvNM/Ke8D/ZTWVaNbBSg/lQBmOB4ydQI65?=
 =?us-ascii?Q?l96JZEB6N9/gVAIHyNRZtVJodGZiKiwXCPxbQZ+tNIFrzifgl275bnfcP2f6?=
 =?us-ascii?Q?WUE2gv+yabPDrXYqr48Fjk84cktBVVU/Z+Hv852NkMG92Gki5TWe/LWhJU0R?=
 =?us-ascii?Q?t0MrNbpx3C0zThGvBv52LfVHwB1xRNkA0uYRXhXy5HZdi18oSfa3tO5005MW?=
 =?us-ascii?Q?ePLGjEZCxnbxStytL4bZMG3utsDTt55KOd3qOwXTvcGUAKYV7gKY5p9AyHqX?=
 =?us-ascii?Q?tHcu3E1RoA2B3rOs+aKS/W4gRxac7625U/ZVZ+M/V5mR0qaZgwdTvygREmpB?=
 =?us-ascii?Q?CE2cUba9pEg9OQDvmfVDskVinLGdztIn7ZiPyCtE9kcUpqQnf7RshKixuodJ?=
 =?us-ascii?Q?XXLN8oV/5F7v5mq4yrXxom44gFVWPjJs0EqNMy6rkgbfgurhBkTdZEwC7I/G?=
 =?us-ascii?Q?tVO3G7kmZ+/7+xikirJp1IxseaxpB16qyU89C+zgI9cvSLM8i5593qX/0mXh?=
 =?us-ascii?Q?1ny/jLEF7ch2YGaMd+nFHTVpKzdWyfrHMerJqdp0/uMvJVglP6RBDxCNgzU6?=
 =?us-ascii?Q?AAKbRmmy077A91rtoSgS4T2FyKXpL4W9XUyPM9miOXqJpdH6d0D0OioCe4BP?=
 =?us-ascii?Q?gHAbJ4OrZrhIJ6ViT2ZengaZW6qX7X8eO0QjWdenstXi7bXE6Ktsg7MMgGtn?=
 =?us-ascii?Q?kKnV73fRZv5oG8vwHOeAEb0mbbWqfj2zW9WTOfnKZqXkEk+v/tLIvArkP2II?=
 =?us-ascii?Q?DgzdXLxSmPeXOQHLPiJjiKfA4gcjDb+Cn5KK+WkXA05xo/5BFUkDOaJrBfhu?=
 =?us-ascii?Q?k8U7YJtC3hQYQUddfodPY6u/ETkeXgBbNkABfgv03RWWFgfbAAK2qFaH/w5s?=
 =?us-ascii?Q?KSlvyv0K5ZiREd2QXxkMmzyuMd3suYgI5UhRcP73YPqUuBH9sD/CwhtwaE9i?=
 =?us-ascii?Q?aCySkoeKmvr34omDGpxIKPxE6FbfEpaiTxoHJwYcF+DAbB65sc9jngmp/H/j?=
 =?us-ascii?Q?ilImZQem3vdenq/f2EhPCyTBILOiOQvsdbwtdoTelnrZRbgMOPV+FTo47jnv?=
 =?us-ascii?Q?3VFsOkJsr4cg/l7ovDQDovUjL4a58nBXJbensGUg10pIs/76Y/g3rRRpyZ2k?=
 =?us-ascii?Q?iZUFFzX4MclT78a2HO8qoKUHjKtGnKCFV4YQLO8RoJetjodcJ5dm+6YO8T97?=
 =?us-ascii?Q?G5AUbNj/6A4+rxNWnz7yGyyA0P7CRv73Tn0YLW1gv68A6bOxY6wm96wu6HMf?=
 =?us-ascii?Q?fHwfFOjspmVgEETtZyO2O6nnBxFRDTxpNMfslSDi0SNy0dfqwsdBhVfCN3Td?=
 =?us-ascii?Q?bPC0feQEvGlKPpmHqw2r91ugP3o90kRzZjWiUxipPMZRmO494LBarCUKVLKF?=
 =?us-ascii?Q?oufDXBZethG3RNFIJjzxXQrwZDKtm59UM8ktgjHjolkEFEf1NHyDSD2J/7Bt?=
 =?us-ascii?Q?cc5NBgaUBlAREfGqhuCm9hvP5nL72lJv85fx1aFUbC4pKFqbdQJul40Di8X2?=
 =?us-ascii?Q?ZrXUdzgphw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 732bcd4c-1999-48f6-2ab7-08de6a415c20
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 14:16:48.5756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4URSfh/xOoZKKkdHuiLvjEa+lu/sNSf1dvPfg1hdQf9uaQ7H0VNFJRSxepnheYly5QNXfu+e/JdC+Z64ERaHtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7892
X-OriginatorOrg: intel.com


Hello,


for new added "test addr2line inline unwinding", we found it failed consistently
in our tests. not sure if we miss any dependency. below report is FYI.


kernel test robot noticed "perf-sanity-tests.test_addr2line_inline_unwinding.fail" on:

commit: 54a23bff770961e024e2c61cd1f46888190c3e79 ("perf test: Test addr2line unwinding works with inline functions")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master


in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: clang
	group: group-02



config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 20 threads 1 sockets (Commet Lake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202602122137.a1396559-lkp@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260212/202602122137.a1396559-lkp@intel.com


2026-02-10 04:50:32 sudo ASAN_OPTIONS=fast_unwind_on_malloc=0 /usr/src/linux-perf-x86_64-rhel-9.4-bpf-54a23bff770961e024e2c61cd1f46888190c3e79/tools/perf/perf test 76 -v
 76: test addr2line inline unwinding                                 : Running (1 active)
--- start ---
test child forked, pid 11320
Inline unwinding verification test
[ perf record: Woken up 136 times to write data ]
[ perf record: Captured and wrote 33.858 MB /tmp/perf-test-inline-addr2line.v74NZkItW4/perf.data (4206 samples) ]

=================================================================
==11324==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 61808 byte(s) in 8 object(s) allocated from:
    #0 0x7fb5922e0610 in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7fb5920c1808  (/lib/x86_64-linux-gnu/libelf.so.1+0x3808) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
    #2 0x7fb5920c25f9  (/lib/x86_64-linux-gnu/libelf.so.1+0x45f9) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
    #3 0x5560ff9ea997 in symsrc__init util/symbol-elf.c:1164
    #4 0x5560ff56702e in dso__load util/symbol.c:1795
    #5 0x5560ff5fb064 in map__load util/map.c:351
    #6 0x5560ff5fb44b in map__find_symbol util/map.c:385
    #7 0x5560ff47a46d in thread__find_symbol util/event.c:725
    #8 0x5560ffa84913 in __report_module util/unwind-libdw.c:54
    #9 0x5560ffa85240 in report_module util/unwind-libdw.c:117
    #10 0x5560ffa86a99 in frame_callback util/unwind-libdw.c:248
    #11 0x7fb59206dae2 in dwfl_thread_getframes (/lib/x86_64-linux-gnu/libdw.so.1+0x78ae2) (BuildId: bafe9cb5bbbe6cee778d0d137730ea5c223d553e)
    #12 0x7fb59206de53 in dwfl_getthread_frames (/lib/x86_64-linux-gnu/libdw.so.1+0x78e53) (BuildId: bafe9cb5bbbe6cee778d0d137730ea5c223d553e)
    #13 0x5560ffa8763d in unwind__get_entries util/unwind-libdw.c:307
    #14 0x5560ff5f2dde in thread__resolve_callchain_unwind util/machine.c:2977
    #15 0x5560ff5f2f32 in __thread__resolve_callchain util/machine.c:3004
    #16 0x5560ff5c80c0 in sample__for_each_callchain_node util/callchain.c:1818
    #17 0x5560ff4132c6 in build_id__mark_dso_hit util/build-id.c:77
    #18 0x5560fef31015 in process_sample_event /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-54a23bff770961e024e2c61cd1f46888190c3e79/tools/perf/builtin-record.c:1504
    #19 0x5560ff61d75e in evlist__deliver_sample util/session.c:1276
    #20 0x5560ff61f490 in machines__deliver_event util/session.c:1432
    #21 0x5560ff6210b1 in perf_session__deliver_event util/session.c:1523
    #22 0x5560ff60c775 in ordered_events__deliver_event util/session.c:134
    #23 0x5560ff64a011 in do_flush util/ordered-events.c:245
    #24 0x5560ff64aeb6 in __ordered_events__flush util/ordered-events.c:324
    #25 0x5560ff64b3c7 in ordered_events__flush util/ordered-events.c:342
    #26 0x5560ff617d42 in perf_event__process_finished_round util/session.c:787
    #27 0x5560ff621c1d in perf_session__process_user_event util/session.c:1583

Direct leak of 4424 byte(s) in 1 object(s) allocated from:
    #0 0x7fb5922e0610 in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x7fb5920c1808  (/lib/x86_64-linux-gnu/libelf.so.1+0x3808) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
    #2 0x7fb5920c25f9  (/lib/x86_64-linux-gnu/libelf.so.1+0x45f9) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
    #3 0x5560ff9ea997 in symsrc__init util/symbol-elf.c:1164
    #4 0x5560ff56702e in dso__load util/symbol.c:1795
    #5 0x5560ff5fb064 in map__load util/map.c:351
    #6 0x5560ff5fb44b in map__find_symbol util/map.c:385
    #7 0x5560ff47a46d in thread__find_symbol util/event.c:725
    #8 0x5560ffa84913 in __report_module util/unwind-libdw.c:54
    #9 0x5560ffa85240 in report_module util/unwind-libdw.c:117
    #10 0x5560ffa874ca in unwind__get_entries util/unwind-libdw.c:299
    #11 0x5560ff5f2dde in thread__resolve_callchain_unwind util/machine.c:2977
    #12 0x5560ff5f2f32 in __thread__resolve_callchain util/machine.c:3004
    #13 0x5560ff5c80c0 in sample__for_each_callchain_node util/callchain.c:1818
    #14 0x5560ff4132c6 in build_id__mark_dso_hit util/build-id.c:77
    #15 0x5560fef31015 in process_sample_event /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-54a23bff770961e024e2c61cd1f46888190c3e79/tools/perf/builtin-record.c:1504
    #16 0x5560ff61d75e in evlist__deliver_sample util/session.c:1276
    #17 0x5560ff61f490 in machines__deliver_event util/session.c:1432
    #18 0x5560ff6210b1 in perf_session__deliver_event util/session.c:1523
    #19 0x5560ff60c775 in ordered_events__deliver_event util/session.c:134
    #20 0x5560ff64a011 in do_flush util/ordered-events.c:245
    #21 0x5560ff64aeb6 in __ordered_events__flush util/ordered-events.c:324
    #22 0x5560ff64b3c7 in ordered_events__flush util/ordered-events.c:342
    #23 0x5560ff617d42 in perf_event__process_finished_round util/session.c:787
    #24 0x5560ff621c1d in perf_session__process_user_event util/session.c:1583
    #25 0x5560ff6249ac in perf_session__process_event util/session.c:1805
    #26 0x5560ff62c265 in process_simple util/session.c:2399
    #27 0x5560ff62b225 in reader__read_event util/session.c:2328

Indirect leak of 18368 byte(s) in 8 object(s) allocated from:
    #0 0x7fb5922e0c57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x7fb5920c9550  (/lib/x86_64-linux-gnu/libelf.so.1+0xb550) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
    #2 0x7fb5920ca517  (/lib/x86_64-linux-gnu/libelf.so.1+0xc517) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
    #3 0x7fb5920ca0b1 in elf_rawdata (/lib/x86_64-linux-gnu/libelf.so.1+0xc0b1) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
    #4 0x5560ff9e0c10 in elf_section_by_name util/symbol-elf.c:193
    #5 0x5560ff9e9ae1 in read_gnu_debugdata util/symbol-elf.c:1086
    #6 0x5560ff9eaac5 in symsrc__init util/symbol-elf.c:1173
    #7 0x5560ff56702e in dso__load util/symbol.c:1795
    #8 0x5560ff5fb064 in map__load util/map.c:351
    #9 0x5560ff5fb44b in map__find_symbol util/map.c:385
    #10 0x5560ff47a46d in thread__find_symbol util/event.c:725
    #11 0x5560ffa84913 in __report_module util/unwind-libdw.c:54
    #12 0x5560ffa85240 in report_module util/unwind-libdw.c:117
    #13 0x5560ffa86a99 in frame_callback util/unwind-libdw.c:248
    #14 0x7fb59206dae2 in dwfl_thread_getframes (/lib/x86_64-linux-gnu/libdw.so.1+0x78ae2) (BuildId: bafe9cb5bbbe6cee778d0d137730ea5c223d553e)
    #15 0x7fb59206de53 in dwfl_getthread_frames (/lib/x86_64-linux-gnu/libdw.so.1+0x78e53) (BuildId: bafe9cb5bbbe6cee778d0d137730ea5c223d553e)
    #16 0x5560ffa8763d in unwind__get_entries util/unwind-libdw.c:307
    #17 0x5560ff5f2dde in thread__resolve_callchain_unwind util/machine.c:2977
    #18 0x5560ff5f2f32 in __thread__resolve_callchain util/machine.c:3004
    #19 0x5560ff5c80c0 in sample__for_each_callchain_node util/callchain.c:1818
    #20 0x5560ff4132c6 in build_id__mark_dso_hit util/build-id.c:77
    #21 0x5560fef31015 in process_sample_event /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-54a23bff770961e024e2c61cd1f46888190c3e79/tools/perf/builtin-record.c:1504
    #22 0x5560ff61d75e in evlist__deliver_sample util/session.c:1276
    #23 0x5560ff61f490 in machines__deliver_event util/session.c:1432
    #24 0x5560ff6210b1 in perf_session__deliver_event util/session.c:1523
    #25 0x5560ff60c775 in ordered_events__deliver_event util/session.c:134
    #26 0x5560ff64a011 in do_flush util/ordered-events.c:245
    #27 0x5560ff64aeb6 in __ordered_events__flush util/ordered-events.c:324

Indirect leak of 3203 byte(s) in 8 object(s) allocated from:
    #0 0x7fb5922e0c57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x7fb5920ca3fa  (/lib/x86_64-linux-gnu/libelf.so.1+0xc3fa) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
    #2 0x7fb5920ca0b1 in elf_rawdata (/lib/x86_64-linux-gnu/libelf.so.1+0xc0b1) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
    #3 0x5560ff9e0c10 in elf_section_by_name util/symbol-elf.c:193
    #4 0x5560ff9e9ae1 in read_gnu_debugdata util/symbol-elf.c:1086
    #5 0x5560ff9eaac5 in symsrc__init util/symbol-elf.c:1173
    #6 0x5560ff56702e in dso__load util/symbol.c:1795
    #7 0x5560ff5fb064 in map__load util/map.c:351
    #8 0x5560ff5fb44b in map__find_symbol util/map.c:385
    #9 0x5560ff47a46d in thread__find_symbol util/event.c:725
    #10 0x5560ffa84913 in __report_module util/unwind-libdw.c:54
    #11 0x5560ffa85240 in report_module util/unwind-libdw.c:117
    #12 0x5560ffa86a99 in frame_callback util/unwind-libdw.c:248
    #13 0x7fb59206dae2 in dwfl_thread_getframes (/lib/x86_64-linux-gnu/libdw.so.1+0x78ae2) (BuildId: bafe9cb5bbbe6cee778d0d137730ea5c223d553e)
    #14 0x7fb59206de53 in dwfl_getthread_frames (/lib/x86_64-linux-gnu/libdw.so.1+0x78e53) (BuildId: bafe9cb5bbbe6cee778d0d137730ea5c223d553e)
    #15 0x5560ffa8763d in unwind__get_entries util/unwind-libdw.c:307
    #16 0x5560ff5f2dde in thread__resolve_callchain_unwind util/machine.c:2977
    #17 0x5560ff5f2f32 in __thread__resolve_callchain util/machine.c:3004
    #18 0x5560ff5c80c0 in sample__for_each_callchain_node util/callchain.c:1818
    #19 0x5560ff4132c6 in build_id__mark_dso_hit util/build-id.c:77
    #20 0x5560fef31015 in process_sample_event /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-54a23bff770961e024e2c61cd1f46888190c3e79/tools/perf/builtin-record.c:1504
    #21 0x5560ff61d75e in evlist__deliver_sample util/session.c:1276
    #22 0x5560ff61f490 in machines__deliver_event util/session.c:1432
    #23 0x5560ff6210b1 in perf_session__deliver_event util/session.c:1523
    #24 0x5560ff60c775 in ordered_events__deliver_event util/session.c:134
    #25 0x5560ff64a011 in do_flush util/ordered-events.c:245
    #26 0x5560ff64aeb6 in __ordered_events__flush util/ordered-events.c:324
    #27 0x5560ff64b3c7 in ordered_events__flush util/ordered-events.c:342

Indirect leak of 1280 byte(s) in 1 object(s) allocated from:
    #0 0x7fb5922e0c57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x7fb5920c9550  (/lib/x86_64-linux-gnu/libelf.so.1+0xb550) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
    #2 0x7fb5920ca517  (/lib/x86_64-linux-gnu/libelf.so.1+0xc517) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
    #3 0x7fb5920ca0b1 in elf_rawdata (/lib/x86_64-linux-gnu/libelf.so.1+0xc0b1) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
    #4 0x5560ff9e0c10 in elf_section_by_name util/symbol-elf.c:193
    #5 0x5560ff9e9ae1 in read_gnu_debugdata util/symbol-elf.c:1086
    #6 0x5560ff9eaac5 in symsrc__init util/symbol-elf.c:1173
    #7 0x5560ff56702e in dso__load util/symbol.c:1795
    #8 0x5560ff5fb064 in map__load util/map.c:351
    #9 0x5560ff5fb44b in map__find_symbol util/map.c:385
    #10 0x5560ff47a46d in thread__find_symbol util/event.c:725
    #11 0x5560ffa84913 in __report_module util/unwind-libdw.c:54
    #12 0x5560ffa85240 in report_module util/unwind-libdw.c:117
    #13 0x5560ffa874ca in unwind__get_entries util/unwind-libdw.c:299
    #14 0x5560ff5f2dde in thread__resolve_callchain_unwind util/machine.c:2977
    #15 0x5560ff5f2f32 in __thread__resolve_callchain util/machine.c:3004
    #16 0x5560ff5c80c0 in sample__for_each_callchain_node util/callchain.c:1818
    #17 0x5560ff4132c6 in build_id__mark_dso_hit util/build-id.c:77
    #18 0x5560fef31015 in process_sample_event /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-54a23bff770961e024e2c61cd1f46888190c3e79/tools/perf/builtin-record.c:1504
    #19 0x5560ff61d75e in evlist__deliver_sample util/session.c:1276
    #20 0x5560ff61f490 in machines__deliver_event util/session.c:1432
    #21 0x5560ff6210b1 in perf_session__deliver_event util/session.c:1523
    #22 0x5560ff60c775 in ordered_events__deliver_event util/session.c:134
    #23 0x5560ff64a011 in do_flush util/ordered-events.c:245
    #24 0x5560ff64aeb6 in __ordered_events__flush util/ordered-events.c:324
    #25 0x5560ff64b3c7 in ordered_events__flush util/ordered-events.c:342
    #26 0x5560ff617d42 in perf_event__process_finished_round util/session.c:787
    #27 0x5560ff621c1d in perf_session__process_user_event util/session.c:1583

Indirect leak of 190 byte(s) in 1 object(s) allocated from:
    #0 0x7fb5922e0c57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x7fb5920ca3fa  (/lib/x86_64-linux-gnu/libelf.so.1+0xc3fa) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
    #2 0x7fb5920ca0b1 in elf_rawdata (/lib/x86_64-linux-gnu/libelf.so.1+0xc0b1) (BuildId: d6a40be9eadcbcb0562b7bb13bbe81166e82cc40)
    #3 0x5560ff9e0c10 in elf_section_by_name util/symbol-elf.c:193
    #4 0x5560ff9e9ae1 in read_gnu_debugdata util/symbol-elf.c:1086
    #5 0x5560ff9eaac5 in symsrc__init util/symbol-elf.c:1173
    #6 0x5560ff56702e in dso__load util/symbol.c:1795
    #7 0x5560ff5fb064 in map__load util/map.c:351
    #8 0x5560ff5fb44b in map__find_symbol util/map.c:385
    #9 0x5560ff47a46d in thread__find_symbol util/event.c:725
    #10 0x5560ffa84913 in __report_module util/unwind-libdw.c:54
    #11 0x5560ffa85240 in report_module util/unwind-libdw.c:117
    #12 0x5560ffa874ca in unwind__get_entries util/unwind-libdw.c:299
    #13 0x5560ff5f2dde in thread__resolve_callchain_unwind util/machine.c:2977
    #14 0x5560ff5f2f32 in __thread__resolve_callchain util/machine.c:3004
    #15 0x5560ff5c80c0 in sample__for_each_callchain_node util/callchain.c:1818
    #16 0x5560ff4132c6 in build_id__mark_dso_hit util/build-id.c:77
    #17 0x5560fef31015 in process_sample_event /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-54a23bff770961e024e2c61cd1f46888190c3e79/tools/perf/builtin-record.c:1504
    #18 0x5560ff61d75e in evlist__deliver_sample util/session.c:1276
    #19 0x5560ff61f490 in machines__deliver_event util/session.c:1432
    #20 0x5560ff6210b1 in perf_session__deliver_event util/session.c:1523
    #21 0x5560ff60c775 in ordered_events__deliver_event util/session.c:134
    #22 0x5560ff64a011 in do_flush util/ordered-events.c:245
    #23 0x5560ff64aeb6 in __ordered_events__flush util/ordered-events.c:324
    #24 0x5560ff64b3c7 in ordered_events__flush util/ordered-events.c:342
    #25 0x5560ff617d42 in perf_event__process_finished_round util/session.c:787
    #26 0x5560ff621c1d in perf_session__process_user_event util/session.c:1583
    #27 0x5560ff6249ac in perf_session__process_event util/session.c:1805

SUMMARY: AddressSanitizer: 89273 byte(s) leaked in 27 allocation(s).
Unexpected signal in test_inlinedloop
---- end(-1) ----
 76: test addr2line inline unwinding                                 : FAILED!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

