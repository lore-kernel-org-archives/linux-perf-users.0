Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792739505;
	b=P4UK2GFBitnaR2iW4yoVDSQcTjO0cb8IQdI/23V4ru97ezv4gF3wZHRVwv2LccBAJJCE
	 opbnAQp558R4ylBkmQEmJN7gGOOtCu8F+u7eNCEUPjWzOZBQMKW5O6yWC+9qCnDGSTqtb
	 0vSLE8ZmNeWnGAnMAvfKRHjQ12n5+YpoVYgdZvwAgGIXbfgvQsNasX7g0UviG9P4AZEN9
	 O8SNkPqDyV7d0hme4X/80RDhj/fZdvv6wXe3iuAmjJoaBEhKSRm5SqAdoN86zHPpxlv2R
	 owepxeaeDaeWRcIdvwI/ZYUEnRXji+LLX1HtAtWuqt4hmjMTbXU4swXxNFTEMZwsL4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792739505;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=q9blhtE4zU7Bnh89OSKDx699eJU0Cd4CoeuAqxPDEqk=;
	b=LAfJlcPhZFGStum/5JAvY0C4CXtPYm/6tLkXCCHRbxUVf8MvW/bXreAEWPUfY/1R1zsG
	 u7UbxE38GCRojm0J71TelfG/2j24pxCQvi7v6aB3kDTpZgT/E+gs7xPH1E0b5p0ZW4Mq6
	 wD9esteuoNPxxnNq1ojtVjry27FmNIbeHNrJjIAt2Xa5lZ5OWAye/vq8GlwNTNOuRYfHI
	 IB/h2tiG3AFlLzbm7cwu/0J2+fuA0NHj1tHCnIVprrDq7kVWsAwN52A5iI1Tg80PEU5ix
	 BiYeK+0bdDNcVc8kKwLHmVtDvVfz2lyjKsm0cDrotHf+vCl6hoxVURoyw+MhufSwz9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QIR8gEr3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FEC606A31F;
	Fri, 23 Oct 2026 07:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QIR8gEr3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE8E1F01828;
	Fri, 23 Oct 2026 07:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792739504;
	bh=q9blhtE4zU7Bnh89OSKDx699eJU0Cd4CoeuAqxPDEqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QIR8gEr3azAiXxclhZI/ufE9IAxKXNF6Y8pW+oSccqRAi254pM9MGVslw6W8bhXbF
	 8TKWDMaPs8PLcqHOu4QUSVne7DF+8fqEZULIyv5T4gaV7jXHacXmRinGeflhy3etsl
	 wOvuJGlnKZGEJYAYLHqJyCjavL0h6jEYt4DWZY3S02er9zWzOes3csJvZIQhdbYK47
	 W+nSTYQ6LjKTmZv3HBpuFnf6v+aQgHf0VKIzoSnc1HRnyjaiOBkzKgBUpaIBNkGEkA
	 KwMRkSmtimI9oxZ0mYRIS3Xx1gXrmeIMNBQVAVIq83ppr1UfzVrqvDsv3Bm3cFXebF
	 y5ekkMbL+4EpQ==
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
Subject: [PATCH v1 02/11] perf tools: Add perf_env__is_same_boot()
Date: Fri, 23 Oct 2026 00:11:32 -0700
Message-ID: <20261023071141.134149-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
In-Reply-To: <20261023071141.134149-1-namhyung@kernel.org>
References: <20261023071141.134149-1-namhyung@kernel.org>
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

Assisted-by: LLM
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/env.c | 21 +++++++++++++++++++++
 tools/perf/util/env.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 8ca0b677f3172b5f..735db21d66a019a5 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -444,6 +444,27 @@ const char *perf_env__boot_id(struct perf_env *env)
 	return boot_id;
 }
 
+bool perf_env__is_same_boot(struct perf_env *env)
+{
+	static char *host_boot_id;
+	const char *env_boot_id;
+
+	if (!host_boot_id) {
+		host_boot_id = read_host_boot_id();
+		if (!host_boot_id)
+			return false;
+	}
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
index 772d11eed1bc2a7c..df1d3d1ac3376e1e 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -189,6 +189,7 @@ int perf_env__kernel_is_64_bit(struct perf_env *env);
 bool perf_arch_is_big_endian(const char *arch);
 const char *perf_env__os_release(struct perf_env *env);
 const char *perf_env__boot_id(struct perf_env *env);
+bool perf_env__is_same_boot(struct perf_env *env);
 
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[]);
 
-- 
2.56.0.257.gf7497c7d27-goog

