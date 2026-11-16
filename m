Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808654;
	b=jaeYeRt4PeJRb3XQ1WjZ2YY5TQdJb30JMQjzLpRCJNLvP4UUWioa9KRRj1EA1pSJols3
	 +8NgbRMaFUEegVHkE5zTZVHeGcSWqntz2X254NncsTOZ4HN8+qrMoB1MWMqvEKMTeLs/D
	 7P+6QklTk4CvdASg6Cl/OHKILS6g/rF9hbdLCSmgSAxaiH/Dq1Kc24EQzByI9P5EgXoO/
	 BIyv08d/WhbwMhu7J1aoLsz8tmXX5XIo/C0ZEHW1g+bW6XoMMvgsZV4g0WZlR2qqP+qGt
	 Exqq3NOnZM7akrLQ9DIINXQe9jfGf0UJhXYBfy75rONMNOKShTFZTmLOxLF3pW5N/bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808654;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gMtU4LCERX9WZHMt3Ydl78C77Xu1fXER8ZUMWmXR5EI=;
	b=l4BUu7+Qt4epwp+Vywt7RCBGkyUAACTJsaYwHQEDybRUiRlZoDtC+uAwtLkUkmvBUcR1
	 q6auXEv/ti+7aFyk8PyXLF+H8Hj+21whrzori5CJBlV9FUofHNs9BctahOrfrrw6zle8l
	 pjeUfTWl7h9yisLZgwn8HYKID4cEdu6VSEehnPCGOv+6KVuADV3Cn66AE5j/teM1SHZPg
	 TLa6Ko+AZnmk9NLb2eazRofk7FabTaVhL0oZgmd87L+0a0xkp0UGceyBf8tPiShOmFvpf
	 fIlXuxVXP9AEZx4iWIlK5tvzUgHwYcAppZ9vkRRy38ivfKcRnkOdsPeNeyorNTS/GBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CccuBun+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FF7606A334;
	Mon, 16 Nov 2026 05:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CccuBun+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96771F000C5;
	Mon, 16 Nov 2026 05:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794808654;
	bh=gMtU4LCERX9WZHMt3Ydl78C77Xu1fXER8ZUMWmXR5EI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CccuBun+nX0Vr+P++1DeghzPHogTAoK16VEguuKK3pMdSYNbHHwEWZg/8al8lN6fV
	 OX2IOI9orubUidx/IsnR63bYntpG30ZAE23Tzbs5Mx7l/hp9eH6JZQJYaY3l2FB1vi
	 ffWpfUKPWc/ZqtrkcoGQLgant4YE6TTZ/D8SA0pvNjG80RudY4Fhsm3T6pqu2EPBzU
	 LAgVm7lgpHmEc/GQcThcB85XJintBj5pxJufa0rX3/zzoVEm+lsfqJlskD9c/tObDp
	 t/ppyhXXP70DtBwhqZ87kp9jamz/zSE5W1yCdzr1r6GWMBGUDyundFcmSdefnVpv4f
	 YSfUzm5ydIdBQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 02/11] perf tools: Add perf_env__is_same_boot()
Date: Sun, 15 Nov 2026 21:57:22 -0800
Message-ID: <20261116055731.707164-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
In-Reply-To: <20261116055731.707164-1-namhyung@kernel.org>
References: <20261116055731.707164-1-namhyung@kernel.org>
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

Add perf_env__is_same_boot() to compare the recorded boot_id in struct
perf_env against the running host's /proc/sys/kernel/random/boot_id.
For live sessions where no offline header was populated, it falls back
to reading the host boot_id and returns true.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/env.c | 25 +++++++++++++++++++++++++
 tools/perf/util/env.h |  1 +
 2 files changed, 26 insertions(+)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 24de685486af9bd5..91ab4ccaf5a9475c 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -444,6 +444,31 @@ const char *perf_env__boot_id(struct perf_env *env)
 	return boot_id;
 }
 
+static char *host_boot_id;
+
+static void init_host_boot_id(void)
+{
+	host_boot_id = read_host_boot_id();
+}
+
+bool perf_env__is_same_boot(struct perf_env *env)
+{
+	const char *env_boot_id;
+
+	DO_ONCE(init_host_boot_id);
+	if (!host_boot_id)
+		return false;
+
+	if (!env)
+		return true;
+
+	env_boot_id = perf_env__boot_id(env);
+	if (!env_boot_id)
+		return false;
+
+	return !strcmp(env_boot_id, host_boot_id);
+}
+
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[])
 {
 	int i;
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index aafd213c7523c018..856385624cee6adf 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -190,6 +190,7 @@ int perf_env__kernel_is_64_bit(struct perf_env *env);
 bool perf_arch_is_big_endian(const char *arch);
 const char *perf_env__os_release(struct perf_env *env);
 const char *perf_env__boot_id(struct perf_env *env);
+bool perf_env__is_same_boot(struct perf_env *env);
 
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[]);
 
-- 
2.56.0.611.g1030f0b940-goog

