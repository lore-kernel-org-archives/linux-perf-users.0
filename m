Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96086346A02
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 02:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775959783; cv=none; b=Ezo/rg0E84O+HiZqaZMFbv8ZiQqwmbm8Qe8u7bOBUOxhM5yojugIn5wSpux6CYxIu5u32oKOn3XFLq5Zp+5okv9hcII2Bvye8dyHnD5SCUVmJQ7BNapEoZXcw1vMeq8jo2w4qdsbkb26TM/rX21xcLqrCjjKuLOeYggKSGBXf8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775959783; c=relaxed/simple;
	bh=zSR89FimOo+a1ho86PLlAmAIRUBEG6ciri5qyIpa6GQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iRBPmeAZV5bGuWH6s2qo3b9bCm67TujZpSYandDaMvdLzsshsTQb9fCNFl8u4VRiTu4jQkc0a2ieyrW/C00bJY+aM2Yoh9mcsWDaLTQkX5VQP8p7mLsC61jPTo5MCyuOxwGJ4kFpSOBDiIz4Bpe+BMsr+/9CES7tIvsUZGvI2kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dRLXNNXD; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dRLXNNXD"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c0ba59a830so4455417eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775959782; x=1776564582; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bhB4ugJgO/oaf/OiGetNZif1o7sER/QECqKsaPKgFw8=;
        b=dRLXNNXDOqApsS+reKblOBdt/LGhrKVrBJsFJjoDgKyFPLiLTXEikEoMHELG/3xS6w
         TJOArQVijVrufdbZh0ypuJ8HoxXOaQGWBCCIYeOoDm55T1zu1VgYWvAD2hV3GfKWULrz
         Gnd+H4HsiuqoELmGKBGs9KkrjuNsdACeWyIajY+1jGuzqPx5JeN4nE5+m3KNnYLGlran
         fk5p8FA7uof4yoHbPYUWkpyGotLan4rnPChTkC7OI3sls0wTgQkKGzJtP76SLsCdB8es
         222XMw/Uy9MKvc6/tve+GbzBkuQtC5v37KKKVa0guo7IT54xRAx+vtr0tpbOQ5kJjaRt
         G9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775959782; x=1776564582;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bhB4ugJgO/oaf/OiGetNZif1o7sER/QECqKsaPKgFw8=;
        b=fVsaA7a032X9gILMKN18Yo67yu3BgPzpmcfsS0K1jpETbmTl6thbJc577ZBeb/xdT9
         pGjgJGIEX5o1B5AzqINzDxITcjregEat4b9TkBmc8HocldRBMdDDiyCZul2LYOS3wYzx
         B31wNZPozcGSDLei8OWRZbZW/R++2fp9Znv+2RkFSmEayWhLzKX0GRiWpqGZtrifWhj/
         +lT/7MQehJsqCHSc5RIz++wwC9c5JXPBbCvyqt3WoWp27GSzoZ1z8XUL2VfzQ98x6fjp
         UiA2y1cVKgd/BSavrxcZIkkRA6pcFShvdBhNsFU2VguCBIm4G3B7uydWFjrFBAhP5cVn
         Mn0w==
X-Forwarded-Encrypted: i=1; AJvYcCXRZ19sf1ILrha/XlaO93+g7aojB6MZWbAWYxYdmPiK0GaqSxWicxv2Cb5SAI1TwCR/o8yYYXW1uVlsypXY/jTO@vger.kernel.org
X-Gm-Message-State: AOJu0YzU+VCendgvOtsERQ46xNeNNhztwmVp9g5k9p0H3T/dCycJldvG
	njXtEO9owhrF6uQAZDR1L08KWyk3ksoKkNlpqJnS0U+cbeNLlAXARJwWpIcFELZkNN9FsXjkEel
	uMR3MRh9h2Q==
X-Received: from dlbsw14.prod.google.com ([2002:a05:7022:3a8e:b0:12a:8440:6d03])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4b:b0:119:e56b:91ec
 with SMTP id a92af1059eb24-12c34eecd01mr5064113c88.29.1775959781692; Sat, 11
 Apr 2026 19:09:41 -0700 (PDT)
Date: Sat, 11 Apr 2026 19:08:28 -0700
In-Reply-To: <20260412020833.641177-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411191710.524998-1-irogers@google.com> <20260412020833.641177-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260412020833.641177-26-irogers@google.com>
Subject: [PATCH v10 25/29] perf sched: Bounds check CPU in sched switch events
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Ensure the CPU is within expected bounds to avoid out of bound memory
accesses.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-sched.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 45439e2af8ff..6d0655d56e26 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1791,6 +1791,11 @@ static int process_sched_switch_event(const struct perf_tool *tool,
 	u32 prev_pid = perf_sample__intval(sample, "prev_pid"),
 	    next_pid = perf_sample__intval(sample, "next_pid");
 
+	if (this_cpu < 0 || this_cpu >= MAX_CPUS) {
+		pr_debug("Out-of-bound sample CPU %d\n", this_cpu);
+		return -1;
+	}
+
 	if (sched->curr_pid[this_cpu] != (u32)-1) {
 		/*
 		 * Are we trying to switch away a PID that is
-- 
2.53.0.1213.gd9a14994de-goog

