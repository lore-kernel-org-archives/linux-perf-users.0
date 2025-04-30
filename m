Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F3B210FB;
	Wed, 30 Apr 2025 03:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745984277; cv=none; b=SvbvFLrdzYYtKsyDTLxZ1lr5ZWIDvdkW7xy/99Zdf+bOf4XLRI8houzHzW2qAn8u387ldjoOnuUU8Aw7AEhZ7q96NrhIlSb6ldrGi2AM5BjBPgQJwR7WDOrGA34EwznKbwmL+8TW5VVCFr/sCu9KTXk6nK1on6Z/XUpZT2+D0mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745984277; c=relaxed/simple;
	bh=nFGGmJ5/n03v9z1/QgjnpQmz8tz7KZGnHiZq3aSa61o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GrfNWglOVMDIomundDeNtLFwr7eo5a6sLvsQ6LEbw+RNaiDOiJyHuy72aUJhJUf2fSDkeaBHjDhVy+ErzGM9+Y5dz3uIiOZFTHylJGDeaJ5OT6SxJmwaY2+j/Y3eIPS1U4dylfQQJxf5vzb1dgDyUKv/Rzi28SGAXFyn3V3emdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1dl7PyS; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1dl7PyS"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b0b229639e3so718323a12.0;
        Tue, 29 Apr 2025 20:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745984275; x=1746589075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFGGmJ5/n03v9z1/QgjnpQmz8tz7KZGnHiZq3aSa61o=;
        b=H1dl7PySuzs452Mt6XRIuZCVk7yk5FqOS2K0MJsZH6ZxR74l8kZMOxwrinVSE+zIaM
         /QZPkNnuHQI240O0tcUHrVzoMKXUD+ZwWBFCZI7gnonBbc7qW3ieBn5H6jMtBmLQVn2/
         WIBzWglNOF854MMT9JwJWA7n8VAhNx+/tTxsoiY8/uNJifMbNvaQbtOVUHTLPQeX6k+M
         Puc9dOxFT9ceDkYvlNL0WIwyTiI7dqw48W7ObAOORpUy0kzD3mNAO3aXk8qOeINfsPGD
         hKUd07+aqxroh/hyoFcxg59PoyhR61hKpeY9Az6km+iifxPc+r3/yG6aVyHKOat0X6fx
         VFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745984275; x=1746589075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFGGmJ5/n03v9z1/QgjnpQmz8tz7KZGnHiZq3aSa61o=;
        b=UKKqWe04kGJz4LlwJr9iPEyJdmsEis3outPKvvcMWoRNyU23RfqymuB8ztOJhuHXwD
         Mh1KzobV+/oZxlBr3edVuESnnjtTVHAvT08ellLMsxrvT0u+nSYIiq6sIJ7FA+3s3Mti
         J/qLwAAf5eq+xTKjA1GJnaNI3wWBl13Gv4d59rxCPOKnphgt1+u/vjPmwyyGKgH0B252
         Na1N5EXw69dgLR8GToxHbtXdPD2KNyg/4vrI4c/1CtDRim916AnqcLVs6QN0j6IGm8yx
         CRvi9Fz13bUxY2MpeofuiQ+SBg4tVytx4uAz3MbQNM0chEVBF1hDRUmxAOiQ9unzMhzL
         RzKg==
X-Forwarded-Encrypted: i=1; AJvYcCV3A2dljdzG52XjhfbL2lttTgC+cViDKva78ZB1lQEfeyXNGzjxqHKnBGJeRSCwQNbIhhqwylcGC8tz8hM=@vger.kernel.org, AJvYcCVbA6i12I1/xUG+KfBWhrg004b368VTSLpOEfAHAZxF0S0/uJ7SaKG8za+vdfR1pH5pijL6bb0l5ChqFm82fiU=@vger.kernel.org, AJvYcCX0BFWq5I83FlXWTt128nIwIywv78BkgEb8Avb4bnSlieMXMLGz0FEPAhMlUbw7KQKYgszP/2IA8aj68NgZIltcdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZvNQPAlSuzC4tCMMF43qojw4B46/YkpBVNMROD8YYL2HMjHVv
	DPEQNbrnFwZmGNC3UlbsOg6dr1LEXHOtG1ZkmIaAqn7yz6yODSXH6PBKcZwSqTUBoLiNxwEalvK
	bkb+GHldhfaVMNTmTq/g3+DinkOE=
X-Gm-Gg: ASbGncvIsRKdCzGjia32DgVM7yW3lFaHSu7ChkyVyMC+WQ26W1Sz1lDm+mMaO73XZP4
	rQQ0/vKX9WqSgKkEMpNevmQsMcBX7NmrBrguJEHHcXwtIQKfXaDfQlt8loF/E7nqj42fy/ym1Ft
	V6qWl8UdRAvqmbpyEm5fBnwg==
X-Google-Smtp-Source: AGHT+IGeL4q3Sdp0CYP9/FmEFq3Sy3JI7KbV2ri0jrVCotH/QaRkIFoag3MCddg/nXXdBUd3LyaNFbeyeJgjrqZdu9s=
X-Received: by 2002:a17:90b:1e05:b0:306:b593:4551 with SMTP id
 98e67ed59e1d1-30a34a96d45mr481543a91.6.1745984274894; Tue, 29 Apr 2025
 20:37:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430004128.474388-1-irogers@google.com> <20250430004128.474388-2-irogers@google.com>
In-Reply-To: <20250430004128.474388-2-irogers@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 30 Apr 2025 05:37:42 +0200
X-Gm-Features: ATxdqUGa7WM7kfr9cHYmn3SM4PPOkRBfwRxxJYsjswOMOQKEEXrxM_mPUUtmvvg
Message-ID: <CANiq72ksEJdnT86V42hoNVfB7OpmaouD+eBQwpRJR899nPsttA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] perf demangle-rust: Add rustc-demangle C demangler
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev, Daniel Xu <dxu@dxuuu.xyz>, 
	Ariel Ben-Yehuda <ariel.byd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 2:41=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> Imported at commit 80e40f57d99f ("add comment about finding latest
> version of code") from:
> https://github.com/rust-lang/rustc-demangle/blob/main/crates/native-c/src=
/demangle.c
> https://github.com/rust-lang/rustc-demangle/blob/main/crates/native-c/inc=
lude/demangle.h
>
> There is discussion of this issue motivating the import in:
> https://github.com/rust-lang/rust/issues/60705
> https://lore.kernel.org/lkml/20250129193037.573431-1-irogers@google.com/
>
> The SPDX lines reflect the dual license Apache-2 or MIT in:
> https://github.com/rust-lang/rustc-demangle/blob/main/README.md
> Following Migual Ojeda's suggestion comments were added on copyright
> and keeping the code in sync with upstream.

Thanks! I doubled-checked that the files added here are essentially
equal to upstream, modulo trailing whitespace cleanups, the header
addition and the change to the include name, so:

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

(Typo on "Migual", but I don't mind it -- it sounds like "M-equal" :)

Cheers,
Miguel
