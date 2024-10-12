Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023A112CDBA;
	Sat, 12 Oct 2024 04:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728707339; cv=none; b=ttrny17QPYrHPUEhtQVIAWZEMX26xr8VLMk1x6voBsFMbQ9ShMnD06Xgtq977M67s9ZIgfQ1HMR1wkb4+kt8KFNxRl30nP6PCsl77dEQu3BzhRh1O8RrE/ybEoyMDECS02yBPsK02Ev0hDXOVsS8XPHgeMdGuOiTKBa6dwQfHfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728707339; c=relaxed/simple;
	bh=3WplEoGi1BsFr6YFFonm+1lYODrrYuC3FQstIpRvcu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P8nLKnWtUxxb1EpAYsuMfe61MmnEH795qB/afDqzgxsP/Tqkdtc+X0ouUtmOxSauLL/8rHOBxi9ZXw05ZZJq7SVDJ4XLw7nSZ7zbb2LQofBIXbImckOHCk/YCzWdhzeo18+AyCRweUHSWdsVqn1Ao2+jDTwDcvw8+mUxTIMbRSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Md5CUrY8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Md5CUrY8"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20ca7fc4484so8448755ad.3;
        Fri, 11 Oct 2024 21:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728707337; x=1729312137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoC9L8TgSrSvS21Od90ZP1h/vkV/JuDG96YqG+cDQ6k=;
        b=Md5CUrY8spsc15o02qxsdE5GTf+9xh6olwFD8+mYwKPT+kKWkvlZVqR11hCBPApes7
         Yt7WE2ZTFXvzF/LcU93xCmDyt+GU/In0UJT6EFPcSRjxkKspMLUCRillPsFEvT4KJ9dJ
         lfW8dRk4fD03jYs6CWrGKrZ+nB+1oPWhlXIsR4lp7O39lmRklUN8htmGy+5/wIWJ66fd
         t//qmLyfblPanP1Ny6A22xkZR99xi98vITFzdbdLzTk0AXrSkltGEFJRE+tiGn7QKr5c
         zr7PCxZpfm05/gsw60wn5BS9otZH+FTx+tLHfsI8ObosHj1Vm3PxJ1aXhd/TUTVjNKCo
         e8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728707337; x=1729312137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VoC9L8TgSrSvS21Od90ZP1h/vkV/JuDG96YqG+cDQ6k=;
        b=g9gdlf7vFTTyOzaGEDURBS3+Fox4LAzG91JI9Tfm6UGIA6MdDv0coIuUFdaq2jq0hy
         xMsyXKdyiuNLWEhQeaKc2ZvObBw9NcGJIrC5oWi9l7G323SyMteGO3ZigZw4Oz/r+Q5x
         ZHE7OLhDcU/7b8ViNvk2aaVokw2gLf65WtZ6lBHCku5u+3ThFbfsV/D+IfGMcCTt45Cy
         Bc6xlCGs8ru92ZxRFIiS1E0RxDs6a70Emr/3JWpZGMQfYh+iirIGK0CMpwWR0VONaO2L
         VvS92vCBlBxOzVDZHvRDlwqhBxYTIUH7mCq03FOzs5mM/2tC1A20RUxWdGjdiKNUULT2
         wTrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0zutFw454fVQPBhzXllTXOFjJDNc1KRcvR35MLXhDYh7hJ27eLPwsKO7djOB839tn9tfdlmbfOcUJJ4m8ZR5v8w==@vger.kernel.org, AJvYcCUBZhk0J8P9HrsAa9KEUDBR+Ul0EtXhw5dOfQ7dp25OHlJHi6lwkw2/Uzcd534l+fT7TtmM6LYJrqyZfA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtPwLpJnP1GfJ7sd232cU09lRGFmyFhDdunJnEXLuTECw7gOkh
	XaFNr8PE+L2DTA5A3dwwI4pkbwDVdzqDPWdmvm1fvMeJTHzjD/ye
X-Google-Smtp-Source: AGHT+IGzoiPgXp+c/na0L2A0nXhMZ/eDvdJYZD9CEa/q7NScMC1ieeXW3F2b2b52t/W7hjAJ6UzBEA==
X-Received: by 2002:a17:902:d509:b0:20b:6d82:acb with SMTP id d9443c01a7336-20cbb19ce4dmr28027795ad.23.1728707337181;
        Fri, 11 Oct 2024 21:28:57 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c212fc7sm31017165ad.204.2024.10.11.21.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 21:28:55 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org,
	acme@kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 3/3] perf tools: Update expected diff for lib/list_sort.c
Date: Sat, 12 Oct 2024 12:28:28 +0800
Message-Id: <20241012042828.471614-4-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241012042828.471614-1-visitorckw@gmail.com>
References: <20241012042828.471614-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since there are no longer any header include differences between
lib/list_sort.c and tools/lib/list_sort.c, update the expected diff in
check-header_ignore_hunks accordingly.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 tools/perf/check-header_ignore_hunks/lib/list_sort.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/tools/perf/check-header_ignore_hunks/lib/list_sort.c b/tools/perf/check-header_ignore_hunks/lib/list_sort.c
index 32d98cb34f80..b7316d29857d 100644
--- a/tools/perf/check-header_ignore_hunks/lib/list_sort.c
+++ b/tools/perf/check-header_ignore_hunks/lib/list_sort.c
@@ -1,11 +1,4 @@
-@@ -1,5 +1,6 @@
- // SPDX-License-Identifier: GPL-2.0
- #include <linux/kernel.h>
-+#include <linux/bug.h>
- #include <linux/compiler.h>
- #include <linux/export.h>
- #include <linux/string.h>
-@@ -52,6 +53,7 @@
+@@ -50,6 +50,7 @@
  			struct list_head *a, struct list_head *b)
  {
  	struct list_head *tail = head;
@@ -13,7 +6,7 @@
  
  	for (;;) {
  		/* if equal, take 'a' -- important for sort stability */
-@@ -77,6 +79,15 @@
+@@ -75,6 +76,15 @@
  	/* Finish linking remainder of list b on to tail */
  	tail->next = b;
  	do {
-- 
2.34.1

