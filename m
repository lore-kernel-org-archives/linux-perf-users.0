Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3B34DDB4B
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013458; cv=none; b=XdVn89K+7wWd1LKMTvhazj+ZBS9tJq8ADS4F2cWtY9En5+GWxDo+8G7r8oLKNBIdq9VmPUghy+PwPaC20Nohm9olPyWmaNLQ62Qtc2uNzGAq3G5nkBtvD2VgRLsRSXUAdSD0hh0TNGjvSqAgLdxiGKrp2lIGM/lYwzGZ7UFn/As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013458; c=relaxed/simple;
	bh=l+3CUvL3dl2lj3lOxcYxDwPAhR6R6HuJ1c1ZmhV+120=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H02OusKRUrzI8/h2b6UUjqw7EYy7ggT4lv+aLikc4bQqJhmrhkQaTvz3arxRwYcdLEhpAcdzU5Y42Z79kZoFeyh4m1pePZ51Evg2bt1ndkSfUv2QNSUfVPUM5N9nrUg2RvnA/Spokn8Nov840AcSqodZpHSDmpxUyy0oQS2cbII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uZDdSkHL; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uZDdSkHL"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39e3c10ac70so8203491a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 10:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790013456; x=1790618256; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iuhgegRfPLxNyO6FswC61vQ7E3b1jvVhOXN9nTT2aUE=;
        b=uZDdSkHLx7GkBgKlgd91hwInKCy0zKx3eM/Iy9XqVF6wLFt7EO062N5YYgR37ZLpSD
         zF7dbsFcniLgKFeAcXTZMpQFRunbwvdpxYmo+N+NmCm1lzM5TUF07SudOW9WGou6SZV0
         wlsxN1Fw9mNybACh9RyXh650FygW/7QWNueDLWd9vlNiCRHV0uk4xN9tZhWatguXw+R5
         K0BDbPg/tiBClFih7wxd+QG/KaaFZawZrJliGSFiRT592EpW2TGMmx/FGa1JYHPRejUo
         B07TvSru7QWiR2TrHRduUc+FRj33hYVdQT6v0J+kkCcpFndddEeJHAQOHK/ChTdST0lb
         f3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790013456; x=1790618256;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iuhgegRfPLxNyO6FswC61vQ7E3b1jvVhOXN9nTT2aUE=;
        b=By+T4hP748EEpZvT73XdHPNMyuGqif4y9jPS+3Z588Nr+MNj/+F5xJxp+nqJ6GONzv
         i9mbnM0wGugeO0g6xDyEWZLSjVXFPlU/HFa+ctg1YM2Ih1TuzMXouuspf4mTIT7G/i3Z
         x96DOQqMfUr6OakhxgoHnUWpeHyc50VKDfnHtH0vsCDS6d8mWSYDrbZyqfp6aLCfTKqx
         VF0N45pZCoJC5OVmLID6nSLjaCsD6iEq9tTD1SA5YiE7vr+zOBM7eLybVhP3EskyCdXb
         tq+p/Z4IO1xMca5dET1j1kgb1KgV6kxnWEJnqoJQR0OLAzyXS6YtR1LFwHSFMCDkcM5l
         fByw==
X-Gm-Message-State: AFuF++mVmK86uTb7YQ+RKGXDYAhpjnCS6sn8HGqEpkn029BTHskvsQdy
	0137fsmZrIvEUUEqCZqSoA/nvUAjT4u6Y+dTII8hoev2Ti7M0na1931uFpqIJnVfF3mmWGUNbU1
	2BL4EtwOs5g==
X-Received: from dled15-n2.prod.google.com ([2002:a05:701b:42cf:20b0:144:e4a2:1056])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7cd:b0:395:7fff:a08f
 with SMTP id 98e67ed59e1d1-39e549bd704mr17216532a91.0.1790013455164; Mon, 21
 Sep 2026 10:57:35 -0700 (PDT)
Date: Mon, 21 Sep 2026 10:57:18 -0700
In-Reply-To: <ag8X7gcDw6jpJsLq@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ag8X7gcDw6jpJsLq@decadent.org.uk>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921175719.846883-1-irogers@google.com>
Subject: [PATCH v2 1/2] perf tools: Put Python egg info in output directory
From: Ian Rogers <irogers@google.com>
To: benh@debian.org, acme@kernel.org, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org, 
	tglozar@redhat.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ben Hutchings <benh@debian.org>

Installing the Python extension currently creates an egg-info
directory in the source tree, preventing a fully out-of-tree build.

Add the necessary runes to the setup.py comamnd line to relocate the
egg-info directory in an out-of-tree build.

Signed-off-by: Ben Hutchings <benh@debian.org>
Reviewed-by: Ian Rogers <irogers@google.com>
---
v2: Rebase
---
 tools/perf/Makefile.perf | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 2438b40eaaec..438102bcae6c 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -908,7 +908,9 @@ install-build-deps:
 	$(Q)$(SHELL) $(srctree)/tools/perf/scripts/install-build-deps.sh $(INSTALL_BUILD_DEPS_ARGS)
 
 install-python_ext:
-	$(PYTHON_WORD) util/setup.py $(python_setup_quiet) install --root='/$(DESTDIR_SQ)'
+	$(PYTHON_WORD) util/setup.py $(python_setup_quiet) \
+		$(if $(OUTPUT),egg_info --egg-base $(OUTPUT)) \
+		install --root='/$(DESTDIR_SQ)'
 
 # 'make install-doc' should call 'make -C Documentation install'
 $(INSTALL_DOC_TARGETS):
-- 
2.55.0.1082.g2b9226bbc0-goog

