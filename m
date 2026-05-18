Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3786386C05
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 04:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779079702; cv=none; b=upySeh5KhBEoCclkPYtf4nUAXilL9Kd9OC5ZLcwJAgbqsaad6F26yxoagPKKXufIBSfmJrNcowUindO3LEQNXuy/LQcYtgh1efDx1EH3u/tOJdRtEZVBqv0z18ql1yemD9E7EWJ+MHg+hEUeHq6+GmTfNWRdH53dJk8Ln5vSX3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779079702; c=relaxed/simple;
	bh=UO8COcfsaqz02sjdD6/7eGxdxivUik5cN2WpzQTquMs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EOAGjK0ueEpFbaXbiw2lM4EZDS+bDsnxv2GuGCk4j1Bw68dhcgkbVPMEvkQKJ+N6CXZ9R9BAc3dwXeNM12HgiDwH5b7Xngb54uxLLDtAwqCDjzK/Oz5pj1eI3Zt45fgGbCn5ORnakNSAm+NdG/nojRPHp/OuqEmpYaY/dVjSfgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gIewkNQF; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gIewkNQF"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2f3ec2e8d07so6648525eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 21:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779079699; x=1779684499; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=elI3dCv9to9+reTrmH7gWaOOH/Cw1KfhvnnriZ/0VzQ=;
        b=gIewkNQFxS7vmTxscHRN/sn7v6nVtxrgOJS1noSq7bPvntiWlJm6niwUD2I62OIrcS
         6STsMe08D2VUA4zxxo6szUzo0ikT4s7YHkOTGuTf8axufHFKETqTGo5WTTT1zP0cOXEu
         dSm2/wmfYoDsRob7mxDz7JmfaibBRBkOdnUj/mTY0ZUGi6GgovBYjA1T95tNt/r3Q9BO
         ncf5VI3xsSLa9QvsAbcFJegurMRXW6SLO4IDML2jiEkdi0pAQca6EXkErKb13F6i46xB
         eXCd2jVPOB9pOc0GTK6HMKHK5busySV8STf57BqKkMxEoy7KrujgXc4frKO/6nuOqch3
         YIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779079699; x=1779684499;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=elI3dCv9to9+reTrmH7gWaOOH/Cw1KfhvnnriZ/0VzQ=;
        b=Fl86oqfcbBtt1q9k5ovrpsGBh0NSCFkzQF4v/k6KR3T11/GUHF/odeYqzglCYuPJS3
         e4Z3oUSML0JqZBCQ/t67UQ0atpNiX6J83eLk95EpffbYuHqZngCXwg8GzaG1RejGL+Uy
         3L9GEZEFSyUGZlIo/Uc8m0MqlAuy3hRd4gefphPZpZYp0iho0Z/dP7Cs2wZgMGI340oS
         1y/6MSyFL/o/a8iWbAXy8rf7VQLi2Ty7yScPtQfNv2ZEBC1muz9Kgn3fJFeeXfbDzuED
         kXoGp5add+bEAJy3wZlm7xcWg+U/PDWp4k66WupegjTJ2cJbqG+NViZ5qKbkEjviu3D1
         q3/A==
X-Forwarded-Encrypted: i=1; AFNElJ+dYJlTMuIC0VVxXZI+y6EsIcqq/teeHdTp2T1dBXGh0yoHdErtInPeWYcLNI+jtokQb8abf31xOOJ5F2+F0t9e@vger.kernel.org
X-Gm-Message-State: AOJu0YypWD5J+JwCIIIIoDx0CPGR7Iynuc0+ujDiJyR57cLRmnzzC4vC
	06Yssk/hr4g+qvNrb3qO/l6AFxryG17pYt/D7n/J1nfueDtcn5qrsm3fWPhfs6kdJ3on+F+Zd06
	lBTrvzIOyXw==
X-Received: from dybdf6.prod.google.com ([2002:a05:7300:b586:b0:2ea:c1bb:3a9c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6c05:b0:2c0:c5e4:605f
 with SMTP id 5a478bee46e88-303986533e0mr6163849eec.24.1779079698716; Sun, 17
 May 2026 21:48:18 -0700 (PDT)
Date: Sun, 17 May 2026 21:47:38 -0700
In-Reply-To: <20260518044740.2526802-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515193314.1593560-1-irogers@google.com> <20260518044740.2526802-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518044740.2526802-13-irogers@google.com>
Subject: [PATCH v6 12/14] perf build: Prefix SCRIPTS with output directory to
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

