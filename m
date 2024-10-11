Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF2133D1;
	Fri, 11 Oct 2024 04:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728621198; cv=fail; b=PHsao3RLe9ihVztSHlCX1XISHPT55RwVLbtYmpBdO97wU+/uJ4uAJl6xe+N84C0slnyu3d1jQRYzRPVPszFAnyGABUTCtizjbZU9F9bjfyloGweUHXgQlu1ZZ8mnicgZA+hBSxn9N4YI4561+TiNylEaqzjf9VSMAlcY9o2m+d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728621198; c=relaxed/simple;
	bh=Jly/rBQ9u0Z891gLT0O8zcfgvtRkttVvz3L7XzCThvA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WaYvg1F3AVDaZ0PG8c8mG3CNB7oCRFrY810QGiZGO5hcFUWTUIhrQcpU4FWWFbTVgLhpHfCSTMdOx/jusUazZbfvpVmwet82pWY1tyOSjKCIiOprAGvCj6I9GV7AF7eiJwBveJNFW2XKNFGEUZlFIdVQbAD+wQKkJg00L4fkFdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TLfWd5qO; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TLfWd5qO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728621191; x=1760157191;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=Jly/rBQ9u0Z891gLT0O8zcfgvtRkttVvz3L7XzCThvA=;
  b=TLfWd5qOWrgBllcf7LJYZRA/RhljjbBh2170Ltz6+4D6pQ5lPKg8DVKR
   Qyd7HSR00CLMEw5PG1Dshk6uJyVbldJJt0/iZWwhU1s1jvQiXBQT/y9oD
   UIqLmRk1OdrVg5eBJVmp7ujzinwzLdUdU4j8464FBSZQv25qlr7cGbuND
   TTTYNzHWpWO2durKPh5d6MNyf6W8mdHVaPgYocgEDBSQXUlxXDchkzbM7
   /WaI8dSEtgYs1VQDA3FWX1VD6uBOmql+creooyQ+4ysGwemZC9M5pxxx4
   d7InWXCJN7XWaq5+RgI9EXIqI10ZyfZ3wnilTDOcsCevqXgigfOusDDeW
   Q==;
X-CSE-ConnectionGUID: vBd6ApBtQ36Vn1zyuTWBLA==
X-CSE-MsgGUID: yEP8W++ZROm90rh5VgtjDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="53413594"
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="53413594"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 21:33:09 -0700
X-CSE-ConnectionGUID: f8vrBkzSSTCl3ZJ0aZxYpg==
X-CSE-MsgGUID: pgpSQ61RRZWoB9/H3HnZmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="77112073"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2024 21:33:09 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 21:33:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 21:33:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 10 Oct 2024 21:33:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 21:33:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkBAFF0XSC5Q0uHQNTkSBAcOey5Nm9pHlW2wGEAFn5bcQB+Q7KDJna/uPNdFKWd1TKjmarQjWM2sJ1wkTsa0M0enxfXnRnKPBA/QncjRGcalv7kM4MYAkWT9Vi4pOZCeRxaxnyOwCyJTvFEp0NwsR3rP7j2re8x/NDA39wFGCOv7GCZT6KZe2ylA9fnQLii8SnAUQQeN9YbVq40JpYpfhpe3cX9I599ALV+gzh6BGh4tt49U9Q8YAy3YG7qa0IjmK9w4WpQsJKZ2q7lV623Di/v8TBs1tfxmE8ORcqs9+j1T9TzpjHtU70hL0jrm+bvSW2h/+AJkFHTJP4WR40lBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgCSL58pu6cWtXD4tjgG//o5WHVZBjYqwcrMGTKAfUg=;
 b=iNaCiFPvYC31TKEYM/TTPCwq3VxrIcsbKpr/qARkRoViISfgITkAnTfPV7an+FbL4BE6Bc3itmhCDi09Hwk0/IbvCkp9PIHOJs3WnrK6TjBmGwVggtUYQX88JwQCwkox7dB3KFH9i014rSol+ALch/Dy/AhkHDIjF822ePpT43QxWbFK7wOKfHY9EDxEU4xeVnIL4zqa1jvtGQEeRZv6haRESoCv5EnCwCDtk/yeeGXDj54UmRqs5IyBonpIT71pSeK9oi058JGbUzlFRe+FhCuxheXcAdrPgMw2p9E5luOyPEz7Dn9KwVfXZC77oAaVUbqudMeLHjMYoCsfhfCrxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SN7PR11MB6727.namprd11.prod.outlook.com (2603:10b6:806:265::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Fri, 11 Oct
 2024 04:33:04 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 04:33:04 +0000
Date: Fri, 11 Oct 2024 12:32:50 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ian Rogers <irogers@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Arnaldo
 Carvalho de Melo" <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Kan
 Liang" <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>,
	Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v4 12/12] perf jevents: Add load event json to verify and
 allow fallbacks
Message-ID: <202410111230.6218f561-oliver.sang@intel.com>
Content-Type: multipart/mixed; boundary="VZJJSsuX2mnIFoRA"
Content-Disposition: inline
In-Reply-To: <20240926173554.404411-13-irogers@google.com>
X-ClientProxiedBy: KL1PR01CA0075.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SN7PR11MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bd508dc-2fcc-4c64-e74d-08dce9adcbc1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?61VBpOZ/peA0SjhixXyOt3/UBn0IB72MV2c13fyYjaO+YOkpdZDhariZCe6d?=
 =?us-ascii?Q?y1HbCrIa0DwjBxjK+KntoldZScEZfGou4+taVrWaiTQw2kLBKHony6bbSdth?=
 =?us-ascii?Q?KTp397uHRZ81y38N2SIiT1IwRV2/R6Doo8utwP8ymz3UAslTSaHRSj62FIuC?=
 =?us-ascii?Q?cP/zJMXecBvy9DfxCiXrj99zh+8ddv+GuatXHwL/Hv26VPLuxzreSqpdXlCo?=
 =?us-ascii?Q?KGW5lPPy8E9Vwbcnnt6qdof1sv5JeeqkEESwqyXursEH6pxbKtnstuJRo4NL?=
 =?us-ascii?Q?1xR7tL2IKY/vsJHWRmnO1eXnCv9JCn2FaZzKvkY7PnrKQFpGQOxjjlA2gbrL?=
 =?us-ascii?Q?xk1RH0v47Sk/RTDOtSv0kglSasSvyR4LbuRZ4+tJM1r7vbLYXTzwa9zZEF3u?=
 =?us-ascii?Q?mDnqJTmZRa9ZmYQehSh/MuGOcvUBr/LV/kSSJca9FYxs1rkw7PPt/Q9wddBs?=
 =?us-ascii?Q?AjFrMmts/aKjnbjs5P5Cl9VlGvKkose1qriwggu70slBX2/CP78I16kScjQn?=
 =?us-ascii?Q?CVf2KfAybtm0wXxojMPBPNUfuCyRAocsCGHijNgpljaHW7PCMsoD7Sk4u9Py?=
 =?us-ascii?Q?tohd0yNkA6GVyDtpgyBF27hlnPW7XRT8v1W05gR16bfG5XkRkvZs5SpeZ+NN?=
 =?us-ascii?Q?w+8R8CKH1EnMTQhzVwlS1WB1TFOqSbdNCvxMXgVJgpj3gflR6rNxCv0CFndw?=
 =?us-ascii?Q?XGgaGevYRW7unOfY/Clj19Y7x413f8o6eJY9hwBmI+E2dbxjtVNyRLz03evC?=
 =?us-ascii?Q?tGILhZ/bLjpDOR/bhyFfG7v/SY3s1ChKdQJ1kUR0yTPkCnoMPs5R5bGGkc3t?=
 =?us-ascii?Q?WM17YZpUeYr689O3iIE4XLDLsZFrjUl54bcJSmKiwiw/bgSki86+DieZbhhY?=
 =?us-ascii?Q?mgxlIhpG/uYNpE9GWaGwxTdzrjsoYD4hOn8Eg6dnq92ufezbgc1sjVOCQMkr?=
 =?us-ascii?Q?itswnhbrqPzuhmGIksmuMYa5Q7bhhfgRO+2hqh49+x04QwJSP7TR5rYssm2f?=
 =?us-ascii?Q?Rt0x12U/5IS7+AWv6Z9eerX6GTUQQHpUMxzdEp01Z5Xsjk+EPmC1bmcznbyS?=
 =?us-ascii?Q?cBEvJVCImjZa/c0xqZ7rogOPePlnomNCdKK48LhajExjAjqmqozhku216/7E?=
 =?us-ascii?Q?h/A2uVnJdc2q9vjDcyLtAhlOQLrH7fVmxhREID21SaYQonh+7ONG4RvSxbeL?=
 =?us-ascii?Q?2nIq7KKEVY+or3B+Z2pW/Un0B+i8wzmiDd5Wems+sPEFi9yzmpL78gGYCk4?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MxrLIQD06gVhg7xFaiuH7OsAG28hkia8LrCLVFm5M0hSE7uS/31HmGRoDqfi?=
 =?us-ascii?Q?7EyVdYx1a+WXjCEkOV9jC12boCJMAJj6/DtWv9jN5ueV2jwEqDkvQBdXCM8Y?=
 =?us-ascii?Q?1//41USRgXAW0FpeC3Kc6m8AKKmIA89GNSbP21zcBhiTSLl3pTGJnyrm7ITw?=
 =?us-ascii?Q?pUx8DmsJnnx1qV2AkSHYO3lmnTzBJ45+XK/u3uEm4rgx5W5he4rwtmHtxAgf?=
 =?us-ascii?Q?jp2gCI5WOAF/XI9zU5w7Wav33gxr7pZxjFW6B8EQPyLPFjppV4WUyxo9YjfP?=
 =?us-ascii?Q?ceARbVy1f18aq6kp9XZ9QkCOj2J36ic3exWwzV1sHxuxSKIxKMbKs3QoDoFm?=
 =?us-ascii?Q?SUxXBehP5aN1rW4Yr6jn3OAn/FLTWSKDSxgU5itZqfR9getzcGEeu0K1GUIV?=
 =?us-ascii?Q?NzgGlCg0PyyEqymyrY8upZBnhxxdL0mne+olOQ8iKgxs6Zb1YW6tTn37brN3?=
 =?us-ascii?Q?IYKo2UhG/Z9JlFAFUOiAlxCmXCRniz9mZ1C/D5ReKiuyXIi8gu0f3xoMHPa2?=
 =?us-ascii?Q?j7Ru4r+e5Ra+oUTwF7Pmwy14E6O/rto1r42sLykYBGR7zY5+HtSynFiXEXRl?=
 =?us-ascii?Q?ZyfcU0QMqW+Ze4If1kz46ZTskCWVGZHBVnAa+ANCCozk0nBbIVOYZ8BmFWo4?=
 =?us-ascii?Q?u6q+EoG0NZ4jH7icxDV2pQMXDVd/7ba9HaCfHQFdLXghPDF95MQRjBWTlJYf?=
 =?us-ascii?Q?DIY64SxzpSRc1PSirH/QY5BQknTNbIslHWohO1ozWXFXq9cjt8GPJSBSKBSG?=
 =?us-ascii?Q?MNuX0ffFYTGw4b4Yr1nZ09Tn5Gy+uhdlmTgSC5nQ+1Zu2Ju0wsiss0nIZddE?=
 =?us-ascii?Q?vTMa5aBwudaPIQmqIIS83Occyo8achD3OVXf8dsnFyRUSBHSofMHerufGeSD?=
 =?us-ascii?Q?bgUVaQuLHzcoIYcYWi8wghIpNu2sOL/wYaocJru7O1GsJGMUfPsXJW9xIm7t?=
 =?us-ascii?Q?2wOpMhnrciY63QKvnUwvt4cvN/XSwEcO6ZYSWwnSUMX8jHDx6ySVaJFD9AL4?=
 =?us-ascii?Q?WT7lB4aII8kBH+Q6C1uflHvuOXmrNK4lyoDbj7WsArN2HaJ9qosvajqNKeDt?=
 =?us-ascii?Q?bBhq+7wiYyOqPVARGLhVa1sMOvgADrqMHZSg9VkDUJ0t4J7PlPX0A3RBJXUv?=
 =?us-ascii?Q?kMVseFyUIugnSsMHOgiRx6ZqQYxM1Fg1QMEP8JY0+lODx6ByYD9RQZkW9uaB?=
 =?us-ascii?Q?4IHjMSq5sJ4qaKBZOW1Xyc2bH6cwqJ8DHxD4p0LI/8lCZOB3tuBF59HOkJGA?=
 =?us-ascii?Q?9MXucRJYZsvrL2Bu54ZSdzXv+NjvOvK+Y3MQEvSMwXPxY0s2aBabwaaZABJr?=
 =?us-ascii?Q?JdFkNw9PkUAOVo2XrkJm7LKzRuXHn7ngVMI1z+gIRj3O3tqw1ZgUg1B25TXW?=
 =?us-ascii?Q?mlRJASgaK4yL5D9rX71Ge1JGquwAEhRvAWpUzjbCCekuR/H9CqAhJ3GcJnGs?=
 =?us-ascii?Q?9UuQhor3GoYD304PcrIF/SoyAHbQjZtB47XSx/T1685Ipn2G1p086coQGgI1?=
 =?us-ascii?Q?zaQ8rqz9jcqe5bGDtBfsQqsq3MkjprIH/HeA7hHS/JV4h+w1uZLp3hbJvNMd?=
 =?us-ascii?Q?zP0cfrUZW3Z4rqHZA4pPmohEs0YPy571jApqNm8MwJ1TGWyguKEu9TiJKulV?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd508dc-2fcc-4c64-e74d-08dce9adcbc1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 04:33:04.4763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01YogCSXQcFxC2zaZsxKfFQRoxjgeSD8m6NVPo5JGB/yqOo9vaWUaPWgHt+3NvwsYACSwzvFac6vvmm7xxA9BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6727
X-OriginatorOrg: intel.com

--VZJJSsuX2mnIFoRA
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline



Hello,

kernel test robot noticed "perf-test.perf.make.fail" on:

commit: 1b58625961de2638d2d798db2f87b3ea0f3a53ed ("[PATCH v4 12/12] perf jevents: Add load event json to verify and allow fallbacks")
url: https://github.com/intel-lab-lkp/linux/commits/Ian-Rogers/perf-jevents-Allow-multiple-metricgroups-json-files/20240927-014027
base: https://git.kernel.org/cgit/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link: https://lore.kernel.org/all/20240926173554.404411-13-irogers@google.com/
patch subject: [PATCH v4 12/12] perf jevents: Add load event json to verify and allow fallbacks

in testcase: perf-test
version: perf-test-x86_64-679c985-1_20240823
with following parameters:

	type: lkp
	group: group-00



compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202410111230.6218f561-oliver.sang@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241011/202410111230.6218f561-oliver.sang@intel.com


(more build log is in attached output)


Traceback (most recent call last):
  File "/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d798db2f87b3ea0f3a53ed/tools/perf/pmu-events/amd_metrics.py", line 42, in <module>
    main()
  File "/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d798db2f87b3ea0f3a53ed/tools/perf/pmu-events/amd_metrics.py", line 32, in main
    LoadEvents(directory)
  File "/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d798db2f87b3ea0f3a53ed/tools/perf/pmu-events/metric.py", line 26, in LoadEvents
    for x in json.load(open(f"{directory}/{filename}")):
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/__init__.py", line 293, in load
    return loads(fp.read(),
           ^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/__init__.py", line 346, in loads
    return _default_decoder.decode(s)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/decoder.py", line 337, in decode
    obj, end = self.raw_decode(s, idx=_w(s, 0).end())
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/decoder.py", line 355, in raw_decode
    raise JSONDecodeError("Expecting value", s, err.value) from None
json.decoder.JSONDecodeError: Expecting value: line 1 column 1 (char 0)

...

Traceback (most recent call last):
  File "/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d798db2f87b3ea0f3a53ed/tools/perf/pmu-events/amd_metrics.py", line 42, in <module>
    main()
  File "/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d798db2f87b3ea0f3a53ed/tools/perf/pmu-events/amd_metrics.py", line 32, in main
    LoadEvents(directory)
  File "/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d798db2f87b3ea0f3a53ed/tools/perf/pmu-events/metric.py", line 26, in LoadEvents
    for x in json.load(open(f"{directory}/{filename}")):
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/__init__.py", line 293, in load
    return loads(fp.read(),
           ^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/__init__.py", line 346, in loads
    return _default_decoder.decode(s)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/decoder.py", line 337, in decode
    obj, end = self.raw_decode(s, idx=_w(s, 0).end())
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/decoder.py", line 355, in raw_decode
    raise JSONDecodeError("Expecting value", s, err.value) from None
json.decoder.JSONDecodeError: Expecting value: line 1 column 1 (char 0)

...

Traceback (most recent call last):
  File "/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d798db2f87b3ea0f3a53ed/tools/perf/pmu-events/amd_metrics.py", line 42, in <module>
    main()
  File "/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d798db2f87b3ea0f3a53ed/tools/perf/pmu-events/amd_metrics.py", line 32, in main
    LoadEvents(directory)
  File "/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d798db2f87b3ea0f3a53ed/tools/perf/pmu-events/metric.py", line 26, in LoadEvents
    for x in json.load(open(f"{directory}/{filename}")):
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/__init__.py", line 293, in load
    return loads(fp.read(),
           ^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/__init__.py", line 346, in loads
    return _default_decoder.decode(s)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/decoder.py", line 337, in decode
    obj, end = self.raw_decode(s, idx=_w(s, 0).end())
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/decoder.py", line 355, in raw_decode
    raise JSONDecodeError("Expecting value", s, err.value) from None
json.decoder.JSONDecodeError: Expecting value: line 1 column 1 (char 0)
make[3]: *** [pmu-events/Build:49: pmu-events/arch/x86/amdzen3/extra-metrics.json] Error 1
make[3]: *** Deleting file 'pmu-events/arch/x86/amdzen3/extra-metrics.json'
make[2]: *** [Makefile.perf:765: pmu-events/pmu-events-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


--VZJJSsuX2mnIFoRA
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="output"
Content-Transfer-Encoding: quoted-printable

=3D=3D> /tmp/stdout <=3D=3D

=3D=3D> /tmp/stderr <=3D=3D

=3D=3D> /tmp/stdout <=3D=3D
RESULT_ROOT=3D/result/perf-test/group-00-lkp/lkp-spr-2sp1/debian-12-x86_64-=
20240206.cgz/x86_64-rhel-8.3-bpf/gcc-12/1b58625961de2638d2d798db2f87b3ea0f3=
a53ed/3
job=3D/lkp/jobs/scheduled/lkp-spr-2sp1/perf-test-group-00-lkp-debian-12-x86=
_64-20240206.cgz-1b58625961de-20241002-83947-l8seva-1.yaml
result_service: raw_upload, RESULT_MNT: /internal-lkp-server/result, RESULT=
_ROOT: /internal-lkp-server/result/perf-test/group-00-lkp/lkp-spr-2sp1/debi=
an-12-x86_64-20240206.cgz/x86_64-rhel-8.3-bpf/gcc-12/1b58625961de2638d2d798=
db2f87b3ea0f3a53ed/3, TMP_RESULT_ROOT: /tmp/lkp/result
run-job /lkp/jobs/scheduled/lkp-spr-2sp1/perf-test-group-00-lkp-debian-12-x=
86_64-20240206.cgz-1b58625961de-20241002-83947-l8seva-1.yaml
/usr/bin/wget -q --timeout=3D3600 --tries=3D1 --local-encoding=3DUTF-8 http=
://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=3D/l=
kp/jobs/scheduled/lkp-spr-2sp1/perf-test-group-00-lkp-debian-12-x86_64-2024=
0206.cgz-1b58625961de-20241002-83947-l8seva-1.yaml&job_state=3Drunning -O /=
dev/null
target ucode: 0x2b0004b1
LKP: stdout: 3334: current_version: 2b0004b1, target_version: 2b0004b1
check_nr_cpu
CPU(s):                               224
On-line CPU(s) list:                  0-223
Thread(s) per core:                   2
Core(s) per socket:                   56
Socket(s):                            2
CPU(s) scaling MHz:                   26%
NUMA node(s):                         2
NUMA node0 CPU(s):                    0-55,112-167
NUMA node1 CPU(s):                    56-111,168-223
IPMI BMC is not supported on this machine, skip bmc-watchdog setup!
gcc march setting is sapphirerapids
valid
2024-10-02 01:02:46 make -j224 WERROR=3D0 ARCH=3D DEBUG=3D1 EXTRA_CFLAGS=3D=
-fno-omit-frame-pointer -fsanitize=3Dundefined -fsanitize=3Daddress -C /usr=
/src/linux-perf-x86_64-rhel-8.3-bpf-1b58625961de2638d2d798db2f87b3ea0f3a53e=
d/tools/perf
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b586=
25961de2638d2d798db2f87b3ea0f3a53ed/tools/perf'
  BUILD:   Doing 'make =1B[33m-j224=1B[m' parallel build

=3D=3D> /tmp/stderr <=3D=3D
  diff -u tools/include/linux/coresight-pmu.h include/linux/coresight-pmu.h
  diff -u tools/lib/list_sort.c lib/list_sort.c

=3D=3D> /tmp/stdout <=3D=3D
=1B[0;33mWarning=1B[0m: Kernel ABI header differences:

=3D=3D> /tmp/stderr <=3D=3D
Makefile.config:700: Warning: Disabled BPF skeletons as clang (clang) is mi=
ssing
Makefile.config:991: No libllvm 13+ found, slower source file resolution, p=
lease install llvm-devel/llvm-dev

=3D=3D> /tmp/stdout <=3D=3D

Auto-detecting system features:
...                                   dwarf: [ =1B[32mon=1B[m  ]
...                      dwarf_getlocations: [ =1B[32mon=1B[m  ]
...                                   glibc: [ =1B[32mon=1B[m  ]
...                                  libbfd: [ =1B[32mon=1B[m  ]
...                          libbfd-buildid: [ =1B[32mon=1B[m  ]
...                                  libcap: [ =1B[32mon=1B[m  ]
...                                  libelf: [ =1B[32mon=1B[m  ]
...                                 libnuma: [ =1B[32mon=1B[m  ]
...                  numa_num_possible_cpus: [ =1B[32mon=1B[m  ]
...                                 libperl: [ =1B[32mon=1B[m  ]
...                               libpython: [ =1B[32mon=1B[m  ]
...                               libcrypto: [ =1B[32mon=1B[m  ]
...                               libunwind: [ =1B[32mon=1B[m  ]
...                      libdw-dwarf-unwind: [ =1B[32mon=1B[m  ]
...                             libcapstone: [ =1B[32mon=1B[m  ]
...                               llvm-perf: [ =1B[31mOFF=1B[m ]
...                                    zlib: [ =1B[32mon=1B[m  ]
...                                    lzma: [ =1B[32mon=1B[m  ]
...                               get_cpuid: [ =1B[32mon=1B[m  ]
...                                     bpf: [ =1B[32mon=1B[m  ]
...                                  libaio: [ =1B[32mon=1B[m  ]
...                                 libzstd: [ =1B[32mon=1B[m  ]

  GEN     common-cmds.h
  GEN     /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/arch/arm64/include/generated/asm/sysreg-defs=
.h
  CC      jvmti/libjvmti.o
  CC      dlfilters/dlfilter-test-api-v0.o
  CC      jvmti/jvmti_agent.o
  CC      dlfilters/dlfilter-test-api-v2.o
  CC      dlfilters/dlfilter-show-cycles.o
  CC      jvmti/libstring.o
  CC      jvmti/libctype.o

=3D=3D> /tmp/stderr <=3D=3D
  PERF_VERSION =3D 6.11.0-rc6

=3D=3D> /tmp/stdout <=3D=3D
  GEN     perf-archive
  GEN     perf-iostat
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libsubcmd/include/subcmd/exec-cmd.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libsubcmd/include/subcmd/help.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libsubcmd/include/subcmd/pager.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libsubcmd/include/subcmd/parse-options.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libsubcmd/include/subcmd/run-command.h
  INSTALL libsubcmd_headers
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libperf/include/perf/bpf_perf.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libperf/include/perf/core.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libapi/include/api/cpu.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libperf/include/perf/cpumap.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libapi/include/api/debug.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libperf/include/perf/threadmap.h
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libperf/core.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libperf/include/perf/evlist.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libsymbol/include/symbol/kallsyms.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libapi/include/api/io.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libapi/include/api/fd/array.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libperf/include/perf/evsel.h
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libperf/cpumap.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libapi/include/api/fs/fs.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libperf/include/perf/event.h
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libperf/threadmap.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libperf/include/perf/mmap.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libapi/include/api/fs/tracing_path.h
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libapi/cpu.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libsymbol/kallsyms.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libperf/evsel.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libperf/include/internal/cpumap.h
  MKDIR   /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libapi/fd/
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libapi/debug.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libperf/include/internal/evlist.h
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libapi/str_error_r.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libperf/evlist.o
  MKDIR   /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libapi/fs/
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libperf/include/internal/evsel.h
  MKDIR   /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libapi/fs/
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libperf/mmap.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libperf/include/internal/lib.h
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libperf/zalloc.o
  MKDIR   /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libapi/fs/
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libperf/xyarray.o
  INSTALL libsymbol_headers
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libperf/include/internal/mmap.h
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libapi/fd/array.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libperf/lib.o
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libperf/include/internal/threadmap.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libperf/include/internal/rc_check.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libperf/include/internal/xyarray.h
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libapi/fs/fs.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libapi/fs/tracing_path.o
  INSTALL libapi_headers
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libapi/fs/cgroup.o
  GEN     /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/bpf_helper_defs.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/include/bpf/bpf.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/include/bpf/libbpf.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/include/bpf/btf.h
  INSTALL libperf_headers
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/include/bpf/libbpf_common.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/include/bpf/libbpf_legacy.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/include/bpf/bpf_helpers.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/include/bpf/bpf_tracing.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/include/bpf/bpf_endian.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/include/bpf/bpf_core_read.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/include/bpf/skel_internal.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/include/bpf/libbpf_version.h
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/include/bpf/usdt.bpf.h
  LINK    dlfilters/dlfilter-show-cycles.so
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libsubcmd/exec-cmd.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libsubcmd/help.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libsubcmd/pager.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libsubcmd/parse-options.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libsubcmd/run-command.o
  LINK    dlfilters/dlfilter-test-api-v0.so
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libsubcmd/sigchain.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libsubcmd/subcmd-config.o
  LINK    dlfilters/dlfilter-test-api-v2.so
  INSTALL /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/include/bpf/bpf_helper_defs.h
  INSTALL libbpf_headers
  LD      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libapi/fd/libapi-in.o
  LD      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libsymbol/libsymbol-in.o
  LD      jvmti/jvmti-in.o
  AR      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libsymbol/libsymbol.a
  LINK    libperf-jvmti.so
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/staticobjs/libbpf.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/staticobjs/bpf.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/staticobjs/nlattr.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/staticobjs/btf.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/staticobjs/libbpf_errno.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/staticobjs/str_error.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/staticobjs/netlink.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/staticobjs/bpf_prog_linfo.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/staticobjs/libbpf_probes.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/staticobjs/hashmap.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/staticobjs/btf_dump.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/staticobjs/ringbuf.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/staticobjs/strset.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/staticobjs/linker.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/staticobjs/gen_loader.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/staticobjs/relo_core.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/staticobjs/usdt.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/staticobjs/zip.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/staticobjs/elf.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/staticobjs/features.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/staticobjs/btf_iter.o
  CC      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/staticobjs/btf_relocate.o
  LD      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libapi/fs/libapi-in.o
  LD      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libapi/libapi-in.o
  AR      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libapi/libapi.a
  LD      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libperf/libperf-in.o
  AR      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libperf/libperf.a
  LD      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libsubcmd/libsubcmd-in.o
  AR      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libsubcmd/libsubcmd.a
  LD      /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/staticobjs/libbpf-in.o
  LINK    /usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d79=
8db2f87b3ea0f3a53ed/tools/perf/libbpf/libbpf.a
  CC      builtin-bench.o
  CC      ui/setup.o
  CC      bench/sched-messaging.o
  CC      tests/builtin-test.o
  CC      bench/sched-pipe.o
  CC      ui/helpline.o
  CC      builtin-annotate.o
  CC      tests/tests-scripts.o
  CC      ui/progress.o
  CC      bench/sched-seccomp-notify.o
  CC      arch/common.o
  CC      builtin-check.o
  CC      tests/parse-events.o
  CC      ui/util.o
  CC      bench/syscall.o
  CC      builtin-config.o
  CC      tests/dso-data.o
  CC      ui/hist.o
  CC      tests/attr.o
  CC      builtin-diff.o
  CC      bench/mem-functions.o
  CC      tests/vmlinux-kallsyms.o
  CC      ui/stdio/hist.o
  CC      builtin-evlist.o
  CC      tests/openat-syscall.o
  CC      bench/futex-hash.o
  CC      ui/browser.o
  CC      builtin-ftrace.o
  CC      tests/openat-syscall-all-cpus.o
  CC      scripts/python/Perf-Trace-Util/Context.o
  CC      bench/futex-wake.o
  CC      arch/x86/tests/regs_load.o
  CC      builtin-help.o
  CC      scripts/perl/Perf-Trace-Util/Context.o
  CC      arch/x86/tests/dwarf-unwind.o
  CC      builtin-buildid-list.o
  CC      bench/futex-wake-parallel.o
  CC      tests/openat-syscall-tp-fields.o
  CC      arch/x86/tests/arch-tests.o
  CC      arch/x86/tests/sample-parsing.o
  CC      builtin-buildid-cache.o
  CC      bench/futex-requeue.o
  CC      tests/mmap-basic.o
  CC      arch/x86/tests/hybrid.o
  CC      builtin-kallsyms.o
  CC      tests/perf-record.o
  CC      bench/futex-lock-pi.o
  CC      bench/epoll-wait.o
  CC      builtin-list.o
  CC      tests/evsel-roundtrip-name.o
  CC      arch/x86/tests/intel-pt-test.o
  CC      arch/x86/util/header.o
  CC      arch/x86/tests/bp-modify.o
  CC      builtin-record.o
  CC      ui/browsers/annotate.o
  CC      tests/evsel-tp-sched.o
  CC      bench/epoll-ctl.o
  CC      arch/x86/util/tsc.o
  CC      ui/tui/setup.o
  CC      tests/fdarray.o
  CC      bench/synthesize.o
  CC      arch/x86/tests/amd-ibs-via-core-pmu.o
  CC      builtin-report.o
  CC      arch/x86/util/pmu.o
  CC      ui/tui/util.o
  CC      ui/browsers/annotate-data.o
  CC      ui/browsers/map.o
  CC      tests/pmu-events.o
  CC      ui/browsers/hists.o
  CC      bench/kallsyms-parse.o
  CC      arch/x86/util/kvm-stat.o
  CC      ui/tui/progress.o
  CC      tests/pmu.o
  CC      ui/tui/helpline.o
  CC      builtin-stat.o
  CC      bench/find-bit-bench.o
  CC      builtin-top.o
  CC      tests/hists_common.o
  CC      arch/x86/util/perf_regs.o
  CC      ui/browsers/scripts.o
  CC      tests/hists_link.o
  CC      arch/x86/util/topdown.o
  CC      bench/inject-buildid.o
  CC      arch/x86/util/machine.o
  CC      bench/evlist-open-close.o
  CC      bench/breakpoint.o
  CC      tests/hists_output.o
  CC      tests/hists_filter.o
  CC      ui/browsers/header.o
  CC      builtin-script.o
  CC      ui/browsers/res_sample.o
  CC      builtin-kvm.o
  CC      arch/x86/util/evlist.o
  CC      tests/hists_cumulate.o
  CC      arch/x86/util/event.o
  CC      bench/pmu-scan.o
  CC      builtin-inject.o
  CC      tests/python-use.o
  CC      arch/x86/util/mem-events.o
  CC      bench/uprobe.o
  CC      tests/bp_signal.o
  CC      arch/x86/util/evsel.o
  CC      bench/mem-memcpy-x86-64-asm.o
  CC      builtin-mem.o
  CC      bench/mem-memset-x86-64-asm.o
  CC      tests/bp_signal_overflow.o
  CC      builtin-data.o
  CC      bench/numa.o
  CC      arch/x86/util/iostat.o
  CC      tests/wp.o
  CC      builtin-version.o
  CC      tests/bp_account.o
  CC      arch/x86/util/dwarf-regs.o
  CC      arch/x86/util/env.o
  CC      arch/x86/util/unwind-libunwind.o
  CC      builtin-c2c.o
  CC      builtin-daemon.o
  CC      tests/sw-clock.o
  CC      tests/task-exit.o
  CC      tests/mmap-thread-lookup.o
  CC      arch/x86/util/archinsn.o
  CC      builtin-kmem.o
  CC      arch/x86/util/intel-pt.o
  CC      arch/x86/util/auxtrace.o
  CC      tests/thread-maps-share.o
  CC      builtin-kwork.o
  CC      arch/x86/util/intel-bts.o
  CC      tests/keep-tracking.o
  CC      builtin-lock.o
  CC      tests/switch-tracking.o
  CC      tests/code-reading.o
  CC      builtin-timechart.o
  CC      builtin-sched.o
  CC      tests/parse-no-sample-id-all.o
  CC      tests/sample-parsing.o
  CC      tests/kmod-path.o
  CC      tests/thread-map.o
  CC      tests/mem.o
  CC      builtin-trace.o
  CC      builtin-probe.o
  CC      tests/topology.o
  CC      tests/cpumap.o
  CC      perf.o
  CC      tests/stat.o
  CC      tests/event_update.o
  CC      tests/event-times.o
  LD      arch/perf-in.o
  CC      tests/expr.o
  CC      tests/backward-ring-buffer.o
  CC      trace/beauty/clone.o
  CC      tests/sdt.o
  CC      trace/beauty/fcntl.o
  CC      trace/beauty/flock.o
  CC      tests/is_printable_array.o
  CC      tests/bitmap.o
  CC      trace/beauty/fs_at_flags.o
  CC      tests/perf-hooks.o
  CC      trace/beauty/fsmount.o
  CC      trace/beauty/fspick.o
  CC      tests/unit_number__scnprintf.o
  CC      trace/beauty/ioctl.o
  CC      tests/mem2node.o
  CC      trace/beauty/kcmp.o
  CC      tests/maps.o
  CC      tests/time-utils-test.o
  CC      trace/beauty/mount_flags.o
  CC      tests/genelf.o
  CC      trace/beauty/move_mount.o
  CC      tests/api-io.o
  CC      tests/demangle-java-test.o
  CC      trace/beauty/pkey_alloc.o
  CC      trace/beauty/arch_prctl.o
  CC      tests/demangle-ocaml-test.o
  CC      tests/pfm.o
  CC      trace/beauty/prctl.o
  CC      trace/beauty/renameat.o
  CC      trace/beauty/sockaddr.o
  CC      tests/parse-metric.o
  CC      tests/expand-cgroup.o
  CC      tests/pe-file-parsing.o
  CC      tests/sigtrap.o
  CC      trace/beauty/statx.o
  CC      trace/beauty/socket.o
  CC      tests/perf-time-to-tsc.o
  CC      tests/dlfilter-test.o
  CC      trace/beauty/sync_file_range.o
  CC      trace/beauty/timespec.o
  CC      tests/event_groups.o
  CC      tests/symbols.o
  CC      tests/util.o
  CC      tests/dwarf-unwind.o
  CC      trace/beauty/tracepoints/x86_irq_vectors.o
  CC      trace/beauty/tracepoints/x86_msr.o
  CC      tests/workloads/noploop.o
  CC      tests/workloads/thloop.o
  CC      tests/workloads/leafloop.o
  CC      tests/workloads/sqrtloop.o
  CC      tests/workloads/brstack.o
  CC      tests/workloads/datasym.o
  CC      tests/workloads/landlock.o
  CC      util/arm64-frame-pointer-unwind-support.o
  CC      util/addr_location.o
  CC      util/annotate.o
  CC      util/block-info.o
  CC      util/block-range.o
  CC      util/build-id.o
  CC      util/cacheline.o
  CC      util/config.o
  CC      util/copyfile.o
  CC      util/ctype.o
  CC      util/db-export.o
  CC      util/disasm.o
  CC      util/disasm_bpf.o
  CC      util/env.o
  CC      util/event.o
  CC      util/evlist.o
  CC      util/sideband_evlist.o
  CC      util/evsel.o
  CC      util/evsel_fprintf.o
  CC      util/perf_event_attr_fprintf.o
  CC      util/evswitch.o
  CC      util/find_bit.o
  CC      util/get_current_dir_name.o
  CC      util/levenshtein.o
  CC      util/mmap.o
  CC      util/memswap.o
  BISON   util/parse-events-bison.c
  CC      util/print-events.o
  CC      util/tracepoint.o
  CC      util/perf_regs.o
  CC      util/intel-pt-decoder/intel-pt-pkt-decoder.o
  CC      util/perf-regs-arch/perf_regs_aarch64.o

=3D=3D> /tmp/stderr <=3D=3D
make[3]: Circular pmu-events/arch/test/arch-std-events.json <- pmu-events/a=
rch/test/arch-std-events.json dependency dropped.
make[3]: Circular pmu-events/arch/test/test_soc/sys/uncore.json <- pmu-even=
ts/arch/test/test_soc/sys/uncore.json dependency dropped.
make[3]: Circular pmu-events/arch/test/test_soc/cpu/metrics.json <- pmu-eve=
nts/arch/test/test_soc/cpu/metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/test/test_soc/cpu/uncore.json <- pmu-even=
ts/arch/test/test_soc/cpu/uncore.json dependency dropped.
make[3]: Circular pmu-events/arch/test/test_soc/cpu/branch.json <- pmu-even=
ts/arch/test/test_soc/cpu/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/test/test_soc/cpu/cache.json <- pmu-event=
s/arch/test/test_soc/cpu/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/test/test_soc/cpu/other.json <- pmu-event=
s/arch/test/test_soc/cpu/other.json dependency dropped.
make[3]: Circular pmu-events/arch/nds32/n13/atcpmu.json <- pmu-events/arch/=
nds32/n13/atcpmu.json dependency dropped.
make[3]: Circular pmu-events/arch/nds32/mapfile.csv <- pmu-events/arch/nds3=
2/mapfile.csv dependency dropped.
make[3]: Circular pmu-events/arch/riscv/thead/c900-legacy/firmware.json <- =
pmu-events/arch/riscv/thead/c900-legacy/firmware.json dependency dropped.
make[3]: Circular pmu-events/arch/riscv/thead/c900-legacy/microarch.json <-=
 pmu-events/arch/riscv/thead/c900-legacy/microarch.json dependency dropped.
make[3]: Circular pmu-events/arch/riscv/thead/c900-legacy/cache.json <- pmu=
-events/arch/riscv/thead/c900-legacy/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/riscv/thead/c900-legacy/instruction.json =
<- pmu-events/arch/riscv/thead/c900-legacy/instruction.json dependency drop=
ped.
make[3]: Circular pmu-events/arch/riscv/sifive/u74/firmware.json <- pmu-eve=
nts/arch/riscv/sifive/u74/firmware.json dependency dropped.
make[3]: Circular pmu-events/arch/riscv/sifive/u74/memory.json <- pmu-event=
s/arch/riscv/sifive/u74/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/riscv/sifive/u74/microarch.json <- pmu-ev=
ents/arch/riscv/sifive/u74/microarch.json dependency dropped.
make[3]: Circular pmu-events/arch/riscv/sifive/u74/instructions.json <- pmu=
-events/arch/riscv/sifive/u74/instructions.json dependency dropped.
make[3]: Circular pmu-events/arch/riscv/andes/ax45/firmware.json <- pmu-eve=
nts/arch/riscv/andes/ax45/firmware.json dependency dropped.
make[3]: Circular pmu-events/arch/riscv/andes/ax45/memory.json <- pmu-event=
s/arch/riscv/andes/ax45/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/riscv/andes/ax45/microarch.json <- pmu-ev=
ents/arch/riscv/andes/ax45/microarch.json dependency dropped.
make[3]: Circular pmu-events/arch/riscv/andes/ax45/instructions.json <- pmu=
-events/arch/riscv/andes/ax45/instructions.json dependency dropped.
make[3]: Circular pmu-events/arch/riscv/mapfile.csv <- pmu-events/arch/risc=
v/mapfile.csv dependency dropped.
make[3]: Circular pmu-events/arch/riscv/starfive/dubhe-80/firmware.json <- =
pmu-events/arch/riscv/starfive/dubhe-80/firmware.json dependency dropped.
make[3]: Circular pmu-events/arch/riscv/starfive/dubhe-80/common.json <- pm=
u-events/arch/riscv/starfive/dubhe-80/common.json dependency dropped.
make[3]: Circular pmu-events/arch/riscv/riscv-sbi-firmware.json <- pmu-even=
ts/arch/riscv/riscv-sbi-firmware.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/freescale/imx93/sys/metrics.json <-=
 pmu-events/arch/arm64/freescale/imx93/sys/metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/freescale/imx93/sys/ddrc.json <- pm=
u-events/arch/arm64/freescale/imx93/sys/ddrc.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/freescale/imx8mq/sys/metrics.json <=
- pmu-events/arch/arm64/freescale/imx8mq/sys/metrics.json dependency droppe=
d.
make[3]: Circular pmu-events/arch/arm64/freescale/imx8mq/sys/ddrc.json <- p=
mu-events/arch/arm64/freescale/imx8mq/sys/ddrc.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/freescale/imx8mn/sys/metrics.json <=
- pmu-events/arch/arm64/freescale/imx8mn/sys/metrics.json dependency droppe=
d.
make[3]: Circular pmu-events/arch/arm64/freescale/imx8mn/sys/ddrc.json <- p=
mu-events/arch/arm64/freescale/imx8mn/sys/ddrc.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/freescale/imx8mp/sys/metrics.json <=
- pmu-events/arch/arm64/freescale/imx8mp/sys/metrics.json dependency droppe=
d.
make[3]: Circular pmu-events/arch/arm64/freescale/imx8mp/sys/ddrc.json <- p=
mu-events/arch/arm64/freescale/imx8mp/sys/ddrc.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/freescale/imx95/sys/metrics.json <-=
 pmu-events/arch/arm64/freescale/imx95/sys/metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/freescale/imx95/sys/ddrc.json <- pm=
u-events/arch/arm64/freescale/imx95/sys/ddrc.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json <=
- pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json dependency droppe=
d.
make[3]: Circular pmu-events/arch/arm64/freescale/imx8mm/sys/ddrc.json <- p=
mu-events/arch/arm64/freescale/imx8mm/sys/ddrc.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json =
<- pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json dependency drop=
ped.
make[3]: Circular pmu-events/arch/arm64/thead/yitian710/sys/metrics.json <-=
 pmu-events/arch/arm64/thead/yitian710/sys/metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/thead/yitian710/sys/ali_drw.json <-=
 pmu-events/arch/arm64/thead/yitian710/sys/ali_drw.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-cpa.json=
 <- pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-cpa.json dependency dr=
opped.
make[3]: Circular pmu-events/arch/arm64/hisilicon/hip08/metrics.json <- pmu=
-events/arch/arm64/hisilicon/hip08/metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json <-=
 pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json <- =
pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json <=
- pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json dependency droppe=
d.
make[3]: Circular pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json <- =
pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/fujitsu/a64fx/sve.json <- pmu-event=
s/arch/arm64/fujitsu/a64fx/sve.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/fujitsu/a64fx/memory.json <- pmu-ev=
ents/arch/arm64/fujitsu/a64fx/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/fujitsu/a64fx/cycle.json <- pmu-eve=
nts/arch/arm64/fujitsu/a64fx/cycle.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/fujitsu/a64fx/branch.json <- pmu-ev=
ents/arch/arm64/fujitsu/a64fx/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/fujitsu/a64fx/cache.json <- pmu-eve=
nts/arch/arm64/fujitsu/a64fx/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/fujitsu/a64fx/exception.json <- pmu=
-events/arch/arm64/fujitsu/a64fx/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/fujitsu/a64fx/other.json <- pmu-eve=
nts/arch/arm64/fujitsu/a64fx/other.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/fujitsu/a64fx/bus.json <- pmu-event=
s/arch/arm64/fujitsu/a64fx/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/fujitsu/a64fx/pipeline.json <- pmu-=
events/arch/arm64/fujitsu/a64fx/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/fujitsu/a64fx/instruction.json <- p=
mu-events/arch/arm64/fujitsu/a64fx/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/common-and-microarch.json <- pmu-ev=
ents/arch/arm64/common-and-microarch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a78/memory.json <- pmu-e=
vents/arch/arm64/arm/cortex-a78/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a78/branch.json <- pmu-e=
vents/arch/arm64/arm/cortex-a78/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a78/cache.json <- pmu-ev=
ents/arch/arm64/arm/cortex-a78/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a78/exception.json <- pm=
u-events/arch/arm64/arm/cortex-a78/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a78/bus.json <- pmu-even=
ts/arch/arm64/arm/cortex-a78/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a78/pipeline.json <- pmu=
-events/arch/arm64/arm/cortex-a78/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a78/instruction.json <- =
pmu-events/arch/arm64/arm/cortex-a78/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cmn/sys/metric.json <- pmu-even=
ts/arch/arm64/arm/cmn/sys/metric.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cmn/sys/cmn.json <- pmu-events/=
arch/arm64/arm/cmn/sys/cmn.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a710/trace.json <- pmu-e=
vents/arch/arm64/arm/cortex-a710/trace.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a710/memory.json <- pmu-=
events/arch/arm64/arm/cortex-a710/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a710/branch.json <- pmu-=
events/arch/arm64/arm/cortex-a710/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a710/cache.json <- pmu-e=
vents/arch/arm64/arm/cortex-a710/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a710/exception.json <- p=
mu-events/arch/arm64/arm/cortex-a710/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a710/bus.json <- pmu-eve=
nts/arch/arm64/arm/cortex-a710/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a710/pipeline.json <- pm=
u-events/arch/arm64/arm/cortex-a710/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a710/instruction.json <-=
 pmu-events/arch/arm64/arm/cortex-a710/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a510/pmu.json <- pmu-eve=
nts/arch/arm64/arm/cortex-a510/pmu.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a510/trace.json <- pmu-e=
vents/arch/arm64/arm/cortex-a510/trace.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a510/memory.json <- pmu-=
events/arch/arm64/arm/cortex-a510/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a510/branch.json <- pmu-=
events/arch/arm64/arm/cortex-a510/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a510/cache.json <- pmu-e=
vents/arch/arm64/arm/cortex-a510/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a510/exception.json <- p=
mu-events/arch/arm64/arm/cortex-a510/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a510/bus.json <- pmu-eve=
nts/arch/arm64/arm/cortex-a510/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a510/pipeline.json <- pm=
u-events/arch/arm64/arm/cortex-a510/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a510/instruction.json <-=
 pmu-events/arch/arm64/arm/cortex-a510/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-x2/trace.json <- pmu-eve=
nts/arch/arm64/arm/cortex-x2/trace.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-x2/memory.json <- pmu-ev=
ents/arch/arm64/arm/cortex-x2/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-x2/branch.json <- pmu-ev=
ents/arch/arm64/arm/cortex-x2/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-x2/cache.json <- pmu-eve=
nts/arch/arm64/arm/cortex-x2/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-x2/exception.json <- pmu=
-events/arch/arm64/arm/cortex-x2/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-x2/bus.json <- pmu-event=
s/arch/arm64/arm/cortex-x2/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-x2/pipeline.json <- pmu-=
events/arch/arm64/arm/cortex-x2/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-x2/instruction.json <- p=
mu-events/arch/arm64/arm/cortex-x2/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/metrics.json <- pmu=
-events/arch/arm64/arm/neoverse-v1/metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/general.json <- pmu=
-events/arch/arm64/arm/neoverse-v1/general.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/sve.json <- pmu-eve=
nts/arch/arm64/arm/neoverse-v1/sve.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/l1i_cache.json <- p=
mu-events/arch/arm64/arm/neoverse-v1/l1i_cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/fp_operation.json <=
- pmu-events/arch/arm64/arm/neoverse-v1/fp_operation.json dependency droppe=
d.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/spe.json <- pmu-eve=
nts/arch/arm64/arm/neoverse-v1/spe.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/spec_operation.json=
 <- pmu-events/arch/arm64/arm/neoverse-v1/spec_operation.json dependency dr=
opped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/memory.json <- pmu-=
events/arch/arm64/arm/neoverse-v1/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/l3_cache.json <- pm=
u-events/arch/arm64/arm/neoverse-v1/l3_cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/stall.json <- pmu-e=
vents/arch/arm64/arm/neoverse-v1/stall.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/exception.json <- p=
mu-events/arch/arm64/arm/neoverse-v1/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/ll_cache.json <- pm=
u-events/arch/arm64/arm/neoverse-v1/ll_cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/l2_cache.json <- pm=
u-events/arch/arm64/arm/neoverse-v1/l2_cache.json dependency dropped.

=3D=3D> /tmp/stdout <=3D=3D
  GEN     util/intel-pt-decoder/inat-tables.c

=3D=3D> /tmp/stderr <=3D=3D
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/bus.json <- pmu-eve=
nts/arch/arm64/arm/neoverse-v1/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/l1d_cache.json <- p=
mu-events/arch/arm64/arm/neoverse-v1/l1d_cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/retired.json <- pmu=
-events/arch/arm64/arm/neoverse-v1/retired.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-v1/tlb.json <- pmu-eve=
nts/arch/arm64/arm/neoverse-v1/tlb.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n1/metrics.json <- pmu=
-events/arch/arm64/arm/neoverse-n1/metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n1/general.json <- pmu=
-events/arch/arm64/arm/neoverse-n1/general.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n1/l1i_cache.json <- p=
mu-events/arch/arm64/arm/neoverse-n1/l1i_cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n1/spe.json <- pmu-eve=
nts/arch/arm64/arm/neoverse-n1/spe.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n1/spec_operation.json=
 <- pmu-events/arch/arm64/arm/neoverse-n1/spec_operation.json dependency dr=
opped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n1/memory.json <- pmu-=
events/arch/arm64/arm/neoverse-n1/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n1/l3_cache.json <- pm=
u-events/arch/arm64/arm/neoverse-n1/l3_cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n1/stall.json <- pmu-e=
vents/arch/arm64/arm/neoverse-n1/stall.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n1/exception.json <- p=
mu-events/arch/arm64/arm/neoverse-n1/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n1/ll_cache.json <- pm=
u-events/arch/arm64/arm/neoverse-n1/ll_cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n1/l2_cache.json <- pm=
u-events/arch/arm64/arm/neoverse-n1/l2_cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n1/bus.json <- pmu-eve=
nts/arch/arm64/arm/neoverse-n1/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n1/l1d_cache.json <- p=
mu-events/arch/arm64/arm/neoverse-n1/l1d_cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n1/retired.json <- pmu=
-events/arch/arm64/arm/neoverse-n1/retired.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n1/tlb.json <- pmu-eve=
nts/arch/arm64/arm/neoverse-n1/tlb.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a35/memory.json <- pmu-e=
vents/arch/arm64/arm/cortex-a35/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a35/branch.json <- pmu-e=
vents/arch/arm64/arm/cortex-a35/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a35/cache.json <- pmu-ev=
ents/arch/arm64/arm/cortex-a35/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a35/exception.json <- pm=
u-events/arch/arm64/arm/cortex-a35/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a35/bus.json <- pmu-even=
ts/arch/arm64/arm/cortex-a35/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a35/instruction.json <- =
pmu-events/arch/arm64/arm/cortex-a35/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a55/memory.json <- pmu-e=
vents/arch/arm64/arm/cortex-a55/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a55/branch.json <- pmu-e=
vents/arch/arm64/arm/cortex-a55/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a55/cache.json <- pmu-ev=
ents/arch/arm64/arm/cortex-a55/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a55/exception.json <- pm=
u-events/arch/arm64/arm/cortex-a55/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a55/bus.json <- pmu-even=
ts/arch/arm64/arm/cortex-a55/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a55/pipeline.json <- pmu=
-events/arch/arm64/arm/cortex-a55/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a55/instruction.json <- =
pmu-events/arch/arm64/arm/cortex-a55/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a34/memory.json <- pmu-e=
vents/arch/arm64/arm/cortex-a34/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a34/branch.json <- pmu-e=
vents/arch/arm64/arm/cortex-a34/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a34/cache.json <- pmu-ev=
ents/arch/arm64/arm/cortex-a34/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a34/exception.json <- pm=
u-events/arch/arm64/arm/cortex-a34/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a34/bus.json <- pmu-even=
ts/arch/arm64/arm/cortex-a34/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a34/instruction.json <- =
pmu-events/arch/arm64/arm/cortex-a34/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a75/mmu.json <- pmu-even=
ts/arch/arm64/arm/cortex-a75/mmu.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a75/memory.json <- pmu-e=
vents/arch/arm64/arm/cortex-a75/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a75/etm.json <- pmu-even=
ts/arch/arm64/arm/cortex-a75/etm.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a75/branch.json <- pmu-e=
vents/arch/arm64/arm/cortex-a75/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a75/cache.json <- pmu-ev=
ents/arch/arm64/arm/cortex-a75/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a75/exception.json <- pm=
u-events/arch/arm64/arm/cortex-a75/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a75/bus.json <- pmu-even=
ts/arch/arm64/arm/cortex-a75/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a75/pipeline.json <- pmu=
-events/arch/arm64/arm/cortex-a75/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a75/instruction.json <- =
pmu-events/arch/arm64/arm/cortex-a75/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a57-a72/memory.json <- p=
mu-events/arch/arm64/arm/cortex-a57-a72/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a57-a72/branch.json <- p=
mu-events/arch/arm64/arm/cortex-a57-a72/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a57-a72/cache.json <- pm=
u-events/arch/arm64/arm/cortex-a57-a72/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a57-a72/exception.json <=
- pmu-events/arch/arm64/arm/cortex-a57-a72/exception.json dependency droppe=
d.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a57-a72/bus.json <- pmu-=
events/arch/arm64/arm/cortex-a57-a72/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a57-a72/instruction.json=
 <- pmu-events/arch/arm64/arm/cortex-a57-a72/instruction.json dependency dr=
opped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a73/mmu.json <- pmu-even=
ts/arch/arm64/arm/cortex-a73/mmu.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a73/memory.json <- pmu-e=
vents/arch/arm64/arm/cortex-a73/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a73/etm.json <- pmu-even=
ts/arch/arm64/arm/cortex-a73/etm.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a73/branch.json <- pmu-e=
vents/arch/arm64/arm/cortex-a73/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a73/cache.json <- pmu-ev=
ents/arch/arm64/arm/cortex-a73/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a73/exception.json <- pm=
u-events/arch/arm64/arm/cortex-a73/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a73/bus.json <- pmu-even=
ts/arch/arm64/arm/cortex-a73/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a73/pipeline.json <- pmu=
-events/arch/arm64/arm/cortex-a73/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a73/instruction.json <- =
pmu-events/arch/arm64/arm/cortex-a73/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a53/memory.json <- pmu-e=
vents/arch/arm64/arm/cortex-a53/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a53/branch.json <- pmu-e=
vents/arch/arm64/arm/cortex-a53/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a53/cache.json <- pmu-ev=
ents/arch/arm64/arm/cortex-a53/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a53/other.json <- pmu-ev=
ents/arch/arm64/arm/cortex-a53/other.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a53/bus.json <- pmu-even=
ts/arch/arm64/arm/cortex-a53/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a53/pipeline.json <- pmu=
-events/arch/arm64/arm/cortex-a53/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-x1/memory.json <- pmu-ev=
ents/arch/arm64/arm/cortex-x1/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-x1/branch.json <- pmu-ev=
ents/arch/arm64/arm/cortex-x1/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-x1/cache.json <- pmu-eve=
nts/arch/arm64/arm/cortex-x1/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-x1/exception.json <- pmu=
-events/arch/arm64/arm/cortex-x1/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-x1/bus.json <- pmu-event=
s/arch/arm64/arm/cortex-x1/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-x1/pipeline.json <- pmu-=
events/arch/arm64/arm/cortex-x1/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-x1/instruction.json <- p=
mu-events/arch/arm64/arm/cortex-x1/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a77/memory.json <- pmu-e=
vents/arch/arm64/arm/cortex-a77/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a77/branch.json <- pmu-e=
vents/arch/arm64/arm/cortex-a77/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a77/cache.json <- pmu-ev=
ents/arch/arm64/arm/cortex-a77/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a77/exception.json <- pm=
u-events/arch/arm64/arm/cortex-a77/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a77/bus.json <- pmu-even=
ts/arch/arm64/arm/cortex-a77/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a77/pipeline.json <- pmu=
-events/arch/arm64/arm/cortex-a77/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a77/instruction.json <- =
pmu-events/arch/arm64/arm/cortex-a77/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json <- =
pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/general.json <- =
pmu-events/arch/arm64/arm/neoverse-n2-v2/general.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/trace.json <- pm=
u-events/arch/arm64/arm/neoverse-n2-v2/trace.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/sve.json <- pmu-=
events/arch/arm64/arm/neoverse-n2-v2/sve.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/l1i_cache.json <=
- pmu-events/arch/arm64/arm/neoverse-n2-v2/l1i_cache.json dependency droppe=
d.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/fp_operation.jso=
n <- pmu-events/arch/arm64/arm/neoverse-n2-v2/fp_operation.json dependency =
dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/spe.json <- pmu-=
events/arch/arm64/arm/neoverse-n2-v2/spe.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/spec_operation.j=
son <- pmu-events/arch/arm64/arm/neoverse-n2-v2/spec_operation.json depende=
ncy dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/memory.json <- p=
mu-events/arch/arm64/arm/neoverse-n2-v2/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/l3_cache.json <-=
 pmu-events/arch/arm64/arm/neoverse-n2-v2/l3_cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/stall.json <- pm=
u-events/arch/arm64/arm/neoverse-n2-v2/stall.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/exception.json <=
- pmu-events/arch/arm64/arm/neoverse-n2-v2/exception.json dependency droppe=
d.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/ll_cache.json <-=
 pmu-events/arch/arm64/arm/neoverse-n2-v2/ll_cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/l2_cache.json <-=
 pmu-events/arch/arm64/arm/neoverse-n2-v2/l2_cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/bus.json <- pmu-=
events/arch/arm64/arm/neoverse-n2-v2/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/l1d_cache.json <=
- pmu-events/arch/arm64/arm/neoverse-n2-v2/l1d_cache.json dependency droppe=
d.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/retired.json <- =
pmu-events/arch/arm64/arm/neoverse-n2-v2/retired.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/neoverse-n2-v2/tlb.json <- pmu-=
events/arch/arm64/arm/neoverse-n2-v2/tlb.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a76/memory.json <- pmu-e=
vents/arch/arm64/arm/cortex-a76/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a76/branch.json <- pmu-e=
vents/arch/arm64/arm/cortex-a76/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a76/cache.json <- pmu-ev=
ents/arch/arm64/arm/cortex-a76/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a76/exception.json <- pm=
u-events/arch/arm64/arm/cortex-a76/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a76/bus.json <- pmu-even=
ts/arch/arm64/arm/cortex-a76/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a76/pipeline.json <- pmu=
-events/arch/arm64/arm/cortex-a76/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a76/instruction.json <- =
pmu-events/arch/arm64/arm/cortex-a76/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a65-e1/ifu.json <- pmu-e=
vents/arch/arm64/arm/cortex-a65-e1/ifu.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a65-e1/memory.json <- pm=
u-events/arch/arm64/arm/cortex-a65-e1/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a65-e1/branch.json <- pm=
u-events/arch/arm64/arm/cortex-a65-e1/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a65-e1/dpu.json <- pmu-e=
vents/arch/arm64/arm/cortex-a65-e1/dpu.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a65-e1/cache.json <- pmu=
-events/arch/arm64/arm/cortex-a65-e1/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a65-e1/exception.json <-=
 pmu-events/arch/arm64/arm/cortex-a65-e1/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a65-e1/bus.json <- pmu-e=
vents/arch/arm64/arm/cortex-a65-e1/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a65-e1/pipeline.json <- =
pmu-events/arch/arm64/arm/cortex-a65-e1/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/arm/cortex-a65-e1/instruction.json =
<- pmu-events/arch/arm64/arm/cortex-a65-e1/instruction.json dependency drop=
ped.
make[3]: Circular pmu-events/arch/arm64/recommended.json <- pmu-events/arch=
/arm64/recommended.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/mapfile.csv <- pmu-events/arch/arm6=
4/mapfile.csv dependency dropped.
make[3]: Circular pmu-events/arch/arm64/sbsa.json <- pmu-events/arch/arm64/=
sbsa.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereone/metrics.json <- pm=
u-events/arch/arm64/ampere/ampereone/metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereone/intrinsic.json <- =
pmu-events/arch/arm64/ampere/ampereone/intrinsic.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereone/spe.json <- pmu-ev=
ents/arch/arm64/ampere/ampereone/spe.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereone/memory.json <- pmu=
-events/arch/arm64/ampere/ampereone/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereone/branch.json <- pmu=
-events/arch/arm64/ampere/ampereone/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereone/core-imp-def.json =
<- pmu-events/arch/arm64/ampere/ampereone/core-imp-def.json dependency drop=
ped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereone/cache.json <- pmu-=
events/arch/arm64/ampere/ampereone/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereone/exception.json <- =
pmu-events/arch/arm64/ampere/ampereone/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereone/bus.json <- pmu-ev=
ents/arch/arm64/ampere/ampereone/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereone/pipeline.json <- p=
mu-events/arch/arm64/ampere/ampereone/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereone/instruction.json <=
- pmu-events/arch/arm64/ampere/ampereone/instruction.json dependency droppe=
d.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereonex/metrics.json <- p=
mu-events/arch/arm64/ampere/ampereonex/metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereonex/mmu.json <- pmu-e=
vents/arch/arm64/ampere/ampereonex/mmu.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereonex/intrinsic.json <-=
 pmu-events/arch/arm64/ampere/ampereonex/intrinsic.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereonex/spe.json <- pmu-e=
vents/arch/arm64/ampere/ampereonex/spe.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereonex/memory.json <- pm=
u-events/arch/arm64/ampere/ampereonex/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereonex/branch.json <- pm=
u-events/arch/arm64/ampere/ampereonex/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereonex/core-imp-def.json=
 <- pmu-events/arch/arm64/ampere/ampereonex/core-imp-def.json dependency dr=
opped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereonex/cache.json <- pmu=
-events/arch/arm64/ampere/ampereonex/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereonex/exception.json <-=
 pmu-events/arch/arm64/ampere/ampereonex/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereonex/bus.json <- pmu-e=
vents/arch/arm64/ampere/ampereonex/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereonex/pipeline.json <- =
pmu-events/arch/arm64/ampere/ampereonex/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/ampereonex/instruction.json =
<- pmu-events/arch/arm64/ampere/ampereonex/instruction.json dependency drop=
ped.
make[3]: Circular pmu-events/arch/arm64/ampere/emag/clock.json <- pmu-event=
s/arch/arm64/ampere/emag/clock.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/emag/intrinsic.json <- pmu-e=
vents/arch/arm64/ampere/emag/intrinsic.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/emag/memory.json <- pmu-even=
ts/arch/arm64/ampere/emag/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/emag/branch.json <- pmu-even=
ts/arch/arm64/ampere/emag/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/emag/cache.json <- pmu-event=
s/arch/arm64/ampere/emag/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/emag/exception.json <- pmu-e=
vents/arch/arm64/ampere/emag/exception.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/emag/bus.json <- pmu-events/=
arch/arm64/ampere/emag/bus.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/emag/pipeline.json <- pmu-ev=
ents/arch/arm64/ampere/emag/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/arm64/ampere/emag/instruction.json <- pmu=
-events/arch/arm64/ampere/emag/instruction.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z196/basic.json <- pmu-events/arc=
h/s390/cf_z196/basic.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z196/extended.json <- pmu-events/=
arch/s390/cf_z196/extended.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z196/crypto.json <- pmu-events/ar=
ch/s390/cf_z196/crypto.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_zec12/basic.json <- pmu-events/ar=
ch/s390/cf_zec12/basic.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_zec12/extended.json <- pmu-events=
/arch/s390/cf_zec12/extended.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_zec12/crypto.json <- pmu-events/a=
rch/s390/cf_zec12/crypto.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_zec12/transaction.json <- pmu-eve=
nts/arch/s390/cf_zec12/transaction.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z10/basic.json <- pmu-events/arch=
/s390/cf_z10/basic.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z10/extended.json <- pmu-events/a=
rch/s390/cf_z10/extended.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z10/crypto.json <- pmu-events/arc=
h/s390/cf_z10/crypto.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z15/basic.json <- pmu-events/arch=
/s390/cf_z15/basic.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z15/crypto6.json <- pmu-events/ar=
ch/s390/cf_z15/crypto6.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z15/extended.json <- pmu-events/a=
rch/s390/cf_z15/extended.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z15/transaction.json <- pmu-event=
s/arch/s390/cf_z15/transaction.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/mapfile.csv <- pmu-events/arch/s390/=
mapfile.csv dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z14/basic.json <- pmu-events/arch=
/s390/cf_z14/basic.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z14/extended.json <- pmu-events/a=
rch/s390/cf_z14/extended.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z14/crypto.json <- pmu-events/arc=
h/s390/cf_z14/crypto.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z14/transaction.json <- pmu-event=
s/arch/s390/cf_z14/transaction.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z16/basic.json <- pmu-events/arch=
/s390/cf_z16/basic.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z16/crypto6.json <- pmu-events/ar=
ch/s390/cf_z16/crypto6.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z16/extended.json <- pmu-events/a=
rch/s390/cf_z16/extended.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z16/transaction.json <- pmu-event=
s/arch/s390/cf_z16/transaction.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z16/pai_crypto.json <- pmu-events=
/arch/s390/cf_z16/pai_crypto.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z16/pai_ext.json <- pmu-events/ar=
ch/s390/cf_z16/pai_ext.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z13/basic.json <- pmu-events/arch=
/s390/cf_z13/basic.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z13/extended.json <- pmu-events/a=
rch/s390/cf_z13/extended.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z13/crypto.json <- pmu-events/arc=
h/s390/cf_z13/crypto.json dependency dropped.
make[3]: Circular pmu-events/arch/s390/cf_z13/transaction.json <- pmu-event=
s/arch/s390/cf_z13/transaction.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power10/pmc.json <- pmu-events/ar=
ch/powerpc/power10/pmc.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power10/frontend.json <- pmu-even=
ts/arch/powerpc/power10/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power10/metrics.json <- pmu-event=
s/arch/powerpc/power10/metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power10/nest_metrics.json <- pmu-=
events/arch/powerpc/power10/nest_metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power10/others.json <- pmu-events=
/arch/powerpc/power10/others.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power10/datasource.json <- pmu-ev=
ents/arch/powerpc/power10/datasource.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power10/translation.json <- pmu-e=
vents/arch/powerpc/power10/translation.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power10/memory.json <- pmu-events=
/arch/powerpc/power10/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power10/marked.json <- pmu-events=
/arch/powerpc/power10/marked.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power10/floating_point.json <- pm=
u-events/arch/powerpc/power10/floating_point.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power10/cache.json <- pmu-events/=
arch/powerpc/power10/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power10/locks.json <- pmu-events/=
arch/powerpc/power10/locks.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power10/pipeline.json <- pmu-even=
ts/arch/powerpc/power10/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power8/pmc.json <- pmu-events/arc=
h/powerpc/power8/pmc.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power8/frontend.json <- pmu-event=
s/arch/powerpc/power8/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power8/metrics.json <- pmu-events=
/arch/powerpc/power8/metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power8/floating-point.json <- pmu=
-events/arch/powerpc/power8/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power8/translation.json <- pmu-ev=
ents/arch/powerpc/power8/translation.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power8/memory.json <- pmu-events/=
arch/powerpc/power8/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power8/marked.json <- pmu-events/=
arch/powerpc/power8/marked.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power8/cache.json <- pmu-events/a=
rch/powerpc/power8/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power8/other.json <- pmu-events/a=
rch/powerpc/power8/other.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power8/pipeline.json <- pmu-event=
s/arch/powerpc/power8/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/mapfile.csv <- pmu-events/arch/po=
werpc/mapfile.csv dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power9/pmc.json <- pmu-events/arc=
h/powerpc/power9/pmc.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power9/frontend.json <- pmu-event=
s/arch/powerpc/power9/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power9/metrics.json <- pmu-events=
/arch/powerpc/power9/metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power9/nest_metrics.json <- pmu-e=
vents/arch/powerpc/power9/nest_metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power9/floating-point.json <- pmu=
-events/arch/powerpc/power9/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power9/translation.json <- pmu-ev=
ents/arch/powerpc/power9/translation.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power9/memory.json <- pmu-events/=
arch/powerpc/power9/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power9/marked.json <- pmu-events/=
arch/powerpc/power9/marked.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power9/cache.json <- pmu-events/a=
rch/powerpc/power9/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power9/other.json <- pmu-events/a=
rch/powerpc/power9/other.json dependency dropped.
make[3]: Circular pmu-events/arch/powerpc/power9/pipeline.json <- pmu-event=
s/arch/powerpc/power9/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/silvermont/frontend.json <- pmu-event=
s/arch/x86/silvermont/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/silvermont/floating-point.json <- pmu=
-events/arch/x86/silvermont/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/silvermont/counter.json <- pmu-events=
/arch/x86/silvermont/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/silvermont/memory.json <- pmu-events/=
arch/x86/silvermont/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/silvermont/cache.json <- pmu-events/a=
rch/x86/silvermont/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/silvermont/other.json <- pmu-events/a=
rch/x86/silvermont/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/silvermont/virtual-memory.json <- pmu=
-events/arch/x86/silvermont/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/silvermont/pipeline.json <- pmu-event=
s/arch/x86/silvermont/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/elkhartlake/frontend.json <- pmu-even=
ts/arch/x86/elkhartlake/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/elkhartlake/floating-point.json <- pm=
u-events/arch/x86/elkhartlake/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/elkhartlake/ehl-metrics.json <- pmu-e=
vents/arch/x86/elkhartlake/ehl-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/elkhartlake/counter.json <- pmu-event=
s/arch/x86/elkhartlake/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/elkhartlake/memory.json <- pmu-events=
/arch/x86/elkhartlake/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/elkhartlake/cache.json <- pmu-events/=
arch/x86/elkhartlake/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/elkhartlake/other.json <- pmu-events/=
arch/x86/elkhartlake/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/elkhartlake/virtual-memory.json <- pm=
u-events/arch/x86/elkhartlake/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/elkhartlake/pipeline.json <- pmu-even=
ts/arch/x86/elkhartlake/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sandybridge/frontend.json <- pmu-even=
ts/arch/x86/sandybridge/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sandybridge/floating-point.json <- pm=
u-events/arch/x86/sandybridge/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sandybridge/snb-metrics.json <- pmu-e=
vents/arch/x86/sandybridge/snb-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sandybridge/metricgroups.json <- pmu-=
events/arch/x86/sandybridge/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sandybridge/uncore-interconnect.json =
<- pmu-events/arch/x86/sandybridge/uncore-interconnect.json dependency drop=
ped.
make[3]: Circular pmu-events/arch/x86/sandybridge/counter.json <- pmu-event=
s/arch/x86/sandybridge/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sandybridge/memory.json <- pmu-events=
/arch/x86/sandybridge/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sandybridge/cache.json <- pmu-events/=
arch/x86/sandybridge/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sandybridge/other.json <- pmu-events/=
arch/x86/sandybridge/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sandybridge/virtual-memory.json <- pm=
u-events/arch/x86/sandybridge/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sandybridge/uncore-cache.json <- pmu-=
events/arch/x86/sandybridge/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sandybridge/pipeline.json <- pmu-even=
ts/arch/x86/sandybridge/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereep-sp/frontend.json <- pmu-ev=
ents/arch/x86/westmereep-sp/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereep-sp/floating-point.json <- =
pmu-events/arch/x86/westmereep-sp/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereep-sp/counter.json <- pmu-eve=
nts/arch/x86/westmereep-sp/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereep-sp/memory.json <- pmu-even=
ts/arch/x86/westmereep-sp/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereep-sp/cache.json <- pmu-event=
s/arch/x86/westmereep-sp/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereep-sp/other.json <- pmu-event=
s/arch/x86/westmereep-sp/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereep-sp/virtual-memory.json <- =
pmu-events/arch/x86/westmereep-sp/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereep-sp/pipeline.json <- pmu-ev=
ents/arch/x86/westmereep-sp/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelakex/frontend.json <- pmu-events/=
arch/x86/icelakex/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelakex/floating-point.json <- pmu-e=
vents/arch/x86/icelakex/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelakex/uncore-memory.json <- pmu-ev=
ents/arch/x86/icelakex/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelakex/uncore-io.json <- pmu-events=
/arch/x86/icelakex/uncore-io.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelakex/metricgroups.json <- pmu-eve=
nts/arch/x86/icelakex/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelakex/uncore-interconnect.json <- =
pmu-events/arch/x86/icelakex/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelakex/counter.json <- pmu-events/a=
rch/x86/icelakex/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelakex/memory.json <- pmu-events/ar=
ch/x86/icelakex/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelakex/cache.json <- pmu-events/arc=
h/x86/icelakex/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelakex/uncore-power.json <- pmu-eve=
nts/arch/x86/icelakex/uncore-power.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelakex/other.json <- pmu-events/arc=
h/x86/icelakex/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelakex/virtual-memory.json <- pmu-e=
vents/arch/x86/icelakex/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelakex/uncore-cache.json <- pmu-eve=
nts/arch/x86/icelakex/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelakex/pipeline.json <- pmu-events/=
arch/x86/icelakex/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelakex/icx-metrics.json <- pmu-even=
ts/arch/x86/icelakex/icx-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/tigerlake/frontend.json <- pmu-events=
/arch/x86/tigerlake/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/tigerlake/floating-point.json <- pmu-=
events/arch/x86/tigerlake/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/tigerlake/uncore-memory.json <- pmu-e=
vents/arch/x86/tigerlake/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/tigerlake/metricgroups.json <- pmu-ev=
ents/arch/x86/tigerlake/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/tigerlake/uncore-interconnect.json <-=
 pmu-events/arch/x86/tigerlake/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/tigerlake/counter.json <- pmu-events/=
arch/x86/tigerlake/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/tigerlake/tgl-metrics.json <- pmu-eve=
nts/arch/x86/tigerlake/tgl-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/tigerlake/memory.json <- pmu-events/a=
rch/x86/tigerlake/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/tigerlake/cache.json <- pmu-events/ar=
ch/x86/tigerlake/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/tigerlake/other.json <- pmu-events/ar=
ch/x86/tigerlake/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/tigerlake/uncore-other.json <- pmu-ev=
ents/arch/x86/tigerlake/uncore-other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/tigerlake/virtual-memory.json <- pmu-=
events/arch/x86/tigerlake/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/tigerlake/pipeline.json <- pmu-events=
/arch/x86/tigerlake/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/graniterapids/uncore-cxl.json <- pmu-=
events/arch/x86/graniterapids/uncore-cxl.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/graniterapids/frontend.json <- pmu-ev=
ents/arch/x86/graniterapids/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/graniterapids/floating-point.json <- =
pmu-events/arch/x86/graniterapids/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/graniterapids/uncore-memory.json <- p=
mu-events/arch/x86/graniterapids/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/graniterapids/uncore-io.json <- pmu-e=
vents/arch/x86/graniterapids/uncore-io.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/graniterapids/uncore-interconnect.jso=
n <- pmu-events/arch/x86/graniterapids/uncore-interconnect.json dependency =
dropped.
make[3]: Circular pmu-events/arch/x86/graniterapids/counter.json <- pmu-eve=
nts/arch/x86/graniterapids/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/graniterapids/memory.json <- pmu-even=
ts/arch/x86/graniterapids/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/graniterapids/cache.json <- pmu-event=
s/arch/x86/graniterapids/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/graniterapids/uncore-power.json <- pm=
u-events/arch/x86/graniterapids/uncore-power.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/graniterapids/other.json <- pmu-event=
s/arch/x86/graniterapids/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/graniterapids/virtual-memory.json <- =
pmu-events/arch/x86/graniterapids/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/graniterapids/uncore-cache.json <- pm=
u-events/arch/x86/graniterapids/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/graniterapids/pipeline.json <- pmu-ev=
ents/arch/x86/graniterapids/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/nehalemex/frontend.json <- pmu-events=
/arch/x86/nehalemex/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/nehalemex/floating-point.json <- pmu-=
events/arch/x86/nehalemex/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/nehalemex/counter.json <- pmu-events/=
arch/x86/nehalemex/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/nehalemex/memory.json <- pmu-events/a=
rch/x86/nehalemex/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/nehalemex/cache.json <- pmu-events/ar=
ch/x86/nehalemex/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/nehalemex/other.json <- pmu-events/ar=
ch/x86/nehalemex/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/nehalemex/virtual-memory.json <- pmu-=
events/arch/x86/nehalemex/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/nehalemex/pipeline.json <- pmu-events=
/arch/x86/nehalemex/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen1/floating-point.json <- pmu-ev=
ents/arch/x86/amdzen1/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen1/data-fabric.json <- pmu-event=
s/arch/x86/amdzen1/data-fabric.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen1/memory.json <- pmu-events/arc=
h/x86/amdzen1/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen1/branch.json <- pmu-events/arc=
h/x86/amdzen1/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen1/cache.json <- pmu-events/arch=
/x86/amdzen1/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen1/core.json <- pmu-events/arch/=
x86/amdzen1/core.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen1/recommended.json <- pmu-event=
s/arch/x86/amdzen1/recommended.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen1/other.json <- pmu-events/arch=
/x86/amdzen1/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellde/frontend.json <- pmu-even=
ts/arch/x86/broadwellde/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellde/floating-point.json <- pm=
u-events/arch/x86/broadwellde/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellde/uncore-memory.json <- pmu=
-events/arch/x86/broadwellde/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellde/uncore-io.json <- pmu-eve=
nts/arch/x86/broadwellde/uncore-io.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellde/metricgroups.json <- pmu-=
events/arch/x86/broadwellde/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellde/uncore-interconnect.json =
<- pmu-events/arch/x86/broadwellde/uncore-interconnect.json dependency drop=
ped.
make[3]: Circular pmu-events/arch/x86/broadwellde/counter.json <- pmu-event=
s/arch/x86/broadwellde/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellde/memory.json <- pmu-events=
/arch/x86/broadwellde/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellde/cache.json <- pmu-events/=
arch/x86/broadwellde/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellde/bdwde-metrics.json <- pmu=
-events/arch/x86/broadwellde/bdwde-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellde/uncore-power.json <- pmu-=
events/arch/x86/broadwellde/uncore-power.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellde/other.json <- pmu-events/=
arch/x86/broadwellde/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellde/virtual-memory.json <- pm=
u-events/arch/x86/broadwellde/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellde/uncore-cache.json <- pmu-=
events/arch/x86/broadwellde/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellde/pipeline.json <- pmu-even=
ts/arch/x86/broadwellde/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereep-dp/frontend.json <- pmu-ev=
ents/arch/x86/westmereep-dp/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereep-dp/floating-point.json <- =
pmu-events/arch/x86/westmereep-dp/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereep-dp/counter.json <- pmu-eve=
nts/arch/x86/westmereep-dp/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereep-dp/memory.json <- pmu-even=
ts/arch/x86/westmereep-dp/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereep-dp/cache.json <- pmu-event=
s/arch/x86/westmereep-dp/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereep-dp/other.json <- pmu-event=
s/arch/x86/westmereep-dp/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereep-dp/virtual-memory.json <- =
pmu-events/arch/x86/westmereep-dp/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereep-dp/pipeline.json <- pmu-ev=
ents/arch/x86/westmereep-dp/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlaken/frontend.json <- pmu-event=
s/arch/x86/alderlaken/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlaken/floating-point.json <- pmu=
-events/arch/x86/alderlaken/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlaken/adln-metrics.json <- pmu-e=
vents/arch/x86/alderlaken/adln-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlaken/uncore-memory.json <- pmu-=
events/arch/x86/alderlaken/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlaken/metricgroups.json <- pmu-e=
vents/arch/x86/alderlaken/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlaken/uncore-interconnect.json <=
- pmu-events/arch/x86/alderlaken/uncore-interconnect.json dependency droppe=
d.
make[3]: Circular pmu-events/arch/x86/alderlaken/memory.json <- pmu-events/=
arch/x86/alderlaken/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlaken/cache.json <- pmu-events/a=
rch/x86/alderlaken/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlaken/other.json <- pmu-events/a=
rch/x86/alderlaken/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlaken/uncore-other.json <- pmu-e=
vents/arch/x86/alderlaken/uncore-other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlaken/virtual-memory.json <- pmu=
-events/arch/x86/alderlaken/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlaken/pipeline.json <- pmu-event=
s/arch/x86/alderlaken/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/rocketlake/frontend.json <- pmu-event=
s/arch/x86/rocketlake/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/rocketlake/rkl-metrics.json <- pmu-ev=
ents/arch/x86/rocketlake/rkl-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/rocketlake/floating-point.json <- pmu=
-events/arch/x86/rocketlake/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/rocketlake/metricgroups.json <- pmu-e=
vents/arch/x86/rocketlake/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/rocketlake/uncore-interconnect.json <=
- pmu-events/arch/x86/rocketlake/uncore-interconnect.json dependency droppe=
d.
make[3]: Circular pmu-events/arch/x86/rocketlake/counter.json <- pmu-events=
/arch/x86/rocketlake/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/rocketlake/memory.json <- pmu-events/=
arch/x86/rocketlake/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/rocketlake/cache.json <- pmu-events/a=
rch/x86/rocketlake/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/rocketlake/other.json <- pmu-events/a=
rch/x86/rocketlake/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/rocketlake/uncore-other.json <- pmu-e=
vents/arch/x86/rocketlake/uncore-other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/rocketlake/virtual-memory.json <- pmu=
-events/arch/x86/rocketlake/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/rocketlake/pipeline.json <- pmu-event=
s/arch/x86/rocketlake/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/jaketown/frontend.json <- pmu-events/=
arch/x86/jaketown/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/jaketown/floating-point.json <- pmu-e=
vents/arch/x86/jaketown/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/jaketown/uncore-memory.json <- pmu-ev=
ents/arch/x86/jaketown/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/jaketown/uncore-io.json <- pmu-events=
/arch/x86/jaketown/uncore-io.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/jaketown/jkt-metrics.json <- pmu-even=
ts/arch/x86/jaketown/jkt-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/jaketown/metricgroups.json <- pmu-eve=
nts/arch/x86/jaketown/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/jaketown/uncore-interconnect.json <- =
pmu-events/arch/x86/jaketown/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/jaketown/counter.json <- pmu-events/a=
rch/x86/jaketown/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/jaketown/memory.json <- pmu-events/ar=
ch/x86/jaketown/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/jaketown/cache.json <- pmu-events/arc=
h/x86/jaketown/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/jaketown/uncore-power.json <- pmu-eve=
nts/arch/x86/jaketown/uncore-power.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/jaketown/other.json <- pmu-events/arc=
h/x86/jaketown/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/jaketown/virtual-memory.json <- pmu-e=
vents/arch/x86/jaketown/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/jaketown/uncore-cache.json <- pmu-eve=
nts/arch/x86/jaketown/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/jaketown/pipeline.json <- pmu-events/=
arch/x86/jaketown/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellx/frontend.json <- pmu-event=
s/arch/x86/broadwellx/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellx/floating-point.json <- pmu=
-events/arch/x86/broadwellx/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellx/uncore-memory.json <- pmu-=
events/arch/x86/broadwellx/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellx/uncore-io.json <- pmu-even=
ts/arch/x86/broadwellx/uncore-io.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellx/metricgroups.json <- pmu-e=
vents/arch/x86/broadwellx/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellx/uncore-interconnect.json <=
- pmu-events/arch/x86/broadwellx/uncore-interconnect.json dependency droppe=
d.
make[3]: Circular pmu-events/arch/x86/broadwellx/counter.json <- pmu-events=
/arch/x86/broadwellx/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellx/memory.json <- pmu-events/=
arch/x86/broadwellx/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellx/cache.json <- pmu-events/a=
rch/x86/broadwellx/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellx/uncore-power.json <- pmu-e=
vents/arch/x86/broadwellx/uncore-power.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellx/bdx-metrics.json <- pmu-ev=
ents/arch/x86/broadwellx/bdx-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellx/other.json <- pmu-events/a=
rch/x86/broadwellx/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellx/virtual-memory.json <- pmu=
-events/arch/x86/broadwellx/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellx/uncore-cache.json <- pmu-e=
vents/arch/x86/broadwellx/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwellx/pipeline.json <- pmu-event=
s/arch/x86/broadwellx/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/goldmont/frontend.json <- pmu-events/=
arch/x86/goldmont/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/goldmont/floating-point.json <- pmu-e=
vents/arch/x86/goldmont/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/goldmont/counter.json <- pmu-events/a=
rch/x86/goldmont/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/goldmont/memory.json <- pmu-events/ar=
ch/x86/goldmont/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/goldmont/cache.json <- pmu-events/arc=
h/x86/goldmont/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/goldmont/other.json <- pmu-events/arc=
h/x86/goldmont/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/goldmont/virtual-memory.json <- pmu-e=
vents/arch/x86/goldmont/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/goldmont/pipeline.json <- pmu-events/=
arch/x86/goldmont/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivybridge/frontend.json <- pmu-events=
/arch/x86/ivybridge/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivybridge/floating-point.json <- pmu-=
events/arch/x86/ivybridge/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivybridge/metricgroups.json <- pmu-ev=
ents/arch/x86/ivybridge/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivybridge/uncore-interconnect.json <-=
 pmu-events/arch/x86/ivybridge/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivybridge/counter.json <- pmu-events/=
arch/x86/ivybridge/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivybridge/memory.json <- pmu-events/a=
rch/x86/ivybridge/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivybridge/cache.json <- pmu-events/ar=
ch/x86/ivybridge/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivybridge/other.json <- pmu-events/ar=
ch/x86/ivybridge/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivybridge/virtual-memory.json <- pmu-=
events/arch/x86/ivybridge/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivybridge/uncore-cache.json <- pmu-ev=
ents/arch/x86/ivybridge/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivybridge/pipeline.json <- pmu-events=
/arch/x86/ivybridge/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivybridge/ivb-metrics.json <- pmu-eve=
nts/arch/x86/ivybridge/ivb-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/snowridgex/frontend.json <- pmu-event=
s/arch/x86/snowridgex/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/snowridgex/floating-point.json <- pmu=
-events/arch/x86/snowridgex/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/snowridgex/uncore-memory.json <- pmu-=
events/arch/x86/snowridgex/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/snowridgex/uncore-io.json <- pmu-even=
ts/arch/x86/snowridgex/uncore-io.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/snowridgex/uncore-interconnect.json <=
- pmu-events/arch/x86/snowridgex/uncore-interconnect.json dependency droppe=
d.
make[3]: Circular pmu-events/arch/x86/snowridgex/counter.json <- pmu-events=
/arch/x86/snowridgex/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/snowridgex/memory.json <- pmu-events/=
arch/x86/snowridgex/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/snowridgex/cache.json <- pmu-events/a=
rch/x86/snowridgex/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/snowridgex/uncore-power.json <- pmu-e=
vents/arch/x86/snowridgex/uncore-power.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/snowridgex/other.json <- pmu-events/a=
rch/x86/snowridgex/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/snowridgex/virtual-memory.json <- pmu=
-events/arch/x86/snowridgex/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/snowridgex/uncore-cache.json <- pmu-e=
vents/arch/x86/snowridgex/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/snowridgex/pipeline.json <- pmu-event=
s/arch/x86/snowridgex/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswellx/frontend.json <- pmu-events/=
arch/x86/haswellx/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswellx/floating-point.json <- pmu-e=
vents/arch/x86/haswellx/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswellx/uncore-memory.json <- pmu-ev=
ents/arch/x86/haswellx/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswellx/uncore-io.json <- pmu-events=
/arch/x86/haswellx/uncore-io.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswellx/metricgroups.json <- pmu-eve=
nts/arch/x86/haswellx/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswellx/uncore-interconnect.json <- =
pmu-events/arch/x86/haswellx/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswellx/counter.json <- pmu-events/a=
rch/x86/haswellx/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswellx/memory.json <- pmu-events/ar=
ch/x86/haswellx/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswellx/hsx-metrics.json <- pmu-even=
ts/arch/x86/haswellx/hsx-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswellx/cache.json <- pmu-events/arc=
h/x86/haswellx/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswellx/uncore-power.json <- pmu-eve=
nts/arch/x86/haswellx/uncore-power.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswellx/other.json <- pmu-events/arc=
h/x86/haswellx/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswellx/virtual-memory.json <- pmu-e=
vents/arch/x86/haswellx/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswellx/uncore-cache.json <- pmu-eve=
nts/arch/x86/haswellx/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswellx/pipeline.json <- pmu-events/=
arch/x86/haswellx/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/bonnell/frontend.json <- pmu-events/a=
rch/x86/bonnell/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/bonnell/floating-point.json <- pmu-ev=
ents/arch/x86/bonnell/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/bonnell/counter.json <- pmu-events/ar=
ch/x86/bonnell/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/bonnell/memory.json <- pmu-events/arc=
h/x86/bonnell/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/bonnell/cache.json <- pmu-events/arch=
/x86/bonnell/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/bonnell/other.json <- pmu-events/arch=
/x86/bonnell/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/bonnell/virtual-memory.json <- pmu-ev=
ents/arch/x86/bonnell/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/bonnell/pipeline.json <- pmu-events/a=
rch/x86/bonnell/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswell/frontend.json <- pmu-events/a=
rch/x86/haswell/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswell/floating-point.json <- pmu-ev=
ents/arch/x86/haswell/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswell/metricgroups.json <- pmu-even=
ts/arch/x86/haswell/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswell/uncore-interconnect.json <- p=
mu-events/arch/x86/haswell/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswell/counter.json <- pmu-events/ar=
ch/x86/haswell/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswell/hsw-metrics.json <- pmu-event=
s/arch/x86/haswell/hsw-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswell/memory.json <- pmu-events/arc=
h/x86/haswell/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswell/cache.json <- pmu-events/arch=
/x86/haswell/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswell/other.json <- pmu-events/arch=
/x86/haswell/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswell/uncore-other.json <- pmu-even=
ts/arch/x86/haswell/uncore-other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswell/virtual-memory.json <- pmu-ev=
ents/arch/x86/haswell/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswell/uncore-cache.json <- pmu-even=
ts/arch/x86/haswell/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/haswell/pipeline.json <- pmu-events/a=
rch/x86/haswell/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwell/frontend.json <- pmu-events=
/arch/x86/broadwell/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwell/floating-point.json <- pmu-=
events/arch/x86/broadwell/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwell/bdw-metrics.json <- pmu-eve=
nts/arch/x86/broadwell/bdw-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwell/metricgroups.json <- pmu-ev=
ents/arch/x86/broadwell/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwell/uncore-interconnect.json <-=
 pmu-events/arch/x86/broadwell/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwell/counter.json <- pmu-events/=
arch/x86/broadwell/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwell/memory.json <- pmu-events/a=
rch/x86/broadwell/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwell/cache.json <- pmu-events/ar=
ch/x86/broadwell/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwell/other.json <- pmu-events/ar=
ch/x86/broadwell/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwell/virtual-memory.json <- pmu-=
events/arch/x86/broadwell/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwell/uncore-cache.json <- pmu-ev=
ents/arch/x86/broadwell/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/broadwell/pipeline.json <- pmu-events=
/arch/x86/broadwell/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/grandridge/frontend.json <- pmu-event=
s/arch/x86/grandridge/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/grandridge/grr-metrics.json <- pmu-ev=
ents/arch/x86/grandridge/grr-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/grandridge/floating-point.json <- pmu=
-events/arch/x86/grandridge/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/grandridge/uncore-memory.json <- pmu-=
events/arch/x86/grandridge/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/grandridge/uncore-io.json <- pmu-even=
ts/arch/x86/grandridge/uncore-io.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/grandridge/metricgroups.json <- pmu-e=
vents/arch/x86/grandridge/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/grandridge/uncore-interconnect.json <=
- pmu-events/arch/x86/grandridge/uncore-interconnect.json dependency droppe=
d.
make[3]: Circular pmu-events/arch/x86/grandridge/counter.json <- pmu-events=
/arch/x86/grandridge/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/grandridge/memory.json <- pmu-events/=
arch/x86/grandridge/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/grandridge/cache.json <- pmu-events/a=
rch/x86/grandridge/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/grandridge/uncore-power.json <- pmu-e=
vents/arch/x86/grandridge/uncore-power.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/grandridge/other.json <- pmu-events/a=
rch/x86/grandridge/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/grandridge/virtual-memory.json <- pmu=
-events/arch/x86/grandridge/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/grandridge/uncore-cache.json <- pmu-e=
vents/arch/x86/grandridge/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/grandridge/pipeline.json <- pmu-event=
s/arch/x86/grandridge/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/lunarlake/frontend.json <- pmu-events=
/arch/x86/lunarlake/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/lunarlake/memory.json <- pmu-events/a=
rch/x86/lunarlake/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/lunarlake/cache.json <- pmu-events/ar=
ch/x86/lunarlake/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/lunarlake/other.json <- pmu-events/ar=
ch/x86/lunarlake/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/lunarlake/virtual-memory.json <- pmu-=
events/arch/x86/lunarlake/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/lunarlake/pipeline.json <- pmu-events=
/arch/x86/lunarlake/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen2/floating-point.json <- pmu-ev=
ents/arch/x86/amdzen2/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen2/data-fabric.json <- pmu-event=
s/arch/x86/amdzen2/data-fabric.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen2/memory.json <- pmu-events/arc=
h/x86/amdzen2/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen2/branch.json <- pmu-events/arc=
h/x86/amdzen2/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen2/cache.json <- pmu-events/arch=
/x86/amdzen2/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen2/core.json <- pmu-events/arch/=
x86/amdzen2/core.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen2/recommended.json <- pmu-event=
s/arch/x86/amdzen2/recommended.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen2/other.json <- pmu-events/arch=
/x86/amdzen2/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlake/frontend.json <- pmu-events=
/arch/x86/alderlake/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlake/floating-point.json <- pmu-=
events/arch/x86/alderlake/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlake/uncore-memory.json <- pmu-e=
vents/arch/x86/alderlake/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlake/metricgroups.json <- pmu-ev=
ents/arch/x86/alderlake/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlake/uncore-interconnect.json <-=
 pmu-events/arch/x86/alderlake/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlake/memory.json <- pmu-events/a=
rch/x86/alderlake/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlake/adl-metrics.json <- pmu-eve=
nts/arch/x86/alderlake/adl-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlake/cache.json <- pmu-events/ar=
ch/x86/alderlake/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlake/other.json <- pmu-events/ar=
ch/x86/alderlake/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlake/uncore-other.json <- pmu-ev=
ents/arch/x86/alderlake/uncore-other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlake/virtual-memory.json <- pmu-=
events/arch/x86/alderlake/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/alderlake/pipeline.json <- pmu-events=
/arch/x86/alderlake/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen4/floating-point.json <- pmu-ev=
ents/arch/x86/amdzen4/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen4/data-fabric.json <- pmu-event=
s/arch/x86/amdzen4/data-fabric.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen4/memory-controller.json <- pmu=
-events/arch/x86/amdzen4/memory-controller.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen4/memory.json <- pmu-events/arc=
h/x86/amdzen4/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen4/branch.json <- pmu-events/arc=
h/x86/amdzen4/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen4/cache.json <- pmu-events/arch=
/x86/amdzen4/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen4/core.json <- pmu-events/arch/=
x86/amdzen4/core.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen4/recommended.json <- pmu-event=
s/arch/x86/amdzen4/recommended.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen4/other.json <- pmu-events/arch=
/x86/amdzen4/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen4/pipeline.json <- pmu-events/a=
rch/x86/amdzen4/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/nehalemep/frontend.json <- pmu-events=
/arch/x86/nehalemep/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/nehalemep/floating-point.json <- pmu-=
events/arch/x86/nehalemep/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/nehalemep/counter.json <- pmu-events/=
arch/x86/nehalemep/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/nehalemep/memory.json <- pmu-events/a=
rch/x86/nehalemep/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/nehalemep/cache.json <- pmu-events/ar=
ch/x86/nehalemep/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/nehalemep/other.json <- pmu-events/ar=
ch/x86/nehalemep/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/nehalemep/virtual-memory.json <- pmu-=
events/arch/x86/nehalemep/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/nehalemep/pipeline.json <- pmu-events=
/arch/x86/nehalemep/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen5/l2-cache.json <- pmu-events/a=
rch/x86/amdzen5/l2-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen5/floating-point.json <- pmu-ev=
ents/arch/x86/amdzen5/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen5/load-store.json <- pmu-events=
/arch/x86/amdzen5/load-store.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen5/branch-prediction.json <- pmu=
-events/arch/x86/amdzen5/branch-prediction.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen5/memory-controller.json <- pmu=
-events/arch/x86/amdzen5/memory-controller.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen5/decode.json <- pmu-events/arc=
h/x86/amdzen5/decode.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen5/recommended.json <- pmu-event=
s/arch/x86/amdzen5/recommended.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen5/execution.json <- pmu-events/=
arch/x86/amdzen5/execution.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen5/l3-cache.json <- pmu-events/a=
rch/x86/amdzen5/l3-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen5/pipeline.json <- pmu-events/a=
rch/x86/amdzen5/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen5/inst-cache.json <- pmu-events=
/arch/x86/amdzen5/inst-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/meteorlake/frontend.json <- pmu-event=
s/arch/x86/meteorlake/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/meteorlake/floating-point.json <- pmu=
-events/arch/x86/meteorlake/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/meteorlake/uncore-memory.json <- pmu-=
events/arch/x86/meteorlake/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/meteorlake/metricgroups.json <- pmu-e=
vents/arch/x86/meteorlake/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/meteorlake/uncore-interconnect.json <=
- pmu-events/arch/x86/meteorlake/uncore-interconnect.json dependency droppe=
d.
make[3]: Circular pmu-events/arch/x86/meteorlake/memory.json <- pmu-events/=
arch/x86/meteorlake/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/meteorlake/cache.json <- pmu-events/a=
rch/x86/meteorlake/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/meteorlake/other.json <- pmu-events/a=
rch/x86/meteorlake/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/meteorlake/uncore-other.json <- pmu-e=
vents/arch/x86/meteorlake/uncore-other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/meteorlake/virtual-memory.json <- pmu=
-events/arch/x86/meteorlake/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/meteorlake/mtl-metrics.json <- pmu-ev=
ents/arch/x86/meteorlake/mtl-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/meteorlake/uncore-cache.json <- pmu-e=
vents/arch/x86/meteorlake/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/meteorlake/pipeline.json <- pmu-event=
s/arch/x86/meteorlake/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylake/frontend.json <- pmu-events/a=
rch/x86/skylake/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylake/floating-point.json <- pmu-ev=
ents/arch/x86/skylake/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylake/metricgroups.json <- pmu-even=
ts/arch/x86/skylake/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylake/uncore-interconnect.json <- p=
mu-events/arch/x86/skylake/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylake/counter.json <- pmu-events/ar=
ch/x86/skylake/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylake/memory.json <- pmu-events/arc=
h/x86/skylake/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylake/skl-metrics.json <- pmu-event=
s/arch/x86/skylake/skl-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylake/cache.json <- pmu-events/arch=
/x86/skylake/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylake/other.json <- pmu-events/arch=
/x86/skylake/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylake/virtual-memory.json <- pmu-ev=
ents/arch/x86/skylake/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylake/uncore-cache.json <- pmu-even=
ts/arch/x86/skylake/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylake/pipeline.json <- pmu-events/a=
rch/x86/skylake/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/knightslanding/frontend.json <- pmu-e=
vents/arch/x86/knightslanding/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/knightslanding/floating-point.json <-=
 pmu-events/arch/x86/knightslanding/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/knightslanding/uncore-memory.json <- =
pmu-events/arch/x86/knightslanding/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/knightslanding/uncore-io.json <- pmu-=
events/arch/x86/knightslanding/uncore-io.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/knightslanding/counter.json <- pmu-ev=
ents/arch/x86/knightslanding/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/knightslanding/memory.json <- pmu-eve=
nts/arch/x86/knightslanding/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/knightslanding/cache.json <- pmu-even=
ts/arch/x86/knightslanding/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/knightslanding/virtual-memory.json <-=
 pmu-events/arch/x86/knightslanding/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/knightslanding/uncore-cache.json <- p=
mu-events/arch/x86/knightslanding/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/knightslanding/pipeline.json <- pmu-e=
vents/arch/x86/knightslanding/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/mapfile.csv <- pmu-events/arch/x86/ma=
pfile.csv dependency dropped.
make[3]: Circular pmu-events/arch/x86/emeraldrapids/uncore-cxl.json <- pmu-=
events/arch/x86/emeraldrapids/uncore-cxl.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/emeraldrapids/emr-metrics.json <- pmu=
-events/arch/x86/emeraldrapids/emr-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/emeraldrapids/frontend.json <- pmu-ev=
ents/arch/x86/emeraldrapids/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/emeraldrapids/floating-point.json <- =
pmu-events/arch/x86/emeraldrapids/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/emeraldrapids/uncore-memory.json <- p=
mu-events/arch/x86/emeraldrapids/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/emeraldrapids/uncore-io.json <- pmu-e=
vents/arch/x86/emeraldrapids/uncore-io.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/emeraldrapids/metricgroups.json <- pm=
u-events/arch/x86/emeraldrapids/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/emeraldrapids/uncore-interconnect.jso=
n <- pmu-events/arch/x86/emeraldrapids/uncore-interconnect.json dependency =
dropped.
make[3]: Circular pmu-events/arch/x86/emeraldrapids/counter.json <- pmu-eve=
nts/arch/x86/emeraldrapids/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/emeraldrapids/memory.json <- pmu-even=
ts/arch/x86/emeraldrapids/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/emeraldrapids/cache.json <- pmu-event=
s/arch/x86/emeraldrapids/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/emeraldrapids/uncore-power.json <- pm=
u-events/arch/x86/emeraldrapids/uncore-power.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/emeraldrapids/other.json <- pmu-event=
s/arch/x86/emeraldrapids/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/emeraldrapids/virtual-memory.json <- =
pmu-events/arch/x86/emeraldrapids/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/emeraldrapids/uncore-cache.json <- pm=
u-events/arch/x86/emeraldrapids/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/emeraldrapids/pipeline.json <- pmu-ev=
ents/arch/x86/emeraldrapids/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/goldmontplus/frontend.json <- pmu-eve=
nts/arch/x86/goldmontplus/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/goldmontplus/floating-point.json <- p=
mu-events/arch/x86/goldmontplus/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/goldmontplus/counter.json <- pmu-even=
ts/arch/x86/goldmontplus/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/goldmontplus/memory.json <- pmu-event=
s/arch/x86/goldmontplus/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/goldmontplus/cache.json <- pmu-events=
/arch/x86/goldmontplus/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/goldmontplus/other.json <- pmu-events=
/arch/x86/goldmontplus/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/goldmontplus/virtual-memory.json <- p=
mu-events/arch/x86/goldmontplus/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/goldmontplus/pipeline.json <- pmu-eve=
nts/arch/x86/goldmontplus/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sierraforest/uncore-cxl.json <- pmu-e=
vents/arch/x86/sierraforest/uncore-cxl.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sierraforest/frontend.json <- pmu-eve=
nts/arch/x86/sierraforest/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sierraforest/floating-point.json <- p=
mu-events/arch/x86/sierraforest/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sierraforest/uncore-memory.json <- pm=
u-events/arch/x86/sierraforest/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sierraforest/uncore-io.json <- pmu-ev=
ents/arch/x86/sierraforest/uncore-io.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sierraforest/srf-metrics.json <- pmu-=
events/arch/x86/sierraforest/srf-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sierraforest/metricgroups.json <- pmu=
-events/arch/x86/sierraforest/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sierraforest/uncore-interconnect.json=
 <- pmu-events/arch/x86/sierraforest/uncore-interconnect.json dependency dr=
opped.
make[3]: Circular pmu-events/arch/x86/sierraforest/counter.json <- pmu-even=
ts/arch/x86/sierraforest/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sierraforest/memory.json <- pmu-event=
s/arch/x86/sierraforest/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sierraforest/cache.json <- pmu-events=
/arch/x86/sierraforest/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sierraforest/uncore-power.json <- pmu=
-events/arch/x86/sierraforest/uncore-power.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sierraforest/other.json <- pmu-events=
/arch/x86/sierraforest/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sierraforest/virtual-memory.json <- p=
mu-events/arch/x86/sierraforest/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sierraforest/uncore-cache.json <- pmu=
-events/arch/x86/sierraforest/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sierraforest/pipeline.json <- pmu-eve=
nts/arch/x86/sierraforest/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivytown/frontend.json <- pmu-events/a=
rch/x86/ivytown/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivytown/floating-point.json <- pmu-ev=
ents/arch/x86/ivytown/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivytown/uncore-memory.json <- pmu-eve=
nts/arch/x86/ivytown/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivytown/uncore-io.json <- pmu-events/=
arch/x86/ivytown/uncore-io.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivytown/metricgroups.json <- pmu-even=
ts/arch/x86/ivytown/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivytown/uncore-interconnect.json <- p=
mu-events/arch/x86/ivytown/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivytown/counter.json <- pmu-events/ar=
ch/x86/ivytown/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivytown/memory.json <- pmu-events/arc=
h/x86/ivytown/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivytown/cache.json <- pmu-events/arch=
/x86/ivytown/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivytown/uncore-power.json <- pmu-even=
ts/arch/x86/ivytown/uncore-power.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivytown/other.json <- pmu-events/arch=
/x86/ivytown/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivytown/virtual-memory.json <- pmu-ev=
ents/arch/x86/ivytown/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivytown/uncore-cache.json <- pmu-even=
ts/arch/x86/ivytown/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivytown/pipeline.json <- pmu-events/a=
rch/x86/ivytown/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/ivytown/ivt-metrics.json <- pmu-event=
s/arch/x86/ivytown/ivt-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/cascadelakex/clx-metrics.json <- pmu-=
events/arch/x86/cascadelakex/clx-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/cascadelakex/frontend.json <- pmu-eve=
nts/arch/x86/cascadelakex/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/cascadelakex/floating-point.json <- p=
mu-events/arch/x86/cascadelakex/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/cascadelakex/uncore-memory.json <- pm=
u-events/arch/x86/cascadelakex/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/cascadelakex/uncore-io.json <- pmu-ev=
ents/arch/x86/cascadelakex/uncore-io.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/cascadelakex/metricgroups.json <- pmu=
-events/arch/x86/cascadelakex/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/cascadelakex/uncore-interconnect.json=
 <- pmu-events/arch/x86/cascadelakex/uncore-interconnect.json dependency dr=
opped.
make[3]: Circular pmu-events/arch/x86/cascadelakex/counter.json <- pmu-even=
ts/arch/x86/cascadelakex/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/cascadelakex/memory.json <- pmu-event=
s/arch/x86/cascadelakex/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/cascadelakex/cache.json <- pmu-events=
/arch/x86/cascadelakex/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/cascadelakex/uncore-power.json <- pmu=
-events/arch/x86/cascadelakex/uncore-power.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/cascadelakex/other.json <- pmu-events=
/arch/x86/cascadelakex/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/cascadelakex/virtual-memory.json <- p=
mu-events/arch/x86/cascadelakex/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/cascadelakex/uncore-cache.json <- pmu=
-events/arch/x86/cascadelakex/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/cascadelakex/pipeline.json <- pmu-eve=
nts/arch/x86/cascadelakex/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereex/frontend.json <- pmu-event=
s/arch/x86/westmereex/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereex/floating-point.json <- pmu=
-events/arch/x86/westmereex/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereex/counter.json <- pmu-events=
/arch/x86/westmereex/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereex/memory.json <- pmu-events/=
arch/x86/westmereex/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereex/cache.json <- pmu-events/a=
rch/x86/westmereex/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereex/other.json <- pmu-events/a=
rch/x86/westmereex/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereex/virtual-memory.json <- pmu=
-events/arch/x86/westmereex/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/westmereex/pipeline.json <- pmu-event=
s/arch/x86/westmereex/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sapphirerapids/uncore-cxl.json <- pmu=
-events/arch/x86/sapphirerapids/uncore-cxl.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sapphirerapids/frontend.json <- pmu-e=
vents/arch/x86/sapphirerapids/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sapphirerapids/floating-point.json <-=
 pmu-events/arch/x86/sapphirerapids/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sapphirerapids/uncore-memory.json <- =
pmu-events/arch/x86/sapphirerapids/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sapphirerapids/uncore-io.json <- pmu-=
events/arch/x86/sapphirerapids/uncore-io.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sapphirerapids/metricgroups.json <- p=
mu-events/arch/x86/sapphirerapids/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sapphirerapids/uncore-interconnect.js=
on <- pmu-events/arch/x86/sapphirerapids/uncore-interconnect.json dependenc=
y dropped.
make[3]: Circular pmu-events/arch/x86/sapphirerapids/counter.json <- pmu-ev=
ents/arch/x86/sapphirerapids/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sapphirerapids/memory.json <- pmu-eve=
nts/arch/x86/sapphirerapids/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sapphirerapids/cache.json <- pmu-even=
ts/arch/x86/sapphirerapids/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sapphirerapids/uncore-power.json <- p=
mu-events/arch/x86/sapphirerapids/uncore-power.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sapphirerapids/other.json <- pmu-even=
ts/arch/x86/sapphirerapids/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sapphirerapids/virtual-memory.json <-=
 pmu-events/arch/x86/sapphirerapids/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sapphirerapids/uncore-cache.json <- p=
mu-events/arch/x86/sapphirerapids/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sapphirerapids/pipeline.json <- pmu-e=
vents/arch/x86/sapphirerapids/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/sapphirerapids/spr-metrics.json <- pm=
u-events/arch/x86/sapphirerapids/spr-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen3/floating-point.json <- pmu-ev=
ents/arch/x86/amdzen3/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen3/data-fabric.json <- pmu-event=
s/arch/x86/amdzen3/data-fabric.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen3/memory.json <- pmu-events/arc=
h/x86/amdzen3/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen3/branch.json <- pmu-events/arc=
h/x86/amdzen3/branch.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen3/cache.json <- pmu-events/arch=
/x86/amdzen3/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen3/core.json <- pmu-events/arch/=
x86/amdzen3/core.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen3/recommended.json <- pmu-event=
s/arch/x86/amdzen3/recommended.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/amdzen3/other.json <- pmu-events/arch=
/x86/amdzen3/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelake/frontend.json <- pmu-events/a=
rch/x86/icelake/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelake/floating-point.json <- pmu-ev=
ents/arch/x86/icelake/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelake/metricgroups.json <- pmu-even=
ts/arch/x86/icelake/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelake/uncore-interconnect.json <- p=
mu-events/arch/x86/icelake/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelake/icl-metrics.json <- pmu-event=
s/arch/x86/icelake/icl-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelake/counter.json <- pmu-events/ar=
ch/x86/icelake/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelake/memory.json <- pmu-events/arc=
h/x86/icelake/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelake/cache.json <- pmu-events/arch=
/x86/icelake/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelake/other.json <- pmu-events/arch=
/x86/icelake/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelake/uncore-other.json <- pmu-even=
ts/arch/x86/icelake/uncore-other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelake/virtual-memory.json <- pmu-ev=
ents/arch/x86/icelake/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/icelake/pipeline.json <- pmu-events/a=
rch/x86/icelake/pipeline.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylakex/frontend.json <- pmu-events/=
arch/x86/skylakex/frontend.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylakex/floating-point.json <- pmu-e=
vents/arch/x86/skylakex/floating-point.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylakex/uncore-memory.json <- pmu-ev=
ents/arch/x86/skylakex/uncore-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylakex/uncore-io.json <- pmu-events=
/arch/x86/skylakex/uncore-io.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylakex/metricgroups.json <- pmu-eve=
nts/arch/x86/skylakex/metricgroups.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylakex/uncore-interconnect.json <- =
pmu-events/arch/x86/skylakex/uncore-interconnect.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylakex/counter.json <- pmu-events/a=
rch/x86/skylakex/counter.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylakex/memory.json <- pmu-events/ar=
ch/x86/skylakex/memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylakex/cache.json <- pmu-events/arc=
h/x86/skylakex/cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylakex/uncore-power.json <- pmu-eve=
nts/arch/x86/skylakex/uncore-power.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylakex/other.json <- pmu-events/arc=
h/x86/skylakex/other.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylakex/virtual-memory.json <- pmu-e=
vents/arch/x86/skylakex/virtual-memory.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylakex/skx-metrics.json <- pmu-even=
ts/arch/x86/skylakex/skx-metrics.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylakex/uncore-cache.json <- pmu-eve=
nts/arch/x86/skylakex/uncore-cache.json dependency dropped.
make[3]: Circular pmu-events/arch/x86/skylakex/pipeline.json <- pmu-events/=
arch/x86/skylakex/pipeline.json dependency dropped.

=3D=3D> /tmp/stdout <=3D=3D
  CC      util/arm-spe-decoder/arm-spe-pkt-decoder.o
  CC      util/arm-spe-decoder/arm-spe-decoder.o
  CC      util/perf-regs-arch/perf_regs_arm.o
  CC      util/intel-pt-decoder/intel-pt-log.o
  GEN     pmu-events/arch/x86/amdzen1/extra-metrics.json
  CC      util/intel-pt-decoder/intel-pt-decoder.o
  CC      util/perf-regs-arch/perf_regs_csky.o
  CC      util/path.o
  CC      util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.o
  CC      util/perf-regs-arch/perf_regs_loongarch.o
  CC      util/perf-regs-arch/perf_regs_mips.o
  CC      util/scripting-engines/trace-event-perl.o
  CC      util/print_binary.o
  GEN     pmu-events/arch/x86/amdzen2/extra-metrics.json
  CC      util/scripting-engines/trace-event-python.o
  CC      util/print_insn.o

=3D=3D> /tmp/stderr <=3D=3D
Traceback (most recent call last):
  File "/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d798d=
b2f87b3ea0f3a53ed/tools/perf/pmu-events/amd_metrics.py", line 42, in <modul=
e>
    main()
  File "/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d798d=
b2f87b3ea0f3a53ed/tools/perf/pmu-events/amd_metrics.py", line 32, in main
    LoadEvents(directory)
  File "/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d798d=
b2f87b3ea0f3a53ed/tools/perf/pmu-events/metric.py", line 26, in LoadEvents
    for x in json.load(open(f"{directory}/{filename}")):
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/__init__.py", line 293, in load
    return loads(fp.read(),
           ^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/__init__.py", line 346, in loads
    return _default_decoder.decode(s)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/decoder.py", line 337, in decode
    obj, end =3D self.raw_decode(s, idx=3D_w(s, 0).end())
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/decoder.py", line 355, in raw_decode
    raise JSONDecodeError("Expecting value", s, err.value) from None
json.decoder.JSONDecodeError: Expecting value: line 1 column 1 (char 0)

=3D=3D> /tmp/stdout <=3D=3D
  CC      util/perf-regs-arch/perf_regs_powerpc.o
  CC      util/rlimit.o
  CC      util/argv_split.o
  CC      util/perf-regs-arch/perf_regs_riscv.o
  GEN     pmu-events/arch/x86/amdzen3/extra-metrics.json
  CC      util/rbtree.o
  CC      util/libstring.o
  CC      util/bitmap.o
  CC      util/hweight.o

=3D=3D> /tmp/stderr <=3D=3D
make[3]: *** [pmu-events/Build:49: pmu-events/arch/x86/amdzen1/extra-metric=
s.json] Error 1
make[3]: *** Deleting file 'pmu-events/arch/x86/amdzen1/extra-metrics.json'

=3D=3D> /tmp/stdout <=3D=3D
  CC      util/perf-regs-arch/perf_regs_s390.o

=3D=3D> /tmp/stderr <=3D=3D
make[3]: *** Waiting for unfinished jobs....

=3D=3D> /tmp/stdout <=3D=3D
  CC      util/perf-regs-arch/perf_regs_x86.o
  CC      util/strbuf.o
  CC      util/smt.o
  CC      util/string.o

=3D=3D> /tmp/stderr <=3D=3D
Traceback (most recent call last):
  File "/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d798d=
b2f87b3ea0f3a53ed/tools/perf/pmu-events/amd_metrics.py", line 42, in <modul=
e>
    main()
  File "/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d798d=
b2f87b3ea0f3a53ed/tools/perf/pmu-events/amd_metrics.py", line 32, in main
    LoadEvents(directory)
  File "/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d798d=
b2f87b3ea0f3a53ed/tools/perf/pmu-events/metric.py", line 26, in LoadEvents
    for x in json.load(open(f"{directory}/{filename}")):
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/__init__.py", line 293, in load
    return loads(fp.read(),
           ^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/__init__.py", line 346, in loads
    return _default_decoder.decode(s)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/decoder.py", line 337, in decode
    obj, end =3D self.raw_decode(s, idx=3D_w(s, 0).end())
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/decoder.py", line 355, in raw_decode
    raise JSONDecodeError("Expecting value", s, err.value) from None
json.decoder.JSONDecodeError: Expecting value: line 1 column 1 (char 0)

=3D=3D> /tmp/stdout <=3D=3D
  CC      util/strlist.o
  CC      util/strfilter.o

=3D=3D> /tmp/stderr <=3D=3D
make[3]: *** [pmu-events/Build:49: pmu-events/arch/x86/amdzen2/extra-metric=
s.json] Error 1
make[3]: *** Deleting file 'pmu-events/arch/x86/amdzen2/extra-metrics.json'

=3D=3D> /tmp/stdout <=3D=3D
  CC      util/top.o
  LD      trace/beauty/tracepoints/perf-in.o
  CC      util/usage.o
  CC      util/dso.o
  CC      util/dsos.o
  CC      util/symbol.o
  CC      util/symbol_fprintf.o
  CC      util/map_symbol.o
  CC      util/color.o
  CC      util/color_config.o
  CC      util/metricgroup.o
  CC      util/header.o
  CC      util/callchain.o
  CC      util/values.o
  CC      util/debug.o
  CC      util/fncache.o
  CC      util/machine.o
  CC      util/pstack.o
  CC      util/map.o
  CC      util/tool.o
  CC      util/session.o
  CC      util/sample-raw.o
  CC      util/maps.o

=3D=3D> /tmp/stderr <=3D=3D
Traceback (most recent call last):
  File "/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d798d=
b2f87b3ea0f3a53ed/tools/perf/pmu-events/amd_metrics.py", line 42, in <modul=
e>
    main()
  File "/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d798d=
b2f87b3ea0f3a53ed/tools/perf/pmu-events/amd_metrics.py", line 32, in main
    LoadEvents(directory)
  File "/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b58625961de2638d2d798d=
b2f87b3ea0f3a53ed/tools/perf/pmu-events/metric.py", line 26, in LoadEvents
    for x in json.load(open(f"{directory}/{filename}")):
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/__init__.py", line 293, in load
    return loads(fp.read(),
           ^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/__init__.py", line 346, in loads
    return _default_decoder.decode(s)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/decoder.py", line 337, in decode
    obj, end =3D self.raw_decode(s, idx=3D_w(s, 0).end())
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/json/decoder.py", line 355, in raw_decode
    raise JSONDecodeError("Expecting value", s, err.value) from None
json.decoder.JSONDecodeError: Expecting value: line 1 column 1 (char 0)
make[3]: *** [pmu-events/Build:49: pmu-events/arch/x86/amdzen3/extra-metric=
s.json] Error 1
make[3]: *** Deleting file 'pmu-events/arch/x86/amdzen3/extra-metrics.json'
make[2]: *** [Makefile.perf:765: pmu-events/pmu-events-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....

=3D=3D> /tmp/stdout <=3D=3D
  CC      util/s390-sample-raw.o
  CC      util/amd-sample-raw.o
  CC      util/syscalltbl.o
  CC      util/ordered-events.o
  CC      util/namespaces.o
  CC      util/comm.o
  CC      util/thread.o
  CC      util/threads.o
  CC      util/thread_map.o
  CC      util/parse-events-bison.o
  BISON   util/pmu-bison.c
  CC      util/pmus.o
  LD      trace/beauty/perf-in.o
  CC      util/svghelper.o
  CC      util/trace-event-info.o
  CC      util/trace-event-scripting.o
  CC      util/trace-event.o
  CC      util/trace-event-parse.o
  CC      util/trace-event-read.o
  CC      util/sort.o
  CC      util/hist.o
  CC      util/util.o
  CC      util/cpumap.o
  CC      util/affinity.o
  CC      util/cgroup.o
  CC      util/cputopo.o
  CC      util/target.o
  CC      util/rblist.o
  CC      util/intlist.o
  CC      util/vdso.o
  CC      util/stat.o
  CC      util/counts.o
  CC      util/stat-shadow.o
  CC      util/stat-display.o
  CC      util/perf_api_probe.o
  CC      util/record.o
  CC      util/srcline.o
  CC      util/srccode.o
  CC      util/synthetic-events.o
  CC      util/data.o
  CC      util/tsc.o
  CC      util/cloexec.o
  CC      util/rwsem.o
  CC      util/call-path.o
  LD      tests/workloads/perf-test-in.o
  CC      util/thread-stack.o
  CC      util/spark.o
  CC      util/topdown.o
  CC      util/iostat.o
  CC      util/stream.o
  CC      util/intel-pt.o
  CC      util/auxtrace.o
  CC      util/intel-bts.o
  CC      util/hisi-ptt.o
  CC      util/s390-cpumsf.o
  CC      util/arm-spe.o
  CC      util/parse-branch-options.o
  CC      util/dump-insn.o
  CC      util/cs-etm-base.o
  CC      util/parse-regs-options.o
  CC      util/parse-sublevel-options.o
  CC      util/term.o
  CC      util/help-unknown-cmd.o
  CC      util/dlfilter.o
  CC      util/mem-events.o
  LD      ui/tui/perf-ui-in.o
  CC      util/vsprintf.o
  CC      util/mem-info.o
  CC      util/units.o
  CC      util/time-utils.o
  CC      util/branch.o
  BISON   util/expr-bison.c
  CC      util/mem2node.o
  LD      util/perf-regs-arch/perf-util-in.o
  CC      util/clockid.o
  CC      util/list_sort.o
  CC      util/mutex.o
  CC      util/sharded_mutex.o
  CC      util/intel-tpebs.o
  CC      util/bpf_map.o
  CC      util/symbol-elf.o
  CC      util/probe-file.o
  CC      util/probe-event.o
  CC      util/probe-finder.o
  CC      util/dwarf-aux.o
  CC      util/dwarf-regs.o
  CC      util/debuginfo.o
  CC      util/annotate-data.o
  CC      util/unwind-libunwind-local.o
  CC      util/unwind-libunwind.o
  CC      util/data-convert-bt.o
  CC      util/data-convert-json.o
  CC      util/zlib.o
  CC      util/lzma.o
  CC      util/zstd.o
  CC      util/cap.o
  CXX     util/demangle-cxx.o
  CC      util/demangle-ocaml.o
  CC      util/demangle-rust.o
  CC      util/demangle-java.o
  CC      util/jitdump.o
  CC      util/genelf.o
  CC      util/genelf_debug.o
  CC      util/perf-hooks.o
  CC      util/bpf-utils.o
  CC      util/bpf-event.o
  CC      util/pfm.o
  FLEX    util/parse-events-flex.c
  FLEX    util/pmu-flex.c
  CC      util/pmu-bison.o
  FLEX    util/expr-flex.c
  CC      util/expr-bison.o
  LD      arch/x86/tests/perf-test-in.o
  CC      util/intel-pt-decoder/intel-pt-insn-decoder.o
  LD      arch/x86/perf-test-in.o
  CC      util/pmu.o
  CC      util/pmu-flex.o
  CC      util/expr-flex.o
  CC      util/expr.o
  CC      util/parse-events.o
  LD      util/hisi-ptt-decoder/perf-util-in.o
  CC      util/parse-events-flex.o
  LD      arch/perf-test-in.o
  LD      scripts/python/Perf-Trace-Util/perf-util-in.o
  LD      util/arm-spe-decoder/perf-util-in.o
  LD      arch/x86/util/perf-util-in.o
  LD      arch/x86/perf-util-in.o
  LD      arch/perf-util-in.o
  LD      bench/perf-bench-in.o
  LD      perf-bench-in.o
  LD      scripts/perl/Perf-Trace-Util/perf-util-in.o
  LD      scripts/perf-util-in.o
  LD      tests/perf-test-in.o
  LD      perf-test-in.o
  LD      util/scripting-engines/perf-util-in.o
  LD      ui/browsers/perf-ui-in.o
  LD      ui/perf-ui-in.o
  LD      perf-ui-in.o
  LD      util/intel-pt-decoder/perf-util-in.o
  LD      perf-in.o
  LD      util/perf-util-in.o
  LD      perf-util-in.o

=3D=3D> /tmp/stderr <=3D=3D
make[1]: *** [Makefile.perf:292: sub-make] Error 2
make: *** [Makefile:76: all] Error 2

=3D=3D> /tmp/stdout <=3D=3D
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-bpf-1b5862=
5961de2638d2d798db2f87b3ea0f3a53ed/tools/perf'
make perf failed

--VZJJSsuX2mnIFoRA--
