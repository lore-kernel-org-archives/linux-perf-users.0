Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555DE3BF699
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 05:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564164; cv=none; b=T9dJeLnVXgn/1ZrOyJNdaYqMHQ5T6+PFuV8CGXfMCF3jD9lyimP39dFXeQpOA6NrEHWwr+RQ32oCVKQid71+SMaOcnDkX8pzox1bDLjEGrYOOCFlJ0tz67XJCB6cjUFVCOuvPJO3fMM/ubVQso655s9ans0h92E9Zkq065JoDc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564164; c=relaxed/simple;
	bh=yHoe94pBCp/jsSadHjDyJqHnLe1VKfRgsa8bqXs5JhI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rBKgjS7Igsw8K8xcs5LFqg8JEitUana40Hwuapr2ovCZcG8g4lSgRb+dY5JOYK1i0rKEkafR/5W54kA6YlduVqiIWgfGc03Kws+cKtSbgfEp1aXq4dQ/1G/9gKbKeUFZqEEHb6nWzXnD4D90Kyzi7jFiz4loLXHMtYj9XGSGFzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tV4Zuypr; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tV4Zuypr"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-13312af37fdso5293104c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 22:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778564157; x=1779168957; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dZFrpPLjC6wmGdWBTaPuklS/Eo1fUFuElAG8Y8XQiQ4=;
        b=tV4ZuyprnkwZnTe+UtPM0X2pkTTZM9WiEITyopcc7BAIlnOiRD2SCMV8Gwg0ZqLjlk
         Cb7nQi+ZJIfjx1uHT1bGoIPicpA4qOuMJQsUi/WjL7Bu0RmO/ud7yTMZwZA4LZTDxX2G
         0naDBNF87jXS8lG3tIBQsiMQcT2qu7WhII2WVXdXZJ6GGxXeaq8lNKwTNI1YgOeU945p
         edjwHRmTfNfPad9sQr64sK1OmtIZETdmJg9mdU/dWEYOD15w+FpicHHYli8j9GQ/dd1p
         1dZT0N0W0aZEeyedGKT2rv3b20Jq/aRBhyGB1U+//OWyaDgw3Nr0hHtaONG++Buiw53U
         75vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778564157; x=1779168957;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dZFrpPLjC6wmGdWBTaPuklS/Eo1fUFuElAG8Y8XQiQ4=;
        b=q1uhdHq04GBYVftvD1raB95MDLgEYvVopJYfFXXrthkoamUhUQvPLzT8RPPKqf5GyR
         uQGd8ygAEyYWkJ5OBDuLoaF++byfQ2em/lqN+Ct6lUrVMFMNwYbXIO/WwNHeCOroUFdu
         ixHiA7cxPKzzjqQo+yqzpuUFCOKoBKNrWvqhHXux6/AqQzfvSK6mE8YtOKUIUvC1Abhb
         NQefb6ZHGVEZX0YJSyk6GOZ1kAjb/0bKshHBKesrtSdw+sn9PXlFtIQVA8iU8wSv4BvZ
         3B8+t/yJXeIKpZNbTsCWrLWYBYILK9xC1uOoCKn8AGGp14MTLfdn1tffYHjZN/ITh0pw
         3J+g==
X-Forwarded-Encrypted: i=1; AFNElJ/KQFfmjunE34HLWB7Ck1PkLXcBfpAcIJUQxdICXSk0ms6D3wty+5pd9Votrrd88gYEeaeXUg1YyGvcaL6Mi1vV@vger.kernel.org
X-Gm-Message-State: AOJu0YzKM/93OYhxcVKf/baO2W5Kh6kVevSi+l92Q+zxD+VZohY6QcWs
	O1wgfzsmcuvGXf0oHX1CvNKRaRV9fylAjZjT9DsCuPL+SPETZbpXqYCm9+OZl9o8hfnP/Vw2UaR
	ifQKD3nkBXA==
X-Received: from dlbsv2.prod.google.com ([2002:a05:7022:3a02:b0:12a:7b92:3d63])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:98e:b0:12a:94ab:e20
 with SMTP id a92af1059eb24-13344f92abfmr1145587c88.20.1778564157242; Mon, 11
 May 2026 22:35:57 -0700 (PDT)
Date: Mon, 11 May 2026 22:35:28 -0700
In-Reply-To: <20260512053539.3410189-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512053539.3410189-4-irogers@google.com>
Subject: [PATCH v1 03/14] perf build: Decouple pmu-events from prepare
 umbrella target
From: Ian Rogers <irogers@google.com>
To: Quentin Monnet <qmo@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>, 
	Nathan Chancellor <nathan@kernel.org>, Tomas Glozar <tglozar@redhat.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Leo Yan <leo.yan@arm.com>, Ankur Arora <ankur.a.arora@oracle.com>, 
	Markus Mayer <mmayer@broadcom.com>, Collin Funk <collin.funk1@gmail.com>, 
	Howard Chu <howardchu95@gmail.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Ricky Ringler <ricky.ringler@proton.me>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, the $(LIBPMU_EVENTS_IN) sub-make depends on the massive
"prepare" umbrella target. Because "prepare" depends on external
libraries (libapi, libperf, etc.) as well as dozens of generated
headers, make completely serializes the launch of the pmu-events
sub-make behind some of those unrelated prerequisites.

Since pmu-events is a large compilation unit, unblock its startup by
binding it directly to only $(LIBPERF) instead of prepare. This allows
background python generation scripts to overlap simultaneously with
the rest of the build.

Testing a parallel build (make -j28 clean all) shows improvements:
  Before:
    real    0m27.642s
    user    2m32.356s
    sys     0m26.683s

  After:
    real    0m22.254s
    user    2m32.810s
    sys     0m24.646s

This reclaims over 5 full seconds of build latency (~19.5% overall
reduction) by elevating average CPU concurrency from ~5.5 active cores
up to ~8 active cores.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index c81797ceec42..c66af4c825fd 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -550,7 +550,7 @@ build := -f $(srctree)/tools/build/Makefile.build dir=. obj
 $(PERF_IN): prepare FORCE
 	$(Q)$(MAKE) $(build)=perf
 
-$(LIBPMU_EVENTS_IN): FORCE prepare
+$(LIBPMU_EVENTS_IN): FORCE $(LIBPERF)
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=pmu-events
 
 $(LIBPMU_EVENTS): $(LIBPMU_EVENTS_IN)
-- 
2.54.0.563.g4f69b47b94-goog

