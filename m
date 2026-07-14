Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CD0417BF8
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054044; cv=none; b=OoRRRqD1sh04oI5VlFPmIOL3OQinjnf6ybi7xmQlO3Y4BILTUgoIg3IohaYN9w5XmzWfRqeo0U5FUeBvQogAkxOzBENySe6IWqa0Snz5+B0q6+26LKy4xRXvatGg9OYPbe6uE+Y2YFm0KSEF5jqTkhuIZ2kKZkmA3kpBuJIGg/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054044; c=relaxed/simple;
	bh=3kWygXnKCpjuIn/qC6W/3zq25IIgInfjEvKuW8zdE90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmzLBcKvlnG4T3o9Wokv7LmdBSTKkZehIWfTHO6bOw1Rzw7HGntPszWzaFHQji8wrxJT1z1A/7EUvoVVjpokegipp5A9st+Z+0doIwEdnJRVoTl0IptXpg8V5E2bE4RFAxGh3Iq1lY1JQc8sQ7DDhp+BdiJSD5/e8Lsx1UPiXhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U+qDy5W2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U+qDy5W2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784054041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=epfFDK7uRA/mihPB8RJRezIjGoE7O366kYFSAw99Blg=;
	b=U+qDy5W2XhANaiyWgzhf5EPZ8FvXs3IuYnnLOzXadKJc9nU0/iTXbOQp2n/u9a9QfkqW6G
	9unJqMrBmdJKSOqLOolBthjy8DgYE6OGTlEEqe3mr8LkG2qrMVNOkh1VKW/ecBhYx+ztkM
	TQ7vrRScGGe+Dlxvjom3v5AiGKspLrU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-6M3x0_UdNJ6G_pnt2cthBA-1; Tue,
 14 Jul 2026 14:32:35 -0400
X-MC-Unique: 6M3x0_UdNJ6G_pnt2cthBA-1
X-Mimecast-MFC-AGG-ID: 6M3x0_UdNJ6G_pnt2cthBA_1784053953
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 08B3D1800EF3;
	Tue, 14 Jul 2026 18:32:33 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.22.65.227])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 488DF1800348;
	Tue, 14 Jul 2026 18:32:30 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: mpetlan@redhat.com,
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
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v5 4/5] perf evsel: don't set PERF_SAMPLE_IP for unprivileged tracepoints
Date: Tue, 14 Jul 2026 14:31:44 -0400
Message-ID: <20260714183150.292861-6-ashelat@redhat.com>
In-Reply-To: <20260714183150.292861-2-ashelat@redhat.com>
References: <20260714183150.292861-2-ashelat@redhat.com>
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
offset.

Make an exception for uprobes, which are registered as
PERF_TYPE_TRACEPOINT, because the IP is important for their
functionality and is a safe userspace address. Detect them with
__probe_ip (entry) and __probe_ret_ip (return) using evsel__field().

Assisted-by: CLAUDE:claude-opus-4 Apogee
Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 tools/perf/util/evsel.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ea9fa04429f0..1d85e5503cf3 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1571,7 +1571,19 @@ void evsel__config(struct evsel *evsel, const struct record_opts *opts,
 	attr->write_backward = opts->overwrite ? 1 : 0;
 	attr->read_format   = PERF_FORMAT_LOST;
 
-	evsel__set_sample_bit(evsel, IP);
+	/*
+	 * Don't set PERF_SAMPLE_IP for unprivileged kernel tracepoints to
+	 * avoid exposing kernel addresses. Uprobes expose only userspace
+	 * addresses so they're safe. Detect both entry and return uprobes.
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

