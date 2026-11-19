Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795073664;
	b=Ckzwx1ASUK9cSR1ayM2j1fnF8ptBylP//nH3UqkM8kxa3gC8pkSFruutA80JBajEff+N
	 wDYMVMO/FqJW7aYcFfOq72sqLamPT3bqA129ldKjfIGZYiYPLVqKaS0O9r8N7X7rE30LE
	 mR3tML1VjpAtj8tfHfCxIa/ci967GARDZwhG+Fpqmhb5Rmew9s5ZLggJqB105abZWSkaB
	 P92vyeBq4ycunV1wNig5+uFVjxxaE3Je4X4mDAeWQYAJ674GBETcXQAD6MUOMkcf2cFvZ
	 RW5cuzo3R+qk0e7r7V2ew/zDssXHlWU/CVBoJdMYnQyqHkpmKGjoEL/2yew7Plqg9pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795073664;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RBP1636V7rkc9bvMHK0Xs/w55HL9/wj9K7hRLODxY9Y=;
	b=LAxFXe+s+OZejfyZMqXKQqfrNfF0Ae9DAAF95mpv6iOy4l/zwIMRNPpo85Vzz31lpq2D
	 k39kvDKIEAePYVYKvKtZRwwxjBb23XOLWohPzIHqzrESpiTerfVDJ48S7lch5ZtgbMIZX
	 4FNaSO4Ckjb5bZ2P90CUPK1iE3KVg7KQpyJ97rxpMY1TWeW3cPZX1f+2p4RpSmJ0u9YEy
	 ClxHyhtpdw0hhLFVUXD7NRACfx+r3iwe69WbdLtoe2diVU+aFsCHxl8rdIOb8f+P3Mk9h
	 qmoklUXlhTGCSJ4mrmxEsfrwEvYGRqMXf++/KeZ3Hhj/pTd4g1TQANIdUFuaitz6qtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RsOMQ5UR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12674606A320;
	Thu, 19 Nov 2026 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RsOMQ5UR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426281F000C4;
	Thu, 19 Nov 2026 07:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795073663;
	bh=RBP1636V7rkc9bvMHK0Xs/w55HL9/wj9K7hRLODxY9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RsOMQ5URbLd5g86g8EV07CAFmIwrcI9h2Pommh6VStxejR0HIoItKN3hm517tivtH
	 kltsvtebug0CDIkwBurKc/5ExVA+NJ/R9BQkBWBOhEPD5FAEPxI9LyB0vs+MLV6lN5
	 E910yFAS58Yk9nfr4x4XgiSiraLv8ZA8IpZ2KK1cDVsrUWIDtTUOpTQylBnup6vfry
	 dY+0Yl+L0Jz+pm7kd+dLvOuPIyVduUXnUsyrdJbGJlfZxXqkICoHrdqibhz+/elYwE
	 aS19xWlsovPYB3LO+1mzQkpbcdK5C4J8tF8NHUY8vFuI1LNorguE0FSm1qu+6yNfV6
	 DAx3/zBpexz2g==
Date: Wed, 18 Nov 2026 23:34:22 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alireza Haghdoost <haghdoost@uber.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/9] perf symbol: Sorted arrays, DSO-owned lifetimes,
 and memory shrinking
Message-ID: <av6mfhEBYhJUebPZ@google.com>
References: <20261117185305.108003-1-irogers@google.com>
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
In-Reply-To: <20261117185305.108003-1-irogers@google.com>

On Tue, Nov 17, 2026 at 10:52:56AM -0800, Ian Rogers wrote:
> When profiling large binaries or long-running workloads with many DSOs and
> threads, symbol and DSO tables frequently dominate perf's memory footprint
> and startup latency. Currently `struct symbol` has several structural
> limitations:
> 
> 1. Every `struct symbol` embeds a 24-byte `struct rb_node` for the
>    `dso->symbols` address rbtree, plus an optional negative-offset
>    allocation prefix (`symbol_conf.priv_size`) for `struct annotation`
>    state even when only a tiny fraction of symbols are ever annotated.
> 2. `dso__symbols()` has no internal synchronization against concurrent
>    readers/writers, and `struct call_path` (plus Python callchain frames
>    and nodes) still retains raw `struct symbol *` pointers without
>    retaining a reference on the owning `struct dso`, preventing
>    unreferenced DSOs and their symbol tables from being safely reclaimed
>    under memory pressure.
> 3. ELF symbol table loading (`dso__load_sym_internal()`) repeatedly
>    invokes `libelf` section/program header lookups per symbol, calls
>    `elf_sym__name()` before filtering out non-function/non-allocated
>    symbols, and resorts `dso->symbols` with `qsort()` even when ELF symbol
>    tables are already largely ordered in ascending address runs.

[...]

Applied the first 3 patches to perf-tools-next, thanks!

Best regards
Namhyung

