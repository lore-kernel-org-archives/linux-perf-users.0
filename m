Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792770516;
	b=ixGTpKvep69WRLE2FpzX7FaFMH2C0jDBnUZv8zPo4p55KWOhiTLd1xJZHyaKGf/dl5E1
	 M4eAzWGnqgcf1Ov/1s1DJ9C0vKfTgViA5sYRBfdMbPOCWOBz6cPBaBX6BXs81u+Pjk72S
	 3+apVPSR3JCSX27tvUI1MAtpaJi97TaGI7mhKLgUsbh7tpsEhwAwFvgYsAWMqmpQyaw8e
	 6KR5JRmqRI1eKnXjYvT8yktAwkc0fo0NAL2BTnedGXm6u2PTbRuOUkRyEIMuEBn6e57p3
	 wgvD+ChBdZUChifkVRu21uPYHZdFXzuedyNcKBFxOnDi8V0LhaRvTLsFxY8Lly8V25A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770516;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=c/nQuNgqr5JoF8kTf6JfE2TgPlE+md4SsGtiiJskVzI=;
	b=TWhjC6Q57EQ90IDh0ENoOTM2gIhTFO1I5psTUDTvxR4e4PQxaJCKjbl2Pa0E6eWxOuHx
	 kauDt56DGFRApWKwnf9VpTRcbceekUXyDBsXF+F3CCGWXt4vdp0uk/wXeKgo2Rs8qmqd7
	 o2KWYEyUTd4P0W165kOnunsCa+CM9lKtUybcyJIINP50L8Tl0+fYWem6tPC5ksTvLjcpq
	 Dh1CnHcJ/rG4QiTh44emtyUBKuTcw/Riz+vwyOb9qoUGywrhKPzri88XKYoLjfnYGCXXA
	 jSa3IL1CEY95PxbI7RltvvGCpeQgXgeUpsP4YUFF2kXwa2Akt+zBVaMXIDZK+etIx0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O+o7Geem;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7747C606A31A;
	Fri, 23 Oct 2026 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O+o7Geem
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CE01F01825;
	Fri, 23 Oct 2026 15:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792770516;
	bh=c/nQuNgqr5JoF8kTf6JfE2TgPlE+md4SsGtiiJskVzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O+o7GeemDORYEayoxdVGYJqXHNXKxOs12jZyfcrpJK/RooZ5Uw7tLWRqS3wKoxkFT
	 vvf/iwbyZWtWPWRhCi3IjCLEfNCl+6BywDIPEVegSZ0k5e2oDRIdH40BmojDdEq+A0
	 dLMYnVYt2ONxCVB58AvDs2AoIT4pTOyQcN+s/8B5/mMncMf/Wj3kWKBvVONsHXutuz
	 Au/m5H3w3AAFPNsN9IltayQsSpSqB4V5FuZiYVD2lj9nE7/uK0N0Vxxz5K5pB83N4t
	 7B6hWZiu45bzqx1669Zbx8LTqOBc59OyetyPGZ8vA4qcLbUfkDdTyyxDxYCxixK/kv
	 +O27vwYwJ6LYg==
Date: Fri, 23 Oct 2026 16:48:29 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	elver@google.com, james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, ndesaulniers@google.com, 
	peterz@infradead.org
Subject: Re: [PATCH v8 00/19] tools/perf: Adopt kernel
 compiler-context-analysis.h annotations
Message-ID: <att_boYgsUyMVBQQ@gremlin>
References: <20261021223905.715051-1-irogers@google.com>
 <20261022201453.1717523-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022201453.1717523-1-irogers@google.com>

It doesn't seem clear to me why you are constantly respinning this series
without feedback since v2 (AFAICT)?

Also not sure if in-reply-to is perf style, but neomutt is struggling with
this thread at this stage :)

Anyway, it's no comment on the series, but my workload dictates I won't be
able to review this unfortunately, so could you take me off cc- moving
forwards? Thanks!

--
Cheers, Lorenzo
