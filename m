Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62219254B09
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Mar 2025 20:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741208377; cv=none; b=W8YRFHBk2HDxu+q3rrr8rlHUnjKZEr+jzfyLUNGOL/NSoIWfZ9mvdgsp4r/ti31O4mywC8uN0zpJx4O8CP0Gg22WQNJfqDRV1OGuBZgQtu9nfmt3bwTDOJYHY/+kugjbIIlqEETUHQDcJDE/qgLhbLHTXSmCPZJXsScjZeM4WN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741208377; c=relaxed/simple;
	bh=tgTKXDMGOzxdQwmlcJc65hKCfFHWXuEzro4iVWpbNS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cdEJJcqoZvDXkDPx7Z6a8GbZrKpsO1buMK84vB9ujreKzm/6rhUm2XzMdgMq5J5WCW3AIZPPIlmOdf3MiwT7K28Zk7KTu22QEO6j6xZITkLHGo4zHXI2h4O6YEqiSEQbAAF6k3bwWJGk6PcUtmXyxHgmAV1fd8K9wWbsKLdKOt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SSMq33j4; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SSMq33j4"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-223a0da61easo42345ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Mar 2025 12:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741208375; x=1741813175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lmk3fgk+ks0BkJxUvg4zR13swLOXKj1S1MoHmuyaVEg=;
        b=SSMq33j4/OY4yADIL7PKlsFMXXvV8ufyNc1PoNWrqUC92lBaa4UCWfzrh/hI/Br1gN
         HLGzJXVE1oa1QNmoKlevLkjvG8Wy4XzwyflX6+pg85u3ZsF42rLR2R7zWcWlP3+Nicqu
         QH1P0sPOyw5adDdJp1YagN2ILrhRE5pmay01BE7EgX7RNTSxzm9y26YgUyxK8hx1AenY
         ujDD1Pqdkg0jkMpJfcgM9JyNh7bQJ6o8NN3bV1jdpswvPF50NaQw/Hi02ZdwcmHomd7D
         0WvAxP+lbMY2sAIMfywtcCL4JCkNBW/y86uO3SMg0WM7VAU1fUphkVUrAjvixVQq0i0W
         vFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741208375; x=1741813175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lmk3fgk+ks0BkJxUvg4zR13swLOXKj1S1MoHmuyaVEg=;
        b=KVntOh4WUWNt4peGVh5nSZjbJ1i2M5v19ZAt9ehYiPYJpTMDzcYgE3hnf5ADwXuu5v
         SyFVe9HMTcAWBnqfNupiSp9ScDJQXZiE/CLKrcnAAPeSqKxspx4DYfqUDmKEmCTwE+eQ
         A9DhwxhqwLZ5JoLMSz6vjkxeEaocKUBORx7bRnFr8Wm9rL7yHI/KVDU+z9RejnosPYws
         dsFq1t1Qa/5eYgvStorP1VOplxPotB3ZO8IlTkAM2LozrPfYYVGZ48aYRJ00UlAwd0Gq
         OfPCz4cTXw7l/bAtkxrOqxCLk24M7Cr8x/SthdXWDa/I78W7X1u/e0/4ggpWxzy6gv71
         GRYA==
X-Forwarded-Encrypted: i=1; AJvYcCWgcHZ/qoxPM3+VIeOC2+BPzFIHUH+/QtKshZ8fX6ZvfhePMStiayWZD99QJSoIYJcLOrvIE/lgdikBSovFC9mM@vger.kernel.org
X-Gm-Message-State: AOJu0YynHjcs0u/RxT73U/WN3LbLtTMTO8Ofx63Fw2PbE/cllKY3nMaD
	G3lfF6IHldr2EltG/BLtU/gNOuPw32BBhfEJLf+fpyixM1HhEYtkGhxpewN0dnSYLRfTpYtt5EI
	rn6VbBvsMsMjn1VJoUs8hZ+L320rDWnVQIolD
X-Gm-Gg: ASbGncsdNL4Ss//RS0vJczyO54PFJ6NMUEK5uGrslzj11ntEhJ5ksoPyB2zwr5nhOyl
	bPmPlW6t9YG2bd6w2cWeBFqlJtgdwqGA6S/Ai3/oHOJR3BmoVYUsrQlCxOMfRZoTw3Y7rzpSFfa
	VG02yTrNYj+zQrdHtmzsYOEfDGwPYz8Y0D9ZqKH0dTjiXBv+gIeJ6UJjc=
X-Google-Smtp-Source: AGHT+IFPMh7V7wkTSGqT09ajUP53IONkC78fgjIvAk+xmY0EJVTppFrd+Ty3PIkeqidvQQo1VXp1JUegQAhadepVi+M=
X-Received: by 2002:a17:902:fc4b:b0:21f:3e29:9cd4 with SMTP id
 d9443c01a7336-2240ab17e92mr546625ad.20.1741208375376; Wed, 05 Mar 2025
 12:59:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304-james-perf-hybrid-list-v1-0-a363ffac283c@linaro.org> <20250304-james-perf-hybrid-list-v1-1-a363ffac283c@linaro.org>
In-Reply-To: <20250304-james-perf-hybrid-list-v1-1-a363ffac283c@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Mar 2025 12:59:24 -0800
X-Gm-Features: AQ5f1JqwdnzvAXnJSYL30sUkXo-OjQvuQ_s4WXb0fgLX3T-vY88Mc_tVHCEe5rk
Message-ID: <CAP-5=fXAVkp9YnC5X7HUt=jSKqjguHpC7eiThQ+f+xptvvoRVQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf list: Order events by event name before PMU name
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 5:50=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
> In order to be able to show a single line for the same events on
> different PMUs, they need to be grouped by event name. This is because
> deduplication relies on similar items being adjacent in the list.
>
> Even without the following changes this would arguably be better
> grouping because it's easier to find events in a topic alphabetically
> by name, rather than in separate PMU blocks.
>
> Signed-off-by: James Clark <james.clark@linaro.org>

Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/pmus.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index dd7c2ffdab38..4d60bac2d2b9 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -445,15 +445,15 @@ static int cmp_sevent(const void *a, const void *b)
>         if (a_iscpu !=3D b_iscpu)
>                 return a_iscpu ? -1 : 1;
>
> -       /* Order by PMU name. */
> -       if (as->pmu !=3D bs->pmu) {
> -               ret =3D strcmp(as->pmu_name ?: "", bs->pmu_name ?: "");
> -               if (ret)
> -                       return ret;
> -       }
> -
>         /* Order by event name. */
> -       return strcmp(as->name, bs->name);
> +       ret =3D strcmp(as->name, bs->name);
> +       if (ret)
> +               return ret;
> +
> +       /* Order by PMU name. */
> +       if (as->pmu =3D=3D bs->pmu)
> +               return 0;
> +       return strcmp(as->pmu_name ?: "", bs->pmu_name ?: "");
>  }
>
>  static bool pmu_alias_is_duplicate(struct sevent *a, struct sevent *b)
>
> --
> 2.34.1
>
