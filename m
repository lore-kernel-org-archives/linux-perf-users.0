Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0C83B38B7
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Jun 2026 18:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782498476; cv=none; b=WHrOJFFiTIU2Um6PkXUWZZcteMClzGOWoEhVPqN4EbrYFjrZPBcCWEd6IQ0/HRqQUC2DHm9p9hnfP4m33BWVCOKFfo6VUoCrGWSGksRniUGHNT11Gh6kVVA223w48PdxNoCkxFfNlpbsLI72EkEOItK5leZ5810StFMOXKJCmM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782498476; c=relaxed/simple;
	bh=6ZMPDasazObhqHlWKpclJ6zVwUjuvzg+T8hPmaS8egs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MwQ3rfHatZSJdGdOCq6NTHA35gMJMhIpaPXGZRNeyeMt3L5neW/wis3Ba3WesdaOIoMcIqJpTF/4GxkH36+ADhmqejlElTfrcB3Lbs1YnWN36N1b7bCQIjyeUy3oltrOF5CgRE8y3NYcmdvBvwy4Yv/XD3QecWBsY203FwsESic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UO+uF3Af; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UO+uF3Af"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782498474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qOFmYjWYFQnKBDLsqK9OfnNy5h7vSIcYXh9a5wTiadk=;
	b=UO+uF3AfT2b1mIWOSD+pRUBQQ1xokaQI719QeCoTqo9dYdQ16YQp5lIpPgeaVvrHCuCZR/
	aJDURAfMsp+bxBdWXW9dNENR4tLtpzWtqIlR/rGEYSfI1w+zx7DKdv0n0ItJOgLLsesNen
	j1H8OB9G16N97oMQ7X+EjJkmVP794f0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-rdy4-1nxMv2Pp0y607S8hg-1; Fri,
 26 Jun 2026 14:27:48 -0400
X-MC-Unique: rdy4-1nxMv2Pp0y607S8hg-1
X-Mimecast-MFC-AGG-ID: rdy4-1nxMv2Pp0y607S8hg_1782498467
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1EEAA18005B1;
	Fri, 26 Jun 2026 18:27:46 +0000 (UTC)
Received: from tallison-mac.redhat.com (unknown [10.22.64.39])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A5ECA30001A5;
	Fri, 26 Jun 2026 18:27:43 +0000 (UTC)
From: Trevor Allison <tallison@redhat.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tallison@redhat.com
Subject: [PATCH] perf build: Add LDFLAGS to dlfilters .so link
Date: Fri, 26 Jun 2026 14:27:39 -0400
Message-ID: <20260626182739.53294-1-tallison@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Build-time linker flags were not applied when linking dlfilters.
Pass LDFLAGS for consistency with the other link rules.

Signed-off-by: Trevor Allison <tallison@redhat.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 3f0544d37a7f..2b53d9e0c73b 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -680,7 +680,7 @@ $(OUTPUT)dlfilters/%.o: dlfilters/%.c include/perf/perf_dlfilter.h
 .SECONDARY: $(DLFILTERS:.so=.o)
 
 $(OUTPUT)dlfilters/%.so: $(OUTPUT)dlfilters/%.o
-	$(QUIET_LINK)$(CC) $(EXTRA_CFLAGS) -shared -o $@ $<
+	$(QUIET_LINK)$(CC) $(LDFLAGS) $(EXTRA_CFLAGS) -shared -o $@ $<
 
 ifndef NO_JVMTI
 LIBJVMTI_IN := $(OUTPUT)jvmti/jvmti-in.o
-- 
2.50.1 (Apple Git-155)

