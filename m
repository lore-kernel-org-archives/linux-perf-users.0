Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02FC376A00;
	Wed, 10 Jun 2026 19:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121162; cv=none; b=o6+QvWyVxvPBrbVQbB1sZEoDgWH4ATgf/rHk7rx2ts3fW0xeDu0WTcH5Gyn0kkwk1akLxDRG02SbRDzpYxvS0dAmg7qKoN1TP2Mt9RIKtjLqTr8ErzPkJoMP2po8AejwM4nr/q5oNwiTRuijyGc5yi92XKA+37xx4TcwexE3qMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121162; c=relaxed/simple;
	bh=Mwpfp4s7/oTgf4KgcwfIoaeKKHPtt+ET53lrSByUQBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SD5Ugc9qFM/BRRF5QOwOnzWd9xa1VeJBb7I5QXoYXljqRYCxrTwsQ1VWHuOiNLjSyeRNr7+OVsU5AtwXjk6n+pLJ2jUeYq9fWA4ZZazJsPlcZcpUFU0GaHFQHcvXFpiciCcAAheJLVCxa23Gmki4wqaC+eWB6DLiJgCpeO1VssQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bdg9I7n1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bdg9I7n1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A271F00898;
	Wed, 10 Jun 2026 19:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121160;
	bh=MQlzc3tKjCiktDvlA46vQAC5Eprpnd3K2zunNpngdC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bdg9I7n1eSiMcwR/eXLfV++vqMdK4NmhkPPltIBjnNVGdAn1PDt7InkcLl2m6qqbL
	 DioSCJzxid6x/xR1u053qTIALmmA0lyZUaSirCcuDd3zrIi29entF+1zoGsADc6XsT
	 yY1hZiY/aDFJsUv7xR3lw3wLvnjzb28HaJ3g+l4nNySxwsNxZDXtmXQDzN5ymXQP1y
	 gAGT2d7dK1jyAvIa2ie7b+/hHYkGW2DrwFOu+nsCeLdrescVPbQYf6YJ708dkOvuRR
	 K55+UYWevIXHku8qiI1sn9S4LiYjxXHio7s2kWDv7qUC/adl+SZocRplypQQco4BtX
	 f7mjpFLEILxXw==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	Andi Kleen <ak@linux.intel.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 07/23] perf intel-pt: Fix snprintf size tracking bug in insn decoder
Date: Wed, 10 Jun 2026 16:51:40 -0300
Message-ID: <20260610195157.2091137-8-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610195157.2091137-1-acme@kernel.org>
References: <20260610195157.2091137-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

dump_insn() tracks remaining buffer space with a 'left' variable,
but the loop subtracts the cumulative offset 'n' each iteration
instead of just the per-iteration delta:

    n += snprintf(x->out + n, left, "%02x ", inbuf[i]);
    left -= n;  /* BUG: n is cumulative, not the delta */

After two iterations left goes massively negative, wrapping to a
huge value when passed as size_t to snprintf(), disabling all bounds
checking for the rest of the loop.

Switch to scnprintf() accumulation using sizeof(x->out) - n as the
remaining space, which is always correct and eliminates the separate
'left' variable entirely.

Fixes: 48d02a1d5c137d36 ("perf script: Add 'brstackinsn' for branch stacks")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../util/intel-pt-decoder/intel-pt-insn-decoder.c     | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
index 72c7a4e15d617b60..f90fcbc4302df58f 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
@@ -220,7 +220,6 @@ const char *dump_insn(struct perf_insn *x, uint64_t ip __maybe_unused,
 {
 	struct insn insn;
 	int n, i, ret;
-	int left;
 
 	ret = insn_decode(&insn, inbuf, inlen,
 			  x->is64bit ? INSN_MODE_64 : INSN_MODE_32);
@@ -229,13 +228,9 @@ const char *dump_insn(struct perf_insn *x, uint64_t ip __maybe_unused,
 		return "<bad>";
 	if (lenp)
 		*lenp = insn.length;
-	left = sizeof(x->out);
-	n = snprintf(x->out, left, "insn: ");
-	left -= n;
-	for (i = 0; i < insn.length; i++) {
-		n += snprintf(x->out + n, left, "%02x ", inbuf[i]);
-		left -= n;
-	}
+	n = scnprintf(x->out, sizeof(x->out), "insn: ");
+	for (i = 0; i < insn.length; i++)
+		n += scnprintf(x->out + n, sizeof(x->out) - n, "%02x ", inbuf[i]);
 	return x->out;
 }
 
-- 
2.54.0

