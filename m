Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DE7625;
	Wed, 26 Nov 2025 06:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764138388; cv=fail; b=QNOG9lQHHbI/Z6yANx66Ys1O3vo7y0oIXeXIg8rKDL5kg8QstYNBFNLSUaYPvaYoTGIGUjNrid9c5a6H50sMCWMsqIuAZsIMu4pMZ/iJNEtTQ7Gvm7P4picYClI8D6P/tkTsc74nlZZ7/n3TNCXxMVV8gGAn0uCP0UwrUhVeB1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764138388; c=relaxed/simple;
	bh=NdYGeRiIRoxnt7dUmf/MM2hP8bzDN7PLe+5nsaqf+zM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=akttJ9fTLMlHkWT05q/3q/Nq7/fiMaBED2mRXJuznZdb4bBEnmqV3wQDChQE2eQNTPfGotQ96Rdcbcwm9ETXdVSC3Wfgw3uveQDe9IPUNFVlbIHSutgHhdfpzPVo5q/uYIQFtM8KuNsJAplKZyEt5F9pPpdKvlIGz/quSlYhTbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U5uHUVoo; arc=fail smtp.client-ip=40.107.209.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U5uHUVoo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfoG5wjsX5VM2s00BrSjz/NqrSDCi/m/N+AjYeNxQ0Fq8aQC7vCVdkOw5+O9lhzviVrlgJpWLljYfigeYYSeauQgiAwMcocHK7P2wPj57jP2egP+KElE+dXJVjFikkrPmEJbKhzjWcch3eUk6IZvpwey6XC8EY9uCRxWsiIMN9GMAL0JYgjWvDDE13u8RcilNB9Ir2ZH2HQb5sDfpYhVIXRJpx25++VPJnLYfLiAqOq05197g3GEHS3R6CfKbE+irWqxiU/xA96eg1OvMvFPVpKgEXYpqg0sQJfjVo4j1r9zEjyj20HyoetRwmuXAYbz/EGI4w/dBEGGpqPpOU2SDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOPQOer6D5CPIIoIQpnNTWUK1zhlEBjPwH+oV/YnKvk=;
 b=svEORsgTt0Quf4HKNYNDLNCTTl84cb5tTL2ciLRQEGH5gsU8J6mzLu5uhnVrLhW+JiRy/qpqGv8gWouj3+7L+Vioba2S1czj0rui32H23Ycq0KLL2ileaRvQfe4AWA3BXhJ0QU6QkmvJtEa9qKnzU5zkcj5PDiU8jfGWiYip+WRONeMTGGwx5kEICxr+JLtk3MWKJw37yL7v/9EY2q3trsJWA7g0Kdfw3N4Io65bt9JpuWRmHJ1Nt/TBNpcT3Gn/hdv99ZG+ulUTkvHtB6QqCiQo6r0+EdHFSEwCOr/bBD9zMBhmOWl4KUtNIx0aRs0kH/guJ3fDoRHuy1/Oeo30vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOPQOer6D5CPIIoIQpnNTWUK1zhlEBjPwH+oV/YnKvk=;
 b=U5uHUVooJegNIwi4mtSRotWu0g4jJf2K/F6AmLrNY9EBmnpQHW6i7YK4/6YO0eqzqTUzzm2Jk0OTsHpsoNdSQnIo3acFljLQXo+Agwp8vdeQ1v3+8a+YI1NQ7RxcMk92cp9n8JIRnlFWiu/Cj7/5IcBa7B9vB2l77zuVhjse81c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by LV9PR12MB9806.namprd12.prod.outlook.com (2603:10b6:408:2ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 06:26:24 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 06:26:24 +0000
Message-ID: <c764200b-1328-470b-9ff5-6ae48013e3e9@amd.com>
Date: Wed, 26 Nov 2025 11:56:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 25/52] perf jevents: Add ILP metrics for AMD
To: Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Benjamin Gray <bgray@linux.ibm.com>, Caleb Biggers
 <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>,
 Ingo Molnar <mingo@redhat.com>, James Clark <james.clark@linaro.org>,
 Jing Zhang <renyu.zj@linux.alibaba.com>, Jiri Olsa <jolsa@kernel.org>,
 John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Samantha Alt
 <samantha.alt@intel.com>, Thomas Falcon <thomas.falcon@intel.com>,
 Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20251113032040.1994090-1-irogers@google.com>
 <20251113032040.1994090-26-irogers@google.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20251113032040.1994090-26-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0125.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::10) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|LV9PR12MB9806:EE_
X-MS-Office365-Filtering-Correlation-Id: fba32f50-8cae-43d5-9945-08de2cb4b88a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkJGUVdZbkxlcjZtS3lZbUgzWVkzcWZKUFhOaHJxN3p4eFF2M05aK012blJy?=
 =?utf-8?B?SlBnT09jajk3OFhpT2hHYWUwdC9CZnlHUjVGb0NRcmdaZXFFQUhxNzRzN3pl?=
 =?utf-8?B?WjdkVjBkQmcxeStDUUlEUU93cXlZalBsSzd3ZC9wODVQbE10Q3RJZ0s0cWhR?=
 =?utf-8?B?NFByYkJ1dE1DRFVSSk0xK1BYNk1FbmsrL1NSd0lHLzJUekltblNaMFpLVkVU?=
 =?utf-8?B?NUU2VkQ3UkdyTkdkUmc3aWYwRFE5NXBVbTBIZURQNUpiT1ZHbXN5RjRwejFK?=
 =?utf-8?B?N3BKeSsza1RYajJVUE1oejY4cHlXMnF5NjhxVmx4NWx6dGZNUng0UHRxQkw3?=
 =?utf-8?B?aHhQRThOcE5iL0cvYmNEK041V0FlVlh6ejVuVGgrWkpjM3JlWmR5dlBvOE9J?=
 =?utf-8?B?Y29vbXdyN2RGVDVsV3ZpN2JPdnd5d1Z3amJXaWZ6Z0pnZFhGbkpKcnlOZWxB?=
 =?utf-8?B?T3pEaklNVXUyaEQzQ0hQN280b05raklZallSb0w5cGpLWkpwbCtOMEZ0UUtj?=
 =?utf-8?B?TkJqdTJKbVN4b0tzUmswYWU4OHdMNFQ5dGl0YXYrV1Jpc2dzUjNIeFVHU2w4?=
 =?utf-8?B?aE1UUjRzQ2lSNFBrWCsxUGlOSnU4ZTZyd0RHNnZiSENJSGdkSXlwZUVtMzJs?=
 =?utf-8?B?VEdpZ0lyQUl3UWZLVDkwSUNYVFdpTG85ak5ubDM0amZwUFVwNlYzZU9raWQ4?=
 =?utf-8?B?RWRHeHBSek5wQ2VSaUdiMXAvZ3B6OE45MWRRQmhTWVI2MUhBS2VYcW5ZZTBw?=
 =?utf-8?B?MTh5ZXdhYTU3Mjc1U0dlUDd3d1NYWnNmUmluOTBRZ0wwZnRKTkhDZVoybktW?=
 =?utf-8?B?VFA4TmFZUTY3SFRKeTNudEY5KzRrZVEwL3d0RzdESzQ2MVNzUDJoT2RVRFhs?=
 =?utf-8?B?NjBHek44YmtVS0phOUNTSTl6TTQvV2NuckpXMzNXMGF4Vi9vSFUzMXRiSnNp?=
 =?utf-8?B?RTk2ZGRDNlBOSWRONElWUExhRUlUNjZScWUvc2ROSUR0cW1WanB2cFUzanBv?=
 =?utf-8?B?RGNnT2IzL2xjd0VGRWxKVmNXVWxCd2l3TEVvaUlzaXRaYkk1U2NyODVxaU5x?=
 =?utf-8?B?YnlqY0J2NTVLTDRZSDlUZXExSWoyOUcvR0VMdENhZ2FsZEJJMXNCQWt3RFZz?=
 =?utf-8?B?M1NyakJ4blNsbVZQN29sY0YrSmphOXlLcmNOem0vMGtvbklNdGN4UWViWWhN?=
 =?utf-8?B?a290RDFJREllZk1ocENtWkpWajRZV29wOVkvdUFuQjBGVmZYckJxei9GRkVP?=
 =?utf-8?B?MFFFV0I3em9NQWpURk00a0d2M3hPd3UwT0cxMHNpZTZZTnFZMDVMUC9nT0RS?=
 =?utf-8?B?ZXZ6TUZKcmpuSzVDTXpuVStoR3kzYlhyamcxRTBMdzBkRm5RNTc0UXpvRk1i?=
 =?utf-8?B?YUpQWmEwWStIWnZlOGlWUEJZWk8xc29XbjMxU1hIVnpsaHFOSWQ4aUFrcVAz?=
 =?utf-8?B?V09ZdS81WXdob3JEQXc1a3FLT29iZHAwUVZSNTJtZUU5eWFLVWF0bjF6L2ho?=
 =?utf-8?B?L3liTVkrQ0NsazVyTmViajkrRDdwMVIwSW1vSkJma2t4Z1VRa2J5OE9RSzJy?=
 =?utf-8?B?S3FSK3JhTzNrazc5WldFdU5CZ0hrclIxbGhZSWxNZHJGbWRvbjlvZ1dwZXZR?=
 =?utf-8?B?d09rckFzRTMvZmFCaWs5c1ZkYk0xSWJBWmhHWWtoY1FoWU5Od1Bsa0hCTXlp?=
 =?utf-8?B?WkZCWkw3MHo3Um4zU2F2UFBoNGVCcWZLbFFxZ3M3YjM1NCtQY3Q5NHpFN2Vw?=
 =?utf-8?B?bEkrRzBGbUFjc0s0OFR3dklNeHo5Nml2bC9QNGg3Rk9XajhybG1Ob0ZqVkUx?=
 =?utf-8?B?WmpYemtFdzZiWk1IUURreGt5WDJnN1Zac2VQRS84QjBmR3BNNWRldVZqbys2?=
 =?utf-8?B?M0RoMmxvUm8xMlV5OWVKTFl0YzRsM0V4Z1BBdmNYNU9wdEg3ODZITTlNdEht?=
 =?utf-8?B?WGlmam1UQ1pXZ1FVdnp4ZktuMG9BYThlR2d2QlliQlpldFhHTVJpZm1VTWtM?=
 =?utf-8?Q?LjpoObtYK5e/gs4hp3Korx8/95mtRg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXh5NUNrZDZ6dkpIbGYvZXhYTmFMOTNXemNNOHo2NjNRYWtKNXNNay9Nbm5G?=
 =?utf-8?B?NU1ra2lGUzdEcitmMWFMQzRxWHk4ZEQ5WXoxUzFVeXhwYmttRDkyREtnTjhJ?=
 =?utf-8?B?bmViQUc2SG9nNzYwRUU2djJWS2hoSDgrdVlZZGJSVW96Rko4OGRZNHpCU3hM?=
 =?utf-8?B?QlRSZjUyVm8wTDA3S1VqSlpOQmpLNHVJVk02ZFZwNmd0cE95aFR3QjBiaVhF?=
 =?utf-8?B?Rm4zWWlqeDN4NUVEZzRwam1EalUrMytOT3RFTjB5UWRaeUgyWWY4WnFVaDVH?=
 =?utf-8?B?ZmlMclBuSDdTTDl6YnIyVXdNMFlnNmFIQlBGS1hFZUxyOFQrU1Y0Z2REUFVu?=
 =?utf-8?B?c2M0S3JOb09jZGtLSGlWaC9iV2pEcU42WlZDRE5haHdDMko0Z2xMZ1prVkhW?=
 =?utf-8?B?SFZjZXd1eUNvTU1ZcElxZWFuKzh1Uy85T0JFNjRDMHJjUGhUejVNWVl2UzR3?=
 =?utf-8?B?b3hob3QrZGl0a2ZUN1ZRN3RPbzhHNm5rUmRPOXZzT3VqM0tScHVQUStWUlJZ?=
 =?utf-8?B?eDJpeUNZME5wQk1XOEg3VnZPWlA5MlNTV2Vpc0NPZXJFbyt0S28xZUVJT1FB?=
 =?utf-8?B?OHFKZmVObmk4R2FsMzE0dFhjUEV5TzhXQjJScFVKU2ZqdEhFd0VXWUJtSzFz?=
 =?utf-8?B?dm9IbnlKRE9XOUJja2N5RkdPdHFJVzl2R1RmUUplNTlrNVQvUG1hblhtSnBx?=
 =?utf-8?B?blRkZFowbFNmWWN1aVpRc3lZUEFJMkFPMjZsVUdwWUhyUzc5NEFkT0hVMjRk?=
 =?utf-8?B?cm1yVUxFZ1BqdlRha2NMT3E3NzVBS01jc2R6OE5MbWViK3ljT3NFMmYvMTha?=
 =?utf-8?B?U2xFS1ZqSW1jNW04cjV1bHdwemFadVplWUU1S2txbE44SkxON2QxTW84TWVi?=
 =?utf-8?B?OG9XT3lGc0RTMUEzTW5uUGZjMXZEb2ZYR1ZRaGF0OTBaWitMakZ4TDBtYmR5?=
 =?utf-8?B?SXVQcjVaMGxxSEU5Qzh2RkgrZ2x2eHFXcitNOWdJdW96VmNieE1WcUk5OTJp?=
 =?utf-8?B?bU5BSDdVS3UxQkt5QkVHdm9teEc4VFA3K2U2U3VJY2xmYmNrQlFzaFlsSVRj?=
 =?utf-8?B?MU1YK3YxZkVnQ0NQMElTb1hhenJxNGRMdXNkU2FSVitMUkRXUTBvYnkyUnhw?=
 =?utf-8?B?Y1ErQXFCd0J5V3I5Q1p4dTM2WTBGOTJGbjNtcXVIOTVUWnFkREVyeWFTVnpI?=
 =?utf-8?B?MEdQeVc4SU5hVkdUcGlMQXJJQW13cE1IUVVkMVNwcVFxS0Fla1F1OWpZNVZh?=
 =?utf-8?B?SmMyOTU2WVBudmV0c3lQZDZaaVVDOU4yT3ZqSnd0WGs5bHRKWk1KamMwUGZ4?=
 =?utf-8?B?cnhRdVVpVFNINjBVZHVvaktVR2tRMWFUcitlSzUraHRSUlZ2ZXQ0TVc2bHlu?=
 =?utf-8?B?MVJGQ3dVbUo2L1dSekp1QXQzU3ZWM2FIc0hyMTRJakpzRHZENGJZd2xwdWNa?=
 =?utf-8?B?cmRjYzdnbWV3V3VDU1lpL1BUbjdnT2RGNlNVUUZackJlSGhnV20wZzVZVFlt?=
 =?utf-8?B?VlgvUWNXbFg1RDg0bXlMT2ExdkNiSXlZcjlCdmI4UTF0WXNEUHVKODhwTGZ2?=
 =?utf-8?B?ZWdLS3dKMi9PT0JOTUJzWko4YUs2RnF3N0toeXo1Q0hVRFU3c3g3T2xDTHk3?=
 =?utf-8?B?OUtuQm1nQmFPQ3FtSGpDVnlvL0V0bHJMaG5ubDlwVDNEdVJTOXJqTHBnS2ZK?=
 =?utf-8?B?REhRMlUySGRSSk5tSHFPVXlYSENicU5RQ1NHK2FRYU9sWTZJTVJUcnRYRHVp?=
 =?utf-8?B?VHFQVkU3ZE9VTG5QcGZncFlSSG1ZenloSUEwZ25mT3VZVTBWcXBJQVRDbnR3?=
 =?utf-8?B?QllUSWpYcEt5QWEwbDQyc1NneDRNOWNPNCtxYWdGeElqSUVKb0NDQlQrakhv?=
 =?utf-8?B?RFE3N0toVzkrODFJaStTa0YzZjdrSER0aU1BM25QcE1FcFBiSkVJYlh1Tk1a?=
 =?utf-8?B?SmE2Qm9ZUTZ3Y1R0Si9FRkpiRnVkbkRTcUM2dGk3ZGRXMWdZcmFoS29EUmxq?=
 =?utf-8?B?T3NYZnAwYUJ2MjBHb0pWZUlwRERrQVZ3UlpHSHczVnpCNnI3T3NtdnNqU05y?=
 =?utf-8?B?Vkl4ZmhjVjJmRmZrNTdYaGJqZ1F3eTFPMWoyUGVNclN2MHUreFhWTXZQK29J?=
 =?utf-8?Q?PLOTNoeA9p98r9UPE2myUWSwY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fba32f50-8cae-43d5-9945-08de2cb4b88a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 06:26:23.8763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mAQW/njwx5bviA5BiOlKcFcXqqEemVqsgpKnNVOkx+o95GeTHu4VERR4HqJxcbWQzeWp14R3b7JZOYUZ2pHsEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9806

On 11/13/2025 8:50 AM, Ian Rogers wrote:
> Use the counter mask (cmask) to see how many cycles an instruction
> takes to retire. Present as a set of ILP metrics.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/amd_metrics.py | 37 ++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
> index 53f7c2198147..9a39e23075b8 100755
> --- a/tools/perf/pmu-events/amd_metrics.py
> +++ b/tools/perf/pmu-events/amd_metrics.py
> @@ -121,6 +121,42 @@ def AmdBr():
>                         description="breakdown of retired branch instructions")
>  
>  
> +def AmdIlp() -> MetricGroup:
> +    tsc = Event("msr/tsc/")
> +    c0 = Event("msr/mperf/")
> +    low = tsc - c0
> +    inst_ret = Event("ex_ret_instr")
> +    inst_ret_c = [Event(f"{inst_ret.name}/cmask={x}/") for x in range(1, 6)]
> +    ilp = [d_ratio(max(inst_ret_c[x] - inst_ret_c[x + 1], 0), cycles)
> +           for x in range(0, 4)]
> +    ilp.append(d_ratio(inst_ret_c[4], cycles))

According to AMD PPRs, "the corresponding PERF_CTR[5:0] register increments by 1,
if the number of events occurring in a clock cycle is greater than or equal to
the CntMask value".

Please correct me if I am getting this wrong but I am interpreting the values above as

inst_ret_c[0] = cycles in which at least 1 instruction retired
inst_ret_c[1] = cycles in which at least 2 instructions retired
...
inst_ret_c[5] = cycles in which at least 6 instructions retired

ilp[0] = fraction of cycles in which exactly 1 instruction retired
ilp[1] = fraction of cycles in which exactly 2 instructions retired
...
ilp[4] = fraction of cycles in which exactly 5 instructions retired
ilp[5] = fraction of cycles in which at least 5 instructions retired

> +    ilp0 = 1
> +    for x in ilp:
> +        ilp0 -= x
> +    return MetricGroup("lpm_ilp", [
> +        Metric("lpm_ilp_idle", "Lower power cycles as a percentage of all cycles",
> +               d_ratio(low, tsc), "100%"),
> +        Metric("lpm_ilp_inst_ret_0",
> +               "Instructions retired in 0 cycles as a percentage of all cycles",
> +               ilp0, "100%"),

If the interpretation above is correct, ilp0 (fraction of cycles in which no instructions
retired) can be computed as 1 - (inst_ret_c[0] / cycles) as inst_ret_c[0] is the count of
cycles in which at least 1 instruction retired.

> +        Metric("lpm_ilp_inst_ret_1",
> +               "Instructions retired in 1 cycles as a percentage of all cycles",
> +               ilp[0], "100%"),
> +        Metric("lpm_ilp_inst_ret_2",
> +               "Instructions retired in 2 cycles as a percentage of all cycles",
> +               ilp[1], "100%"),
> +        Metric("lpm_ilp_inst_ret_3",
> +               "Instructions retired in 3 cycles as a percentage of all cycles",
> +               ilp[2], "100%"),
> +        Metric("lpm_ilp_inst_ret_4",
> +               "Instructions retired in 4 cycles as a percentage of all cycles",
> +               ilp[3], "100%"),
> +        Metric("lpm_ilp_inst_ret_5",
> +               "Instructions retired in 5 or more cycles as a percentage of all cycles",
> +               ilp[4], "100%"),

ilp[5] corresponds to "5 or more".

> +    ])
> +
> +
>  def AmdDtlb() -> Optional[MetricGroup]:
>      global _zen_model
>      if _zen_model >= 4:
> @@ -600,6 +636,7 @@ def main() -> None:
>  
>      all_metrics = MetricGroup("", [
>          AmdBr(),
> +        AmdIlp(),
>          AmdDtlb(),
>          AmdItlb(),
>          AmdLdSt(),

