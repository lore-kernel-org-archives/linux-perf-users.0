Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBD32C9E
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Oct 2023 05:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616DA9E
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Oct 2023 22:23:21 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-57b68556d6dso2426125eaf.1
        for <linux-perf-users@vger.kernel.org>; Sun, 08 Oct 2023 22:23:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696829000; x=1697433800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yc1A5pV3IcR5n9tmheP3/ndlCJ3/SLMW9xZgGA9260E=;
        b=taDsSucZ0xK+9lM9bNZttSOkJt828yJJpNLSLnhPsY/W105Rq1Xyf/TSqSMOYytk+4
         yLbxFyv85r4UQkSffySY3iU6QFVsrt4x8YLYkSduF7yE/bvEOXcVhFrvAxR3Ku3tbbmp
         Ge98CZHBoYg4L7eIqj8qy9OD6j2dJquetlcorOpg+anyuTfabNohBiPC1JhPURXgHMyC
         HOLiOU5LeS4kbcCImU3iMvXh8i8ksPTCgj1HQHtlm7T0Mw+kWNNp0gVkmgQxCuFA2RhD
         OXbYSuJMOZUSlL9Vx8W3/U1l9vCYXirP0yQw3wTD+bUf21u0BikWN5GrXxj9yu6D8F0V
         g0yg==
X-Gm-Message-State: AOJu0YwFYrVHR9q8nOwdIUGPzK5J2suMOzBjz0EXIvzQMXUb/lqkBB4J
	jkXGoCrSMeteSRsxezFv4OIt25mcaHpSyM0SMh1vIyFE
X-Google-Smtp-Source: AGHT+IGix6KwyHY77vP9m/WhG+NIg/zIw8wbhg11f29AK31K4JiUBRexwsDi3nWrrUuAn90DRwJ422hwOFlsNGMGc+M=
X-Received: by 2002:a05:6358:4415:b0:135:6d9:2399 with SMTP id
 z21-20020a056358441500b0013506d92399mr12724287rwc.30.1696828999211; Sun, 08
 Oct 2023 22:23:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231003092113.252380-1-kjain@linux.ibm.com> <40b804b8-1052-8646-34b9-d57ecf0a2bf5@linux.ibm.com>
In-Reply-To: <40b804b8-1052-8646-34b9-d57ecf0a2bf5@linux.ibm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Sun, 8 Oct 2023 22:23:08 -0700
Message-ID: <CAM9d7cgbvaR0WtO8fuvhCOjc2-m6ca2RZW5U0DFaM=7s7=Zh7A@mail.gmail.com>
Subject: Re: [PATCH] tools/perf: Update call stack check in builtin-lock.c
To: Disha Goel <disgoel@linux.ibm.com>
Cc: Kajol Jain <kjain@linux.ibm.com>, acme@kernel.org, maddy@linux.ibm.com, 
	atrajeev@linux.vnet.ibm.com, linux-perf-users@vger.kernel.org, 
	Disha Goel <disgoel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 4, 2023 at 5:07=E2=80=AFAM Disha Goel <disgoel@linux.ibm.com> w=
rote:
>
> On 03/10/23 2:51 pm, Kajol Jain wrote:
>
> The perf test named "kernel lock contention analysis test"
> fails in powerpc system with below error:
>
> [command]# ./perf test 81 -vv
>  81: kernel lock contention analysis test                            :
>  --- start ---
> test child forked, pid 2140
> Testing perf lock record and perf lock contention
> Testing perf lock contention --use-bpf
> [Skip] No BPF support
> Testing perf lock record and perf lock contention at the same time
> Testing perf lock contention --threads
> Testing perf lock contention --lock-addr
> Testing perf lock contention --type-filter (w/ spinlock)
> Testing perf lock contention --lock-filter (w/ tasklist_lock)
> Testing perf lock contention --callstack-filter (w/ unix_stream)
> [Fail] Recorded result should have a lock from unix_stream:
> test child finished with -1
>  ---- end ----
> kernel lock contention analysis test: FAILED!
>
> The test is failing because we get an address entry with 0 in
> perf lock samples for powerpc, and code for lock contention
> option "--callstack-filter" will not check further entries after
> address 0.
>
> Below are some of the samples from test generated perf.data file, which
> have 0 address in the 2nd entry of callstack:
>  --------
> sched-messaging    3409 [001]  7152.904029: lock:contention_begin: 0xc000=
00c80904ef00 (flags=3DSPIN)
>         c0000000001e926c __traceiter_contention_begin+0x6c ([kernel.kalls=
yms])
>                        0 [unknown] ([unknown])
>         c000000000f8a178 native_queued_spin_lock_slowpath+0x1f8 ([kernel.=
kallsyms])
>         c000000000f89f44 _raw_spin_lock_irqsave+0x84 ([kernel.kallsyms])
>         c0000000001d9fd0 prepare_to_wait+0x50 ([kernel.kallsyms])
>         c000000000c80f50 sock_alloc_send_pskb+0x1b0 ([kernel.kallsyms])
>         c000000000e82298 unix_stream_sendmsg+0x2b8 ([kernel.kallsyms])
>         c000000000c78980 sock_sendmsg+0x80 ([kernel.kallsyms])
>
> sched-messaging    3408 [005]  7152.904036: lock:contention_begin: 0xc000=
00c80904ef00 (flags=3DSPIN)
>         c0000000001e926c __traceiter_contention_begin+0x6c ([kernel.kalls=
yms])
>                        0 [unknown] ([unknown])
>         c000000000f8a178 native_queued_spin_lock_slowpath+0x1f8 ([kernel.=
kallsyms])
>         c000000000f89f44 _raw_spin_lock_irqsave+0x84 ([kernel.kallsyms])
>         c0000000001d9fd0 prepare_to_wait+0x50 ([kernel.kallsyms])
>         c000000000c80f50 sock_alloc_send_pskb+0x1b0 ([kernel.kallsyms])
>         c000000000e82298 unix_stream_sendmsg+0x2b8 ([kernel.kallsyms])
>         c000000000c78980 sock_sendmsg+0x80 ([kernel.kallsyms])
>  --------
>
> Based on commit 20002ded4d93 ("perf_counter: powerpc: Add callchain suppo=
rt"),
> incase of powerpc, the callchain saved by kernel always includes first
> three entries as the NIP (next instruction pointer), LR (link register), =
and
> the contents of LR save area in the second stack frame. In certain scenar=
ios
> its possible to have invalid kernel instruction addresses in either of LR=
 or the
> second stack frame's LR. In that case, kernel will store the address as z=
er0.
> Hence, its possible to have 2nd or 3rd callstack entry as 0.
>
> As per the current code in match_callstack_filter function, we skip the c=
allstack
> check incase we get 0 address. And hence the test case is failing in powe=
rpc.
>
> Fix this issue by updating the check in match_callstack_filter function,
> to not skip callstack check if the 2nd or 3rd entry have 0 address
> for powerpc.
>
> Result in powerpc after patch changes:
>
> [command]# ./perf test 81 -vv
>  81: kernel lock contention analysis test                            :
>  --- start ---
> test child forked, pid 4570
> Testing perf lock record and perf lock contention
> Testing perf lock contention --use-bpf
> [Skip] No BPF support
> Testing perf lock record and perf lock contention at the same time
> Testing perf lock contention --threads
> Testing perf lock contention --lock-addr
> Testing perf lock contention --type-filter (w/ spinlock)
> Testing perf lock contention --lock-filter (w/ tasklist_lock)
> [Skip] Could not find 'tasklist_lock'
> Testing perf lock contention --callstack-filter (w/ unix_stream)
> Testing perf lock contention --callstack-filter with task aggregation
> Testing perf lock contention CSV output
> [Skip] No BPF support
> test child finished with 0
>  ---- end ----
> kernel lock contention analysis test: Ok
>
> Fixes: ebab291641be ("perf lock contention: Support filters for different=
 aggregation")
> Reported-by: Disha Goel <disgoel@linux.vnet.ibm.com>
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>
> Thanks for the fix patch.
> Tested the patch on power, kernel lock contention analysis test passed wi=
th the patch changes.
>
> # ./perf test -vv 79
>  79: kernel lock contention analysis test                            :
> --- start ---
> test child forked, pid 28530
> Testing perf lock record and perf lock contention
> Testing perf lock contention --use-bpf
> [Skip] No BPF support
> Testing perf lock record and perf lock contention at the same time
> Testing perf lock contention --threads
> Testing perf lock contention --lock-addr
> Testing perf lock contention --type-filter (w/ spinlock)
> Testing perf lock contention --lock-filter (w/ tasklist_lock)
> Testing perf lock contention --callstack-filter (w/ unix_stream)
> Testing perf lock contention --callstack-filter with task aggregation
> Testing perf lock contention CSV output
> [Skip] No BPF support
> test child finished with 0
> ---- end ----
> kernel lock contention analysis test: Ok
>
> Tested-by: Disha Goel <disgoel@linux.ibm.com>

Applied to perf-tools-next, thanks!
