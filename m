Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35291294A10;
	Sun, 12 Jul 2026 06:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783839375; cv=none; b=qbCWWATQgm52e2gn6TjBsjeVEPbfgenUrMVD2swBrxOivrJsNPP17+SZBGADoE9SXgayKjbz6ElTX3nLGPvGNDJWQI6QyYfrAiy5zWUlIGJvbJEcWVENiwlrbhuSCaFpon3P1xNpJH3NcLV+UpLs/4vE7eTvbg6nrKOy0j/9nDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783839375; c=relaxed/simple;
	bh=lo/qhT4bCsL04i0vJeNBq7GP7snjxj8ehJULA3QGng0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q/BnjCI7MaunHahL0TBo1VYtqM8KArz5g0OKZiq8lMaVadGacfdCCWmaTwjesTGafUHZzuo+gWPy80JnvLCGRgqkI9fLSsRc7AWVrCe8XCjeebhZvMA0KRkhKDbumnQ4+HklED9thZfvNI+Tec1w696CmjsIewhr8jppRhwuY1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YedHCjp8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YedHCjp8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D731F00A3E;
	Sun, 12 Jul 2026 06:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783839374;
	bh=TpuGGpVj1TvWmkFFKE/QOmWtRup8Hpl573vjY4wcRgo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=YedHCjp8RJep6eN1Opv6r4yJC5Hc83jYVPxqGIkp5nazi2JmnUjH/wQ/AMJaSKqvZ
	 IRyUrJCshBgwblPl5KvXQqGI1d7bvxMfhd6NbxxNzfhiXCPurSRPZc+kbtfLIvxQ2Q
	 020qhyKRzDA/kiRQAmCPQ0wm9D7G9fGs+KYuqm464tkrWK7Fq74WozIEjtHabEdCg3
	 ownG9EQCKtLUhPRJxOrbEc/pFX9anQ4XqG7DKLSrUPdmdM4D6tWWINo35/B3m0SM7/
	 QnXcosPtQYhvOIZUY0TVfsWCWjCh82xdZjpYCXOqjEigWTZQO9SceTUdLZBQ+s22FK
	 pbmVws3n5uz4Q==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 mingo@redhat.com, peterz@infradead.org
In-Reply-To: <20260605062418.1540615-1-irogers@google.com>
References: <20260526224241.4016312-1-irogers@google.com>
 <20260605062418.1540615-1-irogers@google.com>
Subject: Re: [PATCH v3] perf clang-format: Prioritize Python.h and expand
 other categories
Message-Id: <178383937371.3162711.361240211609345201.b4-ty@kernel.org>
Date: Sat, 11 Jul 2026 23:56:13 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 04 Jun 2026 23:24:18 -0700, Ian Rogers wrote:
> This commit updates the .clang-format rules for the perf tools.
> It prioritizes Python.h sorting and expands the regex lists for C
> standard library and OS specific headers.
> 
> - Prioritize Python.h by sorting it first (Priority -1), ensuring it
>   is sorted before even the main header (Priority 0).
> - Keep other header priorities (1 and 2) to maintain their relative
>   order.
> - Sanity check and complete "C Standard Library Headers" up to C23
>   (added stdbit.h, stdckdint.h).
> - Sanity check and complete "OS/System-Specific Headers" based on
>   actual usage in tools/perf (added asm-generic, uapi, and various
>   flat POSIX/system headers).
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


