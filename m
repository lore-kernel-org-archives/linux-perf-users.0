Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27B421771A
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 17:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567806; cv=none; b=SY+OT2iHHNUF4HU3B99BPhSBS2FrRVj/C/6CNfGRtHFolHn2lNNFUakTfVyHWko5YwAyZq4bMlqi7srlGY3cu/tV9OvzEK+W9ScpRX6iErW4lb8eP16hHeiJnhPRWar6KL3ALSAKaRB+I3DBfDnacUNiJbyAgg24208URBj1Iqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567806; c=relaxed/simple;
	bh=/6e4emTQAma3I/ECUbvp8eDgQ0XP3VoFcLmrxffX71Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=mm98vHNvoQ1HcdYEVl8a+atbWf5VSsHodvR/e1EtzGbmglc3oNJyRHx5NfiBhxZdEPYk8nQE3ZBErCNPiIOzwHTkSuFV/uhAESn4f2iI1CRA1qS+hJpmprLKAZ10RvnrmeziQyiZ7nBJnkTQ0iXhkDSFQCDXWhIwgDteI8YWX5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uk+uC17T; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uk+uC17T"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e549e7072fbso14994413276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 09:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737567804; x=1738172604; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VogZlDmYyWqz8VLnX5mLueZuF1SFjnllQQUCqGSdoSM=;
        b=Uk+uC17TjtTR+PMrqoPJdhl0MXaeuSvIS/phiQFw8IoktxBfrAqga7Y4PBljZ3fPIo
         mv/rouFKQtSPCr4EzvuaYK08ZwA5+eWkSP8CbgUxXCuOblGKu+raL7p0zOtRZOqQfYVN
         v6u6iqWnXUAtN2OjpP+Rp1hdPN3qZAh65wLDSBavmJDsG1dAAHbWRrC5U9I+fXQSkqCZ
         AHej6dJqE/Opn3zx4JtjYEpnQWJMYivYya21uPDBWUsz1gk7QBstPfqnQRKoUZMRrc0K
         Mt7e3w24P4tE9DXRBYSKbwkpA1/Gd2kwjeFltxcOC0+uSBFSeDFSKz2uT5O5r9JMSVu4
         QyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737567804; x=1738172604;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VogZlDmYyWqz8VLnX5mLueZuF1SFjnllQQUCqGSdoSM=;
        b=Wc87ET1sBYOAQfBMH+Q+BjsSlMHAfF4XMHAKgvBNH6xTiVE99cL7a/dpcpreEDWEV8
         +VmQmp6KxbBR+gf4t0cMyah0MZp3cZDd5B3TVQ2hpmiW9BvIcpWSpkMNR3Xbrd7XmZ9V
         KqLQGgPEIsx0gRUKB6/S/fnjGX9tO6q7LjCYFos2w6/MgqHgFlzZwnpvnKREbAHZdmbI
         IFIiay6+c3UQDxG2p88d7v5tZHVcmWgFMzICfi7S8N1QnU99Tq0nGeeZbtpBFtZfvAOB
         7i2KJDSah10u3hK753s+l81VV3B8ytzpyp+2sZU35TYJhNayR5CiESBHwCSpR1E+BUuQ
         NPkA==
X-Forwarded-Encrypted: i=1; AJvYcCXSnHAjjxENrDM8HSRuhnhQoiJWUWXiPwXjWtc7bo67zRettA8xcrKDyswqiPsNp3ZnHaGk6Dm2tbCQ0js4oTl8@vger.kernel.org
X-Gm-Message-State: AOJu0YyB+OsaZSihT5lC9CemR5391Wji6RQwphqa6zk216HnCgTJtjYS
	rPDdacNh1qB/0l6C4LSgabzvAi/uekP8FaqFNkTOrppOaha1r0AVyr539Ycrk4UhxcXLPxROhUd
	2vfX9TA==
X-Google-Smtp-Source: AGHT+IHkuY00040+mvLKGu21zh7GGvsLOIJdp3hWaxKfD0++kd9sPhyMqVnTMrrTJitRqM1oG5JXLSFmPL3k
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:807b:be79:d5c3:ee5c])
 (user=irogers job=sendgmr) by 2002:a25:a469:0:b0:e57:41ff:5165 with SMTP id
 3f1490d57ef6-e57b103232fmr44707276.2.1737567803903; Wed, 22 Jan 2025 09:43:23
 -0800 (PST)
Date: Wed, 22 Jan 2025 09:42:55 -0800
In-Reply-To: <20250122174308.350350-1-irogers@google.com>
Message-Id: <20250122174308.350350-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122174308.350350-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Subject: [PATCH v3 05/18] perf capstone: Remove open_capstone_handle
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

open_capstone_handle is similar to capstone_init and used only by
symbol__disassemble_capstone. symbol__disassemble_capstone_powerpc
already uses capstone_init, transition symbol__disassemble_capstone
and eliminate open_capstone_handle.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/capstone.c | 34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index c0a6d94ebc18..c9845e4d8781 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -137,33 +137,6 @@ ssize_t capstone__fprintf_insn_asm(struct machine *machine __maybe_unused,
 #endif
 }
 
-#ifdef HAVE_LIBCAPSTONE_SUPPORT
-static int open_capstone_handle(struct annotate_args *args, bool is_64bit, csh *handle)
-{
-	struct annotation_options *opt = args->options;
-	cs_mode mode = is_64bit ? CS_MODE_64 : CS_MODE_32;
-
-	/* TODO: support more architectures */
-	if (!arch__is(args->arch, "x86"))
-		return -1;
-
-	if (cs_open(CS_ARCH_X86, mode, handle) != CS_ERR_OK)
-		return -1;
-
-	if (!opt->disassembler_style ||
-	    !strcmp(opt->disassembler_style, "att"))
-		cs_option(*handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
-
-	/*
-	 * Resolving address operands to symbols is implemented
-	 * on x86 by investigating instruction details.
-	 */
-	cs_option(*handle, CS_OPT_DETAIL, CS_OPT_ON);
-
-	return 0;
-}
-#endif
-
 #ifdef HAVE_LIBCAPSTONE_SUPPORT
 static void print_capstone_detail(cs_insn *insn, char *buf, size_t len,
 				  struct annotate_args *args, u64 addr)
@@ -309,6 +282,7 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 	cs_insn *insn = NULL;
 	char disasm_buf[512];
 	struct disasm_line *dl;
+	bool disassembler_style = false;
 
 	if (args->options->objdump_path)
 		return -1;
@@ -333,7 +307,11 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 
 	annotation_line__add(&dl->al, &notes->src->source);
 
-	if (open_capstone_handle(args, is_64bit, &handle) < 0)
+	if (!args->options->disassembler_style ||
+	    !strcmp(args->options->disassembler_style, "att"))
+		disassembler_style = true;
+
+	if (capstone_init(maps__machine(args->ms.maps), &handle, is_64bit, disassembler_style) < 0)
 		goto err;
 
 	needs_cs_close = true;
-- 
2.48.1.262.g85cc9f2d1e-goog

