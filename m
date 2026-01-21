Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2052369224;
	Wed, 21 Jan 2026 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769011797; cv=fail; b=SaOtZGy+PJGMpTKrBYk1ZHqFPkYUjwkD8zVcU2mBwA0Hj5Hcf8LrGVHo9XX/iSFj+JIrrYiro23fJQ3lEDt9fkLx1dsodo0FUcUsctiNrnufEEwPMBm6hOTDWSxa/cVvixHp70kae5Px1d3ILL+/UI5KRV1u7zWRXF46MDcJ9M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769011797; c=relaxed/simple;
	bh=FWwY/HZ5Alc/nVyoZPPpD7yVoe67AZoSyWf8AOnvU7k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tY+baDzQPDmqDslEU+PdGzt9EoSnbejRUCkWT1l8Iq/FeOYHfAHKvLTLt0HuAvFfdnu7/IAXNbLlvAokjyN2ZDjwSufFe5J1LCsKXXy4shZpkmj6FT6lqSsI4MdgZfcCbeLpowTBpChzDsRckrXJNJeCWbTwKZ2ZxGPHoDeg/9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gQ3PRooD; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gQ3PRooD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769011794; x=1800547794;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FWwY/HZ5Alc/nVyoZPPpD7yVoe67AZoSyWf8AOnvU7k=;
  b=gQ3PRooDhX2AJ3mzPvU5ZajiKBCFxgMi/g0uAv2DzCNM/vDLUhD6avYQ
   aOWGQ/eaD5niUByMDjc9jLGs1vJRrtZpPmgbwYffqzMO3QkwMixV/HfFA
   OLfUinrKrZzoE0KrSrKRGZMO1GKBlu5bmRMK6DjAVkQFx0t46BZeKZk7j
   vUQNTfXBgXqYj7TBABR7iSq/UdffTAhcrpjPf6MoxBH1ghnXz1YbBRM9n
   KhUncPLUHF407ViqWzEEfc+eLSI0BTpBadMXq9HKv3pufhbIVpWsE2GbE
   KbWAG3wit0xu9f0iFHoioRASixwo8suVZtAIVEtFjOVtGTJ0z0MXGG8XU
   Q==;
X-CSE-ConnectionGUID: eTMjjefxQf6QqQEr03KkaA==
X-CSE-MsgGUID: sZpZCXbpRZuciX2BMnVHnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="72831705"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="72831705"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 08:09:51 -0800
X-CSE-ConnectionGUID: YJ8fGJ8DTUGPhWLbsepfuw==
X-CSE-MsgGUID: 00xssYI6QSq6REk8HaQe9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="210644691"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 08:09:50 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 08:09:49 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 21 Jan 2026 08:09:49 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.16) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 08:09:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6gMvHNfbXNvGNGRfXI6gMEltpFny7/hhvXBHzj4n6jS2F9j3EmtzbXNwyPBU0dKWtFDIT9amd3LYc2Otqe9f8pEfuwmr0QZ6v5KqZ7LLS4en8RzBqSZQpKdj0R9saSEmfMcAaOykxuwhKVdrad9V8d+Hy92lIvZoSLFdTx2j3grs0diISiqXi2fQmHtw/H7byJCMyu8a0t8xz/DNHPQqk8K6anXnQIQQV/0SqSh43mCYHBUcqUtJfbunpy7ikJE/fMwxP5lB7oVEkrIlarFN8+RWOWn99mReN4/cRJ1mP/0eR6y0iPkM3GbkJo7gmfeOWsxHjXOXNkFJ50TcjKgRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGG0ZAdWnWOl3hWUTjLpRLGVHHsd0wV3lMMz6du+ssU=;
 b=qhmqF63LqXhxrmWVPmTT/xRt7UNPH5khl0VM2zobIRNo7nFy0qCA9tLdZGA813IB0jQ+NAYPNjUojoSwE4ummRrvhyKv2LYOEbJhHiXjCrVJh2oQPKbGcyhl3FnoOvKTQ75UFY+W5RHc/FqyezRn2TJR3D3ns9Zo/+J7r5J7hy3HyI1Uw1eIFV3EO8z6P/cpHX5p7kCR3ro3rUfYcC5RnjHtAWZ1KmIHo7ZiiD0DFucp6uNyGOxqF27F1eFs2+EhKGERVvBVMcBgJNvJ7CuUfGH9CIJzyTtyyPt88Fzouo3PSFtUYLcN6gMa1qYWONr/WDqtCmb3O/cXL0r6xkP//w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 IA4PR11MB9107.namprd11.prod.outlook.com (2603:10b6:208:562::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Wed, 21 Jan
 2026 16:09:45 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 16:09:45 +0000
Message-ID: <6a434657-5b5b-41ec-a79a-c648c2829602@intel.com>
Date: Thu, 22 Jan 2026 00:09:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] perf sched: Introduce stats tool
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
CC: <ravi.bangoria@amd.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<sshegde@linux.ibm.com>, <ctshao@google.com>, <quic_zhonhan@quicinc.com>,
	<thomas.falcon@intel.com>, <blakejones@google.com>, <ashelat@redhat.com>,
	<leo.yan@arm.com>, <dvyukov@google.com>, <ak@linux.intel.com>,
	<yujie.liu@intel.com>, <graham.woodward@arm.com>, <ben.gainey@arm.com>,
	<vineethr@linux.ibm.com>, <tim.c.chen@linux.intel.com>, <linux@treblig.org>,
	<santosh.shukla@amd.com>, <sandipan.das@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
	<irogers@google.com>, <james.clark@arm.com>, <acme@kernel.org>
References: <20260119175833.340369-1-swapnil.sapkal@amd.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20260119175833.340369-1-swapnil.sapkal@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU0P306CA0073.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:2b::18) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|IA4PR11MB9107:EE_
X-MS-Office365-Filtering-Correlation-Id: c9462eba-29d3-4e90-df6d-08de59077e0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1diQlNjV0FQSTdEQjN2OTR2VWEzdG1FRWhtSDYzY0FmZWdLaGZBL0w0MkMv?=
 =?utf-8?B?SVpwQWpJMFVEaHA2UUp1UE5uWklnUVpQdkRPZG81T1ZpaS9nLzVTcVF4RVVP?=
 =?utf-8?B?V3AxTFgyTVI5SnozNGgvQTYzK3pNYmJxYzhueDFFemJBNEdRMTVSNk9SQ09M?=
 =?utf-8?B?TFpkVzF2YjNCak9Ubm9xTFE2UWFXUEdhVEhLTDVNVFYzenNhbTBpNmc3SXVu?=
 =?utf-8?B?ZUxSb1VNNS9aTDg4V2tPWWdEWnhTVXZXUll1NzZWcU9yeEhtS0tzTDJnTEE4?=
 =?utf-8?B?UXY0bTZ5RFNjclg2elB0MzRrampvVVlqQUM5cHJpc1JyMFQrRVlRc0JuTjJY?=
 =?utf-8?B?YWxtaHhLTFRFeGcyNlQ3ZG1BTkIvSVlCMFV4cDlLMm5tMFBaWjl6bjRvM0s1?=
 =?utf-8?B?K2tPVzc1SUZ5NkhwcFVUYUFjekxIYXZvMVMxRFBQUmx3MGd3OFNqSllQL2tZ?=
 =?utf-8?B?aVFiMzQ2dDF5bTE4VU9IS0VLU3A4Ulk3RFlLK1pkN05namFpUlRaNWhnM0sv?=
 =?utf-8?B?Vk0wUjljR2tOM1BNUmp2Yi9NVWFNZTRiMkdVKzZxcHdvdEw3RVorRzJpc1FY?=
 =?utf-8?B?L2pEempGVzhEL0RzbDZ0NkgrdmVySmNkd1Iyb25LMldOVWo2NjRCYnFocHM2?=
 =?utf-8?B?QU8yckYwb1pibU9CbVlNbzZnbGhDMWV4c1h6NXhuVnNNcHBoNDYxWElSTExh?=
 =?utf-8?B?K2VTV2xpd3RHRlY2Q01EbkIrcXRlZldzWnFzVTZNU2wrZmFUdktwV3dWbUZv?=
 =?utf-8?B?VWdiM0VmN1dycHl6K1dJM0wwZTV2NU9haGtmaVZKUWJ4TTRYdVNGODFXdnFH?=
 =?utf-8?B?M0lnaWNrVlMrRFpuLzdNaW81eG9tNDRHK2RqQzU5bng0QjZzVDdwbENxeTZP?=
 =?utf-8?B?bUt5T2U0NVVtMGdiak4rcTd0N1RCZ0xCdkJvWVBOTnA3dHpXcTIzMXNMNHFL?=
 =?utf-8?B?WDQ3b25iQ2w0U1hZbmpxRVlyekZlTGVyRVVjUk5xUTFvbk1iSHJQNnZvQmkw?=
 =?utf-8?B?em8xQTBUNTQvanMrdHF4SDlDUW9yYXBRR0Ezdk1TeUdGd01MUWl4d0xWKzdL?=
 =?utf-8?B?Q3JVbElTUHlOWWI2aDdBcEJhMWp0ZjJHMUJvNy9yekwrU3VYM2dEV3BkZGhp?=
 =?utf-8?B?WmdHellaNHZjVUlObVh5MmV4OUpjWTZsNW9tMlliMlcxbUZySEpyOUwyd1lC?=
 =?utf-8?B?cnBPMno3UzhUbHMrQmpYbXFoSkpnVFF2N0U1Nnp3dGM0MzFnMUo0MGFTcE1z?=
 =?utf-8?B?WitzNHNpQjJMODROemFjSnIyMlhrS1VMNmFFL0g4MUZYSmtpc1N3dEVHVjZq?=
 =?utf-8?B?UWQ1NHBrMndUSno3amVTTGFWZWs5ZUJUelV4S3V5OG1uZGFRRlhJclpjNXpB?=
 =?utf-8?B?Y1U5dUUycytDbkV6ZGxsTThUZlhzS0M1VTZEYjhXUXR1ZlNUSnFZSko5dERk?=
 =?utf-8?B?bVVDMGxneXJlcWlRZ2pjcktxRDRMN0gvbW4wdFJ1ZVdtRGM4M1pGeUNUTnJv?=
 =?utf-8?B?MExBcEh5S1FRQVZpTzJ0dHEwL25McmV3QW1hbjZNN0srb0ZSKzJBWTY1SzFM?=
 =?utf-8?B?RnVWeGlSSXpsNWV5SDdCSUNLT2FKUlpuVUhiQmRXT283RGhwWUhqODhDZ3RT?=
 =?utf-8?B?Tm9KWnpmaXJUa2RDWlVLN2ZVbFRDeXFmaU1ZYkxuQkN4RitqaDh5cFlGZHcx?=
 =?utf-8?B?aWlPR0VaTmpNOE1IbUt1bVZkbWpmSFMwMFRPcXFGa0ZrdC9VYUdnSlVCZUJz?=
 =?utf-8?B?Njd5cWZiRlpRa0pSK2hZejlsN2xpdlF5WlljRFdIRk1PbHNHZEo4UkxHTFh4?=
 =?utf-8?B?Z1BTK2dEQmI1S0hxbW9oZ1pMUzJEaVZDb0F5TXpRaHZiVk1iMDVWM3c5SlAv?=
 =?utf-8?B?UUQ5cFZlWlZiSzdFamVMNnJPS0d4amE3WXRreXZvK09rQnpHQmZKQWRRTUk2?=
 =?utf-8?B?b2YyMnlzN2h4NmtseHo2RFlaN3J0WGxsM0tRNHZQcmFuSFJ2VXhjRmpvUXVJ?=
 =?utf-8?B?SHZheTNEYzlLZDFWRzlYcktDaDdybHQwZWRsMFRQdW85aU5TMzNpKzgyN0VG?=
 =?utf-8?B?d0R2b0NWTTQ3blpYZG55SlZUQzlSWG01U3VjaEU4WDFobUt6WWs3T2FuUmhI?=
 =?utf-8?Q?FcD4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEpJbk5iZ001V3NmMXZPQ3loQ2x1OTRSY3Q4TGhOMUtSc2FKYTB6b1UwZlJo?=
 =?utf-8?B?WWpGYmMyMEtaOGxBYWxyZk9IQngxbW5zYXRWdndld0dIZ2pYOWVsOHFHQkxa?=
 =?utf-8?B?Y1kwcTg5VFVENmZENVFCOGh2MGRsekQ0V2pPMTlXUmxDc2ZUR3IwTCtjcFV2?=
 =?utf-8?B?OEtkRzdMVVRJeXdNRHVTN05zMndJLzdLVDEvWEM4a2Ztc1NCQ3lMWmViRDF4?=
 =?utf-8?B?Ni83Y2NwaGdtVWRRYy8zcnN3Kyt4QjNxbGU0aWUwTzRQam1PUU5qQi9JKzJm?=
 =?utf-8?B?cFh4MXR4QVNhZkZjZVQ4Vk1NK0VFVEkwWmVucjdHVnVEQVgrUWJaTnQ0MWE0?=
 =?utf-8?B?VDZkcUZRSU5adzdUSEp2M3JxNFVxWU0xb2ZCZmV6R0dWUkdqZXJSTGdsVlpR?=
 =?utf-8?B?b0FwQmVxL1pJd2ErK1FPd3JWb2EycEZ6cnVMOEJudmg0L2RFMnMvQUd5SXhR?=
 =?utf-8?B?WFNpTVJLQWpDSWFEMFRGblRDS3dHOTlKcVJyMjd1eGNDUGE4RXd2SU5ZTklj?=
 =?utf-8?B?ZE43UDU4WHNOQ2lmQXR3TnVNa3JZU3Evb09RbEY4ZXJaWjEvOWszZTQ1WUpB?=
 =?utf-8?B?NkNpL3FGQkhFOGRSYmM0SVhoWW1vZTBRdytEUWw0Vk5YSUJIaTMzUmZpdGZZ?=
 =?utf-8?B?WkF4dTJvZDB3WG9VUWQxR2tLV3ZWR0ZJL1VuclB5NUJMNDhhWTc5Q1RvYUF2?=
 =?utf-8?B?cGxZR0RndHhGVkxUenFYU05uZWR1T2NzNnAzQ3VPckZiUEJjTmtvZ1JDbHMz?=
 =?utf-8?B?dmxUQTRRMkZweE1BRnlTNnFnTFk1MTEwSHE5RWx1QythSUZINkN1c0VhNURH?=
 =?utf-8?B?MFdMQTNXcTVFZEpYRVNpRlkvTWovZHMvS2laNFlSd1B2NUF6cTB4M3BqZzEw?=
 =?utf-8?B?aHE0N2NhRHN4bDd4ZE5sWFNBQzc5Y01scjNqVFRuUEdrODNqbGtBeTBON1RG?=
 =?utf-8?B?RWowRWR4K2U1UDd1N0pVNXkzUTVQN3hrWW9DNmIwamNPb01OUk1OZWwzYXc2?=
 =?utf-8?B?WWViK0g3NmptLzN1V3hIU3lWZU05OHhrR2V5MXV5SVgrcmwyMWhBS1hXTTFa?=
 =?utf-8?B?Y3RnUGxZQXB5SURhNVVsQWNRZkptdHZWNFNmeU1nUmRwbE5ndHRSbXFiZ2F6?=
 =?utf-8?B?ajFCRGpvdExLQndjQWRScTRQbDVuOEtPb2hJbnVuQm5mSjlBMGphWWZTSW1W?=
 =?utf-8?B?K1Z4R2FKS3EvbVI2NUZaU0svbG1JRHZFL1FCbmtXVW1kRUs4QTM1QlY2dSta?=
 =?utf-8?B?N0JyZDMwSktKQXVSS3VuZURmOHJEUFB3S3VUcWV0dTN5bUJSRUdpNU55VHRJ?=
 =?utf-8?B?aW9PeTFpK2VOSHI5aGtJeTZOcE5TRlRybUtXZVBYZVA4RFg5TkVZb2xpTFky?=
 =?utf-8?B?N0xOazBWekc4dEpmcHdsZjVva0xUTVh1b1JCa1B4ZkIyRndXd0ZaYlVXYk5O?=
 =?utf-8?B?a3pEMDJCN0VSZjJKanZpMGVWYldXTWdnODdQekE0ZHpPTUN0YUkwb2R1dHFk?=
 =?utf-8?B?aDlCS0xyMXJpb0VKaG5uSVdwMTliVFVGczU2VzAwYjlXNm1QVE56VTNZWjNl?=
 =?utf-8?B?ZnJFNHdkUFd3R1EyREY1TnFpVTJzREg2Mk1kaE1iSkUxY0hwQXRieDJvWkxw?=
 =?utf-8?B?UERHbXFIYzdQdGRaZDk4SjJTaGdrb0NvcGFHaDZGaVg2UUNka3BITk1ZWWZL?=
 =?utf-8?B?eS83S1ZBSjN6WkI1S245Tm56dXlTc2ZtcGQ2MjFTdndUTXVtTjRzQWZUNmZp?=
 =?utf-8?B?SllSMDF1R0pYWnhGVVpCYUU3bW05NDJUd0JMNXZhZVdocFZYU1EzWC8venRI?=
 =?utf-8?B?V24wN3RmeUNwRHF2Q2JVangyTVlpUGZUektNTW12RjBmN2ZJSHlzOEsyc3do?=
 =?utf-8?B?M25pK3ZTQUpIZ2xNdUpVbmlDNU5DNThORUZEOEp1RzYwdm1nZ0E3UGhWZTAr?=
 =?utf-8?B?Z29OQ3U2NU1YcFJRM1pkNHlWNythTWlBaCtMRmxIemxWOHpySGVwYUh3eUtX?=
 =?utf-8?B?SVhyYlhXa2RHWEczZ0JDYnl3VWZpOFVkN2dBRm1TMTdSeEhJdlpGOFNURnpD?=
 =?utf-8?B?eGhHOG1acjlsYy8yd3lYZG0rN1pVWVdDYUtIa25YblFqaHR2eFlMa25HUXRk?=
 =?utf-8?B?bUQ0bkFZbTV3a2l4L3hrVlp5bnFUc1BKb2Y1L1NSV1dhdVZ5Wk1XeVhjVnFO?=
 =?utf-8?B?ZXgra20yS3JvWHVxd1d3dC92TFZwMFhOcWptYWRzVE9wS0RJOHBDTDc0S0gx?=
 =?utf-8?B?Lzdzb0tESE1NUVk1OU1XT0haMTlRVm44Rytka1p0Z1RQTFYyMEVjbENNc1FO?=
 =?utf-8?B?L1hmcjM4eHQyWVBsNUxRcXpwVk4vSlZlVXEzZXEzb3pLNHdhTnViQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9462eba-29d3-4e90-df6d-08de59077e0b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:09:45.1278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OlstfCtRubnDwcpzlAT614TQNTCbN1hDsxQeYDYuoCeF+u7A2Xh4cvx7xBDopzd1I9syUjAm203+sR1WXHDfLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9107
X-OriginatorOrg: intel.com

On 1/20/2026 1:58 AM, Swapnil Sapkal wrote:
> MOTIVATION
> ----------
> 
> Existing `perf sched` is quite exhaustive and provides lot of insights
> into scheduler behavior but it quickly becomes impractical to use for
> long running or scheduler intensive workload. For ex, `perf sched record`
> has ~7.77% overhead on hackbench (with 25 groups each running 700K loops
> on a 2-socket 128 Cores 256 Threads 3rd Generation EPYC Server), and it
> generates huge 56G perf.data for which perf takes ~137 mins to prepare
> and write it to disk [1].
> 
> Unlike `perf sched record`, which hooks onto set of scheduler tracepoints
> and generates samples on a tracepoint hit, `perf sched stats record` takes
> snapshot of the /proc/schedstat file before and after the workload, i.e.
> there is almost zero interference on workload run. Also, it takes very
> minimal time to parse /proc/schedstat, convert it into perf samples and
> save those samples into perf.data file. Result perf.data file is much
> smaller. So, overall `perf sched stats record` is much more light weight
> compare to `perf sched record`.
> 
> We, internally at AMD, have been using this (a variant of this, known as
> "sched-scoreboard"[2]) and found it to be very useful to analyse impact
> of any scheduler code changes[3][4]. Prateek used v2[5] of this patch
> series to report the analysis[6][7].
> 
> Please note that, this is not a replacement of perf sched record/report.
> The intended users of the new tool are scheduler developers, not regular
> users.
> 
> USAGE
> -----
> 
>    # perf sched stats record
>    # perf sched stats report
>    # perf sched stats diff
> 
> Note: Although `perf sched stats` tool supports workload profiling syntax
> (i.e. -- <workload> ), the recorded profile is still systemwide since the
> /proc/schedstat is a systemwide file.
> 

I found this is useful for load balance analysis on my
384 CPUs system with 6.19.0-rc1, please feel free to add

Tested-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu
