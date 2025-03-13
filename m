Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0442433D9
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Mar 2025 05:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741842677; cv=none; b=QEOUX6tR+LziokQGz911WoKUbkSLKcA5lko6HPK7GZZv/Qpq130aOp83Ej2zZope+Wt8uU2cRwsOXb0Puy15W1GnWeRKRBpeAdGOVLid+pE11NVuziwCoYL8SfJd3KujHOgMawjyMCmIcyhG+eUknv3z8lXmhc4lo/qAsaiN/ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741842677; c=relaxed/simple;
	bh=EcHuY3LKcEdZKoMQ5Sbrlj1yijfOPy99NAo0/AAnzQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Twy7PjcHa2QBxMosGAYXV4sf5nU5FOQ6jvg1Ntftl+cvnSyEDj9UPEyFnKwFB/y9t1SpdKgimpJXylaJgwfccZe/BSXmNzSGSLoQDNcOCkwVjgwTfO3MHvfQfpFWSVeQfWYl4ycaVT+Fc7TZ1rrcH0a8xBOFeEfVEpvTVDb9324=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NsBpngif; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NsBpngif"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741842671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2TXkO3ovGkx1URC0tljx+3Ih2z31JNctDg3fQBN9EHg=;
	b=NsBpngifCL61bVxBpNE8atNq+vqWdB52QS60MeaL9WzjodDjhs50L8c263r/DGXBeZ38zW
	V4G1UH6MEPljpWjTwQtfFaguh7EwpDyy2PjZ2HeCnp6oHjLzi3yRTX7GpKt1p+cru+jDV+
	aJ0WcTj+g46bsGB3esVdfDesWizg69Q=
From: Tao Chen <chen.dylane@linux.dev>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH linux-next] perf/ring_buffer: Add EPOLLRDNORM flag for poll
Date: Thu, 13 Mar 2025 13:10:47 +0800
Message-Id: <20250313051047.2436098-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The poll man page says POLLRDNORM is equivalent to POLLIN,
so add EPOLLRDNORM here.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/events/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 59a52b1a1..5130b119d 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -19,7 +19,7 @@
 
 static void perf_output_wakeup(struct perf_output_handle *handle)
 {
-	atomic_set(&handle->rb->poll, EPOLLIN);
+	atomic_set(&handle->rb->poll, EPOLLIN | EPOLLRDNORM);
 
 	handle->event->pending_wakeup = 1;
 
-- 
2.43.0

