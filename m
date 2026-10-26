Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792984204;
	b=YzLN7SRos4I9j/XPkYkxnH9Qj+Rpr2aKN5dlUW/MyBu2Q0oRSvv52cxPCajjFCMYgZ+c
	 coPIsZeHqq1RyATwGO7CIWxQwgddAJiv14GIqXJAzpKImYZwso9I1RS/F+ciC0qUKulDm
	 AxQoQ79uIjciHK/pBtyabdeDKkLivOF04ZdPI/5txAKOEYuWbyw0bgtp74CY7snraEXOP
	 rNCfZlVprUKIffSZqi+tsdPmQVCYGnEk4qjklRadekkWOtP7qTz4ij6hj7KrFgNePK82W
	 vYBLiu0AbO4DMDLa1xmfQkWPdFZcHU2D7vujYGRMNunOj1MfXY1/AaGlTq5XVtewfpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984204;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:CC:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=YCzui905v4je35FdXvqXliNGW/aSOdKO4mVBbdhKkfg=;
	b=fboO7vDT5R6av2v3o1pFJeJBWcY8bA0zmm5iF5wNC8eJsQ/pQQ4IYc2vLPSAYV36yRVq
	 PlAR4zGPtpfln5htfhyoiRskDp6np8BblF51lZk0gAnY0SA44TWWHjzRHzN5KLHIc0kRC
	 Gxej5T7Rj5hCFIOpcd/5vWRZtu8WLBsimgRVHNP4sch5vnG/RKYJl0up+mH1iKGeIS+tH
	 cn3UGEtHpreTTCcz4MJyS/1fbBNReygoZYCXJC5cljs3V5ZzZS7SyYhrpvloiwpnluMgu
	 ev/QM6Gxl8voCiv1TbNYRHBBZ3tOJnHlqE+H8NddGnJcV6LQ04N8zFNc87u1LrgHTBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bbnVbiLz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.22
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013022.outbound.protection.outlook.com [40.93.196.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFCF606A31B;
	Mon, 26 Oct 2026 03:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BFCF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bbnVbiLz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfVhdxAUJZzaaF9Tf3sTfT9Fl00gVvziOySN10EGzz4GvhbV8n4o0ojEplZMrD5tHzTW77zPAo2HMVaZZywd+dXuk48sIgBBNObJ5V0jCgckQzV00VU0ONHR2tNXKb1abZnjW3Om0+2/xdFyt9w2+r+igblMmHtn4ffScBfaastkYYskG8srIxDQJkDzQNP2nOuSG+auKCK8LZ8iBNPVkpYMazMFhm1NubFa2JZxkQB8UA1EYkbBHJC26V+EjMmsRRZBI+bWgeU41y+yihyPyOr9Kn4wsbmS6LXxhvQCYm/tWpHiwo2i2+w9av5knk2YBlo3NMk+07hOtGYLT6cAIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCzui905v4je35FdXvqXliNGW/aSOdKO4mVBbdhKkfg=;
 b=Mv4Q5wEHjE/SaWiDL2PsUWbjDW6vJXFPZUI+nx786Jc0hP7P0n7DN/qTvV1boUcHB9llTX+SBc5f1Ki5qBCROGc5CrUPOQiLRe0sUZVV9LmPyxwXCqPqqegX/8VugpqXBZ/4TJ3WZRtAwJNrYkZMxahUMnbiNC6nDW5sqG/EVk5ffidwyjCi6OUQFgt+AgtWC0yVTCabtOkaqGKQgTpKXETgJe86y9v94DmA15KcpbyUpQCOM35q8sSZGGBkJwhWZyFqzm3fsXrkuEXVVaPs0UrEWHQsKCzsxA0DFsb9yGAKzk9QovOl2EzjfyJMQljBpTYKY1sP81fqV+1SQF6ghg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCzui905v4je35FdXvqXliNGW/aSOdKO4mVBbdhKkfg=;
 b=bbnVbiLzWjx2ibcvaIKhBopynYKAbTxr+E/aTrWOVmdxGA/xsVylLnzLL4EalZu1izlYE33T/vuJgvFAS7U/VFKJAltagnVWDtR8D7xyy8auj7GuPl6djetiXKG5xoW/nf8B6C0XE0U4UD+M0Z6qzvgdbmOFXO4MY1/ANxwYxDM=
Received: from BN0PR04CA0119.namprd04.prod.outlook.com (2603:10b6:408:ec::34)
 by LV0PR12MB351767.namprd12.prod.outlook.com (2603:10b6:408:3fc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 03:09:59 +0000
Received: from BN6PEPF00000073.namprd03.prod.outlook.com
 (2603:10b6:408:ec:cafe::a3) by BN0PR04CA0119.outlook.office365.com
 (2603:10b6:408:ec::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 03:09:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN6PEPF00000073.mail.protection.outlook.com (10.167.248.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 03:09:59 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 25 Oct
 2026 22:09:58 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 25 Oct
 2026 22:09:58 -0500
Received: from [10.85.33.186] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Sun, 25 Oct 2026 22:09:54 -0500
Message-ID: <93c41471-6d68-42b2-a48a-11b714d44d1c@amd.com>
Date: Mon, 26 Oct 2026 08:39:48 +0530
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH 2/3] perf/amd/ibs: Fix kernel address leak via REGS_USER
To: Jim Mattson <jmattson@google.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Jayapal Ashwin Nair <janair@amd.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, <x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>,
	Manali Shukla <manali.shukla@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20261015060430.5877-1-ravi.bangoria@amd.com>
 <20261015060430.5877-3-ravi.bangoria@amd.com>
 <CALMp9eR7BFGU0zOwTmLF571t-ZcuY5NjkD2nNXWNJoa=cEitTw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALMp9eR7BFGU0zOwTmLF571t-ZcuY5NjkD2nNXWNJoa=cEitTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000073:EE_|LV0PR12MB351767:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bf2c9aa-23cd-468f-4cf1-08df330e9e7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|11063799006|4143699003|56012099006|261009223027099003|261022105027099003|261022075727099003|261021121427099003|261021123027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	mBy6j8xp5Qb2Duk4W5ej+O4fx9Tq0pvquZ2dJ4+c6N6UzM4M9LZ8HxPFlZNNz1KHiu2lyzo1cMai23lNj6MJ0fLsr4r09PQPZX9JE7/e+/m7v4qJbRKmjEqDAztK4kBx/EvnTIpKjmab/iJ7Vu7H54hv9E2kYYKt+9hkOd7qa9PvF7MOjFbUgmbSepthck6qU91xL18WiyKaLvGCrNo/T/GHopGfbVI6hh7eDjvJ+dr0ecLCiN1AReKr1zxKoQeMaXbbn/bRQHhVh1XigjjFnD1KUXA7e4PdyuTb71xt6zrVdMAlnVP9cWDrj1Po0JJx6AeBAf3Oyk5AIGC5lvj3Jm+OUQEO0Lfi3ZA8sLdc012AgD/4FnR778VLZxNVMRItLpwWb8abSZZqoXHuRiNO2lTkC632lLEm2yiyxZGgnPu5JL04CIgKgWxjE5VsV/jQvZJLNJ1kBlhRDPGrwxziDEmT7zoiP5XPT/DJDHfA/2+rVgqoymba1Wxs6SvcoezuZi4FFZpa5cva0QA4UtjlSgxQEL14jiUBLnlQ4hRu5qUTYOp62I+gJuI5YT6ZEEmfNYBdZa5n2gm75NHbMBBVGm0ZppOze1WdNRMf3vT37lPwQZZfQKoJrzwylfPBpeLTL0BohaEZMy6bFJfXzh+kEXHLvTSIGkVaTxB/6tSgyJsyZEd+J2sCR8mmY+he993PYXZTlavIpmjZZRcEQUSBRg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(11063799006)(4143699003)(56012099006)(261009223027099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KDBqp5wG/G1Io+8TgQys07GmgZuG27WX5ZqN8f5bfTyva31DKAJhfZ1z07LNNhCPNp1LycleW5OGgNhVQYxTgheaKUb6lI9iABCunfGMJekuwfyOC5Z3a7cAW5cRLRVDqGznJg885F287KvD4ATAyYCRTnx7mm0W0622m4rQbfxRfmzb87GsgzVkWe7/q2EAS1mBOXIq1eafBCX28aGkNfLfGu13gUBKtP/TA37Uv0PmkRcPyCXWwYt1sNpZlRymgCVTDYrx1W6Pc3cYZMo9WvqnY7210TEMvFBTOb7/H7ojp9+RuaJG+ad6PEbU3lNEYZOTugasNNHNo7d7LUvOS5mVAVicKRx97zaPucLEDmNYQYOMcaqrhKS9y+GSyfKlNkwp2hmg3XyXC1YPMv8M9ovrt7p8xWyS09KAAGZ32Ajpq/6cfLZcNP8ik91r8znn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 03:09:59.0836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf2c9aa-23cd-468f-4cf1-08df330e9e7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF00000073.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB351767

Jim,

Apologies, it took me some time to get back to this.

>> IBS hardware captures a sample and raises an NMI. Since the NMI can be
>> delivered with a delay, a privilege change may occur between sample
>> capture and NMI delivery. Because IBS only provides the sample RIP, the
>> kernel records GPRs from the NMI pt_regs, which may reflect kernel mode
>> if a privilege switch occurred in the interim. This can leak kernel
>> addresses to unprivileged users through PERF_SAMPLE_REGS_USER.
>>
>> Fix this by discarding samples where the NMI arrives in kernel mode and
>> the user has set exclude_kernel.
> 
> This will systematically under-sample instructions just before a
> transition to the kernel. For this special case, perhaps the GPRs
> could be obtained from task_pt_regs(current) instead of the NMI
> pt_regs?

Yes, that's a better approach.

>> Reported-by: Jayapal Ashwin Nair <janair@amd.com>
>> Fixes: d29e744c7167 ("perf/x86: Relax privilege filter restriction on AMD IBS")
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
>> ---
>>  arch/x86/events/amd/ibs.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
>> index bfb51f8e184f..3cb46c775eaa 100644
>> --- a/arch/x86/events/amd/ibs.c
>> +++ b/arch/x86/events/amd/ibs.c
>> @@ -1373,12 +1373,15 @@ static bool perf_ibs_is_kernel_br_target(struct perf_event *event,
>>  }
>>
>>  static bool perf_ibs_discard_sample(struct perf_ibs *perf_ibs, struct perf_event *event,
>> -                                   struct pt_regs *regs, struct perf_ibs_data *ibs_data,
>> -                                   int br_target_idx)
>> +                                   struct pt_regs *regs, struct pt_regs *iregs,
>> +                                   struct perf_ibs_data *ibs_data, int br_target_idx)
>>  {
>>         if (perf_exclude_event(event, regs))
>>                 return true;
>>
>> +       if (perf_exclude_event(event, iregs))
>> +               return true;
> 
> This excludes events with an NMI skid past a privilege change in both
> directions. Do you want to omit a kernel sample taken just before
> returning to userspace if the NMI arrives in userspace and
> exclude_user is set?

Yes, its a valid concern.

Will post a v2 with these addressed.

Thanks,
Ravi
