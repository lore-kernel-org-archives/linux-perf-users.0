Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FF029CE1
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 00:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768351563; cv=pass; b=YvDgaPyaJx9nJjpR33BCXtn3A2bD9UxXxFqJhYIfCMmAlZrspEYmoQ3rZxGc1w5LiUifdXIu+HL77BSwzshkn/ex5jAovppukDAx8GqYlhfVE6F6svE9CVCRTvfH9NYGdL7PL59DiIrZglLqOatvpS/zUgGCOvxAXoAG9VX7SC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768351563; c=relaxed/simple;
	bh=cZguz2z9KYR9uIePJq9T/79HDv2M87pDUwWRQm6DQFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMmpUdoadkk0JQbmqgL7QGtqtLLtcjp3LlvLe9ibTcKSX+p9mmLR+wL6+endJ20gzw3rc1dDNac5rz21GkAU+2cQe0NzJpMn1C5bVzi8vKh0DXruEPJfgMOzFZ8wYxZfEuXWOcKMaRdUb/xd8xyF8R7H6Lxol9mxN6PatqKFVws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3RyBpY/E; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3RyBpY/E"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29f02651fccso30765ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jan 2026 16:46:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768351561; cv=none;
        d=google.com; s=arc-20240605;
        b=ZZdz+rbiZRMfMzp5wd+zY9Duo7GWPMhSmFF+6L/zwubBvtOdc+nccabkHyLwYiPium
         iBkZBui0Qeeeauj9L5R+DaixNTj9mydrESpsjy8XySiJahmViD+IChGnBFhj6bLbj0Sw
         qN9lP8fh522RnG/FOR+gSzV5EH5SjehUP0E813Bw6WrP8ASeiL0EornXnlPVIBrQY6du
         jEeFz+NtvDYmRmCjHHvHe+ST3A0jxhWcy+zbl+lIn/FiiMPRi3yXuKiwVtd5j2qv+ntn
         8Y9Vss8uOotrZPOdvGsjD3+YfTmZd6MeilKGp50vHsEWM2DhJcIfiqnezBp5p54LE1r/
         2JUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sSRY80aHidtcTGCyOCewYizbr1fOXy5wVFHAwp9wyq4=;
        fh=YpuwaDcWGKg1DiAJTPBPiEUi8X0pJgO3oA0tOpU7yzw=;
        b=iPmWHkBlM+SWGYn5OHMB7mza0X+dIK4iop7HQuH9caS6vsk2otgpbNxLjoM8HPtxec
         RkpZG6ErRqZODCQP16p3RiuozwMIfPBXDWROfIhEIPTXRfHETyS/Zo43VYjrpVxFXLOQ
         y7Dpt11VqIGXjpJndopWNFfApeUShZsPsS9W5hftm+yE5EjLX8UAYF9sq/mc8t47Npye
         FtJINsHZ/ObVd4CmTShXH/m1Nb8Y08w1L3UBcUcqvuV1L5dtUvh8cWccLvr3nNz4H7NV
         ViFTifJzo0M4BlP6SNo0r1NGOFMPZm/sVesErBnbYlglav78OB6LkrfJs52Y3DAGowny
         uDOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768351561; x=1768956361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSRY80aHidtcTGCyOCewYizbr1fOXy5wVFHAwp9wyq4=;
        b=3RyBpY/E+SVbFf7WW7vJpo+2Ruq8Gg6W7oS6N029z7RMg8SpzG3nQAXh64vREaCjZl
         bgYf31HaYAxFuvMm//4aSgbPGCjFzDuMar/fNpIqasG9Z0DpnmJGZOj3vmK3YjW9OWrz
         BZVnG1Xq4kwEUneW7GpQXUWzmh2iHIhySbT6ltqiGnBaaAKSAxn/z7OUodeSKak2D5X8
         8ruAtKgjUJr+wt2WJlVfXC7mlUOEmYc7UlMBOLjM4IWF1oalVBAkAvumpdUtNY//npT6
         OXgNqLA2/EM2dvyLgwDB8i+0FzoI0EogPhoUXsE6AP3zB9Pf9IvDVMHXtKCtfhhuRONU
         JRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768351561; x=1768956361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sSRY80aHidtcTGCyOCewYizbr1fOXy5wVFHAwp9wyq4=;
        b=SVvo2foS4ajVCKTDoPWU6+ePeFFY5JU1IwYgJdMdxEDjtcHkw/K/QCPWtjQWeuIits
         5heJlTBtX5/t1/4g8O2L0Pf2lkof4NLBidzuCQNngfr55hhTCKtgYFpMUGMgu9n7DDfD
         nLBHrUvHFTU1KY2hBtU7LwQ2ViuY2T61zqek9jm+UFZrK9xBc9oaNq9Osml7Lhokjm5D
         jwX0cWCuqpQGBQ5FMFqmbSDq4wlsmHEjvbRgEQqC9Nlz48buiRYbALvKG26AQnrLYmyC
         y4IKP1FOE10+uQJfCnZ/IqqgpvlclnNjim7P1HIR8Nk5FcGT01H90dW8kD3/2ZmariIM
         uqrg==
X-Forwarded-Encrypted: i=1; AJvYcCW/LMubXwOmeseeBmRgrAoinVWsUG9sSH9nfuMhvOFDDaqv3SC/j06OJisjvGPRSzmrCtXpvujxGH25bj2Y271/@vger.kernel.org
X-Gm-Message-State: AOJu0YxkAJWcO4BkBTGQ+dZEbGYMxkp2RRuUc4gdO9W84GvuzX3WLwRS
	dgFBgwWG8fL8NR4/CtUFQG9KJRsM5+DBD7ASxyWt2VLfLIkZwkCUwW+XQWST6LGDbdmmTUKcpR/
	7Oc4TRTFj978ssc/pgCGb+V7tzkUhFQLtE3JR5HSe
X-Gm-Gg: AY/fxX4ytyIAOMe2CQbJFKOe93ZR0a+lQ+2TxjyXsHadvh0ZDmDGMNUC/X5v69LPCng
	XucLyzjVEnmdTi0ddzJ82KTCB72IFmhFxhLGLgPyDP2lX/6zoPLEn6MkRIRE0ZKv+Yc51jpdLMk
	EngSQDQLY2t48laIsKD+oLsvLMYlLqvls2J+YywcLubz6ioIW0+07h5ImW23w7DTUjTVV5xLTj3
	6yW3tOXumWtMnbhrNXeO1hAhkle2OEsYzUhNkp9tcNNLJX3Qg7Ansr7wMAPV+2ywCie8I0SujPB
	3U0bZvJ+Roj4DUdBjJENQrWX9Q==
X-Received: by 2002:a17:902:e890:b0:265:e66:6c10 with SMTP id
 d9443c01a7336-2a599a24a2amr1623665ad.4.1768351561256; Tue, 13 Jan 2026
 16:46:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113233757.62347-1-namhyung@kernel.org>
In-Reply-To: <20260113233757.62347-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 Jan 2026 16:45:50 -0800
X-Gm-Features: AZwV_QiY5_FFF45LtiYOfrvxPks12q3FUavbEGrt2jwvSoNXUvbHyekthPiX8F4
Message-ID: <CAP-5=fX+zw-CUEYEtrPA6vYUKqpp4LZp-p==QsbZaNwLcX0Whw@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Get debug info of DSO properly
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 3:37=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The dso__debuginfo() just used the path name to open the file but it may
> be outdated.  It should check build-ID and use the file in the build-ID
> cache if available rather than just using the path name.
>
> Let's factor out dso__get_filename() to avoid code duplicate.

This change lgtm:

Reviewed-by: Ian Rogers <irogers@google.com>

I should have recognized this earlier, we seem to be getting multiple
copies of the dwfl and I wonder repeatedly parsing the debug info has
costs:
1) for arch powerpc there is a dwfl used in
tools/perf/arch/powerpc/util/skip-callchain-idx.c
2) there is a dwfl for the libdw addr2line
3) there is a dwfl in debuginfo
4) there is a dwfl in unwind_info in unwind-libdw

So 1 and 2 both associate the dwfl with the dso and lazily add it, 1
leaks the dwfl whereas 2 ties it to the lifetime of the dso.
For 3 there are individual debuginfo uses as well as a debuginfo cache
in probe-event.
For 4 the lifetime is an unwind of a stacktrace by unwind__get_entries.

1 and 4 load an ELF with a path using dwfl_report_elf  and specifying
a base load address.
2 and 3 use dwfl_report_offline with no load address.

My understanding is that if you have the Dwfl the Dwfl_module and
Dwarf are cheap to compute. The module is cached in the Dwfl and with
a single Dwfl/Dwfl_module per dso then there should only ever be 1
value:
https://github.com/cuviper/elfutils/blob/master/libdwfl/libdwflP.h#L131
And the Dwarf is held in the module:
https://github.com/cuviper/elfutils/blob/master/libdwfl/libdwflP.h#L195
This makes me think the debuginfo may be holding onto more values than
it needs to and perhaps we can simplify it.

I think ideally we'd have a single Dwfl but that means the
Dwfl_modules will need different addresses to avoid overlapping. It
doesn't seem to be possible to relocate a module once it is loaded
(e.g with dwfl_module_relocate_address -
https://github.com/cuviper/elfutils/blob/master/libdwfl/libdwfl.h#L397)
and so we'd need some way to come up with an address to keep the
modules separate (we couldn't just use the virtual address for a
thread as the module address may differ per thread in different
processes).

So I wonder if we should have a single global Dwfl, and have each dso
have a made up load address to get the Dwfl_Module from it - the dso
could hold the Dwfl_Module* or the made up load address. 1 and 4 can
use their current base load address and adjust it by the made up load
address that would be associated with the dso. 2 and 3 can just use
the made up load address with the dso to get the module and possibly
with (2) remove some of the bias logic. This should speed up a bunch
of things by avoiding unnecessary/repeated dwfl_report_elf and
dwfl_report_offline calls, it would also cut down on duplication.

Thanks,
Ian

> Fixes: 53a61a6ca279165d ("perf annotate: Add dso__debuginfo() helper")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/dso.c | 63 ++++++++++++++++++++++++++++++++-----------
>  tools/perf/util/dso.h | 11 ++------
>  2 files changed, 50 insertions(+), 24 deletions(-)
>
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 06980844c014ec9b..922fcc2f798baa57 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -112,7 +112,7 @@ bool dso__is_object_file(const struct dso *dso)
>
>  int dso__read_binary_type_filename(const struct dso *dso,
>                                    enum dso_binary_type type,
> -                                  char *root_dir, char *filename, size_t=
 size)
> +                                  const char *root_dir, char *filename, =
size_t size)
>  {
>         char build_id_hex[SBUILD_ID_SIZE];
>         int ret =3D 0;
> @@ -564,20 +564,15 @@ char *dso__filename_with_chroot(const struct dso *d=
so, const char *filename)
>         return filename_with_chroot(nsinfo__pid(dso__nsinfo_const(dso)), =
filename);
>  }
>
> -static int __open_dso(struct dso *dso, struct machine *machine)
> -       EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
> +static char *dso__get_filename(struct dso *dso, const char *root_dir,
> +                              bool *decomp)
>  {
> -       int fd =3D -EINVAL;
> -       char *root_dir =3D (char *)"";
>         char *name =3D malloc(PATH_MAX);
> -       bool decomp =3D false;
>
> -       if (!name)
> -               return -ENOMEM;
> +       *decomp =3D false;
>
> -       mutex_lock(dso__lock(dso));
> -       if (machine)
> -               root_dir =3D machine->root_dir;
> +       if (name =3D=3D NULL)
> +               return NULL;
>
>         if (dso__read_binary_type_filename(dso, dso__binary_type(dso),
>                                             root_dir, name, PATH_MAX))
> @@ -602,20 +597,38 @@ static int __open_dso(struct dso *dso, struct machi=
ne *machine)
>                 size_t len =3D sizeof(newpath);
>
>                 if (dso__decompress_kmodule_path(dso, name, newpath, len)=
 < 0) {
> -                       fd =3D -(*dso__load_errno(dso));
> +                       errno =3D *dso__load_errno(dso);
>                         goto out;
>                 }
>
> -               decomp =3D true;
> +               *decomp =3D true;
>                 strcpy(name, newpath);
>         }
> +       return name;
> +
> +out:
> +       free(name);
> +       return NULL;
> +}
>
> -       fd =3D do_open(name);
> +static int __open_dso(struct dso *dso, struct machine *machine)
> +       EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
> +{
> +       int fd =3D -EINVAL;
> +       char *name;
> +       bool decomp =3D false;
> +
> +       mutex_lock(dso__lock(dso));
> +
> +       name =3D dso__get_filename(dso, machine ? machine->root_dir : "",=
 &decomp);
> +       if (name)
> +               fd =3D do_open(name);
> +       else
> +               fd =3D -errno;
>
>         if (decomp)
>                 unlink(name);
>
> -out:
>         mutex_unlock(dso__lock(dso));
>         free(name);
>         return fd;
> @@ -1912,3 +1925,23 @@ const u8 *dso__read_symbol(struct dso *dso, const =
char *symfs_filename,
>         return __dso__read_symbol(dso, symfs_filename, start, len,
>                                   out_buf, out_buf_len, is_64bit);
>  }
> +
> +struct debuginfo *dso__debuginfo(struct dso *dso)
> +{
> +       char *name;
> +       bool decomp =3D false;
> +       struct debuginfo *dinfo =3D NULL;
> +
> +       mutex_lock(dso__lock(dso));
> +
> +       name =3D dso__get_filename(dso, "", &decomp);
> +       if (name)
> +               dinfo =3D debuginfo__new(name);
> +
> +       if (decomp)
> +               unlink(name);
> +
> +       mutex_unlock(dso__lock(dso));
> +       free(name);
> +       return dinfo;
> +}
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index 4aee23775054cf83..3dd7d0fc00797f37 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -777,7 +777,7 @@ int dso__kernel_module_get_build_id(struct dso *dso, =
const char *root_dir);
>
>  char dso__symtab_origin(const struct dso *dso);
>  int dso__read_binary_type_filename(const struct dso *dso, enum dso_binar=
y_type type,
> -                                  char *root_dir, char *filename, size_t=
 size);
> +                                  const char *root_dir, char *filename, =
size_t size);
>  bool is_kernel_module(const char *pathname, int cpumode);
>  bool dso__needs_decompress(struct dso *dso);
>  int dso__decompress_kmodule_fd(struct dso *dso, const char *name);
> @@ -926,14 +926,7 @@ u64 dso__findnew_global_type(struct dso *dso, u64 ad=
dr, u64 offset);
>  bool perf_pid_map_tid(const char *dso_name, int *tid);
>  bool is_perf_pid_map_name(const char *dso_name);
>
> -/*
> - * In the future, we may get debuginfo using build-ID (w/o path).
> - * Add this helper is for the smooth conversion.
> - */
> -static inline struct debuginfo *dso__debuginfo(struct dso *dso)
> -{
> -       return debuginfo__new(dso__long_name(dso));
> -}
> +struct debuginfo *dso__debuginfo(struct dso *dso);
>
>  const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
>                            const struct map *map, const struct symbol *sy=
m,
> --
> 2.52.0.457.g6b5491de43-goog
>
