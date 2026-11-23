Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795469030;
	b=zW19lb50PNzZbVtAh8v4EpuoBP2hRI5uIDKn2P87xToiJ5meXQBwxw39eIcKmoDuHMcl
	 r9IMukpG15fZPOQjwS28Y2RSLi/gDuSMh0DYt31AmeoCQtJoeU+1tt8Y9I0fY3gzoJ6i7
	 BHady+JrVUbB70VlU8Z/ddFRZUSYSGEqFsEhOA/Ob164yPezrmEPS+8rs0fTrY1Lzv9n6
	 h6vksJndrVnKE2JYea8RQwccXRvsVwNV9ZNWQ8JB+HCK3AScO+Ck3J1cLT9M+BYMur4nP
	 wc9J18A5i5EOYAwx0f1Ff/drbr0M2cA09E3PUj4P/3yrFTbix0WEtXb21ThzBtO5GHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795469030;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=L9arw8uulMcbtVNjgAjlGcVokaNfxf2DL2AlS+yu3DM=;
	b=zS5UfndM90MRTfwsCsLelEnE9sRb8T+8y0/x2TLxBrNhQFuoihbQSYZG5y8xXq3OM7Ot
	 w/k8wOa3/auyUMdUsyl6Ko7cU1H7gOzxLTLNXfhdP8W0e8aJ1KzuM+H+xk7jPjXt+McT7
	 ySFSiYwTGeAkosWWQHK7D5ZaOjWSZyvYNhQh3vHkOJhg0wzfyHtExgikZMQXZpawfgi7o
	 iHomEaarO8WZBcX898O4jNZ73KZkVo2D4nfG7/42tPih74z3ZbKs9texqE8dZYETTxt0Y
	 wfVqceuWk0RTXCbDYhex6ErmmAhbvxcfV5lL++jMaxr1GOVDyR/HMVu9bL6E1sLIKng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BAlpIgim;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB75606A327;
	Mon, 23 Nov 2026 21:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BAlpIgim
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58471F000D4;
	Mon, 23 Nov 2026 21:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795469030;
	bh=L9arw8uulMcbtVNjgAjlGcVokaNfxf2DL2AlS+yu3DM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BAlpIgimnKAqTRN0Dbi3sG+Eje7AFZjJiR4oRmHxMIR9ZcFzp6p9iIIS6i+mNU0KK
	 C2wRJVmU/OPqHfXP5JsRlOHDlfshDnVc444hg/nmoMfpFPNMmum7hyQqwJYbaPweRF
	 z0AN5f1NoAau18yqQ9IVUuTzTaBhEP2SXUumzXF3hguHSo5eUxarklyaGUVOG0D9JY
	 ZAnyC+YiPhbzovGUVmYrA7mGHInUwchQJ4D/cApIZrO+O7hqpolVY0MBcT+XcMEzui
	 ifJihLblUVEGliVUkR9/HFoZk5rQynRwCJ2afjr+7NxEznNuhb9lkwtBcUaVLcjzrp
	 MURQnpKQuARGA==
Date: Mon, 23 Nov 2026 13:23:47 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Melo <arnaldo.melo@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf build: Only enable context analysis with Clang 23
 or later
Message-ID: <awSu48pUIh942Zm4@google.com>
References: <20261123-james-perf-late-parse-attr-v1-1-cfebcd81a962@linaro.org>
 <CAP-5=fXuQWTt1F6BvKSXqgSkEtBQPKvKg6gmAe-ngyr4VGyGig@mail.gmail.com>
 <EC27692D-9692-4976-B7EA-4C3A91173CE3@gmail.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <EC27692D-9692-4976-B7EA-4C3A91173CE3@gmail.com>

Hello,

On Mon, Nov 23, 2026 at 04:55:16PM -0300, Arnaldo Melo wrote:
> 
> 
> On November 23, 2026 3:44:12 PM GMT-03:00, Ian Rogers <irogers@google.com> wrote:
> >On Mon, Nov 23, 2026 at 8:46 AM James Clark <james.clark@linaro.org> wrote:
> >>
> >> Context analysis requires Clang 23 or later (see
> >> Documentation/dev-tools/context-analysis.rst), otherwise the build fails
> >> on older versions, e.g. Clang 18:
> >>
> >>   util/env.h:142:39: error: use of undeclared identifier 'lock'
> >>     142 |    struct rb_root          infos __guarded_by(&lock);
> >>
> >> Only enable it when the Clang version is supported. Leave the other
> >> thread safety options enabled if they exist because they don't cause
> >> build failures at the moment, and might provide benefits even without
> >> -DWARN_CONTEXT_ANALYSIS.
> >
> >So we've had -Wthread-safety for a long time in the perf tree, I'm
> >guessing __guarded_by is missing on older clang versions. Can we just
> >stub out the __guarded_by for these old clang versions and keep the
> >lock checking?
> 
> Looks way more reasonable, and no need for a feature test since we know
> the compiler version when __guarded_by was introduced, right? 

Sorry for the trouble.  I checked with clang 21 and it didn't have a
problem.

Thanks,
Namhyung

