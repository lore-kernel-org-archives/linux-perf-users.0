Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B23408626
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Sep 2026 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788764070; cv=none; b=Jm5BGQPoJt4tMrfeRHquULnJkyiKjMELDC15cfsBDpERT3rNXxx7onBs8G6H3UCn4hkUiWKW/VI9vvQO7+6R95yd71Y7j3WLDDggecEtnVfYyqdTPZJyTTyLcOnM+9GTrUwSJ4vd4UlLh8oyri1Vl09LCy3tZnpcoB5QpGVJ3cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788764070; c=relaxed/simple;
	bh=rNe9lHzYb4jcyjnxQlYUuDj47iMTb1WR3eBxt42SEd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ox0DWqYH1h6zFMDwxkWg5Lw5fHzjMtGNFU1BLjaz4lO2ctrWh0Cx/lSMaC8Z+PSSJATX36QXy7Quqa8ykVfa/sukuzAYQ9lF0yr8tNKBop3XGd2A+ahF0Pcgakn/AgjEvoNOeer9J+gkF0YluY5CIAIOmX8LbFbjCCPqvsePdwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMQZabsh; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMQZabsh"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ca7c1176317so2616481a12.1
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Sep 2026 23:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788764068; x=1789368868; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hmrACrJalGoGeps5xas3jHbQ9Lu3LHrYoreTzpBrIJU=;
        b=bMQZabshEJoZ6PDlYZN4MrCplvAtdYlXM2m1LZkTTPMSzA0xRX//ydte2VdqiDrA58
         cpvM8IAjZ1hBgL49bL8DoceAUigObNBy2Q779utWebG6xgq7dzGnxBVkpC0c5kawLdCn
         Cw+Tt8eNo0Qri9KUV+I6Q74bsArO7IYdUb42wT5JRBaXyeRJ5g8W+KEmkZV6Iv60ijzj
         vXNoNI6ilOli1kQF8widr64QXfNGdTyLcPiyJAEqkDCfVhEmnESdwWmAQVa97KcpXDGT
         SHqpXujz4Ch1Ax6The16TNEmQG/VuxSV7ZefG9Y5YVFFUmVZU5hk/xGnv13gp7NG9dQU
         NJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788764068; x=1789368868;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hmrACrJalGoGeps5xas3jHbQ9Lu3LHrYoreTzpBrIJU=;
        b=WETRzEvOt4FRQpwKvSGFxHaDCwQv3GtCSkAl84R44dZBNEu983rJdoLMyg5gNduWms
         Np+VPSULL4gizVgyL1huJPoq+/0N5lF3Eq+f3/CXLNQElZ5eIPyigAtKLukLEu4B1tgh
         l4cek1uGnhqxE5wMEHHRsAKMMnGY7TJXf5+X8sT9VQP/q/UsjXNvpgS3RJ+UKmsE/u+z
         y95ea7hEI/ePpvj38iELUViJc/F2XY2t+uaNgJKodnay8bu+8mkQmQXlwTS0UFQyoYaY
         f9o/oEal3JSdBTdXMjVSaAPWJg4eGKU9ethZvCb8at2tiaHryDtnEKt2HbJgj2a1zmBN
         cGmA==
X-Gm-Message-State: AFuF++n1VJEauDDJco8Q8XeZeRW1r8pT0RN4ySH1odRUL5fY9cnT05dv
	0AMs91dMt3TyKBmoHl/UEYI9cbLhvIEcseg8pB6maHqek0QKBeFRdEjB
X-Gm-Gg: AYBFou2MrxjTojIvi+iMIe2rrCFu4fD87SKiXFXjlhR7XePfNqjnxmqWCERr1+iBcqK
	turuf9McDCWPDCOoutWg1TLnpcrWqjK8QdtH5VpwoSb/2PHjGz5jlHi06boZLwt7OD1276X0iNu
	VPY7E5QJADJ0o1LBbYiuZBeABfpJOLsf4m2HG6GXCMM66XVWzEzWB4AG9IZIx84rQZKtKgJoBn7
	Vj8fgFgp+v+8noVxWdYU/JDUFbj0KcRKRBbb+uLAncqd0faRKb+U1qzuCVSiYAWvA56ZdKtT4SZ
	628jglS0ORCOhP3M4RCkPW9/x4hEuF0A0vxJfpVQdP9LOmCOWL43kKY3Nf3mnws+FEEXA6NItoR
	awXj0aBG6uGKNxdEVTWqG2dx5FS2vlHFR6+KZ9Pxi633mqlO8XWkYVtWau9+nu6ryylywfASNme
	WVoCI9POL0pm3io3emESrAUMxcthum1Rl0MFu571KvGLJnxt8rS7tDlE6LiZdaanUegbrsWPQ5l
	gkyAYRL4WfUQw==
X-Received: by 2002:a05:6300:6cc3:10b0:3da:755f:a031 with SMTP id adf61e73a8af0-3da755fa627mr7027400637.12.1788764067698;
        Sun, 06 Sep 2026 23:54:27 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432437d0f4sm22232401c88.7.2026.09.06.23.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:54:27 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/14] perf: fix typos in comments
Date: Mon,  7 Sep 2026 12:24:21 +0530
Message-ID: <20260907065421.11739-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/perf/builtin-trace.c                      | 2 +-
 tools/perf/trace/beauty/include/uapi/linux/fs.h | 2 +-
 tools/perf/trace/beauty/syscalltbl.sh           | 2 +-
 tools/perf/ui/hist.c                            | 2 +-
 tools/perf/util/annotate.h                      | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c3c7f1f85c53..de86901b178b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -104,7 +104,7 @@
 /*
  * strtoul: Go from a string to a value, i.e. for msr: MSR_FS_BASE to 0xc0000100
  *
- * We have to explicitely mark the direction of the flow of data, if from the
+ * We have to explicitly mark the direction of the flow of data, if from the
  * kernel to user space or the other way around, since the BPF collector we
  * have so far copies only from user to kernel space, mark the arguments that
  * go that direction, so that we don´t end up collecting the previous contents
diff --git a/tools/perf/trace/beauty/include/uapi/linux/fs.h b/tools/perf/trace/beauty/include/uapi/linux/fs.h
index bd87262f2e34..ee2203d60643 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/fs.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/fs.h
@@ -88,7 +88,7 @@ struct fstrim_range {
  * We include a length field because some filesystems (vfat) have an identifier
  * that we do want to expose as a UUID, but doesn't have the standard length.
  *
- * We use a fixed size buffer beacuse this interface will, by fiat, never
+ * We use a fixed size buffer because this interface will, by fiat, never
  * support "UUIDs" longer than 16 bytes; we don't want to force all downstream
  * users to have to deal with that.
  */
diff --git a/tools/perf/trace/beauty/syscalltbl.sh b/tools/perf/trace/beauty/syscalltbl.sh
index 1199618dc178..e70a8c79e019 100755
--- a/tools/perf/trace/beauty/syscalltbl.sh
+++ b/tools/perf/trace/beauty/syscalltbl.sh
@@ -55,7 +55,7 @@ build_tables() {
 
 	echo "static const uint16_t syscall_sorted_names_${e_machine}[] = {" >> "$outfile"
 
-	# When sorting by name, add a suffix of 0s upto 20 characters so that
+	# When sorting by name, add a suffix of 0s up to 20 characters so that
 	# system calls that differ with a numerical suffix don't sort before
 	# those without. This default behavior of sort differs from that of
 	# strcmp used at runtime. Use sed to strip the trailing 0s suffix
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index e58327595d37..dcc535cc991c 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -431,7 +431,7 @@ static int hpp__header_mem_stat_fn(struct perf_hpp_fmt *fmt, struct perf_hpp *hp
 		int left, right;
 
 		len = 0;
-		/* update fmt->len for acutally used columns only */
+		/* update fmt->len for actually used columns only */
 		for (int i = 0; i < MEM_STAT_LEN; i++) {
 			if (hists->mem_stat_total[mem_stat_idx].entries[i])
 				len += MEM_STAT_PRINT_LEN;
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index fa08d09b80f7..c2a0a5cc4af9 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -275,7 +275,7 @@ struct cyc_hist {
 /**
  * struct annotated_source - symbols with hits have this attached as in annotation
  *
- * @source: List head for annotated_line (embeded in disasm_line).
+ * @source: List head for annotated_line (embedded in disasm_line).
  * @histograms: Array of symbol histograms per event to maintain the total number
  * 		of samples and period.
  * @nr_histograms: This may not be the same as evsel->evlist->core.nr_entries if
