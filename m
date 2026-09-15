Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE0D42E40B
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 19:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789501279; cv=pass; b=ldQrwqqvNVI9ZTl++DGSFsfguau7Qb+1uhqxUDnWCpG7ZXwIG45NpN0HCczr9SCPWZGdSx0J7FgTNHb9xNcMvNfq2qgMhsn5FG/3214mblLT5SgZkx3tB6uB+eDL/M5RNHyX6kzyUSpyrDtH0iICabIqeWFdNNbFaTEf0PR+k+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789501279; c=relaxed/simple;
	bh=Ej8KoSGeQxcULu7TQzQUynSHUdtMBfWtTqc1vw1YL5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qS1NegsW5TAryMOPu9B+FKnw8t2Yal2Ch5nW71fwi0X3l+Xc7oofJD67O5k/c/6RDJmOrjBpaKvIIWvyIaUYC5+allcUnT4Th9Virr/xaBghFMH0O4yJx0zKoCXd+UaiVuMGB3Apzs1Rcgnuv72KtB4C4HhlBgfY9hrog/rmkYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dB0kI64a; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dB0kI64a"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530d5fc2cd8so61201cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 12:41:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789501277; cv=none;
        d=google.com; s=arc-20260327;
        b=KOY3V9Rd5aCt1Eh36x2qyiHbLVqXIlXCWw1CGAhTLqn5iomiPyXX9RLPx3476wGNH6
         A9cKeXTisoOXOBHUp9Mh5onoTwXrZSPZFFawegJ2EdyrDJXior+fxrRugt4p5G25yTL2
         UwlW74PyJ8Xb9tGdgbrV5mYbkRaMUeYLC+ich7Ygjh8nsZZiBY4XxoxJ9GVVm44g4clV
         NpjC9n2Kl1ddWH9q8pPHwDGs8EmaIQC8KwDMBK86+e3/nqa0VkYNeLV5TGLn+X9ptSX+
         B2+JuxPmMT/bDai60HsAo0AfL8zd/835dQkt57gj9SfqFZkc5idn8R98K6YYZCqbeAPG
         SbZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SC/BXcHW8jtefC9sLazfapcUVxrIRpfnR3KQcEsZeeg=;
        fh=MF173FHg/6PcDiopYNfyljxWxsBg4SrRIP0oEG615fU=;
        b=YnI+ec79HIsVVe04QvUbG2CbKVxL+NE32uPGrtW3wBsK5SItzTaR9mhmAmmYGqVq2H
         w2SalVGbqWYLiUCu27rsnUa0aHLVC5nQclu/FdT04lGlfD7DomiU+zRDQ8OBqUi9QPJ0
         soptlza3zY7S+Ws5TXzXMeM5M6qGOxjpimuDRpUzOBW7eQdSOgJJyyrcC5jenKkwIOlW
         XSQU/5QqdODjSWBBDdA9iBIc037zYLay2dzQjju/cZnzVRIQqTI53b8oK18ZPsovhaPI
         3scvK8+8IPlsem+D5t82oH0Q7+JtMjFbF/ls8gmWs5uWriyY1MHJblnpBLykX8zxkMBJ
         rnhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789501277; x=1790106077; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SC/BXcHW8jtefC9sLazfapcUVxrIRpfnR3KQcEsZeeg=;
        b=dB0kI64aEPXWdnccpfVHtSxmoAh0aHhnF9bXnPHwvrFhFPISaOYmG4WbKgqKewnzdW
         P0Hy/lUIrx6Nb+pLQVIj2eFtDtBcoOdV2YFqFG40qshsvF/bXIRAx9j0NHHWXyRWVmvX
         GXZI+yVqNM0p2Ix7lJfpyhIGEyuo2nXgxBVdhbx4lMojRSsY2GtQn6QUDLjVRXopmZeo
         sj6hG4ySsIc6diMmcmmYl7KRlJ7by8JlbIlc5/nc+UBCp3UR2whc2vEAumGdoYmw/Uyb
         0kZGau5o8bocoxtV3jAwxfwXpcoRPqYXFu2do3q1ibsgmkeClNUXzGYF/FmKojFJxbUb
         hCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789501277; x=1790106077;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SC/BXcHW8jtefC9sLazfapcUVxrIRpfnR3KQcEsZeeg=;
        b=VLSi2Y4s/q93zd32xaKBc8Fz0T4wvsc5WeGbXQs2fWc7CQTQ6PuQ14vlV8FdjF7bk1
         x1mKXl23u2QboK4ldaBbKzKC1VE8nSmWZFknEloJ3xvTlHVgvR9dt0dqohdBESCuF4zn
         cYg+f1EU/+uTpAVbzW6TYXiM659ZWt4TDGYIzSTVoHMclPyBJrcKQLLr3j2vlNzPkEuI
         OD7Snh+NZejfYqQ3AMIVeV0lFy7xzplvzdlS6cixe4URCWTr2BRJdUuwNsSaDK1NG+Zr
         EHArAVhD0/rIJ1KqyXYJH+cmxAqhRjv3tPBg9IeZjMCdXu0t2EI8NRyMNvny7UwtBrSl
         /S6w==
X-Forwarded-Encrypted: i=1; AKwUvBz3LGCPnQqz8eMrnowDEVzs2TMgeI2g4E/Rg8LHl3q0pEJHqw1y2zMec+RJAGgjB8RBJ4soPnFxxPxEFqoUHfsc@vger.kernel.org
X-Gm-Message-State: AFuF++nlE17xiCVO1tJFHaouetztBn1y0vCSAtss9KDtHk7jkoUlYyQ7
	wIxHmGLnE/VTUlazI3wtoDJp3gd/9jTS0h97FOWZVckJHNjY45p2zHL9tG73Wy/j+WfgTeNiGpd
	0145wXtTs+Tzluz0LXqxL0162d4zgGLNy6NtLLjSs
X-Gm-Gg: AYBFou0Ig2fTBiMCzqo9Ts/C+zu59fwj+SB+gmVPt/uU6dtTxbwEOxv6A3ctES7ZiGN
	+MVujvpovvDEN6k+hcJkKnWUbjMLgw6HeL5iYzbLkSdgN59h2MMTAV3ryoUqADvYohd46s2/TID
	QkSmBWZu3komILARMqQMJzZ6jBlBiPHng6YoAf1NyLmVA2hEl3v45+NkHQqcAm/HmDNFPzkMHlu
	GcrobHWbRq+o+o9jRm6p33v+GA9N7jrqjOLNMv2lwaTpzo+6QUgv/gpzKyKcsyzOddy36oV1l0h
	RRNTLjeH1W/ZWPf2SFdXEU3Ob6XNf4bJu2CqaGqNui0HhaFBghRc5qODPbEnCrKgkwylthecz8w
	BIOzXGEYKPw==
X-Received: by 2002:a05:622a:1b14:b0:531:a85:69c1 with SMTP id
 d75a77b69052e-53259a90915mr2530131cf.5.1789501276092; Tue, 15 Sep 2026
 12:41:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912055619.2284443-1-sh_def@163.com>
In-Reply-To: <20260912055619.2284443-1-sh_def@163.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 12:41:03 -0700
X-Gm-Features: AcwNN1VHVa5QCumRu92Zeyc87_NMbjXv1GcU2uE0TNV-q1jJtI9u_WX-kNBr56E
Message-ID: <CAP-5=fUCDeC+mAi_cVpNr+WoUXvpMG8948GVnb8OQV95PhVQ6A@mail.gmail.com>
Subject: Re: [PATCH] perf synthetic-events: Fix schedstat event lifetime handling
To: Hui Su <sh_def@163.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 10:56=E2=80=AFPM Hui Su <sh_def@163.com> wrote:
>
> perf_event__synthesize_schedstat() has two event lifetime issues.
>
> After a successful iteration, event is freed but retains its value. If
> the next iteration starts with an unrecognized schedstat record type,
> neither synthesizer assigns a new value. The stale pointer then passes
> the NULL check, may be passed to process(), and is freed again.
>
> In addition, when user_requested_cpus filters out a synthesized event,
> the continue path skips free(event), leaking the event.
>
> Make event local to each loop iteration so it always starts as NULL.
> Also avoid the filter continue and unconditionally free each synthesized
> event at the end of the iteration.
>
> Fixes: c3030995f23b ("perf sched stats: Add record and rawdump support")
> Signed-off-by: Hui Su <sh_def@163.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/synthetic-events.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index 0c150193cca8..2eac2310a01d 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -2817,7 +2817,6 @@ int perf_event__synthesize_schedstat(const struct p=
erf_tool *tool,
>                                      struct perf_cpu_map *user_requested_=
cpus)
>  {
>         char *line =3D NULL, path[PATH_MAX];
> -       union perf_event *event =3D NULL;
>         size_t line_len =3D 0;
>         char bf[BUFSIZ];
>         __u64 timestamp;
> @@ -2858,6 +2857,7 @@ int perf_event__synthesize_schedstat(const struct p=
erf_tool *tool,
>          * for filtered out cpus.
>          */
>         for (ch =3D io__get_char(&io); !io.eof; ch =3D io__get_char(&io))=
 {
> +               union perf_event *event =3D NULL;
>                 struct perf_cpu this_cpu;
>
>                 if (ch =3D=3D 'c') {
> @@ -2872,12 +2872,12 @@ int perf_event__synthesize_schedstat(const struct=
 perf_tool *tool,
>
>                 this_cpu.cpu =3D cpu;
>
> -               if (user_requested_cpus && !perf_cpu_map__has(user_reques=
ted_cpus, this_cpu))
> -                       continue;
> -
> -               if (process(tool, event, NULL, NULL) < 0) {
> -                       free(event);
> -                       goto out_free_line;
> +               if (!user_requested_cpus ||
> +                   perf_cpu_map__has(user_requested_cpus, this_cpu)) {
> +                       if (process(tool, event, NULL, NULL) < 0) {
> +                               free(event);
> +                               goto out_free_line;
> +                       }
>                 }
>
>                 free(event);
> --
> 2.55.0
>
