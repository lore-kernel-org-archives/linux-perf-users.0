Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A1E1E766E;
	Tue, 11 Feb 2025 06:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739254068; cv=none; b=ZvOduN627qHvMym5FfFvdsuTP6CRL60JsR/4V4FW03KYBolShLT+YzJuvlBbk4+Pbr0c0PkjUYwaxjmg4AljJQo1/SL7zEkeGYcwMPdQ2KarUabka4Rvcm5KMl33qIbEeVBFrcztRNfzi8F0TxDxrBTkLcRrvzjxtLTFUcHZeWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739254068; c=relaxed/simple;
	bh=sxQSDoICKZWMHi5BefHvcEATFMf5kox19lsFSRKsn60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLTH28WmqCke5xoe+0FI5PK2tbX4OhRmRUzruTWwTIWcM1LjgxLfxFs6NrvDL6gti/WsoNxlPAV4RKgrtOHyVHmC3Yx0i4i/G03oTQGhyPNJ85YgMPssv0IcPE4luDFer9iw40/Xr+66OJivVHbqMYqJuh87KDWadaT3JwOpkdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ua5tixpo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ua5tixpo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F73C4CEE5;
	Tue, 11 Feb 2025 06:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739254067;
	bh=sxQSDoICKZWMHi5BefHvcEATFMf5kox19lsFSRKsn60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ua5tixpo5WylQ6G8oEaMsW/DEokF/vKOiFmu7KQp1n1z5gKvnryPwE4ghhXMgVcIX
	 x7Cszj0dR6tE8vFKCuj3YxLKghKhLln1IC63ae0wjQuFdXNS+V87CB4fpdki1j6qR8
	 2gmzBg5UemWMA9Nrh8JwGmKxh/FCrixFjpmFQ4G/szoRUkOPeYJLB7JvJ51MdXcGIL
	 yA3bPBK62fM0SYTOzEfiKLW4my+5WAjXt9Yc5sjup+D/Je/Qsby1FX7M2CSnwEy6qH
	 PFWlPU1Frepx8+RMGjn3HbH5n/1JyCsGEjZthxRjtN8XbARvU7qM1SWgX9N9m7+iFL
	 CddrGQh9gsY3Q==
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
	Dmitry Vyukov <dvyukov@google.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH 2/2] perf report: Support switching data w/ and w/o callchains
Date: Mon, 10 Feb 2025 22:07:45 -0800
Message-ID: <20250211060745.294289-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250211060745.294289-1-namhyung@kernel.org>
References: <20250211060745.294289-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The symbol_conf.use_callchain should be reset when switching to new data
file, otherwise report__setup_sample_type() will show an error message
that it enabled callchains but no callchain data.  The function also
will turn on the callchains if the data has PERF_SAMPLE_CALLCHAIN so I
think it's ok to reset symbol_conf.use_callchain here.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-report.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index c99b14a852dbdfbb..e7a7e9df1b42b3a7 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1826,6 +1826,11 @@ int cmd_report(int argc, const char **argv)
 	if (ret == K_SWITCH_INPUT_DATA || ret == K_RELOAD) {
 		perf_session__delete(session);
 		last_key = K_SWITCH_INPUT_DATA;
+		/*
+		 * To support switching between data with and without callchains.
+		 * report__setup_sample_type() will update it properly.
+		 */
+		symbol_conf.use_callchain = false;
 		goto repeat;
 	} else
 		ret = 0;
-- 
2.48.1.502.g6dc24dfdaf-goog

