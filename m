Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D6432E72F
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 05:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781243593; cv=pass; b=phkdQHy5Lq2yuT4DzfTGMVzgF5wS94TytUlUsSXl8hljcqG/6m3buUkizU+7z3kXQIlqo3BGOo+htPZ9dMzgJXwtv2tcXL5pBpBhCzNDbFr6qAacI4Jd5CFBFR2Y2SGIjm4CWqk2mQHIq32j/+ZOBljbYqIhIG1z0R7Psl18ar4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781243593; c=relaxed/simple;
	bh=40XdrPdqb74mJ3asOUOv99pdc9djKLRs4Y5b4MlVeSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEgVdrPlIU2GrM6Wgghy5ObzDxrOLwh+/tH6gHtvSPq82sotcTtE5aVmeWhZ9wHGxJ1CigdXI4AIgPL2O3vfJejR4TzuVJxni5i7h+HZySclgGt3XhGnfkQRGHHLrx2ouHntMePwFCct73gixGvjfF1gQR47pgAwVQPshZE/B3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eLTBjb6z; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eLTBjb6z"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c0b1a48855so68785ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 22:53:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781243591; cv=none;
        d=google.com; s=arc-20240605;
        b=VbO0JlV76kcKlf7/eVeK5yyh9L62go7ZCeN1VhcvNdSabEFF/+D4PILK56zM7WuDEn
         R9Vv6g4trWfgb0X74TfXHbME9mI3kGyKpg+dws+pBffXHsyd/JiYkWHMV1cX/K268wyz
         kajolNE8Cfwtp/uDTiVHjSs0jvB4E5km0o+q1HgmGJouT1uXnCPSXywn/2JJfQMK58Aj
         +O+NHfpTdSqDf4ZJU5jW0DMRFakmUveBlwGbC5dnTIhleIVReU0MrRrPfSoXhEJJrDfc
         X51cQuke93PAZ3q+Hv7ea3rPWlfe6vTlDsPoaYh/iYT2mVDdh+y5DFK97odBxZbJqNNP
         gOhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5na1fsszTNWhi79hf2Hia6Rn4T4ezziRq32/YISQxMM=;
        fh=oR+znNtIqOdGbmASLZ2zBbxeQ8246IJqIbt+WRTgSks=;
        b=OD4mP2pGhaSJDQl/kJ6KsDFZoTwR1k0yv/h8HQhVqRxzP8obKRTOJ7f+8s09ai2iF+
         wXdqygfwxBjWgR6WLRQBPlANBsCND/07IYK1qzkmnP8xWQ0KI2OVTV0rywxQVRrdEqIW
         Dv+QyZuhBlaitwbsX7L/938HxJaNOFrdMmBqhvp37f3FyJxEpKAoRoTxvj1JkMrkCeRS
         KZ46K9/rP9VDQymVFPG7I/5/7no9mMVPqPzpMHR0ypv42MaRASBEL+JGz7xRv6lQShHr
         cXgWlFW06umqPglQwmWr5ovQDFbke34Jmp6+LKLzJxyTEjA4sGQA+Z385M54WS5grTSL
         x4+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781243591; x=1781848391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5na1fsszTNWhi79hf2Hia6Rn4T4ezziRq32/YISQxMM=;
        b=eLTBjb6z9B13+CIW3c9Jyq2saF1eQY3Gyu7NdH6sWwbzFbE/AA3uclrKY8j3GeLkPz
         43eW3nLjMSgC+11hiYe89K3QABtAeCnnWJVvyjd/c9DvuLTaKbn21J7DacwIzvAeaDo4
         jX2do3JuvFHGiY5FfJfbV6bo19f/mvM5EtB47heyDJRgCyJVNFsNDcrmsQDt/WEkNbt4
         s4BvJaCpemNwOmcYwiSur+/Gpwfkmk28g0p0QpO6PPhyDlC//V4ufNUoZDHbgaML8raE
         agp/bmXVAayBnd48EAZDpK1VppXf857sFfXFzMS9D5cFjir5PY2R10fTLuYfTdVT/EdU
         Vp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781243591; x=1781848391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5na1fsszTNWhi79hf2Hia6Rn4T4ezziRq32/YISQxMM=;
        b=X6drtjiYQNTJF0wewM8sZaFHYTNqn3p4c208DC6n1Yv7kR3y6xuOIn5NziP8h2MnDk
         05SNBEPudURhqXhZdJvziSDN0uYCKouwAseJRwbYIh2G4TNv+TmrxiQYQD3dYyGJN77a
         g8CJ66FoIP+HcsEvuhu2OcomfD7MuSJpZDeqrwg+lDL8yF7K1DynUA1l12WLvHDN9e7j
         aTCFHFRCgOe+hgSh8vezxQENOoHv7+ZVheoXYDH5JbjpUednOlr9wGJ+38UkPlPODwQa
         LfTgXRIyvYAdMwGafOFJ3ZUpoKSzOqNQQc4UCwK/ejGX87D+F+CGM+I1U90uN/2/n1pA
         N2+w==
X-Forwarded-Encrypted: i=1; AFNElJ8M15f8qQ0v9SVxYH6E6x7YZKNATqG4TVVLIdpq42A6uhVsXRUcwmImjJRCuqn5PPvp1KA7S4JZ/QDtlKdhb6od@vger.kernel.org
X-Gm-Message-State: AOJu0YyTDX0vjMiR1G8OCroX6VQkpXp+Rxn5XR8ozRfj7aTOryiaHDUr
	Un0fsckch2WWYqep1Z7Fc8uw5Cx4YSGdoMZ4ZEsfXKNANzAwsDDx1UTvOV/YZKawWOOIbxCLCKe
	iY6F3lxnwa16eW3mIkxw8L6JZn3rJqpMBXEiRUj0P
X-Gm-Gg: Acq92OFijoMGvFPYs7vPFsd1khVq4M1riGvRNdVdgujjsWbXjCEt/cLn7dfcLrGKjHj
	ZIfeaqnRUoPP4DZlQEb7konxSCoHnEagAWBYMqBfoX9Wedshw2Y8hgnHUXRZStSvwOQMintzebN
	HiZiPi/ysFUAnN5cGVUZzQb7Og9qAfFcWg1hgSoZE6KdQgw1aWbFz7tYB2ZUQWzhVqgybZF9AVM
	2OkcNJO2HJMLJ0RAhp3IGZxfx00I69dccKUdJ5QXqNMrLqQtesFXeAqkjHRrnKMbgacGzQE1cPU
	ygMbFrJtM5HiJZFoDUo=
X-Received: by 2002:a17:903:384f:b0:2bf:3579:cdaa with SMTP id
 d9443c01a7336-2c3e1a149b2mr1825325ad.10.1781243590438; Thu, 11 Jun 2026
 22:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612003444.50723-1-acme@kernel.org> <20260612003444.50723-15-acme@kernel.org>
In-Reply-To: <20260612003444.50723-15-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 11 Jun 2026 22:52:57 -0700
X-Gm-Features: AVVi8CfULEUIbzxwaUWBzEN1DwrcgJvdRcwy6g0QATeapo50rOmCCAGZhlk7YFM
Message-ID: <CAP-5=fVB8such4Auvt3rCGzkcM5C-+e6GdEZe79Pi++RxRxTcw@mail.gmail.com>
Subject: Re: [PATCH 14/15] perf symbols: Add O_NONBLOCK to DSO open() calls
 for untrusted paths
To: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Clark Williams <williams@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, sashiko-bot <sashiko-bot@kernel.org>, 
	"Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 5:35=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> DSO paths from perf.data MMAP events could reference FIFOs, device
> nodes, or other special files.  Opening such paths without O_NONBLOCK
> can hang perf report/script indefinitely waiting for a writer or device.
>
> Add O_NONBLOCK to all open() calls in the DSO symbol resolution paths:
> filename__read_build_id(), filename__read_debuglink(), symsrc__init(),
> do_open(), filename__decompress(), and __dso__read_symbol().
>
> O_NONBLOCK is a no-op on regular files but prevents blocking on special
> files, following the systemd "foreign file" convention.  Also add missing
> O_CLOEXEC flags in symbol-minimal.c for consistency.

I think these changes are wrong and based on the bad O_NONBLOCK prompt
I fixed. I did the original addition of O_NONBLOCK and James
fixed/removed it with:
https://lore.kernel.org/linux-perf-users/20251124-james-perf-non-block-v2-1=
-54cdc2f13a24@linaro.org/
As we don't read from files with TEMP_FAILURE_RETRY the use of
O_NONBLOCK is going to mean slow file systems fail. The
is_regular_file tests are intended to avoid the hangs described in the
commit message.

Thanks,
Ian

> Fixes: a08cae03f430b971 ("perf tools: Allow to close dso fd in case of op=
en failure")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/finding/6
> Cc: Jiri Olsa <jolsa@kernel.org>
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/dso.c            | 6 +++---
>  tools/perf/util/symbol-elf.c     | 7 ++++---
>  tools/perf/util/symbol-minimal.c | 6 +++---
>  3 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 1a2fc6d18da74d6c..dc0c8b9c63017239 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -344,7 +344,7 @@ int filename__decompress(const char *name, char *path=
name,
>          * descriptor to the uncompressed file.
>          */
>         if (!compressions[comp].is_compressed(name)) {
> -               fd =3D open(name, O_RDONLY | O_CLOEXEC);
> +               fd =3D open(name, O_RDONLY | O_CLOEXEC | O_NONBLOCK);
>                 if (fd < 0)
>                         *err =3D errno;
>                 if (pathname && len > 0)
> @@ -547,7 +547,7 @@ static void close_first_dso(void);
>  static int do_open(char *name) EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_=
lock)
>  {
>         do {
> -               int fd =3D open(name, O_RDONLY|O_CLOEXEC);
> +               int fd =3D open(name, O_RDONLY|O_CLOEXEC|O_NONBLOCK);
>
>                 if (fd >=3D 0)
>                         return fd;
> @@ -1927,7 +1927,7 @@ static const u8 *__dso__read_symbol(struct dso *dso=
, const char *symfs_filename,
>         int saved_errno;
>
>         nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
> -       fd =3D open(symfs_filename, O_RDONLY | O_CLOEXEC);
> +       fd =3D open(symfs_filename, O_RDONLY | O_CLOEXEC | O_NONBLOCK);
>         saved_errno =3D errno;
>         nsinfo__mountns_exit(&nsc);
>         if (fd < 0) {
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index dc48e2d2763379b9..01c7b09fc82bcddb 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -886,7 +886,8 @@ static int read_build_id(const char *filename, struct=
 build_id *bid)
>         if (size < BUILD_ID_SIZE)
>                 goto out;
>
> -       fd =3D open(filename, O_RDONLY | O_CLOEXEC);
> +       /* O_NONBLOCK avoids hangs on FIFOs/devices from crafted perf.dat=
a paths */
> +       fd =3D open(filename, O_RDONLY | O_CLOEXEC | O_NONBLOCK);
>         if (fd < 0)
>                 goto out;
>
> @@ -1022,7 +1023,7 @@ int filename__read_debuglink(const char *filename, =
char *debuglink,
>         if (err >=3D 0)
>                 goto out;
>
> -       fd =3D open(filename, O_RDONLY | O_CLOEXEC);
> +       fd =3D open(filename, O_RDONLY | O_CLOEXEC | O_NONBLOCK);
>         if (fd < 0)
>                 goto out;
>
> @@ -1187,7 +1188,7 @@ int symsrc__init(struct symsrc *ss, struct dso *dso=
, const char *name,
>
>                 type =3D dso__symtab_type(dso);
>         } else {
> -               fd =3D open(name, O_RDONLY | O_CLOEXEC);
> +               fd =3D open(name, O_RDONLY | O_CLOEXEC | O_NONBLOCK);
>                 if (fd < 0) {
>                         *dso__load_errno(dso) =3D errno;
>                         return -1;
> diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-mi=
nimal.c
> index ea2de3d50d33cf33..dc4a06b2a03ad3cb 100644
> --- a/tools/perf/util/symbol-minimal.c
> +++ b/tools/perf/util/symbol-minimal.c
> @@ -118,7 +118,7 @@ int filename__read_build_id(const char *filename, str=
uct build_id *bid)
>         if (!is_regular_file(filename))
>                 return errno =3D=3D 0 ? -EWOULDBLOCK : -errno;
>
> -       fd =3D open(filename, O_RDONLY);
> +       fd =3D open(filename, O_RDONLY | O_CLOEXEC | O_NONBLOCK);
>         if (fd < 0)
>                 return -1;
>
> @@ -234,7 +234,7 @@ int sysfs__read_build_id(const char *filename, struct=
 build_id *bid)
>         char buf[BUFSIZ] __aligned(4);
>         ssize_t len;
>
> -       fd =3D open(filename, O_RDONLY);
> +       fd =3D open(filename, O_RDONLY | O_CLOEXEC | O_NONBLOCK);
>         if (fd < 0)
>                 return -1;
>
> @@ -257,7 +257,7 @@ int sysfs__read_build_id(const char *filename, struct=
 build_id *bid)
>  int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
>                  enum dso_binary_type type)
>  {
> -       int fd =3D open(name, O_RDONLY);
> +       int fd =3D open(name, O_RDONLY | O_CLOEXEC | O_NONBLOCK);
>         if (fd < 0)
>                 goto out_errno;
>
> --
> 2.54.0
>
