Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7711BFE05
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736792818; cv=none; b=OTsHEWGw34YJxaHO3QogpI66e02cznkXviapX68mhD3LEzk3Ei6VH1G0YORvghGYvFI/kfNnEo6wltyYVC2iqJOd8c/xobGh3TCZT1oN8jdoYMd0JYi/GnGlovWDPcELASGljky1Tc0pGvH3MG6ir8BubzUxQh+rryWAsBGt1P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736792818; c=relaxed/simple;
	bh=Rifa2Dlg9FlCYn1y1uoyMZp3QChKraCqhu6VG0E86fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EhQJdTbB5wLHhUAiGbb2YJA3gIgtqhyBZuklIYJGSwxV9IqN+73vTzEu53wXA92+EahveP3E3Mmo3Q+MzRFIwZ39jBvkGe9i+7P9slZcHtB7EYaHjTQX8HSmsoHyYHCOtpHeaSDD7Uj9hAJbxRA7YkS7Ka4SjqiXpAd/0DSmwlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xvms4UJ4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xvms4UJ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736792815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+f/gHPvLutMV0TuUBm/k5RNvvogD10cY7ADOL6c+d8=;
	b=Xvms4UJ4D/AoK0GyJHiJnJPihOi/5cmZTjjqDsnpOp7YM20iNmRM1kypGAeIrXwgCuPxcg
	y1bdmkyi4PoIUtWR18s8HcT37VkznlZUJFQlC+DlimWg6iDzvXSjiWf4zI5h04CFcM/r+I
	4/3dJ3Uk/AQMyldpnwdrZXNgdkFqF7A=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-as5ECZ1zN0aAKuZDfaKWJw-1; Mon,
 13 Jan 2025 13:26:50 -0500
X-MC-Unique: as5ECZ1zN0aAKuZDfaKWJw-1
X-Mimecast-MFC-AGG-ID: as5ECZ1zN0aAKuZDfaKWJw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B213E1955DCC;
	Mon, 13 Jan 2025 18:26:49 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.147])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55A2E19560AD;
	Mon, 13 Jan 2025 18:26:47 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com,
	mpetlan@redhat.com,
	namhyung@kernel.org
Cc: irogers@google.com
Subject: [PATCH v2 05/10] perf testsuite: Fix perf-report tests installation
Date: Mon, 13 Jan 2025 19:26:00 +0100
Message-ID: <20250113182605.130719-6-vmolnaro@redhat.com>
In-Reply-To: <Z4UwHy-Kj9XDI9cf@x1>
References: <Z4UwHy-Kj9XDI9cf@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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
index a449d00155364422..641ac4df8865131e 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1135,7 +1135,8 @@ install-tests: all install-gtk
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

