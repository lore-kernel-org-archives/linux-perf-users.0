Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021116.outbound.protection.outlook.com [52.101.57.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CA32245EC
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Nov 2024 17:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731088095; cv=fail; b=nQtKL3ko4XP7cJU5bXdi4KvTTE/bdLLVp+jtyiF13enLB8EZZyjmKzEvy3IExBFApPJHCpPL6VKzbzWF/wsAhGm/HTjntutipjhuwsgR/ULTnftEwOdtgTSc2kgsPABxj5FYZufUFU+qbUJqltk4MLYq0Dcmr+c9gpwuu3EWdRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731088095; c=relaxed/simple;
	bh=vM/fvjn/H6iHn1wCrKA5xfSojjt5fZW2PE2K5wgwwBA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fqoYVnOTQZcZVN3/pVSQQiWWZ5lwVieKleQoD+g0LTLG8rRMQjM9xfC5f06ti83ubvurT71I3l4E1NIgl6HM1iHiFhvsuehuZlfcrSSDQWgJzYi26oSTsvcDv1sswd7KtzFrydzTh8f70E+/Ia2bAUZVh9IH3AGm8ep4v7ve4hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=bTok5NBb; arc=fail smtp.client-ip=52.101.57.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="bTok5NBb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogJNMc8B1k3FARj2Fh/5vY9k0bfvEFQ1bgRU6NffcmAiQxRH3LNC5Lr77lh5gc19f04sfm32oOv72KITmokngT7SiBgtDVbPXnfoJxm3lZwiMNbO8Mm6ntI62fFdLXDniTzsddSPqnYwb/e8IVDEjG0p/OdgGexB3w9mEzWOEVnis8GpfNJROSIr9LDssQqH4FFqbWTsSIye4fuFAVxuV7xur4rWyex20+/4FruXGKwMbUVFN5FQT/wxU5lw9HOWY2n0a8DOlZeaUVpIPgcyrFtmS6EqnoSTIgKQPMiRNvPvEXurypFkbGn7HW4MXSka/OL12NC9zcJjRGKAMDCwQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USEZEiZJ0QV8pexn/x79BnZOAEpf9F7LFe1YFNzgRXw=;
 b=uFLDm0SQKOzNmxlOtrQp48Sgxl6s0n4WKPgF9phCfV+RbEd8wSPY84fhD5uF3aXWQNz0QTX7v03Ys9CnRNv1HkT4KsbCLC1ViiIftrI/ykAAFxhSanids1m1FrQvPL8AT5CwLOkSX1MR69AThTtWL772nU9EhWDcngumFy8xMGAps/LxjeYoAa9FHqGjmgb5zCyQupAi7JsWkXlEiAkZ/fHP0VcfWMsotDlAZi2aN/7zzsIDDtt1Wn57Yzsvj4GkntSK9zTO3uovNWHRwrGCsJTGOAdsyZDXAoX37s9X/Zv3gvay5G04AEhX7w7upWUzlnsJd6gJ3a0ZbNduaqurKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USEZEiZJ0QV8pexn/x79BnZOAEpf9F7LFe1YFNzgRXw=;
 b=bTok5NBbvBgG5UG6j2R0XH84k40Ox5MHpaibqeKdqdvxluv7hPqGNV7u5+39brIHhUYiEMqMRdar30SLy1SseT7yqhF1L8NGouKpNXFfxl4886KGLyAsh7nGAcqLmp6V9EjwrDGE9csacjT9wK4Ih0JzMNpPzpn1jH7gXHN/TKY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 SJ0PR01MB6352.prod.exchangelabs.com (2603:10b6:a03:293::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.18; Fri, 8 Nov 2024 17:48:08 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.8158.007; Fri, 8 Nov 2024
 17:48:07 +0000
Message-ID: <b28d4e57-a152-4aa8-8c91-69ce0198dfa2@os.amperecomputing.com>
Date: Fri, 8 Nov 2024 09:48:07 -0800
User-Agent: Mozilla Thunderbird
Reply-To: scclevenger@os.amperecomputing.com
Subject: Re: [PATCH V10 RESEND 1/2] perf util scripting-engines cs-etm: Add
 map_pgoff to python dictionary
To: Namhyung Kim <namhyung@kernel.org>
Cc: leo.yan@arm.com, james.clark@linaro.org, mike.leach@linaro.org,
 suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1728599785.git.scclevenger@os.amperecomputing.com>
 <20241106235110.5NbhrBJjBk6qY_Sg0BJUbMXfpfpi8KZK5R-y4rZfKXI@z>
 <Zy0MPdvV5ofHtyE3@google.com>
Content-Language: en-US
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
Organization: Ampere Computing
In-Reply-To: <Zy0MPdvV5ofHtyE3@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0224.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::19) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|SJ0PR01MB6352:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ebfe4c-8fcc-4109-05c5-08dd001d8119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vlk5VEpZMW43Smk4aWtlMHdUWFI2TWhuMUlMamVDSzhUS2Z3M3JiZFZPeG9a?=
 =?utf-8?B?NDlOdE90Yy9TVllRTEl0UkppTE50OXNXd3loMVhDOHlZSTlaOEVtanBGSndP?=
 =?utf-8?B?Y2hTRTdrZy9UN0hjTStwdDdkSTg5U09iUmxYcHg3V3FzNE9VMUkwT1NtaGVD?=
 =?utf-8?B?QWRENHhScEh0NTlWckpoamZicWphWGZDMFBEdVh2cGtQd1BRVU03M2t6aFY1?=
 =?utf-8?B?bXdWZ2JlMkxqR0pwZXZwL3MwMHN6ZWdzeHNobDgwOXczS29KVWpOTjJ1RUI2?=
 =?utf-8?B?MG5qQSswaVZWb0NRakNUVFFEa3NHZ3dEY1N4NWJFSzB3YTdFTVNjdmU1NG5F?=
 =?utf-8?B?UzgrOXhJU0NESmlSZjhQbmJ5ZnBYeklEWGVhOWx4M0ttRzRZOWJxV09weFAr?=
 =?utf-8?B?bFRNMEFDQkczblNqQjA2dzFDS3dTaGdZd08zSjNIVVVjWlBWcWszZkhseko2?=
 =?utf-8?B?eWtLelFwVFNOVlB5YlQrTVY3dHJHOHU0cnduOTlDTmpIQWFtY0NGNkZ4bVlT?=
 =?utf-8?B?U0pOczQ0RVdka2tWOEowWjRUaGtnSHRQSkhRU2xmWWtmY0NWSG5RdHJncXhU?=
 =?utf-8?B?UWw4SkRDQ0J4WEhmVjBueGptbmdmREo3TGxLa1IwUWM2MlNjT2RpYlNPZXFT?=
 =?utf-8?B?clMrd1QyNDd3czRNQ3NUMHNhUGlpbnhQSkFuVDJWNFVnV0ptUjN6cU4vU3hS?=
 =?utf-8?B?MG1lb3Z5MFlrVyt0aC9BVXRWbmdPSE9kRmdFc2VYTVRtOGhIRzdUdWtqUlJC?=
 =?utf-8?B?TVk5eWY3clFJT1ZrQ3pMWU5xWldXM2VHRnh6VnFXdXdJWm1nK3JqallZazVp?=
 =?utf-8?B?SkcrTFpGc3pRQnROQmVjUEtwQXdHQzFOWnNGamZZcVRWaTUwb1hIWTJoWGIy?=
 =?utf-8?B?NndXcVBQb3E1R3pIYjRpOVdMamtQa1BqL1hkVFFCMHd3cC9LQlY0RXlyenVa?=
 =?utf-8?B?THVIUVJtaFJMZVJpRUhCNy9aMEdrQ09QbXpCZkZIZ09mdHd0NzVXNTk2ZnBp?=
 =?utf-8?B?TGVBTk9xUmpBSjM4UlNxWk1aT1dFN29ZUk9rdE9KSU92Z3QzQ3dmWEJiWHRw?=
 =?utf-8?B?bFNITDU0ZUNOY3VmeDBiQVd0UTA4OWRqcTNHbEtZbGFwOFlTbTByZXpsZTBX?=
 =?utf-8?B?YUtlcHJTc0QyQ2xuWk85L0djK3hlSlpYRERDVGJhWmU2VVRqeExoZmpyc2s5?=
 =?utf-8?B?a2RFcTByakNsMStidGRPNG9sc2xneEhwWXZVZkNQVXpYQU5mc0IwRmllZnhh?=
 =?utf-8?B?d2JDQ0I3Wmd6MEN4eldIdEd6a0dVV1NJUWo4RWh3dmhid1NLQ0NVRnFIazY2?=
 =?utf-8?B?dmpZQnJnNWdMUEx1eG9XOWpFM0FHeWIxbkp5VTdkRFBnN3pxY0loZkR1eEIz?=
 =?utf-8?B?SnVkeXdLOHdoLy9kTk1QdStzUE81V1hrUGo0U00vblMwdVRLM2FtWHR3WndU?=
 =?utf-8?B?UU9Ra3h1ZU1GMlkvMTdLR1MrZHJTS25RdVZXWFU3QjJlSmlhSUEzQnc4UTd0?=
 =?utf-8?B?MGNjWUg5emFCNitKazZHZHEwQ1FWWXBIV1pZZWtjb3h0TjkrT29EZHBERUVa?=
 =?utf-8?B?ZGhwZnB5UnFvcS9wZ3FsalZQZ2tQU0hWeVpFOGt2THh2ZDB1dHd4Wm1Wakla?=
 =?utf-8?B?T2JDbVA1R21EYTNRUktIN0tOTHdvQnI4SHROTkFPWkJxUmw0OTVReDFETTkx?=
 =?utf-8?B?ejFUYXhCMTVTQzVqMXlsTGNLdENCejVQMkVuY3lwTUd1ZUx1YnByYWJMaUE1?=
 =?utf-8?Q?bJO4QLKW7k9PZeEml/BKYEuKSkYN9b63/8UP7wy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2VxdGkrNkJuMWYrR2VDcGs2aURPcVdrOGFDSGlhVWo4YllvQzl3RSswMzIz?=
 =?utf-8?B?c2tWSVEyRVBWRExVOXp6aisrdGw1Q0RtQW5paUtNYklKSHZDR3JhTWhFMlA0?=
 =?utf-8?B?eHVvOFZMZno2NFZKbWlscWxpTlpwbktRN2FyM2tlWDVFaDdGeDJKZE9ySVU2?=
 =?utf-8?B?Zy9iLzNyUHF6RUs1TjJDSHF0Slp6ZzFKRDJGYnBhSGZXL3IzaG14RmZ2Wklo?=
 =?utf-8?B?aU1hczZXSElTWFZucEczYVltL0UvT3Q0VmdubDdNbnhjV0xSSnVMRGJMYjJF?=
 =?utf-8?B?VXBONE5pZitGTHRyVkpFNzdndEhFQkk4VThicSs1U3FiQ3BvWVVSa1lQNnFN?=
 =?utf-8?B?ajI4ZFoydGJST3Y2ajFNczZGU3I5R0RYQnBpTWNReUJjdi83dkVpUmpHcGxk?=
 =?utf-8?B?bWN1Wlh2L1A4NmJKL2RraUhoQVVwOHo1TXdJRWE3V0FrVk5FcWtDajQyL0xD?=
 =?utf-8?B?akFrZEtFMzVUSWE0SGU4N1lPOUErNlpiNUZMRURMdjZ3aFBSeTYrU0k3K3Nu?=
 =?utf-8?B?dEtFc1RNSkdJOXlIeHdPZ3g4MkpBQU0yOXJGV3RCSXBWTFUvOHZWQ0lvd0dO?=
 =?utf-8?B?THVPZ2pXeTlUZDlhdEc1d09EM2xucEJvR1RQWnZTY1BqZk9lWXIvVHE1cDJJ?=
 =?utf-8?B?bnJhdmNJV2dwQzhUQXBDdW8ydDI2UEhyUjI5RHFITXoyZFc1bHhwSnptNmk3?=
 =?utf-8?B?a2tyS0gxWS9rcGZsV1FQbVFRbWFaVWtCY2pKTEN0ZHV2ZWdzeWVZRDBOdlhj?=
 =?utf-8?B?L3pXeCtrZU0wbEdPMXFJd3liTE13NFM1UTdLeXdReEx6bDN6ZUwrVW1zV1dm?=
 =?utf-8?B?VXU3RmRvU2M2UWVUdlZVcVo0N3F1UENJbFFCTkVHMkZPcFgvQVR6eXBkOWht?=
 =?utf-8?B?SERSTGhISWJqMDBFSFRycmZGbmpwdE5XVmRibmRQVUN2RDNBWTZHT2hsd2dY?=
 =?utf-8?B?T1ovcXM3dGx0bTdhMlRaUFdFRjRrR2gwdjdqMXlkUlF6YStNRlN4bDRKdEFB?=
 =?utf-8?B?TjFqK0x5dEdHQmZWd1c5bUFhNHJ3WG5hWEZ1VzJzN2FENWFUM21RZ2hHWWFC?=
 =?utf-8?B?MWR4R205QmRFWTFvYjVPWktYRDFQRE1WYVVFalBXYXRNMWV4SDNEZ2ZnUFRl?=
 =?utf-8?B?TUZ6Ynl0Skw3TEdsNEx2RC92TFZ4Q09wRUdVRGM0dytnRHFXei9obkNyc0lP?=
 =?utf-8?B?bXNXbWhHMXBJNDRxNzh5dGs0ZmVxM2gwZGVDb2lyNzg3ZHlJMStvSkYva2Vn?=
 =?utf-8?B?MTkvU3QxVHBnbjArRlpTOXh2b1gyczJJeURUdVFlMjFyVmY4Nkg3c2poMzha?=
 =?utf-8?B?c2ZUdGJXMGFZT2txSDZHY1oxbVE2STZLdU8rR21HYWIzaHVIQUF4TXVyOXYw?=
 =?utf-8?B?MkgwUWhtdVgxNnJ2cDl3L0IwckJWRGNmMUFWNEdlY1F6LzU5NEMvZjBIL1Jj?=
 =?utf-8?B?bnB1WkZTRmFkR1hRSndaUXQxTEE4RzA3bjBtYXdkZFMzbm1oK0xXcVFWeEM2?=
 =?utf-8?B?L1J0Ti96RndyQ21aTlVQeUhGWlhFZkhWbmNaN3RGTThOSVNJcTNzbGE2MzRM?=
 =?utf-8?B?UnRGcWEwYVR3YWtQeWUyVGFiN3QrS1BHRmRKRXlQTjNWeG03QUo4eXlKNVYz?=
 =?utf-8?B?STRXZHZhVEUyQTMvdVZWTXNwcjRXQzRzN1RBSTdWRU5lSkxzYTUrNkJyc29G?=
 =?utf-8?B?NzhQVkNHMXV0dHozMEpHUFJuTG9OQ3FDUHpEbjh2ZCs0ODQveFFycExVck13?=
 =?utf-8?B?VE84VzRTNkJTMUpmS3doVmtyc2Mza3lpKzEyTDcrYllVUi95UTJIYWhEb21t?=
 =?utf-8?B?MHY5dm85ZkFQSndwalk1Wk93Ykp0dGxDQ2FobHJhcjU3TUduU2QrYks2ckFC?=
 =?utf-8?B?aWZCMk5IOGJ3bDQ5SkNqUlZHMFBhTXB5Y04zL3FaQ0lOTXA2VjRtT25tR1ln?=
 =?utf-8?B?eEh4VjczVmd3OWdYTGVuYU4yajNHRzN0aEdCK0NOS0Q5YXkxZlBDcVN6b1hu?=
 =?utf-8?B?eVVrSlI1Q2htajZqOE5wSk5RUVRVV1o4c1JWejQweWMxaHhrajFaZjZBcTBq?=
 =?utf-8?B?dVlNemhDNUszUGFPNEc0a1hMdytnamhXVXFzR00vVldXS1lORERJNFJkbHZj?=
 =?utf-8?B?Vi9TRStLc3JqeEtKRjh6ZGhBbUVJWEFIYkZueUNjbUhEQ1k2NWN5VGFZazYy?=
 =?utf-8?Q?1lNzZKaFIVu3ifhJswWABOA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ebfe4c-8fcc-4109-05c5-08dd001d8119
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 17:48:07.7864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxBN6mgkpauUIDONxaFosYOU9aoaj0rdDrlt0i/xb4ls2YsqhaToSMjfa9xl78HQYui0f9G2ccxJv3xfRtvNv2uXGpXYlQ843K9IQkO2eFjAXX3FvpH59TH29gr7ql3S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6352



On 11/7/2024 10:51 AM, Namhyung Kim wrote:
> On Wed, Nov 06, 2024 at 04:51:10PM -0700, Steve Clevenger wrote:
>> Add map_pgoff parameter to python dictionary so it can be seen by the
>> python script.
>>
>> Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
>> Reviewed-by: Leo Yan <leo.yan@arm.com>
>> ---
>>  tools/perf/util/scripting-engines/trace-event-python.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
>> index d7183134b669..367132b3a51a 100644
>> --- a/tools/perf/util/scripting-engines/trace-event-python.c
>> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
>> @@ -793,7 +793,8 @@ static int set_regs_in_dict(PyObject *dict,
>>  static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
>>  			    const char *dso_field, const char *dso_bid_field,
>>  			    const char *dso_map_start, const char *dso_map_end,
>> -			    const char *sym_field, const char *symoff_field)
>> +			    const char *sym_field, const char *symoff_field,
>> +			    const char *map_pgoff)
>>  {
>>  	char sbuild_id[SBUILD_ID_SIZE];
>>  
>> @@ -809,6 +810,8 @@ static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
>>  			PyLong_FromUnsignedLong(map__start(al->map)));
>>  		pydict_set_item_string_decref(dict, dso_map_end,
>>  			PyLong_FromUnsignedLong(map__end(al->map)));
>> +		pydict_set_item_string_decref(dict, map_pgoff,
>> +			PyLong_FromUnsignedLongLong(al->map->pgoff));
> 
> Please use map__pgoff(al->map) instead.  Otherwise you'll get this in
> the debug build:
> 
>   util/scripting-engines/trace-event-python.c: In function 'set_sym_in_dict':     
>   util/scripting-engines/trace-event-python.c:814:60: error: 'struct map' has no member named 'pgoff'
>     814 |                         PyLong_FromUnsignedLongLong(al->map->pgoff));   
>         |                                                            ^~
> 
> Thanks,
> Namhyung
>

Hi Namhyung,

I do not see this compile error, and I typically build perf with debug.
This make command works through 6.11.0-rc6:

$ make -C tools/perf DEBUG=1 VF=1 CORESIGHT=1 PYTHON=python3
CONFIG_LIBPYTHON=y CSLIBS=/usr/lib CSINCLUDES=/usr/include install

I can substitute in the map__pgoff() macro in any case.

Thanks,
Steve

> 
>>  	}
>>  	if (al->sym) {
>>  		pydict_set_item_string_decref(dict, sym_field,
>> @@ -895,7 +898,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
>>  	pydict_set_item_string_decref(dict, "comm",
>>  			_PyUnicode_FromString(thread__comm_str(al->thread)));
>>  	set_sym_in_dict(dict, al, "dso", "dso_bid", "dso_map_start", "dso_map_end",
>> -			"symbol", "symoff");
>> +			"symbol", "symoff", "map_pgoff");
>>  
>>  	pydict_set_item_string_decref(dict, "callchain", callchain);
>>  
>> @@ -920,7 +923,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
>>  			PyBool_FromLong(1));
>>  		set_sym_in_dict(dict_sample, addr_al, "addr_dso", "addr_dso_bid",
>>  				"addr_dso_map_start", "addr_dso_map_end",
>> -				"addr_symbol", "addr_symoff");
>> +				"addr_symbol", "addr_symoff", "addr_map_pgoff");
>>  	}
>>  
>>  	if (sample->flags)
>> -- 
>> 2.44.0
>>

