Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149F816401
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jan 2024 19:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uksCHxKr"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso2286a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jan 2024 11:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704223852; x=1704828652; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOYTEsOV9lTiIGnRFctHuQqBGe69F0YWFLoKuRVOe74=;
        b=uksCHxKr0hZihpngARh1CH39gUTfHNLhA4cbu5pGAfdRlQqU4beXtPy9gSEeGjS35I
         RzZAqTsu8/ByiZkB6jhpRU2Z6skD4DyBOmTiVCGR9ToKLrx5c/0kMPB0Lb25quxQJNFp
         XBTeUrvtxBcdINpVJJI7GUSFjV12mNo9SrGG7k7h6YWNLZ96F1wq6g/o3rCAoV/0fBz1
         LuALXzMaqO4EpEU70TEU1tFC61bI5ScUymGikTJA5hwcvpSo/6w4C9TPntx3sjYqQcc+
         sxApoy12sGA7jRisdYbQSRiKXiljlYLffmyQe2cHXw3VHUv7HETIaQ1NZUXi855DZFhK
         dOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704223852; x=1704828652;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOYTEsOV9lTiIGnRFctHuQqBGe69F0YWFLoKuRVOe74=;
        b=iJNUUkFa6q53n/IKd1fLjdEZaML+PyV+LLPXRIgspyzATWvNbKgRb21k/Yd2oPJydX
         0an8ugcIp0cEPASiaQomwCvFEPvO2Fesi59EX6A70etoe8fO5AXjXviX4RM7aztyw07X
         8Nqi+4L22rQL5EpOJzj50CAA2AJveOS9W3QGK+9k4oLlAg/vAIjw4qw0deyaisfmAdEo
         92p11k8JTv4FRs2La+x0sAJJJKbydxhIbys6Yxyar2lme55PxEJwTc0hV0Wky0kEJKC4
         CwgdPy0cnI/q9cFdEffaf756XEikg4Y0u3TKTwZayxrFuGrC0Q+2RvtEQttMeIR0k2xl
         yJXQ==
X-Gm-Message-State: AOJu0YyLOmXY49iuaRJvvlSdFilm+USRFK6XvrOZUOykgqO0nrHNd9f7
	IZFuOUSEPgxnUqnEReQtGXAW2P07eDbCdKL6T9bCh8QHYH2J
X-Google-Smtp-Source: AGHT+IFxkEp53qfdvKXchSLSayawO65q7whtBRhMEQhKEn3q2M+ar5ghgojFLixiM/BGo5c47KunMgRuv1alQVvLjgY=
X-Received: by 2002:a50:8d4e:0:b0:554:98aa:f75c with SMTP id
 t14-20020a508d4e000000b0055498aaf75cmr2425edt.5.1704223852224; Tue, 02 Jan
 2024 11:30:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208000515.1693746-1-irogers@google.com>
In-Reply-To: <20231208000515.1693746-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 2 Jan 2024 11:30:39 -0800
Message-ID: <CAP-5=fVQfqS6gu9Ua3Exijc_ZaBzrt2=1PMopgdoyC_6R_cnaQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] lib subcmd: Fix memory leak in uniq
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Chenyuan Mi <cymi20@fudan.edu.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 4:05=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> uniq will write one command name over another causing the overwritten
> string to be leaked. Fix by doing a pass that removes duplicates and a
> second that removes the holes.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping for this series, no comments since sent.

Thanks,
Ian

> ---
>  tools/lib/subcmd/help.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
> index adfbae27dc36..8561b0f01a24 100644
> --- a/tools/lib/subcmd/help.c
> +++ b/tools/lib/subcmd/help.c
> @@ -52,11 +52,21 @@ void uniq(struct cmdnames *cmds)
>         if (!cmds->cnt)
>                 return;
>
> -       for (i =3D j =3D 1; i < cmds->cnt; i++)
> -               if (strcmp(cmds->names[i]->name, cmds->names[i-1]->name))
> -                       cmds->names[j++] =3D cmds->names[i];
> -
> +       for (i =3D 1; i < cmds->cnt; i++) {
> +               if (!strcmp(cmds->names[i]->name, cmds->names[i-1]->name)=
)
> +                       zfree(&cmds->names[i - 1]);
> +       }
> +       for (i =3D 0, j =3D 0; i < cmds->cnt; i++) {
> +               if (cmds->names[i]) {
> +                       if (i =3D=3D j)
> +                               j++;
> +                       else
> +                               cmds->names[j++] =3D cmds->names[i];
> +               }
> +       }
>         cmds->cnt =3D j;
> +       while (j < i)
> +               cmds->names[j++] =3D NULL;
>  }
>
>  void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
> --
> 2.43.0.472.g3155946c3a-goog
>
