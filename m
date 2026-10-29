Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793295143;
	b=Z2+ldGAQqPrpNTKKmtjdLI/Lf2s638ijK54XjjSblTFydtjDdoNZwS+GzrCgtaA7lyrg
	 I3gzJUv/tf6FlZ+GXXwA4Y4s2sUVszrbpY1J+Vv9UHmwftvBV325Nr5Wj4dhUATxGdNJR
	 x/VUbXesvpvVhJ0T7V03vIbYVhNC/b+WCEyWbkLaEn5SVPm3gmiv/M98RV/PoiFOnwhcW
	 Yvs7hyfC4ls2rX7KM9nTpJqBDdinHS0ZsS+VXAGOBTZclz0160k164g7SgPBDBGNOHdVt
	 CgAoozPVocC/KQrPVpRtn9SAeUmndWoaqhBqAn42T0aJJDOtRiRwjcsYrMSfLXoFTVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793295143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=R4Rs+OXHP0WWXEc1HyOxC7jIqK/84yuL7ps1Yjc1ZrA=;
	b=tEmyUhuyRxJawZNFZU5TELEc/BGY+5g6Cb5DCe6Ff7Cfv8qDBon9d3z98s6918p6DmOA
	 FykrbmeJ0kdCx7J8bghEtzDYcfVdvOYDkl+TRj9vIzUpeM0hiHJYImLJ/XHseBm/i4lWX
	 BSsBpWy9gEFTjJOVV6zhvP83JNLP3lWRyI4h0mK8ZNxlSYIxdJEv6VzRv06qi2aVvVr3e
	 XM9HG6yc9h9ZTt7a9niPFEg8Gaelm15mhnYPCxEW0bwKgoCEuzhmJ/jWYah4dYHYK1NEQ
	 JxT4FabjYGjhbNFkJpHuCLWpvc5NytLrE3UjUhhXAW6p4R5oeC8JsXixQACdNwBPKnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sn8ZaqyK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8916606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 17:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8916606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sn8ZaqyK
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36a1c464349so357331eec.3
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 10:32:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793295142; cv=none;
        d=google.com; s=arc-20260327;
        b=PR3dauKMWFCiXZgT/tsxMx628+Nylzuu+bGtj+WpXtpxHr3xNux2+N7z6dfYVyyyez
         dcHN4CJm7wpEswkmmsM0CVuUgt7GWBqguFCx2IMivTPWn9xhF3biqMOdt552HVqexcmP
         9WuzqKq4xtLALzHT1NC5Q0ofT/DTbuAn8AM5VweoeaPmqaLclvQEQDsl0kEdmFFvczqx
         bNw5YWanlKgTHcuZM6LC90SNapcXaeiG94fZm8LTKtGpTBoryeKtjFpNzIh0H0r9e8Qa
         5foNhZSgI+6j0CRD8uVGe63jCmgOU8IoI82O8JS/L3E1pXNtTBbGLkTbtdczpBxaIp3V
         /QYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R4Rs+OXHP0WWXEc1HyOxC7jIqK/84yuL7ps1Yjc1ZrA=;
        fh=PNQ3hu04j00JSTLVMiW2a8mQaAsRGJvmhmvtdajt1Ko=;
        b=pjGKUTFd45sWqBVs6ZiW8pqRHeOvAiDt2DIqBmYV8xfQnPmU4/TGUjrUquvBD9GbyA
         By1P5UieoX2Mq7TPkN4qXJaCT0Q/M9BWpawNNXedloeBdcDNMq+j+45EV4GEUQnG9nHE
         NTlN8Gai2LzN4vRC4Bia3/XhwHlwrjBJM/rNuTTDdiudxXYCQvmuLOWireimHXV6aRvN
         pmzmm5dczSDse13y+KcBAngPwGOsZWQWXg3dAeZjokb6Xt6gnOpXvzdY6UZI4ALrfXHB
         SiIID1+rOjMGFZmsEVtQ88E+lDKjI3Yvl+CawRZD49r2WKogV3WGQbH/lxopXdMCO5A0
         lR3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793295142; x=1793899942; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R4Rs+OXHP0WWXEc1HyOxC7jIqK/84yuL7ps1Yjc1ZrA=;
        b=Sn8ZaqyKa9l3To+a5GYvvAD0uAR4LJpfMXeTB71mq8b5e1Cu/L8u9HO8Zj4J0B5nci
         ikPSN1UBdudd69fky6nx+fn2zpQNEKKb8ndM85agvMeZX1huHviwXrVWGf3dK98oNA2n
         kPm3sFQi0kDHKs5E2U8HTKnHQfybkyFStMtmeFjCEYXW2mEF15JtSDG+5XlGpHWRHj6s
         p7K5MntJv9WyU0bgxVoYY7vLJvNAw48cDUARB5+Bim5Zy0yKYy1Tv3NY6ydDdUGsXC0O
         83MJ9sAETqsv7YSQ9eLhf5V4kUe2K4/oqFg8hHLQtP7JGEDhl74TjhF3bkIgdYuBHeUM
         yhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793295142; x=1793899942;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R4Rs+OXHP0WWXEc1HyOxC7jIqK/84yuL7ps1Yjc1ZrA=;
        b=w5THpnacOlMijkPu1nOEuUp9lRkqPoktwhrPMuCAVXCCTdf46tOpRWNwPr36x+SvrS
         7sB7YGwnxrnziKZdSdPFbtpn4Owkjqcwp5b2tkTWOkB9P2OWtTpQa9hte2ohzw0ea+zi
         VgxL2PxSCUzVJVqIp5WlkcwZhC6TohAIChtYTrC0eT6C2BcLRZWK73eLOZKyyR6TwjDN
         SA4mXlTwgw8+CTvlUMayS0tGnlwMRWE5L1tiPAsGwQVVf1Sc4A5VPbq7C659sN6QAZPX
         +w8EDb5kL/MS2aVtwQWv98rSHjd6s9iOvB04aIBjPkMa8K4197XkqaJzpfYUyGmnTCaH
         HPdQ==
X-Forwarded-Encrypted: i=1; AKwUvBwOBFGJ0A0hD+8D2JZu9L5uiD24vNPNW5rvsE0Z7wVcRJfPjoqki3EcTsUoLBE/lAz6LNDO/fHrc3aiYIc72yys@vger.kernel.org
X-Gm-Message-State: AFq9FYL7qiNNykpuZ0o+8kgcXX/e0Ij8ta/HQCOiu+PaNGhRCAcg1Y5o
	bGs9VvAgETCkROPPT71KwT3Sx/iXWfkRlj+ln0kVzm6+NnXECSgXZSj7CdzKB8n9umjZr8tPchk
	1TBZ6ZAWRnzwERJ51bkHacbbL09dRqM4=
X-Gm-Gg: AYBFou1HnMZkOu0ab78I0zbEnnU+IWKPVVPkcPLKR3oOKECtWcJXC+swAGCxCY16hq8
	LwfHAHC2LxNbX70tXM2VJx7+I6ipsI9Lbh+UwfzbW3G/nGrneh7s+BqHaBtslJM1MD8pIxzWFE0
	Wr7IjI5tgT9slW4f7rgVo/0QuwC6DWpRvLuqNvh3mV+y93fs61grLQqk9m2HTiGVV6LECYV4NKf
	FqLiP5tj3D6yeIWqxI8Mk9jNsxvcsO2mpNb+QShyXodI5B+Ak+6Q2vQP9H65UzMa2yxaxXE4xN0
	2Czzs9y4RkCPEw3JEml9YWei4jyQ8JIT536X9NJejJvfkHbWQwwjGoIFV2t+7VfrW8jBGhXZL6k
	vBo7qgR66E6xwk/q4iIzzfLUkxvJRkOUy8xJnDKhBmVdHEkEEQeqUYtCButZiIEGdApHJm9Qeip
	RtafGB93eW6Vp5cm0D63XyrT01IQ0RRbu3qYJNBhZS/N9HVNkLwdONw88OhoLwiUmftEsXPAICV
	BSP1Yvskw6EVJW4U7COcw2echa+BmH+6OtvKlCHxO0vIKeiSGvbw9h3Cw==
X-Received: by 2002:a05:7300:ae18:b0:36a:13fd:b5c with SMTP id
 5a478bee46e88-36a4235ceddmr139643eec.2.1793295141770; Thu, 29 Oct 2026
 10:32:21 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029162958.3224280-1-irogers@google.com>
In-Reply-To: <20261029162958.3224280-1-irogers@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 29 Oct 2026 18:32:09 +0100
X-Gm-Features: AclHuK-0mxI3LKAZpnOHH-Drrv94DNRirn4x7gfXbdMbpDKW_doTTtE6JJd6tT0
Message-ID: <CANiq72nrhqK0NP5q8_G=936++gZR3=zrES+cK96T95-ThVTpbg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/3] tools: Add Rust library build infrastructure
 and prefer zlib-rs
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 5:30=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> 1. **tools build: Add Rust library build infrastructure and zlib-rs featu=
re test**:
>    - Adds `tools/build/Makefile.rust` with helpers to locate Cargo crate
>      sources in distro (`/usr/share/cargo/registry`) or local Cargo
>      registries (`CARGO_HOME` / `~/.cargo`), map `.rlib` prerequisites to

When we were discussing whether to vendor crates for the normal build
or whether to fetch them locally from the registry a couple years ago,
we discussed approaches like this one, i.e. picking a version from the
registry by folder name etc.

But that doesn't work too well. For instance, the graph of
dependencies may change, there may be several versions available (and
the highest may not be the proper one to pick), there may be different
major versions available (i.e. not backwards compatible), they may
change the build scripts, etc. Even picking the highest major wouldn't
always be correct, from what I recall.

I also asked a few distributions how they felt about it, and they
indeed said that it wasn't a great idea without querying properly the
registry.

So one should really ask Cargo for the right information about the
local registry (i.e. offline). It has been a while, so Cargo (or maybe
`pkg-config` or whatever) may have better support for querying it
nowadays too -- I would suggest checking that first (e.g. `cargo
metadata`).

I think depending on Cargo for this, especially nowadays and for
`tools/`, should be fine (we were considering even back then and for
the normal build).

By the way, checking Cargo's cache sounds very strange to me: that
means the version that gets picked is even more "uncontrolled".

I hope that helps!

[ In the end, for normal kernel crates, we decided to vendor for other
reasons, e.g. we wanted to pin the versions, to customize sometimes,
and most importantly to avoid any possible user misconfiguration that
could lead to a subtly incorrect kernel. But for `tools/` it makes way
more sense, of course. ]

Cheers,
Miguel
