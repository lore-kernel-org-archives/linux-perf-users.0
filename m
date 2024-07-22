Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD3A200A3
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721675950; cv=none; b=O5/2+S39TqdhidpqF7W5H/5j4gNz64vDfXDFg5aRxCobYvmjkUtHrvYppy0US/mqrDbyA4R9GClZN5n0UU+SQo1xF8QZxiZzEOuokwwlQLjkKJxb1ZiQUJZUat7vz1RXp1Bb6L/N2oPJsqmvNo00bjd42wEmfzUYjMiVJ+i8n0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721675950; c=relaxed/simple;
	bh=r9kLVIViVucIerQTivQNa2tjjSeW2pCf16/nfvHRyMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l2g1AWFksJGWGQ11L5LQ3NRqLe0w8uCP6zehlfx1r6cKSjm4reO4PmiEd+UPRKbfyjx34Wj/Iv/aJzhRgSm7oxNlQRO27BQ0M09y7xZbRIt8+WBWa1duM36LmQ8HTmYzyknqTKwLi6+hfCxpJrdLc2JjEv6dVcsJ0GQpEHPx6N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ONH8jy3V; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ONH8jy3V"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d24ee678cso992000b3a.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 12:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1721675947; x=1722280747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wFGvL9DSEw7hw4F5KO2hzB8OPf4PNI1O89SSx0g1aqo=;
        b=ONH8jy3V25IoiZHCCYPQcyihE8719DX1Pp7lIkrZmbxEKnu9zyG+qYdH4jADVOLSm6
         5CIWGsQg7Oh5GtNbQLH26XcAqqEOi9O74Q6hasl6EVpM9uq+CxH4gdVacgVUOipMgoVr
         mzzyfGqCK1hO3Cqx7KKWEMETv8yjxnQ/FoXCjBZgzeWh0SoQ1irkbLDtsa1DUc9wL3sf
         D4ieEzhcp2Bq9eMdRbiHop9stks0ThHje4v+lZMNwdAPw4ZAfM3xw7soneWxa1dVOcKv
         rUHbg5PQgT6LXv9x9UOn/xG3VxGj5XIdMTaT6ldMUXC/ZgjM2+gSxMD+1gMlWZ1FjDER
         a4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721675947; x=1722280747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wFGvL9DSEw7hw4F5KO2hzB8OPf4PNI1O89SSx0g1aqo=;
        b=stBejDvV+hdW6Tiuik8We406qMAxz7GMP8eJdKjVlf/XGNi/9lJhGbxaB+Jkwv5LTI
         TFIGNtHDDr6G/2P5tMYGUcsQIF57xTF5a72OdZTxnrKuvcxznWkjKTZjx0H+LAH/dGVx
         Tw/rxV7btr10G1lKa7rwLQT0Q+0RIlxJQ/Ygie4TDJR5DaV9wwLNPC5dMK+SXXwiNmgw
         cefGKwhg2qnBNbvx7nPDrDpM7BNHp7vJgFq6yhVoZ2owK0TvxD4iF5x+dJrJpU0O4AUj
         sx8AS7dx1q/Wf/y04TvzkBMJObxzqrOra0kLBwCI9Qf4DUIt9vSvxFQxjIs8lCop65Pi
         Yr/A==
X-Gm-Message-State: AOJu0YyqEcR40oDEcOlccASRgh6Y56dvc7lkGiimADjiYXfkI3GP6hQj
	X12GhbNjgE0BHVnXmoKeGgDHlgBjDx+tnxxwlNQdlHSMl0u07ByZCQnllwUQrF5a0yb5HXu6p5N
	dkoJiPvzx15VshajOPugiDg3I929VCpAiS8zQQvt9bNM62iDOmyE9Nx7kVKuWIWdVX1wxZqo+lN
	5APvn1tbmqd8S5Rfu6RvOo2vF112DB9bLXuRi3iMMLECrP0+JdULr77zMkXw==
X-Google-Smtp-Source: AGHT+IF+6ezlAEacxRcRnQTAh+ST7ge2mD1E/qoknXTm8h+8a0i06zt6N8Y3TJNeGHwhl804Jsw0PA==
X-Received: by 2002:a05:6a00:3989:b0:70a:9672:c3a2 with SMTP id d2e1a72fcca58-70d0f176ed2mr5620185b3a.24.1721675947389;
        Mon, 22 Jul 2024 12:19:07 -0700 (PDT)
Received: from dev-cachen.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70d156a3891sm3534133b3a.123.2024.07.22.12.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 12:19:06 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: yzhong@purestorage.com,
	Casey Chen <cachen@purestorage.com>
Subject: [PATCHv4] perf tool: fix dereferencing NULL al->maps
Date: Mon, 22 Jul 2024 13:18:58 -0600
Message-ID: <20240722191858.123607-1-cachen@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions"),
when cpumode is 3 (macro PERF_RECORD_MISC_HYPERVISOR),
thread__find_map() could return with al->maps being NULL.

The path below could add a callchain_cursor_node with NULL ms.maps.

add_callchain_ip()
  thread__find_symbol(.., &al)
    thread__find_map(.., &al)   // al->maps becomes NULL
  ms.maps = maps__get(al.maps)
  callchain_cursor_append(..., &ms, ...)
    node->ms.maps = maps__get(ms->maps)

Then the path below would dereference NULL maps and get segfault.

fill_callchain_info()
  maps__machine(node->ms.maps);

Fix it by checking if maps is NULL in fill_callchain_info().
---
 tools/perf/util/callchain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 1730b852a947..6d075648d2cc 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1141,7 +1141,7 @@ int hist_entry__append_callchain(struct hist_entry *he, struct perf_sample *samp
 int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *node,
 			bool hide_unresolved)
 {
-	struct machine *machine = maps__machine(node->ms.maps);
+	struct machine *machine = node->ms.maps ? maps__machine(node->ms.maps) : NULL;
 
 	maps__put(al->maps);
 	al->maps = maps__get(node->ms.maps);
-- 
2.45.2

