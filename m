Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2655E24CEF1;
	Fri, 14 Feb 2025 17:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739552795; cv=none; b=iq5hvurJfI2Zw1vKPrRbh/+pLRkb6p+JvG/tr9GqTyqYCTQNrLiH/2e+2uqjYD7FF0edMK9PhPk78ZNllHsdmKYm7MRNwRZUPiwMmGB8azsNOaEHV89ZVPNVxvqbM7/xyAGHS0IAp3TS2lgdeLmqgRJL6pT2x+6mHuju9FEfsgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739552795; c=relaxed/simple;
	bh=y7eINFJEDX5leEqZ0dhdX+xgBwEVOZfPtF1apIvbvyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9FduxvebqQkSUXwnQ3GQgY0BQe8AP+lRJr0Xh7/UqM/XTPYkF2Ns7HeHtQuZi1zEj4DIBalNAUzB03x9LrXxwQOIgGyS7yy0R7/4PJ2bTeazttLA0c2oA/Zqq+wpjUsonAlCbKpONBe1uuo2+KI0eFGFL6kbTjUdrWUxXZx0XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7M1VpJn; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7M1VpJn"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6f768e9be1aso28569297b3.0;
        Fri, 14 Feb 2025 09:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739552793; x=1740157593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TISz4b5vSlplqhW6/j68OFcJR7w5kWob0qZFt3FT/nw=;
        b=F7M1VpJncHCsOqGfB2FCxelLQg9254m+qhtLpmzwntihxArP8SfgSR5GRcYe5v7rt0
         ojtR80d2to3XKf//nY89z1F1rIMriYwHMvBOZKcQKeP11aeb9uobYnQXYdVq/t914g+T
         Z/XhCxzsVwLQZylu3KHyIDsF0hUbMfw+kTryQFp7BTd8jeKkVCj0SNny1t3PG0yxUO4r
         5kzVOoKFj2Cu3y0j1a9mJv7wREATjyN6uLybBJazio/qnXquB0HXeAFZLRuEowL8vT3r
         gcnw0vCEYeeKwJDpOPZ0qi/aUJH64R7HTnLjoz/2xlPz6D3O68TZfPa1/SKvlkHyCAp9
         L1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739552793; x=1740157593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TISz4b5vSlplqhW6/j68OFcJR7w5kWob0qZFt3FT/nw=;
        b=d7ZrRLtPFdgSiw67eWYc2U5A2fOVEiIOZBdyTPWvRBplpagmFs09Byf5oQqClYA3DM
         OaxNjWVDpVHpZYKNfgk94xYJEjI2eayRJtDsXsU/PIa9k1bxqwgHeOIdHTlslpX4oRVL
         RuopOUgxpiAcUNKILvOj6tWT8USZPj3agrsDD+AdGpWY0SjHBjOB1dYNzICWCYpH2/tH
         SYqvrO43RafOberwVhk3+FlTmEHxPCIWzEKj7z7E+eEJqQRveO8SAS62zyA29xpRCB4h
         AtCy8xur9CNmdRiJ/K6quz85BE1nFHAKvVWWasgFkBVYGD3Xnzd7nL1/XLE3hfjRbFZt
         YSGw==
X-Forwarded-Encrypted: i=1; AJvYcCWOqkI99JPF+TdO7a/tkA3QLWr+piOR8Us0W8c3ChLqc6S8n47MtQ5zr0eIY/wl1jgGNeteNJe+DNjF52jcyluzEQ==@vger.kernel.org, AJvYcCX2Wjsr5ihc1LDf3lVNZZaQza/UALK+8gKHlwqlagjgFrT1Q6OGPRbq+QpMA3raw6bgxX351hwF3pJp9bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMzkbBdLQ+5/RViNu5vSngxC4dR4TTdncVahk3hsA56zN/jhyl
	FDwGrqcA+97y8ymKMP2grw+tjb3atlnDaktd9FV98KnXR4gkVDQio+8Y3D3hzv+SI+OfEm6iO5O
	sYWWi56CIi7SgJ5JNG8QMoaiUQMtfR3JcaIg=
X-Gm-Gg: ASbGnctPUABOp8C9YxdFREwbWKLdzsmfoXrt43te385vtaxqGjMrZXj4O7yoLLbEUAv
	8DoaRbwDZZU1ZkKexhsI2pOgCLdwE5I+BlaKVTVjTyXnFdfN+1FyDbOU7xp1yPbcfWkxjWQs=
X-Google-Smtp-Source: AGHT+IH1aH0soLQjUKObjU/VZ+5qc6/I24z8BjBOoGV9rVMY/mymnutuQjrUBwCLiyg/49eg5Zcs3nmu41ckUPMC7Jk=
X-Received: by 2002:a05:690c:2e13:b0:6f9:b027:1bfc with SMTP id
 00721157ae682-6fb33c5a833mr67771347b3.3.1739552792941; Fri, 14 Feb 2025
 09:06:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQCU67EsHyw_FsqGbRuityahZTSAtWzffU=hLUJ7K=aZ=1hhA@mail.gmail.com>
In-Reply-To: <CAOQCU67EsHyw_FsqGbRuityahZTSAtWzffU=hLUJ7K=aZ=1hhA@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 14 Feb 2025 09:06:23 -0800
X-Gm-Features: AWEUYZmkVH-RTT9bcbFc3sg6DFD3tSo9lU_C2Bh6GLNy1-r4C_LIrY-ocpw1oTQ
Message-ID: <CAH0uvojWYbaeDi2=MLkNi+R+N3yAE5rNEV2Ube0Xm21pz6nTTA@mail.gmail.com>
Subject: Re: perf: Question about machine__create_extra_kernel_maps and
 trampoline symbols
To: =?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ian Rogers <irogers@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Krzysztof,

Thanks for looking into this.

On Thu, Feb 13, 2025 at 5:10=E2=80=AFAM Krzysztof =C5=81opatowski
<krzysztof.m.lopatowski@gmail.com> wrote:
>
> Hi,
>
> I'm investigating performance issues with perf's kallsyms parsing. Runnin=
g
> `perf record -g perf trace -a --max-events 1` on an x86_64 Ubuntu 24.10 o=
n a VM

This might be off-topic, but since you (and I think most of the people
as well) didn't use perf trace with --call-graph and
--kernel-syscall-graph.

sudo ./perf trace --call-graph fp --kernel-syscall-graph -a -- sleep 10

Can we do something like:

 tools/perf/builtin-buildid-list.c     | 2 +-
 tools/perf/builtin-trace.c            | 6 +++---
 tools/perf/tests/code-reading.c       | 2 +-
 tools/perf/tests/dlfilter-test.c      | 2 +-
 tools/perf/tests/dwarf-unwind.c       | 2 +-
 tools/perf/tests/mmap-thread-lookup.c | 2 +-
 tools/perf/tests/symbols.c            | 2 +-
 tools/perf/util/machine.c             | 6 +++---
 tools/perf/util/machine.h             | 2 +-
 tools/perf/util/probe-event.c         | 2 +-
 10 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-buildid-list.c
b/tools/perf/builtin-buildid-list.c
index 52dfacaff8e3..357201d8ef0c 100644
--- a/tools/perf/builtin-buildid-list.c
+++ b/tools/perf/builtin-buildid-list.c
@@ -47,7 +47,7 @@ static void buildid__show_kernel_maps(void)
 {
         struct machine *machine;

-        machine =3D machine__new_host();
+        machine =3D machine__new_host(true);
         machine__for_each_kernel_map(machine, buildid__map_cb, NULL);
         machine__delete(machine);
 }
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f55a8a6481f2..e2d840d4787a 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1956,14 +1956,14 @@ static char
*trace__machine__resolve_kernel_addr(void *vmachine, unsigned long l
         return machine__resolve_kernel_addr(vmachine, addrp, modp);
 }

-static int trace__symbols_init(struct trace *trace, struct evlist *evlist)
+static int trace__symbols_init(struct trace *trace, struct evlist
*evlist, bool create_kernel_maps)
 {
         int err =3D symbol__init(NULL);

         if (err)
                 return err;

-        trace->host =3D machine__new_host();
+        trace->host =3D machine__new_host(create_kernel_maps);
         if (trace->host =3D=3D NULL)
                 return -ENOMEM;

@@ -4340,7 +4340,7 @@ static int trace__run(struct trace *trace, int
argc, const char **argv)
                 goto out_delete_evlist;
         }

-        err =3D trace__symbols_init(trace, evlist);
+        err =3D trace__symbols_init(trace, evlist,
callchain_param.enabled && trace->kernel_syscallchains);
         if (err < 0) {
                 fprintf(trace->output, "Problems initializing symbol
libraries!\n");
                 goto out_delete_evlist;
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-readin=
g.c
index cf6edbe697b2..17c7b9f95532 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -654,7 +654,7 @@ static int do_test_code_reading(bool try_kcore)

         pid =3D getpid();

-        machine =3D machine__new_host();
+        machine =3D machine__new_host(true);
         machine->env =3D &perf_env;

         ret =3D machine__create_kernel_maps(machine);
diff --git a/tools/perf/tests/dlfilter-test.c b/tools/perf/tests/dlfilter-t=
est.c
index 54f59d1246bc..11f70ebabacf 100644
--- a/tools/perf/tests/dlfilter-test.c
+++ b/tools/perf/tests/dlfilter-test.c
@@ -352,7 +352,7 @@ static int test__dlfilter_test(struct test_data *td)
                 return test_result("Failed to find program symbols",
TEST_FAIL);

         pr_debug("Creating new host machine structure\n");
-        td->machine =3D machine__new_host();
+        td->machine =3D machine__new_host(true);
         td->machine->env =3D &perf_env;

         td->fd =3D creat(td->perf_data_file_name, 0644);
diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwin=
d.c
index 4803ab2d97ba..b76712f68403 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -203,7 +203,7 @@ noinline int test__dwarf_unwind(struct test_suite
*test __maybe_unused,
         struct thread *thread;
         int err =3D -1;

-        machine =3D machine__new_host();
+        machine =3D machine__new_host(true);
         if (!machine) {
                 pr_err("Could not get machine\n");
                 return -1;
diff --git a/tools/perf/tests/mmap-thread-lookup.c
b/tools/perf/tests/mmap-thread-lookup.c
index ddd1da9a4ba9..194b5affaa41 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -167,7 +167,7 @@ static int mmap_events(synth_cb synth)
          */
         TEST_ASSERT_VAL("failed to create threads", !threads_create());

-        machine =3D machine__new_host();
+        machine =3D machine__new_host(true);

         dump_trace =3D verbose > 1 ? 1 : 0;

diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
index ee20a366f32f..6b22a451211a 100644
--- a/tools/perf/tests/symbols.c
+++ b/tools/perf/tests/symbols.c
@@ -19,7 +19,7 @@ struct test_info {

 static int init_test_info(struct test_info *ti)
 {
-        ti->machine =3D machine__new_host();
+        ti->machine =3D machine__new_host(true);
         if (!ti->machine) {
                 pr_debug("machine__new_host() failed!\n");
                 return TEST_FAIL;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 55d4977b9913..bfa0dc98264a 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -125,14 +125,14 @@ int machine__init(struct machine *machine, const
char *root_dir, pid_t pid)
         return 0;
 }

-struct machine *machine__new_host(void)
+struct machine *machine__new_host(bool create_kernel_maps)
 {
         struct machine *machine =3D malloc(sizeof(*machine));

         if (machine !=3D NULL) {
                 machine__init(machine, "", HOST_KERNEL_ID);

-                if (machine__create_kernel_maps(machine) < 0)
+                if (create_kernel_maps &&
machine__create_kernel_maps(machine) < 0)
                         goto out_delete;

                 machine->env =3D &perf_env;
@@ -146,7 +146,7 @@ struct machine *machine__new_host(void)

 struct machine *machine__new_kallsyms(void)
 {
-        struct machine *machine =3D machine__new_host();
+        struct machine *machine =3D machine__new_host(true);
         /*
          * FIXME:
          * 1) We should switch to machine__load_kallsyms(), i.e. not expli=
citly
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index ae3e5542d57d..444e1961acf7 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -163,7 +163,7 @@ struct thread *machine__findnew_guest_code(struct
machine *machine, pid_t pid);
 void machines__set_id_hdr_size(struct machines *machines, u16 id_hdr_size)=
;
 void machines__set_comm_exec(struct machines *machines, bool comm_exec);

-struct machine *machine__new_host(void);
+struct machine *machine__new_host(bool create_kernel_maps);
 struct machine *machine__new_kallsyms(void);
 int machine__init(struct machine *machine, const char *root_dir, pid_t pid=
);
 void machine__exit(struct machine *machine);
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 307ad6242a4e..6b5b5542f454 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -94,7 +94,7 @@ int init_probe_symbol_maps(bool user_only)
         if (symbol_conf.vmlinux_name)
                 pr_debug("Use vmlinux: %s\n", symbol_conf.vmlinux_name);

-        host_machine =3D machine__new_host();
+        host_machine =3D machine__new_host(true);
         if (!host_machine) {
                 pr_debug("machine__new_host() failed.\n");
                 symbol__exit();
--=20
2.45.2

But I also like the idea of optimizing the ksym parsing/preprocessing.

I can't answer your questions yet, but I'll look into it.

Thanks,
Howard


> (perf version 6.11) showed that about 61% of time was spent in
> 'kallsyms__parse'.
> Total execution time was 370 ms. When running latest version from
> tmp.perf-tools-next
> It's 530ms total and 38% in 'kallsyms__parse' because the old version
> doesn't have
> bpf skeletons enabled.
> During regular execution this function is called three times:
>
> 1. In machine__get_running_kernel_start - searching for _text
> 2. In machine__get_running_kernel_start - searching for _edata
> 3. In machine__create_extra_kernel_maps - which is the focus of my questi=
on
>
> Regarding the third call (implemented in tools/perf/arch/x86/util/machine=
.c),
> I notice it searches for:
> - _entry_trampoline
> - __entry_SYSCALL_64_trampoline
>
> I'm puzzled by the dynamic allocation in add_extra_kernel_map, which seem=
s to
> expect multiple __entry_SYSCALL_64_trampoline symbols. This functionality=
 was
> introduced in:
> https://lore.kernel.org/all/1526986485-6562-1-git-send-email-adrian.hunte=
r@intel.com/
>
> I've attempted to trigger the trampoline logic in two ways:
>
> 1. Using the example provided (uname_x_n.c), which only recorded these sy=
mbols:
>    - entry_SYSCALL_64_after_hwframe
>    - entry_SYSCALL_64
>    - entry_SYSCALL_64_safe_stack
>
> 2. Setting kprobes and kretprobes to try to make the kernel create these =
special
>    trampoline symbols, but this approach also didn't work.
>
> Questions for the perf developer community:
> 1. Is there a reliable way to trigger this trampoline logic in perf? I'd =
like to
>    create a perf test for this functionality.
> 2. If machine__create_extra_kernel_maps is obsolete (since it's
> x86_64-specific),
>    could we remove it to reduce /proc/kallsyms parsing time by at least 5=
0%?
>
> I'm working on a patch to simplify machine__create_kernel_maps to call
> kallsyms__parse only once. However, I would appreciate guidance from thos=
e more
> familiar with perf.
>
> Side note: Could exposing the kernel's lookup_symbol_name function
> (from kernel/kallsyms.c) to userspace eliminate the need for reading
> /proc/kallsyms?
>
> Best regards,
> Krzysztof =C5=81opatowski
>
