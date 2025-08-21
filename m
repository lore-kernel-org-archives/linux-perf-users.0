Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE622DE6F9
	for <linux-perf-users@vger.kernel.org>; Thu, 21 Aug 2025 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755795601; cv=none; b=q60NyQjV2Fl6y0eM1nWPtIrcHGe9739l6LfGhY22oU9lHrgXjT28MAcK45H0psizgmNqVOSa3SjZeOKZT8RlVFzV9pdHvS3TtNjqCyar0HmlvgnCD+3Jxj3kUG46CsGOBlrN+B12hk/SX71GmCfx42mgsQaeUN8xiT6r5WX9EFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755795601; c=relaxed/simple;
	bh=71YKxzLO0H7rmJF43V5oO4JjHh8+7s/LefZ3eNE0oR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R6kw/X6KNmLj9/mW981VMN94rU3UJ44tDZqg8ozNSn/Z2nFoSFJgysISvcBbaahVTKtS1ZaY3Qep1e3qGsezSEdogvgUrZcyfjkgKYIbVNtRt5RrMyn69o9DSz9YIM8IJEWaG3TPVXHCqZ9+EaXULDhfZLk6YRfGM2Gv/cOkwOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d6+YC8Xg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6+YC8Xg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755795599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iPvSWI63IgFJF7JbrixYJr90Uqtcs80ZPbPdPacFaIE=;
	b=d6+YC8XgQWajVt0isd+hbFLTiJZ3iViYSOYE7Kia12YPxDSSsKu50yy23dhW9WhbXXmw9t
	uFV7oJsrnrm3PasLAO5Z1WqusLrlIJCRkR+J+yGcNu8/Btdy8DWf4AHadGZ7rwhQrNEfVw
	ib3krYbn3B4NSsbsVpr60Cp2YHWsJ/o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-sjVfb3ZJOc-SDwgE5qA-zw-1; Thu,
 21 Aug 2025 12:59:55 -0400
X-MC-Unique: sjVfb3ZJOc-SDwgE5qA-zw-1
X-Mimecast-MFC-AGG-ID: sjVfb3ZJOc-SDwgE5qA-zw_1755795593
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94E561954199;
	Thu, 21 Aug 2025 16:59:52 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.2.16.211])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AED821955F24;
	Thu, 21 Aug 2025 16:59:44 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: mpetlan@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-perf-users@vger.kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	dapeng1.mi@linux.intel.com,
	james.clark@linaro.org,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH] perf trace: don't show comm/tid for regular syscalls for single-pid traces
Date: Thu, 21 Aug 2025 12:58:32 -0400
Message-ID: <20250821165831.184569-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Previously when attaching perf trace to a specific pid the output would
look like this:

         ? (         ): vest/616160  ... [continued]: clock_nanosleep())                                  = 0
     0.041 ( 0.013 ms): vest/616160 fstat(statbuf: 0xfffff2c60038)                                        = 0
     0.073 ( 0.008 ms): vest/616160 read(buf: 0x3bede330, count: 4096)                                    = 17
     0.090 (1000.095 ms): vest/616160 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0xfffff2c601d8) = 0
  1000.210 ( 0.136 ms): vest/616160 openat(dfd: CWD, filename: "/tmp/something.txt", flags: CREAT|TRUNC|WRONLY, mode: IRUGO|IWUGO) = 3
  1000.361 ( 0.004 ms): vest/616160 fstat(fd: 3, statbuf: 0xfffff2c60088)                                 = 0
  1000.375 ( 0.018 ms): vest/616160 write(fd: 3, buf: SOME TEST STRING\10, count: 17)                     = 17
  1000.395 ( 0.072 ms): vest/616160 close(fd: 3)                                                          = 0
  1000.476 (         ): vest/616160 exit_group()

which would cause an error in the perftool-testsuite since the comm/tid
shouldn't be in trace lines for regular syscalls. With this change the
output looks like this:

         ? (         ): vest/612038  ... [continued]: clock_nanosleep())                                  = 0
     0.039 ( 0.012 ms): fstat(statbuf: 0xfffff8e94cb8)                                        = 0
     0.069 ( 0.008 ms): read(buf: 0x3b997330, count: 4096)                                    = 17
     0.086 (1000.436 ms): clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0xfffff8e94e58) = 0
  1000.545 ( 0.136 ms): openat(dfd: CWD, filename: "/tmp/something.txt", flags: CREAT|TRUNC|WRONLY, mode: IRUGO|IWUGO) = 3
  1000.700 ( 0.006 ms): fstat(fd: 3, statbuf: 0xfffff8e94d08)                                 = 0
  1000.720 ( 0.024 ms): write(fd: 3, buf: SOME TEST STRING\10, count: 17)                     = 17
  1000.750 ( 0.073 ms): close(fd: 3)                                                          = 0
  1000.833 (         ): vest/612038 exit_group()

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 tools/perf/builtin-trace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index fe737b3ac6e6..4cc38ee6aad9 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2955,11 +2955,17 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 	if (trace->summary_only || (ret >= 0 && trace->failure_only))
 		goto out;
 
-	trace__fprintf_entry_head(trace, thread, duration, duration_calculated, ttrace->entry_time, trace->output);
-
 	if (ttrace->entry_pending) {
+		if (trace->opts.target.pid) {
+			if (trace->show_tstamp)
+				printed = trace__fprintf_tstamp(trace, ttrace->entry_time, trace->output);
+			if (trace->show_duration)
+				printed += fprintf_duration(duration, duration_calculated, trace->output);
+		} else
+			trace__fprintf_entry_head(trace, thread, duration, duration_calculated, ttrace->entry_time, trace->output);
 		printed = fprintf(trace->output, "%s", ttrace->entry_str);
 	} else {
+		trace__fprintf_entry_head(trace, thread, duration, duration_calculated, ttrace->entry_time, trace->output);
 		printed += fprintf(trace->output, " ... [");
 		color_fprintf(trace->output, PERF_COLOR_YELLOW, "continued");
 		printed += 9;
-- 
2.50.1

