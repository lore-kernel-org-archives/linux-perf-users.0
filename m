Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97760C2D0E4
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Nov 2020 14:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 436F42168B
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 Nov 2020 14:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbgKQOxH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 Nov 2020 09:53:07 -0500
Received: from foss.arm.com ([217.140.110.172]:59508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728718AbgKQOxH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 Nov 2020 09:53:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 909DB30E;
        Tue, 17 Nov 2020 06:53:06 -0800 (PST)
Received: from [10.57.59.185] (unknown [10.57.59.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 164713F718;
        Tue, 17 Nov 2020 06:53:04 -0800 (PST)
Subject: Re: [PATCH 13/13 v4] perf tools: add thread field
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
References: <20201113172654.989-1-james.clark@arm.com>
 <20201113172654.989-14-james.clark@arm.com> <20201115211714.GA1081385@krava>
From:   James Clark <james.clark@arm.com>
Message-ID: <c8673aed-4cf6-780b-de96-e6d8987fc3a1@arm.com>
Date:   Tue, 17 Nov 2020 16:53:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201115211714.GA1081385@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 15/11/2020 23:17, Jiri Olsa wrote:
> On Fri, Nov 13, 2020 at 07:26:54PM +0200, James Clark wrote:
>> A separate field isn't strictly required. The core
>> field could be re-used for thread IDs as a single
>> field was used previously.
>>
>> But separating them will avoid confusion and catch
>> potential errors where core IDs are read as thread
>> IDs and vice versa.
>>
>> Also remove the placeholder id field which is now
>> no longer used.
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
>>  tools/perf/tests/topology.c    |  8 ++++----
>>  tools/perf/util/cpumap.c       | 14 +++++++-------
>>  tools/perf/util/cpumap.h       |  2 +-
>>  tools/perf/util/stat-display.c |  8 ++++----
>>  4 files changed, 16 insertions(+), 16 deletions(-)
>>
>> diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
>> index 694f786a77f3..2276db0b1b6f 100644
>> --- a/tools/perf/tests/topology.c
>> +++ b/tools/perf/tests/topology.c
>> @@ -119,7 +119,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
>>  		TEST_ASSERT_VAL("Core map - Die ID doesn't match",
>>  			session->header.env.cpu[map->map[i]].die_id == id.die);
>>  		TEST_ASSERT_VAL("Core map - Node ID is set", id.node == -1);
>> -		TEST_ASSERT_VAL("Core map - ID is set", id.id == -1);
>> +		TEST_ASSERT_VAL("Core map - Thread is set", id.thread == -1);
>>  	}
>>  
>>  	// Test that die ID contains socket and die
>> @@ -131,7 +131,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
>>  		TEST_ASSERT_VAL("Die map - Die ID doesn't match",
>>  			session->header.env.cpu[map->map[i]].die_id == id.die);
>>  		TEST_ASSERT_VAL("Die map - Node ID is set", id.node == -1);
>> -		TEST_ASSERT_VAL("Die map - ID is set", id.id == -1);
>> +		TEST_ASSERT_VAL("Die map - Thread is set", id.thread == -1);
>>  	}
>>  
>>  	// Test that socket ID contains only socket
>> @@ -141,7 +141,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
>>  			session->header.env.cpu[map->map[i]].socket_id == id.socket);
>>  		TEST_ASSERT_VAL("Socket map - Node ID is set", id.node == -1);
>>  		TEST_ASSERT_VAL("Socket map - Die ID is set", id.die == -1);
>> -		TEST_ASSERT_VAL("Socket map - ID is set", id.id == -1);
>> +		TEST_ASSERT_VAL("Socket map - Thread is set", id.thread == -1);
>>  	}
>>  
>>  	// Test that node ID contains only node
>> @@ -149,7 +149,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
>>  		id = cpu_map__get_node(map, i, NULL);
>>  		TEST_ASSERT_VAL("Node map - Node ID doesn't match",
>>  			cpu__get_node(map->map[i]) == id.node);
>> -		TEST_ASSERT_VAL("Node map - ID shouldn't be set", id.id == -1);
>> +		TEST_ASSERT_VAL("Node map - Thread shouldn't be set", id.thread == -1);
>>  		TEST_ASSERT_VAL("Node map - Die ID is set", id.die == -1);
>>  	}
> 
> should we test all unset parts are -1, like here id.core,
> id.socket and there are missing tests also in above code

Yes I think that's a good idea. I added all the missing ones in V5.

Thanks for the review.

James

> 
> jirka
> 
