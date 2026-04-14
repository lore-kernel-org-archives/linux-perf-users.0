Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E661D3B8BC7
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 10:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776161027; cv=pass; b=RXfTKEv/BWWCav5pRiaxQ1FNHFI6huLHPu+9UTx+33HzY8FcMtVIQ6s/mGuzpbiN133s6MLK1mRrKLiiH3LIppkMuS8zPW/RzuWzA1dBZ3T1/7E9rB4k/rNFMkaTFtjSodoc5o9iHG7jLaIfaSdwAjqz4qeD5wI0zrkJmUR+TY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776161027; c=relaxed/simple;
	bh=NGw3vq0gGYgbZs3WougDNYv0+luak2LML/PW+q8OygE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/Ct4IwHDceOEWN6btww9nrf2nokBqwx39+3EZUHTsusSJUdgQwWhlAcp242l2tCGY0q6yUN3SY+o4lITyWHK6SmV9ZXsHaK44HumWMhfMhC0lIm2SrvVW3ShbngjbV5fbaz5JQmpPn/ePfs0j73jeJQNFGR3wV+h5m1mzhiGv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQI/D51c; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQI/D51c"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-127148c2112so902688c88.3
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 03:03:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776161025; cv=none;
        d=google.com; s=arc-20240605;
        b=AyETPQ0+PQCvLN/P3vHV652ke2nyX7s6zI5sSA5ZCZaHY05CWrtbDWb6sKYi2gQOFS
         1XmCs+rNbn9HKmHrXX5VrZ36i4iWomFdau1Lvd5psAmzreLRHe5fVb+xMSd+Mbc8Ed86
         T7hyCgb+pR2Sf1KjDq326hQUYe//WSQaH1BrIk781WvCjVVBYAsCynqq0YR1n8tLX4/Z
         Ws6BIGzYRg7uPejvnJsfUq4zUNEj0Hd4JQe59SegDoTD3ExKej7NosMDGobKq6+66xM6
         DW96wMVSk7SA2pXd/tykK2fTBp1amrPA6PMTf/XX8bPpeVwQxZWysWQBtk4EbqapWaTf
         HoyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NGw3vq0gGYgbZs3WougDNYv0+luak2LML/PW+q8OygE=;
        fh=lz8Xz+SJ7jve17mtMKUo5pZN+zhI3RCO0guzQ+xZadc=;
        b=Gd19SvxpACrOi7HEemRnFyKOrfbB5416NQWFdYjYwGGnjJLglGbpNnkgIUg5nXiiCV
         P7aQkaWu8JsQscmGd2/aTI90kzLlsJE/3GDbcfkU7QRUjfrbz/Mek+ETer9HQTEFC5Sd
         p23h+UhEFSjRwHUrSq35LiYI4FScVgg6orc9JBG+H5QxS0s/16oaYzfr5MnRU1+Pbik5
         RJIfQ52NugaP0BUg1xoAjb1XeLlmm3Mkt7U7LiD9rpUQ5d/T8Xjy8Q0rYm6wKvgZSBMo
         t10QXTcYu1bGHt40g1rMga/cBirm5I0MVNZUP/AHgkKT23RUNuCFkdppQ3wIG83KhvZe
         FzUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776161025; x=1776765825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGw3vq0gGYgbZs3WougDNYv0+luak2LML/PW+q8OygE=;
        b=bQI/D51c4K+l4NywAhMHn/wITsRY3N2eBGXJ7D/EXUlNovyKkLwxY6DPb9vmPK8mvj
         zK2mMztTYbJD1j4J6R9Bd6ZcudHSuegN1qoPDJjI0epH7Kn+W8O/1WFqzMIOAOIt7dLU
         E63X186qMidr+i8ys3Dcxd+1s7PJ0hvivDOlYdOdgbs4bu8jzHRK9T4lfBtKMfHrsEbR
         YbKYJX6G2w2rTy5Mqt38a2D9KhrjuThxrexQkeg9U6YpbCr1LIF3U+2byv9KOFw1uDEV
         BmA9ouHNU6TTlHKnVBlwq+faFjvNfkY62/rXq3XJK75+JT4l6aOz5/n/YLMCZbDzdHB3
         Dumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776161025; x=1776765825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NGw3vq0gGYgbZs3WougDNYv0+luak2LML/PW+q8OygE=;
        b=iD8z5VEhhGf+nPojpd022/DgEFWx8RB05Bq2f8WTd19F00PvDsR0BKZMkF0lsx7Fgq
         mmGpe9adaoiLkd1plHkADkmR/TKTeF5MP6uSbkFGh4HiJqQbvk8ZheFcRYpvOIw9DLyD
         EBJCqkhJ1aNJUjRLWJcz/DIPUKxsYfi8luFvOX7zWGifamSYTjYGEnPvBweplRNi3536
         Chn5CO4jMHB8DalavDaH21L4gQ4fS7thECRiahPTpfPc3LrGxAB9dYjTXftVaLDN0Wez
         jjEILHI7oSHipLD/Mq0kCgXmKSjcS/Da2wLRIPXOtCe/hU08Qp7e4hzH44eD7K29X64F
         SLog==
X-Forwarded-Encrypted: i=1; AFNElJ+HGgQ1ndgWc2xYPQpINwVs8urnGPtM3TBgLpXg7S19qmO1PDZQrizLL/mOx15E3+LKrIBmxnLGgdXKeXh8pYxQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxXBccMwZl//gJRMRUV5bx8YJQ0RVvnmbfXDekebTFzOUsGObzM
	mvWGOy/NWLT6DZXZUOWsAmySjV6X/DtZzBdYXJg9lcm7cS9wDpGhgo7jyzyaOqEZZEHL/mximn+
	frcKzgSIu1MQhRz0s8yqI/kJvWuqClqU=
X-Gm-Gg: AeBDiesg2QIV2DJD7r5WGr+jgDFTdWQqe+Yq4X5rkjHA/GTWMvZsfpfsqs6/9kCvKNm
	XLQUL911TBl56gdAEGEAzC3/NV3YXbOF5cGMg44QL7e5RzS+yQRxC/iogkZ4oYmudtdCZrsTpVZ
	wXindTYPiuT7dnMohadn1Lrc2NKMxJlhGgSrKQ6+tltA+5qmbOraDk4YKzxBxdRS9HLlWh3Ii+c
	7OTIAT1hMn2dyVL7SVQ2F5peOHzrstG/GpV0dL/xV+I6fMSHndCeokP8cClA3DqC96Fp/FQPW9G
	ze9Rnzbw1uLxlY9O/6BVaNRWpNO/R8zmedIpkJMv2d1R6j2VUUCPJ76Bsw9KD3wuvRfuPcela9k
	omi5inJdeeOqboIoegUGqFgs=
X-Received: by 2002:a05:7300:6da6:b0:2be:298c:a11 with SMTP id
 5a478bee46e88-2d58966b77cmr4005329eec.3.1776161024897; Tue, 14 Apr 2026
 03:03:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414080500.320095-1-r@hev.cc>
In-Reply-To: <20260414080500.320095-1-r@hev.cc>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 14 Apr 2026 12:03:31 +0200
X-Gm-Features: AQROBzC466LTvnRS_A9FBMV0x9gLQuJNVW1COdEXUuheC7eprPjxu95Elog66iQ
Message-ID: <CANiq72=c2wniA2piByZNUVzSUA2YPhRPKBq7e_bBP-69Lo+wCw@mail.gmail.com>
Subject: Re: [PATCH] perf build: Add clang and rust target flags for loongarch
To: WANG Rui <r@hev.cc>, Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev, 
	loongarch@lists.linux.dev, Haiyong Sun <sunhaiyong@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 10:05=E2=80=AFAM WANG Rui <r@hev.cc> wrote:
>
> From: Haiyong Sun <sunhaiyong@loongson.cn>
>
> Add missing CLANG_TARGET_FLAGS_loongarch and RUST_TARGET_FLAGS_loongarch
> so that perf can be built with clang and enable rust cross compilation.
>
> Signed-off-by: Haiyong Sun <sunhaiyong@loongson.cn>
> Signed-off-by: WANG Rui <r@hev.cc>

FWIW, sounds good. I guess the commit that added the list should have
had it to begin with? Cc Dmitrii.

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
