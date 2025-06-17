Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADE72E8890
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Jun 2025 15:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750173063; cv=none; b=IMaDPEqbFD1lII12gpGxY426JmNdmGmfj3gD5V+SmL1nXm674OOKh68BcJdwOJjdx7Ze76XlHyFEfKzq/SwURwvcfZDdp7VBEM93Hmz6wL1spIwAQmD28sTu0cVQ5nWSiwAh0vzd6bPAFdEKEQYCLVwdZy7tYDWlZ2Q9sITQtGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750173063; c=relaxed/simple;
	bh=el7jWHCHyOxFyj/I6oX+2Oq1fPUjydQ+xyeadO3qhUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fzMu8+jJxZh4bFXfQ5QMwcI4/OxKBAse1hlkl5sLus0O2kYxOhgAFtdQzlzyjDK91kFaaDkIbkFWNIiDxI2Oj68wd0ThanB4nWVsi3F0xyKKEliedLbb+vJcPIq/Nn82rloCgiEwUrY5VP7F/OyYXWnbHvYrwyKEt1TGiayaPPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DNUSpRDf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNUSpRDf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750173060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gSNk1TQNrBeEJ36zJz2oG9wOktdMivBbzFygyWWDptI=;
	b=DNUSpRDfSIsXl1S0caZ1WYfVIqEwa/CbLAmzqp9EDALwjB2Y1OKPTCLMGN546o6cQwFC8m
	JdQve17fzb51gov5bKF2JQyuBjCzovqFnhOH/dfCIzf+sNBJPA72w4FKYEMT+rM4qEwZ51
	EjPnUf+GJ8mLbhq7c4lc/6e/hJIx/zU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-4WYHD4_pOcKK2RRX9MkmIA-1; Tue,
 17 Jun 2025 11:10:55 -0400
X-MC-Unique: 4WYHD4_pOcKK2RRX9MkmIA-1
X-Mimecast-MFC-AGG-ID: 4WYHD4_pOcKK2RRX9MkmIA_1750173053
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F22719560AE;
	Tue, 17 Jun 2025 15:10:52 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.22.82.51])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6CA62195E346;
	Tue, 17 Jun 2025 15:10:49 +0000 (UTC)
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
Subject: [PATCH] perf header: exempt x86_64 from core id test
Date: Tue, 17 Jun 2025 11:08:48 -0400
Message-ID: <20250617150847.4029177-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On a VM running on an x86_64 architecture, it is possible for the socket
id to be greater than the processor number. So exclude x86_64 arch from
the core id test.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 tools/perf/util/header.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index e3cdc3b7b4ab..c1b4651d0c6a 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2618,9 +2618,12 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 	 * The socket_id number might be higher than the numbers of cpus.
 	 * This depends on the configuration.
 	 * AArch64 is the same.
+	 * It is also possible for a VM running x86_64 to have a larger
+	 * socket_id number than the number of cpus.
 	 */
 	if (ph->env.arch && (!strncmp(ph->env.arch, "s390", 4)
-			  || !strncmp(ph->env.arch, "aarch64", 7)))
+			  || !strncmp(ph->env.arch, "aarch64", 7)
+			  || !strncmp(ph->env.arch, "x86_64", 6)))
 		do_core_id_test = false;
 
 	for (i = 0; i < (u32)cpu_nr; i++) {
-- 
2.49.0

