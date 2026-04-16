Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C032238228C;
	Thu, 16 Apr 2026 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776327898; cv=fail; b=Ps67SLtjw1pTT4lRZhkDSrDtWjNzS7wQd6izCgXVFI40nxAGS2Nyo4tyGmW3xHGUsWQNFrLtevTDurvYCQsBb42UZSOPj5VVBFkuuxBL/6XF1SSBE+NgPW/xxDpZf82YOMEP2qAjBVDv1CrSnDiuP2lsCnK8OEsxP1iZtDhZekc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776327898; c=relaxed/simple;
	bh=AWIBs0TNbAkb4pGEiZsMTbqd8qF0CvVqyZFksJpmpEg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=KmFr7HJ6V0TdULOW3YR/jU2GeMBjr3YjrJIo5F/Sfg0UCY5I3WCu+grd1gDaNJ6OaGw8PrGBhjpcb7iINff/csJ6naeGr/PiLf3js9B7B0yRtacPLT3tB+gmPJoL042DTCCif6P1CEBLkc0fZ0iQ6BwZrdGqNQ3SmCG8nC8SCro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b77vknnC; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b77vknnC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776327897; x=1807863897;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AWIBs0TNbAkb4pGEiZsMTbqd8qF0CvVqyZFksJpmpEg=;
  b=b77vknnCgeN16Bha2zx12IOyF+1wqcrbbPjJN+ad+jg5NLxZLDcPLwfa
   1ym0uHfR7Qgda0OcmJDdT19Ixb7/fLg4QT7lLbjF0woxjhM7pxTi+mBuC
   k1Z5MGqcbuN4YQbJ/LUcbFeC2SJ+PgpDIDl2+whmo3who3yZUIHOqVuKX
   +Be3URJ05yNty/ONXdEOL7URRnwduDDKFQKllHu8c4IvdmN0u4QbS18L9
   6fA/PaWMqo2HVUGYQRRuuMhV2P00jV6u3Jc6CSOFIfKrNpEGWU7cuOeS6
   GYTTrJb2TylKLfoxYA6/GWwxHruNeuvBgJ8/f/CAetRojJnm4DXZ4T1Ni
   Q==;
X-CSE-ConnectionGUID: PnbeSY+fQmmuHPj/M/o/7g==
X-CSE-MsgGUID: pM4papqaQyGZZsjhLLLJRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77020826"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="77020826"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 01:24:57 -0700
X-CSE-ConnectionGUID: iZohLrWSSKGlU7H1BIRW6Q==
X-CSE-MsgGUID: gEhduYuATGy4H/wlTI4y4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="230511811"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 01:24:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 01:24:56 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 16 Apr 2026 01:24:56 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.23) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 01:24:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nI97NZH1cPZYqaNghX8PcVo+Wm/UFwxGhVGJMFSDEHvt3owB+xdIav+iuTaTg/02A4w7TQ6taSF9knUgMeMAg2xAkNZneesKWP7HYXMBGZXHbvdy18ii2YwVCCC02QjT3iIJog9uao4LDf3kDY44/y53kDKMm1kS5OkZEHPrDEDDdHcBiYy6jyxIT8j/YTCtaFFlNBPdxaavTmhpOmcyQGjSVOqqvQ4fHlx9fk9xOTl2KpWVFs3FjAQ+a6RX/rG2a16SOFxYfRGSd9xB7ZzuoxaDmI1/a7PLlR7PTGfK0Wo3Sk9Acd4A+F/nbeukDfnbZ0ozj6vR1G+kBeaA3GmNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WJ6GlrVlLI8K1cOdFqclA9jgnXWUpO529eOSwBnKk4=;
 b=FJMzJODC66mUg7ocbNItHchvRl4GKz76KWX3YPUPWxXFvokRw7kzNpNeNpEPtX8PExDj+yWkBA0n2H1AKE8/aInA9LtLe5ZqNX9ET8SBiXTwVh0UDjMrRTMg7fi+rXkpcIPSHOhFI2JZivzUy0zY7o6qE9dGqcINTg6sTnV1YX2OWVZyFOCAeqluW/cil8pLQ3GUoUCH//QQZnHpdAs2tzGSwR4ZfsXrSCFaace6qu5+VfZw5/5kHX4HnrTJRXTZBSHcG1UMXYUniLV35qy0W3SjULjavBrkwdhYhSqTd0DOyibZD3Ytwsd3SP0Bydxkum7egSna+yM8jAXMPTXqhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by PH0PR11MB5080.namprd11.prod.outlook.com (2603:10b6:510:3f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.17; Thu, 16 Apr
 2026 08:24:46 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 08:24:46 +0000
Date: Thu, 16 Apr 2026 16:24:37 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Qinxin Xia <xiaqinxin@huawei.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [perf tools]  74e2dbe7be: RIP:cpuidle_enter_state
Message-ID: <202604161630.4fec10e1-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SG2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:3:17::32) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|PH0PR11MB5080:EE_
X-MS-Office365-Filtering-Correlation-Id: 689ee355-e077-460f-1e3d-08de9b919e0e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: yaIoqovWHzWs81rymFP/Pxjj2hUc2/VwCGOlqkbxPfdMf35EwEIKR5WG7uxvuCC8A/YMjUb16R2bDuz9JA3FRoWsRpgBdbEQDLxuGg3g4WIp86oh8hLNyLQfRlHLa2ehIRip5N9HFVKV6qegXFZdL9enYW1Mz+pc2ElfWgUlb95IA16BN4NhCvHO4CrGhARns3EJ03yhq7BEilsek+440E44a2tkQSmUBHgwTPP83MDgTstbaPyG68qSW0aH9BE2s+aAyvGbvHYYL1nfIsa2frGQ/6xY8xF1tsBmXYaZ/DEx6RddfXlqVUFQwuu1wcOS9jXxwLnRgfu9fJOstbIssGgcxC9rDrqydbT+MF5UIXbJvD2X4QWXvPzCaTn63RFpUfZiDdDPpjp+DWLVnlaJgZjkhjEqm4vAsOmDfpkGcC3c9Wne9bfid/f4dIaNPXcPgI85jqGb9YHm3ZrkHL63y+GZU98IU6SoWYQrNg6KC94SI/O0Sth5amqZsG0Swzx/ntDCTIZF3KKZ99S/hxbGvI17ZAxgQeIDMfzStzcvoduD98d0XUmV5FiY9qnn0XGLCTqPFuGzcUO+WT7xB+l8KKEH3vJFJwIZbVeiXTulYvmprAabqdgCIStxbQ106euh0+ugUYG+oMgUUb8KVXftsu5k96Obu9+0409tCg8AeYT69FjpYaNmNK/sY8vCuNsr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vc0Sn+bV9lEcUNz27HqYpFkNZMyLCY0nZ+JRFIs7yt5pMb5JZ4IkJw42yLlI?=
 =?us-ascii?Q?evs0LxWLTUl+8Vej3XA4TXuElY0KPmCTksTfM+O5zS1VmhpX0qOiYyUFhVtu?=
 =?us-ascii?Q?jfoUUqeg7NxMHas0XVCtP2VTV4PvxkbPokRelYLV46Db4B1qebHhknME5GwU?=
 =?us-ascii?Q?O5vrGmMU75/1rC8QdloULbrx/H5hmqkAArdC9D7ZZNAMc0i1z7zqfaaZjt9d?=
 =?us-ascii?Q?oh3Sc/o9U//PFfvcrx+zEXnf0rmNMi46d0s3xgRa+ATJXDmKs2nTFYb5By9O?=
 =?us-ascii?Q?/DxajlqNCUD5pyk632eV9CH+tbO7vMKEVddaqP9typt6xnzDGDqcov6k6fP1?=
 =?us-ascii?Q?7QkskkRh0V7tpHM0SZX4X165WhloFtrwUoy3krPSXIgeO1pdZX9gGwAh82U8?=
 =?us-ascii?Q?yw3zQM5mNTtDwEhQU2uR3saT5umf2qxCc4IuQ9UDX6mf68hhDkYoJItS8+z2?=
 =?us-ascii?Q?fc/ygpt2A7lpV1bzj6Otjv+eHYC3/DdQHsnvDQoXMjoyV3LnMzN5GT3+b2Yt?=
 =?us-ascii?Q?KvE5fFfcygC1R7EMN/iQI3b2DZZ353OtxZ5X7h3F3etR3P/PAwUw0SCAwQSD?=
 =?us-ascii?Q?FYHG2Ycs+N6zu8ufJDpn7wkASJNGQ+MAwlvBzpZrBYsoAnk3qhiTKK7uQkvw?=
 =?us-ascii?Q?b2oE04YI0eaoAVvH/+9vRaxebY2hDu39/ZDRl/w218Ruzf3jab+nLNbcHsMK?=
 =?us-ascii?Q?yXoAHr/o/cV19hJYws/jecM5Gnp9rFqAoR0pWklZlM36q8gXrv+jyC1KnIuV?=
 =?us-ascii?Q?SHbcOBsbxA2LBV2YTqO+qdNFQbqCvKQ0oyKe1zfWRwe4amzNCsLJdQmY2BOq?=
 =?us-ascii?Q?e3xVQy5OrcH9J4uyIG+ZGGDgsEWGBVzoX5pxHk9LpvADvDcqZE5dFCxREAzG?=
 =?us-ascii?Q?xlcLM8x8WlTogOeTlz3t/w54KjVO9AXh4W71OBesu2hyNOlMfk3kO3EbOtkL?=
 =?us-ascii?Q?D5ShuZGweZ9DSoAsWSA+3bnGrxt9uyUfeEex8tLB+uR/qQ0uV2kras6MLucK?=
 =?us-ascii?Q?X7PNnxjsvNQaQLj7yGEpsAbNhhNskA8FaLGXW8dXLUO/O8BRRTvUgk8bjbR7?=
 =?us-ascii?Q?sQaZMge/VRgAOBpPzwUwVqB7QFqHxt4CbhtF1XV04vRUv+/R6Ezlw+bZ+wtE?=
 =?us-ascii?Q?OPSRnfijY9/+o+metssUyQZzV6CinBX7nZpzd3ovSkSp1J29262iXTzaui2T?=
 =?us-ascii?Q?Fwe0BycnjcMBCwaxivCugnpDSJtWAOq+ejyhMU4pIr/BBFYuMpWTPFKBG8NS?=
 =?us-ascii?Q?oYYDZLdEvYGbSoy3VU3kwC8wrXcPY1w/t4S3FZ9tJZD2MqRrT5pttmRFm/DP?=
 =?us-ascii?Q?4vbHw3QD3tt0LfDqHK3HNunWR9wHOwwZHTIA0+jEdFF/Xu8wFzQW3beR5W8z?=
 =?us-ascii?Q?GNBQDGma/2yPmuviW+z7TJqaSU2dGSDtBmVocgCJhJEkhqSiM2S54jeHBfAx?=
 =?us-ascii?Q?9kqAIt1MZHEN/M9VEOp3V4G8H1lMLkeTM7EJAgZgcVcFKHuXnJn5BDYXq6r7?=
 =?us-ascii?Q?aO8A7QrW+6vTQR/qtAjyzY4jXCV6b2dZ0OVjzCKEHrYsDkfFodBVpiZq0F9L?=
 =?us-ascii?Q?am5IWLTvjZYRva/ZUt0PMBJpdpF6vFI3fml7l4RBQqZdgoQlfOijiUqM+m61?=
 =?us-ascii?Q?7oW2K/24nY69HXCvuIdSTOwvmJfFSC6CAgPVOagjclb8A2JscoEpfxDHGkCi?=
 =?us-ascii?Q?apQ1IU3TpFhyYTllNoZdN2VWFjNxEFIj/hO0nOYPGEieB0ahneUM18xyY4O+?=
 =?us-ascii?Q?78GNeTXoqA=3D=3D?=
X-Exchange-RoutingPolicyChecked: aJXLlX5Ti05gxwiKu/STsJaf8zX2AUhlo5xQDl8ELeL6FVblrKMBJoww9oss2r+LYvRj9NeIdXdpPr8ffloalde+F1QmdsDWb5L05p9oev09QAOc+KpSLngsP6/tDJo06N4vviQEEf41BsRBF00eLp9pkM7tsdsj0TbkKpDf63G8U0UBXllJZS5/mbaXAfBwQlv/3ErSNTFIhyRjqEQ074m5w1yAdLSHtTZ5dHkYldPOkev/2qDtNIzSOvjWBuC6JhHt2XJuEKQWRV8r8wp+49+uT5S34Hf3GTPEfTjFhfLA6uEgcLgaI3WIGut/sv63TpysPvl5+dcL63x6iRQglw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 689ee355-e077-460f-1e3d-08de9b919e0e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 08:24:45.9242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VGJnY/8FpIjT8gu048+JpajPf5K5TfDRlQJ1OJQcMLOcEqk7tPmOrMeyHbdJPwH7wr/4NcamCCdnp1QDqg76LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5080
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "RIP:cpuidle_enter_state" on:

commit: 74e2dbe7be5037a5e5eed6bc1ad562747ac88566 ("perf tools: Add --pmu-filter option for filtering PMUs")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 2febe6e6ee6e34c7754eff3c4d81aa7b0dcb7979]

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: clang
	group: group-00



config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 20 threads 1 sockets (Commet Lake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202604161630.4fec10e1-lkp@intel.com



kern  :warn  : [  447.822940] [     C15]  common_interrupt (kbuild/src/consumer/arch/x86/kernel/irq.c:326 (discriminator 35))
kern  :warn  : [  447.822946] [     C15]  </IRQ>
kern  :warn  : [  447.822947] [     C15]  <TASK>
kern  :warn  : [  447.822949] [     C15]  asm_common_interrupt (kbuild/src/consumer/arch/x86/include/asm/idtentry.h:569)
kern  :warn  : [  447.822953] [     C15] RIP: 0010:cpuidle_enter_state (kbuild/src/consumer/drivers/cpuidle/cpuidle.c:294)
kern  :warn  : [  447.822957] [     C15] Code: ff 8b 73 04 bf ff ff ff ff 49 89 c6 e8 de 28 94 ff 31 ff e8 17 25 67 fe 45 84 ff 0f 85 34 01 00 00 e8 49 c0 86 fe fb 45 85 e4 <0f> 88 0e 01 00 00 4d 63 fc 4c 89 f7 4b 8d 04 7f 49 8d 04 87 4c 8d
All code
========
   0:	ff 8b 73 04 bf ff    	decl   -0x40fb8d(%rbx)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff 49 89             	decl   -0x77(%rcx)
   b:	c6                   	(bad)
   c:	e8 de 28 94 ff       	call   0xffffffffff9428ef
  11:	31 ff                	xor    %edi,%edi
  13:	e8 17 25 67 fe       	call   0xfffffffffe67252f
  18:	45 84 ff             	test   %r15b,%r15b
  1b:	0f 85 34 01 00 00    	jne    0x155
  21:	e8 49 c0 86 fe       	call   0xfffffffffe86c06f
  26:	fb                   	sti
  27:	45 85 e4             	test   %r12d,%r12d
  2a:*	0f 88 0e 01 00 00    	js     0x13e		<-- trapping instruction
  30:	4d 63 fc             	movslq %r12d,%r15
  33:	4c 89 f7             	mov    %r14,%rdi
  36:	4b 8d 04 7f          	lea    (%r15,%r15,2),%rax
  3a:	49 8d 04 87          	lea    (%r15,%rax,4),%rax
  3e:	4c                   	rex.WR
  3f:	8d                   	.byte 0x8d

Code starting with the faulting instruction
===========================================
   0:	0f 88 0e 01 00 00    	js     0x114
   6:	4d 63 fc             	movslq %r12d,%r15
   9:	4c 89 f7             	mov    %r14,%rdi
   c:	4b 8d 04 7f          	lea    (%r15,%r15,2),%rax
  10:	49 8d 04 87          	lea    (%r15,%rax,4),%rax
  14:	4c                   	rex.WR
  15:	8d                   	.byte 0x8d
kern  :warn  : [  447.822960] [     C15] RSP: 0018:ffff8881014e7d90 EFLAGS: 00000206
kern  :warn  : [  447.822964] [     C15] RAX: 000000000068479b RBX: ffffe8ffffb81580 RCX: 0000000000000000
kern  :warn  : [  447.822966] [     C15] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff82e3d547
kern  :warn  : [  447.822968] [     C15] RBP: ffffffff85570820 R08: 0000000000000001 R09: 0000000000000000
kern  :warn  : [  447.822970] [     C15] R10: ffffffff85a9b6a7 R11: 0000000000000000 R12: 0000000000000003
kern  :warn  : [  447.822972] [     C15] R13: 0000000000000003 R14: 0000006843e122ac R15: 0000000000000000
kern  :warn  : [  447.822980] [     C15]  ? cpuidle_enter_state (kbuild/src/consumer/arch/x86/include/asm/irqflags.h:42 kbuild/src/consumer/arch/x86/include/asm/irqflags.h:119 kbuild/src/consumer/drivers/cpuidle/cpuidle.c:292)
kern  :warn  : [  447.822989] [     C15]  cpuidle_enter (kbuild/src/consumer/drivers/cpuidle/cpuidle.c:393 (discriminator 2))
kern  :warn  : [  447.822995] [     C15]  cpuidle_idle_call (kbuild/src/consumer/kernel/sched/idle.c:161 kbuild/src/consumer/kernel/sched/idle.c:237)

The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260416/202604161630.4fec10e1-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

