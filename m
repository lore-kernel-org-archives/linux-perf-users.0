Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F44E30103F
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Nov 2025 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762706213; cv=none; b=hcUXvMtcXbNfpVDKv1kfidThSzG0QmHyqg+3PnDbpFe4lPhr2yOMI8PiZ+Yk4Cgz4rrQLQqwma2306hHL8Dam42bBsFDfjRXuY0rCMwUmYdjoXzgb03H2b4swRoEa8KVI9jCqqErkjsFxYJaesqs1n7Czoi8yQFzDZLIf1AEr5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762706213; c=relaxed/simple;
	bh=zMlAgK7Vfadh2JGekv30Yi3HICQKbllq6IxAioW86y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6r/aI7WlHpIqzo3KigtVV8ePaMmTwqdef5k+k/N3JwhHaSlsom2kaagXKCqcISxUUFWJn4lroyX4fe4q87WB5XcGBoSG0EnoQlCbbWpWggjCufePF3WzBnK9SJXer/SUctrrbV3CPqQO0qhhyQtJuS73Bg7BmJoAFdDL2Gj+HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZjgQ5Bhx; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZjgQ5Bhx"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762706209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5VAP3oB7GpBydxTF8/qJglhhf0NNtnfVJXegyQuiKgU=;
	b=ZjgQ5BhxFucJEi1DMFumNdX6jv1H42gt1f0a+84UtwSVFkPt/iBQjj4bGfwmj7LtoDI8kj
	W5xjz0CYwmOGcypnCZ/TbSodB7A5OjbwEYntS2Qhptp9SmZvZLlfqAiF2lPut9Yofb9TmT
	HJ/wb9HsLzGVXp5Yd8jQ4iHZmx2D9BU=
From: Tao Chen <chen.dylane@linux.dev>
To: peterz@infradead.org,
	mingo@redhat.com,
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
	bpf@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v5 2/3] perf: Add atomic operation in get_recursion_context
Date: Mon, 10 Nov 2025 00:35:58 +0800
Message-ID: <20251109163559.4102849-3-chen.dylane@linux.dev>
In-Reply-To: <20251109163559.4102849-1-chen.dylane@linux.dev>
References: <20251109163559.4102849-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From BPF side, preemption usually is enabled. Yonghong said, it is
possible that both tasks (at process level) may reach right before
"recursion[rctx]++;". In such cases, both tasks will be able to get
buffer and this is not right.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/events/internal.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index d9cc5708309..684bde972ba 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -214,12 +214,9 @@ static inline int get_recursion_context(u8 *recursion)
 {
 	unsigned char rctx = interrupt_context_level();
 
-	if (recursion[rctx])
+	if (cmpxchg(&recursion[rctx], 0, 1) != 0)
 		return -1;
 
-	recursion[rctx]++;
-	barrier();
-
 	return rctx;
 }
 
-- 
2.48.1

