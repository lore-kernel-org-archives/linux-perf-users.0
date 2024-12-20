Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86D01CAAC
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 22:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734732248; cv=none; b=fA9uwv5aCsDrgHHyYkU70IOuCrp1+obGdP+0eUiR6Fsq7Eh3FvBsZt/p5CK8qHfdMkji2aLNUZ8CfEchoMMqwjHpdhkb0VPVSU/FKfWj7myP4MJz4TTuZNcih96wZ2oblIEAyfSVKv7j2CSCPJaFyAo1XdE+1GgsMlBfliGjHjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734732248; c=relaxed/simple;
	bh=xnabWyQ+JN0ku3i7L6TQNDJBA///+XQ/oYrG32pN1mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KO9cPDd9raNmFZqmVo2XOR4qJ8NO7bsF13UQyZ+hER6d/t7np8SKZv2LFW5XZoi+kU94sXds7tweRvb0nbhn/rn4WnC0OX4S3NO8hGAtChRiKBrgYnBhvEoXjgWreicuVeKTadMh1rMIcAIasiUfdbUS2emdT/UWJx74rpz6Fjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PlL5l6m6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PlL5l6m6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734732244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r8c6FrMkAHbuJBJhToxyA+VsGmkE+ENKAKwce4l8yrg=;
	b=PlL5l6m6a9inkoUsFChf6UYTwqo/FiGE88KHSozh7720zK0jVd0A5ngrq5bOud9t36vR6c
	uvXkRuJwQUuZX6hF6Bry46Ub2dL6rifMqCJttyKbT3rqblkAe1Y/Rr9OYXytOhutoK4Rwu
	r8MwB9Y343ksJRoUJDuwvJ537AidJso=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-290-rhSabDOkM_WyM4xJtsyHgQ-1; Fri,
 20 Dec 2024 17:04:02 -0500
X-MC-Unique: rhSabDOkM_WyM4xJtsyHgQ-1
X-Mimecast-MFC-AGG-ID: rhSabDOkM_WyM4xJtsyHgQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 31C3B195608C;
	Fri, 20 Dec 2024 22:04:01 +0000 (UTC)
Received: from telekom.ip.com (unknown [10.45.224.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1718019560A2;
	Fri, 20 Dec 2024 22:03:58 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com,
	namhyung@kernel.org,
	mpetlan@redhat.com
Cc: irogers@google.com
Subject: [PATCH 07/10] perftool-testsuite: Add empty setup for base_probe
Date: Fri, 20 Dec 2024 23:03:31 +0100
Message-ID: <20241220220334.69198-8-vmolnaro@redhat.com>
In-Reply-To: <20241220220334.69198-1-vmolnaro@redhat.com>
References: <20241220220334.69198-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Veronika Molnarova <vmolnaro@redhat.com>

Add empty setup to set a proper name for base_probe testsuite, can be
utilized for basic test setup for the future.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
---
 tools/perf/tests/shell/base_probe/setup.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100755 tools/perf/tests/shell/base_probe/setup.sh

diff --git a/tools/perf/tests/shell/base_probe/setup.sh b/tools/perf/tests/shell/base_probe/setup.sh
new file mode 100755
index 0000000000000000..fbb99325b555a723
--- /dev/null
+++ b/tools/perf/tests/shell/base_probe/setup.sh
@@ -0,0 +1,13 @@
+#!/bin/bash
+# perftool-testsuite :: perf_probe
+# SPDX-License-Identifier: GPL-2.0
+
+#
+#	setup.sh of perf probe test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#
+#		Setting testsuite name, for future use
+#
+#
-- 
2.43.0

