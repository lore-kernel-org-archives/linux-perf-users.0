Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AA7389E02
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Feb 2026 08:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772180730; cv=none; b=ssMAnXh8+puA9Zf2hLewHH/0uF1r4mkuUJun9dkQaMjYLifmIQb5fGxXfxN3QMG5ED0VtBnlzFn2W8RFL+PFXrp0hY+FKgoRYx0YZ12ylL7M2yi4BHYi3lg0M8ZaNshHsO2SAQU+0iFGfQPM54o9DkpuYKhwtbayYzFCsBCBTGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772180730; c=relaxed/simple;
	bh=6RpSprXsB6BMqJxO0oqQz6OR7IGpUO6/74SKwTFdiWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DQOdzyCg+LmtM/Qxk3Ke5sKvA2asse91MN8pGe3WzOhXalySbjzLX4w13252no5910p9bM4YqMIZ6Mxy0SWSNxLdiPVjBq88tHrGPWM5v127LfCbjeVC792SMrMnnK2I9jWe9GN42wPlo/CN5LwrbXMIoBOkORQvx5G08raBTFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IcvPJA24; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IcvPJA24"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772180728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/Fh2/7Q0VX79mlypXDHnI3a7+14V5syTjjpTGCvuVa4=;
	b=IcvPJA24/9jlgo7Uw3jyIifVUosaZjtcr0pXQeGxA6neTlsjKEjYTgp2espzJkiyEGFCnf
	FD/55aEDLWQJLTo4ZnyD+ImSDybUnS+ogSP4ChyW6juEaRas1hhf6Jgljtf6BnBmuJW6Qv
	Of1mjxhHqkPFTCh7kB1dUSDBlEX4HrQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-U7gNmmNNO8W1zaIhia_HBQ-1; Fri,
 27 Feb 2026 03:25:21 -0500
X-MC-Unique: U7gNmmNNO8W1zaIhia_HBQ-1
X-Mimecast-MFC-AGG-ID: U7gNmmNNO8W1zaIhia_HBQ_1772180719
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E402018002C3;
	Fri, 27 Feb 2026 08:25:18 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.44.32.91])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 652701800370;
	Fri, 27 Feb 2026 08:25:13 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Joe Perches <joe@perches.com>,
	Viktor Malik <vmalik@redhat.com>,
	Paul Mackerras <paulus@ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] powerpc, perf: Check that current->mm is alive before getting user callchain
Date: Fri, 27 Feb 2026 09:25:02 +0100
Message-ID: <20260227082502.1882395-1-vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

It may happen that mm is already released, which leads to kernel panic.
This adds the NULL check for current->mm, similarly to 20afc60f892d
("x86, perf: Check that current->mm is alive before getting user
callchain").

I was getting this panic when running a profiling BPF program
(profile.py from bcc-tools):

    [26215.051935] Kernel attempted to read user page (588) - exploit attempt? (uid: 0)
    [26215.051950] BUG: Kernel NULL pointer dereference on read at 0x00000588
    [26215.051952] Faulting instruction address: 0xc00000000020fac0
    [26215.051957] Oops: Kernel access of bad area, sig: 11 [#1]
    [...]
    [26215.052049] Call Trace:
    [26215.052050] [c000000061da6d30] [c00000000020fc10] perf_callchain_user_64+0x2d0/0x490 (unreliable)
    [26215.052054] [c000000061da6dc0] [c00000000020f92c] perf_callchain_user+0x1c/0x30
    [26215.052057] [c000000061da6de0] [c0000000005ab2a0] get_perf_callchain+0x100/0x360
    [26215.052063] [c000000061da6e70] [c000000000573bc8] bpf_get_stackid+0x88/0xf0
    [26215.052067] [c000000061da6ea0] [c008000000042258] bpf_prog_16d4ab9ab662f669_do_perf_event+0xf8/0x274
    [...]

Fixes: 20002ded4d93 ("perf_counter: powerpc: Add callchain support")
Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 arch/powerpc/perf/callchain_32.c | 3 +++
 arch/powerpc/perf/callchain_64.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/powerpc/perf/callchain_32.c b/arch/powerpc/perf/callchain_32.c
index ddcc2d8aa64a..b46e21679566 100644
--- a/arch/powerpc/perf/callchain_32.c
+++ b/arch/powerpc/perf/callchain_32.c
@@ -144,6 +144,9 @@ void perf_callchain_user_32(struct perf_callchain_entry_ctx *entry,
 	sp = regs->gpr[1];
 	perf_callchain_store(entry, next_ip);
 
+	if (!current->mm)
+		return;
+
 	while (entry->nr < entry->max_stack) {
 		fp = (unsigned int __user *) (unsigned long) sp;
 		if (invalid_user_sp(sp) || read_user_stack_32(fp, &next_sp))
diff --git a/arch/powerpc/perf/callchain_64.c b/arch/powerpc/perf/callchain_64.c
index 115d1c105e8a..eaaadd6fa81b 100644
--- a/arch/powerpc/perf/callchain_64.c
+++ b/arch/powerpc/perf/callchain_64.c
@@ -79,6 +79,9 @@ void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry,
 	sp = regs->gpr[1];
 	perf_callchain_store(entry, next_ip);
 
+	if (!current->mm)
+		return;
+
 	while (entry->nr < entry->max_stack) {
 		fp = (unsigned long __user *) sp;
 		if (invalid_user_sp(sp) || read_user_stack_64(fp, &next_sp))
-- 
2.53.0

