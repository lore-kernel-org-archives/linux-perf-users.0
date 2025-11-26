Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010069.outbound.protection.outlook.com [52.101.56.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F60C188596;
	Wed, 26 Nov 2025 06:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764138741; cv=fail; b=oxBb8DqIB3EngwDQZ1T4uLeGORsKzGZFdJI3IJsGdlzYat0IGoR58NmNB66QKc8bmz7SLB1zgzGYS5DtcMsumpLX6Poal2WavRzTXvTOG+W5g6w7zs7E1GvMErBIixZ8DF0zvwULTxxu0vJkcXg8ldbhlGZZuDAFIRp/joj4q2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764138741; c=relaxed/simple;
	bh=GJ9BGcYCnxHgIUJ1I078LiPjgRkAJ3J6Qj3F84nEMe4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ThQgmW9fUPvTplIBrvxE3l3288TZIJWlG0qaFEA2XcSKnfr3EtCGAsgpgiUNrPjRKj3N9TLJeH6hVArCjcM1K7WrTPGnVU2N5k4JIU27hXvtwfYVR92z8VNutqdnudRNqWURyLbikRCSCpktOUzjchbNeHYYzCQZrXnF9FeweDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DjRASXDV; arc=fail smtp.client-ip=52.101.56.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DjRASXDV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtKcG6qpLBKBncHmJgdXR+kTHW/N0rvWJu9Nwtylix2SUio9vRdF88kktNAx1CeJMvBYPtl2q4ylpmXAny4BNb0WAxYcDQSrBbx9FKe9V87Q5HmGRDqbOk1bSqxNiCwS9MbmeSyd8yN1Fcr2Hqr/CMLzhjmkkc6BmzVyWkMLjtdt/pMOX5WUnmTNIvK352xWmeAFWgP3QzQzAW+JL3/1DVG7wUN4Qn89U7n4gvEhG6lqtWaxujEUdvz6tU05A/0PfHthr3uLynnaikfd4BVnEA8fc5VH3KzRxTPlLlsW/GN3AUP6jDDJqyXNIL3i+H27P+QkCfZSx/WT80rOjlnQWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOXvaba2HFP2Uqg5zMjveSPlaQbKeKdfpZCUA3T04WA=;
 b=E0sTJNzv9XqNzz+wLwXezVYzXnkZIfg4tnvU50zAbhd8WzbRn6krUCxHqAiTQATq+y34XcJK9ILgeF5Fp4Kv1Lu/gTg7V0DMx7Pof1o3paGBpWAr7wXIg3/33Cgsg7Kss8XV++f94JVVhrSRWwzjRAyXAucJWhNBfLgG8BOHyJYVLd8fvTALG04xnMMwj+zQpRd61x8cKiKlLMV1FpGBNVBsatAxlG+ra8n+ic+RDxRc5VYm/lcHS/swHxX860+znggu0oQHTbcAUvff6NVFNVQil3sRHhk+bnBiG5IzUxMAQ/yQGh/vrIdxgWIeRii8H7X2lMWr4ROoYuK8vqNCkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOXvaba2HFP2Uqg5zMjveSPlaQbKeKdfpZCUA3T04WA=;
 b=DjRASXDVu7CXWNK5IYuwaFwXrin43dPfBt53qMfOEtuW6M+YS04JoDdiXpYqKGs0P39vLhCriaYgtA3LrDboFBGVZlB5dcVmaMV+N2QFECB2hVGyoC2w2UuKR5qFS3lZS/dObWgFQga0koPQIUOY/c24wVEIQ0Chm/oGrNXCDaU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 06:32:13 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 06:32:13 +0000
Message-ID: <044cf7ef-8361-4426-8aca-c2bac63c6ab7@amd.com>
Date: Wed, 26 Nov 2025 12:02:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 51/52] perf jevents: Add cycles breakdown metric for
 arm64/AMD/Intel
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
 <20251113032040.1994090-52-irogers@google.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20251113032040.1994090-52-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0104.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::12) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|PH8PR12MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: e769e66e-7263-4553-6758-08de2cb588e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDZoSjM5Rkp4SUZpZXRpTHlaVUFhQ2ZyMWFUd2VLVWtFSER2U2V1M2pVTklp?=
 =?utf-8?B?R0FrS1lVUXdNQWMzbW1UQi9tWHpCc3RUSGVScWI2T0UyUHRycUlEeDVYaHR5?=
 =?utf-8?B?L0ZKbDFxUVV0VDZ6eGNLSDJwTkJHaDByZ0NPOXFISU9LcHViVzV4VkNSa0Jh?=
 =?utf-8?B?dU9QWndSZEl5ZHdZeXZldFI3MFVQeXVUTU1zSkIvRnhmUGE3R2E3N0pWTUVR?=
 =?utf-8?B?eTFTbHpSSUcrSWFtdVBGcHNWL1hlbWJhRTEvcG9idDFnSyt3d0RMR0Urektr?=
 =?utf-8?B?K0k3TlpNOU9GWThXY29sWE55eHdLL1dYRkZLSDVyUDlyRHJFWUNhUVdrYTFl?=
 =?utf-8?B?aXE0YWt1Vk9SUndXVGtSRGhoWjV6TWVtSFBZZEZPTzB5aFRwS0FpeEU4KzVF?=
 =?utf-8?B?NWFvUHNoK0pBbmRETnIvcjdDaVltT3NsS3gwQzNQa0haQlVhSDhrcGs1ejVR?=
 =?utf-8?B?cGNOZEdhY1FkVnNxWmZuQ0tOZXJDS1NlNkdZSmxSZ0RNQTFDSGpHSXU1dXZr?=
 =?utf-8?B?NUt5Mzc0OU9mWUpnd1MwaUwzQUhyVFJoQ3htWW1KV0xKcGFMVEhtZElsOW9K?=
 =?utf-8?B?N25nVVhWREdPaEN2RXVaOWpDUzFYVk9uVHp6QTRuN2JQMnVpcUE3VHhVQjlu?=
 =?utf-8?B?Rk9WOTNhTVFjblpzTURCOWgzSzdVOUN1TldXVFh3OGZUZ1V3ZHR1YWNKQ2cz?=
 =?utf-8?B?UjdwcHcvckdEUWJnSEhCSFl5TmxkUFF5N2srTU01dU16NDkxTEMxMDJ5c3ZJ?=
 =?utf-8?B?Vk1RS0xvL2xmRyt2bjNiN3JFKzRPSyt0dFJmdThHQ3pMankzeDFDQS9aZXlC?=
 =?utf-8?B?M3puNzBTK0lOTVV0b2F4NlFXVWZlekRrYWhXeVJCSHpEeXZjemc4TWhQeUhB?=
 =?utf-8?B?K3RPRThnVCtVNndSOHVVSDFRY29VbjIzK256YVc1d2VFT2VSbUJSWGpLSnJN?=
 =?utf-8?B?aXROSEN5d01mUG1Lak9KT294TTBvV252RnZ2QVYvdVFLNnBqNlNHUnR0ZC9T?=
 =?utf-8?B?b0JnWkp2cDdQUGIxVmh0VlRxdDJVWjIvaTMvR1hlMy9oSlFQWGtpcmlhWjQ3?=
 =?utf-8?B?NDMxcDlSMXd3NlRWOS9neFFLbE9RWVZpYnBSYTJMaXJxUzRWOVk1ZnZoUzJS?=
 =?utf-8?B?UFREREJreDlTSDFaUVdMaC9PQ050UzM0WkZydTJiOUdldXlZRlA3ZVBMVnZp?=
 =?utf-8?B?eHhudlYwL2hGMGoyRmtxK2hacTR2RTJzamtUY2sxRVIvZDBVNFRnWm5DVDhO?=
 =?utf-8?B?QXc4TkdubUNCdHdtNmdVcVYySml5bU9RLzlrVXlmZDhHSnA1MVZxTVBFNXor?=
 =?utf-8?B?eDJwRnJGNElSbldQaXZtY0p3MEV4M3R1K3BUenB5WFJwN3ZrWStYL1BDbXpZ?=
 =?utf-8?B?MTM4SjF1SmVRei80QkgzVEkrZ2JVM2h4NVA2TFFGTWdFZkdCRmEwUXlSU00y?=
 =?utf-8?B?cGVJckNyMXRmVWtZRU5EalVGclN0T0grY1pxcDFxL3pZQXplWW1FaUJJRDNV?=
 =?utf-8?B?c0JSZDBHSXcvK1V4dCtkZXhxODlFRy9Sek1FSHU2YXZDZEdyb3cvY0djVlRh?=
 =?utf-8?B?RVlqdlh5NzBlQjZZaFUzZjFCQk5NYzNEYjY4bGgrT1RpT0ZaQmxDb0FYL1NT?=
 =?utf-8?B?VElkdG9jcVQ1dERaVVVOem00NjRhRzE5eWszS3dSdHdjY0kvQ295MkV0ZnhW?=
 =?utf-8?B?OGhGekdWNE9YZDBBejBnaHlKc0xEalR1MldycnV0QTJGMHRSMDNXNGdlT1hD?=
 =?utf-8?B?bHFVMzY1L3NINnZzUEZDUHVwZzBMcS9DQ09FMGxjNGRkaHJYTERaaU5uRlNa?=
 =?utf-8?B?T0svQzRCMDVORUMxUXAzamw0SXZzeXN6U1BEVlRvd2xSVXU3WlBBZGlPUkd2?=
 =?utf-8?B?aHNaVmYwM3lLRmNPZUQxNTlSVGhEbnhnRXRsQjNvUXJQN3N3eVVsRzhISTNP?=
 =?utf-8?B?anlpOUg2VlVqMU5QUnJ0b2U3N0ZTODVaVTMySmM5UDkvdXcrNkdGdjZZS0hj?=
 =?utf-8?Q?qeQP8PkIl+xv4F0oMdtigqIYvabh48=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1FPREF2ZEpGNndmRVdxaTJrL1MvNVJ5Uzd3Nkl0dGRSdlcwZUlZUDRxUWVH?=
 =?utf-8?B?amZGVmY0WC93ZlhMbjJiZGQvV2w4OVA5cXpwUWFzUyt1UjBma0xoMVJlMy9Q?=
 =?utf-8?B?T2RLNHUvckZVWWtKckx0L2NtWkw5Q2hJRlRQS3Vmam85NnU4R3pjbTFlS3h4?=
 =?utf-8?B?M09TSHBPUFlQamJnc0h4TDcrWGZ3SUwxRDNibkpLN3VaZ0lKcnIzNGZnWEM5?=
 =?utf-8?B?MXBEeGlwMmlOS2pZcWN2WGF3WG9XUjNCcUZ5YkNKN2pSVlRCa3VTRTJ5N1E2?=
 =?utf-8?B?cVpTZHlOK29OOWlocXllUXBTRENxRzRvNkhsd0hpNmsyajdWOG4vMENSMlZD?=
 =?utf-8?B?SDJrNTBqYVc3RmNFMVBraHZpcjQxdHBWYnFDT25IYmExQUowbVV4dEwwdms4?=
 =?utf-8?B?VktDUXNxSHIzM3EzY1EvRWRydTNsdjNsZWRlbGtZOXI0STR3a3hGcE5ON2Y5?=
 =?utf-8?B?Skk3emdrSjRObVllM0NkOG10Zjk0bDJXWnprQVE1ZmxDQUUreFVCd2ROQ21T?=
 =?utf-8?B?Q1VIK3daeFBBSk9ybjFhYlZkOUpnT3NMQU52a1VRQlMzb2QxMFdMVHdwb3Y5?=
 =?utf-8?B?K3BhcllVc2JFbVFmS2t5VVVnUHh5UXprOXV5aGZUSnByakRDMjBMaXZoSThS?=
 =?utf-8?B?OUw1S2dyNnhzV041S3pjekQ0WndKdmxzMmE5RkJVcDdGQjJwMzFIaWhLeUtl?=
 =?utf-8?B?WW9COGhDNnNxUEN3Y0UyVzNjZmdlQzNnZzZTS20xVStCZUo4MW9zd25BcFFX?=
 =?utf-8?B?R3FwbERGNWpzZ1kzY1VkU1Q3K1NQZE9kVmNMRE9LZUxralRKbGNQZHVjZ0Vl?=
 =?utf-8?B?QjZyRHJNVWdRSmVQVERPcmtGTVpmRHczalRYck0xVDRKUzIwcmRBb2NuR1hI?=
 =?utf-8?B?bEtUYXNyUk1sS0JNallacnlwNkh6anZhcElseGlJTUxiMGc2SjJ0eDl4QXVz?=
 =?utf-8?B?OUliSjFObldIa1Q3ZVJreXdldzhSczB1YUUyNkN2U0JiL0Y4NnB5OHphb1pk?=
 =?utf-8?B?U2lTUy9lL1NZN1Y5aW90MWU5dkZPV01ybXhuYXNONTlORXlMR1lUbEJOb2JF?=
 =?utf-8?B?RzRvL3ZRZkliNFRJcEdzbkRhaTZNSjJzOEVlY1puRi9US2FJTGdOcVVWZ0lM?=
 =?utf-8?B?RnZmaHhOZTBWenVEbllDaXUwRFhYc0ZTWGFxRnM4TC9lR2pLN2lPVnl4YSts?=
 =?utf-8?B?YnF6VVpMYlgrQ1dFZXR0RHk0OTh0R01lWnpzK2hjYllTTHBwRk8zaGs2Yk1F?=
 =?utf-8?B?SXV5cmp0c0l4dWwyYnR1UjdDdlFrL3JLdWhaSm5OZjlMYmFqQWVZNlJrVnU3?=
 =?utf-8?B?RFZlbGd1Q3pBS2ZPZGkwc3ZPbElkVldFSGVnRTNuaTc2eFZmdnNiaGJRWW5Q?=
 =?utf-8?B?Z0FLay9hdUJhMGV5cHlubDVlVXJRUmgySUtpazZ1cW02Z2E2V09Xc3lYVlJj?=
 =?utf-8?B?czJUT1NnbWJaMnlRRnBMNDlBQmZLQlpzK2Z4c09sM2lLNU1BSEczM3BkV1Nj?=
 =?utf-8?B?SGduVTFyYitRYkZmNXJwaFpnQmQ5WThwZXhEQ2R1ZTNZVDVHWEZZSmY3TGMr?=
 =?utf-8?B?bHg5R3g5ZGFWMTRoMTk5bVBFK1Rva2xCd1J5ckJoYVdNbmx2VEg3aGZnNDg3?=
 =?utf-8?B?d3YvaVBldmFkaUtXM3hsQWVqZml4UWY5cWhUQUs0YnZhNnNST25EMjdqbit5?=
 =?utf-8?B?cW80Vm9oMElpS2dCOFd0WTdSQ1F6cm1zRXFJaWV3Qk5lYThqV0xKSGhkMXpm?=
 =?utf-8?B?Q09GeVE5OWFLbjh5V3p2Uit4T3lwOEE1VGxsRVhuVkU0Z21tVDd6TjhvMzBR?=
 =?utf-8?B?eE1CdDBhZENuOWVkSEtUMHFxMDZ6ckYwK0xxYW95aGJ2Q1NxczdROTl2TDI4?=
 =?utf-8?B?NVAyZWh2Y2dtbFlJR1psckV5NW9XcDJETEp6RkpBdjIvODd2aGtLYzlKUEpt?=
 =?utf-8?B?c3p3eUlqQlVyVy80TDN4ZFR6OHh6cm1wZWJjYW1JenBnK3pETWtiZGx0Y2Yw?=
 =?utf-8?B?YkxpNERPSXptUHdVU3I5a3l6Y2pVNnpnY1VWRnJhbDE4SnNLdG14eDhla2Vs?=
 =?utf-8?B?Z2JzM2llTzROdmlBR09ZNDVqTHlmWTdBODR1c0JBVG1KbHVvbm16TjYwaFJN?=
 =?utf-8?Q?hzpp8uI3+XRQ6InhyIVrQ/93i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e769e66e-7263-4553-6758-08de2cb588e6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 06:32:13.5265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvhkTORrykp9pCskISiY4onxiGsVFyw2ik0X5wgK90rNJxdbHRdNLZo5J1Aj7UYkTcQ5/6fh8pkbDq2mtxirWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208

On 11/13/2025 8:50 AM, Ian Rogers wrote:
> Breakdown cycles to user, kernel and guest. Add a common_metrics.py
> file for such metrics.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/Build             |  2 +-
>  tools/perf/pmu-events/amd_metrics.py    |  2 ++
>  tools/perf/pmu-events/arm64_metrics.py  |  2 ++
>  tools/perf/pmu-events/common_metrics.py | 19 +++++++++++++++++++
>  tools/perf/pmu-events/intel_metrics.py  |  2 ++
>  5 files changed, 26 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/pmu-events/common_metrics.py
> 
> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> index f7d67d03d055..a3d7a04f0abf 100644
> --- a/tools/perf/pmu-events/Build
> +++ b/tools/perf/pmu-events/Build
> @@ -44,7 +44,7 @@ $(LEGACY_CACHE_JSON): $(LEGACY_CACHE_PY)
>  	$(call rule_mkdir)
>  	$(Q)$(call echo-cmd,gen)$(PYTHON) $(LEGACY_CACHE_PY) > $@
>  
> -GEN_METRIC_DEPS := pmu-events/metric.py
> +GEN_METRIC_DEPS := pmu-events/metric.py pmu-events/common_metrics.py
>  
>  # Generate AMD Json
>  ZENS = $(shell ls -d pmu-events/arch/x86/amdzen*)
> diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
> index b2e3e2883022..5bc53fcf6448 100755
> --- a/tools/perf/pmu-events/amd_metrics.py
> +++ b/tools/perf/pmu-events/amd_metrics.py
> @@ -4,6 +4,7 @@ import argparse
>  import math
>  import os
>  from typing import Optional
> +from common_metrics import Cycles
>  from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
>                      JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
>                      Metric, MetricGroup, Select)
> @@ -694,6 +695,7 @@ def main() -> None:
>          AmdSwpf(),
>          AmdUopCache(),
>          AmdUpc(),
> +        Cycles(),
>          Idle(),
>          Rapl(),
>          UncoreL3(),
> diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-events/arm64_metrics.py
> index 9678253e2e0e..ac518e7f1120 100755
> --- a/tools/perf/pmu-events/arm64_metrics.py
> +++ b/tools/perf/pmu-events/arm64_metrics.py
> @@ -3,6 +3,7 @@
>  import argparse
>  import os
>  from typing import Optional
> +from common_metrics import Cycles
>  from metric import (d_ratio, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
>                      LoadEvents, Metric, MetricGroup)
>  
> @@ -173,6 +174,7 @@ def main() -> None:
>  
>      all_metrics = MetricGroup("", [
>          Arm64Topdown(),
> +        Cycles(),
>      ])
>  
>      if _args.metricgroups:
> diff --git a/tools/perf/pmu-events/common_metrics.py b/tools/perf/pmu-events/common_metrics.py
> new file mode 100644
> index 000000000000..fcdfb9d3e648
> --- /dev/null
> +++ b/tools/perf/pmu-events/common_metrics.py
> @@ -0,0 +1,19 @@
> +# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +from metric import (d_ratio, Event, Metric, MetricGroup)
> +
> +
> +def Cycles() -> MetricGroup:
> +    cyc_k = Event("cpu\\-cycles:kHh")  # exclude user and guest
> +    cyc_g = Event("cpu\\-cycles:G")   # exclude host
> +    cyc_u = Event("cpu\\-cycles:uH")  # exclude kernel, hypervisor and guest
> +    cyc = cyc_k + cyc_g + cyc_u
> +
> +    return MetricGroup("lpm_cycles", [
> +        Metric("lpm_cycles_total", "Total number of cycles", cyc, "cycles"),
> +        Metric("lpm_cycles_user", "User cycles as a percentage of all cycles",
> +               d_ratio(cyc_u, cyc), "100%"),
> +        Metric("lpm_cycles_kernel", "Kernel cycles as a percentage of all cycles",
> +               d_ratio(cyc_k, cyc), "100%"),
> +        Metric("lpm_cycles_guest", "Hypervisor guest cycles as a percentage of all cycles",
> +               d_ratio(cyc_g, cyc), "100%"),
> +    ], description="cycles breakdown per privilege level (users, kernel, guest)")
> diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
> index d56bab7337df..52035433b505 100755
> --- a/tools/perf/pmu-events/intel_metrics.py
> +++ b/tools/perf/pmu-events/intel_metrics.py
> @@ -6,6 +6,7 @@ import math
>  import os
>  import re
>  from typing import Optional
> +from common_metrics import Cycles
>  from metric import (d_ratio, has_event, max, source_count, CheckPmu, Event,
>                      JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
>                      Literal, LoadEvents, Metric, MetricConstraint, MetricGroup,
> @@ -1095,6 +1096,7 @@ def main() -> None:
>      LoadEvents(directory)
>  
>      all_metrics = MetricGroup("", [
> +        Cycles(),
>          Idle(),
>          Rapl(),
>          Smi(),

Reviewed-by: Sandipan Das <sandipan.das@amd.com>

