Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFDD38DD2
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 21:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721682881; cv=none; b=QL1TwGxgsZmrq16X9uHBH2R7R/RvjnLTuMqd/5VKc3FvPw8Zw7Eoblq6kgmsWr1C7kR10fAdadx3WQlCpIc1uPOX0d0FLsqNTFBt1jST8pf2obcWnJHx2xHt3prFZMzuQtDJv3Hmzx3O0aqMd24S9G+fQbeUCmFOyr6UgrmiI8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721682881; c=relaxed/simple;
	bh=r9kLVIViVucIerQTivQNa2tjjSeW2pCf16/nfvHRyMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bzjopGLMuiNHEzHdTcNo1X8bBLDDFNVpDHCvj9FeUdzf3OnYl/MYEecj1DgeZFIRhiFzHYV96e1mH3wMThRh8IBT1eJk6G8IWquypJLuYopiJbcWuGPJhFBs0xS7TLCWoaZ5BBIk0Bvb1thdsnIFjM+aKKe/SeaiJANMDRLjIC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FNz0AoGf; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FNz0AoGf"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc60c3ead4so6645ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 14:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1721682878; x=1722287678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wFGvL9DSEw7hw4F5KO2hzB8OPf4PNI1O89SSx0g1aqo=;
        b=FNz0AoGfwhktiB6dLrCdmTdz2b02Qlvaye7fVNuWHjzdanm7j7JluyFLE/yqmEkWKR
         Avvaw8Ql5xtdP630jmpmDVAFa1aNE3vtXGmbDLJXNwaDewb12IXkXv+d48wE/Otd56nE
         lOrKQ/fSNkJMlJ7bHmhxV4SYGPgD/t7oqcNjHc6xiHoBpzfgzm0FAh2ZMHz87agASTZB
         G7iHrcZsD1CLzhKW0qFa+FDQagiGQDcO9omhEixcFq99Zj9VTL/KUJfuMrr14OwM5HHF
         YdK6DzYN9xzaRY/0SpOPATrtioSHV6QUtLQz3uwSntYTJxVsNk7aI4lw1Q1vPXy0Oc/O
         +Ffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721682878; x=1722287678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wFGvL9DSEw7hw4F5KO2hzB8OPf4PNI1O89SSx0g1aqo=;
        b=o/9aCa8QUG7URvmPvobyAvhkVSLbZz9ybUpoIoO9Zlh5JU/jexz/e3IoO1aCr8mtnb
         k4MIOGJBXJIdRsLZAnGgn7+Dm5ejN/t/ZYoQ3xf1qAfclelqgzP/U65X9/uvWA0otCmp
         Z5m6H3oAQLzBc9SmzqACPdCK/v6lNONTvY6e2JLUVq6qVtvGndDP9dCIhc37MeglZNdQ
         Ohx86tm9poEBJvvESanh6zrCGgZ3UzBdcKTm2IbmSpUZEAO3CwfYqMujSR0lFUtKlo0U
         LlT+OsqR9Zv2velfPWmvaDsJPtgjniysI+apZYxt3KEbwOuAf2ELvGrbMyy6sa4sJhLe
         nwmw==
X-Gm-Message-State: AOJu0YzzPF+OKjMZj+26VvMoNr/TCCL2iCdV/j6FKXg+QRVH/zuzGsP4
	pOI2VtBv0iC/Zbu0GwA31ROYzti1rpTyNP4iAYIC1NBnwI9grtQJzGFrdY/Hli0p+W53nsiYB6b
	siVhWXtPUyvvSlaTEEUo7MoxPh7XiX+NQ25ULAWTHJdduz4pxSsCWhY4SD9lI3jv82FHyumXrJg
	gFZo98LdZSR0Z3BUFxdhRAp6lru397j2qierDxFcC5c/OdH9l7LPG3XdJLrw==
X-Google-Smtp-Source: AGHT+IFPsa5+oGIc1rmg0F4U9ktMMqPmuRltbe4o6v2Y2hW0kkM0DVDIXg83Ar/+m4XCxk1tPexWZA==
X-Received: by 2002:a17:903:190:b0:1fd:7fac:a539 with SMTP id d9443c01a7336-1fd7facab28mr46391415ad.16.1721682878172;
        Mon, 22 Jul 2024 14:14:38 -0700 (PDT)
Received: from dev-cachen.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fd6f28cf4bsm59522205ad.85.2024.07.22.14.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 14:14:37 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: yzhong@purestorage.com,
	Casey Chen <cachen@purestorage.com>
Subject: [PATCHv4] perf tool: fix dereferencing NULL al->maps
Date: Mon, 22 Jul 2024 15:14:30 -0600
Message-ID: <20240722211430.61427-1-cachen@purestorage.com>
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

