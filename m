Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C179F2D948A;
	Wed, 11 Feb 2026 16:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770827228; cv=none; b=PLnTxNc22yKoMm52K0U4a/CoMhtk06jX1hWSlWLS4IVV31YrX/zHinr1w1GMDoekXd0Q7ye54mOknHZJWLdqfEUbQup5uZq2NVLgp00syzzcVK2WjFrb+h2a9vnaOuBeQ91m5cnKuGrjQo4c4uLgcsA507sC1PrBCNdK0s+rBTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770827228; c=relaxed/simple;
	bh=/LJesoTfbflYsC1m2Ri9NVppFK7ho7Sqst64TMCsb3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYITRt8pd8aAmUAYqVt+ika8KqMt+rsAriAt6+DmJfBQRG5Ept1rPWQU/LrRdSgxkxWx61OrJqZ1c7Ynfe3AZJpr1FBIkkTCqoKVZbtUTZghMrzaFpLkWE0F2Sa5+syUszOgS53Ak7vFrWIhXT209FguSbzBHDaV8b522UsSY6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGfulyQ7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGfulyQ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788FCC4CEF7;
	Wed, 11 Feb 2026 16:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770827228;
	bh=/LJesoTfbflYsC1m2Ri9NVppFK7ho7Sqst64TMCsb3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TGfulyQ7OVGwAZeRggKnJFtQRRuKxd63s4kPfvcTrX1rU04/YgzUvaf4wy0w7noED
	 I3enVVE1dLzLHc8nzaQeKTWPkjji2DWqf8AafRkM9qP9wcYDeUepYmL4heKBjlKhbn
	 tsVh6Lscj/7Sw9Ao72Z7AcFvkNABnnIrejfuQQWq/5v/n6/6VIUL4TBtnw/6exflAG
	 MTQwg7kQ5v5DxOfY/LoRotFO0XDX6AEDEG2xavCH7tXjyxC+wHFypqZq+FgfwjRyF8
	 mkR2adt4Naf/l/YAARWr0ncBxmafaaSttFIRKtqdNmLwt/wX1a3ZyEgzQgSYpuLxNd
	 vGe0GN8lRQF6g==
Date: Wed, 11 Feb 2026 13:27:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: hupu <hupu.gm@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	morbo@google.com, justinstitt@google.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [RFC 1/2] perf build: Allow passing extra Clang flags via
 EXTRA_BPF_FLAGS
Message-ID: <aYyt2KD3pPu4alvT@x1>
References: <20251223084337.3789-1-hupu.gm@gmail.com>
 <20251223084337.3789-2-hupu.gm@gmail.com>
 <aUrdUjqVEjJW9VBl@google.com>
 <CADHxFxRprUvRzorxe00HmwG0o73VQJNf=yzM40fkiWjjqu7PZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADHxFxRprUvRzorxe00HmwG0o73VQJNf=yzM40fkiWjjqu7PZQ@mail.gmail.com>

On Tue, Feb 10, 2026 at 01:54:49PM +0800, hupu wrote:
> On Wed, Dec 24, 2025 at 2:20 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > On Tue, Dec 23, 2025 at 04:43:34PM +0800, hupu wrote:
> > > Add support for EXTRA_BPF_FLAGS in the eBPF skeleton build, allowing
> > > users to pass additional Clang options such as --sysroot or custom
> > > include paths when cross-compiling perf.
> > >
> > > This is primarily intended for cross-build scenarios where the default
> > > host include paths do not match the target kernel version.
> > >
> > > Example usage:
> > >     make perf ARCH="arm64" EXTRA_BPF_FLAGS="--sysroot=..."
> > >
> > > Change history:
> > >   v5:
> > >     - Update commit message
> > >   v4:
> > >     - Apply EXTRA_BPF_FLAGS directly to BPF skeleton build command
> > >       instead of modifying CLANG_OPTIONS
> > >   v3:
> > >     - Move the variable description comment to the top of Makefile.perf
> > >     - Update commit message
> > >   v2:
> > >     - Rename EXTRA_CLANG_FLAGS to EXTRA_BPF_FLAGS
> > >     - Update commit message
> > >   v1:
> > >     - Introduce EXTRA_CLANG_FLAGS to allow passing extra Clang options
> > >
> > > Signed-off-by: hupu <hupu.gm@gmail.com>
> >
> > Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> >
> 
> Hi Namhyung,
> 
> Sorry to bother you.
> 
> I noticed that the patch adding support for EXTRA_BPF_FLAGS, which was
> previously reviewed by you, does not seem to be included in the latest
> released version. I just wanted to follow up and check on the current
> status of this patch, in case it was missed or delayed for some
> reason.
> 
> Thanks a lot for your time and review.

Applied this one,

- Arnaldo
