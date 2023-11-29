Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mYyasOpF"
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75A52139
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Nov 2023 08:17:51 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b422a274dso82185e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Nov 2023 08:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701274670; x=1701879470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y25gE7qRQbauuqchZstaaBAeEHIU4T0NaoXjYUJrRZA=;
        b=mYyasOpFy8QAkrn2PLQzOkpl/iuJSbL1vOx1s/OS26/3UmbsQL3I7N1hlf5ECym6Ee
         0BmiLLBACR1n+xCl8bLrDVF2CVfkpLDTZ9nKPsJ+4KKePw8U4On9aBC1yRHUthCROLii
         jZdxIRkKSVQu5yb0NqFVEhsLAMKpcAUs8yVC78HKlBRcytV4maGp7nNlThrma2PmNf6B
         QAKEkrr3a12mJadDfLKNhrjAs01RqQ7B6y3c5ixtlcGFDPGdblI178SRBLuk0V6G4Yg5
         DuG/M/S47mfQZHvaWcGyEq41Id41g1nU1bS8tkSSuih8VkF3ihA4hJwPGwgt51+PNTDf
         wkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701274670; x=1701879470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y25gE7qRQbauuqchZstaaBAeEHIU4T0NaoXjYUJrRZA=;
        b=TFsriXqZvm29I82Ab+uyW1Zj/E8IaOlY+6kmo6sMihMBCLUJZ5VK+CYhZgyBnQzOQB
         mek5WSeiHHMEz2FyfYA/KAckS8KIsIEG328Y2WmKHQLr4zdSDo4gKoxMvJgKXWqSOUer
         YAVC0nrD7RFyExmsD6NPEpHSMbnCSzeJSBP8ui9tNnDb0f6ciPkfE2Jpys7Y8vkju2Cu
         VsQ/KIDqW1jSirUiUxBKLMig2JFaVueFGXDN/Nr7EvDaj9K6atyGLud6jSWvWVp91a1y
         uiyOiQ75worYEiz+WEvdhzNQ++m2OJzAPeXolScbVt807MH+AOVHGHGilst2gKrHnuel
         twAA==
X-Gm-Message-State: AOJu0YxZrMzH0WdVrDiqg51QOAgpdKM1cIqwUFUCpDWwEZcspzhIvol8
	FZ2VVgWf5EkVqaM6CfRJY/FNZ//2Gzp9SSmpcPQELg==
X-Google-Smtp-Source: AGHT+IE6Ts20gD1Fh17UCq7+Pbp+RtkGVtqiWTP7q3OE4Poo42tRXKTgYs+HJplU0rD3mD60aetjpvkIbRsItyBxD1A=
X-Received: by 2002:a05:600c:1d26:b0:40b:4221:4085 with SMTP id
 l38-20020a05600c1d2600b0040b42214085mr514618wms.1.1701274669916; Wed, 29 Nov
 2023 08:17:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128203940.3964287-1-kan.liang@linux.intel.com>
 <CAP-5=fUdEgnwk_FNHb-Ju3wCYE2PLLrPHqwZoyBGyURXQhBeSA@mail.gmail.com> <083bfe11-6f6e-487f-ac28-aec22e6b6b06@linux.intel.com>
In-Reply-To: <083bfe11-6f6e-487f-ac28-aec22e6b6b06@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 29 Nov 2023 08:17:38 -0800
Message-ID: <CAP-5=fXTYX6_QdR4RCBu9yh+k1VwhsTjabKdseVP9Cvi6PE=sA@mail.gmail.com>
Subject: Re: [PATCH] perf mem: Fix perf mem error on hybrid
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: acme@kernel.org, mingo@redhat.com, peterz@infradead.org, 
	mark.rutland@arm.com, namhyung@kernel.org, jolsa@kernel.org, 
	adrian.hunter@intel.com, ravi.bangoria@amd.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Ammy Yi <ammy.yi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 5:52=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2023-11-29 1:24 a.m., Ian Rogers wrote:
> > On Tue, Nov 28, 2023 at 12:39=E2=80=AFPM <kan.liang@linux.intel.com> wr=
ote:
> >>
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> The below error can be triggered on a hybrid machine.
> >>
> >>  $ perf mem record -t load sleep 1
> >>  event syntax error: 'breakpoint/mem-loads,ldlat=3D30/P'
> >>                                 \___ Bad event or PMU
> >>
> >>  Unable to find PMU or event on a PMU of 'breakpoint'
> >>
> >> In the perf_mem_events__record_args(), the current perf never checks t=
he
> >> availability of a mem event on a given PMU. All the PMUs will be added
> >> to the perf mem event list. Perf errors out for the unsupported PMU.
> >>
> >> Extend perf_mem_event__supported() and take a PMU into account. Check
> >> the mem event for each PMU before adding it to the perf mem event list=
.
> >>
> >> Optimize the perf_mem_events__init() a little bit. The function is to
> >> check whether the mem events are supported in the system. It doesn't
> >> need to scan all PMUs. Just return with the first supported PMU is goo=
d
> >> enough.
> >>
> >> Fixes: 5752c20f3787 ("perf mem: Scan all PMUs instead of just core one=
s")
> >> Reported-by: Ammy Yi <ammy.yi@intel.com>
> >> Tested-by: Ammy Yi <ammy.yi@intel.com>
> >> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >> ---
> >>  tools/perf/util/mem-events.c | 25 ++++++++++++++-----------
> >>  1 file changed, 14 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events=
.c
> >> index 954b235e12e5..3a2e3687878c 100644
> >> --- a/tools/perf/util/mem-events.c
> >> +++ b/tools/perf/util/mem-events.c
> >> @@ -100,11 +100,14 @@ int perf_mem_events__parse(const char *str)
> >>         return -1;
> >>  }
> >>
> >> -static bool perf_mem_event__supported(const char *mnt, char *sysfs_na=
me)
> >> +static bool perf_mem_event__supported(const char *mnt, struct perf_pm=
u *pmu,
> >> +                                     struct perf_mem_event *e)
> >>  {
> >> +       char sysfs_name[100];
> >>         char path[PATH_MAX];
> >>         struct stat st;
> >>
> >> +       scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_name, pmu->=
name);
> >
> > Not sure if this is right. Looking at sysfs_name values:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/mem-events.c?h=3Dperf-tools-next#n23
> > "cpu/events/mem-loads" and "cpu/events/mem-stores", so won't pmu->name
> > never be used?
> > Is there a missed change to change the cpu to %s?
>
> There is a X86 specific perf_mem_events__ptr(), which uses the
> "%s/mem-loads,ldlat=3D%u/P" and "%s/events/mem-loads" for Intel platforms=
.
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/=
tree/tools/perf/arch/x86/util/mem-events.c?h=3Dperf-tools-next#n20
> The pmu->name is used especially for the hybrid platforms.

Right, that seems wrong. For one thing we're losing the compiler's
format string argument checking, but hardcoding PMU names just seems
to be something that will keep needing maintenance. This patch set
looks to fix an Intel issue but in general it is increasing tech debt
(or at least churning it) that will need cleaning up to do something
with better error checking and more generic. perf_mem_event looks like
a bad abstraction and then there are the integers whose special values
hold meaning. Could this fix come with some cleanup? It wouldn't seem
wrong to me to add notions of memory events to the PMU abstraction. As
it stands this scnprintf looks wrong in non-Intel cases.

Thanks,
Ian

> Thanks,
> Kan
> >
> > Thanks,
> > Ian
> >
> >>         scnprintf(path, PATH_MAX, "%s/devices/%s", mnt, sysfs_name);
> >>         return !stat(path, &st);
> >>  }
> >> @@ -120,7 +123,6 @@ int perf_mem_events__init(void)
> >>
> >>         for (j =3D 0; j < PERF_MEM_EVENTS__MAX; j++) {
> >>                 struct perf_mem_event *e =3D perf_mem_events__ptr(j);
> >> -               char sysfs_name[100];
> >>                 struct perf_pmu *pmu =3D NULL;
> >>
> >>                 /*
> >> @@ -136,12 +138,12 @@ int perf_mem_events__init(void)
> >>                  * of core PMU.
> >>                  */
> >>                 while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) {
> >> -                       scnprintf(sysfs_name, sizeof(sysfs_name), e->s=
ysfs_name, pmu->name);
> >> -                       e->supported |=3D perf_mem_event__supported(mn=
t, sysfs_name);
> >> +                       e->supported |=3D perf_mem_event__supported(mn=
t, pmu, e);
> >> +                       if (e->supported) {
> >> +                               found =3D true;
> >> +                               break;
> >> +                       }
> >>                 }
> >> -
> >> -               if (e->supported)
> >> -                       found =3D true;
> >>         }
> >>
> >>         return found ? 0 : -ENOENT;
> >> @@ -167,13 +169,10 @@ static void perf_mem_events__print_unsupport_hyb=
rid(struct perf_mem_event *e,
> >>                                                     int idx)
> >>  {
> >>         const char *mnt =3D sysfs__mount();
> >> -       char sysfs_name[100];
> >>         struct perf_pmu *pmu =3D NULL;
> >>
> >>         while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) {
> >> -               scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_nam=
e,
> >> -                         pmu->name);
> >> -               if (!perf_mem_event__supported(mnt, sysfs_name)) {
> >> +               if (!perf_mem_event__supported(mnt, pmu, e)) {
> >>                         pr_err("failed: event '%s' not supported\n",
> >>                                perf_mem_events__name(idx, pmu->name));
> >>                 }
> >> @@ -183,6 +182,7 @@ static void perf_mem_events__print_unsupport_hybri=
d(struct perf_mem_event *e,
> >>  int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
> >>                                  char **rec_tmp, int *tmp_nr)
> >>  {
> >> +       const char *mnt =3D sysfs__mount();
> >>         int i =3D *argv_nr, k =3D 0;
> >>         struct perf_mem_event *e;
> >>
> >> @@ -211,6 +211,9 @@ int perf_mem_events__record_args(const char **rec_=
argv, int *argv_nr,
> >>                         while ((pmu =3D perf_pmus__scan(pmu)) !=3D NUL=
L) {
> >>                                 const char *s =3D perf_mem_events__nam=
e(j, pmu->name);
> >>
> >> +                               if (!perf_mem_event__supported(mnt, pm=
u, e))
> >> +                                       continue;
> >> +
> >>                                 rec_argv[i++] =3D "-e";
> >>                                 if (s) {
> >>                                         char *copy =3D strdup(s);
> >> --
> >> 2.35.1
> >>
