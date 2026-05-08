Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E525637BE7C
	for <linux-perf-users@vger.kernel.org>; Fri,  8 May 2026 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228857; cv=none; b=Q6iO5BhjmVcw5U98lcOMZ5edkzrMOsl+JDjgiXNUzJvdd1YG8OZBJvxoWwLxzCRFnP0k6Jmk+eSLlCl2w0Ci48RqPDB3Enq3JhzX36un8Yo9ODtbs5YLwr3saplpAgUHWbdHnVkBaXb8GoCsfVWJThCGHeShgbXCwMyowCIhn+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228857; c=relaxed/simple;
	bh=CylnfDQq2sYXt33B4obV12HlAnESF/qI9YpYRVRk2HM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qGM8ppn+98C6jz3/Yn5zICEav7CREpLrMlCF40Ykh68+weLIe+Ltd/GTcEkUMJ35Xz1mnX5bnWswsKI/6eFQ5SOARp6aVvy4d2JiH/xFH9GCEjtJXhZTjfF43lZou9uqYC5N8uRzkPMTt9cSbGeyd/OzBT5gOD6eE84ROobS89w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SlJ6B3rZ; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SlJ6B3rZ"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-131371497a1so2366067c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 08 May 2026 01:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778228854; x=1778833654; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=53zBMY0hxmigdLuQch54NlIbiL3paA9gL4y5SjWANoI=;
        b=SlJ6B3rZb/sXHtGH0gUeuxM/RVxNBstd9UmI3ed6jwQkfzQfoDkF95AgYx/+4JDpMn
         ZVLSVFL/0VfAVa0exerL/WdZ6Ro2IgnNLLLeLtMz2cyXuj6zRwOqs/ghmCuq7nLo71jO
         HTw30ceB4HTuhDmIuo2F0SMMVHFJbg+WdJ4oVcvXcgwhfsTGdoVUnv4Iw+dBTN5D3p4M
         E4b3YBzamyH5l1EUWYaDmuQ6fr04WnFwD7Q4B9nB+C+1dHGOZFGXOFZyCJWWE0oX4ojh
         yfJRTjItRvDFA9mTzVLFVLq5sDXq2cMwkit3CQPpeVjX44HY4OcP8Jv6gg/emc2Pjmxh
         An/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778228854; x=1778833654;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=53zBMY0hxmigdLuQch54NlIbiL3paA9gL4y5SjWANoI=;
        b=HbkaGEsM1EbZyRP5A1dWbI59HtU5h7Ej46zF2TI1X6/FB9bfUapbTNI0YT39FLTEIG
         fBTTaHRJlK6PSfz+gv25+gF8s7zkZIXzr+QmXUcIQBIpG9X/pjAgoVQ11e3bwzrldN+7
         DaauMXk/QXDB00LRoAjZ81uz7ynKvbzPfE3fFHwKc4XAVZn4Jcc2H59G1j3mEn6uVOIq
         u9ZT1RZO2fcQOH3zQhbAzwIU1eVRd37dBmE8h6xAjikuESidyKTuooGyWChvX2AKbtCM
         KjHSDLvldaxq9NRxuREBHbLvbyNPe3q+fxe5DDhMdF4wkRhQlxQkjpoREPQoe4CAchJ1
         EzwQ==
X-Forwarded-Encrypted: i=1; AFNElJ90vzuGAa+AkreO3mNXqpVGqO8Ix03lEuhVpnMJb4i03vFAuiwmZl2p9GeChzzHC4Vrtx5DYVl0HthZAwxVF+pL@vger.kernel.org
X-Gm-Message-State: AOJu0YyLA2gUF5rmYhiVtSlECBEO5jd0CcEuXkB66SB9u1N6o423BZVf
	Y0gE6LUNEsFjXso+A/ObMbaiYay+KFJpSsIuIRAUkubLc0xD4twz+09lwboQ/IMnXljehbTiA80
	3qe66zmg0DQ==
X-Received: from dlbuy21.prod.google.com ([2002:a05:7022:1e15:b0:12d:e9ff:7062])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:924:b0:12a:713b:8958
 with SMTP id a92af1059eb24-13271271429mr850207c88.10.1778228853609; Fri, 08
 May 2026 01:27:33 -0700 (PDT)
Date: Fri,  8 May 2026 01:27:21 -0700
In-Reply-To: <20260508082726.2795191-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260506004546.3140141-1-irogers@google.com> <20260508082726.2795191-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508082726.2795191-2-irogers@google.com>
Subject: [PATCH v6 1/6] perf sched: Add missing mmap2 handler in timehist
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, gmx@google.com, 
	james.clark@linaro.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

perf_sched__timehist() registers event handlers for options using the
sched->tool struct. It registers handlers for MMAP, COMM, EXIT, FORK, etc.
but completely omits registering a handler for MMAP2 events.

Failing to register both MMAP and MMAP2 handlers causes modern systems
(which primarily output MMAP2 records) to silently drop VMA map mappings.
This results in uninitialized machine/thread mapping structures, making it
impossible to resolve shared library instruction pointers (IPs) to dynamic
symbols/DSOs during timehist callchain analysis.

Fix this by correctly registering perf_event__process_mmap2 in
sched->tool inside perf_sched__timehist().

Assisted-by: Gemini-CLI:Google Gemini 3
Fixes: 49394a2a24c78ce0 ("perf sched timehist: Introduce timehist command")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-sched.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 555247568e7a..241c2f808f7b 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3299,6 +3299,7 @@ static int perf_sched__timehist(struct perf_sched *sched)
 	 */
 	sched->tool.sample	 = perf_timehist__process_sample;
 	sched->tool.mmap	 = perf_event__process_mmap;
+	sched->tool.mmap2	 = perf_event__process_mmap2;
 	sched->tool.comm	 = perf_event__process_comm;
 	sched->tool.exit	 = perf_event__process_exit;
 	sched->tool.fork	 = perf_event__process_fork;
-- 
2.54.0.563.g4f69b47b94-goog

