Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CA330C61B;
	Mon, 11 May 2026 18:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778522728; cv=fail; b=DV2HoT+8Dix5Jt9QeWtryxMn9sHJlMYlIz/pQStd1scg1oVIlywGzOGggP1qBpfPsq7uy7PlLkI2AK30Ci8UqMyDg2OJtE7X7+Lqy+iRESsrCO62/SxSVIXbcAB6IlFAQm8dFvIqmKxaJlQniqDTfdRYPQ8oRM9+xNCHLNMmges=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778522728; c=relaxed/simple;
	bh=5wZDwfTP486i1T0atZUAf/Y3t1S+lG+6PDCq4zoh9OA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GZkNyjS2L4kSbTtkok50sCu+pZs3RmsJtN8aB+t7Fh8U6cl2Utb+UsLVKxJVYwUI2CeMe8fe5A2Cz4+8EuwIUmv9DfaOgJOb9+QeEhkK2f8oBPoazSTV5TOodEpVe1hfBYvREXStXhvYwULdt//vIyukLvF/Jn3NCu/0tP+sGxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N2AV4ADK; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N2AV4ADK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778522727; x=1810058727;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5wZDwfTP486i1T0atZUAf/Y3t1S+lG+6PDCq4zoh9OA=;
  b=N2AV4ADKWc4cXomkv23iPRbSTnZVyGvTmB7NgHn533T9oH8jx9wjMM/Q
   Lbqs2mwlknSCPq/evW5AEtOu92mpp+XyrGN8BfGGGEAkSkC+Vh6IKqekF
   BhE08vFYcNV/P9h4VE4FndxP1vHQ27wP9hCKD57tqEQ/lygptS3u/X/2R
   QVA4h/TOfoiBCKJ4p+k8RUwH+SPHUJIV2+rpZHkBgidRV98a3RMK/m1UX
   +huxsS/oPDZiKCTGidUoV/nJhHw4es478RLo7P8uoU7gvt5WFUEpuuxKV
   N8yZRzteRdRcCBXxEU8aY/RocBSkYCtjgwNJW86/kCUin3l+wG0iEna5V
   Q==;
X-CSE-ConnectionGUID: pzv7fJiGRLGbjoEIsgprkA==
X-CSE-MsgGUID: rb3vC3JBT3yofX1qCbTgmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="78450097"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="78450097"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 11:05:26 -0700
X-CSE-ConnectionGUID: C0uQ1I2YQNKk4oXc4zwvzA==
X-CSE-MsgGUID: FbAnGQgFQjW6GVV97VtMQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="239350023"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 11:05:25 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 11:05:25 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 11 May 2026 11:05:25 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.4) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 11 May 2026 11:05:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjC7x495451t1LhpkuJZWOsATUgDyk/jSKfXtcvELmnvXtMwlqME4Uz9XukRRIcYSGYPeDqesmhFdAbJoxRJhGYNUUeinjSD9zIZWpOMPY1Xdf+8b1bjFeFOE86VIEkpeB3+YZDrPryaQx07lEmG3tn7a5F4FOvdiVdSF4mFLtT3oByExPK7FrKuuClHh+7cZCG5BADMh14xHcqGT3BVfSCvi7V8IgJWGrLLi3BOXZk49JNoLVg6OPFjRXJqox5iHTcSEiqrH6+T0KQ63kh9ICR/yoS56fMMpHw7gN3dmU7nqdJmibtx9RIEH41UShIQKsXnh9CwFByGIVSpPDneag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wZDwfTP486i1T0atZUAf/Y3t1S+lG+6PDCq4zoh9OA=;
 b=jUBBE7lbbIpwZ8gGWOLliT9ThuK0c4yHrWkJHmEiWcrbvbswbg1JIwf+Dqq76uc09oxX5aR+QPQ5KSuQ6hVrJ++w7v5hBIxUcUi61N8BwVXZ3bRh5R+2crbXwcg6/JoZWHC9uungpmSmvfUmFepE7x4mYJJRzIvJhY7rxwnjSp8S3eo48TYRDtHg91GLlXSnzghDtuMDPMM/6dZK8fBNylHbnY2d/d8xKXL076teV+WePemM9Che02AVwJbSxl5I3E2OQEIDnFPXHspRIeWj8+tIsY7jeqvsenUiiIurdH67J0ERvhUFwzHDQMxjWMqTYXaGwxYpzK+yD7uHJtddNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by LV3PR11MB8577.namprd11.prod.outlook.com (2603:10b6:408:1b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 18:05:22 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%2]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 18:05:22 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
CC: "james.clark@linaro.org" <james.clark@linaro.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"acme@kernel.org" <acme@kernel.org>, "namhyung@kernel.org"
	<namhyung@kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>, "Rogers, Ian"
	<irogers@google.com>, "Hunter, Adrian" <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/2 v2] perf: Fix missing branch counter information in
 script and annotate
Thread-Topic: [PATCH 0/2 v2] perf: Fix missing branch counter information in
 script and annotate
Thread-Index: AQHc1+1hIRA5WYlqCkmCZBwo8axspbYJMZoA
Date: Mon, 11 May 2026 18:05:22 +0000
Message-ID: <4e61558361aa6d7d6a51b376109063f2aa004c67.camel@intel.com>
References: <20260429152917.178803-1-thomas.falcon@intel.com>
In-Reply-To: <20260429152917.178803-1-thomas.falcon@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|LV3PR11MB8577:EE_
x-ms-office365-filtering-correlation-id: ba5464e2-0630-4631-7ef1-08deaf87de88
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|56012099003|18002099003|22082099003|38070700021|3023799003|11063799003;
x-microsoft-antispam-message-info: fCZaQm/4F6c4QcU3HyNSp88dlUNiSYwxFoEt0NEMSoKZp+6rPvl/VVTwjEoi2J/3aauUgimnH7syLD1CBD7mBCff3gfWnyR09lwzoqjOL15R/OamqFRI39Y3xswpaBu4Gc7E+Mb/ID1Wd4KIwt7GIH05vyCy4DE9A1HDwOtZ0+BmSJ4g6zc92w9NKXAngGwN5EeJaZuRG/kvhDlElroo+PYZPPFgI/WQX+ALpV8vuhkDeoLi8787ZV7sV8JiIIs+KHJrgw+GDlM8FoElyUXJtyjRbvdEWslg5mGhQCZapwx2RfnFouvItnCO4iRVP9Ne9XSu6PW6Bz7246KGo/5dni5xXI72HEz03otDKvh2h4K85e7+M1gq1tH2F6AimjzTfVwy8J/NqkJxPxn5X37t/waxPkbVZKDYMzdoKbfv2Ws/vXRY5l5/gFqL6Hu/fb1sZI/U85YaisIvQhXQnsUkdOydTyG27DkFQJPtv2mqiuTpSK8kv4ID+YhOQVN5PLoUTe4WJjDaQnzoogPEaY7JqIjm30ov4QFcNYa5s47OsGkSrNJ5Bc+0YYnEwsPJm7HCuSXr/2mr74LLzrVpVUE/Y1IYhdMi29TAQ/Q6qaHBNtcenS1dMW4vd7hj/tn+0EuqE8yKbmPOX8qoFx/ryu2FWbNL764VviNvfAn0X7BYhq2njxnLx2d7KHvkn7AcI/Sj5J5aCEOUCfazFX+HlFGsBBwwfF8pEIzMl0pTBLvRgOprHA2+xPeYfKfLqXSSkUBR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021)(3023799003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWJ6VkdwVW94MklLUWNYMmJGKzlmWnpYbE0zZ2NDb3AwVkh6REVVRUYybyts?=
 =?utf-8?B?Vzg0b0F1KzNzb0RqOCtSS0Z4YUk4QXlFYnBKQndSNWNGVHplK1BtTktZTHRX?=
 =?utf-8?B?WnJubTBYNlpKdklFQW41ZnB2MnNNZkNLRHgrbkZrMUE3NmgzWEZLaXBLMUFr?=
 =?utf-8?B?bFZqT2UxcUJRbWFsK1JqR29ObkFmOXBLZHdpellsOXhSMXBCT1NnQjlscWJJ?=
 =?utf-8?B?eHFvWk5ORUlVODd3M1FoMlpudmhGb3Y0VEtWeWZIbDZ2aXNHVjd6eXd1a3Ez?=
 =?utf-8?B?cUN6ZHMzazY5cVBpbUxJdW9Qc2tuVnordndwMWtMaDUvVy9wWmh4Y3NSanRm?=
 =?utf-8?B?dGl1NFl0QkVxbzlRZ2tjaW4vcTgwZ2hiQXhaQVlsQ051bGtPL3FIMFl2UmZM?=
 =?utf-8?B?bU5teStNVU4yb3NNRkhWZUhpV29zUlIySTN6TXJKcS9JRHR5QnFCaUlqK3dp?=
 =?utf-8?B?bDROanJxUnVYcHczbFFvVzAraWtmR2FYbXBEclRUSmhrWis4cGpEaHgzRElz?=
 =?utf-8?B?L2JlWk5JNkVPSlZ2YXA0c0huS1E1QTNiL3VRNHNMNjNXU3E5aWp5YUNBd0FI?=
 =?utf-8?B?V0l5cXMyRExBTTFWUVcvcXhNWmtINmUvWVJtcXBHQjRVclVqQWZXL3VaNURE?=
 =?utf-8?B?UHJ5QnNabzUyUmNmZGVMczRGV2tkb2FocHA5MGp1MUVMdVRhQzc3ZjZhTjA1?=
 =?utf-8?B?Qk9jUFlJRXkxQ3pNSHA4THpaTFRJVVM1TXFwUDA4RTVKbE1DWEJaRE9relVs?=
 =?utf-8?B?dW85YlRqbVplUEVUd3d6T0YvOGhKN3g5ZVhqZnZ5M21ZMHNTT05JT3FUa1Aw?=
 =?utf-8?B?bFhHKyt6eG1aWVhMam9ZRXhJUzZkS29jQnhSUk1qaHg4NkJvbzBtWGpnUDYy?=
 =?utf-8?B?K0NUVEw4b0xoUzBLbTZ3bCt2R2psR25ub3NQaExUY0UxVUhFT093Ykg0cGox?=
 =?utf-8?B?RElYSndMU201cURLWkwreEFzM29rbllWUVRQQmVTeU94M0dIWCtSUUFieUhk?=
 =?utf-8?B?SDJ0MHpDWUN1UTQ2UXc0Q0VMWDVSVnFTSGVJR29BK1huYlNCRkdvOExjVnlL?=
 =?utf-8?B?b3pxL25QUjFPb3U5SjNobUVDaEpDaHkwMzBDSmo4VHlmRzJBYkFEMDhyOW9H?=
 =?utf-8?B?R3dER1pQQ1BBQTlmb3IxQVN1SU9TMWFBZVB1Ym1EV1V0cjFwb0thT0hZc1pn?=
 =?utf-8?B?YzBjcVdkb2lNUWdVMEcwZjRzQ202OVN6Z0ZvK0VVZnJNUmJKdXpzbStFamUx?=
 =?utf-8?B?OGxCdU9WbXlDMWRkMi9JQTFOMGpiVy9UQUZWQUlMQ0pKNkREV3M0N3BHc29J?=
 =?utf-8?B?U0RacEhQNE5SdkVkWStmZEVFTXRGVllkdktWVjV3a0FBVTZJOTFTTnJadll6?=
 =?utf-8?B?ckdSWHhUL2N5Uk1NOVJiaEZNbEIxbDBIWE1uMUdtYWN0dnpPNWpXeTV6NVdo?=
 =?utf-8?B?RWlUNXJ3VWk5RmNvalZINmZEckxNR29wUlo2MzV5V2pTNDFFQWhiV2owbmZT?=
 =?utf-8?B?bElhWjQvaXE0b1VrUFdXYjhNNUNmVDNrd3RBazRuNXRpNFZDNFQ3UU9UTWJS?=
 =?utf-8?B?Mi9LT3l3QnZNd1RxYkFpZlFaRDU0YXowWURsTTFxQXA1RFA5Y3c0aXVUNEl5?=
 =?utf-8?B?aVArTjMvU2JYZ2UvSk52Rm5GcS9oMURsMFY4WkpVTFpnTzM4clJpWkpGVWh5?=
 =?utf-8?B?ODJYS2wzZlI3bHdGMERCQzVYcVhYdWx0ZWt6SEIxNXB1cldIYThYSU9nUkZp?=
 =?utf-8?B?M0htdkkwUm5wSW94eGVyeFpWdEp0NSsrdE90ekl0b1N4SklKSkRsZEx4N1FT?=
 =?utf-8?B?VTlMaGVuazJnV3dvN2VOSTFGM3R4cEdLRWtIbnluZUt6UnAwRGZvL3ZEQ09p?=
 =?utf-8?B?Z1BKMVBOS3cvQmZJWEt6cDR5VjdqY2VkOTZYQTFtU0lsUHhweitqVm5CS1Bk?=
 =?utf-8?B?eXljRG54RWtyakFIa25MZzBEeitjdzB3U3F2azdoYmJBRWlzTzYwRHlXV1Rh?=
 =?utf-8?B?WGNmY1JGLzBPOXVuREZtS0hFaWNoTHhrYXg3aS8wemxMWlZYUk9QMDVZaVBG?=
 =?utf-8?B?ZkxaWTRWRWNReTNybGFjUEhMZEQ0Zy9DRTZQYk1uaDYzNDFtNitmUHhMNE1x?=
 =?utf-8?B?ZUY4RVNEQkVqcjVRNnI0T0xtdmxER3Q1R1FGRFlQOE5qZS9jMUN2MjVZMDFt?=
 =?utf-8?B?UTF3MFQ3bGw3bnlBamRZM0hVbm1hOVJ1NGRUbnJpeW5adzdKSzZKdElXNlJs?=
 =?utf-8?B?cE5uRkRCREZJTzJuTS96ZXl5Q1gzcGxnTUZRS2x1TEY5c0dwOUZ1WGxMd2ww?=
 =?utf-8?B?bnVLeTcxbWZ0OUVFN1VUbTVvKytEbTB3c000ZVVwQlBGZDIrL0huTDBpV2lp?=
 =?utf-8?Q?h9yVcYe2318yrfc+hzjmbA1ZODqGY4qlkGtlgScJwsL6Y?=
x-ms-exchange-antispam-messagedata-1: GPRlCc+uBcMqWQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD15595BFE82414AB14F3DD2DABA96F4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Hq+W6a49DwcwmBrl7XqA6zkyv08Z0r81HA+Dg2RhsY5q5bbPHj8blnwMo4nvq+y9tcq8tAAPUSRxZv6idy4p+JwRnUt+kT8F927GYOdmcLr+tqnqjKSzWTZzLENaSp4/l7AAsMpzlwGCcvn3alt3drUMOSsu0RTkPw3WkdPct7j++wImJcmhxE1l90M4OAoZakTBjH9UESqrmk95E0ma9h0WnSnlF3NK5i6bRXePNwhAbip2AZqFosqeLybXd1+tdYmasDuHbIXMDkn806vb1OScOizJekeatvaLDUzp2FXnZoouDqHvoSplQT5sLEVHkMha7UR5Bt/agbKImXiXug==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5464e2-0630-4631-7ef1-08deaf87de88
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 18:05:22.1704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nXN3K6/vE/zHXeu11l/tvosOWHf+39Q0li5mVuxjmI0Kco0QzQBHOiX34FWT5zUbK/arD+cDWHPQzTeUNyXMEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8577
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA0LTI5IGF0IDEwOjI5IC0wNTAwLCBUaG9tYXMgRmFsY29uIHdyb3RlOg0K
PiBUaGlzIHNlcmllcyBmaXhlcyB0d28gaXNzdWVzIHJlbGF0ZWQgdG8gYnJhbmNoIGNvdW50ZXIg
KGJyX2NudHIpDQo+IGRpc3BsYXkgaW4gcGVyZi4NCj4gDQo+IFRoZSBmaXJzdCBwYXRjaCBmaXhl
cyBhIG1pc3NpbmcgJysnIGluZGljYXRvciBpbiAncGVyZiBzY3JpcHQnDQo+IG91dHB1dC4NCj4g
VGhlICcrJyBzdWZmaXggaXMgdXNlZCB0byBzaWduYWwgdGhhdCBldmVudCBvY2N1cnJlbmNlcyBt
YXkgaGF2ZSBiZWVuDQo+IGxvc3QgZHVlIHRvIGJyYW5jaCBjb3VudGVyIG92ZXJmbG93Lg0KPiAN
Cj4gVGhlIHNlY29uZCBwYXRjaCBmaXhlcyBhIHJlZ3Jlc3Npb24gaW4gJ3BlcmYgYW5ub3RhdGUn
IFRVSSBtb2RlIHdoZXJlDQo+IHRoZSBCcmFuY2ggQ291bnQgY29sdW1uIHdhcyBuZXZlciBkaXNw
bGF5ZWQuIFRoZSBjaGVjayBmb3Igd2hldGhlciB0bw0KPiBlbmFibGUgYnJhbmNoIGNvdW50ZXIg
ZGlzcGxheSB3YXMgcGVyZm9ybWVkIGJlZm9yZSBldmVudHMgd2VyZQ0KPiBwcm9jZXNzZWQNCj4g
YW5kIHRoZSBjb3VudGVyIGRhdGEgd2FzIHBvcHVsYXRlZCwgc28gdGhlIGNvbmRpdGlvbiB3YXMg
bmV2ZXINCj4gc2F0aXNmaWVkLg0KPiBNb3ZpbmcgdGhlIGNoZWNrIHRvIGFmdGVyIGV2ZW50IHBy
b2Nlc3NpbmcgcmVzb2x2ZXMgdGhpcy4NCg0KUGluZy4NCg0KVGhhbmtzLA0KVG9tDQo+IA0KPiB2
MjogQWRkZWQgYSBjb3ZlciBsZXR0ZXIgYW5kIGV4cGFuZGVkIGNvbW1pdCBtZXNzYWdlIGZvciBw
YXRjaCAxLzIuDQo+IMKgwqDCoCBQYXRjaCAyLzIgd2FzIG1pc3Npbmcgc29tZSBjb25kaXRpb25h
bCBjaGVja3MgdG8gZW5hYmxlIGJyYW5jaA0KPiBjb3VudGVyDQo+IMKgwqDCoCBkaXNwbGF5LCB3
aGljaCBoYXZlIGJlZW4gYWRkZWQgYmFjay4NCj4gwqDCoMKgIA0KPiANCj4gRGFwZW5nIE1pICgx
KToNCj4gwqAgcGVyZiBzY3JpcHQ6IEZpeCBtaXNzaW5nICcrJyBpbmRpY2F0b3Igd2hlbiBicmFu
Y2ggY291bnRlciByZWFjaGVzDQo+IMKgwqDCoCB1cHBlciBsaW1pdA0KPiANCj4gVGhvbWFzIEZh
bGNvbiAoMSk6DQo+IMKgIHBlcmYgYW5ub3RhdGU6IEZpeCBtaXNzaW5nIGJyYW5jaCBjb3VudGVy
IGNvbHVtbiBpbiBUVUkgbW9kZQ0KPiANCj4gwqB0b29scy9wZXJmL2J1aWx0aW4tYW5ub3RhdGUu
YyB8IDkgKysrKystLS0tDQo+IMKgdG9vbHMvcGVyZi9idWlsdGluLXNjcmlwdC5jwqDCoCB8IDgg
KysrKysrLS0NCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDYgZGVsZXRp
b25zKC0pDQo+IA0KDQo=
