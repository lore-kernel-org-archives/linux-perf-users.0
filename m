Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4DB24FBFF;
	Wed,  5 Mar 2025 14:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186731; cv=fail; b=f4DA12keuJunywCRkXfSIsFB9pqBW1JH0mrEgnYib4GsFohUixmCk2fI7wSPzAAs/iP0JLZbRsDPoh0YjNcJw4WKDfVbcmDtE2EM4brkKu8o99aBVzHXdLVrQp63m3IfInx4Ll2bM51cxMbMOtoDdzkKua56eyWLYDCLHXhsanM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186731; c=relaxed/simple;
	bh=NMbQjdFDvxh7dnO+qA+6/0RHjF4o1YDpAarSi35kv58=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BBC87CKOQrdTg/L6cl/YhR9SPSdjaBIxHQcBSHy4v9fI5RGOjRIBhlnWNWMv71raTADAS09xMX1bFz1gv8HIf8VBdigLIWasyp6k/pNvaMrucf4UdyK1KfAnNHicD0LdmboZvmYyE/7Pz9v8+T5poKCkaI97KgGXbrScdFLSjko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dpBI8yTb; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dpBI8yTb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741186729; x=1772722729;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NMbQjdFDvxh7dnO+qA+6/0RHjF4o1YDpAarSi35kv58=;
  b=dpBI8yTbLjiwCVZ5ACAa2uB0n5YboW1DfgAwfxWrYzS2svVDd03EgaAQ
   ctANHiGgucQlzRPM/W3LCtPzd3+JUvZCHyFxpqf0Nz1OdZXs/CW/QoOkt
   MYyZ67sWVMqo0LlHLHZd/dK3oc4KvvN6lQA5Nm/zBIJVOfUlgelmI7owO
   R231DF/IEpYxwx+dsFCrieXrLpYQBtQlsXnR9Sgb9geVwgROT389aWvDQ
   QJHyEHhwmknF0HKF4YuKLZmmD6HbNoyIuLosUm43hQ1qhwZ88pQn50fDR
   9IXV+UqPXFnUqa2VRWItEdBRMVTmXe2opExlBJIDzYYv03eKLSZZhfHVb
   w==;
X-CSE-ConnectionGUID: CCs3oifBT6OEKvACKhIk1g==
X-CSE-MsgGUID: g5KRhfxESbu/Jz5LfpVoeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42291310"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="42291310"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 06:58:48 -0800
X-CSE-ConnectionGUID: gE4bY94zRt++FyD/v2QaMQ==
X-CSE-MsgGUID: lMGzMEibQb2tnT46M2H6Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="122839378"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 06:58:47 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Mar 2025 06:58:46 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 06:58:46 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 06:58:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyON/Kj1LIdrs98dpeBdGre/9lyL11LjN4K62ILqOyRaS2uZiq+eX0NwexoHycJVTf/PouA2hzByfn1l+1m5YZvbREdqCzAQXPJ1LzocDQNh2njEUTd0o/khbF/UmGhSAFfJaUcC8UlndA2n+0uvTP3nnx2UrR+T1/DRG9mpvBG7eqP9U6eji8/EIdsE+B1i1asgBkKwXWs2rOUM54XCa4H+RqBddp9lZLFpwwvlgYAX9hC5YFIfabsuvcLAFjKZDkVEpMxLVCkRRsOQr8Pt8DRqKCtkatDVywYoW5wf4RkLQ33z7JkE9M4MEjV3H2Yp6U6acaGpohF5yaldSqtB7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEsvnz2Tpre9Oo6DjudjxgDVJz7VSgsFZny2mIlBr0c=;
 b=hYasUrfDVvN226Nh8dOTA2Ag0UiM50RO1wBRmiM5vPiYZ5+30DeZ31yC6D4BUY0pEODLkkuMcDAPN3L+M5zKE/SjQjgkKyQtt8F4ymutQD/PbCS89sVYHH2FWexk33hQuHo3BkPBxECdtxNqYlUqdE/ON06kgX8mXRRw36ByJmyYGukWf48Z3QUuyyBH/nvODRXnbYPiMrFr0leEZzy1X5nmir4GEECpP5itdlPcPAlb+bj/5kDmiPEzUCABNGHEpg3WNsuZGu+QV0RrcA1GKY8DrGmjNYhRqYPuiHc4g8hIiSTT4omqJ5dNgNg6q9NdejYCi2mhthWLm1gK3vROcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by SA1PR11MB6616.namprd11.prod.outlook.com (2603:10b6:806:257::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Wed, 5 Mar
 2025 14:58:37 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%4]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 14:58:36 +0000
Message-ID: <d70b6f8d-0e86-4814-bf05-4c3d9acd313d@intel.com>
Date: Wed, 5 Mar 2025 16:58:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel/bts: allocate bts_ctx only if necessary
To: Jiri Olsa <olsajiri@gmail.com>
CC: lirongqing <lirongqing@baidu.com>, <peterz@infradead.org>,
	<mingo@redhat.com>, <acme@kernel.org>, <namhyung@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<irogers@google.com>, <kan.liang@linux.intel.com>, <tglx@linutronix.de>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250122074103.3091-1-lirongqing@baidu.com>
 <Z8hV3WYuHxHBNoNV@krava> <Z8hXsvloKEb7ia3V@krava>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <Z8hXsvloKEb7ia3V@krava>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::19) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|SA1PR11MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d8a49b2-3bb3-4d86-90ad-08dd5bf634bc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWVJU2N3R0JsdE1BTyswcldWS0FGUU1vOEwyZCtVNisyVHkyZTRNRTB6alUz?=
 =?utf-8?B?cnpYZ01LR1JkOHM1WlBNd05KWUh1ejIxVHBEOVVTcG53NWhCU1paM2dmMDBp?=
 =?utf-8?B?eXF0STVudUVpc0xZcmVOMXZaNitDdm9jaExsUlJKMHJmUEdkOW5ydml1Q282?=
 =?utf-8?B?emUrSXBmZWUwZ1F4Rkcvb1I0anIwY2MySTVMazdJRW5HcUhmVDMvN1NsTDU3?=
 =?utf-8?B?eVBmbk9VV3lRNXY5eW8xaU9ldjMwbWtqMmZldllDUThMQkoxMFRjc3p1THJV?=
 =?utf-8?B?TkFHUzhKNzkzTTl1OCtNaUtTb0RSbUpOa1BNdTd1eFg4OSt1V0I1emViTjVq?=
 =?utf-8?B?aDBiYmZES01wSnJNd1YrZWlJei9uOUN3aVozQnUyU1MrYXArRWh3eU5sUzJz?=
 =?utf-8?B?czVMejVlS2Q5cWZOSmdXWWZ0UjdFM0JFSXE5Um04THhvOXF4WWc5Zk5ZUXNW?=
 =?utf-8?B?bm54amZUWmwwSXpMWUQxcFFEaHkxdG1JQitFb2VNL2lKNThyNWVQSkdwakNY?=
 =?utf-8?B?RDB2V1dYcDJqbXdMSzhNLzRzenZ0clB4M2xaSjFNcjNocG1vakZoNVhsbnVR?=
 =?utf-8?B?M2RxMzdhNnV4MXRiYm9BaUJaNmprSDAvR0RkR0Y3MnMrV3hsWGpOcjNYS0g5?=
 =?utf-8?B?K1N5NlpjTEJFTlU2R0JaalVaMHVPYndxYUhQTEs2TlJZMHQzSEEyTldvTlEx?=
 =?utf-8?B?M0pCcW50a1Y2MkFTSUwxcS93VFQvTkxqS1ZTMTNZMkI3SHVVcGFXSTh2NWhj?=
 =?utf-8?B?bVB2alRCNStDUFhmNUZkVGxSUGZDY2kwd0M2WUZ6WlozZkF1MUg3blNxV0Jj?=
 =?utf-8?B?S25xWUFYSnNUY3RqeCtVNFBJbXF3bk9LZ2J1VWpwOVljeVBZK2gvMkxZbU9W?=
 =?utf-8?B?TEdERTFLNW5rL2RpakdRcTZTbFZTZkVKeGxBWTFiSDd3OEdqTlF0Rldlc09M?=
 =?utf-8?B?TjJiaUVFQzlHWXFTOVM2NzdEUm96M0F5TWF5cnRHSm9SV2VUUlJBWkx0bFZz?=
 =?utf-8?B?NEtBdmxVaE1ueWc3b3NqaVh6RXFEQTBaZnlmaDVrb0FUMGZpWmtLL0dyVjg0?=
 =?utf-8?B?aC9MMmVLbTRYMFZPc2ZPTXZRM0NGd3dDc1hLR1dqWExRWEtEY3M2ZENvTVlS?=
 =?utf-8?B?T0hnWkR1cXdaWU5BK3k2Y2xjUkFaeVo2WFRJY3lIQ2RpWXkycnZWWGpUR1Iz?=
 =?utf-8?B?N3BxOWljUnpIK3pUSjY3akRXY2psMkZ0dUN3NVRzalVjU0EvRWw0K1FCV1Vs?=
 =?utf-8?B?c0JRaE1vNjJ3dGEyT0ZVeEgxNkcvOFZHajgyVTNBMDE1am53UUJXdzZUamhu?=
 =?utf-8?B?S2hia3JWR045RWxld05ka2ZsaEFvNzNNVXVuY05WeThINFN1VSttSGtwN1VN?=
 =?utf-8?B?MVI0U0lqYkJsRVNDT2xtYmc4cjJpaUViMzRWSERaOHJBL1FhQzM3eU90am1t?=
 =?utf-8?B?c29tU09peGVFUjIwa0laOTYzV0t3YVR4S2NTYzUydWh5UmN0MW95a2hqNzc3?=
 =?utf-8?B?cXNTa2RIN1dKUzRXMmFhM1VNeXBzVFoxcHNhV3hCWVp2UllGaXdsN1hrRnE2?=
 =?utf-8?B?NXJyY1pDc2JWN29RcWNBV0hycVl2cWt5S1pJbWc3ZUkvYlRYZlJvRGN6Wnpu?=
 =?utf-8?B?SVJROTVaVjJXcURBeHRJT2RkTk0yWWdDTmg4RmJvZWNRbzFkN3hrOXFPeHp6?=
 =?utf-8?B?Z2RRWkhJVlZxZzNBZUN2MUVGSkQ1WWVZNDl3WGU4SHYvTU40ejhhSVh5SU9Y?=
 =?utf-8?B?TVN4MThETXpONjdQVjVpSU1pai8yRGlUSGduRHBqUHp0VkdUbVZ6ZlhVUFdu?=
 =?utf-8?B?c0tTMzlubytLUkRkR1o0aCtFWEtXT0ZBSHlmTGkvN1piRGVwMlFTd256aG5m?=
 =?utf-8?Q?RfXvXnsQYB/yW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDdlM0RqNi9weUN6UVhYT0d2MnVxc0pQRGYwOEp4Z00wTTBhMEoxaHI5RGhO?=
 =?utf-8?B?bUpCMXZmUnNmZlFRS0gzd2tRQ21UQzF1c0M4RjFvRExCVktUdlVjOFhNTXhm?=
 =?utf-8?B?dkxoYm8xREJXTFdIU2JBcFVsejA4dkZCMVptcC9SQmN1RDZlNUIvMGhDbExr?=
 =?utf-8?B?WlJUbmVNV0Noa3pmUCtUZml0alJoUmVOdndNUzM5TlpsOW9ZNUtVUmxiV3JW?=
 =?utf-8?B?UFQxUzJRT0toMXFMcWROMHdKZHg1akFPa1lCYXkra2lGVS9zTW1WUU5pRGxO?=
 =?utf-8?B?V2RWOXlxR0VrZlQ1MjYyM1g2KzV0eHFEQSswYU00OFhiMmZKM1dtLzRaSSts?=
 =?utf-8?B?Y1hBTDNqWU8vRjFseGZCdjR1WU5jdHdvRlZQUjY5Wk1rSWNEM3k4SWk1V1Ix?=
 =?utf-8?B?MVN3TFV4b1Q1Y2VFelRHbkVVZERFdWR0bWQ5UDVtdUlNUmRadFFUNTQ5RVlR?=
 =?utf-8?B?bHVsckpsM1NjMDZUeWRBUjhpOXg5blRuU3pIMUg1b0lhRUM2TGNHbWpCN0o1?=
 =?utf-8?B?N1o0dTh5UWpBVDZmaXViUGpNby9ESVVVR2cvb1pSQ1VqVkxTejdvWnZqVlBu?=
 =?utf-8?B?OVQwVFNhS2tVWUgvM2dQQ0lmTS9SeG1kV3dzS3I4MFNFRmFnSnhmeDREWGZV?=
 =?utf-8?B?dS8ydEtOYW1WK3dyVngzYTgySFJKMXR6a1BTMDA5Y2M3cW9kamwwQ0U3MFdF?=
 =?utf-8?B?S2xXT1RuMUgxdER0RFZ5Ym0wRGpvaEg5V2k0bHU3R3dnamthODcvNlRUdERK?=
 =?utf-8?B?ZWJ6QVlmekhHRnB2bzN3dDBzMnlqb1lTekhoZENvUC93Q1pPWC9jcFFQSUVh?=
 =?utf-8?B?NmZadFdqc0hkdnd6Y2ZobXErVzR2Y0ZLQVlJSnJkSWhBaEtuNmJhTFpDNTIz?=
 =?utf-8?B?STVSV2pvdVg4elk4Qjd1ZDJxVE9OeWFZS0U4ZGwydmNKUXRCMXVjYW1qTlZ1?=
 =?utf-8?B?ZjVVWHo4MnpWMTFKbVZObTRxZEk0WjVCdVp2azYwWHFkV1MzSjZ6ZnBCNzdi?=
 =?utf-8?B?TkxOVWxGNjUraktObU0rc2NlVEFMcFhyc1pXeWM1Zk96cTlHbTRncFN5MERL?=
 =?utf-8?B?cFg5eUszZzRaeE4xS2VzTUFvaEZGQXZIREhhOFVaQVBDN1BkUHV3TXVuTGJt?=
 =?utf-8?B?L1phVjBUS1hhakFmd3FibkFubitWOHAwWDZpVWd5R3ZYSmxOZEpLL1VUMWx2?=
 =?utf-8?B?YzkzdlFUZE5QLzlrOVNrOVBGZmRJOUJ5ditCYVNQenRUR2hRNjhIVXVxc2My?=
 =?utf-8?B?cUJ1RUx0NlBEdUcrVnNTUWEyZTI4cmZYRkpldndwRTZMQUMyTGU4aXV6ZWNJ?=
 =?utf-8?B?WFJvV3ZCWDFjSGV6dVJaZFQ0aUFVLzgrbnlDVTE1QU50NkpNcGg1dmFXcVhn?=
 =?utf-8?B?RzlLdHFIdTVLTTVqeG5ZOVZDVndTbDIrelkxZlpWdDN2MHVack45eFpBQis0?=
 =?utf-8?B?akRRK0hxdjUwVE5xakNaZ2JoNExBVzQrbk1uc2lpK1padDJ1dEF1d2pSQ0hh?=
 =?utf-8?B?c1BsTFhQcFNxV2pPVlVocHpqTUZPRExTMVQ4S3dmVWVtNHZ2UkwvMGJXUDRh?=
 =?utf-8?B?YVZtK3FRZlB0WVNzQkQ0eFZDS0FsYjZMVDl3MEhhQllwd3hnN3FWSnB2dGgr?=
 =?utf-8?B?SWR3MXJYSldTejVFRlMzai9kQ3F5cU5KQ0JsOEVKcHBMbVcwZkdXWVo0OWhs?=
 =?utf-8?B?VS9hb2JIVHpDU3lFdVFrL0pGLzZ1TjRKSGxBRUtPejYvYXVJR1FpeWJkM1ZX?=
 =?utf-8?B?ck9MWnYyOVNDcjJ6YzNCVi9meis0YlZFZzdiVXg1SVQySDU3T2lJdzhzOU9a?=
 =?utf-8?B?RkpOZmpsOUpHTlpaVy9ZQ29lYWhvR2Uzaml1ZWV0NDdPcVBZV1JxVlozNW9K?=
 =?utf-8?B?QTUyblQ1SXlpaVpnTWpFQzdLaFRRSWdzbWljcmNURnR4VEkxdk9FeFcyTEcv?=
 =?utf-8?B?RXVsQThzRWowRU5jQ2lpOUt4Y2w5dUY1NmJYamRuV2lBSGIrYS9wbytjQm1F?=
 =?utf-8?B?bkVVRm9pQTR6Si9FTVYzdUsvWEVBc0F5OWlTVWtEMlRsWnhsQXdpdURpTlVT?=
 =?utf-8?B?QVpBb1hHbGFWVEh3SFRGRjc0UndBRVBWZDBiVkNjSmFQZ2pqbE5NdHBkWlZo?=
 =?utf-8?B?Yi9hVzg1NXNYVnBvazZpdTJRV3JmLzR1RHk0QXNDL2FESG9wTTVzcDA4Q3or?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8a49b2-3bb3-4d86-90ad-08dd5bf634bc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 14:58:36.4594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyPDmivssTCuKzRBJPaxAz7inYWZdxKzkdR4Y1xKeNpg5oAMfPW2uGHtlZw7Oflz3hlS+hWKSF0ope2Om+Jd/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6616
X-OriginatorOrg: intel.com

On 5/03/25 15:54, Jiri Olsa wrote:
> On Wed, Mar 05, 2025 at 02:47:09PM +0100, Jiri Olsa wrote:
>> On Wed, Jan 22, 2025 at 03:41:03PM +0800, lirongqing wrote:
>>> From: Li RongQing <lirongqing@baidu.com>
>>>
>>> Avoid unnecessary per-CPU memory allocation on unsupported CPUs,
>>> this can save 12K memory for each CPU
>>>
>>> Signed-off-by: Li RongQing <lirongqing@baidu.com>
>>> ---
>>>  arch/x86/events/intel/bts.c | 22 +++++++++++++---------
>>>  1 file changed, 13 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
>>> index 8f78b0c..8e09319 100644
>>> --- a/arch/x86/events/intel/bts.c
>>> +++ b/arch/x86/events/intel/bts.c
>>> @@ -36,7 +36,7 @@ enum {
>>>  	BTS_STATE_ACTIVE,
>>>  };
>>>  
>>> -static DEFINE_PER_CPU(struct bts_ctx, bts_ctx);
>>> +static struct bts_ctx __percpu *bts_ctx;
>>>  
>>>  #define BTS_RECORD_SIZE		24
>>>  #define BTS_SAFETY_MARGIN	4080
>>> @@ -231,7 +231,7 @@ bts_buffer_reset(struct bts_buffer *buf, struct perf_output_handle *handle);
>>>  
>>>  static void __bts_event_start(struct perf_event *event)
>>>  {
>>> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
>>> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
>>>  	struct bts_buffer *buf = perf_get_aux(&bts->handle);
>>>  	u64 config = 0;
>>>  
>>> @@ -260,7 +260,7 @@ static void __bts_event_start(struct perf_event *event)
>>>  static void bts_event_start(struct perf_event *event, int flags)
>>>  {
>>>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
>>> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
>>>  	struct bts_buffer *buf;
>>>  
>>>  	buf = perf_aux_output_begin(&bts->handle, event);
>>> @@ -290,7 +290,7 @@ static void bts_event_start(struct perf_event *event, int flags)
>>>  
>>>  static void __bts_event_stop(struct perf_event *event, int state)
>>>  {
>>> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
>>> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
>>>  
>>>  	/* ACTIVE -> INACTIVE(PMI)/STOPPED(->stop()) */
>>>  	WRITE_ONCE(bts->state, state);
>>> @@ -305,7 +305,7 @@ static void __bts_event_stop(struct perf_event *event, int state)
>>>  static void bts_event_stop(struct perf_event *event, int flags)
>>>  {
>>>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
>>> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
>>>  	struct bts_buffer *buf = NULL;
>>>  	int state = READ_ONCE(bts->state);
>>>  
>>> @@ -338,7 +338,7 @@ static void bts_event_stop(struct perf_event *event, int flags)
>>>  
>>>  void intel_bts_enable_local(void)
>>>  {
>>> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
>>> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
>>>  	int state = READ_ONCE(bts->state);
>>>  
>>>  	/*
>>> @@ -358,7 +358,7 @@ void intel_bts_enable_local(void)
>>>  
>>>  void intel_bts_disable_local(void)
>>>  {
>>> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
>>> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
>>
>> hi,
>> I'm getting crash below in here
>>
>> I think it's because we allocate bts_ctx only if there's X86_FEATURE_PTI,
> 
>  ... .if there's not X86_FEATURE_PTI ;-) ...
> 
> jirka
> 
>> but then intel_bts_disable_local is called unconditionally from
>> intel_pmu_handle_irq and exploding on accessing bts_ctx
>>
>> there's no crash when this change is reverted

It looks like there are 3 functions affected:

	intel_bts_enable_local()
	intel_bts_disable_local()
	intel_bts_interrupt()

Perhaps make them static calls?

>>
>> jirka
>>
>>
>>>  
>>>  	/*
>>>  	 * Here we transition from ACTIVE to INACTIVE;
>>> @@ -450,7 +450,7 @@ bts_buffer_reset(struct bts_buffer *buf, struct perf_output_handle *handle)
>>>  int intel_bts_interrupt(void)
>>>  {
>>>  	struct debug_store *ds = this_cpu_ptr(&cpu_hw_events)->ds;
>>> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
>>> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
>>>  	struct perf_event *event = bts->handle.event;
>>>  	struct bts_buffer *buf;
>>>  	s64 old_head;
>>> @@ -518,7 +518,7 @@ static void bts_event_del(struct perf_event *event, int mode)
>>>  
>>>  static int bts_event_add(struct perf_event *event, int mode)
>>>  {
>>> -	struct bts_ctx *bts = this_cpu_ptr(&bts_ctx);
>>> +	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
>>>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>>  	struct hw_perf_event *hwc = &event->hw;
>>>  
>>> @@ -605,6 +605,10 @@ static __init int bts_init(void)
>>>  		return -ENODEV;
>>>  	}
>>>  
>>> +	bts_ctx = alloc_percpu(struct bts_ctx);
>>> +	if (!bts_ctx)
>>> +		return -ENOMEM;
>>> +
>>>  	bts_pmu.capabilities	= PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_ITRACE |
>>>  				  PERF_PMU_CAP_EXCLUSIVE;
>>>  	bts_pmu.task_ctx_nr	= perf_sw_context;
>>> -- 
>>> 2.9.4
>>>
>>
>> ---
>>
>>   [    9.615480] BUG: unable to handle page fault for address: ffff9eb419247000
>>   [    9.615484] #PF: supervisor read access in kernel mode
>>   [    9.615485] #PF: error_code(0x0000) - not-present page
>>   [    9.615487] PGD ba801067 P4D ba801067 PUD 0
>>   [    9.615490] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
>>   [    9.615492] CPU: 0 UID: 0 PID: 492 Comm: test_maps Not tainted 6.14.0-rc4-g5d70396a7df7-dirty #1
>>   [    9.615495] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>>   [    9.615497] RIP: 0010:intel_bts_disable_local+0x18/0x50
>>   [    9.615501] Code: 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00 65 48 8b 0d bf 1f 7b 02 48 8b 05 e0 b7 7d 02 <8b> 94 01 00 20 00 00 83 fa 02 75 1f 48 83 3c 08 00 74 18 65 48 8b
>>   [    9.615503] RSP: 0018:fffffe71b3e00c78 EFLAGS: 00010002
>>   [    9.615504] RAX: 0000000000000000 RBX: fffffe71b3e00ef8 RCX: ffff9eb419245000
>>   [    9.615505] RDX: 0000000000000001 RSI: 000000023eb5576c RDI: fffffe71b3e00ef8
>>   [    9.615506] RBP: fffffe71b3e00e38 R08: 0000000000000002 R09: 0000000000000002
>>   [    9.615507] R10: ffffffffa023f735 R11: ffffffffa020dfe0 R12: fffffe71b3e00ef8
>>   [    9.615508] R13: 0000000000000000 R14: ffff9eb419245000 R15: 0000000000000001
>>   [    9.615508] FS:  00007f25164ac140(0000) GS:ffff9eb419245000(0000) knlGS:0000000000000000
>>   [    9.615510] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>   [    9.615511] CR2: ffff9eb419247000 CR3: 000000010b31c006 CR4: 0000000000770ef0
>>   [    9.615514] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>   [    9.615515] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>   [    9.615516] PKRU: 55555554
>>   [    9.615516] Call Trace:
>>   [    9.615518]  <NMI>
>>   [    9.615519]  ? __die_body+0x6a/0xb0
>>   [    9.615521]  ? page_fault_oops+0x36f/0x400
>>   [    9.615525]  ? do_kern_addr_fault+0x9a/0xd0
>>   [    9.615526]  ? exc_page_fault+0xab/0xf0
>>   [    9.615528]  ? asm_exc_page_fault+0x26/0x30
>>   [    9.615531]  ? __pfx_perf_event_nmi_handler+0x10/0x10
>>   [    9.615533]  ? nmi_handle+0x55/0x2b0
>>   [    9.615536]  ? intel_bts_disable_local+0x18/0x50
>>   [    9.615538]  intel_pmu_handle_irq+0x88/0x8b0
>>   [    9.615545]  ? look_up_lock_class+0x74/0x150
>>   [    9.615546]  ? verify_lock_unused+0xb/0x80
>>   [    9.615549]  ? lock_acquire+0x1a0/0x2a0
>>   [    9.615551]  ? nmi_handle+0x55/0x2b0
>>   [    9.615553]  perf_event_nmi_handler+0x28/0x50
>>   [    9.615555]  nmi_handle+0x116/0x2b0
>>   [    9.615557]  ? nmi_handle+0x55/0x2b0
>>   [    9.615558]  ? _copy_from_user+0x37/0x80
>>   [    9.615561]  default_do_nmi+0x41/0x100
>>   [    9.615564]  exc_nmi+0xb5/0x110
>>   [    9.615566]  end_repeat_nmi+0xf/0x53
>>   [    9.615568] RIP: 0010:_copy_from_user+0x37/0x80
>>   [    9.615570] Code: 89 f7 49 89 fe 48 c7 c7 19 16 49 a1 be a2 00 00 00 e8 8d 3e cb ff 48 b8 00 f0 ff ff ff 7f 00 00 49 39 c7 4c 0f 47 f8 0f 01 cb <4c> 89 f7 48 89 d9 4c 89 fe e8 fb cd 65 00 48 89 c8 0f 01 ca 48 85
>>   [    9.615571] RSP: 0018:ffffa49b403dfdb0 EFLAGS: 00040283
>>   [    9.615572] RAX: 00007ffffffff000 RBX: 0000000000000008 RCX: 0000000000000001
>>   [    9.615573] RDX: 0000000000000001 RSI: ffff9eb38b2c3950 RDI: ffff9eb389f40b58
>>   [    9.615574] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffffffffffff
>>   [    9.615574] R10: ffff9eb389f40b78 R11: 0000000000000000 R12: ffff9eb382711000
>>   [    9.615575] R13: 0000000000000000 R14: ffff9eb3824fd920 R15: 00007ffd584f7268
>>   [    9.615578]  ? _copy_from_user+0x37/0x80
>>   [    9.615580]  ? _copy_from_user+0x37/0x80
>>   [    9.615581]  </NMI>
>>   [    9.615582]  <TASK>
>>   [    9.615582]  ___bpf_copy_key+0x52/0xb0
>>   [    9.615586]  map_update_elem+0xd4/0x280
>>   [    9.615589]  __sys_bpf+0x450/0x550
>>   [    9.615592]  __x64_sys_bpf+0x1c/0x30
>>   [    9.615594]  do_syscall_64+0x79/0x120
>>   [    9.615596]  ? clear_bhb_loop+0x35/0x90
>>   [    9.615597]  ? clear_bhb_loop+0x35/0x90
>>   [    9.615599]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>   [    9.615600] RIP: 0033:0x7f251668e25d
>>   [    9.615602] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8b bb 0d 00 f7 d8 64 89 01 48
>>   [    9.615603] RSP: 002b:00007ffd584f7128 EFLAGS: 00000206 ORIG_RAX: 0000000000000141
>>   [    9.615604] RAX: ffffffffffffffda RBX: 00007ffd584f76b8 RCX: 00007f251668e25d
>>   [    9.615605] RDX: 0000000000000020 RSI: 00007ffd584f7170 RDI: 0000000000000002
>>   [    9.615606] RBP: 00007ffd584f7150 R08: 0000000000000000 R09: 0000000000000000
>>   [    9.615606] R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000001
>>   [    9.615607] R13: 0000000000000000 R14: 000055bd9b4e01b8 R15: 00007f2516801000
>>   [    9.615609]  </TASK>  [    9.615610] Modules linked in:
>>   [    9.615611] CR2: ffff9eb419247000
>>   [    9.615613] ---[ end trace 0000000000000000 ]---
>>   [    9.615614] RIP: 0010:intel_bts_disable_local+0x18/0x50
>>   [    9.615615] Code: 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00 65 48 8b 0d bf 1f 7b 02 48 8b 05 e0 b7 7d 02 <8b> 94 01 00 20 00 00 83 fa 02 75 1f 48 83 3c 08 00 74 18 65 48 8b
>>   [    9.615616] RSP: 0018:fffffe71b3e00c78 EFLAGS: 00010002
>>   [    9.615617] RAX: 0000000000000000 RBX: fffffe71b3e00ef8 RCX: ffff9eb419245000
>>   [    9.615618] RDX: 0000000000000001 RSI: 000000023eb5576c RDI: fffffe71b3e00ef8
>>   [    9.615618] RBP: fffffe71b3e00e38 R08: 0000000000000002 R09: 0000000000000002
>>   [    9.615619] R10: ffffffffa023f735 R11: ffffffffa020dfe0 R12: fffffe71b3e00ef8
>>   [    9.615619] R13: 0000000000000000 R14: ffff9eb419245000 R15: 0000000000000001
>>   [    9.615620] FS:  00007f25164ac140(0000) GS:ffff9eb419245000(0000) knlGS:0000000000000000
>>   [    9.615621] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>   [    9.615622] CR2: ffff9eb419247000 CR3: 000000010b31c006 CR4: 0000000000770ef0
>>   [    9.615622] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>   [    9.615623] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>   [    9.615624] PKRU: 55555554
>>   [    9.615624] Kernel panic - not syncing: Fatal exception in interrupt
>>   [    9.615807] Kernel Offset: 0x1f000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>>   Failed to run command

