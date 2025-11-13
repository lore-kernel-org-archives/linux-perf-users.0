Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4C5350A1C
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053437; cv=none; b=RoF4/HjWaXe8iDwkK886YUuiafvwXdba9iqdJKkB4YPZP5JXgGf3CnGB2qxHYJ/gtEfHeGWsU1YBlEYIJ9s2TRupGG6dY0O8b5Dr6VJOGexzgTLZ3x1P08i6H1EvHvlZUMH6p+6GlX+huPqcoi4LpP+PKOTgmvt7EJAj/7WTHr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053437; c=relaxed/simple;
	bh=/zMxXmRHwMx5FxWXmXYeaHBe4SakYThmwqMi97BanJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hM/4b3Wtyq1TInd/+2ZeOvYY3kJPwt/ltVlQhmkRHnHB+/+VTUh5SJyBn3A7H20NEj8jj5ZR2t5OLqVNLJw2lfkJWmWX3GM+D2GHi1oiTtDZ+W1If8DlVhvSzmkEChzq6F7fGqjtptNBDbeZVyGHL8ZXRtDqdK9p1BhbxcVaw5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rn6HXpDt; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rn6HXpDt"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2980343d9d1so210495ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 09:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763053435; x=1763658235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9jp39PTZnkze60I0QGfIIiLZ0y8RHALzXohze63JW8=;
        b=Rn6HXpDt24ONMgAcpeSTzQM7+ih84v8qdLx4J5E7PH28TDtrKoAx3O75U2/xxEnoAb
         w7ZwIWgspmufsNah4LkISFLRp48J214fJVsFJruujwrv9iegG9zMS5+enG0IEiCYVPsv
         kh3lLor5UQ7DRIIYbYKKG3uy0zoseY0pYFBAtdYmXLE5270KlNxS9+OM933pQcSSI5iJ
         twZAMWGBD4x8fl9ykaxpkBxUvxk1jeH34fRc479k0437UYY+qtW2G/m42hXote+8J50J
         QPHvydTTnePT5NKwWNm971Hoygc0oZfenhqKv23b5mBrTTzkuP+HlrM7yk0UcaW9ttL0
         76EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763053435; x=1763658235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L9jp39PTZnkze60I0QGfIIiLZ0y8RHALzXohze63JW8=;
        b=vejFfB6DFySu6mO7U5CREHdFeggYnjA/QjG2TrNcztsRrSB6gkeBadyLBj9Vi8730j
         IIlK4GgaklXpV8RKi7zcVgdok7rKE6n400t6Net+OpRvTm1Ios+v45U/7/h8tL84O27u
         RAYGijF0N4WJWDFqqfqSnm1DJ//Y4oU7U+1C7IdB6Gagk/gBZd/2arfjj4joV2xbbCAB
         fzkHjSC+V5Th8zE90wX16k2uBIO9TgI6c2fnEkKfTpU52qzHL7tOdNqXu6ujXlnP3tRJ
         uDrWqVqwKj+KWi2VbCNi/Joy3im+es54mmbf4VAws/BImzqFRdr4ndHVjaLeSMVlN2GW
         nrZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyHnO7L2bTfQcesz6vtxCZXLSgadAjR4v2hHlWjw/fhttTy5znQCFnm+MVdBPcy7vZLRPZ3+6bkB1cc8SVpnM9@vger.kernel.org
X-Gm-Message-State: AOJu0YxKo1j0ZetJh+6VcKNJD5XtW+BU745CkvufeQ6HDiGDFBe+86Ei
	9WLJQu0Da6bdvImjLHfSS0UpZFEsSTkqKHGUW3nrCKSndxdPc4CbrCSFCUfrXZ58AFwooTzan9V
	TCOGaeLBdnEDz8rK/5ZdygQdAlwsrwFMLzfq8hF8V
X-Gm-Gg: ASbGncuwVkRuelHjt+lSoLBHj7sWUNsd1XQA7xBUruVHXMkHYhEz0ir0uokZGgJGdtQ
	dSTErmPUMKI3guMtuI0S8gp4hb5vEMp6xm6stB+cYkP1BsgsySOLxhYC5U+3D6NsZwIK/irg/3N
	xkUkFdQ32Z3Thi1iH9Q1YItgvAxmtliqr5kYvIGC1rMs218JR1Z2Z+6CG6kGnIL/kzk4MXlRSAE
	Bve1HYwXWY1mudX3sW52O6J19KMTmrT5XUdRPlBOtuL2Q8DYaqSTRNBrNi475H/yBd/eV3WA43u
	LuG6ng3fw5LeMZFlo++jiY8w/g==
X-Google-Smtp-Source: AGHT+IFg9BvG1WN3LsaStKUeIGWt5YOIvKQjpCAGjZvXUobzmbiejPvoHBnEAurwcNHp2oChrovFcogxaLhAiF1ybP0=
X-Received: by 2002:a17:903:1c6:b0:290:d7fd:6297 with SMTP id
 d9443c01a7336-2985b7b9694mr6329285ad.2.1763053434131; Thu, 13 Nov 2025
 09:03:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112074311.1440101-1-irogers@google.com>
In-Reply-To: <20251112074311.1440101-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 13 Nov 2025 09:03:42 -0800
X-Gm-Features: AWmQ_bk3fzIBvkpTgav6UiP8QeBpseMD099eBJB45q66bKDNiLcosDDUEPVtsEw
Message-ID: <CAP-5=fU6xad0EGzQ=gJy6eUJtYrgV2FKSu=JcndeWVTKZE_RrA@mail.gmail.com>
Subject: Re: [PATCH v2] perf libbfd: Ensure libbfd is initialized prior to use
To: Guilherme Amadio <amadio@gentoo.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 11:43=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> Multiple threads may be creating and destroying BFD objects in
> situations like `perf top`. Without appropriate initialization crashes
> may occur during libbfd's cache management. BFD's locks require
> recursive mutexes, add support for these.
>
> Reported-by: Guilherme Amadio <amadio@gentoo.org>
> Closes: https://lore.kernel.org/lkml/aQt66zhfxSA80xwt@gentoo.org/
> Fixes: 95931d9a594d ("perf libbfd: Move libbfd functionality to its own f=
ile")
> Signed-off-by: Ian Rogers <irogers@google.com>

I'm hoping adding the missing initialization is just obviously
correct, Guilherme if you could provide a Tested-by it would be great.

Thanks,
Ian

> ---
> v2: Remove unneeded unistd.h include.
> ---
>  tools/perf/util/libbfd.c | 38 ++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/mutex.c  | 14 ++++++++++----
>  tools/perf/util/mutex.h  |  2 ++
>  3 files changed, 50 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
> index 01147fbf73b3..6434c2dccd4a 100644
> --- a/tools/perf/util/libbfd.c
> +++ b/tools/perf/util/libbfd.c
> @@ -38,6 +38,39 @@ struct a2l_data {
>         asymbol **syms;
>  };
>
> +static bool perf_bfd_lock(void *bfd_mutex)
> +{
> +       mutex_lock(bfd_mutex);
> +       return true;
> +}
> +
> +static bool perf_bfd_unlock(void *bfd_mutex)
> +{
> +       mutex_unlock(bfd_mutex);
> +       return true;
> +}
> +
> +static void perf_bfd_init(void)
> +{
> +       static struct mutex bfd_mutex;
> +
> +       mutex_init_recursive(&bfd_mutex);
> +
> +       if (bfd_init() !=3D BFD_INIT_MAGIC) {
> +               pr_err("Error initializing libbfd\n");
> +               return;
> +       }
> +       if (!bfd_thread_init(perf_bfd_lock, perf_bfd_unlock, &bfd_mutex))
> +               pr_err("Error initializing libbfd threading\n");
> +}
> +
> +static void ensure_bfd_init(void)
> +{
> +       static pthread_once_t bfd_init_once =3D PTHREAD_ONCE_INIT;
> +
> +       pthread_once(&bfd_init_once, perf_bfd_init);
> +}
> +
>  static int bfd_error(const char *string)
>  {
>         const char *errmsg;
> @@ -132,6 +165,7 @@ static struct a2l_data *addr2line_init(const char *pa=
th)
>         bfd *abfd;
>         struct a2l_data *a2l =3D NULL;
>
> +       ensure_bfd_init();
>         abfd =3D bfd_openr(path, NULL);
>         if (abfd =3D=3D NULL)
>                 return NULL;
> @@ -288,6 +322,7 @@ int dso__load_bfd_symbols(struct dso *dso, const char=
 *debugfile)
>         bfd *abfd;
>         u64 start, len;
>
> +       ensure_bfd_init();
>         abfd =3D bfd_openr(debugfile, NULL);
>         if (!abfd)
>                 return -1;
> @@ -393,6 +428,7 @@ int libbfd__read_build_id(const char *filename, struc=
t build_id *bid, bool block
>         if (fd < 0)
>                 return -1;
>
> +       ensure_bfd_init();
>         abfd =3D bfd_fdopenr(filename, /*target=3D*/NULL, fd);
>         if (!abfd)
>                 return -1;
> @@ -421,6 +457,7 @@ int libbfd_filename__read_debuglink(const char *filen=
ame, char *debuglink,
>         asection *section;
>         bfd *abfd;
>
> +       ensure_bfd_init();
>         abfd =3D bfd_openr(filename, NULL);
>         if (!abfd)
>                 return -1;
> @@ -480,6 +517,7 @@ int symbol__disassemble_bpf_libbfd(struct symbol *sym=
 __maybe_unused,
>         memset(tpath, 0, sizeof(tpath));
>         perf_exe(tpath, sizeof(tpath));
>
> +       ensure_bfd_init();
>         bfdf =3D bfd_openr(tpath, NULL);
>         if (bfdf =3D=3D NULL)
>                 abort();
> diff --git a/tools/perf/util/mutex.c b/tools/perf/util/mutex.c
> index bca7f0717f35..7aa1f3f55a7d 100644
> --- a/tools/perf/util/mutex.c
> +++ b/tools/perf/util/mutex.c
> @@ -17,7 +17,7 @@ static void check_err(const char *fn, int err)
>
>  #define CHECK_ERR(err) check_err(__func__, err)
>
> -static void __mutex_init(struct mutex *mtx, bool pshared)
> +static void __mutex_init(struct mutex *mtx, bool pshared, bool recursive=
)
>  {
>         pthread_mutexattr_t attr;
>
> @@ -27,21 +27,27 @@ static void __mutex_init(struct mutex *mtx, bool psha=
red)
>         /* In normal builds enable error checking, such as recursive usag=
e. */
>         CHECK_ERR(pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_ERRORCHE=
CK));
>  #endif
> +       if (recursive)
> +               CHECK_ERR(pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_=
RECURSIVE));
>         if (pshared)
>                 CHECK_ERR(pthread_mutexattr_setpshared(&attr, PTHREAD_PRO=
CESS_SHARED));
> -
>         CHECK_ERR(pthread_mutex_init(&mtx->lock, &attr));
>         CHECK_ERR(pthread_mutexattr_destroy(&attr));
>  }
>
>  void mutex_init(struct mutex *mtx)
>  {
> -       __mutex_init(mtx, /*pshared=3D*/false);
> +       __mutex_init(mtx, /*pshared=3D*/false, /*recursive=3D*/false);
>  }
>
>  void mutex_init_pshared(struct mutex *mtx)
>  {
> -       __mutex_init(mtx, /*pshared=3D*/true);
> +       __mutex_init(mtx, /*pshared=3D*/true, /*recursive=3D*/false);
> +}
> +
> +void mutex_init_recursive(struct mutex *mtx)
> +{
> +       __mutex_init(mtx, /*pshared=3D*/false, /*recursive=3D*/true);
>  }
>
>  void mutex_destroy(struct mutex *mtx)
> diff --git a/tools/perf/util/mutex.h b/tools/perf/util/mutex.h
> index 38458f00846f..70232d8d094f 100644
> --- a/tools/perf/util/mutex.h
> +++ b/tools/perf/util/mutex.h
> @@ -104,6 +104,8 @@ void mutex_init(struct mutex *mtx);
>   * process-private attribute.
>   */
>  void mutex_init_pshared(struct mutex *mtx);
> +/* Initializes a mutex that may be recursively held on the same thread. =
*/
> +void mutex_init_recursive(struct mutex *mtx);
>  void mutex_destroy(struct mutex *mtx);
>
>  void mutex_lock(struct mutex *mtx) EXCLUSIVE_LOCK_FUNCTION(*mtx);
> --
> 2.51.2.1041.gc1ab5b90ca-goog
>
