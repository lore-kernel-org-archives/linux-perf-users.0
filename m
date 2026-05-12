Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9C73955E4
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 17:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608025; cv=none; b=DT+fVwOd0LsAAKJy+tHD0BFh0bAik9VPsebn7eTgAkG6a/YBaWj9kcCR2nuqQghiM3RF33kaLBu9xvTw2O/jXcUvGdrMjdXyEx59gP6bv2Gi7kvv3CO7AFZnVrlm/Sn0LyDd39RhY8XfewE06kqTo/zBBRUyl2wIhgRPrne3F/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608025; c=relaxed/simple;
	bh=/7TyOYbdEe9k68HYyv7dCCFzh+d6Q52A6z+ebAC5RwQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OFkKj2wEccKtmYQkks1ey1MP0ccD5FTnJaz73rvP/l19DTdIhdcMAzlYa3PicipvJ/aeRE1NoSzQnof+wH4I9YaDcMZaYDIyOGZWkOgz5W35MflW4cDUf067jzsF9lYNndUgjWREDzhyn6VNeNjzxiEVPdYaVhznhGe6D0VT+KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wcBa1LXD; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wcBa1LXD"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1306c2f7037so5961956c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 10:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778608023; x=1779212823; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5GIfuekLiG6d1t2FIig7OwOH7cYz1r1KvcU67M955lU=;
        b=wcBa1LXDhgVQogrQHnKAaUsIkGXSAHjefoQD/Te9sSIIhRgrSPoefsnSUAWTgr3Uvc
         bmo4ETMjOwEo5+DPfU4daZLOdxlNgCracl6uMBduZFxaeorBZvy+WSZC0BqZlhZD+KUQ
         FoI6zkcRvZeEV+yof3uXZR7rY6kOBJirPI0A9L4DFRpUaJw8HDOiGht1lMXAhipuKwgl
         D7fsLBNUH/HmoQkOc8IY6EnJ0AFOW33eZKX5ael4MoVrw0yFN/eHQj/rIJp6q2i6DnEI
         luizDsmqyHQJ36v/MNLtU5Kn7t3/NDA9S/QrJmLFYY4U7MoDSEI9KKl2BZkNRjakbbeB
         Sozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778608023; x=1779212823;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5GIfuekLiG6d1t2FIig7OwOH7cYz1r1KvcU67M955lU=;
        b=PqyldeDfGZZrMSFOMdOxEuak3UXepjBA96oFswes6RoGuB4XMh9X2aQTM6khgVBDXc
         69jKzX2d03u1tv2t73U4vBgSPgIq6mAlzIS82oDBHrSyHEPZAKpV6lOC+PeQMJdMCpvM
         aUGGQ3O5mQsLjL+Bo9/ZHuJU5RZ04tlVpozqGFCDv7Lv/MbCnaF6S91/2O+cFgXUeG9F
         PzhiHbtHssisZWery4nIC9pp8hxhgimwAF7w39969dDOSQU6MJM9zchHEVgW1VpfOOrC
         AWJZ9Fjf9UMrA4rPuIw3zarjQemFLEgPfXeirRP5xjtIO5JoV6bLB1cL998HlLG+G1qh
         u0QA==
X-Forwarded-Encrypted: i=1; AFNElJ8cqjKx+g131z6ffSKv0wnYKicC63eyPo1vd5/EnawZhdgDANurDy5v49jm5OpSCXCF8UcojVx3BaR75iqRQsJJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxI/G68VXaDzp7PguhvG+CXL2h4hvleymg4HGJP34sk/7xOEFdD
	rNnxuzdETXoSLpO6c2lwjpl+Kv1Q4eCq4Adij5mLp5kyEVYvs41PVcHHSovzQCA5G5pu8Y4zlZi
	Eard5IOMqlg==
X-Received: from dldz1-n2.prod.google.com ([2002:a05:701b:4181:20b0:12d:bafb:54f6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:23aa:b0:12a:6c4b:9cf0
 with SMTP id a92af1059eb24-131967d5026mr15473065c88.3.1778608023142; Tue, 12
 May 2026 10:47:03 -0700 (PDT)
Date: Tue, 12 May 2026 10:46:26 -0700
In-Reply-To: <20260512174638.120445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-15-irogers@google.com> <20260512174638.120445-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512174638.120445-7-irogers@google.com>
Subject: [PATCH v2 06/18] perf build: Decouple pmu-events from prepare
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

