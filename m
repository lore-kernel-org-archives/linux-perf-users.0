Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3A81C84C0;
	Fri, 18 Jul 2025 05:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752816152; cv=fail; b=EZrjUy5ucEl05qqeNCrwxWpIBdY1FnQE/Pl2XaeawMKfbXgpY1EXRW45amDXRBXfa7xSty3rtyf0q64mLFEGEy1RnoRIUGpIWp/qymGn1L2/+EhEx8wHMHuYyozzhn0q2C+yrHOKgWOHmU9buI1qXvbRQYZfYIPb6gRV1vNl9vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752816152; c=relaxed/simple;
	bh=HoVIFu4CJf0UVkCMjnTpZhnM8wOn72L4vd6XrGc36Fc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nV2qpRROmTlt1qhbE3GaklLl+HAEZyaBgZcEgUwB4pdW7RMoUQnC5IgNsaYfbzYPk3Ktzgz+bOrmdKmVoFfTlrl4LAYDjQwQQ0WO53XbhUpr2wdShcOyIu8rcyxGVQ7saIsEjjishbk3AeomFAomIkM0wKUffR8SczqlUqiSpBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UGXiL3r9; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UGXiL3r9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752816151; x=1784352151;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=HoVIFu4CJf0UVkCMjnTpZhnM8wOn72L4vd6XrGc36Fc=;
  b=UGXiL3r9+eFGuHcQKznu7qfM/eocCPEv+tp0p3iEqDgi1h/4F52WXV7+
   F3S6HkOTPvcyKoqS4mCC6vMkvDX8Y96oErjW1KMMsPH9hun0qwDbbb1HG
   SlUUrwDVv2NDeatm0eDU0jBZGkZzw1yNSxOS6wbJbcep9QrnTboGrwUwb
   takvAtC6EzHO3vuLqJFe3GSJjEHKPbxjUjgtCdOtkQPG9Se/Usqw4ijWD
   yqPHp7rwnZPRsD13jlYgUNsDOJ+9dxCTW1/P+YfdDHTkCCDl7oWL8cJv8
   YjEb1TtFKMcfBIE/kpDP9Vo7y0JnuWWra99zp39/AmW+LzWVJ9CeNsRk3
   w==;
X-CSE-ConnectionGUID: jHBO87wtT/qoLdwSmY2s4w==
X-CSE-MsgGUID: A/4sHZWBQdu2cP9ao9ZLQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="42729453"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="42729453"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 22:22:30 -0700
X-CSE-ConnectionGUID: +PGGk0XfTf6PR9uZhnxPmg==
X-CSE-MsgGUID: 04Kwc79ZTNSw7Nb8vp4nRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="158054129"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 22:22:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 22:22:29 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 22:22:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.41)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 17 Jul 2025 22:22:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/o/jnK/wkHKRkrCH/+CquXI+RmArQdNXKd6/4nkiVTX+c2MSAi0Na/cSng1bjfayoYVuH6BYLnIHpZrjntopXHYsFvnS9w3kWywgqinzXDTBzAXy70wFcZeIh+VmNZSfT1NDv6M5dO0t4bQXvt+mDlrp6/6XlES0L3KTwz3QtmAkR1xboS3T8AQfljowFZYWJFs7tRECFKTumcwRqAOXToTmDOg79I6HViOgbbKkc39YKol8NmaSuLLQ3ShRIMzDlAV9p4sEOL9TUTB1AJ3TNihZqTb3URVErsC7ZFw8SgQzg4xGUNbuoL0nAJjMiD2Spt6hG0nvHaeR6EqnHxMqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwfUoO7cin1iSGlSdARStO4LDv6a1eHQYgsCXxHY5Mk=;
 b=N/xcDj3iG6BZuoQfOgZDphOhB5YKHJaKVvQiU4UBFk1b3jJ75vsYX5DFvYcbt4ooUWM1aki6pTtL5X3++JFJ3TG4omGlboLAXovyVV7qtZUGp/YYcsSx87q7VK3PI2lDUJLYrgRw/1rfJadOAqJJG099yfntfpQ1BQlCi63Tt9/iwRfifO2UEwOdS1KNFfyTygZLvFgJcjrLOG2qSIxRWHRHHTIKkCyKfjGgZvPHSihSCUmxo6KBY3BHJxThFukpgz/XGBMEOxm4icJ76Geg/+p4mkHLBa35BWoO4wPJB3nftUrCinFgSkK5Tg/LIbYYvv2Z/2jiYsRiFm4iToinnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB8062.namprd11.prod.outlook.com (2603:10b6:510:251::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 05:22:22 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8901.018; Fri, 18 Jul 2025
 05:22:21 +0000
Date: Fri, 18 Jul 2025 13:22:12 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
CC: Kan Liang <kan.liang@linux.intel.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, "Peter Zijlstra (Intel)"
	<peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [perf] 9734e25fbf:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <aHnaBOPpo/eNEyUp@xsang-OptiPlex-9020>
References: <202507042103.a15d2923-lkp@intel.com>
 <25132107-09d6-45f2-9e09-1ebeaa1d3637@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25132107-09d6-45f2-9e09-1ebeaa1d3637@linux.intel.com>
X-ClientProxiedBy: SG2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096::13) To
 LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: b034990b-3fa3-4e5a-95fc-08ddc5bb127b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?7OY6Nl4pfUK3fZXa8b48G3KJUbJ7+igHBlnBPO4pCWEx2HGeBXSA8FARSg?=
 =?iso-8859-1?Q?o6nVJc4RTqFnBc5JufBj2Y+VL/CJdogK+CFMyE5oGYjZMeqMqQxX2aoXdg?=
 =?iso-8859-1?Q?79g4HPUez+Fm8zZuKGNXLK6zuDVni278EIyWUV3ons+dUoxBGvHLhrFR4T?=
 =?iso-8859-1?Q?NgYJCUmlMyjzNc6OIYfbXeZhy8Y786V60NUouqc2Mba0ClKq6JiYAGh4nE?=
 =?iso-8859-1?Q?yNaJhdAB8ACOUyazL9XHFq4lGdw1MnMYzxXbZSEBODBVyb1j3/bin3ZHg+?=
 =?iso-8859-1?Q?IWwJlRy+s4UvavrlCj6JzNVIbFN/VoPhEFC3HSr1ljh3cTTXLUWr8Y5FaF?=
 =?iso-8859-1?Q?TzEzP4xzyL/r6i1RtBzKHn1dDwQ3ym34StrTu/8nCvpBsJCVuU1MMrNGRk?=
 =?iso-8859-1?Q?jc3dyUi79oK+gdk4zvsGVOlH/vP3PA/auf8zNwkU1t0+N5pqelE3OGzPj8?=
 =?iso-8859-1?Q?mBgV1UUe/O8tpMZZrrBqmrnq2reDXkzRvxdRRlZu4YzprYgyrVFhizU28Y?=
 =?iso-8859-1?Q?4WimMeH9HPXbKe5ASNYiLR+trajXDmSaV951eEdHGgekYgsDAmDG4crdGX?=
 =?iso-8859-1?Q?O6Q6P2QTPnFb+hN2Dwdg/xkoMeFI5WSRPd18u7rK+kKAoqfNF7+rfjh7G9?=
 =?iso-8859-1?Q?NkoeUGdqGl4SQ3okSp1/iUo+Oax9IMli+W3+BNC4Tke2708wZv154OsUKr?=
 =?iso-8859-1?Q?RoyzGgY3xz3q1mt4sPyhBkUDj8ypz2pLKFaTNHwuqD4LyE+/JgwmoikzBp?=
 =?iso-8859-1?Q?5Pu1R/yQ7XajgFUTEQ8yvhnS0JkTrzrOrNjMqkz7V4QIoI4svVn3QpWvTa?=
 =?iso-8859-1?Q?vN2Wj/14g9RXj6jBCOdnNrdZ6KiwriPE9v7MvqZV63wIigt3p25SWPuWGo?=
 =?iso-8859-1?Q?PYiG+7fEgLoWnWHZopWV7nTU/Mox/uWFpyTy9OpDY5J9CjTyOa2Qyl6hDT?=
 =?iso-8859-1?Q?utMrPazL07rSumtYC+9f+F5qCb+UX9ZAGl/M8XH5eT79zAsqjPx6TJZ+1m?=
 =?iso-8859-1?Q?/wu8hzzfQtOzO9dgOcsM7Tkr6M/oUXou6O4BH/zTUM3gcJiwXbHHkcmTVw?=
 =?iso-8859-1?Q?uqJhTU8T64uQx/U7W6HKzJf8f/r8PPYqN0dsQWpsbmshGQ9KC6wmsfEfBu?=
 =?iso-8859-1?Q?IQdHSgl0aCnk/tgzPknC243gZsALT9unwwX5JHoluTq5DaiX1l/MuETnS4?=
 =?iso-8859-1?Q?lG6t/is0ULJTRmWUUPZ6Pl+p+JL5j0l6qfoCAgujepLbtIK2CBjPb/2GdH?=
 =?iso-8859-1?Q?UCpu8L/TZwZ0Iyymur5mJoT9sgkBOzNQP29v0+juNr9xllSxIkVwajp4+A?=
 =?iso-8859-1?Q?KeB1DXHMmY6/JDycI/4hdlrapMpXjyNn/JKsQUq7iP14ALo5ll7TF9571P?=
 =?iso-8859-1?Q?adkm54NotYi9Jlz8y3BeEpA3v87pM4ZyLsVhBho4xdUL6jSPjGBTKP85dr?=
 =?iso-8859-1?Q?hEeHg83IIFbl8OeY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8vyGem7t3gJtugdePrJtWDqkDsPPqlzYO0BumxQcrTd9/kNdSINQ9Elrx5?=
 =?iso-8859-1?Q?KhxnbizMSo3FMxCblC2q5/A9MFDlZ9EFMGlycdKHCy4KR4zvzoaknJyAxR?=
 =?iso-8859-1?Q?KRBzTo65p9gS1nP6cF6NAsB4dEgN6luU7Q8PqwrCebN5yVUOD/rqodpTOx?=
 =?iso-8859-1?Q?kq0pbSB7YYqG+nsRKS9onfwWLba4xUu4ZLamhuf2zuFUekbJt9+834HsMs?=
 =?iso-8859-1?Q?pDnDOtHsdoBLWYt0VcFxYx3RpjF5Czhv2wgEbLQfQNNWB9Nh8jmPnbxrg2?=
 =?iso-8859-1?Q?PlRFvcT8ORowKupu1RcJmOikvgXWdaBtRmacFUPfE3YmWEbE8usegt7crI?=
 =?iso-8859-1?Q?ZOGwoerlXkoY5f3nDUKkEAPofs+yGBrZ2LU5/ziQ7DKya234B9agTlMOw2?=
 =?iso-8859-1?Q?S7X3Yww37EoAMSpFnVfNaShKePoBSAZcTlcIOGjL8kZu+G7DUnPS62oMQ4?=
 =?iso-8859-1?Q?qtljjBOj2B8qZ7V4tsW1KVtuWQ+0pOEWoa9MgbQJtXSIMzHauZtFBSMrRS?=
 =?iso-8859-1?Q?G6V8iSzJ8B582OyNjo5RYyafjtzHpSa8O7q8b78ynw7VUmhrWp5awFNPW6?=
 =?iso-8859-1?Q?wKGE26PK+3wrCik3VGRJmZ1Lm3wWIznHCaSF7Z/Ox+RJU034rVDyAYKjgU?=
 =?iso-8859-1?Q?VhPYjkDv2buNvm2/hV6p8bkkrdBBtiEZZKCmFM4SyZTgruXUNaBpCrPPmU?=
 =?iso-8859-1?Q?aJxGyk53ZT9oQysqZs3CzcuvG0Heq8ACVnGu/EGgmb937YQwXAoNOrYF6N?=
 =?iso-8859-1?Q?1Lv91BZIIgWBfd0+bmlDnWelzThFfsibnhM60TlizhzwC4uSk4x4vOzBMM?=
 =?iso-8859-1?Q?k2yOKfOqWZvnPXGaoMra44lIgr+dSTG2uu2pNsRVVG9uCu8lJKlMT5HMgb?=
 =?iso-8859-1?Q?CgVvUovptuqry2eEy45Lu8c9T+3iGxUjonRis+/xvHTWiW6O7rBKm+tkbe?=
 =?iso-8859-1?Q?b2HbOiTAI4EqON3d6QGdCEZDlK2SvT/WWqP7wUVoMv101VIVhej6839Xj7?=
 =?iso-8859-1?Q?evWbDaD9KeudUTI0rqUnQKhBTpOdHv5ltTJK0wIdo14rldATeVojG3hhX/?=
 =?iso-8859-1?Q?jWWmcMlAHJKN/0ZBJzu9LSZFD8chBq+3ysnvDPoEG6FHAvXWH2rdhXdXuW?=
 =?iso-8859-1?Q?wC91tTWW9EaFgwtoJdKdr2ojUMSG5sayS6oM4SdpcjCXSvasGmY9eZUgic?=
 =?iso-8859-1?Q?VzS8IK90Icq9PCkinTWytCUGhK6soM+NE3OdUxxyhIWUy5MCl6PXl+R78J?=
 =?iso-8859-1?Q?koVRWdC4RFzonTExORIs11mi2TfwKX/ecqE+/HqUf98wn5NF6kN1khqz5X?=
 =?iso-8859-1?Q?N0h8OBN9ZURVHdslDzLsJ91AKePEwW3vubNHd7hOD6T/e9G5zfNLd6jzhG?=
 =?iso-8859-1?Q?sdUE06m/u9CxopL7LDsnteaQxhpXwXxEdGfv1DB4oHdWpqFIR4ItqBo5QQ?=
 =?iso-8859-1?Q?+xxORaqooEWbPN+9pfo0czDQAoorJ/Kwo6sp+3V7a6eyxCem0o7geUFxmt?=
 =?iso-8859-1?Q?T0FUfIgAn10JIrczRnTmOyCAAUTK7Q9XrywCgpImlikXPJ7qR8/hh/8gmy?=
 =?iso-8859-1?Q?Dw3hsrD8f2cvOlwi0oKhGDoyu2rfRX3khog3eROFSgV7uvvUzspKu29rjQ?=
 =?iso-8859-1?Q?BNl+mComJbl1W7U3xdrD5YoB62qspcQ/hytZRQ+MkaDcC01wKdD5oAjQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b034990b-3fa3-4e5a-95fc-08ddc5bb127b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 05:22:21.8870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1a7I7UpQ8lUGhmbHJPoIPw9kYYtwT+q3fHLvNv1EaxyBfRmfomJKAei3D8W77XSiaY6PJWLKOxx9xR4kFUEF9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8062
X-OriginatorOrg: intel.com

hi, Dapeng,

On Tue, Jul 08, 2025 at 05:54:59PM +0800, Mi, Dapeng wrote:
> Base on the call trace, it looks the bug is directly caused by the below
> code in setup_pebs_adaptive_sample_data().
> 
> sample_type = event->attr.sample_type;
> 
> the "event" pointer becomes NULL accidentally when running this code and
> trigger an invalid memory access.
> 
> The helper setup_pebs_adaptive_sample_data() is only called by helper
> intel_pmu_drain_pebs_icl(), the "event" pointer comes from the below
> assignment.
> 
> event = cpuc->events[bit];
> 
> It looks the "cpuc->events[bit]" is assigned to NULL as some reason when
> the issue happens.
> 
> Since I can't reproduce this issue locally, so I can't certainly say what
> caused the issue, but 0day figures out the issue should be introduced by
> the commit '9734e25fbf5a ("perf: Fix the throttle logic for a group")'.
> Just go through this commit, the most probably place causing this issue is
> the below code.
> 
> @@ -10084,8 +10111,7 @@ __perf_event_account_interrupt(struct perf_event
> *event, int throttle)
>         if (unlikely(throttle && hwc->interrupts >= max_samples_per_tick)) {
>                 __this_cpu_inc(perf_throttled_count);
>                 tick_dep_set_cpu(smp_processor_id(), TICK_DEP_BIT_PERF_EVENTS);
> -               hwc->interrupts = MAX_INTERRUPTS;
> -               perf_log_throttle(event, 0);
> +               perf_event_throttle_group(event);
>                 ret = 1;
>         }
> 
> With this change, all events in the group could be possible to be stopped.
> The call chain is perf_event_throttle_group() -> perf_event_throttle() ->
> event->pmu->stop() -> x86_pmu_stop(). In x86_pmu_stop() , the event would
> be disabled and corresponding item in cpuc->events[] array is cleared to NULL.
> 
>     if (test_bit(hwc->idx, cpuc->active_mask)) {
>         static_call(x86_pmu_disable)(event);
>         __clear_bit(hwc->idx, cpuc->active_mask);
>         cpuc->events[hwc->idx] = NULL;
>         WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
>         hwc->state |= PERF_HES_STOPPED;
>     }
> 
> The __perf_event_account_interrupt() helper could be called in PMI handler
> (perf_event_overflow() -> __perf_event_overflow() ->
> __perf_event_account_interrupt()) and PMI is a NMI on x86 platform. So PMI
> handler could interrupt perf code (like setup_pebs_adaptive_sample_data())
> and clear the cpuc->events[hwc->idx] and
> then setup_pebs_adaptive_sample_data() finds the cpuc->events[bit] is NULL
> and crashes.
> 
> @Oliver, I would cook a patch to add NULL check for cpuc->events[*] pointer
> before accessing it. Could you please help to verify it? Thanks.

we tested your patch and confirmed it could fix the issue we observed. thanks
a lot!

Tested-by: kernel test robot <oliver.sang@intel.com>

> 
> 
> On 7/4/2025 9:52 PM, kernel test robot wrote:
> > Hello,
> >
> > kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:
> >
> > commit: 9734e25fbf5ae68eb04234b2cd14a4b36ab89141 ("perf: Fix the throttle logic for a group")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > [test failed on linus/master      66701750d5565c574af42bef0b789ce0203e3071]
> > [test failed on linux-next/master 3f804361f3b9af33e00b90ec9cb5afcc96831e60]
> > [test failed on fix commit        bc4394e5e79cdda1b0997e0be1d65e242f523f02]
> >
> >
> > in testcase: stress-ng
> > version: stress-ng-x86_64-f76f86ffb-1_20250412
> > with following parameters:
> >
> > 	nr_threads: 100%
> > 	testtime: 60s
> > 	test: memthrash
> > 	cpufreq_governor: performance
> >
> >
> >
> > config: x86_64-rhel-9.4
> > compiler: gcc-12
> > test machine: 192 threads 2 sockets Intel(R) Xeon(R) Platinum 8468V  CPU @ 2.4GHz (Sapphire Rapids) with 384G memory
> >
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> >
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202507042103.a15d2923-lkp@intel.com
> >
> >
> > [   93.379225][  C143] BUG: kernel NULL pointer dereference, address: 00000000000000f0
> > [   93.379247][  C143] #PF: supervisor read access in kernel mode
> > [   93.379253][  C143] #PF: error_code(0x0000) - not-present page
> > [   93.379259][  C143] PGD 161558067 P4D 0
> > [   93.379263][  C143] Oops: Oops: 0000 [#1] SMP NOPTI
> > [   93.379274][  C143] CPU: 143 UID: 0 PID: 3944 Comm: perf Not tainted 6.15.0-rc3-00069-g9734e25fbf5a #1 VOLUNTARY
> > [   93.379281][  C143] Hardware name: KAYTUS NF5280-M7-A0-R0-00/NF5280-M7-A0-R0-00, BIOS 06.08.01 12/24/2024
> > [ 93.379286][ C143] RIP: 0010:setup_pebs_adaptive_sample_data (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/events/intel/ds.c:2083) 
> > [ 93.379325][ C143] Code: 04 24 48 85 d2 0f 84 81 02 00 00 49 89 d5 49 89 fe 49 89 f4 48 89 ce 49 c7 80 a8 00 00 00 00 00 00 00 8b 02 4c 89 c5 48 89 cb <4c> 8b bf f0 00 00 00 89 44 24 0c 48 89 44 24 10 48 8b 87 08 02 00
> > All code
> > ========
> >    0:	04 24                	add    $0x24,%al
> >    2:	48 85 d2             	test   %rdx,%rdx
> >    5:	0f 84 81 02 00 00    	je     0x28c
> >    b:	49 89 d5             	mov    %rdx,%r13
> >    e:	49 89 fe             	mov    %rdi,%r14
> >   11:	49 89 f4             	mov    %rsi,%r12
> >   14:	48 89 ce             	mov    %rcx,%rsi
> >   17:	49 c7 80 a8 00 00 00 	movq   $0x0,0xa8(%r8)
> >   1e:	00 00 00 00 
> >   22:	8b 02                	mov    (%rdx),%eax
> >   24:	4c 89 c5             	mov    %r8,%rbp
> >   27:	48 89 cb             	mov    %rcx,%rbx
> >   2a:*	4c 8b bf f0 00 00 00 	mov    0xf0(%rdi),%r15		<-- trapping instruction
> >   31:	89 44 24 0c          	mov    %eax,0xc(%rsp)
> >   35:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
> >   3a:	48                   	rex.W
> >   3b:	8b                   	.byte 0x8b
> >   3c:	87 08                	xchg   %ecx,(%rax)
> >   3e:	02 00                	add    (%rax),%al
> >
> > Code starting with the faulting instruction
> > ===========================================
> >    0:	4c 8b bf f0 00 00 00 	mov    0xf0(%rdi),%r15
> >    7:	89 44 24 0c          	mov    %eax,0xc(%rsp)
> >    b:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
> >   10:	48                   	rex.W
> >   11:	8b                   	.byte 0x8b
> >   12:	87 08                	xchg   %ecx,(%rax)
> >   14:	02 00                	add    (%rax),%al
> > [   93.379327][  C143] RSP: 0018:fffffe00021028f0 EFLAGS: 00010082
> > [   93.379332][  C143] RAX: 0000000000000001 RBX: fffffe0002102c80 RCX: fffffe0002102c80
> > [   93.379338][  C143] RDX: fffffe0002121040 RSI: fffffe0002102c80 RDI: 0000000000000000
> > [   93.379340][  C143] RBP: fffffe0002102970 R08: fffffe0002102970 R09: 0000000000000001
> > [   93.379345][  C143] R10: 0000000000000013 R11: 0000000000000008 R12: fffffe0002102ef8
> > [   93.379349][  C143] R13: fffffe0002121040 R14: 0000000000000000 R15: ff110001a0a69500
> > [   93.379356][  C143] FS:  00007f539e726840(0000) GS:ff1100303c39f000(0000) knlGS:0000000000000000
> > [   93.379359][  C143] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   93.379362][  C143] CR2: 00000000000000f0 CR3: 0000000180052002 CR4: 0000000000f73ff0
> > [   93.379363][  C143] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [   93.379364][  C143] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> > [   93.379365][  C143] PKRU: 55555554
> > [   93.379366][  C143] Call Trace:
> > [   93.379377][  C143]  <NMI>
> > [ 93.379380][ C143] ? x86_perf_event_set_period (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/events/core.c:1442) 
> > [ 93.379410][ C143] intel_pmu_drain_pebs_icl (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/events/intel/ds.c:2356 kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/events/intel/ds.c:2666) 
> > [ 93.379424][ C143] ? shmem_write_end (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/include/asm/bitops.h:55 kbuild/obj/consumer/x86_64-rhel-9.4/include/asm-generic/bitops/instrumented-atomic.h:29 kbuild/obj/consumer/x86_64-rhel-9.4/include/linux/page-flags.h:835 kbuild/obj/consumer/x86_64-rhel-9.4/mm/shmem.c:3319) 
> > [ 93.379436][ C143] handle_pmi_common (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/events/intel/core.c:3206) 
> > [ 93.379440][ C143] ? shmem_write_end (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/include/asm/bitops.h:55 kbuild/obj/consumer/x86_64-rhel-9.4/include/asm-generic/bitops/instrumented-atomic.h:29 kbuild/obj/consumer/x86_64-rhel-9.4/include/linux/page-flags.h:835 kbuild/obj/consumer/x86_64-rhel-9.4/mm/shmem.c:3319) 
> > [ 93.379443][ C143] ? set_pte_vaddr_p4d (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/mm/init_64.c:307 kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/mm/init_64.c:315) 
> > [ 93.379462][ C143] ? flush_tlb_one_kernel (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/include/asm/paravirt.h:85 kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/mm/tlb.c:1544 kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/mm/tlb.c:1499) 
> > [ 93.379489][ C143] ? native_set_fixmap (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/mm/pgtable.c:652 kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/mm/pgtable.c:661) 
> > [ 93.379492][ C143] ? ghes_copy_tofrom_phys (kbuild/obj/consumer/x86_64-rhel-9.4/drivers/acpi/apei/ghes.c:345) 
> > [ 93.379500][ C143] ? __ghes_peek_estatus+0x49/0xb0 
> > [ 93.379503][ C143] intel_pmu_handle_irq (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/include/asm/msr.h:86 kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/include/asm/msr.h:120 kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/events/intel/core.c:2504 kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/events/intel/core.c:3351) 
> > [ 93.379507][ C143] perf_event_nmi_handler (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/events/core.c:1767 kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/events/core.c:1753) 
> > [ 93.379518][ C143] nmi_handle (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/kernel/nmi.c:184) 
> > [ 93.379529][ C143] default_do_nmi (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/kernel/nmi.c:152 kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/kernel/nmi.c:393) 
> > [ 93.379541][ C143] exc_nmi (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/kernel/nmi.c:588) 
> > [ 93.379545][ C143] end_repeat_nmi (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/entry/entry_64.S:1409) 
> > [ 93.379558][ C143] RIP: 0010:shmem_write_end (kbuild/obj/consumer/x86_64-rhel-9.4/mm/shmem.c:3321) 
> > [ 93.379564][ C143] Code: 48 8b 13 83 e2 08 75 41 48 8b 13 83 e2 40 ba 00 10 00 00 74 0c 0f b6 4b 40 ba 00 10 00 00 48 d3 e2 48 39 d0 72 25 f0 80 0b 08 <48> 89 df e8 23 fd fd ff 48 89 df e8 db 1e fd ff f0 ff 4b 34 74 54
> > All code
> > ========
> >    0:	48 8b 13             	mov    (%rbx),%rdx
> >    3:	83 e2 08             	and    $0x8,%edx
> >    6:	75 41                	jne    0x49
> >    8:	48 8b 13             	mov    (%rbx),%rdx
> >    b:	83 e2 40             	and    $0x40,%edx
> >    e:	ba 00 10 00 00       	mov    $0x1000,%edx
> >   13:	74 0c                	je     0x21
> >   15:	0f b6 4b 40          	movzbl 0x40(%rbx),%ecx
> >   19:	ba 00 10 00 00       	mov    $0x1000,%edx
> >   1e:	48 d3 e2             	shl    %cl,%rdx
> >   21:	48 39 d0             	cmp    %rdx,%rax
> >   24:	72 25                	jb     0x4b
> >   26:	f0 80 0b 08          	lock orb $0x8,(%rbx)
> >   2a:*	48 89 df             	mov    %rbx,%rdi		<-- trapping instruction
> >   2d:	e8 23 fd fd ff       	call   0xfffffffffffdfd55
> >   32:	48 89 df             	mov    %rbx,%rdi
> >   35:	e8 db 1e fd ff       	call   0xfffffffffffd1f15
> >   3a:	f0 ff 4b 34          	lock decl 0x34(%rbx)
> >   3e:	74 54                	je     0x94
> >
> > Code starting with the faulting instruction
> > ===========================================
> >    0:	48 89 df             	mov    %rbx,%rdi
> >    3:	e8 23 fd fd ff       	call   0xfffffffffffdfd2b
> >    8:	48 89 df             	mov    %rbx,%rdi
> >    b:	e8 db 1e fd ff       	call   0xfffffffffffd1eeb
> >   10:	f0 ff 4b 34          	lock decl 0x34(%rbx)
> >   14:	74 54                	je     0x6a
> > [   93.379572][  C143] RSP: 0018:ffa00000187bfd48 EFLAGS: 00000206
> > [   93.379575][  C143] RAX: 0000000000001000 RBX: ffd4000005435680 RCX: 0000000001128000
> > [   93.379580][  C143] RDX: 0000000000001000 RSI: 0000000001127000 RDI: ff1100011221d8c0
> > [   93.379580][  C143] RBP: 0000000000001000 R08: 0000000000001000 R09: ffd4000005435680
> > [   93.379581][  C143] R10: 0000000000000001 R11: 0000000000000003 R12: ff1100014115e5d0
> > [   93.379588][  C143] R13: 0000000000001000 R14: 0000000000000000 R15: 0000000000001000
> > [ 93.379592][ C143] ? shmem_write_end (kbuild/obj/consumer/x86_64-rhel-9.4/mm/shmem.c:3321) 
> > [ 93.379600][ C143] ? shmem_write_end (kbuild/obj/consumer/x86_64-rhel-9.4/mm/shmem.c:3321) 
> > [   93.379604][  C143]  </NMI>
> > [   93.379605][  C143]  <TASK>
> > [ 93.379607][ C143] generic_perform_write (kbuild/obj/consumer/x86_64-rhel-9.4/mm/filemap.c:4124) 
> > [ 93.379633][ C143] shmem_file_write_iter (kbuild/obj/consumer/x86_64-rhel-9.4/mm/shmem.c:3464) 
> > [ 93.379636][ C143] vfs_write (kbuild/obj/consumer/x86_64-rhel-9.4/fs/read_write.c:591 kbuild/obj/consumer/x86_64-rhel-9.4/fs/read_write.c:684) 
> > [ 93.379644][ C143] ksys_write (kbuild/obj/consumer/x86_64-rhel-9.4/fs/read_write.c:736) 
> > [ 93.379651][ C143] do_syscall_64 (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/entry/syscall_64.c:63 kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/entry/syscall_64.c:94) 
> > [ 93.379656][ C143] ? exc_page_fault (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/include/asm/irqflags.h:37 kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/include/asm/irqflags.h:114 kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/mm/fault.c:1488 kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/mm/fault.c:1538) 
> > [ 93.379659][ C143] entry_SYSCALL_64_after_hwframe (kbuild/obj/consumer/x86_64-rhel-9.4/arch/x86/entry/entry_64.S:130) 
> > [   93.379662][  C143] RIP: 0033:0x7f53aa05f27f
> > [ 93.379672][ C143] Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 39 d5 f8 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 8c d5 f8 ff 48
> > All code
> > ========
> >    0:	89 54 24 18          	mov    %edx,0x18(%rsp)
> >    4:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
> >    9:	89 7c 24 08          	mov    %edi,0x8(%rsp)
> >    d:	e8 39 d5 f8 ff       	call   0xfffffffffff8d54b
> >   12:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
> >   17:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
> >   1c:	41 89 c0             	mov    %eax,%r8d
> >   1f:	8b 7c 24 08          	mov    0x8(%rsp),%edi
> >   23:	b8 01 00 00 00       	mov    $0x1,%eax
> >   28:	0f 05                	syscall
> >   2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
> >   30:	77 31                	ja     0x63
> >   32:	44 89 c7             	mov    %r8d,%edi
> >   35:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
> >   3a:	e8 8c d5 f8 ff       	call   0xfffffffffff8d5cb
> >   3f:	48                   	rex.W
> >
> > Code starting with the faulting instruction
> > ===========================================
> >    0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
> >    6:	77 31                	ja     0x39
> >    8:	44 89 c7             	mov    %r8d,%edi
> >    b:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
> >   10:	e8 8c d5 f8 ff       	call   0xfffffffffff8d5a1
> >   15:	48                   	rex.W
> >
> >
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20250704/202507042103.a15d2923-lkp@intel.com
> >
> >
> >
