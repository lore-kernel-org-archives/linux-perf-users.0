Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795394589;
	b=5b3lpykpyEq49xjdxptqwC3CVt4tyWZRFX5k9lon+0Pb9uD34VjADxUyQJ0VhLmsHKXm
	 EnLlrwoAMdOc+24FF741whiOBG7kBCkB3HZfhcRi3yIdTB3Fv2yo/b/cNeU3vqIVN5NWZ
	 uL+1Xc3R5B9V47RugQrOmGAvmdUUGaBDrUL0ejXoR5Ejiy66h1WFwXQPxDJPd+7MSbZxq
	 GngRjNL5NDmCOAUDEmoLGORh/dnttDxh2oo8mFSXcOh2RRo67MbDKrt7020eUmQc8wfkS
	 +tbscRs377UoJ5PSsGQQ8kctISQvEvpMelro1K/KL84SV0XEg4xW1iykWIMdhbg168Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795394589;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=j/8IZ0tYFhI/0yqSFfSy337P3mjZcrIvJ9lgLMTLLw0=;
	b=kbO/Vfb1saIn2HteL5AJwyfr8+1iIdMYKEtQjWWZNMt33FbS/TtI/NH1eu3LqMH94oVY
	 6jpPt4VaWNDhP36wHHAjcE8iiGvPjXQvMaeRsc6u2FDuNEkTXhO8gIN/mHBYL74NLYU1U
	 xe71VqwPXXDxkodDNj9eAUaxHlWccR8DeFC4PFD3Uh0zZd9cKHwzD7fXKeiBLXCh0WvvR
	 0A3EM/7wkoumvdmhm/aLo18K0Ey6yB3B3ruDQMufwjHLq93uWwN5eDO++CzybNADuO6tw
	 gMynLJ7H8CSILQ4fqO6D8aBe+Vjc7KGp6IS/mV+j7cjhgDvM6VzYXVNIpPSbaH177zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kt13qt3B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA668606A31A;
	Mon, 23 Nov 2026 00:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kt13qt3B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81931F000C6;
	Mon, 23 Nov 2026 00:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795394589;
	bh=j/8IZ0tYFhI/0yqSFfSy337P3mjZcrIvJ9lgLMTLLw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kt13qt3BR/by4bd+C9eQsXWcl5keoqr/gYysx0DWkADXELpyLxrMzvZGAmpZFCLRC
	 djbYhrFYaOczql8VfbYNkC+gfYQRCxo9BeF665KC8QwFhuCotqpYXJtYqyvAUd3vnW
	 vc1EnFRQB2+SW+ZclN7vmipsPgUZzl26+xgnVy9pFAtDSqls+aR9GJFGAw1tnGHQWo
	 1h+uOtN4z5nCDy4jy14xUBfusSV8Mh0cIgTRrsFfunKI861NFBllc4Nnq5GN97BX2T
	 sgTVmOl6V1NnbJt8CAsCHD4FcAotLmqjL6PhVWPM+ApFSs2iNCUdXDL/3Hvrv0G6DI
	 s5SXBbFPaOiiQ==
Date: Sun, 22 Nov 2026 16:43:07 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Alireza Haghdoost <haghdoost@uber.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/7] perf symbols: Check the file before reading lazy
 symbol names
Message-ID: <awOMG8xqEUl39vcW@google.com>
References: <20261121-perf-symbol-memory-send-v8-0-370561cbb5a7@uber.com>
 <20261121-perf-symbol-memory-send-v8-4-370561cbb5a7@uber.com>
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
In-Reply-To: <20261121-perf-symbol-memory-send-v8-4-370561cbb5a7@uber.com>

On Sat, Nov 21, 2026 at 08:41:04AM -0800, Alireza Haghdoost wrote:
> This patch makes perf check that a file is still the one it loaded
> before it reads lazy symbol names from it. A lazy name is read later
> from a file that perf opens again by path, at the offset that its
> string table had at load time. If the file was replaced in between,
> for example by a deploy, perf would read names from the wrong file and
> print wrong names without a warning. Eager loading rejects such a
> file, since symsrc__init() checks its build ID.
> 
> perf checks the file each time it opens it again. dso__set_lazy_file()
> records the file at load time. Nothing calls it yet: the next patch
> makes the ELF loader call it when it creates lazy symbols.
> 
> If the DSO has a build ID, symsrc__init() matched the file with it at
> load time, so accept a file with that build ID, such as a copy of the
> same build. The build ID alone is not enough, since the offsets are
> only valid if the string tables did not move: objcopy
> --add-gnu-debuglink keeps the build ID but moves .strtab, and strip
> --strip-debug removes sections. So perf also records the index, offset
> and size of the .symtab and .dynsym string tables, and compares them.

I think it's extremely rare that the symbol file is being modified while
perf is running.

> 
> Reading the build ID each time is slow when most lookups load a name:
> the parity test on a 524 MiB binary, which loads 260k names one at a
> time, takes 9.3 seconds instead of 3.9. So perf also records the
> device, inode, size, mtime and ctime of the file, and reads the build
> ID only if they changed. The ctime changes when another file is copied
> over this one in place, even if its size and mtime are kept, as with
> cp -p. Then perf keeps the identity of the accepted file for later
> reads. With this, the test takes 4.1 seconds. A DSO without a build ID
> must keep the same identity.

Is ctime really needed?  I think dev/inode will catch new file creation
and mtime is for in-place mofifications.

> 
> If the file is not the one perf loaded, perf warns and shows the
> remaining lazy symbols of that DSO as "[unknown]" rather than print
> wrong names, without opening the file again. If the file cannot be
> opened or checked, for example because perf ran out of file descriptors
> or fstat() or a read of its ELF headers failed, perf warns once and
> shows the symbols it was reading the names of as "[unknown]", but tries
> again for later names, since the failure can be temporary. A file whose
> build ID cannot be read counts as not checked, since perf cannot tell a
> failed read from a missing build ID note; perf reads no names from it
> either.
> 
> Like symsrc__init(), the check trusts the build ID: a file edited after
> linking without a new build ID, and with its string tables in place,
> gives the edited names.

Right, but I don't think it's gonna be a problem in practice.

Thanks,
Namhyung

> 
> The unit tests later in this series cover these cases.
> 
> No functional change, since no symbol has a lazy name yet.
> 
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
> ---
