Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792700123;
	b=AmnZIPwtMj3iW63jKGgUPY0GvsZt5gGOQarhojX2REJ6X5eA9BT/O1zH6sij23O1ZIaZ
	 4b8qo223OdG5atMYlkX5qKg69rlVxlcLn+encPTcVDdpRLuw+ppbn4DmMx24/9qFN2iYk
	 jTsKh3eeL/sdBwtsf20qADC9KmxpKgalcw+53XGByLfvHIVJ1ZDPSWfuZlXKCgDKHoNSF
	 8zC8benqwQ2kTlGZ/eXy1wZ4hl5lvO+mppIZQWpzPLgBNyW8Lmdx0uXdnUmaw5Ve6HtYH
	 Z1+PiDLzpJnvln08yQFVZ7qKRX2OSHHhWKh9514IMNJvrVtCmu/srOsTpTbRXP0ULSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Bm5F5L/Tc7r70KhD0cqJblZLBdriiRHdrl4SVSE1UvA=;
	b=QxepvTTHrZhg2vM6fF3WdwmoaXTgirXND+nSQFFYEAAN6UqNGRvwF9pVHPORbh0yL+J+
	 +uamzkFus4A2IeqU7q7rxB4Lw9VO1hy4xms/pAc7MHSWwTYm/CKWtLotp7XJDNcIOfq4n
	 d5BY02C8kvSYuTlk1TZ//ipHvcZI9OQ8fTK13uP69zcIVycIbUX6rjALkNbcFT2DFlr6U
	 0dFHAuCPrEe5XUV4vZ4UN/pWn/W79RTL3pawsO/tGI4gT1LGBbSKf3Z0xseMvMs4zFE3e
	 vADq0qh1zzNZoGGu+eBoeX/St0s6sJjJEnJHUlpHMYv1+ID4lJhjY0uTtkNt7fap7Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Y1ViIcr7;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE19606A326
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CE19606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Y1ViIcr7
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35c3c370b17so306559eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 13:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792700122; x=1793304922; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bm5F5L/Tc7r70KhD0cqJblZLBdriiRHdrl4SVSE1UvA=;
        b=Y1ViIcr7Z4Ei53rNSNxXvhYmvT5mW7KS5XAe+/ynQIncC3u+IskaWAgLMAHpJlgzQd
         UloJfTCve6ZGxbXukIUqMsihjkHUyRLLhyPkOIgWnyn3+VCRU9aKn/7SrVLKqwyaMdot
         fUrmkanM8RB3giIdrTJxhD/PmoFjvWmddyA017AY/NSAHC3woCWtc+Fazims0eoNwT21
         KynuyscKt9bD+dIXvxQOpjVolXmwURxh5EAlxvCecaRQ1UyemvaPZ8qLKoCRvmkYtVwy
         ncCFjGEGpuO2RjiwfUVE8/VK2NN3bsG/uJmpk3G9z2xLq7yppdgDQoz1rvf65W3nrHTU
         ShDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792700122; x=1793304922;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bm5F5L/Tc7r70KhD0cqJblZLBdriiRHdrl4SVSE1UvA=;
        b=llKJ1TJvKPNGNBpzAfuKwzEM93juC/ddk/zLuWMLq4wc/LHNV6AsakpTKx6nMUWk4P
         1oIPIHJT3qkqZvAaVNwefeLBYkIp8Ni0TjCwN16AfdNb7CwIbJvs8pEIm+xAwCIrIfzL
         FDYRRfXofi69GQgJr6T3Hg5VHlT3F8y/Uwj4S+xVOwb9a6N1GzgxBtKyCpyAP6pEvlbv
         wBj0HLpqWA2jfuc83kq7Zk3O78aZcXZkKW3r0+bvWcND7HDpq9uF0jMlYIMXz5ZiuM45
         /+tUf++sXvQqZYpdBEWa3gLMJSa4iED0Dv3JTus1orILHjmu6Rgumkag/yV8D3BBceTy
         hwYA==
X-Forwarded-Encrypted: i=1; AKwUvBxAo5ruM6sdo0YltujuINU2HhFVYLiK3iKKyxBGUd7ivRLrk6CpEDC1mY5Tb9/aX9sUmQ36sZYZny7CYwgPljJN@vger.kernel.org
X-Gm-Message-State: AFq9FYL9MfLB5zVBOsgqszdI8qmtVtYYxTWa//Q/6nZFO4Qsbr6xoZRR
	+tXA9KBaqdIl3C2/yffRGx4A9bwjrD2qNQMqpfIEyhYMrafcDRp7MraS85mUVt/9M7QW3m1Lu2g
	xKeIt7sPLiw==
X-Received: from dlbpu2.prod.google.com ([2002:a05:7022:e882:b0:166:1a44:a89])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2302:b0:168:3243:c91a
 with SMTP id a92af1059eb24-195c44b7990mr296334c88.13.1792700121995; Thu, 22
 Oct 2026 13:15:21 -0700 (PDT)
Date: Thu, 22 Oct 2026 13:14:39 -0700
In-Reply-To: <20261022201453.1717523-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261021223905.715051-1-irogers@google.com> <20261022201453.1717523-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261022201453.1717523-7-irogers@google.com>
Subject: [PATCH v8 06/19] perf comm: Add __guarded_by annotations to struct comm_strs
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, elver@google.com, james.clark@linaro.org, 
	jolsa@kernel.org, justinstitt@google.com, linux-kernel@vger.kernel.org, 
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
2.56.0.307.g5fe7bd680c-goog

