Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF5925A62C
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 23:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737071933; cv=none; b=pe5CCMv4rcmS6gXoxUYuw+h9DaRP/87/V+TTGBmj+ae/gQYbtLNh9aq7Iji3Roefv2WC8yPOrBLiEUSxjXhy1oyZkCMFnKwaGC7vf8PLaRAdIw8J0t5ybllvZSkk1ZmQ6HuKoiLRXMYkwWyLsfyqIza0MRPIkmfkO7+EAwprq28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737071933; c=relaxed/simple;
	bh=JkUbfWyKQ3qRVDlCf2dDZ/7AWhRjy18Vy4cw2FH7YL4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kYmdOeLsjJW5uaSSJuWYnTMdG5203ZiIbvekwq+1+ENldiBTYfX5+NpqhYr62//Wt4lHH4o3gQGkyFGhxZRh/AR++TroLczAgnVYBqaY1ThGzx4ZdQxSfFLzw+EU3t3mcyN6BeoZANLtHXpERebwqRw+VUfpKODN6yoMMxNDESM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LK79GZSI; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LK79GZSI"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2166f9f52fbso40466645ad.2
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 15:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737071931; x=1737676731; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6V4zUr7Ix0DUJFYh/9G1GZtvwH2kVS+xa9A8xIpge9k=;
        b=LK79GZSIDNrEO9u5YrVGZgQp5xY/wFlTKHFkLydw22FA/cBNW8AOeCH93X+QI8bKgy
         YAQgoXOz2cBsqPDjHH1DdjpB8AmXIA30Siz0f53f0LFsDr7gaGWPFJCWTpVPHOKyNBSZ
         a8FnqU34Axcc9q/P/1Lrmr5nV7HXzEVVhUHzx/A0+ZBgQMN/jcLKn/qfivNJmzcK2lq5
         lcQRkCS8i/ZaSd4ClXRmIDJgFBCbtG07dYiIbsTHbMA+VPC7XB5IOraiA1LPGAvci/F6
         m+kIc7+EfTqU3Tjsf4TtTq8Yl+bVKPLr2EPK131PSQ8CuZM/NwpKar+KculthN5gL5i2
         cljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737071931; x=1737676731;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6V4zUr7Ix0DUJFYh/9G1GZtvwH2kVS+xa9A8xIpge9k=;
        b=D97M7wNup8SSIXIUMeREwnPuin+0zJ2KRPAac3ECb+EzEhFS77MFk5YkQDFx55p0VA
         wdO6egtN/QzxpFvWgfSnNIXC+KhoSXHlVqzn4Cq+dFxcuJXQi/QsTNm4/WK29+O008Kx
         DUTsG7qF0vlJvZD5Xce1GymfYU4/HeS0RWm+VqgFTCYXVKHgTprjvKB2afIOH7HNh7rT
         idZqHIOGW6kX+eJzgnL2ldMvAwZz05dLpZ7wTTiavhSu2nkrGK0WaECQ6AXJ7ay7OZHI
         5LIDsKsllqvh5E/1HWsoIzBJ2V4KN0v9QSrLJ9GeK1QxW1G1hrrmdr9l476uugnj/ZYC
         aXGg==
X-Forwarded-Encrypted: i=1; AJvYcCX1egjDA2gUxBrs50XdUkRSEiszcPnggbsc3KSf5n2A+bUG2Bu3b6Qvrcyio3N3Onm4EB+jS4v4mvSIpyaYmUxk@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ9N6tqtYPQpL4Y5FFv1P28sbySdJEynPqec59jWhDzNJ9gMKh
	FeF0h9uVqSUNN7V+fQ2Fd9GoB6QGn/7rumJ9qFEc4LaiahGteooCSJNKiixKXAQPVY4cfYJJgv1
	ddA==
X-Google-Smtp-Source: AGHT+IE/D86QCa7yV4AqkWchM60jeczpvNj+SJkivymqx+VkKv6Dljn84lEJrirUURb4u5QeHEEoXmpsNqM=
X-Received: from pfbhx8.prod.google.com ([2002:a05:6a00:8988:b0:725:eccc:e998])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:12cc:b0:1e1:a0b6:9872
 with SMTP id adf61e73a8af0-1eb21486765mr923247637.11.1737071930968; Thu, 16
 Jan 2025 15:58:50 -0800 (PST)
Date: Thu, 16 Jan 2025 15:58:15 -0800
In-Reply-To: <20250116235838.2769691-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250116235838.2769691-1-ctshao@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250116235838.2769691-2-ctshao@google.com>
Subject: [PATCH v6 2/3] perf lock: Add percpu-rwsem for type filter
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, Namhyung Kim <namhyung@kernel.org>, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, nick.forrington@arm.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

percpu-rwsem was missing in man page. And for backward compatibility,
replace `pcpu-sem` with `percpu-rwsem` before parsing lock name.
Tested `./perf lock con -ab -Y pcpu-sem` and `./perf lock con -ab -Y
percpu-rwsem`

Fixes: 4f701063bfa2 ("perf lock contention: Show lock type with address")
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
Note:
  Rebased on tmp.perf-tools-next

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
index a6203c622967..258c4ccb96af 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -2265,7 +2265,10 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
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
2.48.0.rc2.279.g1de40edade-goog

