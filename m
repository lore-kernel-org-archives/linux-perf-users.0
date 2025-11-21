Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900A62B2DA
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Nov 2025 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763745253; cv=none; b=HmKBuQkqEKx3cEfOUAFzUUSQmdVeuWj2XJ6ejwJEoVQATw2nQjOfVyt7VtHsm7x6vVqWRr/AYwCaTElkmMHcxKxWMZBQOu10XfNufEivKPiM2u7cG99dCdEcbnQlWsGIp+G3h03GO3exE8+S8ajgX1NsvoW8r7+47jxbY0g0xMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763745253; c=relaxed/simple;
	bh=4+eP/s6rfELGO1KMeEkeC+HqXllyRXoFEyddTsvlEMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AiDYWdnZ97yRkz5i24cSKXEdgL1EMiBKmtEJKw8B9OrzvxgrJfM+A9Sy33V/DyYgEfKP4olb5RCd61DSt/m0mp4PzxTMtCEwmD1f9FMtQAlPtCuBmwzFzUvI9cUFkuCme0R/8bYEqNsB7G8vybtgCr4h8crxM69jzmQILwcHIgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QeQUaFJL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QeQUaFJL"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29852dafa7dso202565ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Nov 2025 09:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763745251; x=1764350051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fHkA5bXvXGdkcz4DZ9xrSerUItBeB4S8Hb79A6zE4Q=;
        b=QeQUaFJLYejQW9HlZBD/d6uUjK3gNKVjYd0vkvZIcolRR74gHmCLwpwAwg9DX+QVwj
         RxpTJSCtPka9KoKVRThjmTZl/TsVhtYeM78RG0LFAWqqK6bB//C5mY1AITQ5tQ84h0ck
         HPvIvJ3lTQn/b2OU7i9dD8S2WHRtEeCbk6TXsPV6w29uRSDZ3XETnAtaJLJpukXlEowm
         5lFdwklvSEo0+ptgjkfZTiD7FI1cE/nlGd5numI5rQIUFIofE2H2mcpAd2u11ORA1Ksd
         utoKE/xvNdPxiVRHF/JW8llu5nXkafdgVWXoYIWc+XfHTl9Yt2YlzSz832EskoHLX0L/
         EF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763745251; x=1764350051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/fHkA5bXvXGdkcz4DZ9xrSerUItBeB4S8Hb79A6zE4Q=;
        b=tjfISLE2MBhymwVYHvkPY62kNcMh70kEVIZDBah6ZCBzbWhe6XV6mZJzgZZuk0aXYu
         PYx3mb6vGKClD/IgtpMiI/fg+D23/njdRWXwM78N+sZcT9MrrQAxQm5qzdogcsmj3tAj
         Fc05eDSnipSrYEVNyoVfCRevP82hxvIzLdTo6oPgCImzUvDEg6aPOBznzuCe7tOdwXqi
         ZEO1qCNAKJjMdKJ5Hl0TUdYTDggX80rA2oGIhBl0ItdK9AzvesZKvxvREUybZExxb284
         DLqdQGnLMF1M7Oi9Q4SSSWQVjzxQWTqU4xdeu+ZdFD+zDjvi98enXJi7wA9ZWiNAWugX
         9IoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfBhv5QeceKNFhI3iQdK5rG+ICVhuBv6k3QsICpNll8AFtD1gSEJCyVJ7VQQLX7IX6HUguZjSPoJKQmNOdFUKC@vger.kernel.org
X-Gm-Message-State: AOJu0YwTZYeteMWNIBW1d2cwICucfNcVBwb5QIN4o4PZzbNhNbF/kORA
	fuUG6b8hFlPk2pt89xted96Wt0bVF8gveTkyRzf+dM21ejajhAHeD5CQQ4OwasYddYLMWhATABh
	T+tgN4Co+FeyMs27MONHTWeVzOrjFkjpdYfp1dSQ9
X-Gm-Gg: ASbGncsXM5/K2PM9f5OmIQdT9TfLug6TJbvgH0dCqWQraBE0moSVkur9Rxjj870fTcR
	WKUKhsyWkBDnxZj0S1vaKSTMtsKLmfwjzzXvjzovTncSoglV9MVMiZNxIDJKNlHn1Ujj7WJxoOn
	w0AzSFLwRXTBNrOeaZKYOVzL0FVjaG0JZHL1fNidcz0HHEZf2NfaUHrwiM7UKHZHEFMs4UKI/WR
	1e3Jf1preQP8X9zRRB2yWDo8qyPmiI2EFn9GP7QBB09SB2FF5qGBI+6U59Jm0GBnjjvjOzyRAAv
	/7VZ8tYoUnw0EI73mFHrC4Uh
X-Google-Smtp-Source: AGHT+IEVhP3LbQeLvVIPC6ewGUvF+DwzG1d7XZsW3pCvV34fJS2jGI7dQrG+s2Vdkwz4zA41f0/p7SrPMCURdRwmbAY=
X-Received: by 2002:a17:902:ce8c:b0:294:ecba:c8e with SMTP id
 d9443c01a7336-29b6bcef60amr3113015ad.3.1763745250465; Fri, 21 Nov 2025
 09:14:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121-james-perf-non-block-v1-1-6ab2702ab573@linaro.org>
In-Reply-To: <20251121-james-perf-non-block-v1-1-6ab2702ab573@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 21 Nov 2025 09:13:59 -0800
X-Gm-Features: AWmQ_blOnKZlLgbo3J32qTgQY3ytSWzP4H1OPQYh2U-nxclDP-dom0e0bHG-Zm4
Message-ID: <CAP-5=fVj-EQK=Dz8RRjrG+s1oH=1JrYzVu=oDGUHpP_iD=gP_A@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Don't read build-ids from non-regular files
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 6:21=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> Simplify the build ID reading code by removing the non-blocking option.
> Having to pass the correct option to this function was fragile and a
> mistake would result in a hang, see the linked fix. Furthermore,
> compressed files are always opened blocking anyway, ignoring the
> non-blocking option.
>
> We also don't expect to read build IDs from non-regular files. The only
> hits to this function that are non-regular are devices that won't be elf
> files with build IDs, for example "/dev/dri/renderD129".
>
> Now instead of opening these as non-blocking and failing to read, we
> skip them. Even if something like a pipe or character device did have a
> build ID, I don't think it would have worked because you need to call
> read() in a loop, check for -EAGAIN and handle timeouts to make
> non-blocking reads work.
>
> Link: https://lore.kernel.org/linux-perf-users/20251022-james-perf-fix-ds=
o-block-v1-1-c4faab150546@linaro.org/
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
> I looked at the paths for hits to this function and found the following
> categories:
>
> Devices, which non-block reads were unsuccessfully attempted, but are
> now skipped:
>  * /dev/dri/renderD129
>
> Non-valid paths, where 'non-regular' is irrelevant e.g.:
>  * [vdso]
>  * ... (deleted)
>  * anon_inode:i915.gem
>
> Shared memory. These are regular and blocking reads work, so no changes
> there:
>  * /dev/shm/.org.chromium.Chromium.ejhzXY
>
> Symlinks to regular files. Also no change as is_regular_file() is true
> for these too.
> ---
>  tools/perf/bench/inject-buildid.c  |  2 +-
>  tools/perf/builtin-buildid-cache.c |  8 ++++----
>  tools/perf/builtin-inject.c        |  4 ++--
>  tools/perf/tests/pe-file-parsing.c |  4 ++--
>  tools/perf/tests/sdt.c             |  2 +-
>  tools/perf/util/build-id.c         |  4 ++--
>  tools/perf/util/debuginfo.c        |  2 +-
>  tools/perf/util/dsos.c             |  4 ++--
>  tools/perf/util/libbfd.c           |  4 ++--
>  tools/perf/util/libbfd.h           |  5 ++---
>  tools/perf/util/symbol-elf.c       | 13 ++++++-------
>  tools/perf/util/symbol-minimal.c   |  9 ++++++---
>  tools/perf/util/symbol.c           |  5 ++---
>  tools/perf/util/symbol.h           |  2 +-
>  tools/perf/util/synthetic-events.c |  2 +-
>  15 files changed, 35 insertions(+), 35 deletions(-)
>
> diff --git a/tools/perf/bench/inject-buildid.c b/tools/perf/bench/inject-=
buildid.c
> index 12387ea88b9a..aad572a78d7f 100644
> --- a/tools/perf/bench/inject-buildid.c
> +++ b/tools/perf/bench/inject-buildid.c
> @@ -85,7 +85,7 @@ static int add_dso(const char *fpath, const struct stat=
 *sb __maybe_unused,
>         if (typeflag =3D=3D FTW_D || typeflag =3D=3D FTW_SL)
>                 return 0;
>
> -       if (filename__read_build_id(fpath, &bid, /*block=3D*/true) < 0)
> +       if (filename__read_build_id(fpath, &bid) < 0)
>                 return 0;
>
>         dso->name =3D realpath(fpath, NULL);
> diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buil=
did-cache.c
> index 2e0f2004696a..c98104481c8a 100644
> --- a/tools/perf/builtin-buildid-cache.c
> +++ b/tools/perf/builtin-buildid-cache.c
> @@ -180,7 +180,7 @@ static int build_id_cache__add_file(const char *filen=
ame, struct nsinfo *nsi)
>         struct nscookie nsc;
>
>         nsinfo__mountns_enter(nsi, &nsc);
> -       err =3D filename__read_build_id(filename, &bid, /*block=3D*/true)=
;
> +       err =3D filename__read_build_id(filename, &bid);
>         nsinfo__mountns_exit(&nsc);
>         if (err < 0) {
>                 pr_debug("Couldn't read a build-id in %s\n", filename);
> @@ -204,7 +204,7 @@ static int build_id_cache__remove_file(const char *fi=
lename, struct nsinfo *nsi)
>         int err;
>
>         nsinfo__mountns_enter(nsi, &nsc);
> -       err =3D filename__read_build_id(filename, &bid, /*block=3D*/true)=
;
> +       err =3D filename__read_build_id(filename, &bid);
>         nsinfo__mountns_exit(&nsc);
>         if (err < 0) {
>                 pr_debug("Couldn't read a build-id in %s\n", filename);
> @@ -280,7 +280,7 @@ static bool dso__missing_buildid_cache(struct dso *ds=
o, int parm __maybe_unused)
>         if (!dso__build_id_filename(dso, filename, sizeof(filename), fals=
e))
>                 return true;
>
> -       if (filename__read_build_id(filename, &bid, /*block=3D*/true) =3D=
=3D -1) {
> +       if (filename__read_build_id(filename, &bid) =3D=3D -1) {
>                 if (errno =3D=3D ENOENT)
>                         return false;
>
> @@ -309,7 +309,7 @@ static int build_id_cache__update_file(const char *fi=
lename, struct nsinfo *nsi)
>         int err;
>
>         nsinfo__mountns_enter(nsi, &nsc);
> -       err =3D filename__read_build_id(filename, &bid, /*block=3D*/true)=
;
> +       err =3D filename__read_build_id(filename, &bid);
>         nsinfo__mountns_exit(&nsc);
>         if (err < 0) {
>                 pr_debug("Couldn't read a build-id in %s\n", filename);
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index bd9245d2dd41..0e40f2a4bd18 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -668,12 +668,12 @@ static int dso__read_build_id(struct dso *dso)
>
>         mutex_lock(dso__lock(dso));
>         nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
> -       if (filename__read_build_id(dso__long_name(dso), &bid, /*block=3D=
*/true) > 0)
> +       if (filename__read_build_id(dso__long_name(dso), &bid) > 0)
>                 dso__set_build_id(dso, &bid);
>         else if (dso__nsinfo(dso)) {
>                 char *new_name =3D dso__filename_with_chroot(dso, dso__lo=
ng_name(dso));
>
> -               if (new_name && filename__read_build_id(new_name, &bid, /=
*block=3D*/true) > 0)
> +               if (new_name && filename__read_build_id(new_name, &bid) >=
 0)
>                         dso__set_build_id(dso, &bid);
>                 free(new_name);
>         }
> diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-fil=
e-parsing.c
> index 8b31d1d05f90..30c7da79e109 100644
> --- a/tools/perf/tests/pe-file-parsing.c
> +++ b/tools/perf/tests/pe-file-parsing.c
> @@ -37,7 +37,7 @@ static int run_dir(const char *d)
>         size_t idx;
>
>         scnprintf(filename, PATH_MAX, "%s/pe-file.exe", d);
> -       ret =3D filename__read_build_id(filename, &bid, /*block=3D*/true)=
;
> +       ret =3D filename__read_build_id(filename, &bid);
>         TEST_ASSERT_VAL("Failed to read build_id",
>                         ret =3D=3D sizeof(expect_build_id));
>         TEST_ASSERT_VAL("Wrong build_id", !memcmp(bid.data, expect_build_=
id,
> @@ -49,7 +49,7 @@ static int run_dir(const char *d)
>                         !strcmp(debuglink, expect_debuglink));
>
>         scnprintf(debugfile, PATH_MAX, "%s/%s", d, debuglink);
> -       ret =3D filename__read_build_id(debugfile, &bid, /*block=3D*/true=
);
> +       ret =3D filename__read_build_id(debugfile, &bid);
>         TEST_ASSERT_VAL("Failed to read debug file build_id",
>                         ret =3D=3D sizeof(expect_build_id));
>         TEST_ASSERT_VAL("Wrong build_id", !memcmp(bid.data, expect_build_=
id,
> diff --git a/tools/perf/tests/sdt.c b/tools/perf/tests/sdt.c
> index 6132f1af3e22..93baee2eae42 100644
> --- a/tools/perf/tests/sdt.c
> +++ b/tools/perf/tests/sdt.c
> @@ -31,7 +31,7 @@ static int build_id_cache__add_file(const char *filenam=
e)
>         struct build_id bid =3D { .size =3D 0, };
>         int err;
>
> -       err =3D filename__read_build_id(filename, &bid, /*block=3D*/true)=
;
> +       err =3D filename__read_build_id(filename, &bid);
>         if (err < 0) {
>                 pr_debug("Failed to read build id of %s\n", filename);
>                 return err;
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index 35505a1ffd11..fdb35133fde4 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -122,7 +122,7 @@ int filename__snprintf_build_id(const char *pathname,=
 char *sbuild_id, size_t sb
>         struct build_id bid =3D { .size =3D 0, };
>         int ret;
>
> -       ret =3D filename__read_build_id(pathname, &bid, /*block=3D*/true)=
;
> +       ret =3D filename__read_build_id(pathname, &bid);
>         if (ret < 0)
>                 return ret;
>
> @@ -848,7 +848,7 @@ static int filename__read_build_id_ns(const char *fil=
ename,
>         int ret;
>
>         nsinfo__mountns_enter(nsi, &nsc);
> -       ret =3D filename__read_build_id(filename, bid, /*block=3D*/true);
> +       ret =3D filename__read_build_id(filename, bid);
>         nsinfo__mountns_exit(&nsc);
>
>         return ret;
> diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
> index bb9ebd84ec2d..4a559b3e8cdc 100644
> --- a/tools/perf/util/debuginfo.c
> +++ b/tools/perf/util/debuginfo.c
> @@ -115,7 +115,7 @@ struct debuginfo *debuginfo__new(const char *path)
>          * incase the path isn't for a regular file.
>          */
>         assert(!dso__has_build_id(dso));
> -       if (filename__read_build_id(path, &bid, /*block=3D*/false) > 0)
> +       if (filename__read_build_id(path, &bid) > 0)
>                 dso__set_build_id(dso, &bid);
>
>         for (type =3D distro_dwarf_types;
> diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
> index 64c1d65b0149..0a7645c7fae7 100644
> --- a/tools/perf/util/dsos.c
> +++ b/tools/perf/util/dsos.c
> @@ -81,13 +81,13 @@ static int dsos__read_build_ids_cb(struct dso *dso, v=
oid *data)
>                 return 0;
>         }
>         nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
> -       if (filename__read_build_id(dso__long_name(dso), &bid, /*block=3D=
*/true) > 0) {
> +       if (filename__read_build_id(dso__long_name(dso), &bid) > 0) {
>                 dso__set_build_id(dso, &bid);
>                 args->have_build_id =3D true;
>         } else if (errno =3D=3D ENOENT && dso__nsinfo(dso)) {
>                 char *new_name =3D dso__filename_with_chroot(dso, dso__lo=
ng_name(dso));
>
> -               if (new_name && filename__read_build_id(new_name, &bid, /=
*block=3D*/true) > 0) {
> +               if (new_name && filename__read_build_id(new_name, &bid) >=
 0) {
>                         dso__set_build_id(dso, &bid);
>                         args->have_build_id =3D true;
>                 }
> diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
> index 01147fbf73b3..91b431eae0d7 100644
> --- a/tools/perf/util/libbfd.c
> +++ b/tools/perf/util/libbfd.c
> @@ -383,13 +383,13 @@ int dso__load_bfd_symbols(struct dso *dso, const ch=
ar *debugfile)
>         return err;
>  }
>
> -int libbfd__read_build_id(const char *filename, struct build_id *bid, bo=
ol block)
> +int libbfd__read_build_id(const char *filename, struct build_id *bid)
>  {
>         size_t size =3D sizeof(bid->data);
>         int err =3D -1, fd;
>         bfd *abfd;
>
> -       fd =3D open(filename, block ? O_RDONLY : (O_RDONLY | O_NONBLOCK))=
;
> +       fd =3D open(filename, O_RDONLY);

We will need the is_regular_file test here.

>         if (fd < 0)
>                 return -1;
>
> diff --git a/tools/perf/util/libbfd.h b/tools/perf/util/libbfd.h
> index e300f171d1bd..953886f3d62f 100644
> --- a/tools/perf/util/libbfd.h
> +++ b/tools/perf/util/libbfd.h
> @@ -25,7 +25,7 @@ void dso__free_a2l_libbfd(struct dso *dso);
>  int symbol__disassemble_libbfd(const char *filename, struct symbol *sym,
>                              struct annotate_args *args);
>
> -int libbfd__read_build_id(const char *filename, struct build_id *bid, bo=
ol block);
> +int libbfd__read_build_id(const char *filename, struct build_id *bid);
>
>  int libbfd_filename__read_debuglink(const char *filename, char *debuglin=
k, size_t size);
>
> @@ -59,8 +59,7 @@ static inline int symbol__disassemble_libbfd(const char=
 *filename __always_unuse
>  }
>
>  static inline int libbfd__read_build_id(const char *filename __always_un=
used,
> -                                       struct build_id *bid __always_unu=
sed,
> -                                       bool block __always_unused)
> +                                       struct build_id *bid __always_unu=
sed)
>  {
>         return -1;
>  }
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 9e820599bab3..6b35c5bec610 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -860,20 +860,20 @@ static int elf_read_build_id(Elf *elf, void *bf, si=
ze_t size)
>         return err;
>  }
>
> -static int read_build_id(const char *filename, struct build_id *bid, boo=
l block)
> +static int read_build_id(const char *filename, struct build_id *bid)
>  {
>         size_t size =3D sizeof(bid->data);
>         int fd, err;
>         Elf *elf;
>
> -       err =3D libbfd__read_build_id(filename, bid, block);
> +       err =3D libbfd__read_build_id(filename, bid);
>         if (err >=3D 0)
>                 goto out;
>
>         if (size < BUILD_ID_SIZE)
>                 goto out;
>
> -       fd =3D open(filename, block ? O_RDONLY : (O_RDONLY | O_NONBLOCK))=
;
> +       fd =3D open(filename, O_RDONLY);
>         if (fd < 0)
>                 goto out;
>
> @@ -894,13 +894,13 @@ static int read_build_id(const char *filename, stru=
ct build_id *bid, bool block)
>         return err;
>  }
>
> -int filename__read_build_id(const char *filename, struct build_id *bid, =
bool block)
> +int filename__read_build_id(const char *filename, struct build_id *bid)
>  {
>         struct kmod_path m =3D { .name =3D NULL, };
>         char path[PATH_MAX];
>         int err;
>
> -       if (!filename)
> +       if (!filename || !is_regular_file(filename))
>                 return -EFAULT;

I wonder if -EWOULDBLOCK would be a better return code for the
!is_regular_file test?

>
>         err =3D kmod_path__parse(&m, filename);
> @@ -918,10 +918,9 @@ int filename__read_build_id(const char *filename, st=
ruct build_id *bid, bool blo
>                 }
>                 close(fd);
>                 filename =3D path;
> -               block =3D true;
>         }
>
> -       err =3D read_build_id(filename, bid, block);
> +       err =3D read_build_id(filename, bid);
>
>         if (m.comp)
>                 unlink(filename);
> diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-mi=
nimal.c
> index aeb253248895..b811db4157ab 100644
> --- a/tools/perf/util/symbol-minimal.c
> +++ b/tools/perf/util/symbol-minimal.c
> @@ -85,7 +85,7 @@ int filename__read_debuglink(const char *filename __may=
be_unused,
>  /*
>   * Just try PT_NOTE header otherwise fails
>   */
> -int filename__read_build_id(const char *filename, struct build_id *bid, =
bool block)
> +int filename__read_build_id(const char *filename, struct build_id *bid)
>  {
>         int fd, ret =3D -1;
>         bool need_swap =3D false, elf32;
> @@ -102,7 +102,10 @@ int filename__read_build_id(const char *filename, st=
ruct build_id *bid, bool blo
>         void *phdr, *buf =3D NULL;
>         ssize_t phdr_size, ehdr_size, buf_size =3D 0;
>
> -       fd =3D open(filename, block ? O_RDONLY : (O_RDONLY | O_NONBLOCK))=
;
> +       if (!filename || !is_regular_file(filename))
> +               return -EFAULT;

Same here.

Thanks,
Ian

> +
> +       fd =3D open(filename, O_RDONLY);
>         if (fd < 0)
>                 return -1;
>
> @@ -323,7 +326,7 @@ int dso__load_sym(struct dso *dso, struct map *map __=
maybe_unused,
>         if (ret >=3D 0)
>                 RC_CHK_ACCESS(dso)->is_64_bit =3D ret;
>
> -       if (filename__read_build_id(ss->name, &bid, /*block=3D*/true) > 0=
)
> +       if (filename__read_build_id(ss->name, &bid) > 0)
>                 dso__set_build_id(dso, &bid);
>         return 0;
>  }
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index cc26b7bf302b..d8fc5ea77f84 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1743,14 +1743,13 @@ int dso__load(struct dso *dso, struct map *map)
>
>         /*
>          * Read the build id if possible. This is required for
> -        * DSO_BINARY_TYPE__BUILDID_DEBUGINFO to work. Don't block in cas=
e path
> -        * isn't for a regular file.
> +        * DSO_BINARY_TYPE__BUILDID_DEBUGINFO to work.
>          */
>         if (!dso__has_build_id(dso)) {
>                 struct build_id bid =3D { .size =3D 0, };
>
>                 __symbol__join_symfs(name, PATH_MAX, dso__long_name(dso))=
;
> -               if (filename__read_build_id(name, &bid, /*block=3D*/false=
) > 0)
> +               if (filename__read_build_id(name, &bid) > 0)
>                         dso__set_build_id(dso, &bid);
>         }
>
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index 347106218799..3fb5d146d9b1 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -140,7 +140,7 @@ struct symbol *dso__next_symbol(struct symbol *sym);
>
>  enum dso_type dso__type_fd(int fd);
>
> -int filename__read_build_id(const char *filename, struct build_id *id, b=
ool block);
> +int filename__read_build_id(const char *filename, struct build_id *id);
>  int sysfs__read_build_id(const char *filename, struct build_id *bid);
>  int modules__parse(const char *filename, void *arg,
>                    int (*process_module)(void *arg, const char *name,
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index 5aa44c4aba62..2ba9fa25e00a 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -401,7 +401,7 @@ static void perf_record_mmap2__read_build_id(struct p=
erf_record_mmap2 *event,
>         nsi =3D nsinfo__new(event->pid);
>         nsinfo__mountns_enter(nsi, &nc);
>
> -       rc =3D filename__read_build_id(event->filename, &bid, /*block=3D*=
/false) > 0 ? 0 : -1;
> +       rc =3D filename__read_build_id(event->filename, &bid) > 0 ? 0 : -=
1;
>
>         nsinfo__mountns_exit(&nc);
>         nsinfo__put(nsi);
>
> ---
> base-commit: 134852abcbfa5f6a4a17619c8f44c857f800ae03
> change-id: 20251119-james-perf-non-block-3296c96909aa
>
> Best regards,
> --
> James Clark <james.clark@linaro.org>
>
