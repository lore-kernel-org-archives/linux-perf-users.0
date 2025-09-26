Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039532DF6F6
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Sep 2025 10:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758884061; cv=none; b=rF86rCR5xGMPZq2W4u7dOXgjPsgCjlXon8ebePv+8KamdQqVaJAdmc/ibmcUPgSNoPzkHQT5rr0ZKGq9wNkamM2KpsmyKAUk3xyNb6NRPW7OcIrjAND9VL3GPdXXzKCXCt+3q0zlgka1ARePOeMZsNX/2EQs81uSBAp6nLI+51g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758884061; c=relaxed/simple;
	bh=ZqJ9gWc509cwsHWwJkNg4NON23HFhjy8X0SEdcYZJdQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2mOdr85PDPqnY1p91n4uBNJoT938DKE/Tg4ZQNegS85q9sab2+CgJy0hECwyrK7lKHdBS83VSfGnFdLZ6K8b4YwtzqNv/VIwWMqWh3oWSrnWjD+i76UZzEPbL/gT3p/hBwg8NXPNKuztEalroPmbsM+TqsgVP+b2qM2A0YbByo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IW8rqNH/; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IW8rqNH/"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ef166e625aso1600391f8f.2
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Sep 2025 03:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758884057; x=1759488857; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UJQS+YYB0NzVkBYe1TuZ4CgN8KO3C/Ns6qyjEQZVUms=;
        b=IW8rqNH/1yhFb0gGVJYACjrM3qwnw0O+mRjnnsVnKBetIp5s6F2n6ZCB1kKwEKC+pw
         B950MYusjWienDRj8noQHTW+KaEsATmsD8kwRMbpMkri9FO6+z65yzWqMXqYNPC2wOTO
         woX3TAsMdqQrvI+ttoPzdL4XEXm9mJ42NWRL4hN71FinoDbcyoSSq/ztclaLLCprBzGn
         zij4vvNdldsYoX3IiJBDpEeH3zSaZSN3sVPYaejYXIvYGRwrYy1DvQmLro/L8Zlft1IG
         aYJsnd9KwjyJ6PSPitlEvJHxCqaIcQd2Gn4gF5WJpyADihnNRqpRrfI3yvfnrMo/Abv+
         yo4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758884057; x=1759488857;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJQS+YYB0NzVkBYe1TuZ4CgN8KO3C/Ns6qyjEQZVUms=;
        b=Yxe0dQra1UbyXpixSXdolzPVtROxJ0sV+/R3S/YhwySDCfCnklAwhQMQh1pYMEmQ7j
         /JEpw5HuZ5EeAkj3wnJBNKvkxaJQGex3pppIam3SLXBIF7Mt5fkC8I68+KkLjdPycMxu
         y7/cXlMDWXGK5Up+wAwxpLtgWpL6QZI99Szo3t8b+Ehvaqfv0Wnjm6EFdTmK5rc+6Cmz
         k2uEHWvNs3Io+vAyNCLc9W0r4pbgt+bKx7pZiMLWz3PcEN4Kq+2atVsPgavojfskCkks
         avfZkU1PJU3iUgF91Y5MgH5Vta1ODUpPikVl4S41me4MjofFVRAkd3JbZOEzEiY4fNG3
         DC8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKjjNT/tEbuTlYCNlOvcTFS8ScEaQArrWwrCZXabtMK4doP0p/iS0ALaEwW+1PtT0yPtePNS137+yK4y6xJ4Ed@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkj3XqtxcCIZXZUwusYHNTNtGtwS1twdkYllsBzTxHt2xgVZxe
	l8dZIxz4MDz+JT+ddxhviHfV77IXzRR/y81VpZTdOsEoG4gkc65BAr/9
X-Gm-Gg: ASbGnctQeNBniIMq5LzRHbNjD49ZI8bizR6oXtlJaLpK7oX97W9mSQsDziWM6HZuxTs
	rlodKlB4s2j6A6p+C0JP2MHMdKWkCSCqvaAtLl10d3kap/WUR+1WY9jTFY9Duop0Kg8DP9P/h4z
	czCmYtvjfJ7bOch2yPcfsiqR5mXwDa3PtIpjDleHOAUF5t14cE4BysvHaNJlHDfwiGLX7Iaw8vy
	VOrqm8tccgEx6L/UVOCgIjBmTiYAfCZhz156E31qA+N1jYD6ckq8UXL44VodnapGhHLvhuMkbYh
	9ipVimT1Gtauj+k7rH3so6SrMrI3SfNZcmkYySsqAa/ilD0KQDcy0vbcsTDZr1ey8u+BCIVxqjV
	9hLlIjRk=
X-Google-Smtp-Source: AGHT+IGNiZG0zTs7QJIGVAfP9xqyiBKqMoVnPCEQ/mevzBFGRcZCQruWumPhglYyA6JRq8GUffO6ow==
X-Received: by 2002:a05:6000:178b:b0:3b7:9c79:32bb with SMTP id ffacd0b85a97d-40e4ff1991bmr6941603f8f.44.1758884057002;
        Fri, 26 Sep 2025 03:54:17 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72face8sm6615912f8f.5.2025.09.26.03.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 03:54:16 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 26 Sep 2025 12:54:15 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Feng Yang <yangfeng59949@163.com>, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add stacktrace test for kprobe
 multi
Message-ID: <aNZw13CJARm5EZGB@krava>
References: <20250925115145.1916664-1-jolsa@kernel.org>
 <CAEf4BzYPkuD0SnfhjwWU3X_HaRGk-gSVqe_-AxYe7P5kfAZ9Vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYPkuD0SnfhjwWU3X_HaRGk-gSVqe_-AxYe7P5kfAZ9Vw@mail.gmail.com>

On Thu, Sep 25, 2025 at 04:26:08PM -0700, Andrii Nakryiko wrote:
> On Thu, Sep 25, 2025 at 4:51 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding stacktrace test for kprobe multi probe.
> >
> > Cc: Feng Yang <yangfeng59949@163.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> > test for arm64 fix posted separately in here:
> >   https://lore.kernel.org/bpf/20250925020822.119302-1-yangfeng59949@163.com/
> >
> >  .../selftests/bpf/prog_tests/stacktrace_map.c | 107 +++++++++++++-----
> >  .../selftests/bpf/progs/test_stacktrace_map.c |  28 ++++-
> >  2 files changed, 106 insertions(+), 29 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
> > index 84a7e405e912..922224adc86b 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
> > @@ -1,13 +1,44 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <test_progs.h>
> > +#include "test_stacktrace_map.skel.h"
> >
> 
> Tao just refactored this to skeleton, so please rebase and adjust accordingly

ok

> 
> pw-bot: cr
> 
> 
> > -void test_stacktrace_map(void)
> > +static void check_stackmap(int control_map_fd, int stackid_hmap_fd,
> > +                          int stackmap_fd, int stack_amap_fd)
> > +{
> > +       __u32 key, val, duration = 0;
> > +       int err, stack_trace_len;
> > +
> > +       /* disable stack trace collection */
> > +       key = 0;
> > +       val = 1;
> > +       bpf_map_update_elem(control_map_fd, &key, &val, 0);
> > +
> > +       /* for every element in stackid_hmap, we can find a corresponding one
> > +        * in stackmap, and vice versa.
> > +        */
> > +       err = compare_map_keys(stackid_hmap_fd, stackmap_fd);
> > +       if (CHECK(err, "compare_map_keys stackid_hmap vs. stackmap",
> > +                 "err %d errno %d\n", err, errno))
> > +               return;
> > +
> > +       err = compare_map_keys(stackmap_fd, stackid_hmap_fd);
> > +       if (CHECK(err, "compare_map_keys stackmap vs. stackid_hmap",
> > +                 "err %d errno %d\n", err, errno))
> > +               return;
> > +
> > +       stack_trace_len = PERF_MAX_STACK_DEPTH * sizeof(__u64);
> > +       err = compare_stack_ips(stackmap_fd, stack_amap_fd, stack_trace_len);
> > +       CHECK(err, "compare_stack_ips stackmap vs. stack_amap",
> > +               "err %d errno %d\n", err, errno);
> > +}
> > +
> > +static void test_stacktrace_map_tp(void)
> >  {
> >         int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
> >         const char *prog_name = "oncpu";
> > -       int err, prog_fd, stack_trace_len;
> > +       int err, prog_fd;
> >         const char *file = "./test_stacktrace_map.bpf.o";
> > -       __u32 key, val, duration = 0;
> > +       __u32 duration = 0;
> >         struct bpf_program *prog;
> >         struct bpf_object *obj;
> >         struct bpf_link *link;
> > @@ -44,32 +75,56 @@ void test_stacktrace_map(void)
> >         /* give some time for bpf program run */
> >         sleep(1);
> >
> > -       /* disable stack trace collection */
> > -       key = 0;
> > -       val = 1;
> > -       bpf_map_update_elem(control_map_fd, &key, &val, 0);
> > -
> > -       /* for every element in stackid_hmap, we can find a corresponding one
> > -        * in stackmap, and vice versa.
> > -        */
> > -       err = compare_map_keys(stackid_hmap_fd, stackmap_fd);
> > -       if (CHECK(err, "compare_map_keys stackid_hmap vs. stackmap",
> > -                 "err %d errno %d\n", err, errno))
> > -               goto disable_pmu;
> > -
> > -       err = compare_map_keys(stackmap_fd, stackid_hmap_fd);
> > -       if (CHECK(err, "compare_map_keys stackmap vs. stackid_hmap",
> > -                 "err %d errno %d\n", err, errno))
> > -               goto disable_pmu;
> > -
> > -       stack_trace_len = PERF_MAX_STACK_DEPTH * sizeof(__u64);
> > -       err = compare_stack_ips(stackmap_fd, stack_amap_fd, stack_trace_len);
> > -       if (CHECK(err, "compare_stack_ips stackmap vs. stack_amap",
> > -                 "err %d errno %d\n", err, errno))
> > -               goto disable_pmu;
> > +       check_stackmap(control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd);
> >
> >  disable_pmu:
> >         bpf_link__destroy(link);
> >  close_prog:
> >         bpf_object__close(obj);
> >  }
> > +
> > +static void test_stacktrace_map_kprobe_multi(bool retprobe)
> > +{
> > +       int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
> > +       LIBBPF_OPTS(bpf_kprobe_multi_opts, opts,
> > +               .retprobe = retprobe
> > +       );
> > +       LIBBPF_OPTS(bpf_test_run_opts, topts);
> > +       struct test_stacktrace_map *skel;
> > +       struct bpf_link *link;
> > +       int prog_fd, err;
> > +
> > +       skel = test_stacktrace_map__open_and_load();
> > +       if (!ASSERT_OK_PTR(skel, "test_stacktrace_map__open_and_load"))
> > +               return;
> > +
> > +       link = bpf_program__attach_kprobe_multi_opts(skel->progs.kprobe,
> > +                                                    "bpf_fentry_test1", &opts);
> > +       if (!ASSERT_OK_PTR(link, "bpf_program__attach_kprobe_multi_opts"))
> > +               goto cleanup;
> > +
> > +       prog_fd = bpf_program__fd(skel->progs.trigger);
> > +       err = bpf_prog_test_run_opts(prog_fd, &topts);
> > +       ASSERT_OK(err, "test_run");
> > +       ASSERT_EQ(topts.retval, 0, "test_run");
> > +
> > +       control_map_fd  = bpf_map__fd(skel->maps.control_map);
> > +       stackid_hmap_fd = bpf_map__fd(skel->maps.stackid_hmap);
> > +       stackmap_fd     = bpf_map__fd(skel->maps.stackmap);
> > +       stack_amap_fd   = bpf_map__fd(skel->maps.stack_amap);
> > +
> > +       check_stackmap(control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd);
> > +
> > +cleanup:
> > +       test_stacktrace_map__destroy(skel);
> > +}
> > +
> > +void test_stacktrace_map(void)
> > +{
> > +       if (test__start_subtest("tp"))
> > +               test_stacktrace_map_tp();
> > +       if (test__start_subtest("kprobe_multi"))
> > +               test_stacktrace_map_kprobe_multi(false);
> > +       if (test__start_subtest("kretprobe_multi"))
> > +               test_stacktrace_map_kprobe_multi(true);
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/test_stacktrace_map.c b/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
> > index 47568007b668..7a27e162a407 100644
> > --- a/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
> > +++ b/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
> > @@ -3,6 +3,7 @@
> >
> >  #include <vmlinux.h>
> >  #include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> >
> >  #ifndef PERF_MAX_STACK_DEPTH
> >  #define PERF_MAX_STACK_DEPTH         127
> > @@ -50,8 +51,7 @@ struct sched_switch_args {
> >         int next_prio;
> >  };
> >
> > -SEC("tracepoint/sched/sched_switch")
> > -int oncpu(struct sched_switch_args *ctx)
> > +static inline void test_stackmap(void *ctx)
> >  {
> >         __u32 max_len = PERF_MAX_STACK_DEPTH * sizeof(__u64);
> >         __u32 key = 0, val = 0, *value_p;
> > @@ -59,7 +59,7 @@ int oncpu(struct sched_switch_args *ctx)
> >
> >         value_p = bpf_map_lookup_elem(&control_map, &key);
> >         if (value_p && *value_p)
> > -               return 0; /* skip if non-zero *value_p */
> > +               return; /* skip if non-zero *value_p */
> >
> >         /* The size of stackmap and stackid_hmap should be the same */
> >         key = bpf_get_stackid(ctx, &stackmap, 0);
> > @@ -69,7 +69,29 @@ int oncpu(struct sched_switch_args *ctx)
> >                 if (stack_p)
> >                         bpf_get_stack(ctx, stack_p, max_len, 0);
> >         }
> > +}
> > +
> > +SEC("tracepoint/sched/sched_switch")
> > +int oncpu(struct sched_switch_args *ctx)
> > +{
> > +       test_stackmap(ctx);
> > +       return 0;
> > +}
> >
> > +/*
> > + * No tests in here, just to trigger 'bpf_fentry_test*'
> > + * through tracing test_run.
> > + */
> > +SEC("fentry/bpf_modify_return_test")
> > +int BPF_PROG(trigger)
> > +{
> > +       return 0;
> > +}
> > +
> > +SEC("kprobe.multi")
> > +int kprobe(struct pt_regs *ctx)
> > +{
> > +       test_stackmap(ctx);
> >         return 0;
> >  }
> >
> 
> Can you please expland the set of program types you are testing:
> kprobe/kretprobe, kprobe.multi/kretprobe.multi, fentry/fexit/fmod_ret,
> maybe even uprobe/uretprobe?

right, will add those

> 
> Also, for check_stack_ips(), can we make sure that we look for
> expected >1 IPs there? We had (still have?) issues where we'd get
> (successfully) stack trace with just single (but valid!) entry
> corresponding to traced function, but nothing beyond that. Which
> clearly is broken. So it would be good to be able to detect this going
> forward.

ok

thanks,
jirka
