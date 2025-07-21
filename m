Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57C72DCF4F
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 13:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753103126; cv=none; b=Fd1aRKNoGyLtEu4fR/D/SwoUAz7UJwd84xd/yr2N7Ap/EanlzDS2JON6kAbNzZtVX++I0LGe2w04IG4WMUV3KHZMV9Wr/UNup8tMqow7/SRhLTQMmgOWUyS06I1h2scJUGXnkPWiFMvcWFsh72yMGBykwa49m8gV8x5AYn5hT2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753103126; c=relaxed/simple;
	bh=b/ttJae4xiEHONrSB61gWYPCVcnCnqIpQyNKL5V/Pqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kbKow2esvs8DdvIFBBA4PjTMVYT0lWGA8KYZXI1EkiepERs5u7GJ2rPsk7hLZG36uDml/TgYLGymCnRkLoa5ledOwgsRTYIzF6zf2WKcTVQvLCurEh4Ki2JYzp6nWwN2RtbzFm+ZJfEImJ0Hqobve5WKTui8huJ3tqam1emvFu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qQlpmKsX; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qQlpmKsX"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so2760392f8f.0
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 06:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753103123; x=1753707923; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGtpCZfgBTuGsyBPIkbeq53HmntuKbontBvcg3TVESk=;
        b=qQlpmKsXEdRSk8zdwhOzInSekKeRUG4mdTqXX703NVvJQK+LBUT6sqlqeBWkABHvK4
         100Pwf8M6jwhq9YXV/v0vMn5LZ/xPlhDCQExu/RXIe99YZLCZw4DqabDDyhUPEl3vbXl
         psNxeu9xi4S0+VShYCXUo2bBNsRjcdSX29y3zaamf/3Rf6zVfEarmBp65g2tpBwf8mVn
         lclNVBKJ8p9TZnkOtEzIMf4MUZl3iQDPb4ULTp0DrqgUWiOgW3s9K8NgIlx+5Toi7VG5
         XWI0Dq18LMJTLmrF4zOMjoe6Iu3JI1lFtjouwFJ24DJ3Ys30ez+Y654XqVF4u3QJhyca
         0rQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753103123; x=1753707923;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGtpCZfgBTuGsyBPIkbeq53HmntuKbontBvcg3TVESk=;
        b=CoO3wZOasbcNO5vBfn6SdzVwdiC6GzqIFIL4C4Rky5IJr6Eyk4+cpyb6Z/xdVPeYeh
         wpWC6UNRpK6/0wH44IyrCJwhD2eceQeGCuzvc2TLOZcnU4jnF4/Yai1aJAY4vFsLB0rU
         YHycMt1oWbBVBwMv1ZerxMx0ahB7Lha3ieq5qecgU9OzSV4rB8LrqtqXrf0x/8hYi2V0
         wLbjBVrpHSESPDc72puE/LfTNbch0YrjZVCLwn/0t0f60+Cd5n2Vyvp134q2K+3wpOjm
         Sin41SPAF+XZIaFEw6JtEWvdUFOC2BX6JUEavnh6dr2qvYFRoMZhXaPEKmbV2YgLlaTw
         CcGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU36Func8clFKvepvCXfBqS71jFzDOk49OizGagds2oQvZED8V/TCscOhi9CEpNbg7MWW19NBwTJmPopIoVSQZZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd/lyyf6B7Pbf8TYMYvl8j/7O7V46NVhXap32FbbpUGmhxwv/s
	3qpAc/WfSqWQA8lg4ceAaigft7mDGrxBLnoLlbNsutBLT3dcz5w0AbDojuhnmXXSfeA=
X-Gm-Gg: ASbGncv0PSjLQyWqbX2iPL/I/A12yPmtuqeJeZrGqf27AalQmwmFHfLt9VsgLwZh9AD
	UlgLXRsMMb4uJIlP4ex8YyNGlpMg3mz+9kNboZecdB5tkZx6idLvb+piY+gFqTeUaaedZxGoYgX
	aFhOxjYY+UwVQZOeOp7vHuVMQanFdvEO6HRlhTWjk9dyX9zJlwSj5V9yfl3qjY5KGXFaEQnhOew
	4u/BVj4e4EmD3eVicY2Vr54plgpm+eDSEnUSWX3zyT8TS+FPqvurFWSAt+8NAOADItbhk7lcbb1
	MtDqJ0SUA4LYjaaZfHiff+f5YBU+LvuG4Y7ojJDnBeoyyUzHN4h1e446bJZ1DSipOqPrp2t//5j
	D6B/FEo7T15LCk3Le2J9DdIcEHx/zPvg=
X-Google-Smtp-Source: AGHT+IF6B+UvXtx0IYpruCvoBGXj7r+Qm/RbuQTzDQMBKY6Xx1qYG8QQ00o/M8y4LjQhDqQ1Ad7BQg==
X-Received: by 2002:a05:6000:25c4:b0:3b5:f151:207f with SMTP id ffacd0b85a97d-3b613aa23a2mr14510920f8f.3.1753103123024;
        Mon, 21 Jul 2025 06:05:23 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c632sm10485077f8f.80.2025.07.21.06.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:05:22 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 21 Jul 2025 14:05:04 +0100
Subject: [PATCH v5 10/12] tools headers UAPI: Sync linux/perf_event.h with
 the kernel sources
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-james-perf-feat_spe_eft-v5-10-a7bc533485a1@linaro.org>
References: <20250721-james-perf-feat_spe_eft-v5-0-a7bc533485a1@linaro.org>
In-Reply-To: <20250721-james-perf-feat_spe_eft-v5-0-a7bc533485a1@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, Leo Yan <leo.yan@arm.com>, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

To pickup config4 changes.

Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/include/uapi/linux/perf_event.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 78a362b80027..0d0ed85ad8cb 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -382,6 +382,7 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER6			120	/* Add: aux_sample_size */
 #define PERF_ATTR_SIZE_VER7			128	/* Add: sig_data */
 #define PERF_ATTR_SIZE_VER8			136	/* Add: config3 */
+#define PERF_ATTR_SIZE_VER9			144	/* add: config4 */
 
 /*
  * 'struct perf_event_attr' contains various attributes that define
@@ -543,6 +544,7 @@ struct perf_event_attr {
 	__u64	sig_data;
 
 	__u64	config3; /* extension of config2 */
+	__u64	config4; /* extension of config3 */
 };
 
 /*

-- 
2.34.1

