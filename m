Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8BA3D3339
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 19:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785957596; cv=pass; b=pEenNgNqgoMUy5C+BpMMpsBT7TgJJWc0BdcZjaxZXRpIDFb64WoN6iZuhgyMGe7yvBuRT6MGQ+BiyIRcNcrc6FUXh/f9rwGk2MfH7QHt9FnByG4oMnkVJz0N9l9ggTPjWkxojAKTMz+OA5c3hpO0l0OkM4BuiATAr3uoeLUocuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785957596; c=relaxed/simple;
	bh=zfxo6xw3z9Oo4FtZgyWY0YalBxWv8/rrxBlOTCzQrjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LODak0+ipuyXa/8ULKHQBaKHH5LVh1shmRiXIDNkq/CyRojWRxo5Pj3Ft9mCxprocjhEj8wetbE4NRx9hOykqHJNYM9gVD4NbyC3sayAAIAY5gannQ2p1pcHawlBKVDbW90wno1SQYdCejTbkw16PEZvvAJMT5qE014/HypMh20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UavyT7YU; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UavyT7YU"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c10ed63c0so57201cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 12:19:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785957594; cv=none;
        d=google.com; s=arc-20260327;
        b=VTTdFQsIUtSmPuc3EwGZhLtoEzgEy1sKn05CoKrothqYXWTzr7sY6b2yYT+garZYWk
         tDDTVoNY+gpZM0j5Xb8Lu2Uo+p9VDUqkXIVUkuMMz/Cz1/9KMtLuVf0j1K77NlDsFuRy
         4ODJ/j/YNu0/IiHHIr1mEoVWtqCvT6+svuVlEg0IpTzx0INVAhGM5RgWnBRmtUbFlksA
         dFE5QGTd0ERDuozyl3Pwgqx2mUmViHculMyrqfDcB5kmW4oo7Qqy5wfgeZi3jt6tk+tn
         Pn+bHjuJwK4XUWa1fC0QnkdLknmTAppkaNts3qIQh8xB8oTIg9a59AtSnSVQG2+yZw4O
         Fs6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CckD4PX2EsG+s5CE9S2v7XWHjksW6JIGVN74IhwTxcg=;
        fh=m1pVX/VuaESNxNI3wTufA5IGTkSyqHQsPAPF2xsY8L0=;
        b=l414VKtPSfB2olrtfeLggxpxftbw5DBAGiBypH641q0nu5JlTCfaF3mKQdMweAAH4h
         wnbBQ+JMW+R6mxLYSM46ZkP5M+J1DjBZiPGv2TiAdos+7gubpdeSDrN/Yt2sNPa7tG4I
         M/3gV6xR7K9yy6UYznqKtVTbfcyTt50VLrZfxNXAP9laqp92FKt6ERpQ5Bkma60EBost
         U0O7l916co1vWFcYcYeXZMoM7BXf5DCtdSDMugWwPLFt3WhMr/2V7J/FnH6Lli+62QBw
         L7M93jeL+zbFcFuX2ceT952HKj6dKp72LiDwPoV6qIimozAuYo3fThyAURc0Cnky+7zR
         tJSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785957594; x=1786562394; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CckD4PX2EsG+s5CE9S2v7XWHjksW6JIGVN74IhwTxcg=;
        b=UavyT7YUhDNcDN+Xj8XfAl3zwd/eV/8kw8oM5bLOXMzLtjZMo/un9feJuY8xeuAaPi
         vY/G7t90XRaR2inhQqDO8xhwZm/KTvXPcbmsCrXBB+Si+UdC11SjuAL+gii6tdAWrbY0
         Expd30fQm2/LRVi6uBuiTN1qmoBOXGLivNyT1IKjAmSqg5fMcDZKXcGsk8OnSXTMO9tN
         /qmzIxR5jAqoIRXK72J+/mn5fgzlB/0l6NuurlHnM5rgOKo5mEwgqSsY0fL185skZGkF
         Oq1LFhfypX3Kg929aPveG6vQwClj5DJo/ZmcR6LRo5PlnqIGCLbGZbNp+mwcRQ7WUXI6
         yf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785957594; x=1786562394;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CckD4PX2EsG+s5CE9S2v7XWHjksW6JIGVN74IhwTxcg=;
        b=QLc0hTnxRvJtkCRkhNyQcjMZJCfWp8+eZiRZZ0VJ5wYOMdMivu0Z6MgcqGL2DbcULx
         KIM2smnDdK0ShKoTllzbCtdrgvYgwjZ2fy/qwnvuUSGqjwPsy2h3JIoo1OoqqX53x5D+
         QtaSjz0OVwWQ4apEfg1U0UYO7k62/ZRUwHJFt/mJkrs57gWUyPzMXmkrjvxUQbJLCiGi
         CX7oy+OkIuaWw72Tn8Q9M/OzPcy4QD3cbfTczGbswJ+f1DIw8IRrGpm+sCbtr77E7uNx
         u9NI8vWqCk8UcZbiw/CqmOjbm6KGKC1foVAENgUWt3Dsd4VKsUs5OKpojYrm1tyeaOkK
         //Tg==
X-Forwarded-Encrypted: i=1; AHgh+RrnjwYgVgqF9ISzdisR+PFkFh1Fui1nlke4obHxkt8wmR/nieJJSR/MC0EHTXaeEI7J51E22ElvIPsZt68c/E+w@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2a9Ils5xmH4N45qLfDB0KPF13T4iG5yUgHAZXjUKDjOhjlebc
	UKPLpvczJDm8mRPyCICKDm912+sATfjAIsl4/XJb0o3Q4c6eCd8DROqHklE3JEJm+/+mhE9B1IM
	FBoghKNJz3J5dxthmC1sDkzirfsMk8muKyhfj+l6H
X-Gm-Gg: AR+sD12Gw37l4hVq/kxk2Ga8Z5qAsB1XtKK3jXnc0nA30pKGlF6owQOKYLitsA6JCx8
	x3/bGqTIU9q5H/cGPk33QOOncrGJO0sgiWelBl+wz+P2UuMG5ILP3V1dKSJgKp5F57R/0p/TKrs
	kfIVNZlMwS+P8W/0ddc7pnb5l2s7LwbYVqigi4dyUTH/vS4Dc45Zk1cJXmLeev03QkZnkS/lXi9
	x08Tvm51ElwWtce68fdl4Sz9RFmp0IpmMkfvng1y7LYVvgd4Jbh/mtdj47SGNpHe5szfI2Dar8v
	5JzVsdXsOOblADmc2f3sc6CXFEwQP4n10On106IMuxofjw==
X-Received: by 2002:a05:622a:4406:b0:52b:806e:2633 with SMTP id
 d75a77b69052e-52cfc0afcbfmr3259611cf.1.1785957593683; Wed, 05 Aug 2026
 12:19:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805133013.235016-1-acme@kernel.org> <20260805133013.235016-12-acme@kernel.org>
In-Reply-To: <20260805133013.235016-12-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Aug 2026 12:19:40 -0700
X-Gm-Features: AUfX_mwm9ILCqRoMBdnsY0ZnuX8uUjjAxCkF1c0BYnF4qZgTa7WKCcuKikHeSWA
Message-ID: <CAP-5=fUdodt6KrnKqPs0NYwp3tUDQMfQ9OHDYKGPsW=U-MhHLw@mail.gmail.com>
Subject: Re: [PATCH 11/12] perf jitdump: Validate sym string NUL-termination
 in code load
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 6:32=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> jit_repipe_code_load() computes sym =3D (void *)jr + sizeof(jr->load) and
> passes it to jit_emit_elf() which calls strlen(sym) via jit_write_elf().
> If code_size equals total_size - sizeof(jr->load), the sym pointer
> aliases the code blob with no NUL terminator, and strlen() scans past
> the buffer into adjacent heap memory.
>
> Add a memchr() check to verify the symbol name is NUL-terminated within
> the region between the load header and the code blob before use.
>
> Fixes: 598b7c6919c7bbcc ("perf jit: add source line info support")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Stephane Eranian <eranian@google.com>
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/jitdump.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 87612ef3e232598e..5f3a53f818c29f58 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -487,6 +487,13 @@ static int jit_repipe_code_load(struct jit_buf_desc =
*jd, union jr_entry *jr)
>
>         sym   =3D (void *)((unsigned long)jr + sizeof(jr->load));
>         code  =3D (unsigned long)jr + jr->load.p.total_size - csize;
> +
> +       /* sym string lives between the load header and the code blob */
> +       if (!memchr(sym, '\0', code - (unsigned long)sym)) {
> +               pr_warning("jitdump: unterminated symbol name in code_loa=
d record\n");
> +               return -1;
> +       }
> +
>         count =3D jr->load.code_index;
>         idr_size =3D jd->machine->id_hdr_size;
>
> --
> 2.55.0
>
