Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DD7D522
	for <linux-perf-users@vger.kernel.org>; Thu, 28 Sep 2023 05:00:51 +0000 (UTC)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905A7180;
	Wed, 27 Sep 2023 22:00:49 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-79fe6da0095so147128239f.0;
        Wed, 27 Sep 2023 22:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695877248; x=1696482048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWn+eN+3137J1X9ZFpBev17uHRgqKvmTm2T8zksCQyg=;
        b=SmFoFluwhXnrMsJvmuhWTOqiYHC3tncc47osw25ED6Q75zJlhsAv8zLiXSHCvOIGZ1
         LZW0ab6H5kRPuoydYOzj/uoDseOMdhss3thx114sfOOT6lTrNeq1b5Sq9x10gchkkK16
         K/czxLi5hCu716wZhxaPGbU3iO/UBD/fw8YuZ81RO/OBpiM70mhKpTx+1FFKnPZfo2kn
         lZCZMPMB0k8ZeqaKsHgAX4RQIyru2N+Mffpo48QM584srmVSJF3ARvgvO1/MADVx2oiK
         fTowg1szGYK6vwD6fHOANRltIEPViQYknYHN10OQbJKnZs1EP6+0mQynXhL1raibukRG
         oqOg==
X-Gm-Message-State: AOJu0YyOFsCSR4ZMdgTJEQeDDBPCMTm422CT9HE8oMIbrLGLAHkcrrM5
	nWpagTD7hCl9OwQgpDLIHxMpkyvtG0UnOY2Xepc=
X-Google-Smtp-Source: AGHT+IEDnKI0Uo5Oe0zFwupTSgGg6a0S44wu9mbykzvQSWcbG/9FazNTdataivn+nPeD8nD23UTGmgFKnCf7FDhsdPE=
X-Received: by 2002:a5e:881a:0:b0:798:d82b:7b02 with SMTP id
 l26-20020a5e881a000000b00798d82b7b02mr170144ioj.4.1695877248368; Wed, 27 Sep
 2023 22:00:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925062323.840799-1-irogers@google.com>
In-Reply-To: <20230925062323.840799-1-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 27 Sep 2023 22:00:37 -0700
Message-ID: <CAM9d7chaKGciJgDLyN1hhDXNuFuCHRFcYAjTHY0bEMKpfBDZBg@mail.gmail.com>
Subject: Re: [PATCH v1] perf pmus: Make PMU alias name loading lazy
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Ian,

On Sun, Sep 24, 2023 at 11:24=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> PMU alias names were computed when the first perf_pmu is created,
> scanning all PMUs in event sources for a file called alias that
> generally doesn't exist. Switch to trying to load the file when all
> PMU related files are loaded in lookup. This would cause a PMU name
> lookup of an alias name to fail if no PMUs were loaded, so in that
> case all PMUs are loaded and the find repeated. The overhead is
> similar but in the (very) general case not all PMUs are scanned for
> the alias file.
>
> As the overhead occurs once per invocation it doesn't show in perf
> bench internals pmu-scan. On a tigerlake machine, the number of openat
> system calls for an event of cpu/cycles/ with perf stat reduces from
> 94 to 69 (ie 25 fewer openat calls).

I think the pmu-scan bench could show the difference as it
calls perf_pmu__destroy() in the loop body.  So every call to
perf_pmu__scan() should start from nothing, right?

>
> Signed-off-by: Ian Rogers <irogers@google.com>

Maybe we can load event aliases and formats lazily later.
Anyway, it looks good to me.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/arch/x86/util/pmu.c | 139 ---------------------------------
>  tools/perf/util/pmu.c          |  39 ++++-----
>  tools/perf/util/pmu.h          |   2 -
>  tools/perf/util/pmus.c         |  10 +++
>  4 files changed, 31 insertions(+), 159 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pm=
u.c
> index f428cffb0378..8b53ca468a50 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -17,15 +17,6 @@
>  #include "../../../util/pmus.h"
>  #include "env.h"
>
> -struct pmu_alias {
> -       char *name;
> -       char *alias;
> -       struct list_head list;
> -};
> -
> -static LIST_HEAD(pmu_alias_name_list);
> -static bool cached_list;
> -
>  struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pm=
u __maybe_unused)
>  {
>  #ifdef HAVE_AUXTRACE_SUPPORT
> @@ -41,136 +32,6 @@ struct perf_event_attr *perf_pmu__get_default_config(=
struct perf_pmu *pmu __mayb
>         return NULL;
>  }
>
> -static void pmu_alias__delete(struct pmu_alias *pmu_alias)
> -{
> -       if (!pmu_alias)
> -               return;
> -
> -       zfree(&pmu_alias->name);
> -       zfree(&pmu_alias->alias);
> -       free(pmu_alias);
> -}
> -
> -static struct pmu_alias *pmu_alias__new(char *name, char *alias)
> -{
> -       struct pmu_alias *pmu_alias =3D zalloc(sizeof(*pmu_alias));
> -
> -       if (pmu_alias) {
> -               pmu_alias->name =3D strdup(name);
> -               if (!pmu_alias->name)
> -                       goto out_delete;
> -
> -               pmu_alias->alias =3D strdup(alias);
> -               if (!pmu_alias->alias)
> -                       goto out_delete;
> -       }
> -       return pmu_alias;
> -
> -out_delete:
> -       pmu_alias__delete(pmu_alias);
> -       return NULL;
> -}
> -
> -static int setup_pmu_alias_list(void)
> -{
> -       int fd, dirfd;
> -       DIR *dir;
> -       struct dirent *dent;
> -       struct pmu_alias *pmu_alias;
> -       char buf[MAX_PMU_NAME_LEN];
> -       FILE *file;
> -       int ret =3D -ENOMEM;
> -
> -       dirfd =3D perf_pmu__event_source_devices_fd();
> -       if (dirfd < 0)
> -               return -1;
> -
> -       dir =3D fdopendir(dirfd);
> -       if (!dir)
> -               return -errno;
> -
> -       while ((dent =3D readdir(dir))) {
> -               if (!strcmp(dent->d_name, ".") ||
> -                   !strcmp(dent->d_name, ".."))
> -                       continue;
> -
> -               fd =3D perf_pmu__pathname_fd(dirfd, dent->d_name, "alias"=
, O_RDONLY);
> -               if (fd < 0)
> -                       continue;
> -
> -               file =3D fdopen(fd, "r");
> -               if (!file)
> -                       continue;
> -
> -               if (!fgets(buf, sizeof(buf), file)) {
> -                       fclose(file);
> -                       continue;
> -               }
> -
> -               fclose(file);
> -
> -               /* Remove the last '\n' */
> -               buf[strlen(buf) - 1] =3D 0;
> -
> -               pmu_alias =3D pmu_alias__new(dent->d_name, buf);
> -               if (!pmu_alias)
> -                       goto close_dir;
> -
> -               list_add_tail(&pmu_alias->list, &pmu_alias_name_list);
> -       }
> -
> -       ret =3D 0;
> -
> -close_dir:
> -       closedir(dir);
> -       return ret;
> -}
> -
> -static const char *__pmu_find_real_name(const char *name)
> -{
> -       struct pmu_alias *pmu_alias;
> -
> -       list_for_each_entry(pmu_alias, &pmu_alias_name_list, list) {
> -               if (!strcmp(name, pmu_alias->alias))
> -                       return pmu_alias->name;
> -       }
> -
> -       return name;
> -}
> -
> -const char *pmu_find_real_name(const char *name)
> -{
> -       if (cached_list)
> -               return __pmu_find_real_name(name);
> -
> -       setup_pmu_alias_list();
> -       cached_list =3D true;
> -
> -       return __pmu_find_real_name(name);
> -}
> -
> -static const char *__pmu_find_alias_name(const char *name)
> -{
> -       struct pmu_alias *pmu_alias;
> -
> -       list_for_each_entry(pmu_alias, &pmu_alias_name_list, list) {
> -               if (!strcmp(name, pmu_alias->name))
> -                       return pmu_alias->alias;
> -       }
> -       return NULL;
> -}
> -
> -const char *pmu_find_alias_name(const char *name)
> -{
> -       if (cached_list)
> -               return __pmu_find_alias_name(name);
> -
> -       setup_pmu_alias_list();
> -       cached_list =3D true;
> -
> -       return __pmu_find_alias_name(name);
> -}
> -
>  int perf_pmus__num_mem_pmus(void)
>  {
>         /* AMD uses IBS OP pmu and not a core PMU for perf mem/c2c */
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 0d81c059c91c..0f5c6ed257a8 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -937,16 +937,27 @@ perf_pmu__get_default_config(struct perf_pmu *pmu _=
_maybe_unused)
>         return NULL;
>  }
>
> -const char * __weak
> -pmu_find_real_name(const char *name)
> +static char *pmu_find_alias_name(struct perf_pmu *pmu, int dirfd)
>  {
> -       return name;
> -}
> +       FILE *file =3D perf_pmu__open_file_at(pmu, dirfd, "alias");
> +       char *line =3D NULL;
> +       size_t line_len =3D 0;
> +       ssize_t ret;
>
> -const char * __weak
> -pmu_find_alias_name(const char *name __maybe_unused)
> -{
> -       return NULL;
> +       if (!file)
> +               return NULL;
> +
> +       ret =3D getline(&line, &line_len, file);
> +       if (ret < 0) {
> +               fclose(file);
> +               return NULL;
> +       }
> +       /* Remove trailing newline. */
> +       if (ret > 0 && line[ret - 1] =3D=3D '\n')
> +               line[--ret] =3D '\0';
> +
> +       fclose(file);
> +       return line;
>  }
>
>  static int pmu_max_precise(int dirfd, struct perf_pmu *pmu)
> @@ -957,12 +968,10 @@ static int pmu_max_precise(int dirfd, struct perf_p=
mu *pmu)
>         return max_precise;
>  }
>
> -struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, con=
st char *lookup_name)
> +struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, con=
st char *name)
>  {
>         struct perf_pmu *pmu;
>         __u32 type;
> -       const char *name =3D pmu_find_real_name(lookup_name);
> -       const char *alias_name;
>
>         pmu =3D zalloc(sizeof(*pmu));
>         if (!pmu)
> @@ -995,18 +1004,12 @@ struct perf_pmu *perf_pmu__lookup(struct list_head=
 *pmus, int dirfd, const char
>         pmu->is_core =3D is_pmu_core(name);
>         pmu->cpus =3D pmu_cpumask(dirfd, name, pmu->is_core);
>
> -       alias_name =3D pmu_find_alias_name(name);
> -       if (alias_name) {
> -               pmu->alias_name =3D strdup(alias_name);
> -               if (!pmu->alias_name)
> -                       goto err;
> -       }
> -
>         pmu->type =3D type;
>         pmu->is_uncore =3D pmu_is_uncore(dirfd, name);
>         if (pmu->is_uncore)
>                 pmu->id =3D pmu_id(name);
>         pmu->max_precise =3D pmu_max_precise(dirfd, pmu);
> +       pmu->alias_name =3D pmu_find_alias_name(pmu, dirfd);
>         pmu->events_table =3D perf_pmu__find_events_table(pmu);
>         pmu_add_sys_aliases(pmu);
>         list_add_tail(&pmu->list, pmus);
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 04b317b17d66..bc807729a7cd 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -251,8 +251,6 @@ void perf_pmu__warn_invalid_formats(struct perf_pmu *=
pmu);
>
>  int perf_pmu__match(const char *pattern, const char *name, const char *t=
ok);
>
> -const char *pmu_find_real_name(const char *name);
> -const char *pmu_find_alias_name(const char *name);
>  double perf_pmu__cpu_slots_per_cycle(void);
>  int perf_pmu__event_source_devices_scnprintf(char *pathname, size_t size=
);
>  int perf_pmu__pathname_scnprintf(char *buf, size_t size,
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 64e798e68a2d..ce4931461741 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -37,6 +37,8 @@ static LIST_HEAD(other_pmus);
>  static bool read_sysfs_core_pmus;
>  static bool read_sysfs_all_pmus;
>
> +static void pmu_read_sysfs(bool core_only);
> +
>  int pmu_name_len_no_suffix(const char *str, unsigned long *num)
>  {
>         int orig_len, len;
> @@ -124,6 +126,14 @@ struct perf_pmu *perf_pmus__find(const char *name)
>         pmu =3D perf_pmu__lookup(core_pmu ? &core_pmus : &other_pmus, dir=
fd, name);
>         close(dirfd);
>
> +       if (!pmu) {
> +               /*
> +                * Looking up an inidividual PMU failed. This may mean na=
me is
> +                * an alias, so read the PMUs from sysfs and try to find =
again.
> +                */
> +               pmu_read_sysfs(core_pmu);
> +               pmu =3D pmu_find(name);
> +       }
>         return pmu;
>  }
>
> --
> 2.42.0.515.g380fc7ccd1-goog
>
