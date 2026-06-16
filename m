Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010048.outbound.protection.outlook.com [40.93.198.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ABB326924
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781616126; cv=fail; b=UuDST3gImYFNa0o3njWzBnT9HKDOCH4rYkBaeUIen9RB9hwq+HaxJifVwT81YcLicjBX3tkRrvnZNQSBgVWMBemDkOmH/ZEIWLg00eBgGU2YWMTpcTWlpDCiGgTVvsMdxVki5yJId/h/9u8oNUi65yvi5gZKS5Z3w4BrLC6hvU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781616126; c=relaxed/simple;
	bh=sY0Ho935/HZMhOH34EUaXwmMAx1srrHMTl9n4poEwpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uMpWJs+fBvHUyqi/K7bCsBR+q1Dh4L7Ti0qlRalOrBmILYCxD4k/hMBHB5XTVd+GyGLqyfBch9epJhoANxLIvSmljkgFAysf8IvvGjLKRXsflihSChYEP15dEKASXrqNFAjOHqduJfcprPifgJQO/oJzOEihElFieJVUAvaAQ5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RpbVrkNU; arc=fail smtp.client-ip=40.93.198.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RpbVrkNU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0Hodo8lPAh4U9zOFewUj1lqt44+D/N/QyUGutpYHhnR3VCnZWNyWSBHI8foGZvhX4Gy5sgkWBjYJLAF7ABRGyzUUv3a/PCR/fDzU9tKph0ci8nBj16hGmZ71J5cpouH5jG9fDLssRcRgJ/v6J8DykF13VBEPZU8ljE08XfS8AQfV4yBJMn5h0RbLDl7uducNuoi4ti4wkuRpxkFJLwSkF618cDPa+A2hWUFTkj66O3tY0C9LuFAL8VHmrivj8dUHdQH6d1mgkjbPhrNbn3l2EIzhpH9WjHe/W6HTbTDLGxn4oQCHzd+ueTja82/gZRH1CkLvW9NJ9Xcu1NXNZJZaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O91iY0SbaKnK/qkBH2dcFzw50soBHmHKbbGtTyr59xw=;
 b=GyntwgHN/T6eQabC5DeYeUH1r7nYm31rUur30FJFxxHJogcxdPyd0AV+bmb+amqrAl7bsXm5YFFXkPW992nDKSlnq9AhgFFIoQsmNE2/TjY1AIw/cpP2sDfMhznESWfPSSimb5a23BVYNzQU+SsAFNh60huYw6oDwHLDIzfNNaLQSHot+K2ZcE1OfL3XhPn2/79eo/0ERb8a85B87iNuEifItI/kgr6T+D+BwYELB/wu4Oduo/kdoVu0kfcbjMY9bqaZPpc+CgWXf0H0zbhvat5Db65QCecf8YyRaaW9RLFZ6HMhFbwnlhDse9aQrsoxwKiqU+f9JLlVn4qkWp8VhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O91iY0SbaKnK/qkBH2dcFzw50soBHmHKbbGtTyr59xw=;
 b=RpbVrkNUeiUelxZZB6hjeYAzwg6UxLaPRaqVjIZiArIcloyQUlrB9Tvecwkp0v9I2qM/n9vlPhl8fEAPRGCtpjtjLLHjw9RP3peniuzBiqsOLa3eZ7aHgmPdctVwgQ7el47hb9FsG2ZI7a76/M1e+sjB+Uw8DRJYEz8FuWaaT7o=
Received: from SA1P222CA0106.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::11)
 by SA1PR12MB6800.namprd12.prod.outlook.com (2603:10b6:806:25c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 13:22:01 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:3c5:cafe::91) by SA1P222CA0106.outlook.office365.com
 (2603:10b6:806:3c5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 13:22:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 13:22:01 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 08:21:58 -0500
Received: from [10.252.223.236] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 16 Jun 2026 08:21:56 -0500
Message-ID: <46b69b4c-b7d7-4155-93aa-62d2c34e0105@amd.com>
Date: Tue, 16 Jun 2026 18:51:55 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Missing information in HEADER_CPU_DOMAIN_INFO
To: Thomas Richter <tmricht@linux.ibm.com>, Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>
CC: Jan Polensky <japo@linux.ibm.com>, Sumanth Korikkar
	<sumanthk@linux.ibm.com>, linux-perf-use. <linux-perf-users@vger.kernel.org>,
	<ravi.bangoria@amd.com>
References: <3428df2b-abdc-4cb1-98f2-afdd759919b1@linux.ibm.com>
Content-Language: en-GB
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
In-Reply-To: <3428df2b-abdc-4cb1-98f2-afdd759919b1@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|SA1PR12MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e5bb097-6069-4843-31d8-08decbaa3feb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Q3WkaMqaTakkwoTh8JPAYh0bf1MDEtaLRGNLP89Foey6wuaIPFax67tMvbTZD9Wjtp3PecPwWF3IskpzAjRZ6qFr250wRMKaouOzmURSTVoHFWrkITd9MTceOvnY9EUEqgZFYb1f+ihzjSQD/15Z4nkn9brzvi97wlzEdMQs/88LQfZoAtaSZBwXRJ5FYcHyP1pmZ+g6l8bKoEh+3agrP0BFz08CDyYB9VFMuw1HBfSbXBSWylxAyHymi276316n4izJWDNCI1wYCCwkcpZkCO7XmW/fpTFnXDADnrdvg57SSgy0KwSjZWEdiu9Zk7YIOynkeZ+u5cqKkRdHNdLPfd5ezBRfFLEj+gxYrFXp0OU4y+G2L7POM8H2tFN3bd0W+wDCcNdgpiVPhPJ5vFoensaEHGYzLSIZ/udLRHpjy+F2faOZXkQ3THV3Qmb0VGMPvFFsyXwL5EgRHQHhTeFFFdUFxQWxs5EWGHrLrttFHglAHe2tbympLb1EZkKCnLr120OIl2a36WE+HBrnF+d53owdSCbR4l/Ily/bmb45odN5RlI+xB5m/DSTccM2iGRndHpJtQJSS/lvEEkwy1nfrxDlUYQ+i6y5rbXC3ZcUIuPOWcVEC+Kzpc6fJLmzF6bMnP1Lf2xl10BWs1aeLBxYPMjmOoFaXjEkIl7mNL64dNcr3I1Go4mFU2xm/8ctsU1dN9kht3j2AY2PDNcSxtDf5lzqDFu2Q2X8ijiJCnv8ilY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8hugKylU7qRcFSRtS8i+nwcVH2tGyTmQz9onl42/dSYKm1VrcIkJuTfk+231rnHtt6tDQFT/SCQh+aLmNZt3enxh+aQREI/KU3HYM9CN9IwO7OJuKA1ZF4y3ekD0l1jJPaXS1tqub+CbdikSf9wiiuCH2eLnsyGor/qU+YATYMGNQ55VJ7kTKwIyVrMQXTDDMuMzXgH0Kryhm+lpKE7Hkf4ojuPYNdFRh9xDqnME9V2Pnk/XQ2fJAaFBC05DCu68GCARsV98TvPmMl8NsSdOXFirdmbE+tNcGC6wADd8NxevVWnQ0O75BbdIMfZPyQb19YbHWjXTAHfnVE1ijk21pj2u62asPtC/2pevVp2VK53srNE/jkPpuVQ9Bpx9LfFC54YILmLW20R8EP97YRYiN70BH6Tcctanbu3hrTNMNnRWSspfUG0aShPUa91h/Lso
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 13:22:01.0037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5bb097-6069-4843-31d8-08decbaa3feb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6800

Hi Thomas,

Thank you for pointing this issues.

On 12-06-2026 19:03, Thomas Richter wrote:
> 
> Hi Swapnil,
> 
> Commit d40c68a49f69 ("perf header: Support CPU DOMAIN relation info")
> introduced the HEADER_CPU_DOMAIN_INFO bit and the necessary data.
> 
> However two issues came to my attention.
> 
> 1. The documentation is incomplete.
> File Documentation/perf.data-file-format.txt differs from the data written
> in function write_cpu_domain_info().
> The first two values written to the header section are schedstat_version
> and max_sched_domains. They are missing in the documentation.
> 

I agree with this. I will update the documentation for the same.

> 2. The function write_cpu_domain_info() writes a variable amount of data,
> but does not indicate how much CPU members have actually been written.
> This makes it much harder to read back that data from a perf.data file,
> because the reader does not know in advance how much data to read.
> Since the data structures also contain strings, the file section size does
> not help at all, because strings are of variable size.
> 
> In my opinion the structure should contain the number of CPU data to read.
> My suggestion:
> Modify structure cpu_domain_info, which contains the
> missing schedstat_version and max_sched_domains fields and contains the
> number of CPU records actually written to that header section.
> Here is an idea:
> 
>          HEADER_CPU_DOMAIN_INFO = 32,
> 
>   List of cpu-domain relation info. The format of the data is as below.
> 
>   struct domain_info {
>          int domain;
>          char dname[];
>          char cpumask[];
>          char cpulist[];
>   };
> 
>   struct cpu_domain_info {
>          int schedstat_version;
>          int max_sched_domains;
>          int nr_cpus;             <--- new
>          struct {
>                  u32 cpu;
>                  u32 nr_domains;
>                  struct domain_info [nr_domains];
>          } [nr_cpus];
>   };
> 
> The above syntax is also in sync the other sections of that documentation file.
> 
> What do you think?
> 

I agree with you on addition of schedstat_version and max_sched_domains 
fields to struct cpu_domain_info.

Regarding nr_cpus: since /proc/schedstat only contains stats for online 
CPUs, the number of CPU stats written equals env->nr_cpus_online. This 
information is already available via HEADER_NRCPUS, so I didn't include 
it in cpu_domain_info. Please let me know if I've overlooked something.

--
Thanks and Regards,
Swapnil

> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
> --
> IBM Deutschland Research & Development GmbH
> 
> Vorsitzender des Aufsichtsrats: Wolfgang Wendt
> 
> Geschäftsführung: David Faller
> 
> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
> 

