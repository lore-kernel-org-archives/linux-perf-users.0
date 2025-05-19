Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB1F221D80;
	Mon, 19 May 2025 21:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747690926; cv=none; b=XI/X2iY6d5MDRkVNg2CC7MBxuY6FbkXMPLw79uI0fXFQy9jE9+Z/ygPtGfq4+NmafctaK+zkWgE3GrKlyvJ9H5zA7N6yuJEaBCh7QEXkemzeBcCCiKrbgxAI7nph0ML2j+GPJ3iBOWxSuBrBMfLAus3LN7gXfb/Kd52pHzBNlCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747690926; c=relaxed/simple;
	bh=hSFbYg8OWGPPQrOY28FmY6n86ImIh7i2KLy+D4o/8Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5rZjwGOYFfyX7pOK52DedIld6Cmsjp+mi5OaIaKUnD9+OjITr18QLInp5M/SG/uVV99Y2/wNf/iQH/EAq7LinsflS0liiCAUwvfMLt7j4+Pt7Igq31qIYf5URag4ZYnXMZZlgfRWmRlZBRZnmtq6sv3Kat99bsBtAFZmfSB1LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stHw1mRa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stHw1mRa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FF3C4CEE4;
	Mon, 19 May 2025 21:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747690925;
	bh=hSFbYg8OWGPPQrOY28FmY6n86ImIh7i2KLy+D4o/8Fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=stHw1mRajJxtnKs2g7cdpPgek066WnIpMC1BPlb5mZ6z0ki33D1S14rV3vEoDFfFs
	 RJ/dJ31YBKkPfDOk1/B2l/y1/a7bvgg4uVobA/2ZBEBCfWTdyKvjP10mc18YR5iIT4
	 lMR2+PDOQkJPa4GOJqzGo3/JJl1FT9Z1eeaZ69XLlvv+/dQrfc9Y/4G5RXLPlsce/g
	 UwkWBAYRVH5CIvSXsmrnOqSeg2pNTvRC/tuYXVYKr50x6sCmAbAw1WjeiYSxRyAs4D
	 QEBk6zXqvDj3M8j4uWzyjEyg/JIUDt5A2dlcqvVehPtPK7jgm6ZlgVBv6+dlxTYDVu
	 wXyMtgJ2w7ZOQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 7/7] tools headers: Synchronize linux/bits.h with the kernel sources
Date: Mon, 19 May 2025 18:41:26 -0300
Message-ID: <20250519214126.1652491-8-acme@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519214126.1652491-1-acme@kernel.org>
References: <20250519214126.1652491-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes in this cset:

  0312e94abe484b9e ("treewide: fix typo 'unsigned __init128' -> 'unsigned __int128'")

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/include/linux/bits.h include/linux/bits.h

This required picking the const_true() define in linux/compiler.h as a
prep patch as that macro is used in the new linux/bits.h

Please see tools/include/uapi/README for further details.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Yury Norov <yury.norov@gmail.com>
Link: https://lore.kernel.org/r/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/bits.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/include/linux/bits.h b/tools/include/linux/bits.h
index 8de2914e65101463..14fd0ca9a6cd1733 100644
--- a/tools/include/linux/bits.h
+++ b/tools/include/linux/bits.h
@@ -20,9 +20,8 @@
  */
 #if !defined(__ASSEMBLY__)
 #include <linux/build_bug.h>
-#define GENMASK_INPUT_CHECK(h, l) \
-	(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
-		__is_constexpr((l) > (h)), (l) > (h), 0)))
+#include <linux/compiler.h>
+#define GENMASK_INPUT_CHECK(h, l) BUILD_BUG_ON_ZERO(const_true((l) > (h)))
 #else
 /*
  * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
-- 
2.49.0

