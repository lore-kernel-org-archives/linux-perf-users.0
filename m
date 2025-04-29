Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7608021ABC6;
	Tue, 29 Apr 2025 19:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745955198; cv=none; b=Fi22UWItiRzGZAQSUNHQgAhvQGAsSVYqKZUjZa9lU+Gvhgzd1FYRhuab4IsCrcO+ScIjdsp4O22XNfvmtOe7OdF3kcQQp7jOJ73ptyC2qAbbcScDHpki/JBup+UmCzYBrlc/65RvbScSatbSXB+/sZDvW2bfqRn72/zR9Zm4oKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745955198; c=relaxed/simple;
	bh=t/TaDhTEiYr8JZ9az+xPIoer1kKQ0EqLa+WBBbutaGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iqr/4DSGWAbeLkj7h7dGniwxuLzpg3DSCQiGF1v6NblbE74bhaXtNKsWz3QBzzJSpT+b5iWhcvjLLf1uX0d2tXSq7+Zl8y7stF/lMzwLo5lyM0ff9/wjWcwgbJH+DmJo2DQH8yh/MDukZlAgN7kAwh7wLIAdgK/VN/yZ8uPkeyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JInmPKz9; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JInmPKz9"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ff67f44fcaso510783a91.3;
        Tue, 29 Apr 2025 12:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745955197; x=1746559997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+6R87BCw+XZw8t56W3vKaa9E85JmDHuUT63nFr7qjY=;
        b=JInmPKz9DDPU/Tl7tY7inxgquEZA0TO6okGYlsAN/MgafpJWsiS3P4uBBXVkmQUfKU
         C0ktAoFRurADbh2jxFkvQt4GdBnann+OeyENrPqOcEab+j0izN1akUN/6MPPAOkSTz2H
         D5vhRwRRE0mdrcYcwRacivTqCmsEHjXnCU19sOmnWUrPN2+yGovmCDacKCON3DYOZ39T
         N9SQ3CMH0GfglI8xgKs/hpNXsNyayHp5pTX9ugZ/CLvFxfsDlkPYm35AXSrS4DQF+rty
         9YP6f/7XAzqrYSLO4/c/CmhkLn4eA4M1xcB4DCr24kqUmbjuiE9uwbFmNWCgJ+lX+OLP
         K6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745955197; x=1746559997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+6R87BCw+XZw8t56W3vKaa9E85JmDHuUT63nFr7qjY=;
        b=Hyo7nPS8J+7zY3mjiEv1U7ZENtjrOsjkMDiEiH7BYHlFr/CQmwxWFFfGuAEn4rogeg
         3FbgZK53hwuQqmblQBbOt9MJOaYL10UToA4WmquxfSuH69A3HyBAbwQOEEOG3FysNtz8
         sLzTuyLUIBSi3PUNR/qSLD/biGRVncDXJvgz/6xsJPw5/ydLT76BeRg6/KYfhCvV6mtP
         lVsHQD9gZXmpkaNugTMY+qeGgrpYhqQE0N8wOXNor93po7cYO2axoAvkIM7vULXyFXF9
         8qb//vSBkGFrT4tl3Bbt9gah4Pz2af1pGb1qKe38rr2yHdTy//vRucIgYoine3vsUZ06
         2KEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVavlhX7bjQWAzOVlwFFuVd3gBxG4F8zYUfjNPoF762GPsXQ4jJwo6cuZCYH/ep/CUJgHV1CrUzL1s7fatbIAwSEw==@vger.kernel.org, AJvYcCVmCJRi4YA1xfIsvzQa8Cd8Pr+gB0gTXSwNKgNUM7HzN0UvwB1pumjq5wsroBez+alSIFOqvA5u6m53XkI=@vger.kernel.org, AJvYcCXGd6rdWvnFWDIGiNaPPfN54uBFRIsTfQUkMiYCvpUSuP+9JotzOwlnMRGpqTVE2sRno3UaO6DeipNk7VJC/aA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx80DRi5eLd7GZvXMgJ1RSJS6XVgiEfhK9/yGijU991IPKpWKzn
	/BKu3FxRAghP7fZOyovSqgpD5ZstwqxEb10PpAZ775goxsgVCJE4gu6O2hvSwSdCtTIli4SOUNU
	CbypEic8fB2YIMzdqw2XdAII5Sk8=
X-Gm-Gg: ASbGncvDBIxL2HszPCw3hy2it3GheEf2D03FX3ungCu7vMiKLfmVPXt2fPKgEQBDO3R
	qpzHrKWgX0vHSZCMoYsjrywjLJlaMFN+gHSLjzIQWpvY+wVUNu/4wvzM3DVlZTzQ6bjMxKiSZOx
	yUmVuP+jF/Nfuv3OGtUFT4Nw==
X-Google-Smtp-Source: AGHT+IGQqF75KnMv+4bVCZkAaU+P9VRF9V2GaCglJcEOLFkIoEF/9gIcBxqPqDF/usHsH68nxd+NNiRHshS5SL0h1Xo=
X-Received: by 2002:a17:90b:3b91:b0:2ff:6bcf:5411 with SMTP id
 98e67ed59e1d1-30a332d60e6mr187967a91.1.1745955196640; Tue, 29 Apr 2025
 12:33:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429185839.1807005-1-irogers@google.com> <20250429185839.1807005-2-irogers@google.com>
In-Reply-To: <20250429185839.1807005-2-irogers@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 29 Apr 2025 21:33:03 +0200
X-Gm-Features: ATxdqUF8JMzltITilMhWL094El5ZtueGDzQXtv_0-w06j1KIuKQGPrNQhTePM5Q
Message-ID: <CANiq72kDkPgXS2SasysSa0MXX68kkkhYbSpvK9KAYxFbEKpLig@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] perf demangle-rust: Add rustc-demangle C demangler
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

On Tue, Apr 29, 2025 at 8:59=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Imported at 80e40f5 from:

I would suggest using the usual commit reference format:

    commit 80e40f57d99f ("add comment about finding latest version of code"=
)

> The files are renamed as perf supports multiple demanglers and so
> demangle as a name would be overloaded.
>
> The work here was done by github.com/arielb1 and I am merely importing
> it as discussed in the rust-lang issue.

Cc: Ariel Ben-Yehuda <ariel.byd@gmail.com>

> +// SPDX-License-Identifier: (Apache-2.0 OR MIT)

Hmm... The documentation is unclear, but I don't think parenthesis are
needed (the docs have examples without them and for this particular
pair we do not use them elsewhere).

> +// Code for demangling Rust symbols. This code is mostly
> +// a line-by-line translation of the Rust code in `rustc-demangle`.
> +
> +// you can find the latest version of this code in https://github.com/ru=
st-lang/rustc-demangle

Ideally, above this, i.e. before the original file starts, we could
have something like we have for other vendored code, e.g. what we
wrote elsewhere for some code from the standard library:

    //! The contents of this file come from the Rust standard library, host=
ed in
    //! the <https://github.com/rust-lang/rust> repository, licensed under
    //! "Apache-2.0 OR MIT" and adapted for kernel use. For copyright detai=
ls,
    //! see <https://github.com/rust-lang/rust/blob/master/COPYRIGHT>.

(And then below the actual file)

It wouldn't hurt to mention also something like we did for `alloc`:

    Please note that these files should be kept as close as possible to
    upstream.

I hope that helps!

Cheers,
Miguel
