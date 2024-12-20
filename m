Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C7D198845
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 22:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734732236; cv=none; b=rs0UypfFGCmp/S4spy3rIaEmLnvTi6+kGbdgAexXBCu4588tiZwb68OmU7LRd6Mcop6ritlSnT2uNa5b5u/B7p89GrYK7nWnBMYx7Nbwwqe2VuBWiTMRJI0oPUaYr+tv4tXYhAGQIheGv+3/3ajp2tFdbBlReAWaB/WQXnVXbL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734732236; c=relaxed/simple;
	bh=kXT203rdPxOcojaQjlbponq2LbYsdeHowgQCi9oLus4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apP7jcMa1IUCCrk6I1J48LjM4O4dvzruSY8N8dduTBt/buEHwXTAG5L/z4zVKvlOB3y2osEr+XHcSpbElC4uRk0rN0qpHMMf8JybBJaOZX6ZP52pmE9cIMgm3yIZZHBCtVvfDE+pfBdiF3OCZueCFyy8NVGTKxoxDn0nGC//h00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GbdVf+bp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GbdVf+bp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734732232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hnHehnIvO09VV5lTYcJvFAwbywFs48KM5+7nhVt+/Nc=;
	b=GbdVf+bpdJP7x9u4NGkFWx+/QbxMc22yN3oumtzCe3xbBaDPC9aMUZqrcqo5jTO41CYOSn
	kpBsAPCbRBR9DDYOnPk4KvCiDUVK1AvERFQizgiIJQKKJ8mdjsys+rK3QUV86k7KCo8p1z
	IqBXrgBXZErUZuMEjGCBCRn+lOXv+AA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-8W-LIviNOKmyDCLjlb5YyQ-1; Fri,
 20 Dec 2024 17:03:48 -0500
X-MC-Unique: 8W-LIviNOKmyDCLjlb5YyQ-1
X-Mimecast-MFC-AGG-ID: 8W-LIviNOKmyDCLjlb5YyQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1011919560A7;
	Fri, 20 Dec 2024 22:03:46 +0000 (UTC)
Received: from telekom.ip.com (unknown [10.45.224.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0727219560A2;
	Fri, 20 Dec 2024 22:03:43 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com,
	namhyung@kernel.org,
	mpetlan@redhat.com
Cc: irogers@google.com
Subject: [PATCH 01/10] perf test perftool_testsuite: Add missing description
Date: Fri, 20 Dec 2024 23:03:25 +0100
Message-ID: <20241220220334.69198-2-vmolnaro@redhat.com>
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

Properly name the test cases of perftool_testsuite instead of the
license being taken as the name for 'perf test'.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
---
 tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh | 2 +-
 tools/perf/tests/shell/base_probe/test_adding_kernel.sh      | 2 +-
 tools/perf/tests/shell/base_probe/test_basic.sh              | 2 +-
 tools/perf/tests/shell/base_probe/test_invalid_options.sh    | 2 +-
 tools/perf/tests/shell/base_probe/test_line_semantics.sh     | 2 +-
 tools/perf/tests/shell/base_report/setup.sh                  | 2 +-
 tools/perf/tests/shell/base_report/test_basic.sh             | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
index ac5a15c57fb38f14..4204e941fad99269 100755
--- a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
+++ b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-
+# perf_probe :: Reject blacklisted probes (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 #
diff --git a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
index d541ffd44a9332b6..c276c2a3fc26ecde 100755
--- a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
+++ b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# Add 'perf probe's, list and remove them
+# perf_probe :: Add probes, list and remove them (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 #
diff --git a/tools/perf/tests/shell/base_probe/test_basic.sh b/tools/perf/tests/shell/base_probe/test_basic.sh
index 09669ec479f23d2f..a69dc1c9f92c1b96 100755
--- a/tools/perf/tests/shell/base_probe/test_basic.sh
+++ b/tools/perf/tests/shell/base_probe/test_basic.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-
+# perf_probe :: Basic perf probe functionality (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 #
diff --git a/tools/perf/tests/shell/base_probe/test_invalid_options.sh b/tools/perf/tests/shell/base_probe/test_invalid_options.sh
index 1fedfd8b0d0ddf30..491eae7ba09574b9 100755
--- a/tools/perf/tests/shell/base_probe/test_invalid_options.sh
+++ b/tools/perf/tests/shell/base_probe/test_invalid_options.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-
+# perf_probe :: Reject invalid options (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 #
diff --git a/tools/perf/tests/shell/base_probe/test_line_semantics.sh b/tools/perf/tests/shell/base_probe/test_line_semantics.sh
index d8f4bde0f585ac80..83f2db898d795c5a 100755
--- a/tools/perf/tests/shell/base_probe/test_line_semantics.sh
+++ b/tools/perf/tests/shell/base_probe/test_line_semantics.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-
+# perf_probe :: Check patterns for line semantics (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 #
diff --git a/tools/perf/tests/shell/base_report/setup.sh b/tools/perf/tests/shell/base_report/setup.sh
index 4caa496660c64f5e..b03501b2e8fc5330 100755
--- a/tools/perf/tests/shell/base_report/setup.sh
+++ b/tools/perf/tests/shell/base_report/setup.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-
+# perftool-testsuite :: perf_report
 # SPDX-License-Identifier: GPL-2.0
 
 #
diff --git a/tools/perf/tests/shell/base_report/test_basic.sh b/tools/perf/tests/shell/base_report/test_basic.sh
index 47677cbd4df31f0a..2398eba4d3fdd3db 100755
--- a/tools/perf/tests/shell/base_report/test_basic.sh
+++ b/tools/perf/tests/shell/base_report/test_basic.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-
+# perf_report :: Basic perf report options (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 #
-- 
2.43.0

