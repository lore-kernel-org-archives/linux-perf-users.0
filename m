Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383DC37C0E5
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789843039; cv=pass; b=QkulgdEyuqWuBRfSBKPf15hvBplUOYlSHoKJy/HjsaYYm/dzgW6KHBjR+bCrKfR13UAsKi873dqhjuOmMnu/jPOW8lwi3Tej62wTj8GjftYthVHsmn0h2fgBJuDCOFX38eufVYwYiv3bZZ/ua905pHcQmPp0Gp191aNOqDWKdNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789843039; c=relaxed/simple;
	bh=lxHFstBQpQ33imEsLlkA3g02TZX06v5LaHxiPA0L27Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WE4DuzBUWRrdivrrP0/pSM2v2ThZ2Y1gg1S39i8P6If7CFWVZQBcb/UbYjthk7tWVFySa6La+iw6bjdKARokSn0SQoqkZnFIStuhqFBj8b59pWRXlH7Km24QpI8G9l/9a0PNzhk6I/6mLK76ZK603/83j+biDhJexIHmOCz5GgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com; spf=fail smtp.mailfrom=uber.com; dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b=6qt8RmBn; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b="6qt8RmBn"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-85d43db0c29so13029367b3.2
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 11:37:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789843037; cv=none;
        d=google.com; s=arc-20260327;
        b=exiQXVNaxGNVsJLtJOHVNc0IzinJ372YalrB3JF5amE7MDNfWV4IGiVQYq2kLtf9n7
         wGJ2zpJIHwHVeu3rYsSroyWKKyjQGakxu4nWHciwoxMAq+rFME2qyFLn2wkw9S+TlzgC
         ldRnJMPBAX0/qv994i1frfB6Lt3YJgSiRsmm7uvQ/9SkKaPRKmQ+fVXEbXSKhm49plxh
         X60b7wn/H0UdMy9/AnrqmrefEkT9GhrIW3rP/keumoIcuPZqw0Ov9yo6pNZXj/bD9loR
         eqQ+2AcqeQ2q2lBEzttBtshizImo2IWexUbDQtrichEXPcLsqiFvE7sSBkL+OBspgkc4
         g1RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=E59/BUz5Pi6Dr18TnnWWI0RkEyqCowN7qMDJuzGo3+E=;
        fh=4DKhlPykUyq9/fX3MXmN94T/eO9SUoW+Fl3v7RNmUAs=;
        b=W5VMooYbrn6waEfhJw6IAraLI9DBFv+hJm7en72tiYYeg0FNiLMlLVV8TxTE6Mj25r
         EaA08pd18gKWZyT14650GmPtX6ptHwQhIr2AT9erCpEO5luWWfDaIMSiaWgyG3XA2SJ9
         V2qKxhPoUOIWUSRvUXJU+J9dsg6xcDDBeb5w+p+8JRiqkZkS/bs2Yo3PyoAciXdIFjky
         RQme/f+tL3SHPhtiFkYUzFGH7Lzh0gWjnixU1n+5/uUXVpgu70iodjKARA0qXv3genJF
         /SejRKJKTr8n+FgZNRS5dssdhiKUgGGESr5D2lJ/6c7PeX184ksrb/KOgYaeSQEZNLVe
         rN0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1789843037; x=1790447837; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E59/BUz5Pi6Dr18TnnWWI0RkEyqCowN7qMDJuzGo3+E=;
        b=6qt8RmBnZ+P/o5Zl8WXueDMbV3LJUY4gWTLryJP6kokQdBfRY8woZo4pZ21IEgPHeO
         PTyRIzdngfUDCKZxPdjGnuJTwZr/mws9db4Xrpv0Grw8evXEsNbEU3PPciBpS+1cYJ4O
         gAYGFxoEKAipwTJmYh1N49zgqz6PHfG5j5ulI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789843037; x=1790447837;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E59/BUz5Pi6Dr18TnnWWI0RkEyqCowN7qMDJuzGo3+E=;
        b=AcNBGuQaLMuwHsvNk2YVQfJsuxCqz2H5NgQcD+JlKOpvHQAQLB4WmdCVt2Xz2FcXO5
         FI7hlSPW8nEWMjyvuC1LD+oclf1cdEkneIjZyo6KyTJ7Yd6P028NPtf1SUwYOjHuApia
         T0+A9a0cmbCfsSfzpDq7wqrIfXuVyDPtbG4Ybz4WJdcodxYUVAnPrwo/m9wkxNAODu/p
         ARc1gyFviVXxfjl1vZtifvF964UiyTR1dkgxaGPKhV+FvlBdzDnw+X63tjhsf+/wl/WL
         lDN8mH/W1+XT9NpqdVHEUfepmnnrqLWbTr4WAp1y1BnhKVqMVXVdRvrcJSqC/R13remx
         7Fqg==
X-Forwarded-Encrypted: i=1; AKwUvBxORNS8H01OoAgk5pK3TfyLSaHrXKldwnaT+vEtWtWdNvsxwz6SsoTHa0q9Waaxsqr3s2B7unmekEGJ/SgovX+G@vger.kernel.org
X-Gm-Message-State: AFuF++kNOv2kocQS37DISSg2CpR/4nQd/9rCTyBoyRcluXimlheZqUxF
	2xun7Hycd94+qHpKZZ/Z4V/LnuzQmGYD72cz13HwUKkfy5YMD2FT+y5b3nq039QvvqRBZIncpw/
	4dQQ9XMC6fAq9cjLka0AITLyzNvNIA5vUW++UCXLrbg==
X-Gm-Gg: AYBFou0FqoSm4P1d2ToUlUbw14evQ8xiUHJPlDPp/0FTAlJduogM0Kw/2jPdOqXUAYi
	vRC1dBNeYE01R3fDs2S9PzG5DhY6v9iEtLBa6CojuLiM0fLIfYJ/DinH2NVbXo8zqewhrbDX6zc
	w0InSPZjzsmxnr8IIrTL7YqlyafSWBq1YzSxGjnFit8bIN/e/iIgNp2hZiLEgxgk4TVbNQY5mat
	Ukl7tmBqcNha48w4aX9822c0b8kuC04PTH9aHAMPdeykkeUrgdOrPlBQsiG5u87Z1i3vXvpVqrF
	O2dgHFdCnvOWmc1Q+StwwbslR9Ywug2+m2j7DudajVrwDF1/hALvaZ5IDeVTtl7GauXdBzqb8Eh
	OGr6cgYZOvpg=
X-Received: by 2002:a05:690c:d81:b0:81e:9b09:7210 with SMTP id
 00721157ae682-8973314c2ddmr17556017b3.16.1789843036416; Sat, 19 Sep 2026
 11:37:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-perf-symbol-memory-send-v1-0-1d3360e21f07@uber.com>
 <20260915-perf-symbol-memory-send-v1-2-1d3360e21f07@uber.com> <aquOfdBVYlr1QE8Z@z2>
In-Reply-To: <aquOfdBVYlr1QE8Z@z2>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Sat, 19 Sep 2026 11:37:00 -0700
X-Gm-Features: AcwNN1U0eFlAdN_d2-mxK1SAeqVRyi_pr7YM7LmMviwb1XyNgrHknNMzgmeM3U4
Message-ID: <CA+w=M=S9dWAoPyjuqvErYR684E5jE8AX0p+92Abm8mQBQdebxA@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf script: Add --max-symbol-bytes to bound ELF
 symbol memory
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Andrii Nakryiko <andriin@fb.com>, 
	Alexei Starovoitov <ast@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > The counter includes every symbol__new() allocation, but this patch
> > enforces the limit only in the ELF loader, which is the source of the
> > unbounded memory growth addressed here. In this path, reaching the limit
> > can safely produce [unknown] symbols. Other loaders currently treat a
> > failed symbol allocation as an error. Capping those paths would therefore
> > require separate changes whose complexity may outweigh the potential
> > memory savings.
>
> What's the other loaders you meant?
>
> I don't see it produces [unknown] symbols.  Do you mean it just stops
> loading symbols when it hits the limit?
>

The other loaders are kallsyms, JIT/perf-map, and libbfd. Their
allocations are counted by symbol__new(), but the current patch
enforces the limit only in the libelf loader. I will name those paths
explicitly in v2 of this patch series.

The loader stops adding ELF symbols once the budget is reached and
warns once. Later unresolved IPs are printed as [unknown] by
symbol_fprintf.c:40 when sym is NULL.
