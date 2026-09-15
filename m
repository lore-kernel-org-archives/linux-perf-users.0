Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A104E47DFA8
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 22:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789510289; cv=none; b=NyK2B5DOgAl738qOgG5Q3OgYbj9+Lc67pPcMHEwAIssgaqtB8XgCm1xbt1zA9S4qofPsjdlr7ikUkYq66kIj1OW6pR4AvZqUKYWxxfZy6yrOacjZLmeQn8Vx4MU7I12Z/CB9rjbtFHDPASUGfxJKJjGvSWfoE2/OyvWCZS+t7W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789510289; c=relaxed/simple;
	bh=04WHeDiv7VQDGToqWY5HeEAmeoW5ObIa3ErisKveB+Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sn9w51noa5FJm+mn4ex08+r2nCpiNCdDY71xDzwTedkd5oHnFtTYvwktsiq7Zft0bhwVoQy8mKiIccZqNEUp2LxBxehaiZAoFuGpsuKBTPaEP08qsH7hz50NeUwl04Zy5OkDGdupMBq99F0Sq5jC4TF+5TGn0O2b6SR01IsCxxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kax0sfh2; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kax0sfh2"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-398dcfabbf8so12145560a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 15:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789510287; x=1790115087; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EVabf+9Y5bXC/MU0a60DkiNIQl5cnoXXNA9vsJfBEas=;
        b=kax0sfh2L8kPopqUG/P1WYKLj/T84LtPxeSEfr7xsHaqnlvLQICHziqvM2x7apZy9L
         5k8h8lry+ECuMOfKJLFlwKXQz/qS6jgyhHNFjhiRpLG1QnLPcAMTvozbbaGNy7sj/yAm
         HqJOAKnhycDeAecfB2aPMq8LtzgzuWhjW3CoVmFA0yy9zveSK4ilnd2+bqHYquy12Y+K
         +jBecKIAWLJqr5GFBfMLH8KzGMaoDTU6ywVxpoVrPhlofOZz7sBoiINV+lWPTPwWXy8c
         reF600GlgBV4ail0dJHA9gfZTD0NpIGr8n9H5W5HlxxcZbP6IKn7lI5jxjeIrvCwKfEH
         oXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789510287; x=1790115087;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EVabf+9Y5bXC/MU0a60DkiNIQl5cnoXXNA9vsJfBEas=;
        b=GXixD4sTXnkEY7MOHBh1cJgJt1o53KhkRHkAraEIwGOIhVg2OEzHD3kIsvjIsJWGq4
         6SzcaJ8RYycg4+RQ12W3mw5/vukzWD5tkCwBczvMeh/SttRkhMrV5rYz51tUM5Qt+Kwp
         99y2OPbUn6fUJYqHZS3XEJ1vrIkKzzQgnh4ouhqBEGQooqsFMfUMVKak2tDFVSx65u3R
         klKvL/qeXnsO1NMckrsD9l94T7pOjrvTMZwRusjI5Hm3ZksHgpfgCZBrrQA/NG5PdPU+
         zz7HI1k9YY1z/7n48/ChWlGr0Fw5/+ndtdVVBxcvjydUPeF63BblBIHIvep1XsYr2UmK
         783A==
X-Forwarded-Encrypted: i=1; AKwUvBwU24YTTwv9c5EHqyoU2thm+aIbn+2L/eZdDq+Cgv4tduM6uG1xPqSt/Ue9tFrNge9TKG+h3q/qZXsBIT1Nub3w@vger.kernel.org
X-Gm-Message-State: AFuF++nY60rv4M0xHDGahw3gufd/QFX0x/pxc+adYObKBul5gAbD3wco
	FbkjzLtaqIr2kmJoo7xNCoxRxMNu4KAJ8iEqa7Q2wf1OFMhwHfR84lLZxx6GgqesrymM7+WUp8k
	+YM06GzqWmQ==
X-Received: from dybcy29.prod.google.com ([2002:a05:7300:b71d:b0:32b:ed90:9177])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a51:b0:39e:14db:437c
 with SMTP id 98e67ed59e1d1-39e1e27a33amr569603a91.4.1789510286870; Tue, 15
 Sep 2026 15:11:26 -0700 (PDT)
Date: Tue, 15 Sep 2026 15:11:22 -0700
In-Reply-To: <20250922091736.2798-1-liujing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250922091736.2798-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260915221122.2174928-1-irogers@google.com>
Subject: [PATCH] perf bench messaging: Fix the formatting issue when printing.
From: Ian Rogers <irogers@google.com>
To: peterz@infradead.org
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	liujing <liujing@cmss.chinamobile.com>
Content-Type: text/plain; charset="UTF-8"

From: liujing <liujing@cmss.chinamobile.com>

The unsigned int type should use the %u format specifier when
printing with printf or related functions.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>
Reviewed-by: Ian Rogeres <irogers@google.com>
---
 tools/perf/bench/sched-messaging.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
index 4fb6657fc826..c5c9a7a1d7db 100644
--- a/tools/perf/bench/sched-messaging.c
+++ b/tools/perf/bench/sched-messaging.c
@@ -338,9 +338,9 @@ int bench_sched_messaging(int argc, const char **argv)
 
 	switch (bench_format) {
 	case BENCH_FORMAT_DEFAULT:
-		printf("# %d sender and receiver %s per group\n",
+		printf("# %u sender and receiver %s per group\n",
 		       num_fds, thread_mode ? "threads" : "processes");
-		printf("# %d groups == %d %s run\n\n",
+		printf("# %u groups == %u %s run\n\n",
 		       num_groups, num_groups * 2 * num_fds,
 		       thread_mode ? "threads" : "processes");
 		printf(" %14s: %lu.%03lu [sec]\n", "Total time",
-- 
2.55.0.1032.g73a4cd73de-goog

