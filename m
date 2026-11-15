Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794713756;
	b=tmyu65s8DL/aEZJUqr9P9s1Eica454fhagjdQKXx+6Cv0Zt2JdyTrqND4PLBwZPrpDsl
	 Nun8kA5LIz8pQDoOjzIUOw1p++GIordyjDaPDoZTwA28988SBa4clUBxfZ0u/HUHRM66c
	 IKXi5BjnrPA8qAUiT8IuQZJzWq5WPHe0coMAcZZHfV/BQ1ibTxnR5HexY+YOPrpD7Zrmo
	 lnHb1YpXBNTbFcCIRU0YJD0EMBoG2sM0jCZFnDNQohPQvQigAtoOBeYAO0laQKGoMwe7V
	 +38J+eREZ2PGEFRlqQGC+rySzaUGXBsYN6LU9RRT9N4K80uboo0PdrCTrnWkB86MDYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794713756;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xj85yJAZaXoh6bgVlC9M6LWcwat1hk8ga6yA/c8AFw0=;
	b=nExlv/IBzCownHRDjCz+mpMzctJHbPHaIsIumC6SyR5s48iw5zzq0kibb40TjtsJBu0E
	 YU9NQhTkmBMnlK66rwOdv5n1EikbbnoKEiZ6CirtDtgFMNXJPAuuRulHcOwkf6CLU+aDc
	 y/HJncwfqkUn7zOxEIgHp701YJynHvWdIShEo1yvIM2nyo07WqZhl8454lDbygGrth4oP
	 nDMn57X7MxAKjeWPw2hRG5O+dtpgqKXza0DF4Ppl+TBY0aUcA86JvPPmvA3MUxqPeMVEx
	 c6KJ/evtkOSPBquG9JNtmb1iK1nFBD0ciTTJkd2zHuv1MDS16osRlXC7U/vouFAOGew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QnA5ai1p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13DC606A327;
	Sun, 15 Nov 2026 03:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QnA5ai1p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2E51F000C4;
	Sun, 15 Nov 2026 03:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794713755;
	bh=xj85yJAZaXoh6bgVlC9M6LWcwat1hk8ga6yA/c8AFw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QnA5ai1poblvRX4quMSLEYeTOn17d9k8mahBftE5XXYhuUNkhzXLJfguwLM/NWbF0
	 j1ir0LqqAoxyfEYDB8ReU3qjUBGgN4Qm5aoKIkMen/zNKB8D3wsKMEBmZzLBMesOtm
	 SVAQRrV7dv/uUVBHxN+jONsDH7ilRX1Tlh0aJgtX6gx9nWeDRBcwpVTEVG/B7wrs+t
	 +PhOswdKs+EPndryuCXkvxFYwp6b8SATf28sobHpNnj2XggdQXZpWoFsqLQ8saOgMR
	 hXiKqiRddtz2ij42D8MEEwPeNc/jlu5SD1qL637xIzsrvcC0h+uVy7HcW+Fz6r4T/8
	 AmY2kEuhKwWOw==
Date: Sat, 14 Nov 2026 19:35:53 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Alireza Haghdoost <haghdoost@uber.com>
Cc: Ian Rogers <irogers@google.com>, acme@kernel.org,
	adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v4 00/23] perf symbol: Sorted arrays, DSO-owned
 lifetimes, and memory shrinking
Message-ID: <avkomXhSg5evA7c3@z2>
References: <20261110220803.2503416-1-irogers@google.com>
 <20261113171734.2188066-1-irogers@google.com>
 <CA+w=M=SnFtEHA9NhSM8gyCGuA19Oazpx6X7yYTtgatsi3rKfCg@mail.gmail.com>
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
In-Reply-To: <CA+w=M=SnFtEHA9NhSM8gyCGuA19Oazpx6X7yYTtgatsi3rKfCg@mail.gmail.com>

Hello,

On Fri, Nov 13, 2026 at 09:25:34PM -0800, Alireza Haghdoost wrote:
> On Fri, Nov 13, 2026 at 9:17 AM Ian Rogers <irogers@google.com> wrote:
> >
> > When profiling large binaries or long-running workloads with many DSOs and
> > threads, symbol and DSO tables frequently dominate perf's memory footprint
> > and startup latency.
> [...]
> 
> Hi Ian,
> 
> Thanks for v4, and for pulling the three fixes out; they are in
> perf-tools-next now. I posted v7 of the lazy loading series on current
> perf-tools-next. I apologize for the late turnover.
> 
> Lazy loading stays opt-in there for now (just don't have confidence
> yet to make it default, see
> my reply on v6 4/5). From reading v4, the two series overlap in three places:
> 
> - Both use bit 14 of the symbol flags: SYMBOL_FLAG_ANNOTATED in 11/23
>   and SYMBOL_FLAG_LAZY_NAME in v7 3/4. Bit 15 is the last free one.
> - 18/23 replaces the rb-tree. v7 3/4 walks it in two places during
>   loading: the alias name loading before symbols__fixup_duplicate(),
>   and the check that skips a .dynsym entry copying a lazy .symtab
>   symbol. Both would become walks over the sorted array.
> - 15/23 defers elf_sym__name() in dso__load_sym_internal(), the loop
>   where v7 records the name offset instead of the name. Both want the
>   name as late as possible, so this looks mechanical.
> 
> Namhyung, which order do you prefer? lazy loading v7 is four patches;
> if Ian's v4 goes
> first, I'll rebase v7 on it.

Thanks for understanding.  I have no preference and will merge whatever
ready first.  It seems your v7 needs some updates.  I think I'll merge
some of Ian's patches first but it seems that's not part of the
conflicts.  Let me take a look. :)

Thanks,
Namhyung

