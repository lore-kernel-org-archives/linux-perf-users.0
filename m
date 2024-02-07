Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEF615E86
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Feb 2024 04:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707279226; cv=none; b=YZ9gk7hEdoyFSkQlb7OmFfc3dcXZPRkBebcq9iYyV8TvkihKk8/ah21uDMTWWS5nPp3xQk00fgAwz2k0MUXWE5QMi4ZOClB6neEMIox4nM7V1tBV3jz7Zz7EeoSkBFUkVP8Ye3kxbqgJlD+60s3xW4yqg6QRgdX41X6ZqWHOnAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707279226; c=relaxed/simple;
	bh=DawtPmRgk6yjmGv8Et+8qRTVs6tdkKeMMQQpJIvE9NA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K89/dAxACiL+sbzq91rQl11NNzm6FCEVjNtBb5GPK+u1JiNipDi8NxTm4sZnlfM2U/P4KRB1WYLjcto3TQNt3KWs3rMUixqm3Jt1nHediagBOpnLDvpjSsmaqvwZ9FPpW0mfXc981Kp2Iw4yCuiXiTyJub70JhqIlg6iC13wiBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jozsAp0A; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jozsAp0A"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d9daf74f41so2795ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Feb 2024 20:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707279224; x=1707884024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHLcblWjU6UgGzJLYm+rTZl/ZAIvc9e3m6tFVYB02E0=;
        b=jozsAp0AWY8j5F1ybvtQxukfY9/t4sJ9lUUHfnJUdl3rOaAN+oqPWVw36SWVM2ZADe
         U+AyTUvuVMhKckhCwXrh23kh/cgOFhQbUNCb0hlwtrEZYxdo63QwRz7hZ5RmS3oj8DSd
         prc10qxhgXndxVBSsqFpZm/yX/ES8r6zccTHPeWcS41xWcRCzsaHngW6S8fVHVD9zLub
         OEyxDothn54rg84r+f3Ucs1HL5vZtOuza7yYHW1kRGAbvLOeqj4mkGtoRfGDgFnEfkuC
         5DVLIkw8AdGimCZtX1Irq0J49EfMxsE1Am5F0Hn5PjYMYLAYSnShq+rYTTx4jeXgxeMM
         U19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707279224; x=1707884024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHLcblWjU6UgGzJLYm+rTZl/ZAIvc9e3m6tFVYB02E0=;
        b=fG50obymKJ+WKWAK7eqtjvQS0oO68MRAtfVQhzK15/KF4Ps1WwYV5rzqiVCUJT+Z67
         UzQrxAxQ6H4pHHOgdvvMGRIl5IM/x3SNyE17ijWVTQSY27hJdv2idG/V+fVAbsYYR3f6
         qMBvcVoMEbjZJV5eyscttn1nf+ZcKoJTmeWD+Qd+tyTzPM5ZZ/APD0gX0RnkaqE47RvV
         4Ehc8RH1KdvSpObwm1lZz6GShU3aCJ4TpCjA0EodtoPv1VaoAGh/rC3FyZC3axOyfr3O
         jbAA0ve8TdGmi+4W93XN7JcPWlmyEsyt95/VW5OqJf68V6BTlajhIkZF93m/U9Z2uMWE
         fP1A==
X-Forwarded-Encrypted: i=1; AJvYcCX0Z2ed1vY2kjqr6YJUVGPuFqL/KqOSvRaogGM1kKT5+DMSTeXNvKFkRSqOJNY+1dSBTU4Sji9WKi3OBqJ+Z+XS2VSwhjxpHXBGskkZFDlbow==
X-Gm-Message-State: AOJu0YxT/mmbudKjZqXMNxUrQMFiVLQsBBMtFfz86uar6WtPBydT5eDb
	sHqEPSbR9d2NXNPpyiBRyQ3Mtwvm08DWIATSndp/laP5RetOOV18YEh31KB97dmYeEy+xmkrC6o
	5Gr1XbAyiHa0w4JDSFwIVdPordmzedFBBgmE6
X-Google-Smtp-Source: AGHT+IEhuDRvsjd7RWO6TeE99G2pJfH9ARn3kF+Guau3neKYQ+hKEQp/WdB5SfAQ+RqGulk9oUXQ5+4qHEZn0MLQbwc=
X-Received: by 2002:a17:902:ec8a:b0:1d8:d90d:c9ae with SMTP id
 x10-20020a170902ec8a00b001d8d90dc9aemr15347plg.1.1707279224349; Tue, 06 Feb
 2024 20:13:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112231340.779469-1-namhyung@kernel.org>
In-Reply-To: <20240112231340.779469-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 6 Feb 2024 20:13:32 -0800
Message-ID: <CAP-5=fWCQqzPMV=3+o5W6fWx2vy2h0gMicU+ysnTqCy6iiLbaA@mail.gmail.com>
Subject: Re: [PATCH] perf record: Display data size on pipe mode
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 3:13=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Currently pipe mode doesn't set the file size and it results in a
> misleading message of 0 data size at the end.  Although it might miss
> some accounting for pipe header or more, just displaying the data size
> would reduce the possible confusion.
>
> Before:
>   $ perf record -o- perf test -w noploop | perf report -i- -q --percent-l=
imit=3D1
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.000 MB - ]    <=3D=3D=3D=3D=3D=3D  =
(here)
>       99.58%  perf     perf                  [.] noploop
>
> After:
>   $ perf record -o- perf test -w noploop | perf report -i- -q --percent-l=
imit=3D1
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.229 MB - ]
>       99.46%  perf     perf                  [.] noploop
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-record.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 91e6828c38cc..21ebcb04f1d8 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1773,8 +1773,11 @@ record__finish_output(struct record *rec)
>         struct perf_data *data =3D &rec->data;
>         int fd =3D perf_data__fd(data);
>
> -       if (data->is_pipe)
> +       if (data->is_pipe) {
> +               /* Just to display approx. size */
> +               data->file.size =3D rec->bytes_written;
>                 return;
> +       }
>
>         rec->session->header.data_size +=3D rec->bytes_written;
>         data->file.size =3D lseek(perf_data__fd(data), 0, SEEK_CUR);
> --
> 2.43.0.275.g3460e3d667-goog
>
