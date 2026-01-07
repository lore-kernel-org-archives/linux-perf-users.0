Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140B53093C4
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Jan 2026 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767787203; cv=none; b=L/0mvld+gCOt9N52NQb6w86MhcUn2IWzU34VKOuR0etFApu85HTrVHTftDYJ2Ql6HZPldSmwDXQm7PmlxAbWxPLgx12F0W1r6YZ77Hdfa9twac/fRqG9A3LFptlLBzZbtOMEyxW1mtP7eEY+PC1X4c3B5ZPEFfqPT+toRMADFko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767787203; c=relaxed/simple;
	bh=TfMWykcf+8UXGfHGmT9UsPj0B1MObIutniI9d+Q2eso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txe39kkSbAalyi7As0dzETgsV2ATwIKLvRfmK8LCFUbV25880svZwiMGaZpnJfyzpEck4e8Ao2TdTtC1vXe5N4tyVn3++N4A2E0NAyzv4qPzyfQzq7rHEqOOcByCJolaVlHS8QZhpgkjOxXfm9pKAxVfqYtqvTrqDIeh9eS9sP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EX8j8UxM; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EX8j8UxM"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12179b87349so117815c88.2
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Jan 2026 04:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767787201; x=1768392001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvnLNPW39tzQQ3hSPGDk4srbtyERtKsm0TVoURbB78I=;
        b=EX8j8UxMGHbulHkJx7eAVFqJ7p2vos0yDKsXal3B9yXyjGot8VTdv62A40SgDKK5bS
         /IHQZm8rZKVeDecyoN4xG6EIWbiUO0rQ9QW0Tumyl26zTz+3aIVg0cIwRoyUIzoLVQlY
         lx1WrJO4ANMtWCmsnPdtD/CsaZCOFxTq/ecHc1nOEgJNSvsQuWESvv5Zi+A3M0wspM+4
         qFPn3HCR6sHaGSf165DRysgp822IeaJ0PRsTfkwzqBsGZnA9tzZnsHeEZ7in5lYvZleR
         nNTPxVmpVDn5pp+l+A8WlMBTJyCWbIkoSIDlxBRofVoFqod/RW1J/miRS0Vj7MQZLNJD
         CYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767787201; x=1768392001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IvnLNPW39tzQQ3hSPGDk4srbtyERtKsm0TVoURbB78I=;
        b=jJ/Vj/vus1Buq7xnerbdgYe2UTzrWIapc41bV4ZNI7uC2Fp1zgI/DTC7JZ2uvKV3Hq
         V+GXzSZuBGMP1m7n6hC/p2Ven8ev7FWkLjINco47UAsxHJBDzVxDlU9nIHzG4Ggczk/D
         dYM78O6CQS/suErfGD2/kzswAb7T82iU3S2Zm/nsnIH4Oj+wBVN08gn7uXUjAm7mVHaO
         2UvOM6kTqvwhCu6OZ54+HJ41dMdSvKAMyEK8zN6gn6jJARn45jtR+kPiN5uT718g7yzk
         X+0eibW8nTO1ESeCxJcPfGZLRUH2jQ1eP234/s3z0cBUpdOYzrW5XA4Tw9+m64/bVuOS
         aVPg==
X-Forwarded-Encrypted: i=1; AJvYcCU5kKxpQzd3++/tRNtPA+K0lJqFMrEsI2Spqavw7zbfiqyR8mW0tYoo0P2IVtla+UFmIKPjKtaZqpn8glqnm/OL@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm1OxsDnDhQc8ELrJsh0/tt4mMA3LokKoc6tDTnqIGklj+1wdq
	iOJBEGvz5tlSEiGT9xwgxk43hzVAMlaLXrjssrgMD4aieym/KqiAc68wt4nxVhwn9WEOX8C/VAF
	YIg6VN7r7wxOvnSVLqxtwb3oEzKxdET0=
X-Gm-Gg: AY/fxX4bStIFLXhIJwdzIrXcuRU+nidaPCdm6oiWuEsIMhzvRmX/Vd94CutGr3cKNK6
	sbUAl237dn4RyU0HRhzasLy4DZqJdNpjFAfXPUdVp6ET1ql67TwQi5XV0KpEwocziYkBANvkRGz
	r8gWbu8arLIuIZs7bLi4VBC8AlLs3IWdTCd0TasduTfx9IixCkurDSjB7wLuWBJXGkljH1vbKaO
	rLd3bg9p1A/hbGAD/NyFQKx0CNy7hnYQkuSX8JKRR4Ic1p9ApA9Gxtase4vXd+8LBocyqsyHbgw
	BEpBduzs6wqMJ6rlvbDk7GLvKYWQkrgAmbC12/Srld6A2V+9VZVppTEQwv3tdphrvuQj685XTQq
	hR1WraIxpexnn
X-Google-Smtp-Source: AGHT+IHl2VXT8tuqTG18KAX87XjyJCanrQuK31sAG/wWGLYWMCAEZ3iuh0hHmV4OVYAR5S0P8i88XR+h9IHEV+IH9n8=
X-Received: by 2002:a05:7301:4288:b0:2a4:3592:cf89 with SMTP id
 5a478bee46e88-2b17d0d4b88mr704118eec.0.1767787200933; Wed, 07 Jan 2026
 04:00:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105150106.567830-1-gary@kernel.org> <aVvdt90YmhJz3i5i@x1> <aV4TkNE_hAyByISq@google.com>
In-Reply-To: <aV4TkNE_hAyByISq@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 7 Jan 2026 12:59:48 +0100
X-Gm-Features: AQt7F2qCZtVjBpQW4g-uNITeBCmbGHFYwnjYgECDW25Z8q9F1kvT6B953AVTAIo
Message-ID: <CANiq72kUVvMznfFtcjks=0iJ7HE2uvCSyD-Xu5NV=_9ZykVXhg@mail.gmail.com>
Subject: Re: [PATCH v2] perf symbol: remove Rust symbol workarounds
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Gary Guo <gary@garyguo.net>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 9:04=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> I'm afraid there may be some outdated kernels which don't have the fix
> yet.  Maybe make sense to wait some more time for them to disappear?

Hmm... Do you mean that someone would use a new perf with an old
kernel? Is that supported etc.?

In any case, the fix is getting backported all the way to 6.1.y, i.e.
all the supported LTSs:

    761e965d2c61 ("kallsyms: Fix wrong "big" kernel symbol type read
from procfs")
    d5fe0c115bbc ("kallsyms: Fix wrong "big" kernel symbol type read
from procfs")
    d46ef2bf91ef ("kallsyms: Fix wrong "big" kernel symbol type read
from procfs")

And the one in this thread could in principle be backported too to
6.18.y now that the fix is there, no?

Thanks!

Cheers,
Miguel
