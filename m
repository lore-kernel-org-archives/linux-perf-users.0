Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86265226862
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Dec 2024 20:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733861350; cv=none; b=Xel9xumv0GwBaqrr8qGE+mUFYxa7I86KT8T1TMh8uLbkZFWF2WIb+s6Q1hiA6Hz81Nu11SnO7ykthggnirbqw4fz8DbHg9aMLDXBHq9c9e0c1RfuO/58SMr5Mf9+gbAW6aElsa3pdZB7W5lEo3a/384oEqxD3xEOL8bHD0i6poM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733861350; c=relaxed/simple;
	bh=4TXt/fYrKAAtNwYRb9jxLFxe3AURh81Ap7PmCA7Zuko=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FULLir6vjGOucPcX+kJC8m/eDKcHk4PDem8+MGePn4PPLFlxqR9wL53+wyC7+63fR765aqZKqe4UTcEr7pHm7Fv1r1J6r0tcSI39CaPOlShGgwQm7Z7XvzLCNPOdXtbtH4eBCeIZIjikZMoF9ty8KE01v84QG/zxSV9/+r9/W2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MD+b6tFK; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MD+b6tFK"
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-5f06787ea2eso3970681eaf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Dec 2024 12:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733861347; x=1734466147; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YZ0TIlLsvDETtZLHTX5LiWM7DaAh3n/2WyTapiVCEOc=;
        b=MD+b6tFKhWnGjIpS1AEFaW/QCSTV+yZyCMnkJvztpARwKujbPC0P/LTqkFILpnuJoG
         1I8314ofGbHo7iFACabWPxjPVN8smr9OHwI76XbEPlHLpWCGoe8MNQH1+SvtXIXLhoml
         CyqG6I/CbVFRWgqJGiCO41JcZ+AS/UaNQBPB05Fh7ZvABUftltgv1tGnxJ1Lvcbhh6v7
         c3hxDwdJSfSYyaqaNOGuJvHfybm4ANnF7K/S83iq+XmM9nlrHBUiu4m3h0/tlrfO0ivC
         Z1T8KrRbga/BpkWmkDYVdaKH5TrL80fp/x4MMu4FOkkLgwr1mRVdHl6NmwWwvAGEfbLA
         W1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733861347; x=1734466147;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YZ0TIlLsvDETtZLHTX5LiWM7DaAh3n/2WyTapiVCEOc=;
        b=L4OdWefPE+fS4H10c/b44G1BLxerh5SQiJ10TA3kFcXb7Zd8HovzgfT8uOwJ06H1Fr
         K+4+VtcfCRuJBv3hn0duHtLdcK67e3zFSmmO8cfHJYfvkaugEbxvt0R/wvkdjv4ygIO4
         YuY8ho8DxNTJjB94tEb8oRgcFkseV/eh0ANhtn3hmggP6FkOpSaI+FCmrFD6AiX73qHx
         3j/MltrWWNx2BEyAuSIxEEKFQGIBxYAE+UJSDbiuTEyI/1uwz5luk/Km4unLiP6fH2Ck
         +nY65aM+3o//kRyO1IhGUnZbr8NiuVfoMW7SUc/rzilStbgqnWobwPeKDkfomHox0+do
         tRRA==
X-Forwarded-Encrypted: i=1; AJvYcCUnE/faalTy1cZl+4tiscXxgx1i3hwGZwhGmjieHzYsI6E32KaXyxefqiQ3ZPMWlXA4Hdf3vccr7RMRuvUjZ100@vger.kernel.org
X-Gm-Message-State: AOJu0YzX36BmGHBUgQ+v2jAdFe9NPI99n4bhuloixLh5UirvEQn61nGD
	R4hvwyMElueU1hSXmk9Nd+9DciisQUFo4UozlwntJkZ9lI+LnjwVykolR/6cuB5Nz2feLwLtEgY
	Crg==
X-Google-Smtp-Source: AGHT+IFedsnHWxoacSC2bWy7ghFMHZFBRW8dlqVBGCMQ6X3BH3cx8puBGgp+Q31QTB54o9jv5UpXKEhJyNo=
X-Received: from oabrl22.prod.google.com ([2002:a05:6871:6516:b0:29f:c26f:686e])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:230e:b0:29d:cc2e:8493
 with SMTP id 586e51a60fabf-2a012f3bc6bmr324133fac.26.1733861347684; Tue, 10
 Dec 2024 12:09:07 -0800 (PST)
Date: Tue, 10 Dec 2024 12:08:21 -0800
In-Reply-To: <20241210200847.1023139-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241210200847.1023139-1-ctshao@google.com>
X-Mailer: git-send-email 2.47.1.545.g3c1d2e2a6a-goog
Message-ID: <20241210200847.1023139-2-ctshao@google.com>
Subject: [PATCH v5 2/3] perf lock: Add percpu-rwsem for type filter
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, nick.forrington@arm.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

percpu-rwsem was missing in man page. And for backward compatibility,
replace `pcpu-sem` with `percpu-rwsem` before parsing lock name.
Tested `./perf lock con -ab -Y pcpu-sem` and `./perf lock con -ab -Y
percpu-rwsem`

Fixes: 4f701063bfa2 ("perf lock contention: Show lock type with address")
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/Documentation/perf-lock.txt | 4 ++--
 tools/perf/builtin-lock.c              | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index 57a940399de0..d3793054f7d3 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -187,8 +187,8 @@ CONTENTION OPTIONS
 	Show lock contention only for given lock types (comma separated list).
 	Available values are:
 	  semaphore, spinlock, rwlock, rwlock:R, rwlock:W, rwsem, rwsem:R, rwsem:W,
-	  rtmutex, rwlock-rt, rwlock-rt:R, rwlock-rt:W, pcpu-sem, pcpu-sem:R, pcpu-sem:W,
-	  mutex
+	  rtmutex, rwlock-rt, rwlock-rt:R, rwlock-rt:W, percpu-rwmem, pcpu-sem,
+	  pcpu-sem:R, pcpu-sem:W, mutex
 
 	Note that RW-variant of locks have :R and :W suffix.  Names without the
 	suffix are shortcuts for the both variants.  Ex) rwsem = rwsem:R + rwsem:W.
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 7e36bbe3cb80..50630551adad 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -2365,7 +2365,10 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
 		/*
 		 * Otherwise `tok` is `name` in `lock_type_table`.
 		 * Single lock name could contain multiple flags.
+		 * Replace alias `pcpu-sem` with actual name `percpu-rwsem.
 		 */
+		if (!strcmp(tok, "pcpu-sem"))
+			tok = (char *)"percpu-rwsem";
 		for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
 			if (!strcmp(lock_type_table[i].name, tok)) {
 				if (add_lock_type(lock_type_table[i].flags)) {
-- 
2.47.1.545.g3c1d2e2a6a-goog

