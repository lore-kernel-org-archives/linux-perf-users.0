Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3C384039;
	Fri, 16 Aug 2024 06:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723790170; cv=fail; b=VDonOs5UtJhRMtNrIlfT22pdCrzBOPOAhcRSCpjqVco7pHm9OtZN5BxMtGju6L8lUdFTf2ah/DcTjhvLNWx+cY50bwJcvpIOipkXikQHpPumcAb9Dh31XHdFslagTpjc5k4yfIw6R8hZjgCe+FShdMQh4wg8/dDKJfbYUPb7GsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723790170; c=relaxed/simple;
	bh=oEPOYW5qImeWwk7I+dTObphbVh0TDUOaqw0rzsfu3ls=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cpLSv52eK4EklzTATWW7BOUHd8xzNtHEmy5G4riLCUDzIg8nfrdUOdAmzNfkV6+QbUmvLWYgZ7hO+Uk7MskVDC9Fp1rTDIXYQYfQGzs/bGn/v2zhJxXuzQiv+iPgaDAEpkUBvXABvpeyuo/VTYpjOqJqOJTd6aiO97w1uXKBVkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E+XlVmwR; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E+XlVmwR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723790164; x=1755326164;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=oEPOYW5qImeWwk7I+dTObphbVh0TDUOaqw0rzsfu3ls=;
  b=E+XlVmwRn670EQfBtt1LYetdL1ohxPKm6Bbuagj1GdsbxbOt+t80qe4I
   UNu7q2UWMpT/Zrz9x36Efief7do8cs3R0uKVVLEu3QHoc1ZJqpcdzjZW+
   bxrjBx42idW6MMZN0d0GJBVDbuVAGZsjidLPSFEGvIidxyrvT3ED1RVcH
   C8Orue61ltSm5wFWRwxwuAQfzmVDBpEX4nkQN/FVZdlDJw1AsmK37FoUV
   YlVk21tRO7jFVg04vRYwig/j17bjk1T6GryRguZi7lQW3n6W13+BcxzzO
   OQ9jaOioorAIoTuXlzJTLk//Sc8qYUjNGlG2ryVLJJmTm9nVBr/rReBj/
   w==;
X-CSE-ConnectionGUID: mO60OW4oQVWBS6FRCnIVjA==
X-CSE-MsgGUID: 51Tt3okLT+i6SF0uzczBvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="33488916"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="33488916"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 23:36:03 -0700
X-CSE-ConnectionGUID: TpZ3T+8dR+GVU/M1npor9Q==
X-CSE-MsgGUID: IphPj9v6QxSLJ3Rw8wHXBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="64530073"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Aug 2024 23:36:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 23:36:01 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 23:36:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 15 Aug 2024 23:36:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 23:36:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjMtSO0Cneqend2lS0AfOkPPElBiLTGJlaQLljazU4SYel1K2UCH+cBa9FhlSujj566M0Mjy07F+kkmqDNy1x10yuq/wSw6aw+hW6v+DisKbBSRkCJYZ//YyQ5hu6kulKxf3muO4QdHbfW0wfbM5ykNF5C2qGcc+jkfkoz8A/HZcsahZgPcKUswjdQUBz2Cebcz82Nb5CYn2ktqgxE7sfpjd2q0VX/5jcZwhLAu09mF79/zaLniVccQv6q2qnsvKAUl1nBAL8Lx1usUIJaRjVjLK0gu87OwRt2tjguEI+T1QzW3reRJFYRCzwYo0nkBRgTsF1Fpd7ReAFR9REPm5bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1gdchnHEfG5Ip7ySMUO+rUqT70B8WMzgYSLet42DpA=;
 b=jgzxP8HvsZiNbvrqmYzpb+FJichYF36VWN8ag33224iqnoFnQK21lFMfM+v64tbiEIATCqEshyRPaSFmhuVSM+x4Aa/PQTEu4vcFa62Ruh88pPNskXhS6r2EUiGLuplVArtOhxp+gDJmFH1q5zYHuij0kjT2z03+VAWKc/2gUrR0ad4Z2j7ZuP1fDO4SR/UWiIsQ22UO8WH2NNrSu1YQ904D54lUeVQzLiB4GSw8zt7EFHDREVpxPKtJhmyPZODqBNff78ao5pfjrQdxzoDWJg+C/fuSJlYc69XN4ihWYOCAWgg8gzC5B5vdo6rBAN0OeydSgC9ylA2NlHUqQMDePw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW6PR11MB8365.namprd11.prod.outlook.com (2603:10b6:303:240::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 06:35:51 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7875.019; Fri, 16 Aug 2024
 06:35:51 +0000
Date: Fri, 16 Aug 2024 14:35:39 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>, Peter
 Zijlstra <peterz@infradead.org>, "Matthew Wilcox (Oracle)"
	<willy@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Arnaldo Carvalho de
 Melo" <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] perf: Remove setting of page->index and ->mapping
Message-ID: <202408161305.a3a5158a-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240809201038.2648058-1-willy@infradead.org>
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW6PR11MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eca7f29-3012-4c32-b72b-08dcbdbdabcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Dy384wY+P7mKDVuDRNE5x+689DX0/awXlsxVmVwybhyFNofNG48mUOcK9S?=
 =?iso-8859-1?Q?H4umQAwdtyvjNQYf/A/l67jWGqgRkIm6t38zFRonKTwIneJ99/oI2qaCnt?=
 =?iso-8859-1?Q?j5Zy8VuchP9JLGn1zGs21EnDg616bSXRK67S6f6uaSNz5tNkT/0i+XFZ+G?=
 =?iso-8859-1?Q?X4YWPjWJvQeZkOHGBN03RXmKo+KBqxxMY4u41RF5KZ+1rl4ZDRQ6YStJX4?=
 =?iso-8859-1?Q?HhrZOTCO7TC55X80oLmeLTMqvpYMpXvOPm+Vfzg4iP79jrKVgIvsZZKQE4?=
 =?iso-8859-1?Q?dIACo3bQb6CA/AwxOi+qUCpVzJcsKDWp3LLGxE31IyQnM1GiNbMNS2TuXY?=
 =?iso-8859-1?Q?lnMp21CvsOTwSB1ZMVPS0iUptgXO9D8MlNTIqasOicdnx7oqb5kyioA1tv?=
 =?iso-8859-1?Q?il2oxkYML7gx64JJlLRoqAb5IgpmptWaP7xrFxBUEwHGH9J5lph4ExsN1c?=
 =?iso-8859-1?Q?m5yt4IWHclSWSYggv5FUPiQz+9MBIWjY0nIh8TBj9xz5MhlCJj0Mr3wITU?=
 =?iso-8859-1?Q?ffuZO2a6sC2gG0t5uuTp84VeYQdR+dsoTaAl7618kv+agjx9r01kBKth5M?=
 =?iso-8859-1?Q?YexE3IETf3w3YVuYfaoCuEiOYYwKB134l8lNSCzc/+Uyeq1IfeYtJBKixU?=
 =?iso-8859-1?Q?hKK1ja+JkOuWMtJYtttqbA+0pyUVXE8FMy3b9BWdIW5tEXlCZM/PUFLkDP?=
 =?iso-8859-1?Q?kdWU08WZbOfxzBHidnNcbsU25ZE5gKEf1rgYuJv6qbLZccod1FmApPpMPd?=
 =?iso-8859-1?Q?QVI/bq9aJXJSWQxkdrx2LnIKAe/tYqmDxb+8/9FB040sTQ3qfFZuzyWNGS?=
 =?iso-8859-1?Q?iXjLt7brRrxtv8qZ/iZOV8fO0e++ni8/W2Q4f5yLF9LhFgR442K9wydBB7?=
 =?iso-8859-1?Q?l83hVruu/5cwEKCLyDpfaNoYwsGEQesSrg/4O/eS3lGpJ4meJbCKWDGh/U?=
 =?iso-8859-1?Q?l82ke3X5tNltzBQ1KLpNEqHCN1hYDWsyohpf6KvJMGqclHHSW4+zMyJ1EZ?=
 =?iso-8859-1?Q?BPzHzDrR7fsSU+SLDJU8utcVYlczNyPoKb8/Gcb6QKoq+jZwYOvyNd2R/Z?=
 =?iso-8859-1?Q?a60ZY0Dr768EpkfsM8BtCksDGqnP9DLazYduYyrcjrmMj/STTQqXSy4Xl+?=
 =?iso-8859-1?Q?t80clqEB1aWdOIa+OLmnUJ/4oUVpKX+ORdP04GcG2/1H6gWi5vr/PSBlrI?=
 =?iso-8859-1?Q?l1uzSfrguBsmN66kCnOB8ZuvIDdYq2f6lldK2mAhfF30os39ryTwPf2PZ5?=
 =?iso-8859-1?Q?SKn6g/c02QAgZh3wOGWH3jBkruMCwJrWymAAGI/p3rXwVE0fdOP8IXzUjw?=
 =?iso-8859-1?Q?Sn+5wdSlrscsyr1EYmR4P0JCED6sS7kSNHYSWMhdHa21bCc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Lqe5iQOQjDjveVvRGzAhL1UxthYDKmKND4UWu8LvIlszLMpvIa/v9K26cs?=
 =?iso-8859-1?Q?YWvEPqtHMDXBrBm0Z0J5BVaaqFVqqp2fot/yjWGQ6jggBf0970PUsrl+ZB?=
 =?iso-8859-1?Q?Fzm26CZnd1KVrLkW/ni/sEibQFA105BJAwuWLi0z7EtRYzyAut+BNu0Jv/?=
 =?iso-8859-1?Q?0RcaePWVMbpIIJrOaTZ32+YUlaebMY1QlRmRXyuEVJWEjJ05RVux6dPs6v?=
 =?iso-8859-1?Q?tIw3sSv9nxBT4ZIb4xMHitCBQjAAPBLvrLf5hLE0XhMcAng3P0UowI/jBE?=
 =?iso-8859-1?Q?bbz+ra3WDEnxlUvsfX/Y2m3vVDLUBvtq+0/kak8k3lNiGPswjJM20Dyt9q?=
 =?iso-8859-1?Q?57J+jjrwNmy13YLg1ijLoxnSyajTOstg7+CJKMjhjNC9yALeq/cVgt9Pal?=
 =?iso-8859-1?Q?47tE/UoraFhdMw/APNU/1k5+5Sl93+LxUVsqnvrGOpXToSZYe5/rBslYBR?=
 =?iso-8859-1?Q?YHFRzpRhwl9WLq2Z8JWXG6NqVRP3bRV8xcHip818fiGGMbzVToXjaRqT+9?=
 =?iso-8859-1?Q?yVjDm4UKGr1VweO0sPGOO6UGOKKWWZZiGDJ2hHPmQn2i4qD+XKfKcrQ9Th?=
 =?iso-8859-1?Q?dYUOnL0pTTvtVFsaDxazz87AFx7BtGfnqYX/4urPZAv73k9T0Onak3m7Ic?=
 =?iso-8859-1?Q?+l7WtJQ4i0alRpZF+yyOyLcPjsDvnM3ZJGyyHSZRbvskU+DS2MOoUHaL/P?=
 =?iso-8859-1?Q?3cGsh3a7Po8gO8kgCTTNsWZr2QKd5ffvI+jfxCauekQ/hZSnyWyq/xNZB5?=
 =?iso-8859-1?Q?wzjGnY5gBH1tWVIVDbY8Z6F9cJEJ+fdOkkkqKN917xSVgFq1P3x4Agqb6/?=
 =?iso-8859-1?Q?YphNWvNL2+qSkVEPFveSsjw/zgd818Kym9ZR9u4pAVpFUGX+u8YlEMwxmI?=
 =?iso-8859-1?Q?eY4M0zyYJ4uDIbwHy6t+CaQmCiB656wjk8X4MnRxfsJvo41NE1jCvlItah?=
 =?iso-8859-1?Q?2W+I9vzc1Fqb5fCRnLZ6ERe5t0K2n4Um478XRv5Vk7rFBlR7mXD3gLfr8u?=
 =?iso-8859-1?Q?vnxoXO/PjYIvH5sjEHLv3l6UVNf+KgZb6kzdS8E21NMPZY4CIpVn1xFH0p?=
 =?iso-8859-1?Q?jbwJy/jZOl6EDApiLxw5IeQZJUOwLjsxL7pxb9idKnjy9W7wvU8S5S+jCK?=
 =?iso-8859-1?Q?Wz6COjlcDWj9npjOdeRvEXgPCtrI6yMjoCpal0FI0o6H72+uXZmr2xrTXl?=
 =?iso-8859-1?Q?+AD8zsQsQh/1hx+W1UZkMRmw1aOEn7kaO3FPPj7u/5CyMhYraOEIXNLHnw?=
 =?iso-8859-1?Q?909Y/rmF57M+Mb78+G6bX3/mtosJkCdUNVEx/gMOITV50Gy10GhV8bw0vO?=
 =?iso-8859-1?Q?W5aeIfHCKrZ8XAF5WtMlnjT6xcM7cdekuu3h/gup8HOvzn4pSRleo9iHMR?=
 =?iso-8859-1?Q?/ajVpMUl1dksdu2tft0oGmKwTcxemrlG6cYgCHERsE5vXdxmKu8ube/kyY?=
 =?iso-8859-1?Q?l7V255HAH4kbuisf9YIyaeGoK7mVsLw2/JxG4HQ56cpEA7oMQRIh7cyNZE?=
 =?iso-8859-1?Q?gYSgoZOn1oBfjWnZe/qzj4fE6/MIgfZYdlM3JxGSCKDrXQy6T43ddhdVOB?=
 =?iso-8859-1?Q?1BEQoFGU3b7tBJZiC/pfzp1DbhN2/liKaBFdiqC3qpB9yQpo/VSB7W2s1k?=
 =?iso-8859-1?Q?5wCOMPknMDuWfLFPxCAIUDMI2SBfQWxkX9RcJpfgsF4eC7qVVOm+G+6g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eca7f29-3012-4c32-b72b-08dcbdbdabcb
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 06:35:51.6768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +GAbRUclQCFGtFrEkYFM3DFyFa4BUXWpbyNV1phDkY7Clpk0uFufcr9ucCovpuS0/qrZ/hTDKQUnA+G7IKfBjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8365
X-OriginatorOrg: intel.com



Hello,

from commit message, it seems just some useless setting have been removed.
but quite some performance regression bisect by our bot finally point to this
change (already removed some not so significant changes to avoid this report
mail is too long).

we don't have enough knowledge to explain these, so just report FYI.
if you have any suggestion for our tests or need us run more tests, please
just let us know. thanks a lot!


kernel test robot noticed a -28.3% regression of stress-ng.dirmany.files_removed_per_sec on:


commit: a9ac22fb7ac3486a5bd89c25a2f784330ee92dd7 ("[PATCH] perf: Remove setting of page->index and ->mapping")
url: https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/perf-Remove-setting-of-page-index-and-mapping/20240810-111222
base: https://git.kernel.org/cgit/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link: https://lore.kernel.org/all/20240809201038.2648058-1-willy@infradead.org/
patch subject: [PATCH] perf: Remove setting of page->index and ->mapping

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	disk: 1HDD
	testtime: 60s
	fs: btrfs
	test: dirmany
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+--------------------------------------------------------------------------------------------------------+
| testcase: change | aim9: aim9.exec_test.ops_per_sec -12.3% regression                                                     |
| test machine     | 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 64G memory         |
| test parameters  | cpufreq_governor=performance                                                                           |
|                  | test=exec_test                                                                                         |
|                  | testtime=300s                                                                                          |
+------------------+--------------------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.sem.sem_wait_calls_per_sec -56.8% regression                                      |
| test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory            |
| test parameters  | cpufreq_governor=performance                                                                           |
|                  | nr_threads=100%                                                                                        |
|                  | test=sem                                                                                               |
|                  | testtime=60s                                                                                           |
+------------------+--------------------------------------------------------------------------------------------------------+
| testcase: change | tbench: tbench.throughput_MB/s -42.5% regression                                                       |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory              |
| test parameters  | cluster=cs-localhost                                                                                   |
|                  | cpufreq_governor=performance                                                                           |
|                  | iterations=1                                                                                           |
|                  | nr_threads=100%                                                                                        |
|                  | runtime=600                                                                                            |
+------------------+--------------------------------------------------------------------------------------------------------+
| testcase: change | uperf: uperf.Runstat_master_Mbps -25.4% regression                                                     |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory              |
| test parameters  | cluster=cs-localhost                                                                                   |
|                  | cpufreq_governor=performance                                                                           |
|                  | datasize=64                                                                                            |
|                  | nr_threads=1                                                                                           |
|                  | protocol=UDP                                                                                           |
|                  | runtime=30s                                                                                            |
|                  | winsize=32k                                                                                            |
+------------------+--------------------------------------------------------------------------------------------------------+
| testcase: change | netperf: netperf.Throughput_tps -31.4% regression                                                      |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory             |
| test parameters  | cluster=cs-localhost                                                                                   |
|                  | cpufreq_governor=performance                                                                           |
|                  | ip=ipv4                                                                                                |
|                  | nr_threads=50%                                                                                         |
|                  | runtime=300s                                                                                           |
|                  | test=SCTP_RR                                                                                           |
+------------------+--------------------------------------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_process_ops -61.9% regression                                         |
| test machine     | 104 threads 2 sockets (Skylake) with 192G memory                                                       |
| test parameters  | cpufreq_governor=performance                                                                           |
|                  | mode=process                                                                                           |
|                  | nr_task=100%                                                                                           |
|                  | test=context_switch1                                                                                   |
+------------------+--------------------------------------------------------------------------------------------------------+
| testcase: change | fsmark: fsmark.files_per_sec -29.8% regression                                                         |
| test machine     | 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory              |
| test parameters  | cpufreq_governor=performance                                                                           |
|                  | disk=1BRD_32G                                                                                          |
|                  | filesize=4K                                                                                            |
|                  | fs2=nfsv4                                                                                              |
|                  | fs=ext4                                                                                                |
|                  | iterations=1x                                                                                          |
|                  | nr_files_per_directory=1fpd                                                                            |
|                  | nr_threads=1t                                                                                          |
|                  | sync_method=fsyncBeforeClose                                                                           |
|                  | test_size=4G                                                                                           |
+------------------+--------------------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408161305.a3a5158a-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240816/202408161305.a3a5158a-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/btrfs/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/dirmany/stress-ng/60s

commit: 
  cb1898f58e ("perf annotate-data: Support --skip-empty option")
  a9ac22fb7a ("perf: Remove setting of page->index and ->mapping")

cb1898f58e0f175d a9ac22fb7ac3486a5bd89c25a2f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 3.832e+09 ±  2%     +21.3%  4.647e+09 ± 12%  cpuidle..time
      0.71 ±  4%      +0.2        0.88 ±  3%  mpstat.cpu.all.usr%
     37575 ± 10%     -86.8%       4959 ±  2%  meminfo.Active(anon)
    121149 ±  3%     -28.6%      86511        meminfo.Shmem
    103.55           +13.9%     117.98 ±  8%  uptime.boot
      5993           +13.0%       6775 ±  8%  uptime.idle
    238142 ±  6%     -23.9%     181123 ± 11%  vmstat.system.cs
    157186 ±  7%     +59.3%     250390 ± 10%  vmstat.system.in
     16677 ± 10%     -86.6%       2238 ± 49%  numa-meminfo.node0.Active(anon)
     20916 ± 15%     -87.0%       2724 ± 39%  numa-meminfo.node1.Active(anon)
   1379973 ± 75%    +117.7%    3004793 ± 40%  numa-meminfo.node1.FilePages
    666634 ±158%    +224.1%    2160724 ± 53%  numa-meminfo.node1.Unevictable
      1586 ± 12%    -100.0%       0.00        perf-c2c.DRAM.local
     13101 ± 15%    -100.0%       0.00        perf-c2c.DRAM.remote
     12067 ± 15%    -100.0%       0.00        perf-c2c.HITM.local
      8050 ± 16%    -100.0%       0.00        perf-c2c.HITM.remote
     20118 ± 15%    -100.0%       0.00        perf-c2c.HITM.total
      9403 ± 10%     -86.8%       1240 ±  2%  proc-vmstat.nr_active_anon
     27583            -2.0%      27039        proc-vmstat.nr_mapped
     30307 ±  3%     -28.6%      21640        proc-vmstat.nr_shmem
      9403 ± 10%     -86.8%       1240 ±  2%  proc-vmstat.nr_zone_active_anon
     66223           -18.6%      53878        proc-vmstat.numa_other
    263934 ±  3%    +1e+05%  2.768e+08 ± 16%  proc-vmstat.pgfault
     67.43 ±  3%     -14.6%      57.57 ±  9%  stress-ng.dirmany.%_of_time_creating_files
     32.57 ±  6%     +30.3%      42.43 ± 12%  stress-ng.dirmany.%_of_time_removing_file
    703.32           -28.3%     504.06 ±  3%  stress-ng.dirmany.files_removed_per_sec
     63.61 ±  2%     +22.9%      78.17 ± 13%  stress-ng.time.elapsed_time
     63.61 ±  2%     +22.9%      78.17 ± 13%  stress-ng.time.elapsed_time.max
    422.17 ±  4%     -35.4%     272.83 ± 17%  stress-ng.time.percent_of_cpu_this_job_got
    267.72 ±  5%     -21.4%     210.45 ± 17%  stress-ng.time.system_time
      4177 ± 10%     -86.6%     559.65 ± 49%  numa-vmstat.node0.nr_active_anon
      4177 ± 10%     -86.6%     559.65 ± 49%  numa-vmstat.node0.nr_zone_active_anon
      5236 ± 15%     -87.0%     681.46 ± 39%  numa-vmstat.node1.nr_active_anon
    345110 ± 75%    +117.7%     751196 ± 40%  numa-vmstat.node1.nr_file_pages
    164075 ±  3%     +16.8%     191570 ± 14%  numa-vmstat.node1.nr_slab_reclaimable
    166658 ±158%    +224.1%     540181 ± 53%  numa-vmstat.node1.nr_unevictable
      5236 ± 15%     -87.0%     681.46 ± 39%  numa-vmstat.node1.nr_zone_active_anon
    166658 ±158%    +224.1%     540181 ± 53%  numa-vmstat.node1.nr_zone_unevictable
     76822 ± 10%     +82.2%     140007 ± 19%  sched_debug.cfs_rq:/.avg_vruntime.max
      8327 ± 16%    +138.0%      19815 ±  8%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      2.25 ± 27%    -100.0%       0.00        sched_debug.cfs_rq:/.load_avg.min
     76822 ± 10%     +82.2%     140007 ± 19%  sched_debug.cfs_rq:/.min_vruntime.max
      8327 ± 16%    +138.0%      19815 ±  8%  sched_debug.cfs_rq:/.min_vruntime.stddev
     19.67 ± 57%     -98.7%       0.25 ±223%  sched_debug.cfs_rq:/.runnable_avg.min
    217.81 ±  3%     +27.8%     278.40 ±  4%  sched_debug.cfs_rq:/.runnable_avg.stddev
      1006 ±  7%     +16.2%       1169 ±  6%  sched_debug.cfs_rq:/.util_avg.max
     19.75 ± 57%     -99.2%       0.17 ±223%  sched_debug.cfs_rq:/.util_avg.min
    216.49 ±  3%     +27.8%     276.68 ±  4%  sched_debug.cfs_rq:/.util_avg.stddev
     28.42 ± 11%     +58.1%      44.94 ± 14%  sched_debug.cfs_rq:/.util_est.avg
    447.25 ± 12%     +71.0%     764.67        sched_debug.cfs_rq:/.util_est.max
     90.88 ±  9%     +85.0%     168.09 ±  5%  sched_debug.cfs_rq:/.util_est.stddev
    415102 ±  6%     +27.5%     529068        sched_debug.cpu.avg_idle.avg
    752805 ± 25%     +49.8%    1127548 ±  6%  sched_debug.cpu.avg_idle.max
    154552 ±  6%     +53.2%     236733 ±  6%  sched_debug.cpu.avg_idle.stddev
    101993 ± 13%     -40.9%      60236 ± 32%  sched_debug.cpu.nr_switches.avg
    113676 ± 14%     -33.7%      75369 ± 27%  sched_debug.cpu.nr_switches.max
     93486 ± 14%     -87.3%      11896 ± 26%  sched_debug.cpu.nr_switches.min
      3929 ± 34%    +221.3%      12624 ± 28%  sched_debug.cpu.nr_switches.stddev
      2.27 ±  2%     -64.5%       0.81 ± 11%  perf-stat.i.MPKI
 1.604e+09 ±  2%    +138.1%  3.819e+09 ±  6%  perf-stat.i.branch-instructions
      2.33 ±  2%      -1.6        0.72 ±  6%  perf-stat.i.branch-miss-rate%
  36868744 ±  3%     -29.2%   26089842 ±  7%  perf-stat.i.branch-misses
    244416 ±  6%     -24.1%     185618 ± 12%  perf-stat.i.context-switches
      1.90 ±  3%     -39.4%       1.16 ±  3%  perf-stat.i.cpi
     10537 ±  6%     -78.5%       2262 ± 46%  perf-stat.i.cpu-migrations
      1308 ± 11%    +411.3%       6692 ± 26%  perf-stat.i.cycles-between-cache-misses
 8.205e+09 ±  2%    +125.6%  1.851e+10 ±  6%  perf-stat.i.instructions
      0.88 ±  3%     +11.6%       0.98 ±  2%  perf-stat.i.ipc
      3.78 ±  6%   +2824.0%     110.64 ±  3%  perf-stat.i.metric.K/sec
      3035 ±  2%  +1.1e+05%    3448996 ±  3%  perf-stat.i.minor-faults
      3035 ±  2%  +1.1e+05%    3448996 ±  3%  perf-stat.i.page-faults
      2.82 ±  2%     -60.8%       1.10 ±  7%  perf-stat.overall.MPKI
      2.30 ±  2%      -1.6        0.68 ±  7%  perf-stat.overall.branch-miss-rate%
      2.58 ±  2%     -51.0%       1.26 ±  3%  perf-stat.overall.cpi
    915.45 ±  4%     +25.5%       1148 ±  5%  perf-stat.overall.cycles-between-cache-misses
      0.39 ±  2%    +104.3%       0.79 ±  3%  perf-stat.overall.ipc
 1.579e+09 ±  2%    +138.7%  3.769e+09 ±  6%  perf-stat.ps.branch-instructions
  36312783 ±  3%     -29.1%   25735794 ±  7%  perf-stat.ps.branch-misses
    240154 ±  6%     -23.7%     183188 ± 12%  perf-stat.ps.context-switches
     10351 ±  6%     -78.4%       2237 ± 46%  perf-stat.ps.cpu-migrations
 8.078e+09 ±  2%    +126.1%  1.827e+10 ±  6%  perf-stat.ps.instructions
      2990 ±  2%  +1.1e+05%    3403503 ±  3%  perf-stat.ps.minor-faults
      2990 ±  2%  +1.1e+05%    3403503 ±  3%  perf-stat.ps.page-faults
 5.224e+11 ±  2%    +178.3%  1.454e+12 ± 15%  perf-stat.total.instructions
     24.93 ± 18%     -24.9        0.00        perf-profile.calltrace.cycles-pp.common_startup_64
     24.55 ± 56%     -24.5        0.00        perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_write_and_wait_transaction
     24.55 ± 56%     -24.5        0.00        perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_write_and_wait_transaction.btrfs_commit_transaction
     24.54 ± 56%     -24.5        0.00        perf-profile.calltrace.cycles-pp.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_write_marked_extents
     24.51 ± 56%     -24.5        0.00        perf-profile.calltrace.cycles-pp.fsync
     24.50 ± 56%     -24.5        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsync
     24.50 ± 56%     -24.5        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fsync
     24.49 ± 56%     -24.5        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsync
     24.49 ± 56%     -24.5        0.00        perf-profile.calltrace.cycles-pp.btrfs_sync_file.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe.fsync
     24.48 ± 56%     -24.5        0.00        perf-profile.calltrace.cycles-pp.btrfs_commit_transaction.btrfs_sync_file.__x64_sys_fsync.do_syscall_64.entry_SYSCALL_64_after_hwframe
     24.43 ± 57%     -24.4        0.00        perf-profile.calltrace.cycles-pp.btrfs_write_and_wait_transaction.btrfs_commit_transaction.btrfs_sync_file.__x64_sys_fsync.do_syscall_64
     24.43 ± 57%     -24.4        0.00        perf-profile.calltrace.cycles-pp.btrfs_write_marked_extents.btrfs_write_and_wait_transaction.btrfs_commit_transaction.btrfs_sync_file.__x64_sys_fsync
     24.41 ± 57%     -24.4        0.00        perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.btrfs_write_marked_extents.btrfs_write_and_wait_transaction.btrfs_commit_transaction.btrfs_sync_file
     23.94 ± 56%     -23.9        0.00        perf-profile.calltrace.cycles-pp.submit_eb_page.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range
     23.50 ± 16%     -23.5        0.00        perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     23.49 ± 16%     -23.5        0.00        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     23.48 ± 16%     -23.5        0.00        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     22.12 ± 17%     -22.1        0.00        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     21.95 ± 19%     -22.0        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     21.61 ± 20%     -21.6        0.00        perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     20.64 ± 17%     -20.6        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     20.29 ± 57%     -20.3        0.00        perf-profile.calltrace.cycles-pp.btrfs_submit_bio.submit_eb_page.btree_write_cache_pages.do_writepages.filemap_fdatawrite_wbc
     20.29 ± 57%     -20.3        0.00        perf-profile.calltrace.cycles-pp.btrfs_submit_chunk.btrfs_submit_bio.submit_eb_page.btree_write_cache_pages.do_writepages
     17.17 ± 57%     -17.2        0.00        perf-profile.calltrace.cycles-pp.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bio.submit_eb_page.btree_write_cache_pages
     14.62 ± 31%     -14.6        0.00        perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     14.62 ± 31%     -14.6        0.00        perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     14.62 ± 31%     -14.6        0.00        perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     13.30 ± 27%     -13.3        0.00        perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     12.54 ± 58%     -12.5        0.00        perf-profile.calltrace.cycles-pp.btrfs_check_leaf.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bio.submit_eb_page
     12.31 ± 58%     -12.3        0.00        perf-profile.calltrace.cycles-pp.__btrfs_check_leaf.btrfs_check_leaf.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bio
     11.98 ± 32%     -12.0        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     10.42 ± 37%     -10.4        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      8.48 ± 57%      -8.5        0.00        perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      7.77 ± 62%      -7.8        0.00        perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      7.46 ± 58%      -7.5        0.00        perf-profile.calltrace.cycles-pp.check_leaf_item.__btrfs_check_leaf.btrfs_check_leaf.btree_csum_one_bio.btrfs_submit_chunk
      5.40 ± 69%      -5.4        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_posted_msi_notification.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      4.81 ± 57%      -4.8        0.00        perf-profile.calltrace.cycles-pp.check_dir_item.check_leaf_item.__btrfs_check_leaf.btrfs_check_leaf.btree_csum_one_bio
      4.62 ± 36%      -4.6        0.00        perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      4.52 ± 55%      -4.5        0.00        perf-profile.calltrace.cycles-pp.csum_tree_block.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bio.submit_eb_page
      4.51 ± 56%      -4.5        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      4.49 ± 56%      -4.5        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.46 ± 55%      -4.5        0.00        perf-profile.calltrace.cycles-pp.crc32c_pcl_intel_update.csum_tree_block.btree_csum_one_bio.btrfs_submit_chunk.btrfs_submit_bio
      4.46 ± 55%      -4.5        0.00        perf-profile.calltrace.cycles-pp.crc_pcl.crc32c_pcl_intel_update.csum_tree_block.btree_csum_one_bio.btrfs_submit_chunk
     55.50 ± 15%     -55.5        0.00        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     55.46 ± 15%     -55.5        0.00        perf-profile.children.cycles-pp.do_syscall_64
     28.46 ± 53%     -28.5        0.00        perf-profile.children.cycles-pp.btrfs_commit_transaction
     24.93 ± 18%     -24.9        0.00        perf-profile.children.cycles-pp.common_startup_64
     24.93 ± 18%     -24.9        0.00        perf-profile.children.cycles-pp.cpu_startup_entry
     24.92 ± 18%     -24.9        0.00        perf-profile.children.cycles-pp.do_idle
     24.61 ± 55%     -24.6        0.00        perf-profile.children.cycles-pp.btrfs_write_and_wait_transaction
     24.61 ± 55%     -24.6        0.00        perf-profile.children.cycles-pp.btrfs_write_marked_extents
     24.60 ± 55%     -24.6        0.00        perf-profile.children.cycles-pp.__filemap_fdatawrite_range
     24.60 ± 55%     -24.6        0.00        perf-profile.children.cycles-pp.btree_write_cache_pages
     24.60 ± 55%     -24.6        0.00        perf-profile.children.cycles-pp.do_writepages
     24.60 ± 55%     -24.6        0.00        perf-profile.children.cycles-pp.filemap_fdatawrite_wbc
     24.51 ± 56%     -24.5        0.00        perf-profile.children.cycles-pp.fsync
     24.49 ± 56%     -24.5        0.00        perf-profile.children.cycles-pp.__x64_sys_fsync
     24.49 ± 56%     -24.5        0.00        perf-profile.children.cycles-pp.btrfs_sync_file
     24.00 ± 55%     -24.0        0.00        perf-profile.children.cycles-pp.submit_eb_page
     23.53 ± 19%     -23.5        0.00        perf-profile.children.cycles-pp.cpuidle_idle_call
     23.50 ± 16%     -23.5        0.00        perf-profile.children.cycles-pp.start_secondary
     22.05 ± 19%     -22.1        0.00        perf-profile.children.cycles-pp.cpuidle_enter
     22.00 ± 19%     -22.0        0.00        perf-profile.children.cycles-pp.cpuidle_enter_state
     21.66 ± 20%     -21.7        0.00        perf-profile.children.cycles-pp.acpi_idle_enter
     21.63 ± 20%     -21.6        0.00        perf-profile.children.cycles-pp.acpi_safe_halt
     20.41 ± 55%     -20.4        0.00        perf-profile.children.cycles-pp.btrfs_submit_bio
     20.41 ± 55%     -20.4        0.00        perf-profile.children.cycles-pp.btrfs_submit_chunk
     17.35 ± 55%     -17.4        0.00        perf-profile.children.cycles-pp.btree_csum_one_bio
     14.74 ± 31%     -14.7        0.00        perf-profile.children.cycles-pp.ret_from_fork_asm
     14.71 ± 31%     -14.7        0.00        perf-profile.children.cycles-pp.ret_from_fork
     14.62 ± 31%     -14.6        0.00        perf-profile.children.cycles-pp.kthread
     12.66 ± 56%     -12.7        0.00        perf-profile.children.cycles-pp.__btrfs_check_leaf
     12.66 ± 56%     -12.7        0.00        perf-profile.children.cycles-pp.btrfs_check_leaf
      8.52 ± 29%      -8.5        0.00        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      8.48 ± 57%      -8.5        0.00        perf-profile.children.cycles-pp.worker_thread
      7.78 ± 62%      -7.8        0.00        perf-profile.children.cycles-pp.process_one_work
      7.62 ± 56%      -7.6        0.00        perf-profile.children.cycles-pp.check_leaf_item
      7.50 ± 34%      -7.5        0.00        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      5.58 ± 53%      -5.6        0.00        perf-profile.children.cycles-pp.crc32c_pcl_intel_update
      5.20 ± 46%      -5.2        0.00        perf-profile.children.cycles-pp.__irq_exit_rcu
      5.11 ± 47%      -5.1        0.00        perf-profile.children.cycles-pp.handle_softirqs
      5.09 ± 54%      -5.1        0.00        perf-profile.children.cycles-pp.check_dir_item
      4.74 ± 34%      -4.7        0.00        perf-profile.children.cycles-pp.sysvec_call_function_single
      4.57 ± 53%      -4.6        0.00        perf-profile.children.cycles-pp.csum_tree_block
      4.54 ± 70%      -4.5        0.00        perf-profile.children.cycles-pp.asm_sysvec_posted_msi_notification
      4.49 ± 53%      -4.5        0.00        perf-profile.children.cycles-pp.crc_pcl
      4.45 ± 56%      -4.5        0.00        perf-profile.children.cycles-pp.btrfs_get_32
      4.06 ± 34%      -4.1        0.00        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      8.89 ± 14%      -8.9        0.00        perf-profile.self.cycles-pp.acpi_safe_halt
      4.47 ± 53%      -4.5        0.00        perf-profile.self.cycles-pp.crc_pcl



***************************************************************************************************
lkp-ivb-2ep2: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 64G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-ivb-2ep2/exec_test/aim9/300s

commit: 
  cb1898f58e ("perf annotate-data: Support --skip-empty option")
  a9ac22fb7a ("perf: Remove setting of page->index and ->mapping")

cb1898f58e0f175d a9ac22fb7ac3486a5bd89c25a2f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   4849014          +148.9%   12069624        cpuidle..usage
     29121 ± 41%     -62.2%      11007 ± 94%  numa-numastat.node1.other_node
     97.58            -6.9%      90.83        vmstat.cpu.id
      2.30          +115.5%       4.95        vmstat.procs.r
      8730           -13.2%       7575        vmstat.system.cs
     14729          +456.7%      82001        vmstat.system.in
    124849 ±  2%     -91.8%      10221        meminfo.Active
    124801 ±  2%     -91.8%      10173        meminfo.Active(anon)
    876134            -9.4%     793689        meminfo.Committed_AS
      7544           +20.4%       9085        meminfo.PageTables
    128860 ±  2%     -91.1%      11481 ±  2%  meminfo.Shmem
     15.00 ± 19%    -100.0%       0.00        perf-c2c.DRAM.local
     36.00 ± 15%    -100.0%       0.00        perf-c2c.DRAM.remote
      2.67 ± 51%    -100.0%       0.00        perf-c2c.HIT.remote
     64.83 ±  3%    -100.0%       0.00        perf-c2c.HITM.local
     30.00 ± 15%    -100.0%       0.00        perf-c2c.HITM.remote
      1224           -12.3%       1074        aim9.exec_test.ops_per_sec
  31706751           -12.9%   27603136        aim9.time.minor_page_faults
     97.00            -1.0%      96.00        aim9.time.percent_of_cpu_this_job_got
    176.72           +14.8%     202.90        aim9.time.system_time
    116.68           -25.8%      86.55 ±  4%  aim9.time.user_time
    733520           -12.2%     643730        aim9.time.voluntary_context_switches
      0.25            +1.2        1.42        mpstat.cpu.all.irq%
      0.07 ±  2%      +0.1        0.12 ±  2%  mpstat.cpu.all.soft%
      1.66            +3.8        5.46        mpstat.cpu.all.sys%
      0.68            +1.7        2.36        mpstat.cpu.all.usr%
      1.00        +14516.7%     146.17 ± 51%  mpstat.max_utilization.seconds
      8.64           +20.2%      10.38        mpstat.max_utilization_pct
      9398 ± 74%     -82.2%       1675 ± 57%  numa-meminfo.node0.Active
      9366 ± 74%     -82.3%       1659 ± 58%  numa-meminfo.node0.Active(anon)
      9860 ± 70%     -78.5%       2121 ± 48%  numa-meminfo.node0.Shmem
    115389 ±  6%     -92.6%       8534 ± 11%  numa-meminfo.node1.Active
    115373 ±  6%     -92.6%       8502 ± 11%  numa-meminfo.node1.Active(anon)
    522369 ± 30%     -26.9%     381731 ± 30%  numa-meminfo.node1.AnonPages.max
    118964 ±  5%     -92.1%       9348 ± 11%  numa-meminfo.node1.Shmem
      2345 ± 74%     -82.3%     414.77 ± 58%  numa-vmstat.node0.nr_active_anon
      2466 ± 70%     -78.5%     530.32 ± 48%  numa-vmstat.node0.nr_shmem
      2345 ± 74%     -82.3%     414.77 ± 58%  numa-vmstat.node0.nr_zone_active_anon
     28843 ±  6%     -92.6%       2125 ± 11%  numa-vmstat.node1.nr_active_anon
     29739 ±  5%     -92.1%       2337 ± 11%  numa-vmstat.node1.nr_shmem
     28843 ±  6%     -92.6%       2125 ± 11%  numa-vmstat.node1.nr_zone_active_anon
     29121 ± 41%     -62.2%      11007 ± 94%  numa-vmstat.node1.numa_other
    519.91 ± 29%     +39.3%     724.40 ±  3%  sched_debug.IIkworker/R-0000
     11208 ±  3%    +249.5%      39175 ± 19%  sched_debug.cfs_rq:/.avg_vruntime.avg
     52206 ± 19%    +419.6%     271275 ± 14%  sched_debug.cfs_rq:/.avg_vruntime.max
      9447 ± 10%    +573.4%      63622 ± 17%  sched_debug.cfs_rq:/.avg_vruntime.stddev
    221530 ± 22%     -59.4%      89942 ± 48%  sched_debug.cfs_rq:/.load.max
     39358 ± 19%     -45.8%      21349 ± 35%  sched_debug.cfs_rq:/.load.stddev
     11208 ±  3%    +249.5%      39175 ± 19%  sched_debug.cfs_rq:/.min_vruntime.avg
     52206 ± 19%    +419.6%     271275 ± 14%  sched_debug.cfs_rq:/.min_vruntime.max
      9447 ± 10%    +573.4%      63622 ± 17%  sched_debug.cfs_rq:/.min_vruntime.stddev
      7.04 ± 16%    +352.0%      31.80 ± 20%  sched_debug.cfs_rq:/.util_est.avg
    121.39 ± 30%    +212.8%     379.76 ± 23%  sched_debug.cfs_rq:/.util_est.max
     23.68 ± 20%    +318.5%      99.12 ± 21%  sched_debug.cfs_rq:/.util_est.stddev
     66860 ± 13%     -37.7%      41635 ± 27%  sched_debug.cpu.avg_idle.stddev
      2.40 ± 21%     -70.1%       0.72 ± 21%  sched_debug.cpu.clock.stddev
    451.30 ±  3%     -26.7%     330.98 ± 28%  sched_debug.cpu.clock_task.stddev
     90057 ±  3%     -24.8%      67696 ± 23%  sched_debug.cpu.curr->pid.max
     16561 ±  9%     -23.8%      12621 ± 22%  sched_debug.cpu.curr->pid.stddev
     13987 ±  3%     -25.6%      10412 ± 23%  sched_debug.cpu.nr_switches.avg
     38759 ± 11%     -30.0%      27133 ± 25%  sched_debug.cpu.nr_switches.max
      2680 ± 14%     -72.4%     738.87 ± 24%  sched_debug.cpu.nr_switches.min
     31186 ±  2%     -91.9%       2540        proc-vmstat.nr_active_anon
    160386            +2.0%     163528        proc-vmstat.nr_anon_pages
    797165            -3.7%     767817        proc-vmstat.nr_file_pages
    161314            +1.5%     163804        proc-vmstat.nr_inactive_anon
     11375            +3.6%      11782        proc-vmstat.nr_kernel_stack
      8362            -2.8%       8125        proc-vmstat.nr_mapped
      1829           +25.4%       2294        proc-vmstat.nr_page_table_pages
     32208 ±  2%     -91.1%       2867 ±  2%  proc-vmstat.nr_shmem
     20413            -3.4%      19710        proc-vmstat.nr_slab_reclaimable
     28051            +0.8%      28289        proc-vmstat.nr_slab_unreclaimable
     31186 ±  2%     -91.9%       2540        proc-vmstat.nr_zone_active_anon
    161314            +1.5%     163804        proc-vmstat.nr_zone_inactive_anon
     20425 ± 33%     -83.5%       3376 ±182%  proc-vmstat.numa_hint_faults
  26596010           -13.6%   22977970        proc-vmstat.numa_hit
  26542993           -13.6%   22936126        proc-vmstat.numa_local
     49790           -18.7%      40495        proc-vmstat.numa_other
     11951 ± 68%     -99.0%     123.17 ±160%  proc-vmstat.numa_pages_migrated
     91437 ± 43%     -79.1%      19121 ±115%  proc-vmstat.numa_pte_updates
     35248 ±  4%     -99.0%     364.17 ±  4%  proc-vmstat.pgactivate
  27497487           -13.5%   23788404        proc-vmstat.pgalloc_normal
  32590981         +2227.8%  7.587e+08        proc-vmstat.pgfault
  27449503           -13.7%   23694730        proc-vmstat.pgfree
     11951 ± 68%     -99.0%     123.17 ±160%  proc-vmstat.pgmigrate_success
   1549666 ±  2%     -12.4%    1356755 ±  2%  proc-vmstat.pgreuse
      2.17           -61.6%       0.83 ±  2%  perf-stat.i.MPKI
 5.641e+08          +225.5%  1.836e+09        perf-stat.i.branch-instructions
      5.50            -3.5        1.98        perf-stat.i.branch-miss-rate%
  31671027           +15.1%   36440585        perf-stat.i.branch-misses
      8.81            +1.4       10.23 ±  2%  perf-stat.i.cache-miss-rate%
   5351586           +35.8%    7269406 ±  2%  perf-stat.i.cache-misses
  60638638           +16.8%   70801331        perf-stat.i.cache-references
      8748           -13.3%       7589        perf-stat.i.context-switches
      1.85           -13.4%       1.60        perf-stat.i.cpi
 4.765e+09          +193.1%  1.397e+10        perf-stat.i.cpu-cycles
    890.01          +117.1%       1931        perf-stat.i.cycles-between-cache-misses
 2.791e+09          +212.5%  8.722e+09        perf-stat.i.instructions
      0.56           +12.6%       0.63        perf-stat.i.ipc
      0.02 ± 27%     +90.8%       0.03 ± 46%  perf-stat.i.major-faults
      4.40         +2276.8%     104.67        perf-stat.i.metric.K/sec
    105697         +2276.8%    2512206        perf-stat.i.minor-faults
    105697         +2276.8%    2512206        perf-stat.i.page-faults
      1.92           -56.5%       0.83 ±  2%  perf-stat.overall.MPKI
      5.61            -3.6        1.98        perf-stat.overall.branch-miss-rate%
      8.82            +1.4       10.27 ±  2%  perf-stat.overall.cache-miss-rate%
      1.71            -6.2%       1.60        perf-stat.overall.cpi
    890.60          +115.8%       1922        perf-stat.overall.cycles-between-cache-misses
      0.59            +6.6%       0.62        perf-stat.overall.ipc
 5.623e+08          +225.4%   1.83e+09        perf-stat.ps.branch-instructions
  31568362           +15.0%   36300756        perf-stat.ps.branch-misses
   5333517           +35.9%    7245937 ±  2%  perf-stat.ps.cache-misses
  60439198           +16.8%   70570262        perf-stat.ps.cache-references
      8719           -13.3%       7563        perf-stat.ps.context-switches
 4.749e+09          +193.2%  1.392e+10        perf-stat.ps.cpu-cycles
 2.782e+09          +212.5%  8.692e+09        perf-stat.ps.instructions
      0.02 ± 27%     +90.9%       0.03 ± 46%  perf-stat.ps.major-faults
    105344         +2277.4%    2504483        perf-stat.ps.minor-faults
    105344         +2277.4%    2504483        perf-stat.ps.page-faults
  8.38e+11          +212.6%   2.62e+12        perf-stat.total.instructions
     66.96           -67.0        0.00        perf-profile.calltrace.cycles-pp.common_startup_64
     65.60           -65.6        0.00        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     65.60           -65.6        0.00        perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     65.54           -65.5        0.00        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     64.56           -64.6        0.00        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     62.17           -62.2        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     61.49           -61.5        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     49.76           -49.8        0.00        perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     11.21 ±  2%     -11.2        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     10.60 ±  2%     -10.6        0.00        perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      8.26 ±  2%      -8.3        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      8.24 ±  2%      -8.2        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      7.96 ±  2%      -8.0        0.00        perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      7.18 ±  2%      -7.2        0.00        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      7.01 ±  2%      -7.0        0.00        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      6.33            -6.3        0.00        perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.02            -6.0        0.00        perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      6.00            -6.0        0.00        perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      5.75            -5.7        0.00        perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      5.35            -5.3        0.00        perf-profile.calltrace.cycles-pp.execve
      5.34            -5.3        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      5.34            -5.3        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      5.34            -5.3        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      5.28            -5.3        0.00        perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common
     66.96           -67.0        0.00        perf-profile.children.cycles-pp.common_startup_64
     66.96           -67.0        0.00        perf-profile.children.cycles-pp.cpu_startup_entry
     66.96           -67.0        0.00        perf-profile.children.cycles-pp.do_idle
     65.92           -65.9        0.00        perf-profile.children.cycles-pp.cpuidle_idle_call
     65.60           -65.6        0.00        perf-profile.children.cycles-pp.start_secondary
     62.74           -62.7        0.00        perf-profile.children.cycles-pp.cpuidle_enter
     62.59           -62.6        0.00        perf-profile.children.cycles-pp.cpuidle_enter_state
     49.76           -49.8        0.00        perf-profile.children.cycles-pp.intel_idle
     21.70           -21.7        0.00        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     21.66           -21.7        0.00        perf-profile.children.cycles-pp.do_syscall_64
     11.84 ±  2%     -11.8        0.00        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     11.19 ±  2%     -11.2        0.00        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      8.12 ±  2%      -8.1        0.00        perf-profile.children.cycles-pp.__x64_sys_execve
      8.07 ±  2%      -8.1        0.00        perf-profile.children.cycles-pp.execve
      8.02 ±  2%      -8.0        0.00        perf-profile.children.cycles-pp.do_execveat_common
      7.57 ±  2%      -7.6        0.00        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      7.40 ±  2%      -7.4        0.00        perf-profile.children.cycles-pp.hrtimer_interrupt
      6.83            -6.8        0.00        perf-profile.children.cycles-pp.asm_exc_page_fault
      6.43            -6.4        0.00        perf-profile.children.cycles-pp.bprm_execve
      6.39            -6.4        0.00        perf-profile.children.cycles-pp.exc_page_fault
      6.27            -6.3        0.00        perf-profile.children.cycles-pp.do_user_addr_fault
      6.12            -6.1        0.00        perf-profile.children.cycles-pp.__hrtimer_run_queues
      6.04            -6.0        0.00        perf-profile.children.cycles-pp.exec_binprm
      6.02            -6.0        0.00        perf-profile.children.cycles-pp.search_binary_handler
      5.64            -5.6        0.00        perf-profile.children.cycles-pp.handle_mm_fault
      5.57            -5.6        0.00        perf-profile.children.cycles-pp.load_elf_binary
      5.25            -5.2        0.00        perf-profile.children.cycles-pp.__handle_mm_fault
     49.75           -49.8        0.00        perf-profile.self.cycles-pp.intel_idle



***************************************************************************************************
lkp-spr-r02: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/sem/stress-ng/60s

commit: 
  cb1898f58e ("perf annotate-data: Support --skip-empty option")
  a9ac22fb7a ("perf: Remove setting of page->index and ->mapping")

cb1898f58e0f175d a9ac22fb7ac3486a5bd89c25a2f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    257775 ± 22%    +124.5%     578661 ± 21%  cpuidle..usage
   2202062 ± 22%     -90.8%     202614 ± 38%  numa-numastat.node1.local_node
   2296320 ± 19%     -85.0%     345152 ± 19%  numa-numastat.node1.numa_hit
     19.92           -52.0%       9.55 ±  2%  vmstat.cpu.us
 1.856e+08 ±  3%     -58.4%   77159822 ±  4%  vmstat.system.cs
    556587           +42.9%     795511        vmstat.system.in
      0.58 ±  2%      +0.2        0.73        mpstat.cpu.all.irq%
      0.02 ±  3%      -0.0        0.01 ±  6%  mpstat.cpu.all.soft%
     75.65           +10.9       86.52        mpstat.cpu.all.sys%
     20.45           -10.8        9.70 ±  3%  mpstat.cpu.all.usr%
      1531 ± 54%    -100.0%       0.00        perf-c2c.DRAM.local
      2246 ± 32%    -100.0%       0.00        perf-c2c.DRAM.remote
      1173 ± 69%    -100.0%       0.00        perf-c2c.HITM.local
    549.17 ± 31%    -100.0%       0.00        perf-c2c.HITM.remote
  25808257 ±  2%     -58.1%   10805602 ±  4%  sched_debug.cpu.nr_switches.avg
  30207217           -57.0%   12980041        sched_debug.cpu.nr_switches.max
   3103000 ± 72%     -88.6%     354272 ±153%  sched_debug.cpu.nr_switches.min
   4087097 ± 21%     -40.3%    2439826 ± 18%  sched_debug.cpu.nr_switches.stddev
 1.429e+10 ±  3%     -53.6%  6.627e+09 ±  5%  stress-ng.sem.ops
 2.382e+08 ±  3%     -53.6%  1.104e+08 ±  5%  stress-ng.sem.ops_per_sec
    327589           -56.8%     141462        stress-ng.sem.sem_timedwait_calls_per_sec
    327403           -56.8%     141294        stress-ng.sem.sem_trywait_calls_per_sec
    327558           -56.8%     141438        stress-ng.sem.sem_wait_calls_per_sec
 1.178e+10 ±  2%     -58.5%  4.886e+09 ±  4%  stress-ng.time.involuntary_context_switches
     10499           +13.5%      11913        stress-ng.time.system_time
      2767           -53.0%       1301 ±  2%  stress-ng.time.user_time
    473599 ± 19%     -63.1%     174673 ± 55%  numa-meminfo.node0.Mapped
    422997 ± 14%     -99.3%       2940 ± 68%  numa-meminfo.node1.Active
    422988 ± 14%     -99.3%       2932 ± 69%  numa-meminfo.node1.Active(anon)
   4625028 ± 25%     -96.2%     176220 ± 42%  numa-meminfo.node1.FilePages
   4814124 ± 26%     -84.9%     728255 ± 20%  numa-meminfo.node1.Inactive
   4814082 ± 26%     -84.9%     728212 ± 20%  numa-meminfo.node1.Inactive(anon)
   1000373 ± 11%     -92.9%      71080 ±136%  numa-meminfo.node1.Mapped
   6804306 ± 19%     -67.0%    2242499 ±  5%  numa-meminfo.node1.MemUsed
     21291 ± 41%     -41.3%      12504 ± 70%  numa-meminfo.node1.PageTables
   4556992 ± 26%     -98.4%      74595 ±132%  numa-meminfo.node1.Shmem
    118547 ± 19%     -63.1%      43793 ± 54%  numa-vmstat.node0.nr_mapped
    105773 ± 13%     -99.3%     733.51 ± 69%  numa-vmstat.node1.nr_active_anon
   1156277 ± 25%     -96.2%      44056 ± 42%  numa-vmstat.node1.nr_file_pages
   1203588 ± 26%     -84.9%     182078 ± 20%  numa-vmstat.node1.nr_inactive_anon
    249177 ± 11%     -92.8%      17833 ±135%  numa-vmstat.node1.nr_mapped
      5333 ± 41%     -41.6%       3116 ± 70%  numa-vmstat.node1.nr_page_table_pages
   1139269 ± 26%     -98.4%      18649 ±132%  numa-vmstat.node1.nr_shmem
    105772 ± 13%     -99.3%     733.51 ± 69%  numa-vmstat.node1.nr_zone_active_anon
   1203585 ± 26%     -84.9%     182077 ± 20%  numa-vmstat.node1.nr_zone_inactive_anon
   2295346 ± 19%     -85.0%     344087 ± 19%  numa-vmstat.node1.numa_hit
   2201088 ± 22%     -90.8%     201553 ± 38%  numa-vmstat.node1.numa_local
    426533 ± 13%     -98.5%       6257 ± 20%  meminfo.Active
    426484 ± 13%     -98.5%       6209 ± 21%  meminfo.Active(anon)
   7723073 ± 16%     -57.1%    3309547        meminfo.Cached
  10911723 ± 11%     -41.3%    6400110        meminfo.Committed_AS
   5441802 ± 22%     -75.4%    1340267        meminfo.Inactive
   5441575 ± 22%     -75.4%    1340041        meminfo.Inactive(anon)
    152735           -10.7%     136341        meminfo.KReclaimable
   1472940 ±  7%     -83.4%     245093        meminfo.Mapped
  12189055 ± 10%     -37.8%    7581637        meminfo.Memused
    152735           -10.7%     136341        meminfo.SReclaimable
   4639245 ± 27%     -95.1%     225811        meminfo.Shmem
  12381239 ±  9%     -32.7%    8329522        meminfo.max_used_kB
      0.05 ± 14%     -52.4%       0.02 ± 18%  perf-stat.i.MPKI
  1.34e+11           +20.6%  1.616e+11        perf-stat.i.branch-instructions
      1.17 ±  2%      -0.7        0.49 ±  4%  perf-stat.i.branch-miss-rate%
 1.535e+09 ±  3%     -53.0%  7.219e+08 ±  2%  perf-stat.i.branch-misses
     37.03 ±  7%     -14.9       22.14 ± 15%  perf-stat.i.cache-miss-rate%
  21811787 ± 11%     -63.8%    7902212 ± 21%  perf-stat.i.cache-misses
  57650952 ±  7%     -39.5%   34876714 ± 11%  perf-stat.i.cache-references
 1.944e+08 ±  3%     -58.3%   81049117 ±  4%  perf-stat.i.context-switches
      1.04           -17.7%       0.85        perf-stat.i.cpi
    366.44 ±  3%     -14.1%     314.89 ±  3%  perf-stat.i.cpu-migrations
     39918 ± 13%    +167.9%     106957 ± 21%  perf-stat.i.cycles-between-cache-misses
 6.228e+11           +22.2%  7.609e+11        perf-stat.i.instructions
      0.97           +22.5%       1.19        perf-stat.i.ipc
    848.31 ±  2%     -56.7%     367.24 ±  5%  perf-stat.i.metric.K/sec
     17694 ±  4%   +7343.5%    1317088 ± 25%  perf-stat.i.minor-faults
     17694 ±  4%   +7343.5%    1317089 ± 25%  perf-stat.i.page-faults
     24418 ± 46%    +244.4%      84106 ± 20%  perf-stat.overall.cycles-between-cache-misses
      0.81 ± 44%     +47.4%       1.19        perf-stat.overall.ipc
 1.091e+11 ± 44%     +44.9%  1.581e+11        perf-stat.ps.branch-instructions
 5.071e+11 ± 44%     +46.8%  7.443e+11        perf-stat.ps.instructions
     14428 ± 44%   +8787.7%    1282380 ± 24%  perf-stat.ps.minor-faults
     14428 ± 44%   +8787.7%    1282380 ± 24%  perf-stat.ps.page-faults
 3.113e+13 ± 44%     +46.7%  4.566e+13        perf-stat.total.instructions
    107212 ± 13%     -98.6%       1552 ± 21%  proc-vmstat.nr_active_anon
    309617 ±  2%      -8.7%     282833        proc-vmstat.nr_anon_pages
   6248796            +1.8%    6363802        proc-vmstat.nr_dirty_background_threshold
  12512871            +1.8%   12743164        proc-vmstat.nr_dirty_threshold
   1931563 ± 16%     -57.2%     827520        proc-vmstat.nr_file_pages
  62864244            +1.8%   64015988        proc-vmstat.nr_free_pages
   1360577 ± 22%     -75.3%     335437        proc-vmstat.nr_inactive_anon
    367857 ±  7%     -83.3%      61606        proc-vmstat.nr_mapped
      8911           -10.3%       7992 ±  5%  proc-vmstat.nr_page_table_pages
   1160604 ± 27%     -95.1%      56584        proc-vmstat.nr_shmem
     38183           -10.7%      34085        proc-vmstat.nr_slab_reclaimable
    107212 ± 13%     -98.6%       1552 ± 21%  proc-vmstat.nr_zone_active_anon
   1360577 ± 22%     -75.3%     335437        proc-vmstat.nr_zone_inactive_anon
    250896 ±  6%     -91.1%      22308 ± 29%  proc-vmstat.numa_hint_faults
    123468 ±  9%     -93.7%       7808 ±  3%  proc-vmstat.numa_hint_faults_local
   2834379 ± 16%     -72.1%     789773        proc-vmstat.numa_hit
   2602586 ± 18%     -76.9%     601311        proc-vmstat.numa_local
    231785           -18.7%     188526        proc-vmstat.numa_other
     74727 ±  8%     -33.0%      50062 ± 21%  proc-vmstat.numa_pages_migrated
    923809 ±  3%     -53.9%     425642 ± 10%  proc-vmstat.numa_pte_updates
    104416 ± 18%     -48.0%      54266        proc-vmstat.pgactivate
   2989481 ± 14%     -66.7%     996881        proc-vmstat.pgalloc_normal
   1207566 ±  2%   +6626.3%   81224725 ± 24%  proc-vmstat.pgfault
    909425 ±  2%     -27.7%     657444 ±  5%  proc-vmstat.pgfree
     74727 ±  8%     -33.0%      50062 ± 21%  proc-vmstat.pgmigrate_success
     38727 ±  7%     -34.0%      25562        proc-vmstat.pgreuse
     90.17           -90.2        0.00        perf-profile.calltrace.cycles-pp.__sched_yield
     69.08           -69.1        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__sched_yield
     68.94           -68.9        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
     46.48           -46.5        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
     36.80           -36.8        0.00        perf-profile.calltrace.cycles-pp.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
     34.49           -34.5        0.00        perf-profile.calltrace.cycles-pp.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
     18.83 ±  2%     -18.8        0.00        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
     17.91           -17.9        0.00        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.__x64_sys_sched_yield.do_syscall_64
      8.68            -8.7        0.00        perf-profile.calltrace.cycles-pp.do_sched_yield.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      8.13 ±  2%      -8.1        0.00        perf-profile.calltrace.cycles-pp.__rseq_handle_notify_resume.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      7.60 ±  2%      -7.6        0.00        perf-profile.calltrace.cycles-pp.switch_fpu_return.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__sched_yield
      7.04 ±  3%      -7.0        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.__sched_yield
      6.38 ±  2%      -6.4        0.00        perf-profile.calltrace.cycles-pp.yield_task_fair.do_sched_yield.__x64_sys_sched_yield.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.24 ±  2%      -6.2        0.00        perf-profile.calltrace.cycles-pp.put_prev_entity.pick_next_task_fair.__schedule.schedule.__x64_sys_sched_yield
      6.09 ±  2%      -6.1        0.00        perf-profile.calltrace.cycles-pp.restore_fpregs_from_fpstate.switch_fpu_return.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.01 ±  2%      -5.0        0.00        perf-profile.calltrace.cycles-pp.rseq_ip_fixup.__rseq_handle_notify_resume.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
     91.66           -91.7        0.00        perf-profile.children.cycles-pp.__sched_yield
     70.10           -70.1        0.00        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     68.79           -68.8        0.00        perf-profile.children.cycles-pp.do_syscall_64
     47.16           -47.2        0.00        perf-profile.children.cycles-pp.__x64_sys_sched_yield
     36.94           -36.9        0.00        perf-profile.children.cycles-pp.schedule
     35.62           -35.6        0.00        perf-profile.children.cycles-pp.__schedule
     19.16 ±  2%     -19.2        0.00        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
     18.43           -18.4        0.00        perf-profile.children.cycles-pp.pick_next_task_fair
      8.91            -8.9        0.00        perf-profile.children.cycles-pp.do_sched_yield
      8.28 ±  2%      -8.3        0.00        perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      7.72 ±  2%      -7.7        0.00        perf-profile.children.cycles-pp.switch_fpu_return
      7.15 ±  2%      -7.1        0.00        perf-profile.children.cycles-pp.update_curr
      6.61 ±  2%      -6.6        0.00        perf-profile.children.cycles-pp.yield_task_fair
      6.57 ±  2%      -6.6        0.00        perf-profile.children.cycles-pp.put_prev_entity
      6.32 ±  2%      -6.3        0.00        perf-profile.children.cycles-pp.update_load_avg
      6.14 ±  2%      -6.1        0.00        perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      5.17 ±  2%      -5.2        0.00        perf-profile.children.cycles-pp.rseq_ip_fixup
      5.07 ±  2%      -5.1        0.00        perf-profile.children.cycles-pp.prepare_task_switch
      6.07 ±  2%      -6.1        0.00        perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      5.19 ±  2%      -5.2        0.00        perf-profile.self.cycles-pp.__schedule



***************************************************************************************************
lkp-icl-2sp9: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
cluster/compiler/cpufreq_governor/iterations/kconfig/nr_threads/rootfs/runtime/tbox_group/testcase:
  cs-localhost/gcc-12/performance/1/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/600/lkp-icl-2sp9/tbench

commit: 
  cb1898f58e ("perf annotate-data: Support --skip-empty option")
  a9ac22fb7a ("perf: Remove setting of page->index and ->mapping")

cb1898f58e0f175d a9ac22fb7ac3486a5bd89c25a2f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   7848524           -35.6%    5055935        vmstat.system.cs
     99625 ± 16%    +320.7%     419100 ±  2%  vmstat.system.in
      0.35 ±  9%      +0.2        0.51 ±  7%  mpstat.cpu.all.irq%
     18.73           +13.5       32.27        mpstat.cpu.all.soft%
     68.31            -8.5       59.81        mpstat.cpu.all.sys%
     12.13            -5.0        7.17        mpstat.cpu.all.usr%
 1.335e+08           -35.0%   86802870        numa-numastat.node0.local_node
 1.335e+08           -35.0%   86830895        numa-numastat.node0.numa_hit
  1.35e+08           -36.3%   85986323        numa-numastat.node1.local_node
  1.35e+08           -36.3%   86011207        numa-numastat.node1.numa_hit
    240.00 ± 11%    -100.0%       0.00        perf-c2c.DRAM.local
      7529 ±  6%    -100.0%       0.00        perf-c2c.DRAM.remote
      7785 ±  6%    -100.0%       0.00        perf-c2c.HITM.local
      4494 ±  4%    -100.0%       0.00        perf-c2c.HITM.remote
     12280 ±  3%    -100.0%       0.00        perf-c2c.HITM.total
     20996           -42.5%      12072        tbench.throughput_MB/s
     20996           -42.5%      12072        tbench.throughput_MB/s_harmonic_mean
 1.499e+09           -36.6%  9.505e+08        tbench.time.involuntary_context_switches
      3512           -19.7%       2820        tbench.time.percent_of_cpu_this_job_got
     20247           -14.4%      17328        tbench.time.system_time
      5054           -40.8%       2991        tbench.time.user_time
 1.328e+09           -34.3%  8.725e+08        tbench.time.voluntary_context_switches
     80062 ± 51%     -96.2%       3047 ± 70%  numa-meminfo.node0.Active
     80041 ± 51%     -96.3%       2993 ± 71%  numa-meminfo.node0.Active(anon)
     94532 ± 44%     -84.6%      14602 ± 24%  numa-meminfo.node0.Shmem
   3416559 ± 24%     -99.9%       3490 ± 56%  numa-meminfo.node1.Active
   3416370 ± 24%     -99.9%       3343 ± 55%  numa-meminfo.node1.Active(anon)
    179580 ± 58%    +185.9%     513453 ± 32%  numa-meminfo.node1.AnonPages.max
   5327384 ± 30%     -76.3%    1264854 ±100%  numa-meminfo.node1.FilePages
    106230 ± 45%     -86.1%      14817 ±110%  numa-meminfo.node1.Mapped
   5947008 ± 28%     -60.9%    2327541 ± 50%  numa-meminfo.node1.MemUsed
      5973 ± 84%     +73.8%      10382 ± 47%  numa-meminfo.node1.PageTables
   3586379 ± 25%     -99.8%       7080 ± 50%  numa-meminfo.node1.Shmem
   3495980 ± 23%     -99.8%       6538 ± 18%  meminfo.Active
   3495769 ± 23%     -99.8%       6337 ± 18%  meminfo.Active(anon)
   6793049 ± 13%     -53.9%    3133909        meminfo.Cached
   5711472 ± 15%     -63.6%    2077036        meminfo.Committed_AS
    860774 ± 10%     -19.1%     696070        meminfo.Inactive
    860058 ± 10%     -19.2%     695354        meminfo.Inactive(anon)
    100084 ±  2%     -11.6%      88500        meminfo.KReclaimable
    140027 ± 29%     -69.4%      42890        meminfo.Mapped
   8473548 ± 10%     -40.4%    5048986        meminfo.Memused
    100084 ±  2%     -11.6%      88500        meminfo.SReclaimable
   3680778 ± 24%     -99.4%      21686        meminfo.Shmem
   8658135 ± 10%     -39.6%    5229555        meminfo.max_used_kB
     20021 ± 51%     -96.3%     748.82 ± 71%  numa-vmstat.node0.nr_active_anon
     23635 ± 44%     -84.6%       3651 ± 24%  numa-vmstat.node0.nr_shmem
     20021 ± 51%     -96.3%     748.82 ± 71%  numa-vmstat.node0.nr_zone_active_anon
 1.335e+08           -35.0%   86830064        numa-vmstat.node0.numa_hit
 1.335e+08           -35.0%   86802040        numa-vmstat.node0.numa_local
    854348 ± 24%     -99.9%     835.66 ± 55%  numa-vmstat.node1.nr_active_anon
   1331772 ± 30%     -76.3%     316213 ±100%  numa-vmstat.node1.nr_file_pages
     26385 ± 45%     -85.6%       3786 ±110%  numa-vmstat.node1.nr_mapped
      1493 ± 84%     +73.7%       2595 ± 47%  numa-vmstat.node1.nr_page_table_pages
    896521 ± 25%     -99.8%       1770 ± 50%  numa-vmstat.node1.nr_shmem
    854348 ± 24%     -99.9%     835.66 ± 55%  numa-vmstat.node1.nr_zone_active_anon
  1.35e+08           -36.3%   86010078        numa-vmstat.node1.numa_hit
  1.35e+08           -36.3%   85985195        numa-vmstat.node1.numa_local
    874132 ± 23%     -99.8%       1584 ± 18%  proc-vmstat.nr_active_anon
   6344454            +1.3%    6429945        proc-vmstat.nr_dirty_background_threshold
  12704422            +1.3%   12875612        proc-vmstat.nr_dirty_threshold
   1698254 ± 13%     -53.9%     783477        proc-vmstat.nr_file_pages
  63822128            +1.3%   64678294        proc-vmstat.nr_free_pages
    214803 ± 10%     -19.1%     173832        proc-vmstat.nr_inactive_anon
     35091 ± 29%     -68.7%      10970        proc-vmstat.nr_mapped
    920185 ± 24%     -99.4%       5420        proc-vmstat.nr_shmem
     25021 ±  2%     -11.6%      22125        proc-vmstat.nr_slab_reclaimable
    874132 ± 23%     -99.8%       1584 ± 18%  proc-vmstat.nr_zone_active_anon
    214803 ± 10%     -19.1%     173832        proc-vmstat.nr_zone_inactive_anon
    119453 ± 26%     -95.7%       5091 ± 59%  proc-vmstat.numa_hint_faults
     65444 ± 36%     -98.4%       1036 ± 25%  proc-vmstat.numa_hint_faults_local
 2.685e+08           -35.6%  1.728e+08        proc-vmstat.numa_hit
 2.685e+08           -35.6%  1.728e+08        proc-vmstat.numa_local
     66380           -18.6%      54024        proc-vmstat.numa_other
    252531 ± 14%     -60.8%      99021 ± 17%  proc-vmstat.numa_pte_updates
   1163823 ± 24%     -99.9%     776.50 ± 23%  proc-vmstat.pgactivate
 2.129e+09           -35.5%  1.373e+09        proc-vmstat.pgalloc_normal
   2063471 ±  2%  +45810.5%  9.474e+08 ±  9%  proc-vmstat.pgfault
 2.128e+09           -35.5%  1.373e+09        proc-vmstat.pgfree
     85685 ±  9%     -11.0%      76256        proc-vmstat.pgreuse
  17143370           -10.1%   15417411        sched_debug.cfs_rq:/.avg_vruntime.avg
  16788080           -10.5%   15023795        sched_debug.cfs_rq:/.avg_vruntime.min
    147023 ± 26%     +96.3%     288623 ± 26%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      8563 ± 18%     -47.1%       4529 ± 42%  sched_debug.cfs_rq:/.load.min
  17143370           -10.1%   15417411        sched_debug.cfs_rq:/.min_vruntime.avg
  16788080           -10.5%   15023795        sched_debug.cfs_rq:/.min_vruntime.min
    147023 ± 26%     +96.3%     288623 ± 26%  sched_debug.cfs_rq:/.min_vruntime.stddev
      1805 ±  3%     +15.6%       2086        sched_debug.cfs_rq:/.runnable_avg.max
      1079 ±  7%     -15.8%     908.85 ±  6%  sched_debug.cfs_rq:/.runnable_avg.min
     98.24 ± 12%     +92.3%     188.89 ±  3%  sched_debug.cfs_rq:/.runnable_avg.stddev
     51.17 ± 16%     +35.0%      69.10 ±  9%  sched_debug.cfs_rq:/.util_avg.stddev
      1176 ±  8%     +41.6%       1665 ±  4%  sched_debug.cfs_rq:/.util_est.max
    241.66 ±  3%     +16.9%     282.59 ±  2%  sched_debug.cfs_rq:/.util_est.stddev
    620439 ± 19%     +40.4%     871331 ±  4%  sched_debug.cpu.avg_idle.max
      6766 ±  3%     +94.0%      13129 ±  4%  sched_debug.cpu.avg_idle.min
      8.69 ±  4%     +31.4%      11.41 ±  6%  sched_debug.cpu.clock.stddev
    327685           -12.4%     287198        sched_debug.cpu.clock_task.avg
    331298           -10.1%     297931        sched_debug.cpu.clock_task.max
    319890           -12.6%     279574        sched_debug.cpu.clock_task.min
      1712 ± 10%     +72.8%       2960 ± 11%  sched_debug.cpu.clock_task.stddev
      2339 ± 10%     -48.6%       1202 ± 74%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.00 ±  6%     +27.9%       0.00 ± 20%  sched_debug.cpu.next_balance.stddev
  44202960           -28.6%   31561513        sched_debug.cpu.nr_switches.avg
  45127928           -27.9%   32529217        sched_debug.cpu.nr_switches.max
  42497993           -35.6%   27381916 ±  4%  sched_debug.cpu.nr_switches.min
    489510 ±  7%     +87.5%     918047 ± 17%  sched_debug.cpu.nr_switches.stddev
      0.20 ± 12%     -42.7%       0.12 ±  7%  perf-stat.i.MPKI
 3.212e+10           +38.9%  4.463e+10        perf-stat.i.branch-instructions
      1.01            -0.4        0.64        perf-stat.i.branch-miss-rate%
 3.214e+08           -15.3%  2.721e+08        perf-stat.i.branch-misses
     32.93 ±  4%      -2.2       30.71 ±  2%  perf-stat.i.cache-miss-rate%
  32055029 ± 12%     -26.8%   23468576 ±  7%  perf-stat.i.cache-misses
 1.042e+08 ± 13%     -24.7%   78443526 ±  5%  perf-stat.i.cache-references
   7869989           -35.6%    5069963        perf-stat.i.context-switches
      1.40           -24.6%       1.06        perf-stat.i.cpi
      7138 ± 12%     +40.2%      10010 ±  7%  perf-stat.i.cycles-between-cache-misses
 1.601e+11           +34.5%  2.153e+11        perf-stat.i.instructions
      0.71           +34.8%       0.96        perf-stat.i.ipc
      2740 ±  2%  +47765.7%    1311791 ±  9%  perf-stat.i.minor-faults
      2740 ±  2%  +47765.5%    1311791 ±  9%  perf-stat.i.page-faults
      0.20 ± 12%     -45.6%       0.11 ±  7%  perf-stat.overall.MPKI
      1.00            -0.4        0.61        perf-stat.overall.branch-miss-rate%
      1.40           -25.9%       1.04        perf-stat.overall.cpi
      7104 ± 12%     +35.0%       9592 ±  8%  perf-stat.overall.cycles-between-cache-misses
      0.71           +34.9%       0.96        perf-stat.overall.ipc
 3.207e+10           +38.9%  4.455e+10        perf-stat.ps.branch-instructions
 3.209e+08           -15.3%  2.717e+08        perf-stat.ps.branch-misses
  32011532 ± 12%     -26.8%   23433423 ±  7%  perf-stat.ps.cache-misses
 1.042e+08 ± 13%     -24.8%   78378749 ±  5%  perf-stat.ps.cache-references
   7857872           -35.6%    5062068        perf-stat.ps.context-switches
 1.598e+11           +34.5%  2.149e+11        perf-stat.ps.instructions
      2738 ±  2%  +47722.7%    1309682 ±  9%  perf-stat.ps.minor-faults
      2738 ±  2%  +47722.5%    1309682 ±  9%  perf-stat.ps.page-faults
 1.153e+14           +34.5%  1.551e+14        perf-stat.total.instructions
     96.07           -96.1        0.00        perf-profile.calltrace.cycles-pp.main
     60.65           -60.7        0.00        perf-profile.calltrace.cycles-pp.create_procs.main
     42.12           -42.1        0.00        perf-profile.calltrace.cycles-pp.child_run.create_procs.main
     40.64           -40.6        0.00        perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send
     39.19           -39.2        0.00        perf-profile.calltrace.cycles-pp.tcp_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
     38.18           -38.2        0.00        perf-profile.calltrace.cycles-pp.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
     37.37           -37.4        0.00        perf-profile.calltrace.cycles-pp.child_op.child_run.create_procs.main
     35.42           -35.4        0.00        perf-profile.calltrace.cycles-pp.listener.main
     35.36           -35.4        0.00        perf-profile.calltrace.cycles-pp.server.listener.main
     30.48           -30.5        0.00        perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
     30.20           -30.2        0.00        perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto
     27.92           -27.9        0.00        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg
     24.93           -24.9        0.00        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked
     23.36           -23.4        0.00        perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames
     22.77           -22.8        0.00        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit
     21.45           -21.4        0.00        perf-profile.calltrace.cycles-pp.__send.server.listener.main
     21.42           -21.4        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send.do_packets
     20.65           -20.7        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__send.server.listener.main
     20.61           -20.6        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send.server.listener
     19.40           -19.4        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send.server
     18.50           -18.5        0.00        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb
     18.31 ±  2%     -18.3        0.00        perf-profile.calltrace.cycles-pp.kill.create_procs.main
     18.30           -18.3        0.00        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit
     18.07           -18.1        0.00        perf-profile.calltrace.cycles-pp.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
     17.70 ±  2%     -17.7        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.kill.create_procs.main
     17.67 ±  2%     -17.7        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.kill.create_procs.main
     17.14 ±  2%     -17.1        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_kill.do_syscall_64.entry_SYSCALL_64_after_hwframe.kill.create_procs
     17.05           -17.0        0.00        perf-profile.calltrace.cycles-pp.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
     16.77 ±  3%     -16.8        0.00        perf-profile.calltrace.cycles-pp.kill_something_info.__x64_sys_kill.do_syscall_64.entry_SYSCALL_64_after_hwframe.kill
     16.50 ±  3%     -16.5        0.00        perf-profile.calltrace.cycles-pp.kill_pid_info_type.kill_something_info.__x64_sys_kill.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.42           -16.4        0.00        perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip
     16.31           -16.3        0.00        perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.handle_softirqs.do_softirq
     15.90           -15.9        0.00        perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv
     15.76           -15.8        0.00        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.handle_softirqs
     13.94           -13.9        0.00        perf-profile.calltrace.cycles-pp.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.43           -13.4        0.00        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
     13.38           -13.4        0.00        perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
     13.28           -13.3        0.00        perf-profile.calltrace.cycles-pp.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
     13.15           -13.2        0.00        perf-profile.calltrace.cycles-pp.recv.server.listener.main
     13.15           -13.1        0.00        perf-profile.calltrace.cycles-pp.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
     12.97           -13.0        0.00        perf-profile.calltrace.cycles-pp.tcp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
     12.60 ±  3%     -12.6        0.00        perf-profile.calltrace.cycles-pp.security_task_kill.kill_pid_info_type.kill_something_info.__x64_sys_kill.do_syscall_64
     12.57 ±  3%     -12.6        0.00        perf-profile.calltrace.cycles-pp.apparmor_task_kill.security_task_kill.kill_pid_info_type.kill_something_info.__x64_sys_kill
     11.84           -11.8        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recv.server.listener.main
     11.76           -11.8        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv.server.listener
     11.29           -11.3        0.00        perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
     11.21           -11.2        0.00        perf-profile.calltrace.cycles-pp.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
     10.98           -11.0        0.00        perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
     10.56           -10.6        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv.server
      9.59            -9.6        0.00        perf-profile.calltrace.cycles-pp.sio_readx.child_op.child_run.create_procs.main
      8.73            -8.7        0.00        perf-profile.calltrace.cycles-pp.do_packets.sio_readx.child_op.child_run.create_procs
      6.57            -6.6        0.00        perf-profile.calltrace.cycles-pp.__send.do_packets.sio_readx.child_op.child_run
      6.36            -6.4        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__send.do_packets.sio_readx.child_op
      6.35            -6.4        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send.do_packets.sio_readx
      6.06            -6.1        0.00        perf-profile.calltrace.cycles-pp.sio_createx.child_op.child_run.create_procs.main
      5.90            -5.9        0.00        perf-profile.calltrace.cycles-pp.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      5.57            -5.6        0.00        perf-profile.calltrace.cycles-pp.do_packets.sio_createx.child_op.child_run.create_procs
      5.49            -5.5        0.00        perf-profile.calltrace.cycles-pp.sio_qpathinfo.child_op.child_run.create_procs.main
      5.09            -5.1        0.00        perf-profile.calltrace.cycles-pp.wait_woken.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
      5.04            -5.0        0.00        perf-profile.calltrace.cycles-pp.do_packets.sio_qpathinfo.child_op.child_run.create_procs
     96.13           -96.1        0.00        perf-profile.children.cycles-pp.main
     85.56           -85.6        0.00        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     84.98           -85.0        0.00        perf-profile.children.cycles-pp.do_syscall_64
     60.65           -60.7        0.00        perf-profile.children.cycles-pp.create_procs
     48.42           -48.4        0.00        perf-profile.children.cycles-pp.__send
     42.26           -42.3        0.00        perf-profile.children.cycles-pp.child_run
     41.59           -41.6        0.00        perf-profile.children.cycles-pp.__x64_sys_sendto
     41.40           -41.4        0.00        perf-profile.children.cycles-pp.__sys_sendto
     39.97           -40.0        0.00        perf-profile.children.cycles-pp.tcp_sendmsg
     38.93           -38.9        0.00        perf-profile.children.cycles-pp.tcp_sendmsg_locked
     37.51           -37.5        0.00        perf-profile.children.cycles-pp.child_op
     35.42           -35.4        0.00        perf-profile.children.cycles-pp.listener
     35.38           -35.4        0.00        perf-profile.children.cycles-pp.server
     33.33           -33.3        0.00        perf-profile.children.cycles-pp.do_packets
     32.27           -32.3        0.00        perf-profile.children.cycles-pp.tcp_write_xmit
     32.00           -32.0        0.00        perf-profile.children.cycles-pp.__tcp_push_pending_frames
     30.08           -30.1        0.00        perf-profile.children.cycles-pp.__tcp_transmit_skb
     27.32           -27.3        0.00        perf-profile.children.cycles-pp.__ip_queue_xmit
     25.59           -25.6        0.00        perf-profile.children.cycles-pp.ip_finish_output2
     25.22           -25.2        0.00        perf-profile.children.cycles-pp.recv
     24.96           -25.0        0.00        perf-profile.children.cycles-pp.__dev_queue_xmit
     20.53           -20.5        0.00        perf-profile.children.cycles-pp.__local_bh_enable_ip
     20.06           -20.1        0.00        perf-profile.children.cycles-pp.do_softirq
     19.82           -19.8        0.00        perf-profile.children.cycles-pp.handle_softirqs
     19.19           -19.2        0.00        perf-profile.children.cycles-pp.__x64_sys_recvfrom
     18.92           -18.9        0.00        perf-profile.children.cycles-pp.__sys_recvfrom
     18.67           -18.7        0.00        perf-profile.children.cycles-pp.net_rx_action
     18.44 ±  2%     -18.4        0.00        perf-profile.children.cycles-pp.kill
     17.99           -18.0        0.00        perf-profile.children.cycles-pp.__napi_poll
     17.88           -17.9        0.00        perf-profile.children.cycles-pp.process_backlog
     17.27           -17.3        0.00        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
     17.16 ±  2%     -17.2        0.00        perf-profile.children.cycles-pp.__x64_sys_kill
     16.99           -17.0        0.00        perf-profile.children.cycles-pp.sock_recvmsg
     16.78 ±  3%     -16.8        0.00        perf-profile.children.cycles-pp.kill_something_info
     16.51 ±  3%     -16.5        0.00        perf-profile.children.cycles-pp.kill_pid_info_type
     16.03           -16.0        0.00        perf-profile.children.cycles-pp.inet_recvmsg
     15.70           -15.7        0.00        perf-profile.children.cycles-pp.tcp_recvmsg
     15.25           -15.2        0.00        perf-profile.children.cycles-pp.ip_local_deliver_finish
     15.20           -15.2        0.00        perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
     14.97           -15.0        0.00        perf-profile.children.cycles-pp.tcp_v4_rcv
     13.87           -13.9        0.00        perf-profile.children.cycles-pp.tcp_recvmsg_locked
     12.95           -12.9        0.00        perf-profile.children.cycles-pp.tcp_v4_do_rcv
     12.66           -12.7        0.00        perf-profile.children.cycles-pp.tcp_rcv_established
     12.61 ±  3%     -12.6        0.00        perf-profile.children.cycles-pp.security_task_kill
     12.58 ±  3%     -12.6        0.00        perf-profile.children.cycles-pp.apparmor_task_kill
      9.59            -9.6        0.00        perf-profile.children.cycles-pp.sio_readx
      8.65            -8.6        0.00        perf-profile.children.cycles-pp.schedule
      8.55            -8.6        0.00        perf-profile.children.cycles-pp.__schedule
      7.75            -7.8        0.00        perf-profile.children.cycles-pp.sk_wait_data
      6.60            -6.6        0.00        perf-profile.children.cycles-pp.wait_woken
      6.23            -6.2        0.00        perf-profile.children.cycles-pp.schedule_timeout
      6.07            -6.1        0.00        perf-profile.children.cycles-pp.sio_createx
      5.70            -5.7        0.00        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      5.49            -5.5        0.00        perf-profile.children.cycles-pp.sio_qpathinfo
      5.08            -5.1        0.00        perf-profile.children.cycles-pp.sock_def_readable
     10.63 ±  3%     -10.6        0.00        perf-profile.self.cycles-pp.apparmor_task_kill



***************************************************************************************************
lkp-icl-2sp9: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
cluster/compiler/cpufreq_governor/datasize/kconfig/nr_threads/protocol/rootfs/runtime/tbox_group/testcase/winsize:
  cs-localhost/gcc-12/performance/64/x86_64-rhel-8.3/1/UDP/debian-12-x86_64-20240206.cgz/30s/lkp-icl-2sp9/uperf/32k

commit: 
  cb1898f58e ("perf annotate-data: Support --skip-empty option")
  a9ac22fb7a ("perf: Remove setting of page->index and ->mapping")

cb1898f58e0f175d a9ac22fb7ac3486a5bd89c25a2f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   6808243           -25.8%    5054865        cpuidle..usage
     34.51            -1.7%      33.94        boot-time.boot
      2003            -1.8%       1966        boot-time.idle
    313841 ±  3%     -72.4%      86605 ± 25%  numa-numastat.node1.local_node
    334568           -67.5%     108757 ± 15%  numa-numastat.node1.numa_hit
      3.53 ±  3%     +55.6%       5.49        vmstat.procs.r
    367355 ±  3%     -24.3%     277978        vmstat.system.cs
    197397 ±  3%     -12.2%     173405        vmstat.system.in
      0.17 ±  2%      -0.0        0.15        mpstat.cpu.all.irq%
      0.27 ±  3%      +0.2        0.47        mpstat.cpu.all.soft%
      1.07 ±  5%      +2.9        3.97        mpstat.cpu.all.sys%
      5.63 ±  6%     +38.5%       7.80 ±  5%  mpstat.max_utilization_pct
     11.33 ± 41%    -100.0%       0.00        perf-c2c.DRAM.local
     65.17 ± 64%    -100.0%       0.00        perf-c2c.DRAM.remote
      2717 ±  8%    -100.0%       0.00        perf-c2c.HITM.local
     32.17 ± 90%    -100.0%       0.00        perf-c2c.HITM.remote
     31117 ± 24%     -54.1%      14280 ± 87%  numa-meminfo.node0.Mapped
    505070           -99.7%       1522 ± 24%  numa-meminfo.node1.Active
    504998           -99.7%       1490 ± 24%  numa-meminfo.node1.Active(anon)
     44594 ± 30%     -60.3%      17722 ± 69%  numa-meminfo.node1.Mapped
    595059           -99.6%       2232 ± 16%  numa-meminfo.node1.Shmem
    151.45           -25.4%     112.99        uperf.Netstat_lo_in_Mbps
    151.45           -25.4%     112.99        uperf.Netstat_lo_out_Mbps
    105.36           -25.4%      78.60        uperf.Runstat_127.0.0.1_Mbps
    105.36           -25.4%      78.60        uperf.Runstat_master_Mbps
     25.17           -12.6%      22.00        uperf.time.percent_of_cpu_this_job_got
   3325771           -25.8%    2467986        uperf.time.voluntary_context_switches
      7923 ± 25%     -53.9%       3654 ± 86%  numa-vmstat.node0.nr_mapped
    126255           -99.7%     373.42 ± 24%  numa-vmstat.node1.nr_active_anon
     11390 ± 30%     -59.6%       4604 ± 68%  numa-vmstat.node1.nr_mapped
    148846           -99.6%     558.20 ± 16%  numa-vmstat.node1.nr_shmem
    126255           -99.7%     373.42 ± 24%  numa-vmstat.node1.nr_zone_active_anon
    334029           -67.7%     107918 ± 15%  numa-vmstat.node1.numa_hit
    313302 ±  3%     -72.6%      85796 ± 25%  numa-vmstat.node1.numa_local
    506511           -99.5%       2716        meminfo.Active
    506389           -99.5%       2652        meminfo.Active(anon)
   3666247           -16.2%    3072894        meminfo.Cached
   1380898           -41.7%     804785        meminfo.Committed_AS
    730235           -11.6%     645257        meminfo.Inactive
    729851           -11.6%     645012        meminfo.Inactive(anon)
     75195 ± 17%     -57.7%      31826        meminfo.Mapped
   5569857            -9.0%    5068038        meminfo.Memused
    606477           -97.8%      13355        meminfo.Shmem
   5802899           -11.8%    5115559        meminfo.max_used_kB
    126602           -99.5%     664.74        proc-vmstat.nr_active_anon
    916622           -16.2%     768228        proc-vmstat.nr_file_pages
    182518           -11.7%     161242        proc-vmstat.nr_inactive_anon
     19151 ± 17%     -57.1%       8207        proc-vmstat.nr_mapped
      1519            +3.7%       1575        proc-vmstat.nr_page_table_pages
    151678           -97.8%       3342        proc-vmstat.nr_shmem
     22637            -3.8%      21768        proc-vmstat.nr_slab_reclaimable
    126602           -99.5%     664.74        proc-vmstat.nr_zone_active_anon
    182518           -11.7%     161242        proc-vmstat.nr_zone_inactive_anon
    465325           -52.6%     220544 ±  2%  proc-vmstat.numa_hit
    399117           -58.2%     166673 ±  3%  proc-vmstat.numa_local
     66208           -18.7%      53838        proc-vmstat.numa_other
    206736          -100.0%      33.17 ± 20%  proc-vmstat.pgactivate
    492731           -49.5%     248776 ±  2%  proc-vmstat.pgalloc_normal
    208304 ±  5%  +54244.8%  1.132e+08        proc-vmstat.pgfault
    275792 ±  2%     -51.0%     135053 ±  4%  proc-vmstat.pgfree
      0.23 ±  3%     -59.3%       0.09 ±  5%  perf-stat.i.MPKI
 1.982e+09          +106.5%  4.094e+09        perf-stat.i.branch-instructions
      3.04 ±  2%      -1.6        1.48        perf-stat.i.branch-miss-rate%
  68611062 ±  2%     -18.7%   55765171        perf-stat.i.branch-misses
      7.33 ±  4%      -1.3        6.00 ±  4%  perf-stat.i.cache-miss-rate%
   2783561 ±  3%     -39.1%    1695747 ±  5%  perf-stat.i.cache-misses
  35458378           -19.3%   28615257 ±  2%  perf-stat.i.cache-references
    399282 ±  3%     -24.1%     303251        perf-stat.i.context-switches
      1.05           -20.3%       0.84        perf-stat.i.cpi
 9.455e+09 ±  2%     +74.1%  1.646e+10        perf-stat.i.cpu-cycles
    137.55            -4.4%     131.46        perf-stat.i.cpu-migrations
     11616 ± 17%     +77.4%      20608 ±  4%  perf-stat.i.cycles-between-cache-misses
 9.825e+09          +101.0%  1.975e+10        perf-stat.i.instructions
      1.01           +19.0%       1.20        perf-stat.i.ipc
      6.21 ±  3%   +1629.6%     107.36        perf-stat.i.metric.K/sec
      4804 ±  6%  +68281.0%    3285377        perf-stat.i.minor-faults
      4804 ±  6%  +68280.4%    3285377        perf-stat.i.page-faults
      0.28 ±  2%     -69.8%       0.09 ±  5%  perf-stat.overall.MPKI
      3.46            -2.1        1.36        perf-stat.overall.branch-miss-rate%
      7.86 ±  2%      -1.9        5.92 ±  6%  perf-stat.overall.cache-miss-rate%
      0.96           -13.4%       0.83        perf-stat.overall.cpi
      3395 ±  2%    +187.6%       9765 ±  5%  perf-stat.overall.cycles-between-cache-misses
      1.04           +15.5%       1.20        perf-stat.overall.ipc
 1.925e+09          +106.2%  3.971e+09        perf-stat.ps.branch-instructions
  66548387           -19.0%   53931766        perf-stat.ps.branch-misses
   2708553 ±  3%     -39.4%    1641008 ±  5%  perf-stat.ps.cache-misses
  34460219           -19.4%   27762399 ±  2%  perf-stat.ps.cache-references
    387430 ±  3%     -24.1%     294073        perf-stat.ps.context-switches
 9.192e+09 ±  2%     +73.8%  1.598e+10        perf-stat.ps.cpu-cycles
    133.55            -4.5%     127.51        perf-stat.ps.cpu-migrations
 9.543e+09          +100.7%  1.916e+10        perf-stat.ps.instructions
      4668 ±  6%  +68177.7%    3187819        perf-stat.ps.minor-faults
      4668 ±  6%  +68177.1%    3187819        perf-stat.ps.page-faults
 3.268e+11           +94.9%  6.368e+11        perf-stat.total.instructions
     63.98 ±  3%     -64.0        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     47.37 ±  2%     -47.4        0.00        perf-profile.calltrace.cycles-pp.common_startup_64
     45.61 ±  6%     -45.6        0.00        perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     45.57 ±  6%     -45.6        0.00        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     45.47 ±  6%     -45.5        0.00        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     41.88 ±  6%     -41.9        0.00        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     41.79 ±  2%     -41.8        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     41.07 ±  2%     -41.1        0.00        perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     40.56 ±  6%     -40.6        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     22.56 ±  2%     -22.6        0.00        perf-profile.calltrace.cycles-pp.sendto
     21.42 ±  2%     -21.4        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sendto
     21.36 ±  2%     -21.4        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto
     21.01 ±  2%     -21.0        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto
     20.87 ±  2%     -20.9        0.00        perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendto
     19.40 ±  2%     -19.4        0.00        perf-profile.calltrace.cycles-pp.udpv6_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
     19.07 ±  3%     -19.1        0.00        perf-profile.calltrace.cycles-pp.recvfrom
     18.86 ±  2%     -18.9        0.00        perf-profile.calltrace.cycles-pp.udp_sendmsg.udpv6_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
     16.78 ±  4%     -16.8        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recvfrom
     16.72 ±  4%     -16.7        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvfrom
     15.37 ±  4%     -15.4        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvfrom
     15.24 ±  4%     -15.2        0.00        perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvfrom
     14.58 ±  5%     -14.6        0.00        perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     13.60 ±  3%     -13.6        0.00        perf-profile.calltrace.cycles-pp.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
     13.43 ±  3%     -13.4        0.00        perf-profile.calltrace.cycles-pp.inet6_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
     13.32 ±  3%     -13.3        0.00        perf-profile.calltrace.cycles-pp.udpv6_recvmsg.inet6_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
     12.52 ±  4%     -12.5        0.00        perf-profile.calltrace.cycles-pp.udp_send_skb.udp_sendmsg.udpv6_sendmsg.__sys_sendto.__x64_sys_sendto
     12.18 ±  4%     -12.2        0.00        perf-profile.calltrace.cycles-pp.ip_send_skb.udp_send_skb.udp_sendmsg.udpv6_sendmsg.__sys_sendto
     11.64 ±  4%     -11.6        0.00        perf-profile.calltrace.cycles-pp.ip_finish_output2.ip_send_skb.udp_send_skb.udp_sendmsg.udpv6_sendmsg
     11.35 ±  4%     -11.3        0.00        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.ip_send_skb.udp_send_skb.udp_sendmsg
      9.29 ±  4%      -9.3        0.00        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.ip_send_skb.udp_send_skb
      9.14 ±  4%      -9.1        0.00        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.ip_send_skb
      9.13 ±  9%      -9.1        0.00        perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      8.98 ±  4%      -9.0        0.00        perf-profile.calltrace.cycles-pp.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
      8.83            -8.8        0.00        perf-profile.calltrace.cycles-pp.__skb_recv_udp.udpv6_recvmsg.inet6_recvmsg.sock_recvmsg.__sys_recvfrom
      8.27 ±  4%      -8.3        0.00        perf-profile.calltrace.cycles-pp.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
      7.80 ±  4%      -7.8        0.00        perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip
      7.68 ±  4%      -7.7        0.00        perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.handle_softirqs.do_softirq
      7.37 ±  4%      -7.4        0.00        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.handle_softirqs
      6.77 ±  4%      -6.8        0.00        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
      6.73 ±  4%      -6.7        0.00        perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
      6.54 ±  4%      -6.5        0.00        perf-profile.calltrace.cycles-pp.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
      6.40 ±  2%      -6.4        0.00        perf-profile.calltrace.cycles-pp.__skb_wait_for_more_packets.__skb_recv_udp.udpv6_recvmsg.inet6_recvmsg.sock_recvmsg
      6.23 ±  9%      -6.2        0.00        perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter
      5.95 ±  4%      -5.9        0.00        perf-profile.calltrace.cycles-pp.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
      5.89 ±  4%      -5.9        0.00        perf-profile.calltrace.cycles-pp.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      5.72 ±  9%      -5.7        0.00        perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt
      5.13 ±  5%      -5.1        0.00        perf-profile.calltrace.cycles-pp.schedule_timeout.__skb_wait_for_more_packets.__skb_recv_udp.udpv6_recvmsg.inet6_recvmsg
      4.97 ±  3%      -5.0        0.00        perf-profile.calltrace.cycles-pp.__udp_enqueue_schedule_skb.udp_queue_rcv_one_skb.udp_unicast_rcv_skb.__udp4_lib_rcv.ip_protocol_deliver_rcu
     47.37 ±  2%     -47.4        0.00        perf-profile.children.cycles-pp.common_startup_64
     47.37 ±  2%     -47.4        0.00        perf-profile.children.cycles-pp.cpu_startup_entry
     47.27 ±  2%     -47.3        0.00        perf-profile.children.cycles-pp.do_idle
     45.61 ±  6%     -45.6        0.00        perf-profile.children.cycles-pp.start_secondary
     43.59 ±  2%     -43.6        0.00        perf-profile.children.cycles-pp.cpuidle_idle_call
     42.19 ±  2%     -42.2        0.00        perf-profile.children.cycles-pp.cpuidle_enter
     41.99 ±  2%     -42.0        0.00        perf-profile.children.cycles-pp.cpuidle_enter_state
     41.83           -41.8        0.00        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     41.55           -41.5        0.00        perf-profile.children.cycles-pp.do_syscall_64
     41.23 ±  2%     -41.2        0.00        perf-profile.children.cycles-pp.acpi_idle_enter
     41.18 ±  2%     -41.2        0.00        perf-profile.children.cycles-pp.acpi_safe_halt
     37.04 ±  2%     -37.0        0.00        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
     22.75 ±  2%     -22.7        0.00        perf-profile.children.cycles-pp.sendto
     21.04 ±  2%     -21.0        0.00        perf-profile.children.cycles-pp.__x64_sys_sendto
     20.92 ±  2%     -20.9        0.00        perf-profile.children.cycles-pp.__sys_sendto
     19.44 ±  2%     -19.4        0.00        perf-profile.children.cycles-pp.udpv6_sendmsg
     19.25 ±  3%     -19.3        0.00        perf-profile.children.cycles-pp.recvfrom
     18.95 ±  2%     -19.0        0.00        perf-profile.children.cycles-pp.udp_sendmsg
     15.40 ±  4%     -15.4        0.00        perf-profile.children.cycles-pp.__x64_sys_recvfrom
     15.27 ±  4%     -15.3        0.00        perf-profile.children.cycles-pp.__sys_recvfrom
     13.62 ±  3%     -13.6        0.00        perf-profile.children.cycles-pp.sock_recvmsg
     13.43 ±  3%     -13.4        0.00        perf-profile.children.cycles-pp.inet6_recvmsg
     13.34 ±  3%     -13.3        0.00        perf-profile.children.cycles-pp.udpv6_recvmsg
     12.54 ±  4%     -12.5        0.00        perf-profile.children.cycles-pp.udp_send_skb
     12.20 ±  4%     -12.2        0.00        perf-profile.children.cycles-pp.ip_send_skb
     11.66 ±  4%     -11.7        0.00        perf-profile.children.cycles-pp.ip_finish_output2
     11.39 ±  4%     -11.4        0.00        perf-profile.children.cycles-pp.__dev_queue_xmit
      9.53 ±  4%      -9.5        0.00        perf-profile.children.cycles-pp.handle_softirqs
      9.37 ±  8%      -9.4        0.00        perf-profile.children.cycles-pp.sysvec_call_function_single
      9.35 ±  4%      -9.3        0.00        perf-profile.children.cycles-pp.__local_bh_enable_ip
      9.15 ±  4%      -9.2        0.00        perf-profile.children.cycles-pp.do_softirq
      8.88            -8.9        0.00        perf-profile.children.cycles-pp.__skb_recv_udp
      8.28 ±  4%      -8.3        0.00        perf-profile.children.cycles-pp.net_rx_action
      7.82 ±  4%      -7.8        0.00        perf-profile.children.cycles-pp.__napi_poll
      7.70 ±  4%      -7.7        0.00        perf-profile.children.cycles-pp.process_backlog
      7.38 ±  4%      -7.4        0.00        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
      7.05            -7.0        0.00        perf-profile.children.cycles-pp.__schedule
      6.78 ±  4%      -6.8        0.00        perf-profile.children.cycles-pp.ip_local_deliver_finish
      6.75 ±  4%      -6.7        0.00        perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
      6.56 ±  4%      -6.6        0.00        perf-profile.children.cycles-pp.__udp4_lib_rcv
      6.42 ±  2%      -6.4        0.00        perf-profile.children.cycles-pp.__skb_wait_for_more_packets
      6.31 ±  8%      -6.3        0.00        perf-profile.children.cycles-pp.__sysvec_call_function_single
      5.96 ±  4%      -6.0        0.00        perf-profile.children.cycles-pp.udp_unicast_rcv_skb
      5.92 ±  4%      -5.9        0.00        perf-profile.children.cycles-pp.udp_queue_rcv_one_skb
      5.80 ±  8%      -5.8        0.00        perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      5.16 ±  4%      -5.2        0.00        perf-profile.children.cycles-pp.schedule_timeout
      4.98 ±  3%      -5.0        0.00        perf-profile.children.cycles-pp.__udp_enqueue_schedule_skb
     29.86 ±  4%     -29.9        0.00        perf-profile.self.cycles-pp.acpi_safe_halt



***************************************************************************************************
lkp-icl-2sp2: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
  cs-localhost/gcc-12/performance/ipv4/x86_64-rhel-8.3/50%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp2/SCTP_RR/netperf

commit: 
  cb1898f58e ("perf annotate-data: Support --skip-empty option")
  a9ac22fb7a ("perf: Remove setting of page->index and ->mapping")

cb1898f58e0f175d a9ac22fb7ac3486a5bd89c25a2f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     20146           -14.1%      17300 ±  2%  uptime.idle
 1.568e+10           -20.5%  1.246e+10        cpuidle..time
 1.702e+09           -32.2%  1.154e+09        cpuidle..usage
   3115754           -88.3%     365170 ± 16%  numa-numastat.node1.local_node
   3215262           -87.0%     419236 ±  8%  numa-numastat.node1.numa_hit
     37.40           -16.6%      31.18        vmstat.cpu.id
  11031758           -31.8%    7527987        vmstat.system.cs
   5666321           -23.4%    4342549        vmstat.system.in
     37.03            -6.3       30.75        mpstat.cpu.all.idle%
      3.69            -0.7        3.02        mpstat.cpu.all.irq%
     18.00            +7.2       25.18        mpstat.cpu.all.soft%
      2.07            -0.7        1.38        mpstat.cpu.all.usr%
     81.67 ± 19%    -100.0%       0.00        perf-c2c.DRAM.local
      3324 ± 14%    -100.0%       0.00        perf-c2c.DRAM.remote
    246856          -100.0%       0.00        perf-c2c.HITM.local
      1771 ± 11%    -100.0%       0.00        perf-c2c.HITM.remote
    248627          -100.0%       0.00        perf-c2c.HITM.total
   2836525           -31.4%    1944538        netperf.ThroughputBoth_total_tps
     44320           -31.4%      30383        netperf.ThroughputBoth_tps
   2836525           -31.4%    1944538        netperf.Throughput_total_tps
     44320           -31.4%      30383        netperf.Throughput_tps
     15538 ±  2%   +1516.1%     251120 ±  5%  netperf.time.involuntary_context_switches
      2180           -18.6%       1774        netperf.time.percent_of_cpu_this_job_got
      6401           -17.7%       5264        netperf.time.system_time
    253.51           -40.6%     150.54        netperf.time.user_time
 8.508e+08           -31.5%  5.829e+08        netperf.time.voluntary_context_switches
  8.51e+08           -31.4%  5.834e+08        netperf.workload
   3568833 ±  6%     -99.9%       5313 ±  2%  meminfo.Active
   3568785 ±  6%     -99.9%       5273 ±  2%  meminfo.Active(anon)
  10615057           -71.1%    3072650        meminfo.Cached
   8430375           -89.9%     851992        meminfo.Committed_AS
   4707200 ±  4%     -85.5%     681046        meminfo.Inactive
   4706988 ±  4%     -85.5%     680826        meminfo.Inactive(anon)
    130914           -16.5%     109250        meminfo.KReclaimable
   2445242 ±  6%     -98.6%      33828        meminfo.Mapped
  13265505           -55.6%    5893945        meminfo.Memused
     16829 ±  2%     -26.3%      12400        meminfo.PageTables
    130914           -16.5%     109250        meminfo.SReclaimable
   7553109           -99.9%      11212        meminfo.Shmem
  13506404           -54.0%    6207695        meminfo.max_used_kB
    225772 ± 64%     -38.0%     139999 ±100%  numa-meminfo.node0.AnonPages
    227536 ± 64%     -37.7%     141653 ± 99%  numa-meminfo.node0.Inactive
    227365 ± 64%     -37.8%     141435 ± 99%  numa-meminfo.node0.Inactive(anon)
    122078 ±  8%     -85.9%      17153 ± 74%  numa-meminfo.node0.Mapped
      9967 ±  5%     -38.4%       6143 ±  8%  numa-meminfo.node0.PageTables
   3547939 ±  6%     -99.9%       2434 ± 19%  numa-meminfo.node1.Active
   3547931 ±  6%     -99.9%       2434 ± 19%  numa-meminfo.node1.Active(anon)
  10022700 ±  6%     -84.9%    1510608 ± 82%  numa-meminfo.node1.FilePages
   4491145 ±  7%     -88.0%     539362 ± 26%  numa-meminfo.node1.Inactive
   4491105 ±  7%     -88.0%     539359 ± 26%  numa-meminfo.node1.Inactive(anon)
   2331352 ±  6%     -99.3%      16689 ± 75%  numa-meminfo.node1.Mapped
  11420187 ±  6%     -73.5%    3022233 ± 39%  numa-meminfo.node1.MemUsed
   7538938          -100.0%       3512 ± 13%  numa-meminfo.node1.Shmem
     56484 ± 64%     -38.0%      34994 ±100%  numa-vmstat.node0.nr_anon_pages
     56882 ± 64%     -37.8%      35353 ± 99%  numa-vmstat.node0.nr_inactive_anon
     30662 ±  9%     -85.5%       4434 ± 73%  numa-vmstat.node0.nr_mapped
      2501 ±  5%     -38.5%       1537 ±  8%  numa-vmstat.node0.nr_page_table_pages
     56882 ± 64%     -37.8%      35353 ± 99%  numa-vmstat.node0.nr_zone_inactive_anon
    889164 ±  6%     -99.9%     608.62 ± 19%  numa-vmstat.node1.nr_active_anon
   2505432 ±  6%     -84.9%     377651 ± 82%  numa-vmstat.node1.nr_file_pages
   1120376 ±  7%     -88.0%     134862 ± 26%  numa-vmstat.node1.nr_inactive_anon
    581125 ±  6%     -99.3%       4276 ± 75%  numa-vmstat.node1.nr_mapped
   1884492          -100.0%     877.88 ± 13%  numa-vmstat.node1.nr_shmem
    889164 ±  6%     -99.9%     608.62 ± 19%  numa-vmstat.node1.nr_zone_active_anon
   1120376 ±  7%     -88.0%     134862 ± 26%  numa-vmstat.node1.nr_zone_inactive_anon
   3212683           -87.0%     417119 ±  8%  numa-vmstat.node1.numa_hit
   3113203           -88.3%     363053 ± 16%  numa-vmstat.node1.numa_local
    889503 ±  6%     -99.9%       1318 ±  2%  proc-vmstat.nr_active_anon
    181558            -6.6%     169658        proc-vmstat.nr_anon_pages
   6224451            +3.0%    6408360        proc-vmstat.nr_dirty_background_threshold
  12464123            +3.0%   12832389        proc-vmstat.nr_dirty_threshold
   2652787           -71.0%     768163        proc-vmstat.nr_file_pages
  62620501            +2.9%   64462280        proc-vmstat.nr_free_pages
   1178408 ±  4%     -85.6%     170197        proc-vmstat.nr_inactive_anon
    612759 ±  6%     -98.6%       8708        proc-vmstat.nr_mapped
      4212 ±  2%     -26.5%       3098        proc-vmstat.nr_page_table_pages
   1887299           -99.9%       2803        proc-vmstat.nr_shmem
     32725           -16.5%      27312        proc-vmstat.nr_slab_reclaimable
    889503 ±  6%     -99.9%       1318 ±  2%  proc-vmstat.nr_zone_active_anon
   1178408 ±  4%     -85.6%     170197        proc-vmstat.nr_zone_inactive_anon
    290672 ± 45%     -96.8%       9303 ± 41%  proc-vmstat.numa_hint_faults
    175901 ± 76%     -97.5%       4457 ± 89%  proc-vmstat.numa_hint_faults_local
   3663440           -77.3%     830893        proc-vmstat.numa_hit
   3530845           -79.5%     723050        proc-vmstat.numa_local
    132548           -18.6%     107828        proc-vmstat.numa_other
    467705 ± 25%     -87.5%      58338 ± 63%  proc-vmstat.numa_pte_updates
   2487950          -100.0%     114.50 ± 16%  proc-vmstat.pgactivate
   3816007           -74.2%     983809        proc-vmstat.pgalloc_normal
   1529029 ±  8%  +34293.1%  5.259e+08        proc-vmstat.pgfault
   1080189           -31.0%     745470        proc-vmstat.pgfree
     50047 ± 16%     -19.9%      40097        proc-vmstat.pgreuse
      0.13 ± 12%     -55.6%       0.06 ±  9%  perf-stat.i.MPKI
 3.129e+10           +64.8%  5.157e+10        perf-stat.i.branch-instructions
      1.12            -0.5        0.63        perf-stat.i.branch-miss-rate%
 3.419e+08           -14.1%  2.935e+08        perf-stat.i.branch-misses
  19925383 ± 13%     -32.6%   13438806 ±  9%  perf-stat.i.cache-misses
 1.336e+09           -24.7%  1.006e+09        perf-stat.i.cache-references
  11135389           -31.8%    7599205        perf-stat.i.context-switches
      1.55           -28.8%       1.10        perf-stat.i.cpi
 2.551e+11            +3.4%  2.637e+11        perf-stat.i.cpu-cycles
     86514 ±  4%     +26.7%     109601        perf-stat.i.cpu-migrations
     14145 ± 17%     +43.8%      20343 ±  8%  perf-stat.i.cycles-between-cache-misses
 1.648e+11           +51.5%  2.497e+11        perf-stat.i.instructions
      0.65           +45.3%       0.95        perf-stat.i.ipc
     87.60            -1.3%      86.48        perf-stat.i.metric.K/sec
      4794 ±  9%  +35590.7%    1711366        perf-stat.i.minor-faults
      4795 ±  9%  +35590.6%    1711366        perf-stat.i.page-faults
      0.12 ± 13%     -55.5%       0.05 ±  9%  perf-stat.overall.MPKI
      1.09            -0.5        0.57        perf-stat.overall.branch-miss-rate%
      1.55           -31.8%       1.06        perf-stat.overall.cpi
     13042 ± 14%     +51.7%      19779 ±  8%  perf-stat.overall.cycles-between-cache-misses
      0.65           +46.6%       0.95        perf-stat.overall.ipc
     59142          +121.0%     130686        perf-stat.overall.path-length
 3.118e+10           +64.8%  5.139e+10        perf-stat.ps.branch-instructions
 3.407e+08           -14.1%  2.925e+08        perf-stat.ps.branch-misses
  19880579 ± 13%     -32.6%   13396005 ±  9%  perf-stat.ps.cache-misses
 1.332e+09           -24.7%  1.003e+09        perf-stat.ps.cache-references
  11093234           -31.7%    7573495        perf-stat.ps.context-switches
 2.542e+11            +3.4%  2.628e+11        perf-stat.ps.cpu-cycles
     87621 ±  3%     +24.9%     109407        perf-stat.ps.cpu-migrations
 1.642e+11           +51.6%  2.489e+11        perf-stat.ps.instructions
      4770 ±  9%  +35666.9%    1706137        perf-stat.ps.minor-faults
      4770 ±  9%  +35666.8%    1706137        perf-stat.ps.page-faults
 5.033e+13           +51.5%  7.624e+13        perf-stat.total.instructions
   3403878            -9.6%    3076953        sched_debug.cfs_rq:/.avg_vruntime.avg
   5906828 ±  7%     +51.1%    8927261 ±  9%  sched_debug.cfs_rq:/.avg_vruntime.max
   3312785           -12.6%    2896386        sched_debug.cfs_rq:/.avg_vruntime.min
    243929 ±  9%    +164.4%     644860 ±  7%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      1.31 ± 11%     +31.9%       1.72 ± 17%  sched_debug.cfs_rq:/.h_nr_running.max
    267222 ± 12%     -37.6%     166754 ± 11%  sched_debug.cfs_rq:/.left_deadline.avg
   3510445            -9.8%    3168156 ±  4%  sched_debug.cfs_rq:/.left_deadline.max
    902490 ±  6%     -25.0%     677076 ±  4%  sched_debug.cfs_rq:/.left_deadline.stddev
    267208 ± 12%     -37.6%     166745 ± 11%  sched_debug.cfs_rq:/.left_vruntime.avg
   3510259            -9.8%    3167981 ±  4%  sched_debug.cfs_rq:/.left_vruntime.max
    902441 ±  6%     -25.0%     677037 ±  4%  sched_debug.cfs_rq:/.left_vruntime.stddev
      7978 ±  2%     +21.3%       9675 ± 11%  sched_debug.cfs_rq:/.load.avg
     22814 ± 14%    +289.5%      88865 ±147%  sched_debug.cfs_rq:/.load.max
   3403878            -9.6%    3076953        sched_debug.cfs_rq:/.min_vruntime.avg
   5906828 ±  7%     +51.1%    8927261 ±  9%  sched_debug.cfs_rq:/.min_vruntime.max
   3312785           -12.6%    2896386        sched_debug.cfs_rq:/.min_vruntime.min
    243929 ±  9%    +164.4%     644860 ±  7%  sched_debug.cfs_rq:/.min_vruntime.stddev
    267208 ± 12%     -37.6%     166745 ± 11%  sched_debug.cfs_rq:/.right_vruntime.avg
   3510259            -9.8%    3167983 ±  4%  sched_debug.cfs_rq:/.right_vruntime.max
    902441 ±  6%     -25.0%     677037 ±  4%  sched_debug.cfs_rq:/.right_vruntime.stddev
    124.18 ±  5%     +19.4%     148.27 ±  2%  sched_debug.cfs_rq:/.runnable_avg.stddev
    410.44            -8.7%     374.59        sched_debug.cfs_rq:/.util_avg.avg
    123.79 ±  5%     +19.4%     147.85 ±  2%  sched_debug.cfs_rq:/.util_avg.stddev
    688.89 ±  8%     +38.7%     955.28 ±  3%  sched_debug.cfs_rq:/.util_est.max
    451880 ± 32%     +68.2%     759893 ± 15%  sched_debug.cpu.avg_idle.max
      6812 ±  2%     +66.2%      11326        sched_debug.cpu.avg_idle.min
     57452 ± 22%     +59.0%      91375 ± 12%  sched_debug.cpu.avg_idle.stddev
      1511 ± 10%    +166.4%       4026 ±  6%  sched_debug.cpu.clock_task.stddev
      1.31 ± 11%     +34.0%       1.75 ±  9%  sched_debug.cpu.nr_running.max
  13041493           -24.7%    9825289        sched_debug.cpu.nr_switches.avg
  13244004           -23.9%   10073573        sched_debug.cpu.nr_switches.max
   8013647 ± 10%     -84.4%    1247149 ±125%  sched_debug.cpu.nr_switches.min
    499070 ± 10%     +82.7%     911672 ±  9%  sched_debug.cpu.nr_switches.stddev
      9.34 ±  3%     -11.6%       8.26 ±  5%  sched_debug.cpu.nr_uninterruptible.stddev
     46.47           -46.5        0.00        perf-profile.calltrace.cycles-pp.___sys_sendmsg.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg
     45.66           -45.7        0.00        perf-profile.calltrace.cycles-pp.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
     45.53 ± 18%     -45.5        0.00        perf-profile.calltrace.cycles-pp.main
     43.65           -43.6        0.00        perf-profile.calltrace.cycles-pp.sctp_sendmsg.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg.do_syscall_64
     42.48           -42.5        0.00        perf-profile.calltrace.cycles-pp.sctp_sendmsg_to_asoc.sctp_sendmsg.____sys_sendmsg.___sys_sendmsg.__sys_sendmsg
     37.52           -37.5        0.00        perf-profile.calltrace.cycles-pp.sctp_primitive_SEND.sctp_sendmsg_to_asoc.sctp_sendmsg.____sys_sendmsg.___sys_sendmsg
     35.70           -35.7        0.00        perf-profile.calltrace.cycles-pp.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND.sctp_sendmsg_to_asoc
     29.47           -29.5        0.00        perf-profile.calltrace.cycles-pp.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND
     29.39           -29.4        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     26.68           -26.7        0.00        perf-profile.calltrace.cycles-pp.common_startup_64
     26.58           -26.6        0.00        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm
     26.51           -26.5        0.00        perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     26.48           -26.5        0.00        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     26.42           -26.4        0.00        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     25.57           -25.6        0.00        perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.sctp_packet_transmit.sctp_outq_flush.sctp_cmd_interpreter
     25.24           -25.2        0.00        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.sctp_packet_transmit.sctp_outq_flush
     24.20           -24.2        0.00        perf-profile.calltrace.cycles-pp.sendmsg.process_requests.spawn_child.accept_connection.accept_connections
     24.11           -24.1        0.00        perf-profile.calltrace.cycles-pp.sendmsg.main
     23.86           -23.9        0.00        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.sctp_packet_transmit
     23.73           -23.7        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sendmsg.process_requests.spawn_child.accept_connection
     23.72           -23.7        0.00        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit
     23.71           -23.7        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg.process_requests.spawn_child
     23.62           -23.6        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sendmsg.main
     23.60           -23.6        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg.main
     23.59           -23.6        0.00        perf-profile.calltrace.cycles-pp.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
     23.53           -23.5        0.00        perf-profile.calltrace.cycles-pp.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg.process_requests
     23.43           -23.4        0.00        perf-profile.calltrace.cycles-pp.__sys_sendmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.sendmsg.main
     22.88           -22.9        0.00        perf-profile.calltrace.cycles-pp.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
     22.79           -22.8        0.00        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     22.46           -22.5        0.00        perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip
     22.35           -22.3        0.00        perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.handle_softirqs.do_softirq
     22.02           -22.0        0.00        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.handle_softirqs
     21.80           -21.8        0.00        perf-profile.calltrace.cycles-pp.recvmsg
     21.50           -21.5        0.00        perf-profile.calltrace.cycles-pp.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND.sctp_sendmsg_to_asoc.sctp_sendmsg
     21.31           -21.3        0.00        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
     21.26           -21.3        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     21.24           -21.2        0.00        perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
     21.08           -21.1        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     20.96           -21.0        0.00        perf-profile.calltrace.cycles-pp.sctp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
     20.92 ± 41%     -20.9        0.00        perf-profile.calltrace.cycles-pp.accept_connection.accept_connections.main
     20.92 ± 41%     -20.9        0.00        perf-profile.calltrace.cycles-pp.accept_connections.main
     20.92 ± 41%     -20.9        0.00        perf-profile.calltrace.cycles-pp.process_requests.spawn_child.accept_connection.accept_connections.main
     20.92 ± 41%     -20.9        0.00        perf-profile.calltrace.cycles-pp.spawn_child.accept_connection.accept_connections.main
     20.40           -20.4        0.00        perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     20.34           -20.3        0.00        perf-profile.calltrace.cycles-pp.sctp_do_sm.sctp_primitive_SEND.sctp_sendmsg_to_asoc.sctp_sendmsg.____sys_sendmsg
     20.05           -20.1        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recvmsg
     20.02           -20.0        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvmsg
     18.81           -18.8        0.00        perf-profile.calltrace.cycles-pp.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvmsg
     18.35           -18.4        0.00        perf-profile.calltrace.cycles-pp.___sys_recvmsg.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe.recvmsg
     17.76           -17.8        0.00        perf-profile.calltrace.cycles-pp.sctp_assoc_bh_rcv.sctp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
     17.53           -17.5        0.00        perf-profile.calltrace.cycles-pp.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg.do_syscall_64.entry_SYSCALL_64_after_hwframe
     17.04           -17.0        0.00        perf-profile.calltrace.cycles-pp.sock_recvmsg.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg.do_syscall_64
     16.61           -16.6        0.00        perf-profile.calltrace.cycles-pp.inet_recvmsg.sock_recvmsg.____sys_recvmsg.___sys_recvmsg.__sys_recvmsg
     16.40           -16.4        0.00        perf-profile.calltrace.cycles-pp.sctp_recvmsg.inet_recvmsg.sock_recvmsg.____sys_recvmsg.___sys_recvmsg
     14.32 ±  2%     -14.3        0.00        perf-profile.calltrace.cycles-pp.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
     13.68 ±  2%     -13.7        0.00        perf-profile.calltrace.cycles-pp.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv.ip_protocol_deliver_rcu
      9.63            -9.6        0.00        perf-profile.calltrace.cycles-pp.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg.sock_recvmsg.____sys_recvmsg
      9.28 ±  2%      -9.3        0.00        perf-profile.calltrace.cycles-pp.sctp_outq_sack.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv.sctp_rcv
      9.08            -9.1        0.00        perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      7.30            -7.3        0.00        perf-profile.calltrace.cycles-pp.schedule_timeout.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg.sock_recvmsg
      7.05            -7.1        0.00        perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.sctp_skb_recv_datagram.sctp_recvmsg.inet_recvmsg
      6.92            -6.9        0.00        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.sctp_skb_recv_datagram.sctp_recvmsg
      6.02            -6.0        0.00        perf-profile.calltrace.cycles-pp.sctp_outq_flush_data.sctp_outq_flush.sctp_cmd_interpreter.sctp_do_sm.sctp_primitive_SEND
      5.78 ±  3%      -5.8        0.00        perf-profile.calltrace.cycles-pp.sctp_chunk_put.sctp_outq_sack.sctp_cmd_interpreter.sctp_do_sm.sctp_assoc_bh_rcv
      5.48            -5.5        0.00        perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      5.33 ±  4%      -5.3        0.00        perf-profile.calltrace.cycles-pp.consume_skb.sctp_chunk_put.sctp_outq_sack.sctp_cmd_interpreter.sctp_do_sm
     67.76           -67.8        0.00        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     67.49           -67.5        0.00        perf-profile.children.cycles-pp.do_syscall_64
     48.53           -48.5        0.00        perf-profile.children.cycles-pp.sendmsg
     47.03           -47.0        0.00        perf-profile.children.cycles-pp.__sys_sendmsg
     46.55           -46.6        0.00        perf-profile.children.cycles-pp.___sys_sendmsg
     45.75           -45.7        0.00        perf-profile.children.cycles-pp.____sys_sendmsg
     45.59 ± 18%     -45.6        0.00        perf-profile.children.cycles-pp.main
     44.18           -44.2        0.00        perf-profile.children.cycles-pp.sctp_sendmsg
     42.58           -42.6        0.00        perf-profile.children.cycles-pp.sctp_sendmsg_to_asoc
     37.58           -37.6        0.00        perf-profile.children.cycles-pp.sctp_primitive_SEND
     37.38           -37.4        0.00        perf-profile.children.cycles-pp.sctp_do_sm
     36.84           -36.8        0.00        perf-profile.children.cycles-pp.sctp_cmd_interpreter
     35.94           -35.9        0.00        perf-profile.children.cycles-pp.sctp_outq_flush
     29.54           -29.5        0.00        perf-profile.children.cycles-pp.sctp_packet_transmit
     26.68           -26.7        0.00        perf-profile.children.cycles-pp.common_startup_64
     26.68           -26.7        0.00        perf-profile.children.cycles-pp.cpu_startup_entry
     26.63           -26.6        0.00        perf-profile.children.cycles-pp.__ip_queue_xmit
     26.63           -26.6        0.00        perf-profile.children.cycles-pp.do_idle
     26.51           -26.5        0.00        perf-profile.children.cycles-pp.start_secondary
     25.62           -25.6        0.00        perf-profile.children.cycles-pp.ip_finish_output2
     25.30           -25.3        0.00        perf-profile.children.cycles-pp.__dev_queue_xmit
     24.78           -24.8        0.00        perf-profile.children.cycles-pp.accept_connection
     24.78           -24.8        0.00        perf-profile.children.cycles-pp.accept_connections
     24.78           -24.8        0.00        perf-profile.children.cycles-pp.process_requests
     24.78           -24.8        0.00        perf-profile.children.cycles-pp.spawn_child
     24.02           -24.0        0.00        perf-profile.children.cycles-pp.__local_bh_enable_ip
     23.80           -23.8        0.00        perf-profile.children.cycles-pp.handle_softirqs
     23.78           -23.8        0.00        perf-profile.children.cycles-pp.do_softirq
     22.97           -23.0        0.00        perf-profile.children.cycles-pp.cpuidle_idle_call
     22.92           -22.9        0.00        perf-profile.children.cycles-pp.net_rx_action
     22.50           -22.5        0.00        perf-profile.children.cycles-pp.__napi_poll
     22.38           -22.4        0.00        perf-profile.children.cycles-pp.process_backlog
     22.06           -22.1        0.00        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
     21.93           -21.9        0.00        perf-profile.children.cycles-pp.recvmsg
     21.41           -21.4        0.00        perf-profile.children.cycles-pp.cpuidle_enter
     21.34           -21.3        0.00        perf-profile.children.cycles-pp.ip_local_deliver_finish
     21.28           -21.3        0.00        perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
     21.26           -21.3        0.00        perf-profile.children.cycles-pp.cpuidle_enter_state
     21.03           -21.0        0.00        perf-profile.children.cycles-pp.sctp_rcv
     20.54           -20.5        0.00        perf-profile.children.cycles-pp.acpi_idle_enter
     20.42           -20.4        0.00        perf-profile.children.cycles-pp.acpi_safe_halt
     18.83           -18.8        0.00        perf-profile.children.cycles-pp.__sys_recvmsg
     18.36           -18.4        0.00        perf-profile.children.cycles-pp.___sys_recvmsg
     17.81           -17.8        0.00        perf-profile.children.cycles-pp.sctp_assoc_bh_rcv
     17.75           -17.8        0.00        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
     17.55           -17.6        0.00        perf-profile.children.cycles-pp.____sys_recvmsg
     17.06           -17.1        0.00        perf-profile.children.cycles-pp.sock_recvmsg
     16.84           -16.8        0.00        perf-profile.children.cycles-pp.sctp_recvmsg
     16.62           -16.6        0.00        perf-profile.children.cycles-pp.inet_recvmsg
      9.68            -9.7        0.00        perf-profile.children.cycles-pp.sctp_skb_recv_datagram
      9.54            -9.5        0.00        perf-profile.children.cycles-pp.__schedule
      9.36 ±  2%      -9.4        0.00        perf-profile.children.cycles-pp.sctp_outq_sack
      8.24 ±  2%      -8.2        0.00        perf-profile.children.cycles-pp.sctp_chunk_put
      7.62            -7.6        0.00        perf-profile.children.cycles-pp.schedule_timeout
      7.06            -7.1        0.00        perf-profile.children.cycles-pp.schedule
      6.38 ±  3%      -6.4        0.00        perf-profile.children.cycles-pp.consume_skb
      6.14 ±  3%      -6.1        0.00        perf-profile.children.cycles-pp.skb_release_head_state
      6.14            -6.1        0.00        perf-profile.children.cycles-pp.sctp_outq_flush_data
      5.54            -5.5        0.00        perf-profile.children.cycles-pp.sysvec_call_function_single
     13.56           -13.6        0.00        perf-profile.self.cycles-pp.acpi_safe_halt




***************************************************************************************************
lkp-skl-fpga01: 104 threads 2 sockets (Skylake) with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/process/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/context_switch1/will-it-scale

commit: 
  cb1898f58e ("perf annotate-data: Support --skip-empty option")
  a9ac22fb7a ("perf: Remove setting of page->index and ->mapping")

cb1898f58e0f175d a9ac22fb7ac3486a5bd89c25a2f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     64399 ±  2%    +268.0%     236970 ± 13%  cpuidle..usage
   1317337 ±  5%     -75.7%     320761 ± 39%  numa-numastat.node1.local_node
   1363498 ±  5%     -72.5%     374923 ± 32%  numa-numastat.node1.numa_hit
     27.91           -60.0%      11.18 ±  3%  vmstat.cpu.us
  18301349           -60.6%    7203175 ±  4%  vmstat.system.cs
    129807          +465.4%     733957 ±  5%  vmstat.system.in
  18547591           -61.9%    7060612 ±  4%  will-it-scale.104.processes
    178341           -61.9%      67890 ±  4%  will-it-scale.per_process_ops
  18547591           -61.9%    7060612 ±  4%  will-it-scale.workload
      0.41 ±  4%      +0.9        1.33        mpstat.cpu.all.irq%
      0.01 ±  3%      -0.0        0.01 ±  2%  mpstat.cpu.all.soft%
     70.70           +16.1       86.78        mpstat.cpu.all.sys%
     28.09           -17.0       11.11 ±  4%  mpstat.cpu.all.usr%
    197.00 ± 65%    -100.0%       0.00        perf-c2c.DRAM.local
    345.00 ± 13%    -100.0%       0.00        perf-c2c.DRAM.remote
      6145 ± 30%    -100.0%       0.00        perf-c2c.HITM.local
    207.50 ±  9%    -100.0%       0.00        perf-c2c.HITM.remote
      6353 ± 29%    -100.0%       0.00        perf-c2c.HITM.total
   2719746 ±  3%     -99.9%       3450        meminfo.Active
   2719698 ±  3%     -99.9%       3402        meminfo.Active(anon)
   6617563 ±  2%     -53.4%    3084370        meminfo.Cached
   6890243 ±  2%     -51.3%    3357208        meminfo.Committed_AS
   1534356 ±  7%     -54.6%     696751        meminfo.Inactive
   1534138 ±  7%     -54.6%     696537        meminfo.Inactive(anon)
    107936           -12.2%      94813        meminfo.KReclaimable
    528224 ± 12%     -93.0%      36788        meminfo.Mapped
   8481255 ±  2%     -36.9%    5355841        meminfo.Memused
    107936           -12.2%      94813        meminfo.SReclaimable
   3544842 ±  4%     -99.7%      11703 ±  3%  meminfo.Shmem
   9043642 ±  2%     -38.6%    5554552        meminfo.max_used_kB
    322297 ± 32%     -50.7%     159027 ± 76%  numa-meminfo.node0.AnonPages
    422986 ± 24%     -59.1%     173110 ± 74%  numa-meminfo.node0.AnonPages.max
    323931 ± 32%     -50.6%     160140 ± 76%  numa-meminfo.node0.Inactive
    323754 ± 32%     -50.6%     159998 ± 76%  numa-meminfo.node0.Inactive(anon)
     75677 ± 11%     -66.8%      25143 ± 48%  numa-meminfo.node0.Mapped
   2716604 ±  3%     -99.9%       2155 ± 21%  numa-meminfo.node1.Active
   2716596 ±  3%     -99.9%       2139 ± 21%  numa-meminfo.node1.Active(anon)
   4505110 ± 29%     -71.2%    1298660 ± 98%  numa-meminfo.node1.FilePages
   1211376 ± 16%     -55.7%     536704 ± 22%  numa-meminfo.node1.Inactive
   1211335 ± 16%     -55.7%     536631 ± 22%  numa-meminfo.node1.Inactive(anon)
    451272 ± 15%     -97.4%      11673 ±103%  numa-meminfo.node1.Mapped
   5431186 ± 24%     -52.3%    2592950 ± 46%  numa-meminfo.node1.MemUsed
   3537633 ±  4%     -99.8%       6102 ± 19%  numa-meminfo.node1.Shmem
     80524 ± 32%     -50.6%      39762 ± 76%  numa-vmstat.node0.nr_anon_pages
     80887 ± 32%     -50.5%      40003 ± 76%  numa-vmstat.node0.nr_inactive_anon
     19126 ± 11%     -66.2%       6470 ± 47%  numa-vmstat.node0.nr_mapped
     80887 ± 32%     -50.5%      40003 ± 76%  numa-vmstat.node0.nr_zone_inactive_anon
    679371 ±  3%     -99.9%     535.24 ± 21%  numa-vmstat.node1.nr_active_anon
   1126311 ± 29%     -71.2%     324665 ± 98%  numa-vmstat.node1.nr_file_pages
    302619 ± 16%     -55.7%     134149 ± 22%  numa-vmstat.node1.nr_inactive_anon
    113050 ± 15%     -97.4%       2961 ±103%  numa-vmstat.node1.nr_mapped
    884442 ±  4%     -99.8%       1526 ± 19%  numa-vmstat.node1.nr_shmem
    679371 ±  3%     -99.9%     535.23 ± 21%  numa-vmstat.node1.nr_zone_active_anon
    302620 ± 16%     -55.7%     134149 ± 22%  numa-vmstat.node1.nr_zone_inactive_anon
   1362527 ±  5%     -72.5%     374747 ± 32%  numa-vmstat.node1.numa_hit
   1316366 ±  5%     -75.6%     320586 ± 39%  numa-vmstat.node1.numa_local
    120076 ± 10%     +44.5%     173481 ± 10%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      1.29           -14.3%       1.11 ±  2%  sched_debug.cfs_rq:/.h_nr_running.avg
      1093 ±141%    +350.1%       4923 ± 22%  sched_debug.cfs_rq:/.load.min
    120076 ± 10%     +44.5%     173481 ± 10%  sched_debug.cfs_rq:/.min_vruntime.stddev
      1815 ±  4%     +13.8%       2065        sched_debug.cfs_rq:/.runnable_avg.max
      1209           -12.4%       1059 ±  2%  sched_debug.cfs_rq:/.runnable_avg.min
     97.73 ± 12%     +66.6%     162.81 ±  5%  sched_debug.cfs_rq:/.runnable_avg.stddev
    804.36 ±  3%     -10.7%     718.36 ±  3%  sched_debug.cfs_rq:/.util_avg.min
    618.13           +16.3%     719.15 ±  2%  sched_debug.cfs_rq:/.util_est.avg
      1100 ±  5%     +36.4%       1501 ±  7%  sched_debug.cfs_rq:/.util_est.max
    793984 ±  2%     -34.7%     518681 ±  3%  sched_debug.cpu.avg_idle.avg
   1164653 ±  8%     -19.1%     942294 ±  8%  sched_debug.cpu.avg_idle.max
    187692 ± 10%     -18.2%     153546 ±  7%  sched_debug.cpu.avg_idle.stddev
      2817 ±  7%     -26.8%       2061 ±  8%  sched_debug.cpu.curr->pid.min
  26222425           -55.7%   11622454 ±  3%  sched_debug.cpu.nr_switches.avg
  27158282           -55.2%   12180443 ±  4%  sched_debug.cpu.nr_switches.max
  24464466 ±  2%     -57.5%   10402856 ±  4%  sched_debug.cpu.nr_switches.min
    605107 ± 12%     -44.4%     336330 ±  6%  sched_debug.cpu.nr_switches.stddev
    679317 ±  3%     -99.9%     850.20        proc-vmstat.nr_active_anon
    178194            -2.9%     172994        proc-vmstat.nr_anon_pages
   4677129            +1.7%    4755122        proc-vmstat.nr_dirty_background_threshold
   9365694            +1.7%    9521870        proc-vmstat.nr_dirty_threshold
   1654099 ±  2%     -53.4%     771092        proc-vmstat.nr_file_pages
  47057782            +1.7%   47838859        proc-vmstat.nr_free_pages
    383856 ±  7%     -54.6%     174141        proc-vmstat.nr_inactive_anon
    132404 ± 12%     -92.9%       9427        proc-vmstat.nr_mapped
      4649            -1.8%       4567        proc-vmstat.nr_page_table_pages
    885917 ±  4%     -99.7%       2924 ±  3%  proc-vmstat.nr_shmem
     26984           -12.2%      23703        proc-vmstat.nr_slab_reclaimable
    679317 ±  3%     -99.9%     850.20        proc-vmstat.nr_zone_active_anon
    383856 ±  7%     -54.6%     174141        proc-vmstat.nr_zone_inactive_anon
    201323 ± 11%     -96.8%       6359 ± 91%  proc-vmstat.numa_hint_faults
     98999 ± 21%     -99.5%     520.33 ±  5%  proc-vmstat.numa_hint_faults_local
   1907797 ±  2%     -58.8%     785657        proc-vmstat.numa_hit
   1805585 ±  2%     -61.4%     697853        proc-vmstat.numa_local
    107648           -18.6%      87641        proc-vmstat.numa_other
    399248 ± 16%     -88.1%      47657 ± 70%  proc-vmstat.numa_pte_updates
    958792 ±  5%    -100.0%     204.50 ±  8%  proc-vmstat.pgactivate
   2040912 ±  2%     -54.9%     920241        proc-vmstat.pgalloc_normal
   1329369 ±  2%  +15694.5%    2.1e+08        proc-vmstat.pgfault
   1004379           -27.6%     727403        proc-vmstat.pgfree
     49086 ± 20%     -18.3%      40086 ±  4%  proc-vmstat.pgreuse
      0.03           -33.3%       0.02 ± 17%  perf-stat.i.MPKI
 2.522e+10           +69.5%  4.275e+10 ±  3%  perf-stat.i.branch-instructions
      1.55            -0.6        0.94 ± 18%  perf-stat.i.branch-miss-rate%
  18477740           -60.7%    7266076 ±  4%  perf-stat.i.context-switches
      2.20           -37.2%       1.38 ±  3%  perf-stat.i.cpi
 2.835e+11            -2.3%  2.771e+11        perf-stat.i.cpu-cycles
    189.99            +3.7%     197.08        perf-stat.i.cpu-migrations
    154844 ±  2%     -35.7%      99550 ± 14%  perf-stat.i.cycles-between-cache-misses
 1.292e+11           +59.0%  2.054e+11 ±  3%  perf-stat.i.instructions
      0.46           +62.4%       0.74 ±  3%  perf-stat.i.ipc
    177.68           -53.2%      83.14 ±  3%  perf-stat.i.metric.K/sec
      4186 ±  2%  +16391.7%     690372        perf-stat.i.minor-faults
      4186 ±  2%  +16391.2%     690372        perf-stat.i.page-faults
      0.03 ±  2%     -42.7%       0.01 ± 19%  perf-stat.overall.MPKI
      1.54            -0.6        0.91 ± 19%  perf-stat.overall.branch-miss-rate%
      2.19           -38.5%       1.35 ±  3%  perf-stat.overall.cpi
      0.46           +62.7%       0.74 ±  3%  perf-stat.overall.ipc
   2105030          +318.8%    8815433        perf-stat.overall.path-length
 2.513e+10           +69.6%  4.262e+10 ±  3%  perf-stat.ps.branch-instructions
  18416035           -60.7%    7236360 ±  4%  perf-stat.ps.context-switches
 2.825e+11            -2.3%  2.761e+11        perf-stat.ps.cpu-cycles
    189.25            +3.8%     196.41        perf-stat.ps.cpu-migrations
 1.288e+11           +59.0%  2.048e+11 ±  3%  perf-stat.ps.instructions
      4169 ±  2%  +16406.3%     688277        perf-stat.ps.minor-faults
      4169 ±  2%  +16405.8%     688277        perf-stat.ps.page-faults
 3.904e+13           +59.3%  6.221e+13 ±  3%  perf-stat.total.instructions
     53.50           -53.5        0.00        perf-profile.calltrace.cycles-pp.read
     45.69           -45.7        0.00        perf-profile.calltrace.cycles-pp.write
     35.13           -35.1        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     31.89           -31.9        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     29.98           -30.0        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
     26.86           -26.9        0.00        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     26.74           -26.7        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     25.88           -25.9        0.00        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     23.71           -23.7        0.00        perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.52           -21.5        0.00        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     20.61           -20.6        0.00        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
     18.62 ±  2%     -18.6        0.00        perf-profile.calltrace.cycles-pp.pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.92           -16.9        0.00        perf-profile.calltrace.cycles-pp.schedule.pipe_read.vfs_read.ksys_read.do_syscall_64
     16.55           -16.6        0.00        perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.vfs_read.ksys_read
     14.74 ±  2%     -14.7        0.00        perf-profile.calltrace.cycles-pp.__wake_up_sync_key.pipe_write.vfs_write.ksys_write.do_syscall_64
     14.31 ±  2%     -14.3        0.00        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_sync_key.pipe_write.vfs_write.ksys_write
     14.10 ±  2%     -14.1        0.00        perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.pipe_write.vfs_write
     13.74 ±  2%     -13.7        0.00        perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.pipe_write
      9.02            -9.0        0.00        perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key
      7.16            -7.2        0.00        perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
      6.93            -6.9        0.00        perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.pipe_read.vfs_read
      6.62            -6.6        0.00        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.read
      6.14 ±  2%      -6.1        0.00        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.write
     65.61           -65.6        0.00        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     58.74           -58.7        0.00        perf-profile.children.cycles-pp.do_syscall_64
     53.92           -53.9        0.00        perf-profile.children.cycles-pp.read
     46.12           -46.1        0.00        perf-profile.children.cycles-pp.write
     26.87           -26.9        0.00        perf-profile.children.cycles-pp.ksys_read
     25.90           -25.9        0.00        perf-profile.children.cycles-pp.vfs_read
     23.87           -23.9        0.00        perf-profile.children.cycles-pp.pipe_read
     21.55           -21.5        0.00        perf-profile.children.cycles-pp.ksys_write
     20.65           -20.7        0.00        perf-profile.children.cycles-pp.vfs_write
     19.74           -19.7        0.00        perf-profile.children.cycles-pp.schedule
     19.36           -19.4        0.00        perf-profile.children.cycles-pp.__schedule
     18.67 ±  2%     -18.7        0.00        perf-profile.children.cycles-pp.pipe_write
     14.75 ±  2%     -14.8        0.00        perf-profile.children.cycles-pp.__wake_up_sync_key
     14.32 ±  2%     -14.3        0.00        perf-profile.children.cycles-pp.__wake_up_common
     14.10 ±  2%     -14.1        0.00        perf-profile.children.cycles-pp.autoremove_wake_function
     13.79 ±  2%     -13.8        0.00        perf-profile.children.cycles-pp.try_to_wake_up
     12.86           -12.9        0.00        perf-profile.children.cycles-pp.syscall_return_via_sysret
     10.00           -10.0        0.00        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      9.04            -9.0        0.00        perf-profile.children.cycles-pp.ttwu_do_activate
      8.44            -8.4        0.00        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      7.17            -7.2        0.00        perf-profile.children.cycles-pp.enqueue_task_fair
      6.95            -6.9        0.00        perf-profile.children.cycles-pp.dequeue_task_fair
      6.09            -6.1        0.00        perf-profile.children.cycles-pp.entry_SYSCALL_64
     12.54           -12.5        0.00        perf-profile.self.cycles-pp.syscall_return_via_sysret
      9.91            -9.9        0.00        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      6.97            -7.0        0.00        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      5.47            -5.5        0.00        perf-profile.self.cycles-pp.entry_SYSCALL_64



***************************************************************************************************
lkp-icl-2sp9: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
=========================================================================================
compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/testcase:
  gcc-12/performance/1BRD_32G/4K/nfsv4/ext4/1x/x86_64-rhel-8.3/1fpd/1t/debian-12-x86_64-20240206.cgz/fsyncBeforeClose/lkp-icl-2sp9/4G/fsmark

commit: 
  cb1898f58e ("perf annotate-data: Support --skip-empty option")
  a9ac22fb7a ("perf: Remove setting of page->index and ->mapping")

cb1898f58e0f175d a9ac22fb7ac3486a5bd89c25a2f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 1.519e+10           +34.7%  2.046e+10 ±  3%  cpuidle..time
     97.75            -4.6%      93.24        iostat.cpu.idle
      1.84          +220.2%       5.88        iostat.cpu.system
    301.00           +33.4%     401.55 ±  3%  uptime.boot
     18660           +28.1%      23909 ±  3%  uptime.idle
    929516 ±111%    +336.5%    4057213 ± 47%  numa-numastat.node0.local_node
    974371 ±104%    +320.7%    4098811 ± 47%  numa-numastat.node0.numa_hit
  17513401 ±  5%     -17.6%   14426818 ± 13%  numa-numastat.node1.local_node
  17535676 ±  5%     -17.6%   14440697 ± 13%  numa-numastat.node1.numa_hit
    403587           -29.1%     286045 ±  3%  vmstat.io.bo
      2.25          +128.2%       5.14        vmstat.procs.r
    324930           -27.4%     236047 ±  2%  vmstat.system.cs
    176422           +45.4%     256569        vmstat.system.in
    227.83 ± 11%    -100.0%       0.00        perf-c2c.DRAM.local
    427.33 ± 83%    -100.0%       0.00        perf-c2c.DRAM.remote
      5358 ±  4%    -100.0%       0.00        perf-c2c.HITM.local
    236.50 ± 98%    -100.0%       0.00        perf-c2c.HITM.remote
      5595 ±  2%    -100.0%       0.00        perf-c2c.HITM.total
  76998903           +33.3%  1.027e+08 ±  3%  fsmark.app_overhead
      4243           -29.8%       2978 ±  3%  fsmark.files_per_sec
    239.76           +42.0%     340.44 ±  3%  fsmark.time.elapsed_time
    239.76           +42.0%     340.44 ±  3%  fsmark.time.elapsed_time.max
     31.30           +51.6%      47.44 ±  3%  fsmark.time.system_time
   5769288            -1.7%    5670289        fsmark.time.voluntary_context_switches
      0.15            +0.0        0.20 ±  5%  mpstat.cpu.all.irq%
      0.19            +0.1        0.26        mpstat.cpu.all.soft%
      1.50            +3.9        5.43        mpstat.cpu.all.sys%
      0.09 ±  2%      +0.5        0.58        mpstat.cpu.all.usr%
      1.17 ± 31%  +22328.6%     261.67 ±  2%  mpstat.max_utilization.seconds
      5.18 ±  3%     +66.7%       8.63        mpstat.max_utilization_pct
    379352 ± 59%     +87.1%     709913 ± 32%  numa-meminfo.node0.AnonPages.max
      3104 ±  9%     +28.1%       3975 ± 12%  numa-meminfo.node0.PageTables
    111563 ± 19%     +62.9%     181723 ± 31%  numa-meminfo.node0.SUnreclaim
    517329 ±  2%     -99.6%       2323 ± 44%  numa-meminfo.node1.Active(anon)
    277501 ±  6%     -41.6%     162034 ± 18%  numa-meminfo.node1.Dirty
    526882 ±  2%     -99.5%       2824 ± 42%  numa-meminfo.node1.Shmem
    643.83 ±  6%     +39.5%     898.01 ± 20%  numa-meminfo.node1.Writeback
   3076105           -13.2%    2669099        meminfo.Active
    524607           -98.8%       6139 ±  2%  meminfo.Active(anon)
   1246297           +11.7%    1391614        meminfo.AnonHugePages
   3303829           -14.1%    2836865        meminfo.Committed_AS
    284869           -28.9%     202566 ±  3%  meminfo.Dirty
      7768           +10.6%       8592        meminfo.PageTables
    543894           -96.9%      16697        meminfo.Shmem
    645.23 ±  5%     +80.9%       1167 ± 18%  meminfo.Writeback
     87885 ±195%    +615.6%     628897 ± 53%  numa-vmstat.node0.nr_dirtied
      1993 ±222%    +420.2%      10370 ± 55%  numa-vmstat.node0.nr_dirty
    781.52 ±  8%     +27.2%     994.01 ± 12%  numa-vmstat.node0.nr_page_table_pages
     27893 ± 19%     +62.9%      45435 ± 31%  numa-vmstat.node0.nr_slab_unreclaimable
     87721 ±195%    +600.0%     614086 ± 53%  numa-vmstat.node0.nr_written
      1998 ±222%    +422.0%      10431 ± 55%  numa-vmstat.node0.nr_zone_write_pending
    973993 ±104%    +320.8%    4098274 ± 47%  numa-vmstat.node0.numa_hit
    929139 ±111%    +336.6%    4056676 ± 47%  numa-vmstat.node0.numa_local
    129283 ±  2%     -99.6%     581.30 ± 44%  numa-vmstat.node1.nr_active_anon
     69155 ±  6%     -41.7%      40315 ± 18%  numa-vmstat.node1.nr_dirty
    131705 ±  2%     -99.5%     705.99 ± 42%  numa-vmstat.node1.nr_shmem
    158.63 ±  4%     +35.6%     215.16 ± 15%  numa-vmstat.node1.nr_writeback
    129283 ±  2%     -99.6%     581.30 ± 44%  numa-vmstat.node1.nr_zone_active_anon
     69315 ±  6%     -41.5%      40531 ± 18%  numa-vmstat.node1.nr_zone_write_pending
  17534283 ±  5%     -17.6%   14439527 ± 13%  numa-vmstat.node1.numa_hit
  17512007 ±  5%     -17.6%   14425648 ± 13%  numa-vmstat.node1.numa_local
      1.74 ±  9%     -65.6%       0.60 ± 15%  perf-stat.i.MPKI
 9.615e+08          +285.6%  3.707e+09        perf-stat.i.branch-instructions
      0.69            -0.5        0.19        perf-stat.i.branch-miss-rate%
   7798406           -11.5%    6900769        perf-stat.i.branch-misses
    329459           -27.7%     238084 ±  2%  perf-stat.i.context-switches
      1.35           -30.1%       0.94        perf-stat.i.cpi
 6.387e+09          +159.7%  1.659e+10        perf-stat.i.cpu-cycles
    853.55 ±  3%    +132.1%       1980 ± 17%  perf-stat.i.cycles-between-cache-misses
 4.847e+09          +266.3%  1.776e+10        perf-stat.i.instructions
      0.75           +42.0%       1.07        perf-stat.i.ipc
      5.14         +2508.3%     134.15        perf-stat.i.metric.K/sec
      2541        +1.6e+05%    4173925        perf-stat.i.minor-faults
      2541        +1.6e+05%    4173925        perf-stat.i.page-faults
    673.07 ± 45%    +148.1%       1669 ± 16%  perf-stat.overall.cycles-between-cache-misses
      0.63 ± 44%     +69.6%       1.07        perf-stat.overall.ipc
 7.964e+08 ± 44%    +364.2%  3.697e+09        perf-stat.ps.branch-instructions
 5.299e+09 ± 44%    +212.2%  1.654e+10        perf-stat.ps.cpu-cycles
 4.015e+09 ± 44%    +341.1%  1.771e+10        perf-stat.ps.instructions
      2107 ± 44%    +2e+05%    4162878        perf-stat.ps.minor-faults
      2107 ± 44%    +2e+05%    4162878        perf-stat.ps.page-faults
 9.689e+11 ± 44%    +524.4%   6.05e+12 ±  3%  perf-stat.total.instructions
    131138           -98.8%       1536 ±  2%  proc-vmstat.nr_active_anon
    637951            +4.3%     665408        proc-vmstat.nr_active_file
    412901            +5.0%     433490        proc-vmstat.nr_anon_pages
    607.19           +11.8%     679.13        proc-vmstat.nr_anon_transparent_hugepages
     71193           -28.7%      50743 ±  3%  proc-vmstat.nr_dirty
    415380            +4.4%     433762        proc-vmstat.nr_inactive_anon
   1003928            +5.2%    1056379        proc-vmstat.nr_inactive_file
      9194            -5.4%       8699        proc-vmstat.nr_mapped
      1941           +10.8%       2151        proc-vmstat.nr_page_table_pages
    135981           -96.9%       4176        proc-vmstat.nr_shmem
    761716            +5.0%     799556        proc-vmstat.nr_slab_reclaimable
    135618            +5.3%     142780        proc-vmstat.nr_slab_unreclaimable
    165.40 ±  2%     +72.0%     284.42 ± 19%  proc-vmstat.nr_writeback
   3050431            +2.5%    3128215        proc-vmstat.nr_written
    131138           -98.8%       1536 ±  2%  proc-vmstat.nr_zone_active_anon
    637951            +4.3%     665408        proc-vmstat.nr_zone_active_file
    415380            +4.4%     433762        proc-vmstat.nr_zone_inactive_anon
   1003928            +5.2%    1056379        proc-vmstat.nr_zone_inactive_file
     71359           -28.5%      51028 ±  3%  proc-vmstat.nr_zone_write_pending
      1065 ± 10%     -19.5%     858.50 ±  5%  proc-vmstat.numa_hint_faults
    945.50 ± 10%     -50.9%     464.50 ±  6%  proc-vmstat.numa_hint_faults_local
    668.33 ± 25%     +47.3%     984.67 ±  2%  proc-vmstat.numa_huge_pte_updates
     66342           -18.5%      54068        proc-vmstat.numa_other
    367076 ± 23%     +38.1%     507046 ±  2%  proc-vmstat.numa_pte_updates
    150353 ±  2%     -98.4%       2420        proc-vmstat.pgactivate
    671082        +2.1e+05%  1.427e+09 ±  4%  proc-vmstat.pgfault
     29181           +34.0%      39102 ±  3%  proc-vmstat.pgreuse
      7675 ±  9%    +401.5%      38488 ±  8%  sched_debug.cfs_rq:/.avg_vruntime.avg
     40528 ± 16%    +958.7%     429065 ± 19%  sched_debug.cfs_rq:/.avg_vruntime.max
    705.29 ± 28%    +155.6%       1802 ± 21%  sched_debug.cfs_rq:/.avg_vruntime.min
      7669 ± 14%    +883.8%      75453 ± 12%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.30 ±  5%     +13.7%       0.34 ±  5%  sched_debug.cfs_rq:/.h_nr_running.stddev
    951.02 ± 14%     -38.0%     590.09 ± 34%  sched_debug.cfs_rq:/.load_avg.max
    172.57 ±  9%     -28.4%     123.61 ± 18%  sched_debug.cfs_rq:/.load_avg.stddev
      7675 ±  9%    +401.5%      38488 ±  8%  sched_debug.cfs_rq:/.min_vruntime.avg
     40528 ± 16%    +958.7%     429065 ± 19%  sched_debug.cfs_rq:/.min_vruntime.max
    705.29 ± 28%    +155.6%       1802 ± 21%  sched_debug.cfs_rq:/.min_vruntime.min
      7669 ± 14%    +883.8%      75453 ± 12%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.30 ±  5%     +13.9%       0.34 ±  5%  sched_debug.cfs_rq:/.nr_running.stddev
    716.12 ± 10%     +51.6%       1085 ±  3%  sched_debug.cfs_rq:/.runnable_avg.max
    147.84 ±  6%     +64.0%     242.44        sched_debug.cfs_rq:/.runnable_avg.stddev
    712.46 ± 10%     +52.1%       1083 ±  3%  sched_debug.cfs_rq:/.util_avg.max
    147.41 ±  6%     +64.2%     242.12        sched_debug.cfs_rq:/.util_avg.stddev
     16.26 ± 17%    +216.4%      51.45 ±  7%  sched_debug.cfs_rq:/.util_est.avg
    383.67 ± 19%    +162.8%       1008 ±  3%  sched_debug.cfs_rq:/.util_est.max
     63.16 ± 17%    +222.5%     203.68 ±  2%  sched_debug.cfs_rq:/.util_est.stddev
    165310 ±  8%     +24.3%     205470 ±  5%  sched_debug.cpu.clock.avg
    165314 ±  8%     +24.3%     205474 ±  5%  sched_debug.cpu.clock.max
    165279 ±  8%     +24.3%     205454 ±  5%  sched_debug.cpu.clock.min
      5.18 ± 28%     -36.4%       3.30 ± 18%  sched_debug.cpu.clock.stddev
    164698 ±  8%     +24.2%     204576 ±  5%  sched_debug.cpu.clock_task.avg
    165287 ±  8%     +24.3%     205370 ±  5%  sched_debug.cpu.clock_task.max
    155952 ±  9%     +25.1%     195174 ±  5%  sched_debug.cpu.clock_task.min
      1185 ±  2%      +8.9%       1290 ±  5%  sched_debug.cpu.clock_task.stddev
    274.22 ± 13%     +32.4%     362.97 ±  7%  sched_debug.cpu.curr->pid.avg
      5453 ±  6%     +18.4%       6455 ±  4%  sched_debug.cpu.curr->pid.max
    940.43 ±  9%     +18.8%       1117 ±  2%  sched_debug.cpu.curr->pid.stddev
      0.11 ± 10%     +25.0%       0.13 ±  9%  sched_debug.cpu.nr_running.avg
      0.30 ±  6%     +13.5%       0.34 ±  4%  sched_debug.cpu.nr_running.stddev
     24.81 ± 14%     +28.4%      31.85 ±  8%  sched_debug.cpu.nr_uninterruptible.stddev
    165310 ±  8%     +24.3%     205469 ±  5%  sched_debug.cpu_clk
    164147 ±  8%     +24.5%     204306 ±  5%  sched_debug.ktime
    165888 ±  8%     +24.2%     206051 ±  5%  sched_debug.sched_clk
     50.27           -50.3        0.00        perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     50.27           -50.3        0.00        perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     50.27           -50.3        0.00        perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     43.03 ±  6%     -43.0        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     37.89 ±  2%     -37.9        0.00        perf-profile.calltrace.cycles-pp.common_startup_64
     36.23 ±  2%     -36.2        0.00        perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     36.20 ±  2%     -36.2        0.00        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     36.14 ±  2%     -36.1        0.00        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     33.61 ±  2%     -33.6        0.00        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     33.08 ±  2%     -33.1        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     31.89 ±  2%     -31.9        0.00        perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     31.81 ±  2%     -31.8        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     27.02           -27.0        0.00        perf-profile.calltrace.cycles-pp.nfsd.kthread.ret_from_fork.ret_from_fork_asm
     26.83           -26.8        0.00        perf-profile.calltrace.cycles-pp.svc_recv.nfsd.kthread.ret_from_fork.ret_from_fork_asm
     24.50           -24.5        0.00        perf-profile.calltrace.cycles-pp.svc_handle_xprt.svc_recv.nfsd.kthread.ret_from_fork
     16.59 ±  3%     -16.6        0.00        perf-profile.calltrace.cycles-pp.svc_process.svc_handle_xprt.svc_recv.nfsd.kthread
     16.57 ±  3%     -16.6        0.00        perf-profile.calltrace.cycles-pp.svc_process_common.svc_process.svc_handle_xprt.svc_recv.nfsd
     16.02 ±  2%     -16.0        0.00        perf-profile.calltrace.cycles-pp.nfsd_dispatch.svc_process_common.svc_process.svc_handle_xprt.svc_recv
     15.33 ±  2%     -15.3        0.00        perf-profile.calltrace.cycles-pp.nfsd4_proc_compound.nfsd_dispatch.svc_process_common.svc_process.svc_handle_xprt
     13.29 ±  5%     -13.3        0.00        perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     12.88 ±  4%     -12.9        0.00        perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     10.99 ±  8%     -11.0        0.00        perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      9.54 ±  5%      -9.5        0.00        perf-profile.calltrace.cycles-pp.kjournald2.kthread.ret_from_fork.ret_from_fork_asm
      8.75 ±  5%      -8.7        0.00        perf-profile.calltrace.cycles-pp.jbd2_journal_commit_transaction.kjournald2.kthread.ret_from_fork.ret_from_fork_asm
      6.78 ±  4%      -6.8        0.00        perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      6.10 ±  3%      -6.1        0.00        perf-profile.calltrace.cycles-pp.ip6_xmit.inet6_csk_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames
      5.97 ±  4%      -6.0        0.00        perf-profile.calltrace.cycles-pp.nfsd4_create.nfsd4_proc_compound.nfsd_dispatch.svc_process_common.svc_process
      5.93 ±  4%      -5.9        0.00        perf-profile.calltrace.cycles-pp.ip6_finish_output.ip6_xmit.inet6_csk_xmit.__tcp_transmit_skb.tcp_write_xmit
      5.88 ±  7%      -5.9        0.00        perf-profile.calltrace.cycles-pp.rpc_async_schedule.process_one_work.worker_thread.kthread.ret_from_fork
      5.87 ±  5%      -5.9        0.00        perf-profile.calltrace.cycles-pp.nfsd_create.nfsd4_create.nfsd4_proc_compound.nfsd_dispatch.svc_process_common
      5.86 ±  4%      -5.9        0.00        perf-profile.calltrace.cycles-pp.ip6_finish_output2.ip6_finish_output.ip6_xmit.inet6_csk_xmit.__tcp_transmit_skb
      5.85 ±  7%      -5.9        0.00        perf-profile.calltrace.cycles-pp.__rpc_execute.rpc_async_schedule.process_one_work.worker_thread.kthread
      5.73 ±  4%      -5.7        0.00        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip6_finish_output2.ip6_finish_output.ip6_xmit.inet6_csk_xmit
      5.40 ± 15%      -5.4        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      5.10 ±  8%      -5.1        0.00        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip6_finish_output2.ip6_finish_output.ip6_xmit
      5.08 ±  8%      -5.1        0.00        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip6_finish_output2.ip6_finish_output
      5.04 ±  9%      -5.0        0.00        perf-profile.calltrace.cycles-pp.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip6_finish_output2
      4.92 ±  6%      -4.9        0.00        perf-profile.calltrace.cycles-pp.xs_tcp_send_request.xprt_request_transmit.xprt_transmit.call_transmit.__rpc_execute
     50.28           -50.3        0.00        perf-profile.children.cycles-pp.ret_from_fork_asm
     50.27           -50.3        0.00        perf-profile.children.cycles-pp.ret_from_fork
     50.27           -50.3        0.00        perf-profile.children.cycles-pp.kthread
     37.89 ±  2%     -37.9        0.00        perf-profile.children.cycles-pp.common_startup_64
     37.89 ±  2%     -37.9        0.00        perf-profile.children.cycles-pp.cpu_startup_entry
     37.83 ±  2%     -37.8        0.00        perf-profile.children.cycles-pp.do_idle
     36.23 ±  2%     -36.2        0.00        perf-profile.children.cycles-pp.start_secondary
     35.18 ±  2%     -35.2        0.00        perf-profile.children.cycles-pp.cpuidle_idle_call
     33.25 ±  2%     -33.2        0.00        perf-profile.children.cycles-pp.cpuidle_enter
     33.11 ±  2%     -33.1        0.00        perf-profile.children.cycles-pp.cpuidle_enter_state
     31.90 ±  2%     -31.9        0.00        perf-profile.children.cycles-pp.acpi_idle_enter
     31.85 ±  2%     -31.8        0.00        perf-profile.children.cycles-pp.acpi_safe_halt
     27.02           -27.0        0.00        perf-profile.children.cycles-pp.nfsd
     26.84           -26.8        0.00        perf-profile.children.cycles-pp.svc_recv
     25.33 ±  4%     -25.3        0.00        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
     24.51           -24.5        0.00        perf-profile.children.cycles-pp.svc_handle_xprt
     16.59 ±  3%     -16.6        0.00        perf-profile.children.cycles-pp.svc_process
     16.57 ±  3%     -16.6        0.00        perf-profile.children.cycles-pp.svc_process_common
     16.03 ±  2%     -16.0        0.00        perf-profile.children.cycles-pp.nfsd_dispatch
     15.35 ±  2%     -15.4        0.00        perf-profile.children.cycles-pp.nfsd4_proc_compound
     13.31 ±  5%     -13.3        0.00        perf-profile.children.cycles-pp.worker_thread
     11.01 ±  8%     -11.0        0.00        perf-profile.children.cycles-pp.process_one_work
      9.63 ±  6%      -9.6        0.00        perf-profile.children.cycles-pp.__rpc_execute
      9.55 ±  3%      -9.6        0.00        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      9.54 ±  5%      -9.5        0.00        perf-profile.children.cycles-pp.kjournald2
      9.54 ±  3%      -9.5        0.00        perf-profile.children.cycles-pp.do_syscall_64
      8.78 ±  5%      -8.8        0.00        perf-profile.children.cycles-pp.jbd2_journal_commit_transaction
      7.36 ±  3%      -7.4        0.00        perf-profile.children.cycles-pp.handle_softirqs
      7.32 ±  3%      -7.3        0.00        perf-profile.children.cycles-pp.__tcp_push_pending_frames
      7.29 ±  3%      -7.3        0.00        perf-profile.children.cycles-pp.tcp_write_xmit
      6.86 ±  2%      -6.9        0.00        perf-profile.children.cycles-pp.vfs_mkdir
      6.84 ±  3%      -6.8        0.00        perf-profile.children.cycles-pp.__tcp_transmit_skb
      6.82 ±  4%      -6.8        0.00        perf-profile.children.cycles-pp.sysvec_call_function_single
      6.30 ±  3%      -6.3        0.00        perf-profile.children.cycles-pp.inet6_csk_xmit
      6.10 ±  3%      -6.1        0.00        perf-profile.children.cycles-pp.ip6_xmit
      5.97 ±  4%      -6.0        0.00        perf-profile.children.cycles-pp.nfsd4_create
      5.93 ±  4%      -5.9        0.00        perf-profile.children.cycles-pp.ip6_finish_output
      5.88 ±  7%      -5.9        0.00        perf-profile.children.cycles-pp.rpc_async_schedule
      5.88 ±  5%      -5.9        0.00        perf-profile.children.cycles-pp.nfsd_create
      5.86 ±  4%      -5.9        0.00        perf-profile.children.cycles-pp.ip6_finish_output2
      5.74 ±  4%      -5.7        0.00        perf-profile.children.cycles-pp.__dev_queue_xmit
      5.53 ±  4%      -5.5        0.00        perf-profile.children.cycles-pp.__local_bh_enable_ip
      5.51 ±  3%      -5.5        0.00        perf-profile.children.cycles-pp.sock_sendmsg
      5.45 ±  4%      -5.4        0.00        perf-profile.children.cycles-pp.do_softirq
      5.38 ±  3%      -5.4        0.00        perf-profile.children.cycles-pp.tcp_sendmsg
      5.31 ±  4%      -5.3        0.00        perf-profile.children.cycles-pp.__schedule
      5.18 ±  6%      -5.2        0.00        perf-profile.children.cycles-pp.call_transmit
      5.14 ±  6%      -5.1        0.00        perf-profile.children.cycles-pp.xprt_transmit
      5.10 ±  6%      -5.1        0.00        perf-profile.children.cycles-pp.xprt_request_transmit
      5.08 ±  2%      -5.1        0.00        perf-profile.children.cycles-pp.tcp_sendmsg_locked
      5.02 ±  5%      -5.0        0.00        perf-profile.children.cycles-pp.net_rx_action
      4.93 ±  5%      -4.9        0.00        perf-profile.children.cycles-pp.xs_tcp_send_request
     21.35 ±  6%     -21.4        0.00        perf-profile.self.cycles-pp.acpi_safe_halt



Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

