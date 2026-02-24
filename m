Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B9A2EA15C
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Feb 2026 06:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771914342; cv=none; b=T/EhYbQ7CC3jso3B0cDaoKI8kzsqqzTnly1eKW7+HRvYMsPrUx2GPJMaacevKcttj6ADxn8HAVEekgW36tG0Ei+g/ftacR88L+I6UyrdQNQT0eL5bFW3ZplduAmiGDmHrlQtUKZW6DQTpNWIOUm5SaqV3ivkH5Sv9XMThbcDhIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771914342; c=relaxed/simple;
	bh=gO5XKTbGTCNX9F2kGpffpU86Ne6W69soNa7yYuB8rEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tvb3j3vKDb9WITTqp1aIkf3fCPfjsuXWvdLblD9PHVF/f0Jeql/aWLKQ3hrGjnU62B1nzGBoNb4jcbCLOuIaJMsRt6odAN/ZzpQJRT/xW+N3y3Efk3H56HKdnAPvkxcDAu2KaE9p416/JmWLtN5ZHE9VHjxQH/5uswl8lDxJ4ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hW5oWOGs; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hW5oWOGs"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-824af5e5c81so4828802b3a.0
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Feb 2026 22:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771914340; x=1772519140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HQ3C3N6ai9LWpoELJlhPWsjarYjJZBYa3nbCsM7NzMU=;
        b=hW5oWOGsq2okxAznLXCvFIpoCVRrsSOZ+nD0dMRX05M8hgXLvGDWK2hcgCD5+fcDLT
         QRYV1n2frM1S8q2QL8g66AQK7tHDM847/+FLdF0clRchsjqNEtxC+TXqaavLzejzxc3f
         cfXXht27EGtm9xj7Ce8dWXz4OHNfBRHZt3YoOzYA1ZmtpZwkV1okHMGYbdazGh6JxUli
         LS4wzxZvH8Idr/pcEcoZ7fuBueFPKeKz6qlKOP78xLHgwiaj+ald4xrhkIuBWauGrRm1
         wmmJqRVN7qb5NoZZcrdAX8xPUVLiXHHpqeH70EWVcQoYjEmCEkCWcnfZbIK19FsWG+h/
         9wew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771914340; x=1772519140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQ3C3N6ai9LWpoELJlhPWsjarYjJZBYa3nbCsM7NzMU=;
        b=QxmKOxRzbRClzb75De/b0Gnd3Dwci1mtnNnFDimAe5ggLYyvXkMy9yRKVfmZALTzFF
         eMUVv/h8eAkEwl6THnaoqVfz/B7YtbL+GfhvcMiZ+T0umec9HfXIdKiyXrGelzdXczAb
         WkS+Rv6nEiwMtpOK06soOUvNs9yjzCM4KV6/obDExxYr6/PV5kSjYHVvKH5JAfd2Ev9z
         Ruj2Cif4ZlX0TmGiIHKtaPQzuLFO2MkpOrAjpTjbCPa20lrzGzXtkIC6P5mrvWDcyvct
         Jh+79dBiCZvvhpw9RquW4+HE1Sh1lEOpPPB7hv3VYXPB3yjG2AZEZFdxroN+BwyALvc8
         n26g==
X-Forwarded-Encrypted: i=1; AJvYcCVQo1wF6LDOFc1DNkUpBI1iqJp7SHJoLuSsSVrcZoS3jz+VzEXL2ueaThYIt8YIgp+jWS/iaZZatF0hJFgWmYUB@vger.kernel.org
X-Gm-Message-State: AOJu0YwKzTjvC8meczJ92hQVL/CZuphuJwZ/NWayv588OJoDAt5AikxT
	6ZhvkLtHQFxmoh7P8Opo51EFPNLm2wb3zYKBiOcgvGN7ISBzHbr216ic
X-Gm-Gg: ATEYQzzdr6vwvSIX/uFxEuJAx6zL4bcaHe9npKhagBV09TGsJKrCwd2403RWqac18l0
	yUzCZXoQ0PYIALn/s1Do/judmcTF/n33Qg7qt7y8LOhcAbkzjlta30QKhjbltDmzbSqjlc1qpSD
	H6/XCE/fMOZs8CZFr1OiTncy7gasgQ8HGR0496+dFYEbacAELmMIEoooZ/ngqDAMmx35Wf9ywCT
	RHrta9jfeIthLxmdFDKFBSM/zly640xvt2DlJkuEbKhyTmURZTKtyZIGpIkZXkVEXH5pO6mwmDO
	RVyF8IAKVUgs3xSOJrFYB7HRW3C0iiwKWr6kqm0G8hcQIFSELgbLUVaA7CaBQuRDkeoihJik62q
	JKZTokbZubpjAXor318R8uf0oK5IwywjupxhDR0VHWGbfe8JKa1eAhJETVuh2Yw/oFROck0MFS0
	pLCXuRUETnV9YYLGs9lYl7o2EOegrxu348ChkbzuvVlqt8Ow==
X-Received: by 2002:a05:6a00:4b13:b0:823:c4dc:d20 with SMTP id d2e1a72fcca58-826daa1ffa8mr10623797b3a.53.1771914340145;
        Mon, 23 Feb 2026 22:25:40 -0800 (PST)
Received: from localhost.localdomain ([202.161.55.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd901b59sm8365244b3a.65.2026.02.23.22.25.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Feb 2026 22:25:39 -0800 (PST)
From: Yunbo Lyu <yunbolv@gmail.com>
X-Google-Original-From: Yunbo Lyu <yunbolyu@smu.edu.sg>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	richard.henderson@linaro.org,
	mattst88@gmail.com
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	julia.lawall@inria.fr,
	ratnadiraw@smu.edu.sg,
	xutong.ma@inria.fr,
	kexinsun@smail.nju.edu.cn,
	Yunbo Lyu <yunbolyu@smu.edu.sg>
Subject: [PATCH] alpha/perf: Clean up stale comments referencing old hw_perf_* APIs
Date: Tue, 24 Feb 2026 14:25:31 +0800
Message-ID: <20260224062531.96304-1-yunbolyu@smu.edu.sg>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two outdated comments in arch/alpha/kernel/perf_event.c referred to
functions from the deprecated hw_perf_* APIs that were removed more
than a decade ago:

1. hw_perf_disable():
   This was superseded by per-PMU disable APIs such as
   alpha_pmu_disable(), after commit 33696fc0d141 ("perf: Per PMU
   disable"). The comment has been updated to reflect the correct
   function name.

2. hw_perf_group_sched_in():
   This function was removed in commit a13c3afd9b62 ("perf, sparc:
   Implement group scheduling transactional APIs"). The corresponding
   comment mentioning it has been removed. The if (n_ev == 0) check in
   alpha_check_constraints() has also been removed, as this condition is
   never true. The alpha_check_constraints() function is only called
   from two places:

   - alpha_pmu_add(), which calls alpha_check_constraints() with
     n0 + 1, where n0 is the number of existing events (>= 0).
   - __hw_perf_event_init(), which calls it with n + 1, where n is the
     number of events in the group (>= 0).

   In both cases, the n_ev argument is guaranteed to be at least 1.
   Therefore, the check is redundant.

No functional changes; comments and dead code cleanup.

Fixes: 33696fc0d141 ("perf: Per PMU disable")
Fixes: a13c3afd9b62 ("perf, sparc: Implement group scheduling transactional APIs")

Signed-off-by: Yunbo Lyu <yunbolyu@smu.edu.sg>
---
 arch/alpha/kernel/perf_event.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_event.c
index a3eaab094ece..2f57626ffcfb 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -35,7 +35,7 @@ struct cpu_hw_events {
 	int			enabled;
 	/* Number of events scheduled; also number entries valid in arrays below. */
 	int			n_events;
-	/* Number events added since last hw_perf_disable(). */
+	/* Number of events added since last alpha_pmu_disable(). */
 	int			n_added;
 	/* Events currently scheduled. */
 	struct perf_event	*event[MAX_HWEVENTS];
@@ -372,10 +372,6 @@ static int alpha_check_constraints(struct perf_event **events,
 				   unsigned long *evtypes, int n_ev)
 {
 
-	/* No HW events is possible from hw_perf_group_sched_in(). */
-	if (n_ev == 0)
-		return 0;
-
 	if (n_ev > alpha_pmu->num_pmcs)
 		return -1;
 
-- 
2.25.1

