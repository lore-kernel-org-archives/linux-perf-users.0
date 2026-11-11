Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794395181;
	b=t+U9u6jdJ6O+HvZPvhl6AdNqT2KK4RgPcY5PPgTVHz9seqMZYYkEP42xDoNMNncxYuZn
	 lpEWrY8MqJZ3vjefg+93PIkdEHa90fCgkrFxugYPtWb0NROtQndmJFXAOcurTPkLx3/Sd
	 BABJpqCoXuzNK+esH56nLtZAk2Pd2pd2Cl3hNtKok/c4SD7yl0ezF6wmDbs+d64kJpOsM
	 ZpW/RVx69PWpNwHvzEJ8qRTIiTnz8PU+kDE2N+IXa8cgCxi/JQWLK59JGSKJo2JskuS4c
	 UKV4LQGajaoMxBaZWsjiAh29D4NBA+kzcUr4GrPEBM+/CVJg/D8gB6Jm9wQO1ZI2+fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Rz5XATv4ChRAq+veF11y3ZXTbQQ72xxD/k7Itg2J/PQ=;
	b=kM9iK00Ymuvw+4nM01I0m60w6mrBWaLBA0JTU0zoEoxp7U4rXbe9rA7df7+XsxXaWeuR
	 u2K9wZy5hksjH7hHl6QMaBEO6z+XDNpKziLG55fVXzzId91IiEbi9c6PIF+2tmPMK6At8
	 7sAixkIWv17VO+iVEe3LkLWpipE1hR+lnIcnrks3iA75NRRBu81mkRgFuH6EWMXFeGNLl
	 maLwbS3X480S7PrReVEZYqPkKipgxeUzmdqXQNUXyCU5a1xjbJYQFZIsbRcvOq1gicZNi
	 9mVtykestdMUkHj/2h+c74InTCGEwhdkJZYWW6tqChjc2+xN/hBt92cr/4+nQNqZ16g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nUuMJSq1;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE07606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 11:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EE07606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nUuMJSq1
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1b3acec6677so4709871c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 03:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794395180; x=1794999980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rz5XATv4ChRAq+veF11y3ZXTbQQ72xxD/k7Itg2J/PQ=;
        b=nUuMJSq1RkoMVmyH5IXe05PU61LuKNLDdkfRF8q/i+TpueNlD10ZC+P/LCVYcZIbdG
         7x0YjH0cAuFhXxJHYg+2JE7GR+3zM//CfFaGQ3rRa0E2xfrccnJg+QD8nZZer8X7nHFc
         aeEL4LsVC3IWe2qfbF78pK0MCFHXX89UugfL7m5xTnVC24eGxH8Ip1U/osufbI/lPmMT
         AG10wGj4U/50XSNNUeRcD00rt+IEPAEAriT1IkA69gI++U1XDmFbnxuUTjmeAwV2AYNo
         mhBbe9aVbyOB/yTDXM+Y7rqMpHj6BXgnyd5TB9Zmkg2SVQfddlNtCnvenKg/cuvxKx0v
         awVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395180; x=1794999980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rz5XATv4ChRAq+veF11y3ZXTbQQ72xxD/k7Itg2J/PQ=;
        b=CjtoJ6nFMbJ5vHObDV74PjZYa4GFPnFTmIxDVtHBlQE9e1C9hdk2hqEaYLLNPITXBj
         tvdRliVx6AVkkWNKjn1t7J0nSQabLaAAHxMyrvtfgdHREmh+ajrFqpEvMv3BU6xme7Bq
         0t1ghIPD9rfhN9oyIONV10cmSjnioRPlzpptawS0IhjAoMpU7Qt5iYqCT8YrYnQBqJ3t
         D7GYxSDZFtKiwKgMzO3CWGxfquWSD1zs4VKsnDeeqavDC7G5/xXWfNIThAc2+B43lTUb
         ZC49nEchMrQPzVVRR8uBcIVUeyVXFWfB/9M432JWVBkGW+JzodpHrqeblQ+DTwnJRyCU
         1kxQ==
X-Gm-Message-State: APuU4Z9oe6uhCvgADfZKnQXiK0B3n/cdoc+KOWV9IZf1AUPLpYWI/DId
	yCPDv4jWRK3R0Vrj0flkVoZPdYjUr4Gat4mWlv65M1KKWoTurUoKCUMPQ6/ofMLm
X-Gm-Gg: AYBFou3HBhdax0f8pPSA86d+ArhNDX7JzI4lNNyzp8fkO0VAvA2L6KDaSFKZnUoGuyV
	CCBDFWczi3CbyA0/aDo8i8jr1678Clgz8LWXM0+FwObbebfoewF1tNmb2DNGaGJHAIj5J2IllfE
	E7Fi/UL/ncvTJhc833vZ/rxpBCzvoSR0A+fB81jZHbGMH4ljh5sVJ4Q6AgDf2uWjf2cQmddNwTG
	H5UcwWafIbNwUWoWC+zH4rZRSqLnU+7he88OqaKIdzmQzzS8auLwBfdUD8Mi7tc2i/V30bCB0oC
	M+p5hi43vfFYBLx1F6NR+1ZTXoTT7l4uuJhw6zR397eqELjob5++BK0y/HjbIOoWBulQ7nLZzwk
	vT27+JGhbsktSKkAclCC/+qGW9/t3x74kjYaqEYx6ShGSIoInu3xEGIp+Zs39wYmBiX5NOu9wyQ
	VHM9xW818aACW+N4PCqTsIYDdLd48XpSzC3EG9UP/jn+MFOhAwjJnZi0QW+SBoMUZF9ziaI9sw+
	pn3N/NK7NBzBxXdbUPs9udq3hLZTmH24OIJl+nIzDJyjoXI2eCKuLUYrZMHGO72oF+WAfZzlJN0
	aEQx7j2TfSpx1njMuAae
X-Received: by 2002:a05:701b:4590:10b0:1a4:c892:b14f with SMTP id a92af1059eb24-1b3c033909cmr2110912c88.29.1794395179359;
        Wed, 11 Nov 2026 03:06:19 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11346sm17328735c88.7.2026.11.11.03.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 03:06:18 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Hang Zhengyang <hang.zhengyang1010@gmail.com>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v3] perf stat: Count kernel events in a group led by a tool event
Date: Wed, 11 Nov 2026 11:06:16 +0000
Message-ID: <20261111110616.2249764-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111-tool-pmu-leader-v2-1-3faa0fb98c51@gmail.com>
References: <20261111-tool-pmu-leader-v2-1-3faa0fb98c51@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hang Zhengyang <hang.zhengyang1010@gmail.com>

A tool event like user_time has no perf event in the kernel, but
get_group_fd() still passes its fd, the /proc/stat fd, as the group_fd
of the members.  The kernel rejects each member with EBADF and nothing
is counted:

  $ perf stat -a -e '{user_time,cycles,instructions}' -- sleep 0.05
                   0      user_time
     <not supported>      cycles
     <not supported>      instructions

Open the members with group_fd = -1, as the enable/disable code already
assumes, and read them on their own: the leader is not asked for counts
of events that are not in its kernel group.  A kernel event member is
opened disabled, as a leader is, so that it starts with the workload
and still honours -D and --control.  A tool event member is left as it
is: it counts from open and an explicit disable is what stops it, so
disabling it here would leave nobody to start it when perf relies on
enable_on_exec.

  $ perf stat -a -e '{user_time,cycles,instructions}' -- sleep 0.05
                   0      user_time
            38257394      cycles
            21228043      instructions

The kernel events in such a group are no longer scheduled together,
which is the price of counting them at all.  A tool event used as a
member, as in '{cycles,user_time}', is still not counted; that also
needs the leader's group read to be handled and is left for a
follow-up.

Fixes: 6828d6929b76 ("perf evsel: Refactor tool events")
Written with LLM assistants: the group_fd change and its testing by
Hang Zhengyang with Claude, the v3 condition and its measurement by
TAKANO Mitsuhiro with Hermes Agent.  perf was built here and
'perf test -v 10' passes with and without the change.
Signed-off-by: Hang Zhengyang <hang.zhengyang1010@gmail.com>
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
v3: open only the kernel event members disabled.  A tool event member
    counts from open and an explicit disable is what stops it, so
    opening it disabled left nobody to start it when perf relies on
    enable_on_exec: 'perf stat -e "{user_time,system_time}" -- sleep
    0.2' went from ~2.7 ms of system_time to 0 on an arm64 KVM guest.
    The non-standard Assisted-by tag is replaced by a prose
    disclosure, and the patch is regenerated on 7.4-rc2.

    The libperf fix that stops the NULL dereference is a separate
    patch (<20261111101625.2204836-1-takano32@gmail.com>); this one
    does not depend on it.

 tools/perf/builtin-stat.c | 16 ++++++++++++----
 tools/perf/util/evsel.c   |  8 ++++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 37752d6bfef4..57956f55ea09 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -719,9 +719,10 @@ static int create_perf_stat_counter(struct evsel *evsel,
 	/*
 	 * The event is part of non trivial group, let's enable
 	 * the group read (for leader) and ID retrieval for all
-	 * members.
+	 * members.  Members of a tool event leader are opened and
+	 * read on their own.
 	 */
-	if (leader->core.nr_members > 1)
+	if (leader->core.nr_members > 1 && !evsel__is_tool(leader))
 		attr->read_format |= PERF_FORMAT_ID|PERF_FORMAT_GROUP;
 
 	attr->inherit = !config->no_inherit && list_empty(&evsel->bpf_counter_list);
@@ -748,9 +749,16 @@ static int create_perf_stat_counter(struct evsel *evsel,
 	/*
 	 * Disabling all counters initially, they will be enabled
 	 * either manually by us or by kernel via enable_on_exec
-	 * set later.
+	 * set later.  A kernel event that a tool event leader has as
+	 * a member is not in the kernel's group either, so it has to
+	 * be opened disabled to start together with the workload.
+	 * A tool event member counts from open and is only stopped by
+	 * an explicit disable, so leaving it enabled here keeps its
+	 * count; disabling it would leave nobody to start it when
+	 * perf relies on enable_on_exec.
 	 */
-	if (evsel__is_group_leader(evsel)) {
+	if (evsel__is_group_leader(evsel) ||
+	    (evsel__is_tool(leader) && !evsel__is_tool(evsel))) {
 		attr->disabled = 1;
 
 		if (target__enable_on_exec(&target))
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d060fca8090f..7f514cde6840 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2370,6 +2370,14 @@ static int get_group_fd(struct evsel *evsel, int cpu_map_idx, int thread)
 	if (!evsel->supported || evsel__is_group_leader(evsel))
 		return -1;
 
+	/*
+	 * A tool event leader has no perf event to group with, so open
+	 * the member on its own, or report the group as broken (-2) if
+	 * the leader failed to open.
+	 */
+	if (evsel__is_tool(leader))
+		return leader->supported ? -1 : -2;
+
 	/*
 	 * Leader must be already processed/open,
 	 * if not it's a bug.

base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.53.0

