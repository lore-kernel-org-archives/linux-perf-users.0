Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE35152E00
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jul 2024 23:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720480997; cv=none; b=s3pwhdB02WKNpxdyGkIXF0SESKFpOUbIFJuvujl/vuoplRff93HqO702Sk4GZMONxemTvrshKbsJG1qiU+bor2511rYv3YHEbamxYBlfBtSjgxXmmOJaicGo8ETW1Kdhtwrce8y8HbaApyQBzzLhmL0kczIJq7wNK4T3GqP11uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720480997; c=relaxed/simple;
	bh=dKVJuxjCf0BQnbqMmoa6AIWyIAUk9r4xcxNXHBemsa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fkab8njJ9MtjZ/mQ9IscQVLjCbvCz68eyOmQi5Fq8kGFmft2G+3ivoUbxT/kkj+mylW6EqTqcmIW+Rkg94uJwhHAmsliqakQ5QzjOiVtn1WDokDSwJ95f50oJ4bpDr3vgkk/NzeG39mHuzbHD1HBtmWETlWFY5m/NZ0A0C6mctM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=R5dI8yCa; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="R5dI8yCa"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70af0684c2bso2763818b3a.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Jul 2024 16:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1720480995; x=1721085795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vl+9UgjBrvfTiNM4jLErKbUr93/lCxlDJ5aAiE7eoSw=;
        b=R5dI8yCa6A18z9ebzl+qHIIMyRsSEXv49WAFW4a8DIklcuUdQVZ6/3qInh2JPn2gwm
         lk1n40GMdgTV6WeSpeXEn0awkhOMungqerdNMy8RLAPcu+iBLYdJ2CrLh7IWj9nU+VO2
         cL96ZYt7oSHxLpBBygmbkOQVB7T58zowcgsDwLQckaeDEya8798fzSo85uz1Lh14mtfd
         swvuCSaxBuIBSawLHiRGwK9qFnY9iU4TXC8tAFjB8yCR8wJ0grNGgVS2X0mDXWVATmx4
         491VKlpFoBB9+cFIZInhAFeiyQGgDrZS//5cNZd/J0KWCkQw0ki5urUVjIOHQwpCFWu2
         Lgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720480995; x=1721085795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vl+9UgjBrvfTiNM4jLErKbUr93/lCxlDJ5aAiE7eoSw=;
        b=oYhjd5rN92DX4FE32U9+vif/nvcFJdTFhzxr5ixpPUtbBiPcE50OhFPmQf4jt0WJm8
         N0ppI9OSij/XZ+TCGwjrWc/rdaLWr47BEbMrtxBadtVC4dglZEt/4ajwbrgLtBSVC7RV
         OBiW8uw2OcFPX4q/1BryWQma+aZYDdseIzEaOvQfuhld4xyL4K5RVLw2A/WWL4Iy7yvG
         ZE5YjVFx4XrtoNi6ENpWEF0tOa0sfGgMPZXJait8OwPJdW7WpWlmyCluZ4iKadXYiEim
         u8QmWo8a28/WEMkagWPm695UBzjieRr/o7rS1CJ2m5Cznzg4uTZfNVZTq1DkvFKFBmN3
         8nGw==
X-Gm-Message-State: AOJu0YziqvdmUNXnuwEiqv5bHplxbqCYtRcIsm415o/khJTDcBsVbvOX
	HaJcqv8gObKZ2TsfHEinhdMXM/mgcMlvAMjR0wVSYSph+DHfkjYkV1NSpGyqhhtPc1hYlih//nI
	PGPcdJLdbAivgTfYPfAR0ZmWBCZBnvfXmg/BJdbJbFJOS0I0HFoAjg63PC28f8LofqBmyUGEYHt
	l+9rqm7VanK6FQjEn/CQP+4EKJ3s042S4uLg8FlWXW1pbrq7BGJbZKn1E=
X-Google-Smtp-Source: AGHT+IHIfjKQBGz+sOL7hxhDniw3kzOJc5gpk3Em03wnByh2TJarAT6JpXF6BaTPAd2VR/ahmPWk0A==
X-Received: by 2002:a05:6a00:21d0:b0:706:7577:c564 with SMTP id d2e1a72fcca58-70b4364ff1amr1115559b3a.21.1720480995043;
        Mon, 08 Jul 2024 16:23:15 -0700 (PDT)
Received: from dev-cachen.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70b438bfa86sm437775b3a.47.2024.07.08.16.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 16:23:14 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yzhong@purestorage.com,
	Casey Chen <cachen@purestorage.com>
Subject: [PATCH 1/1] perf tool: fix handling NULL al->maps returned from thread__find_map
Date: Mon,  8 Jul 2024 17:23:01 -0600
Message-ID: <20240708232302.15267-2-cachen@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240708232302.15267-1-cachen@purestorage.com>
References: <20240708232302.15267-1-cachen@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions"),
thread__find_map() would return with al->maps or al->map being NULL
when cpumode is 3 (macro PERF_RECORD_MISC_HYPERVISOR),
later deferencing on it would crash.

Fix callers of thread__find_map() or thread__find_symbol() to handle
this.
---
 tools/perf/arch/powerpc/util/skip-callchain-idx.c | 10 ++++++----
 tools/perf/util/machine.c                         |  5 +++++
 tools/perf/util/unwind-libdw.c                    |  6 ++++--
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
index 5f3edb3004d8..25b0804df4c4 100644
--- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
+++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
@@ -255,13 +255,14 @@ int arch_skip_callchain_idx(struct thread *thread, struct ip_callchain *chain)
 
 	thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
 
-	if (al.map)
-		dso = map__dso(al.map);
+	if (!al.map)
+		goto out;
+
+	dso = map__dso(al.map);
 
 	if (!dso) {
 		pr_debug("%" PRIx64 " dso is NULL\n", ip);
-		addr_location__exit(&al);
-		return skip_slot;
+		goto out;
 	}
 
 	rc = check_return_addr(dso, map__start(al.map), ip);
@@ -282,6 +283,7 @@ int arch_skip_callchain_idx(struct thread *thread, struct ip_callchain *chain)
 		skip_slot = 3;
 	}
 
+out:
 	addr_location__exit(&al);
 	return skip_slot;
 }
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 8477edefc299..fa4037d7f3d4 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2098,7 +2098,12 @@ static int add_callchain_ip(struct thread *thread,
 			}
 			goto out;
 		}
+
 		thread__find_symbol(thread, *cpumode, ip, &al);
+		if (!al.maps || !al.map) {
+			err = 1;
+			goto out;
+		}
 	}
 
 	if (al.sym != NULL) {
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index b38d322734b4..fb038ef55be2 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -53,8 +53,10 @@ static int __report_module(struct addr_location *al, u64 ip,
 	 */
 	thread__find_symbol(ui->thread, PERF_RECORD_MISC_USER, ip, al);
 
-	if (al->map)
-		dso = map__dso(al->map);
+	if (!al->map)
+		return -1;
+
+	dso = map__dso(al->map);
 
 	if (!dso)
 		return 0;
-- 
2.45.2

