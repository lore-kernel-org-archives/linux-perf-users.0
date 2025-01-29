Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EA433987;
	Wed, 29 Jan 2025 05:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738128861; cv=fail; b=jzf6V6TFt84Uz0ctAsCLJHxeT/9gbvqcqjFCZt9JLA/S0U9cdZNLQgXdcFepr3JsKnnoslXh3Nuk+yIjeL302bWN/dC4gYQREPRazxIsVxYGeegZlKz7xo1ADLxnTEU9I+JfwGYQQvJTEOzWe/NilPEwKETHNmEj5b5fiuv0gs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738128861; c=relaxed/simple;
	bh=J2pfaq8FGyJnmn2aQ8/FfbVLoKJE6N1ieCjeQABXPM0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hw44BA35RUQAPglT3JYn5XIyxq5TU25+IdP69Td/OsKat+PLXYY6INuGW0DJK/3J6Ba3iPJCK1thYwg+NNSNqtbMl561GJ44CmpiamiWBMwChHNV0Y/pAgiQWp+KFW4X4oNEgB9yFMJEH21xJoGkYh4fHml7bq7/vMovY/JmKAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k/3NgVfl; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k/3NgVfl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cajq988Q9NiM/BnXvupanQVSE7Cn9INX98GA6UEDsm9SfVHIf+u4BPXDlz9HKCVo6J/7V+g+DyMxj1RkLSz1afK/Kt3py9hHYkEf/URc8QjSu3J9HsagS1eMeBQePeQCWKQbuCLekkYh/c1jJPmrkcoTZgLA2AWNTNjkeTF9Ia7p0gZXuN13yd5SFIEFm7u9X59yksjLVqVKiq1panZXLi6OO/8W9YRTwexINJQ4myzMjXycBgNSLrMdotJ24VkyFs2bctTOA6eAx/6ySJNKdr0kvWY2dyVsx8U3XB3uLcLiLG4PynzxFJRJ1bJcP2ornF1PdVisHi6WkpWYOGs90g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaTOw7TgRiAlP/j4z2F4gFI3GxeMiMUbsJvZIs8z2f0=;
 b=n+WT7Ku1L1fi2gWocY8JWSjlyjVvlVGnf677L3PsB0KkfYZzRnx8XXcWrYzYSsZ5hTKNMbJfKrW2x9Ra21vn8r5AlNLJGF193yd2zR7oSnF62yVbq0yJf5ATcrIbgOE3fHDBXTbTo8boDFD1wjToGLCxpXDX5YB68//M9ktwBgSagpQKduuzK014zWBAMfitWr63FzXjfMyMHOVavETRmfn103UQVZnjxDWPgjfA+zdGeFw5Ca6cl9DU220wDXehlmOmkJi2HW0RZqi3haHiW+6x5qgDAsDxYwxW4qJ9+X2LjmYeN8ILJTiFGZs/DaVRwy0VDI32ZPEkRiIZkL54Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaTOw7TgRiAlP/j4z2F4gFI3GxeMiMUbsJvZIs8z2f0=;
 b=k/3NgVfljXbgkIvAsDKAjakZezbKDtd6jHRVi9DwLEF7xwTT9N6Y6Brn7DRB2bTuF1mUk7yeqTMuff/IvNzaVsgzfACg7LrU7W5HOsp9Mc6QllsQaDya1mRCGUTXxATA2Lx+fZqxUBqCQV3q6HpCsmLXMT2SBBIEICGXDh8DxrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by CH2PR12MB4072.namprd12.prod.outlook.com (2603:10b6:610:7e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.27; Wed, 29 Jan
 2025 05:34:15 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%7]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 05:34:15 +0000
Message-ID: <e50d57f1-ec74-47cb-9b65-ed64b7d99e2d@amd.com>
Date: Wed, 29 Jan 2025 11:04:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/10] perf/x86/rapl: Add core energy counter support
 for AMD CPUs
To: Koichiro Den <koichiro.den@canonical.com>
Cc: peterz@infradead.org, mingo@redhat.com, rui.zhang@intel.com,
 irogers@google.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.dei, gautham.shenoy@amd.com, kprateek.nayak@amd.com,
 ravi.bangoria@amd.com, x86@kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241115060805.447565-1-Dhananjay.Ugwekar@amd.com>
 <20241115060805.447565-11-Dhananjay.Ugwekar@amd.com>
 <uv7mz6vew2bzgre5jdpmwldxljp5djzmuiksqdcdwipfm4zm7w@ribobcretidk>
 <98f6108a-3a4f-4ad1-8f0a-a03264f7a2d7@amd.com>
 <6ljdgok5zostmu4uxixwh3idgrrtodul4bjvujvwjfda427snu@3vxczriucb6m>
 <1276efa0-488c-448b-adf8-b002c77179f6@amd.com>
 <73fbc810-6666-4997-8f0b-75d2eab8a943@amd.com>
 <o6lskhkmwehl4snhpx6j7zlgv3npz3ckp6npnjizqphtmyh7dn@e4ige74hbqau>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <o6lskhkmwehl4snhpx6j7zlgv3npz3ckp6npnjizqphtmyh7dn@e4ige74hbqau>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0243.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::6) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|CH2PR12MB4072:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ea0abf3-aaea-4ba7-3818-08dd40269170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkVkekQwb3o1dUl3bjdvbXZzWXdLSklKcTBFYWhUdFFwemNGOTM4WHlBZnNm?=
 =?utf-8?B?Uk43Z0gxYnR1TVgvUDFvZGhoQTc4OFpSYTE3cXQxTnY0VUxDbi9iWjdSanIz?=
 =?utf-8?B?NDhNZ1ZsMnZCeS8xcmQvdFhITmliU2hkVzNiWkVkMmpmSzNHTnFaOVhlMXJw?=
 =?utf-8?B?QmhKaTJtak9RL1VSL2xiY0Q5SSt2ZmVpRU1TS0xqNXF3MWdWSk9VdXo1bXQx?=
 =?utf-8?B?Yk52NTA1RTBEYjltM1lHclUrUElwSEhzUEEwUnAvZDVJRCtCY280bXc5RnhO?=
 =?utf-8?B?dmJlWTE5Y2NBeGJxU2tON21JQllZbjE1elJUWTQ5RTBNNXVuOFk2V1l6TlE4?=
 =?utf-8?B?cWZrYi9Xb05WMmF5UTZlbUllbVNLYko3UXJzMzMwbTV6KzJQS2ptWWRLQm5G?=
 =?utf-8?B?cWxqNW41bFFxcjB5RVBHTnE2QzgvN0hQa3gwZmUybVNsbEZoY2k0UTYrUFZW?=
 =?utf-8?B?SGY1YTYyY3RoMDZ6MGFqMktGd0loQnordXRtTjR2STBhRkdnWnFySE5YQWZS?=
 =?utf-8?B?NEJaa2FidXVSR3NNMXBKbEJxR2E4TS92ekMvSk8zZDcwMW5RdDV0bWIxTDY5?=
 =?utf-8?B?cnVoK1pkUyt6R01pb2JHQXZNYWJZeEtEcE8zVFJDdzVydmpaR2o3eHFpeFFO?=
 =?utf-8?B?MDVnWWNkZFFQaVRvemRiYnBKd05paFg1Y09MOEgwQlB2bXRwc3ZRckFBTDBi?=
 =?utf-8?B?My8ya2VDOGVUbkRhdWdyZE5ESzVlTEtWUHd3bE04VjRxUi9yaDZheVpUWVM2?=
 =?utf-8?B?cUo2dkJyaDRFcTJUMVhaQ010eDEyRWQ3dHcwVnlyWlZmMmVhQzNrMktTWHRi?=
 =?utf-8?B?NERrMi9sT3RQRDlYUE4waE5PeDYxY3FQamd1OVVwbXczTEZuNndSRjBOaVBS?=
 =?utf-8?B?R3JETzVhaHRkR0RMQktacUprVkNFYkkzS1ZYYzJhTzBBd20yN2V3ZE9nZ3Uz?=
 =?utf-8?B?aVVIKyszc1duRGZhSExic1hqTG5DSVF4UW1SRkIzOFR6UmZFaE5qK09PZ3JL?=
 =?utf-8?B?MmV2aUFvYkpCeU5WUnFEaTRBWjdIWkRGeGV4djFzNy8ybnc4NXNVN2ZyMFZt?=
 =?utf-8?B?bTdBTGdCeTRrNm85N3FpdWtpQytCZnVkYldkM0xKWlYrMWNHOHZyWDdkR0hu?=
 =?utf-8?B?czhnbUl0Y1hIVnY2cG1QWHBiS21SekNoNVc1VlBzWUQ1WW5ETWRnM0xYWXRh?=
 =?utf-8?B?dDN6cVNROU9qaytIMWl4ZTdiTWNpbmszOXpZRU02bU5CVGNHblE0RngrdDlt?=
 =?utf-8?B?L2I5MUtzcFBSKzVxYi80WE84RlpjeDZNZVJ2dTQvbjg2ZW5vekNqcHZ2UXN2?=
 =?utf-8?B?VlhMbDFWcVhnTjBvNlNma3gyNFRzOVdYSVBLdUhra3U4dDVzK3ZpZDcwTFV6?=
 =?utf-8?B?LytJRlVFQzVKNXZ1VE9pMlN3SWhGZTJFTTBCSDlhblFaRk5LTWxoakVQSGxR?=
 =?utf-8?B?aVN2VXRtNkUxR3VlTXdzTmhQY1NGV3VYTXRkS05KeWs0RUJiNzlsZjNGaUo3?=
 =?utf-8?B?WW40cE9COGgyaUtVN2RGajY3SFd5LytQS3AzSWdGQy9wYTIwYUFmVEZxLzhR?=
 =?utf-8?B?NkpEWWJzbktMbzdCZ21veXVGWVpKZWp6U3A2L2cycm5mR2FzRUZuOFV1UGJI?=
 =?utf-8?B?SjREZjB0b2lLVklRNjZQTnlPaGQ0V3RBVHM0ZGVFNmZmWmVuQ1MwL0hyd1U5?=
 =?utf-8?B?dWxsL2N4WjBFT0JLR0ZsSnlaNldOQTR1Q1lPa1lEaGV3a0FIRHhubElDZjBl?=
 =?utf-8?B?eGF3eURnaFdzTVoxTDF1aitQQUVTdmZWdStXSkdiQU5qT0NXQ1NSTmhoN3RT?=
 =?utf-8?B?L24vVFVaeGZ3dXhQdEpmUkVyOFF2MTBQNHc5dU9NbUtuZU9aaUNXRmFwenk3?=
 =?utf-8?Q?eLlT1awwu6K81?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1lMM1d2cHVVSWR5cTBhRFlMU0NJd3AyQkZiZ0tmaThlN2E5em1qQ01zSkl5?=
 =?utf-8?B?ZUcrTEVRZVhEMG1mTzNUL1ZlNU1xbDd0UzkydmxwQkFOcmdRKzdsQm4yalAv?=
 =?utf-8?B?elJnZk1FYmxRRlRjcmtoSkttK3RPamNWOElEV0c3R0tuMlZMWWRjNm1mZ2d3?=
 =?utf-8?B?bGpZdmN2U1VoZzZCVUJad04yVDZxZXFHSTdzbUdDL0x2T0VpLytmdXpqeklO?=
 =?utf-8?B?TE5sRUJORVFwZmxlQTcyay85a0dEMnRpWkRvaFIrQU9JU0NVTzZEMmhMckgy?=
 =?utf-8?B?V0FnUHZ3RXgvRTRoL3NDMnpIVksvV2FrWVVEK0F3N2FXMTNkajEyOG1ZMzQz?=
 =?utf-8?B?Rmx5cU54RS9MOVNtZ09OWCthRFllc3JCaTZ2MzQvaC93WDAycjRMdVMrUGQv?=
 =?utf-8?B?Vk5sYlRqSDNkN25ITEM3blpXajRqOTkrUkFBeW1yd2lHV3VmREZHTDlIcUk2?=
 =?utf-8?B?VTV0UmJGbVZBQmk2cFJ6MERpQWo5bitITFJlblZKUnI1WS8zbDR6WGVpZ0JL?=
 =?utf-8?B?ekZ1OERPbm9xdFdWdUN4VytRME9kVFpKajUzMkNrUVlYQ2x2b1RRM3hPQUVV?=
 =?utf-8?B?MC9iVy9KUGpWWWhIQ2ZFWUM3aHhBR3l0UWZHMUZKZGZVT21KOTFJMFYwU2hm?=
 =?utf-8?B?cEIwRVVQQ2pKd1MvN0N4Vmwvc09XODByK2xmNGhKNk1RR1AwZTRvbEMyT2Jw?=
 =?utf-8?B?RzFXS0JjSzBBOTNZT1ErQWNNbGJkTGxrOEJRZUYvUytqT3RrcmZ6SVVOT2Mx?=
 =?utf-8?B?T0R5RFZZVVltSmhicG00d09SL0dKU0ppNWZjZ3A0a3JuNHcxcXo1a2ZUZVV5?=
 =?utf-8?B?LzNEbzlaa0lvYUg1WlN1Tmw5alB6Y3JVdDFESEdnbkM1Y1dnL0J3VW1sZWVW?=
 =?utf-8?B?bVFFa3owZWVaaVVXSFRoZm9pTm4vaGEzSlQwak40b2VFbnk1U3hPd1NEYm9F?=
 =?utf-8?B?VlRzMG8vUXhXUk9QSTNNWWI5OElNcVFhdWR5aW1zdmdiUlJiSkMwMXNIU29G?=
 =?utf-8?B?ZnY5ZG1mTVJhSHJaaDdUOWdaektNZEtQZHEvZ2lCMXhqaTVVQ1plYjZxdmJC?=
 =?utf-8?B?YlNTbk5hT3pYSXBIMVJQemZ1cTVnYUt1ZTV6WnVqNmFsUjhUWEhkOTV6R1Iy?=
 =?utf-8?B?SCtpZXJNRXk1ZFEzS0ZYLzdYMW02Z0NKOEZvQUUvemN4SzhCaWVEQytCdUxj?=
 =?utf-8?B?NGhFYld1Zk0vRzFLRlpyRi83cERhZzNqbXFjeUEwT0w5OWNVYURSY2VheFRD?=
 =?utf-8?B?YTl0RksyUzNybDJNTWJNMVlWODI4cERrTTBZYVlNU1JXKzJKZkhDYWU4d2FU?=
 =?utf-8?B?cFgvRDVzbjBLV0J1U0NYVVBVOFgvTlNQV2N4QlZmODhPN2dsYnM4OFllYjZS?=
 =?utf-8?B?T1VtaTBWbUNQQUZ3bllacGJIV3l5aG8rQ2pvaGNOaUZHaE1RZjFkT2pMOTNI?=
 =?utf-8?B?V2hmWFRvaUw2RW9RWFFxMUdvZ1lDVFErTk1pamViQlB2VHBEVmkwUWRPQVZl?=
 =?utf-8?B?bGVLbFhiV3pvekNQZVM5Q0F4MHRvMG9PdG05SGNleVU3dHRJRGpIS2M4M0pE?=
 =?utf-8?B?ajhxZXE4WFd1NjNUaUdWVWhaY1kvaEh4RDR2TWY1VWtiZ29vRXNYSDFQYjRY?=
 =?utf-8?B?a0poUEF2MVNZVDc1dW1oU20yVVhzVS9ocGNLY3l2cjN6MXdKRTFRNXdaQ3B4?=
 =?utf-8?B?cFFNb00rL1BkR2R2N0dGTnZQRDhyZmZDSmx3S1FNTmh1TnBKb3B4WVZIYkdI?=
 =?utf-8?B?bFI0ODRJYTBBZ3FWWUN2czRuUDdMSlQ2WUp5TXBqa0UvVVlLZldmbU9PamFm?=
 =?utf-8?B?dVVWemt5QjFMOEd5ODlrK213YThRdS9XaERZeUN5cE13OGRaUDVLSGZuL2JE?=
 =?utf-8?B?N1FReS8zTjNGMktrWXltekFoWG93cnNhOFlMcUkzaHNORVFzMHNHeVZkQ1FS?=
 =?utf-8?B?WkxWalE4RDNiRkNEWlhYaW81R2lRR1RKMHNhdGwrQjZjTG84RWRrRUZ5LzJK?=
 =?utf-8?B?bFBBcUlWL2pUbDZ3ZVZjMVZZZ3IvMzJvSFlNckN2a0h0WVpDWWVxY1MxdkJj?=
 =?utf-8?B?NHNJZGRiYTB6NTF1Rmx3S25sNEhiNzQ3WkVwbXp6UUNjTDd5TWRwSnYrTlVy?=
 =?utf-8?Q?t3wsfAsdk+Fd9DiHnLv9pHi4f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea0abf3-aaea-4ba7-3818-08dd40269170
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 05:34:15.2684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHxICbHutYWf75Uc9QH7rRG5nT/a9KCRAZvSEy7E82P6oElDMpgfvSN+qp923s/812d/F9v0yhDh07brWWIzAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4072

On 1/29/2025 8:33 AM, Koichiro Den wrote:
> On Tue, Jan 28, 2025 at 01:41:51PM GMT, Dhananjay Ugwekar wrote:
>> On 1/20/2025 5:12 PM, Dhananjay Ugwekar wrote:
>>> On 1/15/2025 7:53 PM, Koichiro Den wrote:
>>>> On Mon, Jan 13, 2025 at 12:04:43PM GMT, Dhananjay Ugwekar wrote:
>>>>> On 1/12/2025 7:12 PM, Koichiro Den wrote:
>>>>>> On Fri, Nov 15, 2024 at 06:08:06AM GMT, Dhananjay Ugwekar wrote:
>>>>>>> Add a new "power_core" PMU and "energy-core" event for monitoring
>>>>>>> energy consumption by each individual core. The existing energy-cores
>>>>>>> event aggregates the energy consumption of CPU cores at the package level.
>>>>>>> This new event aligns with the AMD's per-core energy counters.
>>>>>>>
>>>>>>> Tested the package level and core level PMU counters with workloads
>>>>>>> pinned to different CPUs.
>>>>>>>
>>>>>>> Results with workload pinned to CPU 4 in core 4 on an AMD Zen4 Genoa
>>>>>>> machine:
>>>>>>>
>>>>>>> $ sudo perf stat --per-core -e power_core/energy-core/ -- taskset -c 4 stress-ng --matrix 1 --timeout 5s
>>>>>>> stress-ng: info:  [21250] setting to a 5 second run per stressor
>>>>>>> stress-ng: info:  [21250] dispatching hogs: 1 matrix
>>>>>>> stress-ng: info:  [21250] successful run completed in 5.00s
>>>>>>>
>>>>>>>  Performance counter stats for 'system wide':
>>>>>>>
>>>>>>> S0-D0-C0              1               0.00 Joules power_core/energy-core/
>>>>>>> S0-D0-C1              1               0.00 Joules power_core/energy-core/
>>>>>>> S0-D0-C2              1               0.00 Joules power_core/energy-core/
>>>>>>> S0-D0-C3              1               0.00 Joules power_core/energy-core/
>>>>>>> S0-D0-C4              1               8.43 Joules power_core/energy-core/
>>>>>>> S0-D0-C5              1               0.00 Joules power_core/energy-core/
>>>>>>> S0-D0-C6              1               0.00 Joules power_core/energy-core/
>>>>>>> S0-D0-C7              1               0.00 Joules power_core/energy-core/
>>>>>>> S0-D1-C8              1               0.00 Joules power_core/energy-core/
>>>>>>> S0-D1-C9              1               0.00 Joules power_core/energy-core/
>>>>>>> S0-D1-C10             1               0.00 Joules power_core/energy-core/
>>>>>>>
>>>>>>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
>>>>>>> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>>>>>>> ---
>>>>>>>  arch/x86/events/rapl.c | 185 +++++++++++++++++++++++++++++++++--------
>>>>>>>  1 file changed, 152 insertions(+), 33 deletions(-)
>>>>>>>
>>>>>>> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
>>>>>>> index 6e51386ff91f..e9be1f31163d 100644
>>>>>>> --- a/arch/x86/events/rapl.c
>>>>>>> +++ b/arch/x86/events/rapl.c
>>>>>>> @@ -39,6 +39,10 @@
>>>>>>>   *	  event: rapl_energy_psys
>>>>>>>   *    perf code: 0x5
>>>>>>>   *
>>>>>>> + *  core counter: consumption of a single physical core
>>>>>>> + *	  event: rapl_energy_core (power_core PMU)
>>>>>>> + *    perf code: 0x1
>>>>>>> + *
>>>>>>>   * We manage those counters as free running (read-only). They may be
>>>>>>>   * use simultaneously by other tools, such as turbostat.
>>>>>>>   *
>>>>>>> @@ -81,6 +85,10 @@ enum perf_rapl_pkg_events {
>>>>>>>  	NR_RAPL_PKG_DOMAINS = PERF_RAPL_PKG_EVENTS_MAX,
>>>>>>>  };
>>>>>>>  
>>>>>>> +#define PERF_RAPL_CORE			0		/* single core */
>>>>>>> +#define PERF_RAPL_CORE_EVENTS_MAX	1
>>>>>>> +#define NR_RAPL_CORE_DOMAINS		PERF_RAPL_CORE_EVENTS_MAX
>>>>>>> +
>>>>>>>  static const char *const rapl_pkg_domain_names[NR_RAPL_PKG_DOMAINS] __initconst = {
>>>>>>>  	"pp0-core",
>>>>>>>  	"package",
>>>>>>> @@ -89,6 +97,8 @@ static const char *const rapl_pkg_domain_names[NR_RAPL_PKG_DOMAINS] __initconst
>>>>>>>  	"psys",
>>>>>>>  };
>>>>>>>  
>>>>>>> +static const char *const rapl_core_domain_name __initconst = "core";
>>>>>>> +
>>>>>>>  /*
>>>>>>>   * event code: LSB 8 bits, passed in attr->config
>>>>>>>   * any other bit is reserved
>>>>>>> @@ -141,14 +151,18 @@ enum rapl_unit_quirk {
>>>>>>>  
>>>>>>>  struct rapl_model {
>>>>>>>  	struct perf_msr *rapl_pkg_msrs;
>>>>>>> +	struct perf_msr *rapl_core_msrs;
>>>>>>>  	unsigned long	pkg_events;
>>>>>>> +	unsigned long	core_events;
>>>>>>>  	unsigned int	msr_power_unit;
>>>>>>>  	enum rapl_unit_quirk	unit_quirk;
>>>>>>>  };
>>>>>>>  
>>>>>>>   /* 1/2^hw_unit Joule */
>>>>>>>  static int rapl_pkg_hw_unit[NR_RAPL_PKG_DOMAINS] __read_mostly;
>>>>>>> +static int rapl_core_hw_unit __read_mostly;
>>>>>>>  static struct rapl_pmus *rapl_pmus_pkg;
>>>>>>> +static struct rapl_pmus *rapl_pmus_core;
>>>>>>>  static u64 rapl_timer_ms;
>>>>>>>  static struct rapl_model *rapl_model;
>>>>>>>  
>>>>>>> @@ -156,14 +170,23 @@ static struct rapl_model *rapl_model;
>>>>>>>   * Helper function to get the correct topology id according to the
>>>>>>>   * RAPL PMU scope.
>>>>>>>   */
>>>>>>> -static inline unsigned int get_rapl_pmu_idx(int cpu)
>>>>>>> -{	/*
>>>>>>> +static inline unsigned int get_rapl_pmu_idx(int cpu, int scope)
>>>>>>> +{
>>>>>>> +	/*
>>>>>>>  	 * Returns unsigned int, which converts the '-1' return value
>>>>>>>  	 * (for non-existent mappings in topology map) to UINT_MAX, so
>>>>>>>  	 * the error check in the caller is simplified.
>>>>>>>  	 */
>>>>>>> -	return rapl_pkg_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
>>>>>>> -					     topology_logical_die_id(cpu);
>>>>>>> +	switch (scope) {
>>>>>>> +	case PERF_PMU_SCOPE_PKG:
>>>>>>> +		return topology_logical_package_id(cpu);
>>>>>>> +	case PERF_PMU_SCOPE_DIE:
>>>>>>> +		return topology_logical_die_id(cpu);
>>>>>>> +	case PERF_PMU_SCOPE_CORE:
>>>>>>> +		return topology_logical_core_id(cpu);
>>>>>>> +	default:
>>>>>>> +		return -EINVAL;
>>>>>>> +	}
>>>>>>>  }
>>>>>>>  
>>>>>>>  static inline u64 rapl_read_counter(struct perf_event *event)
>>>>>>> @@ -173,19 +196,20 @@ static inline u64 rapl_read_counter(struct perf_event *event)
>>>>>>>  	return raw;
>>>>>>>  }
>>>>>>>  
>>>>>>> -static inline u64 rapl_scale(u64 v, int cfg)
>>>>>>> +static inline u64 rapl_scale(u64 v, struct perf_event *event)
>>>>>>>  {
>>>>>>> -	if (cfg > NR_RAPL_PKG_DOMAINS) {
>>>>>>> -		pr_warn("Invalid domain %d, failed to scale data\n", cfg);
>>>>>>> -		return v;
>>>>>>> -	}
>>>>>>> +	int hw_unit = rapl_pkg_hw_unit[event->hw.config - 1];
>>>>>>> +
>>>>>>> +	if (event->pmu->scope == PERF_PMU_SCOPE_CORE)
>>>>>>> +		hw_unit = rapl_core_hw_unit;
>>>>>>> +
>>>>>>>  	/*
>>>>>>>  	 * scale delta to smallest unit (1/2^32)
>>>>>>>  	 * users must then scale back: count * 1/(1e9*2^32) to get Joules
>>>>>>>  	 * or use ldexp(count, -32).
>>>>>>>  	 * Watts = Joules/Time delta
>>>>>>>  	 */
>>>>>>> -	return v << (32 - rapl_pkg_hw_unit[cfg - 1]);
>>>>>>> +	return v << (32 - hw_unit);
>>>>>>>  }
>>>>>>>  
>>>>>>>  static u64 rapl_event_update(struct perf_event *event)
>>>>>>> @@ -212,7 +236,7 @@ static u64 rapl_event_update(struct perf_event *event)
>>>>>>>  	delta = (new_raw_count << shift) - (prev_raw_count << shift);
>>>>>>>  	delta >>= shift;
>>>>>>>  
>>>>>>> -	sdelta = rapl_scale(delta, event->hw.config);
>>>>>>> +	sdelta = rapl_scale(delta, event);
>>>>>>>  
>>>>>>>  	local64_add(sdelta, &event->count);
>>>>>>>  
>>>>>>> @@ -341,13 +365,14 @@ static void rapl_pmu_event_del(struct perf_event *event, int flags)
>>>>>>>  static int rapl_pmu_event_init(struct perf_event *event)
>>>>>>>  {
>>>>>>>  	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
>>>>>>> -	int bit, ret = 0;
>>>>>>> +	int bit, rapl_pmus_scope, ret = 0;
>>>>>>>  	struct rapl_pmu *rapl_pmu;
>>>>>>>  	unsigned int rapl_pmu_idx;
>>>>>>> +	struct rapl_pmus *rapl_pmus;
>>>>>>>  
>>>>>>> -	/* only look at RAPL events */
>>>>>>> -	if (event->attr.type != rapl_pmus_pkg->pmu.type)
>>>>>>> -		return -ENOENT;
>>>>>>> +	/* unsupported modes and filters */
>>>>>>> +	if (event->attr.sample_period) /* no sampling */
>>>>>>> +		return -EINVAL;
>>>>>>
>>>>>> Hi Dhananjay,
>>>>>>
>>>>>> On linux-next, since this commit, it seems that simple sampling with 'perf
>>>>>> record -- <command>' (i.e. the default event), 'perf top' etc. can
>>>>>> unexpectedly fail because rapl_pmu_event_init() now returns -EINVAL instead
>>>>>> of -ENOENT even in such cases of a type mismatch. I observed that this
>>>>>> prevents evsel__fallback() from falling back to cpu-clock or task-clock.
>>>>>>
>>>>>> Should we reorder the checks in rapl_pmu_event_init() to allow an early
>>>>>> return with -ENOENT in such cases, as shown below? I'm not very familiar
>>>>>> with this area and I might be missing something. I'd appreciate it if you
>>>>>> could share your thoughts.
>>>>>>
>>>>>> --- a/arch/x86/events/rapl.c
>>>>>> +++ b/arch/x86/events/rapl.c
>>>>>> @@ -370,17 +370,6 @@ static int rapl_pmu_event_init(struct perf_event *event)
>>>>>>         unsigned int rapl_pmu_idx;
>>>>>>         struct rapl_pmus *rapl_pmus;
>>>>>>
>>>>>> -       /* unsupported modes and filters */
>>>>>> -       if (event->attr.sample_period) /* no sampling */
>>>>>> -               return -EINVAL;
>>>>>> -
>>>>>> -       /* check only supported bits are set */
>>>>>> -       if (event->attr.config & ~RAPL_EVENT_MASK)
>>>>>> -               return -EINVAL;
>>>>>> -
>>>>>> -       if (event->cpu < 0)
>>>>>> -               return -EINVAL;
>>>>>> -
>>>>>>         rapl_pmus = container_of(event->pmu, struct rapl_pmus, pmu);
>>>>>>         if (!rapl_pmus)
>>>>>>                 return -EINVAL;
>>>>>> @@ -411,6 +400,17 @@ static int rapl_pmu_event_init(struct perf_event *event)
>>>>>>         } else
>>>>>>                 return -EINVAL;
>>>>>>
>>>>>> +       /* unsupported modes and filters */
>>>>>> +       if (event->attr.sample_period) /* no sampling */
>>>>>> +               return -EINVAL;
>>>>>> +
>>>>>> +       /* check only supported bits are set */
>>>>>> +       if (event->attr.config & ~RAPL_EVENT_MASK)
>>>>>> +               return -EINVAL;
>>>>>> +
>>>>>> +       if (event->cpu < 0)
>>>>>> +               return -EINVAL;
>>>>>> +
>>>>>>         /* check event supported */
>>>>>>         if (!(rapl_pmus->cntr_mask & (1 << bit)))
>>>>>>                 return -EINVAL;
>>>>>>
>>>>>> Thanks.
>>>>>>
>>>>>> -Koichiro
>>>>>
>>>>> Hello Koichiro,
>>>>>
>>>>> I tried reproducing the issue you mentioned using "sudo perf record -- sleep 2" and 
>>>>> "sudo perf top" commands on an AMD EPYC system, the commands worked successfully. 
>>>>> Can you please mention which system and which exact commands you're 
>>>>> running that reproduced the issue?
>>>>>
>>>>> My analysis is, if we are running "perf record/top" with the default event, we would 
>>>>> not enter the rapl_pmu_event_init() function, which renders the reordering of the type 
>>>>> checks irrelevant. Regardless, please let me know how I can reproduce the issue.
>>>>>
>>>>> Thanks,
>>>>> Dhananjay
>>>>
>>>> Hi,
>>>>
>>>> Apologies for the delayed response, and thank you for your comment. I
>>>> confirmed that just running "perf top" on a qemu instance reproduces it.
>>>> The host CPU model is Intel Core i9-13900K, which is passed through to
>>>> the guest.
>>>>
>>>> In my case, no pmu for PERF_TYPE_RAW is registered, but the rapl pmu is
>>>> present. Then, perf_init_event() reaches the line marked "---->" below, and
>>>> rapl_pmu_event_init() run, which returns -EINVAL before the type check.
>>>>
>>>>   static struct pmu *perf_init_event(struct perf_event *event)
>>>>   {
>>>>           [...]
>>>>           if (pmu) {
>>>>                   [...]
>>>>                   goto unlock;
>>>>           }
>>>>     
>>>>           list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
>>>>   ---->           ret = perf_try_init_event(pmu, event);
>>>>                   if (!ret)
>>>>                           goto unlock;
>>>>     
>>>>                   if (ret != -ENOENT) {
>>>>                           pmu = ERR_PTR(ret);
>>>>                           goto unlock;
>>>>                   }
>>>>           }
>>>>
>>>> I'll look into this a bit more on my side later and get back to you if
>>>> something becomes clear.
>>>
>>> Sorry for the delayed response, can you please try the below diff and let me know 
>>> if it fixes the issue?
>>
>> Hello Koichiro,
>>
>> Gentle ping, please let me know once you try out the below fix.
> 
> Sorry to be late. Yes it works.
> Early return with -ENOENT when event->attr.type != event->pmu->type seems
> like a common approach used in other pmu implementations as well.

Great!, I will post this as a fix for the last patch.

Thanks for your help!

Regards,
Dhananjay

> 
> Thanks,
> Koichiro
> 
>>
>> Thanks,
>> Dhananjay
>>
>>>
>>> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
>>> index d3bb3865c1b1..4952faf03e82 100644
>>> --- a/arch/x86/events/rapl.c
>>> +++ b/arch/x86/events/rapl.c
>>> @@ -370,6 +370,10 @@ static int rapl_pmu_event_init(struct perf_event *event)
>>>         unsigned int rapl_pmu_idx;
>>>         struct rapl_pmus *rapl_pmus;
>>>
>>> +       /* only look at RAPL events */
>>> +       if (event->attr.type != event->pmu->type)
>>> +               return -ENOENT;
>>> +
>>>         /* unsupported modes and filters */
>>>         if (event->attr.sample_period) /* no sampling */
>>>                 return -EINVAL;
>>> @@ -387,10 +391,6 @@ static int rapl_pmu_event_init(struct perf_event *event)
>>>         rapl_pmus_scope = rapl_pmus->pmu.scope;
>>>
>>>         if (rapl_pmus_scope == PERF_PMU_SCOPE_PKG || rapl_pmus_scope == PERF_PMU_SCOPE_DIE) {
>>> -               /* only look at RAPL package events */
>>> -               if (event->attr.type != rapl_pmus_pkg->pmu.type)
>>> -                       return -ENOENT;
>>> -
>>>                 cfg = array_index_nospec((long)cfg, NR_RAPL_PKG_DOMAINS + 1);
>>>                 if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
>>>                         return -EINVAL;
>>> @@ -398,10 +398,6 @@ static int rapl_pmu_event_init(struct perf_event *event)
>>>                 bit = cfg - 1;
>>>                 event->hw.event_base = rapl_model->rapl_pkg_msrs[bit].msr;
>>>         } else if (rapl_pmus_scope == PERF_PMU_SCOPE_CORE) {
>>> -               /* only look at RAPL core events */
>>> -               if (event->attr.type != rapl_pmus_core->pmu.type)
>>> -                       return -ENOENT;
>>> -
>>>                 cfg = array_index_nospec((long)cfg, NR_RAPL_CORE_DOMAINS + 1);
>>>                 if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
>>>                         return -EINVAL;
>>>
>>>>
>>>> Thanks,
>>>>
>>>> -Koichiro
>>>
>>

