Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DFC496D36
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187200; cv=none; b=CM67zELCMLcm/beHIStF/H98GdW0JbgDtIWs/vVFy9ZRWfkuiTBQ2dh6rwbL5nwjiwOgYd01y3JtonNv1y5g5zIN0SBaNb3EvyK5sXeq/PPAr9iQQgyhWXxKpXklk0TB9GyPFE3hEM1tP2fmdI6a+HsInjqWLGRvRDitd/UP90g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187200; c=relaxed/simple;
	bh=875QLfqoOZ34F8YSyij540+OE9P4ryfzMjl/OLqDd2Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e00OTWoYHYjHEZy7fA8RrGxzLL1L2kNhgTggNzZgN1sMttvt/GJk8sgW+pdHXIQVRHRFjhYL+GiGj6i+++a5x0K83nftOWUpjgZpMxbi9p7JlwwfblLVQ+PmsGBtfjPVqLSxP29CZk2BNGWtbCSVUAxUisv5LBoPv7dhdD8BhLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fjdMuemN; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fjdMuemN"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1383723dfddso2406862c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 11:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790187196; x=1790791996; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2XlGXNbap/l1A+NNaDouPpI2p8sjO55zF+jQq8HVzIw=;
        b=fjdMuemN+Fo/jxPbhCN0XJFS1bhM4BXkYpc8iIHDDTsyKyrD6nYOW9StF7AYOK1l/I
         5jBpnUzOxS28xoXplk3OZITdmv4+FJa7ejWfihqW0etg4ZhOQOy1FHSFyYzZmsYfuLrg
         6bHy2rEkTOe4vdPMkkRzgqf3J3EZncg6FxuXKGDo7kfd5nSiaPv4RouxyMDoSWuncf/b
         N2JxoSTtDbSUxM+pHdvCrZNBavZuhFC0Zqoo4ze1darJ80d9heBrR6wddufjOnAdiIgR
         YTBIA5NqBY329W3Ag+GVhMpPUaVbPa5mclr0MUEJWE5NKALJRjvY+q0AxtYNztAL0+56
         idxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790187196; x=1790791996;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2XlGXNbap/l1A+NNaDouPpI2p8sjO55zF+jQq8HVzIw=;
        b=d+cnuUa/L0NdcbgYXkRV4CGGsntdHozjfOgolVsD05syrlzDYknGho2CMzts1Uf7Gc
         D0osEXxaifat5AjU36cnkSz2JTZeZcShc3XfUMtirqx6wvyuEBAwUekWk0ESY/ay+6fR
         4tyQwYfLag+vdVXkjaVRt50qTcFd2UT9fHrswWLyVXVFLw2kMXKmqBe3saf/4VeKgDgO
         JtwvgiBlo+IUI6l1R+RtW8RVtlmhRsYDveoyLVqPq3rLJ9sr4Yx2SIMGFVUgHrEgsV2Z
         3logYyL0jQIiVqF4NoWK15mVO7bLvg2bJTC0nMSPQNucv897pyWPOUUY/aj6gtucxDn9
         I0Ww==
X-Forwarded-Encrypted: i=1; AKwUvBzjExGm1vH8CxhUWOAZA7p43WqZDGBU3uIdTaDa78Y2gcNi4VngMkY9co4hPuLMizxLxwjgITn3Jj4cgLI9RuL4@vger.kernel.org
X-Gm-Message-State: AFuF++n+NzaIXW8jtTzpS9C6gu/MkHKe+u522Vvf7SRjST1Eav7owq1i
	QuSb5t7u1U1035o4SymcZwfbZZRky+7CnnrZDn6UGIfMey8IBSHFQWXeUq+zL3eMq67SWuL4Vdd
	fLwj7GyuCBg==
X-Received: from dlbrj1.prod.google.com ([2002:a05:7022:f401:b0:143:9658:f913])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:208a:b0:137:f532:e360
 with SMTP id a92af1059eb24-144f9086f02mr3322615c88.3.1790187195317; Wed, 23
 Sep 2026 11:13:15 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:11:33 -0700
In-Reply-To: <20260923181213.3032038-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com> <20260923181213.3032038-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260923181213.3032038-11-irogers@google.com>
Subject: [PATCH v3 10/49] perf python: Allow KeyboardInterrupt to propagate in LiveSession
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

LiveSession.run() synchronously blocks while polling evlist for events.
When running interactive tools or scripts from the terminal,
KeyboardInterrupt exceptions raised via Ctrl-C must propagate so the
caller can break out of the polling loop.

Previously, LiveSession caught KeyboardInterrupt with an empty pass
statement, swallowing the exception and preventing calling scripts from
detecting the interrupt cleanly. Remove the empty handler so calling
scripts receive KeyboardInterrupt and can perform clean teardown.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/perf_live.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/python/perf_live.py b/tools/perf/python/perf_live.py
index 616b5f657463..99e73d58a96f 100755
--- a/tools/perf/python/perf_live.py
+++ b/tools/perf/python/perf_live.py
@@ -33,10 +33,16 @@ class LiveSession:
                 # Poll for events with 100ms timeout
                 try:
                     self.evlist.poll(100)
+                # CPython's PyErr_SetFromErrno() invokes PyErr_CheckSignals() on
+                # EINTR, converting SIGINT into KeyboardInterrupt, which inherits
+                # from BaseException rather than InterruptedError/OSError, so
+                # Ctrl-C exits the loop and triggers finally: self.evlist.close()
+                # while non-fatal signals retry poll().
                 except InterruptedError:
                     continue
                 for cpu in self.cpus:
-                    for _ in range(1000): # Limit to 1000 events per CPU per poll to prevent starvation
+                    # Limit to 1000 events per CPU per poll to prevent starvation
+                    for _ in range(1000):
                         try:
                             event = self.evlist.read_on_cpu(cpu)
                         except TypeError as e:
@@ -53,7 +59,5 @@ class LiveSession:
 
                         if event.type == perf.RECORD_SAMPLE:
                             self.sample_callback(event)
-        except KeyboardInterrupt:
-            pass
         finally:
             self.evlist.close()
-- 
2.56.0.rc1.310.g51773c2048-goog

