Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294FD7260F;
	Thu, 16 Oct 2025 02:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760580845; cv=fail; b=u8QF5Ilr9W6pBRJcFZgQxU5nc7s7KGbQzHHssgmrqR6vLI0Kpv52dziO+oKm/RkYIow862v72bO9mQFQMvBfHVqzhmK7uWtuR50rMzy/K9ExCnDo3JLFFYvCXIimQRisDLtDKp3BKxOJ0/IuqFg+vEecb/VF1Z7uJZT+tNIPRrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760580845; c=relaxed/simple;
	bh=jenqLqmePjgBYa/K8o4W9AyTPyD4hlPmnJWQXd+7zW8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=jaVlcsQnhATarVQ45PWp75a+XfChCKL4XLYU9F5PwJNui/a4Z8xDRHG68dSbNTXi1ijr1JDOWPrjksKbA6Taqt816Fa5T1YRUK2XVbNvOLrqTlxYOvB5DCoEoCVY7+OdJLvedyNQp9XV5b/aqu3uhMCxkEHDz4l+z0dnk4Ebfn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xd353xxs; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xd353xxs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760580843; x=1792116843;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jenqLqmePjgBYa/K8o4W9AyTPyD4hlPmnJWQXd+7zW8=;
  b=Xd353xxs54MDBj7JywzxJJzITjLbqMaJ7ibf+bVVE3BxRk2kZvK7/vnS
   JNg9dbs/3HRD/XsrbwAi7ncAw9cSqEyqRvvh8tMhCWY1k5PJRNgGou8Ca
   9YDJViuboKJLkMMy2MCWhRgyZzoX/og+9aOIkfrIwAeFCSzU9vg6cXgBZ
   8eiV+x2JKbNLOBzpFd7pAM20U2mCFD4XSudllVRWzJ6q5Iw7WRI9/TltJ
   3Sw6wSsACD8+Q5j3deF98HpcZj+WsRiOFCITsn/yNu7Cmox+LlRPi7IbZ
   cCHG3g13TA+kIfQuJH/flPMvIrWa5UqKxrKLzxx+cvflN1Ia9hf6xYg/p
   Q==;
X-CSE-ConnectionGUID: CtPMT03pSbqTAw+gIFfvgg==
X-CSE-MsgGUID: UxaoNSSERmKUnjWRo3XllQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="88233824"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="88233824"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 19:14:03 -0700
X-CSE-ConnectionGUID: GwEGwQWvSP6uH1d37g7a5g==
X-CSE-MsgGUID: QNwVtMPMQIG8h2BnUHlrNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="181539250"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 19:14:02 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 19:14:01 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 19:14:01 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.28) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 19:14:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlKID2NrRnqKZsggnBQWZFxrOMbQLrQWD4wnMXyJpWWAQbtDD81r18+fG0BujDbq6t/R2OpuMqkOU7k8fd7gc2bb8s31U8ljRM2WLHFX7AW612KQKqpT6PejyfW6Lzw+3V9n3JvYWHb90HwbmmF94nHORUS2bp4jw3wNDgjNufknEkkAkfWK/d7U8JCTNedR6dAxSch61Bdaf5kLqKXjaQm0uPrnXHVJVflUIkjGRAswCRZPRXFKMqhSYVYaZREr9krDZTAwKsr5PsXCg4o0ukYBIgXe3KwQ/u1EKcMlsLNBM55BU7Sg32ICmSBkYpAK11VnkwXGeIK1e1QUJvvFsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=303bKJHbnk4ZUun2Amb9BywJ2qfUnHPw46jtdjLpvzU=;
 b=cRXsw1VgoAHHweoYaPm2Rx51tO3yvbQwSmYiHtkx8YcSszEKvWBoBO41hxBB81SKNv5sREy1EM6vMhIikcSV2uWsDIPJD4XSwgRP9TRT+hh+C7B+nz8Y8yyuv9SOKRnMryX/6CYIamr7+J/FvnlBhSS+MS3WgVanhidd9LnuKQSNO447AGB2WNTQUhUlB/KpEkWyHuGzziIbREbN69GC+KkhP65GuuWILMhMqPctcCGZKPf8HKh90vYONAvSnyBcRZfWF3USjp+L8QZQNZRC2FM/fbQ7ZH4GFTk+Dx73DewXaR7Yzzv9KWweDz6JCe+HwGW/ENqRowxioD/s3G0I2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB6950.namprd11.prod.outlook.com (2603:10b6:510:226::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 02:13:54 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 02:13:54 +0000
Date: Thu, 16 Oct 2025 10:13:45 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ian Rogers <irogers@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [perf test]  2d58468864:
 kmsg.sanitizer.indirect_leak/malloc/maps__by_name_index/__maps__remove/__maps__fixup_overlap_and_insert/maps__fixup_overlap_and_insert/machine__process_ksymbol_register/machine__process_ksymbol/free/map__put/__maps__remove/__maps__fixup_overlap_and_insert/maps__fixup_overlap_and_insert/machine__process_ksymbol_register/malloc/map__get/__maps__insert_sorted/__maps__fixup_overlap_and_insert/maps__fixup_overlap_and_insert/machine__process_ksymbol_register/maps__by_name_index/__maps__remove/__maps__fixup_overlap_and_insert/maps__fixup_overlap_and_insert/machine__process_ksymbol_register/machine__process_ksymbol/free/map__put/__maps__remove/__maps__fixup_overlap_and_insert/maps__fixup_overlap_and_insert/machine__process_ksymbol_register/malloc/map__get/__maps__insert_sorted/__maps__fixup_overlap_and_insert/maps__fixup_overlap_and_insert/machine__process_ksymbol_register
Message-ID: <202510160935.b4c10a7e-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KL1PR01CA0127.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df47ea5-666d-4291-c315-08de0c59a7f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rdwRA4wa/AJjoWVqzjnSnQ1Bwyc4TuYl5Eu3PYHYEEuXb9Cbu7PVa33dFuvq?=
 =?us-ascii?Q?dEniocbhnGesgIytNozqkIIlPGhEoC8Gh0Pc63l0mFsiuBJ9GRGJ0UE72Dz6?=
 =?us-ascii?Q?BaDUsDoC2IW8MlypZzSgK0EJmjHhGp+He5+SDX3KChOKd3UwIgAmgDq6h0xL?=
 =?us-ascii?Q?X8CLtXp5LFRs7r2CfIIcXhHGElwjzjk8GyaRyXWyYjaPaSu3ubMoNLP/ISta?=
 =?us-ascii?Q?1RvfYOgg2SpokSGB6V9S6nTn0ECxpOX9g2HAaDRZEvT04t24xVjk6DY7NrJF?=
 =?us-ascii?Q?xyjIlxQXA26RWjtdEE930PAVcdWO2uyCtgTJg1+gFL0K3R8gmniYIqx990hW?=
 =?us-ascii?Q?wj5GW99w08oVXB95TfJqd5nrF9Lgfhqp2drj+l1NfBE1mLAjfw1bDwFaPped?=
 =?us-ascii?Q?frCbLj9PmcNPXs68mQODUEMURMm1OvnXHDYoWNZqyD3f8H1dZ7xzh/ctrrXM?=
 =?us-ascii?Q?OKa+RYw4G1TeGorJe3yYI014fBpti1kDbNhcTDXq0VdgMnA9WhzBoee23yAK?=
 =?us-ascii?Q?1fEqWdwVZwLiwDG2xIQD9bVDvY1PDgd2AppW/u56rYCv0XsStRTGIjCEZoRj?=
 =?us-ascii?Q?H7gdH/S+bQEfeTrXMO2CCVtNUtF8SfExYZoOK+kRrEyuwTMNvvO35rg8qgfh?=
 =?us-ascii?Q?1WlzRGSQ597k4s4nolPvxefY5S1zmt4Z4lE8T2PLIOOKQbX1kGUVS1AlfI3X?=
 =?us-ascii?Q?ihfOD3CdrKcaDUqil1bMKibYjYgSFlajfvxOn7T1E3VmN+PPCi0e+t/6SEb9?=
 =?us-ascii?Q?b/UdeV1J3GFJov4ptKcUW/j+/5ok2gu1Er9CrmYUAJGkOVxxwyZZolQzIvM7?=
 =?us-ascii?Q?0bjED2QbTYt/W5SYPiE/vx41EJveytNMAp5/sAayK2TitW/pMymvr+co3Yhi?=
 =?us-ascii?Q?2rIlVa6Xbv9SjE6dQg+4dVsMHZArYOBhTnJCJaiHYcimfL9EvL0faB8fPCVX?=
 =?us-ascii?Q?ztSPfYkxOJf31dST9Tigmq9Q4JARTVuOFnTiTgzIupCxe4IvYLsxyPeUKOUu?=
 =?us-ascii?Q?VOPcnE0wnTx9Hm/glg2zHfjK5foKWX8zTkuYaBWokNqlZhpUUUCyFSyoB8R1?=
 =?us-ascii?Q?0TYJgPO+GOu4FPHgCwbO5aBfgA5Hep90awI2vO39BLqOX/D2UqWYEUqxpl6Q?=
 =?us-ascii?Q?aLuqIBszmUKwLC66gDGmt15kA6WwAvpq1A3JfqpoKmz6ZVI3s9SlF+ghOzJn?=
 =?us-ascii?Q?JBWGQvx9vWdEj7reAwdAraU8f+z+wOu2nggapX1XrMCBi1stSbXXYrHJ7YHn?=
 =?us-ascii?Q?PCWSLbK3rLo9Wy9SmAc0pekEh+xpFm0iX1P0+rao//hmftqtHCC7DOpre5lb?=
 =?us-ascii?Q?/aDJVjJba6rYWEao4IVtM8j1lmtm46RWzCyS/36UFAlun+5hbiNPprVYaq0q?=
 =?us-ascii?Q?uSbhByIAxFbaptuXgB1dFHR6B4egoALgLWams0geVZDKEVW/ESJB53CfaSZ3?=
 =?us-ascii?Q?/OSgaIaWqnI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9GT9XmQaPrIoE7i/cnby+r1eXVrODkmT+NKxQ1yRtvktRdTiNRtiDLRWlQ+C?=
 =?us-ascii?Q?SifIyxVs6wqJyBX6tOcBzHj151M2/Am6fQ4zrIez4RBEhO2GvJH87h+s2Bkr?=
 =?us-ascii?Q?5sDqvB/QFZmMM1R1KUzccoSMO6KoaQevlRek9jT6t4rX/pGb393LfbCsIItj?=
 =?us-ascii?Q?KdRHlt4RAw79ZzgqQnlqIX0u2Hb1h6DwZhSHrGw17+uqjlWq238Bn8Ut2Ygm?=
 =?us-ascii?Q?qJZjt2cNHgACA4KD830N+6oo7AaRXxiONaqLlYNlFBCt73ziXWXwxI+TFpFj?=
 =?us-ascii?Q?6r5s6X7dZmUbG7NNjCJ3UjebXiGE+335tS+ZfvA8dfF/wD+MIQPdXKUsxtFs?=
 =?us-ascii?Q?G+T1j/BmmBw2SN2aDF+5i2NvG7u+YZIXKUXEkWQuLW4zElsGMC6YkYoTyRX4?=
 =?us-ascii?Q?Hd/AJLgF+gcWPx1yzRdMbE2HBfbBuPmF3eICJdx2pHpmCnfmXnf/P/FUNc1D?=
 =?us-ascii?Q?u3jwGS/hTxVx56lgaHmeadA4uwFAwTbJ9F4Jn844A8iAii9YQr1VgJBCHAFu?=
 =?us-ascii?Q?EXYDUFn6vpAsFyh9D7yhRCN+Pk2G+X1HZGqKb8rraXCsa5d53VS1UxafAreF?=
 =?us-ascii?Q?9FlcOobvvUt0Lv2/VajA5w+dbj9Ykyc0paMn2IL+Hi1mKulsL0pR909mfBbo?=
 =?us-ascii?Q?zjdx+BUhGGgxiZHpC3CxiVFAhsSNev2ZABzDpNL/VyVG/Hc8CtaMNA/NIVIH?=
 =?us-ascii?Q?1VtP5bnlHSPLDG4dno7D5CO1d3ikWwV32g9dNdCyInsN++q2+MoPvK9wRt7/?=
 =?us-ascii?Q?NzuuTSrneOo/FVmou2IIzNY7U7xjNk7NjLEYF/OqNptFOE5ZeM0ZJtTPmzCa?=
 =?us-ascii?Q?3r8JlAP4pdv49JEFs95Pki7ciLUejjfQpFBntUcf188TB4E7I33KLH3JmtwC?=
 =?us-ascii?Q?d5RniuWNBUiB3J/N5uZ2QXHVzI7TDiT7NrlwXqXVxCyQkEeISd+ZPjNiiQ0C?=
 =?us-ascii?Q?eCHnRNoh76I1hwKJ9PY2NP8GqmPJgYJ17++4hj1u643fA+KpbEO4W0s9Jn2t?=
 =?us-ascii?Q?mCMjRomqk/f3cK60mmq/U3qdLZru1a5sI+e0eScMtb0ohKXD5WeTE8/Nh/0U?=
 =?us-ascii?Q?BlvyCR3HWjOUWZwFKvXZgyvsN9/4cEOxJSHzIq1HDtHoVRyaHDbBx036ptzx?=
 =?us-ascii?Q?71xoPTlRgp2CbgGFpdJstGnHVfvZEA7Qm3SAGZt9+hiEjmZP0AYFHt3fkD6T?=
 =?us-ascii?Q?UB4A3bt+PE/5Bqd7M0EHeC2z2h/B1qgWoDu7ANT+UJ+oxGk39TxtU7c/5nso?=
 =?us-ascii?Q?fuAFkmaVuA4EnDo01vPNnmLR0KZDbctQyI4EbWXMgJEHFSwL1mCYwjfupPVg?=
 =?us-ascii?Q?exyMGxltLOdIDEs79gDK9ejYRhukhEgAF2h/WhfaI/Pz1ugT2PIYiFzBzql8?=
 =?us-ascii?Q?HwBoALX0CgQPPFv2d4s54XgFwhZ4TOAwGVbSYfwdsQlbl5Voxxfh/jmYBxZY?=
 =?us-ascii?Q?BPQw+W2zFCnkzIioqzSDuH7tHQu1E1beS3Ue0c+tUOQJu+ooLc9t3mmYbaT7?=
 =?us-ascii?Q?Oxm5EfmvKE09ISje2nyYG6PS6xQ0G3AZsmUV2FJnxVVduHD62SHGRuynVpQu?=
 =?us-ascii?Q?yqyKqD16TdnWlCYjzS1vMFhcEnC/MwKBrTH+uTqO6XqPPhf8nQg62Zx58+o6?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df47ea5-666d-4291-c315-08de0c59a7f1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 02:13:54.3613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +UHQasyelMso+8jP3teYiw/Vv4ObQkJiuXYes90gBVAI5ZhuRuOrbTvX8ebjQCUHxZHk/YGsWC/z3b0yH66myA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6950
X-OriginatorOrg: intel.com



Hello,


we noticed the issue in new added test and test itself failed.


kernel test robot noticed "kmsg.sanitizer.indirect_leak/malloc/maps__by_name_index/__maps__remove/__maps__fixup_overlap_and_insert/maps__fixup_overlap_and_insert/machine__process_ksymbol_register/machine__process_ksymbol/free/map__put/__maps__remove/__maps__fixup_overlap_and_insert/maps__fixup_overlap_and_insert/machine__process_ksymbol_register/malloc/map__get/__maps__insert_sorted/__maps__fixup_overlap_and_insert/maps__fixup_overlap_and_insert/machine__process_ksymbol_register/maps__by_name_index/__maps__remove/__maps__fixup_overlap_and_insert/maps__fixup_overlap_and_insert/machine__process_ksymbol_register/machine__process_ksymbol/free/map__put/__maps__remove/__maps__fixup_overlap_and_insert/maps__fixup_overlap_and_insert/machine__process_ksymbol_register/malloc/map__get/__maps__insert_sorted/__maps__fixup_overlap_and_insert/maps__fixup_overlap_and_insert/machine__process_ksymbol_register" on:

commit: 2d584688643fac90428ab12513e05d6deff7c606 ("perf test: Add header shell test")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on      linus/master 3a8660878839faadb4f1a6dd72c3179c1df56787]
[test failed on linux-next/master 52ba76324a9d7c39830c850999210a36ef023cde]
[test failed on        fix commit 844f962ca6bf5b01d0af0bc62a7f06135581fe92]

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
| Closes: https://lore.kernel.org/oe-lkp/202510160935.b4c10a7e-lkp@intel.com


2025-10-13 10:33:04 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-2d584688643fac90428ab12513e05d6deff7c606/tools/perf/perf test 82 -v
 82: perf header tests                                               : Running (1 active)
--- start ---
test child forked, pid 11993
Test perf header file
[ perf record: Woken up 2 times to write data ]
=================================================================
==11998==ERROR: AddressSanitizer: heap-use-after-free on address 0x502000039c50 at pc 0x55831a0ef091 bp 0x7ffd8cf52980 sp 0x7ffd8cf52978
READ of size 8 at 0x502000039c50 thread T0
    #0 0x55831a0ef090 in maps__by_name_index util/maps.c:423
    #1 0x55831a0efc72 in __maps__remove util/maps.c:536
    #2 0x55831a0f3849 in __maps__fixup_overlap_and_insert util/maps.c:956
    #3 0x55831a0f3975 in maps__fixup_overlap_and_insert util/maps.c:975
    #4 0x55831a0c92e0 in machine__process_ksymbol_register util/machine.c:756
    #5 0x55831a0c9aa8 in machine__process_ksymbol util/machine.c:824
    #6 0x558319f713be in perf_event__process_ksymbol util/event.c:297
    #7 0x55831a10acce in machines__deliver_event util/session.c:1344
    #8 0x55831a10b342 in perf_session__deliver_event util/session.c:1381
    #9 0x55831a10ec96 in perf_session__process_event util/session.c:1674
    #10 0x55831a116359 in process_simple util/session.c:2251
    #11 0x55831a115319 in reader__read_event util/session.c:2180
    #12 0x55831a115cbf in reader__process_events util/session.c:2229
    #13 0x55831a116b48 in __perf_session__process_events util/session.c:2274
    #14 0x55831a119c04 in perf_session__process_events util/session.c:2438
    #15 0x558319a4b942 in process_buildids /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-2d584688643fac90428ab12513e05d6deff7c606/tools/perf/builtin-record.c:1492
    #16 0x558319a50376 in record__finish_output /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-2d584688643fac90428ab12513e05d6deff7c606/tools/perf/builtin-record.c:1815
    #17 0x558319a5e2f9 in __cmd_record /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-2d584688643fac90428ab12513e05d6deff7c606/tools/perf/builtin-record.c:2876
    #18 0x558319a6b9f4 in cmd_record /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-2d584688643fac90428ab12513e05d6deff7c606/tools/perf/builtin-record.c:4350
    #19 0x558319c7dc20 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-2d584688643fac90428ab12513e05d6deff7c606/tools/perf/perf.c:351
    #20 0x558319c7e520 in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-2d584688643fac90428ab12513e05d6deff7c606/tools/perf/perf.c:404
    #21 0x558319c7ea76 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-2d584688643fac90428ab12513e05d6deff7c606/tools/perf/perf.c:448
    #22 0x558319c7f21d in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-2d584688643fac90428ab12513e05d6deff7c606/tools/perf/perf.c:556
    #23 0x7fa209c64ca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #24 0x7fa209c64d64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #25 0x5583199eb4f0 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-2d584688643fac90428ab12513e05d6deff7c606/tools/perf/perf+0x102b4f0) (BuildId: 40dc84e2c3040544dfd4a81fbc58e1bb98e5bb4e)

0x502000039c50 is located 0 bytes inside of 8-byte region [0x502000039c50,0x502000039c58)
freed by thread T0 here:
    #0 0x7fa20aebf8f8 in free ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:52
    #1 0x55831a0e7d3a in map__put util/map.c:313
    #2 0x55831a0efb77 in __maps__remove util/maps.c:530
    #3 0x55831a0f3849 in __maps__fixup_overlap_and_insert util/maps.c:956
    #4 0x55831a0f3975 in maps__fixup_overlap_and_insert util/maps.c:975
    #5 0x55831a0c92e0 in machine__process_ksymbol_register util/machine.c:756
    #6 0x55831a0c9aa8 in machine__process_ksymbol util/machine.c:824
    #7 0x558319f713be in perf_event__process_ksymbol util/event.c:297
    #8 0x55831a10acce in machines__deliver_event util/session.c:1344
    #9 0x55831a10b342 in perf_session__deliver_event util/session.c:1381
    #10 0x55831a10ec96 in perf_session__process_event util/session.c:1674
    #11 0x55831a116359 in process_simple util/session.c:2251
    #12 0x55831a115319 in reader__read_event util/session.c:2180
    #13 0x55831a115cbf in reader__process_events util/session.c:2229
    #14 0x55831a116b48 in __perf_session__process_events util/session.c:2274
    #15 0x55831a119c04 in perf_session__process_events util/session.c:2438
    #16 0x558319a4b942 in process_buildids /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-2d584688643fac90428ab12513e05d6deff7c606/tools/perf/builtin-record.c:1492
    #17 0x558319a50376 in record__finish_output /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-2d584688643fac90428ab12513e05d6deff7c606/tools/perf/builtin-record.c:1815
    #18 0x558319a5e2f9 in __cmd_record /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-2d584688643fac90428ab12513e05d6deff7c606/tools/perf/builtin-record.c:2876
    #19 0x558319a6b9f4 in cmd_record /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-2d584688643fac90428ab12513e05d6deff7c606/tools/perf/builtin-record.c:4350
    #20 0x558319c7dc20 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-2d584688643fac90428ab12513e05d6deff7c606/tools/perf/perf.c:351
    #21 0x558319c7e520 in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-2d584688643fac90428ab12513e05d6deff7c606/tools/perf/perf.c:404
    #22 0x558319c7ea76 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-2d584688643fac90428ab12513e05d6deff7c606/tools/perf/perf.c:448
    #23 0x558319c7f21d in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-2d584688643fac90428ab12513e05d6deff7c606/tools/perf/perf.c:556
    #24 0x7fa209c64ca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)

previously allocated by thread T0 here:
    #0 0x7fa20aec0c57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x55831a0eb14a in map__get util/map.h:189
    #2 0x55831a0f22ab in __maps__insert_sorted util/maps.c:791
    #3 0x55831a0f38c0 in __maps__fixup_overlap_and_insert util/maps.c:965
    #4 0x55831a0f3975 in maps__fixup_overlap_and_insert util/maps.c:975
    #5 0x55831a0c92e0 in machine__process_ksymbol_register util/machine.c:756
    #6 0x55831a0c9aa8 in machine__process_ksymbol util/machine.c:824
    #7 0x558319f713be in perf_event__process_ksymbol util/event.c:297
    #8 0x55831a10acce in machines__deliver_event util/session.c:1344
    #9 0x55831a10b342 in perf_session__deliver_event util/session.c:1381
    #10 0x55831a10ec96 in perf_session__process_event util/session.c:1674
    #11 0x55831a116359 in process_simple util/session.c:2251
    #12 0x55831a115319 in reader__read_event util/session.c:2180
    #13 0x55831a115cbf in reader__process_events util/session.c:2229
    #14 0x55831a116b48 in __perf_session__process_events util/session.c:2274
    #15 0x55831a119c04 in perf_session__process_events util/session.c:2438
    #16 0x558319a4b942 in process_buildids /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-2d584688643fac90428ab12513e05d6deff7c606/tools/perf/builtin-record.c:1492
    #17 0x558319a50376 in record__finish_output /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-2d584688643fac90428ab12513e05d6deff7c606/tools/perf/builtin-record.c:1815
    #18 0x558319a5e2f9 in __cmd_record /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-2d584688643fac90428ab12513e05d6deff7c606/tools/perf/builtin-record.c:2876
    #19 0x558319a6b9f4 in cmd_record /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-2d584688643fac90428ab12513e05d6deff7c606/tools/perf/builtin-record.c:4350
    #20 0x558319c7dc20 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-2d584688643fac90428ab12513e05d6deff7c606/tools/perf/perf.c:351
    #21 0x558319c7e520 in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-2d584688643fac90428ab12513e05d6deff7c606/tools/perf/perf.c:404
    #22 0x558319c7ea76 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-2d584688643fac90428ab12513e05d6deff7c606/tools/perf/perf.c:448
    #23 0x558319c7f21d in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-2d584688643fac90428ab12513e05d6deff7c606/tools/perf/perf.c:556
    #24 0x7fa209c64ca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)

SUMMARY: AddressSanitizer: heap-use-after-free util/maps.c:423 in maps__by_name_index
Shadow bytes around the buggy address:
  0x502000039980: fa fa fd fa fa fa 01 fa fa fa fd fa fa fa fd fa
  0x502000039a00: fa fa 00 fa fa fa 00 fa fa fa 00 fa fa fa 06 fa
  0x502000039a80: fa fa fd fd fa fa 00 fa fa fa fd fa fa fa fd fa
  0x502000039b00: fa fa fd fa fa fa fd fa fa fa 00 fa fa fa 00 fa
  0x502000039b80: fa fa 00 04 fa fa 00 fa fa fa 00 fa fa fa fd fa
=>0x502000039c00: fa fa fd fa fa fa 00 fa fa fa[fd]fa fa fa 00 fa
  0x502000039c80: fa fa 00 06 fa fa 00 01 fa fa 00 01 fa fa 00 03
  0x502000039d00: fa fa 00 00 fa fa 00 05 fa fa 00 03 fa fa 00 02
  0x502000039d80: fa fa 00 03 fa fa 00 02 fa fa 00 01 fa fa 00 06
  0x502000039e00: fa fa fd fa fa fa fd fa fa fa 00 fa fa fa 00 fa
  0x502000039e80: fa fa 00 fa fa fa fd fa fa fa fd fa fa fa 00 fa
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07 
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
==11998==ABORTING
Unexpected signal in test_file
---- end(-1) ----
 82: perf header tests                                               : FAILED!



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251016/202510160935.b4c10a7e-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

