Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9894935A95A
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 16:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776482; cv=none; b=mMjKW4jjDmWf6gJCpFJiW2OYun+WsbT3bMJ7ggGiiAwBozGjbOcaSBtiLNNBT40rax3c1iQFTFsguvGIa7dUfZJCLSJge66HLpve0AReJt1Kdtlx9BV4QuXbKWEuW6kWnz7CuJ796DUg9/078/NrljPMMO1G1Lszl9Yi8BfcgfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776482; c=relaxed/simple;
	bh=wARZevzPzisMNLxa1znHw/JxGcHQ48J6wxMvyUlBbjc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AsGwBVFAD6hvvq2h3S6jnM42yvKNlU/imuCbAq7fpo/Ij5U8w/dbT5fdwNJobqvI5f9wpNSyFQYZTiJbZYLNeM6RjJ8dJFWQLVyDGRVCbzffZuktWktD5QBfe0lJa16fcJMKMSZDvTBbh0ZktKt1p5tmDx4PSKx2Jj4Zo6g4UfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N3xWGXYT; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N3xWGXYT"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12dc3d81736so7451934c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 09:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778776480; x=1779381280; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ahktu1Xboi/pnplugnzBCt7t42G9BqvuSLwtnSOz/As=;
        b=N3xWGXYT5IVth4U2hC6og5KfocgyPkOvY0OWjxiHQj5W+g0H483yl7hTpioGzpeRWD
         Ma6JPCXxDMePQjC1eIXFx3lVmaElZODiP+iEpbOi4Md3PgmjnoT7DTN1uTyhuoJbwHBp
         0O5C93Bsnbhqt1p4fKWgdPOao4tWakevCyfN+jj42DunXgs/xx18hJcYSypgCuSsEhaf
         qfw4EUacRSGN3j31yoxE2WIEP/kMDsrJKBmENwprvUxnC7PAvjiGbTbiHngL/aMUYOOi
         PB9silA/IEBhXIipGHCPA/fE0jqI/qEv+pfx10sunZqWpXBz1G0SbNTBkFNBQSLOYzfr
         pKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778776480; x=1779381280;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ahktu1Xboi/pnplugnzBCt7t42G9BqvuSLwtnSOz/As=;
        b=pSibAmWlKNt5YZDlDLeuqg/Zp7goy0oH6E99Arr2CCWXC+sgKhBMeTpQTar93OAinD
         C07I2IOOlaNSr3fx3KHLsUzoSRu8kavfF+52XJ0kviEOuljSwaTDt34FCNj7ki+G++yD
         CJhPkks8eDmjbOPlzkGnj3rANmT5cSCWySW32gZ/x39YRuneSO6DcpIlkoxyJTSB2JtG
         w1VhewD4MY4FfACaRLMb//dPvHex8EyG+3/aKcQRexc6uECzm/TuvFLiIZevCWAYXsas
         daLGWPwkHpJo+dnJjs9YSkotRbty6QuelK1U28guVQv1RVgNBoEkb0fsnNOq5jNwfD7v
         hxMA==
X-Forwarded-Encrypted: i=1; AFNElJ/r6efUG3zctn9RIc4VR3vJwOEgeg1iAdNHmkXdkrjjDIB/6xjZdQKL/fXI7+nD+dem1WVldz+8KSWy0DYojg1e@vger.kernel.org
X-Gm-Message-State: AOJu0YwTiJxiYZSCq2+naZgyobZ7YuCg0eHELI5d46jwrxOZQaJ60vxX
	Bqzrdzum/lws+6fRhhsreMuGx/TOqZ0uRR75YyWEppgTf0W+4D+l19IZqKxWcbLFaBJNn5pfTvx
	XAzIo7rlNpg==
X-Received: from dlaj12.prod.google.com ([2002:a05:701b:280c:b0:134:a6ef:d90f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2595:b0:133:3bb1:8d40
 with SMTP id a92af1059eb24-1349a80df3cmr4884740c88.15.1778776479313; Thu, 14
 May 2026 09:34:39 -0700 (PDT)
Date: Thu, 14 May 2026 09:34:01 -0700
In-Reply-To: <20260514163409.927816-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512174638.120445-1-irogers@google.com> <20260514163409.927816-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514163409.927816-10-irogers@google.com>
Subject: [PATCH v3 09/17] perf build: Move static libbpf dependency out of
 prepare step
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, james.clark@linaro.org, 
	namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	mingo@redhat.com, mmayer@broadcom.com, nathan@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, qmo@kernel.org, ricky.ringler@proton.me, 
	song@kernel.org, swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

The prepare step is a large serialization point before parallel
sub-makes build the perf tool. The libbpf headers are used in the
bench and util libraries, as well as individual perf builtin
commands. Move the libbpf dependency out of the prepare step and into
the dependencies for those targets to avoid it being a source of
serialization in the prepare step.

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index ec0e91bedce1..30114a31ca76 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -547,7 +547,7 @@ export NO_JEVENTS
 
 build := -f $(srctree)/tools/build/Makefile.build dir=. obj
 
-$(PERF_IN): prepare FORCE
+$(PERF_IN): prepare $(LIBBPF) FORCE
 	$(Q)$(MAKE) $(build)=perf
 
 $(LIBPMU_EVENTS_IN): FORCE $(LIBPERF)
@@ -558,13 +558,13 @@ $(LIBPMU_EVENTS): $(LIBPMU_EVENTS_IN)
 
 # The $(LIBPERF_UTIL) dependency is to ensure bpftool and vmlinux.h
 # aren't racily built for bench/bpf_skel/bench_uprobe.bpf.c
-$(LIBPERF_BENCH_IN): FORCE prepare | $(LIBPERF_UTIL)
+$(LIBPERF_BENCH_IN): FORCE prepare $(LIBBPF) | $(LIBPERF_UTIL)
 	$(Q)$(MAKE) $(build)=perf-bench
 
 $(LIBPERF_BENCH): $(LIBPERF_BENCH_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $<
 
-$(LIBPERF_TEST_IN): FORCE prepare
+$(LIBPERF_TEST_IN): FORCE prepare $(LIBBPF)
 	$(Q)$(MAKE) $(build)=perf-test
 
 $(LIBPERF_TEST): $(LIBPERF_TEST_IN)
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

