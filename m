Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7BF3AEF43
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 22:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625081; cv=none; b=C1vWPt5syrsGZBZlUATHmzfcgNcCSuMMcM/EwTDsP5lYWC6ROrb1cvA3G/0RqSr81hZJZRVivzr4W7YoFDrj1neyr1I6mx0EsGRpRh/bo+sEg7T805CO2wTIGkpkuqAJnBtA8c2kTcYEitYR1rWdcMFrefnj5/xxhkXEfgwTOfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625081; c=relaxed/simple;
	bh=AAKP0fGd8Cy1Pyu/FLhyO9APVU/7/L3kSG0tsmumDCI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fK6TnjXnug+tfH4K52o/oPfmP0XoRKyHzEQrSXhH23JBjWJAUUJItp7al/JMCI393vf1Pe3RVXW7FdxydAYBA12ITX0rEEPPJCaxU/G3ZcFkcwUV1INvNH1OixP1iira9QJKgLVREdSbtPKP+6A7V3r38gPNr7wC+W4SrwZZT6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L3pwX37y; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L3pwX37y"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12dd33dc337so3979973c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 15:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778625078; x=1779229878; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bkI3GJUiFpORdrE16l8Sl0/VhLOrVrjxGmWgxDNhIHU=;
        b=L3pwX37y13Nj4O9yXCogcSgKXNMHtO5PSybGxYLdfsg27P3olc+3gzsF6t5lRzgBsd
         Se6CqJ/G1TmXmsQBJdTBaxx+UC4uU7/zCuO9SjNDYniUZeOKYm1M2noekUX2RvDnG7AV
         i1YpKxMSVRAppxutlQlxDXIP9H3pacQOeCfVljS4jNFNygoTJzoeuxOxHyr/HmO6HTrm
         /c/QvFlkg519xGjZlIROdip6PRHkWhDiRhNdZBoEYseY7i9qexcfGehamABfnzBJpeJO
         Io79kWV1HUnnJCTbHTVn3Q7SLd6RMNRHh48bLlXRP0ngk7MiZdlD7ql6J47FdvucyYjn
         vl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625078; x=1779229878;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bkI3GJUiFpORdrE16l8Sl0/VhLOrVrjxGmWgxDNhIHU=;
        b=sZzO9xMoFGILmshbxSIy4mIRSP6dnb9vUE6Em56YTjdD624YaSJF5lKNCakA3zd3z6
         GqMY4mbSU8My+uLy37jTxFHzo3xUEc2DyghvLoxDnNDH4UX2bQm0/jqaSABJlVaK2HF+
         2KOfkCadCD/SqJeMz+J0aHL+605ObSsnNUslF2YdTN0FjWPOKOFuzXpQXqa8d29U2UYd
         rgTzGRmSYFMFxqrVGwqoJfMBFpDSCscbnYdZqaMDHYTQ9exHncHqwZ6axe9j5ArTEhEX
         zfryNM61Oxmn99qbqKz9vOjGJpU6X1lkWZaEC8fv80+O0l4vsZuh9MXaSumPb+aIkGZU
         lXuw==
X-Forwarded-Encrypted: i=1; AFNElJ9Uia2OwR3IOd6/jE2xu55d/kbkRkemkOe1aYmyNSXRbBIzINuXDceUR6Bj2gCt3upmHFHrkiVGZN8MXg1UQnWh@vger.kernel.org
X-Gm-Message-State: AOJu0YwmHWzZgJAAnm5BD9IxhQCy5B8TiCAufLpbKzKaM1tSNvOyUiY7
	Gc0oy+F9Be8wlapKZv/8lmVbQj/zCeCN4JdaPizC7YNxyHSTM3dfObVQnvYITEUmITVznXizntS
	ts9HGPXm/Rw==
X-Received: from dlad16.prod.google.com ([2002:a05:701b:2210:b0:130:c9dc:1b88])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4389:b0:12d:c4b7:5625
 with SMTP id a92af1059eb24-1341e8c9164mr420141c88.9.1778625078077; Tue, 12
 May 2026 15:31:18 -0700 (PDT)
Date: Tue, 12 May 2026 15:29:54 -0700
In-Reply-To: <20260512223001.2952848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413041143.1736055-1-irogers@google.com> <20260512223001.2952848-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512223001.2952848-26-irogers@google.com>
Subject: [PATCH v13 25/32] perf kmem: Fix memory leaks on error path and when skipping
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	namhyung@kernel.org, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Add missing frees and thread__put as necessary. An issue detected by
Sashiko code review.

Signed-off-by: Ian Rogers <irogers@google.com>
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
2.54.0.563.g4f69b47b94-goog

