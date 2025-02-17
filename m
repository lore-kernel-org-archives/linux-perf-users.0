Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E406101EE;
	Mon, 17 Feb 2025 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739781029; cv=fail; b=hqKbj6vfh3cWj5jdOW2DohJxEvRCUM7B3vAF7Loh9jhywC/xdRdsNipaHFwjs3JOgvGyY7iD+YPQMtG3RCtEAT3RhC28/nW6Ye8o9wQWCS1f/3J4/3dBuNpwLwi0E3hIpRNIFqTJchOiMZpABqb1dFV+rdy0KhvjHj/2YCX0UiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739781029; c=relaxed/simple;
	bh=2V79c+yot0bSdY6N3t4zZdKSwrd9KZss1ERAzzNKlNA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cbepQ5hMZ0Ni4LwaRURiAnp86t33DvTExsgI9P9CehfxNptZrGvHTL6OuE+5Aa7dsFzU/XGRWTyK3hQYSxXT2saewxGMDYoaMsVloBRBJPKC4IfhYZIZ1VNtr0l3xiP+entIabq91HMS+rz6xgapGb2kRhODPAl6wZwtNjXsPd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A0WPuDmv; arc=fail smtp.client-ip=40.107.95.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A0WPuDmv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fRiye0GcDAodCopOmBQN/0dafaJEJTgRecEM1ec/vb5pEAhsz+4wTJRG6kvxuFz4mA3IRTbTVuBL1TeiWVjVcpKSQrHsbdtUb7tUoOEOxik1BH1SBVmvY9Yh3rKw+37IQf2t1XzJP+Qu/QBzDnGce7Mmi00OSHxfqxbgsRbv3Cc9UlBM/uRUTKnjLODtPiborblb1JXV+l94NdIlMJDodc8w2a3h5USMuHHBJ4AvtsaqSew+4aoaf7uRkklutQO4jA1arDevdvSUAn2eYkEXmT5ZrBQW2Tz+kUmLfdSjsZCiADXRMjfEdT96J2VjpeHemjhrAQY9pgSsFBCHBL8IZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvSTL+owNjzoQdQxqx5B+IAvThH+ybiXLgtMT7HIhx0=;
 b=SPxpILopoJ0rlHfKMhlYRZRq9mSbhGCTiQpGvqA3HqRIEgm8zAhwCenCfEm93g543SPZFy/8VoQQLiVEp6juOeoj0EENCil92n2ebj+uhLVPOI6FR0lKHRfysk+c4Mfjnj1Ul9rsG9ct3cqnxLdxv6N4rgvcbISl3bcqvUmzVP66SGCUqQTQoZZ07hCFTIWmQQq5u/f9TwjiXGtIkhWUf6i3scW4Yf+26F4wg8fnbfRvUtQDyn3qL+ff9oNzgioR9X7PFdaeIokItPYfzGlioo5NdlSNi+puBO4ipsI8VlCQt5kGgllhaE28Sr1FqwFjvrjkQo3BfghY3bkTEsM44g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvSTL+owNjzoQdQxqx5B+IAvThH+ybiXLgtMT7HIhx0=;
 b=A0WPuDmvMjQ9UU4x70xs+JXacJqxWcOgb70s7gQR0tMEbRBraCscDeehiRTyxyUhUL8/99a4aO5yCP9AkS3HtlixUk/giVEvhiYMBlaxgf3vgqIJf1rpvJ6zmnwLJAcP4OuOTz1lGHlHrgp3qe+6GxjA79ld36WhsjOpu8BrS+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 08:30:24 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 08:30:24 +0000
Message-ID: <65818316-434e-4468-9ead-2e55c15b62eb@amd.com>
Date: Mon, 17 Feb 2025 14:00:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v3 0/7] perf/amd/ibs: Add Zen5 support
To: mingo@redhat.com, peterz@infradead.org
Cc: acme@kernel.org, namhyung@kernel.org, eranian@google.com,
 irogers@google.com, jolsa@kernel.org, bp@alien8.de, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 santosh.shukla@amd.com, ananth.narayan@amd.com, sandipan.das@amd.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250205060547.1337-1-ravi.bangoria@amd.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20250205060547.1337-1-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::13) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DM6PR12MB4236:EE_
X-MS-Office365-Filtering-Correlation-Id: d345fc6a-cd70-4b85-1c70-08dd4f2d5302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTJ1M2R5aUlRSUphVmF3K01yQTlxSWV2dVlHS1pNR2RHa3dHd3VjQVJEbWR4?=
 =?utf-8?B?N1BiT1RtdlBpUnN1c09Uc2tab04venVhN3RVT3FlRVlZZnJCR2ovWUYzVGN5?=
 =?utf-8?B?ekxYSzNhSHFvbUU2YkJ2Y1J1S0ZmUDZDRkpOeDhLSE9Ea3BLSzlOZnlKNFlW?=
 =?utf-8?B?UVRoSm5nbXF4dkhkekIyWjFINjAzK3RzWGEwZkd0eEpzSnVFMTY5KzN1R2VE?=
 =?utf-8?B?U01xTXdzQTBGZFU5Y3AxVGs4QUlnSDkvcWlxc0g0bmFyY2kyMlE2MWx1QkMv?=
 =?utf-8?B?bEovaHFtcEpSL2FpT2diKzJjdDFsWEI2aWNBeXg2MHJ2UzI4a3V6OTJvZ2tF?=
 =?utf-8?B?T25VUEs0UXpicVNzVjdpTllPTGtsaEdXT1dDMTFBZFVvMmV4anpkRUkzZFBv?=
 =?utf-8?B?bm5OR1d3b1JCQm1Qd1FWM3N5cVFZRGFIelpWWFVFUFBpc3pPbDNTYmtpOHZV?=
 =?utf-8?B?MCtoSFBoZURGcnM4T0h1MGx1WWxzWWpHNllVL2Y3dlEwV1ZSSzg2K292cHRE?=
 =?utf-8?B?elIrdTlVaVB6c1BMQTBhQUcvejRydUF1NzRPWWZRNTJoTkJ4OXByc1J1OFhj?=
 =?utf-8?B?Y29nNVFOZUhJdVBmdWRYYzZGb1RqUjVNYlljTzUxU2lKQWU1bjUzS2xxdWlP?=
 =?utf-8?B?cHRvN0haZE15VUpSbnB5cHYycUhIcTNmSThFZHNRWUIyR0RWVG9GUENacktu?=
 =?utf-8?B?WGhlcmNjVUV5NUMvMkV1VjNHdXlzT2twbFNtaEo3TDZOUEFvVWxqaDA0YkNk?=
 =?utf-8?B?Y2doTWk2bFlVcVNQNmNoMnpXeGsrSlYxSnA3QktaNkJjbmZQOXVjSWdPWlJB?=
 =?utf-8?B?QUVQY0Z4MTJTWVhDcXh0NUtGWW9maFhnVkorSlhPRHlxZGg1NEpocXROVEhU?=
 =?utf-8?B?NkwyWktCSVFxU1RSZzA3dTJ3cTJOSTNDeHNHalc3VDY2T0hsbTFnZzZBdkVR?=
 =?utf-8?B?dFFBL2RZdGJTZEFMa0U5c3JNQmx1TGNEdkJGNmc1MW9QYVpidndna1c3TERH?=
 =?utf-8?B?NzJmMHljbzFZNksxWENuVHpKVExLanlUcGpCakhIL2ptVkwyVG0yMm9xSkRE?=
 =?utf-8?B?dnloY3ZTbE90ZVlVV05kSEZvOVRsTDV3VzRJdkkzdVd2S1dTUmVPdnpqZDRk?=
 =?utf-8?B?K2U5dCtMVUJEN0xSR0pwajh6ZU14c2lkZGI2RUorTnRLQnRaNml0R1Q2TGth?=
 =?utf-8?B?T2NPUW5ZRU04TWk4WDNzRDVtMXk2UHcrcmZkcmFPam5vN2FJWlcvcWdoT0d4?=
 =?utf-8?B?a0lPWmFJczBWU3lRUmwvT1JscjA2UkFEbU5WNzdoVWYxRXlYQ3FVaUZoVjhn?=
 =?utf-8?B?YW5ER0tVMDF5b1dzT3ZNTUZNWUpMZEFpalNCcXpOem4xVHlrdXZwQ1MrOUh6?=
 =?utf-8?B?MW0yMExFamc5RTRkczU3Y01tNC90Ni85aWhDNkF6MkNHaG5GaXcxYnJENlFR?=
 =?utf-8?B?OUxzYkwrcXBRQ2d4cTNDSEUySXJCYzVDQkpiU1l5ZUVDYkk3dXRmZkh2UHoy?=
 =?utf-8?B?OVBhbDZ2RldMR0sxZVo4QkkzVWdoQ3pDU0J0RGhVTlg1aVdkQ1JrVnVMRjFv?=
 =?utf-8?B?Y0I1RTRTbmQxQTliWW9pYmp6MjExZzk1bkhWNXo3RTBHMWU2SmhLUG5mdkdK?=
 =?utf-8?B?MkliaHkzdTFaR2ltUk1NcUQ3UjJVbCtQYWtJYWNBeCtVTlM2RDhWcWh6VVk3?=
 =?utf-8?B?RkZrMFdkaUpwUFhPUVNpQk1NdkZpb2t1V1FGZjVzZHpsUU1FTHpPU3RBSDAv?=
 =?utf-8?B?WUszc0VUNVQ2NTJ3SXJMOFBvM21JZWhiOEYzRll2dER1eGlpdnROeFNPV0pS?=
 =?utf-8?B?SlV3dDdRVEcyUE5IUW9CdDNYYW9GZGIyZXNqTGZRb2xtVURqRXQwUU9TY1Ir?=
 =?utf-8?Q?tvmUy5d6OisJU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFVaelBYei84TDl3VFVxZnllcFBCZUJBRjJKNncza0tWQ3FoK1piUDJYaEo4?=
 =?utf-8?B?b0hzOTlZNjZzUlpxVzl6S1BVQjBMd0tRbC9Zayt5WFNIN21HQW9NOHg4bHJF?=
 =?utf-8?B?YUF2WUtnb3lITjVOSDdNWncyVHZ6NGNiTDc0UFFtZmQ5L1VZSmkvVnlOT3V6?=
 =?utf-8?B?b2FPRUhnajNBMTZOTE1sVjBTdnZjb3hmcDBJQkV2d2piYnpOOEV3SmJHazB1?=
 =?utf-8?B?V0wvcWE1d3YxOWNlRXVUTkdtTmxlZUlDYisvNFoyR2xiSlFid3J0V3kwUjlm?=
 =?utf-8?B?OENWWXBHcUpya0VXMjBLaVZ6NXZNWWZkUmdhMTRycVBJUDdBdnlCZlYrWkNn?=
 =?utf-8?B?ZHpGTzdDVkpQWHJDakZSeE9LWWZUZWs5QzlDL3h1S0lmWCtHdzQ2emRxaENt?=
 =?utf-8?B?ZVFDa2hwdGo5WmJzSENtVGhMWDdvQUVoRnVvdFpJN2ZvRDdlbXZ2SG9sbVk0?=
 =?utf-8?B?c24yZjJabTdHaEIzSkhscWwwR3pma2dUeW92c3ZPdmFabDRiMFJRVjZHYWZp?=
 =?utf-8?B?ZE40YTVuOXN5aURtWmxPQmJvVW5hZ1dFU3JCMUJxbjlkM0lCQ1grOVpySTRP?=
 =?utf-8?B?MkdNM09KdjR1eTRlU1NSRDlkaFhYaXhIajNrRXd4amdpaEVscDNmV3plU3NR?=
 =?utf-8?B?YW5peXNhLy9BaU02UndtNmJHYS9GQk43cTY1emhpUmRpcUhpMnhzTmplUDQ5?=
 =?utf-8?B?UHA3Qm55UlZEb09pQ0pHdng3ZEhLSjJCUTZHUlgzNnY2aHFvSWhOcXBiTndq?=
 =?utf-8?B?b2ZzWWpxSkQxd3IrNDY0aUQxeVUxSWdWK0Jya1dMQ1RUTGFFTUwrVHdHTHE0?=
 =?utf-8?B?LzJRODJwZkJLVGNSRkoxdFBNNmhRa3ZpNFF1c0kyVC83c0tCNnZ5ODhuMkcx?=
 =?utf-8?B?V0tTYjNudVNpQW5uRU5BZW90bGVWdWZCQ0IyRVdiRjRPUjZCSWVEeG04eldF?=
 =?utf-8?B?ZjcrUHRJMEN1Ris2NTJzSFArdjh0blBGUHZUdFpURGNjQ0ExVmNIdUxBSE8r?=
 =?utf-8?B?L3FUaXBaSmRSeEg0K0R1VDhFVWtGZmdLOE1IWlh4SzZiOWJjRzZvemZkQUor?=
 =?utf-8?B?dWpIR1FWU2Z0ZitsQkdrRzhVdmFXYlVTZXdyQWdZek5MbUNPUGdFOEhpK1Fi?=
 =?utf-8?B?YjhoaGswYkJNQnRkZ0JId0JsVEJqeHFabm1iUGZDUERmSWNVR2pITzRoRjV0?=
 =?utf-8?B?TnhjeHM5c1kzNU04and0Sjc0K1A4YkdMd2ZjUWVMdmhTK2NQc2NPSmtvTmk5?=
 =?utf-8?B?bWViUDYzQ3JtQm5adEdwOTV2S1ZPQnRnUHl5cTFZejM5dkVjNEVoS0RjRE9E?=
 =?utf-8?B?TXQ0ZWo1RWhWQ1hua29OcjhhRVJZeUhhR2RwbGtMZWpINTlUVjdLd29jbFBQ?=
 =?utf-8?B?UGkwR3hFQU56RzJzL2UveVJIcmxBcFh6ejd1Z3l3bEtuOHFnQkNLQk5iVGsv?=
 =?utf-8?B?d2lvU3prOUhBVEJHSDBicmoycldnOFdIaEkrTjI2ZGY0RlJyVGhreEUrWGNS?=
 =?utf-8?B?NnpocitSSzdLckJzMGZMamZ1VUEvaWhYRzRGbUd5ZncvZ2kvRkJoTUtTVEhT?=
 =?utf-8?B?ZHh3WklndEFVb2xQMHd1eHVHQzdlYklzSE53b0t0OE5oa20vM1BUYzlkRHFD?=
 =?utf-8?B?Ym8rR21JaDF3Y1FJL2NlbUVrZ0V4V1ZZY0V0QUJyTkhMQUtLSVJNeEN4Y09a?=
 =?utf-8?B?TjNXRlNGeGpGbndodklOUCtIOXhxb1lDWFI5YWgrRGNVckZrVEVaODBTQzBL?=
 =?utf-8?B?dlJRYTZ5QS9xU3RnUzFOb0lyTzMwalMvblJ2U1JtQS9mN1BpU3AyZG9kSEEz?=
 =?utf-8?B?Wml0dmlZd3lOZS9MT0ttL2hhaGk3bW4yZ21wcFg3eWhFejdISUhLakIxcURm?=
 =?utf-8?B?VUJ2Vmx6THZuQUVTaURuNWVPSS9YdUhTd2doOFZ5ajNsa0RVQTJCYWZtYnRF?=
 =?utf-8?B?cVFPQ1BDS29ObGRuclN6OGJYWWJNeWU5UW9Ob1NzeHZjTTZxcEZDZVZiZFdY?=
 =?utf-8?B?RjBQb0VVWTVucWNYdURScThsRi95Ym10UVVRVWRmQ3lZLy9KSTFacnhuaUUy?=
 =?utf-8?B?cTE4TERpajhqbUhhTUJCWDNEMWl5a29UcXZoVXpJYlVzL3IrOFlOSlFiSGNL?=
 =?utf-8?Q?BxCd8SyPRhi30J4J/TYzOC8lL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d345fc6a-cd70-4b85-1c70-08dd4f2d5302
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 08:30:24.5309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5TB0LdrLMJxK/G2QFYFxtNQqEItI7f4Ya3HotmpASQSbDG5teRiYmkZGFEceF6o0/BWWetbhyV3ssK6M8QOJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4236

On 05-Feb-25 11:35 AM, Ravi Bangoria wrote:
> IBS on Zen5:
> - introduced Load Latency filtering capability.
> - shows DTLB and page size information differently from prior generations.
> 
> Incorporate these changes into IBS kernel driver as well as perf tool.
> Also include a perf unit-test to test IBS sample period constraints.
> 
> Patches are prepared on peterz/queue/perf/core (cffa473a06d2).

Ingo, Peter, gentle ping!

Thanks,
Ravi
