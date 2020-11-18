Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCAEC5519F
	for <linux-perf-users@archiver.kernel.org>; Wed, 18 Nov 2020 11:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9EEE24199
	for <linux-perf-users@archiver.kernel.org>; Wed, 18 Nov 2020 11:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgKRLVz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 18 Nov 2020 06:21:55 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34756 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgKRLVz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 18 Nov 2020 06:21:55 -0500
Received: by mail-qk1-f195.google.com with SMTP id n132so1410626qke.1;
        Wed, 18 Nov 2020 03:21:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ue6h7UrfTqoxTlMyjwQTIShtLqaWRi/0J/fOLIXOaXM=;
        b=A2PtbYglonwLPFesxXBDyCBLcXCneraKCdPUNoilWNzOTyyvcGtm/bH4RDZF4yApFd
         F9iPsfsSK1oFSxke9vuXfMwWb2fo4AXdmfZw/fSzYnf+54ln27qpl8srtQX9qtwTNdkb
         vzBPz1GaJeKkGUa7XQG1AVPCQpW4oEybX0TK1WSWsZAzWgJcPLr57mBSxVVwVKzkrA3o
         RE6vU3frI/3P6i4zq3us1bkzbnAxV+whjc6hWRZkqdPR7E8wpGeiVxLz/tXPEvDJn/em
         SlmbvIGYNtdSKk/qZL8t6S+KHc7yjjZWYltiw7kiUroG6nkI4kz6FSwhx65MUnd6cDGq
         3I6w==
X-Gm-Message-State: AOAM530LaY1z8yHpMn8fqdkAGeZ950hwn09k5yLjMAXOD0MbuL1rzo3q
        PW2k7gRwwCxNTZXEnf+/ObMgiqQjCFT5HSZ8qtK/8Yiv
X-Google-Smtp-Source: ABdhPJzFvf4BA8UuO9eIPHYyF2YFEZwKd9mZInl4BmMFqjDraqOhBdMLaklXb42+gPLuClGm6bsZ3bagsHLD2Vzs+0w=
X-Received: by 2002:a37:7201:: with SMTP id n1mr4002674qkc.148.1605698513321;
 Wed, 18 Nov 2020 03:21:53 -0800 (PST)
MIME-Version: 1.0
References: <20201117144845.13714-1-james.clark@arm.com> <20201117144845.13714-2-james.clark@arm.com>
In-Reply-To: <20201117144845.13714-2-james.clark@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 18 Nov 2020 20:21:40 +0900
Message-ID: <CAM9d7cj6zbsVB_DNmH0R9XqVJfXe9bofMwreH+u-BaDL-xm2_A@mail.gmail.com>
Subject: Re: [PATCH v5 01/12] perf tools: Improve topology test
To:     James Clark <james.clark@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

On Tue, Nov 17, 2020 at 11:49 PM James Clark <james.clark@arm.com> wrote:
>
> Improve the topology test to check all aggregation
> types. This is to lock down the behaviour before
> 'id' is changed into a struct in later commits.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Thomas Richter <tmricht@linux.ibm.com>
> Cc: John Garry <john.garry@huawei.com>
> ---
>  tools/perf/tests/topology.c | 53 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 46 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
> index 22daf2bdf5fa..7bd8848d36b6 100644
> --- a/tools/perf/tests/topology.c
> +++ b/tools/perf/tests/topology.c
> @@ -64,10 +64,11 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
>                 .path = path,
>                 .mode = PERF_DATA_MODE_READ,
>         };
> -       int i;
> +       int i, id;
>
>         session = perf_session__new(&data, false, NULL);
>         TEST_ASSERT_VAL("can't get session", !IS_ERR(session));
> +       cpu__setup_cpunode_map();
>
>         /* On platforms with large numbers of CPUs process_cpu_topology()
>          * might issue an error while reading the perf.data file section
> @@ -85,11 +86,18 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
>          *  "socket_id number is too big. You may need to upgrade the
>          *  perf tool."
>          *
> -        *  This is the reason why this test might be skipped.
> +        *  This is the reason why this test might be skipped. aarch64 and
> +        *  s390 always write this part of the header, even when the above
> +        *  condition is true (see do_core_id_test in header.c). So always
> +        *  run this test on those platforms.
>          */
> -       if (!session->header.env.cpu)
> +       if (!session->header.env.cpu
> +                       && strncmp(session->header.env.arch, "s390", 4)
> +                       && strncmp(session->header.env.arch, "aarch64", 7))
>                 return TEST_SKIP;
>
> +       TEST_ASSERT_VAL("Session header CPU map not set", session->header.env.cpu);
> +
>         for (i = 0; i < session->header.env.nr_cpus_avail; i++) {
>                 if (!cpu_map__has(map, i))
>                         continue;
> @@ -98,14 +106,45 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
>                          session->header.env.cpu[i].socket_id);
>         }
>
> +       // Test that core ID contains socket, die and core
> +       for (i = 0; i < map->nr; i++) {
> +               id = cpu_map__get_core(map, i, NULL);
> +               TEST_ASSERT_VAL("Core map - Core ID doesn't match",
> +                       session->header.env.cpu[map->map[i]].core_id == cpu_map__id_to_cpu(id));
> +
> +               TEST_ASSERT_VAL("Core map - Socket ID doesn't match",
> +                       session->header.env.cpu[map->map[i]].socket_id ==
> +                               cpu_map__id_to_socket(id));
> +
> +               TEST_ASSERT_VAL("Core map - Die ID doesn't match",
> +                       session->header.env.cpu[map->map[i]].die_id == cpu_map__id_to_die(id));
> +       }
> +
> +       // Test that die ID contains socket and die
>         for (i = 0; i < map->nr; i++) {
> -               TEST_ASSERT_VAL("Core ID doesn't match",
> -                       (session->header.env.cpu[map->map[i]].core_id == (cpu_map__get_core(map, i, NULL) & 0xffff)));
> +               id = cpu_map__get_die(map, i, NULL);
> +               TEST_ASSERT_VAL("Die map - Socket ID doesn't match",
> +                       session->header.env.cpu[map->map[i]].socket_id ==
> +                               cpu_map__id_to_socket(id));

I'm not sure it works.  It seems cpu_map__get_die() returns
16 bit id (socket | die) but cpu_map__id_to_socket() takes
32 bit id (socket | die | core), right?

>
> -               TEST_ASSERT_VAL("Socket ID doesn't match",
> -                       (session->header.env.cpu[map->map[i]].socket_id == cpu_map__get_socket(map, i, NULL)));
> +               TEST_ASSERT_VAL("Die map - Die ID doesn't match",
> +                       session->header.env.cpu[map->map[i]].die_id == cpu_map__id_to_die(id));
>         }
>
> +       // Test that socket ID contains only socket
> +       for (i = 0; i < map->nr; i++) {
> +               id = cpu_map__get_socket(map, i, NULL);
> +               TEST_ASSERT_VAL("Socket map - Socket ID doesn't match",
> +                       session->header.env.cpu[map->map[i]].socket_id ==
> +                               cpu_map__id_to_socket(id));

Same here.

Thanks,
Namhyung


> +       }
> +
> +       // Test that node ID contains only node
> +       for (i = 0; i < map->nr; i++) {
> +               id = cpu_map__get_node(map, i, NULL);
> +               TEST_ASSERT_VAL("Node map - Node ID doesn't match",
> +                       cpu__get_node(map->map[i]) == id);
> +       }
>         perf_session__delete(session);
>
>         return 0;
> --
> 2.28.0
>
