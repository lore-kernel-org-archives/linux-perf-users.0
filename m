Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E722F29BD81
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Nov 2025 04:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763440709; cv=none; b=b7Vtir7t7E40sHOXfSFQ9tO/fBipM6rK+0wPGBxUtPj7/LOCyfdXNHc2sBrSEkfdtGaQbo8XWuJAiaNcTqa3HQTSLDEp1FAokLlg+bDx0dXqAf7l76iA5W2WnNqdduLtx9pjzAW9u+otgGQ/pto5W8kVazT9IoqPjmjV5enTVnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763440709; c=relaxed/simple;
	bh=a3RxEnjm+V9tKMtQ2ALjktqSH/f6uWsyNCBx24dtHQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3YOM5y71JAuOEgvEpG5Q7rZtuAs2SK4udKkOni2NCYNB8/6NFLs3rsqhbjK9FDq42k/WVy2jSVlMmZxb8+XgnPoYcQiaavUV+1T0rbco1U9ABVqvMLxEFr6tzgwNzGsetiS2OKy2CSk8W5ekUvcWJSVWZrdk7EzdPw2yzPUJB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MYufPe98; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MYufPe98"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29852dafa7dso86965ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Nov 2025 20:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763440707; x=1764045507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrXjnm/a7YJo4bbG4gKpKNgJROl74u3jiSBfqt4uYwo=;
        b=MYufPe98Q8aNcuvWSs84qp0QwCm9636IRozcEqYHudNzv8wOfRvz7bsNisyW0SQM7A
         ouXDWJSm6zgcWxaIcxHpEC0Jv1h/5P4MEWlFQuFcrC3kefJKt0mAyIkVZAxMa8XMGcB2
         7sNzyddC84O+VutAtAFG4eIOjNqUsO/Ckn6rV++mO05iu9hdTu54tJlIpHlHJ6U2tVoV
         ZQoPl9Ca44fHjmfMGPIkcnAaqe2kL7lVGTweUrstyQrNXXIZc2Os+BRgTt7JW6lCj5CI
         HDuDDERBkej8A6ouSNkLm7EqaxUTAgIi5ZvIIlkStbPGY7jnNMm9t8OecZFw3P7B3ulM
         LRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763440707; x=1764045507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jrXjnm/a7YJo4bbG4gKpKNgJROl74u3jiSBfqt4uYwo=;
        b=YCuSmoVeuQ8hVkXY5Ilh769udi4gD5xM4Kgmw5whfzRbrJVAQqzXJsVsAEjzfcATf4
         +XhbAJTQVrpzx6E1n6e8+GYSPZJGWEFATWNXEOMW6Fygoo4/ughOLvhaWlsRn8uOKdNy
         RnjHEFnmWUe0GEteZN+2RB1mzJUSl34RkpH6VCTgPUwIusIShP28ijjIcvG8ePxwOL+k
         3X5sM7XM83jwFO1JYAIwwmnZjICV3SVZDPUsMj5nCixzXCWkr7kGs5xZGkjGnuK+Pj7M
         SNgV6kOU+9t+/CyMa8zmqm7+1ktY0xug3mHuZkwxrjuG1ReB0xDjEizeQizgzh2tKHcj
         89jg==
X-Forwarded-Encrypted: i=1; AJvYcCXUqclJ+RiQusR/aDgWT6fffraNRRSAfiZM27Zp3flaol4G/KI8f/W6bW82mxCP4YzgN9gDUlSl8nUVM1RszWnL@vger.kernel.org
X-Gm-Message-State: AOJu0YyIrHSM8xUBUOnipX1W1hrNLNuZncL8jfMYhm5fU9TtZ50C/Di1
	UKo+Ephldhx5oYwEJoO49WGKXwwJ1fqGLlb9TxcJZxL/NUImeLZm5ILjGR705JHOOAWCg1/ihPS
	9auOMVPkqeLsccXHW4bfa8KFnMH6dOhx62iCNGYDY
X-Gm-Gg: ASbGncs89KG80BPBY34vGlxl2UFKd5WGqFYMgl415Mfnan6eGsFRdPifjZ4V/tqSj7a
	lbOcNHvtlG/qxcdBUd6m/7/IxUBDSSb6MTzEBUOa168nEPKMiYV6AP9iRGSU4G1K+EOkkmvveTA
	hUpE9+BuDg6vkLChGJxDrfqP9eD7bsz5/eKeKDwZqIKiupvKPy86W1awWzytkfr9z+DLpUfxk5X
	ILL1rI/ne3er6iZQcLnwkUMUz1RGKeBGuAB1PerriFP7DjybvtBjyZeuvIijejfVtllt/eqN/wT
	TpO3cyA=
X-Google-Smtp-Source: AGHT+IHPJw3BX6aeQRdC1igr0GF6TjyA4QV+mZVCsZ1u3N98NVlsvSZcMXIWPZDsLZeGaNabYHBW6AtVjvMqkNiGkjo=
X-Received: by 2002:a17:903:1d2:b0:294:d42c:ca0f with SMTP id
 d9443c01a7336-299f6682e54mr2355255ad.2.1763440706858; Mon, 17 Nov 2025
 20:38:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113180517.44096-1-irogers@google.com> <20251113180517.44096-10-irogers@google.com>
 <aRvbZbhcsjpCXiAU@google.com>
In-Reply-To: <aRvbZbhcsjpCXiAU@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Nov 2025 20:38:15 -0800
X-Gm-Features: AWmQ_bmcnf9DzHJhlg7TsP4xucyxznYqq7WNF3kq1kfwN939U6v5glSODzHpFxU
Message-ID: <CAP-5=fVidOjNDZCX6Ain83KFp0Zk8aHTJX7_KgwfTY885DuPKg@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] perf stat: Read tool events last
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 6:35=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Nov 13, 2025 at 10:05:15AM -0800, Ian Rogers wrote:
> > When reading a metric like memory bandwidth on multiple sockets, the
> > additional sockets will be on CPUS > 0. Because of the affinity
> > reading, the counters are read on CPU 0 along with the time, then the
> > later sockets are read. This can lead to the later sockets having a
> > bandwidth larger than is possible for the period of time. To avoid
> > this moving the reading of tool events to occur after all other events
> > are read.
>
> Can you move this change before the affinity updates?  I think it's
> straight-forward and can be applied independently.

It is straightforward but will require changes to
read_counters_with_affinity. I can do a v5 once I know what to do with
the other patches.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-stat.c | 29 ++++++++++++++++++++++++++++-
> >  tools/perf/util/evlist.c  |  4 ----
> >  2 files changed, 28 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 947f11b8b106..aec93b91fd11 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -379,6 +379,9 @@ static int read_counters_with_affinity(void)
> >               if (evsel__is_bpf(counter))
> >                       continue;
> >
> > +             if (evsel__is_tool(counter))
> > +                     continue;
> > +
> >               if (!counter->err)
> >                       counter->err =3D read_counter_cpu(counter, evlist=
_cpu_itr.cpu_map_idx);
> >       }
> > @@ -402,6 +405,24 @@ static int read_bpf_map_counters(void)
> >       return 0;
> >  }
> >
> > +static int read_tool_counters(void)
> > +{
> > +     struct evsel *counter;
> > +
> > +     evlist__for_each_entry(evsel_list, counter) {
> > +             int idx;
> > +
> > +             if (!evsel__is_tool(counter))
> > +                     continue;
> > +
> > +             perf_cpu_map__for_each_idx(idx, counter->core.cpus) {
> > +                     if (!counter->err)
> > +                             counter->err =3D read_counter_cpu(counter=
, idx);
> > +             }
> > +     }
> > +     return 0;
> > +}
> > +
> >  static int read_counters(void)
> >  {
> >       int ret;
> > @@ -415,7 +436,13 @@ static int read_counters(void)
> >               return ret;
> >
> >       // Read non-BPF and non-tool counters next.
> > -     return read_counters_with_affinity();
> > +     ret =3D read_counters_with_affinity();
> > +     if (ret)
> > +             return ret;
> > +
> > +     // Read the tool counters last. This way the duration_time counte=
r
> > +     // should always be greater than any other counter's enabled time=
.
> > +     return read_tool_counters();
> >  }
> >
> >  static void process_counters(void)
> > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > index b6df81b8a236..fc3dae7cdfca 100644
> > --- a/tools/perf/util/evlist.c
> > +++ b/tools/perf/util/evlist.c
> > @@ -368,10 +368,6 @@ static bool evlist__use_affinity(struct evlist *ev=
list)
> >       struct perf_cpu_map *used_cpus =3D NULL;
> >       bool ret =3D false;
> >
> > -     /*
> > -      * With perf record core.user_requested_cpus is usually NULL.
> > -      * Use the old method to handle this for now.
> > -      */
> >       if (!evlist->core.user_requested_cpus ||
> >           cpu_map__is_dummy(evlist->core.user_requested_cpus))
> >               return false;
> > --
> > 2.51.2.1041.gc1ab5b90ca-goog
> >
