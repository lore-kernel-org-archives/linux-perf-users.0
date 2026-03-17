Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7AC2BEC52
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773762860; cv=pass; b=g3/LcBn3/ILJDq4iEzijznb93EkI+NIPrBiiw01VBqJ3trm08zA60XDmUWUD05B+ZbbYnEoB9MN3eD0II5dz/Culd98eQ6gOBVTbPDPHF4RnrHbv8LCtRXC79fzCNeX0lh+Pt/HfpNgr1eUXBkExxy9tyac61HUXO+oyLZfoKuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773762860; c=relaxed/simple;
	bh=EgaeRZV3LRo+1wkO0Lbg8F1y9AQIVyAGrmFgmyrQ6bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ezSJrfD2qrihF/AVhSR3WW9d9024B/3N4U9wTTMEe14cfMtIk1RynwX08i38aNl89ny6Z0hwoSNYSYnyBE/yVC9j8fMCQXnBCZ2P2my6rAkwNHRRi51qDZiQrH7X1hs1nuTCBTVVQzi28ID3zMZ/6e+4ChIPC1AY8ERZI+Ef0PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GgFUK4ot; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GgFUK4ot"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aeab6ff148so93075ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 08:54:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773762858; cv=none;
        d=google.com; s=arc-20240605;
        b=cA30sHyZEelX7LIzWCe0Vl9a/1LaDR3E2GxZbg+17EWxMT53RsBwx48KKRioe4VPh3
         nml5rra1bri5TWY47SaFx0MVqUTs6Ms24/eJB92nvLRqpQNe80+ZKVq+J289942k6Frx
         wC7ocUX+BcOrZwlsZF5X+diG6Qq/wSF4i4VS33IDrQOLRoO3+nfJDuB0UDzGVLVeZuI4
         0MC9HsMXV2gh8dKyYpSmzEPEuQ3ajDmCWIi2nlYzOcRx7thKmwu/xqG1HMXkPo033V04
         eOzwSMJ0ovWv0KCkkyI5aHfwG31XNFlXHKdUdA6bgpTnf6hkTxCRcBx4/bYtF27G/LLu
         j5qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3CXPUxEdwVwy9Z1yf6AsLUnB9r6CrpAEGv+lPnIFWtQ=;
        fh=I4DSMOrshDi3F3amAgXMSc5fkWMyjFHtVQadPUVYwfg=;
        b=PK/Jb7Wk8KRkHnmQJz3kpY3ZEqCgvW9MCtHjqFpOfwF2EykPrTrizpx0kiZe+sSSvA
         AX2XaxTTXSQo8gpPU+HkuEVhoozN3kw003cbLUKifFuhgw+emMqc3XBFJHJd++XiajsB
         8ypH0KBSQUU1IXsINS24QxqgzwYL5W2RSl1hXke2WrefRsIk1orOXr51/hrZRdXUZ4zp
         CDSdE8K0Rkc49JnVTx/88fh3XnWmeFgddfTdVAUVcWIjggNo/bngvU41T47NhkbKbbNI
         rhMBgmH4dInWWQ7/tcQXYAuOA7pg/jcrLsr68BaXLir2EaZZfhCkm5y+nTLtvTtB6oHC
         8tIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773762858; x=1774367658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CXPUxEdwVwy9Z1yf6AsLUnB9r6CrpAEGv+lPnIFWtQ=;
        b=GgFUK4otsnVHOcxyPIoLrpJXZGZMwPKkmIXMaJZ2qoHC4uf6YH08OXd+jT2wnD1Ws6
         HQcxs/FfURDtyAzJhCGgf3/0v5fgI9KhvO0OZshFCt4XsaMZsC/pzJf7KtkL5sluso/D
         +iCyDuoj/+tmUg1Sq0cwLMWqfnweaSSlObGo2W/I+SvbQQVtHw81gnYzVGFGZzkIIAZO
         E82gs0L8ZwZ2+HunD8Q0C35JqvAkP0oW4E034OsZbz8znyKuM8kcwLVpaJLZ8/zVsaB7
         wfhTZQfW638tY3wUK0A+u64IGSJM5i91JkJ0ifKpdkvQt9VPC5lwoKDDNRo4xCYJbHo4
         wxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773762858; x=1774367658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3CXPUxEdwVwy9Z1yf6AsLUnB9r6CrpAEGv+lPnIFWtQ=;
        b=cj34etVhLHbbLueVAB/YlmYfUSxuPAV4GcqC3vEaRSYSkdC9hZFapWlGpntmZIWh5l
         g4DBwH4fy5t/9e4BZ34sJ2oAC0drGMa5BTMQtMdrDvlkO0WzyOExXs2gX37eDhmpymKB
         tQlfJvt9HDl0OqYMyIBZBbh9V8OYCeyCw/vaUZddEXxAQ9gk3VDNVst8pPoGteN/JFEt
         WBl1iqxXK4+TWwa9ZzHiebTuy6CubrJ2zdmlg3YIw/ItigKbECgQJoyRszdP0BIzzFyL
         13pvCWScgPpYBiAtWPwCf5x1YmAaF6Kq7PtH0HeV0A/TG2Iv2EPqzYhEjqc0d0RDyJhs
         sF8w==
X-Forwarded-Encrypted: i=1; AJvYcCXaTd4iLm+JuiqS4tzKdsMqd6IESU0jt0cec5AKsQS6k0QlmWHq/zntnLxHSDqf2HO2D3sKw3F+UlVif9zSgwnX@vger.kernel.org
X-Gm-Message-State: AOJu0YwVt5kHKWL8x/4JdZUW+Pg8GltzQuzE5Z8naFGXYvSXJbmlDvqK
	pc3zF0QFlsuG3FnjQp7Rq6EwyXuN07YOjVLFgXMLB4uM49LFvai+skzB2Ew43NN+fww2boUBCOw
	2VGedNHIC/rRRWER143vkegeZbkF0vBmqc+sA4D3M
X-Gm-Gg: ATEYQzzNFYTwmO2bxri/eCyUnBpzybFQfmraJ+9GqaWaXr1jS0b6gD75nfJ9TSO1IzH
	vOro7v4KUt1Pmoi1Tlp+gFxTvFx9tXDKGOFnC/ExtIvbEdw0LNl77Ud+VaOzx3gBswnfyNER5K3
	j4YOzjN8l+RSEIVMz1q9L/jsrK4Q+CKhE0slsNHsCgWi09yHWOZLE0FDV6jwFNaCF9MXqCLLTdM
	mDCk6MrFGsGBkWEP+yGM5igJk/4hg8NegJWHSBVqydY4yuA2jgzjSZipkDkAZJWCkZ5vhQzTYf+
	ZLZq7cQq
X-Received: by 2002:a17:902:d2ce:b0:2ad:6f9b:7817 with SMTP id
 d9443c01a7336-2b06404f4d7mr3607635ad.22.1773762857486; Tue, 17 Mar 2026
 08:54:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317030601.567422-1-irogers@google.com> <20260317055334.760347-1-irogers@google.com>
 <20260317055334.760347-6-irogers@google.com> <e8087f8c-09e8-4204-a9c9-fc635d0453b5@linux.ibm.com>
In-Reply-To: <e8087f8c-09e8-4204-a9c9-fc635d0453b5@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 17 Mar 2026 08:54:05 -0700
X-Gm-Features: AaiRm52avOLAiZnZ3J5B62XVMnRfz8UkdYzqqjx1HzKvlf7YDuV2U_HKP-Mfx38
Message-ID: <CAP-5=fUO8azimnOV2Ogb93nZ3eXnaLdGo6b+3wPVf0tMz29JqQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] perf evlist: Improve default event for s390
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	namhyung@kernel.org, sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 12:52=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.=
com> wrote:
>
> On 3/17/26 06:53, Ian Rogers wrote:
> > Frame pointer callchains are not supported on s390 and dwarf
> > callchains are only supported on software events.
> >
> > Switch the default event from cycles to cpu-clock or task-clock on
> > s390 if callchains are enabled.
> >
> > If frame pointer callchains are requested on s390 show a
> > warning. Modify the '-g' option of `perf top` and `perf record` to
> > default to dwarf callchains on s390.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-record.c      |  8 ++++++--
> >  tools/perf/builtin-top.c         |  5 +++--
> >  tools/perf/tests/event_update.c  |  4 +++-
> >  tools/perf/tests/expand-cgroup.c |  4 +++-
> >  tools/perf/tests/perf-record.c   |  7 +++++--
> >  tools/perf/tests/topology.c      |  4 +++-
> >  tools/perf/util/evlist.c         | 32 +++++++++++++++++++++-----------
> >  tools/perf/util/evlist.h         |  2 +-
> >  tools/perf/util/evsel.c          |  5 +++++
> >  9 files changed, 50 insertions(+), 21 deletions(-)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index af1fe6b7c65c..ef97c7a54088 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -55,6 +55,7 @@
> >  #include "asm/bug.h"
> >  #include "perf.h"
> >  #include "cputopo.h"
> > +#include "dwarf-regs.h"
> >
> >  #include <errno.h>
> >  #include <inttypes.h>
> > @@ -2986,7 +2987,9 @@ static int record_callchain_opt(const struct opti=
on *opt,
> >                               const char *arg __maybe_unused,
> >                               int unset)
> >  {
> > -     return record_opts__parse_callchain(opt->value, &callchain_param,=
 "fp", unset);
> > +     return record_opts__parse_callchain(opt->value, &callchain_param,
> > +                                         EM_HOST !=3D EM_S390 ? "fp" :=
 "dwarf",
> > +                                         unset);
> >  }
> >
> >
> > @@ -4265,7 +4268,8 @@ int cmd_record(int argc, const char **argv)
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
> > index 2a949d956d0b..84211a78977e 100644
> > --- a/tools/perf/builtin-top.c
> > +++ b/tools/perf/builtin-top.c
> > @@ -56,6 +56,7 @@
> >  #include "util/debug.h"
> >  #include "util/ordered-events.h"
> >  #include "util/pfm.h"
> > +#include "dwarf-regs.h"
> >
> >  #include <assert.h>
> >  #include <elf.h>
> > @@ -1409,7 +1410,7 @@ parse_callchain_opt(const struct option *opt, con=
st char *arg, int unset)
> >  static int
> >  callchain_opt(const struct option *opt, const char *arg __maybe_unused=
, int unset)
> >  {
> > -     return parse_callchain_opt(opt, "fp", unset);
> > +     return parse_callchain_opt(opt, EM_HOST !=3D EM_S390 ? "fp" : "dw=
arf", unset);
> >  }
> >
> >
> > @@ -1695,7 +1696,7 @@ int cmd_top(int argc, const char **argv)
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
> > index 591bdf0b3e2a..c702741a9173 100644
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
> > @@ -98,38 +99,47 @@ struct evlist *evlist__new(void)
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
> > +     /* If there is only 1 event a sample identifier isn't necessary. =
*/
> >       if (evlist->core.nr_entries > 1) {
> > -             struct evsel *evsel;
> > -
> >               evlist__for_each_entry(evlist, evsel)
> >                       evsel__set_sample_id(evsel, /*can_sample_identifi=
er=3D*/false);
> >       }
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
> > index 54c8922a8e47..5a294595a677 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -1021,6 +1021,11 @@ static void __evsel__config_callchain(struct evs=
el *evsel, const struct record_o
> >       bool function =3D evsel__is_function_event(evsel);
> >       struct perf_event_attr *attr =3D &evsel->core.attr;
> >
> > +     if (EM_HOST =3D=3D EM_S390 && param->record_mode =3D=3D CALLCHAIN=
_FP) {
> > +             pr_warning_once(
> > +                     "Framepointer unwinding lacks kernel support. Use=
 '--call-graph dwarf'\n");
> > +     }
> > +
> >       evsel__set_sample_bit(evsel, CALLCHAIN);
> >
> >       attr->sample_max_stack =3D param->max_stack;
>
> Great, here is the output on my LPAR. Thanks very much fpr addressing and=
 fixing this!!!
>
> root in =F0=9F=8C=90 b83lp69 in mirror-linux-next/tools/perf on =EE=82=A0=
 master [=E2=87=A1] via C v15.2.1-gcc took 2s
> =E2=9D=AF ./perf record  --call-graph dwarf  -- perf test -w noploop
> [ perf record: Woken up 133 times to write data ]
> [ perf record: Captured and wrote 32.928 MB perf.data (4039 samples) ]
>
> root in =F0=9F=8C=90 b83lp69 in mirror-linux-next/tools/perf on =EE=82=A0=
 master [=E2=87=A1] via C v15.2.1-gcc took 2s
> =E2=9D=AF ./perf evlist
> software/task-clock/P
>
> root in =F0=9F=8C=90 b83lp69 in mirror-linux-next/tools/perf on =EE=82=A0=
 master [=E2=87=A1] via C v15.2.1-gcc
> =E2=9D=AF ./perf record  -g -- perf test -w noploop
> [ perf record: Woken up 133 times to write data ]
> [ perf record: Captured and wrote 32.952 MB perf.data (4042 samples) ]
>
> root in =F0=9F=8C=90 b83lp69 in mirror-linux-next/tools/perf on =EE=82=A0=
 master [=E2=87=A1] via C v15.2.1-gcc took 2s
> =E2=9D=AF ./perf evlist
> software/task-clock/P
>
> root in =F0=9F=8C=90 b83lp69 in mirror-linux-next/tools/perf on =EE=82=A0=
 master [=E2=87=A1] via C v15.2.1-gcc
> =E2=9D=AF ./perf record  -- perf test -w noploop
> [ perf record: Woken up 2 times to write data ]
> [ perf record: Captured and wrote 0.179 MB perf.data (3974 samples) ]
>
> root in =F0=9F=8C=90 b83lp69 in mirror-linux-next/tools/perf on =EE=82=A0=
 master [=E2=87=A1] via C v15.2.1-gcc took 2s
> =E2=9D=AF ./perf evlist
> cpum_cf/cycles/P
>
> root in =F0=9F=8C=90 b83lp69 in mirror-linux-next/tools/perf on =EE=82=A0=
 master [=E2=87=A1] via C v15.2.1-gcc
> =E2=9D=AF ./perf record
> ^C[ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.250 MB perf.data (24 samples) ]
>
>
> root in =F0=9F=8C=90 b83lp69 in mirror-linux-next/tools/perf on =EE=82=A0=
 master [=E2=87=A1] via C v15.2.1-gcc took 3s
> =E2=9D=AF ./perf evlist
> cpum_cf/cycles/P
> dummy:u
>
> root in =F0=9F=8C=90 b83lp69 in mirror-linux-next/tools/perf on =EE=82=A0=
 master [=E2=87=A1] via C v15.2.1-gcc
> =E2=9D=AF ./perf record  -g
> ^C[ perf record: Woken up 8 times to write data ]
> [ perf record: Captured and wrote 5.186 MB perf.data (34255 samples) ]
>
>
> root in =F0=9F=8C=90 b83lp69 in mirror-linux-next/tools/perf on =EE=82=A0=
 master [=E2=87=A1] via C v15.2.1-gcc took 3s
> =E2=9D=AF ./perf evlist
> software/cpu-clock/P
> dummy:u
>
>
> root in =F0=9F=8C=90 b83lp69 in mirror-linux-next/tools/perf on =EE=82=A0=
 master [=E2=87=A1] via C v15.2.1-gcc took 3s
>
> Tested-by:  Thomas Richter <tmricht@linux.ibm.com>

Thanks Thomas! I'll add the tag into the next version. Why a new
version? I'm trying to appease sashiko that is rightly flagging more
issues:
https://sashiko.dev/#/patchset/20260317055334.760347-1-irogers%40google.com

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
