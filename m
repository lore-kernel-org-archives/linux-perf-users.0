Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D3017A2F5;
	Wed, 30 Apr 2025 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746029257; cv=fail; b=T9ilwkxV0dANOB0lnmRMXiW5jfnrk9719GwS/B9+K3TSpC9sGzp5oCej9F6AiV63zHcniIcpZu44JRbsgntvMHX/hHUYVpOI0YHInWLrsdpJxDeaD5cZ5kZMlNGWltIltkpfR9QH6qiLnduKeU7en3VCPdhc20Pghw+vmkEWIyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746029257; c=relaxed/simple;
	bh=pstPltbkXG1rJIGKoKrEI+FoQ+3xHtfH6Zb9QWC4T+E=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YtH6Eg58YVQnZcIpm3VJopCP7RN6YkPsE3c/oWzeLMHO0C8lRq5Zf6vclvwrs7hHCKDGREyttNlI9MhewMz3Im9I3RYwhlkhZlWRa8I0oVeNg2kc6RutzjOhk5VC0QeowGhYh9CzEgjJfI+rzHwBvEJCSKI42n9292TcLHzCTFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qv2ckXPP; arc=fail smtp.client-ip=40.107.96.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qv2ckXPP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upUuhkZCTLt9G1TbkeWkxlKCIkDrgG0ZiaA7BgkIJ9077YJvIMg0krpaVQJ8zZKN0vNRug9+wzXst4mAswh1hQhFAVFJvGRyYbTr0pkiBIpzIBsb0Vtt1Sc/qTppaZWSxemZ55zKZuR90Kp6uLzdxrXmTf2aMhfbjkgHch11r409jronAW6WBX5EMajiMbLljwJeWdiafKncBpSZZ9mANVNfWAgU7O/76prfIGc2HKXIWncg83nanMKD2w709k9Zq/3nXfv+HYZaLRS5RYY6m1whdgdxrpulaiJlaXI/bJpROSO1f4OuJnxLMBYhFEuvbDNRqxIQamIJClcVgj0P0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hP0l8L1Jr7k4Hy8oYX8JF0/luzI8deszVrxdKVtK1ks=;
 b=uEQP3BFSBXfE8NlI1mmAjbjEokNacR0f2ltXwUdk726FpibD3glp9kAuxhq9k80vppc5jqfHX8QY6qBlN3BKk/XK5v8U5PIBFXlYbFdhQHC72Oebc/j3l+XshEfCLy/19pb2tn5MZbelPXZoXLbSDDAgBwyk6zo57F5yMkPkteNPGGhGAyHyWZI/dQJsLZom1nqoneQPHhYCsNNf8A45K26zRIAgF/pavplfEU18T5XCDwP66JtDRiaW270/yBpjYldqmoeYc+2vFHNYJla8y9c7RXbh0K6vManGTaWRSIJT4BKHwxvtw3Wm2Ec6xOVb+HMpXZ2A8sihh+HvoYs0aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hP0l8L1Jr7k4Hy8oYX8JF0/luzI8deszVrxdKVtK1ks=;
 b=qv2ckXPPPJOZJhFLtjyV9dpOR5ye3eReuTNIr3jFFsz0c1cG2Kner9AsFp5QvDsnM7Nf2XC9+6rA7Dfs1F5znWgsEq6UY4eYEJGf1ZW/M7I0zhndihWeFMm/uenPn3wzNh3lQOxkpUz1eSkLLTOqrr01kzPbkMfmh4zCVOtyikU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Wed, 30 Apr
 2025 16:07:32 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%7]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 16:07:32 +0000
Message-ID: <09f5d37b-0ef8-4cc5-bf60-172c448ff9c7@amd.com>
Date: Wed, 30 Apr 2025 21:37:22 +0530
User-Agent: Mozilla Thunderbird
From: Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH v4 4/4] perf test amd ibs: Add sample period unit test
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Joe Mario <jmario@redhat.com>,
 Stephane Eranian <eranian@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "Shukla, Santosh" <santosh.shukla@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das
 <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250429035938.1301-1-ravi.bangoria@amd.com>
 <20250429035938.1301-5-ravi.bangoria@amd.com> <aBE8raTOCVZLfw7J@x1>
 <aBF5UWrxvYgbnxde@x1> <aBF7ZarWJvzeDKqF@x1>
 <4bea7b8a-9ff5-4ae9-8154-57ec7377ee4e@amd.com> <aBIgVi90Zinz6Rl4@x1>
 <aBImI03VHeJSGVfn@x1>
Content-Language: en-US
In-Reply-To: <aBImI03VHeJSGVfn@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ae::10) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DM6PR12MB4251:EE_
X-MS-Office365-Filtering-Correlation-Id: 80855683-208f-4239-c45b-08dd88011cca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0xZN3pLUTdwS3BJN1RxRmRLb09hbWsrK2cwN1kxekptRTRTU3p1UGdKdHNh?=
 =?utf-8?B?V3VvaVJHMzUvL1EyN1NlckRvMWs3RXAyNy9rUWc1Z3VhNDFXRFNGOFRmem9M?=
 =?utf-8?B?dHUxZFZaTm9wdWl1QjZCcG5reXFCSDZ1Nk81b3ZnZGRCRGJyZFJZdm5ubjVM?=
 =?utf-8?B?Q2NMUEl0ZkFHT3ovSHNzVlBVODdjOWlWZFJEdzZ5aThuaXNaSlh4Nll1Y291?=
 =?utf-8?B?M3FMTkxpYk5adzlWTTVucEpmc3dyYmo1R0VaOTNJUCtONWVDRkMrbUlzS2lB?=
 =?utf-8?B?SGdXS1AxOHJjV2o1SlVnZTJReWdhY3U2eVVJQ1lxQTByVkpVWU05WDR6aEo0?=
 =?utf-8?B?RnV2WnR6SC8yeldMWFRvdyt0a21aWWZHR1kzWnh4QmUzZVdjZ1JNMXhJV2pE?=
 =?utf-8?B?K0d3OWZ5c2g0Rzl3MU9DVnp1Q1J3ZVV3UXRPRnRSTkU3S2JuNndwSmF1emFX?=
 =?utf-8?B?VDFlSm9LSXlEdU1zWFVJVXhLLytpQnNCbmxwQ2pNZlJBWGxMbitJVnRmTVZZ?=
 =?utf-8?B?aUhiQlY1MDNmcFJjZTRKQk9XQ1dlQmZPSzFhcEJEVnZONTZWRFU1QWpaV25I?=
 =?utf-8?B?eExmK25GWUlXYWRPT1BOZzJHMHJGcWQ2SFpUR1YvaURQVDlwRU1MZjB3eEZr?=
 =?utf-8?B?cll0YUwrSHh3OXVvbzIxNVQ1bVZwZWIzQlpUNUE0WDduWG8yRUtuT2VjU1Q3?=
 =?utf-8?B?VEhIWlpJbFc2NWx5ZU9sNmNjK3Q2T0lhMUp2dDFocFlyYVE2WG04c2tRSllw?=
 =?utf-8?B?UXgvVFJ5RUtwWHlRaGdJQW12SEN3NkVZcmZPVkpFYk83S3ltRENvMjlJbDR5?=
 =?utf-8?B?Yk1uL1BQUkxkanQzSlJmNWJSY2hab3hEcHpWa0F3bjFkeDlDdnJ0UVYxWXZy?=
 =?utf-8?B?SzE2RTBHVUtOcnhjcFJvc0xGaUh3U1ZtYmppM1FnS2NmbElOUDNIRGpicXQ0?=
 =?utf-8?B?Z1REK2JMaDV5OXhYcVRFcy9malVCUEpENzFOSGxINjdEOVk4RFVWck14YUdm?=
 =?utf-8?B?azBTY1VpNlhBQ2FDTUZsUGRYWS92Y1dmZVBDL1RhNnZOQkhNMy9VTFV5d3lY?=
 =?utf-8?B?Yy9NUFVKb25sa1J4VnArekpEZnIwM3RpdFhKTnQrOFJBcUdzczBJMndzWkFR?=
 =?utf-8?B?a2FsTTE2N1JZQjJ4Z3U3Mldia0oyY0NDa0grNXc2NGlaaDJicHJkS3luT3pZ?=
 =?utf-8?B?Mnl6eDNUWVExU3J5VFhwNlNWWVBicFRnZWpzcFZlVGJVSmozRDJDQUYzNjhi?=
 =?utf-8?B?U0dJODh0RU9NTFhwSzQza05iVTBQZGlWbjdrSXNrQXg3NzFvRlJ0bkNMZTZn?=
 =?utf-8?B?VkN5UWx2V1N0NjhoMlVPVXRBNFZFWkJTdDVDUWNzazJkMkNoN3Y1M0huOStj?=
 =?utf-8?B?UDJCVE84Q0ZhSG16K2hjL2M1QjRWY2JoaWFCdHhMN1ZuUS8xNXZSL0pWN1BD?=
 =?utf-8?B?czdKYlJXQVlHaHZNSDI4U3ZJWHl5TmxFYlN2ODBsK0crZzhWU0tvN0dKeWxi?=
 =?utf-8?B?V1JrYXRxeG53RktrRXMvTklMeS9OV00wTkJSQ3ovVzdnZWFudjlncjJaY0J4?=
 =?utf-8?B?RlZDcGZ1aGZYT0owN1VoaHJGcGtqOXNLMDBuMEkxRlppTGNhTjZNem80d041?=
 =?utf-8?B?bFJiSFh6cjM2alM5Rk5kcjRQdHpYRy93aEJSWlRrT0tmSWM1b2Y1Rk9naXlT?=
 =?utf-8?B?VGF4R3BRbmt3Y29LaTlUMWNhcnJjNlJqZWtXZmJ3ZmtPZG0xNGhycm81bm5U?=
 =?utf-8?B?RWZWdUVkRHFLb1pqaXF3UnVhSUlLTlB2UlAxNVJEWEFrd2VHRVgwVndUcnhW?=
 =?utf-8?B?c0lYUFlaOHhTR0VCVGJDZm8yR2I0dlJRd04xL1U4emxyN25wU1pLVVdMaU9z?=
 =?utf-8?B?VTdIcHE5UjJRcTFSZjZvSlhZSW51RGxxTTBkYjFobEwydDd5L01hME1hWlI4?=
 =?utf-8?Q?qr/TQ8IFaK0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXc1blkvbjRPeWR0Z2ZGY2R2Z0hhQXgyTFBiUmowYWJqYkgwQ0pRY1UxczRu?=
 =?utf-8?B?WVZDQVpOVGpoemdoWkNCU3hsME9GTThLSkIvTlJKMWpHOHlpbzdXR2NLdEF5?=
 =?utf-8?B?azR5a3lJcC9qVGNkeWNTbG1SbGJLMVVsSHppMXRTS3BFdXpTWURvSXBXQUxP?=
 =?utf-8?B?RGk5UFVnSHAxSXdsRDBFRCtiWkh5dis0WDZCbnJkQmNMZ2E3Y3pNelVBcTVy?=
 =?utf-8?B?bzBmSTFLV1NySzAyamJHcDRZRitHM3lEa0hQaDNoYjh3dzNqQjNmMGFoNWpl?=
 =?utf-8?B?M0NRN2RLUGl0YUkvSko0eHRVYURtVnZCenBzWUM0cURSM3lmRzh1UU10QVpS?=
 =?utf-8?B?aUdrdk5ldWIxUDlsUGhOa3RQS2k0M2JHOWIzcndvV1dHRVpKT3FZSk5BL2Qz?=
 =?utf-8?B?SDMzb0xnd2VBdjFiMVFpV2d3ek93UVp3MDIwMk9laHVoRW1iWjd2T0RhQTNX?=
 =?utf-8?B?QmpYL2lHV3NMWFFLM3kvZUg2aTBoS3V6aENzUTZseWljUHR2NDdxbGY4VjBM?=
 =?utf-8?B?WnphbElRZzZtWkhTd3lLd041K2xDcmo5SXpNSjR4WW9jV3JoZDVQeEZ5U3Nl?=
 =?utf-8?B?Q29VR2YyOHBxaUdIMzZxaEVKUE90R09LdGl1NjNIbFhxRW0zTUViOUYvK1Bt?=
 =?utf-8?B?aUFmZzU0d1RZZGJCWUptcERNMlZxMFdYMjNUYTJSZ1JRQmFITkhubjFEY3Ja?=
 =?utf-8?B?NHk2ZWh3clFveDZodGplb2dCQzhkMWkrTmVsUEtnY0hpb1Y4SW9wS2Y3czlz?=
 =?utf-8?B?UDgxVjN5dW54YndOY3dhOFZMUVZIQjBLWFE5aWxoSzcvOGJEMm96N1FOeXAy?=
 =?utf-8?B?c2w5VGpWeUo1TVpDRUVVZ2FKaGlQN3BrUTh2R29vcGNRSjI4bjhYanhvM0FM?=
 =?utf-8?B?RzlBVXBPQWRIZWZjbEpNSE5CcWNwVGEvRXl4cTZUeUJlSVlMN3pqc1VKT3pV?=
 =?utf-8?B?MTZqdS9oZWNVaktqNXFQb1FWTnErVDJhMVhnS2NXVEQ2dWFQcFJQWXUvRFNa?=
 =?utf-8?B?QXBpT2c1UmZVY3Yydk9CZm1NV3U5dnZmOWswd0VZVC9rRXV4WWFrU1d6LytJ?=
 =?utf-8?B?Y25lcUJ3a1BhODR0Nm5oQkdYZlgvZXdOcEkwbmdYazhIeWp6Q09DTHlUVzJ2?=
 =?utf-8?B?U2tqZmRsa0U2MEdocUhyZ040eFovWk9zUkZnRXFlTUhqbDdUVVZvNGw3K3M1?=
 =?utf-8?B?M2NXYlRxQ2NJM3RBODRrSW5sQlFwNDE3TkdnTTB0TlhoWHVna2lHeFlDYldD?=
 =?utf-8?B?eEpnL0JkRlUrTWNrUHVBZm9XSGRvRHdlRWUwdkhSVXJkc2l6cXNkRXJzelFo?=
 =?utf-8?B?aXBaOUJKVThuMGFMZVQyNFFncjZnazV4TUdFZ0J4cWhMYThDK0V3QXJzdUJ3?=
 =?utf-8?B?dk9TaEZZVnd1cDVHVkNaRVFaYUwvLzFyYWlpWVdVUlRNWmd2NTN5eEp3SUNn?=
 =?utf-8?B?cExobGg2QTJJbVNEY3Rqb3hLb3kxZWhLSXpwdEZiUjNuREU2b3NvT2FpNXJS?=
 =?utf-8?B?Uzl1bGFlNXhjZlRHdXdaNnlqeHpXNmRDMGx4Umg0V0lrTENjZGUyTm0wby84?=
 =?utf-8?B?Q0Y2emhlQTdRV2ZwdmlKQi9JeW40TnR6cUdkVDdnOTRWa212YVVvcENENUZK?=
 =?utf-8?B?SmV6UDVpWlBsZVFXUzdmbC9NbGF2NmVkblJtUzhjY1FPdEJ0eTRWemo2WWNG?=
 =?utf-8?B?UWZ1OHBhMEY2dmZmcS9wVE5vWm0yZVJnQzB2VytJc2V3OWgwYnFpVzhDKzEy?=
 =?utf-8?B?dzM5Slh6cVlwQVhpVjhSRjMrWDZicnV1Q21rRVVscDVvL2kvcjhKQm1GcWZy?=
 =?utf-8?B?ekRNWGdnMDFOcEEwM0pUVldiRDFQZGsrVStPOTNEa00zcHp5bGF4NW5mODJ5?=
 =?utf-8?B?WjBNcEt2L0l3SnloS2JqeUU4cXJVWW9MZkVPU0owcU4rdVdPSGNTdzBFeTBr?=
 =?utf-8?B?NFNsL2pHREgxOGliYncxVmM0cFZQbldUYm94Q1BCOHJ2MnNMNEZFb3ZWS29R?=
 =?utf-8?B?bWVuaDVwNkF4bW1NNERYdnF5YUt3K3FDVDFXN2xGQUNiRlJlNVpNQU5pM0tj?=
 =?utf-8?B?SmE1aTF1TnZiZWNvNjVHMmJ3TkVEQ3dzN0lrR0Q0bkh0cVByUnA3Q21vRkk5?=
 =?utf-8?Q?BxerVJSnMM66ba0OXskbaPPdz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80855683-208f-4239-c45b-08dd88011cca
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 16:07:31.9600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 249nrckF9SETuWfZU1cVlm03R2fR5w80GESEOHPg+HJ6BAyHc/c6xjLZAF7mJpCwR2GFaZZkLo3tdk1ytxEzcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4251

Hi Arnaldo,

> root@number:/home/acme/git/linux# perf test -vvv ibs
>  73: AMD IBS via core pmu:
> --- start ---
> test child forked, pid 10047
> Using CPUID AuthenticAMD-26-44-0
> type: 0x0, config: 0x0, fd: 3  -  Pass
> type: 0x0, config: 0x1, fd: -1  -  Pass
> type: 0x4, config: 0x76, fd: 3  -  Pass
> type: 0x4, config: 0xc1, fd: 3  -  Pass
> type: 0x4, config: 0x12, fd: -1  -  Pass
> ---- end(0) ----
>  73: AMD IBS via core pmu                                            : Ok
> root@number:/home/acme/git/linux#

It picks up both the IBS tests for me. (Is that what you mean?)

  $ sudo ./perf test ibs
   73: AMD IBS via core pmu                                            : Ok
  112: AMD IBS sample period                                           : Ok

  $ ./perf --version
  perf version 6.15.rc2.g35db59fa8ea2

Thanks,
Ravi
