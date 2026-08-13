Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1F63EA97B;
	Thu, 13 Aug 2026 05:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786599156; cv=fail; b=Eq5dOg/ZlemK4F85F7cvc5DshnFcqw4zG5p7GfI9KCjqvK8bGVays/JrZnLEdN1blpSCc2zL0AFIuJMlivzfloQEVlwO6sl06Fw4pQh3EPP4abtXMC/1qMDmYpO3vOgvHpYqjGz2hgPFlmAHJjr6iOyxRLSWtkHCtWUX5J9uX/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786599156; c=relaxed/simple;
	bh=jcYbOZIbv5zQftU4tJKxCQR0+LQgPWHlEh9Dv683jy4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CSCMm86Zomf3184UHhUTCreoDo8ZtMTuw6tv7CAlqcTvfdBNJ814wRPagRZQ1n5ZkcS2yOhrs5YgIvgvZEBAi5wFEHxZ7mZQy9dZs8RzCSGDnxV2/J0Wj9KvavTzNIkwRFl2PESkWpinOh27egYJTAkcXbOkHHJVlWuVygjw2NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZaXsXHlC; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZaXsXHlC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786599153; x=1818135153;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jcYbOZIbv5zQftU4tJKxCQR0+LQgPWHlEh9Dv683jy4=;
  b=ZaXsXHlCgyMuTmFOe24Fns+GZnuyK7rtbIZwhWEWFTDSh697R+nb8BJH
   tjKbzB4K8z4AgtYK7QTdXzfk//GY/k008baoS2o/HBWbNMx8uINUOy4sw
   fpWiSBIZ4S2AkmcbN0tjUfex5okuxKCSAxwSj0H+ICajVe92J3kerWiH0
   o4M4kkYWG3jdZDkB4FQ9Frck8KFwduN7qjWz8gvMa0PujuCOw4/uKcf/q
   qkGyhA3Q/cJ6kN2VBCTMC4ec9J4jGyQcIUhlAH2YYZGqgTfMsqgh6NB32
   xrcJxT2i9RfnG5FlgCpko7f2UDABSRBUfWva2kkXnJ6vYWm7zOVZs/fdP
   A==;
X-CSE-ConnectionGUID: CYz8omWEQle/eNiBZc5JOA==
X-CSE-MsgGUID: NzeByJlJR3K6/MGI2z/23w==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="98316104"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="98316104"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 22:32:30 -0700
X-CSE-ConnectionGUID: gMUL2A09QWCWuEBs67G7yw==
X-CSE-MsgGUID: BOsGnHhpQLe8/hY82y1fOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="260023595"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 22:32:30 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 22:32:29 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 22:32:29 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.53) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 22:32:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzFLJDTV6Ye5+X5W98RX7AiEijvIAlf++6SeXhJP2zhfT1zMimB7mWjS4fW0Lfu4MJPNZZN7jK5DpQ5bo0+XQ7tPjF2Ve0cD34uSA6QPby4sT4+GvFYEKM3mUUEGaZGgwS31NGaw/j5e+T1haNvz1+r35nMbK2tgEa8MPHYgLmLIqhLjerKvBATZEWj4CVexSOc5YIhekOJITCcTVhljETuHxJXHKSv59fyE/mD4YlxPix+wXuHpXQpZalz87swusk0rMzMUG2R26qaISno7+PHeVrGPEwHqAz6GnYsSSR4PkFnQBtGcwibpsJ9ydfo6NllUPgGWwPGIY7nthUzU1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lGjD934bP7ofsDQaGsDpItWfpCxq+9jmOAaKjsXWWU=;
 b=mw5XJ0n5qsqk40n4ltLWL2MxAv72fshs7nP5Rqkt0EvPDEWoF+QANIj+g1SwRR7yPyaTp7M3Q4MqbYZYWtSIksUoubj9ITa53GsUc3jRT9ILKzMnQmhpEqrBApMOMuGXlrZPAO6tnoyfPUXln++keBoToJaTYvBwugFygbpXBuoZB7zoZKdGkjpPkkFsHjwXzU8q04AI94fqMVQQLpII8BUf3O5TFMWimC6SaWxaPx+QGCJ3ppq8iXQ4y+/HjSnFQ2q9xlpD/1xwKl0PsVDY+CsS80+P1PzCiyguDARKjK/ZeeUyneFRbu/dpuGgGHq6LF7wWhCxhEPFEMtHsxLphw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 05:32:23 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 05:32:23 +0000
Message-ID: <d2dad6a6-569b-4979-9d9c-b377fe8d9a6e@intel.com>
Date: Thu, 13 Aug 2026 08:32:16 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] perf thread-stack: Report branch stack hw_idx as not
 available
To: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Amir Ayupov <aaupov@fb.com>, <linux-perf-users@vger.kernel.org>,
	<coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>, "Suzuki
 K Poulose" <suzuki.poulose@arm.com>, James Clark <james.clark@linaro.org>,
	"Leo Yan" <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, John Garry <john.g.garry@oracle.com>, "Will
 Deacon" <will@kernel.org>, <linux-doc@vger.kernel.org>, Mike Leach
	<mike.leach@arm.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Swapnil Sapkal <swapnil.sapkal@amd.com>
References: <20260803090640.2412336-1-aaupov@fb.com>
 <20260803090640.2412336-2-aaupov@fb.com>
 <544211a6-29c5-49ab-b9f9-543f199b9533@intel.com>
 <83378be0-1e89-4e31-94a4-ba083f0f7c8c@intel.com> <anyZgnHNV_P3fqbe@x1>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <anyZgnHNV_P3fqbe@x1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0031.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::10) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS0PR11MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 249bf7f3-7a90-4321-1214-08def8fc405a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: fbgGWongOLZ29d1ck7IXvAXHMTyqOReqvLtu3lRk/K6DzzD6uufRUYQ6uFDiw4742D26JPZRFD4KqByZHyeuxw+qVU06/f1+G/+5CuHYLtFMgefY2Zw0s+no0JXmLFFNoAe+muYnelDvbNDoY2TEEYy/Hl6ktXpKIKC+C0iKKXuFyclMUN5dauBq8b48HnvvUOVelOf9l2s0S1H0Wh/qDUEHY9xcYpEfiLPvB9nbbjr3vv9TddDMjmgsBhpYHNJso7yg7UjTEHq3rfSCVymy6W4ReaTT8KXPaFq5kcCAhzyBwLuyWIMKUm6rzeShFzS0v9Lg3XFvcbWhtyDQzo2s7GJioRKz6sqkaVw8h1MjHvD1YAvqMqUiaNk/HGtSj6ywgdsUAP4So1kW11TVnXfRMyxrm/FAwqs3cuboB0VBw809wZTgmEhP3pyRAVxBABEl/Vt7hCja/X05qsImjHDQYGZ7Brg5Oso0hVaiJROQr1h4U6r1MKG+eNhiVPa7FdG0lR5T7bZJj468+GoSoS0oANIJkC88j/JkMNvjyFGP8WcKtN/0s3b3+mxzjBFgOsgjc0eQbP6sAh/H98nZ7pUlnzKgzRLX62EriSEuPkz8HR3/0P5wxaeAd4zhQmrkLuCeY+etyuFgL+lv1vwp0wrkL8edvNSXaV6eyL9elkmOR8s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTNHeVVBR2FvaWZDS2pTWnBhcDlMemNUY0djU3RYS2FjSnU0bFBBNTVmaUF6?=
 =?utf-8?B?RDBWZ1NTdGJRdUJhVnNDSXdrRjRDQ1BFeVJsem9yYk1aOWlHdDY0V2dkRXRI?=
 =?utf-8?B?eGhDS2N4Z0R0Z0l5bDBBVzJncEtwbkdTYUk5d0tLQVNoTENjSTZDdms0alkx?=
 =?utf-8?B?NlJFeEc5cnpvaHhOMU9GbHZOK3FHWmpVVjQ4L0FobDQ2by9jNGdBcy96Ym00?=
 =?utf-8?B?Wm1RakJpSENlZDBZN2dRY1hTcjd6RkVMZVE3SmNaODBnUGVyVmorSzY0OUx0?=
 =?utf-8?B?OFZFMGk4Z2JPQ3owb1l0N29YT05zVktMRlgyWHZrNStFc2NTQWtkb0xrVXJt?=
 =?utf-8?B?SWtPUUFWZjc2WTNoYUZSUS9xbWRiNXNkSmV0SXd2RjZVNDRSOWU3WWFlTlVL?=
 =?utf-8?B?ZHNOemZnekorVG8xVWR2K1p6clBVL1BFbDZZM285ZmQ0UWZyNk9hYjNnZGpW?=
 =?utf-8?B?YzZUbkx6VmNqWTdkVEZJbHJuWnBxbVJtdzFENlVnMUJ6SUhnQmtoaFMwRThL?=
 =?utf-8?B?MmdSZS9jUVBTWG1jSlV6c0RRSXJVaGhzTXdkYVpUd3JQcDJ6WmlyQnJ4czBW?=
 =?utf-8?B?S0daQmxVK09HRnRLOEdsU3JzWld5L2Z0ZnNTUzdMMk9CcHN2Vm5wTkRZMVdu?=
 =?utf-8?B?Z1p2WGwvcXYwRWgzaENEbUJEdGZiNGM0RzFxYUZCYXd5MTBVWFl5VG1GejJR?=
 =?utf-8?B?dnB2VWhud2h1aUdKT0NSa3A0ajhreU4rZkVNOUxWeHRGaEtMc1JPUURhSHVy?=
 =?utf-8?B?cm1EbVlsVFd1Sy9TSlJjNlVEUHkvV1lUMHF4dDFoTGRSN0kxdjVFak5NOUVp?=
 =?utf-8?B?Q2xUdUE3MkRjT2xSSHozM0I5TGZKWHBwdHg2eTFITHM5VGY5TEtsTnphK0Fo?=
 =?utf-8?B?RVFRc3l2MFVPdmJNUzN1d0VuS2hWNUdqa0NubzhkTkM0ZFlnSlFWN3Z1WmpI?=
 =?utf-8?B?OC9QQml1c0d3NFZKbS9pVFYxenZnVUVIZy9qOVliaFBmdzZPeks2cHlaMUhL?=
 =?utf-8?B?d3RDcHo1RzRJMFBpNysybjFoNWVDNjlzNEZwZmdscGRXZjZzK2VmWHYxR0tD?=
 =?utf-8?B?SXJPU1RLamFUd2pWcVFhSXVPc1pDcVZ5MS91WjFKdFphOUs3akFCMUE0TmFZ?=
 =?utf-8?B?Z09VaitUY3JlaVNqRWpZMHJiWUhONHdEaTY5Y1V5R0twcUorR1c0ancyN0xh?=
 =?utf-8?B?TFJpdG9WNjJGcUZJZHM2dmlLZ3pUbUpVWFdWZS9vWktVSHJzTlJna1VxRzNk?=
 =?utf-8?B?WFpZbTFSQUorV2tyejI4T3lpY1dqaHh6R0Zmd0Q0ZWtRSzBtaDNCakR5aW53?=
 =?utf-8?B?Mkl5NEJxK2FaQTVSY3NoSXI4eTEyV1lMcnBIbUJKNUJsK2hKblhxdDlTQWVN?=
 =?utf-8?B?ZytNRUw3cW5sR25HMS9NblJIQmFIOTBwV1lyVktLaTFwVGROZkF0SWhWQUJK?=
 =?utf-8?B?RlFmY2dhaVZJMTcrdVJ5WUNhb1RaVW5tcVl6TXlzc1d3RDFUMTRoREd5R2xt?=
 =?utf-8?B?cEdLS2VuZmxhYmNwVm4yZkI2eGFnL3gyd2lIdVJnSWI1blBmOWlpeWJQbzZC?=
 =?utf-8?B?NFVXTS9Nby9YMzFwRys0bCt1Q1Y5b0hVd0ZxU2Z3WjNoN2g3MGREdmNTbHpY?=
 =?utf-8?B?Tnd5eE9lYjErRmZBTTdCV2gyS2ZscGloU3NEcy9yNnZxTGx3b0hWTGNLMUZj?=
 =?utf-8?B?RWNSd0RBMFpEdWM0ZnRoV2JhSHNEUEVXNTR3TjdPVVhtQStHRGlsdnpKOUFH?=
 =?utf-8?B?bUJGTURuRVpnZzVPT2NIY0h4VEUyM1VqTFRIWHpENE5VVzQ0UXozS3UzbmZO?=
 =?utf-8?B?MGJSSWhFYmtUYjlYSXNiRitEb09pYjZOcXJKYWdPdHdVbzBHZUNHcnRTajVG?=
 =?utf-8?B?bzJUTjQ0SmpFaklzeENTYnhaZ09xa3dmRVJRNlJQaTFLQ3RQb0R6cCtXOWlR?=
 =?utf-8?B?b09Xcld5YXdSaWh1MStIN2xBY2M3QkV6Q2pSRnN4aHQ4ZytkRUV0azZoOFNh?=
 =?utf-8?B?aFQ3cTFoSDJvQVdlUStXQ3FDdktWbjdEQzl0MFgvT2xhNHFHekVxVHFyTG4y?=
 =?utf-8?B?UzJ0ZkRjM2t4bzZnMG1OK3pIREpOK1dzNXNhOEJoWU1hdGZkalJ4eStjV1NN?=
 =?utf-8?B?elBnL3NSb2JGV0hRTDhiUTZWelVVcHBIYUxKTjd4N1JTR3hoWDZEczZhMXVS?=
 =?utf-8?B?aEN2UzhrNUxVMHBUT0lJWm1zbGZjNmhFRWY1K0ttdFFPNTFCam1DV2FLMnBj?=
 =?utf-8?B?ZDBubTN2eGFoUWxvUUxIZGxsbFV6QlZuTEF1QWdIWEczNWlUSVhueXhoZk1s?=
 =?utf-8?B?Tkh2MlRKY1R5V0VoSXpuaXZXZnQwUFNoOEZNQktobjhWNlVzWjU2czUvdkQv?=
 =?utf-8?Q?9sUapLH4P+ZZzUEc=3D?=
X-Exchange-RoutingPolicyChecked: C4VwsPnv3g6l9z4AnRog/zhGeUc5F35/0wfDQM5GrV2pCLO0UXxVB7r511kBMab6FZxKtcwqkLJ7NjqeQSO6R4XMQ4su8agwSTkS9E/TQFQLsIhIKTbnX8Aiu4FDj/ILYNcHTYw2USi5vCObUBEJocWM2ftndU8qBUpScMM/7QkW/jmFTfDacWlrAhJnN0rJEt8JSrEMKsvWHFF9a7RxPnQZyR6QMkO4Ijt3aY+o0WHHKj399ERM16LO+IoXVYJ8pZ4fc3xVwn9zY0h0XCby8sWAH/qgcN2y4mKIHkjwFosn+ISD6fUtwhUMuDPSdDd0SWD/5xagexAVxvz1MNrD1g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 249bf7f3-7a90-4321-1214-08def8fc405a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 05:32:23.0986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HgJTu8X49XXTaAupJ5m46mHoRX1gwaZMwkFZ6uHteKyjVqSTCIy0aRqC+9Ye8VsPaT5lykIC19F32Xy1ES7CTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7997
X-OriginatorOrg: intel.com

On 12/08/2026 19:04, Arnaldo Carvalho de Melo wrote:
> On Wed, Aug 12, 2026 at 06:48:24PM +0300, Adrian Hunter wrote:
>> On 11/08/2026 18:58, Adrian Hunter wrote:
>>> On 03/08/2026 12:06, Amir Ayupov wrote:
>>>> thread_stack__br_sample() and thread_stack__br_sample_late() fill a
>>>> caller-supplied branch_stack that is typically allocated with zalloc(),
>>>> leaving hw_idx as 0. Zero is a valid hardware index, so consumers that
>>>> honour PERF_SAMPLE_BRANCH_HW_INDEX see a reconstructed branch stack
>>>> claiming to start at LBR TOS entry 0.
>>>>
>>>> These branch stacks are reconstructed from instruction trace and have no
>>>> hardware index at all. Set hw_idx to -1ULL, which is the established way
>>>> to say "not available" and matches what intel-pt and cs-etm already put
>>>> in the branch stacks they synthesise directly.
>>>>
>>>> Signed-off-by: Amir Ayupov <aaupov@fb.com>
>>>
>>> Fixes tag?
>>>
>>> Otherwise:
>>>
>>> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
>>
>> On second thoughts, it seems that hw_idx is only used for stitching
>> LBRs which is anyway disabled by default and only enabled by --stitch-lbr.
>>
>> Setting -1ULL will prevent has_stitched_lbr() making a match, but we can
>> rely on the user to decide that for themselves via --stitch-lbr.
> 
> This is one of those options that few people use as its so specialized,
> do you think we could auto-enable it if we notice it is a good idea for
> some specific machine and request from the user? I.e. user requests
> callchains, unlimited or with a limit that is more than what we can do
> without stitching: we auto stich?

For hardware LBRs, stitching is guesswork, so the option
helps users to be informed about that:

  --stitch-lbr

  Show callgraph with stitched LBRs, which may have more complete callgraph. The 
  perf.data file must have been obtained using perf record --call-graph lbr. 
  Disabled by default. In common cases with call stack overflows, it can recreate 
  better call stacks than the default lbr call stack output. But this approach is 
  not foolproof. There can be cases where it creates incorrect call stacks from 
  incorrect matches. The known limitations include exception handing such as 
  setjmp/longjmp will have calls/returns not match.

For auxtrace, the perf thread_stack implementation can accumulate
arbitrarily large branch stacks or call stacks, so stitching
doesn't seem to make much sense in that case.

> 
> - Arnaldo
>  
>> So, in fact, it doesn't look like this change should be needed?
>>
>>>
>>>> ---
>>>>  tools/perf/util/thread-stack.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
>>>> index c5ce741b07446..1a3dffa83bde2 100644
>>>> --- a/tools/perf/util/thread-stack.c
>>>> +++ b/tools/perf/util/thread-stack.c
>>>> @@ -624,6 +624,7 @@ void thread_stack__br_sample(struct thread *thread, int cpu,
>>>>  	unsigned int nr;
>>>>  
>>>>  	dst->nr = 0;
>>>> +	dst->hw_idx = -1ULL;
>>>>  
>>>>  	if (!ts)
>>>>  		return;
>>>> @@ -686,6 +687,7 @@ void thread_stack__br_sample_late(struct thread *thread, int cpu,
>>>>  	bool start = false;
>>>>  
>>>>  	dst->nr = 0;
>>>> +	dst->hw_idx = -1ULL;
>>>>  
>>>>  	if (!ts)
>>>>  		return;
>>>

