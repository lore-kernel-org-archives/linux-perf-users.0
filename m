Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763CD3DF00B
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 16:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787068984; cv=none; b=ma3dJCvqe798VDghLkXUOOAasdxR6rhNCH5NrLwGMyt/0ZIuMcJx1mYFMPsE/1sojnM6xZxKz8gUE0djlnDqybEBirfGAQUuT3IsqVCh728XcUbI16Oq4Z2/r/voA+GrHVumhSpwjwSIfIFuhy21mJPmCttt/GrUI1gV02cO9nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787068984; c=relaxed/simple;
	bh=IiqbyJpEb/d3E5Ptgz/73jDNYT9aO6tMgcuIr3sKWK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ftQcv32TSelA19uJ5f4nlrmrpsGyG+hTh6/Auv1R53pqRfmcRULFpEXRqX/ij1yQZ3wGZEyTcSBWgMFujN7Ku3a41S7wuQwyIIhoUE0XPsvYyoKy82b5oJn0C388hO02G1hlEvFNi8re487EpjkFukYobU/Yy3tzs8i4+cyzyoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=QlCRbgYl; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="QlCRbgYl"
Received: from ms-a2 (M106072126074.v4.enabler.ne.jp [106.72.126.74])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67IEfpNS058426
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 18 Aug 2026 23:41:51 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=v8EtRdOPp83H8AVgqqXi85Tkhs5j1BfDrnmLc/etBes=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1787064111; v=1;
        b=QlCRbgYlpXRuVs/wxuNet9vsglTRjQkmVq8BLUwDZGzlY8x9LjIbqVko+KU6Dqh6
         s5R5xj6VBa0eDUcc1rqOfhujZ6yl4ikRS9k72TiGshaoZGw/7l8q/sbrnkny083v
         bESqOA7y4XmBm4PIc+K7LfZATH9H/+ElgUXJ8u9zXQ8NMi7t3tCAUCOWhgYmfzS0
         RTva0pTzfAqzIi2f+D42HB+K2evE8SJSIZi9ZXTX4ztK102WhezFRRAohBO1/49Z
         zxDfzRK0HA2vmzTGsWxf2SFRtmla5/d4s7NdTu6Q+94KmkF0DP25EUPOoAzg8NOp
         a8baXYeQ3kysp+LQvfwSaw==
From: Kohei Enju <kohei@enjuk.jp>
To: linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>, Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH v1 1/2] perf config: Fix annotate.hide_src_code documentation
Date: Tue, 18 Aug 2026 14:40:12 +0000
Message-ID: <20260818144149.101248-2-kohei@enjuk.jp>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818144149.101248-1-kohei@enjuk.jp>
References: <20260818144149.101248-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

annotate.hide_src_code defaults to true since commit e201757f7a0a ("perf
annotate: Fix source code annotate with objdump"), but the perf config
documentation still describes the default as false in a few places.

Update the documented default and the example.

Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 tools/perf/Documentation/perf-config.txt    | 6 +++---
 tools/perf/Documentation/perfconfig.example | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 9b223f892829..589bc7f36012 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -96,7 +96,7 @@ Given a $HOME/.perfconfig like this:
 
 	[annotate]
 		# Defaults
-		hide_src_code = false
+		hide_src_code = true
 		use_offset = true
 		jump_arrows = true
 		show_nr_jumps = false
@@ -126,7 +126,7 @@ Given a $HOME/.perfconfig like this:
 		skip-empty = true
 
 
-You can hide source code of annotate feature setting the config to false with
+You can hide source code of annotate feature setting the config to true with
 
 	% perf config annotate.hide_src_code=true
 
@@ -291,7 +291,7 @@ annotate.*::
 		│        mov    (%rdi),%rdx
 
 		But if this option is 'false', source code of the part
-		can be also printed as below. Default is 'false'.
+		can be also printed as below. Default is 'true'.
 
 		│      struct rb_node *rb_next(const struct rb_node *node)
 		│      {
diff --git a/tools/perf/Documentation/perfconfig.example b/tools/perf/Documentation/perfconfig.example
index 2b477c1d1efe..f9c202a25fa0 100644
--- a/tools/perf/Documentation/perfconfig.example
+++ b/tools/perf/Documentation/perfconfig.example
@@ -23,7 +23,7 @@
 [annotate]
 
 	# Defaults
-	hide_src_code = false
+	hide_src_code = true
 	use_offset = true
 	jump_arrows = true
 	show_nr_jumps = false
-- 
2.53.0

