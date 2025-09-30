Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A7930ACE1
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759248588; cv=none; b=VDiT1r79E58Ytic3tkdQWwdz4jiJpLxJwJHY17nH3wr8Ndhiyo1IV0ioC7OpVse5pG7/9Z6LZaJE99mDu8uHkXHnl56Ag68mi3vCavCpnSXvC9TQ5/d3Kdtn7hQBw8qUm8wToqGthC1OZWt4MkOWe70HWIawZfgaOEiRwsbH6bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759248588; c=relaxed/simple;
	bh=vJ9hqSW7pA9csafydJvhXoD+F8ld8CJN79mpgaC0YWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ahd7imPoiHFxpF0sz0O/Dqgh0AVJHdTchQ6E1WHIsxDseyV1SVXHIHInsIIOhm5AI46AcoYSN1/vEFxRbLjWChitpz1PEw8zwoBrA0bVuf46EVxv1vLWWAHK/ouo/KlHY/lPtnCZJO5RfYa6uGnXLOvF7y+UFailGRrsRUozndM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AkwPPgYr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AkwPPgYr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759248586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wOqMhCS9Hq5vWVb+/YermxLDm89lbaEe+YdqwOMzfkU=;
	b=AkwPPgYriWVXydATlQrzA/msCiPSmiesFjjOC4jbO9ZI43vg5fOHFelVJWWNC5eECBV/Rt
	ZxgBzfgGDZIaBcnN5SYfhSADkfazstE3HonJUpY8tofTojpbqjjT32fTq9H7l7dgNLf7/3
	1Y4WJi3GDbfL+xMVrCM7xZBvsE/oySw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-pVTn82wANxuzl-goVY-ssg-1; Tue,
 30 Sep 2025 12:09:41 -0400
X-MC-Unique: pVTn82wANxuzl-goVY-ssg-1
X-Mimecast-MFC-AGG-ID: pVTn82wANxuzl-goVY-ssg_1759248580
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4FF11800298;
	Tue, 30 Sep 2025 16:09:40 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.43.17.77])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D93330002C5;
	Tue, 30 Sep 2025 16:09:38 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	acme@redhat.com,
	irogers@google.com,
	linux-perf-users@vger.kernel.org,
	mpetlan@redhat.com,
	vmolnaro@redhat.com
Subject: [PATCH v4 4/7] perftool-testsuite: Add empty setup for base_probe
Date: Tue, 30 Sep 2025 18:09:20 +0200
Message-ID: <20250930160923.13728-5-jbrnak@redhat.com>
In-Reply-To: <20250930160923.13728-1-jbrnak@redhat.com>
References: <20250930160923.13728-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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

