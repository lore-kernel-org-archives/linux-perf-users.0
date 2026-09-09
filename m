Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010029.outbound.protection.outlook.com [52.101.85.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B87E2D2381;
	Wed,  9 Sep 2026 01:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788917308; cv=fail; b=YABiDpORgBocaiirSAu1Yg5aXhLfNY+5zRJYwgj35DnkZiXd/xcAYHls17gFI473HKdbHLXjzRVmcXK/IHJA0V6ra+mhXXfKI/3ZHGX8ApExraiHt8r+OqzNVF56m8WAJQTHwZp/g9Jp7ldah90BB/cRr7fxyXTrRne04ZW8jAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788917308; c=relaxed/simple;
	bh=Nghr9mk7LSYL+wjORNpse332UkJyZjUXNj2PyNT3NGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oFpB02bqiTHJevNn8eO+dWdOk+Xl9xXtY+WzU1FsVH94KgFpPc+mpAgaT+Hn9/8I6024M9oEYP4NqCsQDwfv4PRwRdLZH4FcZ9jOgrhcMgJBWj36jGDXMCrwVb56UaLyxcASHvb1mavj/X1OriMuJzcOfUJTg7zE0+BMQNT9gQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x2EgH8pj; arc=fail smtp.client-ip=52.101.85.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x2EgH8pj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WaBnmhbV0vsvkfTRMQQD7lRqCWGJ2BZ28qeu4lx2ULVC1BolcagKlcO35Gcn0vqNP/3v6HCqF3738wh0CHYVNp9a7mN0/MbHVZM6v/5aHLTYnpDMilKsyvdqbVzXD0ReTVB9VT6CKeIPdshKANAhEgGBsDubvO2g8ufQn9REylYH3E7IyPC+6FOEEvuPGIBdjemx3+xWgINUbrO4bPPX/8iuA3piYMaoJSD9Ex+a0OZR6vUXLnpPuSj/BocWspkSomxUuUzcviNs/Rl2bAea+E+XML6Dx/OpZ6/PYw82JnyrDepk2TYiVfMKJ6HOXaKqFKQ7elWsoQwomH+OXqy1Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/KVl3chbKsvwDpUM/EU1C+SmzHXLeumiUxlbUe5+EA=;
 b=EIGutt/xVlPXElZTbew3NiOIp7qx+EGdWnnudDAXk+TkPb4eNmxfzb2pFfFEQYgni5vcqvLNLZVaAH4qX5wEgzhLF6c6gApOqeUtkt+OOIIRkjRVPwcpJX/ymn+qrWX7liTsLeUYLsHWwhH3+wELXMPkjCUawsLR3HAMpIwnhREXjZlQ31ULkt5SMYPhFSNukOsWTji0npv7yWzjCmxSLSTG47i0+troRu4MAFS/y3ripFqOToA6KyBAecfuqAXwfUS3RbOllmgUCjIF/vEn1pQeQY56ifRYcgd3NaDOcBLi7Rzlb5zfqM1mZBfRg7TXp4HjHfj1Bedyw6qxk6+l/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/KVl3chbKsvwDpUM/EU1C+SmzHXLeumiUxlbUe5+EA=;
 b=x2EgH8pjWotbRCeO4O9E0+ftUfILroZWGNrt9o/4gzIxelqi2/faMECLJR0lzoty0vHOG6Ah7pRT2lqQ9LWu5pBKVp4enT+heE1CpEI3jKxWT07UfA2OOIMiXcnC1C0n2UGU6xFBoG4c2yWGiXHYHKS9O4wBepuf4vXNaMCMyMk=
Received: from MW4PR04CA0277.namprd04.prod.outlook.com (2603:10b6:303:89::12)
 by MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Wed, 9 Sep
 2026 01:28:22 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:303:89:cafe::5d) by MW4PR04CA0277.outlook.office365.com
 (2603:10b6:303:89::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Wed, 9
 Sep 2026 01:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Wed, 9 Sep 2026 01:28:20 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 20:28:20 -0500
Received: from [192.168.0.101] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 20:28:15 -0500
Message-ID: <0c7c7902-e944-4c93-8188-6ca2f90b6795@amd.com>
Date: Wed, 9 Sep 2026 06:58:14 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf/x86: Disable precise sampling for
 PERF_SAMPLE_STACK_USER
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, Ian Rogers <irogers@google.com>
CC: Peter Zijlstra <peterz@infradead.org>, Andi Kleen <ak@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Eranian Stephane
	<eranian@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, Dapeng Mi <dapeng1.mi@intel.com>, "Zide
 Chen" <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>, "Xudong
 Hao" <xudong.hao@intel.com>, Gennady Kupava <gennady.kupava@gmail.com>, "Ravi
 Bangoria" <ravi.bangoria@amd.com>
References: <20260908075102.540715-1-dapeng1.mi@linux.intel.com>
 <20260908075102.540715-2-dapeng1.mi@linux.intel.com>
 <20260908084906.GO4121339@noisy.programming.kicks-ass.net>
 <1691a05c-49a6-4b16-8bad-cb3c004ed07c@linux.intel.com>
 <20260908101914.GQ4121339@noisy.programming.kicks-ass.net>
 <aqAlddsFPYJvRhFr@tassilo>
 <CAP-5=fWbSNYpt8p3e+pqjY+xhqs8WrzsBfPaKB1NLBm88mH8Yg@mail.gmail.com>
 <ddd7d413-ed95-4c3f-9435-1a3e2c27cce2@linux.intel.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <ddd7d413-ed95-4c3f-9435-1a3e2c27cce2@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|MN2PR12MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: b494c03b-d53d-41df-c583-08df0e11a24e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700016|376014|23010399003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ah0n3MplO48wE8okg6oC/GB8/DfYryvJ22UqI+cJ0TJJK6VRRYcCf8qhfz/8tZOKvy3iAatVsn+5KuPe/jx5TNQmLEhQ8R2+cTBMonmPpPoNFsk9MPH7/FDcSxExQToA7ZyFTO7FJasMruoqCfiKkrCyneNK3zJVuEIUn+HZ5VMCE+Y5ZYY+nL4VFmVP87RQAf+Zbx1FwlLj5pjTjK/Txg5ptUT/1JRwIdpRh7o6nuVPmfjXlw950WT59jurFv6hvLU9x6Q0LdkKby5v++2gx+RdFaSoOuNSKibvWkoUaoUp7Pym0wanea6HFs4++M5zmKvSQNXb2MQxt+2sCH9XoW6oleaCEsOp48n3h3+vMgbXzZEoQeYnm4mJINVbAnTInZg2h7Vi+D2Eg9eTGKTe+qC+dVGgpQuvl9nffvfDfz5VAZQxvJ81VbT3SmjjHpBpto9qJdnheyS9XRllMP08dbBuDGXtwhBvqOrPIWmr2KiypYd7A+Rqqzt994RJ5NOgyaPJ0+5ge29FrHamJmQbnP9A37UyCqK+cA2EzMcUZ1jKJ84cYGwqqb5G/julIrCRtJmfu5cSE/yDhNgLJbt0S0w7B/lepaJav0bTZUH0jP082o9vDx4YRW6jydDCOyt8cdsX0jwgJKCAtuIZ+b9NK4IVS+9hObQJybkInSw0ZM6YsFdPNCKKj+h7kOpgjvrXXQW3MoWlNxPjyAKzY6jEQA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700016)(376014)(23010399003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QTI2s8/aTkPCjFgvw6NBNqpKvWnco8zd0G1VciEerj/2J5zx9ZQ9KLRWaDj7tgYVNssc1xhzZuH2HM1YhcBY7eqDAclxXozcS/3i6jdNaQvucy8kaqw5cgH2LFvgOTTM5VSvojqllWgshCK91EgaewVQ9WmwKaRQAmPE4BIvNuceJMi0v9V7phLQNsy/YHzl+UtHA+7WlugUt/3p7aIu1G7EtyOQ/LFmthrBPshj0z1HUmXCRv2D4G6v2xaP+/HKQkZXJsBJH7klZSPc4NNXgRvwq/7xdpKukqJIBigCLzFzyVkPT06piBV7tb/To+ELTDTMkhk6ywBQAkn0wHRZe6RQ9+Z0WkaWbb4hdMxegLsurcvVJYJ8SeHDLHhQ2ZHJrGzpKPs/m5aSioqZKXb8eelCgST05zDraXsbNCZrBHQ1zey3E/T1JHgOP0/k4SwJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 01:28:20.9367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b494c03b-d53d-41df-c583-08df0e11a24e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159

>> Having PERF_SAMPLE_IP be precise and the user registers from the
>> interrupt I believe works for AMD IBS and ARM SPE, but for Intel PEBS
>> there is the ability to use the PEBS register samples for other
>> non-redundant registers. In the x86 driver could we disable PEBS
>> sampling for these registers when doing user stack sampling, so that
>> the sampled user registers match the stack sample? We can keep the
>> PERF_SAMPLE_IP precise, and make all the registers precise when there
>> is no stack sampling.
> 
> That sounds the best way to fix this issue by decoupling PERF_SAMPLE_IP
> with PERF_REG_X86_IP. Then we can keep the precise SAMPLE_IP and the PMI
> context user register snapshot simultaneously.

With this, PERF_SAMPLE_IP and PERF_REG_X86_IP might be from different
privileges. So, any perf code that depends on user_mode(regs) (e.g.
perf_exclude_event(), _REGS_USER, _REGS_INTR, header->misc, etc.) also
needs to be inspected/modified accordingly.

Thanks,
Ravi
