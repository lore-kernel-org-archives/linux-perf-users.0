Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C5C3B0ACE
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 22:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780956077; cv=pass; b=J3k5R1iB7qF5uLBcfP02foHLgcmCWX1Y0M9rrSdG148xYXmAhm2kahpqadD3FebUxb8SSmk/HsNV8LmUAo4XCgNGTpxUwiBTRSvHIrVHUqUvbqP+pjHVSl8J7wgNopOXYpASTowIztdW5elf1cbkKTeJIn071dD36dDrFkObLgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780956077; c=relaxed/simple;
	bh=WZcjqyrHT/gjl/VUsiW+RaCvs6ReOueNrbbxBURQo7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kUUvj9+NCwctcD5Dsr/IQ9OyBY1TvW7aZMKypeOy+QNlUUKHp4z8rjHToyJkTCK8LXhSGnl274FIVJ8VH+HQhxjLXa9dOj6CFUols7HIi8E1utncrfJnSNH5CSENEUPQnb3ReWbCn/xRIH5pHW8XYc7DzqowIdQeekFbMXdklTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EbKz31Yx; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EbKz31Yx"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bf2911f93cso363425ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Jun 2026 15:01:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780956076; cv=none;
        d=google.com; s=arc-20240605;
        b=lLSfOvHElsMlFcB0TIsJA2esd3jAmt0RuAVpaS94T1upDsY7su2RLmjvXBJ/tpMaxT
         F2uGuAnI9b09Lplg63nq/pHjOkItowfSX/KVruzzagIUiIZ9PEpnF4is8aYPzD0ONuW+
         DHirv3dXVjoOz1SULoai2c8DaQY5RETEiO2th9WQQ2BZG5TBcxfDYxLEyPrE9dYei7la
         t5eOqqxCkzie20lJwWVI4px1L4v/CHrYCZjYZOmRoztZgz7rLdSnJeO9L6Dwn95OGaH8
         tH2aLWmZYd1dtO1p4S9g+D6NCcaATa4e27pWDI9VKBYVN5rnKg6XkFcpYr16w0tJZjWH
         PTzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Li1zqRjpweBVAZBfxC/jfb4KZuC+NlHala+uPHqm6ME=;
        fh=2XmAg0OYLPhEUVIVAhB8p4JqnZeMrJCAholowpZsPnE=;
        b=YpJpUuntkUNH8LrKVSpSsuMnA01aKKC7Uzn6tdczspt12tm4R4rYTOqFtaJHsttGAw
         7d/UmupdFbW9lWUpGa6yPQO5j5xCEvHNtmovL3tprhQ/R7ZHIHOwnMjdSkfTle8HqkiC
         R1xRw8JtRXVAT/MbEUiBFHquVricm+OPG0/gkPQ3q6jVuDfmuBmFcfoLhyhLFA9Iyjjw
         7JqCedODqG4qsc9pXycinIKFtJQotSuGh+g2xYW59Cbfsz2XRNvF6iuDTn/NiWjmCZ7O
         J0ur3fz8AqGmgv2mzsartReS6kXcCYiSrgYZnVwLbUyHrLqOhU7WINLq34Te0jT/a8ai
         cO0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780956076; x=1781560876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Li1zqRjpweBVAZBfxC/jfb4KZuC+NlHala+uPHqm6ME=;
        b=EbKz31Yx3IEMDtt+HWetivsXFOQ82nged17Hypk6pJM0H1u5CNxLcPZqmt+c3ls9rJ
         /VEB9vt5zn7yD7fckqA3U1vrHBrphbL5byz56GX82iPz7qeJrNH5NJB0OgHVG9gvUmIm
         bkH60/1go6ppzN2kRZaljoYH7FVQ5kF9ycNl/WyKdDIW6beiCje+sx+knYYW6xRgnjba
         oLZ8OH5O3eO8ZU8kYxrGh+q/Ni4+mAV/tPlC5rTu7PgJbXo57EDmFTM8bfFX/s31IUoC
         PhdKl0OGjzVJg0lrWTSEM+UKlgySDmsAF8GUHP9F6dMa2CMmvcfxYAGnZPy9pu9aHswo
         HMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780956076; x=1781560876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Li1zqRjpweBVAZBfxC/jfb4KZuC+NlHala+uPHqm6ME=;
        b=guNZay8dT8v79HSzYfm0Mz+ZnnC9FNuBHxn0gs2fFz8aOSLwb2prmByw1oESOSpbHb
         Ek+XfpBCTn9ckueAVFT7pP8DlwNakBeMJzUDLE4NO6iBwXIOLq19wm0R3OseYyyjQtY7
         ItWrJkhd5XAoP+wUf/7cPMuCHgfkCqfnPtNkjXKdEnAhW9aRYr3anfxsnPLL2jdhIkVs
         8nEaZK72QYj1gifnn7c/nV+T2qoYaNRnVxkXbHploaWgPqbzvsIaml8whtGzp8uGuo/y
         RXT8hr8gs9R+P+e/HaAnHtoY/PYVUqiD67cjEe4BkDzNN99PF8wxAYqXoviqktwK7EYw
         XvQw==
X-Forwarded-Encrypted: i=1; AFNElJ9gP5F8EU1NRwl7zTbiGVKN12qizztBAKziSp+XZCh9OiOk4PcPIO//662K9rsRn+GQIKwcP3w7lqHOnWsFvgnn@vger.kernel.org
X-Gm-Message-State: AOJu0YzkVQ7C52gAvwJig3+nRlpbN0ophvYQdR70adFcUOsA2+xq5vga
	Spm1VwTQ5BEzYJtv/rfnrwub/qFwNkUlbvI+z1yRS44C3Cjf17GYxAVMoQQ17rk65VFslXjZQCF
	jijyqvVF/uMDnfVh7o4Ej4D/BiHs3ccyjIY23m7ae
X-Gm-Gg: Acq92OGxB+P41p+zh0q73hXv6huyFkdJ0Payus474jFzjxuJnyU+lSDr0Yr2EFcDHkb
	l8EeueZsYALJw4y5/tPURyC6HYZyy2jf+myLgoYf9bQAC/s0DxMVTgz9vVxU0VRXDegmmdAGfQX
	j5dU/+VsXOYqLegOixMStz0lK9gxR0asjOEGmDwjXgvoKHku18Qalso1+5NhaCaaG9n7Dxo5e+o
	hX53sR/Jo6JKAWs736fFVxCNHhn5nhqSjkPymElHzjb3ztJWVhNutlUt3WK+Fgz91SW5RuAZZUV
	jjWmPHsbekStUYFwapIL/JC/JE0oXRpgj+EbUQfSuvwyqbZl
X-Received: by 2002:a17:903:b85:b0:2bf:2e8c:db96 with SMTP id
 d9443c01a7336-2c1eaeab081mr6683645ad.5.1780956075215; Mon, 08 Jun 2026
 15:01:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608201753.1979464-1-acme@kernel.org> <20260608201753.1979464-8-acme@kernel.org>
In-Reply-To: <20260608201753.1979464-8-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 8 Jun 2026 15:01:04 -0700
X-Gm-Features: AVVi8Cc1ZLOLo21pQNFR6EkXolZttLJ7CVqjIwTsb5hzL-FuuV0sDzgGkSEuGYY
Message-ID: <CAP-5=fWsxuvf1iaxLm=Z6+En_YpKrLcRXeMm7i-KUvRiyAqH1A@mail.gmail.com>
Subject: Re: [PATCH 07/11] perf tools: Add O_CLOEXEC to open() calls in DSO
 and ELF code
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, "Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 1:18=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> open() calls in dso.c and symbol-elf.c omit O_CLOEXEC, which leaks
> file descriptors to child processes spawned during symbol resolution
> (e.g., addr2line, objdump).  This can exhaust the fd limit during
> long profiling sessions or when processing many DSOs.
>
> Add O_CLOEXEC to all open() calls in both files (12 call sites).
>
> Fixes: cdd059d731eeb466 ("perf tools: Move dso_* related functions into d=
so object")
> Fixes: e5a1845fc0aeca85 ("perf symbols: Split out util/symbol-elf.c")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>
and Sashiko is asking for more of this goodness.

Thanks,
Ian

> ---
>  tools/perf/util/dso.c        |  4 ++--
>  tools/perf/util/symbol-elf.c | 20 ++++++++++----------
>  2 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 7dced896c64eafd7..fb2e78fe2aa8eb94 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -344,7 +344,7 @@ int filename__decompress(const char *name, char *path=
name,
>          * descriptor to the uncompressed file.
>          */
>         if (!compressions[comp].is_compressed(name))
> -               return open(name, O_RDONLY);
> +               return open(name, O_RDONLY | O_CLOEXEC);
>
>         fd =3D mkstemp(tmpbuf);
>         if (fd < 0) {
> @@ -1911,7 +1911,7 @@ static const u8 *__dso__read_symbol(struct dso *dso=
, const char *symfs_filename,
>         int saved_errno;
>
>         nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
> -       fd =3D open(symfs_filename, O_RDONLY);
> +       fd =3D open(symfs_filename, O_RDONLY | O_CLOEXEC);
>         saved_errno =3D errno;
>         nsinfo__mountns_exit(&nsc);
>         if (fd < 0) {
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 186e6d92ac3d7742..c2bdfd0003df2abe 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -217,7 +217,7 @@ bool filename__has_section(const char *filename, cons=
t char *sec)
>         GElf_Shdr shdr;
>         bool found =3D false;
>
> -       fd =3D open(filename, O_RDONLY);
> +       fd =3D open(filename, O_RDONLY | O_CLOEXEC);
>         if (fd < 0)
>                 return false;
>
> @@ -872,7 +872,7 @@ static int read_build_id(const char *filename, struct=
 build_id *bid)
>         if (size < BUILD_ID_SIZE)
>                 goto out;
>
> -       fd =3D open(filename, O_RDONLY);
> +       fd =3D open(filename, O_RDONLY | O_CLOEXEC);
>         if (fd < 0)
>                 goto out;
>
> @@ -935,7 +935,7 @@ int sysfs__read_build_id(const char *filename, struct=
 build_id *bid)
>         size_t size =3D sizeof(bid->data);
>         int fd, err =3D -1;
>
> -       fd =3D open(filename, O_RDONLY);
> +       fd =3D open(filename, O_RDONLY | O_CLOEXEC);
>         if (fd < 0)
>                 goto out;
>
> @@ -995,7 +995,7 @@ int filename__read_debuglink(const char *filename, ch=
ar *debuglink,
>         if (err >=3D 0)
>                 goto out;
>
> -       fd =3D open(filename, O_RDONLY);
> +       fd =3D open(filename, O_RDONLY | O_CLOEXEC);
>         if (fd < 0)
>                 goto out;
>
> @@ -1153,7 +1153,7 @@ int symsrc__init(struct symsrc *ss, struct dso *dso=
, const char *name,
>
>                 type =3D dso__symtab_type(dso);
>         } else {
> -               fd =3D open(name, O_RDONLY);
> +               fd =3D open(name, O_RDONLY | O_CLOEXEC);
>                 if (fd < 0) {
>                         *dso__load_errno(dso) =3D errno;
>                         return -1;
> @@ -1952,7 +1952,7 @@ static int kcore__open(struct kcore *kcore, const c=
har *filename)
>  {
>         GElf_Ehdr *ehdr;
>
> -       kcore->fd =3D open(filename, O_RDONLY);
> +       kcore->fd =3D open(filename, O_RDONLY | O_CLOEXEC);
>         if (kcore->fd =3D=3D -1)
>                 return -1;
>
> @@ -1985,7 +1985,7 @@ static int kcore__init(struct kcore *kcore, char *f=
ilename, int elfclass,
>         if (temp)
>                 kcore->fd =3D mkstemp(filename);
>         else
> -               kcore->fd =3D open(filename, O_WRONLY | O_CREAT | O_EXCL,=
 0400);
> +               kcore->fd =3D open(filename, O_WRONLY | O_CREAT | O_EXCL =
| O_CLOEXEC, 0400);
>         if (kcore->fd =3D=3D -1)
>                 return -1;
>
> @@ -2461,11 +2461,11 @@ static int kcore_copy__compare_files(const char *=
from_filename,
>  {
>         int from, to, err =3D -1;
>
> -       from =3D open(from_filename, O_RDONLY);
> +       from =3D open(from_filename, O_RDONLY | O_CLOEXEC);
>         if (from < 0)
>                 return -1;
>
> -       to =3D open(to_filename, O_RDONLY);
> +       to =3D open(to_filename, O_RDONLY | O_CLOEXEC);
>         if (to < 0)
>                 goto out_close_from;
>
> @@ -2883,7 +2883,7 @@ int get_sdt_note_list(struct list_head *head, const=
 char *target)
>         Elf *elf;
>         int fd, ret;
>
> -       fd =3D open(target, O_RDONLY);
> +       fd =3D open(target, O_RDONLY | O_CLOEXEC);
>         if (fd < 0)
>                 return -EBADF;
>
> --
> 2.54.0
>
