Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012007.outbound.protection.outlook.com [40.93.195.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C4E2BCF5D;
	Mon,  8 Dec 2025 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765187210; cv=fail; b=ipBU+1wCRNvz1UFSvhNUcvNxIOdFxdLwGFTVvgbf7WpHR9feKlt1c/ctIkB4kk7ax+fr54PnhKUr9c9yei/+3hRLMjMy6HWp+RooJNLpXDAIPQ2tHwh1hFiZHBpNrotAEZ10JxBlTbn2XWLe4r4dOoXKSK5e2iIL0ALsyvBfZPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765187210; c=relaxed/simple;
	bh=Ersc3CJa5cB8DI1UQzduciX2UQKZv3QTgT/NeUmdtl4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jFUVcV4w/yoI5YQ/GdFNZAhlBNN6uSHGbGAL070HSx7DwAtkAWb7/E2kTWPXRkSxC4tD40gj8Pd65iVHu5rYC/3/omG9vsV8KI1Hea5hhJX4wPnG2FYMV3hPjS4xp2n/bWoATroeqXnujXJxdjKB5wKj4JAhTnJqnERWHFKK1U0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x6/S4/WY; arc=fail smtp.client-ip=40.93.195.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x6/S4/WY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZhn2+tWP/C8SzE4a5GqmnKU2vUU4cQ8BnzYDqHbdt+B9/sJ/L5KB+dBV8jnxiIA+rYKBIbdF/ur+6rNegeFM+b2PbSnLsuhi0rhVrGbaefkyAxCoKCPsYn27gEwAmsdfdgQHDkKE1FVXOI0xtl0+jGoM4NWALm6SrngsTQH9s4aAak0MoK7Vo+WBAWZBYVBR0hhWgQHQihICasaVZfqStQBMdi+VPDoE6NAR5poe5+2GcREC5I6jiJRqrnK446KV8aKtTPcG6oArSIo/6/Muxot9xFN24GaLkmtMbslMOkoEDIyK8XWdxg29Invy1AstfA0wQ6id6OfZFXf3j++Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0S4KBLhb7+Ggst8Ksc4Nnt7H9oqwSopuBPj8aJxlIcc=;
 b=b5vRs7J5e9qiTPooUbMaCaTWUmXd8YFvCCiKpb9fFbhhlytksrlOmxrj8TMWD5h5UtrVni4k5Ox9IGOX+gQkJ9zligN9H5dmhtiClJHdDDQNeLtq7s3YwFTvjdeFbKTw/exU4kbs8Gp+hln6VxyyMEbWD/8ZBqHWGc+Tuwlf757C5NIUaE8Et6z1Nnk8OSqnxxdRupaBpqguDqGX3rhNPGQRSS1koO7KTZT/8IX5pcMOU/UJRh4oUQGSfRMIztnOxbhtnO5K++tSl34Vk7Bubsw8xrmcDz+NUGTKoNBd4tStygy1yY7jKTd76qqvRJVYosTXJipdBuNuE7DfRF1rSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0S4KBLhb7+Ggst8Ksc4Nnt7H9oqwSopuBPj8aJxlIcc=;
 b=x6/S4/WYCXwdB4s6zf3RJKjMT0ZCVv8TJpGIiUqTh75OF/px+xnLt7gc2FZFgwYRzSPQLnwfP6IWHbwZRcAKOcd5SGBxbm36gQmW+tl5gT0gwnOdMVN2PTC4fkEcFjzROeREijNHpAesXpGlJTXtm0nVNIbHN11kSmJWFFRmHWg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by SJ2PR12MB7896.namprd12.prod.outlook.com (2603:10b6:a03:4c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 09:46:45 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::afe1:7dd0:ea71:b7e7%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 09:46:45 +0000
Message-ID: <25e7ebdf-39d3-418a-ac23-8f63b3f9f372@amd.com>
Date: Mon, 8 Dec 2025 15:16:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 17/48] perf jevents: Add upc metric for uops per cycle
 for AMD
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
References: <20251202175043.623597-1-irogers@google.com>
 <20251202175043.623597-18-irogers@google.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <20251202175043.623597-18-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0232.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::6) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|SJ2PR12MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: a148884a-39a7-4f59-6e37-08de363eb30f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVJtQkVtTUtXM2Rjc2dMeEoyS3FyanBZRFJrY2dXUk5FZ3hBS1lJUDhOSzA3?=
 =?utf-8?B?c3p2M3ljQVRyUlBWQTBrb3JCNktsUkpnOS9qZWwzV0FMRjJWdGFsSW9BWFFn?=
 =?utf-8?B?ZmdyWE00bHZhekxFSTZLYzBQY2hrT3g5bHlObFdrL2tRa25QNnFyZ2V2cTc2?=
 =?utf-8?B?MU4xQy9CMHhIbSsxbUltQUVNWEd0NVRrdzNoUGdnOWxtQXhCRVAvSmUxRjdz?=
 =?utf-8?B?c0QxWmF4TTFJeXo2NTV3VEpMVDBUVk1zU2syYkc4ZVhiSDZHY3Yyeks1VnVB?=
 =?utf-8?B?UXFpd2djZ0hsdVBSRGpXa002YXkyVmZud0ZwOTVEamJMeGtsa3RVUVB3dGVk?=
 =?utf-8?B?WGI4bVFJNC9vblY3NUYwNXRLbXFhanhneXNmcFY3TzNzdWVuSG8vWEFQRkRa?=
 =?utf-8?B?aGRaV0ltUDFJMjl0bGNSd0pLOXNHZVpsRXlnNGRXMGMrVE56QzY1UTZwdG52?=
 =?utf-8?B?dzV3NGx5QWdxN1VWbVpnMlRNbVFvS0dLYkx5MStrbXJiUGJQcGxneEVmaWdQ?=
 =?utf-8?B?OVp4M0M0WWxLKzBxNFNMSGlrWENwNVV0QXpzaG9oUjdXNDQ1NzgweGthWVlL?=
 =?utf-8?B?UWN6SmJsM2xNK1dlbzZGVjJMSHROajFINElZenJockpBSDRlcDB2S0ZaS0xQ?=
 =?utf-8?B?NitobHpnRWl0Wm1VVmwrZ3dQeG5Lc3p1OGNTZXZKMlJaZkg2SVYvcngvQlA1?=
 =?utf-8?B?cmYyTHZScHNWbG5ZcW1LRlBUaTBhT2RIcTVkamhLTElNQWJUS01DOXJyakFs?=
 =?utf-8?B?Rk55aUplMkhLRlJVWUxLeFh2NTNFYTB2UGlwU3pONld6enNqa0p6TFdIWm1L?=
 =?utf-8?B?YkNNc08yNjg2MFVmWExIUE9LbDYwMk9qUDFieTNYK3lVV0JqRjRXUnhuUEpO?=
 =?utf-8?B?cjN0dkErTlRhZ29ja2pYc1l3SUhoVS83R3VINFNSWlg2a0N5dDI3UE5RUm84?=
 =?utf-8?B?T1owcTVPdWVWTjQyTHBhZlpJS1dCd25pQ1pWejl0NDg1cGkzaEdsMTViY3VP?=
 =?utf-8?B?UXp2cVB6UmdWYVJ5bUxOVytoQXE1V2pMQ2ZNS2dVSkV4djJjM0ZCRnNJUUlq?=
 =?utf-8?B?OFAxOElnREJ1N0FoQzczeWh4bGt0MXE3VG0rTUc4RFBaeDcyTlVjVmZFRExv?=
 =?utf-8?B?NWE1TjMvaVU5eFRNZW0xTitTd1dBMGtYZS81NmdBSUw1R040ckIzNm9wbDh2?=
 =?utf-8?B?U0VwNDNOWTdTWmo4WUx2N0o2RW1jVGkzbWNvVFRYdEV1R3d1RmY1K2tlWDBQ?=
 =?utf-8?B?VTA0cVV1Z1FHZTQySTVyTG8xZHZMWjBYaHpabFhPVDhEZmV3czVXMUxvNlFC?=
 =?utf-8?B?VTZOa2NuTWRkNWdsOUVWUnJUK1VlWmMrM013ZmUwbUo3R3U2QWtmbjFPdElz?=
 =?utf-8?B?S0tqY0J6azhoTTRLbGRKd2pKVE5ZTDFZNnJNYXFuelRPOGN4RGZQZmU3ZDdp?=
 =?utf-8?B?NDUvcXdxMVNaaHJRa25HTXIzTlZ1NUM0WkI2MnR1Sng2c0VrMlNTdnpnRFNT?=
 =?utf-8?B?RW1WWHZDMytOVXk1UFVhVGpYVTgremM0WW0zQjBVLy9aQ2FjUW1UVjNnZTdC?=
 =?utf-8?B?Y0d4RXNRdy9LRDFwSXJyeVZCdDBOSUNnL0VzOVlmODBUQTQ5dS9ZRTByZWt5?=
 =?utf-8?B?Y0FCUitMNi92QkxkMWFiRUdhYWIwdUlsOXdBR1lzM0E0UVJDd2g2cnk1eVhQ?=
 =?utf-8?B?YVRTUTI3TEh1NElnenNRcHh5UEFXUFQwbGZXWkxxNlA2SjNtRUwwMGRPYmVD?=
 =?utf-8?B?UnhEMXozWU5IT0FmUm0veUdwaW1UeHdLOW5xMC91elFMays4NHQxNlJrbVUz?=
 =?utf-8?B?SGlCTUNMUzNIMkRGSnY4UHJYdDRNUjBiNVAxSVM2Wmx4Z1gzMWlVR3Z1eHB1?=
 =?utf-8?B?UlpUMWdOSTlmeHplblpiSHVScWJkaFpvT05xREkvN1gvRWJJclBOYmF1eHBv?=
 =?utf-8?B?N1BjTVNuSE1kaUhqOGJ6RVE1eXVXY2FxNGd4K2pnWUVkWXNnclBxcVRqY2VM?=
 =?utf-8?Q?ugLkLMNAAbTT1s9ykZx5kgeRuGM7+Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WitGd1QzYmdEYWs2MU5sNmUwZW5TT1RMK3p1bVJRbmNlUEdkWDMydGtjMG1n?=
 =?utf-8?B?ekpoaElJMGFyYXA0M2RrUGNWVGFkOTdQaFh6STJhVGJSeHRRZ2JLaDdLZzFS?=
 =?utf-8?B?b0w1cHVIUXJ6elNtdkdJRzhjczEyZnJDQlRXb3RQZXlKTG12NlR4L2c5aXFh?=
 =?utf-8?B?cFliUmRCaExLS1dnaTREK1BET2ZYM1p2UklIeFNJbzE2Y2NqTEI5Zmxia1FR?=
 =?utf-8?B?NFpmbElEY1JHVWRGZUVSMzBJY3ZUd1pRUnlhVUxmbWxVckFwQnJSK0sxcU84?=
 =?utf-8?B?UTR0NVZBaGRBaTRjWGNGbVZaQzBadjJqSEU1bDJkNkdONU0zbWNnTk1ERHNk?=
 =?utf-8?B?dlpUK2cyT1l2MnlDQk4vSFovNitoTEorRjdPNG1PRUxjM2tTaGdya283S1ZP?=
 =?utf-8?B?QXAxSkViczdzT2F4NzNSUytMZm1BcWRuOGVrOFJJaldMNjdqc2NmWC9OTUZK?=
 =?utf-8?B?OEc0NWhYcWxVdXFsdUpxK3FuQjdBNFc4QmZKcVNzSWxjNkJUd2Zub3FLbE9N?=
 =?utf-8?B?OVdySlVRT1Mya1VmTVdwMStRNnc0YWwxaEZWMEEwMjRPeFA0NDB3MXhqMlFR?=
 =?utf-8?B?ZUplM2ZvdFBvUldHdVlWeGZ2SXAyR3R2Wjk0YjYrdXVZWXIyUXVmNlpoUWdC?=
 =?utf-8?B?MlhFQlJoa2VxMHIyeVNJMU11ejFMNGUzVTg5WGdjb1BESHdLUloyWHNCQ0pO?=
 =?utf-8?B?OFgzUTEySTRjZ0NGN2pHOGE0S1ZLRmw3OHVVcGU5ajQ4RVczOXMwV2cxaHBp?=
 =?utf-8?B?OXFITEpvVlEzMXBkYlFwS0luTEF4ZnY2SlpnYkMwa3MyUnJQRzBqVzUwOVZo?=
 =?utf-8?B?K0N2ZjZ0Wk5TQk1yT0x4Zm4zdklnZVMrRzd5d0Z1U21OcWwvSEhsWjU3R3Y1?=
 =?utf-8?B?R2U4SWcyenVnMmJJalhNVnNZdHYwOWdKS201Q2xXMGxEN1ZnaC9RVTZQSEh2?=
 =?utf-8?B?S3U5K1dDWk5iOWh4eitiOEUrcUpGTlBYY2Exd3RGdDVaYmNIK3h1d01IWEtK?=
 =?utf-8?B?VzhRS1hHUlVjeTl0azE2aWdNMzgvdGZyU2YwMUpOc25tZWVpTkZlTUVoUWdY?=
 =?utf-8?B?ZW5BMFU5WVRkT002OFV6STk0K29FTndmaXFKdDk1VTVuWnF4NUFESkllUG5H?=
 =?utf-8?B?K3hRTStvYnhiYnlSVEl3RDZ4eHFaUVdWNlhWTFVGcEdMZ05FR2Z4cEpVYVZp?=
 =?utf-8?B?Y1dxS3cvUitiT1M3T3JFSnJQTklON3hHc3p1WGF3bDd5eUVVWmtmUVpCTXd6?=
 =?utf-8?B?c0NaY2pMOGcrcG90TWRvOWR6MThCbEJLNmxUSER4RmhNSHdUNGRUN3c2SGdX?=
 =?utf-8?B?RnhuamQwV2xtMzlleVJRUDlxTVdaNkxkYVMwYXFsZ3RZRmxiZThzaUdGQWJa?=
 =?utf-8?B?VWJFSG8wbjJCOW1aaHNsKzBuSTJXWHYwTmsvcE54eloyNUpnVWVjN1dtSVhG?=
 =?utf-8?B?aEtzb01OYm5JeVMyVFBQWDhZcFBhalBHLzRIdE12a0I1SkVZZTExU0lQSmdw?=
 =?utf-8?B?OXZLM1JaUzZKSDE1YTAxdExOZlV2UzdxMUdqcXJ6WnlSenVwc2NGdWcvMzlU?=
 =?utf-8?B?Tml2a0x2Qks5OTlTRVhxM0JyTmZEazJMZHJoUW5sWlN5YWhhTEFIcmNYaFh1?=
 =?utf-8?B?cjdOekxsQXJqZW14dU5rMEQ0cXVBVHNIL2Q2NG9xSUFYV2Y4bEd3VWl4eFNa?=
 =?utf-8?B?b1lKWm5kQ1VTWWNLZGoyRVJRQTg2Q29wdXJRUFFGQ095c0dIdUpORFYrYTll?=
 =?utf-8?B?KzlsSzFXYkthemZudW1uWVJ1aFVDc0RVRzhwclQxaDUzRVJuamhOUXpHYy9z?=
 =?utf-8?B?NmtXRFp4YjdJeDduQlRHbU9kNytvYzNqcXZ1OGRlZVBOSi9vUWxHbFJ4L3dJ?=
 =?utf-8?B?d2FsWDRFcGVuaE9SR0poc0FyWEZUTmc3djNNMDhra1VEYkorMEpaK0NORTFJ?=
 =?utf-8?B?VEZUK1ZRanFod0cxaFZweE1WSjJiMGR6M3VBbWFVR1d6VEw1SFkvcGQrQlBL?=
 =?utf-8?B?RVFnWlZsWFd2NUhlSlViTFFka3dlQ3ZWendNTHVTdlhkWDROWUo2anJNRGJn?=
 =?utf-8?B?dHRXZ0NoSnFmeWNUZXBxdDVKTVdEK2dDUW9ReWkxcG0zU01LVkdsUHZZTEZN?=
 =?utf-8?Q?8pIs5BK+dO0BVfgjR/0DcTT7W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a148884a-39a7-4f59-6e37-08de363eb30f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 09:46:45.6555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5GmWhK+lz9aeMY7BzJVIFo/bn/MIvia949s6eQhUvoHJv24sdyn4lDxWFS9uszZfVbS366DAJGxYAFPAubegqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7896

On 12/2/2025 11:20 PM, Ian Rogers wrote:
> The metric adjusts for whether or not SMT is on.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Sandipan Das <sandipan.das@amd.com>
> ---
>  tools/perf/pmu-events/amd_metrics.py | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
> index f51a044b8005..42e46b33334d 100755
> --- a/tools/perf/pmu-events/amd_metrics.py
> +++ b/tools/perf/pmu-events/amd_metrics.py
> @@ -3,14 +3,26 @@
>  import argparse
>  import math
>  import os
> +from typing import Optional
>  from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
> -                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
> -                    MetricGroup, Select)
> +                    JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
> +                    Metric, MetricGroup, Select)
>  
>  # Global command line arguments.
>  _args = None
> -
> +_zen_model: int = 1
>  interval_sec = Event("duration_time")
> +ins = Event("instructions")
> +cycles = Event("cycles")
> +# Number of CPU cycles scaled for SMT.
> +smt_cycles = Select(cycles / 2, Literal("#smt_on"), cycles)

The CPU architects said that while there are some fairness guarantees, the distribution
of resources amongst sibling threads is not always equal. There is also no easy way to
determine this.

> +
> +
> +def AmdUpc() -> Metric:
> +    ops = Event("ex_ret_ops", "ex_ret_cops")
> +    upc = d_ratio(ops, smt_cycles)
> +    return Metric("lpm_upc", "Micro-ops retired per core cycle (higher is better)",
> +                  upc, "uops/cycle")

Zen 3 onwards, PMCx0C1, which is used by ex_ret_ops and ex_ret_cops, counts retired
macro-ops.

>  
>  
>  def Idle() -> Metric:
> @@ -45,6 +57,7 @@ def Rapl() -> MetricGroup:
>  
>  def main() -> None:
>      global _args
> +    global _zen_model
>  
>      def dir_path(path: str) -> str:
>          """Validate path is a directory for argparse."""
> @@ -67,7 +80,10 @@ def main() -> None:
>      directory = f"{_args.events_path}/x86/{_args.model}/"
>      LoadEvents(directory)
>  
> +    _zen_model = int(_args.model[6:])
> +
>      all_metrics = MetricGroup("", [
> +        AmdUpc(),
>          Idle(),
>          Rapl(),
>      ])

