Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A1122911A
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Oct 2024 14:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004095; cv=none; b=mg5fGKrYrBKTTGOO5tuZj7/wm2k0TZf9PnUvNdfXKIcB6cmxpYDqxad5PNOgDv9NcHfyjGRkimKWRl2PEj8fVCpk8CbtgZOop3wqm08K5P0NzA57aozd0rXErQ6L6INwwaCglDDX28fBBMF9+dYPrgh/K3tptFSSz7lRCsXGcME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004095; c=relaxed/simple;
	bh=X7xNxKCQNUdQcARokBvPMUfQpGmnK8/YLfygRBghiIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=smoFLOm2bv9BMGIkLl4MmQOnTUA4tBwU7Q3XFoHVgZolOwXXO3uMUllsO2AvfswMGQ/W2eFVHqR5WE3o89uFdhYycqUqAyzcwXiNdVw1OBafokDJG5mKVc491IoOjBnlk5fbBuG48lc8pu5k73kx6hivMxFg7snwotD61+NSxGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bh61NBCf; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bh61NBCf"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d518f9abcso3053568f8f.2
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Oct 2024 07:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729004092; x=1729608892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqXeLBBN6riMzdyx0YRdKT0mUVd1OzRisoF3SqIRYcs=;
        b=Bh61NBCfLG8VGxQPwvmPODkVi/iS5nsT6aWVj98Pc0OGfLiQoRnaCxlgZ0RyL1t+pq
         EZ4Q8rwYfH8r45RgreUJZU1teoqg/eb9742LDXu0e7igUCzAYNsdap7O+XhYIfxJH5Sc
         stqcirY5S8U2bMkL8TPmZXTz3iC1CbzEHeKDWygutZwlNc+xE1HEKqbircYO2fDTzRTp
         EuB1j+SnWhSDJst4q7Z73dbElGE7BnDEfzph5+qp42STfPdYs+yKgimbau8G3vqZi//8
         Op4Z/nmG8gz5HvhzOcpeDCMo09pltKkco96Wo0RRUk9tO1NVDWmyG2yTlCbnPB0nJHkw
         X8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729004092; x=1729608892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VqXeLBBN6riMzdyx0YRdKT0mUVd1OzRisoF3SqIRYcs=;
        b=SnBs6OBeOt/w3EnRRiiTP672d8QE31T7leJMs+dxTaQN6bgm11NOfmzPTrk6Euc0Fp
         LEY8QhZWxg0DeE4/NQwqSbTWWKbilQbIQfnsCCsXwxyw5Q0Q0tEIhs+CFPBL1zu8uq+G
         LAtaurIGns2CYkwezFwDgPSbRxR06Bezi6Oskvw66XbnkhpCVmZOtrXWCd2eWg2QPQso
         a8op4uXi0MKlg2Hjt1kquqIK8PVWe1VAb6x6ieEPPMlbD3V/e+XWberftgIvkGuehcZp
         KMaWAWEM2lvwedlgShxTvCSNbYKgP0QF8Kza4eu36952GV+NzU2AAXc079bda+bFPe+o
         bL2g==
X-Gm-Message-State: AOJu0Yy0wZ4YQhdKrQV+Q/VtrOv982BOklTLJMJtVxu/Br7/NRNg/8pe
	GY0aECjCqPIY1tnei8/7e+fl2jiq2OyEoDI/+udK/G9DIzSxBWbGLZGhYafC1/fVuZK8lNX1k84
	AYCo=
X-Google-Smtp-Source: AGHT+IHc+QazhHkxSzFsRqXIXs5yi6LRfCc062pWDzMOF0qgkZ8F11jX7umqpfdqQmQbUYNrSSI1dQ==
X-Received: by 2002:adf:f212:0:b0:37d:5113:cdef with SMTP id ffacd0b85a97d-37d86d5031emr479342f8f.43.1729004091687;
        Tue, 15 Oct 2024 07:54:51 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f20fd99sm20363955e9.0.2024.10.15.07.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 07:54:51 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/1] libperf: evlist: Fix --cpu argument on hybrid platform
Date: Tue, 15 Oct 2024 15:54:15 +0100
Message-Id: <20241015145416.583690-2-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015145416.583690-1-james.clark@linaro.org>
References: <20241015145416.583690-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the linked fixes: commit, specifying a CPU on hybrid platforms
results in an error because Perf tries to open an extended type event
on "any" CPU which isn't valid. Extended type events can only be opened
on CPUs that match the type.

Before (working):

  $ perf record --cpu 1 -- true
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 2.385 MB perf.data (7 samples) ]

After (not working):

  $ perf record -C 1 -- true
  WARNING: A requested CPU in '1' is not supported by PMU 'cpu_atom' (CPUs 16-27) for event 'cycles:P'
  Error:
  The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cpu_atom/cycles:P/).
  /bin/dmesg | grep -i perf may provide additional information.

(Ignore the warning message, that's expected and not particularly
relevant to this issue).

This is because perf_cpu_map__intersect() of the user specified CPU (1)
and one of the PMU's CPUs (16-27) correctly results in an empty (NULL)
CPU map. However for the purposes of opening an event, libperf converts
empty CPU maps into an any CPU (-1) which the kernel rejects.

Fix it by deleting evsels with empty CPU maps in the specific case where
user requested CPU maps are evaluated.

Fixes: 251aa040244a ("perf parse-events: Wildcard most "numeric" events")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/lib/perf/evlist.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index c6d67fc9e57e..8fae9a157a91 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -47,6 +47,13 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 		 */
 		perf_cpu_map__put(evsel->cpus);
 		evsel->cpus = perf_cpu_map__intersect(evlist->user_requested_cpus, evsel->own_cpus);
+
+		/*
+		 * Empty cpu lists would eventually get opened as "any" so remove
+		 * genuinely empty ones before they're opened in the wrong place.
+		 */
+		if (perf_cpu_map__is_empty(evsel->cpus))
+			perf_evlist__remove(evlist, evsel);
 	} else if (!evsel->own_cpus || evlist->has_user_cpus ||
 		(!evsel->requires_cpu && perf_cpu_map__has_any_cpu(evlist->user_requested_cpus))) {
 		/*
@@ -80,11 +87,11 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 
 static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel;
+	struct perf_evsel *evsel, *n;
 
 	evlist->needs_map_propagation = true;
 
-	perf_evlist__for_each_evsel(evlist, evsel)
+	list_for_each_entry_safe(evsel, n, &evlist->entries, node)
 		__perf_evlist__propagate_maps(evlist, evsel);
 }
 
-- 
2.34.1

