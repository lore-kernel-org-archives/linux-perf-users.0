Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4E0334C26
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Dec 2025 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766569414; cv=none; b=c5xM/Fv73IvumUJxLd7OpGWQ+EtfiLfcq6DCreWtLPJr25J3YH/FEArEE/t0bCeITyMbtWc7Ueq90U6Y7tyWCFg4K1bxLTJwlOw7UWH34XBazkdLScb2vKtWRqdmJPuUwGLGoTyQ8jcNKl/oAod9BgWyICSCcGoqS53FMg0ds6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766569414; c=relaxed/simple;
	bh=AXrA3sRJwnZgC6dfkQwPIf3oBdpxwqAB6RNtrpM7rKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KXJQlebPz1443sUdwqLuV00bRhOygioashUC8hJVCmbf0+BRJIVpJitn/u1kqb6EvHF46xNORSTprRp53QaHk5SnrdyTdr4n+CHRGERyB5QmXDg7mPaih5rCgeTtMJojoJYCIc1qAQfp2qsGRq/wV7c/OvzatXp9CcUFraRI0+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8YBJxky; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8YBJxky"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a07fb1527cso13635125ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Dec 2025 01:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766569412; x=1767174212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zE5g/APfOf7Doh4n8+ohsSXdsPUU5o9q9e6BCGyON8I=;
        b=E8YBJxkyKDcchRMTyOrg02k2SOOu18ZatgDsMvIJmHbwg8sPtMp6V8zLAKsh6F5yi1
         p6l5zT17BOG7cYR/LtE6tkBNiybzzh9bXFPxfOuDXj9Wt52908wqTOmlt6kqwl02IkAW
         5zZfep/sm1JBcWg6lZMZYrhgo9be8qrwJZmLGIvgCEKHDSLX9eJMbHf+9h1FykXVOz0u
         qob7aKi1olUGKpqBWHQwaCVeAWePfafeHZrHYqytEIeXQOyHu7ct76CF0kLZAWic1sS+
         i3o5TvWPHMM2Y4wBGlyj/5XBUGWT/R6MoJtVOm+8KMXmk6dimleDIekHNuaObRb3pD4K
         q6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766569412; x=1767174212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zE5g/APfOf7Doh4n8+ohsSXdsPUU5o9q9e6BCGyON8I=;
        b=QQFDuOpfEAc37JQN7Hu1Bc8O5MKHMztskNkIWdKDiUPtD6PjBJFz5BCBJVkD74k9bx
         oLp69aIuxQVgrwuCXr4OwcG1/MVufZ1VhD36LBnIVtmu6d39SIKp3VN9Tlr7WtgMAGbv
         6+slSui3R6FSVjDycZ6eDWEIBxze/7z+F3ShGZznxLzLXP/0ro+T0vBANQRR8zASPWI3
         wdaYUtXhDIwMX81XdeyJkPvQbh35mcs+TnrPa/KC5cicF5NLmEmGy1hZ/3muEwMQaOYX
         5xI6dPlSn+2WlXH1ZpnKFt6SR9O9MS3uiZUeemTpBbGt32yWuW/ppStkBap730CXdfHT
         ryxg==
X-Forwarded-Encrypted: i=1; AJvYcCUJWoeRkIc6iJbYB+GbqGempy4gtkAKszlxs1BDo24BbXJqqw20wZ2sZNhcLebLe0gtfoKD/z1q80HXhs6rkkMl@vger.kernel.org
X-Gm-Message-State: AOJu0YzPhSYRkVtga3KacDrHNREF2hvR7DfZEqZRyMCcLSJZPJ3/PqRv
	jG6aObl6B0PPqdCOekoVr9JDGvVyXcB6kKAn8DQOnQ2jdcHxpCGdK2r+LP7CzZzj9t1GZypizrn
	NAscGQMZ6XWHsZKZaBB9CQxxBDYRv2U8=
X-Gm-Gg: AY/fxX6qWeVY3J0HnIDECn3rQfLtOFVL7EM/aoqWZ6NZqzI2FD2wSdzt28ZowESlQOL
	aak8Z9Ymq8pRf8ASV7IV2o9YvFsMcU2bIBzxbSvN9Kgm2nGsfSsQUVoC8waBSIRFzJOOiDCMuqM
	Q/JzHy3SfIPB+FDn0g0UbyBrpW5Dp9oHqaWGzguDmvhp/kRJSEstNYJPQp1aybP+MFwFyHvT80k
	R/qVK2LVn02P/BHLke32aC1lJSG7VaZ9ZfQvsuDMP8HJ/MQZ0O7wlqhDI5QK/rqrfSFBEcuDdeU
	CDUWE3ECYnEldN7rLHrXBTtN0eHaWFWWkoTijtmkm7/LmyMer7uD/6P+fELvzSndt/BB6rSlB8t
	M/HZqtvppJ/Me0IkPKAohoBI=
X-Google-Smtp-Source: AGHT+IFrptM25tDo6OgwVjwNE6sttK8tiJTbTeh1uLcr5AC6QnmieVL8kggrKij9zZwy/QPwpL9ycfqV/YVXijoETTM=
X-Received: by 2002:a05:7300:c00c:10b0:2ae:5d59:3ef6 with SMTP id
 5a478bee46e88-2b05ec8546fmr8341481eec.9.1766569411905; Wed, 24 Dec 2025
 01:43:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223175216.1353814-1-gary@kernel.org>
In-Reply-To: <20251223175216.1353814-1-gary@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 24 Dec 2025 10:43:19 +0100
X-Gm-Features: AQt7F2rBPEL7D8SfZ6Gc5tG6d1djTg5NeV01DNU875a1bSh2mPJggyCVC3K4fd0
Message-ID: <CANiq72=p9QzjApCLzbAwgUe5OMAo6qrPadthspdjE8UMQcXRgQ@mail.gmail.com>
Subject: Re: [PATCH] perf symbol: remove Rust symbol workarounds
To: Gary Guo <gary@garyguo.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
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

On Tue, Dec 23, 2025 at 6:54=E2=80=AFPM Gary Guo <gary@kernel.org> wrote:
>
> Drop the workaround in perf symbol that filter out these symbol types.
>
> Specifically, '1' and 'l' can never be generated by nm -- 'u' does
> indicate GNU unique, however such symbols are only generated by G++ for
> C++ templates, and are never generated by LLVM (LLVM generates weak
> symbols in such cases instead). Therefore, the previous occurrence of
> these symbols types must be due to the off-by-error and can be safely
> removed.

Thanks Gary, this indeed should go away now.

Should we mention `N` which is also removed? (i.e. you mention all the
others that got removed in the paragraph above).

In addition, should we remove the `__` prefix in the parameter name?
It was added in the commit that added `u`.

For context, the commits that added this were (probably useful to
mention in the commit message):

    945f50036169 ("perf symbols: Handle 'N' symbols in /proc/kallsyms")
    4d728bb93bab ("perf symbols: Handle 'u' and 'l' symbols in /proc/kallsy=
ms")

With the notes above considered:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
