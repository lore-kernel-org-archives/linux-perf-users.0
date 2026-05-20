Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FE0340281
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303997; cv=none; b=N7SFwAogh4DM+mtvHa99m5bhwpJI+/0OGFLu/h7ik7rWHZ3+S2mFt4hLe1aXwOV3Okcy6wOqAbr57E8ixz3uinlP406JnfFhNlBDZz716yKAevxHUyqrF1EZgP5/hW3O8/UXo46lZhgS9oImj/o/I1+243/OI4SLLY/Vw2okxjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303997; c=relaxed/simple;
	bh=ZRg61dON0KRc2qEP3tBaM7Zyct4U5agDVGrPlEx1QgQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hc0ncF1Wp642yQdPVbPSqvoCWMJva0deTg7zr7HWSm01WEYXJrqzfUDMLIvVvcb/uqvHwUKnAWRqIJ3LmqOxANKZbVcYTg3mPdTvhL6jSs/M7IyB34DsEJVzovZRur9OANDZN5hUnDipNwKu5bwhDiycoDfhBhW11eP9SlVbDtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kP4+5Dsr; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kP4+5Dsr"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c828b1b7fddso2951084a12.3
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779303996; x=1779908796; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t3ZYk5fqvq7cU/2S9WHwTroDDw3rio9ewcApjvUks0A=;
        b=kP4+5DsrNRGQqrxBnvevXo4+6rBEPlOph/fbPKdBiA2HDdj8sFOd+zrALf7ILj20jR
         j0HEkEuZABWLgVzd3kTqEhAdBGLuUOs/P+fongtscRtgRdi/dANgqd9VtQqde9Z5tS+A
         ipQNNcl1QVnhf3aXvMV4eLuZ/RhEBu1k8CZAe0+eqIDxujOD/qImHON6B8F3bD8PEs5e
         0v9fWl2NQernZZGdPX2pmPvZsOnAap+J3CQgnU+4ZK4PeQQwrRucko3Hftg+MWClTGUQ
         r642aBoDCsUIrSDFBAFKZBQdfs6UyctRmVHR9pc1gw/9xft+EpsBR6aT1q8sRBZ5v6E6
         l7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779303996; x=1779908796;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t3ZYk5fqvq7cU/2S9WHwTroDDw3rio9ewcApjvUks0A=;
        b=m4VkdnKrpce9XGKK7/1X4aQovVDpHrMtO6CjTiVlr/7JlyHze2VGPqKWPYkUnJrkPt
         +XTXUqTZQVQ8uq1R0hBDdBX5trozWJcxM3SNgkGj3yD3WZHnLRt5e4+eHMQK9FWiUmio
         MtbffmtoEaBVMT+ViP0MMFviBW/l/FNlqvRjWlujH3KrxIsWQl42kNEL9zpkiD+G9Kpa
         SOlRULqI02shfmNskc3zDwvrqkyNwvFRzd+YYU3uygySWoDRGaPq1wrRfrHj7zfq0E+7
         6wXVZtg+9hnOSJKXvg2YD65lsmZn+pA+T1js5n9bRS57rgb94+z7rlRvTdbCHp6lX5nP
         Hq1Q==
X-Forwarded-Encrypted: i=1; AFNElJ8ECAE1kDaORq09qcuBHFbqfj+ozfQ3raUtZ157XZC9tchR9J1ZrCBNcSJxhUZcjna05C5wFNLbs1PbjLHY58pp@vger.kernel.org
X-Gm-Message-State: AOJu0YzErUumEFj7DJmzglqoTDdoxa1ExPNp0NhZ5ZMU1f+qXFhbFY/Y
	A642vB/7kf1H+a8oVBc8pcA+6m2MKc5nOutuE3BdyZLoPMWJeuL+VCGB2ZS8u6ekX+0slnOpQUm
	nFrpkpP2W8g==
X-Received: from pgjt2.prod.google.com ([2002:a63:f342:0:b0:c80:dc0a:9f7f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7349:b0:3a3:17f8:bedd
 with SMTP id adf61e73a8af0-3b22ea4f434mr27819932637.17.1779303995412; Wed, 20
 May 2026 12:06:35 -0700 (PDT)
Date: Wed, 20 May 2026 12:05:31 -0700
In-Reply-To: <20260520190538.142018-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512223001.2952848-1-irogers@google.com> <20260520190538.142018-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260520190538.142018-26-irogers@google.com>
Subject: [PATCH v14 25/32] perf kmem: Fix memory leaks on error path and when skipping
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

Fix memory leaks on the error paths and skipped sample handling paths
in the perf kmem tool.

Ensure that all allocated GFP flags and thread references are properly freed and
released via thread__put() when skipping samples or encountering parsing failures,
preventing long-term memory usage leaks during large trace analyses.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-kmem.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 68a39f56204d..daf2272c7337 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -783,17 +783,21 @@ static int parse_gfp_flags(struct perf_sample *sample, unsigned int gfp_flags)
 
 			new = realloc(gfps, (nr_gfps + 1) * sizeof(*gfps));
 			if (new == NULL)
-				return -ENOMEM;
+				goto err_out;
 
 			gfps = new;
-			new += nr_gfps++;
+			new += nr_gfps;
 
 			new->flags = gfp_flags;
 			new->human_readable = strdup(str + 10);
+			if (!new->human_readable)
+				goto err_out;
 			new->compact_str = compact_gfp_flags(str + 10);
-			if (!new->human_readable || !new->compact_str)
-				return -ENOMEM;
-
+			if (!new->compact_str) {
+				free(new->human_readable);
+				goto err_out;
+			}
+			nr_gfps++;
 			qsort(gfps, nr_gfps, sizeof(*gfps), gfpcmp);
 		}
 
@@ -802,6 +806,9 @@ static int parse_gfp_flags(struct perf_sample *sample, unsigned int gfp_flags)
 
 	trace_seq_destroy(&seq);
 	return 0;
+err_out:
+	trace_seq_destroy(&seq);
+	return -ENOMEM;
 }
 
 static int evsel__process_page_alloc_event(struct perf_sample *sample)
@@ -971,6 +978,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	}
 
 	if (perf_kmem__skip_sample(sample)) {
+		thread__put(thread);
 		return 0;
 	}
 
-- 
2.54.0.746.g67dd491aae-goog

