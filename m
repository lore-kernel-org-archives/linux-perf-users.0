Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600568;
	b=f6lA6mp4OHwOXsfez4585jjvlzHrKfgCCXaybi/zlnJSlAS0cV9PFFXoZQq/aBpSNx3x
	 zE1DpqsIXOC9e6ksy3+h/5aWAFHtECKlOca/qoFMPZ+yrDbq6bj7xk3JuDbJlBGX6IXJ9
	 F9V0ie/e8OTBJlPGKxc/5Y/U1Vf5LyeGtQT5yeRLGxUZLPIV5c/l45qkk8a0/gUr+9wQj
	 RMiH0wkAI7aJ6rMrEOfaBbHbPP86LjhaCce43g7dYdDPA5UqikRs8fewwplr7f4jisEin
	 Wrx4zPWpqKB+8QHlU+4YjT838Dq2UWQIGHbPlYR81LbHye3FDR2b9Q9sq0VxB5cEDrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600568;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KX+bt6x4O+wdhm+tqQl1JkjXBpFPjHXF5FgbUfKl0ok=;
	b=rRinCFzrOkuzVHVRqEJliAE4GPmc1xuOqKF/R54h6WHt9UKXKEX89rvll039yWanHZxv
	 4zdBaaaaMvluWSbIGlvuV0U9Kz+g0N4QaKLkvD/0kBUMqoQt/X/NRZJvVsJeLBxCOAt0q
	 p0oW9eiENCVh4m9LMNQmHzI++Kb9lRR4JrHKP6Mq3hbQ3Xa7yzau0NgT0Uqix79nvT+sL
	 oHJq+zREvXaQYKluRNe98due5n28zkuMfCHIsKwSQY+8kRh3YJviwWGlaosgA2ckn+Gls
	 Z4qTT7bUok3fsXGi8y6fqHzg9xKapgIWKjNhPnNLfaZHq6ZU9TG8uYE5A3M/7Q3IcEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eChSUlAm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDD6606A8BC;
	Fri, 13 Nov 2026 20:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eChSUlAm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD1E1F000C5;
	Fri, 13 Nov 2026 20:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600567;
	bh=KX+bt6x4O+wdhm+tqQl1JkjXBpFPjHXF5FgbUfKl0ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eChSUlAmfQ2Uyf51R6XXjyVqcP1Z8DdVVGgV8zSr6m4qmXOeaTk4gcC2vO2vEAqd4
	 7O+rsGhqDExPuf0Fzk18wqexfjqxKKrS65MSoWOQBG9HGMxpj6C+p+ZQXOjmxIbEc0
	 nKsO7oQUl1pMTVYogTmsi16y5ceqfqHeo0NPFsfAJDBZl+Sw9cQW8gPy62I8aE9/lj
	 jWoUN6gXXljuqODk6mtA0ZfGXNEYfOYAZC79NcFdzVNhAbBGr8dE9Wclwk/MpO5FtW
	 jsDYP8aSX0pclG5ikK6waY0b9OQWxMp43rvCosN/mOcf6zAIA+4D5elVBo4r6amhB2
	 2pUsIzFmDARlw==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2 11/11] perf test: Skip the LBR inline unwinding check when unsupported
Date: Fri, 13 Nov 2026 17:08:49 -0300
Message-ID: <20261113200850.2803460-12-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113200850.2803460-1-acme@kernel.org>
References: <20261113200850.2803460-1-acme@kernel.org>
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

The check only looks for the PMU's caps/branches file before recording
with --call-graph lbr.  AMD BRS advertises branches but only samples its
own retired branches event, so the record with cycles is rejected and
the test fails instead of skipping.

Probe the record and skip when it fails, as the branch stack test does.

Fixes: 446c595dc0dd ("perf test addr2line_inlines: Ensure inline information shows on LBR leaves")
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/addr2line_inlines.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/addr2line_inlines.sh b/tools/perf/tests/shell/addr2line_inlines.sh
index e8754ef2d7f21ac2..6fe47909dae4f812 100755
--- a/tools/perf/tests/shell/addr2line_inlines.sh
+++ b/tools/perf/tests/shell/addr2line_inlines.sh
@@ -71,7 +71,14 @@ test_lbr() {
     fi
 
     # Record data. Currently only dwarf callchains support inlined functions.
-    perf record --call-graph lbr -e cycles:u -o "${perf_data}" -- perf test -w inlineloop 1
+    # Some PMUs advertise branches but reject branch sampling for cycles, e.g.
+    # AMD BRS, which only samples its own retired branches event.
+    if ! perf record --call-graph lbr -e cycles:u -o "${perf_data}" -- \
+            perf test -w inlineloop 1 2>/dev/null
+    then
+        echo "Skip: LBR not supported by the PMU"
+        return
+    fi
 
     # Check output with inline (default) and srcline
     perf script -i "${perf_data}" --fields +srcline > "${perf_script_txt}"
-- 
2.56.0

