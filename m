Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7272C101C8;
	Wed, 15 May 2024 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715778109; cv=fail; b=pOOmgjsJvwy3Y6Va2tpChF9U0lczea4s7RjLhaS4RsY2nu3/yYs2oa4+wTlXOiFfUVEss/nhHX60Rgd1APy7/VAb8fYl7/8ta9xqtOnaTZ3fiwD5MFil71/9pzC787jQ8tIZH0gsxfRw2doRbcNp+OPKZW6UjRxqAuSGJLTGsfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715778109; c=relaxed/simple;
	bh=Bziy2zuvRRhg+6zJibDu30+PyFVnIF6GOm7TvBsB7wo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lHwuKhg9Ui/rLfNwBMwqp3cChb9/dmmlQ3Hi30u3pCCx/J1Sl3BMzcngSDvIMwU42rzgzi8lwqeAJSWI8y63EWZbvUN7h//ZsC7okJIj+68W0fGT3aExRWhU+DZ6JdWOdnSX3ygc41liJVJmvjnJzJP9G2yO0RUe3ujLqxb9wPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lf5eHdX+; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lf5eHdX+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715778108; x=1747314108;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Bziy2zuvRRhg+6zJibDu30+PyFVnIF6GOm7TvBsB7wo=;
  b=lf5eHdX+zp6zktqwmZUewyz9Cn63A7HEG5NVEN+Y19/NLYp16YD/U105
   Bie6hww6YJFwmK4Q1xeeNneR6gANu3BxL0G31wYXhrvy+lMNURN4co4+e
   LcTeWemM38SOgWQKx6M1btS+SnmmtBjY5pLebL5JkXdZiBYga6JZ3Uie0
   wOl+ZV+xPglk9kHAv0lmQL37HBbv77G5yj3uveQ8dQrzLF3uoIHVgcp2x
   HLXRY8HjFrbRuJbPd4Hs52kvgpGO1qWWouV//Nu5iiSeb2OJAL4ZSHYuB
   Ceyc25mWjNq+PK9EBQDN8dCmWypsAKapydHpOCYB2CAVdUCMCRYm6YQ86
   Q==;
X-CSE-ConnectionGUID: rYW+mEgATRqU8d1FHUeg/w==
X-CSE-MsgGUID: IKEC3ncgROqj0fvgqQEssA==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11676562"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="11676562"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 06:01:46 -0700
X-CSE-ConnectionGUID: KynzTXQlTYGwyxdfvcyj3g==
X-CSE-MsgGUID: akRwQM5QTHi0zqq8ENxs2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="35840165"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 May 2024 06:01:45 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 06:01:45 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 06:01:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 15 May 2024 06:01:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 15 May 2024 06:01:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJd1SbDX+tRdCVtlG+Lsyl6QBKX3nEosm4NeAvYqhGAiPCG8npAFRlCUzJuZnvTBiDjQ6XaHIvUoyIeuy6zM15xRorvHlbKISy3Lr0guYHvKp5fPJu3BX7elA1Fl4GH3eCp4pfi60CVoO7d3To9ynFBbP/TykKfIw4y7r1HN6BqJlxJdzYItBssu8Z0jP7a8ek7st8h55gBpY6ljLNYbNxgjN4NrjJiHhSl5IJwOiPcWnYtUA4VGck6mkEQ+zjNDxjiJgRjbre1lRsn2ABr/d0i/NVseC3/fo5g7RouKTQDx+uDysOPGxllB+WLqR+UVszZqfVPQx/jaXVD5KLjhXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVcYmzeZgDhFpFJdRL7BPjdUM1X9ptEydyzm7+yIq84=;
 b=mIR4SbdXiw1TtetjqMMf/CIRCdbh1J25G7g32QWJygGb5Y3xl5VfvlT+WGc2jFARNpl7E+nWd2ga8UyZU8AjvAjr2iHzrhR82jaOvSV6BIM2U+oYT7I2IhdkjbdZkBvXHgbfpfT6DAmIy4u75CCfrxq+8do+xwBSzc1j/+/RWzdvbQ5yXaH2svDc2xZAAtuR9p/J/0RkLQLVmDZf4B5A+AuOjuDJ9g/QE+/6xGw83UXVRCDfeR8Q4KT22kcZs/o3us3naHWH6J0E6L1faLyVNF2UNxLAskeYCCX/kCbuWbfXFl44qDx5neD0++wzmvzP231KWg6u/pCeoKAMbsSGcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB8490.namprd11.prod.outlook.com (2603:10b6:806:3a7::14)
 by SN7PR11MB7539.namprd11.prod.outlook.com (2603:10b6:806:343::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 13:01:36 +0000
Received: from SA1PR11MB8490.namprd11.prod.outlook.com
 ([fe80::61ff:e976:3464:9f6e]) by SA1PR11MB8490.namprd11.prod.outlook.com
 ([fe80::61ff:e976:3464:9f6e%3]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 13:01:36 +0000
From: "Wang, Wendy" <wendy.wang@intel.com>
To: Zhenyu Wang <zhenyuw@linux.intel.com>, "peterz@infradead.org"
	<peterz@infradead.org>
CC: "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>,
	"Bityutskiy, Artem" <artem.bityutskiy@intel.com>, "Wang, Wendy"
	<wendy.wang@intel.com>
Subject: RE: [PATCH RESEND] perf/x86/intel/cstate: Add pkg C2 residency
 counter for Sierra Forest
Thread-Topic: [PATCH RESEND] perf/x86/intel/cstate: Add pkg C2 residency
 counter for Sierra Forest
Thread-Index: AQHapnXYp7BVl2jRbkOSt3m7I3nZC7GYP3rg
Date: Wed, 15 May 2024 13:01:36 +0000
Message-ID: <SA1PR11MB84900A6023E6F9856A928A779FEC2@SA1PR11MB8490.namprd11.prod.outlook.com>
References: <20240506084806.495816-1-zhenyuw@linux.intel.com>
 <20240515032158.12845-1-zhenyuw@linux.intel.com>
In-Reply-To: <20240515032158.12845-1-zhenyuw@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8490:EE_|SN7PR11MB7539:EE_
x-ms-office365-filtering-correlation-id: b65203aa-00ff-4b15-99bb-08dc74df2735
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?2KaQalwGG07L5dLDFsuSI0PHZIBt0z9RNrzpxWdBaZXkewxUQqX0jWcK0dsB?=
 =?us-ascii?Q?YsO7VNJi3k977pzdHDSwGU2NInVCcmscR+7ON29UGyqdZgD9WPu2mUC4xVtZ?=
 =?us-ascii?Q?imrqgwU7eP0BT9UEleVRZh3GvnHHwlNDKXqRJWDVNGN8H/nMDjSUBkrNcJpS?=
 =?us-ascii?Q?DhCqokCF+xt/hO8Rngd5BILJ3rfamsduAThD5NTqQ+Fovz7LBrilIi4ClHvV?=
 =?us-ascii?Q?nopWSjc4xn9sLiL3MuvFWLEVOQGq3BpR8/D46rXaYZHl/gB5uNl5FhHC+FKn?=
 =?us-ascii?Q?AhNYPNYtu5ZcCEb79BEzRwpsrb+X59nzI2bsRVyyR0BeUAAetbkUTogkNGUW?=
 =?us-ascii?Q?fruHe26yVKWIKaoiW90F+XzurY97q6SA2Ubq9SXm24o1u5SpFvEQM2zKqc+z?=
 =?us-ascii?Q?IA8cCgnCmY1gT3bpQx20W+syXDQ2wTtguSXF3M/FsLYUrPPs/FSZAhJK7dkz?=
 =?us-ascii?Q?mb9ZO9ihp7WtsASpxz/0rR5PgeWvc+8p+xHV9I3HaPw5Xqi4c6+IbX0uuUTc?=
 =?us-ascii?Q?qnFBVIS5ltaTEy4KjYunm1lRWiTJgr0lh1kzlLztgFQhMCh9Sqi1B/mQMXF6?=
 =?us-ascii?Q?youlCLBVaiR+5G+4BU0XvtoH+I2gPQw4VjTTDFrdmcVAO5zvMA5+exlywZUY?=
 =?us-ascii?Q?293M8tAjKIHrLNb7TfPnEtyO+r6sdNHQ5djdeAgpm3oLBu/aCbqPk/mlkVSt?=
 =?us-ascii?Q?fGE+jL9Gvk9xGmeTVVSJvilgT32pHaIMUOx8CFenCzeHt0u7uVvv9pGjke23?=
 =?us-ascii?Q?7yEqM9Mwq35bzC+LG7WhpWLUSS6nnWMjeekXrTLX4eRNPe40LAHKMoA+H0PG?=
 =?us-ascii?Q?tOXNTbvwJ3socHLQbU/8vzoURQyzKHP78NkyK0QDapruVttl6YUcFv44kHG2?=
 =?us-ascii?Q?NOHts9Ds3O3Fr7HdSxKn6cQsEocWxekRFHEgqAT4rAdX8WdcnVfiaSGSnNGV?=
 =?us-ascii?Q?gnMX98ApjvAhgkbto/lHpsDRtazkDi5tgQUaFhIZqahYF6dPFi0cBUcKmRZn?=
 =?us-ascii?Q?G5BnG4QjDXyG4R44cx8OxcBYsIkEY3ksSltp6l9njsdGolRvNAqB6xfbIyoL?=
 =?us-ascii?Q?gXE6EFAeT1LDxmkxdvKxt4cE3eDS2LD1AZ3buF0tDKDBQHUGl78k/Ww5y3/l?=
 =?us-ascii?Q?now07UXFluxJYiph+r1+UhVPyTi0FJhyFELfmnFseXqn9VX9HIYRZfFBCZIW?=
 =?us-ascii?Q?hfrttxcW34mmZaRW60i11UGmDOmm0Bg95tQ567LGsHZL43iqQR1QhGCWhMtp?=
 =?us-ascii?Q?0Sk9G35vHYQTiEUCDoPtIrbMerE7Bo9sSO+BLVGBPaq7IZo1W1tsGtAj0UvD?=
 =?us-ascii?Q?JP5arrltcFGsJSbsGBUpAfmu1jS1w9bx55jj2nKiTd435A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8490.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VR+Zs1sy9JTd099m7/LtQ0q2RmhfHPF+gvm1h9z8kydcyO1ANZ8ls1OZzaDC?=
 =?us-ascii?Q?c2u6XNzaqJshw4hXQtAoo+fRqO6nQUeKYyGeOjvzAU26hBsmDriKT66IpcsL?=
 =?us-ascii?Q?iHeTTC+96dmfM3LwB0VOTX05bqNrrbwPZgiJPrQvdaFGK6w0tRXf/A7BJDQA?=
 =?us-ascii?Q?96aUWhwQ9haAba4fS5pdKHWdCXuhBVHVPmmD6Ju0E/BgjMQTlYn2JXaafMch?=
 =?us-ascii?Q?+4AYo9WmF7OgNYOm58BH2mr2Hjqmvh0KtDAL6ZcX1O2xGIvmj0OF52NoTUJn?=
 =?us-ascii?Q?+aOKbvaw28s+E0KwPeA8+Bkj+qbKBWJysNg5uaQl//uTn0iRHZLTk77FfBjQ?=
 =?us-ascii?Q?nWTfCIbCp92MDKgJF2OZvCvTepkC5iScPE/cN059uK+TV3+SgycTQi2eC45K?=
 =?us-ascii?Q?gMhqYZ9j6liG2wdt/0Lz7QcwB+W523+wvY45tlIBN2cx+y9IsHIJFbgEkXkW?=
 =?us-ascii?Q?9iGPwcYRzVXaLXAKl7OGSkUvfyBEDQLHTkf8A54zjQZs/O98FOLU+Uj5L1Zv?=
 =?us-ascii?Q?Ecz7R37uRyY+VOVyVf2qnw/P17XgTHfB5mZQ+kWF54vVdBmhMdQZ0bWGJMmm?=
 =?us-ascii?Q?jVILtI4KYkDb7CSU1u/DXY5F8lXXBSaWYZ5V/GRDvku5NDsymTFBsrs+0v2/?=
 =?us-ascii?Q?LVsgB4FJnuiXwB8JGnORK16cAxzvaS/23YBNhDf3e17PkFkUyhtrS+OMZ3DE?=
 =?us-ascii?Q?4UNSrj1cb3goeoQ2QY+Io5NLArdOaWd4wBxrVAX8LNknQFeHhEIL4ZNNPcim?=
 =?us-ascii?Q?ghMewDl54QWtLfj1pavNon4hY+gGej27qnIZTrTecYwvbP2Admo67Vgqhr/l?=
 =?us-ascii?Q?Ex9OgIDhw/spvO+be5CiubNBd3+YqXkytXTaC6pTusJT2gVigozQIkdukaKn?=
 =?us-ascii?Q?5fFUjOFCojGLWC8A+ayeVDHAwxuAQw81m68Y/+Xmu/y9yU/m8Nvgc8zTSPPH?=
 =?us-ascii?Q?vomvzuHbQj/9OTdFHG2GJw1RjCKupSJxmc5l4vlBljVvduNN6p9vfRf08vAK?=
 =?us-ascii?Q?3Bgfe+Gr8MfBiSGbcOhXvm6Rs48UNYefHfAebTsDRIt8706TEG07EoOIqEnn?=
 =?us-ascii?Q?dAtue9V9NMl/hQ888wUWrhhcQIga1M9csgiiDS7M3EJxBBnIrThpU4x/wqbB?=
 =?us-ascii?Q?MsQ4ukAnNaiB92EbS8z93x0tHf3bWxmI0fsKW+mNAif3+MOa9dcgA/lqhQGy?=
 =?us-ascii?Q?+M8BCFBPWNM+tAm7t+LZzQ0ZUNP7AireuRggsSFsstm5go8Kup4U8iIYNiG2?=
 =?us-ascii?Q?Nug1zcbs31Qrwz3Cv4jzQOLkgpO24bJUDNe5VxPWn76YesFBYhTi7UHM9ri6?=
 =?us-ascii?Q?2oHy5Omt907x8TM1ISw/mIWjgJrFsa0vJEPBjbu81oYQ0WmECv2otG743AVd?=
 =?us-ascii?Q?cgb3cSknM6F103GGCi4GtM0qPS6skTr1PZ2CzT7SXiH0ZtI1acGIOxoz31ot?=
 =?us-ascii?Q?EdBriJdeJCtXSecnwI3VELBiAVD3jkcbS6DFTCvJoELfM+161dRah6En/4ra?=
 =?us-ascii?Q?VHz+Qr8mkVZTEaby/aKbFjMn/CNOK0Laey6MwJsgsS4PZE4HoyQe7vcOMuH7?=
 =?us-ascii?Q?dFhgaIny+Lg35R834sSRBWuiFUO0Pnjc+bfxBWmN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8490.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b65203aa-00ff-4b15-99bb-08dc74df2735
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 13:01:36.3897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YU0MbBtICJkCAT5yyneTbvAROo//y0tbr78pwO83lp+pULbg1BhbHKMC0/q5BjrgIZ/iWjj6sU0gCIJi3PmW7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7539
X-OriginatorOrg: intel.com

Verified on SRF-SP, the Perf PC2 counter is updated:

[root@p-srf07 ~]# perf stat --per-socket  -e cstate_pkg/c2-residency/ sleep=
 20

 Performance counter stats for 'system wide':

S0        1      9,589,297,024      cstate_pkg/c2-residency/
S1        1     10,204,349,952      cstate_pkg/c2-residency/

      20.003533150 seconds time elapsed

[root@p-srf07 ~]# perf stat --per-socket  -e cstate_pkg/c2-residency/ sleep=
 20

 Performance counter stats for 'system wide':

S0        1      9,309,806,784      cstate_pkg/c2-residency/
S1        1     10,897,684,928      cstate_pkg/c2-residency/

      20.004747926 seconds time elapsed

Tested-by: Wendy Wang <wendy.wang@intel.com>


-----Original Message-----
From: Zhenyu Wang <zhenyuw@linux.intel.com>=20
Sent: Wednesday, May 15, 2024 11:22 AM
To: peterz@infradead.org
Cc: kan.liang@linux.intel.com; linux-kernel@vger.kernel.org; linux-perf-use=
rs@vger.kernel.org; x86@kernel.org; Zhang, Rui <rui.zhang@intel.com>; Bityu=
tskiy, Artem <artem.bityutskiy@intel.com>; Wang, Wendy <wendy.wang@intel.co=
m>
Subject: [PATCH RESEND] perf/x86/intel/cstate: Add pkg C2 residency counter=
 for Sierra Forest

Package C2 residency counter is also available on Sierra Forest.
So add it support in srf_cstates.

Cc: Rui Zhang <rui.zhang@intel.com>
Cc: Artem Bityutskiy <artem.bityutskiy@intel.com>
Cc: Wendy Wang <wendy.wang@intel.com>
Fixes: 3877d55a0db2 ("perf/x86/intel/cstate: Add Sierra Forest support")
Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
---
 arch/x86/events/intel/cstate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.=
c index e64eaa8dda5a..4cd36848cfff 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -64,7 +64,7 @@
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
  *						KBL,CML,ICL,ICX,TGL,TNT,RKL,ADL,
- *						RPL,SPR,MTL
+ *						RPL,SPR,MTL,SRF
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
@@ -683,7 +683,8 @@ static const struct cstate_model srf_cstates __initcons=
t =3D {
 	.core_events		=3D BIT(PERF_CSTATE_CORE_C1_RES) |
 				  BIT(PERF_CSTATE_CORE_C6_RES),
=20
-	.pkg_events		=3D BIT(PERF_CSTATE_PKG_C6_RES),
+	.pkg_events		=3D BIT(PERF_CSTATE_PKG_C2_RES) |
+				  BIT(PERF_CSTATE_PKG_C6_RES),
=20
 	.module_events		=3D BIT(PERF_CSTATE_MODULE_C6_RES),
 };
--
2.43.0

