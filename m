Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27688C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Nov 2021 08:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbhKWIoW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Nov 2021 03:44:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233911AbhKWIoW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Nov 2021 03:44:22 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AN6Gns8028323;
        Tue, 23 Nov 2021 08:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=MeQboweeNUheoUVo5xUsdCc1WYoGzzBJH6hVFYrK75s=;
 b=e/1QnsWNxjCtk8V/5BiCNfxbxol1t+u6mB1ySNNVoi2euPD4O2f3Q0pmeKjsfBRTco/l
 elj/KRzD6EQCRckQae5PRcy5oCJBaAxX/p/c1s1GdjpquDGOnYeTWHdov7LqYOXdvmJ8
 ygBIvqwYQwbgb/W7U2HPJoQjDdRPkqbEk83FDkppfVACXBfNUcgk3Xrz++otcf0a+ZgN
 rA78RYOn3wAxQPCqJqlpOrvDiCG7daZVtf7+TIUqOxgwTs6gIqc37NCw/u5bS/h2k43h
 L+P3b88qJDym9reYvcNAGWHRK1jKdbs4ktBJghbSr96Vt52+1N/R+XJlVJqKb/T/L7bb HQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cgtw32agd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Nov 2021 08:41:05 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AN8TgLl025108;
        Tue, 23 Nov 2021 08:41:05 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cgtw32afe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Nov 2021 08:41:05 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AN8atW4011315;
        Tue, 23 Nov 2021 08:41:02 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3cern9wfgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Nov 2021 08:41:02 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AN8XnUY63242520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 08:33:49 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89CA7A405C;
        Tue, 23 Nov 2021 08:41:00 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08FBCA405F;
        Tue, 23 Nov 2021 08:40:55 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com (unknown [9.43.21.81])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Nov 2021 08:40:54 +0000 (GMT)
Subject: Re: [PATCH 2/2] perf tools: Improve IBS error handling
To:     Kim Phillips <kim.phillips@amd.com>, Jiri Olsa <jolsa@redhat.com>
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
        Stephane Eranian <eranian@google.com>
References: <20211004214114.188477-1-kim.phillips@amd.com>
 <20211004214114.188477-2-kim.phillips@amd.com> <YV8uQVnMnnMd1Led@krava>
 <8a8583dc-5a5d-f107-8ef0-6be96e2f9095@amd.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <fdcfec83-01c6-5e25-5b99-dac05287fdae@linux.ibm.com>
Date:   Tue, 23 Nov 2021 14:10:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <8a8583dc-5a5d-f107-8ef0-6be96e2f9095@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0-N56oZramO-N8aeoMfxUYulu64rAE-7
X-Proofpoint-GUID: gRj-FzQnfUpxJfyi4ery2nWZF02C6Isb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_02,2021-11-22_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 spamscore=0 lowpriorityscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111230044
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 10/8/21 12:47 AM, Kim Phillips wrote:
> On 10/7/21 12:28 PM, Jiri Olsa wrote:
>> On Mon, Oct 04, 2021 at 04:41:14PM -0500, Kim Phillips wrote:
>>> ---
>>>   tools/perf/util/evsel.c | 24 ++++++++++++++++++++++++
>>>   1 file changed, 24 insertions(+)
>>>
>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>>> index b915840690d4..f8a9cbd99314 100644
>>> --- a/tools/perf/util/evsel.c
>>> +++ b/tools/perf/util/evsel.c
>>> @@ -2743,9 +2743,22 @@ static bool find_process(const char *name)
>>>       return ret ? false : true;
>>>   }
>>>   +static bool is_amd(const char *arch, const char *cpuid)
>>> +{
>>> +    return arch && !strcmp("x86", arch) && cpuid && strstarts(cpuid,
>>> "AuthenticAMD");
>>> +}
>>> +
>>> +static bool is_amd_ibs(struct evsel *evsel)
>>> +{
>>> +    return evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name,
>>> "ibs", 3);
>>> +}
>>> +
>>>   int evsel__open_strerror(struct evsel *evsel, struct target *target,
>>>                int err, char *msg, size_t size)
>>>   {
>>> +    struct perf_env *env = evsel__env(evsel);
>>> +    const char *arch = perf_env__arch(env);
>>> +    const char *cpuid = perf_env__cpuid(env);
>>>       char sbuf[STRERR_BUFSIZE];
>>>       int printed = 0, enforced = 0;
>>>   @@ -2841,6 +2854,17 @@ int evsel__open_strerror(struct evsel
>>> *evsel, struct target *target,
>>>               return scnprintf(msg, size, "wrong clockid (%d).",
>>> clockid);
>>>           if (perf_missing_features.aux_output)
>>>               return scnprintf(msg, size, "The 'aux_output' feature
>>> is not supported, update the kernel.");
>>> +        if (is_amd(arch, cpuid)) {
>>> +            if (is_amd_ibs(evsel)) {
>>
>> would single 'is_amd_ibs' call be better? checking on both amd and ibs
> 
> Good suggestion. If you look at the later patch in the
> BRS series, I have rewritten it to add the new
> AMD PMU like so:
> 
>  if (is_amd()) {
>      if (is_amd_ibs()) {
>          if (evsel->this)
>              return
>          if (evsel->that)
>              return
>      }
> +    if (is_amd_brs()) {
> +        if (evsel->this)
> +            return
> +        if (evsel->that)
> +            return
> +    }
>  }

Hi Kim,
     From my point of view, it won't be a good idea of adding so many
checks in common function definition itself.

Can you just create a check to see if its amd machine and then add a
function call which will handle all four conditions together?

which is basically for:

+		if (is_amd(arch, cpuid)) {
+			if (is_amd_ibs(evsel)) {
+				if (evsel->core.attr.exclude_kernel)
+					return scnprintf(msg, size,
+	"AMD IBS can't exclude kernel events.  Try running at a higher
privilege level.");
+				if (!evsel->core.system_wide)
+					return scnprintf(msg, size,
+	"AMD IBS may only be available in system-wide/per-cpu mode.  Try using
-a, or -C and workload affinity");
+			}

and this:

+            if (is_amd_brs(evsel)) {
+                if (evsel->core.attr.freq)
+                    return scnprintf(msg, size,
+    "AMD Branch Sampling does not support frequency mode sampling, must
pass a fixed sampling period via -c option or
cpu/branch-brs,period=xxxx/.");
+                /* another reason is that the period is too small */
+                return scnprintf(msg, size,
+    "AMD Branch Sampling does not support sampling period smaller than
what is reported in /sys/devices/cpu/caps/branches.");
+            }

So, incase we are in amd machine,  common function evsel__open_strerror
will call function may be something like amd_evesel_open_strerror_check
which will look for both ibs and brs conditions and return corresponding
error statement.

Thanks,
Kajol Jain

> 
> Below is the full proposed replacement patch for patch 12
> of 13 of the BRS series.
> 
> Another option is to have the is_amd_{ibs,brs} functions
> call is_amd() themselves, so the if (evsel->) code could be
> unindented by one tab, would that be better?
> 
> Thanks,
> 
> Kim
> 
> From a4cbab762719b30bddec2e278cf8b8eb82e83865 Mon Sep 17 00:00:00 2001
> From: Stephane Eranian <eranian@google.com>
> Date: Thu, 9 Sep 2021 00:56:59 -0700
> Subject: [PATCH] perf tools: Improve error handling of AMD Branch Sampling
> 
> This patch improves the error message printed by perf when
> perf_event_open() fails on AMD Zen3 when using the branch sampling
> feature. In the case of EINVAL, there are two main reasons: frequency
> mode or period is smaller than the depth of the branch sampling
> buffer (16). The patch checks the parameters of the call and tries
> to print a relevant message to explain the error:
> 
> $ perf record -b -e cpu/branch-brs/ -c 10 ls
> Error:
> AMD Branch Sampling does not support sampling period smaller than what
> is reported in /sys/devices/cpu/caps/branches.
> 
> $ perf record -b -e cpu/branch-brs/ ls
> Error:
> AMD Branch Sampling does not support frequency mode sampling, must pass
> a fixed sampling period via -c option or cpu/branch-brs,period=xxxx/.
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>
> [Rebased on commit 9fe8895a27a84 ("perf env: Add perf_env__cpuid,
> perf_env__{nr_}pmu_mappings")]
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> ---
>  tools/perf/util/evsel.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index f8a9cbd99314..e1f5eff07355 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2753,6 +2753,12 @@ static bool is_amd_ibs(struct evsel *evsel)
>      return evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name,
> "ibs", 3);
>  }
> 
> +static bool is_amd_brs(struct evsel *evsel)
> +{
> +    return ((evsel->core.attr.config & 0xff) == 0xc4) &&
> +           (evsel->core.attr.sample_type & PERF_SAMPLE_BRANCH_STACK);
> +}
> +
>  int evsel__open_strerror(struct evsel *evsel, struct target *target,
>               int err, char *msg, size_t size)
>  {
> @@ -2863,6 +2869,14 @@ int evsel__open_strerror(struct evsel *evsel,
> struct target *target,
>                      return scnprintf(msg, size,
>      "AMD IBS may only be available in system-wide/per-cpu mode.  Try
> using -a, or -C and workload affinity");
>              }
> +            if (is_amd_brs(evsel)) {
> +                if (evsel->core.attr.freq)
> +                    return scnprintf(msg, size,
> +    "AMD Branch Sampling does not support frequency mode sampling, must
> pass a fixed sampling period via -c option or
> cpu/branch-brs,period=xxxx/.");
> +                /* another reason is that the period is too small */
> +                return scnprintf(msg, size,
> +    "AMD Branch Sampling does not support sampling period smaller than
> what is reported in /sys/devices/cpu/caps/branches.");
> +            }
>          }
> 
>          break;
