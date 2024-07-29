Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ED9148FEC;
	Mon, 29 Jul 2024 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722259780; cv=none; b=VipvBR6iDizzx/8CeT/ZZFszpPcCZrLraAgXK6AH62CqMftSLKx+lwiUF53MFzJSunpJyEzukatF+CXI4YHbx1wEvJgc2mFRgbWkzsuwIFtxruKIfty/JwaktgPP3WawP3yQBdnba/OdyZdtRUsEuJdcgv5jCdOvcj8IR0RJLFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722259780; c=relaxed/simple;
	bh=FTROBxRRAkk3tPwT0yLeA9Qd/Y9mYEvCDTDLWetDzgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7t7LRianUVXWVJtLYOUIjsIRplefHMN2LH2A9Qmqu+NtzLzpl4cxD7z5fhdWfsnhA5ke7c6RbA0ITfVbx76+o2tOCDPIMvhYiMvHTwqcy/sH6K2HcxOtx1RvePcrvWHcnX0TUjoursp4fjn/s/O5/p2j4RCDzWS3lIDzGdRjXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1ONsvWh; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1ONsvWh"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e08724b2a08so2065359276.1;
        Mon, 29 Jul 2024 06:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722259778; x=1722864578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1UFgN3Qz29rVihW4ffo2kFZjFPhl/pKrSqSLGvFCu8=;
        b=V1ONsvWhbG7+D96N57ygMB5BDmvHIpA/SSKtWp+DnibN8fXJ9MdZTa9prkXvfIBbFy
         y/NWfuhLe9IxSzjesWOFQrPru5AwDeHcjC0ssa62Vcm2VHyrkRr8c/cT4ZAdXrkJDD2T
         6C3QKuiEK8YyjRFrAqHRDmFCH+Ot5wBfEhaBohMwWS+mnHeD1hakqTeqmKYXxwpRPq+g
         aN5fTBX6cNOGyxzyS6hPN55i59zzTV8A8z7daf1JGyEzlikSd2pl4AbAXjPr3afKuj54
         fteXebvSvL4TGL5t30nQcQ1TQwxrrXej66c3/lxFk3BNQjlqSN4j5n0qMv6xGmX1T9cj
         GOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722259778; x=1722864578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A1UFgN3Qz29rVihW4ffo2kFZjFPhl/pKrSqSLGvFCu8=;
        b=GtdZWB9c+Tk0GeT+tppewwOQDvEyAm7dpJqfPC5fS/D0+JPrI6Rc+oOGTGmntqOo+2
         T6fanGJjBWKV+x5iwETWCI3RSlIahU7SKC/T1oy3lk6uurErpe1c2MvrOjq6ThjM6+X4
         1QMJACRljkc/mmjrI5KvavvKQNHehTxWRKQ9RyJIijj2o2HVbuatCwBNkK3EBaTqil8J
         JNwG2V6PhM1g22qZd7pnugpEuSoNuLdewm8v/03+E7tX7tFql1nZdcdpxeCcsZanbhmD
         6SCYtzMUeg0YQWaT9HuVw3qJUJfg4xSIgDTASZcrNcas8vvVtlR9G+4Ot8tH9ysck++M
         Qf1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWio05lOeTDn0tGrCCnx3T63Yv6T8g4pCFlK14jngyfKst76vEuN90fGt90EYHTZTFXEddUcnacC9gM9xxNn0GunzXiERVUM3OBqegCYD7vTBXReIsrJL8hvVrfGMg0o1ZJ9GePTKVMllyWqA722Q==
X-Gm-Message-State: AOJu0Yz+EA5i9+9WEmPrc843eEHWz/oWEU4SguOttUavxBFqqnaQoaqY
	GK56eoNMB04PvQck2awb4f23rINzm2ztQnmhB8GTnVBvYJAnNync4rRIu6nO7RbR7ZlaOswJNqt
	PsgF7eI3YQvGyjdBlPczRC9tbhIk=
X-Google-Smtp-Source: AGHT+IF9kntbFnkxVPI+THOLsDdUuZKcY2e0GCm6BCWjCKB0QjVjtmobWtrsmo7Cl9C2bmJxOPLBQRTNIhAMSwr8xKI=
X-Received: by 2002:a05:6902:2b88:b0:e03:5da3:905a with SMTP id
 3f1490d57ef6-e0b544403f3mr9445073276.13.1722259778090; Mon, 29 Jul 2024
 06:29:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726102826.787004-1-howardchu95@gmail.com>
 <20240726102826.787004-6-howardchu95@gmail.com> <CAP-5=fUztDHbZcwpT4VrXaGahH3k=B=uU-otv4tniJr=fazkFg@mail.gmail.com>
In-Reply-To: <CAP-5=fUztDHbZcwpT4VrXaGahH3k=B=uU-otv4tniJr=fazkFg@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Mon, 29 Jul 2024 21:29:27 +0800
Message-ID: <CAH0uvogWu+tQ37o2-OGHCVDL8wp7LuB+Sm1k4CWWfpHZ-6nCvg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] perf record off-cpu: Add direct off-cpu test
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, acme@kernel.org, adrian.hunter@intel.com, 
	jolsa@kernel.org, kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ian,

Thanks for reviewing this patch.

On Sat, Jul 27, 2024 at 8:54=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Jul 26, 2024 at 3:28=E2=80=AFAM Howard Chu <howardchu95@gmail.com=
> wrote:
> >
> > Add a simple workload(offcpu.c) to create the scenario for direct
> > off-cpu dumping.
> >
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > Suggested-by: Ian Rogers <irogers@google.com>
>
> I tried with and without --off-cpu-thresh=3D1 but I only see 1
> offcpu-time sample and no offcpu-time-direct.

TL;DR:

Please use 'perf record -F 1 -D 999 --off-cpu --off-cpu-thresh 1999
perf test -w offcpu' :)

We need to give it an initial delay, using '-D 999'.

That's because when using "perf record <workload>", evlist is not
enabled if you don't give it an initial delay or specify cpu. There
are two occurrences of evlist__enable() in builtin-record.c:

if (!target__none(&opts->target) && !opts->target.initial_delay)
    evlist__enable(rec->evlist);

Here, if you perf record a workload, say "perf record --off-cpu
--off-cpu-thresh=3D1 perf test -w offcpu", the
"!target__none(&opts->target)" will always be 0, so no enabling.

if (opts->target.initial_delay) {
    pr_info(EVLIST_DISABLED_MSG);
    if (opts->target.initial_delay > 0) {
        usleep(opts->target.initial_delay * USEC_PER_MSEC);
        evlist__enable(rec->evlist);
        pr_info(EVLIST_ENABLED_MSG);
    }
}

But we can do '-D 999' to give it an initial delay, so the evlist does
get enabled, now BPF can perf_event_output() a direct off-cpu sample
to the evlist. This is also the approach I used in the
'tests/shell/record_offcpu.sh'.
```
  if ! perf record -F 1 -D 999 --off-cpu --off-cpu-thresh 1999 -o
${perfdata} ${TEST_PROGRAM} 2> /dev/null
```

Thanks,
Howard
>
> Thanks,
> Ian
>
> > ---
> >  tools/perf/tests/builtin-test.c         |  1 +
> >  tools/perf/tests/shell/record_offcpu.sh | 29 +++++++++++++++++++++++++
> >  tools/perf/tests/tests.h                |  1 +
> >  tools/perf/tests/workloads/Build        |  1 +
> >  tools/perf/tests/workloads/offcpu.c     | 16 ++++++++++++++
> >  5 files changed, 48 insertions(+)
> >  create mode 100644 tools/perf/tests/workloads/offcpu.c
> >
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin=
-test.c
> > index c3d84b67ca8e..5062058ad17d 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -152,6 +152,7 @@ static struct test_workload *workloads[] =3D {
> >         &workload__sqrtloop,
> >         &workload__brstack,
> >         &workload__datasym,
> > +       &workload__offcpu,
> >  };
> >
> >  static int num_subtests(const struct test_suite *t)
> > diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests=
/shell/record_offcpu.sh
> > index 67c925f3a15a..1ea0a44336e2 100755
> > --- a/tools/perf/tests/shell/record_offcpu.sh
> > +++ b/tools/perf/tests/shell/record_offcpu.sh
> > @@ -6,6 +6,7 @@ set -e
> >
> >  err=3D0
> >  perfdata=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> > +TEST_PROGRAM=3D"perf test -w offcpu"
> >
> >  cleanup() {
> >    rm -f ${perfdata}
> > @@ -88,6 +89,30 @@ test_offcpu_child() {
> >    echo "Child task off-cpu test [Success]"
> >  }
> >
> > +test_offcpu_direct() {
> > +  echo "Direct off-cpu test"
> > +  # dump off-cpu samples for tasks blocked for more than 1999ms (1.9s)
> > +  # -D for initial delay, which is necessary if we want to enable evli=
st
> > +  if ! perf record -F 1 -D 999 --off-cpu --off-cpu-thresh 1999 -o ${pe=
rfdata} ${TEST_PROGRAM} 2> /dev/null
> > +  then
> > +    echo "Direct off-cpu test [Failed record]"
> > +    err=3D1
> > +    return
> > +  fi
> > +  if ! perf evlist -i ${perfdata} | grep -q "offcpu-time-direct"
> > +  then
> > +    echo "Direct off-cpu test [Failed no event]"
> > +    err=3D1
> > +    return
> > +  fi
> > +  if ! perf script -i ${perfdata} | grep -q -E ".*2[0-9]{9}[ ]*offcpu-=
time-direct" # 2 seconds (2,000,000,000)
> > +  then
> > +    echo "Direct off-cpu test [Failed missing output]"
> > +    err=3D1
> > +    return
> > +  fi
> > +  echo "Direct off-cpu test [Success]"
> > +}
> >
> >  test_offcpu_priv
> >
> > @@ -99,5 +124,9 @@ if [ $err =3D 0 ]; then
> >    test_offcpu_child
> >  fi
> >
> > +if [ $err =3D 0 ]; then
> > +  test_offcpu_direct
> > +fi
> > +
> >  cleanup
> >  exit $err
> > diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> > index 3aa7701ee0e9..84ab15683269 100644
> > --- a/tools/perf/tests/tests.h
> > +++ b/tools/perf/tests/tests.h
> > @@ -205,6 +205,7 @@ DECLARE_WORKLOAD(leafloop);
> >  DECLARE_WORKLOAD(sqrtloop);
> >  DECLARE_WORKLOAD(brstack);
> >  DECLARE_WORKLOAD(datasym);
> > +DECLARE_WORKLOAD(offcpu);
> >
> >  extern const char *dso_to_test;
> >  extern const char *test_objdump_path;
> > diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/worklo=
ads/Build
> > index 48bf0d3b0f3d..f37e9be8b142 100644
> > --- a/tools/perf/tests/workloads/Build
> > +++ b/tools/perf/tests/workloads/Build
> > @@ -6,6 +6,7 @@ perf-test-y +=3D leafloop.o
> >  perf-test-y +=3D sqrtloop.o
> >  perf-test-y +=3D brstack.o
> >  perf-test-y +=3D datasym.o
> > +perf-test-y +=3D offcpu.o
> >
> >  CFLAGS_sqrtloop.o         =3D -g -O0 -fno-inline -U_FORTIFY_SOURCE
> >  CFLAGS_leafloop.o         =3D -g -O0 -fno-inline -fno-omit-frame-point=
er -U_FORTIFY_SOURCE
> > diff --git a/tools/perf/tests/workloads/offcpu.c b/tools/perf/tests/wor=
kloads/offcpu.c
> > new file mode 100644
> > index 000000000000..02be3d05b06d
> > --- /dev/null
> > +++ b/tools/perf/tests/workloads/offcpu.c
> > @@ -0,0 +1,16 @@
> > +#include <linux/compiler.h>
> > +#include <unistd.h>
> > +#include "../tests.h"
> > +
> > +static int offcpu(int argc __maybe_unused, const char **argv __maybe_u=
nused)
> > +{
> > +       /* get pass initial delay */
> > +       sleep(1);
> > +
> > +       /* what we want to collect as a direct sample */
> > +       sleep(2);
> > +
> > +       return 0;
> > +}
> > +
> > +DEFINE_WORKLOAD(offcpu);
> > --
> > 2.45.2
> >
