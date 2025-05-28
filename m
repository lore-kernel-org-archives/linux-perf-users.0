Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1961DE89B;
	Wed, 28 May 2025 22:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748470692; cv=none; b=AHJGGm3gXTRh3NM0k5emSjKyZxDx/D/O8bzirqJ2yukzqBzUw/Vh9FjkorzuKEWPonj1CKFE/AYjUNWcwMuz0qkQgFAWVH+kw309H55/kGNq3Q4GwXw6vG1I7xL7+5cqslHRff6K7keEiMH9VnXHv5jUKoda2ScCw9Vqi6lHE30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748470692; c=relaxed/simple;
	bh=i10iblRPByubcH4c4iA76dJU0SdrOWEJ/QYvMMGZpAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9JO6RtvsQxFJ1jTPVboLpGeJYa1e9r8cDApZtgFGArDhtvloivwQUv0n4XB8xFSV/VvmT28+hlYxX8EoKhlbcSZB0zIeMiOsncHHJr/eci0Ktn0UvFaeJY/PZ1WX3plaY/eS4NzCPIbQQgJr8h2OIhL5DSHvcuHJlndfdujyhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AR7CEia4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AR7CEia4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A0EC4CEE3;
	Wed, 28 May 2025 22:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748470692;
	bh=i10iblRPByubcH4c4iA76dJU0SdrOWEJ/QYvMMGZpAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AR7CEia4ly2PrUrgrZN+XJ779uXZpb7kiW313IxR8xzQWVK6vJ02PUSsXS9lr/b0p
	 3A4bLa6ttmnD3LKqLzt5VgdQiOz3JFlhUT9LG/62ae7o7bz1qfW8VvezcZtDxoRtcY
	 4lYEraOJioP6cPkWgcz+GEmZPtoRUJ7t+n/mO18TWKxteXWY9L3MpusHELvldWJ1zM
	 VY6iw7cprL4LaeP+6sZTC+dNjAQdQspGij4yhe5nC/JvprXCpk8jpfzCsrh8aBvv7x
	 ecs8hOFIBFLDZBm8OeL4fyfSwxleRtCkclpTsW5iy8F20fily17RQBlJ5B10Qqe0y9
	 0QQueU4R1xfPw==
Date: Wed, 28 May 2025 15:18:10 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf symbol: Move demangling code out of symbol-elf.c
Message-ID: <aDeLou32h8k1ECJc@google.com>
References: <20250528210858.499898-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250528210858.499898-1-irogers@google.com>

On Wed, May 28, 2025 at 02:08:58PM -0700, Ian Rogers wrote:
> symbol-elf.c is used when building with libelf, symbol-minimal is used
> otherwise. There is no reason the demangling code with no dependencies
> on libelf is part of symbol-elf.c so move to symbol.c. This allows
> demangling tests to pass with NO_LIBELF=1.
> 
> Structurally, while moving the functions rename demangle_sym to
> dso__demangle_sym which is already a function exposed in symbol.h and
> the only purpose of which in symbol-elf.c was to call
> demangle_sym. Change the calls to demangle_sym in symbol-elf.c to
> calls to dso__demangle_sym.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
