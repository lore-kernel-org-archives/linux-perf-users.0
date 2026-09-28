Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010061.outbound.protection.outlook.com [52.101.193.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8CA4BEE4A;
	Mon, 28 Sep 2026 13:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602085; cv=fail; b=n7VCKgUZyQQJVEY6eob1ijT/F4+2GmxF3D5dK/7ZUBwLtEdI5/VdLnle38pkRW5XAOlrVia6xhC3p8Z/7JXND11AWBEx9WniGcrnur3PTYZFxSkjPeWuzIbGlzZDaBQ3mTOpT6jYCoxTlO1UyZxiZHcEIiKmQSZs94Zz/tKiMuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602085; c=relaxed/simple;
	bh=khWyFXuEKmRUrdnzWOGV3yMiuGT/GORZD0PDMISq+sU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L1yl93znhtQEYuRHiDLp0lN6Zx074JWQNTxXnmsUFw8Erh3nPjtMt4EeRrPxkYHuripCZE/Wq51msMp2gEo3n+I/byfGhg0oNKmu8kdebEwN1BK/dtLwyCHMGgL9Bu0f1iMRd/jUpAf9gc4lspIqpIFcA7rsdlOHb9LWQte37Uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OPQyBioy; arc=fail smtp.client-ip=52.101.193.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OPQyBioy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tl3PtR3CG+Uf4WgdqbvZ/y2wy7w6wDTOv+eM/V+t6WDHsC6LQGYLH5tkiwDUnqQZDXSagzLp+OtfGfAwsI3myCZHc1vitQ/X++aT1vSBn0NpGUbOHB7JAL0mPW4VjP2JQ62Kg4OP9V6GxiCg+io9hUflNmpluq2JiFAOXIm5DKcZVX/jkjL88h8Idf9UyGphCzvUBIRr2w6PBSORVI9BwPB+ER24AL8cQr6Hj1RwsexQuqUgFxBSe1Je0kdV/+qcVDazsJYCbxGc+O9b1oC50m5Bbf9spF4uUQBdvu05i4sV87fpAbsGTMGX64KQZWE33OpoZkNh+sQ/bKL4luKdVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPQm8gw09+/Y9dftAA9bK9qV95+NUDkeIU0sVteNbUk=;
 b=afTwIgHFKg+U4eD1lfqZ0qXBzCEflHa729T346GNuUtY69Pd1wGE2tgVPguw0vOMK4lxaNMcaOcycM4wIcYVXHVhWC+ldAeEOo1Uk2iWQv+Duam4a6Gzbx6CprDpyWybq/eqpAuX74Yi/Jl9RQ8YIIzAw/Jlaoz5QB0RfNUUWhh+wW1jqyBHnR9fm/U/vUMnNkOikejpTTEDaRu0MxPK+sxdKFX3g8J55CvZzYz37Xl9i14l5dMZiES1u4dXZd3+bDf5yUW97TeasJ0z9/uG85yLbmFsA3SSugaCnoIBA36wzq439KogbugKJrZ/MfRj4wYOS1XlDOwZyJnG5ZE5ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPQm8gw09+/Y9dftAA9bK9qV95+NUDkeIU0sVteNbUk=;
 b=OPQyBioysLY0Wi8pBPjXyeQL0VyIYGp8EAPTJ/rjo7ymkzPc6pjrLfte4HGqthVLPqsNEpVQ4HUJoICOs9T2tZykiFj3VHJecYk8wsV6AJ8DfkGwXRITg3fxB3GsW1hoXgaVhHRnxsVrC3JJh+KMzK67H34YpLkkgUdcz4SpaPM=
Received: from BN0PR04CA0150.namprd04.prod.outlook.com (2603:10b6:408:ed::35)
 by DS4PR12MB9769.namprd12.prod.outlook.com (2603:10b6:8:2a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 13:27:52 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:ed:cafe::4b) by BN0PR04CA0150.outlook.office365.com
 (2603:10b6:408:ed::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 13:27:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 13:27:52 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 08:27:52 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 08:27:51 -0500
Received: from [192.168.0.103] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 28 Sep 2026 08:27:49 -0500
Message-ID: <a7b96474-98b0-49b4-a524-89bda593275f@amd.com>
Date: Mon, 28 Sep 2026 18:57:43 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf sched stats: Reject mismatched or incomplete
 snapshots
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Tianyi Chen <hi@tychen.cc>
CC: Namhyung Kim <namhyung@kernel.org>, <irogers@google.com>,
	<ravi.bangoria@amd.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260916161125.2548499-1-hi@tychen.cc> <arZyC1oiFA8bZ9Zc@x2>
Content-Language: en-GB
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
In-Reply-To: <arZyC1oiFA8bZ9Zc@x2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|DS4PR12MB9769:EE_
X-MS-Office365-Filtering-Correlation-Id: f5babdef-1b54-46a3-0f9b-08df1d644c74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|260925021311599003|3023799007|6133799003|10067099003|260925021911599003|260925022911599003|11063799006|4143699003|56012099006|22082099003|17002099007|18002099003;
X-Microsoft-Antispam-Message-Info:
	Nlzg7+X+gd9gLJknW0LH4y4Mq8BLVq6ByO6+RatdDmimilfgDfCbXunYayoSM51HtAszOBXPmoBzGtzNZAV7i/dmMoFPFff2zEme/EbzxYj2lKLY4NQrkiW0ypyFboq9/bFJbLRdKEjhtCbbv7tQhPZcH1di/uQRTXYoqUOs4LzLyorfhThY/IGlc3v/AnrNhdj5lGPzVIo3p90zauG5QIQLhOA6iSO/pA4QK9prsGQWZXRppAG6oIAwJra6VxHjfNcylQz5ysSbYHCXsRApx0GnvPEZnLS2V4DOHB3MX6Ep8d0L/uQCS6BGWPFJpRP3rsPLw+Pc4jGdBJNcrWUzMaHLPIM4azzBrFVTHELzEps1JxMgT4XrqUiP9Tdr46KD42c7yo/+t5GLKE2aq2UEaVGYyyxR6UryLBy/Kk9+N+BKPHx9y6e0KvKS4tNaTBzWHZD354epsjpiBi3er8Opk4zzQYNs5GbcNCemn3bJSUmcKa0TLEQbftxoL8sh06koeUXrJ2kaR7ijJKMopFAXJhQeVHA27DrLedT88GPjkSi29Vt+1AaxrScWGcgpUavhSolhiZbL10ExLZaUoSBcnJbeJp8oILZ6uhrK9Tub+GycOxu7BYl0kx0twKI2ucCZnvKCv0BgGNDU6YXlfQ/BHOwfbCgxg3EFZrjXbL9GxGHm3CqFQiyVJNa+ZKsmHXxscL/43MkV3F+eSOYC7BrJLw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(260925021311599003)(3023799007)(6133799003)(10067099003)(260925021911599003)(260925022911599003)(11063799006)(4143699003)(56012099006)(22082099003)(17002099007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	scJH9dS5juVKsuTz88CKEDZ1GIwmz0IQeIv6Zyqtavldx+/6eeDgB0a54hHAO/t66+pjdE4g0BhiLEJyAKQAocaLVc408aobF+iW542zWWnn0mzgn4KOfhJQsi/naFgLZ34tM6fHcB2l9Kdz3+jaCYTNdL9IHZv6YhNqQC1d5MZmg6H/wDpPyRMxRHuXqlD2hlcA/j2A0SlloCsXKj4jg8wvjKzh5+KjDeH28/mTx3VSmOc6WRGPlCz8ZcSUYkt6Y3IpD+Uacy3ZsonLch3G7PgB1mjG4EIV22otR1MlA/7VfZENaTgsgP/Nh4tDGs1SIyij83Mcn981ILF4ZP19X5o50/iB6uUKI4Vytl1jiDt4dCrnE3a1z8wCZtc6IeeTnzAk24lqbIFul1MjuUuykslRe3YpCx2rZQPeYEwBXKE7O4HT/iIe8YqiEGCMX4k1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 13:27:52.6071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5babdef-1b54-46a3-0f9b-08df1d644c74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9769

Hi Arnaldo, Tianyi,

Sorry for the delay in response. I was on vacation last week.

On 25-09-2026 18:37, Arnaldo Carvalho de Melo wrote:
> On Thu, Sep 17, 2026 at 12:11:25AM +0800, Tianyi Chen wrote:
>> The before and after records are paired by list position. If a CPU or
>> domain disappears, counters can be subtracted from a different record
>> or left as absolute values. An extra record can also advance the cursor
>> past the list.
>>
>> Identify the second snapshot by its timestamp or CPU ordering, and
>> require matching CPU/domain IDs and versions before subtracting. Check
>> that every record has a counterpart before printing, and propagate
>> errors from either input of diff.
>>
>> Add a shell test with synthetic snapshots, including equal timestamps,
>> CPU filtering, and missing or reordered CPU/domain records.
>>
>> Fixes: 5a357ae6ad63 ("perf sched stats: Add support for report subcommand")
> 
> Swapnil, can you please ack/review this one?
> 
> - Arnaldo
> 

I have reviewed and tested the changes. It looks good to me. Please feel 
free to add

Reviewed-and-tested-by: Swapnil Sapkal <swapnil.sapkal@amd.com>

--
Thanks and Regards,
Swapnil

>> Assisted-by: LLM
>> Signed-off-by: Tianyi Chen <hi@tychen.cc>
>> ---
>> The new shell test passes with GCC and Clang ASan/UBSan and fails on
>> unpatched perf. Live and record/report/diff checks with temporary
>> /proc/schedstat fixtures also pass.
>>
>>   tools/perf/Documentation/perf-sched.txt       |   6 +-
>>   tools/perf/builtin-sched.c                    | 189 ++++++++++++------
>>   tools/perf/tests/shell/schedstat_snapshots.sh | 155 ++++++++++++++
>>   3 files changed, 283 insertions(+), 67 deletions(-)
>>   create mode 100755 tools/perf/tests/shell/schedstat_snapshots.sh
>>
>> diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
>> index 4da06215163a..fe0abef2bd13 100644
>> --- a/tools/perf/Documentation/perf-sched.txt
>> +++ b/tools/perf/Documentation/perf-sched.txt
>> @@ -95,8 +95,10 @@ There are several variants of 'perf sched':
>>      events, ``try_to_wakeup()`` call among others. This is useful in understanding the
>>      scheduler behavior for the workload.
>>   
>> -   Note: The tool will not give correct results if there is topological reordering or
>> -         online/offline of cpus in between capturing snapshots of `/proc/schedstat`.
>> +   Note: Reports reject incomplete snapshots and mismatched CPU or domain IDs.
>> +         Topology changes that retain the same IDs, including CPUs going offline
>> +         and returning online between snapshots, cannot be detected and may still
>> +         produce incorrect results.
>>   
>>       Example usage:
>>           perf sched stats record -- sleep 1
>> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
>> index dd39a4fb6c7a..9e7d170b30ad 100644
>> --- a/tools/perf/builtin-sched.c
>> +++ b/tools/perf/builtin-sched.c
>> @@ -4281,18 +4281,18 @@ struct schedstat_cpu {
>>   };
>>   
>>   static struct list_head cpu_head = LIST_HEAD_INIT(cpu_head);
>> -static struct schedstat_cpu *cpu_second_pass;
>> -static struct schedstat_domain *domain_second_pass;
>> +static struct list_head *cpu_second_pass;
>> +static struct list_head *domain_second_pass;
>> +static u64 schedstat_timestamp;
>>   static bool after_workload_flag;
>>   static bool verbose_field;
>>   
>>   static void free_schedstat(struct list_head *head);
>>   
>> -static void store_schedstat_cpu_diff(struct schedstat_cpu *after_workload)
>> +static void store_schedstat_cpu_diff(struct perf_record_schedstat_cpu *before,
>> +				    struct perf_record_schedstat_cpu *after)
>>   {
>> -	struct perf_record_schedstat_cpu *before = cpu_second_pass->cpu_data;
>> -	struct perf_record_schedstat_cpu *after = after_workload->cpu_data;
>> -	__u16 version = after_workload->cpu_data->version;
>> +	__u16 version = after->version;
>>   
>>   #define CPU_FIELD(_type, _name, _desc, _format, _is_pct, _pct_of, _ver)	\
>>   	(before->_ver._name = after->_ver._name - before->_ver._name)
>> @@ -4308,11 +4308,10 @@ static void store_schedstat_cpu_diff(struct schedstat_cpu *after_workload)
>>   #undef CPU_FIELD
>>   }
>>   
>> -static void store_schedstat_domain_diff(struct schedstat_domain *after_workload)
>> +static void store_schedstat_domain_diff(struct perf_record_schedstat_domain *before,
>> +				       struct perf_record_schedstat_domain *after)
>>   {
>> -	struct perf_record_schedstat_domain *before = domain_second_pass->domain_data;
>> -	struct perf_record_schedstat_domain *after = after_workload->domain_data;
>> -	__u16 version = after_workload->domain_data->version;
>> +	__u16 version = after->version;
>>   
>>   #define DOMAIN_FIELD(_type, _name, _desc, _format, _is_jiffies, _ver)	\
>>   	(before->_ver._name = after->_ver._name - before->_ver._name)
>> @@ -4814,12 +4813,35 @@ static int show_schedstat_data(struct list_head *head1, struct cpu_domain_map **
>>    * other after completion of the workload. The above linked list stores the diff of the cpu and
>>    * domain statistics.
>>    */
>> +static int schedstat_snapshot_error(void)
>> +{
>> +	pr_err("Incompatible or incomplete schedstat snapshots\n");
>> +	return -EINVAL;
>> +}
>> +
>> +static bool schedstat_domains_complete(void)
>> +{
>> +	struct schedstat_cpu *cpu;
>> +
>> +	if (!domain_second_pass)
>> +		return true;
>> +	cpu = list_entry(cpu_second_pass, struct schedstat_cpu, cpu_list);
>> +	return domain_second_pass == &cpu->domain_head;
>> +}
>> +
>> +static int schedstat_snapshots_complete(void)
>> +{
>> +	if (!after_workload_flag || !cpu_second_pass ||
>> +	    cpu_second_pass->next != &cpu_head || !schedstat_domains_complete())
>> +		return schedstat_snapshot_error();
>> +	return 0;
>> +}
>> +
>>   static int perf_sched__process_schedstat(const struct perf_tool *tool __maybe_unused,
>>   					 struct perf_session *session __maybe_unused,
>>   					 union perf_event *event)
>>   {
>>   	struct perf_cpu this_cpu;
>> -	static __u32 initial_cpu;
>>   
>>   	switch (event->header.type) {
>>   	case PERF_RECORD_SCHEDSTAT_CPU:
>> @@ -4836,63 +4858,91 @@ static int perf_sched__process_schedstat(const struct perf_tool *tool __maybe_un
>>   		return 0;
>>   
>>   	if (event->header.type == PERF_RECORD_SCHEDSTAT_CPU) {
>> -		struct schedstat_cpu *temp = zalloc(sizeof(*temp));
>> -
>> -		if (!temp)
>> -			return -ENOMEM;
>> -
>> -		temp->cpu_data = zalloc(sizeof(*temp->cpu_data));
>> -		if (!temp->cpu_data)
>> -			return -ENOMEM;
>> +		struct perf_record_schedstat_cpu *data = &event->schedstat_cpu;
>> +		struct schedstat_cpu *cpu;
>>   
>> -		memcpy(temp->cpu_data, &event->schedstat_cpu, sizeof(*temp->cpu_data));
>> -
>> -		if (!list_empty(&cpu_head) && temp->cpu_data->cpu == initial_cpu)
>> -			after_workload_flag = true;
>> -
>> -		if (!after_workload_flag) {
>> -			if (list_empty(&cpu_head))
>> -				initial_cpu = temp->cpu_data->cpu;
>> -
>> -			list_add_tail(&temp->cpu_list, &cpu_head);
>> -			INIT_LIST_HEAD(&temp->domain_head);
>> -		} else {
>> -			if (temp->cpu_data->cpu == initial_cpu) {
>> -				cpu_second_pass = list_first_entry(&cpu_head, struct schedstat_cpu,
>> -								   cpu_list);
>> -				cpu_second_pass->cpu_data->timestamp =
>> -					temp->cpu_data->timestamp - cpu_second_pass->cpu_data->timestamp;
>> -			} else {
>> -				cpu_second_pass = list_next_entry(cpu_second_pass, cpu_list);
>> +		if (list_empty(&cpu_head)) {
>> +			after_workload_flag = false;
>> +			cpu_second_pass = &cpu_head;
>> +			domain_second_pass = NULL;
>> +			schedstat_timestamp = data->timestamp;
>> +		} else if (!after_workload_flag) {
>> +			cpu = list_last_entry(&cpu_head, struct schedstat_cpu, cpu_list);
>> +			/* Snapshots share a timestamp and list CPUs in increasing order. */
>> +			if (data->timestamp != schedstat_timestamp ||
>> +			    data->cpu <= cpu->cpu_data->cpu) {
>> +				after_workload_flag = true;
>> +				schedstat_timestamp = data->timestamp;
>>   			}
>> -			domain_second_pass = list_first_entry(&cpu_second_pass->domain_head,
>> -							      struct schedstat_domain, domain_list);
>> -			store_schedstat_cpu_diff(temp);
>> -			free(temp->cpu_data);
>> -			free(temp);
>>   		}
>> -	} else if (event->header.type == PERF_RECORD_SCHEDSTAT_DOMAIN) {
>> -		struct schedstat_cpu *cpu_tail;
>> -		struct schedstat_domain *temp = zalloc(sizeof(*temp));
>>   
>> -		if (!temp)
>> -			return -ENOMEM;
>> +		if (after_workload_flag) {
>> +			if (data->timestamp != schedstat_timestamp || !schedstat_domains_complete())
>> +				return schedstat_snapshot_error();
>> +			cpu_second_pass = cpu_second_pass->next;
>> +			if (cpu_second_pass == &cpu_head)
>> +				return schedstat_snapshot_error();
>> +			cpu = list_entry(cpu_second_pass, struct schedstat_cpu, cpu_list);
>> +			if (data->cpu != cpu->cpu_data->cpu ||
>> +			    data->version != cpu->cpu_data->version ||
>> +			    data->timestamp < cpu->cpu_data->timestamp)
>> +				return schedstat_snapshot_error();
>> +			cpu->cpu_data->timestamp = data->timestamp - cpu->cpu_data->timestamp;
>> +			store_schedstat_cpu_diff(cpu->cpu_data, data);
>> +			domain_second_pass = cpu->domain_head.next;
>> +			return 0;
>> +		}
>>   
>> -		temp->domain_data = zalloc(sizeof(*temp->domain_data));
>> -		if (!temp->domain_data)
>> +		cpu = zalloc(sizeof(*cpu));
>> +		if (!cpu)
>>   			return -ENOMEM;
>> +		cpu->cpu_data = memdup(data, sizeof(*data));
>> +		if (!cpu->cpu_data) {
>> +			free(cpu);
>> +			return -ENOMEM;
>> +		}
>> +		INIT_LIST_HEAD(&cpu->domain_head);
>> +		list_add_tail(&cpu->cpu_list, &cpu_head);
>> +	} else {
>> +		struct perf_record_schedstat_domain *data = &event->schedstat_domain;
>> +		struct schedstat_domain *domain;
>> +		struct schedstat_cpu *cpu;
>> +
>> +		if (list_empty(&cpu_head) || data->timestamp != schedstat_timestamp)
>> +			return schedstat_snapshot_error();
>> +		if (after_workload_flag) {
>> +			cpu = list_entry(cpu_second_pass, struct schedstat_cpu, cpu_list);
>> +			if (domain_second_pass == &cpu->domain_head)
>> +				return schedstat_snapshot_error();
>> +			domain = list_entry(domain_second_pass, struct schedstat_domain,
>> +					    domain_list);
>> +			if (data->cpu != domain->domain_data->cpu ||
>> +			    data->domain != domain->domain_data->domain ||
>> +			    data->version != domain->domain_data->version)
>> +				return schedstat_snapshot_error();
>> +			store_schedstat_domain_diff(domain->domain_data, data);
>> +			domain_second_pass = domain_second_pass->next;
>> +			return 0;
>> +		}
>>   
>> -		memcpy(temp->domain_data, &event->schedstat_domain, sizeof(*temp->domain_data));
>> -
>> -		if (!after_workload_flag) {
>> -			cpu_tail = list_last_entry(&cpu_head, struct schedstat_cpu, cpu_list);
>> -			list_add_tail(&temp->domain_list, &cpu_tail->domain_head);
>> -		} else {
>> -			store_schedstat_domain_diff(temp);
>> -			domain_second_pass = list_next_entry(domain_second_pass, domain_list);
>> -			free(temp->domain_data);
>> -			free(temp);
>> +		cpu = list_last_entry(&cpu_head, struct schedstat_cpu, cpu_list);
>> +		if (data->cpu != cpu->cpu_data->cpu || data->version != cpu->cpu_data->version)
>> +			return schedstat_snapshot_error();
>> +		if (!list_empty(&cpu->domain_head)) {
>> +			domain = list_last_entry(&cpu->domain_head, struct schedstat_domain,
>> +						 domain_list);
>> +			if (data->domain <= domain->domain_data->domain)
>> +				return schedstat_snapshot_error();
>>   		}
>> +		domain = zalloc(sizeof(*domain));
>> +		if (!domain)
>> +			return -ENOMEM;
>> +		domain->domain_data = memdup(data, sizeof(*data));
>> +		if (!domain->domain_data) {
>> +			free(domain);
>> +			return -ENOMEM;
>> +		}
>> +		list_add_tail(&domain->domain_list, &cpu->domain_head);
>>   	}
>>   
>>   	return 0;
>> @@ -4947,6 +4997,8 @@ static int perf_sched__schedstat_report(struct perf_sched *sched)
>>   	user_requested_cpus = evlist__core(session->evlist)->user_requested_cpus;
>>   
>>   	err = perf_session__process_events(session);
>> +	if (!err)
>> +		err = schedstat_snapshots_complete();
>>   
>>   	if (!err) {
>>   		setup_pager();
>> @@ -4976,7 +5028,7 @@ static int perf_sched__schedstat_diff(struct perf_sched *sched,
>>   	struct list_head cpu_head_ses0, cpu_head_ses1;
>>   	struct perf_session *session[2];
>>   	struct perf_data data[2] = {0};
>> -	int ret = 0, err = 0;
>> +	int ret = 0;
>>   	static const char *defaults[] = {
>>   		"perf.data.old",
>>   		"perf.data",
>> @@ -5009,8 +5061,10 @@ static int perf_sched__schedstat_diff(struct perf_sched *sched,
>>   		goto out_delete_ses0;
>>   	}
>>   
>> -	err = perf_session__process_events(session[0]);
>> -	if (err) {
>> +	ret = perf_session__process_events(session[0]);
>> +	if (!ret)
>> +		ret = schedstat_snapshots_complete();
>> +	if (ret) {
>>   		free_schedstat(&cpu_head);
>>   		goto out_delete_ses0;
>>   	}
>> @@ -5028,8 +5082,10 @@ static int perf_sched__schedstat_diff(struct perf_sched *sched,
>>   		goto out_delete_ses1;
>>   	}
>>   
>> -	err = perf_session__process_events(session[1]);
>> -	if (err) {
>> +	ret = perf_session__process_events(session[1]);
>> +	if (!ret)
>> +		ret = schedstat_snapshots_complete();
>> +	if (ret) {
>>   		free_schedstat(&cpu_head);
>>   		goto out_delete_ses1;
>>   	}
>> @@ -5152,6 +5208,9 @@ static int perf_sched__schedstat_live(struct perf_sched *sched,
>>   					       user_requested_cpus);
>>   	if (err)
>>   		goto out;
>> +	err = schedstat_snapshots_complete();
>> +	if (err)
>> +		goto out;
>>   
>>   	setup_pager();
>>   
>> diff --git a/tools/perf/tests/shell/schedstat_snapshots.sh b/tools/perf/tests/shell/schedstat_snapshots.sh
>> new file mode 100755
>> index 000000000000..a4bdf2673d43
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/schedstat_snapshots.sh
>> @@ -0,0 +1,155 @@
>> +#!/bin/sh
>> +# Validate CPU and domain pairing in perf sched stats snapshots
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +set -e
>> +
>> +# shellcheck source=lib/setup_python.sh
>> +. "$(dirname "$0")/lib/setup_python.sh"
>> +
>> +if ! perf version --build-options | grep -q 'libtraceevent:.*on'; then
>> +	echo "[Skip] perf sched requires libtraceevent"
>> +	exit 2
>> +fi
>> +
>> +$PYTHON - <<'PY'
>> +import os
>> +import re
>> +import struct
>> +import subprocess
>> +import sys
>> +import tempfile
>> +
>> +# Native-endian perf.data with only NRCPUS and CPU_DOMAIN_INFO features.
>> +endian = '<' if sys.byteorder == 'little' else '>'
>> +
>> +
>> +def pack(fmt, *values):
>> +    return struct.pack(endian + fmt, *values)
>> +
>> +
>> +def string(value):
>> +    data = value.encode() + b'\0'
>> +    return pack('I', len(data)) + data
>> +
>> +
>> +def cpu(cpu_id, timestamp, value, version):
>> +    return pack('IHHQIHH6I3Q', 85, 0, 72, timestamp, cpu_id, version, 0,
>> +                *([value] * 9))
>> +
>> +
>> +def domain(cpu_id, domain_id, timestamp, value, version):
>> +    # All supported versions use the largest union member's record size.
>> +    return pack('IHHQIHH45I4x', 86, 0, 208, timestamp, cpu_id, version,
>> +                domain_id, *([value] * 45))
>> +
>> +
>> +def snapshot(timestamp, value, version=17, cpus=(0, 1, 2), domains=(0, 1)):
>> +    records = []
>> +    for cpu_id in cpus:
>> +        records.append(cpu(cpu_id, timestamp, value + cpu_id * 100, version))
>> +        for domain_id in domains:
>> +            records.append(domain(cpu_id, domain_id, timestamp,
>> +                                  value + cpu_id * 100, version))
>> +    return records
>> +
>> +
>> +def write_file(path, records, version=17):
>> +    metadata = pack('II', version, 2)
>> +    for cpu_id in range(3):
>> +        metadata += pack('II', cpu_id, 2)
>> +        for domain_id in range(2):
>> +            metadata += pack('I', domain_id)
>> +            if version >= 17:
>> +                metadata += string('SMT' if domain_id == 0 else 'MC')
>> +            metadata += string('7') + string('0-2')
>> +    features = [pack('II', 3, 3), metadata]
>> +    data = b''.join(records)
>> +    offset = 104 + len(data) + 16 * len(features)
>> +    sections = b''
>> +    for feature in features:
>> +        sections += pack('QQ', offset, len(feature))
>> +        offset += len(feature)
>> +    header = pack('13Q', 0x32454c4946524550, 104, 144, 104, 0,
>> +                  104, len(data), 0, 0, (1 << 7) | (1 << 32), 0, 0, 0)
>> +    with open(path, 'wb') as output:
>> +        output.write(header + data + sections + b''.join(features))
>> +
>> +
>> +def run(args, valid, domains=True):
>> +    result = subprocess.run(['perf', 'sched', 'stats'] + args,
>> +                            stdout=subprocess.PIPE, stderr=subprocess.PIPE,
>> +                            text=True, timeout=10)
>> +    if valid:
>> +        assert result.returncode == 0, result.stderr
>> +        assert re.search(r'^yld_count\s+:\s+10\b', result.stdout, re.M), result.stdout
>> +        if domains:
>> +            assert re.search(r'^busy_lb_count\s+:\s+10\b', result.stdout, re.M), result.stdout
>> +        else:
>> +            assert 'busy_lb_count' not in result.stdout, result.stdout
>> +    else:
>> +        assert result.returncode > 0, (args, result.returncode, result.stdout)
>> +        assert 'Incompatible or incomplete schedstat snapshots' in result.stderr
>> +        assert not result.stdout, result.stdout
>> +    assert 'Sanitizer' not in result.stderr, result.stderr
>> +
>> +
>> +with tempfile.TemporaryDirectory(prefix='perf-schedstat-') as directory:
>> +    good = os.path.join(directory, 'good.data')
>> +    test = os.path.join(directory, 'test.data')
>> +    before = snapshot(100, 1000)
>> +    after = snapshot(200, 1010)
>> +    write_file(good, before + after)
>> +
>> +    for version in (15, 16, 17):
>> +        for timestamp in (100, 200):
>> +            write_file(test, snapshot(100, 1000, version) +
>> +                       snapshot(timestamp, 1010, version), version)
>> +            run(['report', '-C', '0,1,2', '-i', test], True)
>> +            run(['diff', test, test], True)
>> +    print('Matching snapshots, including equal timestamps: [Success]')
>> +
>> +    write_file(test, snapshot(100, 1000, domains=()) +
>> +               snapshot(200, 1010, domains=()))
>> +    run(['report', '-C', '0,1,2', '-i', test], True, domains=False)
>> +    run(['diff', test, test], True, domains=False)
>> +    print('CPUs without domains: [Success]')
>> +
>> +    write_file(test, before + snapshot(200, 1010, cpus=(0, 1)))
>> +    run(['report', '-C', '0,1', '-i', test], True)
>> +    run(['report', '-C', '1', '-i', good], True)
>> +    write_file(test, snapshot(100, 1000, cpus=(0, 1)) +
>> +               snapshot(200, 1010, cpus=(0, 1)))
>> +    run(['diff', good, test], True)
>> +    print('CPU filtering and different CPU sets across files: [Success]')
>> +
>> +    write_file(test, snapshot(100, 0xfffffffa, cpus=(0,)) +
>> +               snapshot(200, 4, cpus=(0,)))
>> +    run(['report', '-C', '0', '-i', test], True)
>> +    print('Wrapping 32-bit counters: [Success]')
>> +
>> +    cases = {
>> +        'missing first CPU': before + snapshot(200, 1010, cpus=(1, 2)),
>> +        'missing middle CPU': before + snapshot(200, 1010, cpus=(0, 2)),
>> +        'missing last CPU': before + snapshot(200, 1010, cpus=(0, 1)),
>> +        'added CPU': snapshot(100, 1000, cpus=(0, 1)) + after,
>> +        'reordered CPUs': before + snapshot(200, 1010, cpus=(0, 2, 1)),
>> +        'equal timestamp, missing first CPU': before + snapshot(100, 1010, cpus=(1, 2)),
>> +        'missing first domain': before + snapshot(200, 1010, domains=(1,)),
>> +        'missing last domain': before + after[:-1],
>> +        'added domain': snapshot(100, 1000, domains=(0,)) + after,
>> +        'reordered domains': before + snapshot(200, 1010, domains=(1, 0)),
>> +        'domain without CPU': before[1:] + after,
>> +        'wrong domain CPU': before + [after[0], domain(1, 0, 200, 1010, 17)] + after[2:],
>> +        'changed version': before + snapshot(200, 1010, version=16),
>> +        'backwards timestamp': before + snapshot(50, 1010),
>> +        'third snapshot': before + after + snapshot(300, 1020),
>> +        'missing second snapshot': before,
>> +    }
>> +    for name, records in cases.items():
>> +        write_file(test, records)
>> +        run(['report', '-C', '0,1,2', '-i', test], False)
>> +        run(['diff', test, good], False)
>> +        run(['diff', good, test], False)
>> +        print(name + ': [Success]')
>> +PY
>>
>> base-commit: 91b0782fc9e9d2f0a40b5256146e014802fdbb36
>> -- 
>> 2.55.0

