Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E754759221B;
	Wed,  9 Sep 2026 21:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788989472; cv=none; b=HzmjFRnbVZNQidBEVAlM5mCDNg99syYqQA3OdHHMlMm8Y/7lbZR8EGcMtE9Jh4OpxPmYp2wiy9IQ+nSYOZBwpALQoWjCxugikbjUvBmDb5IPZinYUlNu9ZqFCyxhIdHqkd9vBx7VvQ00dXfvx0N0DcLFmK1FIwHaR/+Fs2u6ZKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788989472; c=relaxed/simple;
	bh=lOT7XQPCszL0lE2kPQNtUpip88xXJX7ct1dtA5km34I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XvtlYb9MFEOZslOMmnwTGfHGD2ga+hsfUqK6SLGCqMZhl0OKOIN5EQgC8TGAgH6eA/XXoRZheOFp7NCYHLLUvALUm4KNoZKYqyJahHDHnHBH1Ibal1PxeBm3Z1AsdCdxM70+EKViOhpJ6PeT3FRYd1RRPpqwmnb8pqPzpSi0I7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xxt1L+Ba; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xxt1L+Ba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D491F00893;
	Wed,  9 Sep 2026 21:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788989444;
	bh=lOT7XQPCszL0lE2kPQNtUpip88xXJX7ct1dtA5km34I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Xxt1L+Bal8c2jHFjl7C3zF/rMZtO6cdkpDy7/if5eCZ0ZGtdyTL8Tz4H4o0NKhaPm
	 k7pxP6dRetnfFZpOR2x0/rXox5AifeiSpeY9czIOKTXXAAOe+4l7ePzCRZd7toHqim
	 9GH0Rf7fowLqnPPJSlr0/25+Javstw7xu/cq1pXIPY6ADTBUztZIpEv+o+txabmCfZ
	 LG/5XtY/jmXOgtepJ15XcBpgJWWK9gZdfS18lHUXXNAI1d/toIxUNOGdk2rREkjZCA
	 mW3jXc73DTTNHSerAF3FfRExDFbaFq/hudHwjsMpqGQM1Lb7eLEMhyq53MjOqe3JMM
	 ShtftKTasShXQ==
Content-Type: multipart/mixed; boundary="===============3620100518046819435=="
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1d8002555202c2d344b450155c0620a80231a2e3e655c97dec959553984b9790@mail.kernel.org>
In-Reply-To: <20260909204122.1993010-4-irogers@google.com>
References: <20260909204122.1993010-4-irogers@google.com>
Subject: Re: [PATCH v2 3/4] bpftool: Add explicitly sequenced -lzstd to libbfd feature fallback
From: bot+bpf-ci@kernel.org
To: irogers@google.com,qmo@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,jpoimboe@kernel.org,peterz@infradead.org,mingo@redhat.com,acme@kernel.org,namhyung@kernel.org,irogers@google.com,adrian.hunter@intel.com,james.clark@linaro.org,terrelln@fb.com,dsterba@suse.com,tglozar@redhat.com,costa.shul@redhat.com,mjeanson@efficios.com,9erthalion6@gmail.com,leo.yan@arm.com,linux-kernel@vger.kernel.org,linux-perf-users@vger.kernel.org
Cc: bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  9 Sep 2026 21:30:43 +0000 (UTC)

--===============3620100518046819435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpftool: Add explicitly sequenced -lzstd to libbfd feature fallback
>
> Distributions like Fedora currently ship a statically compiled binutils
> libbfd that natively depends on zstd to decompress sections (e.g.
> undefined reference to 'ZSTD_decompress').
>
> Extend the newly supplemented libbfd-liberty-z-zstd feature probe into
> bpftool's Makefile so it can natively build against static binutils
> distributions.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> Assisted-by: Antigravity:gemini-3.1-pro

This isn't a bug, but the subject line uses the phrase "explicitly
sequenced" which doesn't appear to describe what the patch does. Looking at
the diff, the patch adds libbfd-liberty-z-zstd to FEATURE_TESTS and
FEATURE_DISPLAY, then appends a new fallback branch with '-lz -lzstd' to
the existing cascade.

Similarly, "Extend the newly supplemented ... probe into bpftool's Makefile"
is a bit indirect. The patch adds the probe to FEATURE_TESTS and appends the
matching link flags to the fallback chain.

Also, "natively" appears twice ("natively depends on zstd", "natively build
against static binutils") but doesn't add meaning to either phrase.

Would a more direct subject such as "bpftool: Use libbfd-liberty-z-zstd
feature in the libbfd fallback chain" describe the change more clearly, and
could the body state simply that the new probe is added to FEATURE_TESTS
and a matching '-lz -lzstd' branch appended to the fallback?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34404437407
--===============3620100518046819435==--
