Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E11C1EEA3C;
	Mon, 24 Mar 2025 23:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742860371; cv=none; b=eVZDnUDlf5CvmesOwMxOoMhyHfmmY8+HyAXo9QflFkDLo+xK7bDfUeVb/rqdcA8aNxDiW7CrjQvgEhEgfRdqDalMVkEC/Hm40CuBlR1TYMmkwyTnRj++pbn5coMQxyzv1tccvOh5UUnLMY7AXo4LzTBcJ+Xi85B20vhv6gduaqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742860371; c=relaxed/simple;
	bh=DiJsWHPjtn1sDdKnXVT5JOA6F+zvL5kq5vp/JkQmp2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NI3VZe3IGD9YAkh7ngRgjdSjg359y/RmpbZ0nE6h6BmEkLcLByTRpZ3JHMaf6Vo08caeFlhy7pm6JCa0yq1kE3kXny4PwF+089ophfPYwP38tZITGqgqJu/I6GLsSEHdHTcPAur+4gipLIbtb6K7JFT1Z8kOSN8uEIFxvPaCfPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6ldQCNk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6ldQCNk"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-227a8cdd241so18876285ad.3;
        Mon, 24 Mar 2025 16:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742860369; x=1743465169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yNO808lpuhv7vbZscCJkd7kdAd3UYBYPDAJQ4hZ1maY=;
        b=i6ldQCNkSzaJdmJZb+ejJ0gEBjPxqiFXKLQy1INjF0NViNA+WsYnePazspixPgIVQc
         bn4Uq52LwWuwTh/dDcTsozvwy17V9xLhLdzAizvby6TraZ5ligAzbKEY1iD36X/7J4Y6
         hWLjgF6upbrNxWP/6eBOQlKpko0Cok8JIrzy1bLEXM7Rr+NZssFHVTnt5gcdWD/99FGF
         RLYjJMtEZ/21CB36UFoXKerb/i/gCwmnR6tydtYcGCbRWNSa+9252mQbAyEIALndTdch
         Q+ohA2CFYaJGYDssqJxyfpGEUlSccv8zv1xTL0KWcwHLN3d4ueTalwrpKPZjv5JAsTK8
         ne+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742860369; x=1743465169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yNO808lpuhv7vbZscCJkd7kdAd3UYBYPDAJQ4hZ1maY=;
        b=npZT8yYPHvLBLv0Ho5ZdlMZiN+Js0h2L1Rgylms/NXjhso2q0UPXU3y5QDqrA9ehVt
         cSPe/pkVQByL1jT4jnGroI7GXqFURDPX5h/HhW2DgV3czl+Rfacci/+SEM6X8ADe8CXB
         vSRDwX1CxH16xPZS8T1vrLnG/q//P+IpH1fjwg9OeVU3aamdRFdcYx0BiAhtEM6FglHJ
         jL+go3f9dao8K1MKjxVgr2W3XS1bkq8AY54hyEL87XDaLIZ+cApZyyuUKyUR0+b5erD3
         BO0c5RMMgMqkXl0oCHDXWhptQmHdoPy3teafSWz2/SZyxO1BPYAE5QpFYWLhrTRzfC9L
         /iBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlPi8rhwq+1fTdSSfgnB5J5mdwln8SgwFr2eV4skyesvVLUX11Nxqr7ZLb4EtT7v4h9OoYPwtk6hi/1eA=@vger.kernel.org, AJvYcCXoKOIqsKvIqEEBUFeG7NM+aOr0Y1KIgsrqSsu2LQhnTRtW0M6VCAHZEhvWfYjhLvzLTSMmypy4/DeydvFTovEM3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpD4wkFW8BsOLZwyXBlkPZef2c4v0FoMSOkxiUFZeIAAxfvAh9
	5V3tOzdd3KTwQ9zot1HuHOLHTxtzdqVLUE6MH4Cjg/Xcd3PgOvsQ
X-Gm-Gg: ASbGncuAMV0qr/xBsgepVcDCCZJAvfSrJeqFU1RP1cKUZGDcW3Mj1gYjX8o79CFCA7/
	A7HNZM6jKNdw2x59SpVzXcSPTHvtIBTu+FhQGY7aw0KFvMlt7ujA5hRzvRjgxilSe3/21dRuZ8T
	t8oRJJrBVP32gjwuIGjtPPK2gGX/zl9nuQMAUraOoxD8xgLveWRRyF+gTSows52i1tQmTukH3Va
	0cDHLynpVDhFMTGmRNwnxjD7zNo6UF/VOpFs9mQ0LZzZFACqkUVVeObA+RTf3LR+cDCx3jebhdJ
	5NyGQS/2E7s49bmnZiiG9CJKnMwtOktBJIdMuh7T7wcRospN6QCwP3MykP2VyqAGRwLixybg9rv
	Q0qIW
X-Google-Smtp-Source: AGHT+IFaqEVXplEsEDRGUr0QQXMFcp68kv72Z+LpVsZby/6c2rqwRKD2nl6A3q5BT1wYq2XA5eHdKA==
X-Received: by 2002:a17:903:46c3:b0:224:a79:5fe9 with SMTP id d9443c01a7336-22780d9473emr236122745ad.30.1742860369372;
        Mon, 24 Mar 2025 16:52:49 -0700 (PDT)
Received: from howard.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3980dsm77232225ad.47.2025.03.24.16.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 16:52:49 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v1] perf trace: Fix possible insufficient allocation of argument formats
Date: Mon, 24 Mar 2025 16:52:45 -0700
Message-ID: <20250324235245.613063-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In my previous fix of runtime error(Link:
https://lore.kernel.org/linux-perf-users/20250122025519.361873-1-howardchu95@gmail.com/),
I made a mistake of decrementing one unconditionally, regardless of
whether an extra 'syscall_nr' or 'nr' field was present in
libtraceevent's tp_format. This may cause perf trace to allocate one
fewer arg_fmt entry than needed for the accurate representation of syscall
arguments.

This patch corrects the mistake by checking the presence of'syscall_nr' or
'nr', and adjusting the length of arg_fmt[] accordingly.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/builtin-trace.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a102748bd0c9..ad6dad8e2453 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2139,6 +2139,7 @@ static int syscall__read_info(struct syscall *sc, struct trace *trace)
 	char tp_name[128];
 	const char *name;
 	int err;
+	bool extra_nr = false;
 
 	if (sc->nonexistent)
 		return -EEXIST;
@@ -2176,20 +2177,22 @@ static int syscall__read_info(struct syscall *sc, struct trace *trace)
 		return err;
 	}
 
+	sc->args = sc->tp_format->format.fields;
+	if (!strcmp(sc->args->name, "__syscall_nr") || !strcmp(sc->args->name, "nr"))
+		extra_nr = true;
 	/*
 	 * The tracepoint format contains __syscall_nr field, so it's one more
 	 * than the actual number of syscall arguments.
 	 */
-	if (syscall__alloc_arg_fmts(sc, sc->tp_format->format.nr_fields - 1))
+	if (syscall__alloc_arg_fmts(sc, sc->tp_format->format.nr_fields - (extra_nr ? 1 : 0)))
 		return -ENOMEM;
 
-	sc->args = sc->tp_format->format.fields;
 	/*
 	 * We need to check and discard the first variable '__syscall_nr'
 	 * or 'nr' that mean the syscall number. It is needless here.
 	 * So drop '__syscall_nr' or 'nr' field but does not exist on older kernels.
 	 */
-	if (sc->args && (!strcmp(sc->args->name, "__syscall_nr") || !strcmp(sc->args->name, "nr"))) {
+	if (sc->args && extra_nr) {
 		sc->args = sc->args->next;
 		--sc->nr_args;
 	}
-- 
2.45.2

