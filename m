Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BEA279355;
	Mon, 26 Jan 2026 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769438847; cv=fail; b=goxwLlluuKvtXE1Hrd5vcRE1o/JjztvWS8VsLXczYMwtCWiDqZmHvINjDpX3W09aEKjBRt2gUNaGrsAQv7/F3g2rnPFWv4Ax46zeU/hBPkMdVvTYCDZx7ScVOfkdKFyGhOMExjIVU3ZRa1655nmsj0gHVEEthta2mKkpNaZgeNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769438847; c=relaxed/simple;
	bh=DLFBbXBeB6bzq3YR7G60PkeZEZ52yLTj+3na2Y8e674=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ih9XwCrSiWiZml6SSAqzNkwOJMT4NxpJWedyI05QKrehifk2rfX8Djjn/cbczNqIYoDj38OQXknVQ1dnmiSEqfwo31ciQa6cb4ayVUr6KkTEU5MDYGSZzEkKb75ucatSX/tglY/KkzNBA4zwfRLddyBdumb2T5IU2GCwDKAbCrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mmUAMkjq; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mmUAMkjq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769438843; x=1800974843;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=DLFBbXBeB6bzq3YR7G60PkeZEZ52yLTj+3na2Y8e674=;
  b=mmUAMkjqh9nMziICO52AQVg29/zK0ksufGCtR0i8TINjhJ1adWOIwEhm
   HA1ZKGxOJ4z89MamJq1dK3fo8GbFZ/hTDKAD+Ia9YgaHvBTviW095//4e
   Kh1GPUTYcC+fEQGW1a37/e232CfjfM5QNfZ5XL6cHMfEUqe5g/V0RFgEv
   7B/GQQHesSjJ3Lt/OqBFCBtAnGvH/LkHFIpp2ST2Rx2+M7QU8RRpRn2IF
   Mr8t3gJ0C42MXlYlNrbvx2c54j4UBjPE/cwtOBs1YfuHS1p0sB4bZj9iU
   a8RDUr/xAP6UPeDA6cMuJQUnGI22x2U3yyMZVh/VlIS0g+P04jB45aBwI
   g==;
X-CSE-ConnectionGUID: v+MjLS7LR4GQ4ukGi8NBEA==
X-CSE-MsgGUID: b0TPwe+RQsKacFgN6+jY3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="81249738"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="81249738"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 06:47:22 -0800
X-CSE-ConnectionGUID: BJMaWDBwSeK+HfK1xyLbOw==
X-CSE-MsgGUID: KzpCenJsRf639+skqNytbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="238371850"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 06:47:21 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 06:47:21 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 26 Jan 2026 06:47:21 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.51) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 06:47:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqelqOPk2INbvKSfTn0BrY2OLmCeKoeGuPvb/FxcYK2THaVoDlhIYAIg3mKojW2lKHPuE4BU+LsS/r0lubWTuk3wSJaF3jy9+J/gSKQIqphw78XMNBoP+1EcYpbtxYespZeJ6fs1aMZ9Z/R84xyENWOQBr/BKoyv29ULQjLF9y1o0ByhwP/8IWlLHnH6aAiG3Zc4KAfI80B0iEZeLan3Oc1vfbgCJyjjaa4hUkqAJ6/dK5Mc1iroeCWnBlSOYP8zH+xZxNF+I9xtO625jy4BmDv5iSmT98W7mmv84oG98tck+ScG+ZfXVod3+ccSYPwx7B87qRZ8zdCpM3WCtUk7kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOYjyJC/YFX5gZ8fagjNxFmqi2aUcl38iun7cgeWP40=;
 b=W89jjSo+9jrQ3V4r5ai29kelEuvXsN3EYQUYgpLtzoHGeFsu2WCi8XxrL0vpbham0SPdcq24uaWbf0ezLwhDDgPHIKFYrYoR9Yr89Khr0CgYawnPgzf0HpWLQ8MAhyV2j/KF6EVR51Hc29MnAfx4nFv8m47nlcSGCmTtZhEdeFPp8LIpD/ydvGzjTGpoNaEvcSX0H79qHstO+d05oTrPi1Ae+mNQUBuRYGUm+V8Z87i21vQY5cRDX0F0v0Pia1q7d3hqoIWlIW0th2O7kqzUfjxbg/j71E9kbcaDnPq31P7ErSMCYrT7C3Xr+0ZET7ED6EpSaFtEhmSwqdO1UQfkRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA0PR11MB4670.namprd11.prod.outlook.com (2603:10b6:806:9a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Mon, 26 Jan
 2026 14:47:17 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 14:47:17 +0000
Date: Mon, 26 Jan 2026 22:46:56 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@arm.com>,
	<ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>, <yu.c.chen@intel.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<sshegde@linux.ibm.com>, <ctshao@google.com>, <quic_zhonhan@quicinc.com>,
	<thomas.falcon@intel.com>, <blakejones@google.com>, <ashelat@redhat.com>,
	<leo.yan@arm.com>, <dvyukov@google.com>, <ak@linux.intel.com>,
	<yujie.liu@intel.com>, <graham.woodward@arm.com>, <ben.gainey@arm.com>,
	<vineethr@linux.ibm.com>, <tim.c.chen@linux.intel.com>, <linux@treblig.org>,
	<santosh.shukla@amd.com>, <sandipan.das@amd.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v5 02/10] perf header: Support CPU DOMAIN relation info
Message-ID: <202601262235.ee84b79e-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260119175833.340369-3-swapnil.sapkal@amd.com>
X-ClientProxiedBy: KL1PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:820:1::32) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA0PR11MB4670:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c13fa5-7dfe-479a-5438-08de5ce9cce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xr9/7LNj/VhuHUysG01R6/Uqgmw+w6MCjByRvoanPOTWnx1KqTeycdcpETVa?=
 =?us-ascii?Q?1dBiOVUN2Lr8itSmpgJFVNK9hd2Hvye7oinLP7rLM1HfmQ/R6JH0Ie26M+Ee?=
 =?us-ascii?Q?ekGzt2CVHIyQMIw5Dya8r4E3VeAH0FvBnttw3B46bG3z9SeOzGlWOxIFNdxt?=
 =?us-ascii?Q?lsAqacbazX0j/z4O3jdaEaLqZrzRxuN2xfxEg9tntuEizG3tv45yCGUjlTw+?=
 =?us-ascii?Q?w5ZtnVRYU34+qekyk1shWz/84KUf0vnW5EchPoJKCkQcJsCioZhg0owB2arT?=
 =?us-ascii?Q?Np/JN/RLgXweY0zP5YMgOmKiG16Cw03Cl+1Kw/3/BDTOzlibzFkAvH4e3lHF?=
 =?us-ascii?Q?ags5JjGJ3xwcJGCtdPF8fqUI+PP04W3J/wIsjrKOPz+nomNS96KZbvwZAa7h?=
 =?us-ascii?Q?iIVfIVKdwt1l6wepJsZ4tLjivSXPdzqaYuPNETc6tmKF3O1+6+3xszw6Q69k?=
 =?us-ascii?Q?MXktlGIa4fp25+IIPxg3hkHilIDlpehN/sG8KbFlS0qtjpILx9nnw3kSYEGI?=
 =?us-ascii?Q?mK1Y84Fv5agOWrUGTYaczh9Zsa7b9GFPxKx1uBZp/U5XDzmK1Mt+LoPMrtmB?=
 =?us-ascii?Q?61JyoyQR6JRw+pQGEvR+V0EAxH5c/bWoIfwvetNgDMr4xu3X23ZgaQZnmvWc?=
 =?us-ascii?Q?b62IKouwp4C3NrQEr8fYDXkw99aZz1PLajoKtTjp4LFGoEEi4PEp1c7Hrcp+?=
 =?us-ascii?Q?gTppV+MyDkYHvMtpKhSCdjlkUgPiSXQIgy5QlgTGslYJnvQDBVfqKW+IdvBk?=
 =?us-ascii?Q?ga47sMy/3owLMJlsIbNMVyYP88P2kwnpEjvFIZnogumzWwJ1pJ1K03uEghlH?=
 =?us-ascii?Q?6L0TyF296igI5V3jTziu/iSDnNQjw0t4j4Jwz0ZRAlC9Y5yxEgW57ow2v06O?=
 =?us-ascii?Q?TcT3Tqp1q0G+4ONCvoeHku4EpMXiFD9E592hb1kyerPDfRyyaoRO3IGDAjxl?=
 =?us-ascii?Q?PDcSYZRdtFADpJWWj0wrzewS35qL/k3o88wj9VxzGll/IqJ27SyZkIj3JS2/?=
 =?us-ascii?Q?RPGsacDCR4TxknZ4zappDufAO5kBlyOqbdva5PCscuNjqAh+86K8JC6u9mOZ?=
 =?us-ascii?Q?/Evx4lb4Ty5YIlgfBkgtBFX0zzpAbZB2A4gz+wQYG/PX9OuNYGB3EEsNM5RA?=
 =?us-ascii?Q?NkczVe1IiFjOaEIHfxiJLdcVey2+5VJyr++iqQaYHV/xkG6utHJbWFtVYJl/?=
 =?us-ascii?Q?N1QEqpM406xkYpxePPLnLUht2hFg4V0HHXBK6nDwI2khOfx0SUKe81oYrHIw?=
 =?us-ascii?Q?PeeRr0MEc7O73ICkJe7CLAqx4a1Zw3D4dzzUZ/v1ROinQa0u/dWX5kgGGXPs?=
 =?us-ascii?Q?g5JE5bGuUUflmpqMYM0bDQElHANzBd66NKpldJJX3QCcIXungb8AcW/LolPL?=
 =?us-ascii?Q?AlSHWtpOedHnbmQo0zOjnqFK6a6BrRfzKw1enODZpLl7vGtHcb0ozL/cEpRC?=
 =?us-ascii?Q?+De3KPpftxlgrIljqaBe27dDQnxEL0bk+s53mF2nTYc7KvQXtaozmokAsBvZ?=
 =?us-ascii?Q?BjmSdBzTtkQw8COHdqg0YCnrrd8nTxb2zDfnXStunk8A6EkCJLi8CRlxsL6P?=
 =?us-ascii?Q?Mfsxxzg7OoLq9fsm4XtQqMs3umxj3s4Oq5iyN+zz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?syvAzZiIem1E+bDdiwJWk22ZIUGQjHUZWQ/cuk/ntAITW2lPkIBpeYh3UTUU?=
 =?us-ascii?Q?84wlMGTbnwCIFHGGw25DrxhWycsJKC/uifKGRCyYJ7VM/9MqZswrmgL3ktxV?=
 =?us-ascii?Q?Usvd4CaoE+bu+k+957LyAhuByEGjsizSAV8/6MWVzAPXSM4DwRe7twLcGB2Q?=
 =?us-ascii?Q?WojpE8P4o8U8nc0aHdbGrDtMDztR/S/A4cOi1tF7zPmwKmfr23xNzrt3ljNs?=
 =?us-ascii?Q?qNLqHwosrzTahC0MDp4lX1x1mtW/w1M377z6HOCRGrHIdr3Cng1ERtKhtzBH?=
 =?us-ascii?Q?xumRdjWSJorsLUHTa3a2RwWXskCssbBgTgx3lBNXs62l5Gte7kyAHTDlmarM?=
 =?us-ascii?Q?62G+4jfIAXkahJkQq9lhGfpkvjIzcBpK+1lAvrU6GyHxbHmjfKqWuCbfig0+?=
 =?us-ascii?Q?RPVX88ZsoWsvnVDXPGTz4qUNVOVptTpfOWerqGbvJXMdNJ4uuG7JyDC8aSZA?=
 =?us-ascii?Q?uVSqwgE3dbZWWKnaTz33qM0qWdWijYNvZBlPJeDfs4jzQEpCTf0QE98r4nzu?=
 =?us-ascii?Q?ZWRiNuMliiDd2RZ6qGZonRhtpixVle9+Z36iI/JNQonIBSZIUX8iVPF85t04?=
 =?us-ascii?Q?m+59ri4wkgSLCpnYhTn4cUXNKanjhY7ySxK10UaD8KPhuE8L5jNNkUGfwHWr?=
 =?us-ascii?Q?iKdaTn3Jv5poPWaMl5I90wmF+8jadszWMrwkAviTtprOSiMfUNltZ/D5DMDK?=
 =?us-ascii?Q?lqkBWtJXosAR7CSzfhO2asq7+GxaVl1mIN4N0EoqCKURs+WkzoEvhf881Nnp?=
 =?us-ascii?Q?EkEQSx4K6RVaW5+f1kX1QmiwroSOFKm5Q9zTMEJi3mABlSQbgwgKQMhTA4Vw?=
 =?us-ascii?Q?fKMbzFIWoB13uYKvqSwAOeVtkQnlGdKrxMxd7je+I2Jst0T3tY//rlDciffp?=
 =?us-ascii?Q?mT2FJxqOBkem7i7mimbV3yB2Un786MZhMRBWU8dXdJEkaxvrSM5FxVbSPIbX?=
 =?us-ascii?Q?O/NRHel4GE8jr5Qcd+iiqFMu/CiFMMzmpwaVxByUEVH/zcQSpXDjk5NYv4D7?=
 =?us-ascii?Q?fpPL8SCwIRaHXdDvVrSmHPlackUzjA8r6p02ScykwK9bUhqUDoGCzhfiEc6D?=
 =?us-ascii?Q?7gYvYmYxwRF+rqmooQ0EPV3iNSCHzsN8D9tKTUyIZnur9j+rLVZAhAdva8Sm?=
 =?us-ascii?Q?wP/yZH2XwD/NLzpybr5/cZNgFFPOn32vuM3PFfozbLzACygudpxR4rkv262A?=
 =?us-ascii?Q?lbNyKBxFnU+y3bbfnQY/5YCFN+OneDLk6cjUNRXEe0pdU/IiVinRFcsCyUxX?=
 =?us-ascii?Q?EzFrXU5/22UqgMqnpSKboJianSn2QJxqhLnULUmLWUJX7xHAfHVbUdYwSD5a?=
 =?us-ascii?Q?kIAZntB+k0MbdrmuZHN+LBXIA+63d5twwgcTWEaHKYgFRh9gT0OYSgZvelKy?=
 =?us-ascii?Q?nVuWWNZQuLZA7Bmcx9Y2HVrlBA7k7KN4pX9h8tDIklKZipfNz7qd7FN/iD+H?=
 =?us-ascii?Q?4Aq0h8zb3a8bbg1NI3bozNmG5JLtnSRgXq7aHeh+QHph7MIomsm2OQV3bS6w?=
 =?us-ascii?Q?SnzwfHNoPgvI0U7cYguRMVWVJKGxXhYGkezTUquRAThWoATEE5vlgOL6NI2h?=
 =?us-ascii?Q?2u7zbRmEcOOH59pPlSswB1yqrflZLtuEhnywAFnpD3iZOXOyjS8+eI/5E+Kg?=
 =?us-ascii?Q?1mlWFnCfY/x6G2XHw8gptPHYZ93ec/+D2e3/pBhzlNhDo/bGGUD/5+aVQwSO?=
 =?us-ascii?Q?AowuUD7weJ22Lv+4I2YGHV8BpYb3voNramcTtpdxIhXNMnLYlgpT6tE578pH?=
 =?us-ascii?Q?2iOhWIrqBA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c13fa5-7dfe-479a-5438-08de5ce9cce4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 14:47:17.2409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWpr+5FR7+tC9C0JEBQqN2u2G+KajcZFEyarpzQW4oGK3viq1DA/2AWt085411TvtxOdB09oL1LOg2wwCsC2hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4670
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kmsg.sanitizer.direct_leak/calloc/zalloc/process_cpu_domain_info/perf_file_section__process/perf_header__process_sections/perf_session__read_header" on:

commit: 6f993818d20c79b874f546cec1dcce40a9927c7b ("[PATCH v5 02/10] perf header: Support CPU DOMAIN relation info")
url: https://github.com/intel-lab-lkp/linux/commits/Swapnil-Sapkal/tools-lib-Add-list_is_first/20260120-021007
base: https://git.kernel.org/cgit/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link: https://lore.kernel.org/all/20260119175833.340369-3-swapnil.sapkal@amd.com/
patch subject: [PATCH v5 02/10] perf header: Support CPU DOMAIN relation info

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: gcc
	group: group-02



config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 256 threads 4 sockets INTEL(R) XEON(R) PLATINUM 8592+ (Emerald Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202601262235.ee84b79e-lkp@intel.com


we found below tests impacted.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/perf_compiler/group:
  lkp-emr-2sp1/perf-sanity-tests/debian-13-x86_64-20250902.cgz/x86_64-rhel-9.4-bpf/gcc-14/gcc/group-02

4d991caa3f1e36c3 6f993818d20c79b874f546cec1d
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6          100%           6:6     perf-sanity-tests.build_id_cache_operations.fail
           :6          100%           6:6     perf-sanity-tests.perf_evlist_tests.fail
           :6          100%           6:6     perf-sanity-tests.perf_header_tests.fail




2026-01-24 13:53:34 sudo ASAN_OPTIONS=fast_unwind_on_malloc=0 /usr/src/linux-perf-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf test 80 -v
 80: build id cache operations                                       : Running (1 active)
--- start ---
test child forked, pid 14171
WARNING: perf not built with libbfd. PE binaries will not be tested.
WARNING: wine not found. PE binaries will not be run.
test binaries: /tmp/perf_buildid_test.ex.SHA1.fdj /tmp/perf_buildid_test.ex.MD5.U8m /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/tests/shell/../pe-file.exe
DEBUGINFOD_URLS=
Downloading debug info with build id 89e03056b3c150ac13d49ad72e7ccfe9e8e1fb11
Adding 89e03056b3c150ac13d49ad72e7ccfe9e8e1fb11 /tmp/perf_buildid_test.ex.SHA1.fdj: Ok
build id: 89e03056b3c150ac13d49ad72e7ccfe9e8e1fb11
link: /tmp/perf_buildid_test.debug.PIE/.build-id/89/e03056b3c150ac13d49ad72e7ccfe9e8e1fb11
file: /tmp/perf_buildid_test.debug.PIE/.build-id/89/../../tmp/perf_buildid_test.ex.SHA1.fdj/89e03056b3c150ac13d49ad72e7ccfe9e8e1fb11/elf
OK for /tmp/perf_buildid_test.ex.SHA1.fdj
DEBUGINFOD_URLS=
Downloading debug info with build id ee26502b2cb816e82d08fd203ebf46b4
Adding ee26502b2cb816e82d08fd203ebf46b4 /tmp/perf_buildid_test.ex.MD5.U8m: Ok
build id: ee26502b2cb816e82d08fd203ebf46b4
link: /tmp/perf_buildid_test.debug.dem/.build-id/ee/26502b2cb816e82d08fd203ebf46b4
file: /tmp/perf_buildid_test.debug.dem/.build-id/ee/../../tmp/perf_buildid_test.ex.MD5.U8m/ee26502b2cb816e82d08fd203ebf46b4/elf
OK for /tmp/perf_buildid_test.ex.MD5.U8m
running: perf record /tmp/perf_buildid_test.ex.SHA1.fdj
build id: 89e03056b3c150ac13d49ad72e7ccfe9e8e1fb11
link: /tmp/perf_buildid_test.debug.T5w/.build-id/89/e03056b3c150ac13d49ad72e7ccfe9e8e1fb11
file: /tmp/perf_buildid_test.debug.T5w/.build-id/89/../../tmp/perf_buildid_test.ex.SHA1.fdj/89e03056b3c150ac13d49ad72e7ccfe9e8e1fb11/elf

=================================================================
==14272==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 131072 byte(s) in 1024 object(s) allocated from:
    #0 0x7f3a7fd98c57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x563053942c76 in do_read_string util/header.c:261
    #2 0x563053967c30 in process_cpu_domain_info util/header.c:3653
    #3 0x56305396f9f3 in perf_file_section__process util/header.c:4386
    #4 0x56305396cfb5 in perf_header__process_sections util/header.c:4144
    #5 0x563053971ef1 in perf_session__read_header util/header.c:4620
    #6 0x5630539cd802 in perf_session__open util/session.c:54
    #7 0x5630539cea98 in __perf_session__new util/session.c:168
    #8 0x5630532b6d43 in perf_session__new util/session.h:116
    #9 0x5630532b798b in perf_session__list_build_ids /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-buildid-list.c:113
    #10 0x5630532b8891 in cmd_buildid_list /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-buildid-list.c:175
    #11 0x5630535113bf in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:348
    #12 0x563053511b8f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:398
    #13 0x5630535120e5 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:442
    #14 0x563053512851 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:549
    #15 0x7f3a75ac0ca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x7f3a75ac0d64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #17 0x563053277310 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf+0x1048310) (BuildId: 07c75edf5764b1417259ec0a6cb5fc6de1859c88)

Direct leak of 73728 byte(s) in 1024 object(s) allocated from:
    #0 0x7f3a7fd98610 in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x56305353dd0c in zalloc ../../lib/zalloc.c:8
    #2 0x563053967c7f in process_cpu_domain_info util/header.c:3657
    #3 0x56305396f9f3 in perf_file_section__process util/header.c:4386
    #4 0x56305396cfb5 in perf_header__process_sections util/header.c:4144
    #5 0x563053971ef1 in perf_session__read_header util/header.c:4620
    #6 0x5630539cd802 in perf_session__open util/session.c:54
    #7 0x5630539cea98 in __perf_session__new util/session.c:168
    #8 0x5630532b6d43 in perf_session__new util/session.h:116
    #9 0x5630532b798b in perf_session__list_build_ids /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-buildid-list.c:113
    #10 0x5630532b8891 in cmd_buildid_list /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-buildid-list.c:175
    #11 0x5630535113bf in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:348
    #12 0x563053511b8f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:398
    #13 0x5630535120e5 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:442
    #14 0x563053512851 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:549
    #15 0x7f3a75ac0ca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x7f3a75ac0d64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #17 0x563053277310 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf+0x1048310) (BuildId: 07c75edf5764b1417259ec0a6cb5fc6de1859c88)

Direct leak of 65536 byte(s) in 1024 object(s) allocated from:
    #0 0x7f3a7fd98c57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x563053942c76 in do_read_string util/header.c:261
    #2 0x563053967a1c in process_cpu_domain_info util/header.c:3642
    #3 0x56305396f9f3 in perf_file_section__process util/header.c:4386
    #4 0x56305396cfb5 in perf_header__process_sections util/header.c:4144
    #5 0x563053971ef1 in perf_session__read_header util/header.c:4620
    #6 0x5630539cd802 in perf_session__open util/session.c:54
    #7 0x5630539cea98 in __perf_session__new util/session.c:168
    #8 0x5630532b6d43 in perf_session__new util/session.h:116
    #9 0x5630532b798b in perf_session__list_build_ids /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-buildid-list.c:113
    #10 0x5630532b8891 in cmd_buildid_list /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-buildid-list.c:175
    #11 0x5630535113bf in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:348
    #12 0x563053511b8f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:398
    #13 0x5630535120e5 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:442
    #14 0x563053512851 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:549
    #15 0x7f3a75ac0ca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x7f3a75ac0d64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #17 0x563053277310 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf+0x1048310) (BuildId: 07c75edf5764b1417259ec0a6cb5fc6de1859c88)

Direct leak of 65536 byte(s) in 1024 object(s) allocated from:
    #0 0x7f3a7fd98c57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x563053942c76 in do_read_string util/header.c:261
    #2 0x563053967e44 in process_cpu_domain_info util/header.c:3662
    #3 0x56305396f9f3 in perf_file_section__process util/header.c:4386
    #4 0x56305396cfb5 in perf_header__process_sections util/header.c:4144
    #5 0x563053971ef1 in perf_session__read_header util/header.c:4620
    #6 0x5630539cd802 in perf_session__open util/session.c:54
    #7 0x5630539cea98 in __perf_session__new util/session.c:168
    #8 0x5630532b6d43 in perf_session__new util/session.h:116
    #9 0x5630532b798b in perf_session__list_build_ids /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-buildid-list.c:113
    #10 0x5630532b8891 in cmd_buildid_list /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-buildid-list.c:175
    #11 0x5630535113bf in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:348
    #12 0x563053511b8f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:398
    #13 0x5630535120e5 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:442
    #14 0x563053512851 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:549
    #15 0x7f3a75ac0ca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x7f3a75ac0d64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #17 0x563053277310 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf+0x1048310) (BuildId: 07c75edf5764b1417259ec0a6cb5fc6de1859c88)

Direct leak of 10532 byte(s) in 1024 object(s) allocated from:
    #0 0x7f3a7fd98610 in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x56305353dd0c in zalloc ../../lib/zalloc.c:8
    #2 0x563053967e93 in process_cpu_domain_info util/header.c:3666
    #3 0x56305396f9f3 in perf_file_section__process util/header.c:4386
    #4 0x56305396cfb5 in perf_header__process_sections util/header.c:4144
    #5 0x563053971ef1 in perf_session__read_header util/header.c:4620
    #6 0x5630539cd802 in perf_session__open util/session.c:54
    #7 0x5630539cea98 in __perf_session__new util/session.c:168
    #8 0x5630532b6d43 in perf_session__new util/session.h:116
    #9 0x5630532b798b in perf_session__list_build_ids /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-buildid-list.c:113
    #10 0x5630532b8891 in cmd_buildid_list /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-buildid-list.c:175
    #11 0x5630535113bf in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:348
    #12 0x563053511b8f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:398
    #13 0x5630535120e5 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:442
    #14 0x563053512851 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:549
    #15 0x7f3a75ac0ca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x7f3a75ac0d64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #17 0x563053277310 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf+0x1048310) (BuildId: 07c75edf5764b1417259ec0a6cb5fc6de1859c88)

Direct leak of 4352 byte(s) in 1024 object(s) allocated from:
    #0 0x7f3a7fd98610 in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x56305353dd0c in zalloc ../../lib/zalloc.c:8
    #2 0x563053967a6b in process_cpu_domain_info util/header.c:3646
    #3 0x56305396f9f3 in perf_file_section__process util/header.c:4386
    #4 0x56305396cfb5 in perf_header__process_sections util/header.c:4144
    #5 0x563053971ef1 in perf_session__read_header util/header.c:4620
    #6 0x5630539cd802 in perf_session__open util/session.c:54
    #7 0x5630539cea98 in __perf_session__new util/session.c:168
    #8 0x5630532b6d43 in perf_session__new util/session.h:116
    #9 0x5630532b798b in perf_session__list_build_ids /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-buildid-list.c:113
    #10 0x5630532b8891 in cmd_buildid_list /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-buildid-list.c:175
    #11 0x5630535113bf in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:348
    #12 0x563053511b8f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:398
    #13 0x5630535120e5 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:442
    #14 0x563053512851 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:549
    #15 0x7f3a75ac0ca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x7f3a75ac0d64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #17 0x563053277310 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf+0x1048310) (BuildId: 07c75edf5764b1417259ec0a6cb5fc6de1859c88)

SUMMARY: AddressSanitizer: 350756 byte(s) leaked in 6144 allocation(s).
failed: 89e03056b3c150ac13d49ad72e7ccfe9e8e1fb11 is not reported by "perf buildid-list -i /tmp/perf_buildid_test.data.9pp"
Unexpected signal in check
---- end(-1) ----
 80: build id cache operations                                       : FAILED!


...


2026-01-24 13:55:59 sudo ASAN_OPTIONS=fast_unwind_on_malloc=0 /usr/src/linux-perf-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf test 85 -v
 85: perf evlist tests                                               : Running (1 active)
--- start ---
test child forked, pid 15479
Simple evlist test

=================================================================
==15499==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 131072 byte(s) in 1024 object(s) allocated from:
    #0 0x7f3c9bf85c57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x55c6557f9c76 in do_read_string util/header.c:261
    #2 0x55c65581ec30 in process_cpu_domain_info util/header.c:3653
    #3 0x55c6558269f3 in perf_file_section__process util/header.c:4386
    #4 0x55c655823fb5 in perf_header__process_sections util/header.c:4144
    #5 0x55c655828ef1 in perf_session__read_header util/header.c:4620
    #6 0x55c655884802 in perf_session__open util/session.c:54
    #7 0x55c655885a98 in __perf_session__new util/session.c:168
    #8 0x55c6551528d3 in perf_session__new util/session.h:116
    #9 0x55c655152d1f in __cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:46
    #10 0x55c655153e1a in cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:101
    #11 0x55c6553c83bf in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:348
    #12 0x55c6553c8b8f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:398
    #13 0x55c6553c90e5 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:442
    #14 0x55c6553c9851 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:549
    #15 0x7f3c91cadca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x7f3c91cadd64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #17 0x55c65512e310 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf+0x1048310) (BuildId: 07c75edf5764b1417259ec0a6cb5fc6de1859c88)

Direct leak of 73728 byte(s) in 1024 object(s) allocated from:
    #0 0x7f3c9bf85610 in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x55c6553f4d0c in zalloc ../../lib/zalloc.c:8
    #2 0x55c65581ec7f in process_cpu_domain_info util/header.c:3657
    #3 0x55c6558269f3 in perf_file_section__process util/header.c:4386
    #4 0x55c655823fb5 in perf_header__process_sections util/header.c:4144
    #5 0x55c655828ef1 in perf_session__read_header util/header.c:4620
    #6 0x55c655884802 in perf_session__open util/session.c:54
    #7 0x55c655885a98 in __perf_session__new util/session.c:168
    #8 0x55c6551528d3 in perf_session__new util/session.h:116
    #9 0x55c655152d1f in __cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:46
    #10 0x55c655153e1a in cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:101
    #11 0x55c6553c83bf in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:348
    #12 0x55c6553c8b8f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:398
    #13 0x55c6553c90e5 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:442
    #14 0x55c6553c9851 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:549
    #15 0x7f3c91cadca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x7f3c91cadd64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #17 0x55c65512e310 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf+0x1048310) (BuildId: 07c75edf5764b1417259ec0a6cb5fc6de1859c88)

Direct leak of 65536 byte(s) in 1024 object(s) allocated from:
    #0 0x7f3c9bf85c57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x55c6557f9c76 in do_read_string util/header.c:261
    #2 0x55c65581ea1c in process_cpu_domain_info util/header.c:3642
    #3 0x55c6558269f3 in perf_file_section__process util/header.c:4386
    #4 0x55c655823fb5 in perf_header__process_sections util/header.c:4144
    #5 0x55c655828ef1 in perf_session__read_header util/header.c:4620
    #6 0x55c655884802 in perf_session__open util/session.c:54
    #7 0x55c655885a98 in __perf_session__new util/session.c:168
    #8 0x55c6551528d3 in perf_session__new util/session.h:116
    #9 0x55c655152d1f in __cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:46
    #10 0x55c655153e1a in cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:101
    #11 0x55c6553c83bf in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:348
    #12 0x55c6553c8b8f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:398
    #13 0x55c6553c90e5 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:442
    #14 0x55c6553c9851 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:549
    #15 0x7f3c91cadca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x7f3c91cadd64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #17 0x55c65512e310 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf+0x1048310) (BuildId: 07c75edf5764b1417259ec0a6cb5fc6de1859c88)

Direct leak of 65536 byte(s) in 1024 object(s) allocated from:
    #0 0x7f3c9bf85c57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x55c6557f9c76 in do_read_string util/header.c:261
    #2 0x55c65581ee44 in process_cpu_domain_info util/header.c:3662
    #3 0x55c6558269f3 in perf_file_section__process util/header.c:4386
    #4 0x55c655823fb5 in perf_header__process_sections util/header.c:4144
    #5 0x55c655828ef1 in perf_session__read_header util/header.c:4620
    #6 0x55c655884802 in perf_session__open util/session.c:54
    #7 0x55c655885a98 in __perf_session__new util/session.c:168
    #8 0x55c6551528d3 in perf_session__new util/session.h:116
    #9 0x55c655152d1f in __cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:46
    #10 0x55c655153e1a in cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:101
    #11 0x55c6553c83bf in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:348
    #12 0x55c6553c8b8f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:398
    #13 0x55c6553c90e5 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:442
    #14 0x55c6553c9851 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:549
    #15 0x7f3c91cadca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x7f3c91cadd64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #17 0x55c65512e310 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf+0x1048310) (BuildId: 07c75edf5764b1417259ec0a6cb5fc6de1859c88)

Direct leak of 10532 byte(s) in 1024 object(s) allocated from:
    #0 0x7f3c9bf85610 in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x55c6553f4d0c in zalloc ../../lib/zalloc.c:8
    #2 0x55c65581ee93 in process_cpu_domain_info util/header.c:3666
    #3 0x55c6558269f3 in perf_file_section__process util/header.c:4386
    #4 0x55c655823fb5 in perf_header__process_sections util/header.c:4144
    #5 0x55c655828ef1 in perf_session__read_header util/header.c:4620
    #6 0x55c655884802 in perf_session__open util/session.c:54
    #7 0x55c655885a98 in __perf_session__new util/session.c:168
    #8 0x55c6551528d3 in perf_session__new util/session.h:116
    #9 0x55c655152d1f in __cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:46
    #10 0x55c655153e1a in cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:101
    #11 0x55c6553c83bf in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:348
    #12 0x55c6553c8b8f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:398
    #13 0x55c6553c90e5 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:442
    #14 0x55c6553c9851 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:549
    #15 0x7f3c91cadca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x7f3c91cadd64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #17 0x55c65512e310 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf+0x1048310) (BuildId: 07c75edf5764b1417259ec0a6cb5fc6de1859c88)

Direct leak of 4352 byte(s) in 1024 object(s) allocated from:
    #0 0x7f3c9bf85610 in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x55c6553f4d0c in zalloc ../../lib/zalloc.c:8
    #2 0x55c65581ea6b in process_cpu_domain_info util/header.c:3646
    #3 0x55c6558269f3 in perf_file_section__process util/header.c:4386
    #4 0x55c655823fb5 in perf_header__process_sections util/header.c:4144
    #5 0x55c655828ef1 in perf_session__read_header util/header.c:4620
    #6 0x55c655884802 in perf_session__open util/session.c:54
    #7 0x55c655885a98 in __perf_session__new util/session.c:168
    #8 0x55c6551528d3 in perf_session__new util/session.h:116
    #9 0x55c655152d1f in __cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:46
    #10 0x55c655153e1a in cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:101
    #11 0x55c6553c83bf in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:348
    #12 0x55c6553c8b8f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:398
    #13 0x55c6553c90e5 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:442
    #14 0x55c6553c9851 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:549
    #15 0x7f3c91cadca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x7f3c91cadd64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #17 0x55c65512e310 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf+0x1048310) (BuildId: 07c75edf5764b1417259ec0a6cb5fc6de1859c88)

SUMMARY: AddressSanitizer: 350756 byte(s) leaked in 6144 allocation(s).
Simple evlist [Failed to list event]
Group evlist test

=================================================================
==15528==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 131072 byte(s) in 1024 object(s) allocated from:
    #0 0x7efcde5dfc57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x56040444bc76 in do_read_string util/header.c:261
    #2 0x560404470c30 in process_cpu_domain_info util/header.c:3653
    #3 0x5604044789f3 in perf_file_section__process util/header.c:4386
    #4 0x560404475fb5 in perf_header__process_sections util/header.c:4144
    #5 0x56040447aef1 in perf_session__read_header util/header.c:4620
    #6 0x5604044d6802 in perf_session__open util/session.c:54
    #7 0x5604044d7a98 in __perf_session__new util/session.c:168
    #8 0x560403da48d3 in perf_session__new util/session.h:116
    #9 0x560403da4d1f in __cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:46
    #10 0x560403da5e1a in cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:101
    #11 0x56040401a3bf in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:348
    #12 0x56040401ab8f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:398
    #13 0x56040401b0e5 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:442
    #14 0x56040401b851 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:549
    #15 0x7efcd4307ca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x7efcd4307d64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #17 0x560403d80310 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf+0x1048310) (BuildId: 07c75edf5764b1417259ec0a6cb5fc6de1859c88)

Direct leak of 73728 byte(s) in 1024 object(s) allocated from:
    #0 0x7efcde5df610 in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x560404046d0c in zalloc ../../lib/zalloc.c:8
    #2 0x560404470c7f in process_cpu_domain_info util/header.c:3657
    #3 0x5604044789f3 in perf_file_section__process util/header.c:4386
    #4 0x560404475fb5 in perf_header__process_sections util/header.c:4144
    #5 0x56040447aef1 in perf_session__read_header util/header.c:4620
    #6 0x5604044d6802 in perf_session__open util/session.c:54
    #7 0x5604044d7a98 in __perf_session__new util/session.c:168
    #8 0x560403da48d3 in perf_session__new util/session.h:116
    #9 0x560403da4d1f in __cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:46
    #10 0x560403da5e1a in cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:101
    #11 0x56040401a3bf in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:348
    #12 0x56040401ab8f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:398
    #13 0x56040401b0e5 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:442
    #14 0x56040401b851 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:549
    #15 0x7efcd4307ca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x7efcd4307d64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #17 0x560403d80310 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf+0x1048310) (BuildId: 07c75edf5764b1417259ec0a6cb5fc6de1859c88)

Direct leak of 65536 byte(s) in 1024 object(s) allocated from:
    #0 0x7efcde5dfc57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x56040444bc76 in do_read_string util/header.c:261
    #2 0x560404470a1c in process_cpu_domain_info util/header.c:3642
    #3 0x5604044789f3 in perf_file_section__process util/header.c:4386
    #4 0x560404475fb5 in perf_header__process_sections util/header.c:4144
    #5 0x56040447aef1 in perf_session__read_header util/header.c:4620
    #6 0x5604044d6802 in perf_session__open util/session.c:54
    #7 0x5604044d7a98 in __perf_session__new util/session.c:168
    #8 0x560403da48d3 in perf_session__new util/session.h:116
    #9 0x560403da4d1f in __cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:46
    #10 0x560403da5e1a in cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:101
    #11 0x56040401a3bf in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:348
    #12 0x56040401ab8f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:398
    #13 0x56040401b0e5 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:442
    #14 0x56040401b851 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:549
    #15 0x7efcd4307ca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x7efcd4307d64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #17 0x560403d80310 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf+0x1048310) (BuildId: 07c75edf5764b1417259ec0a6cb5fc6de1859c88)

Direct leak of 65536 byte(s) in 1024 object(s) allocated from:
    #0 0x7efcde5dfc57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x56040444bc76 in do_read_string util/header.c:261
    #2 0x560404470e44 in process_cpu_domain_info util/header.c:3662
    #3 0x5604044789f3 in perf_file_section__process util/header.c:4386
    #4 0x560404475fb5 in perf_header__process_sections util/header.c:4144
    #5 0x56040447aef1 in perf_session__read_header util/header.c:4620
    #6 0x5604044d6802 in perf_session__open util/session.c:54
    #7 0x5604044d7a98 in __perf_session__new util/session.c:168
    #8 0x560403da48d3 in perf_session__new util/session.h:116
    #9 0x560403da4d1f in __cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:46
    #10 0x560403da5e1a in cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:101
    #11 0x56040401a3bf in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:348
    #12 0x56040401ab8f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:398
    #13 0x56040401b0e5 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:442
    #14 0x56040401b851 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:549
    #15 0x7efcd4307ca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x7efcd4307d64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #17 0x560403d80310 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf+0x1048310) (BuildId: 07c75edf5764b1417259ec0a6cb5fc6de1859c88)

Direct leak of 10532 byte(s) in 1024 object(s) allocated from:
    #0 0x7efcde5df610 in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x560404046d0c in zalloc ../../lib/zalloc.c:8
    #2 0x560404470e93 in process_cpu_domain_info util/header.c:3666
    #3 0x5604044789f3 in perf_file_section__process util/header.c:4386
    #4 0x560404475fb5 in perf_header__process_sections util/header.c:4144
    #5 0x56040447aef1 in perf_session__read_header util/header.c:4620
    #6 0x5604044d6802 in perf_session__open util/session.c:54
    #7 0x5604044d7a98 in __perf_session__new util/session.c:168
    #8 0x560403da48d3 in perf_session__new util/session.h:116
    #9 0x560403da4d1f in __cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:46
    #10 0x560403da5e1a in cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:101
    #11 0x56040401a3bf in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:348
    #12 0x56040401ab8f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:398
    #13 0x56040401b0e5 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:442
    #14 0x56040401b851 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:549
    #15 0x7efcd4307ca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x7efcd4307d64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #17 0x560403d80310 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf+0x1048310) (BuildId: 07c75edf5764b1417259ec0a6cb5fc6de1859c88)

Direct leak of 4352 byte(s) in 1024 object(s) allocated from:
    #0 0x7efcde5df610 in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x560404046d0c in zalloc ../../lib/zalloc.c:8
    #2 0x560404470a6b in process_cpu_domain_info util/header.c:3646
    #3 0x5604044789f3 in perf_file_section__process util/header.c:4386
    #4 0x560404475fb5 in perf_header__process_sections util/header.c:4144
    #5 0x56040447aef1 in perf_session__read_header util/header.c:4620
    #6 0x5604044d6802 in perf_session__open util/session.c:54
    #7 0x5604044d7a98 in __perf_session__new util/session.c:168
    #8 0x560403da48d3 in perf_session__new util/session.h:116
    #9 0x560403da4d1f in __cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:46
    #10 0x560403da5e1a in cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:101
    #11 0x56040401a3bf in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:348
    #12 0x56040401ab8f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:398
    #13 0x56040401b0e5 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:442
    #14 0x56040401b851 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:549
    #15 0x7efcd4307ca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x7efcd4307d64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #17 0x560403d80310 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf+0x1048310) (BuildId: 07c75edf5764b1417259ec0a6cb5fc6de1859c88)

SUMMARY: AddressSanitizer: 350756 byte(s) leaked in 6144 allocation(s).
Group evlist [Failed to list event group]
Event configuration evlist test

=================================================================
==15547==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 131072 byte(s) in 1024 object(s) allocated from:
    #0 0x7f6169abfc57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x559f7b345c76 in do_read_string util/header.c:261
    #2 0x559f7b36ac30 in process_cpu_domain_info util/header.c:3653
    #3 0x559f7b3729f3 in perf_file_section__process util/header.c:4386
    #4 0x559f7b36ffb5 in perf_header__process_sections util/header.c:4144
    #5 0x559f7b374ef1 in perf_session__read_header util/header.c:4620
    #6 0x559f7b3d0802 in perf_session__open util/session.c:54
    #7 0x559f7b3d1a98 in __perf_session__new util/session.c:168
    #8 0x559f7ac9e8d3 in perf_session__new util/session.h:116
    #9 0x559f7ac9ed1f in __cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:46
    #10 0x559f7ac9fe1a in cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:101
    #11 0x559f7af143bf in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:348
    #12 0x559f7af14b8f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:398
    #13 0x559f7af150e5 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:442
    #14 0x559f7af15851 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:549
    #15 0x7f615f7e7ca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x7f615f7e7d64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #17 0x559f7ac7a310 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf+0x1048310) (BuildId: 07c75edf5764b1417259ec0a6cb5fc6de1859c88)

Direct leak of 73728 byte(s) in 1024 object(s) allocated from:
    #0 0x7f6169abf610 in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x559f7af40d0c in zalloc ../../lib/zalloc.c:8
    #2 0x559f7b36ac7f in process_cpu_domain_info util/header.c:3657
    #3 0x559f7b3729f3 in perf_file_section__process util/header.c:4386
    #4 0x559f7b36ffb5 in perf_header__process_sections util/header.c:4144
    #5 0x559f7b374ef1 in perf_session__read_header util/header.c:4620
    #6 0x559f7b3d0802 in perf_session__open util/session.c:54
    #7 0x559f7b3d1a98 in __perf_session__new util/session.c:168
    #8 0x559f7ac9e8d3 in perf_session__new util/session.h:116
    #9 0x559f7ac9ed1f in __cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:46
    #10 0x559f7ac9fe1a in cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:101
    #11 0x559f7af143bf in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:348
    #12 0x559f7af14b8f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:398
    #13 0x559f7af150e5 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:442
    #14 0x559f7af15851 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:549
    #15 0x7f615f7e7ca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x7f615f7e7d64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #17 0x559f7ac7a310 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf+0x1048310) (BuildId: 07c75edf5764b1417259ec0a6cb5fc6de1859c88)

Direct leak of 65536 byte(s) in 1024 object(s) allocated from:
    #0 0x7f6169abfc57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x559f7b345c76 in do_read_string util/header.c:261
    #2 0x559f7b36aa1c in process_cpu_domain_info util/header.c:3642
    #3 0x559f7b3729f3 in perf_file_section__process util/header.c:4386
    #4 0x559f7b36ffb5 in perf_header__process_sections util/header.c:4144
    #5 0x559f7b374ef1 in perf_session__read_header util/header.c:4620
    #6 0x559f7b3d0802 in perf_session__open util/session.c:54
    #7 0x559f7b3d1a98 in __perf_session__new util/session.c:168
    #8 0x559f7ac9e8d3 in perf_session__new util/session.h:116
    #9 0x559f7ac9ed1f in __cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:46
    #10 0x559f7ac9fe1a in cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:101
    #11 0x559f7af143bf in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:348
    #12 0x559f7af14b8f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:398
    #13 0x559f7af150e5 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:442
    #14 0x559f7af15851 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:549
    #15 0x7f615f7e7ca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x7f615f7e7d64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #17 0x559f7ac7a310 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf+0x1048310) (BuildId: 07c75edf5764b1417259ec0a6cb5fc6de1859c88)

Direct leak of 65536 byte(s) in 1024 object(s) allocated from:
    #0 0x7f6169abfc57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x559f7b345c76 in do_read_string util/header.c:261
    #2 0x559f7b36ae44 in process_cpu_domain_info util/header.c:3662
    #3 0x559f7b3729f3 in perf_file_section__process util/header.c:4386
    #4 0x559f7b36ffb5 in perf_header__process_sections util/header.c:4144
    #5 0x559f7b374ef1 in perf_session__read_header util/header.c:4620
    #6 0x559f7b3d0802 in perf_session__open util/session.c:54
    #7 0x559f7b3d1a98 in __perf_session__new util/session.c:168
    #8 0x559f7ac9e8d3 in perf_session__new util/session.h:116
    #9 0x559f7ac9ed1f in __cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:46
    #10 0x559f7ac9fe1a in cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:101
    #11 0x559f7af143bf in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:348
    #12 0x559f7af14b8f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:398
    #13 0x559f7af150e5 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:442
    #14 0x559f7af15851 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:549
    #15 0x7f615f7e7ca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x7f615f7e7d64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #17 0x559f7ac7a310 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf+0x1048310) (BuildId: 07c75edf5764b1417259ec0a6cb5fc6de1859c88)

Direct leak of 10532 byte(s) in 1024 object(s) allocated from:
    #0 0x7f6169abf610 in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x559f7af40d0c in zalloc ../../lib/zalloc.c:8
    #2 0x559f7b36ae93 in process_cpu_domain_info util/header.c:3666
    #3 0x559f7b3729f3 in perf_file_section__process util/header.c:4386
    #4 0x559f7b36ffb5 in perf_header__process_sections util/header.c:4144
    #5 0x559f7b374ef1 in perf_session__read_header util/header.c:4620
    #6 0x559f7b3d0802 in perf_session__open util/session.c:54
    #7 0x559f7b3d1a98 in __perf_session__new util/session.c:168
    #8 0x559f7ac9e8d3 in perf_session__new util/session.h:116
    #9 0x559f7ac9ed1f in __cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:46
    #10 0x559f7ac9fe1a in cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:101
    #11 0x559f7af143bf in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:348
    #12 0x559f7af14b8f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:398
    #13 0x559f7af150e5 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:442
    #14 0x559f7af15851 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:549
    #15 0x7f615f7e7ca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x7f615f7e7d64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #17 0x559f7ac7a310 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf+0x1048310) (BuildId: 07c75edf5764b1417259ec0a6cb5fc6de1859c88)

Direct leak of 4352 byte(s) in 1024 object(s) allocated from:
    #0 0x7f6169abf610 in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x559f7af40d0c in zalloc ../../lib/zalloc.c:8
    #2 0x559f7b36aa6b in process_cpu_domain_info util/header.c:3646
    #3 0x559f7b3729f3 in perf_file_section__process util/header.c:4386
    #4 0x559f7b36ffb5 in perf_header__process_sections util/header.c:4144
    #5 0x559f7b374ef1 in perf_session__read_header util/header.c:4620
    #6 0x559f7b3d0802 in perf_session__open util/session.c:54
    #7 0x559f7b3d1a98 in __perf_session__new util/session.c:168
    #8 0x559f7ac9e8d3 in perf_session__new util/session.h:116
    #9 0x559f7ac9ed1f in __cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:46
    #10 0x559f7ac9fe1a in cmd_evlist /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-evlist.c:101
    #11 0x559f7af143bf in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:348
    #12 0x559f7af14b8f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:398
    #13 0x559f7af150e5 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:442
    #14 0x559f7af15851 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:549
    #15 0x7f615f7e7ca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x7f615f7e7d64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #17 0x559f7ac7a310 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf+0x1048310) (BuildId: 07c75edf5764b1417259ec0a6cb5fc6de1859c88)

SUMMARY: AddressSanitizer: 350756 byte(s) leaked in 6144 allocation(s).
Event configuration evlist [Failed to list verbose info]
---- end(-1) ----
 85: perf evlist tests                                               : FAILED!


...


2026-01-24 13:56:27 sudo ASAN_OPTIONS=fast_unwind_on_malloc=0 /usr/src/linux-perf-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf test 87 -v
 87: perf header tests                                               : Running (1 active)
--- start ---
test child forked, pid 15636
Test perf header file
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.213 MB /tmp/__perf_test_header.perf.data.LAgPK (4662 samples) ]

=================================================================
==15661==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 131072 byte(s) in 1024 object(s) allocated from:
    #0 0x7f5bd6234c57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x55684cf14c76 in do_read_string util/header.c:261
    #2 0x55684cf39c30 in process_cpu_domain_info util/header.c:3653
    #3 0x55684cf419f3 in perf_file_section__process util/header.c:4386
    #4 0x55684cf3efb5 in perf_header__process_sections util/header.c:4144
    #5 0x55684cf43ef1 in perf_session__read_header util/header.c:4620
    #6 0x55684cf9f802 in perf_session__open util/session.c:54
    #7 0x55684cfa0a98 in __perf_session__new util/session.c:168
    #8 0x55684c8cf199 in perf_session__new util/session.h:116
    #9 0x55684c8e5d65 in cmd_report /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-report.c:1629
    #10 0x55684cae33bf in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:348
    #11 0x55684cae3b8f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:398
    #12 0x55684cae40e5 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:442
    #13 0x55684cae4851 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:549
    #14 0x7f5bcbf5cca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #15 0x7f5bcbf5cd64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x55684c849310 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf+0x1048310) (BuildId: 07c75edf5764b1417259ec0a6cb5fc6de1859c88)

Direct leak of 73728 byte(s) in 1024 object(s) allocated from:
    #0 0x7f5bd6234610 in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x55684cb0fd0c in zalloc ../../lib/zalloc.c:8
    #2 0x55684cf39c7f in process_cpu_domain_info util/header.c:3657
    #3 0x55684cf419f3 in perf_file_section__process util/header.c:4386
    #4 0x55684cf3efb5 in perf_header__process_sections util/header.c:4144
    #5 0x55684cf43ef1 in perf_session__read_header util/header.c:4620
    #6 0x55684cf9f802 in perf_session__open util/session.c:54
    #7 0x55684cfa0a98 in __perf_session__new util/session.c:168
    #8 0x55684c8cf199 in perf_session__new util/session.h:116
    #9 0x55684c8e5d65 in cmd_report /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-report.c:1629
    #10 0x55684cae33bf in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:348
    #11 0x55684cae3b8f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:398
    #12 0x55684cae40e5 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:442
    #13 0x55684cae4851 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:549
    #14 0x7f5bcbf5cca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #15 0x7f5bcbf5cd64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x55684c849310 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf+0x1048310) (BuildId: 07c75edf5764b1417259ec0a6cb5fc6de1859c88)

Direct leak of 65536 byte(s) in 1024 object(s) allocated from:
    #0 0x7f5bd6234c57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x55684cf14c76 in do_read_string util/header.c:261
    #2 0x55684cf39a1c in process_cpu_domain_info util/header.c:3642
    #3 0x55684cf419f3 in perf_file_section__process util/header.c:4386
    #4 0x55684cf3efb5 in perf_header__process_sections util/header.c:4144
    #5 0x55684cf43ef1 in perf_session__read_header util/header.c:4620
    #6 0x55684cf9f802 in perf_session__open util/session.c:54
    #7 0x55684cfa0a98 in __perf_session__new util/session.c:168
    #8 0x55684c8cf199 in perf_session__new util/session.h:116
    #9 0x55684c8e5d65 in cmd_report /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-report.c:1629
    #10 0x55684cae33bf in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:348
    #11 0x55684cae3b8f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:398
    #12 0x55684cae40e5 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:442
    #13 0x55684cae4851 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:549
    #14 0x7f5bcbf5cca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #15 0x7f5bcbf5cd64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x55684c849310 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf+0x1048310) (BuildId: 07c75edf5764b1417259ec0a6cb5fc6de1859c88)

Direct leak of 65536 byte(s) in 1024 object(s) allocated from:
    #0 0x7f5bd6234c57 in malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:69
    #1 0x55684cf14c76 in do_read_string util/header.c:261
    #2 0x55684cf39e44 in process_cpu_domain_info util/header.c:3662
    #3 0x55684cf419f3 in perf_file_section__process util/header.c:4386
    #4 0x55684cf3efb5 in perf_header__process_sections util/header.c:4144
    #5 0x55684cf43ef1 in perf_session__read_header util/header.c:4620
    #6 0x55684cf9f802 in perf_session__open util/session.c:54
    #7 0x55684cfa0a98 in __perf_session__new util/session.c:168
    #8 0x55684c8cf199 in perf_session__new util/session.h:116
    #9 0x55684c8e5d65 in cmd_report /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-report.c:1629
    #10 0x55684cae33bf in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:348
    #11 0x55684cae3b8f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:398
    #12 0x55684cae40e5 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:442
    #13 0x55684cae4851 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:549
    #14 0x7f5bcbf5cca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #15 0x7f5bcbf5cd64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x55684c849310 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf+0x1048310) (BuildId: 07c75edf5764b1417259ec0a6cb5fc6de1859c88)

Direct leak of 10532 byte(s) in 1024 object(s) allocated from:
    #0 0x7f5bd6234610 in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x55684cb0fd0c in zalloc ../../lib/zalloc.c:8
    #2 0x55684cf39e93 in process_cpu_domain_info util/header.c:3666
    #3 0x55684cf419f3 in perf_file_section__process util/header.c:4386
    #4 0x55684cf3efb5 in perf_header__process_sections util/header.c:4144
    #5 0x55684cf43ef1 in perf_session__read_header util/header.c:4620
    #6 0x55684cf9f802 in perf_session__open util/session.c:54
    #7 0x55684cfa0a98 in __perf_session__new util/session.c:168
    #8 0x55684c8cf199 in perf_session__new util/session.h:116
    #9 0x55684c8e5d65 in cmd_report /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-report.c:1629
    #10 0x55684cae33bf in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:348
    #11 0x55684cae3b8f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:398
    #12 0x55684cae40e5 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:442
    #13 0x55684cae4851 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:549
    #14 0x7f5bcbf5cca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #15 0x7f5bcbf5cd64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x55684c849310 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf+0x1048310) (BuildId: 07c75edf5764b1417259ec0a6cb5fc6de1859c88)

Direct leak of 4352 byte(s) in 1024 object(s) allocated from:
    #0 0x7f5bd6234610 in calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
    #1 0x55684cb0fd0c in zalloc ../../lib/zalloc.c:8
    #2 0x55684cf39a6b in process_cpu_domain_info util/header.c:3646
    #3 0x55684cf419f3 in perf_file_section__process util/header.c:4386
    #4 0x55684cf3efb5 in perf_header__process_sections util/header.c:4144
    #5 0x55684cf43ef1 in perf_session__read_header util/header.c:4620
    #6 0x55684cf9f802 in perf_session__open util/session.c:54
    #7 0x55684cfa0a98 in __perf_session__new util/session.c:168
    #8 0x55684c8cf199 in perf_session__new util/session.h:116
    #9 0x55684c8e5d65 in cmd_report /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/builtin-report.c:1629
    #10 0x55684cae33bf in run_builtin /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:348
    #11 0x55684cae3b8f in handle_internal_command /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:398
    #12 0x55684cae40e5 in run_argv /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:442
    #13 0x55684cae4851 in main /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf.c:549
    #14 0x7f5bcbf5cca7  (/lib/x86_64-linux-gnu/libc.so.6+0x29ca7) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #15 0x7f5bcbf5cd64 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x29d64) (BuildId: def5460e3cee00bfee25b429c97bcc4853e5b3a8)
    #16 0x55684c849310 in _start (/usr/src/perf_selftests-x86_64-rhel-9.4-bpf-6f993818d20c79b874f546cec1dcce40a9927c7b/tools/perf/perf+0x1048310) (BuildId: 07c75edf5764b1417259ec0a6cb5fc6de1859c88)

SUMMARY: AddressSanitizer: 350756 byte(s) leaked in 6144 allocation(s).
Unexpected signal in test_file
---- end(-1) ----
 87: perf header tests                                               : FAILED!



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260126/202601262235.ee84b79e-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

