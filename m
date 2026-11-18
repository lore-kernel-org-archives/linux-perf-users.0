Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795041493;
	b=WhSGK48Lvlyhq9jVswUjZpCRQOIJO7le3dmEHUdv97PES1mVAvC4aFJacPtpinHYvuhE
	 1xjt1E6wzH9X5eFt8xKYC7+dHK9DfDxkUVfHRLxR3pvlCBODMDi5O6H4v1vfEl1XLkgZr
	 DUqWG2c1etVHXvDEOQKHtY8nxT2kWvTBVP+TiCIvBycx3G0CRJbU473nkbNYicHUR71wy
	 cCoxl5OcBZg3Ux+HRNsCC5/PINwvEU34Wwan+ytDyivLwMrHnX6IKSYbr+lHD6wCJ1wLk
	 tcDEYEgJ5sOPoUvGFyR46+PDyAKh5ZN588ce1oQDwi0bPaDJcHamR/GzmZqW+di29pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041493;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lcjtcwl0f/VjQ5MXMPxqJNyppae5RyWWs0S0BDnyFb0=;
	b=IPCrS6spmWbklL8Vt+VfVenyXVmGGocK1dZquAqm5JYrwSji/sloEyW8BWBedAbCnEGD
	 Cn5tLksBFKdYrtEon18DQzeM9gmKKcdbMWi4u6705S1ReVEzvmolNbH8NswSz+Cd54i0+
	 kXRqy+BjfQ5m0THoxCn++5QDZv8tQ8sve797rkE7QKxGsYBj470+i9vI2BH5E0ZYHk4B5
	 MEf5CSGIeV2CMlNhB9loTgMcT7q4cfVy9UVOSJ/yuWzs2wvSBaQieKO6dGm9Z41z/AhsU
	 npLRayibjFW6oY8QoJW5wjJ2caidNvJBBUOkp9hA7Pf7fgm0NLL9zSWtwj/SO446dVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oHi1f+xY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE78B60A6F61;
	Wed, 18 Nov 2026 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oHi1f+xY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6801F000D1;
	Wed, 18 Nov 2026 22:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795041493;
	bh=lcjtcwl0f/VjQ5MXMPxqJNyppae5RyWWs0S0BDnyFb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oHi1f+xYdbxmfOYpiPOXdlrtdB54Nlc5huJ7oPcr4LevJD3sCKlQ9EG6Kgnk7HGpr
	 O1mzO8exa41s+5jLlfaLh6UG0h2PPlIKRwsRxSgZohAg8xNeq+PrAghrsVgRH9lUu9
	 EHde7R018PVREWK5DUQKbG7tIW99Px5skbkG2jIRqf7tfprj02fMAn8iU2XaURFMHc
	 Yp0q9OoTf7tbna6h4/FMkyO3uYuvR9ZQ4B+dTZpKXlvr6MfzQ6jHuD6yk3InnQeLSp
	 PPLmUEB11dAbVXU1cw4nP70QLyX+EUbkdxm8z+SbBhg6ZvmJwXQcn07t7nvryFby3E
	 nSFLlKi3zWlTw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v8 12/13] perf test: Drop samples without an IP in the dlfilter test
Date: Wed, 18 Nov 2026 19:37:23 -0300
Message-ID: <20261118223725.121500-13-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118223725.121500-1-acme@kernel.org>
References: <20261118223725.121500-1-acme@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since v7.3 the kernel zeroes PERF_SAMPLE_IP when a user-only event skids
into kernel mode, so that kernel register state is not exposed to user
space: commit 166f10836a653dfa ("perf/core: Fix kernel register info
leak via hardware skid").

The test records without an event modifier, which is user-only only when
perf falls back to cycles:u for an unprivileged user, which is why root
runs never saw it.  The dlfilter keeps those ip 0 samples, and the check
that nothing but test_loop survives then trips on their lines: the comm
column reads "perf".  Drop them, as everything except test_loop must be
filtered out.

Fixes: 199d5e872a9ce737 ("perf tests script dlfilter: Add a dlfilter test")
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/script_dlfilter.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/script_dlfilter.sh b/tools/perf/tests/shell/script_dlfilter.sh
index 88222280f6094fd0..797cd9ae84141f64 100755
--- a/tools/perf/tests/shell/script_dlfilter.sh
+++ b/tools/perf/tests/shell/script_dlfilter.sh
@@ -46,7 +46,7 @@ int filter_event(void *data, const struct perf_dlfilter_sample *sample, void *ct
 	const struct perf_dlfilter_al *al;
 
 	if (!sample->ip)
-		return 0;
+		return 1;
 
 	al = perf_dlfilter_fns.resolve_ip(ctx);
 	if (!al || !al->sym || strcmp(al->sym, "test_loop"))
-- 
2.56.1

