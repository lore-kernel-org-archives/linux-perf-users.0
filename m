Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A156048DB37
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 22:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792189107; cv=none; b=XGeGHCevGv8qvUsIJ7Z/OEWMWuoh98qRKN5XGZyAK5nwEmSPg6KOwMFlbNpLpK/GgaSjhMEJwL0pdCmPLg6geyY5VoEsH07Zi/eWxqrU2pPkO9ySdbzn4OMt/pyeLrTMhQ6ZY2LdbGxxyLGU+cLmeEw34Q537Qk4jlIJpYL/NBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792189107; c=relaxed/simple;
	bh=NHNHFzCRJCoNjfCgzgh3uLdZFtzpAhqYSL5RZUodvIE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kxxqywnMOnQQEU/m+eehBpUaCGemVSd1TliWS6hrJKozW7bKea9q9Jl2LWLs6y9NSzf3FAsr0PoVPgkv+930stcQsAFvMit2Cn+YQW4KSbdovjvw3B4rqfT39dJKiCbZuaKlJB7K86HxMm2g/lxdcz6p0lGe4AIeui4nfHW1Cno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hTiKXJRE; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hTiKXJRE"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3510d0baf63so864247eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 15:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792189106; x=1792793906; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0AxmQfbpaXJI1ahn+7h0PxdePVBkvh19toBGNbRn6vg=;
        b=hTiKXJREtUpt3xJ8AY035MXikWnElXJM3udu1q9KBaKPn36PonmTM4S16L2L/A8XAk
         anUWPr+5j7/qo4yabHJAnXsNW5WVHyeffmio/lFPEDNw3t/KbjiIDGchyeLAdc1JXEqq
         x7wLmqsgGBjfuearJMbpjy/Y5ehHdm185hCsq2RFGOt4DfWAkWL/YsafS4sdIGtovAQi
         Yad/Z5UgAFXdo26kxoTXrAJbeI3gicIMfFOMYDiCLN1ekUZzBe0zYz4wluKr+cKegMND
         iEs9kMmpok7z3blpOpgIedp3tudbDZPLTPwJyHjWdPVMy46UN4ARAYh14op94QoKtcbr
         swTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792189106; x=1792793906;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0AxmQfbpaXJI1ahn+7h0PxdePVBkvh19toBGNbRn6vg=;
        b=fyGAohMt6Z2S6NuCIu3lbatBPX8RYD97uF1cnyvV3IKYb6+Ix8Ffqug3NPcu6iMwIA
         mp4U1xrzivD1jRkhMk5mGxfqRosKA0fqmAsEGULG51Z1DLk7okmmw6cNJvRLcgT7WkFr
         wf+GozfKtZUPblP591F68q8Ce7qQ5fFCFaX03YNIsW89ZzjsZp+tZ6O8LQ+t0q0gR2Ns
         Ep3TuOPqKZnQuDROQUgAS6AsR4q58snZQ+lCqmuDofk7THnDvapHh0W88DkyMYkaZfqV
         EPkvFT7lQsrFB7lWuIo9ETP4RDGL4LL6xMcHLP2x+Ywdlgyz+inxB/mmvD+A1wkrtAGQ
         Hd6w==
X-Forwarded-Encrypted: i=1; AKwUvBwl/fsblsS/Emlqk2yH+YhwAPk7J/KqRvb5VVPreM1cldOQJa0+Uq4jCwgVLqIfhrVow8QCWC5QWd2PvotDgI6H@vger.kernel.org
X-Gm-Message-State: AFq9FYJkSyAGCVnmUBpujHuB8HBt78aWJxWo7TpbINuhVzmxy333xTUy
	K57mpkTnMfUa6+7qE/6r5AK3DgbZLkOwjGKJGIaDfJaBeV4+VOE5s2JNZk1rvp4i2gpPTfo+0ff
	4sY4YvPRjag==
X-Received: from dlah10.prod.google.com ([2002:a05:701b:260a:b0:161:fc1c:61e2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1508:b0:143:7001:7645
 with SMTP id a92af1059eb24-185151be2e3mr1523967c88.47.1792189105155; Fri, 16
 Oct 2026 15:18:25 -0700 (PDT)
Date: Fri, 16 Oct 2026 15:16:49 -0700
In-Reply-To: <20261016221700.1282659-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261016173106.679725-1-irogers@google.com> <20261016221700.1282659-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261016221700.1282659-7-irogers@google.com>
Subject: [PATCH v4 06/17] perf comm: Add __guarded_by annotations to struct comm_strs
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, elver@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, ljs@kernel.org, llvm@lists.linux.dev, 
	mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Annotate strs, num_strs, and capacity in struct comm_strs with
__guarded_by(&lock) and __pt_guarded_by(&lock) so Clang verifies all
accesses hold comm_strs->lock.

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
2.56.0.212.g129ede20d9-goog

