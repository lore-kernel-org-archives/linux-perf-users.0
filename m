Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B0D376E9;
	Mon,  2 Sep 2024 01:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725241586; cv=none; b=slNEG43oSOSnVL7CuXwXi1Zgmbf1uwDmOKtI5lMra7g2HRIf+6FdelkPOAEwBdMTa/FrfcGgjr322mC7lQtiIXfOrF8tfirT4b11eTOAQUCcj1Hf5Fuf6z+bpRRbBeAcqC/RPjeMNuJS6ZZ9vw7Jbx+wU5NFuoQqoW8IeOHanJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725241586; c=relaxed/simple;
	bh=32VDGrtfHMytoPOOFqHZVvYDvIox7PLmSkvoaBgXsIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ag/0oLWqCAlAlvlPJDPqSLMFcwROiW6j3df/i9HUSvO4TYwN+nayQW41ORpn4eTLIXvHfpgFbzHsy2q0zoiTy/91h5eMEvsCdOwrcdtLJ8oosRGBnCvWEKtJlVdE6uhlTY5GZK6EAk9LOMfhjxTnO2eW/deFa10z8kL2Okc1BWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIFNVEnS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIFNVEnS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60E1C4CECE;
	Mon,  2 Sep 2024 01:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725241584;
	bh=32VDGrtfHMytoPOOFqHZVvYDvIox7PLmSkvoaBgXsIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aIFNVEnSxcEGkzGCw7l2Te5Q58MnTyN15NRRL+8wGpFx4ELY8VYcjhaPYdDfEIpPp
	 3921zsPtICec10+cXv1DdVfPnVmpAnxCBTCCjMZb0pGwb5tetPYrxuBdPR8kXl7vRb
	 M/jw37OZ6dE6Bk65bgCo5h3PovWCSQ6oltLEnPIrCKzPFe8jZ/p8GQy3qP9cq7zHt+
	 QtOzBOmWpAXq4357kNQ5BFKP7e4SWIEts6JT15KimcVu+LdHQ/TAnTzwoIg9w0XJN5
	 eDphdxxg0hnjbV1U5bMNaJuh/Tv3yI/waw/Tad0hZL110wYR5KcDrvqke/4+STjVPx
	 WQzePK8kMpgUA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>
Subject: [PATCH 2/4] perf tools: Simplify evsel__add_modifier()
Date: Sun,  1 Sep 2024 18:46:19 -0700
Message-ID: <20240902014621.2002343-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240902014621.2002343-1-namhyung@kernel.org>
References: <20240902014621.2002343-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since it doesn't set the exclude_guest, no need to special handle the
bit and simply show only if one of host or guest bit is set.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 49cc71511c0c..57fe0f9b06f9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -548,7 +548,6 @@ static int evsel__add_modifiers(struct evsel *evsel, char *bf, size_t size)
 {
 	int colon = 0, r = 0;
 	struct perf_event_attr *attr = &evsel->core.attr;
-	bool exclude_guest_default = false;
 
 #define MOD_PRINT(context, mod)	do {					\
 		if (!attr->exclude_##context) {				\
@@ -560,17 +559,15 @@ static int evsel__add_modifiers(struct evsel *evsel, char *bf, size_t size)
 		MOD_PRINT(kernel, 'k');
 		MOD_PRINT(user, 'u');
 		MOD_PRINT(hv, 'h');
-		exclude_guest_default = true;
 	}
 
 	if (attr->precise_ip) {
 		if (!colon)
 			colon = ++r;
 		r += scnprintf(bf + r, size - r, "%.*s", attr->precise_ip, "ppp");
-		exclude_guest_default = true;
 	}
 
-	if (attr->exclude_host || attr->exclude_guest == exclude_guest_default) {
+	if (attr->exclude_host || attr->exclude_guest) {
 		MOD_PRINT(host, 'H');
 		MOD_PRINT(guest, 'G');
 	}
-- 
2.46.0.469.g59c65b2a67-goog

