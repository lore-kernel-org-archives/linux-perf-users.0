Received: from cvsmtppost11.nm.naver.com (cvsmtppost11.nm.naver.com [114.111.35.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE28488D83
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044536; cv=none; b=fSY1xVC7imAv2zNznQ6JAn4UmbNetuto7XYkUcNyRhJqkBXRwkL5z9K6DHkFK6FqISHj2Ay5zz0p3lZx4vZjVAmFoNR4xzWPor0a2bkGoxjwX/fsT5ovulP8FPS+JludTkE0iQ9Z33rFIXaA10ZV1SRcLFEU/iOM6oTeyrYdSyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044536; c=relaxed/simple;
	bh=ll8IJRv9xC+9BKu3dEi/5XmfutcNvkYSL2nndzITnTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gxl4xPz4uW6z68+33dli1m2D9UjGS86VlJJXPpYB+qMeDw511uAZ3mS3CudZ2nxEtzlJDqlK4VkxWOhsPKfPGUfrkGJvOS4cUJwkXD/TMmhGhQWXGPSk/mfmegvBDp86uQ4+5eDf1ksyR+M6PXjkKw8TWJGJVgVmpZ4MHRUFsJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=rwkhesaN; arc=none smtp.client-ip=114.111.35.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="rwkhesaN"
Received: from cvsendbo020.nm ([10.112.24.40])
  by cvsmtppost11.nm.naver.com with ESMTP id 3ginMbKDQrmt0IsuHXy0BQ
  for <linux-perf-users@vger.kernel.org>;
  Thu, 10 Sep 2026 12:38:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1789043923; bh=ll8IJRv9xC+9BKu3dEi/5XmfutcNvkYSL2nndzITnTw=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=rwkhesaNWKTW2Q+zLikDi2u1Jdyo+pqqubFC4Oom1YH10j0CoOwDs/mkp+eCMypJl
	 FwRqshAnJWjvQ2I/ZPfnkJTtxyTq24irit1e/jmKBEF3K2Pz3o+WjYiR2M2mHvsX0D
	 0s2r9l72IfcTpVNdpXLZFg9p6jHPY7oN7LFIetkzO8YrvSP4SS8suFjvY60p1/9Eln
	 J9E4eMoUuoF/+knVDN9vwOf1hq6b4l4t4NseLKJNz70XAG9nzfjk0xTVNMGqBo8zSa
	 i7RnG6YBFOJ5WGLOaszQKvnNsI5Ct/PpduWHLLit2+Ai1ZMjyRpMWbO9o36TuUy1N5
	 m14uIxdyDobog==
X-Session-ID: MPm6t9lWTa2CC5tRcfY2pw
X-Works-Send-Opt: TXRTb4kwjHwYKBwRMBiNFBmwFAudKoUwKAKXjJkaBd9YKBmm
X-Works-Smtp-Source: PwnwKAv/FqJZ+HmZKoEw+6E=
Received: from localhost.localdomain ([175.193.32.226])
  by cvnsmtp010.nm.naver.com with ESMTP id MPm6t9lWTa2CC5tRcfY2pw
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_CHACHA20_POLY1305_SHA256);
  Thu, 10 Sep 2026 12:38:42 -0000
From: Qerogram <qerogram@naver.com>
To: acme@kernel.org,
	namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	irogers@google.com,
	Qerogram <qerogram@naver.com>
Subject: [PATCH perf-tools-next] perf list: Avoid repeated strlen when escaping JSON strings
Date: Thu, 10 Sep 2026 21:38:39 +0900
Message-ID: <20260910123839.72285-1-qerogram@naver.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The %S conversion in fix_escape_fprintf() calls strlen(s) in the loop
condition while escaping each character. GCC 14.2.0 retains this call
inside the loop in a normal DEBUG=0 (-O3) perf build, repeatedly scanning
the whole string.

Test the current character for NUL instead. This processes the same bytes
without rescanning the string. Escaping and buffer growth are unchanged.

Full-command wall-clock measurements on an Apple M5 Pro host running an
aarch64 Linux container with GCC 14.2.0 and glibc 2.41 gave these medians:

  perf list --json metrics       Before (ms)  After (ms)
  Default catalog                    0.5969      0.5855
  PERF_CPUID=0x00000000410fd830        0.7818      0.7033

Each workload used 50 randomized before/after pairs. Each sample averages
the time per invocation across five fresh processes, with stdout sent to
/dev/null and no single-CPU pinning. PERF_CPUID selects the shipped V3
catalog on the same host; these are not measurements on V3 hardware. The
measurements include process startup and do not establish a gain on other
machines or perf commands.

These observations come from one short run. Relinking also changes code
layout: .text grows from 2,013,172 to 2,017,236 bytes in this build. The
timings do not isolate scan removal from the changed layout.

The existing list shell test passes for both binaries. Source-extracted
functions linked to perf's strbuf implementation pass 906 equivalence
cases with ASan and UBSan. Full-command outputs are byte-identical.

Codex assisted with identifying the redundant scan, preparing the change,
and running the comparisons.

Assisted-by: LLM
Signed-off-by: Qerogram <qerogram@naver.com>
---
 tools/perf/builtin-list.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 50f69c2c0d51..4118424cb364 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -325,7 +325,7 @@ static void fix_escape_fprintf(FILE *fp, struct strbuf *buf, const char *fmt, ..
 			case 'S': {
 				const char *s = va_arg(args, const char*);
 
-				for (size_t s_pos = 0; s_pos < strlen(s); s_pos++) {
+				for (size_t s_pos = 0; s[s_pos] != '\0'; s_pos++) {
 					switch (s[s_pos]) {
 					case '\n':
 						strbuf_addstr(buf, "\\n");
-- 
2.55.0

