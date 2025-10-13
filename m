Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A2E301460
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 10:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760352218; cv=none; b=AIsUJFZzr9XxxG8f2IgQwgDYJInjP9MTo4+Qzh6KAx5SwD1TNotmMUVjwZVnGduen3HvKWvVf/lAGQxS4lhxVYCjK4Wr2MNVHOqE/5IbyOehD2B//DWAEqnBItPJ3d6pAfvujWUJBGBQAYpBbKjg6fqVOKavwatoRQM9sxqwLEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760352218; c=relaxed/simple;
	bh=RARMZDmBdSDpC7RVOxOxKN9neRejU+cWMFB+JB/5Aww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AE0s2OyFmowLnwQ/thRa19mjV4o+cut/atSKDim5DYHfEAZJE+koOD2G9D/5dxWezqwP6usVS+Tn4kOQQq1qn9rWQY9S4WYqPdwWkZl4/yy6861bTfmodk3cifR34U+Inuy2yWTz7ApuC5/76bTjr5YlLAOKH0lndgRQpKfASHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtaZyemm; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtaZyemm"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3ee18913c0so642855566b.3
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 03:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760352211; x=1760957011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcFv0JvgUUiMF5k8y9cAyCMvmoFgRHs7l0aoa48VQc4=;
        b=TtaZyemmTg5CmbMJdHp9Oxp57Mh2hTfsinDovJwIskm4XiIaDQ77uisuSYPXtyKhDu
         oZEUwvhz+4BbFFV8AgQqBEBAq83RYqkICDI9jhUSfbSNYW/h+8kJHzm05QEKtldaifMO
         kpIRPE1LGVTky8Y6YsQDiq9BwTnrtLtHNbire1JnjkyI2tiBgQokE1zGv0q0+kpgYyGi
         bASPkeL9nEYaL75MQ/0DrmqEYxISLWS/FKrCk+eNeFyBkTVFJxy1HvsIDbpSN0itu+vk
         J1u8rgUNMoFhWfQjlqJyoRgUODRIA8cWImX+Z/gzEb1S180ysrDV2laZNAyc6QEwg9XZ
         RRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760352211; x=1760957011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcFv0JvgUUiMF5k8y9cAyCMvmoFgRHs7l0aoa48VQc4=;
        b=ZHsdhmNoRogb9cNAo0a9KUd9gtPpYg5mcnOhM83k87dlxB/3uebXclHmzhYLWL2dmM
         RMsemadDZQBjGRZQ1YOEBE8Chv0huN9EkQD1aEqNdh9oEE19dzNyJsHkFAF0GeP54mg8
         hSo2rTWWqLjOWNCCxNOhH3B45GJsDtnnuxnTln53VwX+0FuHzBCZ1z9OiyBvtpwI31Dd
         qtF+LCaA5QxZ2dxkYISQ183XWtYfiasaPzWhNTyZmMHlYmk3jcF+ZWXV5+cZRkNqMlsb
         QuXnekv9SoTJEs91Ww8113luhsVjbVetoyWIGTt0h/jei7KaCqtOzgcqWs2T12T/l9bK
         LEXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzUDpg/BmOviNk7nCHyrRWIOwKEFdaiWhMfhfW5Ucp+Xg7XlvGsjXF86zufjK3QfirzTx+3SNpX3sUwKzmR1su@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9PCI69nDQ0IBATFao1fX7ZEzC+pISIQjtXR+ts5HV6ia6w7gX
	SJl2D2nJgH5npeZfhBm4a55hiBt+aMqSUQLB7nAXjCp+c+c3VwgBe41myO0+Wo9AEJn8vYO6044
	OxYjKDCGjUsv+PlIRN8Y7N0YCorDScvA=
X-Gm-Gg: ASbGncv4rCpIJY/8F6oHtCcHBb2OK0fG1lQhbi4MTD7lBObP30uSYoINV2YSL1wYgbQ
	5RpZXGx/FwzLArUNj1Qsjh99yMjuhpJ3kP26jZkCDSbnqKTW7MBc+lTEH6o40iQ9dgxAFcr37cZ
	dCSXqj1XQGsonVlzI0Qj//7fdFbdDMj4nM8r5k+0Od3YsDRlfGP5gib6OWk4HVTEPkV3EoLDkNq
	kI+StSwhLeiPwmptkZPT+FWtCDx7w7HoNAkSozQglXuw09uQcZuIM6fbhsaWKixu1VMpw==
X-Google-Smtp-Source: AGHT+IFzNX+P3pRvMW2FAQ59SOQyqK2bEstHj5NDTUN+rvyTr/ypGkzaAvvpN1+r/clXISvXK/E8Cpge4p8hjlKIXuE=
X-Received: by 2002:a17:906:f5a6:b0:b45:b1f2:fac0 with SMTP id
 a640c23a62f3a-b50aa7a1910mr1902159766b.29.1760352210599; Mon, 13 Oct 2025
 03:43:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013072244.82591-1-adrian.hunter@intel.com> <20251013072244.82591-3-adrian.hunter@intel.com>
In-Reply-To: <20251013072244.82591-3-adrian.hunter@intel.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 13 Oct 2025 12:43:19 +0200
X-Gm-Features: AS18NWB05SzNuGx1SK51LKQThAd0fI_UJoF4XpEyvTEmr-9RfOPg4zcyShW6HMw
Message-ID: <CAOQ4uxjip6vRZq+ZWYemsOaeXvQ7LRmJWUnzF7R+53wYdeLNGA@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/3] perf/core: Fix MMAP event path names with
 backing files
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ian Rogers <irogers@google.com>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Edd Barrett <edd@theunixzoo.co.uk>, Laurence Tratt <laurie@tratt.net>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 9:23=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> Some file systems like FUSE-based ones or overlayfs may record the backin=
g
> file in struct vm_area_struct vm_file, instead of the user file that the
> user mmapped.
>
> Since commit def3ae83da02f ("fs: store real path instead of fake path in
> backing file f_path"), file_path() no longer returns the user file path
> when applied to a backing file.  There is an existing helper
> file_user_path() for that situation.
>
> Use file_user_path() instead of file_path() to get the path for MMAP
> and MMAP2 events.
>
> Example:
>
>   Setup:
>
>     # cd /root
>     # mkdir test ; cd test ; mkdir lower upper work merged
>     # cp `which cat` lower
>     # mount -t overlay overlay -olowerdir=3Dlower,upperdir=3Dupper,workdi=
r=3Dwork merged
>     # perf record -e intel_pt//u -- /root/test/merged/cat /proc/self/maps
>     ...
>     55b0ba399000-55b0ba434000 r-xp 00018000 00:1a 3419                   =
    /root/test/merged/cat
>     ...
>     [ perf record: Woken up 1 times to write data ]
>     [ perf record: Captured and wrote 0.060 MB perf.data ]
>     #
>
>   Before:
>
>     File name is wrong (/cat), so decoding fails:
>
>     # perf script --no-itrace --show-mmap-events
>              cat     367 [016]   100.491492: PERF_RECORD_MMAP2 367/367: [=
0x55b0ba399000(0x9b000) @ 0x18000 00:02 3419 489959280]: r-xp /cat
>     ...
>     # perf script --itrace=3De | wc -l
>     Warning:
>     19 instruction trace errors
>     19
>     #
>
>   After:
>
>     File name is correct (/root/test/merged/cat), so decoding is ok:
>
>     # perf script --no-itrace --show-mmap-events
>                  cat     364 [016]    72.153006: PERF_RECORD_MMAP2 364/36=
4: [0x55ce4003d000(0x9b000) @ 0x18000 00:02 3419 3132534314]: r-xp /root/te=
st/merged/cat
>     # perf script --itrace=3De
>     # perf script --itrace=3De | wc -l
>     0
>     #
>
> Fixes: def3ae83da02f ("fs: store real path instead of fake path in backin=
g file f_path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  kernel/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index cd63ec84e386..7b5c2373a8d7 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9416,7 +9416,7 @@ static void perf_event_mmap_event(struct perf_mmap_=
event *mmap_event)
>                  * need to add enough zero bytes after the string to hand=
le
>                  * the 64bit alignment we do later.
>                  */
> -               name =3D file_path(file, buf, PATH_MAX - sizeof(u64));
> +               name =3D d_path(file_user_path(file), buf, PATH_MAX - siz=
eof(u64));
>                 if (IS_ERR(name)) {
>                         name =3D "//toolong";
>                         goto cpy_name;
> --
> 2.48.1
>
