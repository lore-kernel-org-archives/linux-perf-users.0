Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039085;
	b=2FLP9MhzalzJs00XuKOdAuXcLuKpMP0yBqB8jfcr4g4r/8Oj8fUnEmAaFu1rLe0P2TmA
	 1cutDEGpAAPVSbRKsON8grlA9XJxsTlFg0lJdmqYwSk5+JlFVYX2fxPS/mbVaGUO3Xi5g
	 7V/l3yxymJATIJRhZhni/YleKZN7ZBrw5fivKvWfqpfVJsVmn0MBaPrv3KOBmYJIv4Qqm
	 xmCXkPZvQbtIvtNYo2Nh4ktK7XJ/CZ+6DJlnXCUiIOYCMXCH8ocM4jk7Ahn8+ByJoafAD
	 8GEEZTLdYGYZgdPMyQbJyOZx8B1yzPebN/bo2jTHi2eBpebAi1/pXfVwzjASLXtLHCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039085;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lcjtcwl0f/VjQ5MXMPxqJNyppae5RyWWs0S0BDnyFb0=;
	b=yF/e5HDG1eNUm8wCAjYLgdNiOgnsQUV1h8QFRBcRSolpsovgzBN5/UVCZK1k9se9aZKP
	 RcMMFPm0wDdE/ErTvobMx29Oh6BkP8cgRWiEqgfmnTskRNsqy2irCCNB/SjD++jHvIdVA
	 pXl5zAOS3EaXfRrd6EDPoToEjfkq0rqb6nfo+2FuZfVjTxm52fFr2b9KED99JJOB6N7xh
	 5OWidA8F1ji+p1VA3nKmk99VbCndadAy8kFgfujvqeXemh8WIiqUy7EwBCezjdk07ZgX2
	 Q1Ms5ojcKWBp39pi3CtC4x0UxOkhvzqRh9l++IwjRkeELmtPr957lK1wdoLT+nrIQ2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cv88B4Ip;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D1B60A2609;
	Wed, 18 Nov 2026 21:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cv88B4Ip
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88D21F000CC;
	Wed, 18 Nov 2026 21:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795039084;
	bh=lcjtcwl0f/VjQ5MXMPxqJNyppae5RyWWs0S0BDnyFb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cv88B4Ipq9Klc3Av06iEZvpUcodjROiz+vXq21KC2MVGp5wDvXBf2Z/B0IHHsnzNN
	 HD36rotHVN7fVm6L+r5YIY3udNnITcfk3yRcbeeRTayaesK9zPm3wUAlJ42FIHke3r
	 neXKazt7DfhclF0vqIjC+W0jVg94F72AFMrxbcmYQ+zcl/bYpwyVD7lvztqzn3cXTg
	 a4UPGmEGsaNoedSaSn64h0XguFhA3jhXv+laOCvY1u/yQIzxqNVF21LU/BBc+2PI2f
	 EI9b0Ao+t00q0Ok+8wScJAjnmxFyiKMzQmJT8rcijKDBoUmjt4sxu8O/7kf5TSzLKl
	 iXJAxOc4nzAkA==
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
Subject: [PATCH v7 12/13] perf test: Drop samples without an IP in the dlfilter test
Date: Wed, 18 Nov 2026 18:57:14 -0300
Message-ID: <20261118215716.114868-13-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118215716.114868-1-acme@kernel.org>
References: <20261118215716.114868-1-acme@kernel.org>
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

