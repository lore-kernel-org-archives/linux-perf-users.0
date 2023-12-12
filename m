Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WuDYgIxE"
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E19AB
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Dec 2023 10:08:12 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c32bea30dso4185e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Dec 2023 10:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702404491; x=1703009291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhYdf+8cQfQ3MBTe94vw2YkuW7rtXoDUvtiEUFEToaQ=;
        b=WuDYgIxEwZyV86F+YyWEX3X8tT0gogswv5nuOtTCuS+TCMheELgY9+CrcDV2A++ptJ
         XhFBSApt1S1BPbvn872zL1+PXMPwyFpgrw/7sWt9uB37qdK+tI1g1f2IKbOisvogtzXV
         4hG3yLHHvHMNbqRAOrGdkAYY8EwrHKxpUHG59Ka+XB6XT9Gx6kLQ8n1WcQL2SJ6S9nmP
         JhDAaS379pfjHMlRjti8wdUYlE/hoIITOlidzrUJp4hqWzTSnjtERAdZy6t++BHV98dm
         dU0slBlQgl6L8MTlpXwF2iD/u/17wfRGgB8/nkp/+hVNfMGyKsBMvrkaDBYnj1JvFVqa
         2AMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702404491; x=1703009291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VhYdf+8cQfQ3MBTe94vw2YkuW7rtXoDUvtiEUFEToaQ=;
        b=AG8pZJ9l7Kl4lsyhdO5hItbX1oCx0mh0tjdKdN2OKRfpoZDABKY0BaN3wbPvda6Zrn
         kDqpnw6X0CPFkJtBD32Us1AXR+2FRAB99DMNt3+RE9RSy089Kwd4Ko8Av/TmbAmaXDYX
         aF7EBKLRt3fDkwTFYo8B5Q7we7SQVYVLSS4JUCr+HL4IdFLMqQi3yG0rLkqFslZc2dTL
         Q9//V84vFY0fO2zesiPA/7WGKBVpuBwdySXAE9yGDAvxHO//w7UPpsrFM6y+/WzTZoPo
         0Fi3qTX0gThoFzNYROwvYo1haB1Kq1+NdvjG0GbTdT1gh3tZbtkW+K7ZaFPoZm+BU0+k
         FhDw==
X-Gm-Message-State: AOJu0Yz1hA8buaShioUJM9WjZDYKhTehvLFJdrsN8yhj9Mn8+2KxA59u
	LEHfAgcmb5E1yqzeXULLtCT4Xib1GlTrurrbBqsebw==
X-Google-Smtp-Source: AGHT+IEY9JpTUZMLV0vKfFqIa+W0hU/BLMoseO7ZQoy1ydLtjF1Ozffn/lu+j4tpuI19zVLxcHQ6IJKe8IEo2dyMPyE=
X-Received: by 2002:a05:600c:3648:b0:3f7:3e85:36a with SMTP id
 y8-20020a05600c364800b003f73e85036amr324700wmq.7.1702404490911; Tue, 12 Dec
 2023 10:08:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212070547.612536-1-namhyung@kernel.org> <20231212070547.612536-2-namhyung@kernel.org>
In-Reply-To: <20231212070547.612536-2-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 12 Dec 2023 10:07:59 -0800
Message-ID: <CAP-5=fUsVd-ZAL0yBeKpQ5RvQVWs+ujXZj679sYQAwPLmzrCXQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf genelf: Set ELF program header addresses properly
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, 
	Pablo Galindo <pablogsal@gmail.com>, Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 11:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> The text section starts after the ELF headers so PHDR.p_vaddr and
> others should have the correct addresses.
>
> Fixes: babd04386b1d ("perf jit: Include program header in ELF files")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/genelf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
> index fefc72066c4e..ac17a3cb59dc 100644
> --- a/tools/perf/util/genelf.c
> +++ b/tools/perf/util/genelf.c
> @@ -293,9 +293,9 @@ jit_write_elf(int fd, uint64_t load_addr, const char =
*sym,
>          */
>         phdr =3D elf_newphdr(e, 1);
>         phdr[0].p_type =3D PT_LOAD;
> -       phdr[0].p_offset =3D 0;
> -       phdr[0].p_vaddr =3D 0;
> -       phdr[0].p_paddr =3D 0;
> +       phdr[0].p_offset =3D GEN_ELF_TEXT_OFFSET;
> +       phdr[0].p_vaddr =3D GEN_ELF_TEXT_OFFSET;
> +       phdr[0].p_paddr =3D GEN_ELF_TEXT_OFFSET;
>         phdr[0].p_filesz =3D csize;
>         phdr[0].p_memsz =3D csize;
>         phdr[0].p_flags =3D PF_X | PF_R;
> --
> 2.43.0.472.g3155946c3a-goog
>
