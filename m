Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012010.outbound.protection.outlook.com [52.101.53.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9AC2676F4;
	Mon, 29 Sep 2025 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137459; cv=fail; b=Y5iFvTYjHY9qZGYT0AEx/KACzAlRJ52CnKZD87msKHY450dk3iVTm2csBbXCX7s7IsSt5TysFlRwgdrjVYBTOcjjpwJizbG1/CwNosINMi9yZPRI4fvMzhBub9xJtVntYRyU+9hOUHJWaikF5+qPTQh5xgd19pbWnXHFbKFbH1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137459; c=relaxed/simple;
	bh=1+HD+sBzzehOphP6btOWkc4OT712xqKUDBpM2r/AxIU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ha+UE5bQYgjmrUp1RpoTXV65E1S1/lylbqoUxVgz0B/ELr2Fp7TdmJY6PPqwxGUNrKY/AkSprPHM65C1HCFFoZJtQMO52Va3QaJtoqR+rkmLDWmuaPr0JPo+LjoEO0/D2rv90HR/w6+2kqIMmFeDpvHebuHIfeQJVSnu2pasIhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ioiulN3P; arc=fail smtp.client-ip=52.101.53.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ioiulN3P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yxB9+rzGD57/1RBhrhxzKdOwqfgIBoe3qvPvu+w2O7g+hU8fpkqFiq8hbRuc49Whzwy3m7CLCvg8gGE+Rb7O+mCxP5FsxU8lbDS4q3qG6pPT/7nYpoAw2oAE0r0pBRARSssa5hFM3Mnn+Ff04+nwt8Xnk44H268rDF5PUNXxZWkolhIh6pa8TUZIKRxoNyZxua+74yWXiN9c3BHYpquF8AoycUKHUqxJSUcnc7tkIue0Vys6TKo8SuefbUgd0+1uhRxQ+dEAguZU2k9/QYE5T8rt73T52Jf3Oc6B9mgmnL2iRrhlo1gKReqsi935HQRNIjG+9BwdgGYtSTsauhUzXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajAPnRV07eFwWkAqgDXwYbM7bf7FVDBBCDwG3v0d1X4=;
 b=SWvDvIapH4wB+NyTtaI3tAp/KbeYO4g4XbBNhpoAu4EOmoakbG/81OIdyz5HVC/3KXorOPktCXbx/GDwxKCqt8O8FJ5jYJ0LHyzn+eTlrqVGHwmu8qQUDP4DzNhOq2fw1ahiysocRUqp2BjTy1eEGFje0enMsfo/XRWlCRN/E02twnr7XgSHO7jaTsZOiusf1Zxz3I50luP02OikuQTatqP38i5r2uDebUj9zHMtktpfZTm4lxKxOcryWjPQnpTolOEamY8z8sZzK3jEAaXfWVhbqliwX2mgT1dCYP/r2rIUxRnIl/9ZFxHfPWJtqnzAcDFWL1/dksxyEhHiELWLOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajAPnRV07eFwWkAqgDXwYbM7bf7FVDBBCDwG3v0d1X4=;
 b=ioiulN3PXnB+u0YQ8am4QhcUHBd0XI195VERT545DHLUo5Pjng/tH9aeaQWpInYbWDKJCqgSYi6TAv80XEQLQNDqHHpsO11eXbG8WeFsb13vOU4wqPc0vhX1I50o/t+dy0+zUYlpaxeEI/bVMNPOnTpGNmv/wSfl2QW7YZa2cZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8301.namprd12.prod.outlook.com (2603:10b6:208:40b::13)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Mon, 29 Sep
 2025 09:17:33 +0000
Received: from IA0PR12MB8301.namprd12.prod.outlook.com
 ([fe80::e929:57f5:f4db:5823]) by IA0PR12MB8301.namprd12.prod.outlook.com
 ([fe80::e929:57f5:f4db:5823%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 09:17:33 +0000
Message-ID: <2797b8f2-fc56-41a6-8ab3-dd298fd3ea36@amd.com>
Date: Mon, 29 Sep 2025 14:47:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools headers: Sync x86 cpufeatures and arm64 cputype
 headers
To: Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org,
 James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, acme@redhat.com, namhyung@kernel.org,
 yangyicong@hisilicon.com, bp@alien8.de, mingo@kernel.org, xin@zytor.com,
 yosry.ahmed@linux.dev
References: <20250929061644.19188-2-shivankg@amd.com>
 <20250929082733.GH7985@e132581.arm.com>
Content-Language: en-US
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <20250929082733.GH7985@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0190.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::19) To IA0PR12MB8301.namprd12.prod.outlook.com
 (2603:10b6:208:40b::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8301:EE_|MN2PR12MB4240:EE_
X-MS-Office365-Filtering-Correlation-Id: 29b020de-64a0-488e-4e36-08ddff3905d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTVIcHlmUUxCRnhqeTdEOGxacmdmZjhDWXNvK09CRXFrZVFhVGJGQTUyNlF3?=
 =?utf-8?B?MnZ0Uy9NNWZnY2Irb01iZjhsaEFzU3FwRXJibU5IVXk1ZDh4d21jc21TekNj?=
 =?utf-8?B?Z2g2QmxJTjBma01pQmZsaG5kUDF1QnRlbi9zNHVWaUw0N1JIWnU1dlJhKy8w?=
 =?utf-8?B?RHF1K0xHd1c4bEh1TW1YZjZvd29WckxMcXNaTDI5RzhXcnJYdGxkeWxlZjdL?=
 =?utf-8?B?Y0E1dDZHR1BKbWMyOFFlTzJ4SjFQUm1BaXpqbW13bnRTMjltMG9MNWlLNHVJ?=
 =?utf-8?B?MEFnZzlqSnpDdHBYWTdvMEo1VHRtanJlZzh1VXNqdjZrL2JvSFhZcktwajFS?=
 =?utf-8?B?VFFLWEdwbENYb1ZPOW9XbFEwblh1aEJvZXM5ZCtHM3dPb044ZzR2R3crQXd1?=
 =?utf-8?B?ci85aEw4M2F6SlEzYm1Vc1UrZGdGL1pPS1FBMWk3TlJHamZDb1g3ZDFSZ2lK?=
 =?utf-8?B?U1BEVmVZTVBtNkVMK2xLTnNHZjN6VG1GTVRYZkNYWWwwUjRXSHE3dmdqTCt6?=
 =?utf-8?B?NVViazlvYTVqMHlEeUcxY3d3MjhaSjhxT2tsZk5mdTVJNUZvTjdlbzdVOU9U?=
 =?utf-8?B?T2l4R3JwY0R4Y05uTUlEMjBXRFRyWHIyS01ZVGZKY0NpakQ5SzNHc1g1bTFH?=
 =?utf-8?B?b0NMRnUvM21aRUMzbUJkaWtQNXJDcG1ZQTRqNTI1Q1ZwYTRKcWtjOUJMclg2?=
 =?utf-8?B?cWFpVHNuR0NqUXh1WFJvRFByWi9EZ1NPcGx3TWUzSlNKVGhiZVpIMnA2bUx0?=
 =?utf-8?B?Q1BTdGYvaGFYZW45NzVpRGlLM0NoN3ZPczFFeE90ODRvbXF5NEFDSWRuSXF0?=
 =?utf-8?B?S3NUQ20yQ1VtMjdIVkRqclIvL3BWMmFKSktTRmI2V29GdTdoVEJ5Q284Y2VL?=
 =?utf-8?B?WjBLYUpCSlFkRndERkhXUURjbE9lWm5PSVUyZHo3UUVkVDhGNVZOZzFhQ2xJ?=
 =?utf-8?B?bEdKNWFuOTBBWHo1Y3ZWOEtoWXZyWks2WVJkOVlMbWFMK1BaRU5BS2daZk5J?=
 =?utf-8?B?ZXBNeFJmM0ZXVUhlaUNiTGJkb3p2MHFaNU1aTzkreDAvM1NVSUsvMitNUzYz?=
 =?utf-8?B?bUdzVzVXSHMwMzRvVXMvY3dURWNxZGdtWDUyUm1iaGp4MW04S0V4ZkdhUlJ6?=
 =?utf-8?B?Mm50bzFDeC92L0l2cVJtc254eGk4TFl6Uk5CalZIU3dCcHFBNTZIbXBVSGhx?=
 =?utf-8?B?U2dSdWRsa3pKSWNwUENWeWZ2M1FTM1FpdGNNWEJCdVFQTmJCeCtQdjcvNUcz?=
 =?utf-8?B?SDU2SVczckNVMjV2amYrSktoQzRWOTQrcUNOTlZwRWZzUlVuYXdxTGx5b2Zv?=
 =?utf-8?B?ZmdpQUNBc1RKNHFUNTZRUEZHQnArTkxEN2pSN2dWcjd1ZEthMlZkV1RuNkdi?=
 =?utf-8?B?d21IeW9Td1NkZVd2QnhZODJpSDRRaitLdmVSOFQ1T01xa1RqdjJsTVNSL3dE?=
 =?utf-8?B?ZFlOM3ZxTVFyRXJ5N2lUMjd0SEs0SlZucFNGZ2loRHpVQzhvcEYweFFWQ1FR?=
 =?utf-8?B?cUtGWWMvWFE0TWJsUWJ1TUp6ajVPYnBUSENTcS91MGZEaVAvZnZ5c2Y3UXJK?=
 =?utf-8?B?Z1dpSXo5NHNqeFdTdU9oN0lESC9KaG83UEN1YzVRZEN2NVAyZThqS2ZPbG1C?=
 =?utf-8?B?WXJEclN5clRSUWhNTG9RU0w3MkZXemp0TUxsUjFxd2RtWC9XTExJOXBnVkhu?=
 =?utf-8?B?WWlmVHpuUlE4MDVCekVSNUlvRzNzQSs0NlJTNjNJbUo2eVRsU2Y4a2xIT2ZU?=
 =?utf-8?B?ZGFJYm84OSs0Wlg2TXRyR3ZwVXk1UmZ4Mlp6MUwwMXF3c3N4SS9Hbjg1c1FC?=
 =?utf-8?B?bUNOR2xQY1lNOG9WSGFhOHJodDhCS1FBeC8zb2Q0NlVLRk1CUG16SUJ0NFBL?=
 =?utf-8?B?K2FkRWpFVmNkZ0N1TWlvSTN4QXk3YWFiUm52SCtscFZhME5VWjdaUHIrbi9Y?=
 =?utf-8?Q?zkZua/o5r9xBQ7fSJpz7TuLR1xrauXCa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8301.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVJ0c1VxcU9TUWtrQnRsRWk3VHFlMng3ZEdSV1NiNTNmbVJxODJVNk1oRzRR?=
 =?utf-8?B?NzNFT2poRWhseGVZNU5RWUR6SEhzcnkzNjc3QzluZk0vdUdiOHBHbzlkL1Nl?=
 =?utf-8?B?Z0puOU05TG92ZXpkbjVHNWxIb0oveVFUM0pKdG9MNktOQVcrUHc4MmtVZWNC?=
 =?utf-8?B?cXlBRDVnSSsrT1FrWGJCUnRKdFpCV253K2VZM0E0bmZhZ1NIM1BOa0VHUi9p?=
 =?utf-8?B?Rm1RdGY1ajUvd200MWpHVUhPejlQTVdvSzhoTklZNVMyQlpuc0d5cGpxaUZ2?=
 =?utf-8?B?dnBtd3ltYnV5TkY3aUdpZkZPRUE1ekp4eVFNaElDUVRsalpWTjM0TS9TSVVZ?=
 =?utf-8?B?TXBkMHg4cXRCYUVBWlpXTUtHZ0E5M01oMGd5R0FnRGk1eEN0bkUzYmNiUmdj?=
 =?utf-8?B?cjArS1ROSEgvUTVPTTBnSzQwcVVpME0vYnNwNmw4cE9lRHlEZktnNUNIL2t1?=
 =?utf-8?B?SnNRNXZSbDVYZEdxdm1RNnMrMTZ4VHozUVZhbEgrNEo1QUp6V3JPVjZHQnFp?=
 =?utf-8?B?VVFRTFIxL0pTVlZSaDdBU3c3Y3hRQW83MGhnM2tTZ01pY09XdFphcmtwRWRZ?=
 =?utf-8?B?YWhmeW16MU0rRlJTMzFlQWtTN3lOc0lwSUNKd2t0THpHOGZveHBnTlI0Y05S?=
 =?utf-8?B?UFBqaDFoNy9POWczQmVoeFc1R3puckRXR0F1SE5mRjVNTVp0NXhlUWcvOGQ2?=
 =?utf-8?B?SnMzUFhVNlFFL1VsWStDUTJpcVJIT0wxQ1NsNmVPdlNac0hvOTJlLzhYU1Zq?=
 =?utf-8?B?QUtwOXRMRnRBRjJDMzljaFZzODFSTEZHNjE1U0hhbVdHUlUvS0dZbVNGMTNu?=
 =?utf-8?B?N3dZS241K3kwajJpWWcwTnFYcW9weVVaMkNHL2xJNFpuclk1NU9vUDRnT2Vp?=
 =?utf-8?B?MVBRMUoxaEdHMG13TXRGRlNpRUQ2NzRNSHJPcTFEOGtHZDlGNHNwRGJsZUlF?=
 =?utf-8?B?eWE4YW5oOHNzeTN4RGpUYTFaWUlUMEx5YlZVcS93LzN5bmJyakFMVkdUOE5L?=
 =?utf-8?B?T1VZMWVPMUc1TUpjSFp0bitoSGNnYnpMSW5pdHdjVklieDhHd0VrVk0rbmR3?=
 =?utf-8?B?cmtWSzlPL0hINkJOVWxuRDBIdGZDRGhka1gyS2Z1RVVFVDFLNmRhNENjT0Qx?=
 =?utf-8?B?cGxPMmp2UGQ1dTMvREtlT0Voc1VndEZjb0IxZkNOU0RIbXNUT1JDK1ZQd2Yw?=
 =?utf-8?B?REV3RmdIY3pKdWRraEVmRmhCZ2pXT0M2dG9VRk5aakxLTEFWeXpqODVhdlRR?=
 =?utf-8?B?TytheDEweDhXZEYxcHc2QkhmejQxSGk4TzBXamxXNXdhc253RjVzU0xxd1dr?=
 =?utf-8?B?V2c5cy9iOWpYSDEyR2RqTWFvZUJ1OFZGcDlpSUw1aTVrM1dKUnJ5OGhYYlBn?=
 =?utf-8?B?SzArVTF4dThRdG1CbUliLzBJTTJ0QU5KZWZ0dlludW5zSnhqdFJsTGVERmZC?=
 =?utf-8?B?VExzbXZ1cjRnVWdQalBCS0VKWEdzNTV2alhYYU55Q3JEOWpoV0xoTzh6LzNQ?=
 =?utf-8?B?VExYWXJVQ1pSTWo2SjhQR3NCOXZvay9URmpPUVppUTUxSnY2OHl4dnFBa3Rh?=
 =?utf-8?B?ZzRrNytnMURYc2RIOUlLb2sxckEzMG81VUpaQWdFODFwRVdqTzlxL0ExWFpI?=
 =?utf-8?B?VE1DeWpVdFdoTlpRajhEN1pEZi9zR2VsME1Ca2VhY0x4bHhEV1piOWszYmZs?=
 =?utf-8?B?NkRjcnNNVmVoSThpV3VlUzFEK1Zjbm50MmEzeUxhTXJpNmhOL2FoZEdrc0xj?=
 =?utf-8?B?QVVOR01qSjdhTFhON3N4RHB3ZjRGK3dOZExiVXFOSDhuV1pydFgrVzJTY0R5?=
 =?utf-8?B?SXhYczVFL2tCTXFwNEcvUFhGUzVLU01xd1kvb2tTL1VQVnBhOEJGUzZoaGFH?=
 =?utf-8?B?WUs3V0ZyNzU3WWhMMmdCaUhuZzBuL0hHMzY2eTVzN3VwZFVZV25EMytweVE5?=
 =?utf-8?B?c1Vlbk5Ra1RVQ1F3RTEySS80ZkFEVENZcVpDaXVhMStpWDJ4QmpjZFN0bW1y?=
 =?utf-8?B?ZDhycHBOYmJOT3Rqc2wrNjJzMGxCWFRKbCswZTBpRENicWhNNnpOMTN3ZWxB?=
 =?utf-8?B?OFpNVTNCcnRmamlRRGJaL0dkeEZuU1R6Uk5lUnIrNGxTalN2STR5QTBpNldS?=
 =?utf-8?Q?YqPixkpwK2iA5LrFZN70YOggA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b020de-64a0-488e-4e36-08ddff3905d2
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 09:17:33.4376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h0ZenMcdbxYuMYsyLcMjbtVMvsgSIlx99DmYZVSQfZ/ywKHPBnpXWMQTHP325AGz9IIm1/VBmU/Viz712Q+xOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240



On 9/29/2025 1:57 PM, Leo Yan wrote:
> Hi Shivank,
> 
> [ + James, perf-user ML ]
> 
> On Mon, Sep 29, 2025 at 06:16:45AM +0000, Shivank Garg wrote:
>> To pick up the changes in this cset:
>>
>> commit 2f8f173413f1 ("x86/vmscape: Add conditional IBPB mitigation")
>> commit a508cec6e521 ("x86/vmscape: Enumerate VMSCAPE bug")
>> commit c8c2647e69be ("arm64: Make  _midr_in_range_list() an exported function")
>> commit e3121298c7fc ("arm64: Modify _midr_range() functions to read MIDR/REVIDR internally")
>>
>> This addresses these perf build warnings:
>> tools/perf$ ./check-headers.sh
>> Warning: Kernel ABI header differences:
>>   diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures
>>   diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
> 
> Please drop arm64 related syncing, otherwise, it will break perf
> building.

Sure, I'll send V2 without arm64 sync.

Thanks,
Shivank
> 
> At the meantime, James is working on refactoring cpu type definitions
> for Arm64, we expect to avoid syncing cputype.h.
> 
> Thanks,
> Leo

