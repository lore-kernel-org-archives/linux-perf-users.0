Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D297385D62
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 19:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778873628; cv=none; b=KtTMD51+RDPyLE4KLJ90aJ/OoZ6C1DL7fD3IJ9LdqTnKDHwREATnthNFl8bfulv/jF3jNpWGod0Iq49BPFBJ7TNcv0AvC1qWZ0jvqG1uSxIGbmZcKWV/E3SzLJG4fj7YeHqAGBBAi0AmGMLPPMnGn0msxVeknqINP8iz4M62d8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778873628; c=relaxed/simple;
	bh=o/K4kgugTGSk6IivctS3woOeRJortswYl5L/8mR0x6I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h+U3FlFBP0GzkgMxxn0K81g8q7rULRF+hwq2O+cjNtKKi0ZtnokwABwSgkwDOxsAyVG91xBI5MwrCwmf8ta0hzZpBdBXNcjFHonF3TWzBRHHVewIQolc4ZgsQDP0jvFBi8kePnDFOSeG+BkbDCzjwQGDGv8Zy1+ZWd9U14bt0yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n5KCmiFi; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n5KCmiFi"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2f3eb8f3419so486771eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 12:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778873626; x=1779478426; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mgPMCywWzI9T8eglAxB7fkblHJQb+JFJwFxoaBxPkU8=;
        b=n5KCmiFiUj9yKCov1BbDqVHbXWt3E6+GC0h9j3Eoumrd2NrYlMkzUR225tQD4Nuju9
         RCY7FCqk4RqnXEKJdS/RSfdZXTqn+gBxcf9vTZ3qtT1V14mibh53ni0q7+yQ7jgzcUht
         WpXgDwzhpbPuWX0tKgWhD++0zIIPMPkvDjlpIerTSN99qYRrKv4aU0IfzgvBk6wsVv1K
         2rIiUrj9cZQGggsxNCHMyo18QDIXOXquwpES+WHrpYkgGSqRjH7jh2AeoaAeoQ9anu7/
         OuaF3jr0BlDTYaxPKrPl0Wr6VFx7LlA7ad7JxPykJJa6MKiwTfic4tZ0VpNhbJg8ddo1
         nbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778873626; x=1779478426;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mgPMCywWzI9T8eglAxB7fkblHJQb+JFJwFxoaBxPkU8=;
        b=HgNYCEgLgwk8IfLGthWNGpV3Xd+VOondmHCgoLPyTY9wsykFulOA0Geg+40+rvAckw
         jhMogI9jm23ULiSVE3UpzFDMqV16LNAqsV456yjRr0PQYzRCKAsvEIaS5XYpRAkSGy08
         kGoMV5k8Q8kw14+1H2VhBlXjEg0POPkCvFcYmC9CfXOJF9wZjX0YEDnGgG058f88OrFh
         KpH58H67J/wpp/OpCIIpZ9pmB0+BWAUeHGreFtqieG6J36On9pdKATGPQ/AeOKRnHCV5
         i3qLgaFbz/eqEmY3I75Y1NGeFiC/QF6UbYxxCvHuuy4TRZrEc9H+R/YbHYgcNhaIpt3+
         d2Eg==
X-Forwarded-Encrypted: i=1; AFNElJ+QeAcoIcfuWo+uOt+LwBAPr29qJVQcGNXBcQLAB+ZvE0iy3p0z516kyXpVZbtT8iX6awJsOb6RK4KUC6Qlea1Z@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv33k+T3eGX3rXS/R8r7sqQUtFY5++D6t8kHg8yC82+/zgIUmc
	ZJOZ6aV/KLNIpLtr4BzQcSvCCIhp3w+VDYAYQXC/C8U0JRIiBIMIe/R03wfg57ZyH8YLe5AY/JM
	9TaGAu12n3g==
X-Received: from dybnx1.prod.google.com ([2002:a05:7300:e781:b0:303:a321:4220])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:2152:b0:2f1:496c:94bf
 with SMTP id 5a478bee46e88-30398682f61mr2718301eec.16.1778873626136; Fri, 15
 May 2026 12:33:46 -0700 (PDT)
Date: Fri, 15 May 2026 12:33:09 -0700
In-Reply-To: <20260515193314.1593560-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515173852.1378571-1-irogers@google.com> <20260515193314.1593560-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515193314.1593560-10-irogers@google.com>
Subject: [PATCH v5 09/14] perf build: Remove redundant libbpf feature check
 for static builds
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

By default, the perf tool compiles and statically links against its own
internal copy of libbpf (tools/lib/bpf/libbpf.a), setting LIBBPF_STATIC=1.

Despite this static linkage, Makefile.config unconditionally executed
$(call feature_check,libbpf), which forced a synchronous sub-make fork
during AST parsing to detect dynamic system libbpf libraries.

As noted in the internal Makefile comments, this check was executed purely
so that running `make VF=1` would display the detection status of system
libbpf. During standard builds without LIBBPF_DYNAMIC=1, the detection
result was entirely ignored.

Wrap the libbpf feature check inside LIBBPF_DYNAMIC=1 so Make avoids the
redundant sub-make fork overhead during standard static builds.

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index bc1111c88226..fbe7fa83b0bb 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -587,10 +587,8 @@ ifndef NO_LIBELF
 
   ifndef NO_LIBBPF
     ifeq ($(feature-bpf), 1)
-      # detecting libbpf without LIBBPF_DYNAMIC, so make VF=1 shows libbpf detection status
-      $(call feature_check,libbpf)
-
       ifdef LIBBPF_DYNAMIC
+        $(call feature_check,libbpf)
         ifeq ($(feature-libbpf), 1)
           EXTLIBS += -lbpf
           CFLAGS += -DHAVE_LIBBPF_SUPPORT
-- 
2.54.0.563.g4f69b47b94-goog

