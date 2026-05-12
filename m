Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55F13E9C1C
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 17:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608045; cv=none; b=f04HFUCLJucZvKMqWweV0+39L+bbptTmo6tQLkUBGuQQ9/gNF89UDx+SUSZejMp1r4b7MFOl/IJPUWqpxS9+uuCW8IF0OPKatVD2gjNFt5XU292L6tJfOUEMw6a/loM5HNFgv12bSMfDDhRsjkXkCYJzDCN/Suuts8zcuLBfGsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608045; c=relaxed/simple;
	bh=rjzjA5zRIkpICgO0qUIWtuptTam/FQFcuKRS9Xq1UvA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W8FSWktx++zC/fYdrz6YMx6IQZ6XrhWA8yQtDcjAMuS6ZVg4BusdQARWsCJNh+FQDJuGq4n1qLC4CbCVlICwIBtlSlGFvunjFJcJvoiLto6T57t0my7pU/WaoOCcbyMhEM4YNH0nm974kSchOZTlaiWR/kxXNC1gsPOcahfamOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hISbOQme; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hISbOQme"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1334825df27so2225447c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 10:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778608043; x=1779212843; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lGrstGPcZrorDIbjfOFeE8ufwrIU7j/Y3K3p6Csfg9g=;
        b=hISbOQmeq6wIJtbpqFRlt6niyjmQ5fheLeZOlTslW0cMaYT/XuMby6ZnQECQCTnFCc
         o4yuVsAWui7rXE5LB8uPL1fpPOEYXBjbllNQ0QU334AhGGd29J8cJ7utup90Le/XvVYb
         oSB9EXyzeZUmB3AukQztxa+K9nsNLDyHHnYb9FiwuJIqJ9M/DJdyvay8rNpxNYEIcGft
         cBayo59RgFpo+xk6YwXvGrkQv2X9LsHmvbRrcu0gcd8CT1SiGMoWsK52lp7q0dOjCEhV
         WbMboaE26CKwYTN1BH0uX1KKaCus9WDLLoNIxpNxFWNhycH5s1KGVYNekBShDSfnaCo/
         tEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778608043; x=1779212843;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lGrstGPcZrorDIbjfOFeE8ufwrIU7j/Y3K3p6Csfg9g=;
        b=iJpOpqv2IMh+Dq1p4daZCFGoJiCyEh4sHcbJEoHG8f2gO2LAOXuR7C+ed2eLz3DSw+
         6Z0X+8+KXzt+jUuz7OXr3s7ux0B28a1sYUtYDY0G1KOU/lNsmkN5PdR7Cc8YhGsHtW3L
         QccaZ/RJjq+hq5lFxVCglaJ2FUaNCVgrmZG42/eUx9MtrDiORyZHPjhv+FfreelTYFGg
         ++BiEaDtvQbEy/Cdyuxc+Ma0vBCzHRF9cBtLcrkjeGKVHa4mbY8GqWZBpfzypU6wWqCf
         qzjExS2xMU/qrao5GGMpeBLvDKoppVOuyPjM+HDj+yDA/CqTil9YvRAUE4wIKAXB9YDN
         pdog==
X-Forwarded-Encrypted: i=1; AFNElJ9U8q2DIIcEI4ub7CgW92OSjhV2UJzXxbk7WDA1/QzpbnCthuNrjtRAgvL06pGg3LQR9+qkYlKaaSfANQ5fTlX7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx47+/yNn15k60+XLAl2FHlXGUyjw2CyH2r5kDltTSBdX720Oa4
	Fze5GayPL8rGWPmiWkm3/YjVDpgB3yUQtVpAncBmIMYsV9ZzGzH6Tsy0wORiOOxUTIsvHkXlzjZ
	4ak0Xof/t8Q==
X-Received: from dlaf19.prod.google.com ([2002:a05:701b:2413:b0:132:8d92:4d78])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6896:b0:130:9c30:edfe
 with SMTP id a92af1059eb24-13344fa6201mr3149800c88.32.1778608042523; Tue, 12
 May 2026 10:47:22 -0700 (PDT)
Date: Tue, 12 May 2026 10:46:36 -0700
In-Reply-To: <20260512174638.120445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-15-irogers@google.com> <20260512174638.120445-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512174638.120445-17-irogers@google.com>
Subject: [PATCH v2 16/18] perf build: Prefix SCRIPTS with output directory to
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
index 98b6f9fda8d1..e700cc1ed028 100644
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

