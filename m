Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C466C1C1741
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Sep 2024 15:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727450380; cv=none; b=Ctdm+K8c6xH6RmwxDkb/I2LERKyeZsHTJY0svJu4ASGtlUKdOnN4oItYYKMvCS52KG9V+/SPfDK0mCJ/pfsoMVomvzQuylfofWVpwJX5zPHngcIPrXiEYsu7vSuJGx6lixg/iuVGORg4QHuzxwTPY1KTBCKfTcuooSOWETy6IUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727450380; c=relaxed/simple;
	bh=QZpCcmRRPkiDgzmSA8rVrxnuYM285ZCHCgkQ41zxFB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hwcbcO3B1jfSx5Ts66l1B+Wey8SKEF1n91kpDbNyl3HYGShrxPiWy0DSafGpQ0hAQ+J6dvE36Tyl7VEbupQf++mxLS1JXjVL4Xjdghgxg8wpXQdBptvx0SBPXyQnhLNM8SBTbkKs2nBSP4rq2FERJumm1UVseMICRd/aYnLcW60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U1TyGT/U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U1TyGT/U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727450377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NikHNuoNzRhKTzErVG/9wIbh/q5IpNLhlNDSpCB+Vik=;
	b=U1TyGT/UFo+lZeTYFfnbd5Xm82uBsaSFy2x7PZzxd90DjoIVLy9qtqOzfHt1DQYgljsjs1
	FSGSMnYPaQZWA5hWzh15HCsBtBWM92v5T0Lxb1xA0BBjVHnATgVbVZuA4UX2/H52K7I7dz
	g8qBH1IIrma0KC+HiyOexDf7eI/KU/o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-4rTSjycsPFeLgCAL95hkzA-1; Fri,
 27 Sep 2024 11:19:34 -0400
X-MC-Unique: 4rTSjycsPFeLgCAL95hkzA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2BBAB19792FF;
	Fri, 27 Sep 2024 15:19:33 +0000 (UTC)
Received: from Carbon.redhat.com (unknown [10.39.208.41])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 49E871956086;
	Fri, 27 Sep 2024 15:19:28 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	vmolnaro@redhat.com,
	irogers@google.com
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Subject: [PATCH] perf trace: Keep exited threads for summary
Date: Fri, 27 Sep 2024 17:19:26 +0200
Message-ID: <20240927151926.399474-1-mpetlan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Since 9ffa6c7512ca ("perf machine thread: Remove exited threads by
default") perf cleans exited threads up, but as said, sometimes they
are necessary to be kept. The mentioned commit does not cover all the
cases, we also need the information to construct the summary table in
perf-trace.

Before:
    # perf trace -s true

     Summary of events:

After:
    # perf trace -s -- true

     Summary of events:

     true (383382), 64 events, 91.4%

       syscall            calls  errors  total       min       avg       max       stddev
                                         (msec)    (msec)    (msec)    (msec)        (%)
       --------------- --------  ------ -------- --------- --------- ---------     ------
       mmap                   8      0     0.150     0.013     0.019     0.031     11.90%
       mprotect               3      0     0.045     0.014     0.015     0.017      6.47%
       openat                 2      0     0.014     0.006     0.007     0.007      9.73%
       munmap                 1      0     0.009     0.009     0.009     0.009      0.00%
       access                 1      1     0.009     0.009     0.009     0.009      0.00%
       pread64                4      0     0.006     0.001     0.001     0.002      4.53%
       fstat                  2      0     0.005     0.001     0.002     0.003     37.59%
       arch_prctl             2      1     0.003     0.001     0.002     0.002     25.91%
       read                   1      0     0.003     0.003     0.003     0.003      0.00%
       close                  2      0     0.003     0.001     0.001     0.001      3.86%
       brk                    1      0     0.002     0.002     0.002     0.002      0.00%
       rseq                   1      0     0.001     0.001     0.001     0.001      0.00%
       prlimit64              1      0     0.001     0.001     0.001     0.001      0.00%
       set_robust_list        1      0     0.001     0.001     0.001     0.001      0.00%
       set_tid_address        1      0     0.001     0.001     0.001     0.001      0.00%
       execve                 1      0     0.000     0.000     0.000     0.000      0.00%

Fixes: 9ffa6c7512ca ("perf machine thread: Remove exited threads by default")

Reported-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/builtin-trace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f6e847529073..1a12ed71c809 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -5449,6 +5449,10 @@ int cmd_trace(int argc, const char **argv)
 	if (trace.summary_only)
 		trace.summary = trace.summary_only;
 
+	/* Keep exited threads, otherwise information might be lost for summary */
+	if (trace.summary || trace.summary_only)
+		symbol_conf.keep_exited_threads = true;
+
 	if (output_name != NULL) {
 		err = trace__open_output(&trace, output_name);
 		if (err < 0) {
-- 
2.43.5

