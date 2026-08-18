Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012059.outbound.protection.outlook.com [40.107.200.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282BC3C10A0;
	Tue, 18 Aug 2026 09:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787043882; cv=fail; b=mmYOdvBpz0StAyOQ28/lNf1GmsuoBcl4FmEKF1T2TkO/CgOApg/6pmciRS1PXVt74l7xtUjAAzc5GWbkGfzTeB4x/fa0Amf70sGchZPWMPdydLcKISMFyBn/uI1ALV0KWn8PeUW+aHvzrTV8SGCxCvMZM9u6rSGhfzg1HdH7HN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787043882; c=relaxed/simple;
	bh=xH9d4tAZaCLR8dZPADfDrmcRxPBJcqAVUyMal61bzns=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KvrxyAegBuJLfPLxKE50gXqj/BrpKu4jMHA3iK68ikGSQW7urWHdQ2GSIZpE7r0O0dvFnJ5GKCRfnyO6pxLzPzAS8MnOEoZ+Ko6RS3/0My7Px4tgx7BrFswcLsgqO8yGr/mUUYVqZWblwogmngCtc63rgJl0nd3rTElPj6R8zBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e7WGXxFg; arc=fail smtp.client-ip=40.107.200.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e7WGXxFg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVwRoFzGvX+N/eoFvsy9/nU4cPttU7mL5V4LpIw8GcyHhPYxfEkUsNMadHmX2HeXtSIXvaDkm2bNhqWiiRDaTIhHugZlQ3lCHSOPdYkpKPHMq/SG9sST5KLMb1dgqD6cx9tp9rEHEYqQrRHPnEIzeoPS9m2uCuXc5/JU1wlW+mMmPLgBXXB6DXFiKV+K7DaPHr0IkbYqTOhAGq1t92azpfgV2NusSt2Vp+5NEITAvLXkC6tvmOFxLo3sWaV/k1Q956zZaqKq9nDYAYM6fxcFq+H1OHOYdztpp4Fu4hWPioftvgTP8alG5DmnvF4U9g7Hxw7cb+vSJJQkcMbQwvTFcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/EpnXKq7AMmGbxGr10u1NFTQzajAaR1a5y5hMCyp38=;
 b=EhsZZyBZEDGaOlgDH9wqNi8mrLawqbKn6nZxDBe+nTMiGldSewbtRczeTxbY/PLrBFWqLJ+bG0IW2SU/1pBjvYQtSJVQQEww93APuIahPNJI6o/ODEnrqtRpFfmn/2W3xcTseQ6ffvHyUFOUtBAzQhrAAQR06JQqs9uf2G+Ap4qzPJR/Eebf+NiG0tScONF40EeE1wyh9BlZxzZYX5u/J118nbwTx+jcgkXT8YfJITNZR/6TptexWIUK2TSzZxwsnJ1bQSjXiDmy/jAjl3KDmv6lRRCAmX/BUttMQok8DLHoxNqhOt4a/H1kXz6KRbkIvWNfDE6KjkEi0Rt8GC/TjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/EpnXKq7AMmGbxGr10u1NFTQzajAaR1a5y5hMCyp38=;
 b=e7WGXxFgqr4udXSQVLUWiW2MjkL0gdYccy9mJY8qpKxVZ6i4OqUNAxIYW9+AK8M7Z1lsG1yIZVW4BhhOfBcS4EIzidxTazoDvRjNswJ1ZsV3q+z0hdT5CcRdX9BiAQ0IO9ET5TNC4pH65ZgnAa0VWQVDJFDctPfHXkEuqw8WeBM=
Received: from SJ0PR13CA0161.namprd13.prod.outlook.com (2603:10b6:a03:2c7::16)
 by PH8PR12MB6745.namprd12.prod.outlook.com (2603:10b6:510:1c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 18 Aug
 2026 09:04:35 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::4e) by SJ0PR13CA0161.outlook.office365.com
 (2603:10b6:a03:2c7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 09:04:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 09:04:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 04:04:33 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 04:04:33 -0500
Received: from [10.136.43.11] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 04:04:27 -0500
Message-ID: <638cf844-8422-4706-b028-60d8722ce487@amd.com>
Date: Tue, 18 Aug 2026 14:34:26 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] perf/amd/ibs: Report physical address for IBS fetch
 samples
To: Peter Zijlstra <peterz@infradead.org>
CC: Huang Shijie <huangsj@hygon.cn>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>,
	<yingzhiwei@hygon.cn>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <james.clark@linaro.org>,
	<tglx@kernel.org>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <liuqi@hygon.cn>, <lijing@hygon.cn>, "Ravi
 Bangoria" <ravi.bangoria@amd.com>
References: <20260817073323.2504767-1-huangsj@hygon.cn>
 <9a39e681-3184-4841-9e19-7fc40956e917@amd.com>
 <20260818080024.GB1247881@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20260818080024.GB1247881@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|PH8PR12MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: a4ba2a90-047d-4ee6-aced-08defd07b8a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|23010399003|1800799024|82310400026|10067099003|56012099006|3023799007|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	81QMLS/O9NgR+S47d2/MjCKYg05xx45KsJ+/lQH+++RGQGY5Jf08otUf+NQ5Tx/tUAdQ3y5fsIRIh4nP5Hk8KScp5PxczTZqNYL8O3bH1APY1M7/9D4pBOAw3Q5v8/sl8sNibVOPTaKsf1Zyf985LZFlBjo1A5Jk2PI/oPVX9ItrIFnR8bZYthZ8VhG4RAWAnMxL/UZxH3/GZNVLCC47YyLW7Lk+bcYyRwka15Wf7Tt0KsL+Dg2Q0E5MGM2e0q2emjJInxXsitagH5mY3S6iTaVr3tXmne8i+gbS3LLoOTf+4SVgZu30Zj+Xkwbn5fd59Su24x5D4u+SAGS7wdKvKeyk9CQh7QsKNaHjA1TIaVMmhybwv6914wNe8RlOEkDONt/dDw3418w68ogkOOM/eA3VA2umSXEdgNPozc50mUbLUzs8egRu/1K37iFCCMh6SH8B9CdHu/KMWFohEYTcfKmJZur72If0C1/t5jr9qBIBgXnQuOHEYDqomEpwLXhhrU9TqZEz4V7aErWAxNzG31Ur0shyAjD4Va8dmtttqrOPaGD8x7BbjozlCrvM43Elx3dhzkAGZxQgzWHZCM25bha3wnNvhdt2+O0B/V6Xj1oC/auOy8f5GnesxAEsax00WMncjCCk0j34l5FQC6eCM8+LAdmOW89wRyqeQRBlMpYhgk1m16ZTq7Wow2uxOjL71jgc73Afn2N4PUH2BIJmyA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(23010399003)(1800799024)(82310400026)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YVwDJOMr0LsJTRPewXBD5ysgulU502Odxyz5bBmWbxS4qpvIgFlLbHLSzXe+xf0VOg5rsEg6tsIBTxsdOokLp2wxUqMPkyAVHKEoEeNlM1k3tYx/jEghCLAdLy4/mUbzz3g3C6KJFMSbONfuYwDQV67N43Gb90LrVKVc9UFuSqEdeAO4etlxdHWQ9BJbB9oolTdyDTDQlAX3Nm/bPKOaNIJXMwwv5hV4ytmEZ25ai7c1iOVvTEDekNi7wntqfjRvT7+cot1UpVK5MoCeujmil6RN5su1hosed/j6wA2YcbM5I4y2+GUr0do22qZHlf/wQhHRV/oXi9QoQpetRO8vtq7H/DkX2pYzq+PnOwdoMY76vx7Eg+WUWnOEP3K1i+lecUZZWNMpMQHgkmg9PUC4F5uUJMuBkEyxFIW6R+Cf0gUSc6YI5xToE4WYstpNac0n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 09:04:33.6391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ba2a90-047d-4ee6-aced-08defd07b8a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6745

On 18-Aug-26 1:30 PM, Peter Zijlstra wrote:
> On Tue, Aug 18, 2026 at 10:29:08AM +0530, Ravi Bangoria wrote:
>> On 17-Aug-26 1:03 PM, Huang Shijie wrote:
>>> The IBS Fetch sampling does not report the physical address of the
>>> fetched instruction even when PERF_SAMPLE_PHYS_ADDR is requested,
>>> while IBS Op sampling does.
>>>
>>> This patch reports physical address for IBS fetch samples which can be
>>> used for profiling the running program.
>>
>> PERF_SAMPLE_PHYS_ADDR is meant to capture the _data_ physical address, which
>> IBS Fetch doesn't provide. So, repurposing semantics of PERF_SAMPLE_PHYS_ADDR
>> for IBS Fetch seems reasonable.
>>
>> Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
> 
> Well, why confuse things?
> 
> As you say, PHYS_ADDR is for ADDR, which is the *data* address, and
> FETCH is an instruction address, which we find in IP, not DATA.
> 
> What would be the purpose of confusing things and making PHYS_ADDR
> relate to IP?

Agreed, that would create confusion.

Do you think we should introduce a new type PERF_SAMPLE_IP_PHYS_ADDR?
I didn't suggest it earlier because I thought it would be overkill.

Thanks,
Ravi
