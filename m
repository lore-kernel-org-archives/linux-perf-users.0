Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F981C8FDB
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 17:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618286; cv=none; b=qt+Cd02rwassHilKvwTZ5zbrHq7HVH1Z9GELWtslGEnMynA5I312q0jqhpw426kmP7pPheS9sSd0WAifJz2q/KL6IivjGlFsos3XYZ/1k86woANtSy8TUvCBvANWaE+7j+9iMN+odahWTVOvEdHYpWdAwNf/JN3n3VlwFwgk1d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618286; c=relaxed/simple;
	bh=wP5xmkvAAF0cc6yxByZSQ91mHbkEonU1IDc+KMo9VIA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=HAyiz9wjxZaQbBXUZULp9rppcbLcWBP0QT2s690ChhQ/ggi8hvdcAdTHMEv+fKJvX/7E0U/fQqmzCGUyvuusNyxUOcV4csvw7eocCVMLP/hdQVtBPyfcC4b2hYn3SZoF8Z3vL2CJvS1RXNwtBVrWJIUnq4hw2STdvnxggUuKL9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S+cnXiMv; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S+cnXiMv"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e7e0093018so15527427b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 10:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729618284; x=1730223084; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q2lIQmRoJAPcxBHPZc9OawDV+vOklIH/TcpOqXgiCgo=;
        b=S+cnXiMvonGNZ2dW1NWAbfZPGyVUqLS+LJwN07yliAZ15SHPfGcAHzbGM+db1f4VQN
         YTDpheEsSNv+J+xtrR3W352yXYokN686ocW0R1900sy0h8SGOx60X4uqx7fWKFibbZeP
         q0BFMY4QrNRJPYwtciyoTLplR9t8ZC/38ng1cwsL0vGPpaNXEStsUneiZ+JHZY6cj8s5
         RiHrqugy/5E9ytrxWxl5ie9bU27Wdqw1jzWHKUzx7ZVbEXfnYTNhljpNVphEfTl2ll7q
         3Iof+oOI/4phkaUHenS9z+/bZPt1uk2Xtv38qZJ9bQLt1cpLXYbuhYsj13k4o9hnTIls
         aYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729618284; x=1730223084;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q2lIQmRoJAPcxBHPZc9OawDV+vOklIH/TcpOqXgiCgo=;
        b=Wn1AonOxiPwNlV+f2qVWcnB5/xGGKOqhIk/FgHENn9GNO33IhsTvkkUdyVJJYmY7q7
         ZUX8kKBwRrMbj5t2oYA8pIV2sznJir8t07nL62/Up0SNW/jA0SZbji4Dw6xcnaNY4pHn
         haXBPzRdbNjktAONQ3uw3Mk2MLo7B9IBhU4cIcUelX8W6PltAkVoGMr9ApesCGzgqiR/
         HMnFNAbGYp7gU7WLFXnQiFhry3NEB+uaZRC/X8x7767puHh3xzHf1C8TftwIT4AxCbNT
         1IqCDMhwn1h8RgprTsG4tl+46OetHEwInsLScP9sJ0MiLOsc5dWzexTgJbr7AY79wcG5
         4m+w==
X-Forwarded-Encrypted: i=1; AJvYcCUjw80A+JcDJ64Xt5rJc3k84dR1UiXdwcR5bssbA8wyOPpEf6ky8cCTIISBB9RuyG3Xf8E3//9MknpObr2bmfc8@vger.kernel.org
X-Gm-Message-State: AOJu0YzIJouYJxBapHvQ2n+CXyQfyj+98G++jH31BoH0PCIU4MFciZh9
	rU4TffLz3PriYggHXDUmIIkKVKxjp7wYmwEQVsnVuFV34OieTRIYnoZEGatff6RkYh2dTFw+Ld3
	LR/MLHw==
X-Google-Smtp-Source: AGHT+IGzmwekM0FkphwepMJvsOqlkRGtCfnNkqk3W7pCbVKQLK6M3uitUSkN44V5hE7kzuyq8IwCiMDHpmhT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:57ba:88e0:aaf6:282])
 (user=irogers job=sendgmr) by 2002:a05:690c:4783:b0:6db:c3b8:c4ce with SMTP
 id 00721157ae682-6e5bfd8b0edmr535057b3.7.1729618284520; Tue, 22 Oct 2024
 10:31:24 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:30:13 -0700
In-Reply-To: <20241022173015.437550-1-irogers@google.com>
Message-Id: <20241022173015.437550-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022173015.437550-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v3 15/16] perf build: Remove test library from python shared object
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

With the attr.c code moved to a shell test, there is no need to link
the test code into the python dso to avoid a missing reference to
test_attr__open. Drop the test code from the python library.

With the bench and test code removed from the python library on my x86
debian derived laptop the python library is reduced in size by 508,712
bytes or nearly 5%.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index e54c6953cf02..957b25322786 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -487,7 +487,7 @@ endif
 EXTLIBS := $(call filter-out,$(EXCLUDE_EXTLIBS),$(EXTLIBS))
 LIBS = -Wl,--whole-archive $(PERFLIBS) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
 
-PERFLIBS_PY := $(call filter-out,$(LIBPERF_BENCH),$(PERFLIBS))
+PERFLIBS_PY := $(call filter-out,$(LIBPERF_BENCH) $(LIBPERF_TEST),$(PERFLIBS))
 LIBS_PY = -Wl,--whole-archive $(PERFLIBS_PY) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
 
 export INSTALL SHELL_PATH
-- 
2.47.0.163.g1226f6d8fa-goog

