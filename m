Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFF942669D
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775049963; cv=none; b=iLG2MkSFYyEHg6chm+mo7rXmuppRZgq0WTyQSoLtd00sOKIadjGEFMohHmC0h3lsfDapwjiSYpX1XDjxS06ss7zGA0VQQyZaeJC3zfqp8LlJGoyAL8xbcuSpswF/CsdmrnqhVeineHBptgAzavtlopKM5eroAugGZx8ij+Nc7T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775049963; c=relaxed/simple;
	bh=S54Ur7xGaPcCaMFNaVUxQSyGAlIf3cbAGmZWuElRWP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cWV1Kyg8jtPUbJfgtgg9h3L1VZYr3wKLG2EU9t6xTdoSmmR7iH5P3QVbkOOSkqImD/N9dhuKbTePB16MNGz9UdSz+Lwo35LtPRaRotvUMOL8q0n1H42TvMOi2AlKhplZpaJtjDjWMesWfyLiwyaJFCMm7n5mR4/MvS69lD2dkso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=boDA3TPA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="boDA3TPA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775049961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2aBuHTlA6uRx8M4jeiB+YqjeH/F8q4zxjlSiVW2evoc=;
	b=boDA3TPAJxIThX/FqgOeQ2bd905U7XHRvH/ihrKAywIp/3Pn+FYPrwYFZ9xq4QDSF01I9U
	tspWrcZ4jZta+mCkD7FA7TG1FjYJF8j5MkgFrD7foozicln4nOZSpZ2ALl2xMGC1qF2MJ8
	iJetRGHZZxVu5Qo9gVQ6perafP8W4nE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-tmi8_O7nN42JJCY3tddnwA-1; Wed,
 01 Apr 2026 09:25:58 -0400
X-MC-Unique: tmi8_O7nN42JJCY3tddnwA-1
X-Mimecast-MFC-AGG-ID: tmi8_O7nN42JJCY3tddnwA_1775049954
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C1E719560B7;
	Wed,  1 Apr 2026 13:25:53 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.22.88.218])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0CD81955F2E;
	Wed,  1 Apr 2026 13:25:48 +0000 (UTC)
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
Subject: [PATCH] perf dso: prevent null dsos from being added
Date: Wed,  1 Apr 2026 09:24:43 -0400
Message-ID: <20260401132442.505507-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

When sorting the dso array we sometimes get a crash due to null
comparisons in comparator functions. So prevent __dsos__add from
adding null to the dso array to avoid out-of-memory related errors.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 tools/perf/util/dsos.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 0a7645c7fae7..5cf8c878bab2 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -196,6 +196,9 @@ static struct dso *__dsos__find_by_longname_id(struct dsos *dsos,
 
 int __dsos__add(struct dsos *dsos, struct dso *dso)
 {
+	if (!dso)
+		return -EINVAL;
+
 	if (dsos->cnt == dsos->allocated) {
 		unsigned int to_allocate = 2;
 		struct dso **temp;
-- 
2.52.0

