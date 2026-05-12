Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1603C3C0E
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 05:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564173; cv=none; b=bhicL66TC7GmbEnoDRT8oF2P2V2xyj5/3ALIOqLnNv7dW+XRfBZWKWKzu9AIO4DawhUn0vaXklZS0CxLSy3svzB+AeugLl3nVZSyxJpKrF1M+Ux/eYJzO/GZidnxsd2pfWJwhq7eT2DMe6NhR9KCFk2SQpqAKoYREkD8FJ+QsTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564173; c=relaxed/simple;
	bh=75eKE+tJFe0OAfOA1qho8SQB/O8Uy2A/+7SXYIEKmzA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XjJA7Dm0Z2cSd3l3+keJBQlEW2sRW+hNrR4EhspzmWnOxgGGBLUUXKZi7ipSyBscPxRpYFZAcGgxUFFjfCqVXQx26L3YiJ7nU/O4Is7oiU/njD3ZAnNkw0ZNAdpSmRUVzx02RwD+w/sh/z+NSaI8IYsb6G1QVi6QB2OXCqVUKHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BuCwMr77; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BuCwMr77"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-13312be8a31so6429178c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 22:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778564164; x=1779168964; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zvl3sORFLrEwbrjqVU+zw5LLtprwRT4ak9UnaDwB2ig=;
        b=BuCwMr77ZtTtEt7kHXYZ2lrtul6Cx4Of2QoE8KTGTdHeo/3USz3smQRAfXNVeoJ0Kq
         ADEpWPQH7oGjuSxknNa4wNMF1TWIiw5BtcjYqBccOBaDkmlJCn30ajXs6hqcXws9V580
         108aeSmh8c7wj/upjv+lr960X8HS83U812QuQjg3U3+KfvdmVZefRe59TbSpAZNiOk4X
         0EN5OzobYJNoQZpiip5Tlbv6RPt0x8hceE33P5Qak2J6CwY6xfUvWTHmb0ZyO/ti6uM+
         zPTXHkeMpTK2Y5+JQLBzdlut1Ul2rt/9GFZqXq/qTj5ZNQo4sBvOpC5RtERGeMxyXfOl
         caEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778564164; x=1779168964;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zvl3sORFLrEwbrjqVU+zw5LLtprwRT4ak9UnaDwB2ig=;
        b=SRPJmytI4CIEPb46pvxE6Lztrne+xNk40cBo0x3KgO9W4O0337y6DCNcuqeTYGr9lq
         a9XUHIotXZLBh6EHOff5OrVzIxjjWLJ5qP9TT/3Z8sTXA2hQi+7mY21BUpklQlRGAs0L
         OdWHBVGOeloJv2S2bJFhq0CeLsNQExe7yNwlFm11CV5mcW2qSdFUD1zuo5BRly5KN4EO
         WSTlMF5fXvSCKD2+sI5pBNL7u31zt1CtIjM8mg3UEWq+RKhZeFF6cFdokMZ3yNWwzVwq
         FfehMlKs7KGI3BdV67AXtacBkRNpRlY+ZvZYXSP31TCk0xCRIjUcA3W7Z2I0xpKwaay8
         R5/g==
X-Forwarded-Encrypted: i=1; AFNElJ+zoVo0zNOn097gB0FLLJe4M2OU6gD5TEa/px5SekfXwsGkRKwhYPEOZEigrfZu26iSwnzXPHql+npGnsq4sk1N@vger.kernel.org
X-Gm-Message-State: AOJu0YwUdVfndtdDpMeAH0e80pN2KvIF6CjdvdmZ8FmxzMosNv+zgfKN
	YrZRKYJYYlGERMtsU7PjxrtGg2tTEAiHUQJCk2jHOUvNxAMBfuqsK7wWkNP9/lCOcrtmINmRcwG
	CBgVl67YFPw==
X-Received: from dybgn40.prod.google.com ([2002:a05:7301:2528:b0:2d1:6536:ac8a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:fb0c:b0:12d:ca31:f19d
 with SMTP id a92af1059eb24-13271b86630mr9447493c88.28.1778564164216; Mon, 11
 May 2026 22:36:04 -0700 (PDT)
Date: Mon, 11 May 2026 22:35:32 -0700
In-Reply-To: <20260512053539.3410189-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512053539.3410189-8-irogers@google.com>
Subject: [PATCH v1 07/14] perf build: Move static libbpf dependency out of
 prepare step
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

The prepare step is a large serialization point before parallel
sub-makes build the perf tool. The libbpf headers are used in the
bench and util libraries, as well as individual perf builtin
commands. Move the libbpf dependency out of the prepare step and into
the dependencies for those targets to avoid it being a source of
serialization in the prepare step.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index ec0e91bedce1..5af767415c11 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -547,7 +547,7 @@ export NO_JEVENTS
 
 build := -f $(srctree)/tools/build/Makefile.build dir=. obj
 
-$(PERF_IN): prepare FORCE
+$(PERF_IN): prepare $(LIBBPF) FORCE
 	$(Q)$(MAKE) $(build)=perf
 
 $(LIBPMU_EVENTS_IN): FORCE $(LIBPERF)
@@ -558,7 +558,7 @@ $(LIBPMU_EVENTS): $(LIBPMU_EVENTS_IN)
 
 # The $(LIBPERF_UTIL) dependency is to ensure bpftool and vmlinux.h
 # aren't racily built for bench/bpf_skel/bench_uprobe.bpf.c
-$(LIBPERF_BENCH_IN): FORCE prepare | $(LIBPERF_UTIL)
+$(LIBPERF_BENCH_IN): FORCE prepare $(LIBBPF) | $(LIBPERF_UTIL)
 	$(Q)$(MAKE) $(build)=perf-bench
 
 $(LIBPERF_BENCH): $(LIBPERF_BENCH_IN)
@@ -576,7 +576,7 @@ $(LIBPERF_UI_IN): FORCE prepare
 $(LIBPERF_UI): $(LIBPERF_UI_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $<
 
-$(LIBPERF_UTIL_IN): FORCE prepare
+$(LIBPERF_UTIL_IN): FORCE prepare $(LIBBPF)
 	$(Q)$(MAKE) $(build)=perf-util
 
 $(LIBPERF_UTIL): $(LIBPERF_UTIL_IN)
@@ -636,10 +636,6 @@ prepare: $(OUTPUT)PERF-VERSION-FILE \
 	$(LIBSUBCMD) \
 	$(LIBSYMBOL)
 
-ifdef LIBBPF_STATIC
-prepare: $(LIBBPF)
-endif
-
 $(OUTPUT)%.o: %.c prepare FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(build-dir) $@
 
-- 
2.54.0.563.g4f69b47b94-goog

