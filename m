Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B4738F93A
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071864; cv=none; b=o/lf663mhZslJ6W7p4xDvJzZcQTwVpUoNpj3lrfT1g8XurWfG8l8Cf+RvAhYAi6yWflEs671cpuL4bC1IqXzjnJT1zk1ccd7mp4TG6rqT0p56nVdUsMSCnIq66TtypnzbzeFRbonqRA2ufv/gnHFoiGgyIjFUUn3jtKd4paJ/0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071864; c=relaxed/simple;
	bh=Zv+N5H46hfCji2bq3tlKyLs4Xg5PdZYnxy8tjLNZij4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EgfwKC+2jWnCG1k3E4wNGLt+vHgfaED/pk5Vau+En2m4cX8prZ0jjPT8KlczxwzVk8NMfzM3wiJ2HBBp7bbezj+nZx2yEmlZS7OdO+b0CE4Bo5LeP9t/esNyOyTEofv5RKplrrOlYoxbSVz655lrmlbVJT4tTJBbsC03Eo3aQg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kdhyqbki; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kdhyqbki"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773071861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tPymI9K5wiIcRRYCGuKCy57OLBabMS3LJZSQEbI1pMQ=;
	b=KdhyqbkiqhE8NCnM6PpBWvJZLg5Izh3co7DaFcUWjb91xRog6ux7gxmvs6tfTY5fNefl4V
	mWuCovvkPMAuZeXAOQydYb7fsm+vDFW3pGuHjo7lkUWKS4TNLpeXt4pIXESri+VGSeI2br
	qHuP27Ftw8cXyMbPYiU8839TrSx6TFE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-1uiz5rt6M8if48lnUS42DA-1; Mon,
 09 Mar 2026 11:57:40 -0400
X-MC-Unique: 1uiz5rt6M8if48lnUS42DA-1
X-Mimecast-MFC-AGG-ID: 1uiz5rt6M8if48lnUS42DA_1773071859
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D9E8195608D;
	Mon,  9 Mar 2026 15:57:39 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.43.17.6])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB50530001A2;
	Mon,  9 Mar 2026 15:57:37 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: acme@kernel.org,
	acme@redhat.com,
	linux-perf-users@vger.kernel.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mpetlan@redhat.com
Subject: [PATCH v6 3/7] perftool-testsuite: Add empty setup for base_probe
Date: Mon,  9 Mar 2026 16:57:24 +0100
Message-ID: <20260309155728.98026-4-jbrnak@redhat.com>
In-Reply-To: <20260309155728.98026-1-jbrnak@redhat.com>
References: <20260309155728.98026-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add empty setup to set a proper name for base_probe testsuite, can be
utilized for basic test setup for the future.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Co-developed-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
---
 tools/perf/tests/shell/base_probe/setup.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100755 tools/perf/tests/shell/base_probe/setup.sh

diff --git a/tools/perf/tests/shell/base_probe/setup.sh b/tools/perf/tests/shell/base_probe/setup.sh
new file mode 100755
index 000000000000..fbb99325b555
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
2.52.0

