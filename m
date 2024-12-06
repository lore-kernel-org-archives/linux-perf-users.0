Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE28193426;
	Fri,  6 Dec 2024 05:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733462716; cv=fail; b=iSGolZdfe/DaoxliTOBoDbwki8hRiBWL6SKLBhe/ThMxDLeGVwT1Gz9nnql4qvWPRquffLE/Z892sl2aKiihHa31isiWqlJNWqO9PzDemTegKE4yWV56en2NICR0mLdEIvGu5L2PPc0syilF076Im/ngZj1C+VuYKButwV9Vaz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733462716; c=relaxed/simple;
	bh=sxkIOg2Z7NKeT/pq6Q1hQSJZQK1Ff7oVf0WlnOaIXWk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ayUJ63mjYDrz8c9nm/So3BmDFOsB7vv7/olMAiAVfAi+pDVWAw2mD8P8eAnrB77kDpYagrskYbJ51YmY3x+xMSp8PI7zyaSgg0pd11yCAJxp8XB8wqQuvv+6TBCK4du1vDS85jPNMUnm1IJY9DHso3k1Q093wpkeaSiU/e5V4WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZCi4OyOl; arc=fail smtp.client-ip=40.107.93.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZCi4OyOl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myMpHCuULummOYkE/Pq23gxcJtcNOziS6f/HcKimu6nmXt31a2uDUyB68NBxsZ5JQpNy0LTEijafW5WoVnh4cmRq9ANxVsAl+y1oK+4bneX0M2ROWYgUWDVlHGARK8la5d4X6LN1qE/qYOPIhchOHHtSjBWNNZ+0uH6QUAz83GjcGvCw/CWkOZmCkcElxbFD4LhRSBjt2NDm19hWt7VbMtFQ6W1bP3w4h7pfgZ1zjJwrsTwcFYEkR3LG144aQ+uq8kzRv/eJBEoG0hVjgMza30hztmuLU8++bALnejGX6GDhnWgEi6hrAd759puzoaa7qKT+4MpRBKPOCiTFz7/QoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lYCMPZHQaKvn2vjb/P6vtJVQjFbGIYS1CZ18rHfRPg=;
 b=ykqDInYXOlzaBgOu+hjJOMhWQHBhjX28Qrlo1v0HWhXdSf3wKZRWPLPbpHckBRGdkz6F0Edm/ExwxwVB03NEip9JTPcsMYXbuY5/kRDjFDTcnDY6h4jarm9OwurcbxLCLkZEOchR4bLzCjletE2qEWdZ/JikpXG1xt3pznz90xRmnZJJrYTL91cYDCHdmyze2R//7+ulPGkJY0RaimUg/FG5dE+QAjSVQ521ZJlcPXv3DwcSqulhMtUT4hoZK3xqWxAxtgdR1pzV0OsRd1WgvGbFER5VM0KKc5eUHS0k/mkz+926UMjM/fh2XdiGzQDAC4VijiO4p0hvamb3M1FGkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lYCMPZHQaKvn2vjb/P6vtJVQjFbGIYS1CZ18rHfRPg=;
 b=ZCi4OyOlVTAwDnpMo0SDNQk9F8N3yNNkMPn1P3rTgp1BUFW+jvKu1ptfQ1aun8ayBenfWc8QaE4Jgl1liNw6rRLV1rrMseo2ojIi8q1Ftx2xAUE3ojAkIdsm2tfZylDwG5WmXV2BIsfTEN4YuTjgwrAfN3cd5pUNfO6OF+k0EV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 05:25:11 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 05:25:10 +0000
Message-ID: <cf12a0c4-21bd-4568-9dc8-daaa2392bd94@amd.com>
Date: Fri, 6 Dec 2024 10:54:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] perf test amd ibs: Add sample period unit test
To: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org
Cc: acme@kernel.org, eranian@google.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 santosh.shukla@amd.com, ananth.narayan@amd.com, sandipan.das@amd.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20241206051713.991-1-ravi.bangoria@amd.com>
 <20241206051713.991-11-ravi.bangoria@amd.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20241206051713.991-11-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF0000017F.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::4f) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bf9b507-1046-47aa-5a1b-08dd15b65a7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWczYndhMFhqUFlpMkdTZTlFa0tFbXFmeHQ0MHVacGZOQWg0T3BnemllR3FS?=
 =?utf-8?B?NFozc1o4Umgva2lLRk1BeFYvV0JzZWhTVnRmUCtmeFZZQXhISE14TE42RDBH?=
 =?utf-8?B?R0djWjRMWXEwZFdRaTdlLzVYYUdYZ2pOY01ieXJ1dnFqb0wvR2dWYm5qcUwz?=
 =?utf-8?B?M1Vic09FdEdBcytydXFrSGFJaGwxTUxuZ1B4enAva0gyMDQyZ016b29XcVFC?=
 =?utf-8?B?Y0FJUWxML1hwMFY0UERlc3U1TVRGOE5DMnVTT3RLS3BKY0pXL3ArZlJ4QjdL?=
 =?utf-8?B?RGhlMDFzN3pncU5ZVVlpYzRBeXVUY0t4R1E0YUM2RTlIOGMwTStlQUV0blpD?=
 =?utf-8?B?UUlreHA5YjIzN25zNDMrZnUxVExpdHE0UEV3RnUrd04vTjJNUFk4c0o2SE5s?=
 =?utf-8?B?akUxL3FPRlgxMGhib1JrempVQmJHWXA5Z2ZCcUNPKzh6c2U1SzBwRkJvQ3Bz?=
 =?utf-8?B?bDZGODAyOWtVZGcvNmsxeSs2ZUlVK0lCZ0dFN2wreFhLa1IxTEdKZGF3cThx?=
 =?utf-8?B?aTdSVHVoNkczTytWWlRndGZSakFhRzVhWU5hOXNKeUpJd2lBaHVhbXU0V0RS?=
 =?utf-8?B?REZ2MFZUME5DWVg3cGQwZTVzTGRFK29KMy9OeG5WdTBrVENiTTBkQm04UDBV?=
 =?utf-8?B?dXZ2R1Jva3RWMDVoTVFqTmx3WnpZcC93bHRqQXBLUFo4MHRMKzIwTFNmMXcv?=
 =?utf-8?B?QVJudTUwOWNwc2t6c0JhOWg2cFpCWGtEb0V5em5wSlpIc1E4d0FkRmZ3dWpW?=
 =?utf-8?B?TU14aUxxeGRQUEoxOUxEamVoaW1aV0NTN1MvdTZtQVdOcVMxN2lFdmltaW5N?=
 =?utf-8?B?YWhxd25TL085c0plNDhKb3RJMGZWNGd6Q294ZDlHZFZSczJuZlkyN09UbkxQ?=
 =?utf-8?B?clI1bWlOS0I5UjM0VlR2QlprdS90UDZ4a2ZrdEdRZTlheCtoYU04Z091OERS?=
 =?utf-8?B?RGJhOG5EaW1ZUGdkQjNDNmI0WUYvMWNDdTA3SGhBaFFoVWFOZEJsK1JsQjV5?=
 =?utf-8?B?Vm5uQkd6RHJoeEc4bGhhZy8xZkRJUFJjQmFMTG1nQXB2UHJrQWhCWFlUVlJQ?=
 =?utf-8?B?b2lDMmpXOEhISjVGUUlYN2haNXFhS3BWVmpBcWNXQ3BWNmJmN05oSUMrUUs2?=
 =?utf-8?B?cVFkT1pJa2hLSE9RdXRqem4yejh6RHZabDhTODFTWm9kMnZIUEFRWGd5MlI4?=
 =?utf-8?B?ZGkxRHU5bWhscnFjdHBqZERnTjZ0bkxwNnJyVExUbnNXcCt1dllzaHo5OGhl?=
 =?utf-8?B?MnFFelNyTkRoT1ZZTE5vMTgrS01EZGVmUWl0cDBwQzd2WXdFOW1Nd1I1NDlm?=
 =?utf-8?B?aGxzUjltU0V6ZHJwVEtKcXRvQXNLQTVmdm5tVVlBYkEvaUE4THc3RTUzS0xm?=
 =?utf-8?B?L0hRNVlncUo3U1grWVpuWE05dzJsQ3F3b3VqVUNZc3RDNThscUtZd0c0Skg0?=
 =?utf-8?B?MUlKVlY2bkdOWUt6SDBGa2FJL1pmdS9KRll6Z3ltRU05aThucS9rVGJKcnBJ?=
 =?utf-8?B?NzczS0dYZ0NBb3h1ZVVzd0dBQTY0VEZ1VkdHRUJWbUFBVkgzWlRGbElmSTdN?=
 =?utf-8?B?dHpqYnVVeWd1M2tuR2NrdXh3MFcyMVVEaGN5OFFzajhXMnR1NVR6YnhCaVhS?=
 =?utf-8?B?NEg3Tm9NRGVVblp5WityS2NrMWF5bXM0R2VmVXlVanZPTkpyUHE1bXRJUjI1?=
 =?utf-8?B?TEFUVmhUS3ZNNkxRSlhiTWFIUGJseVJQWXc4NnE2NksrQ0lBS09jMzRIcU8r?=
 =?utf-8?B?bFgwQnpxRGlza3lneEpsdjJYcmptWm5FN0x3ZTA5QUtxd2NYWWV4VmRlNUFx?=
 =?utf-8?B?TE9DQkVMRkFtRkh2RTljdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGdIaExlMTdBZmp6a1cwVXFxeWZtY3NVcHFIcllzd2JMaHFtRENPaHovbHpJ?=
 =?utf-8?B?UlRKbkZneUZBMncxTFNWRFlKcExaT2ZHdzY1RjhacTFrOStBT05lbGNtQTJH?=
 =?utf-8?B?SmNyTmhoSUdmR0pKUk5aS1FiYXI3ZHJhS1VROVRjdmN0YUtoOEp0TndkSTZ2?=
 =?utf-8?B?Qy9EdDVrYU81R1hKa2JZVTJ1UDQ5MEJET3hDTE9McTlpR2hjWHVOaDdWbVFi?=
 =?utf-8?B?SHNtaXNXS05LQTNJazQvUjZQbDlCUjNzditpbi9Hdkx5ZmEyOTc3Q1dJUkFr?=
 =?utf-8?B?N3hwVUE5bEJjclBVOU1pTldlMWs5bHUwa3orcy9mZHhreGFpd1pHSTJVemta?=
 =?utf-8?B?M2MxVWlYcmpOQlU1ckc2OVNCZmxSc0VtRGlhcjlGZFp5SmtPZE9wdHdyUzQw?=
 =?utf-8?B?ZENzL1BuSDFBdzI4aG5KMFVwYVBHYnJ2MW1VWEUxNkpqaFd0RmNYODFZNkx0?=
 =?utf-8?B?bVBRRGhiaTJYb1NkdTlra3NPN2hKRDloQkh4UC94N2dvVFNEMVJMWkVnblFG?=
 =?utf-8?B?UkhUQkZxTDJoemFWckJTS20xWG9DSE0rVUExVG9zVUpyVzUrY05XemdCMmJl?=
 =?utf-8?B?TUpoczFsZzBxdHJidzNkK3VuTWZCNTByaTZQMXBHb2prZzlzekVuUVAyK0FI?=
 =?utf-8?B?OWRVRmZGOUVRT2dwQjJreGJlb3U1NWhRQTh4b3hTazUraVo1bWZPdGowNDl1?=
 =?utf-8?B?Q2FyU1FZWGFuV0tvSlFUYjUvSmdxVURYNjRNNVdyQk1KTjJobHJOcERxSXJz?=
 =?utf-8?B?SGgyYktMU0d6RFMyQVBzejdodzRvSDdISGRqcjNFR1ZGc0wzeFVWdWVadHRs?=
 =?utf-8?B?SDNKVFFSbkRXSnhKOWhnUHpqRTNhY1hZUS9UN1A1czJLQmdiWnFYWlpWZzFs?=
 =?utf-8?B?ZlJ3eDBGa0djdGtuYldtbXdBYkpoa01FZ2FtT2doS3lDZk1GR2ZYb2FMOVBQ?=
 =?utf-8?B?RDkrbThaaStXcG9vUWtxajhvRDA5V3A2aGgrTEM5QXpsTlVPVG1ZR0ZyZ3E0?=
 =?utf-8?B?MmpmZ0l4UjFRbGpmMFNCK1lPbUZuOUpRSm1wTG1iZzljMytaMUx0NDZJY0ND?=
 =?utf-8?B?MjFmYmhXVkFPdjQzalJnbFA2MnErRE05M2JDUjVtbUdyVVkrQnVJZS9vTnFx?=
 =?utf-8?B?a0NacVkwU05TVHdNcGlSWUtRMHdoUW9iQzUxZTZZTWRaR0pXbHJKQXpUdU9z?=
 =?utf-8?B?aUV6NU5tWGl4VTM0anZXNnJXbytYUGxZNTQwallWOEJtby9UOG1heU5acUg1?=
 =?utf-8?B?eS9MOVdtRGVuWTlkRy9NcVA3akh3UTMxWTBqdXo1dm1TaFU2WVpoNXR5MEQ3?=
 =?utf-8?B?SzIvWjBUby9uTEJhNXBxWnFnak82ZCtYR3dHUDJ5M2UwRTBBemxnZys1bTMw?=
 =?utf-8?B?d01Xb1IvZmIxaFdPV1V1WmpPTVdCazF2eDlNV3NkY1ZCRG5ZV2RjQnhnQXNF?=
 =?utf-8?B?SGlHc3Y0a1FHRkw2QlZTaGFKRERlSHlzeERiQ2J2Rk5ZdmpQZGdOMzVRQS9D?=
 =?utf-8?B?ZXRQOGhsQkpSMDFVVytlZlVscWRKbzk4TUhSOTVKL2pxR3pva1NWNGNUOVp1?=
 =?utf-8?B?TndGKzRBcitJMC9PZGtUMXJYRUVuQVZRLy9xNGdxY29Hc29veXVoQVd1VXVD?=
 =?utf-8?B?WGQxdjVPbDMvdzZxME8xTkcwVkdnd3FIWFVUMkQ3WTFBUW5idzNQdEd2R21M?=
 =?utf-8?B?VVArMThmVTdmSnhDa0crdThmYXRyemhDUmFmOHIxVytFNXd6UlY3aGVPcG1E?=
 =?utf-8?B?UVo0aHdEUjBidFhaSXV2dGdjUC93Y1dRNnF1cWgvV1BkZTNlR0RtV3lueW0r?=
 =?utf-8?B?VjRFdVY4WG5QMkpEZERINFlnR2p5VlJGSUpscUo4NVdvQk5aMFZzKzdPOXBK?=
 =?utf-8?B?MmFkaUNwdmEzZjAySXhQOHl1RVc0aUVuNkxhaktQYXRnTVQvMDhHclc1dXJk?=
 =?utf-8?B?ZFdXaGdteHN4eXJqMzdDZVE2Y2RsaStFVDlONGVMT0RhaEp5MEkwUGl0dmZa?=
 =?utf-8?B?UTdXMHdhVEs2Q1B6NUFjSW53cEFZYmxGa3Y0UlRDNFBjTmhBdkt6blI2WjlE?=
 =?utf-8?B?STZZWGQwTzYyZnJvMEx0M1Y4UVlGYVAwaFd3aW9PN2JzM1ZibUNIYXZtRDh2?=
 =?utf-8?Q?C1BJw/ts5U2dTWFMHkXp3UIpr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf9b507-1046-47aa-5a1b-08dd15b65a7f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 05:25:10.6869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vcnXx6pCxADQwGobiugjRaoaWFcM1Vxwm0O7XgC7vCx4BasUzDvTGsQMfVbNC0dkw0sB4GyFgpd+AGW2z5sCrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086

On 06-Dec-24 10:47 AM, Ravi Bangoria wrote:
> IBS Fetch and IBS Op pmus has various constraints on supported sample
> periods. Add perf unit tests to test those.
> 
> Running it in parallel with other tests causes intermittent failures.
> Mark it exclusive to force it to run sequentially.

The verbose mode of unit test is quite exhaustive so I've not added it
in the commit description. Here is the sample output on a Zen5 machine:

Without patches:

  $ sudo ./perf test -vv 112
   75: AMD IBS sample period:
  --- start ---
  test child forked, pid 7368
  Using CPUID AuthenticAMD-26-2-1
  
  IBS config tests:
  -----------------
  Fetch PMU tests:
  0xffff            : Ok   (nr samples: 1224)
  0x1000            : Ok   (nr samples: 19866)
  0xff              : Ok   (nr samples: 40738)
  0x1               : Ok   (nr samples: 40945)
  0x0               : Ok
  0x10000           : Ok
  Op PMU tests:
  0x0               : Ok
  0x1               : Fail
  0x8               : Fail
  0x9               : Ok   (nr samples: 40543)
  0xf               : Ok   (nr samples: 40543)
  0x1000            : Ok   (nr samples: 20267)
  0xffff            : Ok   (nr samples: 1289)
  0x10000           : Ok
  0x100000          : Fail (nr samples: 17)
  0xf00000          : Fail (nr samples: 1)
  0xf0ffff          : Fail (nr samples: 1)
  0x1f0ffff         : Fail (nr samples: 1)
  0x7f0ffff         : Fail (nr samples: 0)
  0x8f0ffff         : Ok
  0x17f0ffff        : Ok
  
  IBS sample period constraint tests:
  -----------------------------------
  Fetch PMU test:
  freq 0, sample_freq       0: Ok
  freq 0, sample_freq       1: Fail
  freq 0, sample_freq      15: Fail
  freq 0, sample_freq      16: Ok   (nr samples: 1604)
  freq 0, sample_freq      17: Ok   (nr samples: 1604)
  freq 0, sample_freq     143: Ok   (nr samples: 1232)
  freq 0, sample_freq     144: Ok   (nr samples: 1274)
  freq 0, sample_freq     145: Ok   (nr samples: 1241)
  freq 0, sample_freq    1234: Ok   (nr samples: 1261)
  freq 0, sample_freq   65520: Ok   (nr samples: 2660)
  freq 0, sample_freq   65535: Ok   (nr samples: 2635)
  freq 0, sample_freq   65552: Ok   (nr samples: 2633)
  freq 0, sample_freq 8388607: Ok   (nr samples: 31)
  freq 1, sample_freq       0: Ok
  freq 1, sample_freq       1: Ok   (nr samples: 4)
  freq 1, sample_freq      15: Ok   (nr samples: 4)
  freq 1, sample_freq      16: Ok   (nr samples: 4)
  freq 1, sample_freq      17: Ok   (nr samples: 4)
  freq 1, sample_freq     143: Ok   (nr samples: 5)
  freq 1, sample_freq     144: Ok   (nr samples: 5)
  freq 1, sample_freq     145: Ok   (nr samples: 5)
  freq 1, sample_freq    1234: Ok   (nr samples: 8)
  freq 1, sample_freq   65520: Ok   (nr samples: 541)
  freq 1, sample_freq   65535: Ok   (nr samples: 622)
  freq 1, sample_freq   65552: Ok   (nr samples: 720)
  freq 1, sample_freq 8388607: Ok
  Op PMU test:
  freq 0, sample_freq       0: Ok
  freq 0, sample_freq       1: Fail
  freq 0, sample_freq      15: Fail
  freq 0, sample_freq      16: Fail
  freq 0, sample_freq      17: Fail
  freq 0, sample_freq     143: Fail
  freq 0, sample_freq     144: Ok   (nr samples: 2005)
  freq 0, sample_freq     145: Ok   (nr samples: 1604)
  freq 0, sample_freq    1234: Ok   (nr samples: 1604)
  freq 0, sample_freq   65520: Ok   (nr samples: 2547)
  freq 0, sample_freq   65535: Ok   (nr samples: 2532)
  freq 0, sample_freq   65552: Ok   (nr samples: 2469)
  freq 0, sample_freq 8388607: Ok   (nr samples: 30)
  freq 1, sample_freq       0: Ok
  freq 1, sample_freq       1: Fail (nr samples: 4)
  freq 1, sample_freq      15: Fail (nr samples: 4)
  freq 1, sample_freq      16: Fail (nr samples: 4)
  freq 1, sample_freq      17: Fail (nr samples: 4)
  freq 1, sample_freq     143: Fail (nr samples: 5)
  freq 1, sample_freq     144: Fail (nr samples: 5)
  freq 1, sample_freq     145: Fail (nr samples: 5)
  freq 1, sample_freq    1234: Fail (nr samples: 6)
  freq 1, sample_freq   65520: Fail (nr samples: 602)
  freq 1, sample_freq   65535: Fail (nr samples: 618)
  freq 1, sample_freq   65552: Fail (nr samples: 622)
  freq 1, sample_freq 8388607: Ok
  
  IBS ioctl() tests:
  ------------------
  Fetch PMU tests
  ioctl(period = 0x0      ): Ok
  ioctl(period = 0x1      ): Fail
  ioctl(period = 0xf      ): Fail
  ioctl(period = 0x10     ): Ok
  ioctl(period = 0x11     ): Fail
  ioctl(period = 0x1f     ): Fail
  ioctl(period = 0x20     ): Ok
  ioctl(period = 0x80     ): Ok
  ioctl(period = 0x8f     ): Fail
  ioctl(period = 0x90     ): Ok
  ioctl(period = 0x91     ): Fail
  ioctl(period = 0x100    ): Ok
  ioctl(period = 0xfff0   ): Ok
  ioctl(period = 0xffff   ): Fail
  ioctl(period = 0x10000  ): Ok
  ioctl(period = 0x1fff0  ): Ok
  ioctl(period = 0x1fff5  ): Fail
  ioctl(freq   = 0x0      ): Ok
  ioctl(freq   = 0x1      ): Ok
  ioctl(freq   = 0xf      ): Ok
  ioctl(freq   = 0x10     ): Ok
  ioctl(freq   = 0x11     ): Ok
  ioctl(freq   = 0x1f     ): Ok
  ioctl(freq   = 0x20     ): Ok
  ioctl(freq   = 0x80     ): Ok
  ioctl(freq   = 0x8f     ): Ok
  ioctl(freq   = 0x90     ): Ok
  ioctl(freq   = 0x91     ): Ok
  ioctl(freq   = 0x100    ): Ok
  Op PMU tests
  ioctl(period = 0x0      ): Ok
  ioctl(period = 0x1      ): Fail
  ioctl(period = 0xf      ): Fail
  ioctl(period = 0x10     ): Fail
  ioctl(period = 0x11     ): Fail
  ioctl(period = 0x1f     ): Fail
  ioctl(period = 0x20     ): Fail
  ioctl(period = 0x80     ): Fail
  ioctl(period = 0x8f     ): Fail
  ioctl(period = 0x90     ): Ok
  ioctl(period = 0x91     ): Fail
  ioctl(period = 0x100    ): Ok
  ioctl(period = 0xfff0   ): Ok
  ioctl(period = 0xffff   ): Fail
  ioctl(period = 0x10000  ): Ok
  ioctl(period = 0x1fff0  ): Ok
  ioctl(period = 0x1fff5  ): Fail
  ioctl(freq   = 0x0      ): Ok
  ioctl(freq   = 0x1      ): Ok
  ioctl(freq   = 0xf      ): Ok
  ioctl(freq   = 0x10     ): Ok
  ioctl(freq   = 0x11     ): Ok
  ioctl(freq   = 0x1f     ): Ok
  ioctl(freq   = 0x20     ): Ok
  ioctl(freq   = 0x80     ): Ok
  ioctl(freq   = 0x8f     ): Ok
  ioctl(freq   = 0x90     ): Ok
  ioctl(freq   = 0x91     ): Ok
  ioctl(freq   = 0x100    ): Ok
  
  IBS freq (negative) tests:
  --------------------------
  freq 1, sample_freq 200000: Fail
  
  IBS L3MissOnly test: (takes a while)
  --------------------
  Fetch L3MissOnly: Fail (nr_samples: 1159)
  Op L3MissOnly:    Ok   (nr_samples: 1205)
  ---- end(-1) ----
   75: AMD IBS sample period                                           : FAILED!


With patches:

  $ sudo ./perf test -vv 112
  112: AMD IBS sample period:
  --- start ---
  test child forked, pid 44042
  Using CPUID AuthenticAMD-26-2-1
  
  IBS config tests:
  -----------------
  Fetch PMU tests:
  0xffff            : Ok   (nr samples: 1278)
  0x1000            : Ok   (nr samples: 20129)
  0xff              : Ok   (nr samples: 40529)
  0x1               : Ok   (nr samples: 40443)
  0x0               : Ok
  0x10000           : Ok
  Op PMU tests:
  0x0               : Ok
  0x1               : Ok
  0x8               : Ok
  0x9               : Ok   (nr samples: 40443)
  0xf               : Ok   (nr samples: 40761)
  0x1000            : Ok   (nr samples: 20808)
  0xffff            : Ok   (nr samples: 1261)
  0x10000           : Ok
  0x100000          : Ok   (nr samples: 1276)
  0xf00000          : Ok   (nr samples: 87)
  0xf0ffff          : Ok   (nr samples: 77)
  0x1f0ffff         : Ok   (nr samples: 39)
  0x7f0ffff         : Ok   (nr samples: 8)
  0x8f0ffff         : Ok
  0x17f0ffff        : Ok
  
  IBS sample period constraint tests:
  -----------------------------------
  Fetch PMU test:
  freq 0, sample_freq       0: Ok
  freq 0, sample_freq       1: Ok
  freq 0, sample_freq      15: Ok
  freq 0, sample_freq      16: Ok   (nr samples: 1272)
  freq 0, sample_freq      17: Ok   (nr samples: 1272)
  freq 0, sample_freq     143: Ok   (nr samples: 1590)
  freq 0, sample_freq     144: Ok   (nr samples: 1272)
  freq 0, sample_freq     145: Ok   (nr samples: 1272)
  freq 0, sample_freq    1234: Ok   (nr samples: 1272)
  freq 0, sample_freq    4103: Ok   (nr samples: 1272)
  freq 0, sample_freq   65520: Ok   (nr samples: 2530)
  freq 0, sample_freq   65535: Ok   (nr samples: 2339)
  freq 0, sample_freq   65552: Ok   (nr samples: 2546)
  freq 0, sample_freq 8388607: Ok   (nr samples: 30)
  freq 1, sample_freq       0: Ok
  freq 1, sample_freq       1: Ok   (nr samples: 4)
  freq 1, sample_freq      15: Ok   (nr samples: 4)
  freq 1, sample_freq      16: Ok   (nr samples: 4)
  freq 1, sample_freq      17: Ok   (nr samples: 4)
  freq 1, sample_freq     143: Ok   (nr samples: 5)
  freq 1, sample_freq     144: Ok   (nr samples: 5)
  freq 1, sample_freq     145: Ok   (nr samples: 5)
  freq 1, sample_freq    1234: Ok   (nr samples: 9)
  freq 1, sample_freq    4103: Ok   (nr samples: 36)
  freq 1, sample_freq   65520: Ok   (nr samples: 954)
  freq 1, sample_freq   65535: Ok   (nr samples: 1590)
  freq 1, sample_freq   65552: Ok   (nr samples: 1272)
  freq 1, sample_freq 8388607: Ok
  Op PMU test:
  freq 0, sample_freq       0: Ok
  freq 0, sample_freq       1: Ok
  freq 0, sample_freq      15: Ok
  freq 0, sample_freq      16: Ok
  freq 0, sample_freq      17: Ok
  freq 0, sample_freq     143: Ok
  freq 0, sample_freq     144: Ok   (nr samples: 1272)
  freq 0, sample_freq     145: Ok   (nr samples: 1272)
  freq 0, sample_freq    1234: Ok   (nr samples: 1272)
  freq 0, sample_freq    4103: Ok   (nr samples: 1272)
  freq 0, sample_freq   65520: Ok   (nr samples: 2599)
  freq 0, sample_freq   65535: Ok   (nr samples: 2558)
  freq 0, sample_freq   65552: Ok   (nr samples: 2480)
  freq 0, sample_freq 8388607: Ok   (nr samples: 31)
  freq 1, sample_freq       0: Ok
  freq 1, sample_freq       1: Ok   (nr samples: 4)
  freq 1, sample_freq      15: Ok   (nr samples: 4)
  freq 1, sample_freq      16: Ok   (nr samples: 4)
  freq 1, sample_freq      17: Ok   (nr samples: 4)
  freq 1, sample_freq     143: Ok   (nr samples: 5)
  freq 1, sample_freq     144: Ok   (nr samples: 5)
  freq 1, sample_freq     145: Ok   (nr samples: 5)
  freq 1, sample_freq    1234: Ok   (nr samples: 8)
  freq 1, sample_freq    4103: Ok   (nr samples: 30)
  freq 1, sample_freq   65520: Ok   (nr samples: 577)
  freq 1, sample_freq   65535: Ok   (nr samples: 585)
  freq 1, sample_freq   65552: Ok   (nr samples: 577)
  freq 1, sample_freq 8388607: Ok
  
  IBS ioctl() tests:
  ------------------
  Fetch PMU tests
  ioctl(period = 0x0      ): Ok
  ioctl(period = 0x1      ): Ok
  ioctl(period = 0xf      ): Ok
  ioctl(period = 0x10     ): Ok
  ioctl(period = 0x11     ): Ok
  ioctl(period = 0x1f     ): Ok
  ioctl(period = 0x20     ): Ok
  ioctl(period = 0x80     ): Ok
  ioctl(period = 0x8f     ): Ok
  ioctl(period = 0x90     ): Ok
  ioctl(period = 0x91     ): Ok
  ioctl(period = 0x100    ): Ok
  ioctl(period = 0xfff0   ): Ok
  ioctl(period = 0xffff   ): Ok
  ioctl(period = 0x10000  ): Ok
  ioctl(period = 0x1fff0  ): Ok
  ioctl(period = 0x1fff5  ): Ok
  ioctl(freq   = 0x0      ): Ok
  ioctl(freq   = 0x1      ): Ok
  ioctl(freq   = 0xf      ): Ok
  ioctl(freq   = 0x10     ): Ok
  ioctl(freq   = 0x11     ): Ok
  ioctl(freq   = 0x1f     ): Ok
  ioctl(freq   = 0x20     ): Ok
  ioctl(freq   = 0x80     ): Ok
  ioctl(freq   = 0x8f     ): Ok
  ioctl(freq   = 0x90     ): Ok
  ioctl(freq   = 0x91     ): Ok
  ioctl(freq   = 0x100    ): Ok
  Op PMU tests
  ioctl(period = 0x0      ): Ok
  ioctl(period = 0x1      ): Ok
  ioctl(period = 0xf      ): Ok
  ioctl(period = 0x10     ): Ok
  ioctl(period = 0x11     ): Ok
  ioctl(period = 0x1f     ): Ok
  ioctl(period = 0x20     ): Ok
  ioctl(period = 0x80     ): Ok
  ioctl(period = 0x8f     ): Ok
  ioctl(period = 0x90     ): Ok
  ioctl(period = 0x91     ): Ok
  ioctl(period = 0x100    ): Ok
  ioctl(period = 0xfff0   ): Ok
  ioctl(period = 0xffff   ): Ok
  ioctl(period = 0x10000  ): Ok
  ioctl(period = 0x1fff0  ): Ok
  ioctl(period = 0x1fff5  ): Ok
  ioctl(freq   = 0x0      ): Ok
  ioctl(freq   = 0x1      ): Ok
  ioctl(freq   = 0xf      ): Ok
  ioctl(freq   = 0x10     ): Ok
  ioctl(freq   = 0x11     ): Ok
  ioctl(freq   = 0x1f     ): Ok
  ioctl(freq   = 0x20     ): Ok
  ioctl(freq   = 0x80     ): Ok
  ioctl(freq   = 0x8f     ): Ok
  ioctl(freq   = 0x90     ): Ok
  ioctl(freq   = 0x91     ): Ok
  ioctl(freq   = 0x100    ): Ok
  
  IBS freq (negative) tests:
  --------------------------
  freq 1, sample_freq 200000: Ok
  
  IBS L3MissOnly test: (takes a while)
  --------------------
  Fetch L3MissOnly: Ok   (nr_samples: 1408)
  Op L3MissOnly:    Ok   (nr_samples: 1456)
  ---- end(0) ----
  112: AMD IBS sample period                                           : Ok

Thanks,
Ravi
