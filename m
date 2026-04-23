Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C3F35AC33
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776958420; cv=pass; b=giofaLiGURH7NeJmO8THjXos8itILxWDwzlBmp52qgRNwxGvM3PO2w2wf4HbWNKQN31mHtaiP8i1AKC5YHMk6Ho36DXLJuZ/q1mNKEsUhtIttQIKdTyo3DIfR/BaWLGBfjKQfB6ZNM/9vSsGwQFThB6RqiykZQds+z7kyhGdzYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776958420; c=relaxed/simple;
	bh=T1pnK3/dcF4X/41Z3x54tQM5m4bmMwR39FcTWzI8hyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=szaO2i1NkQQ+7bCnUkbFqlJEIOcLfTH+/+KVah4I9CMw1qhKtxV1EVBAk3VyrSwS2EWUHd5d4w4rqtuoqrQnq1kkVLVB5Jn+QHkQrxzVjN3eRV5qzk3emJtqyxaVLx1kV2KaohROkwdM/IHf0JxL5f2V74GlClNIN9PKBsrBs0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kLDcfDJI; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kLDcfDJI"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-67148a70f8aso54268a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 08:33:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776958418; cv=none;
        d=google.com; s=arc-20240605;
        b=XL7jBeFHb7Rx7eK7PUNHO45zvk0LKE83bqB24HE+y1e/5Xqv8BI4sEbSzcgst1ljTp
         ZAgdBj1O/BLbz56bX4bEnZB9n39NQIesgvQe7gMnLTZTGJWe9Fxdcz3aAm3YbtQHU7+o
         OQHwdXJ9dkEVHPraH5FyF4fz8QtYPum18m6yB9QkGvQYyn8MJHWUoHNR8IJqDXgmBLuV
         1jCSdjhDhitccnKhhkuHZy8vfRNhQwX0rLQxZFvnHRJMTZFfBy/Atsol11zRfLcmupC2
         wo2VPt1JnepFLAzeNuVw9ejwsWR70oJXEv5gKGTUMDAzo6PxKs9d2IIxqoAc0wMmSQum
         zE0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OsxNIj4wJa0sbNfwB5Amgg3Lv6Hkf5YbUDtxavbwvFQ=;
        fh=/uVeBZlOSrT0CpcEibHZHlugMCc4THt7BHuPfEq8a28=;
        b=AIIe/VM0VDIZQVssZj2xNa63NwhFwgAporKWyqqyfw1qdQEkuH4fmso96E4cc96KHg
         AS4TsrkxeePITndGThTI2jyKjiow3iSNM2uFkwa4zRDiLOK8hc3c7yFIvAaOyG8OdPt8
         cuHGI+brT89ZjMDhBAoWUUR70aqwPhVFAMH5jl9uMCsA6odDxdhiy5TFhy3nQd6EhQDK
         qY21TR9A88AEXPIsjyGNank4Yn4geiP5b3VKu5sPbwfjZFod7m5w0O3ErsKvLLFFGLVc
         fKHMnbkZC4ojVKE0ntaO7dtOS+BNiIGWgKC1qCM4sXg0NI5BwOXCQ5AM2L3uSxNJI4Jt
         AKWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776958418; x=1777563218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsxNIj4wJa0sbNfwB5Amgg3Lv6Hkf5YbUDtxavbwvFQ=;
        b=kLDcfDJIyln4V39txmMS+cW5b7Z2oDUgbqxgWKhIrhEE6Q0lfesOBixCnDjF0FPvEL
         8zTSVtGU6AKqiG+1HbQAO1nuB12TyylkzftZzRgxyakY2AkyLy8UbAhR9E89BVv9pBAq
         G5IxExuGyzpwyElCFY9iRxYDmZ80dqf/d2JAYEbAjStqs7D/z3LRghfsBMOzSjIuHIc1
         +DC6XBpQcT4uqzjBnZC8RN2xFx5j8gAYhqKnEvzPMW34WbHv2EF+KJq09F0VNpTG2ifz
         qDG9agInR1snumhxXMjM/MrFRJqEIjhdq7Lu6SjzrjKp2WOhNHWe6q+TySHcZ+t5deC7
         t2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776958418; x=1777563218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OsxNIj4wJa0sbNfwB5Amgg3Lv6Hkf5YbUDtxavbwvFQ=;
        b=YsTJ/IXZUQEWWjBmEud6ouwxO0QposIfEmbZJqA5JqSYZV82vYoH3hawQ/zZGPOWNw
         fyzw2ej693pTN9KsQIB2mkyOZAkrsrBYQFaXtKBVrLKt5fmxhskdSZ8Zli8XYxsaOcgC
         N+OXxpLOZxUqc1XJgYm29aaHiOpGT1i3sZzq2uPnK2ZvU2udkvyMarIae1v5BFwHxJEZ
         uodBdE5HaePXrJyxL9u0fPaJr4qEliI1LfReEIhrZtFAXa4s5n2KoXWCx60aEMVniaie
         o+O/IURJIEcpxMoHLaQ14go+iah5WPEK4xiFD+YnRRDtHCd2fg063VV4o/wAHhjRkqKm
         Z+7w==
X-Forwarded-Encrypted: i=1; AFNElJ/Ddr1pklsyp+ZO/dOmw/elUuzem/a7k9O5g1r4/9v65ROLbSvMpGSNNvd+QdhgzhP6Z2BgXaAu8JuRMpQTRVy8@vger.kernel.org
X-Gm-Message-State: AOJu0YwPBk47OOPakwC1gB2hD6pAiw+hZwjyrv/3A9tKp3t7gyC9w24O
	Dl/gJKp+lV8ZzK6PY6BnVHpiw10bzWcu++xizoBUl6E954udopZx8CFJ6gom8KHfT6YIEJPQmVn
	xq1/ra2ylTa9wf/ASxZ/32qoSBf+pHS0HH3BBieCr
X-Gm-Gg: AeBDietWmHcSMyWoEVssIW9FtS9TAolYKg31ndJTb+EFhrjVtZkZ51xcoSLSsprr6DM
	1yVWmDgwcBMUIcwIwB2hAjirawH19pT6dCVWS/OvV8VWKzZfEYVhTCBPJPg/IZg1jZIDjDZkPng
	7wGIskcehJDfEWD7WdJL8i2zjJFuwTvftl6l4N6d2foEuYc+2Fva8zKVZzRtFipt8ZbGaeV6yYI
	SNxYeQTllIWBY7Ri4Vioe1Y5bxzMfLhJcNXo2p3UgezUddyWT4B6tI+IoXo/kiVcD+0x5NyBHDA
	7jOc0kXmbxh8dkwbh7SVMvGOKZ+J
X-Received: by 2002:a05:6402:a508:20b0:66e:e3f9:ebb6 with SMTP id
 4fb4d7f45d1cf-674404eed43mr13659a12.4.1776958417009; Thu, 23 Apr 2026
 08:33:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423150340.463896-1-seanjc@google.com>
In-Reply-To: <20260423150340.463896-1-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 23 Apr 2026 08:33:24 -0700
X-Gm-Features: AQROBzBBAoDsVusSh2h9V7H_f9OZ2OCtaBU8k1DNE-tepDqCsp5oI6tFTHWCYBg
Message-ID: <CALMp9eQW+Y5i4D71HCAmnPywQs+hFhaB_9wR=BbZ5bg=XCNkFA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] perf/x86: Don't write PEBS_ENABLED on KVM transitions
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Stephane Eranian <eranian@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 8:03=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
> ...
>  - Dropping PEBS_ENABLED from the lists save three MSR writes, not two, a=
s
>    KVM performs an explicit WRMSR prior to VM-Entry to guarantee PEBS is
>    quiesced.

Is the wrmsrq(MSR_IA32_PEBS_ENABLED, 0) in add_atomic_switch_msr()
necessary when the CPU has PEBS isolation?
