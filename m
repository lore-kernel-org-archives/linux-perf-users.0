Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE17732E721
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Jan 2026 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767632080; cv=none; b=VKjRcCRwu2kWpbBvlPTIVhtxeBNbIBC1sTwPsVpy7cHLE6qMVLSDpDvMcj1NdDi4aoQd7OxR6MqhU0chgtG7f6dcxG39472rhvVbqe9irSRLrQxUm0h4YpQxtFdtXOOELWiUNAO1ll7QmoKHLi8Jaevb0FjBbd2k6UQW/AqkPtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767632080; c=relaxed/simple;
	bh=5iUtKS7P1pExvt8SVQ6tSMP5tPKNfrWuy2K8oV7wXEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oIRqAnyAPr8T5bOxXV+e20o7SbBFQk/3CoM5AKWkkM/XNTQFnY8uxVV1MS1vKZTmNQQJi9ZusJvdrKJJKZykwd2hfUbv8piIBnDI5EYlcAEAt7il93wpo3t159peT7siQR0uspm9ZHpSBnuBdlTKpV0vAa5EMbyeJ2PqzGhO9V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=SPv8LruV; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="SPv8LruV"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c13771b2cf9so54023a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Jan 2026 08:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1767632077; x=1768236877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HkuA2Iz0l5KGRSo9OokGCp9vOWImrmU4vjQF4nroIo=;
        b=SPv8LruVrnneTHcFCrayi9JzrpXHUGvDanw3iWZnYLIs+xcnsTFQVfQyZ6E9XXmKj2
         Ag5wkXCqpcRu5rd/TuYE39bRgZGuMtts/zwZCsfBrJhtCqDtMsMB3Jpr0SD6ogLsGFc8
         svKy9XK996i/fJUzWWrIs/HB09ynrJYB+Z/9kaDuXJu98cYGguXZmt8Pw9hNnAtsVyTU
         porHmGtKPmILCBxzwa5cnz4lcvlq5nOKmy5LvBKBJyE1lHSmM4Mv3OLzdJs8v6Mp8m8N
         4JI41ycH4zwQmrU5NtdfwMjFZDcei6FEAA2VubOrdJ3lYH5Q9quCvKimVFR3516x7YGg
         glow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767632077; x=1768236877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1HkuA2Iz0l5KGRSo9OokGCp9vOWImrmU4vjQF4nroIo=;
        b=RArb0GXkuo4KpouLlpmR/yFcptzNxFy+7zv97PfrsANlcLl0rt/25puxSLD4EI2ZIf
         ZAy8J83x/KzMFq/WpIMVSNMdnuDUq1jbnlD1NT8cQ+imQ32BSfN3qR8k+qWZYRhgts5/
         7qUl9gGUFaZ1aDhmRxVuDMdbml41HPLtd7kv+pn2P/S0LvwLrlG0qo6x1faQS1RTeHFv
         GZESjA7cRZ1VUBfA/cHI0DclByqUHZLn0gfDy0/vr2gwb+yYwMAnuJKI8OUW/nCyPATC
         fSoBcuB9DT/eErpmrthdFkHs7NLAgQ/Z5pOVzyGGn0cCjzl7oZyjoRHdb/5a5ctDNmmI
         Bbeg==
X-Forwarded-Encrypted: i=1; AJvYcCUOra/8+Nk1z0OXUoIVuKnHxxM5V3aPRTUBFuiImH9tb73X9QHIj0jNj4n7DMSD5+8HVVx5xTlvzGRiPLQh1/yN@vger.kernel.org
X-Gm-Message-State: AOJu0YyHW7gVHj5ftQKvkyaijDqEl33OqCQ7auC4yQma/t9EsJw2g2ny
	EXy0kaZ6Q5j2b6055HVPPCbo9fONN/V2285B7P1QiJdSv75oqAqM8x3ZwSWep+wCVw==
X-Gm-Gg: AY/fxX6YmKAh3HudLeJQAFHHDoayCy/x5rgAsRiYNw7FRdTvK8RBUim1Q0JMT6Ec9Sq
	eNjxN9A7F3KqJVLMpyYVSsptbk2PBnVNpsnQTgJPWqQxkM2/ko1KglKj6D9A2VlyzCoCydH2LUM
	eU+cqfnoe2vH0zFh9A1x1HKY04J6V9dT/YPVY62r+2FRCK8ZZeZ4SWx+Qk0uNJPf2Y51EL+LS7J
	qCv3BS9K67Rdl6uwHrEGJ3xETaNLLFzA+W7SXyqW8iRey6yvmMOujdhSRasWcD5dMD1MPSd+jyL
	dtTfh+7LAR5OeXoCtZvYTI1kcAhMi+GoicuStHw1PtTp/DG9ZjWnJHtgixmOUSy2sM8FVhsJ+DJ
	sTLRpF4vF+F/9EIiubW6kTSf8tzdVAdN8S1LWPKKkeL5/SlkPXlURVwXiG0cuQEIyi+K19momoB
	CAaGGOTjHCBS4MOmggu7n4GoBzrc+4j79yngDfbXocTzslGGHMBSXs0DwXt1M=
X-Google-Smtp-Source: AGHT+IFhB2kovOaap16+/Ow4rTNM6cvVOkquC68OhGTB9bnFJnOnmXwCYaO6a2DzTDUQ/l5gYCr/2g==
X-Received: by 2002:a05:7300:f81a:b0:2b0:4e86:815a with SMTP id 5a478bee46e88-2b05ec347fcmr27023919eec.27.1767632076901;
        Mon, 05 Jan 2026 08:54:36 -0800 (PST)
Received: from localhost.localdomain (ip72-200-102-19.tc.ph.cox.net. [72.200.102.19])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2b16f18e0f2sm213853eec.12.2026.01.05.08.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 08:54:36 -0800 (PST)
From: Will Rosenberg <whrosenb@asu.edu>
To: 
Cc: yi1.lai@linux.intel.com,
	Will Rosenberg <whrosenb@asu.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH v2] perf: Fix refcount warning on event->mmap_count increment
Date: Mon,  5 Jan 2026 09:51:49 -0700
Message-Id: <20260105165149.30200-1-whrosenb@asu.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aVt6tqOp+fGnFuBb@ly-workstation>
References: <aVt6tqOp+fGnFuBb@ly-workstation>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When calling refcount_inc(&event->mmap_count) inside perf_mmap_rb(), the
following warning is triggered:

	refcount_t: addition on 0; use-after-free.
	WARNING: lib/refcount.c:25

PoC:

    struct perf_event_attr attr = {0};
    int fd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
    mmap(NULL, 0x3000, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    int victim = syscall(__NR_perf_event_open, &attr, 0, -1, fd,
                         PERF_FLAG_FD_OUTPUT);
    mmap(NULL, 0x3000, PROT_READ | PROT_WRITE, MAP_SHARED, victim, 0);

This occurs when creating a group member event with the flag
PERF_FLAG_FD_OUTPUT. The group leader should be mmap-ed and then mmap-ing
the event triggers the warning.

Since the event has copied the output_event in perf_event_set_output(),
event->rb is set. As a result, perf_mmap_rb() calls
refcount_inc(&event->mmap_count) when event->mmap_count = 0.

Account for the case when event->mmap_count = 0. This patch goes against
the design philosophy of the refcount library by re-enabling an empty
refcount, but the patch remains inline with the current treatment of
mmap_count.

Fixes: 448f97fba901 ("perf: Convert mmap() refcounts to refcount_t")
Signed-off-by: Will Rosenberg <whrosenb@asu.edu>
---

Notes:
    v1 -> v2: Add Fixes tag
    
    I also have a related concern about code that handles the mmap_count.
    In perf_mmap_close(), if refcount_dec_and_mutex_lock() decrements
    event->mmap_count to zero, then event->rb is set to NULL. This
    effectively undos our ring buffer copy. However, is this desired
    behavior? Should event->rb remain unchanged since it may still be
    mmap-ed by other events and can still be used?

 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 376fb07d869b..49709b627b1f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7279,7 +7279,8 @@ static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
 			 * multiple times.
 			 */
 			perf_mmap_account(vma, user_extra, extra);
-			refcount_inc(&event->mmap_count);
+			if (!refcount_inc_not_zero(&event->mmap_count))
+				refcount_set(&event->mmap_count, 1);
 			return 0;
 		}
 

base-commit: 538254cd98afb31b09c4cc58219217d8127c79be
-- 
2.34.1

