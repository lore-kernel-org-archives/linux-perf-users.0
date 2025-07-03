Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722E9289E16
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Jul 2025 04:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751516419; cv=none; b=bhnesAT7yv6dbFp1MbxJ5KfX3RNIZaYAb1SBefSKkX/wg81g6eSwPe6f3Z3jVcsYIyNYkO16oa/bFtcX9CnLWCNS3mSBlhSZPJUXNUrHpbszDrt+37uamhI1HgmLrNC1dWVO9MWJOgrRHdJvW2+OabRFnlDN+UUWkwt3QCdbJdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751516419; c=relaxed/simple;
	bh=rLc8b2dNNuqqVKZiMn6cja/ksI/JbKrvSVdDIzulFPo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=hjh1u+pJb7DW5ojuf+ashJ0UvqXx8x2UdgUuYu2Mb/srRD4Vmt5qzZyapleKPP+Ii+xYpegQWf4p9mSCCPOyt/mSkPfDGJGmVZ1FX8+zzRn1R2GihIgqY6Q0mPvbI2lsDyyZuV3Hl4K26j/+i5RoO/cflgCj5d2GqdqSSgj28tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tLpb/oAx; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tLpb/oAx"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b31814efd1cso5545902a12.3
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Jul 2025 21:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751516417; x=1752121217; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NCuiNh2lweGhl6aAOQS7i4KJyxD4N16XY2C2N8BJ0DU=;
        b=tLpb/oAx4GLe2dWsCXITnc/DMNQPCELByuBDSDx0DjyhPTIQzqbzYxVkG1EMEMui+8
         ib5nuvG1MvNUZW06xjGUrxIRas4DCuTJWxlanxTlgNhVcAcrzHUZaEaUkKuG5lxYsM+a
         /dOl49RTscpwMLIGO/6sWahGyUA2FFFH3m4SV1T5MkFMzKF8GZgbVqoZ4LNGKo7r/gAB
         z/szxy+swwZ1TCJd4xMstWZ2gJajGUhM4Nd1i2kabVKW34da9CYlw6CdKnS/iAjdAbui
         jqRyqoPqVi+AgGJVXDSx/pm7nglzd8hQYxCSi5UVoQPBWisMCUKv358wZxdnlGOFoAyq
         LDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751516417; x=1752121217;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NCuiNh2lweGhl6aAOQS7i4KJyxD4N16XY2C2N8BJ0DU=;
        b=NhT9nWnbmooATChwdt9PSoog/coqbxdb5c5sJybX5eEYl9y5Xlcc1LBNV6TvtTWu93
         W2yBBqWOrO2IWH3nx0WLX5zKT59Zz+PYh8Ui6grY5a8WOxX9IbrBc5YKrr+lA/vtMbB3
         uATy/TuG+fEM6rVV3GnFhESTonTaPu6eRjhttKpmWOl22NNF7ukEopcyf6P7kTqFmCss
         Kr0YEKnqyESZ/MuBEvtBAXMtr9zbENgInF49MQF085GPckLhfNYS9h0pbGhpWeveUqTq
         cFMczqqId7Isl/W6i9stbO7P2/bSKWckpsEN69pqd8UIF26jdTSX8SJNjSVEpezBbSyY
         koog==
X-Forwarded-Encrypted: i=1; AJvYcCV7S8vtZAjwrWFFRp84Y5wqWB2GVXd+b0mjFhKU3w5ZrrnK1VGUe87wHHmNcPyVpeZRSaAuLk3sfKJZEY9v1DlK@vger.kernel.org
X-Gm-Message-State: AOJu0YybnRTQ3zQpnrrTrHuzmTLVTQGCf4GlWoHSGsm8EgyRNZwbAAtG
	Ff7c4rynbiyhtEJfMTF/LuqybM7M2y4D/5qvJF/T70augH0iyPFmAuME5PFBJ4HDiNENvkvocfm
	F+A1Cvx15WQ==
X-Google-Smtp-Source: AGHT+IE4s9ytov+kyRjx5EjBzfe7vyrHcl2JGp03Pms3N8vqlFk5vlVhav1h/SdJSJIMTEPp46RoLX3iKkcj
X-Received: from pge4.prod.google.com ([2002:a05:6a02:2d04:b0:b31:d727:24a4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:730a:b0:21f:5324:34d
 with SMTP id adf61e73a8af0-2243eab4871mr2432123637.28.1751516416742; Wed, 02
 Jul 2025 21:20:16 -0700 (PDT)
Date: Wed,  2 Jul 2025 21:20:00 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250703042000.2740640-1-irogers@google.com>
Subject: [PATCH v1] perf header: Fix pipe mode header dumping
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The pipe mode header dumping was accidentally removed when tracing of
header feature events in pipe mode was added.

Minor spelling tweak to header test failure message.

Fixes: 61051f9a8452 ("perf header: In pipe mode dump features without --header/-I")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/header.sh |  2 +-
 tools/perf/util/header.c         | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/header.sh b/tools/perf/tests/shell/header.sh
index 412263de6ed7..e1628ac0a614 100755
--- a/tools/perf/tests/shell/header.sh
+++ b/tools/perf/tests/shell/header.sh
@@ -42,7 +42,7 @@ check_header_output() {
   do
     if ! grep -q -E "$i" "${script_output}"
     then
-      echo "Failed to find expect $i in output"
+      echo "Failed to find expected $i in output"
       err=1
     fi
   done
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 487f663ed2de..53d54fbda10d 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -4343,6 +4343,7 @@ int perf_event__process_feature(struct perf_session *session,
 	int type = fe->header.type;
 	u64 feat = fe->feat_id;
 	int ret = 0;
+	bool print = dump_trace;
 
 	if (type < 0 || type >= PERF_RECORD_HEADER_MAX) {
 		pr_warning("invalid record type %d in pipe-mode\n", type);
@@ -4362,8 +4363,20 @@ int perf_event__process_feature(struct perf_session *session,
 		goto out;
 	}
 
-	if (dump_trace) {
+	if (session->tool->show_feat_hdr) {
+		if (!feat_ops[feat].full_only ||
+		    session->tool->show_feat_hdr >= SHOW_FEAT_HEADER_FULL_INFO) {
+			print = true;
+		} else {
+			fprintf(stdout, "# %s info available, use -I to display\n",
+				feat_ops[feat].name);
+		}
+	}
+
+	if (dump_trace)
 		printf(", ");
+
+	if (print) {
 		if (feat_ops[feat].print)
 			feat_ops[feat].print(&ff, stdout);
 		else
-- 
2.50.0.727.gbf7dc18ff4-goog

