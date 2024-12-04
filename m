Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF3E14884D;
	Wed,  4 Dec 2024 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321108; cv=fail; b=LzHDZ88J9Zi/nI8v/HyG1m9YaL/19HAeT+AZ9OWCMt6+v9Dh8I1n+l5P6cPGSdek+A0gLMcMhbb372SjLhnnL8iNTCq+6BPeJuGBL0u0NCoZTHa9vni1oyphNCXktsYhsn6ZFChXmWAiQ8bXhDF4qnSvu0WpXvI05VDDhe2fHJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321108; c=relaxed/simple;
	bh=hjDcEmM4QjVjLt811jNm+rBv84NE3TU9jYsz8J5LwWo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LfxoO0518UqCtwe+eTt65uWcUHEEctK+BAuwLOIjBPJemXrKMC7xQVpMgsk72tRMcZHqUGTOuLleSP9Ky42CgLwa0yfEV7aIUhbcbLXBC0CbvyGM0OWOY5ug6t+sm0AckUjJSrTRysl6KNCr3NJSuDyUjipX72LUVsO1azAngn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ne6F9bMk; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ne6F9bMk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733321107; x=1764857107;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hjDcEmM4QjVjLt811jNm+rBv84NE3TU9jYsz8J5LwWo=;
  b=ne6F9bMk61Bi/oGHm75kYeexVIB+a95iD+dUDPFWZ1fX+4BHhrL8BK41
   veV3TcILwDBplIAwl8dpGHI+s8B8Z7iGaaGOHZD1xQC50XfuRoDYaj1i2
   IoZf9UpLmpVksArf9JRrzZttrqwiU4xo1CqsjeflicqW9joIcYfgWTqkN
   EKk2l7dUmvwbbQ59A23iUVcdwSaHYLG6coe1bt3MY13D32+JCJKemZMXB
   6oX6yTUacq1YX+dILelIw3JnX5a2MFyzxQ94MID0jE8ybL1jijTw1l3Ba
   0+9KJ+ZgIMf6fDNzNUh3xZ3Er+VKFyK5BuUKd7fk/tudr4h33KUekKzFi
   w==;
X-CSE-ConnectionGUID: 6g55oDUaT5SnJ09SqV17Lw==
X-CSE-MsgGUID: x6jd//ksTRCij9ecqFNa7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="44964107"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="44964107"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 06:05:06 -0800
X-CSE-ConnectionGUID: R1gLFXVIRT6fpt0/7I5mEA==
X-CSE-MsgGUID: sKNZWabVTxyRbXkUTJrl3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="98844278"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2024 06:05:06 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Dec 2024 06:05:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Dec 2024 06:05:05 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Dec 2024 06:05:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/6zzehLeY/6wdU98Eb/rPOxdjKkr2RaCQDPqpv9Qhn4K9Vbx2C6XMU3/25kRP0RyoTesIeuDoknIzxYMcKg/oJR2gB3sZ0AApcL9iVP6p4UGEgw5Qm/jmzE1wbhXDA6C6qsjaKv9NbUZRmHgiB24TYauvZAJeK/uA7KraKjPXT+qhRFE50AYNlCMCSoicc7Qu5aCNVKfT9BHSKDU+CpzrVcB2mdR9LmnOFmJ5IlCrTmngx40uRzMXpdonac/f7bjg3Xp085uQqtWRJl4kgge0YV1PxjalqwpsuGSmtpWZYbvUnQFWeqjefpxRNTXrC6oUyIV08SbD4IzInTwFwKNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuqH8EPAr6B2rnp8VHBiWhbrDJvfmsW3cCkwIHyWj/E=;
 b=U/Yw0eZhCjmVH8k/0T6KI45rpeFQnUn+7Aq3t+F3cvIHVwcNZlB6du7Uwx+6nfGL0XJqNK1llsW+MV5hEXk+y8D/BChehFxnlMSH88lnCd9bxcvfGwuO3BRMm23UUSiSvww0qMy6gHkROGZz9ZGuoBLfNuWiTqPC4pHp0hRAQYCR1TCiTYDC1ON30uvbEUw9QccoY+OSLO0n3Veu29Nu7sR7+iN+QFSH6LtvSkBmjFKC2LoT1f7RLfSWTtOCYZbmrVWsksZp+k/ZSs4AzAdTRP5PSk8tPMG6IxMJkCgdTPFMavUExMQeneZufDvDooMwEx1Lm4zQzBAWVoGaYiQWbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB8294.namprd11.prod.outlook.com (2603:10b6:a03:478::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 14:04:58 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 14:04:58 +0000
Date: Wed, 4 Dec 2024 22:04:46 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	James Clark <james.clark@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>,
	Atish Patra <atishp@atishpatra.org>, Mingwei Zhang <mizhang@google.com>,
	Kajol Jain <kjain@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
	Palmer Dabbelt <palmer@rivosinc.com>, <linux-perf-users@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [linus:master] [perf tools]  af954f76ee:
 perf-sanity-tests.Test_data_symbol.fail
Message-ID: <Z1BhfpYWpUQ0p+qR@xsang-OptiPlex-9020>
References: <202411301431.799e5531-lkp@intel.com>
 <Z04ZUHaGdsBapIEL@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z04ZUHaGdsBapIEL@google.com>
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: 36c16756-3e64-46ec-d9c2-08dd146ca2ed
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ACUmyr8yu+Zg7xTpDzxKYRv+tg4bXz3eD1iwIprSRA3atR7Mae7tCooqo8HK?=
 =?us-ascii?Q?+LZIp8FTlgTfkGV2jymbW/bHGIIsuv1St2HBtP0TN3stUTpRfHSVtVQ/+pm/?=
 =?us-ascii?Q?rMDeQ7GFM5yaOeN1K9AmHWkT70uzHNOVT4xmD9wLSDohuI/YJURhZx+yiHKZ?=
 =?us-ascii?Q?Q/NiT508t4B7ej2PvMHXxegFMZTKDgesmZ5p/tJzTRlZA0nttBf/p/syP7LX?=
 =?us-ascii?Q?UNgeZS0vLTlU7C1RY8F9VA30Gfqpa6fLH4l5C0/2+sAMOfU2AVcNe7qcVI4y?=
 =?us-ascii?Q?4E/11gYMEPWdCeEzidHhQ86P248OxQdTgQdlxeaLCf/j8XYhLArbBnyV5dHI?=
 =?us-ascii?Q?he+k+eMjDl1vwhOoX+kuyKjI2XWzfr0peuIPsjSNhbqC4PBAL9yBQmaCtnB0?=
 =?us-ascii?Q?iosBIcDMO5czKAc3h9qQMemn4wv5zTknpRBJo3+DnS9zOA1l5i2HRu9URz8V?=
 =?us-ascii?Q?5/hBtcRv2sIa0YoLCmdwgJ1dgLpHXrbRn31i/gkLWRzrspU45UQ+bvxVh75c?=
 =?us-ascii?Q?ukoTsrL/4sm8q+73cHaUR1qL4xkWSVSF6QQry56T3V363EPsvMA9QO6F0tuB?=
 =?us-ascii?Q?f10kATcwo5RNxS2knHZoQmh0JR/71BQqpQN6jscWBvb2kTeHvJcNccHL0+FR?=
 =?us-ascii?Q?goNSY9nlx9qHP/dhNmluQPRyCyqBJKfkLB/wOSKvBLULrQTYldGQD2oqHXrU?=
 =?us-ascii?Q?uCsrycVmygYzMGoFG7s+ExS1qfpFFQphO1wohDXjcmymQNHAOhlfVaJkxHOK?=
 =?us-ascii?Q?Agi2JEsnpGRPxhp8Lc3UhGoks6dbkK9LR+zEohAGRZiVcXcEGGQrXlEcAGnH?=
 =?us-ascii?Q?2CMNBtgV2Wy39BaOuB0gNjBzY9MfhtHofu8rzdcb7InSlqvhTrBUvqaXo5Z/?=
 =?us-ascii?Q?xxl9QkS0ZyFuuSOuw6wLuT5hEmvlP3r5a02jROpiEv7A7UVcrSdpqWrIu8Sd?=
 =?us-ascii?Q?0/dMzsqHF5ZGcPaCXIMbfrDCvpOFVOpRhuy0eae4BeEXHyShpRCHxdQ34DeD?=
 =?us-ascii?Q?CqcdyvU6X1Kv5CQKgG/jXl4Vt+sV7mEFYk1iXCtqRyPRW6uZNlH1+vHpKOTD?=
 =?us-ascii?Q?T2CwfOBaTtadudiy6SEqIb2KtSwfA1+U/Xsyp9fZxAZi4fRTYP9mrI+++E36?=
 =?us-ascii?Q?zzz8Wf8rnoN8rRZ/FvIfdlRGDdznHceAAPOJV3hypzxMcSzjgOwBBZoFi7zC?=
 =?us-ascii?Q?oTCS81AMlCYkwBP+etkBqL7lLa++8gSky9RmHmevaoCAUofcC+8YQUlSn6ro?=
 =?us-ascii?Q?YX7757IeBgMpXB9unDU7xR5J8ZxA7+OT01DWaZhm+6yEtB5aL5Mpq8cjefir?=
 =?us-ascii?Q?di1tWRU2sspImOMoyjYs2naS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bjYv+k7AX44ATf/baWzSdDFDqTyAj0B1arb26TN6b9GeCCWMWoOEpGeyisWU?=
 =?us-ascii?Q?P+nKinghVVF/HIyribaLynuzqA8wFMl2qG6S078bDmv4iwtouyp8KfKJyb+0?=
 =?us-ascii?Q?VxOzYUm7DkuEYP32rJN0nktaN99Op0+h+7/78ckgVTyupg+tlAZftrFJury+?=
 =?us-ascii?Q?du8zNdz1iiP3Ty4VqWX1TgMijn6B51GBI3WjsWNg6w4vOhk5C7YLmANGTat3?=
 =?us-ascii?Q?LfFn6k0jJ+2KrihcBUqzaISnpdm0lxvY6msqExRIgUEr1I8nya7bbrmI8Drk?=
 =?us-ascii?Q?NzlWHeam7Gr4hsbT9GUNWpyi/Njjw8bJZOvSZspt1hX903VoINqdRyWYax6f?=
 =?us-ascii?Q?RAzuAMtAtIdsbDXRew5gHCMi2rFuHWXj7cYQ1zGnnJCtt8o5DfM7LosUDW/9?=
 =?us-ascii?Q?fDvcpkPGRJOIgeCvcu5uUdM4d7dhHcFFlrxsmLb+JNT/GwDMKB8enyVMxbQo?=
 =?us-ascii?Q?gDz1cF5tM8bGK7xb/TXGrUQKU8k3NWG1RrT0TDEDNrBfRxFih3TxnBAoGy39?=
 =?us-ascii?Q?Q241Y+yZ2ujwLQEmeDkoAIvcihdmglL3tPw+OVCj3E/8FlupomXqt9/DiDtt?=
 =?us-ascii?Q?Zc5Oh6qj7cON6YlpyzFBG9mlZA1GoRNNfHNaS/oIQtO6A2fgHhrrD208KcS1?=
 =?us-ascii?Q?AkbVpmcmZ62TCUGIkKmdUof5I5pKMdCcUUHJ4hLZnXnYKS9KYADiRip98p2T?=
 =?us-ascii?Q?eNVson8L//Tcxx3Dgy163FbGO7v4zubLuTQyL9KY7BVKCfcdN9zpfk/1gNU0?=
 =?us-ascii?Q?VoJQIlUQUllQuOd4iSeH8lgeqmRk0T9NicBIFA+3X7gC6cMv5AcuKW0fyYBG?=
 =?us-ascii?Q?IkDK6hlQSSKdOT3DVyO/6FrfBctofGqrqnTBWChFf5sb5a7ReyrjQuqY3qyW?=
 =?us-ascii?Q?FJCczI3Y9AbZUFlCWtv4HjJD9kNZUqaS0oK1r+IVUwmKlT1eEnoZFcaLD/BY?=
 =?us-ascii?Q?jufU6sjezufBqc4NP9gl+b3PBQvrjF/Vk8zNwBqQYv8XjCqVqdwb8XKzHP8I?=
 =?us-ascii?Q?mvHtbu5tG71ndIs5XSCEaEo0neM0fwq+o3fYFc8k9Buu+LdvoCKkerDdpGL7?=
 =?us-ascii?Q?uLZihMvSn8zOEvUmkP7O8TTi0cXPhTkXz/pVQArQNvBfpXuaS0Ru6AQ97JXw?=
 =?us-ascii?Q?MNMdmf9sDPotztzMhcK6STxezs+hoJBSuCLfxmXU4lUn315uvfcu3jHYSA66?=
 =?us-ascii?Q?8c54GJtN15T3D1PzWA/Jjw/FMWA2AQh6LdH37Ceq1+3LaAckk6IKriETgN8W?=
 =?us-ascii?Q?y9YGK/cKzVfAzUokN1dpcp8KeGQsExonRtRkYDm3BpwuCwV9/fmBaO5ddgCs?=
 =?us-ascii?Q?wkLx5OLwtNCu0XybsKEP0ByRoSnU9fWB3/XH+wsFMM5zWfz+zaog0E/HfuWV?=
 =?us-ascii?Q?HCvSxgWt8+6RdHmLbK4r/GN6yxNkWWp+GCpvUe3X/Ag5KOOZKPBRYPJ5j7/A?=
 =?us-ascii?Q?dJ30V0pAogn8nluVs37G2bGxce6dIJOen68m+y/XqNFNkXnh2Y/zC9jA9LUZ?=
 =?us-ascii?Q?d8KpCbfZE0gMcL3JgyJX6k5wgK0ILk8UUWh4rKTEMdGojMAbpokVEo4XOaFQ?=
 =?us-ascii?Q?It3s1TIG0ecl0S8TdlNNSylkH7TZ393M56G70WH52kPBxaO8AcOSMxvSVJ3o?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c16756-3e64-46ec-d9c2-08dd146ca2ed
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 14:04:58.0620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +91CuBFITod15+itCmJlio7ntyPT0pYDAWkJ3tzgn9L4qpiq3xkH1+uAiC07u6GsxNLoatNcavWwS9PspBJfhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8294
X-OriginatorOrg: intel.com

hi, Namhyung Kim,

On Mon, Dec 02, 2024 at 12:32:16PM -0800, Namhyung Kim wrote:
> Hello,
> 
> On Sat, Nov 30, 2024 at 03:03:10PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "perf-sanity-tests.Test_data_symbol.fail" on:
> > 
> > commit: af954f76eea56453713ae657f6812d4063f9bc57 ("perf tools: Check fallback error and order")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > [test failed on linus/master      7af08b57bcb9ebf78675c50069c54125c0a8b795]
> > [test failed on linux-next/master f486c8aa16b8172f63bddc70116a0c897a7f3f02]
> > 
> > in testcase: perf-sanity-tests
> > version: 
> > with following parameters:
> > 
> > 	perf_compiler: gcc
> > 
> > 
> > 
> > config: x86_64-rhel-8.3-bpf
> > compiler: gcc-12
> > test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202411301431.799e5531-lkp@intel.com
> > 
> > 
> > 
> > 2024-11-28 08:31:19 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-af954f76eea56453713ae657f6812d4063f9bc57/tools/perf/perf test 121
> > 121: Test data symbol                                                : FAILED!
> 
> Thanks for the report.  But I have a request.
> 
> Can you please run the perf test with -v option so that we can see the
> detailed error messages when it failed?

below is the log with '-v'

2024-12-03 11:20:32 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-af954f76eea56453713ae657f6812d4063f9bc57/tools/perf/perf test 121 -v
121: Test data symbol:
--- start ---
test child forked, pid 143127
 294e400-294e439 l buf1
perf does have symbol 'buf1'
Recording workload...
Waiting for "perf record has started" message
/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-af954f76eea56453713ae657f6812d4063f9bc57/tools/perf/tests/shell/test_data_symbol.sh: line 74: kill: (143139) - No such process
Cleaning up files...
---- end(-1) ----
121: Test data symbol                                                : FAILED!


> 
> Thanks,
> Namhyung
> 
> > 
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20241130/202411301431.799e5531-lkp@intel.com
> > 
> > 
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> > 
