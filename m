Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E228460
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742830713; cv=none; b=tdhN20CjOtPI55zxYWhR300aG5Kx0d84f8S+MQBj5iWZzyW/9Xny8uPuQRLNozQfYK8Md8PBOBU2ZstF54jCPdegLK5IzWlfkAoZuKs4XY+2i6NRG6hrigA3MgvQ333EXNoK+kIGjJht5UYKL7YxJD5wvLluHJIAw07zlU9szOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742830713; c=relaxed/simple;
	bh=7tFPKr5B28kVVnB/cruAoC3a2L3PVQkAdc77QpKuC8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EyySWwqzhfvO4Jy6cTFah+/RZ5zG9U3VnmRfB4J82f4ZrI4SRamc6adxOhJCiwJ3YXpSaqkPyCCqkRWSekyIlfS8TqNiiC5GkxquIJd+/aMYeQq4q7NgmkhXOIpNFIUXcgCaj8kEfhs9wBylnEWt8pugPKylM5nSqoCSRT5QBAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PW6GnF/9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PW6GnF/9"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2263428c8baso415335ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 08:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742830711; x=1743435511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COkzJxkZqJhvzNHBGE3D9fP9/TE+wWSTDgVE4d1zPOc=;
        b=PW6GnF/9JHS+fPzLvw8tXKTUATOwRF5vOzd+BUXCA0Sw7b6WNE7RJM/xxv5U0K7y22
         4akE++r0y+kO7FpbrqauoaNLHK/TUkxeiEvjwiyM0Sj0q8plGRJDLcHcimOC91voaZUl
         WGaqj4puHEtr9xCgf4hgWeJaFvUWwM9MfQdQQCMw96engae+fusVvzFmb9t0CZ2PN2uB
         6KkoSgfgjAFeMi0Oe8zQ6nXNoDZ2JCRVNeIL2Ql94DEwDEOHe5+k1rLwdUQLdQePsnSc
         VnOJg/5O105T8+9qTzXpcsGEaPCAChXCaMaIBHy5jj7gfBb+iIZybRmzxs7vZKovzEzw
         tg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742830711; x=1743435511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COkzJxkZqJhvzNHBGE3D9fP9/TE+wWSTDgVE4d1zPOc=;
        b=BUrckEdpzRVpOO4E2AX8sRivRyO8bDU58OWpQdDjWfHVcw6ux7E5Vzjs4/9Smk6ny5
         HM66FmJka07L+nip2Xk7k2PhcGHeAHUJnnGbXv/0FWGrah9QVATRmz1ORz0BsWL9/d1m
         LDRBREVBHvVNwVGGrUz42Hg2aasPnGvCvEj/hPCQiCZ3O5/34jJLLJM9YiuVa+hWf9V5
         bfEEy4dI2dLb/2ca6LBTlxIx772OXRB9K6+wsHSOtBiC6mMz8bBcRY1HvzsAVRUmfQNT
         W3tTtJjHFhqvFC8DsgLAKEKY2xvy5PbjZGSsMk2M+qJur051g9IErkE+iPZB2iEtjRLB
         d4xQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+ml5g7HHqbmGnBszLk5n2RAyi8ZZ/w7tnjGwBCtRLGYrbqeuFVkF2SJyyCVckt7wPV8IUd2wIqa+FsM7Uzy7j@vger.kernel.org
X-Gm-Message-State: AOJu0YykobnVqDIyvwDK070Kh4R7/SdzkQHW0SfFO1k2DjGDYAgywsQI
	n9UQDSgRZI4SqRBLn5voIQ2a755TPxBy3UOBIm9/2WxKO/lVbzMITmcTIVM3xpOW1jLMAm0VTb0
	UaAd8WpU2Y0QO7tKwT4S8GUrxITobXrKL21vG
X-Gm-Gg: ASbGncs4j/te+8/pHozosWEJHkztX+f3XJzpaNGly7iaILUZmYGFMHw2M2VHVmvbsmF
	Nynto7Zg+JGGsRinTvbaaldWwE+Lxzqe7naCWFmbgSD+4z1f0swdhmtM72dodVqrxLtUZUaXVdF
	E3Ve0ELkJhrR8YYE042CnQl8I7tAZZ1vkNscdvfaFXAyC8PqMuh03N7Lk=
X-Google-Smtp-Source: AGHT+IGC6OhQhLhblQDXlW7T4oZnxNtKmyg52BRRYG7Eecnu7rJEDTmRZl6hO4pMB5TJ2eza8MtiCvnCoiAvt74Vtu0=
X-Received: by 2002:a17:902:d50b:b0:223:7f8f:439b with SMTP id
 d9443c01a7336-22799f85804mr3222075ad.29.1742830710575; Mon, 24 Mar 2025
 08:38:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324152756.3879571-1-tmricht@linux.ibm.com>
In-Reply-To: <20250324152756.3879571-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 24 Mar 2025 08:38:19 -0700
X-Gm-Features: AQ5f1JoRuG3A3vNzieof0Dx0hE6xP7IbfvSZ9Sgmli56VVBGPS-QMQOikuNcZEc
Message-ID: <CAP-5=fXPgoocDSRxzYpkzcLsPwKsp9b80b1KPDWv-obkmiX-fA@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Fix wrong size to bpf_map__update_elem call
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	james.clark@linaro.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 8:28=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> In linux-next
> commit c760174401f6 ("perf cpumap: Reduce cpu size from int to int16_t")
> causes the perf tests 100 126 to fail on s390:
>
> Output before:
>  # ./perf test 100
>  100: perf trace BTF general tests         : FAILED!
>  #
>
> The root cause is the change from int to int16_t for the
> cpu maps. The size of the CPU key value pair changes from
> four bytes to two bytes. However a two byte key size is
> not supported for bpf_map__update_elem().

Nice catch!

> Note: validate_map_op() in libbpf.c emits warning
>  libbpf: map '__augmented_syscalls__': \
>          unexpected key size 2 provided, expected 4
> when key size is set to int16_t.

Wow, weird.

> Therefore change to variable size back to 4 bytes for
> invocation of bpf_map__update_elem().
>
> Output after:
>  # ./perf test 100
>  100: perf trace BTF general tests         : Ok
>  #
>
> Fixes: c760174401f6 ("perf cpumap: Reduce cpu size from int to int16_t")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/builtin-trace.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 092c5f6404ba..464c97a11852 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4375,10 +4375,12 @@ static int trace__run(struct trace *trace, int ar=
gc, const char **argv)
>                  * CPU the bpf-output event's file descriptor.
>                  */
>                 perf_cpu_map__for_each_cpu(cpu, i, trace->syscalls.events=
.bpf_output->core.cpus) {
> +                       int mycpu =3D cpu.cpu;
> +
>                         bpf_map__update_elem(trace->skel->maps.__augmente=
d_syscalls__,
> -                                       &cpu.cpu, sizeof(int),
> +                                       &mycpu, sizeof(int),

nit: It is usually preferred to do "sizeof(mycpu)" to avoid the
problems like the one this fix is fixing. And I'm blamed for the bad
code in:
5e6da6be3082 perf trace: Migrate BPF augmentation to use a skeleton

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks for the fixes!
Ian

>                                         xyarray__entry(trace->syscalls.ev=
ents.bpf_output->core.fd,
> -                                                      cpu.cpu, 0),
> +                                                      mycpu, 0),
>                                         sizeof(__u32), BPF_ANY);
>                 }
>         }
> --
> 2.48.1
>
