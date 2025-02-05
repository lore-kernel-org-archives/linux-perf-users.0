Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F44C2EF
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Feb 2025 05:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738731628; cv=none; b=MmsUUpmXxX6U3q/fgH+zpFK3ew4psW8dl2KgkCDAJ7O1hVbI1HN5afffFsh5PVoqih8gVY/LBdPhz5LCkWdlvrxiM5hPVCBYDNEOyrnjZFh4XzjTWZnUzBz3YT8CD3rK4PA/2oRPRYRpEzcrL0a9BtOD8IybWp48KNSWTZeHOHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738731628; c=relaxed/simple;
	bh=XoHgY57qdbAKv8uWUYNfx7XWO/S0+Vz8NkbzUcrg87Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENaBprP7HeEVhQiRGk9LDaYEIZSfuCn5tca3u6J735T843oTDjuz6ntTG2hsCUGTrhOiDsVQnVrshO8xi+5S1j4E6yo41FtiSrWsr0qqYxIe6OC1INwDyFbTXhkRpTjweOd7ofXvuAOLuzd9hYyptf432J+N92BruBbTtz9yv+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eoixNFmE; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eoixNFmE"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so212565ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Feb 2025 21:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738731625; x=1739336425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBrAJ33Lv27IH622MIOkF0t5tIX46ic8QrDeWtn4wec=;
        b=eoixNFmEX68JlxnaYLurIKdqSWOhSiGJFSzu2jmHgNx4kp9zODr2UWmTF5WgWROV+Q
         uwFpL7fpkiQRKWB+fexlIztGvecToTC4VckpUkN6yphGA7BiCZboWGN9fr5Zg1DrsPqD
         VBS1ip6QSbd4dSi+Yf8+2Dah9KFyGqKJHbqj8V0BZLtIbLQCIdcvxmzeq55QhU+4LqRV
         Nfrc6yrxVZq/l6AJ/bVD6SJoX4pOcoKmt8FBHGjZ3ZYtC+G6bS1iLmWu4jIDVhwK89vN
         5RDcVvsD1CdsPHB7XxfG1lJ32bZxpRkufBKTd2+eVT94S8VeZgXDv93+ow6Wu6yI1QmE
         Lz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738731625; x=1739336425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBrAJ33Lv27IH622MIOkF0t5tIX46ic8QrDeWtn4wec=;
        b=omenoYrhityGQUJEC/Fscru6WWEAtlHtFe5ZXXs3sNDKhQHmXcVyU4oPdvDjpEWzHC
         swpWcEnKZXCrFjOzysg5vTW4INHPr0XqK2V0KuybJw7f/kEFxSpnJv7UnUlJLsMXxkm2
         HV7SwBCzh63SSr5es+JzA7F66uxgTN/0zSlakytXDvsnRGwyhEDvwLNvG3HB7wpr2q3T
         j4DwhTOM/3O0YWzF81Mg1Phij75hBN0QjNKgK5GUqfMuqE0FKMaXcI8c69zkllCojms+
         H/la4222fm6nZPuWHsVnNiG+jIkW+GGwNBe9s9yFuQc8PgU6jFrQtWg1sjPlMJDaVqKp
         H14Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOAePbBcf63sv2VanMlwvRoZTI5FbC9lLp/4wW3B8N0F50jdio7GAustSRVPA7EkFXKjdfpyiBgpk5Gz8oZpqZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwpFwM7iDcklcU8fLyniP31lKhj/faEvaz/qqmqvfUlz3/1e23l
	PTawtwOzAq/PRGzmX5SjzbwSa4oTF9Qk1cU1FKpwHbbyAshea3RPMQyZeguP+fvNC0EoZ3r4I7i
	L3+PnMTnXXpxQQykMI+YQQIaEKM998w2cud7R
X-Gm-Gg: ASbGnctlSmTxFZ+JFC0xqBiUin1hrS8LIbHwRsYdq8UQC4YrAcrrj5lCBInNzWQQ2iu
	57vtoDqkoQV884lICeLhCPORT/aFLULi5uZKaDWW0kLj0oHDgUe7klPqTp6pEbQuBM9o8EPe3WQ
	==
X-Google-Smtp-Source: AGHT+IE5v6UIxUtbhZWXvQ6xeQiRfsd1Lh1y3K7nKT+DdV2MV+Ch6CX6fJX9kXWxtmkarMn0roBxr/1rIM2Ik8IIu/M=
X-Received: by 2002:a05:6e02:1f0f:b0:3cf:c98a:ceba with SMTP id
 e9e14a558f8ab-3d03fc6611dmr7494995ab.22.1738731625326; Tue, 04 Feb 2025
 21:00:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201071455.718247-1-irogers@google.com> <20250201071455.718247-3-irogers@google.com>
 <CAH0uvogeG9rUw+1huquE=8fEq8AdJaSygS94G8a05=cHckjndg@mail.gmail.com>
In-Reply-To: <CAH0uvogeG9rUw+1huquE=8fEq8AdJaSygS94G8a05=cHckjndg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Feb 2025 21:00:14 -0800
X-Gm-Features: AWEUYZlxJYAftveNvjFByQ6RA0wq7gWZe-nwQuI2bmCaSivCz6TrVnDN2aRhlBs
Message-ID: <CAP-5=fX1bePwr5QGZQAMxWv1zvBY3dxOhbMd0H5UYQDXMrSKMQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/7] perf trace: Reorganize syscalls
To: Howard Chu <howardchu95@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Bibo Mao <maobibo@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 4:12=E2=80=AFPM Howard Chu <howardchu95@gmail.com> w=
rote:
>
> Hello Ian,
>
> Thanks for doing this.
>
> On Fri, Jan 31, 2025 at 11:15=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
[snip]
> > @@ -2104,11 +2123,12 @@ static int trace__read_syscall_info(struct trac=
e *trace, int id)
> >          */
> >         if (IS_ERR(sc->tp_format)) {
> >                 sc->nonexistent =3D true;
> > -               return PTR_ERR(sc->tp_format);
> > +               err =3D PTR_ERR(sc->tp_format);
> > +               sc->tp_format =3D NULL;
> > +               return err;
> >         }
> >
> > -       if (syscall__alloc_arg_fmts(sc, IS_ERR(sc->tp_format) ?
> > -                                       RAW_SYSCALL_ARGS_NUM : sc->tp_f=
ormat->format.nr_fields))
> > +       if (syscall__alloc_arg_fmts(sc, sc->tp_format->format.nr_fields=
))
>
> Makes sense because IS_ERR(sc->tp_format) is checked a few lines
> above. However, nr_fields can be 7 with the __syscall_nr prefix. I
> sent a patch to fix this, but it's not included here... Never mind,
> it's off-topic. This patch looks good.

:-) So is this a reviewed-by? What about the other patches?

Thanks,
Ian
