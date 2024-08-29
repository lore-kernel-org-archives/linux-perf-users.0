Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FFA18A923
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Aug 2024 11:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931012; cv=none; b=jdYV2XO0siTFXogQdkW2owjfoQ9ypNiNaVqs3/Q3Cco4y7pHTdqFbPGcHmyGu5V1aSKPNOb4K5luHre46Cw8uk90rmygF3eNBJ42B8UuPPBHuuLZ9iG7qYrfDc8FNO7gmV12Ma5JbXo1wR39K6KMWy+zA1EYzsgrWD76KR+DIHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931012; c=relaxed/simple;
	bh=ns/SWkYblnisgUkg10Kr+XhbW1ElWRVH4ojz0Hf4XuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqVPN9xtpX5FyK1vMhwPGSdRlvV5CXl4cDJtKEcXMYUEZ/8EpsU0uTre4DJVDkY6CuApm9vHK73/MW6F3f1NOitHNY2F7tFSmx6lLPBY4Zasv4tAGqNp88LqwXZwgmOUVQLEOQQCphfpQqNqwSLjEWFcLBBa167t4h5Bt55xTdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iIGWNzEM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iIGWNzEM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724931009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gH82ns+bRDgvvkluox+erHrwb80sXG38ppWjImrCo8g=;
	b=iIGWNzEMWegbfpKv54c31z5x2FkARMW65vB4FOSzOIqpVF2Co5ZLOiBo+d1rxJzXX7idAC
	/bSDgdStJ8B931MQsFzXEJZ/6JRZDTgwBAHBBTCGi//vRzS0yOPRVtU9GPG3mgN2A2Bd7a
	yzI8jJpLUqMp/tVr2PcPJbxv5okUHfc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-Lpysy7zAO4S07gzwGUE_Tw-1; Thu,
 29 Aug 2024 07:30:06 -0400
X-MC-Unique: Lpysy7zAO4S07gzwGUE_Tw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F0391955D4A;
	Thu, 29 Aug 2024 11:30:05 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.56])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C8641956053;
	Thu, 29 Aug 2024 11:30:02 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com,
	namhyung@kernel.org
Cc: mpetlan@redhat.com,
	irogers@google.com,
	atrajeev@linux.vnet.ibm.com
Subject: [PATCH v2 11/11] perf testsuite: Install perf-report tests
Date: Thu, 29 Aug 2024 13:29:57 +0200
Message-ID: <20240829112957.12595-1-vmolnaro@redhat.com>
In-Reply-To: <Zs-LEEutfp0hkjh5@x1>
References: <Zs-LEEutfp0hkjh5@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Michael Petlan <mpetlan@redhat.com>

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
---
 tools/perf/Makefile.perf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index e6d56b5553..b921b19c39 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1081,6 +1081,8 @@ install-tests: all install-gtk
 		$(INSTALL) tests/shell/common/*.pl '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/common'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/base_probe'; \
 		$(INSTALL) tests/shell/base_probe/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/base_probe'; \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/base_report'; \
+		$(INSTALL) tests/shell/base_probe/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/base_report'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight' ; \
 		$(INSTALL) tests/shell/coresight/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
 	$(Q)$(MAKE) -C tests/shell/coresight install-tests
-- 
2.43.0

