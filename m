Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013062.outbound.protection.outlook.com [40.93.196.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514817D6;
	Wed, 28 Jan 2026 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769617523; cv=fail; b=ZG3S4QvSFBZkLxoNfKEdBSrBzrAfKJrLm+rTA+H/M/GG+P+kZ5M7uVD1ZgO17M/Y8s1xyryM5ZZHlh8TeWryuAY0jwNVcK2R45p2kCmxiTDIMJQyGk+B2HVXNX/VNprRjnpD7PTETLN5h8fd7g7sVxB5+YBBYYHRZ7qYADQl+/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769617523; c=relaxed/simple;
	bh=J11tsEFfoWExWPnfvVvwUKv2/6wvCwwGZRDnnD9suQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=I2zwMTfYtDjvqp7wy3CgzhQ6YKULaPVJ+2MuqeQbnZD3QT4hgAOozIJhaBZ2YZocMIMb9teXamYRgAADaVGAkFl/jYf1mVt5nlyu/D3fBoWOJVpxFCMQktl43V9AUo7qnUpGTOy6lqec3EDV/ts9mBoM+2LOY0YwewoDxjDuL+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bHE/rmZR; arc=fail smtp.client-ip=40.93.196.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bHE/rmZR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3Cw1gnX5O4FGLuWjO3z00rTybNDaqnn7uZzvrnduhcKcgy5tNrMi5EsORsu6AuCIWoCKkxEPU+i8NQN8RSqJo8daSAlBmcI8e5cFJUs7Ulc0JSMi5FHq3NrEzcSvB88sGIk9QbmTAXBbPTJILVLx5FI74kxvYRvle2MrXRx3zk5HnXU68COCBMU3CaWX/U/p+/gs1hLPl4+BUFwsUqHKzY+11ct1SLPLoauV6Y6zbQFWKdlh7PD+uASx+Bq0mVBsepj6GQV8+N9KtyGLIU9vluY5hcng04UoCFDedmbQyKwm4e/XSChfR3vUmCK5t8RR51wiO+AuKrfXZGce4Cnsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHCC7zPVWM8KavDAEVqVhtWu2a0Z0tWuel4oJ4TBxNo=;
 b=Z63EQuK7CJP83pcfpfzYG9OMOK6Yz+JO/4frxagiFRFy880xQ/Mu8OntX0eszJFYmTY86HVLX/zFkmAdW4I7fnsUUewvNTEO8J6hc79/dULtc1S3gikL1jPu3eaOcHjl6GBt86aVCwJnBQj9eGC2+wQ9rR88B5K591GmH4STDTGumfJTmB81FQ95XaIOtg7Xt7F2oOe7XgCwMPjdWlHVw+7h9D2UEjMh7Hui8FI0q5garaS2nN78BSC0nElXGD7yhYQIojgaqAWFhEZrZa2zBXvLPGhm8DhXCZvhsOZczy4L/+iDOl9dficJDJTm2anLBoqZEVn5lIxgQPaSlOY/XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHCC7zPVWM8KavDAEVqVhtWu2a0Z0tWuel4oJ4TBxNo=;
 b=bHE/rmZRJ0IEzz9k3SMdDdVvRgD1RlmPAhBaAWIn8boKF4F9XpOab4C/IaIvWcOKN2gTMsq8p/amIQZqu25lSXkyy5KbTK1T4fUdAg1E5scJ19NEmCtl1mK1usqUUA4w9viPjXRUKZCaGvRL/nA73jzF/MkU6gZI+aU9LHwtNBY=
Received: from PH7P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::27)
 by DS2PR12MB9639.namprd12.prod.outlook.com (2603:10b6:8:27a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 16:25:17 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:33a:cafe::e1) by PH7P222CA0022.outlook.office365.com
 (2603:10b6:510:33a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 16:25:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 16:25:16 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 28 Jan
 2026 10:25:15 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 28 Jan
 2026 08:25:15 -0800
Received: from [10.252.192.223] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 28 Jan 2026 08:25:11 -0800
Message-ID: <50e3ac65-fc5d-47d0-bdc4-5c8c1fc8eac1@amd.com>
Date: Wed, 28 Jan 2026 21:55:05 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] perf header: Replace hardcoded max cpus by
 MAX_NR_CPUS
To: Shrikanth Hegde <sshegde@linux.ibm.com>, <acme@kernel.org>
CC: <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, <thomas.falcon@intel.com>,
	<ashelat@redhat.com>, <yu.c.chen@intel.com>, <gautham.shenoy@amd.com>,
	<ravi.bangoria@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <peterz@infradead.org>,
	<mingo@redhat.com>, <namhyung@kernel.org>, <irogers@google.com>,
	<james.clark@arm.com>
References: <20260127185000.431884-1-swapnil.sapkal@amd.com>
 <20260127185000.431884-2-swapnil.sapkal@amd.com>
 <0117fe41-0016-49d7-bc73-1ec682ca8783@linux.ibm.com>
Content-Language: en-GB
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
In-Reply-To: <0117fe41-0016-49d7-bc73-1ec682ca8783@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|DS2PR12MB9639:EE_
X-MS-Office365-Filtering-Correlation-Id: 39572167-2cb4-4f16-93a0-08de5e89d27d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFhDZmc0ZXA0V1BheHhhMCtyd1oyOXpEOVVNRkxzMHp2di9sZGxFZTlVQXhk?=
 =?utf-8?B?V2xIVmllZG1KNVdXdFVJU0lYeXJRSGsxZG1LTDlCRkI2RmQzWGlCOHdERjhy?=
 =?utf-8?B?L1RvNURhSmVmUnZ3L0FSK0dGaDZWSDNNWHhlOW1aTVpwRWxFanF3YWJ0Nm54?=
 =?utf-8?B?Y2VxekpuTUhUQUx5NnlBWTFIbHRXcEkyVk16b0dmdk5DWWg2bjZWQ3NvYlVO?=
 =?utf-8?B?MExXeW5ZM0pTUjhPbVF5aTVwbEdlaExmVUt5VWdMTiszcUlnOVNNTDVkajZG?=
 =?utf-8?B?WUNUeUV0c2dNbTFTemJESSt1Ryt3a0NkRWdBcFRDS05KaXpkRWlZWGdOeVI0?=
 =?utf-8?B?R3llTm8rY0FPZGVIQUhWWDlTNzVmK3AwbkUrQXkrcWQ2QUx0dGtGTkd2TDE2?=
 =?utf-8?B?d1JMUnV4d2s2L0ZYV0FyVElqZjZxK3B0WU1YT0ZJTVlUMjNBRmVLMzE2OTFi?=
 =?utf-8?B?SVUzcVVKaHZzbG1qL0NvMlhBMHhJY0tHNzB2K1l3Zkxyb1Uxd3VtNEozTHpF?=
 =?utf-8?B?WmdiNHgzMWtNWkdzWXNVYkVhbWZOemNZWXdaajBpb0RNbnNtdnB5ekpDK0oy?=
 =?utf-8?B?Ny9DRkNpRDdGUE95dFdKb0lTTVhlZy9zVGF2Z1ZYalZmbXJpRjE1K3g4QU1O?=
 =?utf-8?B?eEcwekgxTlpac3pRUC9HRW00MmxDTEpHNlJpM3RLUnVHZitvTGtnTHAya1JG?=
 =?utf-8?B?YnJSMktPNGFsREhqWUN0U1FlMnNVTWtxS2wvVkZqMzZET0JPQ2VmeWNLYkRi?=
 =?utf-8?B?L3diSy94T1IzWWc4QW5UN1EvWG9zcEljSm9mTzlZcVlvamw1ZlBFaWg1Umwv?=
 =?utf-8?B?bTB2MC9NUWxCRkNsamJMeVFySTNzaXNjV2dUV1hQWkIybjhVSm5adzdSNENY?=
 =?utf-8?B?TnpRWGJ1NURxa3hPclZWWEp5d3VoT254TE9LMlliTzAyTjNLdFBnRnpFSitV?=
 =?utf-8?B?bUFCM0xjTDFPOVFRek45bmxxeGNSQVZWKzFQNDdvTzM3K2VsbGRwdTA5dmY2?=
 =?utf-8?B?YjNNUWJtM2FYRk01NmJrUlZNdVZJNG1lNmpjNk11bmNNVVJkZTFWbi81WnRY?=
 =?utf-8?B?bDJ5TzBKSXk0RytDVTdwMGtqU29oazQ3eHBmV1NkOVErbk9WOHc5RXUxci96?=
 =?utf-8?B?WEhUQnJlelVjWlpxSVdWNUg0aHBvWmtYdkxwNXhUTFhScGRBQ25vcW1RVklH?=
 =?utf-8?B?dE1tcXA0L3FqTHF1c3hQOGNGQS9pOVhNWk1oL2I3UjZwbmxmNU4xVFQ2UC8x?=
 =?utf-8?B?OVdUYmhzTWhieHZhMjZNUnRhMkl4NEVlZ0FOK0hDMUdWd01KK3hPMCtRaDlI?=
 =?utf-8?B?OW03bUNkVndSSHBaS2VnMDY0QkNScVVEVWFTaHhaUzFMTnNJWEh2Z3ROOXVt?=
 =?utf-8?B?bFZrRE43QzN0N3o3VEl5S1RLMUVpRGlhMzliVDUvM2JnWThmcGtZWmlzRDRY?=
 =?utf-8?B?OWpBZ2FBNnJJRjJ3THZZYnpTMGM5Uk1Bem13ZnFvVWsxbHRYMUVSeFpnZTdn?=
 =?utf-8?B?RXVtMEdzNEpBZnc1cFdIQUJNNFV0cERXNFR1akptTjZGRzZ4QmU0ZTdTQkhu?=
 =?utf-8?B?T1hwSjE2M1kyVU8wdEc5aFBpTm9TejE5b042RHVSQXpkcW9IVURLNTBrK0J0?=
 =?utf-8?B?N3Ivc3BYL2dCNnJMa0d2MWQ1clhsUkJFQUZJNEhVMjUzNlRTeDZ4amI3NnlY?=
 =?utf-8?B?SnNLVXhPbXZpUDk4VlhzdnpFQ3d6WVhIcnVJajFObWtiZzhDbnZpOXdBOE50?=
 =?utf-8?B?cUhrc21HdEVObGpYRmUyTTdPYVJmNG5nbVBZUXU3alBZWmoxYUNVMTBpRjJU?=
 =?utf-8?B?UitEaFN5ZGNzeE96eXoxUnRRbW02ZkMzRU5seU0xakNKZm43NUFCU3dOSVhO?=
 =?utf-8?B?SmZuRUxpRFRLbHlKRUxHSlliMXpmc2NYeGVKR1poOVNvU1FZMkpuaVRIaDgz?=
 =?utf-8?B?dDB6WUE4dXBuZ3hDS09zZ2pFSk4vRUwvWklhemVHS1RRNzhMU0ZTSjVvbDlN?=
 =?utf-8?B?amUrYkhHNEpUNUF1eFRJTFZ5MGtOWWFEMVZwbWFPMWF4bElNWFRzc3dnUVFL?=
 =?utf-8?B?S2ZVbDNISHYvUjNvK2w0S3d5aXVQU29hWnpCeTBpci9Jamg2Q1RjaEVwMCtW?=
 =?utf-8?B?TTZWd3p2Uk9MTW9VZHpkeUIyTHhQcW00Yyt5UFBXeU12Zm5TaGFYNmNNUGVE?=
 =?utf-8?B?d241M1h2cjZyeTdGVTBNN2lwa3MxNzRnWmI3RDR6eTdxQ094bFlHMWlHbVRP?=
 =?utf-8?B?YW4rcmZVR2VrK1NxbjlqUmpsR1RRPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 16:25:16.7293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39572167-2cb4-4f16-93a0-08de5e89d27d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9639

Hi Srikanth, Arnaldo,

Thank you for reviewing the patches.

On 28-01-2026 13:09, Shrikanth Hegde wrote:
> 
> 
> On 1/28/26 12:19 AM, Swapnil Sapkal wrote:
>> cpumask and cpulist from cpu-domain header have hardcoded max_cpus value
>> of 1024. Current systems have more cpus than this value. Replace it with
>> MAX_NR_CPUS. Also define a macro to represent domain name length.
>>
>> Fixes: d40c68a49f69 ("perf header: Support CPU DOMAIN relation info")
>> Reported-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
>> ---
>>   tools/perf/util/header.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
>> index eefd1cd73b6a..31c3bab1b10a 100644
>> --- a/tools/perf/util/header.c
>> +++ b/tools/perf/util/header.c
>> @@ -76,6 +76,7 @@ static const u64 __perf_magic2    = 
>> 0x32454c4946524550ULL;
>>   static const u64 __perf_magic2_sw = 0x50455246494c4532ULL;
>>   #define PERF_MAGIC    __perf_magic2
>> +#define DNAME_LEN    16
>>   const char perf_version_string[] = PERF_VERSION;
>> @@ -1616,10 +1617,10 @@ static int write_pmu_caps(struct feat_fd *ff,
>>   struct cpu_domain_map **build_cpu_domain_map(u32 *schedstat_version, 
>> u32 *max_sched_domains, u32 nr)
>>   {
>> +    char dname[DNAME_LEN], cpumask[MAX_NR_CPUS];
>>       struct domain_info *domain_info;
>>       struct cpu_domain_map **cd_map;
>> -    char dname[16], cpumask[256];
>> -    char cpulist[1024];
>> +    char cpulist[MAX_NR_CPUS];
>>       char *line = NULL;
>>       u32 cpu, domain;
>>       u32 dcount = 0;
> 
> Looking at
> https://lore.kernel.org/all/20260119175833.340369-3-swapnil.sapkal@amd.com/
> 
> There was one more "char cpus[1024]"  in tools/perf/util/util.c.
> You may need to fix that too. It is unlikely but, if one has created 
> exclusive
> cpusets comprising of only one cpu from a core, maybe you will run out 
> the length.
> So better use the MAX_NR_CPUS there as well.

Yes, I missed this.

Arnaldo, can you please consider the below diff? Let me know if you'd 
like me to respin the patch.

--
Thanks and Regards,
Swapnil

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index c83e59e8c787..3795d5182ce8 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -262,7 +262,7 @@ void cpumask_to_cpulist(char *cpumask, char *cpulist)
         int i, j, bm_size, nbits;
         int len = strlen(cpumask);
         unsigned long *bm;
-       char cpus[1024];
+       char cpus[MAX_NR_CPUS];

         for (i = 0; i < len; i++) {
                 if (cpumask[i] == ',') {
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 394dbfa944ac..c43f17137efd 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -6,6 +6,7 @@
  /* glibc 2.20 deprecates _BSD_SOURCE in favour of _DEFAULT_SOURCE */
  #define _DEFAULT_SOURCE 1

+#include "perf.h"
  #include <dirent.h>
  #include <fcntl.h>
  #include <stdbool.h>

