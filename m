Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5F2264A69
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Mar 2025 21:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741729005; cv=none; b=AOz7CMJmPFYuukodWa7OsecUEweo8JgRLBJlmq2GWruJDJKPnvCNx6ywVl7nDnQJ2HORPvH8KnK8S0nsAeL9l0QFlsQRnYcSuLgG4dnv7NR7pGgBLIdarj/NlbeYaFSs8oN1TK8/ZxqK+Z3cJqHVUdgkWpsvoRJgI4cS611LTfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741729005; c=relaxed/simple;
	bh=wGRplBneEc1rIRRdZMJiQ0Fw8JqUQP1EAzOvCudzAIw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=XBNZQMrTWN8gx8ZYJJdNbAcjzlmiX12HJTx0l1AODj3tgsm1EZXLfiDC1jU0VrobTpYJZFBEMsyOL6dOQLlLLcTN2Nn6YJnAujOqDauNZ+fXxK5aO+TgUy9SZWSpzALjYpR1PXFADLyPH9Kb5U0aUVOtPGmGzwigM3de6sC4+Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ezp/DxVA; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ezp/DxVA"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f2737d115eso78622927b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Mar 2025 14:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741729003; x=1742333803; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2cDMG93hxPUKXZ7cLkWYorGVfJKpRaqSUmDH4zrnk9A=;
        b=ezp/DxVAj9Iwo7Wft0119uEysxdHgUA+xb3T0a8ZAIHYyDo07B/PQ3QZGYZY/ON53a
         eHuDsylj0zivr2PDxM02eM6l2Q8JjCWsSds76bSdqxHvsC0MniG8OvqsGUZWNOX7DCdu
         TxNP/pf4wca0zL1T4cToUaJSa3emcLNL/vAkkB+HbNwd63h+AwLfg9XbVYWpJr4pkWsd
         WOnC0hwbyQZT9q2rf6PINcDlezufsOe6HLGEw2Uqh+ZUbUlKYkhSbgkyW1pDOA3yWhCh
         pTJ3cGYhIT7y3Vlll3fH4PB7aT1UfCK/o3DtAdX/w9ujg8S6FZO3tKL7+6O6xaCkJBAw
         bt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741729003; x=1742333803;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2cDMG93hxPUKXZ7cLkWYorGVfJKpRaqSUmDH4zrnk9A=;
        b=nEgoB/sp7rONKrjENkX/siAqm6nwKYmXzp260lcNsToTBkVehgI4fWJc+TUXw8274C
         2UHe/+TuC1yxijB102yI35pC5H9UVcXw3Hx+9/01ZJz31qnyNHRUqUkvSONxklQTqqu0
         uir7QzEDmdl6dx2/1oFZLHEdBOfLl1KYFbI3yVtINLVQqO2MFYka1dsUC21v/YBsJEbp
         CCSmRRNGW0BVbwp3z7XYx17Io0DX8O4YFZfXOSBNPxM++9pEoPsITVkmrn9/+ekUANuW
         LUjhaKoZ3ytRVK5ayHrGiBf+TodCtNOYCznHh9l+MXWPthS6p1r4CYdqAenkbanJut7e
         AQMA==
X-Forwarded-Encrypted: i=1; AJvYcCVxrxfz1xMi3dD66NwxZ9/8YLX3WIp4D7vlDk1OahBJDit48PAkvUbKUGNjZ6AHdA3S4sY/lbmUWWIela8hr0ER@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt0oibluPICwJDOISG4FllwAcEBUnphr1XcIe3MTz+aUJ2SOVB
	gHooBtAvrlWfb+RsxeoT8eiMV9KFnI6u+4U5nDJmRWD3ss3VuuODjskAYd8PwV4ADihqkDeR8N3
	b0mRsTA==
X-Google-Smtp-Source: AGHT+IEiOPSjPvcxng/rOefKJ2Ly70BAOiBxBmrwoe/2mKuAHw/kJPRmtJWO7sdKvqU40lKe9m72eTkVulcl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8bc2:942f:1b93:42dd])
 (user=irogers job=sendgmr) by 2002:a25:2d04:0:b0:e60:b036:664e with SMTP id
 3f1490d57ef6-e63b517afadmr35491276.3.1741729002756; Tue, 11 Mar 2025 14:36:42
 -0700 (PDT)
Date: Tue, 11 Mar 2025 14:36:23 -0700
In-Reply-To: <20250311213628.569562-1-irogers@google.com>
Message-Id: <20250311213628.569562-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250311213628.569562-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Subject: [PATCH v2 1/6] tools/build: Don't pass test log files to linker
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Charlie Jenkins <charlie@rivosinc.com>, John Garry <john.g.garry@oracle.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Separate test log files from object files. Depend on test log output
but don't pass to the linker.

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.build | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
index e710ed67a1b4..3584ff308607 100644
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -129,6 +129,10 @@ objprefix    := $(subst ./,,$(OUTPUT)$(dir)/)
 obj-y        := $(addprefix $(objprefix),$(obj-y))
 subdir-obj-y := $(addprefix $(objprefix),$(subdir-obj-y))
 
+# Separate out test log files from real build objects.
+test-y       := $(filter %_log, $(obj-y))
+obj-y        := $(filter-out %_log, $(obj-y))
+
 # Final '$(obj)-in.o' object
 in-target := $(objprefix)$(obj)-in.o
 
@@ -139,7 +143,7 @@ $(subdir-y):
 
 $(sort $(subdir-obj-y)): $(subdir-y) ;
 
-$(in-target): $(obj-y) FORCE
+$(in-target): $(obj-y) $(test-y) FORCE
 	$(call rule_mkdir)
 	$(call if_changed,$(host)ld_multi)
 
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

