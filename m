Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12D917C7C9
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 13:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723469186; cv=none; b=TSfz5EWDTZ6fkAOPfTK705W/J/Hmp5ysTzD89xZMRRI0GZD01wdFLsh3xBLff4rmzUO8zozEVomxNQHR6aeO48KS7+jzXxUVRUEmmxuwX6cPE7ypoeY0Z/fXR1zaw8/cuAKLXTLEWLFznQIsqMrLvB1TTS/UUkGxrWYKQ7+BpS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723469186; c=relaxed/simple;
	bh=X32C/zgw2k4Chfqvi1qvoLWS0TzSKZ3dcmHueJwpN38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cp9WyH1x+UPYShgU842HtEQca/HsFFV6PAiZ4vWjEMpdRGB6m3PDlEer4CyDwuOKsEQHEW2QQcQn20Mnxo+CAUe67nP/OqEF74IBg0tzEvCzf3khbvzBMApO1GwvSC373FRCq9EWduKl0XoIZqPvl1Kx5JtNwSS6K1SmSA4h4gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Go4x7yuw; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Go4x7yuw"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7a264a24ea7so3228768a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 06:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723469184; x=1724073984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGdm6FoC0bpCgULiHVrsDT8TBvPGobT/sZVUlThjbGI=;
        b=Go4x7yuwMe9+903cp2X+I5rQIJ5ZSl74IgY/npFDSD/4vNJotvjKKQ1CGXX0zmCeDX
         ek2RY51FM4WDaujJsmouXEIMiZJZBxw96bkEaFNYK37R2bm8FKzeuT6NdVwuVWNgWl0q
         7u151u1AXTtFf85qX9E/KgBSbGS43qdH1uMjJ4fmhqrT00S7V2JVUOje2JzcMSfzxvvw
         fX9WsGz6+vIy7PIcoqZni2pIUNeMLghSrKXddF5hYJSlGnGdOmPw3KYmtx7FsvrBMKY8
         e/Ebl/M025vo5tNY1+xKPKMdRfgU67O19orpw8w1jmShNP/EU0yUpFWGEFKWtbR6ajmm
         NSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723469184; x=1724073984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGdm6FoC0bpCgULiHVrsDT8TBvPGobT/sZVUlThjbGI=;
        b=ubABVh/o6RS/AL80XklxuQcRYSM3KpHFVdY/Rz3iowHbBd9Bcabbs/ns6Vd7IrbtKQ
         D5QjTgQ5TBPTQCnRpGjnLfAwaLS4OQV2ylknDBP26I9gIx+OnsdGnJ521Us4DPO7pk4u
         COsZXmdLI2yhWH0qewLq2KmVdBtikZ3F8Mi8wTbcinSOawqVmYp+2E3eXb2hr0vTjZ0e
         6mVlH9blTJ3XY7Gs1GTaKdB5uzNTbRVuozJty44/umEyulYzN7NV3ADtrMt4KWmk6oHn
         A4BbHQ2Jy8r6k3BqSzvzGvi23l1xCTBn1vrM35c/bPThJozmw8gAKV9q9Z6w1ei58IuM
         mORA==
X-Forwarded-Encrypted: i=1; AJvYcCXkdv0TE/JYdzLuF2sNfPwk/FeftW8RSN7si2YeGenj0Hrk5xiveWRXMR1CSQ4hLNgn0GfRT6Yvlm74xGkt/9VFvGm7NeZ8dXHLC1jEUhHEKA==
X-Gm-Message-State: AOJu0YwtUHZY68+V7w/7Tz/1WRagkO8x8Pfr3z80w9kcx7HbHsoYO3c2
	OwCkFCTpj/0uPqY8oOXMVfNpxfCT+W+4XBzkMne3+Y/mxIXo9jflewd0tuaBMgo=
X-Google-Smtp-Source: AGHT+IETvaxUSjbxv6yfrA7sNvMWoQYseDuUSEtCAP2be3HaShYUFKBOeNSVbImgcYwZiy6vfyE7Jg==
X-Received: by 2002:a17:903:1c9:b0:1fd:82ac:7c2e with SMTP id d9443c01a7336-201ca1af358mr3585255ad.25.1723469184201;
        Mon, 12 Aug 2024 06:26:24 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb9b2f81sm37683395ad.150.2024.08.12.06.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 06:26:23 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	james.clark@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH v2 2/2] perf sched timehist: Remove BUG_ON in timehist_sched_change_event()
Date: Mon, 12 Aug 2024 21:26:06 +0800
Message-Id: <20240812132606.3126490-2-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240812132606.3126490-1-yangjihong@bytedance.com>
References: <20240812132606.3126490-1-yangjihong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BUG_ON(thread__tid(thread) != 0) in timehist_sched_change_event()
is redundant, remove it.
No functional change.

Fixes: 07235f84ece6 ("perf sched timehist: Add -I/--idle-hist option")
Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/perf/builtin-sched.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 177634df1ba5..309dcfb3796d 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2700,8 +2700,6 @@ static int timehist_sched_change_event(struct perf_tool *tool,
 			struct idle_thread_runtime *itr = (void *)tr;
 			struct thread_runtime *last_tr;
 
-			BUG_ON(thread__tid(thread) != 0);
-
 			if (itr->last_thread == NULL)
 				goto out;
 
-- 
2.25.1

