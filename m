Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545AE28A1C9;
	Thu, 24 Apr 2025 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745511877; cv=none; b=ES7+i2REIzDAaTss0InWtP24dBvw5VglstTRTeLoxVuUjsfNLsH2XUqn3EsJ8VqlT405T4TkoH3SZEG64NhI+lIkoK4Hov9Cnt2b1ljW4TqaNrRjmh7+h/0LTFuFPZ2nhqgQ0hQtI3o9jyEhMKrHh/5tDEknPh6C+JzLqasAnjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745511877; c=relaxed/simple;
	bh=8I8mlsaGdUmAwksLhHYQr3Ngvj1gO1XMU/nwDMeX05s=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=RTLZpc79ZFsjvZ27Donj1BPPl7op4ATkYbTWKGQXztCXOX/Ei3kM6NbmOfYsHOp4xmhR3Y5Nd8gOZtAFli0MQQjf1fTRvLYOdOkWXkkYjhGDZ4F3MpwhrE3hcwz+TXNJ7Cj146brkJBAEUzvZwmCbXaL0jdKWgsih1afpRGOhgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C79C4CEFA;
	Thu, 24 Apr 2025 16:24:37 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u7zPF-0000000Gya9-06zI;
	Thu, 24 Apr 2025 12:26:33 -0400
Message-ID: <20250424162632.877321284@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 24 Apr 2025 12:25:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org,
 Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org,
 Jordan Rome <jordalgo@meta.com>,
 Sam James <sam@gentoo.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Florian Weimer <fweimer@redhat.com>,
 Andy Lutomirski <luto@kernel.org>,
 Weinan Liu <wnliu@google.com>,
 Blake Jones <blakejones@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>
Subject: [PATCH v5 10/17] perf: Have get_perf_callchain() return NULL if crosstask and user
 are set
References: <20250424162529.686762589@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

get_perf_callchain() doesn't support cross-task unwinding for user space
stacks, have it return NULL if both the crosstask and user arguments are
set.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v4: https://lore.kernel.org/all/73229250c0279667f617c3d6da121c6621164e4d.1737511963.git.jpoimboe@kernel.org/

- The crosstask is still used for kernel stacks, so that use case is still
  need. (Andrii Nakryiko)

 kernel/events/callchain.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index b0f5bd228cd8..abf258913ab6 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -224,6 +224,10 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 	struct perf_callchain_entry_ctx ctx;
 	int rctx, start_entry_idx;
 
+	/* crosstask is not supported for user stacks */
+	if (crosstask && user)
+		return NULL;
+
 	entry = get_callchain_entry(&rctx);
 	if (!entry)
 		return NULL;
@@ -249,9 +253,6 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		}
 
 		if (regs) {
-			if (crosstask)
-				goto exit_put;
-
 			if (add_mark)
 				perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
 
@@ -261,7 +262,6 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		}
 	}
 
-exit_put:
 	put_callchain_entry(rctx);
 
 	return entry;
-- 
2.47.2


