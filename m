Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204314D8CE;
	Fri, 19 Dec 2025 01:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766107102; cv=none; b=tjbyualk+Ny9NFtIpYT3b3A/9Kelii89XNcl8n1aXzwf4gshitMM7tX842NCCJHoh+zmfyV0wFkY1f/Eb7TOOr3+o4coypC+H00yLj+29liguVwsXSYAQ/j5yw1F6JQw9HxkUieE5nuJmmqfigTOw7K0sWlIq8tzLMhf0TfnsJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766107102; c=relaxed/simple;
	bh=a+5hEykq+ZmRRXBx4PFazJjHDDJggJssEC28KRAuILA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jHzY2olDSayP9vsbIW5UfmCEuEyjj7UzPL+AtxnPtFCzLhOOGWGmDQsEmu2WsLoHsqeLnpHaSkbEIC9asCJ8ujLqGUvA7TvuUoK8xOymuxYwHtZuou3PjYd3ugDUUgdd5sfUgI7hUPQ0VV3YqTP6C008al+LcAUfxKhgIObYKd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMFUbR0o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMFUbR0o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3794CC116C6;
	Fri, 19 Dec 2025 01:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766107101;
	bh=a+5hEykq+ZmRRXBx4PFazJjHDDJggJssEC28KRAuILA=;
	h=From:To:Cc:Subject:Date:From;
	b=YMFUbR0oIwUJFYQcj0z+HrxSkv4x/cQu5gUYBeTtC/P5hhBFaXZ++TgSSoWHdGVUl
	 KAYlAaqTX55mpM+VFkrrSvPoxK59V2W7T3JEf4v9Cy+T7qr+EeJG47AIt4/CP/4G4E
	 SZE13wjvaRjzXvcvGqdYQnVPfV3pViw67momrel7FFjFq9XS2WKD1LK4NnpRNs8DMb
	 3879SescFh45m48eGFRhcFWqmSe4QaroohxtNVouuWLPhZM1EZW6EzdmasuxAL0nLi
	 1W/bHlll711185ULpaVwuI9D53cC8tsZBH4i56Zz1m8b6FgGtP+9yTY7RkErR0JcaM
	 9ktqOPNM5YJmA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/4] perf test: Skip dlfilter test for build failures
Date: Thu, 18 Dec 2025 17:18:17 -0800
Message-ID: <20251219011820.2505506-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.322.g1dd061c0dc-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For some reason, it may fail to build the dlfilter.  Let's skip the test
as it's not an error in the perf.  This can happen when you run the perf
test without source code or in a different directory.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/script_dlfilter.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/script_dlfilter.sh b/tools/perf/tests/shell/script_dlfilter.sh
index 45c97d4a7d5f90e8..7895ab0309b29dd5 100755
--- a/tools/perf/tests/shell/script_dlfilter.sh
+++ b/tools/perf/tests/shell/script_dlfilter.sh
@@ -70,15 +70,15 @@ test_dlfilter() {
 	# Build the dlfilter
 	if ! cc -c -I tools/perf/include -fpic -x c "${dlfilter_c}" -o "${dlfilter_so}.o"
 	then
-		echo "Basic --dlfilter test [Failed to build dlfilter object]"
-		err=1
+		echo "Basic --dlfilter test [Skip - failed to build dlfilter object]"
+		err=2
 		return
 	fi
 
 	if ! cc -shared -o "${dlfilter_so}" "${dlfilter_so}.o"
 	then
-		echo "Basic --dlfilter test [Failed to link dlfilter shared object]"
-		err=1
+		echo "Basic --dlfilter test [Skip - failed to link dlfilter shared object]"
+		err=2
 		return
 	fi
 
-- 
2.52.0.322.g1dd061c0dc-goog

