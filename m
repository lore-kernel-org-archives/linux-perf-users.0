Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF50015E5DC
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 19:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874127; cv=none; b=QLrtkQa4nQNyYbJ/sm1U3SbJ3JGCebaRaTiInYzCeiYcvWzOshQFfbNTjieMroD+bJGfj4EM8Zx4dUA0vzgTQMUD53eEhU3j5Y0XZ3nX9+QdApGVgS2cr5j89VgjoT4Tm3os8ffOXmzcn5xpNAbDJnQn4RcT38Q4QVCqy3PeNTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874127; c=relaxed/simple;
	bh=Ulq4Me1sfWuuHA3AMTGfQmfiOXh1ef+JNR2f7IkNv/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F6OyMBQF2aLD3NV8VmDFsi0yI3GKyn+m+SSlSuIgVHkUPBDAxQPBsdyLHOJ4SPfIU9Sr0lAt6hJmBAvtx9jcieIoKvS9cqzpGcsNQc+ZHqN+2mWopPV6rFupDMYTf1nGGz11MT5HB0Bv6H0sb9n7PzOMTNK778IcWcf9lxYEO0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y2Ut2LGz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2Ut2LGz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778874125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=smZehZ4R4GekK+a7uEBnX02LbnOGqDpqzyo4HnU8/6g=;
	b=Y2Ut2LGzGme+x21tq8+f0F38mcjMRB+9S/e2tsSSuS31CY2WwPHDgMPQngwdqFmRF15yrG
	doqkNcNLvWNFORmdZZUNYEDdnf6WZYqbwtCgAZVfQGS59A2clDLLal9biW/Mqqu0F0yUub
	ihONk7xm+ZCQXljHXYngotg3cJsb2SA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-fCsQ77UPM7C_HAiQEoXW7w-1; Fri,
 15 May 2026 15:42:00 -0400
X-MC-Unique: fCsQ77UPM7C_HAiQEoXW7w-1
X-Mimecast-MFC-AGG-ID: fCsQ77UPM7C_HAiQEoXW7w_1778874118
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B2DD18005B6;
	Fri, 15 May 2026 19:41:58 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.22.80.109])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17B5B1956053;
	Fri, 15 May 2026 19:41:54 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: mpetlan@redhat.com,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Falcon <thomas.falcon@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v4 1/3] perf evsel: don't set PERF_SAMPLE_IP for unprivileged tracepoints
Date: Fri, 15 May 2026 15:40:05 -0400
Message-ID: <20260515194010.93725-3-ashelat@redhat.com>
In-Reply-To: <20260515194010.93725-2-ashelat@redhat.com>
References: <20260515194010.93725-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

For tracepoint events the IP is a static kernel address.
It doesn't vary by sample and provides no useful information for
unprivileged users. Skipping setting PERF_SAMPLE_IP for unprivileged
tracepoints avoids exposing a kernel address that reveals the KASLR base
offset.

Make an exception for uprobes, which are registered as
PERF_TYPE_TRACEPOINT, because the IP is important for their
functionality and is a safe userspace address. Detect them with
__probe_ip (entry) and __probe_ret_ip (return) using evsel__field().

Assisted-by: Claude:claude-sonnet-4.5
Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 tools/perf/util/evsel.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2ee87fd84d3e..bf66e0c78451 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1509,7 +1509,19 @@ void evsel__config(struct evsel *evsel, const struct record_opts *opts,
 	attr->write_backward = opts->overwrite ? 1 : 0;
 	attr->read_format   = PERF_FORMAT_LOST;
 
-	evsel__set_sample_bit(evsel, IP);
+	/*
+	 * Don't set PERF_SAMPLE_IP for unprivileged kernel tracepoints to
+	 * avoid exposing kernel addresses. Uprobes expose only userspace
+	 * addresses so they're safe. Detect entry and return uprobes.
+	 */
+	if (attr->type != PERF_TYPE_TRACEPOINT || perf_event_paranoid_check(1)
+#ifdef HAVE_LIBTRACEEVENT
+	    || evsel__field(evsel, "__probe_ip")
+	    || evsel__field(evsel, "__probe_ret_ip")
+#endif
+	    )
+		evsel__set_sample_bit(evsel, IP);
+
 	evsel__set_sample_bit(evsel, TID);
 
 	if (evsel->sample_read) {
-- 
2.54.0

