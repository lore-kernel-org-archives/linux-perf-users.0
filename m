Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992B51A682E;
	Wed,  5 Aug 2026 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948852; cv=fail; b=eI5MH5U12/GBo+0wb/dDGy2miZx7AIOlQr6L1bc7ri3NcL04c0obja2fCtOlzZyl9s6J5kesZaIkWDKVRAbvw88Og5EbqVxNqFKbMXEmQzy0f/DNe8QLIXak+L5CtXL3xcdBuB282f9+rk0CPHjbNl3k+BjEOe69cmi8jliWhDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948852; c=relaxed/simple;
	bh=/8sGwGnd+96HkRzTLLo6WwfjHcK3roKkb+Rt+tRTdJk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DOEJo7jFNe261faT6pKjTE1VwSZqenjsWFYRCGhetEkh4A+QvwmeKlwrHiig9Cn8GUErL6mHf3uo8gfp7j7gFDo4lIJrTNm6+trwbinF7VH6umXIeamadeQ/91OXxfjzSuDrqm9hXVlMVQ6ddNJogti0qTNNoaYGh4xcZMWaEJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cPjPvZBq; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cPjPvZBq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785948850; x=1817484850;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/8sGwGnd+96HkRzTLLo6WwfjHcK3roKkb+Rt+tRTdJk=;
  b=cPjPvZBqtH1Hhe/5N14FLXXiVYV9RCcWgOLcQgcpR/dw6y7Fy4zCvEca
   Dm1bYYDyTeURefeO1RLI6TJaL2XjWReOP30YYWaq3LyPPOsbaPbYpPZ8P
   30jnneurmr2QUu7V1IO0i1lD+FrzUbt8N+GkxaK8a7xDP7eq/wKMgcJKW
   jhWoVyQljzYlU2JosY5stE1LF4o6DzeqXV5vGFG+pHbAzIrvnzWy0lZ8O
   XMWQJCLgR6pCOwF4on9rnana+aceLG3EX+eei1PNFDk6GTR3VTFXUHau6
   +SCDpoxWQNYxDzkKDQh/QJfY0rPxL7tRnUtJDBqLpC27Nx5CQmEDK3ILk
   Q==;
X-CSE-ConnectionGUID: 9jDKOW7HQWqD1MaqBjoi+w==
X-CSE-MsgGUID: cTJltcx0SSGjjDyhh/CqTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="97889904"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="97889904"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 09:54:08 -0700
X-CSE-ConnectionGUID: DfvAewmuQAyp9fGBhjWk5g==
X-CSE-MsgGUID: tXww2cYiS5CKbDEOcsNqzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="257555014"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 09:51:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 09:51:13 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 5 Aug 2026 09:51:13 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.37) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 09:51:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qw/lAb0yPAQ7RfrOK6AuOBiGdEicjMXiXoivMNVfDbWJvHRCenWVM5mBwUMO5Si3fmI845f7tKTvAl/KdUQUKGkjFY1FeVrfx5l1SLcvD8skzwFYCvt1uuVaLW02n0ilhz/XZgraN/7vSQ/yAvd64D4IaC1yatRXshIIKsVl4LQGy4M5CAmkVgwtTlbeyFBgUZMPbo1E75lKUylbF0lP1cFxUVR8LdutejBlE5I1ITaXombxry83t/NxdNmEXBCwEsPuU78cqdZuBpmYknigQX4L96dkkRy5yoVkD/ywBd6owbaaTizEfpwCMP/5pO1H5LWr9VzSUk/g3F1SwOwsCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+9roHVFGFT3sQ72t070yTAeR91ZGr3qL37C87JyIlY=;
 b=GIzES6XZXaCwXo0tMxjAIsHgUR0EeXzMrFrLCk0whXuzcC+fLAw2iNc7sJKMgqQGAWDnjMbwBnwf6A3ErQdQvg+ipwWjiN9NH4RepNQEoi+rtxq/ldcBbtIAN10kHPahf5GLy1Yb3x8w8egnMvB8kSKqQenq96vUnInBfczQY4jAso47HI75sfJz3EMvZxssKy5rqhWTwlz3EIYuHY1R6yuSIZH1p34t7HW8izfXb5Q1GSzXxfpfHAUWjkvD49/3mWO8Ee7fSASM495UlfiNAp+Sik34NYW/SRq7VzAQ87NrPLF21iE5W1xhk9GkrJ7Up2yMpOYIbj5h3u8Q/NrUfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA2PR11MB5082.namprd11.prod.outlook.com (2603:10b6:806:115::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 16:51:07 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0292.013; Wed, 5 Aug 2026
 16:51:07 +0000
Date: Wed, 5 Aug 2026 09:51:03 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<jic23@kernel.org>, <will@kernel.org>, <mark.rutland@arm.com>,
	<dave@stgolabs.net>, <robin.murphy@arm.com>, <icheng@nvidia.com>
Subject: Re: [RESEND PATCH v4 06/11] cxl/pci: Add the PMUs after configuring
 events
Message-ID: <anNp99A54UyI5f8k@aschofie-mobl2.lan>
References: <20260805155911.1304807-1-dave.jiang@intel.com>
 <20260805155911.1304807-7-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260805155911.1304807-7-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::23) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA2PR11MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e671a8-653c-4da8-900d-08def311be57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|4143699003|56012099006|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: O4J1h/wAiObr6MAg+bK2xDToyq0i19pKW5OKc7dSR8i6hgSnnySLCLzvM7d6uJ4g53cOeY6IKHhFEK7bqHD2rckyRGHzzvXMUv1+0B4QI8RUFrhVNwlTy3mWC/c6/9ux7ukNPCaX53h6nOL31xR+c9XlOSH+wHQ6rif90PHpT7Or9kYVZ7rp5cJYlVDvs/jUFlmA46FLchmneGR0fPTzZXHi9+/Ezx/CDWPOfAWv2l0gqtg/b7hbbQmxjb+Dwc/BFynldY5zANqlP4u8833HgualLn7tGEmpuPoVeeYxCm9+GMYMmSIf2Y6BrRtepWQOZkB5RPDza3UtfPQy7YkmQ1NMn8XhNAt350OjQUpB1pvaIoQW2NOOMFfI1tW1tRtVGQPE9II7qNmiVfztt5q5YbiF562mjNzjHovvIcUexss7UakHsmirGvdX7VRAVO55+tIMFDGgZjDVWWQnW1XHQ72Bu/5cTCtIjJ0p87A7w/RVyhIIczjW0KbMjt1Tw9oLzRxE9ceGcF0MHzshxWqD4cSND8RTUfTwLi5j3jZ5QqOv8qwiiu+qGzikPasKqRrlWaIdOYXz/DFxUyXrzsvzlrpmdphLrQiBmVQATJ4rC9d2OXWX179rGuO7XKqVErAGwNiZLhf0Hmp4cwFiv7HB4NFpMdhg16Q/GETXLD8cO0M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pYEIRViV7f2YbJ4Qb6Hk4JNUmHr2QEy/CtJam5+9OYd0syt2h4FI0lzzu7NS?=
 =?us-ascii?Q?wezVolme8Pr3AosR7zv4IKISyWt8PO7MNYq6ciRvRXJN+6DELkOGb6/uVCI4?=
 =?us-ascii?Q?jQuAFGbtjXRp67GvAmeA0tb1zHPNbPvPptA6hKF3FegaDzS74W/5Qt1MqtsA?=
 =?us-ascii?Q?okS+OMGxA+/i8MxAU2w59YCn4/qHdbGpBlk+Wde1b0H9EtwSvwygUQY56JX0?=
 =?us-ascii?Q?nS5wuGNl6mRSWBmBKPR/lpxd1bGwvviCEEMFYhcAhj33sCUxZe+mtOAQnrGy?=
 =?us-ascii?Q?z4ppmljlYBWz6WsALUqFULcX9nVhEdL7InoE8hltgRPnotVKmOKsIMp3C8Jv?=
 =?us-ascii?Q?sUqankG/yefs3xeFipgMhCAP4WYr6SFo5Xrc7Z9FRS6RoIn6p+Ah+H4DED0Y?=
 =?us-ascii?Q?yD+h2+MimX7TTkUk5VTvDUHXb2fd9r9Bu0wZ0Qqeoj09YfG2lFPWHHCWje/2?=
 =?us-ascii?Q?iEaQAzBCa4OcWcI1Qs46PIt2HbKoaT2euIdbkjqVao+1+Nc4oeZddrtTsPn/?=
 =?us-ascii?Q?+hRgyCV8Xp2o2NwQqOeqrKHtzSSZ9CplAHIAYU7UownYNqqyJz9mTO/dlzCr?=
 =?us-ascii?Q?eoGriZvJL5Te7gj2oZLXT/WGiQlj0WW79LMxuEg8BWPLdyFznMKFRGHf0z3T?=
 =?us-ascii?Q?X3xqp6xTdjXOBXXqQubsUhj13czQgwFjo3O83Mz3IAnL+8617u6r69jNCj+S?=
 =?us-ascii?Q?Pjea+pHzF/RGsdq2XfL/JeNiD35bZB41rSSMcjnp1xC42TEloGbkIZsLcTdu?=
 =?us-ascii?Q?TKCrJe7uP9qBCbYdbOx0O07vsHwtD6xBhTQcDUZOyW3IFIXZYWGsgrbV/b3g?=
 =?us-ascii?Q?ThcvlQhsdc22RDqXtZ2Y2yOhFfIyUDbA1d8lsD2k8fac796a8XHZRjWpybL1?=
 =?us-ascii?Q?Jszhey+40iNaMyAG2Tt/0Q4qe7a3xaXlDDhiSVHaZlIfUlDdHZNzxW0lB+a0?=
 =?us-ascii?Q?TgRIdteJEKqVKQcUIcWQZLqQOGOtsHTaNNAlVb9CRiAB45KAqKsxlgetQT19?=
 =?us-ascii?Q?a40hr2/QH5dwl4NxYQeWeJo18/pO/rZXu5maSga/af+T/VvbjUC5Gz52vZSk?=
 =?us-ascii?Q?3EMrhSHDCkRCjXu+ZEpSh69HwVntDGDHMVOBJMAhZju14TVJvqR5WqNeJp40?=
 =?us-ascii?Q?7e5yDPdrdxsMx3Gy7PNPIAWHzbMEcnc4qyQU1Q1wv0kcHDfNSmDoLyOmRwEV?=
 =?us-ascii?Q?WaYYniFzDQVtvsDzFC1oKgHBBDgYiWTnlhaWIZzv0EZIwLOc753fwdw0tx0G?=
 =?us-ascii?Q?2hkA32r0nqXHiuDX5v12xdh32oikVa80tLGHwyFZhDKVCNCiMG1cIy5tJzY3?=
 =?us-ascii?Q?/qo669MfaingesXnJ0Fkc2gatJYt6wGGE3MdGNOspjTqlK8ifKikPNPDIo+J?=
 =?us-ascii?Q?LZzx+Yn0PMGMmkxqq3aflYg4FpNsUGc57MEvIRBiX1EqRtv1Q4bjJNEPprmC?=
 =?us-ascii?Q?4dW53bMzXGheBZdBesTSAlXCuiVMm8VtiaXnfpRJHmD6qal6/ETWO4F4GZX5?=
 =?us-ascii?Q?bfqk/1eEbeS8/kR7I+mDarx9l4OgVHomP4t4Z9JnD415GFastV+eoS14WZmc?=
 =?us-ascii?Q?zD1x5G74siTL3NL+f7iMwYQ7NBC7njgwTk7O7TUT3gDmZYke2E07eEpCZSbb?=
 =?us-ascii?Q?gNobOUPXUkJeaJkkN6x2xjM+pUm/D0JRtxbUCqokMW9qMBRTGHGWcTh0nX9c?=
 =?us-ascii?Q?693OaHs2pdIv+cZI+AYqxOzcnzK4zTI5e2Z3FKkdIQ3BFHVlB+g7KC3RlJ9o?=
 =?us-ascii?Q?MQka5GlxiQBYV4nb5/06z26i5VVlc04=3D?=
X-Exchange-RoutingPolicyChecked: SwOYUyQ7MmWIHCKwtPcC8GGV+ltWwp1whXgrQzQzItSf8My0z+qh+6XK46orxF06v/tK0bpHGj0Ovr7xbbMMzj3gOifRkE6HYJhXO3vVkFa41ysRg8jn6iHcdKN+21iDEYbcjBMDu67Xkh4hhp5KJhymze2JXNDsF/uzgS4GHkBBcMI20CAm0Sr0r384IIBvEwz7UjQ+aRa0nA0k+7KIyYSQK1rRh73cfxEFMjqo1cwOTFPxBpKAdULV0/owjGC6+SkMAXszzcW5XMs2qlhVrbpPHF5DCSD2Uzz1ZzgnMqLoJbqRLPr3ouT8iS0FoNDtyeOSBj1H/aZFMkH4tEtajQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e671a8-653c-4da8-900d-08def311be57
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 16:51:07.0321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0EROedEEvkjhmjoK1yMsVVK0iWgauxd59tYmcEWRFTKRslS2BD/WrmlWv+QFMuEWsJd266hXuU25LvD+3IvX9fd+59dYt1bdQQylV4r2lps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5082
X-OriginatorOrg: intel.com

On Wed, Aug 05, 2026 at 08:59:06AM -0700, Dave Jiang wrote:
> cxl_pci_probe() adds the CPMU instances before configuring the event
> interrupts. Both take an MSI/MSI-X vector the device names in its own
> capability registers, and the spec lets a device point several capabilities
> at one message number, so the two can collide.
> 
> They do not fail the same way. A failed devm_cxl_pmu_add() only breaks out
> of the loop, while a failed cxl_event_config() aborts probe and the memory
> device never appears. Going PMUs-first therefore lets a peripheral facility
> take the vector and deny it to one that matters.
> 
> Configure events first, so a collision costs the PMU rather than the
> memdev. Return 0 explicitly afterwards, since rc still holds any PMU error
> that cxl_event_config() used to overwrite on the way past.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
