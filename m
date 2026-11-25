Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634646;
	b=d6qAygKGq2IhHPCqq41SfedoDhEjIfc2BDF9qV1wy73LZrn6sXwN2bMuDBYNPBlSShKV
	 8f1xCq/xBsiTaUIXuu8OYcJMD+gaoKBQlGhZjr50CprC330QgxYunUyxfzqjXScZTREHl
	 4FBzT1N9Yfo68FXkaIvLcKahhNLsLfENrI1aY8nnqV6x0T7TRtybQaeie5uZ95YVQAr4G
	 51+WCByV2c2jRR0ZuxgMqgNlkBSEfOind6nq73ZNnR/CdlrUmclXz9o0YEaw2h+0xw9Ez
	 whz+A2B2bfAJR7lrIbNbPHBAkOKehUwiwrb1jjHV7vEDS13lC/IW60QKQnfAorhSCRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634646;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=r9rkywW6iZzLXO5O3QcBEmkBRS6pLSLATvMPp7gmyB8=;
	b=3G8DnuT45Kbb4oRIJUFFya/4azXYcblzHBO0dKIgbDFbdQoy1L+4M6ww/GdrDPhNTr7A
	 hss5GQcV829SKycQEETiCnfDUdPDZvuydrBNNTbHZj9oXLLQ/eorCKTcJKR1fyMreox0j
	 QGlhll3mwLbIrfjRN/+LMTZV7fImxxIRmKhKkRcChFEf9lg8kx9tUjsgWscYrKGyR5CBc
	 eUA6/bfR9ZUiz9XKP1MSvFAoWH/3NS7GJc3q0AHEuRRITE6NN7iwWfSnP17D0RvTgd8Jp
	 0B9CQr8N2guso1KNe++k+0aO2LqHgJbyLQdHOWvMVB4q8zI8i6o85Roeh27kFfIxrgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aQUZZOD8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7277606A329;
	Wed, 25 Nov 2026 19:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aQUZZOD8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD231F000C6;
	Wed, 25 Nov 2026 19:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634646;
	bh=r9rkywW6iZzLXO5O3QcBEmkBRS6pLSLATvMPp7gmyB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aQUZZOD8RsOWaoO/G9cML5SB6nBS9mgq/WNLeL+iia001+VUvJaBVfrbjliuKFMo0
	 rtxuTon/1eUYJUoEWaHObIu3A7Tw1eFNLQx0IgSnmg3Cfy2q/rMi8V/HIeL6bIV9pN
	 sowNmyVrqOWbmxOwi08gJOO1fBPjinDEuCIYZSTBRi/ARKyCeXy12udZy9Vy25u/5a
	 54NPflBmKrl/igYoyJBFBlOgrV3xB6YWCveKLVF2zIUBXEyKoC3iw4eGw27S+y2st/
	 Fi5FAYtayKLPjSL3nLcwSFHt0oklXM3qczW/mse0lyu0FOi6jrbC1hhcns3j005m3a
	 yGV6fdHPs0frw==
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
Subject: [PATCH v13 14/19] perf test: Drop samples without an IP in the dlfilter test
Date: Wed, 25 Nov 2026 16:23:07 -0300
Message-ID: <20261125192312.34134-15-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125192312.34134-1-acme@kernel.org>
References: <20261125192312.34134-1-acme@kernel.org>
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
2.56.0

