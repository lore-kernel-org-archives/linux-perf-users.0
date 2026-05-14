Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75B13655EE
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776505; cv=none; b=pdklGvFrrimH0H2H4WRqqpPse/lRUDLLYcdFzxPpg0VIrlE0H/RBK0VLrkq3Uxx20cbIKJBXtBJnrXhdzNGKdWg9849DuX2enKzK4iRdNvxviioaluynF6aFOx1yzJ9rdPW9nu73FNgT98rVSlBTyX4NyrrtjVwpjXtVpw6g548=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776505; c=relaxed/simple;
	bh=oY8ot2ZW4/Uix4iWQvLYcy2TP5wWoGw+BgLtKo4g2Nw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l+xRWOkI8s3uOPDJH34InomV3x31wYcHcJsQ5tF5ivPFVSU9JM63PCOxCYelwSAFJcUKFhgWXu4d/xz/FYMnx8GUaVg1j7F7lFPNxVN2blEvAD/NWMRgGH44m6EQW/VAGbvMsThayfvz0+SJ325pvpElRDNVPOUMDnNl2MBNeCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wKjZKiQS; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wKjZKiQS"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12dc3d81736so7452534c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 09:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778776503; x=1779381303; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fcNB+RxRa1Sr7NhNICyZ5jAIefEmQ21qHYxrPQiAS0s=;
        b=wKjZKiQSAZYvfcjPli2eB9MolyGE70LZiwKJo0Zdkcxd0glK1AnzqLmAYcUtYdVECx
         ZXFj2rHIqRfX8ygT4h0xqevKmmPT+wMTofOw2KUq74OxNzxI+3SY+GJ33mo42OUe+v3j
         7JxFYLs8jLIc0mloOaxiTt4layYEkcrmnLFL4GMArRWP771CVVd/Imauksb3Nk0J+QXa
         9mOXhLt7qckl61/gQaas3OiIngo5yYkqU+8wFIJ9YMalV5EBxOWE5JKcLD5CCEDwicH3
         zZWgSNS05jUzWmbkEB/P5uVwb+MX1hrJtxtFfEmOVcvMhvpvXAUbjwDZ1kHchFb+iFWm
         SRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778776503; x=1779381303;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fcNB+RxRa1Sr7NhNICyZ5jAIefEmQ21qHYxrPQiAS0s=;
        b=ZPwjq5TrGhlfK+KmzaT+39oSewZ1vzX1nViyzNBL/oYjH+sGVktjt+uZo4b6n+lt9I
         mTXg4KbWa8qTNVrFQh4Jv8/rlSokyAoBA8DEXNDF//s4elJZO/fGwf2XYKP/EcIxmj8B
         RVnP7Tt5IPANPtAZdHcyff+9cXDwG5rxSAMFQO7sLdKOCL8PmsYkuCLLGztAOgEaH+qd
         yscCUI+ZckIMIGVRTptGM4EEDVm4oxBP0qqoen3etjitrKLYIpJypPJUFnczjl/QMqER
         eqGkNyQMi/NrICK7a+PU7Kx06jGnCInbBli8JaEOeVQtN0+HFzhS0qXrMLO9G8ebaDBA
         43lg==
X-Forwarded-Encrypted: i=1; AFNElJ9+qpLi5EwJEt1u59d8ZFX5LLGgXIYhVdRDRseLMCu3wocBl1LVYvFwHQ8CA5iLkiLE+vDqDTnRS+nsm3iCPorl@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+V/+uYSPbkO4nUo+Ms3YXHxrAV3icTWM6T/6uIefFgxIxf0mN
	r33JFi0/GueJQiwy744grEdQ+ITUDOIO6xG8qwyDJZz6VrYoo0bQ4ng9r65h/Rt+GosHaG5Vfei
	SfczTicElKQ==
X-Received: from dlbem1.prod.google.com ([2002:a05:7022:1001:b0:132:8d92:4d63])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:101:b0:133:3c47:92de
 with SMTP id a92af1059eb24-1349a80f03amr5239132c88.17.1778776502833; Thu, 14
 May 2026 09:35:02 -0700 (PDT)
Date: Thu, 14 May 2026 09:34:07 -0700
In-Reply-To: <20260514163409.927816-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512174638.120445-1-irogers@google.com> <20260514163409.927816-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514163409.927816-16-irogers@google.com>
Subject: [PATCH v3 15/17] perf build: Prefix SCRIPTS with output directory to
 fix continuous rebuilds
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, james.clark@linaro.org, 
	namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	mingo@redhat.com, mmayer@broadcom.com, nathan@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, qmo@kernel.org, ricky.ringler@proton.me, 
	song@kernel.org, swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

In Makefile.perf, ALL_PROGRAMS includes SCRIPTS (perf-archive,
perf-iostat). However, unlike PROGRAMS and DLFILTERS, SCRIPTS was not
prefixed with $(OUTPUT).

During out-of-tree builds (or when O= is specified), Make checked for the
unprefixed target 'tools/perf/perf-archive'. Since the actual script was
installed into $(OUTPUT)perf-archive, Make concluded the target was
missing and continuously re-executed the script installation rule on every
single incremental build.

Prefix SCRIPTS with $(OUTPUT) and update the static pattern rule to ensure
Kbuild correctly tracks generated script prerequisites during incremental
builds.

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 3be0be5eb43b..dccfce2efb93 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -405,7 +405,7 @@ python-clean := $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT
 # Use the detected configuration
 -include $(OUTPUT).config-detected
 
-SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH))
+SCRIPTS = $(addprefix $(OUTPUT),$(patsubst %.sh,%,$(SCRIPT_SH)))
 
 PROGRAMS += $(OUTPUT)perf
 
@@ -592,8 +592,8 @@ $(GTK_IN): FORCE prepare
 $(OUTPUT)libperf-gtk.so: $(GTK_IN) $(PERFLIBS)
 	$(QUIET_LINK)$(CC) -o $@ -shared $(LDFLAGS) $(filter %.o,$^) $(GTK_LIBS)
 
-$(SCRIPTS) : % : %.sh
-	$(QUIET_GEN)$(INSTALL) '$@.sh' '$(OUTPUT)$@'
+$(SCRIPTS) : $(OUTPUT)% : %.sh
+	$(QUIET_GEN)$(INSTALL) '$<' '$@'
 
 $(OUTPUT)PERF-VERSION-FILE: .FORCE-PERF-VERSION-FILE
 	$(Q)$(SHELL_PATH) util/PERF-VERSION-GEN $(OUTPUT)
-- 
2.54.0.563.g4f69b47b94-goog

