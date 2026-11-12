Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.160.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794444063;
	b=cs3L67zeuL9uBEgKO4l2/hYClaK/Quyg+KdZ/XSel9fJKcFQff9G05iryXPOFmYQL0S/
	 o/E8SRf0K2aXeg41Y55XSkPkiyg5LpYxGCZjRmKBjqGEIAGGe9wBxAhbTrApM3v+NHJtp
	 T2Vbz/tDS8GK9vJ8SZCg32falr1UT0X+OBpI4cGsSLSY9BFva9kOgKGnCr4esWzkfv1ci
	 peIJPT1vNan1fVMldN3FenhrC6hETZWo/QPM9o6UVWuEgD0whLDtLBBBAA05f5aWXNPNf
	 exQUTv2FhBvNp8hU8ij6arQX0LREyXjr2X++5vR93Fdfg0KJaErYDr0pmYS7IfkHF9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794444063;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=aBfI4LwPIWDn397IEmYVFCKsIdTFBg5r1P35GnfG2Gg=;
	b=PitXw8es7NfOMi3vhWusO3dQ5MPpq5AG6jUXgvd0gHauDvE6dMhTiT9mqSw6SDv+cBBt
	 LNDEdVjsLWgKEmWAzZvur8F0aiAjY7DEuHqe5409bgzpz+fS+6ZQm6TrrJnx4qrA0XAJo
	 Jpaf4Wq+2kgQUvdU6mrXoyJh12HHItozqnfEm05V7MymC3L3olTD6KZyOrSYGyntBhDTd
	 3VLM4jNnvhiGSp0G1oMLAEDOJGBFmlcxd5I4nQ/3bhFs7oqHpMKZXp62KjVmhKq6o/joe
	 LA3O8TzYplP4zUKzEDgWaTDisdCysV3MRv1pUMEiaGBDuG/YoMf8W1jmsWp9UYHrnkw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eSFNQh9m;
	arc=fail smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB63606A326
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 00:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AB63606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eSFNQh9m
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5383c97c8cfso43061cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 16:41:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794444060; cv=none;
        d=google.com; s=arc-20260327;
        b=f0CzEX5n6kBNNbVENt59ez0sFuG2EdAYvvy5RuifqLsNSSZKqRwcbTe+VdFXDlYcAh
         JPmO0Sx3ZGLl62NcRxyvH5fdPQpB1i4OyO8uqy9HB6TMy8YqGVeIkWC93bHwUb8KoANv
         qEF3TOsniFSHxunZyczUxd3sYfNgnUtxZKyAaIlZiUUhOWQUFlkosj9sCisOzdqA6rvd
         qaFuPwakS2gZKu5zECXtl6e8VVweKBIvUtp2iSOOahIpPSFHE411Ck8vj7KSR+2GhMwA
         hEZoa85qtR9XSfPct+Guc9X3Pn1rnwCF+wg/Zk6AsWJaoUPJxpnNaVfwgAYWdlnzY/I3
         bHng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aBfI4LwPIWDn397IEmYVFCKsIdTFBg5r1P35GnfG2Gg=;
        fh=195fe2S1+YBEGD5Gx2o/Kb6p3/0cSC8zAg/pk5LRkuA=;
        b=s5iYtvNoW38/GWHlwheVNkIoC9rqtSukOxY9t1txKPGZTTMrig5qTuyHhxXk+G2Mmo
         Emk1heIoUO4ZzMB//EDepMxfCd5o0omhHEWCkjBfH+ODJAjQE/OOzKizhMl1YSo924Sx
         N84+G3vZmFJJvs9ywjtW7B0LKxnL5RccQQO2eAGLlseRIxugm14lIMWap1OXdUhSlQx+
         LuO0XMCLcIIGB2H4caI4icA2FqclqE2gLHJ8Sc/dra9AHFehnUdsAbWk6msXPA3IDnmx
         AllnimfvAIP7AB3RLdMd4UhPBGA7FCjU8gC2ktPN5TgJYGZEBYjwxuugZb+82OYf/Iwn
         A6zQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794444060; x=1795048860; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aBfI4LwPIWDn397IEmYVFCKsIdTFBg5r1P35GnfG2Gg=;
        b=eSFNQh9moOqcJyQ9dG77dKNM/iMvsPT+P9rDh0lpuY482Xiy2zDEUkuM/csCcBcLOJ
         pQWEP1bX/gWqN1mw1iwZ0PEqe1eFVU/Vk0tRh7eDTy9JrPaDuAGjfYLbjgp1Xe2NLpmG
         O0NM6tuNdspLDBewmlic3iPNH8+VTmkFzg8Sj786Xd+ba7QSX2w6W0Pw2qGEDQK5KcB0
         DRjGKAyTNkq5anfpNzZCqZPPdsTTjngUOiFaHk3Imre56Im7B7yYC7aiVva48MVrkhG0
         dj7+0I5w1pO8YrICaWvBoTA0+HTqCn3O1KV4TIyIZN+zPVb2fxNp1ifQJpouN6uvn7H0
         oTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794444060; x=1795048860;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aBfI4LwPIWDn397IEmYVFCKsIdTFBg5r1P35GnfG2Gg=;
        b=zSoAAlisEOhcBK8UaVXxEblFMZz4UXhmIGv//Du88rkIXH57GEF5T0IuUJ2nPwC+zV
         p809/Jt8z242NOgpmzQfGrN/gaQmGTe2GapaphkLromIiACFlWqCD8F/0hpyR349mnLF
         7mUCtXT9OJJaxVZUnaCjtapRkPtYs4NaxmEPZxIBCXzn2MHzL1Km9TonvAGMGKbq+uGN
         191uafEIlGTCfCR+6NdxeRENXzCILjtzYrirBRu567ReD+ZzesA1HXEODJCAaTHuubbu
         Z4HfTfpoMzp1lR8MUrb5GZ6bNQIv/q5KCAFPsh9NkEUH8a3cbNMPX4vCNkRFaHmjIbMO
         3iSw==
X-Forwarded-Encrypted: i=1; AL+hErFoCghi3lrGveKJtIfhC+dIT1zQ4RPDFTKltkWGGHIiKIxylDQsBEhwZClIKEXfLmdajw+iHIMBIjJ4yzYaAFAZ@vger.kernel.org
X-Gm-Message-State: APuU4Z91T9p1yI5ZEPxwKNAKg9JHF82tORYzn4bWEpxskHW0a5Sf2E4B
	Jl4gkLho/IgUJ4dTh/j5q27dKjcmusss23R5dm33Bx/D94yZZzj4WTwbaxy+UOOO3TD72JvN3mt
	lJWIZQ7GJdBYsnPBSITGWIMEIADsjEnAsGakA0fUL
X-Gm-Gg: AYBFou1KxUEXKLg7b8G0sv9iST49LhfiPBguMCAUSImesDhimZ7iwkemTrRWJGRJX0a
	VJOLRX8C5pZcWUeStO0W5TikBPdzcFQsUxzDxjl3s3hRftX5cC6ONd4oG+PDp6Ixg1adtWSXEw0
	X0Sp2/xBn6GyR+b/sdM9gWcBndZWWK546sdJQOcFGxmMUTdEpRxDldHDFEYNP0TVtnwyjL5NR/D
	Qh6oksCl3AWcyi6V9hquB9w3o9xf/ysdiY8Hj/WdZYCLgGCBVyZ93lIxMoABS2BARoQAyZwYYpU
	PTexu1JwkbzWov3F4Qx5eq7BzjuEZaiiMZ4cX64NDvpc5F6Kdz4JyJj6UUMkba/IIFR/D+jI9XT
	drfxyVMaeOs+xB6H5BjEceFW55qxItCT4Jzyw
X-Received: by 2002:a05:622a:2b4b:b0:535:ce3:ee07 with SMTP id
 d75a77b69052e-55990ce917bmr5521181cf.13.1794444059678; Wed, 11 Nov 2026
 16:40:59 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111192328.3917311-1-namhyung@kernel.org>
In-Reply-To: <20261111192328.3917311-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 11 Nov 2026 16:40:48 -0800
X-Gm-Features: AclHuK_uaJBzba-msIabZxmfmAl0HhXVr27IHwWIve-ZoogqoqSz5W0jWx8eCU4
Message-ID: <CAP-5=fUDtatm5Ah4gzw7xHbvLysFEX=B7g-ix9jqufQDQGiD5g@mail.gmail.com>
Subject: Re: [PATCH] perf record: Do not fail with an exiting thread
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 11:23=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> When a thread in the target process exits during the synthesize, it
> can fail due to the missing /proc entry.  So __perf_event__synthesize_
> thread() ignores the return value of __event__synthesize_thread().
>
> Do the same in the perf_event__synthesize_thread_map() too.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/synthetic-events.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index b9dbd105cdc37f38..3c8d29f27fd91a2c 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -991,6 +991,7 @@ int perf_event__synthesize_thread_map(const struct pe=
rf_tool *tool,
>         union perf_event *comm_event, *mmap_event, *fork_event;
>         union perf_event *namespaces_event;
>         int err =3D -1, thread, j;
> +       int synthesized =3D 0;
>
>         comm_event =3D malloc(sizeof(comm_event->comm) + machine->id_hdr_=
size);
>         if (comm_event =3D=3D NULL)
> @@ -1010,16 +1011,19 @@ int perf_event__synthesize_thread_map(const struc=
t perf_tool *tool,
>         if (namespaces_event =3D=3D NULL)
>                 goto out_free_fork;
>
> -       err =3D 0;
>         for (thread =3D 0; thread < threads->nr; ++thread) {
> +               /*
> +                * We may race with exiting thread, so don't stop just be=
cause
> +                * one thread couldn't be synthesized.
> +                */
>                 if (__event__synthesize_thread(comm_event, mmap_event,
>                                                fork_event, namespaces_eve=
nt,
>                                                perf_thread_map__pid(threa=
ds, thread), 0,
>                                                process, tool, machine,
> -                                              needs_mmap, mmap_data)) {
> -                       err =3D -1;
> -                       break;
> -               }
> +                                              needs_mmap, mmap_data))
> +                       continue;
> +
> +               synthesized++;
>
>                 /*
>                  * comm.pid is set to thread group id by
> @@ -1037,17 +1041,19 @@ int perf_event__synthesize_thread_map(const struc=
t perf_tool *tool,
>                         }
>
>                         /* if not, generate events for it */
> -                       if (need_leader &&
> -                           __event__synthesize_thread(comm_event, mmap_e=
vent,
> +                       if (need_leader) {
> +                               __event__synthesize_thread(comm_event, mm=
ap_event,
>                                                        fork_event, namesp=
aces_event,
>                                                        comm_event->comm.p=
id, 0,
>                                                        process, tool, mac=
hine,
> -                                                      needs_mmap, mmap_d=
ata)) {
> -                               err =3D -1;
> -                               break;
> +                                                      needs_mmap, mmap_d=
ata);
>                         }
>                 }
>         }
> +
> +       if (synthesized)
> +               err =3D 0;
> +
>         free(namespaces_event);
>  out_free_fork:
>         free(fork_event);
> --
> 2.56.0.567.gdb80ae8cd5-goog
>
