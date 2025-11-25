Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6842C1CAA6C
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Nov 2025 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764086228; cv=none; b=V8dl7Tq7QUvV5VHyPwTjY+fS9FOP7BQwrTp+zEhn/h5wR7Sz5dAoDoOxsrWtPCxEHFCIKhNi1QBnp9sjf+9b5uc1IAbhq/wdg67FMInuU9NjBKThRKjdyphxQMInf+QwvGj89KFtHEH9o8w9YpiS4iLunTOQzruIOD+wMCuNPo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764086228; c=relaxed/simple;
	bh=NJQ57ffD+rcv/h9M75eKbgh2nqp8mq3XPrkLAFMtE1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIXVwoWY4vKgLoA/lg5xv7ftngplpTCB6LY9/i9bCnuhljBSkpZGPbdBYydn4PQIs+o8FxDw4tLG8pd2+tQ30SOz+na+MwONLYUdIF+8cosMjHJyRB/ji9i1ciPzIQi196nnV1vMbsnsteXQuXRopamC74eJc9QkYjYVuiq0Icc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Edp0dul5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Edp0dul5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764086224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=39K8VBB3/NduuTkOIbcVHQhDLi5YI8SPbCdZTvTC36A=;
	b=Edp0dul5/3vXfoLYlMHHKC2qVZ5QlEEqINnkXVJ9iTS8KPmuJ1+TZlBHBFmZxIGy0Q87B7
	eJL9n6h1rZH54u1PGKEO2rw5jPjTDmecYmLU/YnnerxalHPZYFOSJeDUhsScGSUATn7kI6
	/MXbPb4cYAVzhAghNEgIHaSGm73WdO0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-ZkKvFJZ9PPGrUnDVz5UGRA-1; Tue,
 25 Nov 2025 10:57:00 -0500
X-MC-Unique: ZkKvFJZ9PPGrUnDVz5UGRA-1
X-Mimecast-MFC-AGG-ID: ZkKvFJZ9PPGrUnDVz5UGRA_1764086219
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BBEA61956080;
	Tue, 25 Nov 2025 15:56:59 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.com (unknown [10.43.17.21])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD110180047F;
	Tue, 25 Nov 2025 15:56:57 +0000 (UTC)
From: Jakub Brnak <jbrnak@redhat.com>
To: acme@kernel.org,
	acme@redhat.com,
	linux-perf-users@vger.kernel.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mpetlan@redhat.com,
	vmolnaro@redhat.com
Subject: [PATCH v5 3/7] perftool-testsuite: Add empty setup for base_probe
Date: Tue, 25 Nov 2025 16:56:44 +0100
Message-ID: <20251125155648.197527-4-jbrnak@redhat.com>
In-Reply-To: <20251125155648.197527-1-jbrnak@redhat.com>
References: <20251125155648.197527-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add empty setup to set a proper name for base_probe testsuite, can be
utilized for basic test setup for the future.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Co-developed-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
Reviewed-by: Ian Rogers <irogers@google.com>
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
2.51.1

