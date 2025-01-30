Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E581B3939
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Jan 2025 21:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738272943; cv=none; b=hDQY6xpLXrDPkkls1QDbdOumZbYEsuXWiAwvRzSxSHq+/XZ0eBllxXX2mzG5NSI1xaDB6DT1dB837Ln95DzvKHWuAdcfh08iJcjdWT/Yn5nw2FOOVT4lh5+iMAjZOYi79I6BM8K0f9VHjozNtZppw/e9Nn45t5vZYDyF5vIHLDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738272943; c=relaxed/simple;
	bh=eD3MBkWthqL4xB6tCJFF8enkKgU8DQIYxuunH7vF7oM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NemuJ8DtPXpsItV6ddbAkXJYO8agIAt7LJRdQa7zhq+2tu0Gn74a2ZG9pLDyrqTlk1eXSmPHuqPRaeFaflkC67xddG/wQPZjWoHXs1WJFwvqNYrBpr9HdW+KkG+598g0kfSQiG9uQVAtT9uRcUxhxNDX1fYcxZey2/sXXwn8pnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gbVc99lg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gbVc99lg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738272940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sT+Gm7l6Mop3Kr/tB2nvv33r9mApey6xQrHeFIYWlD4=;
	b=gbVc99lgEuk2Q513CHjuYYm5AVAaGF2sw3AfUGDNYLI+j8nuvkgTFCmJEiNV6Mt3P4LMi/
	8h2nS7lVkOQe0f0PftWJ6Nl01BwB89fTaJz2AEwUDm3woIulufIfeWwTrFb7f/ABdwxYsa
	bBw+biBZSSa5o/P3sXrPHPlixyMcJ/8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-Uq3FZH4KN9Gzczb_qYA9RA-1; Thu,
 30 Jan 2025 16:35:36 -0500
X-MC-Unique: Uq3FZH4KN9Gzczb_qYA9RA-1
X-Mimecast-MFC-AGG-ID: Uq3FZH4KN9Gzczb_qYA9RA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86DF21956083;
	Thu, 30 Jan 2025 21:35:34 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.22.80.81])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6AA3A19560AA;
	Thu, 30 Jan 2025 21:35:30 +0000 (UTC)
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
	james.clark@linaro.org
Subject: [PATCH] flamegraph: force flamegraph-report script to run in live mode when using 'perf script flamegraph'
Date: Thu, 30 Jan 2025 16:35:26 -0500
Message-ID: <20250130213526.2626749-1-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Currently, running "perf script flamegraph -a -F 99 sleep 1" should
produce flamegraph.html containing the flamegraph. Howevever, it gives a
segmentation fault.

This is caused because the flamegraph.py script is
supposed to take as input the output of "perf record", which should be
in stdin. This would require passing "-i -" to flamegraph.py. However,
the "flamegraph-report" script causes "perf script" command to take the
"-i -" option instead of flamegraph.py, which causes no problem for
"perf script", but causes a seg fault since flamegraph.py has no input
file. To fix this I added the "-i -" option directly to the
flamegraph-report script to ensure flamegraph.py gets input from stdin.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 tools/perf/scripts/python/bin/flamegraph-report | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/bin/flamegraph-report b/tools/perf/scripts/python/bin/flamegraph-report
index 53c5dc90c87e..83d5738c75ca 100755
--- a/tools/perf/scripts/python/bin/flamegraph-report
+++ b/tools/perf/scripts/python/bin/flamegraph-report
@@ -1,3 +1,3 @@
 #!/bin/bash
 # description: create flame graphs
-perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -- "$@"
+perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -i - -- "$@"
-- 
2.48.1

