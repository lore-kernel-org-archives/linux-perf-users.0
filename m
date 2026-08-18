Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3289743F0B8;
	Tue, 18 Aug 2026 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046601; cv=fail; b=Sgb2aA8SBY16g4zojfJF4coeSMQz9yhdT9xblSfQCoRWtxpw380fsibXfSx5psDpd4BdSdqNeSBYdS+bCG5dHlxFzDplLY9NXuAFAMqgDIS9zHxF9KiiT7s5SeiG75phrlpuE/TSy1ondPywRTzAU+WTriUaBd7Mj7E9nGdfEts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046601; c=relaxed/simple;
	bh=Yq29NGlpDC/Rx19iz9XEkr1Yi5JqCTHg+HpSTfmSaNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ssWgkvvJhXKHpjg+6Vp6pOBRWJaEA6PKYVIvWQlw+xNaM8HPNdXuTU1Tf2tfu7fISIbiStvDuptJ3a9GCIMTPgPCfVjOmNiOtljcYdrwGovYUnmmDFWwRMH8Md+SezZGjClEY4wPjr6MsFCprHPLXEAcMI78bVpz5rCnDhAGszU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a9DaWBAI; arc=fail smtp.client-ip=52.101.48.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a9DaWBAI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHR7rm5hBG7JrupQhSOzZ5BzbZcK6teGFb5cA8CQKXeoN24dJJt8XubYSUmQnu8kBaDMU5uubJrFVrMJgt1BUKOUiUpmOUSbZD3PNpqzrE2L5BbETxQc6l2iYjYKwe+thutG3K1TqLWU1NQRgaGM05Jbs28aejqHgtC+xsoCeR1ewoF30piKOuYKGALsDyQlSAifyB6BUfzrEglkyACoxWrciPZnP8Sl7NpapjnSxf1+carW/nW3jL4CZb06+bpYiYp27N+E/RFEcoprcuM0aR69AiR0/8bZDFQdHUdWd+bPi0UclV7QC1pb8lkzJEMjItKpcvOyyNI2rp+Vc0bkIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crnHvsYyz0tqIYomI2pH98GakL4h/WMLMXyY23uaNbE=;
 b=Dou32C+Ys5zP9dwzRExyg6tgsr/YdlC/kwLR/GRCnpqzML6wduViD5LaXdwcIeo40AYJYaIhS51XCZ57/j8XvJW/gtjEAsKLIKEAlPoTNJbJIU/nUG9Tp3Jmwigpg7Nl/4lV13uM6FzW6kMm4mhF/88xZRXAE92UjfEN8YET+orIn8GiKcgmaG/+EAd9JpWJ5qNkz1PgESC2GjlNMyx7KJlMEvohOE++zOcLlUcHgjbx7vK2EwJjGoNUm5MnZwheIObjxR7MK8F4NARsHOIQpFjbuHGJq5JMSqmnNGLguTyllDCHv1LH68kRXZexU8iOKq0i07GnCQTZ65/PkyKQ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crnHvsYyz0tqIYomI2pH98GakL4h/WMLMXyY23uaNbE=;
 b=a9DaWBAIJCgy3XPwEIPsXNVgz5GM8NwKjGuLITtVrXye/vJBpvKXqVqsUNFxLtIRR7BQ+ptnJ2JXejxno1FtrkFrCUO2ptOOg5AzLgzbgCZJ8piU3eV4D8VFz0pGme+qchBnxfSj+xnsMeOvIMaNDt7tTIi0JevtfxvpaFXXnGE=
Received: from CH0PR03CA0235.namprd03.prod.outlook.com (2603:10b6:610:e7::30)
 by MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Tue, 18 Aug
 2026 09:49:56 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::5e) by CH0PR03CA0235.outlook.office365.com
 (2603:10b6:610:e7::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 09:49:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 09:49:56 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 04:49:55 -0500
Received: from [10.136.43.11] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 04:49:49 -0500
Message-ID: <8ad9240e-71a6-400d-9d64-6b3dc1261433@amd.com>
Date: Tue, 18 Aug 2026 15:19:43 +0530
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
 <638cf844-8422-4706-b028-60d8722ce487@amd.com>
 <20260818091913.GD1247881@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20260818091913.GD1247881@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|MW4PR12MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: c564fac2-f39b-4de5-f7cb-08defd0e0f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|7416014|376014|23010399003|22082099003|18002099003|56012099006|6133799003|4143699003|11063799006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	0ZQZGydETOhGa4RRUbCDcYSKJEQJJ9V2DfamQ1JXYg4mEFMuCbygsWjlfVEfb9IVICpvkF8EjpL19SSlBrbGoOCG722aolXKWCUDorn2v8aJD7x6iuMWfgZLZ6l/Cq90HSMGMtnfoJtXFecQqX7UGKKuAAdyRIRjg2y4AVWZwxquCSubXnpxM3SLIbOeNHFoDCzMRgAOQ5ZqEfeDLz+mFq9kESjS/csJdFyuyHZ4DQf3In+58wB/1x1XJjXeisSe3uZ3EuS4/y8ggOQ4QHPlBHG9sRZlpFuSSHpfOpffNytp3yBClnrC1brX1pKWN+anUnCsYwgetK30726HZ4OzlyvNnioE/Y71BT7jJsf0T9aE+yHQP3dRZcXx/n6uxLDmJ4X74xmS0u4y5fXRt9e3f6DABaeciuKSI9uorodjHvTAMPSsAFYOX+xbGMBTqfbXkzLG5ZnUoxKE3Ldok0VhyUv0GvcappHRivFCYJxpoGhXetQJ4R49GQv182tQYOyzaO56Bdmu5ogAfFqVEIr+lBy3nc7wrOwuYy4MPILgSs0TcdeA6Un37QhDwla86iZiBQigxYSvOkjPRcv4+1OXr7JR6gygCMeDG2B3cJHwMDbcKQBno3QlezHLBXxXtVUDpgzkk2aNsxF1Xf5PLW5C7q7mjWKKjuoENyroIWPbejUEuyOPv6sBxYmlcQBHurcAd+5nl6rabP+LE3nb8V8T2Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(6133799003)(4143699003)(11063799006)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lLz8dgWq+AxS6cSClqEWAG/CYoYpenHnS6N5jizPYpDBQvYJpyBcDKJ4qxfUIgAe434RzjG8TOQQtmThBlC3cguTWS5ix0Slvy9hCQPlFTpjyAkYP8kWU1mb6EFjHqRV7b9/tGliQMB1+U/9XA0DPEaV45jT1MZTS3GsrfvON8/DFcV8zJkEPoSx26TfuDDSyUSJObaUN0iA+iWdhQfJm1S0W+FuTeBYInm6W0YSEF4iYjeHy91j0zKQnqPeZFwM186fOHbrrzTw/Fp4KNwd6wlcZUgEmZDxOB8C5hBIdlaGaFPo1dhiHtFMsz7a2jYPVQyti7VXk1vZ1oPr+cMAIV9CCPWIIg7OK5nvwXQWThO/8ZPsASKrOwAm3i13rVdZSuRxtFmCoCLmA24nqIby7v5GXr2Uaxsic5YQlgLVOwGbgTa7KEvf15fb/2oX/ZMc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 09:49:56.1173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c564fac2-f39b-4de5-f7cb-08defd0e0f53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6873

On 18-Aug-26 2:49 PM, Peter Zijlstra wrote:
> On Tue, Aug 18, 2026 at 02:34:26PM +0530, Ravi Bangoria wrote:
>> On 18-Aug-26 1:30 PM, Peter Zijlstra wrote:
>>> On Tue, Aug 18, 2026 at 10:29:08AM +0530, Ravi Bangoria wrote:
>>>> On 17-Aug-26 1:03 PM, Huang Shijie wrote:
>>>>> The IBS Fetch sampling does not report the physical address of the
>>>>> fetched instruction even when PERF_SAMPLE_PHYS_ADDR is requested,
>>>>> while IBS Op sampling does.
>>>>>
>>>>> This patch reports physical address for IBS fetch samples which can be
>>>>> used for profiling the running program.
>>>>
>>>> PERF_SAMPLE_PHYS_ADDR is meant to capture the _data_ physical address, which
>>>> IBS Fetch doesn't provide. So, repurposing semantics of PERF_SAMPLE_PHYS_ADDR
>>>> for IBS Fetch seems reasonable.
>>>>
>>>> Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
>>>
>>> Well, why confuse things?
>>>
>>> As you say, PHYS_ADDR is for ADDR, which is the *data* address, and
>>> FETCH is an instruction address, which we find in IP, not DATA.
>>>
>>> What would be the purpose of confusing things and making PHYS_ADDR
>>> relate to IP?
>>
>> Agreed, that would create confusion.
>>
>> Do you think we should introduce a new type PERF_SAMPLE_IP_PHYS_ADDR?
>> I didn't suggest it earlier because I thought it would be overkill.
> 
> Well, that all depends on how useful this data is. As is, I see very
> little words on the benefit of having this data.
> 
> In fact, I'm not really sure what PHYS_ADDR is good for, so clearly I'm
> missing a bit to begin with.
> 
> That is; if there is a very convincing argument to actually have this
> data, that might help justifying either accepting this 'hack' or perhaps
> introducing more fields.

I don't have a compelling use case either.

fwiw, IBS PMUs already dump this metadata (including the physical address)
through PERF_SAMPLE_RAW, so this information isn't completely unavailable
to userspace today.

Thanks,
Ravi
