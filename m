Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4984044BC88
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jun 2026 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781713451; cv=pass; b=AQv9oZ4ip3PdARE/EuWq6zBThE0CtX8MJ3/m/MgiO6hTj6LKd3zcdfFCy3zEYLLFDKCuTv6KUEhMFQQgIe3SnuanzeeTLSY1wNMtyVmWhMfYoxSmj5iR583yd0TOk01WmDxaCHg95nVu6HBs40KHavWmtMeyUE2+u4EiUCGKXKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781713451; c=relaxed/simple;
	bh=3xUX9beD8NN00NWAMNU1O/QszPZldMSAgl4iylGboEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DscvITRtG9HM672/H8BGmZCSgK0L+UqK/hj02ezcTy3+sdQREcUe008ravXNIewRUftHceUF21L5LkeY2fAt8h06TP8xvTSya98HDaj28Ik/MuyUesqP18sYoUnm60UbIkBYG6NP+gYIm8DxZ/OTys6HMGKiBcVzTszRkuR1f8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WGHbrWJz; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WGHbrWJz"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-133362c30cfso7706c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jun 2026 09:24:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781713445; cv=none;
        d=google.com; s=arc-20240605;
        b=AtzROKZohOck30ppazrzcJopiBOWrgQhJd6La1phQJ7+MQhDEdoky5jywUdjJ+I2Sl
         dBALwa/tRKpx7VSqD5H37mIfRe9s/rqGuHwlM1kyk6ngHkbmk2A8iyCq27W5+r9+8zPa
         IIV/5CY1ARpHf8ajTXl2ahkUkw1JXjyUI1xDZzuoPC54knnNjXpIKzDxHWwMlpdWlwzH
         eezO2A0v6kj8KfRYJLye2KjkmbBz4bFWE3JYUnHlg6LvNkQkXZpzWomMf839mVSn4sWt
         E/+89Uzuvw17zd7/UbzKSNeyDRuzmJjfEPe3gouoywjNx5APJYzk/86+cpTTDL+FX5ew
         5xGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pgk7hgp/zAhx/cX1TEoAjnewE/UnWjgyOknDJCkvjo4=;
        fh=POWx38kF7iqt9V/NJ04yVB3JfAPB0emRp7e2ZTlATEI=;
        b=Z42s98SwobEHnBXC9zxn4/R8ZP+Dq1+d3JPAzp74GxELKC04rmdPXnmpATaD3akwnd
         NAQDU7Liqc+5BIjxB/Lm3LflMBqjiM1b/8qEwmPLfgpC98VAJDX1nZo7pGjXFgiVmkIP
         UbC5aNhhvLJwTFs1ltpsHVL7m08ePZ3J+XmSb/MJJeilqHsFINW9TCL+M0lXLDS+hFLg
         0OSlfgYY0OQpKSlejqjrMGWAdn/HDUxW0MPgx6fGJV7yn28rblLMdV+qDkKEgaJcPmL0
         SrE5VoIboRTJxpJ2msZ8mLlDgHTZAY1CBP33NafPCMNLEzZsB5+DSdFiatHXGHLtc/x4
         +4mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781713445; x=1782318245; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pgk7hgp/zAhx/cX1TEoAjnewE/UnWjgyOknDJCkvjo4=;
        b=WGHbrWJz/SRnbbRYctNOn3JE7Z9h7UQ8EjiiKeQGgREd8wmCz1mXwkl/rZEfAarJ9Q
         x2r77rMQ+NGRBVRB5AE/HTK9RzkinZrJ9Hhjmp1kFJUmCwMYh5ywPjRHAqWViOFVTSDC
         6OlFVvIe2IyM6CuO7pCR6heobma22znSUJo7tPFfRS1Q2c+Sd17MfWtt4cE9to0CoB2I
         GqN8MPNdeE2mgiUAs1y3329+9wSYitbzE5NYCHSWNLYmfKvzvEP6bdHipm0hoxC5FEJC
         janwNBj1VUNmrlDN9O51V3B+JGXVoT2z4dZKKqG1dTrNCDwALu27ZzL7LX1mFLanQ0zt
         wPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781713445; x=1782318245;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pgk7hgp/zAhx/cX1TEoAjnewE/UnWjgyOknDJCkvjo4=;
        b=o4Hq/rPCl44AjZkU36GBgUakcSvvi/PhEvwpiA+nBR9b1Ex49Hw2DLx+vpwM67iRdF
         4ZSDXTJ+oNIC8ENnyFnayaMk6iUltWsgHYCxlTV7QtTGZNFheYwAQC0va23dhw3Zj66L
         4j9MJ5UfLklS3IiDdP/poGT8G7IRnAVoRomwzTg7mbhspu3ssSjvrBh431dZhDZYoBhr
         KuS6b6UXy4inq7ihU3vGZ4dQ0DWLpUhxn98qcBKd9/5hVQuuVVGOdXjvT6ZE/xBPzSCw
         b6iI9z9QltGQPcqjh8SWP04upFpnFlJMNqbiwf1VAd/OCLaz3Wq45w6YWoP8yOWDD2Rq
         zOJg==
X-Forwarded-Encrypted: i=1; AFNElJ8E9O1TGYZrcXqxe/qwsTPdxEBvOyHOIkz3TOBmcGG0Jqd86mU/0MmuMsBayRkZcYFHMAcNXfYgVJfpAky3M3BE@vger.kernel.org
X-Gm-Message-State: AOJu0YybuK4Q6N3L3EZh/ZKmzFTgIkpF8cJHpc7hjtslpGI5++a7tH93
	TO14bsMl72rgtDOF5n7IxoQ4F1bSwtw9tiSWPBPqVvNsK7Y502NtTPDVOXQ2EjO2Ry6CsEXxpgy
	k7ZpcMDsIzmzNGwQpLkl9Kmp0l26A9KoOEwVQWGaA
X-Gm-Gg: Acq92OH/Iz0xVTx85Ja5C4iX4LPjAYRnBTbVDRnAdN9XsaK/oAwzgKEcv9pImxlMEsD
	hVFhSbgCXn1YZKfMke2uh8erT3vrFrUjjGr7Da0lw/A/H5lDqFREXBzP5DhbzNv+j4l8o4KuYNx
	DS2IbnnzPahF0tMh5lBLVJiwpzkLjkares3j7jd1cNnzEO96uiRyTAhbWgUh84TF3WFD7g36PKa
	nVfGyQw1a20x3BchlwtAqj/I4eTh+4rRoX2WOoHCfcljo1EZQxBrViDYdJM7W1PK6QvFkB26uMO
	hlinv3J0uQaVCI5EWdcYmaLG42o=
X-Received: by 2002:a05:7023:b0c:b0:134:a710:ca44 with SMTP id
 a92af1059eb24-1398f15cb3cmr186437c88.18.1781713444214; Wed, 17 Jun 2026
 09:24:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615223011.3873955-1-irogers@google.com> <20260616011543.4037138-1-irogers@google.com>
 <20260616011543.4037138-4-irogers@google.com> <ajLGZBOPNraF3Fj3@x1>
In-Reply-To: <ajLGZBOPNraF3Fj3@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 17 Jun 2026 09:23:52 -0700
X-Gm-Features: AVVi8CcTJnv_ggamjAkdAsyXBSKMwUYroRe7cBlNplPnbv-JXau3bsOqtkst3y8
Message-ID: <CAP-5=fWPgRn-Oa=9h367xbciDFeWBPkWfSji3qydwQ1nf08gaw@mail.gmail.com>
Subject: Re: [PATCH v21 03/21] perf evsel/evlist: Avoid unnecessary #includes
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 9:08=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Jun 15, 2026 at 06:15:25PM -0700, Ian Rogers wrote:
> > Use forward declarations and remove unnecessary #includes in
> > evsel.h. Sort the forward declarations in evsel.h and evlist.h. Move
> > some PMU code into evsel.c.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> =E2=AC=A2 [acme@toolbx perf-tools-next2]$ git log --oneline -5
> ce69f4f6d7467ef4 (HEAD) perf evsel/evlist: Avoid unnecessary #includes
> 23dce143f5ed0557 perf python: Add missed explicit dependencies
> ca74d08280ad690f perf util: Sort includes and add missed explicit depende=
ncies
> 776bd9ac834556ab (x1/perf-tools-next, perf-tools-next.korg/tmp.perf-tools=
-next, perf-tools-next.korg/perf-tools-next, origin/perf-tools-next) perf b=
pf: Fix up build failure due to change of btf_vlen() return type
> 522ae978ac720a91 (origin/perf/hardening-9) perf dso: Set standard errno o=
n decompression failure
> =E2=AC=A2 [acme@toolbx perf-tools-next2]$
>
>   LD      /tmp/build/perf-tools-next2/util/scripting-engines/perf-util-in=
.o
> make[3]: *** [/home/acme/git/perf-tools-next2/tools/build/Makefile.build:=
158: util] Error 2
> make[2]: *** [Makefile.perf:573: /tmp/build/perf-tools-next2/perf-util-in=
.o] Error 2
> make[2]: *** Waiting for unfinished jobs....
>   LD      /tmp/build/perf-tools-next2/tests/perf-test-in.o
>   LD      /tmp/build/perf-tools-next2/perf-test-in.o
>   LD      /tmp/build/perf-tools-next2/perf-in.o
> make[1]: *** [Makefile.perf:288: sub-make] Error 2
> make: *** [Makefile:122: install-bin] Error 2
> make: Leaving directory '/home/acme/git/perf-tools-next2/tools/perf'
> =E2=AC=A2 [acme@toolbx perf-tools-next2]$
>
> I added this to fix the build:
>
> =E2=AC=A2 [acme@toolbx perf-tools-next2]$ git diff
> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> index 6a7542e7db827d1b..027695d967798487 100644
> --- a/tools/perf/util/aslr.c
> +++ b/tools/perf/util/aslr.c
> @@ -13,6 +13,7 @@
>  #include "session.h"
>  #include "data.h"
>  #include "dso.h"
> +#include "pmu.h"
>  #include "pmus.h"
>
>  #include <internal/lib.h>  /* page_size */
> =E2=AC=A2 [acme@toolbx perf-tools-next2]$
>
> Applied the series, now testing.

Thanks, I'd found the same aslr issue but was testing with fixing the
wider issues you raised. Presumably the aslr code was depending on the
the #include via evsel.h and so cleaning those up broke the build as
the aslr code needed a fix.

Thanks for testing, I can rebase my fixes on top of the v21 changes
assuming testing goes ok.

Ian

>
> - Arnaldo
>
> > ---
> >  tools/perf/util/evlist.h | 15 +++++++++------
> >  tools/perf/util/evsel.c  |  5 +++++
> >  tools/perf/util/evsel.h  | 25 ++++++++++++-------------
> >  3 files changed, 26 insertions(+), 19 deletions(-)
> >
> > diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> > index e507f5f20ef6..e54761c670b6 100644
> > --- a/tools/perf/util/evlist.h
> > +++ b/tools/perf/util/evlist.h
> > @@ -2,29 +2,32 @@
> >  #ifndef __PERF_EVLIST_H
> >  #define __PERF_EVLIST_H 1
> >
> > +#include <signal.h>
> > +
> >  #include <linux/compiler.h>
> >  #include <linux/kernel.h>
> > -#include <linux/refcount.h>
> >  #include <linux/list.h>
> > +#include <linux/refcount.h>
> > +#include <pthread.h>
> > +#include <unistd.h>
> > +
> >  #include <api/fd/array.h>
> >  #include <internal/evlist.h>
> >  #include <internal/evsel.h>
> >  #include <perf/evlist.h>
> > +
> >  #include "affinity.h"
> >  #include "events_stats.h"
> >  #include "evsel.h"
> >  #include "rblist.h"
> > -#include <pthread.h>
> > -#include <signal.h>
> > -#include <unistd.h>
> >
> > -struct pollfd;
> > -struct thread_map;
> >  struct perf_cpu_map;
> >  struct perf_stat_config;
> > +struct pollfd;
> >  struct record_opts;
> >  struct strbuf;
> >  struct target;
> > +struct thread_map;
> >
> >  /*
> >   * State machine of bkw_mmap_state:
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 34c03f47a913..19e48b9260e9 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -370,6 +370,11 @@ void evsel__set_sample_id(struct evsel *evsel,
> >       evsel->core.attr.read_format |=3D PERF_FORMAT_ID;
> >  }
> >
> > +bool evsel__is_non_perf_event_open_pmu(const struct evsel *evsel)
> > +{
> > +     return evsel->pmu && evsel->pmu->type > PERF_PMU_TYPE_PE_END;
> > +}
> > +
> >  /**
> >   * evsel__is_function_event - Return whether given evsel is a function
> >   * trace event
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index 8178858d168a..6b28cd754a18 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -2,28 +2,30 @@
> >  #ifndef __PERF_EVSEL_H
> >  #define __PERF_EVSEL_H 1
> >
> > -#include <linux/list.h>
> >  #include <stdbool.h>
> > -#include <sys/types.h>
> > +
> > +#include <linux/list.h>
> >  #include <linux/perf_event.h>
> >  #include <linux/types.h>
> > +#include <sys/types.h>
> > +
> >  #include <internal/evsel.h>
> >  #include <perf/evsel.h>
> > +
> >  #include "symbol_conf.h"
> > -#include "pmus.h"
> > -#include "pmu.h"
> >
> > +struct bperf_follower_bpf;
> > +struct bperf_leader_bpf;
> > +struct bpf_counter_ops;
> >  struct bpf_object;
> >  struct cgroup;
> > +struct hashmap;
> >  struct perf_counts;
> > +struct perf_pmu;
> >  struct perf_stat_config;
> >  struct perf_stat_evsel;
> > -union perf_event;
> > -struct bpf_counter_ops;
> >  struct target;
> > -struct hashmap;
> > -struct bperf_leader_bpf;
> > -struct bperf_follower_bpf;
> > +union perf_event;
> >
> >  typedef int (evsel__sb_cb_t)(union perf_event *event, void *data);
> >
> > @@ -356,10 +358,6 @@ void arch_evsel__apply_ratio_to_prev(struct evsel =
*evsel, struct perf_event_attr
> >  int evsel__set_filter(struct evsel *evsel, const char *filter);
> >  int evsel__append_tp_filter(struct evsel *evsel, const char *filter);
> >  int evsel__append_addr_filter(struct evsel *evsel, const char *filter)=
;
> > -static inline bool evsel__is_non_perf_event_open_pmu(const struct evse=
l *evsel)
> > -{
> > -     return evsel->pmu && evsel->pmu->type > PERF_PMU_TYPE_PE_END;
> > -}
> >
> >  int evsel__enable_cpu(struct evsel *evsel, int cpu_map_idx);
> >  int evsel__enable(struct evsel *evsel);
> > @@ -478,6 +476,7 @@ static inline bool evsel__is_group_event(struct evs=
el *evsel)
> >       return evsel__is_group_leader(evsel) && evsel->core.nr_members > =
1;
> >  }
> >
> > +bool evsel__is_non_perf_event_open_pmu(const struct evsel *evsel);
> >  bool evsel__is_function_event(struct evsel *evsel);
> >
> >  static inline bool evsel__is_bpf_output(struct evsel *evsel)
> > --
> > 2.54.0.1136.gdb2ca164c4-goog
