Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795668789;
	b=WDnfpJL3ZjmPGrOPn3CB3AEIK3hFbubIeJUYX9J4b+oznlI/gf5jNF1N+wbd8CsrA+tj
	 KtPq+yTAG/Z+DutsRCeD0KWTlxBayriqUJYIB9+DrJ4alJjg4PzoPuRg9hbWV9iB5SJSu
	 yFfEecDgs42qgEzzRZvteVzabpWUMr/uwHnAuUKw7mu/x9euOOXrMcZUj9r0t1NYFCSDr
	 GXXvCFWIkYIN8WNcGMlbas2d6Leqr4qupi2Rmu6dTZ6bvAn/VdEOnkBlTn1utmm21LfNn
	 Ju0HKPgaheEZM6zD+h9tMjUHEANLyANN83l6n444YROuRbPrJRjY5OjO9SLBY2LqEmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795668789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3Lt4WVagAGoPNQQ8sUuV+xbM6KmxoNVjHzW8jPpsfl4=;
	b=ZvgnobUqH4YfJyiYjZE+0p8bIBI+wWcSuvXFGIbMC4nAM5HHsHdW+ireJ6b0F8zGkUv1
	 cWp3627CFG9uMkrlHsluiW7zn4XadDi7OFyp4baZQn6JGbc9ZK45RRGn6P8FwUFlwmZar
	 qwpbp4DAhEiusAXHvmKcnB2www0uy8MjJMsBzbPQfzHtIx5SOfj2+3jZ8sRQ9SSiqtupY
	 /3hF3z7XmMck8QG3oqn1H0ZI89RPdl3UQ5zRn3u19QHhAhzmNIZ02715Kez+XzTBvuRl8
	 0NOfDOxoXHl56iR7efV2Ly/EW1NZXfY0fAawrfQSdOtGKUdbDacU2hXtEtoikZlU8NQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Wt/H8uEX";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4675F606A31C
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Nov 2026 04:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4675F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Wt/H8uEX
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-54492d8a988so1599651cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 20:53:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795668788; cv=none;
        d=google.com; s=arc-20260327;
        b=VVZAqhv2Yt4QPRRHR6Wuz/b3JflXUDez8mm136/sXR2IMZotxzTuw2o+J6wTbCrAOD
         bUnSSZq6b0Y5R4a5yRJxdopUZiCWoDkIfzK8HyD13TP7qbrP6onZhVAc+uSTALPqVyeU
         pGj9kBjPh5WwxLrRPXl9WUgQatj1zEdLIOEcifYAzxMfNnnkMJMmcOHiQxNFbIqgFjGn
         j4qL+woah3M5FFV2tccTZOt8cuQUVZUuktib2eLFDzKZhg8w7w3M1xImXkNUt44BGkh+
         LsYB8V5K9o0yF4U0TAUKgJ5AjIm1KajqKtAISL5xCbzr0SAQ6du/6xw9aLE0cOKyp239
         5Qyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3Lt4WVagAGoPNQQ8sUuV+xbM6KmxoNVjHzW8jPpsfl4=;
        fh=ttzn7lTnED/DI/SVJgyCCnp4IhvwprwFDaUusjGD7WA=;
        b=rEt1wVLzPRG+Bqv5enbvA2ajwT1rVZdYVY1rojlW0uSFJYkLM8CnZmWD06uH3x4Db0
         Gw7CIiDUktmCFMwXqE3Gg5uBE4OK+RajM75IL3z433ImV9R1oGuBtxQAzWRuaP6aIKLr
         dVTOLnwGNghcO6KiYI1AdQx0llLjvc5Cepj9qKJFebuThidlM0oWLjDJ9ZwcuNrPNYqq
         so9vY4ZN0SwzHMx9kTICfGmS0ypfYAkpFLmszxV+mhacFBMwl30G7yTHOp3+Dl4MGvEo
         0D+FlJhDzFBL0k8Z3bo3IpKpAtk/x47RrJMRwovQeKQMG/IrJXA3YCXuwvwJ54Hmyb1G
         dvPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795668788; x=1796273588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3Lt4WVagAGoPNQQ8sUuV+xbM6KmxoNVjHzW8jPpsfl4=;
        b=Wt/H8uEXeygfnRJXsnha4ogYR4WFdKKtucv0h74Hl9SvZ7ZVOZ8pyveIu/m+bbBuqU
         7pLEkyr5FS02oSIkkEdcPGP7aMYZHs2eR8ZbSslwbXiv4nig66Yw9zXIl5pT+EHlNoMU
         cQHBNyntCt6+GiY4hESZ00/HEKXKxMOneQnWVqwJdquEVsZ01fF3oKFb+IYLDHDd97P1
         5iwuBre8QUjJjwbIhiuIlmYLUamd902f2vsDR98ELoNLHrtAN91EmUr8k1YyhoPYh3J/
         v+aNlL3NNgtJeSDZE4JVJM46ZiSMrhfEMHEAp3euRyiB3I6N1f0aZKatBbawmZwgSrYV
         rmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795668788; x=1796273588;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Lt4WVagAGoPNQQ8sUuV+xbM6KmxoNVjHzW8jPpsfl4=;
        b=Qe425gyJd/9o03cGL68XeKDFSm9sAowJVhvrQNB5sRZ9Ujk+4p4vVsZT0HOtkTHQNd
         r4KIFo4IasnaoaquytwhMmh2xoaECSvXF0tX08Co7Mw6kZxLH4zGTrHRBqnVLEvJ0Qht
         KFFcGzXID6p5X9A+I8PY37VWy79t6r2d+Hu+PDkDZj0xKu/mWxmUOsClgoVQzlfwmDkz
         yGh4et61laaIdTaszXKYHJSuKiUtxV7rv7mnk1FTvsdvLTpmKWEUtJivESRKp5/BRGIa
         k/kUg/y/MWSqXqBLax3tRd+UANktexfQ8kXHC+JrZdlBmA1CqmvZGyiHWwmk3EROoZUM
         AGMw==
X-Forwarded-Encrypted: i=1; AL+hErE3YRgLgnV5C/Uw9wxcHFn0MYrO7gN+NrvKjT16iV8var/Z+DCVqDfIVpfDllFVtFg52IAhVBrNDXxGMv0qWlLv@vger.kernel.org
X-Gm-Message-State: APuU4Z85g3SFE5Ue85jP+VDtSNVeav3Pxphwo2JDqH7kmO5K4OuigsGm
	lGY6FRp3g5K7j+lmTC1VV1IAYnZ8S96nwcwiSwPxfjhbAuDO/6YC9TG2V4xFq+ExgBUeWbU4CDV
	giYFzO/kBZvC9P2/iIigJb7UEmsNirXjfdpF6uqUz
X-Gm-Gg: AZFdTZeVrrFhuGR/upGFmcSgKo5bP6rJRfB6Bsfz35PesnqDNuox8aDT9zZOv4klzy5
	xxscqyrLYpwgAEMKy1zadnBrH86aPbeGf3uBaIQB7Tv0+m35Z+rzYebwCM9Mh25julcDwBCpOLQ
	imM5ot5fNCq8GSMjFtgwCdW07P4KE5Vbx24//1NeJJ9eKXd97TpEkHSVoM309k/PaWWiSL0ckV0
	0qV2jWYFApYSG5Rj4PjKceUA06q3FP17ULf9xLxwTUbykgIwCV5VwEgx6bOFRwK6TRQAil42WxX
	SnDahmKdIIJtd3h19MCpSNzPQha05gdHMSa38X46rFr8989/zAKQVth5zG6wGWA2m0e/qJxcoDN
	bttWwKuuVx5RbWvCUPmKtiBQm6KgeUX660ZJCZkw4i58fkixhGDx8TP856g==
X-Received: by 2002:a05:622a:1e86:b0:536:3ee4:81cd with SMTP id
 d75a77b69052e-55d88127bafmr101738501cf.4.1795668787640; Wed, 25 Nov 2026
 20:53:07 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125061523.1540234-1-irogers@google.com> <DN4FM3TBOJ9T.2QOOL77P5HETO@garyguo.net>
 <20261125132225.00254c37@gandalf.local.home>
In-Reply-To: <20261125132225.00254c37@gandalf.local.home>
From: Ian Rogers <irogers@google.com>
Date: Wed, 25 Nov 2026 20:52:56 -0800
X-Gm-Features: Aa3M54pMQmXw5Cgtc0EakW9NOiIZs8STgUuBigJfJMSZlzejGTE6XZMetCnzc-8
Message-ID: <CAP-5=fWkUW787c4dGx9rccucqD67dfRgwBB_SoCxFnfZXtXP-w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/30] unwind: Minimal DWARF CFI unwinding for user
 and kernel space
To: Steven Rostedt <rostedt@goodmis.org>, Gary Guo <gary@garyguo.net>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, jpoimboe@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, tglx@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, acme@kernel.org, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, mhiramat@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, 
	nathan@kernel.org, llvm@lists.linux.dev, nsc@kernel.org, 
	linux-kbuild@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, ardb@kernel.org, linux-efi@vger.kernel.org, 
	maz@kernel.org, oupton@kernel.org, kvmarm@lists.linux.dev, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, indu.bhagat@oracle.com, jremus@linux.ibm.com, 
	wnliu@google.com, dylanbhatch@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 10:22=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Wed, 25 Nov 2026 16:28:02 +0000
> "Gary Guo" <gary@garyguo.net> wrote:
>
> > A quick question: how do you plan to get this working on 32-bit ARM whi=
ch has
> > its own EHABI?
>
> Do we care? Isn't ARM 32 mostly deprecated at this moment? Or at least no=
t
> adding new features.

There has been recent work on both MIPS and Alpha for perf events, so
supporting ARM32 EHABI doesn't seem unreasonable. Devices like the
Raspberry Pi Zero W/WH, which use a 32-bit CPU are end-of-life in 2030
(according to https://endoflife.date/raspberry-pi ). It is
out-of-scope here, but extending the kernel and verification
infrastructure shouldn't be hard.

Thanks,
Ian

> -- Steve
