Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60615289E25;
	Fri, 20 Jun 2025 13:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750424881; cv=pass; b=YSE1RGV6Mw7jspybSeHXaoe1DALjXtYMEggKd3mOqUmCqaEXYUPNn47rDetczPu8htiUohyVaOk6RG1dZX1pbSWzGQQKOFjm5igZJkh2GIhFNZkHodPXX1yuc1/LHG3EgKk6mbAT2t8V5jmW1dlQVjMuysUp9h5C3i7naP0oG5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750424881; c=relaxed/simple;
	bh=2iXG7eia1v94YWNjbygODnzZKHmhGakBBqNvfYOZtDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=k0A6/eSd9XTq58+w+qF2LqI3p61cES8Km5uCZD2bV9tZOptSeiM8kChSbg0m7QR8kZEccZYhYGb5oW1WcVwgYXQOolv3QoBZM/WlNKpr2AevpXD31nf3VTtbeQaytwSXFC5mOMKjfm0iK0wOqoFv448RRkzwh57yYxihyT6O4vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=HK60ujtK; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="HK60ujtK"
ARC-Seal: i=1; a=rsa-sha256; t=1750424855; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZuRdDeXji7e8RdZ+/rQ2quJwb0hTa2g3WxOdrtvq0A9zhhV7X/51m6ww9cKM4WcZs/FaF4srdPoWtLCpwm9/sUmet06xoaKapSuxANQLWQ3CBTZ9E9Rx92WUS0IscNKxFRTi30KQNVYugEfeiKctBVvjzhCAmfHtpfc8esJm6o4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750424855; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7bK7CVuSOQysQX8426rv7mnq8+Wx0EPjV/U4SoHzy5s=; 
	b=BssliwiLqLgAdRKgkwSrY9C4gNVF5m7PA6gRHD4zFkX5qGtMmBSY0MN+X01dZ4YSub8Jr5iT6o7YVskoQeNlzGIL6bBwhP+BHhvPcJJUNwVfnRbS9Pdwet5pUgVXmCn8BnOTycD2CWeF/aq3e14VpKyFJaEcFDXnn9jnsC1jkBc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750424855;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=7bK7CVuSOQysQX8426rv7mnq8+Wx0EPjV/U4SoHzy5s=;
	b=HK60ujtKAyvh7sf7ThXqhKGa0FkB9ELU8K40CkU5U34EnxMgjTFHgf7We0Nkx2oi
	Fryp9ttJN71hNgWLrQ1KR78c2To3DeO+sCOH1NTyUQjzTq0My8EnbLaxDmrKu7ghytD
	L4QKW4erjxAOTnS199rMyd+00EbeY3ny0z6u1pf4=
Received: by mx.zohomail.com with SMTPS id 1750424852417349.11288406056326;
	Fri, 20 Jun 2025 06:07:32 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 20 Jun 2025 15:06:57 +0200
Subject: [PATCH v2] perf/headers: Document PERF_PMU_CAP capability flags
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-perf-pmu-cap-docs-v2-1-97d7752fefac@collabora.com>
X-B4-Tracking: v=1; b=H4sIAPBcVWgC/32OzQ6CMBAGX4Xs2TWUIn8n38NwKO0iTYBiWwiG8
 O5W8OxxNpn5dgNHVpODKtrA0qKdNmOA5BKB7MT4JNQqMCRxcoszVuBEtsVpmFGKCZWRDgXjlAo
 qeSkkBG+y1Or1aD7qky295pD25xEa4QilGQbtq2ik1eMvX8JX6LTzxr6PnxZ2GH/mF4YMY8VTX
 uQqozS/S9P3ojFWXMMG1Pu+fwCnTiPH5wAAAA==
X-Change-ID: 20250618-perf-pmu-cap-docs-a13e4ae939ac
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: kernel@collabora.com, Jonathan Corbet <corbet@lwn.net>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, 
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

Reviewed-by: James Clark <james.clark@linaro.org>
Reviewed-by: Ian Rogers <irogers@google.com>
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
Changes in v2:
- Fixed the description of PERF_PMU_CAP_NO_INTERRUPT and expanded it to
  make it clearer for driver authors whether this flag is right for them
- Made PERF_PMU_CAP_NO_EXCLUDE docs mention the precise attributes the
  flag concerns itself with, as suggested by Peter Zijlstra
- Link to v1: https://lore.kernel.org/r/20250618-perf-pmu-cap-docs-v1-1-0d34387d6e47@collabora.com
---
 include/linux/perf_event.h | 85 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index ec9d96025683958e909bb2463439dc69634f4ceb..d0e6b66cfd268bdad742b707633792f26352a428 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -294,16 +294,101 @@ struct perf_event_pmu_context;
 /**
  * pmu::capabilities flags
  */
+
+/**
+ * define PERF_PMU_CAP_NO_INTERRUPT - \
+ *    PMU is incapable of generating samples
+ *
+ * On CPU PMU hardware, a PMU driver is only capable of generating sample data
+ * in the form of &struct perf_sample_data if the hardware is capable of
+ * generating hardware interrupts. If such interrupt capability is missing,
+ * this flag should be set.
+ *
+ * Uncore drivers, i.e. drivers for hardware performance counters that are not
+ * closely entwined with CPUs and their model of execution, should also set
+ * this flag, as they are not able to generate meaningful sample data, even if
+ * they do use an interrupt for some purpose.
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
+ * The PERF_PMU_CAP_NO_EXCLUDE flag, when set, makes the perf core reject any
+ * request for an event that has one of the attributes
+ * perf_event_attr::exclude_{user,kernel,hv,idle,host,guest} set.
+ *
+ * Drivers for PMU hardware that cannot distinguish between these different
+ * execution contexts should set this flag.
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
base-commit: 1d07605c859ee3f483f07acd461452d9e505c58c
change-id: 20250618-perf-pmu-cap-docs-a13e4ae939ac

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

