Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CB72D879B
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753104422; cv=none; b=HPlKtcsXfG6dkkxdjTk+DUYQjc4/3bQyZXYWRyuTug4+n/1vxblhcsVXd/ahDbHm0PQESIc+tLp+zBF0ULeJq/4aHKPOsCC3wElq2cnbybzgX/T6dWNBxTF4x+Qx8KL0QURXL6S7aVC3AXuRHfpgme9U6VtQ9x+lXfccI9F90ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753104422; c=relaxed/simple;
	bh=vJ9hqSW7pA9csafydJvhXoD+F8ld8CJN79mpgaC0YWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWV76Xt0wbQ5W0uhoLXtAAtIaTTakkm52XLC7mV8AAj3cbgN/uqpOa89ArPtzAJTkRD7/aQWa2cV4eIHNrADt4AnVAGgcp9HQ8T8Cfw50sxVV+dvYxyX235VIZT7gyEiu2xZpmxc4Ln9zZ3+BdaRx1buD0BDtXM4yrF8JneAm50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fQNLOCzf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fQNLOCzf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753104420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wOqMhCS9Hq5vWVb+/YermxLDm89lbaEe+YdqwOMzfkU=;
	b=fQNLOCzfnc2YTa8iXbRMMYcGm+G4YBepSbtUOABEo+dWaT2OJoUPI6Yd6e4Fu4OkEO/Uge
	ABIet8IzwQHgMfRc1qXlp9ry8l0amiQCafKE7Fle+ox+ca8gfPElx6+zo+/ZJglJGC+dtw
	hQe2IkfhNlqcxtVkO9PO9/G/InRLOSc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-oQjpdqCvOGCIn6ai3_byNQ-1; Mon,
 21 Jul 2025 09:26:57 -0400
X-MC-Unique: oQjpdqCvOGCIn6ai3_byNQ-1
X-Mimecast-MFC-AGG-ID: oQjpdqCvOGCIn6ai3_byNQ_1753104416
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E8601800295;
	Mon, 21 Jul 2025 13:26:56 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.43.17.245])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F65719560AF;
	Mon, 21 Jul 2025 13:26:54 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: vmolnaro@redhat.com
Cc: acme@kernel.org,
	acme@redhat.com,
	irogers@google.com,
	linux-perf-users@vger.kernel.org,
	mpetlan@redhat.com,
	namhyung@kernel.org
Subject: [PATCH v3 4/7] perftool-testsuite: Add empty setup for base_probe
Date: Mon, 21 Jul 2025 15:26:39 +0200
Message-ID: <20250721132642.40906-5-jbrnak@redhat.com>
In-Reply-To: <20250721132642.40906-1-jbrnak@redhat.com>
References: <20250113182605.130719-1-vmolnaro@redhat.com>
 <20250721132642.40906-1-jbrnak@redhat.com>
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
2.50.1

