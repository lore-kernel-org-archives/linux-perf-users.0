Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E237343D86
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781112305; cv=pass; b=WXD3vmhAtMxwa/Ry9yeLUKWjxftv/AZDZy1hX1Uci184Pu/vgktUnOK5t63grF1nb/G/uM3Oi/qONbZIxkisGLdVlYcvxtxUCcynzS1PscSjgXH7tM1aqpnSkX+nURvwU4mpk+cVeJ+lhuGZWMaxYebnrP8kmJhOMfOu3z+jvRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781112305; c=relaxed/simple;
	bh=pcXPxtxT4XNb/kCmW1gqRNh2oKr5WUNI3FcJqfvT5VM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0bQLQPvg424+6De6GDYlp/l1I3z4J/S1bkt9KJXBTIiDloJleprm1Hta5AsAzjNUnauiTJzz2mrMGGgnRuu2xcJAevPmfqEKcC2qbrJAWVEAmxIul/PAzL6SGPsdUKs8lCuyTFtAYigRkzKQXXCcTbGOMCaZfGpUoiTWTgjrlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b/UUjZpq; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b/UUjZpq"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0b1a48855so8625ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 10:25:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781112304; cv=none;
        d=google.com; s=arc-20240605;
        b=PXPuW+TAOp8DBpUfNSvLzDk+INKs9R6rnMS1Os4+/1RLJydZ+fhc80+S0IxBVIHoLa
         ily7s9uGy9W6qx8N+A68dvjcIRofuWvD1LJ2mbIgdFR8/2wMa7Dye5iKbBYhzHqKseAd
         rl1UzQszuW/RaVJPqNQuAQg2rSMMJqpXt3XVI4ZkAWdc7UNNj6DhWyhXZ14+GKrDsmju
         4GjmKYdtxs/3QfOJ+rOJaxACXCVH4lJJ7xJPVDX0u4+v6tlAT1j+hqPbLO6cRu1+3Dtw
         8yBRETam0O+GyHAiJcPWQIkrpeB0d2CrUK9OwpT1Pj8LvDkEQKre5f5cc2V/3Bs23ldW
         w8Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KUZ5KuNsTFrORb+3cfGVVnx4AD+5WgaR3uIFTCKj+d4=;
        fh=AM8vwiOBFkjIlJQGCo5EJijipBGdIguYedVvXl+Ufp4=;
        b=KTP3EsBa8a6kmjL7mdr/YLEXNCyE8sjnMSvIo1uraqjbPERi+jZos8buyhBgge/N1K
         Kuj2PzGynlVwbXzBU1keMaZJRmSLMfl6OWI/cwRincfq3cBo8fOxyNYMn3KbtFvA3S8S
         cV6E2pZ8uJ4wzUo3rPPUafhNx3VDMIIPYndgtIfcmItK+lf3DyZTXAw9vNRqgUqycFHn
         ++zM3plJ1uK4jRQHdWYVleOY4nyTOfEj+4tefWumwh61RBT2arna0pGnTdz9QYP02faU
         fS7f7PaCHvYBsbhZhZ7UBo/vR7v3c6h24Z4AHrtQ4EdfKcqu4ec9QT2L7sm9TviZZHLz
         t0Yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781112304; x=1781717104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUZ5KuNsTFrORb+3cfGVVnx4AD+5WgaR3uIFTCKj+d4=;
        b=b/UUjZpqE4XmNJ7cYmLUViYM2aa8n3erF5y+L5r0VujZ4OvkB2dNGxc8JvdKpw/Qm1
         yYrSI3LbjFO2SmCCkkBAi0kSnswHcVRHe4WrnZeB2U8ExosL43YlhL7qm1u5CN+oZUM4
         OdhIlc6df24XEJvWisAUBt+H2SVN+CRS70AzKsBwyb70Bkwc7sQjJKTt4iBGyLhUpqRG
         Tg3jqgeVgLrqc0bvdYlZaDV211v99+/IgXCjFJcikNQVIf85Jpzurh+2tfw2zAkyrjIw
         7l4JD1tSKCRazOa3oD/YH4urt9Nn2T6zOnf/xbsAQsP2V/kj8kpPkQvOwnIYCxaZwg4p
         gxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781112304; x=1781717104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KUZ5KuNsTFrORb+3cfGVVnx4AD+5WgaR3uIFTCKj+d4=;
        b=Aiw9BGV8mbQ6I5Ob1wpkF6UqjJshc4IfNFa2RwmB2sxN1CHMXbm0NaADHKwqkuZt9/
         J03fcLr6lFkW6F7DPJcxtf0K/5EmafzwEQSfhr8aThT9aDrzuKzGTx5w5EMpEcZXNG3r
         ghGMXbArjIWwgNbeaQp15u2d/6A/SQTFHB5JtL+wxkJTERon2dIeora7hG8HG9qUDz2f
         GssaFLmi8VMA33zZsrGjLupfYkmZBX912bBN2zixDHd/A9s5o6jdSmkbuZ2fw087XiEH
         FEf4UnDpluh2heJsjfJdcZM7gkqLW3MufIrrSf+eKyXlVeBWTGjtroyE9SXrWYW/KkGI
         gwxg==
X-Forwarded-Encrypted: i=1; AFNElJ8wblth6dCrWBeHrrbaWs44gCMClu2rRLg5OsbDqdh1wdwUFKNkTNGe+ITL76lpo6J73t7ccW6SMwg7p6Yf6N4a@vger.kernel.org
X-Gm-Message-State: AOJu0YzoJ10smgVHfgIPD6Pu9L/qF3/B2er8zBzB+WlUN0Mb+9YHaL2L
	a6MXg/SpAUVkm9lyrrIlz1btmD14nNuQIo3mFbBPpMxoYLbfR9k+sByZZvyXP5muPYbeqaor2aN
	QyfyTxx+Ul7mR9b8vdQpKK9fj2omCpCwgg8P+UGj3
X-Gm-Gg: Acq92OFZ0nzkTNyyGBn7OueG7S+rnR/v2kH7RC/eNPzF1fslqCktd9druTbUap0Ubs9
	TBZefxV3JQIfX/lyI9ZKOsYEMsifnE1tH0K0s7+1wPodEMObTd0K9hlSlzigIz6tl4ZnxdpfAuK
	p5UNu1/9IEb9XuXrdL2yJDe8bRy83fjOwc1uoybaAkqUpIBt9/+oQ8IVMfPSfrTZwRNAZ1woWo1
	XP/4tnpPNYALQGYkqHnnOMyGfHH1AVbIXrxWwtl1MGifWxZ2xMuzSkpMbVH5EmgF+r34FF3YZqn
	eRfr8V7eP+TzDhfPrMejrJr5Y1ZKWjX9VumM+xQY9dYIcZbp
X-Received: by 2002:a17:902:c941:b0:2c1:ee6e:be1e with SMTP id
 d9443c01a7336-2c2d940584cmr386605ad.28.1781112303095; Wed, 10 Jun 2026
 10:25:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610165207.2077258-1-acme@kernel.org> <20260610165207.2077258-12-acme@kernel.org>
In-Reply-To: <20260610165207.2077258-12-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Jun 2026 10:24:51 -0700
X-Gm-Features: AVVi8CeJu_W1f8Z8bQTqqbMjyHJCcpIqKuLeXECndOY_oYiYIww1kSUtXMEcW1s
Message-ID: <CAP-5=fUsa+FDExbnSOqSdhe-T2VpM-3eNFmkWpZcAusWwBAb5w@mail.gmail.com>
Subject: Re: [PATCH 11/11] libperf: Document code simplification case for
 widening struct perf_cpu
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 9:53=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Add a bullet point to the libperf ABI TODO explaining the code
> simplification benefit of widening struct perf_cpu.cpu from int16_t
> to int: the narrow type forces defensive truncation checks at every
> boundary where wider CPU indices are narrowed, and values > 32767
> silently wrap to negative numbers (two's complement), bypassing
> bounds validation without them.
>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Ian Rogers <irogers@google.com>

The size motivation was for cases like having 1000 CPUs and a struct
perf_cpu_map with a CPU for each entry. In the data file we compress
this by tracking such cases as a range of CPUs. I wonder if the struct
perf_cpu_map abstraction should do something similar. It would save
memory, potentially be faster (iterating a range rather than loading
incrementally increasing values from an array) and then we wouldn't
care so much whether the struct perf_cpu was an int16_t or an int32_t.

Looking at lscpu, which does a similar job:
https://github.com/util-linux/util-linux/blob/master/sys-utils/lscpu.c
They use cpu_set_t but that seems to be a bitmap with fixed support
for around 1024 CPUs. So I prefer perf_cpu_map.

Thanks,
Ian

> ---
>  tools/lib/perf/TODO | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/lib/perf/TODO b/tools/lib/perf/TODO
> index 486dd95dc57208a8..e179728697d8c7c0 100644
> --- a/tools/lib/perf/TODO
> +++ b/tools/lib/perf/TODO
> @@ -11,6 +11,14 @@ together.
>       (x86_64 max is 8192, arm64 is 4096), but NR_CPUS limits keep
>       growing.  perf clamps to INT16_MAX in set_max_cpu_num() as a
>       safety net.
> +   - Code simplification: the int16_t forces defensive truncation
> +     checks at every boundary where a wider CPU index (int from
> +     sample->cpu, al->cpu, etc.) is narrowed into struct perf_cpu.
> +     Without these checks, values > 32767 silently wrap to negative
> +     numbers (two's complement), bypassing bounds validation.
> +     Widening to int eliminates this entire class of silent
> +     truncation bugs and removes the need for the INT16_MAX clamp
> +     in set_max_cpu_num().
>     - Scope: struct perf_cpu is embedded everywhere =E2=80=94 perf_cpu_ma=
p__cpu(),
>       perf_cpu_map__min(), perf_cpu_map__max(), perf_cpu_map__has(), the
>       for_each_cpu macros, and all internal callers.  The perf_cpu_map
> --
> 2.54.0
>
