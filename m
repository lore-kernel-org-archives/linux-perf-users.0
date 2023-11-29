Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pvnhHQKW"
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8354171D
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Nov 2023 22:24:21 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40b51e26a7aso25225e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Nov 2023 22:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701239060; x=1701843860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrR3MK1LW15VjpUrUw2X9mVPoBtBYztiwKpoFmC9scE=;
        b=pvnhHQKWIRRGPVPJtxocxSZ5U5hYunLHyQCLjIaLr+nw1bU1q1xvRJQkfR9SmUS/TQ
         RrtD1Tyz7brtpsdHOMhI8QuIG49BPVbTyMytS4nrH0ML+Zfrmzy+k65nxd80dUYPqDRX
         c3KJwuvoTev+wTkBTO+x5HL4xcwtdcH65gONW9fLOSeaaPhd/ld/TDH2UqE1SfQCAA0V
         O26DXQrhF6RCARxgGv1Byka2+nmQ63n3yFHBVnenNvp70DG2Xfo1IUTcK0t1qUDuzWy/
         YO26I2Gx757KD49BFN7/F77lyaBjcu9GeBo9bScoYSQMZAYT8xVr2AZvggZpSJ5BS9mL
         6XGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701239060; x=1701843860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrR3MK1LW15VjpUrUw2X9mVPoBtBYztiwKpoFmC9scE=;
        b=uVV/e9lKabNdUrPVOToEkS6irtb8K8TCQyimF148c9LHcNhTA9pAiWo2SrM3rZlq+L
         E1w3C77k0UvQmvOtnYR3oRpU3Cwgu7iGvtSWRns3K0T0YGkEcEkN64H130rJB/e0tHs/
         kCiXFQh+fmA0Yp6rkZ8OqggeRnLh4mQ/j4GrHA99gGPyjSB1FizQ37XyFGNiEWk3Elc2
         agiZ6wLJxJ60mGA0G3W5pqUlsJNNp36WHNnQcQVEBG4POMrHFfhCKgoePPUC97HKPvjx
         X9tYNBdg8HV6FC7nafwMoY8BflLe2HHQxpguUNjUpLeSSI9L5iIJqAnZKg4QsOMttjky
         AqVA==
X-Gm-Message-State: AOJu0YyAJuOUXAxEBn6eOLk99iEk8ale7GDFZDVGJMlDAn+xjPM90KzP
	qf9x2IYSWndYe4tBPxs5m1TWM7Y8vbYRftZMal7aPg==
X-Google-Smtp-Source: AGHT+IEmsaHYAiQWIDtKdTh10FcRAoai8sYGWZ8W3ifG0/DbXmRoooaMyppUpLBx9xf5I4/5roCn9rR7VUFo4tW4oTE=
X-Received: by 2002:a05:600c:3c83:b0:40b:2ec6:2a87 with SMTP id
 bg3-20020a05600c3c8300b0040b2ec62a87mr886505wmb.5.1701239059996; Tue, 28 Nov
 2023 22:24:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128203940.3964287-1-kan.liang@linux.intel.com>
In-Reply-To: <20231128203940.3964287-1-kan.liang@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 28 Nov 2023 22:24:08 -0800
Message-ID: <CAP-5=fUdEgnwk_FNHb-Ju3wCYE2PLLrPHqwZoyBGyURXQhBeSA@mail.gmail.com>
Subject: Re: [PATCH] perf mem: Fix perf mem error on hybrid
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, mingo@redhat.com, peterz@infradead.org, 
	mark.rutland@arm.com, namhyung@kernel.org, jolsa@kernel.org, 
	adrian.hunter@intel.com, ravi.bangoria@amd.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Ammy Yi <ammy.yi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 12:39=E2=80=AFPM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The below error can be triggered on a hybrid machine.
>
>  $ perf mem record -t load sleep 1
>  event syntax error: 'breakpoint/mem-loads,ldlat=3D30/P'
>                                 \___ Bad event or PMU
>
>  Unable to find PMU or event on a PMU of 'breakpoint'
>
> In the perf_mem_events__record_args(), the current perf never checks the
> availability of a mem event on a given PMU. All the PMUs will be added
> to the perf mem event list. Perf errors out for the unsupported PMU.
>
> Extend perf_mem_event__supported() and take a PMU into account. Check
> the mem event for each PMU before adding it to the perf mem event list.
>
> Optimize the perf_mem_events__init() a little bit. The function is to
> check whether the mem events are supported in the system. It doesn't
> need to scan all PMUs. Just return with the first supported PMU is good
> enough.
>
> Fixes: 5752c20f3787 ("perf mem: Scan all PMUs instead of just core ones")
> Reported-by: Ammy Yi <ammy.yi@intel.com>
> Tested-by: Ammy Yi <ammy.yi@intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/util/mem-events.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 954b235e12e5..3a2e3687878c 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -100,11 +100,14 @@ int perf_mem_events__parse(const char *str)
>         return -1;
>  }
>
> -static bool perf_mem_event__supported(const char *mnt, char *sysfs_name)
> +static bool perf_mem_event__supported(const char *mnt, struct perf_pmu *=
pmu,
> +                                     struct perf_mem_event *e)
>  {
> +       char sysfs_name[100];
>         char path[PATH_MAX];
>         struct stat st;
>
> +       scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_name, pmu->nam=
e);

Not sure if this is right. Looking at sysfs_name values:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/mem-events.c?h=3Dperf-tools-next#n23
"cpu/events/mem-loads" and "cpu/events/mem-stores", so won't pmu->name
never be used?
Is there a missed change to change the cpu to %s?

Thanks,
Ian

>         scnprintf(path, PATH_MAX, "%s/devices/%s", mnt, sysfs_name);
>         return !stat(path, &st);
>  }
> @@ -120,7 +123,6 @@ int perf_mem_events__init(void)
>
>         for (j =3D 0; j < PERF_MEM_EVENTS__MAX; j++) {
>                 struct perf_mem_event *e =3D perf_mem_events__ptr(j);
> -               char sysfs_name[100];
>                 struct perf_pmu *pmu =3D NULL;
>
>                 /*
> @@ -136,12 +138,12 @@ int perf_mem_events__init(void)
>                  * of core PMU.
>                  */
>                 while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) {
> -                       scnprintf(sysfs_name, sizeof(sysfs_name), e->sysf=
s_name, pmu->name);
> -                       e->supported |=3D perf_mem_event__supported(mnt, =
sysfs_name);
> +                       e->supported |=3D perf_mem_event__supported(mnt, =
pmu, e);
> +                       if (e->supported) {
> +                               found =3D true;
> +                               break;
> +                       }
>                 }
> -
> -               if (e->supported)
> -                       found =3D true;
>         }
>
>         return found ? 0 : -ENOENT;
> @@ -167,13 +169,10 @@ static void perf_mem_events__print_unsupport_hybrid=
(struct perf_mem_event *e,
>                                                     int idx)
>  {
>         const char *mnt =3D sysfs__mount();
> -       char sysfs_name[100];
>         struct perf_pmu *pmu =3D NULL;
>
>         while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) {
> -               scnprintf(sysfs_name, sizeof(sysfs_name), e->sysfs_name,
> -                         pmu->name);
> -               if (!perf_mem_event__supported(mnt, sysfs_name)) {
> +               if (!perf_mem_event__supported(mnt, pmu, e)) {
>                         pr_err("failed: event '%s' not supported\n",
>                                perf_mem_events__name(idx, pmu->name));
>                 }
> @@ -183,6 +182,7 @@ static void perf_mem_events__print_unsupport_hybrid(s=
truct perf_mem_event *e,
>  int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
>                                  char **rec_tmp, int *tmp_nr)
>  {
> +       const char *mnt =3D sysfs__mount();
>         int i =3D *argv_nr, k =3D 0;
>         struct perf_mem_event *e;
>
> @@ -211,6 +211,9 @@ int perf_mem_events__record_args(const char **rec_arg=
v, int *argv_nr,
>                         while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) =
{
>                                 const char *s =3D perf_mem_events__name(j=
, pmu->name);
>
> +                               if (!perf_mem_event__supported(mnt, pmu, =
e))
> +                                       continue;
> +
>                                 rec_argv[i++] =3D "-e";
>                                 if (s) {
>                                         char *copy =3D strdup(s);
> --
> 2.35.1
>
