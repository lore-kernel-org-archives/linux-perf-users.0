Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFB51F582C;
	Thu, 17 Apr 2025 06:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744871124; cv=fail; b=O0tWJdBKqzBRSYdnjLJhFkGeAa09chWPTgmy6v5W3KC53T9IIuxPIU32s0PxqkvqBARzGTeNAlYTjN8yxILb4exs3J91JBE/7y3QCQ1shreCK/R4R/Kt8TwT5zj/Wbuk1k+duM/dXfyQqRoytVO/Qf3k7HrnJNg6uBMusp8T+CE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744871124; c=relaxed/simple;
	bh=Ue2KvrV9xhGEyn02pTzsGZSD3wJtSY/e6LC58pnxBA8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=elsT6wSV6hxIlJMVVDs7iNMW2GgW+TAq9MrPyNGbAQe6bDI/rBlzhUjyHuJShh0PJkUFwvr5ONGKkiWOfEEz+esEX8ebcxXYeD1goOma0BGb+We8VBUVC7KcwfH2vJbc++yP++oG+yvRHj18Mn6eJIDqjg3pmyRxxmB9co+6Jmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dxofaLx5; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dxofaLx5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744871123; x=1776407123;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ue2KvrV9xhGEyn02pTzsGZSD3wJtSY/e6LC58pnxBA8=;
  b=dxofaLx535Y9HI2b+FhASb86SmRyNPK+FKFL0s7eUa6jfbNsvALCpmgV
   9nyyOv7votsIsrQr7rsdsDPUsgF3jfydswCyEvQiFknCSFF0K42gs12PQ
   42MXPY0nRot7RfVm+Jw357nJZwZnHvsiIr4qsOKn1rBeVDxSQP0KDkIV/
   YSOJb0v9l0S07F7NfDYKZntzcRaaSKkJwOkJhCAerDsLPWnD7Hm0KcUoL
   v7zqu6Aa5ger/b3OARSNLrZpfJn4dGhkrOri772iYe5TPcVCL7dW5tdyM
   6h0lJPp3MfJDMDRta5NW/MmuiNeJISGvcoFmMsbxtuCXDn/QGfnfTkZ8/
   g==;
X-CSE-ConnectionGUID: UslOEs2XRIOBxa+I09t2/A==
X-CSE-MsgGUID: y+TBXxOYQY6a1AMt8f8SeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="50252977"
X-IronPort-AV: E=Sophos;i="6.15,218,1739865600"; 
   d="scan'208";a="50252977"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 23:25:22 -0700
X-CSE-ConnectionGUID: SZ4maD0xTbixQBCfvuPOlg==
X-CSE-MsgGUID: O4outRvvTzGu6y4dGT0r5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,218,1739865600"; 
   d="scan'208";a="130690444"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 23:25:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Apr 2025 23:25:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 16 Apr 2025 23:25:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 16 Apr 2025 23:25:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tk7KAT199V2/gxzbEZh419owNWMYU/hAsgTaeMCB11nD/q25DNjYLJRZJnPym5+FhA/uZVoSM8CgzhGJC8QBYJZEMeg3tyv+VY7/QbpFXSB97Vofqux7VNAsNUUFY7mNkjW6vrSmagMCKJNwOPHgXgDXPdQHJ15QHfnSZZ3MALZngz6dbGP4GP/hgcmmQUtBwHODwqIjE4vbQaaqDb62e9ZKtNBRIxH6lqdIxAAHzc7q92WPgI9iRdmDdLuAr376vbU/VbD1OOwu35h/IbITiIFvgTsUYrOdjk30y8wAW0OgQf18U9ZDG+PfV5sYccJ2iIyxV5gNfGvsC9fgBt7clA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hyqXxM+OhvsOvvfC/vAW4LynXN+1fQKJl1YF4HcENA=;
 b=gVSpwiFHyWrUMkgKIrP0CCH9JXKbrFHyDH1M0ePwg/Bc2JsA3zkJukyHlzTOFXoqlJG86WL6CKF4DZ5OTWEr9PNkhmnpB3h4BI6koAVCMyxTazq5+yIrakyTf2mJwnZ09RWyFSjmWCKGzKCLx2L3sSUbBY1jzBCfYjdTbMUQ68+No4bUwuh5JNWMCfQDlh5DXK3HFkywk39YRFsHbgOO9qy1SfkyULjJzieYTsL/kw8ixI6FiahodPoo7goOUw/lKb51mvtNvmi7a8milub9Fz1cFFtugCdqY3MirBqwyHenS174MXgHBbvZStEQjEbzOfGDXbqGeunsvnyLAsOdWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8)
 by DM6PR11MB4627.namprd11.prod.outlook.com (2603:10b6:5:2a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 06:25:18 +0000
Received: from PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301]) by PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301%2]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 06:25:18 +0000
Message-ID: <cf18217c-a650-405b-86fb-7c60472a4b64@intel.com>
Date: Thu, 17 Apr 2025 09:25:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: Fix JSON output crash with intel_pt// samples
To: "James O. D. Hunt" <james.o.hunt@intel.com>,
	<linux-perf-users@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "Arnaldo
 Carvalho de Melo" <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	"Mark Rutland" <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, "Liang, Kan" <kan.liang@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20250407162211.172951-1-james.o.hunt@intel.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250407162211.172951-1-james.o.hunt@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0153.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::37) To PH7PR11MB6054.namprd11.prod.outlook.com
 (2603:10b6:510:1d2::8)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6054:EE_|DM6PR11MB4627:EE_
X-MS-Office365-Filtering-Correlation-Id: cdee667a-cec8-4037-7233-08dd7d789f9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDY1R1pGYXpReURWdlJXVTNqdGNET3hLWFVqMjJtNnlzTjhqMHNVSk92ZzVZ?=
 =?utf-8?B?aHJqdGlQQzJxVnR5Y0grd2RpQjErWjFqS2VoeXYyUFV0emJ5NExXanpLK09t?=
 =?utf-8?B?Z21saXF0czJPMUdBQ0RFem1OQUNDbEVBVnNGMFI0TVBSclBoSHExSCt3TzhX?=
 =?utf-8?B?eFlNZ3RnL1VHc2ViZkxVdjZlL0szNytzQVd1aUZJdE1MT3dSalVLRXg0M0NG?=
 =?utf-8?B?WVA3aUpNUlJzMmxzdE5pYjRZQ3RHdFZLa3M4N3hUY2tSYUJsallHNHJDWWsy?=
 =?utf-8?B?SUhZM0hnSHZqajkzUEFBOUQrNzc1SG53cWU3VnkrZzc0cDkycGlPVGRjOW1Y?=
 =?utf-8?B?M1NDRFpPUUV1RWpHODl5TUxZbjhvS2FrdVh6OHV2VFZrS01acSt4dWs4TU04?=
 =?utf-8?B?WHlNUXE5SUpUT2RpMzh2c2J4OGRXaWFONDRTNXkva1VEYXZZdldYTGtxR1ln?=
 =?utf-8?B?WDBBYTNPWUNET1NYN2paOHRQTnd4NXkxRnVBSEE4dVpwVmVrRWhxM0pHQU9P?=
 =?utf-8?B?OXd2bkl5TUNHNVQ3S0tqR2IyWW1JYUI2U2Y5VXFyYzVQVzJEMTJZV0JnMERO?=
 =?utf-8?B?dTdrOUxDRXZLdHRiRmU3dFZ0eC85V3N5TVpJaHVEZFNBbWEvSG1qK1B0NDhN?=
 =?utf-8?B?aXNKRVdHVWtDYThmZ2tYek5IKzEwUWdMY3N6VlA2WGtWTW9VRUdHZ2d2a2JJ?=
 =?utf-8?B?dXErVGZNck1zK2pFa3dQVzExM3JLaXgxQldYYzVNbWVXVWJtOGJXZ0pveUV4?=
 =?utf-8?B?eDcvdnk0MzZhSmZRemg1aHE5Y3AxVHlVd254WEdXTVAvNWlmcnVTR3lmckV6?=
 =?utf-8?B?Mk9hdmZvVVNWZU1TTGlKRUtMY3VPblZsdzJaMXFZOThzbFBXOEZhdmtuOTJ4?=
 =?utf-8?B?cVdHVGIycXowSVpZQTI3dGg0T25PN2gvenNWVlVKOWxVYmk0ZDdxeldRNmFS?=
 =?utf-8?B?NFY4UTlrRnUyVWtGblR4alFpUkhyeHd5Y2t2MTBXc01CQjdXTkVJNngyZGJZ?=
 =?utf-8?B?djBDZjdPekhYMCtxUjBWeFVjOHpMU1NGSXNJOEwreUcwWS9wcWhhcmNybjgz?=
 =?utf-8?B?N3RzTG16MHUzUXlGNHBHRGhJODdzRitmV1JNUDBMNEx1Rzc5UG02aWFmRnNP?=
 =?utf-8?B?bS9oVS91dmFFdldLZlVwcWYyUGEzZ1VsMDZ0QnBHWk1hYTI2cDIwQmh5ZFl3?=
 =?utf-8?B?WGVFK3lxQW1PV0VnaDBIZjlsaTg5MzFlMkwxbjBjbVNYdUhFblRvZVdFVWlG?=
 =?utf-8?B?WGx3UTFDRExiVDNNNHM4S1pFSkpzRVhYYTBZY1hYN21sblorcVo3Qm9jTkQ4?=
 =?utf-8?B?MHdBejZzZTltZlVaalFGYVNpalBkY0FSU3k1Vis3QkJDRVYzZmVXQ0pIMXBG?=
 =?utf-8?B?eUNTMmJDTFN1UGtMOVZHMjNhRXdJOGZDMEMxcWxEZXRZOUxqWlYvL2ZLZlA3?=
 =?utf-8?B?bDdESnVvR1hRN3E1VjNCYjErMERUcm9qbE9TRGwzd2xMQll4aHNGaFBtcWxF?=
 =?utf-8?B?NEU1bzNCY3FNR25pOXNLai9UalZTYVUzVEZaVmhGamFYZlZob2RTMElUOTlN?=
 =?utf-8?B?R25DajBBUDh5dHpzejIyb2E3ZU1FaEZkSWUxK3JaZWcwUUpXM0IrNUlrMWRo?=
 =?utf-8?B?emMxa2NSclRuSUZHMkk3N1ZNRFJWSnZWRkNpSzJxcExGQlVsVGVQUXN2dFBm?=
 =?utf-8?B?WHptMlh6NXRlUzhiMmh3ZmVNaGUydU5ISk1HbTF3RGNIRmJSbzYzQXdFcUpN?=
 =?utf-8?B?TEkrZ3R0MlRoeFlPZ0tzZDdYU2ZBRndDcHVpdUVNVlpFcGtGQ0RIT0xsczJ1?=
 =?utf-8?B?WjdhNmpTZm5JeEFRckVCaXFJOG10enpkUnpqL3lIV0tsK1lvVWJDWWdadTBp?=
 =?utf-8?B?WVVTUTVETDhlK094ZGloOVI3L2s0K0VONWZoUWlMRUVZNHBZQy9PdzRYSDRw?=
 =?utf-8?B?cDl1azRiOE81NXZiS3ZFVUkrZlRlT2Y3U0RzRjJEaWdhSlpFY2xpOU5PTGhV?=
 =?utf-8?B?ZjE5d2hrTE9BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6054.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVNYd1ZxS2tXVlBZRzc1cmUyeHkrRlRnaWh5ZVpiZllpVUtOdnIvNGtYaVM0?=
 =?utf-8?B?bVA4WUU3bVVOU1NHRlpTd1JVQzVzVjZVMnFLQlZFTzhJMUw5TEE1Z3JhRDJ5?=
 =?utf-8?B?UlNlWlgvTnF5c0wwU2JpbzJmbTBIVm1DZTZFbGZhVGJJeDhZbFFxZ2gvMjBE?=
 =?utf-8?B?bVVtMzFwUWhwR214cjNEVXFDWWdHbTA5ZVZKdGRLNXRUZm15Q051cGEyaDRJ?=
 =?utf-8?B?cXI0czQwZWNHRllhY2FZOUs2UUhveExxQ2dSN1p2NVpyc3VHZ1VBR1h6YUt2?=
 =?utf-8?B?QXFDUmdDR0R2Z0dvczdrSFpoL2k0K3ZidE0xam9ydFZ1NjA4c0p2YkFiZUMv?=
 =?utf-8?B?cDhwQmRvNWNFdUpwS3VkRjkrck5GQ3BHa0RRRCt6OW1sRm9pcmRKZjI2Vitt?=
 =?utf-8?B?ZUhzMzJnNmsyNkx3YWh2a0dxSEVPUFI0M1I3YlJ2TmFHNzJsWUQ5b2hRRE1x?=
 =?utf-8?B?dDVnUWJmRXVwc0g3UkJ3bkdjZ0RLNU1LeldnNW53dDVwYVNFeXVCVHZESWtz?=
 =?utf-8?B?WjJRNVQ4WUFqdmNIK1VpdnMvVEpybWxuYTBON1NvbzdHR3hDd0pydlNJeWx6?=
 =?utf-8?B?b0VXNncxQUN0SkF2elhqSTA0Y3h1Ky9qUTlUTlNMbkFwR3ZoNHl5cURYeDBD?=
 =?utf-8?B?cmRCczl5Yk5WcTlqRXF0NWdsb2pET1NqRUNDWWlnZytjbHY0RmRoaG9JS1ZI?=
 =?utf-8?B?SHE1NTAxdko5dk4rdW1XbUgzU2RUVUNlN2JFTUNsL2E1WTgyVmRtRm0zMisr?=
 =?utf-8?B?V2ZLRXZhZkNBc293ZWZDRlduZUNiOXFMYlZYZGwvb1plSGtUSmVyRzYvc1cz?=
 =?utf-8?B?S3o3b2xsZStiWWtpN2xEQ2NBWGtmZ3VCcDh2bXhRSTBrZERTMit4bUNpaUlB?=
 =?utf-8?B?d25HMUdFUzd2Q0wxMGhQT2xMajhnWHptT21UeFl0SFZVQXNzejFEVGFYdC9N?=
 =?utf-8?B?a2N5dy9yQXRFQU9JNGc1QmlkV0JYam1SUmlhUjRhT0V0cEtEbHg2cHB6Vkpv?=
 =?utf-8?B?U2p2UnJNeitKV1Iya012ZGNxR2N4YWtMU0dwUmpxQ1R2dllBdFhHeXZSUEFt?=
 =?utf-8?B?NzZVOWNTWG12cHNlUFAxZUVZZjR0KzkraFQ5NWR4aEVNMWwvV3Z1UTNZeDd6?=
 =?utf-8?B?RjRiRFBIcUFuRDN4QUgzMU9YYndRdnhScERQbVZaRElSaGk1Z3MzbkxmOHJ5?=
 =?utf-8?B?dTJiTzJPVXVIS2VvbVJVYkRlYjFYUVU4SzJ6c045aTJuZXJyY01PTFpYS0lR?=
 =?utf-8?B?REdaeGdsMURqcTdjM2tObEFDM1NNWmxNVG1rNUdwWkx1bmZVRWJiTm9HVGty?=
 =?utf-8?B?b29PUUdpUG5VMzBncmM3YzdmWnplbEl5ZjZWb1o1RlRSeHUyWnZXeENrTDlH?=
 =?utf-8?B?Y2RMYTYvcDlacFBGQ1ZybWR3WjZLY2RYcE1BRDBEekdnS1owdEk3YkxkSHJR?=
 =?utf-8?B?TG01cWl6eDkzREsrb0owUTFVM1lJM29GOENRUjlQU3FJSGlHemVic09yZVJs?=
 =?utf-8?B?aUVHK1FHSmRGVXlUN1QyOVZ0M0p2SzR5NzBjbi95QnhianVWVDlEcHpRaERR?=
 =?utf-8?B?ZkxXOWhKQ1VFTjEzTktJU1BJbWdLWEhBQ1kwTEhYblNtUWFGVVBmR1lXNTVP?=
 =?utf-8?B?clFpOFlmb29jNzV4MXVGcUtVMk4zeG1zYlRuaVk1UlN2cW00ek13a3hkM2ZZ?=
 =?utf-8?B?QS83QzhDclpJR0k4ZUhUOTlCRHhNZjRBR3RLNkpCeVhtTVIwdVpoL0lNaVpi?=
 =?utf-8?B?VDlTRVh1cmhISmp1aWJXOG4zZFZFT01mZGpXalpWK3kybjYvc3RPVmhSdTBG?=
 =?utf-8?B?WjA1dGdWc2RScGkwWWlTL2c4QkxWN2kyZ01HbFJQWk9oNWZWRFRWKzNCd0g1?=
 =?utf-8?B?MXFxeFNCU2tHSThRTW9XbEJUcTh0Q0pQa0c1S243RkNmbVlOanp5dGtZMUZa?=
 =?utf-8?B?MXk3NTNFeWlGc0RxdDhaWmZXcnp1TVFwSUYrRk4xSFF2MCt2bVExZXRsTm9x?=
 =?utf-8?B?bHM2YTgzU21pMHpRRzZ1bnFyUTRTQjZjT3pkUEpUTHFQd0pMWi9TN1NVbVhq?=
 =?utf-8?B?WlpOZWsxWU9kRFMrMVlwRVIzSk4wdkZuTGJyNjVTVk1JeG5aVGNyRks4VVVI?=
 =?utf-8?B?MjNMUVRLYStmekhUQ0hPemI2cXBFR1pSVmhNb3UwUC9SdDZ1cjZ2VDQ0SzNK?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cdee667a-cec8-4037-7233-08dd7d789f9d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6054.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 06:25:18.6699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0pFis6uZndgfcxzt/1Vh+ml9FXZNZiqjcu76mknOxKnd2izw5zgXZwtlgSWBgKb79qcynaZKUG7PhluDOBBDFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4627
X-OriginatorOrg: intel.com

Subject usually contains the relevant perf command.
e.g.
	perf data: Fix JSON output crash with intel_pt// samples
or
	perf data convert: Fix JSON output crash with intel_pt// samples

On 7/04/25 19:22, James O. D. Hunt wrote:
> Current behaviour:
> 
> ```bash

Might want to go easy on the backticks.

> $ perf record -e intel_pt// true
> $ perf data convert --to-json /tmp/perf.json
> Segmentation fault (core dumped)
> ```
> 
> With fix applied:
> 
> ```bash
> $ perf record -e intel_pt// true
> $ perf data convert --to-json /tmp/perf.json
> $ jq < /tmp/perf.json &>/dev/null && echo ok
> ok
> ```
> 
> The crash actually occurs in `intel_pt_process_auxtrace_info()` where
> `session->itrace_synth_opts->set` is unconditionally dereferenced. This
> platform-specific code could be changed to fix the issue, but this patch
> fixes the problem generally.
> 
> Fixes: f6986c95af84ff2a76847910b4322f542b793bbf ("perf session: Add instruction tracing options")

Full commit hash is not necessary and no one uses it for Fixes tags.
Should be 12+ characters but not much more.

Note it is the wrong commit.  The code was added by
commit d0713d4ca3e94 ("perf data: Add JSON export")

> Signed-off-by: James O. D. Hunt <james.o.hunt@intel.com>
> ---
>  tools/perf/util/data-convert-json.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
> index d9f805bf6fb0..b0aaa23659a0 100644
> --- a/tools/perf/util/data-convert-json.c
> +++ b/tools/perf/util/data-convert-json.c
> @@ -326,6 +326,10 @@ int bt_convert__perf2json(const char *input_name, const char *output_name,
>  		.force = opts->force,
>  	};
>  
> +	struct itrace_synth_opts itrace_synth_opts = {
> +		.set = 0,
> +	};

The problem is that this sub-command sets up the auxtrace callbacks:

	c2c.tool.auxtrace_info  = perf_event__process_auxtrace_info;
	c2c.tool.auxtrace       = perf_event__process_auxtrace;
	c2c.tool.auxtrace_error = perf_event__process_auxtrace_error;

but not itrace options.

Other sub-commands either support the --itrace option:
	perf script
	perf report
	perf inject
	perf annotate
Or are limited to memory events only:
	perf c2c report
	perf mem report

In this case it looks like it should either support the --itrace
option or remove the auxtrace callbacks.

> +
>  	perf_tool__init(&c.tool, /*ordered_events=*/true);
>  	c.tool.sample         = process_sample_event;
>  	c.tool.mmap           = perf_event__process_mmap;
> @@ -377,6 +381,8 @@ int bt_convert__perf2json(const char *input_name, const char *output_name,
>  		goto err_fclose;
>  	}
>  
> +	session->itrace_synth_opts = &itrace_synth_opts;
> +
>  	if (symbol__init(&session->header.env) < 0) {
>  		fprintf(stderr, "Symbol init error!\n");
>  		goto err_session_delete;

