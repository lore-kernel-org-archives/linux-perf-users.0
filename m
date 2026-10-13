Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D245349CC
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 18:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916004; cv=none; b=rQEH4W/7Ql5SwTrZ7+RWo3pZN04fKbSdDS/kU78fSnQbueMF1PEQZnh0jAcxeRe82U7SjQkojvm5VpvjJCY9LJep6PF2K9p4D5fBxnyOcqvbCR0+VRGm3lnxgSk5kZHeSbomHRFDgmVDziQfa/iY+l+ayxb00OW++ICZAAQ/drU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916004; c=relaxed/simple;
	bh=CMzWLsSvUBuoBzjwvp7EGGHEbhbirK0Kv2OvNgP3qM8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j9VPslwxTdy6RiE4z3MVg5KkI4sAlD/qTuKkBDRWf7PX49KXyAcbYheVQBOqaPe3EHR8cHhhFuJnqJ2ZWwZ3Rw8u+F6kTkw/WPFuC9/TISpgPKZKYgopmgM1FCVhxdKrGRim4cgwHBFsWLSZiDXtzfCgyCLfN5OOlpwVs/K0wV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QSUyoY/v; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QSUyoY/v"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-357e2bc3b1bso5565490eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 11:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791916001; x=1792520801; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F3HbwDarhrHxgEfaQxuccmNcSi/54Dhir4/ZTP/Ma6I=;
        b=QSUyoY/vERqQ3h22Px4JBAhfwltkU7JXI9mr/fDNOPGkifRizYRJAecKl0k6Sr7zW0
         FHtTgwjr0TSj93ZRH+eS6IH1dGPryEEQOdcle2vOWVSAYMCEpgU3SBivPux4hdzaxCRW
         Yn5iI41jxro25k85He+Jtk3tAk6LKE6l3DozY40/D9w00iMBr985rFity5ZcZ8cJAjZ8
         mj93RAoX4Sqb3lvUnDjuBNndUwI+j50Ev+tQ+KJ1ep6QJZE8+lI+/bV4VB6KRnb3rjIZ
         tBDikMCt5nHSW2Ho0or93SSlTqrUmderOqizuYu6jGsCeOrxSCSrj3MNhIWY+gyhLphr
         gUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791916001; x=1792520801;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F3HbwDarhrHxgEfaQxuccmNcSi/54Dhir4/ZTP/Ma6I=;
        b=xzLBBk89PxFIQrAXqsPUdmziRA+E56F+72Lg8z/dAWeYt5DP2ggtT4Ht+WhIN+JFs7
         PBTFpL861ErI8cDa7D/RNbyVrx3PnVPSW6z9HzhQeg0O3h5UYaISrH4o7+pvldAO1YRN
         M4FqpreEtkMSOFSZSFoUSwNs7b1lr1HkEO5XKWzcCNy+so88WUVj+tLbGHyc8wkvpbpc
         It49MAURzEPctFSsh3SUfecP1dYa0L7kbvprGg15qxKd9O/NX+Yvd4KpS4NWnmvfb0YC
         /hThcfZejm21B3oSbiT9fulTMJcJKccRkfIVRphAUuo7FQ5rovv1A+vcy/fqNIOEfwn8
         u2EA==
X-Forwarded-Encrypted: i=1; AKwUvBxKRD7+LeDpqGDqP2vGwXRd+GJbLCfPofEnF3NyDj1eplKwhY9eIsMHzXaGqu2X3YjQzDq/Jj5/9csg73LZzhX3@vger.kernel.org
X-Gm-Message-State: AFq9FYJWSL7AYAx2l345DwfzXhOkq5UXP3PeeXJi9oQRNSkGw/DwH59T
	DIJBhdkTvzwHNYABx3hgGo1ENI5uIACNDagGDH2Yga80RVpEQoJK50DAdGmMyrK9wZZN4Yi25JO
	mrWSgVViM7w==
X-Received: from dyng35.prod.google.com ([2002:a05:7300:7f23:b0:352:3ca9:9a5b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:810f:b0:356:a044:b194
 with SMTP id 5a478bee46e88-356a044b1e5mr16397097eec.39.1791916000286; Tue, 13
 Oct 2026 11:26:40 -0700 (PDT)
Date: Tue, 13 Oct 2026 11:24:53 -0700
In-Reply-To: <20261013182458.1234616-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013182458.1234616-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013182458.1234616-6-irogers@google.com>
Subject: [PATCH v1 05/10] perf build: Enable additional Clang thread-safety flags
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Align tools/perf's Clang thread-safety flags with the kernel's
scripts/Makefile.context-analysis by adding -Wthread-safety-pointer,
-Wthread-safety-beta, and (when supported by the compiler)
-fexperimental-late-parse-attributes.

Assisted-by: Antigravity:gemini-3.1-pro

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 39442577418e..d536203ff42f 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -64,7 +64,10 @@ ifeq ($(CC_NO_CLANG), 0)
   endif
 
   # Enabled Wthread-safety analysis for clang builds.
-  CFLAGS += -Wthread-safety -DWARN_CONTEXT_ANALYSIS
+  CFLAGS += -DWARN_CONTEXT_ANALYSIS -Wthread-safety -Wthread-safety-pointer -Wthread-safety-beta
+  ifeq ($(shell $(CC) -Werror -fexperimental-late-parse-attributes -E -x c /dev/null >/dev/null 2>&1 && echo 1), 1)
+    CFLAGS += -fexperimental-late-parse-attributes
+  endif
 endif
 
 include $(srctree)/tools/scripts/Makefile.arch
-- 
2.56.0.385.gd3acb90ef8-goog

