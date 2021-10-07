Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F439C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 19:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD8E46101E
	for <linux-perf-users@archiver.kernel.org>; Thu,  7 Oct 2021 19:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbhJGTT2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Oct 2021 15:19:28 -0400
Received: from mail-bn8nam08on2054.outbound.protection.outlook.com ([40.107.100.54]:43617
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243887AbhJGTT0 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Oct 2021 15:19:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kjw8MoQQaEhW7YZo/y+aKbzLaiCX/86Tubx8E0CfE2/FUQo+EeKb6gs8K2JczVVyAYezkn5IFLMOdjfQs+0Doa+LL77WmCigLYvqGuTqfcy0tYrEYFJSy8upDHiC1u7ANIZVF0sytXIEjrXpM1ACcG00qpt6c61L/71XFoAgBvBmpYCeR9OUcIxNKmOsE/y0+8ua0uWN3A9g7xXuPpIEnj8ZzP/0Z9uBoEHRYXEXNyZCRdFY/4D+RKTgat2M4mGphQF7ew1jWngDrW13GkJwARZdLjF038X++LaTvdI9phgYxGASYe5xBlThV/F+sMJVm2s2SglA8TbEqiVKfVU91Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+sqhYwki2bXR/z5Sez8yZf8kHtJzFH3zwhwrIhEPok=;
 b=DhUENuMFbRbaMPws5yTP/mXGie71MihzHY1ncSH830J4BYkuQHlnfC8vKkefvdFAd9y2AIzfZwgmY3wm0t2GCt73hxgutdw6SRTLv13QdRb+1ZxBXQ4G8HdhOJBg5+q5QHsCnSWy6hiEMEI2ZNVkuR7XiwKlTlKbd1tHmP4Sa0ZXPOnIYkdX5Ofoqu7Ftm06GXB4dDfum7m5sMRQPz1DTQg0Ng+Z6Tmm0W+SjvIQJGtzlRNDRNFO2KKv534nA4kbbooVZ7GQ33rlqKyCGN8zWYL22+TLZBuG45AB+UDJKOThgHrdAWgpoCRSQa82E6oxgXxfS/LG/FFh9BhytsVzqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+sqhYwki2bXR/z5Sez8yZf8kHtJzFH3zwhwrIhEPok=;
 b=ol+bxBiNMXNqKoDYxbo4GMLpA/ah0mKwctOytihCwrmqFnKcql484SJ3L67ngcpLj43TeiJLNUY6XDSs3+kSUsp7ak/dl/SaAxJ7h9I2PgAp9Legy2E63ojH+uAZ7mxtQyAZya/AA3LjgncbzRzuXTZpN2lyPXj0iP/TEI9fwSc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3505.namprd12.prod.outlook.com (2603:10b6:408:69::17)
 by BN6PR12MB1394.namprd12.prod.outlook.com (2603:10b6:404:1e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16; Thu, 7 Oct
 2021 19:17:29 +0000
Received: from BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c]) by BN8PR12MB3505.namprd12.prod.outlook.com
 ([fe80::704c:60ed:36f:4e4c%7]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 19:17:29 +0000
From:   Kim Phillips <kim.phillips@amd.com>
Subject: Re: [PATCH 2/2] perf tools: Improve IBS error handling
To:     Jiri Olsa <jolsa@redhat.com>
References: <20211004214114.188477-1-kim.phillips@amd.com>
 <20211004214114.188477-2-kim.phillips@amd.com> <YV8uQVnMnnMd1Led@krava>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Richter <robert.richter@amd.com>,
        Stephane Eranian <eranian@google.com>, kim.phillips@amd.com
Message-ID: <8a8583dc-5a5d-f107-8ef0-6be96e2f9095@amd.com>
Date:   Thu, 7 Oct 2021 14:17:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YV8uQVnMnnMd1Led@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::11) To BN8PR12MB3505.namprd12.prod.outlook.com
 (2603:10b6:408:69::17)
MIME-Version: 1.0
Received: from [10.236.30.70] (165.204.77.1) by SN7P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 19:17:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef234e86-4727-4643-4379-08d989c71afb
X-MS-TrafficTypeDiagnostic: BN6PR12MB1394:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1394A6C98157D11CBC9F71D687B19@BN6PR12MB1394.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 42v0woKd0ve8onWLKIrQvsgZUMhGR0IoUj6YEfYuYTUmjCuUc80u6lXOSpRYPciJji8nrsUMWB8xW5vI+wsrmn2/wEceXJKAZS3tcimtzK0/z00SX6qNVzmz4sveuI9zMEFPzBl74YBdklFb8YnXDz5zVuS1yW9kG+6v10Dq+v4dmBb+B7bV2ozKefJjJpcndnI0ZKNWYouLLBo28INT2NqM9eznEHQPZgbG5h+6eVb1OUmPSyFN52QGHLJfnbS4KvcQjcO19cRvwH6RnIU49UlUJymX+TGkqmseHgNV/V14l0E1SplTJ1HSaDCouJZuOuvYkG9fS77bFc0neH8XQMc5ckCQ7RdI597Dfst/wSZHtQdpLezp1aL17bP1qHrXKpg7U6u94z41+I1WRVK4UpMuszFJwqa21WgX4UwIPp1yJaKE63/679s9ygcheLLzvPhyA3M+uxkCyXb6SnxgXo6qhFS/wfhBgF5A5Mt8XEpNEJ8L332N6f1xmdv6FA3Xvl2iUsrtQP80ZUGxjpXiN6t1xZgxbxzwSNjDYHWQkzB4wsao9d+gUQhvogS/kBeHtDIGzlBYCTpOkJGZXgWv408eRtGdE6rhghFb3Fp3LX1sXtt+dKnbJtvWg5rtypmqlW0ag1+xRAo+6lpaCOGj+p0cqlzYUQMLrwkrqmB1tpX8OitfKhpnUhBSB+kOVcEME43ZlKRc4u9b0qArPgqOjhfuOVsXtE6z9sevDQ5yLrk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(316002)(6486002)(7416002)(8676002)(508600001)(6916009)(16576012)(2906002)(66946007)(36756003)(186003)(956004)(2616005)(31696002)(31686004)(5660300002)(26005)(44832011)(8936002)(66556008)(66476007)(83380400001)(4326008)(38100700002)(53546011)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXFNbEVGU053NnJBcDhWdjkwRVBOMk1XRkJGRnRicjN0RUJQRXFLZGRJNW1B?=
 =?utf-8?B?cGVndVVTS2lCSCtyWHV4dVFEdzlWd3R2SWF0Mm5rQTRhRWFiMzVOdTRCRzBj?=
 =?utf-8?B?SUoya2hrMG5oeXhTRnRoUUwrMHdRbER5QXFZWWtXL2hPY1VSbkR2eElRYnZ2?=
 =?utf-8?B?YXQ4R0YzOTc5UzVOaFgvUXhKNWF0SkJPQS9LTmw4NTJaTmVnOVhYdXF5MndR?=
 =?utf-8?B?Rkd1RzlpMVcxTzUveTVaZTNqMjlsVmN6dU1TSGJFY083Y0t1QWNFbDdqZ2JR?=
 =?utf-8?B?dU1wcjZKSk51QlhydytxeXB3UUZwTUl4S0l0NVljRmprZEo0MmNTSE5peXRC?=
 =?utf-8?B?dVdZaVpHTFN2Mm11a0xHZFFWdmJKNUVPakhoY3p1aFBsUEtrR0tiZEtaSm90?=
 =?utf-8?B?QmdFMWxKSmRqdklHZXpNenJrU0xkcTg0MGJMV2RtZmswamxJY1lMR3NvZXM5?=
 =?utf-8?B?NGNLMW9zdTljV0tlekxZN09hbDhkaFNBSWVNNnhYdXNoU3VVdStjejBMRHVr?=
 =?utf-8?B?Qit1SzFZZUpxZFpDNUlQWlhrMFZMajJMUVhPWCtaUWEwUmJ1bDJQZDJWeExz?=
 =?utf-8?B?bXlILzNPY3dQMEJlei91bmRtOGRRb2x4K0xlczVjNllLa3FscS92QTQ3OEpj?=
 =?utf-8?B?MFBDWVFUaVhhSzFhYkh4eDgvOGx3QlNwQ01WRW9Qdk9TUDhGaFRzMEtzOU9w?=
 =?utf-8?B?bFhmbzhZVDF3akI1ZW1VclRWbDBPdGRhV2d5N0lsak4zMndNUmNidUREN0Jj?=
 =?utf-8?B?UDZOM0RmWk1GUkxlQWJBdjRHU01kUGJTNDhyc2xlb1pJYzFiUCt3NDNueXp4?=
 =?utf-8?B?K2dzNnZ5b1hGQWRWMStod0NDLzVwemQ4akFGRlVEN041UUM0dlZrck9yL2RX?=
 =?utf-8?B?alhrTWRFN1Q5cTlyTFloTWJ3ZnlhVFVXY3dYSlFya3MycE1ucFRoRUdsM3NN?=
 =?utf-8?B?bGNEMFBUeE9Kd2xiTWpkQ0tZeEpTcHVmQVdrRjJrUVUvRmVvdU9lVU9DNGc5?=
 =?utf-8?B?Mk1LdmcyWngvdW80QUxhMHc1Ui9WdGJBc2ZUcGoyWXJMMzBXVVFkbmhpd29X?=
 =?utf-8?B?OUM0Q2hPVm01MjIwOFdmc0RudytNWEhmZnlpYWVMUzZ2eWZrTWhxRWRocmo1?=
 =?utf-8?B?SDVodUR5eExUdHpHNzkvNFBWcWMyK0lhdDVZS1VRRFhsTUpiYUJJZVNGZXRo?=
 =?utf-8?B?NVFYUUdiWlZSWHY3d0R2ZG1meWpkbzk1dFpLUWF4cngrVmUvNzI0RStkdGdw?=
 =?utf-8?B?V1A3dklOaEJZSnIzd2s2RUtvU0h3bWI4aWlrdy9FNjZOdktPQS9TT3o5eE9o?=
 =?utf-8?B?aHZmSHFGbjdSMGJqZWI0U0U4OWVIbWNtOUNtQVFQRVVSOWU3L1ZGU3FmTUlP?=
 =?utf-8?B?VHBuUEFEcndKNGRZeWliOG1xRVl6bkVMcTl1TFZVK0pjb2cyb2FKZWJhZ1hY?=
 =?utf-8?B?Z0N1ZEVQc2c2TDFuc0Y0OGdZemlEWnlPYmkza3BoVDhGVzdqY1FFNEt0SDJV?=
 =?utf-8?B?SWpqbTJRTUpWMS85UDZidkhPc3lhWVQ0ZFl4aE51Q2d2ZU1rblZRQXEzR1N4?=
 =?utf-8?B?ei9YZnM5VkI5K2wwWmVYZ0VnZmZlUVhIQU1JVERQQkQzYnNlZXhBR1BZY05T?=
 =?utf-8?B?NXVtVW43a2pMK0duc1E1RXFXQkU1ZWRPSGttODVnODRlajZuclptMUJscUhN?=
 =?utf-8?B?dXBxK0UwZklRUEM3SGpGRzh0UHdHU1AvNCtoU3hFMVNjVVRTQWhkTkRYdEIr?=
 =?utf-8?Q?RW+DUdIoEU90GZscxjaXGSpsJKvrleHObCfMpRK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef234e86-4727-4643-4379-08d989c71afb
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 19:17:29.5576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjHI9XbJCtRwysQ1Dc+i5NFjSpRbtb+yNuldj0sq3D7L1U56dUxEIaA8RvhY+FVAaCqnAqPHZkNSoQeH8XJ53w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1394
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 10/7/21 12:28 PM, Jiri Olsa wrote:
> On Mon, Oct 04, 2021 at 04:41:14PM -0500, Kim Phillips wrote:
>> ---
>>   tools/perf/util/evsel.c | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index b915840690d4..f8a9cbd99314 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -2743,9 +2743,22 @@ static bool find_process(const char *name)
>>   	return ret ? false : true;
>>   }
>>   
>> +static bool is_amd(const char *arch, const char *cpuid)
>> +{
>> +	return arch && !strcmp("x86", arch) && cpuid && strstarts(cpuid, "AuthenticAMD");
>> +}
>> +
>> +static bool is_amd_ibs(struct evsel *evsel)
>> +{
>> +	return evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name, "ibs", 3);
>> +}
>> +
>>   int evsel__open_strerror(struct evsel *evsel, struct target *target,
>>   			 int err, char *msg, size_t size)
>>   {
>> +	struct perf_env *env = evsel__env(evsel);
>> +	const char *arch = perf_env__arch(env);
>> +	const char *cpuid = perf_env__cpuid(env);
>>   	char sbuf[STRERR_BUFSIZE];
>>   	int printed = 0, enforced = 0;
>>   
>> @@ -2841,6 +2854,17 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
>>   			return scnprintf(msg, size, "wrong clockid (%d).", clockid);
>>   		if (perf_missing_features.aux_output)
>>   			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
>> +		if (is_amd(arch, cpuid)) {
>> +			if (is_amd_ibs(evsel)) {
> 
> would single 'is_amd_ibs' call be better? checking on both amd and ibs

Good suggestion. If you look at the later patch in the
BRS series, I have rewritten it to add the new
AMD PMU like so:

  if (is_amd()) {
  	if (is_amd_ibs()) {
  		if (evsel->this)
  			return
  		if (evsel->that)
  			return
  	}
+	if (is_amd_brs()) {
+		if (evsel->this)
+			return
+		if (evsel->that)
+			return
+	}
  }

Below is the full proposed replacement patch for patch 12
of 13 of the BRS series.

Another option is to have the is_amd_{ibs,brs} functions
call is_amd() themselves, so the if (evsel->) code could be
unindented by one tab, would that be better?

Thanks,

Kim

 From a4cbab762719b30bddec2e278cf8b8eb82e83865 Mon Sep 17 00:00:00 2001
From: Stephane Eranian <eranian@google.com>
Date: Thu, 9 Sep 2021 00:56:59 -0700
Subject: [PATCH] perf tools: Improve error handling of AMD Branch Sampling

This patch improves the error message printed by perf when
perf_event_open() fails on AMD Zen3 when using the branch sampling
feature. In the case of EINVAL, there are two main reasons: frequency
mode or period is smaller than the depth of the branch sampling
buffer (16). The patch checks the parameters of the call and tries
to print a relevant message to explain the error:

$ perf record -b -e cpu/branch-brs/ -c 10 ls
Error:
AMD Branch Sampling does not support sampling period smaller than what is reported in /sys/devices/cpu/caps/branches.

$ perf record -b -e cpu/branch-brs/ ls
Error:
AMD Branch Sampling does not support frequency mode sampling, must pass a fixed sampling period via -c option or cpu/branch-brs,period=xxxx/.

Signed-off-by: Stephane Eranian <eranian@google.com>
[Rebased on commit 9fe8895a27a84 ("perf env: Add perf_env__cpuid, perf_env__{nr_}pmu_mappings")]
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
  tools/perf/util/evsel.c | 14 ++++++++++++++
  1 file changed, 14 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f8a9cbd99314..e1f5eff07355 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2753,6 +2753,12 @@ static bool is_amd_ibs(struct evsel *evsel)
  	return evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name, "ibs", 3);
  }

+static bool is_amd_brs(struct evsel *evsel)
+{
+	return ((evsel->core.attr.config & 0xff) == 0xc4) &&
+	       (evsel->core.attr.sample_type & PERF_SAMPLE_BRANCH_STACK);
+}
+
  int evsel__open_strerror(struct evsel *evsel, struct target *target,
  			 int err, char *msg, size_t size)
  {
@@ -2863,6 +2869,14 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
  					return scnprintf(msg, size,
  	"AMD IBS may only be available in system-wide/per-cpu mode.  Try using -a, or -C and workload affinity");
  			}
+			if (is_amd_brs(evsel)) {
+				if (evsel->core.attr.freq)
+					return scnprintf(msg, size,
+	"AMD Branch Sampling does not support frequency mode sampling, must pass a fixed sampling period via -c option or cpu/branch-brs,period=xxxx/.");
+				/* another reason is that the period is too small */
+				return scnprintf(msg, size,
+	"AMD Branch Sampling does not support sampling period smaller than what is reported in /sys/devices/cpu/caps/branches.");
+			}
  		}

  		break;
-- 
2.31.1
