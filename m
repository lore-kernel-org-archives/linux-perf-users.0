Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80BA3F39CA
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866761; cv=none; b=LV94huB8ldKhcesXxYwZVm2QYXZGJzj0qquBqxr1OQ9UusWwqSfkvrMmhF+OSpIEgVHfc9nxFmQvpfVCpmUi233BgYoN81st/keGFxOwx2TynIi7dihpDegYB64EnLZoDUk7GbZQybcGDEAnGDLVABY0b6TaMpesk7DCDDIbbZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866761; c=relaxed/simple;
	bh=o/K4kgugTGSk6IivctS3woOeRJortswYl5L/8mR0x6I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JQURjU6tzwY+lQjnenwCPajCCVPO+JuuvurujlJOsqBTtvioaUNAEO2K8nlPIpwMFgEb9Guu1374zX6Lj82vDZvfCBHJ/5NN3GjhMsEw0CSDh+khPbpjMcsQEWv/ZCumLBWcr9Gw2xv5K+8TKpenj0ZjM2JhDWRY6q7ihREQ6rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RjmBQ/nd; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RjmBQ/nd"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2f485961555so45609eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 10:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778866759; x=1779471559; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mgPMCywWzI9T8eglAxB7fkblHJQb+JFJwFxoaBxPkU8=;
        b=RjmBQ/ndIcuk0+tP5ypIdpP5yIOXBIVQqXOhnzRrBhmq4O1ZfrtRswnY6snlmC4Y/2
         Ug4nnHe1LX6rkFuxQgvU72Tkzm8sGatQeV78KM7mNyvE9a+qYENdE7qRQeoG0a/1jn4C
         28MtXQ8Ms9uPNgGFjCs7NuAWf7TOGbXZxLA5wK+beoOFcPY0qWbLiwJ3E23kgLHV53kg
         bYyJXJ/4N855Hj0Gs/1wJIbusZ4BtHAoI/9E8t2pgG+nOjIRZHEZmQ31+C2EzUw5Z0fk
         xwdtgg+r+UarP6BC+Qos3BaE39RIVWQCYd9yTX+Cqjn+krAdepVdIn5IvKWS/d6cW31B
         9FTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866759; x=1779471559;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mgPMCywWzI9T8eglAxB7fkblHJQb+JFJwFxoaBxPkU8=;
        b=MB1Z1Y7Rp7KFTTDwPQQpXEToZMO60NWAkSyp6gpPgnBwalXosQtL0LXpXLohrI6YMr
         fuMBSW+uFc22OsXS2gsYaoKcceMUPIDfZR3fHyctvhyL94lqHIEVWtG/GJ4fF4hooL5f
         +Pf5MLhSeNC3Cs7VDUJmAfZ5uMTleBrhe3ruDNltIqVCCDVVZhV/caprQabpnoFGtz4/
         ZGFnANUY3VRLZSsmn/hKK8jAhCzZrPeXlN4FmrThiEUdks05OmGx0V+gjDUe6zCQ0OXQ
         Z8d8dYgE+FRhX4LhPmg0/a3hK+ECc4z5LNEE+rQ/sBb6XYzU9ax2Eonyaq9u2CiAFN92
         ePSg==
X-Forwarded-Encrypted: i=1; AFNElJ+0bHmqgQgQ8qMa9lyyzPvtZKP1TNobP+rW6kKo9u+Z7g3eAtRX+Y7qqONc0kTFzAQ6onMGOub5YL17HQU1MMgI@vger.kernel.org
X-Gm-Message-State: AOJu0YzeiMX7KbyUN82IBlcFWOn4kWPuLvv/36AA9I4+M6RMWw6+/9gv
	fWNU1UsTRGucJsX+gnvbp/oSYXxjnu6YHAbVl1Fb27s13meOA/g+5jUzIQnuZJGI+retwYH3Qkr
	l0gQDzg9LEw==
X-Received: from dyek35.prod.google.com ([2002:a05:7300:6423:b0:2e2:26bc:21c2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:ac90:b0:2ff:9d6b:4f31
 with SMTP id 5a478bee46e88-3039812b389mr2310822eec.6.1778866758473; Fri, 15
 May 2026 10:39:18 -0700 (PDT)
Date: Fri, 15 May 2026 10:38:46 -0700
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
Message-ID: <20260515173852.1378571-10-irogers@google.com>
Subject: [PATCH v4 09/14] perf build: Remove redundant libbpf feature check
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

