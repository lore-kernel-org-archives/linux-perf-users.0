Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5552A1FF5FB;
	Mon,  3 Mar 2025 11:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001900; cv=fail; b=CXQRw/AkBQxZxeP+v4Fl0zpOgoqZinutEMV2lcyoweFLxYlWh6JJWkfDAfswcDwCsmiioJ0ExoK/5IT244esWOgGRtkKpv/QS083sJz56gDIdvVnVrXSW+0vgmZaeY8QIW3R9vDP7S1m7i2kKjIc6RnCV213UgU1brS8j/5IMIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001900; c=relaxed/simple;
	bh=es5LyWs7oxVaKV20/F5e7YLk6wPNnkFo9e7W+GO11mQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kVboq09cWEGxMt91zuDvcXry0moVtSwdUVsrs84ORTxr471dvqxzTaU8CyuI1F2ca2We+ubo/iwcFeKQb0Tc4L55OHHwNjYXJwyy/zCy0am1vu77ktqZYGJMvLcuMXol9tKgVtj76ieShiDPDqKSLMeTenSnMWxfxf0rYM+itjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WHmXBAfU; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WHmXBAfU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVockNFJ0eZbr9tOQ4ozXUEUHdDO1qnsebgPl37ZDbwyahInvFxYRNMlyCLpo/dlWgISDQQO2aUQcr228BCh9wvvARcwvBuUI8FPaVqB2YCsKU0hzR6wHbWS2ssS2AMbsAYfApBXfz+AxJjO5N8/ZnI9WGBGfuS8AeCZXZzZl7yfrx7ogsKX3XU5hQrdPEuYVQma855N/LCvfeexFNOA5/XMm7NtwKD6qC45KpWFBLC7lnDFv/ash8S33hnXoKRgC4k0S4NNZ8IyorFwk0vszHGMBJO48emLnuDI/NtjvyOixWOYn+YJaEBF1AcaLSKlIaMM54inTZ+ZUFh/Xw2Xlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G17tZ3DLbfZjvX+8k/EW9YuPxFr/eeKUjfUAz68sdmA=;
 b=Uz72rR1LeBRfkSkK6buIBPiBh/ADn13uoSmTTpabtxmyzo/nHpbn2Y5HeubJS/bfU1ZjxUH82R54MMOIHCAQZKYPC75OxGM5dmzktGwfvYXg7BlpHwyIfH1PkQjRDvpZzN5pzVUqolMrblnUK6r8AcOSzpC6nKXtlZRzRW3vlh6eQsb6t5u/3cIz3UakRzJYGwdn6yVw7hFvr/WOqUymeJZO+2zoBbObH7qcc2AurS/3oSL80+bB/sdsi/BKoL45BEDa7+4Cp+3yjErcmd8rh4f5gt6jajlBi9twDx/tA4+TOkj0bLHTw4KXvE8iDmuVoaDzC8HNO7MSvnEU/jw4Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G17tZ3DLbfZjvX+8k/EW9YuPxFr/eeKUjfUAz68sdmA=;
 b=WHmXBAfU1l8lP1fFL2LfEfcPCi98J8BvK8hhTAkMYUkuWjP5fx6ycfpheyXlKRFfExZGH0YLV891vXNk/jO7EY7eKt2FzuD+NRWgLaBaDYpNxjGwu8hSugxePX9Pyw4OO9U4OnLLN8G7Txwi0RHSPF7Kh7mguJFgVlDLjmFStrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13)
 by LV2PR12MB5822.namprd12.prod.outlook.com (2603:10b6:408:179::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 11:38:13 +0000
Received: from IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::c819:8fc0:6563:aadf]) by IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::c819:8fc0:6563:aadf%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 11:38:13 +0000
Message-ID: <7c3b4623-45ea-4340-ac47-334071c1d15f@amd.com>
Date: Mon, 3 Mar 2025 17:08:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] x86/cpufeatures: Generate a feature mask header
 based on build config
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, will@kernel.org,
 peterz@infradead.org, yury.norov@gmail.com, akpm@linux-foundation.org,
 acme@kernel.org, namhyung@kernel.org, brgerst@gmail.com,
 andrew.cooper3@citrix.com, nik.borisov@suse.com
References: <20250228082338.73859-1-xin@zytor.com>
 <20250228082338.73859-4-xin@zytor.com>
Content-Language: en-US
From: "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <20250228082338.73859-4-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF00000184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::4a) To IA1PR12MB6460.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6460:EE_|LV2PR12MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d40947a-7284-4f52-5fe2-08dd5a47e1d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zi9odi9GTnJGd2dvMTh0M0g4a2hIYTBjTFVoS3NFRDZSYnJLUDVpaS9iZWZD?=
 =?utf-8?B?VXk4bkFXN1dPbzZxdGpIRGFkNStJejF3L1Z2QW5ySEZFWnc2bFpjWXZUOFFB?=
 =?utf-8?B?MDZvenlheGdmaDNRdzNpSzdYSUVMcmRzcXhFQWlaallIUlJYV1BHbU5nbTZR?=
 =?utf-8?B?c0IybmZTWitaUWlmdFlRUzBHM3YzMUFBakdpYjdkVDN4TFE1MUpyS2drOWZR?=
 =?utf-8?B?OGJxUlZkZnBZMWJPT0xKVkg5b2xTNjMwMlFMcjA2Vk41SmV4d3A4UEg1aGFX?=
 =?utf-8?B?TUpzSmZYZSt5UG91eWRZZlZhTFVwVWlVM2pUOWRSVlk5cVpIcDkwU3grM3FX?=
 =?utf-8?B?dkp6QllTZmhWTFpGUUpIeG14d2llZE5wOFlKeTJESmZRZVg4RFprVDE4Um9r?=
 =?utf-8?B?SWs0aFB5TFNMUjhwcWF3aWF2OG5hVCtqUmt1dm9sMzREUmVzWlRYMWQ3eDVX?=
 =?utf-8?B?Y21Qc3V2dFR0bzZHRDExTk1XcEx0TU1KODl2UXFZNUU4aWMrRndnZS9NVktu?=
 =?utf-8?B?YXBMdk5SbUE5c2w4QWY1RTNUdzVObG5CRFFLYW0vWnE3a3NRWHVsTUpta2hW?=
 =?utf-8?B?YlMvNzgrNFpicThJdDR0VHJaQStzVmUzS0RJZDZmWVRyL2ZvY3FBM25sQnFT?=
 =?utf-8?B?cXlLOUxyMEM0VS9ZMHVEU1BXRU9SQ1BHdm9Ec3ZvZVhUMUQwU0s5WnZWOWdD?=
 =?utf-8?B?Q1JDK05DUnBsM3VLd253T2VZMU90YVFkK0pyU2c2b3Q3aTBLZzJXa21VcTBu?=
 =?utf-8?B?T3FBVGtiR2UySnVvVUlKRFg4YlUwcHdkL2RPQ001TXhQamg0L1lrenh0ait1?=
 =?utf-8?B?OVkyWTlDMys5TlY5MTdVbHFyZ0ZJUVB4WWJXQVYyNWpXalJmcElDUVdRMGNq?=
 =?utf-8?B?dTdYdVY3ZEZ2RnlEWms3dG5SVWthKzV5MC8yMFNXZ084cGVETituR1lmTXRM?=
 =?utf-8?B?ZTVwYWpwUGgrWUxwMlFpZXNxSlNQTFR0SDhDWGZOZitkZUhBVGdMcjB3Vk5n?=
 =?utf-8?B?azMwaE9TNmxGMzdTWkV6cm1SaDRWVWpWMFIwOWVjVktFK0lnUVkzbmw4ekdS?=
 =?utf-8?B?VTF4alNZNzc5SG5Tbi90ZnVrQU4yaUEyVmF3WXVtRkh0RTVqdE9TMlJiRGFn?=
 =?utf-8?B?SVRRN3FQUnU2dFVwWXo3Y1dpdTFUR1lDTUNvc0YraXBNWnRGSDJ2ZlJhRWti?=
 =?utf-8?B?UW5LZWc1dFFCeHNuZzJ4dVVtMENBb3hkNTBJSmU5NjFqRDFtdFlYeDZrT0xS?=
 =?utf-8?B?YUZKRTNSSnpGK281WGQ2RndlWUpCV3lDQTQyWCtnaUJjRFVwWjQydkNGcXp6?=
 =?utf-8?B?eXRqSW40SG9WcldxaWdtd1YxcVlXNG04ekdyTkx6d2t4eFVVbjJnSG0rUUpt?=
 =?utf-8?B?S0NxZFpLMENHSXdaOWJlQlR5SVVjdnZ3RFRNZ2dZS2krRlF5YStmUHhQWW5V?=
 =?utf-8?B?WXgxRnJVNFVtaUYrN2hLK3Vyc2taSDVKZnlIU2g0dERNa25Sem0vcHJ0MUFQ?=
 =?utf-8?B?V29oYWxUdEJqcHZzOVd6Sk5lbitKQStQRkJ5c0ExN3ROaERRZXJDUVFleGdC?=
 =?utf-8?B?WHBIUnZ5Zm9xOWtuVkRlT1JOSjhwaEcvSk1ldkhSWDh5N2RWK2Z2VFdHVjlE?=
 =?utf-8?B?YlVOZjFLUjBUOENCangzTWJxQ1hKYjZONXRiT0ZXVUFxL3pXcXZWNGgrUjBs?=
 =?utf-8?B?R1V2ZExXcEpBOEFhZ3NDOEhDVVU0NEJReVZoZVVwaTlWdSsyUjJ6MklnUkVF?=
 =?utf-8?B?WUhqKzBMQUZNWDd6RFMrNVNaS3BPMDdWMTRkcFpFRDZLejRpMExDUzRidUNJ?=
 =?utf-8?B?dzNMUFFicmdHenJmVFk4d254UmFOOENucUw2SnFSdFFsZ3JGR3hvTmhTNXZ1?=
 =?utf-8?Q?z4q9HMu4FoLVg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6460.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2M2eFRqR0VDQ1NyVzlGVS9KbEQzRlN3Nmd0bUFLY3g4cnp6b3JlMzN0UFk1?=
 =?utf-8?B?QzhlTE0vU2RxYmo1V0VmOFN5eEZwRzBraEh0TFZ1UWZSd2pnUWhaWDBXc2JN?=
 =?utf-8?B?QmtmaU5IMG02MWVFU3pOMFQvL2YybzU3M3M1aXdrMzU3dDk5Z3J1Y29UZHky?=
 =?utf-8?B?SkEwYnd1RENWZTN0YUNOR3dVNjdxbU9BL2ZHYUI2Q09WbkdmRTFRdW9nWmY3?=
 =?utf-8?B?dGZFRURZd0FnN3lHYjBscUk1TUdPOGJTalNOSkVlM2htUDRid1g4bUY5RTYw?=
 =?utf-8?B?N2pYTkdUMFpuU2t1U25kWmlGa0RlZFF1ZktrZGJ5T2FGdDRZRXdtd0VQOURT?=
 =?utf-8?B?RTY5UmJjdy9TVTFTRGFodHV5WDBrRzcrdmx0RXIrd1ZyN1A0VEdzUGxUaVY5?=
 =?utf-8?B?RCtEdG93YkE1aGNHTHBVdjdQZUR6enRUcGJEdHljMktGYUpUVUh6Mmo1eVdQ?=
 =?utf-8?B?eDU0cThKaHY4SnhZd2xwYmo4b28rOU1PQldUY3VHZDNaTHpLS0RzNmdQTlJ2?=
 =?utf-8?B?N1phOXhJNzRZTWxkVWJ5YU1Mb0duVERhTnQxa0hVREFzK2hLcDRYNHFueXBi?=
 =?utf-8?B?ZmQyS05TRHdXQnZickZsNHE0cDlienBSTEJ2WnpoVXdiWklSa1hrSjJvU2d3?=
 =?utf-8?B?VzhlVEt4eTdLc3VrdHcxRmJMZ1F6aFZreDRQT0JnNFk4NnpJS1g3THo2a3lX?=
 =?utf-8?B?YWpKS29wWk9JKzdGcVB4bzFXL3Q1V1NtQnJ0ek9uY29vWUF2bE15NGhYNTRU?=
 =?utf-8?B?dDIvbVUwd1pnVllGOEVTWSs4UFlLU1ErM2pVQmlrYmphWkM1L1R4NE5pc25v?=
 =?utf-8?B?dWVrWnhvaUt1cGR5aUo1YndCZnAxa2xKY1FtUzlIckdFbkY3ckVhUUpBeVc3?=
 =?utf-8?B?WUJzbmQ1TG9yd3REdGYwdGJkWGFlaHo1SzBUdjdvVWQrbnc5eUdGalJDZ091?=
 =?utf-8?B?THQvMFRnRHNxS1BLN2tCUlJyRVN3amlnL0VMcUpHMzNza2JyMldreDY4YzIv?=
 =?utf-8?B?N21IT1MxVmFGSnhvL0IvN0duL0l5S3o4RmdVTHZHK3JKcHEveUFBYlNGS05z?=
 =?utf-8?B?b0pRSjVEcllkZUg4Rm5tQVBxMHFpM0xlMEg0UHpUY3RLQjVjTkpocTJiWUJR?=
 =?utf-8?B?U1l3MzNBcGZlQVlNM2RMN3YvSXNjOVJ3NzZoRC90ODZLQ2N1alhWSHZ3R0d3?=
 =?utf-8?B?YkJpeG1xVEgwV1JOWVk5d2lxaWF2MHI1RmpESm5rdytGazROVEs4TEdVdVkx?=
 =?utf-8?B?ellwY3pUNHhHcGQ1Mmt6aFRMRlZPelFVSlRFVlFCVEtmeVoxZzdjZHNndTRk?=
 =?utf-8?B?V0kvL0dJd2VVbUcyTWdENHlEK3ZpczlrUCtDWlZBUHMrSFNIbjFST1FLRkRi?=
 =?utf-8?B?YVZYSXpmL3BQUFZVamdscVZoNktEMjhZWXpFb3hMNWVla2dCQjArYWNxMGxL?=
 =?utf-8?B?OTgyanBjb3BHNGZRUUNYK2sxaG9aaWFZZGpFRlViZ3NPSUpGVk8xWWRZT3hk?=
 =?utf-8?B?Zmt3NUNIOHhZRWpNTGIyTUFHSGczWlJISXEwdUNIbGF0eGFuMjYrdVBtODRj?=
 =?utf-8?B?SDhiMFUwMnpwTHNXQ2M2VEhab1lZbmRLV08zVm5jSEhPY0dSMkhTVjdoWkU1?=
 =?utf-8?B?T0MzajZ4UFR5RVMzaGEwVWE0cjRQaGlLQnpmcVB5K0NXYWZ4SHVXY0RZbTIy?=
 =?utf-8?B?aTNHVTF2T3VSNmU1R25iUDJDNE1SL3dINzVWaFBFQ0ZzOFQ4RVVIK1FOYncy?=
 =?utf-8?B?NVJTMGVnWG85TUVGMmI3VS9qVFdjU1BXVk81NWR5cG92Zmp2Vjh3TVNLckxD?=
 =?utf-8?B?NVBIOVNMSFZlSVdqVnBCdUtkODFTcTdLVm5pazMwMlI2U1dpZURIbERoOWJv?=
 =?utf-8?B?cEVWdEF2YUN1c1NpQm1TUUFMencyU2pqWHZzSXlsUHpGS2ZBTE4zeStUUmVI?=
 =?utf-8?B?cnZPQzl6dVVBNSttTm9MSFFvdzczVzlVK2I4WUZCVnFOeE9UTVZFZjZ5bFcy?=
 =?utf-8?B?Ty9nTVNDd1F0eXVSZS9zR083ZjBNWVpwYm8zOVp3NmR2eVQyUGoxY081MTFU?=
 =?utf-8?B?dHVFTzRWaXFsbDMrckhsTjFIQWZPNEdpME1Ib1V4eC9zMWw1bUwraDFhdmpt?=
 =?utf-8?Q?c1pIb1cpUjpsd3hueLehLSVfI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d40947a-7284-4f52-5fe2-08dd5a47e1d1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 11:38:13.8541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vAreuqvtcYFGUgCaasmaY/gVh1Vcj8Z27kVM8nKPgme7eAIlgW/WeUpoCwSs3NeiriIEh6Ibd3Jge2drikzlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5822

On 2/28/2025 1:53 PM, Xin Li (Intel) wrote:
> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
> 
> Introduce an AWK script to auto-generate a header with required and
> disabled feature masks based on <asm/cpufeatures.h> and current build
> config. Thus for any CPU feature with a build config, e.g., X86_FRED,
> simply add
> 
> config X86_DISABLED_FEATURE_FRED
> 	def_bool y
> 	depends on !X86_FRED
> 
> to arch/x86/Kconfig.cpufeatures, instead of adding a conditional CPU
> feature disable flag, e.g., DISABLE_FRED.
> 
> Lastly the generated required and disabled feature masks will be added
> to their corresponding feature masks for this particular compile-time
> configuration.
> 
> [ Xin: build integration improvements ]
> 
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> ---
> 
> Change in v6:
> * Make the AWK script work for mawk and BusyBox awk (Borislav Petkov).
> 
> Change in v5:
> * More polishes (Nikolay Borisov).
> 
> Changes in v4:
> * Add a few high-level comments to the AWK script (Nikolay Borisov).
> * Enforce CPU feature mask values to be unsigned.
> 
> Changes in v3:
> * Remove AWK code that generates extra debugging comments (Brian Gerst).
> * Move SSE_MASK to verify_cpu.S, the only place it is used (Brian Gerst).
> 
> Change in v2:
> * Remove code generating unused macros {REQUIRED,DISABLED}_FEATURE(x)
>    to tell if a CPU feature, e.g., X86_FEATURE_FRED, is a required or
>    disabled feature for this particular compile-time configuration.
> ---
>   arch/x86/Makefile                  | 17 ++++++-
>   arch/x86/boot/cpucheck.c           |  3 +-
>   arch/x86/boot/cpuflags.c           |  1 -
>   arch/x86/boot/mkcpustr.c           |  3 +-
>   arch/x86/include/asm/Kbuild        |  1 +
>   arch/x86/include/asm/cpufeature.h  |  1 +
>   arch/x86/include/asm/cpufeatures.h |  8 ---
>   arch/x86/kernel/verify_cpu.S       |  4 ++
>   arch/x86/tools/featuremasks.awk    | 81 ++++++++++++++++++++++++++++++
>   9 files changed, 105 insertions(+), 14 deletions(-)
>   create mode 100755 arch/x86/tools/featuremasks.awk
> 
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 6784129328f6..60583987d320 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -263,9 +263,22 @@ archscripts: scripts_basic
>   	$(Q)$(MAKE) $(build)=arch/x86/tools relocs
>   
>   ###
> -# Syscall table generation
> +# Feature masks header and syscall table generation
>   
> -archheaders:
> +out := arch/x86/include/generated/asm
> +featuremasks_hdr := featuremasks.h
> +featuremasks_awk := $(srctree)/arch/x86/tools/featuremasks.awk
> +cpufeatures_hdr := $(srctree)/arch/x86/include/asm/cpufeatures.h
> +quiet_cmd_gen_featuremasks = GEN     $@
> +      cmd_gen_featuremasks = $(AWK) -f $(featuremasks_awk) $(cpufeatures_hdr) $(KCONFIG_CONFIG) > $@
> +
> +$(out)/$(featuremasks_hdr): $(featuremasks_awk) $(cpufeatures_hdr) $(KCONFIG_CONFIG) FORCE
> +	$(shell mkdir -p $(out))
> +	$(call if_changed,gen_featuremasks)
> +
> +targets += $(out)/$(featuremasks_hdr)
> +
> +archheaders: $(out)/$(featuremasks_hdr)
>   	$(Q)$(MAKE) $(build)=arch/x86/entry/syscalls all
>   
>   ###
> diff --git a/arch/x86/boot/cpucheck.c b/arch/x86/boot/cpucheck.c
> index 0aae4d4ed615..8d03a741d1b2 100644
> --- a/arch/x86/boot/cpucheck.c
> +++ b/arch/x86/boot/cpucheck.c
> @@ -22,10 +22,11 @@
>   # include "boot.h"
>   #endif
>   #include <linux/types.h>
> +#include <asm/featuremasks.h>
>   #include <asm/intel-family.h>
>   #include <asm/processor-flags.h>
> -#include <asm/required-features.h>
>   #include <asm/msr-index.h>
> +
>   #include "string.h"
>   #include "msr.h"
>   
> diff --git a/arch/x86/boot/cpuflags.c b/arch/x86/boot/cpuflags.c
> index d75237ba7ce9..0cabdacb2a2f 100644
> --- a/arch/x86/boot/cpuflags.c
> +++ b/arch/x86/boot/cpuflags.c
> @@ -3,7 +3,6 @@
>   #include "bitops.h"
>   
>   #include <asm/processor-flags.h>
> -#include <asm/required-features.h>
>   #include <asm/msr-index.h>
>   #include "cpuflags.h"
>   
> diff --git a/arch/x86/boot/mkcpustr.c b/arch/x86/boot/mkcpustr.c
> index da0ccc5de538..b90110109675 100644
> --- a/arch/x86/boot/mkcpustr.c
> +++ b/arch/x86/boot/mkcpustr.c
> @@ -12,8 +12,6 @@
>   
>   #include <stdio.h>
>   
> -#include "../include/asm/required-features.h"
> -#include "../include/asm/disabled-features.h"
>   #include "../include/asm/cpufeatures.h"
>   #include "../include/asm/vmxfeatures.h"
>   #include "../kernel/cpu/capflags.c"
> @@ -23,6 +21,7 @@ int main(void)
>   	int i, j;
>   	const char *str;
>   
> +	printf("#include <asm/featuremasks.h>\n\n");
>   	printf("static const char x86_cap_strs[] =\n");
>   
>   	for (i = 0; i < NCAPINTS; i++) {
> diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
> index 58f4ddecc5fa..51022d21003e 100644
> --- a/arch/x86/include/asm/Kbuild
> +++ b/arch/x86/include/asm/Kbuild
> @@ -8,6 +8,7 @@ generated-y += syscalls_x32.h
>   generated-y += unistd_32_ia32.h
>   generated-y += unistd_64_x32.h
>   generated-y += xen-hypercalls.h
> +generated-y += featuremasks.h
>   
>   generic-y += early_ioremap.h
>   generic-y += fprobe.h
> diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
> index de1ad09fe8d7..077a5bbd1cc5 100644
> --- a/arch/x86/include/asm/cpufeature.h
> +++ b/arch/x86/include/asm/cpufeature.h
> @@ -9,6 +9,7 @@
>   #include <asm/asm.h>
>   #include <linux/bitops.h>
>   #include <asm/alternative.h>
> +#include <asm/featuremasks.h>
>   
>   enum cpuid_leafs
>   {
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index c8701abb7752..b9b7329f4ac4 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -2,14 +2,6 @@
>   #ifndef _ASM_X86_CPUFEATURES_H
>   #define _ASM_X86_CPUFEATURES_H
>   
> -#ifndef _ASM_X86_REQUIRED_FEATURES_H
> -#include <asm/required-features.h>
> -#endif
> -
> -#ifndef _ASM_X86_DISABLED_FEATURES_H
> -#include <asm/disabled-features.h>
> -#endif
> -
>   /*
>    * Defines x86 CPU feature bits
>    */
> diff --git a/arch/x86/kernel/verify_cpu.S b/arch/x86/kernel/verify_cpu.S
> index 1258a5872d12..a23a65d5d177 100644
> --- a/arch/x86/kernel/verify_cpu.S
> +++ b/arch/x86/kernel/verify_cpu.S
> @@ -29,8 +29,12 @@
>    */
>   
>   #include <asm/cpufeatures.h>
> +#include <asm/featuremasks.h>
>   #include <asm/msr-index.h>
>   
> +#define SSE_MASK	\
> +	(REQUIRED_MASK0 & ((1<<(X86_FEATURE_XMM & 31)) | (1<<(X86_FEATURE_XMM2 & 31))))
> +
>   SYM_FUNC_START_LOCAL(verify_cpu)
>   	pushf				# Save caller passed flags
>   	push	$0			# Kill any dangerous flags
> diff --git a/arch/x86/tools/featuremasks.awk b/arch/x86/tools/featuremasks.awk
> new file mode 100755
> index 000000000000..fd3e72147157
> --- /dev/null
> +++ b/arch/x86/tools/featuremasks.awk
> @@ -0,0 +1,81 @@
> +#!/usr/bin/awk
> +#
> +# Convert cpufeatures.h to a list of compile-time masks
> +# Note: this blithly assumes that each word has at least one
> +# feature defined in it; if not, something else is wrong!
> +#
> +
> +BEGIN {
> +	printf "#ifndef _ASM_X86_FEATUREMASKS_H\n";
> +	printf "#define _ASM_X86_FEATUREMASKS_H\n\n";
> +
> +	file = 0
> +}
> +
> +FNR == 1 {
> +	++file;
> +
> +	# arch/x86/include/asm/cpufeatures.h
> +	if (file == 1)
> +		FS = "[ \t()*+]+";
> +
> +	# .config
> +	if (file == 2)
> +		FS = "=";
> +}
> +
> +# Create a dictionary of sorts, containing all defined feature bits
> +file == 1 && $1 ~ /^#define$/ && $2 ~ /^X86_FEATURE_/ {
> +	nfeat = $3 * $4 + $5;
> +	feat = $2;
> +	sub(/^X86_FEATURE_/, "", feat);
> +	feats[nfeat] = feat;
> +}
> +file == 1 && $1 ~ /^#define$/ && $2 == "NCAPINTS" {
> +	ncapints = int($3);
> +}
> +
> +# Create a dictionary featstat[REQUIRED|DISABLED, FEATURE_NAME] = on | off
> +file == 2 && $1 ~ /^CONFIG_X86_(REQUIRED|DISABLED)_FEATURE_/ {
> +	on = ($2 == "y");
> +	if (split($1, fs, "CONFIG_X86_|_FEATURE_") == 3)
> +		featstat[fs[2], fs[3]] = on;
> +}
> +
> +END {
> +	sets[1] = "REQUIRED";
> +	sets[2] = "DISABLED";
> +
> +	for (ns in sets) {
> +		s = sets[ns];
> +
> +		printf "/*\n";
> +		printf " * %s features:\n", s;
> +		printf " *\n";
> +		fstr = "";
> +		for (i = 0; i < ncapints; i++) {
> +			mask = 0;
> +			for (j = 0; j < 32; j++) {
> +				feat = feats[i*32 + j];
> +				if (featstat[s, feat]) {
> +					nfstr = fstr " " feat;
> +					if (length(nfstr) > 72) {
> +						printf " *   %s\n", fstr;
> +						nfstr = " " feat;
> +					}
> +					fstr = nfstr;
> +					mask += (2 ^ j);
> +				}
> +			}
> +			masks[i] = mask;
> +		}
> +		printf " *   %s\n */\n", fstr;
> +
> +		for (i = 0; i < ncapints; i++)
> +			printf "#define %s_MASK%d\t0x%08xU\n", s, i, masks[i];
> +
> +		printf "#define %s_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != %d)\n\n", s, ncapints;
> +	}
> +
> +	printf "#endif /* _ASM_X86_FEATUREMASKS_H */\n";
> +}



Building kselftests is regressing with this commit on next-20250303.

# make headers
   HOSTCC  scripts/basic/fixdep
   HOSTCC  scripts/unifdef
   WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
   WRAP    arch/x86/include/generated/uapi/asm/errno.h
   WRAP    arch/x86/include/generated/uapi/asm/fcntl.h
   WRAP    arch/x86/include/generated/uapi/asm/ioctl.h
   WRAP    arch/x86/include/generated/uapi/asm/ioctls.h
   WRAP    arch/x86/include/generated/uapi/asm/ipcbuf.h
   WRAP    arch/x86/include/generated/uapi/asm/param.h
   WRAP    arch/x86/include/generated/uapi/asm/poll.h
   WRAP    arch/x86/include/generated/uapi/asm/resource.h
   WRAP    arch/x86/include/generated/uapi/asm/socket.h
   WRAP    arch/x86/include/generated/uapi/asm/sockios.h
   WRAP    arch/x86/include/generated/uapi/asm/termbits.h
   WRAP    arch/x86/include/generated/uapi/asm/termios.h
   WRAP    arch/x86/include/generated/uapi/asm/types.h
make[1]: *** No rule to make target '.config', needed by 
'arch/x86/include/generated/asm/featuremasks.h'.  Stop.
make: *** [Makefile:251: __sub-make] Error 2

The same used to work fine until next-20250228.

Recreation steps:
1. Clone next-20250303
2. make distclean
3. make headers

Srikanth Aithal <sraithal@amd.com>
