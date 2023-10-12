Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E806DD2EE
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Oct 2023 06:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y5oLkfN0"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694C3BA
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Oct 2023 23:24:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a3e0f8872so850821276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Oct 2023 23:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697091848; x=1697696648; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e5eVmSUwSJxksG4NuITaTSZqNGvqcD7jLZAKoPJCuWU=;
        b=y5oLkfN06TgWXS3T+DIqI41033RTHqlG50bSK7V7VQbAhwhGGcSjc4qAwqKygliEMw
         Dzh/xEbTTErZN4BVS3Pbn0pku5E1Apc/bqPd6Ijh7VRRFgk3TbWeg64L30Wc1WorAbDI
         YG3JeTkPUZUCwugaaFoloZaSE8CctvzKlONXqM6TlgyEdq0KhiT+M4srskMsnAlW5Lt8
         /KhwYKQQyxkmrKvpGXmEqd1ntx5trZWSpnYKse13WRT+Ojt93O7egD7ZW47xYOAYtqCv
         28251R+c3r7BXlB9v+5AgoBC9rpcEwCudlwhbgLlNKT8+UqnTLAEyDDeYiOAAEBZuw0Y
         03CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697091848; x=1697696648;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5eVmSUwSJxksG4NuITaTSZqNGvqcD7jLZAKoPJCuWU=;
        b=onU2FxXp7vyluW9pE6OCcQGEgbKrDuTXHF5L8TNYrssQS/IvrS3I7iyPwadVAtqcQL
         EUIj+rg6RgM4kLZKvxGuRgBRiYxpByAog3BMdBJQ5Bf3WghrXIFvRODSIC3bKWJ8knZX
         RrjDeY6DuAj/bfbUGasMh66iXGttC7ilrlM+n1egeY9dZgIwVRixkM30nKR/iQTZAiFb
         muVyvpn+sYe5sgWYRrI8VYSXM48e5Xv4d61mJ8Fu+cj0kc1YI2Ww7tgVShHlfK2bMMdk
         T5WBvtvmenmzFDNedLagACyw9U9JThthoK5+wbyOuL17vnSCls8K9k2vfFko+I/5jXTt
         1DUw==
X-Gm-Message-State: AOJu0YwMG9t5ETB6x9I25dnaJ1smG4NEUt4IeEyKjoCRI8s/Ds/SrBCK
	I26o5h6kdwmOQMWRjcnSJPjldUjzFfjt
X-Google-Smtp-Source: AGHT+IFmqFq4/wm5EgdUd3x0JEaVUvH+YjHVcBVN3IPYbimtzwGlyFiTzZuU2AziiY+gjwegOfUSdr2DJPxE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7be5:14d2:880b:c5c9])
 (user=irogers job=sendgmr) by 2002:a25:bccb:0:b0:d9a:61ca:7c7a with SMTP id
 l11-20020a25bccb000000b00d9a61ca7c7amr138294ybm.11.1697091848675; Wed, 11 Oct
 2023 23:24:08 -0700 (PDT)
Date: Wed, 11 Oct 2023 23:23:48 -0700
In-Reply-To: <20231012062359.1616786-1-irogers@google.com>
Message-Id: <20231012062359.1616786-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231012062359.1616786-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 02/13] libperf rc_check: Make implicit enabling work for GCC
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Song Liu <song@kernel.org>, 
	Sandipan Das <sandipan.das@amd.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	James Clark <james.clark@arm.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Leo Yan <leo.yan@linaro.org>, 
	German Gomez <german.gomez@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Artem Savkov <asavkov@redhat.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Make the implicit REFCOUNT_CHECKING robust to when building with GCC.

Fixes: 9be6ab181b7b ("libperf rc_check: Enable implicitly with sanitizers")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/internal/rc_check.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/include/internal/rc_check.h b/tools/lib/perf/include/internal/rc_check.h
index d5d771ccdc7b..e88a6d8a0b0f 100644
--- a/tools/lib/perf/include/internal/rc_check.h
+++ b/tools/lib/perf/include/internal/rc_check.h
@@ -9,8 +9,12 @@
  * Enable reference count checking implicitly with leak checking, which is
  * integrated into address sanitizer.
  */
-#if defined(LEAK_SANITIZER) || defined(ADDRESS_SANITIZER)
+#if defined(__SANITIZE_ADDRESS__) || defined(LEAK_SANITIZER) || defined(ADDRESS_SANITIZER)
 #define REFCNT_CHECKING 1
+#elif defined(__has_feature)
+#if __has_feature(address_sanitizer) || __has_feature(leak_sanitizer)
+#define REFCNT_CHECKING 1
+#endif
 #endif
 
 /*
-- 
2.42.0.609.gbb76f46606-goog

