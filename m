Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EA1306764;
	Mon,  1 Jun 2026 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302008; cv=none; b=ihaAXwxqV+PUP6b/iavc+UN2YjLEcaTUAGnzZ0qmXQwyuhIGI0vGdDtVBHNkky7jzzTifW4vJ5EdP5JgwueWK02pg7Gpf5jniewgRhODvIrEYObgTVWahEL1tke+0dSw94fiAhjjeBmZDbgJskWaoorrWreY6ME5UHQONltlyAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302008; c=relaxed/simple;
	bh=JWLDWTAqcmXVyaJF49S/tmgyy/nWL5FkVeSks4aAO9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQ5tdAP4MjZ+nPEi24uPDjDRPXxvjc6bwv/JlhhUpy+AyncOkz3pPUtq7Nzz6SvEiY6ThwYZkRz7/PoMWjDhqBA2cCgg4nrWDu7vXYA7aM5MTLpeijsxfCQOmoTjtPqh+Na2Y/4NYcaN6yob/U+8wbrHmGTfVkL/Lbjo7xwecZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqQfXDIl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqQfXDIl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A2D1F00893;
	Mon,  1 Jun 2026 08:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780302007;
	bh=O3SBerDy7gLkJyDryJeqMmv1YGRLwNIx1Y17wjdBz40=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=oqQfXDIlzg0gxBm+klYjURdclxoa2cUxwmLBK7CVEFAY+K+N6psZMsUhEH3/KR+RT
	 BY691nZhoxDAj5jrDGFeCzUOz3xEb3EHQhxaNk8UYuNh9R4of1EZisrxa5kjiFrkTu
	 esSvKduFfqnTBXXStRzM0i295WW/c7qiDb3P7QjtpzibxEblkV6/eouWef3e+lhb9e
	 BAuBVjDGgqEOK1yZ9p08K3Ru79innm+Yh7Bh5LMddp10ShYhwTfeabsTXiCaN/Wlc9
	 h1q7cfKkAnx2heAnlJnDxxlRN/cQLvJiI4SCD5KhWYfriT5uwddNtI1+YF8zSz3/vl
	 tWhdS8Amr9Cvg==
Message-ID: <1a9884b6-df23-42d9-bb68-1d6c774c0657@kernel.org>
Date: Mon, 1 Jun 2026 09:20:01 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] bpftool build: Restrict feature tests during bootstrap
 compilation
To: Ian Rogers <irogers@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, Nick Terrell <terrelln@fb.com>,
 David Sterba <dsterba@suse.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, James Clark <james.clark@linaro.org>
References: <20260531010750.525160-1-irogers@google.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260531010750.525160-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-05-30 18:07 UTC-0700 ~ Ian Rogers <irogers@google.com>
> When the perf build executes 'make -C ../bpf/bpftool bootstrap', bpftool's
> Makefile unconditionally evaluated feature checks for llvm, libcap, libbfd,
> and disassembler libraries because the bootstrap target was not exempted.
> 
> Since the bootstrap bpftool strictly compiles minimal AST parsing and C
> code generation logic without linking LLVM or disassembler libraries, these
> feature check sub-makes are completely redundant.
> 
> Exempt the bootstrap target from non-essential feature tests to eliminate
> unneeded sub-make fork overhead during Kbuild startup.
> 
> Tested-by: James Clark <james.clark@linaro.org>
> Assisted-by: Gemini:gemini-3.1-pro-preview
> Signed-off-by: Ian Rogers <irogers@google.com>


Makes sense, thank you Ian!

Acked-by: Quentin Monnet <qmo@kernel.org>
