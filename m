Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1432E630;
	Tue, 13 Aug 2024 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723569509; cv=fail; b=ZXYeP26g2tgrcdTK+vb1QZArL8JpsGSAMfGh6KijlhwRvIc+ExdsK5k+rLQvpv7HRWxq7O3ueqQlzzPaAwPXgFLAtLBVSSl5iYlEI9RyU7fOvImLScrsgrHgPBYnA06EU10HQ3oxEhQtPH7genSkf9Zr52K/Bbv3tceh5NC8VgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723569509; c=relaxed/simple;
	bh=PUwAOD4nfucZzFOtnG1QYFLzn5TGLQIdgGkXBCqOX18=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ezt6+4c0y508uiGUMWkqCSP3GdkxfAd1ToVW+QqLffsDuWP/GgzgExRacQ11tuaOCVaEnYWiyC2oy12VCmy+qY4qJdYPcMpoFBLyuR1Ffv5ErI5SJophaBsyuKkWqUH4xioRWVYo0kx8e7n8Ad0KVcJREt6tn1AqXpxn0En+9lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mHxQ7Ti3; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mHxQ7Ti3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723569507; x=1755105507;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PUwAOD4nfucZzFOtnG1QYFLzn5TGLQIdgGkXBCqOX18=;
  b=mHxQ7Ti3MD13bM7ArwhVtvQ8XgFOudmjQgETfdmbfcjo1mmr+sQR5bVa
   wsFx4Wr0wcBM7Kv4DavIqRVy4PXFIc0397xDZORMoQ8e/BaVv5PFz8HEH
   7ErR5WrwKirOanOIzyC2QDQpwpBFnVKePoqMFjazfdhwm0tiXWm8V/pb4
   54ytgl23ub1e94uiLWkybPJH/oXhAKBs5eqshge4fvH4griz15SN0gl6p
   o+EwNsaQmc1sxASIw57SqkRIe5TnNqFC4J5yEXIK853yFljez9u9VUcYy
   tIf4K+F42eikrVCw0tGmwSz4fHICOZE+aNe1mupt7vnufvr00s3VEfTOq
   g==;
X-CSE-ConnectionGUID: wt30J/pKR626Bi9ZfkIo1Q==
X-CSE-MsgGUID: nFu3zTyJTgCNVPdrRzwJKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="25514686"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="25514686"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 10:18:27 -0700
X-CSE-ConnectionGUID: nHIuCibJTba8RpDVVDkhiA==
X-CSE-MsgGUID: BBVGz506T12HZKVNwoguYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="58428851"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 10:18:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 10:18:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 10:18:25 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 10:18:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ox3+HiePoiIBFCQ7NFJuVN67m17Op8GX128zycxtt/navpPJZIpBKWn1Eda82n5T3Qq2v1Uf6ixPvagLHXjxWQGxMa9OD3LCUPMhN3Z/EBWbk+E7Sgn4J8lebJIqKLaylRhJBa87+rnnoTJgtIba8BG7dnRvAptL04Me7KDHlkoSX7BEpDKEP/nwUiCBwy8DkrTZ6AzbR0ukehEIe41ifOYuNSJ2o6j8o05GlFyzuLGYPDPt/xwNBMZI3E5pJc8SzB3r1+UvHlgdcKgCLIxzpbaXoA7J/KcwajM5Ym9MaW0A88O200rLowB7wSpAWerg++ZL2Xlk6qNryAPhb8ziSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRoEAGFh/s2wedee1mwtQd4cADisd+coIl5iqA2e90Y=;
 b=Jn+8ARzkShjryXTk1oZ/GpDALIP16XCtzt5b5mH8o8fPOV2tM5jL4ODsc/fekhPswTFDA82WKPRM83F5UCzAzXYPqIDq9QfLCrKdKYaFrx/eVGWJmpe/6qvJT/vX24mLafTHJSxrFYp3CaAlD5uiGIwUI8nC4amh+zO8nYLnTB8YVuIdWaus3bf4ALJvd6tRrlhw+t7zp9CEtoD5ZvsmTF5Ba08MYbx55Brx16jNlmVXL6FKPCfOlGFx2OUTs540DozHIR6KMBYfXvcS9tJPGbCx/dWONK+K0AL3ZlhEFHssPc2ZfhbA56Q+5siaJ267T7zHOAa0Ys6xNJ4JRhdl8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by DS0PR11MB8051.namprd11.prod.outlook.com (2603:10b6:8:121::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Tue, 13 Aug
 2024 17:18:22 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%5]) with mapi id 15.20.7828.031; Tue, 13 Aug 2024
 17:18:22 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	"Hunter, Adrian" <adrian.hunter@intel.com>, Kan Liang
	<kan.liang@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb"
	<caleb.biggers@intel.com>
Subject: RE: [RFC PATCH v18 8/8] perf test: Add test for Intel TPEBS counting
 mode
Thread-Topic: [RFC PATCH v18 8/8] perf test: Add test for Intel TPEBS counting
 mode
Thread-Index: AQHa2m0QZqCz/Ib5/EyrYjGlqvAGO7IkikWAgAAAWwCAAQcbgA==
Date: Tue, 13 Aug 2024 17:18:22 +0000
Message-ID: <CO6PR11MB5635B87159218287A4E8108CEE862@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240720062102.444578-1-weilin.wang@intel.com>
 <20240720062102.444578-9-weilin.wang@intel.com> <Zrq11fq_F9vImsQh@x1>
 <Zrq2IoAgopw1NbbA@x1>
In-Reply-To: <Zrq2IoAgopw1NbbA@x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|DS0PR11MB8051:EE_
x-ms-office365-filtering-correlation-id: ef52a163-6ea6-4db9-ce82-08dcbbbbeee4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?2QX+qP2gNQAxg1jj/T69y5EAO2oYXNrRBI2MpkMmqvS6bOLmyHVJlIm+8+Ef?=
 =?us-ascii?Q?14T6nhAlXmbR2CmWNQ2cavIyPK+33qBo1FYwaT/etT7uns8TfRzFk7+zLqZo?=
 =?us-ascii?Q?3vekqSkjlxVDBgX1SR2DBUX6iu5mEo346G68bq9ANBnsUsSnwv+bNVYwjpwp?=
 =?us-ascii?Q?Pujo21559CKYVs+Bhv8WyRbhsIUj/CS7w0EhWTT1SvYs78/euF9Yx6/ols1t?=
 =?us-ascii?Q?aA0KB+nIxP0xWXg5+cqjdxyPtsM53uT4aLFkDC1fSywdUrNDlm4GjUhxO3xn?=
 =?us-ascii?Q?rLE/5oXOWbgQ9gQyWAqa28IxSezk/Gz48BTaLJsSa0ncfbMgGVERzRIzLszI?=
 =?us-ascii?Q?p6C2vRo0Fec5x8m/N5faeEaSs1FN8EB24aYVTkSF8bMXnhSYCRn5AE39he2h?=
 =?us-ascii?Q?Td1JhPQ7ZQyIauy8MS1shaQ+nSRKL0Kwyz13tYkNvkpNUzyLoYDCzEn3J7ww?=
 =?us-ascii?Q?+529QpCQwIFZ0eS/3Qf6Ieg7AWq25XkDsIg5t/oqjGfRml9awo/NxFquInb9?=
 =?us-ascii?Q?t6Aa3DuuEYdiK0PGLVLmu7W3ZA15UPXw7UhpwOI6uIiBzf+APxslXSeean7d?=
 =?us-ascii?Q?lLEezQVXDRu7mArnvB7Ffo0lX61NZrBQYm7IiMackmNO7bScgqePS3J8COWt?=
 =?us-ascii?Q?Az1K8jyzA7W9rDiRnMhlhtUkyhuSLeGHibFXLEqf+Z/tvpLDth4fqjBaMjtY?=
 =?us-ascii?Q?X6p/QCA3/0AKesLxnC5ApdZto0WP2GySSTZA6P0xv6w4TfZzBlsdKa6Sj1Kh?=
 =?us-ascii?Q?w4rZnvrAzwLrrEQg3N1u9fqj/AOlF4dzFaHhxMOjG9azgiHWnsW/XlsrSUxz?=
 =?us-ascii?Q?HI0QPTnV3fQ8TnJdHmDQRhBZ0bgypq4XARUaF/gn/OPzkQsM81nbi6NB3mOI?=
 =?us-ascii?Q?sQ36yitikGt8d3JFqTpVeu2Y4L9k4U41A7prOqXRMcksARv/AfXZ2Rcbt4xq?=
 =?us-ascii?Q?vXAKx9bou2GYAQYH9AOiWWWT4WdHzfSk2Q11t+8kbycKBPjMTHnAlqFTcLA/?=
 =?us-ascii?Q?tcI9qz9WboMaxdUgMb5yXyYbER+9toZvJc3iAoBYUgbuAws/FjYvzsQOcosQ?=
 =?us-ascii?Q?BP97JSGoAewi7Bt+Qq32haPWE0N5AA/9H3KQCp20PplpaCrCtbcuBgwaJLyl?=
 =?us-ascii?Q?WpPBwxpAwibo2SF3iPbW56UOhBjE/h3Cz1PgGuqMTKOkLpRbmSzrmliN2G1/?=
 =?us-ascii?Q?CTRLwa3Q5rIrLpRIiPrqdW54ut5J9YI010XNdcYyP/21mDfC38PXuR5h+13j?=
 =?us-ascii?Q?caCeDTrJPl39KZtVTnVq7qfJesn7IHwy8iEsTuOoMX5DOT1U4MKzTP29VQhw?=
 =?us-ascii?Q?hmUJ/F12WrS/tp4GFsY/aHmJCI+56rADh0PuqBC1p3p5+dSAqjwbfyuxawGt?=
 =?us-ascii?Q?RdVJC2PruxySI/JYUc3ak6+VktTcvNj9VDoGmHNrsDlYlA58BA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nc92pr39xBHZVCjgsuw7xctywEjLhWW3Wb10GCjFBJonN7k8a0DtGGFpH7Ya?=
 =?us-ascii?Q?y8ubBQpm3H2JZZU+OhEcB3BGtH29H0do0kExQNS8znd6Vezw/85U0vBfSOq7?=
 =?us-ascii?Q?iyGO7oLQrMxe4vde8fFEE33n3kr8P2iaxgZQLnID5SCqBWFQC2FBBYKV4DUH?=
 =?us-ascii?Q?dx6omWGC0PsK6rkIiVm1x6L4hFvJc2mIbY2SsAnBQUNJ7hdmRqn8Av1pGnPX?=
 =?us-ascii?Q?BJMpLLtbEZ66olHVvZe4NfzxVuTvm4MCGy3EHwyeSDDubp4XaZJYXEeDNlFt?=
 =?us-ascii?Q?Nv6wBe14xU1rNZuGZLt5KA/6Xm2XBMyY/jC2L+57bsyNouazWDUrfyxxwurn?=
 =?us-ascii?Q?tIMLcO2G4io7aUS8JuhqHbv0x42FrbRMShI7l5KjR3Ped5am/LnX2E2FslZr?=
 =?us-ascii?Q?coy1NoajUciWtNsp4GIIbx5sYJT/rI/3kJGm0BQs3SZaTWgoj9fmgyKUQpOK?=
 =?us-ascii?Q?NCfSYulhbqcwAo5wN0rJSQQhJMuFaNosKYBjdyGevsV9D2K29slW8YzLhzUO?=
 =?us-ascii?Q?voIJQUOj8G1hU0ouvh1GBOz0Kz2GELVF9Fkumr+q4JEy6j3KQiGtdYwMhUWh?=
 =?us-ascii?Q?ZYRNRzIa+OIxzJpdy4AlkQLVKZZnirBq1M4pT7zMo6s6VPjTPO8bKsuSsf79?=
 =?us-ascii?Q?FuScFtEIjq4Fzi0CUBu0cUS1T1g8VDiKSSAsDGncW93MWfELYy6hRff6Q4fW?=
 =?us-ascii?Q?RW83HMlg8uMtZ/016hW8GJZIEYdH4r12iWGbQD9KpDhwZfvKdkQkTx4O3WQ2?=
 =?us-ascii?Q?sq8E4WD7EIcr2bByE7o7TMFVq6yfT9Jd0W6XaWYw32y8Q2JMoxAzaAFDgbR3?=
 =?us-ascii?Q?ZB83lknWq/pkkTkk/sAkASywZmGyWDU8yUSnRtbrWUQQlkdaOZFX/R4VRPdG?=
 =?us-ascii?Q?LupBQUwVeXX1snIiP53uKn1pIAIUz6Oz44dnFVRt3j0lk5OsV+2I3enIL+sB?=
 =?us-ascii?Q?hbq6ztoOXzTIJamO+yNTnHp/529fofvMMVM91Lt53MOyZoh9zUkMRQwgNcwT?=
 =?us-ascii?Q?WgbraB1I5eNS+Zp3VSW7b79QLzPFiHDIJ28HaLpddyuISpJMHvIgXkUtDKXT?=
 =?us-ascii?Q?z//BJFQCk/nPS01Q+YCWP/Z7zKNRoIjwZpNDZXQkvTSSTuHIGImtAHN7fMCi?=
 =?us-ascii?Q?xqFZfnaFfuHPXK1xNMnFUAYEuBDU9eslEd2X7/LWNqoZRq6lUPaQzCv0lnzq?=
 =?us-ascii?Q?+OUMKLL3os1Hix7IO6oNSwNl20vy3GtQtwdxgdSVooVLBjvk3x4qIfyfKox9?=
 =?us-ascii?Q?yiugRAWorZhYz4p5S6d+4l8zk1OdccRggrjfWvh2g/w179p5r9w4bmfaTkwD?=
 =?us-ascii?Q?pBz4I21KA0zbxv/j0/AEqk+S30tWa66u+1dNi2R/xqpv1tptHIl6zgryfSWc?=
 =?us-ascii?Q?gk1VU+oCztVxV+NQkq0V2sxp6EPsDyEUMwvJUVNtDdYkNaBULb6cF9uUb5ad?=
 =?us-ascii?Q?/zbv+kQAnYHGxZQ5gnK/risqo4iHwxdu0AWS4texxuHRczHswuP82R2UcqPk?=
 =?us-ascii?Q?b6kx6661ByvlFv2yQxuBLmi/NVkP5/wjKKeeis9Tt7aovyn+D6vb0AbPTv0/?=
 =?us-ascii?Q?I9p0x8kgoGYAa8Tww/5+pv3gWL9dtvZTDFVicor1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ef52a163-6ea6-4db9-ce82-08dcbbbbeee4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 17:18:22.0502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ok7rlh/yGxJ+Iv7miUZQ1G9PmoJDZHuqSp7UQkzqZKrde56bWBEi/QPY7fX9vM7UYhezQn9XppqzW2EQ++kK4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8051
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Arnaldo Carvalho de Melo <acme@kernel.org>
> Sent: Monday, August 12, 2024 6:26 PM
> To: Wang, Weilin <weilin.wang@intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>; Ian Rogers
> <irogers@google.com>; Peter Zijlstra <peterz@infradead.org>; Ingo Molnar
> <mingo@redhat.com>; Alexander Shishkin
> <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@kernel.org>; Hunte=
r,
> Adrian <adrian.hunter@intel.com>; Kan Liang <kan.liang@linux.intel.com>;
> linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; Taylor, P=
erry
> <perry.taylor@intel.com>; Alt, Samantha <samantha.alt@intel.com>; Biggers=
,
> Caleb <caleb.biggers@intel.com>
> Subject: Re: [RFC PATCH v18 8/8] perf test: Add test for Intel TPEBS coun=
ting
> mode
>=20
> On Mon, Aug 12, 2024 at 10:24:40PM -0300, Arnaldo Carvalho de Melo
> wrote:
> > On Sat, Jul 20, 2024 at 02:21:01AM -0400, weilin.wang@intel.com wrote:
> > > From: Weilin Wang <weilin.wang@intel.com>
> > >
> > > Intel TPEBS sampling mode is supported through perf record. The count=
ing
> mode
> > > code uses perf record to capture retire_latency value and use it in m=
etric
> > > calculation. This test checks the counting mode code on Intel platfor=
ms.
> >
> > root@x1:~# perf test -vvvvv 123
> > 123: test Intel TPEBS counting mode:
> > --- start ---
> > test child forked, pid 2600160
> > Testing without --record-tpebs
> > Testing with --record-tpebs
> > ---- end(-1) ----
> > 123: test Intel TPEBS counting mode                                  : =
FAILED!
> > root@x1:~# grep -m1 "model name" /proc/cpuinfo
> > model name	: 13th Gen Intel(R) Core(TM) i7-1365U
> > root@x1:~#
> >
> > What am I missing?
> >
> > The current codebase is in tmp.perf-tools-next
>=20
> acme@x1:~/git/perf-tools-next$ uname -a
> Linux x1 6.8.11-200.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Sun May 26
> 20:05:41 UTC 2024 x86_64 GNU/Linux
>=20

Hi Arnaldo,
I just checkout the code and tested it. The failure is caused by a seg faul=
t on a
perf_tool struct that is not initialized correctly. I think this is related=
 to the patches=20
on struct perf_tool in this branch that applied right before the tpebs patc=
hes.=20

I was able to fix the seg fault by adding the perf_tool__fill_defaults() ba=
ck. Since=20
Ian updated the code to replace this function, I think I need some advice o=
n how=20
to use the new code to initialize perf_tool correctly here. Should I call t=
he=20
perf_tool__init()?


Thanks,
Weilin


> > - Arnaldo
> >
> > > Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> > > ---
> > >  .../perf/tests/shell/test_stat_intel_tpebs.sh | 19 +++++++++++++++++=
++
> > >  1 file changed, 19 insertions(+)
> > >  create mode 100755 tools/perf/tests/shell/test_stat_intel_tpebs.sh
> > >
> > > diff --git a/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> > > new file mode 100755
> > > index 000000000000..c60b29add980
> > > --- /dev/null
> > > +++ b/tools/perf/tests/shell/test_stat_intel_tpebs.sh
> > > @@ -0,0 +1,19 @@
> > > +#!/bin/bash
> > > +# test Intel TPEBS counting mode
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +
> > > +set -e
> > > +grep -q GenuineIntel /proc/cpuinfo || { echo Skipping non-Intel; exi=
t 2; }
> > > +
> > > +# Use this event for testing because it should exist in all platform=
s
> > > +event=3Dcache-misses:R
> > > +
> > > +# Without this cmd option, default value or zero is returned
> > > +echo "Testing without --record-tpebs"
> > > +result=3D$(perf stat -e "$event" true 2>&1)
> > > +[[ "$result" =3D~ $event ]] || exit 1
> > > +
> > > +# In platforms that do not support TPEBS, it should execute without =
error.
> > > +echo "Testing with --record-tpebs"
> > > +result=3D$(perf stat -e "$event" --record-tpebs -a sleep 0.01 2>&1)
> > > +[[ "$result" =3D~ "perf record" && "$result" =3D~ $event ]] || exit =
1
> > > --
> > > 2.43.0
> > >
