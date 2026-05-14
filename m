Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B011DDC38
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776495; cv=none; b=i6lDpxZOfhGFVZyPSJMUQCWMq7So96NACnCv3v0NfmqF4lo2gQIY39mP3qNZuks4pZ/WmLeBlxrpmTnDsLpt9PGWQ7RcyfDg3CoB92HnQP3rl5f91YE3XfiOnYrm/E5Cvqt12fjryIL0ob5Rmp4GIanW0BP0aoQHt1Po43UHp5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776495; c=relaxed/simple;
	bh=o/K4kgugTGSk6IivctS3woOeRJortswYl5L/8mR0x6I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=orsPbsbcZ6ZY+t7QuDefsAWGLPk8pWTE3lMCSDxm/0xPHur3q14raWjaI48BuZyxKzpki4BfrG7jjz6HEBwgsxRX/TRrNl/9VKH2mTb8is4Kf6gwjvcBte00IcOamM0rZz09dyp0bX2NfS2HZqGjPEaL+aeAx9y2Z7stgzWfRX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nDTycAW3; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nDTycAW3"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-13312af37fdso16902030c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 09:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778776493; x=1779381293; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mgPMCywWzI9T8eglAxB7fkblHJQb+JFJwFxoaBxPkU8=;
        b=nDTycAW3r5YLIMa6TOlxClRkS+6CPBoIQL1+mnl5/bjoxw1aq/hOxiIXWX8ovqJqra
         5CNYphKXGvsmx4c+4LGaqgLyWb7VRU1ajBLeftdF0nWXvsmQG9idLZ+b70ru9d0SvwR5
         kKkTGseLBzmCSzHWdNTbGPwn89Sd++EvBuy/gm+XFO6ILQ884Gwpdq9JlQf0ZEvv7OM2
         wz0XfeoGUt2FTE5UPwF92hdeipGS3+Nq9b82mDDDPnQZvKm+ZTvRmh9bvkTqmcuvhPY5
         2Bz7z+8eBxXhuNtaDu/lW659VwGcTN6fOj6ODbJRbwsJrxTpVF+d7OncL0MZiWx/hUvh
         nTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778776493; x=1779381293;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mgPMCywWzI9T8eglAxB7fkblHJQb+JFJwFxoaBxPkU8=;
        b=EWKs+Wy5MqdXYQZwhO3g39NLVMDEcNGoKbbORHMSP0M36Wunp8HTKhxtwl46TqgMYX
         tsaBBHNJCNZvFafp4Br5EunrEpJkmdqd+1xlaIvEvygImIesXBtPigmB6Vt55TQ/35h8
         LQbu3wF1UwikKn7f+SdNWIFJlN8TvCArf+SOELn6fQdDq4Y7kcg+PrL/qEqbF1z3K3ET
         bUbo/2lg6DN3zUo49/YxutVfL9myL59Gg000aw/GrkNzekvdn07HUf3pY7Mdz5BAwobw
         WzR3G+x5LvALAjRx7FaI+zPIVlqBqM2C9Bff7OrrKKIqGRFhu33Ipp3/9oHS/0B5dbI8
         FAIA==
X-Forwarded-Encrypted: i=1; AFNElJ+gJNKDa+IeRF3faQTARQeta9jSqHraH875T6RUjNvwRkfbmSpAy1oJs6KjZDhIsd8IEUNcHBfhWvM6gd/jPsij@vger.kernel.org
X-Gm-Message-State: AOJu0Ywajin73scyOxTKJSGZMsMPcQTpSGrj8dSYzcDYXrWA+UUwASaA
	afh/aEwxAuCiQ0LHzb3NP0pzVyyP+fBBLkmnUqv1HigEonANrTQQBnT91dQFfkeyk7CEro9B6rM
	s1ywb1SNOPg==
X-Received: from dlbem1.prod.google.com ([2002:a05:7022:1001:b0:132:8d92:4d63])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f68e:b0:12a:94ab:e20
 with SMTP id a92af1059eb24-134369910acmr5950565c88.20.1778776492912; Thu, 14
 May 2026 09:34:52 -0700 (PDT)
Date: Thu, 14 May 2026 09:34:04 -0700
In-Reply-To: <20260514163409.927816-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512174638.120445-1-irogers@google.com> <20260514163409.927816-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514163409.927816-13-irogers@google.com>
Subject: [PATCH v3 12/17] perf build: Remove redundant libbpf feature check
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

