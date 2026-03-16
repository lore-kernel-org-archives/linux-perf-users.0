Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B57F3E4C9E
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Mar 2026 18:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686494; cv=pass; b=h+MGPY3WmOUCAhGZsWFA3fcfSSX5zIIXVpHu4vGe9SKbC+rG2C/s3jtltgQDKTWuN3xlRwQ6I9Tyr21limj3hO3cu07iRUPDlnFdWGwpKiAXcvZv4bTSZ1JVn///CXNFqnGbWYKTCEKSRHQxZFZQ/C6M5P1FHcNTDqyZ8GA+PUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686494; c=relaxed/simple;
	bh=/JcBvwkGRLdJITEuZQ2nZV1F5U7yrMabcJ0rKiBTN/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mOoDCQGwTERLgw3dP9u+uQyrzyO2v0bUT4hJBUDmNhUqHO/SEqwFU2fxoMCqLGUuft14256obmT2mDjvxTEYMLxFgopYppC+/QnlnCFiZeMzPKULXTqoiRLzVeVWsTt4deZNklt9mC+0aXMWPy5jCAhY3gt3jmp46cdIogzDvGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KMg/N/bs; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KMg/N/bs"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b052562254so16405ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Mar 2026 11:41:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773686490; cv=none;
        d=google.com; s=arc-20240605;
        b=KbwycU9qWdD2IZhkA2fbUa/3OaLv+AQGdeQHCjfNVGrSQmFzWbBjykfDi3tCu9iidR
         dIjJPfKzfP9iDjmmGcruLzCBbR8B8rw5RUXx66/ul1INX3xJWOeNN6osuNTnsiKo11qA
         Mm0a7oC92UXq+K9s1pNPa2naV9fSKg7Xyf5tEuVl04imhB1tu/CKQogAIF07p+6Iz7dt
         ZXM1d+PfBLr/JgW/p6ogeBwwsCEyMwTIPP2dA6JKMWgKp4Ql/Msrl/0dtIwi7NHtX9g0
         ouzPUQJzxHahyM8FJfG9LQWZfiQyfGVD3IAFUNYAAvZdeD5Rre16cLetMPl4wBqosRtz
         Xn/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BGq9WjFn8Xvcp6TfAGJrrctyuJyQnFDbgZnxO6QRELQ=;
        fh=ocuvQLaN0Z4ix/DIgEswUbFTc8wDJTgwjgkdsF2Exxw=;
        b=V20OMv9O2DwLzFRQ4oBlFV8jkbW7UcWP38ktwEzky5481l+ahdbBiZ0hR6Gts4BckV
         DJrT4BTu4CFm4OArr75Je+ix6E1nOjHBEsFCqFfad1309uQJLOXtUfxMVpoIheQrMMqy
         TS+NZH4fRaMfYGtN0JR5WPj/NVfFGOyNGx8GI5mpWACxiB141SQOJQtdHyq94c2gRGbA
         RHh5ikf2ZXAnkUJ4V2OV/bos7Q9Ys5Rf5SsFFIIVt+n1rIrsvqn8EWQ0i9BvCkvRpFxm
         jtQBbzR/fv5YrWincHStI4jRz8RiEm95B2YysJo3x2G3d2G0eFYAFc8s6aeFG7oB+Fqk
         CLbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773686490; x=1774291290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGq9WjFn8Xvcp6TfAGJrrctyuJyQnFDbgZnxO6QRELQ=;
        b=KMg/N/bsc0tc4qPvngpt5T9BPxFdJoKyLHwkB2lZ6dnus2Qy0ftm5w7J09xmvwkDF3
         8/zR/N2uuo5hVQXSIwiV/mhuDJQLtji2qNKtyPrEfPMHIhEzd0XGMeA2NQ9CbVqVj/3Y
         x1LDs37lDXLqRxsw7SnH56igHg4EnJMmzVfcixsNzgHeai1Ese9cyV7XiEmHNwU54ycP
         G1waqw4crPen4kcSoMLuhEH1m0v1LE+PCuVhaThswwfA0QBxBdPnNN65VB5qiNS5IOsO
         hR3F6+8F2A0DyrSeoBhncyO5BJnOuX36aplRk2ESOgQTlNSyEdQBZjldF7BsBZ4nhoPS
         kfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773686490; x=1774291290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BGq9WjFn8Xvcp6TfAGJrrctyuJyQnFDbgZnxO6QRELQ=;
        b=EE8P4hsQWnM9+HVfsecXRf5YV0RDUXRO5HlM/EfQfX0AbSMY7VdBXXs7Zqr+rnWfor
         1cPQ2S+XVGsWj85PIaK/ah83CLBkqF/0IB4vjMpBVez4Yv6oAaKLiDBGbbYtajjTNQkT
         iHZCX1piky31rJwEamVeaTMXMoB5cWMAlHZumkJ7ISS0MsPjHvHAsNgzNiTfoxDKr5AK
         NSkJwQ1RSDtDtvnHaID4mdTMTCVMm4tnOVxhoi0esVtNX0CUsIKqXQwTm90YvL3ovymF
         9lO4hrFKRNMJHL5Dj/jEKkS6b9ek6rivhaXnIXtPvewyWDXnPDzjqK0Gjy/anB0YPt+h
         e4RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu9Cu2cMW05lXGSrDu3d7Kv8qshA9yxSQotkdeSuY+DPp5yJAlH5Ijmf5CDuQqe1FxEtLh5QbMEjvAtlWJ7tXd@vger.kernel.org
X-Gm-Message-State: AOJu0YwfQHOQtUfvDzZ+MiqdRBPGkcKX+ptLjH3EeZ7qWLyvqk/Gka8k
	DxBNDEwoT2pL6wmIv+ygQzZYiKDed4NmKObBOnLpTLM7IbfQG+O5+HJZ1y+Tsix5APQshYhdcLm
	sOla04x5+NIhfgKF29TrD2xCd0mpuHSj6SNU7tmte
X-Gm-Gg: ATEYQzzSb8EIMVZHXwTkvTrT57i6b1HG2+L5U651hCcp+adDg1Ca1Nv+haOFHUM53Cf
	5wv2kqdPUgHBPE+X6FZIpNXCcGCkuCofNeYBTJnHGee6qSjfZ3Hk0YMwq6Eaj5QL9VoTHp6lZLJ
	roJL+o6uRpoJJ60P5sbvOy9QeeAQ3biXFVEMD10EHI2AZJac4LT+PqsP9Zy7VY9EyoGyppBXywr
	xQ6MI8vbzttVs3xZVTo+Qoy/XWJjjbqOE86Yir8JRGPtjArc7VIrpgqmccLuIBPRQIFTdMbruPX
	cYxIiKc6
X-Received: by 2002:a17:902:ffd0:b0:2ae:44db:570c with SMTP id
 d9443c01a7336-2b064031934mr384665ad.12.1773686489686; Mon, 16 Mar 2026
 11:41:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312061628.1593105-1-irogers@google.com> <20260313202811.2599195-1-irogers@google.com>
 <20260313202811.2599195-4-irogers@google.com> <6e9e5208-3e92-48f4-81fb-d37e5c0080ae@linux.ibm.com>
In-Reply-To: <6e9e5208-3e92-48f4-81fb-d37e5c0080ae@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 16 Mar 2026 11:41:18 -0700
X-Gm-Features: AaiRm52-3ug2n1KLgjLv1DNqR6u3NJsqcv7a_aRKcdSalvStgexEVJUj2mDGg7k
Message-ID: <CAP-5=fU9SJu=x2+aKTV4eXXLVv77SbtBr0shDLTfWw9eByYZ4Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] perf evlist: Improve default event for s390
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	namhyung@kernel.org, sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 5:13=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> On 3/13/26 21:28, Ian Rogers wrote:
> > Frame pointer callchains are not supported on s390 and dwarf
> > callchains are only supported on software events.
> >
> > Switch the default event from cycles to cpu-clock or task-clock on
> > s390 if callchains are enabled.
> >
> > If frame pointer callchains are requested on s390, warn and switch to
> > dwarf callchains.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-record.c      |  3 ++-
> >  tools/perf/builtin-top.c         |  2 +-
> >  tools/perf/tests/event_update.c  |  4 +++-
> >  tools/perf/tests/expand-cgroup.c |  4 +++-
> >  tools/perf/tests/perf-record.c   |  7 ++++--
> >  tools/perf/tests/topology.c      |  4 +++-
> >  tools/perf/util/evlist.c         | 37 +++++++++++++++++++-------------
> >  tools/perf/util/evlist.h         |  2 +-
> >  tools/perf/util/evsel.c          | 11 ++++++++--
> >  9 files changed, 49 insertions(+), 25 deletions(-)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 60d764068302..07ecc8a5fec7 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -4310,7 +4310,8 @@ int cmd_record(int argc, const char **argv)
> >               record.opts.tail_synthesize =3D true;
> >
> >       if (rec->evlist->core.nr_entries =3D=3D 0) {
> > -             struct evlist *def_evlist =3D evlist__new_default();
> > +             struct evlist *def_evlist =3D evlist__new_default(&rec->o=
pts.target,
> > +                                                             callchain=
_param.enabled);
> >
> >               if (!def_evlist)
> >                       goto out;
> > diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> > index 710604c4f6f6..58bab595b024 100644
> > --- a/tools/perf/builtin-top.c
> > +++ b/tools/perf/builtin-top.c
> > @@ -1695,7 +1695,7 @@ int cmd_top(int argc, const char **argv)
> >               goto out_delete_evlist;
> >
> >       if (!top.evlist->core.nr_entries) {
> > -             struct evlist *def_evlist =3D evlist__new_default();
> > +             struct evlist *def_evlist =3D evlist__new_default(target,=
 callchain_param.enabled);
> >
> >               if (!def_evlist)
> >                       goto out_delete_evlist;
> > diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_u=
pdate.c
> > index cb9e6de2e033..facc65e29f20 100644
> > --- a/tools/perf/tests/event_update.c
> > +++ b/tools/perf/tests/event_update.c
> > @@ -8,6 +8,7 @@
> >  #include "header.h"
> >  #include "machine.h"
> >  #include "util/synthetic-events.h"
> > +#include "target.h"
> >  #include "tool.h"
> >  #include "tests.h"
> >  #include "debug.h"
> > @@ -81,7 +82,8 @@ static int test__event_update(struct test_suite *test=
 __maybe_unused, int subtes
> >  {
> >       struct evsel *evsel;
> >       struct event_name tmp;
> > -     struct evlist *evlist =3D evlist__new_default();
> > +     struct target target =3D {};
> > +     struct evlist *evlist =3D evlist__new_default(&target, /*sample_c=
allchains=3D*/false);
> >
> >       TEST_ASSERT_VAL("failed to get evlist", evlist);
> >
> > diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand=
-cgroup.c
> > index c7b32a220ca1..dd547f2f77cc 100644
> > --- a/tools/perf/tests/expand-cgroup.c
> > +++ b/tools/perf/tests/expand-cgroup.c
> > @@ -8,6 +8,7 @@
> >  #include "parse-events.h"
> >  #include "pmu-events/pmu-events.h"
> >  #include "pfm.h"
> > +#include "target.h"
> >  #include <subcmd/parse-options.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> > @@ -99,7 +100,8 @@ out:       for (i =3D 0; i < nr_events; i++)
> >  static int expand_default_events(void)
> >  {
> >       int ret;
> > -     struct evlist *evlist =3D evlist__new_default();
> > +     struct target target =3D {};
> > +     struct evlist *evlist =3D evlist__new_default(&target, /*sample_c=
allchains=3D*/false);
> >
> >       TEST_ASSERT_VAL("failed to get evlist", evlist);
> >
> > diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-rec=
ord.c
> > index efbd9cd60c63..c6e31ab8a6b8 100644
> > --- a/tools/perf/tests/perf-record.c
> > +++ b/tools/perf/tests/perf-record.c
> > @@ -84,8 +84,11 @@ static int test__PERF_RECORD(struct test_suite *test=
 __maybe_unused, int subtest
> >       CPU_ZERO_S(cpu_mask_size, cpu_mask);
> >
> >       perf_sample__init(&sample, /*all=3D*/false);
> > -     if (evlist =3D=3D NULL) /* Fallback for kernels lacking PERF_COUN=
T_SW_DUMMY */
> > -             evlist =3D evlist__new_default();
> > +     if (evlist =3D=3D NULL) { /* Fallback for kernels lacking PERF_CO=
UNT_SW_DUMMY */
> > +             struct target target =3D {};
> > +
> > +             evlist =3D evlist__new_default(&target, /*sample_callchai=
ns=3D*/false);
> > +     }
> >
> >       if (evlist =3D=3D NULL) {
> >               pr_debug("Not enough memory to create evlist\n");
> > diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
> > index ec01150d208d..a34a7ab19a80 100644
> > --- a/tools/perf/tests/topology.c
> > +++ b/tools/perf/tests/topology.c
> > @@ -9,6 +9,7 @@
> >  #include "evlist.h"
> >  #include "debug.h"
> >  #include "pmus.h"
> > +#include "target.h"
> >  #include <linux/err.h>
> >
> >  #define TEMPL "/tmp/perf-test-XXXXXX"
> > @@ -37,11 +38,12 @@ static int session_write_header(char *path)
> >               .path =3D path,
> >               .mode =3D PERF_DATA_MODE_WRITE,
> >       };
> > +     struct target target =3D {};
> >
> >       session =3D perf_session__new(&data, NULL);
> >       TEST_ASSERT_VAL("can't get session", !IS_ERR(session));
> >
> > -     session->evlist =3D evlist__new_default();
> > +     session->evlist =3D evlist__new_default(&target, /*sample_callcha=
ins=3D*/false);
> >       TEST_ASSERT_VAL("can't get evlist", session->evlist);
> >       session->evlist->session =3D session;
> >
> > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > index 591bdf0b3e2a..e6c518cc4a69 100644
> > --- a/tools/perf/util/evlist.c
> > +++ b/tools/perf/util/evlist.c
> > @@ -13,6 +13,7 @@
> >  #include "util/mmap.h"
> >  #include "thread_map.h"
> >  #include "target.h"
> > +#include "dwarf-regs.h"
> >  #include "evlist.h"
> >  #include "evsel.h"
> >  #include "record.h"
> > @@ -98,38 +99,44 @@ struct evlist *evlist__new(void)
> >       return evlist;
> >  }
> >
> > -struct evlist *evlist__new_default(void)
> > +struct evlist *evlist__new_default(const struct target *target, bool s=
ample_callchains)
> >  {
> >       struct evlist *evlist =3D evlist__new();
> >       bool can_profile_kernel;
> >       struct perf_pmu *pmu =3D NULL;
> > +     struct evsel *evsel;
> > +     char buf[256];
> > +     int err;
> >
> >       if (!evlist)
> >               return NULL;
> >
> >       can_profile_kernel =3D perf_event_paranoid_check(1);
> >
> > -     while ((pmu =3D perf_pmus__scan_core(pmu)) !=3D NULL) {
> > -             char buf[256];
> > -             int err;
> > -
> > -             snprintf(buf, sizeof(buf), "%s/cycles/%s", pmu->name,
> > +     if (EM_HOST =3D=3D EM_S390 && sample_callchains) {
> > +             snprintf(buf, sizeof(buf), "software/%s/%s",
> > +                      target__has_cpu(target) ? "cpu-clock" : "task-cl=
ock",
> >                        can_profile_kernel ? "P" : "Pu");
> >               err =3D parse_event(evlist, buf);
> > -             if (err) {
> > -                     evlist__delete(evlist);
> > -                     return NULL;
> > +             if (err)
> > +                     goto out_err;
> > +     } else {
> > +             while ((pmu =3D perf_pmus__scan_core(pmu)) !=3D NULL) {
> > +                     snprintf(buf, sizeof(buf), "%s/cycles/%s", pmu->n=
ame,
> > +                             can_profile_kernel ? "P" : "Pu");
> > +                     err =3D parse_event(evlist, buf);
> > +                     if (err)
> > +                             goto out_err;
> >               }
> >       }
> >
> > -     if (evlist->core.nr_entries > 1) {
> > -             struct evsel *evsel;
> > -
> > -             evlist__for_each_entry(evlist, evsel)
> > -                     evsel__set_sample_id(evsel, /*can_sample_identifi=
er=3D*/false);
> > -     }
> > +     evlist__for_each_entry(evlist, evsel)
> > +             evsel__set_sample_id(evsel, /*can_sample_identifier=3D*/f=
alse);
> >
> >       return evlist;
> > +out_err:
> > +     evlist__delete(evlist);
> > +     return NULL;
> >  }
> >
> >  struct evlist *evlist__new_dummy(void)
> > diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> > index d17c3b57a409..e507f5f20ef6 100644
> > --- a/tools/perf/util/evlist.h
> > +++ b/tools/perf/util/evlist.h
> > @@ -104,7 +104,7 @@ struct evsel_str_handler {
> >  };
> >
> >  struct evlist *evlist__new(void);
> > -struct evlist *evlist__new_default(void);
> > +struct evlist *evlist__new_default(const struct target *target, bool s=
ample_callchains);
> >  struct evlist *evlist__new_dummy(void);
> >  void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
> >                 struct perf_thread_map *threads);
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index bd14d9bbc91f..caa95dc06ac5 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -1020,6 +1020,13 @@ static void __evsel__config_callchain(struct evs=
el *evsel, struct record_opts *o
> >  {
> >       bool function =3D evsel__is_function_event(evsel);
> >       struct perf_event_attr *attr =3D &evsel->core.attr;
> > +     enum perf_call_graph_mode record_mode =3D param->record_mode;
> > +
> > +     if (EM_HOST =3D=3D EM_S390 && param->record_mode =3D=3D CALLCHAIN=
_FP) {
> > +             pr_warning("Framepointer unwinding switched to dwarf due =
to a lack of kernel support.\n"
> > +                        "Use '--call-graph dwarf' to silence this warn=
ing.\n");
> > +             record_mode =3D CALLCHAIN_DWARF;
> > +     }
> >
> >       evsel__set_sample_bit(evsel, CALLCHAIN);
> >
> > @@ -1029,7 +1036,7 @@ static void __evsel__config_callchain(struct evse=
l *evsel, struct record_opts *o
> >               attr->exclude_callchain_user =3D 1;
> >       if (opts->user_callchains)
> >               attr->exclude_callchain_kernel =3D 1;
> > -     if (param->record_mode =3D=3D CALLCHAIN_LBR) {
> > +     if (record_mode =3D=3D CALLCHAIN_LBR) {
> >               if (!opts->branch_stack) {
> >                       if (attr->exclude_user) {
> >                               pr_warning("LBR callstack option is only =
available "
> > @@ -1048,7 +1055,7 @@ static void __evsel__config_callchain(struct evse=
l *evsel, struct record_opts *o
> >                                   "Falling back to framepointers.\n");
> >       }
> >
> > -     if (param->record_mode =3D=3D CALLCHAIN_DWARF) {
> > +     if (record_mode =3D=3D CALLCHAIN_DWARF) {
> >               if (!function) {
> >                       uint16_t e_machine =3D evsel__e_machine(evsel, /*=
e_flags=3D*/NULL);
> >
>
> Ian, Thanks very much.
>
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>
>
> The fall back to cpu-clock works nicely when --call-graph or -g is specif=
ied on s390.

Thanks Thomas. Some legitimate issues were flagged in the automated AI
review so I'll need to do a v4. Unfortunately it will need testing
again.
https://sashiko.dev/#/patchset/20260313202811.2599195-1-irogers%40google.co=
m

Thanks,
Ian

> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, German=
y
> --
> IBM Deutschland Research & Development GmbH
>
> Vorsitzender des Aufsichtsrats: Wolfgang Wendt
>
> Gesch=C3=A4ftsf=C3=BChrung: David Faller
>
> Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stut=
tgart, HRB 243294
