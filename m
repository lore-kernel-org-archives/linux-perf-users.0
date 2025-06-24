Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEB2298CBC;
	Tue, 24 Jun 2025 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788182; cv=none; b=VN0xrSoF2w9RsAknDnC9rbWZ6FUhR9EZiaLFEo9qRetmTqWFUT+3tL9RVvCW4CskVSypuvIy0PhQ0BhdmyNxc5hXJc+1PI/+RglmCpWObawI0dSsa3iVi5mI0m/6Ot+m9IiwV5Nh3a86DZvICXGZXFH6TwmE05HF66k0siatGrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788182; c=relaxed/simple;
	bh=IxpQVFavBDkJlM/cSKrOfKpzF66IllwAzWZ9Ke2ip98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qju1rz7ApY/l0PlnvEfRnKgrFIWvQwUstJWHAcm9kr788Yw4L5YOTQ0Afq3FWpnuKM2IF02NPXtrbtMEaFZGA90KW897/f1Flx9EHmvE3xsx5Zkqsotwr0uodYElD8l+H037mOa0SWtFfVED6DLHJiTcJwMmCCqT2yDipVCIVN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JE/n0Tfv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JE/n0Tfv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A93C4CEE3;
	Tue, 24 Jun 2025 18:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750788182;
	bh=IxpQVFavBDkJlM/cSKrOfKpzF66IllwAzWZ9Ke2ip98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JE/n0TfvHU8zacWqv6InS01qBOIZpgy4w7J9T1cbBz8iac7ObWTqnKgCqhy+zNBPM
	 pmOIqClfq9fjvQfYOsg2gX0Nzl8DyaJxtG1rTFUtLyev/hSVZC7wDXfsacDNr/3Ji6
	 lPO7flPUrdXnbCiRXorKuztMGP/Wo5Ku8wDUnIRzit9nuELUByrGozhtff/j+3NIwP
	 FYYPLAhN2RUZrJ0dH1mzHUccm3LJNXOujAnMemMRNZF8YYw47rw7nPo4flNNZWfX6a
	 HIUkKBf8XkcaCJtVLdKeo9LffobDQ04OffvwuLYRA0qYhRP5225OnFml+fE0YOmf0y
	 1XQVLVGHAVzMw==
Date: Tue, 24 Jun 2025 11:03:00 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Yuzhuo Jing <yuzhuo@google.com>
Subject: Re: [PATCH v2 0/4] perf: Remove libcrypto dependency
Message-ID: <aFroVMHTBOB7wfjI@google.com>
References: <20250614044133.660848-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250614044133.660848-1-ebiggers@kernel.org>

Hello,

On Fri, Jun 13, 2025 at 09:41:29PM -0700, Eric Biggers wrote:
> This is a reworked version of
> https://lore.kernel.org/all/20250521225307.743726-1-yuzhuo@google.com/.
> I've changed it to add a new minimal SHA-1 implementation, instead of
> trying to pull in the kernel's SHA-1 implementation which is not really
> designed to be extracted into userspace programs.  I also added a test.
> 
> Eric Biggers (2):
>   perf build: enable -fno-strict-aliasing
>   perf util: add a basic SHA-1 implementation
> 
> Yuzhuo Jing (2):
>   perf genelf: Remove libcrypto dependency and use built-in sha1()
>   tools: Remove libcrypto dependency

Thanks for working on this.  But can you please rebase it on to the
latest perf-tools-next tree/branch?  It doesn't apply cleanly.

Thanks,
Namhyung

> 
>  tools/build/Makefile.feature            |  2 -
>  tools/build/feature/Makefile            |  4 -
>  tools/build/feature/test-all.c          |  5 --
>  tools/build/feature/test-libcrypto.c    | 25 -------
>  tools/perf/Documentation/perf-check.txt |  1 -
>  tools/perf/Makefile.config              | 17 +----
>  tools/perf/Makefile.perf                |  3 -
>  tools/perf/builtin-check.c              |  1 -
>  tools/perf/tests/make                   |  4 +-
>  tools/perf/tests/util.c                 | 45 +++++++++++-
>  tools/perf/util/Build                   |  1 +
>  tools/perf/util/genelf.c                | 85 +---------------------
>  tools/perf/util/sha1.c                  | 97 +++++++++++++++++++++++++
>  tools/perf/util/sha1.h                  |  6 ++
>  14 files changed, 156 insertions(+), 140 deletions(-)
>  delete mode 100644 tools/build/feature/test-libcrypto.c
>  create mode 100644 tools/perf/util/sha1.c
>  create mode 100644 tools/perf/util/sha1.h
> 
> 
> base-commit: 18531f4d1c8c47c4796289dbbc1ab657ffa063d2
> -- 
> 2.49.0
> 
