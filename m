Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E8D249EB;
	Thu,  9 Oct 2025 03:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759981694; cv=fail; b=J6zKOAUzS4iEK57W9ShF61lpY7lUO7sHnfwnQOsyadMLeXuLubE2zd7hypSQz3ikLxXUsxmOPI31kcbuhR5novc6gr65REPmng0hM8Hy+wkNWrCKGsI4RCoLzk37AKB1hYAP8sp+5gXpPT/lTZcnIhgwxZgxZJnpkXMPSbuG5Vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759981694; c=relaxed/simple;
	bh=GMrX9zZ56bf+sEqgN+EbBtBajuOFSC/rXnRyYZby4PM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R7MthcLKZBUjDQExX+zfFsyxU4jIO2IHYQM2kLBSA8wdgOOAWchk8LRkqKuObaMRyjV1dz7hsKYcmff9EJp1r22YSmcW4Z0e/FdU7cuqOVekr4kfjrfU8M0uxr6txR37jpfevFP1nkjJUzho/25+yCMV5z5M1wLKEJYMgX/AgFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N9vdB6lq; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N9vdB6lq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759981692; x=1791517692;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GMrX9zZ56bf+sEqgN+EbBtBajuOFSC/rXnRyYZby4PM=;
  b=N9vdB6lqZm9pgSckGxdVldhf1jYwq25gCUG2l2JxlUWVwo7P38Aj59TN
   sKZB2yPOg/UZxAAtkMLtMqG+n1iUd4n0KGgSztzcekX2Fomg1+ItB4bdp
   ZSjQB43et4MbSsdT8+MBN2Fv1GFhUYKl7rESYO7VUf2rnP7FPlQp4txi6
   GrEIo0CuQQbC7ldSV9niT07lLziSwrz5c5GWge+s1byup0PFrpXQj1DDd
   zS4X4aEymlJzTNICH0L2Cgf2Eu6BtN6YYcaHh17nuPfIMFuNbDiFKT4rG
   sjGNCNvLAn061bzvLbsRA2ZSxC3y4Zb6r+eNcNEifwjXN2PCwZFJPgM3g
   g==;
X-CSE-ConnectionGUID: B5HrYN7TSguLcPwzsOByKw==
X-CSE-MsgGUID: 8piXQJ33QQGXcVFt43uQ4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="62278832"
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="62278832"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 20:48:11 -0700
X-CSE-ConnectionGUID: DuwARU7zQGi8VAyS48fIxw==
X-CSE-MsgGUID: ZpueDcH4SnOMQEMX8VCkLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="185734692"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 20:48:11 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 20:48:09 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 20:48:09 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.14) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 20:48:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsmaZUnqy/uJhlSEHDblFAo2zvZwYuE/4Ae3L1rbyGxcrOA9HosV/LZoAbMP8EQT1HbE5B+qiuTnjtcUDhuSbNHBpFJIfBpUEwz+fWOOP52KVUmL2He0JPiPZt5Zy31EUSARjqVyfxZ0QZciKB3Xn1SLPePBHKuh01jG+X20uhGF0Mrj1akWDyEGEdEYL5dtVb01znGKsX23nTMtGynCUNksXogZUuTU63eQ62jV0vGPc1asZjG2UgL4uBe3J45K8YeHT82ecZI1Zn0dBbqvn4gDEFF2+7hM4J6RHCuYGk3gyB4Ep18cSduFpkQnvvYC3TMHmGfNVTRfSd8GGg/RVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVYhbVSZrONoIaGtEQ8OGHw2vl4RQCwSgd7nzJvzXK8=;
 b=WiIwBE43WdC/7lR9ltYF8cXiKcVm/xCQaVg9Led+cVsT8JFfu+7mm7FZtVc7grq2XXWgX3LRsOiI1+J3Fw0jBXIXNi0bl+v49xHTCN6ecQaeo2CLMG8pRdNBnTGsVXePGA3DCpQKgbibMMV2WQI6yHKP8y9eebKMwFVzcUwxh0x/2cab+Km7Z8hyqpe+uwNQbV3lerSiidDzmfLG0s5pNOe0+e36lMfmyqo+PZposJ35XSVC48ijBycwXp+yCb3Ydd1IMDEsikC4s6CG6UxZEebDBTXpcYxENprluQrB8JzCgs8R0Gt1VjCSgAFwykeVKJ2wbQarQGQdL059KL/3Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB8289.namprd11.prod.outlook.com (2603:10b6:303:1e8::9)
 by IA1PR11MB7917.namprd11.prod.outlook.com (2603:10b6:208:3fe::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Thu, 9 Oct
 2025 03:48:07 +0000
Received: from MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022]) by MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022%6]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 03:48:07 +0000
Message-ID: <e7237995-ab43-46c2-a379-a6870d948680@intel.com>
Date: Thu, 9 Oct 2025 11:47:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] perf tools c2c: Add annotation support to perf c2c
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
References: <aNo-U0KquRbcJam9@google.com>
 <20250930123900.1445017-1-tianyou.li@intel.com> <aN9ZiPYyYtr332h_@google.com>
 <9fd778d2-8383-4675-b07d-4d8bdd5cf674@intel.com>
 <aOTOEcNOiUiEJ9tz@google.com>
Content-Language: en-US
From: "Li, Tianyou" <tianyou.li@intel.com>
In-Reply-To: <aOTOEcNOiUiEJ9tz@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU0P306CA0001.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:17::14) To MW4PR11MB8289.namprd11.prod.outlook.com
 (2603:10b6:303:1e8::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB8289:EE_|IA1PR11MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: c82f886c-33f2-47c8-a518-08de06e6a817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUpEd1lFT1JTNXk2UzhWb0JOaGY2eEwxRjA2VEF1WjZjY2hqbzZnMlVrbzV1?=
 =?utf-8?B?S3Buc1dZUkFYZzZUdmxwMVFjMlN0em5KNThoSm9BTEU3L29qemZhcDcxS1lY?=
 =?utf-8?B?dlZLbFcycGEvMmU2bXdJTFQzajNvc0FxaFplQ3JFVmI3dms1bFpCWm11VU5M?=
 =?utf-8?B?WlE0ekVqV0Q4SlJRNjgwcFpTVnA1YUs3YjQ5UXNGQmNDMzFTNjlYVE5kNTNM?=
 =?utf-8?B?SWNBV2xGd3p6d1Fua3ozOHRTMzhkMGVKd3pkWmRlUEkydzRxNXVYZEJHdndz?=
 =?utf-8?B?Q0FzRWVJS0ZGQkZqeGhGeUgzWjJNMEdIWGNFWHNvLzdKZ2xuU1NIbGpDNXNY?=
 =?utf-8?B?amhXR1hPVGNhWk0wK3gzTmFMcldmRGFIbFM3T2pzQ2ttMDN1b1JJNEswNXRs?=
 =?utf-8?B?RVJsYXhoTytxOWhydC8zb1NMbFFoRjhrTFpscjlxRGpTUzNibkl4U1c2LzNR?=
 =?utf-8?B?c2pSVlZZcCtyQUl2MlQrV28rOTNXREtkY2ZOdUo3aVpjWVBlUnRocWJPTFdK?=
 =?utf-8?B?SUxia3BxNEtHbzBWaEp3dlBxUFFuM3ZSd212algxMC9YbXNGZlNVYTJkdjR4?=
 =?utf-8?B?aFYzVHFTNVVZTXBXYmg2UUI5OXN5NnA4UVU3REZNQTlub3FzM0pvYjRwK2RR?=
 =?utf-8?B?ZjlucmYvSHpocG9uRU5tcFpoUjZ3ZndabVUxUnQzTkd3TTMrVnhtRk5BcHJ3?=
 =?utf-8?B?QnJKNzM0U2FycVFTNXQ4RkZwN0ZacjNMZ01nMS9ucWFlbzFveE9DVjJJbklK?=
 =?utf-8?B?Slc0SFh2Ykg5UTRpUktudDVwbnYrSFIxdG5wS3ZDNGdoM2c2UlhCUjRqbks3?=
 =?utf-8?B?V1AzNTBFdXRReFFRd3gyaWR6OUFtRmdoOTdKSjhQOGpWUHZvVi9UL09SR1lm?=
 =?utf-8?B?WjlqOWhXc2hMNGVQc1E3cmx0NXVPSzE3OVVUTmRYeGkvNmltWWZ0VmlRVG5s?=
 =?utf-8?B?Rk5NMzdtYm9wMmwyMzNtdEhleWhkQnE4alVYR0tSMkdxVTZncFFNMGhsU24x?=
 =?utf-8?B?Z2FNaVhQc0UvSHp2Nzk5SDQ1SlFKRjdtdlZDSWx3NHlBWC9ZSUFNTnJrMTFS?=
 =?utf-8?B?b1dSeWUvR3IrdnNJVEQ0d2s1STU3c1d1azR3am51M3cyQ3BYZTdKT2dtaHR5?=
 =?utf-8?B?R3g5V3BtRjJ3THRHVWp4a2hxQ3kzb0NKTTJ1eEFDbmhYam1McmJXMWlFbkgr?=
 =?utf-8?B?czB1QjVHQUtCNy84UkhEMGJaa295OHM0TlB0MkpBdGV1UERCTVFEaldyRUQ3?=
 =?utf-8?B?T3lhaWE2dlI1MDd6ZHo0cy9vejJFbklKT2NIUTRoOGxVVkdNL3pEL0YvNGJJ?=
 =?utf-8?B?cE1obU1OaW5nUlE1WmJLUXFVY3NLR3drNWZKRGUxb0RUWEJKNk1NUTFJeWpP?=
 =?utf-8?B?NmFncjBFcFJzTFQzbVdHVHpoRDMvYUJTa040Lzhiek1KSlRyT3NpMlNZSkVi?=
 =?utf-8?B?UlRwMExwV0JHN1dtOFpFczF2d05YWHlkWEoyR1lkd3NBTERZZHkwaGdHVXRR?=
 =?utf-8?B?Vyt1bTNnYjB5eVBzVFdWdDlxK0lkQXJDRWM5R0dIcVJXbjJ4RlNRdlRyWmxD?=
 =?utf-8?B?emhEc2RXanlqTjZJdStPc09vRkNNNHRYY3BwVW5reXN6Y2NpWjRMcnVhaTN3?=
 =?utf-8?B?dDJJVXBxL0JveVJabEZZWVpaOFE0VGVMR3dVakRlckFHSG9RSXI4cjNIdFlw?=
 =?utf-8?B?QXNlOFhhQ1dUUGt1TVlKWmwweVM4cXF3aHRvVjhqR3B6QnRRMHFUeGpoV0d5?=
 =?utf-8?B?TEFSSFFSRjJxbXhRdWpKZmlnT3hsc3FiSDV6UzVaQWhJNWJnSHNkSVlRWmNG?=
 =?utf-8?B?WlZiOS82bDk5cjgwODZ1NXpUSDFXOWVPTXNlclBJd3NhNkk4QTYycXlrZkM0?=
 =?utf-8?B?RGRtZ2dwaUdhcTBrUENtTW00b2VEYk9MTlpWdEpqOVMwTVdJaW5SOVZPQjVp?=
 =?utf-8?Q?082UP0sdV61P7Ffp8YuEpL+RvC4r+K4s?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB8289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1hrOFBZelgxQ3VyTUJUNzcxckFRR1RrN2tyaUxnSERWV202T1NKRXpPRnpQ?=
 =?utf-8?B?aWlJbEhwUWljemNqSko1U2QxbnZNNTJiU0pMdjZDUG1STTd3dFBXdFNCNTdZ?=
 =?utf-8?B?Zm5nTTBxNDQrNTB3Z1ZJR1BNR2crZ2hoT0hJY01QZVFjRmlKaGVyZTVYQlNB?=
 =?utf-8?B?V1NqazNWb3BYRjFMaTk5ckkvTEJZMEhldXNacmRVazVSOHpLMkpTeXBNaGZh?=
 =?utf-8?B?L05ZdGx5OEZxVUh6bnV0MkFJV0ZDa2R6MTluazVUQjRHVTZuTm42M1RnK0Vj?=
 =?utf-8?B?aEFJdXpWVGlXMkV6WUFCRkNpQUlsUWhsem9hcklyaXIvWm9HM3dKOTNUekpU?=
 =?utf-8?B?cHY2NWNjSjhWUElqVlhVSjg0WlpqZWtXRUNWb0VUYWJRZ2JacU9vTVdiL0JD?=
 =?utf-8?B?eisxOUU2R3BJNW5PbnU5NTg5NzcwV0psM2VIVWozUzFxU0RCankySDVjclMw?=
 =?utf-8?B?OExiNjVPbkFlYWgrc0ovQWhmNys3TVBWL2JkcjhqQmFvb3M2WFNPSG41Q3dz?=
 =?utf-8?B?cHpqZXZaSDdTT2t3b0ZLVThvWFlaall0NVA5WllCYWlvYkV3NVBCd3Zua1dL?=
 =?utf-8?B?dXFVbWlsZW1ObnJmb1ZTM1V0VDB2VFBJK3JoSUk1T3ZuNjg0N3BOT0lIR0Zk?=
 =?utf-8?B?d1JlaGljaWowR1R0V2FDSERnSnV3TjdHQlZjOG1hUUtJdkhCRFBTSzlxN3FU?=
 =?utf-8?B?ZUdHVXJrTTdhbWt6cXJuRWpqUko2Q00xT0ZnRDlLbTR3bnJrWXNSN2srV0p2?=
 =?utf-8?B?WlJxZkNhVG44T2J2THNEU044RWVmTFJHdmxJZEQ2SGpMY0REaHY2N0NucVNI?=
 =?utf-8?B?ang4amJYbS9pdm9wNTg3dks1V2o1SGg1S3h5SS9HOVRmYjlkaXUzOG9PQ2h4?=
 =?utf-8?B?YmtzSGdMdFJXTU5nWW45UE9heTZ6MlAzOTBCUFJmWks1eDgyb0k0MW41bHFq?=
 =?utf-8?B?cDZIVS9nR3gzYkxJR2loVWl1TlQ3MEZPalAwckk4bS8xdlpzZlRwREd3QnFn?=
 =?utf-8?B?alhNbDdjU3pZMy9ieSttODMvZm9aZDFOVmlrM1VzeXIxamlEWGN3bmZiMGFs?=
 =?utf-8?B?d01IRkl5eTZOY3lpN3lnazJUcHE2NGNzNjBlWmd2U0hFZVFEQzFCNlU3MXYy?=
 =?utf-8?B?VEwwK3BGZzA1Y2JNUk4wUlR6U2V2clQzZWJibEJCL0xIakxSaVhVRFlHZmhj?=
 =?utf-8?B?cm9UTzdIZEpuSEEvbU85TFBlZkVidFpndXo5VWtMWGR5VFd2alZFNEVYaWcy?=
 =?utf-8?B?YS9wVVAzKzdNb1U5VGFNYXBPK29NbHBNM0Rqb2ZYTmdzYzMwcDRLVmtoVTlj?=
 =?utf-8?B?YVZyaXR2dUNQUXlDU3NLZ1lrVlVONk5TUjU2NXVxRlhPM3FpNGJvRDZRTk53?=
 =?utf-8?B?WjZqQ3MxUUlmNzE2M1luYmM0UlZuenptVkRBVXRiMzF1b2FyOG9ZeTNabE5W?=
 =?utf-8?B?U1labHZQNUFnc2IzdXVnZWJYTy9UcVNtbnNHeE16UmdJN2dHM0xwU3R5TjR6?=
 =?utf-8?B?QW0zMW56NHZ3RG5QbzQrK2hUM2ovYVRWT3lPeUM0NFg2clZaUjczN0VCN09u?=
 =?utf-8?B?MHRYYkJEcVY5S2ljSVJsQ3BlY2N5bjZiR0hSS0F2cUZ0RURONU9LUkxseXJs?=
 =?utf-8?B?MGdsR3MxR0d1aVFrNUVDME50SStIQVUzNDNUbG42R1VqMDVoV1BFcURsR0VX?=
 =?utf-8?B?cUt6akVzdUljMS9Qd2I4anVZT1pPMFZQejZjU2tVbFpDZk1mNWI2ZkJmMjdw?=
 =?utf-8?B?ZTdzU0w1VHpBcForRFRLSkhUM0c4YnIrS1JLbE9oZ3pGalN4NHRzZDFHd1Bi?=
 =?utf-8?B?aUhPS284dHdGbE9QM1hJdnZUd3BMcDNxNXBXQWdBc1Y0YTl1Zzl4NjBKUVVY?=
 =?utf-8?B?UzBRdjR2K2txVzl5VC9kWDZySUVHWVJHZWZLVGdoMHVoaDFxQVhkLytNSUtw?=
 =?utf-8?B?YXJtSjdLUUpaZVRoVytsUktNZUVUMWFQM3J5VUJxam5UYkp6R2dSazRLOThP?=
 =?utf-8?B?WHlBc2p1eGp6MlA5bXlvNCtiTCsybkJwNCtwelQ3dmZUZlFqMm05cFM5MnEy?=
 =?utf-8?B?cWRjY1FoUExjNG5CMktPc2Irc3Nsa0I1dURSeVE5ajRkeWtyQ2JXNnR0ZU5N?=
 =?utf-8?Q?nKOCHTyBquL9j1TRsLqJuzFjJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c82f886c-33f2-47c8-a518-08de06e6a817
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB8289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 03:48:07.2795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPItm8yvC4L7pXdNBkVF06E8SGmba7f3B/n3Rqqg0JkRoUS8wXoii84Fp3bBIIKyDy+NXNKrIOdaO6SVcR+9Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7917
X-OriginatorOrg: intel.com

Hi Namhyung,

Sorry for the delayed response, just came back from vacation. According 
to your review comments, I have sent patch v6 for your kindly review. 
Appreciated for your time.

Patch v6 rebased with latest perf-tools-next, removed the INIT_ADDR 
support, keeps the changes inside of the builtin-c2c.c, along with other 
code suggestions you've made. Basically split the annotate changes from 
the c2c changes.

I will work on the annotate changes according you and Ravi's 
suggestions, hopefully I could send that patch soon.

Regards,

Tianyou

On 10/7/2025 4:23 PM, Namhyung Kim wrote:
> Hello,
>
> On Fri, Oct 03, 2025 at 07:44:34PM +0800, Li, Tianyou wrote:
>> Hi Namhyung,
>>
>> Appreciated for your review comments. Sorry for the delayed response. I am
>> on National Holiday so check email late. My response inlined for your
>> consideration.
>>
>> Regards,
>>
>> Tianyou
>>
>>
>> On 10/3/2025 1:05 PM, Namhyung Kim wrote:
>>> Hello,
>>>
>>> On Tue, Sep 30, 2025 at 08:39:00PM +0800, Tianyou Li wrote:
>>>> Perf c2c report currently specified the code address and source:line
>>>> information in the cacheline browser, while it is lack of annotation
>>>> support like perf report to directly show the disassembly code for
>>>> the particular symbol shared that same cacheline. This patches add
>>>> a key 'a' binding to the cacheline browser which reuse the annotation
>>>> browser to show the disassembly view for easier analysis of cacheline
>>>> contentions. By default, the 'TAB' key navigate to the code address
>>>> where the contentions detected.
>>>>
>>>> Signed-off-by: Tianyou Li <tianyou.li@intel.com>
>>>> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>>> Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
>>>> Reviewed-by: Jiebin Sun <jiebin.sun@intel.com>
>>>> Reviewed-by: Pan Deng <pan.deng@intel.com>
>>>> Reviewed-by: Zhiguo Zhou <zhiguo.zhou@intel.com>
>>>> Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
>>>> ---
> [SNIP]
>>>> @@ -2980,7 +3056,8 @@ static int setup_coalesce(const char *coalesce, bool no_source)
>>>>    	else if (c2c.display == DISPLAY_SNP_PEER)
>>>>    		sort_str = "tot_peer";
>>>> -	if (asprintf(&c2c.cl_resort, "offset,%s", sort_str) < 0)
>>>> +	/* add 'symbol' sort key to make sure hpp_list->sym get updated */
>>>> +	if (asprintf(&c2c.cl_resort, "offset,%s,symbol", sort_str) < 0)
>>> I think it's better to just process the input rather than enforcing it.
>>> It seems the default value will have 'iaddr' and so 'symbol as well.
>>
>> Sorry I am not so clear about 'so symbol as well'. Did you mean we can check
>> the 'dim == &dim_iaddr' instead of 'dim == &dim_symbol' to make sure
>> hpp_list->sym = 1? If so, do we need to check the coalesce set to default
>> 'iaddr' or not, otherwise we need to append the 'iaddr' in addition to the
>> user specific one?
> I meant you have 'iaddr' in the default sort keys and it will include
> 'symbol' in the output.  So annotation will be enabled by default.
>
>>
>>>>    		return -ENOMEM;
>>>>    	pr_debug("coalesce sort   fields: %s\n", c2c.cl_sort);
>>>> @@ -3006,6 +3083,7 @@ static int perf_c2c__report(int argc, const char **argv)
>>>>    	const char *display = NULL;
>>>>    	const char *coalesce = NULL;
>>>>    	bool no_source = false;
>>>> +	const char *disassembler_style = NULL, *objdump_path = NULL, *addr2line_path = NULL;
>>>>    	const struct option options[] = {
>>>>    	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
>>>>    		   "file", "vmlinux pathname"),
>>>> @@ -3033,6 +3111,12 @@ static int perf_c2c__report(int argc, const char **argv)
>>>>    	OPT_BOOLEAN(0, "stitch-lbr", &c2c.stitch_lbr,
>>>>    		    "Enable LBR callgraph stitching approach"),
>>>>    	OPT_BOOLEAN(0, "double-cl", &chk_double_cl, "Detect adjacent cacheline false sharing"),
>>>> +	OPT_STRING('M', "disassembler-style", &disassembler_style, "disassembler style",
>>>> +		   "Specify disassembler style (e.g. -M intel for intel syntax)"),
>>>> +	OPT_STRING(0, "objdump", &objdump_path, "path",
>>>> +		   "objdump binary to use for disassembly and annotations"),
>>> Please update documentation with the new options.
>>
>> Noted, will do in patch v6.
>>
>>
>>>> +	OPT_STRING(0, "addr2line", &addr2line_path, "path",
>>>> +		   "addr2line binary to use for line numbers"),
>>> Do you really need this?
>>
>> In my use scenarios of c2c tool, I did not use this addr2line tool. If this
>> was not quite necessary, I will remove it from patch v6.
> Yes, please.
>
>>
>>>>    	OPT_PARENT(c2c_options),
>>>>    	OPT_END()
>>>>    	};
>>>> @@ -3040,6 +3124,12 @@ static int perf_c2c__report(int argc, const char **argv)
>>>>    	const char *output_str, *sort_str = NULL;
>>>>    	struct perf_env *env;
>>>> +	annotation_options__init();
>>>> +
>>>> +	err = hists__init();
>>>> +	if (err < 0)
>>>> +		goto out;
>>>> +
>>>>    	argc = parse_options(argc, argv, options, report_c2c_usage,
>>>>    			     PARSE_OPT_STOP_AT_NON_OPTION);
>>>>    	if (argc)
>>>> @@ -3052,6 +3142,36 @@ static int perf_c2c__report(int argc, const char **argv)
>>>>    	if (c2c.stats_only)
>>>>    		c2c.use_stdio = true;
>>>> +	/**
>>>> +	 * Annotation related options
>>>> +	 * disassembler_style, objdump_path, addr2line_path
>>>> +	 * are set in the c2c_options, so we can use them here.
>>>> +	 */
>>>> +	if (disassembler_style) {
>>>> +		annotate_opts.disassembler_style = strdup(disassembler_style);
>>>> +		if (!annotate_opts.disassembler_style) {
>>>> +			err = -ENOMEM;
>>>> +			pr_err("Failed to allocate memory for annotation options\n");
>>>> +			goto out;
>>>> +		}
>>>> +	}
>>>> +	if (objdump_path) {
>>>> +		annotate_opts.objdump_path = strdup(objdump_path);
>>>> +		if (!annotate_opts.objdump_path) {
>>>> +			err = -ENOMEM;
>>>> +			pr_err("Failed to allocate memory for annotation options\n");
>>>> +			goto out;
>>>> +		}
>>>> +	}
>>>> +	if (addr2line_path) {
>>>> +		symbol_conf.addr2line_path = strdup(addr2line_path);
>>>> +		if (!symbol_conf.addr2line_path) {
>>>> +			err = -ENOMEM;
>>>> +			pr_err("Failed to allocate memory for annotation options\n");
>>>> +			goto out;
>>>> +		}
>>>> +	}
>>>> +
>>>>    	err = symbol__validate_sym_arguments();
>>>>    	if (err)
>>>>    		goto out;
>>>> @@ -3126,6 +3246,38 @@ static int perf_c2c__report(int argc, const char **argv)
>>>>    	if (err)
>>>>    		goto out_mem2node;
>>>> +	if (c2c.use_stdio)
>>>> +		use_browser = 0;
>>>> +	else
>>>> +		use_browser = 1;
>>>> +
>>>> +	/*
>>>> +	 * Only in the TUI browser we are doing integrated annotation,
>>>> +	 * so don't allocate extra space that won't be used in the stdio
>>>> +	 * implementation.
>>>> +	 */
>>>> +	if (perf_c2c__has_annotation(NULL)) {
>>>> +		int ret = symbol__annotation_init();
>>>> +
>>>> +		if (ret < 0)
>>>> +			goto out_mem2node;
>>>> +		/*
>>>> +		 * For searching by name on the "Browse map details".
>>>> +		 * providing it only in verbose mode not to bloat too
>>>> +		 * much struct symbol.
>>>> +		 */
>>>> +		if (verbose > 0) {
>>>> +			/*
>>>> +			 * XXX: Need to provide a less kludgy way to ask for
>>>> +			 * more space per symbol, the u32 is for the index on
>>>> +			 * the ui browser.
>>>> +			 * See symbol__browser_index.
>>>> +			 */
>>>> +			symbol_conf.priv_size += sizeof(u32);
>>>> +		}
>>>> +		annotation_config__init();
>>>> +	}
>>>> +
>>>>    	if (symbol__init(env) < 0)
>>>>    		goto out_mem2node;
>>>> @@ -3135,11 +3287,6 @@ static int perf_c2c__report(int argc, const char **argv)
>>>>    		goto out_mem2node;
>>>>    	}
>>>> -	if (c2c.use_stdio)
>>>> -		use_browser = 0;
>>>> -	else
>>>> -		use_browser = 1;
>>>> -
>>>>    	setup_browser(false);
>>>>    	err = perf_session__process_events(session);
>>>> @@ -3210,6 +3357,7 @@ static int perf_c2c__report(int argc, const char **argv)
>>>>    out_session:
>>>>    	perf_session__delete(session);
>>>>    out:
>>>> +	annotation_options__exit();
>>>>    	return err;
>>>>    }
>>>> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
>>>> index 8fe699f98542..a9d56e67454d 100644
>>>> --- a/tools/perf/ui/browsers/annotate.c
>>>> +++ b/tools/perf/ui/browsers/annotate.c
>>>> @@ -605,7 +605,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
>>>>    	target_ms.map = ms->map;
>>>>    	target_ms.sym = dl->ops.target.sym;
>>>>    	annotation__unlock(notes);
>>>> -	__hist_entry__tui_annotate(browser->he, &target_ms, evsel, hbt);
>>>> +	__hist_entry__tui_annotate(browser->he, &target_ms, evsel, hbt, NO_INITIAL_AL_ADDR);
>>>>    	/*
>>>>    	 * The annotate_browser above changed the title with the target function
>>>> @@ -864,6 +864,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
>>>>    	const char *help = "Press 'h' for help on key bindings";
>>>>    	int delay_secs = hbt ? hbt->refresh : 0;
>>>>    	char *br_cntr_text = NULL;
>>>> +	u64 init_al_addr = NO_INITIAL_AL_ADDR;
>>>>    	char title[256];
>>>>    	int key;
>>>> @@ -873,6 +874,13 @@ static int annotate_browser__run(struct annotate_browser *browser,
>>>>    	annotate_browser__calc_percent(browser, evsel);
>>>> +	/* the selection are intentionally even not from the sample percentage */
>>>> +	if (browser->entries.rb_node == NULL && browser->selection) {
>>>> +		init_al_addr = sym->start + browser->selection->offset;
>>>> +		disasm_rb_tree__insert(browser, browser->selection);
>>>> +		browser->curr_hot = rb_last(&browser->entries);
>>>> +	}
>>>> +
>>>>    	if (browser->curr_hot) {
>>>>    		annotate_browser__set_rb_top(browser, browser->curr_hot);
>>>>    		browser->b.navkeypressed = false;
>>>> @@ -973,6 +981,18 @@ static int annotate_browser__run(struct annotate_browser *browser,
>>>>    				ui_helpline__puts(help);
>>>>    			annotate__scnprintf_title(hists, title, sizeof(title));
>>>>    			annotate_browser__show(browser, title, help);
>>>> +			/* Previous RB tree may not valid, need refresh according to new entries*/
>>>> +			if (init_al_addr != NO_INITIAL_AL_ADDR) {
>>>> +				struct disasm_line *dl = find_disasm_line(sym, init_al_addr, true);
>>>> +
>>>> +				browser->curr_hot = NULL;
>>>> +				browser->entries.rb_node = NULL;
>>>> +				if (dl != NULL) {
>>>> +					disasm_rb_tree__insert(browser, &dl->al);
>>>> +					browser->curr_hot = rb_last(&browser->entries);
>>>> +				}
>>>> +				nd = browser->curr_hot;
>>>> +			}
>>> Can you please split annotate changes from c2c change?  I think you can
>>> start with annotation support in c2c.  And add INITIAL_ADDR later so
>>> that we can discuss the issue separately.  Maybe we don't need the ADDR
>>> change.  Do you have any concrete usecase where default annotate is not
>>> enough for c2c?
>>
>> Sure, I will split the patch into 2 patches. I use c2c extensively for my
>> day-to-day performance work, the INITIAL_ADDR would be very helpful to
>> located to the code where the iaddr was indicated in the cacheline browser.
>> Otherwise, probably I need to copy the iaddr from the cacheline browser, get
>> into the annotation browser, press 'o' to show the view with addresses in
>> disassemble view, and manually find the iaddr match since the search only
>> match string for disassembly code. The code highlight with INITIAL_ADDR
>> would quickly allow me to navigate the contended lines of code from
>> different functions showed in the cacheline browser, plus with  's' and 'T',
>> I can get to the point more conveniently.
>>
>>
>> Agreed to discuss it separately, looking forward to hearing your thoughts.
> Thanks for your understanding!
> Namhyung
>
>
