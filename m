Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604F5422E2E
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187175; cv=none; b=KXBWD382wKkvS3LwPZ8bzjY61Fxi0vms28eL2Zg1xF8jT6eqnC5rRUZb0llBmHzd268MLfMtFkK68JpLHCtdzKDz4nE91U+o7ZSxEiR7SsylpPe3GoooUthH0i9BdPom/xqvXpO2IU+xKZQRe/pL3IFYdflzPoY7OUVopW+W/D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187175; c=relaxed/simple;
	bh=rxBJstrb/NElUcnWB1Y6YOMGe83U5urlvFGslsanN1o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TW1gPpnhA9868Xa5/aQWlrnearQL25QIiGeXPkRowqsxoeVkwkEcPvnBLpVDIleSqH/GZ7GvhcxOwPrkEn43zloLqGFd2SaBCGnerKf+KgJZcafXI2Kc2vu6OHbQPJG6ymK/yPXt6aaB/NKhOo83sLd8mwocmcVD7RFK2DWhU/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SXCZABeH; arc=none smtp.client-ip=74.125.82.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SXCZABeH"
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1383723dfddso2405841c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 11:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790187171; x=1790791971; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JMi36kHqQF9krCG/BtzCWQUXvhHN3LxF/0Bt3Ev47fM=;
        b=SXCZABeH9pTBqw8+szxD23vr0DaJHv4jtyzB4o/IwN5DfK386kjd3214Ax3Zec2sq9
         OMEiKQTRW8IM3lp6v5RT3iu/rkR68dQkAyTvBgCo+TWs8ESWL25Dl61We4DHH3k10TNw
         GCzRkOdpMFwiI1yY1i6gxGKbS/HRTBp+aMqDFsmpyTkZYTc0i/okMltj8jJyKKxRSVuo
         LO21lHDVFZnXdp74rQUI40F8RiC3e0MUvNH11j2Dp7LR3dWobgAA6x6QYv6dNozKJhOv
         Ohy91RnYipH73dEkSAFAZfTQPkP7caf4tGLetYrxcVxH/Pe2FiK4h9HfmBWK1QCifnsh
         28CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790187171; x=1790791971;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JMi36kHqQF9krCG/BtzCWQUXvhHN3LxF/0Bt3Ev47fM=;
        b=UQTdlZT/IUhza/wRu4MzpSdn76cWCtpM+0fGZTARpZXWDhbilN6XV5ixZ4GxlTpR72
         SpK3yzmXKL5uDxZe8h2Oz5I5p9t7GWNop8DT94kHD5KYBUVds959bc7a+babNmZSJKcu
         DvkCL6nGn5LI8+g2d91E1FjRcfFmebKfzXStvVC1vzvcuaFmezqW5wAylQ3zImqML/T/
         mmJypX0LRmMgyEoio4fz6b0eNHkC2ayNG+MGWuE88oLoj5zzmrxKjv49TscW5fIfpUXJ
         nilqkQWUg0yB317kFGr6feVH0in/NWq6NDEfrPw7tzB4m69PP1xbO8nPhfoL9io7ZWR9
         Wn5A==
X-Forwarded-Encrypted: i=1; AKwUvBxxlxmegYumvUPy/hHKB5GGSP/+dI+0CyJcdExqbFh/CNTFHu1EY05QIIT5ZLKT6HTUgW8pqd6ojw68XnDLCh0R@vger.kernel.org
X-Gm-Message-State: AFuF++kW7Tz2mLTT3rbUBBiJ3sg8P3Q7fW2Uk+RR7aRBNqwSCNi9umGw
	cjkHEPYRbVHS7SZSlFxyWakjAXjPXiDvD5wghqVcw9JOe1nkxJglePK5+GCv59fnuzoPRPJ14wN
	xShOpTbGwPw==
X-Received: from dlaf24.prod.google.com ([2002:a05:701b:2418:b0:144:cdb9:29be])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1109:b0:144:eaa7:2765
 with SMTP id a92af1059eb24-144f90cac6dmr3462950c88.18.1790187170920; Wed, 23
 Sep 2026 11:12:50 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:11:28 -0700
In-Reply-To: <20260923181213.3032038-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com> <20260923181213.3032038-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260923181213.3032038-6-irogers@google.com>
Subject: [PATCH v3 05/49] perf python: Clean up pylint warnings in tracepoint.py
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Clean up pylint warnings in tracepoint.py so that it passes pylint
without warning suppression comments:
- Catch ImportError instead of bare 'except:' (W0702: bare-except) when
  importing setproctitle.
- Remove unnecessary trailing semicolon (W0301: unnecessary-semicolon)
  after evlist.enable().

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/tracepoint.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/python/tracepoint.py b/tools/perf/python/tracepoint.py
index 15b0c8268996..9d49a25b3b1e 100755
--- a/tools/perf/python/tracepoint.py
+++ b/tools/perf/python/tracepoint.py
@@ -9,7 +9,7 @@ def change_proctitle():
     try:
         import setproctitle
         setproctitle.setproctitle("tracepoint.py")
-    except:
+    except ImportError:
         print("Install the setproctitle python package to help with top and friends")
 
 def main():
@@ -29,7 +29,7 @@ def main():
 
     evlist.open()
     evlist.mmap()
-    evlist.enable();
+    evlist.enable()
 
     while True:
         evlist.poll(timeout = -1)
-- 
2.56.0.rc1.310.g51773c2048-goog

