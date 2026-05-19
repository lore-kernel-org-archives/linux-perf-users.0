Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57CB30FC2E
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 05:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779166933; cv=none; b=NiTUYC2fjQzyGJ7H6pzdLUQvEqfML8DTT7wDmMFoL+eIRIEpcts5uc7ffHBda/hcI+NxF9WZHrBjWyhVGawOJcPpihlW4siYnPMmEQWYgvlwsputmcNRAAOj3W55cSNZUVyS8LWsW5lXb1RI7IoEs8FgyX+voL1CZw0UeL0g+n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779166933; c=relaxed/simple;
	bh=Dm1dRXMcj8LHggSUomlhbdBytPSZTwFogeXZK3/CgVE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gEGnYtt78XXfkkfS2yO+JHz8+FGHsZKMAIHFZUIXtGBnAt/aVdnFDqKgSBzKj5OfEeDKtvJ9FnFk0o4O935l5UacoekK8kYIN/Kym8eIRr/D2byxq6rZxvu0aqbXX+UM7N3U0bKqhksnn58nsiyBNmmKwwR5KvhmIBsCm2GDqjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BgdugCJh; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BgdugCJh"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12dc1c0b7ccso2794777c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 22:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779166932; x=1779771732; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rpNAlzgW5SSa1ZsBC1HKHkIDD3KLaNZAgkWCJbzVU4w=;
        b=BgdugCJhpvIOA867XUU95b14UnKvWvo7prRnNNR4sO2jIxEU366vqp9ds+Sayg7u6T
         ovIKMNfaB/UU0PaqEjhahm+s8y6chsWmfr1iRJrrYOpjONAK8Xq7W02+Pobraz0z5cN5
         WXEjLUACldl1PSO9Att16jCyxLeTBoFm3XfcuhuA7spqU1b3bl6fqJkfDIJ1LAK8pccO
         glMADBToNT5LSIMISVZVpgclUB6Qd4vF8vqmM9mOyjFYU7I6V8tnDljWzyB8cpH9dSaA
         PbrgRkUeJUVuQpup6bgjzSfEgpmAixIzcBdjzQ42vKr36z4pavzU3r4EDM9RHe784RpY
         rKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779166932; x=1779771732;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rpNAlzgW5SSa1ZsBC1HKHkIDD3KLaNZAgkWCJbzVU4w=;
        b=NHyM/dIMXyRGpRVsCpGoRBeNBx67GQULkdUqAmZUOiAzp7iSeQKQQjoIgEwXadSZ46
         XjGt1cHiZX8yl6ST6e/FKqpMAgHfmKfKS+8kwni1p+xfdQlOhHK0e8EO4RJBx4CQpJ7/
         HgFLruBL2qCrCndiZRlL732dP2WKTSO5h0mrGy2KXKpRd5HmPkq0xlZEfvvJ9B4jzYnu
         0QFXpGmCSxzNZBeNQEQcNAzfp0/tlMSRBkaGGCqKWUfo/CMuWoSmiBcZpknvyZLCNY9H
         f9zYk6YOY6OkpMUXHzo7BXEczIuSVcUrpYztfukxFux5lYT0uioZOlYACGL/DeBzRevX
         +r5g==
X-Forwarded-Encrypted: i=1; AFNElJ9bQJ7CB6g6poFod9jL13k1a+/MGazYwU83CG/IaeZD/DCTLzn3LcNQf1Uj6l65HYJ5vsdX2Lce0tZwsGQE8IuZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxAV7a/W8S9/Mb6B2wb+MTNrffmOkV6s9XWocng1jsp2v2Dt1gk
	Bc2l0A7TTapARzy4hG90Lua+kVqDI5oyOT27mmfTuklKyp5fJbvzijg1mTltF3GEmw4nHn/1xXL
	b5G7iKFZUog==
X-Received: from dlbrh6.prod.google.com ([2002:a05:7022:f306:b0:12c:1f83:7b4c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6b8f:b0:135:3983:2131
 with SMTP id a92af1059eb24-135398321e5mr4565827c88.21.1779166931554; Mon, 18
 May 2026 22:02:11 -0700 (PDT)
Date: Mon, 18 May 2026 22:01:49 -0700
In-Reply-To: <20260519050150.3144907-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260519015108.3094513-1-irogers@google.com> <20260519050150.3144907-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260519050150.3144907-2-irogers@google.com>
Subject: [PATCH v3 1/2] perf stat: Propagate supported flag to follower cgroup
 BPF events
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, skanev@google.com
Content-Type: text/plain; charset="UTF-8"

When using BPF counters with cgroups, follower events (for cgroups
other than the first one) are not opened. Because they are not opened,
their `supported` flag was left as `false`.

During metric calculation, `prepare_metric` checks if the event is
supported. If it is not supported (like the follower events), it
explicitly sets the value to `NAN`, which eventually causes the metric
to be reported as `nan %`.

Fix this by propagating the `supported` flag from the "leader" events
(the ones opened for the first cgroup) to the "follower" events.

Reported-by: Svilen Kanev <skanev@google.com>
Assisted-by: Antigravity:gemini-3-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_counter_cgroup.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
index 519fee3dc3d0..dd1851634087 100644
--- a/tools/perf/util/bpf_counter_cgroup.c
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -186,6 +186,21 @@ static int bperf_load_program(struct evlist *evlist)
 		i++;
 	}
 
+	/*
+	 * Propagate supported flag from leaders to followers. Follower events
+	 * are not opened, so their supported flag remains false.
+	 */
+	{
+		struct evsel *leader;
+		int num_events = evlist->core.nr_entries / nr_cgroups;
+
+		evlist__for_each_entry(evlist, evsel) {
+			leader = evlist__find_evsel(evlist, evsel->core.idx % num_events);
+			if (leader)
+				evsel->supported = leader->supported;
+		}
+	}
+
 	/*
 	 * bperf uses BPF_PROG_TEST_RUN to get accurate reading. Check
 	 * whether the kernel support it
-- 
2.54.0.631.ge1b05301d1-goog

