Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795383682;
	b=oeH5I7DcDSg4gKj3+6KQGHE2rPcB1QbCyLrTpQin/7jVVRzr7nJIOVf/wNX0krczlRAg
	 nk2vPLLGvtze5eHWJwWSFImKekrQ7Ai6nkD+sCGMuqyYEUxzuhOGeUeOufZwrd27HfY6g
	 iuzrECIj2Wr8QTT14k474CIlvpjPCYhA8oQEmW2Zo9KHiSagx7wy6o93GPx5jStTGa67f
	 c3YGNo7YDmAfMhppLPyKMEL2BPBPXy0gBzmLqlqhWmW4Hh6KsI4JTH1Evd4QkV9YbjLwE
	 9HYVIqPYMN1wTQz1QyePoJcQtdFwaRsQBShXzeHfNrWcaoy6J4eGn6Kpzq8yGUgS5aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795383682;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lcjtcwl0f/VjQ5MXMPxqJNyppae5RyWWs0S0BDnyFb0=;
	b=V01zljPMD0xsV6Nmz/rLLIiQ2A/lLXarKXtxfSdK97GyemLw93TRVjUoCPql5n3Pg5BS
	 Br8mfdxXssoEvKkMdVAv4AzDJA8HvHjsdIrrz/rtO5FX0KKR1n7/L9uvcn+wM0Sv4oTwN
	 W8fJFKi3Wc1bimd308G2KVUcsTARJbCj5e77QUa5x44iEiSXOqz5OkREzBUkj0VsPAjCC
	 zdz5qJ7XLix3treVHY4SFI2RYlz/G4FBKyxbRrqMgaPtfrsaR89kn42iFJ01u1Lt0mf+d
	 m67WlI2X0DQInN6xTkQ5DDxWksCnS9BnT8C9kG06BCt4s/0fYO7tjur6ni+t7eG2NdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UnAfleLm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DA0606A33E;
	Sun, 22 Nov 2026 21:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UnAfleLm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05441F000F2;
	Sun, 22 Nov 2026 21:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795383681;
	bh=lcjtcwl0f/VjQ5MXMPxqJNyppae5RyWWs0S0BDnyFb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UnAfleLmJuTtSytWKBEyrnyJtYp19BB6Akh6YeIZFuS5QkaWZteJiGfI8ejRR9hmG
	 taUGRhtDV3ECjEYyLgENJZdasnanuW2pbQOQR2awRNfph9kVXgWoS1b4kA48RhLasH
	 Y7f0F/dNYn7hHroIF95ZyNdQlq1S+ZtnpUI6F4Wdg2Sbvkr+355jp9ejB9/1CBIzAY
	 AbCMw9Gn24NoFnWtCz7GgjAejRATkXe9Lpnymy5qQt+0yaT36Ynn8oow5DNFtiSxGp
	 n49mSvdfl9Ut+IvD3yFZ7Ahh132I2fHWNbzG1jCvg+XHJu1UpQqdeA4TeUhD/wSaeH
	 iIi6HeXYbHg+w==
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
Subject: [PATCH v11 14/19] perf test: Drop samples without an IP in the dlfilter test
Date: Sun, 22 Nov 2026 18:40:20 -0300
Message-ID: <20261122214025.16769-15-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261122214025.16769-1-acme@kernel.org>
References: <20261122214025.16769-1-acme@kernel.org>
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

