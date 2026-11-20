Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795138395;
	b=b5PCVytTasUchl+jB7LMDAqSU/DJ/ivBrQfXKlDPx/PZoMuUmGxRnJvwYLJCCC5jX2jw
	 7SIRZ2xMLvak+kCkGPxzjuamkOHObq/AipW8nbIdLHfkXznaj4h8n+2ZLpbJSHwJukEDH
	 NKHlyzIszyrvvX+Yw1BrF6zyYE2YP10vBiq7C5FJoqm0uSFK/X/hDoZ3Ov7WVtAygsGdC
	 XvKgwRZynxzrTmjxgfX7htATmcDpXSoACFy78HcsRdPf8BIhXK59mX+uJJfha0r/OOJoz
	 CfJJd87AHvYWeJhcUxbyniXr+LY1GdS8ltzNO4zUCUSKJWi0BQ9glbyZedCjiTRtg4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795138395;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lcjtcwl0f/VjQ5MXMPxqJNyppae5RyWWs0S0BDnyFb0=;
	b=LKURLYhysX0pnFzpGTm2Q85Jyra6Hv9vd7Shyuufao7QrZsY2WUiIeGAdOFrBTLMrGSo
	 bzdgclZTaR+zd5uSX0gF1vsYAq/VrkQI3rRzh3qRY9sLFJuJNTY+ratSkWThIv7D6oPzG
	 6wrgjt8NzsIMPPo0vMs3uCfk1vYosJp/5jKB94FsJjlQjqZYkRGjRmeYzxEvXNojNOJ/g
	 tBL5QfA/zId4Uw7PjF22XdRbT3t1lCy46qSzaTNE8+rC3TxkJLDMdUajhPLaK7j4Hq12W
	 cp8f1/tD+imFj5JQ/JUeXrGMy4zEiBf3sICBOwP3Tl8n2j7sex01SsVUHZl0zhI8l8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IYMumQit;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17274606A320
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 01:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IYMumQit
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02EB1F000CA;
	Fri, 20 Nov 2026 01:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795138394;
	bh=lcjtcwl0f/VjQ5MXMPxqJNyppae5RyWWs0S0BDnyFb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IYMumQitjDKhWH6/7Qh1yps+kTySVIvpHWM6aZGZSisi1m9N0CW5tBOAJKTkTpiQZ
	 LBgIMHFxnHdciaeZ4XgLgcz2DSg+2BgiyhXcX6kzfv1sf4jlawuPJjXbrj7OB3aJUD
	 +xrK5wZDanpPybPJne4NwrVkf3IO3GYXBnD/ucZU4pgU7EXVYq+uiJ3xxzsPWb+Tch
	 DrdkbDpwC/1yUdZhat/RT/SzRiQnkYxZcC2I9svy2d6bi5R8F62gyWFnlvJWb5ojL5
	 YJxTeLQgF26/RH5ZFzaQihg6m3hPai+Vp5DmMmJR7aamQ5PYjudhyTH2Pj1vyC5Xkr
	 c9uL/Kw9flUKw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v9 12/13] perf test: Drop samples without an IP in the dlfilter test
Date: Thu, 19 Nov 2026 22:32:07 -0300
Message-ID: <20261120013211.1510-13-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261120013211.1510-1-acme@kernel.org>
References: <20261120013211.1510-1-acme@kernel.org>
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

