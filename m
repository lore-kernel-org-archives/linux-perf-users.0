Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C184914D714
	for <linux-perf-users@vger.kernel.org>; Thu, 16 May 2024 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715875891; cv=none; b=ZH3AU1379fzjwrCSRbdVW208QURoJiKHiTxapwEoXf4iGtb964hH5j1YzhJvz2qbc7kmStCST4x4zkG3PakKaAPWVRWWCfzFr4TWqWPqPQtIdy2dpXYiKPLkjh+Cu3/8yeLM69vp3+u1vMA1fOv0rBTzJLmwQvs1y0XUhO7euCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715875891; c=relaxed/simple;
	bh=KOWrJV7sZB7BW+XiwAgmgvw/gxT5eUyy4zK/OgczSaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIYamk5j9THuvoHfACgp8IzS5HF7ZfB6UHJ9eXNIbLg8SMKQCKuFbRBbH3K8+ycQ13lmFiDOQimi3DjdpEhTL+xzbn9XhJ7vxKSdhRoJAVijIfXGAfUp2jsQ+JJtJShUYEOOXtHW2v0MzJfEb0W+MogZsF3swJotW1XeA5x7I2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I2lsMc+p; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I2lsMc+p"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ee0ccf9c2fso940855ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 16 May 2024 09:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715875889; x=1716480689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qi2qQgRZiJ5JZUb6RUMF3EpGhmXXz9TrZaZuZSjvq3w=;
        b=I2lsMc+pE8QJe9TV6uj4GPvyDFXpNzN9pnpSkZ9UszfeZwN9Fq+5mcswwXOAW+laGo
         wI5VvYIctJNu4sn1otGkvFUnAZGDYd7yKlSEZoo7cGzfGAmNj6MN7yAi2i2ionpp6N7t
         clqJq+b8k4QuD+Ag4dKLTJCDdUW3KpI8ELO6x/gMcRelh46t9TsChHyPIu8llmx2GQ2H
         fwV94dbBDmjwV0Tfku3LG85Iir+lNupCCoGD1yx8LpN2fIwQpqnnLp6zhTVIyo9AJWl3
         us99qkexNhlpEdURu+w+2O+sL8mdz27s5hRSYPGYWkedE89QNb4nzfHG92+QxCxSAqW7
         t/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715875889; x=1716480689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qi2qQgRZiJ5JZUb6RUMF3EpGhmXXz9TrZaZuZSjvq3w=;
        b=YCawVWzjrTvYv1m+2AjnCBc9IcHN0V6WOdAMZCsgLNtlD8hxf2dyE30cVh43PYHuCj
         yz0kM59EUpVZBuZqX75DNVoaUqgnyi42n1irdxuPDPzh+c3F4tI38Sqvqidu2sr/+kfI
         daFQkl/5hLbnXfOpegeGymFU3KsXE45yk0DaYNAoQGBzLMdDYrxl3PJZr/tKtXIzu121
         5LaUUGGKe4UDSutZiZm+g9jT7PIgu9b5RG4LO+PTLCY6bmCKQxuLpZyiLXGPdnYYaY2m
         uk7FgtthVHDVYGSBl2nBtMHliHZX1FXdraEUDEgt6LvbdDIjLwkgRnoSBzgZeo2WEzj5
         lK/g==
X-Forwarded-Encrypted: i=1; AJvYcCVVFyao6P4tFcIRFvHIv2sPUe/0Lbv7BRyvCDLxlo8vHV1SbSSWGE2ZP5CiJliwRXxJOZzifPI0xUqplOswK1rX1zxXWTjiHXESKNW74ApxMQ==
X-Gm-Message-State: AOJu0Yw1FoajVpjO9wyYisD66stvnV3pdXEv4f1UjUUs68sAqDc3Pw7s
	6SLnJCyyw0tJFcFl+yT3O0/6fFdWgQ9JXxajsPA6tYE7z06KWoMp13pKDbd9xIbQCmsI3QcVnKM
	ktke+8xPZucGldndijFv3pZWcnud+C/LdP2mo
X-Google-Smtp-Source: AGHT+IFRyHkQgYr5jjrcF5qYtfSAVdRBMCqzUeIHo06PoydzRvkbrJ4hVzy9D9CNYhYASGKmMWTgj9ELT0rXtXIpsh8=
X-Received: by 2002:a17:902:6808:b0:1e2:73a9:7df6 with SMTP id
 d9443c01a7336-1f060bab7e0mr12034005ad.23.1715875888772; Thu, 16 May 2024
 09:11:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515054443.2824147-1-weilin.wang@intel.com> <20240515054443.2824147-3-weilin.wang@intel.com>
In-Reply-To: <20240515054443.2824147-3-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 16 May 2024 09:11:15 -0700
Message-ID: <CAP-5=fXcdUYY8KBTTq3QNxkBF2K6YjuQGtLSujRoRfehgLLKgA@mail.gmail.com>
Subject: Re: [RFC PATCH v8 2/7] perf data: Allow to use given fd in data->file.fd
To: weilin.wang@intel.com
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 10:44=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> When in PIPE mode, allow to use fd dynamically opened and asigned to
> data->file.fd instead of STDIN_FILENO or STDOUT_FILENO.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/data.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index 08c4bfbd817f..98661ede2a73 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -204,7 +204,12 @@ static bool check_pipe(struct perf_data *data)
>                                 data->file.fd =3D fd;
>                                 data->use_stdio =3D false;
>                         }
> -               } else {
> +
> +               /*
> +                * When is_pipe and data->file.fd is given, use given fd
> +                * instead of STDIN_FILENO or STDOUT_FILENO
> +                */
> +               } else if (data->file.fd <=3D 0) {
>                         data->file.fd =3D fd;
>                 }
>         }
> --
> 2.43.0
>
