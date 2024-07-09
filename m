Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487EA14F131;
	Tue,  9 Jul 2024 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518912; cv=none; b=arFDD6lZzch5PmR8X1H3aVj/GAMoHSvoo4L6fkYkSxvxro2p/tIkN24ca7EbiizzEdTnwxYmFDKQGmHO4PQr51Xv689Yov8tTewid8MHDUXJSsq2291wU+Fzsb9TKLfSHdGN8O8uQuDr6vyZueJdZ4GIh/KEe7YJLIOui5PxwGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518912; c=relaxed/simple;
	bh=xbBYpeUgi3jxNaO/CakzXkYOVeh8wOfJ6lkI8xevQds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OUoCAbDyqHTRyrSpMY69GdukF9O5NvL/QRiCLCGxIJ4xmDRpMN6X0QiNpYZ6ALORsdbmilF+d5hXlZ4/ddeXQWvhjQr4KvwKAu+01UVrWj31o35xPSoS+gma2cVRJwkYDp5EE2A+xQUmnh0gtYSkKnmL0WX2bdLV6pYPxr6FFmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxS_D8CI1mT2ACAA--.7078S3;
	Tue, 09 Jul 2024 17:55:08 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxqsb6CI1mgt1AAA--.17645S2;
	Tue, 09 Jul 2024 17:55:07 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] hw_breakpoint: Save privilege of access control via ptrace
Date: Tue,  9 Jul 2024 17:55:03 +0800
Message-ID: <20240709095506.9691-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cxqsb6CI1mgt1AAA--.17645S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtryxCrWDXrW3Zw13KF4kGrX_yoWfJwcEgF
	yxJ34DK3yv9F15ta4UJ3WSvF93t3y5W34Yyr1UKrZxGasIva48Zwn8AayxWwn8Xrs2vFWD
	Awn8urn2vrnxKosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07joc_-UUUUU=

v3:
  -- Put the new member "bp_priv" lives in a union on config3
     at the end of the uapi struct perf_event_attr.
  -- Update the commit message to make the goal common and clear.

v2:
  -- Put the new member "bp_priv" at the end of the uapi
     struct perf_event_attr and add PERF_ATTR_SIZE_VER9.
  -- Update the commit message to make the goal clear.

Tiezhu Yang (3):
  perf: Add perf_event_attr::bp_priv
  arm: hw_breakpoint: Save privilege of access control via ptrace
  arm64: hw_breakpoint: Save privilege of access control via ptrace

 arch/arm/kernel/hw_breakpoint.c   |  4 +---
 arch/arm/kernel/ptrace.c          |  2 ++
 arch/arm64/kernel/hw_breakpoint.c | 11 ++---------
 arch/arm64/kernel/ptrace.c        |  2 ++
 include/uapi/linux/perf_event.h   |  5 ++++-
 kernel/events/hw_breakpoint.c     |  1 +
 6 files changed, 12 insertions(+), 13 deletions(-)

-- 
2.42.0

