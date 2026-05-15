Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3C43DFC63
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 19:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778873635; cv=none; b=S3Fo46PB4nad3griYTO2CckU/o+f81nCcilxXujrtquiwcwQDMuMT23XpgzqG9gFQdaCRPEnFoQuXOjpVyUcZyIyXeGOmcqXaVW44UHtHz0w/XFQ9bfDozsevx6mg6axa1U9zbafIJBU4B+Ft6XUvWXy8lvjMLPSs2IHroWBm+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778873635; c=relaxed/simple;
	bh=UO8COcfsaqz02sjdD6/7eGxdxivUik5cN2WpzQTquMs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s5F+xdY/iYhdT0gY4HIkJwAWsCjUBb39OuepW5rmdWjPu69dWcfMKzJ68T5eVX0DeOBFGENBnUn4xl2vNirRewGeQbPV+gPMsIDb5sDNElVXFvkp7F7pAeoeR+GrPl0fENd3LmxwUd1R9x2bthr2byiDosXHB7sBVvfLXZDl6es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bHjWSn7W; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bHjWSn7W"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12dece274b1so238576c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 12:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778873633; x=1779478433; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=elI3dCv9to9+reTrmH7gWaOOH/Cw1KfhvnnriZ/0VzQ=;
        b=bHjWSn7WuK6tOHoGEwzIHlTzKWGNE8IyrJaQZpDADdtB+bHqVAFw4SGYK7wFTFVYeX
         Ie94PN7hE2TXopwUmBSN0AsrN6CCMZ0SOsYrCAREoVnCuxONh1uMt/PrM1YJxToflxix
         1Ewwh9kjDE/d4w0OAUQSTGj/rkOxlbo5ABZ8rxQa34ZoiRVkP9Pq1LLSqqi06GzQHovG
         zA+oMSdm4b/kbUTOP8OfZM+BlX70m0kjB1IGU8pmyEtHd7okPi9/OI0AJ9oPHTFv4Cej
         gm/Qajf9w76cDRX0rQ06vIw4qwatc/z6EbiFG5YWP7PLk7kFshJwtKSrylSHymVOYnq8
         z7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778873633; x=1779478433;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=elI3dCv9to9+reTrmH7gWaOOH/Cw1KfhvnnriZ/0VzQ=;
        b=U5R3h3kgs5Zgfli7tPCskWYxljFsqJCTaB1pRuhtzH7j3IjMnGGThOWYSFezNEcOT+
         iL+k2todVkLEYIoxfcEf5fpBRloQ80QzeFdmkmmoEwaymtyMIedwjCH/HDu6amghH9Ng
         ULiGC/H7h0XJST9caMWdf9UO/LT1dOb8AuUQRTUl9HFjdUTDL/5umdECqAFc55oGwCFW
         tbJP9Mk9z9yKtTtEWarraJfr9AOovVAZXJsWtKnTQ+UeH4yCojBTo/XZ+ZxPqs6pi9xD
         YLYkLqFu0NSoVoOF0+c4VJZ6zpksyLGPQKO2bQ5x2Qza0huguWnTJ76lDE8yhiaLSrCL
         wMLg==
X-Forwarded-Encrypted: i=1; AFNElJ/uwYV5cLDko2qPftAjy8ywjqHO3djlClliLrmJ+D9k1qTug8cFiS92LgtStCMYExt4RwIYcrJSXcEKqd0iIlxu@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7aeLaQXhjg0tqTbUeKmcoVriatKS011kYLnm6J+vDEc6IWfMI
	N3I8KZbHz93U/YtQFNRwmlX3xhzzbSNr0V+HSDSOXQzX5OHjfbi6evdwCNnHNXz9cnCTlFwnmsS
	E17UWBMYtnw==
X-Received: from dlbur19.prod.google.com ([2002:a05:7022:ea53:b0:134:c678:5306])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2523:b0:12a:6c4b:9d01
 with SMTP id a92af1059eb24-1350430f349mr2270147c88.7.1778873632533; Fri, 15
 May 2026 12:33:52 -0700 (PDT)
Date: Fri, 15 May 2026 12:33:12 -0700
In-Reply-To: <20260515193314.1593560-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515173852.1378571-1-irogers@google.com> <20260515193314.1593560-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515193314.1593560-13-irogers@google.com>
Subject: [PATCH v5 12/14] perf build: Prefix SCRIPTS with output directory to
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

