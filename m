Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793120686;
	b=WSxx4pUd8Zz62eBqBQ2NjJgh4ikXoL7D5NdK3Piu3v6dJXcdTcKZXnsPwB7m7P7loHjY
	 nBvtNtQ1LcmslppN1jpvwA3vECUsw9zVRYCm3VQqmBGnWgLkY+4ytPWL6ixoPeCLNtkuy
	 dO3Jt9V1ifBzfrsz0O4QYDODikf/3dHHGptBqKD88q+gaRmcTzjAyWShJ1JQrQf+3u667
	 6u0cAHpkaLF22EnkWa3rttIe/C9fJmEmE+6zYcc8kwzsgz0LMK9v/H28SWnCaXx+KzRAo
	 zPwCxY9PaTkMU4yz+WDr/qqBJdKRQiJWsQihjmdMifg2wY/XdElxBJYjZxOpJOVcj2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793120686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:
	 Content-Type;
	bh=gVjE4i5YYyffthwilIi3npAsOinE/ZGxF9+4UzDwIXg=;
	b=HMePjkyOLKBJJdSQSo41qeSqwuXJtygTMNwGvAjI3UGzZVJ1VqRjsV8EAVQvTgFX5EeS
	 lhR5IkMMD/YNbbBlftJAwgdZsNAaoNF25CqGvgxO0JsQjYHOwsZKMougab951SDSG6PfR
	 eHmNER8GcQBO7uwVTuO2hD0itZVgbFedW6sB/dm2EQUWr5HAeIcm1Q8BmhTmf5N5bX0gm
	 VP8ezcY09pAvXi2vqd6FNuiV3bWZA/XxkhTmkCnBxTJrWgcsbCtWoVf/OhNySkSX4ihkA
	 jy+t6IzeMD7HdBXYY0kzP4nUDxSZyYPCi/tsHMwzIZ3eEzrZUZMBw+48+zV2EMsse8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EKrTcaq2;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CF3606A32C
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 17:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2CF3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EKrTcaq2
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36637676140so82366eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 10:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793120685; x=1793725485; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gVjE4i5YYyffthwilIi3npAsOinE/ZGxF9+4UzDwIXg=;
        b=EKrTcaq28AutmoPVrFeFdFT8GGrC9QjC1LaaCOXtXDtFTfzFlISdkEBZUTM3NcKbxU
         tyfiEXUgg7j09oOujTnALEMDrXdnRYODsTUZlYmQibPfjh7ER+boITLBbiqzJ+hhlja7
         DQ4MAEkdQObrtkqNWZSN7Wfot5IFBxJiIlChUa6Qm6qGJ1y0O84oztF3BwrvY0zhGllg
         bTO5VWzC9h0y7J9EWlSgmPiXq1pbHOrce+Uzbr0Ra0qvDG2Bk9KJGaC+xwZ8oy4eXdIy
         n5YwPvxpC4F1lFfZhCM8YN6KPISKIiDEWrNq4D76yOY6fIOO5t41r9znDPdvHZt4NOHV
         0gzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793120685; x=1793725485;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gVjE4i5YYyffthwilIi3npAsOinE/ZGxF9+4UzDwIXg=;
        b=EdvnQPWzLDVFsTr6NYAzPvjVCJHkiY56qfFGahHL/bQtSVTHk17WC/hfYUwmnybdgP
         +LJlqDCgSxRk4GVYNB8ySxuJh78ZhNdoEeBxhs06rs+12leqSOiyLGnnqb8/pjbtMVXV
         oNP6VWIEXs0EB2EawHM3UPQGVvsYUsWLaZde7ZycFJiuo5RkH+4Qr9olYzPYTP1ZyjsL
         zz080xnHxinfJS9G7oAByn3lngb4POPRNrmrDeVu78U8k1EdRI4N0U9ALF0f/7um6FGM
         FmbiZh3XLMkMafui+H88KPAWRLUhBMJQ9jXLD2qth7ME54ETb8i/wldxaYqWJvS1uLts
         Tp7w==
X-Forwarded-Encrypted: i=1; AKwUvBz81ybJLI44h2IWQrPZaUzkNu77ljbJvJffkcLbARzo4I+S1gd8n+exjBlcEqM/964ntq1qQZ/DEu85NJsXc1J2@vger.kernel.org
X-Gm-Message-State: AFq9FYICN24KmEKHa1I9S4RMKQEuanb0ZBXBYSeNpEa6bbMlzlSDn9YJ
	jKERD9OLxe73bq1UxlbI6JaeGnuy8SyL7wvrc5RZkSmzRNDLAIQKVLGobpMq2+haD1t8xRtCoQ+
	HV2qExtHxTg==
X-Received: from dyw21.prod.google.com ([2002:a05:7300:8815:b0:353:7c23:55e8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:c3a4:b0:358:8f02:e0ca
 with SMTP id 5a478bee46e88-36a2007fef6mr122722eec.9.1793120684505; Tue, 27
 Oct 2026 10:04:44 -0700 (PDT)
Date: Tue, 27 Oct 2026 10:04:15 -0700
In-Reply-To: <20261027170415.2815859-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027170415.2815859-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027170415.2815859-4-irogers@google.com>
Subject: [PATCH v1 4/4] libperf evlist: Recompute CPU map when an evsel goes
 system wide
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Ankur Arora <ankur.a.arora@oracle.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

perf_evlist__go_system_wide() marks the evsel as system wide and then
propagates the evlist's maps to it. __perf_evlist__propagate_maps()
only assigns the PMU CPUs to evsel->cpus if the map is empty, but an
evsel added after the evlist's maps were created already has the user
requested CPUs propagated (e.g. the "any CPU" map of -1 in per-thread
or workload mode). Going system wide then leaves the evsel opened on
the wrong CPUs.

Drop the existing CPU map before propagating so the evsel is given all
of its PMU's CPUs, as is expected for a system wide event.

Fixes: 811082e4b668 ("perf parse-events: Support user CPUs mixed with threads/processes")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evlist.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index c1c5b0684eed..46de69aa5a86 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -835,7 +835,10 @@ void perf_evlist__go_system_wide(struct perf_evlist *evlist, struct perf_evsel *
 {
 	if (!evsel->system_wide) {
 		evsel->system_wide = true;
-		if (evlist->needs_map_propagation)
+		if (evlist->needs_map_propagation) {
+			perf_cpu_map__put(evsel->cpus);
+			evsel->cpus = NULL;
 			__perf_evlist__propagate_maps(evlist, evsel);
+		}
 	}
 }
-- 
2.56.0.313.g2479322e68-goog

