Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ED6396B6B
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Mar 2026 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368749; cv=none; b=sX0zandH8VYr4gR5wCfdekfCeBfZWz3AX4oWK1DdN+3QtwuqPZk5zDsxYwLcavlmWpwRbv7hnK1gXwd+LQaS37U/wvaOw2Fxyo9l2y86M6a/sDU086wh9eF+9rhipY0sWhDbB68E5SeDUq5KO209Yo9NzzJvrarF2PxEW+fo3BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368749; c=relaxed/simple;
	bh=/gaGN1+SVIK7mmzfw43CEwEKpLL2BpZNDPB37yS2bYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGMLTg/jj5vEZUQEZPCW904qZu/2EautcJpbT740y3mRfejbRxX/HlaPlwwPqYf5XW0mv26XebaQlFVHd/0YLc2q88nG6Db095TMxmt1+iFqC1R/BPddglWS8ueUHhN4CZIduNdSi4rxgnwKEzB13wn91rGK53XaUIxrLgiyHEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Il0KJfNu; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Il0KJfNu"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b9825ba7e8dso204315466b.3
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Mar 2026 09:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1774368746; x=1774973546; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kwpyzIz914Q+mCh8BxGrks1Yw9I4fI+6MmK9HUqnkuw=;
        b=Il0KJfNukZIQMf/o1MTpLQpiQn0ZllTvIiQDA6Dw2dGFJr3pha7JPPWndXGWynhugd
         cJE30TtQtUh2CUlAchjBfs5v2ttID9dy0pR3RwImNBnYvSnDOoJ6Lg2BzvvpDUUIwPCX
         +AijnXgyXTn+52YGB+4ijmushScKIubu9HV6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774368746; x=1774973546;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwpyzIz914Q+mCh8BxGrks1Yw9I4fI+6MmK9HUqnkuw=;
        b=BQYbayTaOGcPhadmbkV5sevMftSS/mhQPvnmt6zDjHY9nstLA10Y6L0YDZnkUtkp40
         Act6VnFTetWjnO5xRIc7+7gP7/2Rpf3hSwFw8Mn5eXGcYpvLgFoxehVs5Gcq+/OhLI2P
         HUjpNK6ymmXWKyevPg7aOtbmhRRDovKOar3tueG4FHsW4lf8kZ+VdSneya4stfUaMhLA
         JGYScqsoQ0hU9Ywx888n8ZPJm0bB5tcmg50QKxoisKeTthSD4FfdyUa/bZXpeyKgfb7o
         CqafnSCA6FugmsFmSxHGQrlXwhYTem4ZGazssIw1yqyuVCIlrqrZPAgGyUrAhx6xwlht
         JT6g==
X-Forwarded-Encrypted: i=1; AJvYcCXNpMl53MLqMel4d4fuARmB217e7NJPdKJ6eL45WgB+XzZg0+E/+p98Jv/KDSmCaRpwk/Jx+3jybx8rH69om9rh@vger.kernel.org
X-Gm-Message-State: AOJu0YzeyK4SzV7JT1syC8y6PBu76DNKavErmapA+TK09o8GFQH71osC
	+L81beXlhroWiY5rJqkyg/p/bt2Q5/EYt2PzAFKQcRWcQgW7ggNzlYSw5PBm8u6KoFyRgQg829q
	MSHygxQ8=
X-Gm-Gg: ATEYQzy6+gs5iXH1T1VmjWhnTYsUOmqc6/ip8lKaRliSOJMGT3t9tqnkNhC475zL4F1
	KQHBXEYkeMKIASSd24dxexd5RxSbhpWNyBgscvN74Dr/z+FHGJslMiBOQ5BWwWfKKePcZLNUdWj
	11r4i5QGIe1Z8uic/ayAsUmxTqoO/4jYHRewnKs08M8qNEHOzi2bMWBZVjJVpUD0CX45ojn1nIB
	7iK1Y+IzVVoA8sbHpbvoR7SMk6X4dr2MimOcFxnyqxUcfDO1CiQHuOsfzFRlOuB8RcZnw/5c6Ob
	Go39J9/hk9PAzMjrYz1kNm1yn4gTuZEv59SKSv0iuPTaErQSxBfA5HIFCloCX3t6IUN8F4Hknjs
	W/RSkeju0hK1ka9JqGIwsTA0k9sRG37Q5Mv2mSx+d39LX9urCFKNn/Fsh/meVMCeWBcB0U1g45h
	ejTzC/g4NjQZhw+NqQsZA6+P3UbfxMYbIqNWIJbI8wO0GBR3X69z74gGxMKAqCEjKS7s3xy3w+
X-Received: by 2002:a17:907:e0d8:b0:b97:c801:2c29 with SMTP id a640c23a62f3a-b9a3f1663cbmr371766b.7.1774368745956;
        Tue, 24 Mar 2026 09:12:25 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9832f43ae8sm674359366b.6.2026.03.24.09.12.24
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 09:12:24 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6686697f578so2450408a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Mar 2026 09:12:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVcZvuh/HoSYgl49P7VTWOsElA/gZc6p+ZbXME/V3QTKN1i83s3KeYPVdiqYdzM2IYW+8OYbq3GrU1zFHyRuJ2N@vger.kernel.org
X-Received: by 2002:a05:6402:1469:b0:669:ed35:e472 with SMTP id
 4fb4d7f45d1cf-669ed35ebf6mr5105094a12.4.1774368744636; Tue, 24 Mar 2026
 09:12:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323105725.1882966-1-acme@kernel.org>
In-Reply-To: <20260323105725.1882966-1-acme@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 24 Mar 2026 09:12:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=whAfaYBGA3gDW+8kL0hGWoyGCs3rT5CGOKVnNmvswT_pw@mail.gmail.com>
X-Gm-Features: AQROBzCP_N8RZkTp4tF6KQ7E3OFZ4knmadd7wf3ql2LgQI9b1rXj6Fm50gstZyA
Message-ID: <CAHk-=whAfaYBGA3gDW+8kL0hGWoyGCs3rT5CGOKVnNmvswT_pw@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools fixes for v7.0: 2nd batch
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Clark Williams <williams@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Leo Yan <leo.yan@arm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Francesco Nigro <nigro.fra@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Mar 2026 at 03:57, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
>       tools arch x86: Sync the msr-index.h copy with the kernel sources
>       tools headers UAPI: Sync linux/kvm.h with the kernel sources
>       tools headers UAPI: Sync x86's asm/kvm.h with the kernel sources
>       tools headers: Synchronize linux/build_bug.h with the kernel sources

So I think we need to come up with some solution to *not* do this all,
because honestly, it's getting hugely annoying.

And it's not annoying due to the unnecessary diffs per se, but because
this tool header sync then causes 'objtool' - which also uses some of
those headers - to be rebuilt, and then that causes *everything* to be
rebuilt.

Just because the perf tree decided it needed to sync headers for
unexplained reasons.

The docs say "this works surprisingly well". That *used* to be the
case. But with objtool also being affected, it really does *not* work
well at all.

And no, the tools cannot use the kernel headers directly. That
*really* didn't work well, and required synchronizing kernel changes
with tooling changes, and was just a pain.

So the "header copies" solved a real problem, but we need to figure
out something better.

And honestly, the "something better" may be to just remove the
mindless check for "headers aren't 100% sync".

Because 99% of the time nobody cares. This time, for example, the
header changes in question were comments and stuff that was inside a
__KERNEL__ guard.

So how about just at least as a first step trying to remove the
warning that is actively detrimental, and only do header syncs when
there is a *real* reason for them?

                 Linus
