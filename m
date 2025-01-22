Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3C71F893C
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 10:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737543155; cv=fail; b=eQ/3zT7HsM47DNy+q8Owi8P9vso735mL7qREcjtOB6iE4UI6odvjO5qC5CUh7AAdNY6+SGtcb+uYkuh0nrRm76rS1AEUGLvASJk937Fyx0z5z9Z20zapWLCYb4Hc+PGRv1OmMSTH3C1C4uPaFqXyFTzNZmrwecS4Ve9tObkgNdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737543155; c=relaxed/simple;
	bh=ej1Ps2v862+lpuh8EoGi5D6QoQ8r1pwWN1pOk2+Kdag=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PxyuzBarnvddLPIkQvijuSpz9YsCEnkMDLIv13gfBxu+4FGiMyyAcFLH9O1HNm348cKvjg6yWVJfXrJOzzcUA0iE/MmQiHc3eEwexLIz6KwdE7qwHEwDb6a8L002PQdrfI1t/8Lp9tGqygsA9ePD08G/xD2agHIkH0xbR++qmu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mYYiaXlS; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mYYiaXlS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737543153; x=1769079153;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ej1Ps2v862+lpuh8EoGi5D6QoQ8r1pwWN1pOk2+Kdag=;
  b=mYYiaXlSzJZ+h3y46zSP+RlvvPjRLJKnCrmt1qSqYgn5lcJBNFUyOCCH
   /pIFMbQXqiPQ1GnSbaH15eEQy0/HJxpmjG916Ou9IDg/+4GJBPOJ3pqEg
   tejfYcGDE0y/7TbYzF+fe/3diV+cRGmAXYemmQ10xWSaNCZrKLZki7Xid
   MF8iTedJ94d4R654yjCJU44hsUuhr9KXqhUxxv7LNI/eXKJ8RFp++UEXx
   t0/gSpGFjYM1i/PxDqjximXlFXj7z94bhXffM2WwHl7YASPzM+qGZxmYG
   wnNwGlImILuJ3aGIXZxIBOXS9TxigqqkxpEKqjsvBbXdGwjJm9o1xvinK
   w==;
X-CSE-ConnectionGUID: irOg1IKKRq+8u/Bk+fjhuw==
X-CSE-MsgGUID: NTQJRI8aT7a5YoBnR5wK1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="38096733"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="38096733"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 02:52:33 -0800
X-CSE-ConnectionGUID: rCW58mUkQga2ZtzLHC684Q==
X-CSE-MsgGUID: VNFCvoq9Tz63/7mlu2HLew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; 
   d="scan'208";a="112131480"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2025 02:52:33 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 22 Jan 2025 02:52:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 22 Jan 2025 02:52:32 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 22 Jan 2025 02:52:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwcnpH4277b4BrbcHG1+1CQ/kMYJVPwRnRqToejGKOoLqSs71etB1tEd3J4i1OdXSLbs4sPhXNQ5OBaP/uhjnvqquzPYs5j4AgKisNjqgSo6dzOSbuKkoO71VOawK/xLOR/TspK4F/U1oYjPOufu9zdOdpFS5s8VMCINoiortvYXMvnL8OuJLbOYhhdD9oDHcvpumjfaoeIM0aLKLbM+IjWuFaSVk6eGn6VtG/4h6VJUsBGqrzMASgvy012s2zDz5w/pR0O3AQe4pv9inRArr3L1d/nB0QpBIr0F1/OnjNnbN8FLJDyuwYz3uUXenLc3SZR1msDtkUVaCMBPDs76hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9HRjMlK4sLWpXO0SkcptY0TlMPtbRwK5wkmMVACZvE=;
 b=I5Imcxgzxki/iCGM5fn2QfuICbk1duB0KwKGERQnKp3xK8uUhjrfY7DmL0F5wNM0QT897pxhCPfWyfCAfcM27T9YxQu22gsWzmNiWOZMZr4S/f7RGhG+RqGyU/lVO1RY4a14NKvDouZpwIeIvzBMeNrLlrWarTZf2X5iZcTrJdpCqmkhWVNC87r6emd+/FXDuSQyMwKr2VfPSXG81d5TJiGehTSTwZouoZpR5qIqJuvIdI//3xiC6qh5bskgXXh02Ebhmiybako0Vm9apayEaXeohmI0ALfLuhkWkXFcYOXS54Sm3ykt6lqXz5mHnOKiZmhjvhmC/53tktrPb53dGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 DM3PR11MB8681.namprd11.prod.outlook.com (2603:10b6:0:49::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.21; Wed, 22 Jan 2025 10:52:02 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::d3ba:63fc:10be:dfca]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::d3ba:63fc:10be:dfca%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 10:52:02 +0000
Message-ID: <22a55c13-7833-439c-87c6-4970953f2eeb@intel.com>
Date: Wed, 22 Jan 2025 16:21:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 2/7] drm/xe/pmu: Enable PMU interface
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	<intel-xe@lists.freedesktop.org>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>, Vinay Belgaumkar
	<vinay.belgaumkar@intel.com>, Peter Zijlstra <peterz@infradead.org>,
	<linux-perf-users@vger.kernel.org>
References: <20250122062341.1100173-1-lucas.demarchi@intel.com>
 <20250122062341.1100173-3-lucas.demarchi@intel.com>
Content-Language: en-US
From: Riana Tauro <riana.tauro@intel.com>
In-Reply-To: <20250122062341.1100173-3-lucas.demarchi@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::13) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|DM3PR11MB8681:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d8cbf2f-3afe-4e2b-1dbe-08dd3ad2cd50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDh5M3piTlZOc3p4ZjlqOUdGTWNtaE5jYVBWKzdCMjg0clhFNG15S2tvTnhX?=
 =?utf-8?B?Q0JCNjM1YnB5UnpGa0JRaG1oMk9RVjNhV0Q1dWFkRFdiMVBtSVB3cnhpanJV?=
 =?utf-8?B?SnhibTlFWmtWU2FXZXI1Mk5PQzUvQzBybjR4VEdhVHF5MDZmaHkvN1IwTEFo?=
 =?utf-8?B?M2FyWDI5OHVKT0pZVjdJVFNkcFRTdFVreHBtTlcrQmJ3c0QvR24xcUtZb3J0?=
 =?utf-8?B?YmFvVnVXaXU0TFdXQ3Q4MDBOaWZna2FNM3AvU3BtOHlVUTlkS1ltNmJWR3hk?=
 =?utf-8?B?QVB0cW5Zc1BhSno1VXcybVZtdmFpUXorN04ybk5VaHM1OCtXWUh1cTA1VTV4?=
 =?utf-8?B?VjQxb3NVWEYxUWFXU21UZGk4ZmFOV0pSK2VCeEFsZmhGdldkMVJiOEdpbEI3?=
 =?utf-8?B?c0FRb3NybE9CbVBTK1I5UWZDOVFLeWpNSjRxbHlyS3FjOFhuUWJvR2JnLzZs?=
 =?utf-8?B?bUplUVI4ZGZVUkI3NXJ5Zno1K2VHUXVvRGdTalg2VERHRUlWY09iOGpBaEVK?=
 =?utf-8?B?MUsydk1VOXJWdmQ1d0lCQWgzcGJPbFIzY09DV1hQcDM1N1FIMUdGd29UTkpP?=
 =?utf-8?B?TlJKNVNaT3kwdkl0NStCV1FsZEl5WTR0OTVJd3VyZFhPVG1mNU5HNzNqWFR1?=
 =?utf-8?B?SnZqMjBsb1lVUDNRT0VBNVdOVnlmdUt6Kys5L3F0dkNicWxacFgvNllKSWlF?=
 =?utf-8?B?anQ2TTdaeDB5SURzQUVVM2dOQ3Q4V1F0ZGhiNHlUSEo5clhibTk2UzFrTkgx?=
 =?utf-8?B?TkwyTkFOVlF1UUN1eFBuN2xhSWtDellhSDZobmwzMGZ4ZFd1Z2pKVDhhaGZS?=
 =?utf-8?B?TlJVTzBjSTd1NlAraFo4bkVWY2VtczJ1TWx5a2d6M243RzVRT0RET1N1WnpT?=
 =?utf-8?B?U0hQMGFEdGFRalI5K2tVbDU0Sm52NXMyNlg3a3dERFJLYVlsaHZibVhRL1Rv?=
 =?utf-8?B?eEJmNUhyQStBa3d6RGtBQ3cvK0gxUGVRMzVpNEZOUzMyN0ZpcklVa2lUNFZT?=
 =?utf-8?B?cDJnR0FQV3lmczFwemRLaE9SbVV5YWViYlBvWlVqcU9rQnBwdDVRVG8wT3F1?=
 =?utf-8?B?V1VkdEpxTVp6dDJYTUxoTDlWR0wwWEloL2dxMzZNOUErVWtndHg5bld6ZTVW?=
 =?utf-8?B?SDVBd21OdldhYTY5M3gxU01SNktsZ3VJdit3Mlo1N1VtWWdocFYwb0YrNGhE?=
 =?utf-8?B?NFFwVTNHaTZGSkR1UFd6dnBKOHZvbHE1R1phVEVCNUc2Y212L2FQd2FjT09i?=
 =?utf-8?B?NXlDUVI5YnNTOWtnNitHTWVDdXg2a1ZtN2NUQ1lHNm1RNlRPQ1dtU0NhKzlY?=
 =?utf-8?B?d3NKYkVxcnU1ZGRJR2tPV2tuazE2OHBwNGpOOWFWakZiT2wvMTB5d2VNOUpT?=
 =?utf-8?B?Q3EwbVE3S0VtVEVsWDdLcjc1aEVsTVpieHExbHlJdFp2dld2VGs2Qm5ZUlNM?=
 =?utf-8?B?R0E3V1J6bmtSZFd3MW9sV2tVSFhFVWZsb3FPM3VKVVphYW1EZkVqei8rNndW?=
 =?utf-8?B?Rll1cDRVRTFyVTVQQ3ZFdThUSTVvbGFJQXZzNFg3N3kydTdZa0NldkFFcXhN?=
 =?utf-8?B?MFJDZmdFTVNOeFVQY21MSTVRbS95N0c2ZldreDViMjN3SGQxSHdKVHR4OHRq?=
 =?utf-8?B?SlZscE9SeWtjUnQ2MlI5WXFKL0J6eXRyM3FsVVpELzg5YUwwR2RxSTFSYkJP?=
 =?utf-8?B?dVdVMUFRU2pzOHhVV2FsOTB3cU9id1c0WkI1R0g3TGt3K0F0TVE5UFI3cDBq?=
 =?utf-8?B?TWdPa0dGR281SHZTR2JHamQ1WWtMMDFQNmt2Lzl3cFlTYzM0dGtTb1JhNHZW?=
 =?utf-8?B?VS9FZ2FaZ2xsb0xpdWdMZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHNkR044QUlJbUs5THRKUWVKbnozZTVndkprWVNZYjhwRWZlblBvUkVab1hE?=
 =?utf-8?B?QW1RN2ZsN0hpWTEwN0RESlRXNC9nY0VXdVh0UU1pNVd4SU1EdmhvTlovSE9l?=
 =?utf-8?B?RVpYZ1dxV3pXQVN3T1ZDSG1LcEJKU3JHWis5UHRpYXFHUzd6TkhzOVJDK3NT?=
 =?utf-8?B?SFNCd1puSDBUZUtIR2JLQTZua3RhcmhSNUFyQ29wL0tLYjB3YXpHcGNYSTRN?=
 =?utf-8?B?TGEzZFoyTDlsdGpIMWNMYURqd1FXYUdZL2hpOTltbUxHYkpQbGVpQmxxaVF2?=
 =?utf-8?B?YUd0bkVpZFRYTnJDM0ZyTkVOVlhGT0VRbjBaSEltNkhHd2diVmc4QzVKMHZo?=
 =?utf-8?B?aHQ3VEYvcUZWV0h6V3ZoQnBiNFBqZkVCRzdkcE8vOXVEWkhtREFST0FYaGhj?=
 =?utf-8?B?bERhU0xzeXpBdThjSTZNRGNxOHhpaTEzOEExZ3lRbWJtQmdyQzN0cUdXMVcx?=
 =?utf-8?B?dk83MGlnWWhPRVZwUG9YMTRjdEZhcWxGQnVDMzJpVFQ3NFpJdjY4eTZZc0Mr?=
 =?utf-8?B?NmhWKzhFcUI0ZVAzMTJkb1V4YjZub1NWSHEyUFM5WW9KN1pIMTVEQTkzR0xX?=
 =?utf-8?B?T3NmMU9oNHJ5SkZyeEtNZXVJM3RYeEd0K1REb0g4eHI3MVB4SDNZTzJkV2hO?=
 =?utf-8?B?dks3Qkp4N3NhbStyZWFnTCs2aEx0L240dWtxeWFaeW44YldIdEhRN2gzelVX?=
 =?utf-8?B?OG1qeGw5RnQrZEZJei8rYVp6RzV2akxhZkZiYXVMQTh4QU5lZE9kN0MvWGpu?=
 =?utf-8?B?OVc5aGdEdmZFeTFqQjhlaUpPRHZJT1E4aUxyOXliNEY4Z3FvRWtnWGpySkNl?=
 =?utf-8?B?bWJydUdRUVNlUy9xSExDUVFyRWJPRFE1Wk5FNTh4eEhKK1l6OHFJNFhER1dR?=
 =?utf-8?B?UDU5elFMa3lkUnczYVBDRVBNdzE3YjRRS285VXhnTld1dnR3TEFvRFhLaXNO?=
 =?utf-8?B?MGtpY0lDMW40bnVjVEJhUGptWHArcmM0Q1FGbldwRHNTeExVZ25sNktaL2VZ?=
 =?utf-8?B?OE9wSVBUZVY1UGROaUI5RXh6cTBMUUJJTU9JU1ZsbVFWNERnbTVNM1BRczBT?=
 =?utf-8?B?REpaQjhMdVVJRmFSVEJ0WEVnWTJSTTdHQUpEc0hlZElWSG1iN08vdVJtZjg2?=
 =?utf-8?B?SytITTkySDFqbjdWUWgxb05LY0VkT1Ixd2IyOXhmRW5kYThiZ1pCbThVQXdU?=
 =?utf-8?B?bExlZHFjd0JVTGkvcUUzaHpVWEtUdGIwNDQxSVpBeUVxbkZzZDRvMTczdFZH?=
 =?utf-8?B?RFA2SllSOUxPeTBqMlFTUkxuZzRjMEVhdTlhWWhkcjhJVlhZMFh0ckNSOHB3?=
 =?utf-8?B?UG5nK3hNbzMxck44TEdWbkZ2Y0I3bk9LaE52T3F5blN5NU5ZNHE4MEN0a0Jq?=
 =?utf-8?B?Nll4ZFBUT3hlNWg0QnNmazVDaVNjTi9YNGRzYTJMa29RZzAvOXFxeUhqWTA1?=
 =?utf-8?B?bzE4WGxTVTQ4VlVXU1VzRk9FY3I0bHArcW9vMTFrVFJnRjlzSDEyMkVUTUNh?=
 =?utf-8?B?VjJTKzBUemdZblYyU25lUmRBeUNqbjdZL2VVOHdUQ1VSQmkzRXRDVndyRkQz?=
 =?utf-8?B?djIwb2YrU2Mvb0MxdWZsUXhIZzBZS3FGV2Y2ZGpxbmw1eHg4ZHNmUVhjTFgy?=
 =?utf-8?B?bXJQL3V5TXFqU2hkWEtTb2JKckdMT3VZS3JkWWJTNkszbEIyaVdFSmlrUEh3?=
 =?utf-8?B?cGZGMW1va01DZ3B2b0EwRDdnUHF5TCsxenU1T00zOW1kTjBGNlZsRUpmaFJJ?=
 =?utf-8?B?Z3I1cHl6WXlGNnlRdk5DUTFvMXo4SU1iT3RJSEMxcFRGQUk4MzJvUWpITXdh?=
 =?utf-8?B?R2N1cHIzbEZZdDQ1N3JoYnJPTERtN2x5dVd1SzJsSmw0WEd2SW81TUtEOVNU?=
 =?utf-8?B?NkVBSmV5SzhZUW1mRWdDYWZ5WFVObFUrcldrN0ZtaytXZC9jazFKMHpzMkNt?=
 =?utf-8?B?RGJnTTJLdHR6Y1dJU05pSW5lUVZkRlQzT2hGaE5oZjZwMmo0d0NDbkxYUC9D?=
 =?utf-8?B?OW92d3JIdFNFL0dTR0JtckRvM3NBOE91Q2dNdmJQR285NTJzckNPVmpNWWFh?=
 =?utf-8?B?VEJWOFFmTStTaUtJV0ZXa2RDTXpTSTY4aXhHZFJ4aUpnc3ptUTd4akd4OVNR?=
 =?utf-8?Q?77i0RwX/IBiIoROX6lNZ5H2Pw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8cbf2f-3afe-4e2b-1dbe-08dd3ad2cd50
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 10:52:02.1715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgktJUXqHKbWdyBsb7BLl5Hh5PY/yFZUiZ3f9VuapLB7E+nvhRPtwfykgm0xGEmWXj9sl4MkQ482u3gcCfkjKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8681
X-OriginatorOrg: intel.com

Hi Lucas

On 1/22/2025 11:53 AM, Lucas De Marchi wrote:
> From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
> 
> Basic PMU enabling patch. Setup the basic framework
> for adding events/timers. This patch was previously
> reviewed here -
> https://patchwork.freedesktop.org/series/119504/
> 
> Based on previous versions by Bommu Krishnaiah, Aravind Iddamsetty and
> Riana Tauro, using i915 and rapl as reference implementation.
> 
> Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>   drivers/gpu/drm/xe/Makefile          |   2 +
>   drivers/gpu/drm/xe/xe_device.c       |   3 +
>   drivers/gpu/drm/xe/xe_device_types.h |   4 +
>   drivers/gpu/drm/xe/xe_pmu.c          | 299 +++++++++++++++++++++++++++
>   drivers/gpu/drm/xe/xe_pmu.h          |  20 ++
>   drivers/gpu/drm/xe/xe_pmu_types.h    |  43 ++++
>   6 files changed, 371 insertions(+)
>   create mode 100644 drivers/gpu/drm/xe/xe_pmu.c
>   create mode 100644 drivers/gpu/drm/xe/xe_pmu.h
>   create mode 100644 drivers/gpu/drm/xe/xe_pmu_types.h
> 
> diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
> index 68861db5f27ce..aa0d981663e4c 100644
> --- a/drivers/gpu/drm/xe/Makefile
> +++ b/drivers/gpu/drm/xe/Makefile
> @@ -305,6 +305,8 @@ endif
>   xe-$(CONFIG_DRM_XE_DP_TUNNEL) += \
>   	i915-display/intel_dp_tunnel.o
>   
> +xe-$(CONFIG_PERF_EVENTS) += xe_pmu.o
> +
>   obj-$(CONFIG_DRM_XE) += xe.o
>   obj-$(CONFIG_DRM_XE_KUNIT_TEST) += tests/
>   
> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
> index bd6191e1ed3e7..f3f754beb812b 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -49,6 +49,7 @@
>   #include "xe_pat.h"
>   #include "xe_pcode.h"
>   #include "xe_pm.h"
> +#include "xe_pmu.h"
>   #include "xe_query.h"
>   #include "xe_sriov.h"
>   #include "xe_tile.h"
> @@ -871,6 +872,8 @@ int xe_device_probe(struct xe_device *xe)
>   
>   	xe_oa_register(xe);
>   
> +	xe_pmu_register(&xe->pmu);
> +
>   	xe_debugfs_register(xe);
>   
>   	xe_hwmon_register(xe);
> diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
> index 16ebb2859877f..58e79e19deaad 100644
> --- a/drivers/gpu/drm/xe/xe_device_types.h
> +++ b/drivers/gpu/drm/xe/xe_device_types.h
> @@ -18,6 +18,7 @@
>   #include "xe_memirq_types.h"
>   #include "xe_oa_types.h"
>   #include "xe_platform_types.h"
> +#include "xe_pmu_types.h"
>   #include "xe_pt_types.h"
>   #include "xe_sriov_types.h"
>   #include "xe_step_types.h"
> @@ -514,6 +515,9 @@ struct xe_device {
>   		int mode;
>   	} wedged;
>   
> +	/** @pmu: performance monitoring unit */
> +	struct xe_pmu pmu;
> +
>   #ifdef TEST_VM_OPS_ERROR
>   	/**
>   	 * @vm_inject_error_position: inject errors at different places in VM
> diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
> new file mode 100644
> index 0000000000000..c5641af6e9a91
> --- /dev/null
> +++ b/drivers/gpu/drm/xe/xe_pmu.c
> @@ -0,0 +1,299 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright © 2025 Intel Corporation
> + */
> +

Some of these headers are unused
> +#include <drm/drm_drv.h>
> +#include <drm/drm_managed.h> 
> +#include <drm/xe_drm.h>
above 2 unused
> +
> +#include "regs/xe_gt_regs.h"
unused
> +#include "xe_device.h"

> +#include "xe_force_wake.h"
> +#include "xe_gt_clock.h"
> +#include "xe_gt_printk.h"
> +#include "xe_mmio.h"
> +#include "xe_macros.h"
unused
> +#include "xe_pm.h"
> +#include "xe_pmu.h"
> +
> +/**
> + * DOC: Xe PMU (Performance Monitoring Unit)
> + *
> + * Expose events/counters like GT-C6 residency and GT frequency to user land.
> + * Events are per device. The GT can be selected with an extra config sub-field
> + * (bits 60-63).
> + *
> + * All events are listed in sysfs:
> + *
> + *     $ ls -ld /sys/bus/event_source/devices/xe_*
> + *     $ ls /sys/bus/event_source/devices/xe_0000_00_02.0/events/
> + *     $ ls /sys/bus/event_source/devices/xe_0000_00_02.0/format/
> + *
> + * The format directory has info regarding the configs that can be used.
> + * The standard perf tool can be used to grep for a certain event as well.
> + * Example:
> + *
> + *     $ perf list | grep gt-c6
> + *
> + * To sample a specific event for a GT at regular intervals:
> + *
> + *     $ perf stat -e <event_name,gt=> -I <interval>
> + */
> +
> +#define XE_PMU_EVENT_GT_MASK		GENMASK_ULL(63, 60)
> +#define XE_PMU_EVENT_ID_MASK		GENMASK_ULL(11, 0)
> +
> +static unsigned int config_to_event_id(u64 config)
> +{
> +	return FIELD_GET(XE_PMU_EVENT_ID_MASK, config);
> +}
> +
> +static unsigned int config_to_gt_id(u64 config)
> +{
> +	return FIELD_GET(XE_PMU_EVENT_GT_MASK, config);
> +}
> +
> +static struct xe_gt *event_to_gt(struct perf_event *event)
> +{
> +	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
> +	u64 gt = config_to_gt_id(event->attr.config);
> +
> +	return xe_device_get_gt(xe, gt);
> +}
> +
> +static bool event_supported(struct xe_pmu *pmu, unsigned int gt,
> +			    unsigned int id)
> +{
> +	if (gt >= XE_MAX_GT_PER_TILE)
> +		return false;
> +
> +	return false;
> +}
> +
> +static void xe_pmu_event_destroy(struct perf_event *event)
> +{
> +	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
> +
> +	drm_WARN_ON(&xe->drm, event->parent);
> +	drm_dev_put(&xe->drm);
> +}
> +
> +static int xe_pmu_event_init(struct perf_event *event)
> +{
> +	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
> +	struct xe_pmu *pmu = &xe->pmu;
> +	unsigned int id, gt;
> +
> +	if (!pmu->registered)
> +		return -ENODEV;
> +
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	/* unsupported modes and filters */
> +	if (event->attr.sample_period) /* no sampling */
> +		return -EINVAL;
> +
> +	if (event->cpu < 0)
> +		return -EINVAL;
> +
> +	gt = config_to_gt_id(event->attr.config);
> +	id = config_to_event_id(event->attr.config);
> +	if (!event_supported(pmu, gt, id))
> +		return -ENOENT;
> +
> +	if (has_branch_stack(event))
> +		return -EOPNOTSUPP;
> +
> +	if (!event->parent) {
> +		drm_dev_get(&xe->drm);
> +		event->destroy = xe_pmu_event_destroy;
> +	}
> +
> +	return 0;
> +}
> +
> +static u64 __xe_pmu_event_read(struct perf_event *event)
> +{
> +	struct xe_gt *gt = event_to_gt(event);
> +	u64 val = 0;
> +
> +	if (!gt)
> +		return 0;
> +
> +	return val;
> +}
> +
> +static void xe_pmu_event_read(struct perf_event *event)
> +{
> +	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct xe_pmu *pmu = &xe->pmu;
> +	u64 prev, new;
> +
> +	if (!pmu->registered) {
> +		event->hw.state = PERF_HES_STOPPED;
> +		return;
> +	}
> +
> +	prev = local64_read(&hwc->prev_count);
> +	do {
> +		new = __xe_pmu_event_read(event);
> +	} while (!local64_try_cmpxchg(&hwc->prev_count, &prev, new));
> +
> +	local64_add(new - prev, &event->count);
> +}
> +
> +static void xe_pmu_enable(struct perf_event *event)
> +{
> +	/*
> +	 * Store the current counter value so we can report the correct delta
> +	 * for all listeners. Even when the event was already enabled and has
> +	 * an existing non-zero value.
> +	 */
> +	local64_set(&event->hw.prev_count, __xe_pmu_event_read(event));
> +}
> +
> +static void xe_pmu_event_start(struct perf_event *event, int flags)
> +{
> +	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
> +	struct xe_pmu *pmu = &xe->pmu;
> +
> +	if (!pmu->registered)
> +		return;
> +
> +	xe_pmu_enable(event);
> +	event->hw.state = 0;
> +}
> +
> +static void xe_pmu_event_stop(struct perf_event *event, int flags)
> +{
> +	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
> +	struct xe_pmu *pmu = &xe->pmu;
> +
> +	if (pmu->registered)
> +		if (flags & PERF_EF_UPDATE)
> +			xe_pmu_event_read(event);
> +
> +	event->hw.state = PERF_HES_STOPPED;
> +}
> +
> +static int xe_pmu_event_add(struct perf_event *event, int flags)
> +{
> +	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
> +	struct xe_pmu *pmu = &xe->pmu;
> +
> +	if (!pmu->registered)
> +		return -ENODEV;
> +
> +	if (flags & PERF_EF_START)
> +		xe_pmu_event_start(event, flags);
> +
> +	return 0;
> +}
> +
> +static void xe_pmu_event_del(struct perf_event *event, int flags)
> +{
> +	xe_pmu_event_stop(event, PERF_EF_UPDATE);
> +}
> +
> +PMU_FORMAT_ATTR(gt,	"config:60-63");
> +PMU_FORMAT_ATTR(event,	"config:0-11");
> +
> +static struct attribute *pmu_format_attrs[] = {
> +	&format_attr_event.attr,
> +	&format_attr_gt.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group pmu_format_attr_group = {
> +	.name = "format",
> +	.attrs = pmu_format_attrs,
> +};
> +
> +static struct attribute *pmu_event_attrs[] = {
> +	/* No events yet */
> +	NULL,
> +};
> +
> +static const struct attribute_group pmu_events_attr_group = {
> +	.name = "events",
> +	.attrs = pmu_event_attrs,
> +};
> +
> +/**
> + * xe_pmu_unregister() - Remove/cleanup PMU registration
> + * @arg: Ptr to pmu
> + */
> +static void xe_pmu_unregister(void *arg)
> +{
> +	struct xe_pmu *pmu = arg;
> +	struct xe_device *xe = container_of(pmu, typeof(*xe), pmu);
> +
> +	if (!pmu->registered)
> +		return;
> +
> +	pmu->registered = false;
> +
> +	perf_pmu_unregister(&pmu->base);
> +	kfree(pmu->name);
> +}
> +
> +/**
> + * xe_pmu_register() - Define basic PMU properties for Xe and add event callbacks.
> + * @pmu: the PMU object
> + *
> + * Returns 0 on success and an appropriate error code otherwise
> + */
> +int xe_pmu_register(struct xe_pmu *pmu)
> +{
> +	struct xe_device *xe = container_of(pmu, typeof(*xe), pmu);
> +	static const struct attribute_group *attr_groups[] = {
> +		&pmu_format_attr_group,
> +		&pmu_events_attr_group,
> +		NULL
> +	};
> +	int ret = -ENOMEM;
> +	char *name;
> +
> +	if (IS_SRIOV_VF(xe))
> +		return 0;
> +
> +	raw_spin_lock_init(&pmu->lock);
> +
> +	name = kasprintf(GFP_KERNEL, "xe_%s",
> +			 dev_name(xe->drm.dev));
> +	if (!name)
> +		goto err;
> +
> +	/* tools/perf reserves colons as special. */
> +	strreplace(name, ':', '_');
> +
> +	pmu->name		= name;
> +	pmu->base.attr_groups	= attr_groups;
> +	pmu->base.scope		= PERF_PMU_SCOPE_SYS_WIDE;
> +	pmu->base.module	= THIS_MODULE;
> +	pmu->base.task_ctx_nr	= perf_invalid_context;
> +	pmu->base.event_init	= xe_pmu_event_init;
> +	pmu->base.add		= xe_pmu_event_add;
> +	pmu->base.del		= xe_pmu_event_del;
> +	pmu->base.start		= xe_pmu_event_start;
> +	pmu->base.stop		= xe_pmu_event_stop;
> +	pmu->base.read		= xe_pmu_event_read;
> +
> +	ret = perf_pmu_register(&pmu->base, pmu->name, -1);
> +	if (ret)
> +		goto err_name;
> +
> +	pmu->registered = true;
> +
> +	return devm_add_action_or_reset(xe->drm.dev, xe_pmu_unregister, pmu);
> +
> +err_name:
> +	kfree(name);
> +err:
> +	drm_err(&xe->drm, "Failed to register PMU (ret=%d)!\n", ret);
> +
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/xe/xe_pmu.h b/drivers/gpu/drm/xe/xe_pmu.h
> new file mode 100644
> index 0000000000000..f9dfe77d00cb6
> --- /dev/null
> +++ b/drivers/gpu/drm/xe/xe_pmu.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright © 2025 Intel Corporation
> + */
> +
> +#ifndef _XE_PMU_H_
> +#define _XE_PMU_H_
> +
> +#include "xe_pmu_types.h"
> +
> +struct xe_gt;
unused
> +
> +#if IS_ENABLED(CONFIG_PERF_EVENTS)
> +int xe_pmu_register(struct xe_pmu *pmu);
> +#else
> +static inline void xe_pmu_register(struct xe_pmu *pmu) {}
> +#endif
> +
> +#endif
> +
> diff --git a/drivers/gpu/drm/xe/xe_pmu_types.h b/drivers/gpu/drm/xe/xe_pmu_types.h
> new file mode 100644
> index 0000000000000..e0cf7169f4fda
> --- /dev/null
> +++ b/drivers/gpu/drm/xe/xe_pmu_types.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright © 2025 Intel Corporation
> + */
> +
> +#ifndef _XE_PMU_TYPES_H_
> +#define _XE_PMU_TYPES_H_
> +
> +#include <linux/perf_event.h>
> +#include <linux/spinlock_types.h>
> +
> +enum {
> +	__XE_NUM_PMU_SAMPLERS
> +};
This enum is not used. can be removed

Thanks,
Riana
> +
> +#define XE_PMU_MAX_GT 2
> +
> +/**
> + * struct xe_pmu - PMU related data per Xe device
> + *
> + * Stores per device PMU info that includes event/perf attributes and
> + * sampling counters across all GTs for this device.
> + */
> +struct xe_pmu {
> +	/**
> +	 * @base: PMU base.
> +	 */
> +	struct pmu base;
> +	/**
> +	 * @registered: PMU is registered and not in the unregistering process.
> +	 */
> +	bool registered;
> +	/**
> +	 * @name: Name as registered with perf core.
> +	 */
> +	const char *name;
> +	/**
> +	 * @lock: Lock protecting enable mask and ref count handling.
> +	 */
> +	raw_spinlock_t lock;
> +};
> +
> +#endif

