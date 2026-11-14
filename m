Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794625189;
	b=HU3zHrDsUFWelt3ZflXjnN/5CtqBsV6SJqBMAOO/ohwk56FZlxy75Rg86y7JbDE+LOpY
	 9RMTBIF6lchDJxw6dO9zMDWv9eAXZnyNg/9HYUT4QwLa4OFuTZUrocQQ6v67GaL0aY7DC
	 m0z0toU4an1/U2IUVrPZXyBa9A6jw03s2oAS/5gMYYvOuh96KVg6j2fMjyXZZw7w0abTQ
	 Uo1Q4VoaG23t2nPnnPrJ+tO5D9JcXOv+1b9O+tckGiGvZy1c/ccnnOB1C72gvB414SmXM
	 TyV8QzDQhI/nQ1QO4MKhMvE6vS2BUzjWS+Itxhu1ZOyMeFmRjNqwtpsTe2DDcsliE/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794625189;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=gtqgkeZJdBZqWJgZYD55Ddial0CIGRsrTMXTK2arrJ4=;
	b=lih5vHqYX4nCN422GHvgqwVDkL1NWDGOaOMKyTPgVCGglpYzryv2tc5P85mzvKOnVeZR
	 ivfRHM9OOdlTLKpOqEh6gj1ZmAr5cQyN1cbscePlyk8LEtHxThlDiWylYHwD6bDPf04zb
	 hlI2clfvKmN8U+/eP0X764NRu+rCjUs9bkR47e+MxTrGxfRhFIq/58jOWzHQXL4zbc0zq
	 qEdTQbKPkgKxcHbCXNK9csW5Cn9AJ07YrIAmCeMudxyQdjhjbQuOnbL7QD4swE3og6HRd
	 IDQdz+tNhFNmkyyEBTPHM7wEYYQsymzuuWBtIldtFqveF+zzDd83jiXt2tgHx+1rA2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MpdwKDMh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FB0606A323;
	Sat, 14 Nov 2026 02:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MpdwKDMh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D38B1F000C4;
	Sat, 14 Nov 2026 02:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794625189;
	bh=gtqgkeZJdBZqWJgZYD55Ddial0CIGRsrTMXTK2arrJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MpdwKDMh7RYG3utRHcOSHI5e1nHSdpfQEqvfX+E5ZHS2yLIC+mhHWhCdXMnSwwuex
	 2l3FMO/J4/UkFfmNK69RFOpv8PlRbwAf4pA2egWCJyE+aU/6vblWQSmZxQa2n7N0Hv
	 S9B9gP7wK7lkpO+1FDFyPVLi1NM8AWPXWLpve4deGXdSSD5px9VmB87Dq7UWWpYJSj
	 yjwedu4pqzeWlWz5UtMOfoKV4kz2EMwdZ2T4CttH/XVl7jZNGIvak3DQp6uC1ey4n8
	 Ig56iwuiRaTZFdVDH+urVvEGrCxQtPexjKLxtqRvYV8MlQiFZdgzSKWwgoPb3DzNis
	 FluIWOvU+YGjg==
Date: Fri, 13 Nov 2026 18:59:46 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: bot+bpf-ci@kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
	qmo@kernel.org, jpoimboe@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	james.clark@linaro.org, leo.yan@arm.com,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, ast@kernel.org, martin.lau@kernel.org,
	mason@kernel.org, ihor.solodrai@linux.dev
Subject: Re: [PATCH v3 1/4] tools build: Add explicitly sequenced -lzstd to
 libbfd feature fallback
Message-ID: <avfOol00qzRyJgD9@google.com>
References: <20261104043006.1199857-2-irogers@google.com>
 <d94520950f855a1d5ac4b51975988b70185ba7da61836aa84b044b69e8104bbc@mail.kernel.org>
 <CAP-5=fWekVEnxS_eSGsrCPM2XzoY=Z5fkYYK_dD6MGgxX3N2gg@mail.gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWekVEnxS_eSGsrCPM2XzoY=Z5fkYYK_dD6MGgxX3N2gg@mail.gmail.com>

On Thu, Nov 12, 2026 at 10:13:35AM -0800, Ian Rogers wrote:
> On Tue, Nov 3, 2026 at 9:03 PM <bot+bpf-ci@kernel.org> wrote:
> >
> > > tools build: Add explicitly sequenced -lzstd to libbfd feature fallback
> >
> > TL;DR: Possible build break at this commit: the libbfd -lzstd fallback is
> > removed but no consumer uses the new feature test yet, so perf may fail to
> > link and bpftool may lose JIT disassembly.
> >
> > > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> > > --- a/tools/build/feature/Makefile
> > > +++ b/tools/build/feature/Makefile
> >
> > [ ... ]
> >
> > > @@ -249,18 +250,21 @@ $(OUTPUT)test-python-module.bin:
> > >       $(BUILD) $(FLAGS_PYTHON_EMBED)
> > >
> > >  $(OUTPUT)test-libbfd.bin:
> > > -     $(BUILD_BFD) || $(BUILD_BFD) -lzstd
> > > +     $(BUILD_BFD)
> > >
> > >  $(OUTPUT)test-libbfd-threadsafe.bin:
> > > -     $(BUILD_BFD) || $(BUILD_BFD) -lzstd || $(BUILD_BFD) -liberty || $(BUILD_BFD) -liberty -lz
> > > +     $(BUILD_BFD) || $(BUILD_BFD) -liberty || $(BUILD_BFD) -liberty -lz || \
> > > +     $(BUILD_BFD) -liberty -lz -lzstd
> >
> > Can this leave perf and bpftool unable to link libbfd at this commit?
> 
> So the concern is that at this commit, not later in the series, a
> feature test for a libbfd built with zstd that previously failed to
> link in this feature test will now succeed, but the parent Makefile
> will not pass the -zstd flag and so break the build. This issue is
> fixed later in the series by adding the -lzstd. Will this impact
> anything? It will turn one broken build into a different kind of
> broken build. I can reengineer the series to maintain bisectability
> but this seems like a low priority issue to address.

Ok, fair enough.  As it got acked from other maintainers, I think it's
good to go.

Thanks,
Namhyung

