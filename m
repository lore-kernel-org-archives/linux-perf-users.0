Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC537187346
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 04:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783486627; cv=none; b=StlARBg+qrF35ofzToqhwl7vp14Kl1DT/ph/q9pUX4kZcyiQhy0a5vvBaCyUqhJ6vFv7/wWdN6+NpCdlZ6BxromOZ4pzzYQDeajQNdVIj0X0pSGq+wlnQK4VFdo7tnSrsCNMHk8M4ghhN8UP2PuEFfwmOAEvGb+AhZTS5X2wj4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783486627; c=relaxed/simple;
	bh=1la1gQq3azUS+keiFPeQZNQ5pH5JWzl6wT1L2+r+9Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETsHAzlWUqcf8uvZGv/rQPtj3zQKSclA/HTpxDlEsNQxa89yjBqE0ckZSRZ3MZSR9/KDSKiSID4BGHkgJ9+CUQPsDSa8BB0zbKl0HVHlAVAAjwLk39WZDhaR1d6Eoi7VrigyU8QgayV2wjDrfxK+aSpEwFviUMSn831rsH6IZnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZGxx+z+B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGxx+z+B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783486620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QJTmhgVkCyWAv1NwJ+JHa69nEk0s70kKPRoNOeh0izk=;
	b=ZGxx+z+BvGh1Yj2LEAawrKBahq210aOTGyrFvw5uNxzGio3YEycpyqL+Dcfl0WHITHJZcd
	Q5fHktr40cKWEUF1gFFS75zFJRvj8/xzJwWi1PrgcLRQh6TjuLcdrYhKsVuLDL4+l3o369
	RyeyweubsPeaGn2RTHWLq+ebM7SRaJM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-8_bGM3nWMsi6yVqUjJ_RPA-1; Wed,
 08 Jul 2026 00:56:55 -0400
X-MC-Unique: 8_bGM3nWMsi6yVqUjJ_RPA-1
X-Mimecast-MFC-AGG-ID: 8_bGM3nWMsi6yVqUjJ_RPA_1783486614
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 123D01955F44;
	Wed,  8 Jul 2026 04:56:54 +0000 (UTC)
Received: from tallison-mac.redhat.com (unknown [10.22.81.130])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3243E1800664;
	Wed,  8 Jul 2026 04:56:52 +0000 (UTC)
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
	tallison@redhat.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] perf build: Apply EXTRA_CXXFLAGS to C++ builds
Date: Wed,  8 Jul 2026 00:56:05 -0400
Message-ID: <20260708045606.43649-3-tallison@redhat.com>
In-Reply-To: <20260708045606.43649-1-tallison@redhat.com>
References: <20260708045606.43649-1-tallison@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

C++ sources did not receive EXTRA_CXXFLAGS or EXTRA_CFLAGS, unlike C
sources. Initialize CXXFLAGS from both so C++ objects such as
demangle-cxx.o get the same builder flags as the rest of perf.

Signed-off-by: Trevor Allison <tallison@redhat.com>
---
 tools/perf/Makefile.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 0ba307e78fe1..052a6cc7942f 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -17,6 +17,7 @@ detected     = $(shell echo "$(1)=y"       >> $(OUTPUT).config-detected)
 detected_var = $(shell echo "$(1)=$($(1))" >> $(OUTPUT).config-detected)
 
 CFLAGS := $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
+CXXFLAGS := $(EXTRA_CXXFLAGS) $(EXTRA_CFLAGS)
 HOSTCFLAGS := $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
 
 # This is required because the kernel is built with this and some of the code
-- 
2.50.1 (Apple Git-155)

