Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6CDC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Sep 2021 14:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E444161038
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Sep 2021 14:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346951AbhIXPBJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 24 Sep 2021 11:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346950AbhIXPBI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 24 Sep 2021 11:01:08 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C25C061613
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Sep 2021 07:59:35 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d6so28250000wrc.11
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Sep 2021 07:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LuJBJddAbNmI++eqx+rjg/yRDsYkwL6jnpDKYkeFYQk=;
        b=CRtNoN3F9yQf8P31py3o8RdW69qM6AYe1hmWWxu2ziqEFV3bSmn9GQE8WyMpEkNaV0
         arJqtADkaV8opursy9m6GaTULx46Jk/8wOVEqL/XwEgwBUAS+JR+C2V1rcX6JANfJ7ui
         7taWjuxVHAt/jTaXt5t7RqJby8goAgbfnZZ8sJvD7koeE5GpGv+o+xB7aGB/BJ3EeORR
         JOsqzXs/+TD1rKLfM1/fRTk5byVkBz/kO1Qpq8/aYuCePNnFC7X0XehCivodveHVklzl
         jmW2+FkFnuOEO5DYT+hejD6plBhWvKvVmqUPawg7oMj5bTJ2JLxGdMikCZmrrREh37x8
         xf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LuJBJddAbNmI++eqx+rjg/yRDsYkwL6jnpDKYkeFYQk=;
        b=Ho3o74doFqcX9xQ4uCe+xpFiTrlQ7BHYOzK5pHmL1rGo98IlO/x0Hq6Q04aPfb2p8h
         BiTAWGKH+lwU1nj4r6wMtHW5DNcDg/eByrG9PQQIbsIdu8pTayKB0O3F+8Qjw3LD+wdV
         +ZkX8O+lGxPRAQ481Vob8Q+++qAVtttP8KpbZT/9luGWXGQezmBBHZBNz/yTkXoonTgK
         6kNgotrT9q42aWz18KVQpNnsWH7FidzQC2T5DFTxRRqUkS+HAwFGIKdGqWjViEIMIcDd
         25FTNMwNDUBk7fzum0akd12TjO3C7RGj/HbK7WwtlKIP0BLTYvje1rddYyo99dXh7zB0
         Mv9A==
X-Gm-Message-State: AOAM531kxVuu8Fi6fNfKCwckwUP+cZdYDdGFxSPG6lmVQJOeQaF34n6z
        pLPWT1yxGMH0n/6Rr5CkDISzdz3Jj00gYeOKBIHApQ==
X-Google-Smtp-Source: ABdhPJwuGY4dWUl219fyh5OMhkdCHYPnpzIDQ3h6By5bCR0ni86V8KhIr2tRhX1KntE6hLZKM+CMKRsdmuE+L39Zoc0=
X-Received: by 2002:a5d:4b11:: with SMTP id v17mr1370065wrq.313.1632495573228;
 Fri, 24 Sep 2021 07:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210924081942.38368-1-likexu@tencent.com>
In-Reply-To: <20210924081942.38368-1-likexu@tencent.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 24 Sep 2021 07:59:19 -0700
Message-ID: <CAP-5=fUuDkntXse1XDksOSij2MO7-rtMg3TfR=N+eHMu0kMTnA@mail.gmail.com>
Subject: Re: [PATCH] perf doc: Fix typos all over the place
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Sep 24, 2021 at 1:20 AM Like Xu <like.xu.linux@gmail.com> wrote:
>
> From: Like Xu <likexu@tencent.com>
>
> Considering that perf and its subcommands have so many parameters,
> the documentation is always the first stop for perf beginners. Fixing
> some spelling errors will relax the eyes of some readers a little bit.
>
>  s/specicfication/specification/
>  s/caheline/cacheline/
>  s/tranasaction/transaction/
>  s/complan/complain/
>  s/sched_wakep/sched_wakeup/
>  s/possble/possible/
>  s/methology/methodology/
>
> Signed-off-by: Like Xu <likexu@tencent.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Documentation/jitdump-specification.txt | 2 +-
>  tools/perf/Documentation/perf-c2c.txt              | 2 +-
>  tools/perf/Documentation/perf-intel-pt.txt         | 2 +-
>  tools/perf/Documentation/perf-lock.txt             | 2 +-
>  tools/perf/Documentation/perf-script-perl.txt      | 2 +-
>  tools/perf/Documentation/perf-script-python.txt    | 2 +-
>  tools/perf/Documentation/perf-stat.txt             | 2 +-
>  tools/perf/Documentation/topdown.txt               | 2 +-
>  8 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/Documentation/jitdump-specification.txt b/tools/p=
erf/Documentation/jitdump-specification.txt
> index 52152d156ad9..79936355d819 100644
> --- a/tools/perf/Documentation/jitdump-specification.txt
> +++ b/tools/perf/Documentation/jitdump-specification.txt
> @@ -164,7 +164,7 @@ const char unwinding_data[n]: an array of unwinding d=
ata, consisting of the EH F
>  The EH Frame header follows the Linux Standard Base (LSB) specification =
as described in the document at https://refspecs.linuxfoundation.org/LSB_1.=
3.0/gLSB/gLSB/ehframehdr.html
>
>
> -The EH Frame follows the LSB specicfication as described in the document=
 at https://refspecs.linuxbase.org/LSB_3.0.0/LSB-PDA/LSB-PDA/ehframechpt.ht=
ml
> +The EH Frame follows the LSB specification as described in the document =
at https://refspecs.linuxbase.org/LSB_3.0.0/LSB-PDA/LSB-PDA/ehframechpt.htm=
l
>
>
>  NOTE: The mapped_size is generally either the same as unwind_data_size (=
if the unwinding data was mapped in memory by the running process) or zero =
(if the unwinding data is not mapped by the process). If the unwinding data=
 was not mapped, then only the EH Frame Header will be read, which can be u=
sed to specify FP based unwinding for a function which does not have unwind=
ing information.
> diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documenta=
tion/perf-c2c.txt
> index de6beedb7283..3b6a2c84ea02 100644
> --- a/tools/perf/Documentation/perf-c2c.txt
> +++ b/tools/perf/Documentation/perf-c2c.txt
> @@ -261,7 +261,7 @@ COALESCE
>  User can specify how to sort offsets for cacheline.
>
>  Following fields are available and governs the final
> -output fields set for caheline offsets output:
> +output fields set for cacheline offsets output:
>
>    tid   - coalesced by process TIDs
>    pid   - coalesced by process PIDs
> diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Docu=
mentation/perf-intel-pt.txt
> index 184ba62420f0..db465fa7ee91 100644
> --- a/tools/perf/Documentation/perf-intel-pt.txt
> +++ b/tools/perf/Documentation/perf-intel-pt.txt
> @@ -883,7 +883,7 @@ and "r" can be combined to get calls and returns.
>
>  "Transactions" events correspond to the start or end of transactions. Th=
e
>  'flags' field can be used in perf script to determine whether the event =
is a
> -tranasaction start, commit or abort.
> +transaction start, commit or abort.
>
>  Note that "instructions", "branches" and "transactions" events depend on=
 code
>  flow packets which can be disabled by using the config term "branch=3D0"=
.  Refer
> diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Document=
ation/perf-lock.txt
> index 74d774592196..1b4d452923d7 100644
> --- a/tools/perf/Documentation/perf-lock.txt
> +++ b/tools/perf/Documentation/perf-lock.txt
> @@ -44,7 +44,7 @@ COMMON OPTIONS
>
>  -f::
>  --force::
> -       Don't complan, do it.
> +       Don't complain, do it.
>
>  REPORT OPTIONS
>  --------------
> diff --git a/tools/perf/Documentation/perf-script-perl.txt b/tools/perf/D=
ocumentation/perf-script-perl.txt
> index 5a1f68122f50..fa4f39d305a7 100644
> --- a/tools/perf/Documentation/perf-script-perl.txt
> +++ b/tools/perf/Documentation/perf-script-perl.txt
> @@ -54,7 +54,7 @@ all sched_wakeup events in the system:
>  Traces meant to be processed using a script should be recorded with
>  the above option: -a to enable system-wide collection.
>
> -The format file for the sched_wakep event defines the following fields
> +The format file for the sched_wakeup event defines the following fields
>  (see /sys/kernel/debug/tracing/events/sched/sched_wakeup/format):
>
>  ----
> diff --git a/tools/perf/Documentation/perf-script-python.txt b/tools/perf=
/Documentation/perf-script-python.txt
> index 0250dc61cf98..cf4b7f4b625a 100644
> --- a/tools/perf/Documentation/perf-script-python.txt
> +++ b/tools/perf/Documentation/perf-script-python.txt
> @@ -448,7 +448,7 @@ all sched_wakeup events in the system:
>  Traces meant to be processed using a script should be recorded with
>  the above option: -a to enable system-wide collection.
>
> -The format file for the sched_wakep event defines the following fields
> +The format file for the sched_wakeup event defines the following fields
>  (see /sys/kernel/debug/tracing/events/sched/sched_wakeup/format):
>
>  ----
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Document=
ation/perf-stat.txt
> index 4c9310be6acc..7e6fb7cbc0f4 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -385,7 +385,7 @@ Aggregate counts per physical processor for system-wi=
de mode measurements.
>  Print metrics or metricgroups specified in a comma separated list.
>  For a group all metrics from the group are added.
>  The events from the metrics are automatically measured.
> -See perf list output for the possble metrics and metricgroups.
> +See perf list output for the possible metrics and metricgroups.
>
>  -A::
>  --no-aggr::
> diff --git a/tools/perf/Documentation/topdown.txt b/tools/perf/Documentat=
ion/topdown.txt
> index c6302df4cf29..a15b93fdcf50 100644
> --- a/tools/perf/Documentation/topdown.txt
> +++ b/tools/perf/Documentation/topdown.txt
> @@ -2,7 +2,7 @@ Using TopDown metrics in user space
>  -----------------------------------
>
>  Intel CPUs (since Sandy Bridge and Silvermont) support a TopDown
> -methology to break down CPU pipeline execution into 4 bottlenecks:
> +methodology to break down CPU pipeline execution into 4 bottlenecks:
>  frontend bound, backend bound, bad speculation, retiring.
>
>  For more details on Topdown see [1][5]
> --
> 2.32.0
>
