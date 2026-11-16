Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794816794;
	b=D++1Krp4oTfAQ2slEzK67dIMiBqJnf0cEXsKzgYPZE5E2iVeL6p6NaOJUvNE/+atf0yL
	 iu6OSMtMUldghg+B8hUppAIS9BTd8wwD7MhklRbmWFvq80W+2Ma/wm0K8oc554WVN8DCa
	 QZwcRB0egweWuosAclIuVPzsJkHHBdumTDys2O5hoP1M7gR3BWfr0iOUn6bRC0+fCIGnY
	 eU/4upmHPzavFUrLcsD36XLQMmhdFqmN2XDqBLjM2lCXNoMFXbA+FnAbbkL1NNms52sIc
	 j7pw7DhufMbaFlrR87+2fCmOjigi2m5YCPvog9rdfljALMcH0z2AiYfSnr9c/nUMsUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HMeM0QfJQAC8IxnA6vSCAe8SX44/lRojJHCqiwMF6ks=;
	b=5R60MQobYwQgxF1ip417GErBqYwY9TwJKBvAjfVjihNnkOWkXX2fVWQQeGXFz6zGoxXE
	 fcG9QUlXBKejueeYeBzF+NAgK/nxIuI21YX0AzOiuanVlfjJqa4CUybG4yOudlPK9G/Py
	 xXc69Wcsv54lgDvG21pIQeBtlElsjpEsKOgdfaws1EGLrZ0D/JvsSo1bGKAodeK1+I0wA
	 wZBZ05/oOd/wYNWR5WVAKB4ZZyMno1AL1woepCs+vUziVaRaF5A2FETYz4kULNPmeclhm
	 obkW3LSG7LvqftlGemj6q6KGjQJOmn+Sys8f3QK8/mdTbas0m/q/GtHBDxs/iUenHIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=akPUhHiD;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE72E606A339
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 08:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE72E606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=akPUhHiD
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e9d7791b00so31538175ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 00:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794816791; x=1795421591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HMeM0QfJQAC8IxnA6vSCAe8SX44/lRojJHCqiwMF6ks=;
        b=akPUhHiD4rd2ZaZcybasijHMaK8gP3HN7guCnUggkHaUE3OOYRv1eYyKrvyFiLIpxq
         P2fTuaPXu3zGHliTzkm/jl5B3OCZUOpbFB32CdvmqHwEQWwaQM7RaZAWgVc6A4M1bXFF
         b3ijO6RFPaQ1GoqQQp0/LmT3mylB+VnCgdSmQB01ZhAkX0XWUmfoodo3hYtk+B1osJs1
         pU9ZzXBqwJz1qBuAzhbAnlbqmG6ywLIpVGPzimYLXfFVFO05GMC4qG1MgwLZLuIaV7w9
         9UKEm+ILCQ2yN9FU/Wlk09SAfsxZ920rzJzsd25Wf04p10U0oeLQS4hoUKY9o8IY3ByF
         Mr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794816791; x=1795421591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HMeM0QfJQAC8IxnA6vSCAe8SX44/lRojJHCqiwMF6ks=;
        b=OSqpm8lYSTVwhCi9Drrs8adbg43YJ/a52plj+r/SjltZaAiN/55hqjXT9Yplko8RIx
         y62+Td57/7hJqpZPTByyHyt396Pxp5B9JX5a9V4VcSi+3bD9mNf5qaiHyBiMkKNrHR00
         lmbZVpNYLBiX/Li7fe88fudX49SafpI6BQCT5E7evTSbKz6GjScWBy0vmZlIN88O4fEu
         9V/jfLBPxpJ1rS/vWlqHcxLlYB/gFVa6ozY/1pBy1hfAlcN4LVBgVMxE2ewZI3yt63WR
         hIgWUZW4eNi0gfBRc7uCiS/92gWl567n2Cw0hfonDFFrSTBj1Ti8emtKAV1AsvtSi+BL
         EW/Q==
X-Forwarded-Encrypted: i=1; AL+hErH39uGGfyv/hvRweebLIs9qSLOxBpnlcARBMKAvWCUtR4nUx55VEAQBqLEDQ5GTzFVsvGMCLCpwjBn8gDP2GEzJ@vger.kernel.org
X-Gm-Message-State: APuU4Z8qhKB+byfBOYcTQ5n1GE6nclno06r41JP1XE5FUhHmG72QgCSA
	WHAsfMqfv/Wq66OBQ217kyjqzA+KqyeCa9ogT7paizq1OoFj58cdpd4/
X-Gm-Gg: AZFdTZcBaFlYLSeSyEGkjaDD2d2AsSk4QOwucgNx0fOcSPwy5CaYsQTsLm27ASNgv5r
	+jMCctDL9onWTz871vru04db8aDrDh0JYOZyY7V9haepHpGgBJEX1BhTT6scdFIULSqf4Q4m7wj
	AvcSzIwV9hVLtH4YXWmlvVxvKRQIOF/Lqr1NQH2b1RwV8eqmzyvUONHgmPIp2oxT1Ara7344grF
	hPu7NQbFWcHu9/Y5Sqk+pAjmWo3ZWnKmptE+3WF036vL5zd0yvo+xdyZrjjAqpp3Ekf57qhzI0K
	UpEKKW7ZWeoS2/UgY7/QfcJbMGFhAEVOnKOnMc0xXcTtZhGT/bzC9IKNIstJGXZYaksegJTWMUW
	tYpKH5agcDGsRCP70YSkXqaIEeETJlbrRV4CQsus1LeFrcuD9nsgOanT/Ce6pSymEuV/POrr4tq
	QRI5OeLQpqZRkMbnEb3broWCEMcT4WDq+hwUPlrAoGuN9QAQHD0Oj6s5IrLPcxwa6FO288SN6S5
	/5ONQWT64iLc3vMMF57v2ohDYR+/6UL/ebt7PXqSLj6DoyThci4kIek3hh5OBRWcxAIJyLmpFyT
	pmoIFwSRcHTnIFhbHLXNjMeqwsfX2NzECOL2bnD6VYYwPOJ8208k0DOa+7v6CtbLUmWFTgIzQit
	HZK9pBDU6v2f6Ntd8BJv06JnCDnS6rcOy6Q8icr9Bk/gOW0ftHRWIBEPeRiaLYktDk7GPq03mY4
	S/4r2My7qjU6fpbme5Jsepqq6NnkuzcEsFwgtsRNE72LFw0aQrvpbkHlkejuU02Hz+/0dGdyXrE
	DqbcOcc3D0iFnL6tSzroRUm8XltRz94l2euDQ8DpSmCDntPQQVMtqvfYB51ZRpH
X-Received: by 2002:a17:903:4686:b0:2df:90d4:7758 with SMTP id d9443c01a7336-2ee0dc93c50mr86140055ad.23.1794816790880;
        Mon, 16 Nov 2026 00:13:10 -0800 (PST)
Received: from localhost.localdomain (123-243-92-89.static.tpgi.com.au. [123.243.92.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f7cf8e1sm33712165ad.31.2026.11.16.00.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 00:13:10 -0800 (PST)
From: Daniel Wade <danjwade95@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Kyle Zeng <kylebot@openai.com>,
	Aditya Chillara <aditya.chillara@oss.qualcomm.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf: Reject group leaders detached by CPU hot-unplug
Date: Mon, 16 Nov 2026 18:42:48 +1030
Message-Id: <20261116081248.21059-1-danjwade95@gmail.com>
X-Mailer: git-send-email 2.39.0.windows.2
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

When a CPU goes offline, __perf_event_exit_context() removes every event
of that CPU's context with DETACH_GROUP. That clears PERF_ATTACH_GROUP and
PERF_ATTACH_CONTEXT and leaves the event in PERF_EVENT_STATE_OFF, or in
ERROR, while the file descriptor stays open and event->ctx keeps pointing
at the per-CPU context; nothing re-attaches it when the CPU comes back.
Commit fa091f46c383 ("perf: Reject exited events as group leaders")
fixed the same defect for remove-on-exec, by rejecting a leader in a
state <= PERF_EVENT_STATE_EXIT. OFF and ERROR are both above EXIT, so
once the CPU is online again a leader detached by hot-unplug is still
accepted and perf_group_attach() links the new event to it.

perf_group_detach() returns early when PERF_ATTACH_GROUP is already
clear, which is right for the double detach it was written for, where no
group is left to break up. With a sibling added after the hot-unplug
detach it skips a sibling_list which is no longer empty: the leader is
freed with that sibling still on it and still pointing at it through
->group_leader. Closing the sibling, or a group read or ioctl on it, then
uses the freed event.

Commit 42c5ca1f0a28 ("perf/core: Fix group leader use-after-free after
sibling detach") fixed the mirror image, a sibling detached by hot-unplug
and the leader closed afterwards. It promotes the sibling from the paths
below that early return, so a leader detached first and given a sibling
afterwards still reaches the same free.

Reproduced on v7.4-rc2, which contains that commit, with KASAN in a
two-CPU guest, as root:

  BUG: KASAN: slab-use-after-free in perf_event_update_time
  Call Trace:
   perf_event_update_time
   __event_disable
   __perf_remove_from_context
   event_function
  Freed by task 149 from an RCU callback queued by
  perf_event_release_kernel(), via perf_release() and __fput().

Opening a CPU event needs CAP_PERFMON or perf_event_paranoid below 1, so
an ordinary user cannot reach this on a default configuration.

Reject a leader that is no longer attached to its context, rather than
promoting siblings of a detached leader in perf_group_detach(): the early
return there is right, and the anomaly is a leader on no context taking
new siblings for a group that can never be scheduled. Test
PERF_ATTACH_CONTEXT, which only the __perf_remove_from_context() path
clears, so every detached leader is covered whatever state it is left in,
and test it under ctx->mutex, where the leader is already known to share
this context and every detach path holds that mutex across the removal.

One open that works today fails as well: adding a hardware event to a
detached, pure software leader takes the move_group path, which installs
the leader again before the new event is linked to it, so that group was
valid. Events removed by hot-unplug are not scheduled again, which the
commit in the Fixes tag relies on, so it now gets ENODEV like any other
open on a detached leader.

Fixes: 226424eee809 ("perf: Fix corruption of sibling list with hotplug")
Signed-off-by: Daniel Wade <danjwade95@gmail.com>
Cc: stable@vger.kernel.org
---
Tested on mainline b3dfbde62cf1 (kernel/events identical to v7.4-rc2),
x86-64 with KASAN, PROVE_LOCKING and DEBUG_LIST, kasan_multi_shot=1, 2 vCPUs
under KVM, on a kernel carrying only this patch. Without it a software
sibling is accepted and the close produces 15 KASAN reports; with it both
the software and the hardware open fail with ENODEV and no report appears.
An unrelated test that moves an inherited software group to the hardware
context still passes.

Not tested: other architectures, hotplug or suspend on real hardware, the
perf tool's own test suite.

 kernel/events/core.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f5f2261f1fe..21c529cd7d1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -14274,6 +14274,18 @@ SYSCALL_DEFINE5(perf_event_open,
 			goto err_locked;
 		}
 
+		/*
+		 * Likewise against CPU hot-unplug, which detaches the events
+		 * of a CPU context and breaks up its groups without putting
+		 * them in a terminal state. perf_group_detach() does nothing
+		 * for a leader that is already detached, so a sibling added
+		 * to one would stay linked to it after the leader is freed.
+		 */
+		if (!(group_leader->attach_state & PERF_ATTACH_CONTEXT)) {
+			err = -ENODEV;
+			goto err_locked;
+		}
+
 		/*
 		 * Only a group leader can be exclusive or pinned
 		 */
