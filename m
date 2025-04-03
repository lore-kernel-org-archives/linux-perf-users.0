Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A832475C8
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Apr 2025 16:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743696301; cv=none; b=VlYfbigtygZOzSdtkP3F7a94igUgtAiXdXuN7Hay0dPTvHhFe3iEHR865VxT9HZvwEO6eTozbaPFMfHjpz7mcdPIP+J0Pd3K4PBzvc9mkuKY5CKhY5N86hwBXScbNz8gLB9d3IqwTYyMkOjvbwpkGjHEkVcUnPlFWwyz1toZkoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743696301; c=relaxed/simple;
	bh=ayGeI1vgcM2JUZtOOCcTmsydqi0ZDi/vaxuzC7Jnfg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oisw8OKporzaD7piY5D5iOecooJyru/Vwq6hWFOExH7JATN6Yc5le38j6pMpWkvQzyKjCH8ilUWIDmlbEvyq6oukaW3d9tubwV7WVkvQF3D3Rm9BpBU4mnuPGH2iZqjUa2WcQFgdHUBBdFrLtm+Ib5YhjNMRXddiHBycNNOkg/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TyzoZ9kF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TyzoZ9kF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743696298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7S1aRbEbJ/LqncEWKq79Hm3vAzySaW6ujzc1LbWde3U=;
	b=TyzoZ9kFzZUehwGcE87pRbX6UI2PHtwiGWQqTbGZJPpuhvc377seRm1OsvZfN460kI+f4a
	EY21TQfFEG/mt8/9QoykqwAvvCDUrNfxZ91D7xh3gQ1UmyGQMZq2AvHdqOWLaiX2f+eF87
	W3RBgRsffCLp9fMybIoWFzRBkNUTzaA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-SgeXaPdcPwap-geM_CtyrQ-1; Thu,
 03 Apr 2025 12:04:54 -0400
X-MC-Unique: SgeXaPdcPwap-geM_CtyrQ-1
X-Mimecast-MFC-AGG-ID: SgeXaPdcPwap-geM_CtyrQ_1743696289
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A93FA195608A;
	Thu,  3 Apr 2025 16:04:48 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.22.64.76])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5829E1955BC2;
	Thu,  3 Apr 2025 16:04:44 +0000 (UTC)
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
Subject: [PATCH] perf trace: always print return value for syscalls with set errpid
Date: Thu,  3 Apr 2025 12:04:12 -0400
Message-ID: <20250403160411.159238-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Currently some syscalls that have errpid set to true do not print a
return value in perf trace. The syscalls that were consistently
observed were set_robust_list and rseq. This is because perf cannot find
their child process. This change ensures that the return value is always
printed.

Before:
     0.256 ( 0.001 ms): set_robust_list(head: 0x7f09c77dba20, len: 24)                        =
     0.259 ( 0.001 ms): rseq(rseq: 0x7f09c77dc0e0, rseq_len: 32, sig: 1392848979)             =
After:
     0.270 ( 0.002 ms): set_robust_list(head: 0x7f0bb14a6a20, len: 24)                        = 0
     0.273 ( 0.002 ms): rseq(rseq: 0x7f0bb14a70e0, rseq_len: 32, sig: 1392848979)             = 0

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6ac51925ea42..c192f0219b2b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3005,8 +3005,8 @@ errno_print: {
 	else if (sc->fmt->errpid) {
 		struct thread *child = machine__find_thread(trace->host, ret, ret);
 
+		fprintf(trace->output, "%ld", ret);
 		if (child != NULL) {
-			fprintf(trace->output, "%ld", ret);
 			if (thread__comm_set(child))
 				fprintf(trace->output, " (%s)", thread__comm_str(child));
 			thread__put(child);
-- 
2.48.1

