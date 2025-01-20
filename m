Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934E117BB21
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jan 2025 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737394352; cv=none; b=Jm23lEY4JH/IJJ/Tqyrg7bXS8Lw9/+NQrwT+uhUho5KHt9tPMOb/CgnYSGAtybfn8Za3XCKQFq0Cisc7QrWT3aMn7TROMmIN+MMiLgYf7JJ1YEl2iwMovlP8gVYRN9mEYfh+xT5XbXEhlr9yqIIQVQ0Q6G8b2o28lSI9B/5oTiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737394352; c=relaxed/simple;
	bh=ksmTITiwDHRKN7AM1iSFOtcCcIcP7GGHu1o6+CqXZco=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ZBzeek22zPQ9fNcTqdj0iUQ57HBbKgOi5N41ZuaBpJkUmMwVdSNjHrpSjbacbyQeGsbUH7wZfn+XyLrDFkjmnX3IqEy0W9CfFRLjKhc34BsIXqDR7V11ECdFj9u5//K56WvyjaNGJE1zLNVDGnM4x8Pz0iojk0x8DQ1JEVHzCg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h0nwzxSo; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h0nwzxSo"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e549e7072fbso9755163276.2
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Jan 2025 09:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737394349; x=1737999149; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HtzTzHqLOrR4WcyKkQw1nPTI/K9PhaOnccVbKtmGOUc=;
        b=h0nwzxSofvEy80zJ8nbTIH+Ydma1Rn6Qei7o8m+vQKsg5roLgOVULLWhTePXwkQ6Fw
         74RZ0/68xIQs7N7vPMZFfew0/QbuDuL7LqrM/Htmg377HQ+6YyCTpgBwAjh0gj9oV+No
         OmEhv5YM0X6177UDJvy9uoixnkLNKbHsRKW/Ys95Eitq5d1MuFOxLVltfp9tnhnfm6fQ
         AioXga+AkeHrVXQkdMzVEuCXG/yp2Ou+ohTDtR1YSA18ICSQJP3VDkX/HDkcScp8Ztwc
         3bWELWXBG6/nKfWG4HYnyzkgJ7IKcrGLJ+go9TMUzWhd+msLs2A93V3nkBXQyYhbtxMB
         YWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737394349; x=1737999149;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HtzTzHqLOrR4WcyKkQw1nPTI/K9PhaOnccVbKtmGOUc=;
        b=DaixFNAjEzFZDY0/aXiP9/y/1wadeWdEK2MziapP0Gg4VAmljq3ST8aZ6pKV1YlA8p
         1TzabxDKOS55pphUq8kY84lds1s8M7fL7D5lAQLUd47Huy82l+CTWrzqQN55Te1ElYC8
         90W9zwMhsRvo1jlUAb1VlPMTvEcxCp06cFLcdys4Tu00dA4G5/BByIy9ntG30uMxH56P
         vVW4Ok9x8LSgi+xmltwMb9/EWs65OLEzo5h+0zkOVw8rN/GWakz6FNTiRtfpaEl12e3H
         w4wyLFFZ/i+wOUs2kxQ1ZLEYmwcODE74bSkEcjYoLyqn2/zPFYtxZfdmqha3q/DKXTAn
         zD/g==
X-Forwarded-Encrypted: i=1; AJvYcCWTZgT0a0fDRZGu3W+exaGqoKaDNHCkFiyoqG7/QWCirc/YR3LsWyipwC2ScOL4PbCsF3nr9ZpeBv02/+6WPhbh@vger.kernel.org
X-Gm-Message-State: AOJu0YzzdWXym5UJp0nsJjPBQ/RQM6dOK/RImErTNEOeSln49SjtFcuJ
	DIXCy7aw8U+rgdiNPYMQuAEreeMl/SOISLf3uMnLTL6YGimHfDRCdPrD15Fl/jHs5zPe6oC9GuH
	suawSxg==
X-Google-Smtp-Source: AGHT+IHIzB+rzKdJa/y5Df3JyN6/QJXl88D/lTU1G5FjQMVdybu4eav6ixEQn5oya5VjsDod/0fpWDvIHW8v
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:fc95:312:c7ce:d18e])
 (user=irogers job=sendgmr) by 2002:a05:6902:309:b0:e46:4def:f62e with SMTP id
 3f1490d57ef6-e57b132e742mr29263276.6.1737394349425; Mon, 20 Jan 2025 09:32:29
 -0800 (PST)
Date: Mon, 20 Jan 2025 09:32:06 -0800
In-Reply-To: <20250120173208.344231-1-irogers@google.com>
Message-Id: <20250120173208.344231-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250120173208.344231-1-irogers@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Subject: [PATCH v1 3/5] perf capstone: Remove open_capstone_handle
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Changbin Du <changbin.du@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
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

