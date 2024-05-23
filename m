Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5400C6E60F;
	Thu, 23 May 2024 23:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716506738; cv=none; b=ZBpInYkESsdSBRwK2OAzXAnP9WYhHPQY7CwqY+KRO5pz4zrxXhJEVmv9Azunj8YyLYwqnbZc+/51NLGKf4pYtpU/qe+nYrbparcUTdxuIwOcT+M1QuCnaI7DFd5RHiWRSarPX1hHOMZZ3ndYI8BavPni6UE4cw76T2i/3TviwtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716506738; c=relaxed/simple;
	bh=gOnNfwNIpAY9sve0LzmGMLwXNcv9bFm+H02okkOIxBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ICJneWsTmfR4L0r42s7Md5l76lDV9V9WFbeN9CJuZG4aMU8f0MBHWYooI9GN1gcfr9DyssT22rQ+uOxiHiw7ym3KT7SNNFsRRQvGnUWkzvLMAMMYb1shx8Id1ubVKwYJEwBS3ysWF+ucVrJhGy1i5tQfAuEdIYMAMmBnQBp/xxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6818eea9c3aso248464a12.1;
        Thu, 23 May 2024 16:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716506736; x=1717111536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZufZqOOJs1gFCov6+F3hUDTdyFQsOsoFygQ3sgKY+8U=;
        b=fTBZZIuf/oVOnyenODLqAbS3NkF6K1O1gswiQpfToQF7xXTx0l1VG0RL/3BiIpwf+M
         85joFDfy9JBLncf+++o60VSojVOb4aL4qQoST5o5GuA1yo4kqJLP5jYzhFn4Fx3qILfN
         Aq6YOLsp8G5OpnIesooZegs/lSkSBqhBd0w6B62akskFO/ECi4VQUOECmo3cCCVYuRfv
         rzUD7LkZUPaoJKD3Yj5MVtPskaOTuRG29ctusEniMW+QN0/VfD+CU7puOhTmHnDZb01o
         L8TM4iavzU10SRnyddetT5DUWupMmeQCU/XrHNRmoMCihOzLsyHNDb1eQPxeD4YQxP26
         5Rvw==
X-Forwarded-Encrypted: i=1; AJvYcCVd4H546Hd+Nvuo3wn22ybXx0yf1nDHkP69GyYHLr40xQoiu7o6jRA0bQ755cI9EChxpXv1Aj4KiRWG46RTvXgHbT2QeXiEKDT2/aMSt2AfPSXaiOzimyt4dA6flR4p41caDbCZkopYR6xKT7mgrQ==
X-Gm-Message-State: AOJu0YyMmwmuClNvC2425ZgPEp2Zhc8Uz3Ej4dIDPmv/FSQ11J1NIfCX
	iGUinM10A+QRdJa7Rvt6J4XFDX2n2t8r8Sup4FcwEznAu/Nnj/9u3AvwykETh8Ol78UYUP8RABV
	/f/KlhS6RbjUncWFuTmskHmv9fHM=
X-Google-Smtp-Source: AGHT+IFoz08wMHH5wqxHmkeyEYiX76+5nhEO26PM7F3evaFkVmInY9UHuyFcC/KfOdrQQw7vYzKYqNGfQD6am8fXuUw=
X-Received: by 2002:a17:90b:201:b0:2bd:82c9:bd40 with SMTP id
 98e67ed59e1d1-2bf5f408a4amr589586a91.48.1716506736394; Thu, 23 May 2024
 16:25:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240519181716.4088459-1-irogers@google.com>
In-Reply-To: <20240519181716.4088459-1-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 23 May 2024 16:25:25 -0700
Message-ID: <CAM9d7chxsyZ+vnPXj0gc-mbADzwzQYi3qUwUohW-7He5KwMvHg@mail.gmail.com>
Subject: Re: [PATCH v1] tools api io: Move filling the io buffer to its own function
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 19, 2024 at 11:17=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> In general a read fills 4kb so filling the buffer is a 1 in 4096
> operation, move it out of the io__get_char function to avoid some
> checking overhead and to better hint the function is good to inline.
>
> For perf's IO intensive internal (non-rigorous) benchmarks there's a
> near 8% improvement to kallsyms-parsing with a default build.

Oh, is it just from removing the io->eof check?  Otherwise I don't
see any difference.

Thanks,
Namhyung

>
> Before:
> ```
> $ perf bench internals all
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>   Average synthesis took: 146.322 usec (+- 0.305 usec)
>   Average num. events: 61.000 (+- 0.000)
>   Average time per event 2.399 usec
>   Average data synthesis took: 145.056 usec (+- 0.155 usec)
>   Average num. events: 329.000 (+- 0.000)
>   Average time per event 0.441 usec
>
>   Average kallsyms__parse took: 162.313 ms (+- 0.599 ms)
> ...
> Computing performance of sysfs PMU event scan for 100 times
>   Average core PMU scanning took: 53.720 usec (+- 7.823 usec)
>   Average PMU scanning took: 375.145 usec (+- 23.974 usec)
> ```
> After:
> ```
> $ perf bench internals all
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>   Average synthesis took: 127.829 usec (+- 0.079 usec)
>   Average num. events: 61.000 (+- 0.000)
>   Average time per event 2.096 usec
>   Average data synthesis took: 133.652 usec (+- 0.101 usec)
>   Average num. events: 327.000 (+- 0.000)
>   Average time per event 0.409 usec
>
>   Average kallsyms__parse took: 150.415 ms (+- 0.313 ms)
> ...
> Computing performance of sysfs PMU event scan for 100 times
>   Average core PMU scanning took: 47.790 usec (+- 1.178 usec)
>   Average PMU scanning took: 376.945 usec (+- 23.683 usec)
> ```
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/api/io.h | 69 +++++++++++++++++++++++++---------------------
>  1 file changed, 38 insertions(+), 31 deletions(-)
>
> diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
> index 84adf8102018..d3eb04d1bc89 100644
> --- a/tools/lib/api/io.h
> +++ b/tools/lib/api/io.h
> @@ -43,48 +43,55 @@ static inline void io__init(struct io *io, int fd,
>         io->eof =3D false;
>  }
>
> -/* Reads one character from the "io" file with similar semantics to fget=
c. */
> -static inline int io__get_char(struct io *io)
> +/* Read from fd filling the buffer. Called when io->data =3D=3D io->end.=
 */
> +static inline int io__fill_buffer(struct io *io)
>  {
> -       char *ptr =3D io->data;
> +       ssize_t n;
>
>         if (io->eof)
>                 return -1;
>
> -       if (ptr =3D=3D io->end) {
> -               ssize_t n;
> -
> -               if (io->timeout_ms !=3D 0) {
> -                       struct pollfd pfds[] =3D {
> -                               {
> -                                       .fd =3D io->fd,
> -                                       .events =3D POLLIN,
> -                               },
> -                       };
> -
> -                       n =3D poll(pfds, 1, io->timeout_ms);
> -                       if (n =3D=3D 0)
> -                               errno =3D ETIMEDOUT;
> -                       if (n > 0 && !(pfds[0].revents & POLLIN)) {
> -                               errno =3D EIO;
> -                               n =3D -1;
> -                       }
> -                       if (n <=3D 0) {
> -                               io->eof =3D true;
> -                               return -1;
> -                       }
> +       if (io->timeout_ms !=3D 0) {
> +               struct pollfd pfds[] =3D {
> +                       {
> +                               .fd =3D io->fd,
> +                               .events =3D POLLIN,
> +                       },
> +               };
> +
> +               n =3D poll(pfds, 1, io->timeout_ms);
> +               if (n =3D=3D 0)
> +                       errno =3D ETIMEDOUT;
> +               if (n > 0 && !(pfds[0].revents & POLLIN)) {
> +                       errno =3D EIO;
> +                       n =3D -1;
>                 }
> -               n =3D read(io->fd, io->buf, io->buf_len);
> -
>                 if (n <=3D 0) {
>                         io->eof =3D true;
>                         return -1;
>                 }
> -               ptr =3D &io->buf[0];
> -               io->end =3D &io->buf[n];
>         }
> -       io->data =3D ptr + 1;
> -       return *ptr;
> +       n =3D read(io->fd, io->buf, io->buf_len);
> +
> +       if (n <=3D 0) {
> +               io->eof =3D true;
> +               return -1;
> +       }
> +       io->data =3D &io->buf[0];
> +       io->end =3D &io->buf[n];
> +       return 0;
> +}
> +
> +/* Reads one character from the "io" file with similar semantics to fget=
c. */
> +static inline int io__get_char(struct io *io)
> +{
> +       if (io->data =3D=3D io->end) {
> +               int ret =3D io__fill_buffer(io);
> +
> +               if (ret)
> +                       return ret;
> +       }
> +       return *io->data++;
>  }
>
>  /* Read a hexadecimal value with no 0x prefix into the out argument hex.=
 If the
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>
