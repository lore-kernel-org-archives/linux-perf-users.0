Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8440919755B
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Jul 2025 20:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752698451; cv=none; b=WqlvpzsP6mL9z+t7PZ3AcUfvsJmMZdWD6RfO8mC4El6Wca/7fBEExnPkm0Q3mbZvzYj4LM86QX4qDgFLZSSO49ERLT4zZDKF2/Y3TFIaQ2qlu20lJpFg+bEXCJxHGn0TZu79/fOss7eg3n+g2e7hbv9XDoO0kYqdXaX68jg8ME0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752698451; c=relaxed/simple;
	bh=cY6mNY0Qw+BdVyNQxGomDjMMCKeUN3yOLKjN5MENE8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JKXPjfUf0HELw6hmp7VU46MRN/3BkOsfgLu4t2R8i/Mxprig+jzKkvxg7L/SR27xKG3SEj4rPwx7rwNulml0A7LfMb02Etvo0aDt8ibIheYKX+U1zmUui/zjoKYvQGEtwgtUckfb7fqV8EJteqsigv/jrggsW5UIc3g2J/bhp7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h4jguwZB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4jguwZB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752698448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=miVEQf9YDEMYj8NkPoQJpFXbk1W+mPGjQBu/0HneoVI=;
	b=h4jguwZBJfs8xKM3D2SwSneVXc6wqTk9YyNQu0ZhwRz31EfjVKEieVL3p9Vejyt9qS5BOG
	LECVNMtScD1dfknrRKdpp4g0bo+vOYKWGdKszKd4vf0/FbVmjoCubECe37llTuq93WF4Es
	S1yCwIfBuoto2v6vFQUz/VExls4wGOc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-J5GxsO8MPMy2JmoYIESAUA-1; Wed,
 16 Jul 2025 16:40:45 -0400
X-MC-Unique: J5GxsO8MPMy2JmoYIESAUA-1
X-Mimecast-MFC-AGG-ID: J5GxsO8MPMy2JmoYIESAUA_1752698443
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 729D6195608C;
	Wed, 16 Jul 2025 20:40:36 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.22.89.86])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F0FC19560AB;
	Wed, 16 Jul 2025 20:40:32 +0000 (UTC)
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
Subject: [PATCH v2] perf sched timehist: decode process names of processes in zombie state
Date: Wed, 16 Jul 2025 16:39:15 -0400
Message-ID: <20250716203914.45772-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Previously when running perf trace timehist --state, when recording
processes in the zombie state the process name would not be decoded
properly and appears with just the PID:

1140057.412177 [0006]  Mutter Input Th[3139/3104]          0.956      0.019      0.041      S
1140057.412222 [0012]  :1248612[1248612]                   0.000      0.000      0.332      Z
1140057.412275 [0004]  <idle>                              0.052      0.052      0.953      I
1140057.412284 [0008]  <idle>                              0.070      0.070      0.932      I
1140057.412333 [0004]  KMS thread[3126/3104]               0.953      0.112      0.058      S

Now some extra processing has been added to decode the process name:

1140057.412177 [0006]  Mutter Input Th[3139/3104]          0.956      0.019      0.041      S
1140057.412222 [0012]  sleep[1248612]                      0.000      0.000      0.332      Z
1140057.412275 [0004]  <idle>                              0.052      0.052      0.953      I
1140057.412284 [0008]  <idle>                              0.070      0.070      0.932      I
1140057.412333 [0004]  KMS thread[3126/3104]               0.953      0.112      0.058      S

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 tools/perf/builtin-sched.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 26ece6e9bfd1..76e8b3fda02e 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2174,6 +2174,11 @@ static void timehist_print_sample(struct perf_sched *sched,
 		printf(" ");
 	}
 
+	if (!thread__comm_set(thread)) {
+                const char *prev_comm = evsel__strval(evsel, sample, "prev_comm");
+                thread__set_comm(thread, prev_comm, sample->time);
+        }
+
 	printf(" %-*s ", comm_width, timehist_get_commstr(thread));
 
 	if (sched->show_prio)
-- 
2.50.1

