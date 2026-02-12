Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FD5263F5E
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Feb 2026 18:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770920276; cv=pass; b=o+NJPGHesu+Z7kuuOPnYOUPwzmjWdVw8qthSfTdYFYEf1cH54TNK+HDirFDolWhVdH4PwWbvw4cOYdbYVuQvSpqrQnF9X9lOI4gSzzuEYx3ld5AzrvdCfhkMcDyXpHk4WS/UWF6hqBM+RS7GiY8x3URTVECg3qs0xVzwkQ+7YXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770920276; c=relaxed/simple;
	bh=R7o/cpkDQO7wHK4vBLyOAKkN9uJz6DrV9/7FvH9dkZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SZs5bjD4GplbYWgKQ+J5qnfrbjUSN7mUF8J5d6infag4btyqtXHxESFETjskuj4NjIxxrITSqqcDIgZNe1C/k5Ug5eLBpirNeHT/bnsvLbOlX4Xfpaqybqz+lDI8pCYMktI018/DYW+IJnQQbtEvZfoG6n+fMZFagLX4zAJMZP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PNlY5ARh; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PNlY5ARh"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aad8123335so3765ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Feb 2026 10:17:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770920275; cv=none;
        d=google.com; s=arc-20240605;
        b=jzpkzGlBdAY2xrePEa5ToQayKLIuK2U90pOzxj+Qsl1BYLw9QEHYuf36/Ukjvlsjtu
         PownSm50OCEGLbfQmr6FaIfCobIkaBUibbhLQ/9JEl5xAaAiIqhRpMca31fBMPuJDMq1
         dh8liNCB6Pr+SrRh98tNqMKFB89sQuMbaWV3AYp5DluxN4GDv4vc0DFWUHuvbQCTh6kH
         6D4VPduDHjACH3QcaZYui4wBZrHDxn9lApto7iafH/Oe6eM+SMXcUDmVYqFV3h8xPYlZ
         9o/krzBBmu2wfAGWyR4AIIrQPO/qo87NlUSckGPd6nysUrOUjYfYIHs0AwFeL26IOuaa
         Kzdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kLWeXrRWq1Z8R0G6ScWpddv+wpe/jmdqorkcO6NIr+c=;
        fh=LhXXPdLUM+bpeSKvGJufpVIeq8L/xHSneQSUR+PGldU=;
        b=b2jLfkT4JNIpE3Y9vxlR5GxgQvUp63M21eXyt/X5l8a8XGW2flLLmgg5s+X/n9qjF9
         hA+AxOlG++lRuULaWpXlwDY9Y1duvU4qDZTWPacyJgYgd2wq22FHhrz22IFcWxvC1Wsr
         fGTtriIk29yj+mDBhU+Xgn8jqbpL+iO5b5u4LnvonUvKrcKH1m5mXmbGqu8vpL7MIXVT
         N1v4kvDqRMi8+1WGSt6weYKFkCQBx9dq63FlKDc5wmUF/TDyayXG7EW6KWJbHY5QeEjr
         2S/8GomcYrS8fXtH6yzqszaiaOblsVauQLYtgGh8q9JMrt7RND2vxs/gc1qVZfozbyXf
         6MWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770920275; x=1771525075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLWeXrRWq1Z8R0G6ScWpddv+wpe/jmdqorkcO6NIr+c=;
        b=PNlY5ARhHXLwLuN6rt63oruUo9/JgY/knXcQGrOoDgoHVkLRPwdHHCpXRiE5dsKnio
         1adJc/3rL2XfP2Gd6n2TgpASTw0CQMr047rrE+n4YzpV6uIvHvWgZyxES415AFCUzzv+
         l3K/ruptKqTkX43ZiUIM3WeliTNUvVfYsyeguWUQ6wdL9po/VOTnP1tkjEzMSWn0o/Eb
         59dPx1VeOXC4meYO3f92EwJGaiLNzX+rhKrcLVFXet8y6M2WhIvraVoxeAALiFiKAL7p
         DN+Oq8foXTAUccOzbxpaX+acPb7RjIzL4pIUrzWUuGxbcaXHNgkTJB45whg4X7208R2P
         6cTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770920275; x=1771525075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kLWeXrRWq1Z8R0G6ScWpddv+wpe/jmdqorkcO6NIr+c=;
        b=PcIXIuloAhFbbpR0/UoJW6+1/WWliGHC3xs5dBbHRqukHjfjduSKvWjFO2KOqJpbfg
         K385SqaA/88f8ETQCa9ir4fIc0lSmZKAjf1Agj7r9CEgmBeE835cIafM+3u1lq0gGLEx
         YoE0xK2tkkxFsoBC67mStk+fOprllKdlReJ4viun1VYDgb3SyVLvOhxGj3n5fBUFid99
         gcLAGMwqQLe8MQSTH+yHQc6RVEpCbHr9Lolqa/GZPkJdZO4HEvrBzhiK27+rcEZUdyTU
         M+0A4o7JOZre9fyp/UQT5yenAs1Y1RAfnEI99jVjWFva1Op+S7xyaLJ/WlmFk8ECU6qt
         JOgg==
X-Forwarded-Encrypted: i=1; AJvYcCVK2n0bFdSKNOZPTw7elYzfU9y0+ywEiT0WkBu9Esrh74GtkGCjJ9udrXZSYpDsZ7SFGTzIIyvowjWIvN0gKjOh@vger.kernel.org
X-Gm-Message-State: AOJu0Yz69sRy31eEDk/FsAR3x8gYsIUpnwcxSuKyCTYv062VVPWeLqC6
	s5CCwgIRNgP3N1NyqGOrYf8Sgmz50HdUBE7kelFY0o4dqRU2nhGaIsLhbjgtYL2hy/BH6TaFZxc
	ElbnPBBd1v9fKqSaHLwcpU9JTwBH9T9f/NN4hr/yY
X-Gm-Gg: AZuq6aJnvs3+9y8pNroh3cKrEYQdrjU7WZeDUO+T0KRMZPcSZnQdNgzJER558ayKaLc
	Y1W3rodGWEL+6WU50kfTJq+mMfd6m15wx+aO/j2DJz4uREAH1dFh8FiZ19GpjRILJuhyUsP63M9
	NZVo/YFeMf5bgaw6TEVyTKmyBqS49iscgez9qQbv9gCc0Rf+3CcI2Qjo9PxWbDjOSFx54MbfRnR
	QOWyFX7UJhywRTQdMeEv6M9yUzfvJ4RUY0Vuvhcy/yf0cYVpxXRe8fr+Oto+eNNK2BTy5Udh800
	ictjVgkgIuhn7PzFtr9C4PiWOvLcv8eneiwI
X-Received: by 2002:a17:902:db05:b0:291:6858:ee60 with SMTP id
 d9443c01a7336-2ab4c64ae54mr64455ad.4.1770920274175; Thu, 12 Feb 2026 10:17:54
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212125315.777356-1-tmricht@linux.ibm.com>
In-Reply-To: <20260212125315.777356-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 12 Feb 2026 10:17:43 -0800
X-Gm-Features: AZwV_QhShl-HZziCq5mgH_V2A4kBmbbFEo85Wm1G0WQ_YJnpQquqDRpIFIzq5jo
Message-ID: <CAP-5=fWxHfGZaLyrvzuQF83K1g=LaFC4uRvg3HjM0=W9ts_yxQ@mail.gmail.com>
Subject: Re: [PATCH linux-next] perf parse-events: Fix big-endian 'overwrite'
 by writing correct union member
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	james.clark@linaro.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 4:53=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> The "Read backward ring buffer" test crashes on big-endian (e.g. s390x)
> due to a NULL dereference when the backward mmap path isn't enabled.
>
> Reproducer:
>   # ./perf test -F 'Read backward ring buffer'
>   Segmentation fault (core dumped)
>   # uname -m
>   s390x
>   #
>
> Root cause:
> get_config_terms() stores into evsel_config_term::val.val (u64) while lat=
er
> code reads boolean fields such as evsel_config_term::val.overwrite.
> On big-endian the 1-byte boolean is left-aligned, so writing
> evsel_config_term::val.val =3D 1 is read back as
> evsel_config_term::val.overwrite =3D 0,
> leaving backward mmap disabled and a NULL map being used.
>
> Store values in the union member that matches the term type, e.g.:
>   /* for OVERWRITE */
>   new_term->val.overwrite =3D 1;  /* not new_term->val.val =3D 1 */
> to fix this.
>
> Impact:
> Enables backward mmap on big-endian and prevents the crash.
> No change on little-endian.
>
> Output after:
>  # ./perf test -Fv 44
>  --- start ---
>  Using CPUID IBM,9175,705,ME1,3.8,002f
>  mmap size 1052672B
>  mmap size 8192B
>  ---- end ----
>  44: Read backward ring buffer                         : Ok
>  #
>
> Fixes: 159ca97cd97c ("perf parse-events: Refactor get_config_terms() to r=
emove macros")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Reviewed-by: Jan Polensky <japo@linux.ibm.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/parse-events.c | 49 +++++++++++++++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index d4647ded340f..12fe5392c832 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1250,7 +1250,54 @@ static int get_config_terms(const struct parse_eve=
nts_terms *head_config,
>                         }
>                         new_term->free_str =3D true;
>                 } else {
> -                       new_term->val.val =3D val;
> +                       switch (new_type) {
> +                       case EVSEL__CONFIG_TERM_PERIOD:
> +                               new_term->val.period =3D val;
> +                               break;

Thanks Thomas and sorry big endian got broken! I'm a little confused
here as period is a u64 so I think this one can be a default case.

> +                       case EVSEL__CONFIG_TERM_FREQ:
> +                               new_term->val.freq =3D val;
> +                               break;

Also a u64.

> +                       case EVSEL__CONFIG_TERM_TIME:
> +                               new_term->val.time =3D val;
> +                               break;
> +                       case EVSEL__CONFIG_TERM_STACK_USER:
> +                               new_term->val.stack_user =3D val;
> +                               break;

Also a u64.

> +                       case EVSEL__CONFIG_TERM_INHERIT:
> +                               new_term->val.inherit =3D val;
> +                               break;
> +                       case EVSEL__CONFIG_TERM_OVERWRITE:
> +                               new_term->val.overwrite =3D val;
> +                               break;
> +                       case EVSEL__CONFIG_TERM_MAX_STACK:
> +                               new_term->val.max_stack =3D val;
> +                               break;
> +                       case EVSEL__CONFIG_TERM_MAX_EVENTS:
> +                               new_term->val.max_events =3D val;
> +                               break;
> +                       case EVSEL__CONFIG_TERM_PERCORE:
> +                               new_term->val.percore =3D val;
> +                               break;
> +                       case EVSEL__CONFIG_TERM_AUX_OUTPUT:
> +                               new_term->val.aux_output =3D val;
> +                               break;
> +                       case EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE:
> +                               new_term->val.aux_sample_size =3D val;
> +                               break;
> +                       case EVSEL__CONFIG_TERM_CALLGRAPH:
> +                       case EVSEL__CONFIG_TERM_DRV_CFG:
> +                       case EVSEL__CONFIG_TERM_BRANCH:
> +                       case EVSEL__CONFIG_TERM_AUX_ACTION:
> +                       case EVSEL__CONFIG_TERM_USR_CHG_CONFIG:
> +                       case EVSEL__CONFIG_TERM_USR_CHG_CONFIG1:
> +                       case EVSEL__CONFIG_TERM_USR_CHG_CONFIG2:
> +                       case EVSEL__CONFIG_TERM_USR_CHG_CONFIG3:
> +                       case EVSEL__CONFIG_TERM_USR_CHG_CONFIG4:
> +                       case EVSEL__CONFIG_TERM_RATIO_TO_PREV:

I think these cases are all assigning a str so would using str rather
than val be cleaner?

The change looks good but it is a little inconsistent that the default
copying is done for str values but not for u64. It would kind of be
nice to remove the default copying so that if a new config term is
added the switch will fail to compile due to a missing case statement.
Then we can do the right copy for big endian. Given we've broken
big-endian here we should probably add a comment.

Thanks,
Ian

I> +                       default:
> +                               new_term->val.val =3D val;
> +                               break;
> +                       }
>                 }
>         }
>         return 0;
> --
> 2.53.0
>
