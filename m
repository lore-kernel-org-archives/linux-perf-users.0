Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B0D30BF4F
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 15:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957509; cv=none; b=lcttuC3mSWrUlRdcnpaCdYjAzt2hA3j6oAVb2TyQBLObwYQFruIw01mGePEKF/N+D3FHLSeHR+mCJFwAOZdl6nyNqYbit7rGNROPtAUk1bcXYJnZS9vx6thaHlJZvbZ1w7BMnE2qM6TdBltpBt0ZfecHOAQlU88vigwHzpuPb4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957509; c=relaxed/simple;
	bh=ma0OE6jc72wX99S3EDlOnhT41J21hCR55F44rTDbdMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eIYwE8CsPVra83Ai7pVNw9jXdyxVJK6sVBBAP7wl6eGGnVMI/wKpVP2KNT7kW6757kwLrmplC9shW7PRupQWFhhLE1c3gwpAI/9F+9q3yf7JW3jWPHIjHi0O48VMeEUx0tGk5Bqnr2EFBPICI4RpqgpmExXrCZx0gy+sjahbKOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WoICO06Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WoICO06Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776957507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tfrr+HWsFGxr25q1lEOOcrWGfevT4jtMVgKE83pLNF0=;
	b=WoICO06ZSzMSdCryj7F9qnU/jYYsiG82UZwx79pWd9VX9JByu2KsZeydk7AgpoYkH4fllv
	jwSFx6lcGN+6Z0VNQQlsJJAWOjp2my+HuHwtdGkauMZOIg7EmWd/qhScM5HQF47ylc/vJx
	yME82MxugoJUqXSv/EAUSV4IjIIE/9w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-S-W2rFYJM32ZYdtYw1BbUQ-1; Thu,
 23 Apr 2026 11:18:21 -0400
X-MC-Unique: S-W2rFYJM32ZYdtYw1BbUQ-1
X-Mimecast-MFC-AGG-ID: S-W2rFYJM32ZYdtYw1BbUQ_1776957499
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B44618003FC;
	Thu, 23 Apr 2026 15:18:18 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.74.80.103])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 465391800348;
	Thu, 23 Apr 2026 15:18:09 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v3 1/3] perf evsel: don't set PERF_SAMPLE_IP for unprivileged tracepoints
Date: Thu, 23 Apr 2026 11:17:44 -0400
Message-ID: <20260423151746.16258-2-ashelat@redhat.com>
In-Reply-To: <20260423151746.16258-1-ashelat@redhat.com>
References: <20260423151746.16258-1-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

For tracepoint events the IP is a static kernel address.
It doesn't vary by sample and provides no useful information for
unprivileged users. Skipping setting PERF_SAMPLE_IP for unprivileged
tracepoints avoids exposing a kernel address that reveals the KASLR base
offset and slightly reduces sample record size.

Assisted-by: Claude:claude-sonnet-4.5
Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 tools/perf/util/evsel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f59228c1a39e..a1091d937ff9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1503,7 +1503,9 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	attr->write_backward = opts->overwrite ? 1 : 0;
 	attr->read_format   = PERF_FORMAT_LOST;
 
-	evsel__set_sample_bit(evsel, IP);
+	if (attr->type != PERF_TYPE_TRACEPOINT || perf_event_paranoid_check(1))
+		evsel__set_sample_bit(evsel, IP);
+
 	evsel__set_sample_bit(evsel, TID);
 
 	if (evsel->sample_read) {
-- 
2.53.0

