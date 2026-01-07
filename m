Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51D9279DCD;
	Wed,  7 Jan 2026 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767771422; cv=none; b=ihyURjxtpPKOWLJ67SaV1tJxNtq5vbBR2xdS6Sl8rkpBAd+cThXpTy3udUGLoGkQByAtTgku5UsRvHnCk/Y6rG4DE41CkELDVwMkpyHMfvMMQwtcDdyFzz7dx4nyTA7xLdMsbMKjS03NbKs8Ppf4KX7F2cSCNnKBcIz3aDNoVW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767771422; c=relaxed/simple;
	bh=vSgrJVTmVFgDZDI2xW85DHF2k2GQXmh4UYKSuR86GhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3JyAzr4jDHkEsqoRqLNtvm/b6Fx94XgCgZxht3DOj/CphRwgLrwD0pdXiLzbY5O9dWsr7fIkCzFSGX/kInRU6VvxjSVYCd/RzidXaEZmIrhi4KICW4YZopjWfJqpnNltM0RSiH+cYI3NInKF7CW6wsOd+42hekCJJZHRsVKIQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTmj6ln3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTmj6ln3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C81C4CEF7;
	Wed,  7 Jan 2026 07:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767771421;
	bh=vSgrJVTmVFgDZDI2xW85DHF2k2GQXmh4UYKSuR86GhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pTmj6ln3XNp/rVBl701J2YABzkFtTLQYZZB5537q2GHrHrkx0mfBRK5xLQ6GcDSCj
	 Q174bm2d6t+nFegdDMS8fpIhISOIpvWjl1r3SwIni52YB2aXutopPuLATbG/x5M0U9
	 Zr9beCzOx+MQX2Ds2Pmx5UkArHFAX9a4O7INHIPrfWBYUGQN9uMpIf0unjoO2KQ+9Y
	 R14GbHWez95vnYX2jnvOb+WpDb4/RjKXKmY/1h18zmwdi46txVRgV11PnFjYImY7Wb
	 osUWfQIaQ0hGep0386YDqreVNWe2UTc2F1K7gjER/DmCz5xE8G4QSVfWeVe3uJsPyH
	 W6msWfu4xiKLQ==
Date: Tue, 6 Jan 2026 23:36:59 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Nicolas Schier <n.schier@avm.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Michael Petlan <mpetlan@redhat.com>,
	Jakub Brnak <jbrnak@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Philipp Hahn <p.hahn@avm.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nicolas Schier <nsc@kernel.org>
Subject: Re: [PATCH] perf build: Raise minimum shellcheck version to 0.7.2
Message-ID: <aV4NG14zGnZw1PTq@google.com>
References: <20260106-perf-raise-minimum-shellcheck-version-v1-1-b46739a78888@avm.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260106-perf-raise-minimum-shellcheck-version-v1-1-b46739a78888@avm.de>

On Tue, Jan 06, 2026 at 02:19:28PM +0100, Nicolas Schier wrote:
> Raise the minimum shellcheck version for perf builds to 0.7.2, so that
> systems with shellcheck versions below 0.7.2 will automatically skip the
> shell script checking, even if NO_SHELLCHECK is unset.
> 
> Since commit 241f21be7d0f ("perf test perftool_testsuite: Use absolute
> paths"), shellcheck versions before 0.7.2 break the perf build with
> several SC1090 [2] warnings due to its too strict dynamic source
> handling [1].

It'd be nice if you could copy the error message here.

> 
> Fixes: 241f21be7d0f ("perf test perftool_testsuite: Use absolute paths")
> Link: https://github.com/koalaman/shellcheck/issues/1998 # [1]
> Link: https://www.shellcheck.net/wiki/SC1090
> Signed-off-by: Nicolas Schier <n.schier@avm.de>

Other than that,

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
> This is an alternative to introducing several shellcheck directives to
> let old shellcheck versions handle the dynamic source statements
> correctly:
> https://lore.kernel.org/lkml/20260106-perf-add-shellcheck-sc1090-annotation-v2-1-bd52dc47369e@avm.de/
> ---
>  tools/perf/Makefile.perf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index b3f481a626afa314632876449a11eb79b2978824..e2d668fb7f439befd6d1d9cbf66765f8b815e3c6 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -255,7 +255,7 @@ endif
>  # minimal shellcheck version as v0.6.0.
>  ifneq ($(SHELLCHECK),)
>    ifeq ($(shell expr $(shell $(SHELLCHECK) --version | grep version: | \
> -        sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \< 060), 1)
> +        sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \< 072), 1)
>      SHELLCHECK :=
>    else
>      SHELLCHECK := $(SHELLCHECK) -s bash -a -S warning
> 
> ---
> base-commit: 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb
> change-id: 20260106-perf-raise-minimum-shellcheck-version-5d684fe90a39
> 
> Best regards,
> -- 
> Nicolas Schier
> 
