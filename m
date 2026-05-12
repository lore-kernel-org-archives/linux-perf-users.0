Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6083DD86D
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 17:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608039; cv=none; b=YjonaTKhL5jDWO7CqE3ZEZlMvgVnGw2Dz/nOEhkySf3QUJsXomUigAHvD+SntWIpX6C1TLLJ+xtdmouxQir/f9QNJRlhrmT6MfQEHupb2kXYakRYdby1RUkaHG3AzVB95dcBI1rFutnNkRT7GBLjk0tnJb9KKM2symMz4fdXd/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608039; c=relaxed/simple;
	bh=o/K4kgugTGSk6IivctS3woOeRJortswYl5L/8mR0x6I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V00PayBtZFd+WmhDfGjKCiWNuKLoXCSwolctYSsBBoqE0/zURatQdrDjUqlpGIChhDzl76ChP4ArGRkJSiHKo+b5P8h3g44Ql9K3+O0CrJYmsUxcLPag+NNE6WWE1s3smxmYS6bJBzeeCX0acgylACpuuNjE0vmczhRa9jf+TNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CLWTZPoC; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CLWTZPoC"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12df8bc580cso3593659c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 10:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778608037; x=1779212837; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mgPMCywWzI9T8eglAxB7fkblHJQb+JFJwFxoaBxPkU8=;
        b=CLWTZPoCGnYEEE2di1Vp8iNXccTkZ5173mucOZM4M168dyHV2PsVWI6v/YPIwQ7bIC
         Lu5mawI61+p75J7g8DBgMFUO0COgirbte21Coqi+sueKt+q5HPA/V9wVpaSAw+Ywo/nw
         PnmakwWRdmNvl2S6AExVvF30gQUAnF2o0QcbNdoJAKPTCwC7BEuskEF5DpfOlaoK17If
         XT2tZQoEj875gwb2DMuxN/j/N+gObT8ESVDlhfEhhH29cvTRHQUfXeT+Ey3+fpRVZ1TI
         QUPr2WcGN6iGkmhXuC7raFyUVMtvkL9+T8ZdZvzNl86I5zvvSWiuDPCl2xl5JfQavl9C
         658g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778608037; x=1779212837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mgPMCywWzI9T8eglAxB7fkblHJQb+JFJwFxoaBxPkU8=;
        b=qGREmH0BLgBj6ccxqGOHYcbVZz27nYblmpQXeKJa7Q7Zs8iFlbVE9/BAcQOl/uHr8R
         vfymFzAKj353ek8x61P88LI0h0pvgMq48RnFgJXl8HZENODIQw4rwPzz7cUthS5yqvvG
         7DqBVgPMjsO7BsvLIUOPvTUSueNbWXdR1xNJLuKzNwh/rCGyxpu0LIRDwyEqbZZe859E
         PgrJyvKFir0EmCp77xwheked9rFpVa3bnZLofMLo5wxlwBCqcg8BQiaV5PuwlK/cd4c6
         NGDzzZdnE8EH/WlOYREJHBVPbUJVod106W4ibqfX5GOkPPpZ8MGwhtcp39o1pgzxNqiU
         T+Bw==
X-Forwarded-Encrypted: i=1; AFNElJ95bV3UmJgtlnwGMoAriPiWFCRjLUpcVoU4zKJadN6hnjO9T8v5zJfjldBrZxeEs0TgY0Lotb1iS20+gl8WkWvy@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa3KAEiboay6sCWvyxuSoKDbhbPjpT34audGIwO7z+mWAs0oWJ
	O4uPfReGu3NAgKNL4vyw3A9h56cZO5te3S4PzGIHsz3RL9ayIYE6ix6h5UKraRygxndNM3gT5Vb
	2eOWPbbnNzA==
X-Received: from dlai28.prod.google.com ([2002:a05:701b:271c:b0:132:8d92:4d7c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:10e:b0:130:5606:94d
 with SMTP id a92af1059eb24-1333a927d94mr2988973c88.0.1778608036478; Tue, 12
 May 2026 10:47:16 -0700 (PDT)
Date: Tue, 12 May 2026 10:46:33 -0700
In-Reply-To: <20260512174638.120445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-15-irogers@google.com> <20260512174638.120445-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512174638.120445-14-irogers@google.com>
Subject: [PATCH v2 13/18] perf build: Remove redundant libbpf feature check
 for static builds
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

By default, the perf tool compiles and statically links against its own
internal copy of libbpf (tools/lib/bpf/libbpf.a), setting LIBBPF_STATIC=1.

Despite this static linkage, Makefile.config unconditionally executed
$(call feature_check,libbpf), which forced a synchronous sub-make fork
during AST parsing to detect dynamic system libbpf libraries.

As noted in the internal Makefile comments, this check was executed purely
so that running `make VF=1` would display the detection status of system
libbpf. During standard builds without LIBBPF_DYNAMIC=1, the detection
result was entirely ignored.

Wrap the libbpf feature check inside LIBBPF_DYNAMIC=1 so Make avoids the
redundant sub-make fork overhead during standard static builds.

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index bc1111c88226..fbe7fa83b0bb 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -587,10 +587,8 @@ ifndef NO_LIBELF
 
   ifndef NO_LIBBPF
     ifeq ($(feature-bpf), 1)
-      # detecting libbpf without LIBBPF_DYNAMIC, so make VF=1 shows libbpf detection status
-      $(call feature_check,libbpf)
-
       ifdef LIBBPF_DYNAMIC
+        $(call feature_check,libbpf)
         ifeq ($(feature-libbpf), 1)
           EXTLIBS += -lbpf
           CFLAGS += -DHAVE_LIBBPF_SUPPORT
-- 
2.54.0.563.g4f69b47b94-goog

