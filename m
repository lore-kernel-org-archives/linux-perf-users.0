Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ED73C9ED8
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 05:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564176; cv=none; b=SxG05JSHgm04Tec54zIrXXFTtZ4xkv/4FaxYzMkyQqujEfJis4tHFIXF+k7KmD1BmF2jgqbbKVKUWZcumRAEx2nEKSg+6JxfTZKq09k3jMGVpCOfRiyrH+lUuV0u6KxvDC6+cuR/BOthSywhPwDolLy7AorFHf13kjlfr9jfH8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564176; c=relaxed/simple;
	bh=FwmY6SHC1wqZd8FH4YmHONHnhz0zCirTCjX6zLXta8c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j9usUtmGAipbEpN15RbHkRxmMyGqEClAiqeC+ADl7tTudrZBVgqF/AU4YPTAGnTy2FEJenMxuVJyn3iD/znBwCFwBDsXvpXCZn4UcPpLF8k9rqWmDzgkWh6ZZJDs3hZhI4UTQ8dX3b506ZS+lTbdDNxG8ThxeefryOFo8/uliNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xs7UQXec; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xs7UQXec"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bda35eab74so4182482eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 22:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778564170; x=1779168970; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xpv+PKIXTPZiwweR2cUepuzcxs44tDppG43wpY6jGYo=;
        b=Xs7UQXecdG5bx9COGnjCuYT4f97soR1gBvxe/2SQY+sgMI26FmMWrbgotFc6Awmx1e
         t1OBFqBUs/S5UKLhI1QaC9AAWH2kcTla/rb7bfanjUBI7p/xXe2HeeCcWVTlbWlC6RK6
         s8VAUrwiYcRrTr/xCQlI/7K6catdqe3w5p6Kd6/W6TdxqfZg322UuucSp8N5XmOL1E0J
         s1ppD4rIif+LvtUTfZW2vfehPEHt4xsiCD8TTA6LDs2eOzDA54E1sIliGWpgb8WGIeLf
         Mc2IN0BeFtMtvuCCPew2Z28GXv/ssmeYhhZqX5vxzl3TtrtIABZSA326BU3AAO/BSjTr
         FdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778564170; x=1779168970;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xpv+PKIXTPZiwweR2cUepuzcxs44tDppG43wpY6jGYo=;
        b=OfNayyHvnsZxfpOrABh1Vsr34/NsTQT7M32Fu4ignZ93UQbKbwe6R27BcUdhqkqy4d
         AkoSEuqpXEMYNDrpbX5y6DSS7kjCwrwK0cVgBZn0m6m6MdkTO0/2gbDTYAF2wIo3vyQx
         i/VrUrh7/7IbosFwWibHMx5x0wFJ0BXdtvJY60Q3iilceIqjtGWxSZ/o4y1MTvHCRnNj
         q6HzYnzxGwJEFc8qvDb0IHY8rhQ7OemuCewOsq/TEh7vSDEQUAwBo5XvDKOlD6qVJunY
         j/54C0nsLknMlXOdCgZgsc05493RciOBaW6AgncgJD0ch20//eCYAHpWp9PU1SyiriZV
         1dwg==
X-Forwarded-Encrypted: i=1; AFNElJ8EuYO2shD430IklYoBfz6YO9PrCMUYTuRwmSjIV4RzTjsLdjRub5BjKMaE7jktSkqLb5LgG6OhVC0oeGj1fLx2@vger.kernel.org
X-Gm-Message-State: AOJu0YyPvN3T1zpVLhPx6KUmKG9TcLbddOmNMUKCL3+z6+Ebuuv89SPF
	zHgaahW/QYddCKmOyzATpAT7+y7gZ1YDHOe3VCAPLYsON2rP0KGQcOqaRMhTrZAgdn884XgoIUR
	o/yFKcokXqQ==
X-Received: from dyz23.prod.google.com ([2002:a05:693c:4097:b0:2da:2525:9f3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2c0d:b0:2ef:e4:c912
 with SMTP id 5a478bee46e88-2ff94001c41mr1360913eec.9.1778564169493; Mon, 11
 May 2026 22:36:09 -0700 (PDT)
Date: Mon, 11 May 2026 22:35:35 -0700
In-Reply-To: <20260512053539.3410189-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512053539.3410189-11-irogers@google.com>
Subject: [PATCH v1 10/14] perf build: Remove redundant libbpf feature check
 for static builds
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

