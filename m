Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5D11CF3D8;
	Thu, 20 Jun 2024 17:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906329; cv=none; b=ZDzOLuzfkUFAttgGSLLJQKyuyDt+uW7CKxrnaC8zOZfTBW5sff/IlYyl4bbSoRbl1ispDVCpGOn4kAJYoWvMkXJj0uqV49ejapInO7xC0PkN0RwEJsEZ90j5eR/VLZwkrYrhO9pOZm32EXtoZu8rj3qEI6u7SAtpSIMTzHidfx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906329; c=relaxed/simple;
	bh=7jDPXKVK1Gn1Q5IAcYSYnvMH/NIfDHCFFGZUZqyUDvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FgR++Sft1L01yyCJJ8hWv9sgsMeXIUONHZ2DpT3yzj1B0RPt6puiAGv9QOqdyNKkQhXx5Aok8/vZM9uI1LPCh1TlU3j5eTlSWnFPydj5a5DgDyPEufjybHsF0Iz9dlg8jQoDgB5hXKc0b+1Ijvi0tA7HLfnlqov2RPK/korSQxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q21tjXbx; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q21tjXbx"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7064afd7011so434354b3a.1;
        Thu, 20 Jun 2024 10:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906328; x=1719511128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4Ir80xSiYngcpPXBHnGnxBUcMhzo8e4IRrRAzmZKk0=;
        b=Q21tjXbx0tcwXHB9x+zYv1Ac0/ZlxInXWoAhn7Wn3y9V3FxLbAZ9NqitElD/XFlTSY
         wjgOMw8LRPQFskxwgdFcowj5rqXPGPRaR8oXxJdozPB+iI1/svSSn7D9cuG2vYibgAxW
         0zVER3Zar73O7KQ3iKqjQfxJnL+fvZh5kCan3YY5+Ah211vXJx4g4kYCjtd7tO8TZ1ja
         EZaDA0jGJOvVFr8sdHtfLe/sfATG/oWp8PS9+ARyci7zu2e6cJyx7+JnqjayhJgp65dn
         VWeC/va/vrF0UGVpc8KQ5eYWEKtsAnlra8pykl3NPbeSsTAyKDRhqfGoCpf516ioRRvX
         EwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906328; x=1719511128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4Ir80xSiYngcpPXBHnGnxBUcMhzo8e4IRrRAzmZKk0=;
        b=nbyMeaOEUfyPibfgAMmvrwcgeuLUr4aMKZdEMkIx3+uUT/KlJb91I0xVyt2JJjPLJG
         wfgDxO+FE2Z0NpfpdtgFnieeEWSzxq07PC7/guUTXdpkdnDKhFYXgmknxO0l2ZMepnMX
         03nq9t0S/zZNM8fK6DPnQwwq2yolyt8snGK5fTFxxRO8VYVDlxQDLLxNkTGJWK/5QFnA
         obbvzip4t8NMLYuWWmL3Xvhp6dILiRUZub0OwFlkbjtg3mDxL35rwFYtTHWEmMriCstr
         6tq9CTD2QutClHIXa5KnmesUrBwdy+lqDkFJqlhpUcPH8Utd/3VJs4mgf8ahz79mWD0Q
         iEqA==
X-Forwarded-Encrypted: i=1; AJvYcCWIua7lAosSW1gr8Tl2RVh079B6uujRTOaLKlxiV3MAFVVsBBKEAQQBN1YHY3YDVgVKK+4TLOopv/kcljasGzafO7uZbpwrPQQPoLXx1IaZ1A==
X-Gm-Message-State: AOJu0YzSCgxgpSONWqm8tKP2OfriBLnBXvzp912oB3w/dg9URNyvqsz9
	4GUTy3UVxBHxH/epC12/pWu6zkzgHGcW3R0Xtx4xNvLJH8aepIdTrxdqJBQtLRs=
X-Google-Smtp-Source: AGHT+IGeZnFwtFK9/vOKkpOdDMAbvJAuNbjW/POTw87WB/bESSwhGo/tx9inSGzZgD+dxEVltZsAkw==
X-Received: by 2002:a62:b50e:0:b0:706:3454:7d8b with SMTP id d2e1a72fcca58-70634547fd4mr4788083b3a.16.1718906327659;
        Thu, 20 Jun 2024 10:58:47 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb6c1c7sm12676888b3a.167.2024.06.20.10.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:58:47 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v4 35/40] uprobes: optimize xol_take_insn_slot()
Date: Thu, 20 Jun 2024 10:56:58 -0700
Message-ID: <20240620175703.605111-36-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620175703.605111-1-yury.norov@gmail.com>
References: <20240620175703.605111-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function opencodes atomic find_bit() operation. Switch to using
a dedicated function.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/events/uprobes.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2c83ba776fc7..30654c41f0b2 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -9,6 +9,7 @@
  * Copyright (C) 2011-2012 Red Hat, Inc., Peter Zijlstra
  */
 
+#include <linux/find_atomic.h>
 #include <linux/kernel.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>	/* read_mapping_page */
@@ -1581,17 +1582,13 @@ static unsigned long xol_take_insn_slot(struct xol_area *area)
 	unsigned long slot_addr;
 	int slot_nr;
 
-	do {
-		slot_nr = find_first_zero_bit(area->bitmap, UINSNS_PER_PAGE);
-		if (slot_nr < UINSNS_PER_PAGE) {
-			if (!test_and_set_bit(slot_nr, area->bitmap))
-				break;
+	while (1) {
+		slot_nr = find_and_set_bit(area->bitmap, UINSNS_PER_PAGE);
+		if (slot_nr < UINSNS_PER_PAGE)
+			break;
 
-			slot_nr = UINSNS_PER_PAGE;
-			continue;
-		}
 		wait_event(area->wq, (atomic_read(&area->slot_count) < UINSNS_PER_PAGE));
-	} while (slot_nr >= UINSNS_PER_PAGE);
+	}
 
 	slot_addr = area->vaddr + (slot_nr * UPROBE_XOL_SLOT_BYTES);
 	atomic_inc(&area->slot_count);
-- 
2.43.0

