Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9661459EA;
	Thu, 14 Aug 2025 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755164026; cv=none; b=WzJtG/h6CsVBlTyYTDVc7qK42oTQMPBCDoHc34jJmiab8/L3YrLnPXSsuWVAX0fLB//BuZOP3jfwa3AQeZ2G/ypDBcPY7a4bO999pPRXzIsrVKBVL46AfYhEyqjLUNQltKnMcE8Cpp7KOWkJcccZ05t8+bWB6Wa7X3kCY4riP2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755164026; c=relaxed/simple;
	bh=7iaTzwlnmhwbA+apBzSECwy15FMAd1JlpcZ8t4dIBdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VZ0BpCj+JvaxConaVeGpq0HuA+pra7A9UHshRYl+LFkeulebxXkuscddLbAjcszl3/xnruyjhM8w0h6diOcItV+XOKpkrsv7RHzQOf37xlIyR+KndWVoPSWGMxuEJ4XdNc3ssz+WSjSZ1goTKLq6SOtVJGuy3rU1gaBeUSaMloc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=myO30dyp; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="myO30dyp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=PO
	6/s9/udkUFFSSjh/2mbrajibVc2GAUeD7nVCqBEb0=; b=myO30dypPoDV2Da2zT
	ihBgwTJ5v+slnYd9+qv2ZtqiEXYKmo3AruGuLNCjD1aYQZmtx6phlV1Huja70Gy6
	qMX+C1/W0IHr+8iYic6R4mYpLEjLGg/OC9tAjQUpVOEGvcyHBE5vZJi+N4wnPDbm
	+yS8O12XTQKvWxfKF7BR4xkP8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wCH7ltXrZ1oPpJrBw--.9386S2;
	Thu, 14 Aug 2025 17:33:13 +0800 (CST)
From: tanze0x01@163.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tanze <tanze0x01@163.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH v4] perf/x86/zhaoxin: Fix instructions error by missing fixedctr member
Date: Thu, 14 Aug 2025 17:33:09 +0800
Message-Id: <20250814093309.1580835-1-tanze0x01@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCH7ltXrZ1oPpJrBw--.9386S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF4fAr1kuFWfZry7Gry5twb_yoW8WrW5pF
	nrJwnxtFW8WanFq34rtan7A3yY9r4fKayqgr1UJw13X3s8Xwn2qFW8Kry5uasxJry29Fyf
	WwnFv343Z398Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jTmhOUUUUU=
X-CM-SenderInfo: xwdq6vkq0qiqqrwthudrp/xtbBzxWpqmidRI+m8gABsy

From: tanze <tanze0x01@163.com>

Perf's instructions event tests on Zhaoxin CPUs may exhibit:

  $perf stat -e instructions,cycles ls -l

  ......
  Performance counter stats for 'ls -l':

                 0      instructions                     #    0.00  insn per cycle
         9,488,278      cycles

       0.004365407 seconds time elapsed

       0.003303000 seconds user
       0.001099000 seconds sys

The absence of the fixedctr member leads to an incorrect hwc->event_base
value on Zhaoxin CPUs, causing a discrepancy in the instruction count
reported by perf stat. This commit resolves the instruction count issue
by properly initializing the fixedctr member.

Fixes: 149fd4712bcd ("perf/x86/intel: Support Perfmon MSRs aliasing")
Signed-off-by: tanze <tanze0x01@163.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

---
v1-v3:https://lore.kernel.org/all/20250620023757.1429898-1-tanze@kylinos.cn/

This patch does not modify the previous code,
Do you have any other suggestions?

---
 arch/x86/events/zhaoxin/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
index 4bdfcf091200..3fc3f9abece9 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -467,6 +467,7 @@ static const struct x86_pmu zhaoxin_pmu __initconst = {
 	.schedule_events	= x86_schedule_events,
 	.eventsel		= MSR_ARCH_PERFMON_EVENTSEL0,
 	.perfctr		= MSR_ARCH_PERFMON_PERFCTR0,
+	.fixedctr		= MSR_ARCH_PERFMON_FIXED_CTR0,
 	.event_map		= zhaoxin_pmu_event_map,
 	.max_events		= ARRAY_SIZE(zx_pmon_event_map),
 	.apic			= 1,
-- 
2.25.1

