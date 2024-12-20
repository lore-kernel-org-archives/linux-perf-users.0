Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7601CAAC
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 22:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734732242; cv=none; b=pejMGgSrlDoKEAbzh8jGIARXEFtFs2OHN8tI50taWNjZiafiQ56RXTz9WcBga+9kFlU7CPgsdAoSlDHmXF9hRruZrUOVRGXdsV3omuttWTyqAa85mx7lvouL32yTjY+WQS64AyjNMTyQBxMOsX1frpJ9BuwzSt3GfQEMMYc8f98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734732242; c=relaxed/simple;
	bh=ZfYkalIpbhWPopQewgacGgvHxwtKvHpLorvCmaOXf6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkeAu3aHLARWhyvRWo49v7o/T6ah4/Zn7VoXdXDftf7tCchjUj6AB92i6Hfqa9T1HC45fsCatSOOS6PREN/hk66RJtCjBA7kvZ8UFPInbvvAdasHb0nlMVgNJUe8i2Ta8RbNfpL64C/Aj78+Gpa5q0739hA/pRKlLMxNTGuoscQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W6fTO3KH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6fTO3KH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734732240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Gqgy79ltkDjhBO8lLgC33Q9qZN57TFRTb2jFIS6Tdo=;
	b=W6fTO3KHYRhok0txJlv4QeSY+MbkRB4HgX/sercQsvnqFbRTbtTF1zvj2Z5T5JPn7+Z8gI
	17ZQIr/K8JnJwECsGGJEwDC4PhIDb3MIc0jXDfYE05Peb4AbyEYHzxaUArzqxQN23OzLqZ
	DLdczRQrTbkp/kg1+nApvrE/xSlgDSA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-Encjj_p_N12mbDktFnNGDA-1; Fri,
 20 Dec 2024 17:03:57 -0500
X-MC-Unique: Encjj_p_N12mbDktFnNGDA-1
X-Mimecast-MFC-AGG-ID: Encjj_p_N12mbDktFnNGDA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B9F6195605A;
	Fri, 20 Dec 2024 22:03:56 +0000 (UTC)
Received: from telekom.ip.com (unknown [10.45.224.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B28719560A2;
	Fri, 20 Dec 2024 22:03:53 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com,
	namhyung@kernel.org,
	mpetlan@redhat.com
Cc: irogers@google.com
Subject: [PATCH 05/10] perf testsuite: Fix perf-report tests installation
Date: Fri, 20 Dec 2024 23:03:29 +0100
Message-ID: <20241220220334.69198-6-vmolnaro@redhat.com>
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

From: Michael Petlan <mpetlan@redhat.com>

There was a copy-paste mistake in the installation commands. Also, we
need to install stderr-whitelist.txt file, which contains allowed
messages that are printed on stderr and should not cause test fail.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
---
 tools/perf/Makefile.perf | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d74241a151313bd0..50cbc19b002213f5 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1142,7 +1142,8 @@ install-tests: all install-gtk
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/base_probe'; \
 		$(INSTALL) tests/shell/base_probe/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/base_probe'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/base_report'; \
-		$(INSTALL) tests/shell/base_probe/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/base_report'; \
+		$(INSTALL) tests/shell/base_report/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/base_report'; \
+		$(INSTALL) tests/shell/base_report/*.txt '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/base_report'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight' ; \
 		$(INSTALL) tests/shell/coresight/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
 	$(Q)$(MAKE) -C tests/shell/coresight install-tests
-- 
2.43.0

