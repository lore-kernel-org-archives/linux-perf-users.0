Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3781F4702
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Oct 2024 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728571793; cv=none; b=acL3RV4lpeIP2o7jNHA613xy50JDp0dvLVwrAwnaKdYmdF39YPJ5GmnPvsZtoe6bELbl6WlEPwmd3MHtcTu3XFUQ8xZUW2OTTt2l6TAHPNONWxCD82Qk/mYm6KLE8Gafi8r1G1aVuCRYLzLOquGQYtS47B/Ls4jrQCvhbMWIq7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728571793; c=relaxed/simple;
	bh=M72KeCWqdjEiTNyedo0Yf4ZW2quaDFbTJrXi+008Z7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HRXYmqINjOTjIz+wLtdNY1MmyqHOaDG8NR6deOmMTXU5XcGg5Vddcp9OKiadqMJrK30kJ2IeOB2mHsI7t56ZlbMjvBJ4QLt5HOuL0N5RdpEbNXc6O/nZ9CpGC2fj5L5fKxu9uAGfbM+nzSAy39R8Qwi8GAkEJ7f8BmUrYedaZxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SKxLt3YH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKxLt3YH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728571790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VUv3nF2wT2H61K4JZC79JDTIETuUqKRQzK7FGJfeVFg=;
	b=SKxLt3YH0iGMYC7xqxhMgouWkBDFlaqyVT5q++pw/8SQHv1GaVwWM9WYLXIBcisOrPRisG
	lOyJu/irMNUKet4krDihF6EC3v8BT5St+pdhWTGIF0b8wu0ffuhijkJ3TksC8agC9vt0oU
	MbWwGIVfVC4NYauEvTPkVPeYbpV2xOE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-ZmQ-TY8EOGetYr7VNDIpUw-1; Thu,
 10 Oct 2024 10:49:44 -0400
X-MC-Unique: ZmQ-TY8EOGetYr7VNDIpUw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0D751955F40;
	Thu, 10 Oct 2024 14:49:41 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.16])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EAE501956089;
	Thu, 10 Oct 2024 14:49:36 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com
Cc: mpetlan@redhat.com,
	peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	irogers@google.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Subject: [PATCH] perf dso: Fix symtab_type for kmod compression
Date: Thu, 10 Oct 2024 16:48:36 +0200
Message-ID: <20241010144836.16424-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Veronika Molnarova <vmolnaro@redhat.com>

During the rework of the dso structure in patch ee756ef7491eafd an
increment was forgotten for the symtab_type in case the data for
the kernel module are compressed. This affects the probing of the
kernel modules, which fails if the data are not already cached.

Increment the value of the symtab_type to its compressed variant so the
data could be recovered successfully.

Fixes: ee756ef7491eafd7 ("perf dso: Add reference count checking and accessor functions")
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
---
 tools/perf/util/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index fad227b625d155c5..4f0ac998b0ccfd7a 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1343,7 +1343,7 @@ static int maps__set_module_path(struct maps *maps, const char *path, struct kmo
 	 * we need to update the symtab_type if needed.
 	 */
 	if (m->comp && is_kmod_dso(dso)) {
-		dso__set_symtab_type(dso, dso__symtab_type(dso));
+		dso__set_symtab_type(dso, dso__symtab_type(dso)+1);
 		dso__set_comp(dso, m->comp);
 	}
 	map__put(map);
-- 
2.43.0

