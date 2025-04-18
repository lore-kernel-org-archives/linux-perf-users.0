Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F841EE7BE;
	Fri, 18 Apr 2025 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744968489; cv=fail; b=NHFS/CE7bFd3eQdnffX1UV9sbjT8CBBwsM9pZ8A1qMzdvrT4oVMhOve2G86OCakdAH0jLHrVE0FjtNd8Nyep+8WdfRDSOs3pdzLYMFYtWqjJo2PKK0dc2A0Q7fYF5z52WzJGw1Q3edhXK4xZiM2mUmK0nWtUHSZ96n5PuFvENaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744968489; c=relaxed/simple;
	bh=77cwKeAyUwf3LPmpsI2L9H+SgLThA1UvrYb9k9g5COI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g3sDqod48ndVHgpdL1xW5h78dsJxTdKyW7pWV88O+OUTXRqZvMdPjwV5EINCAt+Sd5x2RMTrd8YNBKZvPuvAJk9Ll6NMKp6PoID/R4UZQkZ+rCrpGTYPwO+1Qb/IBimT6cWZ/Vczfa1i14pHpxWyj25wQWr2vhVyoiZ9s7BXiKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NSKHWUct; arc=fail smtp.client-ip=40.107.212.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NSKHWUct"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FjJgJg7mmnBkjNWu4cSirDwmaYE7n9UL84FvZF3vnpXdAbgO2BQYS786yFobzKZ4ZhlEr9XpkKSnY5IVAN0DUFEXptafPhUpUbPErLdtcPsbrgP2rbogcXml4E7QnZyEF+s7UfnxNfdQ1hEjrq4TsJUm0rYx4H/xxc/HOiFMatuYPBpZqovMrUFKx5sDGsQIAxsM9BpTNIXoqR44fv7CtIyagRhMfRrJL80ekLz1b2FFyxQ9pTP3RQCg4uu3ZVAX7CzBkGGXw0qsPNz2E1chr3vvb4CvV7LOm7BGSJ7qIwPj4DefscafzYRe0gvRb/9AkqKzUvcf7CZhZ2F03lSPtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozQ920JLnXxsoUXLPXOcdb/+M5vjOMYYr/soJpo9THw=;
 b=w8OjhS5syZs5ZRjP1DM5/4HZQxAIJdP2yyUHaJyTRn6YXQqTRG3K3KlgYAQddP18n3oxXuD19ohCeTYgyQmrTO/0u6qlHZt8UK4mTapLEzyBSDFTgX3WVGWZujWoitnDpk9bHpv1GbZwNKoQmoNW4tN0k37jpppipDuaIOaJ00Ut5wy2X5Vx9v5Ig6vITNv3wTaQo2j6UVXeDHhDjE1y8WF80j6QT1v7Xuqi9FwTRO2AkDqUYJYcaqKwocN3uQd9FcwzXykxjY9k9Jt9YSz47S5zCXRG1GL1c70zVIwdgoa9JgQuphk9zeZ73s8KY10y93Qs7Djlu5MV4r2V0Vh9rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozQ920JLnXxsoUXLPXOcdb/+M5vjOMYYr/soJpo9THw=;
 b=NSKHWUctEcHxD85DHMIUjt/Fbbd86uN/UDMwfosJ0ABVzQ1c6DPTvd3Ahvh9DT5kGZ8QJNDHa4sgxV8NTlNSElhZKQnoNlKg6LP2+SHzCctSeGUCU90GPGDhwvawxtKK+E1XXQxAolssj+qZZCD7Mjo5xMA6Ks1P+poYlUfkfrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by PH7PR12MB6934.namprd12.prod.outlook.com (2603:10b6:510:1b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Fri, 18 Apr
 2025 09:28:03 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::2efc:dc9f:3ba8:3291]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::2efc:dc9f:3ba8:3291%6]) with mapi id 15.20.8655.021; Fri, 18 Apr 2025
 09:28:03 +0000
Message-ID: <c8d5dac0-f933-49bc-9420-bd2d81910a99@amd.com>
Date: Fri, 18 Apr 2025 14:57:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] perf/x86/uncore: Overflow handling enhancements
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 eranian@google.com, songliubraving@meta.com, ravi.bangoria@amd.com,
 ananth.narayan@amd.com
References: <cover.1744906694.git.sandipan.das@amd.com>
 <aAIOGkKWGOLbu6y-@gmail.com>
Content-Language: en-US
From: Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <aAIOGkKWGOLbu6y-@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::18) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|PH7PR12MB6934:EE_
X-MS-Office365-Filtering-Correlation-Id: ed98afc1-e2f7-4945-a8dd-08dd7e5b51cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aU9vU3pwcVdlR21BRUZUdmdaaVVNWmZrdTFrS1BRams5T3NvUVpac2trOUtJ?=
 =?utf-8?B?M3hDOTJyQnhWTXR2VFpCOE1hNE56UzNBRElsOSt0SSt0Ulp4OWYxNHQzdnNW?=
 =?utf-8?B?anNZQlUzUk1iQzBaMWNEaGhFS29RaG9qbDRkUld5YmdMU2s4QlAxaGg3WUpP?=
 =?utf-8?B?N2JsbXVxTitvSzFqRFRZUUZLK0NXd0IzZ3BKdzVJeXRmWEIvS1lYYUNlUHIx?=
 =?utf-8?B?WFdKZDJNcTRrWjdmKzg3cnVOVUZZNlRUM1pCRk9NR3RaQnFnWEg5ZmJ0NktJ?=
 =?utf-8?B?QTlNMlJvRUpCSGthKzZKU3BJZUtId093c0pYMHFTRllhN1RCd0hneWhMWVp6?=
 =?utf-8?B?ZEUwMTB3K3NnVEhBZFU2eGVKcjFkMnlPb05YaHhUdTI3ajR3MEh3Y1NVQWtV?=
 =?utf-8?B?YnFiV1cxekNTRTF4VDBsRWZQeUFhY016VWZxNW8xQkNwNUxOK2ZZMkZsUTZ2?=
 =?utf-8?B?SDk5aWwzcmlzZ29qRHIwMGtlRnRRZmpsOEY5dFowUnYrcnNPYXBhVTR4azU1?=
 =?utf-8?B?Rjhvem02elNrZStDOVRjRytwTUxJQVJNdzc1d1A2WjRXSG40RFFWVEgwbnor?=
 =?utf-8?B?cjl5am4xT1Z1Q1d3RS9LeHhTeExTdkMrUS9Eb09EcTdmc0lBU2g4TitUeEdQ?=
 =?utf-8?B?Rnd0TGNuSkJMcVo0K2ZkRGY0NGFxckJQZmpFNCszR0JtZmpIV3JwNjZWc29t?=
 =?utf-8?B?OXlIWnhqOERTbVdhZHB1THhHQSsrWVBHMUIyZ3lDd3BDeXJrbWNETVBCaitV?=
 =?utf-8?B?OVl3SnF6NXJDbEZrWEdxU0I5UlF4SUtROHR2WDMvR1RRYXNWaEZ3RThHN1ht?=
 =?utf-8?B?NDNEY3p5YlF0eUhCWFQ3WkV6TEtsdnJraWcyZXJNbVpYTFV0Q2pmQXRFVGx1?=
 =?utf-8?B?T2ltYTRLY2VGaUVwbkNOMzcyM2EwczFZTXJiNXFzQjE4UDNvV1RkQzhGWWZl?=
 =?utf-8?B?L21EcThzSGQ3bUlLS2JxWGZrNXRCMlBtQk5QSXdPMUJyblZYV0UzcFdFc3hG?=
 =?utf-8?B?RHAxR1RFU3ZTTks3Q2J2UjBxN001V1BlWnA4NW9aZ1Vyc1RXR05panN6dXNM?=
 =?utf-8?B?bTFCSVlPa0xoaUl2eVYwc3N0QmNFQW9DNXIvUTJQZjJKbmFod0M5MkZ4bXY4?=
 =?utf-8?B?dXA4YWJtc1RkVHh1a2FTZlYyV3B3SEJqclpOK24vMEY1eUk2SE9uaWdvYlQr?=
 =?utf-8?B?T1hvTHZNeGpJR2hUcjFhQjZzb0tuTWk4ME92bS8ydjVkOW4yeno0Rm83OHhY?=
 =?utf-8?B?T1BXVDZhODNBZ0IyWWdIWTlCOFNPaHBzekh6TEdnRkFpV0dxelVpSEdZMnox?=
 =?utf-8?B?V1hoVGlxcTVNSVliZGJkY3hkWG55ajlrRjZ3cTBSdk95V2U0bDJ4d2VFTGJ3?=
 =?utf-8?B?R09PRGZrVlNXUFpOOUx2U3g4NERRTlVUdEJkeFhSWTdGSXhmSytxakhPR2d6?=
 =?utf-8?B?YjBqeXBBVEtYOVlLTkRMUGowUnJIVXA1VHFrQU56TDFhZFAvL1RoZk0rbUNn?=
 =?utf-8?B?SEJndnJyRTdzTlBsMkJFdUFxVXQrajk3SXp0MmdVVVhVS1I0d2dXUU56R1dn?=
 =?utf-8?B?Mmk2K1ZaQXptNk1ZTUhMeWgzMG9kbUk1RHFXYXF5U2NhRGk2ZHQrNSs1b0xz?=
 =?utf-8?B?TFhJaVVsZjJaOTI2ZSsweDh0cGc0Q2YvZ0t0ZTFVdGhCbHcwOENsZExucUdn?=
 =?utf-8?B?Z3VGaW5ES2w0dGs0SVV1VmJsdmF2RUV6aUl0TndUREJFTzgyV1dFTkN3Sk1E?=
 =?utf-8?B?SGI5NnE3dzM3cE41OHY2Sk9relgxSTEvYjhpOXJtTHh4R0U1M3lCbTVKWTUx?=
 =?utf-8?B?cm55d2ZwOVYxeFZKOFFSbE5aT1R3aFpqcDdOZUVOZElxSjRDdkFpb09vTVhI?=
 =?utf-8?B?Zlg2NFNvYml5T3I1U2RGei9RUHN3WWxma1JnbDY1eFgvb0Z4dFBjRGdiQSsx?=
 =?utf-8?Q?sa3Z1lTEn38=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ym5lQWQrcVhBV2tDQ1FsN1RQdUNHQURCeEpqRDdDbHV5VDZSM2lMUHRmV3hI?=
 =?utf-8?B?SVZ2S1M5NXp1NG9XbVI0cVh2bCtxSE50bDZ5d2ptTHZ6N2lvWDZHeTZTbXdo?=
 =?utf-8?B?QlJScXZBd01ZWlMvOFN1VWRPTlQ1YkZIRFZaNGV5eitFQTVTSlh0Q1Q5ZEQ1?=
 =?utf-8?B?M21OTjJJRFNPMHdyTnlPam9aUHRSeFg4elF2T2VpNmozSHkvWmcwRXBkc094?=
 =?utf-8?B?akxVS3BlQ3hoNm1BUkFuZldWQnlBZDFUL1R4VG8rSURmZ292eVNHQ2Y3MkJY?=
 =?utf-8?B?TnRrd295R1lNd1BSU1BPOFV5UE01dW1adEp2a2JVVWJ0N3ZkdTA3Y091aHhP?=
 =?utf-8?B?cEdFMmhseVE4WUZ3ZEovWmRtTTYzSHFwcVdFbzNVdkRxWTRWQk9DekJtMldo?=
 =?utf-8?B?TGpORVdvbG52VXljcVVSaVdTK0pEaHB0SThGQjQya3lGbVY5MVlzTWt1bll2?=
 =?utf-8?B?ODVhSlRhYXNaVnI2WE0yVkNXaTVYK3djRXdtSElvV1JWRVpkTUM2VHJBdEJW?=
 =?utf-8?B?T09kTUcrZmNmTHhabFQwbDdNSmNPL0ZPaG1GUTRYandyNk5pNUxZcDFMT0dI?=
 =?utf-8?B?czJudHJLMWdlTGE0TjFTLzhCc1kzQXU4TjhBZ2xHMGlnQjFGMHA4R3NYMG51?=
 =?utf-8?B?RlNZZ0tua1k4UXQ3cDdDbXRaKy9KUlRTbWNnc1NMYk1jMnVlUWpZcG1TQXJX?=
 =?utf-8?B?aVhBdzRSUml3enpQV1o4UjUyN2RISWlUMTFEUE5tUWlKbWN1NmdhUXF3YkE1?=
 =?utf-8?B?M1RCNGhlNE5JNi9nb3RoWXRBWVoxUmZYVW5TUnNncnUyV3Q2OGc2UGVjM3Nz?=
 =?utf-8?B?cDUrRTFPTUxhNUVuVnhMZUttaEdrUExVZk5FWGF3QWgzRi9CMHF2R1JzZS9r?=
 =?utf-8?B?aXd2QzhyaGFPb2FXcllXdTJFNkhUMWFUM2lKWDcrVVIvdXcycEtlaTk0Q1FV?=
 =?utf-8?B?d0dNTVpiSE16RFN1SE1INWp4RkpONGYwZXREeUJUdXRoU2NaWTlJUmdNUjBI?=
 =?utf-8?B?Z2FWTWJIMjA4RTVvalZrdTBwUGhQTWVveWtrbndPQXFINGJSV3ZERWlnWGYr?=
 =?utf-8?B?UEpTbGZXaElJdWpOUHY0MUV5dTBwUHJIYUZUVXZjUGExTGdHcFZhR3lhYTRu?=
 =?utf-8?B?RlN5MzdxbE1Kc3g5ZW50NnY2TjE5clA2SzRuMjBFVVNOWnR4UWQvU3hpU0Vn?=
 =?utf-8?B?TDNyeDhjQ2tYazFObnIyWFRIRW1wQ2hLU3JFYTVibzdEQVRxL1NoRGZFcGJa?=
 =?utf-8?B?VnA1ZnRESHVHU1ZGNzZyWWI4Q21KTytaYThDMi90SzFWMG92Z3dyRHk0a2lJ?=
 =?utf-8?B?WW5WeG5uTWsvM2x6ZlhyNk1XQjZpQ29IR1dQNGk4RkpvTDdLMXZuNWFhWWZI?=
 =?utf-8?B?cEgzZjlobWdaRE5TeHVpODc1TWZWQmdMNkJTMXlJbElXN1l4QnlpUTdtbCt3?=
 =?utf-8?B?dlFMN1JqQjdRQmxXaXptbWtzMnFkNVFvY3V0RDlyM0hYUDdHMUVmaXdUaFpI?=
 =?utf-8?B?TCtKMmdGblhpZHRCNXFRT2ZaTE4zRnVSbWpWZFJIMGd1cXN5eUlqeHdVQ1ph?=
 =?utf-8?B?NE9nTUc3ZHlRdFo0ait2WlAzMGVWM0VSd05FMEh5RHJpZ0xwYWZzYzdtNTRv?=
 =?utf-8?B?WEpPQWozdHlLUC9KYUI1aElwZEhlQ1dyN204M0N3VXg4SHRYQWo3SDB2NmJs?=
 =?utf-8?B?MjNIeFdtSXlaVGszbC9ha05xZjFrUTFLVUdxUzM4RUZ1NkVjN212dElvWXNS?=
 =?utf-8?B?d1lTODJTVGZ4QzlxS2MwN1FrUWxIdFlOb0gvR3lDN0RyTjVWNmNPNFFmT090?=
 =?utf-8?B?Nnd4ODFyMkt1VldUZkxIT29YbEFqNWxVWnhrcVN1aHdzRWhCVEUyS3ZtMkM0?=
 =?utf-8?B?MHNkQnBkVDdIMUpNSXM3eTQ5TWV3RDNvOC9hNWk5Mks4K0hrQkM5eWZQVW1j?=
 =?utf-8?B?MUdKR1o5UFRqNDQ3TGtuck95dmRaZy90cTBTam83OVBJZFpvZlNmL3dxenhY?=
 =?utf-8?B?cFRKcXh6VTB2bjNvSzFweVhiS2c1SVZkTURZNWUzSjg1NVNBam12eXpMN01G?=
 =?utf-8?B?TEpRWFViZjB4TGZ6cjFZQUE5SVdRaFJiTWF5bUludk1JRUhWTi80RThPcENJ?=
 =?utf-8?Q?MCxItsbHLUKcxw8MwYcBtcPrc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed98afc1-e2f7-4945-a8dd-08dd7e5b51cb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 09:28:03.7431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DiwUaqn9ettK+S5EIGR8w1s6FuTLKZbpKgd9nUGe7vj1rN6XI1TmpRAjeFFIT/kZaofy5Qdj7/AX3I9T1dek2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6934



On 4/18/2025 2:02 PM, Ingo Molnar wrote:
> 
> * Sandipan Das <sandipan.das@amd.com> wrote:
> 
>> Sandipan Das (5):
>>   perf/x86/amd/uncore: Remove unused member from amd_uncore_ctx
>>   perf/x86/intel/uncore: Use HRTIMER_MODE_HARD for detecting overflows
>>   perf/x86/amd/uncore: Use hrtimer for handling overflows
>>   perf/x86/amd/uncore: Add parameter to configure hrtimer
>>   perf/x86/amd/uncore: Prevent UMC counters from saturating
> 
> Could you please fix your mailer to not mutiliate Cc: lines?
> 

My bad. Will fix this.

> Cc: linux-perf-users@vger.kernel.org
> Cc: peterz@infradead.org
> Cc: mingo@redhat.com
> Cc: acme@kernel.org
> Cc: namhyung@kernel.org
> Cc: mark.rutland@arm.com
> Cc: alexander.shishkin@linux.intel.com
> Cc: jolsa@kernel.org
> Cc: irogers@google.com
> Cc: adrian.hunter@intel.com
> Cc: kan.liang@linux.intel.com
> Cc: tglx@linutronix.de
> Cc: bp@alien8.de
> Cc: dave.hansen@linux.intel.com
> Cc: x86@kernel.org
> Cc: hpa@zytor.com
> Cc: eranian@google.com
> Cc: songliubraving@meta.com
> Cc: ravi.bangoria@amd.com
> Cc: ananth.narayan@amd.com
> 
> All these email addresses have real names, I suppose they weren't just 
> written in in such a fashion?
> 

And this too.
