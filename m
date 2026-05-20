Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7FC3EC2CE;
	Wed, 20 May 2026 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287506; cv=none; b=CjvhbPuqUi7bpoXXZyKArKhdMlIm2P6p+myZqu1dAjqSwDpXepgCeVUf//iRk+Yqfv1o/BwVNe1AvnF9rbH7AkfTAZr2GOYXmgr51Lv2DolEtDGW8aIb58+KJYdeRWpy8Bdbcne6CXOZ5pLCkzTGr5BvJmi8GcgxsI9zaIZ7KvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287506; c=relaxed/simple;
	bh=6ccqmCGqz/HpAmPfEsckEGefveGaHqzhJd05zzrUCvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDKg8WHsTKYr1bx0Lq/4mFi+0w5wjN4/Y5TIQbTf+OxXxb3OvD8OJEJ0j1oXL3uWPeBxIGUMjfIvTnyrejvN0gMOzyXpyIq5LZ7kNplk0o0wdJLOv3BuVif6xgVQs89kdkJ1PIa2n0d5StDYgYT1oAKX4AHhZ/mz93IA5aIlcRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdupXEP+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdupXEP+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A421F00897;
	Wed, 20 May 2026 14:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779287504;
	bh=4wqF2syvd/6X3KHXfFgHP9JmZv7Goy11NEgHhMwEGm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LdupXEP+svoNI4R28eY8YaLngiyxhltn+W794u9sBohWtGqvzUzL5EepScIPiwp6D
	 rtl3vihRHWEBBBR4s8NYybqwAYAODI/r43gOtgXZioYK6Kiq+Baq6YUCQQIBNRRdqj
	 LdPUvE6u7IUPIY60f7JI65lVDE6rnANCfdCS2L9zozDp/rt8FXn/jcXZl+lmSVl5Ni
	 qDxsy34udVl7JnKJLaGMrf48a4Tumlc9ogOIBAYq6ULcvEnkTZ5nB5gQ8niRttDY1l
	 gLf+wLiKmDgDACGNALH4TR3xYcd/rtYOGWlzNAU5EpO0y3f7+zDjgss0NXOR9pSUCf
	 rfe1a2vuYACpw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH stable 6.1 0/3] perf build fixes
Date: Wed, 20 May 2026 10:31:37 -0400
Message-ID: <stable-reply-0002-perf-build-6.1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519185154.2987285-1-florian.fainelli@broadcom.com>
References: <20260519185154.2987285-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This patch series contains "perf" build fixes specific to 6.1. We have
> seen occasional build failures in our CI looking like these:
[...]
> Ian Rogers (3):
>   perf build: Conditionally define NDEBUG
>   perf parse-events: Make YYDEBUG dependent on doing a debug build
>   perf build: Disable fewer bison warnings

Thanks for the series.

Patch 3/3 (ddc8e4c96692) has an upstream Fixes: follow-up,
878460e8d0ff8 ("perf build: Remove -Wno-unused-but-set-variable from
the flex flags when building with clang < 13.0.0"), which we need on
6.1 alongside 3/3 to keep clang<13 perf builds working. Without it,
3/3 unconditionally adds -Wno-unused-but-set-variable and drops the
-Wno-unknown-warning-option guard that was previously gated by
BISON_GE_35, so clang 11/12 fails under WERROR=1.

878460e8d0ff8 does not cherry-pick cleanly onto 6.1 - it references
the 'version-lt3' make macro (introduced by a9b451509565d, not in 6.1)
and bpf-filter-flex.o (no such file in 6.1's tools/perf). I wasn't
comfortable resolving that conflict blind on a 6.1-only perf change.

Could you send a v2 6.1 series that includes 878460e8d0ff8 adapted to
6.1 (or an equivalent 6.1-specific patch that preserves the
-Wno-unknown-warning-option guard for clang<13)? I'll queue the whole
thing once that piece is in.

--
Thanks,
Sasha
