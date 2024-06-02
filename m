Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4D74A23;
	Sun,  2 Jun 2024 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717286851; cv=none; b=oeGeVzLhS/OwKiZ50MiRoVgnpSsBbYXqyds1JoeMo7O+jKrAsH392Qa0NfdxHZm5sl+4Wudy3E0CIa/bjMBcWdgSR07ZtUZKNAEpBPRg/zEzIrTfpembcoldsXVsRwIrkdFwgVYrtw2KjlcvlGU2TgmW7FrYaK4IGaAGzZ+oxYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717286851; c=relaxed/simple;
	bh=bUazdPEUGXG7BVZAHP6iffcOY8WHso3Lci8AE22n8S8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nnMTIbho3sgI6a3yUuN0tdXfMDbL0wgQkkYnbvkX6h050s7GWQlMWebcIXZoYRrUUakrZdub/2Y7E6HsmGkRZjCp8oMAStRJGHANNDAbxh8OOUuc3Eqk6iNS2ip4m6g83Y7YwZmzJ321Xpb3NAbXDKnZAaOChNYVCnvOe3TqagE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=CFsoEpXv; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="CFsoEpXv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=BTg74Q8G7r9JfxNh0PyANZiqfRUsI/acV0wBtpvoB/M=; b=CFsoEpXvURX2mEFC
	ziu4AsEolaQvdoo7wmh6nO0Hlob2JFANofBKi4H/FDOq/IYdxKxOjAyzI8X4okvb1yu90NuBUfBuw
	bUoOdqUjotqn7u3RXOgVFTqILATC37Dk6N2AqwSZLWbgTUmIZvfGEJIx0sML/dqQrAYJpZGgGtHHx
	KseISnAHgEq1Zn0IISAyiYmMJ7Z1TPqHeLl3UYK6zUX5lWOcFa+MiBvR4N4+Zgu+fFjxn2axEXon3
	F+zMDDBb71an+m8iJqnlbpg6k7/oa32x1UgaEI5sAbWURV/QYiv1IZxZoBdLFWOtL3Lzj/UmuRyox
	xJMSebOkLnLpnh9vNg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sDYkg-003m3O-2I;
	Sun, 02 Jun 2024 00:07:11 +0000
From: linux@treblig.org
To: yangyicong@hisilicon.com,
	jonathan.cameron@huawei.com,
	peterz@infradead.org,
	mingo@redhat.com,
	jolsa@kernel.org,
	irogers@google.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] perf hisi-ptt: remove unused struct 'hisi_ptt_queue'
Date: Sun,  2 Jun 2024 01:07:09 +0100
Message-ID: <20240602000709.213116-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'hisi_ptt_queue' has been unused since the original
commit 5e91e57e6809 ("perf auxtrace arm64: Add support for parsing
HiSilicon PCIe Trace packet").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 tools/perf/util/hisi-ptt.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
index 52d0ce302ca0..37ea987017f6 100644
--- a/tools/perf/util/hisi-ptt.c
+++ b/tools/perf/util/hisi-ptt.c
@@ -35,11 +35,6 @@ struct hisi_ptt {
 	u32 pmu_type;
 };
 
-struct hisi_ptt_queue {
-	struct hisi_ptt *ptt;
-	struct auxtrace_buffer *buffer;
-};
-
 static enum hisi_ptt_pkt_type hisi_ptt_check_packet_type(unsigned char *buf)
 {
 	uint32_t head = *(uint32_t *)buf;
-- 
2.45.1

