Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0A6221549;
	Tue, 10 Jun 2025 09:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749546041; cv=fail; b=jeEkeRBEmFt8X7ZzLpuoAyjE7FMRPWryifQhs68z7e0SjFgau7xxw/cv4BfuJMDHoBAizUTsUPiynGODm0eun96R4X+stf1iUxDu+xjLnCISSv6BEfWjKoMpThwL4m8Ex3notzlmwWUzG1W2fHKcrGi3/qebmzq16NLf7G08xh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749546041; c=relaxed/simple;
	bh=esnYDEZWa06vnHSTIWuSx5w0XSE6GwmRbR5n7xdYdh4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IwcKqIdduVnqVBwesjsJ3YE1e01K0Dl/a2Ll9iEWwvgP7wkqg3n/krngml8Jt+MZP/7rMcSK5uZsp7+H537ZVkDLiidFR/tCHF/mGUAzqlUva8fN1VsTCsDBad3DmCW1k0fpNN45N56QdcwZUm9a3tmjVwZ0ALmGRbyjkHAS+w8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c9y/sbxt; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c9y/sbxt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKgqb6eoVIULF6XWXDv/cBr3AgZxWK90kwrwBFC7Tk7tr9GScPTxGNJSYocQwv7yd+9PK/ZKgKBJNuNbjeS4QOVze1I+MmuNbVaXFy+3lnxZgP/Av/lkJ98Vb9LSOY5V5CQHZHbaIRUzUObKH/6muGcgL2V44qCj+1QVeoEvqmKE1DsRSaUlRIKgiFU9TyPwxKqb+Vgxe4rbjg1RRjOeSMqlVpUCi0UsLlGgzyptW00XOUn6IeGvwkqUYyQf/upAOT4Xh025+CDv3L5U35R8dRDMLrVkqLWtgxLiiBgY8yGS97ukdR33OoDcXalbY0YxgQWWqMd12oJ8HfE4DYJ00g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXPkZmlLQCM8a9c3uvJqHLMIRhubtI1U37xLFV4hBVc=;
 b=hEuTZXNbuUqpdN05k0G8Aa9DpOvoP3lLnetOFRe/vTRWliCd3Cf2eKCYLSUmi9c0in6x4h7VrAaGytCurQ/Dl4l17scyE7/HmrazbexOy5ZCCAkCVB0t7arosaTvzMo8jWq+YvydhHnrY/3RBb25srU3ochLNOGaHYyWW8s9Y4HPO83HLCvmAIL9zzLn2R4S+OwVFGyJ9tAX1/xwi0DY6t4PPxxoW6Vq9d1FxplZP6g55fhnhM+1mtiwD4dcICQ5upECqFCuaXrYyJxFHGNTnK0nboEy5claeaPiMpqcZ1gRkMycS52hcmR9TSMqIJqLeeFuQizcPbvDZMA2kSdBzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXPkZmlLQCM8a9c3uvJqHLMIRhubtI1U37xLFV4hBVc=;
 b=c9y/sbxtWON663iJsIGPfZK1RSiTWXOZSG3z0mXBakGJZ3DPT5bP+6qf6ERY8W6P79YGJxjLPOdza5NNM3XHmGTekQ0N9GOoFp7JLSne7HF5dbBO9UJ3BXirOHA/a136gMJY1Ly9b9z2CBGEEojTAXwGPCfr+GZjpJtR5Tqq/ss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by SN7PR12MB7911.namprd12.prod.outlook.com (2603:10b6:806:32a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 10 Jun
 2025 09:00:36 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 09:00:36 +0000
Message-ID: <1cf094b7-f530-4956-bbbd-be5a44a8a1f2@amd.com>
Date: Tue, 10 Jun 2025 14:30:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] mm: use folio_expected_ref_count() helper for reference
 counting
To: David Hildenbrand <david@redhat.com>, mhiramat@kernel.org,
 oleg@redhat.com, peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-mm@kvack.org
References: <20250609170806.447302-2-shivankg@amd.com>
 <398d49f6-00c8-4bd8-ba30-62cbf0efee46@redhat.com>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <398d49f6-00c8-4bd8-ba30-62cbf0efee46@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::34) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|SN7PR12MB7911:EE_
X-MS-Office365-Filtering-Correlation-Id: b2be8d57-cabb-40c2-fcf0-08dda7fd43ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUdqQVM0WStiUDBXd1hmNXlMbVpZbXdMa2dCYlRaR1FFMjI1WGcrVDEwZ1hp?=
 =?utf-8?B?VmUvWCtjMXMreHJqKzZtQXExOHhpdjJlY3JJa2dhYzlxWWhOYnc3TWRTMUt6?=
 =?utf-8?B?djBia1JRUEFvSDNwRTJnQzhxMlVwR3FJVnd3TlVyL21aL2U5cFdkRjVzWlUr?=
 =?utf-8?B?U09BZzBXYzJFQVh6VDRjZC93Y0MvWEExcUh5MVp6OEhYcGZRTUNINzVtQmVN?=
 =?utf-8?B?UEgyZUpFcVNFZmQ0RURKeHVPYWtmOWtZWlNFYnBHN0NxcHNSdHkzdEZ3Rjcv?=
 =?utf-8?B?R2VSQnVGQlJYMGgxSVQ3WFZWRzZtTlR2UVFmU1hxMWdOWDJGU2Z3cGY5elR1?=
 =?utf-8?B?bkgyMVFEL1lrQVNCMHdKRUxmKzhpckhzWnZMNzg1cWZFSkJSbTFHRkRodXdi?=
 =?utf-8?B?SE1qNko2Qm1zRG9vYnRVMXAxSXgzR29sdjlPdFFBWSt3NVkvdlNMU1RFWnJY?=
 =?utf-8?B?VnpqZmtYVW96eEt4OGc0Y1hwUU5ra2xMSFJETmVTdnc0a1Z4THJvQmRnZ1I5?=
 =?utf-8?B?K1I0WDlCejdLZ0pqYXpQOTJPVllOejBORkE2aUVOK1NTQjFPUE5kdzVYUENw?=
 =?utf-8?B?UUhtRmZXM202ZVBBV3J6M0JMclM3NTlMSmh4VG1kd1N6NXB6ZVVjdTNzQVE5?=
 =?utf-8?B?TmM2UnNSbnM3SnI0NE5XTWZHNklHREZMUWFNTFpuYlU3cTZMZjc5UEtlRDd4?=
 =?utf-8?B?b0MzWGFVYkpQWTBvZ3RoaHUzZ1NOM2xoaldxRlZFZW16aWFzcnAzZGtxbVNm?=
 =?utf-8?B?M1hWbVZ5eFoxaFJWMUJLN2s0M3h2TThqSVZhamEvbE51Ui9IbitLRGJNNmt5?=
 =?utf-8?B?b2pKSkNUY1hRbG4yZjBFUzNKU2tNSUlocU1PU0xwbWFoWUlYSU5oeTY2TldO?=
 =?utf-8?B?L2hKYUpYRm0zQkNZaC8xQU5pU0grYlhKbFhKakdGeE5EeVROQUFRV1dZQnVO?=
 =?utf-8?B?ZmdLN25HMXdwY1lQQVlUK0o4Z1ZncWJLSVBRVGl4L2xncnBkT05vVE9ETWd6?=
 =?utf-8?B?MlpWZTI3K3l1K01IVERkYi9oZmZSM0xiamNXcTIxVEh1eGdmWWRkT3duTnhn?=
 =?utf-8?B?VGp2WWlZdEFPWHZSU0ROUjcvMlVsaFMvUDFNOEM1RUR2SjZjZ3RCbFVSSEZD?=
 =?utf-8?B?ekhudUsyQkwvWTRCU3FLZnB1TWo3RlpwQW13QzlDRG1DVEhSOTFQSndMTUlM?=
 =?utf-8?B?UVNEcGs1UTBNVVcyT0dMVllTUklZTzJpblFON1VDeTZNUnBUdEpRd2MzWHpl?=
 =?utf-8?B?ZmVyWlJyazZKUkZXRDhDZzNmWGpEK0x0eUVwMkpBWHRHbWVEU2p3bHdnbE1F?=
 =?utf-8?B?SWlmeWh6WTM1dUhZa3lFQjBtUFV4ZE9pTll1MUtrUDFKc0JhTjduYXN2UlF3?=
 =?utf-8?B?Qm1wTnZmdi9DTm1hWnFrdWRCM2VZVEpacExleC9pSHVHYlAwNjFiY2FqYkcz?=
 =?utf-8?B?MHVqZUhiUFljbExSai8va3U0ZC9Iam85YVZwWGpMUzQrWGRKTDhjVFh6NnU1?=
 =?utf-8?B?TFhuaDRBSkpONFBNUWs3cStFRXkrTnlmOW5OTnRtbElobU4rTzl6bzJzbWF0?=
 =?utf-8?B?bDA3d0N4V1lKRGhmeTNMYnhCTzBweXIwUkxXMng1bGRzc0Vnb2RRSGJkZUJB?=
 =?utf-8?B?Z0pLSjRaNUIreEMzUTMzU29jVXd5dFpsbXF2TlprR1F6QXBDMVdXVGR0QUxT?=
 =?utf-8?B?ZXBwaVA0L0x1T0pJY0FuVlJnRFZTWTZHU1plZEp2UU9oZTM1ZHBXRThoZU15?=
 =?utf-8?B?dFRTZEdnbmpYVHdia1NIUHR2cEdTWldHeTA3WGRoaFAwa0ZFWStWTGF0L3VJ?=
 =?utf-8?B?WTVHazNiUkZmS2FWUUh2R2NhWDFQdzB6Y0VuY1Aya0pNR3VkT3lRN2RFSVBB?=
 =?utf-8?B?NWYrekhEWTk3aDJlSVFCbWlRb0FSOU84K2dDYzlBN3lYSDlKZWMrWGlrejlC?=
 =?utf-8?B?MERRL3MxZyszYU1iWnZoM1hqa1IwQkNQOUk5cG1VZDhpUFFDNWJFMC9QUGE3?=
 =?utf-8?B?ZWRieGVQOVV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGM4NERoZmhyZmVIUTZBZ0dyQjhzQ3h4SENsRWxDYitFWGFxN3A2cVNkcGV1?=
 =?utf-8?B?SVVLR1hTbUVXeXRocGkxa1d0K28vQjM3T1R0RjlkWkl1U3d4M05idnlSUStz?=
 =?utf-8?B?UmNxUmlJV0dUSGtYTFgrOVlQSU1nS01HbG1FME9vb1VDZy80VEloT1p1cDIr?=
 =?utf-8?B?S1pSRUtLSDFuWXdlWVlVbDV5RktESDdvUHZIRGYwbnMrVTd0V0gyekMrY2Vs?=
 =?utf-8?B?QU9WMWZ3bC9kYkdNTnV0UVEzc29RVjVVOTRyVWFFNzNVSTBMcldKME52SlVV?=
 =?utf-8?B?OW56VHJPOVhYOHJhTUhnLzk0N3JYcjRZejN5eUdUYTl6QUFEMGYvanE1elR5?=
 =?utf-8?B?b3p5ZzIveHJVSTNzaE1NdXg1aUMwNk9jNlZFcDRkdGdjUVd5QXRxM0ozNlZx?=
 =?utf-8?B?cmk4NWw4Vkt1RFFUM25ZMk52YzE1Uzl5bG9VRnpPZ293R1I3bVNaYzg1NTZL?=
 =?utf-8?B?VndBb0Z0VTRNTExaNENsNHZ0MCtWZStIODZkRlB2MTZpNmNWdmYwZDhEZStm?=
 =?utf-8?B?emdTV1YwZGpWbTRQekEzSWlpaFZQWWk3N0NXMVh2OENjQlh1UVNWNUlpNFlo?=
 =?utf-8?B?d0hrZVZlSlNVampqaE15SXl3Z2JYcFVvZ0NCTXZvSlJ5endMdzdvNi84Qyti?=
 =?utf-8?B?dXM4YURJSHJnT3AreW1LaGpQUlhDdlY1NVdrN3JPOTBNNEh1QUNNWi9LMHRt?=
 =?utf-8?B?TmpXbmJTUldRb0NsQXdzaSs1aGdHU1h6RWdoZ3pSbWFPVzBJc1BNMUpiOFdt?=
 =?utf-8?B?WWVhSElkaFFWaStFamNubmdTOCtlK0ZnQTNjcHEwQ3pDbzVRS1lCS2pvdXg3?=
 =?utf-8?B?N1pqRDBVdDEySDZLTGFERE5iamZMKzBsbzlZMFZJWGwxZmxISTBMeUFtcjJJ?=
 =?utf-8?B?cldvZWNYS05JcTQvemM5b0VIVlpERTZ1c3JFNXMzcEZkSzBSS3VBdmx4bjZ1?=
 =?utf-8?B?TDNsR085d3EvZEcrRUVuOGpXSEFCblNDelVuREpvWndtdUovaXhEb3ZLZ0Nn?=
 =?utf-8?B?UHozU1NzTDFiMUxqdnIxejRJNDFvQmhmSkNaN3Y5TFI1SThjTGJkUk84TjVW?=
 =?utf-8?B?QzBrSWtkYUo0TzZDL2RRTndwQjh1S1BsaHdWS3ZoNDdHZEhRVUltMEM2MTAw?=
 =?utf-8?B?dCtVVWRCamU0czZRUndVb0dOdFFkQ3BnRFNIU2luQUU1QkF1QUZ4NWU0NUpt?=
 =?utf-8?B?UnBZY3lMQjI2ZVRJVkZtcFArTGp5RTgvN0lITTN5bzNPa05sR1pvV0dxUG9D?=
 =?utf-8?B?U3BKWlFXeE5wVWtkemhmdHF1WENrKzdPZ1RrSlM3c2poTlpzM3NzbFNBMmZu?=
 =?utf-8?B?cU1qMEhiNjZxVzQwMXJmdXZvR1V0TGM2bkhOaTlLL1JNbmNQNFc5RGt3Q0wz?=
 =?utf-8?B?RmlUL3NJdkxWWFNMV01JQk1CMlUvOXBPbVFoTXNVeVV1QXhOMU5NclpOU01Z?=
 =?utf-8?B?ZUt4M1dPTjBTQitYT0xWRTVwTlZmcE8rK21DTUVtTXQ1b1Y4cXZMZEk1NDNT?=
 =?utf-8?B?M0lzWXdpQVZRdXk4dU1GUnNOQm1TTUxIbHg4cnllQlAvWlNpREsraW91cmM2?=
 =?utf-8?B?bUthemNyczFYb0RZOC8rNCs5NndGekpsMjBIVlZqQlV6TGRwS1gvc2t1Q3Bq?=
 =?utf-8?B?OUM3SDlHQVVjSVB6YVdwMlM3WFQ5NWdsMk1sbkpmV253eGp0SXVZUm5nZzh1?=
 =?utf-8?B?elcrUTFrUnBMR1llSFp6cjhNNHUrZ2xJZnRET2hhVU1NV1JLdkd1NXd4amdy?=
 =?utf-8?B?ZE1WZTNBOVN1aEtNaGN3clkyN2RmNnljbXFqMkJpaXk0NHZqcGkyeHVGTWhG?=
 =?utf-8?B?djZCdE1aQXYyaWhXUmRiOEtmcEh2TkdXWU53TmYyUEwvUm0wZndxVzJ5UkdI?=
 =?utf-8?B?Q296ZlpIZlRQQ1I2d2NmNGw4UWVkUFVsd0tVQmpQcGhzbjYzVWtIOWljbmxD?=
 =?utf-8?B?NHB3aDBoZjZyejJYZnJsZHRRZHpuNEloVnQ4S1Q2YTdSZXdTUU8vcEVoWmxx?=
 =?utf-8?B?Ny9mK1lzaTU4ZWFTM3E0bTNkVEY2Z2c4UENRVytWNTV3R294WDB2ak1ueWRI?=
 =?utf-8?B?ZGVJakpMNWhZY1pWNXovV2FJZnpmQUs1TWhhRVB4QW4yNjgzN1pDSHhvT1JR?=
 =?utf-8?Q?DsJI92k6gPMj16XWrYI9ELzqZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2be8d57-cabb-40c2-fcf0-08dda7fd43ab
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 09:00:36.5509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1ppa4thkYwQEy9/2aTrkcJhbztCHp4Qf7IMIqaoLJmnwYHqy1fI4R5silKzIa7W0nfG6ligy1yfobkaSotrEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7911



On 6/10/2025 12:38 PM, David Hildenbrand wrote:
> On 09.06.25 19:08, Shivank Garg wrote:
>> Replace open-coded folio reference count calculations with the
>> folio_expected_ref_count() helper to improve code maintainability
>> and reduce duplication.
>>
>> No functional changes intended.
>>
>> Signed-off-by: Shivank Garg <shivankg@amd.com>
>> ---
>>   kernel/events/uprobes.c | 5 +++--
>>   mm/memfd.c              | 4 ++--
>>   2 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
>> index 4c965ba77f9f..c978c8c27340 100644
>> --- a/kernel/events/uprobes.c
>> +++ b/kernel/events/uprobes.c
>> @@ -434,10 +434,11 @@ static int __uprobe_write_opcode(struct vm_area_struct *vma,
>>       /*
>>        * When unregistering, we may only zap a PTE if uffd is disabled and
>>        * there are no unexpected folio references ...
>> +     * Expected refs: mappings + swapcache.
>> +     * We hold one additional reference (+1).
>>        */
>>       if (is_register || userfaultfd_missing(vma) ||
>> -        (folio_ref_count(folio) != folio_mapcount(folio) + 1 +
>> -         folio_test_swapcache(folio) * folio_nr_pages(folio)))
>> +        (folio_ref_count(folio) != folio_expected_ref_count(folio) + 1))
>>           goto remap;
>>   
> 
> With the comment removed (the caller holds a reference from GUP) or simplified ("Caller holds an additional folio reference.")
> 
Sure, I'll make this change in revision.

> Acked-by: David Hildenbrand <david@redhat.com>
> 
Thank you!

Best Regards,
Shivank
