Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE573D6688;
	Tue, 20 Jan 2026 22:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768947079; cv=none; b=lzOcZRk0C5a6mzFEERhW5S6rTWk0Upc1jsfqcknF9sMm7c6IeeY8kwDZQ0uWC6gbulgESkrHCK4a8P8qQ81Gf5kMsw1YtkBws2J7K1wMB8/YnNDgUnHZrafjF2hOeQAT4ubzAKokepjjMeI+vbk8g+zifqPepMK1RWmwcMZFMLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768947079; c=relaxed/simple;
	bh=9AQ04Q45KYJvgiQU6eyRgu+IU8LONLjTjfGyl0Bpwi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JndacWyDmmmOI0AgnY2duerMngjsqbtOon5+vYACAE8wF1MLiPOsQJ2G8F8ArTZtqkxUr/uLvwZhKs2ZjrrMD3A7lw5vIQiR6um98ywTI2Nlb0iO7KwrzUubLQSoUen1gsb7zyTucpnkf83rBmZvmBHJNf8pCIgz5ElGTL6q3sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vhq6UHwL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vhq6UHwL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCBAC19422;
	Tue, 20 Jan 2026 22:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768947078;
	bh=9AQ04Q45KYJvgiQU6eyRgu+IU8LONLjTjfGyl0Bpwi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vhq6UHwLs31n5OYRl7O4R6lW97+tl/MF6JcSIT63Pd7IwWpvfk8P6A6V86ZqNMOFJ
	 mj0A8aLa/ttnmSidn4G0iJZ9/liTYZnWRL4px5vRMt+cBjXngxVjQ+NQ5py7uLYN1x
	 OG7bWeg9Wr+d14dvfZGoxkJEqd2U6ehSpgF8+IiuGAV4qalcCd1lbhc3AQPVfKcfM4
	 kckSPHH6jLcZQ0Quf1ROKXtjJJfZRvZjrmuDjTqkKKU82v0kZA3DXawS4zAoBlqMU9
	 eDjxqzJVr/aV2RE0WPr6KYcx1Q7351fcQKZftFX7zKG7W+ermQlxCyw2/eOlqOhW0m
	 WhL3/X9EXzMXQ==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 1/4] perf tests sw-clock: Mark the volatile tmp variable as __maybe_unused
Date: Tue, 20 Jan 2026 19:08:57 -0300
Message-ID: <20260120220900.366451-2-acme@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120220900.366451-1-acme@kernel.org>
References: <20260120220900.366451-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As it is just used to waste some cycles, not being used as all, to
silence some compilers.

Noticed with gcc version 16.0.1 20260115 on fedora 44:

    tests/sw-clock.c: In function '__test__sw_clock_freq':
    tests/sw-clock.c:31:22: error: variable 'tmp' set but not used [-Werror=unused-but-set-variable=]
       31 |         volatile int tmp = 0;
          |                      ^~~

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/sw-clock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index 4a2ad7176fa07be0..b6e46975379cd5ef 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -5,6 +5,7 @@
 #include <stdlib.h>
 #include <signal.h>
 #include <sys/mman.h>
+#include <linux/compiler.h>
 #include <linux/string.h>
 
 #include "tests.h"
@@ -28,7 +29,7 @@
 static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 {
 	int i, err = -1;
-	volatile int tmp = 0;
+	volatile int tmp __maybe_unused = 0;
 	u64 total_periods = 0;
 	int nr_samples = 0;
 	char sbuf[STRERR_BUFSIZE];
-- 
2.52.0

