Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA55B1369B6
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719351685; cv=none; b=MW8A+h5Y9eq/c1npG/IGvwxIMxIYzeDvey8ThHCf1jSoG04Pbv9Mu4c4R+EETxFNQPVXId/cd1p3ujl2oUNtcsZ1xusO1D/u6l5feY9KOiM4wdIq9CrrZHRsR3xdUc0X4t6c9Br8AvGgr6x54Yx7V0HgOWUEhDPjaW/KTHtSeQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719351685; c=relaxed/simple;
	bh=AGF2g3tEA7zbe6kDn2NaGFb8pt75qgtrYCw6tl/k2BE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=TKTb7HIrRPkxqzDWSCdspgSccfZM/qNDEjIL0ubZrPN2dIJfHeuwfxybuDrGU4vDzmr6v0cZmN2PjH79baI9iTOlv7U0l0JcjSwO86EY6IVEnoSuFMlGtnl/JdZX2ymneduH8dJx+NVjwqm8qt6wIHs64cFeUwrc/EhluiW9Ghs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dv9GOw6b; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dv9GOw6b"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0268d49b6dso12173367276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 14:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719351683; x=1719956483; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VV5nTHz7JpmXL00HnuBhzQFlSeI21ZYNHe64ER+6Mts=;
        b=dv9GOw6brwgRK55b2Bpct+M/e95IbCTqwcH9chQ9CftE3eAK1aHKAq8A8i2K+YJtZw
         Q6kItKzQZrQAvZhsL9NTu21hpa9nwa3rtclg1BPhM9yDUZbHYCWkSaRJn95MxMOhcJbp
         7SWeyA5o+yuikdTCrNlmnUIDhsZWwxJNsrDP+zVPyYrdugZvy8FHMbJVPXsKByvwmNfm
         DD1IfASVeuAlikgBXuQJTCl+JK6RoT+GFYZN8YKXkLXLWxQFRGNfZh0e5Xm6AuK/A17Y
         IPWGD8JMI5nEQSBELZWqNnGepOyjbBGdgEIT8g50/mxRrAZFzQu0M/eI7RL03rrvGna+
         axvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719351683; x=1719956483;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VV5nTHz7JpmXL00HnuBhzQFlSeI21ZYNHe64ER+6Mts=;
        b=orxVJxpNjcxigU5jZXiWZ+cZyk4lFRTV9DiWdWzlFN4ko7J76p+KMJeUOCkMdgARoq
         5ALV7fa4F5vEo3kBiHuQEa5nDxThpLOKEMv8K6b+9ePppJv3nvfLETBjhI/RVMw8coK+
         9Es70wb39Tf/G72Jj3lbr60uvcGbXAQ02fx9KqoLLCH165u96oy5xbfyMuD22QrKJaZM
         ++nOiROg0lYMm+vSgUxBYNdNNsHNKBbhDp6dsqgp5HXKlRA7YIdo0hgxikf+hAaCXBui
         X5tSb5qak6TQi+P+WOkIr457dpXIo4M8NXDQPREgCagVqoGlW8QG/bITjKLa8nLtOGWm
         QDtA==
X-Forwarded-Encrypted: i=1; AJvYcCV3n5fSVNIOuTtke52kpi70PY3ma5YwFU8oaNjJM1WpQ6ybilUGc63S6TsdUJT3/qlb805yFtGQLNh8b5rIiirXvm+K4eGOl/VZRxhaUzDhxA==
X-Gm-Message-State: AOJu0YyKJjKVVoKhBOsx5o/0Y1Y7upbawa21ArsdgJ6KU+DJ3gfu0Nph
	DaD3BWWXAzf1B1Shc2WiWKdnnA8/G9vFdPqxbbY/3Dq477nUuRhoAerBUwGS+woDxChgA6cL9OE
	Lf6Au7g==
X-Google-Smtp-Source: AGHT+IEy8zCWgmfD2YMUxVYSQZooaRbMoZ2CL2WLYr8JNXB6DT7t3q7Wwd6PL2YwS3pqDvoYGj9f/G0IqvHi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a05:6902:1827:b0:e02:bd52:dd73 with SMTP
 id 3f1490d57ef6-e0303f48404mr29330276.7.1719351682873; Tue, 25 Jun 2024
 14:41:22 -0700 (PDT)
Date: Tue, 25 Jun 2024 14:41:10 -0700
In-Reply-To: <20240625214117.953777-1-irogers@google.com>
Message-Id: <20240625214117.953777-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625214117.953777-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v5 1/8] perf build: Add '*.a' to clean targets
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Nick Terrell <terrelln@fb.com>, Andrei Vagin <avagin@google.com>, Kees Cook <keescook@chromium.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Ze Gao <zegao2021@gmail.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fix some excessively long lines by deploying '\'.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 5c35c0d89306..acc41a6717db 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1201,12 +1201,19 @@ endif # CONFIG_PERF_BPF_SKEL
 bpf-skel-clean:
 	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS) $(SKEL_OUT)/vmlinux.h
 
-clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean arm64-sysreg-defs-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean
-	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-iostat $(LANG_BINDINGS)
-	$(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete -o -name '*.shellcheck_log' -delete
+clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean \
+		arm64-sysreg-defs-clean fixdep-clean python-clean bpf-skel-clean \
+		tests-coresight-targets-clean
+	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive \
+		$(OUTPUT)perf-iostat $(LANG_BINDINGS)
+	$(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '*.a' -delete -o \
+		-name '\.*.cmd' -delete -o -name '\.*.d' -delete -o -name '*.shellcheck_log' -delete
 	$(Q)$(RM) $(OUTPUT).config-detected
-	$(call QUIET_CLEAN, core-progs) $(RM) $(ALL_PROGRAMS) perf perf-read-vdso32 perf-read-vdsox32 $(OUTPUT)$(LIBJVMTI).so
-	$(call QUIET_CLEAN, core-gen)   $(RM)  *.spec *.pyc *.pyo */*.pyc */*.pyo $(OUTPUT)common-cmds.h TAGS tags cscope* $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* $(OUTPUT)util/*-flex* \
+	$(call QUIET_CLEAN, core-progs) $(RM) $(ALL_PROGRAMS) perf perf-read-vdso32 \
+		perf-read-vdsox32 $(OUTPUT)$(LIBJVMTI).so
+	$(call QUIET_CLEAN, core-gen)   $(RM)  *.spec *.pyc *.pyo */*.pyc */*.pyo \
+		$(OUTPUT)common-cmds.h TAGS tags cscope* $(OUTPUT)PERF-VERSION-FILE \
+		$(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* $(OUTPUT)util/*-flex* \
 		$(OUTPUT)util/intel-pt-decoder/inat-tables.c \
 		$(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c \
 		$(OUTPUT)pmu-events/pmu-events.c \
-- 
2.45.2.741.gdbec12cfda-goog

