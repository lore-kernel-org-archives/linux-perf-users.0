Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794715563;
	b=sCHRUaF1llX9M+n9Q910Yiog7wMORJZe8X/Xa1TR5OlsSiCR8wnqO0O8D2kz5+R6cVGP
	 o2cUTg2yi9iaZ3eWy2Ap4NflDAL10Jmp5LjMsOmlaCMfryJf+dsugzvdiDTYuDPA1xAsn
	 8p3wr9fAImSsvgeIOmG0YZqMGffT+uozrpgF0bfQVc90SfjcjIhE5egMsGHof76oJyC+O
	 0OAf+v+N0sJSR/41dLj7WxEpO2xROcuGBD047DvoVC4cRc8OtjsBQiARB0ht0EAF46vnQ
	 MlgJZxJ5VNmUqXoP33mABGydmM7TIFmHOZYObp8J3cbKWG/1ZomLSGj+Se5BcWMN1rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794715563;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qItG3cn/R/98K+KZGFwBScGLlparnaFDe/yLSyp2wq0=;
	b=FFHL9BmERZvuTV7u4k6alo1iyMZutrbZWQbNNPpP4+c9i0FwgeLLZEAKX85g45aQzAom
	 x2/OSvVk3CEdo2mARntlzyDG3vLhBtcoKDSf3UpZEFT+SsZ0Ar3QK/mMeHeBFilCIYPFe
	 BbrX2aOh53NRYZ73miDGhev+sUARjEZUJpsQjguFHp63h5Jf3p/y7BFE+kxg1/jH+SsuY
	 1rz5UQsRvWzjylgecrH0s3pN6jCaJ/q26U3MIa6Eufhfn0cdtK1mCJ9YAYZKwuxgXQgtQ
	 IvI6KtQ+0XEmTZ1pleW+4snJu76TEyfB+zKj7Sa/pNM+59iayDDjdWj2TAv/63a204Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DD4jzoS8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CBB606A323;
	Sun, 15 Nov 2026 04:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DD4jzoS8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108A11F000C4;
	Sun, 15 Nov 2026 04:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794715562;
	bh=qItG3cn/R/98K+KZGFwBScGLlparnaFDe/yLSyp2wq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DD4jzoS8LOyWO8HT8O48Ngd5+bKy2d/jCPORNhdzDFLoHNkEO9kXxZoipVtE8yT0n
	 Nky0hRdaKnbWQZYwXIbqM9r+Ut03pxWRbW+yWbAX8DFFRh0BgzvYB3fw6vbe2r6RBv
	 jJrlz9UyREIOobQ+mke8BF9UwLwQrIr+1l0iEKYZ0UrTIez3VPRtNmM9zHUl+B9gIC
	 zzKLG/J2Ec+++GN3VFxLIKWOo67JBGSOv+vGFPGHlZmOWcNJUcbf4LB2H3e7G9zLGL
	 FEYnAHO1OT3VEE+DzBAjXEl6yDdHo/SDSv1KVtFtJoVUqC+H+EqWnh5xGvWh6ESkzE
	 buk4tyVMsJhXg==
Date: Sat, 14 Nov 2026 20:06:00 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, haghdoost@uber.com, adrian.hunter@intel.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v4 11/23] perf annotate: Move struct annotation to a
 hashmap and remove symbol_conf.priv_size
Message-ID: <avkvqOTFLHODjjrr@z2>
References: <20261110220803.2503416-1-irogers@google.com>
 <20261113171734.2188066-1-irogers@google.com>
 <20261113171734.2188066-12-irogers@google.com>
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
In-Reply-To: <20261113171734.2188066-12-irogers@google.com>

On Fri, Nov 13, 2026 at 09:17:22AM -0800, Ian Rogers wrote:
> Previously, enabling annotation added sizeof(struct annotation) to
> symbol_conf.priv_size, bloating every loaded struct symbol in every DSO
> even though only a small fraction of symbols are ever annotated.
> 
> Move struct annotation storage to an on-demand hashmap in
> util/annotate.c keyed by struct symbol pointer, guarded by
> annotations_lock and tracked via a new SYMBOL_FLAG_ANNOTATED flag in
> sym->flags so unannotated symbols pay zero lookup or teardown overhead.
> If allocation fails in symbol__annotation(), return a static
> empty_annotation fallback so callers that do not check for NULL remain
> safe while mutating callers check for &empty_annotation.
> 
> With annotation, TUI map browser indices, and db-export symbol IDs no
> longer using negative-offset space ahead of struct symbol, remove
> symbol_conf.priv_size and symbol__priv().
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
[SNIP]
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index 6347bd218ad5..a0ad62e452be 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -78,9 +78,9 @@ enum symbol_idle_kind {
>  #define SYMBOL_FLAG_INLINED         (1 << 11)
>  #define SYMBOL_FLAG_ANNOTATE2       (1 << 12)
>  #define SYMBOL_FLAG_IFUNC_ALIAS     (1 << 13)
> +#define SYMBOL_FLAG_ANNOTATED       (1 << 14)

Do we really need this?  I think we can just check the hash table
without adding the flag.  Of course it requires a read lock, but
it'll be needed anyway, right?

Thanks,
Namhyung


>  /**
> - * A symtab entry. When allocated this may be preceded by an annotation (see
> - * symbol__annotation) and/or a browser_index (see symbol__browser_index).
> + * A symtab entry.
>   */
>  struct symbol {
>  	struct rb_node	rb_node;
> @@ -135,12 +135,19 @@ static inline bool symbol__ifunc_alias(const struct symbol *sym)
>  		SYMBOL_FLAG_IFUNC_ALIAS) != 0;
>  }
>  
> +static inline bool symbol__annotated(const struct symbol *sym)
> +{
> +	return (atomic_load_explicit(&sym->flags, memory_order_relaxed) &
> +		SYMBOL_FLAG_ANNOTATED) != 0;
> +}
> +
>  bool symbol__is_idle(struct symbol *sym, const struct dso *dso, struct perf_env *env);
>  
>  void symbol__set_ignore(struct symbol *sym, bool ignore);
>  void symbol__set_annotate2(struct symbol *sym, bool annotate2);
>  void symbol__set_inlined(struct symbol *sym, bool inlined);
>  void symbol__set_ifunc_alias(struct symbol *sym, bool ifunc_alias);
> +void symbol__set_annotated(struct symbol *sym, bool annotated);
>  
>  /* symbols__for_each_entry - iterate over symbols (rb_root)
>   *
