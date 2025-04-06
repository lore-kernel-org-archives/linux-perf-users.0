Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C446B13D89D;
	Sun,  6 Apr 2025 22:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743980056; cv=none; b=DGU5twsksdiQLhTEi7JWtEAVzKTLLaPsGdX4NG0lc9WK9VKOs/Qwn+lmI6lPKX9GbTluFtrZqJUWeYq83kfHDI6LAnfoOIJSoCc4jFg5V8PG+gZmXO5XnfsVngiREz9pxcgpEsycutM337Byi5f9oVtgL7+TgX0OhYmy1H5Nw4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743980056; c=relaxed/simple;
	bh=/G7yUcGfZAsiUzfpwKkC+MKXUgb95tffKECR0zY7QYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HolG4kP1sAbC2fnicCEsv7PMu1PXGmRbr6bNXPWm2oGYsN5Rd9XtjwdQ7Ob4qM3xUoy6Y8+4rZP8c3ws88umk4/L92tcHU7sTicpKqh3rJ9ISrxElqBIL8rMniRz2P2UdpRSH4qYMjEOkweFxKPbz3TyBlPtm6GymjDl0aQovmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+/Fgn4b; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+/Fgn4b"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9ebdfso7923936a12.3;
        Sun, 06 Apr 2025 15:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743980053; x=1744584853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/G7yUcGfZAsiUzfpwKkC+MKXUgb95tffKECR0zY7QYc=;
        b=G+/Fgn4bkq+l8Vvc+Z9Zj3BjWp9HK/pqZiVzQWv7fvvgZQDTwnzCZag/gLlnV6Ia2m
         KMfbafqEcKXjkUK/2M7+m0MlwQaGR2Mq4H40CBpVGDcQNiRh7faq5ljtFnoL2SqIW4UG
         mU7X2I/QjCTFBVmXvsIUzFMgbJGZMjxcqFI+8W85Xxz4YCjoOlxz/dDPH3wHMYPcHwOd
         i7gpmG9JtcEZpOqVFOvnVSo5IxwnC19iY1eayc1mfw65O0WEo/m5c+TbK26aurrTZF8c
         oq+0VCsMuearGsC3CuSLSU5kR72qQnjX2eNZgv8urlilEJiz7UZwxzPx3DxzNjXD9Zlr
         FPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743980053; x=1744584853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/G7yUcGfZAsiUzfpwKkC+MKXUgb95tffKECR0zY7QYc=;
        b=TYGKj46m0cA0eW4FAgj2ra+ptD1f5/D6bUXxqIr1z5rZzF/ZIKTyrFLh4tRe4Cf+Tu
         i6RXhYi4osPp7qEbmakA5ZJT9AAuitJdrwDEzNjAI37jLtnJG+OgTgyqc/UH2WGc6eGz
         45AyEdyzB6kzR2nM8bWzGJfZ7mVXc2/3FKF/YaBnVZWYau7B9+9KLQqjVMtqY6sRw8iZ
         DU3sFuj1q1ZT7M5DkrVdQE96VLTH5vaD8R12Jr4ElfVXNIaOHu7XhPzXNkD/k9Uk1baG
         78mHaRODEc/uxlghiaTH4089sOv/n5g0dkyvG3LHTOTa+u90zBC6ODGY2Tqk8N9VpsyS
         JVDg==
X-Forwarded-Encrypted: i=1; AJvYcCU39pIGu2WXUfzxSaM7zP5ZgNPBvZLnnFxWOTaTmmOPWYHCp9hdyeZiAkeuwjcQsqqnINIpTv5zVpN6YFsqrMXDUA==@vger.kernel.org, AJvYcCUI9VRsFwHxTvS597XYe69sUyEJqOvdv/KQlzMO9xZtwB1pr8VkKUHQO1fRtAW7BTrxr7MXxNI4/f/0qN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzviU3jEcAXPKo1hb5saRRAELh4KIKjlC9SUO7YycamEiel7xsX
	4tqcoylU5COzbHy5g+5U61JeleqLO2tjkqyym/xG8T8/RF/8+w6xJwFgnOOjznkcxUfrqqtkXFh
	pxvHO0Vetxe8psDeXbD0+JCaXZvs=
X-Gm-Gg: ASbGnct4ZudeJd8wvOcdfLFopH4j+2N4dOEvb0AYCP9bGjCowvtQXho1K3CRNMBoeyz
	31eGZF8wqOPyZJqyTY634SeeCPm5IvHvxQE0XLzZnuV9vmZ4DSt+UWwWqemcu6nB1u6dJoBNBwN
	P0T4r3soMukE7SEbmygyTMSM9LrTM=
X-Google-Smtp-Source: AGHT+IEaBtlMBCdqu6/itEb3Hkc+hSQYaA2lNBSHPLLKXgKx35wbmfecZWSnF5/5LT+zSplLR8i/9w+ew1uxylu6BWE=
X-Received: by 2002:a05:6402:5194:b0:5e7:b02b:6430 with SMTP id
 4fb4d7f45d1cf-5f0b45001b9mr8567359a12.23.1743980052906; Sun, 06 Apr 2025
 15:54:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250405031213.3502708-1-howardchu95@gmail.com>
In-Reply-To: <20250405031213.3502708-1-howardchu95@gmail.com>
From: =?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>
Date: Mon, 7 Apr 2025 00:54:01 +0200
X-Gm-Features: ATxdqUGmYFqAvTEi4Mi0RApnU82yKjwFCI9DpcUhJAeWvWdjAmd3COIRdZJJs_g
Message-ID: <CAOQCU653Y1SE1wQbL-qkMo1H0GemfT3tiN8JbJKujh9Hb1a-UA@mail.gmail.com>
Subject: Re: [PATCH v1] perf trace: Speed up startup time by bypassing the
 creation of kernel maps
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, james.clark@linaro.org, charlie@rivosinc.com, 
	mpetlan@redhat.com, vmolnaro@redhat.com, linux@treblig.org, 
	mhiramat@kernel.org, leo.yan@arm.com, dima@secretsauce.net, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Howard,
I much appreciate your work.

> I also want to express my gratitude to Krzysztof =C5=81opatowski=E2=80=94=
his
> profiling of the perf trace [1] inspired this patch.

:-)

> I'm not sure why the discussion stalled, and I apologize for
> not being able to answer his questions.

I believe the conversation stalled because it touched a piece of code that
has been forgotten/abandoned.
Perhaps because the mechanism of setting trampolines in the kernel changed.
I'm not sure about that.

> Since his findings significantly improve the startup time of
> perf trace, I don't want to take credit for that.
> So Krzysztof, please let me know if you'd like a Suggested-by:
> or anything else.

I'd appreciate a Suggested-by: credit.

A while ago I also tried to refactor perf's code to improve the startup
time even more by merging all invocations of kallsyms__parse.
I gave up on that for now.

But I also investigated the possibility of removing dependency on
/proc/kallsyms. You can find my findings in [2].

Basic idea is to use a built-in feature of printk [3].
We can use this either in a custom kernel module or
(in a limited way) in an eBPF program to get name of a kernel symbol
on demand from raw kpointer.

It's a question to the more knowledgeable programmers here if such an
approach could work in perf? I didn't share it here before because
I hoped to get some feedback from the BCC guys first.

Best regards,
Krzysztof

[1]: https://lore.kernel.org/linux-perf-users/CAOQCU67EsHyw_FsqGbRuityahZTS=
AtWzffU=3DhLUJ7K=3DaZ=3D1hhA@mail.gmail.com/
[2]: https://github.com/iovisor/bcc/pull/5217
[3]: https://docs.kernel.org/core-api/printk-formats.html#symbols-function-=
pointers
