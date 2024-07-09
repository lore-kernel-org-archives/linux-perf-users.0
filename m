Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EEB29CEA;
	Tue,  9 Jul 2024 04:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720501128; cv=fail; b=dTjGnTK1SlP23XUCEHy5Nj8q+kRt/CMjXfP8m265eUuPLu4cxvYVIwFLWkA5nJfHoQ0c9PTlhJeUOkPRqi+SKS+faWl1hSqNtcm00hKIWCz7+S38EyQe9d6lzU3nmfWMxwGVgiw7PR5PLv/YkZFJtIALPYGF16DIp91jCPZNe6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720501128; c=relaxed/simple;
	bh=cQHSFTo9QOZPPJW1ldNGE+q5TIuomLhnQFvfk3DUOtY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V6/fIuEteJUc9gylQZQGKJP2ljLmwn5tfV14dKUoY2gW4xg4PXirzwt759Rvl3QSisli+S8yT2noqQNxOfI6KpGqMCLeKM+sAT6NKgpWemC4Ne2msb60gA3+mg6xk0q8CvfqnFRbPPFlMi9H/HNvHJp2Krv2K6qH2/qJBxJvqIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HrV0DA6X; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HrV0DA6X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720501126; x=1752037126;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cQHSFTo9QOZPPJW1ldNGE+q5TIuomLhnQFvfk3DUOtY=;
  b=HrV0DA6X6J7pJFUNUeGTguKp0tsRB0zX5NMexkqxmIidRJioOQ9sDEH8
   6nAQcZWIOLEvLIOUWjotikYNCa8dsdTEesXmitRiCFUwlnpvVeRVXzosy
   hpgJ3zTgZBX1on+Rz6mwYef5amw4fWK0BRhucOxDO64cDDt54vipXspMQ
   IIZJdtXFZKZxL/mJJzXUD5XKjFrrmJtk0b2UdJ0WmNASR32dfu2IPdHOu
   /NbS+uxLjkKHhQ70y7o0z8jLjzRarGiLWkHmMpv1O+lm3aUjDfIx7SfvH
   w6mM6yj5pfij0CIShAyWEES+za34yh58HJPGIHiBEKXi+XcB51HCL6Izi
   A==;
X-CSE-ConnectionGUID: AftjNR/bTo24jL5o4tzYRQ==
X-CSE-MsgGUID: BdO6ucI5SVicbTLWqkvD8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="28892266"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="28892266"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 21:58:45 -0700
X-CSE-ConnectionGUID: nBr++/nuTFquw7gUdWmG6w==
X-CSE-MsgGUID: fs9TDuqvRaWdK5O9T5dSMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="47605070"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jul 2024 21:58:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 21:58:45 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 21:58:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 21:58:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 21:58:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcMhzcxrZYQIjhcDkeq2uM+DTBg+MdHiKQB0laMnPxN2ADy5mim0gH0aLIrbi5iM0svXvttDDsGNVcaPmnsc4nHHyKHeS+8b/rO/9PRjMq/oUCxJELqWdK/92UG8kF0xzPSgHsBkyrBkpUGj9RrzrlN83hWMiYT6LeCRMx23yQAJZPvMk4Rkr7IWD0BXzB+iyIvz9pLM+zXEGwFlvHvdvwZvrEdexFoQQcvU2ozd+dL+bp8SXf17rf+QgMa3UEWr8THPQC9V5+X52kSWX25dk9k1rC7iUvbFdZ3/Qiib4YJJWu9IUb7eUu2+1gymu+KwQmS/k3XynjNClGz/aCBYAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQHSFTo9QOZPPJW1ldNGE+q5TIuomLhnQFvfk3DUOtY=;
 b=fdjNONpssUBrUcjH+duqbeEPsFvgCNbGvcXn5gHi+qfFLEl7ofK/n0hPnrzFYPNKmOfAPc3KGC+Sn/0eJ24S+sQ1DhO3W/KBcyW1EvESiy1iGwwShIuH2TnI7uLt1El/VE82aIhv2N1QgsiHd4lMPvk/rmaYOeAjdtdZU+CptAoZQg+GlYvS/ulLDXoKQvekRal/bJZ6yEj7ePgyIZ8y18vnu4VRRNVRnBYlOT+3p7wcSVY+0iGZSNAWQpMk2bgQSCx5n5TocBfKlx8Gk0frEduP30zRFIaFrVWcjuWhE64lGwV4rc2Q/0hVF/zGDGzsm+Qm6DLDCqDPaJdqdr8HxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by MW3PR11MB4635.namprd11.prod.outlook.com (2603:10b6:303:2c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 04:58:43 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::8cfa:1a7f:d9ee:42cf%5]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 04:58:43 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"Kan Liang" <kan.liang@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb"
	<caleb.biggers@intel.com>
Subject: RE: [RFC PATCH v16 8/8] perf test: Add test for Intel TPEBS counting
 mode
Thread-Topic: [RFC PATCH v16 8/8] perf test: Add test for Intel TPEBS counting
 mode
Thread-Index: AQHaz/yE5K7EZmPt/k6tYcJFR9dutrHt1TgAgAADezA=
Date: Tue, 9 Jul 2024 04:58:42 +0000
Message-ID: <CO6PR11MB563567A7804F50AD5AA1F708EEDB2@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240706232956.304944-1-weilin.wang@intel.com>
 <20240706232956.304944-9-weilin.wang@intel.com>
 <CAM9d7chhVAG9wpWdQM4DRriM_kp9vjFj=_ak1+0qyO-sRdXs4w@mail.gmail.com>
In-Reply-To: <CAM9d7chhVAG9wpWdQM4DRriM_kp9vjFj=_ak1+0qyO-sRdXs4w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|MW3PR11MB4635:EE_
x-ms-office365-filtering-correlation-id: 84c13da8-ba1d-4995-e518-08dc9fd3ce6c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VThpdFdJdHFNU0Q2V2Q2TWhMR0IxM2sraElkUVYwS2Z1VHVHdExLVkd1eXd4?=
 =?utf-8?B?VEJ6dVNwWmdYazhRcjc2aDVxTzRJK05xNlB3QWlrWFNFSEhEY2RmNFM2WkxU?=
 =?utf-8?B?N3dXTzl2YzlPUk01OTlVblh4MkVPaXUwbW5reW5rdS9MRUthc3Rmb2RIUWg3?=
 =?utf-8?B?ZjRDTUk0dTBHOVNQc1Z6cXYxdG5oWXF4aDUxU096TVFZekcxRkNWTk5xeUYy?=
 =?utf-8?B?OWFPa3RrRU01NGZsUFo3WFlPeFdzNEhTMDQxdlgzMDA3dmxsL2tGNXpEbU9m?=
 =?utf-8?B?eWdYa3dMeWxsZzcvL3gwQTF1VzkreDNIdkEybVNseXBCRjJtWDdQQ25JeTQ4?=
 =?utf-8?B?WWN1OGJyZWFXeG5XazkyNXBIUnV4QkJOcHJaajRWa2k0ckNXZTNqcEh2bURN?=
 =?utf-8?B?U2NlYXZvNUU3YmdaQVoyRWxLNlBjaHppSDJyOFRVWnJkWjRPeTRkUnF1dmVl?=
 =?utf-8?B?L0dDQUxtK09aZHhNL2E0UXFnNUh1N0QxZEhvcmwrZjVxNUJzd2dzdmZqMTNj?=
 =?utf-8?B?Wm9pQUFleUxyWG1MaTEwY015RHdWRU9wK0dQdnRVVGY1S1BZYndBQTZVM05Z?=
 =?utf-8?B?WmVyUWNJSFlldlJueXpoMG8zMko4SDN2TWJYWlMxaUNRaWs5WTNNQVNHeHpt?=
 =?utf-8?B?OFNMMXdoSzJKUVBGY0ovcDBrSjVMWUZ0V1lnQ0RTcWQ2WUdpaXBNSXpoTUJF?=
 =?utf-8?B?U25YdDZRUThpemhDN1ZPNVBJUUl5NEpPWTFpZHA4ZmpmMWtaV0s4RVdEdUJk?=
 =?utf-8?B?ZThFSzIxNlRzOCtqdUMzblhwVXA2SEE3ajh5MEFIb203MzdxRUdHL1pzamF6?=
 =?utf-8?B?YjQ4dWlwWUd6Tk1XL0ZOT202RkdadEpnMWhFYVhDNm9pdWFDWFg5QzdjUjdE?=
 =?utf-8?B?YnhNdXNmVlBCdXNuWXVRMy8vWUYvVHZ2OWdUMUZqU1RUNkIyU253eFh6UzJU?=
 =?utf-8?B?OTZlUldteHJMK2RPZUR4TitrZXRwR25xYlFTU1FzM3BZSXRvV1RTdk5JVnpv?=
 =?utf-8?B?ak9ZRGI3ZVJEMkdkSjJ1RXZNK0xVRytUeWFhcll1T0lmdVVmWWJGQklqb3lC?=
 =?utf-8?B?M1ZXUllsUnNERVQ5YW1yZjVQOEhUWkxwZ2E0cFptMmZ5TlZPa3Z6alVGNHNC?=
 =?utf-8?B?blRiVmFkb1lRNHlQWHpPSFN2T3crN0VZVGZ2M0paUXh6K0FzbU9LQUJSR2pI?=
 =?utf-8?B?aDhXRlpDL3k0UlFVVjM0Nm5wb3hqVDlvcFBwUjh0U2FwZzA5TnRhR0xXRWNn?=
 =?utf-8?B?RjdsRHEvRUR4aWI1MUxzK1cxRVNrKzdFNFN6MGoxOEJ2YVRUeWk3VmpUbjht?=
 =?utf-8?B?aCsrdkQ3M2tGblB0WFBBZXpzZGl5K3BYSURYZFJBTHRrRXhURDNNejZMUTBl?=
 =?utf-8?B?dkhFWENqNUdiMHlibjFXeUhTQ2dYYmgzd0Z5ajhyTnM4cDhvZFJBbllpZVlQ?=
 =?utf-8?B?R2lrbk0rU3NiSlZ5c1duc0p2Z1lBWlUvTmN4dDE1dUNLbVBjMitCL3U5Nml2?=
 =?utf-8?B?VGlMQTBLUGFkUVppL002SmdkWXE2Z2Z3UkZQU20xWkUrTjhaVEFnbzhVYmpk?=
 =?utf-8?B?TWtrSlNQZUpVdS81V0s2VWkxTThJaHhGN0phZXdiWkRaVktMUGVEMExVcDNT?=
 =?utf-8?B?VjZLZDRGajF0Ym05MnZ1MkxhWHRmVHEraDZtRkpmaTlMOUd6TG54WUlDRG9M?=
 =?utf-8?B?TnQ5VlhRNTN4MXh6Nms2U2N2ZXBQUE5EbkhHTC9RSnJxTHlHOWM5d05CUmRh?=
 =?utf-8?B?cGlqLy9XN3J6dGpuR1JtREpYbjdPWmFRUVljaEw4cG9JbUxsak0yeU9aajNz?=
 =?utf-8?B?ekFCdlFOdXNLL2FZY21XbW9yd2lDQ0ZUUkVBdFh5TGcrS29PTGFOUnNVcFdh?=
 =?utf-8?B?RG1DNXBJRTJCcC9WeFc4bXk4YmpSMCsyM2R1Q3FJbzFLTFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NW5nRE54ODM5UkZsYVVBZEE2akVLUFc1clZEVFYzUDFyUzlxVzRZT0ZUUm5L?=
 =?utf-8?B?VVRaY2R3dFNvKzFkY3pNU0ZCY2cyOW9mNFZBS3FzTXBpSlNPZUtJUmlEL0o3?=
 =?utf-8?B?WDdYZVI4TmZiYXhjOU9OZmp0TkJ5bDIxdFBmbTdxVERLRVB1L2JmMk5hRDFV?=
 =?utf-8?B?RXRuVVZSZnY1cWxQMkE2UTVPYkM3ZzF6Qk5pUWd1a2RFU2FPeUozOEkvc2Ra?=
 =?utf-8?B?OStldmpTVGw1V2FSclZwcng4UEE1U25ULyt5T282ZWVXSDBNOEJQbU42OVhZ?=
 =?utf-8?B?S2dlV01sMndDWEV3Vjg1SUtOZUs5aGJJY3JTQW5peWpJcTFCT3JTZ0tkSTVK?=
 =?utf-8?B?cU5yRm53cmVTT0Q4OWxYRTJCcGVqYm1hNGVUTVBjd3RON1djcHU1em43S3d4?=
 =?utf-8?B?b0ppSTNMZ2RPek5aNmN3L3NlbnBjQnBJTmFVZlVocWZlZVVnT2lWRThhbHhl?=
 =?utf-8?B?ZEpZS0U0dnF1amRMTTdHL3NQUXJmMzEyanhIK2V1TzR6OEtOcVhsZjBsWkNM?=
 =?utf-8?B?ZlBIT3V2VUVtNkZnVTQ3Um1EeWJ2TXpRcE1ibGhyaGNtN0N4VjdCejFKdkl1?=
 =?utf-8?B?S3dLNUJ6dHFUU0ZwNlhIeTdhWjRid2RNSzBmSnV2MkIzRkc3UCtNWXdtZ1Uy?=
 =?utf-8?B?ZHdUWXJyYzYrMy9lNVhvelVabVl5U3l1NGtQM09SVTVnWGVPZnJpMFFWUmVa?=
 =?utf-8?B?NzNHVmhNSFBPVGc0aDhtRTB3YTM0K2loeGIyK2tkeXBORFplV3Z0MnBGckwz?=
 =?utf-8?B?SkJnQVRqVmpqQnNVQUtJTmJDOU1WM0NkQ3A1UkZocEsxM3hBRjM5YTJzOE5i?=
 =?utf-8?B?TEppOEx1ZFI1QW5oc2o1cGFvK2VxSkp3WDJxT3VmOEFQSE5EY2Jrem1icjZB?=
 =?utf-8?B?RXhvSHRvV0tjZ1NRY2JzSCtLZjNCWXk3c3k5TnZaamdrQytBbUtoV0x3QXhv?=
 =?utf-8?B?TFZUcGliQ21QY2hVWjFJUjBHSGRlZ1l0aDlRTFl5cU9PMFRiRXVXNlBZTzNx?=
 =?utf-8?B?Z2pQbiswTmJ3OFpQUWkwNERITExSS0tVZThvb01iRTVGOC9JckdIb2pDYWly?=
 =?utf-8?B?RTBlc0pFeG5JMkJaK0FNY0w0M2sycXROdGhBUjlka25xR3BNY1dTUEJENWtT?=
 =?utf-8?B?amJ1aVJSNmJZZ1liSmlDcDJobGY0REY5Um9yYTJjK3R2aXpZSWV2ZDhEWXVs?=
 =?utf-8?B?UVdZUXc5dU50bFZ2N1B0eXJRQlhmVE5ueFhnTk5OeG9GQ1pkMW40aUU3SFVo?=
 =?utf-8?B?UkljcmhKVWZHNVZQMExsRkRTOWx6Ui9UalZCVVEyMlEwTkpOTjVWelpTdUc2?=
 =?utf-8?B?UDY5ZHp6aUlxMGVST2FZWENzQ3RMVSs0V1k4STV5U3J1MGRxQVhOMElRcU1p?=
 =?utf-8?B?YlJNV29ocHFWTU53V2thbk1VNTFvcEZGL1haTXBsdTM4VW85VFRtdlQyVysv?=
 =?utf-8?B?d1llOFprcnBSVVNuMDFtS2Y1Z1JmSXhqcHRZV1BkTmJaTkxsTGY2RU1xTk9y?=
 =?utf-8?B?YjBNMUduWDMvM0ZQTHFZSHllaDR0ZHNFY1lVUXc1VUMvb1A5b2tXQ2dVamc1?=
 =?utf-8?B?QnB2dlAxQ3N4bFJmSlNUYnYyTDJvNFRWNlpwS3FEUHRPaU9UaUc1QzVZS0xi?=
 =?utf-8?B?aFRzSFNJek50TWJuWHhvT1hLbi9xSVUvOTdRcEtDbHYrM2c3R3JVREU0eGJw?=
 =?utf-8?B?aDJ0UzBOV3R3Qk53M3J5MWJBTFhwSWluTUhHWVFlQW1BamNPenlLbitmR3pk?=
 =?utf-8?B?blBvbng5TDkwRDlobThhd0FjYnNVSENUMFBSeDd5L1d1WFZoYzIvdTJNTEds?=
 =?utf-8?B?OGlkOFJiWU80NVM4WEVZcXlXd3ozSjBpTWNZa3d3Z3NQbzV2SnNCR2RaZkU4?=
 =?utf-8?B?ZVRnRWlPQ2VRa2s5c1U4cW91R2tWYWlHUFV3bk5qaUJrcXFmVHdnVFlMZEV3?=
 =?utf-8?B?engxeWdTbTd3M0txaE1DTk4vQmZWUlZLeWphWGk4dEpndXhyZHRqK1JpL1Va?=
 =?utf-8?B?MXpoNU8zMklUZ2lqM1pjZ2dzaUhZd0p1ajQ3dldMcit4MHFpWXlwTWUzZDJZ?=
 =?utf-8?B?V2JwamxUZmpuamJpU3RCTTg5cW53b2RRUXVhSnhRRmh4NG4wSlE1MkNqY1ov?=
 =?utf-8?Q?x8KPUJpNDgy/JpLYU5oHG7xkc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5635.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c13da8-ba1d-4995-e518-08dc9fd3ce6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 04:58:42.9500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7g1AVilp/k1WLlUhPCMfwabg9Xhn+BiX6W0V/OJ5/sbXQKtcPCsIBcopQm6nkyhNyClzOv6Xxf+WwZFA9IyOvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4635
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFtaHl1bmcgS2ltIDxu
YW1oeXVuZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIEp1bHkgOCwgMjAyNCA5OjQ0IFBN
DQo+IFRvOiBXYW5nLCBXZWlsaW4gPHdlaWxpbi53YW5nQGludGVsLmNvbT4NCj4gQ2M6IElhbiBS
b2dlcnMgPGlyb2dlcnNAZ29vZ2xlLmNvbT47IEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbw0KPiA8
YWNtZUBrZXJuZWwub3JnPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsg
SW5nbyBNb2xuYXINCj4gPG1pbmdvQHJlZGhhdC5jb20+OyBBbGV4YW5kZXIgU2hpc2hraW4NCj4g
PGFsZXhhbmRlci5zaGlzaGtpbkBsaW51eC5pbnRlbC5jb20+OyBKaXJpIE9sc2EgPGpvbHNhQGtl
cm5lbC5vcmc+OyBIdW50ZXIsDQo+IEFkcmlhbiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBL
YW4gTGlhbmcgPGthbi5saWFuZ0BsaW51eC5pbnRlbC5jb20+Ow0KPiBsaW51eC1wZXJmLXVzZXJz
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgVGF5bG9yLCBQ
ZXJyeQ0KPiA8cGVycnkudGF5bG9yQGludGVsLmNvbT47IEFsdCwgU2FtYW50aGEgPHNhbWFudGhh
LmFsdEBpbnRlbC5jb20+OyBCaWdnZXJzLA0KPiBDYWxlYiA8Y2FsZWIuYmlnZ2Vyc0BpbnRlbC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYxNiA4LzhdIHBlcmYgdGVzdDogQWRkIHRl
c3QgZm9yIEludGVsIFRQRUJTIGNvdW50aW5nDQo+IG1vZGUNCj4gDQo+IEhlbGxvIFdlaWxpbiwN
Cj4gDQo+IE9uIFNhdCwgSnVsIDYsIDIwMjQgYXQgNDozMOKAr1BNIDx3ZWlsaW4ud2FuZ0BpbnRl
bC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogV2VpbGluIFdhbmcgPHdlaWxpbi53YW5nQGlu
dGVsLmNvbT4NCj4gPg0KPiA+IEludGVsIFRQRUJTIHNhbXBsaW5nIG1vZGUgaXMgc3VwcG9ydGVk
IHRocm91Z2ggcGVyZiByZWNvcmQuIFRoZSBjb3VudGluZw0KPiBtb2RlDQo+ID4gY29kZSB1c2Vz
IHBlcmYgcmVjb3JkIHRvIGNhcHR1cmUgcmV0aXJlX2xhdGVuY3kgdmFsdWUgYW5kIHVzZSBpdCBp
biBtZXRyaWMNCj4gPiBjYWxjdWxhdGlvbi4gVGhpcyB0ZXN0IGNoZWNrcyB0aGUgY291bnRpbmcg
bW9kZSBjb2RlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2VpbGluIFdhbmcgPHdlaWxpbi53
YW5nQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL3BlcmYvdGVzdHMvc2hlbGwvdGVzdF9z
dGF0X2ludGVsX3RwZWJzLnNoICB8IDE4ICsrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA3NTUgdG9vbHMv
cGVyZi90ZXN0cy9zaGVsbC90ZXN0X3N0YXRfaW50ZWxfdHBlYnMuc2gNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS90b29scy9wZXJmL3Rlc3RzL3NoZWxsL3Rlc3Rfc3RhdF9pbnRlbF90cGVicy5zaA0K
PiBiL3Rvb2xzL3BlcmYvdGVzdHMvc2hlbGwvdGVzdF9zdGF0X2ludGVsX3RwZWJzLnNoDQo+ID4g
bmV3IGZpbGUgbW9kZSAxMDA3NTUNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmZlYThjYjFiODM2
Nw0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi90b29scy9wZXJmL3Rlc3RzL3NoZWxsL3Rl
c3Rfc3RhdF9pbnRlbF90cGVicy5zaA0KPiA+IEBAIC0wLDAgKzEsMTggQEANCj4gPiArIyEvYmlu
L2Jhc2gNCj4gPiArIyB0ZXN0IEludGVsIFRQRUJTIGNvdW50aW5nIG1vZGUNCj4gPiArIyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiA+ICsNCj4gPiArc2V0IC1lDQo+ID4gKw0K
PiA+ICsjIFVzZSB0aGlzIGV2ZW50IGZvciB0ZXN0aW5nIGJlY2F1c2UgaXQgc2hvdWxkIGV4aXN0
IGluIGFsbCBwbGF0Zm9ybXMNCj4gPiArZXZlbnQ9Y2FjaGUtbWlzc2VzOlINCj4gPiArDQo+ID4g
KyMgV2l0aG91dCB0aGlzIGNtZCBvcHRpb24sIGRlZmF1bHQgdmFsdWUgb3IgemVybyBpcyByZXR1
cm5lZA0KPiA+ICtlY2hvICJUZXN0aW5nIHdpdGhvdXQgLS1yZWNvcmQtdHBlYnMiDQo+ID4gK3Jl
c3VsdD0kKHBlcmYgc3RhdCAtZSAiJGV2ZW50IiB0cnVlIDI+JjEpDQo+ID4gK1tbICIkcmVzdWx0
IiA9fiAkZXZlbnQgXV0gfHwgZXhpdCAxDQo+ID4gKw0KPiA+ICsjIEluIHBsYXRmb3JtcyB0aGF0
IGRvIG5vdCBzdXBwb3J0IFRQRUJTLCBpdCBzaG91bGQgZXhlY3V0ZSB3aXRob3V0IGVycm9yLg0K
PiA+ICtlY2hvICJUZXN0aW5nIHdpdGggLS1yZWNvcmQtdHBlYnMiDQo+ID4gK3Jlc3VsdD0kKHBl
cmYgc3RhdCAtZSAiJGV2ZW50IiAtLXJlY29yZC10cGVicyAtYSBzbGVlcCAwLjAxIDI+JjEpDQo+
IA0KPiBJdCBuZXZlciBmaW5pc2hlcyBvbiBteSBBTUQgbWFjaGluZS4NCj4gDQpIaSBOYW1oeXVu
ZywNCg0KRG8geW91IHNlZSBhbnkgbWVzc2FnZSB3aGlsZSBpdCBleGVjdXRlcz8gSXMgdGhlIHBl
cmYgcmVjb3JkIGZvcmtlZCBzdWNjZXNzZnVsbHkNCmJ1dCBmYWlsZWQgdG8gcmV0dXJuPw0KDQpU
aGFua3MsDQpXZWlsaW4NCg0KPiBUaGFua3MsDQo+IE5hbWh5dW5nDQo+IA0KPiANCj4gPiArW1sg
IiRyZXN1bHQiID1+ICJwZXJmIHJlY29yZCIgJiYgIiRyZXN1bHQiID1+ICRldmVudCBdXSB8fCBl
eGl0IDENCj4gPiAtLQ0KPiA+IDIuNDMuMA0KPiA+DQo=
