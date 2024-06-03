Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F112562E;
	Mon,  3 Jun 2024 17:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434060; cv=fail; b=lEF5bqSDvdklC3caYaTjVlYYtXkqD+ALnPiLXFyq5z1YNDk4SJCD7LteXXSd1J7TAczFtBqWtK7FBqXzkSz64mxmbXqAEj9jteB3a1pnpdUCfaVSkgFU14kXqjY6e+EqWNERa0BINiOKMi5dZXygCV9cGcxcu6L3KmvWvk3jccY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434060; c=relaxed/simple;
	bh=neDmK5PBth66/CsoAulp0A261qUNqQRuIAgNoTWuZvQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=amwcqsxWXjy/u7DFTLUCQNyXmGss/LdMygApJY6Q43M9gMOlU7N07xvEHgIDU/r1270Lbgh9nY7DRVeNU6PJW+BOzZvDvUqZWbMgxYymXFOea33kRQwiRcCbRyK6i5DDSfxMLgoQvF7pwwpXjVYhoLwv60+jOdHLA7HqMpmMMAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A77EmfVY; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A77EmfVY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717434059; x=1748970059;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=neDmK5PBth66/CsoAulp0A261qUNqQRuIAgNoTWuZvQ=;
  b=A77EmfVYFTEvINe3ozvQ5dNU7Ps2IV0VKRXIhlC5zK2u4TEVumOw3juR
   ff0SribfL0s11L7Wt3OW5FxBIZ7LFk01knlohm+LDpkw3T6nkeTM+rWq7
   5HmTqu9CMwBqkjCR23ck7XwD3sJ88MSnpBVVMtkeexwCuk/5i6znh319B
   ppr61CCpCpfsUkXceiKXuUIStxiXI6yAffxUTeR1H4y/JuY8ctzhtY/3Y
   1BVqtmtFUPdbJ6knjJUDODc7rMOs8QVXxgUlzUamdrKEJWXZds1KQOwi3
   0C3BuuJ5adheGFSPqUmv0SzFTFBUlJ8/32Ze+MJlpq6mDh5soFAh80EJM
   w==;
X-CSE-ConnectionGUID: rDvxwj93R9KCzYrYTMWnmg==
X-CSE-MsgGUID: Ua+IiRJYSpi/IzbMFEEeBA==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="24513938"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="24513938"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 10:00:58 -0700
X-CSE-ConnectionGUID: BH4NloCFT0uc9M6nJp1Otw==
X-CSE-MsgGUID: cRQcdWShT5+RwRlxcjUVrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="68096694"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jun 2024 10:00:57 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 10:00:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 10:00:57 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 10:00:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cN2AA33I7BTxUhcwC7rcelIaK8ef1pdN7KAVMtJiiYYcsfQg4/rITJYe2S2NT3hyVv9WSim4vrCsBV8EUj5jOjhOlifdPNoocpxGgMOUql2Yt9HtHTeRMeGMpQF/425qft7WR+3wMzAczbUJMxa6CD4kBilAMmL6HB8X3cIwSUYt2vGyJUXmsCKgxOiab0jy7lECltMr1kOS7LR9ysIspEXDAQ9m09NLPu8XJvXJY2tKGAdTSteuOoY8D+7keW/HuBVPHT9bzngUtSWRaxxF/ZPB+jEtZR/Td7OboyIk8Q23xGBQ9OQB9j8IR9GqXGPvCCjZYAeAnfvBleg+WHxx9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6qiSexp3fpokdtzanBsep77bLEIHoH0WQRdrfCwHWU=;
 b=R37eLLOna3TgZmLbdj9y4ulUduP5GmKO6I2y9BTkd5M3B4NbElczp1XARUadCG/SmxiVFL6PUXx4A5TjUImlglb6c/ZOIp7I1bvsAGg3oQqRDA5t9e4HGWtnB/DexPQ+dCx1kvRweProppKCVDUDsN8qwDi5cCBj4WMFjXU3Al2YJEfJnVqClWtMjy1AL7prWf4QNBveRAz2Z2/XkMBLBns4bbNFq7yL16tKXRy7TG095fBwlZ9xgPfnxvnUXV4VTvg5tnANW90ULX8YuW52ywaMLeoDnPMs0K1DJyB6FMMMvntZCJ2NafFuMwoKh8EovakGia89hBWUUZzetsdmWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by CY8PR11MB6866.namprd11.prod.outlook.com (2603:10b6:930:5e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Mon, 3 Jun
 2024 17:00:54 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 17:00:54 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Namhyung Kim <namhyung@gmail.com>
CC: "namhyung@google.com" <namhyung@google.com>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>, "Arnaldo Carvalho de
 Melo" <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>, Kan
 Liang <kan.liang@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb"
	<caleb.biggers@intel.com>
Subject: RE: [RFC PATCH v10 8/8] perf test: Add test for Intel TPEBS counting
 mode
Thread-Topic: [RFC PATCH v10 8/8] perf test: Add test for Intel TPEBS counting
 mode
Thread-Index: AQHasZOMbuNn7cwVHkStwuT5Ba6t6rG1I8WAgAEoKXA=
Date: Mon, 3 Jun 2024 17:00:54 +0000
Message-ID: <CO6PR11MB56353AAFC39B85C7E9310488EEFF2@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240529064327.4080674-9-weilin.wang@intel.com>
 <20240602232041.1730256-1-namhyung@google.com>
In-Reply-To: <20240602232041.1730256-1-namhyung@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|CY8PR11MB6866:EE_
x-ms-office365-filtering-correlation-id: ebc02e76-49fa-4bbd-52f5-08dc83eebb52
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?mXmYOqhQMV7p3tpgaHw0HntMfOOFaoZIu/krXvV+lShekBuyJ2GSJD7BJSRl?=
 =?us-ascii?Q?YdXN7B2A+fm5sPCkuU4c8CreVlKKUmlUMJCJQ59BexuG3b0f/pF7UcnrcvOX?=
 =?us-ascii?Q?l0NBzMolVsG1AVrll5xC4ZK8/yJF5k4crAhqgaKYXdfG8I5OtOJsmMiOaDoF?=
 =?us-ascii?Q?T5ftDrC18iUS4xpSuqZdVwxbuVc2IcwCHzYGQMZVS2H0FV4BrRN7DDuWy5K4?=
 =?us-ascii?Q?KniCQfwZpJY35EAEjA7Gy3K5tNVQpXwB1Jslq2AN+x0i/g1h/3lFpw1QIYzK?=
 =?us-ascii?Q?h00mJI9OQ1hglWwFCetVzjs67CsgX7mSeLkPi2jTo2cx2gKq7WSbA9axkErq?=
 =?us-ascii?Q?bX+Tbi2ZNXZzFzC+7xpZIfHUtBVEw4SxFHiYeITKXXmR9dd3qzCll+pIxPKJ?=
 =?us-ascii?Q?jM3eTMJ3vtN+w2HBrwK35jADKpw6PlQ3JXKET2/MdM4JCBs6eiN+YsCEZhQP?=
 =?us-ascii?Q?x9UFJJw7SdLW0XeyVb/eUAriatfIQarniSXA/HAk21V5ZQcWdn2Z53uxvCsf?=
 =?us-ascii?Q?0kCEZFWu0MLTtW3LSM39mtkBad3RNOrX1AbjLwFGYF9MNzMTtghOoU7UbVCd?=
 =?us-ascii?Q?Ilj+KWfRLJ8ioHE64DorDx6aSLSkNVdcya6ysLLTdmKmtA9kx5RwWY2E5Cgm?=
 =?us-ascii?Q?82l1QPgUTuKow845/z82cV86cSe2+f7HGXGfh1i6O7qxG6h7iBR+Dm/Q1Sc7?=
 =?us-ascii?Q?MTWAJKy3g84X++Jqa/PO0eP2CppxfY3j1m6u5QaviB2pA6+7wKbwV1LjJmVX?=
 =?us-ascii?Q?if1Ntmw3ErFpJ4ADyGv+MFgDryU9XmMRY9t1iBHe6p6tCydkGgq+GLDIGUya?=
 =?us-ascii?Q?0LaLlINJLgGC1alxSz5WjnbgPTiILT3YSZ+2m0hAqSavLhZcA7/qTqWUTVEi?=
 =?us-ascii?Q?mJQz8frUS2W7gzeA4dcbvskctPalkEK2zIfKAZ9338BXRD+2cmyTrLn8HkJd?=
 =?us-ascii?Q?zs4l0EZCOMrOOReO7aH1i+/Rt+JPsYdLwP2t2Il1XoMOHs2PmD9Fnk3QBNe6?=
 =?us-ascii?Q?V6SLHyvu44JHutYXATkcybrFaaQOMblP7niUDvldU5uiOsJSRadgbiIDHmKV?=
 =?us-ascii?Q?0H2/z8wxZ9caN4BzbB6pRRa+XBWDLWytawWzcIIQA03CaA0s3hu4kenkx0md?=
 =?us-ascii?Q?lVt+Xju7Twhwfa0ZvxCWrN2HlcJ4+4tg3NcAX5yf5bJK7THXLsE9Qd+iI5fs?=
 =?us-ascii?Q?FQPRb3YV8h63DEMmCLFwtYukZWhC13aoZ9UJPMUZOwYKnJzz7lR+5xm25/KA?=
 =?us-ascii?Q?Nts64VueG9MDru4h/nROA5xD1xyHmhX9ef3Bkmr2WQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yYvJ+RIP9Fk2DcEar6IPhOJ61Qc5zJ7PoRlLj/3y2ou+lo9wNlE7U+MBK0kD?=
 =?us-ascii?Q?dDB9dxmQtaYJGi5VsEfQxMSYU+04YlTgu2S0q7BFkCh9/KZQvLfal4AHYdTw?=
 =?us-ascii?Q?M3Z5R73vp0pPFwWF8UOOSOynlgV3NUp/WMmn8Lf7Mq5V4tM6vDRICNzxIKX2?=
 =?us-ascii?Q?/zvTVvgyvqPMxQIrqt+VO4ipW90mehEZwG0BqEdQJa6/tT8bX4PwrES5HGte?=
 =?us-ascii?Q?oVfPFHtoKEk80pzzVnpaMpdcr0XzHx6LlBpLUSeLzdd/2Aq4TsxrhDqGRA0L?=
 =?us-ascii?Q?9JwcvkOGmLdFGq5lz3l7kQYaG1t9XtcKG8tITJYB6bB80LrIWK1O6zd0VnLl?=
 =?us-ascii?Q?9/rtqSKvBLI8gzC9hadI/58b7DKE6zPlKbQS4qZk2QQDeD5bwzumDemoxC/h?=
 =?us-ascii?Q?NdbhwTzyeztfJpbmPDgMynHFdEaGKj4GzZ0/ZYGaQ0Lk7k2w65EvwlBuNqy4?=
 =?us-ascii?Q?/yQqhyvH7zhc+5l4XVDUI1M9pEZBANeNqcNmLaNrEZ9lX6Hkz7Qi3366MvwK?=
 =?us-ascii?Q?U5PNr0oZxD1wwNs9ZFuWROiKLBHWtqmqfQ/Zmo68T+WWR5pGgc5LvBvcZVD3?=
 =?us-ascii?Q?vmQWVZwPXdXCuBQlzapYTdTTN2dKjYvPsBqivj1JGekqht4EmFDE1yjS8O63?=
 =?us-ascii?Q?Q/SrHjJ8ewdpBDpeitY76Jc2i8DtsmJliW6TmUEtASiCP6j4O07JKudcZF9s?=
 =?us-ascii?Q?bvM1o0IUq0CvpMDsvNokKYmO4HwyK6hkAAniPVoy0KoA2G63YQjuhaN9aqzj?=
 =?us-ascii?Q?svlGkGhrOeijL22r2Zsl4U13+qK0NejLcKB79ttZa9t80nqAtTGIn1odx+Em?=
 =?us-ascii?Q?Ao0pjDFvmm1I8dhLTMQx62ahmpARy8DNc/seKltAKIXO+gcA2aB1mUdzP4Ni?=
 =?us-ascii?Q?dLeVP7VFlSUETfQJ/zXcs8+lnrZZjGI5KEoPv7ut9T/nKiG84EITYrTFDDsi?=
 =?us-ascii?Q?sHCvyBc+CvbOWCUJ3fH0VJJBP9X4L8Zpi24u/H9UPhISi+G+c2/0H4HAh7b1?=
 =?us-ascii?Q?xl4NuXbsyXcbGK3H4k0NtpGz3g1QMYNaYOvvekodbD7vcz7DLrhfAu7uw6SH?=
 =?us-ascii?Q?gFKgwkxbxuuAKw9OIb4RKmJ5ILw8UxJi7PErDumoSN+/Zpb+0FaPQy+4o9qG?=
 =?us-ascii?Q?jCUjoNGoFL2lPdR6sJfRWI70YvkzAhB3gHs4YrJEA4ykrR9noxSm51Urldlq?=
 =?us-ascii?Q?cnkPp+MZ+com24wJ2ZUOdohpWOcA+eqNhdae6roUtlxFtxk0qMgRy0ZgkUZS?=
 =?us-ascii?Q?qovNVjYcmnFD8TmZH6mCyrQqkqBWRY1wuiknX1yNiEUhPXycNSoRpemb7HW6?=
 =?us-ascii?Q?E27POVW3Ch9eHBJ3q59Cwp9Zo0HRyF5WxAy6fARkWs+J+0frv/EdkuxBCJJX?=
 =?us-ascii?Q?Gy7cGblwy6XNUMln4mMPrVkofKryfRFmKFoZlMCd0hfMe65mDm7DLVjALSVa?=
 =?us-ascii?Q?Ygbv2tFySpjQj2LkTx8GSAneQRs6hIY4M4lVAMNHSvoz3BMdtBHQcxnJVF90?=
 =?us-ascii?Q?p5SsbR7nXyf+z8eoGrKNTO1F2xa+K8ryiOzCcuszX9ZzJ0mZ4j94c5bs88dC?=
 =?us-ascii?Q?DoEOgZv/JYoI0m3us1TB7Uxbqjaesj4qwMwqY0rd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5635.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc02e76-49fa-4bbd-52f5-08dc83eebb52
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 17:00:54.7388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jiu5L0sKU9hhhQwwSTFqHg/r7jzy9W8Ww7MSxVo8i20HdpylPC3YIkFBIOuYrKs4YhavuWNDIk53ljOdb/+NiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6866
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Namhyung Kim <namhyung@gmail.com>
> Sent: Sunday, June 2, 2024 4:21 PM
> To: Wang, Weilin <weilin.wang@intel.com>
> Cc: namhyung@google.com; Namhyung Kim <namhyung@kernel.org>; Ian
> Rogers <irogers@google.com>; Arnaldo Carvalho de Melo
> <acme@kernel.org>; Peter Zijlstra <peterz@infradead.org>; Ingo Molnar
> <mingo@redhat.com>; Alexander Shishkin
> <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@kernel.org>; Hunte=
r,
> Adrian <adrian.hunter@intel.com>; Kan Liang <kan.liang@linux.intel.com>;
> linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; Taylor, P=
erry
> <perry.taylor@intel.com>; Alt, Samantha <samantha.alt@intel.com>; Biggers=
,
> Caleb <caleb.biggers@intel.com>
> Subject: Re: [RFC PATCH v10 8/8] perf test: Add test for Intel TPEBS coun=
ting
> mode
>=20
> From: namhyung@google.com
>=20
> On Wed, 29 May 2024 02:43:24 -0400 weilin.wang@intel.com wrote:
>=20
> > From: Weilin Wang <weilin.wang@intel.com>
> >
> > Intel TPEBS sampling mode is supported through perf record. The countin=
g
> mode
> > code uses perf record to capture retire_latency value and use it in met=
ric
> > calculation. This test checks the counting mode code.
> >
> > Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> > ---
> >  .../perf/tests/shell/test_stat_intel_tpebs.sh | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >  create mode 100755 tools/perf/tests/shell/test_stat_intel_tpebs.sh
> >
> > diff --git a/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> > new file mode 100755
> > index 000000000000..43f75055fee4
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> > @@ -0,0 +1,19 @@
> > +#!/bin/bash
> > +# test Intel TPEBS counting mode
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +set e
> > +err=3D0
> > +
> > +# Use this event for testing because it should exist in all platforms
> > +e=3Dcache-misses:R
> > +
> > +# Without this cmd option, default value or zero is returned
> > +echo "Testing without --enable-tpebs-recording"
> > +result=3D$(perf stat -e "$e" true 2>&1)
> > +[[ "$result" =3D~ "$e" ]] || exit 1
> > +
> > +# In platforms that do not support TPEBS, it should execute without er=
ror.
> > +echo "Testing with --enable-tpebs-recording"
> > +result=3D$(perf stat -e "$e" --enable-tpebs-recording -a sleep 0.01 2>=
&1)
> > +[[ "$result" =3D~ "perf record" && "$result" =3D~ "$e" ]] || exit 1
>=20
> I got these build errors:
>=20
Sorry about the error! I will fix it.=20

Thanks,
Weilin

> Thanks,
> Namhyung
>=20
> ---
>=20
>   TEST    tests/shell/test_stat_intel_tpebs.sh.shellcheck_log
>=20
> In tests/shell/test_stat_intel_tpebs.sh line 6:
> err=3D0
> ^-^ SC2034 (warning): err appears unused. Verify use (or export if used
> externally).
>=20
>=20
> In tests/shell/test_stat_intel_tpebs.sh line 14:
> [[ "$result" =3D~ "$e" ]] || exit 1
>                 ^--^ SC2076 (warning): Remove quotes from right-hand side=
 of =3D~ to
> match as a regex rather than literally.
>=20
>=20
> In tests/shell/test_stat_intel_tpebs.sh line 19:
> [[ "$result" =3D~ "perf record" && "$result" =3D~ "$e" ]] || exit 1
>                                               ^--^ SC2076 (warning): Remo=
ve quotes from right-
> hand side of =3D~ to match as a regex rather than literally.
>=20
> For more information:
>   https://www.shellcheck.net/wiki/SC2034 -- err appears unused. Verify us=
e
> (o...
>   https://www.shellcheck.net/wiki/SC2076 -- Remove quotes from right-hand
> sid...
> make[4]: *** [tests/Build:91:
> tests/shell/test_stat_intel_tpebs.sh.shellcheck_log] Error 1
>=20

