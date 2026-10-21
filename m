Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622371;
	b=kHjp1KWyq6m5XQamDkbnvd9ccCOUs6kEYfv0LA18Ox4NPmO/gOGkd1dfesfQmlSmORmF
	 oHsp2faVo/6JokUYlw2+xbZqUUXzBxjIMlKfX6LTUCq+u+hD2r5RnNHp52MrzawRNKY7k
	 GG7Ito2vtPTnDR5pckj/+7KGPAiuCgBKb8c7GhCza6nbQqGvXzw3P5UiNSWrDy4yvkgzt
	 i/PB97MQyxBZCQurnTCdwM5Xyb7ig/I+kOYnIL8WbK14J1uuWIvEKCpH9F1Ziy47Yxpvj
	 GtjmIp4lADDKuzgFNLf0T6WtepeQ7YIPDLKOca62BWMSNf0aRO3DyOgVueua8YBE3OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622371;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=BGtpnjqbgsSI0YGAfALssqGviHqvt2+cOYL3HWLbbPs=;
	b=cSAii6n+Nnzf3mi2yiBbhWTyqgEOBPTH/3ALvnCRHtCi6s42IxjtEQAvASfsugGgs1LU
	 0UN7BIRIBtQ79K+CsNpfCvEx6mhrBOa0IvOHhcUUlF+iy/0GhRF6WymZQJKKOVMwJAFHj
	 9tws3rKooFrPvcOfCbnU6E8w8LQMEOvbvwtdNmJmEOo0FIC4wW9DYTm80BWYGgCjltKTV
	 gGfKL2NYDAKeqCrU/G3fbwkx0MLdBqVIxVrQIQtscXx1Msk7/4izIeI+ovH1yrKqi8WQ0
	 Lu/EDMpRKziHJ+fJfpUoBz2VtoTcx5T39Cg87yQFBIZTGJlgIW3ITsJ/Co3dntRqVpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=msBwAe2x;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC72B606A321
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC72B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=msBwAe2x
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-366c279b454so2378794eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 15:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792622370; x=1793227170; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BGtpnjqbgsSI0YGAfALssqGviHqvt2+cOYL3HWLbbPs=;
        b=msBwAe2x3k58oLvMlW67MHBqy4MJRpV4zP1Yx2wD23QcZEwUNE5QlMr/POOC/rKPq3
         eeSXzkEjiyPIxtn3e1FK+3NXVQwQ+KePbhowQoUbIICqc0AQwPh2lC8t2c+MkbvxrAGr
         isNoh1R1W80SGPgIlNzi3EyC66EO7lZ9KvjfA6IQ3k79HUs4tmikxlRB7D0m60lPy2DR
         0HHSOABuPOMhVSALbd35Rn+L04tZxK7HSk/hrZt7YplCS8dw/FmGUyyiNu7um3gDA1Rn
         /ZbYTLVBiS6yYHhXlUinPPMchQRbTohr0sbyBH0BBrEhMCBvVMSeLv8LaWS610OoONm+
         OJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792622370; x=1793227170;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BGtpnjqbgsSI0YGAfALssqGviHqvt2+cOYL3HWLbbPs=;
        b=OfoHQCP5xUQnUX/IcE8WJOvkFV1oBAuOqjIzORvVUiuInG9WwqX6rvz0UPhL63h/UG
         1/W/7ukw9JteM++T2/13tPyehcxST52JovUSewc3vNLYjpqs2+h/l9uOOV7EpoV+TZFw
         jOZiTJik/hQB/GRYCUaLtTZwFd1J1ABGgN/dFeekuincVH58Noz0okNOQVWcFcHyRgci
         oSWTt4m3MVYQveEL+2sop8WQZw/mO3rpo7Xi5klZoFLyt7sOuWt+fKDWbSVf0knpxjQd
         YlqBBrZZjN7G1Q7pgQfNh6RPTcOvdN5TpIk/bFKPkXz1NMPX6JL6S1hJf37RhVFX0eVw
         03qA==
X-Forwarded-Encrypted: i=1; AKwUvByNmd0qZuK2kAldpSOYDEzyK4eEsUZk1HT9YaedHKOLfeqyGeszOS1sbdCIbII/e2BAQWiDYJZuTXdY5DIXweTC@vger.kernel.org
X-Gm-Message-State: AFq9FYI67lZLYpLbD59npi37Z/3LuFVSFszk3pm2Q9zDGnfnxJQ/AREx
	RPD+HKqQTOmKGahdFqtoSLD6t288Nbo5FzizNzp4EFEeJ8wrVPDFW3Bfe1WoNcDPYu0PCwJW+K/
	D1675/BPi1Q==
X-Received: from dly10-n1.prod.google.com ([2002:a05:701b:204a:10b0:15c:a5e1:a591])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2810:b0:14c:d8d9:9502
 with SMTP id a92af1059eb24-190a52dcc93mr3712312c88.14.1792622369768; Wed, 21
 Oct 2026 15:39:29 -0700 (PDT)
Date: Wed, 21 Oct 2026 15:38:54 -0700
In-Reply-To: <20261021223905.715051-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021171044.155240-1-irogers@google.com> <20261021223905.715051-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261021223905.715051-7-irogers@google.com>
Subject: [PATCH v7 06/17] perf comm: Add __guarded_by annotations to struct comm_strs
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
2.56.0.218.g1ec904b173-goog

