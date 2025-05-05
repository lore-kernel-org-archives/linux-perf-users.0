Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8B52C859
	for <linux-perf-users@vger.kernel.org>; Mon,  5 May 2025 13:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746453051; cv=fail; b=mbRCDIQB1V7Uf9P18ySu66ZyRstx2jHAdDIBSJEUbB/OzBgdg5x+FvqlZA1tWDmJPffzlSaH8cX9tiUVlud8jSNBTrzNTm2N7EzZVGYt3ktiUEts1NfrL4jmIIlJLNid4mLj3SOcSIDf06f9tUPHALfFhqS4tQikjxRrVOzCUhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746453051; c=relaxed/simple;
	bh=VwPOfwTZKpYYin3+VjQ/JBubfewe+ZXyPNwzniblQwk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tnZ/z4dgh2WXEFgitQtg7wUhlXgGan7DOZDQWOPthL03IArwdS79Bder9HbZchqte+d1ZDFqkx1KRgaelH9QaJzcV2U+tQkFB9WFBB+8eAODEgsSd/YFN4YBZzakcWdrhNAqme9DUntkuOsb55EeJSASqvln8EYf1DK6icWQxcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=STEZo9Jp; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="STEZo9Jp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746453050; x=1777989050;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VwPOfwTZKpYYin3+VjQ/JBubfewe+ZXyPNwzniblQwk=;
  b=STEZo9JpUj8vJvGIPhhbB2BxiWL13qxJ2/I2H8OBr1aRy2lFsxzsWpCt
   Qwd7OqA+WTx+YqUXIQVPq6+l5Vk28ZOlq5hTgMsItfuUnCNqcwzOY4HGi
   m//bJ77ohge9VSyogL5WwrIMGscXoe93J4cOPtbv6950WLrhSUIFZD0Vo
   nP0CTKKtdv/95VK+3Gg49Wy5GpCITxtNJShROidcm/IJGhs3VNhybsm1S
   HMhbI7e4njCXsptRsI3roV0MIceK0n+8IxOm+nMjbHTBXCYs6GVfBR8PK
   z71p+4p6dc4y0v0rJn2+I+0assw2DwBTkGKoeXS8DmR1wwcbvjHUqiuNp
   w==;
X-CSE-ConnectionGUID: GTEFJejtSwWE/oNT5Esn1Q==
X-CSE-MsgGUID: ut3tMH4CT5aQ+FwIwZz1vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11423"; a="48072854"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="48072854"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 06:50:46 -0700
X-CSE-ConnectionGUID: giRTJ2QlT5Ko1uAaOt3eKQ==
X-CSE-MsgGUID: BIBrm4rYRyWRqQA8a7JiEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="140031985"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 06:50:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 5 May 2025 06:50:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 5 May 2025 06:50:44 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 5 May 2025 06:50:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/AcrQ4PGlcloJ1eRJ9uh3A2z7tXTJixGzYAvcegg9xMQfEOK2QmH5pCa2F9fkxNKoneJJNX5Q1wgbhoYSQLCEgwedgwpy9bomkZ+hMzyo5NApDtlr6lAGwW4iIlEUnqcRGEzJDFsYtKGFH4q2utfpkPEDioyw8Kyv/TT4RHo0nsDvqteX509pPqaGkgJEPTS7Kul1Te+dyaderu2qDs+fNw84N9XzylD9Ce6NJG6grZtDPaXxPWgq1tpjj+Iulngk8G+684DZmqlAATK1GW119Gl/EBUNezVqEgxaXu0kVPAJ9+mkVzzCS4H/dGNaGiba/Q7w/BdL3FeOc8tH9vlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uVgDcaG/LNT/YU6EWPJtMQHPEBkdBgRxwgo8yGE79Y=;
 b=xsKtmujM4Zu/8+HvFyjikWWUAmtAbg6nGJFejj7+mG+zpMTjhajIes70hUBH/bqVd1qyUm8Y/tVfj1q8MRaZkPZJZBPvejPUUn2OVJ6fy432MmTrQHOkPbE3KtdWogtYJH7nDvkWxpIIGrl8DmXGQzNXX3TOELVMaCxXkBSED6KWCUtPy9f7+XRuL09DlGpqWtPZr+7C/XCCRN1K7ciShOXvdw9+sIgMHWTZn0Qsy65Bg4XvGED7ZEIsvKqpPYb4KnmwwMoSouPDJOOBHpEcr9fKJg1bygQY438x1q19sheqP8nHZU/vOYL//hsVQPdkZ2LuTiboiaKpwNtCMgtpVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8)
 by CY8PR11MB7947.namprd11.prod.outlook.com (2603:10b6:930:7a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 13:50:27 +0000
Received: from PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301]) by PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301%2]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 13:50:26 +0000
Message-ID: <6a80f5da-9393-4617-bcc2-5aa7bae7e516@intel.com>
Date: Mon, 5 May 2025 16:50:21 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf script: perf script tests fails with segfault
To: Ian Rogers <irogers@google.com>, Aditya Bodkhe <adityab1@linux.ibm.com>
CC: <linux-perf-users@vger.kernel.org>, Aditya Bodkhe
	<aditya.b1@linux.ibm.com>, Disha Goel <disgoel@linux.ibm.com>
References: <20250429065132.36839-1-adityab1@linux.ibm.com>
 <CAP-5=fXOyT30o5JdAer0hPnQZNgGtRKO6B0LWy_Sn-WYC+yM4A@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fXOyT30o5JdAer0hPnQZNgGtRKO6B0LWy_Sn-WYC+yM4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P194CA0027.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::7) To PH7PR11MB6054.namprd11.prod.outlook.com
 (2603:10b6:510:1d2::8)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6054:EE_|CY8PR11MB7947:EE_
X-MS-Office365-Filtering-Correlation-Id: d5e0853b-64eb-47ac-8c12-08dd8bdbc9e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXNjS28xS2I4d1VMWEdNL00rUDY4M3lBUjJNa3RSaktiNkE3WDlUdENwMVBy?=
 =?utf-8?B?blJoczJscDl0Sk8wU1JQbERqM2JWQ1BicjZhWVlvdWdUQ1owNlpkYlZHblBX?=
 =?utf-8?B?MEZTeWxtOGNudkptdXk2aWVSNGRXWkp5bzdYc1BaWitZRTdVT0NiK1c1OStT?=
 =?utf-8?B?RThCZGVaVjJnTmNBb3VoNTlkT1doWEFPMDNjdFpWcEc3NjNiam9RZmhzUUk2?=
 =?utf-8?B?RloyaFJiaFVJcytOYzI5SWNJUHF3dEI2c2RnaVVFRTBqK1AyWTNsSDgwZTM0?=
 =?utf-8?B?S2xvVU1uaFEyMEx4a0lzN0dMRDk2NklmVGttdEJMWXMxWjBLUm1VakUya3VG?=
 =?utf-8?B?R05NNlJtVHNURlhEY2NHZUsxNU5oVGZ2YWxHYWNUSDNTNUl6QVNiSzkydXB1?=
 =?utf-8?B?dkVKYWFDNkRlL2V4M2tCM0JlN2lEdjNlVG4xZzBobUxoUHJ2K0h3VVQwSU0r?=
 =?utf-8?B?M0Z4ejRmUTB5Yy8vbC9Dc0ZXS21rNWE5aUV2UVpkdG5odkhCZUEzRmtIaHhR?=
 =?utf-8?B?U1FSZXFLSzVITjBKcU5hWXdQTzk5TkJpbk5acEhKVjBnb0hxakw3VlhqSnN4?=
 =?utf-8?B?ZGVVSTIxYzF0SDM0dEsvc0ZuTGNQWkhZOTRSN0l1aW55SkNPTEgzTlhQR0F3?=
 =?utf-8?B?THZpOVg1d3pXamZrcG54OEZlUmlOYjQ3MzRHcVVEc0tQazBXK2xGNzZUaXh2?=
 =?utf-8?B?dFlLbUFtdjBwSkcwYmVJaXUrQzYwbndjTnZUU2N5aVZZaHVSUGtMaTVveGt3?=
 =?utf-8?B?Q2pYNzBlM21mcGE0blkvcXBVVEVydllhWjZBdmM0VEFFdWNxNU9vaDFIYlcv?=
 =?utf-8?B?TEN2U2dZb2Qrd2ZVTFFSZXRjcXMvM3pmQUt3c0FIUXcrSFE2N1llWjRQSlg2?=
 =?utf-8?B?Ym8xYTVobG5zS29SNFpWVGU4c1d4MlR6bzNvMDhGSXp3OTdWd2dacXViVVF2?=
 =?utf-8?B?QU45b1VqZlp3NExERHNDQVBtUzFmVlc1cFZCNFhuWUY4S1JMV1JUM0g3T3ZU?=
 =?utf-8?B?TFpTWkJycG51TCtnSE1NcnZaaHJzT3l6RE1ha2ZESlRiUk5GRm8rb0N2UklL?=
 =?utf-8?B?QlhESXQvbEZMYlR4OC80TC9BdVJoRWxId2RGQzBiWnhDT2lZSHUzNEdZMTFa?=
 =?utf-8?B?RVpDeTM1OUtGM0FPU1NSdlJUYTN4LzFZTHRNbkRjUEg5QWJyRm0vM2lZbVlv?=
 =?utf-8?B?MVN2eU9adTN2SDBLdWpYOGZ6ZkFOQXlNYTBNaGpabTFlVHlnbXJ6TkNqRTZu?=
 =?utf-8?B?ZDNjbDM0NWxBZGlMcUZsVXpya1E0eExpbm9JbGZKSE9wQmlnSDgrejhPZDJH?=
 =?utf-8?B?TlpYODBkbUJJU2VVRy9kR012S0NwT242V01XSGR5MDVuSC9DMldGSTArNmJH?=
 =?utf-8?B?U1NaSG9CRnhucWVYWXZkQWRtQjAxSnEvUndkL0xrM2RCSXVhTklVRUdza0hs?=
 =?utf-8?B?NkhNU1RSMjBLVFdUZURJc1E5bTZCM0o3alppdC9pT0FDZy9JVENlWnI0WmlE?=
 =?utf-8?B?eTY4em9ISDgwU1Q4S0d5MEVMM2RuUE1oK2U5ZXZJV2FDbHRERHlhQzdGZDBm?=
 =?utf-8?B?K1ViOVlsYXNXWEpPdWtDQ1l1b3c5dTdsVk1YYjkyakFtclE3K1hxMTB6N3or?=
 =?utf-8?B?NFdDTEhMY2p4cFFSRFo2OFcyVjF6bGU5TDRzTzh4aGRSVGxQYWtXcEJZcGhp?=
 =?utf-8?B?a09NQzV0enBPa1dGZXMvbm4vY3dsR1R5a1lPV2ZiOFdWQ1pybUJhOG04OTZF?=
 =?utf-8?B?Y2doQlRXZDk1QTA3bDgzNlF3OW5SaVNvcnZvWDg3VUp1RjFPejgwUHZlSk1V?=
 =?utf-8?B?VXFGZTV3VkM4bU1GaGUrQWIzVVhwK1dxMFZqcGtHeHpzZlpyNWtFdjcwR2Uv?=
 =?utf-8?B?TVNJS1FSR3ExY0pqcXh3MW94SHdKZys3c1lUTWVlT1VGSW1rSnc2VThHczRw?=
 =?utf-8?Q?eEmsZa6Q5rU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6054.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1BpK2V5M1FhVVc3VlZLaEVsamhRMG5mWmY5KzBjRlh1bEN4ZklKZUN2ZmZj?=
 =?utf-8?B?Z1A2eDBPRVFvdER5UitINTJxdUwyU2xjeFVLYmlCWkxyV2Jkc3hLMVlGVGtn?=
 =?utf-8?B?SklMYStiMENQM25oUW1JVmY0MjNndkJCSHBVT0NXKzhtZUZuNFdualFiNlVq?=
 =?utf-8?B?R1VldzB6UGxuRHc2Q0FnaUpZOElpTlNDbTEwWE9NSWZleXhUZE9aVUxRUXQx?=
 =?utf-8?B?KzZIZXYrOXdnZmptanFUYzhiblRWdmVRbGxyOUZhUERqcmJZV0lLOUJCZkhT?=
 =?utf-8?B?aXFrblkydXRIeGI4alZOelFJNnZmeTJ1UHY2NWZKTDg1WkhQWFBBamdSV0g5?=
 =?utf-8?B?aVY3WDhTS2N0RzZFSDJpcktNMzZCWDR4VExLT1BLVTkyTGpvMk5lYllwY3NM?=
 =?utf-8?B?NEhlQ29xM3luQXpoK3FaWXFBVnFjMTVIVWdKdW1YTnhET3N4RW9vaVFvL0o2?=
 =?utf-8?B?My9rTXJWam81SXMxWlYxUEZZamhGUy90RTY3SjA1TlJHTXBiQ1YwZUk0WjMr?=
 =?utf-8?B?bGUrbVJjTlJhMFdyTy9UaWo4R0N3WWpweTBzNkxrM2ZubmtqYjVaYmhqaDRZ?=
 =?utf-8?B?ZSs4OGtnNEVlcm1zUkpMRVNvaGkzU09hcm1PY0FrajlMUFpqSmF1c2RIN2tx?=
 =?utf-8?B?aFhGVHpVRUtWTlhlZll2YUUzZTErZU5NL3hMMlVEMkZhdnhrcUxGc0g5MENz?=
 =?utf-8?B?d1NCS3VYNGFjVzVMbUFYV00wR3pRRDIwV0FLS0Nib2ovZytoeHpKUXNXVkJG?=
 =?utf-8?B?TjJlNytLMk00aEtuR200NDVYMG5FaVN1MDY3akVEbDVZdzlYMWVqRDQvT0cy?=
 =?utf-8?B?QkZNd2I0Qlo2RzU5UmQ2cWd5U0dLT0c5RjhtVVZJdGdmM1BFckdvM21ZYXZm?=
 =?utf-8?B?emIxdGhOOWd6aWJYbEg5S3doT2NOalVPZG02cWZhYnBMaFk3c2I3T1dIbm5J?=
 =?utf-8?B?KzJUdWdpM2g2eVlselVucXZqOHpsNHpLclJISm9JK1JPYUwydUZHY2EzUFk3?=
 =?utf-8?B?c09yRGxId3BBM1BVRGI4cVd5Z0tOVUk5cXFzblVUZkpoMUJrUDVydEY0SnRj?=
 =?utf-8?B?Z1B4eFFWY3RPemhlMFhpTlBkeDlXUkVYVVN3VTVUR2dOQ3p4NSsvL0o5dDZm?=
 =?utf-8?B?VHVPZlJTS1NGeEVmd3hqenJ0TS9qNk9KcldqNUM5VW5uaURBQS9kNTdVMWtK?=
 =?utf-8?B?S09ITFNOWVJmdE41MXdMK2RNdDlaNGhmQmt5NGxTbkh6a1c4TkZkNk9SaVRE?=
 =?utf-8?B?SHk2aCthL2hZWXpwU3ZlSFZyU0o3YU81TzhMOGxjYmVOY1hBWmMraXMzRTRv?=
 =?utf-8?B?WHFZZ1owS2E0MXdKNXFiR0M0R3J2WjAwc2FwQ2pHbUlINHdHZFhoS1ZTb24r?=
 =?utf-8?B?Y01wMTJFbytiNFZBRWVYQkpsZzJIZU9rNnByMDBtdVZ0RTBHRHZVZUJxVDVP?=
 =?utf-8?B?dzUvQW5rVHVCaExmS0REaEdMSjR2a0s5TjdFZCtjcVprbXFXTzQrZXVpNGRV?=
 =?utf-8?B?QnNEVGlQd0FLbkZBN0Y5Y0l2OWtxOS90WDNobWU4L3lNSnBDTGlPTTZ2bkJU?=
 =?utf-8?B?TnZjMU1JWHdJUExlbEN3VTFUTkxUMithYzRCL3RxcGV2WDZWcW1keGd1bmcr?=
 =?utf-8?B?R0EwNnFidW1IcTZjZXN3a1VYdW4vNGVvaGNrNTlXRnVDL3Yvc3U4U0NYRXNE?=
 =?utf-8?B?eHF1RFg3K0NnSnpXaVhzaitBY0xNRTJFYVlHdnFISUx5eG0xLzdhYnBQNFpP?=
 =?utf-8?B?dnBiN1V3dUdoeUh2czJLR2hRQ3kzYkE2YnhjQ2VmbDdYdjdnRTZkTzFDcnVF?=
 =?utf-8?B?ZXh1Q1MzbnZOaGNoZnY0TWdGUHpYM3k3V2RjUWFjVFhNcjBJcEhieFhnYmpU?=
 =?utf-8?B?aXE3R3VDYWYvNTN0NDVqRjB5bmxCTVduTWp4K3pRZURjSEpOdEF3VCtwQUhX?=
 =?utf-8?B?RmZTKzd2R25ZWXlrejU1cGRSTkcxczlRRENxejh3VWRzM3FQNXdRdFFRbi9a?=
 =?utf-8?B?aWN6QS9oVFpYMFdsSWQ0ZzB0RzllVU9zMEpGTDkxUGhHemgzck9TTjNWVDdX?=
 =?utf-8?B?clhxZXZPeDNNK2t4c3VRd3ExOEROS1JwK2pnTldCTmRTck9tbjEzc1d0SDdk?=
 =?utf-8?B?a3J5Nm9NU1psOCtLTVQvSUlkNWhKQ2NQT0R6T0xpZGJBdjBLcU92bUhrQkpF?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e0853b-64eb-47ac-8c12-08dd8bdbc9e9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6054.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 13:50:26.1719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jH2jEtdYoEtX4KuzM7ShCqa4jDweGxU+gPqWTjHAl9kDY4/oi5khv0VO7a8w+DtUdLvJV+YVKTvcR91EBpNVSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7947
X-OriginatorOrg: intel.com

On 01/05/2025 02:13, Ian Rogers wrote:
> On Mon, Apr 28, 2025 at 11:52 PM Aditya Bodkhe <adityab1@linux.ibm.com> wrote:
>>
>> From: Aditya Bodkhe <aditya.b1@linux.ibm.com>
>>
>> perf script: pert script tests fails with segmentation fault as below:
>>
>>  92: perf script tests:
>>  --- start ---
>> test child forked, pid 103769
>> DB test
>> [ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 0.012 MB /tmp/perf-test-script.7rbftEpOzX/perf.data (9 samples) ]
>> /usr/libexec/perf-core/tests/shell/script.sh: line 35: 103780 Segmentation fault      (core dumped) perf script -i "${perfdatafile}" -s "${db_test}"
>>  --- Cleaning up ---
>>  ---- end(-1) ----
>>         92: perf script tests                                               : FAILED!
>>
>> Backtrace pointed to :
>>         #0  0x0000000010247dd0 in maps.machine ()
>>         #1  0x00000000101d178c in db_export.sample ()
>>         #2  0x00000000103412c8 in python_process_event ()
>>         #3  0x000000001004eb28 in process_sample_event ()
>>         #4  0x000000001024fcd0 in machines.deliver_event ()
>>         #5  0x000000001025005c in perf_session.deliver_event ()
>>         #6  0x00000000102568b0 in __ordered_events__flush.part.0 ()
>>         #7  0x0000000010251618 in perf_session.process_events ()
>>         #8  0x0000000010053620 in cmd_script ()
>>         #9  0x00000000100b5a28 in run_builtin ()
>>         #10 0x00000000100b5f94 in handle_internal_command ()
>>         #11 0x0000000010011114 in main ()
>>
>> Further investigation reveals that this occurs in the `perf script tests`,
>> because it uses `db_test.py` script. This script sets `perf_db_export_mode = True`.
>>
>> With `perf_db_export_mode` enabled, if a sample originates from a hypervisor,
>> perf doesn't set maps for "[H]" sample in the code. Consequently, `al->maps` remains NULL
>> when `maps__machine(al->maps)` is called from `db_export__sample`.
>>
>> As al->maps can be NULL in case of Hypervisor samples , use thread->maps
>> because even for Hypervisor sample, machine should exist.
>> If we don't have machine for some reason, return -1 to avoid segmentation fault.
>>
>> Reported-by: Disha Goel <disgoel@linux.ibm.com>
>> Signed-off-by: Aditya Bodkhe <aditya.b1@linux.ibm.com>
>> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>> Changelog:
>> v2 -> v3:
>> This patch contains changes suggested by Adrian Hunter<adrian.hunter@intel.com> to add extra spaces
>> before ---start--- and ---end---
>> to be able to apply patch without any issues
>>
>> v1 -> v2:
>> The below patch contains changes suggested by Adrian Hunter<adrian.hunter@intel.com> to handle the segmentation fault ,
>> as well as initialisation of al.thread
>>
>>  tools/perf/util/db-export.c                           | 11 ++++++++---
>>  .../perf/util/scripting-engines/trace-event-python.c  |  2 +-
>>  2 files changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
>> index 50f916374d87..8f52e8cefcf3 100644
>> --- a/tools/perf/util/db-export.c
>> +++ b/tools/perf/util/db-export.c
>> @@ -181,7 +181,7 @@ static int db_ids_from_al(struct db_export *dbe, struct addr_location *al,
>>         if (al->map) {
>>                 struct dso *dso = map__dso(al->map);
>>
>> -               err = db_export__dso(dbe, dso, maps__machine(al->maps));
>> +               err = db_export__dso(dbe, dso, maps__machine(thread__maps(al->thread)));
> 
> Would it be better to add a new helper function to minimize the chance
> of a segv, like:
> ```
> struct machine *addr_location__machine(struct addr_location *al)
> {
>   struct machine *machine = NULL;
>   struct maps *maps = al->maps;
> 
>   if (maps)
>     machine = maps__machine(maps)
>   if (!machine && al->thread) {
>     maps = thread__maps(al->thread);
>     if (maps)
>       machine = maps__machine(maps)
>  }
>   return machine;
> }
> ```

Those things have already been checked in db_export__sample(),
and there will still be a segfault if there is no machine,
so it does not really help.

>>                 if (err)
>>                         return err;
>>                 *dso_db_id = dso__db_id(dso);
>> @@ -256,6 +256,7 @@ static struct call_path *call_path_from_sample(struct db_export *dbe,
>>                 al.map = map__get(node->ms.map);
>>                 al.maps = maps__get(thread__maps(thread));
>>                 al.addr = node->ip;
>> +               al.thread = thread__get(thread);
>>
>>                 if (al.map && !al.sym)
>>                         al.sym = dso__find_symbol(map__dso(al.map), al.addr);
>> @@ -358,14 +359,18 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
>>         };
>>         struct thread *main_thread;
>>         struct comm *comm = NULL;
>> -       struct machine *machine;
>> +       struct machine *machine = NULL;
>>         int err;
>>
>> +       if (thread__maps(thread))
>> +               machine = maps__machine(thread__maps(thread));
>> +       if (!machine)
>> +               return -1;
>> +
> 
> Perhaps the machine should be stashed somewhere like struct db_export ?

Different samples can be from different machines i.e. VMs.

