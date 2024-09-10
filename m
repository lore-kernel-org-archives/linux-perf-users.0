Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9633514F12C
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Sep 2024 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725983978; cv=none; b=k/jN5KJZrc/FG1/nlnN074pSibvmWz/t8feLwzFsSuFo/N8vjjh6OzNWHQnOIPjvMqEK05TM/vSqZ7n6M7Dir4RhWBP0ubfxOqqwoB0rg8mtMJ/Cdfc8NxVfn2L+kZvCQ1kPbuIh41DyqteVjCL7DFyzTGLweq1Y25YAYuWIiXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725983978; c=relaxed/simple;
	bh=V99WNH5dOmvSNnSF/BmHZyT/GRd0NVPuBJ1LTz6DTms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzSXKThzR3A5s2/7sPQ+bXGypsKZj+Gzfai1Wlldt7ChG1v046Kimotk5kV+qjGGHKEcEeh41tJsrypFCTKB8AItBM3FnB1xpsRC85xh6Iqjy2TXXhAf7Cqar9Zq9vtn55GN5bVjtco6JItJxnDsi0iz6XJ1kHF778FSwksXhNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=idQKLcS+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="idQKLcS+"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-207349fa3d7so188195ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Sep 2024 08:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725983976; x=1726588776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/pQ6A+pcYJ6D1seY7AqA3NxJXg0QF/AHpSLfCgBJF0=;
        b=idQKLcS+dlJNE3k3VE42TXa8FwdvmTjl+MJBFBeMLkdRYIoj/4TNWmmmAY8kLY9Q2b
         hVC9RTOdjtlxHK00OD2HalpoXzasK0pD5LA76150meMEK8y4Jc3Kg/jF13nF8MwKX/h+
         B4Ief4WzXgvuH+NPJ5+rmaLFxvSuU7R22iwH7Zcj18GEN3J/i0b8oRKIGMbC5TOvq8mu
         U5CTHSqA6QPCl0oKhwjT5ljN5Tfvmvb0wpQz54/tezsn83XZ4n2mQ7XcdP9auFrSmmDS
         0R4e5mzjXGblg9lzn+r9X47VjGVDWoFSQQgZx5biQ3yAPRhn7razhE7hHLoKdfewwp5z
         gtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725983976; x=1726588776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/pQ6A+pcYJ6D1seY7AqA3NxJXg0QF/AHpSLfCgBJF0=;
        b=MaLhclRWHVpG8iJeiykR8aQ8AQLrMguZc+5qEcMY1dhT48/MTORCVHzfpw4a3ma1q9
         SK7cLTbR6rrZ3+SPs4r+QryUwk3pCyIWSV7IeJW2zQt+bo0iSyEiV9glFyWvZLEP8Mcx
         swYCnYC0PnEJ68NyiITEK5HG1hHATRqpXUKiO3D5vSPFML7UavaPO1xDJgFm2jMV2WVA
         EagcmzY/kqTC0iP/p0UnzZDNaUsrmtxFHmq3ZCl5Z58Y6F4VFz4HTxjpwtdDP9WlYO/V
         BKqrgokExwUQ6jjz37fONMVkprdQcxmhD/9nSyw+fzaJqxfWdx+N8sYwkaVQHPFVcYlg
         N5Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXJnenufFePv3n7CAjYd8qfHMHKD1xg5EaG3zE/xgMzaTjAohhCME/LVeFfZ33zeQOHoS5K+Nv6DESj4EIPjQer@vger.kernel.org
X-Gm-Message-State: AOJu0YxtcsA5dW2FwWhqs6ravgWeP13JkhS4xUquYkZifDnsEVEi1OiE
	Q7i0D+bnSoTLYXSPC0oZjbOe3iHlbBsRWh1rt2nqKbQzPzQt0jQ7Kc0wD9vnpFATHjay1dcnh/+
	4FF59jO6EDeGKPetGMsPQAwOypqfjoH9QMhJC
X-Google-Smtp-Source: AGHT+IHRCPEz5/BbFDmFo23Gi8jP7WaCaP46OvR/6hySAeelq879cijbQ/h4qP+7bgQO4s0dbhmIgkTf4d+zhILMM0I=
X-Received: by 2002:a17:902:fa10:b0:205:6c5f:e3ac with SMTP id
 d9443c01a7336-2074c646bc1mr1059585ad.19.1725983975114; Tue, 10 Sep 2024
 08:59:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240907050830.6752-1-irogers@google.com> <20240907050830.6752-14-irogers@google.com>
 <Zt_eOhg7I81oGeo2@google.com>
In-Reply-To: <Zt_eOhg7I81oGeo2@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 10 Sep 2024 08:59:23 -0700
Message-ID: <CAP-5=fXRY=ATVqnCpkyBJjgrQsb03jFwU6Knje2easrWb7j0bQ@mail.gmail.com>
Subject: Re: [PATCH v1 13/15] perf tests: Add tool PMU test
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Weilin Wang <weilin.wang@intel.com>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yang Jihong <yangjihong@bytedance.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Changbin Du <changbin.du@huawei.com>, 
	Ze Gao <zegao2021@gmail.com>, Andi Kleen <ak@linux.intel.com>, 
	=?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, Junhao He <hejunhao3@huawei.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Yicong Yang <yangyicong@hisilicon.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 10:50=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Sep 06, 2024 at 10:08:28PM -0700, Ian Rogers wrote:
> > Ensure parsing with and without PMU creates events with the expected
> > config values. This ensures the tool.json doesn't get out of sync with
> > tool_pmu_event enum.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/Build          |   1 +
> >  tools/perf/tests/builtin-test.c |   1 +
> >  tools/perf/tests/tests.h        |   1 +
> >  tools/perf/tests/tool_pmu.c     | 111 ++++++++++++++++++++++++++++++++
> >  4 files changed, 114 insertions(+)
> >  create mode 100644 tools/perf/tests/tool_pmu.c
> >
> > diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> > index 5671ee530019..a771e4928247 100644
> > --- a/tools/perf/tests/Build
> > +++ b/tools/perf/tests/Build
> > @@ -67,6 +67,7 @@ perf-test-y +=3D sigtrap.o
> >  perf-test-y +=3D event_groups.o
> >  perf-test-y +=3D symbols.o
> >  perf-test-y +=3D util.o
> > +perf-test-y +=3D tool_pmu.o
> >
> >  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
> >  perf-test-$(CONFIG_DWARF_UNWIND) +=3D dwarf-unwind.o
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin=
-test.c
> > index 470a9709427d..3b30f258c395 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -73,6 +73,7 @@ static struct test_suite *generic_tests[] =3D {
> >       &suite__PERF_RECORD,
> >       &suite__pmu,
> >       &suite__pmu_events,
> > +     &suite__tool_pmu,
> >       &suite__dso_data,
> >       &suite__perf_evsel__roundtrip_name_test,
> >  #ifdef HAVE_LIBTRACEEVENT
> > diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> > index 6ea2be86b7bf..1ed76d4156b6 100644
> > --- a/tools/perf/tests/tests.h
> > +++ b/tools/perf/tests/tests.h
> > @@ -83,6 +83,7 @@ DECLARE_SUITE(perf_evsel__tp_sched_test);
> >  DECLARE_SUITE(syscall_openat_tp_fields);
> >  DECLARE_SUITE(pmu);
> >  DECLARE_SUITE(pmu_events);
> > +DECLARE_SUITE(tool_pmu);
> >  DECLARE_SUITE(attr);
> >  DECLARE_SUITE(dso_data);
> >  DECLARE_SUITE(dso_data_cache);
> > diff --git a/tools/perf/tests/tool_pmu.c b/tools/perf/tests/tool_pmu.c
> > new file mode 100644
> > index 000000000000..94d0dd8fd3cb
> > --- /dev/null
> > +++ b/tools/perf/tests/tool_pmu.c
> > @@ -0,0 +1,111 @@
> > +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> > +#include "debug.h"
> > +#include "evlist.h"
> > +#include "parse-events.h"
> > +#include "tests.h"
> > +#include "tool_pmu.h"
> > +
> > +static int do_test(enum tool_pmu_event ev, bool with_pmu)
> > +{
> > +     struct evlist *evlist =3D evlist__new();
> > +     struct evsel *evsel;
> > +     struct parse_events_error err;
> > +     int ret;
> > +     char str[128];
> > +     bool found =3D false;
> > +
> > +     if (!evlist) {
> > +             pr_err("evlist allocation failed\n");
> > +             return TEST_FAIL;
> > +     }
> > +
> > +     if (with_pmu)
> > +             snprintf(str, sizeof(str), "tool/%s/", tool_pmu__event_to=
_str(ev));
> > +     else
> > +             strncpy(str, tool_pmu__event_to_str(ev), sizeof(str));
> > +
> > +     parse_events_error__init(&err);
> > +     ret =3D parse_events(evlist, str, &err);
> > +     if (ret) {
> > +             evlist__delete(evlist);
> > +             if (tool_pmu__skip_event(tool_pmu__event_to_str(ev))) {
> > +                     ret =3D TEST_OK;
> > +                     goto out;
> > +             }
> > +
> > +             pr_debug("FAILED %s:%d failed to parse event '%s', err %d=
\n",
> > +                      __FILE__, __LINE__, str, ret);
> > +             parse_events_error__print(&err, str);
> > +             ret =3D TEST_FAIL;
> > +             goto out;
> > +     }
> > +
> > +     ret =3D TEST_OK;
> > +     if (with_pmu ? (evlist->core.nr_entries !=3D 1) : (evlist->core.n=
r_entries < 1)) {
> > +             pr_debug("FAILED %s:%d Unexpected number of events for '%=
s' of %d\n",
> > +                      __FILE__, __LINE__, str, evlist->core.nr_entries=
);
> > +             ret =3D TEST_FAIL;
> > +             goto out;
> > +     }
> > +
> > +     evlist__for_each_entry(evlist, evsel) {
> > +             if (perf_pmu__is_tool(evsel->pmu)) {
> > +                     if (evsel->core.attr.config !=3D ev) {
> > +                             pr_debug("FAILED %s:%d Unexpected config =
for '%s', %lld !=3D %d\n",
> > +                                     __FILE__, __LINE__, str, evsel->c=
ore.attr.config, ev);
> > +                             ret =3D TEST_FAIL;
> > +                             goto out;
> > +                     }
> > +                     found =3D true;
> > +             }
> > +     }
> > +
> > +     if (!found && !tool_pmu__skip_event(tool_pmu__event_to_str(ev))) =
{
> > +             pr_debug("FAILED %s:%d Didn't find tool event '%s' in par=
sed evsels\n",
> > +                      __FILE__, __LINE__, str);
> > +             ret =3D TEST_FAIL;
> > +     }
> > +
> > +out:
> > +     evlist__delete(evlist);
> > +     return ret;
> > +}
> > +
> > +static int test__tool_pmu_without_pmu(struct test_suite *test __maybe_=
unused,
> > +                                   int subtest __maybe_unused)
> > +{
> > +     int i;
> > +
> > +     tool_pmu__for_each_event(i) {
> > +             int ret =3D do_test(i, /*with_pmu=3D*/false);
> > +
> > +             if (ret !=3D TEST_OK)
> > +                     return ret;
> > +     }
> > +     return TEST_OK;
> > +}
> > +
> > +static int test__tool_pmu_with_pmu(struct test_suite *test __maybe_unu=
sed,
> > +                                int subtest __maybe_unused)
> > +{
> > +     int i;
> > +
> > +     tool_pmu__for_each_event(i) {
> > +             int ret =3D do_test(i, /*with_pmu=3D*/true);
> > +
> > +             if (ret !=3D TEST_OK)
> > +                     return ret;
> > +     }
> > +     return TEST_OK;
> > +}
> > +
> > +static struct test_case tests__tool_pmu[] =3D {
> > +     TEST_CASE("Parsing without PMU name", tool_pmu_without_pmu),
> > +     TEST_CASE("Parsing with PMU name", tool_pmu_with_pmu),
> > +     {       .name =3D NULL, }
>
> An unusual indentation.

Agreed. It matches the other tests though:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/mmap-basic.c?h=3Dperf-tools-next#n303
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/pmu.c?h=3Dperf-tools-next#n539
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/tests/parse-events.c?h=3Dperf-tools-next#n2876

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +};
> > +
> > +struct test_suite suite__tool_pmu =3D {
> > +     .desc =3D "Tool PMU",
> > +     .test_cases =3D tests__tool_pmu,
> > +};
> > --
> > 2.46.0.469.g59c65b2a67-goog
> >
