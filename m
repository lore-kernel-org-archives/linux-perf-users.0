Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7229833AD88;
	Wed, 12 Aug 2026 06:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786514868; cv=fail; b=OwLJpabaxQ2P+hWS6ur9+JlfDYmHanKHY/mHU5pn2mIe2FeWi4xZJz700aF/gGBoq4RUBOYQb9MKufOcCf28w1ydQ9QEXVBjrpSBWlS+Pk3lDE1raM94qEt40Rep+FsXMuH1ELsrzoHdKieEvopLsCWn1Ako8FFJif2DrFQUl4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786514868; c=relaxed/simple;
	bh=MYPw91Nlt258A1FMqn60H+Xu+5ibDRi0x6sOi/kKKUg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NhZFOWJBNYmj87rDwLkeCzbkBFDmeSO5KfyYOT0fVY70l8plcYRd3Gt2NdnexNmKNgdBL2WvvoKSwc/21R9fCIFKL9/f5xmtK+oKFV3U/yOJ2Foxwr3lkOaz0UhuSe/fmY3C5nq4G/HyxmsajKJ49/Ypkde47QZkclCbei68caM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AEpY0n9a; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AEpY0n9a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786514865; x=1818050865;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MYPw91Nlt258A1FMqn60H+Xu+5ibDRi0x6sOi/kKKUg=;
  b=AEpY0n9aEjvBDgJ470TI0Qhw9aAK+KrvvBAylP0V/IQcGFrknuvgSihD
   nwbnlf0nPdp+DOLyyFvgeNIXP6x8ng7TtsRu8WdDR9Gvr0yb71LKLlGiZ
   Xj1H90gVT384/9DRS0h9vnQAOLYOVGdM+D459vfyCRqnArclsKhRn1XDP
   1XzjbqoGy7FL1w4Zh2SsKwijP0X359wFh4SXSsBy9RF3rGPjd8jZ3Nyzk
   4OkuCHk0eqLb6e01SmEtzGVHYb6Df6Q+Ywq44zBeLLq+drBs0YPorDTXY
   Iblagg7Hg83XQzIBgZ4ooC7RuySv4HoJ7YmMUgX+Iw2Y8HSTUMK9abgm9
   w==;
X-CSE-ConnectionGUID: +wbfFsp7Q9SSduELP/c/Tw==
X-CSE-MsgGUID: WoXLv1MZThCOM6F/ERneOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="97721600"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="97721600"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 23:07:40 -0700
X-CSE-ConnectionGUID: J9BeHcEBQiOcJ50HuQw3zw==
X-CSE-MsgGUID: qM/H/qEpRXO08CMYllWsFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="268697586"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 23:07:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 23:07:39 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 23:07:35 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.29) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 23:07:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akrUnVRBIvRa6XLWYyAMih9EfieG+dTldlv3x1Gl+i+/0Lo1KEnQltm+9PU0m4HipEPoAosSPbcwAFIfhJxdg/EpGcYiQHqMAYdHyqbEXArx0wREKpuKTf2VkVt6dnZMJLcfCvziWr3RNSjtjBBwLNCR9dfw3okxvdVTNftEOaZcZqr6UHiuVOnTqZj9slLO2xDDby0xpz+bvIjaYZHrSKtIgWR10WAjy6zR5BFLZfFgP6r56RfwUu7c3qCqHF5+9IOVyxaeVMnPGfCSYRIj5jO7d7/LoBjOIgJvnmXWQN4h9yct9XinEG5jaK5TfbgcszLQ8mxK5huqGrm9K9Gd+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJLD8kJhehiQcwCIeA2NSSwya/kYyAkS8yGkK7fL0Pw=;
 b=wrP6wbYxXo8UJMu6wOq1/YwJ/7NVC+vMzu8S8tCZ9FhUZlJ9ElO4kEJAiX+T/mDK+Ja1GkPSNFwCRgHBsnLSPtMziLfHohCOT8GA3LRhu7Wcopu5XYs4NdpgbRier3gjEYN+61xL5PHFJtNfmXU+mO6JG+bn7GL/67c+3GmScoNoZigSjgZPS/Z4Ci3JUqA6CoNWuxO4jwzR9/2QNqScNaPj5heCcUErld9kaUuQchCxEiAdlM/gcOmBZ4C+qeoU7tCw4XYvLSFiitK3rBOTrIYunuWSvlWUXG5zLwWhUL/OWWqYCtgToFYGo9Nku2YQyS0wib/AGZvKIeD2PX5stQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7215.namprd11.prod.outlook.com (2603:10b6:8:13a::13)
 by IA0PR11MB7954.namprd11.prod.outlook.com (2603:10b6:208:40e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 06:07:24 +0000
Received: from DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::cba:8493:6cff:5cf7]) by DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::cba:8493:6cff:5cf7%6]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 06:07:24 +0000
Message-ID: <b9a642f7-f8a9-425b-98ad-b779f9501db8@intel.com>
Date: Wed, 12 Aug 2026 09:07:16 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/23] perf annotate: Deduplicate overlapping ARM SPE
 events for data type profiling
To: Tengda Wu <wutengda@huaweicloud.com>, Namhyung Kim <namhyung@kernel.org>,
	<james.clark@linaro.org>, <xueshuai@linux.alibaba.com>, Li Huafei
	<lihuafei1@huawei.com>
CC: Peter Zijlstra <peterz@infradead.org>, <leo.yan@linux.dev>, Ian Rogers
	<irogers@google.com>, Kim Phillips <kim.phillips@arm.com>, Mark Rutland
	<mark.rutland@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Bill Wendling <morbo@google.com>, Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Zecheng Li <zli94@ncsu.edu>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-10-wutengda@huaweicloud.com>
 <20083f61-9724-445c-ad45-d77f9e8d2266@intel.com>
 <1910f712-8ea6-4916-82ac-0c1c2eac653c@huaweicloud.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <1910f712-8ea6-4916-82ac-0c1c2eac653c@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0217.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::11) To DS0PR11MB7215.namprd11.prod.outlook.com
 (2603:10b6:8:13a::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7215:EE_|IA0PR11MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: ae0de63e-4e51-4156-2e01-08def837fa2b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|10067099003|6133799003|56012099006|4143699003|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 8Qse2vKOPv49BhC5sRv5aJiRkv6Ay3NrR8aZjn1i3STcWxprBf2Y/6TMP0uTTCRrigj8c/Dpx2LCBch+FQ5a6rf/ie1E/KFjxYSWgbR35PzxegCTUzrNtKOVmaeXUZNmJuCk4eIQRfnQwNn+2ul8q0eHjj5amFCVyww2XllPUssaKXH9NIDM6J29+ZScnKmhi+VtY35sGOaSqZ99DP2Tf+CSBc+5JI2adLA4KbQMb5HrrrUTMfK4m177LuiuKXb9GV+qtL4Rx21fMPrKDg3DsCOCDKzp5S4+iKKH+oz/xrVlaU6KHVlH+CJKuqnC2Ggw5haY5oi1H4LfllTRQv/LIGEBIe/3WdBit0QdhREybbnS/djq4d7OnBu9QiWfChOSb8L2GcQmEmn+NRGpjYsMiAG25by/s4NOaWfkXs/Am8+FghwlSwFD1nIpjVlJOm/1QkqIRdibPMPdkkvTS17SOBN4LsDjcIIf51GwwWiVoXVCUy9LrC1VnfJyrkwaG6zuS0IASlcFn/KLVyaBqPGpzgz6FqnkNX5cF3HbSCPlyDZi1gdC6Oku7flCdpSDleJFy1aO/xz5FP5HfkyJ/vSRVjW01RAtCKaioJlIjl8OKRBIuI9c4nwTQ0RUDFN478cL4sjngrcwwhvk6RcxsMtxfXo3lAmM7LqFHVkbV6E051E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7215.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(10067099003)(6133799003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVNFaUFQdmw3aFdqUkgwcmJJUjU3a3FUK1NVSWVmckVFMzc5cWN1TmQreTBI?=
 =?utf-8?B?RHZQMmJhV203dkxmZ0U2N2loK2FVdnh3bTRSWEcxb2ZmRFJqanh2N3IrbG1q?=
 =?utf-8?B?djI3OFpaZVdQU1FPc3JHSDdETllNdjRDMGFFYlZpbEVrQmpqWHZPdGpLV3k0?=
 =?utf-8?B?cTVJV1ptbHQ5M0JPVzhCNjRLTEdQa01SMHExZGk5STJxNFVsMi9rWnR1V1l3?=
 =?utf-8?B?TzYzZDA3dk1pK3NmbFFYSExNWm5xeFJoSzNpTFhMZm9QREgra0hvRWEwZjBY?=
 =?utf-8?B?dThrUWd5Q1UxaGRSYnNqK2xyTE5sVll5cVh5RnNKZ0hXVUZvcWphWThDbTZX?=
 =?utf-8?B?NUFMaUxHWTNpZG5Nc0hEbEczSnpJL2JXUlNjaEhNS0hjRytiek5BblBoVzU1?=
 =?utf-8?B?WHJudm1qNThUMWNaT3ovcGExNytIbDNKQnVaa3d5ZG9KYmJEc0F3ZnB2QVI0?=
 =?utf-8?B?YTN4NXdQYTY5aFo1MlZTK0JuUVlOdk9VTVNKdE5xTTNEZFVSeTN0c3hqUDds?=
 =?utf-8?B?ZFZJQTd2Sy9xT1ZKL0JmdlFta2ljNGRUMkVPNW5kcjlXK1VJVTFldkpnMStS?=
 =?utf-8?B?YnVWdzZ6SE1EcVBXSGV2T1BkaVJuQXRrQkFmNUdzclZBVDNpOTVjd0p3cllT?=
 =?utf-8?B?dXNUZlV5UDJTeUFOV3k0bnRldEhIQzZBZWp5RVhCUkI0Z2FDWXFvMFp0SldH?=
 =?utf-8?B?WW5UWXJYY2l4Z2xyWmwxL0d4dFNvMjBZWXVPdENsL2NCckRURmV2UDlEV0o0?=
 =?utf-8?B?bTFFZlhXelJOOWlHTUJiYmZPWktGemZNU2dEQ1ZlZnBncDdKUDA2N2UxU3lS?=
 =?utf-8?B?eHJEOUYrb0loSDVoZCtNelJoT0dqWks4SVQ1N2NUZlYvT0VGbzR4OVRuRDM5?=
 =?utf-8?B?WldadTZSMGh5bUp0M0Y0TmtRUVpLdkIwaDBsbGExclFwMHozNHNZZkFFalRX?=
 =?utf-8?B?VnRoSGE5MGFYMmN1UENFRkNvd1J0TWM5RVV0cDB0SW43UEhLN1luTTY4eDRi?=
 =?utf-8?B?azM3cGE4cm1XeXhiTlVBZlZPdndML1dvMEtOT0lZZzR1OTNlcnhJaWJhRUV3?=
 =?utf-8?B?VW9rNTBuaVBQU3Bjc05lNUFLbUNUOTlDNGdDWnkvaThNRFBJRGdaSnMxMUV1?=
 =?utf-8?B?SGxrRzVjVGs5ZVI3T04vWXNMb0VvMHZVMGk5aGhaVW4vcEVlSGFxZDBmSlZx?=
 =?utf-8?B?N3ZZcXMrdkJrRUQ3WUJ6eVI1ZjNqVGhhbWgyTHVXcXphOWQySXZRUTlJMkZv?=
 =?utf-8?B?MkthdVlxcEFBbXFsekxMYnNZV3FDbTBaWTFrdGJLajF3WG44V1A3Q1UxM3ZR?=
 =?utf-8?B?a2FNYloxRjgzUk9iTHhHNHJEOWlvd1RHclpIR2RPT3F1aWYvNDJrTHhkMXZw?=
 =?utf-8?B?YU1GUlpRczcrTWUrcTZ4MHI1OC9Ga0JqaUdkdWhQV245VklSeDhQTFp4VGx5?=
 =?utf-8?B?eVN2NkUrTUpjR1VFTlp1dnRWMmJyNGdmWkN3NG5TYjZqOUpBaitvSWlBaVR3?=
 =?utf-8?B?cENhUVhzbmJ6WE5qcFpGRVQwN3pDUm1VTUZNbUsxSkJzOUFjRHRtbjRlLzRC?=
 =?utf-8?B?bE4rVlRLcXQ5aHVXSzkwTmhVc0JHQkltZlBGdGZaR1o3UEpsUWxYaUk1c214?=
 =?utf-8?B?eVQxY2RhRFVycFgyQmU3RFBQVC81S0krZEFhelN5QnRLNy96L05IWXZtN3Q3?=
 =?utf-8?B?bGNxNkp2cjJZeG50cHdXRmRSamJqN3QvblEreUJhTFRZWnlCUDlrV2hXdExW?=
 =?utf-8?B?R0xFbFFrcnVDWVRVaUdpd1RiMjhrQkRMdjBqczNac1BHVER2Q1Y4Z2hWUEtE?=
 =?utf-8?B?ZjRmWGtOa0hBUTVKVHZ2d1NBdDFQbnQrMVVXV2VvVnh6WDFJTFFxaFBCKzRE?=
 =?utf-8?B?U1B1Mm0zR2NTZnJDTVVKMWpMN2JPbHE3ODkwczFDam9YN0xJUjg3bEJHZ1p4?=
 =?utf-8?B?UVBwYm0wZ2NYOEsxK1FpVlRyOHpBbXRPdWpOYUM2Y2lzdTR1RjFVb2d6TTYy?=
 =?utf-8?B?Q1lzMTkzMDFvNHFqUFFtYVNTelRtQXBrVkpURHlyeVNqN3k0RCtRelQzaFVo?=
 =?utf-8?B?V01CYTRiZ0RlWFB1aHcyS3pnaDdsYlZMRFA0M1Y3Uy9HU0MwR1RvY3ZQejZZ?=
 =?utf-8?B?Y0hBelpWQ1FGdC9sQlNRaHN1NnltZi96MXlDbmFQbkZaRjB1ZXJJQTBCMzhC?=
 =?utf-8?B?OE5oaDVUaFhEMkV6UWVlZjFRWExKWkF1NG54dEdDS3dqcUlqQnJsM21hcFUz?=
 =?utf-8?B?SDBYSVQreThHTUNNYTZVYnFUQkZhOXRmY0M3UHEwckFjYW9HaGY0R3dRc1ls?=
 =?utf-8?B?Z1htbm5aN2xSV2lacWVwRWdZd0xibHQ5Q3c5MVVnS2g4aWcrTDFRK1dORVpW?=
 =?utf-8?Q?S5Po/QCgaTRC00hc=3D?=
X-Exchange-RoutingPolicyChecked: XBkEC8OyfNocMI7xy1xORhGjtj1987QFXbDQDNxCIM9B4Zh8Q9QP4IsDPP/AyxB/jJ9g4bUZ+nsW3kP4uzuFnrg5llRbY29eDbcuamENfArrj8cJLT+NwHBa58KUSGncqVZONx7UMEGCsGRY6fc2tg98/aKN1pEV8vMPyCOHG0cqfMFKN994eiFN3tCmStVAQi2UKa7nkDnipALTHXXhpQuVykoFabwNPNOUDDxYq12Xj/7ajoJsSNeOlvU19y14A9a6w3V6XCbAAh8jV1as/LOHfQgXwKWELmrE6fkBRKkOrb+YElQtVXC0/juAuVMJ6oKWOZW7JMO/k96OuJ7ePA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0de63e-4e51-4156-2e01-08def837fa2b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7215.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 06:07:24.0045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Vf8QXkJK7tvmxZnuRAXRRWWUpaSnHfxyrPLFX/D5JgE8ozGUGm5X1SWy+K2AsX6M/b1NUKAhGDGNa95Y+6ofA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7954
X-OriginatorOrg: intel.com

On 12/08/2026 05:28, Tengda Wu wrote:
> 
> 
> On 2026/8/10 14:57, Adrian Hunter wrote:
>> On 08/08/2026 15:23, Tengda Wu wrote:
>>> When data type profiling is enabled on ARM SPE, multiple overlapping
>>> events (e.g., l1d-miss, tlb-access) are synthesized for a single sampled
>>> instruction, as shown below:
>>>
>>>   Available samples
>>>   0 arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=30/
>>>   0 dummy:u
>>>   84K l1d-miss
>>>   95K l1d-access
>>>   77K llc-miss
>>>   58K llc-access
>>>   9K tlb-miss
>>>   108K tlb-access
>>>   0 branch
>>>   13K remote-access
>>>   108K memory
>>>   108K instructions
>>>
>>> While 'perf report' provides an interactive menu for users to select a
>>> specific event to prevent duplicate counting, 'perf annotate' lacks such
>>> a mechanism. Consequently, it counts all instructions across these
>>> overlapping events, which inflates the profile and distorts the data
>>> type statistics.
>>>
>>> Although using the '--itrace' option can work around this issue (e.g.:
>>> perf annotate --data-type --stdio --itrace=i1i), it is inconvenient for
>>> users to specify this explicitly every time.
>>>
>>> To address this, introduce itrace_synth_opts.dont_overlap. Set this to true
>>> when data type profiling is enabled and the user has not explicitly
>>> specified an itrace option. Then, during arm_spe_process_auxtrace_info(),
>>> adjust the synthesized event options based on the dont_overlap value to
>>> only enable instruction event synthesis, thereby achieving automatic
>>> deduplication.
>>>
>>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>>> ---
>>>  tools/perf/builtin-annotate.c |  8 ++++++++
>>>  tools/perf/util/arm-spe.c     | 17 +++++++++++++++++
>>>  tools/perf/util/auxtrace.h    |  2 ++
>>>  3 files changed, 27 insertions(+)
>>>
>>> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
>>> index 69cb72b2082a..616f54bf4868 100644
>>> --- a/tools/perf/builtin-annotate.c
>>> +++ b/tools/perf/builtin-annotate.c
>>> @@ -873,6 +873,14 @@ int cmd_annotate(int argc, const char **argv)
>>>  	annotate.session = perf_session__new(&data, &annotate.tool);
>>>  	if (IS_ERR(annotate.session))
>>>  		return PTR_ERR(annotate.session);
>>> +	/*
>>> +	 * Hardware tracing (e.g.: ARM SPE) may generate overlapping events
>>> +	 * per instruction. When data type profiling is enabled, enable
>>> +	 * dont_overlap to deduplicate them to avoid skewed stats, but only
>>> +	 * if user hasn't specified itrace options (respect user override).
>>> +	 */
>>> +	if (annotate.data_type && !itrace_synth_opts.set)
>>> +		itrace_synth_opts.dont_overlap = true;
>>>  
>>>  	annotate.session->itrace_synth_opts = &itrace_synth_opts;
>>>  
>>> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
>>> index 401aab529309..1721882423f6 100644
>>> --- a/tools/perf/util/arm-spe.c
>>> +++ b/tools/perf/util/arm-spe.c
>>> @@ -2033,6 +2033,9 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
>>>  		/* Default nanoseconds period not supported */
>>>  		spe->synth_opts.period_type = PERF_ITRACE_PERIOD_INSTRUCTIONS;
>>>  		spe->synth_opts.period = 1;
>>> +
>>> +		if (session->itrace_synth_opts)
>>> +			spe->synth_opts.dont_overlap = session->itrace_synth_opts->dont_overlap;
>>>  	}
>>>  
>>>  	if (spe->synth_opts.period_type != PERF_ITRACE_PERIOD_INSTRUCTIONS) {
>>> @@ -2044,6 +2047,20 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
>>>  		ui__warning("Arm SPE has a hardware-based sampling period.\n\n"
>>>  			    "--itrace periods > 1i downsample by an interval of n SPE samples rather than n instructions.\n");
>>>  
>>> +	if (spe->synth_opts.dont_overlap) {
>>> +		/*
>>> +		 * The 'instructions' event is the most comprehensive,
>>> +		 * synthesize it exclusively.
>>> +		 */
>>> +		spe->synth_opts.flc = false;
>>> +		spe->synth_opts.llc = false;
>>> +		spe->synth_opts.tlb = false;
>>> +		spe->synth_opts.branches = false;
>>> +		spe->synth_opts.remote_access = false;
>>> +		spe->synth_opts.mem = false;
>>> +		spe->synth_opts.instructions = true;
>>> +	}
>>> +
>>>  	err = arm_spe_synth_events(spe, session);
>>>  	if (err)
>>>  		goto err_free_queues;
>>> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
>>> index 6947f3f284c0..ebb4e9e8e574 100644
>>> --- a/tools/perf/util/auxtrace.h
>>> +++ b/tools/perf/util/auxtrace.h
>>> @@ -80,6 +80,7 @@ enum itrace_period_type {
>>>   * @intr_events: whether to synthesize interrupt events
>>>   * @errors: whether to synthesize decoder error events
>>>   * @dont_decode: whether to skip decoding entirely
>>> + * @dont_overlap: whether to deduplicate overlapping events
>>
>> This doesn't seem to match what you are actually doing, which
>> seems to be to choose particular default itrace options for
>> 'perf annotate --data-type'
>>
>> I wonder if this should really be handled by
>> itrace_synth_opts__set_default()?
>>
> 
> Placing this in itrace_synth_opts__set_default() may not be appropriate.

Your current approach introduces the concepts of
"dont_overlap" and "deduplicate" but doesn't actually
map them to specific functionality.  They are a mismatch
with what you are actually doing.

> 
> The current approach is designed to constrain the following conditions:
> 
> 1. Using perf annotate
> 2. With --data-type specified
> 3. Based on ARM SPE
> 4. Without --itrace explicitly specified
> 
> When these conditions are all met, we want to enable --itrace=i1i by default,
> effectively making this option built-in.
> 
> If we were to place the --itrace=i1i configuration inside
> itrace_synth_opts__set_default(), conditions 1, 2, and 3 would not be
> reachable from that context, as there's no way to propagate that information
> into the function.

itrace_synth_opts__set_default() is only called when 4 is true.

WRT 1 and 2, you are planning to pass information via synth_opts,
anyway, so it is the same in that regard.

>                    Configuring it directly there would take effect globally,
> impacting other commands such as perf report and perf script.

Not if they did not pass the new information, same as your current
approach.

> 
> Therefore, the current approach passes the dont_overlap information through
> itrace (satisfying conditions 1, 2, and 4), and then configures --itrace=i1i
> inside the ARM SPE driver (satisfying condition 3).

Why wouldn't that default be ok for other auxtrace implementations?

In any case, the problem is with the mismatch between the naming,
definition, and framing of "dont_overlap" and how it is actually used.

Perhaps instead:

	default_single_event_per_ip

and explain the annotate data-type use-case in its kernel-doc
description.

> 
> Thanks,
> Tengda
> 
>>
>>>   * @log: write a decoding log
>>>   * @calls: limit branch samples to calls (can be combined with @returns)
>>>   * @returns: limit branch samples to returns (can be combined with @calls)
>>> @@ -128,6 +129,7 @@ struct itrace_synth_opts {
>>>  	bool			intr_events;
>>>  	bool			errors;
>>>  	bool			dont_decode;
>>> +	bool			dont_overlap;
>>>  	bool			log;
>>>  	bool			calls;
>>>  	bool			returns;
> 

