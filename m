Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D222D291C21;
	Fri, 13 Jun 2025 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749807691; cv=fail; b=Y+FiMBzKj8WwSl6fwE0UxLBhlqHY4YvDe7VOrPS2CJ0NdjpzOxEmElfEvlesKAEGyomsFoHkcOFCwQDeSPBTlJQqv2TuIJo96yLEY9Cr1GXQX81ftXE2/wjd2sfJReMAWod/EmdQp0zcxedeiQAz8+nCP/YyDH2YSqQre6TqvZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749807691; c=relaxed/simple;
	bh=AZJDeKLt3Cd2tX5+mKZj/Rp8eVwTsXBRtpIEM7fZ1SE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dBS8VxFvfbNMhOWfC57/q9I752cNADApPqrSOLAkr3d7vOZOCFafDuAL/Xj7JlYhHQzt5ickyUFsZ4Uy1MWYDjuAPjUf5U6unRYr7Lut0DsZTn1V0FGkPOrcYZMXMqsRWh/AiaXPz7ghgbDjH7NY3byTSIKNAAv5IaoXiJn/jwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EDZHNth4; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EDZHNth4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749807681; x=1781343681;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=AZJDeKLt3Cd2tX5+mKZj/Rp8eVwTsXBRtpIEM7fZ1SE=;
  b=EDZHNth4XaSLtH4He6z3qIBzX8r78fSIjsYGZKNzBKBm4L1Mw8PCN6DI
   7nb3X9Qc0eey3ecMRq2t8aoXA3EizDc6MI/3U3sw7qaSKxUm5Bxl5Iwt+
   sc2AbA2NI4/JSg+WlLPT4PywTFpDsiYgzkUG38yv0Uz41T4SrGiHM0t7W
   cADzuM0zkBHBJpFa2vyE/r+XVcbIWOta1xMyFoORiCUkoExMgTz07Y2TP
   Rn+4ECb033/oeYElV8NBMg0Q60/IOHiLnuscP77Su0KSHGLuJfpT9wn+S
   DHpyS3kjC5eLOPv9KRslP+gSkZ2GpvAtKboqgOlnUgEI8Vz3ejJsBQPEb
   w==;
X-CSE-ConnectionGUID: Q0WUhe6/T1GWaIU5PhKpdQ==
X-CSE-MsgGUID: 9P3xEQRZSnW1eWOkCYXnqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="74552587"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="74552587"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 02:41:15 -0700
X-CSE-ConnectionGUID: d0FthAqKRb2BWiOBZ63CYg==
X-CSE-MsgGUID: 5SF9M6lVRP2YmGdnOijmbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="148666035"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 02:41:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 02:41:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 13 Jun 2025 02:41:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.57)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 02:41:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsWH0H0EbzGS6H6gwdfjY9f70N3A7dmFPoRPQFJNbX05HjdsI4xK3Kiurpc3k1DgvC9bGi0nIdS2/Y4wsnyJzoWPjW3zk/2osw/6fZzXbmNEbYOgnBMnQTaZXFO58nHp7puPnoc2iR5OBuTh1fGqXm4OGruCF17ng3Xml/cThi+mND+eE7fGjZvpblQF/gvtEvdMYCzwd33UEPMDN25SfydyTMPzdaBjcO0370i4LU0XnkhczQDiy5Vn1Fcg9gnRRnXv2vQFq+dIMCW8qi7RgmkJH073+G/EnOV3kT8HDFnaNqYrbCoT4AWl2S0N6e/gySKa5VzGkBU33v9Avfz70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2KOoxZGFimEzfDQ31twyyQP+EH1AG9ae9vsB1T5yu4=;
 b=s8fKSuMXIT6zajucg5ZQUYxXOatGYWl22lQ1gatcbXtvbU1bJygi59v6/dfCdKukckoPlRPkDnphw4RdncK2/qZONDrS2MGbHp+VrYVNcpMjH0pakwddKDR/XvjfFQhnE2nzDCjYaVXUz8gL8w/EYfbYYfodiVSY9GxD0aFt8WSXLvbMPzDHTn338z9UFznsYrlp9RZQ62YD6v6SWb5pzQrU3jCly+Z3060ZjdsWBcn9djkRgP5Bx9cMedI08Qnb5l6CpaqWChMJjk+KendwB5cejq0akVfOFGxZrL4r1aA9dH+sv5eX+wxyTJNdzRbfRjg6YeIX+7CKvW//Jf2tvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7681.namprd11.prod.outlook.com (2603:10b6:8:f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 09:40:49 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8792.034; Fri, 13 Jun 2025
 09:40:48 +0000
Date: Fri, 13 Jun 2025 17:40:35 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Howard Chu <howardchu95@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<acme@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<peterz@infradead.org>, <kan.liang@linux.intel.com>, Howard Chu
	<howardchu95@gmail.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v3 5/6] perf test trace BTF: Use --sort-events in BTF
 general tests
Message-ID: <202506131634.ef8ef10b-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250528191148.89118-6-howardchu95@gmail.com>
X-ClientProxiedBy: KU0P306CA0089.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:22::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 963f30c1-b692-4865-679b-08ddaa5e6014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GAPnxyfC8vFdWb0aVei9PqJ+t9GlbQgtcPWb5JX5CNDP+UE+b5j+BrhWvHY4?=
 =?us-ascii?Q?60kj+nDckcnShMyVrcnHHtodMQY/cxoQe6xTGSYRRieNv8UPaLdmFwBCUMMx?=
 =?us-ascii?Q?kdEKOZKn+YfnBXq5+kpgjT5s19msOhTtWjSN8/894U6BQmP7L1ZhRsQqcO1P?=
 =?us-ascii?Q?JYbyWOsjknuC3ib/WkvGXY9ok5PoJpzT/SzHTC7FEceFSWGi8VHHESD2yV0x?=
 =?us-ascii?Q?idHuRLoBAGSgwbaLyT784+QwbVuO+IY9VPRDugJvaIm2/jP0W6IQqT54dRWg?=
 =?us-ascii?Q?QMRU5GiptDVVx7W64X55jX2KufnbfcbnGt0dTw6PdB5132rZepaeLmzJhnHL?=
 =?us-ascii?Q?aCU5OdjCz69jPKwg9sezgxC4Ci3RPZRQorrmRbBCpahekHj5INrqH75KbP5v?=
 =?us-ascii?Q?BEpRP9EnsyhxJ8de7JTyUa/nXduVfvMgsKJ7/jqksdAuK0xmEGKJxlhEM97Z?=
 =?us-ascii?Q?r8L98Yq64J0vQlGGarw7cg0YfFwZ3TyK4H405PP0By91YEUaqxgx2U47OlaB?=
 =?us-ascii?Q?qRpOvWL+BvF5NsTqCLRzqtkfCBzas2yrSPJ9rlwA7HE4P3aeC3+dJPseTrbo?=
 =?us-ascii?Q?0ZSL2IwQuQ9EzP4O75xb9Mmh68gUmnizHwSMSr5ORhNCNpCb6N+mLEw14Pih?=
 =?us-ascii?Q?33muikGyz8LiEUR3y91qnu/g9Ee54Ktf5jqVywLroSpKqShQe+uOM3fnweKI?=
 =?us-ascii?Q?pjFSr1ZgjCAdfoEcl+QbSoxK8AwEaspCWC0TKt4xCsjOXeSoOUEtHaId6xiY?=
 =?us-ascii?Q?W89jLSNN3NP5NIGAZe+5N8KjC0BzVE+8zREDS/gqyDMLoTZAGX7uPCW9stKh?=
 =?us-ascii?Q?FeorhYFoAUksPRJXFdIU/9hERD8RbOZzGTLrwjQP2iEHko0eac3tdYyheEDL?=
 =?us-ascii?Q?5jbF9o8PNG9WEhS865ZzeCiLdQ5mXLDEF/9+kQENAgsLksRj+jGtJo2eKBA6?=
 =?us-ascii?Q?xXOoDXmaiPAh9A/5eMYRyTuPtn8SN/i/CzxFUBIguXRCbcK/L1JGDw8d7CN7?=
 =?us-ascii?Q?F+COXk4cDTOEV4kjjRfuivIPUghD1lmopUab2En5cLD/S2KHr9VXAOBQMOwV?=
 =?us-ascii?Q?mbKhp8XSE7FMbG/NF38kl6zfxCcpJ6cK4umQWx07rs2LUZj2y8s8lU+drQoQ?=
 =?us-ascii?Q?6OpHn2g7b7QgC7OJB/k6dlFSsdLjism9wlQhWoTffP8l9Q/hwbEhGWlG7xAo?=
 =?us-ascii?Q?iMhQMvxYnG3LWZjcligkx39Xm+Cj7R4dyPz8lV2T8tbbWcMwlh4Za/99P7uB?=
 =?us-ascii?Q?pccRvh7bbkEWe7lUBv71Xc6WPEe0fI2RGym3tm28O/3QBFutJuJ0hQceZJ5X?=
 =?us-ascii?Q?IsVNzi75r8g9HjE5wAu7VobaPbXNxEIBYUHjJ1ZwEDIVoXiaV0TrfHClU59K?=
 =?us-ascii?Q?s9hsLt6bfAZEzaCQZvJFu+WnmA3F?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mww+g74VZnZuv1XaM0hjsIzvwD3IstCxi7W+t89ShmU6iOr19aOI9qHIg+bH?=
 =?us-ascii?Q?UwnFxtlUGOEClLJcX7e04lPsNHogvWb/fRd19G9RSyNtNCm+WvvSt3L3ESp6?=
 =?us-ascii?Q?V4RNBgZGt01S7aWp9ZdFXxxsJiUyBZFieV37coLn8FbmrSM5EwWyenDMhdh5?=
 =?us-ascii?Q?KEZwXI+r/jWo0ePWK6vhPR5mjniqDnKquLS906KKKOR7J6NjjsqUWFlSjZNZ?=
 =?us-ascii?Q?tCknSSVZfDkN0T9n9q/KKK/kf3+NW8zSui2gHkTVi79Nd5OidYJ4dntKYCaP?=
 =?us-ascii?Q?0Xb7VAsiyNP3FMTsYbakwQ/KELp8GiN//e9ErIWQmLCMGo2b7kPe5ZiSCBM1?=
 =?us-ascii?Q?vIzEhBGSIjYG4x2CpEm0l/IqLOs8Q/U/cURHkq4liwb/UqIpouMAkQzkmigi?=
 =?us-ascii?Q?jSmhSB3Mt4jNsEGGGffh/snAuur1agAB4NPW4Psa7qRk9o8V2jYx3iUwQAno?=
 =?us-ascii?Q?rIRXpT/c0r55Aa+lbSTKdqUu5NWt+OpNmiS/pykh+ZdJlVcowvmQXzulwSfW?=
 =?us-ascii?Q?m6SbjuTZPgunoNDuivdMwKdBH6SzuhdOah+1BJXfQeLvxH0mC1133QhYgOJ4?=
 =?us-ascii?Q?894A8yLOssjjA4W6PZLSs7eaZt0M7jg5BTJIIp4uKXkAiKn7A+pAiIG88J15?=
 =?us-ascii?Q?0w18hscJtNZnNOmK7GJbrn/EPjMQCzDFt6FrH86vVhl3+xh3VcWrr3CXI2Kb?=
 =?us-ascii?Q?jQnXeJtG/LvNVQ66pVLtPKt5XLtrX1ZfGxwOhlrjh9kB3IMGWrGHR0eVYW4j?=
 =?us-ascii?Q?4C45hn2hQFE1CUVoCHluige7nhQXBwpvU6lvPig4N0Y7wtRYwGC6ZRv3KcRp?=
 =?us-ascii?Q?+Gid4NNZJkg9P45HRwD4Slfclpc2ep1CouFnWcjcnoNILjwm0Sh3PyPl1UK9?=
 =?us-ascii?Q?IfoxmKQCJJpzGA82PMbKYDSRmUien8/KR2joGfR5XouPGBTGavu5fE7an011?=
 =?us-ascii?Q?/by3ifgpYgb98BYDZS5nHw5wJVM3P9d4lHYh1ZqMh9tV+MK1o4JBuyc1f3v/?=
 =?us-ascii?Q?Cyj1wzbcFeMKoHTJGmSWSQxeXVLchSWmn7ZjuxYKir0EO9ivhImqp7WYVJA0?=
 =?us-ascii?Q?Pa35lUdrepp2BnakotSdhMzihpNGzjIOgDKZ4MmYM2D7MPuKC6mWnxlvfViK?=
 =?us-ascii?Q?uO4NGmdVSLuVJHpOwyIRffjxqbKNwKkFiaKKMGv6WVVWOMNQv82H7mY79eWk?=
 =?us-ascii?Q?+maabVIykd53Fb+ATAnkp/Sx/+AnR6wtwZs/MWsW+gjtAxnarz8z869TZNUt?=
 =?us-ascii?Q?LjDVfgxVp52q6xLso/7KdT8m/G1VZIuC+tT/CjxJqcr4gOA0omC0ENY8G8AL?=
 =?us-ascii?Q?dmFK+lpZjpSPXO7HKrKKTFlWjfac00K/PsM337w8AZagLG7MWvG9nIrmJTX8?=
 =?us-ascii?Q?HW3CO7Zw3ZTveJVifjzSozeMADfxKRpaUfzzPqwnW4hAbmue+DSveTYJ6dQO?=
 =?us-ascii?Q?+10JEWtne2s3JojCkMtsW1ECPxIPPh8nrJYixMswg/6WaNRtcLtPK2wo9AJB?=
 =?us-ascii?Q?RjLty8MEq9Vx2EZWFUd9zpBow+b0Gp7O2EBMKVcYGnHUtTxMPyuagsjW+EPe?=
 =?us-ascii?Q?eVw/Tk4r/wyjLAB5tous8iLxj6Uv4jyslP+xSh7M01A6lwa907SlaIxCy+rt?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 963f30c1-b692-4865-679b-08ddaa5e6014
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 09:40:48.6978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Zyh8Ty6/uUnvdhVf494KCokfy9cfSxrJZz+YCGtPmNQPffV7Vmq6JeSA2L/UXbBBGWSr0Y+2XcbZUslHseNeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7681
X-OriginatorOrg: intel.com


Hello,

besides below formal report, we observed below difference comparing to pare=
nt.

1d2859b4fa79a8e2 609a86901e6fd886f1139aed8f8
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6          100%           6:6     kmsg.sanitizer.direct_leak/__=
interceptor_malloc/alloc_event/ordered_events__new_event/ordered_events__qu=
eue/trace__deliver_event/trace__run
           :6          100%           6:6     kmsg.sanitizer.direct_leak/__=
interceptor_malloc/thread__get/trace__sys_enter/trace__handle_event/__trace=
__deliver_event/ordered_events__deliver_event
           :6          100%           6:6     kmsg.sanitizer.indirect_leak/=
__interceptor_calloc/nsinfo__alloc/nsinfo__copy/map__new/machine__process_m=
map2_event/machine__process_event
           :6          100%           6:6     kmsg.sanitizer.indirect_leak/=
__interceptor_calloc/zalloc/comm__new/thread__new/threads__findnew/__machin=
e__findnew_thread
           :6          100%           6:6     kmsg.sanitizer.indirect_leak/=
__interceptor_calloc/zalloc/dso__new_id/__dsos__addnew_id/__dsos__findnew_i=
d/dsos__findnew_id
           :6          100%           6:6     kmsg.sanitizer.indirect_leak/=
__interceptor_calloc/zalloc/dso__new_id/dso__new/__machine__addnew_vdso/mac=
hine__findnew_vdso
           :6          100%           6:6     kmsg.sanitizer.indirect_leak/=
__interceptor_calloc/zalloc/map__new/machine__process_mmap2_event/machine__=
process_event/trace__process_event
           :6          100%           6:6     kmsg.sanitizer.indirect_leak/=
__interceptor_calloc/zalloc/maps__new/thread__init_maps/__machine__findnew_=
thread/machine__findnew_thread
           :6          100%           6:6     kmsg.sanitizer.indirect_leak/=
__interceptor_calloc/zalloc/thread__new/threads__findnew/__machine__findnew=
_thread/machine__findnew_thread
           :6          100%           6:6     kmsg.sanitizer.indirect_leak/=
__interceptor_calloc/zalloc/thread_trace__new/thread__trace/trace__sys_ente=
r/trace__handle_event
           :6          100%           6:6     kmsg.sanitizer.indirect_leak/=
__interceptor_malloc/comm_str__get/comm_strs__findnew/comm__override/____th=
read__set_comm/__thread__set_comm
           :6          100%           6:6     kmsg.sanitizer.indirect_leak/=
__interceptor_malloc/dso__get/map__init/map__new/machine__process_mmap2_eve=
nt/machine__process_event
           :6          100%           6:6     kmsg.sanitizer.indirect_leak/=
__interceptor_malloc/map__get/__maps__insert_sorted/__maps__fixup_overlap_a=
nd_insert/maps__fixup_overlap_and_insert/thread__insert_map
           :6          100%           6:6     kmsg.sanitizer.indirect_leak/=
__interceptor_malloc/maps__new/thread__init_maps/__machine__findnew_thread/=
machine__findnew_thread/machine__process_comm_event
           :6          100%           6:6     kmsg.sanitizer.indirect_leak/=
__interceptor_malloc/nsinfo__alloc/nsinfo__copy/map__new/machine__process_m=
map2_event/machine__process_event
           :6          100%           6:6     kmsg.sanitizer.indirect_leak/=
__interceptor_malloc/nsinfo__alloc/nsinfo__new/thread__new/threads__findnew=
/__machine__findnew_thread
           :6          100%           6:6     kmsg.sanitizer.indirect_leak/=
__interceptor_malloc/nsinfo__get/map__new/machine__process_mmap2_event/mach=
ine__process_event/trace__process_event
           :6          100%           6:6     kmsg.sanitizer.indirect_leak/=
__interceptor_malloc/trace__sys_enter/trace__handle_event/__trace__deliver_=
event/ordered_events__deliver_event/do_flush
           :6          100%           6:6     kmsg.sanitizer.indirect_leak/=
__interceptor_realloc/__maps__insert_sorted/__maps__fixup_overlap_and_inser=
t/maps__fixup_overlap_and_insert/thread__insert_map/machine__process_mmap2_=
event
           :6          100%           6:6     kmsg.sanitizer.indirect_leak/=
__interceptor_strdup/dso__set_basename/__dsos__addnew_id/__dsos__findnew_id=
/dsos__findnew_id/machine__findnew_dso_id


we don't have enough knowledge whether the appearance of these leak message=
 is
actually a fix from 609a86901e6fd886f1139aed8f8 which allows to show issue
clearly. so just report out FYI.

below is formal report.


kernel test robot noticed "kmsg.sanitizer.indirect_leak/__interceptor_mallo=
c/trace__sys_enter/trace__handle_event/__trace__deliver_event/ordered_event=
s__deliver_event/do_flush" on:

commit: 609a86901e6fd886f1139aed8f8c66d982f2afed ("[PATCH v3 5/6] perf test=
 trace BTF: Use --sort-events in BTF general tests")
url: https://github.com/intel-lab-lkp/linux/commits/Howard-Chu/perf-test-tr=
ace-Use-shell-s-f-flag-to-check-if-vmlinux-exists/20250529-031444
patch link: https://lore.kernel.org/all/20250528191148.89118-6-howardchu95@=
gmail.com/
patch subject: [PATCH v3 5/6] perf test trace BTF: Use --sort-events in BTF=
 general tests

in testcase: perf-sanity-tests
version:=20
with following parameters:

	perf_compiler: clang
	group: group-02



config: x86_64-rhel-9.4-bpf
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (=
Kaby Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202506131634.ef8ef10b-lkp@intel.co=
m

gcc march setting is skylake
valid
make PERF passed
2025-06-12 08:31:04 cd /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e6f=
d886f1139aed8f8c66d982f2afed/tools/perf
2025-06-12 08:31:04 mkdir -p /pkg
2025-06-12 08:31:04 mkdir -p /kbuild/obj/consumer/x86_64-rhel-9.4-bpf
2025-06-12 08:31:05 cp /pkg/linux/x86_64-rhel-9.4-bpf/gcc-12/609a86901e6fd8=
86f1139aed8f8c66d982f2afed/vmlinux.xz /tmp
2025-06-12 08:31:09 unxz -k /tmp/vmlinux.xz
2025-06-12 08:31:18 cp /tmp/vmlinux /kbuild/obj/consumer/x86_64-rhel-9.4-bp=
f
2025-06-12 08:31:19 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 101 -v
101: perf metrics value validation                                   : Runn=
ing (1 active)
101: perf metrics value validation                                   : Ok
2025-06-12 08:31:20 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 102 -v
102: Check Arm64 callgraphs are complete in fp mode                  : Runn=
ing (1 active)
102: Check Arm64 callgraphs are complete in fp mode                  : Skip
2025-06-12 08:31:21 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 103 -v
103: Check Arm SPE doesn't hang when there are forks                 : Runn=
ing (1 active)
103: Check Arm SPE doesn't hang when there are forks                 : Skip
2025-06-12 08:31:22 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 104 -v
104: Check branch stack sampling                                     : Runn=
ing (1 active)
--- start ---
test child forked, pid 7384
 13b7261-13b730c l brstack_bench
perf does have symbol 'brstack_bench'
Testing user branch stack sampling

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D7433=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 88504 byte(s) in 13 object(s) allocated from:
    #0 0x7fc7e91593b7 in __interceptor_calloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:77
    #1 0x7fc7e8f8b743  (/lib/x86_64-linux-gnu/libelf.so.1+0x3743)

Indirect leak of 26176 byte(s) in 13 object(s) allocated from:
    #0 0x7fc7e91599cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7fc7e8f929f0  (/lib/x86_64-linux-gnu/libelf.so.1+0xa9f0)

Indirect leak of 4282 byte(s) in 13 object(s) allocated from:
    #0 0x7fc7e91599cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7fc7e8f93812  (/lib/x86_64-linux-gnu/libelf.so.1+0xb812)

SUMMARY: AddressSanitizer: 118962 byte(s) leaked in 39 allocation(s).
Unexpected signal in test_user_branches
---- end(-1) ----
104: Check branch stack sampling                                     : FAIL=
ED!
2025-06-12 08:31:35 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 105 -v
105: Test java symbol                                                : Runn=
ing (1 active)
105: Test java symbol                                                : Skip
2025-06-12 08:31:36 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 106 -v
106: 'perf data convert --to-json' command test                      : Runn=
ing (1 active)
106: 'perf data convert --to-json' command test                      : Ok
2025-06-12 08:31:43 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 107 -v
107: test perf probe of function from different CU                   : Runn=
ing (1 active)
--- start ---
test child forked, pid 7502

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D7532=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 7960 byte(s) in 1 object(s) allocated from:
    #0 0x7fa35b43f3b7 in __interceptor_calloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:77
    #1 0x7fa35b271743  (/lib/x86_64-linux-gnu/libelf.so.1+0x3743)

Indirect leak of 2368 byte(s) in 1 object(s) allocated from:
    #0 0x7fa35b43f9cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7fa35b2789f0  (/lib/x86_64-linux-gnu/libelf.so.1+0xa9f0)

Indirect leak of 368 byte(s) in 1 object(s) allocated from:
    #0 0x7fa35b43f9cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7fa35b279812  (/lib/x86_64-linux-gnu/libelf.so.1+0xb812)

SUMMARY: AddressSanitizer: 10696 byte(s) leaked in 3 allocation(s).
--- Cleaning up ---
"foo" does not hit any event.
  Error: Failed to delete events.
---- end(-1) ----
107: test perf probe of function from different CU                   : FAIL=
ED!
2025-06-12 08:31:45 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 108 -v
108: perf trace enum augmentation tests                              : Runn=
ing (1 active)
108: perf trace enum augmentation tests                              : Ok
2025-06-12 08:31:51 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 109 -v
109: perf trace BTF general tests                                    : Runn=
ing (1 active)
--- start ---
test child forked, pid 7588
Checking if vmlinux BTF exists
Testing perf trace's string augmentation
String augmentation test failed, output:
mv/7612 renameat2(CWD, 0x3bf92cdc, CWD, 0x3bf92cec, NOREPLACE) =3D 0

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D7605=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 65536 byte(s) in 1 object(s) allocated from:
    #0 0x7f857a9839cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x5575e6397181 in alloc_event util/ordered-events.c:148
    #2 0x5575e63978aa in ordered_events__new_event util/ordered-events.c:17=
7
    #3 0x5575e6397f3f in ordered_events__queue util/ordered-events.c:210
    #4 0x5575e5ec3034 in trace__deliver_event /usr/src/perf_selftests-x86_6=
4-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-=
trace.c:4214
    #5 0x5575e5ec79ec in trace__run /usr/src/perf_selftests-x86_64-rhel-9.4=
-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:45=
99
    #6 0x5575e5ed894b in cmd_trace /usr/src/perf_selftests-x86_64-rhel-9.4-=
bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:582=
0
    #7 0x5575e5eec211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.=
4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:351
    #8 0x5575e5eecacf in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.=
c:404
    #9 0x5575e5eed025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-b=
pf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:448
    #10 0x5575e5eed7cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-=
609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:556
    #11 0x7f857996e249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Direct leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x7f857a9839cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x5575e63a656a in thread__get util/thread.c:136
    #2 0x5575e5eb47d7 in trace__sys_enter /usr/src/perf_selftests-x86_64-rh=
el-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trac=
e.c:2820
    #3 0x5575e5ec0d0a in trace__handle_event /usr/src/perf_selftests-x86_64=
-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-t=
race.c:3623
    #4 0x5575e5ec2a4e in __trace__deliver_event /usr/src/perf_selftests-x86=
_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builti=
n-trace.c:4180
    #5 0x5575e5ec314e in ordered_events__deliver_event /usr/src/perf_selfte=
sts-x86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf=
/builtin-trace.c:4226
    #6 0x5575e6398bb6 in do_flush util/ordered-events.c:245
    #7 0x5575e6399a57 in __ordered_events__flush util/ordered-events.c:324
    #8 0x5575e6399f6a in ordered_events__flush util/ordered-events.c:342
    #9 0x5575e5ec7f39 in trace__run /usr/src/perf_selftests-x86_64-rhel-9.4=
-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:46=
41
    #10 0x5575e5ed894b in cmd_trace /usr/src/perf_selftests-x86_64-rhel-9.4=
-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:58=
20
    #11 0x5575e5eec211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9=
.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:351
    #12 0x5575e5eecacf in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf=
.c:404
    #13 0x5575e5eed025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-=
bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:448
    #14 0x5575e5eed7cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-=
609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:556
    #15 0x7f857996e249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 2495 byte(s) in 6 object(s) allocated from:
    #0 0x7f857a9833b7 in __interceptor_calloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:77
    #1 0x5575e5f17fde in zalloc ../../lib/zalloc.c:8
    #2 0x5575e62a45ea in dso__new_id util/dso.c:1515
    #3 0x5575e62ac313 in __dsos__addnew_id util/dsos.c:328
    #4 0x5575e62ac400 in __dsos__findnew_id util/dsos.c:350
    #5 0x5575e62ac48a in dsos__findnew_id util/dsos.c:357
    #6 0x5575e634b668 in machine__findnew_dso_id util/machine.c:3153
    #7 0x5575e63515c1 in map__new util/map.c:169
    #8 0x5575e633bfbb in machine__process_mmap2_event util/machine.c:1736
    #9 0x5575e633dafd in machine__process_event util/machine.c:1928
    #10 0x5575e5ea78e7 in trace__process_event /usr/src/perf_selftests-x86_=
64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin=
-trace.c:1949
    #11 0x5575e5ec0607 in trace__handle_event /usr/src/perf_selftests-x86_6=
4-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-=
trace.c:3601
    #12 0x5575e5ec2a4e in __trace__deliver_event /usr/src/perf_selftests-x8=
6_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/built=
in-trace.c:4180
    #13 0x5575e5ec314e in ordered_events__deliver_event /usr/src/perf_selft=
ests-x86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/per=
f/builtin-trace.c:4226
    #14 0x5575e6398bb6 in do_flush util/ordered-events.c:245
    #15 0x5575e6399a57 in __ordered_events__flush util/ordered-events.c:324
    #16 0x5575e6399f6a in ordered_events__flush util/ordered-events.c:342
    #17 0x5575e5ec7f39 in trace__run /usr/src/perf_selftests-x86_64-rhel-9.=
4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:4=
641
    #18 0x5575e5ed894b in cmd_trace /usr/src/perf_selftests-x86_64-rhel-9.4=
-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:58=
20
    #19 0x5575e5eec211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9=
.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:351
    #20 0x5575e5eecacf in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf=
.c:404
    #21 0x5575e5eed025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-=
bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:448
    #22 0x5575e5eed7cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-=
609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:556
    #23 0x7f857996e249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 2048 byte(s) in 1 object(s) allocated from:
    #0 0x7f857a9839cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x5575e5eb35a5 in trace__sys_enter /usr/src/perf_selftests-x86_64-rh=
el-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trac=
e.c:2776
    #2 0x5575e5ec0d0a in trace__handle_event /usr/src/perf_selftests-x86_64=
-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-t=
race.c:3623
    #3 0x5575e5ec2a4e in __trace__deliver_event /usr/src/perf_selftests-x86=
_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builti=
n-trace.c:4180
    #4 0x5575e5ec314e in ordered_events__deliver_event /usr/src/perf_selfte=
sts-x86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf=
/builtin-trace.c:4226
    #5 0x5575e6398bb6 in do_flush util/ordered-events.c:245
    #6 0x5575e6399a57 in __ordered_events__flush util/ordered-events.c:324
    #7 0x5575e6399f6a in ordered_events__flush util/ordered-events.c:342
    #8 0x5575e5ec7f39 in trace__run /usr/src/perf_selftests-x86_64-rhel-9.4=
-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:46=
41
    #9 0x5575e5ed894b in cmd_trace /usr/src/perf_selftests-x86_64-rhel-9.4-=
bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:582=
0
    #10 0x5575e5eec211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9=
.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:351
    #11 0x5575e5eecacf in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf=
.c:404
    #12 0x5575e5eed025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-=
bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:448
    #13 0x5575e5eed7cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-=
609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:556
    #14 0x7f857996e249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 448 byte(s) in 8 object(s) allocated from:
    #0 0x7f857a9833b7 in __interceptor_calloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:77
    #1 0x5575e5f17fde in zalloc ../../lib/zalloc.c:8
    #2 0x5575e6351323 in map__new util/map.c:132
    #3 0x5575e633bfbb in machine__process_mmap2_event util/machine.c:1736
    #4 0x5575e633dafd in machine__process_event util/machine.c:1928
    #5 0x5575e5ea78e7 in trace__process_event /usr/src/perf_selftests-x86_6=
4-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-=
trace.c:1949
    #6 0x5575e5ec0607 in trace__handle_event /usr/src/perf_selftests-x86_64=
-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-t=
race.c:3601
    #7 0x5575e5ec2a4e in __trace__deliver_event /usr/src/perf_selftests-x86=
_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builti=
n-trace.c:4180
    #8 0x5575e5ec314e in ordered_events__deliver_event /usr/src/perf_selfte=
sts-x86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf=
/builtin-trace.c:4226
    #9 0x5575e6398bb6 in do_flush util/ordered-events.c:245
    #10 0x5575e6399a57 in __ordered_events__flush util/ordered-events.c:324
    #11 0x5575e6399f6a in ordered_events__flush util/ordered-events.c:342
    #12 0x5575e5ec7f39 in trace__run /usr/src/perf_selftests-x86_64-rhel-9.=
4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:4=
641
    #13 0x5575e5ed894b in cmd_trace /usr/src/perf_selftests-x86_64-rhel-9.4=
-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:58=
20
    #14 0x5575e5eec211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9=
.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:351
    #15 0x5575e5eecacf in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf=
.c:404
    #16 0x5575e5eed025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-=
bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:448
    #17 0x5575e5eed7cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-=
609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:556
    #18 0x7f857996e249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 383 byte(s) in 1 object(s) allocated from:
    #0 0x7f857a9833b7 in __interceptor_calloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:77
    #1 0x5575e5f17fde in zalloc ../../lib/zalloc.c:8
    #2 0x5575e62a45ea in dso__new_id util/dso.c:1515
    #3 0x5575e62a5970 in dso__new util/dso.c:1566
    #4 0x5575e64e75d4 in __machine__addnew_vdso util/vdso.c:132
    #5 0x5575e64e8fed in machine__findnew_vdso util/vdso.c:361
    #6 0x5575e6351598 in map__new util/map.c:167
    #7 0x5575e633bfbb in machine__process_mmap2_event util/machine.c:1736
    #8 0x5575e633dafd in machine__process_event util/machine.c:1928
    #9 0x5575e5ea78e7 in trace__process_event /usr/src/perf_selftests-x86_6=
4-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-=
trace.c:1949
    #10 0x5575e5ec0607 in trace__handle_event /usr/src/perf_selftests-x86_6=
4-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-=
trace.c:3601
    #11 0x5575e5ec2a4e in __trace__deliver_event /usr/src/perf_selftests-x8=
6_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/built=
in-trace.c:4180
    #12 0x5575e5ec314e in ordered_events__deliver_event /usr/src/perf_selft=
ests-x86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/per=
f/builtin-trace.c:4226
    #13 0x5575e6398bb6 in do_flush util/ordered-events.c:245
    #14 0x5575e6399a57 in __ordered_events__flush util/ordered-events.c:324
    #15 0x5575e6399f6a in ordered_events__flush util/ordered-events.c:342
    #16 0x5575e5ec7f39 in trace__run /usr/src/perf_selftests-x86_64-rhel-9.=
4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:4=
641
    #17 0x5575e5ed894b in cmd_trace /usr/src/perf_selftests-x86_64-rhel-9.4=
-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:58=
20
    #18 0x5575e5eec211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9=
.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:351
    #19 0x5575e5eecacf in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf=
.c:404
    #20 0x5575e5eed025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-=
bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:448
    #21 0x5575e5eed7cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-=
609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:556
    #22 0x7f857996e249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 256 byte(s) in 1 object(s) allocated from:
    #0 0x7f857a9833b7 in __interceptor_calloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:77
    #1 0x5575e5f17fde in zalloc ../../lib/zalloc.c:8
    #2 0x5575e63a5982 in thread__new util/thread.c:46
    #3 0x5575e63aa3b0 in threads__findnew util/threads.c:116
    #4 0x5575e6331574 in __machine__findnew_thread util/machine.c:506
    #5 0x5575e63317ab in machine__findnew_thread util/machine.c:530
    #6 0x5575e6331bb0 in machine__process_comm_event util/machine.c:569
    #7 0x5575e633da81 in machine__process_event util/machine.c:1920
    #8 0x5575e5ea78e7 in trace__process_event /usr/src/perf_selftests-x86_6=
4-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-=
trace.c:1949
    #9 0x5575e5ec0607 in trace__handle_event /usr/src/perf_selftests-x86_64=
-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-t=
race.c:3601
    #10 0x5575e5ec2a4e in __trace__deliver_event /usr/src/perf_selftests-x8=
6_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/built=
in-trace.c:4180
    #11 0x5575e5ec314e in ordered_events__deliver_event /usr/src/perf_selft=
ests-x86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/per=
f/builtin-trace.c:4226
    #12 0x5575e6398bb6 in do_flush util/ordered-events.c:245
    #13 0x5575e6399a57 in __ordered_events__flush util/ordered-events.c:324
    #14 0x5575e6399f6a in ordered_events__flush util/ordered-events.c:342
    #15 0x5575e5ec7f39 in trace__run /usr/src/perf_selftests-x86_64-rhel-9.=
4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:4=
641
    #16 0x5575e5ed894b in cmd_trace /usr/src/perf_selftests-x86_64-rhel-9.4=
-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:58=
20
    #17 0x5575e5eec211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9=
.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:351
    #18 0x5575e5eecacf in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf=
.c:404
    #19 0x5575e5eed025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-=
bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:448
    #20 0x5575e5eed7cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-=
609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:556
    #21 0x7f857996e249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 256 byte(s) in 1 object(s) allocated from:
    #0 0x7f857a9828d5 in __interceptor_realloc ../../../../src/libsanitizer=
/asan/asan_malloc_linux.cpp:85
    #1 0x5575e635c451 in __maps__insert_sorted util/maps.c:770
    #2 0x5575e635dd4c in __maps__fixup_overlap_and_insert util/maps.c:965
    #3 0x5575e635de01 in maps__fixup_overlap_and_insert util/maps.c:975
    #4 0x5575e63a76cf in thread__insert_map util/thread.c:357
    #5 0x5575e633bfe9 in machine__process_mmap2_event util/machine.c:1745
    #6 0x5575e633dafd in machine__process_event util/machine.c:1928
    #7 0x5575e5ea78e7 in trace__process_event /usr/src/perf_selftests-x86_6=
4-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-=
trace.c:1949
    #8 0x5575e5ec0607 in trace__handle_event /usr/src/perf_selftests-x86_64=
-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-t=
race.c:3601
    #9 0x5575e5ec2a4e in __trace__deliver_event /usr/src/perf_selftests-x86=
_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builti=
n-trace.c:4180
    #10 0x5575e5ec314e in ordered_events__deliver_event /usr/src/perf_selft=
ests-x86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/per=
f/builtin-trace.c:4226
    #11 0x5575e6398bb6 in do_flush util/ordered-events.c:245
    #12 0x5575e6399a57 in __ordered_events__flush util/ordered-events.c:324
    #13 0x5575e6399f6a in ordered_events__flush util/ordered-events.c:342
    #14 0x5575e5ec7f39 in trace__run /usr/src/perf_selftests-x86_64-rhel-9.=
4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:4=
641
    #15 0x5575e5ed894b in cmd_trace /usr/src/perf_selftests-x86_64-rhel-9.4=
-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:58=
20
    #16 0x5575e5eec211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9=
.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:351
    #17 0x5575e5eecacf in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf=
.c:404
    #18 0x5575e5eed025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-=
bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:448
    #19 0x5575e5eed7cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-=
609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:556
    #20 0x7f857996e249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 112 byte(s) in 1 object(s) allocated from:
    #0 0x7f857a9833b7 in __interceptor_calloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:77
    #1 0x5575e5f17fde in zalloc ../../lib/zalloc.c:8
    #2 0x5575e5ea3bce in thread_trace__new /usr/src/perf_selftests-x86_64-r=
hel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-tra=
ce.c:1587
    #3 0x5575e5ea40e8 in thread__trace /usr/src/perf_selftests-x86_64-rhel-=
9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c=
:1625
    #4 0x5575e5eb33b0 in trace__sys_enter /usr/src/perf_selftests-x86_64-rh=
el-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trac=
e.c:2767
    #5 0x5575e5ec0d0a in trace__handle_event /usr/src/perf_selftests-x86_64=
-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-t=
race.c:3623
    #6 0x5575e5ec2a4e in __trace__deliver_event /usr/src/perf_selftests-x86=
_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builti=
n-trace.c:4180
    #7 0x5575e5ec314e in ordered_events__deliver_event /usr/src/perf_selfte=
sts-x86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf=
/builtin-trace.c:4226
    #8 0x5575e6398bb6 in do_flush util/ordered-events.c:245
    #9 0x5575e6399a57 in __ordered_events__flush util/ordered-events.c:324
    #10 0x5575e6399f6a in ordered_events__flush util/ordered-events.c:342
    #11 0x5575e5ec7f39 in trace__run /usr/src/perf_selftests-x86_64-rhel-9.=
4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:4=
641
    #12 0x5575e5ed894b in cmd_trace /usr/src/perf_selftests-x86_64-rhel-9.4=
-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:58=
20
    #13 0x5575e5eec211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9=
.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:351
    #14 0x5575e5eecacf in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf=
.c:404
    #15 0x5575e5eed025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-=
bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:448
    #16 0x5575e5eed7cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-=
609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:556
    #17 0x7f857996e249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 107 byte(s) in 6 object(s) allocated from:
    #0 0x7f857a93b77b in __interceptor_strdup ../../../../src/libsanitizer/=
asan/asan_interceptors.cpp:439
    #1 0x5575e62ac1c7 in dso__set_basename util/dsos.c:316
    #2 0x5575e62ac32a in __dsos__addnew_id util/dsos.c:336
    #3 0x5575e62ac400 in __dsos__findnew_id util/dsos.c:350
    #4 0x5575e62ac48a in dsos__findnew_id util/dsos.c:357
    #5 0x5575e634b668 in machine__findnew_dso_id util/machine.c:3153
    #6 0x5575e63515c1 in map__new util/map.c:169
    #7 0x5575e633bfbb in machine__process_mmap2_event util/machine.c:1736
    #8 0x5575e633dafd in machine__process_event util/machine.c:1928
    #9 0x5575e5ea78e7 in trace__process_event /usr/src/perf_selftests-x86_6=
4-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-=
trace.c:1949
    #10 0x5575e5ec0607 in trace__handle_event /usr/src/perf_selftests-x86_6=
4-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-=
trace.c:3601
    #11 0x5575e5ec2a4e in __trace__deliver_event /usr/src/perf_selftests-x8=
6_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/built=
in-trace.c:4180
    #12 0x5575e5ec314e in ordered_events__deliver_event /usr/src/perf_selft=
ests-x86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/per=
f/builtin-trace.c:4226
    #13 0x5575e6398bb6 in do_flush util/ordered-events.c:245
    #14 0x5575e6399a57 in __ordered_events__flush util/ordered-events.c:324
    #15 0x5575e6399f6a in ordered_events__flush util/ordered-events.c:342
    #16 0x5575e5ec7f39 in trace__run /usr/src/perf_selftests-x86_64-rhel-9.=
4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:4=
641
    #17 0x5575e5ed894b in cmd_trace /usr/src/perf_selftests-x86_64-rhel-9.4=
-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:58=
20
    #18 0x5575e5eec211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9=
.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:351
    #19 0x5575e5eecacf in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf=
.c:404
    #20 0x5575e5eed025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-=
bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:448
    #21 0x5575e5eed7cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-=
609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:556
    #22 0x7f857996e249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 104 byte(s) in 1 object(s) allocated from:
    #0 0x7f857a9833b7 in __interceptor_calloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:77
    #1 0x5575e5f17fde in zalloc ../../lib/zalloc.c:8
    #2 0x5575e6357f49 in maps__new util/maps.c:248
    #3 0x5575e63a583f in thread__init_maps util/thread.c:30
    #4 0x5575e63315fa in __machine__findnew_thread util/machine.c:516
    #5 0x5575e63317ab in machine__findnew_thread util/machine.c:530
    #6 0x5575e6331bb0 in machine__process_comm_event util/machine.c:569
    #7 0x5575e633da81 in machine__process_event util/machine.c:1920
    #8 0x5575e5ea78e7 in trace__process_event /usr/src/perf_selftests-x86_6=
4-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-=
trace.c:1949
    #9 0x5575e5ec0607 in trace__handle_event /usr/src/perf_selftests-x86_64=
-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-t=
race.c:3601
    #10 0x5575e5ec2a4e in __trace__deliver_event /usr/src/perf_selftests-x8=
6_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/built=
in-trace.c:4180
    #11 0x5575e5ec314e in ordered_events__deliver_event /usr/src/perf_selft=
ests-x86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/per=
f/builtin-trace.c:4226
    #12 0x5575e6398bb6 in do_flush util/ordered-events.c:245
    #13 0x5575e6399a57 in __ordered_events__flush util/ordered-events.c:324
    #14 0x5575e6399f6a in ordered_events__flush util/ordered-events.c:342
    #15 0x5575e5ec7f39 in trace__run /usr/src/perf_selftests-x86_64-rhel-9.=
4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:4=
641
    #16 0x5575e5ed894b in cmd_trace /usr/src/perf_selftests-x86_64-rhel-9.4=
-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:58=
20
    #17 0x5575e5eec211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9=
.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:351
    #18 0x5575e5eecacf in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf=
.c:404
    #19 0x5575e5eed025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-=
bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:448
    #20 0x5575e5eed7cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-=
609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:556
    #21 0x7f857996e249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 64 byte(s) in 8 object(s) allocated from:
    #0 0x7f857a9839cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x5575e63554c8 in map__get util/map.h:189
    #2 0x5575e635c6d1 in __maps__insert_sorted util/maps.c:791
    #3 0x5575e635dd4c in __maps__fixup_overlap_and_insert util/maps.c:965
    #4 0x5575e635de01 in maps__fixup_overlap_and_insert util/maps.c:975
    #5 0x5575e63a76cf in thread__insert_map util/thread.c:357
    #6 0x5575e633bfe9 in machine__process_mmap2_event util/machine.c:1745
    #7 0x5575e633dafd in machine__process_event util/machine.c:1928
    #8 0x5575e5ea78e7 in trace__process_event /usr/src/perf_selftests-x86_6=
4-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-=
trace.c:1949
    #9 0x5575e5ec0607 in trace__handle_event /usr/src/perf_selftests-x86_64=
-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-t=
race.c:3601
    #10 0x5575e5ec2a4e in __trace__deliver_event /usr/src/perf_selftests-x8=
6_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/built=
in-trace.c:4180
    #11 0x5575e5ec314e in ordered_events__deliver_event /usr/src/perf_selft=
ests-x86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/per=
f/builtin-trace.c:4226
    #12 0x5575e6398bb6 in do_flush util/ordered-events.c:245
    #13 0x5575e6399a57 in __ordered_events__flush util/ordered-events.c:324
    #14 0x5575e6399f6a in ordered_events__flush util/ordered-events.c:342
    #15 0x5575e5ec7f39 in trace__run /usr/src/perf_selftests-x86_64-rhel-9.=
4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:4=
641
    #16 0x5575e5ed894b in cmd_trace /usr/src/perf_selftests-x86_64-rhel-9.4=
-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:58=
20
    #17 0x5575e5eec211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9=
.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:351
    #18 0x5575e5eecacf in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf=
.c:404
    #19 0x5575e5eed025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-=
bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:448
    #20 0x5575e5eed7cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-=
609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:556
    #21 0x7f857996e249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 64 byte(s) in 8 object(s) allocated from:
    #0 0x7f857a9839cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x5575e62a64c6 in dso__get util/dso.c:1607
    #2 0x5575e6350f6f in map__init util/map.c:112
    #3 0x5575e635166b in map__new util/map.c:175
    #4 0x5575e633bfbb in machine__process_mmap2_event util/machine.c:1736
    #5 0x5575e633dafd in machine__process_event util/machine.c:1928
    #6 0x5575e5ea78e7 in trace__process_event /usr/src/perf_selftests-x86_6=
4-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-=
trace.c:1949
    #7 0x5575e5ec0607 in trace__handle_event /usr/src/perf_selftests-x86_64=
-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-t=
race.c:3601
    #8 0x5575e5ec2a4e in __trace__deliver_event /usr/src/perf_selftests-x86=
_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builti=
n-trace.c:4180
    #9 0x5575e5ec314e in ordered_events__deliver_event /usr/src/perf_selfte=
sts-x86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf=
/builtin-trace.c:4226
    #10 0x5575e6398bb6 in do_flush util/ordered-events.c:245
    #11 0x5575e6399a57 in __ordered_events__flush util/ordered-events.c:324
    #12 0x5575e6399f6a in ordered_events__flush util/ordered-events.c:342
    #13 0x5575e5ec7f39 in trace__run /usr/src/perf_selftests-x86_64-rhel-9.=
4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:4=
641
    #14 0x5575e5ed894b in cmd_trace /usr/src/perf_selftests-x86_64-rhel-9.4=
-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:58=
20
    #15 0x5575e5eec211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9=
.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:351
    #16 0x5575e5eecacf in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf=
.c:404
    #17 0x5575e5eed025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-=
bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:448
    #18 0x5575e5eed7cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-=
609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:556
    #19 0x7f857996e249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 48 byte(s) in 6 object(s) allocated from:
    #0 0x7f857a9839cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x5575e639d8e1 in nsinfo__get util/namespaces.c:230
    #2 0x5575e635147a in map__new util/map.c:142
    #3 0x5575e633bfbb in machine__process_mmap2_event util/machine.c:1736
    #4 0x5575e633dafd in machine__process_event util/machine.c:1928
    #5 0x5575e5ea78e7 in trace__process_event /usr/src/perf_selftests-x86_6=
4-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-=
trace.c:1949
    #6 0x5575e5ec0607 in trace__handle_event /usr/src/perf_selftests-x86_64=
-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-t=
race.c:3601
    #7 0x5575e5ec2a4e in __trace__deliver_event /usr/src/perf_selftests-x86=
_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builti=
n-trace.c:4180
    #8 0x5575e5ec314e in ordered_events__deliver_event /usr/src/perf_selfte=
sts-x86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf=
/builtin-trace.c:4226
    #9 0x5575e6398bb6 in do_flush util/ordered-events.c:245
    #10 0x5575e6399a57 in __ordered_events__flush util/ordered-events.c:324
    #11 0x5575e6399f6a in ordered_events__flush util/ordered-events.c:342
    #12 0x5575e5ec7f39 in trace__run /usr/src/perf_selftests-x86_64-rhel-9.=
4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:4=
641
    #13 0x5575e5ed894b in cmd_trace /usr/src/perf_selftests-x86_64-rhel-9.4=
-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:58=
20
    #14 0x5575e5eec211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9=
.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:351
    #15 0x5575e5eecacf in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf=
.c:404
    #16 0x5575e5eed025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-=
bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:448
    #17 0x5575e5eed7cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-=
609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:556
    #18 0x7f857996e249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 48 byte(s) in 1 object(s) allocated from:
    #0 0x7f857a9833b7 in __interceptor_calloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:77
    #1 0x5575e5f17fde in zalloc ../../lib/zalloc.c:8
    #2 0x5575e63a1a99 in comm__new util/comm.c:194
    #3 0x5575e63a5b75 in thread__new util/thread.c:66
    #4 0x5575e63aa3b0 in threads__findnew util/threads.c:116
    #5 0x5575e6331574 in __machine__findnew_thread util/machine.c:506
    #6 0x5575e63317ab in machine__findnew_thread util/machine.c:530
    #7 0x5575e6331bb0 in machine__process_comm_event util/machine.c:569
    #8 0x5575e633da81 in machine__process_event util/machine.c:1920
    #9 0x5575e5ea78e7 in trace__process_event /usr/src/perf_selftests-x86_6=
4-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-=
trace.c:1949
    #10 0x5575e5ec0607 in trace__handle_event /usr/src/perf_selftests-x86_6=
4-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-=
trace.c:3601
    #11 0x5575e5ec2a4e in __trace__deliver_event /usr/src/perf_selftests-x8=
6_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/built=
in-trace.c:4180
    #12 0x5575e5ec314e in ordered_events__deliver_event /usr/src/perf_selft=
ests-x86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/per=
f/builtin-trace.c:4226
    #13 0x5575e6398bb6 in do_flush util/ordered-events.c:245
    #14 0x5575e6399a57 in __ordered_events__flush util/ordered-events.c:324
    #15 0x5575e6399f6a in ordered_events__flush util/ordered-events.c:342
    #16 0x5575e5ec7f39 in trace__run /usr/src/perf_selftests-x86_64-rhel-9.=
4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:4=
641
    #17 0x5575e5ed894b in cmd_trace /usr/src/perf_selftests-x86_64-rhel-9.4=
-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:58=
20
    #18 0x5575e5eec211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9=
.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:351
    #19 0x5575e5eecacf in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf=
.c:404
    #20 0x5575e5eed025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-=
bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:448
    #21 0x5575e5eed7cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-=
609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:556
    #22 0x7f857996e249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x7f857a9833b7 in __interceptor_calloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:77
    #1 0x5575e639c9bc in nsinfo__alloc util/namespaces.c:147
    #2 0x5575e639cf60 in nsinfo__copy util/namespaces.c:192
    #3 0x5575e6351537 in map__new util/map.c:160
    #4 0x5575e633bfbb in machine__process_mmap2_event util/machine.c:1736
    #5 0x5575e633dafd in machine__process_event util/machine.c:1928
    #6 0x5575e5ea78e7 in trace__process_event /usr/src/perf_selftests-x86_6=
4-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-=
trace.c:1949
    #7 0x5575e5ec0607 in trace__handle_event /usr/src/perf_selftests-x86_64=
-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-t=
race.c:3601
    #8 0x5575e5ec2a4e in __trace__deliver_event /usr/src/perf_selftests-x86=
_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builti=
n-trace.c:4180
    #9 0x5575e5ec314e in ordered_events__deliver_event /usr/src/perf_selfte=
sts-x86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf=
/builtin-trace.c:4226
    #10 0x5575e6398bb6 in do_flush util/ordered-events.c:245
    #11 0x5575e6399a57 in __ordered_events__flush util/ordered-events.c:324
    #12 0x5575e6399f6a in ordered_events__flush util/ordered-events.c:342
    #13 0x5575e5ec7f39 in trace__run /usr/src/perf_selftests-x86_64-rhel-9.=
4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:4=
641
    #14 0x5575e5ed894b in cmd_trace /usr/src/perf_selftests-x86_64-rhel-9.4=
-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:58=
20
    #15 0x5575e5eec211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9=
.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:351
    #16 0x5575e5eecacf in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf=
.c:404
    #17 0x5575e5eed025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-=
bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:448
    #18 0x5575e5eed7cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-=
609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:556
    #19 0x7f857996e249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x7f857a9839cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x5575e639c9d5 in nsinfo__alloc util/namespaces.c:148
    #2 0x5575e639cf60 in nsinfo__copy util/namespaces.c:192
    #3 0x5575e6351537 in map__new util/map.c:160
    #4 0x5575e633bfbb in machine__process_mmap2_event util/machine.c:1736
    #5 0x5575e633dafd in machine__process_event util/machine.c:1928
    #6 0x5575e5ea78e7 in trace__process_event /usr/src/perf_selftests-x86_6=
4-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-=
trace.c:1949
    #7 0x5575e5ec0607 in trace__handle_event /usr/src/perf_selftests-x86_64=
-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-t=
race.c:3601
    #8 0x5575e5ec2a4e in __trace__deliver_event /usr/src/perf_selftests-x86=
_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builti=
n-trace.c:4180
    #9 0x5575e5ec314e in ordered_events__deliver_event /usr/src/perf_selfte=
sts-x86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf=
/builtin-trace.c:4226
    #10 0x5575e6398bb6 in do_flush util/ordered-events.c:245
    #11 0x5575e6399a57 in __ordered_events__flush util/ordered-events.c:324
    #12 0x5575e6399f6a in ordered_events__flush util/ordered-events.c:342
    #13 0x5575e5ec7f39 in trace__run /usr/src/perf_selftests-x86_64-rhel-9.=
4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:4=
641
    #14 0x5575e5ed894b in cmd_trace /usr/src/perf_selftests-x86_64-rhel-9.4=
-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:58=
20
    #15 0x5575e5eec211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9=
.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:351
    #16 0x5575e5eecacf in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf=
.c:404
    #17 0x5575e5eed025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-=
bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:448
    #18 0x5575e5eed7cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-=
609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:556
    #19 0x7f857996e249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x7f857a9839cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x5575e63a0038 in comm_str__get util/comm.c:58
    #2 0x5575e63a1a49 in comm_strs__findnew util/comm.c:189
    #3 0x5575e63a1d01 in comm__override util/comm.c:215
    #4 0x5575e63a6f62 in ____thread__set_comm util/thread.c:250
    #5 0x5575e63a70af in __thread__set_comm util/thread.c:274
    #6 0x5575e6331e80 in machine__process_comm_event util/machine.c:582
    #7 0x5575e633da81 in machine__process_event util/machine.c:1920
    #8 0x5575e5ea78e7 in trace__process_event /usr/src/perf_selftests-x86_6=
4-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-=
trace.c:1949
    #9 0x5575e5ec0607 in trace__handle_event /usr/src/perf_selftests-x86_64=
-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-t=
race.c:3601
    #10 0x5575e5ec2a4e in __trace__deliver_event /usr/src/perf_selftests-x8=
6_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/built=
in-trace.c:4180
    #11 0x5575e5ec314e in ordered_events__deliver_event /usr/src/perf_selft=
ests-x86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/per=
f/builtin-trace.c:4226
    #12 0x5575e6398bb6 in do_flush util/ordered-events.c:245
    #13 0x5575e6399a57 in __ordered_events__flush util/ordered-events.c:324
    #14 0x5575e6399f6a in ordered_events__flush util/ordered-events.c:342
    #15 0x5575e5ec7f39 in trace__run /usr/src/perf_selftests-x86_64-rhel-9.=
4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:4=
641
    #16 0x5575e5ed894b in cmd_trace /usr/src/perf_selftests-x86_64-rhel-9.4=
-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:58=
20
    #17 0x5575e5eec211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9=
.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:351
    #18 0x5575e5eecacf in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf=
.c:404
    #19 0x5575e5eed025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-=
bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:448
    #20 0x5575e5eed7cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-=
609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:556
    #21 0x7f857996e249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x7f857a9839cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x5575e6357f62 in maps__new util/maps.c:250
    #2 0x5575e63a583f in thread__init_maps util/thread.c:30
    #3 0x5575e63315fa in __machine__findnew_thread util/machine.c:516
    #4 0x5575e63317ab in machine__findnew_thread util/machine.c:530
    #5 0x5575e6331bb0 in machine__process_comm_event util/machine.c:569
    #6 0x5575e633da81 in machine__process_event util/machine.c:1920
    #7 0x5575e5ea78e7 in trace__process_event /usr/src/perf_selftests-x86_6=
4-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-=
trace.c:1949
    #8 0x5575e5ec0607 in trace__handle_event /usr/src/perf_selftests-x86_64=
-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-t=
race.c:3601
    #9 0x5575e5ec2a4e in __trace__deliver_event /usr/src/perf_selftests-x86=
_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builti=
n-trace.c:4180
    #10 0x5575e5ec314e in ordered_events__deliver_event /usr/src/perf_selft=
ests-x86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/per=
f/builtin-trace.c:4226
    #11 0x5575e6398bb6 in do_flush util/ordered-events.c:245
    #12 0x5575e6399a57 in __ordered_events__flush util/ordered-events.c:324
    #13 0x5575e6399f6a in ordered_events__flush util/ordered-events.c:342
    #14 0x5575e5ec7f39 in trace__run /usr/src/perf_selftests-x86_64-rhel-9.=
4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:4=
641
    #15 0x5575e5ed894b in cmd_trace /usr/src/perf_selftests-x86_64-rhel-9.4=
-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:58=
20
    #16 0x5575e5eec211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9=
.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:351
    #17 0x5575e5eecacf in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf=
.c:404
    #18 0x5575e5eed025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-=
bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:448
    #19 0x5575e5eed7cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-=
609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:556
    #20 0x7f857996e249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

Indirect leak of 8 byte(s) in 1 object(s) allocated from:
    #0 0x7f857a9839cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x5575e639c9d5 in nsinfo__alloc util/namespaces.c:148
    #2 0x5575e639cb09 in nsinfo__new util/namespaces.c:161
    #3 0x5575e63a5c95 in thread__new util/thread.c:73
    #4 0x5575e63aa3b0 in threads__findnew util/threads.c:116
    #5 0x5575e6331574 in __machine__findnew_thread util/machine.c:506
    #6 0x5575e63317ab in machine__findnew_thread util/machine.c:530
    #7 0x5575e6331bb0 in machine__process_comm_event util/machine.c:569
    #8 0x5575e633da81 in machine__process_event util/machine.c:1920
    #9 0x5575e5ea78e7 in trace__process_event /usr/src/perf_selftests-x86_6=
4-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-=
trace.c:1949
    #10 0x5575e5ec0607 in trace__handle_event /usr/src/perf_selftests-x86_6=
4-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-=
trace.c:3601
    #11 0x5575e5ec2a4e in __trace__deliver_event /usr/src/perf_selftests-x8=
6_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/built=
in-trace.c:4180
    #12 0x5575e5ec314e in ordered_events__deliver_event /usr/src/perf_selft=
ests-x86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/per=
f/builtin-trace.c:4226
    #13 0x5575e6398bb6 in do_flush util/ordered-events.c:245
    #14 0x5575e6399a57 in __ordered_events__flush util/ordered-events.c:324
    #15 0x5575e6399f6a in ordered_events__flush util/ordered-events.c:342
    #16 0x5575e5ec7f39 in trace__run /usr/src/perf_selftests-x86_64-rhel-9.=
4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:4=
641
    #17 0x5575e5ed894b in cmd_trace /usr/src/perf_selftests-x86_64-rhel-9.4=
-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/builtin-trace.c:58=
20
    #18 0x5575e5eec211 in run_builtin /usr/src/perf_selftests-x86_64-rhel-9=
.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:351
    #19 0x5575e5eecacf in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf=
.c:404
    #20 0x5575e5eed025 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-=
bpf-609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:448
    #21 0x5575e5eed7cc in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-=
609a86901e6fd886f1139aed8f8c66d982f2afed/tools/perf/perf.c:556
    #22 0x7f857996e249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)

SUMMARY: AddressSanitizer: 72041 byte(s) leaked in 56 allocation(s).
---- end(-1) ----
109: perf trace BTF general tests                                    : FAIL=
ED!
2025-06-12 08:31:54 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 110 -v
110: perf trace exit race                                            : Runn=
ing (1 active)
110: perf trace exit race                                            : Ok
2025-06-12 08:32:16 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 111 -v
111: perf trace record and replay                                    : Runn=
ing (1 active)
111: perf trace record and replay                                    : Ok
2025-06-12 08:32:23 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 112 -v
112: Number of exit events of a simple workload                      : Runn=
ing (1 active)
112: Number of exit events of a simple workload                      : Ok
2025-06-12 08:32:23 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 113 -v
113: Track with sched_switch                                         : Runn=
ing (1 active)
113: Track with sched_switch                                         : Ok
2025-06-12 08:32:24 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 114 -v
114: AMD IBS sample period                                           : Runn=
ing (1 active)
114: AMD IBS sample period                                           : Skip
2025-06-12 08:32:25 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 115 -v
115: CoreSight / ASM Pure Loop                                       : Runn=
ing (1 active)
115: CoreSight / ASM Pure Loop                                       : Skip
2025-06-12 08:32:25 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 116 -v
116: CoreSight / Memcpy 16k 10 Threads                               : Runn=
ing (1 active)
116: CoreSight / Memcpy 16k 10 Threads                               : Skip
2025-06-12 08:32:26 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 117 -v
117: CoreSight / Thread Loop 10 Threads - Check TID                  : Runn=
ing (1 active)
117: CoreSight / Thread Loop 10 Threads - Check TID                  : Skip
2025-06-12 08:32:26 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 118 -v
118: CoreSight / Thread Loop 2 Threads - Check TID                   : Runn=
ing (1 active)
118: CoreSight / Thread Loop 2 Threads - Check TID                   : Skip
2025-06-12 08:32:27 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 119 -v
119: CoreSight / Unroll Loop Thread 10                               : Runn=
ing (1 active)
119: CoreSight / Unroll Loop Thread 10                               : Skip
2025-06-12 08:32:28 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 120 -v
120: perftool-testsuite_probe                                        : Runn=
ing (1 active)
--- start ---
test child forked, pid 7863
Probing warn_thunk_thunk
Result polluted by broken DWARF, trying another probe
Probing asm_exc_divide_error
-- [ PASS ] -- perf_probe :: test_adding_blacklisted :: adding blacklisted =
function asm_exc_divide_error
-- [ PASS ] -- perf_probe :: test_adding_blacklisted :: listing blacklisted=
 probe (should NOT be listed)
## [ PASS ] ## perf_probe :: test_adding_blacklisted SUMMARY
-- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe inode_permi=
ssion ::=20
-- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe inode_permi=
ssion :: -a
-- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe inode_permi=
ssion :: --add
-- [ PASS ] -- perf_probe :: test_adding_kernel :: listing added probe :: p=
erf list
-- [ PASS ] -- perf_probe :: test_adding_kernel :: listing added probe :: p=
erf probe -l
-- [ PASS ] -- perf_probe :: test_adding_kernel :: using added probe
-- [ PASS ] -- perf_probe :: test_adding_kernel :: deleting added probe
-- [ PASS ] -- perf_probe :: test_adding_kernel :: listing removed probe (s=
hould NOT be listed)
-- [ PASS ] -- perf_probe :: test_adding_kernel :: dry run :: adding probe
-- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding probes :: f=
irst probe adding
-- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding probes :: s=
econd probe adding (without force)
-- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding probes :: s=
econd probe adding (with force)
-- [ PASS ] -- perf_probe :: test_adding_kernel :: using doubled probe
-- [ PASS ] -- perf_probe :: test_adding_kernel :: removing multiple probes
Regexp not found: "probe:vfs_mknod"
Regexp not found: "probe:vfs_create"
Regexp not found: "probe:vfs_rmdir"
Regexp not found: "probe:vfs_link"
Regexp not found: "probe:vfs_write"
-- [ FAIL ] -- perf_probe :: test_adding_kernel :: wildcard adding support =
(command exitcode + output regexp parsing)
-- [ PASS ] -- perf_probe :: test_adding_kernel :: non-existing variable
-- [ PASS ] -- perf_probe :: test_adding_kernel :: function with retval :: =
add
-- [ PASS ] -- perf_probe :: test_adding_kernel :: function with retval :: =
record
-- [ PASS ] -- perf_probe :: test_adding_kernel :: function argument probin=
g :: script
## [ FAIL ] ## perf_probe :: test_adding_kernel SUMMARY :: 1 failures found=
=20
-- [ SKIP ] -- perf_probe :: test_basic :: help message :: testcase skipped
-- [ PASS ] -- perf_probe :: test_basic :: usage message
-- [ PASS ] -- perf_probe :: test_basic :: quiet switch
## [ PASS ] ## perf_probe :: test_basic SUMMARY
-- [ PASS ] -- perf_probe :: test_invalid_options :: missing argument for -=
a
-- [ PASS ] -- perf_probe :: test_invalid_options :: missing argument for -=
d
-- [ PASS ] -- perf_probe :: test_invalid_options :: missing argument for -=
L
-- [ PASS ] -- perf_probe :: test_invalid_options :: missing argument for -=
V
-- [ PASS ] -- perf_probe :: test_invalid_options :: unnecessary argument f=
or -F
-- [ PASS ] -- perf_probe :: test_invalid_options :: unnecessary argument f=
or -l
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive opt=
ions :: -a xxx -d xxx
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive opt=
ions :: -a xxx -L foo
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive opt=
ions :: -a xxx -V foo
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive opt=
ions :: -a xxx -l
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive opt=
ions :: -a xxx -F
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive opt=
ions :: -d xxx -L foo
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive opt=
ions :: -d xxx -V foo
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive opt=
ions :: -d xxx -l
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive opt=
ions :: -d xxx -F
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive opt=
ions :: -L foo -V bar
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive opt=
ions :: -L foo -l
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive opt=
ions :: -L foo -F
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive opt=
ions :: -V foo -l
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive opt=
ions :: -V foo -F
-- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive opt=
ions :: -l -F
## [ PASS ] ## perf_probe :: test_invalid_options SUMMARY
-- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions=
 :: func
-- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions=
 :: func:10
-- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions=
 :: func:0-10
-- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions=
 :: func:2+10
-- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions=
 :: func@source.c
-- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions=
 :: func@source.c:1
-- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions=
 :: source.c:1
-- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions=
 :: source.c:1+1
-- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions=
 :: source.c:1-10
-- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable descriptio=
ns :: func:foo
-- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable descriptio=
ns :: func:1-foo
-- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable descriptio=
ns :: func:1+foo
-- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable descriptio=
ns :: func;lazy\*pattern
## [ PASS ] ## perf_probe :: test_line_semantics SUMMARY
---- end(-1) ----
120: perftool-testsuite_probe                                        : FAIL=
ED!
2025-06-12 08:34:28 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 121 -v
121: perftool-testsuite_report                                       : Runn=
ing (1 active)
--- start ---
test child forked, pid 8589
-- [ PASS ] -- perf_report :: setup :: prepare the perf.data file
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.363 MB /tmp/perftool-testsuite_report.3=
fm/perf_report/perf.data.1 (7443 samples) ]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-- [ PASS ] -- perf_report :: setup :: prepare the perf.data.1 file
## [ PASS ] ## perf_report :: setup SUMMARY
-- [ SKIP ] -- perf_report :: test_basic :: help message :: testcase skippe=
d
Line did not match any pattern: "Kernel address maps (/proc/{kallsyms,modul=
es}) were restricted."
Line did not match any pattern: ""
Line did not match any pattern: "Check /proc/sys/kernel/kptr_restrict befor=
e running 'perf record'."
Line did not match any pattern: ""
Line did not match any pattern: "If some relocation was applied (e.g. kexec=
) symbols may be misresolved."
Line did not match any pattern: ""
Line did not match any pattern: "Samples in kernel modules can't be resolve=
d as well."
Line did not match any pattern: ""
Line did not match any pattern: ""
Line did not match any pattern: "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D"
Line did not match any pattern: "=3D=3D8774=3D=3DERROR: LeakSanitizer: dete=
cted memory leaks"
Line did not match any pattern: ""
Line did not match any pattern: "Direct leak of 31008 byte(s) in 4 object(s=
) allocated from:"
Line did not match any pattern: "    #0 0x7ff86125e3b7 in __interceptor_cal=
loc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77"
Line did not match any pattern: "    #1 0x7ff861090743  (/lib/x86_64-linux-=
gnu/libelf.so.1+0x3743)"
Line did not match any pattern: ""
Line did not match any pattern: "Indirect leak of 9216 byte(s) in 4 object(=
s) allocated from:"
Line did not match any pattern: "    #0 0x7ff86125e9cf in __interceptor_mal=
loc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69"
Line did not match any pattern: "    #1 0x7ff8610979f0  (/lib/x86_64-linux-=
gnu/libelf.so.1+0xa9f0)"
Line did not match any pattern: ""
-- [ FAIL ] -- perf_report :: test_basic :: basic execution (command exitco=
de + output regexp parsing)
Line did not match any pattern: "Kernel address maps (/proc/{kallsyms,modul=
es}) were restricted."
Line did not match any pattern: ""
Line did not match any pattern: "Check /proc/sys/kernel/kptr_restrict befor=
e running 'perf record'."
Line did not match any pattern: ""
Line did not match any pattern: "If some relocation was applied (e.g. kexec=
) symbols may be misresolved."
Line did not match any pattern: ""
Line did not match any pattern: "Samples in kernel modules can't be resolve=
d as well."
Line did not match any pattern: ""
Line did not match any pattern: ""
Line did not match any pattern: "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D"
Line did not match any pattern: "=3D=3D8805=3D=3DERROR: LeakSanitizer: dete=
cted memory leaks"
Line did not match any pattern: ""
Line did not match any pattern: "Direct leak of 31008 byte(s) in 4 object(s=
) allocated from:"
Line did not match any pattern: "    #0 0x7ff7e8e5a3b7 in __interceptor_cal=
loc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77"
Line did not match any pattern: "    #1 0x7ff7e8c8c743  (/lib/x86_64-linux-=
gnu/libelf.so.1+0x3743)"
Line did not match any pattern: ""
Line did not match any pattern: "Indirect leak of 9216 byte(s) in 4 object(=
s) allocated from:"
Line did not match any pattern: "    #0 0x7ff7e8e5a9cf in __interceptor_mal=
loc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69"
Line did not match any pattern: "    #1 0x7ff7e8c939f0  (/lib/x86_64-linux-=
gnu/libelf.so.1+0xa9f0)"
Line did not match any pattern: ""
-- [ FAIL ] -- perf_report :: test_basic :: number of samples (command exit=
code + output regexp parsing)
-- [ PASS ] -- perf_report :: test_basic :: header
-- [ PASS ] -- perf_report :: test_basic :: header timestamp
Line did not match any pattern: "Kernel address maps (/proc/{kallsyms,modul=
es}) were restricted."
Line did not match any pattern: ""
Line did not match any pattern: "Check /proc/sys/kernel/kptr_restrict befor=
e running 'perf record'."
Line did not match any pattern: ""
Line did not match any pattern: "If some relocation was applied (e.g. kexec=
) symbols may be misresolved."
Line did not match any pattern: ""
Line did not match any pattern: "Samples in kernel modules can't be resolve=
d as well."
Line did not match any pattern: ""
Line did not match any pattern: ""
Line did not match any pattern: "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D"
Line did not match any pattern: "=3D=3D8858=3D=3DERROR: LeakSanitizer: dete=
cted memory leaks"
Line did not match any pattern: ""
Line did not match any pattern: "Direct leak of 31008 byte(s) in 4 object(s=
) allocated from:"
Line did not match any pattern: "    #0 0x7f1a836203b7 in __interceptor_cal=
loc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77"
Line did not match any pattern: "    #1 0x7f1a83452743  (/lib/x86_64-linux-=
gnu/libelf.so.1+0x3743)"
Line did not match any pattern: ""
Line did not match any pattern: "Indirect leak of 9216 byte(s) in 4 object(=
s) allocated from:"
Line did not match any pattern: "    #0 0x7f1a836209cf in __interceptor_mal=
loc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69"
Line did not match any pattern: "    #1 0x7f1a834599f0  (/lib/x86_64-linux-=
gnu/libelf.so.1+0xa9f0)"
Line did not match any pattern: ""
-- [ FAIL ] -- perf_report :: test_basic :: show CPU utilization (command e=
xitcode + output regexp parsing)
Line did not match any pattern: "Kernel address maps (/proc/{kallsyms,modul=
es}) were restricted."
Line did not match any pattern: ""
Line did not match any pattern: "Check /proc/sys/kernel/kptr_restrict befor=
e running 'perf record'."
Line did not match any pattern: ""
Line did not match any pattern: "If some relocation was applied (e.g. kexec=
) symbols may be misresolved."
Line did not match any pattern: ""
Line did not match any pattern: "Samples in kernel modules can't be resolve=
d as well."
Line did not match any pattern: ""
Line did not match any pattern: ""
Line did not match any pattern: "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D"
Line did not match any pattern: "=3D=3D8889=3D=3DERROR: LeakSanitizer: dete=
cted memory leaks"
Line did not match any pattern: ""
Line did not match any pattern: "Direct leak of 31008 byte(s) in 4 object(s=
) allocated from:"
Line did not match any pattern: "    #0 0x7f3243f2e3b7 in __interceptor_cal=
loc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77"
Line did not match any pattern: "    #1 0x7f3243d60743  (/lib/x86_64-linux-=
gnu/libelf.so.1+0x3743)"
Line did not match any pattern: ""
Line did not match any pattern: "Indirect leak of 9216 byte(s) in 4 object(=
s) allocated from:"
Line did not match any pattern: "    #0 0x7f3243f2e9cf in __interceptor_mal=
loc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69"
Line did not match any pattern: "    #1 0x7f3243d679f0  (/lib/x86_64-linux-=
gnu/libelf.so.1+0xa9f0)"
Line did not match any pattern: ""
-- [ FAIL ] -- perf_report :: test_basic :: pid (command exitcode + output =
regexp parsing)
Line did not match any pattern: "Kernel address maps (/proc/{kallsyms,modul=
es}) were restricted."
Line did not match any pattern: ""
Line did not match any pattern: "Check /proc/sys/kernel/kptr_restrict befor=
e running 'perf record'."
Line did not match any pattern: ""
Line did not match any pattern: "If some relocation was applied (e.g. kexec=
) symbols may be misresolved."
Line did not match any pattern: ""
Line did not match any pattern: "Samples in kernel modules can't be resolve=
d as well."
Line did not match any pattern: ""
Line did not match any pattern: ""
Line did not match any pattern: "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D"
Line did not match any pattern: "=3D=3D8919=3D=3DERROR: LeakSanitizer: dete=
cted memory leaks"
Line did not match any pattern: ""
Line did not match any pattern: "Direct leak of 31008 byte(s) in 4 object(s=
) allocated from:"
Line did not match any pattern: "    #0 0x7ffb48cb83b7 in __interceptor_cal=
loc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77"
Line did not match any pattern: "    #1 0x7ffb48aea743  (/lib/x86_64-linux-=
gnu/libelf.so.1+0x3743)"
Line did not match any pattern: ""
Line did not match any pattern: "Indirect leak of 9216 byte(s) in 4 object(=
s) allocated from:"
Line did not match any pattern: "    #0 0x7ffb48cb89cf in __interceptor_mal=
loc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69"
Line did not match any pattern: "    #1 0x7ffb48af19f0  (/lib/x86_64-linux-=
gnu/libelf.so.1+0xa9f0)"
Line did not match any pattern: ""
-- [ FAIL ] -- perf_report :: test_basic :: non-existing symbol (command ex=
itcode + output regexp parsing)
Line did not match any pattern: "Kernel address maps (/proc/{kallsyms,modul=
es}) were restricted."
Line did not match any pattern: ""
Line did not match any pattern: "Check /proc/sys/kernel/kptr_restrict befor=
e running 'perf record'."
Line did not match any pattern: ""
Line did not match any pattern: "If some relocation was applied (e.g. kexec=
) symbols may be misresolved."
Line did not match any pattern: ""
Line did not match any pattern: "Samples in kernel modules can't be resolve=
d as well."
Line did not match any pattern: ""
Line did not match any pattern: ""
Line did not match any pattern: "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D"
Line did not match any pattern: "=3D=3D8947=3D=3DERROR: LeakSanitizer: dete=
cted memory leaks"
Line did not match any pattern: ""
Line did not match any pattern: "Direct leak of 31008 byte(s) in 4 object(s=
) allocated from:"
Line did not match any pattern: "    #0 0x7f3d86ba73b7 in __interceptor_cal=
loc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77"
Line did not match any pattern: "    #1 0x7f3d869d9743  (/lib/x86_64-linux-=
gnu/libelf.so.1+0x3743)"
Line did not match any pattern: ""
Line did not match any pattern: "Indirect leak of 9216 byte(s) in 4 object(=
s) allocated from:"
Line did not match any pattern: "    #0 0x7f3d86ba79cf in __interceptor_mal=
loc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69"
Line did not match any pattern: "    #1 0x7f3d869e09f0  (/lib/x86_64-linux-=
gnu/libelf.so.1+0xa9f0)"
Line did not match any pattern: ""
-- [ FAIL ] -- perf_report :: test_basic :: symbol filter (command exitcode=
 + output regexp parsing)
-- [ PASS ] -- perf_report :: test_basic :: latency header
Line did not match any pattern: "Kernel address maps (/proc/{kallsyms,modul=
es}) were restricted."
Line did not match any pattern: ""
Line did not match any pattern: "Check /proc/sys/kernel/kptr_restrict befor=
e running 'perf record'."
Line did not match any pattern: ""
Line did not match any pattern: "If some relocation was applied (e.g. kexec=
) symbols may be misresolved."
Line did not match any pattern: ""
Line did not match any pattern: "Samples in kernel modules can't be resolve=
d as well."
Line did not match any pattern: ""
Line did not match any pattern: ""
Line did not match any pattern: "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D"
Line did not match any pattern: "=3D=3D8983=3D=3DERROR: LeakSanitizer: dete=
cted memory leaks"
Line did not match any pattern: ""
Line did not match any pattern: "Direct leak of 31632 byte(s) in 4 object(s=
) allocated from:"
Line did not match any pattern: "    #0 0x7f0c4389f3b7 in __interceptor_cal=
loc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77"
Line did not match any pattern: "    #1 0x7f0c436d1743  (/lib/x86_64-linux-=
gnu/libelf.so.1+0x3743)"
Line did not match any pattern: ""
Line did not match any pattern: "Indirect leak of 9408 byte(s) in 4 object(=
s) allocated from:"
Line did not match any pattern: "    #0 0x7f0c4389f9cf in __interceptor_mal=
loc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69"
Line did not match any pattern: "    #1 0x7f0c436d89f0  (/lib/x86_64-linux-=
gnu/libelf.so.1+0xa9f0)"
Line did not match any pattern: ""
-- [ FAIL ] -- perf_report :: test_basic :: default report for latency prof=
ile (command exitcode + output regexp parsing)
Line did not match any pattern: "Kernel address maps (/proc/{kallsyms,modul=
es}) were restricted."
Line did not match any pattern: ""
Line did not match any pattern: "Check /proc/sys/kernel/kptr_restrict befor=
e running 'perf record'."
Line did not match any pattern: ""
Line did not match any pattern: "If some relocation was applied (e.g. kexec=
) symbols may be misresolved."
Line did not match any pattern: ""
Line did not match any pattern: "Samples in kernel modules can't be resolve=
d as well."
Line did not match any pattern: ""
Line did not match any pattern: ""
Line did not match any pattern: "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D"
Line did not match any pattern: "=3D=3D8993=3D=3DERROR: LeakSanitizer: dete=
cted memory leaks"
Line did not match any pattern: ""
Line did not match any pattern: "Direct leak of 31632 byte(s) in 4 object(s=
) allocated from:"
Line did not match any pattern: "    #0 0x7f4b6c5293b7 in __interceptor_cal=
loc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77"
Line did not match any pattern: "    #1 0x7f4b6c35b743  (/lib/x86_64-linux-=
gnu/libelf.so.1+0x3743)"
Line did not match any pattern: ""
Line did not match any pattern: "Indirect leak of 9408 byte(s) in 4 object(=
s) allocated from:"
Line did not match any pattern: "    #0 0x7f4b6c5299cf in __interceptor_mal=
loc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69"
Line did not match any pattern: "    #1 0x7f4b6c3629f0  (/lib/x86_64-linux-=
gnu/libelf.so.1+0xa9f0)"
Line did not match any pattern: ""
-- [ FAIL ] -- perf_report :: test_basic :: latency report for latency prof=
ile (command exitcode + output regexp parsing)
Line did not match any pattern: "Kernel address maps (/proc/{kallsyms,modul=
es}) were restricted."
Line did not match any pattern: ""
Line did not match any pattern: "Check /proc/sys/kernel/kptr_restrict befor=
e running 'perf record'."
Line did not match any pattern: ""
Line did not match any pattern: "If some relocation was applied (e.g. kexec=
) symbols may be misresolved."
Line did not match any pattern: ""
Line did not match any pattern: "Samples in kernel modules can't be resolve=
d as well."
Line did not match any pattern: ""
Line did not match any pattern: ""
Line did not match any pattern: "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D"
Line did not match any pattern: "=3D=3D9000=3D=3DERROR: LeakSanitizer: dete=
cted memory leaks"
Line did not match any pattern: ""
Line did not match any pattern: "Direct leak of 31632 byte(s) in 4 object(s=
) allocated from:"
Line did not match any pattern: "    #0 0x7f7f685093b7 in __interceptor_cal=
loc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77"
Line did not match any pattern: "    #1 0x7f7f6833b743  (/lib/x86_64-linux-=
gnu/libelf.so.1+0x3743)"
Line did not match any pattern: ""
Line did not match any pattern: "Indirect leak of 9408 byte(s) in 4 object(=
s) allocated from:"
Line did not match any pattern: "    #0 0x7f7f685099cf in __interceptor_mal=
loc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69"
Line did not match any pattern: "    #1 0x7f7f683429f0  (/lib/x86_64-linux-=
gnu/libelf.so.1+0xa9f0)"
Line did not match any pattern: ""
-- [ FAIL ] -- perf_report :: test_basic :: parallelism histogram (command =
exitcode + output regexp parsing)
## [ FAIL ] ## perf_report :: test_basic SUMMARY :: 9 failures found=20
---- end(-1) ----
121: perftool-testsuite_report                                       : FAIL=
ED!
2025-06-12 08:35:35 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 122 -v
122: Add vfs_getname probe to get syscall args filenames             : Runn=
ing (1 active)
122: Add vfs_getname probe to get syscall args filenames             : Skip
2025-06-12 08:35:47 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 123 -v
123: probe libc's inet_pton & backtrace it with ping                 : Runn=
ing (1 active)
--- start ---
test child forked, pid 9089

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D9148=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 19872 byte(s) in 2 object(s) allocated from:
    #0 0x7f4034a983b7 in __interceptor_calloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:77
    #1 0x7f40348ca743  (/lib/x86_64-linux-gnu/libelf.so.1+0x3743)

Indirect leak of 5952 byte(s) in 2 object(s) allocated from:
    #0 0x7f4034a989cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7f40348d19f0  (/lib/x86_64-linux-gnu/libelf.so.1+0xa9f0)

Indirect leak of 1337 byte(s) in 2 object(s) allocated from:
    #0 0x7f4034a989cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7f40348d2812  (/lib/x86_64-linux-gnu/libelf.so.1+0xb812)

SUMMARY: AddressSanitizer: 27161 byte(s) leaked in 6 allocation(s).
Pattern: ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)
FAIL: Didn't find the expected backtrace entry "ping[][0-9 \.:]+probe_libc:=
inet_pton: \([[:xdigit:]]+\)"
---- end(-1) ----
123: probe libc's inet_pton & backtrace it with ping                 : FAIL=
ED!
2025-06-12 08:35:57 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 124 -v
124: Use vfs_getname probe to get syscall args filenames             : Runn=
ing (1 active)
124: Use vfs_getname probe to get syscall args filenames             : Skip
2025-06-12 08:36:09 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 125 -v
125: perf record tests                                               : Runn=
ing (1 active)
125: perf record tests                                               : Ok
2025-06-12 08:37:30 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 126 -v
126: perf record LBR tests                                           : Runn=
ing (1 active)
--- start ---
test child forked, pid 9835
LBR callgraph
[ perf record: Woken up 10 times to write data ]
[ perf record: Captured and wrote 2.641 MB /tmp/__perf_test.perf.data.Ew2Rs=
 (9267 samples) ]
Warning:
Kernel address maps (/proc/{kallsyms,modules}) were restricted.

Check /proc/sys/kernel/kptr_restrict before running 'perf record'.

If some relocation was applied (e.g. kexec) symbols may be misresolved.

Samples in kernel modules can't be resolved as well.


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D9859=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 69408 byte(s) in 10 object(s) allocated from:
    #0 0x7f02e4ae73b7 in __interceptor_calloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:77
    #1 0x7f02e4919743  (/lib/x86_64-linux-gnu/libelf.so.1+0x3743)

Indirect leak of 20544 byte(s) in 10 object(s) allocated from:
    #0 0x7f02e4ae79cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7f02e49209f0  (/lib/x86_64-linux-gnu/libelf.so.1+0xa9f0)

Indirect leak of 3463 byte(s) in 10 object(s) allocated from:
    #0 0x7f02e4ae79cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7f02e4921812  (/lib/x86_64-linux-gnu/libelf.so.1+0xb812)

SUMMARY: AddressSanitizer: 93415 byte(s) leaked in 30 allocation(s).
# To display the perf.data header info, please use --header/--header-only o=
ptions.
#
#
# Total Lost Samples: 0
#
# Samples: 9K of event 'cycles'
# Event count (approx.): 9126645360
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
    86.59%    84.33%  perf     perf                        [.] test_loop
            |         =20
            |--42.94%--_start
            |          __libc_start_main
            |          0x7f0ca76f1248
            |          main
            |          run_argv
            |          handle_internal_command
            |          run_builtin
            |          cmd_test
            |          run_workload
            |          thloop
            |          test_loop
            |         =20
            |--41.40%--0x7f0ca77d37da
            |          0x7f0ca775313e
            |          thfunc
            |          test_loop
            |         =20
             --2.26%--test_loop
                       |         =20
                        --2.03%--0xffffffff81000e06
                                  |         =20
                                   --1.92%--0xffffffff82c72b15
                                             0xffffffff812c3303
                                             |         =20
                                              --1.71%--0xffffffff814e082b
                                                        |         =20
                                                         --1.60%--0xfffffff=
f814df30f
                                                                   |       =
  =20
                                                                    --1.56%=
--0xffffffff81500d0d
                                                                           =
   |         =20
                                                                           =
    --1.45%--0xffffffff814ddbe0
                                                                           =
              |         =20
                                                                           =
               --0.57%--0xffffffff813d4114

    44.44%     0.00%  perf     perf                        [.] _start
            |
            ---_start
               __libc_start_main
               |         =20
                --43.27%--0x7f0ca76f1248
                          main
                          |         =20
                           --43.00%--run_argv
                                     handle_internal_command
                                     run_builtin
                                     cmd_test
                                     run_workload
                                     thloop
                                     |         =20
                                      --42.96%--test_loop

    44.44%     0.00%  perf     libc.so.6                   [.] __libc_start=
_main
            |
            ---__libc_start_main
               |         =20
                --43.27%--0x7f0ca76f1248
                          main
                          |         =20
                           --43.00%--run_argv
                                     handle_internal_command
                                     run_builtin
                                     cmd_test
                                     run_workload
                                     thloop
                                     |         =20
                                      --42.96%--test_loop

    43.70%     0.00%  perf     libc.so.6                   [.] 0x00007f0ca7=
7d37da
            |
            ---0x7f0ca77d37da
               |         =20
                --43.67%--0x7f0ca775313e
                          |         =20
                           --43.64%--thfunc
                                     test_loop
                                     |         =20
                                      --2.01%--0xffffffff81000e06
                                                |         =20
                                                 --1.90%--0xffffffff82c72b1=
5
                                                           0xffffffff812c33=
03
                                                           |         =20
                                                            --1.69%--0xffff=
ffff814e082b
                                                                      |    =
     =20
                                                                       --1.=
58%--0xffffffff814df30f
                                                                           =
      |         =20
                                                                           =
       --1.55%--0xffffffff81500d0d
                                                                           =
                 |         =20
                                                                           =
                  --1.44%--0xffffffff814ddbe0
                                                                           =
                            |         =20
                                                                           =
                             --0.56%--0xffffffff813d4114

    43.67%     0.00%  perf     libc.so.6                   [.] 0x00007f0ca7=
75313e
            |
            ---0x7f0ca775313e
               |         =20
                --43.64%--thfunc
                          test_loop
                          |         =20
                           --2.01%--0xffffffff81000e06
                                     |         =20
                                      --1.90%--0xffffffff82c72b15
                                                0xffffffff812c3303
                                                |         =20
                                                 --1.69%--0xffffffff814e082=
b
                                                           |         =20
                                                            --1.58%--0xffff=
ffff814df30f
                                                                      |    =
     =20
                                                                       --1.=
55%--0xffffffff81500d0d
                                                                           =
      |         =20
                                                                           =
       --1.44%--0xffffffff814ddbe0
                                                                           =
                 |         =20
                                                                           =
                  --0.56%--0xffffffff813d4114

    43.64%     0.00%  perf     perf                        [.] thfunc
            |
            ---thfunc
               test_loop
               |         =20
                --2.01%--0xffffffff81000e06
                          |         =20
                           --1.90%--0xffffffff82c72b15
                                     0xffffffff812c3303
                                     |         =20
                                      --1.69%--0xffffffff814e082b
                                                |         =20
                                                 --1.58%--0xffffffff814df30=
f
                                                           |         =20
                                                            --1.55%--0xffff=
ffff81500d0d
                                                                      |    =
     =20
                                                                       --1.=
44%--0xffffffff814ddbe0
                                                                           =
      |         =20
                                                                           =
       --0.56%--0xffffffff813d4114

    43.27%     0.00%  perf     libc.so.6                   [.] 0x00007f0ca7=
6f1248
            |
            ---0x7f0ca76f1248
               main
               |         =20
                --43.00%--run_argv
                          handle_internal_command
                          run_builtin
                          cmd_test
                          run_workload
                          thloop
                          |         =20
                           --42.96%--test_loop

    43.27%     0.00%  perf     perf                        [.] main
            |
            ---main
               |         =20
                --43.00%--run_argv
                          handle_internal_command
                          run_builtin
                          cmd_test
                          run_workload
                          thloop
                          |         =20
                           --42.96%--test_loop

    43.25%     0.00%  perf     perf                        [.] handle_inter=
nal_command
            |
            ---handle_internal_command
               |         =20
                --43.00%--run_builtin
                          cmd_test
                          run_workload
                          thloop
                          |         =20
                           --42.96%--test_loop

    43.00%     0.00%  perf     perf                        [.] run_argv
            |
            ---run_argv
               handle_internal_command
               run_builtin
               cmd_test
               run_workload
               thloop
               |         =20
                --42.96%--test_loop

    43.00%     0.00%  perf     perf                        [.] run_builtin
            |
            ---run_builtin
               cmd_test
               run_workload
               thloop
               |         =20
                --42.96%--test_loop

    43.00%     0.00%  perf     perf                        [.] cmd_test
            |
            ---cmd_test
               run_workload
               thloop
               |         =20
                --42.96%--test_loop

    43.00%     0.00%  perf     perf                        [.] run_workload
            |
            ---run_workload
               thloop
               |         =20
                --42.96%--test_loop

    43.00%     0.00%  perf     perf                        [.] thloop
            |
            ---thloop
               |         =20
                --42.96%--test_loop

     5.58%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
000bb2
            |
            ---0xffffffff81000bb2
               |         =20
                --5.49%--0xffffffff82c73057
                          |         =20
                          |--4.75%--0xffffffff812ec7ef
                          |          |         =20
                          |           --4.22%--0xffffffff81820024
                          |                     |         =20
                          |                      --4.09%--0xffffffff8181f94=
c
                          |                                |         =20
                          |                                 --3.57%--0xffff=
ffff8181f2ab
                          |                                           |    =
     =20
                          |                                           |--0.=
68%--0xffffffff8181edbb
                          |                                           |    =
     =20
                          |                                            --0.=
62%--0xffffffff8181ee02
                          |                                                =
      |         =20
                          |                                                =
       --0.54%--0xffffffff81817b45
                          |         =20
                           --0.58%--0xffffffff812ec7ae

     5.58%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d1ba53
            |
            ---0x7f0ca8d1ba53
               0x7f0ca8d1cba7
               0x7f0ca8d1b22d
               |         =20
               |--4.07%--0x7f0ca8d1ec94
               |          |         =20
               |           --3.54%--0x7f0ca8d0ebd0
               |                     |         =20
               |                      --3.13%--0xffffffff81000bb2
               |                                |         =20
               |                                 --3.08%--0xffffffff82c7305=
7
               |                                           |         =20
               |                                            --2.71%--0xffff=
ffff812ec7ef
               |                                                      |    =
     =20
               |                                                       --2.=
39%--0xffffffff81820024
               |                                                           =
      |         =20
               |                                                           =
       --2.36%--0xffffffff8181f94c
               |                                                           =
                 |         =20
               |                                                           =
                  --2.27%--0xffffffff8181f2ab
               |                                                           =
                            |         =20
               |                                                           =
                             --0.68%--0xffffffff8181edbb
               |         =20
                --1.47%--0x7f0ca8d1e975
                          |         =20
                           --1.45%--0x7f0ca8d035c5
                                     _dl_catch_exception
                                     0x7f0ca8d0325c
                                     |         =20
                                      --1.31%--0x7f0ca8d09070
                                                |         =20
                                                 --0.74%--0x7f0ca8d07a24
                                                           0x7f0ca8d21ad0
                                                           0xffffffff810001=
2b
                                                           0xffffffff82c6e9=
ac
                                                           0xffffffff81828f=
e0
                                                           0xffffffff817cc6=
6a
                                                           0xffffffff8182a8=
03

     5.58%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d1cba7
            |
            ---0x7f0ca8d1cba7
               0x7f0ca8d1b22d
               |         =20
               |--4.07%--0x7f0ca8d1ec94
               |          |         =20
               |           --3.54%--0x7f0ca8d0ebd0
               |                     |         =20
               |                      --3.13%--0xffffffff81000bb2
               |                                |         =20
               |                                 --3.08%--0xffffffff82c7305=
7
               |                                           |         =20
               |                                            --2.71%--0xffff=
ffff812ec7ef
               |                                                      |    =
     =20
               |                                                       --2.=
39%--0xffffffff81820024
               |                                                           =
      |         =20
               |                                                           =
       --2.36%--0xffffffff8181f94c
               |                                                           =
                 |         =20
               |                                                           =
                  --2.27%--0xffffffff8181f2ab
               |                                                           =
                            |         =20
               |                                                           =
                             --0.68%--0xffffffff8181edbb
               |         =20
                --1.47%--0x7f0ca8d1e975
                          |         =20
                           --1.45%--0x7f0ca8d035c5
                                     _dl_catch_exception
                                     0x7f0ca8d0325c
                                     |         =20
                                      --1.31%--0x7f0ca8d09070
                                                |         =20
                                                 --0.74%--0x7f0ca8d07a24
                                                           0x7f0ca8d21ad0
                                                           0xffffffff810001=
2b
                                                           0xffffffff82c6e9=
ac
                                                           0xffffffff81828f=
e0
                                                           0xffffffff817cc6=
6a
                                                           0xffffffff8182a8=
03

     5.58%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d1b22d
            |
            ---0x7f0ca8d1b22d
               |         =20
               |--4.07%--0x7f0ca8d1ec94
               |          |         =20
               |           --3.54%--0x7f0ca8d0ebd0
               |                     |         =20
               |                      --3.13%--0xffffffff81000bb2
               |                                |         =20
               |                                 --3.08%--0xffffffff82c7305=
7
               |                                           |         =20
               |                                            --2.71%--0xffff=
ffff812ec7ef
               |                                                      |    =
     =20
               |                                                       --2.=
39%--0xffffffff81820024
               |                                                           =
      |         =20
               |                                                           =
       --2.36%--0xffffffff8181f94c
               |                                                           =
                 |         =20
               |                                                           =
                  --2.27%--0xffffffff8181f2ab
               |                                                           =
                            |         =20
               |                                                           =
                             --0.68%--0xffffffff8181edbb
               |         =20
                --1.47%--0x7f0ca8d1e975
                          |         =20
                           --1.45%--0x7f0ca8d035c5
                                     _dl_catch_exception
                                     0x7f0ca8d0325c
                                     |         =20
                                      --1.31%--0x7f0ca8d09070
                                                |         =20
                                                 --0.74%--0x7f0ca8d07a24
                                                           0x7f0ca8d21ad0
                                                           0xffffffff810001=
2b
                                                           0xffffffff82c6e9=
ac
                                                           0xffffffff81828f=
e0
                                                           0xffffffff817cc6=
6a
                                                           0xffffffff8182a8=
03

     5.49%     0.00%  perf     [unknown]                   [k] 0xffffffff82=
c73057
            |
            ---0xffffffff82c73057
               |         =20
               |--4.75%--0xffffffff812ec7ef
               |          |         =20
               |           --4.22%--0xffffffff81820024
               |                     |         =20
               |                      --4.09%--0xffffffff8181f94c
               |                                |         =20
               |                                 --3.57%--0xffffffff8181f2a=
b
               |                                           |         =20
               |                                           |--0.68%--0xffff=
ffff8181edbb
               |                                           |         =20
               |                                            --0.62%--0xffff=
ffff8181ee02
               |                                                      |    =
     =20
               |                                                       --0.=
54%--0xffffffff81817b45
               |         =20
                --0.58%--0xffffffff812ec7ae

     4.75%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2ec7ef
            |
            ---0xffffffff812ec7ef
               |         =20
                --4.22%--0xffffffff81820024
                          |         =20
                           --4.09%--0xffffffff8181f94c
                                     |         =20
                                      --3.57%--0xffffffff8181f2ab
                                                |         =20
                                                |--0.68%--0xffffffff8181edb=
b
                                                |         =20
                                                 --0.62%--0xffffffff8181ee0=
2
                                                           |         =20
                                                            --0.54%--0xffff=
ffff81817b45

     4.24%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
820024
            |
            ---0xffffffff81820024
               |         =20
                --4.11%--0xffffffff8181f94c
                          |         =20
                           --3.59%--0xffffffff8181f2ab
                                     |         =20
                                     |--0.68%--0xffffffff8181edbb
                                     |         =20
                                      --0.62%--0xffffffff8181ee02
                                                |         =20
                                                 --0.54%--0xffffffff81817b4=
5

     4.11%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
81f94c
            |
            ---0xffffffff8181f94c
               |         =20
                --3.59%--0xffffffff8181f2ab
                          |         =20
                          |--0.68%--0xffffffff8181edbb
                          |         =20
                           --0.62%--0xffffffff8181ee02
                                     |         =20
                                      --0.54%--0xffffffff81817b45

     4.07%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d1ec94
            |
            ---0x7f0ca8d1ec94
               |         =20
                --3.54%--0x7f0ca8d0ebd0
                          |         =20
                           --3.13%--0xffffffff81000bb2
                                     |         =20
                                      --3.08%--0xffffffff82c73057
                                                |         =20
                                                 --2.71%--0xffffffff812ec7e=
f
                                                           |         =20
                                                            --2.39%--0xffff=
ffff81820024
                                                                      |    =
     =20
                                                                       --2.=
36%--0xffffffff8181f94c
                                                                           =
      |         =20
                                                                           =
       --2.27%--0xffffffff8181f2ab
                                                                           =
                 |         =20
                                                                           =
                  --0.68%--0xffffffff8181edbb

     3.98%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
00012b
            |
            ---0xffffffff8100012b
               |         =20
                --3.95%--0xffffffff82c6e9ac
                          |         =20
                          |--1.41%--0xffffffff817cc66a
                          |          |         =20
                          |           --1.37%--0xffffffff8182a803
                          |                     |         =20
                          |                      --0.93%--0xffffffff8185bcb=
b
                          |                                |         =20
                          |                                 --0.62%--0xffff=
ffff8185863a
                          |         =20
                          |--0.83%--0xffffffff81828fe0
                          |          0xffffffff817cc66a
                          |          0xffffffff8182a803
                          |         =20
                           --0.52%--0xffffffff81828721
                                     0xffffffff8185efd2
                                     0xffffffff8185a936

     3.95%     0.00%  perf     [unknown]                   [k] 0xffffffff82=
c6e9ac
            |
            ---0xffffffff82c6e9ac
               |         =20
               |--1.41%--0xffffffff817cc66a
               |          |         =20
               |           --1.37%--0xffffffff8182a803
               |                     |         =20
               |                      --0.93%--0xffffffff8185bcbb
               |                                |         =20
               |                                 --0.62%--0xffffffff8185863=
a
               |         =20
               |--0.83%--0xffffffff81828fe0
               |          0xffffffff817cc66a
               |          0xffffffff8182a803
               |         =20
                --0.52%--0xffffffff81828721
                          0xffffffff8185efd2
                          0xffffffff8185a936

     3.59%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
81f2ab
            |
            ---0xffffffff8181f2ab
               |         =20
               |--0.68%--0xffffffff8181edbb
               |         =20
                --0.62%--0xffffffff8181ee02
                          |         =20
                           --0.54%--0xffffffff81817b45

     3.54%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d0ebd0
            |
            ---0x7f0ca8d0ebd0
               |         =20
                --3.13%--0xffffffff81000bb2
                          |         =20
                           --3.08%--0xffffffff82c73057
                                     |         =20
                                      --2.71%--0xffffffff812ec7ef
                                                |         =20
                                                 --2.39%--0xffffffff8182002=
4
                                                           |         =20
                                                            --2.36%--0xffff=
ffff8181f94c
                                                                      |    =
     =20
                                                                       --2.=
27%--0xffffffff8181f2ab
                                                                           =
      |         =20
                                                                           =
       --0.68%--0xffffffff8181edbb

     2.98%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
000e06
            |
            ---0xffffffff81000e06
               |         =20
               |--1.92%--0xffffffff82c72b15
               |          0xffffffff812c3303
               |          |         =20
               |           --1.71%--0xffffffff814e082b
               |                     |         =20
               |                      --1.60%--0xffffffff814df30f
               |                                |         =20
               |                                 --1.56%--0xffffffff81500d0=
d
               |                                           |         =20
               |                                            --1.45%--0xffff=
ffff814ddbe0
               |                                                      |    =
     =20
               |                                                       --0.=
57%--0xffffffff813d4114
               |         =20
                --0.85%--0xffffffff82c72b4e
                          0xffffffff81355d2a
                          0xffffffff81355139
                          0xffffffff81354ba0
                          |         =20
                           --0.83%--0xffffffff814a7f14
                                     |         =20
                                      --0.82%--0xffffffff8149fdb0

     2.97%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
8d9ddc
            |
            ---0xffffffff818d9ddc
               0xffffffff814d362f
               |         =20
                --1.91%--0xffffffff812780e7

     2.97%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
4d362f
            |
            ---0xffffffff814d362f
               |         =20
                --1.91%--0xffffffff812780e7

     2.83%     0.00%  perf     libasan.so.8.0.0            [.] __asan::Asan=
InitInternal() [clone .part.0]
            |
            ---__asan::AsanInitInternal() [clone .part.0]
               |         =20
                --1.67%--__sanitizer::Symbolizer::LateInitialize()
                          |         =20
                           --1.65%--dlsym
                                     0x7f0ca774ef1f
                                     _dl_catch_error
                                     |         =20
                                      --1.54%--0x7f0ca8d05aaf
                                                |         =20
                                                 --1.43%--0x7f0ca8d059cc

     2.81%     0.00%  perf     libc.so.6                   [.] _dl_catch_er=
ror
            |
            ---_dl_catch_error
               _dl_catch_exception
               |         =20
                --2.67%--InitializeCommonInterceptors()
                          __interception::InterceptFunction(char const*, un=
signed long*, unsigned long, unsigned long)
                          dlsym
                          0x7f0ca774ef1f
                          _dl_catch_error
                          _dl_catch_exception
                          InitializeCommonInterceptors()
                          __interception::InterceptFunction(char const*, un=
signed long*, unsigned long, unsigned long)
                          dlsym
                          0x7f0ca774ef1f
                          _dl_catch_error
                          _dl_catch_exception
                          InitializeCommonInterceptors()
                          __interception::InterceptFunction(char const*, un=
signed long*, unsigned long, unsigned long)
                          dlsym
                          0x7f0ca774ef1f
                          |         =20
                           --2.65%--__asan::AsanInitInternal() [clone .part=
.0]
                                     |         =20
                                      --1.67%--__sanitizer::Symbolizer::Lat=
eInitialize()
                                                |         =20
                                                 --1.65%--dlsym
                                                           0x7f0ca774ef1f
                                                           _dl_catch_error
                                                           |         =20
                                                            --1.54%--0x7f0c=
a8d05aaf
                                                                      |    =
     =20
                                                                       --1.=
43%--0x7f0ca8d059cc

     2.81%     0.00%  perf     libc.so.6                   [.] _dl_catch_ex=
ception
            |
            ---_dl_catch_exception
               |         =20
                --2.67%--InitializeCommonInterceptors()
                          __interception::InterceptFunction(char const*, un=
signed long*, unsigned long, unsigned long)
                          dlsym
                          0x7f0ca774ef1f
                          _dl_catch_error
                          _dl_catch_exception
                          InitializeCommonInterceptors()
                          __interception::InterceptFunction(char const*, un=
signed long*, unsigned long, unsigned long)
                          dlsym
                          0x7f0ca774ef1f
                          _dl_catch_error
                          _dl_catch_exception
                          InitializeCommonInterceptors()
                          __interception::InterceptFunction(char const*, un=
signed long*, unsigned long, unsigned long)
                          dlsym
                          0x7f0ca774ef1f
                          |         =20
                           --2.65%--__asan::AsanInitInternal() [clone .part=
.0]
                                     |         =20
                                      --1.67%--__sanitizer::Symbolizer::Lat=
eInitialize()
                                                |         =20
                                                 --1.65%--dlsym
                                                           0x7f0ca774ef1f
                                                           _dl_catch_error
                                                           |         =20
                                                            --1.54%--0x7f0c=
a8d05aaf
                                                                      |    =
     =20
                                                                       --1.=
43%--0x7f0ca8d059cc

     2.81%     0.00%  perf     libasan.so.8.0.0            [.] InitializeCo=
mmonInterceptors()
            |
            ---InitializeCommonInterceptors()
               __interception::InterceptFunction(char const*, unsigned long=
*, unsigned long, unsigned long)
               dlsym
               0x7f0ca774ef1f
               _dl_catch_error
               _dl_catch_exception
               |         =20
                --2.67%--InitializeCommonInterceptors()
                          __interception::InterceptFunction(char const*, un=
signed long*, unsigned long, unsigned long)
                          dlsym
                          0x7f0ca774ef1f
                          _dl_catch_error
                          _dl_catch_exception
                          InitializeCommonInterceptors()
                          __interception::InterceptFunction(char const*, un=
signed long*, unsigned long, unsigned long)
                          dlsym
                          0x7f0ca774ef1f
                          |         =20
                           --2.65%--__asan::AsanInitInternal() [clone .part=
.0]
                                     |         =20
                                      --1.67%--__sanitizer::Symbolizer::Lat=
eInitialize()
                                                |         =20
                                                 --1.65%--dlsym
                                                           0x7f0ca774ef1f
                                                           _dl_catch_error
                                                           |         =20
                                                            --1.54%--0x7f0c=
a8d05aaf
                                                                      |    =
     =20
                                                                       --1.=
43%--0x7f0ca8d059cc

     2.81%     0.00%  perf     libasan.so.8.0.0            [.] __intercepti=
on::InterceptFunction(char const*, unsigned long*, unsigned long, unsigned =
long)
            |
            ---__interception::InterceptFunction(char const*, unsigned long=
*, unsigned long, unsigned long)
               dlsym
               0x7f0ca774ef1f
               _dl_catch_error
               _dl_catch_exception
               |         =20
                --2.67%--InitializeCommonInterceptors()
                          __interception::InterceptFunction(char const*, un=
signed long*, unsigned long, unsigned long)
                          dlsym
                          0x7f0ca774ef1f
                          _dl_catch_error
                          _dl_catch_exception
                          InitializeCommonInterceptors()
                          __interception::InterceptFunction(char const*, un=
signed long*, unsigned long, unsigned long)
                          dlsym
                          0x7f0ca774ef1f
                          |         =20
                           --2.65%--__asan::AsanInitInternal() [clone .part=
.0]
                                     |         =20
                                      --1.67%--__sanitizer::Symbolizer::Lat=
eInitialize()
                                                |         =20
                                                 --1.65%--dlsym
                                                           0x7f0ca774ef1f
                                                           _dl_catch_error
                                                           |         =20
                                                            --1.54%--0x7f0c=
a8d05aaf
                                                                      |    =
     =20
                                                                       --1.=
43%--0x7f0ca8d059cc

     2.81%     0.00%  perf     libc.so.6                   [.] dlsym
            |
            ---dlsym
               0x7f0ca774ef1f
               _dl_catch_error
               _dl_catch_exception
               |         =20
                --2.67%--InitializeCommonInterceptors()
                          __interception::InterceptFunction(char const*, un=
signed long*, unsigned long, unsigned long)
                          dlsym
                          0x7f0ca774ef1f
                          _dl_catch_error
                          _dl_catch_exception
                          InitializeCommonInterceptors()
                          __interception::InterceptFunction(char const*, un=
signed long*, unsigned long, unsigned long)
                          dlsym
                          0x7f0ca774ef1f
                          |         =20
                           --2.65%--__asan::AsanInitInternal() [clone .part=
.0]
                                     |         =20
                                      --1.67%--__sanitizer::Symbolizer::Lat=
eInitialize()
                                                |         =20
                                                 --1.65%--dlsym
                                                           0x7f0ca774ef1f
                                                           _dl_catch_error
                                                           |         =20
                                                            --1.54%--0x7f0c=
a8d05aaf
                                                                      |    =
     =20
                                                                       --1.=
43%--0x7f0ca8d059cc

     2.81%     0.00%  perf     libc.so.6                   [.] 0x00007f0ca7=
74ef1f
            |
            ---0x7f0ca774ef1f
               _dl_catch_error
               _dl_catch_exception
               |         =20
                --2.67%--InitializeCommonInterceptors()
                          __interception::InterceptFunction(char const*, un=
signed long*, unsigned long, unsigned long)
                          dlsym
                          0x7f0ca774ef1f
                          _dl_catch_error
                          _dl_catch_exception
                          InitializeCommonInterceptors()
                          __interception::InterceptFunction(char const*, un=
signed long*, unsigned long, unsigned long)
                          dlsym
                          0x7f0ca774ef1f
                          |         =20
                           --2.65%--__asan::AsanInitInternal() [clone .part=
.0]
                                     |         =20
                                      --1.67%--__sanitizer::Symbolizer::Lat=
eInitialize()
                                                |         =20
                                                 --1.65%--dlsym
                                                           0x7f0ca774ef1f
                                                           _dl_catch_error
                                                           |         =20
                                                            --1.54%--0x7f0c=
a8d05aaf
                                                                      |    =
     =20
                                                                       --1.=
43%--0x7f0ca8d059cc

     2.42%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
8d9e50
            |
            ---0xffffffff818d9e50
               |         =20
                --2.37%--0xffffffff818d9ddc
                          0xffffffff814d362f
                          |         =20
                           --1.65%--0xffffffff812780e7

     2.27%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
7cc66a
            |
            ---0xffffffff817cc66a
               |         =20
                --2.23%--0xffffffff8182a803
                          |         =20
                           --1.30%--0xffffffff8185bcbb
                                     |         =20
                                      --0.97%--0xffffffff8185863a

     2.23%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
82a803
            |
            ---0xffffffff8182a803
               |         =20
                --1.30%--0xffffffff8185bcbb
                          |         =20
                           --0.97%--0xffffffff8185863a

     2.18%     0.01%  perf     [kernel.kallsyms]           [k] entry_SYSCAL=
L_64_after_hwframe
            |         =20
             --2.17%--entry_SYSCALL_64_after_hwframe
                       do_syscall_64
                       x64_sys_call
                       0xffffffff81351468
                       do_group_exit
                       do_exit
                       |         =20
                        --2.12%--exit_mm
                                  __mmput
                                  exit_mmap
                                  |         =20
                                   --1.39%--unmap_vmas
                                             unmap_page_range
                                             |         =20
                                              --1.37%--zap_pmd_range.isra.0
                                                        |         =20
                                                         --1.21%--zap_pte_r=
ange
                                                                   |       =
  =20
                                                                    --0.66%=
--tlb_flush_mmu
                                                                           =
   __tlb_batch_free_encoded_pages
                                                                           =
   free_pages_and_swap_cache
                                                                           =
   |         =20
                                                                           =
    --0.56%--folios_put_refs

     2.18%     0.01%  perf     [kernel.kallsyms]           [k] do_syscall_6=
4
            |         =20
             --2.17%--do_syscall_64
                       x64_sys_call
                       0xffffffff81351468
                       do_group_exit
                       do_exit
                       |         =20
                        --2.12%--exit_mm
                                  __mmput
                                  exit_mmap
                                  |         =20
                                   --1.39%--unmap_vmas
                                             unmap_page_range
                                             |         =20
                                              --1.37%--zap_pmd_range.isra.0
                                                        |         =20
                                                         --1.21%--zap_pte_r=
ange
                                                                   |       =
  =20
                                                                    --0.66%=
--tlb_flush_mmu
                                                                           =
   __tlb_batch_free_encoded_pages
                                                                           =
   free_pages_and_swap_cache
                                                                           =
   |         =20
                                                                           =
    --0.56%--folios_put_refs

     2.17%     0.00%  perf     [kernel.kallsyms]           [k] x64_sys_call
            |
            ---x64_sys_call
               0xffffffff81351468
               do_group_exit
               do_exit
               |         =20
                --2.12%--exit_mm
                          __mmput
                          exit_mmap
                          |         =20
                           --1.39%--unmap_vmas
                                     unmap_page_range
                                     |         =20
                                      --1.37%--zap_pmd_range.isra.0
                                                |         =20
                                                 --1.21%--zap_pte_range
                                                           |         =20
                                                            --0.66%--tlb_fl=
ush_mmu
                                                                      __tlb=
_batch_free_encoded_pages
                                                                      free_=
pages_and_swap_cache
                                                                      |    =
     =20
                                                                       --0.=
56%--folios_put_refs

     2.17%     0.00%  perf     [kernel.kallsyms]           [k] 0xffffffff81=
351468
            |
            ---0xffffffff81351468
               do_group_exit
               do_exit
               |         =20
                --2.12%--exit_mm
                          __mmput
                          exit_mmap
                          |         =20
                           --1.39%--unmap_vmas
                                     unmap_page_range
                                     |         =20
                                      --1.37%--zap_pmd_range.isra.0
                                                |         =20
                                                 --1.21%--zap_pte_range
                                                           |         =20
                                                            --0.66%--tlb_fl=
ush_mmu
                                                                      __tlb=
_batch_free_encoded_pages
                                                                      free_=
pages_and_swap_cache
                                                                      |    =
     =20
                                                                       --0.=
56%--folios_put_refs

     2.17%     0.00%  perf     [kernel.kallsyms]           [k] do_group_exi=
t
            |
            ---do_group_exit
               do_exit
               |         =20
                --2.12%--exit_mm
                          __mmput
                          exit_mmap
                          |         =20
                           --1.39%--unmap_vmas
                                     unmap_page_range
                                     |         =20
                                      --1.37%--zap_pmd_range.isra.0
                                                |         =20
                                                 --1.21%--zap_pte_range
                                                           |         =20
                                                            --0.66%--tlb_fl=
ush_mmu
                                                                      __tlb=
_batch_free_encoded_pages
                                                                      free_=
pages_and_swap_cache
                                                                      |    =
     =20
                                                                       --0.=
56%--folios_put_refs

     2.17%     0.00%  perf     [kernel.kallsyms]           [k] do_exit
            |
            ---do_exit
               |         =20
                --2.12%--exit_mm
                          __mmput
                          exit_mmap
                          |         =20
                           --1.39%--unmap_vmas
                                     unmap_page_range
                                     |         =20
                                      --1.37%--zap_pmd_range.isra.0
                                                |         =20
                                                 --1.21%--zap_pte_range
                                                           |         =20
                                                            --0.66%--tlb_fl=
ush_mmu
                                                                      __tlb=
_batch_free_encoded_pages
                                                                      free_=
pages_and_swap_cache
                                                                      |    =
     =20
                                                                       --0.=
56%--folios_put_refs

     2.12%     0.00%  perf     [kernel.kallsyms]           [k] exit_mm
            |
            ---exit_mm
               __mmput
               exit_mmap
               |         =20
                --1.39%--unmap_vmas
                          unmap_page_range
                          |         =20
                           --1.37%--zap_pmd_range.isra.0
                                     |         =20
                                      --1.21%--zap_pte_range
                                                |         =20
                                                 --0.66%--tlb_flush_mmu
                                                           __tlb_batch_free=
_encoded_pages
                                                           free_pages_and_s=
wap_cache
                                                           |         =20
                                                            --0.56%--folios=
_put_refs

     2.12%     0.00%  perf     [kernel.kallsyms]           [k] __mmput
            |
            ---__mmput
               exit_mmap
               |         =20
                --1.39%--unmap_vmas
                          unmap_page_range
                          |         =20
                           --1.37%--zap_pmd_range.isra.0
                                     |         =20
                                      --1.21%--zap_pte_range
                                                |         =20
                                                 --0.66%--tlb_flush_mmu
                                                           __tlb_batch_free=
_encoded_pages
                                                           free_pages_and_s=
wap_cache
                                                           |         =20
                                                            --0.56%--folios=
_put_refs

     2.12%     0.00%  perf     [kernel.kallsyms]           [k] exit_mmap
            |
            ---exit_mmap
               |         =20
                --1.39%--unmap_vmas
                          unmap_page_range
                          |         =20
                           --1.37%--zap_pmd_range.isra.0
                                     |         =20
                                      --1.21%--zap_pte_range
                                                |         =20
                                                 --0.66%--tlb_flush_mmu
                                                           __tlb_batch_free=
_encoded_pages
                                                           free_pages_and_s=
wap_cache
                                                           |         =20
                                                            --0.56%--folios=
_put_refs

     2.03%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
2780e7
            |
            ---0xffffffff812780e7

     2.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2c3303
            |
            ---0xffffffff812c3303
               |         =20
                --1.82%--0xffffffff814e082b
                          |         =20
                           --1.71%--0xffffffff814df30f
                                     |         =20
                                      --1.60%--0xffffffff81500d0d
                                                |         =20
                                                 --1.49%--0xffffffff814ddbe=
0
                                                           |         =20
                                                            --0.58%--0xffff=
ffff813d4114

     1.93%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c72b15
            |
            ---0xffffffff82c72b15
               0xffffffff812c3303
               |         =20
                --1.72%--0xffffffff814e082b
                          |         =20
                           --1.62%--0xffffffff814df30f
                                     |         =20
                                      --1.56%--0xffffffff81500d0d
                                                |         =20
                                                 --1.45%--0xffffffff814ddbe=
0
                                                           |         =20
                                                            --0.57%--0xffff=
ffff813d4114

     1.82%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4e082b
            |
            ---0xffffffff814e082b
               |         =20
                --1.71%--0xffffffff814df30f
                          |         =20
                           --1.60%--0xffffffff81500d0d
                                     |         =20
                                      --1.49%--0xffffffff814ddbe0
                                                |         =20
                                                 --0.58%--0xffffffff813d411=
4

     1.73%     1.72%  perf     [kernel.kallsyms]           [k] __asan_load8=
_noabort
            |         =20
             --0.61%--0x7f0ca8d1ba53
                       0x7f0ca8d1cba7
                       0x7f0ca8d1b22d

     1.71%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4df30f
            |
            ---0xffffffff814df30f
               |         =20
                --1.60%--0xffffffff81500d0d
                          |         =20
                           --1.49%--0xffffffff814ddbe0
                                     |         =20
                                      --0.58%--0xffffffff813d4114

     1.67%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:Symbolizer::LateInitialize()
            |
            ---__sanitizer::Symbolizer::LateInitialize()
               |         =20
                --1.65%--dlsym
                          0x7f0ca774ef1f
                          _dl_catch_error
                          |         =20
                           --1.54%--0x7f0ca8d05aaf
                                     |         =20
                                      --1.43%--0x7f0ca8d059cc

     1.60%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
500d0d
            |
            ---0xffffffff81500d0d
               |         =20
                --1.49%--0xffffffff814ddbe0
                          |         =20
                           --0.58%--0xffffffff813d4114

     1.58%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d05aaf
            |
            ---0x7f0ca8d05aaf
               |         =20
                --1.46%--0x7f0ca8d059cc

     1.50%     0.00%  perf     libc.so.6                   [.] dl_iterate_p=
hdr
            |         =20
            |--0.99%--dl_iterate_phdr
            |          __lsan::ProcessGlobalRegionsCallback(dl_phdr_info*, =
unsigned long, void*)
            |          __lsan::ScanGlobalRange(unsigned long, unsigned long=
, __sanitizer::InternalMmapVector<unsigned long>*)
            |          __lsan::ScanRangeForPointers(unsigned long, unsigned=
 long, __sanitizer::InternalMmapVector<unsigned long>*, char const*, __lsan=
::ChunkTag)
            |         =20
             --0.51%--dl_iterate_phdr

     1.49%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4ddbe0
            |
            ---0xffffffff814ddbe0
               |         =20
                --0.58%--0xffffffff813d4114

     1.47%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d1e975
            |
            ---0x7f0ca8d1e975
               |         =20
                --1.45%--0x7f0ca8d035c5
                          _dl_catch_exception
                          0x7f0ca8d0325c
                          |         =20
                           --1.31%--0x7f0ca8d09070
                                     |         =20
                                      --0.74%--0x7f0ca8d07a24
                                                0x7f0ca8d21ad0
                                                0xffffffff8100012b
                                                0xffffffff82c6e9ac
                                                0xffffffff81828fe0
                                                0xffffffff817cc66a
                                                0xffffffff8182a803

     1.46%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d059cc
            |
            ---0x7f0ca8d059cc

     1.45%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d035c5
            |
            ---0x7f0ca8d035c5
               _dl_catch_exception
               0x7f0ca8d0325c
               |         =20
                --1.31%--0x7f0ca8d09070
                          |         =20
                           --0.74%--0x7f0ca8d07a24
                                     0x7f0ca8d21ad0
                                     0xffffffff8100012b
                                     0xffffffff82c6e9ac
                                     0xffffffff81828fe0
                                     0xffffffff817cc66a
                                     0xffffffff8182a803

     1.45%     0.00%  perf     ld-linux-x86-64.so.2        [.] _dl_catch_ex=
ception
            |
            ---_dl_catch_exception
               0x7f0ca8d0325c
               |         =20
                --1.31%--0x7f0ca8d09070
                          |         =20
                           --0.74%--0x7f0ca8d07a24
                                     0x7f0ca8d21ad0
                                     0xffffffff8100012b
                                     0xffffffff82c6e9ac
                                     0xffffffff81828fe0
                                     0xffffffff817cc66a
                                     0xffffffff8182a803

     1.45%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d0325c
            |
            ---0x7f0ca8d0325c
               |         =20
                --1.31%--0x7f0ca8d09070
                          |         =20
                           --0.74%--0x7f0ca8d07a24
                                     0x7f0ca8d21ad0
                                     0xffffffff8100012b
                                     0xffffffff82c6e9ac
                                     0xffffffff81828fe0
                                     0xffffffff817cc66a
                                     0xffffffff8182a803

     1.41%     0.02%  perf     [kernel.kallsyms]           [k] unmap_page_r=
ange
            |         =20
             --1.38%--unmap_page_range
                       |         =20
                        --1.37%--zap_pmd_range.isra.0
                                  |         =20
                                   --1.21%--zap_pte_range
                                             |         =20
                                              --0.66%--tlb_flush_mmu
                                                        __tlb_batch_free_en=
coded_pages
                                                        free_pages_and_swap=
_cache
                                                        |         =20
                                                         --0.56%--folios_pu=
t_refs

     1.40%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
8da21a
            |
            ---0xffffffff818da21a
               0xffffffff818d9e50
               |         =20
                --1.35%--0xffffffff818d9ddc
                          0xffffffff814d362f
                          |         =20
                           --0.95%--0xffffffff812780e7

     1.39%     0.00%  perf     [kernel.kallsyms]           [k] unmap_vmas
            |
            ---unmap_vmas
               unmap_page_range
               |         =20
                --1.37%--zap_pmd_range.isra.0
                          |         =20
                           --1.21%--zap_pte_range
                                     |         =20
                                      --0.66%--tlb_flush_mmu
                                                __tlb_batch_free_encoded_pa=
ges
                                                free_pages_and_swap_cache
                                                |         =20
                                                 --0.56%--folios_put_refs

     1.37%     0.05%  perf     [kernel.kallsyms]           [k] zap_pmd_rang=
e.isra.0
            |         =20
             --1.32%--zap_pmd_range.isra.0
                       |         =20
                        --1.21%--zap_pte_range
                                  |         =20
                                   --0.66%--tlb_flush_mmu
                                             __tlb_batch_free_encoded_pages
                                             free_pages_and_swap_cache
                                             |         =20
                                              --0.56%--folios_put_refs

     1.33%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44724c
            |
            ---0xffffffff8144724c

     1.31%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d09070
            |
            ---0x7f0ca8d09070
               |         =20
                --0.74%--0x7f0ca8d07a24
                          0x7f0ca8d21ad0
                          0xffffffff8100012b
                          0xffffffff82c6e9ac
                          0xffffffff81828fe0
                          0xffffffff817cc66a
                          0xffffffff8182a803

     1.30%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85bcbb
            |
            ---0xffffffff8185bcbb
               |         =20
                --0.97%--0xffffffff8185863a

     1.25%     0.00%  perf     libasan.so.8.0.0            [.] __asan::Allo=
cator::Allocate(unsigned long, unsigned long, __sanitizer::BufferedStackTra=
ce*, __asan::AllocType, bool)
            |
            ---__asan::Allocator::Allocate(unsigned long, unsigned long, __=
sanitizer::BufferedStackTrace*, __asan::AllocType, bool)
               |         =20
                --0.92%--__sanitizer::CombinedAllocator<__sanitizer::SizeCl=
assAllocator64<__asan::AP64<__sanitizer::LocalAddressSpaceView> >, __saniti=
zer::LargeMmapAllocatorPtrArrayDynamic>::Allocate(__sanitizer::SizeClassAll=
ocator64LocalCache<__sanitizer::SizeClassAllocator64<__asan::AP64<__sanitiz=
er::LocalAddressSpaceView> > >*, unsigned long, unsigned long)
                          __sanitizer::SizeClassAllocator64LocalCache<__san=
itizer::SizeClassAllocator64<__asan::AP64<__sanitizer::LocalAddressSpaceVie=
w> > >::Refill(__sanitizer::SizeClassAllocator64LocalCache<__sanitizer::Siz=
eClassAllocator64<__asan::AP64<__sanitizer::LocalAddressSpaceView> > >::Per=
Class*, __sanitizer::SizeClassAllocator64<__asan::AP64<__sanitizer::LocalAd=
dressSpaceView> >*, unsigned long)
                          __sanitizer::SizeClassAllocator64<__asan::AP64<__=
sanitizer::LocalAddressSpaceView> >::GetFromAllocator(__sanitizer::Allocato=
rStats*, unsigned long, unsigned int*, unsigned long)
                          __sanitizer::SizeClassAllocator64<__asan::AP64<__=
sanitizer::LocalAddressSpaceView> >::PopulateFreeArray(__sanitizer::Allocat=
orStats*, unsigned long, __sanitizer::SizeClassAllocator64<__asan::AP64<__s=
anitizer::LocalAddressSpaceView> >::RegionInfo*, unsigned long)
                          |         =20
                           --0.76%--__sanitizer::MmapFixedImpl(unsigned lon=
g, unsigned long, bool, char const*)
                                     __sanitizer::internal_mmap(void*, unsi=
gned long, int, int, int, unsigned long long)
                                     |         =20
                                      --0.75%--0xffffffff8100012b
                                                |         =20
                                                 --0.74%--0xffffffff82c6e9a=
c
                                                           0xffffffff817cc6=
6a
                                                           0xffffffff8182a8=
03
                                                           |         =20
                                                            --0.59%--0xffff=
ffff8185bcbb
                                                                      |    =
     =20
                                                                       --0.=
58%--0xffffffff8185863a

     1.24%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
8da0c3
            |
            ---0xffffffff818da0c3
               0xffffffff818dd117
               0xffffffff818d9e50
               |         =20
                --1.23%--0xffffffff818d9ddc
                          0xffffffff814d362f
                          |         =20
                           --0.86%--0xffffffff812780e7

     1.24%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
8dd117
            |
            ---0xffffffff818dd117
               0xffffffff818d9e50
               |         =20
                --1.23%--0xffffffff818d9ddc
                          0xffffffff814d362f
                          |         =20
                           --0.86%--0xffffffff812780e7

     1.24%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:internal_clone(int (*)(void*), void*, int, void*, int*, void*, int*)
            |         =20
             --1.18%--__sanitizer::internal_clone(int (*)(void*), void*, in=
t, void*, int*, void*, int*)
                       __sanitizer::TracerThread(void*)
                       |         =20
                        --1.13%--__lsan::CheckForLeaksCallback(__sanitizer:=
:SuspendedThreadsList const&, void*)
                                  |         =20
                                   --0.99%--dl_iterate_phdr
                                             __lsan::ProcessGlobalRegionsCa=
llback(dl_phdr_info*, unsigned long, void*)
                                             __lsan::ScanGlobalRange(unsign=
ed long, unsigned long, __sanitizer::InternalMmapVector<unsigned long>*)
                                             __lsan::ScanRangeForPointers(u=
nsigned long, unsigned long, __sanitizer::InternalMmapVector<unsigned long>=
*, char const*, __lsan::ChunkTag)

     1.21%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
887f4e
            |
            ---0xffffffff81887f4e
               |         =20
                --1.20%--0xffffffff818da21a
                          0xffffffff818d9e50
                          |         =20
                           --1.15%--0xffffffff818d9ddc
                                     0xffffffff814d362f
                                     |         =20
                                      --0.80%--0xffffffff812780e7

     1.21%     0.02%  perf     [kernel.kallsyms]           [k] zap_pte_rang=
e
            |         =20
             --1.18%--zap_pte_range
                       |         =20
                        --0.66%--tlb_flush_mmu
                                  __tlb_batch_free_encoded_pages
                                  free_pages_and_swap_cache
                                  |         =20
                                   --0.56%--folios_put_refs

     1.18%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:internal_mmap(void*, unsigned long, int, int, int, unsigned long long)
            |
            ---__sanitizer::internal_mmap(void*, unsigned long, int, int, i=
nt, unsigned long long)
               |         =20
                --1.16%--0xffffffff8100012b
                          |         =20
                           --1.14%--0xffffffff82c6e9ac
                                     |         =20
                                      --1.10%--0xffffffff817cc66a
                                                |         =20
                                                 --1.06%--0xffffffff8182a80=
3
                                                           |         =20
                                                            --0.66%--0xffff=
ffff8185bcbb
                                                                      |    =
     =20
                                                                       --0.=
61%--0xffffffff8185863a

     1.18%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:TracerThread(void*)
            |
            ---__sanitizer::TracerThread(void*)
               |         =20
                --1.13%--__lsan::CheckForLeaksCallback(__sanitizer::Suspend=
edThreadsList const&, void*)
                          |         =20
                           --0.99%--dl_iterate_phdr
                                     __lsan::ProcessGlobalRegionsCallback(d=
l_phdr_info*, unsigned long, void*)
                                     __lsan::ScanGlobalRange(unsigned long,=
 unsigned long, __sanitizer::InternalMmapVector<unsigned long>*)
                                     __lsan::ScanRangeForPointers(unsigned =
long, unsigned long, __sanitizer::InternalMmapVector<unsigned long>*, char =
const*, __lsan::ChunkTag)

     1.14%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d21ad0
            |
            ---0x7f0ca8d21ad0
               0xffffffff8100012b
               0xffffffff82c6e9ac
               |         =20
                --0.83%--0xffffffff81828fe0
                          0xffffffff817cc66a
                          0xffffffff8182a803

     1.13%     0.00%  perf     libasan.so.8.0.0            [.] __lsan::Chec=
kForLeaksCallback(__sanitizer::SuspendedThreadsList const&, void*)
            |
            ---__lsan::CheckForLeaksCallback(__sanitizer::SuspendedThreadsL=
ist const&, void*)
               |         =20
                --0.99%--dl_iterate_phdr
                          __lsan::ProcessGlobalRegionsCallback(dl_phdr_info=
*, unsigned long, void*)
                          __lsan::ScanGlobalRange(unsigned long, unsigned l=
ong, __sanitizer::InternalMmapVector<unsigned long>*)
                          __lsan::ScanRangeForPointers(unsigned long, unsig=
ned long, __sanitizer::InternalMmapVector<unsigned long>*, char const*, __l=
san::ChunkTag)

     1.07%     1.05%  perf     [kernel.kallsyms]           [k] __lock_acqui=
re
     1.03%     0.31%  perf     libasan.so.8.0.0            [.] __lsan::Scan=
RangeForPointers(unsigned long, unsigned long, __sanitizer::InternalMmapVec=
tor<unsigned long>*, char const*, __lsan::ChunkTag)
            |         =20
             --0.72%--__lsan::ScanRangeForPointers(unsigned long, unsigned =
long, __sanitizer::InternalMmapVector<unsigned long>*, char const*, __lsan:=
:ChunkTag)

     0.99%     0.00%  perf     libasan.so.8.0.0            [.] __lsan::Proc=
essGlobalRegionsCallback(dl_phdr_info*, unsigned long, void*)
            |
            ---__lsan::ProcessGlobalRegionsCallback(dl_phdr_info*, unsigned=
 long, void*)
               __lsan::ScanGlobalRange(unsigned long, unsigned long, __sani=
tizer::InternalMmapVector<unsigned long>*)
               __lsan::ScanRangeForPointers(unsigned long, unsigned long, _=
_sanitizer::InternalMmapVector<unsigned long>*, char const*, __lsan::ChunkT=
ag)

     0.99%     0.00%  perf     libasan.so.8.0.0            [.] __lsan::Scan=
GlobalRange(unsigned long, unsigned long, __sanitizer::InternalMmapVector<u=
nsigned long>*)
            |
            ---__lsan::ScanGlobalRange(unsigned long, unsigned long, __sani=
tizer::InternalMmapVector<unsigned long>*)
               __lsan::ScanRangeForPointers(unsigned long, unsigned long, _=
_sanitizer::InternalMmapVector<unsigned long>*, char const*, __lsan::ChunkT=
ag)

     0.97%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85863a
            |
            ---0xffffffff8185863a

     0.94%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:CombinedAllocator<__sanitizer::SizeClassAllocator64<__asan::AP64<__sanitiz=
er::LocalAddressSpaceView> >, __sanitizer::LargeMmapAllocatorPtrArrayDynami=
c>::Allocate(__sanitizer::SizeClassAllocator64LocalCache<__sanitizer::SizeC=
lassAllocator64<__asan::AP64<__sanitizer::LocalAddressSpaceView> > >*, unsi=
gned long, unsigned long)
            |
            ---__sanitizer::CombinedAllocator<__sanitizer::SizeClassAllocat=
or64<__asan::AP64<__sanitizer::LocalAddressSpaceView> >, __sanitizer::Large=
MmapAllocatorPtrArrayDynamic>::Allocate(__sanitizer::SizeClassAllocator64Lo=
calCache<__sanitizer::SizeClassAllocator64<__asan::AP64<__sanitizer::LocalA=
ddressSpaceView> > >*, unsigned long, unsigned long)
               __sanitizer::SizeClassAllocator64LocalCache<__sanitizer::Siz=
eClassAllocator64<__asan::AP64<__sanitizer::LocalAddressSpaceView> > >::Ref=
ill(__sanitizer::SizeClassAllocator64LocalCache<__sanitizer::SizeClassAlloc=
ator64<__asan::AP64<__sanitizer::LocalAddressSpaceView> > >::PerClass*, __s=
anitizer::SizeClassAllocator64<__asan::AP64<__sanitizer::LocalAddressSpaceV=
iew> >*, unsigned long)
               __sanitizer::SizeClassAllocator64<__asan::AP64<__sanitizer::=
LocalAddressSpaceView> >::GetFromAllocator(__sanitizer::AllocatorStats*, un=
signed long, unsigned int*, unsigned long)
               |         =20
                --0.93%--__sanitizer::SizeClassAllocator64<__asan::AP64<__s=
anitizer::LocalAddressSpaceView> >::PopulateFreeArray(__sanitizer::Allocato=
rStats*, unsigned long, __sanitizer::SizeClassAllocator64<__asan::AP64<__sa=
nitizer::LocalAddressSpaceView> >::RegionInfo*, unsigned long)
                          |         =20
                           --0.78%--__sanitizer::MmapFixedImpl(unsigned lon=
g, unsigned long, bool, char const*)
                                     __sanitizer::internal_mmap(void*, unsi=
gned long, int, int, int, unsigned long long)
                                     |         =20
                                      --0.77%--0xffffffff8100012b
                                                |         =20
                                                 --0.76%--0xffffffff82c6e9a=
c
                                                           0xffffffff817cc6=
6a
                                                           0xffffffff8182a8=
03
                                                           |         =20
                                                            --0.60%--0xffff=
ffff8185bcbb
                                                                      |    =
     =20
                                                                       --0.=
59%--0xffffffff8185863a

     0.94%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:SizeClassAllocator64LocalCache<__sanitizer::SizeClassAllocator64<__asan::A=
P64<__sanitizer::LocalAddressSpaceView> > >::Refill(__sanitizer::SizeClassA=
llocator64LocalCache<__sanitizer::SizeClassAllocator64<__asan::AP64<__sanit=
izer::LocalAddressSpaceView> > >::PerClass*, __sanitizer::SizeClassAllocato=
r64<__asan::AP64<__sanitizer::LocalAddressSpaceView> >*, unsigned long)
            |
            ---__sanitizer::SizeClassAllocator64LocalCache<__sanitizer::Siz=
eClassAllocator64<__asan::AP64<__sanitizer::LocalAddressSpaceView> > >::Ref=
ill(__sanitizer::SizeClassAllocator64LocalCache<__sanitizer::SizeClassAlloc=
ator64<__asan::AP64<__sanitizer::LocalAddressSpaceView> > >::PerClass*, __s=
anitizer::SizeClassAllocator64<__asan::AP64<__sanitizer::LocalAddressSpaceV=
iew> >*, unsigned long)
               __sanitizer::SizeClassAllocator64<__asan::AP64<__sanitizer::=
LocalAddressSpaceView> >::GetFromAllocator(__sanitizer::AllocatorStats*, un=
signed long, unsigned int*, unsigned long)
               |         =20
                --0.93%--__sanitizer::SizeClassAllocator64<__asan::AP64<__s=
anitizer::LocalAddressSpaceView> >::PopulateFreeArray(__sanitizer::Allocato=
rStats*, unsigned long, __sanitizer::SizeClassAllocator64<__asan::AP64<__sa=
nitizer::LocalAddressSpaceView> >::RegionInfo*, unsigned long)
                          |         =20
                           --0.78%--__sanitizer::MmapFixedImpl(unsigned lon=
g, unsigned long, bool, char const*)
                                     __sanitizer::internal_mmap(void*, unsi=
gned long, int, int, int, unsigned long long)
                                     |         =20
                                      --0.77%--0xffffffff8100012b
                                                |         =20
                                                 --0.76%--0xffffffff82c6e9a=
c
                                                           0xffffffff817cc6=
6a
                                                           0xffffffff8182a8=
03
                                                           |         =20
                                                            --0.60%--0xffff=
ffff8185bcbb
                                                                      |    =
     =20
                                                                       --0.=
59%--0xffffffff8185863a

     0.94%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:SizeClassAllocator64<__asan::AP64<__sanitizer::LocalAddressSpaceView> >::G=
etFromAllocator(__sanitizer::AllocatorStats*, unsigned long, unsigned int*,=
 unsigned long)
            |
            ---__sanitizer::SizeClassAllocator64<__asan::AP64<__sanitizer::=
LocalAddressSpaceView> >::GetFromAllocator(__sanitizer::AllocatorStats*, un=
signed long, unsigned int*, unsigned long)
               |         =20
                --0.93%--__sanitizer::SizeClassAllocator64<__asan::AP64<__s=
anitizer::LocalAddressSpaceView> >::PopulateFreeArray(__sanitizer::Allocato=
rStats*, unsigned long, __sanitizer::SizeClassAllocator64<__asan::AP64<__sa=
nitizer::LocalAddressSpaceView> >::RegionInfo*, unsigned long)
                          |         =20
                           --0.78%--__sanitizer::MmapFixedImpl(unsigned lon=
g, unsigned long, bool, char const*)
                                     __sanitizer::internal_mmap(void*, unsi=
gned long, int, int, int, unsigned long long)
                                     |         =20
                                      --0.77%--0xffffffff8100012b
                                                |         =20
                                                 --0.76%--0xffffffff82c6e9a=
c
                                                           0xffffffff817cc6=
6a
                                                           0xffffffff8182a8=
03
                                                           |         =20
                                                            --0.60%--0xffff=
ffff8185bcbb
                                                                      |    =
     =20
                                                                       --0.=
59%--0xffffffff8185863a

     0.93%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:SizeClassAllocator64<__asan::AP64<__sanitizer::LocalAddressSpaceView> >::P=
opulateFreeArray(__sanitizer::AllocatorStats*, unsigned long, __sanitizer::=
SizeClassAllocator64<__asan::AP64<__sanitizer::LocalAddressSpaceView> >::Re=
gionInfo*, unsigned long)
            |
            ---__sanitizer::SizeClassAllocator64<__asan::AP64<__sanitizer::=
LocalAddressSpaceView> >::PopulateFreeArray(__sanitizer::AllocatorStats*, u=
nsigned long, __sanitizer::SizeClassAllocator64<__asan::AP64<__sanitizer::L=
ocalAddressSpaceView> >::RegionInfo*, unsigned long)
               |         =20
                --0.78%--__sanitizer::MmapFixedImpl(unsigned long, unsigned=
 long, bool, char const*)
                          __sanitizer::internal_mmap(void*, unsigned long, =
int, int, int, unsigned long long)
                          |         =20
                           --0.77%--0xffffffff8100012b
                                     |         =20
                                      --0.76%--0xffffffff82c6e9ac
                                                0xffffffff817cc66a
                                                0xffffffff8182a803
                                                |         =20
                                                 --0.60%--0xffffffff8185bcb=
b
                                                           |         =20
                                                            --0.59%--0xffff=
ffff8185863a

     0.92%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
355d2a
            |
            ---0xffffffff81355d2a
               |         =20
                --0.86%--0xffffffff81355139
                          0xffffffff81354ba0
                          |         =20
                           --0.84%--0xffffffff814a7f14
                                     |         =20
                                      --0.83%--0xffffffff8149fdb0

     0.92%     0.91%  perf     [kernel.kallsyms]           [k] __asan_load4=
_noabort
     0.86%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
355139
            |
            ---0xffffffff81355139
               0xffffffff81354ba0
               |         =20
                --0.84%--0xffffffff814a7f14
                          |         =20
                           --0.83%--0xffffffff8149fdb0

     0.86%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
354ba0
            |
            ---0xffffffff81354ba0
               |         =20
                --0.84%--0xffffffff814a7f14
                          |         =20
                           --0.83%--0xffffffff8149fdb0

     0.85%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c72b4e
            |
            ---0xffffffff82c72b4e
               0xffffffff81355d2a
               0xffffffff81355139
               0xffffffff81354ba0
               |         =20
                --0.83%--0xffffffff814a7f14
                          |         =20
                           --0.82%--0xffffffff8149fdb0

     0.84%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4a7f14
            |
            ---0xffffffff814a7f14
               |         =20
                --0.83%--0xffffffff8149fdb0

     0.83%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
828fe0
            |
            ---0xffffffff81828fe0
               0xffffffff817cc66a
               0xffffffff8182a803

     0.83%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
49fdb0
            |
            ---0xffffffff8149fdb0

     0.78%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:MmapFixedImpl(unsigned long, unsigned long, bool, char const*)
            |
            ---__sanitizer::MmapFixedImpl(unsigned long, unsigned long, boo=
l, char const*)
               __sanitizer::internal_mmap(void*, unsigned long, int, int, i=
nt, unsigned long long)
               |         =20
                --0.77%--0xffffffff8100012b
                          |         =20
                           --0.76%--0xffffffff82c6e9ac
                                     0xffffffff817cc66a
                                     0xffffffff8182a803
                                     |         =20
                                      --0.60%--0xffffffff8185bcbb
                                                |         =20
                                                 --0.59%--0xffffffff8185863=
a

     0.77%     0.46%  perf     [kernel.kallsyms]           [k] unwind_next_=
frame
     0.76%     0.03%  perf     libasan.so.8.0.0            [.] __asan_regis=
ter_globals.part.0
            |         =20
             --0.72%--__asan_register_globals.part.0

     0.74%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d07a24
            |
            ---0x7f0ca8d07a24
               0x7f0ca8d21ad0
               0xffffffff8100012b
               0xffffffff82c6e9ac
               0xffffffff81828fe0
               0xffffffff817cc66a
               0xffffffff8182a803

     0.74%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
858057
            |
            ---0xffffffff81858057

     0.68%     0.04%  perf     [kernel.kallsyms]           [k] free_pages_a=
nd_swap_cache
            |         =20
             --0.64%--free_pages_and_swap_cache
                       |         =20
                        --0.58%--folios_put_refs

     0.68%     0.00%  perf     [kernel.kallsyms]           [k] __tlb_batch_=
free_encoded_pages
            |
            ---__tlb_batch_free_encoded_pages
               free_pages_and_swap_cache
               |         =20
                --0.58%--folios_put_refs

     0.68%     0.07%  perf     [kernel.kallsyms]           [k] arch_stack_w=
alk
            |         =20
             --0.61%--arch_stack_walk

     0.68%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81edbb
            |
            ---0xffffffff8181edbb

     0.67%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
88b1ab
            |
            ---0xffffffff8188b1ab
               0xffffffff818da0c3
               0xffffffff818dd117
               0xffffffff818d9e50
               0xffffffff818d9ddc
               0xffffffff814d362f
               |         =20
                --0.51%--0xffffffff812780e7

     0.67%     0.01%  perf     [kernel.kallsyms]           [k] kmem_cache_f=
ree
            |         =20
             --0.66%--kmem_cache_free

     0.66%     0.00%  perf     [kernel.kallsyms]           [k] tlb_flush_mm=
u
            |
            ---tlb_flush_mmu
               __tlb_batch_free_encoded_pages
               free_pages_and_swap_cache
               |         =20
                --0.56%--folios_put_refs

     0.64%     0.00%  perf     [kernel.kallsyms]           [k] kasan_save_s=
tack
            |
            ---kasan_save_stack
               |         =20
                --0.63%--stack_trace_save
                          arch_stack_walk

     0.64%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
8dd068
            |
            ---0xffffffff818dd068
               0xffffffff818d9ddc
               0xffffffff814d362f

     0.63%     0.00%  perf     [kernel.kallsyms]           [k] stack_trace_=
save
            |
            ---stack_trace_save
               arch_stack_walk

     0.62%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81ee02
            |
            ---0xffffffff8181ee02
               |         =20
                --0.54%--0xffffffff81817b45

     0.59%     0.02%  perf     [kernel.kallsyms]           [k] folios_put_r=
efs
            |         =20
             --0.57%--folios_put_refs

     0.58%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d4114
            |
            ---0xffffffff813d4114

     0.58%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2ec7ae
            |
            ---0xffffffff812ec7ae

     0.56%     0.56%  perf     [kernel.kallsyms]           [k] kasan_check_=
range
     0.56%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
857f4f
            |
            ---0xffffffff81857f4f

     0.55%     0.54%  perf     [kernel.kallsyms]           [k] lock_is_held=
_type
     0.54%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
817b45
            |
            ---0xffffffff81817b45

     0.53%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
4a5b94
            |
            ---0xffffffff814a5b94
               |         =20
                --0.52%--0xffffffff818dd068
                          0xffffffff818d9ddc
                          0xffffffff814d362f

     0.53%     0.52%  perf     [kernel.kallsyms]           [k] rcu_is_watch=
ing
     0.53%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
85efd2
            |
            ---0xffffffff8185efd2
               0xffffffff8185a936

     0.53%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
85a936
            |
            ---0xffffffff8185a936

     0.53%     0.32%  perf     [kernel.kallsyms]           [k] lock_acquire
     0.53%     0.00%  perf     [unknown]                   [k] 0xffffffff82=
c49ccf
            |
            ---0xffffffff82c49ccf

     0.52%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
828721
            |
            ---0xffffffff81828721
               0xffffffff8185efd2
               0xffffffff8185a936

     0.52%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
857197
            |
            ---0xffffffff81857197

     0.52%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
2780c3
            |
            ---0xffffffff812780c3

     0.52%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:ReadFileToBuffer(char const*, char**, unsigned long*, unsigned long*, unsi=
gned long, int*)
            |
            ---__sanitizer::ReadFileToBuffer(char const*, char**, unsigned =
long*, unsigned long*, unsigned long, int*)

     0.51%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:UnmapOrDie(void*, unsigned long)
     0.51%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:internal_munmap(void*, unsigned long)
     0.51%     0.00%  perf     libasan.so.8.0.0            [.] __intercepto=
r_malloc
            |
            ---__interceptor_malloc

     0.51%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:MemoryMappingLayout::MemoryMappingLayout(bool)
            |
            ---__sanitizer::MemoryMappingLayout::MemoryMappingLayout(bool)

     0.50%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
857ae1
            |
            ---0xffffffff81857ae1

     0.50%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:ReadProcMaps(__sanitizer::ProcSelfMapsBuff*)
     0.49%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
2e154c
     0.48%     0.10%  perf     [kernel.kallsyms]           [k] zap_present_=
ptes.constprop.0
     0.48%     0.00%  perf     [unknown]                   [k] 0xffffffff82=
c4a9e5
     0.48%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
8c11cc
     0.46%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8175b5
     0.46%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
2780fd
     0.46%     0.00%  perf     libasan.so.8.0.0            [.] __intercepto=
r_calloc
     0.46%     0.00%  perf     libasan.so.8.0.0            [.] __asan::asan=
_calloc(unsigned long, unsigned long, __sanitizer::BufferedStackTrace*)
     0.46%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
2e2547
     0.44%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
8dc7c4
     0.43%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81ecdb
     0.42%     0.00%  perf     libasan.so.8.0.0            [.] __lsan::Init=
ializePlatformSpecificModules()
     0.42%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:ListOfModules::init()
     0.42%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:dl_iterate_phdr_cb(dl_phdr_info*, unsigned long, void*)
     0.41%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c580b
     0.41%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c54c2
     0.40%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d417b
     0.40%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
820122
     0.39%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
8853f8
     0.39%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81ed0a
     0.39%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
819043
     0.38%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
793db7
     0.38%     0.38%  perf     [kernel.kallsyms]           [k] __irqentry_t=
ext_end
     0.37%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
814ddf
     0.37%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e15bd
     0.36%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
96bda5
     0.36%     0.00%  perf     libasan.so.8.0.0            [.] operator new=
(unsigned long)
     0.36%     0.00%  perf     libasan.so.8.0.0            [.] __asan::asan=
_memalign(unsigned long, unsigned long, __sanitizer::BufferedStackTrace*, _=
_asan::AllocType)
     0.36%     0.00%  perf     libasan.so.8.0.0            [.] __asan::asan=
_malloc(unsigned long, __sanitizer::BufferedStackTrace*)
     0.36%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
96a2da
     0.36%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
2e0f33
     0.36%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
3965ae
     0.35%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:ReadFromFile(int, void*, unsigned long, unsigned long*, int*)
     0.35%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:internal_read(int, void*, unsigned long)
     0.35%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc80c
     0.35%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9cc4d0
     0.35%     0.00%  perf     [unknown]                   [k] 0xffffffff82=
c34aec
     0.35%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3ec6ee
     0.35%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d21b40
     0.35%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8316c3
     0.35%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
779532
     0.35%     0.00%  perf     [kernel.kallsyms]           [k] kasan_save_t=
rack
     0.34%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d0fca3
     0.34%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d0ead8
     0.34%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
83150f
     0.34%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
778b7c
     0.34%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
857dd4
     0.33%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:LowLevelAllocator::Allocate(unsigned long)
     0.33%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81f40c
     0.33%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
85a6cd
     0.33%     0.00%  perf     libLLVM-14.so.1             [.] llvm::cl::Op=
tion::addArgument()
     0.33%     0.31%  perf     [kernel.kallsyms]           [k] lock_release
     0.33%     0.00%  perf     libasan.so.8.0.0            [.] __asan::Asan=
Thread::ThreadStart(unsigned long long)
     0.33%     0.00%  perf     libasan.so.8.0.0            [.] __asan::Asan=
Thread::Init(__asan::AsanThread::InitOptions const*)
     0.32%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8563b0
     0.32%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:MmapOrDie(unsigned long, char const*, bool)
     0.32%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
857a08
     0.32%     0.32%  perf     [kernel.kallsyms]           [k] debug_lockde=
p_rcu_enabled
     0.32%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81712d
     0.32%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
3520d7
     0.32%     0.00%  perf     [unknown]                   [k] 0xffffffff82=
c393d9
     0.31%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
33e2eb
     0.31%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
351eea
     0.31%     0.00%  perf     libLLVM-14.so.1             [.] llvm::String=
MapImpl::RehashTable(unsigned int)
     0.31%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
3c77ea
     0.31%     0.00%  perf     libasan.so.8.0.0            [.] __asan::Asan=
Thread::SetThreadStackAndTls(__asan::AsanThread::InitOptions const*)
     0.31%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:GetThreadStackAndTls(bool, unsigned long*, unsigned long*, unsigned long*,=
 unsigned long*)
     0.31%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:GetThreadStackTopAndBottom(bool, unsigned long*, unsigned long*)
     0.30%     0.00%  perf     [kernel.kallsyms]           [k] kasan_record=
_aux_stack
     0.30%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
871d33
     0.30%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81e291
     0.29%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d086b3
     0.29%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81ecbd
     0.29%     0.00%  perf     libasan.so.8.0.0            [.] __asan::Crea=
teMainThread()
     0.29%     0.29%  perf     [kernel.kallsyms]           [k] __asan_store=
8_noabort
     0.28%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:InternalAlloc(unsigned long, __sanitizer::SizeClassAllocator32LocalCache<_=
_sanitizer::SizeClassAllocator32<__sanitizer::AP32> >*, unsigned long)
     0.28%     0.00%  perf     [kernel.kallsyms]           [k] __kasan_kmal=
loc
     0.28%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91ef0a
     0.28%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
793adf
     0.27%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
74fd89
     0.27%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8587be
     0.27%     0.00%  perf     perf                        [.] __asan_regis=
ter_globals@plt
     0.27%     0.00%  perf     libc.so.6                   [.] 0x00007f0ca7=
74f51f
     0.27%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445fdb
     0.27%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85977f
     0.27%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91ef1a
     0.26%     0.01%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:StackDepotBase<__sanitizer::StackDepotNode, 1, 20>::Put(__sanitizer::Stack=
Trace, bool*)
     0.26%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80e0bb
     0.26%     0.00%  perf     [kernel.kallsyms]           [k] free_pgtable=
s
     0.26%     0.00%  perf     libasan.so.8.0.0            [.] __asan::Init=
ializeShadowMemory()
     0.26%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
a90b3a
     0.26%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85bd84
     0.25%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
85c017
     0.25%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
830ca1
     0.25%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85ab53
     0.25%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8594cb
     0.25%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
776b34
     0.25%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:MemoryRangeIsAvailable(unsigned long, unsigned long)
     0.25%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:MemoryMappingLayout::CacheMemoryMappings()
     0.25%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c357e0
     0.25%     0.00%  perf     libc.so.6                   [.] exit
     0.25%     0.00%  perf     libc.so.6                   [.] 0x00007f0ca7=
70855b
     0.25%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
859edd
     0.24%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:StackDepotBase<__sanitizer::StackDepotNode, 1, 20>::lock(__sanitizer::atom=
ic_uint32_t*)
     0.24%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9cc0eb
     0.24%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d05819
     0.24%     0.08%  perf     libasan.so.8.0.0            [.] __lsan::Poin=
tsIntoChunk(void*)
     0.23%     0.02%  perf     [kernel.kallsyms]           [k] folio_remove=
_rmap_ptes
     0.23%     0.17%  perf     [kernel.kallsyms]           [k] __rcu_read_u=
nlock
     0.23%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:CombinedAllocator<__sanitizer::SizeClassAllocator32<__sanitizer::AP32>, __=
sanitizer::LargeMmapAllocatorPtrArrayStatic>::Allocate(__sanitizer::SizeCla=
ssAllocator32LocalCache<__sanitizer::SizeClassAllocator32<__sanitizer::AP32=
> >*, unsigned long, unsigned long)
     0.23%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:SizeClassAllocator32LocalCache<__sanitizer::SizeClassAllocator32<__sanitiz=
er::AP32> >::Refill(__sanitizer::SizeClassAllocator32LocalCache<__sanitizer=
::SizeClassAllocator32<__sanitizer::AP32> >::PerClass*, __sanitizer::SizeCl=
assAllocator32<__sanitizer::AP32>*, unsigned long)
     0.23%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:SizeClassAllocator32<__sanitizer::AP32>::AllocateBatch(__sanitizer::Alloca=
torStats*, __sanitizer::SizeClassAllocator32LocalCache<__sanitizer::SizeCla=
ssAllocator32<__sanitizer::AP32> >*, unsigned long)
     0.23%     0.02%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:SizeClassAllocator32<__sanitizer::AP32>::PopulateFreeList(__sanitizer::All=
ocatorStats*, __sanitizer::SizeClassAllocator32LocalCache<__sanitizer::Size=
ClassAllocator32<__sanitizer::AP32> >*, __sanitizer::SizeClassAllocator32<_=
_sanitizer::AP32>::SizeClassInfo*, unsigned long)
     0.23%     0.01%  perf     libasan.so.8.0.0            [.] __asan::Pois=
onShadow(unsigned long, unsigned long, unsigned char)
     0.23%     0.01%  perf     [kernel.kallsyms]           [k] free_unref_f=
olios
     0.22%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85bddf
     0.22%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
493c5f
     0.22%     0.00%  perf     libc.so.6                   [.] 0x00007f0ca7=
8198e7
     0.22%     0.22%  perf     [kernel.kallsyms]           [k] __asan_store=
4_noabort
     0.22%     0.01%  perf     [kernel.kallsyms]           [k] __page_cache=
_release
     0.22%     0.00%  perf     [kernel.kallsyms]           [k] unlink_anon_=
vmas
     0.22%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
859bed
     0.22%     0.12%  perf     [kernel.kallsyms]           [k] __mod_memcg_=
lruvec_state
     0.21%     0.21%  perf     [kernel.kallsyms]           [k] mark_lock
     0.21%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc6ac
     0.21%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc7c0
     0.21%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
85b531
     0.21%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
33e22b
     0.21%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
857d6b
     0.21%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
741ac9
     0.21%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d02128
     0.21%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
48cf98
     0.20%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
001094
     0.20%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
446d1c
     0.20%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
86fc6c
     0.20%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
82d622
     0.20%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
85bdc3
     0.20%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c34b82
     0.20%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
88b8e2
     0.20%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
8d9bdb
     0.19%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d0f40c
     0.19%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
773570
     0.19%     0.15%  perf     [kernel.kallsyms]           [k] __orc_find
     0.19%     0.03%  perf     [kernel.kallsyms]           [k] __lruvec_sta=
t_mod_folio
     0.19%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e16ee
     0.19%     0.00%  perf     libc.so.6                   [.] 0x00007f0ca7=
81d180
     0.19%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
88a530
     0.19%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
a90ade
     0.18%     0.04%  perf     [kernel.kallsyms]           [k] free_frozen_=
page_commit
     0.18%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c8988c
     0.18%     0.07%  perf     [kernel.kallsyms]           [k] unwind_get_r=
eturn_address
     0.18%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d1ba7b
     0.18%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d05af8
     0.17%     0.00%  perf     [kernel.kallsyms]           [k] __put_anon_v=
ma
     0.17%     0.17%  perf     [kernel.kallsyms]           [k] rcu_lockdep_=
current_cpu_online
     0.17%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7789cd
     0.17%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
83b753
     0.17%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
84098b
     0.17%     0.17%  perf     [kernel.kallsyms]           [k] __asan_load1=
_noabort
     0.17%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85a79f
     0.16%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3ec6de
     0.16%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81ed94
     0.16%     0.16%  perf     [kernel.kallsyms]           [k] copy_mc_enha=
nced_fast_string
     0.16%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c691a6
     0.16%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
857bab
     0.16%     0.15%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:LargeMmapAllocator<__asan::AsanMapUnmapCallback, __sanitizer::LargeMmapAll=
ocatorPtrArrayDynamic, __sanitizer::LocalAddressSpaceView>::GetBlockBeginFa=
stLocked(void*)
     0.16%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
83d3c5
     0.16%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81dec3
     0.16%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d0ac73
     0.16%     0.00%  perf     ld-linux-x86-64.so.2        [.] _dl_exceptio=
n_create_format
     0.16%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d0aa43
     0.15%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2780d4
     0.15%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4aa00
     0.15%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc7fa
     0.15%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
844f4f
     0.15%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
493c4c
     0.15%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91c340
     0.15%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81e7e6
     0.15%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445bc5
     0.14%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4e0865
     0.14%     0.03%  perf     [kernel.kallsyms]           [k] asm_sysvec_a=
pic_timer_interrupt
     0.14%     0.13%  perf     [kernel.kallsyms]           [k] __lock_relea=
se.isra.0
     0.14%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc660
     0.14%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81dea5
     0.14%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
493c52
     0.14%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91bca1
     0.14%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81f0be
     0.14%     0.00%  perf     libasan.so.8.0.0            [.] __asan::Init=
ializeAsanInterceptors()
     0.14%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc7ea
     0.13%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9f6747
     0.13%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:AddModuleSegments(char const*, dl_phdr_info*, __sanitizer::InternalMmapVec=
torNoCtor<__sanitizer::LoadedModule>*) [clone .part.0]
     0.13%     0.01%  perf     libc.so.6                   [.] __cxa_finali=
ze
     0.13%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
88b077
     0.13%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
73a6dd
     0.13%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3df4f9
     0.13%     0.00%  perf     [kernel.kallsyms]           [k] __call_rcu_c=
ommon.constprop.0
     0.13%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
817122
     0.13%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8174e7
     0.13%     0.00%  perf     [kernel.kallsyms]           [k] __mem_cgroup=
_uncharge_folios
     0.13%     0.06%  perf     [kernel.kallsyms]           [k] kernel_text_=
address
     0.13%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c64263
     0.13%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
963b55
     0.13%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
990476
     0.12%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d09d10
     0.12%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
81348b
     0.12%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
964278
     0.12%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
88a58e
     0.12%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
791b85
     0.12%     0.12%  perf     [kernel.kallsyms]           [k] mtree_range_=
walk
     0.12%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
86c8c9
     0.12%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
86bf3c
     0.12%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
00106a
     0.12%     0.12%  perf     [kernel.kallsyms]           [k] validate_cha=
in
     0.12%     0.12%  perf     [kernel.kallsyms]           [k] stack_trace_=
consume_entry
     0.11%     0.00%  perf     libasan.so.8.0.0            [.] __intercepto=
r_realloc.part.0
     0.11%     0.00%  perf     libasan.so.8.0.0            [.] __asan::asan=
_realloc(void*, unsigned long, __sanitizer::BufferedStackTrace*)
     0.11%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9cb201
     0.11%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:LoadedModule::set(char const*, unsigned long)
     0.11%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:internal_strdup(char const*)
     0.11%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d05df7
     0.11%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d21930
     0.11%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d05983
     0.11%     0.00%  perf     libbabeltrace-ctf.so.1.0.0  [.] 0x00007f0ca0=
2332c7
     0.11%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] g_quark_from=
_string
     0.11%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] g_malloc
     0.11%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
263b4a
     0.11%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] 0x00007f0c9d=
8bbf10
     0.11%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80a585
     0.11%     0.00%  perf     [kernel.kallsyms]           [k] sysvec_apic_=
timer_interrupt
     0.11%     0.01%  perf     [kernel.kallsyms]           [k] __unwind_sta=
rt
     0.11%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
83b6eb
     0.11%     0.09%  perf     [kernel.kallsyms]           [k] __rcu_read_l=
ock
     0.11%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
791af7
     0.11%     0.11%  perf     [kernel.kallsyms]           [k] asm_exc_page=
_fault
     0.11%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
000b90
     0.11%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4471e4
     0.11%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:StackDepotPut(__sanitizer::StackTrace)
     0.11%     0.03%  perf     [kernel.kallsyms]           [k] __kernel_tex=
t_address
     0.11%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e1602
     0.10%     0.02%  perf     [kernel.kallsyms]           [k] __might_resc=
hed
     0.10%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4461d2
     0.10%     0.02%  perf     [kernel.kallsyms]           [k] lru_gen_upda=
te_size
     0.10%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d07580
     0.10%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c44cbb
     0.10%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
80e2a2
     0.10%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81e6be
     0.10%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] 0x00007f0c9d=
902806
     0.10%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] g_hash_table=
_new_full
     0.10%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] g_slice_allo=
c
     0.10%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
2e0c53
     0.10%     0.00%  perf     libstdc++.so.6.0.30         [.] 0x00007f0ca0=
4187b5
     0.10%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e16df
     0.10%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
857490
     0.10%     0.03%  perf     [kernel.kallsyms]           [k] __hrtimer_ru=
n_queues
     0.10%     0.00%  perf     [kernel.kallsyms]           [k] free_pcppage=
s_bulk
     0.10%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
776acf
     0.10%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44553f
     0.10%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
343249
     0.09%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
88b064
     0.09%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:MmapAlignedOrDieOnFatalError(unsigned long, unsigned long, char const*)
     0.09%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc69a
     0.09%     0.00%  perf     libasan.so.8.0.0            [.] __do_global_=
dtors_aux
     0.09%     0.00%  perf     libasan.so.8.0.0            [.] __lsan::DoLe=
akCheck()
     0.09%     0.00%  perf     libasan.so.8.0.0            [.] __lsan::Chec=
kForLeaks()
     0.09%     0.00%  perf     libasan.so.8.0.0            [.] __lsan::Lock=
StuffAndStopTheWorld(void (*)(__sanitizer::SuspendedThreadsList const&, voi=
d*), __lsan::CheckForLeaksParam*)
     0.09%     0.00%  perf     libasan.so.8.0.0            [.] __lsan::Lock=
StuffAndStopTheWorldCallback(dl_phdr_info*, unsigned long, void*)
     0.09%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:StopTheWorld(void (*)(__sanitizer::SuspendedThreadsList const&, void*), vo=
id*)
     0.09%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c49a10
     0.09%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
493c38
     0.09%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c72b49
     0.09%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
88b04c
     0.09%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e16e4
     0.09%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c3f441
     0.09%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d07887
     0.09%     0.00%  perf     libasan.so.8.0.0            [.] __asan::Allo=
cator::QuarantineChunk(__asan::AsanChunk*, void*, __sanitizer::BufferedStac=
kTrace*) [clone .isra.0]
     0.09%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
2e1989
     0.09%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
2e199f
     0.09%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
3964fa
     0.09%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c72b1a
     0.09%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3ebb75
     0.09%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
48d06a
     0.09%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7789f1
     0.09%     0.02%  perf     [kernel.kallsyms]           [k] hrtimer_inte=
rrupt
     0.09%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7388f9
     0.09%     0.05%  perf     [kernel.kallsyms]           [k] cgroup_rstat=
_updated
     0.09%     0.09%  perf     [kernel.kallsyms]           [k] error_entry
     0.09%     0.02%  perf     [kernel.kallsyms]           [k] uncharge_fol=
io
     0.09%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e150e
     0.09%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
816feb
     0.09%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc810
     0.09%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91381e
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c73722
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
83b5bf
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
34159a
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
753a82
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7452aa
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
744ed4
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
744b2a
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7735ab
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4a1c3e
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e1219
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85768c
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5d596d
     0.08%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
8c596c
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445f91
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
776899
     0.08%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
73a51f
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
859819
     0.08%     0.00%  perf     libasan.so.8.0.0            [.] __lsan::ForE=
achChunk(void (*)(unsigned long, void*), void*)
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c3cf96
     0.08%     0.00%  perf     [unknown]                   [k] 0xffffffff82=
c736a7
     0.08%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] 0x00007f0c9d=
902771
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446d9a
     0.08%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
2e13e9
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3dff11
     0.08%     0.08%  perf     [kernel.kallsyms]           [k] __kasan_chec=
k_write
     0.08%     0.08%  perf     [kernel.kallsyms]           [k] do_raw_spin_=
lock
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4e3f79
     0.08%     0.03%  perf     [kernel.kallsyms]           [k] __irq_exit_r=
cu
     0.08%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446b9d
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc874
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81912a
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5d5952
     0.07%     0.07%  perf     [kernel.kallsyms]           [k] match_held_l=
ock
     0.07%     0.07%  perf     [kernel.kallsyms]           [k] __kasan_chec=
k_read
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
830db1
     0.07%     0.07%  perf     [kernel.kallsyms]           [k] __kasan_chec=
k_byte
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446d29
     0.07%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
2ef673
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
83b1ae
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc6b0
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3964e7
     0.07%     0.03%  perf     libasan.so.8.0.0            [.] __asan_unreg=
ister_globals
     0.07%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
2c44bf
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9cb218
     0.07%     0.02%  perf     libasan.so.8.0.0            [.] __lsan::GetU=
serBegin(unsigned long)
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c6512c
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2ef683
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
82080b
     0.07%     0.07%  perf     [kernel.kallsyms]           [k] handle_mm_fa=
ult
     0.07%     0.07%  perf     [kernel.kallsyms]           [k] __update_loa=
d_avg_cfs_rq
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4fc996
     0.07%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
871c4f
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4ddb2c
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
48cf8f
     0.07%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d4134
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c73700
     0.06%     0.00%  perf     [kernel.kallsyms]           [k] __sysvec_api=
c_timer_interrupt
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c343d8
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
77226d
     0.06%     0.00%  perf     [kernel.kallsyms]           [k] __kasan_slab=
_free
     0.06%     0.00%  perf     [kernel.kallsyms]           [k] kasan_save_f=
ree_info
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
813699
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81e3c5
     0.06%     0.02%  perf     [kernel.kallsyms]           [k] __memcg_slab=
_free_hook
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dcc5c
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
79038f
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c49c50
     0.06%     0.06%  perf     [kernel.kallsyms]           [k] get_page_fro=
m_freelist
     0.06%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d091d5
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
493c58
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81e7db
     0.06%     0.06%  perf     [kernel.kallsyms]           [k] stack_access=
_ok
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
343975
     0.06%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d093ef
     0.06%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
279dbd
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e0cdc
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dcb63
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447155
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e191e
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e15d2
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
95e5c1
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
96e7c5
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
500d60
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4e5d7c
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
88819d
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c49a01
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
845603
     0.06%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
8454a4
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8d9dea
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8135ef
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc8bc
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3964c8
     0.06%     0.00%  perf     libasan.so.8.0.0            [.] __lsan::Coll=
ectIgnoredCb(unsigned long, void*)
     0.06%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] g_malloc0
     0.06%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d0a920
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
396585
     0.06%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
97cc44
     0.06%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
97c83d
     0.06%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
97b5ea
     0.06%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
97b1a4
     0.06%     0.02%  perf     [kernel.kallsyms]           [k] __is_insn_sl=
ot_addr
     0.06%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80a52a
     0.05%     0.05%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
00e269
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d4171
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
494925
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3ec6f6
     0.05%     0.04%  perf     [kernel.kallsyms]           [k] perf_adjust_=
freq_unthr_context
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c89bff
     0.05%     0.05%  perf     [kernel.kallsyms]           [k] do_user_addr=
_fault
     0.05%     0.05%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
00e26c
     0.05%     0.02%  perf     [kernel.kallsyms]           [k] __free_one_p=
age
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445c21
     0.05%     0.01%  perf     [kernel.kallsyms]           [k] sched_tick
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447383
     0.05%     0.00%  perf     [kernel.kallsyms]           [k] tick_nohz_ha=
ndler
     0.05%     0.00%  perf     [kernel.kallsyms]           [k] update_proce=
ss_times
     0.05%     0.01%  perf     [kernel.kallsyms]           [k] irq_exit_rcu
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c73631
     0.05%     0.05%  perf     [kernel.kallsyms]           [k] __asan_load2=
_noabort
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7917ab
     0.05%     0.04%  perf     [kernel.kallsyms]           [k] find_held_lo=
ck
     0.05%     0.05%  perf     [kernel.kallsyms]           [k] folio_add_fi=
le_rmap_ptes
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc664
     0.05%     0.05%  perf     [kernel.kallsyms]           [k] mark_usage
     0.05%     0.05%  perf     [kernel.kallsyms]           [k] lock_vma_und=
er_rcu
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c356d4
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
494932
     0.05%     0.01%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:internal_memset(void*, int, unsigned long)
     0.05%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:internal_allocator() [clone .part.0]
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445e8d
     0.05%     0.05%  perf     [kernel.kallsyms]           [k] __asan_store=
1_noabort
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81e51c
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
493c30
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
817aae
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4466ab
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e1ff6
     0.05%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:OpenFile(char const*, __sanitizer::FileAccessMode, int*)
     0.05%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:internal_open(char const*, int, unsigned int)
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
96412c
     0.05%     0.05%  perf     [kernel.kallsyms]           [k] kasan_byte_a=
ccessible
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8da9cf
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
813949
     0.05%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:MmapNamed(void*, unsigned long, int, int, char const*)
     0.05%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d062bd
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446cd0
     0.05%     0.05%  perf     [kernel.kallsyms]           [k] orc_find.par=
t.0
     0.05%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d0ac84
     0.05%     0.00%  perf     libc.so.6                   [.] 0x00007f0ca7=
74ef4c
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
871e41
     0.05%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
26227f
     0.05%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
4c4aab
     0.05%     0.00%  perf     libLLVM-14.so.1             [.] llvm::cl::ge=
tGeneralCategory()
     0.05%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
34ef5e
     0.05%     0.00%  perf     libLLVM-14.so.1             [.] llvm::Manage=
dStaticBase::RegisterManagedStatic(void* (*)(), void (*)(void*)) const
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
a909fd
     0.05%     0.00%  perf     libasan.so.8.0.0            [.] __intercepto=
r___cxa_atexit
     0.05%     0.00%  perf     libc.so.6                   [.] 0x00007f0ca7=
707e83
     0.05%     0.00%  perf     libc.so.6                   [.] 0x00007f0ca7=
707dfa
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
96dc0d
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80ddfa
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
844c41
     0.05%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:CloseFile(int)
     0.05%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
81ec7e
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4e32d5
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91d791
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
88b5aa
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81f9fb
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
f2a91c
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4d353d
     0.05%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] g_hash_table=
_insert
     0.05%     0.05%  perf     [kernel.kallsyms]           [k] xas_next_ent=
ry
     0.05%     0.00%  perf     libc.so.6                   [.] dlerror
     0.05%     0.00%  perf     libc.so.6                   [.] __asprintf
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8ddb6f
     0.05%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dcb27
     0.04%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d232e0
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
516d83
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5168db
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3e8ae7
     0.04%     0.04%  perf     [kernel.kallsyms]           [k] __accumulate=
_pelt_segments
     0.04%     0.04%  perf     [kernel.kallsyms]           [k] update_curr_=
task
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
741a84
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c89bf7
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d6c20
     0.04%     0.03%  perf     [kernel.kallsyms]           [k] perf_event_t=
ask_tick
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445cbd
     0.04%     0.00%  perf     [kernel.kallsyms]           [k] task_work_ru=
n
     0.04%     0.04%  perf     [kernel.kallsyms]           [k] xas_load
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91ef62
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8ddb30
     0.04%     0.04%  perf     [kernel.kallsyms]           [k] finish_fault
     0.04%     0.04%  perf     [kernel.kallsyms]           [k] lockdep_hard=
irqs_on_prepare
     0.04%     0.00%  perf     libasan.so.8.0.0            [.] __asan::OnLo=
wLevelAllocate(unsigned long, unsigned long)
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
82a31b
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8295d6
     0.04%     0.04%  perf     [kernel.kallsyms]           [k] do_anonymous=
_page
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
862e45
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446137
     0.04%     0.00%  perf     libasan.so.8.0.0            [.] __intercepto=
r_pthread_create
     0.04%     0.00%  perf     libc.so.6                   [.] pthread_crea=
te
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91900c
     0.04%     0.04%  perf     [kernel.kallsyms]           [k] rmqueue_bulk
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
793d1f
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5d5a8c
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d4199
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c735fc
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446ba5
     0.04%     0.01%  perf     [kernel.kallsyms]           [k] slab_free_af=
ter_rcu_debug
     0.04%     0.00%  perf     [kernel.kallsyms]           [k] handle_softi=
rqs
     0.04%     0.00%  perf     [kernel.kallsyms]           [k] rcu_core
     0.04%     0.00%  perf     [kernel.kallsyms]           [k] rcu_do_batch
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c73727
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80a4f4
     0.04%     0.04%  perf     [kernel.kallsyms]           [k] ___pte_offse=
t_map
     0.04%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
2d06de
     0.04%     0.00%  perf     libLLVM-14.so.1             [.] polly::initi=
alizePollyPasses(llvm::PassRegistry&)
     0.04%     0.00%  perf     libasan.so.8.0.0            [.] __lsan::Floo=
dFillTag(__sanitizer::InternalMmapVector<unsigned long>*, __lsan::ChunkTag)=
 [clone .constprop.0]
     0.04%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d079ac
     0.04%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d22740
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc68a
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc6a8
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
0013e6
     0.04%     0.04%  perf     [kernel.kallsyms]           [k] __handle_mm_=
fault
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
57e1b7
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc714
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7403af
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
73719c
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
736d69
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c64172
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
57e22b
     0.04%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:ReserveShadowMemoryRange(unsigned long, unsigned long, char const*, bool)
     0.04%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:MmapFixedSuperNoReserve(unsigned long, unsigned long, char const*)
     0.04%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:MmapFixed(unsigned long, unsigned long, int, char const*) [clone .constpro=
p.0]
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9900ab
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
96e935
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e1a3c
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e231f
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e200e
     0.04%     0.00%  perf     libLLVM-14.so.1             [.] std::_Rb_tre=
e_iterator<std::pair<unsigned int const, std::__cxx11::basic_string<char, s=
td::char_traits<char>, std::allocator<char> > > > std::_Rb_tree<unsigned in=
t, std::pair<unsigned int const, std::__cxx11::basic_string<char, std::char=
_traits<char>, std::allocator<char> > >, std::_Select1st<std::pair<unsigned=
 int const, std::__cxx11::basic_string<char, std::char_traits<char>, std::a=
llocator<char> > > >, std::less<unsigned int>, std::allocator<std::pair<uns=
igned int const, std::__cxx11::basic_string<char, std::char_traits<char>, s=
td::allocator<char> > > > >::_M_insert_unique_<std::pair<unsigned int const=
, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<c=
har> > > const&, std::_Rb_tree<unsigned int, std::pair<unsigned int const, =
std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<cha=
r> > >, std::_Select1st<std::pair<unsigned int const, std::__cxx11::basic_s=
tring<char, std::char_traits<char>, std::allocator<char> > > >, std::less<u=
nsigned int>, std::allocator<std::pair<unsigned int const, std::__cxx11::ba=
sic_string<char, std::char_traits<char>, std::allocator<char> > > > >::_All=
oc_node>(std::_Rb_tree_const_iterator<std::pair<unsigned int const, std::__=
cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > > =
>, std::pair<unsigned int const, std::__cxx11::basic_string<char, std::char=
_traits<char>, std::allocator<char> > > const&, std::_Rb_tree<unsigned int,=
 std::pair<unsigned int const, std::__cxx11::basic_string<char, std::char_t=
raits<char>, std::allocator<char> > >, std::_Select1st<std::pair<unsigned i=
nt const, std::__cxx11::basic_string<char, std::char_traits<char>, std::all=
ocator<char> > > >, std::less<unsigned int>, std::allocator<std::pair<unsig=
ned int const, std::__cxx11::basic_string<char, std::char_traits<char>, std=
::allocator<char> > > > >::_Alloc_node&)
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc440
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dcb26
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4a1c36
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc47f
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9f5e43
     0.04%     0.00%  perf     libasan.so.8.0.0            [.] operator del=
ete(void*)
     0.04%     0.00%  perf     libc.so.6                   [.] 0x00007f0ca7=
7483dd
     0.04%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44725d
     0.04%     0.04%  perf     [kernel.kallsyms]           [k] mark_held_lo=
cks
     0.04%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d0bc00
     0.04%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
85b898
     0.04%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
8dc6a4
     0.04%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
2e1529
     0.04%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
8dc710
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44a6db
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
914612
     0.03%     0.03%  perf     [kernel.kallsyms]           [k] call_functio=
n_single_prep_ipi
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
516833
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4e0833
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
001115
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3f86d7
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
741ae9
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3e8dab
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7389a1
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
741a08
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
42b7e9
     0.03%     0.03%  perf     [kernel.kallsyms]           [k] update_load_=
avg
     0.03%     0.03%  perf     [kernel.kallsyms]           [k] update_curr
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
918f18
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4a1c7b
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
914577
     0.03%     0.03%  perf     [kernel.kallsyms]           [k] exc_page_fau=
lt
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
0013fd
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80a565
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c73030
     0.03%     0.03%  perf     [kernel.kallsyms]           [k] __count_memc=
g_events
     0.03%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.03%     0.03%  perf     [kernel.kallsyms]           [k] folio_batch_=
move_lru
     0.03%     0.00%  perf     perf                        [.] symbol__init=
_regexpr
     0.03%     0.00%  perf     libasan.so.8.0.0            [.] __intercepto=
r_regcomp.part.0
     0.03%     0.00%  perf     libc.so.6                   [.] regcomp
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
913781
     0.03%     0.03%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
008d9b
     0.03%     0.03%  perf     [kernel.kallsyms]           [k] task_tick_mm=
_cid
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91458c
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4471ea
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c57ee
     0.03%     0.00%  perf     libc.so.6                   [.] 0x00007f0ca7=
752d6b
     0.03%     0.00%  perf     libc.so.6                   [.] 0x00007f0ca7=
7d3828
     0.03%     0.00%  perf     libc.so.6                   [.] 0x00007f0ca7=
7d37b0
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
343c20
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80a576
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
260fc3
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
829232
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
914683
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d4077
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2ec68b
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91ef3f
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447141
     0.03%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:InternalMmapVectorNoCtor<unsigned long>::push_back(unsigned long const&)
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91c398
     0.03%     0.01%  perf     perf                        [.] _sub_I_00099=
_1
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc4b0
     0.03%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d0a0c5
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446036
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c343cf
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
911b4e
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2ec962
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
871e25
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80a58a
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4a1c41
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7722d1
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
43f16b
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91229d
     0.03%     0.03%  perf     [kernel.kallsyms]           [k] consume_stoc=
k
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8137cd
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
494238
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
862e0d
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c7367a
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
86c86f
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c89b37
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
912164
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5d58ec
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc444
     0.03%     0.03%  perf     [kernel.kallsyms]           [k] trace_irq_en=
able.constprop.0
     0.03%     0.03%  perf     [kernel.kallsyms]           [k] do_raw_spin_=
unlock
     0.03%     0.03%  perf     [kernel.kallsyms]           [k] page_ref_add=
_unless.constprop.0
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4948d7
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc67b
     0.03%     0.03%  perf     [kernel.kallsyms]           [k] __mod_memcg_=
state
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc74a
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
813ac6
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
73a53c
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
86bb05
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
48d07f
     0.03%     0.03%  perf     [kernel.kallsyms]           [k] filemap_map_=
pages
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4471dc
     0.03%     0.03%  perf     [kernel.kallsyms]           [k] __folio_batc=
h_add_and_move
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
776964
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e0ce7
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
99004a
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7406e6
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
912057
     0.03%     0.03%  perf     [kernel.kallsyms]           [k] __pte_offset=
_map_lock
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c73724
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e16c8
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dcd24
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c73663
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c63c53
     0.03%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca3=
59fcdf
     0.03%     0.03%  perf     [kernel.kallsyms]           [k] mas_walk
     0.03%     0.00%  perf     perf                        [.] __asan_unreg=
ister_globals@plt
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e202a
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
770498
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
98fff2
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81393e
     0.03%     0.03%  perf     [kernel.kallsyms]           [k] mangle_path
     0.03%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
26352e
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4a1c75
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e150a
     0.03%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
355d1d
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
444706
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
a8f9c7
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc870
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3ba570
     0.03%     0.00%  perf     libasan.so.8.0.0            [.] __asan::Asan=
Thread::ClearShadowForThreadStackAndTLS()
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c45b82
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9cb029
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9cbdd4
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
963b6f
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8ddb34
     0.03%     0.00%  perf     libnuma.so.1.0.0            [.] 0x00007f0ca0=
27e966
     0.03%     0.00%  perf     libasan.so.8.0.0            [.] __intercepto=
r___getdelim.part.0
     0.03%     0.00%  perf     libc.so.6                   [.] __getdelim
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85a785
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4c20f
     0.03%     0.00%  perf     libasan.so.8.0.0            [.] __intercepto=
r_fclose
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
819b32
     0.03%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d0762a
     0.03%     0.00%  perf     libnuma.so.1.0.0            [.] 0x00007f0ca0=
27ea2f
     0.03%     0.00%  perf     libc.so.6                   [.] 0x00007f0ca7=
799d4d
     0.03%     0.00%  perf     libc.so.6                   [.] 0x00007f0ca7=
799ce0
     0.03%     0.00%  perf     libz3.so.4                  [.] 0x00007f0c9d=
d57feb
     0.03%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] 0x00007f0c9d=
8df017
     0.03%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] 0x00007f0c9d=
8de80b
     0.03%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] 0x00007f0c9d=
8de4e8
     0.03%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] g_realloc
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e1c9b
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4e22f0
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44593f
     0.03%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
2657d9
     0.03%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d020e0
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4ccd64
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446290
     0.03%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:ThreadSuspender::SuspendAllThreads()
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e15a3
     0.03%     0.00%  perf     [unknown]                   [k] 0xffffffff82=
c73634
     0.03%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
2d5d22
     0.03%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] g_private_ge=
t
     0.03%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] 0x00007f0c9d=
94662e
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
983df2
     0.03%     0.03%  perf     [kernel.kallsyms]           [k] __read_once_=
word_nocheck
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
657071
     0.03%     0.00%  perf     libc.so.6                   [.] pthread_geta=
ttr_np
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
813921
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
83a88f
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
793bc2
     0.03%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
494232
     0.03%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
73a6d4
     0.03%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e0f2a
     0.03%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
49421f
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] ftrace_graph=
_ret_addr
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e19dd
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5ef052
     0.02%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
a5bfda
     0.02%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
a5aeab
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4d3487
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c7360d
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
912412
     0.02%     0.01%  perf     [kernel.kallsyms]           [k] rcu_read_loc=
k_sched_held
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
494936
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
2ceafd
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] llvm::Regex:=
:Regex(llvm::StringRef, llvm::Regex::RegexFlags)
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] llvm_regcomp
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4a1c57
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
494929
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
79405e
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
355038
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] kick_ilb
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d593e
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
35502d
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] charge_memcg
     0.02%     0.00%  perf     libc.so.6                   [.] 0x00007f0ca7=
752fb0
     0.02%     0.00%  perf     libc.so.6                   [.] 0x00007f0ca7=
75044f
     0.02%     0.00%  perf     libasan.so.8.0.0            [.] __asan::Asan=
Thread::Destroy()
     0.02%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.02%     0.01%  perf     [kernel.kallsyms]           [k] page_counter=
_uncharge
     0.02%     0.00%  perf     [kernel.kallsyms]           [k] uncharge_bat=
ch
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7419e0
     0.02%     0.02%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
00e26f
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
40d0a6
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] __hrtimer_ne=
xt_event_base
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4df883
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] lapic_next_d=
eadline
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4fc9fe
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446d3d
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
40cf44
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc694
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4df175
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] intel_pmu_di=
sable_all
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
22091c
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3ebb9a
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] __update_loa=
d_avg_se
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4ddbba
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4a867e
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] trace_pelt_s=
e_tp
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
40c946
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
40cb0b
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d3fdd
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3c22c4
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] percpu_count=
er_add_batch
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dcb25
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9146d5
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] vm_normal_pa=
ge
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446bfe
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
40f9cf
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
42b940
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] do_pte_missi=
ng
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446cdc
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446030
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c7361a
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81fe77
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] vma_alloc_fo=
lio_noprof
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3e0093
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4df26b
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
911ba9
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
914572
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
494920
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
86c8d6
     0.02%     0.01%  perf     [kernel.kallsyms]           [k] update_rq_cl=
ock_task
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c73039
     0.02%     0.01%  perf     [kernel.kallsyms]           [k] idle_cpu
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
494217
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4948d0
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7914f8
     0.02%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
a5bb63
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c343a4
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c35790
     0.02%     0.00%  perf     [kernel.kallsyms]           [k] is_bpf_text_=
address
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] free_pud_ran=
ge
     0.02%     0.00%  perf     [kernel.kallsyms]           [k] free_pgd_ran=
ge
     0.02%     0.00%  perf     [kernel.kallsyms]           [k] free_p4d_ran=
ge
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c73608
     0.02%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.02%     0.02%  perf     libc.so.6                   [.] 0x0000000000=
1532a0
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81f83d
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c73c63
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445514
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] irqentry_exi=
t_to_user_mode
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8190df
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
395f0e
     0.02%     0.00%  perf     libc.so.6                   [.] 0x00007f0ca7=
7b4e0d
     0.02%     0.00%  perf     libc.so.6                   [.] 0x00007f0ca7=
7ab23a
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
83b1c8
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] trace_irq_di=
sable.constprop.0
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91242a
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445e5c
     0.02%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44a6c7
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c39f4b
     0.02%     0.00%  perf     [kernel.kallsyms]           [k] tlb_finish_m=
mu
     0.02%     0.02%  perf     libc.so.6                   [.] 0x0000000000=
1532aa
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
48cf7a
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c7371c
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
83b291
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
790412
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9144c6
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44558c
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5d5a06
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
98f344
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e1653
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81e468
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] get_vma_poli=
cy
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c4c07
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] lru_add
     0.02%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85e721
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c40fef
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
43f1af
     0.02%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.02%     0.00%  perf     [kernel.kallsyms]           [k] kfree
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
772299
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dcc78
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4948f2
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8da9c2
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7789fd
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445500
     0.02%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5d586e
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8ddb14
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d3ec6
     0.02%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:internal_memcpy(void*, void const*, unsigned long)
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] memset_orig
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] stack_depot_=
save_flags
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91c141
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445d32
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80a620
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] llvm::initia=
lizeCodeGenerationPass(llvm::PassRegistry&)
     0.02%     0.00%  perf     libc.so.6                   [.] 0x00007f0ca7=
757fa5
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca4=
0b0a47
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] llvm::initia=
lizeDependenceInfoPass(llvm::PassRegistry&)
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca4=
051a87
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] llvm::initia=
lizeScopInfoRegionPassPass(llvm::PassRegistry&)
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc75c
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e0cf3
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
858a58
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c45a12
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc760
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dcb19
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] __alloc_froz=
en_pages_noprof
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e1a07
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7cc60f
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dcbca
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8595d9
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc8c0
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4459ee
     0.02%     0.02%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
00e261
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3c03cb
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] sync_regs
     0.02%     0.01%  perf     [kernel.kallsyms]           [k] free_swap_ca=
che
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
493c55
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e0cb1
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] __mem_cgroup=
_charge
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
840c94
     0.02%     0.02%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
00e24b
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4d34ab
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
213c35
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2294bd
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] commit_merge
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c89a38
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4446cc
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c356cb
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
98bc77
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9a360c
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81e276
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81f28e
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
98c64e
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
500bad
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446cb0
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
83b63d
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] lockdep_hard=
irqs_on
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
83b298
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446217
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445ca2
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dcb51
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] mas_wr_store=
_type
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
914732
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e2022
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
57e194
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445fe9
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7735bc
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
72efa2
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c387c4
     0.02%     0.01%  perf     [kernel.kallsyms]           [k] mas_next_slo=
t
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e156a
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dcb1e
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
494210
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
776b86
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc89a
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c7369a
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
86ac8a
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
861b5c
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445c96
     0.02%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d131b5
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4163e5
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc685
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445fd6
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91ce5f
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445ee5
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
776a9a
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
889279
     0.02%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:MmapOrDieOnFatalError(unsigned long, char const*)
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91c393
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8191b9
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
859d09
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5d5866
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e1bcc
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc483
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] __might_slee=
p
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
2ad8e7
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] std::_Rb_tre=
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
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] rmqueue.cons=
tprop.0
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
26f0ef
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c735e7
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4d34a4
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
2a126a
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
858aa2
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] trace_hardir=
qs_on
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e19ac
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
88b2e5
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
96e0cc
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8ddb10
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e13f5
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4461de
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446ce0
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
77228e
     0.02%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
a5aa0b
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] handle_pte_f=
ault
     0.02%     0.00%  perf     libasan.so.8.0.0            [.] __asan::Quic=
kCheckForUnpoisonedRegion(unsigned long, unsigned long)
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dcd29
     0.02%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:LoadedModule::addAddressRange(unsigned long, unsigned long, bool, bool, ch=
ar const*)
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8da1fa
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8de681
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8de020
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc4b4
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
351f36
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] copy_from_ke=
rnel_nofault.part.0
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9f5f83
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9f5705
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
355c59
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4461a4
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445a44
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
2c3957
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446039
     0.02%     0.00%  perf     libasan.so.8.0.0            [.] sched_yield@=
plt
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9f62ea
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8191b4
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e0f3f
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] seq_read_ite=
r
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9ca329
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e1406
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3df5b4
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e11cd
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e1bd8
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446bf8
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9ca2fa
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e1a14
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
888121
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] seq_put_hex_=
ll
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e0c7b
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9cbf7a
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dcc57
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9f62ff
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445db5
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] bpf_ksym_fin=
d
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
657083
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
6508db
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] entry_SYSRET=
Q_unsafe_stack
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
0001c4
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4ccddc
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
7827bb
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
782993
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
782c7e
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] void std::ve=
ctor<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocato=
r<char> >, std::allocator<std::__cxx11::basic_string<char, std::char_traits=
<char>, std::allocator<char> > > >::_M_realloc_insert<std::__cxx11::basic_s=
tring<char, std::char_traits<char>, std::allocator<char> > const&>(__gnu_cx=
x::__normal_iterator<std::__cxx11::basic_string<char, std::char_traits<char=
>, std::allocator<char> >*, std::vector<std::__cxx11::basic_string<char, st=
d::char_traits<char>, std::allocator<char> >, std::allocator<std::__cxx11::=
basic_string<char, std::char_traits<char>, std::allocator<char> > > > >, st=
d::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>=
 > const&)
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e0f2e
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e1a25
     0.02%     0.02%  perf     libasan.so.8.0.0            [.] __asan::CanP=
oisonMemory()
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
268822
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8854cf
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e15a7
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85978e
     0.02%     0.00%  perf     libasan.so.8.0.0            [.] GetIntercept=
orMetadata(__sanitizer::__sanitizer_FILE*)
     0.02%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:AddrHashMap<CommonInterceptorMetadata, 31051ul>::acquire(__sanitizer::Addr=
HashMap<CommonInterceptorMetadata, 31051ul>::Handle*) [clone .isra.0]
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3a5299
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
57e230
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c7372a
     0.02%     0.02%  perf     [kernel.kallsyms]           [k] obj_cgroup_c=
harge
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4471d7
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91c3d2
     0.02%     0.00%  perf     libbabeltrace-ctf.so.1.0.0  [.] 0x00007f0ca0=
2331eb
     0.02%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] g_quark_from=
_static_string
     0.02%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] 0x00007f0c9d=
8dee3a
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c3cc2e
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2780cf
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c898da
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e199a
     0.02%     0.00%  perf     libc.so.6                   [.] 0x00007f0ca7=
748328
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4d34d8
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e11b1
     0.02%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
264562
     0.02%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:internal_waitpid(int, int*, int)
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445a77
     0.02%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] 0x00007f0c9d=
91cd6c
     0.02%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] 0x00007f0c9d=
9102ed
     0.02%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] 0x00007f0c9d=
9102cd
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e1a2a
     0.02%     0.02%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
00e24e
     0.02%     0.00%  perf     libasan.so.8.0.0            [.] __intercepto=
r_free.part.0
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e2048
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e1be4
     0.02%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
3ba78f
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
963b21
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446d0a
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7704a1
     0.02%     0.00%  perf     libc.so.6                   [.] pthread_attr=
_setaffinity_np
     0.02%     0.00%  perf     libc.so.6                   [.] 0x00007f0ca7=
750e7e
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c736c7
     0.02%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
2ec727
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2f32bd
     0.02%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
516520
     0.02%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
739f8e
     0.02%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
72fb77
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445e7a
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
2e1538
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] mem_cgroup_f=
rom_task
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9123c6
     0.01%     0.01%  perf     libLLVM-14.so.1             [.] 0x0000000000=
db8321
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
2c9dd0
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
3452f0
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] next_uptodat=
e_folio
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
2cbbf2
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca3=
a3c8b0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
773566
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e0cbc
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
2cd693
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
93e080
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
2cea5a
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __intercepto=
r_memcpy
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __asan_regio=
n_is_poisoned@plt
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81ff5d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e19f6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
791b41
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81eb00
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
791bc4
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dcb71
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81fefb
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c342de
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
86fc4a
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] change_pte_r=
ange
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
830d55
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8306f6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8300e5
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
82fc2d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
82f1c2
     0.01%     0.01%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
008dea
     0.01%     0.01%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
00e3b6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81edd7
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c641e2
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81feba
     0.01%     0.01%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
008c19
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d09b70
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c73622
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446375
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80a4d1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
49422d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91c360
     0.01%     0.01%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
00e4a0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81ede0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
806bcd
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
840ecc
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] __folio_thro=
ttle_swaprate
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81ecf2
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8a2150
     0.01%     0.01%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
008e29
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9f62fa
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446c07
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c343a0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81f5c6
     0.01%     0.01%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
009973
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
83b391
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8175fb
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
f1dc66
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
793b5b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
884da1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
814e04
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
776ae5
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dcb74
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
86c8d1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5d5a0e
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8701c5
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8d9f18
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dde53
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c74ea6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c3452f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
53e3f8
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] __vmf_anon_p=
repare
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
813428
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
355d20
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81ffbf
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] __mod_lruvec=
_state
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3c9102
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
83b1f5
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91efa4
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
43f14f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
772296
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
86fdc6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
40f854
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
817284
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3e8d15
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4df442
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] filemap_get_=
entry
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
778a06
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
53e416
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5167e0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
eaeb78
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dcb81
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81f4fe
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
911bb4
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4e3f8a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4dee5d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c735e0
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] __do_fault
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
814e46
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
793b12
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4163be
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c68f7c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7703a1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4df7bf
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445524
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
871c56
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
912169
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
914532
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] alloc_pages_=
mpol
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c11d3
     0.01%     0.01%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
008dbb
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
918e3b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446041
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4df19e
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c73604
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5000bf
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44a963
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c57fe
     0.01%     0.01%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
008dda
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80a4f9
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] filemap_faul=
t
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
779466
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3e8c23
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
738951
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c73d11
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4459a0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c346bd
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2c3106
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c64230
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8175f2
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
913740
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
83b1b3
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
791a3e
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d6b70
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3fe3ef
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
840ebb
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
817641
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] tick_program=
_event
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5000ae
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c6e972
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445a52
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
911d1c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81ed39
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4e09bb
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91ef78
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
86fb0c
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] _raw_spin_un=
lock
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c89c06
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
40f88f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c73cdb
     0.01%     0.01%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
00e265
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
793b41
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3c90c8
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
778a2b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4df1e6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c736b6
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] sched_core_i=
dle_cpu
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
355067
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
41658f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9147c8
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] propagate_pr=
otected_usage.part.0
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] xas_reload
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
770fca
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3550d0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3e007f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91c41d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81edca
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
40cd56
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d5a03
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44a953
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] folio_unlock
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81edcf
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
76f5c7
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446d09
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3e8e4d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
001116
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] profile_tick
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
500d17
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4d3300
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
915ce7
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4163f1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
86a9e3
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] rcu_read_loc=
k_held
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
48cfa1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c641bb
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44a64f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4fc9bf
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
773609
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
83b1c4
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
738a2a
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c7358e
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4df4d3
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4de536
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445562
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81f184
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445c06
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] __filemap_ge=
t_folio
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
778b64
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44a617
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3c9030
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d4142
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c641c0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
741a89
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
86ab63
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4df53f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d5a0b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
000df0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3df4de
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3e89a9
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c899d4
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
40cf16
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4e0785
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445eef
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3fe3bb
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
738a75
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c730a4
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dcc52
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
741aba
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] x86_pmu_disa=
ble
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
20f8a1
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] pte_mkwrite
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8170f1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2f0f0f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8da9d8
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
73892e
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
778a26
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
83b74b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d3f4a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
871bc0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44a8e0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4948fd
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] hrtimer_forw=
ard
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
500c7d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4de19d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dcbf1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4df237
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] account_proc=
ess_tick
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
410c17
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
412ef7
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3fe870
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445f37
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] update_min_v=
runtime
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d4cbb
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3e8ec1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c73706
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2c30ed
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
741c09
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
494942
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44614d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
40cc0b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445da3
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
40c94a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c55d70
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] run_posix_cp=
u_timers
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4f8d1d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
48d050
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445d2d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d3f42
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3fc0ae
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3df584
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
40fa0a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c73644
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7723b4
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4a4a43
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
49798f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c73714
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
40c6ea
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] dl_scaled_de=
lta_exec
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] acct_account=
_cputime
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
412ca5
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
412b53
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
58de29
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2ec7c2
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
40cc40
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7388d7
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] task_tick_fa=
ir
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3ec6bc
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] sched_balanc=
e_trigger
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3f863d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3fe3bd
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] __asan_store=
2_noabort
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
82003a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc608
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3ebb81
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc524
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] __mt_destroy
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] mt_destroy_w=
alk
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] kmem_cache_f=
ree_bulk.part.0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
40cd75
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3e0160
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d6c67
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] rcu_pending
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4a4bdf
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8574a4
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
856acb
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c81e0d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3ba7e6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
40c9dc
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c7358d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
40cf76
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
40cd11
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3df536
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3df3fc
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] irq_work_tic=
k
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4ddbdb
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
64fee0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3ec282
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3ec0e0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3eb947
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] update_cfs_g=
roup
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3ec2cb
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] arch_scale_f=
req_tick
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d3fc7
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2812ff
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3df500
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] avg_vruntime
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3ec0eb
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3e9056
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3e8fc7
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
738932
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81e488
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c73520
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44a6ec
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3fe3b6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
40f07c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3c03e8
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3eba39
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d4c19
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d6b72
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44710c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
83b5e2
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3fc081
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4fc951
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3df442
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
494918
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc7ca
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3d6b9e
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4dee47
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3eb98a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3da560
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3eb9c6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3eba4d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
912063
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3df53b
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2ec993
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9144f8
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
918f79
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
914548
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] _raw_spin_lo=
ck_irqsave
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7797aa
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] irqentry_exi=
t
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c73f47
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2ec7fa
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91c333
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7388b7
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
2cfbf7
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca3=
ffb580
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
444652
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445b69
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
817a02
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
53e42f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4e06d8
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44720b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc8aa
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] trace_mm_pag=
e_free
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c3449d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
0013f5
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
83b649
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc895
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81e323
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
914557
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] __vma_start_=
write
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] __vma_enter_=
locked
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
260e71
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8408b8
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
000df6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
840964
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
793ffe
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] __up_write
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] mas_find
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
819098
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2ec951
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91cdec
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c3468e
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] __list_del_e=
ntry_valid_or_report
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
83b18b
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] mas_store_pr=
ealloc
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c4aa5f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
42b772
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
817815
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81f6a6
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3e8b71
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c7370a
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] is_module_te=
xt_address
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
778abf
     0.01%     0.01%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
009078
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2608c2
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c44f25
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
813cc1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
f1dc40
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4a5da1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dcc6f
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] remove_vma
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] fput
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
53e427
     0.01%     0.01%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
00e2dc
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] perf_iterate=
_sb
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
739f20
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] refill_obj_s=
tock
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4466a3
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81e21a
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] vma_is_anon_=
shmem
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8172a9
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7c5a20
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] trace_hrtime=
r_cancel
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] __folio_mod_=
stat
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
83d3ee
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81ee05
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81fedc
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] __refill_sto=
ck
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
912a6c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91256f
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] mod_objcg_st=
ate
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
817b4f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
793e88
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c4cb8
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc568
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
a5ab38
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
887e66
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc7ee
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
396489
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c55d5d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c5189f
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] do_read_faul=
t
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
817a8b
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c39b25
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
84512f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
43c927
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446d07
     0.01%     0.01%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
022365
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d1ead4
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d193dc
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d1c623
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d13b1b
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d134cf
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
911b7a
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] rcu_read_unl=
ock
     0.01%     0.01%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.01%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
0236fe
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d09c9f
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] __asan_loadN=
_noabort
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dccd4
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44469f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
0010a1
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] get_mem_cgro=
up_from_objcg
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] obj_cgroup_u=
ncharge_pages
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81ffcf
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
86fe14
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     libc.so.6                   [.] 0x00007f0ca7=
7b4a02
     0.01%     0.00%  perf     libc.so.6                   [.] 0x00007f0ca7=
7ac8cb
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
911b98
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
86c889
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc560
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] security_vm_=
enough_memory_mm
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
cfeeb8
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
86abb2
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] native_sched=
_clock
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] lock_pin_loc=
k
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] sched_clock
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8c579e
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d1edd0
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d146db
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d21b20
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
856326
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
812b66
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
812679
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
79036c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
820138
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] kasan_disabl=
e_current
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8701d3
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8d9b2f
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] __dentry_kil=
l
     0.01%     0.00%  perf     perf                        [.] perf_config
     0.01%     0.00%  perf     perf                        [.] perf_config_=
_init
     0.01%     0.00%  perf     perf                        [.] perf_config_=
set__new
     0.01%     0.00%  perf     perf                        [.] perf_config_=
set__init
     0.01%     0.00%  perf     perf                        [.] access@plt
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
95ecf2
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
95e70d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
98f673
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
98e886
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9a147a
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] account_syst=
em_index_time
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] cpuacct_acco=
unt_field
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81e735
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445ea3
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8408cb
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dcc68
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
791b51
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
73fcaa
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
88896a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e13b7
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
40fa35
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] _raw_spin_lo=
ck
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c89870
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e0f43
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d1f87c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e13c9
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3ba88d
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] fault_in_ker=
nel_space
     0.01%     0.00%  perf     perf                        [.] setup_path
     0.01%     0.00%  perf     perf                        [.] astrcat
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __intercepto=
r_asprintf
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __intercepto=
r_vasprintf
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c73045
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2ed04e
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c40561
     0.01%     0.00%  perf     perf                        [.] _sub_D_00099=
_0
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] mas_leaf_max=
_gap
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c3204a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
840c6e
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
86ac32
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] folio_add_lr=
u
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
794063
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445bc7
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
770438
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc46a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446cb2
     0.01%     0.01%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
00fe12
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d10dc0
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8574f2
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8fb69f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81f08a
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] may_expand_v=
m
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8586c5
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
82c6fe
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] vsnprintf
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:CacheBinaryName()
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:ReadBinaryName(char*, unsigned long)
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
976ad6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
976811
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
98e82c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
98b876
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
98af11
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
ab2240
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c5fd6d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c5f801
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
819016
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44a8fe
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] mas_rev_awal=
k
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85e69a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c477e1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c47218
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c3566e
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81e648
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca4=
082007
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] llvm::initia=
lizeAAResultsWrapperPassPass(llvm::PassRegistry&)
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca2=
6bf708
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] llvm::initia=
lizeBasicAAWrapperPassPass(llvm::PassRegistry&)
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca2=
6d88d9
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] __asan_memse=
t
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8576b3
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
856ef4
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e0ceb
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] fs_reclaim_a=
cquire
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
862e2a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447211
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
2d5713
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca4=
0eff70
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7703a7
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7938d2
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
817088
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c35683
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] mas_wr_slot_=
store
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c40130
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c404e4
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] syscall_retu=
rn_via_sysret
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
00014d
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9138a2
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91eef7
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7938c5
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c34431
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc47b
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] get_stack_in=
fo_noinstr
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] get_stack_in=
fo
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
40cdb9
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c39fb9
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
000b99
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c6fe31
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c81fe4
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44606b
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] lockdep_hard=
irqs_off
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5d5ad9
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c73343
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81723d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7703d2
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
53e3c7
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445eab
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __lsan::Coll=
ectLeaksCb(unsigned long, void*)
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c73ca0
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e11d7
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447107
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81e4ab
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] down_write_k=
illable
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c81f50
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44a925
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] llvm::initia=
lizeDeLICMWrapperPassPass(llvm::PassRegistry&)
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c35789
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
911ada
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
790432
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] flush_tlb_fu=
nc
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
51641b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2f2acb
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44a665
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e19fb
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
793bb8
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c89cf8
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dcb66
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca4=
08201f
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] llvm::initia=
lizeRegionInfoPassPass(llvm::PassRegistry&)
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca2=
881477
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] llvm::initia=
lizeDominanceFrontierWrapperPassPass(llvm::PassRegistry&)
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca2=
781c21
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
493c31
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c6425a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c736d3
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81e780
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
805158
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81ffb3
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc691
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
778986
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc73a
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
79163b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
82d5f2
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
867538
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91d061
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
915e65
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
915bf1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
840c91
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __asan::Asan=
CheckIncompatibleRT()
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
813cd8
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c73231
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3ba86d
     0.01%     0.01%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:mem_is_zero(char const*, unsigned long)
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __lsan::Word=
IsPoisoned(unsigned long)
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __asan_regio=
n_is_poisoned
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:ThreadLister::ListThreads(__sanitizer::InternalMmapVector<unsigned long lo=
ng>*)
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:ThreadLister::IsAlive(int)
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:ReadFileToVector(char const*, __sanitizer::InternalMmapVectorNoCtor<char>*=
, unsigned long, int*)
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44601f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44669c
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
2c8b4d
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca3=
7ffe34
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca3=
800830
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
819039
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c73666
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4948d9
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] llvm::initia=
lizeMaximalStaticExpanderPass(llvm::PassRegistry&)
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] pthread_once=
@plt
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8175b9
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81f6de
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5d5a87
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446b61
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2ec97b
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __asan::Init=
ializeFlags()
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:GetEnv(char const*)
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
98cb8f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
98660a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
aa535c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
aa5104
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
aa4c44
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9af404
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9af2ff
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
a9941e
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
88860a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8845e0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
88623b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8860ab
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c63c46
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
793b46
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81e651
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85739a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
793d2b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
770446
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e1a41
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] refill_stock
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
912987
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
2c6f5f
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca3=
707a20
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
840ebf
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e16da
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:ReadProcessName(char*, unsigned long) [clone .constprop.0] [clone .isra.0]
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:ReadLongProcessName(char*, unsigned long)
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
a9fa1f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
a9cbd8
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80a70d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c82ade
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445be8
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445508
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9120bd
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __lsan::Mark=
IndirectlyLeakedCb(unsigned long, void*)
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
2c4a9e
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
2c5055
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] pte_offset_m=
ap_rw_nolock
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
83b5e9
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
85767c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81917c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
000dfb
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c6fe18
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e1ffb
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] get_pfnblock=
_flags_mask
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c64205
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:SuspendedThreadsListLinux::GetRegistersAndSP(unsigned long, __sanitizer::I=
nternalMmapVector<unsigned long>*, unsigned long*) const
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:SuspendedThreadsListLinux::GetRegistersAndSP(unsigned long, __sanitizer::I=
nternalMmapVector<unsigned long>*, unsigned long*) const::{lambda(unsigned =
long)#1}::operator()(unsigned long) const
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:internal_ptrace(int, int, void*, void*)
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3607b5
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
275588
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
361599
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3acf34
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3acc36
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445bb1
     0.01%     0.00%  perf     [kernel.kallsyms]           [k] folio_mark_a=
ccessed
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e15ec
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
791a68
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
918f64
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81ec6a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446bf0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80a51a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8409a0
     0.01%     0.01%  perf     libasan.so.8.0.0            [.] __asan_regis=
ter_globals
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
793e5f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
793d98
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81ff78
     0.01%     0.00%  perf     perf                        [.] _sub_I_00099=
_1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c44ee7
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
791dbe
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9146b5
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
276eb5
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca2=
134be0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4446ec
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
86aa15
     0.01%     0.00%  perf     perf                        [.] _sub_D_00099=
_0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e13c1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
77109e
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4d34b4
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
793b3a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4461b0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e151f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
f2ab3c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e15c9
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
83b6b2
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e19b5
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
288f05
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca2=
957ed0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c73268
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
2752a6
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca2=
0af75d
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] void llvm::c=
l::apply<llvm::cl::opt<llvm::PGOViewCountsType, false, llvm::cl::parser<llv=
m::PGOViewCountsType> >, llvm::cl::OptionHidden, llvm::cl::desc, llvm::cl::=
ValuesClass>(llvm::cl::opt<llvm::PGOViewCountsType, false, llvm::cl::parser=
<llvm::PGOViewCountsType> >*, llvm::cl::OptionHidden const&, llvm::cl::desc=
 const&, llvm::cl::ValuesClass const&)
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
776ae9
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
776b17
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c34673
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e1a1c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
213bde
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
210e00
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
98ca77
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9bec59
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
213c3d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e1159
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
2874ed
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
871d9e
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e15d7
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
82d68c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5d5968
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
2b418a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
396466
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
340af2
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3a7ee8
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3a7896
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2780ed
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
770430
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e1bec
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
271bfe
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca2=
0326e0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445fc9
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
856e77
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
43c72c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80dddd
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c35745
     0.01%     0.00%  perf     perf                        [.] _sub_D_00099=
_0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
53e40f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dcfea
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8d9d29
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2f1176
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
2866d2
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca2=
7f9440
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c356b9
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44611b
     0.01%     0.01%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
009070
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
86fde6
     0.01%     0.01%  perf     libasan.so.8.0.0            [.] __asan::GetC=
urrentThread()
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
2b9b7a
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __asan::GetC=
urrentThreadStats()
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c3a2ad
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4a1c30
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445b44
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
284629
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d08f45
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
86a976
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e1524
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44552c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
99008b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9a14c6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dcb7e
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
2b1100
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca3=
675fd0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c34505
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] vms_gather_m=
unmap_vmas
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
857efb
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
785afb
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4e234e
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8ddc48
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
2700b4
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] llvm::PassRe=
gistry::registerPass(llvm::PassInfo const&, bool)
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
5a8d55
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] check_slab_a=
llocation
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
88b574
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8d9cb0
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
277cde
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca2=
2149b0
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
2ad071
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445f5e
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
396588
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] update_irq_l=
oad_avg
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
28ccdd
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca3=
088842
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __intercepto=
r_strlen.part.0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
40f0f5
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
73d079
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
755754
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c736bb
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e19f1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
819ec7
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
913823
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c3426a
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
26f632
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
782767
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e0f07
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
856eb8
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
282905
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca2=
6ba0b0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91cd1b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91213e
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c342be
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
28b6d1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44711f
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] register_loc=
k_class
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445cfd
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447720
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d03422
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d0b72c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91d3a6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9133bd
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
29ec3a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9ccb2a
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __asan::Init=
ializeAllocator(__asan::AllocatorOptions const&)
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
43f1a6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
911bb7
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
818f87
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e14f3
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
26ed3f
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
d79520
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c641de
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91dee2
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
917669
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
294152
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9cc1e0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
ea8bf9
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c6932a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
791b5d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446cd6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91ddbd
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9f6387
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445e00
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d07900
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8310aa
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c81fc1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
793d26
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4cce24
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:ProtectGap(unsigned long, unsigned long, unsigned long, unsigned long)
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
791766
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e11c6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9ca32c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
a8f9b0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9ccb1a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c3f45d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c343a9
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e1f5a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4471f9
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d09bd2
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91d380
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5d5841
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
00010d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8da9d9
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e205a
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
27fd6e
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca2=
5502d0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
80a5d5
     0.01%     0.00%  perf     perf                        [.] _sub_D_00099=
_0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9ca314
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
96e0e5
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
96d3ad
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
43944f
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
26cc3d
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
b9cd50
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91d772
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e0cbf
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
57e1d0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
72ede2
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
884e8e
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
886903
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
447168
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c32064
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
291c6d
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] llvm::Regist=
erBank::RegisterBank(unsigned int, char const*, unsigned int, unsigned int =
const*, unsigned int)
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c73672
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
98c9dc
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
98b52a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9a6b7c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
444673
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446ceb
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d064ae
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d216f0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
977d54
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
977cb8
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c89cf0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9cc063
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
33e346
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445db9
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4d3498
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4e232b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4e1cab
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4d34c3
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9f655a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91383a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4a1c82
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
26acc2
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2ec7c7
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2ec18f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9cbbc2
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c7e141
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
859e33
     0.01%     0.00%  perf     perf                        [.] _sub_D_00099=
_0
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
261fbb
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
369234
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] llvm::String=
MapImpl::LookupBucketFor(llvm::StringRef)
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
772259
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
27cc83
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca2=
474380
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c3567a
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
2909d2
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
686b90
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8701fb
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] timekeeping_=
advance
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4e2f5e
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9ca31d
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] native_flush=
_tlb_one_user
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
59e997
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
59ee10
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2f337f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2f2be2
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2f3782
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
2c4988
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] mas_alloc_no=
des
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c34aca
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
28edd0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8408b0
     0.01%     0.01%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
0092e0
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d10eb9
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9ccb15
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
857ab4
     0.01%     0.01%  perf     libc.so.6                   [.] 0x0000000000=
153290
     0.01%     0.00%  perf     perf                        [.] _sub_D_00099=
_0
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] __mod_zone_p=
age_state
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
57e240
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e0c50
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:InitTlsSize()
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:GetLibcVersion(int*, int*, int*)
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __intercepto=
r_confstr.part.0
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
27a0ca
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
351eaa
     0.01%     0.00%  perf     libnuma.so.1.0.0            [.] 0x00007f0ca0=
27ec71
     0.01%     0.00%  perf     libc.so.6                   [.] fclose
     0.01%     0.00%  perf     libc.so.6                   [.] _IO_file_clo=
se_it
     0.01%     0.00%  perf     libc.so.6                   [.] _IO_file_clo=
se
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9cafc9
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e1f81
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9cb058
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e2559
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
27b3ac
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca2=
3623b0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91dd94
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8136ce
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8067f4
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445944
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c6e9b8
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c739ad
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5d59a9
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
2c4537
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
911c92
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9cc068
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
a90ed1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c45ad4
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c44d44
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9cc131
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
99011d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
98a673
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
963476
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
960445
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
a8faf5
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9cae2c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
887c96
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3ba8c5
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9ccba2
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4d34c9
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
269126
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
918104
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
928910
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] rcu_segcblis=
t_get_seglen
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
49fbed
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4a919f
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] seq_pad
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
a90acc
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9ca760
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44714d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c73675
     0.01%     0.00%  perf     libnuma.so.1.0.0            [.] 0x00007f0ca0=
27eb28
     0.01%     0.00%  perf     libc.so.6                   [.] __sysconf
     0.01%     0.00%  perf     libc.so.6                   [.] get_nprocs_c=
onf
     0.01%     0.00%  perf     libc.so.6                   [.] 0x00007f0ca7=
7cdfdb
     0.01%     0.00%  perf     libc.so.6                   [.] __open64_noc=
ancel
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] show_map_vma
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
a90a2e
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] seq_putc
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9c9e6a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
911b6b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9cc07a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
785b4f
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
26365c
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
5a92e0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2ec5d7
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dc53b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c46d97
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c43862
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e1f13
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e164f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445db0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445f55
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91d7cb
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c73593
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9f5e48
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
86fe10
     0.01%     0.00%  perf     libnuma.so.1.0.0            [.] 0x00007f0ca0=
27ea8c
     0.01%     0.00%  perf     libnuma.so.1.0.0            [.] numa_node_si=
ze64
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4a1c69
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffffc0=
e44cb6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446cb7
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] seq_write
     0.01%     0.00%  perf     libc.so.6                   [.] _IO_file_und=
erflow
     0.01%     0.00%  perf     libc.so.6                   [.] _IO_file_rea=
d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
a9e331
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
aad136
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
aab006
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9ca495
     0.01%     0.00%  perf     libz3.so.4                  [.] 0x00007f0c9d=
d57a9b
     0.01%     0.00%  perf     libstdc++.so.6.0.30         [.] std::ios_bas=
e::Init::Init()
     0.01%     0.00%  perf     libstdc++.so.6.0.30         [.] std::locale:=
:locale()
     0.01%     0.00%  perf     libstdc++.so.6.0.30         [.] 0x00007f0ca0=
42eb4f
     0.01%     0.00%  perf     libstdc++.so.6.0.30         [.] std::locale:=
:_Impl::_Impl(unsigned long)
     0.01%     0.00%  perf     libstdc++.so.6.0.30         [.] std::ctype<w=
char_t>::_M_initialize_ctype()
     0.01%     0.00%  perf     libc.so.6                   [.] __wctype_l
     0.01%     0.00%  perf     libc.so.6                   [.] strlen@plt
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e14ec
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c49c73
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e151b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445e1f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e1193
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] __list_add_v=
alid_or_report
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c39066
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c39fe9
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
889619
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91d2f7
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5095b9
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c89c8f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44a96a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91de9c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
396460
     0.01%     0.00%  perf     libnuma.so.1.0.0            [.] 0x00007f0ca0=
27e980
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dcb48
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:Symbolizer::GetOrInit()
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:Symbolizer::PlatformInit()
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:LibbacktraceSymbolizer::get(__sanitizer::LowLevelAllocator*)
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
859bac
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
805ed6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
805a2c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446285
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4463a9
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4461ca
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:StackDepotNode::store(unsigned int, __sanitizer::StackTrace const&, unsign=
ed long long)
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3a52db
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffffc0=
e44b2e
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
267a67
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
83c510
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445ed4
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c73524
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
915af0
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] mas_wr_node_=
store
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c38ff8
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445e36
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e15fd
     0.01%     0.00%  perf     libz.so.1.2.13              [.] 0x00007f0ca8=
553000
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e2561
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4a1c5d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
48d046
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3df478
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4461c7
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
278100
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91d3e8
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e19b1
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e140e
     0.01%     0.01%  perf     libasan.so.8.0.0            [.] __asan::Stop=
InitOrderChecking()
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] AtCxaAtexit(=
void*)
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44556d
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca1=
266a29
     0.01%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] 0x00007f0c9d=
902817
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
cfee9a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7650a3
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e0ca5
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e2044
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8da9db
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] llvm::Regex:=
:~Regex()
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c34571
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c6e9b0
     0.01%     0.00%  perf     libz3.so.4                  [.] 0x00007f0c9d=
d617a2
     0.01%     0.00%  perf     libz3.so.4                  [.] __cxa_finali=
ze@plt
     0.01%     0.00%  perf     libglib-2.0.so.0.7400.6     [.] 0x00007f0c9d=
9109af
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __intercepto=
r_posix_memalign
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __asan::asan=
_posix_memalign(void**, unsigned long, unsigned long, __sanitizer::Buffered=
StackTrace*)
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
83b70b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91d281
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2ef75b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4a1c83
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4d3480
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81f0cd
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81f53c
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
840ed5
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] 0x00007f0ca2=
824e57
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
793aef
     0.01%     0.01%  perf     [kernel.kallsyms]           [k] kmem_cache_a=
lloc_noprof
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
887ee2
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4d34c6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
819b04
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
86c88d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
39646e
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4a1c17
     0.01%     0.00%  perf     libLLVM-14.so.1             [.] std::_Rb_tre=
e<unsigned int, std::pair<unsigned int const, std::__cxx11::basic_string<ch=
ar, std::char_traits<char>, std::allocator<char> > >, std::_Select1st<std::=
pair<unsigned int const, std::__cxx11::basic_string<char, std::char_traits<=
char>, std::allocator<char> > > >, std::less<unsigned int>, std::allocator<=
std::pair<unsigned int const, std::__cxx11::basic_string<char, std::char_tr=
aits<char>, std::allocator<char> > > > >::_M_erase(std::_Rb_tree_node<std::=
pair<unsigned int const, std::__cxx11::basic_string<char, std::char_traits<=
char>, std::allocator<char> > > >*)
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e1596
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
6570f3
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e1551
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dcc5a
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e0f11
     0.01%     0.00%  perf     perf                        [.] _sub_D_00099=
_0
     0.01%     0.00%  perf     libstdc++.so.6.0.30         [.] 0x00007f0ca0=
418ac0
     0.01%     0.01%  perf     libasan.so.8.0.0            [.] __lsan::Lsan=
Metadata::LsanMetadata(unsigned long)
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
44615f
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
8dcb7b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
446beb
     0.01%     0.00%  perf     libasan.so.8.0.0            [.] __sanitizer:=
:ThreadSuspender::SuspendThread(unsigned long long)
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3526f2
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
352519
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
351a50
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c7b4c5
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c7a836
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3c7711
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3ee287
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3ed6af
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3ecbff
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4a5ddf
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff82=
c3567e
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
3964a8
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2780e2
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
91cd0b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9134ab
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e1610
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d0366f
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d0692f
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d230c0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
57e1c8
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d1d4a0
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
77367b
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
50953d
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
50901b
     0.01%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d0fbc8
     0.01%     0.00%  perf     libc.so.6                   [.] __memcpy_chk
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
a5c0ff
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
a58ca8
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
805888
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
4d348b
     0.01%     0.01%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
008ded
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
857c7a
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
a5ac25
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff82=
c68c20
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
447102
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
445e10
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
77044e
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
4a5ca6
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
4979f6
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
5161c1
     0.01%     0.01%  perf     ld-linux-x86-64.so.2        [.] 0x0000000000=
008e0f
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
73d0ff
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
393ac9
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
793848
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
793124
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7910a4
     0.01%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e1f67
     0.01%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
a5ab94
     0.00%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
a5b6d8
     0.00%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
979f20
     0.00%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
57e1a3
     0.00%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d0efc0
     0.00%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d05e33
     0.00%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d219b0
     0.00%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
96a5a3
     0.00%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
775a99
     0.00%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9b054f
     0.00%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
9b6ff4
     0.00%     0.00%  perf     ld-linux-x86-64.so.2        [.] 0x00007f0ca8=
d088b2
     0.00%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7735d3
     0.00%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
7710ab
     0.00%     0.00%  perf     [kernel.kallsyms]           [k] mas_wr_store=
_entry
     0.00%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
82cd7f
     0.00%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
85a312
     0.00%     0.00%  perf     [unknown]                   [k] 0xffffffff82=
c48147
     0.00%     0.00%  perf     libm.so.6                   [.] __exp_finite
     0.00%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
82ccc7
     0.00%     0.00%  perf     libm.so.6                   [.] cosf32
     0.00%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
82cce1
     0.00%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
833695
     0.00%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
81f293
     0.00%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
2e2037
     0.00%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
446bbe
     0.00%     0.00%  perf     [unknown]                   [.] 0xffffffff81=
48d097
     0.00%     0.00%  perf     [unknown]                   [k] 0xffffffff81=
57e180


#
# (Tip: To analyze particular parallelism levels, try: perf report --latenc=
y --parallelism=3D32-64)
#
LBR callgraph [Failed in perf report]
LBR any branch test
[ perf record: Woken up 27 times to write data ]
[ perf record: Captured and wrote 7.222 MB /tmp/__perf_test.perf.data.Ew2Rs=
 (9254 samples) ]
LBR any branch test: 9254 samples
LBR any branch test [Success]
LBR any call test
[ perf record: Woken up 28 times to write data ]
[ perf record: Captured and wrote 7.071 MB /tmp/__perf_test.perf.data.Ew2Rs=
 (9295 samples) ]
LBR any call test: 9295 samples
LBR any call test [Success]
LBR any ret test
[ perf record: Woken up 28 times to write data ]
[ perf record: Captured and wrote 7.242 MB /tmp/__perf_test.perf.data.Ew2Rs=
 (9284 samples) ]
LBR any ret test: 9284 samples
LBR any ret test [Success]
LBR any indirect call test
[ perf record: Woken up 28 times to write data ]
[ perf record: Captured and wrote 7.251 MB /tmp/__perf_test.perf.data.Ew2Rs=
 (9323 samples) ]
LBR any indirect call test: 9323 samples
LBR any indirect call test [Success]
LBR any indirect jump test
[ perf record: Woken up 16 times to write data ]
[ perf record: Captured and wrote 3.881 MB /tmp/__perf_test.perf.data.Ew2Rs=
 (9333 samples) ]
LBR any indirect jump test: 9330 samples
LBR any indirect jump test [Success]
LBR direct calls test
[ perf record: Woken up 28 times to write data ]
[ perf record: Captured and wrote 7.273 MB /tmp/__perf_test.perf.data.Ew2Rs=
 (9321 samples) ]
LBR direct calls test: 9321 samples
LBR direct calls test [Success]
LBR any indirect user call test
[ perf record: Woken up 5 times to write data ]
[ perf record: Captured and wrote 1.612 MB /tmp/__perf_test.perf.data.Ew2Rs=
 (9329 samples) ]
LBR any indirect user call test: 9327 samples
LBR any indirect user call test [Success]
LBR system wide any branch test
[ perf record: Woken up 36 times to write data ]
[ perf record: Captured and wrote 9.256 MB /tmp/__perf_test.perf.data.Ew2Rs=
 (11508 samples) ]
LBR system wide any branch test: 11508 samples
LBR system wide any branch test [Success]
LBR system wide any call test
[ perf record: Woken up 30 times to write data ]
[ perf record: Captured and wrote 8.249 MB /tmp/__perf_test.perf.data.Ew2Rs=
 (10518 samples) ]
LBR system wide any call test: 10518 samples
LBR system wide any call test [Success]
LBR parallel any branch test
LBR parallel any call test
LBR parallel any indirect call test
LBR parallel any ret test
LBR parallel any indirect jump test
LBR parallel direct calls test
LBR parallel any indirect user call test
LBR parallel system wide any call test
LBR parallel system wide any branch test
[ perf record: Woken up 11 times to write data ]
[ perf record: Woken up 7 times to write data ]
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.685 MB /tmp/__perf_test.perf.data.iw4R6=
 (3423 samples) ]
[ perf record: Woken up 11 times to write data ]
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 1.764 MB /tmp/__perf_test.perf.data.yA2qa=
 (2314 samples) ]
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.166 MB /tmp/__perf_test.perf.data.zAGlH=
 (328 samples) ]
[ perf record: Woken up 68 times to write data ]
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.956 MB /tmp/__perf_test.perf.data.KLoMh=
 (3833 samples) ]
[ perf record: Captured and wrote 0.089 MB /tmp/__perf_test.perf.data.c5IOX=
 (88 samples) ]
[ perf record: Captured and wrote 0.243 MB /tmp/__perf_test.perf.data.Kn2vw=
 (378 samples) ]
[ perf record: Woken up 29 times to write data ]
[ perf record: Captured and wrote 0.020 MB /tmp/__perf_test.perf.data.E6jzz=
 ]
[ perf record: Captured and wrote 9.431 MB /tmp/__perf_test.perf.data.cLMLE=
 (37112 samples) ]
[ perf record: Captured and wrote 19.263 MB /tmp/__perf_test.perf.data.Epb7=
U (38475 samples) ]
LBR parallel direct calls test: 88 samples
LBR parallel direct calls test [Success]
LBR parallel any indirect user call test: 328 samples
LBR parallel any indirect user call test [Success]
LBR parallel any indirect jump test: 378 samples
LBR parallel any indirect jump test [Success]
LBR parallel any indirect call test: 2314 samples
LBR parallel any indirect call test [Success]
LBR parallel any branch test: 3423 samples
LBR parallel any branch test [Success]
LBR parallel any call test: 3832 samples
LBR parallel any call test [Success]
LBR parallel system wide any branch test: 37112 samples
LBR parallel system wide any branch test [Success]
LBR parallel system wide any call test: 38475 samples
LBR parallel system wide any call test [Success]
---- end(-1) ----
126: perf record LBR tests                                           : FAIL=
ED!
2025-06-12 08:40:24 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 127 -v
127: perf record offcpu profiling tests                              : Runn=
ing (1 active)
127: perf record offcpu profiling tests                              : Skip
2025-06-12 08:40:25 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 128 -v
128: perf all PMU test                                               : Runn=
ing (1 active)
128: perf all PMU test                                               : Ok
2025-06-12 08:44:17 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 129 -v
129: perf stat --bpf-counters test                                   : Runn=
ing (1 active)
129: perf stat --bpf-counters test                                   : Skip
2025-06-12 08:44:18 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 130 -v
130: Check Arm CoreSight trace data recording and synthesized samples: Runn=
ing (1 active)
130: Check Arm CoreSight trace data recording and synthesized samples: Skip
2025-06-12 08:44:19 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 131 -v
131: Check Arm CoreSight disassembly script completes without errors : Runn=
ing (1 active)
131: Check Arm CoreSight disassembly script completes without errors : Skip
2025-06-12 08:44:20 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 132 -v
132: Check Arm SPE trace data recording and synthesized samples      : Runn=
ing (1 active)
132: Check Arm SPE trace data recording and synthesized samples      : Skip
2025-06-12 08:44:21 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 133 -v
133: Test data symbol                                                : Runn=
ing (1 active)
133: Test data symbol                                                : Ok
2025-06-12 08:44:28 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 134 -v
134: Miscellaneous Intel PT testing                                  : Runn=
ing (1 active)
--- start ---
test child forked, pid 17014
--- Test system-wide sideband ---
Checking for CPU-wide recording on CPU 0
OK
Checking for CPU-wide recording on CPU 1
OK
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.355 MB /tmp/perf-test-intel-pt-sh.Rep2h=
wPgdL/test-perf.data ]
OK
--- Test per-thread recording ---
Workload PIDs are 17061 and 17062
perf PID is 17073
Waiting for "perf record has started" message
OK
pid 17061 cpu -1 fd 13 : sys_perf_event_open: pid 17061  cpu -1  group_fd -=
1  flags 0x8 =3D 13
pid 17064 cpu -1 fd 14 : sys_perf_event_open: pid 17064  cpu -1  group_fd -=
1  flags 0x8 =3D 14
pid 17062 cpu -1 fd 15 : sys_perf_event_open: pid 17062  cpu -1  group_fd -=
1  flags 0x8 =3D 15
pid 17065 cpu -1 fd 16 : sys_perf_event_open: pid 17065  cpu -1  group_fd -=
1  flags 0x8 =3D 16
pid 17061 cpu -1 fd 17 : sys_perf_event_open: pid 17061  cpu -1  group_fd -=
1  flags 0x8 =3D 17
pid 17064 cpu -1 fd 18 : sys_perf_event_open: pid 17064  cpu -1  group_fd -=
1  flags 0x8 =3D 18
pid 17062 cpu -1 fd 19 : sys_perf_event_open: pid 17062  cpu -1  group_fd -=
1  flags 0x8 =3D 19
pid 17065 cpu -1 fd 20 : sys_perf_event_open: pid 17065  cpu -1  group_fd -=
1  flags 0x8 =3D 20
fd 13 : idx 0: mmapping fd 13
fd 17 fd_to 13 : idx 0: set output fd 17 -> 13
fd 14 : idx 1: mmapping fd 14
fd 18 fd_to 14 : idx 1: set output fd 18 -> 14
fd 15 : idx 2: mmapping fd 15
fd 19 fd_to 15 : idx 2: set output fd 19 -> 15
fd 16 : idx 3: mmapping fd 16
fd 20 fd_to 16 : idx 3: set output fd 20 -> 16
Checking 8 fds
OK
--- Test per-thread (incl. kernel) recording ---
Workload PIDs are 17286 and 17287
perf PID is 17298
Waiting for "perf record has started" message
OK
pid 17286 cpu -1 fd 13 : sys_perf_event_open: pid 17286  cpu -1  group_fd -=
1  flags 0x8 =3D 13
pid 17290 cpu -1 fd 14 : sys_perf_event_open: pid 17290  cpu -1  group_fd -=
1  flags 0x8 =3D 14
pid 17287 cpu -1 fd 15 : sys_perf_event_open: pid 17287  cpu -1  group_fd -=
1  flags 0x8 =3D 15
pid 17289 cpu -1 fd 16 : sys_perf_event_open: pid 17289  cpu -1  group_fd -=
1  flags 0x8 =3D 16
pid 17286 cpu -1 fd 17 : sys_perf_event_open: pid 17286  cpu -1  group_fd -=
1  flags 0x8 =3D 17
pid 17290 cpu -1 fd 18 : sys_perf_event_open: pid 17290  cpu -1  group_fd -=
1  flags 0x8 =3D 18
pid 17287 cpu -1 fd 19 : sys_perf_event_open: pid 17287  cpu -1  group_fd -=
1  flags 0x8 =3D 19
pid 17289 cpu -1 fd 20 : sys_perf_event_open: pid 17289  cpu -1  group_fd -=
1  flags 0x8 =3D 20
pid -1 cpu 0 fd 21 : sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags=
 0x8 =3D 21
pid -1 cpu 1 fd 22 : sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags=
 0x8 =3D 22
pid -1 cpu 2 fd 23 : sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags=
 0x8 =3D 23
pid -1 cpu 3 fd 24 : sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags=
 0x8 =3D 24
pid -1 cpu 4 fd 25 : sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags=
 0x8 =3D 25
pid -1 cpu 5 fd 26 : sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags=
 0x8 =3D 26
pid -1 cpu 6 fd 27 : sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags=
 0x8 =3D 27
pid -1 cpu 7 fd 28 : sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags=
 0x8 =3D 28
fd 13 : idx 0: mmapping fd 13
fd 17 fd_to 13 : idx 0: set output fd 17 -> 13
fd 14 : idx 1: mmapping fd 14
fd 18 fd_to 14 : idx 1: set output fd 18 -> 14
fd 15 : idx 2: mmapping fd 15
fd 19 fd_to 15 : idx 2: set output fd 19 -> 15
fd 16 : idx 3: mmapping fd 16
fd 20 fd_to 16 : idx 3: set output fd 20 -> 16
fd 21 : idx 4: mmapping fd 21
fd 22 : idx 5: mmapping fd 22
fd 23 : idx 6: mmapping fd 23
fd 24 : idx 7: mmapping fd 24
fd 25 : idx 8: mmapping fd 25
fd 26 : idx 9: mmapping fd 26
fd 27 : idx 10: mmapping fd 27
fd 28 : idx 11: mmapping fd 28
Checking 16 fds
OK
--- Test tracing self-modifying code that uses jitdump ---
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.033 MB /tmp/perf-test-intel-pt-sh.Rep2h=
wPgdL/tmp-perf.data ]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D17532=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 20136 byte(s) in 3 object(s) allocated from:
    #0 0x7fee2df363b7 in __interceptor_calloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:77
    #1 0x7fee2dd68743  (/lib/x86_64-linux-gnu/libelf.so.1+0x3743)

Indirect leak of 5952 byte(s) in 3 object(s) allocated from:
    #0 0x7fee2df369cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7fee2dd6f9f0  (/lib/x86_64-linux-gnu/libelf.so.1+0xa9f0)

Indirect leak of 1388 byte(s) in 3 object(s) allocated from:
    #0 0x7fee2df369cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7fee2dd70812  (/lib/x86_64-linux-gnu/libelf.so.1+0xb812)

SUMMARY: AddressSanitizer: 27476 byte(s) leaked in 9 allocation(s).

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D17539=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 20136 byte(s) in 3 object(s) allocated from:
    #0 0x7fd861fb23b7 in __interceptor_calloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:77
    #1 0x7fd861de4743  (/lib/x86_64-linux-gnu/libelf.so.1+0x3743)

Indirect leak of 5952 byte(s) in 3 object(s) allocated from:
    #0 0x7fd861fb29cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7fd861deb9f0  (/lib/x86_64-linux-gnu/libelf.so.1+0xa9f0)

Indirect leak of 1388 byte(s) in 3 object(s) allocated from:
    #0 0x7fd861fb29cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7fd861dec812  (/lib/x86_64-linux-gnu/libelf.so.1+0xb812)

SUMMARY: AddressSanitizer: 27476 byte(s) leaked in 9 allocation(s).
/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-609a86901e6fd886f1139aed8f8c66d=
982f2afed/tools/perf
OK
--- Test with MTC and TSC disabled ---
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.031 MB /tmp/perf-test-intel-pt-sh.Rep2h=
wPgdL/test-perf.data ]
OK
--- Test with branches disabled ---
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.035 MB /tmp/perf-test-intel-pt-sh.Rep2h=
wPgdL/test-perf.data ]
OK
--- Test with/without CYC ---
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.138 MB /tmp/perf-test-intel-pt-sh.Rep2h=
wPgdL/test-perf.data ]
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.081 MB /tmp/perf-test-intel-pt-sh.Rep2h=
wPgdL/test-perf.data ]
OK
--- Test recording with sample mode ---
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.003 MB /tmp/perf-test-intel-pt-sh.Rep2h=
wPgdL/test-perf.data ]
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.001 MB /tmp/perf-test-intel-pt-sh.Rep2h=
wPgdL/test-perf.data ]
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.003 MB /tmp/perf-test-intel-pt-sh.Rep2h=
wPgdL/test-perf.data ]
OK
--- Test with kernel trace ---
Linux
[ perf record: Woken up 11 times to write data ]
[ perf record: Captured and wrote 1.414 MB /tmp/perf-test-intel-pt-sh.Rep2h=
wPgdL/test-perf.data ]
OK
--- Test virtual LBR ---
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.019 MB /tmp/perf-test-intel-pt-sh.Rep2h=
wPgdL/test-perf.data ]
OK
--- Test power events ---
SKIP: power_event_trace is not supported
--- Test with TNT packets disabled  ---
SKIP: tnt_disable is not supported
--- Test with event_trace ---
SKIP: event_trace is not supported
--- Test with pipe mode ---
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.082 MB - ]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D17677=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 25336 byte(s) in 3 object(s) allocated from:
    #0 0x7fa5dbda93b7 in __interceptor_calloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:77
    #1 0x7fa5dbbdb743  (/lib/x86_64-linux-gnu/libelf.so.1+0x3743)

Indirect leak of 7552 byte(s) in 3 object(s) allocated from:
    #0 0x7fa5dbda99cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7fa5dbbe29f0  (/lib/x86_64-linux-gnu/libelf.so.1+0xa9f0)

Indirect leak of 1577 byte(s) in 3 object(s) allocated from:
    #0 0x7fa5dbda99cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7fa5dbbe3812  (/lib/x86_64-linux-gnu/libelf.so.1+0xb812)

SUMMARY: AddressSanitizer: 34465 byte(s) leaked in 9 allocation(s).
perf record + report failed with pipe mode
--- Test with pause / resume ---
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.002 MB /tmp/perf-test-intel-pt-sh.Rep2h=
wPgdL/test-perf.data ]
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.061 MB /tmp/perf-test-intel-pt-sh.Rep2h=
wPgdL/test-perf.data ]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D17706=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 25336 byte(s) in 3 object(s) allocated from:
    #0 0x7f7f4db4f3b7 in __interceptor_calloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:77
    #1 0x7f7f4d981743  (/lib/x86_64-linux-gnu/libelf.so.1+0x3743)

Indirect leak of 7552 byte(s) in 3 object(s) allocated from:
    #0 0x7f7f4db4f9cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7f7f4d9889f0  (/lib/x86_64-linux-gnu/libelf.so.1+0xa9f0)

Indirect leak of 1577 byte(s) in 3 object(s) allocated from:
    #0 0x7f7f4db4f9cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7f7f4d989812  (/lib/x86_64-linux-gnu/libelf.so.1+0xb812)

SUMMARY: AddressSanitizer: 34465 byte(s) leaked in 9 allocation(s).
OK
--- Cleaning up ---
--- Done ---
---- end(-1) ----
134: Miscellaneous Intel PT testing                                  : FAIL=
ED!
2025-06-12 08:45:11 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 135 -v
135: test Intel TPEBS counting mode                                  : Runn=
ing (1 active)
135: test Intel TPEBS counting mode                                  : Ok
2025-06-12 08:45:19 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 136 -v
136: perf script task-analyzer tests                                 : Runn=
ing (1 active)
136: perf script task-analyzer tests                                 : Ok
2025-06-12 08:45:39 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 137 -v
137: Check open filename arg using perf trace + vfs_getname          : Runn=
ing (1 active)
137: Check open filename arg using perf trace + vfs_getname          : Skip
2025-06-12 08:45:50 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-609a86901e=
6fd886f1139aed8f8c66d982f2afed/tools/perf/perf test 138 -v
138: perf trace summary                                              : Runn=
ing (1 active)
--- start ---
test child forked, pid 17961
testing: perf trace -s -- true
testing: perf trace -S -- true
testing: perf trace -s --summary-mode=3Dthread -- true
testing: perf trace -S --summary-mode=3Dtotal -- true
testing: perf trace -as --summary-mode=3Dthread --no-bpf-summary -- true
testing: perf trace -as --summary-mode=3Dtotal --no-bpf-summary -- true
testing: perf trace -as --summary-mode=3Dthread --bpf-summary -- true
Error: perf trace -as --summary-mode=3Dthread --bpf-summary failed unexpect=
edly
---- end(-1) ----
138: perf trace summary                                              : FAIL=
ED!



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250613/202506131634.ef8ef10b-lkp@=
intel.com



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

