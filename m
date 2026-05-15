Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1223F8EC9
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866769; cv=none; b=q5Srnd2WiqCWEZaFxWxq0CfAifwRUbR9EvgrGsQ3dWXGTxiz6ULAAFVJkhFOFiCK6p3w3HZebvXEHmGHSLSfT8mzz15wO0p5qVoHlaCzzyI4oHaRvcqJUwjrKzI0a6R0Ks3Lh+eNgjWIlozMPIlef5AJUsCg0Oa1kzk+6+0JBxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866769; c=relaxed/simple;
	bh=UO8COcfsaqz02sjdD6/7eGxdxivUik5cN2WpzQTquMs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CcHQ0RYeXN4gE2iFEzznFfQoF41gabHdjFuzjwWkpIsAI0vfHYytbGLlx1BKJGsi+5HySJA47kV6lEMctEFJWBYjim5qmk4GluAjhaq7mTuTdIunqVU7LJl4cZYDTCsxM8xNSbJhZiq6TYZQMFQJbjKlwSjAjzrbFch8TQDrSNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iz3DoYic; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iz3DoYic"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2f3ec2e8d07so504573eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 10:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778866765; x=1779471565; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=elI3dCv9to9+reTrmH7gWaOOH/Cw1KfhvnnriZ/0VzQ=;
        b=iz3DoYicMd8gb4mTbQZ6CpfKw02+ghudu9zxGsjY4Wh7S3N5oCAce0fu+bwR2dpBUd
         yhD/tq+J3BlKtYIas9RR4raE4lkIG1vQH5ZGixAULLNiwNjlia4Y6cB6DMhazYeHCJtn
         mVEc0uv31H1eycoidZb18IWOpX9gEdn/rAzKMTT33V11ixLqa4PpkwE+zmkZ1d+YSp5q
         7dVR8Kb16bl9ezvtlhtWg1OyQLyD2U4597nDhpU3fQqK8CnW+bnhg/NWTBHhGuLBhPMI
         drwswap8C+6N6+9wbYvXWFBMb813PXgeLDOyqZ64nWqbtZMqOOvD1kHCtnVtnU5VPGZ1
         tr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866765; x=1779471565;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=elI3dCv9to9+reTrmH7gWaOOH/Cw1KfhvnnriZ/0VzQ=;
        b=gWGNqQnCYXMrSNJD9BFZROyV22/zSUFQdgy1L+FEG6DlZCMoD8vL1RAIXscsweH8B0
         w40IHDLdXj34oxyApNGkEZJJtn5F9eOX/Q85jY6jQvaBjz7kMBNrMqtzfcP3VxQL56+n
         5U0dhfG4vLy+6LdVTQnsfkgsqIc10sL5JLTycskJN1ltuSfQ8wAc86h8tyqYotARGm0H
         n1Eo9qFbgdOciLHibcI2250o9fFjtNV7NHqMFUdWwZuNBpicrhyZd8XiNv2gu1o/Gr+X
         yPqOKiGJRQFyTWQ6qqad8BTkWzqq4ej/Tkv0dy6y6EFrB81N4Pf69n5bwL5r8pvtOqpW
         cLVw==
X-Forwarded-Encrypted: i=1; AFNElJ8lbj7pBacB1atFoIHBMIyUkVdwFVipWbjOVLNlRY9Ov4szlD63KdjPbX24NmleWYzoaf3kX4l0eNjX88uGGuo1@vger.kernel.org
X-Gm-Message-State: AOJu0YzVcjzsZFMMvFjLyth49hlqcXjQ/TbxNw0kyiqUkHcVtXSVWhQy
	efvAIUBzBpE5+GE18pheanOQEf66QCo/ShHiRK0zvRIZ+u6WpamjafQVhk3VXDHnhYPfsQvgYA3
	Dkh7YOvFUjw==
X-Received: from dlbvg5.prod.google.com ([2002:a05:7022:7f05:b0:134:74a7:dae])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6992:b0:132:83e6:41
 with SMTP id a92af1059eb24-13504c5dbb8mr2157263c88.13.1778866764333; Fri, 15
 May 2026 10:39:24 -0700 (PDT)
Date: Fri, 15 May 2026 10:38:49 -0700
In-Reply-To: <20260515173852.1378571-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fWfrGMV4EafqkwQO-R33c_szXcxVLgH0c4k2zt3zj4HdQ@mail.gmail.com>
 <20260515173852.1378571-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515173852.1378571-13-irogers@google.com>
Subject: [PATCH v4 12/14] perf build: Prefix SCRIPTS with output directory to
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
index b8a81c9749a8..fc92d6ceac5b 100644
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

