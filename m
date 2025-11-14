Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0B32C0F96
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 22:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763159277; cv=none; b=Xo5di+ZhLdh20s6HKMtW3Zr+KjJ9+BJKtiQbyZv7KY6sx3EF6m+vA3wOFKDPTxAvVZgNPkEx0tCwqQZeL15Wo3G42aLRPSrT5qsKs4dsJoSHtsMgZv9HW1TWEtSHti1WgsLqkMbqaUrQHfKsa2JF8OD7uAjwwzhHeNVz4zMycG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763159277; c=relaxed/simple;
	bh=+TC/TYEeT+4YvBtSBlvWpJpgnRAISaBsWKodd0Xzb6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHXVYCEfArZfDegcmRQIp/tYcYRDeuBtMcQDnMyJ9ufFcfyFi6PUMup6VdDbnBK6crnHsgxV7b2R5RYRjrj2I4z7NEVaa3jW+hK2JwcRXH1Bpwk80IRV0FDpweT9CiHd17ONszHpKaUG9LM4bzxTPQ2PKV8vnrRHmZNO4pep7O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7jz3I6z; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7jz3I6z"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4711810948aso16880255e9.2
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 14:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763159274; x=1763764074; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6zWTgFH16lyinpfOQhDmR6D2kiWJbPWX9IcixhEvB9E=;
        b=P7jz3I6zW49WoIl9AWcCazyZSyb12nABUEgm5KOqzWqPRvHZGcM4toOdoyeVzHCfpQ
         QUL2Q88qVYAjvU9bUHkX4HyJ2wV9hm2HYpuxqVDsRhyRgoUiFdEZYQ/I3nHUvpWZ0SCE
         NM0BH8hLCQQxFB5JNvxjjFeeaneSaVjxm68vahwPmZLmzdfDR/BXv5S6aoKEzclF8C6L
         RZYgIiNd3eKXxyTB/AgrGZss0ApjZwJrLLIt+Yl8Sw10wBJysDKAptZCfJpVkbUv68Gi
         j3vPcgvzsCU2sxMVA6e/cSWKbPwxrythFB92FBWbWmwJfiUpHN05z/TH48SxtxB65zow
         Bbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763159274; x=1763764074;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zWTgFH16lyinpfOQhDmR6D2kiWJbPWX9IcixhEvB9E=;
        b=jZLymzrlv+M027j6ulSBDlaceohQz11RiuQfNa/45GAN2H8CL9WcUt6YoLSlJ9wvFn
         4lzlayqnyO1NzFYAIS2cIuyg/yW+he37KxEHkIwmwu4d5IRX1qfNn8M1IptyKrg1wkL+
         LRWkRmjbcq0yr2vRnL3R7mJlpbWw6d5Fb8LpHQkl5xNwgTOS08qFq2Sn7VQbOk1N4IRl
         NY7khtALvBFxlQmcVJK+KHCuD/M3gnAKuplRxvZwmB44280oDBwsVWT4nQ4EqY+8K2mA
         OYQSiKUnj6f1hV6DS3aCXnYvfYzdNlHJjIt7hYoFWyj/ll63Si/fxFWo/HwhJM6CrzVU
         2Gjg==
X-Gm-Message-State: AOJu0YzRPTjsU2E70IV3QxTuE73y6n5a1uxWGdK48hFHzhQNjdTiekEP
	h7nlznucEZYzHHaQBiWymxNr6ek/eNN25T8YSn7ZWw2L//tiexNW2yG0Ew+LjOv3OBrrPx7le5I
	E9t7rqhYjbAmIbXQoS0SxHcMmsDys84M=
X-Gm-Gg: ASbGnctDzx5YZvc7l57vYA8wEr/drp1B5F45i71h9FXKSc/98xdFjGvu4kpo1bL830Z
	DpBqFYc01v181N4A/QZawk3akkUhDFmoTu2MLEItLfRZ66Ac7Wl+qQ8vd6kMsmbSxxXARhUN3Nt
	O9zYuChamPKCMFMQEgTvNrgwBPmDyLokCe+hjRisVi5WvizRVfCMHUK2w3QxNyrO8OujI/8m2qq
	usSdKVkD1cJZONG5NM67Dom5eGL4P3usZroB0do3XqA6zhFhEnlu65iH1g+ZFj3fKtvkbObFSD+
	VQuiwgPva+i4wF9Mz4KmUEt+gG3Hj1MV9a6LaDQiOfU46nGdKN11XKnBUjRdLoTpFXesw+IDrvF
	F7nvGUBIpVCjs8CiJKS19dJzA
X-Google-Smtp-Source: AGHT+IFCm5sKwvl7eNyOLegnKt83z/VbkVQWLF7g+uDBn072nXJbPU43kyFpu0lz9jl+Cj4Qsg6ib/2F7Vx/zOYpBPk=
X-Received: by 2002:a05:6000:2893:b0:42b:5592:ebe6 with SMTP id
 ffacd0b85a97d-42b592d34e3mr4222219f8f.0.1763159273537; Fri, 14 Nov 2025
 14:27:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114092914.217533-1-namhyung@kernel.org> <20251114092914.217533-2-namhyung@kernel.org>
 <CAFjbc8FK_qs9XqMEf5k81VRNCNXSyda=VUSuJwp8LALOq8fGvg@mail.gmail.com> <aReBx2jFezxbhWt0@google.com>
In-Reply-To: <aReBx2jFezxbhWt0@google.com>
From: Pablo Galindo Salgado <pablogsal@gmail.com>
Date: Fri, 14 Nov 2025 22:27:43 +0000
X-Gm-Features: AWmQ_bnexWNje23AK3agjC7AxKwHytwDp9GqCOq3TM5av1a9l72X5v_V6j6j1eA
Message-ID: <CAFjbc8ENz1AhCH0MBMmcrJB34GvjWPjzV3i0PEfnsTAampe8-w@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test: Add python JIT dump test
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The version is likely the more reliable method, but you could use
sys.is_stack_trampoline_active()
in combination with the X option. For example:

$ python -c 'import sys; print(sys.is_stack_trampoline_active())'
False
$ python -Xperf_jit -c 'import sys; print(sys.is_stack_trampoline_active())'
True

If you get False even when passing Xperf_jit, then it is not supported.

> Good point.  Is there a better way to check if -Xperf_jit is available
> or not other than reading the version number?
