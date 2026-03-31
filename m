Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDABD3A6B77
	for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774951828; cv=none; b=hwysWZt8kK7a8kQioTtjQnHSEtiaAf6k7X6AzGdKyF8Bx/fAkpxWYq/CKZgn/qqfVUaNH1Vm1wAAIdzPqBqlt8q8r5u+XqGPEvZRHfMLcMfapr8xJTeHO1Kl6KHCvQn6XdJ1fjNZ1gvHiJzt6urrRg0awjmZ4xFQtKQ5xETXn9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774951828; c=relaxed/simple;
	bh=LvMLbs3jBpPnyOIave+00wP7mhFyZqWcgh89DVMnOZI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=F+IZi6u3jgJbInhvM25npbKXm28pyqqn9z9isxgq5ona8hnCoaWW+iTZgI41IAapDBwRQ7TxURE7y56ERZp8yYPWe7Ua9dLaEgBk3b/CxU1jXjNKM57b+bk5UzSPHFHR/qHKHtOBTDBAazl97WFWMncarAExFgEsorQeZ7FcZJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=INN0vR36; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INN0vR36"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774951825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LzAi9OZpCNdT8zE911wyHgxV+x985gohGLBt0iRsSmM=;
	b=INN0vR36U3mF6ZRYCmkW3zsKNEvPyElwYb7CxnlaM3KrvnDGpQcL71psIp4yoahHXEFvrb
	oFFUfG2ifTwNvm+eVMb4mMixA+50y7mAb89DwpSS7gMijXvqeP0q8vkTq4dC3Yrc8cfu1L
	6umr3bS9F4sQIc2ca4U60YouCue2TUg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-pAMlDZHuPbK5iqnfHOODwg-1; Tue,
 31 Mar 2026 06:10:24 -0400
X-MC-Unique: pAMlDZHuPbK5iqnfHOODwg-1
X-Mimecast-MFC-AGG-ID: pAMlDZHuPbK5iqnfHOODwg_1774951823
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84ACB1800365;
	Tue, 31 Mar 2026 10:10:23 +0000 (UTC)
Received: from Carbon.redhat.com (unknown [10.44.24.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EC6961954102;
	Tue, 31 Mar 2026 10:10:21 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	acme@redhat.com,
	namhyung@kernel.org
Subject: [PATCH] perf trace: Fix potential u64 underflow in duration calculation
Date: Tue, 31 Mar 2026 12:10:20 +0200
Message-ID: <20260331101020.1270363-1-mpetlan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Although it happens very rarely, in case of out-of-order events (i.e.
due to CPU migration when a syscall is executed), the calculation of
event duration might underflow and thus a bogus value is printed:

    2.804 ( 0.001 ms): :49553/49553 rt_sigaction(sig: QUIT, act: 0x7fff403ed6e0, oact: 0x7fff403ed780, sigsetsize: 8) = 0
    2.807 ( 0.001 ms): :49553/49553 rt_sigaction(sig: CHLD, act: 0x7fff403ed6e0, oact: 0x7fff403ed780, sigsetsize: 8) = 0
    2.815 (18446744073709.438 ms): :49553/49553 execve(filename: 0xbb173a30, argv: 0x55aabb171930, envp: 0x55aabb171120) = 0
    2.815 ( 0.534 ms): pwd/49553  ... [continued]: execve())                                           = 0

Check for possible underflow first and in case of a bogus value, do
not print it.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f487fbaa0ad6..c9de6bb9b0ea 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2956,7 +2956,7 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 		++trace->stats.vfs_getname;
 	}
 
-	if (ttrace->entry_time) {
+	if (ttrace->entry_time && sample->time > ttrace->entry_time) {
 		duration = sample->time - ttrace->entry_time;
 		if (trace__filter_duration(trace, duration))
 			goto out;
-- 
2.47.3

