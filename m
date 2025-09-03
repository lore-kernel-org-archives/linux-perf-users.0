Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C3F2874F8;
	Wed,  3 Sep 2025 14:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756909586; cv=fail; b=QASpz4EVI2PPG1Hl5Q8tgcnP24Pw/9g2RZFuVIC3EI9HTpQbjGLHzWwAfZ7UQNoI8j42XuJT1bIdUWmPE/lsF6CJ7slTKsVUiPonJochGmt03u2be94GphtlgOQq+DmDO0R7d3sMC2Mg9cvkeBsVyGCByN7EVBQAeZBFxGZzcnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756909586; c=relaxed/simple;
	bh=4bvmK1Gy2QR+/HaC0QDoQ1NPmXPqrSsdCpWbOg+tdyU=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=SLXk4gReKaHXWPtTR5sIYX+56MmCw4vmRyuzubgjQPWwJgpFYCy8XntBRYA0VVzaRSBeqF58hGUwELSoWiHVeq4SWtF9PYvKqyHWb6t9+Hty0awgyWoJSS0QttQzX/yJuNVBSzY6ftOWGRDr7XiTdxc9n1yGnTW1vf8dj2eji8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FSAgGkT7; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FSAgGkT7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n95N6vwtzq43unmgMkHVwtWtzY8ISQgagZASOlBk5LOae8ZkgUiyIp5z4Waowj6f5yRwZETgoL0XqZQwdithY/R6qHTibNLCEN7/w4HdJXJejL/CANKG+CFMot3z3/9wdSH1nq3vYRRIq0sNfT+AtaudtApvJ5ZIUk0OiqjDTumnkwdrrDekOYdZc+LqFak0eIk9+3iNw0GfnXdrDptX4djjvdDZWEQsDtsKJQQoyylULATt7Or6ykVuSEfLLI65GJHZzdTNkSgqJghamFD3IRb5doguc4TRz7klGVhotPV+9wnoQNGtxYuAKLbfqDG60oX12ofV6GQr9Zn1CqY78g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yD78v+8rpdEZrFr/pDkSb4Uj/IcjBzEZVdjL+obHPfM=;
 b=xntffw3m3VzKuKODoBdtOGH0/1vMa/1BSYwUDy1aIqyraBZSfneyB1Apim6HEnZqMmohiia6w1KoX5xOFIREsm49IPcpwP6OQvIB92ONnH43RIOKK96ujHysOg6H52vvE+GsPlvhep+fhDb/bi1Pi7he+nW9Ywme4i0QKDSMCLnyFzfQ3NJ5e/kYnNVVWI00G84+COzFwVRdMcWLlqU0Qkvz5SqL48SJNui31Yud/F9c3FePgpzenfzp7n8Cky47rvaH3zeP6HheAfSdGcmWZrS/kwb5dV/k3lsX4nJl2QxVSBKktM34dhWnS1pNv4/jXgqZoDElBqM/9FxJ03o9dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yD78v+8rpdEZrFr/pDkSb4Uj/IcjBzEZVdjL+obHPfM=;
 b=FSAgGkT7kV9uICsHcBjGJZNqm4gaTXzYrmTx1gorhqh0K++rgHO15uHhpCr3+SyWN9YM19AXmHBOLTdyLRywqhL9CI58QjBjREslnAuDO161RGTOUyA03DBrcEM5jx0dxaoK2z+FME3+dS6rltUJ29rENDMLEJR7CGsD5GR2bN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 14:26:21 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::2efc:dc9f:3ba8:3291]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::2efc:dc9f:3ba8:3291%4]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 14:26:21 +0000
Message-ID: <efb8ef2a-f5e4-4d7d-ba8e-fee5055f7c20@amd.com>
Date: Wed, 3 Sep 2025 19:56:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/13] Python generated AMD Zen metrics
To: Ian Rogers <irogers@google.com>
References: <20250829033138.4166591-1-irogers@google.com>
Content-Language: en-US
From: Sandipan Das <sandidas@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>,
 Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>,
 Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das
 <sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>
In-Reply-To: <20250829033138.4166591-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0147.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::32) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|MW3PR12MB4492:EE_
X-MS-Office365-Filtering-Correlation-Id: d47c9ad5-ab07-4cd6-cb58-08ddeaf5da90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3oxSDFZaFBGZHJESndyZVNQNWxWTlB5M0hLSVFZeHN3MDRuWDRSZTYxWXRh?=
 =?utf-8?B?V24wckJmeE9jTW9HTUJFR0JOdHdyUHRpMXUrQVBBdThjd1BMaUFCdFhDaVIy?=
 =?utf-8?B?eHRYemJhdTcwcGZhelFSNnhwK0FnNjJNVHg3QWJYelhFY3RmWkI1N3premxP?=
 =?utf-8?B?Skc2WnNSd2RPbWp6RXVwSngrbmY1VTdyZ2Y4N1Q0RHJqVjkxZFB6S3BiK29M?=
 =?utf-8?B?MkNLcmRqZGdmRml5ZWpTVDZhY3BJRkg1RDBYbEVETTNmbmppVVEwd2Nyemhs?=
 =?utf-8?B?WWVVN1ZnSUhqQnZ0dWlyTDkyVkxnNnByYkVXSVJ1TDV6THB2QVdaVzB1cGNB?=
 =?utf-8?B?Z25nWDI0VEpwalZjTWtJOWhEQ0ZWYUI1bCtQTmpnc3B5ZjQ3T1JlNC9oTEEr?=
 =?utf-8?B?YU1zYTl3c2x3R1BqdVBnQkk0K0cxSFBHOVBVWVI4eWE4NHhVdmErT1NkQnZi?=
 =?utf-8?B?TEJQZTM4dFFJQjZSSkFFdUEwclNhcHNsMXJ2MmZzbDVwUmdOc2V1Q21JZkVa?=
 =?utf-8?B?b2U3NGNaTGgzNzZjM2NIK2F0Zld1U21zV3hta1VTdHZoU3JXUkdEdkhSdFd5?=
 =?utf-8?B?UGk2SW92TG5ZRDU1QVNuVW9BYXR2NFgzcXJJaFo4SEpvVVR5YnlWSWRzRy9L?=
 =?utf-8?B?SzlCUEdyWnpENGNFcWY0TUUyc25mZHFWL1VObFQ3NUJrWGpLWVBzdXNCRFVY?=
 =?utf-8?B?WmtMY2VqOWhSQTZSVzQ4VWVIZDE5TStxbXR5dzVyeFhWNEgrNkxpaURnRmM4?=
 =?utf-8?B?NjRxbUFXOWJLcnB5NFNhQWRaby9wb0xFU2RwMkZrUmQrNjBzZzRBejdHNWdm?=
 =?utf-8?B?aDdPNFY2azlYSzFBTUFXL1F4RCtxeXdFV1VVL3pndDdaTytpUWtacVFIYjhC?=
 =?utf-8?B?UVNLajRoOFdTdnl3a293Yk0vZFlOYW0rMkhnYlNzcHoxSW12Ky9BM1VpWEZm?=
 =?utf-8?B?THFtNk1hNlJKMzR1ZEtUUlJRNjllYmRBUW5UK0xJNzV5RDlPekd5SDV2V3BC?=
 =?utf-8?B?M3V3ZDhuUVl3ZWVNVWFjbDJJMzkvRVZJZDcrbWxDbDVjcExDdmZVRVBJM1F2?=
 =?utf-8?B?NzNlY1NWTDR2MDlEUkNRMDhzSlpNaVAyN1dUbHZWWmVNa3BtL0twVFBReGl2?=
 =?utf-8?B?R0FnTldLdEJ6Tk45dmtIdnR6ODArS0VoRWhlcFJUVkRkbU5jRERPaWJpNjl6?=
 =?utf-8?B?NEFHQ0FpcGFXMlFHWHA5ckxCbjJIbFlnbXYvckgveVZWYXREQUtuTmgrQk9y?=
 =?utf-8?B?S24vL3cwMGg5cnRZRENucFArQi9TRG1mNFdGNXhiTzNsUERibWM4WmVnSVV1?=
 =?utf-8?B?NlBLbmZHbnFuaHVEa3BlUzAvQ3hsVXZvZy9mRDdZREZ0TEFrVU4zRFRaZ2Za?=
 =?utf-8?B?cGcvd0J6TTVwZmpGM3F2QlArb3UwcVZDUzc0Q1NyV1F1L0U1UUtYbUNnR253?=
 =?utf-8?B?bForVElBbTlFd0tsZUZ1dzhiOUpIVU1OeXdTLzVQNVZCOHgrQWgxUEY1Wkk1?=
 =?utf-8?B?Q3VIR21PT0NsKzdOSVY3WVpsanZLMXh4UjJpUm5VU000NmxJWUtVaytRUFFC?=
 =?utf-8?B?TUhXU1BtTERSNUlmZXpDYng5dG1uNXhmYmw1RHBvemo2anBBOTh5aUljN0JI?=
 =?utf-8?B?VGxXNVBqQVdianNHbnprZGV5cHBsektiUDAwcS85U2ROdDVHQ0NOWG1GcERM?=
 =?utf-8?B?RXBVVUN6Y2QvQmUxZXpDamMvWnNuRjI4dmhaUmNGM1l2elgyU1pVdjkxNGRZ?=
 =?utf-8?B?UnpoU1hrTnNrVjNVNzRpY09XU21nRVBqbzJkbnppQWsvU25iRUpHT2JMTGUx?=
 =?utf-8?B?cTFGaTlpM1hhWDNzTWltaEZocWVhNEV1ZEVjODlCR3RjWmkxRDVOV21mOEVm?=
 =?utf-8?B?VGRsTjVrclVGOW5Wa2JJZnQwU2E4Rk92NDI5SlJlTHZCUmluampWejVVb21F?=
 =?utf-8?Q?cqCnyEdMWjg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0lxM0tXUDcrazZEV2gzQVBvSDYyc0VDRDA0NWQ1T3BBaFBJVGZHc2NCakh2?=
 =?utf-8?B?YkVyQitkSTQ2bmpyQStsbXlSZFY5dUtaSHpQajJhNjV2TzRMUmFOUkEzbXRl?=
 =?utf-8?B?VHAwQzduN1BMaXFtK2hOLy9oSUZqT05neDU2VnZSZTQwbHNoZFdOb1lsSTd6?=
 =?utf-8?B?ZFJqUXFEQ2JjT1E2OWVCNXhTMW9iZUFXWTdnV0FGUlVXOENOU1dybmFCUnNn?=
 =?utf-8?B?WmpwTWNVc0xic012YjVlcU9OZzZwc0IyWWN1Sk5POG93U0RldVFsdEVlRW5z?=
 =?utf-8?B?OXNTZ2hmZzlDNVhFMVJyUkhDY3p6TE5aNUV6SmRTMnVvZHFyT3dFbm1ybFRE?=
 =?utf-8?B?M1pLZXFQZVhqSnJzMjJQbnN1Z2tRYlZ4UHpFWHBSbytBd0RYQ2J6NU9WcUZr?=
 =?utf-8?B?OWVyekdVUzVKR3lZYVhCRkd6bDNFOHFjWmpGTElHU1FMdEJqUlVBMnpjWHhD?=
 =?utf-8?B?OWFWUVZDdUxvTm9CV2huZ2ZFQklyeEFVRUplYTVOenl6ZldWeUkzUDVkU1d1?=
 =?utf-8?B?Sk50V1Bqa2JJOXRnRVVMZHJ6aUVIeU1VYlRXelExa2ZyRktiM2xLMEZXM2VG?=
 =?utf-8?B?VEZuSVNDREZrcFFyRTdQZUZaMWVVM0dKckd5cmhUUnBUajV0aCs2WTNxeEtx?=
 =?utf-8?B?cGR3OHN2c3RMM0RQZHExOFZ2SDd3OVdUZ1I0cFdsMUdPNUpTb0xqRzdJOFpR?=
 =?utf-8?B?bjRmUUFwYmFoamhOamsvcndMc3VjZ2szcGE3OU9BbFlWRGNhQ2VwSFc2clNQ?=
 =?utf-8?B?MXFMSEs5MHdIclI5b0kwSjBaV0VuRzliUlV1TG00VTczcms3VmQ4UTZHYS9M?=
 =?utf-8?B?N1JTNXdERFFtTDNCRU91QjVncHg2SkdOVTRibWloYVhudFBZQTIyNjArSG1H?=
 =?utf-8?B?V0JMMm9VRkJ6WDd5aE5POVVwa0FXTnVjQVh5bHRTUnBhV0dvYWYrNWk2SnpU?=
 =?utf-8?B?cGdza0tuNWxiS2owQTE0MW5xYW5Gc2FJaHNpNjkrbzJRdkZWQmlzRExhWDRr?=
 =?utf-8?B?amVsNFc0T1JYUHRTR1RiN0hkMHBtTE1LV2RsZStyYXVITXVGWXA5TDhvcnJS?=
 =?utf-8?B?aHNodzBaVXhBSVJnRTNWUDVGWE5vdWtyUWtqbEcyNDU2Vm5Gd0lSWUYyN1lM?=
 =?utf-8?B?d0cxc29rZ25oL0x1OGhrOHNhYlBvYUdDNFFNL0xDODJnbUFnTXg4RHhBbmd1?=
 =?utf-8?B?bEhnVjUxTEpSYzlsZkN1cFp4QjVEMXhVZjZ4bEY3a1EzZW1RaHdlRnQySUtY?=
 =?utf-8?B?NXhLMUd0dmU4RHhmdnUyREU2SFBaVUM4RWJVSXlkZ0M5ZnpvQml0QmdlT1Q4?=
 =?utf-8?B?RnJDNFFtbkpHOHg0ajU3RmoranRiUmxFYVdqVE5EcCtqSnIzQzlqOVdjR0ZV?=
 =?utf-8?B?MXFIRzltWWZiZnFwMnFVbHZXb0hKdVh4TkViZ0FCd0pVNVdjK3VlQ0NibmNI?=
 =?utf-8?B?Nmg1akMrNEFtUy9ZLzEyOHNIc2psVEZkL0NZQmVHMzNDUTB6Z3A4TXlwU3ZU?=
 =?utf-8?B?UXI2MUNyVmJ1UEFrRkw1YXpKa21TUEhZbHE1UmpIK3hoMnZpOFdkeUR0MEVY?=
 =?utf-8?B?QzI5ZU91cUt5NUxnVlNYbm5zMWpHZDRGd2JIN1VtVWdPY3M2VjJnZHc3ZmlT?=
 =?utf-8?B?SGNNV3dBN0Z5a1B1dE1FcE5EbXJwL2IxQnhWVG5rUWZJU1B0SWZBby9vRmR2?=
 =?utf-8?B?dWpQZDZxclpLeWJoMUFQcUlabHFIVUt3RXk3Y3lpUWVjWHdQYzhGeVhTVFBz?=
 =?utf-8?B?WnhuV3FpQ0kyckZMdWY2ZVczOGE1ZWJGUHVNK2FxbDFsREMrODdBUy85dnE5?=
 =?utf-8?B?MVFTZzNkTWFiWng2UENHdzhSTDNUR0hQQ2pLSEl1N2U3Y2l5Q1Y3YkM5YWha?=
 =?utf-8?B?b0RubG9tVmpwcVNlVWJNUzFpV3NsVmxPRDljNXlPN3oreUxvSnNoa0pZeGI4?=
 =?utf-8?B?a3IySjQ1RC9SK0xaR2lTZXFJM1E1U1BoSEp6NXpqd3JFN04zYkViZXNIamV4?=
 =?utf-8?B?OGJiMzJ6aUg5djBlUmZrZUN2SnBGMDNCd0NONlNXbGdacE5MU1N4dG93VkV2?=
 =?utf-8?B?Rm5HVmdNYUZUcUxMWFNEckhTcVY5cWxIYStLUXZweDFqazRpMG9oREtkTFla?=
 =?utf-8?Q?VtinH0QuZDmlLg3/VOikwbJwq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47c9ad5-ab07-4cd6-cb58-08ddeaf5da90
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 14:26:21.5040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjbCeRe0ubBdLYs9i6kuW5RbIb0IeUH5HqODc3IqbHu9U905Jfi67A78tjfFWGL4naEzKdjqS5exNrtqGROrAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492

On 8/29/2025 9:01 AM, Ian Rogers wrote:
> Generate thirteen sets of additional metrics for AMD zen.  Rapl and
> Idle metrics aren't specific to AMD but are placed here for ease and
> convenience. Uncore L3 metrics are added along with the majority of
> core metrics.
> 
> The patches should be applied on top of:
> https://lore.kernel.org/lkml/20250829030727.4159703-1-irogers@google.com/
> 
> v5. Rebase. Add uop cache hit/miss rates patch. Prefix all metric
>     names with lpm_ (short for Linux Perf Metric) so that python
>     generated metrics are clearly namespaced.
> 
> v4. Rebase.
>     https://lore.kernel.org/lkml/20240926174101.406874-1-irogers@google.com/
> 
> v3. Some minor code cleanup changes.
>     https://lore.kernel.org/lkml/20240314055839.1975063-1-irogers@google.com/
> 
> v2. Drop the cycles breakdown in favor of having it as a common
>     metric, suggested by Kan Liang <kan.liang@linux.intel.com>.
>     https://lore.kernel.org/lkml/20240301184737.2660108-1-irogers@google.com/
> 
> v1. https://lore.kernel.org/lkml/20240229001537.4158049-1-irogers@google.com/
> 
> Ian Rogers (13):
>   perf jevents: Add RAPL event metric for AMD zen models
>   perf jevents: Add idle metric for AMD zen models
>   perf jevents: Add upc metric for uops per cycle for AMD
>   perf jevents: Add br metric group for branch statistics on AMD
>   perf jevents: Add software prefetch (swpf) metric group for AMD
>   perf jevents: Add hardware prefetch (hwpf) metric group for AMD
>   perf jevents: Add itlb metric group for AMD
>   perf jevents: Add dtlb metric group for AMD
>   perf jevents: Add uncore l3 metric group for AMD
>   perf jevents: Add load store breakdown metrics ldst for AMD
>   perf jevents: Add ILP metrics for AMD
>   perf jevents: Add context switch metrics for AMD
>   perf jevents: Add uop cache hit/miss rates for AMD
> 
>  tools/perf/pmu-events/amd_metrics.py | 654 ++++++++++++++++++++++++++-
>  1 file changed, 651 insertions(+), 3 deletions(-)
> 

For clean builds, I am seeing some warnings for the "context-switches" and
"energy-pkg" events.

...
/home/sandipan/linux/tools/perf/pmu-events/amd_metrics.py:124: SyntaxWarning: invalid escape sequence '\-'
  cs = Event("context\-switches")
...
/home/sandipan/linux/tools/perf/pmu-events/amd_metrics.py:615: SyntaxWarning: invalid escape sequence '\-'
  pkg = Event("power/energy\-pkg/")
...
