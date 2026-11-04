Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825692;
	b=n/CazxrvjknG07sVcAXvNqySa69Vy0RFuQmw/19SfZz7Ant7QzRBBFuKmfeW5UDbiDqy
	 eIVQEAKkGRCRDIdUCoFpufB9ObuJX0kvlO3ANejuBOZMr84SVO3jNFx+6LE7O3y5iuA7c
	 Bt0NWMlkPl7BcoyMT3f0jGavYdFCfOlxNXdnDrGE1YIEPpUCwkq74+Pdvmd0B42B4OwWA
	 Qnvgt8LUwj9X+c/7x+aMuJ6DoNg0uzqKCIFdVlCcNa0Z0GPu7dTN2HfITnZFOLMa3VZZ7
	 WSeSlWDHmH2GH9VklStuLw7Dz0Xgdkwbz/BieD65np9PPmpedAr/4TYNHgr7GxVFvxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825692;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ba9/h+V5Meq1wkITvXegwitThM7yj544wxqsQCz0yS4=;
	b=rawiaege3TrvKjonky7c5jHP7W4IpLEZ3/2hCqyx70LxPKW42ExmqPU1+jv1ql5BZHnI
	 uxrPAxetNXqsONgjg/SVGzC9ERkoGP2Ud6tCFAjXDg3RzbRlggISUQoAKysnQbgUXX8H6
	 sxuujT2yjb7bQ7Jlcw3hJjjP68qYb59OpRJRQOWlki9dzkRfdxoeJa8pJIMj+2kSiucvr
	 9R+YOqi33bQJ6vaIx8ABg7bYXMI4ouurh0JbZtDh9LYu3cm6G69O+u3CIWtNJWcKXsFx7
	 w5mO3UTiFU+dok/mETAztubInn0/yPMvwdmW0VCPhTW2O99N+bj3L2PN0dep+nq7Jkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BrWWwPZ/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8532A6078151;
	Wed,  4 Nov 2026 20:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BrWWwPZ/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7C31F00919;
	Wed,  4 Nov 2026 20:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793825692;
	bh=ba9/h+V5Meq1wkITvXegwitThM7yj544wxqsQCz0yS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BrWWwPZ/la4ATP/U6VCWAA+Ay8vb+pI4aLCctpwOU/zMy/bMxt4GrxmKhgwcE7/dU
	 Uea3jr/2i8A3ju8bcfHOXCp1/A72Ws+XAWHa0s9dIr2ZTZt2s0tB1ripQME8KJXQVq
	 KEE1tDTSfVC0rQqdL4IK91N9fPKySk7xqyQL/Gn3k4eJ7vivBtoHm8btEDnXbvgbHU
	 fXfEEyFvP8Keq55p5ZmbehR01qbmtNlCSyD5ogtsHtBfJQY/fLUgUcpQz2kIjoOZWx
	 ByHXmrQatZSTZy8ucOmP6/8NcPPNRCzRR5bczsJdx7MF++zmRPw221m4foOL4zp2P3
	 tKLFs2+Yng76w==
Date: Wed, 4 Nov 2026 12:54:50 -0800
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
Subject: Re: [PATCH v6 1/5] perf symbols: Fix broken ELF_C_READ_MMAP fallback
 guard
Message-ID: <auubmvsLenOI2EcV@google.com>
References: <20261028-perf-symbol-memory-send-v6-0-7e90415f0101@uber.com>
 <20261028-perf-symbol-memory-send-v6-1-7e90415f0101@uber.com>
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
In-Reply-To: <20261028-perf-symbol-memory-send-v6-1-7e90415f0101@uber.com>

On Wed, Oct 28, 2026 at 04:42:32PM -0700, Alireza Haghdoost wrote:
> Commit 22dd1ac91a77 ("tools: Remove feature-libelf-mmap feature
> detection") replaced perf's compile-time feature test with an #ifdef on
> ELF_C_READ_MMAP. ELF_C_READ_MMAP is an Elf_Cmd enumerator rather than a
> preprocessor macro, so the condition is always false and perf silently
> uses ELF_C_READ.
> 
> Perf already requires a sufficiently recent elfutils version that
> provides ELF_C_READ_MMAP. Use the enumerator directly instead of
> restoring a feature probe or retaining an unreachable fallback.
> 
> Fixes: 22dd1ac91a77 ("tools: Remove feature-libelf-mmap feature detection")
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Reviewed-by: Ian Rogers <irogers@google.com>

Applied to perf-tools-next, thanks!

Best regards
Namhyung

