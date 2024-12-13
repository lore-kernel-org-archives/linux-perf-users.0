Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C401E47DD
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Dec 2024 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734113446; cv=none; b=UVjqMHsKaDBl+iWidxstltdWuSAFH58vy0nLnbMYH9AF04ZpBUAFy6BBOX5xXAqk5V6C7bS7qe9+K/y0ZN3kPAVqIpxcGufogB+QPZw5dql1W4089pdv+gXM7CWUme34jP6iAJ04VY1yb0oRPvYPLk60SLCwinLwmnXkIkalErc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734113446; c=relaxed/simple;
	bh=k0DPfjVaCNtHadVi817LIPEFiQPVpOq0Rk4KDTJHK1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HI4DD4XqXhRrgbOXZyPMGIKjxi+zo1dg84w9KMIkIDOVLdpYHcHbSBhGPeTrNTYpmVlPBaOudI6aU/BmjEPp2WCMwFZ1rEYNMt5YtKoH7CKBJvAQ+q9VgK3+hRk0FANfr9+HFlwzd2jNwnboSsteofCd7/7f/7kPFSp0IemDUNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2I3KG5UE; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2I3KG5UE"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a815a5fb60so5455ab.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Dec 2024 10:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734113444; x=1734718244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+hgaeTwc969Xr5cJMWCHi4YypA6NV2JJFX5XRvZhe0=;
        b=2I3KG5UEnCqmDXsgINIdqhTexwpAa777w+mBS1ayCxu5SVkU2DKqaJ3ysZAK9j7tbI
         95ATsD9+gk1tLR+4ldGrZa49qgwHBZqHF/E2tkZAohUGo/ooPPkLChewZ/m/N8z/7GUo
         m/aJYJRq4Fewv3a+PVVnVSs59Oo3RZPVAMPQXTAU6tUYEOyiQ69+zZ9dwmyXlw6jex9+
         aqT+XbR8geOoTy6kPqMC48jtSizRIVKxPGoaZY5ATfD9UlxaPRVmCNAIlIaaE8YASfwD
         xnEXv8rIcPV9XnrLUisD1wK1ktoeHO3VkHrif2NiQ361pTmGjrH6+Aj1MIMfpzUgduko
         CZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734113444; x=1734718244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+hgaeTwc969Xr5cJMWCHi4YypA6NV2JJFX5XRvZhe0=;
        b=kX8VE8Cy5F3jvIdyNBgtGR6Bm3J4WL7AWvP8DvKxhh0HS7JOeKcid5lu9Kncmzteh4
         rCKMnn5HYqctZOErp+7ufKfW+vKMWrP7W16aYI49y1m2KDCpKTZ1q7kdBgLJMXHuwC9u
         jaGCkfeLtcYu4vkSLV0C2Ab0gY/l1Zb+fpYXqjI/oD7AmJf/JSbEJjKpHBSH4D10AVMS
         9f7Mc3x3BOXsL+0dmTbb1eet1q73/MhsqwSVdc924qd3SSd0r4v3gT5uk1wr8FGBua2p
         eNNOIqrwUF/M1IrbjO/g9Q2vp/wRCFawJTq3CauLT1FJzlGm+Y16MxaKHQMoqWqzNCOQ
         HcGw==
X-Forwarded-Encrypted: i=1; AJvYcCUD5jUcjZfrzHLqxtrwolbHm8aeqAKj2lkafur93rXO0Td0aD/n92ns8ThOTxPo+HPQAdeOBKUMpXCI2i3QuDkR@vger.kernel.org
X-Gm-Message-State: AOJu0YxCMjdxL/S3tpiRKAs00a0CvlaK86vML7d2rg7GOFLVREcC1sK7
	PcAUgqRhfw/5l/rHU38PruV/OItTS7UBRm7sz71vKUe8liKeK7r9A3O7iJdJPeSEOTmS7M6oP1I
	WI4WgNKr9qBjp9d41XaxEMNXHrskGWKWo+s8S
X-Gm-Gg: ASbGncus/AEeGQX29EMWXvG/WhRAnh2tKWuxRP4ynuJx5XAV79KT8ntSukRtQjBdSwj
	qai7n/HWN0hfQsIFwxQbQ0CoDfrdvPHJaQvtikz0=
X-Google-Smtp-Source: AGHT+IEpXVdotD7gPTZpVvNm6rDcuEI9+VbTUTPpjI0rSnYDYqUNwhT6bqW+G6X28rCmH0gCHBryuHlavZreyLNczUQ=
X-Received: by 2002:a05:6e02:20e5:b0:3a7:ddbb:1b19 with SMTP id
 e9e14a558f8ab-3b0290a08a1mr2949455ab.27.1734113444146; Fri, 13 Dec 2024
 10:10:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z1x3o0YoeZS2kQzr@x1>
In-Reply-To: <Z1x3o0YoeZS2kQzr@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 13 Dec 2024 10:10:32 -0800
Message-ID: <CAP-5=fVBrssdqwz0YiJ9snKgEJSiAhMVpZcP=sNr6gGEwhMUsA@mail.gmail.com>
Subject: Re: [PATCH 1/1 next] perf tests switch-tracking: Set this test to run exclusively
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 10:06=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> This test was failing when run with the default 'perf test' mode, which
> is to run multiple regression tests in parallel.
>
> Since it checks system_wide mode, set it to run in exclusive mode.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/tests/switch-tracking.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch=
-tracking.c
> index 5cab17a1942e67d7..88a03bcbecb2b11f 100644
> --- a/tools/perf/tests/switch-tracking.c
> +++ b/tools/perf/tests/switch-tracking.c
> @@ -583,4 +583,11 @@ static int test__switch_tracking(struct test_suite *=
test __maybe_unused, int sub
>         goto out;
>  }
>
> -DEFINE_SUITE("Track with sched_switch", switch_tracking);
> +struct test_case tests__switch_tracking[] =3D {
> +        TEST_CASE_EXCLUSIVE("Track with sched_switch", switch_tracking),
> +        {       .name =3D NULL, }
> +};
> +struct test_suite suite__switch_tracking =3D {
> +        .desc =3D "Track with sched_switch",
> +        .test_cases =3D tests__switch_tracking,
> +};

With Ravi's change:
https://lore.kernel.org/lkml/20241210093449.1662-10-ravi.bangoria@amd.com/
This could be s/DEFINE_SUITE/DEFINE_SUITE_EXCLUSIVE/ , wdyt?

Thanks,
Ian
