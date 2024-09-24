Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4C39463;
	Tue, 24 Sep 2024 02:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727146009; cv=fail; b=XCd5A83+nAwPoHHd6NwwvZPhbW/qW1fuSF+QA/qe2qWphCI4KwvziKbxgGP98l1kuuBgKsK/SGdai2knZ0DkFIZEKhbaY9eU9bh8Uwd+e5UVIlXp4pAWM+Hml0WbelnPOs5rMEQpMW8WjEpvT2EltrBTvb91FDK2TO6oh0x2G+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727146009; c=relaxed/simple;
	bh=gfx8jM5PUJYsR6XoxSZXi5404Omf51jCai5+yf2XXlE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ei2pgbHtpGWiV0D6JwCqjsQxWZqr1+xfFHtNpNNxqegLAr0hJdDbnFr9A8v3cq5eK8gd3sLxJ4FMklHbG9GN5k7EIfrWgcMG2KDFR41JCgjhqFf0xVXw5Kzl+jSc+59xkxOY29YAc63QTW3XMY2z/eAbfilOodGK61LfA3CbJ5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lLfJa6wn; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lLfJa6wn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727146008; x=1758682008;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=gfx8jM5PUJYsR6XoxSZXi5404Omf51jCai5+yf2XXlE=;
  b=lLfJa6wnpLdt/5CiyQ9vsQxw8ynovGjE1IDlWAkWZZb4LxhcoybJi57L
   bVT7WgtaN997fif8mXWs32Emy71dWeSAt7uYmvrMLVNIABEbw3oFI72zG
   f58yOYwIkBNYbiux3RuSYPp8xY4bZKrnTltobyNZbI1AzG85al5xgGguj
   65EtcChknSpH63cw2jjupe+AD6uQ/bS8M9UIGkh3tr/RPD+a9/wo8iG9o
   VhDyAahpCE+mtwerzGthLVPYqc3sftrDNrD0LwPQT7Fbr6yFMkPgjwz+K
   B6zW05KqcUWutt1GZLx7jHWokw3vX9RxtSKKx99BVFamcYvn4j/KKKm9F
   A==;
X-CSE-ConnectionGUID: 7IY1NB5QQjygr/jphxG0Jg==
X-CSE-MsgGUID: oHCLUEO6T029kxIV/nov1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="25596549"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="25596549"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 19:46:47 -0700
X-CSE-ConnectionGUID: 3QMcxGlyQ6u0g/JKTdjZlA==
X-CSE-MsgGUID: aw6zmFm5SW28EUtyYLAg1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="108704346"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Sep 2024 19:46:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 19:46:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 19:46:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 23 Sep 2024 19:46:46 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 19:46:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyVzuaA2gnxvZNjx/6jNJ4YSxeI2QUVsyLCtP2hrreThdVGVttJaR9kb/g2OZTSIQQTLi1D7KIcfOrnjncIWUn4NGQpVijsF1BM0nqe/uFTk4w7LFXX1JLk+xudRZ1NumbkB6jMbWi4zZ/L9dDSwSHgltlzWNkuK3Z7tUzV51ELzGjl2IE6npRXlcL/vxr6ew+Gr/fJgcP2giZ9I1h5jw2n+19k/l2FzjnFthxH9nXv/hSZ7HFRGxECDuZCkmgpdpK0N7VAPWH40NTtEJQG3+mmKMNPabauJSlBeZETz6NgVki6krfGKyHyd0CeKdGH1+6sSSlDKEcIhMAfRhDoYJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5XCoqz4aYBE6k9hXLYG3W0yy55/Ya5Pe9hY6L/12FI=;
 b=Cqa1DaqwtGfEsDr+IfwNVgwsAOXc6dpljxpuV4x5+dnSNVacKh9sK3Fjja6uA12rEydKBRz/SoFy4hA3TGd504Y8qYJseeH9fnogDr4u4ePt7Q/ojOaoh+ZbJwFEm8zin8NqYCZ8K1y44kKkUlvLIx4XgXAKeWHaIGsZ/vPumIU/LKoqzkUpvV8bb8VhG1g2u0If5kE4TJB/HRZX2G6kgitA0Z36lA0nDCC3HLge+MUgOYedY0w1IQqNrIX68zqd1dnbkWBkab3NtZmUyu83aXk34kkZu6sHKCGJ8NLkThzUq5qLQSn9lSfD/2kzPTXkjMYqFn+BFTm6Ay+6F1TvDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 by PH0PR11MB7494.namprd11.prod.outlook.com (2603:10b6:510:283::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 02:46:44 +0000
Received: from SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125]) by SJ2PR11MB8587.namprd11.prod.outlook.com
 ([fe80::4050:8bc7:b7c9:c125%3]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 02:46:44 +0000
Date: Tue, 24 Sep 2024 10:46:36 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
CC: "Liang, Kan" <kan.liang@linux.intel.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Li Huafei <lihuafei1@huawei.com>,
	<linux-perf-users@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [perf/x86/intel] 25dfc9e357:
 kvm-unit-tests-qemu.pmu.fail
Message-ID: <ZvIoDCpLW6kX8pFw@xsang-OptiPlex-9020>
References: <202409201525.4877023e-oliver.sang@intel.com>
 <f272389f-8565-4bdc-8727-8b37eaa82821@linux.intel.com>
 <ZvDvB98DW10Au8lo@xsang-OptiPlex-9020>
 <196706e4-e892-4e73-8ba7-1fa939d8998b@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <196706e4-e892-4e73-8ba7-1fa939d8998b@linux.intel.com>
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8587:EE_|PH0PR11MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fbaa07b-dde3-4e24-86ca-08dcdc431ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y6SKewY8Osw0wlsROQ0PpCC1rlaAH8r1bzC6dbPOjFTOy4MskRWGz3wtUx1M?=
 =?us-ascii?Q?JH9N+vGAN3Dq8TsjVxcREQYP2urme4H6CTXaXlgwqySGwJP2b7Ffh6MWSOjK?=
 =?us-ascii?Q?uUKAWOWfYcQE6nbDGT4DKgZnvIcCaRU9t3NF1kuFVBuOik12CwOpPyJ2hsRg?=
 =?us-ascii?Q?zV/Ot9QK9Ktrm21AUlEQK5n1x1oMO417zFJsKkC1qWEBNKAh8bozie4dRTr/?=
 =?us-ascii?Q?gX3Q0M7vHKR/a8HRJ/MmVwTx4rmFhnqhbe8Ij16tE8K4qlFbq0q4qO8iD4RT?=
 =?us-ascii?Q?2N/tncOzzM9JlnF0hQyNsrcmz/wU0Ce7QZRdpirZyUJ9kW5IATfJEpjTdnAf?=
 =?us-ascii?Q?XQ4I5rEsx+05g+J/lV9gzvKmNDodPzN4IofuNkYWNDx8s8AqQj5QteQtNwyk?=
 =?us-ascii?Q?+vJVFGsrMS8wsBXdpoRsLpryrqWpeFuHWcxSw19EYgQB+K1KX+L/rBzduC+4?=
 =?us-ascii?Q?jyHtXlyxZu3Fi4pwBU9zNaDgyrHM2PENcNyv5jv5I5UqxzWjZ4sZ9JAcVWol?=
 =?us-ascii?Q?G/Z/jYcEk1UvN9l41vGaUCT09jwbtn7MObe4api6zCu8igaLKOFbD5lKKIHe?=
 =?us-ascii?Q?VbV/rgqFkqlXwuhYY7nMt4T1tJmqTMPMLhHzVXzBScHPWV4Gk1cM0YOgvw90?=
 =?us-ascii?Q?4Q/K07eoXRnWn/2uvqW62s3CLRrNghBZ618HTA1c4UKf25U77LmcJRSy4LyA?=
 =?us-ascii?Q?CkVlrbXfid6GIeoTdpDk0Q75SnxMq2maHKfiUmP4k/SFBecHqXpPFhLFb8i5?=
 =?us-ascii?Q?JhIXHpmaifEH58djZvFen0WKAT0OB9gvJYfxGUWBlmyDE2QF8ZsiBAxy1qn1?=
 =?us-ascii?Q?Bxxvn+QEBW7OICsLQrFxogwrkjjO5g+K5EXwXLFe4iuTD7fTKy8r1ZIgyxb1?=
 =?us-ascii?Q?EdidDV00hOFXtUsvoRjqp4f8IUFiILcfGlXQqchUCElWz8C60IFTsoFqi094?=
 =?us-ascii?Q?6wbXK+p8qgqlKZSW0WwRx1/Q3ssKPIOd0ZxrZSozxTCKcdM/56WxSDjuyiL9?=
 =?us-ascii?Q?fYavo/lMh7+VSZItRp2tjOrcIEh3YeQoxaCYceTEB247OL3ucpYfm7lAJ8jc?=
 =?us-ascii?Q?5jge6bR1rEbexhW6jazzgjRZT7Wl3G6j8tcS1AHBtD59kxauWWZrztfsOHO7?=
 =?us-ascii?Q?fVr9PwXHVpCphrgXrAIy39L7/JShYqzlLoWMnclTpWbaK8UkSYM8+2kzZZ/Z?=
 =?us-ascii?Q?KO6AfALmE2gP+h4DibroVtwlLP7EHyf/4NkXPalpfy/u3nb9puuWpOl36QRJ?=
 =?us-ascii?Q?2scfDP8Clbhs8byThOL6BquXYWeFxmMsV9c+pqUW6w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hbksC/RVlAaoMsvbhnR+PkS+jLL+L42DtEuZQ7hW9M4gYxfRmB/a41QzO67Y?=
 =?us-ascii?Q?5ug0Ek5VXVNQrDWUykl5mQUvVzwIZ5HOVpS0vF5FE1spmb2oNZrK/+ZzrhWv?=
 =?us-ascii?Q?i7NBWdjIMw+3jAPwUJoT7rwr0QwCRTNr9n7kG7UeUDi8VaBjUcpOJ4WO4hzd?=
 =?us-ascii?Q?ZXOUqriI3PdxK/2eIJ582puIH5sSW2/wroQgRCXY1c29Xqoz5drIMbvNoa8m?=
 =?us-ascii?Q?LcjiV04gxwekyR4X9gIpA8yiW0FneWWMWNgwvUdPdf/0lVnLu8Pb8haLEkmv?=
 =?us-ascii?Q?OdHsCAcjbRccrL/cH8FFu+BXCQ7rXeAIutYCb2HAN+Q0BeydivSSAWbyczhd?=
 =?us-ascii?Q?VDdtKw+5mO/36kZo7Kqqf6PtbtBp/Wu4ZvkEDPvCpxSGMA6mXnO1eMW/Hmac?=
 =?us-ascii?Q?JTDlfIgT2carHnmOFE+6s3mNskCOcYY+WH25rKMD2s/yLfuc+y0Rs2i2xdzN?=
 =?us-ascii?Q?YFYnFaV+L7soy+waY5fxwF4/lgMRaNsIDEyLjwKDc9XFCbu3b35+xyJLOY1J?=
 =?us-ascii?Q?FVRuP07HttjsPSbPfwVrZpuRAnLn5r/v8dejkjwKMAadi15fpMBztVDQ5zRN?=
 =?us-ascii?Q?cMpVZQB2dIiQHYNMAawyNfJd4DMxsqlyed1moGVE9m8JjYWrVaTzxFlQIOqY?=
 =?us-ascii?Q?i8PdH07HHcZWxTFamM1jlhUM7P8ha47xbAm27oyDKErqZXzQa5iEPB+AU4oF?=
 =?us-ascii?Q?5pXwERztp8iSxv23RpyflyewagJ1cmDR/JnC25cWmKnxn6dPOn0JmAk2ADAD?=
 =?us-ascii?Q?AhUIF9vs7hh8SZlM3+Xlhcc4x1UiLy9sk9xMVId51ylAwcPx/oW9zbesStbL?=
 =?us-ascii?Q?oDu8i7fwJGzL2JeAbc9DNIRaSfGoIXeU/mhKBjBq80XjLunquq1GtQ/UN5wD?=
 =?us-ascii?Q?ph0GbLxTIrNJY+L3dY2XIEiu6ljtn0uXsoKiDFaiEwRCWZo653a2sbPKwOvC?=
 =?us-ascii?Q?Nhdhh2Eg0zFGj9BmQNziNHAMpgeMt8GpI3UnoTRJduQD640dewfXMKWQX0Mq?=
 =?us-ascii?Q?AgI8p89POew1Fyr8vJBRFy6z9BN2MehvtwpyZA1iYG62jYTpISRX3Ot5JZsg?=
 =?us-ascii?Q?WY/lTyzIkzktHUUHQja3V5b6jcfdCTxaZJmTIXCkBrTajoquVW5NMqb3i1mp?=
 =?us-ascii?Q?vmNIotXsxDlfGBrwgXF+LKQTkOANv8osZvgylPPjtZJqSheuIP0jI53GjBsx?=
 =?us-ascii?Q?lgoeXxalfZeZ54REC74fwAHFArUJNNHiqNXQaGtCjUbNMQLAu/42Ah4qs4nr?=
 =?us-ascii?Q?EtRthSSGK6Bnjvwy4d2qf8BvSjAwqJ2Lr4aW4o4+4DvaVlyicBdhuGn/FFOM?=
 =?us-ascii?Q?YxKtglqIPSst9VgeftcKqznU1jjYzk+sEwOeCfTX90lCktlGgU0GfKHlDTBw?=
 =?us-ascii?Q?1joyQsHm9OK3S1r+LYq3yy9x6elIWxINirW5RYy88/vzf6kbmd0aqUR1f8fR?=
 =?us-ascii?Q?LLgfWbZ/pgT1JjX6ClNhslgFp8+Fbxoqv/0wKfWsGzsmKVQcGPFmO9E0cbVx?=
 =?us-ascii?Q?KhTTkaMUCL3wmTE2kyp1ecNlcnFNsvehsexwgNRPY36uyw4y3IyL9VfFxYF6?=
 =?us-ascii?Q?S7CRiXn9785ZPsbllRx41a7MIzxsECcIHi9Pd8G9ilQxgrsVx2bEpnz1BXo3?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbaa07b-dde3-4e24-86ca-08dcdc431ffc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 02:46:44.0369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BX/KqxpVPx1EB0KM1YUla2MoER3gFktmI2P+0ZrO9uyVbqQbnp9EvN81jAFFGCl+ENnQc5Lu07fn3Bkb/kWObQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7494
X-OriginatorOrg: intel.com

hi, Dapeng Mi,

On Tue, Sep 24, 2024 at 10:17:17AM +0800, Mi, Dapeng wrote:
>=20
> On 9/23/2024 12:31 PM, Oliver Sang wrote:
> > hi, Kan,
> >
> > On Fri, Sep 20, 2024 at 09:27:06AM -0400, Liang, Kan wrote:
> >
> >>> ...
> >>> =1B[32mPASS=1B[0m msr (1836 tests)
> >>> =1B[31mFAIL=1B[0m pmu (143 tests, 24 unexpected failures, 14 skipped)=
  <---
> >> Is there a list to show which checks are failed?
> > I attached a pmu.log.
> >
> > below failed which can pass on parent (v6.11-rc5)
> >
> > FAIL: Intel: overflow: cntr-0
> > FAIL: Intel: overflow: status-0
> > FAIL: Intel: overflow: cntr-1
> > FAIL: Intel: overflow: status-1
> > FAIL: Intel: overflow: irq-1
> > FAIL: Intel: overflow: cntr-2
> > FAIL: Intel: overflow: status-2
> > FAIL: Intel: overflow: cntr-3
> > FAIL: Intel: overflow: status-3
> > FAIL: Intel: overflow: irq-3
> > FAIL: Intel: overflow: cntr-4
> > FAIL: Intel: overflow: status-4
> > FAIL: Intel: full-width writes: overflow: cntr-0
> > FAIL: Intel: full-width writes: overflow: status-0
> > FAIL: Intel: full-width writes: overflow: cntr-1
> > FAIL: Intel: full-width writes: overflow: status-1
> > FAIL: Intel: full-width writes: overflow: irq-1
> > FAIL: Intel: full-width writes: overflow: cntr-2
> > FAIL: Intel: full-width writes: overflow: status-2
> > FAIL: Intel: full-width writes: overflow: cntr-3
> > FAIL: Intel: full-width writes: overflow: status-3
> > FAIL: Intel: full-width writes: overflow: irq-3
> > FAIL: Intel: full-width writes: overflow: cntr-4
> > FAIL: Intel: full-width writes: overflow: status-4
>=20
> Hi Oliver,
>=20
> What HW platform do you see this error on?=20

it's on a Haswell desktop
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (=
Haswell) with 16G memory

> If possible, could you please
> apply the previously mentioned KUT/pmu patchset and check if the issue ca=
n
> be fixed? Thanks.

do you have a repo/branch? unfortunately, our bot failed to fetch this
patch-set.

>=20
> Dapeng Mi
>=20
> >
> >
> >> Thanks,
> >> Kan
> >>
> >>> =1B[32mPASS=1B[0m pmu_lbr (3 tests)
> >>> =1B[33mSKIP=1B[0m pmu_pebs (1 tests, 1 skipped)
> >>> ...
> >>>
> >>>
> >>>
> >>> The kernel config and materials to reproduce are available at:
> >>> https://download.01.org/0day-ci/archive/20240920/202409201525.4877023=
e-oliver.sang@intel.com
> >>>
> >>>
> >>>
>=20
