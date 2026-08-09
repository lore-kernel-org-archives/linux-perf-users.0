Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161503AA50A
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Aug 2026 07:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786259728; cv=none; b=fzFrMfNLApDKkVd0GqbuMfjielYo+XbglAmQsdXZrrTjS5yWPDu/ArVT05s7K+zrH+YX8I2AKWXedgZjR/36gegYUF5W+OrAEwtrzAiRxzHvxFo3mPktNzAlx6LgkyQmBsjsidd8cKKftBPd/aE3CFOO3qfcv7dpArmPf1gl6gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786259728; c=relaxed/simple;
	bh=eTLTXsX4mUdMPUwdgUu6LgfscRKIwjPgzHjKLdinpgM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ob6yD9xBC65bW/wTiFY0iCQMa0hbEVbQanwVdfJtQ79O0ay2l/+B1KVjveyjspVfdTDoI6nB2wxyrM2FVDDtVf3fe/CXyKNGUBGjLdZyzC7b9vfPqYhCStZsxMl4KlvQtlkXAvnxwZuUevt1j9NcxnEockAMGj/DAknCeqWlpG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nMYBcb2E; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nMYBcb2E"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so567844a91.3
        for <linux-perf-users@vger.kernel.org>; Sun, 09 Aug 2026 00:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786259726; x=1786864526; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=44myQ460KI1I5jV+5Jt00SfBl1/EBm8ZDskp8s1X+nc=;
        b=nMYBcb2EGHHl3PXJK6INVLfUG1aFIkOJdJ1sw0+NHrm5K7zOhEOk+MkCVH0k7HHB2k
         p0OKzfv/cUQw5mQAVrS2vlL7hpvfW/ilZ3pn8qBqDOknGuH+1yrDKTp8a/G0DsnciAlh
         7Y7KX3xjrS7VMBIzFdRWbzW5s6rNV8JCmjc+iybUGlkOJ4L6+7YFJv4fzvLN72Lvo7Jn
         gyLl97Th4QimdKp/onXPERPJJuOcUMIwdA9A23oaAJ3P4UjvZApyuB8JC2iTbUT4ZA/L
         ClHE5YFoge1m/dESHHa6EcvFTxmgnEiuqFdDaliXTSMRq+T4BOy/X/iHWPTbtA1y0G4b
         kAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786259726; x=1786864526;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=44myQ460KI1I5jV+5Jt00SfBl1/EBm8ZDskp8s1X+nc=;
        b=c3wVHGiyFrNN/34Un+tREM65qgyoda15Q1c+zBshgpCrehUDJ3CpmRdegbRZwqquo7
         1F5p8CqglNxJNB4IBTgqKDe8kgdOtdwBhc05HboHKx9DG/ZH3F/k2F+oOBkg5v3wrtXU
         n3TuAHgVJnWnlYruPX+AAM7cygLyPs4EBUszHHv/bZKFYbIk79wBBfVdaJUyAIkPW9oL
         aAJmn34O2fy82xh9Ygl2YFBzoJL5be2Vi7DJaCTkzFGP6MrpZz+qOKC3i5S8nKMzN3wF
         4wYd7E60sqUOS+yGFhijNSWhMZYDYYEZ7CLoBl/EQ3snInaeF44pYhb5TAIY0Cg2Nk8O
         9dOw==
X-Forwarded-Encrypted: i=1; AHgh+RrpHvs4lNHcc2pTk4F2/8H/DnilgVLO7w2jvwjB8sP7PbccJUkIZ41pPT4SRpMZcdagbwKk9xv8SjpKRaKk8l66@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7tbziSi1eYBiaN8Kwo+3WPSmZs4c/7tenlvtAfZ2f3Agnmvt8
	zcwaS1t7leXeKUAwaku2uXiA7Nt+EdIurQGdUv9lz+2BQU4YkQkY4vM+oBUVxFJUt2QwtlPOgTZ
	Qk1qfMiEdmw==
X-Received: from dlbep6.prod.google.com ([2002:a05:7022:1086:b0:13d:2ef5:67be])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2745:b0:381:3b5d:30f4
 with SMTP id 98e67ed59e1d1-3903c535d84mr37292057a91.1.1786259726030; Sun, 09
 Aug 2026 00:15:26 -0700 (PDT)
Date: Sun,  9 Aug 2026 00:14:51 -0700
In-Reply-To: <20260809071455.1221514-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260624051535.3584977-1-irogers@google.com> <20260809071455.1221514-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260809071455.1221514-13-irogers@google.com>
Subject: [PATCH v3 12/15] perf python: Fix MetricGroup return type in perf.pyi
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The metrics() function can return a dictionary where the value is either
a string or a list of strings, so the type signature in the stub file
should be Union[str, List[str]].

Fixes: 430da3cd03b4 ("perf python: Add perf.pyi stubs file")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/perf.pyi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
index f266c9baffd0..58b0b3ed819d 100644
--- a/tools/perf/python/perf.pyi
+++ b/tools/perf/python/perf.pyi
@@ -1,5 +1,5 @@
 """Type stubs for the perf Python module."""
-from typing import Callable, Dict, List, Optional, Any, Iterator
+from typing import Callable, Dict, List, Optional, Any, Iterator, Union
 
 def config_get(name: str) -> Optional[str]:
     """Get a configuration value from perf config.
@@ -12,7 +12,7 @@ def config_get(name: str) -> Optional[str]:
     """
     ...
 
-def metrics() -> List[Dict[str, str]]:
+def metrics() -> List[Dict[str, Union[str, List[str]]]]:
     """Get a list of available metrics.
 
     Returns:
-- 
2.55.0.679.g6767b8d81c-goog

