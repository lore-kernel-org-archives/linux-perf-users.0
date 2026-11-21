Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795231299;
	b=Pso1R44uhKS30MiV/Pnd3m/O1dQ/f5QIIRP1W4b211MeYpj5iqVGlhjY949mHQV55QwA
	 fnZNhvqdMeUVpXsLZrGqSW4YLwxmTUlDln0MWkQP8BfM9MjfqeL9cSO4nCcc4ZQnD/yXv
	 h0ILj3xSSdy9+rStU6vQnNFyymp71Y1vR9mVw2KV58e7mIZY+i3WMV9r5MtTHZ5HyCT+k
	 EUMmsuyCFzFQkqKKLjL1D4p3g4pKNR5dO0eX1qVtlLUSkl4yX4SU3JTLRm0bpyZRmkm2Q
	 Que+2HsjkNMN+7/+VjZ6eiyetvj6gmTQs9/gIGS/aBh1W803MP0t/lfpWDb29bRqCvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795231299;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KGmUhDDN0UG2rp9CP1JqbUp2tr3lxr0jBQoyS/TZUB4=;
	b=qBs1cd4U3VpTS5SYwTv2PzuY+XSpHZY5eFsrtbs5UoGEHpkAlT1wyoC5yf/xUdS57Hfm
	 NMQVR1tOMOvAbzbFTy1UYmohNkAUm6BQ2099GJZzYEZdidkT9t6cijQE1Uvsg/N7a0cvD
	 rm57JUn0ZxUGS4N5FV2q2I9ElExE+xp0eBfVM3VmaZVRs3XoeKZQX3eqaFNWgIBHwaDC6
	 bxRkNPVEevklyGWPtbDr+0c9NgmJgqc+PeG+7HIxZ1vpK3i2aMirwby3WXtLjadFTRMSe
	 YqSLb+or4NhJ6YWZH+AgFX36L9OvLhn4fLANAitfhy1vHLDLsvWc2RmeOZKQDfZQUHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BRtFJoRk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64B4606A688;
	Sat, 21 Nov 2026 03:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BRtFJoRk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A516C1F000D0;
	Sat, 21 Nov 2026 03:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795231299;
	bh=KGmUhDDN0UG2rp9CP1JqbUp2tr3lxr0jBQoyS/TZUB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BRtFJoRk18NP3mT16WjH8JVKBY0E4csK+or17dxP4mlXCCzBToZ37SIw9s22LMfbW
	 Fma3qKtDppeaJjbu/XJxwhkfnVQpIlTy4EaoNMuSgEr12fnI9Z15Or3cVQSxl9/TT1
	 cgS0gL8MZYuA1Vb5eYgNXP9ukS6aeXS6g14HrHpw0luD/5swsYOeo9qUFWxJmwTfT5
	 pmjh7Wh3oJ/qoeFbQtGsMAvIw0JNf6s8xTmIoobuDBnkv5D34PlE4sfJ3A5OehiUca
	 kXCfvUa1gQ6rUSw7b/1UcvLiSETyA7S7SYZCmcI36T6a4NAdfcfhRhc83JKUsJ0ZXc
	 Vy8dgYtIbk+3A==
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
Subject: [PATCH v10 12/16] perf tests: Fix the Intel PT virtual LBR check
Date: Sat, 21 Nov 2026 00:20:48 -0300
Message-ID: <20261121032052.1392234-13-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261121032052.1392234-1-acme@kernel.org>
References: <20261121032052.1392234-1-acme@kernel.org>
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

On an Intel host the virtual LBR check failed with:

  Warning: Processed 29 samples and lost 100.00%

The record leaves the buffer sizes to the tool defaults: the data ring
follows perf_event_mlock_kb, and the runner's small value left a single
page, too small for the AUX samples.  Pin 4 data and 64 AUX pages, so
the test does not depend on the host sysctl, and give the AUX ring room
instead of the single page the tool sizes to the 4 KiB snapshot.  Both
fit in the default mlock allowance regardless of the CPU count.

Also require the Python perf module to export session: a perf module
without it, like the distro's python3-perf, made the check fail instead
of skipping.

Fixes: 915d6b14dc0c8971 ("perf test: Migrate Intel PT virtual LBR test to Python API")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/test_intel_pt.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index c0ecece0a8255124..96f5c132cebf23e6 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -384,13 +384,15 @@ test_virtual_lbr()
 	# shellcheck source=lib/setup_python.sh
 	. "${shelldir}"/lib/setup_python.sh
 
-	if ! "$PYTHON" -c 'import perf' > /dev/null 2>&1; then
-		echo "SKIP: Python perf module not found"
+	if ! "$PYTHON" -c 'import perf; perf.session' > /dev/null 2>&1; then
+		echo "SKIP: Python perf module with session support not found"
 		return 2
 	fi
 
-	# Check if virtual lbr is working
-	perf_record_no_bpf -o "${tmpfile}" --aux-sample \
+	# The default data ring follows perf_event_mlock_kb and can be too
+	# small for the AUX samples; pin 4 data and 64 AUX pages, which fit
+	# in the default allowance.
+	perf_record_no_bpf -m 4,64 -o "${tmpfile}" --aux-sample \
 		-e '{intel_pt//,cycles}:u' perf test -w brstack || return 1
 	perf inject --itrace=L -i "${tmpfile}" -o "${perfdatafile}" || return 1
 	output=$("$PYTHON" "${shelldir}/lib/perf_brstack_max.py" -i "${perfdatafile}") || return 1
-- 
2.56.0

