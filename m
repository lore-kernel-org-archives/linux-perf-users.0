Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFDC33EB01
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 05:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788152719; cv=fail; b=eMx5n4VPDdFxBKEGHfnavc4trEFN3bb3CTfvy8PrVDhihYMhwwz//CVg2NDq7Gz8O1zp27ATF1iqyQfMk7hkHWNwkE36/HpvQT/S3yqOM5vk8r0jj4UI2qTVwqvjkxJnsSYVbyl5/UsWViMO+WK1rEorPH2OEDsZEGnUK4V/pBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788152719; c=relaxed/simple;
	bh=g600xTOi90ggkgNq/Fd5cuOrxsMXv9FeDXeNKMrXOwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dYI2IKllOg85Lwgq1W32tYQRP0FCMBeFiBuNfLg7Q5L9eEJX5+0Mqg5VY9kriCMz2F2DeC88f9++X+0IMr6yYwqrsT4ijvSoTMqXVssUKEFLT8pbVy/QjAxqlSAm8Ct2WMPIULyatty8jrSy0OmpyWRhIhnWHi5eGKH59C2gkRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GgPFfuaQ; arc=fail smtp.client-ip=52.101.52.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GgPFfuaQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f17dx3ljdQADNtDZkBBRnFw+vBqu70EQz3YJoE1rUz0J1JZGk4Kmtn72LkPemhiCYU+plcYIDXAnwWpsm3b6gFoyry9uAVNBApGxZjSwOh82dyMUNbGoVjEKZd4XNTA508WIJpcbdIB8wmdPT1b2n/MygKTuRMd0JzK+7imetgxwj27TMdNEXVem/CJSz7QJq3XWJpckF5Mp3G9xZ1av9n/jSgw24N1DdtCScxRBrq1gzjMXyX3tA2sUFCMeYcO43kztjSM+YRHr8WNgB2Z/UM27TPRn6+fmqQSf//Ck2/opb8sd9W12cS4ARsufw4QqpIABm9H46iGe1+9aIMei5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssRHzBpFNILdbmsndKzm1cmm8pz5/uvVhOf9lWKplPw=;
 b=wIKB1waaNt2zVSm2inKtmTyBQqhQnOvb8IzjQgbUoLbTWnl+9ePnW9NmHkBTIrxoV4X7LAf6ryvM4+7bEQzw2uE/JHoi9pZBNscMFtExBg0RzcOu0+kj6GQvyrWgplpX2qj5KfsDrHsP3KDYyBFYKRs/3Q4SdhgvYM7rnCSOEKhO1CJ8fXo0M3HNURkxkumDRhzUjX8zxFni9InS1DO9jHACo/cb2Nnd66fuyBHpS+cX6Mf74wxj4oxUO6c0eVcGQcPC/Hln6mQCxzSOPqJEcy0mvi5ZDpmIWJT1ck+StWiv+wHsmS16r1+z5CKKLqbYy96ic8KbZxwMlCJEBwtFzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssRHzBpFNILdbmsndKzm1cmm8pz5/uvVhOf9lWKplPw=;
 b=GgPFfuaQGgOAb67EO68batR3B2KCsRFzg2MvuT77PMgppCKZKv8cQeafKejQX8o+bhZJ+P5TXzwG4/ly3gBbwxEo/8psoLkDf2BgEFid33nkFbV3w4Z8kqGCd2bVe35iDCSefxmIcC3hLKH+1iYQpr1WFAL4zTbDZbuPr9uw8QI=
Received: from BY1P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::9)
 by PH0PR12MB5631.namprd12.prod.outlook.com (2603:10b6:510:144::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 05:05:14 +0000
Received: from MWH0EPF000C6195.namprd02.prod.outlook.com
 (2603:10b6:a03:59d:cafe::52) by BY1P220CA0014.outlook.office365.com
 (2603:10b6:a03:59d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 05:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6195.mail.protection.outlook.com (10.167.249.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 05:05:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 00:05:13 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 00:05:14 -0500
Received: from [10.85.39.94] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 00:05:12 -0500
Message-ID: <27d79477-c469-413b-95bd-c6c1f8a40f55@amd.com>
Date: Mon, 31 Aug 2026 10:35:06 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DISCUSSION] Three problems behind broken "perf --call-graph
 dwarf" on AMD: IP and stack dump mismatch, libdw fails on lld's layout, and
 the unwinder fallback never runs
To: Namhyung Kim <namhyung@kernel.org>, Gennady Kupava
	<gennady.kupava@gmail.com>
CC: <linux-perf-users@vger.kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <CAPu-DQqF0aF6=GS8Z6KKWeeX_V5LiXeKU_rJQZC+uGg8zuTPNw@mail.gmail.com>
 <apCyQ93c48Dy4H-S@google.com> <apG-RzV0zyjoC-FY@google.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <apG-RzV0zyjoC-FY@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6195:EE_|PH0PR12MB5631:EE_
X-MS-Office365-Filtering-Correlation-Id: b2eb9538-e908-40c2-9f44-08df071d70d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|18002099003|22082099003|56012099006|4143699003|11063799006|5023799004|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	L1UJ8hC5Y1WmkQ/tAJTst+rm4JA57IBLuK5chIKDwjquV7+a6xKnFAVbuLRr0wOwBFwiUn7vSVXGvBzl2Ao8XKkSCa8g7HzSgA3KTb6A5hTrcjz9brA3+0v6cIwFumISI/thulKFua0BN0m6ybVMJKCJwUJyD8Zl1Zi0KlZUAXgDQgYksrKr61f0uqNY54lyYHy412mZeif4dOE5KWzI9YKu8Tl9I4GGARZtiLK8oJ2OXdj20rDem8pQgmwBEZNH0QhfMepqHswTkW4OiZ18nih+Rs3mNi/77f2dSYtNNbnyIkbcxxQcaVoHEcwB9NR2hAAZx6Nm0dizBchIRey0PITKtcR3QsWUgAHQi9JvUK7GczI5b1+r9D7UbW37fRs4roZvDRl9g71bw/qEg2/UjvBjCx4q7mrV71lffUI8IfunD5NzFeOtQ1r1/77uDJz7mVFuOdERm5gf4D9gcuiUA5KwJPVA3jtXAA/sSBG4jFpJ4Wwr0PPSn3VM/iNrlaY4BEsYWtKASnc8bymUW8+ZGcNGlOA96H90YS1kkycZ2fCc22AjJox31pKETvkzqvGARq0tIdCUTlE+6WOxSkcderm3+jOJwXtj/rrgRF+jAAqjuN9tWFO/oALw943LQWILWJxiO5+MzTFpnl4CY5NrTcFk9x2TK1fhSaef6L28AOOoMrXIBrDYYTxyDAhjaytdriilBSDo0JepDtxf/WZr+Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(5023799004)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YKscR3mnIUO9OE6RTn7JgfzpwpN75Rxn2SOZ/nlrQNs38mXsqovbQnMzPk5ZqfeRAdVN7QbS+n4D2KeU/NqBJs95/z8cYKM7cHXXG4XyCx6dkz2g8syVAKNQdoUotPZPI2eM7VgfkMIdaMsGItmAI4WYBaU3Nu4SDDAmFHlvB5kmhBJUhcOi3wtIqi5FOnmYttjPunW2NdnYZmkApD7DnsGCi5HngluYV4BKVPnlwHBW16V5Z7I9Ha+H8W9cmjBOIfgKLpEFpbZwca7upHCmaXzgcySxegEQfRpvS3+MRyHCyZ5EZ9SKrn7cKd0fDTbM0tuoMjRRst8z4lS/liTbPgyyo8KYlGGoUd9HGQOVlNLPMh0pxbMeJ30EWhr/4G7dW8l8Sx7JtTBz2K12QvUjjFbxYNoHZv4EkKVsICcExEVrYP6GqsBMt46JrtbYteZQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 05:05:13.7864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2eb9538-e908-40c2-9f44-08df071d70d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6195.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5631

>>> 2. perf: precise events and DWARF call graphs are mutually exclusive on this
>>>    hardware, so arguably perf should simply not let the two be combined.  I
>>>    would suggest two rules rather than one, because a blanket refusal would
>>>    make the common case worse:
>>>
>>>    - for the default event, drop the P when --call-graph dwarf is requested,
>>>      silently and on PMUs where precision means IBS.  Otherwise a plain
>>>      "perf record -g --call-graph dwarf" starts failing outright on every AMD
>>>      box, which is worse than today.  The s390 case in evlist.c suggests this
>>>      kind of substitution is considered acceptable;
>>>
>>>    - if the user asked for a precise event explicitly and also asked for
>>>      DWARF call chains, refuse with a message that says why and what to do,
>>>      instead of quietly producing a useless result.
>>>
>>>    Note that this should be scoped to IBS.  On Intel, PEBS records the whole
>>>    register set, so precise events and DWARF unwinding work together there
>>>    and nothing needs restricting.  Frame-pointer call graphs are also fine
>>>    with precise events - only the leaf frame is off.
>>
>> I think we can enable both precise IP and dwarf callchains by using
>> PERF_SAMPLE_REGS_INTR.  For unwinding, it should use PERF_REG_X86_IP
>> from the REGS_INTR instead of sample.ip
> 
> Ok, it seems we already do this in the perf tools but it looks like the
> kernel already overwrote the PERF_REG_X86_IP with the precise IP.  I
> feel like we should fix the kernel.

This should resolve the DWARF unwinding issue with IBS PMUs:

--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1523,8 +1523,11 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 			goto out;
 		}
 
-		set_linear_ip(&regs, ibs_data.regs[1]);
-		regs.flags |= PERF_EFLAGS_EXACT;
+		if (event->attr.sample_type & PERF_SAMPLE_IP) {
+			data.ip = ibs_data.regs[1];
+			data.sample_flags |= PERF_SAMPLE_IP;
+			regs.flags |= PERF_EFLAGS_EXACT;
+		}
 	}
 
 	if (((ibs_caps & IBS_CAPS_BIT63_FILTER) ||
---

However, there's no way to address the stack being out of sync with the
IBS RIP, since the IBS HW does not capture GPRs alongside the sample.

Thanks,
Ravi
