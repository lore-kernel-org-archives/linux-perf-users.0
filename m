Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2C921ABBB
	for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748529243; cv=none; b=Jn1n4fF7ZvNxHTH9+qvxoocrlu+s7r2C/qoCxo0gykY+yrWEOc+fWh7386oCSuEr5cHfsBdr+rzI3bG0jcuxAhLSqgWI2oyzkdZarM7dR6vD1OR2SN6/23QE+tfnRgTqTWmSdyhd5tpqfTGzPGqBsl96+xyS7RtPoQgG/4vR0qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748529243; c=relaxed/simple;
	bh=jwSwJvZfnajPNXxBTcE2Medy2cObX1A9gl5OPYBUnfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TLFGEKp/cd2duteokTo9HrZoslCpPkf0k/efGOHK7XxlzTN57rfUcGWA2eSOSopo7tsxHHw++uOPXFAzrPQ37YTaaBAF6hymh5IUXojGQI8zC6EkVKqcnWBMRlbvcRJHBJXmJR7ofJ/C2+BdhXGV4GIQBEQ5i7ipuZCX4T7KRKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OYxH3Kk5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OYxH3Kk5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748529241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nMMpWFBK11H+M3SWpdblJ5X0vncyK7tpnYPpe0HATuQ=;
	b=OYxH3Kk5hVWWwq78/avYyVWt5iRSf8HeHMlMN+5ABc4QjZOdpRl34onhQ7L0QiAPr6Ogys
	s//6cls0jtPPqkLS0/KuKev/JvHKg70ikmy6zre49SXytGa9bWcI94P/wJoiO8vQZQI80n
	lrLwlodnPiDJKroC6puo5/7VeKyUd5U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-UMfdz3Z9MgO1K3wqVOvNTg-1; Thu,
 29 May 2025 10:33:57 -0400
X-MC-Unique: UMfdz3Z9MgO1K3wqVOvNTg-1
X-Mimecast-MFC-AGG-ID: UMfdz3Z9MgO1K3wqVOvNTg_1748529235
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6857B195609E;
	Thu, 29 May 2025 14:33:55 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.22.88.199])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 92BFD30001B7;
	Thu, 29 May 2025 14:33:51 +0000 (UTC)
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
Subject: [PATCH] perf trace: set errpid to false for rseq and set_robust_list
Date: Thu, 29 May 2025 10:33:35 -0400
Message-ID: <20250529143334.1469669-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

rseq and set_robust_list don't return a pid, so set errpid for both to
false.

Fixes 0c1019e3463b2 and 1de5b5dcb8353.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 tools/perf/builtin-trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 07eddd5c0baa..0e086b7c1495 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1348,7 +1348,7 @@ static const struct syscall_fmt syscall_fmts[] = {
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* olddirfd */ },
 		   [2] = { .scnprintf = SCA_FDAT, /* newdirfd */ },
 		   [4] = { .scnprintf = SCA_RENAMEAT2_FLAGS, /* flags */ }, }, },
-	{ .name	    = "rseq",	    .errpid = true,
+	{ .name	    = "rseq",	    .errpid = false,
 	  .arg = { [0] = { .from_user = true /* rseq */, }, }, },
 	{ .name	    = "rt_sigaction",
 	  .arg = { [0] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
@@ -1372,7 +1372,7 @@ static const struct syscall_fmt syscall_fmts[] = {
 	{ .name	    = "sendto",
 	  .arg = { [3] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ },
 		   [4] = SCA_SOCKADDR_FROM_USER(addr), }, },
-	{ .name	    = "set_robust_list",	    .errpid = true,
+	{ .name	    = "set_robust_list",	    .errpid = false,
 	  .arg = { [0] = { .from_user = true /* head */, }, }, },
 	{ .name	    = "set_tid_address", .errpid = true, },
 	{ .name	    = "setitimer",
-- 
2.49.0

