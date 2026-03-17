Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4857F3803D6
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 05:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773726824; cv=none; b=mJEeLIWOi+0LaODmOZYnYY5rqGfVsAXtl4i8W2AB5EUX7IITQvwyA6m6LLs8D8weOneFjHpsJiX4gsSxJDKMqIhWZp403Grr1wNTKMlM87s9cTVFpljObL5TSrk/r4S0MCHXJSopBGVGFmszxP6iTkrmByPpIs/kGXrlWmifJ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773726824; c=relaxed/simple;
	bh=4mSJoDt19c1s52Ar2qiFo/PGbNpyNgJireRDLID11TM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lozcGHC4FT+xrtJVOChIylXtYi/fw0BaWVIb+HzGzPDi6in2ggIpld2pdIseI4359Ih0D1X7OxrCm4QGex8rTByLsxGPlWrC+ifuXkNmsIm8ForVc370qTlRs7vKTZ9xYtSuunDkV1TZoz1g5PK7yEa8XENVoT9Tlt3HAsc4JCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e2jppqV2; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e2jppqV2"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-829ad972df6so2917755b3a.3
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Mar 2026 22:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773726823; x=1774331623; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jjPd8hYb03Ftsdibhr+aMw0AWnG2dzFR9qnmX2QMSHk=;
        b=e2jppqV2bBUIRMl1d+AbvCcolwtdLSX0AOG2FdGsjQE8e3rgmk1H/inwS8Ziq5DBxx
         9ab6UF53qr73utPneH0bCbPXZfGpBlNuf41imZ0/xJW6AuOKYC+4DgAWIayFlZ8yAMx/
         AiojvGIaPzfzRqlgmfnJF9QVsi0n470bu2uuLZUCe+Y372vjYLF4B2sNC7QSsDu+sUMm
         H4f4T+58a76p7ENqT+lgl0dw1swTsOX5x9WozmCbcdEreoWjNGHhK4QWGOpdLucvf6++
         dnoVdNLd1SFnlChPeirJdaIvU0FGF384MEdUP2vh1JK3L9NntgFtk7nliJkA87nQu7hX
         l+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773726823; x=1774331623;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jjPd8hYb03Ftsdibhr+aMw0AWnG2dzFR9qnmX2QMSHk=;
        b=JUOQXHosil/KUKOv7ENbngZREzMN/i0ZQ4wI7YKmHDiPSlLYzV0fAsDx6WKDKvayJy
         do4KL+IV0eUwycBNG25CgR6CESya3o3qARtJUxcWkW8W1iMBmDCs0kSDoAx/V+qzYuoV
         Jw4+cu2yRW4rfP6wtX8AHEXnE0Nnn0LXquRFlWoENjX1LmLI9YF2kv56LxpxbggiECbV
         TQb5stWFdci2zelBJpzoX/mNHW8Bpf6W0f3Ah9wsnf+vZMkFePVF1EHdyby0JvfCHcYT
         bWB9fsGHbOSPcLl2rR4AmS55imXrTPCRBnsOXtEiPwfQ+osfObltL68gP1t1TIRVW+A3
         dTOA==
X-Forwarded-Encrypted: i=1; AJvYcCUdtFAVVghJQ/wl2njEIAgElJJSLhfEGEe0x6pcpRGJ4PR4BOZQWRexfjvIIQMF32PvWaftFt3ZmzT/lD0q3Bb9@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy6+Oeq+kIXNnsGW0gmi8lclqTIR7DM9OA20DptHT4DLkQKLpL
	oIEXUnB/juS2EBF+zObXnXPkWaz3SFpyY11lytAZpnAlE73DgZ0mfEFMzj5FzruW0fDgW+9TO1Z
	REpLiV6beOA==
X-Received: from pfld9.prod.google.com ([2002:a05:6a00:1989:b0:824:a502:8fea])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:22c4:b0:827:2f87:ac03
 with SMTP id d2e1a72fcca58-82a198fb8f3mr15205658b3a.43.1773726822422; Mon, 16
 Mar 2026 22:53:42 -0700 (PDT)
Date: Mon, 16 Mar 2026 22:53:31 -0700
In-Reply-To: <20260317055334.760347-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260317030601.567422-1-irogers@google.com> <20260317055334.760347-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260317055334.760347-3-irogers@google.com>
Subject: [PATCH v5 2/5] perf target: Constify simple check functions
From: Ian Rogers <irogers@google.com>
To: tmricht@linux.ibm.com
Cc: irogers@google.com, acme@kernel.org, agordeev@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-s390@vger.kernel.org, namhyung@kernel.org, sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Allow the target to be const in callers.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/target.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h
index 84ebb9c940c6..bc2bff9c6842 100644
--- a/tools/perf/util/target.h
+++ b/tools/perf/util/target.h
@@ -49,22 +49,22 @@ uid_t parse_uid(const char *str);
 
 int target__strerror(struct target *target, int errnum, char *buf, size_t buflen);
 
-static inline bool target__has_task(struct target *target)
+static inline bool target__has_task(const struct target *target)
 {
 	return target->tid || target->pid;
 }
 
-static inline bool target__has_cpu(struct target *target)
+static inline bool target__has_cpu(const struct target *target)
 {
 	return target->system_wide || target->cpu_list;
 }
 
-static inline bool target__none(struct target *target)
+static inline bool target__none(const struct target *target)
 {
 	return !target__has_task(target) && !target__has_cpu(target);
 }
 
-static inline bool target__enable_on_exec(struct target *target)
+static inline bool target__enable_on_exec(const struct target *target)
 {
 	/*
 	 * Normally enable_on_exec should be set if:
@@ -75,12 +75,12 @@ static inline bool target__enable_on_exec(struct target *target)
 	return target__none(target) && !target->initial_delay;
 }
 
-static inline bool target__has_per_thread(struct target *target)
+static inline bool target__has_per_thread(const struct target *target)
 {
 	return target->system_wide && target->per_thread;
 }
 
-static inline bool target__uses_dummy_map(struct target *target)
+static inline bool target__uses_dummy_map(const struct target *target)
 {
 	bool use_dummy = false;
 
-- 
2.53.0.851.ga537e3e6e9-goog

