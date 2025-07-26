Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A0B2E41E
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Jul 2025 00:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753489819; cv=none; b=lMdtlKUSPEUo/shnNYwEdn8HUZIYrr61f65QsSWXAEEOR6cH4czRs1KGJcXcPGXfFONjY+vHbUMq3VreKhIyj1lSTAqG7iDj9hQKbwovMEII9azJ1p+d3VeqAKnn62CwsHW/xqSsI4IZPKKMMhiO7XiYhxx/V3536/HmpN9KOU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753489819; c=relaxed/simple;
	bh=5VZiPzAk02+Z+u7DWJ3d8mCBiSi0EmcuuRSJYn2qm9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHXf8686GVYCZkKiQe4xjeEXAMCCNPrcTw2gO0T6npYtb3idQFf9WW860yxV5CZJ/UAG/cXWcRRxs34bOlTgQIug8DxECMgFgU41taPGdfZq4tchHtta6twMsIPIWN7JALUfBkqOiaiPTW7b82yVtQzf6sVLODEeHlGQuTWLi7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cj5e5XqT; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cj5e5XqT"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3e2429bd4b3so41365ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 17:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753489817; x=1754094617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FLPFGHXVO+M6lQeuPBeajmfc+gHzdZezLy461FS5no=;
        b=cj5e5XqTcKeVApvk59xCtD+6n20mkeq0pPoV2phbVd9wzN7qF0wshC4+oC+fJojA/x
         Ttf1iHYccwcc/87krctoMLcNoD4KVLvD+2sg0urZ5wQb8yDu4TUgmsTLJLKJ2GF1m/CT
         yX1f7Gi5MSlWhR+H4tfhKmzjA4aAJv1DIbzz7pf3rIQjoaZddXqLvBo4pGz4BPw5BpZq
         DUthpESbJJzQavIRHIJ1mAytmKDeS8wjJrP4jtM+jw2xMsjWI9KGGDNMqPQgtA+KnLT3
         JRrccFYqcGYAItDwLmqjnnPFbD6qLxD4TQuOCes/rL6jIVxrOuk6mAnmjf+4yG97jrkU
         pZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753489817; x=1754094617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FLPFGHXVO+M6lQeuPBeajmfc+gHzdZezLy461FS5no=;
        b=DqHdaS74lc+lnskxsJggoe/uQg74de1xBFHWsDD1ADsOd5V4RcaJih/BZskF9Zsdwz
         3IzBzRzuoUIWDuii+jWM9irdU9rwJhInRR+e0FFYk4eLfmqo8Gf7wRvBwyuH9sbfR4d7
         x5eCRULGnmsXFxjLm2DlI6bAHwSNflN1DeOt8Ms0rn0KcjmSrXvwoB7JZhMAGB8tuk0n
         SRYGGjUJ7kTzxO+aNcP9dgtq/wcPSFeLgkTQWQGs6Shy3Ytt26R2iIBKHFmvi/3ZTTj/
         Weda+GaZsjCwQLhhnZfSheTnWFoXhd2OF067bu84lfMRApkMhdWBBNbjMjxhdF3+m5Vb
         aOxA==
X-Forwarded-Encrypted: i=1; AJvYcCXknrN/uIOb3kUK8AGQLI9T2sfIv4e9sfam/jy8d5GaqMzJive8dbPimJp3hXYcYtZs79cVocZBpgw2GLqknObR@vger.kernel.org
X-Gm-Message-State: AOJu0YzyThcM3ZMGeZ/dtmLTb5dAD8MvSgJ/zF1qt/n1/7YFBvtQgtmf
	czkjwZ30u9Hz78Oq2OWKjT4FqfZmXe1YbC3zdTOefPhuc1Xim3LoMi+erEB3BPmbcpCnxXNpf3p
	2YDNB84u1M+1AeFhKgl/5cmB6ZvW3czcCK8mampb6
X-Gm-Gg: ASbGncsVf60siszQvQRWGL7CBL0QVoUtKQaatQy0Jpti4u1EEFSHfpwm/g5M9yHJpnz
	Y96e7p1hmwivPBEQFNA1aNZHqXvz7f9eDLUnVuCKXUP9EdXZxgefG1TFT/DtxaTl+Nn0Akz871n
	MJvh12gLAH32UnI68evXHvEI6X7K/p7JZazo54s/4tDNLbUQgZnHRFUdXKQbpCOWB7k3vBPZ0TH
	R4dRqVB
X-Google-Smtp-Source: AGHT+IEKbaGdaud57btGyC8P7efLaOwq5P86iPcR7HobckPzULoLUGLjsjSvgvmW+f+wDNGNbCbt4jUgQKIYpKtKBA0=
X-Received: by 2002:a92:c249:0:b0:3e1:eaf:3d48 with SMTP id
 e9e14a558f8ab-3e3cbf76627mr1743835ab.4.1753489816811; Fri, 25 Jul 2025
 17:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725193755.12276-1-namhyung@kernel.org> <20250725193755.12276-5-namhyung@kernel.org>
In-Reply-To: <20250725193755.12276-5-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Jul 2025 17:30:04 -0700
X-Gm-Features: Ac12FXxBOo_Y2Pp_nCCqNn85Oau1WrRBF3-bt-lIx4Tt5Hsl_uAnLJ4qW2KUHe0
Message-ID: <CAP-5=fUM=1paD_3morMnz_6m8WWE8pmN0sC27xPanbp3FWYtjQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] perf annotate: Simplify width calculation in annotation_line__write()
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 12:38=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> The width is updated after each part is printed.  It can skip the output
> processing if the total printed size is bigger than the width.
>
> No function changes intended.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/annotate.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index c21152710148b68c..d69e406c1bc289cd 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1993,6 +1993,7 @@ void annotation_line__write(struct annotation_line =
*al, struct annotation *notes
>                                            symbol_conf.show_nr_samples ? =
"Samples" : "Percent");
>                 }
>         }
> +       width -=3D pcnt_width;
>
>         if (notes->branch) {
>                 if (al->cycles && al->cycles->ipc)
> @@ -2056,11 +2057,12 @@ void annotation_line__write(struct annotation_lin=
e *al, struct annotation *notes
>                         obj__printf(obj, "%*s", ANNOTATION__AVG_IPC_WIDTH=
, bf);
>                 }
>         }
> +       width -=3D cycles_width;
>
>         obj__printf(obj, " ");
>
>         if (!*al->line)
> -               obj__printf(obj, "%-*s", width - pcnt_width - cycles_widt=
h, " ");
> +               obj__printf(obj, "%-*s", width, " ");
>         else if (al->offset =3D=3D -1) {
>                 if (al->line_nr && annotate_opts.show_linenr)
>                         printed =3D scnprintf(bf, sizeof(bf), "%-*d ",
> @@ -2069,7 +2071,7 @@ void annotation_line__write(struct annotation_line =
*al, struct annotation *notes
>                         printed =3D scnprintf(bf, sizeof(bf), "%-*s  ",
>                                             notes->src->widths.addr, " ")=
;
>                 obj__printf(obj, bf);
> -               obj__printf(obj, "%-*s", width - printed - pcnt_width - c=
ycles_width + 1, al->line);
> +               obj__printf(obj, "%-*s", width - printed + 1, al->line);

This doesn't seem to line up with the commit message, should width be
updated prior to this call?

>         } else {
>                 u64 addr =3D al->offset;
>                 int color =3D -1;
> @@ -2112,9 +2114,11 @@ void annotation_line__write(struct annotation_line=
 *al, struct annotation *notes
>                 if (change_color)
>                         obj__set_color(obj, color);
>
> +               width -=3D printed + 3;

nit: For constants that like '+3' here and '+1' it'd be nice for a
comment just to say where the adjustment comes from.

Thanks,
Ian

> +
>                 disasm_line__write(disasm_line(al), notes, obj, bf, sizeo=
f(bf), obj__printf, obj__write_graph);
>
> -               obj__printf(obj, "%-*s", width - pcnt_width - cycles_widt=
h - 3 - printed, bf);
> +               obj__printf(obj, "%-*s", width, bf);
>
>                 (void)apd;
>         }
> --
> 2.50.1
>
