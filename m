Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B7E1531C8;
	Mon,  8 Sep 2025 08:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757321065; cv=fail; b=dDYmoXp/02q/JK9dIUSm7vVDVnu2NNkaLuuXpxXS1I5OVIhQZf1Up8YAqvF/S/CkpA/iLtTsLVHZaTuLW9y+NulfYENXKUExynsyXm2drdcOxMatH0RMtAzz+56Ek3KUPgqcOVRPOC9CnTu/srw4ziHDG60w6ATjNKViLoBS3z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757321065; c=relaxed/simple;
	bh=glo9MxuZiug17FPDbwx23MtnY3JyAzyrjmXTtuIoS5Y=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EUI3/8LaMDwqko8c+21WKEFMwVIjYjhZwkKbhrqHvlJYDH1a1B8gUUDH+Vf7+x5GPIqS15uyubpL6Lek4dvqgSWQ4lUt6y1bG6cxEQYxW8QjF8ssuWzi4AoRLUs6He9A7h3om6G6j90HGL4us4dYZRU38pP/rbcsD8bueCl4320=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kaJtrDKR; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kaJtrDKR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757321063; x=1788857063;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=glo9MxuZiug17FPDbwx23MtnY3JyAzyrjmXTtuIoS5Y=;
  b=kaJtrDKRLafAEfMdD3mrTGNQWUiJd5jr8T11ceKg1dX2Zp/5D3dFC/V3
   64zNGRSxQFd4GFFAKtI4EpeuHC74aGJJnPzrbgHbjZI/VfrKYhm9Lt5lz
   93+HHvamg2buRBbT7/Jt/H1kzr9nTu+tMhqhl8OufntSBFs4TEfFfYY3e
   G0iIxKVTjTK1cZPGqMZX9ioefcFU/3YmrolQTHvGcfH3mvoX4/AxMq5xX
   BVrSMn1TFBnelsHFN3DW/XmbUBiEXk0H1Fi95D6N/cVZ0WFGeEeyyeMXn
   0e6Bf3Onnjbz5teb/aUb86zSEeLHx/BXKRBakBvTs4HNckifWqbH6F9J9
   g==;
X-CSE-ConnectionGUID: xoJWfmGZSmyjiSKnZ1Zu7g==
X-CSE-MsgGUID: 4dLrr5nsRrutmWw+w2AAbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="59510451"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="xz'341?scan'341,208,341";a="59510451"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 01:44:17 -0700
X-CSE-ConnectionGUID: anAmjyQBTC2V4N8GPkGk+A==
X-CSE-MsgGUID: MkLJ7SALRoW0zrCx4O3dFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="xz'341?scan'341,208,341";a="172659208"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 01:44:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 01:44:15 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 8 Sep 2025 01:44:15 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.74)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 8 Sep 2025 01:44:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TdTYu9C85kvC4FUyrpDxjz8FA0b5cUpvfeesaG/gEiCGAIgMwQxcxqgLYwFLSmaVWWKjZhcgBYOtUllNKfwt+26wLZL0nCHi57hobSWUwA/j5V8f57hyNNGB6N4D0AgdZxd6SCJM7chCf/o03jGpnmAX2Vlr8MJHy5ZTwIZCwA7D8mZfxmsM9y3D6ZbURfR+Kxc3ccp/gj508Vz1kSuU1XgOF3Vdco3zvHfVOnruAlIsQ+D+7isLxpiUxnxGE5NOSlW0UbJk95iDZeoCcV5HhmjrF/uNa1ZzsfynYwv9cR7dPWZp4bPDC45aiPHQPoHZRGYN48ILFyRYkGpq3DBq0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lueNgdceifIGhpJxy4Sq5Z+3yD9Z4KLr8yaehx8NKYE=;
 b=O5xwHk0GQaHzsdJV5OdMdGYDClWDsw0B+Y+GIQrsRjpoQKUHFbgcK0cxKnxitoMG1IOzEI01ZazWPuKpr8+hHnFBryWEkFJahwq6vy/iY2Y6Lq2syiPGTD6J6fLmMlOQOpFjKUsX0+LAN85vShGWXNXveGbt5qFSXTHJgZvnV2gh1bDP5P0MsHPvt79hLG9RzFJfkIdiZgzJgsATrivfKezDR/MG+bTyNZmzVn0Be0ZlUcW4ssDhjvK1xd6kdgA7vh8gsaQCqjYPappC1Mm14pgorSsdJ6WNR9v3NlmaaUBilv0I4NrM4MvpP4hyd/1eoqy1q3VFp0japoavb82PKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB7001.namprd11.prod.outlook.com (2603:10b6:510:208::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 08:44:04 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 08:44:04 +0000
Date: Mon, 8 Sep 2025 16:43:52 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, kernel test robot
	<oliver.sang@intel.com>, Kan Liang <kan.liang@linux.intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Arnaldo
 Carvalho de Melo" <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen
	<ak@linux.intel.com>, Eranian Stephane <eranian@google.com>, Dapeng Mi
	<dapeng1.mi@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [Patch v7 02/12] perf/x86/intel: Fix NULL event access and
 potential PEBS record loss
Message-ID: <202509081646.d101cfb7-lkp@intel.com>
Content-Type: multipart/mixed; boundary="dy7J/g5r1NTLp3S2"
Content-Disposition: inline
In-Reply-To: <20250828013435.1528459-3-dapeng1.mi@linux.intel.com>
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: 4beca1cc-3ceb-4d0f-37d9-08ddeeb3dd79
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|4013099003|4053099003|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lwa2/CACuuAiHHG9iawF1+GxS4cL69JkYUQHC3td8vjhSQRAVko3e1RjzHEd?=
 =?us-ascii?Q?GHaSlevFSDtif46OFxWfwjzfMG9T6E+ODrgxivNHMWmA76mHGy0YTSIexPPI?=
 =?us-ascii?Q?qOcWI2EKQLCELGpSMPJf9/VUUD0J/pHI+OUVwU+9lbwAJABoDL4rKf90IGUZ?=
 =?us-ascii?Q?PBT1gdVGaIbW+bBJyUxgb3eqpwBwy+om+4n8FPcpZcPwKKyDB+Cu+JnkOkkU?=
 =?us-ascii?Q?he/Kg81nWaXsMCoFxfB8LmtWyuIde0OFWQcY4+3ToHFo34EMFsOkuBUNlBrk?=
 =?us-ascii?Q?tjSc4qBJqaecpubWv7Zxw/pFrJiNIjHFYJjct2+tOXfEwaSQVgcmwH1ord0q?=
 =?us-ascii?Q?L6qOxEhraob4kIcoMaqv3xWduG/cPQ2h6lM9/cqqvuBpzJop4BHUuraCAGYR?=
 =?us-ascii?Q?dA5b21mbR7JOkLxVls9y1dWeHntaT+L2d37zt3Sy3F/GUoYcLePXvNED3Tj6?=
 =?us-ascii?Q?M6iWW+NPe7dE5LIOheLhV/khsZXk2zEO2XDXjLQexXOSssRKzPjcKBCapSkG?=
 =?us-ascii?Q?BGmd9byt/JqGTyohYzxmckhuvckQicOCx7G1JE+/VdjK05YBHb/S130eY/oG?=
 =?us-ascii?Q?NLffAGqvV72IqnZ+w6WH8J5ot+fG73ycvtja3Nkx/CWdU53ajvEUiKxIkJwm?=
 =?us-ascii?Q?bZtcJTzA1os8mOg7ZpDxWx5CKCkiJnJ7Fv6FeA8wL7LuOyMU5IV3wyOlY41U?=
 =?us-ascii?Q?Yc3fQ8PuADC+NSZQHhtbHeTY6mXlZvbGsDXdXokzkrXuUuSUexa0NpRo6If5?=
 =?us-ascii?Q?5b592qgQUliURVO63i4tpGB4/U8yDohR81yYOypsag99DXAiys5JizBy6m1i?=
 =?us-ascii?Q?Y8+y0xAg7hS/VMzoUJpjr7qzO8TFJHPj78A7PP+9YFsc3vmQ+H22zReK5P46?=
 =?us-ascii?Q?c3NW5z1gXcsFY9MrOocWRecCwufxmgNR1FM3s/bLxmWIDqckP1P8fwYc4WFW?=
 =?us-ascii?Q?uRPVFfNOBkW9DwteJ25W9wmhJO/1dhJHZqVZSk9xtHELwy4m1Gtji3ww+nph?=
 =?us-ascii?Q?EqOmzXj/dBsrQtG5c9y0R1HXZ9wavs40Qz4dQWp9UvxkDZpsEDFK3jGnNc5f?=
 =?us-ascii?Q?EenEcF8Hm+I6aBg2SXKWUTLGBJq0GaMO6VDuJfT2hjzUWGV3OtZMCHY3POXY?=
 =?us-ascii?Q?doSfkojbk8PUqBzycrAyKWuHsFZNCwCD+YAfiOTa/v+MWVEeBUK2uaJ41Ls4?=
 =?us-ascii?Q?KqGxZru8kVBKwDrtuKRBUOyAsZziCrw4BDrqDjC7IaUvHfYLc0rJgz67xpOM?=
 =?us-ascii?Q?lxzYI5fkC42CxvmRgGZlgova0LcVGbkgu3KyTRvrFw4XPLVX/BQgyBJ6S903?=
 =?us-ascii?Q?02tduHStu0tu56kmCwXYuewuYix/d6vFSrXsSGL12mjuVORW0H9bpJ1SRUio?=
 =?us-ascii?Q?4ibwYaONMU8ePUkihPEaZ3ju6OBJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(4013099003)(4053099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B17a/nRK5QOAYgwlta2YRg/SUxWFVa/YEIreo8eAi5skjfa1PTPh+cNKeBzp?=
 =?us-ascii?Q?rQOY2nM6+UVcwfoK08m49kv5LE3EhbsXZbjOga/zHQ/uP4Dfm4HOz0yByIyJ?=
 =?us-ascii?Q?vMqYuq2M345HxizIu1hW1swPu63wsj/lnLoc6LAJtKt0AHCw1037x2+r9NHj?=
 =?us-ascii?Q?r1RFF38Waru1YgNqV9OALAz2ojdT1gf11x1NN8RJUHQ/t0WWnfUuf2MpOodo?=
 =?us-ascii?Q?66N7yCDf/QILq85uMO0bZwVoefqPheTOWd4y8RonY3dqBgQKX8FcWFPewx6E?=
 =?us-ascii?Q?BXuqZiBtYtiPQp3hKoLQeL9+XATFoTIPHN7omNwbRMBrvVi0ZUFXAUH964Tm?=
 =?us-ascii?Q?h1acfjF7jC98uMnRP8hFMtHt0ixz/8aBPctBR3UViGb5THErBs0eOskBxE7V?=
 =?us-ascii?Q?z4iF5lusT5ugfIlyB1WlDFQ5qb6zms5cPKwvMDZ/vvaC1liCPfVjDok9Ch/S?=
 =?us-ascii?Q?5Q19+VNfspAkXO09AWuYwaPRxd94snGWO7yow7HEaxhoME2XpwofCUysyeUL?=
 =?us-ascii?Q?BHTiX/tDi/zTLEhg/vymxUeoJHIUFBlbX0r+25dZ9buywRYGwmJ0m+j25J1Y?=
 =?us-ascii?Q?VmaD2stgIBIwON9cJlr2EDQYNSdwxGQ2Yr+skI+yiOLWXp5ETBgUQVVxkiff?=
 =?us-ascii?Q?jqmXMenzhVoskHktTmqgB7JVjtLS6vE2a+2FNX41ss/OXqLZ/0gF4B5A782B?=
 =?us-ascii?Q?v0q4m66C6kaomVxEnnSTKJGeq8ZkpZcyD4gCe0mfngoMWnpGQUcTUYRB2p54?=
 =?us-ascii?Q?Yscj7PH+GkCi5+ENchR/SU5b3TPQJZHd+nMDGLdZntJXiaIowS7PuLmDcBbx?=
 =?us-ascii?Q?AX+TPX1cmwYJ28dGJ6fm0YrDIGms7DRBoarV661xh2cu64sM+cjvv0a0NZzr?=
 =?us-ascii?Q?0kmCpDOjNh9nggvHBxqEYoiVyduZfXzPpxeAK0lnl+TVB8h5QkmpWC+TPu1N?=
 =?us-ascii?Q?qEfO4+QZFhIvzSeTkysKMJRcYM64F+P8tatzffgMVW/NPqKsNPsR0kgA7pXm?=
 =?us-ascii?Q?zFYHiTouRxwmJOlAq5zNR6+82AQRhIlqx8lc6GmCXnuRj9FoSl9wFjW/lQTa?=
 =?us-ascii?Q?wc5cGbPhsrKn6dvw2MmmwmqAFsX1togsg/9PBNs4C+3QBP4XfrATgsjYEMys?=
 =?us-ascii?Q?qQDRaThiMM7V5Arf93vtBUbNmco+QW44WGTEQePdSDrnRClqUMWogcyWLxDQ?=
 =?us-ascii?Q?wYAJ7rY/ewLe18r6ZsE681lLOosJEeVse/9WnvsO1qzj8AHuD/RnQubbeyQT?=
 =?us-ascii?Q?AX3CMJmHwEljhia92cKY1ErMb5scglJcYx9f7yLxrMwmYluhmScz4dklI0jf?=
 =?us-ascii?Q?DR47NxaAq5srCRNF1i2N2WVXc0YJVh3cQxODhgOzq1D0Ivu/6pd1iOYB4XlW?=
 =?us-ascii?Q?Ji2zUBA8lX5fLyi+YBpbWTUCBwKCDAT/HZbPWi5l+3c9XkJDpZI9PSMe38yu?=
 =?us-ascii?Q?7lDwSX52tRjExIn6Xg/cYTxu7PChuZ4dyT2ohMvh9zkdacx2IK7h66pcAj4d?=
 =?us-ascii?Q?oSawt+NHnvWQgdAOnQcHBcAaaN+otO7Ae/ggElko6gUqxlriZcIRemdXGh2i?=
 =?us-ascii?Q?LyJ5deAGjRiScXUlmoa0jmKr2C87kMTgcp6EqfECfkyPbam0sy1y0A4MsUoC?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4beca1cc-3ceb-4d0f-37d9-08ddeeb3dd79
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 08:44:04.4640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +13BFl1U0bC8oJptzAzWwAhzI0WkImWTLgNlDcY7c3RWEU8yS54zJr40v4il8iR1GMiXDnjYY2kMni8QyTL2kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7001
X-OriginatorOrg: intel.com

--dy7J/g5r1NTLp3S2
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline


Hello,

kernel test robot noticed "WARNING:at_arch/x86/events/intel/ds.c:#intel_pmu_drain_pebs_nhm" on:

commit: a7138973beb1d124386472663cf50a571a2059ce ("[Patch v7 02/12] perf/x86/intel: Fix NULL event access and potential PEBS record loss")
url: https://github.com/intel-lab-lkp/linux/commits/Dapeng-Mi/perf-x86-Remove-redundant-is_x86_event-prototype/20250828-094117
patch link: https://lore.kernel.org/all/20250828013435.1528459-3-dapeng1.mi@linux.intel.com/
patch subject: [Patch v7 02/12] perf/x86/intel: Fix NULL event access and potential PEBS record loss

in testcase: phoronix-test-suite
version: 
with following parameters:

	test: stress-ng-1.11.0
	option_a: Socket Activity
	cpufreq_governor: performance



config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202509081646.d101cfb7-lkp@intel.com



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250908/202509081646.d101cfb7-lkp@intel.com


the dmesg in above link is not very clear, so we also attached one dmesg FYI,
from which:

[   41.225784][   C82] ------------[ cut here ]------------
[   41.225786][   C82] WARNING: CPU: 82 PID: 3704 at arch/x86/events/intel/ds.c:2592 intel_pmu_drain_pebs_nhm+0x56b/0x630
[   41.225791][   C82] Modules linked in: xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
xt_addrtype nft_compat nf_tables nfnetlink br_netfilter bridge stp llc dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio qrtr sg binfmt_misc loop fus
e dm_mod overlay btrfs blake2b_generic xor raid6_pq intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common skx_edac skx_eda
c_common nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irdma sd_mod ast irqbypass ice ipmi_ssif drm_client_lib snd_pcm ghash
_clmulni_intel drm_shmem_helper snd_timer gnss rapl drm_kms_helper intel_cstate snd ahci ib_uverbs libahci mei_me soundcore acpi_power_meter i2c_i801 ioat
dma drm ib_core pcspkr intel_uncore ipmi_si acpi_ipmi libata mei joydev i2c_smbus intel_pch_thermal lpc_ich dca wmi ipmi_devintf ipmi_msghandler acpi_pad
[   41.225831][   C82] CPU: 82 UID: 0 PID: 3704 Comm: sleep Tainted: G S                  6.17.0-rc1-00052-ga7138973beb1 #1 VOLUNTARY
[   41.225834][   C82] Tainted: [S]=CPU_OUT_OF_SPEC
[   41.225835][   C82] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
[   41.225836][   C82] RIP: 0010:intel_pmu_drain_pebs_nhm+0x56b/0x630
[   41.225839][   C82] Code: 48 e8 b9 cd fe ff 85 c0 0f 84 a9 00 00 00 41 f6 84 24 a4 01 00 00 80 0f 84 9a 00 00 00 4c 89 ef e8 1a 2a 34 00 e9 c7 fc ff ff
 <0f> 0b e9 c0 fc ff ff 0f 0b e9 b9 fc ff ff 48 8b 04 cb 48 89 84 cc
[   41.225841][   C82] RSP: 0018:fffffe00012f38c0 EFLAGS: 00010046
[   41.225843][   C82] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[   41.225844][   C82] RDX: 0000000000000001 RSI: 0000000000000004 RDI: fffffe00012f3900
[   41.225845][   C82] RBP: fffffe00013120c8 R08: 0000000000000000 R09: 0000000000000000
[   20.931889][ T1340] Error: Driver 'pcspkr' is already registered, aborting...
[   41.225846][   C82] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   41.225847][   C82] R13: 0000000000000000 R14: fffffe00012f3c80 R15: 0000000000000000
[   41.225848][   C82] FS:  0000000000000000(0000) GS:ffff88f027c62000(0000) knlGS:0000000000000000
[   21.006859][ T1512] sd 6:0:0:0: Attached scsi generic sg0 type 0
[   21.013583][ T1512] sd 7:0:0:0: Attached scsi generic sg1 type 0
[   41.225849][   C82] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   41.225851][   C82] CR2: 00007ffe5571fe7c CR3: 00000040c5ae1003 CR4: 00000000007726f0
[   41.225852][   C82] PKRU: 55555554
[   41.225853][   C82] Call Trace:
[   41.225855][   C82]  <NMI>
[   41.225861][   C82]  handle_pmi_common+0x29b/0x430
[   41.225865][   C82]  intel_pmu_handle_irq+0x109/0x2b0
[   41.225867][   C82]  perf_event_nmi_handler+0x2a/0x70
[   41.225870][   C82]  nmi_handle+0x53/0x130
[   41.225873][   C82]  default_do_nmi+0x11d/0x170
[   41.225876][   C82]  exc_nmi+0x106/0x1b0
[   41.225878][   C82]  end_repeat_nmi+0xf/0x53
[   41.225880][   C82] RIP: 0010:find_next_fd+0x2a/0xb0
[   41.225883][   C82] Code: 0f 1f 44 00 00 41 54 89 f2 48 c7 c0 ff ff ff ff 49 89 fc 55 c1 ea 06 53 89 f3 48 8b 77 18 89 d9 48 d3 e0 48 f7 d0 48 0b 04 d6
 <48> 83 f8 ff 74 0d 48 f7 d0 f3 48 0f bc c0 83 f8 3f 76 3a 41 8b 2c
[   41.225885][   C82] RSP: 0018:ffffc90025283b90 EFLAGS: 00000206
[   41.225886][   C82] RAX: 0000000000000017 RBX: 0000000000000003 RCX: 0000000000000003
[   41.225887][   C82] RDX: 0000000000000000 RSI: ffff88f06d277150 RDI: ffff88f06d2770e8
[   41.225888][   C82] RBP: 0000000000000400 R08: 8080808080808080 R09: 979c8d9e9a8cdfff
[   41.225889][   C82] R10: fefefefefefefeff R11: 0000000000000000 R12: ffff88f06d2770e8
[   41.225890][   C82] R13: 0000000000088000 R14: ffff88f06d2770c0 R15: ffff88f06d2770e8
[   41.225893][   C82]  ? find_next_fd+0x2a/0xb0
[   41.225896][   C82]  ? find_next_fd+0x2a/0xb0
[   41.225899][   C82]  </NMI>
[   41.225899][   C82]  <TASK>
[   41.225900][   C82]  alloc_fd+0x55/0x130
[   41.225902][   C82]  do_sys_openat2+0x5a/0xf0
[   41.225905][   C82]  __x64_sys_openat+0x6d/0xb0
[   41.225907][   C82]  do_syscall_64+0x7f/0x2b0
[   41.225909][   C82]  ? vfs_statx+0x68/0x170
[   41.225911][   C82]  ? strncpy_from_user+0x26/0xf0
[   41.225914][   C82]  ? vfs_fstatat+0x75/0xb0
[   41.225917][   C82]  ? __do_sys_newfstatat+0x25/0x70
[   41.225919][   C82]  ? path_openat+0xb6/0x2b0
[   41.225921][   C82]  ? do_syscall_64+0x7f/0x2b0
[   41.225922][   C82]  ? do_filp_open+0xc3/0x170
[   41.225924][   C82]  ? do_syscall_64+0x7f/0x2b0
[   41.225925][   C82]  ? __cond_resched+0x1e/0x70
[   41.225928][   C82]  ? check_heap_object+0x34/0x1b0
[   41.225931][   C82]  ? __check_object_size+0x5c/0x130
[   41.225933][   C82]  ? do_sys_openat2+0x8a/0xf0
[   41.225936][   C82]  ? __x64_sys_openat+0x6d/0xb0
[   41.225938][   C82]  ? clear_bhb_loop+0x30/0x80
[   41.225940][   C82]  ? clear_bhb_loop+0x30/0x80
[   41.225942][   C82]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   41.225944][   C82] RIP: 0033:0x7eff04bb9a2d
[   41.225946][   C82] Code: 48 89 54 24 e0 41 83 e2 40 75 32 89 f0 25 00 00 41 00 3d 00 00 41 00 74 24 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff ff 0f 05
 <48> 3d 00 f0 ff ff 77 33 c3 66 2e 0f 1f 84 00 00 00 00 00 48 8d 44
[   41.225947][   C82] RSP: 002b:00007ffe5571f7e8 EFLAGS: 00000287 ORIG_RAX: 0000000000000101
[   41.225949][   C82] RAX: ffffffffffffffda RBX: 0000558b3236dbe6 RCX: 00007eff04bb9a2d
[   41.225950][   C82] RDX: 0000000000080000 RSI: 00007eff04bc20b1 RDI: 00000000ffffff9c
[   41.225951][   C82] RBP: 00007eff04bcd1f8 R08: 0000000000000000 R09: 0000558b3236dbe6
[   41.225952][   C82] R10: 0000000000000000 R11: 0000000000000287 R12: ffffffffffffffff
[   41.225953][   C82] R13: 0000000000000001 R14: 00007eff04bcc020 R15: 00007eff04bcd6b8
[   41.225954][   C82]  </TASK>
[   41.225955][   C82] ---[ end trace 0000000000000000 ]---



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


--dy7J/g5r1NTLp3S2
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg-a7138973be.xz"
Content-Transfer-Encoding: base64

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

--dy7J/g5r1NTLp3S2--
