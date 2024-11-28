Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E8FD27E
	for <linux-perf-users@vger.kernel.org>; Thu, 28 Nov 2024 00:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732755089; cv=none; b=MpiE+ZRfhDgaIn4gnncTYz9KIgKLbOU8QQEtpdoWOHOrUMctwrnoWTJbVNEfFP/0j8oWlgnYp4guhNL/BxxVu4r9Yf/wzXYcHIi7CaKd1sab0cSK2EdRGSUhmOzE6/PumxJmkZpKYJWOGkVV8Q6fe9QM3InpRB2PIcoiNQirF+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732755089; c=relaxed/simple;
	bh=ECzqOYYQAwVhTqlgToe4cHCya7AUIwCJKbeWDaNywYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=us+zjEFOEUGORKG0wHYRXA1rgM6YRQ+N3omqi3nXuYxtr+lrvocJHr10OXVFm2grWdx8Cz8+luH/Cb3/431ZVPUU7C/fFLV7SvihycNI5/surU1KEluWVSIfgoQ03AS+z2A4bmDqKqNJONkXTyjv6aeaT/+QACBLaudiTIWMhYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jn9ob28B; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jn9ob28B"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a781e908a7so17945ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Nov 2024 16:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732755087; x=1733359887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLiTfyzcVcR229K1ikE+nUNAVjEsCa37tEiZKYXv2lw=;
        b=jn9ob28B/xGdJmPVMpOPUoi2kBZyYoGvIVz1EU+IIxivCqeOATfkSyeKHAM0fhvFI9
         7rwSMlifur9ymumtKTgxz8tUHDga86zXT9CWPvwgOYPs5OH2+B9CIhR/688Eaf+K02Je
         KsG4lTmnxGyH0U/SKKBnznmxb9zG5OGzzxZ4Y2VXRSu5uboSFwTv0mhNBzU9Z8X7gfBO
         yQtFd3SA1WKtJVMpju7cDB1If/nwE9JhDI7iAe3JTOU3QRpLQCERKMwqXfBMBN/IwsYr
         qBdiZuXeodRiLkAhV7UlVs3FtqwjYZ2dR895DSFLy5Iul93SEUof5edIjM0aIV/bn+rv
         YXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732755087; x=1733359887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLiTfyzcVcR229K1ikE+nUNAVjEsCa37tEiZKYXv2lw=;
        b=RAsloZdccB94uJ+7LwP42gq4QBYEo8Xfh3h3RuozzxqyYVud+CLtW8Ne/bbZSWXTVk
         X9smtsjvtzKbKXmhep1qw6lUtTI21Gyf60cy4wlnN9Sci8FamOdBjeI7KCH3a7CHVisS
         IJNSX/TP0vHkZwTgYobe3kQ8dRWxXhlswNRf6IhD0YpOh3j+7N8CiWT7NtKYU4IRHj6S
         qHsw3M6kAAuAiM0Knf+DJEK2/1G+mVVCjXwWrdle8KW8kUD26IyvGl20rOgvA7GLjknz
         AWxzxDVFaUAfzkBTKK8KB7BL2g1g/3I44ZJWXOxx+or3IO3vZ3f+J9Uveyt6C0k5dpHx
         Y+mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhh5EsbKYLgMNeif0QHVuW/kpB2Io3BUUSLAdxXuPeRBC86E0Dwamfqw+hI5R1BEJoTTh0xgNYNlh0DijJDmfd@vger.kernel.org
X-Gm-Message-State: AOJu0YzP4S71LSgk8JIZlQ1ENv3ficPpxDzoagPiiH9cQUzQBX3msGxC
	LMF7vw8uu5hPiDwrDKGbhuS4ap2Cd4cWQiDt1DwZP5VSSze5KHVf4fI7v4PyhcilnMu5qTwDRwx
	wD7m4TTR2SEZwl6w0ZNrDJN46cQG+8BNRdiXa
X-Gm-Gg: ASbGnctV+PxeV98rQ7bvz0Yo8xmmmE7VoKajIszMsF65LIqkc+RGu+OJGqb2hsCPzET
	eCwnyb4Hk7NBLIuo4dIbFdYKp+dBsa05S
X-Google-Smtp-Source: AGHT+IFYYY/jzwMxbpREcw7kv5681JgWs2h1AcFGILJLSJy6Q8v7Vw6m81BiA57DXL5QIpwW2vXmFB1stsbHdmUFXMU=
X-Received: by 2002:a05:6e02:3f88:b0:3a7:a468:69df with SMTP id
 e9e14a558f8ab-3a7ccfc4ae4mr454235ab.3.1732755086493; Wed, 27 Nov 2024
 16:51:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127212655.922196-1-namhyung@kernel.org>
In-Reply-To: <20241127212655.922196-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 27 Nov 2024 16:51:15 -0800
Message-ID: <CAP-5=fXtL-MFW5YW=5WsYNftCAj7MaXVwN8R3veuiODiC85bdg@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Avoid unaligned pointer operations
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 1:26=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The sample data is 64-bit aligned basically but raw data starts with
> 32-bit length field and data follows.  In perf_event__synthesize_sample
> it treats the sample data as a 64-bit array.  And it needs some trick
> to update the raw data properly.
>
> But it seems some compilers are not happy with this and the program dies
> siliently.  I found the sample parsing test failed without any messages
> on affected systems.
>
> Let's update the code to use a 32-bit pointer directly and make sure the
> result is 64-bit aligned again.  No functional changes intended.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/synthetic-events.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index a58444c4aed1f1ea..385383ef6cf1edaf 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -1686,12 +1686,16 @@ int perf_event__synthesize_sample(union perf_even=
t *event, u64 type, u64 read_fo
>         }
>
>         if (type & PERF_SAMPLE_RAW) {
> -               u.val32[0] =3D sample->raw_size;
> -               *array =3D u.val64;
> -               array =3D (void *)array + sizeof(u32);
> +               u32 *array32 =3D (void *)array;
> +
> +               *array32 =3D sample->raw_size;
> +               array32++;
> +
> +               memcpy(array32, sample->raw_data, sample->raw_size);
> +               array =3D (void *)(array32 + (sample->raw_size / sizeof(u=
32)));
>
> -               memcpy(array, sample->raw_data, sample->raw_size);
> -               array =3D (void *)array + sample->raw_size;
> +               /* make sure the array is 64-bit aligned */
> +               BUG_ON(((long)array) / sizeof(u64));
>         }
>
>         if (type & PERF_SAMPLE_BRANCH_STACK) {
> --
> 2.47.0.338.g60cca15819-goog
>
