Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE9339934F
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 22:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773958341; cv=none; b=b3YNsusrt7G+y8sMriczZS/wysmlZ6T+PzVakOps246okRG4UuauuV407UxYWe+XQ89vbSwsA++BXSKTle4ZmRcpECoqr5wVMEQc1kAAN84W3TVq6AtLli978W5pgKETg1B841QqoV6Zs3hQ6fgWoPU6+dmWGVHg9QQHOTrMozc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773958341; c=relaxed/simple;
	bh=jaKQNWDztSTVc9carY07JbD+L36D0ujHAkrR1d3xcKE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=RbeSvi/pruOtVB72OKVOYJMw1Mu9KUQeXnRgSq085wuKHWJUbPSfpa/uplCObkifGSM7/uPukEAJ5MRwaw9DSnEcC072Pj3RyJDqj/Am0JLbtskndAWE1YEhVJckFIs6BGwZjr6CfTzXl1r3A2E1EBaKolfI8yyMkDLA+nYPs1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AeFK01zk; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AeFK01zk"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so1596183eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 15:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773958338; x=1774563138; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZBprN/SDxVbpqiWt0IwbTwUWMFsC5LXCcAsRDziglik=;
        b=AeFK01zkllvOQi3aIFEwlpD/kwlRI3dN4SrT/OsXeEPYIMx61i42SqTLVLwPyR6v4Q
         z06wTVy9RXsxsFHliMbm8tB0olv++RtdA1aTdWw9BFIYC5qRPU09MPvJZb1TaNF4DFxt
         G+oEaMQ+BNRPboDSyZaHOTUreMESEX+NXdKsMOJUNxHdUisCsHpdIeiAP/cMur2BUl3N
         C2jm8wEs8t6Fn1YLGWV1we0SuoJBK945D8bPin7VjhSIPWxrENL6HfsgOW2Y5bQ8h18t
         XWHwtotZxbsjZxKW7F23+03QIbDhN0xZqbdcLvBvxejuQbci8y5VazMltl3ooccshjuM
         x1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773958338; x=1774563138;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZBprN/SDxVbpqiWt0IwbTwUWMFsC5LXCcAsRDziglik=;
        b=bWc0j/H5dgB2bA60hhoJqv8PSZTbpJOCjCVM+X4yptSy3HbwzegMCP6Xb49nzVGNcM
         kKJr9KcYvz5/kZ/YdeV8tLfIIETSHGN8uNfBo3A4t/q9c0ywQXIDw42vKRXcKACL8WwG
         qGSaZARBaZkFe2x8fikLcmkObNMsQ1JBw9q7BkoBF6xmZkYZJ+Ir74Ksuuvl0t4HCO/s
         ZZn/46K5n+NlLcRQctG+LzkUt0dXmr6IpIryR/ix0wpspub7o19DbCsrbCFQXDImlM7n
         k+D7eEQQf8z17WZ2nPqQ5gdRyMCXwQgnk/kosXX5O7TYG8KIxU7e+O67EF3OtMGejjSE
         FHww==
X-Forwarded-Encrypted: i=1; AJvYcCXH1nzYRCWiMbcVUtE7QPTc8VH38RotHP+3bn5cfOIXDLa/rutX2LBu57lttqDVlyO4673YIPdORY46HVOGhmZQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9gj8BpiM9M2uNmatEV86c/h151X6ooxVJeI3LScdqLAyuDQKy
	0UXJ7LzN6ZRtJVdmyCJyqtopmAq7XWvyUF6QNdmgUKlvWzg0RBCaLVTSIM1h2nrWMOLozttlOjg
	rS0RRoP0UHw==
X-Received: from dycc23.prod.google.com ([2002:a05:693c:60d7:b0:2c0:aff8:8f62])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4198:b0:2c0:dc7e:ed17
 with SMTP id 5a478bee46e88-2c10961ef52mr493501eec.10.1773958338175; Thu, 19
 Mar 2026 15:12:18 -0700 (PDT)
Date: Thu, 19 Mar 2026 15:12:14 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260319221215.207951-1-irogers@google.com>
Subject: [PATCH v1 1/2] perf lock: Fix option value type in parse_max_stack
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The value is a void* and the address of an int, max_stack_depth, is
set up in the perf lock options. The parse_max_stack function treats
the int* as a long*, make this more correct by declaring the value to
be an int*.

Fixes: 0a277b622670 ("perf lock contention: Check --max-stack option")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index e8962c985d34..5585aeb97684 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -2250,7 +2250,7 @@ static int parse_map_entry(const struct option *opt, const char *str,
 static int parse_max_stack(const struct option *opt, const char *str,
 			   int unset __maybe_unused)
 {
-	unsigned long *len = (unsigned long *)opt->value;
+	int *len = opt->value;
 	long val;
 	char *endptr;
 
-- 
2.53.0.959.g497ff81fa9-goog

