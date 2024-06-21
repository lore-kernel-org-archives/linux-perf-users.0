Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463AA745E2;
	Fri, 21 Jun 2024 23:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719010861; cv=fail; b=F3ikfCUQ8lUTHWTzjnyodVVE8GVYfTbEpim71HL+34/Fid/lLRQcYS0yZNFWQgHPgAzJvk+wbKzEbI4W46J1VY54vhqZFbr3d7pX4sbzwX0j3QKEbEq1FO7XagMIYynXMwrdWGoHSz/nqdIAbVVHEc0Sa4vVTYnHAOX+cZM+8lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719010861; c=relaxed/simple;
	bh=/0Rk+5VRs87luSTezdymzN5F61+c1U+7JoKpknAXX2o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fhBWHRkC+yXnD8I7IjSgoQ4yA5YPvNzjmA/u5kPhKso0UZk8tgu/hiToRJJfgIvpGZQDK9LLd83ciInF/qSdzx1NrHRsIYYQkpL7OTFdME20nKJTyRMRp0ozMSmhM1KkDHOcCc2lYk8gdwSl6RHPsM+li3rMAa7yCoi/4uEdG50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q0W7/g9E; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q0W7/g9E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719010860; x=1750546860;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/0Rk+5VRs87luSTezdymzN5F61+c1U+7JoKpknAXX2o=;
  b=Q0W7/g9E9igj2OvSkr8Xyb+Oa3K1Ng1McU8cumuTiUGyUtqI+AVkuzrO
   bwC3DTbq/rJkEPffKDg/kbEe6eOcb6bprWYQRZeceSA2/1moTShQhYUU7
   MqgmWD04OXrMFQZqfEH4lEjYfBFe+7x29RQ6EDjjMC258tCqxq1FOT1VY
   gn+YPojd8bKfnPySo0DWKzIMBsyRM6lg/aZiAcWGhCDssf6qmhIFZkFNJ
   BfUvW4Z4puGXe6Mt1Yz1dBHj34LFhkraulaSsHvZw8/A5GLOetynlM86A
   An3M1+ct0o5b/VYjMsZr0MKZGxZDMNZFCtdIyVkeu6VFEMHhtOXaPnX07
   A==;
X-CSE-ConnectionGUID: Ly4Cs5IgTQ2Vs9yKGA0xyg==
X-CSE-MsgGUID: fuVGmhDEQNWVS6KoCUu6oA==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="16181103"
X-IronPort-AV: E=Sophos;i="6.08,256,1712646000"; 
   d="scan'208";a="16181103"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 16:00:59 -0700
X-CSE-ConnectionGUID: AxvZXYoEQu6AR+n2rQmX2A==
X-CSE-MsgGUID: eqG7GsqVQ8CoiUJ6DG7xdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,256,1712646000"; 
   d="scan'208";a="47899479"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jun 2024 16:00:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 16:00:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 16:00:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 21 Jun 2024 16:00:57 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 16:00:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKqEg2+CdNZfC5t69dWuWDu/LsxNy1Ol2K3xBI6sLtThr+BJ0t4yxlbxPQxIg+noK7IqwCqRcjkLUBCtjd4pp0O76RNYZH2g8n097iVkTse5sMWaBJ+DATLVsOELesqXiS2+Bos97CLrmth0OQ/XyBCoK7b+sC953+yFi6Xw+FIw7XcA+MEqYVwOOreAJatih6KzOO1yKbmwktJHHCQWHAb7dLP+sckWAbRzj3ZH9nkcSCoG6J28Wj/8slusDe0o39pLQ6o9YQZQOFrMTtBD54g+RblgLZZQPROhNaVKz+6nboYj3YG3c5gZUxT5GDzaC+XEwZ/gf4Gz928V7kSVkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMYua/RRceJrJUEGD7FifOnTAwYQ6Svg6k62Zq6zubQ=;
 b=k05OpL6nMOzRzcDhGRvIIPZCtFivGW8m69hIQUB1V07lPYT2b3r/5eGNMr8YvI5clsp12eZlyNNQm0GeR65PUPAzaTGENgJz01Y9tfp9Na/Gg/bqX+GHOcXRBBtco5/kTg4FYkp7uQP3iD8C+6exMBDkVKLbAbslztO+ERCTv75b7xrsf8b5/W6T9Aot2pZCstnRzwNKBfP4Pj3lgXmDjZVcU1QXoYE9UpXRH+v0briqDZpyXaLXjnC/+I+OoTPdMPj9hIKOlMvb1Ggg0963krN9Je3FC0p/XuZ+iRiT7t3tGvwz22O0NXRbrJatJ98BM2HIlm0Ixq8h9quRB0eEVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CY8PR11MB7011.namprd11.prod.outlook.com (2603:10b6:930:55::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Fri, 21 Jun
 2024 23:00:50 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 23:00:49 +0000
Message-ID: <5c1f24aa-79f0-4142-80b2-f13c41b91d76@intel.com>
Date: Fri, 21 Jun 2024 16:00:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] x86/irq: Add enumeration of NMI source reporting
 CPU feature
To: Xin Li <xin@zytor.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, "X86
 Kernel" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, Dave Hansen <dave.hansen@intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, <linux-perf-users@vger.kernel.org>, Peter Zijlstra
	<peterz@infradead.org>
CC: Andi Kleen <andi.kleen@intel.com>, Xin Li <xin3.li@intel.com>
References: <20240611165457.156364-1-jacob.jun.pan@linux.intel.com>
 <20240611165457.156364-2-jacob.jun.pan@linux.intel.com>
 <de99f490-8b8d-4ae9-9f87-e0336e563aba@zytor.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <de99f490-8b8d-4ae9-9f87-e0336e563aba@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0365.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::10) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CY8PR11MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: acc42d13-bd9c-4ea7-64af-08dc9245fe3b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|7416011|366013|376011|921017;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnJCbFdjcVQzb0EzUkEydjE5dUlITy9qbVp1N0dLMWpIUnBNRjRtNWZlN0xm?=
 =?utf-8?B?U25Kalk5MVVXT1NlVTBlV29KRmNRUWkxUGsyMUxkWk9kQ2ppazVmRDZnb1Zi?=
 =?utf-8?B?MGlGZVpYK05BQzZrK1ZVNVFkM3lrVnRzTU1uUndodHAwTTFpOGNCS21lMU9V?=
 =?utf-8?B?SzAwYzFjY0cvVWFJUmpZcUFSQ0kwdm5uMTVSR0VwNGc2bFp6aU1jeXBoNXo2?=
 =?utf-8?B?Mlc2bE9ienNrM3ozWXlXUEpUQ1FjcWxMMmFPQ01JSXlXd0UzbzU2U1QwcGRL?=
 =?utf-8?B?ZTRDbTZLdUlQZDlOTWRyS0g2QTUxMDZUVzNGNnRhNUwzcG1HTG9XZ2lPTFJo?=
 =?utf-8?B?TmxzOUFKeWR1dFBXRTNGazhNaHZGY2ZBcWNGNTliMnVOS0twakMzK1hrZFFF?=
 =?utf-8?B?S3lZZGpqTEY3eW13VnRhYmJJeW5VUUFBQUZZRDZhelh6alJMQ2VzeENSdXQ3?=
 =?utf-8?B?QkE5OWF5K21SSXRaY2g2OHVTSEpzYUwvZ1ZjWE1VdHFtdjM2RkZqdG9WWjBD?=
 =?utf-8?B?UUVoVHNDQ09oZWFlbzI5UXlOZGhyM1RLVGFHL0VOQUlXQ0pNU3dVdnpCeUFz?=
 =?utf-8?B?dDlnU292aVpoWmFrN1ZrZHJTZDNjL1RRVkhzQnZvV0FvOTk4cU1hcHdlQnA2?=
 =?utf-8?B?WXpuOHFnSS9rU0NQUU1EOEFVZVV0V2Q2ME5ZZWxCU1l0d3NRVHJYOVU5YjJT?=
 =?utf-8?B?ZkoxTE15TGNjSE9Od1diODkzckJGbDhHVThwK3V2eENGbWlrQUx1THhReVRh?=
 =?utf-8?B?S0t0Q1N6Y0I3S3hXVjRHVkcvTTlWVU81bjlmRi9hSUdDaGhWUFRmQm1rYlRp?=
 =?utf-8?B?TE10VjhwcHlDNU04eU1VZ2FYMDhFaWlwM250ODZJZkpzSDl1NERhMnZkU0tw?=
 =?utf-8?B?YUY4TWthaHRKYmpPRW9IR1FXVzZFYXlFRExNbDRzRnkxb0V5R1Z4Vi84b0or?=
 =?utf-8?B?djc2MXZqZ1kzSGFwZGRlekRrRzlmaFZFOWlxaWw3bjBadGNoUmgyNkxvSGJs?=
 =?utf-8?B?Q0UxdjZCOGp4eDNhSW1QSnI5SDJnSnRVajM2d1UrV1plS0FsTllRMVZMZWlv?=
 =?utf-8?B?VkRvSE1pQldJaDZDMUNyVjlRR2JTNkZHZ2NVTE91T2lhN3dEUjFEQXpFMDNN?=
 =?utf-8?B?RU13ZHpKL0trcDc1N1lVcitKVWd3am50dmF4U0hOd0FaNDhwNWFqU1gvMTh1?=
 =?utf-8?B?WE1CM3RlVjlDaXc2VjFMU2dqZHRoczV1YTAycE0zYzNzMXA3bHIrZDF1TE9k?=
 =?utf-8?B?cnFXRzFZQTJDRVdXSURwWTFnUFRudUdoR1BtMlFoTi9Sa0lsZlNkTG9HZHJQ?=
 =?utf-8?B?U0tGZHVFZ1BOdGpJS3ZyUzlsM1M5eVliUVVLbTFmck1LSkk4YjNpWDdmSm5l?=
 =?utf-8?B?MUV3UW1VVkFJd0wzNFdJOXhBL1BVdmZUL09FVTVJdGVBWlZlY3RHYjFSVkVn?=
 =?utf-8?B?ZzE4V1JqR2FSRGZ5VlVZVVV4d1pEa3c0N2RVSi9YOVJUdU9lWVJOMW82RnJr?=
 =?utf-8?B?aXo3SkxnWXUzRkxKcEFhRC9nT2xVU0R4UnZTNDlpVzMwWVREU0dzQmJvNVJY?=
 =?utf-8?B?TDcvM3ZIc01uVWRYeU9nRDRZbk80R3dXMWpvRE45TDBwYTdCTE9BN0lxczYx?=
 =?utf-8?B?dXBLeGNOeU5aaThvS1RFZ1NLL1RvNW5LQTRkOFU1bVBscUFnaG15WFg3eS82?=
 =?utf-8?B?NU5DV3VRSHkxS01DaDlNT1ptUWVTRFd4dDRRVFhHU0JyRTZiTTVZN014WUVy?=
 =?utf-8?B?bExVSDlIYUw5RStZVEdMOTh6TXJXT3NvZ3dGMk1hQVVpbzRwVVc3WjNseUkx?=
 =?utf-8?Q?5Pj30tq6npFh3EU4TSOriaxNO7V6zew3W0i/w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(7416011)(366013)(376011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDdEbDVlRkhPVjlmQnpzS2ZwYkhNQVNKV0ZQM0lCNGxQaStVejFpR01ZdmRC?=
 =?utf-8?B?TGRQYms1SUxqeXI1OUFQZDFlUVBtclFqVTdUWXMyLys2RUQ4amZUMURnMllW?=
 =?utf-8?B?czQ0K1l6T3JqSkI0ZEx0VUtiNmcveEI2SEhLNjNyYVp3YjNNVFNZV0VnbjFU?=
 =?utf-8?B?M1ZiWmVtOHlITFhLVU1oVDFIZFZ6YkZSUjN3YmtJalB3RElhMDVOZ2xzSVhJ?=
 =?utf-8?B?L3NtZzBQNTUvdG54WG93cmg5bDNMSU1nRzhxN1BRMFJESXhRZ1N4UFk3cks5?=
 =?utf-8?B?S1BPNmx4d0FwU3pxanZoTWhQNmpDWStKaytqTFhPN1B3TEtxZ1E2TUpxS2NJ?=
 =?utf-8?B?YmptbmhWR0VjRkQ4dndCL1M1MVZNZDZkcVNmaGxEOTJNMWxvUVcxQ0hSbk1J?=
 =?utf-8?B?enJjYlc3clVQQmtlOVZPYTc0NXNrWXl4MnFUVGxrVGZYZzB6NmZZOWxkSnV6?=
 =?utf-8?B?SnZGWWp2eGdVbmJKUUd0Zzh6Z3lKcjlWaFFlUWV4WnlTY1M3WlgvMnc3ZUdC?=
 =?utf-8?B?eUdqQlZVWUd5bkEyVG5HK2FjUjNaVEZyTDg0d1JFSHhPK1puNGdaTHIxMElC?=
 =?utf-8?B?SzVMTllKZWc2TktkTGZ6aWg1TGFiSnZ4YjlZZW5VUHBIT0lqRTd2TFk0UFBp?=
 =?utf-8?B?WXdHMHZCMFVsQ2J0STBJZmRCSUMrdGlFUk5LT1JMUXQ0a0dzRVQ5YWk5VzJU?=
 =?utf-8?B?ZnRxczdnMWtBd09qSldrNmlLUW5EMmVDeVdCVUhjKzRMcFVOWVRWMDRzY29C?=
 =?utf-8?B?VmlWcFVoanM2TDBXRHdXaE1MT2I3eUtyNHpmK3htcjVYY0h4bzR6dGpLcERj?=
 =?utf-8?B?Y2JtWXFka2k4SGV6d1FVMWptWm0wYWZDd2FsZUF5N1F2K2hqdFNIU2JUUDcr?=
 =?utf-8?B?NHF1Qm9CdlRkZ3ozNDhqY3dwWTNibUJON05TYUFHQUVvQlBMZGZ6bC80YXJw?=
 =?utf-8?B?d1NoZDMyd1NkazV6bnFHSGgxd2FJTStYRVlETTBKYm93eTVkR3NYS1dzMUZi?=
 =?utf-8?B?bGZialp5RTRTNXMzakE5YVVpQ09SZi9DOXZqYklrK1NXRWVxVHNPTThoNk1M?=
 =?utf-8?B?R0dFSnQ0WFZsOEYxY29PSU92RXhJWWZwS1oxL2pLR3hxRllXRTdxMm4waFFO?=
 =?utf-8?B?QjF5aEM4ZzFaUlhnUVd0K3dHMWpBUG9RM3lscXNUOEszWFRCZG1BdmRPcFN2?=
 =?utf-8?B?Q1dLWm8vL09LbkdnRVgwbzRQNjh5V05DTDNpWUJxUWI5NmtrTDRXUVRQOCsw?=
 =?utf-8?B?cG04VWxFR3MzZzNTcGMvMzZId0tWU2s0MU9GNWdYL1IyeGQ4TGhhQ1dQUDBl?=
 =?utf-8?B?Umx0S21iclVTeWZUU0pWOVhOS0JOU1orUHRkSGtaQXhwTktYU2x2ajBIZ0ht?=
 =?utf-8?B?WUlBRDZPcmlBVWExM0VERUIxRkZCNHFrNjBUZnVwTlRwL2RuajNLVHlldEdl?=
 =?utf-8?B?ZzdqYlZiYW03U0Jnek5xRnJ4K0doZTBNaGp2WTM2OTZrMVRFcDNRSFNxejBo?=
 =?utf-8?B?Rkp6bVJ0QlFRWEtHY2RLZzVHTEo1WTg5eStHNlBKTTZFNDRSSUt3Vk5EZzNk?=
 =?utf-8?B?M2txc24xOEhxQ29VeUVuMzd4ZXMzc0tLdnhhZ1ZnMUFPZmlSWVR5aTQxUWxm?=
 =?utf-8?B?aFE5c2MwVEM1cWxqMGo1K0l5SGFKY0ZxK2Vvb3RFUjFqdFRXUFFjdUNnRTJa?=
 =?utf-8?B?elN0S2c1M3pWeTVSTjZidC9WVDJob2oybzQrR2VUSzBTQ291RTJmaVRSSXg4?=
 =?utf-8?B?TUpxeEROaDU1NFFhQkpuczJwYkovSWZBdkpvMDI3T2M0T2NZMUhDVGQ5ZGxF?=
 =?utf-8?B?QUQ2aTlITmZqcmVjandlNE14QlRQZ0liWWFlTFRqT2QrWUpVTXpvRUtQQlpT?=
 =?utf-8?B?cklaMlJPd2R2Mk1nT1QxUUdHUVRlUXJ1YzdsSi9OUXV4Wk1SRys4K3Q5cGtN?=
 =?utf-8?B?QWtxMmlCUGx6bmxOdkV5blo1S1BDSFZVMWdCSnJGTWlsTTI5RzIyVThSYXVP?=
 =?utf-8?B?Z3dOdFgxeEp6TndXR3NGZFFNOU1oeFh6TC9wdC9WTU8zRnZkVkpMYzFMdVF4?=
 =?utf-8?B?OWtZN2VRREN3NmhwU1I1cEhrb3dXRkFRWWNuRDYvK1l0T09xMmJLdXlRQ2tK?=
 =?utf-8?Q?SE6T8K10hw4xefont8jqnxQ3i?=
X-MS-Exchange-CrossTenant-Network-Message-Id: acc42d13-bd9c-4ea7-64af-08dc9245fe3b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 23:00:49.6431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4y2yfhNA6R/oI+M12/VSTLKOzKZ+wBTH4evQOjFLmRUA5gSQgY3gG3sDwfoxshSv289WFIRoVnK2mKRvlXnCUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7011
X-OriginatorOrg: intel.com


>> +config X86_NMI_SOURCE
> 
> Lets reuse X86_FRED instead of adding another hard config option. See
> below.
> 

I mostly agree with the suggestion here but there seems to be a bit of
confusion regarding feature availability and feature activation.

Availability and activation of X86_FEATURE_NMI_SOURCE depends on FRED
but not the other way around.

In other words, CONFIG_X86_NMI_SOURCE would only be useful if someone
wants to disable NMI_SOURCE even if both X86_FEATURE_FRED and
X86_FEATURE_NMI_SOURCE are available on a platform.

This seems unlikely to me. Reusing CONFIG_X86_FRED seems reasonable.

Sohil
