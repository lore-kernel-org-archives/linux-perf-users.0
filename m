Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2036E176AA8;
	Fri, 26 Jul 2024 07:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721977789; cv=fail; b=DoAFQK6XPVK3wNb/cj20f9T2/YcZ5wAH0AMvmQhHfeYVdFqBqD5GTx1smxnqiWsUcpzkk8linZO4mUtFlhbG2tuQ0BI/mHhOIwJMVmoP6yo9HMCvCLkfv+wYmiRwTICMnQDPtUWyMEHb7V8Fgzc1Xow1juFxvNqs5emEhzFh0BI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721977789; c=relaxed/simple;
	bh=FxloIBsvpnryPv3XB1Vwud+SNL/R88AHkfOpb7YiTi8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jc29su6W424L3faapcwr9AKCNLj/QkOehOaeqC+H9p8XkmmDzvRhE/lJW107SaD/99N224DjCkiIJSZM/gciTEhLno/Xyc88tJ0fcmixhoSchAWzOeVHzs7MSqYeRPeRFR6xbvSEu7gwb1GJrfQGNhisPOWk/lwzi595tQIFcmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MA4C+HAy; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MA4C+HAy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWZPG88i2u3bVlzCtyXPUYSUJ4EhHPoIhYQyLPJvEqY1/Hv0pi47oF27aRZvyurq8fXiCH9IxAWuT7J24Z1GzyDuA1gEJOJ8UQ/TBYi+ShlC3wyCHjugaZrh9kn9dbYVssNcJvFdQFbZBvuaQuOCTVzTE9BlAat1rSLn+TRR8Pp7IbCMIEmynMB4lpUeuDXhGIMd8gRUz5REHvIyxjjaVxmCu8EI5L9+16S30QdI+ZDDSIJYu17k3jTPkW6me0M9Xiil35khxIBZSvdJKA03DwchAVP2Gh66pDUhWLx7QZwngU1DuAVI/fk61tKcQ9EEveBV7vXxauZq/Tda78382w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6jl1CZVpcNNris2ZNSHx9ndDjjIrwitjV3BngDADak=;
 b=eoMwrmBquVFUJzGs1XJ43xVq1YNIOAc0NrX0pt6YNu0XtHYLfC+t+vNFPzABoz1IlGq+efTlNVbD3pb9oHtSSdQ5UwqKWiR3Bm3iGWsPe53hqCTxxIeBccy1CBKMXXReJBFEOXkUnI5ASb+N+D0HCjMxTe7y0RakivvC/8zcLJPUNhxDKrelDJTIZwD/xSZB22bA3p7IdTQ868hheOhpZQvbx2Jnz7sxvsD6OtV7KIQhmrWHvm4GaSwGHQH0GYnPcYOCS20agmvMvCYHNy+pzeKwH4NuB1hGBYizRG3PNB3G0SimVkOr9Ck9qzwUiX8ClzatICoebO0TxJGgm1n7dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6jl1CZVpcNNris2ZNSHx9ndDjjIrwitjV3BngDADak=;
 b=MA4C+HAyE8sR6DpDWj01KOaaeFreF7T/M0OMKMSwcF64LTRvpsEllTa6R5I4lqR9/To7RcvL/9QXlyrw7tAUU26IkJEUiTKJLsJOiUfoM4nkBbgdQL8B7wrkUhGFvkgB/hLm7L3xiqTK6oMRyDHD7YOAqdkHUz1QK9lL9208lW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by DS0PR12MB8293.namprd12.prod.outlook.com (2603:10b6:8:f3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.20; Fri, 26 Jul 2024 07:09:44 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%4]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 07:09:44 +0000
Message-ID: <3c3d1cd9-ccb1-495d-a670-9ee504fb0bbe@amd.com>
Date: Fri, 26 Jul 2024 12:39:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] perf pmu: Add support for event.cpus files in
 sysfs
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: Ian Rogers <irogers@google.com>, "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
 James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Dominique Martinet <asmadeus@codewreck.org>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, ananth.narayan@amd.com,
 gautham.shenoy@amd.com, kprateek.nayak@amd.com, sandipan.das@amd.com
References: <20240718003025.1486232-1-irogers@google.com>
 <20240718003025.1486232-4-irogers@google.com>
 <92ceb8b5-240a-4715-98db-c73e8e9d3e50@linux.intel.com>
 <CAP-5=fUfoMZ0HjCNoJe6hgEMi5ciY+LqFjBbLzfiZgO6dioshA@mail.gmail.com>
 <64030eab-6e95-494a-ab72-bc33792ef723@linux.intel.com>
 <CAP-5=fVMV4ZmGk4-XguqV=LAuif-MgAL+BK=mMAE1tC3f3tbhQ@mail.gmail.com>
 <e8872317-8e18-48aa-9f23-b98af9345bed@linux.intel.com>
 <CAP-5=fUjEYwdOdmfa5N7b8OOLWDitJKBdeOr8-+UOYWA5+ehkA@mail.gmail.com>
 <775d8f1d-437d-47a3-b4b2-da476e914cf5@linux.intel.com>
 <CAP-5=fUH+n+f_q1Tc-a3oV3vDV60VGOLANRFWUemDen197rYog@mail.gmail.com>
 <c4b499a5-7d2a-44db-bd0c-c123417337a5@amd.com>
Content-Language: en-US
In-Reply-To: <c4b499a5-7d2a-44db-bd0c-c123417337a5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|DS0PR12MB8293:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f5aceb-1c0d-483d-1a79-08dcad41ece8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2VRYU9FV2ZNVnFZM1BXN3BCZ1RyNElDKzBtb0lGTnN2V0IxbFVSbHpCT3hz?=
 =?utf-8?B?bFdTOEhKc0NRbjBaTVpTZU1KaXRrNmV6Y3NZWHdHSXFqeFJ5UzRJQXdwUnh1?=
 =?utf-8?B?VzdCZDRaRUZZSmVGMlV0d0c0TG1TdjZ6cFc5bGpZNkZONS9kM1QzbVpnTGF0?=
 =?utf-8?B?NmdNT3hlNDc4RTZFQkF0aitWYzI0bjNkcVVkOERwTEVQdXp1ak9kS2c5Y2pO?=
 =?utf-8?B?enRKWXdmMDdzUm1UclF2RFJaQ2JhZWpUSWdqcGFmY01hRk1TdXZ0R2RXTUlF?=
 =?utf-8?B?Q09sc0JGMnFUY3BRUGVDL25UUExpMWhzV2o0azJnVm9OTjlwakF4bDVmTzN4?=
 =?utf-8?B?Y2dZVVpuUkNNeFhJNjRwMVJEcndWaE53aW9uVi9pTVhYaWRLS090czIwbXlJ?=
 =?utf-8?B?QTdLQjJoblk3K1pGNW1pV3MyZmI1TEZlTWFJOVRMV09jOE11bjUrWUZTU1lW?=
 =?utf-8?B?RWpFSCt0Nk54UGp3Z2tWMFFpdWFDbk9RS0xjTzE1dmNjSjRvTUlRR045RnZp?=
 =?utf-8?B?eWZGM2Z3Q2p4Z2FjbWxPM20wcU5VUzVPdm83QWIzTWNBTytFTVJjdTZTd2Rp?=
 =?utf-8?B?RWs5eStISEM3WmptbUdpbmRJb0lxTUN3YmU3Slc5VCszUW94TmRua0xDM0pp?=
 =?utf-8?B?YkMwWFJodVlMY3Z6MW1oQ0dxMFIzSlFoZW1GSkJsdlBPY0RLNmZaYURXWGpw?=
 =?utf-8?B?RTlLbU9IMElCNkpnRnJHTWlhRmNNVXpjalJmZzNXNTlkb2kvUUtJc2RpTEhr?=
 =?utf-8?B?eTZaRGJsbmhzNmFMWjRST1lzZ1EwcjFockpQSGNnQkhUUmliSDdTWG0xb2Vj?=
 =?utf-8?B?ZW5ST2dwNzZtYTJaS25xb1gzZEMreGlkd3ZYcURtOWxvMUdFZHRKRDF0NmNi?=
 =?utf-8?B?TEVoTzl2M1ZKUGpmTlFBQ3RVKzM2VkI2a2hYNmE2VVYrSHhUaG9GTUJoaFo5?=
 =?utf-8?B?d3V6ZW1RWDNzQlFQLzEwbWxmV09PVHlObkxLc2ROVE1RZ29pclNEVS9ZN0d2?=
 =?utf-8?B?ZlIrWENJMUg2TnYzVWFtbEVlcVhmVXdzK1BCL2VjelB4cDFZeVVnSmNPR1Ux?=
 =?utf-8?B?MC9tSld5djM1NWk2RkRsUStxK0JIQmVJNU9BZ25TMXQ1NkRld1A1VTlmbnNa?=
 =?utf-8?B?YVVzUFZqMnlKVURkM2x1dkJuM2RFRXhYM0pJUnVNVTY3V21VNmFLSkozZi8y?=
 =?utf-8?B?RlRSaDhTTWViZHhsN0NRWldsWXhRYmI2aDJEMUVHeGlpdm54VTgrb2J6MlY5?=
 =?utf-8?B?aFJJNEhxK3p1d0pxRXZmd1BzaXh4RWZXdTlsN2Mzb044c3ErWnZONXFqam5z?=
 =?utf-8?B?MjYrNVpJbkp6TnpLYU1xN0xRSnVmdWRnTU9RR0dZMEMwOWtnZkRMZVp3NjRV?=
 =?utf-8?B?SEhSWjExVm5rMCtsOXdQME1EcVBIajRYRytGTnlHcW1tVnFoU0dVbmJueGFK?=
 =?utf-8?B?dlNkRHhLODUrNDBtZHVTQVEvYW9Da0VJaVhTOFFuV1F6bFV6TkUvK0UvUmdK?=
 =?utf-8?B?YWJSOVFjVFRnMXFlVkp0cGdZTTJrQVhPcm9sdEJmZWVOOXNyaHZxOTZNT0M0?=
 =?utf-8?B?R3U3QWpwU3pmaHhxYmtHU2txQmF1U1BUYVplZWJTTkp1YnZFSWIxWVFTQisz?=
 =?utf-8?B?dGRrS3ZSdFE5ekF3TTlJU29LTXc0SnRXVFdRNDVYWS9BZlFib0ZjNC9LQ3BE?=
 =?utf-8?B?emtjaE1lZkUyWkxDQ3A5U1FSb0VtNTZxQWZhYUN3dVA0OHFJRk1aQ0hReVFT?=
 =?utf-8?Q?5RPKRU3DkClYUHdMgzldXaIzgZpIUIXBfupDNnJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2xoYXlLc2VmdGY0elBmaDQ2a3FGZ0FLdkFjUThUWjBPNm95TWVkdUpwamMr?=
 =?utf-8?B?RWZiZStQTHllZG5JaGxxdFNzckxadGN5UW9kRXZHWkpoaGpCM3phaENDQ29m?=
 =?utf-8?B?Q3VRenE0UkdHZEI2N2lzSnFidEtnRDBrQUhPUmpYQStVMXpyN0JRcFh0MHFt?=
 =?utf-8?B?ZFNub1dnSDIzUUxGT2lvQ1lwZTJ0R1RxM0VKN2t2bWxqekt4L1ZUb0dRUmps?=
 =?utf-8?B?S3QreXBmTy85dTM3TFFDRERzeVQ1N1FoY3Z1MGdYYmo4SHlTcUU2RVcvd0I3?=
 =?utf-8?B?SG5HVUgzc2wyd1JWNkg1Y09Ha2JBbVlscVM5ckVPNHBEbFlXZDRSd3krL3d1?=
 =?utf-8?B?UW90RUMybFdnY3NUbjJySkVPc2N4cmtsMmU3V3JYcDZZNHF3Q2ZhWkF5K0Zh?=
 =?utf-8?B?U3NzOWFJaFFXYzJNYkpuVTdQZGFISzZiUUR6dzEyWmhwbjgvSjkvdWlqV2Jv?=
 =?utf-8?B?cGI2RHEyUUFWeDJBT3ZNekdMSWR5M0VuS3N2cXlOallpalVGbHJ2NmZ0L0xi?=
 =?utf-8?B?ZFgwZi9TQlR6MTZZS0ttYktyMEV1TFRmMVVUcXVOZnB6TzRSUHh5Sk5oL0tY?=
 =?utf-8?B?UmJ5WXd3V2NsZUhacGdMNHdOWHFwWW9zdHVDV3VxWXRaK282eG5XRnRFR0hm?=
 =?utf-8?B?cTlISW42N0pUZDVQdUpuMEc5amI5QzhmWXRrSjV0ek5tc0JhU3g4T0k3Qnhk?=
 =?utf-8?B?RGZVU2tWSHJsdkZLanZ0VEFvTmFjTUp2M1F0YWVXL1QxTHdGSTR6TVhwL1Fl?=
 =?utf-8?B?VWJHM1pXZjcxVFpTdFR5VzlKbmU3cU8rVWR4cTNGZXdyeWZTSjhGSjVMOVpk?=
 =?utf-8?B?ODdPTUNBc1pEb0lidm4wcWo2UGVvZ0dJVCt3cXNoTE95bU02V2VDR2ZBMDI3?=
 =?utf-8?B?WDNtNTRBSzRRcnMxcG1lNDZ6SEE4ZHZXTjRMZk9HQ2pwaTgyelowRWZ5RlBV?=
 =?utf-8?B?aHBDWGZIeDJyQnlrUnlhU1llUkYvRGtydXg3Z1YxS1BFVW1Ka2FaODZsMHBo?=
 =?utf-8?B?TzFlb1J5TmZKT0VsbWdtU0NMTUNCb2JkVkQ4c0NobXRIUHBJNi9TaXFsRE82?=
 =?utf-8?B?U29SRGUva0gxNitneldOK3RoUE5oOFUxdEc3RGNFWXd6TzBnODR6OE5uRVlX?=
 =?utf-8?B?QzhtOHBTUzRrcXhJVG1YeHdacTdiREx1cnc2dmxRVEZCQjNncXN2anRGckEy?=
 =?utf-8?B?NEE4ZVJvOWY2cXFGTEl1c3htKytQbDlydE0zWHJYTzVLQjFrTFBVazZGK3Bm?=
 =?utf-8?B?QTFZUHdZc3U3bFA1bmhNT3A0NFJqZSthalQzUzlaQm03SGRHcWVIdi92bTJh?=
 =?utf-8?B?RlFSai9MSlRZV3FpZ0g0T05kaVplbEV2c21WaGRVSXoweHVLWVJaQ2MreE9t?=
 =?utf-8?B?OGVTRzY0NlJMUGwra2txT1FCR3R2NklHSzJXdXZ1aTRpNTFXVVk2VklLMjNX?=
 =?utf-8?B?QUs1NTBXUUNTbjgzaUJXU3NkdTJKTklIc3FFUDVkNnJmaW9oallISlNrQ0ln?=
 =?utf-8?B?eko0Sm5xMVZBbE5Lbzd0MHBPU2dQY1dLQXEzTVNJaitzaGI3TkxpQmIyMExB?=
 =?utf-8?B?OWpOVmVueTFPQlB4MWhoU3F2YzFsYVZnWFpEdVphRms3cGtjMVZhZTdubkZL?=
 =?utf-8?B?bE9zTzB4TmorVGhnREg0SHl5UjJtWGVGWnIvWHk5Y2U1UXdVMWlWZUZicTFL?=
 =?utf-8?B?akVBdHhGRmNnVjFYdVB2TGJ0cFNJTHVwRlJNbHNkbFBYMExIZ3QraDN4a2tU?=
 =?utf-8?B?ZXNZS3BwWUZIYTlGQVRyQ2dFTVN5Ri9qYXFrTnFTVjFZZDN1aHRydmpFa3cy?=
 =?utf-8?B?Skc1ZG9MblpEMlp4NnJhRWgzY3VqVTFLMFZyWVp4aDFDL1RmdGF4enRVelU0?=
 =?utf-8?B?UlFDY1k3d01Zdm9yb3RyWHhqSml5U1U4UGRMWGJLeDBoSHp0eXhZdDNyK2x2?=
 =?utf-8?B?QVp1cE04aTV3Y1ZCcVhtTm5tQTNZbHpEb1FTd2duNjhNV2NBV3l1aFJjbEgx?=
 =?utf-8?B?ZjNmSHowTno3eHdleHBqcFhrSklmUGwvRENWSTB3R2tHY25wOG5iMGlCVXdZ?=
 =?utf-8?B?TUVTTitpcWRxdUVxLzBTRldaZUZib1E2UEpwL21hWU15Z2pMWFZlNmJBWFha?=
 =?utf-8?Q?ZDQ6Wovq59z/bo0DbWyoMvQJX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f5aceb-1c0d-483d-1a79-08dcad41ece8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 07:09:44.2312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dAl1HUjG9amgENiVRaqBISByShF5Ti0d5Qm9sDCmRlaEku/2bjRqDMYhEmyp5jPUoVax5Pe2gJUhuwgrYxL1VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8293



On 7/26/2024 12:36 PM, Dhananjay Ugwekar wrote:
> Hello, Ian, Kan,
> 
> On 7/20/2024 3:32 AM, Ian Rogers wrote:
>> On Fri, Jul 19, 2024 at 9:35 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>> On 2024-07-19 10:59 a.m., Ian Rogers wrote:
>>>> Thanks Kan. I'm not wondering about a case of 2 CPUs, say on CPU0 and
>>>> solely its perf event context, I want to know its core power and
>>>> package power as a group so I never record one without the other. That
>>>> grouping wouldn't be possible with 2 PMUs.
>>>
>>> For power, to be honest, I don't think it improves anything. It gives
>>> users a false image that perf can group these counters.
>>> But the truth is that perf cannot. The power counters are all
>>> free-running counters. It's impossible to co-schedule them (which
>>> requires a global mechanism to disable/enable all counters, e.g.,
>>> GLOBAL_CTRL for core PMU). The kernel still has to read the counters one
>>> by one while the counters keep running. There are no differences with or
>>> without a group for the power events.
>>
>> Ok, so power should copy cstate with _core, _pkg, etc. I agree the
>> difference is small and I like the idea of being consistent.
> 
> So, it seems we want to follow the new PMU addition approach for RAPL 
> being consistent with Intel cstate driver, should I revive my "power_per_core" 
> PMU thread now?

The power_per_core PMU thread link for reference,

https://lore.kernel.org/all/20240711102436.4432-1-Dhananjay.Ugwekar@amd.com/

> 
> Thanks,
> Dhananjay
> 
>  Do we
>> want to add "event.cpus" support to the tool anyway for potential
>> future uses? This would at least avoid problems with newer kernels and
>> older perf tools were we to find a good use for it.
>>
>>>> My understanding had been that for core PMUs a "perf stat -C" option
>>>> would choose the particular CPU to count the event on, for an uncore
>>>> PMU the -C option would override the cpumask's "default" value. We
>>>> have code to validate this:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/evlist.c?h=perf-tools-next#n2522
>>>> But it seems now that overriding an uncore PMU's default CPU is
>>>> ignored.
>>>
>>> For the uncore driver, no matter what -C set, it writes the default CPU
>>> back.
>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/arch/x86/events/intel/uncore.c#n760
>>>
>>>> If you did:
>>>> $ perf stat -C 1 -e data_read -a sleep 0.1
>>>> Then the tool thinks data_read is on CPU1 and will set its thread
>>>> affinity to CPU1 to avoid IPIs. It seems to fix this we need to just
>>>> throw away the -C option.
>>> The perf tool can still read the the counter from CPU1 and no IPIs
>>> because of the PMU_EV_CAP_READ_ACTIVE_PKG().
>>>
>>> Not quite sure, but it seems only the open and close may be impacted and
>>> silently changed to CPU0.
>>
>> There's also enable/disable. Andi did the work and there were some
>> notable gains but likely more on core events. Ultimately it'd be nice
>> to be opening, closing.. everything in parallel given the calls are
>> slow and the work is embarrassingly parallel.
>> It feels like the cpumasks for uncore could still do with some cleanup
>> wrt -C I'm just unsure at the moment what this should be. Tbh, I'm
>> tempted to rewrite evlist propagate maps as someone may look at it and
>> think I believe in what it is doing. The parallel stuff we should grab
>> Riccardo's past work.
>>
>> Thanks,
>> Ian
>>
>>
>>> Thanks,
>>> Kan
>>>>
>>>>>> 2) do the /sys/devices/<pmu>/events/event.(unit|scale|per-pkg|snapshot)
>>>>>> files parse correctly and have a corresponding event.
>>>>>> 3) keep adding opening events on the PMU to a group to make sure that
>>>>>> when counters are exhausted the perf_event_open fails (I've seen this
>>>>>> bug on AMD)
>>>>>> 4) are the values in the type file unique
>>>>>>
>>>>>
>>>>> The rest sounds good to me.
>>>>
>>>> Cool. Let me know if you can think of more.
>>>>
>>>> Thanks,
>>>> Ian
>>>>
>>>>> Thanks,
>>>>> Kan
>>>>
