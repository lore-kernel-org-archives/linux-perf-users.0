Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4172F549E
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Sep 2025 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123079; cv=none; b=i4Z1SklOarzppujYdXk6a9i0oVSACJH+iSu7/rfKuAdAZIgxhU2Icc67ijvdLsRj54sCaIkGwrxQSv+oVuDCLeQsB8yVQXdLYDkrVRn+UY37C5OZlo7R2gGEr+YYTeSlo3JROBkbP/d/+NpwgWsWgAj/1smMhMweCwkcaqJAsG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123079; c=relaxed/simple;
	bh=Q9p0ElTEfDeyRmJGVtQS7BZacADA6lcsIfSZqPI8CPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=knKFeSOxUfo1ewz2Ea1JBZF8799uIpUq+9UyHzaMbwv8eDfoVihaR6gltEfYdUAWIBlc9n0S17Qj+ldSkg9Iqi+tdz8hh1Cnxw87F3PmeSr7ybyeSe2P6RDh+aQfEbKntQuNVKX4GkrmcYYdZ9DqFrirmhb+yUL46S/7p3KgJvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3yQ6njjb; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3yQ6njjb"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-267c90c426dso217445ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Sep 2025 08:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758123076; x=1758727876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yP2yi9kYnKCwIrv9Gb5KpJODKy5MEoQhUbHkafFHfNQ=;
        b=3yQ6njjbt9I5qm7wFeO1gZNhSoEzMLJPUQjOcdIvmwVYTX3TdzZxtwsXNn6Do61E/B
         w+GINPspSdv5n2RmuQVSY1P7Gmu829FOiD/BYf95tV+tsXVo6Z5HZkjiDUKkcCYZd3DJ
         6JzEbVq/dY1ocspgHR1j+ibqQAAbKX88K7Vn3Is6854xDw/oE2UFfcfCLUhQB8+0vkH7
         iQcXjz4yh5eZWrWRRevXh5UxMU7ya+47RPjr33ILAwjF9qhx2CUOC/7wqBHeQCLibyNq
         BjelaGr+l7KbLE7YuUVwe2NGSSvCM6DyzSJyKVh/loJVr47wAqI4pkNeNAR/YVqC5Bdo
         t1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758123076; x=1758727876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yP2yi9kYnKCwIrv9Gb5KpJODKy5MEoQhUbHkafFHfNQ=;
        b=p5UIxMGgCYjTfpEtDJcCQ/qC77W3qowsMo8T1BtXkLMG7akaMlIczA2/hjGjelfA8o
         srhNkWXVsQI+xWdHSLo46TXExjejCQelTlzdtFL8bkm+VTJEL9/Os6k0EqKqiZNhMT9k
         /GYEaovJLA6KiJa/EVElUXVi6H1izPv7DZBAc1UtqPDVyQ2IxaQ67BSXCUk+wDPPDt5x
         cytyjJsq8bibUiR+e5GJDDipGXzK4Vz1LKlugucCISPXXJ6TRaNvMINdkCBkDmjn3WRT
         LotLNoLYprGUoxe5+vozq7Gxav1H05iAWIiXwImCTHcWmO0dRGyYnzaYxiSjiC8Rb0T2
         Bsvg==
X-Forwarded-Encrypted: i=1; AJvYcCUW6s5O/wBbja6Mo7ACvM1Rn0ArPr48cYUbML2dqLr8hmWEl9NIJz5ZNBjwX1/HRTFvt6urMFocAFKaPQXCgDsS@vger.kernel.org
X-Gm-Message-State: AOJu0YxXleLDZ5zUf9OEQ31WX2LMOCMe5azCONOOZ5VMbRw0oW7nzzmr
	SSgtvddtqcXPueadYJXzWdyV6hSHk37dhmpybeIkF+w/ptORB83teUq1A9/Rlhj5ziwcGi2bU4F
	Hwd8Xq5IggtXrURDxvRokh5h4IJwEWsKrfDb3y9RT
X-Gm-Gg: ASbGncsQEWshx5XcHMcIZcYEBOnc9yCKjVQmQrBDKkU0YUganH7Xx0UwZfLvzj90rCe
	5nH5mzaGVrXZKxoHVQaAxoXX2XkinwDCTbVRSCuB7qO5EyXjtC55+XIjI0i0a4P43lJKAJ2wKZE
	oM1T9rVUabKt0EH3IbF43sxGoPD0JS+QtIFDAWjTDecYzmmGsRpt2el5deErIhbMUYewY9CF9xu
	wsb5MVzl05yt9oK8UqfHzzWxqcpYNZboKvpsvApl8s=
X-Google-Smtp-Source: AGHT+IEIYsSgoPFw8n0D5GyMXO8O7j8k2ouTC76R97gvN6WMwuWsPXFAVjR0Mb9sTGuoiknuifAK5c5GGSIVmLuC2HU=
X-Received: by 2002:a17:902:d4c2:b0:248:a039:b6e3 with SMTP id
 d9443c01a7336-26800f661e8mr5881855ad.10.1758123075306; Wed, 17 Sep 2025
 08:31:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917095422.60923-1-wangfushuai@baidu.com>
In-Reply-To: <20250917095422.60923-1-wangfushuai@baidu.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 17 Sep 2025 08:31:02 -0700
X-Gm-Features: AS18NWBn1xIsmr49KgjsNQAQO0Eb9GKnYzHA-cdT8fTubed47WT7fWABg6bGxJk
Message-ID: <CAP-5=fUvvcfPOEyoTGFD9oahxzKGMZXPZ1YikLqzwE3hw7B=bg@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Fix IS_ERR() vs NULL check bug
To: Fushuai Wang <wangfushuai@baidu.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 2:54=E2=80=AFAM Fushuai Wang <wangfushuai@baidu.com=
> wrote:
>
> The alloc_syscall_stats() function always returns an error pointer
> (ERR_PTR) on failure. So replace NULL check with IS_ERR() check
> after calling alloc_syscall_stats() function.
>
> Fixes: fc00897c8a3f ("perf trace: Add --summary-mode option")
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-trace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index fe737b3ac6e6..25c41b89f8ab 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4440,7 +4440,7 @@ static int trace__run(struct trace *trace, int argc=
, const char **argv)
>
>         if (trace->summary_mode =3D=3D SUMMARY__BY_TOTAL && !trace->summa=
ry_bpf) {
>                 trace->syscall_stats =3D alloc_syscall_stats();
> -               if (trace->syscall_stats =3D=3D NULL)
> +               if (IS_ERR(trace->syscall_stats))
>                         goto out_delete_evlist;
>         }
>
> @@ -4748,7 +4748,7 @@ static int trace__replay(struct trace *trace)
>
>         if (trace->summary_mode =3D=3D SUMMARY__BY_TOTAL) {
>                 trace->syscall_stats =3D alloc_syscall_stats();
> -               if (trace->syscall_stats =3D=3D NULL)
> +               if (IS_ERR(trace->syscall_stats))
>                         goto out;
>         }
>
> --
> 2.36.1
>
