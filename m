Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A808A26560A;
	Wed, 28 Jan 2026 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769609412; cv=none; b=h2E/ANzu77tavyuHrSOCPH6dzDVu2JO3vUZwyL+XKb73RyIyGcvuondUDhGAkNZQg0G/CNOjWctoIaqMFDxuVDbbdbi+CJ59bJrO89EODByTWP3hOU2GONfmC3+yLWmzlYq+/MkuO9OgzRxfcPyd/kOHmZzkO0Ql5tZ16OS3CRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769609412; c=relaxed/simple;
	bh=FwofjpaBIP939xlrMtaUiM5BSY7RsnvWLxex1YGY+5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f1P2nh8kPLCgxERthuuscU5/oElJEDBZ5ixLVSHNFNxt20ntb4sv5g+GbnERlcHoB/Waa+T2ujp75+j58urD3s3q2OBx+qEwYcAwhKG9TAu0lkTw0oFXyGv/+0pUK3xxMxRWuqbeeuKqHHp/NbvSt4rZliRTvfi2Zi2nnrdOZA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUmaSUtA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUmaSUtA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A677C2BC9E;
	Wed, 28 Jan 2026 14:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769609412;
	bh=FwofjpaBIP939xlrMtaUiM5BSY7RsnvWLxex1YGY+5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iUmaSUtAoRo8DZ83BAyA2fqm25sMgWPESKcbIbjv/pt4C6eiEosFAtB0l1563j/PP
	 /JoK7wKgdZQkwCiTZ4FateTQOQ/6OO2Am2pP+Otmhbjv0zNf/S72Lx39fxZkHKoQnz
	 pqXzDDf9yxSKXbOBgi+YCHVm3TXT+9w/TCGYCMB3LOJt7iXKTIV/G9vqrR4SlVfL4J
	 Ym/zzihVuZ0PSxVaOxaWevBu9FI+dSa0z70MPum7g05TTISvwecx5imjqcAOeMxG7k
	 X0yeQ/sPq8I75Xv70Cm8OacT1SEdLDH9Z7LOzKh8atuOR1fqfPzKYDSW30uB02OSaM
	 YvQuNgtE3xjXg==
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
Subject: [PATCH v6 06/11] tracing: wprobe: Use a new seq_print_ip_sym_offset() wrapper
Date: Wed, 28 Jan 2026 23:10:05 +0900
Message-ID: <176960940550.182525.13602015884277238925.stgit@devnote2>
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

Use a new seq_print_ip_sym_offset() wrapper function instead of
using TRACE_ITER(SYM_OFFSET) mask directly.

Link: https://lore.kernel.org/all/176226550596.59499.18020648957674458755.stgit@devnote2/

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_wprobe.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
index 98605b207f43..eae952a4f9e9 100644
--- a/kernel/trace/trace_wprobe.c
+++ b/kernel/trace/trace_wprobe.c
@@ -20,6 +20,7 @@
 #include <asm/ptrace.h>
 
 #include "trace_dynevent.h"
+#include "trace_output.h"
 #include "trace_probe.h"
 #include "trace_probe_kernel.h"
 #include "trace_probe_tmpl.h"
@@ -260,7 +261,7 @@ print_wprobe_event(struct trace_iterator *iter, int flags,
 
 	trace_seq_printf(s, "%s: (", trace_probe_name(tp));
 
-	if (!seq_print_ip_sym(s, field->ip, flags | TRACE_ITER_SYM_OFFSET))
+	if (!seq_print_ip_sym_offset(s, field->ip, flags))
 		goto out;
 
 	trace_seq_putc(s, ')');

