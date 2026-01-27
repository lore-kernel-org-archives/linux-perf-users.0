Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8212C2E62B7;
	Tue, 27 Jan 2026 02:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769481995; cv=fail; b=lJoLHB6JESlHRrSmhCoQdmNSM5TayWHCm2g0+XL2ZHn+olxIX12OoPSuLX8SqZgV2JnrELPsTFVM2oe0QHmXeL0cu4TF3F9atvwEFWjtQ/YwfHprU/BXuAjAdGAzqt9vaYKCl8+RzZOoSbtS/D/GKY/63XiZZCHvt97XhNPOzZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769481995; c=relaxed/simple;
	bh=FuS4ceyyXzECG9QOPaMTePrfJTfEskanKAZWBgLIVKE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R78iSzoCoG1kC4+1F2SFndPb2VI+YhVuJrR7J5Lbrzk/gUfVuLtYjIJXKVS5qeCNZaAQU8XS/UpFw9rKHpM94Bd+VqXnW+MIlQ2TFKHwrqLk+iBAEexlpZvmdsWigmcpt+C+0DGeS9T2gKaSa90t+zPkSmY3irk9Eu9hSCZvG3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gGv1XuHK; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gGv1XuHK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769481992; x=1801017992;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FuS4ceyyXzECG9QOPaMTePrfJTfEskanKAZWBgLIVKE=;
  b=gGv1XuHKPqCSuX+Whpy22HZehTBfEP+ePxpVmd0UVInya7Wns8TWH3i2
   p87PDV74c7bqEVwa8wzjM4TesgVP28klLBMVrgKbA76t5CFqka1fs0sSg
   FPh07RKK7FJukTL2nrkcGl++radXeJdcp5KazzNZ+j1IZJkjeAUpNXeQN
   To7AcckKB0ikWOHx43It4JoxUfVtNIY1qsCboyo7HvXpmt4D0vFHbDL4R
   G4m1wXxF2hr9p0sBML+bYLGwWZl2QxgkIZ0lKCugyGQVUw+SoHCLR2wiQ
   R9gYLqmMf/aj4ZWThmU2mozzepPVHc6J0KJe1Dxg0uUAiHINvk1fELhcC
   A==;
X-CSE-ConnectionGUID: Kc6PdHTpQmuBgcAPjwgqDQ==
X-CSE-MsgGUID: cA3TQcxVSa+EI6SEyrOMsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="82097072"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="82097072"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 18:46:31 -0800
X-CSE-ConnectionGUID: bVBevrZ4SxansV55vSv7KQ==
X-CSE-MsgGUID: 3+l4YXcdR8WKB9odPnrUMw==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 18:46:29 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 18:46:28 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 26 Jan 2026 18:46:28 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 18:46:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpSelBx1LokB4zGARd1bao/uH4o0lhlkMpFf986oBF20Ds6IgDfS3VvpjUtgXRADfgq7wDNe+dSiqaPiTp7xDH3cyVwSyIAB2eR+HV/BpKOApXrCHH2TPKM4Rv1bw4g2qqyJ6d4xaFpT88jCHeACsQFhbrSUaKDYJyBgtAVVNGoY2gbTDcwG4pRoXOjZ2PmHBK42BVmVzu6ajt3NuVrOemUf7qbKqdqXDxwBIXnHysOkbDX1rJxIKdE/pbfdidna1kMQIXu4hGef5bEfULi1PmsnvrSvn+fpeecW5y0xUwyQCdnnFLz/UtlWmYmKH0aGvqaVicGrD7wbf0bacLGcmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZNAsJ8prChkQAZddQHmA0HLzxU1curwftIaXFjtBZ4=;
 b=CBDTAd76VvMRC+ScaWuTcxAfP0GKZfe75dllRxQ6wzPTY5FY07emSZKXk7caU7ubb3RHJiGLWtsjqiXmgNpbCv33+gb6p79SxkdouRxKIN4Ud+3F5NiGkhis+Mz/JcHiUJALNaNeP5x/fmyeh8p5gMUnKBdMA9tTH2gTulHnD0qGtLwrYTv0NJ3qCFVBKNIUvhjF0tV17syBw0PPEPyn6L570XT76vnExBZb54c1bJRAKEClfz7XZPlDBKqJ2OmAWhHEIqJTXGMWpQO/nXgC8aqLb23e472zOpDjv+8Dfdp2cK7u+zUVV/AEDPTmDC88PgnIlNvR58FypE9732jVeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS4PPF708A6BB3E.namprd11.prod.outlook.com (2603:10b6:f:fc02::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 02:46:21 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 02:46:21 +0000
Date: Tue, 27 Jan 2026 10:46:01 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Ian Rogers <irogers@google.com>
CC: Swapnil Sapkal <swapnil.sapkal@amd.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <namhyung@kernel.org>, <james.clark@arm.com>,
	<ravi.bangoria@amd.com>, <yu.c.chen@intel.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<sshegde@linux.ibm.com>, <ctshao@google.com>, <quic_zhonhan@quicinc.com>,
	<thomas.falcon@intel.com>, <blakejones@google.com>, <ashelat@redhat.com>,
	<leo.yan@arm.com>, <dvyukov@google.com>, <ak@linux.intel.com>,
	<yujie.liu@intel.com>, <graham.woodward@arm.com>, <ben.gainey@arm.com>,
	<vineethr@linux.ibm.com>, <tim.c.chen@linux.intel.com>, <linux@treblig.org>,
	<santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: Re: [PATCH v5 02/10] perf header: Support CPU DOMAIN relation info
Message-ID: <aXgm6US3q2n3nzVS@xsang-OptiPlex-9020>
References: <20260119175833.340369-3-swapnil.sapkal@amd.com>
 <202601262235.ee84b79e-lkp@intel.com>
 <CAP-5=fXU9XcyFRv_zbjsg7HLr8S6BLjvNiwkF-a+Fv_78+16-A@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAP-5=fXU9XcyFRv_zbjsg7HLr8S6BLjvNiwkF-a+Fv_78+16-A@mail.gmail.com>
X-ClientProxiedBy: KU0P306CA0082.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:2b::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS4PPF708A6BB3E:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e21eeb-a4bd-46dc-d915-08de5d4e40ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P9H5SVjBhlcd12eZ2vKmZYr34/uySkOL2M9tvJAsNqrq9LQ0XE3aLE/6xRoC?=
 =?us-ascii?Q?3aMyiULFpP1OTwYkTHcVC9V+lKv5anLDPhNFtF3ek4zVt6R/1HLLhgsdAitz?=
 =?us-ascii?Q?FOR2uhtGN/pZ+kOGyjufSKi4pwzw2sENNIs77BZEer85MeRXvt0YV/OhjMDt?=
 =?us-ascii?Q?aJidAGa1mPYsw55fmG17aD9Ar50kewfZNgTHUaDL0lewBTQ0Zm65pRsRmejv?=
 =?us-ascii?Q?dHpqIZX0sTy7yiidOYmIzUneyIfPE3Hk94yVzPbKeYA/f/kl9lMsmy94DBO1?=
 =?us-ascii?Q?40DNnStD/X01IPMpG5psMyt4g4Edyzgvl+zM8I6t/Lksiw4ZCSzDRABkBN0G?=
 =?us-ascii?Q?AK9HeF+C3VQIgcxIL/KHpqNzJwNPiepID7ojvnO1OzAYw7LZf6fTLekaaZ7/?=
 =?us-ascii?Q?PfqgiegIGpxCu58Nyi9Jz8SlrN8evkNI5GgwJUtKR0i4tw/sxl+i2YaAgAfr?=
 =?us-ascii?Q?sPo73oYhZCCcHm79eH36WrwGtx9B+4iRbj0hJgeAHBrejtxhp2e7shXLMWzX?=
 =?us-ascii?Q?DguJ1Hf6vYRdo4KUtmc5gNQYVxr0tkQglwFyN3X54FVBncmroSRAqJywo6rN?=
 =?us-ascii?Q?EL+5fm6ey0qpS8G7sD/LdTJmmo9T4mOcVWKdgLrtat+wHK/Y0QtLOVY43IDo?=
 =?us-ascii?Q?PBNcgyN+hRZL03Q1iwSg5ut3uSPhps2o8umg7KHhy+Ib5KluZkUWHbEg8jVQ?=
 =?us-ascii?Q?4Tit0o+zpQzCdTLfJphZ30snuAwtO55KYh1hF+DfPXjRlP4Ggz/Pp/4FoPlk?=
 =?us-ascii?Q?6cFEPPEEA5VLTKqZJxmXHZuY8mbA7+xAQ3L92kiMa/6LWPh89CAl2ev9pj9x?=
 =?us-ascii?Q?pu6+5T2EblKGlO1lCTZUjGfXtdY+wHvShMgFHll7AzpPDWMNl8sXvMIO5USk?=
 =?us-ascii?Q?Lcy5mQPECYgqEm5hgT7ocTCoytpoPyBtN5Lr/vAF6VbLT+l8oMnd1iFOmvgI?=
 =?us-ascii?Q?ES1EOVFjDvQeCx4WqphTk1K+vf0jZ0qiatL68hjrNFmHc8G76iItMN8s/lQy?=
 =?us-ascii?Q?GEHC89sJnu2spEdAn1dvOZXww3NcXd9ijsAld/u5bhxv6q2yygj0fc8LjIou?=
 =?us-ascii?Q?6DRLVdTlf2ipHLFBSUtvv9+xzp1WusEy3/ggVynEHhfpmGc8ZgyzPIGwX6Uu?=
 =?us-ascii?Q?64I1xlzlx2zk+sihMLtOcV8RxpoS9gnnYigiKgVbfONmmDbWckWQHVO21t76?=
 =?us-ascii?Q?nSAp4wvvTUZ+dzw5kh5NeeIVDt+p/k1dfFsx+qarVTq9hk4SqT12M/oRopQi?=
 =?us-ascii?Q?V78PWlBF2xczFZLWDa9zRBWQeu/GfLttOX/mwd6xBL17IshiG1QN0O6oR+Ql?=
 =?us-ascii?Q?1TjIinD818H2mKvOTHPLNvprPZC/tGOUFrCWjq5GWCaJ/NEbuK6Nl0lJAF6e?=
 =?us-ascii?Q?Xfl6S7r4mPM/yrZxnAxCxdpxlfhaXdFETl3vj/+CWTEcXBJ+Dvf2JKINxxqk?=
 =?us-ascii?Q?iTOyQbL59rPMs5QYavhu+mVQNYNz/6nyQKlCUiPXy9gUYRlZIFoyO0sh3vET?=
 =?us-ascii?Q?F7Pw5VkNPkfN+Yr7moqJd8E2IQsq15WjKbvCbhnSrz75idWVBoGy/EE+P8cP?=
 =?us-ascii?Q?adyuGorgfQ//hM+dnsDv13ToOBnkRaQz3jINMHSc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VZST479WrkpULgzzNx4eKxJ2gxVAx0VuYGtT52VBtYIFQ01+Xw8PdICLKkYr?=
 =?us-ascii?Q?z/A44CgwIgpuRvAlGBlfqRj+g+4UDQuRagA7Izd52Uiu2aAJr7prH/GRWwBG?=
 =?us-ascii?Q?4OCIr+2E+ICtcw8ivdsSmSeg0c7LTIgP0vWB/EbnSo6acUVIewhFay11ByVX?=
 =?us-ascii?Q?0giszYdWecuy/gY1cfBfckFItx+F5haTph0BafUlZdg4LU7R+sMBzxv/MAEP?=
 =?us-ascii?Q?p8mXhi0k6IXMsU9O2voJNiuFaA/Hr+GNUfcoBwFV8LFFsgPcWLT+V9IQEZ6/?=
 =?us-ascii?Q?qX3c7O9+oNlWac6wC0Wvn57KPWJbzpXABr9Tuh0jy1yTalZoetYV4rNiqYwl?=
 =?us-ascii?Q?BskbLrAQuzk1pDC5VjBzPIPlrJjfRPyEtMOs5OaBX52K7PuWY8b1Vq0uUrje?=
 =?us-ascii?Q?htNfNPnpOdmxYHkgUEQrG3dGWjEtruCetsqSqyxS/0KeOIgd3AdLRoBUJ8tW?=
 =?us-ascii?Q?gL2d/YciqzylJGrvcvOk9tWzcOi809JjBiLs3AEREP5AGgqPiQbkNHi9XGXm?=
 =?us-ascii?Q?r9NOMzKUYrJeJ2mTTJmgFX7/9cVP/HNidgGmnHfuWdRR/FUDbg4EZ2TFFYyJ?=
 =?us-ascii?Q?6x2D+gkl4TFNZxdxtw6zfc+zSnIEUz8QZpLN4lk62aTD/1yYilqx6i4+2P3I?=
 =?us-ascii?Q?+mE8mlnEqDHLzNLIfYOgr4kSbOGJuLVUJDSd8tabHeMI7h3UWaLp3+FMC5e6?=
 =?us-ascii?Q?iLwTOlxT4dM2Lfn7AwnbpTjE7h9ks2VFCTmoXGW82EGxS6iyM0+PMOK/T7PS?=
 =?us-ascii?Q?6fxr7RDSvhqHDLpHyF2BDWCuOOjAo4+b0gqbf+uGvnSiTvJthG9HBegBbdx7?=
 =?us-ascii?Q?d0dOTRB84wT3bqPKNBwSQ3AMaB//a4Ahutbj9+EDOTBaUkaPMaqOhjhGVBeu?=
 =?us-ascii?Q?60kbDoumvSRp0hnGMcKYXSvB6pbvkXCrn5sbCd9fs3bioI569g3AyUjSWzEp?=
 =?us-ascii?Q?oPw0pD5/m72zplpNMzH2VZ9GzakNu4JjbRAaSxE9rCzdUJm03LJUig3IU+VW?=
 =?us-ascii?Q?aym7ucEOWevN6cZNs8ribFx9FXEonTwfkGP3+UMEd3Ai8JXZgbTn8le28Llm?=
 =?us-ascii?Q?TadDVGskgq2LXLdOzFYGtzHU3axoHdtCNqueXUNP8nqkRxJzqyfPKTEdLqeb?=
 =?us-ascii?Q?XCLqO9WzJ7YlMkIvJD2+lFfhb4CMq+2rzyOvYJAh8QzRzApHLsJIKPLjzt3j?=
 =?us-ascii?Q?LPJ46U/U+DjaeanbA2BGxHAC1fOhET6fnnSbm6Uu655OrxkDBDuoo3chDIdz?=
 =?us-ascii?Q?jINlOwlD9dQep6/d4l7LOLc1ZFvH0DkUgLAeI2g81I7jfxaWjE7hVP58weEp?=
 =?us-ascii?Q?L/Y9KyYRhBYaKwirCSIjBti42xfPdAAB9SW2gCbwCLNedb0YYGzlPmuc1tF2?=
 =?us-ascii?Q?PI0BlbCgFzZ2aJkvTjo1ihiMU7GczTZZeSX8A809ubNZTd8hIJL9NTbMVUQW?=
 =?us-ascii?Q?UyATtrCHsUG5Ta4oPCOVAAiK5VCqBPpntmzY9KleB01Wb9L/npBetd+2Ch8p?=
 =?us-ascii?Q?ROjKggs5H8eXpc7WhjWqHhrPmZvaJimhbTjLl/zglJutfIXOFPTwF3wh3DW7?=
 =?us-ascii?Q?gTxWBor6C4Z/juAErr0m3Rk3swEvEUYJjdDcl54/XTljQA/gLCswfg+S/dRd?=
 =?us-ascii?Q?SL4kWQJr4ISL1Rm58U3cBomj5KJqcCxTSyvJkhqTVbNmj67zmcq8CoUjweDn?=
 =?us-ascii?Q?INYZKqzP5pnW8OvXmfIBuImS3hyE6+QALXakNJxtGmGjVLoORh8v6lv5SHWZ?=
 =?us-ascii?Q?UYyEZTmouQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e21eeb-a4bd-46dc-d915-08de5d4e40ba
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 02:46:20.9484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqrcYyC+4RX6PsNQ819aQ+avb0mfWAlDhr2d558IirLc5VzOyd5ANOwI3s8R8Fn72d0VDydQ8Hx8Cxcdhyza0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF708A6BB3E
X-OriginatorOrg: intel.com

hi, Ian,

On Mon, Jan 26, 2026 at 09:12:58AM -0800, Ian Rogers wrote:

[...]

> 
> As always thanks for the testing! I believe this issue is addressed by:
> https://lore.kernel.org/lkml/20260122213516.671089-2-irogers@google.com/
> which is merged into the perf-tools-next tree:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/?h=perf-tools-next&id=d84f24c898864facc13412a58b78964f6a769d76

thanks a lot for information!

> 
> Thanks,
> Ian
