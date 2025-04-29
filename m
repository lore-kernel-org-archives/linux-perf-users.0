Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCC51E89C;
	Tue, 29 Apr 2025 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745955681; cv=none; b=WM6RjbBC2/EABNe71DksRXn4PK7JfED87vXbGORivyvBmyo3Jb5ZzKpN2kMXhEk56yq3cYQwbGHTCzDgd7Lu3QivLT9XC2KFBnsa6zLmaJJ+LXgdpaYHzOXklfLTWlaJNptV3m0fWTi0zlf/vXq3mBqfbcMQkixs/+6Luhkk36A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745955681; c=relaxed/simple;
	bh=emoQcqlb+HW2sgPwTA9ftx2rqI7sEqj4UbrS4WjRv2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mv4eWWySFmNOR0EwZCH00jhIVO4DkH+OUMDaGMtC7sCnN0/NdXa+FTeRxzo6gxAtx2suOfVKTjZOUKc0S7Ab8NH+Me0+zDKWAApYHE1W/o8yUZ1t8BGaiys7NcWbZCPPIt2796V1okgIy8h1xOv+5ozx+YIbd1N2L65OAeJpD7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzMg4cFG; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzMg4cFG"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ff67f44fcaso511603a91.3;
        Tue, 29 Apr 2025 12:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745955679; x=1746560479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emoQcqlb+HW2sgPwTA9ftx2rqI7sEqj4UbrS4WjRv2c=;
        b=RzMg4cFGJWX5tVv/R61Nqw+p7bvw2F60YrTU6bQozIwrXN3TMbNSh64/9rcFgz47iu
         pfcXkmLoYrEK0xrERhu7JU8VjYJ1Iyc2gAEtFGboOCbd9KSRv+La53zdhFkUG55W237Q
         uCzqv7AkYeRh4dUyw2L34h3dXlB0hwvLIxA9AOYUJvD6v8w2MmoskDulZdjcSsp1ilWF
         lJPDD/pvtbxayeiBVsHrsWNAUWIFxxi4zfee85BqXKaZGJKn+1nm9TXmZFE19DvvCF7G
         Le8dUinuHf0ANew0xrPZzA4P8aen3zUPUKfdItP4p6UscMN7PfMHCXSFb1feRevsWzBN
         unRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745955679; x=1746560479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emoQcqlb+HW2sgPwTA9ftx2rqI7sEqj4UbrS4WjRv2c=;
        b=Yhf9Gxup3JWV/a2tslLI1cqidqMJ8IDf0CIcqtRWEaA92vyBUcUNLS5WNvpFic8JvW
         QPHut1mST7HTGwPNNShrR1KP9RqA4JrC9kYnuZCIQL1lknqNXivWmIvivPI0fl5iWdmD
         4cXJrj//lKn9YXiT87QcZw6FAnWInRi855yfG7yd9O5QK4EP6s2B1kZcrPqMsLLhV1+e
         2K5ACaSOrco602bfxS8y1+1QRx38KgkD80CcXOnnMYEIB174jOvkma0ytq1ivhd84ucY
         PtIZGCRnwO0iMdLmRmzAHDbS1nkzoBw5Vw6LBANZ0GBnklw760NONR/0VFQ0YOxv2NcY
         Qwaw==
X-Forwarded-Encrypted: i=1; AJvYcCUMC/sKG85IGrCdzXzwWn1l38dHdGSrzjmr8sD45QESY3h8zkQvBTF0n42Xw0iI8tTvoyv6k3WBWoSP8Y5I8NBXNQ==@vger.kernel.org, AJvYcCV//kHAiPk+oAVCPiILlD/BCGFa1LiY5sjd1qaoCkVaCpd0amInKlWKj1GwHDJ3hMObwnULqSmD+1BMeKPogJw=@vger.kernel.org, AJvYcCW97Ui2RVbKCYNZN9wBW1u2jb1CzzwkByoROD2UJn0z7jmvqZRD1FMNyZSD8ukSgyEmVoEsBUYA+CSxTuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPnRJKmvPtYYcoVAPdzQY3WklXGrb7V1Ba16IjWQMAqGacjBU1
	PjufrCbUNhUdhgKrEyrwp/APyBhQ5Y7Q7knI7xer+Rm0LGEw0arskmWylfENCtou4RAhgm7pbBN
	r0Ld2qBgP7QeLiDe78Saq5FiVAbE=
X-Gm-Gg: ASbGncurXGEn//dwz3l0ki6TKVbgNb4rvXzfBqPBCxVwkVzLJkn2C+7ahi0A8t4ko4I
	dLdv9gy6L5BiOwD3KrU2CAN71GtOdOC8P44Qk22XTVlAQ8LTy0lMwoM4IJup9hRxGA6sHpxnYQt
	wnRmnsc4vqvrJGDpwjDOU7tP62v0LCcRbm
X-Google-Smtp-Source: AGHT+IEsz/JWpYHIQB2ND8TAPWjryOqVEs6NcRyR9v4Xj2Udz+EeqWASFStYh1DEZBXGsTgzXSaBNResIErXGEAwKsg=
X-Received: by 2002:a17:90b:1643:b0:2ff:7b41:c3cf with SMTP id
 98e67ed59e1d1-30a333530efmr190898a91.4.1745955679171; Tue, 29 Apr 2025
 12:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429185839.1807005-1-irogers@google.com> <20250429185839.1807005-5-irogers@google.com>
In-Reply-To: <20250429185839.1807005-5-irogers@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 29 Apr 2025 21:41:07 +0200
X-Gm-Features: ATxdqUGjrsQgDER8osuejNAHo00_Sx94goMIQhOsN8FiYorxUkXhdheN2z5OT-A
Message-ID: <CANiq72kF+XFFMzFYV_O6kVK1oEaWca5iw4r6f8CU9OvSnRMzfg@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] perf test demangle-rust: Add Rust demangling test
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
	llvm@lists.linux.dev, Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 8:59=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> The test cases are listed examples in:
> https://doc.rust-lang.org/rustc/symbol-mangling/v0.html
>
> This test was previously part of a different Rust v0 demangler:
> https://lore.kernel.org/lkml/20250129193037.573431-1-irogers@google.com/

Hmm... this sounds like it comes from the previous demangler, but it
isn't in-tree, right?

I don't know if reusing those examples count as "code" or not, but
just in case: the docs (and the original RFC) seem to be under
Apache/MIT like the rest.

Thanks!

Cheers,
Miguel
