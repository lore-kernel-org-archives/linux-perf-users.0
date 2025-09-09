Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1207285071
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Sep 2025 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417217; cv=none; b=ERroZFFKdV3svGJ2TE6BOwoZDpbLR9AH3fM5EgC4qg9CPawaFhK6alwavwv5OVK44WFghsYArO7osNJGpcayKenOPqhNyMf41Xrk/qnvjNoZ5NEuXcFbDQjRAXQOhZA/FCadEMGwx75hiCHpfXMFqqBKsp9NdCB/KUO7lSUmTSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417217; c=relaxed/simple;
	bh=c+ptnOyAm3jUIUln5KuULPwP/29EvnP8THI8ZxcBLg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NUE/LTLSGCIf2ErhXKmG75/VRGqz/OBRkUoovYQ54rm2dWM4+GN8vQOO4ICcgHoQM2QEfIEXJVaSLFWzM45wkvPWz+pVFYJYr+Qm7teDE5g6QFlOCRgF/nbRrxDGe+rw/tMw3atr0zp3h3ITzKAbfdvzED/9zHxciRNosUILJWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJ9JhkZT; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJ9JhkZT"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4741e1cde5so597069a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Sep 2025 04:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757417215; x=1758022015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+ptnOyAm3jUIUln5KuULPwP/29EvnP8THI8ZxcBLg8=;
        b=jJ9JhkZT4QWT5zTpOCK4kMbMWRGtV20piCNhFBgYjepihWvea2byMS5GLmtKCVT7Um
         WhUJv3LvdPCFHCJb182wKIph6rM8h7HMs0QgszKPobhweRSGfoGjxUp0m177MyaOK2nl
         8ZPvp+rgXtX14tKXEitzmy/sAMWSUBfSXwjWlMrnL1jUPriQPHUvH5Y5w62HvgEH5Hr6
         CwYq3YpnOc7MsLUSCY8LXgleqD+6rqw7IuLAIQYMebaRaFJ0FlydDJWlw78w51NtEjPb
         3Tc/6Pp10zFS+RmBMFnfYCfeoplybZV/tA1N52gG6WVhX/deWK/J/Ix3TwksXpz5IQag
         cwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757417215; x=1758022015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+ptnOyAm3jUIUln5KuULPwP/29EvnP8THI8ZxcBLg8=;
        b=OYuuI2GyAD20R1y588yxfdq6SXTOzhAemkFFxrS/3NWVe8Ec4VknpOYQKZD7Rf4Du9
         u/bYSEb6eXEcsxrnvMZiM+ckxgcSSieDTQCNtPNCHYSA6zadl/Ptj/AUXUakIFIJmSbT
         YF8G5eEv3dGHwBeuczxNGFWpDfzhwpnWDVBXdGQBL0sDx8HQZx1tQyQG2s3pczQa4Hvz
         Od9T6NFCGiIaZkykuNwjkR0Q4ECIPOKSgsS6zpWRtz/ZsWRcHXSo79jt/zXBHW2+2k3e
         pI7+FVVTQSm0gnW8Z+lpHIOL3/SxUIkkgvN+7e2tunRDMRHwyA8KhlPJZl8D/JbFHQM9
         Se6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPo4PCfPEJ5sdSItxMl2iMp/vkF3IQwaAb+o0o325kmDE5HeBmwCfOA7MkCSBjQga85IEVHgT1TBCP/IBSJnng@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5pS+wYzMrAl0uJw2SarQOBpGrb2ZLcW0wCtnE+ybm1dAsNyT8
	m6ZnJYYtH2TMihmMk027xHxAFQBboPvC3KtNlqXjZP1jgBduD2Z0qqOh3fsChI/zhe5trvoCc1V
	Y2z8+Xya4ND8n2nj2T+GWeCnDnfN6JYc=
X-Gm-Gg: ASbGncsSv5bqogORSm92ElbbdRX5Lat/Xz1AFkm1eNrxXfurnZzIgeAxDu64uq3lZT3
	H3qWRK+9Cys6VOLjuZWgafUUWRxM7Ow4BTDVJMVWHn0IBwRM7QtjPp0gpIvryL6YJ8YhZTTeqrF
	DhU73zMmc5/PtcuuiNcxwG7TebntnIUuoZmMT62Ni6ALMq4SsBcHI0J/H4lo7CzQsmK8BcefP3s
	dA6v6BHzY5XQklg/AKOzePB2HCKe+S5n3LyUQFBkviNO4/+19R9XYsL4r2F92uGyDqduo7VBS3h
	YzlISDhDzccNreSlui62uDC2xQ==
X-Google-Smtp-Source: AGHT+IHq6LxauZ4W7XVEaPw5eeAmvgO7uHid3sBeb2MBggW4s5U8nrTwtThoBWZwkRM8YjaKlKGX/jYtu36SsSGL5YE=
X-Received: by 2002:a17:90b:38cb:b0:32b:dcef:f65f with SMTP id
 98e67ed59e1d1-32d43f772e8mr7977540a91.3.1757417215077; Tue, 09 Sep 2025
 04:26:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aL9Ch_XaYTxMzFXK@x1> <CANiq72=6yb5PZnuPYX3xWAms6pfYmfpoPj-GE1AZv7OfxcROJA@mail.gmail.com>
 <0633E365-72E2-47B9-B6DE-99E05D1E729A@gmail.com>
In-Reply-To: <0633E365-72E2-47B9-B6DE-99E05D1E729A@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Sep 2025 13:26:42 +0200
X-Gm-Features: AS18NWBtwT21xFJ4tCPAlJTc6pRxR63ipRI4okv-GtO4w11-zahOibO8PV59FvQ
Message-ID: <CANiq72mhca5DF__uJt2N5uK=j7iA8Hn6vqr5si_5sa_15T3qpQ@mail.gmail.com>
Subject: Re: [PATCH next 1/1] perf symbols: Handle 'N' symbols in /proc/kallsyms
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jocelyn Falempe <jfalempe@redhat.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ian Rogers <irogers@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	rust-for-linux <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 1:17=E2=80=AFPM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Nope, there are 2 lines in the commit message, both zeroed as I did it as=
 !root, I can see them as root.

Not sure I follow -- what I meant was whether you saw other `N`
symbols apart from that one (and its `__pfx_` prefixed variant).

Thanks!

Cheers,
Miguel
