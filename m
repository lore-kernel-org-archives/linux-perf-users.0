Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479794;
	b=qNixIrtfiqSdBOFuAbq1rp6owUzNgvk6XkMZgAqyhvZYnViNJ3pfPNAvpN0fo+nSHpXp
	 njJQEctekivNQJNmPD0SZ2CQOkpifwwg1dOnychWvD8x66xQvEnQsfYDXmxlg46Tc3yz8
	 vOtgKlp6JwvrUd5pl/deKklCxMW4cr4yLOFqAaCbadbFWanzHiaAKZUUoFoze22PxIQm5
	 HE26CZ3Us1Lq1aWusyfZ7MtKXZCeWeqqFPUMsanQx9/hy0MdVjE9TK/bT9sorOCJ1yZBO
	 v3f3MEo6p7lRvFK9u5wzPCO1N9LpsOLTqXBirUh3G8Xfp8SxdP91Q94cLyYR26oU1xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479794;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fI8ghVWbQeoE8EoWyYFaP5jeWl+2kB1c5wsHFSF1Dj8=;
	b=VHjCuPc6dyHB2RwwUBIvjZriqwwFMF5co/lzitktLvvzw1U3m6nzeScDgT8+lGl/OIE9
	 yrzvwm1TfHIpMoJAaccR3hZAQmb+wjo/RzblYoGAiljukS8bN++2LI/S79p7cC5xQBJq3
	 ST1ubemFTdT/OHc3t6mQouucdzh2Ck63hVpQeiAv9IBp8EjMJJeCX0fPq2SxXE0EDb59h
	 uFkdZJi0mFRmuu3JfpqJxk1pzZdgzs7xf4BMmgpVejlYjfkHM0DEydzim2Cws/kIwEqR6
	 oVgPhzhaOgeXzO1JdU0XgJ1x9NnJITfS4XJkx5d8UvgoyNAeciiN5xnh3FFFc/62Wcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i8JPIHEX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2126F606A322;
	Tue, 24 Nov 2026 00:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i8JPIHEX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62BB1F000D1;
	Tue, 24 Nov 2026 00:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479792;
	bh=fI8ghVWbQeoE8EoWyYFaP5jeWl+2kB1c5wsHFSF1Dj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i8JPIHEXKR9OSltbS0TydhN2ZJ9oYmo2uicDXwaRyavJLE0w6QUQA0BS7sY/Veh9h
	 N1yC0xZomH7h/TRu6h2E/Sp1rWyrk9t/gWY1IN9e4dv03fvOfW9ysvhs+tfQQ0kxZz
	 son6B/wZqFhaCBy1o3iSg7nJClC8CrE0tUBbTXYWrldphA+GF5xRuf9uIy5M6JyG6H
	 iGNGdEyDKBwK63nD68UWl5I0i1JLbytoJnBx8Ur8VHgrMqjTSPWykHvfW6EzjKEbKI
	 DIj61ngkWwKuOIVN2YuPSdlDWkEX9zs6hwIxskdXFNH8l+hMeUyNi8qQGqlaNfXK3q
	 Gqyg8Uyx7woCg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mingwei Zhang <mizhang@google.com>,
	Jim Mattson <jmattson@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [RFC PATCH 02/26] perf/core: Don't subtract guest time for events that keep counting
Date: Tue, 24 Nov 2026 00:22:39 +0000
Message-ID: <20261124002303.1785363-3-yosry@kernel.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
In-Reply-To: <20261124002303.1785363-1-yosry@kernel.org>
References: <20261124002303.1785363-1-yosry@kernel.org>
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

Currently, events with exclude_guest=1 in a non-mediated PMU context
(e.g. software events) are not scheduled out while the guest context is
loaded and keep counting, yet the guest time is subtracted from their
time_running/time_enabled. This discrepancy grows if the guest context
remains loaded beyond the KVM inner run loop (i.e. with dynamic PMU
context switching).

Only subtract guest time for events that are actually scheduled out
while the guest context is loaded (i.e. host-only events in a
mediated-capable PMU context).

Software events with exclude_guest=0 grouped under a leader in a
mediated PMU share the leader's PMU context, and are scheduled out while
the guest context is loaded. Keep counting guest time as enabled for
those, as they miss guest time they asked to count, similar to being
multiplexed.

Fixes: 4593b4b6e218 ("perf: Add a EVENT_GUEST flag")
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 kernel/events/core.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6f076e5483cb7..5a3e40155ce70 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -176,7 +176,8 @@ enum event_type_t {
 	 * - In for_each_epc() to skip PMUs that don't support events in a
 	 *   MEDIATED_VPMU guest, i.e. don't need to be context switched.
 	 * - To indicate the start/end point of the events in a guest.  Guest
-	 *   running time is deducted for host-only (exclude_guest) events.
+	 *   running time is deducted for host-only (exclude_guest) events of
+	 *   MEDIATED_VPMU PMUs, which are scheduled out while the guest runs.
 	 */
 	EVENT_GUEST	= 0x40,
 	EVENT_FLAGS	= EVENT_CGROUP | EVENT_GUEST,
@@ -872,12 +873,22 @@ static_assert(offsetof(struct perf_event_context, timeguest) -
 #define T_TOTAL		0
 #define T_GUEST		1
 
+/*
+ * Exclude guest time only for host-only events in a mediated PMU context, as
+ * those are scheduled out while a guest with a mediated vPMU runs.
+ */
+static inline bool perf_event_exclude_guest_time(struct perf_event *event)
+{
+	return event->attr.exclude_guest &&
+	       (event->pmu_ctx->pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU);
+}
+
 static inline u64 __perf_event_time_ctx(struct perf_event *event,
 					struct perf_time_ctx *times)
 {
 	u64 time = times[T_TOTAL].time;
 
-	if (event->attr.exclude_guest)
+	if (perf_event_exclude_guest_time(event))
 		time -= times[T_GUEST].time;
 
 	return time;
@@ -890,7 +901,7 @@ static inline u64 __perf_event_time_ctx_now(struct perf_event *event,
 	u64 time = now + READ_ONCE(times[T_TOTAL].offset);
 	u64 guest_time;
 
-	if (event->attr.exclude_guest) {
+	if (perf_event_exclude_guest_time(event)) {
 		if (is_guest_mediated_pmu_loaded())
 			guest_time = now + READ_ONCE(times[T_GUEST].offset);
 		else
-- 
2.56.1.809.ga0b61035b5-goog

