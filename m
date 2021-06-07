Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2871DC47082
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Jun 2021 17:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02C036102A
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Jun 2021 17:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhFGRXo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 7 Jun 2021 13:23:44 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3164 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbhFGRXo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 7 Jun 2021 13:23:44 -0400
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FzKbV20mjz6G7jF;
        Tue,  8 Jun 2021 01:09:10 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 19:21:51 +0200
Received: from [10.47.88.167] (10.47.88.167) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 7 Jun 2021
 18:21:50 +0100
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        "irogers@google.com" <irogers@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Subject: perf tool: Issues with metricgroups
Message-ID: <ac8b10b5-820a-9542-51ab-3fcc51cb91ef@huawei.com>
Date:   Mon, 7 Jun 2021 18:21:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.88.167]
X-ClientProxiedBy: lhreml738-chm.china.huawei.com (10.201.108.188) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi guys,

I am finding a couple of issues in metricgroup support. Firstly I have 
found a segfault (which I caused with my "fix" in commit 9c880c24cb0d), 
and a fix for that is at the bottom.

Another issue is that the ordering of the metrics we supply for stat 
command causes an issue.

On my broadwell, this works ok:

sudo  ./perf stat -vv -M backend_bound,retiring sleep 1
Using CPUID GenuineIntel-6-3D-4
metric expr 1 - ( (idq_uops_not_delivered.core / (4 * cycles)) + (( 
uops_issued.any - uops_retired.retire_slots + 4 * 
int_misc.recovery_cycles ) / (4 * cycles)) + (uops_retired.retire_slots 
/ (4 * cycles)) ) for Backend_Bound
found event uops_issued.any
found event cycles
found event idq_uops_not_delivered.core
found event int_misc.recovery_cycles
found event uops_retired.retire_slots
metric expr uops_retired.retire_slots / (4 * cycles) for Retiring
found event cycles
found event uops_retired.retire_slots
adding 
{uops_issued.any,cycles,idq_uops_not_delivered.core,int_misc.recovery_cycles,uops_retired.retire_slots}:W,{cycles,uops_retired.retire_slots}:W
uops_issued.any -> cpu/umask=0x1,(null)=0x1e8483,event=0xe/
idq_uops_not_delivered.core -> cpu/umask=0x1,(null)=0x1e8483,event=0x9c/
int_misc.recovery_cycles -> 
cpu/umask=0x3,(null)=0x1e8483,cmask=0x1,event=0xd/
uops_retired.retire_slots -> cpu/umask=0x2,(null)=0x1e8483,event=0xc2/
uops_retired.retire_slots -> cpu/umask=0x2,(null)=0x1e8483,event=0xc2/
Control descriptor is not initialized
uops_issued.any: 1655376 547221 547221
cycles: 1665343 547221 547221
idq_uops_not_delivered.core: 1983394 547221 547221
int_misc.recovery_cycles: 69571 547221 547221
uops_retired.retire_slots: 1311124 547221 547221

  Performance counter stats for 'sleep 1':

          1,655,376      uops_issued.any           #     0.41 
Backend_Bound
          1,665,343      cycles 

                                                   #     0.20 Retiring 

          1,983,394      idq_uops_not_delivered.core 

             69,571      int_misc.recovery_cycles 

          1,311,124      uops_retired.retire_slots 


        1.000992470 seconds time elapsed

        0.001031000 seconds user
        0.000000000 seconds sys
----/---

But when I reorder the metrics, it fails:

  sudo  ./perf stat -v -M retiring,backend_bound sleep 1
Using CPUID GenuineIntel-6-3D-4
metric expr uops_retired.retire_slots / (4 * cycles) for Retiring
found event cycles
found event uops_retired.retire_slots
metric expr 1 - ( (idq_uops_not_delivered.core / (4 * cycles)) + (( 
uops_issued.any - uops_retired.retire_slots + 4 * 
int_misc.recovery_cycles ) / (4 * cycles)) + (uops_retired.retire_slots 
/ (4 * cycles)) ) for Backend_Bound
found event uops_issued.any
found event cycles
found event idq_uops_not_delivered.core
found event int_misc.recovery_cycles
found event uops_retired.retire_slots
adding 
{cycles,uops_retired.retire_slots}:W,{uops_issued.any,cycles,idq_uops_not_delivered.core,int_misc.recovery_cycles,uops_retired.retire_slots}:W
uops_retired.retire_slots -> cpu/umask=0x2,(null)=0x1e8483,event=0xc2/
uops_issued.any -> cpu/umask=0x1,(null)=0x1e8483,event=0xe/
idq_uops_not_delivered.core -> cpu/umask=0x1,(null)=0x1e8483,event=0x9c/
int_misc.recovery_cycles -> 
cpu/umask=0x3,(null)=0x1e8483,cmask=0x1,event=0xd/
uops_retired.retire_slots -> cpu/umask=0x2,(null)=0x1e8483,event=0xc2/
Control descriptor is not initialized
cycles: 1695223 563189 563189
uops_retired.retire_slots: 1343463 563189 563189
uops_issued.any: 0 563189 0
cycles: 0 563189 0
idq_uops_not_delivered.core: 0 563189 0
int_misc.recovery_cycles: 0 563189 0
uops_retired.retire_slots: 0 563189 0

  Performance counter stats for 'sleep 1':

          1,695,223      cycles 

                                                   #     0.20 Retiring 

          1,343,463      uops_retired.retire_slots 

      <not counted>      uops_issued.any 
               (0.00%)
      <not counted>      cycles 
               (0.00%)
      <not counted>      idq_uops_not_delivered.core 
                 (0.00%)
      <not counted>      int_misc.recovery_cycles 
               (0.00%)
      <not counted>      uops_retired.retire_slots 
               (0.00%)

        1.000980001 seconds time elapsed

        0.001028000 seconds user
        0.000000000 seconds sys

----/---

I think that it may be related to changes when introducing hashmap for 
evsel (that's before I started fiddling with metricgroups). 
Specifically, it looks to be in metricgroup__setup_events() -> 
find_evsel_group(). We seem to be enabling wrong evsels.

I'll continue to look at this, but any help would be appreciated.

Thanks,
John

perf metricgroup: Fix find_evsel_group()

The following command segfaults on my x86 broadwell:

$ ./perf stat  -M frontend_bound,retiring,backend_bound,bad_speculation 
sleep 1
     WARNING: grouped events cpus do not match, disabling group:
       anon group { raw 0x10e }
       anon group { raw 0x10e }
perf: util/evsel.c:1596: get_group_fd: Assertion `!(!leader->core.fd)' 
failed.
Aborted (core dumped)

The issue shows itself as a use-after-free in evlist__check_cpu_maps(),
whereby the leader of an event selector (evsel) has been deleted (yet we
still attempt to verify for an evsel).

Fundamentally the problem comes from metricgroup__setup_events() ->
find_evsel_group(), and has developed from the previous fix attempt in
commit 9c880c24cb0d ("perf metricgroup: Fix for metrics containing
duration_time").

The problem now is that the logic in checking if an evsel is in the same
group is subtly broken for "cycles" event. For "cycles" event, the
pmu_name is NULL; however the logic in find_evsel_group() may set an 
event matched against "cycles" as used, when it should not be.

This leads to a condition where an evsel is set, yet its leader is not.

Fix the check for evsel pmu_name by not matching evsels when either has 
a NULL pmu_name.

Fixes: 9c880c24cb0d ("perf metricgroup: Fix for metrics containing 
duration_time")
Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 8336dd8e8098..c456fdeae06a 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -162,10 +162,10 @@ static bool contains_event(struct evsel 
**metric_events, int num_events,
         return false;
  }

-static bool evsel_same_pmu(struct evsel *ev1, struct evsel *ev2)
+static bool evsel_same_pmu_or_none(struct evsel *ev1, struct evsel *ev2)
  {
         if (!ev1->pmu_name || !ev2->pmu_name)
-               return false;
+               return true;

         return !strcmp(ev1->pmu_name, ev2->pmu_name);
  }
@@ -288,7 +288,7 @@ static struct evsel *find_evsel_group(struct evlist 
*perf_evlist,
                          */
                         if (!has_constraint &&
                             ev->leader != metric_events[i]->leader &&
-                           evsel_same_pmu(ev->leader, 
metric_events[i]->leader))
+                           evsel_same_pmu_or_none(ev->leader, 
metric_events[i]->leader))
                                 break;
                         if (!strcmp(metric_events[i]->name, ev->name)) {
                                 set_bit(ev->idx, evlist_used);
lines 25-63/63 (END)


