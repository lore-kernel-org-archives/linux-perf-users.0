Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F51187346
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 04:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783486611; cv=none; b=ZjzR8RDFzog+4TT0b2T34NYtc4bPoOHdtWY1Kb+5UcvvjSZ107EoSstTPrw5FvKi988D9Px8mtFX6z+3Ol1qiZV6jV0A60qMFfK1wUt3UzotaQ6KnRVT9e7Bk2HLI9OjrBa/pPoEvdlUaR5hLebInrch6V/d2g+f0+yfJkaP7P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783486611; c=relaxed/simple;
	bh=CUfN0bFl2Zvp9IrBajxsRt/TgANcKTQh8m/9eQmpinQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QlKy97fcykNeBNx/fPuKtPs8FZ3byTyWWj8Q52uZtf84tix4zCYzSD2zzyJVzO7oSSvSIhW6kV24z+2QpEnvac2dHj4r5kt/9agCj0l1dsT5/zJ+cY53hEbhPgAJhJYeNLw91x9ng0W+I70Qdz8EJZJVm9qqbkRIMS2BmHWcG98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L5NXGDmL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5NXGDmL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783486609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PB/gGCaLeqjcMDaBfkThoG37D339GATgqjTdiU7aoOU=;
	b=L5NXGDmL2qbynT5/ASlJE+h6A8XnO+mX4R+ASMa8kKayyaauY169egXVkHpZTqiPGfR0um
	EEWz/nsPT3QSLlMfft63YlOaKdiJKFlR7JZBLobLnkOzhzfZjRoXFYa+22Jdlyihu7ZFC2
	y9XHaB5i4zHXPJEaI2Nu4Mg/KVgVyj0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-zBjz_oHANNCE9l8RRrZm4Q-1; Wed,
 08 Jul 2026 00:56:46 -0400
X-MC-Unique: zBjz_oHANNCE9l8RRrZm4Q-1
X-Mimecast-MFC-AGG-ID: zBjz_oHANNCE9l8RRrZm4Q_1783486595
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B37C18005A2;
	Wed,  8 Jul 2026 04:56:32 +0000 (UTC)
Received: from tallison-mac.redhat.com (unknown [10.22.81.130])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A5621800664;
	Wed,  8 Jul 2026 04:56:29 +0000 (UTC)
From: Trevor Allison <tallison@redhat.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	tallison@redhat.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] perf: Fix missing CET property notes on x86 with -fcf-protection
Date: Wed,  8 Jul 2026 00:56:03 -0400
Message-ID: <20260708045606.43649-1-tallison@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

When perf is built with -fcf-protection, the x86 binary can lack CET
(IBT/SHSTK) in .note.gnu.property because perf links several static
archives whole-archive: if any input object lacks matching property
notes, the linker drops CET from the final binary.

Fix libbpf EXTRA_CFLAGS handling, C++ flag propagation, and missing
.note.gnu.property sections in x86 assembly (like .note.GNU-stack).
All three are needed for CET to survive the link.

Trevor Allison (3):
  perf build: Preserve EXTRA_CFLAGS when building in-tree libbpf
  perf build: Apply EXTRA_CXXFLAGS to C++ builds
  perf x86: Add .note.gnu.property to assembly linked into perf

 tools/perf/Makefile.config               |  1 +
 tools/perf/Makefile.perf                 |  2 +-
 tools/perf/arch/x86/tests/regs_load.S    | 24 ++++++++++++++++++++++++
 tools/perf/bench/mem-memcpy-x86-64-asm.S | 24 ++++++++++++++++++++++++
 tools/perf/bench/mem-memset-x86-64-asm.S | 24 ++++++++++++++++++++++++
 5 files changed, 74 insertions(+), 1 deletion(-)

-- 
2.50.1 (Apple Git-155)

