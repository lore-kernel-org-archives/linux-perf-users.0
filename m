Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013015.outbound.protection.outlook.com [40.93.196.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9115B1EE7B7
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 04:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776139256; cv=fail; b=OuUkkWJNTkm0vW+ny02vBsGRilEQSWWyLynU85WOBLFbxlffeqHnLihZlrc3+fTqr2W0/tEpW/82QxJY/WQH78UAhETMG5nrruNaOzTIANNgcIH0NGPW3Q6WXxBYv8Y/jjj5biZNRgEw1JKPmPiz0lJBvKV6sEPaKNwWTy9wEnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776139256; c=relaxed/simple;
	bh=f2eW2vBI2uiqTU5X3bV2UVeNqCtFb5Vl35E7OYY/cgA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=hytXt/Y54kPbfgEOJCZUHN22FEfwT1JlVagERJpdYAi/SYMeAyjuWacGMpl1PJfxX5UIb8qWM9tGJEjT/bCSpc6N8EHmq1pQe/rldPyy19nnlWm4HlVmq/XPbl21tZS/Y1f4LaYM2qgFGGu+3t8xVzLn0rIUsS120pe/vsFTvR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kXiJXSbc; arc=fail smtp.client-ip=40.93.196.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kXiJXSbc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajxqy5a5+XMXT0Q/sIFR8khni4Q6VQnqN+kek8gXrPxbeITOE2sFWkDP3osO0djR6QKB3JmAk5HBUH5luVf5EKTCgBbjZXoXdeTxmWoz9HVIQwgZYT5JIST4c/R7mmpzNWHJtMtZIQ3s2kXKSWxpUW2y1YLnxGUWqEMPwfK/ZNUTacgaZFSREl3Xf0MWJ/QeuscGLmzUxNj0xx3Bhu/JYXV1gHMGqEU1pyYB4NQHXtJnrR+GPPbrv5v14p2mHqw6fcwLa0Wz+9PUqlUr7MFDxvkyKcw+ElfaOClfxYAN2oHJ10OupBnrYG5Dvl2ccMMmgD5nGvFK6mFdyMJizs5m5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhoWNokUmqr5Rk6F2g8S7+DDyY2YfOgdapXbkhK31SI=;
 b=F+jRSlknNXFmasq+QhFlFjstm+vTfOs8x2Aa8ZcxvyI+E/E6g1ws4uJLRd7hRSJl8+r3dk1HxCzF5Jn1CTBaUxqElv+QlUyEW3FklWd4mPNiZ6O4qQPdkkEyNiIbcz1BeAWbFHYiKno4EOks/xji9A+a1hTXfMV79YHm+bGeSibmhPSFl7Q+zi0v/ofOMoF5oNyq1615yDYibBLIRhRCuBHd6QDj6E8ydR0eQ9RcSzZvdRg2kRhAE5z4O3dLDtpQqKZ2MV+QjELVGlHamYIl8Yh3lXbf4adUFlZjYu7CutsvgQsg9QnSfWTNCVXYq3Xxf0Bz7KMAOB8uMDhhy/Hr6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhoWNokUmqr5Rk6F2g8S7+DDyY2YfOgdapXbkhK31SI=;
 b=kXiJXSbcikDJ54OdK4tloM9ixX42oZhhonlw7dT8rjKrDVCCz8KozfPMjpiynfqxHgsPBMHOtPpt18rG25lg3e/Ck3wFOQYQL/CELdm5oCx9wjbrzvqVPXP/EIh7Zh7ngbO2FwXCrENdVfkmJFR7FmBeJMDhJLlT6bNgvL3P/rU=
Received: from MW4PR04CA0060.namprd04.prod.outlook.com (2603:10b6:303:6a::35)
 by DS2PR12MB9775.namprd12.prod.outlook.com (2603:10b6:8:2bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 04:00:50 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:303:6a:cafe::98) by MW4PR04CA0060.outlook.office365.com
 (2603:10b6:303:6a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 04:00:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 04:00:48 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 23:00:47 -0500
Received: from [10.85.36.41] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 13 Apr 2026 23:00:46 -0500
Message-ID: <752bb73b-5828-4d38-b05c-16da0f262d33@amd.com>
Date: Tue, 14 Apr 2026 09:30:40 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [GIT PULL] Performance events changes for v7.1
To: <sashiko@lists.linux.dev>, Ingo Molnar <mingo@kernel.org>
CC: <linux-perf-users@vger.kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <adynEfZ0r_GIu06k@gmail.com>
 <20260413094110.C3CAAC116C6@smtp.kernel.org>
Content-Language: en-US
In-Reply-To: <20260413094110.C3CAAC116C6@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|DS2PR12MB9775:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b2d301b-dd2f-4c4a-dff0-08de99da6978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	WRXuuWLrLik5U2MJ/QRXTxiBoVpRlO6wpG1bZdhorkFZsjomctkmpSMI2y2zTFRtT3Q7v50avzvWF9Z4y7nJpPrjwOxlStFFO+37cJX9yayfV1gn57ygqtdJK33vzLXMiiBQAePBloDkmcfmDzP4z+MRMcisLwxowJDclvH0JqgFS9pZxuAJpQQOEMPQ5bnNU0MxJfHuVnqtvrjMUqYtjbWTd4dsx7qRgBSHu24YQVUaLVov7mtOPab+ZIgTDDojh1t58pBkvDabNu2dxd/uDtl++vhm9RF/09CE4vfP/ILfLvfliIeXYPzhhkfPwCH0H+7ep4M/ZFXFGTKHeEHTLhpE/XSoAeSwkUyQCQSJSSW/KVM1+NglWZ3ux4lOKgaQYDSB76jDkB/SMxqG10qo09yME6zY7qpz6vMjEaD69cyuYQ94F16rOZ+xEFNcHhJmkdgaOaqiJY8Bsq/tHQLiGKyG3RDmff5noXBJAxIPrDjBqIYnf8i54zGfi51YUXVhuZg08xL5uvZ49EAfs6KMKHfvd5JqzLbODHB/+qNiMJ7yWuxwlsw5j6gWONpCthmNq+qncIq1Wl5bWGulVF943pN5YO4p7EFjWJnLwuiwUiu72X92FRty8cObtFZnEgW8PcQEYAihbvVhEBDt+h3x4eLG9jaCP7hnB4Qrf5NSa5HRuzrL81zX1GIWB3iHDs6KaNQQwDLraw4RvDdMsdR1JenmYuvE6+haY4NtZJgV6SDY7re2kqA9glDU75yTIl2jgqTGoLzUOTRVftNcFuM/Gg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LX9jHMgaxJQ68GWlVqA72vcrm1orYwdvNs/SpLmcA3UP6w6p7PHwFUaT1Qh2OQkXPAsj1iFkBTWh19TK01pU4bwlTGNQUOJAp1HAigkhyqTtVKbm/HVAOlW0GmTnsB7wgtuYq87N33PiW9u+/hUxmggbXaEA8DwfK4yJB95WFJ7B78q7r3NjJXdLhQ9BlW7NYxXf5xI3Dej1cMvM5JwPSbubKcgIYlvDe3f40exFtW2E3ppvNKrWpTkSsdgQyPWXCIDSmCYigbWZUtJRh5iT6fdVZuQqyzewb451d2rVSvpBxbqbT/+brUY2avSTNRps6YkXffgPn3nwEapN3dsKY29Qq+/4p8JVpDBPrpOwYfBp6CG30lFKFdxDo70JM2DIGLH+UCGfP2UxebPnJL0IgTw+4d85O9kdyXLZODK73mpmRehxXSQaEBGYTlFQc+42
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 04:00:48.3492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2d301b-dd2f-4c4a-dff0-08de99da6978
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9775

>> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -698,6 +698,8 @@
>>  #define MSR_AMD64_IBSBRTARGET		0xc001103b
>>  #define MSR_AMD64_ICIBSEXTDCTL		0xc001103c
>>  #define MSR_AMD64_IBSOPDATA4		0xc001103d
>> +#define MSR_AMD64_IBSOPCTL2		0xc001103e
>> +#define MSR_AMD64_IBSFETCHCTL2		0xc001103f
>>  #define MSR_AMD64_IBS_REG_COUNT_MAX	8 /* includes MSR_AMD64_IBSBRTARGET */
> 
> This isn't a regression from the current patch, but looking at the adjacent
> MSR handling code, is there a potential stack buffer overflow in the IBS
> NMI handler on CPUs supporting IBS_CAPS_OPDATA4?
> 
> In arch/x86/events/amd/ibs.c, struct perf_ibs_data is allocated on the
> stack in perf_ibs_handle_irq(). Its regs array is sized using
> MSR_AMD64_IBS_REG_COUNT_MAX, which is 8.
> 
> When handling a perf_ibs_op event, the initial read loop fetches up to 7
> MSRs, advancing the pointer buf to &ibs_data.regs[7].
> 
> Subsequently, the handler reads additional MSRs depending on CPU caps:
> 
> 	if (event->attr.sample_type & PERF_SAMPLE_RAW) {
> 		if (perf_ibs == &perf_ibs_op) {
> 			if (ibs_caps & IBS_CAPS_BRNTRGT) {
> 				rdmsrq(MSR_AMD64_IBSBRTARGET, *buf++);
> 				br_target_idx = size;
> 				size++;
> 			}
> 			if (ibs_caps & IBS_CAPS_OPDATA4) {
> 				rdmsrq(MSR_AMD64_IBSOPDATA4, *buf++);
> 				size++;
> 			}
> 		}
> 
> If the CPU supports IBS_CAPS_BRNTRGT, MSR_AMD64_IBSBRTARGET is read into
> regs[7], advancing buf to &regs[8].
> 
> If the CPU also supports IBS_CAPS_OPDATA4, it reads MSR_AMD64_IBSOPDATA4 into
> the next pointer position, which translates to regs[8]. This writes one
> element past the end of the 8-element array, overwriting adjacent local
> variables on the stack.
> 
> Furthermore, ibs_data.size is incremented to 9, so
> perf_sample_save_raw_data() will subsequently read 72 bytes of regs,
> exposing the corrupted stack data to user-space in the raw perf record. Since
> unprivileged users can configure RAW IBS events, this might lead to
> unintended behavior.
> 
> Should MSR_AMD64_IBS_REG_COUNT_MAX be increased to account for
> IBS_CAPS_OPDATA4?

Thanks for the bug report.

While this seems like a genuine overflow issue, IbsOpData4 has been
deprecated from long back. I was unable to find any platform that
supports it. So it's not a real a concern.

Thanks,
Ravi
