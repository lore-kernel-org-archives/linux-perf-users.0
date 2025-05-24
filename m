Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1885818E362;
	Sat, 24 May 2025 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748080052; cv=fail; b=Y8/mMGEC1I9n+X0COQ+Ud+rB6bNiJYM7CXbL56RCL3+a90awBs7ZBnkkN9BWbJ/XnVDPy8V9vEPPDOmkaX1kBGI+MZR5IybW0H651MJxP4PNR3BUf+0UQjG+wagAoZyc25ciXVS1Xsw0gC1SNyZYr1kx4Uc9td81mtquNPrzFeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748080052; c=relaxed/simple;
	bh=SMk+bXJuOjwI0sOaNq6L8tPDPBBwrwkku9eb4gSwmMg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NDtuhKLZZfyzD2mYW7wezrCE3m3jTpHzt0WNED9K4etrUKyHzKqFbxTcFNzvhhwZD8H7He5z7NsHGfNEsv6vimk3Y+ae5tIrLywp0/2mfEwXbP7bk1etGkRnQkZMqgDkGCcabIMN91wMf5o0+dQ9A4xadYpOj9elbdH/fl8uOBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DmVwzN3o; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DmVwzN3o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSO9ESXXStZsr/z6cEEGmIiOnS8V6kSrAuz6FetSr8CHN+3448OM/68Tm01KMV8VTNXH/myTr6pNPgt3KqGFX4TFGnW+pvdTdI0xxhFc+0PC1xd+mHeCzv+kJhW9k/fAfpiHWNcGP7NQEqw2n8UniRbxzDq3m9R86uGGIbAXTmIChXTbDHXqiATkbVdDzB/TUjgn85Rl6x57mmahc+sbDrB4BwYcb2dA8Tpt97lnvnciQSU5OMLEgpqcLs7Py+hSxDZUz1Rb8cyyXZT3mXHPRMd0pg8Os+CF3/QGOBYpcYLsmpwZ1otZbxlrviMCujK8lhquAOQPbVvTzOPSbHUSGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwiUYI990kn5Bm9hFE//DqPtccD/dIlDgwnLMAyCyPk=;
 b=XPZHMsrUt2pcIYWrAaRqpVP6ZxR7M4r1UFk3Fw4UOckn5iwvO46acGF/GDADnGNBO4SGMVFaZ7ODE+oE6xQtXzkMlP5eDMCU3R4czC1HmYXovY4Hxhfo10zZzw9jRXtk158vjrMvWx1N/58CgwscXcd5LTCExpM2XPAZDhXHZ5u8FrjPnHLBeHwZYHtR6MpounXXsGcg0aZ1xIGW4s4VSKIFnlWZTlBUTjz8m9Hiv/tcMaZlt89Kl2n6FiKW8dmCXjHhwWBE3wWywvzZnk26dVqSyMCiBFdR6/QCSyDXRaxvQkf1cS7d00hCRtjAFqDsI7n4zHwnu0lOs29GoLq2dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwiUYI990kn5Bm9hFE//DqPtccD/dIlDgwnLMAyCyPk=;
 b=DmVwzN3oV2rkJ+6IjQSEcM9SQTezlLubbgJ8J8eTSPQE8MkAWeSUgOLjiEQhSudCaRw6CjQhYeFuoMGPBTJwz4MoQStzSj+EMs2EhOtse1kVHevBBjizS5wcPrcL2IK+Tphx8cmSckSsUVa8UVm6lGsK2qH/RIjAa4xaPBwSJeQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM4PR12MB7503.namprd12.prod.outlook.com (2603:10b6:8:111::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Sat, 24 May
 2025 09:47:25 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%7]) with mapi id 15.20.8769.021; Sat, 24 May 2025
 09:47:25 +0000
Message-ID: <960adb81-2c77-4e77-b685-b3f3005cb286@amd.com>
Date: Sat, 24 May 2025 15:17:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf test: Add AMD IBS sw filter test
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250524002754.1266681-1-namhyung@kernel.org>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20250524002754.1266681-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::23) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DM4PR12MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 2adb5b83-2c8e-410f-2cb4-08dd9aa7fcc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0liODhKRGR0ZWVpTkl0d2cxb3JMUmNxM1VVNTJsU2ltdXRZMFE2aERnMzcw?=
 =?utf-8?B?aGorUnFaNnNhL0t1dHAwLzN6S3VoaG1HdHlKbEVwWC9OKzRKTnA4Ukt6OG1p?=
 =?utf-8?B?bXFYVkVJU2hLYUx5dURjU1FRb01UUXF5K3k0UkdFanhVRWtXZ0daUkszT0ZB?=
 =?utf-8?B?NFdyWlE0elFXT3lXQUlFYzEvRkd3c3lIZFBCTDNYK1hnYzJsWndpOUxKbENN?=
 =?utf-8?B?bkx0L1lmd05ZN0hIRGhFb01Da2krVzZyaWx2SGVPNi91QUxGUjRLVU9FdVg0?=
 =?utf-8?B?MEdxY1AxbDZMbXZVQ1U0SnlYenZTRS9yWTZUOThwMi9BRDhJeFB4NnVVbFF6?=
 =?utf-8?B?eUpWYUYzUDVvRTFmMEhMSjA0K2dlcHBoaEZBcXpNVnIvSUN3Q3pHWXR0L1hY?=
 =?utf-8?B?ZVZMNTFpWGRoZkVEbDRjSHZkYWJONUc0NU5RMnAwbEZJazhIM0IrWldrYlRm?=
 =?utf-8?B?UE1GMlEzUFMrRm9sU3ozRFUrTzNJSlBlQ3lCdnVVZUpBV2dxQ25XZFZka0Z3?=
 =?utf-8?B?dEk4MXpHY1FVL0xCYWp5Y042THlFT0YvV0RKRmdVNkdFZ0s5VE1HWDQxMzlC?=
 =?utf-8?B?NHJFTG94UDZodkx1cEZhTDg1NU5HYnVpd2NWcEQ5ZUpTdDlVNjdIc1liMnJG?=
 =?utf-8?B?TEtqWWVVaUpJN2hTQzhHK2czT3c5VFdCOUVFcVNVeWwwZ2orYzYvUnhDRzFX?=
 =?utf-8?B?T3VIRHpqWXF2ODRTaWU2dkpMN3pBK2k4MDVWUDZOY2FlOHdEbmF1a2NjeDd3?=
 =?utf-8?B?TnZBeDh1Wi9TMSs4eExXSnRyWDdsbWZ2NHpQS2RXV25EWWJzZE9tNW9NZ01J?=
 =?utf-8?B?TlhweTdMTk1vTmJZRUZndjM0Nm5vR0xFdExpSHE2WTU3aXBMMWVzREd6YkFk?=
 =?utf-8?B?ZGduaXJyRG1BZEhqbXZRSGhiUjUzVWgyM0NnY1BpcEorNUUwb05yV3l0Y2Uv?=
 =?utf-8?B?K0E2SkJTTjg0MFFuMXQrcVRJbGVVZnB6U3VDNVFUYlpjeE5GbmU1aUh6UG8z?=
 =?utf-8?B?M09xMVNvSzBCTnlJR0thVERMMlc3NEI3Q1hZc01yUXFSb0FqL0dIaHhjRVFq?=
 =?utf-8?B?YkhqR0NuM1ArWTduV2tqS0tsZ0I0TENZMW52Z1dkZjZYeUY3d29YVUdzSWhI?=
 =?utf-8?B?QnYzaUMwaUUrVm1Gak1GMUhxUFdsMDVVRFpmb29MYXgxWndheExLQ09DY2tP?=
 =?utf-8?B?VHNWSXhCRU1jSCs3d1diaWFZblBRckxmbFZ0cjVDb2VLUmlha3ZYcHd3M0py?=
 =?utf-8?B?b0xqVllDWXBNM0k2Ymc3OEUrU0N2YlBMWlJRaEM2SnBqa3NnNE9mMWNhYURq?=
 =?utf-8?B?YmlRZ29selFlQWlXMUpBL2RGclZZQldGTXF1U1dzQ1BiYVU4VVdEODBhKzNZ?=
 =?utf-8?B?MWxBYXErdVZ3U2RIRHZBWkpudXU2N0lGYXJJN1BjZXFBbTVPUDRkOUFHMDdm?=
 =?utf-8?B?SGtsM00vQlRzYXBOTkF3TEZZZHJPS2dWYWQwelYrU3Zuay92bnZvK21GaVpy?=
 =?utf-8?B?YXYwNkdSei9GenlsclVLUnNvM1VPMEhiY2tVUUx4VUlBSDh0OFdwNzh1cEFI?=
 =?utf-8?B?OXcvVWJuRTlCN0hNU0EzOWh4eGhkbjdjTDNsWXJOajNPSmR6TTZaSlJzc2Vy?=
 =?utf-8?B?TDdyVkxjTEJxNDFjQm90YUFoTjZ6aHVrc1ZNSHBwZVQ0UWtzbmpyVmZsQkpD?=
 =?utf-8?B?QzdTc1FrSEd3TDgxYjZkY0ZOQTg0akswM28zY2pCeXNvT2g1dEp3UDh5Vkto?=
 =?utf-8?B?bzkzbzRib1dXNDlVRzlXL1Jld2h3KzdLQ3BtaGVTcU4zSk9tNjlrL1RqK0lz?=
 =?utf-8?B?bEdzcXV3NTlidjk5ZE9STkhSVWJwZjVWTURxWkI0UEhDbmMyMk1SOG0wYm5K?=
 =?utf-8?B?a3NtNGN1SnpLaW5PVlQ1UzBNQ1NmdmhXOGJOUHd4b0s1dWgyQ1ZqZzZ4U0dx?=
 =?utf-8?Q?QVsEUBv6Lr8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1ZMR0J6NVNRTkJJQ0F5UWZhK2pkdjZsZmNaZnNkV2hVbVFtcUl3MW0xTmx2?=
 =?utf-8?B?ZGRzVTM4bXVqaUhJb2NXd1JoYjNHRWQrZVMyM2pvRGUrQUh4VHMwUC9iRDFV?=
 =?utf-8?B?VEhDRWFkTUVFQlJBZHVGL3FwcVJEK0pBTmlMaWp6Z2UrdERoczhjYUIxdnBG?=
 =?utf-8?B?QkxPZEluZXJCU01VeEZRZGlYTE00TDRjREJjR3lKN2p1UStuUVR6cHVpb3NJ?=
 =?utf-8?B?Y2VpWHhPdUk2SitnUTdFNEpHam1FV3lOMXc3aEJMS0pEZ3hjd3UxVjN3Mk9i?=
 =?utf-8?B?SWxQOHNnVy9MRkpvdHo0WVYvSGFDRktiR3dFdThpZHJOZnpaK0xDMVFUcnNY?=
 =?utf-8?B?NEovMG91a1dsMTdSZEQyYU1qY1hQVUdFRTJ6MmtVbXlTcjlQM3VBdkNwM3Vm?=
 =?utf-8?B?S0JxYm5wbm9xbFE3VWh0UW51eS9TWWdyREE3WnZiSTdxUm83RmJUZVJobS9B?=
 =?utf-8?B?UGVHZ0hyRnJtZGhFdGthZFc3MWpXbGg0M3VqNFVsWmtCYm1Wb09hRUpnS05P?=
 =?utf-8?B?MUUydE5WT214dEJjaHJmeFc3L1F6ZmtFZW5WMHF5bXM2SUEvMktHYTlPanBX?=
 =?utf-8?B?ZXRlUTd1d1FBc0x2NGY5Y01tSUlUYmIxQVJ0eFhYc0dTNlVDUUpveGgxSlI4?=
 =?utf-8?B?Q0FwcmRudmZqck50WG5RNWFRRnlGOW5jYTZzTVlxcklPMW1uZVg4RGszUHJX?=
 =?utf-8?B?WnM5OGlaeVJNcGFmMjlrRnpOeEFmSm5hOVN1MEtCS0FiTVM3MVdOSm1ickpE?=
 =?utf-8?B?NG1XMFE3QzhuM3c2MHk1WG1Rb0pqR3JJWTEzY0NMemZOZXJqdUlaMnd6Zk4r?=
 =?utf-8?B?cC9XMkpnMXJMRUJJUU9xR3BLSlNHbkMxWW02MTBlME4rZFBjVnpOM0hBNXBZ?=
 =?utf-8?B?TEUrSFV0ZnNyK2VlcnVRZFYvc3BEOWtYckpSWlBDd2w3V2R2eVpzVk5ZeWQz?=
 =?utf-8?B?WWRLUlczZ3N4WWg4SHhYMlc2bU1zU2huZ2J0Y29taG8vUXNaWCt6eEd0Y293?=
 =?utf-8?B?SFJFTC83c1BzSnM1aEtsai8wSTc3L3ZiM0h3SEJGaVRrU1BLb3VvTmtYUnNI?=
 =?utf-8?B?cUNiSHU2aDVSOUdsTk9EQUxqcDlUYytETVpPZDVuKzNYUGZidUsxZlVBdGdT?=
 =?utf-8?B?bXVoaE9ZZ3FpcDMySVNSOEhIWi9xNzFtSWhiL0cveTVwOU8vOWdDN3MwZXE5?=
 =?utf-8?B?QjNIU0krSG52bWJxQmt5SUExUGJDc2E5WStDWTlmNG5ZSCt4Nm10Ulhxek1W?=
 =?utf-8?B?QUJ4Z3EvMmtjVDNXcnNldU1uaVM0eXRFdmRaV2Y4MXNQc1RYZkViQWhzbkhX?=
 =?utf-8?B?a3lpaUpVeU4rOTcwcW1STEljZGtQYWE3dWU0MzU5bHVhZVhzaEpwaUw1QUND?=
 =?utf-8?B?dldvajg3dkwzTUxDQzhJNlNXa0pScXFwd0w3TXovUzFiaVpUL1cxZ3FoVSts?=
 =?utf-8?B?RVZLZUE0aE9QbjNKL2pKMG5rc1ZDR01kYzl5c0pOakpQS0NyaGdqdWZIcWdl?=
 =?utf-8?B?SkZPclo0d3AvZkZxZVFSTWJ0VkJ3MjFoN0s1WFMvak03UUFDTTkzTGx3RHdj?=
 =?utf-8?B?eitVTEY1M1VlLzV3YWxlak9aUFpVZkxkSHhCQ0x3TVV2ZXdIK2RrQ0M5T1hJ?=
 =?utf-8?B?eVNLS1BjTHo0OWhhUzFQS0Fuc1Vrd1E5d1UrYkRLV0hJYjJtQ3RBY1Q1Wnkx?=
 =?utf-8?B?aXhlaFd3MnZrWVpPb2ZhdlZaY2IyNUd4SzVCV3duYU9DYnU1eTVTdWhkYXlS?=
 =?utf-8?B?TWxrZGQxV1NXQ3BoNHE5WEpNSHI1NGZocjBYM2tkZ1p1SWlYd1g0dGdMVUdl?=
 =?utf-8?B?b3hFeXVxVllhV3VyaGMrMzVrMXdtb0lEN0djbTdoc2hHOHdIaDIyKy80dmFl?=
 =?utf-8?B?ZjF0VGFtczU4MVY0Z0FXR090am55Mk5sUGdxSGIzK2ZVRlY0cXIzOHNXRThS?=
 =?utf-8?B?MkFsZ2lXNXlaRWk2ZzdRVU93MTRYUXZKTk9qVmNMSXRDMWI0aFhWdGRDdk9i?=
 =?utf-8?B?MlBzeHJTbmM3dFV6ZEhKV3hsa01iSnlyV2h5QTd2ZkxTdUhSenVrSFdIZW5H?=
 =?utf-8?B?bU9XcHNSWFBIbisrRUVGamFJbXYzQmgwUEZMWFp4RTh4dngzNlNteXcvQ3E3?=
 =?utf-8?Q?XFnWBrpu/8xzEwsKN/7nuakHD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2adb5b83-2c8e-410f-2cb4-08dd9aa7fcc0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2025 09:47:25.1490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tWA1K0ofo3dlDmZfAYixINM1Y+rdbtnjCCjxdfNdWRp9IOzkg5oxCZ7BkxkyLUwZADBn8F9KHEm7rcDg87swEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7503

Hi Namhyung,

On 24-May-25 5:57 AM, Namhyung Kim wrote:
> The kernel v6.14 added 'swfilt' to support privilege filtering in
> software so that IBS can be used by regular users.  Add a test case in
> x86 to verify the behavior.
> 
>   $ sudo perf test -vv 'IBS software filter'
>   113: AMD IBS software filtering:
>   --- start ---
>   test child forked, pid 178826
>   check availability of IBS swfilt
>   run perf record with modifier and swfilt
>   [ perf record: Woken up 3 times to write data ]
>   [ perf record: Captured and wrote 0.000 MB /dev/null ]
>   [ perf record: Woken up 3 times to write data ]
>   [ perf record: Captured and wrote 0.000 MB /dev/null ]
>   [ perf record: Woken up 3 times to write data ]
>   [ perf record: Captured and wrote 0.000 MB /dev/null ]
>   [ perf record: Woken up 0 times to write data ]
>   [ perf record: Captured and wrote 0.000 MB /dev/null ]
>   check number of samples with swfilt
>   [ perf record: Woken up 3 times to write data ]
>   [ perf record: Captured and wrote 0.037 MB - ]
>   [ perf record: Woken up 3 times to write data ]
>   [ perf record: Captured and wrote 0.041 MB - ]
>   ---- end(0) ----
>   113: AMD IBS software filtering                                      : Ok
> 
> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>

A minor nit below ...

> +echo "check number of samples with swfilt"
> +
> +kernel_sample=$(perf record -e ibs_op/swfilt/u -o- true | perf script -i- -F misc | grep -c ^K)

"true" barely runs in userspace. So, many a times this "perf record"
generates no samples :)

Thanks,
Ravi
