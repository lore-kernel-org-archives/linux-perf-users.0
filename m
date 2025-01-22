Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648A8192B66
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 06:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737527071; cv=none; b=h8croRlCIeh9YtomVY9myt9ME86ZitzFzCIEWLcPl12iVdImJeoljU0j1NK8+hEM9BldShlXQEg5k6tjB++z9v6ZpBmkShn9wSvTrIZx4DnogLCBUA0gyM8mWJNbhsiFMb6btSgQ2/vF9n4gbMi0Q3R8jCzz3gPqdXlhXw08cmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737527071; c=relaxed/simple;
	bh=ksmTITiwDHRKN7AM1iSFOtcCcIcP7GGHu1o6+CqXZco=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ifR9UP4ZotKlGH0dLdsSJSYbRM/Q3m2j1KBWTB9EeRJrFXkR7p/MOlkYAE3FsaS5jN/fi1Ni6AdW/Xa46QYjVSYKqwWlXgVcXpPDOVkULotfy+W0zUdf+Af2J6+0j+mK7V0uxPZZw0hC1bP9LMKomRKe9xPrM4EAzp5G5PKahPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TyKVpYj7; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TyKVpYj7"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e39993d8594so16201662276.3
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jan 2025 22:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737527068; x=1738131868; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HtzTzHqLOrR4WcyKkQw1nPTI/K9PhaOnccVbKtmGOUc=;
        b=TyKVpYj70eRmTUWHD//d+KGPRiHo3IMzlkXgrMfmfr0HxaVQXKhrmOrg75yfZNgttk
         cAGWGss8N0WA0PhWdmGJTYUb1gvwi4oOZ8kzbfn6QU8BrQ/+DtSe7V6aTfwXEqAo3ZJR
         MhnOpbUdbuRKWJsKxZJ/5jij8M/AXY2iasXu85UzE1b1VEwde17l6z6ivTWNwD+KASDB
         G1UAaUfcFdiCjeCyAkxuqIGDTJVw68aQqJyFE6aKQyY30CKfFyj7TpfqWqb2u3eg++15
         XDTX/uIBKUKVNgeKoRTVczBsxgt7/bDsiw3o43nc/jxuIEvfC/w2Lfz6H7/v7+CEt2UN
         /dPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737527068; x=1738131868;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HtzTzHqLOrR4WcyKkQw1nPTI/K9PhaOnccVbKtmGOUc=;
        b=sxonjnAuewMf3TurlTdrX7ZBZFHlbyUpufxgzI4IRLkyImuemOkiHdYxu+H8iNq0AZ
         BtPkLXtVIaf6bVvGdxq5gMqIdRmOTPUvdy30irWu+hDqIzH7xV5e3YiUpx3TbSdtZyH0
         JCjH/gyByvijW7zAcC4ouDOXvgT1Q/NBzF+3qpFyaRn8s1P5vhwr2tDsL1MIKT9TH9XX
         ccqVeGMjU3E8Qxsc58bPYo5OjYE+u1y5BzDVCsY/zHyQagZmSjNErw89s32rHbw8Lvro
         Sa0SAYsaXQWXnpYjnvva7fj2u7u0ccB4uUTitBzsI86HYab3eRvioS+4OqziqHXDT5yW
         5Q8w==
X-Forwarded-Encrypted: i=1; AJvYcCWHg9MnNB2t5DAQJFDAYOhD/6BtQTwsQlMzyUGCP7goQ/QzFOd+B8wHRzgnnijQmzswshw468rQktEZzx1D1DDW@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5v1cJZphpnQHLL+MR1ZZbj+HDXkJo62QmLBFB8/E0Xw7til2Y
	hii1wBV98b36unZzBTB8Br9sXhSEGsaQL7azpb4ipGcJUXRHLNuwD4WCAkaLr9If7FLrNiLK3SO
	f6SRTqw==
X-Google-Smtp-Source: AGHT+IF4xW6MszewyE48AJoSmqv42vaUKpGWDsoNDMUd22FuA0iZtmjyorbaunxgqGCpQY+ff4Pe+DYCCOq9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:807b:be79:d5c3:ee5c])
 (user=irogers job=sendgmr) by 2002:a05:690c:6f8c:b0:6ef:4ba2:6bfc with SMTP
 id 00721157ae682-6f6eb95f9eemr535417b3.5.1737527068640; Tue, 21 Jan 2025
 22:24:28 -0800 (PST)
Date: Tue, 21 Jan 2025 22:23:20 -0800
In-Reply-To: <20250122062332.577009-1-irogers@google.com>
Message-Id: <20250122062332.577009-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122062332.577009-1-irogers@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Subject: [PATCH v2 05/17] perf capstone: Remove open_capstone_handle
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
2.48.0.rc2.279.g1de40edade-goog

