Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3823A1DB
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jan 2025 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737365926; cv=fail; b=kRSWQpM5sfxnal3Xz+yqAnhM6X3ytLTJa5725TXFz+IOBxkw5wCH/ToEkojprJoQNK8bk3NGX2CJ/K4tw2Jzzq9+u+biuu6aOBrdV9U2n1QAiRyPZzEY3aeMTfAn89Dtm7nHPlP+im7rdHtB6X3rUI+bOqwpn3pco5f+lvTZXCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737365926; c=relaxed/simple;
	bh=DW2yLDYBSMZoKIPqdgHlAcHecgtbtY4KmHqBo9Zq2XE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CTEA/FwParO1H1i7aHXmCt5Hg8+FzdNM9FVXIdSrNhU8A5nMA1iQhmEZOUTWWAATzMalpDX8xjTkT7ipzIQqvSFdsnAqLMO5oLCduxrVujbps1vGPG80ZPgmEadtAEWNZdz1lgqWt5ByAfjCav2Ue/rtrsDeD8vCcI/7NU1OKPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P+TMdXwe; arc=fail smtp.client-ip=40.107.96.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P+TMdXwe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+8wDfZhTsDMfkGuzGW3HWOpGPd9B+2Q2XMfq9zI+WbDWzwjKlsSRX7m1ZL/Vr1QADKJTZrl9StgQIB0GLe/0aZo8xGsPi1tTcgdElNOXPW7Hz1PC+dgdSehP2v49JflOfOjvZQFit36N0ErqYocUPSsJzKUyoaCFkKb63LcISkCE8YgAcjws7OUxG6+Stdt/wwCTG6syRfGo55xjtG14d8qhVjaxZGv5y3619ko8oNcQCvAYtav6wnU1JA1hRUMbeNHa7yfrrZf5L98aNs6rrrm0jFysNMjFmeC64vPGZ5JR3PoQu2zaBoQMyjyd1iNK8LGyFkzAPiAMI7Uqp5dFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOzLvIM8Eit5dkwUOLhEE5DNi0iw0k8xSQWo3wNV9pY=;
 b=MvzoKvZCW89r4yr/ORmrbYnJvhOmLEISiJWaBInroMRQmORk/4R5fe0lgCdun+w9Fh7gfa/iLBMg63q6plga9qRlW45irleIJIrh4Dx2AoYK04D3Ata4K97jTwCgyEvvRQw+Q76CYDjEJu2MugMJJx/pVHDbu5UCdtP+khTXfd9XvFidqd1+FgDgnKKsNmEPEM/y4U4XVaRWHivn4woRAE3NMW8xEDd1tv0dX50qSW9IBSAVRO3LObIeBzJOTS4W31LaL3boLSaAkTxwMAJ5z3T51KsYjO2uidOcmRvhefsLdW2/o4Fq/V9/to28Ntku0EljJDXYe7wLo1ev7b1gVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOzLvIM8Eit5dkwUOLhEE5DNi0iw0k8xSQWo3wNV9pY=;
 b=P+TMdXweNul9uCalU+BPIOTDfT3AbKwnKHw6rXGDHUehnJMLc2g6w0rAlvGT1T9Mj3Khi7RYTXdJ9Ln1hRoWIYS63ncpI2sOq9RAuulpn93j3qtX+Kc+CSC0FtvRIABlDZKS48PTjnzqkNp1jf0mXx/oviyjAEeJWHsBlftbkK0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by LV8PR12MB9205.namprd12.prod.outlook.com (2603:10b6:408:191::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Mon, 20 Jan
 2025 09:38:42 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%5]) with mapi id 15.20.8356.014; Mon, 20 Jan 2025
 09:38:42 +0000
Message-ID: <c484259a-668c-4639-92c0-6f2a2a82a859@amd.com>
Date: Mon, 20 Jan 2025 15:08:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/perf/tests: Update event_groups test to use
 instructions as one of the sibling event for hw type
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
 irogers@google.com, namhyung@kernel.org, linux-perf-users@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, kjain@linux.ibm.com,
 disgoel@linux.vnet.ibm.com, hbathini@linux.ibm.com,
 Tejas Manhas <Tejas.Manhas1@ibm.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250110094620.94976-1-atrajeev@linux.vnet.ibm.com>
 <d4403303-81b5-4f7d-b7b1-1550c37d9e0f@amd.com>
 <7626F28E-7BEC-4374-800F-ABD1D044D092@linux.vnet.ibm.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <7626F28E-7BEC-4374-800F-ABD1D044D092@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0138.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::10) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|LV8PR12MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: c505800a-e020-4e13-54ca-08dd393639d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHRvckpldnFCMWFwalRvdTRnSk1QeGVNTFpHNmtCQThkWVMrZU9wYTBxcXVE?=
 =?utf-8?B?T3JETHR3anJCeTJlMFo1SitYU3o4Ly9iaExzY3BPeXZQb2daMXpPQ1BDMWc1?=
 =?utf-8?B?YmNhc0swUW1rbkt6V1JSN0ZiQkk5TjhmcndJQU42UWVNUTVsamd3bzdOS2o5?=
 =?utf-8?B?d2JhS0NVb2pvaUROcVhKK2ZzOEtBSzhRUEY3aTN6NnVVN2VQYlRRemNQMi9I?=
 =?utf-8?B?ZUlobVovWnF5UTNYaEVqZ0JaTi8wTXN2NjY5eTFhbFV2blE3MGp5eERLVlM3?=
 =?utf-8?B?R0MzdlB3U3d1emQrVC9BaXd3L1BKSldSMFZjMURaVFlHRS9BajVRMUFyUWNI?=
 =?utf-8?B?N2Z0UXUyeks5Tk91ZXN3THIyN1JmMm82MTRlc3VkL21CRUUyalFMemhSZ1Z2?=
 =?utf-8?B?MUhJdHBjMVdRNDFqRHVNMWhHYzM5dXZzR3hYQnh5dXhzWUVuSmcrejI4OUNT?=
 =?utf-8?B?aHpDRStWemRIRnlxQkVaOHBybUdsYjFicEVvNk1kendSaXhkOEt3S0RyYlc3?=
 =?utf-8?B?NVB5M3k3bnZ5RmkxNHFJSlpraHJIRWRKcGxKdGVnU1RScmtlV1FnRWNnNEFJ?=
 =?utf-8?B?M3o5bHFMUFBCWmdTb0NuYXkxQ1k2Q3M4eVBqRjF6YzlvcTRXVDljZzhiWXdu?=
 =?utf-8?B?ZGJOb2wwWlF5dmJ5TnFXc1FJaWlCZjczcUo3Ynl0b3JsK3hCT2pDeFNiSG1h?=
 =?utf-8?B?VlRNZG0zRXhhcW1ZT085ZkFFZEJPTjAyVG8xWlc0YzhYRGY0SHBhaitSMFZt?=
 =?utf-8?B?WTFSd2lJVTJjNjNvQjBzdThhUGhkNWhIYU9rTWtGSzd4cXBCbUZlOVVrZDJu?=
 =?utf-8?B?eDh3TGF0dmc1TTJoc214T3VYNnBoT2hpWlFCZ3lnN2JldEpiMmhCc2lRa3px?=
 =?utf-8?B?Zk0vRVpDV2VlQ3hYNEQvWm9iREh3YmRhMFFEWG5PWHdKd05UVnJKbGJvZHRD?=
 =?utf-8?B?bWJzRXozb2RjZjU5ZXY3U0xiTG8yNXRZQUx5bG5CZjFoazdSK3MzT1YreXFF?=
 =?utf-8?B?Y2JRQnRvZUJ0WVY0SDRhcHpsQkVQRzIrMnlhNS9MM2FiRkNEeU8vNDRRRGdH?=
 =?utf-8?B?aDNScENKdTVtdTM5VVdldzJOZTVHVkQySnpmRVpUSEJtN2orQWFacjh4dWJk?=
 =?utf-8?B?WkdOUlZxNTdwM3dWY1lwdzNjWWYwdnZpc29JSzRTZ2tGaWtHOWhRMFU5Vkh6?=
 =?utf-8?B?WmNMRVhiL1p4VUlqaVFEbStmb29MUS85SmVmWitnc1Iyako2Vk10UzBUQU5V?=
 =?utf-8?B?Uy92MEpuekhGdmtXbEUvOExNdGQreE9rck0vRWU2S2wxR2NZcWVSZFczL0lN?=
 =?utf-8?B?TDNFQllOS1kyOUFSOEZZbm55VWRvaStUUnY1ZHloUERMTmZVNkcyTkJ6T0Z1?=
 =?utf-8?B?NlQvS2IxTGxGaGlTYW9ncFNFbVFZSDA3M2xCdGk2bXlZd3YvZ2RGbVpZMktz?=
 =?utf-8?B?WC9GbXFGa054ekVKR3lzcTRBbit0VFlOSStYSHcxWmRGK0Rka01kalNGOHdT?=
 =?utf-8?B?WWttMno2Qnh1alhNbnFmN1I0TVllaHBoNGx3MXFQYWs3SURRV2xpRWR0cFM4?=
 =?utf-8?B?aUExczZGNWZ3UmFyMzM1UHlxdHROVFlaVjNQcXBTOXFHTW8wcWVhSyt5bVV3?=
 =?utf-8?B?S0k1NnVVQW1BenJHa1kwdmErcUNzWXJQNWozWERDZnVDOXhRUklUM2xOL0xn?=
 =?utf-8?B?bm1UWXFUUXI5WTBUaVMwVklybjJWcU5ONHlTVGQ1N1RFaEp1UDQ4cnJicW1W?=
 =?utf-8?B?VXg1dnlITmFNVzFsZGVDdzRXdjgxQWgyTEJHRythM3IrQWVNVDAwOGlQK0JF?=
 =?utf-8?B?eFlKRVlSMThNUmVSdTA5MXdPOGd6aWlZZ0dMZkVEcndSL213NzhPLzJ6OGNv?=
 =?utf-8?Q?GNqV0xY9OtClf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXVjeWdHOEtFT0FReWxVQ0FIelR3QXhsNU1aMlZpSU14aVFFQzB2N09sQjNj?=
 =?utf-8?B?ek9VVTRBaEZudjdpVGVaaUtQckhmSHFJQ1RlbjQ3cVRoQkhvdmhaejhvRHBk?=
 =?utf-8?B?SHAvK282c3FjZWtIQ29vVUo3RkZrb0lRWXR6OE9kZ01Ka1kwbU1OU3c2Q043?=
 =?utf-8?B?Wkp6bFVLbjNzQW1LTW96WTZlc2o3ZDhJRmRSRlZaYkIyejBEbVJUTUFHTzhH?=
 =?utf-8?B?bjQvSU9VS0JxTzIzQUNLK3FoOEpFR1JRZGt5TzZLbnJCLzNtc1JTRTdlbkhP?=
 =?utf-8?B?alg2TVpYTG4rQXNyM0J0bkhHcGVVRVU4cnhOVUM0K3NsUDdCMlhScGtXbFVJ?=
 =?utf-8?B?dTMrR0YzUmROWWsyczdPSjZKYWFzeTFORlRQeU40VDdYY0pldGlBbFVoOXFN?=
 =?utf-8?B?MFRLM3JHdnBMc2duenpvZ01vOVVxMXJvbHlvdkhySnhHZHNnU3ZCM0lzK3dW?=
 =?utf-8?B?RHhwbURkOFhPdmVZL2o3SVdaQm1lTVNKZEpzVzI3b2lXK0RIcHJmcHA4aXpW?=
 =?utf-8?B?Tlg2bFc0a3pVYXFxUk93U2Q0RHJ2d2xuZTQ5a2I2MkI0UDdaZHZEMDBYSnl0?=
 =?utf-8?B?RnVsd0dGVmZ5bCtXbkdHLzcwTDRPSW5seFVoS1ZZMkRNdWRVUHd3RGJtRW8w?=
 =?utf-8?B?RDAvdHgrWGxNb2c3ZDVaYjZ0UEVIRHVUUUFPQVQ2TlVHbFFJRGJuT1oxcnZX?=
 =?utf-8?B?eHdyalo5Q1AydU53dVA3Wnp0b2ZPTCsxZjlBQlkwQkV4ZVVjL3YzeGJMZ245?=
 =?utf-8?B?TE16ek12c2NwcDMzcEQ4TE5FYzN2SWF4V3lONy9HbGZ0dGZkTXdDOVFQMjBa?=
 =?utf-8?B?Ni9OclQ0cHkwQnVNMG5zNTJRUHVyLzFoZlMwZjdQM1g3aHFKT2JSWVFBditZ?=
 =?utf-8?B?UlYrc1J4NGN4aTFwZXZ5ZVZmSDRDNm9xU0t0TlFFQjNCRUFnZEVWMUcrRDFI?=
 =?utf-8?B?Z2tva0psNGpOREV3cWNuR1VCbkcvaURrQndzUWExdUp4MnNucGU4aTlDaHZy?=
 =?utf-8?B?bFZkL1MvWGJQYzlwMFc1R1lKZjdvWnJxdXYzRGk3TGtYZCtGT1NubWw5aERn?=
 =?utf-8?B?Nk1pRzRDMWtGK1lRSU5ZcDI2MWtWU0w1QSttNnBVWFJxUWdzOXRpVjN6Z0VG?=
 =?utf-8?B?L0JldGNMN1hrelQzUk43MmJldXNMZFBPbUxJZUpKUHFNbFo0TzZBcVB4K3Jz?=
 =?utf-8?B?a05lT1k2Snp5bTEwQy93Sk9mOTJ4cnJjcVZScXJWREV1MVFEaGtTRU83YW1N?=
 =?utf-8?B?WEhZbnVDRGNzZUplRzRJc1FWM1RoRkROcU9FTExwMlRJM0Vtb01iMGhpSHlX?=
 =?utf-8?B?dnBFSzRGckU0cjFxamVmVmxEVEFyOXIvalVVeXVQNXVUWnc1TEV4TG12UVpI?=
 =?utf-8?B?ZTZJejZsR09MS3dBTWs2c2JXaS8wZDBwZTlMTjZqdU51dHRJOXA0MFF2YS9m?=
 =?utf-8?B?eGpMU3ZwSG5GUTdVVlM1S3NBamwySE5EaksrUldEWWRUZi9CbHY0VFNKa0JZ?=
 =?utf-8?B?dUExbHFBb1hyNDJkVmEzbTBrWnJxSVBYUy9jTnhUa295L2duTUxoa2tYWko2?=
 =?utf-8?B?c2w3NmVobnhWNWVieHVyV202cTY0cTgzdUtXQ1k3TElFT1luazh2SFhqcTFI?=
 =?utf-8?B?V2JSVGhsMDY4MVhtZXhxeEI3R0xmNHpnU2NuSE0xZERPNGRjREx5N2JsV3Z1?=
 =?utf-8?B?WkcxWGgwL3F6UWI0R3JuaU8xa0Zaem9BTEQ4QkJEZGZ3ZklZeWUvVjdPMzVI?=
 =?utf-8?B?WllzTVhHL3VlTzhrekE5WFpBZE95WkpaOVdoTlRDQWhJM2hMc3FGYWFFQXVM?=
 =?utf-8?B?S3g1SWVodkhVbDY0ZlE3RWtOeldTMmVQVTU5N2VUSE9oOHlaeVpyNFNGMWlL?=
 =?utf-8?B?U3lQMjlPbDFlWkNpaXMvaGpkS0MzSnNYK05tQmlTL3h1K2xGY3dGa2FMUzNG?=
 =?utf-8?B?aWtFYkdiZFNYSmpJWjRzckhJdER4ZGJTay81UXpsUGtBTEZSYlB3OE05SDcz?=
 =?utf-8?B?ekhYU3dLdXhiTDFXSE5MWDZCbjkxb21KS3BoQm9YSTQyMDYrSGRnNUo2UzZ3?=
 =?utf-8?B?cUVETi8vNUlDTHhaazhtR3Z0UUJiRWlTU2oxOHZybU5HRkhGNmJSNGZ5ckRi?=
 =?utf-8?Q?hxx2EIfdShz9PeSAOW+4SZoGk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c505800a-e020-4e13-54ca-08dd393639d7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 09:38:42.1194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJl3bQC1o2Eyt4Dt3E38wg2toxtWd8NibowIbL78ZL2MZYe4j23UXkvMcE8QIrmMp3ZutoSjAivEVJq0H4DG3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9205

>>> In some of the powerpc platforms, event group testcase fails as below:
>>>
>>>   # perf test -v 'Event groups'
>>>   69: Event groups                                                    :
>>>   --- start ---
>>>   test child forked, pid 9765
>>>   Using CPUID 0x00820200
>>>   Using hv_24x7 for uncore pmu event
>>>   0x0 0x0, 0x0 0x0, 0x0 0x0: Fail
>>>   0x0 0x0, 0x0 0x0, 0x1 0x3: Pass
>>>
>>> The testcase creates various combinations of hw, sw and uncore
>>> PMU events and verify group creation succeeds or fails as expected.
>>> This tests one of the limitation in perf where it doesn't allow
>>> creating a group of events from different hw PMUs.
>>>
>>> The testcase starts a leader event and opens two sibling events.
>>> The combination the fails is three hardware events in a group.
>>> "0x0 0x0, 0x0 0x0, 0x0 0x0: Fail"
>>>
>>> Type zero and config zero which translates to PERF_TYPE_HARDWARE
>>> and PERF_COUNT_HW_CPU_CYCLE. There is event constraint in powerpc
>>> that events using same counter cannot be programmed in a group.
>>> Here there is one alternative event for cycles, hence one leader
>>> and only one sibling event can go in as a group.
>>
>> For power9, cycles seems to map to PM_CYC event:
>>
>>   GENERIC_EVENT_ATTR(cpu-cycles,                  PM_CYC);
>>
>> However, I don't see PM_CYC in power9_event_alternatives[]. Is PM_RUN_CYC
>> and PM_CYC are same?
> 
> Hi Ravi
> 
> They are not the same. PM_CYC count irrespective of the run latch state (idle state)
> whereas PM_RUN_CYC doesn’t do that.
> 
> This test runs fine in power9. The event code for PM_CYC is 
> EVENT(PM_CYC,                                   0x0001e)
> 
> Here it is not specifically meant to be run a particular counter and even if no alternative event is defined, it can pick available counters and go in as a group.

Got it.

> But there are cases like other PMU (which is used in absence of platform specific PMU) , where alternative event is specified to run a particular counter.
> Example: arch/powerpc/perf/generic-compat-pmu.c 
> 
>         EVENT(PM_CYC_ALT,                       0x100f0)
> 	EVENT(PM_CYC,                           0x600f4)
> 
> In this case, we can have only two cycles events to go in a group. So with our testcase events, one leader and only one sibling event
> can go in a group (checked other PMU’s to confirm two is possible). So added this fix to consider instructions as one of the sibling event.
Thanks for the explanation.

Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>

Thanks,
Ravi
