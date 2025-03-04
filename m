Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BFA1F3FED;
	Tue,  4 Mar 2025 02:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741055323; cv=none; b=DwuZSF4Ddw2XRTjzMYaMtKMod0S9nIG1xQm6/cANVb2AO7eqip4w8M6D3pKcyqpvee6Y+eFdBSOrYTRNW6w7q2rPw2/+CquDo74Ufdh1yFORh8VoTVOnfUZVGauXCAL3j9zUh91e0TRmRuz8hOz7KacnR0KlXdBW0nYHLbR6NuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741055323; c=relaxed/simple;
	bh=0hdoilLOGa6AOrQ12FPGta7eflB7cDeA1VkIKF6W4T8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QB83wxOiyGUz4mFT3EF7nhkVRLBds7OOo65nP2uwfPYtlc63UEUTZeW7zl3pmGD5eNm4HY7P/yaRbc2T92vdC/Swi/QfT56Fn6QnwTayU4aQV3fTEXD5K6VVuhTSVifJoLlWHbSfKI/H7XdS9Nt46jsFWkWYZOJZ9OzKC+y2hsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYbRyQQj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYbRyQQj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14241C4CEEC;
	Tue,  4 Mar 2025 02:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741055321;
	bh=0hdoilLOGa6AOrQ12FPGta7eflB7cDeA1VkIKF6W4T8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DYbRyQQj/mUwkLjRakZGzLwB51Aq6kKksQIL+lcYUKXvh9pq14VsJiFPgqOmnzOxN
	 4KksIn5QZa8so4nhsPZ949SxgXXzlu6i9heopNIGkLuqgu8EiI9KU+FJvkQN5ZTDgF
	 BzLthqgKGgJR3PuDUlMA0kQdMJO49MxKxcrQTYih9NFLcPjcNdcVof/Ny8WkAf8nSy
	 HOHgthgZ5FzEhyX7GIAlUQ/3np6u2J4jZNp2LaYeStudfXodjjIE1hluGLKPZTu50K
	 NlU+cpajvUcZo0dE9wNZfeAr8MnxL8ucX//EpRD9r+vWwpqAgycHf+IrpsAyhkIYB1
	 MBXCEyUTipYhw==
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
	Thomas Richter <tmricht@linux.ibm.com>,
	Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 6/6] perf test: Simplify data symbol test
Date: Mon,  3 Mar 2025 18:28:37 -0800
Message-ID: <20250304022837.1877845-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250304022837.1877845-1-namhyung@kernel.org>
References: <20250304022837.1877845-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now the workload will end after 1 second.  Just run it with perf instead
of waiting for the background process.

Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Leo Yan <leo.yan@arm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/test_data_symbol.sh | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
index c86da02350596b35..1792b7ad4066f8cd 100755
--- a/tools/perf/tests/shell/test_data_symbol.sh
+++ b/tools/perf/tests/shell/test_data_symbol.sh
@@ -5,8 +5,6 @@
 # Leo Yan <leo.yan@linaro.org>, 2022
 
 shelldir=$(dirname "$0")
-# shellcheck source=lib/waiting.sh
-. "${shelldir}"/lib/waiting.sh
 
 # shellcheck source=lib/perf_has_symbol.sh
 . "${shelldir}"/lib/perf_has_symbol.sh
@@ -60,19 +58,10 @@ echo "Recording workload..."
 # specific CPU and test in per-CPU mode.
 is_amd=$(grep -E -c 'vendor_id.*AuthenticAMD' /proc/cpuinfo)
 if (($is_amd >= 1)); then
-	perf mem record -vvv -o ${PERF_DATA} -C 0 -- taskset -c 0 $TEST_PROGRAM 2>"${ERR_FILE}" &
+	perf mem record -vvv -o ${PERF_DATA} -C 0 -- taskset -c 0 $TEST_PROGRAM 2>"${ERR_FILE}"
 else
-	perf mem record -vvv --all-user -o ${PERF_DATA} -- $TEST_PROGRAM 2>"${ERR_FILE}" &
+	perf mem record -vvv --all-user -o ${PERF_DATA} -- $TEST_PROGRAM 2>"${ERR_FILE}"
 fi
 
-PERFPID=$!
-
-wait_for_perf_to_start ${PERFPID} "${ERR_FILE}"
-
-sleep 1
-
-kill $PERFPID
-wait $PERFPID
-
 check_result
 exit $?
-- 
2.48.1.711.g2feabab25a-goog

