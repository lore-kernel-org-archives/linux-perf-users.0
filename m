Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF8E1C6A8
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 21:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721682959; cv=none; b=pPeSCRhwTdXIrNQVQeK1HtgFr3EEW1eErguvBAAE5x80A6kRldoQlUsdEOwfWIZ61bixTDILKA4jLU8na0NaVpJwjQE63rcAHa3mm9dKSmnZ4f5Eg4eSkytgUlrmCsjsG/xKsNt8iItn6emOQKuTkHvjvkEEHASF974P6yzrr9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721682959; c=relaxed/simple;
	bh=7KFOC5wLs3EJl4NsTnqfnwdjiRRNzD7PATmyJ6TduFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ftixw8WIRoA2GDgWqeeIrnhh/j+ciib2uar+T4R1wc/wM0M+Yx7z7XAyE3SYtsIbAy9TZQ6M/RdalpXmmgE3eJO9dexV1QNSmFp+hGt/GXelQOEdTwkiJSc4JA4OKSi0EuQ38RQU8O8nXmFwsd35QWp2dks7cPFn/XlwIa4N6a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SJoLjlJf; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SJoLjlJf"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7a263f6439eso794757a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 14:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1721682956; x=1722287756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qOO2jji9U8j5jqgweOYexBqjPNMVig6bzmPu41c6FV4=;
        b=SJoLjlJfpb4+VTjGMVo1c4ygxlKdEGxG3lxOo4V8o7oMmOJEQQlggrxeXu1/NMtDMu
         zu1d7R4g4ULnq2AiDnMAR29SSY3jIJbzxTHKqUubHYyy1vLrUFdoK+c+2hRd0cvnFF0q
         unq7zBPb5lIalmuEsTyBz63obs4sWlbNXUPzs6o6w5EH+BTTYHCvRMZC0TwBVhQrgGfC
         MY0yIoUdXVr23LLvRZfjgLm7UUcWZi8KYybfoFMAM3Kv+hqVe+mj6TshZwvv2qeYWPU1
         4eHIEN9ixkkngsnb+xwSHSDZT1ITkD+1yMAf1p9/0Q84tbLzKBY29gOSOuaeXX1IGFiK
         BwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721682956; x=1722287756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qOO2jji9U8j5jqgweOYexBqjPNMVig6bzmPu41c6FV4=;
        b=xH0Lmr6ijCYJBrlvSj3+Ck0aSlwwB73qWJUo/M6wsE/XEFxgLVF4Aoi6+M3ZUn9m7V
         ZXeq9CupVUHcrkO6PNKYEaL2/acjQEfrDl1tqUQvgMxR5IaYRvVxGGR9uiS1nu9JkUUI
         DafwV/jFyBlaKZ6D/3T07jGvg3NtJX03emtr2ZuPN8JoJavnhHFpXNcotXFk9/HSGwS1
         LpckhhO3sl8RGpiUEC9E2c4A0Ql+zBFlJWtvjWNEWu4GAl2N4fwEct5q9qrwZvQgC0S0
         LoHO+VlAekpTESfDS6EO9P6819AZnjhjya7iyjKbOp74XRyx2OCXZAkqEPHoU8G+oBjY
         IOOQ==
X-Gm-Message-State: AOJu0Yz8Ma7jKuljJWLy7qHKAORjlhaa04ZGGNcPTCbNQe/AoHT57Qxp
	+enIVJWUNE9sWMW5Io5PMk4hjocDkXH/dh3kNxuTUoFuyz//AZuRkZ0G1vKtOR9D17uMyRdUu7y
	9FixDAHH8KC5yT9SC39Cht2XjJTfGN1rNXFtsSqcCSMOpa5e0EcHSG6BTQhAKH96uinj1vXTgN4
	l2qbsbYnGF2cAJ/Gsx5QCXuMpOHpK37stT4wN1rj8SVHea7/jDWE7LlSw=
X-Google-Smtp-Source: AGHT+IE2SCRbidasSEcvUS+FBkZiidEQHa2TVu6rFttRlOgPYgJmcCb4tj758FeHkNi2yyoJQ5XZ+g==
X-Received: by 2002:a05:6a20:4327:b0:1c0:e5d1:619f with SMTP id adf61e73a8af0-1c42285ee9dmr8697515637.4.1721682956411;
        Mon, 22 Jul 2024 14:15:56 -0700 (PDT)
Received: from dev-cachen.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fd6f452c67sm59463035ad.225.2024.07.22.14.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 14:15:55 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: yzhong@purestorage.com,
	Casey Chen <cachen@purestorage.com>
Subject: [PATCHv5] perf tool: fix dereferencing NULL al->maps
Date: Mon, 22 Jul 2024 15:15:48 -0600
Message-ID: <20240722211548.61455-1-cachen@purestorage.com>
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

Signed-off-by: Casey Chen <cachen@purestorage.com>
Reviewed-by: Ian Rogers <irogers@google.com>
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

