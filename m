Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE121F4281;
	Tue, 30 Sep 2025 05:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759209608; cv=fail; b=R4Xx3gJheCml5CCesHCpsgoSBYr50EhDnZGKBpZwhCCkn547ShpzITqFaxImrdJCyKlph0nXHm6y5pmv5Eabh2jNKMEJ9ldWXJxD0GAjrFmetf+J632Q4WOY3lTokMFg7eBb+nhud777rMGlfGu84RydULwiQG8NiGhU/0QHCZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759209608; c=relaxed/simple;
	bh=n9uYRESPeQv3KBswr/qZvVDMbsRrzP+9tbAb4q8xiz0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WZlNFY9fbKX9vmrzQ4DHmLhzsBChN0qwgw9aoviGXfNOoECXaYnBFw7quyQt4sphHCpno4PuXxp53n5iG+i+r/2K5nf5H/V8S+8CzWnyWmZi7699S0voI1hKfr/lq3q3bHTU3l1jAj5Oo0Ef5mNFsjWkIuWwQv85wirdHzy0VDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BVMtA5Yq; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BVMtA5Yq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759209606; x=1790745606;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=n9uYRESPeQv3KBswr/qZvVDMbsRrzP+9tbAb4q8xiz0=;
  b=BVMtA5YqSz7B7ovLohuSWs13tNJ12dQbEGQMiS0Rgtsir9StYYpZaW3Z
   FPP6qSyu9RNpeQ5i+l9q55ylVlaBP/18HsP3J/Qej/4s/sLciqLMjKr58
   Ij2gbrIEDjzUL9dCjmVQwWSKtaPLKdtrnpWltXcrjo2NErSHAE4IE2nHZ
   3GabeAHHG061yIQ8cA8KugQp9QYCcKepuISaeaNNcyjc9QINSkp3bQhrt
   z/LxjixT/bYOFDEHuzol9+IREu9+IVpozsaGkjJ09favhWAyZY6nIhoNp
   5xXsPHj7TLguIJXP8ay8A9FTorKR46R6m/kSBW0LSxGU28v9WzftU48iV
   A==;
X-CSE-ConnectionGUID: aXZGx6hUScmOrSTUBMSDTA==
X-CSE-MsgGUID: R6wZwWtHTg+ESZTvd2+1DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="72136552"
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="xz'341?scan'341,208,341";a="72136552"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 22:20:00 -0700
X-CSE-ConnectionGUID: E6vZyrSRS06wuA6wHS0qrQ==
X-CSE-MsgGUID: 0YfyYuWBTuK0OxmNnXBUow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="xz'341?scan'341,208,341";a="183684862"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 22:19:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 22:19:54 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 22:19:54 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.48) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 22:19:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0483CmzInzEHA0ITdZbJ6BFTcrMf7K9EKWVWmJ9hZ+6sTIX8but5woI8nqHbWPA3lw/Idgeoknf6t3n/iCJU1OTTBTGb1UEyi2MCJsfR6YSmDZdmyLNA8/WnaYx6N3g60t589FmDLTJzO3n5nwev8hD+OHF1/IJYhGepzI2AOpGO3DzC8q8RW4r/Ujn8bXaETBA4393R7StWHR345hTBe4XhhCCdZOf+yvUCfy+35u+J8ZtBg2gZNJZ0btLWBipeV8JPCdC/AZ8R6sXmL1SWy5uuxN9IrA3ckd+zjAXZIkIBR+kvhhjoFtd/MvwJfdXiY2GTHgpXKBZfd4MysdYjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGQGs0JoKD5tjjzbK1XXp5hr2GYIEbxFpsofJ9CDR/U=;
 b=N4+FdFHGVBwPat+XoRnuK5gIBjuugit8uvSXu19X2pqkUgpwiGvu2edFZ9DpZ9PerohpRYlvDrJzEvnoIguQ/snni6PUP12ZnyN9rzQxqMg2xzTwuf3FWpsU1BdsDwlpB7zidLI08d/kGq9VkW69nLA306xDIyD9c9RFQtCVxhYkUt9BqOaJc/yPRubNKMcy6wB9dcMpgeWKSWtcPtIJww8wx7qbqZMwwGK7JalkPA1dItSk5PNhEweL9qa5JnFpPOeD/w1vbBwPojqSGUIsK/piVtz+S8a0JN53/KN+2m6QMXub/rgbkcZSYxtbX/RLVhq2xYYAxSKg58Du+sYOAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB7302.namprd11.prod.outlook.com (2603:10b6:8:109::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 05:19:47 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9160.014; Tue, 30 Sep 2025
 05:19:47 +0000
Date: Tue, 30 Sep 2025 13:19:35 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Kan Liang
	<kan.liang@linux.intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, "Adrian
 Hunter" <adrian.hunter@intel.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, Dapeng Mi <dapeng1.mi@intel.com>,
	<oliver.sang@intel.com>
Subject: Re: [Patch v7 02/12] perf/x86/intel: Fix NULL event access and
 potential PEBS record loss
Message-ID: <aNtoZ3bJ5OmGAMT0@xsang-OptiPlex-9020>
References: <202509081646.d101cfb7-lkp@intel.com>
 <e92a703d-6a92-474c-acba-b15176b97548@linux.intel.com>
 <bd48852d-e5d3-4d58-9d71-891a4e31dd5b@linux.intel.com>
Content-Type: multipart/mixed; boundary="s1z7SxBGmvMBdzOA"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd48852d-e5d3-4d58-9d71-891a4e31dd5b@linux.intel.com>
X-ClientProxiedBy: TPYP295CA0038.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: d36ca477-df3a-4926-896a-08ddffe0f8bf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|13003099007|4053099003|4013099003;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?d2Pgqipp1+KUOCHyAa/eymmrBXwq/xLV6h5YC0ElK1pQ8Ilt65Y6UBDt+m?=
 =?iso-8859-1?Q?7AOpeunJHnqfxv+76REv71WdGEotE1rQxqlHZcvJ79nKlcOAtcMBpQxInI?=
 =?iso-8859-1?Q?GhsbJskInQpEapHJD/Z5dSHaSMtZqcZDwez19r024mOM3jmFUtNOUwMUMd?=
 =?iso-8859-1?Q?s9TEwJ4sf6d5JErhCNgFIIOuiAegSHQKtFf2mJUFxAhiYsMimFxnWHH9B1?=
 =?iso-8859-1?Q?2ioidUhK3xtzTqutOCyvzmxy6GpqQ71H2bugn1bpxF06JyEYKPlZh/sJyF?=
 =?iso-8859-1?Q?+TgaAHTMoa6L+zb9ts8lOjdMT9zldsLFJo09J6WeaeVlGHoQAzRHoQ+42m?=
 =?iso-8859-1?Q?tHFIQd43SNvKpRjvCv/9is89Z3v2xHVDjKu/qdYs6TYxALh/NAqo5sA/Ph?=
 =?iso-8859-1?Q?aSU8XKtkXMpUiec7u/pEocNPpdx57sF4D4diaopeYhISZbcoAHEczxOXBz?=
 =?iso-8859-1?Q?wgqhSWb4RYJ3f180EExBjwmtpFOQd/SrkpbdfXC4RFVYAsKiL/hb0XxBdj?=
 =?iso-8859-1?Q?Jv8wo/dLDbq8xnH4CTfqZxs1wT3OG8PxH2JLOqDJ9ZVAVjn627AU2pp6gH?=
 =?iso-8859-1?Q?Vtl1P02Z2LflrJDcC9xwH+I9m32xDQ16oqYS7YiGfE8zdUAUoCQ93FU/VP?=
 =?iso-8859-1?Q?2uIMoWH06l1iy0qlS1GKyDuotmoSqBoKoPgH+ZNHz8GNIoGU4p5g997vxU?=
 =?iso-8859-1?Q?4EhGnzq51NXy5+yDKYeXnkyJkVRSd+fwP3IO0XVltzWY8uVhGrD3bsBDZZ?=
 =?iso-8859-1?Q?UPOTQ4Pq8AFwPYXDlUwxsTntbBhG7N9qX8wPpNAtSzx8S8WD+EpYpstYqb?=
 =?iso-8859-1?Q?lpU2XyNacP9KlzeOwY6DkUdz7bnYRVJ4jG2MgTdE8XAd8DQPZ8jVB6Uv8I?=
 =?iso-8859-1?Q?tbazikFxVD15mMyxheguaNrL1ZWr2IjNee16EggyNsRUQQA41KK7Cz/JEK?=
 =?iso-8859-1?Q?vPIy/flRYqHHerHudh5uytH7YiVznPP2LzczPC+AGFz/GGcU3oDgN1qCtq?=
 =?iso-8859-1?Q?piWbG4nOqX+AsNthAfbONWCCtEQC23+SWM1OXNsjwNTBxS4qQnTn5XDIYW?=
 =?iso-8859-1?Q?FOeUvbaikf/tb0xnw2+/kyQXb63bfKNV1SGrgtlfMq1/nosm03kSYRzHVP?=
 =?iso-8859-1?Q?khuTJsiiB3Zjf9sxSpJY+knA8ZQm3s2T8QyLEzaWOfjllZI/GqNKE8LXCO?=
 =?iso-8859-1?Q?2TvCCg+/rCSIbS+oZ2iTo4UtC/y2vcOkl9FISVpjzQGTcptQX67+GQjZ1a?=
 =?iso-8859-1?Q?zVyz8xeGk5gSO3UTCOj+JBesMzg45VgbcCggoikh+qre7FuGW5qxPOb1W1?=
 =?iso-8859-1?Q?kJKmSPROA2ByA0GIoaWYNt3/X52Yw8EwCIwRpl3Ln4ElEXjbV0GormHvON?=
 =?iso-8859-1?Q?UpW4nQC5hHcs0KNJwz1demA3X1uAIqdUYjD2pcz7qUtR7yy+sHvWD/P0Hq?=
 =?iso-8859-1?Q?Tj9tLDO7KUcIB4a5sfZ5fz/EUKfMGhb+WcsU1aupJqOcip7IZDGWP2b08Z?=
 =?iso-8859-1?Q?E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(13003099007)(4053099003)(4013099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?tbI3Fpl80V+fqm+YFn0rE7fd9N1UjdFks/Hz6ptlOzPhCO2K7ilqZkejmq?=
 =?iso-8859-1?Q?JVt6npQU3q14QIt9W8PYkCJszQ3gnspvAMcW3d4VFpiWqqmX/WNCVKQEqc?=
 =?iso-8859-1?Q?SkVLqy0lQOupvwskgCl9UIseMWZuxIViPBHuMTbLsfVWTXIJto3Xk+lg64?=
 =?iso-8859-1?Q?/URNDCGp8rgNRyppvjuLdgk+nivqDGGQy4O5yejxx+6XKn2Sw1mkF6lxz1?=
 =?iso-8859-1?Q?lmH8ysy43qrDRgtMb6n3AEclZuv39M7PoTGvzU03senZsxhyX3LqG1QYQI?=
 =?iso-8859-1?Q?gvS1NcwcVmCnj+AdV+FwZOtgM3o2Iny/+WX0pL00hKuUJUJqUIAqZO3HE4?=
 =?iso-8859-1?Q?rb8Uzg6IOhsQEzJLfE6i6UO6UreEHBGHqQm40hGjMf/R2QPovfz/20s1VS?=
 =?iso-8859-1?Q?7lVIq+jaBdQ9IfTeukuehZW630fIfyui9Lu37oHA74Z5nQcr9d/fmo6Hbw?=
 =?iso-8859-1?Q?qgrWHnxDqObX0mFKy9ME+4OGH4Z+1W5EZGF7u0PeZA54zWK0F/3Y6aJlgL?=
 =?iso-8859-1?Q?lzMYASlm1sslreSZe4uJHGFUm/W1j2L4lTdeTAfc//PTpIRGUXjYspiHMN?=
 =?iso-8859-1?Q?WmWycpAs7xOqyAmodJ/dpJS1gYwu0jZTJnGTlgLY8t4wRWQ5rebpMtG7R0?=
 =?iso-8859-1?Q?bMENXRosf9PpOiL3hGV4ehVUId2qSb5M7sLbToJdgyJYKzxN9vWVpHxEk5?=
 =?iso-8859-1?Q?KRf73D0xOgOY6IaV45N5fidyXT5Jd5L13cmZoUmMNheU9YCEdet1KFFmhr?=
 =?iso-8859-1?Q?VlSRShQrgbj5wqM6ykqEocQ+4PmWMpo2c6PEzMQwiIn44m5KYyCZ2jdDl6?=
 =?iso-8859-1?Q?3m9Gk2EqQAye6SAb+wRqfUwyxaJDE4bTotV2OkwVOA+eQGVqKHEeXzVq7R?=
 =?iso-8859-1?Q?lZmufxKQ0h/ErywZzsqtKQYSYrB1gFSYSvYu8npvxAFg8i1IOIec+xFmGB?=
 =?iso-8859-1?Q?GZwskHT9c5S89mjuGoBvSyQMiWux98Y+DIdLUIfiuC19g+w/M0h8NkJMbe?=
 =?iso-8859-1?Q?XR09pjAa1T/8wb1vuXJZPhNk4xGTD6H3VkepzE1FVXwdiFxEFrdozZO7UQ?=
 =?iso-8859-1?Q?q2T9205KZldNUEmZKjJH8Fnr1H0LzSIFU6XgRFCVJxhaeJRsQYLDZ1wG0q?=
 =?iso-8859-1?Q?0WQxNwmbj5Z2Z0aPogZ61dY88SEJUMnPNtm+i6C8oQNuHLE6BomrIPaRL9?=
 =?iso-8859-1?Q?OEuFJ0cCZnzjcfboOaxaOgWSXdfx8og1PRFetRBUMaXjp/IqG3oYhqa6Ty?=
 =?iso-8859-1?Q?2fjGekiB5l1srHYmEmbfoNyv0x/qso0/n3WMz315T8qE5hLau+bXgCa1Pr?=
 =?iso-8859-1?Q?XO4ky0SagNdiHrHnSRdHWaY6sfLruKE/C8q7ShL/daMwQUA8kkq88aBcLx?=
 =?iso-8859-1?Q?EHYVDRvfU6Iqnx5bfsE5PcCdEOO9zykXvpQQElYrUa/ahLbAmaaeWsLU5Y?=
 =?iso-8859-1?Q?UalRY5Hi1vXCFuwItLDP5fnYOu5u+E2E6im1EXIH1uZlsu7e9zTHxobq4A?=
 =?iso-8859-1?Q?PecOSlyLuIfYSOZBb9DLS6xuBkfRk3O+ChGuGj972aL4wJ7zcSUeDG/7a7?=
 =?iso-8859-1?Q?Z/m/GuSsuzYpbgLhMeoy7Tq8IRs2KH53NjHE53bUbGdnBC21xUVykPYVOO?=
 =?iso-8859-1?Q?GHiMtCAbVAKG2ghe47x6hOwgydJfDwszOY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d36ca477-df3a-4926-896a-08ddffe0f8bf
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 05:19:47.2274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RqkaYxGjIOZ+YdsGx8I28QJo9mqryOFcuPzs1gZ6tdGsUbfXpPvarX1NIV1vmJR4qGhA3x8/KDww+qnQnpY4+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7302
X-OriginatorOrg: intel.com

--s1z7SxBGmvMBdzOA
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

hi, Dapeng,

On Sun, Sep 28, 2025 at 02:00:28PM +0800, Mi, Dapeng wrote:
> Hi Oliver,
> 
> Could you please help to validate the attached patch? The patch should fix
> this warning. (Please apply this patch on top of the whole patch series).
> Thanks.

the patch doesn't fix the warning [1]. one dmesg is attached FYI.

BTW, I applied this patch on top of the patch set, and the patch set itself
is applied upon f49e1be1954248. as below.
if any problem, please let us know. thanks

* f7171f90cc3a45 perf/x86/intel: Fix NULL event access waring from test robot
* 81248d31dd384c perf/x86/intel: Add counter group support for arch-PEBS
* c4dd1608098ec0 perf/x86/intel: Setup PEBS data configuration and enable legacy groups
* de78881cd5ac79 perf/x86/intel: Update dyn_constranit base on PEBS event precise level
* f560ef321b0632 perf/x86/intel: Allocate arch-PEBS buffer and initialize PEBS_BASE MSR
* 5411e99084e21d perf/x86/intel: Process arch-PEBS records or record fragments
* d721d0d90c7b30 perf/x86/intel/ds: Factor out PEBS group processing code to functions
* 0cd78a2875e1ab perf/x86/intel/ds: Factor out PEBS record processing code to functions
* cc5755ee9b8bb2 perf/x86/intel: Initialize architectural PEBS
* 995af2a15982ff perf/x86/intel: Correct large PEBS flag check
* fa9540afb72301 perf/x86/intel: Replace x86_pmu.drain_pebs calling with static call
* a7138973beb1d1 perf/x86/intel: Fix NULL event access and potential PEBS record loss
* 0c9567b36ae6f8 perf/x86: Remove redundant is_x86_event() prototype
* f49e1be1954248 perf/x86: Print PMU counters bitmap in x86_pmu_show_pmu_cap()

commit f7171f90cc3a45627643d4eadd204e2b8f45e540
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
Date:   Sun Sep 28 13:50:47 2025 +0800

    perf/x86/intel: Fix NULL event access waring from test robot

    This patch fixes the warning about
    https://lore.kernel.org/all/202509081646.d101cfb7-lkp@intel.com/.

    Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 65908880f4244..ef32714cb1822 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2821,8 +2821,11 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
                 * If collision happened, the record will be dropped.
                 */
                if (pebs_status != (1ULL << bit)) {
-                       for_each_set_bit(i, (unsigned long *)&pebs_status, size)
+                       for_each_set_bit(i, (unsigned long *)&pebs_status, size) {
                                error[i]++;
+                               if (error[i] && !events[i])
+                                       events[i] = cpuc->events[i];
+                       }
                        continue;
                }




[1]
[  101.198733][    C0] ------------[ cut here ]------------
[  101.198737][    C0] WARNING: CPU: 0 PID: 2770 at arch/x86/events/intel/ds.c:2849 intel_pmu_drain_pebs_nhm+0x589/0x630
[  101.198758][    C0] Modules linked in: xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
xt_addrtype nft_compat nf_tables nfnetlink br_netfilter bridge stp llc dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio qrtr sg binfmt_misc loop fus
e dm_mod overlay btrfs blake2b_generic xor raid6_pq intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common skx_edac skx_eda
c_common nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel irdma ice kvm sd_mod ast irqbypass snd_pcm gnss ghash_clmulni_intel drm_c
lient_lib snd_timer drm_shmem_helper rapl ib_uverbs snd ipmi_ssif ahci drm_kms_helper intel_cstate soundcore libahci mei_me acpi_power_meter i2c_i801 ioat
dma intel_uncore drm ib_core pcspkr libata ipmi_si acpi_ipmi mei joydev i2c_smbus intel_pch_thermal lpc_ich dca wmi ipmi_devintf ipmi_msghandler acpi_pad
[  101.198862][    C0] CPU: 0 UID: 0 PID: 2770 Comm: perf Tainted: G S                  6.17.0-rc1-00063-gf7171f90cc3a #1 VOLUNTARY
[  101.198871][    C0] Tainted: [S]=CPU_OUT_OF_SPEC
[  101.198873][    C0] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
[  101.198877][    C0] RIP: 0010:intel_pmu_drain_pebs_nhm+0x589/0x630
[  101.198885][    C0] Code: 48 e8 1b bd fe ff 85 c0 0f 84 a9 00 00 00 41 f6 84 24 a4 01 00 00 80 0f 84 9a 00 00 00 4c 89 ef e8 bc 29 34 00 e9 a9 fc ff ff
 <0f> 0b e9 a2 fc ff ff 0f 0b e9 9b fc ff ff 48 8b 04 cb 48 89 84 cc
[  101.198890][    C0] RSP: 0018:fffffe000000d8c0 EFLAGS: 00010046
[  101.198895][    C0] RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000001
[  101.198898][    C0] RDX: 0000000000000001 RSI: 0000000000000004 RDI: fffffe000000d900
[  101.198901][    C0] RBP: fffffe000002c0c8 R08: 0000000000000001 R09: 0000000000000000
[  101.198904][    C0] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
[  101.198905][    C0] R13: 0000000000000000 R14: fffffe000000dc80 R15: 0000000000000001
[  101.198908][    C0] FS:  00007f96c7747840(0000) GS:ffff88bffb7e0000(0000) knlGS:0000000000000000
[  101.198913][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  101.198916][    C0] CR2: 00000000004ac270 CR3: 000000021df93005 CR4: 00000000007727f0
[  101.198920][    C0] PKRU: 55555554
[  101.198922][    C0] Call Trace:
[  101.198927][    C0]  <NMI>
[  101.198942][    C0]  handle_pmi_common+0x2e1/0x4b0
[  101.198965][    C0]  intel_pmu_handle_irq+0x109/0x2b0
[  101.198967][    C0]  perf_event_nmi_handler+0x2a/0x70
[  101.198974][    C0]  nmi_handle+0x53/0x130
[  101.198979][    C0]  default_do_nmi+0x11d/0x170
[  101.198988][    C0]  exc_nmi+0x106/0x1b0
[  101.198990][    C0]  end_repeat_nmi+0xf/0x53
[  101.198995][    C0] RIP: 0010:clear_bhb_loop+0x5e/0x80
[  101.198997][    C0] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
 <b8> 05 00 00 00 eb 01 90 83 e8 01 75 f8 83 e9 01 75 bb c3 cc cc cc
[  101.198998][    C0] RSP: 0018:ffffc90025163f30 EFLAGS: 00000002
[  101.199000][    C0] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000004
[  101.199001][    C0] RDX: 0000000000000000 RSI: 0000000000000010 RDI: ffffc90025163f58
[  101.199002][    C0] RBP: ffffc90025163f48 R08: 0000000000000000 R09: 0000000000000000
[  101.199004][    C0] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[  101.199004][    C0] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  101.199007][    C0]  ? clear_bhb_loop+0x5e/0x80
[  101.199010][    C0]  ? clear_bhb_loop+0x5e/0x80
[  101.199011][    C0]  </NMI>
[  101.199012][    C0]  <TASK>
[  101.199012][    C0]  ? clear_bhb_loop+0x30/0x80
[  101.199014][    C0]  ? clear_bhb_loop+0x30/0x80
[  101.199016][    C0]  ? clear_bhb_loop+0xe/0x80
[  101.199017][    C0]  ? entry_SYSCALL_64_after_hwframe+0x71/0x7e
[  101.199020][    C0]  </TASK>
[  101.199020][    C0] ---[ end trace 0000000000000000 ]---


> 
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 65908880f424..ef32714cb182 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -2821,8 +2821,11 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs
> *iregs, struct perf_sample_d
>                  * If collision happened, the record will be dropped.
>                  */
>                 if (pebs_status != (1ULL << bit)) {
> -                       for_each_set_bit(i, (unsigned long *)&pebs_status,
> size)
> +                       for_each_set_bit(i, (unsigned long *)&pebs_status,
> size) {
>                                 error[i]++;
> +                               if (error[i] && !events[i])
> +                                       events[i] = cpuc->events[i];
> +                       }
>                         continue;
>                 }
> 
> 
> On 9/8/2025 5:05 PM, Mi, Dapeng wrote:
> > On 9/8/2025 4:43 PM, kernel test robot wrote:
> >> Hello,
> >>
> >> kernel test robot noticed "WARNING:at_arch/x86/events/intel/ds.c:#intel_pmu_drain_pebs_nhm" on:
> >>
> >> commit: a7138973beb1d124386472663cf50a571a2059ce ("[Patch v7 02/12] perf/x86/intel: Fix NULL event access and potential PEBS record loss")
> >> url: https://github.com/intel-lab-lkp/linux/commits/Dapeng-Mi/perf-x86-Remove-redundant-is_x86_event-prototype/20250828-094117
> >> patch link: https://lore.kernel.org/all/20250828013435.1528459-3-dapeng1.mi@linux.intel.com/
> >> patch subject: [Patch v7 02/12] perf/x86/intel: Fix NULL event access and potential PEBS record loss
> >>
> >> in testcase: phoronix-test-suite
> >> version: 
> >> with following parameters:
> >>
> >> 	test: stress-ng-1.11.0
> >> 	option_a: Socket Activity
> >> 	cpufreq_governor: performance
> >>
> >>
> >>
> >> config: x86_64-rhel-9.4
> >> compiler: gcc-12
> >> test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory
> >>
> >> (please refer to attached dmesg/kmsg for entire log/backtrace)
> >>
> >>
> >>
> >> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> >> the same patch/commit), kindly add following tags
> >> | Reported-by: kernel test robot <oliver.sang@intel.com>
> >> | Closes: https://lore.kernel.org/oe-lkp/202509081646.d101cfb7-lkp@intel.com
> >>
> >>
> >>
> >> The kernel config and materials to reproduce are available at:
> >> https://download.01.org/0day-ci/archive/20250908/202509081646.d101cfb7-lkp@intel.com
> >>
> >>
> >> the dmesg in above link is not very clear, so we also attached one dmesg FYI,
> >> from which:
> >>
> >> [   41.225784][   C82] ------------[ cut here ]------------
> >> [   41.225786][   C82] WARNING: CPU: 82 PID: 3704 at arch/x86/events/intel/ds.c:2592 intel_pmu_drain_pebs_nhm+0x56b/0x630
> >> [   41.225791][   C82] Modules linked in: xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> >> xt_addrtype nft_compat nf_tables nfnetlink br_netfilter bridge stp llc dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio qrtr sg binfmt_misc loop fus
> >> e dm_mod overlay btrfs blake2b_generic xor raid6_pq intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common skx_edac skx_eda
> >> c_common nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irdma sd_mod ast irqbypass ice ipmi_ssif drm_client_lib snd_pcm ghash
> >> _clmulni_intel drm_shmem_helper snd_timer gnss rapl drm_kms_helper intel_cstate snd ahci ib_uverbs libahci mei_me soundcore acpi_power_meter i2c_i801 ioat
> >> dma drm ib_core pcspkr intel_uncore ipmi_si acpi_ipmi libata mei joydev i2c_smbus intel_pch_thermal lpc_ich dca wmi ipmi_devintf ipmi_msghandler acpi_pad
> >> [   41.225831][   C82] CPU: 82 UID: 0 PID: 3704 Comm: sleep Tainted: G S                  6.17.0-rc1-00052-ga7138973beb1 #1 VOLUNTARY
> >> [   41.225834][   C82] Tainted: [S]=CPU_OUT_OF_SPEC
> >> [   41.225835][   C82] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
> >> [   41.225836][   C82] RIP: 0010:intel_pmu_drain_pebs_nhm+0x56b/0x630
> >> [   41.225839][   C82] Code: 48 e8 b9 cd fe ff 85 c0 0f 84 a9 00 00 00 41 f6 84 24 a4 01 00 00 80 0f 84 9a 00 00 00 4c 89 ef e8 1a 2a 34 00 e9 c7 fc ff ff
> >>  <0f> 0b e9 c0 fc ff ff 0f 0b e9 b9 fc ff ff 48 8b 04 cb 48 89 84 cc
> >> [   41.225841][   C82] RSP: 0018:fffffe00012f38c0 EFLAGS: 00010046
> >> [   41.225843][   C82] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> >> [   41.225844][   C82] RDX: 0000000000000001 RSI: 0000000000000004 RDI: fffffe00012f3900
> >> [   41.225845][   C82] RBP: fffffe00013120c8 R08: 0000000000000000 R09: 0000000000000000
> >> [   20.931889][ T1340] Error: Driver 'pcspkr' is already registered, aborting...
> >> [   41.225846][   C82] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> >> [   41.225847][   C82] R13: 0000000000000000 R14: fffffe00012f3c80 R15: 0000000000000000
> >> [   41.225848][   C82] FS:  0000000000000000(0000) GS:ffff88f027c62000(0000) knlGS:0000000000000000
> >> [   21.006859][ T1512] sd 6:0:0:0: Attached scsi generic sg0 type 0
> >> [   21.013583][ T1512] sd 7:0:0:0: Attached scsi generic sg1 type 0
> >> [   41.225849][   C82] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [   41.225851][   C82] CR2: 00007ffe5571fe7c CR3: 00000040c5ae1003 CR4: 00000000007726f0
> >> [   41.225852][   C82] PKRU: 55555554
> >> [   41.225853][   C82] Call Trace:
> >> [   41.225855][   C82]  <NMI>
> >> [   41.225861][   C82]  handle_pmi_common+0x29b/0x430
> >> [   41.225865][   C82]  intel_pmu_handle_irq+0x109/0x2b0
> >> [   41.225867][   C82]  perf_event_nmi_handler+0x2a/0x70
> >> [   41.225870][   C82]  nmi_handle+0x53/0x130
> >> [   41.225873][   C82]  default_do_nmi+0x11d/0x170
> >> [   41.225876][   C82]  exc_nmi+0x106/0x1b0
> >> [   41.225878][   C82]  end_repeat_nmi+0xf/0x53
> >> [   41.225880][   C82] RIP: 0010:find_next_fd+0x2a/0xb0
> >> [   41.225883][   C82] Code: 0f 1f 44 00 00 41 54 89 f2 48 c7 c0 ff ff ff ff 49 89 fc 55 c1 ea 06 53 89 f3 48 8b 77 18 89 d9 48 d3 e0 48 f7 d0 48 0b 04 d6
> >>  <48> 83 f8 ff 74 0d 48 f7 d0 f3 48 0f bc c0 83 f8 3f 76 3a 41 8b 2c
> >> [   41.225885][   C82] RSP: 0018:ffffc90025283b90 EFLAGS: 00000206
> >> [   41.225886][   C82] RAX: 0000000000000017 RBX: 0000000000000003 RCX: 0000000000000003
> >> [   41.225887][   C82] RDX: 0000000000000000 RSI: ffff88f06d277150 RDI: ffff88f06d2770e8
> >> [   41.225888][   C82] RBP: 0000000000000400 R08: 8080808080808080 R09: 979c8d9e9a8cdfff
> >> [   41.225889][   C82] R10: fefefefefefefeff R11: 0000000000000000 R12: ffff88f06d2770e8
> >> [   41.225890][   C82] R13: 0000000000088000 R14: ffff88f06d2770c0 R15: ffff88f06d2770e8
> >> [   41.225893][   C82]  ? find_next_fd+0x2a/0xb0
> >> [   41.225896][   C82]  ? find_next_fd+0x2a/0xb0
> >> [   41.225899][   C82]  </NMI>
> >> [   41.225899][   C82]  <TASK>
> >> [   41.225900][   C82]  alloc_fd+0x55/0x130
> >> [   41.225902][   C82]  do_sys_openat2+0x5a/0xf0
> >> [   41.225905][   C82]  __x64_sys_openat+0x6d/0xb0
> >> [   41.225907][   C82]  do_syscall_64+0x7f/0x2b0
> >> [   41.225909][   C82]  ? vfs_statx+0x68/0x170
> >> [   41.225911][   C82]  ? strncpy_from_user+0x26/0xf0
> >> [   41.225914][   C82]  ? vfs_fstatat+0x75/0xb0
> >> [   41.225917][   C82]  ? __do_sys_newfstatat+0x25/0x70
> >> [   41.225919][   C82]  ? path_openat+0xb6/0x2b0
> >> [   41.225921][   C82]  ? do_syscall_64+0x7f/0x2b0
> >> [   41.225922][   C82]  ? do_filp_open+0xc3/0x170
> >> [   41.225924][   C82]  ? do_syscall_64+0x7f/0x2b0
> >> [   41.225925][   C82]  ? __cond_resched+0x1e/0x70
> >> [   41.225928][   C82]  ? check_heap_object+0x34/0x1b0
> >> [   41.225931][   C82]  ? __check_object_size+0x5c/0x130
> >> [   41.225933][   C82]  ? do_sys_openat2+0x8a/0xf0
> >> [   41.225936][   C82]  ? __x64_sys_openat+0x6d/0xb0
> >> [   41.225938][   C82]  ? clear_bhb_loop+0x30/0x80
> >> [   41.225940][   C82]  ? clear_bhb_loop+0x30/0x80
> >> [   41.225942][   C82]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >> [   41.225944][   C82] RIP: 0033:0x7eff04bb9a2d
> >> [   41.225946][   C82] Code: 48 89 54 24 e0 41 83 e2 40 75 32 89 f0 25 00 00 41 00 3d 00 00 41 00 74 24 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff ff 0f 05
> >>  <48> 3d 00 f0 ff ff 77 33 c3 66 2e 0f 1f 84 00 00 00 00 00 48 8d 44
> >> [   41.225947][   C82] RSP: 002b:00007ffe5571f7e8 EFLAGS: 00000287 ORIG_RAX: 0000000000000101
> >> [   41.225949][   C82] RAX: ffffffffffffffda RBX: 0000558b3236dbe6 RCX: 00007eff04bb9a2d
> >> [   41.225950][   C82] RDX: 0000000000080000 RSI: 00007eff04bc20b1 RDI: 00000000ffffff9c
> >> [   41.225951][   C82] RBP: 00007eff04bcd1f8 R08: 0000000000000000 R09: 0000558b3236dbe6
> >> [   41.225952][   C82] R10: 0000000000000000 R11: 0000000000000287 R12: ffffffffffffffff
> >> [   41.225953][   C82] R13: 0000000000000001 R14: 00007eff04bcc020 R15: 00007eff04bcd6b8
> >> [   41.225954][   C82]  </TASK>
> >> [   41.225955][   C82] ---[ end trace 0000000000000000 ]---
> >>
> >>
> > It looks the warning is triggered in the  "error[i] != 0" case and lead to
> > the local events[] array is not initialized. Would fix it in next version.
> >
> >
> >
> >

> From 0afc076a7836433b455c8aff15d4a3ad9631ebc2 Mon Sep 17 00:00:00 2001
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Date: Sun, 28 Sep 2025 13:50:47 +0800
> Subject: [PATCH] perf/x86/intel: Fix NULL event access waring from test robot
> 
> This patch fixes the warning about
> https://lore.kernel.org/all/202509081646.d101cfb7-lkp@intel.com/.
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/ds.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 65908880f424..ef32714cb182 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -2821,8 +2821,11 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>  		 * If collision happened, the record will be dropped.
>  		 */
>  		if (pebs_status != (1ULL << bit)) {
> -			for_each_set_bit(i, (unsigned long *)&pebs_status, size)
> +			for_each_set_bit(i, (unsigned long *)&pebs_status, size) {
>  				error[i]++;
> +				if (error[i] && !events[i])
> +					events[i] = cpuc->events[i];
> +			}
>  			continue;
>  		}
>  
> -- 
> 2.34.1
> 


--s1z7SxBGmvMBdzOA
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg-f7171f90cc3a45.xz"
Content-Transfer-Encoding: base64

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

--s1z7SxBGmvMBdzOA--
