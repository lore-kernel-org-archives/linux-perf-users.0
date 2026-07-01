Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ABC3921E4
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 04:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782879730; cv=none; b=IyDAHvq9iRalu8vhkxaBiryK/LVma6mIdT/l3E9EBbrihL8b651y9MSwwZnSvjJql1duAn7ADH3PlZvGTV6hJQ5zX0Kky7HBs5uBfSXSuhCCQtU9f+pNCcrK+RlgYiEpBUV7eCTFCmHwou72Z0TpS7btw9vUyBqwhXSGQecM9TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782879730; c=relaxed/simple;
	bh=tAHMRsheTde10qNn58UXTjY6qjd9LfGqAk7alqAt3NI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jmvw03eyeQMXVxi61EglKNJen7ZRH7xar05NAn74PSxM9ZntHEk5i6glztcgQYUt43gHalGVLzoBvr63uPJCUaoviZAhqykMHb+n8SAmzqeURa64pa6OnWqf9YfANKRscYvXp1lHapsZ6hhHvS5IWaX93n6XhdQ8NZOmsMgYBdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TCKc/Yd3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCKc/Yd3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782879726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tguKlM9RJRsTyq+UftPcI3tMbMpuYZQGwwm0LMSHqsg=;
	b=TCKc/Yd3K/DFgeMUqq/+1wsxQ6/JGnSAcDGDMM8ZSuhYbyRV6QF9y3aVm0jYNHahROzf8j
	DGuOhieqWsGeJFVaaOwIvNpc6DvL5pEjH/UHHcgUlCO4o65VuD/EzR2I5fw1u8DtAJwzFd
	DgbbRWekMoz61KyNF5uSrYujU6E7bd0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-m5wm6BD-PAWXbbXxDSxz1g-1; Wed,
 01 Jul 2026 00:22:03 -0400
X-MC-Unique: m5wm6BD-PAWXbbXxDSxz1g-1
X-Mimecast-MFC-AGG-ID: m5wm6BD-PAWXbbXxDSxz1g_1782879721
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B6501978CAA;
	Wed,  1 Jul 2026 04:22:00 +0000 (UTC)
Received: from tallison-mac.redhat.com (unknown [10.22.65.235])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0BC091800607;
	Wed,  1 Jul 2026 04:21:56 +0000 (UTC)
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
Subject: [PATCH] perf build: Fix LTO build of libperf-jvmti.so
Date: Wed,  1 Jul 2026 00:21:45 -0400
Message-ID: <20260701042145.71595-1-tallison@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Linking libperf-jvmti.so through jvmti-in.o (ld -r) breaks LTO when
-flto is passed via LDFLAGS.  Link the JVMTI object files directly
instead, and pass any LTO flags from LDFLAGS to the JVMTI compile step

Signed-off-by: Trevor Allison <tallison@redhat.com>
---
 tools/perf/Makefile.perf | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 3f0544d37a7f..bc66d711fa39 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -686,10 +686,12 @@ ifndef NO_JVMTI
 LIBJVMTI_IN := $(OUTPUT)jvmti/jvmti-in.o
 
 $(LIBJVMTI_IN): prepare FORCE
-	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=jvmti obj=jvmti
+	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=jvmti obj=jvmti \
+		CFLAGS="$(CFLAGS) $(filter -flto% -ffat-lto-objects,$(LDFLAGS))"
 
 $(OUTPUT)$(LIBJVMTI): $(LIBJVMTI_IN)
-	$(QUIET_LINK)$(CC) $(LDFLAGS) -shared -Wl,-soname -Wl,$(LIBJVMTI) -o $@ $<
+	$(QUIET_LINK)$(CC) $(LDFLAGS) -shared -Wl,-soname -Wl,$(LIBJVMTI) -o $@ \
+		$(addprefix $(OUTPUT)jvmti/,libjvmti.o jvmti_agent.o libstring.o libctype.o)
 endif
 
 $(patsubst perf-%,%.o,$(PROGRAMS)): $(wildcard */*.h)
-- 
2.50.1 (Apple Git-155)

