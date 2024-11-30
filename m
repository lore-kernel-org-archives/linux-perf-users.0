Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D411813F43B;
	Sat, 30 Nov 2024 07:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732950206; cv=fail; b=g0e2GkIsKRzGNJhUcxcsuz9OycD37QJw24JSbpgjpBm9dSZEpfjZRgUm3KIhtUT46vVc9C/PuuhJgOwaNto+gTztVT8u/N3ccozXlVOpAY9DtlJZJBzVAVX0gbKv3mzGFFgaNRugJMfJ473eLYq67DGLvTc+piEW/8UeAVYCmuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732950206; c=relaxed/simple;
	bh=+TqHRoheY9DsfMCcHELVgB/1+CRpg++9SH3zZzld9sc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ct2qgjKwPCWZPMWD7Z2FIlTMMgSHw0ndaHG7BjzKM+lOGvZ3ubNrOdbUK4pl/BnUXXQDqvDkNM7oRVg6hqWxqzfFZq+AyspRJ7N1C94cw4v0+2RlITMRrHbS6hBWQMkUWUqCwf2NU1pwpITzsjX6TNGKSX/DgQ+ggwMlQqw91/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z6xY00Sp; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z6xY00Sp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732950205; x=1764486205;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+TqHRoheY9DsfMCcHELVgB/1+CRpg++9SH3zZzld9sc=;
  b=Z6xY00SpsVeiWZmkl7H7c8KtR7WvgdtbQwELXJZ6RYJFBlylg4pKk6Vd
   sBT9dQU4ACGgKutiF/jhdnjMeoHbxDnvx8yMUDE+mF2DG7xrqy1wKYtcB
   f23DwAqMvaurEBRlKh2bYLgN5LlBDAH0ZdremVnMtx4eXbl216dXnAMPw
   MDkSHUgPqXpLycdPx2gaa0FhhHH5pNHUIWKN1bfRsmzxkm/7RKLeyOAXx
   AOyoUZe/GT+cUIIOIhr0x8y/ofWVAZGiPtEgRc/XOgshMj/cmFovDBPKR
   VZvwW0f1rQjgNhJGcg976zU509jEgL062edr5zob5M4OVeTYiIatebTxM
   w==;
X-CSE-ConnectionGUID: t74hPFWXTzuuCUe25p0VUw==
X-CSE-MsgGUID: jnuXK5QiSpiOVvhWJfGZXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11271"; a="33299331"
X-IronPort-AV: E=Sophos;i="6.12,198,1728975600"; 
   d="scan'208";a="33299331"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 23:03:24 -0800
X-CSE-ConnectionGUID: CYKv0KJxTxCqKXjA77GGxg==
X-CSE-MsgGUID: idRY3QKpTfKCaGGQblFLRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,198,1728975600"; 
   d="scan'208";a="92964599"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Nov 2024 23:03:24 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 29 Nov 2024 23:03:23 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 29 Nov 2024 23:03:23 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 29 Nov 2024 23:03:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofeBcsmBUCTqu9/U2v3WoFco1Lk3nqyuc68JD4lQ4dO50XY9tTUCn8Be8JHiBGnkQz0FARwODch9ynh9MoQfC4wH5+v7+/Z6hMkgONDZDidFN2sarG5SOfpTFb36qs2C43ZEkjN2HwiEkIK3nqzP0Pu+rFu2u5X6FHbzu8HuaygRv35e1HAKRIkYzHAScTIsw6TCVMgmEYy1M9r8Lw+1eMOEZ2Hip428fE3Z+UC/gD+DG+FkdDIEuIdFqz4v7JerNGBprKSC2LhafCJQ4FhCx/Vtd3i94MeXIDFfHnmmRiiMD8FtDQOu+3XnIUvdt6VLji+LlrUPNl85MCObN6z6Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6eTbZtIDTMpWsAIm6nOiWar4d/Pa+Fqi42J6j/0D4h8=;
 b=cKjpIJnmra8q1E1lZnnrSm0BPobUqKvgi1yY1d5hJ+G69bJaPqNA8i/sDKqR/HAdHxeObfeDX2Jgnm79Ia1Mb1CD06LT+GzoJH7N1ux9EkmZVfEVrN9nFG/hQOSe5RuPldtTGYiKp5MM7tDvZpRKUkBV1LY2tGaeGpYj8GoiN9ILucP35y/7JxDkzIevkE6AfLLzpO9NQHuco2PRTx5y6YqTqhrqsAAYWvKEatnLTOldTSGITdOSrxJEm8fpDZ8v7cil57GTNYOwqXJ3L3ggiAM0ReWvgqAsLYiQhKxAYHiio64W34juLJBWCmZeeNXbGXHISD9uE/W68FLY1ClAiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB7445.namprd11.prod.outlook.com (2603:10b6:510:26e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Sat, 30 Nov
 2024 07:03:21 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8207.014; Sat, 30 Nov 2024
 07:03:21 +0000
Date: Sat, 30 Nov 2024 15:03:10 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	James Clark <james.clark@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>,
	Atish Patra <atishp@atishpatra.org>, Mingwei Zhang <mizhang@google.com>,
	Kajol Jain <kjain@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
	Palmer Dabbelt <palmer@rivosinc.com>, <linux-perf-users@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [perf tools]  af954f76ee:
 perf-sanity-tests.Test_data_symbol.fail
Message-ID: <202411301431.799e5531-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGBP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::30)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c7e6e40-938f-484e-e829-08dd110d131a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Lg39d+iuinOFdnc2EXbQdebph1uPmVSdX4e7RZQdvMUR1Rngxu4riLDaY79s?=
 =?us-ascii?Q?82gysvU6DNtqQCZzifb+CkviBMIFw76vlrfLlqpAXrt5KZnOcppvGg4hmKiB?=
 =?us-ascii?Q?vQ6EbG8p6abu1luZVkuzZfXk3FJe+6/PbRP18BqHimZGaYG+QySnYIlp4n7k?=
 =?us-ascii?Q?v/Fmd4n/Cy/2fnsofUEVNYO3wYvjAIEdPqUCnruYlO63E/E0lbpuYtkQ1fFR?=
 =?us-ascii?Q?Wxa2+D0vWKj5Asd0xzqRe15w9wKiwJESW27d1qEPBhW/SNI3JDTimotvtXB5?=
 =?us-ascii?Q?4jCUUSWOR+rjtSyoYMw6sC5Ogc6oq7toF//jaeNIdi76rgg/qOCaj6ZJj8Kp?=
 =?us-ascii?Q?ZVYs2OJfw2h2L1NWIg8TzggsjMYtoTyaOwjpbduiMb+McrY/oyoz4y3SjcAO?=
 =?us-ascii?Q?1JYfrjiTZSwGyANazlVqdwEmZSIo/z4uwBG1a/mSuX0BqfjBrrj4F5ckdkBa?=
 =?us-ascii?Q?GZDba5bY5QU8A+0Jq4A6r3dIc+SsXW5E+PCUHCZADXQlufcU7iH7pXaPr3Es?=
 =?us-ascii?Q?suw86d1hcjFq/6nTEUD60HTf0pzgCBky51u/oWH8lpYENkuxzljP8vAZiSuI?=
 =?us-ascii?Q?SdgjsYmghxH8wbF4Z2XFHS3/l6HAWTKrh2+PxOGbO6sTFb+veWbXO7joMkTO?=
 =?us-ascii?Q?k1hFv4SJ8nHNBfrF9R1tGa+4YoqynJ/NUSEJYf4WavhQGM44vOsCAj01Mw0p?=
 =?us-ascii?Q?lTn4K6eL/NUAUCf8OT2M0EIGcs8O/+LHWp1kXXqK8mVLbL5IRISE7CE5B3va?=
 =?us-ascii?Q?cs7qDjlf0vlTwwK5A/3mhsBIN3rgpD/uIrE1t4VA/9xqQEVaeF9TpKWdMU4n?=
 =?us-ascii?Q?vjfIftf2m8i0TDKXP1UGmQ6amBnE5i9SGfW3MCNaqL6LGFBnymqBsJkRGrU1?=
 =?us-ascii?Q?tFGccCuEX+F/D6d5ZQ9BI1sYAakuMt9eMwNqvjW6Td8iG8CpGBuc6Lf0y6Ge?=
 =?us-ascii?Q?gC+hGaNIYWqWC6oeEPNz7aQWch0olIFGrovZyPmDRergxILUfudwxKK8Fp1N?=
 =?us-ascii?Q?MugV4je+xcsxnKQW6muimOvE5WpKRXEyUW09d61NzfmA8+lFicKMDG9/JMad?=
 =?us-ascii?Q?ySOF+qs/0EnTlCSLtIBiYSNXs+q1xyJYcOCvO1lEsXM6kuHj4BV+iTwL13fM?=
 =?us-ascii?Q?ifVVfXXCYdXSUaQT8YOCOKbvTfMjcCy7w7YO9FoJDol+2XqjzR3IZPzwdiPS?=
 =?us-ascii?Q?wWOiHaDu3t1CqMfYsKTc3pHYysCqnTLQkIevH4YXSVUehDvxJOZ7KfGktPF8?=
 =?us-ascii?Q?w/5Wx651Qw2QQdr7WnMorB5yl485enZwYQlQZcbMXua3lxnsmvRlxFewdKAU?=
 =?us-ascii?Q?v4RmNSVXo7f2fPcD4S/aX2+n?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W0yBbXHyKkFhfXLIBVKD7wkXyVZ/6X167gHLr6auak62q92ZkiRSLi3J5KpF?=
 =?us-ascii?Q?dlxRx54NF6Q/+ej4vs1HJ4HlNBuPISVFZxykPFisot4oSlzXo3QJhtDi5xL7?=
 =?us-ascii?Q?pmh6TIvDTJJ8Ah0sra9FG5Nhagytsfq48rtKroy/xiHOkMKdO0rvXfqnKiV/?=
 =?us-ascii?Q?5G4I5oWS9YUadrf38gYg50lX3VH6x70D78aeScEliyiejJsqG3n31QcKda9s?=
 =?us-ascii?Q?W0qGQp3t3Eum0irbYH5nwZhnhXZzBSknQMzo9fOXobB7GQ23CmFM9CsrDatG?=
 =?us-ascii?Q?D68EvsqtPJmgMjJVTjWzQ5W+3S2rrrYDqraSUNca6FHeQZZn+OdMC4LfcPbd?=
 =?us-ascii?Q?g+krSFSSZck5HVZ2RLKJLNAwH8VG7WVXw/W0xfE7vJ+YS3hfZLpkJ+36RVcu?=
 =?us-ascii?Q?K7IFgFrLHNcyIS4cKlaOIahjX/G9nTlwOrRt6rFB4sA7J8DB7zuQQaUonNe1?=
 =?us-ascii?Q?9sr1fyM8y03RblfVs5i0nHphJ7Ljk70QFL0zbemw5fybHSWQxJNkrYJtepuO?=
 =?us-ascii?Q?Vb8rEmOw2rdG9utPZD3tbhmAiMQAX7LfmT1AehF1d9nDt4ys6hlHe7XqfTnK?=
 =?us-ascii?Q?rixKuomdCHZGnxH85WpjObQ+1Hl/O9KFo64iCwKZJS7AA6OdBo90ldz/zoWq?=
 =?us-ascii?Q?/3gE5QwTBe9UjrpB8tQUMjNvIz0Oke6AY7TFeZbqG5TOefdzTxADN/QJC/Pe?=
 =?us-ascii?Q?xya8SXQSh8M3Zl3UG+4JKPIWw5zAe1o8lj+ZzjU/y1pAXNmzexQCixe3GBiE?=
 =?us-ascii?Q?09K6IlqyTgHEkqShR5WKGB21xk2uyZjXiB7Aeaxkm4Qle4IyuuKFeE5brYm6?=
 =?us-ascii?Q?fGyZr2LdHpLGLEn3T5e7qsRBwnb2agxgUOltn0iQRDaqfYfzWJtjYY6N6qfi?=
 =?us-ascii?Q?ZClB4q5knUZkvljnDiJ8g5kCRWEQpAvZWqR55QpuaXlcNjTpGcQI7K0ntp5x?=
 =?us-ascii?Q?N+Kry6ep6cHXangp9XZVLZw2MeoDqjea6FtDXv1QhwpWp90l4SLGFU1JAtgb?=
 =?us-ascii?Q?+i00G9mcP2TC7ZR/5ah/b+Wj16ud0cUPOLasEV8ZBujz/X8SRxl+X/qB9O8d?=
 =?us-ascii?Q?hrKrw4C41/y1ZqzhRrwbu742HaFk6TZDTcjb4N9Cw7rc3fJ1AZHj/GrPLf7d?=
 =?us-ascii?Q?C4k13uI+ZH2UR8fba4y+zbF5uIJzYjSAracr7L9rOdFdx0XiB4sCCve7nLYk?=
 =?us-ascii?Q?WhvAlSqiX/LWJUg2JD3+ZrpjRL/gw6g9+jl87R80loS1D/beN4wH8XYwi9VF?=
 =?us-ascii?Q?WCgLqu167RYBay2LOZKmw1xiONaLLgikEHLtTPcU1pU39Ju3tfsg5Kl+tVB2?=
 =?us-ascii?Q?eSd3N0fsqY9IH+Dm/h7Cw4DmJovdVcnYanQNTwKEonnIE4hBkw7HxLKI07Oc?=
 =?us-ascii?Q?dJf4rMDokD84S5uvY0GkJocqmBxsiCn3WK0iTMptH2a/29yPP7mxd0P1pwph?=
 =?us-ascii?Q?aF4mFWq0QDesQOiWJGXzirng21iUALwi3RRh6LE48k1dxHYukEYXbavK4ER+?=
 =?us-ascii?Q?bQoqL/xRPKidej/Tb2s0avshGRWmMJEDvOqqoMjZbapsVKwJJVEm8KwG+100?=
 =?us-ascii?Q?uy+FaI5jB/+NSo0wZJj1oXwTJ6pX3mmoPohdZ8KbWHrmTR66Z8i1rOr7V0YI?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7e6e40-938f-484e-e829-08dd110d131a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 07:03:21.0335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1b/LO2EG7nc+1iv7/g3o4DuP7a3JUnxp8zzQ1taRzwQ5O4qo80wNm01pvUTTOQV3DnWL/un+K9mDj4sXNHYu0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7445
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "perf-sanity-tests.Test_data_symbol.fail" on:

commit: af954f76eea56453713ae657f6812d4063f9bc57 ("perf tools: Check fallback error and order")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      7af08b57bcb9ebf78675c50069c54125c0a8b795]
[test failed on linux-next/master f486c8aa16b8172f63bddc70116a0c897a7f3f02]

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: gcc



config: x86_64-rhel-8.3-bpf
compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202411301431.799e5531-lkp@intel.com



2024-11-28 08:31:19 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-af954f76eea56453713ae657f6812d4063f9bc57/tools/perf/perf test 121
121: Test data symbol                                                : FAILED!



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241130/202411301431.799e5531-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

