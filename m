Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795075784;
	b=N9DTzVYRDjOVp453o8v7D66cZkNEG580Heu53AIoh/HiwYgEsOYeLCXfS7OFS5SZKmQP
	 OLJAtmjnjsJGfAaieUawO9oK/U3YBGiWdp+jLf9Aomjr7uKBuVA4M0lGF5gPgNKo795Rq
	 bsibrbA0UTco4arunXOWnIpzy/4uGyrVvY433txd+hgIHdGZRwQ+uSCMONIBFOUfe7tij
	 tGtZQrpclmolbEl5zBsZod+o4phCvgz4Y6JAXa0Kmt5jnrosf4fNtmdXdg9TEsw9sa3oq
	 IH1KR3SqLDNJ0I3DsaOSR27/ylx0z0HHtowHtl2oAvvFUbfBGNwLIPRHs+MtZA1aG+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795075784;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=dQlgFf4t/hUAlsRbzT8JuKis1TFbZr9UMi09698M+9k=;
	b=itl4DdWbZjjW4s29YlaRjuo93w4TtnAJVb/KroFVKHTnfenfJgGOHc2YjJ4mvvJtqQeW
	 GLI9Kkz/0gGxKNM+qS8ZaAqnydGQFZzuv5/BUxicJqxff6LxX7ziU49cituXrNp/FRjgn
	 TWCKZ40JmhVhefnijlFzt5HgMM+KZshdoeEOO3rRaxvqWebL0Zw90N/uslbl+OjGcLyHn
	 JXmAcHS+YhnfGkfeUHSkbKsQ14t+Awd21HBmWeCqNx6rJ8iZRI2/L/QapBVuuZebrrRDA
	 HgdwHAq/W2oyEeNy06GJ+sNnhbRU7n1KvapwIUAAcsZ/EvkttF+FE7p9NvnszJmgOgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X75dVxjd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD00606A320;
	Thu, 19 Nov 2026 08:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X75dVxjd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EEA1F000C4;
	Thu, 19 Nov 2026 08:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795075784;
	bh=dQlgFf4t/hUAlsRbzT8JuKis1TFbZr9UMi09698M+9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X75dVxjdJYKkI2ps1jyseWaiwD09If8e5GGie5ldAvjD+ayrNh8J00HEQe2k3AdJw
	 uQpCvzhlNRuwTlvuh9EoPYnRY6GCsyvyo4i8mlzMc2t7S6MYULdvFeT/Ete7gs7iRk
	 HXcrHhhYpgx1+9C+xCixdqynJhaa1wdiXWQvYU3hllYRKFw43DamvuN6WmgtBQ11s0
	 GJWX2ABxXKA+X4f/r+J+8Z11EYKy47nYTmOp4G6hH0amTdvj8itEoS/EP7TlMSV9Tg
	 TI0K6TuYyAFg9Id+uA3kBWBjabJ557Xm6tNCHuJNmgTstBBEXo6J5jQ6oV+iC5MrpL
	 aCN9gqP9BAbIA==
Date: Thu, 19 Nov 2026 00:09:42 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Gu Bin <gubin@cmss.chinamobile.com>
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@redhat.com, irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf trace: propagate evsel__set_filter() error in
 trace__expand_filter()
Message-ID: <av6uxj_pkVK27sCO@google.com>
References: <20261112080924.2082-1-gubin@cmss.chinamobile.com>
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
In-Reply-To: <20261112080924.2082-1-gubin@cmss.chinamobile.com>

On Thu, Nov 12, 2026 at 04:09:21PM +0800, Gu Bin wrote:
> At the end of trace__expand_filter(), the return value of
> evsel__set_filter() is ignored. When the strdup() inside fails with
> -ENOMEM, the function returns 0 anyway, leaving evsel->filter holding
> the unexpanded filter, which still contains the symbolic constants the
> loop meant to resolve. The failure then surfaces later and indirectly:
> evlist__apply_filters() passes the unexpanded string to the tracepoint
> filter parser, which rejects the symbolic name, so perf trace fails to
> start with a filter syntax error whose real cause is the missed
> allocation.
> 
> Propagate the error so the -ENOMEM is reported at the source and the
> caller fails immediately.
> 
> Fixes: 90df0249c2ea ("perf trace: Expand strings in filters to integers")
> Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>

Oh, you already sent out the fix. :)

Thanks,
Namhyung
