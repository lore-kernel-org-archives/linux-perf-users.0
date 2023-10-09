Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F363541E4F
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Oct 2023 21:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fJXVfSki"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0299D
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Oct 2023 14:41:52 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a1f12cf1ddso49552767b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Oct 2023 14:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696887711; x=1697492511; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e5eVmSUwSJxksG4NuITaTSZqNGvqcD7jLZAKoPJCuWU=;
        b=fJXVfSkiGiwPbG3WBw4d22x7sCxkptAblZ4PFc6CmwVo+UgSY3KXYu3458vbIrVjPR
         aUuIkUUxS51FBlSc9x0DqiVPvr7s4ah7osm+xazK86GBdHtg6mLldRQ8IyLYEhKiiIhp
         P4NKsBclahd2RViAgv39XJzyxhau1c2agtOd484dee/ntwML9k8Ub6LCPGgc9LSNKHY8
         /vn4db7h5h0/K8T0FRExEOoOYvNhjVdy0sa1Qm6mpANyt6sGK0rhD3wI8eqs7rVcQH3q
         G5jHfSfjN8u9Ys8HmWtX6smo2ZMkG5TrNfgck6YKZV2/a5V8KtezjnPxuxD0Q+dINEz8
         46OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696887711; x=1697492511;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5eVmSUwSJxksG4NuITaTSZqNGvqcD7jLZAKoPJCuWU=;
        b=W5Ms+SA1gGtLsoI/YOVAlpyJT/B284ljA+EY/rZDCTW1KkLcFSN0pwo+5w/943xlJk
         fxGqlYScyl1EjCCb5+LdNs3ohh4S3PXGdb+zH6FdI0syE7hTMZnNv9zhb64IwofkrQxE
         G8JYZ6+C0MiQKCPsJ1xuHKtJkB6rripzOiG/QarSF0kwBkQ/TGrCFil5nJhGuREW3q7V
         qpXpjJtfHab3M2a0dOca7O978Kx+pfJaAUecjJh5AQRxyEi3HM3CvhFcRkpl4qUXBTH3
         K/vSK3f9/NfioBZUvXJgWLsRvrE52Mnj1nqjw13eNnAO+XojeugtodAnMmumRDpSeRrc
         nJ8g==
X-Gm-Message-State: AOJu0YwIUcX22IzLdCEHpoofs6Q7DHG0J88bwqsh0RRqXaJ7P6FhC9tL
	oyKJSfqiD7hZlmzPndUvCSBtHWS3YQzW
X-Google-Smtp-Source: AGHT+IG1Mask8yzdgt3sOkhSS3pJvD57UOaHsabCmR20TGjf4UoA5irxXhGJtnmMGXLbFsPzxkrL+WoFpwSm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a25:6a04:0:b0:d89:42d7:e72d with SMTP id
 f4-20020a256a04000000b00d8942d7e72dmr281634ybc.3.1696887711442; Mon, 09 Oct
 2023 14:41:51 -0700 (PDT)
Date: Mon,  9 Oct 2023 14:41:42 -0700
In-Reply-To: <20231009214143.349978-1-irogers@google.com>
Message-Id: <20231009214143.349978-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231009214143.349978-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v1 2/3] libperf rc_check: Make implicit enabling work for GCC
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Artem Savkov <asavkov@redhat.com>, Andi Kleen <ak@linux.intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
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

