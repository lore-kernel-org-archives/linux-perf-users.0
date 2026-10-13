Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2486562607
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 22:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930411; cv=none; b=IyNK1HYy6XIGWGsRCK5qmGsBMlkU0ChP+mrDzCZ8kaGGqR9OcFQIuvSslvcs0uz028yZ7fD1SmEJ7BPyIQ5rsltFBFurCPkma8Vq6j5OiSi8+YELIcHAngEryToA7otSasHtkGgA/eaBbr/BAQbjfK2mIVXoNPT1aiVPfaPS+14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930411; c=relaxed/simple;
	bh=ASSO9Yhh3x4l2aj4p4LjjHkOJ/UB3ZSeE8UNpeDAMHA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nLbIhiqAN+JZZ+hRMSEtauf8hwZDb2F4nyrL1c+RYcjVt2xP5cVQh7AwH0XDKrV5jU4SZQHfU4xalCY60Jk8is/0u+rB2cS7yr93wv/yx7ssQRBQmwJFZPn8p79Lx3Zw12mbih1fI9XX+84c2Lz0JCk2miF1hVCi5YvB4J/57lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FYWn+rBX; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FYWn+rBX"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-152d1363a29so12851270c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 15:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791930409; x=1792535209; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vK8eM9wlcN4Kfzlfrk2Po0YSpGR23CvMBC4OejD2aUs=;
        b=FYWn+rBX7g8gdvYD005gY3CsGJU0m/aniH1dQI5voYi1XmtthlfvysK5zrdSmzhJ/P
         Tx+QA+Dt8lcdKggt3e3yc4B6rjZr/NQ/Gq+aVrA3ZYhNuXFYqP/rlPcyAhxjIHjZYoK5
         UGKYQoqCMYigHwwcAiyLWXPtr0q1qvOXnzkO/EGpvRQMt+ZKS9bG+gCDqbYbGuzGfEMg
         bT+w3R+GCOgpxG2uROqQ72zID9e36Nlt723nrZmUmy+Z+w4YFrewLEB2pTDqFOvWObdv
         ReY0RtTAuXuLrILPSC3XV/YiRqvLnOMIxqoXgBXPn6iHyWiUbWHd0aNSkyp5gPG/v0DR
         EUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791930409; x=1792535209;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vK8eM9wlcN4Kfzlfrk2Po0YSpGR23CvMBC4OejD2aUs=;
        b=nt3tGA9u3A5+bXfwj/dMwzjR5z/COamYUEitgN1I6NETPkcJmZT+ZX4n+B2R+w2KCn
         gmsC45LKWfi3p1MvbEQa6CG/sgySzEZxuTlHOxv8CBhhHUG+xXSPx0kjP06OGqWkY1Xk
         vzMNf3ZHDiSjrgEGxqqafvYlQ2oU/ZoJVtTtqn7xT35txVKnuPjZEh6S6vTjDTTinIO6
         f13SnvdZgOPUx2wiiQ2C1rlIVOhs+yAQI/oXxYWamJiJd1zzTH7vYlwkGzw6l6QnOY63
         vdZKXR2d2TvGJb183j2phia9uskxFvtQq34qc2UzW6cRRnQ9izmIUGiunvQXEQ96LHiA
         06cQ==
X-Forwarded-Encrypted: i=1; AKwUvBw7Y4gN5HCo9AC1Z5UzAY8jpfGXzBH7qtN6k8JTeYHbpYS68edPJVCwF0FDGQPDY9bR1xlSZDtdevNGmAMaP5Hc@vger.kernel.org
X-Gm-Message-State: AFq9FYKtjXOzCvtH6FJkd6STdhCSfH8mu4vwxkxExkIe4g6izVDxw/n9
	b/j9q/p8A824OVpIladb1WuQUOBB1cKO+a4mVEOpS3gAWatLhA4zBB2GIDVAfVueL3jDzv1tDLC
	4YdmK6jSX1Q==
X-Received: from dloo7-n2.prod.google.com ([2002:a05:7023:a47:20b0:168:9e52:72b9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2309:b0:14a:5284:1bff
 with SMTP id a92af1059eb24-16a5f4e8824mr22840937c88.34.1791930408253; Tue, 13
 Oct 2026 15:26:48 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:26:17 -0700
In-Reply-To: <20261013222622.1822619-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013182458.1234616-1-irogers@google.com> <20261013222622.1822619-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013222622.1822619-6-irogers@google.com>
Subject: [PATCH v2 05/10] perf build: Enable additional Clang thread-safety flags
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, elver@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, james.clark@linaro.org, 
	jolsa@kernel.org, justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Align tools/perf's Clang thread-safety flags with the kernel's
scripts/Makefile.context-analysis by adding -Wthread-safety-pointer,
-Wthread-safety-beta, and (when supported by the compiler)
-fexperimental-late-parse-attributes.

Assisted-by: Antigravity:gemini-3.1-pro

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 39442577418e..a5bd160c03da 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -64,7 +64,10 @@ ifeq ($(CC_NO_CLANG), 0)
   endif
 
   # Enabled Wthread-safety analysis for clang builds.
-  CFLAGS += -Wthread-safety -DWARN_CONTEXT_ANALYSIS
+  CFLAGS += -DWARN_CONTEXT_ANALYSIS -Wthread-safety -Wthread-safety-pointer -Wthread-safety-beta
+  ifeq ($(shell $(CC) -Werror -fexperimental-late-parse-attributes -c -x c /dev/null -o /dev/null >/dev/null 2>&1 && echo 1), 1)
+    CFLAGS += -fexperimental-late-parse-attributes
+  endif
 endif
 
 include $(srctree)/tools/scripts/Makefile.arch
-- 
2.56.0.385.gd3acb90ef8-goog

