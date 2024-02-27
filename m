Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70751586D5
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Feb 2024 22:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071338; cv=none; b=lBKbvWSwESAOEvOaZtGEY4uhbbEtwudtfcPm2UrfdDdA7CzPB3BBBzPbzRje+T343GNSzHukU2madJN8cgJkf53+1VRL024+/dS5oIc6blsGBP7lgVOEEITjyIqbFeb84r61Rwszzmijxc5/rMclk7eeFn0PBrBgWNTkDrpEpYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071338; c=relaxed/simple;
	bh=upLg+yhe8A2OZg6p8OFlrhH2yLDrE7BI//l8P1Vylms=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=pqyLHTrrjGbQ00RchUxraYd6c6gAvL0DBjILF6gWxAlW2psDGK3kutau1ZdVPGmOTyE62sY5kb5IXMu8o1QdYrPhjhR8id/bYvWAzAnY5xqFxiZKiMDRvXpR+NCUT/lS+9sXL5r0O6PAUbhBqWHq3nBnvvM1Ae134HZ24IwzDCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s9gcvNa9; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s9gcvNa9"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc3645a6790so8073667276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Feb 2024 14:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709071336; x=1709676136; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vCV6R+NKRLMYoVC59mA+bYuzdEe0EtrTOitlrlnnMsA=;
        b=s9gcvNa9lW/PIzWihQTBqJP0VhTkZpQ2bDTsbEkPcpPLqGv6NTqfIF9gX+jC0MYySl
         osPkLoPBNizf3K41BZSSLigRaSaGT1Qgn9qYm59CQODGL5LG0zYf6iSoQuyc1c5XWaTT
         TGaQukHZ1EJmX6+JatByB8EPKyCCGxF/6W4NW2krDMsZyfSS0Puzq9ziNCM9koeX4+bd
         a3m6oPYQDeFKyHAykaE2jJN3Ub+EOmpJqxC+j5xjSvgVUIi+U8m0pv6MByvY5wiwAWxH
         thikawX9Nj/Nm83tyMYSPhDXLrrW1TrwDhQ0TjXJs84drugGC6t1l/sekw811eMQguc/
         ZjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071336; x=1709676136;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vCV6R+NKRLMYoVC59mA+bYuzdEe0EtrTOitlrlnnMsA=;
        b=CiCTM6u13kA/Jaevt/2fISf2bg0kqTlUAaLuvS2J+dA2ztdS42NovywtF7mG2+0K3e
         a/7jHFJOfzec5NsxEJKhRAL2qf3tuPoTdRdgmoymQqTxvQSAeU1fcGr/ccdEUWgJDz93
         njkRHQen9WSzIbPg9uP79Ffvvb35ubmIZpQ73R2b/Ph9nZlQ09AxqIIY6lMK4l/KDZwL
         mVSNp5njONfBRGVe+Rum8W/9Ky6jjOfNIX1YNG22FvZmJXoWKWaFicpF8LnC8V9CEsQ7
         ZkAr5hpXDSuyBBDoZsyMw2dyg3+d8tX/CX43homSO5JGpqtQ6qgtgaygipxcodvXp/4m
         ig0A==
X-Forwarded-Encrypted: i=1; AJvYcCWoh3ycqgYZA78USP8tUWeLYVIvfZXe1gVUEg5VNCN5FBg3ZV2twr25bWJpraL3NErWqFm8SNW+e629uzRkfMnlL4VIwmiidzzOjima0kahtw==
X-Gm-Message-State: AOJu0Yzc/54qIsoGNP3rlDFGjG88kedRdqZQNuWSj4x13q88R5dY/Unu
	PnsLMpsSyg/gNBK65QxcmPCF7Uol4yCsI5ANeV+NtfN8mU1HJVtGxmSnGcr/y7LTa4jliIu6Soh
	6tOF4ZQ==
X-Google-Smtp-Source: AGHT+IGEhA+c0sAKulaM8RvsHp0DR9xq8SYgR2yBjBN+6kuK+8Tuz+x8EH8gmVr1C3hn6lBPKxh3uS12sCNZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4ff1:8af6:9e1a:6382])
 (user=irogers job=sendgmr) by 2002:a05:6902:1204:b0:dc6:cd85:bcd7 with SMTP
 id s4-20020a056902120400b00dc6cd85bcd7mr220673ybu.3.1709071335967; Tue, 27
 Feb 2024 14:02:15 -0800 (PST)
Date: Tue, 27 Feb 2024 14:01:50 -0800
In-Reply-To: <20240227220150.3876198-1-irogers@google.com>
Message-Id: <20240227220150.3876198-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227220150.3876198-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Subject: [PATCH v2 6/6] perf threads: Reduce table size from 256 to 8
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The threads data structure is an array of hashmaps, previously
rbtrees. The two levels allows for a fixed outer array where access is
guarded by rw_semaphores. Commit 91e467bc568f ("perf machine: Use
hashtable for machine threads") sized the outer table at 256 entries
to avoid future scalability problems, however, this means the threads
struct is sized at 30,720 bytes. As the hashmaps allow O(1) access for
the common find/insert/remove operations, lower the number of entries
to 8. This reduces the size overhead to 960 bytes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/threads.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/threads.h b/tools/perf/util/threads.h
index d03bd91a7769..da68d2223f18 100644
--- a/tools/perf/util/threads.h
+++ b/tools/perf/util/threads.h
@@ -7,7 +7,7 @@
 
 struct thread;
 
-#define THREADS__TABLE_BITS	8
+#define THREADS__TABLE_BITS	3
 #define THREADS__TABLE_SIZE	(1 << THREADS__TABLE_BITS)
 
 struct threads_table_entry {
-- 
2.44.0.rc1.240.g4c46232300-goog

