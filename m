Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9804538398B
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 19:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778873617; cv=none; b=e6wTRETWqO/FxmGSjJHaW8djM7cchTZbUg0r+bKKKbE8iaveiFiOeM4T4DfJ3KK1pvfSNzDVsZpaaJSh1mpoQTa7FDN2OBfcr9c8DuBQJWyh45PrHiWWumxceXU9S9CdM9YmXvNnir66jTlxkGRTT49LNl9LoUzwQtbp+dpKopw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778873617; c=relaxed/simple;
	bh=/7TyOYbdEe9k68HYyv7dCCFzh+d6Q52A6z+ebAC5RwQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G/WB59JycyZNmtuUdoR6CMNF5eUoyeJM0g6WUBx2H3Syon5J5JFvGQ9XhiH5k1ze+/9Q+CkQpAnTvzd0JnARYClvcQlIyuOmy33gU+rrhEbGo/aJ9Z9nuD0hbTt+JvYaoRAZHZ/gvAhJnK70Ht3fX9Ag+eUhMkUU4Ojj2zN0Fbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F3zNthch; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F3zNthch"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ee1da7a13fso237912eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 12:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778873615; x=1779478415; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5GIfuekLiG6d1t2FIig7OwOH7cYz1r1KvcU67M955lU=;
        b=F3zNthchOKp/onhOgzgifJMzg/n+4RKuyFUfUq39KYiCMt6Fm11SAkSc0t/sKOPBht
         03M1HIADe/l+IFHjzbk/tlFa+chRTUJGX7sJZOMshOFjH3VHXIDoVjGZwupJrjCzar8R
         fQi4QeYqr5179n5XO1vimz1lZb+qSEaBDhaWhqtunxY9Jistk7xDhByw47Igk2ZlNZbB
         /oEWjvHWS9prEiBzC0lOxejY/mxEf7g78Rfza/Z/EXvVnJwFA1A09p5DqHtoT4FLpZB9
         tflQpM13UZ8utsHoa63yLUFG8iKb0NLAlJAU/KgW+vkSY5n9kfRFrf8tfuivuRxjMOMs
         j0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778873615; x=1779478415;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5GIfuekLiG6d1t2FIig7OwOH7cYz1r1KvcU67M955lU=;
        b=qrC1J7wMoTjOoNFhstIZgLIvlqPcveB2UA6rzic0DhQEk81pO8/1m7FWa7JdD3yi8X
         /ovJ0P2GK3TGiDFftMvi/xooNd2kut3qR2PZgsSIWcwnXfwHGAgmfQCYWsqQhsw7CSwx
         At7VOU30NhduY9Zde1dX3d0XoCF4OOn5Gnffcrc5Wdj8L0MVN6vRu2J6jVfwaExb8cOX
         NGBsQpbnRkCTqYvzPuz/eJoP+wAIGnhTaqnLgoMfabVctSI1CqkLM1FplIsUV3uaDhNv
         /diUMevOX6VJ5zX7iP3IUtLjeiK1d0t2UIZW3oul410IaeAW2xO/gU4g01+Ip9Bz9ccF
         TpIQ==
X-Forwarded-Encrypted: i=1; AFNElJ9DvmGud/2j8n/TGNuajmwY9T2noEi9+ajSqMXSxG9IqSgrarIeVUtLnaFWTzE8SN3FWcQsT7lu60MSPk02VnBZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwpXAmjyaC0QgF41/o0JlVl9E22ELog0FyhlfyDG6cB08u2rxwj
	4avlBco8X3RlU/ANC0WUz32O9nrX+i7UTPGTFuLNTxqFMp6WgmCipPL5rDIm1lrXOgPp/fR9pDG
	If4RFfSCJ/Q==
X-Received: from dyau11.prod.google.com ([2002:a05:7300:600b:b0:303:2247:382])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:8b95:b0:2e0:1f09:d924
 with SMTP id 5a478bee46e88-3039813cab5mr2918644eec.5.1778873614455; Fri, 15
 May 2026 12:33:34 -0700 (PDT)
Date: Fri, 15 May 2026 12:33:03 -0700
In-Reply-To: <20260515193314.1593560-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515173852.1378571-1-irogers@google.com> <20260515193314.1593560-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515193314.1593560-4-irogers@google.com>
Subject: [PATCH v5 03/14] perf build: Decouple pmu-events from prepare
 umbrella target
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

Tested-by: James Clark <james.clark@linaro.org>
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

