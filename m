Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F106113790B
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Apr 2026 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775141488; cv=none; b=UE7SfAFwdgwvcJEDUIf0ICgFSgCx/uEp84GvOMn2XAefnZXkVi7GmUZkcqXPsSD2FZrgiebNNeFC1sZWRIyKdWhqyXJhmLTWTuOldHwVIJjCTXyb3Y2asnXCjIEQnTXjmP3Tb4TxwxQRW4wv0V7Eg4x2XHBN30QPPWZvHZNGO/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775141488; c=relaxed/simple;
	bh=dPiRupAAsB+47PnMZyZc8UQYiFCGbIdywri2EGdgH3w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YkI8wa/00B+oOpB/UI1x9TMxGbPflGn31OGb/fEMivrqoWvly9ogyxdKOzSQcZp7LSaHVyaq6t/loNUx/SAb/PVSjxcVo+UxStDUg+Ebirq6/4tYpe2OvVu4fT9s7pDMIa/dmDwC3MpiSU96fsx/kNMKIn4G4KtWz4+1UDurBdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b1Yery15; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b1Yery15"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775141485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VJxTXZZgHS3KNGdR9ycOE5Q1JZarToSEJbSB60v1zoU=;
	b=b1Yery15ciMK68ee6eTZi2vnkKe7gbxSEhhxGoAm1AeaSkxpFCsj2aLBehqXvquHomwb2g
	8UTGVxTgNCE+FCMKjlZdjIZOLeMZyrQ6sq763kfmaEPePf5idofSZgwsYShxWdnFJBpMdM
	Eh16j3+f1eOJ8iuixtWYJqWWUKNtm5Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-j8-iL6CQNDq2a9n2ulxtdQ-1; Thu,
 02 Apr 2026 10:51:22 -0400
X-MC-Unique: j8-iL6CQNDq2a9n2ulxtdQ-1
X-Mimecast-MFC-AGG-ID: j8-iL6CQNDq2a9n2ulxtdQ_1775141481
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BAE301956046;
	Thu,  2 Apr 2026 14:51:21 +0000 (UTC)
Received: from Carbon.redhat.com (unknown [10.44.24.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0009919373D8;
	Thu,  2 Apr 2026 14:51:19 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	acme@redhat.com,
	namhyung@kernel.org
Subject: [PATCH v2] perf trace: Fix potential u64 underflow in duration calculation
Date: Thu,  2 Apr 2026 16:51:18 +0200
Message-ID: <20260402145118.1379546-1-mpetlan@redhat.com>
In-Reply-To: <20260331101020.1270363-1-mpetlan@redhat.com>
References: <20260331101020.1270363-1-mpetlan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Although it happens very rarely, in case of out-of-order events (i.e.
due to CPU migration when a syscall is executed), the calculation of
event duration might underflow and thus a bogus value is printed:

    2.804 ( 0.001 ms): :49553/49553 rt_sigaction(sig: QUIT, act: 0x7fff403ed6e0, oact: 0x7fff403ed780, sigsetsize: 8) = 0
    2.807 ( 0.001 ms): :49553/49553 rt_sigaction(sig: CHLD, act: 0x7fff403ed6e0, oact: 0x7fff403ed780, sigsetsize: 8) = 0
    2.815 (18446744073709.438 ms): :49553/49553 execve(filename: 0xbb173a30, argv: 0x55aabb171930, envp: 0x55aabb171120) = 0
    2.815 ( 0.534 ms): pwd/49553  ... [continued]: execve())                                           = 0

Check for possible underflow first and in case of a bogus value, do
not print it.

v2: Use greater-or-equal to handle "zero" duration calls correctly.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f487fbaa0ad6..9c59969de2af 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2956,7 +2956,7 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 		++trace->stats.vfs_getname;
 	}
 
-	if (ttrace->entry_time) {
+	if (ttrace->entry_time && sample->time >= ttrace->entry_time) {
 		duration = sample->time - ttrace->entry_time;
 		if (trace__filter_duration(trace, duration))
 			goto out;
-- 
2.47.3

