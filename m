Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8372E770FB;
	Thu,  9 May 2024 18:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715279063; cv=none; b=BbqmqKd8WjKGvCTOGnma2Mb3SDnMbIkh7f2C1PelF9w3T0YqAXu2R7O8YpZfOry3W7/jtyKhduRp6mIxglUQibD3A/uL9hF4QHNVhWtCJuKeZZ9TsnBcJj7MbqdbMar1/9nUDWSTbYOv60GOzNYI6r1xHKy51yroGjJZUDK6Pgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715279063; c=relaxed/simple;
	bh=5Qo27+WGss6vpZfPHE6zXvgF9tWSHfs0qT0N/c77xwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3T5jRf69GwNWxS6t/9ghhvYzt7odZBGXPuhYJs9S17WJynQMDu7Ldhg/iZp3euauREu/lJY9RaoD8E7w9e9cE/UPCmOFWMyJIWh6kVuhPRNUpiuDG793VlqWXUK7hrfT/IcwdV6Qq5ws9jzv/Nams4Uc5EJ/sm834G+/oc5A/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2a2d82537efso949984a91.2;
        Thu, 09 May 2024 11:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715279062; x=1715883862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKNW444OCrxlPgBeDO8oQQCjMSV87teux/IWGrH4YXY=;
        b=lw38SU19s24rxNQO7vow3nrWOF1J0ssnGFrFzP2Z5ZISudwqn0IhqnzFVSg9/AVd8L
         AW4dvyzMPIB49z2NlbzEmUxS7oHWtz3gnbveWvMcJVVJK8lW/gqdPhYjej7Eeay8G8e0
         e1cn676192igqXCZ5sN+1PZAoCyyh7h/83nje+dqFKupJr9GuYH17cFhIIuoshdEOA9F
         P/c0rvXQoWE1uBVAxv2RC6z7vPIyyUjNw42tGH+H/t/yqYot6dq8e6YRMTnZXUs9ge6Y
         DbiN9ECI2+dR8MtEaMrIVTkAeoAjiBN3hDWPyL9/Yr3o2JglFArDWXRsd50xH6hs3+xX
         2NrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNfwcY+4y74DZssQoSjEiiCHXhzhJqaN04K2ve6CDybYkCjS7riKAiVnA9FO23x9XQdffp5aurY1+GI7bdIvnHHlgthFzyY+h8xP9yf6cPFXZrTq1GVw+kMCgboEMMJ1ogPgNIYq5ESNmu5WGExA==
X-Gm-Message-State: AOJu0YzVuqbybNHlng2Kyvzm3zbM2WB2hj3p98REZipioB0UT3KZQliD
	ejLo/UjA5hR8gkjTlcnCT3Ikjbw+4o+4ABmQyGiI9jmWcwHC0iSO9Vcg5FlCzlMxV/3DgXtHjFu
	xUFJsDFHTIQsh8sLpV1jHiPCr0CM=
X-Google-Smtp-Source: AGHT+IGVwChJwQYvTdUiUEJ2+Vdnd/GheO3jnq9D1q4FcmEFE3GfMc/os7kOwhnzsI0nokZTkwOr01qL9ylMpG3TE1g=
X-Received: by 2002:a17:90a:dc82:b0:2b5:6e92:1096 with SMTP id
 98e67ed59e1d1-2b6cc87abadmr251896a91.28.1715279061761; Thu, 09 May 2024
 11:24:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509053123.1918093-1-irogers@google.com>
In-Reply-To: <20240509053123.1918093-1-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 9 May 2024 11:24:10 -0700
Message-ID: <CAM9d7cgvRO0niWKi8dVnaYU1Y0C2hWCYxdA+Yb1vObDdgK85Kg@mail.gmail.com>
Subject: Re: [PATCH v1] perf lock: Avoid memory leaks from strdup
To: Ian Rogers <irogers@google.com>
Cc: zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 10:31=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Leak sanitizer complains about the strdup-ed arguments not being freed
> and given cmd_record doesn't modify the given strings, remove the
> strdups.
>
> Original discussion in this patch:
> https://lore.kernel.org/lkml/20240430184156.1824083-1-irogers@google.com/
>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/builtin-lock.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
>
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 230461280e45..7007d26fe654 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -2275,23 +2275,13 @@ static int __cmd_record(int argc, const char **ar=
gv)
>                 return -ENOMEM;
>
>         for (i =3D 0; i < ARRAY_SIZE(record_args); i++)
> -               rec_argv[i] =3D strdup(record_args[i]);
> +               rec_argv[i] =3D record_args[i];
>
>         for (j =3D 0; j < nr_tracepoints; j++) {
> -               const char *ev_name;
> -
> -               if (has_lock_stat)
> -                       ev_name =3D strdup(lock_tracepoints[j].name);
> -               else
> -                       ev_name =3D strdup(contention_tracepoints[j].name=
);
> -
> -               if (!ev_name) {
> -                       free(rec_argv);
> -                       return -ENOMEM;
> -               }
> -
>                 rec_argv[i++] =3D "-e";
> -               rec_argv[i++] =3D ev_name;
> +               rec_argv[i++] =3D has_lock_stat
> +                       ? lock_tracepoints[j].name
> +                       : contention_tracepoints[j].name;
>         }
>
>         for (j =3D 0; j < nr_callgraph_args; j++, i++)
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>
