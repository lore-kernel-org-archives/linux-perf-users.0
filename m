Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E38236164B;
	Fri,  8 May 2026 06:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778220350; cv=fail; b=IjjszNrd7oM7gpzNILGI0Krp6m13lYugQZI/HfVfOMcqhPpmZk2xwXyhe4SMfbI0lzSqwRpK7EsjXenF8zHidgGTq1fgQY37qrELSDSmw3TdKtuvJKahsMwH3+X36azxkCbG0C5RQjtfOx3SV4QrKdk9/GuAKmJgkv1rwZ0NSgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778220350; c=relaxed/simple;
	bh=ASgnUCTY8aKod8IbQ8s+vwaumlS+u0NhOyFdeZOSk7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GlHzrXQd61gTNPL+H/uosdyC8EJEmr5RXWho09eDavGbwVuwEX4UGxBiTQLNdy29OUefQATvIPPCsxGoJrsEPgHBv2aZrMbBhq3/4F3u8Kca5ocyj3Pks6uytUqp+mYWww2Y7RrRZBzwISZ8tAjEQo1hBmXGl8lqe5lazEWJEfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NElWFNxO; arc=fail smtp.client-ip=40.107.209.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NElWFNxO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2GcBiMBZ6aUcaGghKgVEkZr+cO0hIz+6rfo3Ic2XL+pThFc9uQ/YDbJcAYFMb9tIwqzwxhkcLFpTluhuhcVv8pAmV+FGIlw859UZo2Buo7yI1pHKA5x00QuU0od4fWOXjAA//2QiAxDBjJq9mVIx0pf5VpUHY8zSj+8l7KVc3zVR4xZ/YbQ8wZHdaFEQS23dHaffJSxfuUSIF6n44sjGNVlimW3CzT7pjGWeX/EEMEJD4Y7PuN8g1wzqMmMpYBOrYMShlaD4xm5i+HTpla9de0Uh0Cq6CS5jGyTa0herT/WYAybfko1tNHbNzi8M2J95zDm5IvLctDwYOlbZV2hkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHJQHuSCV9o8y1wXs2mY3p2CUS6Zbv4+CrxLIQyJ208=;
 b=is79BCRcylOo5n7zV/EE5I6YlVEnEn7f7qf8KT458dqKkYiDJnZT63S8LXO4tqlaWtVfaPpRi1SNBFdsobL0gnT1DVNJW5F9E1TgWYclNEx9ug9yaSXahuOPy9m5cZssKIaR0gojdTV/oH2bd6/IpRpyqQMOHBqlbAxoMrIk4pTzjXzyMFYQ2Bg8RGbwk3rMw18dDYBb+vFnXELv+kZiVAyVHGRhmFNo1tc7OvAC33kReoNlU5V5k/TkZbCN14eh9UW1q0NkhM/uOk9/YjPut9yHcpIhW43z9+z7ZsJXSI+7vF9rbUzXhQ0V9Vl8IMfNukKEGrOGchX02sbLfn9GVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHJQHuSCV9o8y1wXs2mY3p2CUS6Zbv4+CrxLIQyJ208=;
 b=NElWFNxO4WdrMpntCCpQB3AHfxpZsYTE0yAxkKkFNsomR5VWXiQ/Z8MMSg2mWIGPzy4IWgAQVUSMlV/H0Ggb0Jf2Z2YZowq6x8wXdFOA2Hu+22XZ4IUauZAMekMrttqRZZN2ZqHVnaJ3FGQamBdP9Bjm6tuO1loLcYXsGT7XmW0=
Received: from CH5P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::21)
 by BL3PR12MB6572.namprd12.prod.outlook.com (2603:10b6:208:38f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 06:05:32 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::c) by CH5P220CA0003.outlook.office365.com
 (2603:10b6:610:1ef::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.19 via Frontend Transport; Fri,
 8 May 2026 06:05:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 06:05:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 8 May
 2026 01:05:32 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 May
 2026 01:05:32 -0500
Received: from [10.136.38.58] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 8 May 2026 01:05:28 -0500
Message-ID: <43179782-f1bc-4590-a4ed-0ce189e08ce9@amd.com>
Date: Fri, 8 May 2026 11:35:27 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] perf test ibs: Remove obsolete privilege test
To: Namhyung Kim <namhyung@kernel.org>
CC: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers
	<irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, James Clark
	<james.clark@linaro.org>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manali
 Shukla" <manali.shukla@amd.com>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>
References: <20260430061115.10266-1-ravi.bangoria@amd.com>
 <20260430061115.10266-4-ravi.bangoria@amd.com> <af0tTxZNLdtohH8A@google.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <af0tTxZNLdtohH8A@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: ravi.bangoria@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|BL3PR12MB6572:EE_
X-MS-Office365-Filtering-Correlation-Id: 661554e9-2dd0-4704-2a03-08deacc7d06f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kcwLIfdvzSwT5CZd8+ggiC0R/QamHvXqmghraWp6dY2kZUqWUU14qJOd0c8J1dEOF1Wc6ajX6iiu1q7S+lTVJ+RjwGanR4EMwbRM3HIrViF91pfjDFjkh/THpDdaum8zjHqeC56maIY06vmOiML94tFrG1DQmRvZYBEHp6cxCbY3H3LQkJKUfznTA8/jfif0oc8BtRRR2Xu4pZj9c0sN465ekSk1fqNFDE0d1Gu3nUhTTQT28p6tcFpYa0rF7pqviKTHtmu3B0M4EVVylICAD9jsEquTXo3WK4nDVnc7WQJTgvz7+/QRRkofWmfPYdN47OaAXupVpcMFGNwADrlPNqC27gKaOcoOuxwPweewCfu9s+i1AbxbHHM6FqlDyuKDxEPycTo8WnNgpD1s3cz4tt7e0RR0Y3v89WFsga+Apbcw5+24ycDTsY4MDLbU5gzXHI2kRCqAmSwBybo9ZGWJT/S63OyY1NTJfTsZPWAblRDoLvHrHWpa8VgFA4yMIcn+SJlMsqwrVyQGc4IOabDcmJpTAG4c/5uS0cJu+P3iqWB5hWeHh9N2BTgzmyeDJZ945pXIBzmI+h5Dhj7M0G9CJA+ADo8RYRMfvPron+XKXW+3PZN0tlMI/On3R8UDQPQwArNLVKYe07UoihZk6Z/+PbrwiZ3c7MYXNhq7OVOsn376G6Q1M+WSpODnB62KluC9bpJSwKaU+UC58CTKKXvDd1XHt5ahoumDa67DfNp/NxQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hot/P23kxlkDyiKxipuBD0uTqd6x47pO8fPlqqSam8MXfdCq4hW4hPQLfKgo/p6mfslDayYBlpYT1iMU0l/J+oQ1xueTukFPxh6yIVJ3avuGCfdqXy9ElDp2v6E1qlqi5YkkXW+ylM241KHboIJnAfW8nqICN50GUJAowCUV+j26VI7diIWlLFYF3wbzPq2wJSRUAFnfB6gW/7jpQ/LWxphFiX22YvpeIdZDyTRwGUOQq25nTkrv8zH7kl+FZ7TA2r+3Q/abH3AnoGEBYe/o1+O7V8YbpDIinBVQqfwf7aMYZZ/wJVR9jzxFz23FY42E0oo4pkM+HkV5P4P5U+uDE8hMD2HjOuHZqwFh8A3eEoRD22TwPDnuve9nFk2lmub5fJTAItPb9vOyxGUbKpznwDZuN44Hx4lEQdw2i76SoKuNTZVbMwMWJ6C5QgpIoOvG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 06:05:32.8210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 661554e9-2dd0-4704-2a03-08deacc7d06f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6572

>> Older IBS implementations lacked a hardware privilege filter, so the
>> kernel enabled swfilt=1. Newer AMD CPUs will provide privilege filtering
>> via the RIP[63] bit, making swfilt redundant. Remove the perf unit test
>> that assumes IBS has no hardware-assisted privilege filter.
> 
> Can you add a check for CPU model or capability for this?
> Probably we want to keep this test for older models..

Fixed and posted v3:
https://lore.kernel.org/r/20260508060004.2575-1-ravi.bangoria@amd.com

Thanks Namhyung.

Ravi
