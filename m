Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353D923A562
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 02:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776048495; cv=none; b=VaZiGIvTXO6Ew0YQ93ll8v1FcG7ALbG+ScqHAUWe/BlMryLzg1zhsnwx5Qd94Ly3U+rUeMXClseGnz14wojxvs6t5KrgqG8tYrlrZs8mNjYy+ZakK4l3PHnIkHER/Xog+86PCDFGfOO6/N65w3rD6GLAWBRjJdHu49O3Al63mWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776048495; c=relaxed/simple;
	bh=JeSLyEyVbGrzHWl/OHpa8voq5Wa/zBgvBxLzEbB0v1I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=be9PF/XcYKM82ZCH/zb5H8XlYEByTDctoEfA6h+CKq6kKsuJf9yXoQEoHGJRqmKS/Ljkh2eXYxuaziKyaMFRU3VB7MCDncZrnN6g6/YeGur4pSoflVkmoNFNJgvlobR7+yo6a3Ns9E9NRRK9VkEvoIWJdgHyyYc4BQBcsuhkSUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G1XLkP+F; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G1XLkP+F"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso5601292eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 19:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776048493; x=1776653293; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4gq5oV2Uwm1Ltd6b9FECKA8ZBvmmiMQwyALIUU23nRA=;
        b=G1XLkP+Fs1DU+45y59DnETc2d5jHzCYZYmJDycqYHdHai+92m1wZH1CK6eJJLyBdK2
         mUc7OrvjWICltLJckHHsZMOwAJFy/TVVKloC3sgLfjjz2paUNdcqbL5lQLcJRwCkS+on
         +tR5epXtOueeGZPqUj8ppAUh0KoT8qAAhmOQUUvzWhl4sPB4w2yslp2FEKXKp7lEnrAs
         b+s6gm8EbUM7jGjMbKgHd3F6xiy3GbWJ5mvoJ055kzt89FHSqq61fTzOki+bQs5Itcaj
         zIKKj8lb2RdU508bZa8ZIZcAdLqpFKt/y8J0HlUXwtrH+hqDCLBzm8wIjhQdR4BG5c+F
         UJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776048493; x=1776653293;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4gq5oV2Uwm1Ltd6b9FECKA8ZBvmmiMQwyALIUU23nRA=;
        b=ePUqI5qmYesvex/pGvlupstVPkTZTq15o3SoaPzVAcfB2cNIGZ7iMMIGskGZpgUlgF
         +rLeYxlEgnvefIimoFiBqdKDVmsYR/bq2cRwaB0gCi/l8hvJu3eCyF0o/uV8rryVfcEN
         ASGUsaTSss68HzZWoiEC6wGdg8N/OosTSgCE55cCHM2XNQ0kks1zm9iurI1n7c4TJ7YQ
         7IUpUqb/ZE5UxvgKAA5cVaDvQ+vwW1jk//WA7JftKA4gJxeYFe8wFGMYvCIAvAmoleux
         dv2MNzuK7KM/Vk/Hm9v/dPcbJW2Ae7f7BgCxTc5VAFPyl6lU0jqkgf0rk0xe509AWbrG
         Gsrg==
X-Forwarded-Encrypted: i=1; AFNElJ8rxGakV/DY/MDh+Fp6CvbhYfmd0tAb238grjITxQfMPkpV+trsmWRDMoYI2ERt1Z5CInrkp26imoXEEcq609CH@vger.kernel.org
X-Gm-Message-State: AOJu0YxfmTUer6w3bJLoUMeU2jF2Rq0o+IHb2Db/j0e8ieexxHBKnQzI
	tVzYXjOJGzdXD2yCRj/A8RZxJeGdZ55WghsKV+iTitSIspppFxJ8e951jA7YPfWVUtgCinbvToU
	DOCifNlb9sQ==
X-Received: from dybmf46.prod.google.com ([2002:a05:7301:92e:b0:2d9:3c6b:a26b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6788:b0:2c4:acef:292a
 with SMTP id 5a478bee46e88-2d587d82e73mr6543730eec.12.1776048493060; Sun, 12
 Apr 2026 19:48:13 -0700 (PDT)
Date: Sun, 12 Apr 2026 19:47:59 -0700
In-Reply-To: <20260413024805.1316480-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <advv6twWCEVBo_Hc@x1> <20260413024805.1316480-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413024805.1316480-3-irogers@google.com>
Subject: [PATCH v4 2/8] perf build loongarch: Remove reference to missing file
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, andrew.jones@oss.qualcomm.com, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, howardchu95@gmail.com, 
	irogers@google.com, james.clark@linaro.org, john.g.garry@oracle.com, 
	jolsa@kernel.org, leo.yan@linux.dev, libunwind-devel@nongnu.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	mingo@redhat.com, namhyung@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, shimin.guo@skydio.com, 
	tglozar@redhat.com, tmricht@linux.ibm.com, will@kernel.org, yuzhuo@google.com
Content-Type: text/plain; charset="UTF-8"

The file was removed in commit e62fae9d9e85 ("perf unwind-libdw: Fix a
cross-arch unwinding bug") but the Build file not updated.

Fixes: e62fae9d9e85 ("perf unwind-libdw: Fix a cross-arch unwinding bug")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/loongarch/util/Build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/arch/loongarch/util/Build b/tools/perf/arch/loongarch/util/Build
index 3ad73d0289f3..8d91e78d31c9 100644
--- a/tools/perf/arch/loongarch/util/Build
+++ b/tools/perf/arch/loongarch/util/Build
@@ -1,4 +1,3 @@
 perf-util-y += header.o
 
 perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
-perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
-- 
2.53.0.1213.gd9a14994de-goog

