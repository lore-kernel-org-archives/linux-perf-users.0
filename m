Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E76217BA7;
	Mon, 24 Jun 2024 23:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719272290; cv=fail; b=JkEb7q0Zi+06hm+RcR8VjHe3yQgGjxQ3XfT7zuLCeikCKzLRSutBP+1+zVFuqB2YdH3CIK7+9MFoqydp63dgws+x5dDnyETlQhZTcigcAh1SapB3kufYLLT5oi9/BlbNI7HarlUBjav43c428WWj63POZjBqD73GP3QnY/UT+Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719272290; c=relaxed/simple;
	bh=CT1RxOhV2ru/wDn6FABAHl+3lecIacdXDea031rSvhg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z0MmQwRfb7Vbv7WWWrzN50kiA3WoOwGZyjgev9bQITU2d1VZtup7Ou/X1sZ9d6qWIxZoT86ddAWlk9z8xoM1m5wE5KqPLSTnTdCcRlRnkWA2dWbTLfEfv47RtrjGh6wFZuofxwHnxZZy8c/6z9fNjaQFr5rxSYSFOfH+jtF8Rxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hid95Vos; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hid95Vos"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719272288; x=1750808288;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CT1RxOhV2ru/wDn6FABAHl+3lecIacdXDea031rSvhg=;
  b=Hid95Vosx3XEv3wMJhWR+orQSAo0HJMgTT31AzqzSuaYdsYhc0Pd5Dsm
   TzipK7Tixhpunj4pNl58/hWm2x5UuPMyV2Z67Uf/+tzPePCg3hg7qtdv/
   5vAXrEUa6jchL26e9lPnbFghZsVy4ETiSeLTL6AGxsX3Ghi8CAz8hHmUB
   EjVyKO0/XcMfZ2PFXFk35Lcrq6pwQ66XbpHuY0BM09WQ2ficeSTJm2jQL
   I5LKMiNOHprTsIrh5P7DqsIFDAjy0geuqhsr/B6pdIGjOa4uef3qqNxGb
   4CsTDekIzPtidDshVh/P/XfbJ+La/evmbP3GIukNiuLmdHosoBZCgqYWh
   g==;
X-CSE-ConnectionGUID: iuTjcsjDQz2/hJ0p689GRg==
X-CSE-MsgGUID: 7bUedWb/SQmtd+ArVKU8eQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="38780714"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="38780714"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 16:38:07 -0700
X-CSE-ConnectionGUID: fsesuOhQRHiuKJKIHxap/w==
X-CSE-MsgGUID: 2EqOCWZ+Sg6YxsVItZWJtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="43525778"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jun 2024 16:38:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 16:38:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 24 Jun 2024 16:38:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 16:38:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSp4IEBj7ezuWaFSFOolUknkO2a0JcT3/luP/EKKw6jjU5rl1xYoX7ec++IQObcv8hcgAQUt3UERwm2f1PAAwCDN0Tg1P09TBIYrZPpZ5LYhmRB6qL6AeJDjoFYAdoqr8nL6C4vZVvN7lfVp/UPpsUUlKLGhOj9Lz4JVV7d366WG9QeTRYOUQT6xrQO8vsDnzLOHudO4Uf2m8hZJ7RUxVs2V6ZDwgMDJ5loQy3WuyjNrrcX6ruNifxQCm9Y3mxRIbx4HPnpX6Blm7gCzk43J9ps19LcwUIEGFh1YCTvVIH1hY6npivjA1uC9oxyfdMKX+ieI5rucUqK9UyTaz9m/iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tD/Q+7m8atgRcVD2ZNq+hwZTF6vikdKXt2Mw6WKHZUE=;
 b=iQM4Hox23rtYTINcSPZ5nW1JOB2HJaUFRAmRN8G3qPVCjAw6Vj3WzBic3uNbdgJANr1yU+XIIRXUFbQswOpVIevY99pcSMPp8hyle6pIQPw4fZUMstmLqs8cIfOk06FI9Ny+PDsZbN4FOzgOPBrv+XRstVA4IK+zE4XLfBOluQo/wgwSTFG/99nYKqA5zKXzgBsVCHZRba14Q4fAcPIo8k76bU65rCPYzxatFAYpd/1foy7vi17A8LDwvwpJLVjoFvQcpN3vg6LywZleCBP8hOlNdOgdWVg6vDFJzjRTHN2/U/xUI9p6gx3jK1Ct33VfG7OVk/yDWxe1IQNQoxKR2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BN9PR11MB5324.namprd11.prod.outlook.com (2603:10b6:408:119::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 23:38:04 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 23:38:04 +0000
Message-ID: <5076264d-f74e-4774-b5cc-40a5198e925e@intel.com>
Date: Mon, 24 Jun 2024 16:38:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] x86/irq: Process nmi sources in NMI handler
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>
CC: X86 Kernel <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, Dave Hansen <dave.hansen@intel.com>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	<linux-perf-users@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Andi Kleen <andi.kleen@intel.com>, Xin Li <xin3.li@intel.com>
References: <20240611165457.156364-1-jacob.jun.pan@linux.intel.com>
 <20240611165457.156364-5-jacob.jun.pan@linux.intel.com>
 <b2a230b0-3f00-49b3-87fb-63622f697395@zytor.com>
 <20240612145424.61890aa3@jacob-builder>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20240612145424.61890aa3@jacob-builder>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0020.namprd16.prod.outlook.com (2603:10b6:907::33)
 To BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|BN9PR11MB5324:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f582f1-9f89-4f63-0663-08dc94a6b16d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cy9iTmgzZ3RyTlNJZFRGNGdMR3p1YjRyR0pJaDkxTllFYndaVDg2WnpYbk04?=
 =?utf-8?B?Wi95N25ybThwS0ljcXpERlVvdlVQQ0JpRm00QVBLdzNzelhUcEFOQzhQcWo4?=
 =?utf-8?B?d2VSY2RhNnc0T0N2ZlZhY2lMVFFsNlNTYkdpQkJaWUFWdnJzcFAyMkNTU015?=
 =?utf-8?B?T2x6RUYzMWhRWXo1b3Zmd2FLbFBuVWVLNGJMeWVNdFpsZnYvSXRpczFoRTYx?=
 =?utf-8?B?bTByUExXOEtYMHA5OVZKdGlFc1R5amxvVXVHS2ZpWnNKK0QwRENNRXRVTUJn?=
 =?utf-8?B?bzI2Wm1iWFduVnF5dTJnVyttTHhxM3FzZlpSUGZvaE1ReDhaNXBFZVFsZTVw?=
 =?utf-8?B?VW9OYTEzUmd3NExBdWJGSzNvK2Z4N21TVXNBbWNPMkcvZE9raUhIUVBZN3Vx?=
 =?utf-8?B?bTdQQXhYZ20wclVRZzlPOE9veGxHbU04QzJ4QXdVRVlMRUdINkVTUkhzSUpM?=
 =?utf-8?B?UnlYaGVMcllWVFBNRFZDWHI0bnA2dWk1YmkzaU9sMkdzTVJ3WG50cnptL2Vq?=
 =?utf-8?B?anZlQys5NFVzMnFUR3hXMWFGVmtBV1UwOTZKWVlIQlgxNWdjei9wRHBGd2xw?=
 =?utf-8?B?b0dKYjhRK0MrbXh6QVN0V2dlUFVHWEVlQjQxMStWNXZRUGc1QVNIcjlBSHJm?=
 =?utf-8?B?b0MyR2ZUT3FBcmdsNG1HYlQrVUNhTnovcCsxMTJyZ1V5eUJzaXk5OGV0ZU5u?=
 =?utf-8?B?WmNYc1NzcHJNdXBsWmYxUG0rNVVKNm1OWmliZVBXcHBDTjZiV1VaSjQ0ZlRP?=
 =?utf-8?B?Rk5maG9ZSERWaXpZZk0zZHBrSld6VGNzMkh2RkwySWhiQXNyejhtOTBOdmMw?=
 =?utf-8?B?NWpkbXNlQVZnZzFxUGc4V1dJR1drY2dxVHptczQrMnRqeVA0Mm9OWFRITDgx?=
 =?utf-8?B?ald4SkpLTU14T1hDNmVDcWN5cVk4YWN5SkFiMVFPaS9RbUIrNmRiZVlYdHVU?=
 =?utf-8?B?Zjd4WUNldE4wOG44bXkxZlhtd0YzaStwTmhJc2s2K3lGbmcwbVdQVEdFRUg5?=
 =?utf-8?B?NE40NzBVdzg1aXoyRzRXWU5iSUo2SnZaTXoxY2hWeDFxVE5oTmNvaGxLeTVo?=
 =?utf-8?B?MStVSWVBVzlyYS9qZCtxUXhDWGlaWXZyUlJqR0V5RnNsV3hIdGNVclVjWXZO?=
 =?utf-8?B?M2pLcStJNWY3TFhPc2JFeVZYYzhMNTM4aHBuLzdCODlxdTNCVEhIR01raW95?=
 =?utf-8?B?NEpFSXFKVGFMOFV3ZTk0L3lTY05WbmRpc29MeWhydC9jNHYwVUdHdGRYZmxM?=
 =?utf-8?B?UmVLL2dzNnlPYUlYTjRwc3luUGNqUjdKdEFMNnZQV2ZOWVBIZmZpVmZRNVJm?=
 =?utf-8?B?bXpLa1dHTnVPVXFEaWlqT0lIUTE0TVZnYndiWFJ5M0FHTHZXK09jNFdFb2tZ?=
 =?utf-8?B?djNja245eWt5RUNGeE5zK2xjU0lVQXQyUTBUUmpxNHhEMktkck41ZXliOWpI?=
 =?utf-8?B?c3YwSEkya003MGkxYVkzT0pSZG1FNEdpdEM0cDhEMHkxNk1IMGxhM0U3Unc3?=
 =?utf-8?B?Z2FIbDBEVnFjdTV0RjF6WEFqOWxrUXFUdVo0dDZVaVduWDF6cVNJNVZ4V0Nr?=
 =?utf-8?B?L1JwU1E0N3JXNzZYSEpZbC9xeTNvQkRYRVRwd3ZESUpESXJERHZKMHpMVlVI?=
 =?utf-8?B?b2phSmJUUnpOQXQzMkF3ZE9tWkJ6Vmc1WG1WTDM3T0hRVVg5dHpldmRvR1Ev?=
 =?utf-8?B?TkloK0RUSjRLRUtmRVovMWpCRlpHVWlIek1SSDJmY2V6eE91c1RUTUE3aUZ4?=
 =?utf-8?Q?jHJbeoFExqFh7V0aFA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2NIZVp0ZVF1Zm40SWZNUVNvQjh6UHJMRHJGMFhIZzY4aDFEaEZCTFQ5U0Zt?=
 =?utf-8?B?cEx3Vk5mZWN6WUR0czk3NURINkliYTRYQlRkQ2t0MElrT1R5YnY0eFdUN2g4?=
 =?utf-8?B?czlsY2ZNYWN3OFJONTJ3TnNwTW4rZVB6cHVValpwVll0WjhRQ3VUcm9OclBj?=
 =?utf-8?B?a0I0OUlJb25lbGJpSzV4Sk1waDlNVlVvWDcyTGt1UDR1UDMxRVQxWTVtWlRC?=
 =?utf-8?B?SlhmRFh3T3l1Z0taNnhNdFhROFM5YTRBVlhVM3FaN21yYzVwcEVNRFZCZmxq?=
 =?utf-8?B?UFBuYytaODEwbnUwcUZkZkgwaWZzUVMvN1J5WlB6K2lxQnRxcDU1TnY2cTFP?=
 =?utf-8?B?eW9pR1d4RDIxTVhucERTVUxnYXo4OG9iSUYreG1RSE1mMWprTE00RXFkc3FS?=
 =?utf-8?B?ZjNCb3hNdWdmdlJ4V0t3ZVN6VDJjL2VpbW96cWxMSTF0Y2FqZGEzb0h4ZG01?=
 =?utf-8?B?VDdWMVRBalBQUzBjL0hacEdQTm9Gb1phSHczakd0RDhMS3JiRUZGVlBTZldu?=
 =?utf-8?B?YjUzSVk0S1hadDZsYncvYVhVaG91bEVnSXRjZkxjcUVvRlQrNndyb0x1L1hD?=
 =?utf-8?B?Q0MwUm5qVDBlOUw3aFlTelBBbk44UkJtWnUveHJJRGg4TUVwQVd4QXZaWGl3?=
 =?utf-8?B?c21iNFptREpBbVNNQWpvUDNGVVBiVVl5Q000YWNJUUxURVVQRFJpY1VlOVNr?=
 =?utf-8?B?Ukw2cGhrcVNpRnNFUEx3UmVUYXFhckpHZ3l1N3RvZTJuVFpQRFM3TTFvNUVm?=
 =?utf-8?B?NFY4OWM5TGdsN043bUxrTW9iK2lxUUVQRFMwd1dqUzFtNklUVHpxTG1rQmFv?=
 =?utf-8?B?RXFLMVJlWEEzZnkvdVFMZENGbzV3dXNPNUgzUGdOK0x5SlVTL0RHUkRveEQ0?=
 =?utf-8?B?S0xLVjBiTVAzZ1VVamlpUTJ0RjhCWGN6R0dENk1odTYrWVd5MjdTSnhDZnpQ?=
 =?utf-8?B?dmpDTDdhOUt0QjkvdCtCdkxpMlJMN1hHdkliRVNvclFRS2xTcWJsTlFvcEJ0?=
 =?utf-8?B?Mi9UOFJ2YzlsWnR2K3VFYzRjRTdGR0RCb3Nsdk92MEhQd0JBVHhhRExiaDFI?=
 =?utf-8?B?K2RRZnJWSlBPdlZHYU1FNXovOTVGVlo3VDlYQW9yekh5bVhRY3ROcENwRlZu?=
 =?utf-8?B?MEtVQm12ZlZ5bTc3clJjYlU4djBzUTQrTmU3M2w3MFc5Q0hhdXlYQzd5RjJz?=
 =?utf-8?B?ZDdzNjJjR2dHK0wxaW1nZ2hHLzJZWkVqUFp6UVovR283MmJoYWlBT2g2bjRP?=
 =?utf-8?B?Tlk4czJLaytaVzVIZExHdjI1QXFTTjliYm9GUjMvWC9jeEhiNHk0c09iSDIv?=
 =?utf-8?B?d1h5Sm1RaXVTZGRIeEJyc0diVmpwSjQxOWtwcVFUUitCU3ExaE5ra0pBTmk3?=
 =?utf-8?B?RFZMQVg3cjVpcVVpNGJFeVZ1bk91cC9TSlVOam1NWWJDOHlWTS9lMlRuK1Jx?=
 =?utf-8?B?VU1waVdtSkp0cWFlNW5ISjhtM3htWU03aFRXeXoyOVEwcHVTNkRnc2xoVXFE?=
 =?utf-8?B?YW51RENHUzBSR3pDNjJsQzZVVFZoWXNUTGxFcHdmQUpJbkNVR29pV0pxbk9E?=
 =?utf-8?B?cDNaMGN4Q0ZkdUVMd2l3dk0rZnJlQ0JBQklnYjdrRFBpVjlXeGJac0ZwQ1I5?=
 =?utf-8?B?WURIdTdUUnBkVXVJRCtIeFg4K2pnWXozSU5MRVJ2UWxXekFmSnY1SmY4TnR0?=
 =?utf-8?B?d0V0SFhha1dHV1RSSGhkSlNEZUtLL013NG8yeENsWW85cnROVmJTOWx6bHdY?=
 =?utf-8?B?V3pjV2Y4UjdOWHUvQmhqaUllT0FmaUorUHlSZjI5L1EyMmVuQnpVUTZJZnFK?=
 =?utf-8?B?ZU4vR1VLYTlBbWdDL0tWUzk3OXlhdTZCS3VBREZIa3ZOcFA0aXM2WGN3TVRk?=
 =?utf-8?B?azllcjRLc2NQeEJidEo1NzU5YXBWdmZjY2ViOTlFdVFKaFR1RHhPVDJ4czVZ?=
 =?utf-8?B?dVErTC9WK3VJeFVmTnNKWlBheXRtZDJlOGozYTFPVDZ6RExwbVpXakd6ck9a?=
 =?utf-8?B?MzZjZTU3SHh5V01McnBCbGxnZUQxb3ZpZjVKZmZDcEpBdjFpSTJPYkJQOXBk?=
 =?utf-8?B?YTZaQkN4VDdkbnk3REF2S0FrZXpIcHpDaGw2S2FQUTFQYUpFSUIxS2ZQTTJO?=
 =?utf-8?Q?eA5sB7tU9RcvCbag6GuSwE7Lz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f582f1-9f89-4f63-0663-08dc94a6b16d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 23:38:04.3230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWAJJk4AQBIMY4i2iqLzD4MjShynPbNFF8aV5j6YdJcV1pwJ1YoaBnvKUzCqZqRG0CsGKz4ZWEV3x4OjuG/UmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5324
X-OriginatorOrg: intel.com


On 6/12/2024 2:54 PM, Jacob Pan wrote:
> Hi H.,
> 
> On Tue, 11 Jun 2024 11:41:07 -0700, "H. Peter Anvin" <hpa@zytor.com> wrote:
> 
>> On 6/11/24 09:54, Jacob Pan wrote:
>>> +
>>> +	source_bitmask = fred_event_data(regs);
>>> +	if (!source_bitmask) {
>>> +		pr_warn_ratelimited("NMI without source information!
>>> Disable source reporting.\n");
>>> +		setup_clear_cpu_cap(X86_FEATURE_NMI_SOURCE);
>>> +		return 0;
>>> +	}  
>>
>> Is setup_clear_cpu_cap() even meaningful here?
> Right, alternative patching doesn't work here. Let me use a separate flag.
> 

You mentioned this somewhere:
"The functionality of NMI source reporting is tied to the FRED. Although
it is enumerated by a unique CPUID feature bit, it cannot be turned off
independently once FRED is activated."

Does this have any implication here? What does disable source reporting
mean if it cannot be turned off?


