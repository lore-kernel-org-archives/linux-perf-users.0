Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284D43346BA
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 22:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763592175; cv=none; b=ptANoMt7UWUCf+wL6eFPge5qLygucUwK/vkz07ve1jWNhSigKiaOeZDm5x0vUIw55IFdg8NhcCo8utF9s1/iCrXfpB8p+XUZ92pPGx7thKYyoUHDzoNaSOuLjHispXjzMB/2vLTeiereFix/1u4MKK8HI7kgINrnpnaiGzJnrw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763592175; c=relaxed/simple;
	bh=li52uobPk66+BkwIH/b8VJKjGDYh3+gh2uWOK3B772E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ftv4HB5+GLmt/5GTTguCcqDIFxhvaM9fnalzxo3C8C4rWad1zP/EHNV2Z5vKy7ndDeC1H9f+u06rZItHZjvPbJDUsDnw0tEUhisOzKCtNc13SEElVXCg7iukDOP2D7f68nowXu2WEX5mghmBYk6eQDDmAqUm23mthyE3qZmI6XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=DGUWUnvz; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="DGUWUnvz"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqt0-006kxU-Tm; Wed, 19 Nov 2025 23:42:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=N1DxFU65G+nM7q0zov0KSr3WF0ez8nK/PjfzsNDA87s=; b=DGUWUnvzyRp3eBNft6KMmq33+r
	cqzFxHUt1cMknmNzAL0QK0DdLp7DRfT/3Cj2QO9XgbvpOzu6XPMDzjz4TtMdxFGHgcmx8VPz0qUoM
	POrh0zfp3/9JbKuncjnr05y1RaYfnJ8OjYAnSj8NGE5Z3uQ2/heQ4SjGigBs6Bu+TvGbfPU2qTgHR
	UeGPfULMqTboFHcEKrSLWXXf0oBLw1+++XgdPlUii6w+jsK6ITl56xerANPGwyF+uVaWX/nOOJbJm
	5svE9KfLf7Srtp0RdeqynV4E/5FzJskMjBRlNFtoiODpcx4OMiDuQMhKc+kyt5oX9UM0ilLa72+e+
	7cF7cbYA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqt0-00086M-KX; Wed, 19 Nov 2025 23:42:50 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vLqsV-00Fos6-DY; Wed, 19 Nov 2025 23:42:19 +0100
From: david.laight.linux@gmail.com
To: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 03/44] perf: Fix branch stack callchain limit
Date: Wed, 19 Nov 2025 22:40:59 +0000
Message-Id: <20251119224140.8616-4-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251119224140.8616-1-david.laight.linux@gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

The code that bounds the brs->nr to event->attr.sample_max_stack
incorrectly masks brs->nr with 65535 before the limit check.
Replace the min_t(u16, ...) with a plain min(...).

I guess there may be another limit on brs->nr (which is u64).

Fixes: c53e14f1ea4a8 ("perf: Extend per event callchain limit to branch stack")
Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fd1d91017b99..f91c875ea311 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1430,7 +1430,7 @@ static inline void perf_sample_save_brstack(struct perf_sample_data *data,
 	if (branch_sample_hw_index(event))
 		size += sizeof(u64);
 
-	brs->nr = min_t(u16, event->attr.sample_max_stack, brs->nr);
+	brs->nr = min(event->attr.sample_max_stack, brs->nr);
 
 	size += brs->nr * sizeof(struct perf_branch_entry);
 
-- 
2.39.5

