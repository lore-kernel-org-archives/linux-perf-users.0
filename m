Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F309277016;
	Thu, 10 Apr 2025 10:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744280975; cv=fail; b=jib0MQChvine1oH5/GTNn5XMnVKUqi7SKPEwqcIqbgzUgqtw2Vi3pt+stfSDtHKuWTBX4fQhxoWwZFLBD6CIOmG26XJcs0kkINqiFFn2BmfythfaklQxmrxWF5EO0e7+hUCtsB+dwJLo2/tgsH0b9T+33JtLhTkbOWRjc1UOTdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744280975; c=relaxed/simple;
	bh=V+O2omP/sXpY/jdGuveTuT5Jp+4oU+0Z1FzV70puw+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=taJ5x9+5mTv6Rh5AeqccDtq/H59qff1LRV0tQ1vgRPbQVoar4O/6RjOFNOq2jPRIlqPl/+PkbdEsaHmb9PxhguQ3/45wX2Nun1qAEPpL4h8tEAq5B1RH7nL7/CdBUVnxF9Gc8oDJ9rOEdttzE5tug++C87WZCNqsFWDH/gyU1LI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tKVnMzHd; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tKVnMzHd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhHw++zQO8EN8wnaNOEFnzSA1eevntBM9Z0UhdnWg/W58hi7eYkPp3nxm2tkT/6BI7omJtyp1soMrDcFb+KdIYGYIueSC2gpzS1TDFmXdJPy1IGOA9PiPTof1/XZdVeeGTrUBq1heYMLok9Nzz0Wok8BdrU2B3z603UrvcFMlE5YwEDMCE1OSkpv6OyPCCajG1kSHfxCP/62+LAse0H4De6gHedmx2sMDln/OSGYq09J54sGqQaVleLR/4viOfHe9sUboiYFezLMJEQQdpTyx/lgMfbsBidmfBhtdQ6l/Z7kqgh4YuRPIs6tmk7pUrXp/aYUBg2a66jQjNUqHerI6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHAFLng+WWz3mBw5H4e+/J7tSVlNa3Xc6mI93eLNycI=;
 b=C2PztCngTNOWafkdiTW9vWJC23ZtNruJqpyjKEqWAg0P/q4x0isjlmEeWah0OYijc5d87sVii8tdTTYtKXWAAAOJA4SbrPTH6hCZ4S9/BYzRPJiws6x9wn0GYnhJsZNztyOZuyrKojkArHikewRhFN6QsARWQS2GiZPKWkAGiQ4cXyMkUGsNiXgg+8IZVcv48eiDQilaSbNA/YKdu4DELJXQvSz/NvEqxhHfXegOc3xIVoDahwy+OWsHYac4QjN+iV52N+TfPtubUyAXMZt9aWZL6C1aejGGHd+NBpX3kPtfx/SwrUXblmUuv5LiOYlgtuKS9v3N3Uz12zBXEBQ/Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHAFLng+WWz3mBw5H4e+/J7tSVlNa3Xc6mI93eLNycI=;
 b=tKVnMzHd9qmisPlOShGSJB8a490ejUPMyBrjG05xqPH6OQur0nN17+kUrMYNICHn52FblSAO8QtG1rMelW7aIo4sdOn0NDpGW0WsANfzogxckdw3PwSyBjRvnr+TBgbUw+uCXFjJ0ePHKKpU1f20gIc1BzMQlaocZnBR1c8Il98=
Received: from BL0PR02CA0092.namprd02.prod.outlook.com (2603:10b6:208:51::33)
 by MN0PR12MB6245.namprd12.prod.outlook.com (2603:10b6:208:3c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.24; Thu, 10 Apr
 2025 10:29:29 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::e3) by BL0PR02CA0092.outlook.office365.com
 (2603:10b6:208:51::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.23 via Frontend Transport; Thu,
 10 Apr 2025 10:29:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 10:29:29 +0000
Received: from [10.252.216.136] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 05:29:21 -0500
Message-ID: <1840fbe3-d538-4b41-8465-c22d9f1d1e1a@amd.com>
Date: Thu, 10 Apr 2025 15:59:04 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] perf sched: Introduce stats tool
To: "Chen, Yu C" <yu.c.chen@intel.com>
CC: <ravi.bangoria@amd.com>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<gautham.shenoy@amd.com>, <kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<sshegde@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <santosh.shukla@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>, <peterz@infradead.org>,
	<acme@kernel.org>, <james.clark@arm.com>, <namhyung@kernel.org>,
	<irogers@google.com>, <mingo@redhat.com>
References: <20250311120230.61774-1-swapnil.sapkal@amd.com>
 <917bb3c8-e084-4790-b0ac-f0433cfca758@intel.com>
Content-Language: en-US
From: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
In-Reply-To: <917bb3c8-e084-4790-b0ac-f0433cfca758@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|MN0PR12MB6245:EE_
X-MS-Office365-Filtering-Correlation-Id: dd227597-100c-47ff-6fbe-08dd781a93a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTZrZ3B5MlhJNHdlRW9UTjI5VTByRVQ5S1pIQStZOGdJS2ZJZTFnUW1tWlBG?=
 =?utf-8?B?SkJKL3dCc0l3UXN6SjB1SlBBUXY5cGlIUldqbGFmdnpDaEhkRjlRYUNuaTlL?=
 =?utf-8?B?Skl1Z1BFMUZlMHRwb3crVXdNang0YzlPYWw2dVRVRm80dnBwTm5ld20yalBR?=
 =?utf-8?B?cVE5ZVdOSjlERElMRU83VVFrSWMwUkNTbDZaTDJvbHdJSElvODN6QzNTQitP?=
 =?utf-8?B?SGxwdGNBbmpYY21vSFRtL2t4cEp4MFdvdVJXdkl2aWxiTGJtbnQ1M3l0dEVz?=
 =?utf-8?B?a29MUzhGS2VZa1hrOWZnQTlqbHphODBCem5kcmtpSWJ1Q0tSSHNLMzZYeUlS?=
 =?utf-8?B?NnhIV0F6Rll6NDRwSjc4M0xsWGY2MExlSXcyTDduOGpLUHlFd3FZdzVXbUhK?=
 =?utf-8?B?SE42dzRyRE9jQWM2a2ozVDdWWUhsVnloeUwwNXh3eklFelZRMmhab2lRVlpF?=
 =?utf-8?B?VWxEcGhIa0N4VzVNSFlBbzUwWkhvdUVQc1dydXFicDBXcmo4YjFhWGwxUHZG?=
 =?utf-8?B?b0gvbGdYcEFaVmJabnF5d2RSd1RDcW1IQlBXMTM0cyswZnh0bmhKM2Z2cmdu?=
 =?utf-8?B?U1RkdTRRRmdZTGNaZDRQZVNxY0VtT2k2OW5FRTNZRzk5TExPT2dMbHdGYkFN?=
 =?utf-8?B?VHdCbk1SU3lUT2l6cDU5RzNlY0ZNYlNnNkdiV3ZJQmNGaDExb2VYeUdUa21q?=
 =?utf-8?B?U0I1WFJLSDBvcHZwMnJ2TmFIZ0pzRmtWK0h6TVFabW5IeHJ6QlB2dDd0Nmdx?=
 =?utf-8?B?b1dIR2lMTTZDUTE4S2xMMHNlZytDNFVLdWJ2OWNCR3h0ME0xdXNLUnpOZzEx?=
 =?utf-8?B?U2NqVHF2Z1JqRkZWTmJhWHFER1BsbWNCbWpJanhvZXpwMUlneFpQTnNGRkpT?=
 =?utf-8?B?SXMxdjFraWZFbnZSbzRaMkpWQ0N2eEkyajgwT1N5cmxWbk5UTTJKNGw1eVNa?=
 =?utf-8?B?bUI3T2VFckh0YjRLbVowbm1TN2pqeWQ0SW53cW1RMm5mVHVlM3VIT3VsdHpS?=
 =?utf-8?B?TkJhUVVDcW9BTjdrTTIvcDRMMnRzSFViK0tzVGlCZmY1UTBMdHNGWmU0UVd0?=
 =?utf-8?B?aGRNVlhiRTJBZ2oyT0c5NkhnbXlvcDJRSmNMMUd1N25KMGhsSUxSSTNGR2Zp?=
 =?utf-8?B?aTE3YjVhSEZ1STRuTGNkUHExS01pd2hvaW1jN1ppZW90em1lQXdIZWVvVjNW?=
 =?utf-8?B?M1RYYzNDWXdGWnJpQVBzb3ZtYktqSzBZaFhZM29DS0xBN0FqNmNsUEluT2tD?=
 =?utf-8?B?cEtnRlFHOHYwMlNvKzB4RGovVlRSbDQ5Q3JaQlJyckRoUi9OVXlXcG5xczBp?=
 =?utf-8?B?bXdaT1NHbXAwd3NDODE1dVZrZHFFd0lCMEdKaGVSY29mMFMzZ0VJc2JJVndl?=
 =?utf-8?B?TFN4VmJDVndSOVkwNklRV084YVE2V0wwTHpjNFFZbFgyLysySTN6UDN6NlFy?=
 =?utf-8?B?dG5hZ1JSRlNGSXhSc1N4bXZZK3FkS0lVNXp2ZW4yYXhzcmNMckdsdytwTG9H?=
 =?utf-8?B?dERkdHRoVmpvNjFpWk13WXMwdkxxWmtNeEtDTEI4RnBJSGp5ZlRDazljT0R3?=
 =?utf-8?B?a2tuMDU2WFRQV0R5MjlHdG11QU8yUDRLclNia1o0UVhibS9DZXhRMEpXeEo3?=
 =?utf-8?B?dFlYZTU1eHZWZDJJRWxmRzNDSlZDN1NNTXFzakljY3p2NHkxOFlWWVBOYjZ4?=
 =?utf-8?B?bUlTVGlGc2kxb2Z3MWxmcFY1UHpxWVFzOWV1ZUdJd1dmcm1QbEFhRnFSSzJu?=
 =?utf-8?B?RFhTaWpOdTVhd29kQXJHNERNMVlMR29DR1ZDcU4xRlJ5MmJSQVg3K0xYUXpP?=
 =?utf-8?B?VCthOXlDbXNJWForSnowd2N4TWdxa1hLWWdkczFqdDY0aW1yVE80TUNpV2kv?=
 =?utf-8?B?RnEwbGd6NFdGRHZRekFzOVh6eVQvRHhMWExNbVh4allZNzZYZVVyQlZuRmtp?=
 =?utf-8?B?b1l2QUZNZ2oreVM4djJtMCtPbmVRWnVwMWhYRWRjVUdPeGxlejQvUk0zMUh5?=
 =?utf-8?Q?vLUsx8d8J/TGCcKGiEXlJhm89yYsyA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 10:29:29.7716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd227597-100c-47ff-6fbe-08dd781a93a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6245

Hi Chenyu,

On 4/10/2025 3:11 PM, Chen, Yu C wrote:
> Hi Swapnil,
> 
> On 3/11/2025 8:02 PM, Swapnil Sapkal wrote:
>> MOTIVATION
>> ----------
>>
>> Existing `perf sched` is quite exhaustive and provides lot of insights
>> into scheduler behavior but it quickly becomes impractical to use for
>> long running or scheduler intensive workload. For ex, `perf sched record`
>> has ~7.77% overhead on hackbench (with 25 groups each running 700K loops
>> on a 2-socket 128 Cores 256 Threads 3rd Generation EPYC Server), and it
>> generates huge 56G perf.data for which perf takes ~137 mins to prepare
>> and write it to disk [1].
>>
>> Unlike `perf sched record`, which hooks onto set of scheduler tracepoints
>> and generates samples on a tracepoint hit, `perf sched stats record` takes
>> snapshot of the /proc/schedstat file before and after the workload, i.e.
>> there is almost zero interference on workload run. Also, it takes very
>> minimal time to parse /proc/schedstat, convert it into perf samples and
>> save those samples into perf.data file. Result perf.data file is much
>> smaller. So, overall `perf sched stats record` is much more light weight
>> compare to `perf sched record`.
>>
>> We, internally at AMD, have been using this (a variant of this, known as
>> "sched-scoreboard"[2]) and found it to be very useful to analyse impact
>> of any scheduler code changes[3][4]. Prateek used v2[5] of this patch
>> series to report the analysis[6][7].
>>
>> Please note that, this is not a replacement of perf sched record/report.
>> The intended users of the new tool are scheduler developers, not regular
>> users.
>>
>> USAGE
>> -----
>>
>>    # perf sched stats record
>>    # perf sched stats report
>>    # perf sched stats diff
>>
> 
> May I know the status of this patch set? I tested it on a 96 cores system and it works as expected in general.

Thank you for testing the patch set. I am working on v4 based on the Namhyung's suggestions.

> 
> One nit question:
> Is perf.data and perf.data.old the default files
> for comparison if no files are provided in
> perf sched stats diff?
> 

Yes, if no files are provided to `perf sched stats diff`, it will take perf.data and perf.data.old as defaults.

> 
> thanks,
> Chenyu
> 
> 
--
Thanks and Regards,
Swapnil
