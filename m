Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1466138F9C
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 20:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759262747; cv=none; b=H3YKgQJVvgmTmmdNIyCoS9vwyELDnt2ivE3nEHCe8mLGrNvj/m1izQjLAVohNNKscBec3nC82PckoAKzLjcB+29uV764pXWjnoEivMfXrrqPYGHr8zuOKSoqHdJgLTsMyypS4bu/9slrhY2GTj4DXrxw3jhFFv9Er/xci06LxZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759262747; c=relaxed/simple;
	bh=+O7E0xYbdBDkKmgcReNtSO/+rzQoEah3WlLA/TdGzRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=s/HzZq8ogyXKTsSF/trazQJ3T+PP+q1MFTSaUNMMU8OpsV68+72SKK9X+Wr/vdra7kFSGseUEDh8iv5FlYibyXtjJ8xLKA+gtyZVvp4aguYCVF3NhOOKnVZ0MeObz7CL+ySAsd82150NqvslqGzs4O2feEtH5v4sLfh0fm0A8pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2/1KNLDf; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2/1KNLDf"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2731ff54949so2405ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 13:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759262745; x=1759867545; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFCc179Dp3pOElR5ms1mLbchLu5y9iNqzrQelohBmx4=;
        b=2/1KNLDf4jcNrymcFQvVarhWy7MKX/V4VmNEFQcH/ct3RONjr/Q7h3zeFKxuPUtGTS
         1ge7On1vOhxVbCyEywcj175JlNBnWQgT5eWl/Clr1BjFXghWnvn7x1XU2mjD+6yUZqT5
         OcepLL59dvMR1Zp5D3iKvqlhgCmtzR6F4vbz/3H53RjmZ6IF4liDLlvMRM0IBCo3k2CS
         xPN4K3OcpqF1WwQSHbUdzVzhgZxfL3BVZyBK/ozwqwa6wCY+RRXaYOnbQSGYtL9xlOWQ
         Fgzt3EulyLAAGGY9O2dYGcsnc9R51x09OB2w6rHLB0vGxtPUCdFu3sf+WwmVV9ptB26t
         7Irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759262745; x=1759867545;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFCc179Dp3pOElR5ms1mLbchLu5y9iNqzrQelohBmx4=;
        b=DjhMhwJen6HekESv+afhnIKz6lMAGgr9E1eo8N1sq+mfXubizPYJymNX5SvPg9M9ga
         KuxYAiYQEq4KrU3kRNfEoDrVztxYjOIeMScwueLs7s/CWgq15ygYfMq3MTAp3tQVCgMp
         XF9eM6nu3ICwKMQmi+vfY+YEEFGrKEYWZYljlDHSt4Fl1Ukbj5szQEVi6zSbgq35Vmwm
         O2bWz9qTF5kUSjV7266JIZ7ZHSP+bPRixixEPmWn2zgs6D+asiJ7ulyuSkL+B73oq5k4
         NEMzpNWlyaF5bmB8As8yyBmcSgIcWSvE6tTXWN1SK9sUfgf30AytdKrR8V9DBsL98rdY
         k+DQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3CDjw4TRfnMznFdKI1nZyzv51EvGvh7jt+QtJB9JQorGi2a5+Un6yIlCezRaqKSg1jcE/0NQB0pbNofsRgHs5@vger.kernel.org
X-Gm-Message-State: AOJu0YxseMy0n0xY+f4G5jU3hxkvsHLA3AsMmkt7bPXgNDb2MV/d9KOb
	EZpzIuAyptVAKV8S4TZZdxJ3TagCqyc5j3QwfbW16uRKb0VxvwI/Uze61Fyrfy9GKXfOvq2TqQl
	RSMhS1gUZ4Rx0mqADmDRjYZCTiJJgvE4h7EVFpQfi
X-Gm-Gg: ASbGncv+DytfwHlYi1bPK1iY8edYbXr0C0YuxAzLALJhQVuGwhcZpkpMgjfljTEFrYH
	QKWLZbnGgdNCe54+VxZY3BqqY7XMjG7H4enHLZAgtVjbtDYWRs3qCO+I04b8LGXPXhn6PNannvy
	emIKm3AG5u7rN+cGMIGXDrhme8c/EBdG6QdQ6ldownHFMlUme35W/WS0J2EZ2SAvGNW8Wj9nZvL
	HeD0PxHs73eaa8816bF5KlMrVpHZXQhyXeqPuRHV5nHGdj2VPvToz3h/Dd7O8WKbfz1
X-Google-Smtp-Source: AGHT+IHHh9JevAZ7PaehVwgw6+jzVxzZ+2niK6DzklvkWwaIz9NijM5RmLov0xxykDGhNUTPGnG8FkD21SWdtww5YhY=
X-Received: by 2002:a17:903:2c9:b0:26a:befc:e7e1 with SMTP id
 d9443c01a7336-28e8003e1a8mr986365ad.12.1759262745053; Tue, 30 Sep 2025
 13:05:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250914183353.1962899-1-irogers@google.com>
In-Reply-To: <20250914183353.1962899-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 30 Sep 2025 13:05:33 -0700
X-Gm-Features: AS18NWAWr0cMyC7kAVVOvYHKqJ8zIPeQHKH65rFC18TxONt4GIIpxrAGDbGzuOo
Message-ID: <CAP-5=fV59uES4ZkNHDUypeO0XSnjkUTDWLydvaymEsegyeSb-w@mail.gmail.com>
Subject: Re: [PATCH v1] perf sched: Avoid union type punning undefined behavior
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025 at 11:33=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> A union is used to set the priv value in thread (a void*) to a boolean
> value through type punning. Undefined behavior sanitizer fails on this.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

> ---
>  tools/perf/builtin-sched.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
>
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index f166d6cbc083..eca3b1c58c4b 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -1532,35 +1532,24 @@ static int process_sched_wakeup_ignore(const stru=
ct perf_tool *tool __maybe_unus
>         return 0;
>  }
>
> -union map_priv {
> -       void    *ptr;
> -       bool     color;
> -};
> -
>  static bool thread__has_color(struct thread *thread)
>  {
> -       union map_priv priv =3D {
> -               .ptr =3D thread__priv(thread),
> -       };
> -
> -       return priv.color;
> +       return thread__priv(thread) !=3D NULL;
>  }
>
>  static struct thread*
>  map__findnew_thread(struct perf_sched *sched, struct machine *machine, p=
id_t pid, pid_t tid)
>  {
>         struct thread *thread =3D machine__findnew_thread(machine, pid, t=
id);
> -       union map_priv priv =3D {
> -               .color =3D false,
> -       };
> +       bool color =3D false;
>
>         if (!sched->map.color_pids || !thread || thread__priv(thread))
>                 return thread;
>
>         if (thread_map__has(sched->map.color_pids, tid))
> -               priv.color =3D true;
> +               color =3D true;
>
> -       thread__set_priv(thread, priv.ptr);
> +       thread__set_priv(thread, color ? ((void*)1) : NULL);
>         return thread;
>  }
>
> --
> 2.51.0.384.g4c02a37b29-goog
>
