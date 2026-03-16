Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4FC3DFC80;
	Mon, 16 Mar 2026 18:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773686441; cv=none; b=tc915Q4LvMpCSxRZOcYnWT+L1oZISx4W1cna6pLcYwlCd9QmM+iPjS8P3LOrNzjdDPcPH5WMJMsLbRg5PqoDJA7ZFU1zyX5D7Xjd09BiSvLDljAT29WNEYTGElVGwVlM99f1ydDkudi28OODp5OQhmPCh483iW9grc2lQRN1wF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773686441; c=relaxed/simple;
	bh=BDLkgbnoo2CWArc5Am7Ovr1qSVX1mkAs+VUyk+DYM1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqPcZHBKE2JksvwifgK3vW6m06SlAU+qRYo6tyJszG0hUtyzoEn2wPAumM7P4ypyPY1Ke1wbtxGMDSGF0DEDzunsWJey8jycAi6MXjvIiNgY+t+xGuIdhH3OG4BACO82k7T+ADIWUSt7viLZ5XHy8rhzXu1RhX66ANtWjb6gdeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAUjuL93; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAUjuL93"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37C7C19421;
	Mon, 16 Mar 2026 18:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773686440;
	bh=BDLkgbnoo2CWArc5Am7Ovr1qSVX1mkAs+VUyk+DYM1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bAUjuL93dpxhmmlf5mAlbdQ49SBBM6UIOZR2h0goX7yS91Tr/5sXklJrLA/pKEQcl
	 jVJimEaOkEDeEtW53/WYtud3oLCCPGOro0OsO55eGx4NiTmrPlN+/Fv9vhLj7Qn3TX
	 d6s6g9j2nzJJ/ISaUOyedJDoTgZrCnbWYPZL9OjAw49tZ+T5UyRSP0G3dSTSzi0xcq
	 p+LB/pehxCm/a2zsr3+V/iDV/ab2+EzQ303L5lXNrCM95i8EDiMTgjYwozC+G1/mhB
	 JFdKwJX0I2qpU3sWYwZrWW5NsxPoVq3HGwhcXnwnH4+uS47Lex4HZAstOzXJo1H/lp
	 Qqs4vRCbPTyIg==
Date: Mon, 16 Mar 2026 11:40:38 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Dmitrii Dolgov <9erthalion6@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Blake Jones <blakejones@google.com>,
	Yuzhuo Jing <yuzhuo@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools build: Link crypto lib for libopenssl feature
Message-ID: <abhOpjDG6hr-Sfe2@google.com>
References: <20260307140553.2021539-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260307140553.2021539-1-leo.yan@arm.com>

Hi Leo,

On Sat, Mar 07, 2026 at 02:05:53PM +0000, Leo Yan wrote:
> The perf static build reports that the BPF skeleton is disabled due to
> the missing libopenssl feature.
> 
> Linking the crypto library fixes the static build failure.

I'm not sure if it's enough.  My build still doesn't have BPF skeleton
support even with this change.  It seems to want zlib and zstd as well.

Here's my tools/build/feature/test-libopenssl.make.output.

/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-dso_dlfcn.o): in function `dlfcn_globallookup':
(.text+0x18): warning: Using 'dlopen' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-bio_addr.o): in function `BIO_lookup_ex':
(.text+0xe77): warning: Using 'getaddrinfo' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-bio_sock.o): in function `BIO_gethostbyname':
(.text+0x85): warning: Using 'gethostbyname' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-c_zlib.o): in function `zlib_stateful_expand_block':
(.text+0x83): undefined reference to `inflate'
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-c_zlib.o): in function `zlib_stateful_compress_block':
(.text+0x157): undefined reference to `deflate'
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-c_zlib.o): in function `zlib_stateful_finish':
(.text+0x1bd): undefined reference to `inflateEnd'
/usr/bin/ld: (.text+0x1c6): undefined reference to `deflateEnd'
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-c_zlib.o): in function `zlib_stateful_init':
(.text+0x293): undefined reference to `inflateInit_'
/usr/bin/ld: (.text+0x308): undefined reference to `deflateInit_'
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-c_zlib.o): in function `bio_zlib_ctrl':
(.text+0x506): undefined reference to `zError'
/usr/bin/ld: (.text+0x5f8): undefined reference to `deflate'
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-c_zlib.o): in function `bio_zlib_write':
(.text+0x8c9): undefined reference to `deflate'
/usr/bin/ld: (.text+0x946): undefined reference to `zError'
/usr/bin/ld: (.text+0x9e7): undefined reference to `deflateInit_'
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-c_zlib.o): in function `bio_zlib_read':
(.text+0xad9): undefined reference to `inflate'
/usr/bin/ld: (.text+0xb56): undefined reference to `zError'
/usr/bin/ld: (.text+0xbcb): undefined reference to `inflateInit_'
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-c_zlib.o): in function `zlib_oneshot_expand_block':
(.text+0xc64): undefined reference to `uncompress'
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-c_zlib.o): in function `zlib_oneshot_compress_block':
(.text+0xce4): undefined reference to `compress'
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-c_zlib.o): in function `bio_zlib_free':
(.text+0xd39): undefined reference to `inflateEnd'
/usr/bin/ld: (.text+0xd64): undefined reference to `deflateEnd'
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-c_zstd.o): in function `zstd_stateful_expand_block':
(.text+0x9e): undefined reference to `ZSTD_decompressStream'
/usr/bin/ld: (.text+0xa9): undefined reference to `ZSTD_isError'
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-c_zstd.o): in function `zstd_stateful_compress_block':
(.text+0x178): undefined reference to `ZSTD_compressStream2'
/usr/bin/ld: (.text+0x180): undefined reference to `ZSTD_isError'
/usr/bin/ld: (.text+0x1bf): undefined reference to `ZSTD_endStream'
/usr/bin/ld: (.text+0x1c7): undefined reference to `ZSTD_isError'
/usr/bin/ld: (.text+0x1ef): undefined reference to `ZSTD_flushStream'
/usr/bin/ld: (.text+0x1f7): undefined reference to `ZSTD_isError'
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-c_zstd.o): in function `zstd_stateful_finish':
(.text+0x22b): undefined reference to `ZSTD_freeCStream'
/usr/bin/ld: (.text+0x234): undefined reference to `ZSTD_freeDStream'
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-c_zstd.o): in function `zstd_stateful_init':
(.text+0x2fd): undefined reference to `ZSTD_createCStream_advanced'
/usr/bin/ld: (.text+0x316): undefined reference to `ZSTD_initCStream'
/usr/bin/ld: (.text+0x337): undefined reference to `ZSTD_createDStream_advanced'
/usr/bin/ld: (.text+0x34c): undefined reference to `ZSTD_initDStream'
/usr/bin/ld: (.text+0x374): undefined reference to `ZSTD_freeCStream'
/usr/bin/ld: (.text+0x37d): undefined reference to `ZSTD_freeDStream'
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-c_zstd.o): in function `bio_zstd_new':
(.text+0x42c): undefined reference to `ZSTD_createDStream_advanced'
/usr/bin/ld: (.text+0x444): undefined reference to `ZSTD_initDStream'
/usr/bin/ld: (.text+0x449): undefined reference to `ZSTD_DStreamInSize'
/usr/bin/ld: (.text+0x46e): undefined reference to `ZSTD_createCStream_advanced'
/usr/bin/ld: (.text+0x488): undefined reference to `ZSTD_initCStream'
/usr/bin/ld: (.text+0x48d): undefined reference to `ZSTD_CStreamInSize'
/usr/bin/ld: (.text+0x4f4): undefined reference to `ZSTD_freeDStream'
/usr/bin/ld: (.text+0x4fd): undefined reference to `ZSTD_freeCStream'
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-c_zstd.o): in function `bio_zstd_ctrl':
(.text+0x6dc): undefined reference to `ZSTD_getErrorName'
/usr/bin/ld: (.text+0x78d): undefined reference to `ZSTD_flushStream'
/usr/bin/ld: (.text+0x798): undefined reference to `ZSTD_isError'
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-c_zstd.o): in function `bio_zstd_write':
(.text+0x9a2): undefined reference to `ZSTD_compressStream2'
/usr/bin/ld: (.text+0x9ad): undefined reference to `ZSTD_isError'
/usr/bin/ld: (.text+0xa24): undefined reference to `ZSTD_getErrorName'
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-c_zstd.o): in function `bio_zstd_read':
(.text+0xbcd): undefined reference to `ZSTD_decompressStream'
/usr/bin/ld: (.text+0xbd8): undefined reference to `ZSTD_isError'
/usr/bin/ld: (.text+0xc14): undefined reference to `ZSTD_getErrorName'
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-c_zstd.o): in function `zstd_oneshot_expand_block':
(.text+0xd87): undefined reference to `ZSTD_decompress'
/usr/bin/ld: (.text+0xd94): undefined reference to `ZSTD_isError'
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-c_zstd.o): in function `zstd_oneshot_compress_block':
(.text+0xe0a): undefined reference to `ZSTD_compress'
/usr/bin/ld: (.text+0xe17): undefined reference to `ZSTD_isError'
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/15/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-c_zstd.o): in function `bio_zstd_free':
(.text+0xe77): undefined reference to `ZSTD_freeDStream'
/usr/bin/ld: (.text+0xe95): undefined reference to `ZSTD_freeCStream'
collect2: error: ld returned 1 exit status

Thanks,
Namhyung

