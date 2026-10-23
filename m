Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792732600;
	b=Z+eg8EdU3TvrT2dJAk4WbKDNRxsHvp98BI8qtgwQMc4zQ8nsCnDynHtKvhzIfQEcd8pX
	 uEkwOKMk8JWSydRf3WeTd6Hmzs/dFsRM7q8HzM0Hv3F8mtjCtUnk+oKQrBqTrKc/AIWSf
	 1KDCL/AEtSYVvWeyhN98ElXs5qMqwWxPcpR1FXxg01k44m4BxB6nXtsxgZxRBOBFM6tej
	 KPzm1jdxnTkHSCQtUlrM2UNUfY2pD9fAYaTmmF0VKwRhBa3nGf1isjGfxFrUBbC+l0lm/
	 1cdzTfoYAAcUlMJSxEn+JkrYab2A9a7OppFWuKA0rZ0cRxcg99PY/HOGfYZiPIVPl7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792732600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nz9Cf8qFMGz6p/yYVjpoFgM9Oju9i2cprQSLO3sRbc8=;
	b=GCgn0eV3I4RybmPKcNJmRsFK3zw2Aw+/IJSveTvkVdo3LwFrZVx/7x3ofzq9ilOYEK2d
	 w7kHET6g9K/6zyZZp/E0dtsAzTpGcSI5eQHIBdU2ihrQen256KfWLWTnh6iSOtcHE2ckd
	 V5o4BH9t0ZtSgC3ucCvf34Mk74ei3ZKQCTnwZi8gFQBqY1aTAYeTw8hWo64tEI1tVhk5d
	 XC11hQgg+v2DfvDyXfOeG8hl981eEmbMcEfe6f8NIhTxGvsGReO8PzzybX5VkIpMHiVrZ
	 1pv/Js730uzlR02o1W9BH2RRjQcHOs1sF9FC1LNyk/Pi7v4nQ81LTRu+qkx9ieReRew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="qk/Edkvs";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7974C606A31B
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 05:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7974C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=qk/Edkvs
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5337c7b9937so180621cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 22:16:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792732599; cv=none;
        d=google.com; s=arc-20260327;
        b=POveEHk+/cnTR5mx8tMeUpXxy4vFUYus2P9cchhqN4XMbtMgv3+3eyPB/U7/TcZb37
         mZE6q9vyHELgt0NaQgpjFgObO7kGpni9xslkyBIf86eeJ8ynEd4QvH3vBDqAvTnXRd/L
         mnGbZOpbindaftZJdQkLYOnjAsENwPmdoWvulvxZrRbbrIqasOtV0Qhhb2zqb6wxDeY3
         hMsx/szjahPf8ySs7RZj48GWW03Xux/HHmeMv1H839dpHzcZwkK0h83xKaWcYatYQJUY
         grRGG+Ctuczs++GUORt8AT8HjvjzMzobRSMTUEllRgOEE7sDLge2YYmZ3FgmbAWwjzAU
         G2cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nz9Cf8qFMGz6p/yYVjpoFgM9Oju9i2cprQSLO3sRbc8=;
        fh=f6OHwflva0TMlWiMHJkxjM93BjyPKKEUAs2jwfTQ0A8=;
        b=i8oE/rErO4IA844DHhwBbx0TR/RHY3qFKL4q/sjeeI9wwkh/m8qXXsn/Pcg76eHvgk
         hD8Avzt2OhK0l/yDt1NZ4uSFHmoJe9UkNuB0eEplEcONzSM1Q7ieqPDLcP1DO5Nq1EB6
         HHwQMK7l9pStk3YJhOAGcZUcuK4jv2HTdBGqF0WSL/xFjhCWDVNAsY6/uzc+6QEmJJPl
         lRjn7d8zzSHPDYyEfy0XbGpBoqiGsTGb0Iju2oB0JJujnrJr82RQI5OCsN9qkpfzznAX
         NZ46wK47LsvR0e/pysbZ2czqMEL8zVFHv4WGWU8qOEVkchRzupxvXKSKGZHHOeOSx9Sx
         fHww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792732599; x=1793337399; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nz9Cf8qFMGz6p/yYVjpoFgM9Oju9i2cprQSLO3sRbc8=;
        b=qk/EdkvsHRAnmnorDQKg1s+yWQL9hzjOOpTzQqcpTHHNE4+D3aq49Z0GG1r50IJ8c/
         lONFb5BfwTJ3b/eb5h3y3/ivGtjHXxCwh77N6byYEsTf99Wp/GeGZA2H6qR1/85ORowe
         BUc1fXIcECLjlrHuGmFZTBxzOZnOpWzwBJDNNCX/zc+StwRW2s2UN/zQgkrx+zDgZZbf
         FeTSKNODJ8RtQgUADfG9CYTUa6AbiKRkmLeqijY5U95nre7ZVCtKdUps5uxcALCOqJNX
         WZt0WIy4d1858mhO6BbparV0C0i9GPAZhbAP5D88LztwEJimGi2EZndfCtJfuRwbVm8L
         736w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792732599; x=1793337399;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nz9Cf8qFMGz6p/yYVjpoFgM9Oju9i2cprQSLO3sRbc8=;
        b=LHPa/6s+wPZR5ylb7+cmC6u4ydiaU8EnNE372Ixf34CiwgIociW84t6WjImo1ztZ5f
         VP2nhYgZp77N2vybgbh4f90fEpKRuZ3zI7Ng5SEUSueLQLvUIpuMSuFuMskWhUjJhofK
         GwwcYLx0dqu33nWpRs3FsIvsvdHG/GdQywtDg5gQfdUJO2ImkT90lTb1qkCESQDlp+ki
         8PlUgw3Otv0i4XZP1XC2tMEX7MSAGZETsKrWC8pzphe6+0uiVZxE9QQoXQB8Zd9AAHeZ
         1jfnc5ysu6AQf0N3Fisyv24LCbKyeKpgebs7v3L9axh32R/xiim1r8KmCdwrZEPweLa6
         Nk2A==
X-Forwarded-Encrypted: i=1; AKwUvBxXQ1DKvfT/TE+8cLPaQ00XubHtWVgrdrn6oNNuYHptSUiq2+AWdK+WY57tqhpRA0dQ0ZbZW31F+IP9qkzowwKL@vger.kernel.org
X-Gm-Message-State: AFq9FYKVGBNV7ZhmDibOZLWOdpwHPIjOOGLZtYbuBzw8qrHCX7zyuy62
	v6/otjQ+En9wMjDc/EGkZEqL1GmHTPMZRMdJSS4oBbycObE9pxV42Wptr3WnkQh2CY5MRInPuaC
	w8mNPPehuK9B9nnOClDuqvMy2TiZODugDkRDQxH6E
X-Gm-Gg: AYBFou3xrjVBswJCH1xvLeXDUiaVOVYc3hrkfHPF1a675zmZlHy/rdecO7ccXQUDw20
	QqruXGLcIeZDWyXqYEjr52vBsseZaLOJxoITvwMMU5Wo3uq96uv60HQUeWZVaYhYLlADYECGO8B
	ZKOj7TccseAvxl+OBP0oFk5TQub5zfS9MKMi/jQHCE6TcEuY1gN71aOID8eQ0P5KQHEa1KzgeE8
	nqkQGaymfNXwNXr1Kz7ggo3IrB/kqsysCVeoyIQhveIzbR5hXPyrWuZVX5zNpucO3L/7WhjXYHJ
	0/pn8wN/yAy/O4GzXUfXnMN7v6Ovv8exF+yZr2S8MQLvADP+MHSZ5sRYrtxwxuUMI/Qbx+CmVmu
	SBu3Xd+oL3XR8JWPaacZfVZBky3bkWOXmvha6ImaAQ00HNo2kMxUjTwZj3e4=
X-Received: by 2002:a05:622a:4d4f:b0:536:3ee4:81cd with SMTP id
 d75a77b69052e-536c274d0e2mr8214441cf.4.1792732598813; Thu, 22 Oct 2026
 22:16:38 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020205859.1080743-1-irogers@google.com> <20261022203003.1779152-1-irogers@google.com>
 <20261022203003.1779152-6-irogers@google.com> <atqUSrmtsfCojGcA@google.com>
In-Reply-To: <atqUSrmtsfCojGcA@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 22 Oct 2026 22:16:27 -0700
X-Gm-Features: AclHuK-FispLLEYasalxplr3JlR7dLX32HrZh2qbDugEADtQ2Lp3Wc6zv5VHb3M
Message-ID: <CAP-5=fWFbSP48GDQFuUXsTMJ6sN8hYEYrMPmM8tb_o44AxwCQg@mail.gmail.com>
Subject: Re: [PATCH v6 05/11] perf bpf-filter: Add lock_held() sample filter
 for global mutexes
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, ddhariwal@google.com, 
	eranian@google.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 3:55=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Oct 22, 2026 at 01:29:57PM -0700, Ian Rogers wrote:
[snip]
> > +static int resolve_lock_expr(struct perf_bpf_filter_expr *expr,
> > +                          struct perf_bpf_filter_entry *entry)
> > +{
> > +     const char *name =3D expr->lock_name;
> > +     char base[128];
> > +     bool has_amp;
> > +     unsigned int mode;
> > +     u64 addr =3D 0;
> > +     int ret;
> > +
> > +     ret =3D normalize_lock_expr_op(expr, &entry->op);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     if (split_lock_name_mode(name, expr->part, base, sizeof(base),
> > +                              &has_amp, &mode) < 0 || has_amp) {
> > +             pr_err("Error: Invalid kernel lock filter '%s'\n", name ?=
: "");
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (str_ends_with(base, "mutex") &&
> > +         !str_ends_with(base, "rt_mutex") &&
> > +         !str_ends_with(base, "rtmutex")) {
>
> Is it just checking the symbol name ends with "mutex" or so?  It seems
> risky and limited, can we check BTF to verify if it's really a mutex?

Agreed, a suffix check is only a heuristic. The catch is that kallsyms
gives an address for a global or static variable but not its type. And
vmlinux BTF normally only has BTF_KIND_VAR entries for per-CPU
variables: scripts/Makefile.btf passes "--btf_features=3D...,var,..."
but not "global_var". So on most kernels there's no BTF type for
something like cgroup_mutex to check.

Patch 6 in this series adds classify_lock_sym(), which uses BTF where
it can and falls back to the name suffix otherwise. It checks:
1. for a __percpu_rwsem_rc_<name> BTF var. DEFINE_PERCPU_RWSEM()
always emits one, and as a per-CPU variable it's always in BTF;
2. the symbol's BTF_KIND_VAR type (struct mutex, rt_mutex,
rw_semaphore, semaphore, ...), when the kernel was built with global
variables in BTF;
3. otherwise, the name suffix.

In any case a wrong guess is harmless. The direct owner check only
reads lock->owner with bpf_probe_read_kernel(), and only at an address
already confirmed to be in kernel .data/.bss (function symbols are
rejected via kallsyms and BTF). The worst case is that the filter
doesn't match.

Patch 5 adding a suffix check that patch 6 then replaces isn't
intuitive, so in the next version I'll move classify_lock_sym() into
patch 5 and use it from the start.

Thanks,
Ian

> Thanks,
> Namhyung
