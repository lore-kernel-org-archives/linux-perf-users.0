Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ouETubjN"
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9E4D6C
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Nov 2023 10:29:43 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40b35199f94so17465e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Nov 2023 10:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701368982; x=1701973782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBKQZd68edVxF6ECkF2oX9KfXPiYc6EetlvZAUBR47c=;
        b=ouETubjN1Hdfwdi3lj5ciw9BryOW7yvcfzKQ8Y6c9yMy99sUrEZjdtvK4hgBXQcrHw
         QOKA/wmdEMYw8XZhz70GYM/rzYolQYCaA/htcob/jmnpV9u06qUnjK/rlDjXJalwiolJ
         UyBsk8YT8+T8NWijedkchFVYnMhjTsmaZi5AfrsNxxq71qnVGwJccjjm4xWh+/JrxXtn
         gxBp4vE83nlRW5PewqnFvmVSjDvi6STPDLTpS/2PE/+sJfusmXGrMAyyn8aJ9nq7PZ69
         B2Gcq76iRn1gs0o3w1id+LxjamdEHE19sbD8RJdXLPJSguWAMHMJLPIIG8QTp4jISYC9
         +JxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701368982; x=1701973782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FBKQZd68edVxF6ECkF2oX9KfXPiYc6EetlvZAUBR47c=;
        b=NDiJn28M9p9M21czPfXLcXigE57QTdhpe1Bz0G40R2Gb3MQrko0x6XMBr4xgyWh+Dh
         4gRG2px3JYlzaudEYz6RRtt3gzWgFLQ5t/AetqEjdkY66Dh9KCV3CZyqr0tvwk9Swy01
         f2INKoycWqnnxewmIZGkyN5hK+bdN8WvAVjmfVy8Rk5QEUK5IzZ9W9koZeDkK1D1nVSJ
         DoxjaPcABT/rTi5JJhAfhjxmJZd4G6qj4YqdnMHuaPZ5Lq0z3brCPTCU1bE2khJgApkJ
         vkfQoSuCCwLtuYknqxt9bnpV+aVzG2iVk1PO218q7aAJQVPcH9kYpmsmz+yHrZ08OTjy
         Ugkw==
X-Gm-Message-State: AOJu0YyiW04q5T23Jmr1pJ+/TqCi4tA64bcHaZrc5f8l7HJDerDNPNxq
	L7O6tAfsDWUCxMUmf36PVRoWp4dScaBesn8WmzUvnA==
X-Google-Smtp-Source: AGHT+IGJXurzgm9WUTj0WY4QgYfh64X35gMpEmBv6sX8eZgPY8mokBM6500vWNCCFVYZsaGL0tJ3UdVaHekQSMyAvhA=
X-Received: by 2002:a05:600c:1c04:b0:40b:43f4:df9e with SMTP id
 j4-20020a05600c1c0400b0040b43f4df9emr211199wms.2.1701368981847; Thu, 30 Nov
 2023 10:29:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-9-irogers@google.com>
 <CAM9d7cjpYHN_Q63sW70vTCisdW=-SzjsrryUUJjgtZ3+9jdxfA@mail.gmail.com>
In-Reply-To: <CAM9d7cjpYHN_Q63sW70vTCisdW=-SzjsrryUUJjgtZ3+9jdxfA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 30 Nov 2023 10:29:30 -0800
Message-ID: <CAP-5=fXjReF38T_GKohtWd7_7fZjYVnKBj-Fwt+agi1vSWAEdQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/50] perf record: Be lazier in allocating lost
 samples buffer
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ming Wang <wangming01@loongson.cn>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, liuwenyu <liuwenyu7@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 6:09=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Nov 27, 2023 at 2:09=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Wait until a lost sample occurs to allocate the lost samples buffer,
> > often the buffer isn't necessary. This saves a 64kb allocation and
> > 5.3kb of peak memory consumption.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-record.c | 29 +++++++++++++++++++----------
> >  1 file changed, 19 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 9b4f3805ca92..b6c8c1371b39 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -1924,21 +1924,13 @@ static void __record__save_lost_samples(struct =
record *rec, struct evsel *evsel,
> >  static void record__read_lost_samples(struct record *rec)
> >  {
> >         struct perf_session *session =3D rec->session;
> > -       struct perf_record_lost_samples *lost;
> > +       struct perf_record_lost_samples *lost =3D NULL;
> >         struct evsel *evsel;
> >
> >         /* there was an error during record__open */
> >         if (session->evlist =3D=3D NULL)
> >                 return;
> >
> > -       lost =3D zalloc(PERF_SAMPLE_MAX_SIZE);
>
> To minimize the allocation size, this can be
> sizeof(*lost) + session->machines.host.id_hdr_size
> instead of PERF_SAMPLE_MAX_SIZE.

Sounds good, should probably be a follow up. The current size is
PERF_SAMPLE_MAX_SIZE.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > -       if (lost =3D=3D NULL) {
> > -               pr_debug("Memory allocation failed\n");
> > -               return;
> > -       }
> > -
> > -       lost->header.type =3D PERF_RECORD_LOST_SAMPLES;
> > -
> >         evlist__for_each_entry(session->evlist, evsel) {
> >                 struct xyarray *xy =3D evsel->core.sample_id;
> >                 u64 lost_count;
> > @@ -1961,6 +1953,14 @@ static void record__read_lost_samples(struct rec=
ord *rec)
> >                                 }
> >
> >                                 if (count.lost) {
> > +                                       if (!lost) {
> > +                                               lost =3D zalloc(PERF_SA=
MPLE_MAX_SIZE);
> > +                                               if (!lost) {
> > +                                                       pr_debug("Memor=
y allocation failed\n");
> > +                                                       return;
> > +                                               }
> > +                                               lost->header.type =3D P=
ERF_RECORD_LOST_SAMPLES;
> > +                                       }
> >                                         __record__save_lost_samples(rec=
, evsel, lost,
> >                                                                     x, =
y, count.lost, 0);
> >                                 }
> > @@ -1968,9 +1968,18 @@ static void record__read_lost_samples(struct rec=
ord *rec)
> >                 }
> >
> >                 lost_count =3D perf_bpf_filter__lost_count(evsel);
> > -               if (lost_count)
> > +               if (lost_count) {
> > +                       if (!lost) {
> > +                               lost =3D zalloc(PERF_SAMPLE_MAX_SIZE);
> > +                               if (!lost) {
> > +                                       pr_debug("Memory allocation fai=
led\n");
> > +                                       return;
> > +                               }
> > +                               lost->header.type =3D PERF_RECORD_LOST_=
SAMPLES;
> > +                       }
> >                         __record__save_lost_samples(rec, evsel, lost, 0=
, 0, lost_count,
> >                                                     PERF_RECORD_MISC_LO=
ST_SAMPLES_BPF);
> > +               }
> >         }
> >  out:
> >         free(lost);
> > --
> > 2.43.0.rc1.413.gea7ed67945-goog
> >
