Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F7D314D33
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Nov 2025 11:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764070899; cv=none; b=sckWJJKj+zoQDpmJHAYudLvXxVnG4r15xZ2UJMz6pv2RkwzLEx5jBir+mBdOGMhCaZxIl+8abwSkyYCDY5pHfQLpLE3+CsXDtG/2mSOtEjdgxopR3csHuSd892NcLytj9fx1tYXUu6vjyqp33d/qFDbVCAOikskd9S+WbRPlRAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764070899; c=relaxed/simple;
	bh=vQwz+T4VAoAmqzp4oNXyTb+6OY+BnVs4XmvUEAcSCSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ToTQnCTmQwJ/N1YXsku3A26ucGCx82+W5+8YBAjm6yZ0MuaiRoB0dLuvKzEgeZ5oCnoJ3UXRt9OfqGvlpD4FC5S6Y769KxMxaKElDjaxGIlhrEXgZbK+HezvYFYhcvHLLP/92VEY2BW2vL/8wSJmc0/U4lw8NHHP3d4gZeeB8n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ADeyy26F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADeyy26F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764070896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=03YVDbHkMHuWppeSfqswH7G7loDUJv9EN0qjFPHNNeM=;
	b=ADeyy26FHsdLTAQEum0hWvat21OR38SlicwghrOdbSGehwYMnmb2X1t/TRPh1T+yYVDTPH
	e1LK71ihVvYAoOrZch8m4iXxzqsjn4dwn9TsNRtaf2wC/pLLQOguwdY8KhlW+IZ4ShjUuC
	rxq74laBzG56DrWK++mHKwzWGQghegg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-ZHUBSH_YNgyz2uHC7aZuDw-1; Tue,
 25 Nov 2025 06:41:32 -0500
X-MC-Unique: ZHUBSH_YNgyz2uHC7aZuDw-1
X-Mimecast-MFC-AGG-ID: ZHUBSH_YNgyz2uHC7aZuDw_1764070890
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB8C01800447;
	Tue, 25 Nov 2025 11:41:29 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.42.28.227])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4B7318004A3;
	Tue, 25 Nov 2025 11:41:24 +0000 (UTC)
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
Subject: [PATCH] perf pmu: fix duplicate conditional statement
Date: Tue, 25 Nov 2025 11:41:18 +0000
Message-ID: <20251125114118.196089-1-ashelat@redhat.com>
In-Reply-To: <20251114220547.496562-2-irogers@google.com>
References: <20251114220547.496562-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Remove duplicate check for PERF_PMU_TYPE_DRM_END in perf_pmu__kind.

Fixes cedf1f4852ae.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 tools/perf/util/pmu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index cfcaba3e2e75..723a67cb41f4 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -331,8 +331,6 @@ static inline enum pmu_kind perf_pmu__kind(const struct perf_pmu *pmu)
 		return PERF_PMU_KIND_PE;
 	if (type <= PERF_PMU_TYPE_DRM_END)
 		return PERF_PMU_KIND_DRM;
-	if (type <= PERF_PMU_TYPE_DRM_END)
-		return PERF_PMU_KIND_DRM;
 	if (type <= PERF_PMU_TYPE_HWMON_END)
 		return PERF_PMU_KIND_HWMON;
 	if (type == PERF_PMU_TYPE_TOOL)
-- 
2.51.1

