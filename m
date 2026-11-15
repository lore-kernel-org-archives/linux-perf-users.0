Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794714666;
	b=zOPV6dTH0B0+XZWj3/+PBqN+IjYFSFpsciWgBbARTmgyMfsGqDBBDLDbdutlqbSdhZ64
	 4neoBcq1gRS10SecZPrHbkEg7JLkpDzHe4izf7lEZI6oSqVI6uJEGdjWHWy/ab4O+NBT5
	 /6wQwteYld/Wqnuf3WPxzHdW3u8CG2yosC7+KUT35gbstU+fFvGPqn/19LgyjthmC41fl
	 tSpKCeBNDDsXEiSbmBrYZD/Cvh8lCeTOaBzJJnIdbmYzPH13V7omgeywSWh/mH+A1Q76H
	 Yvh8abo75Xprh+txPO57XIsQErlvSafaOqnELR2NC3X2HcXr8rwcDoqJJeKczNBzCYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794714666;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=t/T1AoiK5chN/HSK582+jWNS5DmbyIqN0LBOShYiUts=;
	b=A/IXzWiAy60nZ25dst8XUFvaW23CWNHoRySb+V9/dthdxHs/d6KBZCx6D0BsLvVMjBZL
	 v3PvqgrSax7N+YzSGcSM3AolL/X6tE5IQATaROBW+1RdF7aH0WXE8DVgy/HZ5JBEaCusJ
	 tlcmCK59K/y/gMQHPJBiUG2MaDXfecLbJTVqLXOMEfPUXhAoclxNNPl2ggsdkaBix8dHA
	 X/CQXu8k82m62yvP/R2vuQoNkgjvZm9N4kVYjSCjqpQVGtZnIPzKyzWhT8+JQ6+nJ4Fs6
	 j3jXhYf/HhJVpyYj7UWUvtzDbLMvtFbIYxpQYHMt6eY1hlwRgMjC2sj0Tm/P8ZFj4Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G1SmzToW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B17606A323;
	Sun, 15 Nov 2026 03:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G1SmzToW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D04A1F000C4;
	Sun, 15 Nov 2026 03:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794714666;
	bh=t/T1AoiK5chN/HSK582+jWNS5DmbyIqN0LBOShYiUts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G1SmzToWboV1QlvttOJNkxBeW0pU1kDpLBd/sgCIg3YIWfnyE2zo8WBlJeEWHet5e
	 cJJnDVgvId6ao3aEIU9kixqr9DhIQIEyfMNlRGLqzmMIERXdc1bDEzHFAxcYavrSo3
	 43tYS87fruru7TDxrTjVZb8hg0kCDHdbwQ62i14Mx02cnd0Gg3rkQ2k87CMPsuSKbw
	 u1Sgh8Xb8woMiYR05qgo/ok2gP6seMtPpdKrzhP0htxDDzteCZflhrdf/sCZiSFZ0n
	 N2rLv/J+QWqQx33t9rcpzaUWalwWIObbY9pz+lgzEnsoh689uDGKaMWM4CpP0moGBM
	 o3MoyS7LUeKXw==
Date: Sat, 14 Nov 2026 19:51:04 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Alireza Haghdoost <haghdoost@uber.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andriin@fb.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/4] perf script: Add --lazy-load-symbols to load
 symbol names lazily
Message-ID: <avksKJdCK9C6wpRv@z2>
References: <20261113-perf-symbol-memory-send-v7-0-d992eced9f9c@uber.com>
 <20261113-perf-symbol-memory-send-v7-3-d992eced9f9c@uber.com>
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
In-Reply-To: <20261113-perf-symbol-memory-send-v7-3-d992eced9f9c@uber.com>

On Fri, Nov 13, 2026 at 09:09:08PM -0800, Alireza Haghdoost wrote:
> This patch adds a --lazy-load-symbols option to perf script. With it,
> perf reads the name of a userspace ELF symbol only when a lookup returns
> that symbol. Eager loading stays the default.
> 
> perf script loads the whole ELF symbol table of every DSO that appears
> in a sample and keeps every symbol, with its demangled name, until exit.
> Most of those symbols are never sampled, and their names take most of
> the memory. On a large profile this is the main memory cost of perf
> script, and in a memory-limited cgroup it gets perf OOM-killed.
> 
> The loader still creates every symbol, so end fixup, duplicate
> selection, PLT synthesis and IFUNC marking do not change. It stores the
> file offset of each name instead of the name, in a union with the name
> pointer, and SYMBOL_FLAG_LAZY_NAME tells which one is set. Lookups load
> the name of the symbol they return, and code that walks all symbols of
> a DSO gets them from dso__named_symbols(), which loads every name. Names
> are read under the DSO lock with pread() from the symbol table file,
> which is open only while perf reads them. A name that cannot be read
> becomes "[unknown]", and address lookups do not return that symbol.
> 
> A few names are still read at load time: aliases that duplicate
> selection can tell apart only by name, and IFUNC symbols, whose names
> PLT synthesis uses. A .dynsym entry that copies a lazy .symtab symbol is
> skipped, since duplicate selection would drop it anyway after reading
> both names.
> 
> The offsets are only valid in the file that perf loaded. perf records
> its device, inode, size and mtime, and checks them each time it opens
> the file again. If the binary was replaced in the meantime, for example
> by a deploy, or the path now resolves to another file because a mount
> namespace went away, perf warns once and shows the remaining lazy
> symbols of that DSO as "[unknown]" rather than print wrong names.

Please separate this part into another patch.  That would make my life a
bit easier. :)  As I said, you can use dso_id instead.

> 
> The kernel, modules, PPC64 .opd and .gnu_debugdata still load names
> eagerly.
> 
> On a 45,073-sample callchain profile of a large C++ service (about 1M
> symbols), lazy loading cuts max RSS from 327 MiB to 135 MiB and run
> time from 2.9 to 1.3 seconds, with identical output.

Nice!

Thanks,
Namhyung
