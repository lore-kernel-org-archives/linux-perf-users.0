Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FBB1FF5F3;
	Thu, 27 Mar 2025 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743060649; cv=none; b=EnXuhBzHJ9Qpl9sR4eO/R3IzsIqgM0lkl+Hh/CrC+Hs2HW5MLQ2HWyS3FT4R4HFNz1yTUBJOu1tWBqzsBPAWrR1qNDFTO+WPsWIhl97U6pMKgEB82eVCmUTsx6Hl/m+bA+FNGdPGZRlo7HhUL+IHh3Yb8AgYoOvO6SlEOVQPXyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743060649; c=relaxed/simple;
	bh=XkVDYKgfGHlmxiQCSeFDSgKyf0AXTvepXpEwbSTINpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VzoMqbvEoMaK80NE+ubcoBm24t98E2rGnb7jBE72H/KNUkkpq2ifw6zH4UHh1xsr8QHVGVxsO2IqQguwxJcGVoCOJxuZ5cZupo5Zril6XkAOAOH+Ejm27YYCPjqVg0Rzwh43n7AcwvNYjNBhocbrBxwoE6LME/GHPl1y2nij9CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffn8xklC; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffn8xklC"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-227aaa82fafso14406675ad.2;
        Thu, 27 Mar 2025 00:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743060647; x=1743665447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fIsgSqbVtMcV6WZx6Min9su3gUMVh1BkINqCEFQM9do=;
        b=ffn8xklCRIaxMsPGF+dYLqdVgHt5qpP4hwbs2kxczanOake+KPSTZv9/ezTnESNNMY
         1HIZbU7XhTM6hQpGCTjkFo3vzv3lexMdaWo7AFqBClnkoCaNhqwxgbMqoaJVAcHeh/Rk
         c16NDBcR+5Yhv3FTV93Kz+OGCJBHeWvJbDUQnyqEDuZCXHcxpwSUgQQM3L6kighg9x/t
         GioYLaqrHUG14fXP7MhcplzSS+fVv6cuBfZz/zPFfRHlpdBbTKdJR7zLreDsnwG+98z8
         fv3MOE8KdZLCBPT3h+Zl2amF1/mXH5j8Kq2FwpV0xHLJARsqOCKdAKM46jo5rB1ZANxc
         T+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743060647; x=1743665447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fIsgSqbVtMcV6WZx6Min9su3gUMVh1BkINqCEFQM9do=;
        b=SfFOxc2vawJitc1MJ7O9xo5bEHkKNOcKfD167eRksud7WMPSLeLLIT2Ej0FMUhJCw2
         Pgzev29XukU/epOwDzrJmx/dbqnj1XHmZq9UT+OodMGwsMbGaxwtn2ZewE2ZKFKlRxzN
         KDc5PPESo0pF45vkJpUeVMiLxK78vwI0bp6auuE0+kKwmidpo/c9qZcEcetmQGHi6GU/
         BHeTEEazf2BaUIDrRkEpJxFfyEHDH5uIB20pRYj+5mRIEis+1TH4tlTMoMDoxs2gAkT/
         XO0rhDL8Pnqlh+nAWAF0ctw29FywvTR9ZpsjDZns4W+HCM0/Po+8eLA+XG4bB77IsKy7
         RrsA==
X-Forwarded-Encrypted: i=1; AJvYcCUWTpT/zwRnAZLUniDKjEyf55zJbNBAYHqwISMAa+HJOhxbLkHcqQkw+fceBXNXraO4M50m2fmXIQxg7CLvi5Actg==@vger.kernel.org, AJvYcCX+i+D57sBI92D2u4+ejYbda1eBDLLxvye4iQVfYrUGDu3sMI+R5CZ0qFBbaWYfdR9+8vf6DIIARHqrUQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb//5nTilfpfjAgXxy6ydpB2aWuKzSjwGW4788QLJn9rOaKwL2
	uTa6NTqEAGG3w5cy/ImnDn9QNcJYcRDUnnTgSsPQWuFdzsV/alOi
X-Gm-Gg: ASbGncv/FCEE/sq76SEuqxAB7TO3lDfno7oJuLZB5jDOjUYHWAdGeAIZRkp+fgNb7z7
	Yfe0mFrqDMBBHMcu506H//z4xmRFHmno5B9+qJhYZybhHJP1yCGChMut/WpvXWNuHbEAKCNPkCB
	CSX2618OBY8eM7NpNev3/vjg/gQVbfBVCsFECivr4FLrJO2p1NVmjR5nP4mOxswSDWBe7dKDTOC
	VvQ/KfJvEcqAZ/RfmSRZObRH21U0KLYJnsDf+CXMNUVLuLq88KWjh9y4uuuKcLX14vDQIVTkBiz
	fI9lbkSFvuOdYnh5BcS4K495oD6RYUpQeU+03VUWNPdrJ16nHdIPE7cttxQgbRdAu3XIJYumPsD
	6yaql
X-Google-Smtp-Source: AGHT+IH2tulkKqvsgpZFbmzM15tHs2kSCbVktLnnpu+HDYbSNnkz/J+5vAdGBs4rtida5ApGOBsEDQ==
X-Received: by 2002:a05:6a00:2305:b0:736:9f20:a175 with SMTP id d2e1a72fcca58-73960e0fb52mr3707286b3a.2.1743060647183;
        Thu, 27 Mar 2025 00:30:47 -0700 (PDT)
Received: from howard.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7394abf74e0sm4303626b3a.24.2025.03.27.00.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 00:30:46 -0700 (PDT)
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
Subject: [PATCH v3] perf trace: Fix possible insufficient allocation of argument formats
Date: Thu, 27 Mar 2025 00:30:41 -0700
Message-ID: <20250327073041.1956482-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:
* Add Fixes: tag

Changes in v2:
* Simplify the code (written by Namhyung)

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
Suggested-by: Namhyung Kim <namhyung@kernel.org>
Fixes: c7b87ce0dd10 ("perf trace: Fix runtime error of index out of bounds")
---
 tools/perf/builtin-trace.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a102748bd0c9..439e152186da 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2022,9 +2022,6 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
 {
 	int idx;
 
-	if (nr_args == RAW_SYSCALL_ARGS_NUM && sc->fmt && sc->fmt->nr_args != 0)
-		nr_args = sc->fmt->nr_args;
-
 	sc->arg_fmt = calloc(nr_args, sizeof(*sc->arg_fmt));
 	if (sc->arg_fmt == NULL)
 		return -1;
@@ -2034,7 +2031,6 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
 			sc->arg_fmt[idx] = sc->fmt->arg[idx];
 	}
 
-	sc->nr_args = nr_args;
 	return 0;
 }
 
@@ -2176,14 +2172,9 @@ static int syscall__read_info(struct syscall *sc, struct trace *trace)
 		return err;
 	}
 
-	/*
-	 * The tracepoint format contains __syscall_nr field, so it's one more
-	 * than the actual number of syscall arguments.
-	 */
-	if (syscall__alloc_arg_fmts(sc, sc->tp_format->format.nr_fields - 1))
-		return -ENOMEM;
-
 	sc->args = sc->tp_format->format.fields;
+	sc->nr_args = sc->tp_format->format.nr_fields;
+
 	/*
 	 * We need to check and discard the first variable '__syscall_nr'
 	 * or 'nr' that mean the syscall number. It is needless here.
@@ -2194,6 +2185,9 @@ static int syscall__read_info(struct syscall *sc, struct trace *trace)
 		--sc->nr_args;
 	}
 
+	if (syscall__alloc_arg_fmts(sc, sc->nr_args))
+		return -ENOMEM;
+
 	sc->is_exit = !strcmp(name, "exit_group") || !strcmp(name, "exit");
 	sc->is_open = !strcmp(name, "open") || !strcmp(name, "openat");
 
-- 
2.45.2

