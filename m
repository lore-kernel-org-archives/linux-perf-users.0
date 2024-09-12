Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8672C1B78E3;
	Thu, 12 Sep 2024 22:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726180930; cv=none; b=XKwHo/f8RTTVOSoMcqWh+pB4ht0Q/YH8x8CUx7PMV6wnR3eaZDW4jYbMhSPw0904dGctERKy9+42HhDQ55775P8HYbKCm3vb2juH9KHFPfzJvnyg64pP4UFwRIePeJdwhaPktRQQomTNHs8xpfZlDPbJflQwJ8veDKGsdB0lM7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726180930; c=relaxed/simple;
	bh=X+6Xu4NNqWDxPKJ6AcwJ2eFnPCO1uaHbjM5L6myz/ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eTmiRyE5VO1NeECGiEhKotgRuAAyS6rsb6ntyrisEEg7E/aY1PmygeH+egMP3bI6oQ2nalK7Ie9orvBtkn0ssNgUVs7vjfkARm2Ucy23MB+nFIkXs7w+lgCWvTdhz4QjToUwCTu/4F+JXDYgWOZTvRNQpDu54jSWwAfg7CSFdus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAEsd//y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAEsd//y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E97C4CEC3;
	Thu, 12 Sep 2024 22:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726180929;
	bh=X+6Xu4NNqWDxPKJ6AcwJ2eFnPCO1uaHbjM5L6myz/ss=;
	h=From:To:Cc:Subject:Date:From;
	b=FAEsd//y/9lSbOUKcpZuoRbgsq0uJzRO/NV9ODD6tHsATJH4xLDhn8q0herB3BZuR
	 soWJh1eVSD9ZAinXz6KTT0eRBxDdzEXQTN8N5GePDfjNyLo37iI8maJuUfycKBMv8k
	 88RW54FhroqmjRYVwi1H/7N5YGJOmAGecVsKCEp/DasFngkc1uLpGpN4GaPl+IaI0/
	 GXQ+yXWkRG1LelbzmNK+9nTCMpUhdolFx2nUW6rGtgR0Z54WLc5ya5VafKZNxOsNCc
	 cTjSayFi6mFsCriX4l5rgGpyIqL0yqOceNny/EcE9YdRA2iBiYAhCMGEpoB/Mzt/35
	 WDc2mGiJRTEVg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf symbol: Do not fixup end address of labels
Date: Thu, 12 Sep 2024 15:42:08 -0700
Message-ID: <20240912224208.3360116-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When it loads symbols from an ELF file, it loads label symbols which is
0 size.  Sometimes it has the same address with other symbols and might
shadow the original symbols because it fixes up the size of the symbol.

For example, in my system __do_softirq is shadowed and only accepts the
__softirqentry_text_start instead.  But it should accept __do_softirq.

  $ readelf -sW vmlinux | grep -e __do_softirq -e __softirqentry_text_start
  105089: ffffffff82000000   814 FUNC    GLOBAL DEFAULT    1 __do_softirq
  111954: ffffffff82000000     0 NOTYPE  GLOBAL DEFAULT    1 __softirqentry_text_start

  $ perf annotate --stdio __do_softirq
  Error:
  The perf.data data has no samples!

  $ perf annotate --stdio __softirqentry_text_start | head
   Percent |	Source code & Disassembly of vmlinux for cycles (26 samples, percent: local period)
  ---------------------------------------------------------------------------------------------------
           : 0                0xffffffff82000000 <__softirqentry_text_start>:
      0.00 :   ffffffff82000000:        nopl    (%rax,%rax)
     30.77 :   ffffffff82000005:        pushq   %rbp
      3.85 :   ffffffff82000006:        movq    %rsp, %rbp
      0.00 :   ffffffff82000009:        pushq   %r15
      3.85 :   ffffffff8200000b:        pushq   %r14
      3.85 :   ffffffff8200000d:        pushq   %r13
      0.00 :   ffffffff8200000f:        pushq   %r12

We can ignore NOTYPE symbols in the symbols__fixup_end() so that it can
pick the __do_softirq() in choose_best_symbol().  This should be fine
since most symbols have either STT_FUNC or STT_OBJECT.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index ea0da3f46f10b756..a445035f7dd7ed88 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -262,7 +262,7 @@ void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms)
 		 * like in:
 		 *   ffffffffc1937000 T hdmi_driver_init  [snd_hda_codec_hdmi]
 		 */
-		if (prev->end == prev->start) {
+		if (prev->end == prev->start && prev->type != STT_NOTYPE) {
 			const char *prev_mod;
 			const char *curr_mod;
 
-- 
2.46.0.662.g92d0881bb0-goog

