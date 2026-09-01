Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995B038D3FD;
	Tue,  1 Sep 2026 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272527; cv=none; b=AFoQddqfLGBBz8nOADc868voTx7A5WNNIjAFt911qMbDqlnLBEsmqBLHztai+4LTFdTSx8lNPCwMxlxW6zT11kLh3mL0W6+JdGkpE3hGqbBRSPtDJFycfFNEk6ZvViOjqEmGg8zcP+4mrp6BbuwD2rVU24UFLD5Ac6D7OAStjKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272527; c=relaxed/simple;
	bh=q01b6Fb/Va4nk0KzfKWawKLamrcD1BX3rDo4igKbjW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kaXhi12VJ7T5aEZXj4gSATUgdBkKpdM6VqYvJe5f3O8QoLS/M3wnG5zzLbDDzsyOmNN7xoV0C3aonEW+aiyxixgaOyT2WngwgHkbxQYSbEFzNfL+mSVqGJkL9MbbE0ZJF0ZMmIGW3YNCvgveRdhDo3N3siEYp1ruF/08Y7igBDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8HqGc58; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8HqGc58"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6ED1F000E9;
	Tue,  1 Sep 2026 14:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788272526;
	bh=a6GJxWD+W33oVckwTRW6cqEZmP+mD56tlrS5kVmgWvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T8HqGc58IBpPp9PRRE/wDLOpN2mQOdPjXIoEXw5KjZ6uvEF9C1hcSjxsxqJNcQLfq
	 wsamHOoA3IW1pjEjH5azaWXAU+VjN7iZJ23KQP/8BTZgnWhLjwVvGyJhCJqVSvMldl
	 YGDvRLdZ6TM+fHAsaOMffG5NskiclYk29+JGoiZ85//I5P/QWwwTLdkBaJA1I2fifL
	 2Et0jbmT6kfIsDFuBE7fYusP0CHr1Kxn+6P3k2Jr+MdOGP4XoTG3HWPUgEcO1ffnVg
	 JPAUpLeke9JpJ9niE57d8S19NLR/tG//6zThCYVr2noPsS9RfJx7E7SliK4vmuhveq
	 jpBwmISKydhKQ==
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
Subject: [PATCH v3 3/3] tracing/probes: Fix code indent in get_bitoffset_of_field()
Date: Tue,  1 Sep 2026 23:22:00 +0900
Message-ID: <178827252027.123716.7095571176291547259.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178827248631.123716.2627172171811720261.stgit@devnote2>
References: <178827248631.123716.2627172171811720261.stgit@devnote2>
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

Fix code block indentation introduced by commit f21834524025
("tracing/probes: Support field specifier option for typecast").

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 144e790077c6..908b4b6bc2df 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -662,11 +662,11 @@ static int get_bitoffset_of_field(char **pfieldname, const struct btf_type **pty
 			ctx->last_bitsize = 0;
 		}
 
-			type = btf_type_skip_modifiers(btf, field->type, NULL);
-			if (!type) {
-				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
-				return -EINVAL;
-			}
+		type = btf_type_skip_modifiers(btf, field->type, NULL);
+		if (!type) {
+			trace_probe_log_err(ctx->offset, BAD_BTF_TID);
+			return -EINVAL;
+		}
 
 		if (next)
 			ctx->offset += next - fieldname;

