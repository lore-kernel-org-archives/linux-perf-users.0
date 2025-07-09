Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFF038F9C
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Jul 2025 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752071507; cv=none; b=pYeECck3663bVo7Ihp2WRgqvMbzvMdYsogJQMGSWgiqfY1l3ZmD3uzUoXWahWcsWq+wkEbJXN3PEzFdRZ7oyyl8c9YGshfqdtR9C6+ltLJAW5J+jEHpAtsnZt5ApL/Vde3gbEYkLTZF+W4USsKWwfnAiKRH3P5x5YvmoS4T+6Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752071507; c=relaxed/simple;
	bh=63HYRtLscaJD4DpEPN8eTWuIhppVK43bbdQ/n1/bJsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FQf212GHjaK5Djwj9Jwx1QDWyFzOGG1GSehmyjQ+n2I/sbVKYY6uX7sKyD+RqJYxl/d87cCNfzP4r+mysWt9PAPOu74Mq3FQ9wNrodGor5SkowZfOOPjSGwt1YySXQFBi8anVANhudGTOot59q3FFxxw76fnU2EKoRcn0xgN1sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tdqq4HTH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tdqq4HTH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752071504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LS9jOgSQoqk857hJ81FWyzHteMoNbIFBZD+TbGH43gE=;
	b=Tdqq4HTH1tTKbDbDZCnFjPvBy42NocXrXpfRstpK0oOwqVRN9pMwpCWE1wmW92qA0tuSbj
	AToh9XeLeYsYz0z7zKZUlc4NQUIFiLn0jhny1Gekvnz46WcvGli28ujMd7o2c+SknyQlMp
	yXuYKRzBS2kChLRFL2JXLJEVhbfypB4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-kz4KeGboOHiA3BCnpltxjA-1; Wed,
 09 Jul 2025 10:31:40 -0400
X-MC-Unique: kz4KeGboOHiA3BCnpltxjA-1
X-Mimecast-MFC-AGG-ID: kz4KeGboOHiA3BCnpltxjA_1752071499
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F2931956077;
	Wed,  9 Jul 2025 14:31:38 +0000 (UTC)
Received: from ashelat-thinkpadp1gen5.boston.csb (unknown [10.22.81.233])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 098291956089;
	Wed,  9 Jul 2025 14:31:34 +0000 (UTC)
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
Subject: [PATCH] perf sched timehist: decode process names of processes in zombie state
Date: Wed,  9 Jul 2025 10:31:20 -0400
Message-ID: <20250709143119.91147-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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
 tools/perf/builtin-sched.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 26ece6e9bfd1..e1a931341bc8 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2023,11 +2023,15 @@ static int comm_width = 30;
 static char *timehist_get_commstr(struct thread *thread)
 {
 	static char str[32];
-	const char *comm = thread__comm_str(thread);
+	char *comm = (char *) thread__comm_str(thread);
+	char *empty = (char *) "";
 	pid_t tid = thread__tid(thread);
 	pid_t pid = thread__pid(thread);
 	int n;
 
+	if (*comm == ':')
+		comm = empty;
+
 	if (pid == 0)
 		n = scnprintf(str, sizeof(str), "%s", comm);
 
@@ -2147,6 +2151,8 @@ static void timehist_print_sample(struct perf_sched *sched,
 	struct thread_runtime *tr = thread__priv(thread);
 	const char *next_comm = evsel__strval(evsel, sample, "next_comm");
 	const u32 next_pid = evsel__intval(evsel, sample, "next_pid");
+	const char *prev_comm = evsel__strval(evsel, sample, "prev_comm");
+	char *comm_str = timehist_get_commstr(thread);
 	u32 max_cpus = sched->max_cpu.cpu + 1;
 	char tstr[64];
 	char nstr[30];
@@ -2173,8 +2179,15 @@ static void timehist_print_sample(struct perf_sched *sched,
 		}
 		printf(" ");
 	}
-
-	printf(" %-*s ", comm_width, timehist_get_commstr(thread));
+	
+	/* if a process is in zombie state commstr will start with a '[' and 
+	 * we need to do extra processing to decode the process name */
+	if (*comm_str == '[') {
+		printf(" %s", evsel__strval(evsel, sample, "prev_comm"));
+		printf("%-*s ", comm_width - (int) strlen(prev_comm), comm_str);
+	}
+	else
+		printf(" %-*s ", comm_width, comm_str);
 
 	if (sched->show_prio)
 		printf(" %-*s ", MAX_PRIO_STR_LEN, timehist_get_priostr(evsel, thread, sample));
-- 
2.50.0

