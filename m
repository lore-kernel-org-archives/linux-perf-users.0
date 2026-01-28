Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8227A230BF6;
	Wed, 28 Jan 2026 14:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769609400; cv=none; b=IJhCKBB7mRJPNiBCvg20wXvuGVAcTiI3Ga25DY6QYG+RNvNd5x4VlK1XMXggJd72PJB3udTzR334H7aEbjNBHUqnAxJfA4vFzGlMNF6b2GMu3OJ24d6J9AM7L8n8CDpG6Ev6ADNc6sCxwhmHMP6E69xySZx3IeqjS/gyEY+WGj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769609400; c=relaxed/simple;
	bh=LillPVj+D01tzFsPNb4HRfbZ2n9V6Am4yy1/k9dGmvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i+RtJ5XQ0wFKKAk9pZuLamSZ8cRuQGRRLmWWLHzwxp8Kehoh45ZTsWu5OrutihD9IPErLKRJd1Vtev3uHTKOOriZq3MP8+49ex1Qvm3yfeXC2c/pgduZMCiMVXw8K/crk6wCPxwFNI5idne73qFZyz24UJjwSf+SR+pBI1tzQV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tml10nKW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tml10nKW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9716AC4CEF1;
	Wed, 28 Jan 2026 14:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769609400;
	bh=LillPVj+D01tzFsPNb4HRfbZ2n9V6Am4yy1/k9dGmvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tml10nKWeU387O4x0je4hPABZkRdkplgyN1Q3c91Wxvrcmt7nPNACwS3E52NCd902
	 knjrPfj6D2XlDCWPFXCM0LwsfTKiQX0xXJ1fZd/LjslhFFf2CeZ67IstbruwnIsDBW
	 4CFzvSy/3s9MuIeJW+VFqcJbMyvHIziirGYHDJzROFalqtPoJs7NT6HuFu3gLCVUyU
	 hIM0T0nOC7xE3WvEUSGHzC+491E+oH0ujknEesFD9jAQJx5UoCubPZVYtolaZQX2wg
	 SXdbMxBaq4PRFm3yqSs15OjKx7fBJ5Co9Hjy53VSLue2BoPeVDq64r5gJsBfFfIEZG
	 +8DDLrBzNFVEA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v6 05/11] tracing: wprobe: Fix to use IS_ERR_PCPU() for per-cpu pointer
Date: Wed, 28 Jan 2026 23:09:54 +0900
Message-ID: <176960939425.182525.15663394581634314970.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <176960933881.182525.11984731584313026309.stgit@devnote2>
References: <176960933881.182525.11984731584313026309.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since wprobe uses IS_ERR() for per-cpu pointer, it failed to build.

/tmp/next/build/kernel/trace/trace_wprobe.c: In function '__register_trace_wprobe':
/tmp/next/build/kernel/trace/trace_wprobe.c:176:20: error: cast to generic address space pointer from disjoint '__seg_gs' address space pointer [-Werror]
  176 |         if (IS_ERR((void * __force)tw->bp_event)) {
      |                    ^
/tmp/next/build/kernel/trace/trace_wprobe.c:177:35: error: cast to generic address space pointer from disjoint '__seg_gs' address space pointer [-Werror]
  177 |                 int ret = PTR_ERR((void * __force)tw->bp_event);
      |                                   ^

Use IS_ERR_PCPU() instead.

Link: https://lore.kernel.org/all/175979899246.1800846.1725245135731182727.stgit@devnote2/

Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/all/aN6fTmAjD7-SJsw2@sirena.org.uk/
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Menglong Dong <menglong8.dong@gmail.com>
---
 kernel/trace/trace_wprobe.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
index 4b00a8e917c1..98605b207f43 100644
--- a/kernel/trace/trace_wprobe.c
+++ b/kernel/trace/trace_wprobe.c
@@ -173,8 +173,8 @@ static int __register_trace_wprobe(struct trace_wprobe *tw)
 	attr.bp_type = tw->type;
 
 	tw->bp_event = register_wide_hw_breakpoint(&attr, wprobe_perf_handler, tw);
-	if (IS_ERR((void * __force)tw->bp_event)) {
-		int ret = PTR_ERR((void * __force)tw->bp_event);
+	if (IS_ERR_PCPU(tw->bp_event)) {
+		int ret = PTR_ERR_PCPU(tw->bp_event);
 
 		tw->bp_event = NULL;
 		return ret;

