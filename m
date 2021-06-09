Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A411CC48BCD
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Jun 2021 10:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 851F661375
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Jun 2021 10:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbhFIKbl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 9 Jun 2021 06:31:41 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3183 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbhFIKbl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Jun 2021 06:31:41 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G0NTz46pHz6G7QZ;
        Wed,  9 Jun 2021 18:23:03 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 12:29:44 +0200
Received: from [10.47.80.201] (10.47.80.201) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 9 Jun 2021
 11:29:43 +0100
Subject: Re: perf tool: Issues with metricgroups
To:     Ian Rogers <irogers@google.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
References: <ac8b10b5-820a-9542-51ab-3fcc51cb91ef@huawei.com>
 <CAP-5=fVERioMuK=JgKr1QWXKvU0Y31efQjxh7hX32ifL9V+_EA@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <49c6fccb-b716-1bf0-18a6-cace1cdb66b9@huawei.com>
Date:   Wed, 9 Jun 2021 11:23:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAP-5=fVERioMuK=JgKr1QWXKvU0Y31efQjxh7hX32ifL9V+_EA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.201]
X-ClientProxiedBy: lhreml749-chm.china.huawei.com (10.201.108.199) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 09/06/2021 07:15, Ian Rogers wrote:

Hi Ian,

> The fix to avoid uncore_ events being deduplicated against each other
> added complexity to the code and means that metric-no-group doesn't
> really work any more. I have it on my list of things to look at. It
> relates to what you are looking at as the deduplication afterward is
> tricky given the funny invariants on evsel names. I think it would be
> easier to deduplicate events before doing the event parse. It may also
> be good to change evsels so that they own the string for their name
> (this would mean uncore_imc events could have unique names and not get
> deduplicated against each other). The invariants around cycles in your
> change look weird, but I can see how it might workaround an issue. My
> attempts to reproduce the issue weren't successful on a SkylakeX.

I am a bit surprised that you could not reproduce on SkylakeX, as the 
metric expressions are the same.

As an experiment I hacked the mapfile.csv to make my broadwell machine 
pick up the skylakex pmu-events:

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv 
b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 5f5df6560202..3f170fc430b2 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,6 +1,6 @@
  Family-model,Version,Filename,EventType
  GenuineIntel-6-56,v5,broadwellde,core
-GenuineIntel-6-3D,v17,broadwell,core
+GenuineIntel-6-3D,v17,skylakex,core
  GenuineIntel-6-47,v17,broadwell,core
  GenuineIntel-6-4F,v10,broadwellx,core
  GenuineIntel-6-1C,v4,bonnell,core


And I still see the issue:

john@localhost:~/acme/tools/perf> sudo  ./perf stat -v -M 
retiring,backend_bound sleep 1
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
uops_retired.retire_slots -> cpu/(null)=0x1e8483,umask=0x2,event=0xc2/
uops_issued.any -> cpu/(null)=0x1e8483,umask=0x1,event=0xe/
idq_uops_not_delivered.core -> cpu/(null)=0x1e8483,umask=0x1,event=0x9c/
int_misc.recovery_cycles -> cpu/(null)=0x1e8483,umask=0x1,event=0xd/
uops_retired.retire_slots -> cpu/(null)=0x1e8483,umask=0x2,event=0xc2/
Control descriptor is not initialized
cycles: 1648306 533003 533003
uops_retired.retire_slots: 1309840 533003 533003
uops_issued.any: 0 533003 0
cycles: 0 533003 0
idq_uops_not_delivered.core: 0 533003 0
int_misc.recovery_cycles: 0 533003 0
uops_retired.retire_slots: 0 533003 0

  Performance counter stats for 'sleep 1':

          1,648,306      cycles 

                                                   #     0.20 Retiring 

          1,309,840      uops_retired.retire_slots 

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

        1.000942715 seconds time elapsed

        0.000954000 seconds user
        0.000000000 seconds sys

The events in group usually have to be from the same PMU. Try 
reorganizing the group.
john@localhost:~/acme/tools/perf>

> 
> Thanks for reporting the issues. I planned to look at this logic to
> fix metric-no-group, it'd be nice to land:
> https://lore.kernel.org/lkml/20210112230434.2631593-1-irogers@google.com/
> just so that I'm not making patch sets that conflict with myself.

As I said, one issue is caused by me, and I can send a fix. I need to 
test more, though. And I was holding off until an approach decided for 
2nd issue. Since no resolution yet, I think I'll just send a fix today.

Thanks,
John
