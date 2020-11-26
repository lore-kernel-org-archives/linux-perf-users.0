Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8583C63697
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Nov 2020 13:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9142B20644
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Nov 2020 13:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390810AbgKZNqj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 26 Nov 2020 08:46:39 -0500
Received: from foss.arm.com ([217.140.110.172]:33426 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390637AbgKZNqj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 Nov 2020 08:46:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CFB931B;
        Thu, 26 Nov 2020 05:46:38 -0800 (PST)
Received: from [10.57.53.242] (unknown [10.57.53.242])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4B1A3F71F;
        Thu, 26 Nov 2020 05:46:36 -0800 (PST)
Subject: Re: [PATCH v5 01/12] perf tools: Improve topology test
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
References: <20201117144845.13714-1-james.clark@arm.com>
 <20201117144845.13714-2-james.clark@arm.com>
 <CAM9d7cj6zbsVB_DNmH0R9XqVJfXe9bofMwreH+u-BaDL-xm2_A@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <d1742147-eebd-a03d-6f09-174448e0d02d@arm.com>
Date:   Thu, 26 Nov 2020 15:46:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAM9d7cj6zbsVB_DNmH0R9XqVJfXe9bofMwreH+u-BaDL-xm2_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 18/11/2020 13:21, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Nov 17, 2020 at 11:49 PM James Clark <james.clark@arm.com> wrote:
>>
>> Improve the topology test to check all aggregation
>> types. This is to lock down the behaviour before
>> 'id' is changed into a struct in later commits.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Jiri Olsa <jolsa@redhat.com>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: Thomas Richter <tmricht@linux.ibm.com>
>> Cc: John Garry <john.garry@huawei.com>
>> ---
>>  tools/perf/tests/topology.c | 53 ++++++++++++++++++++++++++++++++-----
>>  1 file changed, 46 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
>> index 22daf2bdf5fa..7bd8848d36b6 100644
>> --- a/tools/perf/tests/topology.c
>> +++ b/tools/perf/tests/topology.c
>> @@ -64,10 +64,11 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
>>                 .path = path,
>>                 .mode = PERF_DATA_MODE_READ,
>>         };
>> -       int i;
>> +       int i, id;
>>
>>         session = perf_session__new(&data, false, NULL);
>>         TEST_ASSERT_VAL("can't get session", !IS_ERR(session));
>> +       cpu__setup_cpunode_map();
>>
>>         /* On platforms with large numbers of CPUs process_cpu_topology()
>>          * might issue an error while reading the perf.data file section
>> @@ -85,11 +86,18 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
>>          *  "socket_id number is too big. You may need to upgrade the
>>          *  perf tool."
>>          *
>> -        *  This is the reason why this test might be skipped.
>> +        *  This is the reason why this test might be skipped. aarch64 and
>> +        *  s390 always write this part of the header, even when the above
>> +        *  condition is true (see do_core_id_test in header.c). So always
>> +        *  run this test on those platforms.
>>          */
>> -       if (!session->header.env.cpu)
>> +       if (!session->header.env.cpu
>> +                       && strncmp(session->header.env.arch, "s390", 4)
>> +                       && strncmp(session->header.env.arch, "aarch64", 7))
>>                 return TEST_SKIP;
>>
>> +       TEST_ASSERT_VAL("Session header CPU map not set", session->header.env.cpu);
>> +
>>         for (i = 0; i < session->header.env.nr_cpus_avail; i++) {
>>                 if (!cpu_map__has(map, i))
>>                         continue;
>> @@ -98,14 +106,45 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
>>                          session->header.env.cpu[i].socket_id);
>>         }
>>
>> +       // Test that core ID contains socket, die and core
>> +       for (i = 0; i < map->nr; i++) {
>> +               id = cpu_map__get_core(map, i, NULL);
>> +               TEST_ASSERT_VAL("Core map - Core ID doesn't match",
>> +                       session->header.env.cpu[map->map[i]].core_id == cpu_map__id_to_cpu(id));
>> +
>> +               TEST_ASSERT_VAL("Core map - Socket ID doesn't match",
>> +                       session->header.env.cpu[map->map[i]].socket_id ==
>> +                               cpu_map__id_to_socket(id));
>> +
>> +               TEST_ASSERT_VAL("Core map - Die ID doesn't match",
>> +                       session->header.env.cpu[map->map[i]].die_id == cpu_map__id_to_die(id));
>> +       }
>> +
>> +       // Test that die ID contains socket and die
>>         for (i = 0; i < map->nr; i++) {
>> -               TEST_ASSERT_VAL("Core ID doesn't match",
>> -                       (session->header.env.cpu[map->map[i]].core_id == (cpu_map__get_core(map, i, NULL) & 0xffff)));
>> +               id = cpu_map__get_die(map, i, NULL);
>> +               TEST_ASSERT_VAL("Die map - Socket ID doesn't match",
>> +                       session->header.env.cpu[map->map[i]].socket_id ==
>> +                               cpu_map__id_to_socket(id));
> 
> I'm not sure it works.  It seems cpu_map__get_die() returns
> 16 bit id (socket | die) but cpu_map__id_to_socket() takes
> 32 bit id (socket | die | core), right?

Hi Namhyung,

Yes you are right. I assumed the cpu_map__id_to_...() etc functions applied in all cases. Actually
they only work in the per core aggregation mode. In stat-display.c the id is shifted when in die
mode to account for this:

  	case AGGR_DIE:
		fprintf(config->output, "S%d-D%*d%s%*d%s",
			cpu_map__id_to_socket(id << 16),
			config->csv_output ? 0 : -8,
			cpu_map__id_to_die(id << 16),

I've updated the test to match this in patchset v6. When running the test on a multi socket machine it did fail,
but now it passes. The reason I didn't see the issue is because I only tested the last patchset in the
series which doesn't have this issue.


Thanks
James

> 
>>
>> -               TEST_ASSERT_VAL("Socket ID doesn't match",
>> -                       (session->header.env.cpu[map->map[i]].socket_id == cpu_map__get_socket(map, i, NULL)));
>> +               TEST_ASSERT_VAL("Die map - Die ID doesn't match",
>> +                       session->header.env.cpu[map->map[i]].die_id == cpu_map__id_to_die(id));
>>         }
>>
>> +       // Test that socket ID contains only socket
>> +       for (i = 0; i < map->nr; i++) {
>> +               id = cpu_map__get_socket(map, i, NULL);
>> +               TEST_ASSERT_VAL("Socket map - Socket ID doesn't match",
>> +                       session->header.env.cpu[map->map[i]].socket_id ==
>> +                               cpu_map__id_to_socket(id));
> 
> Same here.
> 
> Thanks,
> Namhyung
> 
> 
>> +       }
>> +
>> +       // Test that node ID contains only node
>> +       for (i = 0; i < map->nr; i++) {
>> +               id = cpu_map__get_node(map, i, NULL);
>> +               TEST_ASSERT_VAL("Node map - Node ID doesn't match",
>> +                       cpu__get_node(map->map[i]) == id);
>> +       }
>>         perf_session__delete(session);
>>
>>         return 0;
>> --
>> 2.28.0
>>
