Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31069DDA6
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Apr 2024 03:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448212; cv=none; b=FE4H+iE3ON+rs/myIne0Xx8iNjR1LYJbOY68EjLA7JxGyDjKjaz3GZOUHndFGuQGz+M81dMYW6rAIGj906T66TSLqXTw6wgFfR9u+W7u7TnOvo1YceTOYOtmqsv3+JjIojAoARMGpw4CXrirDeyU18PQRV0PH/Senti5qYtJu3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448212; c=relaxed/simple;
	bh=zBq1LHiQVLgDn8WCXIPPZegxnFwBTySh9wmNs5lQQA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOHRhwQ1TYzGgjPnMUSxEL1Jrbo0ZHSbnT1E17lAcjAsZ6CKvH84I98Eo/A8qBb9WwQ+L8xjtWndKIP9rApg4NPDvYz+py0VuBCqp21AVD+CwH6YbV9kmfk7fwHqbxyOvQ0q/IqrClE44MIEaygGh8cVZ9unj4NQ8lI2rLG+7jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GzVrh3VS; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GzVrh3VS"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ec182ab287so61705ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Apr 2024 20:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714448210; x=1715053010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkrtyRv2EBwxmmqvBQQh1p4PP//wdMb/rRAhkXpumuM=;
        b=GzVrh3VS0bHBnl+32T+sVKIeKiqRT5797ThoU9X3OFdxaum10ZbmP/0j4mAJDzb4g6
         FMyqyXktRwzvxHiR6eIjK2sTr5eaZddK970eYljC3bHZwk9gTjGMrO1DlOXSgGfKG/aQ
         SjaG+v1yVpoaEv3ZbhnU4fLE+n6UAdv+zz9tp9B2mtWP6enMArSwT2zR/HG+NCY6C310
         P87SFBa64RfMHUocDyK9mNo72RU+d7SGhkPmzwxt1kWqh15pbt3DT23xrg7cjaBP+e36
         pE+ky4Y5oGa9E/sJ9/QdgfyDpdBT84VZ9iaCtK25/zUAdtL3+ZR2l9rs11ipRn8jNii1
         HXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714448210; x=1715053010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkrtyRv2EBwxmmqvBQQh1p4PP//wdMb/rRAhkXpumuM=;
        b=RqwNE8M79QwTj2zLSHcKo2+MT5hgsqZkYbhXAKgH8eQehx52FbMC0jvFNJe9EnsFA9
         QfANR22Hk3mXlbvEh5SZYd+xlMMfWjSq3HRDDmD5x3CKBD7hmxhmYRVOaGV0BeHu8AlR
         jm93w7PtmHl3N9m7G9POi+WddnPMW2i3dX+8pp7dM64LBRTLq+SIFxVkScPqIeGwSUJT
         rmjmXCh14z9Xeqpab7uyO/OTx7MJ+/8U9y2+lRmZTVhlybETonYA7iLK46t38mXpw2JV
         Rcvv+hXGGuasbzUafaINw9qX0Bde2bHPc4B3xpkThd0sIMjq6FdO5FRRgu1chW3GLaiV
         cAQA==
X-Forwarded-Encrypted: i=1; AJvYcCVZMngEth5HyWTxiU1AY31kBewRmLm9UCCbjKU2mle76Eg916EaZ8Ct4oh6KUZ6d186Nbn9IylUh/v1Xe4PNE8KVZpAzyOL/o8ICbRWm/yBew==
X-Gm-Message-State: AOJu0Yzv8PxB1GXQPXaCL9ooeSGES2Lf2vZmMBt4KKmF/RQdx+94Iayq
	+8UBCDqS6vD53zf1YARnuozns0L7CwOx8orTWYrzET/aFypbf2a0L8tYZ+T494+6lKVCM5CAu1b
	44qPgK/EVTN1p0VxTQEVXwgU2FeWXZ5riLVc9
X-Google-Smtp-Source: AGHT+IFjgB5d/cluocj38XNvLS2lFgJH2RwV1hbfZaFXHLYTLK65bWNgayIaDdQ3T9jL5Wf9d9jj9ZbTN+WAaTslrrM=
X-Received: by 2002:a17:902:e551:b0:1e6:3ff9:edf7 with SMTP id
 n17-20020a170902e55100b001e63ff9edf7mr139796plf.10.1714448210110; Mon, 29 Apr
 2024 20:36:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429233707.1511175-1-namhyung@kernel.org>
In-Reply-To: <20240429233707.1511175-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 29 Apr 2024 20:36:38 -0700
Message-ID: <CAP-5=fWWML91BsOfF1wvJcDFPG4=S_b3cTe_gza6GDQyWYjksA@mail.gmail.com>
Subject: Re: [PATCH v2] tools lib subcmd: Show parent options in help
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 4:37=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> I've just realized that help message in a subcommand didn't show one
> in the parent command.  Since the option parser understands the parent,
> display code should do the same.  For example, `perf ftrace latency -h`
> should show options in the `perf ftrace` command too.
>
> Before:
>
>   $ perf ftrace latency -h
>
>    Usage: perf ftrace [<options>] [<command>]
>       or: perf ftrace [<options>] -- [<command>] [<options>]
>       or: perf ftrace {trace|latency} [<options>] [<command>]
>       or: perf ftrace {trace|latency} [<options>] -- [<command>] [<option=
s>]
>
>       -b, --use-bpf         Use BPF to measure function latency
>       -n, --use-nsec        Use nano-second histogram
>       -T, --trace-funcs <func>
>                             Show latency of given function
>
> After:
>
>   $ perf ftrace latency -h
>
>    Usage: perf ftrace [<options>] [<command>]
>       or: perf ftrace [<options>] -- [<command>] [<options>]
>       or: perf ftrace {trace|latency} [<options>] [<command>]
>       or: perf ftrace {trace|latency} [<options>] -- [<command>] [<option=
s>]
>
>       -a, --all-cpus        System-wide collection from all CPUs
>       -b, --use-bpf         Use BPF to measure function latency
>       -C, --cpu <cpu>       List of cpus to monitor
>       -n, --use-nsec        Use nano-second histogram
>       -p, --pid <pid>       Trace on existing process id
>       -T, --trace-funcs <func>
>                             Show latency of given function
>       -v, --verbose         Be more verbose
>           --tid <tid>       Trace on existing thread id (exclusive to --p=
id)
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> *v2: remove goto and add comments  (Ian)
>
>  tools/lib/subcmd/parse-options.c | 36 +++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 12 deletions(-)
>
> diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-op=
tions.c
> index 9fa75943f2ed..eb896d30545b 100644
> --- a/tools/lib/subcmd/parse-options.c
> +++ b/tools/lib/subcmd/parse-options.c
> @@ -806,18 +806,30 @@ static int option__cmp(const void *va, const void *=
vb)
>
>  static struct option *options__order(const struct option *opts)
>  {
> -       int nr_opts =3D 0, nr_group =3D 0, len;
> -       const struct option *o =3D opts;
> -       struct option *opt, *ordered, *group;
> -
> -       for (o =3D opts; o->type !=3D OPTION_END; o++)
> -               ++nr_opts;
> -
> -       len =3D sizeof(*o) * (nr_opts + 1);
> -       ordered =3D malloc(len);
> -       if (!ordered)
> -               goto out;
> -       memcpy(ordered, opts, len);
> +       int nr_opts =3D 0, nr_group =3D 0, nr_parent =3D 0, len;
> +       const struct option *o, *p =3D opts;
> +       struct option *opt, *ordered =3D NULL, *group;
> +
> +       /* flatten the options that have parents */
> +       for (p =3D opts; p !=3D NULL; p =3D o->parent) {
> +               for (o =3D p; o->type !=3D OPTION_END; o++)
> +                       ++nr_opts;
> +
> +               /*
> +                * the length is given by the number of options plus a nu=
ll
> +                * terminator for the last loop iteration.
> +                */
> +               len =3D sizeof(*o) * (nr_opts + !o->parent);
> +               group =3D realloc(ordered, len);
> +               if (!group)
> +                       goto out;
> +               ordered =3D group;
> +               memcpy(&ordered[nr_parent], p, sizeof(*o) * (nr_opts - nr=
_parent));
> +
> +               nr_parent =3D nr_opts;
> +       }
> +       /* copy the last OPTION_END */
> +       memcpy(&ordered[nr_opts], o, sizeof(*o));
>
>         /* sort each option group individually */
>         for (opt =3D group =3D ordered; opt->type !=3D OPTION_END; opt++)=
 {
> --
> 2.44.0.769.g3c40516874-goog
>
