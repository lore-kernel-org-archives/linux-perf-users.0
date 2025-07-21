Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DC91990D8;
	Mon, 21 Jul 2025 03:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753068800; cv=none; b=pZJN1IYM/F0GE/+glV/E4jBwRd5KESIkiZp0glIrAVS7Kbjj6W4RB4R8SsytEh7mEUlWZajLiVeo3fdiQoyItJkC4pGCfjxz2RQp4JsVOK8LV+Yh0zyFbAj4UHogqiyyMDsBaEaxS8/yV/Os4Io391T+RjQYZ2ftRCWPfz7DptI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753068800; c=relaxed/simple;
	bh=t+/XWVDFYz8YYlNr1Xavigwb3/CjRxVWn0MNgRsU9so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c21EbvtyyAss0EY7ACwPkf3auo97bZJPqac+RJnzLl3BTv+WYSr/c4cWYowTddKrlB6s9RCe0jRtr+5LhRsK6JL/qL8YIxNrdFcFKxz88+f4PR2F61vLneligsKsYB31G3SVEErs8+x24CS/6XoFTpvax36sWM/9gey27u0WN+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oafp9vja; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oafp9vja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C44C4CEF1;
	Mon, 21 Jul 2025 03:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753068797;
	bh=t+/XWVDFYz8YYlNr1Xavigwb3/CjRxVWn0MNgRsU9so=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oafp9vja9LxzYJyWLD+qZLPtUGsp9zoAqp07n0O6CYh3Ydp+XWOBLdT6Lk4jSUCo0
	 MqtU7GcXr81lc5NKD9cptCt1AmRkzteJbjOYpF9Y7doNGwmEdlfpy6f3ks12EMgXI4
	 oeiKKH7fHLP+wwwyFSDpbiMUd4nj4S0Crk/+tEsmeLA3bzJflmLhteV6ijNhx5GHKV
	 hUiU+OM8HfrYx6pTvFd/5XRYUaBCYJ+42yPx8wPamTzg0XkNSnQOTb1PRr2UYlTfUs
	 kx5EGdw5fPQB14JPGeG3vdwfI6XqnMMYh8zK0W35pQ8+LYcYTF136psF8lJlZzdj4/
	 lotTdZS+LKOdg==
Date: Sun, 20 Jul 2025 20:33:12 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	sesse@google.com, charlie@rivosinc.com,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] perf tests: Fix lib path detection for non-x86
 architectures
Message-ID: <aH20-KEurjw5qJq0@google.com>
References: <20250720085905.192652-1-suchitkarunakaran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250720085905.192652-1-suchitkarunakaran@gmail.com>

On Sun, Jul 20, 2025 at 02:29:05PM +0530, Suchit Karunakaran wrote:
> The existing Makefile logic for determining library paths was
> hardcoded for x86 architectures, causing incorrect behavior
> on other platforms. This patch implements a portable solution
> using system bit detection.
> 
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> ---
>  tools/perf/tests/make | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index 0ee94caf9ec1..565522408f99 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -53,9 +53,12 @@ endif
>  
>  include $(srctree)/tools/scripts/Makefile.arch
>  
> -# FIXME looks like x86 is the only arch running tests ;-)
> -# we need some IS_(32/64) flag to make this generic
> -ifeq ($(ARCH)$(IS_64_BIT), x861)
> +BITS := $(shell getconf LONG_BIT)
> +IS_64_BIT ?= 1
> +ifeq ($(BITS), 32)
> +IS_64_BIT = 0
> +endif
> +ifeq ($(IS_64_BIT), 1)
>  lib = lib64
>  else
>  lib = lib

A dummy question: Does all other architectures have lib64 vs lib
separation?

Thanks,
Namhyung

> -- 
> 2.50.1
> 
