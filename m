Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E03E1CEEB2;
	Mon, 31 Mar 2025 08:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743408564; cv=fail; b=dPHW8ECIRMgnL7klqcMDx7eDuNK3OEIWg8Iq5p+ACK+2wOw+72jGgq/JQO0JQ9SMvM9c5rwMJ5Eqj5zLDjpZp1TEbrLmbDTzh3nBfUvwvnLcf/uF6kHU6/h6CF1D8M/6EocZn2jzgvXA2tAxK0FkjsFnIFtzpfZ8qAxm/nJN6PI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743408564; c=relaxed/simple;
	bh=dumi5yhlEhR8ET4ZQx8tF52akVw1wM7Vh1ndZz0yqbI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=p/OOuuL41nOAbdDWoliwM1Ip9w/Ae4qRiv5OoI0nPvq0z6bYK7SLzJL6qMjXW8Oi+JpfdZo0m32wucP3vlqMurT3PJt9UN52dO4282DgIOGz+MnbsVcNoFrNlK2pdJATJqW4VAtgUPOKr3Rti/Mt1GaRPLl19Z1kAQeRAKqB1lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S4S7+JYg; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S4S7+JYg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743408553; x=1774944553;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=dumi5yhlEhR8ET4ZQx8tF52akVw1wM7Vh1ndZz0yqbI=;
  b=S4S7+JYgFZYDXFVxVIhT/IYhiUQcJIE6buQkWm7VpuibbwzVn3eTgLIs
   egYQMwGITg+bBcuR6K4WCX/DHl0oaQ2Bk0fMThZqOCN1AjfLLBzeKryvr
   YXCiyolV9OeczMiTpYwTQoUXSTjq99wmGGlbB9w7l3Mi08EVaPzYNsDxX
   8QfXNBZn0ipT5cz8otHnMNXfEytyGZ8qBtGlPOW6dVa3DipoOHc/nk6bo
   wvTitrgnY4y8uKAaVf9LtXedf22X9bhxbThOzzO6zJMrehNZ3EUwaYX0M
   Zf4b3kt/66hi8zyaC+gYgzj7byk/6raCyVRsCE5E/7a7ish3hyALZllfb
   Q==;
X-CSE-ConnectionGUID: 9i3CikTiRgiyV3Kjl4yFfg==
X-CSE-MsgGUID: mzM1Bn9HTDSusmDP+0rg8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11389"; a="54884761"
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="54884761"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 01:09:12 -0700
X-CSE-ConnectionGUID: hSAj+ZDeSliBkWDirZ4sMA==
X-CSE-MsgGUID: 9SxxtXFsTdWZsx7jOGDdBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="126006925"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Mar 2025 01:09:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 31 Mar 2025 01:09:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 31 Mar 2025 01:09:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 31 Mar 2025 01:09:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fw0Sg3we/gx/q61xnk+8XCYnLRKxOTCucoM7iKlYxYs0AYTXvDcNqhooYvatP6m8I13H+fhKupiibLbuZkLMXUNwKWvNPCntkNOiE7Jtj9qejDNTC23YNJIyJtTUvrMCiP2bZQYUDQrjuO3GHSCGaAAIvoDlrCbFhnJV8JbuppoKFuurSmlc51ov6Qh9E4Vui5X7rEfbZwHFYrtmW7l2eiOfjnwfLoLygQW2IF6vhf1E+BA8B9oLQLZMpBZ3/HDqqSVFAX/roRCJM5Q+SlwpILh1eUfAnNWIWXp+u2Y03KdiENTxECXFZw9xTbcdugQZMNwATX79RT/Eeh0XsNnucA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BlvlNHMhUq0XKG+f8DaCHDecmU0dX4OF3LKkqw8VuM=;
 b=uyMLcKJ++kuxy5bNBMBtZTSKNLfpxutVfy2CO8G7+t/M4oeQtkeZfIxNwCRdsF1CkA5s7ADBeBAmdjF7WmiDnFQl/BE7EoFbjjolTTfA6R2Hhjom8oPxw5CKSr5Ct5nohAI/T4LVF9D+6OCEPEBAgNstvWzQm7Z42LTcvafZWSvf699DRH8XHOCyerDqteWKF0XNdbJmuZivEYrTvO+jAMxKf8TUPhuS1qluaXvvJB3qC5ztUCZT+wDRXYTugJJZEapOAcUayIzfsuZ7W93YiXVQxsfKpLrGr5n+xuz0hUqLAjGNgtmtfeec9pqEk/5tIiZR8rn6g6wyqR3igmlXOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS7PR11MB5968.namprd11.prod.outlook.com (2603:10b6:8:73::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Mon, 31 Mar 2025 08:09:05 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 08:09:05 +0000
Date: Mon, 31 Mar 2025 16:08:54 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Namhyung Kim
	<namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [perf symbol]  b10f74308e:
 perf-sanity-tests.perf_record_LBR_tests.fail
Message-ID: <202503311428.2d19d587-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SG2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:3:18::32) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS7PR11MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: f1dd0313-d593-437f-d8fb-08dd702b4d95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1j0V24mFj3Rl73EN/qHYTcbwQoD1XX9xg0hazxsKL5r1iOKj/HnGIKAPCfqz?=
 =?us-ascii?Q?T8UnUn+GMIrlpm29sLV9hF+Vn0I18SW6zCTyXSnF/fFi7L0dH+YPE5GJwSPt?=
 =?us-ascii?Q?Lw5/ayiREZJC0awuUspqWQb7Np1s2rDhaysFOJeK0RF3Fstr/24h89Ws2kQI?=
 =?us-ascii?Q?WINAfLAJ9ZA4XSKT8zhaSFy+TxZttOfrscEgLQ6RyyG5A09lYXmCTQyX/jdJ?=
 =?us-ascii?Q?92YCcteUXItOqDA9qAMtVVZg36AnpytZqBj8BbsCPOG9WzwbsERudQwubk4v?=
 =?us-ascii?Q?Ut91SGFuvRTYGA+2v/zLiTSh3+75fIEQgJCbuSW3UXI6s+/kcy+0SzULtzbY?=
 =?us-ascii?Q?rXTc7dz2+ByFbBcQHLP9FaqJC55Oh4JgfR4VBb7CfWakcFL4Mkhv/1AbtXC1?=
 =?us-ascii?Q?JGkMRAm8SDcGKZ8x2bxTunZ5ZbyN68BjoVIzXc0e59PpUqTRBzrhVeEI0Vrw?=
 =?us-ascii?Q?/+0JiWyrM1ePaZrljKaJkIOU7+caM6YA2hTmBbt8uSbgNFbv4CD9H/3CQbGe?=
 =?us-ascii?Q?Kb305H8Hs26TVr+THdGhyp+lLy0WwdEz/GOexB7bPBtS9g0zuk9HZ6wZ53Go?=
 =?us-ascii?Q?wwqg8MZm8A5VBCusoaHXAky4bsMwJtOM8juFUHixmI+KClSgpPYKzxDpUTMd?=
 =?us-ascii?Q?Xsm9xRj8L/7yduy6T+IJmwt5478Z7q/bff2ezZ3+sM/fWCR3EPD9sEi93Gct?=
 =?us-ascii?Q?+NTNvUoit4qH0OJspQB9QV/cXBfXftB1Jd3NQoWpioZE9/v+3ULSrA01j4/h?=
 =?us-ascii?Q?f33cBxogn88KPyEPm513Vj5LQy1R+MYuUKYeyU83e+rkq0FaWNA7+gfceg6m?=
 =?us-ascii?Q?7Hx16Omv2lgZ4En4jSGVuWLwIFTHbq04GaRFbOyumIeWeNZtKwIElkA/QZGK?=
 =?us-ascii?Q?5Stewp8zuQ03blnnzzSMK4oxomopDfnSSKgh6agAHuHSnWDBdsXolEx6I6Gd?=
 =?us-ascii?Q?hBt2MPdjIZ7267xmgVk1Hl4tvkKnLa2MFsMkvfK1LekgKYTaEPEsUkEWYL4P?=
 =?us-ascii?Q?3Bnbf7yzXNXPdnwn16/tDr05kO9EVf290PsgQVEegxV1WKZxuojvUzh7gxB4?=
 =?us-ascii?Q?co6UkyU9bliDkpC0if7FSKT9XJxhlfJZqsiuMAh8fUswV6ECi8e06Q5yfKkR?=
 =?us-ascii?Q?YZ8G/uPzedzzzQmQ8pKeBnacrR/KEXo74mm2QH8jlSX1sx9MjPugQLR2gGcK?=
 =?us-ascii?Q?R54sO2AvJboah4lO0VMx06LqzpG5MIzZa0hlEzS+d+NBLUd+3JYnOqfXwJjb?=
 =?us-ascii?Q?et4Id+gi4a6+Lo67rA4nTZCwyXPczVqSIiMnrLYsK0r0tKy27ExFyAHHCoDC?=
 =?us-ascii?Q?qW7ic2BQXh0ToaHhN4kBJPkntc4mXk0iY30tBHlnLqRmfw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lSZe4E/UFXXU0ZiuPyUfz9fuYVHJBEFb9pCjt/w0+0c7orb1G/Sbz3uAbrDi?=
 =?us-ascii?Q?QhnbYd2RyhPuQ95u3FI5zYFEOfTXuM2nwZwcTgG4VZkR5nCfJSpq6lxERmuA?=
 =?us-ascii?Q?TWNWVp9gct5N4r9GLmevLtCsPmT8V2MG+O/T9712Pc34Zl3clDPxNfZhhG5S?=
 =?us-ascii?Q?imOfGKOWOsiwtUopbc47dj3TerFvxgj7pOB3+/WkeTSFHpHLj6YdlC0yXmhg?=
 =?us-ascii?Q?T7+gsTYnSoJ7paMdxEiWUwsYnOM2SxDUYpThTUWQH8799MJnNHPZ3zkV+sBN?=
 =?us-ascii?Q?xRkR3kO+EksPXYz0Kfxay/7ARkRCiyrqt9C3xFtVxiZw9KaQ7UeEM9JtOOFH?=
 =?us-ascii?Q?ZO7rQsPlS48bVEy+PleeLaZYHtxlV1XlILsbsoC06f/LwGlC0hxoMnef7hld?=
 =?us-ascii?Q?Ww/7r29Z+RmCNmSqOtPQoArZxwLLrXQpCD3iN5n0ocGqfHcmN5YjSf/YWob9?=
 =?us-ascii?Q?evzy8XcZZOpt/7LJXiZ+w1LVQXn2aoO5AUWj/LmfAcO/NcvkA1G6UcfFyOBE?=
 =?us-ascii?Q?EuaX14hoW1oPdv+Hbvqnz0Ooc4wSmZdgjBhhEGtLlyHNCJZcn6+d8PaRqGnN?=
 =?us-ascii?Q?c+aUzH9AuYclu59fmx0eDMCoAsOF1Qo4QQ7Ueh4YivYytiv8IKO/QlujQ+Tk?=
 =?us-ascii?Q?a7jGpdHyik9emlpUycRvagiw4QQVv4LynC9BbKZBsOHeY3OtwFsZZZT9Thnu?=
 =?us-ascii?Q?gPv9Y8aLf8gzaBPRWdMtnPRzD8LkQFATHGYo4Cd7pAgpw1jhwUc+bWCC8ywD?=
 =?us-ascii?Q?jkR89wY4M3TZdYBE7GWCzK9lrx/K8LBDnhFG8mfCH9tuZM5czlK73hSEBpyL?=
 =?us-ascii?Q?8CZghXhT/MekASAjokTaHpoGHjuOdHXdcqmJFY1Uf5NTrD61Dj8IthYqZhb4?=
 =?us-ascii?Q?zobdnH3pJsieh+HCJpO/q6pRp4ZEWMJdIx3kBuriA/6LAmqsb8yBEqavUFMB?=
 =?us-ascii?Q?Fw5dO1kc/5bbiMJlbdzWAlPPkkXYOOwyE9D49pQVKHo+8gueOJZ1WOKdzMDL?=
 =?us-ascii?Q?qowkm/vydUvhjlK1RT8OD2aMx8G6bGf1JCJoUuXGiNUiAZ15LI8DCTLhSag1?=
 =?us-ascii?Q?XE2ES8iOpA5+c/Uu6R38t09VaaAvEGkmXC3AtRywplaUab3DdRFGEfIbkPDu?=
 =?us-ascii?Q?GZqtFK6XY32ol5sjbP9iY//OyQbR2q5rwQCmv46/NLFGro3fHeqnw+2414q0?=
 =?us-ascii?Q?+g165SkrPsLa6agMPq0MFIhNPYPI1JfQZS+rA0n76NUs6KFYJL9zDuNcQlbL?=
 =?us-ascii?Q?sD2ewLs/lXqJJgD+NSbugm1CiZf9ZIOSFuqM5VNqUpX+J9Xs0X8ZVYsIjLvr?=
 =?us-ascii?Q?FP4ZgG07RGezDKbRx1VgTomxg/sD6bKWTSKp9v+hQYpZlaNwVHd3baDJLXlC?=
 =?us-ascii?Q?+y3LQjMUj3DmNPnHRkLzdoBZUUO3+yl/hyAM7D5k6PkB8Pm5DBR8SwkArU1H?=
 =?us-ascii?Q?OJlbs3vj3DzxN0aq5q5XHa2KTJdcfC+64ybRm9+19z9TSSKcP6E5FdU1ntUc?=
 =?us-ascii?Q?UbJ4tBYGzFXxTLqX/W3Sn/e/v/DpUhusDyeju6ZCHQaRHZk8RG9/t05K1mdx?=
 =?us-ascii?Q?JTmYAz4+W1g5BfghzyZRLuPC72t8XpdwZjfRfiz/++zbA0YJuyw8EaqQVt2W?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1dd0313-d593-437f-d8fb-08dd702b4d95
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 08:09:05.4243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vBbhdxI2/NO1L50a1QLREEfvfwo9i1Dl8+eUtuIurihpG0Jv63IjleHkzXqdvSWdIUFEoLgrszS2rwg1Bgm55g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5968
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "perf-sanity-tests.perf_record_LBR_tests.fail" on=
:

commit: b10f74308e1305275e69ddde711ec817cc69e306 ("perf symbol: Support .gn=
u_debugdata for symbols")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master e21edb1638e82460f126a6e49bcdd958d452929c]

in testcase: perf-sanity-tests
version:=20
with following parameters:

	perf_compiler: clang



config: x86_64-rhel-9.4-bpf
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz=
 (Ice Lake) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


besides, we also noticed below failures which can pass on parent commit.

71fa411fe8904b6f b10f74308e1305275e69ddde711
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :8           75%           6:6     perf-sanity-tests.Check_branc=
h_stack_sampling.fail
           :8           75%           6:6     perf-sanity-tests.Object_code=
_reading.fail
           :8           75%           6:6     perf-sanity-tests.Symbols.fai=
l
           :8           75%           6:6     perf-sanity-tests.dlfilter_C_=
API.fail
           :8           75%           6:6     perf-sanity-tests.perf_record=
_LBR_tests.fail
           :8           75%           6:6     perf-sanity-tests.probe_libc'=
s_inet_pton_&_backtrace_it_with_ping.fail
           :8           75%           6:6     perf-sanity-tests.test_perf_p=
robe_of_function_from_different_CU.fail



If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202503311428.2d19d587-lkp@intel.co=
m



2025-03-27 19:45:35 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-b10f74308e=
1305275e69ddde711ec817cc69e306/tools/perf/perf test 24 -v
 24: Object code reading                                             : Runn=
ing (1 active)
--- start ---
test child forked, pid 8774
Looking at the vmlinux_path (8 entries long)
Using /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux for symbols
Parsing event 'cycles'
Using CPUID GenuineIntel-6-6A-6
mmap size 528384B
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8bcc
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8bcc
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8bcc --st=
op-address=3D0xffffffff818c8c4c /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818ca030
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xaca030
Objdump command is: objdump -z -d --start-address=3D0xffffffff818ca030 --st=
op-address=3D0xffffffff818ca0b0 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8bd0
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8bd0
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8bd0 --st=
op-address=3D0xffffffff818c8c50 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81853e22
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xa53e22
Objdump command is: objdump -z -d --start-address=3D0xffffffff81853e22 --st=
op-address=3D0xffffffff81853ea2 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8c08
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8c08
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8c08 --st=
op-address=3D0xffffffff818c8c88 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8c0c
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8c0c
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8c0c --st=
op-address=3D0xffffffff818c8c8c /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812dead5
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x4dead5
Objdump command is: objdump -z -d --start-address=3D0xffffffff812dead5 --st=
op-address=3D0xffffffff812deb55 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8dba
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8dba
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8dba --st=
op-address=3D0xffffffff818c8e3a /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81446224
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x646224
Objdump command is: objdump -z -d --start-address=3D0xffffffff81446224 --st=
op-address=3D0xffffffff814462a4 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81eff03b
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x10ff03b
Objdump command is: objdump -z -d --start-address=3D0xffffffff81eff03b --st=
op-address=3D0xffffffff81eff0bb /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8baa
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8baa
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8baa --st=
op-address=3D0xffffffff818c8c2a /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8b80
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8b80
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8b80 --st=
op-address=3D0xffffffff818c8c00 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c91f0
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac91f0
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c91f0 --st=
op-address=3D0xffffffff818c9270 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81447fa2
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x647fa2
Objdump command is: objdump -z -d --start-address=3D0xffffffff81447fa2 --st=
op-address=3D0xffffffff81448022 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812de79f
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x4de79f
Objdump command is: objdump -z -d --start-address=3D0xffffffff812de79f --st=
op-address=3D0xffffffff812de81f /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff814459e2
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x6459e2
Objdump command is: objdump -z -d --start-address=3D0xffffffff814459e2 --st=
op-address=3D0xffffffff81445a62 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812dde77
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x4dde77
Objdump command is: objdump -z -d --start-address=3D0xffffffff812dde77 --st=
op-address=3D0xffffffff812ddef7 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81445edc
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x645edc
Objdump command is: objdump -z -d --start-address=3D0xffffffff81445edc --st=
op-address=3D0xffffffff81445f5c /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81445a17
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x645a17
Objdump command is: objdump -z -d --start-address=3D0xffffffff81445a17 --st=
op-address=3D0xffffffff81445a97 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8baa
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8baa
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8baa --st=
op-address=3D0xffffffff818c8c2a /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81446a42
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x646a42
Objdump command is: objdump -z -d --start-address=3D0xffffffff81446a42 --st=
op-address=3D0xffffffff81446ac2 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8bd0
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8bd0
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8bd0 --st=
op-address=3D0xffffffff818c8c50 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812de540
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x4de540
Objdump command is: objdump -z -d --start-address=3D0xffffffff812de540 --st=
op-address=3D0xffffffff812de5c0 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8d1a
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8d1a
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8d1a --st=
op-address=3D0xffffffff818c8d9a /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8d0a
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8d0a
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8d0a --st=
op-address=3D0xffffffff818c8d8a /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818ca054
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xaca054
Objdump command is: objdump -z -d --start-address=3D0xffffffff818ca054 --st=
op-address=3D0xffffffff818ca0d4 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c9185
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac9185
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c9185 --st=
op-address=3D0xffffffff818c9205 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812de6d4
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x4de6d4
Objdump command is: objdump -z -d --start-address=3D0xffffffff812de6d4 --st=
op-address=3D0xffffffff812de754 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8ce0
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8ce0
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8ce0 --st=
op-address=3D0xffffffff818c8d60 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff814464e2
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x6464e2
Objdump command is: objdump -z -d --start-address=3D0xffffffff814464e2 --st=
op-address=3D0xffffffff81446562 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81447838
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x647838
Objdump command is: objdump -z -d --start-address=3D0xffffffff81447838 --st=
op-address=3D0xffffffff814478b8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff814477bf
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x6477bf
Objdump command is: objdump -z -d --start-address=3D0xffffffff814477bf --st=
op-address=3D0xffffffff8144783f /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81970394
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xb70394
Objdump command is: objdump -z -d --start-address=3D0xffffffff81970394 --st=
op-address=3D0xffffffff81970414 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8dc4
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8dc4
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8dc4 --st=
op-address=3D0xffffffff818c8e44 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81969d58
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xb69d58
Objdump command is: objdump -z -d --start-address=3D0xffffffff81969d58 --st=
op-address=3D0xffffffff81969dd8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8bcc
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8bcc
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8bcc --st=
op-address=3D0xffffffff818c8c4c /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8b80
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8b80
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8b80 --st=
op-address=3D0xffffffff818c8c00 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff814d3793
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x6d3793
Objdump command is: objdump -z -d --start-address=3D0xffffffff814d3793 --st=
op-address=3D0xffffffff814d3813 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8bcc
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8bcc
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8bcc --st=
op-address=3D0xffffffff818c8c4c /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8bb4
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8bb4
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8bb4 --st=
op-address=3D0xffffffff818c8c34 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff82c56b30
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x1e56b30
Objdump command is: objdump -z -d --start-address=3D0xffffffff82c56b30 --st=
op-address=3D0xffffffff82c56bb0 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8baa
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8baa
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8baa --st=
op-address=3D0xffffffff818c8c2a /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8bcc
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8bcc
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8bcc --st=
op-address=3D0xffffffff818c8c4c /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c9071
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac9071
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c9071 --st=
op-address=3D0xffffffff818c90f1 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c898a
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac898a
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c898a --st=
op-address=3D0xffffffff818c8a0a /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff8144786b
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x64786b
Objdump command is: objdump -z -d --start-address=3D0xffffffff8144786b --st=
op-address=3D0xffffffff814478eb /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818ca030
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xaca030
Objdump command is: objdump -z -d --start-address=3D0xffffffff818ca030 --st=
op-address=3D0xffffffff818ca0b0 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c9188
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac9188
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c9188 --st=
op-address=3D0xffffffff818c9208 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8d2c
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8d2c
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8d2c --st=
op-address=3D0xffffffff818c8dac /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81446af0
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x646af0
Objdump command is: objdump -z -d --start-address=3D0xffffffff81446af0 --st=
op-address=3D0xffffffff81446b70 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8a40
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8a40
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8a40 --st=
op-address=3D0xffffffff818c8ac0 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c904d
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac904d
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c904d --st=
op-address=3D0xffffffff818c90cd /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8d2c
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8d2c
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8d2c --st=
op-address=3D0xffffffff818c8dac /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0x55c648ffd4b6
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-b10f74308e1305275e69dd=
de711ec817cc69e306/tools/perf/perf
On file address is: 0x131e4b6
Objdump command is: objdump -z -d --start-address=3D0x131e4b6 --stop-addres=
s=3D0x131e536 /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-b10f74308e1305275=
e69ddde711ec817cc69e306/tools/perf/perf
Bytes read match those read by objdump
Reading object code for memory address: 0x55c648ffd78f
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-b10f74308e1305275e69dd=
de711ec817cc69e306/tools/perf/perf
On file address is: 0x131e78f
Objdump command is: objdump -z -d --start-address=3D0x131e78f --stop-addres=
s=3D0x131e80f /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-b10f74308e1305275=
e69ddde711ec817cc69e306/tools/perf/perf
Bytes read match those read by objdump
Reading object code for memory address: 0x55c648ffd57f
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-b10f74308e1305275e69dd=
de711ec817cc69e306/tools/perf/perf
On file address is: 0x131e57f
Objdump command is: objdump -z -d --start-address=3D0x131e57f --stop-addres=
s=3D0x131e5ff /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-b10f74308e1305275=
e69ddde711ec817cc69e306/tools/perf/perf
Bytes read match those read by objdump
Reading object code for memory address: 0x7f72e6091c85
File is: /lib/x86_64-linux-gnu/libc.so.6
On file address is: 0x163c85
Objdump command is: objdump -z -d --start-address=3D0x163c85 --stop-address=
=3D0x163d05 /lib/x86_64-linux-gnu/libc.so.6
Bytes read match those read by objdump
Reading object code for memory address: 0x55c648ffd7a7
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-b10f74308e1305275e69dd=
de711ec817cc69e306/tools/perf/perf
On file address is: 0x131e7a7
Objdump command is: objdump -z -d --start-address=3D0x131e7a7 --stop-addres=
s=3D0x131e827 /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-b10f74308e1305275=
e69ddde711ec817cc69e306/tools/perf/perf
Bytes read match those read by objdump
Reading object code for memory address: 0x55c648ffd500
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-b10f74308e1305275e69dd=
de711ec817cc69e306/tools/perf/perf
On file address is: 0x131e500
Objdump command is: objdump -z -d --start-address=3D0x131e500 --stop-addres=
s=3D0x131e580 /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-b10f74308e1305275=
e69ddde711ec817cc69e306/tools/perf/perf
Bytes read match those read by objdump
Reading object code for memory address: 0x7f72e6091c85
File is: /lib/x86_64-linux-gnu/libc.so.6
On file address is: 0x163c85
Objdump command is: objdump -z -d --start-address=3D0x163c85 --stop-address=
=3D0x163d05 /lib/x86_64-linux-gnu/libc.so.6
Bytes read match those read by objdump
Reading object code for memory address: 0x55c648ffd7a9
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-b10f74308e1305275e69dd=
de711ec817cc69e306/tools/perf/perf
On file address is: 0x131e7a9
Objdump command is: objdump -z -d --start-address=3D0x131e7a9 --stop-addres=
s=3D0x131e829 /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-b10f74308e1305275=
e69ddde711ec817cc69e306/tools/perf/perf
Bytes read match those read by objdump
Reading object code for memory address: 0x7f72e5f6dbc6
File is: /lib/x86_64-linux-gnu/libc.so.6
On file address is: 0x3fbc6
Objdump command is: objdump -z -d --start-address=3D0x3fbc6 --stop-address=
=3D0x3fc46 /lib/x86_64-linux-gnu/libc.so.6
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8b80
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8b80
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8b80 --st=
op-address=3D0xffffffff818c8c00 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0x55c648ffd935
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-b10f74308e1305275e69dd=
de711ec817cc69e306/tools/perf/perf
On file address is: 0x131e935
Objdump command is: objdump -z -d --start-address=3D0x131e935 --stop-addres=
s=3D0x131e9b5 /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-b10f74308e1305275=
e69ddde711ec817cc69e306/tools/perf/perf
Bytes read match those read by objdump
Reading object code for memory address: 0x7f72e5f6d989
File is: /lib/x86_64-linux-gnu/libc.so.6
On file address is: 0x3f989
Objdump command is: objdump -z -d --start-address=3D0x3f989 --stop-address=
=3D0x3fa09 /lib/x86_64-linux-gnu/libc.so.6
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8bcc
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8bcc
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8bcc --st=
op-address=3D0xffffffff818c8c4c /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0x55c648ffd932
File is: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-b10f74308e1305275e69dd=
de711ec817cc69e306/tools/perf/perf
On file address is: 0x131e932
Objdump command is: objdump -z -d --start-address=3D0x131e932 --stop-addres=
s=3D0x131e9b2 /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-b10f74308e1305275=
e69ddde711ec817cc69e306/tools/perf/perf
Bytes read match those read by objdump
Reading object code for memory address: 0x7f72e5f6da0b
File is: /lib/x86_64-linux-gnu/libc.so.6
On file address is: 0x3fa0b
Objdump command is: objdump -z -d --start-address=3D0x3fa0b --stop-address=
=3D0x3fa8b /lib/x86_64-linux-gnu/libc.so.6
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c917c
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac917c
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c917c --st=
op-address=3D0xffffffff818c91fc /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff8164c8db
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x84c8db
Objdump command is: objdump -z -d --start-address=3D0xffffffff8164c8db --st=
op-address=3D0xffffffff8164c95b /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81445f9e
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x645f9e
Objdump command is: objdump -z -d --start-address=3D0xffffffff81445f9e --st=
op-address=3D0xffffffff8144601e /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8baa
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8baa
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8baa --st=
op-address=3D0xffffffff818c8c2a /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8c7c
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8c7c
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8c7c --st=
op-address=3D0xffffffff818c8cfc /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812dde87
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x4dde87
Objdump command is: objdump -z -d --start-address=3D0xffffffff812dde87 --st=
op-address=3D0xffffffff812ddf07 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8b80
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8b80
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8b80 --st=
op-address=3D0xffffffff818c8c00 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8ddc
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8ddc
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8ddc --st=
op-address=3D0xffffffff818c8e5c /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff814a66e0
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x6a66e0
Objdump command is: objdump -z -d --start-address=3D0xffffffff814a66e0 --st=
op-address=3D0xffffffff814a6760 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c9046
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac9046
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c9046 --st=
op-address=3D0xffffffff818c90c6 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81494910
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x694910
Objdump command is: objdump -z -d --start-address=3D0xffffffff81494910 --st=
op-address=3D0xffffffff81494990 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff82c4eb63
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x1e4eb63
Objdump command is: objdump -z -d --start-address=3D0xffffffff82c4eb63 --st=
op-address=3D0xffffffff82c4ebe3 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8bcc
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8bcc
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8bcc --st=
op-address=3D0xffffffff818c8c4c /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818ca030
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xaca030
Objdump command is: objdump -z -d --start-address=3D0xffffffff818ca030 --st=
op-address=3D0xffffffff818ca0b0 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff82c4ec14
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x1e4ec14
Objdump command is: objdump -z -d --start-address=3D0xffffffff82c4ec14 --st=
op-address=3D0xffffffff82c4ec94 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8baa
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8baa
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8baa --st=
op-address=3D0xffffffff818c8c2a /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81446a17
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x646a17
Objdump command is: objdump -z -d --start-address=3D0xffffffff81446a17 --st=
op-address=3D0xffffffff81446a97 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8ce0
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8ce0
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8ce0 --st=
op-address=3D0xffffffff818c8d60 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8cea
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8cea
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8cea --st=
op-address=3D0xffffffff818c8d6a /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81a37389
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xc37389
Objdump command is: objdump -z -d --start-address=3D0xffffffff81a37389 --st=
op-address=3D0xffffffff81a37409 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff813b85a0
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x5b85a0
Objdump command is: objdump -z -d --start-address=3D0xffffffff813b85a0 --st=
op-address=3D0xffffffff813b8620 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8d90
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8d90
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8d90 --st=
op-address=3D0xffffffff818c8e10 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81991c7c
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xb91c7c
Objdump command is: objdump -z -d --start-address=3D0xffffffff81991c7c --st=
op-address=3D0xffffffff81991cfc /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8c30
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8c30
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8c30 --st=
op-address=3D0xffffffff818c8cb0 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff8178d1a7
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x98d1a7
Objdump command is: objdump -z -d --start-address=3D0xffffffff8178d1a7 --st=
op-address=3D0xffffffff8178d227 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c9091
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac9091
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c9091 --st=
op-address=3D0xffffffff818c9111 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff82c50395
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x1e50395
Objdump command is: objdump -z -d --start-address=3D0xffffffff82c50395 --st=
op-address=3D0xffffffff82c50415 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81446622
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x646622
Objdump command is: objdump -z -d --start-address=3D0xffffffff81446622 --st=
op-address=3D0xffffffff814466a2 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8ce0
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8ce0
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8ce0 --st=
op-address=3D0xffffffff818c8d60 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81224558
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x424558
Objdump command is: objdump -z -d --start-address=3D0xffffffff81224558 --st=
op-address=3D0xffffffff812245d8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812de650
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x4de650
Objdump command is: objdump -z -d --start-address=3D0xffffffff812de650 --st=
op-address=3D0xffffffff812de6d0 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818ca034
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xaca034
Objdump command is: objdump -z -d --start-address=3D0xffffffff818ca034 --st=
op-address=3D0xffffffff818ca0b4 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8d2c
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8d2c
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8d2c --st=
op-address=3D0xffffffff818c8dac /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8bd0
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8bd0
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8bd0 --st=
op-address=3D0xffffffff818c8c50 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8cbb
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8cbb
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8cbb --st=
op-address=3D0xffffffff818c8d3b /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff814477bd
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x6477bd
Objdump command is: objdump -z -d --start-address=3D0xffffffff814477bd --st=
op-address=3D0xffffffff8144783d /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81446068
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x646068
Objdump command is: objdump -z -d --start-address=3D0xffffffff81446068 --st=
op-address=3D0xffffffff814460e8 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8ddc
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8ddc
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8ddc --st=
op-address=3D0xffffffff818c8e5c /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff814477ed
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x6477ed
Objdump command is: objdump -z -d --start-address=3D0xffffffff814477ed --st=
op-address=3D0xffffffff8144786d /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff8144626a
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x64626a
Objdump command is: objdump -z -d --start-address=3D0xffffffff8144626a --st=
op-address=3D0xffffffff814462ea /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c9188
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac9188
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c9188 --st=
op-address=3D0xffffffff818c9208 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8bcc
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8bcc
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8bcc --st=
op-address=3D0xffffffff818c8c4c /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81446581
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x646581
Objdump command is: objdump -z -d --start-address=3D0xffffffff81446581 --st=
op-address=3D0xffffffff81446601 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c9188
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac9188
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c9188 --st=
op-address=3D0xffffffff818c9208 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff82c64666
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x1e64666
Objdump command is: objdump -z -d --start-address=3D0xffffffff82c64666 --st=
op-address=3D0xffffffff82c646e6 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff814a1699
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x6a1699
Objdump command is: objdump -z -d --start-address=3D0xffffffff814a1699 --st=
op-address=3D0xffffffff814a1719 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff8144755a
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x64755a
Objdump command is: objdump -z -d --start-address=3D0xffffffff8144755a --st=
op-address=3D0xffffffff814475da /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81446b08
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x646b08
Objdump command is: objdump -z -d --start-address=3D0xffffffff81446b08 --st=
op-address=3D0xffffffff81446b88 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8ba5
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8ba5
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8ba5 --st=
op-address=3D0xffffffff818c8c25 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8b80
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8b80
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8b80 --st=
op-address=3D0xffffffff818c8c00 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8baa
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8baa
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8baa --st=
op-address=3D0xffffffff818c8c2a /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8d30
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8d30
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8d30 --st=
op-address=3D0xffffffff818c8db0 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff82c50395
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x1e50395
Objdump command is: objdump -z -d --start-address=3D0xffffffff82c50395 --st=
op-address=3D0xffffffff82c50415 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8ddc
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8ddc
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8ddc --st=
op-address=3D0xffffffff818c8e5c /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812de6ea
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x4de6ea
Objdump command is: objdump -z -d --start-address=3D0xffffffff812de6ea --st=
op-address=3D0xffffffff812de76a /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81cde16e
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xede16e
Objdump command is: objdump -z -d --start-address=3D0xffffffff81cde16e --st=
op-address=3D0xffffffff81cde1ee /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff812deb41
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x4deb41
Objdump command is: objdump -z -d --start-address=3D0xffffffff812deb41 --st=
op-address=3D0xffffffff812debc1 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818758d3
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xa758d3
Objdump command is: objdump -z -d --start-address=3D0xffffffff818758d3 --st=
op-address=3D0xffffffff81875953 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c65b0
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac65b0
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c65b0 --st=
op-address=3D0xffffffff818c6630 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff818c8960
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xac8960
Objdump command is: objdump -z -d --start-address=3D0xffffffff818c8960 --st=
op-address=3D0xffffffff818c89e0 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff819f776b
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0xbf776b
Objdump command is: objdump -z -d --start-address=3D0xffffffff819f776b --st=
op-address=3D0xffffffff819f77eb /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff81440f87
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x640f87
Objdump command is: objdump -z -d --start-address=3D0xffffffff81440f87 --st=
op-address=3D0xffffffff81441007 /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff8157e48b
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x77e48b
Objdump command is: objdump -z -d --start-address=3D0xffffffff8157e48b --st=
op-address=3D0xffffffff8157e50b /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
Reading object code for memory address: 0xffffffff814469ad
File is: /lib/modules/6.14.0-rc1-00148-gb10f74308e13/build/vmlinux
On file address is: 0x6469ad
Objdump command is: objdump -z -d --start-address=3D0xffffffff814469ad --st=
op-address=3D0xffffffff81446a2d /lib/modules/6.14.0-rc1-00148-gb10f74308e13=
/build/vmlinux
Bytes read match those read by objdump
/proc/{kallsyms,modules} inconsistency while looking for "[bpf]" module!
/proc/{kallsyms,modules} inconsistency while looking for "[bpf]" module!
/proc/{kallsyms,modules} inconsistency while looking for "[bpf]" module!
/proc/{kallsyms,modules} inconsistency while looking for "[bpf]" module!
/proc/{kallsyms,modules} inconsistency while looking for "[bpf]" module!
/proc/{kallsyms,modules} inconsistency while looking for "[bpf]" module!
/proc/{kallsyms,modules} inconsistency while looking for "[bpf]" module!
/proc/{kallsyms,modules} inconsistency while looking for "[bpf]" module!
/proc/{kallsyms,modules} inconsistency while looking for "[bpf]" module!
/proc/{kallsyms,modules} inconsistency while looking for "[bpf]" module!
Using /proc/kallsyms for symbols
no kcore
---- end(0) ----

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D8774=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 23200 byte(s) in 2 object(s) allocated from:
    #0 0x7f72e6f6a3b7 in __interceptor_calloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:77
    #1 0x7f72e6d9c743  (/lib/x86_64-linux-gnu/libelf.so.1+0x3743)

Indirect leak of 6976 byte(s) in 2 object(s) allocated from:
    #0 0x7f72e6f6a9cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7f72e6da39f0  (/lib/x86_64-linux-gnu/libelf.so.1+0xa9f0)

Indirect leak of 1526 byte(s) in 2 object(s) allocated from:
    #0 0x7f72e6f6a9cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7f72e6da4812  (/lib/x86_64-linux-gnu/libelf.so.1+0xb812)

SUMMARY: AddressSanitizer: 31702 byte(s) leaked in 6 allocation(s).
 24: Object code reading                                             : FAIL=
ED!

...

2025-03-27 19:47:11 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-b10f74308e=
1305275e69ddde711ec817cc69e306/tools/perf/perf test 64 -v
 64: dlfilter C API                                                  : Runn=
ing (1 active)
--- start ---
test child forked, pid 9861

-- Testing version 0 API --
Checking for gcc
Command: gcc --version
gcc (Debian 12.2.0-14) 12.2.0
Copyright (C) 2022 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

dlfilters path: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-b10f74308e13052=
75e69ddde711ec817cc69e306/tools/perf/dlfilters
Command: gcc -g -o /tmp/dlfilter-test-9861-prog /tmp/dlfilter-test-9861-pro=
g.c
Creating new host machine structure
Command: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-b10f74308e1305275e69dd=
de711ec817cc69e306/tools/perf/perf script -i /tmp/dlfilter-test-9861-perf-d=
ata --dlfilter /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-b10f74308e130527=
5e69ddde711ec817cc69e306/tools/perf/dlfilters/dlfilter-test-api-v0.so --dla=
rg first --dlarg 1 --dlarg 4198704 --dlarg 4198697 --dlarg 0 --dlarg last
start API
filter_event_early API
filter_event API
stop API

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D9871=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 7752 byte(s) in 1 object(s) allocated from:
    #0 0x7f4282a623b7 in __interceptor_calloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:77
    #1 0x7f4282894743  (/lib/x86_64-linux-gnu/libelf.so.1+0x3743)

Indirect leak of 2304 byte(s) in 1 object(s) allocated from:
    #0 0x7f4282a629cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7f428289b9f0  (/lib/x86_64-linux-gnu/libelf.so.1+0xa9f0)

Indirect leak of 352 byte(s) in 1 object(s) allocated from:
    #0 0x7f4282a629cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7f428289c812  (/lib/x86_64-linux-gnu/libelf.so.1+0xb812)

SUMMARY: AddressSanitizer: 10408 byte(s) leaked in 3 allocation(s).
Failed with return value 256
---- end(-1) ----

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D9861=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 7752 byte(s) in 1 object(s) allocated from:
    #0 0x7f54339703b7 in __interceptor_calloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:77
    #1 0x7f54337a2743  (/lib/x86_64-linux-gnu/libelf.so.1+0x3743)

Indirect leak of 2304 byte(s) in 1 object(s) allocated from:
    #0 0x7f54339709cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7f54337a99f0  (/lib/x86_64-linux-gnu/libelf.so.1+0xa9f0)

Indirect leak of 352 byte(s) in 1 object(s) allocated from:
    #0 0x7f54339709cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7f54337aa812  (/lib/x86_64-linux-gnu/libelf.so.1+0xb812)

SUMMARY: AddressSanitizer: 10408 byte(s) leaked in 3 allocation(s).
 64: dlfilter C API                                                  : FAIL=
ED!

...

2025-03-27 20:10:13 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-b10f74308e=
1305275e69ddde711ec817cc69e306/tools/perf/perf test 101 -v
101: Check branch stack sampling                                     : Runn=
ing (1 active)
--- start ---
test child forked, pid 34847
 13700f5-13701a0 l brstack_bench
perf does have symbol 'brstack_bench'
Testing user branch stack sampling

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D34891=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 69824 byte(s) in 10 object(s) allocated from:
    #0 0x7f250a23a3b7 in __interceptor_calloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:77
    #1 0x7f250a06c743  (/lib/x86_64-linux-gnu/libelf.so.1+0x3743)

Indirect leak of 20672 byte(s) in 10 object(s) allocated from:
    #0 0x7f250a23a9cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7f250a0739f0  (/lib/x86_64-linux-gnu/libelf.so.1+0xa9f0)

Indirect leak of 3469 byte(s) in 10 object(s) allocated from:
    #0 0x7f250a23a9cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7f250a074812  (/lib/x86_64-linux-gnu/libelf.so.1+0xb812)

SUMMARY: AddressSanitizer: 93965 byte(s) leaked in 30 allocation(s).
+ grep -E -m1 '^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL/.*$' /tmp/=
__perf_test.program.i8YVn/perf.script
brstack_bench+0x8b/brstack_foo+0x0/P/-/-/1/IND_CALL/-
+ grep -E -m1 '^brstack_foo\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$' /tmp/__perf=
_test.program.i8YVn/perf.script
brstack_foo+0x17/brstack_bar+0x0/P/-/-/3/CALL/-
+ grep -E -m1 '^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/CALL/.*$' /tmp/__pe=
rf_test.program.i8YVn/perf.script
brstack_bench+0x7d/brstack_foo+0x0/P/-/-/5/CALL/-
+ grep -E -m1 '^brstack_bench\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$' /tmp/__pe=
rf_test.program.i8YVn/perf.script
brstack_bench+0x82/brstack_bar+0x0/P/-/-/1/CALL/-
+ grep -E -m1 '^brstack_bar\+[^ ]*/brstack_foo\+[^ ]*/RET/.*$' /tmp/__perf_=
test.program.i8YVn/perf.script
brstack_bar+0x2d/brstack_foo+0x1c/P/-/-/1/RET/-
+ grep -E -m1 '^brstack_foo\+[^ ]*/brstack_bench\+[^ ]*/RET/.*$' /tmp/__per=
f_test.program.i8YVn/perf.script
brstack_foo+0x32/brstack_bench+0x82/P/-/-/1/RET/-
+ grep -E -m1 '^brstack_bench\+[^ ]*/brstack_bench\+[^ ]*/COND/.*$' /tmp/__=
perf_test.program.i8YVn/perf.script
brstack_bench+0x32/brstack_bench+0x4e/P/-/-/4/COND/-
+ grep -E -m1 '^brstack\+[^ ]*/brstack\+[^ ]*/UNCOND/.*$' /tmp/__perf_test.=
program.i8YVn/perf.script
brstack+0xd9/brstack+0x9d/P/-/-/1/UNCOND/-
+ set +x
Testing branch stack filtering permutation (any_call,CALL|IND_CALL|COND_CAL=
L|SYSCALL|IRQ)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D34922=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 32256 byte(s) in 4 object(s) allocated from:
    #0 0x7f7da05783b7 in __interceptor_calloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:77
    #1 0x7f7da03aa743  (/lib/x86_64-linux-gnu/libelf.so.1+0x3743)

Indirect leak of 9600 byte(s) in 4 object(s) allocated from:
    #0 0x7f7da05789cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7f7da03b19f0  (/lib/x86_64-linux-gnu/libelf.so.1+0xa9f0)

Indirect leak of 1885 byte(s) in 4 object(s) allocated from:
    #0 0x7f7da05789cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7f7da03b2812  (/lib/x86_64-linux-gnu/libelf.so.1+0xb812)

SUMMARY: AddressSanitizer: 43741 byte(s) leaked in 12 allocation(s).
Testing branch stack filtering permutation (call,CALL|SYSCALL)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D34950=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 32256 byte(s) in 4 object(s) allocated from:
    #0 0x7f78b07f23b7 in __interceptor_calloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:77
    #1 0x7f78b0624743  (/lib/x86_64-linux-gnu/libelf.so.1+0x3743)

Indirect leak of 9600 byte(s) in 4 object(s) allocated from:
    #0 0x7f78b07f29cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7f78b062b9f0  (/lib/x86_64-linux-gnu/libelf.so.1+0xa9f0)

Indirect leak of 1885 byte(s) in 4 object(s) allocated from:
    #0 0x7f78b07f29cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7f78b062c812  (/lib/x86_64-linux-gnu/libelf.so.1+0xb812)

SUMMARY: AddressSanitizer: 43741 byte(s) leaked in 12 allocation(s).
0x7f9daca93582/0x7f9dac9f
---- end(-1) ----
101: Check branch stack sampling                                     : FAIL=
ED!

...

2025-03-27 20:10:36 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-b10f74308e=
1305275e69ddde711ec817cc69e306/tools/perf/perf test 104 -v
104: test perf probe of function from different CU                   : Runn=
ing (1 active)
--- start ---
test child forked, pid 35011

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D35041=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 7960 byte(s) in 1 object(s) allocated from:
    #0 0x7f0056d2c3b7 in __interceptor_calloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:77
    #1 0x7f0056b5e743  (/lib/x86_64-linux-gnu/libelf.so.1+0x3743)

Indirect leak of 2368 byte(s) in 1 object(s) allocated from:
    #0 0x7f0056d2c9cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7f0056b659f0  (/lib/x86_64-linux-gnu/libelf.so.1+0xa9f0)

Indirect leak of 368 byte(s) in 1 object(s) allocated from:
    #0 0x7f0056d2c9cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7f0056b66812  (/lib/x86_64-linux-gnu/libelf.so.1+0xb812)

SUMMARY: AddressSanitizer: 10696 byte(s) leaked in 3 allocation(s).
--- Cleaning up ---
"foo" does not hit any event.
  Error: Failed to delete events.
---- end(-1) ----
104: test perf probe of function from different CU                   : FAIL=
ED!

...

2025-03-27 20:18:22 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-b10f74308e=
1305275e69ddde711ec817cc69e306/tools/perf/perf test 119 -v
119: probe libc's inet_pton & backtrace it with ping                 : Runn=
ing (1 active)
--- start ---
test child forked, pid 37299

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D37353=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 19872 byte(s) in 2 object(s) allocated from:
    #0 0x7f4df3bdb3b7 in __interceptor_calloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:77
    #1 0x7f4df3a0d743  (/lib/x86_64-linux-gnu/libelf.so.1+0x3743)

Indirect leak of 5952 byte(s) in 2 object(s) allocated from:
    #0 0x7f4df3bdb9cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7f4df3a149f0  (/lib/x86_64-linux-gnu/libelf.so.1+0xa9f0)

Indirect leak of 1337 byte(s) in 2 object(s) allocated from:
    #0 0x7f4df3bdb9cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7f4df3a15812  (/lib/x86_64-linux-gnu/libelf.so.1+0xb812)

SUMMARY: AddressSanitizer: 27161 byte(s) leaked in 6 allocation(s).
Pattern: ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)
FAIL: Didn't find the expected backtrace entry "ping[][0-9 \.:]+probe_libc:=
inet_pton: \([[:xdigit:]]+\)"
---- end(-1) ----
119: probe libc's inet_pton & backtrace it with ping                 : FAIL=
ED!

...

2025-03-27 20:19:19 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-b10f74308e=
1305275e69ddde711ec817cc69e306/tools/perf/perf test 122 -v
122: perf record LBR tests                                           : Runn=
ing (1 active)
--- start ---
test child forked, pid 37725
LBR callgraph
[ perf record: Woken up 10 times to write data ]
[ perf record: Captured and wrote 2.513 MB /tmp/__perf_test.perf.data.Xip1v=
 (8997 samples) ]
util/maps.c:1086:5: runtime error: null pointer passed as argument 2, which=
 is declared to never be null
Warning:
Kernel address maps (/proc/{kallsyms,modules}) were restricted.

Check /proc/sys/kernel/kptr_restrict before running 'perf record'.

If some relocation was applied (e.g. kexec) symbols may be misresolved.

Samples in kernel modules can't be resolved as well.


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D37750=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 68368 byte(s) in 10 object(s) allocated from:
    #0 0x7f2ddbecb3b7 in __interceptor_calloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:77
    #1 0x7f2ddbcfd743  (/lib/x86_64-linux-gnu/libelf.so.1+0x3743)

Indirect leak of 20224 byte(s) in 10 object(s) allocated from:
    #0 0x7f2ddbecb9cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7f2ddbd049f0  (/lib/x86_64-linux-gnu/libelf.so.1+0xa9f0)

Indirect leak of 3409 byte(s) in 10 object(s) allocated from:
    #0 0x7f2ddbecb9cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7f2ddbd05812  (/lib/x86_64-linux-gnu/libelf.so.1+0xb812)

SUMMARY: AddressSanitizer: 92001 byte(s) leaked in 30 allocation(s).
# To display the perf.data header info, please use --header/--header-only o=
ptions.
#
#
# Total Lost Samples: 0
#
# Samples: 8K of event 'cycles'
# Event count (approx.): 7878596033
#
# Children      Self  Command  Shared Object               Symbol          =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
                                                                           =
                               =20
# ........  ........  .......  ..........................  ................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
..................................
#
    89.06%    88.08%  perf     perf                        [.] test_loop
            |         =20
            |--44.31%--_start
            |          __libc_start_main
            |          0x7f22a499c248
            |          main
            |          run_argv
            |          handle_internal_command
            |          run_builtin
            |          cmd_test
            |          run_workload
            |          thloop
            |          test_loop
            |         =20
            |--43.78%--0x7f22a4a7e7da
            |          0x7f22a49fe13e
            |          thfunc
            |          test_loop
            |         =20
             --0.98%--test_loop
                       |         =20
                        --0.95%--0xffffffff81000e06
                                  |         =20
                                   --0.88%--0xffffffff82c4e045
                                             0xffffffff812bff0a
                                             |         =20
                                              --0.75%--0xffffffff814e0b03
                                                        |         =20
                                                         --0.66%--0xfffffff=
f814df5aa
                                                                   |       =
  =20
                                                                    --0.64%=
--0xffffffff8150115d
                                                                           =
   |         =20
                                                                           =
    --0.54%--0xffffffff814ddf20

    45.87%     0.00%  perf     perf                        [.] _start
            |
            ---_start
               __libc_start_main
               |         =20
                --44.78%--0x7f22a499c248
                          main
                          |         =20
                           --44.46%--run_argv
                                     |         =20
                                      --44.45%--handle_internal_command
                                                run_builtin
                                                cmd_test
                                                run_workload
                                                thloop
                                                |         =20
                                                 --44.32%--test_loop

    45.87%     0.00%  perf     libc.so.6                   [.] __libc_start=
_main
            |
            ---__libc_start_main
               |         =20
                --44.78%--0x7f22a499c248
                          main
                          |         =20
                           --44.46%--run_argv
                                     |         =20
                                      --44.45%--handle_internal_command
                                                run_builtin
                                                cmd_test
                                                run_workload
                                                thloop
                                                |         =20
                                                 --44.32%--test_loop

    44.78%     0.00%  perf     libc.so.6                   [.] 0x00007f22a4=
99c248
            |
            ---0x7f22a499c248
               main
               |         =20
                --44.46%--run_argv
                          |         =20
                           --44.45%--handle_internal_command
                                     run_builtin
                                     cmd_test
                                     run_workload
                                     thloop
                                     |         =20
                                      --44.32%--test_loop

    44.78%     0.00%  perf     perf                        [.] main
            |
            ---main
               |         =20
                --44.46%--run_argv
                          |         =20
                           --44.45%--handle_internal_command
                                     run_builtin
                                     cmd_test
                                     run_workload
                                     thloop
                                     |         =20
                                      --44.32%--test_loop

    44.75%     0.00%  perf     libc.so.6                   [.] 0x00007f22a4=
a7e7da
            |
            ---0x7f22a4a7e7da
               |         =20
                --44.74%--0x7f22a49fe13e
                          thfunc
                          test_loop
                          |         =20
                           --0.95%--0xffffffff81000e06
                                     |         =20
                                      --0.88%--0xffffffff82c4e045
                                                0xffffffff812bff0a
                                                |         =20
                                                 --0.75%--0xffffffff814e0b0=
3
                                                           |         =20
                                                            --0.66%--0xffff=
ffff814df5aa
                                                                      |    =
     =20
                                                                       --0.=
64%--0xffffffff8150115d
                                                                           =
      |         =20
                                                                           =
       --0.54%--0xffffffff814ddf20

    44.75%     0.00%  perf     perf                        [.] handle_inter=
nal_command
            |
            ---handle_internal_command
               |         =20
                --44.45%--run_builtin
                          cmd_test
                          run_workload
                          thloop
                          |         =20
                           --44.32%--test_loop

    44.74%     0.00%  perf     libc.so.6                   [.] 0x00007f22a4=
9fe13e
            |
            ---0x7f22a49fe13e
               thfunc
               test_loop
               |         =20
                --0.95%--0xffffffff81000e06
                          |         =20
                           --0.88%--0xffffffff82c4e045
                                     0xffffffff812bff0a
                                     |         =20
                                      --0.75%--0xffffffff814e0b03
                                                |         =20
                                                 --0.66%--0xffffffff814df5a=
a
                                                           |         =20
                                                            --0.64%--0xffff=
ffff8150115d
                                                                      |    =
     =20
                                                                       --0.=
54%--0xffffffff814ddf20

    44.74%     0.00%  perf     perf                        [.] thfunc
            |
            ---thfunc
               test_loop
               |         =20
                --0.95%--0xffffffff81000e06
                          |         =20
                           --0.88%--0xffffffff82c4e045
                                     0xffffffff812bff0a
                                     |         =20
                                      --0.75%--0xffffffff814e0b03
                                                |         =20
                                                 --0.66%--0xffffffff814df5a=
a
                                                           |         =20
                                                            --0.64%--0xffff=
ffff8150115d
                                                                      |    =
     =20
                                                                       --0.=
54%--0xffffffff814ddf20

    44.46%     0.00%  perf     perf                        [.] run_argv
            |
            ---run_argv
               |         =20
                --44.45%--handle_internal_command
                          run_builtin
                          cmd_test
                          run_workload
                          thloop
                          |         =20
                           --44.32%--test_loop

    44.46%     0.00%  perf     perf                        [.] run_builtin
            |
            ---run_builtin
               |         =20
                --44.45%--cmd_test
                          run_workload
                          thloop
                          |         =20
                           --44.32%--test_loop

    44.45%     0.00%  perf     perf                        [.] cmd_test
            |
            ---cmd_test
               run_workload
               thloop
               |         =20
                --44.32%--test_loop

    44.45%     0.00%  perf     perf                        [.] run_workload
            |
            ---run_workload
               thloop
               |         =20
                --44.32%--test_loop

    44.45%     0.00%  perf     perf                        [.] thloop
            |
            ---thloop
               |         =20
                --44.32%--test_loop

     6.16%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
000bb2
            |
            ---0xffffffff81000bb2
               |         =20
                --6.04%--0xffffffff82c4e567
                          |         =20
                          |--4.88%--0xffffffff812e97e5
                          |          |         =20
                          |           --4.50%--0xffffffff81810c1a
                          |                     |         =20
                          |                      --4.43%--0xffffffff818104d=
4
                          |                                |         =20
                          |                                 --3.88%--0xffff=
ffff8180fe5d
                          |                                           |    =
     =20
                          |                                           |--0.=
77%--0xffffffff8180fa20
                          |                                           |    =
      |         =20
                          |                                           |    =
       --0.71%--0xffffffff81808c95
                          |                                           |    =
                 |         =20
                          |                                           |    =
                  --0.51%--0xffffffff8176ab49
                          |                                           |    =
     =20
                          |                                           |--0.=
61%--0xffffffff8180f8f9
                          |                                           |    =
     =20
                          |                                           |--0.=
56%--0xffffffff8180f9d9
                          |                                           |    =
     =20
                          |                                            --0.=
55%--0xffffffff8180ef76
                          |         =20
                           --0.78%--0xffffffff812e97ae

     6.04%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4e567
            |
            ---0xffffffff82c4e567
               |         =20
               |--4.88%--0xffffffff812e97e5
               |          |         =20
               |           --4.50%--0xffffffff81810c1a
               |                     |         =20
               |                      --4.43%--0xffffffff818104d4
               |                                |         =20
               |                                 --3.88%--0xffffffff8180fe5=
d
               |                                           |         =20
               |                                           |--0.77%--0xffff=
ffff8180fa20
               |                                           |          |    =
     =20
               |                                           |           --0.=
71%--0xffffffff81808c95
               |                                           |               =
      |         =20
               |                                           |               =
       --0.51%--0xffffffff8176ab49
               |                                           |         =20
               |                                           |--0.61%--0xffff=
ffff8180f8f9
               |                                           |         =20
               |                                           |--0.56%--0xffff=
ffff8180f9d9
               |                                           |         =20
               |                                            --0.55%--0xffff=
ffff8180ef76
               |         =20
                --0.78%--0xffffffff812e97ae

     5.03%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fc4a53
            |
            ---0x7f22a5fc4a53
               0x7f22a5fc5ba7
               0x7f22a5fc422d
               |         =20
               |--4.09%--0x7f22a5fc7c94
               |          |         =20
               |           --3.74%--0x7f22a5fb7bd0
               |                     |         =20
               |                      --3.49%--0xffffffff81000bb2
               |                                |         =20
               |                                 --3.41%--0xffffffff82c4e56=
7
               |                                           |         =20
               |                                            --2.87%--0xffff=
ffff812e97e5
               |                                                      |    =
     =20
               |                                                       --2.=
69%--0xffffffff81810c1a
               |                                                           =
      |         =20
               |                                                           =
       --2.68%--0xffffffff818104d4
               |                                                           =
                 |         =20
               |                                                           =
                  --2.43%--0xffffffff8180fe5d
               |                                                           =
                            |         =20
               |                                                           =
                            |--0.61%--0xffffffff8180f8f9
               |                                                           =
                            |         =20
               |                                                           =
                             --0.56%--0xffffffff8180f9d9
               |         =20
                --0.90%--0x7f22a5fc7975
                          |         =20
                           --0.89%--0x7f22a5fac5c5
                                     _dl_catch_exception
                                     0x7f22a5fac25c
                                     |         =20
                                      --0.80%--0x7f22a5fb2070

     5.03%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fc5ba7
            |
            ---0x7f22a5fc5ba7
               0x7f22a5fc422d
               |         =20
               |--4.09%--0x7f22a5fc7c94
               |          |         =20
               |           --3.74%--0x7f22a5fb7bd0
               |                     |         =20
               |                      --3.49%--0xffffffff81000bb2
               |                                |         =20
               |                                 --3.41%--0xffffffff82c4e56=
7
               |                                           |         =20
               |                                            --2.87%--0xffff=
ffff812e97e5
               |                                                      |    =
     =20
               |                                                       --2.=
69%--0xffffffff81810c1a
               |                                                           =
      |         =20
               |                                                           =
       --2.68%--0xffffffff818104d4
               |                                                           =
                 |         =20
               |                                                           =
                  --2.43%--0xffffffff8180fe5d
               |                                                           =
                            |         =20
               |                                                           =
                            |--0.61%--0xffffffff8180f8f9
               |                                                           =
                            |         =20
               |                                                           =
                             --0.56%--0xffffffff8180f9d9
               |         =20
                --0.90%--0x7f22a5fc7975
                          |         =20
                           --0.89%--0x7f22a5fac5c5
                                     _dl_catch_exception
                                     0x7f22a5fac25c
                                     |         =20
                                      --0.80%--0x7f22a5fb2070

     5.03%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fc422d
            |
            ---0x7f22a5fc422d
               |         =20
               |--4.09%--0x7f22a5fc7c94
               |          |         =20
               |           --3.74%--0x7f22a5fb7bd0
               |                     |         =20
               |                      --3.49%--0xffffffff81000bb2
               |                                |         =20
               |                                 --3.41%--0xffffffff82c4e56=
7
               |                                           |         =20
               |                                            --2.87%--0xffff=
ffff812e97e5
               |                                                      |    =
     =20
               |                                                       --2.=
69%--0xffffffff81810c1a
               |                                                           =
      |         =20
               |                                                           =
       --2.68%--0xffffffff818104d4
               |                                                           =
                 |         =20
               |                                                           =
                  --2.43%--0xffffffff8180fe5d
               |                                                           =
                            |         =20
               |                                                           =
                            |--0.61%--0xffffffff8180f8f9
               |                                                           =
                            |         =20
               |                                                           =
                             --0.56%--0xffffffff8180f9d9
               |         =20
                --0.90%--0x7f22a5fc7975
                          |         =20
                           --0.89%--0x7f22a5fac5c5
                                     _dl_catch_exception
                                     0x7f22a5fac25c
                                     |         =20
                                      --0.80%--0x7f22a5fb2070

     4.88%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e97e5
            |
            ---0xffffffff812e97e5
               |         =20
                --4.50%--0xffffffff81810c1a
                          |         =20
                           --4.43%--0xffffffff818104d4
                                     |         =20
                                      --3.88%--0xffffffff8180fe5d
                                                |         =20
                                                |--0.77%--0xffffffff8180fa2=
0
                                                |          |         =20
                                                |           --0.71%--0xffff=
ffff81808c95
                                                |                     |    =
     =20
                                                |                      --0.=
51%--0xffffffff8176ab49
                                                |         =20
                                                |--0.61%--0xffffffff8180f8f=
9
                                                |         =20
                                                |--0.56%--0xffffffff8180f9d=
9
                                                |         =20
                                                 --0.55%--0xffffffff8180ef7=
6

     4.53%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
810c1a
            |
            ---0xffffffff81810c1a
               |         =20
                --4.45%--0xffffffff818104d4
                          |         =20
                           --3.90%--0xffffffff8180fe5d
                                     |         =20
                                     |--0.77%--0xffffffff8180fa20
                                     |          |         =20
                                     |           --0.71%--0xffffffff81808c9=
5
                                     |                     |         =20
                                     |                      --0.51%--0xffff=
ffff8176ab49
                                     |         =20
                                     |--0.61%--0xffffffff8180f8f9
                                     |         =20
                                     |--0.56%--0xffffffff8180f9d9
                                     |         =20
                                      --0.56%--0xffffffff8180ef76

     4.45%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8104d4
            |
            ---0xffffffff818104d4
               |         =20
                --3.90%--0xffffffff8180fe5d
                          |         =20
                          |--0.77%--0xffffffff8180fa20
                          |          |         =20
                          |           --0.71%--0xffffffff81808c95
                          |                     |         =20
                          |                      --0.51%--0xffffffff8176ab4=
9
                          |         =20
                          |--0.61%--0xffffffff8180f8f9
                          |         =20
                          |--0.56%--0xffffffff8180f9d9
                          |         =20
                           --0.56%--0xffffffff8180ef76

     4.09%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fc7c94
            |
            ---0x7f22a5fc7c94
               |         =20
                --3.74%--0x7f22a5fb7bd0
                          |         =20
                           --3.49%--0xffffffff81000bb2
                                     |         =20
                                      --3.41%--0xffffffff82c4e567
                                                |         =20
                                                 --2.87%--0xffffffff812e97e=
5
                                                           |         =20
                                                            --2.69%--0xffff=
ffff81810c1a
                                                                      |    =
     =20
                                                                       --2.=
68%--0xffffffff818104d4
                                                                           =
      |         =20
                                                                           =
       --2.43%--0xffffffff8180fe5d
                                                                           =
                 |         =20
                                                                           =
                 |--0.61%--0xffffffff8180f8f9
                                                                           =
                 |         =20
                                                                           =
                  --0.56%--0xffffffff8180f9d9

     3.90%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80fe5d
            |
            ---0xffffffff8180fe5d
               |         =20
               |--0.77%--0xffffffff8180fa20
               |          |         =20
               |           --0.71%--0xffffffff81808c95
               |                     |         =20
               |                      --0.51%--0xffffffff8176ab49
               |         =20
               |--0.61%--0xffffffff8180f8f9
               |         =20
               |--0.56%--0xffffffff8180f9d9
               |         =20
                --0.56%--0xffffffff8180ef76

     3.74%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fb7bd0
            |
            ---0x7f22a5fb7bd0
               |         =20
                --3.49%--0xffffffff81000bb2
                          |         =20
                           --3.41%--0xffffffff82c4e567
                                     |         =20
                                      --2.87%--0xffffffff812e97e5
                                                |         =20
                                                 --2.69%--0xffffffff81810c1=
a
                                                           |         =20
                                                            --2.68%--0xffff=
ffff818104d4
                                                                      |    =
     =20
                                                                       --2.=
43%--0xffffffff8180fe5d
                                                                           =
      |         =20
                                                                           =
      |--0.61%--0xffffffff8180f8f9
                                                                           =
      |         =20
                                                                           =
       --0.56%--0xffffffff8180f9d9

     2.74%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447f40
            |
            ---0xffffffff81447f40

     2.19%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
00012b
            |
            ---0xffffffff8100012b
               |         =20
                --2.18%--0xffffffff82c4a10c
                          |         =20
                           --0.58%--0xffffffff81819bb9
                                     0xffffffff817c06b4
                                     0xffffffff8181b3f5

     2.18%     0.00%  perf     [unknown]                   [k] 0xffffffff82=
c4a10c
            |
            ---0xffffffff82c4a10c
               |         =20
                --0.58%--0xffffffff81819bb9
                          0xffffffff817c06b4
                          0xffffffff8181b3f5

     1.93%     0.00%  perf     libasan.so.8.0.0            [.] __asan::Asan=
InitInternal() [clone .part.0]
            |
            ---__asan::AsanInitInternal() [clone .part.0]
               |         =20
                --1.12%--__sanitizer::Symbolizer::LateInitialize()
                          dlsym
                          0x7f22a49f9f1f
                          _dl_catch_error
                          |         =20
                           --1.04%--0x7f22a5faeaaf
                                     |         =20
                                      --0.93%--0x7f22a5fae9cc

     1.92%     0.00%  perf     libc.so.6                   [.] _dl_catch_er=
ror
            |
            ---_dl_catch_error
               _dl_catch_exception
               |         =20
                --1.79%--InitializeCommonInterceptors()
                          __interception::InterceptFunction(char const*, un=
signed long*, unsigned long, unsigned long)
                          dlsym
                          0x7f22a49f9f1f
                          |         =20
                          |--0.95%--__asan::AsanInitInternal() [clone .part=
.0]
                          |          __sanitizer::Symbolizer::LateInitializ=
e()
                          |          dlsym
                          |          0x7f22a49f9f1f
                          |          _dl_catch_error
                          |          0x7f22a5faeaaf
                          |          |         =20
                          |           --0.85%--0x7f22a5fae9cc
                          |         =20
                           --0.84%--_dl_catch_error
                                     _dl_catch_exception
                                     InitializeCommonInterceptors()
                                     __interception::InterceptFunction(char=
 const*, unsigned long*, unsigned long, unsigned long)
                                     dlsym
                                     0x7f22a49f9f1f
                                     |         =20
                                      --0.53%--_dl_catch_error
                                                _dl_catch_exception
                                                InitializeCommonInterceptor=
s()
                                                __interception::InterceptFu=
nction(char const*, unsigned long*, unsigned long, unsigned long)
                                                dlsym
                                                0x7f22a49f9f1f
                                                _dl_catch_error
                                                _dl_catch_exception
                                                |         =20
                                                 --0.52%--InitializeCommonI=
nterceptors()
                                                           __interception::=
InterceptFunction(char const*, unsigned long*, unsigned long, unsigned long=
)
                                                           dlsym
                                                           0x7f22a49f9f1f
                                                           _dl_catch_error
                                                           _dl_catch_except=
ion
                                                           InitializeCommon=
Interceptors()
                                                           __interception::=
InterceptFunction(char const*, unsigned long*, unsigned long, unsigned long=
)
                                                           dlsym
                                                           0x7f22a49f9f1f
                                                           _dl_catch_error
                                                           _dl_catch_except=
ion
                                                           InitializeCommon=
Interceptors()
                                                           __interception::=
InterceptFunction(char const*, unsigned long*, unsigned long, unsigned long=
)
                                                           dlsym
                                                           0x7f22a49f9f1f
                                                           |         =20
                                                            --0.51%--__asan=
::AsanInitInternal() [clone .part.0]

     1.92%     0.00%  perf     libc.so.6                   [.] _dl_catch_ex=
ception
            |
            ---_dl_catch_exception
               |         =20
                --1.79%--InitializeCommonInterceptors()
                          __interception::InterceptFunction(char const*, un=
signed long*, unsigned long, unsigned long)
                          dlsym
                          0x7f22a49f9f1f
                          |         =20
                          |--0.95%--__asan::AsanInitInternal() [clone .part=
.0]
                          |          __sanitizer::Symbolizer::LateInitializ=
e()
                          |          dlsym
                          |          0x7f22a49f9f1f
                          |          _dl_catch_error
                          |          0x7f22a5faeaaf
                          |          |         =20
                          |           --0.85%--0x7f22a5fae9cc
                          |         =20
                           --0.84%--_dl_catch_error
                                     _dl_catch_exception
                                     InitializeCommonInterceptors()
                                     __interception::InterceptFunction(char=
 const*, unsigned long*, unsigned long, unsigned long)
                                     dlsym
                                     0x7f22a49f9f1f
                                     |         =20
                                      --0.53%--_dl_catch_error
                                                _dl_catch_exception
                                                InitializeCommonInterceptor=
s()
                                                __interception::InterceptFu=
nction(char const*, unsigned long*, unsigned long, unsigned long)
                                                dlsym
                                                0x7f22a49f9f1f
                                                _dl_catch_error
                                                _dl_catch_exception
                                                |         =20
                                                 --0.52%--InitializeCommonI=
nterceptors()
                                                           __interception::=
InterceptFunction(char const*, unsigned long*, unsigned long, unsigned long=
)
                                                           dlsym
                                                           0x7f22a49f9f1f
                                                           _dl_catch_error
                                                           _dl_catch_except=
ion
                                                           InitializeCommon=
Interceptors()
                                                           __interception::=
InterceptFunction(char const*, unsigned long*, unsigned long, unsigned long=
)
                                                           dlsym
                                                           0x7f22a49f9f1f
                                                           _dl_catch_error
                                                           _dl_catch_except=
ion
                                                           InitializeCommon=
Interceptors()
                                                           __interception::=
InterceptFunction(char const*, unsigned long*, unsigned long, unsigned long=
)
                                                           dlsym
                                                           0x7f22a49f9f1f
                                                           |         =20
                                                            --0.51%--__asan=
::AsanInitInternal() [clone .part.0]

     1.92%     0.00%  perf     libasan.so.8.0.0            [.] InitializeCo=
mmonInterceptors()
            |
            ---InitializeCommonInterceptors()
               __interception::InterceptFunction(char const*, unsigned long=
*, unsigned long, unsigned long)
               dlsym
               0x7f22a49f9f1f
               |         =20
               |--1.09%--_dl_catch_error
               |          _dl_catch_exception
               |          |         =20
               |           --0.96%--InitializeCommonInterceptors()
               |                     __interception::InterceptFunction(char=
 const*, unsigned long*, unsigned long, unsigned long)
               |                     dlsym
               |                     0x7f22a49f9f1f
               |                     |         =20
               |                      --0.53%--_dl_catch_error
               |                                _dl_catch_exception
               |                                InitializeCommonInterceptor=
s()
               |                                __interception::InterceptFu=
nction(char const*, unsigned long*, unsigned long, unsigned long)
               |                                dlsym
               |                                0x7f22a49f9f1f
               |                                _dl_catch_error
               |                                _dl_catch_exception
               |                                |         =20
               |                                 --0.52%--InitializeCommonI=
nterceptors()
               |                                           __interception::=
InterceptFunction(char const*, unsigned long*, unsigned long, unsigned long=
)
               |                                           dlsym
               |                                           0x7f22a49f9f1f
               |                                           _dl_catch_error
               |                                           _dl_catch_except=
ion
               |                                           InitializeCommon=
Interceptors()
               |                                           __interception::=
InterceptFunction(char const*, unsigned long*, unsigned long, unsigned long=
)
               |                                           dlsym
               |                                           0x7f22a49f9f1f
               |                                           _dl_catch_error
               |                                           _dl_catch_except=
ion
               |                                           InitializeCommon=
Interceptors()
               |                                           __interception::=
InterceptFunction(char const*, unsigned long*, unsigned long, unsigned long=
)
               |                                           dlsym
               |                                           0x7f22a49f9f1f
               |                                           |         =20
               |                                            --0.51%--__asan=
::AsanInitInternal() [clone .part.0]
               |         =20
                --0.83%--__asan::AsanInitInternal() [clone .part.0]
                          __sanitizer::Symbolizer::LateInitialize()
                          dlsym
                          0x7f22a49f9f1f
                          _dl_catch_error
                          0x7f22a5faeaaf
                          |         =20
                           --0.75%--0x7f22a5fae9cc

     1.92%     0.00%  perf     libasan.so.8.0.0            [.] __intercepti=
on::InterceptFunction(char const*, unsigned long*, unsigned long, unsigned =
long)
            |
            ---__interception::InterceptFunction(char const*, unsigned long=
*, unsigned long, unsigned long)
               dlsym
               0x7f22a49f9f1f
               |         =20
               |--1.21%--_dl_catch_error
               |          _dl_catch_exception
               |          |         =20
               |           --1.08%--InitializeCommonInterceptors()
               |                     __interception::InterceptFunction(char=
 const*, unsigned long*, unsigned long, unsigned long)
               |                     dlsym
               |                     0x7f22a49f9f1f
               |                     |         =20
               |                     |--0.55%--__asan::AsanInitInternal() [=
clone .part.0]
               |                     |         =20
               |                      --0.53%--_dl_catch_error
               |                                _dl_catch_exception
               |                                InitializeCommonInterceptor=
s()
               |                                __interception::InterceptFu=
nction(char const*, unsigned long*, unsigned long, unsigned long)
               |                                dlsym
               |                                0x7f22a49f9f1f
               |                                _dl_catch_error
               |                                _dl_catch_exception
               |                                |         =20
               |                                 --0.52%--InitializeCommonI=
nterceptors()
               |                                           __interception::=
InterceptFunction(char const*, unsigned long*, unsigned long, unsigned long=
)
               |                                           dlsym
               |                                           0x7f22a49f9f1f
               |                                           _dl_catch_error
               |                                           _dl_catch_except=
ion
               |                                           InitializeCommon=
Interceptors()
               |                                           __interception::=
InterceptFunction(char const*, unsigned long*, unsigned long, unsigned long=
)
               |                                           dlsym
               |                                           0x7f22a49f9f1f
               |                                           _dl_catch_error
               |                                           _dl_catch_except=
ion
               |                                           InitializeCommon=
Interceptors()
               |                                           __interception::=
InterceptFunction(char const*, unsigned long*, unsigned long, unsigned long=
)
               |                                           dlsym
               |                                           0x7f22a49f9f1f
               |                                           |         =20
               |                                            --0.51%--__asan=
::AsanInitInternal() [clone .part.0]
               |         =20
                --0.71%--__asan::AsanInitInternal() [clone .part.0]
                          __sanitizer::Symbolizer::LateInitialize()
                          dlsym
                          0x7f22a49f9f1f
                          _dl_catch_error
                          0x7f22a5faeaaf
                          0x7f22a5fae9cc

     1.92%     0.00%  perf     libc.so.6                   [.] dlsym
            |
            ---dlsym
               0x7f22a49f9f1f
               _dl_catch_error
               _dl_catch_exception
               |         =20
                --1.79%--InitializeCommonInterceptors()
                          __interception::InterceptFunction(char const*, un=
signed long*, unsigned long, unsigned long)
                          dlsym
                          0x7f22a49f9f1f
                          |         =20
                          |--1.04%--__asan::AsanInitInternal() [clone .part=
.0]
                          |          __sanitizer::Symbolizer::LateInitializ=
e()
                          |          dlsym
                          |          0x7f22a49f9f1f
                          |          _dl_catch_error
                          |          0x7f22a5faeaaf
                          |          |         =20
                          |           --0.93%--0x7f22a5fae9cc
                          |         =20
                           --0.74%--_dl_catch_error
                                     _dl_catch_exception
                                     InitializeCommonInterceptors()
                                     __interception::InterceptFunction(char=
 const*, unsigned long*, unsigned long, unsigned long)
                                     dlsym
                                     0x7f22a49f9f1f
                                     |         =20
                                      --0.53%--_dl_catch_error
                                                _dl_catch_exception
                                                |         =20
                                                 --0.52%--InitializeCommonI=
nterceptors()
                                                           __interception::=
InterceptFunction(char const*, unsigned long*, unsigned long, unsigned long=
)
                                                           dlsym
                                                           0x7f22a49f9f1f
                                                           _dl_catch_error
                                                           _dl_catch_except=
ion
                                                           InitializeCommon=
Interceptors()
                                                           __interception::=
InterceptFunction(char const*, unsigned long*, unsigned long, unsigned long=
)
                                                           dlsym
                                                           0x7f22a49f9f1f
                                                           _dl_catch_error
                                                           _dl_catch_except=
ion
                                                           InitializeCommon=
Interceptors()
                                                           __interception::=
InterceptFunction(char const*, unsigned long*, unsigned long, unsigned long=
)
                                                           dlsym
                                                           0x7f22a49f9f1f
                                                           |         =20
                                                            --0.51%--__asan=
::AsanInitInternal() [clone .part.0]

     1.92%     0.00%  perf     libc.so.6                   [.] 0x00007f22a4=
9f9f1f
            |
            ---0x7f22a49f9f1f
               _dl_catch_error
               _dl_catch_exception
               |         =20
                --1.79%--InitializeCommonInterceptors()
                          __interception::InterceptFunction(char const*, un=
signed long*, unsigned long, unsigned long)
                          dlsym
                          0x7f22a49f9f1f
                          |         =20
                          |--0.95%--__asan::AsanInitInternal() [clone .part=
.0]
                          |          __sanitizer::Symbolizer::LateInitializ=
e()
                          |          dlsym
                          |          0x7f22a49f9f1f
                          |          _dl_catch_error
                          |          0x7f22a5faeaaf
                          |          |         =20
                          |           --0.85%--0x7f22a5fae9cc
                          |         =20
                           --0.84%--_dl_catch_error
                                     _dl_catch_exception
                                     InitializeCommonInterceptors()
                                     __interception::InterceptFunction(char=
 const*, unsigned long*, unsigned long, unsigned long)
                                     dlsym
                                     0x7f22a49f9f1f
                                     |         =20
                                      --0.53%--_dl_catch_error
                                                _dl_catch_exception
                                                |         =20
                                                 --0.52%--InitializeCommonI=
nterceptors()
                                                           __interception::=
InterceptFunction(char const*, unsigned long*, unsigned long, unsigned long=
)
                                                           dlsym
                                                           0x7f22a49f9f1f
                                                           _dl_catch_error
                                                           _dl_catch_except=
ion
                                                           InitializeCommon=
Interceptors()
                                                           __interception::=
InterceptFunction(char const*, unsigned long*, unsigned long, unsigned long=
)
                                                           dlsym
                                                           0x7f22a49f9f1f
                                                           _dl_catch_error
                                                           _dl_catch_except=
ion
                                                           InitializeCommon=
Interceptors()
                                                           __interception::=
InterceptFunction(char const*, unsigned long*, unsigned long, unsigned long=
)
                                                           dlsym
                                                           0x7f22a49f9f1f
                                                           |         =20
                                                            --0.51%--__asan=
::AsanInitInternal() [clone .part.0]

     1.58%     1.58%  perf     [kernel.kallsyms]           [k] __asan_load4=
_noabort
            |         =20
             --0.82%--0x7f22a5fc4a53
                       0x7f22a5fc5ba7
                       0x7f22a5fc422d
                       |         =20
                        --0.67%--0x7f22a5fc7c94
                                  |         =20
                                   --0.61%--0x7f22a5fb7bd0
                                             0xffffffff81000bb2
                                             |         =20
                                              --0.60%--0xffffffff82c4e567

     1.57%     1.57%  perf     [kernel.kallsyms]           [k] __asan_load8=
_noabort
            |         =20
             --0.68%--0x7f22a5fc4a53
                       0x7f22a5fc5ba7
                       0x7f22a5fc422d

     1.46%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
000e06
            |
            ---0xffffffff81000e06
               |         =20
                --0.89%--0xffffffff82c4e045
                          0xffffffff812bff0a
                          |         =20
                           --0.76%--0xffffffff814e0b03
                                     |         =20
                                      --0.67%--0xffffffff814df5aa
                                                |         =20
                                                 --0.64%--0xffffffff8150115=
d
                                                           |         =20
                                                            --0.54%--0xffff=
ffff814ddf20

     1.32%     0.00%  perf     [kernel.kallsyms]           [k] entry_SYSCAL=
L_64_after_hwframe
            |
            ---entry_SYSCALL_64_after_hwframe
               do_syscall_64
               x64_sys_call
               0xffffffff813506b8
               do_group_exit
               do_exit
               |         =20
                --1.30%--exit_mm
                          __mmput
                          exit_mmap
                          |         =20
                           --1.01%--unmap_vmas
                                     unmap_page_range
                                     |         =20
                                      --1.00%--zap_pmd_range.isra.0
                                                |         =20
                                                 --0.88%--zap_pte_range

     1.32%     0.00%  perf     [kernel.kallsyms]           [k] do_syscall_6=
4
            |
            ---do_syscall_64
               x64_sys_call
               0xffffffff813506b8
               do_group_exit
               do_exit
               |         =20
                --1.30%--exit_mm
                          __mmput
                          exit_mmap
                          |         =20
                           --1.01%--unmap_vmas
                                     unmap_page_range
                                     |         =20
                                      --1.00%--zap_pmd_range.isra.0
                                                |         =20
                                                 --0.88%--zap_pte_range

     1.32%     0.00%  perf     [kernel.kallsyms]           [k] x64_sys_call
            |
            ---x64_sys_call
               0xffffffff813506b8
               do_group_exit
               do_exit
               |         =20
                --1.30%--exit_mm
                          __mmput
                          exit_mmap
                          |         =20
                           --1.01%--unmap_vmas
                                     unmap_page_range
                                     |         =20
                                      --1.00%--zap_pmd_range.isra.0
                                                |         =20
                                                 --0.88%--zap_pte_range

     1.32%     0.00%  perf     [kernel.kallsyms]           [k] 0xffffffff81=
3506b8
            |
            ---0xffffffff813506b8
               do_group_exit
               do_exit
               |         =20
                --1.30%--exit_mm
                          __mmput
                          exit_mmap
                          |         =20
                           --1.01%--unmap_vmas
                                     unmap_page_range
                                     |         =20
                                      --1.00%--zap_pmd_range.isra.0
                                                |         =20
                                                 --0.88%--zap_pte_range

     1.32%     0.00%  perf     [kernel.kallsyms]           [k] do_group_exi=
t
            |
            ---do_group_exit
               do_exit
               |         =20
                --1.30%--exit_mm
                          __mmput
                          exit_mmap
                          |         =20
                           --1.01%--unmap_vmas
                                     unmap_page_range
                                     |         =20
                                      --1.00%--zap_pmd_range.isra.0
                                                |         =20
                                                 --0.88%--zap_pte_range

     1.32%     0.00%  perf     [kernel.kallsyms]           [k] do_exit
            |
            ---do_exit
               |         =20
                --1.30%--exit_mm
                          __mmput
                          exit_mmap
                          |         =20
                           --1.01%--unmap_vmas
                                     unmap_page_range
                                     |         =20
                                      --1.00%--zap_pmd_range.isra.0
                                                |         =20
                                                 --0.88%--zap_pte_range

     1.31%     0.00%  perf     libc.so.6                   [.] dl_iterate_p=
hdr
            |         =20
             --0.90%--dl_iterate_phdr
                       __lsan::ProcessGlobalRegionsCallback(dl_phdr_info*, =
unsigned long, void*)
                       __lsan::ScanGlobalRange(unsigned long, unsigned long=
, __sanitizer::InternalMmapVector<unsigned long>*)
                       __lsan::ScanRangeForPointers(unsigned long, unsigned=
 long, __sanitizer::InternalMmapVector<unsigned long>*, char const*, __lsan=
::ChunkTag)

     1.30%     0.00%  perf     [kernel.kallsyms]           [k] exit_mm
            |
            ---exit_mm
               __mmput
               exit_mmap
               |         =20
                --1.01%--unmap_vmas
                          unmap_page_range
                          |         =20
                           --1.00%--zap_pmd_range.isra.0
                                     |         =20
                                      --0.88%--zap_pte_range

     1.30%     0.00%  perf     [kernel.kallsyms]           [k] __mmput
            |
            ---__mmput
               exit_mmap
               |         =20
                --1.01%--unmap_vmas
                          unmap_page_range
                          |         =20
                           --1.00%--zap_pmd_range.isra.0
                                     |         =20
                                      --0.88%--zap_pte_range

     1.30%     0.00%  perf     [kernel.kallsyms]           [k] exit_mmap
            |
            ---exit_mmap
               |         =20
                --1.01%--unmap_vmas
                          unmap_page_range
                          |         =20
                           --1.00%--zap_pmd_range.isra.0
                                     |         =20
                                      --0.88%--zap_pte_range

     1.15%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:internal_clone(int (*)(void*), void*, int, void*, int*, void*, int*)
            |         =20
             --1.03%--__sanitizer::internal_clone(int (*)(void*), void*, in=
t, void*, int*, void*, int*)
                       __sanitizer::TracerThread(void*)
                       |         =20
                        --1.03%--__lsan::CheckForLeaksCallback(__sanitizer:=
:SuspendedThreadsList const&, void*)
                                  |         =20
                                   --0.90%--dl_iterate_phdr
                                             __lsan::ProcessGlobalRegionsCa=
llback(dl_phdr_info*, unsigned long, void*)
                                             __lsan::ScanGlobalRange(unsign=
ed long, unsigned long, __sanitizer::InternalMmapVector<unsigned long>*)
                                             __lsan::ScanRangeForPointers(u=
nsigned long, unsigned long, __sanitizer::InternalMmapVector<unsigned long>=
*, char const*, __lsan::ChunkTag)

     1.12%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:Symbolizer::LateInitialize()
            |
            ---__sanitizer::Symbolizer::LateInitialize()
               dlsym
               0x7f22a49f9f1f
               _dl_catch_error
               |         =20
                --1.04%--0x7f22a5faeaaf
                          |         =20
                           --0.93%--0x7f22a5fae9cc

     1.11%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
8c631c
            |
            ---0xffffffff818c631c
               0xffffffff814d3906
               |         =20
                --0.55%--0xffffffff81276d58

     1.11%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
4d3906
            |
            ---0xffffffff814d3906
               |         =20
                --0.55%--0xffffffff81276d58

     1.08%     1.08%  perf     [kernel.kallsyms]           [k] kasan_check_=
range
     1.07%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
7c06b4
            |
            ---0xffffffff817c06b4
               |         =20
                --1.05%--0xffffffff8181b3f5

     1.05%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
faeaaf
            |
            ---0x7f22a5faeaaf
               |         =20
                --0.95%--0x7f22a5fae9cc

     1.05%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
81b3f5
            |
            ---0xffffffff8181b3f5

     1.04%     0.85%  perf     [kernel.kallsyms]           [k] __lock_acqui=
re
     1.03%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:TracerThread(void*)
            |
            ---__sanitizer::TracerThread(void*)
               |         =20
                --1.03%--__lsan::CheckForLeaksCallback(__sanitizer::Suspend=
edThreadsList const&, void*)
                          |         =20
                           --0.90%--dl_iterate_phdr
                                     __lsan::ProcessGlobalRegionsCallback(d=
l_phdr_info*, unsigned long, void*)
                                     __lsan::ScanGlobalRange(unsigned long,=
 unsigned long, __sanitizer::InternalMmapVector<unsigned long>*)
                                     __lsan::ScanRangeForPointers(unsigned =
long, unsigned long, __sanitizer::InternalMmapVector<unsigned long>*, char =
const*, __lsan::ChunkTag)

     1.03%     0.00%  perf     libasan.so.8.0.0            [.] __lsan::Chec=
kForLeaksCallback(__sanitizer::SuspendedThreadsList const&, void*)
            |
            ---__lsan::CheckForLeaksCallback(__sanitizer::SuspendedThreadsL=
ist const&, void*)
               |         =20
                --0.90%--dl_iterate_phdr
                          __lsan::ProcessGlobalRegionsCallback(dl_phdr_info=
*, unsigned long, void*)
                          __lsan::ScanGlobalRange(unsigned long, unsigned l=
ong, __sanitizer::InternalMmapVector<unsigned long>*)
                          __lsan::ScanRangeForPointers(unsigned long, unsig=
ned long, __sanitizer::InternalMmapVector<unsigned long>*, char const*, __l=
san::ChunkTag)

     1.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c6390
            |
            ---0xffffffff818c6390
               |         =20
                --0.94%--0xffffffff818c631c
                          0xffffffff814d3906

     1.01%     0.00%  perf     [kernel.kallsyms]           [k] unmap_vmas
            |
            ---unmap_vmas
               unmap_page_range
               |         =20
                --1.00%--zap_pmd_range.isra.0
                          |         =20
                           --0.88%--zap_pte_range

     1.01%     0.01%  perf     [kernel.kallsyms]           [k] unmap_page_r=
ange
            |         =20
             --1.00%--unmap_page_range
                       zap_pmd_range.isra.0
                       |         =20
                        --0.88%--zap_pte_range

     1.00%     0.00%  perf     [kernel.kallsyms]           [k] zap_pmd_rang=
e.isra.0
            |
            ---zap_pmd_range.isra.0
               |         =20
                --0.88%--zap_pte_range

     0.96%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2bff0a
            |
            ---0xffffffff812bff0a
               |         =20
                --0.83%--0xffffffff814e0b03
                          |         =20
                           --0.74%--0xffffffff814df5aa
                                     |         =20
                                      --0.69%--0xffffffff8150115d
                                                |         =20
                                                 --0.59%--0xffffffff814ddf2=
0

     0.95%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fae9cc
            |
            ---0x7f22a5fae9cc

     0.94%     0.29%  perf     libasan.so.8.0.0            [.] __lsan::Scan=
RangeForPointers(unsigned long, unsigned long, __sanitizer::InternalMmapVec=
tor<unsigned long>*, char const*, __lsan::ChunkTag)
            |         =20
             --0.65%--__lsan::ScanRangeForPointers(unsigned long, unsigned =
long, __sanitizer::InternalMmapVector<unsigned long>*, char const*, __lsan:=
:ChunkTag)

     0.90%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fc7975
            |
            ---0x7f22a5fc7975
               |         =20
                --0.89%--0x7f22a5fac5c5
                          _dl_catch_exception
                          0x7f22a5fac25c
                          |         =20
                           --0.80%--0x7f22a5fb2070

     0.90%     0.00%  perf     libasan.so.8.0.0            [.] __lsan::Proc=
essGlobalRegionsCallback(dl_phdr_info*, unsigned long, void*)
            |
            ---__lsan::ProcessGlobalRegionsCallback(dl_phdr_info*, unsigned=
 long, void*)
               __lsan::ScanGlobalRange(unsigned long, unsigned long, __sani=
tizer::InternalMmapVector<unsigned long>*)
               __lsan::ScanRangeForPointers(unsigned long, unsigned long, _=
_sanitizer::InternalMmapVector<unsigned long>*, char const*, __lsan::ChunkT=
ag)

     0.90%     0.00%  perf     libasan.so.8.0.0            [.] __lsan::Scan=
GlobalRange(unsigned long, unsigned long, __sanitizer::InternalMmapVector<u=
nsigned long>*)
            |
            ---__lsan::ScanGlobalRange(unsigned long, unsigned long, __sani=
tizer::InternalMmapVector<unsigned long>*)
               __lsan::ScanRangeForPointers(unsigned long, unsigned long, _=
_sanitizer::InternalMmapVector<unsigned long>*, char const*, __lsan::ChunkT=
ag)

     0.89%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fac5c5
            |
            ---0x7f22a5fac5c5
               _dl_catch_exception
               0x7f22a5fac25c
               |         =20
                --0.80%--0x7f22a5fb2070

     0.89%     0.00%  perf     ld-linux-x86-64.so.2        [.] _dl_catch_ex=
ception
            |
            ---_dl_catch_exception
               0x7f22a5fac25c
               |         =20
                --0.80%--0x7f22a5fb2070

     0.89%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fac25c
            |
            ---0x7f22a5fac25c
               |         =20
                --0.80%--0x7f22a5fb2070

     0.89%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4e045
            |
            ---0xffffffff82c4e045
               0xffffffff812bff0a
               |         =20
                --0.76%--0xffffffff814e0b03
                          |         =20
                           --0.67%--0xffffffff814df5aa
                                     |         =20
                                      --0.64%--0xffffffff8150115d
                                                |         =20
                                                 --0.54%--0xffffffff814ddf2=
0

     0.88%     0.01%  perf     [kernel.kallsyms]           [k] zap_pte_rang=
e
            |         =20
             --0.87%--zap_pte_range

     0.83%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4e0b03
            |
            ---0xffffffff814e0b03
               |         =20
                --0.74%--0xffffffff814df5aa
                          |         =20
                           --0.69%--0xffffffff8150115d
                                     |         =20
                                      --0.59%--0xffffffff814ddf20

     0.80%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fb2070
            |
            ---0x7f22a5fb2070

     0.78%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e97ae
            |
            ---0xffffffff812e97ae

     0.77%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80fa20
            |
            ---0xffffffff8180fa20
               |         =20
                --0.71%--0xffffffff81808c95
                          |         =20
                           --0.51%--0xffffffff8176ab49

     0.74%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4df5aa
            |
            ---0xffffffff814df5aa
               |         =20
                --0.69%--0xffffffff8150115d
                          |         =20
                           --0.59%--0xffffffff814ddf20

     0.73%     0.09%  perf     libasan.so.8.0.0            [.] __asan_regis=
ter_globals.part.0
            |         =20
             --0.64%--__asan_register_globals.part.0

     0.71%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
808c95
            |
            ---0xffffffff81808c95
               |         =20
                --0.51%--0xffffffff8176ab49

     0.69%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
50115d
            |
            ---0xffffffff8150115d
               |         =20
                --0.59%--0xffffffff814ddf20

     0.69%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8adf9a
            |
            ---0xffffffff818adf9a

     0.65%     0.00%  perf     libasan.so.8.0.0            [.] __asan::Allo=
cator::Allocate(unsigned long, unsigned long, __sanitizer::BufferedStackTra=
ce*, __asan::AllocType, bool)
            |
            ---__asan::Allocator::Allocate(unsigned long, unsigned long, __=
sanitizer::BufferedStackTrace*, __asan::AllocType, bool)

     0.64%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8b29bc
            |
            ---0xffffffff818b29bc
               |         =20
                --0.63%--0xffffffff818b2672
                          0xffffffff818adf9a

     0.63%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8b2672
            |
            ---0xffffffff818b2672
               0xffffffff818adf9a

     0.63%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fcaad0
            |
            ---0x7f22a5fcaad0
               |         =20
                --0.62%--0xffffffff8100012b
                          0xffffffff82c4a10c
                          |         =20
                           --0.58%--0xffffffff81819bb9
                                     0xffffffff817c06b4
                                     0xffffffff8181b3f5

     0.61%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80f8f9
            |
            ---0xffffffff8180f8f9

     0.59%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4ddf20
            |
            ---0xffffffff814ddf20

     0.58%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
819bb9
            |
            ---0xffffffff81819bb9
               0xffffffff817c06b4
               0xffffffff8181b3f5

     0.58%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44784b
            |
            ---0xffffffff8144784b

     0.57%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
276d58
            |
            ---0xffffffff81276d58

     0.56%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80f9d9
            |
            ---0xffffffff8180f9d9

     0.56%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80ef76
            |
            ---0xffffffff8180ef76

     0.54%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c6603
            |
            ---0xffffffff818c6603
               0xffffffff818c9637
               0xffffffff818c6390

     0.54%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c9637
            |
            ---0xffffffff818c9637
               0xffffffff818c6390

     0.54%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44681e
            |
            ---0xffffffff8144681e

     0.51%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
76ab49
            |
            ---0xffffffff8176ab49

     0.50%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9089fa
            |
            ---0xffffffff819089fa

     0.50%     0.01%  perf     [kernel.kallsyms]           [k] free_pages_a=
nd_swap_cache
     0.50%     0.00%  perf     [kernel.kallsyms]           [k] __tlb_batch_=
free_encoded_pages
            |
            ---__tlb_batch_free_encoded_pages
               free_pages_and_swap_cache

     0.49%     0.25%  perf     [kernel.kallsyms]           [k] lock_acquire
     0.49%     0.02%  perf     [kernel.kallsyms]           [k] folios_put_r=
efs
     0.49%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fb0a24
     0.48%     0.00%  perf     [kernel.kallsyms]           [k] tlb_flush_mm=
u
     0.48%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:internal_mmap(void*, unsigned long, int, int, int, unsigned long long)
     0.48%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
84aa03
     0.45%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
354faa
     0.44%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:CombinedAllocator<__sanitizer::SizeClassAllocator64<__asan::AP64<__sanitiz=
er::LocalAddressSpaceView> >, __sanitizer::LargeMmapAllocatorPtrArrayDynami=
c>::Allocate(__sanitizer::SizeClassAllocator64LocalCache<__sanitizer::SizeC=
lassAllocator64<__asan::AP64<__sanitizer::LocalAddressSpaceView> > >*, unsi=
gned long, unsigned long)
     0.44%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:SizeClassAllocator64LocalCache<__sanitizer::SizeClassAllocator64<__asan::A=
P64<__sanitizer::LocalAddressSpaceView> > >::Refill(__sanitizer::SizeClassA=
llocator64LocalCache<__sanitizer::SizeClassAllocator64<__asan::AP64<__sanit=
izer::LocalAddressSpaceView> > >::PerClass*, __sanitizer::SizeClassAllocato=
r64<__asan::AP64<__sanitizer::LocalAddressSpaceView> >*, unsigned long)
     0.44%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3541a9
     0.43%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
847b3b
     0.43%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:SizeClassAllocator64<__asan::AP64<__sanitizer::LocalAddressSpaceView> >::G=
etFromAllocator(__sanitizer::AllocatorStats*, unsigned long, unsigned int*,=
 unsigned long)
     0.43%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:SizeClassAllocator64<__asan::AP64<__sanitizer::LocalAddressSpaceView> >::P=
opulateFreeArray(__sanitizer::AllocatorStats*, unsigned long, __sanitizer::=
SizeClassAllocator64<__asan::AP64<__sanitizer::LocalAddressSpaceView> >::Re=
gionInfo*, unsigned long)
     0.43%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85f61d
     0.42%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
353c14
     0.42%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80f8db
     0.42%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c675a
     0.42%     0.42%  perf     [kernel.kallsyms]           [k] __asan_load1=
_noabort
     0.40%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8bcc
     0.40%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4a8f34
     0.40%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4a082a
     0.40%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
908a0a
     0.39%     0.39%  perf     [kernel.kallsyms]           [k] __asan_store=
8_noabort
     0.39%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4e07e
     0.39%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
276d6e
     0.38%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
810d05
     0.38%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8d2c
     0.37%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2de0c3
     0.37%     0.09%  perf     [kernel.kallsyms]           [k] zap_present_=
ptes.constprop.0
     0.37%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8088b1
     0.36%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
87593f
     0.36%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
39522e
     0.36%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:ReadFileToBuffer(char const*, char**, unsigned long*, unsigned long*, unsi=
gned long, int*)
     0.36%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:MemoryMappingLayout::MemoryMappingLayout(bool)
     0.35%     0.34%  perf     [kernel.kallsyms]           [k] lock_is_held=
_type
     0.34%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:ReadProcMaps(__sanitizer::ProcSelfMapsBuff*)
     0.34%     0.00%  perf     perf                        [.] __asan_regis=
ter_globals@plt
     0.33%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80ebf3
     0.33%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80ffbe
     0.33%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
877c18
     0.33%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
76647b
     0.32%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
84adbe
     0.32%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8b80
     0.32%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
788877
     0.31%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446a98
     0.30%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9529e6
     0.30%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80837d
     0.30%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80f9b2
     0.30%     0.00%  perf     libc.so.6                   [.] exit
     0.30%     0.00%  perf     libc.so.6                   [.] 0x00007f22a4=
9b355b
     0.29%     0.00%  perf     libasan.so.8.0.0            [.] __intercepto=
r_malloc
     0.29%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
950ef0
     0.29%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9b10d1
     0.29%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8ce0
     0.29%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80f928
     0.29%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fae819
     0.29%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fab128
     0.29%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85d46e
     0.28%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8ba5
     0.28%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8cea
     0.28%     0.00%  perf     libasan.so.8.0.0            [.] __intercepto=
r_calloc
     0.28%     0.00%  perf     libasan.so.8.0.0            [.] __asan::asan=
_calloc(unsigned long, unsigned long, __sanitizer::BufferedStackTrace*)
     0.28%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
84747d
     0.28%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:ReadFromFile(int, void*, unsigned long, unsigned long*, int*)
     0.28%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:internal_read(int, void*, unsigned long)
     0.28%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c44916
     0.28%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80615f
     0.28%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
8c8b8a
     0.27%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
76629d
     0.27%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447685
     0.27%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
84a2d1
     0.27%     0.27%  perf     [kernel.kallsyms]           [k] copy_mc_enha=
nced_fast_string
     0.26%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44741b
     0.26%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:MmapFixedImpl(unsigned long, unsigned long, bool, char const*)
     0.26%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:StackDepotBase<__sanitizer::StackDepotNode, 1, 20>::Put(__sanitizer::Stack=
Trace, bool*)
     0.26%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:StackDepotBase<__sanitizer::StackDepotNode, 1, 20>::lock(__sanitizer::atom=
ic_uint32_t*)
     0.26%     0.01%  perf     [kernel.kallsyms]           [k] kmem_cache_f=
ree
     0.25%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:InternalAlloc(unsigned long, __sanitizer::SizeClassAllocator32LocalCache<_=
_sanitizer::SizeClassAllocator32<__sanitizer::AP32> >*, unsigned long)
     0.25%     0.00%  perf     libasan.so.8.0.0            [.] __lsan::Init=
ializePlatformSpecificModules()
     0.25%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:ListOfModules::init()
     0.25%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:dl_iterate_phdr_cb(dl_phdr_info*, unsigned long, void*)
     0.24%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
82b54e
     0.24%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80a39e
     0.24%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7885a0
     0.24%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
34269a
     0.24%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3409f8
     0.24%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7485ab
     0.24%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
73d4ec
     0.24%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
73d114
     0.24%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9b0d02
     0.24%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
a71cea
     0.23%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
76dce4
     0.23%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
76d39c
     0.23%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80a156
     0.23%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8d05
     0.23%     0.00%  perf     libc.so.6                   [.] 0x00007f22a4=
ad96c0
     0.23%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
875bbf
     0.22%     0.01%  perf     [kernel.kallsyms]           [k] free_unref_f=
olios
     0.22%     0.02%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:LowLevelAllocator::Allocate(unsigned long)
     0.22%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:MmapOrDie(unsigned long, char const*, bool)
     0.22%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c642fc
     0.22%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9060b0
     0.22%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80ebd5
     0.22%     0.00%  perf     libc.so.6                   [.] 0x00007f22a4=
9fa51f
     0.21%     0.20%  perf     [kernel.kallsyms]           [k] mark_lock
     0.21%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8ff706
     0.21%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
49492c
     0.20%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8725f8
     0.20%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
39517a
     0.20%     0.00%  perf     libc.so.6                   [.] __cxa_finali=
ze
     0.20%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
846d99
     0.20%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44621b
     0.20%     0.20%  perf     [kernel.kallsyms]           [k] __kasan_chec=
k_read
     0.20%     0.00%  perf     libasan.so.8.0.0            [.] __asan::Pois=
onShadow(unsigned long, unsigned long, unsigned char)
     0.19%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4459da
     0.19%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:CombinedAllocator<__sanitizer::SizeClassAllocator32<__sanitizer::AP32>, __=
sanitizer::LargeMmapAllocatorPtrArrayStatic>::Allocate(__sanitizer::SizeCla=
ssAllocator32LocalCache<__sanitizer::SizeClassAllocator32<__sanitizer::AP32=
> >*, unsigned long, unsigned long)
     0.19%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:SizeClassAllocator32LocalCache<__sanitizer::SizeClassAllocator32<__sanitiz=
er::AP32> >::Refill(__sanitizer::SizeClassAllocator32LocalCache<__sanitizer=
::SizeClassAllocator32<__sanitizer::AP32> >::PerClass*, __sanitizer::SizeCl=
assAllocator32<__sanitizer::AP32>*, unsigned long)
     0.19%     0.00%  perf     libasan.so.8.0.0            [.] __asan::Crea=
teMainThread()
     0.19%     0.00%  perf     libasan.so.8.0.0            [.] __asan::Asan=
Thread::ThreadStart(unsigned long long)
     0.19%     0.00%  perf     libasan.so.8.0.0            [.] __asan::Asan=
Thread::Init(__asan::AsanThread::InitOptions const*)
     0.19%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d1f35
     0.19%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80fc6f
     0.19%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
82b95f
     0.19%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
82baf3
     0.19%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fb840c
     0.19%     0.00%  perf     libc.so.6                   [.] 0x00007f22a4=
ac48e7
     0.19%     0.05%  perf     libasan.so.8.0.0            [.] __lsan::Poin=
tsIntoChunk(void*)
     0.18%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
33d7f6
     0.18%     0.01%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:SizeClassAllocator32<__sanitizer::AP32>::PopulateFreeList(__sanitizer::All=
ocatorStats*, __sanitizer::SizeClassAllocator32LocalCache<__sanitizer::Size=
ClassAllocator32<__sanitizer::AP32> >*, __sanitizer::SizeClassAllocator32<_=
_sanitizer::AP32>::SizeClassInfo*, unsigned long)
     0.18%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:SizeClassAllocator32<__sanitizer::AP32>::AllocateBatch(__sanitizer::Alloca=
torStats*, __sanitizer::SizeClassAllocator32LocalCache<__sanitizer::SizeCla=
ssAllocator32<__sanitizer::AP32> >*, unsigned long)
     0.18%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:MemoryMappingLayout::CacheMemoryMappings()
     0.18%     0.00%  perf     libasan.so.8.0.0            [.] __asan::Init=
ializeShadowMemory()
     0.18%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:MemoryRangeIsAvailable(unsigned long, unsigned long)
     0.18%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
84736f
     0.18%     0.00%  perf     libasan.so.8.0.0            [.] __asan::Asan=
Thread::SetThreadStackAndTls(__asan::AsanThread::InitOptions const*)
     0.18%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:GetThreadStackAndTls(bool, unsigned long*, unsigned long*, unsigned long*,=
 unsigned long*)
     0.18%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:GetThreadStackTopAndBottom(bool, unsigned long*, unsigned long*)
     0.18%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
744a4b
     0.18%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85f530
     0.18%     0.00%  perf     libasan.so.8.0.0            [.] operator new=
(unsigned long)
     0.18%     0.00%  perf     libasan.so.8.0.0            [.] __asan::asan=
_memalign(unsigned long, unsigned long, __sanitizer::BufferedStackTrace*, _=
_asan::AllocType)
     0.18%     0.04%  perf     [kernel.kallsyms]           [k] arch_stack_w=
alk
     0.18%     0.13%  perf     [kernel.kallsyms]           [k] lock_release
     0.17%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
4a6625
     0.17%     0.00%  perf     [unknown]                   [k] 0xffffffff82=
c26886
     0.17%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
8c9588
     0.17%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fb8ca3
     0.17%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fb7ad8
     0.17%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fcab40
     0.17%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
822353
     0.17%     0.01%  perf     [kernel.kallsyms]           [k] folio_remove=
_rmap_ptes
     0.17%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8087a0
     0.17%     0.00%  perf     [unknown]                   [k] 0xffffffff82=
c116b3
     0.16%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fc4a7b
     0.16%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
faeaf8
     0.16%     0.10%  perf     [kernel.kallsyms]           [k] unwind_next_=
frame
     0.16%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44786b
     0.16%     0.00%  perf     libasan.so.8.0.0            [.] __asan::asan=
_malloc(unsigned long, __sanitizer::BufferedStackTrace*)
     0.16%     0.00%  perf     libasan.so.8.0.0            [.] __do_global_=
dtors_aux
     0.16%     0.00%  perf     libasan.so.8.0.0            [.] __lsan::DoLe=
akCheck()
     0.16%     0.00%  perf     libasan.so.8.0.0            [.] __lsan::Chec=
kForLeaks()
     0.16%     0.00%  perf     libasan.so.8.0.0            [.] __lsan::Lock=
StuffAndStopTheWorld(void (*)(__sanitizer::SuspendedThreadsList const&, voi=
d*), __lsan::CheckForLeaksParam*)
     0.16%     0.00%  perf     libasan.so.8.0.0            [.] __lsan::Lock=
StuffAndStopTheWorldCallback(dl_phdr_info*, unsigned long, void*)
     0.16%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:StopTheWorld(void (*)(__sanitizer::SuspendedThreadsList const&, void*), vo=
id*)
     0.15%     0.00%  perf     [kernel.kallsyms]           [k] __lruvec_sta=
t_mod_folio
     0.15%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
830784
     0.15%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
82d776
     0.15%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
48d4d8
     0.15%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
858d34
     0.15%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fb3c73
     0.15%     0.00%  perf     ld-linux-x86-64.so.2        [.] _dl_exceptio=
n_create_format
     0.15%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:UnmapOrDie(void*, unsigned long)
     0.15%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:internal_munmap(void*, unsigned long)
     0.15%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8192f1
     0.15%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
84de73
     0.15%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
849635
     0.15%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
90730b
     0.15%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
73cd6a
     0.15%     0.00%  perf     libLLVM-14.so.1             [.] llvm::cl::Op=
tion::addArgument()
     0.15%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
5fd0d7
     0.15%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
5fceea
     0.15%     0.00%  perf     libLLVM-14.so.1             [.] llvm::String=
MapImpl::RehashTable(unsigned int)
     0.15%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
6727ea
     0.15%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
845a82
     0.15%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
786597
     0.15%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8221ad
     0.15%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
8c9091
     0.15%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d1ed1
     0.14%     0.00%  perf     [kernel.kallsyms]           [k] kasan_save_s=
tack
     0.14%     0.00%  perf     [kernel.kallsyms]           [k] stack_trace_=
save
     0.14%     0.14%  perf     [kernel.kallsyms]           [k] memset_orig
     0.14%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e995b
     0.14%     0.07%  perf     [kernel.kallsyms]           [k] __might_resc=
hed
     0.14%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
84aac8
     0.14%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
a71c89
     0.14%     0.13%  perf     [kernel.kallsyms]           [k] __lock_relea=
se.isra.0
     0.14%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80a099
     0.14%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
851005
     0.13%     0.00%  perf     [kernel.kallsyms]           [k] __kasan_slab=
_free
     0.13%     0.00%  perf     [kernel.kallsyms]           [k] kasan_save_f=
ree_info
     0.13%     0.00%  perf     [kernel.kallsyms]           [k] kasan_save_t=
rack
     0.13%     0.13%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:LargeMmapAllocator<__asan::AsanMapUnmapCallback, __sanitizer::LargeMmapAll=
ocatorPtrArrayDynamic, __sanitizer::LocalAddressSpaceView>::GetBlockBeginFa=
stLocked(void*)
     0.13%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e9931
     0.13%     0.00%  perf     libasan.so.8.0.0            [.] __asan::Init=
ializeAsanInterceptors()
     0.13%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80f4ac
     0.13%     0.00%  perf     libasan.so.8.0.0            [.] __intercepto=
r_pthread_create
     0.13%     0.00%  perf     libc.so.6                   [.] pthread_crea=
te
     0.13%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2de704
     0.13%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
57e417
     0.13%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9afe21
     0.13%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
448191
     0.13%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c25b70
     0.12%     0.12%  perf     [kernel.kallsyms]           [k] __asan_store=
4_noabort
     0.12%     0.00%  perf     [kernel.kallsyms]           [k] __mem_cgroup=
_uncharge_folios
     0.12%     0.00%  perf     [kernel.kallsyms]           [k] free_pgtable=
s
     0.12%     0.08%  perf     [kernel.kallsyms]           [k] __mod_memcg_=
lruvec_state
     0.12%     0.12%  perf     [kernel.kallsyms]           [k] rcu_is_watch=
ing
     0.12%     0.12%  perf     [kernel.kallsyms]           [k] debug_lockde=
p_rcu_enabled
     0.12%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
43a9f7
     0.12%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
858cda
     0.12%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c64597
     0.12%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447e9e
     0.12%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8ddc
     0.12%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fb3a43
     0.12%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7fcdd4
     0.12%     0.00%  perf     libc.so.6                   [.] 0x00007f22a4=
9fdd6b
     0.12%     0.00%  perf     libc.so.6                   [.] 0x00007f22a4=
a7e828
     0.12%     0.00%  perf     libc.so.6                   [.] 0x00007f22a4=
a7e7b0
     0.12%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
342fea
     0.12%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5d49cd
     0.12%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9daec8
     0.12%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
73591c
     0.12%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
72cf48
     0.12%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
72ca3c
     0.12%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:AddModuleSegments(char const*, dl_phdr_info*, __sanitizer::InternalMmapVec=
torNoCtor<__sanitizer::LoadedModule>*) [clone .part.0]
     0.12%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
342d61
     0.12%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
57e48b
     0.12%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
784d1f
     0.11%     0.01%  perf     libasan.so.8.0.0            [.] __asan::Allo=
cator::QuarantineChunk(__asan::AsanChunk*, void*, __sanitizer::BufferedStac=
kTrace*) [clone .isra.0]
     0.11%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85879f
     0.11%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8fe231
     0.11%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80a061
     0.11%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8ca030
     0.11%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:StackDepotPut(__sanitizer::StackTrace)
     0.11%     0.03%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:internal_memset(void*, int, unsigned long)
     0.11%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
848b70
     0.11%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
846e4f
     0.11%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c917c
     0.11%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fb0580
     0.11%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fae983
     0.11%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8471e8
     0.11%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
84ab07
     0.11%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
33d87b
     0.11%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
439567
     0.10%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
906103
     0.10%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fb0887
     0.10%     0.00%  perf     [kernel.kallsyms]           [k] __page_cache=
_release
     0.10%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
76d1de
     0.10%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
82ba8c
     0.10%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fb2d10
     0.10%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
905904
     0.10%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8960
     0.10%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4459ff
     0.10%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
849450
     0.10%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c9068
     0.10%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
848891
     0.10%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
33d8a8
     0.10%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:LoadedModule::set(char const*, unsigned long)
     0.10%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:internal_strdup(char const*)
     0.10%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44626a
     0.09%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
804c1a
     0.09%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4e0b3d
     0.09%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
33d76b
     0.09%     0.00%  perf     [kernel.kallsyms]           [k] uncharge_fol=
io
     0.09%     0.00%  perf     [kernel.kallsyms]           [k] unlink_anon_=
vmas
     0.09%     0.00%  perf     [kernel.kallsyms]           [k] free_frozen_=
page_commit
     0.09%     0.09%  perf     [kernel.kallsyms]           [k] validate_cha=
in
     0.09%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446614
     0.09%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
495475
     0.09%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
84848b
     0.09%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
850fcd
     0.09%     0.08%  perf     [kernel.kallsyms]           [k] mark_usage
     0.09%     0.00%  perf     [unknown]                   [k] 0xffffffff82=
c151fc
     0.09%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c9198
     0.09%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
276d34
     0.09%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
94a79c
     0.09%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9763d6
     0.09%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
276d45
     0.09%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c918f
     0.09%     0.09%  perf     [kernel.kallsyms]           [k] __list_del_e=
ntry_valid_or_report
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7664a3
     0.08%     0.00%  perf     libasan.so.8.0.0            [.] __lsan::ForE=
achChunk(void (*)(unsigned long, void*), void*)
     0.08%     0.03%  perf     libasan.so.8.0.0            [.] __lsan::GetU=
serBegin(unsigned long)
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
736859
     0.08%     0.00%  perf     [kernel.kallsyms]           [k] lru_gen_upda=
te_size
     0.08%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
2dea72
     0.08%     0.01%  perf     [kernel.kallsyms]           [k] __memcg_slab=
_free_hook
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80f1ea
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8ce8
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
ea994d
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
786625
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446285
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4477d8
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4469e9
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7887db
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c9172
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
766440
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8b88
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8985
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446b26
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8ff852
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8db5
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c9185
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4e079
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9059e8
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2df6ba
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
395167
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c10854
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5d49b2
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
a71ba4
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
821a41
     0.08%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] 0x00007f229a=
b66f10
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c632a
     0.07%     0.07%  perf     [kernel.kallsyms]           [k] asm_exc_page=
_fault
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
000b90
     0.07%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
8c8d30
     0.07%     0.00%  perf     [kernel.kallsyms]           [k] __vm_area_fr=
ee
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44447f
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
494911
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
808372
     0.07%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fb3920
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c100b8
     0.07%     0.07%  perf     [kernel.kallsyms]           [k] __rcu_read_u=
nlock
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446456
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44650a
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447660
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c896a
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4465b5
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447f6a
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445f15
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
908a52
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7fce6a
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c899b
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c9030
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81e1d2
     0.07%     0.00%  perf     libasan.so.8.0.0            [.] __intercepto=
r_free.part.0
     0.07%     0.07%  perf     [kernel.kallsyms]           [k] __rcu_read_l=
ock
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
395205
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
653061
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447051
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
878331
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
73cd99
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
730b0e
     0.06%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] 0x00007f229a=
bad806
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
730b17
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c20b0c
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
877100
     0.06%     0.00%  perf     libasan.so.8.0.0            [.] __intercepto=
r_realloc.part.0
     0.06%     0.00%  perf     libasan.so.8.0.0            [.] __asan::asan=
_realloc(void*, unsigned long, __sanitizer::BufferedStackTrace*)
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
804a0b
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
804eca
     0.06%     0.06%  perf     [kernel.kallsyms]           [k] get_mem_cgro=
up_from_mm
     0.06%     0.04%  perf     libasan.so.8.0.0            [.] __asan_unreg=
ister_globals
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7fce65
     0.06%     0.00%  perf     libasan.so.8.0.0            [.] __lsan::Coll=
ectIgnoredCb(unsigned long, void*)
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4fcdf6
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4e41f9
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3ea21e
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4e04a
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
444514
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
736814
     0.06%     0.02%  perf     [kernel.kallsyms]           [k] __free_one_p=
age
     0.06%     0.00%  perf     [kernel.kallsyms]           [k] free_pcppage=
s_bulk
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
788683
     0.06%     0.01%  perf     [kernel.kallsyms]           [k] unwind_get_r=
eturn_address
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c904d
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
76d1ba
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8578fc
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
76d202
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446856
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44689b
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4eb34
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8ff8ab
     0.06%     0.01%  perf     [kernel.kallsyms]           [k] __kernel_tex=
t_address
     0.05%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:internal_allocator() [clone .part.0]
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
444570
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446041
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446495
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7662ef
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4459b3
     0.05%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fb23ef
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80f4a1
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9727d7
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
94ae79
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2130ce
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8bd0
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8b2afc
     0.05%     0.00%  perf     libasan.so.8.0.0            [.] __intercepto=
r___cxa_atexit
     0.05%     0.00%  perf     libc.so.6                   [.] 0x00007f22a4=
9b2e83
     0.05%     0.00%  perf     libc.so.6                   [.] 0x00007f22a4=
9b2dfa
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
875a04
     0.05%     0.05%  perf     [kernel.kallsyms]           [k] stack_depot_=
save_flags
     0.05%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] g_malloc
     0.05%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] g_hash_table=
_new_full
     0.05%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] g_slice_allo=
c
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447eee
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c107be
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2ec69a
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8113db
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c611b
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
90738f
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8c7c
     0.05%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
8c673a
     0.05%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
8caba1
     0.05%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
8ca540
     0.05%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
2de585
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
804ebf
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4df412
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c64444
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3ea236
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
444549
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3ea22e
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4ec22
     0.04%     0.00%  perf     [kernel.kallsyms]           [k] kernel_text_=
address
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4463e5
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c3fe03
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
78624e
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4f211
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4eb31
     0.04%     0.04%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
00e26c
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
495482
     0.04%     0.04%  perf     [kernel.kallsyms]           [k] mtree_range_=
walk
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44781b
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8ca038
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85d999
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c6458
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8ca373
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8d9a
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4a16b0
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447613
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7fcf00
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5d494f
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4eb7a
     0.04%     0.04%  perf     [kernel.kallsyms]           [k] match_held_l=
ock
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4465ee
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4475fe
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447eb8
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4468ca
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
844de3
     0.04%     0.03%  perf     [kernel.kallsyms]           [k] __orc_find
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c258b0
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c64758
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
788948
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
76452b
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2df12d
     0.04%     0.04%  perf     [kernel.kallsyms]           [k] __asan_store=
1_noabort
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2de341
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4467c2
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
847179
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
908a94
     0.04%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
faedf7
     0.04%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fca930
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4d3784
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81e1a2
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85a1ca
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
906c93
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
900e5d
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4477f2
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c1b1fd
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4469c3
     0.04%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
51a0ef
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
975fe9
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7fce0a
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
84607a
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
84937d
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
76a985
     0.04%     0.04%  perf     [kernel.kallsyms]           [k] seq_put_hex_=
ll
     0.04%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] g_malloc0
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
21312d
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c5d5b2
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7303be
     0.04%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
394f08
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447870
     0.04%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
57b6de
     0.04%     0.00%  perf     libLLVM-14.so.1             [.] polly::initi=
alizePollyPasses(llvm::PassRegistry&)
     0.04%     0.00%  perf     libc.so.6                   [.] 0x00007f22a4=
a02fa5
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
821900
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
849878
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
848119
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
808bfe
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8349e4
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4eb35
     0.04%     0.00%  perf     perf                        [.] __asan_unreg=
ister_globals@plt
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446240
     0.04%     0.00%  perf     libasan.so.8.0.0            [.] operator del=
ete(void*)
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4459e2
     0.03%     0.03%  perf     [kernel.kallsyms]           [k] lockdep_hard=
irqs_on
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
517343
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
516e8b
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4df772
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d1f2e
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4ddeee
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
509c08
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
50235c
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447076
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4f3e1
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8d98
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446aba
     0.03%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:InternalMmapVectorNoCtor<unsigned long>::push_back(unsigned long const&)
     0.03%     0.00%  perf     libasan.so.8.0.0            [.] __lsan::Floo=
dFillTag(__sanitizer::InternalMmapVector<unsigned long>*, __lsan::ChunkTag)=
 [clone .constprop.0]
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4ebbf
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
72e909
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
53e6c0
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c64657
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
48d4cf
     0.03%     0.00%  perf     [kernel.kallsyms]           [k] __is_insn_sl=
ot_addr
     0.03%     0.00%  perf     [kernel.kallsyms]           [k] __put_anon_v=
ma
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3c0454
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c6434a
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c100af
     0.03%     0.03%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
00e265
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445970
     0.03%     0.02%  perf     [kernel.kallsyms]           [k] __list_add_v=
alid_or_report
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c3fd12
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
494eef
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85852b
     0.03%     0.03%  perf     [kernel.kallsyms]           [k] __mod_node_p=
age_state
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44449a
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44679a
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
906127
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8faf6c
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446832
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
48d4ba
     0.03%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4ec00
     0.03%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.03%     0.00%  perf     perf                        [.] symbol__init=
_regexpr
     0.03%     0.00%  perf     libasan.so.8.0.0            [.] __intercepto=
r_regcomp.part.0
     0.03%     0.00%  perf     libc.so.6                   [.] regcomp
     0.03%     0.03%  perf     [kernel.kallsyms]           [k] __count_memc=
g_events
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
494942
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446740
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44663c
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8ff915
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8219e5
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
821355
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
820dc4
     0.03%     0.01%  perf     [kernel.kallsyms]           [k] tlb_finish_m=
mu
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8ce4
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
845d5f
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
845431
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c644a8
     0.03%     0.01%  perf     [kernel.kallsyms]           [k] mod_objcg_st=
ate
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
82b52b
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3b8646
     0.03%     0.03%  perf     [kernel.kallsyms]           [k] __asan_load2=
_noabort
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2de719
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4478ff
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
494f02
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44677b
     0.03%     0.03%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
00e24e
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
439532
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c9188
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446aca
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44688f
     0.03%     0.03%  perf     [kernel.kallsyms]           [k] find_held_lo=
ck
     0.03%     0.03%  perf     [kernel.kallsyms]           [k] stack_access=
_ok
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44633d
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
763db1
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
76aaed
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80823b
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7ff728
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
834181
     0.03%     0.02%  perf     [kernel.kallsyms]           [k] orc_find.par=
t.0
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2de579
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44782d
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4466b6
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446aa9
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80f388
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7ffc63
     0.03%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
faf4ae
     0.03%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fca6f0
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
95e855
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
95e797
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
95d908
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9754d1
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
97495f
     0.03%     0.03%  perf     [kernel.kallsyms]           [k] filemap_map_=
pages
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446013
     0.03%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fb21d5
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c18d89
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c268a1
     0.03%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fb3c84
     0.03%     0.00%  perf     libc.so.6                   [.] 0x00007f22a4=
9f9f4c
     0.03%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
56798a
     0.03%     0.00%  perf     libLLVM-14.so.1             [.] std::_Rb_tre=
e_iterator<std::pair<std::__cxx11::basic_string<char, std::char_traits<char=
>, std::allocator<char> > const, unsigned int> > std::_Rb_tree<std::__cxx11=
::basic_string<char, std::char_traits<char>, std::allocator<char> >, std::p=
air<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator=
<char> > const, unsigned int>, std::_Select1st<std::pair<std::__cxx11::basi=
c_string<char, std::char_traits<char>, std::allocator<char> > const, unsign=
ed int> >, std::less<std::__cxx11::basic_string<char, std::char_traits<char=
>, std::allocator<char> > >, std::allocator<std::pair<std::__cxx11::basic_s=
tring<char, std::char_traits<char>, std::allocator<char> > const, unsigned =
int> > >::_M_insert_<std::pair<std::__cxx11::basic_string<char, std::char_t=
raits<char>, std::allocator<char> > const, unsigned int> const&, std::_Rb_t=
ree<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator=
<char> >, std::pair<std::__cxx11::basic_string<char, std::char_traits<char>=
, std::allocator<char> > const, unsigned int>, std::_Select1st<std::pair<st=
d::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>=
 > const, unsigned int> >, std::less<std::__cxx11::basic_string<char, std::=
char_traits<char>, std::allocator<char> > >, std::allocator<std::pair<std::=
__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > =
const, unsigned int> > >::_Alloc_node>(std::_Rb_tree_node_base*, std::_Rb_t=
ree_node_base*, std::pair<std::__cxx11::basic_string<char, std::char_traits=
<char>, std::allocator<char> > const, unsigned int> const&, std::_Rb_tree<s=
td::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char=
> >, std::pair<std::__cxx11::basic_string<char, std::char_traits<char>, std=
::allocator<char> > const, unsigned int>, std::_Select1st<std::pair<std::__=
cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > co=
nst, unsigned int> >, std::less<std::__cxx11::basic_string<char, std::char_=
traits<char>, std::allocator<char> > >, std::allocator<std::pair<std::__cxx=
11::basic_string<char, std::char_traits<char>, std::allocator<char> > const=
, unsigned int> > >::_Alloc_node&)
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
857bdd
     0.03%     0.00%  perf     libasan.so.8.0.0            [.] __intercepto=
r_strlen.part.0
     0.03%     0.00%  perf     libc.so.6                   [.] 0x00007f22a4=
adc7c0
     0.03%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fb062a
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446673
     0.03%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fb09ac
     0.03%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fcb740
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2dde6c
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2de6b1
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9da5c5
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
73516d
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
87635e
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4477bd
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
804b70
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446c5c
     0.03%     0.03%  perf     [kernel.kallsyms]           [k] clear_page_e=
rms
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85d9f5
     0.03%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
50d27f
     0.03%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
76faab
     0.03%     0.00%  perf     libLLVM-14.so.1             [.] llvm::cl::ge=
tGeneralCategory()
     0.03%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
5f9f5e
     0.03%     0.00%  perf     libLLVM-14.so.1             [.] llvm::Manage=
dStaticBase::RegisterManagedStatic(void* (*)(), void (*)(void*)) const
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2111d8
     0.03%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:OpenFile(char const*, __sanitizer::FileAccessMode, int*)
     0.03%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:internal_open(char const*, int, unsigned int)
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
94ad2d
     0.03%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] g_hash_table=
_insert
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
a70acd
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9b0df2
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
e7f2f2
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e9727
     0.03%     0.00%  perf     libc.so.6                   [.] dlerror
     0.03%     0.00%  perf     libc.so.6                   [.] __asprintf
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8105ac
     0.03%     0.00%  perf     libbabeltrace-ctf.so.1.0.0  [.] 0x00007f229d=
4de2c7
     0.03%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] g_quark_from=
_string
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
72b5aa
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2de749
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5d48bc
     0.03%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
580d22
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4d3768
     0.03%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fcc2e0
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
87715e
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c950a
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c6269
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2ee1f3
     0.03%     0.00%  perf     libLLVM-14.so.1             [.] llvm::PassRe=
gistry::registerPass(llvm::PassInfo const&, bool)
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
730956
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2df1a3
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
76a8bf
     0.03%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
2deadf
     0.03%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
872f8c
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
805028
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446586
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8fe2ce
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
516d90
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] clockevents_=
program_event
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4fcd80
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4a16f5
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
736879
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] intel_pmu_di=
sable_all
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
72e992
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2206ec
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3e967e
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] update_cfs_g=
roup
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d1e32
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3be554
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d1d8d
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4dde6c
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
500ffd
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4e420a
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4ddefa
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4a969e
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4a54c3
     0.02%     0.01%  perf     [kernel.kallsyms]           [k] lockdep_hard=
irqs_on_prepare
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
495468
     0.02%     0.01%  perf     [kernel.kallsyms]           [k] cgroup_rstat=
_updated
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8b84
     0.02%     0.00%  perf     [kernel.kallsyms]           [k] task_work_ru=
n
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8bb4
     0.02%     0.00%  perf     [kernel.kallsyms]           [k] __call_rcu_c=
ommon.constprop.0
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446357
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
902b2e
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7c4087
     0.02%     0.02%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
00e309
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c6465f
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4465dd
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4ebbb
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
444460
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80fe45
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85f791
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] mas_walk
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] down_write
     0.02%     0.02%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
00e305
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c3f640
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
763da8
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8c80
     0.02%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44702b
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4f20c
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5d4a09
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c90ea
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9059db
     0.02%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.02%     0.02%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
00e24b
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c5035a
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7c0659
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8c3a
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
730973
     0.02%     0.01%  perf     [kernel.kallsyms]           [k] rcu_read_unl=
ock
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4468bd
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] do_raw_spin_=
lock
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] cond_accept_=
memory
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85d303
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44763f
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
804ce8
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] charge_memcg
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
76e0b7
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8c08
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
844ded
     0.02%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4475d2
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4464e2
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4e09cd
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4e6571
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8ff7cc
     0.02%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
9072d1
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] irqentry_exi=
t_to_user_mode
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] asm_sysvec_a=
pic_timer_interrupt
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
000df0
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447f04
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44636f
     0.02%     0.00%  perf     libasan.so.8.0.0            [.] __asan::OnLo=
wLevelAllocate(unsigned long, unsigned long)
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4eae0
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] access_error
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e97c7
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445f5e
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
847bd0
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c909e
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4e768
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c3fdfa
     0.02%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4463b1
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
57e490
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
72631f
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8cef
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8a0b
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446762
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
33c34a
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] lockdep_hard=
irqs_off
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44669c
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
784da2
     0.02%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:CloseFile(int)
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
945240
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c899f
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447627
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8a40
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446081
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4ebb6
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c1159f
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
76ab0d
     0.02%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c25af1
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4464cd
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2de6dd
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4462da
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
213125
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
228d4d
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4a1690
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c9046
     0.02%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fb4c64
     0.02%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fb472c
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8ff6e3
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4ea2a
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2de56d
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
971e29
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
844d59
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4461f5
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c115a8
     0.02%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
faf2bd
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2de685
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447ea6
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c56865
     0.02%     0.00%  perf     libasan.so.8.0.0            [.] sched_yield@=
plt
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3fb6aa
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8fd0a6
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
211190
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
972486
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
96a8ad
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
98c22a
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
986490
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
986061
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c18a29
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
871f90
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8483f1
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446650
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c5d765
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] rcu_lockdep_=
current_cpu_online
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
48d9ea
     0.02%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fb16b3
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3b83dd
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2ec68a
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] trace_irq_en=
able.constprop.0
     0.02%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:InternalScopedString::append(char const*, ...)
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446a0e
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5011b0
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4e5ffc
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2dde49
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9b172a
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85f7e1
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8c30
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
600d1d
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
5fcf36
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
228970
     0.02%     0.00%  perf     libbabeltrace-ctf.so.1.0.0  [.] 0x00007f229d=
4de1eb
     0.02%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] g_quark_from=
_static_string
     0.02%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] 0x00007f229a=
b89e3a
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
513822
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9daa83
     0.02%     0.00%  perf     libasan.so.8.0.0            [.] __intercepto=
r___getdelim.part.0
     0.02%     0.00%  perf     libc.so.6                   [.] __getdelim
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
50e52e
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44b94b
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8d90
     0.02%     0.00%  perf     libc.so.6                   [.] 0x00007f22a4=
9f3328
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
a70a25
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
50eb4a
     0.02%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] 0x00007f229a=
bad771
     0.02%     0.00%  perf     libnuma.so.1.0.0            [.] 0x00007f229d=
529a8c
     0.02%     0.00%  perf     libnuma.so.1.0.0            [.] numa_node_si=
ze64
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80aae4
     0.02%     0.00%  perf     libnuma.so.1.0.0            [.] 0x00007f229d=
529966
     0.02%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] 0x00007f229a=
bbb2ed
     0.02%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:LoadedModule::addAddressRange(unsigned long, unsigned long, bool, bool, ch=
ar const*)
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] __up_read
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] page_ref_add=
_unless.constprop.0
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c44339
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
845d42
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447f26
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
76445b
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4468ff
     0.02%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fb30c5
     0.02%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fb2bd2
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] do_user_addr=
_fault
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] llvm::initia=
lizeCodeGenerationPass(llvm::PassRegistry&)
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f22a1=
35ba47
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] llvm::initia=
lizeDependenceInfoPass(llvm::PassRegistry&)
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f22a1=
2fca87
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] llvm::initia=
lizeScopInfoRegionPassPass(llvm::PassRegistry&)
     0.02%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
962c22
     0.02%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
962836
     0.02%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
962544
     0.02%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
962105
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7262eb
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c1b035
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81019b
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
efef2c
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
84a3ed
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
579afd
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] llvm::Regex:=
:Regex(llvm::StringRef, llvm::Regex::RegexFlags)
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] llvm_regcomp
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
76451e
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80ef57
     0.02%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
8c8de0
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
902524
     0.02%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
877ac9
     0.02%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
85a6bf
     0.02%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
855c8f
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
902d3b
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
a3e506
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
20bf94
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
81d543
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446522
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
84a5f8
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] lock_vma_und=
er_rcu
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80a025
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7882f2
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] task_mm_cid_=
work
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3bf691
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3bf6c6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4e74e
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] __local_bh_e=
nable
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
353ef4
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
352ed0
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] update_dl_rq=
_load_avg
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3f5c21
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3defb8
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
40d30b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
40bfb5
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4e0b0b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4dee8b
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] __kasan_chec=
k_write
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
e85179
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8ca050
     0.01%     0.00%  perf     libc.so.6                   [.] 0x00007f22a4=
9fdfb0
     0.01%     0.00%  perf     libc.so.6                   [.] 0x00007f22a4=
9fb44f
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __asan::Asan=
Thread::Destroy()
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81ed07
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81ddb7
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8838d0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
788393
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
787ac4
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c905c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
72e93e
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446051
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] __x2apic_sen=
d_IPI_dest
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2cba29
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] __calc_delta=
.constprop.0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3e96ba
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d3d3f
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] idle_cpu
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d374f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
413d70
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447e23
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4f9068
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3f6266
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] kick_ilb
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d3848
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d1ef1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
394b80
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4df457
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] llist_add_ba=
tch
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
e8514c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3f67b7
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
48d9ff
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3f5e58
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447839
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4de9d9
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4fce43
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4de9b6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446b21
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4de9a0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8ca034
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] sched_balanc=
e_trigger
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3f671d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44bbbe
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
72e989
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] raw_spin_rq_=
unlock
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3c0606
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4477bf
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3e9c4b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4e09af
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4464b8
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
53f76d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3f6716
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] irq_work_tic=
k
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4ddf1b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
64bec1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3dd810
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
40ae5f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3e9e21
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44be8f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
53f74a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3540d7
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
413ef5
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3dd789
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
736842
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] update_irq_l=
oad_avg
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
40cea6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
40d61f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
429020
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
49548b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447df0
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] update_load_=
avg
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3dd849
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] update_curr
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3e946f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d1e73
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4ebb4
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
49828f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
40d0ca
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3f8e21
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3e9ddb
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44635b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3e9d7e
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] lock_pin_loc=
k
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d1dc7
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
43d268
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
58df23
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3f617d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4982c3
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] update_min_v=
runtime
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3e9549
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d2b76
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3f6778
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
877d52
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
907933
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
902967
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8fdc11
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44786a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2de61b
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] __fput
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
849436
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c2829a
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] trace_hardir=
qs_on
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8fd27a
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] is_bpf_text_=
address
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] trace_hardir=
qs_off
     0.01%     0.00%  perf     perf                        [.] perf_config_=
_exit
     0.01%     0.00%  perf     perf                        [.] perf_config_=
set__delete
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8fd262
     0.01%     0.01%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
009964
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446790
     0.01%     0.01%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
009070
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
20b038
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
35039c
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
34ff5e
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
51ca8b
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff82=
c21934
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff82=
c20d89
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c101e5
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __lsan::Mark=
IndirectlyLeakedCb(unsigned long, void*)
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
43cd4b
     0.01%     0.01%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:IncreaseTotalMmap(unsigned long)
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:SuspendedThreadsListLinux::GetRegistersAndSP(unsigned long, __sanitizer::I=
nternalMmapVector<unsigned long>*, unsigned long*) const
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:SuspendedThreadsListLinux::GetRegistersAndSP(unsigned long, __sanitizer::I=
nternalMmapVector<unsigned long>*, unsigned long*) const::{lambda(unsigned =
long)#1}::operator()(unsigned long) const
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] free_swap_ca=
che
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] unlink_file_=
vma_batch_add
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] unlink_file_=
vma_batch_process
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] vma_interval=
_tree_remove
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] kasan_record=
_aux_stack
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] __mod_zone_p=
age_state
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5d48ca
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c1166a
     0.01%     0.01%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
008d78
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44bc53
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __lsan::Rese=
tTagsCb(unsigned long, void*)
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80a03e
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] kasan_byte_a=
ccessible
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] check_slab_a=
llocation
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
908a2f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
494ee0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7665a0
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] uncharge_bat=
ch
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446a4e
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] free_pgd_ran=
ge
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] free_p4d_ran=
ge
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] free_pud_ran=
ge
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] folio_mark_a=
ccessed
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] static_key_c=
ount
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
847fab
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
cdacda
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
759738
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
902ce7
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4d380d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7882cc
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447838
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8086cf
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446565
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446176
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80553f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8d94
     0.01%     0.01%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
008e32
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4f1dd
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3bf6f9
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446441
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] _raw_spin_un=
lock_irqrestore
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
788679
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] alloc_anon_f=
olio
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446b08
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446842
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80fe40
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446451
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80f9ed
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
781e72
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2df1b0
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] mas_wr_slot_=
store
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c1bf30
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446851
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c1020c
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8083f3
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7fce45
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4a16cb
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] stack_trace_=
consume_entry
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7882b8
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c446ec
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446725
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c1153f
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4466b1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c11642
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80a16e
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446d03
     0.01%     0.01%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
00ea40
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fc887c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9da4ed
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446168
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] trace_irq_di=
sable.constprop.0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4e5b4
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5d47ba
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8fcc6d
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] get_page_fro=
m_freelist
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85d318
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4459e8
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4393d4
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.01%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
00994a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4ea8b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85d8a9
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445a4e
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447637
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
906084
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] rmqueue_bulk
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
857b04
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7f8501
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] exc_page_fau=
lt
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4e568
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e8fe0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7662c6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4e540
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4f163
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5d472c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81d258
     0.01%     0.01%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
008d9d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e9642
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
858598
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7864d9
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e9a40
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
788aee
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446773
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8fcda2
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] folio_add_fi=
le_rmap_ptes
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
830aba
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4eb72
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9059a8
     0.01%     0.01%  perf     libc.so.6                   [.] 0x0000000000=
1646c0
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447e4b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
788272
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4469f1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
902d50
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85d615
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
82b72d
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
ea9942
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80f9fe
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7f9b2b
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] down_write_k=
illable
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8ff879
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4473be
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80f94b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4475b4
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
76e0dc
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
439318
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e990e
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81b0e5
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
788821
     0.01%     0.01%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
00e35a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80a364
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4469b1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8c55
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
854bc0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446922
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
788590
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9044e7
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] getname_flag=
s.part.0
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:CacheBinaryName()
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:ReadBinaryName(char*, unsigned long)
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
95ce26
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
95cb49
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
96a200
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9060bd
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85f537
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c10030
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
788858
     0.01%     0.01%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:internal_memcpy(void*, void const*, unsigned long)
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] __might_slee=
p
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c5d742
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3b86c0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c446e2
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44597e
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4eb22
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4459a0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
902cf2
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
76d20e
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:ReadProcessName(char*, unsigned long) [clone .constprop.0] [clone .isra.0]
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:ReadLongProcessName(char*, unsigned long)
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
877adc
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
395154
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
595a85
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5959da
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4ec24
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
76a894
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447f7c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7662a2
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
854bd5
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7fce70
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2dde5a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c3f7f3
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8083e3
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
786385
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
ea9815
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] mas_rev_awal=
k
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __asan::Init=
ializeFlags()
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:FlagParser::FlagParser()
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81af0c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81a1c6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
26033c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
819e14
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
84d56b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c23662
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c22fc6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
90611a
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
84882b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c5d5ed
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] trace_rcu_ut=
ilization
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4a36a4
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] kasan_poison
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8ca1a0
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] lru_add
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
78663b
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7664b5
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447e99
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446887
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8fe20e
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446299
     0.01%     0.00%  perf     libc.so.6                   [.] 0x00007f22a4=
a5fa02
     0.01%     0.00%  perf     libc.so.6                   [.] 0x00007f22a4=
a57971
     0.01%     0.00%  perf     libc.so.6                   [.] 0x00007f22a4=
a52ee0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
43a420
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] folio_add_ne=
w_anon_rmap
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
830657
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85f7a0
     0.01%     0.01%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
00e26f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
877986
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
830a62
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4f365
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
75d9b3
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
75d65c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
75d25a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7f82b0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445a06
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4ec14
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7fcdee
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] d_path
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9dae83
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
494efd
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
766494
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4464c8
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e997b
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7303eb
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4464b3
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447f0d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8ff772
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
810426
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     libc.so.6                   [.] 0x00007f22a4=
a5fe0d
     0.01%     0.00%  perf     libc.so.6                   [.] 0x00007f22a4=
a5623a
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] unlink_file_=
vma_batch_final
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7ffa9f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
84a0f6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8ff7b7
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
76e07a
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44818c
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447e45
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7c0704
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
43a16e
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     perf                        [.] perf_config
     0.01%     0.00%  perf     perf                        [.] perf_config_=
_init
     0.01%     0.00%  perf     perf                        [.] perf_config_=
set__new
     0.01%     0.00%  perf     perf                        [.] perf_config_=
set__init
     0.01%     0.00%  perf     perf                        [.] perf_etc_per=
fconfig
     0.01%     0.00%  perf     perf                        [.] system_path
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __intercepto=
r_asprintf
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __intercepto=
r_vasprintf
     0.01%     0.00%  perf     libc.so.6                   [.] 0x00007f22a4=
9f3442
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
804ea2
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
82acef
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2ef8a2
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
516ad0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5169c3
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2ef28f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8964
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8ff6c0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
858d41
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4477a0
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.01%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c10111
     0.01%     0.01%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
009019
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4475da
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c15f42
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c8968
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8fccc7
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446a61
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
8478a6
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff82=
c219e2
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
82bae7
     0.01%     0.01%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
008dda
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     perf                        [.] setup_path
     0.01%     0.00%  perf     perf                        [.] astrcat
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
804cc0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3b85ef
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
784d24
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4468f5
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] _dl_allocate=
_tls
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fbac5d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
805988
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4a16d7
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
806223
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
87585e
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
43cd34
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c50356
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8fe2be
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7c4016
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
902d5d
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80f137
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44be75
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4f21f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445a1f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
763cc3
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] timekeeping_=
advance
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4e34d3
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446319
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] __tlb_remove=
_folio_pages_size.constprop.0
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] __pte_offset=
_map_lock
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] ___pte_offse=
t_map
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
76638c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2de09a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446a44
     0.01%     0.01%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
012b6e
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fb218e
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fbd3c7
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fbcd45
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fbcb60
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
764412
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c44337
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:MmapAlignedOrDieOnFatalError(unsigned long, unsigned long, char const*)
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
804017
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
444586
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2de72b
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fac66f
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
faf92f
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fcc0c0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2deb54
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
847776
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8ffa08
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
821de0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81ee29
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2ef8a3
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3de162
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
40a61c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446a46
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80f44b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7f87de
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c10097
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
57e474
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4ec27
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4476cd
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2de356
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445a2f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85f667
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85d5df
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e9071
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80f89c
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fc7ad4
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fc23dc
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fc5623
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fbcb1b
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fbc200
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
875895
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3f5f99
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
84ab23
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2deb12
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
276daf
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81d27d
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
faee33
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fca9b0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9511b9
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
76a2cd
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
769bbd
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
769759
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
764465
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4ec1c
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] mas_topiary_=
replace
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c22c18
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c1f658
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2df49f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8ca08f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
97607a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
970898
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
94a086
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
946dfd
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
e742d9
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
848bc6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8f5885
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9897bb
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44bc3d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
87226b
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] clear_bhb_lo=
op
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
001748
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8fd14f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445ef4
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c89a3
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
857a6f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
976009
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
877ab1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2df196
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] xas_find
     0.01%     0.00%  perf     libc.so.6                   [.] 0x00007f22a4=
9fa510
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c40b3d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80e9a0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446a69
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446c57
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
98965c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
987466
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
834b9b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4462be
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] llvm::Regex:=
:~Regex()
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] llvm_regfree
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81ecf5
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c55a9e
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3ba62a
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] vma_merge_ne=
w_range
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
848a96
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44764f
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
5588e7
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] kmem_cache_a=
lloc_lru_noprof
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8761b6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c55ac6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
eff072
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
56255a
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f22a0=
84acdf
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
72b5a2
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9afe38
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9aef59
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
558830
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f22a0=
912880
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4eae7
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2de0ba
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
875f3e
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
536189
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
a2d7bb
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
a2d993
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
a2dc01
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
a2de3f
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] std::_Rb_tre=
e_iterator<std::pair<std::__cxx11::basic_string<char, std::char_traits<char=
>, std::allocator<char> > const, unsigned int> > std::_Rb_tree<std::__cxx11=
::basic_string<char, std::char_traits<char>, std::allocator<char> >, std::p=
air<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator=
<char> > const, unsigned int>, std::_Select1st<std::pair<std::__cxx11::basi=
c_string<char, std::char_traits<char>, std::allocator<char> > const, unsign=
ed int> >, std::less<std::__cxx11::basic_string<char, std::char_traits<char=
>, std::allocator<char> > >, std::allocator<std::pair<std::__cxx11::basic_s=
tring<char, std::char_traits<char>, std::allocator<char> > const, unsigned =
int> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tu=
ple<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator=
<char> > const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<std=
::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> =
> const, unsigned int> >, std::piecewise_construct_t const&, std::tuple<std=
::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> =
> const&>&&, std::tuple<>&&)
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
788883
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
53c15f
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f22a0=
373b19
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
494ec8
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
55c100
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f22a0=
920fd0
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
53a14a
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
53dbab
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f22a0=
755790
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
54bcc5
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8fe248
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
544428
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f22a0=
86fea0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
76aa65
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
534d42
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229f=
ee5058
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
766387
     0.01%     0.01%  perf     libLLVM-14.so.1             [.] 0x0000000000=
d17ff7
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
54fa40
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
537d8f
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
964aed
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4463a4
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446719
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44632f
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] mas_wr_store=
_type
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c158dd
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
53360e
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229f=
b9fc80
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
72b5e2
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4a16be
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] percpu_count=
er_add_batch
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8040e3
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
803a77
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
803169
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
802b32
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
ef23a6
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
531f23
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8107d7
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80a774
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9069fb
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8fe139
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fb18b2
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
eff06c
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
530452
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229f=
9e9580
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2de695
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] refill_stock
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8fd164
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
a71c77
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9af38c
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] perf_event__=
header_size
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
73ceef
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
720c34
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2deb29
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
73ceff
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c644c0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5d4809
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4e843
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
788420
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
909216
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
900aa6
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
518dd5
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
f740d0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44755a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
855309
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8538e9
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446026
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
50cfbb
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
614220
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2deac6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9daa6e
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
600c59
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
870fe4
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2289a5
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
448f0e
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c89d0
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:InitTlsSize()
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:GetLibcVersion(int*, int*, int*)
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __intercepto=
r_confstr.part.0
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __asan::Quic=
kCheckForUnpoisonedRegion(unsigned long, unsigned long)
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] get_vma_poli=
cy
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8b299f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8b1e39
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
eff074
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
52eb2e
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
87696f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2de67d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
902952
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8fdbc5
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c89f5
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
51a632
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
a2d767
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
517565
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
cc33f0
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2df110
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8717f6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
870c00
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
870ae7
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
874df7
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
5151b7
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
c4e9e0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
76aaa5
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
84a2fe
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] hash_name
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9726b7
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
968eb2
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
975fab
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
972b5a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
97170a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
98cc10
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
730394
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
972765
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9723db
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] look_up_lock=
_class
     0.01%     0.00%  perf     libnuma.so.1.0.0            [.] 0x00007f229d=
529bf2
     0.01%     0.00%  perf     libc.so.6                   [.] _IO_file_und=
erflow
     0.01%     0.00%  perf     libc.so.6                   [.] _IO_file_rea=
d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9b07e3
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c593da
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446388
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
448657
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4e950
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9b0c80
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
a72091
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
975f53
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
954caa
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
834b43
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2deaaf
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] mm_find_pmd
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
84711b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8e5e42
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
82fd26
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] ___slab_allo=
c
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __asan::Init=
ializeAllocator(__asan::AllocatorOptions const&)
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8710c8
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9b1795
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
906df9
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446a17
     0.01%     0.00%  perf     libtraceevent.so.1.7.1      [.] 0x00007f229c=
bad000
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
76657c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80ab12
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
50dc42
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
80c650
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
90267b
     0.01%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] g_private_ge=
t
     0.01%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] 0x00007f229a=
bf162e
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2de79b
     0.01%     0.00%  perf     libnuma.so.1.0.0            [.] 0x00007f229d=
529a2f
     0.01%     0.00%  perf     libc.so.6                   [.] 0x00007f22a4=
a44d4d
     0.01%     0.00%  perf     libc.so.6                   [.] 0x00007f22a4=
a44ce0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2de555
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] mab_mas_cp
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c1a81b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c1108c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c0f258
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] vma_alloc_fo=
lio_noprof
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8b2945
     0.01%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] 0x00007f229a=
b8a017
     0.01%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] 0x00007f229a=
b8980b
     0.01%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] 0x00007f229a=
b894e8
     0.01%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] g_realloc
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9026dd
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44769b
     0.01%     0.01%  perf     libc.so.6                   [.] __strcasestr
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __intercepto=
r_strcasestr
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
52bbb7
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229f=
824cf0
     0.01%     0.00%  perf     libnuma.so.1.0.0            [.] 0x00007f229d=
529980
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __intercepto=
r_fclose
     0.01%     0.00%  perf     libc.so.6                   [.] fclose
     0.01%     0.00%  perf     libc.so.6                   [.] _IO_file_clo=
se_it
     0.01%     0.00%  perf     libc.so.6                   [.] _IO_setb
     0.01%     0.01%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:MemoryMappingLayout::Next(__sanitizer::MemoryMappedSegment*)
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
5107d9
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
870f45
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447e85
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9060e0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
494ec7
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
5120a6
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
a91f60
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
76ab83
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9daa7e
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
43cd20
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446189
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9da5a4
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80f09e
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
785f7f
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] error_entry
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
0013d3
     0.01%     0.00%  perf     libc.so.6                   [.] 0x00007f22a4=
9eb254
     0.01%     0.00%  perf     libc.so.6                   [.] _IO_file_fop=
en
     0.01%     0.00%  perf     libc.so.6                   [.] _IO_file_ope=
n
     0.01%     0.00%  perf     libc.so.6                   [.] open64
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
971db5
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] debug_check_=
no_locks_freed
     0.01%     0.00%  perf     libz3.so.4                  [.] 0x00007f229b=
002feb
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
33d821
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
43878c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4410d5
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
510eac
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
a07fe0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
906ac1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8fd770
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446997
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] prepend_copy
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9da704
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9d9e75
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9daaf8
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446581
     0.01%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] 0x00007f229a=
bbb2cd
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
a70a0d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9b1653
     0.01%     0.00%  perf     libz3.so.4                  [.] 0x00007f229b=
002a9b
     0.01%     0.00%  perf     libstdc++.so.6.0.30         [.] std::ios_bas=
e::Init::Init()
     0.01%     0.00%  perf     libstdc++.so.6.0.30         [.] std::basic_i=
os<char, std::char_traits<char> >::init(std::basic_streambuf<char, std::cha=
r_traits<char> >*)
     0.01%     0.00%  perf     libstdc++.so.6.0.30         [.] std::basic_i=
os<char, std::char_traits<char> >::_M_cache_locale(std::locale const&)
     0.01%     0.00%  perf     libstdc++.so.6.0.30         [.] bool std::ha=
s_facet<std::ctype<char> >(std::locale const&)
     0.01%     0.00%  perf     libstdc++.so.6.0.30         [.] __dynamic_ca=
st
     0.01%     0.00%  perf     libstdc++.so.6.0.30         [.] __cxxabiv1::=
__vmi_class_type_info::__do_dyncast(long, __cxxabiv1::__class_type_info::__=
sub_kind, __cxxabiv1::__class_type_info const*, void const*, __cxxabiv1::__=
class_type_info const*, void const*, __cxxabiv1::__class_type_info::__dynca=
st_result&) const
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9dad7c
     0.01%     0.00%  perf     libc.so.6                   [.] 0x00007f22a4=
9f33dd
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] do_read_faul=
t
     0.01%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] g_hash_table=
_new
     0.01%     0.00%  perf     libstdc++.so.6.0.30         [.] 0x00007f229d=
6c37b5
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
494ec5
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446784
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
873326
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
50ff95
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
9646b0
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
50f562
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44676f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
875b1d
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] try_charge_m=
emcg
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
905859
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
a71c02
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9aea68
     0.01%     0.00%  perf     libnuma.so.1.0.0            [.] __getdelim@p=
lt
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
76af5b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
ef23ec
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __asan::Asan=
Thread::ClearShadowForThreadStackAndTLS()
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:ReserveShadowMemoryRange(unsigned long, unsigned long, char const*, bool)
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:MmapFixedSuperNoReserve(unsigned long, unsigned long, char const*)
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:MmapFixed(unsigned long, unsigned long, int, char const*) [clone .constpro=
p.0]
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:MmapNamed(void*, unsigned long, int, int, char const*)
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
846f46
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
83448f
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.01%  perf     libasan.so.8.0.0            [.] __intercepto=
r_strlen
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
5287dc
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229f=
73fbb8
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] strlen@plt
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9daeed
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9b16b5
     0.01%     0.00%  perf     libstdc++.so.6.0.30         [.] 0x00007f229d=
6b7000
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
43932e
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9b1614
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] __raw_spin_l=
ock_init
     0.01%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] 0x00007f229a=
bc7d6c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2ec6fa
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
efef94
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2deb24
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
87102e
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447f1a
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
526c92
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
8fcf20
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44620b
     0.01%     0.00%  perf     libxml2.so.2.9.14           [.] 0x00007f229a=
cc8000
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] num_to_str
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
a70afc
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9b1570
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c3c9e0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2de66b
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] up_write
     0.01%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] 0x00007f229a=
bad817
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
84704b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
43a3f6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
72b419
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
848b1a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8782b2
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fb4c00
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
5257b6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
906ecd
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2de382
     0.01%     0.01%  perf     libasan.so.8.0.0            [.] __asan::Stop=
InitOrderChecking()
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] AtCxaAtexit(=
void*)
     0.01%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] g_hash_table=
_unref
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
524dbd
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446655
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446a85
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
524c58
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229f=
565c70
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80a0c5
     0.01%     0.00%  perf     libz3.so.4                  [.] 0x00007f229b=
00c7a2
     0.01%     0.00%  perf     libz3.so.4                  [.] 0x00007f229b=
9252a0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
830a4d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8fcdaa
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
76d237
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4e3567
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4e25f0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3a4139
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffffc1=
193b4e
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
788802
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
efef3a
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
522c4f
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229f=
4ba500
     0.01%     0.00%  perf     libnuma.so.1.0.0            [.] 0x00007f229d=
529673
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4477e6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
821d47
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446172
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
5803b4
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f22a1=
3868e0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7662f4
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
808ae5
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f22a0=
84abb7
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f22a0=
84aba3
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __asan::asan=
_delete(void*, unsigned long, unsigned long, __sanitizer::BufferedStackTrac=
e*, __asan::AllocType)
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2de6ea
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] kfree
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8723fe
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
395220
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229f=
c3e55d
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229f=
c47880
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] llvm::initia=
lizeForwardOpTreeWrapperPassPass(llvm::PassRegistry&)
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f22a1=
2d4938
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
853c5e
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
82309e
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
521eb5
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229f=
3dfbe0
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:internal_sigprocmask(int, __sanitizer::__sanitizer_sigset_t*, __sanitizer:=
:__sanitizer_sigset_t*)
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3673fa
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
366f75
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c646f4
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5d48a1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8b268b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2deb01
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
875857
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447f3b
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] llvm::initia=
lizeDependenceInfoWrapperPassPass(llvm::PassRegistry&)
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f22a1=
2fd031
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
444434
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
51f887
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229f=
351310
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8fd238
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
495420
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8fd24d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4eb0a
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] __asan_loadN=
_noabort
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c91f4
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f22a1=
32d01f
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] llvm::initia=
lizeRegionInfoPassPass(llvm::PassRegistry&)
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229f=
b2c477
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] llvm::initia=
lizeDominanceFrontierWrapperPassPass(llvm::PassRegistry&)
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229f=
a2cc21
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445fcd
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] __read_once_=
word_nocheck
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2df141
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2ddde0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
43a5d7
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
51b013
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
853d04
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] llvm::String=
MapImpl::LookupBucketFor(llvm::StringRef)
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
51cbfe
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229f=
2dd6e0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4477e0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c10162
     0.01%     0.00%  perf     perf                        [.] _sub_D_00099=
_0
     0.01%     0.00%  perf     perf                        [.] _sub_D_00099=
_0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446b03
     0.01%     0.01%  perf     libc.so.6                   [.] 0x0000000000=
1646f5
     0.01%     0.00%  perf     perf                        [.] _sub_D_00099=
_0
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f22a1=
32d007
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] llvm::initia=
lizeAAResultsWrapperPassPass(llvm::PassRegistry&)
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229f=
96a708
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] llvm::initia=
lizeBasicAAWrapperPassPass(llvm::PassRegistry&)
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229f=
9838bf
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] llvm::initia=
lizeDominatorTreeWrapperPassPass(llvm::PassRegistry&)
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
7b1f33
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] void std::ve=
ctor<std::unique_ptr<llvm::PassInfo const, std::default_delete<llvm::PassIn=
fo const> >, std::allocator<std::unique_ptr<llvm::PassInfo const, std::defa=
ult_delete<llvm::PassInfo const> > > >::_M_realloc_insert<std::unique_ptr<l=
lvm::PassInfo const, std::default_delete<llvm::PassInfo const> > >(__gnu_cx=
x::__normal_iterator<std::unique_ptr<llvm::PassInfo const, std::default_del=
ete<llvm::PassInfo const> >*, std::vector<std::unique_ptr<llvm::PassInfo co=
nst, std::default_delete<llvm::PassInfo const> >, std::allocator<std::uniqu=
e_ptr<llvm::PassInfo const, std::default_delete<llvm::PassInfo const> > > >=
 >, std::unique_ptr<llvm::PassInfo const, std::default_delete<llvm::PassInf=
o const> >&&)
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8ff6f8
     0.01%     0.00%  perf     perf                        [.] _sub_D_00099=
_0
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] next_uptodat=
e_folio
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
57aadd
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f22a1=
2a64af
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] void llvm::c=
l::apply<llvm::cl::opt<PassPositionChoice, false, llvm::cl::parser<PassPosi=
tionChoice> >, llvm::cl::ValuesClass, llvm::cl::OptionHidden, llvm::cl::ini=
tializer<PassPositionChoice>, llvm::cl::NumOccurrencesFlag, llvm::cl::cat>(=
llvm::cl::opt<PassPositionChoice, false, llvm::cl::parser<PassPositionChoic=
e> >*, llvm::cl::ValuesClass const&, llvm::cl::OptionHidden const&, llvm::c=
l::initializer<PassPositionChoice> const&, llvm::cl::NumOccurrencesFlag con=
st&, llvm::cl::cat const&)
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
766551
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4467ca
     0.01%     0.01%  perf     libasan.so.8.0.0            [.] __asan::CanP=
oisonMemory()
     0.01%     0.00%  perf     perf                        [.] _sub_D_00099=
_0
     0.01%     0.00%  perf     perf                        [.] _sub_D_00099=
_0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8ff86d
     0.01%     0.01%  perf     libc.so.6                   [.] clock_gettim=
e
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:MonotonicNanoTime()
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] real_clock_g=
ettime
     0.01%     0.01%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
0222fa
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447059
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] __asan_memcp=
y
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c1a7f9
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c154ca
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c0f20a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8ca14f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85a517
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c50372
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
57914d
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f22a1=
0bd0c0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e9a86
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
847103
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8453a7
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447f02
     0.01%     0.01%  perf     libLLVM-14.so.1             [.] 0x0000000003=
687b58
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
5778e8
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f22a0=
ebfb30
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] p4d_offset
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7f84ea
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
576516
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f22a0=
c7aee0
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] filter_irq_s=
tacks
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4d3840
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
574d07
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f22a0=
bba340
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fc76d3
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fb014d
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fc2991
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f22a5=
fc2410
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4465bd
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] folio_unlock
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
57385f
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f22a0=
a99a70
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
76ab19
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7634b7
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff82=
c4a118
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff82=
c4f09b
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
572384
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229f=
37e0f0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8ff6de
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4469a3
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
85526f
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
ea9935
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
5700d3
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
56fdff
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
805b35
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7f806c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44760e
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
a3e40f
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
a3d28c
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
a3cde6
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] __slab_free
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
87428e
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
56fb1f
     0.00%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
56f9be
     0.00%     0.00%  perf     libLLVM-14.so.1             [.] std::_Rb_tre=
e_iterator<std::pair<unsigned int const, std::vector<unsigned int, std::all=
ocator<unsigned int> > > > std::_Rb_tree<unsigned int, std::pair<unsigned i=
nt const, std::vector<unsigned int, std::allocator<unsigned int> > >, std::=
_Select1st<std::pair<unsigned int const, std::vector<unsigned int, std::all=
ocator<unsigned int> > > >, std::less<unsigned int>, std::allocator<std::pa=
ir<unsigned int const, std::vector<unsigned int, std::allocator<unsigned in=
t> > > > >::_M_insert_unique_<std::pair<unsigned int const, std::vector<uns=
igned int, std::allocator<unsigned int> > > const&, std::_Rb_tree<unsigned =
int, std::pair<unsigned int const, std::vector<unsigned int, std::allocator=
<unsigned int> > >, std::_Select1st<std::pair<unsigned int const, std::vect=
or<unsigned int, std::allocator<unsigned int> > > >, std::less<unsigned int=
>, std::allocator<std::pair<unsigned int const, std::vector<unsigned int, s=
td::allocator<unsigned int> > > > >::_Alloc_node>(std::_Rb_tree_const_itera=
tor<std::pair<unsigned int const, std::vector<unsigned int, std::allocator<=
unsigned int> > > >, std::pair<unsigned int const, std::vector<unsigned int=
, std::allocator<unsigned int> > > const&, std::_Rb_tree<unsigned int, std:=
:pair<unsigned int const, std::vector<unsigned int, std::allocator<unsigned=
 int> > >, std::_Select1st<std::pair<unsigned int const, std::vector<unsign=
ed int, std::allocator<unsigned int> > > >, std::less<unsigned int>, std::a=
llocator<std::pair<unsigned int const, std::vector<unsigned int, std::alloc=
ator<unsigned int> > > > >::_Alloc_node&)
     0.00%     0.00%  perf     [kernel.kallsyms]           [k] memcpy
     0.00%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
000b99
     0.00%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4b354
     0.00%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4ffda
     0.00%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
84a57a
     0.00%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
43a1ef
     0.00%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
56f976
     0.00%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
56f854
     0.00%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f229e=
56f90c
     0.00%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4472d8
     0.00%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8fcbf1
     0.00%     0.00%  perf     [unknown]                   [k] 0xffffffff82=
c10135
     0.00%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
907105
     0.00%     0.00%  perf     [unknown]                   [k] 0xffffffff82=
c4e7b0
     0.00%     0.00%  perf     [kernel.kallsyms]           [k] __intel_pmu_=
enable_all.constprop.0
     0.00%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3c0d98
     0.00%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
73ac06
     0.00%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
73aa2e
     0.00%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
72814b
     0.00%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
224558
     0.00%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
20a15a
     0.00%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
2695c7
     0.00%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
3c8673
     0.00%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c55fb3
     0.00%     0.00%  perf-ex  [kernel.kallsyms]           [k] __intel_pmu_=
enable_all.constprop.0
     0.00%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:ThreadSuspender::SuspendAllThreads()
     0.00%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:ThreadSuspender::SuspendThread(unsigned long long)
     0.00%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:internal_waitpid(int, int*, int)
     0.00%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
351934
     0.00%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
35175a
     0.00%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
350c97
     0.00%     0.00%  perf-ex  [unknown]                   [k] 0xffffffff81=
00012b
     0.00%     0.00%  perf-ex  [unknown]                   [k] 0xffffffff82=
c4a10c
     0.00%     0.00%  perf-ex  [unknown]                   [k] 0xffffffff81=
962c22
     0.00%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4f396
     0.00%     0.00%  perf-ex  [unknown]                   [k] 0xffffffff81=
962836
     0.00%     0.00%  perf-ex  [unknown]                   [k] 0xffffffff81=
962544
     0.00%     0.00%  perf-ex  [unknown]                   [k] 0xffffffff81=
962105
     0.00%     0.00%  perf-ex  [unknown]                   [k] 0xffffffff81=
a3d97f
     0.00%     0.00%  perf-ex  [unknown]                   [k] 0xffffffff81=
963d49
     0.00%     0.00%  perf-ex  [unknown]                   [k] 0xffffffff81=
744639
     0.00%     0.00%  perf-ex  [unknown]                   [k] 0xffffffff81=
739de3
     0.00%     0.00%  perf-ex  [unknown]                   [k] 0xffffffff81=
224558


#
# (Tip: Show individual samples with: perf script)
#
LBR callgraph [Failed in perf report]
LBR any branch test
[ perf record: Woken up 28 times to write data ]
[ perf record: Captured and wrote 7.002 MB /tmp/__perf_test.perf.data.Xip1v=
 (8972 samples) ]
LBR any branch test: 8972 samples
LBR any branch test [Success]
LBR any call test
[ perf record: Woken up 27 times to write data ]
[ perf record: Captured and wrote 6.846 MB /tmp/__perf_test.perf.data.Xip1v=
 (9011 samples) ]
LBR any call test: 9011 samples
LBR any call test [Success]
LBR any ret test
[ perf record: Woken up 27 times to write data ]
[ perf record: Captured and wrote 7.006 MB /tmp/__perf_test.perf.data.Xip1v=
 (8982 samples) ]
LBR any ret test: 8982 samples
LBR any ret test [Success]
LBR any indirect call test
[ perf record: Woken up 28 times to write data ]
[ perf record: Captured and wrote 6.999 MB /tmp/__perf_test.perf.data.Xip1v=
 (9002 samples) ]
LBR any indirect call test: 9002 samples
LBR any indirect call test [Success]
LBR any indirect jump test
[ perf record: Woken up 18 times to write data ]
[ perf record: Captured and wrote 4.602 MB /tmp/__perf_test.perf.data.Xip1v=
 (9017 samples) ]
LBR any indirect jump test: 9017 samples
LBR any indirect jump test [Success]
LBR direct calls test
[ perf record: Woken up 28 times to write data ]
[ perf record: Captured and wrote 7.032 MB /tmp/__perf_test.perf.data.Xip1v=
 (9016 samples) ]
LBR direct calls test: 9016 samples
LBR direct calls test [Success]
LBR any indirect user call test
[ perf record: Woken up 7 times to write data ]
[ perf record: Captured and wrote 1.985 MB /tmp/__perf_test.perf.data.Xip1v=
 (9006 samples) ]
LBR any indirect user call test: 9001 samples
LBR any indirect user call test [Success]
LBR system wide any branch test
[ perf record: Woken up 28 times to write data ]
[ perf record: Captured and wrote 8.201 MB /tmp/__perf_test.perf.data.Xip1v=
 (10106 samples) ]
LBR system wide any branch test: 10105 samples
LBR system wide any branch test [Success]
LBR system wide any call test
[ perf record: Woken up 28 times to write data ]
[ perf record: Captured and wrote 7.815 MB /tmp/__perf_test.perf.data.Xip1v=
 (9925 samples) ]
LBR system wide any call test: 9925 samples
LBR system wide any call test [Success]
LBR parallel any branch test
LBR parallel any call test
LBR parallel any ret test
LBR parallel any indirect call test
LBR parallel any indirect jump test
LBR parallel direct calls test
LBR parallel any indirect user call test
LBR parallel system wide any branch test
LBR parallel system wide any call test
[ perf record: Woken up 17 times to write data ]
[ perf record: Woken up 2 times to write data ]
[ perf record: Woken up 2 times to write data ]
[ perf record: Woken up 17 times to write data ]
[ perf record: Woken up 1 times to write data ]
[ perf record: Woken up 2 times to write data ]
[ perf record: Woken up 3 times to write data ]
[ perf record: Woken up 60 times to write data ]
[ perf record: Woken up 179 times to write data ]
[ perf record: Captured and wrote 0.485 MB /tmp/__perf_test.perf.data.NcfJe=
 (599 samples) ]
[ perf record: Captured and wrote 0.250 MB /tmp/__perf_test.perf.data.AMrjx=
 (624 samples) ]
[ perf record: Captured and wrote 0.473 MB /tmp/__perf_test.perf.data.4H9al=
 (593 samples) ]
[ perf record: Captured and wrote 4.323 MB /tmp/__perf_test.perf.data.ugZAx=
 (5529 samples) ]
[ perf record: Captured and wrote 4.207 MB /tmp/__perf_test.perf.data.rHL8E=
 (5524 samples) ]
[ perf record: Captured and wrote 0.494 MB /tmp/__perf_test.perf.data.s3biI=
 (611 samples) ]
[ perf record: Captured and wrote 0.265 MB /tmp/__perf_test.perf.data.HkmKX=
 (599 samples) ]
[ perf record: Captured and wrote 58.233 MB /tmp/__perf_test.perf.data.Ccig=
2 (91372 samples) ]
[ perf record: Captured and wrote 23.705 MB /tmp/__perf_test.perf.data.mr6w=
K (109686 samples) ]
LBR parallel any indirect jump test: 599 samples
LBR parallel any indirect jump test [Success]
LBR parallel any indirect user call test: 624 samples
LBR parallel any indirect user call test [Success]
LBR parallel direct calls test: 599 samples
LBR parallel any ret test: 611 samples
LBR parallel any indirect call test: 593 samples
LBR parallel direct calls test [Success]
LBR parallel any ret test [Success]
LBR parallel any indirect call test [Success]
LBR parallel any branch test: 5529 samples
LBR parallel any branch test [Success]
LBR parallel any call test: 5524 samples
LBR parallel any call test [Success]
LBR parallel system wide any branch test: 109686 samples
LBR parallel system wide any branch test [Success]
LBR parallel system wide any call test: 91372 samples
LBR parallel system wide any call test [Success]
---- end(-1) ----
122: perf record LBR tests                                           : FAIL=
ED!



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250331/202503311428.2d19d587-lkp@=
intel.com



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

