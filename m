Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795052872;
	b=iZ+NoKa2lJd/PxTBPn6EJ15MpXZnfLkk4tJ42RvHByxX3EyAGyecrhXf9vyp7euPYpgW
	 N7Tdq26DeRi7ag/zLP1TRTYPzc2Z+79+qL5M/Izrk7vUgS+5qoPOG2Y4FkC0HZ9vrsxQh
	 BIQdvNLW3fR3QrpKuvd9W6+ZUrTRu2iMGm+wn/hTXgsLLrxqnLDy+C+3syIr4N5JcuEv5
	 DlGa3wO9dxGzhJ8lHslMWlQLqW1jiht2/ZPNOJphKHkk4Kd3Dv/zCmsuy18Mb4gsh+joc
	 BNP9BHVgsffy8DSCBddhKBx4QaCPgRF/weNVKWxMpZk0A7t0B6NL2OqUl4S7sydyOWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795052872;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BF6MHMVC/gRhXEjqmDEfUPfPCO5ohWekc5J++08zS4o=;
	b=ulxFOzHy4gLNPG8PGzYc+CwYrn/R7h2CeEzUz0wV1zDfdYfRAp5dTjGIYNzrcjlknbsz
	 mAIE/6fwylrKjUgCxbiXAKDg759FJoWVLAg8q5V56s93CKgNfZGw65xL9xc1b4oA+aGUn
	 5UCoLmRcX+u5cYjLC4q1t03nReF6Iq/117aeQ4RZOec7TCdljMF/wxBJqP7uJYoBFTyFI
	 4v0VzvovImsclYii55ngNi3ZqvzRUIBtxG5j36nPDHOH/IeiAuvv2E92zXStdPkEoE07h
	 NY8/Sswp47XiWz4kvwGhq5lOGhcvxo1Ye31oP0mcgZuIeqbK7JmQOP5Vz8uONKdOxDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WNBbOJGQ;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48BC606A330
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 01:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D48BC606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WNBbOJGQ
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2f01f296937so2951775ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 17:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795052871; x=1795657671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BF6MHMVC/gRhXEjqmDEfUPfPCO5ohWekc5J++08zS4o=;
        b=WNBbOJGQP22gqUiDU4eNd4w9Ilw6g7LrbmQStjy4SBnKM7Cz2YB+ZLOm2BUl5NA8xj
         YL1iDZ2iAqYX2vtbhlQp2DZX2jwZLs98IVlSXl7Mur8BZJixvAa7Z7mdQaTn0PCzSoJG
         E4s3pnISlw0Ju9UadnmRgJfk75A3AXCKZBeLUsDOcMV7h+wMQ0uSn+W/T2AVLwyq7W3r
         qT4kVp2KsV5ZA8Gl66EY11GsK50ccLAIFHIe6tvF9A8Pu9i51K06kkT/jpu9ZiK6YBTx
         ntIbX384YVvhXaHgmSMN8gRNvxbBdkLk4QlbhchYIizTDn/Czj9Z6K3gzkLes2sZDp5a
         1zCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795052871; x=1795657671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BF6MHMVC/gRhXEjqmDEfUPfPCO5ohWekc5J++08zS4o=;
        b=P40uXHJhv8VYbEcJnxEyCqGo7U7OCTT8ZgTYOFENsxKxSaTN2Fy2OIh4i9yIHbtecB
         Jzv2vD/eE81swiPnfHi5iuIH+C2uXamkBuH2XGJ68RDr2az6v4+EUSzM+Mgt3eUaxGAj
         dYANFFpmNHPnlj0In3iBcjTmCXFhQ3Q0hrNCfth1cMbi7IvoBYYSVrDK1atkjwAsECmq
         E/01/+JdC5yDU0HBzVT+Fa9w76CF9k1PdWdXKUXK+iOwZkVs5+Z7fp/j4JxqD1CriVgO
         j33xlcJ3fQ4uyhbHHg/6vlGNaUtT78DPG/uyJ0ugyQpeCIAjgBKyfZ3nb141NEabjRqi
         3ukQ==
X-Forwarded-Encrypted: i=1; AL+hErHzZELeqHYMOi3rLDRz2bAzBxMUHxH27UvVXT5f8GJ9hEZN2/YPCceyaJsG4iEU8IYa1i02cvi5KIAzaY+BaoJJ@vger.kernel.org
X-Gm-Message-State: APuU4Z+b2ktON7R57gJ3SBxMu8R25a0P/Qd41wQHDOuiqaL81n7SO+Y+
	IcUBCPUOp+AiyG7mJlu4GTcSsOtdniJiKyL4O4ewl6BvJjCjbst1g0bZ
X-Gm-Gg: AZFdTZfvDmwSzLZTwhFJWCowhvpp125IKuR6rh9/zN5NV9Kn2Ex29Wi2poifk2eQuoD
	YkcRlOf3JFlePPh8p2s7J/LEaW0vANL7gqFs0S0J3XXNem5Hs8oh9tcvtn/bbTxeC3XsBe+q37o
	0xB2un9shl77eYbgS4aLbptfImNz2T62/rMcIUpaFED7RiORBfdNqquk3/2dqhnNU3/aeMdlsM6
	kabLa0rvvKrCVB2xBNqG1J7BIEdd3YQfFT0GdDEyb64ntdD/FxPFe57FvH4KiMQoMy3AJeU5aMt
	a1sh2DmE2uKhBb0wNwjm4I30Zil27lAzU/GyhaLCvzp7ACQYr8NffZKEbx2Ewu1/ImFSvOt0Qwi
	DcPGW8luAlndZFgjupV6h3xGCW25LXBgpuhdOVz5sFUPztjWUtQ1BVmOWcHU6JsSAg8FFnaexy6
	L+pWmIlc8KbFBCJfsKdN6HDFgfq8ZYrJzGSHfq6HGnXXylPWh9ohdTQx1UF+trr/BIQ2GtVLX5q
	0qUmJ+EDccExrz8Q9mtWPVkbHCEttuSW7HWgoovKQs1ZfZIlYSGwDoyr1gAvt+5/Kiv/T8x8VX3
	2QoIrDrq6gcv8ivdpvwTzZ1bDspxJltHTo4Q5cLprftcBfVu2Mwq1rlHO9Uj5x/qEc4NMWGlIgW
	QvfvnR9ITC670pXGFocx7S0W9AAmn+yDwcL4LLx5coTK6mmX9cq0P7qBUdQQ3QwkTmvmtt7tE/P
	2Qk07eVQBfe2hHUsAgqQDA1ZtzPxS1NTyi1a/4ydyM5dImgQrum8srPf4TRoSgXqKbgbU6ZxOCr
	fHB+hn2XPZREnTj3ZYtk0bvNZN+Nj3vzvAo/HiKskDQ71AqKGQgapvAbxZtvOmR
X-Received: by 2002:a17:903:1d0:b0:2e8:b5b2:a9f9 with SMTP id d9443c01a7336-2eff740acedmr41921305ad.37.1795052871033;
        Wed, 18 Nov 2026 17:47:51 -0800 (PST)
Received: from localhost.localdomain (123-243-92-89.static.tpgi.com.au. [123.243.92.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff62db225sm21774475ad.72.2026.11.18.17.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 17:47:50 -0800 (PST)
From: Daniel Wade <danjwade95@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Kyle Zeng <kylebot@openai.com>,
	Aditya Chillara <aditya.chillara@oss.qualcomm.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf: Reject group leaders detached by CPU hot-unplug
Date: Thu, 19 Nov 2026 12:17:30 +1030
Message-Id: <20261119014730.2074-1-danjwade95@gmail.com>
X-Mailer: git-send-email 2.39.0.windows.2
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CPU hot-unplug detaches the events of a CPU context but leaves them in
OFF or ERROR, so once the CPU is back a detached leader is still accepted
as group_fd. perf_group_detach() does nothing for a leader that is
already detached, so closing it frees it with the new sibling still
linked, and closing the sibling is a use-after-free.

Detach them with DETACH_EXIT as well, so that they end up in
PERF_EVENT_STATE_EXIT and are rejected by the check from
commit fa091f46c383 ("perf: Reject exited events as group leaders").

Side effect: poll() on a hot-unplugged event now reports EPOLLHUP, and it
is refused as group_fd even with PERF_FLAG_FD_NO_GROUP.

Fixes: 226424eee809 ("perf: Fix corruption of sibling list with hotplug")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Daniel Wade <danjwade95@gmail.com>
Cc: stable@vger.kernel.org
---
v2: use DETACH_EXIT at hot-unplug instead of a new check, as Peter
suggested.
v1: https://lore.kernel.org/all/20261116081248.21059-1-danjwade95@gmail.com/

Tested on mainline b3dfbde62cf1, x86-64 with KASAN and PROVE_LOCKING,
2 vCPUs under KVM. Without the patch a sibling is accepted on a
hot-unplugged leader and the close gives 15 KASAN reports. With it the
open fails with ENODEV and no report appears.

 kernel/events/core.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f5f2261f1fe6..2de4c3cc37ac 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -15342,8 +15342,10 @@ static void __perf_event_exit_context(void *__info)
 
 	raw_spin_lock(&ctx->lock);
 	ctx_sched_out(ctx, NULL, EVENT_TIME);
-	list_for_each_entry(event, &ctx->event_list, event_entry)
-		__perf_remove_from_context(event, cpuctx, ctx, (void *)DETACH_GROUP);
+	list_for_each_entry(event, &ctx->event_list, event_entry) {
+		__perf_remove_from_context(event, cpuctx, ctx,
+					   (void *)(DETACH_EXIT | DETACH_GROUP));
+	}
 	raw_spin_unlock(&ctx->lock);
 }
 
