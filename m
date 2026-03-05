Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7397E2C21F4;
	Thu,  5 Mar 2026 21:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772745740; cv=none; b=PjmiuyAAhnXRmQCFiPxCP3cUv9BJfAlzVxRggULeLjhSVu8b61rf9D8fNW6MSH82cL/3FX2va78YRuJG3tJLz8UPmi0HkuJ4DNMw3TEraFi0M6Z8MT2yWSXVlzZTs0X9eHYY81R31t8RPUkZrh+Sw14J8/QifPYzDR60mOcavZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772745740; c=relaxed/simple;
	bh=OXXE4RUJw+TnCUdSP3DZ/XtM0ObRg1jiprd0LOaBVnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZMSi4O/C/+yP5q0o6I+MRIYbA7FoGClS1XtYdtiKYNxbZmffNwjZeXXDa1r4D81/TDVNOZZxbSTZrnzeMrFfX6IGDDZFNwdLVRkRig78dfv2V8vv4awKFuucF09o3w0JdNNerXwPkvSsWeBZJPWSDf1lTaSG1rJiJlXmSPFVjb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NzdISaeV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NzdISaeV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772745740; x=1804281740;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OXXE4RUJw+TnCUdSP3DZ/XtM0ObRg1jiprd0LOaBVnU=;
  b=NzdISaeV0nOPuueWaHH/SZAp1swsawcxoIu/SVootLwO/q18vWZXc9S0
   o/faYsBJDeU5oQJJZwNTY4v1h7NMLIDdrrENux6jbj11i4AEzX/VVbqvo
   vm/nrelL+ub4C0U2ZVx482RJx7Hc3cgJA+/vJI9HqNmfnW4BtPY3qD4ys
   0W+xYHA89VtRWrRHl2AANnmOG9SCdSaeSRk8fFJER8070Txkhkn2WqVKD
   8XhEtJCpwFbK9tG01hRL8bo3MoQeSrrx9KFkXnlGh3mV0bJSmIkvNsbrL
   IzXNjpUzla7qCjZMhbZNDk0/Zs2xHmKQ8IDxSm2sYLwjYGrK6R/bLJ2Wj
   g==;
X-CSE-ConnectionGUID: kS9MC8fARW+qO7w34frWWg==
X-CSE-MsgGUID: HRItaxVwRRKm4s2YOvwGtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="85320379"
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="85320379"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 13:22:19 -0800
X-CSE-ConnectionGUID: tE+1CR8HSzq5XsJe7Jmoew==
X-CSE-MsgGUID: JMgg7HNgS6e1B36G3XG+7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="223295218"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 13:22:20 -0800
Received: from ray2.jf.intel.com (unknown [10.24.81.183])
	by smtp.ostc.intel.com (Postfix) with ESMTP id D584C6362;
	Thu,  5 Mar 2026 13:22:18 -0800 (PST)
From: Dave Hansen <dave.hansen@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	linux-perf-users@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH] MAINTAINERS: Add references to tip tree handbook
Date: Thu,  5 Mar 2026 13:22:15 -0800
Message-ID: <20260305212215.3188399-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tip tree handbook is a pretty handy reference for keeping the
various tip maintainers happy. But there are no references to it
in the MAINTAINERS file.

Add a references to the handbook for a number of subsystems. I've
added these for all of the obvious subsystems that list T:.../tip.git
and are likely to follow the tip rules.

This will be useful both for humans digging in the MAINTAINERS file
and our new AI bot overlords.

I'm cc'ing all the M:'s and L:'s listed for the subsystems but leaving
off the R:'s because the cc list is already out of control. I'll
commit this to *some* tip branch if there's general consensus that
this is a good idea.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: x86@kernel.org
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 61bf550fd37c2..3e852a5babf77 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6283,6 +6283,7 @@ M:	Daniel Lezcano <daniel.lezcano@kernel.org>
 M:	Thomas Gleixner <tglx@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
+P:	Documentation/process/maintainer-tip.rst
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
 F:	Documentation/devicetree/bindings/timer/
 F:	drivers/clocksource/
@@ -6657,6 +6658,7 @@ M:	Thomas Gleixner <tglx@kernel.org>
 M:	Peter Zijlstra <peterz@infradead.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
+P:	Documentation/process/maintainer-tip.rst
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/core
 F:	include/linux/cpu.h
 F:	include/linux/cpuhotplug.h
@@ -7085,6 +7087,7 @@ DEBUGOBJECTS:
 M:	Thomas Gleixner <tglx@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
+P:	Documentation/process/maintainer-tip.rst
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/debugobjects
 F:	include/linux/debugobjects.h
 F:	lib/debugobjects.c
@@ -10656,6 +10659,7 @@ M:	Peter Zijlstra <peterz@infradead.org>
 M:	Andy Lutomirski <luto@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
+P:	Documentation/process/maintainer-tip.rst
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry
 F:	include/linux/entry-common.h
 F:	include/linux/entry-virt.h
@@ -13494,6 +13498,7 @@ F:	sound/soc/codecs/sma*
 IRQ DOMAINS (IRQ NUMBER MAPPING LIBRARY)
 M:	Thomas Gleixner <tglx@kernel.org>
 S:	Maintained
+P:	Documentation/process/maintainer-tip.rst
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
 F:	Documentation/core-api/irq/irq-domain.rst
 F:	include/linux/irqdomain.h
@@ -13505,6 +13510,7 @@ IRQ SUBSYSTEM
 M:	Thomas Gleixner <tglx@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
+P:	Documentation/process/maintainer-tip.rst
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
 F:	include/linux/group_cpus.h
 F:	include/linux/irq.h
@@ -13518,6 +13524,7 @@ IRQCHIP DRIVERS
 M:	Thomas Gleixner <tglx@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
+P:	Documentation/process/maintainer-tip.rst
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
 F:	Documentation/devicetree/bindings/interrupt-controller/
 F:	drivers/irqchip/
@@ -14888,6 +14895,7 @@ M:	Boqun Feng <boqun@kernel.org> (LOCKDEP & RUST)
 R:	Waiman Long <longman@redhat.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
+P:	Documentation/process/maintainer-tip.rst
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
 F:	Documentation/locking/
 F:	arch/*/include/asm/spinlock*.h
@@ -20694,6 +20702,7 @@ L:	linux-perf-users@vger.kernel.org
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 W:	https://perf.wiki.kernel.org/
+P:	Documentation/process/maintainer-tip.rst
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git perf-tools
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
@@ -21005,6 +21014,7 @@ M:	Frederic Weisbecker <frederic@kernel.org>
 M:	Thomas Gleixner <tglx@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
+P:	Documentation/process/maintainer-tip.rst
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
 F:	fs/timerfd.c
 F:	include/linux/time_namespace.h
@@ -23671,6 +23681,7 @@ R:	Mel Gorman <mgorman@suse.de> (CONFIG_NUMA_BALANCING)
 R:	Valentin Schneider <vschneid@redhat.com> (TOPOLOGY)
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
+P:	Documentation/process/maintainer-tip.rst
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
 F:	include/linux/preempt.h
 F:	include/linux/sched.h
@@ -28555,6 +28566,7 @@ M:	x86@kernel.org
 R:	"H. Peter Anvin" <hpa@zytor.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
+P:	Documentation/process/maintainer-tip.rst
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
 F:	Documentation/arch/x86/
 F:	Documentation/devicetree/bindings/x86/
-- 
2.43.0

