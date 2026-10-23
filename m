Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792732788;
	b=SAOAtkazuFTBgKZVfS86f13tfgoZHtHDsXploDCgrocaWjMp6TlwZnhI9b8F2pVEqJuZ
	 vYEJpsla42doVKK3sfu6vpuMYTvix8Pjf18u8ZZo9b9lueEEpuGnUHIlDJgOJ4uM8bLRR
	 BZsI4bt3CsLONSox5GB0mwc+VidK5XMgyMv3rL4xf02nKCYN5YAHuO/Ag9X623TsG4Mb/
	 bb5V2mZ43SFR6S3ucDKtl2g0Ch/K0YoFyFcpSUPEdWoItnLoK3VnnV90T9dH9kYLuKoWY
	 aQmrVgKXJDHEpQZK1h0GISWunwaEkyloJO7dMdL2JD52NuYE9O11Tof1fxAi5ONGjAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792732788;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/NaKMAAGxxDgzyHN/M6S08Zb78X5Vhy8kShaURHSxac=;
	b=Jf8hW7Hy7Vo+9qxEVIO6d3qJNSgUYWya53eRPOuhs16lKQGsakfrd1APG5OM0x5I50mX
	 04Ed7boarzwaNcU+XArXYMht6/IlNfMBizxTru5x3Vk6DjTjA3zXUsfuWksOnig3Z4jKQ
	 V/0T3+CuuUpUTIRqToMxM4dkaqV4bSKP/CXxnINbQjLDG9iYwW/u0uZdUkFfgeUuRnaIo
	 SK/PSCSt7ELOJm6LDwqqgX6Hd6r1lsYFQkHytF56vM2Did9cTwGzwNPKPrBr/jCI9WmgG
	 bhqNClK93F97cRjTxqjpzv+as8A0tjs6jNZePg9qLBV3/e7MktuoOG50LALbADUIEBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dhN+jjhY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D5D606A319
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 05:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0D5D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dhN+jjhY
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5337fa12431so127361cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 22:19:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792732786; cv=none;
        d=google.com; s=arc-20260327;
        b=sTasL1JxLm6qo40m69SsqRmSWMPtPLqxD6/yUduXdB0Bv+Z67D7KkteoBis8zrRHij
         +WjOne1G7Njcd3cqrrwnniso0FIPOUtFqFPTsVTIR04IpIId+TEMEtjIkyzGYomDDK/0
         VJMGXOY7TEOPa/Z9kS0oSKGAsvRE/pvBIpjRy0BWpsztpKniuWzCgdboXcSPx/rYc48L
         vJ1EikCAoQGxxP77G6KW/voTWTwjQ/E5QdCI5I8/UkETBltVGGUW5YQHPDdSHJaUoUZf
         asGD9643CfkJGHc22l42TWBsuQelHNxIGuMEFCi7NvcK+bqRQJMxa2UX//fw5Pq2blJl
         PiIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/NaKMAAGxxDgzyHN/M6S08Zb78X5Vhy8kShaURHSxac=;
        fh=Cxvh7HrtgtBXf1YoQ30qCjimZpdIYjOt43oW6Yr03WQ=;
        b=DfpxVUDHmsw9x7fcHcNtc9x41oEDHQIbiVlouKUQ6yTxp5Ekt75sMAaPwSlVgBB4xo
         znZLl3xY/FnWr7i/fbdGZ4ktazJZCUb8N066Kippm5bblgiz/50Q4h/JGEla9VOmv2+x
         ne1tRjP4tey2qOWRXqaDReCtaF2rlG8KQF+oWVNnaSQ7bgPxF9UBT6YId3beponSUxD7
         ddjozCmjqFhiGCbcLtj3KK+x90WMUBOfAXOCQn54IHN7Gwlwfrww+sCbtbS6wkaTH9Uc
         +7p3bYbkNmkXCwgUFn0h+NI9KGeIRnhXbKDwEw0K3RUfs51nx7jVjGuBArYFgnOWk26x
         7ZGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792732786; x=1793337586; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/NaKMAAGxxDgzyHN/M6S08Zb78X5Vhy8kShaURHSxac=;
        b=dhN+jjhYDCzHhvHbn33fmDcad2jwo/QdsisYORyUbFD9+SyQfN1B+U21BPynozdCik
         pJRzP91kzKB8uV0dCvorOtfJwoFvPDN1KJ1jFQmtJ7boJ9/GFh+VdTe+LSaszIikyc1k
         +a6ZtlBhP9Gcz6qOLkBWf9KiF1z15aO4Cke0EzKemwnQlqR37Andcj0CmLkwSur/vQXr
         2EyTIJ4ScuMh4Edk0uXxn1CtMI/0roJu+bUbfgXXYGcYq0A8Vdm9fGjm+ZOwJSgjHSc0
         uqEcKEpuDUmFmPjcrYC5WEq90+naPV9OgYcG0qIXPmCEUc31AMRTbOCMXUX+SCjLIvWF
         1c6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792732786; x=1793337586;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/NaKMAAGxxDgzyHN/M6S08Zb78X5Vhy8kShaURHSxac=;
        b=Gll4C1LnsIecXwI7ac7mr6dbTI37uS/N4UYYh7EPL2xP7QrNz+o1d+YBxoYnNCDgAe
         rngMtAzYeun1e4AYnztMO43DkEBrNZGm4H3bf+CUzJW3WOPaRVtiRs3T6oXLerU6KEHH
         hA/CsojlQDlNduPlGmJS82M1MYGd2GuMjP4lHtMhoeh02PKvWaQ+51ZuVzFWQ6z0ZUR8
         +72kJJcpU/ZYkFqmlADzi22nhQnrmw01SfdDUQvLvEkfO6EQBbCWJ/TRW8+0lkMcOrvi
         Lw1FMVxmtepCS5K09tGQWQNc/60ame2dp7xE7TgEtQoC6hTbC5KqvSYRpc1F7Q3VYEFg
         pZ+g==
X-Forwarded-Encrypted: i=1; AKwUvBxiq4FfNbJe0jehUG/s5Z8R7+xzzmhpSQhMj+wFL0LOKdt26tvzWa3/5FHe9ITWFkrN2vUx2bgn8B24mDAnDGUz@vger.kernel.org
X-Gm-Message-State: AFq9FYKA0utXahi9XEb2itHZyrHL1rJpfrPSAw7CMzhovDuZMG5XyKRL
	FB5ZSj4b5VU+jWMp0kbvUJB4IdJz7Il4AusT6KuG6mKIfvX5HcXNHcTEUuulA0qwm8xgDIxwIhw
	b812QjYq0XKObXR6wOu6Z1TH/6TU6HGlPEJjxaXgT
X-Gm-Gg: AYBFou2j6XKjoapd+6/m+5b48Fl4JrZS8n8LjIwqqhRQXqyJUsCUSubyt7bgiKhQ3GE
	z0Lzp2n9CRP8yfoCTxgW89G6X36yDCW301eRK/Vr6PfwAZe4AonJTMZXxbyWm2Nk7K+0fWlaomH
	npIni/4qgH9Lck2RhyWcTXfUgiqzvduylKSN5cAGArkohnr8oNr/5yNEOffBTnaP5SbrgCmGHHF
	gA4KMk17G0FWNAMb1LbaeSgpHcu4K01YwdO4IrZ/vxqRLF8YuwCOKCyHTdHoGQuMWfG9hKJe41X
	QuQPJ4MdsAQ9C683cvu8blZKWT24ceqg9RG9JwlBcOn4taAWQ4K/ktcS12NyJFYHik/17or7clu
	B8au2nKn1jsXX8yuv2bIQONjVz4iLUTMUkMNuNg==
X-Received: by 2002:a05:622a:410e:b0:531:282:6560 with SMTP id
 d75a77b69052e-536c499a845mr5631721cf.15.1792732786055; Thu, 22 Oct 2026
 22:19:46 -0700 (PDT)
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
 <20261022203003.1779152-7-irogers@google.com> <atqUsIBhPaxjp3p8@google.com>
In-Reply-To: <atqUsIBhPaxjp3p8@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 22 Oct 2026 22:19:34 -0700
X-Gm-Features: AclHuK8074tTEIi4nbK08SZtgABfkl_zUHjYXnlEC7ftpUdA3DXoCtzUr3SI0rM
Message-ID: <CAP-5=fUZ+=_b_1SL7B=wtab=8foQ6iDKXrxQ_k8wDZaJTd43Pg@mail.gmail.com>
Subject: Re: [PATCH v6 06/11] perf bpf-filter: Extend lock_held() to other
 kernel lock types
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, ddhariwal@google.com, 
	eranian@google.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 3:56=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Oct 22, 2026 at 01:29:58PM -0700, Ian Rogers wrote:
[snip]
> > +static const struct lock_prog_desc lock_progs[] =3D {
> > +     /* Mutex */
> > +     LOCK_FPROG(fexit_mutex_lock, "mutex_lock", LOCK_PROG_MUTEX),
> > +     LOCK_FPROG(fexit_mutex_lock_nested, "mutex_lock_nested", LOCK_PRO=
G_MUTEX),
> > +     LOCK_FPROG(fexit__mutex_lock_nest_lock, "_mutex_lock_nest_lock", =
LOCK_PROG_MUTEX),
> > +     LOCK_FPROG(fexit_mutex_lock_io, "mutex_lock_io", LOCK_PROG_MUTEX)=
,
> > +     LOCK_FPROG(fexit_mutex_lock_io_nested, "mutex_lock_io_nested", LO=
CK_PROG_MUTEX),
> > +     LOCK_FPROG(fexit_mutex_lock_interruptible, "mutex_lock_interrupti=
ble", LOCK_PROG_MUTEX),
> > +     LOCK_FPROG(fexit_mutex_lock_interruptible_nested, "mutex_lock_int=
erruptible_nested",
> > +                LOCK_PROG_MUTEX),
> > +     LOCK_FPROG(fexit_mutex_lock_killable, "mutex_lock_killable", LOCK=
_PROG_MUTEX),
> > +     LOCK_FPROG(fexit__mutex_lock_killable, "_mutex_lock_killable", LO=
CK_PROG_MUTEX),
> > +     LOCK_FPROG(fexit_mutex_trylock, "mutex_trylock", LOCK_PROG_MUTEX)=
,
> > +     LOCK_FPROG(fexit__mutex_trylock_nest_lock, "_mutex_trylock_nest_l=
ock", LOCK_PROG_MUTEX),
> > +     LOCK_FPROG(fentry_mutex_unlock, "mutex_unlock", LOCK_PROG_MUTEX),
>
> I'm not sure if these are still needed.. it can handle mutexes
> specially, right?

The direct lock->owner check only works when we already know the
mutex's address, i.e. lock_held(<global mutex symbol>). In that case
prescan_one_lock_expr() adds no LOCK_PROG_MUTEX group, and
configure_lock_progs() turns autoload off for all of these programs,
so none of them are loaded.

They're still needed when the address isn't known up front, or the
target matches many mutexes:
 - lock type filters, e.g. lock_held(mutex) or "lock_held(mutex) ||
lock_held(rwsem)" for the direct reclaim use case. There we need to
know whether the current task holds any mutex, which means tracking
acquire/release in held_locks;
 - slab cache filters (lock_held(&<cache>)), where the lock is
embedded in a dynamically allocated object and we match on the
kmem_cache of the address recorded at acquire time;
 - hex addresses and symbols whose type can't be determined, where we
hook every lock family.

So they're only loaded when the filter actually needs them. I'll add a
comment above lock_progs[] in the next version explaining this.

Thanks,
Ian

> Thanks,
> Namhyung
