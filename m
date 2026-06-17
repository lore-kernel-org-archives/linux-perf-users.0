Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012000.outbound.protection.outlook.com [40.107.209.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D71A2E54A3
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jun 2026 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695158; cv=fail; b=Z1juEILq0D4SkiUUV3+plWJwACzNeW+GMCs3MJbbFj+/xAsat+9b4rZ4h7i08YDfKmGK7AsuJ8vnw0ISCTQQC58vrImPPmKsOVk50JCz6iPu6lQZwpEHvN1Wk/PlYztK+ERmKvGx/l5FjaJlSx36SwmUQGG6UrMOG2HzyvW2YDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695158; c=relaxed/simple;
	bh=YGSxQkV5igJeR7eTd1HHL/a5neYOckhPzJR/fEGAFec=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GNzp9BnGqpbMf7FIa6XR+RLsq58M+UcH7uTrdGzdlwZd6Km7JClsQvF5rvRCCxj36xpakWu+DskbC/Ic+pBWt+WDLOo+0insILk9BpMN4WScFFfrp4kytT14P6Y13uJkxy+MWk+UZoE/nvr8AUu4GD6Albstr8BKUECo1YwBNQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gcXCGbH2; arc=fail smtp.client-ip=40.107.209.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gcXCGbH2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATmF6wzJgMcei8SgxHOYthSbOrTYfaaDilTegfwo/SOCuWXn/Kr3U6go/FPwdhHUmK5ssuAW/0ecWpO/V4g9IdV+rVIAayDkfcwduRjDO68xa2j2r2FUq5MA6unX5K99ojJIsk0hpshnDbQ4PIQ8h7t6oBvk0F1hDFqaNHqKO2+ZMtxmoU2Nl0yOcYbsaJqHv3IgRPsFADno5BsCMYFXysidYkS/lToEjBGqFGzgF0axagI+rBCvuohsFhJ8bhCxVpT8xMxvWCXi71Z4xxwhGQf4X2Y3ZUujxRGzonPSsNgimO6/JJRdsvRAcQN7/W0Czl9g+B1CeWO3RNJEmR7NRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksoryTD9INDmfltX30ldvYXNve53TOU/tXvCqWcMenY=;
 b=XNNx1rtlA4sUxRYBO10QO4UJV5FRF3RBHANLrfZsJkzSE2jOlm+o+FEz/E4ivu9/UohRz+atRrO0OXUXr8dVRk1G8x89X2CREUugMUJode4Bqip4izVVzHPq07HNsS3f4/k66KMc0SrhBz+ZnELuO6Sqkc4iYVma4VT/PGbsoMxVGLfrpDqF7jYZOaaBz24a7Wh8/xm0/5iT5wFqC+hLB2pREt1yRfzoivN+HayqMkINDV2gVjTgJyj4bgC8VobmaesVA+PyA8Z7dZ3GRAWYjSnEKrD9lU3rQnCaqpYlPGY3Ha80lvmFvjKU7Ak9GXrMYySgThp3ngiBIJgBxesajw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksoryTD9INDmfltX30ldvYXNve53TOU/tXvCqWcMenY=;
 b=gcXCGbH2Rs3QC2iCFskWI6qGbWLqB01TnyTjb7LVxyYsQIrvyRtPTlCq2vrGglXSTm8Yw37X6QzrwNjR4OJ/nJPkFj/YQYo7obRPP246Mr+zKRH+F2rQTLqO7DZimjfCyv29pwZAQO9S47B7armQ9O3gYC0WBzQ9k4ZCIsYYx4Y=
Received: from BL1P221CA0013.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::11)
 by DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Wed, 17 Jun
 2026 11:19:08 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::32) by BL1P221CA0013.outlook.office365.com
 (2603:10b6:208:2c5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Wed,
 17 Jun 2026 11:19:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 11:19:08 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 06:19:08 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 06:19:07 -0500
Received: from [10.85.34.160] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 17 Jun 2026 06:19:05 -0500
Message-ID: <1e6db624-aeb9-4d9a-9ecd-ea1524e00d1e@amd.com>
Date: Wed, 17 Jun 2026 16:49:04 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Missing information in HEADER_CPU_DOMAIN_INFO
Content-Language: en-GB
To: Thomas Richter <tmricht@linux.ibm.com>, Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>
CC: Jan Polensky <japo@linux.ibm.com>, Sumanth Korikkar
	<sumanthk@linux.ibm.com>, linux-perf-use. <linux-perf-users@vger.kernel.org>,
	<ravi.bangoria@amd.com>
References: <3428df2b-abdc-4cb1-98f2-afdd759919b1@linux.ibm.com>
 <46b69b4c-b7d7-4155-93aa-62d2c34e0105@amd.com>
 <64b353ab-6079-49fb-8495-06087e6686fb@linux.ibm.com>
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
In-Reply-To: <64b353ab-6079-49fb-8495-06087e6686fb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|DM6PR12MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: c442e287-faef-43c8-942a-08decc624004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|56012099006|11063799006|4143699003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	z7L0ax+mOnv9ujXq7cNose37unhTTXh0g8O5vNhHSnBVkn0D2HBmnjBJiBkMwmbrtu3GSmcF/beFfnfiw2V9bZw30Z7llJHyuTb+z2ncXqmis9i79IkQhMJti+OYIMhIygLlUzr0xs0psYARu3WzPEVBKeDLT6Sax9AWUO0EEBl8a1s5Fdk/eZhzEOT3eWdsTjOpyrB9OAAwdN1ehXpHMRKbGgowtxfRVcnlz9rKKnVNHknnOogTxlj4v4KKyc9jgr6B/YlAP9V9obCoqq7EcJumGvPzdXgH9WaOlyziI9amjvDfaIOm1z/N9wMCoowvHpoel6Y3qc36CSzJi4UdUUHCy8/vCJaS0+12bmzvpG+APrqhROAPLAJPoQudi1G7RKtnLPzK4YdBzCecw52qK0xWbyKJjnqOuRvGhfn/bP7K0sq+dlApHwumVn3CsQgQ6sn9rLCWwwvAaP3yw9sBFhuU97BRGdl3wqrg38hFfQ6JnZ2V1GWokksfhEGEGeDnT0BSlbgdTlaePZjVAr+OnGl3iP2RjB4rlBvR4sY9XVKi5JakiHbh2ZFUS7EJhpW9oREjNI4RIb0xYtb5oHxQagTeZjpJS7fMp4kWdw5cjuOpVT98uEfa2iLNJMHjJbgvBsQJbGwThznGd5dEThfXQj9uE9BvK6I8DFSHkGzcJgx356sNWw9SfggtR4qhKdak91W2bgCB0B8oegtOCXN+iZLswuPTUDHivGp1GxwATw0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0zVIvBFlzTjpbLiSzqDuYnHcZ8Y5YEQNelYaBlufXnYpgIs3jbzoCIUDp/myidbQqfcxa7eVZhCjDF3Qo/lKiKrTRN98p5mDmS9k8nORk0vZvIjipNAEqz0Sd1wqHL++sfvxEYHk/OZpTsMLKBvxucDjgl6Zeqj0yGcZ7HwXbDQiHVUKYpkWbjju32t8qPvq2+oxJPvZJkFsS/8dn8sR4EBNKW2+dQuoF02ZQE1M4Lwp63rKOM2nz9iOGOk3bPVFZK7dDLcdAgYUsxhqgLpAb4fYbB3YswYvhyGACAnVY+zEvV28j7rilzePg1vNmH2gV58KNHR6VAFGNzgGD/pwDJ3Pl7HBKko4tfQ9hLpbsZ3NPnkiFyba6EMKB1h26kNzSCC0EedtXrWQJCbe1QDGmVlnI5gEEjoORmyYdc0iERrJWJevgdO8kU1x2FP1NgCC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 11:19:08.5620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c442e287-faef-43c8-942a-08decc624004
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4482

Hi Thomas,

On 17-06-2026 12:14, Thomas Richter wrote:
> On 6/16/26 15:21, Swapnil Sapkal wrote:
>> Hi Thomas,
>>
>> Thank you for pointing this issues.
>>
>> On 12-06-2026 19:03, Thomas Richter wrote:
>>>
>>> Hi Swapnil,
>>>
>>> Commit d40c68a49f69 ("perf header: Support CPU DOMAIN relation info")
>>> introduced the HEADER_CPU_DOMAIN_INFO bit and the necessary data.
>>>
>>> However two issues came to my attention.
>>>
>>> 1. The documentation is incomplete.
>>> File Documentation/perf.data-file-format.txt differs from the data written
>>> in function write_cpu_domain_info().
>>> The first two values written to the header section are schedstat_version
>>> and max_sched_domains. They are missing in the documentation.
>>>
>>
>> I agree with this. I will update the documentation for the same.
> 
> Great Thanks
> 
>>
>>> 2. The function write_cpu_domain_info() writes a variable amount of data,
>>> but does not indicate how much CPU members have actually been written.
>>> This makes it much harder to read back that data from a perf.data file,
>>> because the reader does not know in advance how much data to read.
>>> Since the data structures also contain strings, the file section size does
>>> not help at all, because strings are of variable size.
>>>
>>> In my opinion the structure should contain the number of CPU data to read.
>>> My suggestion:
>>> Modify structure cpu_domain_info, which contains the
>>> missing schedstat_version and max_sched_domains fields and contains the
>>> number of CPU records actually written to that header section.
>>> Here is an idea:
>>>
>>>           HEADER_CPU_DOMAIN_INFO = 32,
>>>
>>>    List of cpu-domain relation info. The format of the data is as below.
>>>
>>>    struct domain_info {
>>>           int domain;
>>>           char dname[];
>>>           char cpumask[];
>>>           char cpulist[];
>>>    };
>>>
>>>    struct cpu_domain_info {
>>>           int schedstat_version;
>>>           int max_sched_domains;
>>>           int nr_cpus;             <--- new
>>>           struct {
>>>                   u32 cpu;
>>>                   u32 nr_domains;
>>>                   struct domain_info [nr_domains];
>>>           } [nr_cpus];
>>>    };
>>>
>>> The above syntax is also in sync the other sections of that documentation file.
>>>
>>> What do you think?
>>>
>>
>> I agree with you on addition of schedstat_version and max_sched_domains fields to struct cpu_domain_info.
>>
>> Regarding nr_cpus: since /proc/schedstat only contains stats for online CPUs, the number of CPU stats written equals env->nr_cpus_online. This information is already available via HEADER_NRCPUS, so I didn't include it in cpu_domain_info. Please let me know if I've overlooked something.
>>
> 
> Ah, now I get it. This is fine with me but should be mentioned in the documentation as well.

Sure, I will modify the documenation accordingly.

> See header feature HEADER_CPU_TOPOLOGY documentation.
> There is a similar situation and is expained in the comment:
> 
>         struct {
>                uint32_t core_id;
>                uint32_t socket_id;
>         } cpus[nr]; /* Variable length records */
>         /* 'nr' comes from previously processed HEADER_NRCPUS's nr_cpu_avail */  <--- here
> 
> So the reader is aware of the cross reference and what value to use when reading the feature file section.

I appreciate you bringing that to my attention.

> 
>> -- 
>> Thanks and Regards,
>> Swapnil
>>
> 
> 
> Thanks.
> 
> 
--
Thanks and Regards,
Swapnil
