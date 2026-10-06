Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B113ED5D6;
	Tue,  6 Oct 2026 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791292637; cv=fail; b=WLhMgqs1LMGj5ZhWLjERdQb741dFYzhP22jb8IYRFdKVcJZcW8vUkDRQqKVkjmsFVSo9+6LhWifOvgI+eJR4dOd20EUi6+LWx9sjHXtt3+bl5TPwCpFzLfAJSRiD+tUx71CH2O4jK8yeJXn/AC68bt5NTv6FTMNcmLoXnWRvyiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791292637; c=relaxed/simple;
	bh=LDE5Rs7zNYTnSMyn0FPQ95gFQFlFZmsIBCkkmUMQ4wU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tQKT13bYlZAFdVHdQGAIeWfj3l0o6l6tYXAPl/7HCzQ65zMr3VCfAaGHfINs7AEoGph1vwv5qD0Uk/C7iizLGcGu8/OCBDQM+4sJNzoHKJEnswKBqeuZC+HbbosjUtt1bWjJSftFf9yTrI3G/iS5hiOm9bHjrLYK9oeqyQFH3GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aDfvIB6g; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aDfvIB6g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791292635; x=1822828635;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LDE5Rs7zNYTnSMyn0FPQ95gFQFlFZmsIBCkkmUMQ4wU=;
  b=aDfvIB6gPWpCv6kDRN9SoFp997OWGj62SQWG/TJhRuwmzv3t1AWjfEga
   l9YcP2uDQ1jJlAth6+Xk2Ylj9xPK+S+3V4Gf9nn1cQzp1calmXITwkkr4
   iMLgSjdjqzaelRr6wNwRR7Gth7CcGL+GXlUl0/kaJFjxWvtV6BH7kOF/J
   7VSqRsfiCmsOBsK94ipJpvlidW0pFfmOiFTkMzWE8YETmWB0TZ9in34Vo
   kOOlOOxyzWrBgZcmuekUuVEEITE0AVl9Ng6B1wIYQwpuNpDQsILSAeS5G
   p00p2I9ODYKqZcON0fxIHsYYUvPZiAZhmBz2huApa1+3T6iQyXdXiHdUb
   g==;
X-CSE-ConnectionGUID: gKYJbGOkTa+0/+/KxJdWyQ==
X-CSE-MsgGUID: I14zJEfRRIqBUTZrkcx5jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="102651543"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="102651543"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 06:17:14 -0700
X-CSE-ConnectionGUID: 21EVpoXgQWOCMiDWN2x75A==
X-CSE-MsgGUID: onoZTT44QviSsyVnFvuHzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="285252430"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 06:17:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 06:17:13 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 06:17:13 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.9) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 06:17:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hE4+gRjBjHBUItjKHkjIHvbFrr8Ordl3Q/JgJXMTCXHaosQkTs4Cgca77DkUFv86ppggKW/vhI4OHl1exjqNL379iW8+m19ymNS3aU8f47XQkaL3WaKipswWQayYZqaQxH9XulM1v0YmoGl60ext0Zg4ii3zqjsANHNtdmkdLyjOAL7CGKcQ7oj19tc016wwsbNMizZxoJb0KVLmDhdvmOp90AjDMH9zaj4216yPwIJG8cKcaDWS7Yx2t2+MgPwhJmjTp+16d86gTEG9x+VpPjFwzNdE4f++406r26CNaXKqYyUz58kDpX6zNUG8qRch8q4si2aPIyUNReFaHgFHXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVAYWNUWutWwmH5IQDloOCZsOnewrA5SLYuigOa6wZc=;
 b=o87QiyBnPdGBpcF6ve3+pylQ6ZjtPQmKyXQDFh+4r11E2kJr7gOVOt9UinAKs5MAZupaBkg8GWPLphvpGGN3eiU/TSOr7eQGJitKVzm1QIMV8W8HXRfnY4FxO1x5tjCJnx31T4mukmWRxM0j3uayjDHvGfrfzpxLtAKl9zHMKIYsyNBtp+900NRH6f0UaMF+hPpLd1JDxutH81H3IHVOzaaooI5uSqehkGcxOkfZu8EG/f7EQico82eFTetUgU0GX7o7sWPehv5fa35PZ5nTjhqKiwqr4KmUYSKr/CLO/TDfEWR0ILIgzOhLXQ+scZo1Z69DJ9w++jvHZCqh4gBEZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH8PR11MB6999.namprd11.prod.outlook.com (2603:10b6:510:221::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 13:17:00 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0472.015; Tue, 6 Oct 2026
 13:17:00 +0000
Message-ID: <66136aa8-adbe-4fdf-9b7c-d44ea0e5cf1e@intel.com>
Date: Tue, 6 Oct 2026 16:16:52 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] perf tsc: Declare TSC support from the build
 system
To: Chen Pei <cp0613@linux.alibaba.com>, <acme@kernel.org>,
	<peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <james.clark@linaro.org>,
	<leo.yan@linux.dev>, <john.g.garry@oracle.com>, <will@kernel.org>,
	<mike.leach@arm.com>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<guoren@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20260929034133.2153-1-cp0613@linux.alibaba.com>
 <20260929034133.2153-3-cp0613@linux.alibaba.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260929034133.2153-3-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P190CA0018.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::21) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH8PR11MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d7ac612-55d2-4498-e22c-08df23ac1abb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: rSZboxfH1fnLgynfbZZk/lWbGKUhWfY6Y1NrAaS2LisW0QsZvuv2elumPA83z0xF7rqAh4YFI/Vb4+Zsfys9KaOXZHpKxwPXIPIT6jV8K1dBku+KIGp8T2vSuEEZbyjyrH/fxG3TkPVKPAdeZgUhQ8uRwhu0zBa0PQlCBqUvd09dntmpfvC7j0WC1GBGCmN/VGZjzoDlFRrp+O0Q1+ehJCm0TAThuhv3JicDP5y67HAEZJQk3nir3EJmJ4JKPF6qlZ64f/i80MHXG6A42xdUqxTYo16Da7V93jpTEwre6i5BX3PIrTr6Ff6l7GU5aE3wxbE5Hgc5TyGn4KT4vx5jW3RZziWRMs8JoJQ9r/CbtMQq8R3TzqtVyjlzVCHW5YA2+bIt7pNGr0itYF7L4wkMqQgAO6L9i5endR+hxbYms682pIVaiwV0mIscqNIX4x6cC6nVsY7ofmOTF3RxZlEP+s3NCjm+14QGbpRxY0OTFxe4+v6okV97muXrdh5uvQJmpMSgYx7ViYKQo4lZGLEL6s8dCDPbjbuqEWYyGBL4etUmYjVHM/WyaS/a9u4JrWZcVwTf3WEV/SYEHyfq4XsZ16J7NZ3Ih7eMz8bu32T2DpNlU+s3RRt9WjkTO0E1T08s2O6FuBbIHbXahABa8CRavMRRvEkQDekcfEoQfKVPnS0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1REcWpHVkdBUzQrNWpZMmhGdXZFRWRpOEcxZlNZVElHajVzQzBqdy9PakVH?=
 =?utf-8?B?RThNREJzdUJTWkJxaFQ2RnBFWWRhZmdEOUpnVXlIV3paYTVhLytrRXRzN3Ja?=
 =?utf-8?B?MzlkVWgvQ2lvU05ETXl5NEpuUHRjQjF2Qm13ZkdQRERueWJkbC9aVzNlemU2?=
 =?utf-8?B?VGIyZEwvQzFnS0hrczlURDNzWWg4SERYRTFaNmdlMUY3ZnRoY2NUZ0NGeVV4?=
 =?utf-8?B?UnBLRUh4SDBaTzkwcGdpbmJYVGcwRi80ZzNSVVlGS0xQWWlhU2VLZVEvVVRw?=
 =?utf-8?B?QlIyZE1sS1lqQnZWbGVnM3NvMHdKY25mRWx4T0FqN3dHTzczbG9Kd3I4dTVh?=
 =?utf-8?B?Znd1bmpaNzEvci9NMHlXWlZpMEY0cmxvTlFFbktseU1GWDc4citvckVMRTdY?=
 =?utf-8?B?WTg1ekNpNjlkUW53VUo1ZUVjVXFlUDdiQXBLNzRLaUJ4UnBPQ0p6a1BzTDVO?=
 =?utf-8?B?Yyt5eUZiWjhuaUJTdkxPR3RoRGp3aVVkTHA3SXpsa3R3R09SS2ZIaXp5SStP?=
 =?utf-8?B?VHgrSnNjNTVKVmJKd2xXUWF6UHF1OUkxQU9TclFDemZ2RXluRFRNaWozWmpU?=
 =?utf-8?B?VHpqR2tCZWFhcmM4RTBTdWpmTFZMRW1zUVNyUmdMWFBuWHpCOVUvMktHOTVK?=
 =?utf-8?B?RUNPNGtxOHFZYjlQU3dNc2tKVy96cm4zb3BsM2pwbXFkb0JuYVRpaEUxRi9y?=
 =?utf-8?B?cUxNbFJsK0xRN0lkWmpyNTZrSXBvRVJRakM3Yk93enBUanptOVRwVEpacXZX?=
 =?utf-8?B?eWNQZ2loOWNjWStKcVM5L0srRnpBWHVnbGJBZnlYbTVzZk1ENzMxcXQrK1V0?=
 =?utf-8?B?UmtSVTVYWVk5R2xsYkxLb3RqNkxxN1kzQVN5L2Mwb25LellnejR6U21oWm1D?=
 =?utf-8?B?Z1REREc5VUorWTBuVmF1c0lpZGJpYWljNnVzUUdnUE4zZDlsVnplbGx4K0p1?=
 =?utf-8?B?Um5oN2s2MTZESTR5b2I2cUFHZHh6MHRYVmtXNy9VaTNmWGQ0OFVsWVpyU1Ux?=
 =?utf-8?B?M0hQRHJpSEJVWUZ0bGRpbTAybmlzREZmem9tUmNLK2ZLUU4xaEZhWXJvaXg3?=
 =?utf-8?B?Q3hGM2tXTERkbzROVTBpYnFZWVl2MzlzQUVKRUVXc3A2V1RJbVlhUC8xREpm?=
 =?utf-8?B?YmkyeDRXbSs2ZStVKyt2MUdrdk9UQ3hJREtUYzZBazhwYkg3V0Y3b3ZvQmZa?=
 =?utf-8?B?enZLRTlFeFZrc2dLckVOcmJFR0ZnR0pEN2tLcklNUG9Rd2l4UXZEcFM3Sml3?=
 =?utf-8?B?em56NDBNV1Z6aUI0UVVVb0JQV1k1SGw0V0lOSEJhMGNLK1N6eHJVRE44N0FM?=
 =?utf-8?B?N0FXbml3L1MxUFlUSGZJaXpjR0Y2WVN0NW9DMG9xOFk1UnBvc3RHbHhTcm1Y?=
 =?utf-8?B?L29iK1BNN2kxdndtOWkxcmU2aHNkdE1lekpEL1BySFhNWGoxNWVEUUFxelBU?=
 =?utf-8?B?Vkpxa0RxK21lVHU0bmU4K1kxTDl0d2VwVE04Ti9YRnVPY3FOenJKUXQxbFEy?=
 =?utf-8?B?dG1McDQrUG1XN1Z5dXBnZmc1THZhMmNzQkd5UGpWWFRJOEI0M0V5KzJUUVd4?=
 =?utf-8?B?Y1hlTE9VdW9OdXZSVEdUeENXS2poRkdiVFRua2lIRmY2SUNRUEFySWVOczZX?=
 =?utf-8?B?VmtDbTVDYjFkdUpHbjVXSHUzUzNNcHFSTnJlMnJGN2poNjUwelFvaXJZMGh1?=
 =?utf-8?B?NEVrZDBwMDFmSlV6YVY4VjFNcXN2dnQxWEtrSUVDOXZ5ektIYWhpWisrNHN1?=
 =?utf-8?B?ZzZ2ekNlNUlzbzBwalZ3dlQxSUoyL0pDZng2eXd5WnVrRWZTeUtHaEF0T3FS?=
 =?utf-8?B?VzBIOC94M1BuN3oyT1BDeVdnUWFJeDU4S2VQRTlDNEJ4N1ZnejN5K1EzaUlr?=
 =?utf-8?B?UEl1QW9qckRtRnBEUlhGODdvMjRqTjZEbHZtSjgvZ0FDNTI4K2hFeFluQ0R2?=
 =?utf-8?B?SG9KaTZSckFyMUxSZWJiWHo1MitJRDlQc3M5Nlc0UHJPTEJXMHphc2l0Mmt2?=
 =?utf-8?B?OFA3RE8wdFJzeTRXUTk5RWlZMmZCMHlxNzJjRmJDVjFNazRRakhGWEI5TlF1?=
 =?utf-8?B?bVQ2bnJRVWdLZW1MaHFheEtSTllZcmFwN0hhQWllbzhXOTFkc1FSQ0ZVOXpN?=
 =?utf-8?B?VXYvUG5Ocm5XVEs0TythUk9KMGdNdHEzNzVUY3U1VVAvNDVZRWNkTlpnUzF3?=
 =?utf-8?B?RkNiNnVGVzdXdWxyaU11UURPSHdHWis3a2srQmNNZGV1d1JFZ1cwR2tUcVlP?=
 =?utf-8?B?M0V6ZUNrRk0rdllvOFJXR2JrS0E3RU5XVGRIb2lnMlAxTXdpV0RNTHpML2Q1?=
 =?utf-8?B?VThOenVucDlUWkJBMmdhdmp4VGZDVlZnbE5YSTdMdlQvOHVtUlFCYWtteEVj?=
 =?utf-8?Q?LHgCKpLypiXmSVwA=3D?=
X-Exchange-RoutingPolicyChecked: kMvvGKHRJLlcJaSQ256mW+/z7mkQHIJ51TOtOKIRlsUQZGjBZDemTE6TmTktIIGjdH1xeWISUN+/jsa0vI8D+u3KMmXQV5Gze7L5GToK1Wnqs7rNbWGspuca96K0eIRIqvCSkgVnt4CneQk+82YgxwMRm5AHA8V25iXcU5etlap/GjLuX7Iyrv14sNUvfy1MEJ1JjYUBHHETcD9dyDnS5mxMhsy9WncsUUu+Xj4WgvZ9AQugLwpjl2vj3CyvKl7hi3PfyYemONoNXlRVPHZsF321he4w5VlRpHS1jLGsKfpb2MnmLrD1wGMQS4MQqnuaauo7lVtfnrYObz7YVuHl+w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7ac612-55d2-4498-e22c-08df23ac1abb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 13:17:00.2304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/W2ivshkBI2k1sfV6vbUikDLbbLwVNICgWriy2FzjbfLRnbysDhvZ7giCfTpDoMOH7oYXheOHT6Eu0VNQ2vLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6999
X-OriginatorOrg: intel.com

On 29/09/2026 06:41, Chen Pei wrote:
> The "TSC support" subtest of the "Convert perf time to TSC" test decides
> whether the architecture is covered by matching compiler macros for
> x86_64, i386 and arm64.  That list has to be edited for every new
> architecture and can drift apart from the set of architectures that really
> provide a counter.
> 
> Declare the capability where the implementation is, following the
> PERF_HAVE_JITDUMP pattern: an architecture with a usable counter sets
> PERF_HAVE_RDTSC in its arch Makefile, Makefile.config turns it into
> -DHAVE_RDTSC, and the test keys off that.
> 
> x86 and arm64 keep the same behaviour, riscv starts running the subtest
> where the previous patch defines rdtsc().
> 
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

One minor style comment below.  In any case:

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changes in v2:
> - Declare the capability through the build system instead of a weak
>   arch__rdtsc_supported() hook.
> 
>  tools/perf/Makefile.config          |  4 ++++
>  tools/perf/arch/arm64/Makefile      |  1 +
>  tools/perf/arch/riscv/Makefile      |  1 +
>  tools/perf/arch/x86/Makefile        |  1 +
>  tools/perf/tests/perf-time-to-tsc.c | 19 ++++---------------
>  5 files changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 4d5993da9f94..f1b3bf208231 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -618,6 +618,10 @@ ifdef PERF_HAVE_JITDUMP
>    endif
>  endif
>  
> +ifeq ($(PERF_HAVE_RDTSC),1)
> +  CFLAGS += -DHAVE_RDTSC
> +endif
> +
>  ifeq ($(SRCARCH),powerpc)
>    ifndef NO_LIBDW
>      CFLAGS += -DHAVE_SKIP_CALLCHAIN_IDX
> diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
> index 44cc3f023318..b9cd559065d6 100644
> --- a/tools/perf/arch/arm64/Makefile
> +++ b/tools/perf/arch/arm64/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  PERF_HAVE_JITDUMP := 1
> +PERF_HAVE_RDTSC := 1
> diff --git a/tools/perf/arch/riscv/Makefile b/tools/perf/arch/riscv/Makefile
> index 44cc3f023318..8036bf55da8e 100644
> --- a/tools/perf/arch/riscv/Makefile
> +++ b/tools/perf/arch/riscv/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  PERF_HAVE_JITDUMP := 1
> +PERF_HAVE_RDTSC := $(IS_64_BIT)
> diff --git a/tools/perf/arch/x86/Makefile b/tools/perf/arch/x86/Makefile
> index 44cc3f023318..b9cd559065d6 100644
> --- a/tools/perf/arch/x86/Makefile
> +++ b/tools/perf/arch/x86/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  PERF_HAVE_JITDUMP := 1
> +PERF_HAVE_RDTSC := 1
> diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
> index f8f71fdd32b1..feb8063f8b59 100644
> --- a/tools/perf/tests/perf-time-to-tsc.c
> +++ b/tools/perf/tests/perf-time-to-tsc.c
> @@ -22,16 +22,6 @@
>  #include "tests.h"
>  #include "util/sample.h"
>  
> -/*
> - * Except x86_64/i386 and Arm64, other archs don't support TSC in perf.  Just
> - * enable the test for x86_64/i386 and Arm64 archs.
> - */
> -#if defined(__x86_64__) || defined(__i386__) || defined(__aarch64__)
> -#define TSC_IS_SUPPORTED 1
> -#else
> -#define TSC_IS_SUPPORTED 0
> -#endif
> -
>  #define CHECK__(x) {				\
>  	while ((x) < 0) {			\
>  		pr_debug(#x " failed!\n");	\
> @@ -49,11 +39,10 @@
>  static int test__tsc_is_supported(struct test_suite *test __maybe_unused,
>  				  int subtest __maybe_unused)
>  {
> -	if (!TSC_IS_SUPPORTED) {
> -		pr_debug("Test not supported on this architecture\n");
> -		return TEST_SKIP;
> -	}
> -
> +#ifndef HAVE_RDTSC
> +	pr_debug("Test not supported on this architecture\n");
> +	return TEST_SKIP;
> +#endif

Perhaps with #include <tools/config.h> the following is tidier:

	if (!IS_BUILTIN(HAVE_RDTSC)) {
		pr_debug("Test not supported on this architecture\n");
		return TEST_SKIP;
	}

>  	return TEST_OK;
>  }
>  

