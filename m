Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1DD1E1C29
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Apr 2025 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743539025; cv=none; b=q9fUcPOlIR6Qdzk+v0ZmOEempCVzDwqE2E9UJtyC29CI8fo5fdQDsl2IE2skna9XFvV1Od+9co7K98w0DHF8l6SNWbunisZbCVHtY08NvYfKCkSV0KtPEF2W8m0oPTa/0gMigkaLbE2LP9pyI45m0oop7MqnR7e3hq0rpahG6b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743539025; c=relaxed/simple;
	bh=8D1xT8a0b7CgbI8gOlxA5+JoUXDPbXW7nrtKvBPf/R0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXjt39LbukBftnrylUh3Ej5Z8tC+NY2QW8s56eP5CwjIJX3lEH7fqkMczIlZNXKvsVbBUY1YB7VVmsaB0d69j+LBs0FKZ0ZE4ELLIJ4luOwMO1m3I8o65wmkna9R3u76vXaP3RM40SWazst5U38PpbJPSi/6qoJGz1+I0UADy4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FYgVcuQz; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FYgVcuQz"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2242ac37caeso7285ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Apr 2025 13:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743539023; x=1744143823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZAcMUbqSMQxpNYoKMoe9LwWg1kIJPyXPHsJmNqOlVU=;
        b=FYgVcuQzKsta09szEvJWwFpJE2WSXCJsjTO/G2f9OkThlBKRodY9xEyxfdJbhJpI4/
         n+xP51y1u8PGu+rADx8kWwdX1vNjH8JDJGYT2XoQr2zq6Syat8ansKtPzFfQX+yNCudm
         TSblbcH3KIBsBiqCoZfuyF2xnJM0GYuxHAGy6M/igdQQwl5XGgJw1/dr6jecD3hgjHmr
         74VyjAifj5wi78mTy4eeM2+187bclMfE7BSzfTqpkZTqhfKOMqQ4Ul+JukKWStfjwLBq
         RfBjO0P6YeGGbwv3v1pYunGq+KVuunFOGKWU38Fk89oxb4R0edPBJuRA6DB52zg4egaS
         Rjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743539023; x=1744143823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZAcMUbqSMQxpNYoKMoe9LwWg1kIJPyXPHsJmNqOlVU=;
        b=LpT8h+W27RLwbFkxlC4aRgp+Wg/iiOD7nAii9Sh9COKhj7HBU/Nz+wjIWd9x7pBkMj
         6NKVKUhZdGtj8BpN/V/ilJgmSaL9p9YWdp9cW6FgKVJxuEM+e1v10Qp4yfH/+xXrbEJK
         Hs9k28JpcL26bfpXyutydPjIJBDqQt1erV10Ec6W3ewffG3dwSHefe+NzfjU0ghcMGie
         70h9W6GEj9aRo0NrfR7wTs4dqZg/OpUiNu5j1XXjFeoUljxiUXLcNE7pnlCEQVhCJV1g
         VMVV/3h/hNwKXBX6MnfbvBLFPasQbRrAPINUDMoVS0Z8frDpjfJYbCxmDqqHdXU1cKlA
         I9Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUnA/gbGHGP9TKMMosHupyDGBh9diVMf4an5j/7BYzPLqWZlXQcZiaOoDIoE3A5vpwCvZehb2Zyuwd1D3tcOdgp@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq5zIQ2909OeQy+bVwWL+tH2T6YvbcGApgVSg2WaVt+qRBc3wR
	Yxrrstf1kPhhQUgkRE/7Q9ZiRQOwkyeEK9Hd1q9WJJdI1kMjszWtCzGedgQqFGuGxP4dvKHZ9ZX
	TKCl0WNB5PT7mMVdqHDIwIwq4cfIiNP1mP7jl
X-Gm-Gg: ASbGncv5EV8yVxxgsnSnnAhO+ahb/92ki97mMIWorzMpao4FIFDE3TGVIY9/8i479mF
	qgYzllZS+LmFgqmWLXLnLt/zwWKRiQws6f407p1Dd8av67lkeDJ98btFOqfkgB+qEcAaBSVF5MQ
	eqjJKhnI+o7Jt7wrbQTddSPhaP2isJpyzVOX1DtXUymptJ5n9rPweB/2RBR9abDbW9
X-Google-Smtp-Source: AGHT+IFCjw/qVBDjA/mm5foS41L30Ts3NcNRK1D/PrgXZKzythsTSFQf+gbitg18EFV9GzXU6K/bWIf1y+y2OWix3VQ=
X-Received: by 2002:a17:902:ed12:b0:21b:b3c4:7e0a with SMTP id
 d9443c01a7336-2296a01c9cfmr504615ad.13.1743539022991; Tue, 01 Apr 2025
 13:23:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331184638.3856982-1-namhyung@kernel.org>
In-Reply-To: <20250331184638.3856982-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 1 Apr 2025 13:23:31 -0700
X-Gm-Features: AQ5f1Jqt-SYxYK_Z4LJUtRH5N5zNduKl7fj7RvF0IPB6x629cLIhgyPKjGfEfrg
Message-ID: <CAP-5=fXUiHMK5jGo6CDBCGramH2OaqWFi_TyjMofM43dqST+FQ@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Fix some leaks of struct thread
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 11:46=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> I've found some leaks from 'perf trace -a'.  It seems there are more
> leaks but this is what I can find for now.
>
> Cc: Howard Chu <howardchu95@gmail.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-trace.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 3d0c0076884d34cb..10cd99888a9a11b5 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2835,7 +2835,7 @@ static int trace__fprintf_sys_enter(struct trace *t=
race, struct evsel *evsel,
>         e_machine =3D thread__e_machine(thread, trace->host);
>         sc =3D trace__syscall_info(trace, evsel, e_machine, id);
>         if (sc =3D=3D NULL)
> -               return -1;
> +               goto out_put;
>         ttrace =3D thread__trace(thread, trace);
>         /*
>          * We need to get ttrace just to make sure it is there when sysca=
ll__scnprintf_args()
> @@ -4123,8 +4123,10 @@ static int trace__set_filter_loop_pids(struct trac=
e *trace)
>                         pids[nr++] =3D thread__tid(parent);
>                         break;
>                 }
> +               thread__put(thread);
>                 thread =3D parent;
>         }
> +       thread__put(thread);
>
>         err =3D evlist__append_tp_filter_pids(trace->evlist, nr, pids);
>         if (!err && trace->filter_pids.map)
> --
> 2.49.0.472.ge94155a9ec-goog
>
