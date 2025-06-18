Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1478E20409A;
	Wed, 18 Jun 2025 19:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750273748; cv=pass; b=TVHmXiABDKtPldFIlOTezEwvUW0aGN/uClJJzkdVZ4kG8aygPpKXn1uQq8MStH9sR3l1IoPDUm5GUNC1uLQgRnWSgNX9gFhqqx6pu6DJV5TMq5PLXMnTQF8fWtLnKWZYd5Qt1pS08hrjYMAjaf2fG3+ro3wKdDEZRD0LIXZWrDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750273748; c=relaxed/simple;
	bh=4Z3AXktjTBKSymA4SqIUqydcN+VFCyRWZKF5DyykVwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CDHTFN40TuxghYWZed3nx28XEe+FNXl3hob35oAe7fMS+WwNwNEY/wfw0xFjXb1CW2ZUUfNWNVYrjVCHKSpb3gmSRJFPXNAUSkBv293NKl9RJrekndcA1zXPE+kKBK+xYUpB4lTrKm8m/9zMHPXg6Gkx/GhWLXsXURcymQWgo2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=XsW+M7t2; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="XsW+M7t2"
ARC-Seal: i=1; a=rsa-sha256; t=1750273722; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QJPnh45OETapjN4qF3xo8Lme5+vlpwWQSeXqDM9GDw0qwvNpHfKsv5siT+1nIxdMu3y3guASFweEovPANRautPbVdV+qIG9WxrX+K/e6Z7r0gtOgrTDCwA8EtaESOEvbrJxnVy/z9zjOmJHlmBfLAGe9+TpbTemM/i9Ks8/u0wQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750273722; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LgnFWrFFRwO1u4DsMfUjudDNydgl3mR9TjdmxuLGWNk=; 
	b=NChDot1uIg8fj/Wch7R9W9GZOZQV4qA/rcGlP5MOItU7UKcGdEWfR0MhOVNSFJe7R38mtCMlGPowDngMTcMrrOCx6dcD70xn+fpFbJ0KbDUR78z+Hfu8S2oOo5IPy56qppnOlH/34RTmQdhNQxdnY7ZWh9+ElRHHuvWxwu1G7Mg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750273722;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=LgnFWrFFRwO1u4DsMfUjudDNydgl3mR9TjdmxuLGWNk=;
	b=XsW+M7t2tDN2fz13xr0OMW8iXLyTCmFYRAmlfw+/LpMF184rGKtooK9E6SLgBfiZ
	OnqaE1IIhQaJ+Q8yuxRPukSaEy6765Cch4H/GJrEyVB5jM+vdmfA3ITbZ+4DNsryoH5
	9J8tF3DHTq8rIs3VTjSxMClEaT/+JQwrA8KnM6N4=
Received: by mx.zohomail.com with SMTPS id 1750273720909890.1724588959887;
	Wed, 18 Jun 2025 12:08:40 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 18 Jun 2025 21:08:34 +0200
Subject: [PATCH] perf/headers: Document PERF_PMU_CAP capability flags
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-perf-pmu-cap-docs-v1-1-0d34387d6e47@collabora.com>
X-B4-Tracking: v=1; b=H4sIALEOU2gC/zXMywrCMBCF4VcJs3agaVVsX0W6GNOpziIXM6kUS
 t/dYHH5HzjfBspZWGEwG2T+iEoMNezJgHtReDLKVBvapr00V3vDxHnG5Bd0lHCKTpFsx2fivuv
 JQf2lzLOsP/M+Hp35vVS6HCM8SBld9F7KYAKvBf88jPv+BeYMMl6UAAAA
X-Change-ID: 20250618-perf-pmu-cap-docs-a13e4ae939ac
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: kernel@collabora.com, Jonathan Corbet <corbet@lwn.net>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

Over the years, capability flags for perf PMUs were introduced in a
piecemeal fashion whenever a new driver needed to signal to the perf
core some limitation or special feature.

Since one more undocumented flag that can have its meaning inferred from
the commit message and implementation never seems that bad, it's
understandable that this resulted in a total of 11 undocumented
capability flags, which authors of new perf PMU drivers are expected to
set correctly for their particular device.

Since I am in the process of becoming such an author of a new perf
driver, it feels proper to pay it forward by documenting all
PERF_PMU_CAP_ constants, so that no future person has to go through an
hour or two of git blame + reading perf core code to figure out which
capability flags are right for them.

Add comments in kernel-doc format that describes each flag. This follows
the somewhat verbose "Object-like macro documentation" format, and can
be verified with

	./scripts/kernel-doc -v -none include/linux/perf_event.h

The current in-tree kernel documentation does not include a page on the
perf subsystem, but once it does, these comments should render as proper
documentation annotation. Until then, they'll also be quite useful for
anyone looking at the header file.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
There may be more perf documentation patches in the future, but right
now I'm focused on getting a minimally viable driver for the hardware
I'm working on going. Documenting these seemed to have a fairly good
effort-to-future-payoff ratio though.

I Cc'd Corbet in case he has any input on the verbosity of the
kernel-doc syntax here, maybe I'm missing something and all of these
could be in a single /* comment */, but as it is in this patch doesn't
seem too awful to me either.
---
 include/linux/perf_event.h | 74 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index ec9d96025683958e909bb2463439dc69634f4ceb..7d749fd5225be12543df6e475277563bf16c05b1 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -294,16 +294,90 @@ struct perf_event_pmu_context;
 /**
  * pmu::capabilities flags
  */
+
+/**
+ * define PERF_PMU_CAP_NO_INTERRUPT - \
+ *    PMU is incapable of generating hardware interrupts
+ */
 #define PERF_PMU_CAP_NO_INTERRUPT	0x0001
+/**
+ * define PERF_PMU_CAP_NO_NMI - \
+ *    PMU is guaranteed to not generate non-maskable interrupts
+ */
 #define PERF_PMU_CAP_NO_NMI		0x0002
+/**
+ * define PERF_PMU_CAP_AUX_NO_SG - \
+ *    PMU does not support using scatter-gather as the output
+ *
+ * The PERF_PMU_CAP_AUX_NO_SG flag indicates that the PMU does not support
+ * scatter-gather for its output buffer, and needs a larger contiguous buffer
+ * to output to.
+ */
 #define PERF_PMU_CAP_AUX_NO_SG		0x0004
+/**
+ * define PERF_PMU_CAP_EXTENDED_REGS - \
+ *    PMU is capable of sampling extended registers
+ *
+ * Some architectures have a concept of extended registers, e.g. XMM0 on x86
+ * or VG on arm64. If the PMU is capable of sampling these registers, then the
+ * flag PERF_PMU_CAP_EXTENDED_REGS should be set.
+ */
 #define PERF_PMU_CAP_EXTENDED_REGS	0x0008
+/**
+ * define PERF_PMU_CAP_EXCLUSIVE - \
+ *    PMU can only have one scheduled event at a time
+ *
+ * Certain PMU hardware cannot track several events at the same time. Such
+ * hardware must set PERF_PMU_CAP_EXCLUSIVE in order to avoid conflicts.
+ */
 #define PERF_PMU_CAP_EXCLUSIVE		0x0010
+/**
+ * define PERF_PMU_CAP_ITRACE - PMU traces instructions
+ *
+ * Some PMU hardware does instruction tracing, in that it traces execution of
+ * each instruction. Setting this capability flag makes the perf core generate
+ * a %PERF_RECORD_ITRACE_START event, recording the profiled task's PID and TID,
+ * to allow tools to properly decode such traces.
+ */
 #define PERF_PMU_CAP_ITRACE		0x0020
+/**
+ * define PERF_PMU_CAP_NO_EXCLUDE - \
+ *    PMU is incapable of excluding events based on context
+ *
+ * Some PMU hardware will count events regardless of context, including e.g.
+ * idle, kernel and guest. Drivers for such hardware should set the
+ * PERF_PMU_CAP_NO_EXCLUDE flag to explicitly advertise that they're unable to
+ * help themselves, so that the perf core can reject requests to exclude events
+ * based on context.
+ */
 #define PERF_PMU_CAP_NO_EXCLUDE		0x0040
+/**
+ * define PERF_PMU_CAP_AUX_OUTPUT - PMU non-AUX events generate AUX data
+ *
+ * Drivers for PMU hardware that supports non-AUX events which generate data for
+ * AUX events should set PERF_PMU_CAP_AUX_OUTPUT. This flag tells the perf core
+ * to schedule non-AUX events together with AUX events, so that this data isn't
+ * lost.
+ */
 #define PERF_PMU_CAP_AUX_OUTPUT		0x0080
+/**
+ * define PERF_PMU_CAP_EXTENDED_HW_TYPE - \
+ *    PMU supports PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
+ */
 #define PERF_PMU_CAP_EXTENDED_HW_TYPE	0x0100
+/**
+ * define PERF_PMU_CAP_AUX_PAUSE - \
+ *    PMU can pause and resume AUX area traces based on events
+ */
 #define PERF_PMU_CAP_AUX_PAUSE		0x0200
+/**
+ * define PERF_PMU_CAP_AUX_PREFER_LARGE - PMU prefers contiguous output buffers
+ *
+ * The PERF_PMU_CAP_AUX_PREFER_LARGE capability flag is a less strict variant of
+ * %PERF_PMU_CAP_AUX_NO_SG. PMU drivers for hardware that doesn't strictly
+ * require contiguous output buffers, but find the benefits outweigh the
+ * downside of increased memory fragmentation, may set this capability flag.
+ */
 #define PERF_PMU_CAP_AUX_PREFER_LARGE	0x0400
 
 /**

---
base-commit: 31d56636e10e92ced06ead14b7541867f955e41d
change-id: 20250618-perf-pmu-cap-docs-a13e4ae939ac

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

