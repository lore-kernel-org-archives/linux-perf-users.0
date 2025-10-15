Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62550347C7;
	Wed, 15 Oct 2025 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546970; cv=fail; b=sT8WxmC9ll5Ac1ds3uIDa20ao5Amak/EULQYNIdnZ3AEw4u0Lp8o6fgGLcJ7T/P4gNDdSvwuFe0HaiSoslaVZNLu4qeISz0FZdAXsH3++x/D+otVNHsr7H+1xd3NnjuiQ3fhVclZz55yADogoQUwyCNjAlLNZj6GHmd0G19KQv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546970; c=relaxed/simple;
	bh=/vJ80utcH8tgW3v7Gm4xUJeaDuw1WA/F4dSEbW5wvHM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qIX6MSy77sl95whAZsJz2jmCzin0aoVY6QYRjDPdRgG4EimypOeFECY6A+We/bMMqfBeZBC3SknrhcbkkqjRm3bz+3GtKt5Fj0zVGQK1aUGtOIExgLUhf0ljJF4kiOkaFb44I7ioi/9wHfYHJn9UdoBcpDHf7Zvn5YbI6UFebrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SY+rPfsF; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SY+rPfsF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760546969; x=1792082969;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/vJ80utcH8tgW3v7Gm4xUJeaDuw1WA/F4dSEbW5wvHM=;
  b=SY+rPfsFRrp4MGxMLMddsesMaI+iI1r9mQRjZfzMTI4DOi4OAqJEoibS
   tkzjhUdwG1ySbGYp/tDaz46mEcCz5FNVSruiBj9eCVfa2VdNZDhiAnJvx
   X0Da2Lk3FTVtBM9MrWZybfEWk+wv45795sIgxidPt4hTooa2RFbg2zdrB
   vxoUt6KnKan21lu9vdpfbP4Y5GIgjaWnEAtRmq7Spu1RTmMLBp1FLD8qf
   S8gv4J7VuzpBlgc2dO6H0yR6+eXgKTX+Ng+8ZVgEYPyAvmidpXTHOqAs4
   0/uT8CC+cJLsXign9lslCda/n5Qod7ftCYTeVjuvQkCt9pKEKEkzarFuu
   g==;
X-CSE-ConnectionGUID: 9/Rv4T/ISsGLmU1V3i7jAg==
X-CSE-MsgGUID: ngXNz7LOS3aLalDUIUq3bQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="85345158"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="85345158"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 09:49:28 -0700
X-CSE-ConnectionGUID: zEmgr3jZQCiZCGy2lsYj5Q==
X-CSE-MsgGUID: ZSlgK1q/RJS2Z//M8eQP1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="219370005"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 09:49:27 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 09:49:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 09:49:27 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.29) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 09:49:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5w0ksSlQiHqsxaSfZ1cmQf103dtTjhEpEo+C3oBE/QihIyu5DLg3qSGHM/IkxQ0268bdatnUj1TWrJw83Um1I1OujQ+vZAYK+JSZJEV857HH9Q60FfpE7ZCJfpAtS+owCNm7EN8g3bfCdUMQ7DEAqb6WpQvLCEHNu9PfQ+foPQGGGMkVl+w7SkdNBFrN0PSbOU0TZjBR6d8mX/Lnz31ua78qiSvBVRsErtw6DXI3EyMY20EWeWjlETGdgAu05qZ5hrhKAqVtoUpucih6I/xBKU+ovhdvOmLWJuYKU4L7Bwwlx1ScLp76EN6iwS9EjLsuwku2y0ffBeVim+w8z1bfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyj6kOyZJMeIpOIlKfuL787zQu+2jGbS7NxI5TUePcM=;
 b=Be0Frsnv3VNqn1wvXAbLxiUvH0tWgm39vOAtsbrr2IF+9qSn3UQlENwDwK78g7MbOjOad9cK50OXfj928jNxLvmindGfBrbHk0G8wZMJcU8VquFsUWQxj34XjouhzdYdbu3gmv27e8F1qLWWpu8qBqy7jPaXhJ5EP2BUGpuQTTiuIXfIibMyqPof5o9Y0qpC0UoqNVlC5rNHVSqv1ttiqvyYNGQisSCVrY/YfGEwNj4GdJxg0CrKEQEwym2tdPWvQ7xuAQuhuAIFv5S0d3odhemHfUCTrslxEzRZEndecER8he+3OwvmJ80KO1o9bnlg4zZjdhViimwJZ2Jd0CLU+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB8289.namprd11.prod.outlook.com (2603:10b6:303:1e8::9)
 by DS0PR11MB7360.namprd11.prod.outlook.com (2603:10b6:8:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 16:49:17 +0000
Received: from MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022]) by MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022%6]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 16:49:17 +0000
Message-ID: <9f8f8acc-6b0b-4edb-bf69-25d7bbd9c147@intel.com>
Date: Thu, 16 Oct 2025 00:49:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tools annotate: fix a crash when annotate the same
 symbol with 's' and 'T'
To: James Clark <james.clark@linaro.org>, Namhyung Kim <namhyung@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Kan
 Liang" <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
	<wangyang.guo@intel.com>, <pan.deng@intel.com>, <zhiguo.zhou@intel.com>,
	<jiebin.sun@intel.com>, <thomas.falcon@intel.com>, <dapeng1.mi@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Arnaldo
 Carvalho de Melo" <acme@kernel.org>
References: <20251013161046.2075335-1-tianyou.li@intel.com>
 <baea1e93-5e30-404e-8a5d-8b1d20cf8761@linaro.org>
Content-Language: en-US
From: "Li, Tianyou" <tianyou.li@intel.com>
In-Reply-To: <baea1e93-5e30-404e-8a5d-8b1d20cf8761@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1P15301CA0064.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::7) To MW4PR11MB8289.namprd11.prod.outlook.com
 (2603:10b6:303:1e8::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB8289:EE_|DS0PR11MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: d563a24c-02aa-4e36-d82b-08de0c0ac76d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0podEpMMWVzN0hZT1lueDFYaWVoUlVOcDJTT2hyZERBT1UyNms2QjZJUmxo?=
 =?utf-8?B?UXI5NnM0NTVEekhjUytzWHQ4dGhibzExYnhOM1IzYTNxTkFRdWZnbUlKR1M3?=
 =?utf-8?B?ZTYvL3lGMENwMFZvZlVhRTQ3SFpCeGV1a1BwQkt5eitCTlB2VnEzOTFGOHY3?=
 =?utf-8?B?aElmSHNaMWgydklueCs2ZVhWNWJrTStHKzZnTUtJclZKOVNpVGRQWHZzS0Mr?=
 =?utf-8?B?SUJPZThnSHpmLzNCQVo3RkllNGgyOURtdHRlTUxOR0s5ZlVXSzJLZzlPQ0ZH?=
 =?utf-8?B?RnpzQlV1dWdyMVB2S09DQmhocXZpREFYNWVEei91VVBqRkphUGtnaEo2UzZm?=
 =?utf-8?B?cXNYbTdQZnZuZlpocUliTGRnV1N3eHRocStUblh6aHRVNWRXSmNqY1ZORUJE?=
 =?utf-8?B?OXo0YXVYZ0MyQkVhRkJYaFlTVFV4QVd5Q3doSGxtMnhpblg2REdrUHUwcGRw?=
 =?utf-8?B?SUVXNTJjaGRMVTZSZ0FRWCtBakJPYWEzRmdIdjVpNEdFdWJiYkZ3SllnVUJN?=
 =?utf-8?B?RnQ3OGxLaDU3SWdmdlVscjhrckJkaURQOUUwbGIvc1l1Z0lFNnlkWTAra1VT?=
 =?utf-8?B?azFTZWtPelF0NXNveEJYMzNyb25qUEl2T204dUhJQVRrNkZnenN2a1N4d2pX?=
 =?utf-8?B?MFcyUEl2eG83L3luZk5pN3l3TlJsblBJQnVVeExjWlIwN0FONUQwZGhONXdX?=
 =?utf-8?B?Z2VOMmhtTUkvaGhXaG5lQ1QwUkNUVlJMOUpYRzFZQXJLcytFbkRZSkdKQllW?=
 =?utf-8?B?aVhvUXZhYURUQ0dkUHpZZjdiQjRxWHB1dDVma01Ga0tMTXhYaVB0MlRhczd1?=
 =?utf-8?B?N08zLzh2K0hVMEdqZjhjTU8vdEpwLy9aTnh3YjI2UHVMSTBOb0Z5ZDFMRkpJ?=
 =?utf-8?B?OEQ1SXNBZHdaYWhiMjIzcCtpVmdxQUp3NEJTNS9IRCtHTVowaFFOdFA1bUdj?=
 =?utf-8?B?bzh1bTZGM05hN2F2OTg3STlRUG1SMVR2cFBhNlRETEFvY0xDVXRXejJuZTU5?=
 =?utf-8?B?TjlJbWdyZUw4NWxpTW9YYUFPRmYwV0NiNENEUk5vY2w0V1laZ0t4aFFyTk5N?=
 =?utf-8?B?SG9NNndiK2RLZVFCbTlLa0ZBd2JaR3BEeWp4RWhsNnU5TGVkb2FlSDE0NFJE?=
 =?utf-8?B?MFpuTFZpUlV6ZjRjSEpXeVV4QzE0NHY3aFAvTExBYUdJUkYrNGd2RXFCNEI5?=
 =?utf-8?B?MmlzY0dxRXpWcDBkT2YrQ1VUZWNNS0tkRXBKRlVYeFI5bHdabTgrdzBUY2hj?=
 =?utf-8?B?TXBJOEp3NGJNNVU5U1lPUzIxT21qL1lhdUEycmdqQnc0VGRHNEJ6bzZrV3Aw?=
 =?utf-8?B?UVlXb0c2bmMxemJiOUszUUJPeGd1aG4vMldrNzBQN3pzV3Q2cG1CMnpkdURP?=
 =?utf-8?B?Q1kvaDFzUmNBQkxWeFRTTEJueWhWc2RGeENITDQ3bnNrUlUwVjBHbUN1VGJJ?=
 =?utf-8?B?UEppOHpScFRwNyt5YnZzUDRaTTdjbzRlZWJtNGtWZldvMlRrVy91MWRHWEtL?=
 =?utf-8?B?NEpYZ0lLTFZiM2hzNDhyWTMzWWh6VzFZWWNqYUVQNURoUHJVU1BRNlRXR0JR?=
 =?utf-8?B?dGhEWjBiZVdBaVdkUk1BcTgyOTViTURzU0lSemhYaFpOWXhwOGdJYkYybVJ5?=
 =?utf-8?B?WVd4cE9PZmRhcEJrL3ovaytnNldobFFVekU3d2ZYa3l3d2pPbmswbHlMTmE5?=
 =?utf-8?B?K1lYaEpaWXdUeGVZTFhabHI2NVNlbVNRK0xPbjJaZ0c2TVpvazMrYWJaU2R1?=
 =?utf-8?B?UVN2MG9VRUt4M3lkdnVhcitCSkJqdUJoejZzakJDdzZ4THNqeCt2eDByR05U?=
 =?utf-8?B?TzhNNHl5N1VTRDNCR1ZoMlZ4bzZOWStIYTdSQ0IvdDdua1lVb2h0ZENkaitM?=
 =?utf-8?B?czBiKzl2NmpmQVFad1EraVV5a215MGxOMm5MbFhzMCtlc3BVVXFBekxUQ1ZH?=
 =?utf-8?Q?VbkaW+03dJbKRc81NNWjrHV8k1f+GDXk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB8289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2FNNTNBSlJJcHU1V1o5c0JuZnBVajZxYjZjZHBWMjFJWFJIZXlYSlBSSGgx?=
 =?utf-8?B?Y0NSYzQrZFhLdkJETHpWZFdZUmFJYXUwaHpJRzhHaTJsN2dHN2VhYlQrZkFn?=
 =?utf-8?B?eVpNQ2ZiMlJXNllmL1NsVVNmek92M1dTQ0F5cWp5Q041TU5mK0J0a3RGcW53?=
 =?utf-8?B?OXhVeGNHT3VXQ3JjaGI2R3BFa3hZdGdVRzVULzBTK3NlNVdaejU3UU0xbDJz?=
 =?utf-8?B?dlpNenNxZmNyalYvUWorSlgzZGRneUNlbWd4RXZ0QlQxdEhGTGUzUlVoSEdN?=
 =?utf-8?B?UkZuaEZPTGJ5VW1xZUZHajFKbEY2Mzl4MTYzUXdYZWVFQmsxRlUweHhOUmRu?=
 =?utf-8?B?VEVCd3B5WnR3WTI4SWtFdjZPMkZWQk1rcmhIdXF4OFFkSE44amtsNXR1OUJV?=
 =?utf-8?B?YjNYVXZya2xCeWFDRnJOMDU4TDJpd0NoZ3JHUlMxTC84ZFpaM2U3YndYUWhC?=
 =?utf-8?B?eEJGa1B5OFFxQ3hKY3haakU5U2VCUkZacVlGVkhNQUZjMkNTcUdjR1M0V1Nv?=
 =?utf-8?B?VVVpeUNod0VsTzNJRFFwOXRtU3J2YU5XWnhtRmRDb1NHSE1lbkRONXN6eTVG?=
 =?utf-8?B?UFZURzdIZVRGLzZxZFByWnM0Z1V3Qm90dW5RS3c3ZVZ4dVpoTGZEOUFiT0lS?=
 =?utf-8?B?dWF1SlhLa0hyNk1RbEJNR21jNU56M3NHOFUyTTlVKzNZWHVOWGg5RzRCbm1T?=
 =?utf-8?B?QmVtMDVFNW5UaTg5SmZhQjBicXZLdmJCbS9YOGlScURpcDNDQUlpWTFRNWF3?=
 =?utf-8?B?QWR0OU1RN3hsaDZZbk01VWhtNXR4TU9RVCtZVWtwaFR3elRUZDlUUXcxMWxJ?=
 =?utf-8?B?THdqR3hWR1pMWUJiZzJlN3FwNTFTK1grNmRGampsaEY0VWRQemtpVXhxanVi?=
 =?utf-8?B?bG1ybXhSVzlDQUEza21FZXI1MWhLa3YvVVRWSmlySDdodXdJajFuVjZSdFZt?=
 =?utf-8?B?VHMrbFVRRkY1Mys0NFNOMGdrNmhTOGhhZTc5N0hSSlBTWnhQVWQ5RzhiUVNp?=
 =?utf-8?B?cSsvK3Q5TDcyS2R2OS9TaXI3SlVBM0pUeEptYVBvQzhwbzdXZ05odzdhTS9i?=
 =?utf-8?B?SnA5MEhvRnNHRW9yejg3OTcrUGVMZlNnVVlqVDF5OGpwL2RtQ1VYRGxPcm4x?=
 =?utf-8?B?eElUZWdaU0NudEcwb21pREo5Tllvb2I4SGVxdlRVb01ERU9hYjdGK0xJRGpF?=
 =?utf-8?B?L2lKczdlTWordUU5ZXJJWTZCOC9mRmVqUm1RekpjK0tjRkNJNDk2NVc3a2Fl?=
 =?utf-8?B?MWdKT043c205djdPOGEzTWNzZWdKeUwvaU53YWY5aExGd3V0SUc1WTM1NE1Z?=
 =?utf-8?B?TzZqQ2tzZUhNTGxhV0d5aDAyaHF4VkFiT3lGOFFwRUx6U1hROHRPQXdvRkFt?=
 =?utf-8?B?QlhOaElxTXJNMk50T29FMWUwQkRqUE5SaFpsSlBvNnRWT2k2M2o2SUtmODhF?=
 =?utf-8?B?WFNDV1RNK2ZiZkgrT0N5Uy9LaWZaOUZOZ3FsdG5BWVdNL3NISlRrS21JazlS?=
 =?utf-8?B?WmFPZktGM1BHVnBURkdqVDJWdDZxSkxDZXBMcnpUVnpMTDFSdUtEL0o3WWFp?=
 =?utf-8?B?Mi9tcWE4NTB2QUdGbWFJbElFMjUwV21tc2xqTDl6UkpzY1BESXE1d25xOE5p?=
 =?utf-8?B?NGxjSTdRVW5FSE82M3VlNXZVZ1pPTFRwM2pEMmFTL2hvS1NZTk9HemY2V2M2?=
 =?utf-8?B?eGo1dldQWDZ3QnR6eFVVWk4yZ25NM1gwS1FpVmVCYU9XUEJYZUdiQm9FWjli?=
 =?utf-8?B?UDVCWXVxc0FEWGphRnNLR1JTaFNqNnNqNmh2d3A0emx1cG5tdmVUcFNkTlgw?=
 =?utf-8?B?VUdZZG1wbmxJM2VhWEJLODYwc2ZLT3dzNktUcHU3R2htMmdUanN5Z0psaFdI?=
 =?utf-8?B?alo4WVJFUFZjUVFEL0RORkVPR21Zc01PVU9PWHhhOGp2M0YvbWVzMThqUTFv?=
 =?utf-8?B?blhmMnAwTXZDakJIV0VPQTROZ1VVMm9TMTdDUThVYldaRk40R1NjNFdwUVdI?=
 =?utf-8?B?dkFGMjlYa2xuQXdHb1kzUEJJN0xRelhXZzhHemxRblVXeC9IbTRtc3ZTRWo5?=
 =?utf-8?B?ZUsyWnRKa3QxUnJyU1VaUmgrNkdnWGNwNDd3elhBR1R3SmFJSHFLb0tvOTNO?=
 =?utf-8?Q?mJyZLgyiiqG/JC+py4i6zCqLC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d563a24c-02aa-4e36-d82b-08de0c0ac76d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB8289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 16:49:17.2912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/yw2qUv+K2qO8rGT+EecIlmYp0W5/Uuci8srAIkxIwdyJpQQXU/yrbMltTywzvqrfCe5a4aCoyPkjfMQYSvnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7360
X-OriginatorOrg: intel.com

Hi James,

Appreciated for your review comments. All great suggestions. Thanks.

On 10/15/2025 8:30 PM, James Clark wrote:
>
>
> On 13/10/2025 5:10 pm, Tianyou Li wrote:
>> When perf report with annotation for a symbol, press 's' and 'T', 
>> then exit
>> the annotate browser. Once annoate the same symbol, the annoate browser
>> will crash. Stack trace as below:
>>
>
> Hi Tianyou,
>
> Can you explain why this only happens the second time and what you did 
> to fix it in the commit message. It took me a minute to work out.
>

Sure, will update the commit message and fix typos in patch v2.


>> Perf: Segmentation fault
>> -------- backtrace --------
>>      #0 0x55d365 in ui__signal_backtrace setup.c:0
>>      #1 0x7f5ff1a3e930 in __restore_rt libc.so.6[3e930]
>>      #2 0x570f08 in arch__is perf[570f08]
>>      #3 0x562186 in annotate_get_insn_location perf[562186]
>>      #4 0x562626 in __hist_entry__get_data_type annotate.c:0
>>      #5 0x56476d in annotation_line__write perf[56476d]
>>      #6 0x54e2db in annotate_browser__write annotate.c:0
>>      #7 0x54d061 in ui_browser__list_head_refresh perf[54d061]
>>      #8 0x54dc9e in annotate_browser__refresh annotate.c:0
>>      #9 0x54c03d in __ui_browser__refresh browser.c:0
>>      #10 0x54ccf8 in ui_browser__run perf[54ccf8]
>>      #11 0x54eb92 in __hist_entry__tui_annotate perf[54eb92]
>>      #12 0x552293 in do_annotate hists.c:0
>>      #13 0x55941c in evsel__hists_browse hists.c:0
>>      #14 0x55b00f in evlist__tui_browse_hists perf[55b00f]
>>      #15 0x42ff02 in cmd_report perf[42ff02]
>>      #16 0x494008 in run_builtin perf.c:0
>>      #17 0x494305 in handle_internal_command perf.c:0
>>      #18 0x410547 in main perf[410547]
>>      #19 0x7f5ff1a295d0 in __libc_start_call_main libc.so.6[295d0]
>>      #20 0x7f5ff1a29680 in __libc_start_main@@GLIBC_2.34 
>> libc.so.6[29680]
>>      #21 0x410b75 in _start perf[410b75]
>>
>
> This should have a fixes tag. Maybe commit 1d4374afd000 ("perf 
> annotate: Add 'T' hot key to toggle data type display")? Or earlier if 
> only 's' and not 's' and 'T' are required to reproduce.
>

My apology. Will add the fixes tag in patch v2.


>> Signed-off-by: Tianyou Li <tianyou.li@intel.com>
>> ---
>>   tools/perf/ui/browsers/annotate.c | 3 +++
>>   tools/perf/util/annotate.c        | 2 +-
>>   tools/perf/util/annotate.h        | 2 ++
>>   3 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/ui/browsers/annotate.c 
>> b/tools/perf/ui/browsers/annotate.c
>> index 8fe699f98542..1e0873194217 100644
>> --- a/tools/perf/ui/browsers/annotate.c
>> +++ b/tools/perf/ui/browsers/annotate.c
>> @@ -1163,6 +1163,9 @@ int __hist_entry__tui_annotate(struct 
>> hist_entry *he, struct map_symbol *ms,
>>           }
>>       }
>>   +    if (browser.arch == NULL)
>> +        evsel__get_arch(evsel, &browser.arch);
>> +
>
> This technically only needs to be called if symbol_annotate2() doesn't 
> get called. So it could be on an "else" after "if (not_annotated || 
> !sym->annotate2)".
>

I have a local version use the 'else' but I thought it might be clearer 
by make a NULL check then call the evsel__get_arch. Your suggestion 
definitely make sense especially the if/else statement could serve the 
whole purpose of initializing the necessary data structures. I will 
update the code in patch v2.


> I looked to see if it's better to save the arch in *notes, seeing as 
> that's where the annotation is cached, but it doesn't feel any nicer 
> than the way you've done it.
>
> You don't need to check the return value for errors because we only 
> get here if it worked previously and dso__annotate_warned() is false. 
> But it might be worth a comment or checking it anyway to avoid doubt.
>

Yes, I do need to check the return value. Appreciated for your kind 
words. I will update the code in patch v2. Thanks.


> Other than that, looks good.
>
> Thanks
> James
>
>>       /* Copy necessary information when it's called from perf top */
>>       if (hbt != NULL && he != &annotate_he) {
>>           annotate_he.hists = he->hists;
>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>> index a2e34f149a07..39d6594850f1 100644
>> --- a/tools/perf/util/annotate.c
>> +++ b/tools/perf/util/annotate.c
>> @@ -980,7 +980,7 @@ void symbol__calc_percent(struct symbol *sym, 
>> struct evsel *evsel)
>>       annotation__calc_percent(notes, evsel, symbol__size(sym));
>>   }
>>   -static int evsel__get_arch(struct evsel *evsel, struct arch **parch)
>> +int evsel__get_arch(struct evsel *evsel, struct arch **parch)
>>   {
>>       struct perf_env *env = evsel__env(evsel);
>>       const char *arch_name = perf_env__arch(env);
>> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
>> index eaf6c8aa7f47..d4990bff29a7 100644
>> --- a/tools/perf/util/annotate.h
>> +++ b/tools/perf/util/annotate.h
>> @@ -585,4 +585,6 @@ void debuginfo_cache__delete(void);
>>   int annotation_br_cntr_entry(char **str, int br_cntr_nr, u64 *br_cntr,
>>                    int num_aggr, struct evsel *evsel);
>>   int annotation_br_cntr_abbr_list(char **str, struct evsel *evsel, 
>> bool header);
>> +
>> +int evsel__get_arch(struct evsel *evsel, struct arch **parch);
>>   #endif    /* __PERF_ANNOTATE_H */
>
>
