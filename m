Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 5A7B6143861;
	Tue,  4 Jun 2024 09:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492116; cv=none; b=qz51BKj5eW1z8hWhH2xshYFYTn5Fks56TywBN16o23Gl9oGm13j/6Cker5pv6MvWuG18Y5jZIR0Ivk8bgP3jrLymiv1vDsjuQDaM9/yX2LjQ2TxmFPvm7SAWvbaMvqI7NN5j292JPzB+hcMX8ojtGU/3iMrxCtrTDd80i/JFfiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492116; c=relaxed/simple;
	bh=hGb4UAIi4lt+FKNZcwxdqAoWUZ+8IgXCNR6exSoJQCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FUaC/RrnYTxsbYHRvFr6ko78PitkwU4xeY2Vv00io0//07LFDtutWcb0+xDD+oQ5qS3vk+n3WLKeUKXAMzo25r7Zxnss/0AZT7c4ZPbPPscdgsbFTqjv/cnS74gfSRKYHT+g+DXKtR9iFgSe77Mn3L8RY9bmRp9UDJngtljwpkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 86F81604BB2D1;
	Tue,  4 Jun 2024 17:08:10 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li zeming <zeming@nfschina.com>
To: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?events:=20core:=20Remove=20unnecessary=20?= =?UTF-8?q?=E2=80=98NULL=E2=80=99=20values=20from=20task=5Fepc?=
Date: Tue,  4 Jun 2024 17:07:30 +0800
Message-Id: <20240604090730.62670-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

task_epc is assigned first, so it does not need to initialize the 
assignment.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f0128c5ff278..5e1a4cbdb67d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4283,7 +4283,7 @@ ctx_event_to_rotate(struct perf_event_pmu_context *pmu_ctx)
 static bool perf_rotate_context(struct perf_cpu_pmu_context *cpc)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
-	struct perf_event_pmu_context *cpu_epc, *task_epc = NULL;
+	struct perf_event_pmu_context *cpu_epc, *task_epc;
 	struct perf_event *cpu_event = NULL, *task_event = NULL;
 	int cpu_rotate, task_rotate;
 	struct pmu *pmu;
-- 
2.18.2

