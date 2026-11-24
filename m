Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795552903;
	b=oU6Djdd7NkCqIrBCp243syAYDPBLm5hH4ezCqHkejBxsxE9KkI2PQuvVPGosBPhOs8z1
	 gQ2iYHotrnvYqMXDr+vFMQjF0x62oZDPETI1DSQUft8UZ4Y+faMi7K0kHcFGDxpZzLUIL
	 XHuaBPtedgYlOsdIUs2Rr/y7pqeqYBbeQtxwuYLDl/Vfv2090dfEn0/Nn9XG156GBj8eB
	 7ft5wzU2GVkUqAGdL3TJSHTmEZd7QjtM8G2aZWYCEWuLE+b4jrZc1JL9/8o+DTuy0XkV7
	 oiai31UJ/EIQYpfzOd9z4+f35WBgTNx7m49mByHGw/vZkW93PLDkR2ljRK/EUhX5Mhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795552903;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:CC:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=t7wyka/3inOZU2Fw0JZmBheOw/zSYciofq+6eSPImyY=;
	b=VNrxC0+TKWo2AhGb0EaCFEUy2y2sI0tehvdt4rH2Lamjav/849kNDb9UW9vT9yUq9Vg4
	 +nTlKX9kV8Q23ZPZbgZg6wPz2zvG0wIfLkg3cfWE8GmPlpNA+W9JViOWOqQDtU+HcGlms
	 GQXUIReo05kiB2hS8efuBkcLQyA9aEmPPebBoTDHcNzMWIDC7MVGmxTt2WhdOvGXOs/pQ
	 qzg4oXTwb6Vca6nyvwCSIHux3OkUOVye5WeBUd70frsa7yNbDWCwyjnNRn57++ge0a059
	 syQ3+NlkPczAPQwwgeP8XZPsGSJ497n1cbFCtinhkrCfCzujpVsqmsV/ce3xzvg71GA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NeFZSKgb;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=j4lIONUW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EFE606A683;
	Tue, 24 Nov 2026 20:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70EFE606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NeFZSKgb;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=j4lIONUW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795552903; x=1827088903;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+a/sip9UrdjoflT+074bBJlkokvsOk1xXcAyfiJ8n0M=;
  b=NeFZSKgbakP66jiuac0YYFv2Sp0Fir80DHh0rTpPVf/1wpfN94VSIY3r
   heklrJrU0+8Iy6P5qZ/Be5AxeIN9Yv/ZxqXDqeaY8OZqKHN/zdOjdim5F
   CxYVTMVu+jDA8Kz5KUrS/f687zG6mhdbxlgHcXQMGu4RFGKtcLdb8vDs6
   ZIhBUzazGlLC5GxPxFMJUucX9ICSffadpPE07HcgHcCKwaB9LUuOpYU+n
   DJdJXYZBHpGuuoNjumJo3UKaYgEj3NJnK9SQQJWwcWh+xX2K2/D/dvtdU
   aqRR5EV23+8Ww54EC6lwA0kw1qY3f4mohNz93K/vOJNDtNRUsLXhpJJ1g
   Q==;
X-CSE-ConnectionGUID: hdYAReOSSW6sragR+rm9gQ==
X-CSE-MsgGUID: qafOvv6zQHa/gl3Lxn3YJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4313039"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4313039"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 12:41:42 -0800
X-CSE-ConnectionGUID: xO3hKs69SAWgDnZYjQlOQg==
X-CSE-MsgGUID: ybluegtcR6+kaQX2YosPdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="11679693"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 12:41:39 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:41:38 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 12:41:38 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.2) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:41:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HCfYyCxYhPVmNeRvgmfJRLKuMFoxL6GFoLHMDoxOvQWq1LkUzb3C6zmN1sBUfgNkKlPovnmDoFVi7+xHG6OysRBv31iewwz9fNWiPEQGGwC7VEUE6WsZ0BbErD5mWWOS8waicE/NyX1KrYQdKZCqZqlSqhVmExi3E5rfSwIox/Xq6ddavoS8mSyBOB9vja/TnphPEahIqYgubz3Jmx24sD3hcsDMcFr+06etPfQaIiVpHg8SbxpUnqZVKEGFHEdSdmtQ2BSw00ULjy3k5UKpwXcHx7lkgcgTR1E1gIl9TqAKPEa8OmPn7cyg3usfsj6OUbK40H+bC5EtMXY8lk/TGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7wyka/3inOZU2Fw0JZmBheOw/zSYciofq+6eSPImyY=;
 b=Vf2GnkbpAzshk7vdQmvvy9VANGXXT22RtrNEpOMhlO6DKPB/2ya2uZPo/8F/aTTu8UVjmddGzpFNzq1ZNskIAwA/SrgBzftv0/U75ipy08rmLxqrzcWizNXrl5T3fM0UFbBdYho3EQoBIzikEY/lps11VICvF7YHIG3z9MTUDgmxkcs5L83Se70zYWg1CyrwE3IdsHUw2TMCL8nsD7sYEwqSVR7HhEAOm0/EU5jjcI5HNWYCp2yeAbVpcyFVt9EKhq3d9L0G2BUw5xZH7ZMRseMa9Xw4+X4SkFeYt+I2g6fRUevNcbXhzvF152oRRlYeJ1mof5B9z9CZl2DyQRflhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7wyka/3inOZU2Fw0JZmBheOw/zSYciofq+6eSPImyY=;
 b=j4lIONUWc7HBnEHVpqhgmOAgZe3b+pWxclc221z62KX0dxCcvJY1IiGtVGHgsWBl8/+Dfh2f5frz8l1X3wS4Fmldj3BNeF+Kq/r20OutO/oZQG0Mf6HlGUGaWy8zjVANkzBouBaDZpVWcGGK95soOwnof15KOnhwpGDMYMYJqqA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH0PR11MB4888.namprd11.prod.outlook.com (2603:10b6:510:32::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 20:41:34 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 20:41:34 +0000
Message-ID: <8b37f5ea-9427-43f6-8abf-07a36a9bbb72@intel.com>
Date: Tue, 24 Nov 2026 22:41:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/19] perf auxtrace: cs-etm: Capture wrapped snapshots
To: James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@linux.dev>
CC: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
	<mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, Will Deacon
	<will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Suyash Mahar <smahar@meta.com>, Amir Ayupov
	<aaupov@fb.com>, <linux-arm-kernel@lists.infradead.org>,
	<coresight@lists.linaro.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>,
	<linux-doc@vger.kernel.org>, John Garry <john.garry@linux.dev>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
 <20261105-james-cs-unformatted-per-thread-fix-v4-15-7759e0ce2449@linaro.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606-4,
 Domiciled in Helsinki
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-15-7759e0ce2449@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0324.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::29) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH0PR11MB4888:EE_
X-MS-Office365-Filtering-Correlation-Id: 09f4891a-3b29-4d66-aa88-08df4a6b53a2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|18002099003|22082099003|56012099006|11063799006|4143699003|261028144727099003|261009223027099003|261022105027099003|261022075727099003|261026140227099003|261021135927099003|10067099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: vWKUdZAengKsJ98cdrOlC9wn1YZhsU6phrB9pbn6RX7qqJOEQUwJPXDkCEwqnzpLAP6bpd76JdoQOOha3Rn5n2tdjhh/gA1nhn8xQEgXvuOBfv1njspIbVzd1duooAYUOuqygRVjfQ0LSylqSzadsyIEZuue4bFgQkbwE30xE5ECvW9snjjkvJioZ+nBOVfwUiTJg/R3IN24bk8LEfbWkEyc8JyH9Tqb5sH8YhTGUDRbMHT/BPX1IUifmZNDVpRK7biyI95Q7484Sf6TlZRk9XW4TfWW7c6Tk7wzI+3baW4DqG+7JNfD7rNJQcQyWv9wsOM2oSING9X/0bnCufAXJly5Jr1HShpZ1wWOLXr++y7Vn8k14pynB9fcvlvskLlOgHGjQIBRvGtowopD6XDFLkl5Cq45A2CPDftNcQOFWA5X7U4NSePtbafncit1O4KNI+NMqVaiJi6dG2q8AvTKNvxMUtorjGJtjYdEYjPD1rSdXdOkjYVLZPN+9gMtSnvUVHvzqjY+jSbs2zj/2VgTLchsVWZsGvtdtC0WO2lIqFTjZJpMquk50OS78ekzLZgrjfYkwCcZH2aC3LGnlID10x0kJOpHoG4S60yFX0YfEQWYZ4uhMFeVxKl6oghllEkVbaPIS4OnJ26F5Rif/QGgGivTplZxXF8m5RVGxcLyfuk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(261028144727099003)(261009223027099003)(261022105027099003)(261022075727099003)(261026140227099003)(261021135927099003)(10067099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWRVMDZlYTcxazNnTnY1eHVWRkFZd0xvbVU5ZkdrbzV4amxpOGRCbDE4ZE1r?=
 =?utf-8?B?SXBNZTBxczZuR0FoSXdhcjFJRURPc1FEZ0lENzc0SUhQd1NralZZZFlCRUVT?=
 =?utf-8?B?MTNoKy9UZSticEtwR0YxRWY2b2JISC9BbjhNZHRySGJNaXBQeTdlK2xqMzlY?=
 =?utf-8?B?b21sVWFkcjdlVTBId1UxWGdMUWMvN2NieHQxT21vcWx4bEZKT2tyOVRzTW5a?=
 =?utf-8?B?bUEwMExmMVpueXJQS1JHbm9wZXd3UEtrY21OYkl6ZTdiVkJPZ0VJZ21zTnBO?=
 =?utf-8?B?eEoxSnFKaGkwN0FzN3hXd20zbjg5UFAvczVJV1REOHhrUlNPbnp6V0srNGNZ?=
 =?utf-8?B?emkwVFNxUXEwT0RRbWpKWXV5bGorZDJxRWh4WkhJb05kUUg1R1RFNm91bzZj?=
 =?utf-8?B?MzBUVHpSY2hqa1pJNGp4UlFqYkJJMDkyK0V1ejZhckJiV0NlQzhoNmJTMFVD?=
 =?utf-8?B?NWc0NU96ZUZxM2Ixc0g4a2J2Z0ZkTGNVQVdSN2JhYlVyTDVWSXNHZnFrSjBp?=
 =?utf-8?B?bU1Nb09xNTFMb0pKK2RZTjg3YkxzR0ZGRTlTMHhoeHp3bXp5RGlkeXJPelUz?=
 =?utf-8?B?NitYYlEvRVJOU1EwQUY5ZW9uTVpzS3ZQN2QzT3JtNk5zYW13LzBBbjlMSXU2?=
 =?utf-8?B?eEJrSjhWbm5BTnV4cGY0TG9Zcm1uWS9ZRXZCZy9oQXJjK1JwZkNVQk56TzVO?=
 =?utf-8?B?LzQzb2RtbHRBSHZoZmsyeGkxaERmbkYyQ2VsYndDRzQ5NlpGNzg5Z0ozMmJY?=
 =?utf-8?B?dk0yWG9EaWlvYzA3YXkvbW9qemtFcDZLZldjWEV2aG1KWWxXM24vRlBXQUtp?=
 =?utf-8?B?YnoxSDNzNm9qUWdzM0svcFRpcmEvckRjRERFU25LQmxUL2JqU2lpV2ZydCti?=
 =?utf-8?B?ay9PTjl6dnFTWDJDNWJGb2l0UmdmRU1aend6S2t0UElob3ErbFZia2ZDRUZO?=
 =?utf-8?B?Ri9mdWI0cnBQaksxeHdiMHhjay8zY280Q3FmYkFoTzQ3WXhLZWswMWpIb1FW?=
 =?utf-8?B?cTdScHVSdEVwaGxHV25jOGJ6NHJJTkxhWTQrTzF3cFc4a0Q5d0NISHRNdFFY?=
 =?utf-8?B?eDFSUm9Hd0Y4d1pla0tKUjhvQTcyZmlPZ2hERmoweDk0WUx0WHA4dXBFSkFT?=
 =?utf-8?B?cjgwUVhnclJjenU3ZFZYeUoyZ2pMY3BvM3pTNy8zMHVKOGtoOHZmZWtoRzNs?=
 =?utf-8?B?RkhBS2FmdURtZUpIWWNuMTh4dGdNNGQwRnJRR2J1SWZ6RGgxeHBzOU9neTMw?=
 =?utf-8?B?dmV5SXhPVjhoTDBYVGlCb0E5UlowbXJkOEJrYkgxZGozeC91RXB4Yk9NVjhY?=
 =?utf-8?B?dkJvZEoyV1M5TFMxd1hrWElkbUx2WVNaWlY4UEFrOTV2b21IUTBuVGl6cU5U?=
 =?utf-8?B?MTNPbTdSOFQzVGFFelh4d1IvODRYdzNtRlVEZUZSOU9QajJEd0d1WmdkS2JR?=
 =?utf-8?B?S0hMYzJLZnBOU2RCSlczWVJCUUJ1ZDVDcStRdGNsMGlFTS9qNTV2YWZWdDRC?=
 =?utf-8?B?Yzczdi84dW5KNE92Q2FJVi96L1NjY3pWZkZtUEd6SGFCeXZuVkJ6ZmRmMVFk?=
 =?utf-8?B?L3A3ZWdKSmtZRjFETGEwR0Y0QSs2dW5xQ0QxOVdwR1NTakFDdUk0MmtmR0Rt?=
 =?utf-8?B?bnZYRUU4bkQyRFBvd1gyU05vZkJtbVZJVSs1b1ROQnNiSkxJN3Jkd2JkVEND?=
 =?utf-8?B?MFhKOEJqWGtDVlBXdjVmUHNEU2NQQ2dvbXRKS0w5QVVlc081OS83UTY0aklE?=
 =?utf-8?B?WHdDYU1kcDJxb3RzSlRIYVNNVlBqRmc3eDFveDZkM2JXU3Z0NE5WaXoxakxk?=
 =?utf-8?B?L3AzYSs2TURJT1lPR21LOW9BYXdzWHJ1Rlc3MUZOeDUyNURUWldGTCttNXFu?=
 =?utf-8?B?dmtWbEdIbVB6aUFwYk5PQ2E3MU00YUxEQTV2WlNCUGtlNFpRNWh4YjI0ekJL?=
 =?utf-8?B?d1VtOHorNVh3Vm13VjN3enNTbXZhbkRqZnR2QU5hSnZCcmV1UitjazdzWkor?=
 =?utf-8?B?UWxVRTltYWRWMytLSmcwZnpROU9HWDRHdEsrbjhRTjk0c2JOZWVNOTlkV0ZF?=
 =?utf-8?B?VkMrSVluc3dob1dCUnVGTm1DNnNaRGNsdHdYRWJQeVFLR0dNR2prMnJ4dHdo?=
 =?utf-8?B?UHAwZ1JrbGtnWEJ2Ym5IVEkxUnlIMWRQNlNGNC9xMXo1a3MvNys3U0lHUUow?=
 =?utf-8?B?bGhtem80ekduWmp0dnZKbEE4YUpnRFB5cGdwZVpCS1pHR0Nrc29yQlYzV084?=
 =?utf-8?B?Q3ZnVHh2OTJicnMvL3l0ZlhVK1pRbFdlL21qekRBcE16K1VXU29zWDg2andO?=
 =?utf-8?B?Q1Jzek9DYjB4dllqWDlDOUdTR2cvK0pRQ2h6WDFLVmVIYXovL2R4WTdGd2xN?=
 =?utf-8?Q?tC4UnXBGqlCy+0aM=3D?=
X-Exchange-RoutingPolicyChecked: Ml+AicHnIIMkcpxJarqkl6i+adt9ejCcPeASI12lz3C0E2ZoOHNJq4MT/ZfWex/vQuIP289kgJ3FMxZ6pJcCRDfrA8kngqD5njJnu3p7J87ElU5oDjzmhFUoF5Q/OVLJr4pDuLgC4Nlj+Bq4xN5CdDt8VdzPZTaU/km86/y6sjPSVUAq48zwsw0Y1RZmIjF9qOIV36NftCLHOjQtsF+lJaC9SAAITWJgvEtB1xgnlxrsLbCFYGofMVLoEP1k8I6SQu+76Cd3CKDxXmSF1pfYjX4VyVgUDYskOEWFT/xBPhlG/iSzz28K2CccUNTH+rPOKOgBW/8nb533eymCc1lJrw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f4891a-3b29-4d66-aa88-08df4a6b53a2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 20:41:33.9786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUuDC0k9vXKKEUJjB0WFMlB3++oWAjBIXSr1dbFagYnwlCGrgO5D3hpd3TcQnPxhgd06yZJ3a0WdT7W7XiKRcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4888
X-OriginatorOrg: intel.com

On 05/11/2026 13:45, James Clark wrote:
> find_snapshot() isn't implemented for Coresight, so when a wrap occurs
> we only save from offset 0 to current head, modulo buffer size, rather
> than capturing the whole buffer. Coresight drivers currently use a
> monotonic head pointer even in snapshot mode, which gives a lot more
> information for taking snapshots than a wrapped pointer. It means we
> don't need to search for data at the end of the buffer to guess if a
> wrap has occurred, and we can go back to saving partial buffers after a
> wrap by checking if the next size to take is less than the buffer
> size.
> 
> The drivers will always be able to generate a monotonic head because
> TRBE has a bytes written counter, so even if we stop generating an AUX
> record on every overflow, we can check if the counter indicated an
> overwrite and offset head by a whole buffer size if it wrapped. This
> forces userspace to read the whole buffer rather than between last and
> current head. ETR and other sinks use software double buffering, so can
> continue as they are.
> 
> Add auxtrace_record__monotonic_find_snapshot() and use it for Coresight.
> A monotonic head can't be auto-detected in the default find_snapshot()
> by checking if head > buffer size, because before the first wrap a
> monotonic head looks the same as a wrapped one. The search would then
> falsely detect a wrap when head is near the end of the buffer, and the
> wrapped pointer fixup moves 'old' and 'head' a whole buffer ahead of the
> driver's head. With a wrapped head that doesn't matter because only the
> offset within the buffer is used, but with a monotonic head the next
> snapshot would either save already saved data again or drop up to a
> buffer's worth of new data.
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

