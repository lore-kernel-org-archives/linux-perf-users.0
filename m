Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFF437FF67;
	Wed, 15 Jul 2026 01:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784079904; cv=none; b=OFVzIGEw8SH7jTzNKxlFmGUaK8KVIk31Qlnyra8oXCvg9C6rMt/WAREKjY/0s97c2X1ce+7HWGAE0Q/isZP1Wr+0lgSLUs1IXN3IWiRE3F2dx8m06RlsICjyjdLKN0wSe61B7ip+2ynJ+zXSxB2X/G51nAq5PdSu6Izcy6wSByU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784079904; c=relaxed/simple;
	bh=gE5E61SHGyfS34EqmtoCN5wjt/tCHOvKVE5y6Wg2Hp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X3990OhpFq8BNnPlf7BMxRvf2h89TO1jjQbgjyxDSRnHApWihLqEB8VkpuvP+O7GR1DEn/ECT4dT2kcSyNTheg+MN0Q95ZCcKsRNjaGtfu8ysYCbh05UJ/HcFk7LpPay4e7KKXf7dd/nfTifuDlz3U4R5xKUsCctF3ytRMNL1OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jh2tX1Nt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jh2tX1Nt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9081F000E9;
	Wed, 15 Jul 2026 01:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784079903;
	bh=rKR3a2cqrM6Ydesu7cGmeplW+brpFmLVctCH3lJIWws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jh2tX1Nt2GdpvDaJThIV9PmLuPTzpdCBpVI7WjH0Qi5AkKxqizv5FJkQ8QMFd6Wd2
	 swLyxyhB0EY43+L9NZmVlv60+Wq2Dk4MpO6f4Z9mPHBjeMKZzK9Lqfk9UrsvyN6xCu
	 LtZTF2i1vtA7DouHdp1JLpCJ9hY74MLwdjF4V5UZkYxDQkN/mkVTn9OeH0he4MERTa
	 k61qEcngSQZWiMhcpmCw8BeovSEMya9ReYsE4A0JVmXCI5JMKhaZRoBp23psDSK/Zy
	 jGnBKg9mIy2pdll3boGb41ceLMRGtqIYynmWXYffrHhXqNff0Mlx8DcA4Vbu2uCckh
	 SRDpVB/hfahPg==
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
Subject: [PATCH v7 05/10] tracing: wprobe: Use a new seq_print_ip_sym_offset() wrapper
Date: Wed, 15 Jul 2026 10:44:57 +0900
Message-ID: <178407989708.95826.17630423823637072384.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178407983818.95826.12714571928538799781.stgit@devnote2>
References: <178407983818.95826.12714571928538799781.stgit@devnote2>
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
 kernel/trace/trace_wprobe.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
index b52f3eac719f..dd310a87b333 100644
--- a/kernel/trace/trace_wprobe.c
+++ b/kernel/trace/trace_wprobe.c
@@ -20,6 +20,7 @@
 #include <asm/ptrace.h>
 
 #include "trace_dynevent.h"
+#include "trace_output.h"
 #include "trace_probe.h"
 #include "trace_probe_kernel.h"
 #include "trace_probe_tmpl.h"

