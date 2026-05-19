Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E7628469F
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 22:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779230343; cv=none; b=MVL2bx0he9aEHEyTsMVdtaiV+pE8hKAGrbI5oTpMRtBnPKogXpE96Wz8kRPWK08pdAHvzvHLLGKrryPxZqLkVQQrtPrqtBy8E20quwnFiaLjOAfn345Q+Cg08KdPYDN3MsaR4vHaQv3eHViGNlqBvDgyl5fgYu7kt4PBoy1uriE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779230343; c=relaxed/simple;
	bh=22hnvoEgaDzfu5zO8dqsclmLgsjl810W4o0lzM3bF9U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qBVxLv7tYyhH6NirU7UMWLY1E2qO+YKrAPhLG0UbsvA1sEfVKNQg0H/1vJHeb4g6ZlwwAuG0l0LV5vpmaktqzhXjqJB4g5NP4rLQGjgYCRxA6iMfX+4J0FRhnjDdvuvrSqYsGT3+GSsv6tNj6va4QvIinDbvKb4g1lnt7zein2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EUGLZ60U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EUGLZ60U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779230340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=khAMKhL1QzWKrtRf9XhRGRfSSq515GRKlb+ESP3gNq4=;
	b=EUGLZ60U2T5KUuH/4KgfyRLMIc4B9B9xYDdUl1yYrp46xyeMpJ+0I/X0zoWDcQ8PVVGtRq
	GnE02K2stPa/Rsh+xkSsh+RD728qm+MzWiyLmA1IWmYlwwr42Z+2tRtN1HIFN3Z1Mlcn5Q
	02ZMzjwo4aGe+H9jUW8cBclOPcfmyvQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-843DHw_pPHi-nC_EcXEoFw-1; Tue,
 19 May 2026 18:38:59 -0400
X-MC-Unique: 843DHw_pPHi-nC_EcXEoFw-1
X-Mimecast-MFC-AGG-ID: 843DHw_pPHi-nC_EcXEoFw_1779230338
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C5C21956096;
	Tue, 19 May 2026 22:38:58 +0000 (UTC)
Received: from Carbon.redhat.com (unknown [10.44.24.2])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E09AA1687;
	Tue, 19 May 2026 22:38:56 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	namhyung@kernel.org
Subject: [PATCH] perf build-id: Fix off-by-one bug when printing kernel/module build-id
Date: Wed, 20 May 2026 00:38:55 +0200
Message-ID: <20260519223855.191637-1-mpetlan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

When changing sprintf functions to snprintf, one byte got lost. Since
snprintf ones do not handle the '\0' terminating character, the number
of printed characters is 40, while sizeof(sbuild_id) is 41, including
the terminating '\0' character. This makes the later check fail so that
nothing is printed.

Fix that.

Before:
    [Michael@Carbon ~]$ perf buildid-list -k
    [Michael@Carbon ~]$

After:
    [Michael@Carbon ~]$ perf buildid-list -k
    a527806324d543c4bc3ff2f9c9519d494fed5f68
    [Michael@Carbon ~]$

Fixes: fccaaf6fbbc5 ("perf build-id: Change sprintf functions to snprintf")

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/builtin-buildid-list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
index a91bbb34ac94..e0881b0ac38f 100644
--- a/tools/perf/builtin-buildid-list.c
+++ b/tools/perf/builtin-buildid-list.c
@@ -61,7 +61,7 @@ static int sysfs__fprintf_build_id(FILE *fp)
 	int ret;
 
 	ret = sysfs__snprintf_build_id("/", sbuild_id, sizeof(sbuild_id));
-	if (ret != sizeof(sbuild_id))
+	if (ret + 1 != sizeof(sbuild_id))
 		return ret < 0 ? ret : -EINVAL;
 
 	return fprintf(fp, "%s\n", sbuild_id);
@@ -73,7 +73,7 @@ static int filename__fprintf_build_id(const char *name, FILE *fp)
 	int ret;
 
 	ret = filename__snprintf_build_id(name, sbuild_id, sizeof(sbuild_id));
-	if (ret != sizeof(sbuild_id))
+	if (ret + 1 != sizeof(sbuild_id))
 		return ret < 0 ? ret : -EINVAL;
 
 	return fprintf(fp, "%s\n", sbuild_id);
-- 
2.47.3

