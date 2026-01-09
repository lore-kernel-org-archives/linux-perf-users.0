Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD1A358D1F;
	Fri,  9 Jan 2026 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767957853; cv=fail; b=mpsFdySdg92iz3aLGR7qvaYJ3X4QFinS9H93IrQky1G5riNGOYnqQ8x6scA8Ek+zZqMAK77l6QSrSLiZEFwv2zbQTFMhQOYGcc3GlwLSMSzfX7iE9VBBAMPWUsv8nIUWF/3MGFxiSaHX3EHhHEm/9xQjQgYJIvGI8Kmt/8vDnXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767957853; c=relaxed/simple;
	bh=Mm2Og+LqfzWiMRS7I2oIhmU7D+7uKsbAlkLZJPCcT2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Lsh/nGhNGme9gnouXIpMu1wE9KWjWAv4CH7AxiVZfz3yxRk8LRY0DVNwqiniIUyY/91BEzosrXHgNKRei30AK4BrrNkT9mxizcdL0IPhV8q/zG40+LIYNx1RzIGh1ELTWdcVkIRTORh6kiIqw/2bj67sPnzOwGiFCJgutPFN/bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=40IS52eD; arc=fail smtp.client-ip=52.101.52.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="40IS52eD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZRfHGaKDun9tP8fOWrV5yMw3U2tuiO/3XDo/T3d/N1sbeRjHTkNr/gziOHbptjh7HntB36vBplG/uuqes4ELVmjir14SsUUF0rC+jIR0njnkUS6ulyuaUYVOgU+hXAwmC7w6buL5cIuUHINFOYAm7rjPBYAVSirED1XN5qDxX89UiwmSM0bkE3j8KcGQMXXiuzx7HAwEsfHgcQTt/hP4h8a0Xt7W5tExroZRuTckq7gbUqw94/JMeryMElOcbrDvmaBQW8S+UU25Cxzxd6S+FWMLcdNMSrvNVU3s0p1ghK6fB09B32wXkT6M3vCCGAh3D9hxuQjfmBLULP012kmuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPSb70LDiBS2UTYihHGiUVLvwWjPV6m9cg7n8YbIVoY=;
 b=bAUTAgCRM5cweHoGRYby99XtCD3zhF6FErB+DFKJqsmOyMFwjDQLBkfmPSMQQ+CChyYSfAAOsK3tAdc9X138WRHaezPHOJliO6K4uTigPSU9bA43JyKovsiHOGI8tPluoKR+XOeZXD2D8wQWmxYKGk1kKqlfqtZUgTxQZh/PSDOA9eBnh09S8ynixWmBEcdJYIQm1UyDdb9jnn5B7LCfVEcqPJU6BG51rpJTrPm4xUd5H4cbKyQUtgu/MM5kFA+fhpHbSt4snvq9qk9TB2VR/H6qC9q/qMDKQYJCd3XiK/ou5+pM+gvZmsFWA7T2y47eqmVH/3x9xEtNNF2PQHSsqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPSb70LDiBS2UTYihHGiUVLvwWjPV6m9cg7n8YbIVoY=;
 b=40IS52eDdvBz0j3tLfxI4hi4kCWF1v9e1KqR7Ey2D1L9bTHTF8GpN6B/wQrWGTNl+mEFDpS3L7GeQ8jowCn3uGOtzwZU1EPjX7QW1JTJSI/8w0HjWMgb/Qa7sPfkwayOYtGawgrBOXvyW6EmXnimGbHVhsvecNCwOO3qJbfrxiM=
Received: from BYAPR21CA0025.namprd21.prod.outlook.com (2603:10b6:a03:114::35)
 by SJ5PPF2CD49510F.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 9 Jan
 2026 11:23:56 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::71) by BYAPR21CA0025.outlook.office365.com
 (2603:10b6:a03:114::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1 via Frontend Transport; Fri, 9
 Jan 2026 11:23:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 11:23:56 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 9 Jan
 2026 05:23:55 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 9 Jan
 2026 05:23:55 -0600
Received: from [10.136.42.229] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 9 Jan 2026 03:23:43 -0800
Message-ID: <79489188-ba79-4f98-bca5-6c64c5f13b38@amd.com>
Date: Fri, 9 Jan 2026 16:53:42 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 01/11] perf: Add print_separator to util
Content-Language: en-GB
To: Namhyung Kim <namhyung@kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<irogers@google.com>, <james.clark@arm.com>, <ravi.bangoria@amd.com>,
	<yu.c.chen@intel.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<sshegde@linux.ibm.com>, <ctshao@google.com>, <quic_zhonhan@quicinc.com>,
	<thomas.falcon@intel.com>, <blakejones@google.com>, <ashelat@redhat.com>,
	<leo.yan@arm.com>, <dvyukov@google.com>, <ak@linux.intel.com>,
	<yujie.liu@intel.com>, <graham.woodward@arm.com>, <ben.gainey@arm.com>,
	<vineethr@linux.ibm.com>, <tim.c.chen@linux.intel.com>, <linux@treblig.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<santosh.shukla@amd.com>, <sandipan.das@amd.com>
References: <20250909114227.58802-1-swapnil.sapkal@amd.com>
 <20250909114227.58802-2-swapnil.sapkal@amd.com> <aVhC40oJIx1cbfiJ@google.com>
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
In-Reply-To: <aVhC40oJIx1cbfiJ@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|SJ5PPF2CD49510F:EE_
X-MS-Office365-Filtering-Correlation-Id: da344e96-e0f3-49f8-e0f4-08de4f7193f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTJPTmFvQXdKWnhTZHNaQW1XUmdhMU9rb2pqMWphbGh1R0xTejd3MW5sYXJm?=
 =?utf-8?B?KzMrS1poQmRjTGEwMjhGWHNrcWE4N1JFOHpmOHJ5RkxCWmVWcll5R0RCa1pN?=
 =?utf-8?B?cGFSamN6Z3NkNlU1cHRhTjljOTdSZTl0OENKWVBBeG10WGRkZnJIK0VpZS9M?=
 =?utf-8?B?VVl1cld6clNQMVVJZUZmRG1hSis1RUd2Vk5CTzJveDJtL2hKTFM3dWhvaEhP?=
 =?utf-8?B?eElBdnhxU3k0VUkzWnlnV1JyRlJNVjZLVE5SRjF0T09HcmFlbU8xTWN4MkxR?=
 =?utf-8?B?UlhvZmN4OVppNk9HbldqV0h1Qm9TZmlBd2V6ejJDN2c4d1F1dmVCOERJRENG?=
 =?utf-8?B?NVlWKzlCQnVDcnlRMlEwdGpsL1kreXc3UHN2UlBVNjFHSUJoWnJCOCs0Rlls?=
 =?utf-8?B?d0l2SEkzY3ozeVdjSFhnVWhQSTlrMnl2ekZkeUdmelZuUUN2ekFUZTYxUWJh?=
 =?utf-8?B?VzI3YlJGaUVPNTQrWVVKY2hEMEF3a2FoVFlvaWhncUpMaHZTcTZQNldnRUZr?=
 =?utf-8?B?U1gwVWJkQkVDWHdEbG1rVUIzcUVJZVZ5ZnJRakNnSlVwQUt1RE82UlhuZTZN?=
 =?utf-8?B?c1g3UTU1R3pqRlJtRjVla0FLQThqaW9DWUN1UDBoRGg2b3BJNFg4cDZmWUFF?=
 =?utf-8?B?UFdoUTRDb21uSEx1djE0WnB2eGNtZFlFVTByVHU3SWhmZFljdG9OejU4UGdK?=
 =?utf-8?B?SlZPZGdUcGRBekFvYVRYWmlWNktzUDhTWFM4YjVaLzBMekxrZHY4cDI4eGJr?=
 =?utf-8?B?RktiaFZVL2pHa2tyaitzZDJ2UHhiajd4cldVSVhLVStFNnoyWkxJclJRL09R?=
 =?utf-8?B?Z1A5SGpFWjBzS3diZWV4SytBTGY1WFVtUzZuVDZBWlpGTWVsNDlib1dxY0Z1?=
 =?utf-8?B?MEZUSHFwemRQZVBWQzczY2Vkb2V1b2kvVlhaaG9PMGhBQWtPSFQ2YnhTZUxL?=
 =?utf-8?B?SzFhWFBlU2tTeXZBWTB4QzVVL0duQkZmcE1kRXdicHNMMDdON2ZmNWNnOGhS?=
 =?utf-8?B?bGw4c2FUSVFxcmRoZ0l0a1ZhM01MZUtpNVNnKzhENzgrL3VIRFdZMWNtN1NS?=
 =?utf-8?B?VUF3SncrNFJ1azJMTkl4dmxDTWx1a1o0ZFFnTHBjY0J2ejBpVmlndEpTOXBX?=
 =?utf-8?B?QzdGcWlMVmpGODRTZGdUZTdxNUF4WXRGd1RYRjJzZTFoaGI0NE5oYWZYVXlj?=
 =?utf-8?B?eFM4MHFqb0NOdTREWUQ5NFU4WVBucFBDM1hVZzRIdHoydDNJUW9xRGp2eFlU?=
 =?utf-8?B?cEJ4MzIwQ1ZGc1grb3lVY09wNTllak44UW1BWmpjcVk0QXkySThWOGJicDZr?=
 =?utf-8?B?TVlrblVJNlJUTVB1UWZMVk9Yd05RUzFMclM1a1Y2VUVFN2tmcHIycW1VcUtD?=
 =?utf-8?B?UncrM2hJbTFzZTM2TDJUT1lOcjJkZkk1OUl1dFcyczREMFlSU09DRUt3LzFL?=
 =?utf-8?B?UlFQdjJLMHMxMUtVTjhFWXNhUC9KVjZRQk5YelBJdERZOFFvZGY2T2hPTm1I?=
 =?utf-8?B?dXhNSk5TUkZ5Wk9KQzY0Z2VhNG5sdVlxdGRyanBOdW9kcG1ibGZNanFCNldB?=
 =?utf-8?B?THJwNWkranVzYzhyTytMcjFLbU9hbklNZWVCY09lV2U2VjFQS2JRR09iaFhp?=
 =?utf-8?B?TTljQ2JlNUtPckhEUFNvcGtkdit3bFVvd0pBd3l6UGZHVzFhdFRKRURKOVVl?=
 =?utf-8?B?WE5rYmI5dDhFQlBLZWVHMDkxTUlxM0hndzd6UGZPbGx2UHN0SzVaVUNIVnhE?=
 =?utf-8?B?U2xXRlUxdTBGaEJVeitBaFl5eGlNM3NWMWxzdUxPdXhWdUNhcy9Lci9PQkcv?=
 =?utf-8?B?Q3VsdksrUGNTYTBtSHBGTkQvaUJ4dXBwSStHdzZpTEpsdENua0poQ2FpUDg1?=
 =?utf-8?B?VmZLUDd4dE1rWmd5OWxySFRVeks4NVJxN2Z6TTNOaW1xektlaXdNakRsQWNG?=
 =?utf-8?B?cisyKytEQnloVUZYQ2FxTW5ZVnp4MDh0WEVyWnFnZHZ6RDg0SE9PVjJsZU9C?=
 =?utf-8?B?cncyeUFxb0FmUTgrbUsvbjYweHRPOHJKL2haQ1p2Rml2Uys5SGtkUEFuTDNn?=
 =?utf-8?B?dWRMZjlMZHFnRXFyRldyRmhFN3liTUFvb3VRUWU4UEtEdkRmc1JpREp5Rnl0?=
 =?utf-8?Q?zWnw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 11:23:56.3854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da344e96-e0f3-49f8-e0f4-08de4f7193f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2CD49510F

Hello Namhyung,

On 03-01-2026 03:42, Namhyung Kim wrote:
> Hello,
> 
> Sorry for the delay and happy new year!
> 

No worries at all. Happy new year to you too!

> On Tue, Sep 09, 2025 at 11:42:17AM +0000, Swapnil Sapkal wrote:
>> Add print_separator to util.c and use it wherever necessary.
>>
>> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
>> ---
>>   tools/perf/builtin-kwork.c | 13 ++++---------
>>   tools/perf/util/util.c     |  6 ++++++
>>   tools/perf/util/util.h     |  2 ++
>>   3 files changed, 12 insertions(+), 9 deletions(-)
>>
>> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
>> index d2e08de5976d..842f59ff85ac 100644
>> --- a/tools/perf/builtin-kwork.c
>> +++ b/tools/perf/builtin-kwork.c
>> @@ -1340,11 +1340,6 @@ static struct kwork_class *kwork_class_supported_list[KWORK_CLASS_MAX] = {
>>   	[KWORK_CLASS_SCHED]     = &kwork_sched,
>>   };
>>   
>> -static void print_separator(int len)
>> -{
>> -	printf(" %.*s\n", len, graph_dotted_line);
>> -}
>> -
>>   static int report_print_work(struct perf_kwork *kwork, struct kwork_work *work)
>>   {
>>   	int ret = 0;
>> @@ -1458,7 +1453,7 @@ static int report_print_header(struct perf_kwork *kwork)
>>   	}
>>   
>>   	printf("\n");
>> -	print_separator(ret);
>> +	print_separator(ret, "", 0);
>>   	return ret;
>>   }
>>   
>> @@ -1633,7 +1628,7 @@ static void top_print_header(struct perf_kwork *kwork __maybe_unused)
>>   		     PRINT_RUNTIME_HEADER_WIDTH + RPINT_DECIMAL_WIDTH, "RUNTIME",
>>   		     PRINT_TASK_NAME_WIDTH, "COMMAND");
>>   	printf("\n ");
>> -	print_separator(ret);
>> +	print_separator(ret, "", 0);
>>   }
>>   
>>   static int top_print_work(struct perf_kwork *kwork __maybe_unused, struct kwork_work *work)
>> @@ -1933,11 +1928,11 @@ static int perf_kwork__report(struct perf_kwork *kwork)
>>   		}
>>   		next = rb_next(next);
>>   	}
>> -	print_separator(ret);
>> +	print_separator(ret, "", 0);
>>   
>>   	if (kwork->summary) {
>>   		print_summary(kwork);
>> -		print_separator(ret);
>> +		print_separator(ret, "", 0);
>>   	}
>>   
>>   	print_bad_events(kwork);
>> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
>> index 0f031eb80b4c..1b91834e11de 100644
>> --- a/tools/perf/util/util.c
>> +++ b/tools/perf/util/util.c
>> @@ -257,6 +257,12 @@ static int rm_rf_kcore_dir(const char *path)
>>   	return 0;
>>   }
>>   
>> +void print_separator(int pre_dash_cnt, const char *s, int post_dash_cnt)
>> +{
>> +	printf("%.*s%s%.*s\n", pre_dash_cnt, graph_dotted_line, s, post_dash_cnt,
>> +	       graph_dotted_line);
>> +}
> 
> I think it's better to keep the existing interface and add a new one
> like print_separator2() for your case.  The old one can be implemented
> on top of the new API.
> 

Sure, I will update this in the next version.

--
Thanks and Regards,
Swapnil

> Thanks,
> Namhyung
> 
>> +
>>   int rm_rf_perf_data(const char *path)
>>   {
>>   	const char *pat[] = {
>> diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
>> index 3423778e39a5..de69384380c2 100644
>> --- a/tools/perf/util/util.h
>> +++ b/tools/perf/util/util.h
>> @@ -48,6 +48,8 @@ bool sysctl__nmi_watchdog_enabled(void);
>>   
>>   int perf_tip(char **strp, const char *dirpath);
>>   
>> +void print_separator(int pre_dash_cnt, const char *s, int post_dash_cnt);
>> +
>>   #ifndef HAVE_SCHED_GETCPU_SUPPORT
>>   int sched_getcpu(void);
>>   #endif
>> -- 
>> 2.43.0
>>

