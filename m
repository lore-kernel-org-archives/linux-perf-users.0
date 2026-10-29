Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793316537;
	b=mu7HoL2lDkbEvmyi7aA79JNVuZnpugvoyRc1iW0lLS1uzqeltGiKs3I4bTqKzMLAtBpv
	 XDfTvkfxmTpcbtZXXxi+HUA/xJg447MAhjkdquiYam5yGinkJCQ4kCjfXKnGw660gpQq0
	 gJKZdmfWNjdNWS28vySmUR5SVOg0VfAIRxyEIw7LKoY/Lzz7SAq3A+3y00Vso0jxgeAlO
	 OVqMpmF2nAaxkgTGdi7oLFSsy1IkZtydLR12IfBFpsw9ZTYRhoU04DPB9y97wO9CD+jjG
	 BKVGoKTNHDfsVAqyCM2sPiSlewL/379av9VfURDSooryLPqIMzCB0EtLgWihIXvmZag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793316537;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:User-Agent:MIME-Version:Content-Type;
	bh=5h2QYAUToJaBGd0SGBHbFjbHZlMRwFbs4A1MHWtxF2o=;
	b=sdT+o5x9m4J2B5W95CtrAcEJgoSccpSpNpFdnqt7aUc3wQcpAQ1dnsVt+X0HPoBCK9rV
	 Mu61TVmWyqz7QGVswUd1sNUeiMkf24LR7e4HZ4aDMRDKaIBCJxphn/xx/jwbw7PZamlhP
	 d9nf5Mx58YtfYtk16lLVyIXrDfY/X2ECesixFJtFhcYd+xTHhGN0pe4QG+aeYDL13+ttq
	 rc9UbyC2cLt1TixpRa+6MI8rDhgViGmQZjaUFTDq/iTpidT5umoa2tRfl/8P5Y0WeanzD
	 lDM1eXj+UaKgUWYHNt26jQMduxafWKTvN/Ow+hcVFjNqG21ApvlowfzO63jhpx8DbMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YOgm8mcb;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960F3606A33F
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 23:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 960F3606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YOgm8mcb
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so285968eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 16:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793316536; x=1793921336; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5h2QYAUToJaBGd0SGBHbFjbHZlMRwFbs4A1MHWtxF2o=;
        b=YOgm8mcbczfA7htknXvada6PreAPrkYysyTyxZIjC0VGtZBE8sM2qbalP55zVF52zF
         Je7HazYD9Hm80fZzmMbfwmSxVHCginJPN6PzK7/X3WWrl7aC37ytFd6b0iy/wRRXNi94
         tYw3fN9Mh51WgGDhAy5EWVUTfBx7oOi9Qhe/oQicWugzmsaAFKccgq1AxeOwuk9U3O7a
         xmlHbSAowdwzgS/0s1t8uQgi/w+3Akx0vPOf3IIRwp7lfXgY5sYmarSaa43wpJVasINm
         t23ZH/X+/xsvCrOv4+ctvnCT5vt+FWvsBwhyOCmT/qfgq+uShGXAJhYdjrpTG4r90V9Y
         sR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793316536; x=1793921336;
        h=content-type:mime-version:user-agent:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5h2QYAUToJaBGd0SGBHbFjbHZlMRwFbs4A1MHWtxF2o=;
        b=jBA9jH13VuTevBZocpbN3d+WZD1Yr1n+lyhT8AJq4gXGcmLvqG416u4qCNIfWFE7V8
         Ep+NGLM6AenWthTKUd5WBrBTJ+SVnUyWzt24ixqNRoMCbAJFUuGY/2dBcwLmi7ki40t+
         wWTTrBmuNRQR1z+/PbPh+x0Qq64Pf0/0MCCiPtqOXC39g6RFDir9TpKHJo8vhgctiwVX
         l7JiqXsMxy0adXKbTqvOgPRA1SuHmj6AzouKZGSaSI4rW2wgIyv7GeCi1cQ0AF3q3IOw
         d9cQ6ZaKttWZFqrbMFZ0li03exhPCDOKZn0hWKYKD7zrbPOt6ZcYbhezy38pC1K6Hy7V
         ZtkQ==
X-Gm-Message-State: AFq9FYKjzyUH4K9ChBaHRAdGzioLGocU48Cn9McJBN73jCg+x1xW/De3
	NqjRE/yWQQoCfkVHgWyTlEWf6/Pu3Mtzu3VIkHRApUx8Lt6RhaXOD2XiD4z9eLWgRQ==
X-Gm-Gg: AYBFou0Xn55xSGE4EV+qWZZjiG/U62S0+aVpIfLDa4LS0PQ5+aTfctgU8aSy9oUNqYG
	ayamfQUMtSQgfWZSIiizdqBPmK2uYm17LjYRjzJRFq5lhgk1n0XfyjqFE6osLBc7hsjPMC1xv9X
	aOMBzm/oIECjb5wkVFdzQ3G4EJkw2tSLgBBDfSEm7k9BYPaMHzi0S4lFnxN7Kk9s+Dvj2yeSX/e
	3Rbl3xAec3PLMEN5hfS1Ucj41EVmhPw+SiMLaYwd18nT3QWl8t5E5U+92ni7/MLVU45PyOi2sEQ
	L+6jjKDXZQ9AVcT/kx1DtQyZpU4pnNplIuhGpm2Vrw/MVQAPHv+V4gZyv3k87mThB0Zyh/p4BpJ
	oeix0qvNteiG0jv+ZMUjlnNNtKQHBetqIBYWYKE2amIH+DDEeSVBWKNmQgwWEi9vuBFhwM+UYie
	47yCtHbPIe7Vuib99Bw6lKj/SO34/r8/qmVujxKwfDIapud1hexNBZpWKY/8gaqTt5g4HGfN9xI
	uwKDFC+Qoh5tOQNyLHrLNpDdDXCf6IT3A3fxwoUa42i2LwIIEWOfnit4YJXdcYNR9aczA7gDrQ5
	ZwLtBXljRKpD7Uu4AeLmLFPwDah2ENAcQZ3n8A==
X-Received: by 2002:a05:7022:f20b:b0:136:c443:80e5 with SMTP id a92af1059eb24-1ac56d94b0amr847420c88.6.1793316534852;
        Thu, 29 Oct 2026 16:28:54 -0700 (PDT)
Received: from bsegall27.localhost ([98.45.141.147])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac192c2e9dsm2146185c88.9.2026.10.29.16.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 16:28:54 -0700 (PDT)
From: Benjamin Segall <bsegall@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf: skew perf_mux_hrtimer_handler firing across cpus
Date: Thu, 29 Oct 2026 16:28:52 -0700
Message-ID: <xm265wykhyrv.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

When in nohz_full, perf_mux_hrtimer will wind up checking if it needs to
update jiffies as of commit 53e87e3cdc15 ("timers/nohz: Last resort update
jiffies on nohz_full IRQ entry"). When perf is run systemwide or against
a wide process and needs the mux timer, this will fire against many cpus
at the same interval. Then, much like the timer tick did, this will
result in unnecessary lock contention on jiffies_lock. This is
particularly unfortunate since nohz_full is intended to reduce the time
spent in irqs on those cpus.

Adopt the same solution as sched_skew_tick and just have a different
offset for the timer on each cpu, and make sure to redo the skew if the
interval is changed.

Signed-off-by: Ben Segall <bsegall@google.com>
---
 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index eb3f7bab498ca..e1cb052af3d2e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1123,10 +1123,11 @@ struct perf_cpu_pmu_context {
 	int				pmu_disable_count;
 
 	raw_spinlock_t			hrtimer_lock;
 	struct hrtimer			hrtimer;
 	ktime_t				hrtimer_interval;
+	ktime_t				hrtimer_old_interval;
 	unsigned int			hrtimer_active;
 };
 
 /**
  * struct perf_event_cpu_context - per cpu event context structure
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 457d75ea71420..7885071bf0856 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1277,17 +1277,29 @@ static void perf_cgroup_switch(struct task_struct *task)
  */
 static enum hrtimer_restart perf_mux_hrtimer_handler(struct hrtimer *hr)
 {
 	struct perf_cpu_pmu_context *cpc;
 	bool rotations;
+	u64 offset;
 
 	lockdep_assert_irqs_disabled();
 
 	cpc = container_of(hr, struct perf_cpu_pmu_context, hrtimer);
 	rotations = perf_rotate_context(cpc);
 
 	raw_spin_lock(&cpc->hrtimer_lock);
+	if (cpc->hrtimer_old_interval != cpc->hrtimer_interval) {
+		/*
+		 * Skew the timer to avoid contention on jiffies_lock in
+		 * nohz_full, whenever we change interval
+		 */
+		offset = cpc->hrtimer_interval;
+		do_div(offset, num_possible_cpus());
+		offset *= smp_processor_id(); /* we are PINNED_HARD */
+		hrtimer_set_expires(hr, offset);
+		cpc->hrtimer_old_interval = cpc->hrtimer_interval;
+	}
 	if (rotations)
 		hrtimer_forward_now(hr, cpc->hrtimer_interval);
 	else
 		cpc->hrtimer_active = 0;
 	raw_spin_unlock(&cpc->hrtimer_lock);
-- 
2.56.0.317.g454f8302e1-goog

