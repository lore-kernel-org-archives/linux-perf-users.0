Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FEC413D60
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 17:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543396; cv=pass; b=uf0S+YAvdlhLHgVpFRyWMVdh9zxOZgwYRcfVFoSArUnUrGGplczVLmHdGpM/AM+N6kOH2bOgIhjZ5OByFIwfw1/Tjp5A5h/zs8sMH7EE7V7mtZC2sQWnTFHchzLJCzdIYjOlClJ4BCOuouVPEYpum4MAgBL3F4WE/FScxWa+pKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543396; c=relaxed/simple;
	bh=RWLnb0Yv8dvenMFQjdHz/0w8cchOVac5ZvNpqCyHfYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRXErBvGGlt+9dTwEwZkNpfU0NBAO+Sr4PbewXuhVVu/gROy3WQSlsss5JXnWziTzOenY0VWrNzkSvFljqQFnUSV92wRNOV/clJ2jAgyqN/fEpuwNCEsi01R73E4PAr/5UjF9YOUrXj3E2u8Ga2ZR+6w/GME+bHN+g+cg0MZl2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hJp1MbPX; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hJp1MbPX"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bf2d865383so2295ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 10:09:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781543394; cv=none;
        d=google.com; s=arc-20240605;
        b=VLXGc86k4IhkHe8CoJtOcPLND7Jx4cRrUTmLTZa+oGQ+TmoKFrQm8CcerD3UveUm/K
         VcJuXKFFBil7XdvN7nDDLfusW4qImzGbyK1Vxx4JLhWaftUb80JEQHjFeDcFbrTIl1jI
         szmlv8V/G3QJnjthYmTMk3WthuHd8k/kCUmRRgKQvoVWolXldacGGedmn+6VyWWIFMDI
         oyl1uvbG+yN+v0PF4H5pgeoK46dgkkUkuvDA3wvLBYIuVyNIrlqlFXsXCrZ/Y8zO8j8L
         8b3PBTbmR+lEL8Q/IXSC1tXm39g74J4DOuFfsPaPcbubua6rO+OUeXXuCa1siD6c4g2j
         RX0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bR+ZBxy7Dr+6bKECydHxJUiz6jez+EZlbzueJEUyeqg=;
        fh=RP/VJ4QONnuieq1sY96SjzYbwQ3lNon+jTw8ekNfImg=;
        b=VmazinAJTPCZwD2AaQRfuhztxFwBJjnJZc8V6S2/5m6phYmrCePtwkiXlCh1ChJ/gg
         OT51kT1ckXmZn1qs6e4CIqTy5lSoVoUeom1f/AEfyzQ3luGBb8tgAnAzZX/OmkM43KAK
         bMd8rXbWwCRbLC8+jYfeJdjR2K43zaM/Am2titMNvHXo+nlV5aVEtdhET3QsmrEQG9ry
         WGg4CyA0PVfWMbbFus5VODsU3TADOXt42lHGbDbvFhzwYYZTwWAcUuLb+/jpntXmcXGs
         mttflzPgpRj4istHLhcQl5waKRFA18HwUvxLsvzTA1UFqm6PupP3iG8hXmMz4Yzb0L82
         IUMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781543394; x=1782148194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bR+ZBxy7Dr+6bKECydHxJUiz6jez+EZlbzueJEUyeqg=;
        b=hJp1MbPXajK1dL5kw9s32CkE2RXUPau7rH5ThLSlmemlrd23Ex2GbT1uir9MHDZ7af
         fgQlXkeTrVR3AuQl94ASoANbqMAjU8iuAKBxeFRmCpq1zfjAli8clbbZxA8GSIBZ82LJ
         IKRLDSD04evHWHKfg+jkEAdzpEDeQsNlQ0a6dLAHwkuX0SHGWTg6pANZYI+02gPZwKvA
         yHFWCwyk7jPKTy0Q/wy2bgJwyrzSTxUhHf/tzJkScPcJwHu6kILUeGn8/4RMxhcJ4pvx
         GBgntP/qzL31n3BcWEhdlnnrA0vYxXo0XdZnX4VzY4AtXX4suE7zQ436RQRu4AsNdCgz
         tK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781543394; x=1782148194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bR+ZBxy7Dr+6bKECydHxJUiz6jez+EZlbzueJEUyeqg=;
        b=LecpmM/3Avc9fAJC6rOQ6NY+M8WV+F34+yibFOgSb7a6nyAxDmpuUnrdGs50hHqMHY
         Y3WD83P04yubxQtUf+zgwe8z0w09N3UTNks7qRvOBRKHL61jzic15tai0FZyEeecJ6I5
         an7TG0DK4LFK1SANcwchAurxoKXsWF5BblgpNeMhwhDgnCcOs/K2Wk5diOpOy8lVzEZ3
         CGKHRx2wQYGBUUWohvrjeFpQvxi1fJz7OFzxf9g0hZBCBgSU2Kixl815GjTlZrMwALQe
         y3wbUp/eZrainq7eRUiKKRx3ilXW+2BtmcIuZdJ46T93RAaemi2eX1vv6ukUmQL3puUx
         T3gw==
X-Forwarded-Encrypted: i=1; AFNElJ/qZceLaKpeeqSXcVFKXwZo/BAKQRlOkdK0vkxjUuQ3CdbyQvl/1P4+ZUr5tikx31whXBbph200/cl8B4M8d+D6@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoc/RoDSSCKy3Mm5pptuqa9qVEppVVfn1fUMawla88y9dhOrB1
	UsE4SsaTGbhbyrRaoIPpCPwm7EuzxsPaRJDWO3KATwp/wZ9WMQGwdQWW/eA/4eSNovaj8UDWSIS
	J4TcTN5Py/sgt/p4bPHxBeYwSzkgGp3tdqdmDTNOZ
X-Gm-Gg: Acq92OHko85a3xVFSbD2qB7mv4ctY5O6XBr98+bTPLksYspGCeikCYbQ5BJk0t6k1br
	D8m4W96AIo9DOhagj2TS95Fo+ORmYRTHV3h8zThNGSIlkfuh2nhIbzbA9vjflnqoTSALzFV4Y5E
	HhlFeRm7pW00H4+BRxpmQxgydexzi3xUD95aNn53UnXTDE6EzKfCcReL9JOQMDKYxaz/NJzrj8c
	wDMhGm+NZQNlSmNxZORjcGzFBxPNEp5LsI/o7F0KKYi5GZ39xoHh6nsyVjrp16OrFS9zDhdhfYy
	iy5nPJlqRACK+ZF6AM6/mQD71IqUZquOZKPFa7JNmoCfO+s=
X-Received: by 2002:a17:903:1446:b0:2bf:1000:d3ac with SMTP id
 d9443c01a7336-2c69a3c5d96mr1295ad.11.1781543393265; Mon, 15 Jun 2026 10:09:53
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612222413.40791-1-acme@kernel.org> <20260612222413.40791-5-acme@kernel.org>
In-Reply-To: <20260612222413.40791-5-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Jun 2026 10:09:41 -0700
X-Gm-Features: AVVi8Cefvp75cGm8kYdfRmINlPDocdG_VWXfZ99kUX7sDMqdvOar868GEEsUZrE
Message-ID: <CAP-5=fUnH=4z6L9fhQY=3iYV-70s5YThq3e1wbqVTwg6u5gWHg@mail.gmail.com>
Subject: Re: [PATCH 04/13] perf dso: Fix heap overflow in dso__get_filename()
 on decompressed path
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, "Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 3:24=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> dso__get_filename() allocates name with malloc(PATH_MAX), but the
> dso__filename_with_chroot() path replaces name with an asprintf'd
> exact-size string (e.g. 8 bytes for "/a/b.ko").  When the DSO needs
> decompression, dso__decompress_kmodule_path() writes the temp path
> ("/tmp/perf-kmod-XXXXXX", 22 bytes) into newpath, and strcpy(name,
> newpath) overflows the smaller allocation.
>
> Replace the strcpy with strdup(newpath) + free(name) so the buffer
> is always correctly sized for its content.
>
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Fixes: 1d6b3c9ba756a513 ("perf tools: Decompress kernel module when readi=
ng DSO data")
> Cc: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/dso.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 5d017975873817ec..511921bd901d8145 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -603,8 +603,15 @@ static char *dso__get_filename(struct dso *dso, cons=
t char *root_dir,
>
>                 /* empty pathname means file wasn't actually compressed *=
/
>                 if (newpath[0] !=3D '\0') {
> +                       char *tmp =3D strdup(newpath);
> +
> +                       if (!tmp) {
> +                               unlink(newpath);
> +                               goto out;
> +                       }
> +                       free(name);
> +                       name =3D tmp;
>                         *decomp =3D true;
> -                       strcpy(name, newpath);
>                 }
>         }
>         return name;
> --
> 2.54.0
>
