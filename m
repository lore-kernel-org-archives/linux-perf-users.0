Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1F84825AE;
	Thu, 24 Sep 2026 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254852; cv=fail; b=iZ4RX8kmd58prZyX0WXUopZ20zVD69X6pySABTCYsBr9cq6nS/MpjDI5bX9gBzEluI7+4A9lY4Bo/6XVoEHrtIy8E/aY2l7P8oF2b6OH9bcnY3dIOYmkE24r1t6ZjQO/2Es6u2EHJedybg4TPSPMJlnh7ynGxVD1m0Udi6oZsZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254852; c=relaxed/simple;
	bh=R2wsCzTYITTdXZW2yVDZCokU0UVJIl15ii0OP63ZV/A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KjRGa0PtdtaHmgWEKa+RUTCtJ9YzW8WI952tDKVAMlt7NCJNAnqjJWfLIXh8iIi/Qtnmmmtuiyqd5ZkaXMoQ6pOBqN0wKvL4Mhvs16boGlLg5iwxHoN54y63xX2Fui+ai4nHf9vGjfb5Ohi3kEEW8BhyDLlFECJcW1+dsKQ5gKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iQvy76Tl; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iQvy76Tl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790254851; x=1821790851;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R2wsCzTYITTdXZW2yVDZCokU0UVJIl15ii0OP63ZV/A=;
  b=iQvy76TljRrYyc6U5E56ifXJdysH6butel431Aw25alZdNoZPMH8Uho1
   JvwZV/hbfD0sGptiuRIo0xMecqj9iQ03IYOcW6ycGrBCJ+fnP/JLFUlGM
   JIE0geqPVLUhse3R87oxY4oefz/Xujleqg25Gc9V9qGzAU18sOveuz4dj
   xTySUdKubPhbDehqRWp18uGl1DzXwbPmIPl9zBI1LpLW7KCCBVJRhfZt7
   x+/O2hoY9ikdoROcoMnIQ238xsWoMBJXA9dKWPQGiUySsg7VgvGPG8GJS
   mICtqngB+xhzOGbVT2lNwJNWglp6BDajn3Subj6qnnHph0RpQfpj/o5pw
   g==;
X-CSE-ConnectionGUID: gwFjz1IcSKyC4EEc/GlaaQ==
X-CSE-MsgGUID: 7y79oyQMQ8+XQgWH4ToqBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="101554511"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="101554511"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 06:00:50 -0700
X-CSE-ConnectionGUID: QWYoo6e1RbOMAr0Hkz+fWw==
X-CSE-MsgGUID: dxbJcGl0Qk6pzeT+g6tWXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="272607524"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 06:00:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 06:00:49 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 06:00:49 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.41) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 06:00:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwGIQSKKMBsl0okmW1xCVlSfXUKhLcKSJIT4rX+ZXqSyqgJDtWhq00aWfmTR/ufIy5u8yJI2Q68nEab/eZqm0h0RKhrrUtdL8XkAnp3bnw749cOGsH5l9Qag1BTFG+/vVqgh+c3v5krRv5uP2wcQ+PRe5andypzU5lsaHtZKylWcMVBsZ2wDIvJqFMnWkLPu2Z4OeSWkTTkUuq6eVNGxZnZTYv9Eb7RoRjGpNcDRRMjduqKjalY39X13zMG5NnxT2qRHNvVjE3GYAjs6K+rM8hpBd2Cmv6PcZfgU1ub4jJZg/Fj5/uSofXEq+RX49xYC4Yz1+z/ZXqtV7a/jE5dWCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xy6plm/pFB0arnMc4X9zldXpdYPvSal8eCyDTydq9JE=;
 b=zKgMgivY42ymjnzTyEc+3YnwQR+M8E2+RGmaC53W/TtLBNranezTEu5/uCdiS1pRrDnDVCs61fbh4zkw1LwqeQNGBXtwGgREqA7+ylFmAMsPETB+/mjvKaZIiCGdnAM2MZP9//3ytw7zJyltn0IFQMx72XwPEADob7l5F5ms/63bSb5I355yvGYhKZVU/P+juqrSeP8UiDHvTkebGFDFBluQwZQ5+pgZuGyuhSefZ8E6KFi3Gv210QqzHEFO9jjshCGuCDa3TfO4bOKN4cCngYje5dhsyphj61TbuDcAHISXYoNz0Edg9C3Xo6g6JqSgHVZaUxCqHPt/jP9GqDqXWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by CH8PR11MB407363.namprd11.prod.outlook.com (2603:10b6:610:32d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 13:00:46 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 13:00:45 +0000
Message-ID: <7f046a93-1739-49b0-abe9-c742866e9df3@intel.com>
Date: Thu, 24 Sep 2026 16:00:39 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] perf sample: Allow decoders to supply branch
 return addresses
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers
	<irogers@google.com>, James Clark <james.clark@linaro.org>, Mike Leach
	<mike.leach@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Suyash Mahar
	<smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
CC: Arnaldo Carvalho de Melo <acme@redhat.com>, <coresight@lists.linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
 <20260923-perf_cs_etm_fix_non_taken-v2-1-6ab8c07a5455@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260923-perf_cs_etm_fix_non_taken-v2-1-6ab8c07a5455@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0011.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::19) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|CH8PR11MB407363:EE_
X-MS-Office365-Filtering-Correlation-Id: b6335a2d-7e71-40bf-a0fb-08df1a3bd8ee
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|10067099003|56012099006|6133799003|3023799007|18002099003|22082099003|4143699003|11063799006|921020;
X-Microsoft-Antispam-Message-Info: dbCP5e18AUBGIDc4hdvVJpLI36xJhDiWWOAZpqCDlMxhgxKkw1Z42sZiX7wWl1gM/AjrYrGopGYAb7rHLKtYrPTQY+B25W2DR8P7UJGCjZqSurB+MMubDiKhATBJbwkLiNxp13xDFJy/MVOraa8Q6If46V8Z2xZTCalw+SBw7I7KqccQEKJ4VssbhDRHghOK0BrbGXK/OrIFp9cHJnfcyIntUL1TG3QZdndpxZkybWguLYMJlMcZbxAEztqSIjNIJ/RxeCfCNcCtjHjAiImCHCMyo0cGLQvjfDfqPvJsqUCBf/MrQC2jqp282UO2pZ8X3VOBn5/U4JafXTmOQswRvkp3iMzKJEDUGMGqY0xWfMM7MY+TU4ReTvutVZ5lyrhr8TZuXUeHHfU14Z6Q6yUvhtr5AY85BB4OBoi+GVv8XHk5oi2A4zKv5ojZ0Gyp6htw2vzffhDRzSYyQaA+UmXAFEJYaFUYZOokwZ9U1D+D+bWbDvcXhdrcTN3DKtpsacbit2VL+WtmBa58Ij+4WsjOvqf0ntgfCyfTAn7HrZnxNr1Ke3akdfRJpbmx1G9yX4o/mxHSEEYD8wkSAewDFECCr/UwXQyZq2bdpQ5hqKFyoE2kOL0FRJkV+sWS0OswSziuV/H9epId6mcEZnIU2XXQzLZ8XOX58Q6eoINrNLGF9ViTPMw4BWbq08ZehXndfcMCdQF6H8nJynFwD2TepUCX/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(10067099003)(56012099006)(6133799003)(3023799007)(18002099003)(22082099003)(4143699003)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXpQUllGbHlnK1F4SkZIV0tHbEpkRG0veS9NZkpJUU5ha2dMTGZ5ZHJXY1BX?=
 =?utf-8?B?RThZZDVjWmp0YTgwc2l4QXNmNVlZbytNRVVMZUVtTStqWEF0K25VYmtQRTVQ?=
 =?utf-8?B?dlJUZ2R0MXFlNkQ4WlZRYU5qUlFqVUxUOVR2clRiZ2o1cDQyWTNoMTBGOWp4?=
 =?utf-8?B?UFV1TkpVWnV4T0wvTktrMkQ5ZW9iOWlPZyttNHdQTmx6b3FyRzFxN2VEcjlT?=
 =?utf-8?B?SXBtNzJmOG9DenpySmFMMk1vZ3UzRmVQZVQxbTBrWFpkSTk2WEI4OUJuekxC?=
 =?utf-8?B?dVA0Vk1CeldNc1lHbktnNktpOVFLa2pwR1EwTC9yZjk0d2psU2tEd1FFRGJP?=
 =?utf-8?B?cjhZQjVYWHE5Q0VRdzhibUVnNjJnNEMyZ0Y4MWxia0RMam1OYnM4cnJuZXd5?=
 =?utf-8?B?bjdRY2VhYkV2Z1BkSm4vWUdwOCtLSVppYkl6bDVPcStSVWdRaG40WE1HRnox?=
 =?utf-8?B?cDY5QjN6ZExEeFVjTW1Db0RpY0NRTGdaRTlDbnh4amRoUXdwbUJYek5lQTY1?=
 =?utf-8?B?Z0lLdCt0TUtTa3ArbEp6V3VSNUZrZEc0U2MweS8yWEJFdWVYckdNK2xvNm5C?=
 =?utf-8?B?Y3pEcXhmczVHelh0WW5zSk1zeDl5UThheHhwQVM5UFpHbFZHQ0lzUTVJY2M2?=
 =?utf-8?B?Vk5lY3pEL3RjazYvcy9lVHhacXJDcEx2NGVQNTZMNFZrbXZmRFc0RnlJVjZ6?=
 =?utf-8?B?R3ZlTmVob1R4LzM3QVA2dkRlZ2pOMVdZTTRuSlFEbEFTOS9GWCt2d1NvVTVy?=
 =?utf-8?B?dktUMFpycUNEZnpLZTlQWEI5cGdnNjRXTlFpU256aDF3Rk41cXA2czlJaFY3?=
 =?utf-8?B?dGc0d3Y2ODJhcjM5RjR0cHlIaVZ3bVYwNzdCTHFRL0EwL29FbmlDVnRVL05r?=
 =?utf-8?B?dnI3OVlsa2ppemp2T25BQ2R4VDllVFlWcnMrQ3VLWmRJUG85TjgzTjhKRzZB?=
 =?utf-8?B?ZUxrSjdBZjdMUTNCQ1d1SWQ5clZLMWVjZ2pxZFMzT3p6c3dKbU1IMUZJNDZK?=
 =?utf-8?B?eGJLRHdNaHNraU8ybHEyU2hraTdEZ05tS1Z5aktWU2dDbEZnWFZEek1rNXhu?=
 =?utf-8?B?aVltTUdFNEZrTENhUjBuOFJnYkpMVFk0UGQ1dVZ3VHA5WExCQjdQdS9oZVBo?=
 =?utf-8?B?Q1ZxNVk1NmhaSGFoTzZTLzV2alRFbzE1UTFQK01lUzI0S1ZHZWRQWXdiRWpC?=
 =?utf-8?B?cEFILy9HaTlpQnY3NStvYzlhaDY3bDRsZGg0MXFhVjhNRVJlQks4TTVvQjFJ?=
 =?utf-8?B?Ym4zMjE1V3grNmZIeGFwRDhmSlRRRnZpQUdrdy9NZFRYWWRtMUYvd0pMZ0Fx?=
 =?utf-8?B?WmVWMlJNY2NOaUJ5cnN4ZWh1dnNmTGEyTkRaL0NvYVFiNm5HZHNYQ0RFcTlz?=
 =?utf-8?B?d1NwZ0FScnBnOEV4UFl1L2hqYWZGVnEwYUJoV1Zuck5aZjRQTldJeUZHNlFy?=
 =?utf-8?B?S3NxOHVFL2NHeEhlbUhBMzROVGFGQVRSQkNxZXUxL2dMdXBLbkwyTFBwNi9X?=
 =?utf-8?B?aThuZVB1SnI5ZlZXRDZ5cGltT0tjU2ZudG5EZld0aWd5RHdLckkwcDJrWkp5?=
 =?utf-8?B?RFdxZk93UjRYMEF4S05vUmw5RTAveFZpRktPTlNGWElEZW1takxlYVBaenMx?=
 =?utf-8?B?R2dMTDRGcVZoUzZlTmpUM1NzWFJZTmJTNFNGMXJidEFiNkl0d2E5M1k3L3ZI?=
 =?utf-8?B?akYwaGxESERkQ3FwYTNDdmVjT0ZONDFzSWVVeG9xRWZkYXppaEJETVg0YXZP?=
 =?utf-8?B?NFY1SmVmVkJMOFVucndmN3kzNWZNdFVWVHg3VTUvOTJRVXFiM1k3dStNS2RE?=
 =?utf-8?B?Vmc3cmxaZW4xZU9PR2lETlByaDljZmF6VGI2UENBaTYyUTJ3WldTSDVSMnBl?=
 =?utf-8?B?SVZSdnRxNFNRd2w3cWh4U0piYTJaNVhxL3UxckdmL2Z6SFptS1R2bU1hSmxv?=
 =?utf-8?B?Q3R4QWFoa0ZpZm9FbEdLSnBYT1dmUjJDYlBJbVdHQTJwWVRoa1B2MW8zRHNl?=
 =?utf-8?B?WnArMDdldzdsU1BQSHRGakRxU3ZvNUdKd3VUUXV4VFBKZnVKWExkQ09OaGZL?=
 =?utf-8?B?TG5jYnd3RSs3bGpxMlR4WENJWEp4L0ZyT2V3c1d5VlY2cC9iQ1RXa1N6VXVM?=
 =?utf-8?B?aUJsTHhVWWNocUtNSDBRRUVJdjVFaHhiK25RMEZvUTNGck9pWk1EOWROMHE1?=
 =?utf-8?B?MWNBRE55dW9XOEJ6WHM5WVkzbG1XVk9QY3h4YjRxenNSUEJKWWhGTUFlN1lR?=
 =?utf-8?B?WmpsK0lGdHNtUU5Hc0c5cytSNjhBU2NEaGpXOEJmRjcwcmlocjdDN2VqdHkr?=
 =?utf-8?B?cFkrM0ozclRhUmY1NDhmYkZoTm4yemxBbjJSSmpZL0FFaS81RERNV3BUT2pS?=
 =?utf-8?Q?ct+ycISBFdEgWXbA=3D?=
X-Exchange-RoutingPolicyChecked: xxjM9n7SjGchGETUpTJDpSHWdIbNe9/qw+G934hQWnTGoh/Dlr8br095J9189icnEVco8EQDsEZcsf5wCdIvWAaB6d3Dt8n1m5sieKtsWnNBOJixd9Io66Z/Vmv4a4mWEtihSdGrI27fmqLJBK5Lookt3oUkUKh43Wzjp4FgTMyll1q4pjOxok0Zkbn5zianbjYtl1KXCplbEvyt+Bayh9j174bSupvNhoBy9Ow/7320j6oQne8PMa1Jeb2GL0rVGpaA6yHjLrdD9E13sHRGoJtKxL9+dN9WLjQlvCVlTmfIoeXziVIeY5p8GK/cmDi0D35CWYz5n6DrpKb79ge0JQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b6335a2d-7e71-40bf-a0fb-08df1a3bd8ee
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 13:00:45.7939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQ7D9iCQvwZP7V2cEie+C6JK7hQdlk2n2bReHmBNk0GTDPh6JjXZ0mEJ7YoY3EuIzj5QglrJ/BZh+YypfnDkuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB407363
X-OriginatorOrg: intel.com

On 23/09/2026 18:21, Leo Yan wrote:
> The thread stack derives return addresses from IP + insn_len. For an
> interrupt or fault, the return address can instead be the sample IP even
> when instruction bytes at that address are available.
> 
> Add ret_addr to perf_sample and prefer it in thread_stack__trace_end()
> and thread_stack__process() when supplied. Initialize it to zero so other
> samples retain the IP + insn_len calculation.
> 
> Add a regression test for explicit exception return addresses and the
> ordinary call fallback when the return address is zero.
> 
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/tests/Build          |   1 +
>  tools/perf/tests/builtin-test.c |   1 +
>  tools/perf/tests/tests.h        |   1 +
>  tools/perf/tests/thread-stack.c | 106 ++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/sample.c        |   1 +
>  tools/perf/util/sample.h        |   5 ++
>  tools/perf/util/thread-stack.c  |   5 +-
>  7 files changed, 118 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 81c311b131b72715f11b6501511a18dce2af07df..d03ae938dd0ad92f78f8de6900ce7161f39fc3bc 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -29,6 +29,7 @@ perf-test-y += task-exit.o
>  perf-test-y += sw-clock.o
>  perf-test-y += mmap-thread-lookup.o
>  perf-test-y += thread-maps-share.o
> +perf-test-y += thread-stack.o
>  perf-test-$(CONFIG_LIBTRACEEVENT) += switch-tracking.o
>  perf-test-y += keep-tracking.o
>  perf-test-y += code-reading.o
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index d2f594921e25bda9fc662e7ba82464bfef1b752b..6259ed805c5f75799d52ac742b77cf278f98bd9d 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -112,6 +112,7 @@ static struct test_suite *generic_tests[] = {
>  	&suite__hists_filter,
>  	&suite__mmap_thread_lookup,
>  	&suite__thread_maps_share,
> +	&suite__thread_stack,
>  	&suite__hists_output,
>  	&suite__hists_cumulate,
>  #ifdef HAVE_LIBTRACEEVENT
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index 9c96f33483d1435644da6068c3802f7a914a9de0..b2520a564417b61718f1dcb23da1f8cc0f601906 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -138,6 +138,7 @@ DECLARE_SUITE(expr);
>  DECLARE_SUITE(hists_filter);
>  DECLARE_SUITE(mmap_thread_lookup);
>  DECLARE_SUITE(thread_maps_share);
> +DECLARE_SUITE(thread_stack);
>  DECLARE_SUITE(hists_output);
>  DECLARE_SUITE(hists_cumulate);
>  DECLARE_SUITE(switch_tracking);
> diff --git a/tools/perf/tests/thread-stack.c b/tools/perf/tests/thread-stack.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..0239e3bee34faf8fd4ddc7b723cf479609760064
> --- /dev/null
> +++ b/tools/perf/tests/thread-stack.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/kernel.h>
> +#include <unistd.h>
> +#include "tests.h"
> +#include "util/addr_location.h"
> +#include "util/event.h"
> +#include "util/sample.h"
> +#include "util/thread.h"
> +#include "util/thread-stack.h"
> +
> +#define CALL_REF		1234UL
> +#define RET_REF			5678UL
> +
> +struct return_check {
> +	unsigned int matched;
> +	unsigned int unmatched;
> +};
> +
> +static int check_call_return(struct call_return *cr,
> +			     u64 *parent_db_id __maybe_unused, void *data)
> +{
> +	struct return_check *check = data;
> +
> +	if (cr->call_ref == CALL_REF && cr->return_ref == RET_REF && !cr->flags)
> +		check->matched++;
> +	else
> +		check->unmatched++;
> +
> +	return 0;
> +}
> +
> +/* A zero expected_ret_addr asks the stack to use ip + insn_len. */
> +static int check_return_address(u64 expected_ret_addr, u64 actual_ret_addr,
> +				u32 flags)
> +{
> +	struct call_return_processor *crp;
> +	struct return_check check = { };
> +	struct thread *thread;
> +	struct addr_location from = { }, to = { };
> +	struct perf_sample sample = { };
> +	int ret = TEST_FAIL;
> +
> +	thread = thread__new(getpid(), getpid());
> +	if (!thread)
> +		return TEST_FAIL;
> +
> +	crp = call_return_processor__new(check_call_return, &check);
> +	if (!crp)
> +		goto out;
> +
> +	sample.ip = 0x1000;		/* Call or exception source addr */
> +	sample.addr = 0x2000;		/* Callee or exception handler addr */
> +	sample.ret_addr = expected_ret_addr;
> +	sample.flags = PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | flags;
> +	sample.time = 1;
> +	/* Model the opcode length after an instruction fetch. */
> +	sample.insn_len = 4;
> +	if (thread_stack__process(thread, thread__comm(thread), &sample,
> +				  &from, &to, CALL_REF, crp))
> +		goto out;
> +
> +	sample.ip = 0x2000;		/* Return instruction addr */
> +	sample.addr = actual_ret_addr;	/* Return branch target addr */
> +	sample.ret_addr = 0;
> +	sample.flags = PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_RETURN |
> +		       (flags & (PERF_IP_FLAG_INTERRUPT | PERF_IP_FLAG_SYSCALLRET));
> +	sample.time = 2;
> +	if (thread_stack__process(thread, thread__comm(thread), &sample,
> +				  &to, &from, RET_REF, crp))
> +		goto out;
> +
> +	if (check.matched == 1 && !check.unmatched)
> +		ret = TEST_OK;
> +
> +out:
> +	thread__put(thread);
> +	call_return_processor__free(crp);
> +	return ret;
> +}
> +
> +static int test__thread_stack(struct test_suite *test __maybe_unused,
> +			      int subtest __maybe_unused)
> +{
> +	static const struct {
> +		const char *name;
> +		u64 expected_ret_addr;
> +		u64 actual_ret_addr;
> +		u32 flags;
> +	} cases[] = {
> +		{ "ordinary call", 0, 0x1004, 0 },
> +		{ "interrupt", 0x1000, 0x1000, PERF_IP_FLAG_ASYNC | PERF_IP_FLAG_INTERRUPT },
> +		{ "fault or trap", 0x1000, 0x1000, PERF_IP_FLAG_INTERRUPT },
> +		{ "SVC", 0x1004, 0x1004, PERF_IP_FLAG_SYSCALLRET },
> +	};
> +
> +	for (size_t i = 0; i < ARRAY_SIZE(cases); i++) {
> +		if (check_return_address(cases[i].expected_ret_addr,
> +					 cases[i].actual_ret_addr, cases[i].flags)) {
> +			pr_debug("Incorrect return address for %s\n", cases[i].name);
> +			return TEST_FAIL;
> +		}
> +	}
> +	return TEST_OK;
> +}
> +
> +DEFINE_SUITE("Thread stack return addresses after instruction fetching", thread_stack);
> diff --git a/tools/perf/util/sample.c b/tools/perf/util/sample.c
> index bccc19e2aaf25118a8ecde88473aa6cb16fa561a..4abb689132bc27d0f2318eeafca20f7e57621837 100644
> --- a/tools/perf/util/sample.c
> +++ b/tools/perf/util/sample.c
> @@ -29,6 +29,7 @@ void perf_sample__init(struct perf_sample *sample, bool all)
>  		sample->intr_regs = NULL;
>  		sample->merged_callchain = false;
>  		sample->callchain = NULL;
> +		sample->ret_addr = 0;
>  	}
>  }
>  
> diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
> index cb4b16654876e9a5c3bfd66be3e0235ac15795e0..865ed18200f1339f5949ef3f185ed57a34aace72 100644
> --- a/tools/perf/util/sample.h
> +++ b/tools/perf/util/sample.h
> @@ -131,6 +131,11 @@ struct perf_sample {
>  	u64 time;
>  	/** @addr: The sample event PERF_SAMPLE_ADDR value. */
>  	u64 addr;
> +	/**
> +	 * @ret_addr: Return address supplied by the decoder for a branch sample.
> +	 *            Zero means use ip + insn_len.
> +	 */
> +	u64 ret_addr;
>  	/** @id: The sample event PERF_SAMPLE_ID or PERF_SAMPLE_IDENTIFIER value. */
>  	u64 id;
>  	/** @stream_id: The sample event PERF_SAMPLE_STREAM_ID value. */
> diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
> index 1360f44421ef8bb80fe5cfdba59be7e6029b0240..d452d1a7eabb16f040ca3dada23e6fdec8fb1088 100644
> --- a/tools/perf/util/thread-stack.c
> +++ b/tools/perf/util/thread-stack.c
> @@ -1030,7 +1030,7 @@ static int thread_stack__trace_end(struct thread_stack *ts,
>  	cp = call_path__findnew(cpr, ts->stack[ts->cnt - 1].cp, NULL, 0,
>  				ts->kernel_start);
>  
> -	ret_addr = sample->ip + sample->insn_len;
> +	ret_addr = sample->ret_addr ? sample->ret_addr : sample->ip + sample->insn_len;
>  
>  	return thread_stack__push_cp(ts, ret_addr, sample->time, ref, cp,
>  				     false, true);
> @@ -1154,7 +1154,8 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
>  		if (!sample->ip || !sample->addr)
>  			return 0;
>  
> -		ret_addr = sample->ip + sample->insn_len;
> +		/* Opcode fetching must not change a decoder-supplied return address. */
> +		ret_addr = sample->ret_addr ? sample->ret_addr : sample->ip + sample->insn_len;
>  		if (ret_addr == sample->addr)
>  			return 0; /* Zero-length calls are excluded */
>  
> 

