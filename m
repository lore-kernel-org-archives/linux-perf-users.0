Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB41E5103F
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Apr 2025 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743608592; cv=none; b=aWdxwRJtfp7B9MkPsPDLxkwuKBu9jUh4s1w6qrXzPnJS1ZbJt/JJGyJaZq1aXji3BGrSx4u+6qYmHV8RsTmVhU341oLhBTw8OX7Xe/PnyCKgo9xpQld4QXNHtCd+IJqYdk7rm8OZD6M5RTWTC7l5lzTeA6iL/UtVtrevNAwTPmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743608592; c=relaxed/simple;
	bh=gXWTx4KzNVCpRYOf004yG4hkyWIGaJmJ1DJ+XENGdog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FxFRitBv+K1kO2kOXEi1QtAvWQ3h1Z/LLOq6Ybl5fPSsFrqLjQaDTsG+cKO/pbIvOV4VR/NU1DiigcPCvkakTNCFFwdXMpD3E2BfpjGgPbPBMqzijNWkyQaaQb0JkPLwVmca9gXqW5bSpN7xOwlvMDND0WBp0Lp54vLqScjUIUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G1ky23hg; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G1ky23hg"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2263428c8baso203485ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Apr 2025 08:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743608590; x=1744213390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLx926SERiuLZQCn+zwVm1b5oe6kEeJawcqBPY1JlWg=;
        b=G1ky23hgDxxjSVOqAWTScn1JrgHrmXRaDzutwDSjKzDQjc7tYvnNQUvGHPadnFcl/I
         bYTKfbtWgLr41nO/JRKL7UC/fi1+ULLiayg4o4YViWEqCnvTc+9/puFxmt7Wbc2Npvr4
         2hjYKvDaTBCh6gBBVG9lKHpsSLZV3xEZgKOFDPjodxAo/MIq8nc7WLA1qk10We0OxJSR
         mYNl/c4nF85r/JrLwozKcC2G07socM0goC6fwBL/7keNpGOhioPEbuPsGkCMLwH/SJH3
         yybJG+fAPdAIl7HqwOie3JQr1DhrNfqyD+03xvo2bP8LJhGRw3lFwZuCbgfLPt8m94Oy
         +PWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743608590; x=1744213390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLx926SERiuLZQCn+zwVm1b5oe6kEeJawcqBPY1JlWg=;
        b=dIMhAupcEtda0nb+L5zV6Vy5yaLl3nCzrhPabqqnWvdjBYRi38ouEJGcG4PIgCCDER
         mQGVALfDtuz/t1qLmGX86A4fHLiU8K12U7/v19sH+wejOswpWMk++tUxfL2ZSXJw6ZqZ
         YG/I6AzkOxY2N3zm0I/xAN9S3EV8vHs6JHKxdiOGOLSikGGMrjCuDNsvlXIeE4QOwHjK
         HDs+AbJkHXYhToPDpyKu0M6cKdEFyfcYp2o7pxxTvmz1hPLIHUhVkJB7X3rmT97R3/0Y
         gT3jxLaaYGayonuCYp2HR7sffO8x+V3ltoZ0RGNZPu/1Wu9uDryZSOLpjfhJeQIg2GRx
         Ie+A==
X-Forwarded-Encrypted: i=1; AJvYcCVbbWGVwV7cgQQaqkq21VUH5IcVNLNZvcpSVpECvpa02ESrRMMDeu2qWXBTScCJ7pGleyZp2edNeQrDzfzhTzs4@vger.kernel.org
X-Gm-Message-State: AOJu0YznVLt92imiK/cXW4Qy/Tn07VkMj+wjiAQEFBA/BzkHUcGMOJZC
	6nmMpsVAcrg0Ec4WvXVfxaZ7ZcHXiPZGtBu3aa0Ua7GPSfQozTri1S0oNHns44CtA0cdzoVW2I0
	S/rp4nQq5DFcEc23q8WNUv7Wv4mzFBhTiFs4e
X-Gm-Gg: ASbGncsassUlbetbDYuLfWK9gHhzXTJBtbt6KncWsFSaOI9zjaXut1/BPP/enSQ0gR+
	Ms9CT4BScyf2inLpNtZ1f/zfUIwePTlTKTI2Vc4bXiDJs0fdVuu68Dg+PqDFBoBxwVGdHALWjRd
	f7UwcNtPYr8mZ0NOaRuQ/mFpuherqjtxTf/NZLlIbdHM7+NEsa3+HRvg==
X-Google-Smtp-Source: AGHT+IHUU2j/octwD2z6LvcYRe4LtMPcNbJ70CbkYAKSdPaiRXvDW4hjHK3JtQAK2aTmcF6biabxxV5TPMI8t4CMHgM=
X-Received: by 2002:a17:902:e5ca:b0:223:37ec:63be with SMTP id
 d9443c01a7336-22969dce57cmr3357735ad.4.1743608589525; Wed, 02 Apr 2025
 08:43:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com> <20250401182347.3422199-10-irogers@google.com>
 <20250402143541.GM115840@e132581.arm.com>
In-Reply-To: <20250402143541.GM115840@e132581.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 2 Apr 2025 08:42:58 -0700
X-Gm-Features: AQ5f1Jp98ZbdLZ_9VupKP8CmreTV4tjO1cqtDjJsnkA5YYhinMwNDExzc3C9hoA
Message-ID: <CAP-5=fVqax8cxdZ4HLBP4AMxL6jADfYNrORC97T6F23mjf3N1w@mail.gmail.com>
Subject: Re: [PATCH v1 09/48] perf tests: Silence -Wshorten-64-to-32 warnings
To: Leo Yan <leo.yan@arm.com>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nathan Chancellor <nathan@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Kyle Meyer <kyle.meyer@hpe.com>, Ben Gainey <ben.gainey@arm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Eder Zulian <ezulian@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
	He Zhe <zhe.he@windriver.com>, Dirk Gouders <dirk@gouders.net>, 
	Brian Geffon <bgeffon@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Howard Chu <howardchu95@gmail.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Jann Horn <jannh@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Yang Jihong <yangjihong@bytedance.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Hao Ge <gehao@kylinos.cn>, Tengda Wu <wutengda@huaweicloud.com>, 
	Gabriele Monaco <gmonaco@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Casey Chen <cachen@purestorage.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Andrew Kreimer <algonell@gmail.com>, 
	=?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 7:35=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> On Tue, Apr 01, 2025 at 11:23:07AM -0700, Ian Rogers wrote:
>
> [...]
>
> > @@ -478,13 +478,14 @@ static int __cmd_test(struct test_suite **suites,=
 int argc, const char *argv[],
> >       int err =3D 0;
> >
> >       for (struct test_suite **t =3D suites; *t; t++) {
> > -             int i, len =3D strlen(test_description(*t, -1));
> > +             int i;
> > +             int len =3D (int)strlen(test_description(*t, -1));
>
> Thanks for huge polish.
>
> Just a concern from me.  Throughout this patch, the methodology is not
> consistent.  Some changes update variable types which is fine for me.
>
> But the case above it simply cast size_t to int.  Should we update the
> variable type as 'size_t' at here?

Thanks Leo, I played around with it, but don't mind if someone wants
to do it a different way. I was trying to make the changes minimal.
The problem typically with size_t is we then use the value, for
example, as a printf size modifier and need to introduce lots of casts
back to being an int. When this isn't too great I've done it, but in
this case I think keeping the int, the lack of casts but a cast here
to capture that we expect test descriptions to fit in the size of an
int is the least worst option.

> >               if (width < len)
> >                       width =3D len;
> >
> >               test_suite__for_each_test_case(*t, i) {
> > -                     len =3D strlen(test_description(*t, i));
> > +                     len =3D (int)strlen(test_description(*t, i));
> >                       if (width < len)
> >                               width =3D len;
> >                       num_tests +=3D runs_per_test;
> > diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-re=
ading.c
> > index cf6edbe697b2..0c31d5ff77e2 100644
> > --- a/tools/perf/tests/code-reading.c
> > +++ b/tools/perf/tests/code-reading.c
> > @@ -188,7 +188,7 @@ static int objdump_version(void)
> >       char *line =3D NULL;
> >       const char *fmt;
> >       FILE *f;
> > -     int ret;
> > +     ssize_t ret;
> >
> >       int version_tmp, version_num =3D 0;
> >       char *version =3D 0, *token;
> > @@ -295,7 +295,7 @@ static int read_via_objdump(const char *filename, u=
64 addr, void *buf,
> >       if (len) {
> >               pr_debug("objdump read too few bytes: %zd\n", len);
> >               if (!ret)
> > -                     ret =3D len;
> > +                     ret =3D (int)len;
>
> A proper change is to update the function type to:
>
>   size_t read_via_objdump(...)
>
> [...]

Normally the int is negative to error, 0 and more for a successful
positive read of so many bytes. We could switch the return type to
ssize_t but I was trying to avoid changing everything.

> > diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-event=
s.c
> > index db004d26fcb0..2762794827ce 100644
> > --- a/tools/perf/tests/pmu-events.c
> > +++ b/tools/perf/tests/pmu-events.c
> > @@ -609,7 +609,7 @@ static int __test_uncore_pmu_event_aliases(struct p=
erf_pmu_test_pmu *test_pmu)
> >       pmu_add_sys_aliases(pmu);
> >
> >       /* Count how many aliases we generated */
> > -     alias_count =3D perf_pmu__num_events(pmu);
> > +     alias_count =3D (int)perf_pmu__num_events(pmu);
>
> Could we change the variable 'alias_count' to size_t type?
>
> Or in another way, we need to update perf_pmu__num_events() with
> returning int type.
>
> My understanding is rather than using cast, we should polish code for
> using consistent type for both variables and return values.

We can, I was trying to keep the size of the change down. Later the
code will compare against matched_count which is an int, so using a
size_t means a signed vs unsigned compare, so a multi-line change vs 1
cast.

> >       /* Count how many aliases we expect from the known table */
> >       for (table =3D &test_pmu->aliases[0]; *table; table++)
> > diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
> > index a67c756f90b8..b7d7735f8a72 100644
> > --- a/tools/perf/tests/sigtrap.c
> > +++ b/tools/perf/tests/sigtrap.c
> > @@ -154,13 +154,13 @@ sigtrap_handler(int signum __maybe_unused, siginf=
o_t *info, void *ucontext __may
> >  {
> >       if (!__atomic_fetch_add(&ctx.signal_count, 1, __ATOMIC_RELAXED))
> >               ctx.first_siginfo =3D *info;
> > -     __atomic_fetch_sub(&ctx.tids_want_signal, syscall(SYS_gettid), __=
ATOMIC_RELAXED);
> > +     __atomic_fetch_sub(&ctx.tids_want_signal, (pid_t)syscall(SYS_gett=
id), __ATOMIC_RELAXED);
> >  }
> >
> >  static void *test_thread(void *arg)
> >  {
> >       pthread_barrier_t *barrier =3D (pthread_barrier_t *)arg;
> > -     pid_t tid =3D syscall(SYS_gettid);
> > +     pid_t tid =3D (pid_t)syscall(SYS_gettid);
> >       int i;
> >
> >       pthread_barrier_wait(barrier);
> > diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/swit=
ch-tracking.c
> > index 8df3f9d9ffd2..1f0f8321ae40 100644
> > --- a/tools/perf/tests/switch-tracking.c
> > +++ b/tools/perf/tests/switch-tracking.c
> > @@ -140,8 +140,8 @@ static int process_sample_event(struct evlist *evli=
st,
> >
> >       evsel =3D evlist__id2evsel(evlist, sample.id);
> >       if (evsel =3D=3D switch_tracking->switch_evsel) {
> > -             next_tid =3D evsel__intval(evsel, &sample, "next_pid");
> > -             prev_tid =3D evsel__intval(evsel, &sample, "prev_pid");
> > +             next_tid =3D (int)evsel__intval(evsel, &sample, "next_pid=
");
> > +             prev_tid =3D (int)evsel__intval(evsel, &sample, "prev_pid=
");
>
> Change 'prev_tid' and 'next_tid' to pid_t type?

I agree, but I was trying to do what was minimal and use the types as
they already were. Perhaps we should have multiple of the
evsel__<type>val helpers. Again, I wanted to do what was minimal in
order for the warning to be silenced.

Thanks,
Ian

> Thanks,
> Leo
>
> >               cpu =3D sample.cpu;
> >               pr_debug3("sched_switch: cpu: %d prev_tid %d next_tid %d\=
n",
> >                         cpu, prev_tid, next_tid);
> > @@ -262,9 +262,10 @@ static int compar(const void *a, const void *b)
> >  {
> >       const struct event_node *nodea =3D a;
> >       const struct event_node *nodeb =3D b;
> > -     s64 cmp =3D nodea->event_time - nodeb->event_time;
> >
> > -     return cmp;
> > +     if (nodea->event_time =3D=3D nodeb->event_time)
> > +             return 0;
> > +     return nodea->event_time < nodeb->event_time ? -1 : 1;
> >  }
> >
> >  static int process_events(struct evlist *evlist,
> > @@ -398,7 +399,7 @@ static int test__switch_tracking(struct test_suite =
*test __maybe_unused, int sub
> >
> >       switch_evsel =3D evlist__add_sched_switch(evlist, true);
> >       if (IS_ERR(switch_evsel)) {
> > -             err =3D PTR_ERR(switch_evsel);
> > +             err =3D (int)PTR_ERR(switch_evsel);
> >               pr_debug("Failed to create event %s\n", sched_switch);
> >               goto out_err;
> >       }
> > diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vml=
inux-kallsyms.c
> > index 74cdbd2ce9d0..fbdb463e965d 100644
> > --- a/tools/perf/tests/vmlinux-kallsyms.c
> > +++ b/tools/perf/tests/vmlinux-kallsyms.c
> > @@ -82,7 +82,7 @@ static bool is_ignored_symbol(const char *name, char =
type)
> >                       return true;
> >
> >       for (p =3D ignored_suffixes; *p; p++) {
> > -             int l =3D strlen(name) - strlen(*p);
> > +             ssize_t l =3D strlen(name) - strlen(*p);
> >
> >               if (l >=3D 0 && !strcmp(name + l, *p))
> >                       return true;
> > @@ -313,7 +313,7 @@ static int test__vmlinux_matches_kallsyms(struct te=
st_suite *test __maybe_unused
> >                                * _really_ have a problem.
> >                                */
> >                               s64 skew =3D mem_end - UM(pair->end);
> > -                             if (llabs(skew) >=3D page_size)
> > +                             if (llabs(skew) >=3D (s64)page_size)
> >                                       pr_debug("WARN: %#" PRIx64 ": dif=
f end addr for %s v: %#" PRIx64 " k: %#" PRIx64 "\n",
> >                                                mem_start, sym->name, me=
m_end,
> >                                                UM(pair->end));
> > diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
> > index 6c178985e37f..d5dd17eb5c05 100644
> > --- a/tools/perf/tests/wp.c
> > +++ b/tools/perf/tests/wp.c
> > @@ -31,10 +31,10 @@ volatile u8 data2[3];
> >  #ifndef __s390x__
> >  static int wp_read(int fd, long long *count, int size)
> >  {
> > -     int ret =3D read(fd, count, size);
> > +     ssize_t ret =3D read(fd, count, size);
> >
> >       if (ret !=3D size) {
> > -             pr_debug("failed to read: %d\n", ret);
> > +             pr_debug("failed to read: %zd\n", ret);
> >               return -1;
> >       }
> >       return 0;
> > --
> > 2.49.0.504.g3bcea36a83-goog
> >
> >
