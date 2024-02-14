Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86DE1419A2
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Feb 2024 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707954631; cv=none; b=YDJ2ET5L5hQX6JJGz30KDUwdKiQULLFZ9TSzrs0qqN23Jf0ze3rxtkO8g8+JRzKMMiFK3UCgove9Z/CyvF/CrMvbhkbSkIBnXA55zdR70ySFGsOeG0wJRTLDJ5K1d+WbZVJTfq/GT+CbYwa5swSCOyz+OdZW6SuLe4QPIuVUZPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707954631; c=relaxed/simple;
	bh=LjR2Xnv5w8P3uWdzHWgqQx1KlP4R++nOn3Ix96RndFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/82qBgNF+bscY66NBiM53uE8jCnKpINbeL/Apl39fJoxPmLnYV3pwQrK1NiHLcmKLdsp3ws8qmsaIZGxSg68Oem6fFPkbNf1aUaJKzg3k4uBgob7mSBlR0VCqDrgUEkpHP4SiIuiDjm3FfGiB7ojL0Ex+cGo58wch4WMdlhRtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F7of44bn; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F7of44bn"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1db61f7ebcbso34775ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Feb 2024 15:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707954629; x=1708559429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hLkk26SkKRw8FMas9+HqAOG+Ra2K1devtEkfmg/Abk=;
        b=F7of44bnvCadMk3qpclFp1z2yMm6S7v4SRY6nnILgD9Xk+DoYXeaBnOyVrk/VursvN
         6rajrrXqBRZELKjDC0duEhu0rpN0ZEI16rMe/N5fZgNzoerx6xP7lLgWdCyrMccp9Gyj
         gCLRoPtnx/BubQ6hQ8BgykqJ6fDJ8pxQBA2ABcqYgCS4wNPbMsdvPZ/v7K9RmAM7Jep0
         sgBWYPgabXKviv5ReFFaS23XrvkRKkooMiALZY9PZ39Lm3smSxPsJkv/QUtrSrBwbVsI
         l2EXoq0nS9znHTgMTObekMPXWuIzYDDw4LomuI48r7PerNxsEWgXD2x1yANC0zWv+Eu6
         fffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707954629; x=1708559429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hLkk26SkKRw8FMas9+HqAOG+Ra2K1devtEkfmg/Abk=;
        b=Ak7xNz+R28rpbVQ5E4aNbfC1Cq3Ziia3exh7wmP/qUD5OQourp0BeoQu00s1KiDwOQ
         IhL7QDHbf9Pdh1OUfwPAloi4aikrtyqCQPcoYNAiZLhH4Yvnb1Vp8/VWLHunuZd1jCph
         +bXgqOMTLKfllHiSz3tdFXe74YncpFNNQi3S3UDso9m/k5WkGt36BWEp1KthFgSXvnWX
         C3YormO1mulJlRENAz/4hA/1ZBLPfziDMzh8qGA9yqRtTqzge2eSkiXk0UhCfg2j9i0V
         YeBSnuWZ58wro9EEV0vIoy4lcbS8Qp5irZpDszlk+GUVR4V5gZQuuOMY4Ua2QyRb9OAQ
         3+iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdwvtjVku8wbEttao6PccpS91vUIc1Mti7KAG2KRSNgkyQoO26O6es5Z2nK0MovdKWfrPgfLfv+IJNqPyju6NbaS35agO+J9LgGddE8LEh7w==
X-Gm-Message-State: AOJu0YxQ313Bm3wyFjUJQyqlAfeiJWxIHGQYzRym6P+HfSBE7jDMV8a+
	xdc+JRKitemcndZMuJN6CNkm7qmqPpLnOfHHFyCAewW0fIjTiJSylui1gCW9dzLc8RahJRb3ahs
	Kr6nonGlIGMEm68ObdhCgQKdSKf0JxRkBfwiK
X-Google-Smtp-Source: AGHT+IEaYtCtfRfALjXKLxTfu9ipI8NqSOh4MowUemoPdlZzds56tsK1ladV4c8fkyXzoH6LsEAAEJK8gsFai2/JoIs=
X-Received: by 2002:a17:902:f392:b0:1db:5d07:f8de with SMTP id
 f18-20020a170902f39200b001db5d07f8demr285617ple.5.1707954628911; Wed, 14 Feb
 2024 15:50:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213075256.1983638-1-namhyung@kernel.org> <20240213075256.1983638-2-namhyung@kernel.org>
In-Reply-To: <20240213075256.1983638-2-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 14 Feb 2024 15:50:17 -0800
Message-ID: <CAP-5=fVXgKc0r+fup0+2-JOAtJERAsPq61MZh_f7HYTk2XqObg@mail.gmail.com>
Subject: Re: [PATCH 1/4] libperf evlist: Update group info in perf_evlist__remove()
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 11:52=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> When an event in a group is removed, it should update the group status
> including the pointer to leader and number of member events.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Should we worry about evlist's all_cpus that could also be stale now?

Thanks,
Ian

> ---
>  tools/lib/perf/evlist.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 058e3ff10f9b..befdb062fa1d 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -102,8 +102,29 @@ void perf_evlist__add(struct perf_evlist *evlist,
>  void perf_evlist__remove(struct perf_evlist *evlist,
>                          struct perf_evsel *evsel)
>  {
> +       struct perf_evsel *leader =3D evsel->leader;
> +
>         list_del_init(&evsel->node);
>         evlist->nr_entries -=3D 1;
> +
> +       /* return stand-alone event */
> +       if (leader =3D=3D evsel && leader->nr_members < 2)
> +               return;
> +
> +       if (leader =3D=3D evsel) {
> +               struct perf_evsel *member;
> +
> +               /* select the next event as a new leader */
> +               leader =3D member =3D perf_evlist__next(evlist, evsel);
> +
> +               /* update members to see the new leader */
> +               while (member && member->leader =3D=3D evsel) {
> +                       member->leader =3D leader;
> +                       member =3D perf_evlist__next(evlist, member);
> +               }
> +       }
> +
> +       leader->nr_members =3D evsel->leader->nr_members - 1;
>  }
>
>  struct perf_evlist *perf_evlist__new(void)
> --
> 2.43.0.687.g38aa6559b0-goog
>
