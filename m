Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213640;
	b=PDH1b3J/DpU/mc6QCTF9w0WALcgtYY52SsfUcdJJMmoI2fxDJCHl1Scsi+cILEIkN6KM
	 he2hgLaBtAy0kmd1Rk2KqJ2Gndb3hKzBgGLShVgu54ZfvAPsFWcig0RZQWFMkhUJMs8o0
	 4TceN5x9dBkztyiPeNqj/Ng+bu03MGaWZ7dbB3Vrb+CMppgzFqRqXQLi7ENfG8W8fExzA
	 S1IGOLkQbKC12jMwE8hV1uTlACzIlu573YeN7MXptZdWABAHdJ8x3hdLcya/xxhONhDbZ
	 Rd1UNQxZjGeia8/YtCU/kQxhB2GDOKyy4sd48lU3zFj05gNnarNze3wh+ZxH4tfmGGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=DhRVWbT6TcadzJqDGHH7XP3gxHS8pIibm5/i/AQztRw=;
	b=bHbeqtdNzaICuqLCKf60jBuZ3HASdDAoOy5/cL+DB2wKj/x6LCbiP+Cy+Q5Q8fyogtHl
	 6Oy2ecumkLybtThuAqkIJq+s2wmJb8IWciCAZh4Spoh0HZkjzX2MO0pucQHsuLfFsNyCX
	 M8WmQZwmzGSOOk5FZtUvuGvrosfHMzPUhYhcFSNr/jBjPeDS8iQx8t+2swsKNhLTBHHMZ
	 aFyrnxSX0FAdeuOHsUVq+EonbS+eewXFPre9ekV1RXkWg8Zv+UvjYhRxQORN9Fy3UYIWD
	 VzC7O6BL8XAsP1mVy/5OvUZbvO/25xcGDHb5PiU0OzVw8LyPbVEcimaoirfiNFaDaNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eLVXITf3;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E58F606A6A9
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E58F606A6A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eLVXITf3
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1af203073e0so1533495c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 14:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795213636; x=1795818436; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DhRVWbT6TcadzJqDGHH7XP3gxHS8pIibm5/i/AQztRw=;
        b=eLVXITf3jlGz8aHd4ajrEE9upSvTnqaC3jzDf1rQSxF/BXK/luwLKUpTCcGT7TPXSY
         OPIgQndTe9CIFn0VcC/gbFu9UGHFnYVJqqwHikYT82zmOVI9uzgVQAluo//0iDrlwE5Y
         udmswSPDdhVTtxWxN2E2T7ugGzv+GJmuVxCwW3DTr4w5GIIcw1jvJTEQ2KXVGSoFG7FT
         jfkqwcymQ5ZseiToCdAPAWuDgLSTVP1p+MR0+X1gqIxxg+JLxgUXSdWr7Ny+MYpwy1Tc
         vsoq1ZkSenjCDyAZG4O5aQ4+X1zweVI7uWaPwDNnwVg2dkNcSLHZdSIDB8odKPzY5NOD
         Lb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795213636; x=1795818436;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DhRVWbT6TcadzJqDGHH7XP3gxHS8pIibm5/i/AQztRw=;
        b=eJGpislTI9qfKd0dbi8XwmbsNf+wdm2KGOkaPMPRUBWL75mPOkdUhhcjjW66jkBQtv
         90tAf2dFkbVj6F78uJ0rujIVEAt6qCx5xqfnP96gihsERbY3JJPrGIG/ryvvxrlv5Oxd
         X56GhbE/nhaRZxWhQCBAlVtopZLyrkb0ZxsJef5yahpPsdGWZnruKFV9tDOspPYZbjv9
         AftZk+IwVeoiaG/tFBdtVGj4Ay5M7Ri+fJBXEcDXSSXd1+WhUUpDOJjjpTyNF7Y8abLg
         YIMqWqYyf5P85R5IbBuxbJvt9fzIWbcRLKCPsF3gh3t9GdIs6j7Iq1kqKlpafRB/ycXe
         UQFw==
X-Gm-Message-State: APuU4Z+cZkP13PRJJX7T0ab3oWo4dcz4OOv+W40jrTS7Jf13KC9+NbTE
	XNUXGyFhebIvrdNoXDcnu7tMS4Syzta20GYsfNcfL6Fz5JJ/NSVQTXT29TQWTFHK3uL6U57wvVD
	o9/sgPgnDYw==
X-Received: from dlbur23.prod.google.com ([2002:a05:7022:ea57:b0:1a2:e6ba:5856])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2815:b0:1b5:2746:8cee
 with SMTP id a92af1059eb24-1b5568c342dmr4025938c88.18.1795213635250; Fri, 20
 Nov 2026 14:27:15 -0800 (PST)
Date: Fri, 20 Nov 2026 14:26:11 -0800
In-Reply-To: <20261120222615.2291168-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261120222615.2291168-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120222615.2291168-13-irogers@google.com>
Subject: [PATCH v3 12/16] perf pmu: Probe user-space mmap capabilities
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Extend perf_pmu__probe() with probe_mmap_caps() to inspect the
perf_event_mmap_page of an opened event on the PMU.

Record whether user-space counter reading (rdpmc on x86, mrs on arm64
with format/rdpmc=1) is available in sysfs/sysctl and enabled in
cap_user_rdpmc, verify whether executing a self-read via
perf_mmap__read_self() produces non-zero advancing counts
(rdpmc_works), and record pmc_width and cap_user_time /
cap_user_time_zero / cap_user_time_short support.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 111 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.h |  25 ++++++++++
 2 files changed, 136 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 2e099e97ba03..0a7bb0a215f0 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -3836,6 +3836,114 @@ static bool probe_format_pack(const struct perf_pmu *pmu, struct perf_event_attr
 	return true;
 }
 
+/*
+ * Probe user-space perf_event_mmap_page capabilities, including user-space
+ * counter reading (rdpmc/mrs/csrr), counter bit-width, and user time fields.
+ */
+static void probe_mmap_caps(struct perf_pmu *pmu,
+			    const struct perf_event_attr *base_attr,
+			    pid_t pid, int cpu, unsigned long flags)
+{
+	struct perf_event_attr attr = *base_attr;
+	struct perf_event_mmap_page *pc;
+	long page_sz = sysconf(_SC_PAGESIZE);
+	bool has_rdpmc_cap = false;
+	int events_fd;
+	int fd = -1;
+
+	pmu->probed.rdpmc_sysfs = -1;
+
+	if (page_sz <= 0)
+		page_sz = 4096;
+
+	events_fd = perf_pmu__event_source_devices_fd();
+	if (events_fd >= 0) {
+		int pmu_dirfd = openat(events_fd, pmu->name, O_DIRECTORY | O_RDONLY | O_CLOEXEC);
+
+		if (pmu_dirfd >= 0) {
+			if (faccessat(pmu_dirfd, "rdpmc", F_OK, 0) == 0) {
+				int rfd;
+
+				has_rdpmc_cap = true;
+				rfd = openat(pmu_dirfd, "rdpmc", O_RDONLY | O_CLOEXEC);
+				if (rfd >= 0) {
+					char rbuf[16];
+					ssize_t n = read(rfd, rbuf, sizeof(rbuf) - 1);
+
+					if (n > 0) {
+						rbuf[n] = '\0';
+						pmu->probed.rdpmc_sysfs = atoi(rbuf);
+					}
+					close(rfd);
+				}
+			}
+			close(pmu_dirfd);
+		}
+		close(events_fd);
+	}
+
+	attr.disabled = 0;
+
+	/*
+	 * Architectures such as arm64 and RISC-V control user-space counter
+	 * reading for core PMUs with a sysctl rather than a sysfs rdpmc file.
+	 */
+	if (pmu->is_core && pmu->probed.rdpmc_sysfs < 0) {
+		int uval;
+
+		if (sysctl__read_int("kernel/perf_user_access", &uval) == 0) {
+			has_rdpmc_cap = true;
+			pmu->probed.rdpmc_sysfs = uval;
+		}
+	}
+
+	/*
+	 * On architectures such as arm64, user-space counter reading must be
+	 * explicitly requested via format/rdpmc (e.g. config1:1).
+	 */
+	if (perf_pmu__has_format(pmu, "rdpmc")) {
+		struct perf_event_attr r_attr = attr;
+
+		has_rdpmc_cap = true;
+		if (probe_format_pack(pmu, &r_attr, "rdpmc", 1))
+			fd = sys_perf_event_open(&r_attr, 0, -1, -1, flags);
+	}
+
+	if (fd < 0 && !pmu->is_uncore)
+		fd = sys_perf_event_open(&attr, 0, -1, -1, flags);
+	if (fd < 0)
+		fd = sys_perf_event_open(&attr, pid, cpu, -1, flags);
+
+	if (fd >= 0) {
+		pc = mmap(NULL, page_sz, PROT_READ, MAP_SHARED, fd, 0);
+		if (pc != MAP_FAILED) {
+			if (has_rdpmc_cap || pc->cap_user_rdpmc) {
+				pmu->probed.rdpmc_available = true;
+				pmu->probed.pmc_width = pc->pmc_width;
+			}
+			if (pc->cap_user_rdpmc && pc->index != 0) {
+				struct perf_mmap map = { .base = pc };
+				struct perf_counts_values start = { .val = 0 };
+				struct perf_counts_values end = { .val = 0 };
+
+				pmu->probed.can_user_rdpmc = true;
+				if (perf_mmap__read_self(&map, &start) == 0) {
+					for (int spin = 0; spin < 10000; spin++)
+						barrier();
+					if (perf_mmap__read_self(&map, &end) == 0 &&
+					    end.val > start.val)
+						pmu->probed.rdpmc_works = true;
+				}
+			}
+			pmu->probed.can_user_time = !!pc->cap_user_time;
+			pmu->probed.can_user_time_zero = !!pc->cap_user_time_zero;
+			pmu->probed.can_user_time_short = !!pc->cap_user_time_short;
+			munmap(pc, page_sz);
+		}
+		close(fd);
+	}
+}
+
 static void __perf_pmu__probe(struct perf_pmu *pmu, int pmu_cpu)
 {
 	struct probe_candidates cands = { .nr = 0 };
@@ -4390,6 +4498,9 @@ static void __perf_pmu__probe(struct perf_pmu *pmu, int pmu_cpu)
 		}
 	}
 
+	/* 5b. User-space mmap capabilities (rdpmc, user_time, pmc_width) */
+	probe_mmap_caps(pmu, &base_attr, pid, cpu, flags);
+
 	/* 5c. Auto-counter reload (acr_mask / ratio-to-prev) */
 	if (pmu->probed.can_sample && perf_pmu__has_format(pmu, "acr_mask")) {
 		struct perf_event_attr l_attr = base_attr;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index ee56570cac00..bb21e910da90 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -266,6 +266,24 @@ struct perf_pmu {
 		bool can_aux_resume;
 		/** @probed.can_aux_sample: Supports AUX area snapshot sampling. */
 		bool can_aux_sample;
+		/**
+		 * @probed.rdpmc_available: PMU supports user-space counter
+		 * reading (rdpmc/mrs/csrr).
+		 */
+		bool rdpmc_available;
+		/**
+		 * @probed.can_user_rdpmc: User-space counter reading enabled
+		 * (cap_user_rdpmc & index).
+		 */
+		bool can_user_rdpmc;
+		/** @probed.rdpmc_works: User-space counter read instruction executed and worked. */
+		bool rdpmc_works;
+		/** @probed.can_user_time: Supports user-space time conversion (cap_user_time). */
+		bool can_user_time;
+		/** @probed.can_user_time_zero: Supports cap_user_time_zero in mmap page. */
+		bool can_user_time_zero;
+		/** @probed.can_user_time_short: Supports cap_user_time_short in mmap page. */
+		bool can_user_time_short;
 		/** @probed.exclude_user: Supports perf_event_attr::exclude_user. */
 		bool exclude_user;
 		/** @probed.exclude_kernel: Supports perf_event_attr::exclude_kernel. */
@@ -304,8 +322,15 @@ struct perf_pmu {
 		int user_regs_abi;
 		/** @probed.intr_regs_abi: ABI flags for intr_regs_mask. */
 		int intr_regs_abi;
+		/**
+		 * @probed.rdpmc_sysfs: Value from sysfs rdpmc or perf_user_access
+		 * (-1 if unknown).
+		 */
+		int rdpmc_sysfs;
 		/** @probed.mem_events_mask: Bitmask of memory event types verified by probing. */
 		unsigned int mem_events_mask;
+		/** @probed.pmc_width: Bit-width of hardware counter for user-space rdpmc. */
+		u16 pmc_width;
 		/**
 		 * @probed.sample_types: Bitmask of supported
 		 * enum perf_event_sample_format flags.
-- 
2.56.1.750.gf70dc682cf-goog

