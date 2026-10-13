Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374975349CF
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 18:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916006; cv=none; b=sG56EuvpO8dMPFjqnqpTPPlPQPdqrffIhdaXrArP2uxaw4M75xGPKcCL2p1lSGlJ1c48clMlSMps0IpjLB7fjGSnyXuj1GmhZb2Q+ufBRiRTSos2NjpTDGAkwrJW0MZfazcr5m8YzGeMTzCXFsvZgTLNwNNfsy+ImqVrl/AHGmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916006; c=relaxed/simple;
	bh=qz98LWjBN7vuyhktaur2iXpicZss29gzxpSAse2Me08=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pQBGKR+hNsINxMTPZLRCX5TNkMX5+lP7jZ+AZwiGy2PmMcqZzBnCjD9deTVs9WQNCvyWIV3J56mJb3451L6t0WCO2Phx2BuVF5Uh/zHpB2I2g232cwFCHNQJ5cPMi63VJsAMk1sm+6H7CcpZdoumctEc+jrQxB+Ye77KFqP9DPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l+IC2EWb; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l+IC2EWb"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-35c3c370b17so2029342eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 11:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791916003; x=1792520803; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DM2MthsEYIVhdmp2494m0lpQjS73jUhrnW6tHHeF46g=;
        b=l+IC2EWbD+VLpNPknX3l9acwQ9ZwypSJDsqfo7wmzMEJFrPClhjgiyrgx3akzdAron
         9gFUG8VK32e0XXpwURrWxf6SSYhIwRIZiVnXkxuiscsvC44Kw2HevCFTodM5bT8RefL8
         WJ7hc6zp30WXtonCIe7yQraxzj/sAtUbj5Zen86WssLkKb+HkGv7BxGW//obhq/mN4GP
         jWuUPK5tWBS/QVujow55ZQqTKN+320JvMHPTzw/plIox9CGQgiI58a/sdK3t+VJDwZMG
         W78w3tnQc2h24Kzn3Xf5DlhRMP626XcmQQiFdKjq75nasTDHmDUDFZuWyO2+iBtrGFV2
         yvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791916003; x=1792520803;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DM2MthsEYIVhdmp2494m0lpQjS73jUhrnW6tHHeF46g=;
        b=w2IB4OXKL6UY+1TuzIudauz7bbOSsaTOWhQHgH+486fAvOlIUpvdlzkIut/W+IwFvR
         APhzlI/Nf5AnC1ZqAzhBtOJ2rqtop5uL9ZyAHAdpubVQj/9v0zy0XC1EonTLh26MZwH3
         Rytz21BbSNxMDzkKyt4TlDHBeJo1UJU0tfNVxhPRbaJ78gA13A7/0gUUZQL4v5sC+mjK
         HV+9CN8e3SYaGN38NPa4ddd1cVR4NA03E/n0JTb46A7B07Pf5seBmwV1zgR6smT+dzxr
         lp1FSWWHchstIOI17kSiPgYUAGlBkgkFwjTvy1CHMY/4TK8U9isniZjstzfjFZ0jffE/
         lyYg==
X-Forwarded-Encrypted: i=1; AKwUvBxPN/L6mAsKdclGOlayXTIlM3MHGoMrbfAC7SuBCs6U/yrDt3unnjTZ/dj5s44MC1tnDtSJhEHY2vIPA0ppdNvf@vger.kernel.org
X-Gm-Message-State: AFq9FYIFCK1BwFeAtzzqAIDzcdBqXzZX53xv/EgYapE+5xzucreTStUY
	JIRtX8qz1d1fRJQKo4ggI6mzVs49OkrzgPZLnNsqtX3Qd8KkiIP6dtxdJr+PCGFKi8X2tuRV3Px
	y2rJOWK3JBw==
X-Received: from dyah25-n2.prod.google.com ([2002:a05:693c:83d9:20b0:359:72f9:2aa7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8103:b0:34a:fc46:35ba
 with SMTP id 5a478bee46e88-3537dfc6e87mr21326454eec.8.1791916002804; Tue, 13
 Oct 2026 11:26:42 -0700 (PDT)
Date: Tue, 13 Oct 2026 11:24:54 -0700
In-Reply-To: <20261013182458.1234616-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013182458.1234616-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013182458.1234616-7-irogers@google.com>
Subject: [PATCH v1 06/10] perf comm: Add __guarded_by annotations to struct comm_strs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Annotate strs, num_strs, and capacity in struct comm_strs with
__guarded_by(&lock) and __pt_guarded_by(&lock) so Clang verifies all
accesses hold comm_strs->lock.

Assisted-by: Antigravity:gemini-3.1-pro

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/comm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index 6343a3c9debe..9fc4e91a36e9 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -16,9 +16,9 @@ DECLARE_RC_STRUCT(comm_str) {
 
 static struct comm_strs {
 	struct rw_semaphore lock;
-	struct comm_str **strs;
-	int num_strs;
-	int capacity;
+	struct comm_str **strs __pt_guarded_by(&lock) __guarded_by(&lock);
+	int num_strs __guarded_by(&lock);
+	int capacity __guarded_by(&lock);
 } _comm_strs;
 
 static void comm_strs__remove_if_last(struct comm_str *cs);
-- 
2.56.0.385.gd3acb90ef8-goog

