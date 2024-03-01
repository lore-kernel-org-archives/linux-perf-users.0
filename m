Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CE23D3A0
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311131; cv=none; b=DShzem4JR/YU0XJpghQrkJhTdgCflx0lFcq2AWCL+Gt9G4edoxTN2LaNNvBGSLAgz6qn6d3VsJHNuFJ4XGZLt1MNnTuv0w9z8GO+Ck7MslMiTdu3BC2m0lFGE8bOaSAqOlSDIAgKgu7PZM7g/v5T6x+VAcE3egkDAYEwBfTxqVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311131; c=relaxed/simple;
	bh=v3fasrZ049SzsiSU8Wv5RWlUno1kfBoq0xOnRmY2Kzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmfTDvfT8Wr3IALRv2kAi8OotSW4W7TEt3E94G8/4jBdgMS1+pyTlQyWMXZn1vzaoccs1YP4c0bJFw3qLtFH5h8uuHzXhPgWwgsphDNXGmpOsnNtJlSKne8Yh3+EJZVuEuvOofhcDhxnIERJ2AE8gU81Anif74ijOzUXB3HqNQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ToFWaj+y; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ToFWaj+y"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3650be5157fso172225ab.0
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 08:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709311129; x=1709915929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPAqnWxjgworqniOSJ8PsC+uXqBSSqBSNTzJb0e70h4=;
        b=ToFWaj+yy1xHk0HWU7bAiRlZgJjJ7P5W9nrD2mHEo1Z2vSEf4hFZa2od4BFlXjoJsN
         9UqnA0lX4krcJq5282hSHI6pBKgPaS7G/PV+FvycvgRTzI2k6k2TEI9GmRemRMD+sKBo
         Qg5PDM3cnPc/uFuOcHzNxQbA4mtNm6k7Fb1STIJ94hIMQIQr0ESvT/fPwEX6GEIKIZ4w
         5GWUpmQljBtlHIz4Fm6yiKMy2jfGSFVeOfFQdi0SVC7vqo+CWXx10XRygMcDNRR0Ioz3
         UJqnv7ewtZegAvtnJ9GO7P4nr5pPZD8U3lP9rm3U93G7rAx9vwpL5UkqpBZOzx0VqFN5
         wa5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709311129; x=1709915929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPAqnWxjgworqniOSJ8PsC+uXqBSSqBSNTzJb0e70h4=;
        b=snZg5XyXzWlvStS8yO2D7jLnFqfq9IaQ0j/8Uc8x5hqcLTNy6POlngYD8HOKgMVPJx
         U0ai8OfqnlbImLlPmatUyDmVIIw2tcLXkX28bO7+eqYfISCKoxqu1jErUDhfbILrY5ES
         qoaNUa6+aenxUB2jiKL7rH/FBnCmv3JrzWkDKnrJwQBhWoaZi9FD2iO9ffLIfH6+89Zf
         380kQIx7AC+1TPhLJB9FRxwk45M+iQGGuE1iAiXuG7s/VDcJDNsJX5/2X5TKUiAl0+tX
         sW2597Zl36Q6/OYWkptOYnhVODk568i5AAZpF/uM6yhptQz7BVIA5PkUs0LvS+DV0gmJ
         OPlA==
X-Gm-Message-State: AOJu0Ywic8yp5GiPVqXyh31bF65SewdMIyBAwL/5/ofInQ/dIDx7DZ5V
	Sni1lfWoIJ25epRYseZcbNis9grSeaDkIwXZGhfM6s5HO0NkifS9DrJiBtPuhMrtp8oXg+MP4e3
	E5Lv9wWbqWRcXae9Dr3vMplw+juI5T0nYvBUa
X-Google-Smtp-Source: AGHT+IGzUaWRlQBaB12S4PDv8Qi4wWxiH8WVAoDZQqsKYneLkWDQW4ooAJch4Bg6DQQcBZP9232lw/TkfOFRlBunGp8=
X-Received: by 2002:a05:6e02:1aaf:b0:363:c5ec:9fe6 with SMTP id
 l15-20020a056e021aaf00b00363c5ec9fe6mr191804ilv.29.1709311128800; Fri, 01 Mar
 2024 08:38:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301133829.346286-1-james.clark@arm.com>
In-Reply-To: <20240301133829.346286-1-james.clark@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 1 Mar 2024 08:38:37 -0800
Message-ID: <CAP-5=fUWL56Hi716DPa6Q_VXQoGh6Ed1WoNfSHow3+9qzSaMbw@mail.gmail.com>
Subject: Re: [PATCH] perf version: Display availability of OpenCSD support
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, al.grant@arm.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 5:39=E2=80=AFAM James Clark <james.clark@arm.com> wr=
ote:
>
> This is useful for scripts that work with Perf and ETM trace. Rather
> than them trying to parse Perf's error output at runtime to see if it
> was linked or not.
>
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-version.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
> index 1bafe5855ae7..398aa53e9e2e 100644
> --- a/tools/perf/builtin-version.c
> +++ b/tools/perf/builtin-version.c
> @@ -84,6 +84,7 @@ static void library_status(void)
>         STATUS(HAVE_LIBTRACEEVENT, libtraceevent);
>         STATUS(HAVE_BPF_SKEL, bpf_skeletons);
>         STATUS(HAVE_DWARF_UNWIND_SUPPORT, dwarf-unwind-support);
> +       STATUS(HAVE_CSTRACE_SUPPORT, libopencsd);
>  }
>
>  int cmd_version(int argc, const char **argv)
> --
> 2.34.1
>
