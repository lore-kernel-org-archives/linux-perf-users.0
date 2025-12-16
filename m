Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB99E357A2F
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Dec 2025 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765888160; cv=none; b=XtGbtyjoef+YavlCU4m5VLVnOnSPdQgEIjwZZor34VoYqxRs06xAyIjHyyzRPmiE+nVpCUuE8uYoGs/HdD6YdI4eEKXs6MuqwNwo2+C13wM+TMB3lX/gmVXClTBzZ5eFLDPaEkfVpzyHiGg5NJnBXqTjRbGGqL9u106Xim/0+Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765888160; c=relaxed/simple;
	bh=HDes8BCMie6O4p9LVAYxBfQQIpi0ZVoBmPLcQtZg3so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GyAjG7rTm7Ain3xNSx+esO/+AiPDz544RV/OXYNquyX3CNsHlYpCc7qbbRUjIpRkomljTrz9o59UTiesWPz8k7U4CbFScfgT6R/DHX27Qle8l2/iMpfI+ZACH2f9h9ziwhpHLvFZy/0Tucre1kD+J9rFQgv45eOLRwQ9Ub6sQIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7B9J92a; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7B9J92a"
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-598eaafa587so5247783e87.3
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Dec 2025 04:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765888157; x=1766492957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBB6BuR2kkNR0CeKxXfGVVlzyrMRqFqfRYfF5LSKwuQ=;
        b=N7B9J92aEdQtjmjIW2+qemVaGCyzo2UuFPH0OSMHUpExS3+Bq/VKp7HCop2Ohvx7vI
         r9h99no3tANWP3DoHJLipRzoftZwolAWBNDQVGhsKJs47LIYVzUPIevfH3gKXuMPdp2q
         K+Um/Zw/i7Mej0pAgtdXL68ptD5nXbz16iMpnwvOUvm2oE6BhqHG2lSVnx3iSJ7QuNYa
         b3ARRLEAf+b5xJzFZxieA5K8vum1YUuAPTZxt/jX6KD6raY76nf7yj0AXN38toUGiV+T
         MVrzDGYhHVFgiWuiffMm7khnp/K2gXMWpveS35/TQb7IH8PorjFZThRUBGD79ALjjTMf
         F7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765888157; x=1766492957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VBB6BuR2kkNR0CeKxXfGVVlzyrMRqFqfRYfF5LSKwuQ=;
        b=kWgn/q9AYd3hkTXPyTgtevMX8lrr2Y+U7ra2cn6J4xkT6lp8l7f/fo9AxXV9cmjcIE
         DD8ff2Zp6Bvr0zhNefZCZlyRX68bf/flRBUTP5AQxEh5gg4WHIV4AL4bAW4evSNjaUBR
         g4S15DPXsDWgIQaeoULMcX8Zjb+vrOBNdSjC6hns7aEUImge/1zABjfAdXfJXzhA/jv+
         mp39sUmjzbbuVk8DDBxx2pspdxA4R8CRw08X+lUNMZP1TCqf9jM+bJgHD4Q+GKzCerTL
         z1ktJO6nJS1xU4yTsjp8SEyOsW8jzg3trIFKlLSyIdZ6BvGG0ILSyUg6jZIxF+ekWSnt
         q++A==
X-Forwarded-Encrypted: i=1; AJvYcCUd5Z6Tvfhz++LftyIcfaPAQg4coK4BdmKDIthM9N149MJzTr8dKHTWjQ69/QEs/+FeuePbwlLX0YJ9qbwnJJc2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9mxvs6mEm39q8Z/VGUOK8Kscdd7B0yqzoEhxGv3m7fnj3Oxhl
	jgIl9O8U6q1gb9BPHboXC3BnqjXHpdf8eJj6a+S1HZsOjpJridjMuu6ADpEa/3P9QF8XvVp3348
	32Jd8JtzuP7CpB1yNnfEk7WKwskZ2T3I=
X-Gm-Gg: AY/fxX53tKeRQBG+9/0RGJ1YLR5M3qfP0+xbjnRMxz8gu6EqDoyqWSETbfp9xxl1PGO
	H1NsCDhx+2HxGvblf0gQRISijYnysir+ZQeReuRLJv25mrXFJVrf6yWYdPXSLJSMbAEc1TOvw7C
	ydshDda8IpOX06/d6qXdQrXqzcLIjdXIe5BZJsh1UGUrk0L8jEhqfyie+FmaySVQGIo0MBV6MXw
	7HmC2qLCUo5IOXuEpVgkRLvQ739F1NKtvaRzQpJP+S0ntKHNhmMPXpoNujUYci8RLiRG7yobOHK
	N6V9mE0=
X-Google-Smtp-Source: AGHT+IGoKKDcMCCrYaxU4CCwDIRXJ60VGXzp/A+6JuF6OYsGn9u/I7or5OUUfp45M0pM7Qs5kDQvcX2s+2ddvgs4Dx8=
X-Received: by 2002:a05:6512:1055:b0:598:e851:1db3 with SMTP id
 2adb3069b0e04-598faa36140mr4912548e87.11.1765888156572; Tue, 16 Dec 2025
 04:29:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADHxFxR-8NRN0Fwj7jhD1KKACrb0PdUp1iOBKJ+xkxaNQn_tew@mail.gmail.com>
 <20251124073445.3709-1-hupu.gm@gmail.com> <aSVlQHJ9xcGcZULp@google.com>
 <CADHxFxRY5Vse0UnezDg8hCEgbVy5qXkoLbEMRGaA6pH5aLoNxA@mail.gmail.com>
 <CADHxFxSXMvmeL4afJPh9Ycs2ABrnOVHkxJ4pRBdhJRJWBAvnHA@mail.gmail.com>
 <20251125161026.GF724103@e132581.arm.com> <CADHxFxQ2kb2pRhn0-_PJwmo9pykHzDMJDPQay5GaqmmZF1nwSw@mail.gmail.com>
 <20251211103957.GA4048253@e132581.arm.com> <CADHxFxRayyDK5qO3j-GtQAuWruk8UtQ-6EcvYb-3iKtE8ooJUQ@mail.gmail.com>
 <aUD1DXHh_PrCjZ96@google.com>
In-Reply-To: <aUD1DXHh_PrCjZ96@google.com>
From: hupu <hupu.gm@gmail.com>
Date: Tue, 16 Dec 2025 20:29:04 +0800
X-Gm-Features: AQt7F2pPHPZprgoSiTQMkFGOeg4MQ_BpGo6QA5J8JE5iIn9_ZUZ8RrN-FrlSAg0
Message-ID: <CADHxFxRrXP+vueYh=pMpGUWXCYUvrju0NO34SFUAB=okfDgpSQ@mail.gmail.com>
Subject: Re: [PATCH] perf build: Support passing extra Clang options via EXTRA_BPF_FLAGS
To: Namhyung Kim <namhyung@kernel.org>
Cc: Leo Yan <leo.yan@arm.com>, acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung,
Thank you very much for your reply.

On Tue, Dec 16, 2025 at 1:58=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> > Indeed, as you mentioned in the early discussion, running the
> > following commands on the host to install certain packages can
> > successfully compile perf:
> > > $ sudo apt-get install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
> > > $ sudo apt-get install libc6-dev-aarch64-cross linux-libc-dev-aarch64=
-cross
> > > $ sudo apt-get install libc6-dev-arm64-cross linux-libc-dev-arm64-cro=
ss
>
> At this point, I'm confused whether we are talking about general
> cross-build or just BPF skeleton.  I agree with Leo that the skeleton
> build should not require any host specific information rather than
> vmlinux.h.
>

I agree with this point. This is also what I was trying to express
earlier: although installing some additional packages on the host can
indeed make perf build successfully, in my view this approach is not
an ideal solution.

> >
> >
> > However, I don=E2=80=99t think relying on the host build environment is=
 the
> > best approach, for several reasons:
> >
> > a) These commands install UAPI header files on the host, especially
> > `linux-libc-dev-aarch64-cross` and `linux-libc-dev-arm64-cross`. These
> > headers originate from the kernel source tree=E2=80=99s `include/uapi/`=
 and
> > `arch/arm64/include/uapi/` directories, and their versions are tied to
> > the *HOST* kernel version. If the target kernel version is different,
> > mismatches may cause compilation errors or even runtime failures.
> >
> > b) Even if `perf` can be compiled and run successfully now, there is
> > no guarantee that the kernel source headers will always match the
> > host-installed UAPI headers as the upstream kernel evolves.
> >
> > c) In scenarios where the host acts as a general build server and
> > needs to build multiple target kernel versions, it is not possible to
> > ensure that the host UAPI headers are compatible with all target
> > versions.
> >
> > d) As you pointed out, `CLANG_SYS_INCLUDES` does include host headers,
> > but it uses `-idirafter` instead of `-I`. This means the host headers
> > have lower priority. This change was introduced in commit a2af0f6b8ef7
> > ("perf build: Add system include paths to BPF builds"); as noted in
> > the commit message, the preferred approach is to use kernel source
> > headers rather than potentially older ones from the system.
> >
> >
> > Based on this, I propose the following include order:
> > - Prefer kernel source headers
> >   [RFC] perf build: Use self-contained headers from kernel source when =
compiling
> >   https://lore.kernel.org/all/20251124072310.3592-1-hupu.gm@gmail.com/
> >
> > - Allow users to specify header search paths matching the target
> > kernel version (eg. via `EXTRA_BPF_FLAGS`)
> >   [PATCH] perf build: Support passing extra Clang options via EXTRA_BPF=
_FLAGS
> >   https://lore.kernel.org/all/20251013080609.2070555-1-hupu.gm@gmail.co=
m/
>
> I'm ok with this part - not only to pass header search paths, it can do
> anything user wants to add to the compiler.  You may want to send it out
> in a separate thread with all comments addressed.
>

Thank you very much for this suggestion. I understand that you would
prefer to continue the discussion in a new, separate email thread, and
I am happy to do so.

Before proceeding, I would like to clarify your intention to make sure
I understand it correctly and avoid any misunderstanding. Since the
discussion above involves two patches with different functionalities,
I would like to confirm whether you would prefer me to combine these
two patches into a single one, or to discuss and resend both patches
together in a new separate email thread.


Thanks again for your time and guidance.
hupu
