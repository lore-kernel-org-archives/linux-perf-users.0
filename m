Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9303F376A00;
	Wed, 10 Jun 2026 19:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121183; cv=none; b=hKiiZhjB8D4FEn+xffO2NXkReXanTBaQe02SvrZ1Hhl+v6e9vBLJichEoj9iFswtTZz9Ef+BytLiyJtxfPobvHZXh4IvJ7Cwx8OVwvn+HWOY3evt6qwq329tkEyp2bM8yPv+HkQ1rEF/RCzJnIZdI/6JqQwQX9cqeRqihSX2AlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121183; c=relaxed/simple;
	bh=6DHaEesU1HxcBe7IAQEFvPynqatqgSNZg56hKrmfej4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CuVyu/ePuyBpJztGBbNJbxCaZM15IMo4vdDpt59HYa1jpi/9yrx+ckFgUqtCmW7Q3afVLp+yRx2x2H8vsT9pr35R6KuwA47AGJtjxYjNxO2kk62pB2lKVU5qvCYp8ZbCg5MmC43IYKTtKzu4GazJUVlkPs7c369s6K80kfImHm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5uGVixj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5uGVixj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08EA1F00898;
	Wed, 10 Jun 2026 19:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121182;
	bh=1eyHbE/wfY3LRfOLgcFHF0JQRUUcUvxj8aZs9j1miaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B5uGVixjX+YkK17ml0NvvzSl3VT3mLSpNWuXkW5LmJCbbY6oIgTZ+fTppAf7X29zp
	 KhbijCJSQhrTXKDZcmb1dSGEei6OEQwMpis3x+94uwC5DVvcnFqZ5RXZvK7mEv5+ph
	 OM/kkyII4yQ1Ks0IC8cwPgxHgC74uierLjwroUdZEWVRHyUv1MvR9br1qzL95wVQfm
	 URRL+p9DJPZmQEjOKkD49kONLJV2xbjSpgip/NXVzUZdSMS1OIi5HrubaKZkjJY8lO
	 gU2Nddfn0zQv71qanN0jiDvQj4vl+bsDkwaI2deVR6kYk+j910X5H/Ion6CM0rToD2
	 +GEe01/yHaSCw==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 11/23] perf hwmon: Fix parse_hwmon_filename() strlcpy buffer overflow
Date: Wed, 10 Jun 2026 16:51:44 -0300
Message-ID: <20260610195157.2091137-12-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610195157.2091137-1-acme@kernel.org>
References: <20260610195157.2091137-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

parse_hwmon_filename() strips the "_alarm" suffix from event names
by copying into a 24-byte stack buffer:

    strlcpy(fn_type, fn_item, fn_item_len - 5);

The third argument is the source length minus the suffix, not the
destination buffer capacity.  A long event name ending in "_alarm"
can have fn_item_len - 5 > sizeof(fn_type), causing strlcpy() to
write past the 24-byte fn_type[] array.  The assert() only validates
that the longest *valid* hwmon item fits, but does not protect
against crafted input.

Clamp the strlcpy size to min(fn_item_len - 5, sizeof(fn_type)).

Fixes: 4810b761f812da3c ("perf hwmon_pmu: Add hwmon filename parser")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hwmon_pmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index fbfb872ceb1826d8..bdcbe887579a1f08 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -202,7 +202,8 @@ bool parse_hwmon_filename(const char *filename,
 	fn_item_len = strlen(fn_item);
 	if (fn_item_len > 6 && !strcmp(&fn_item[fn_item_len - 6], "_alarm")) {
 		assert(strlen(LONGEST_HWMON_ITEM_STR) < sizeof(fn_type));
-		strlcpy(fn_type, fn_item, fn_item_len - 5);
+		/* fn_item_len - 5 strips "_alarm"; clamp to buffer size */
+		strlcpy(fn_type, fn_item, min_t(size_t, fn_item_len - 5, sizeof(fn_type)));
 		fn_item = fn_type;
 		*alarm = true;
 	}
-- 
2.54.0

