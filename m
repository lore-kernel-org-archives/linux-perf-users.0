Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5EF76410;
	Fri, 16 May 2025 13:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747403044; cv=none; b=pxzIOTkQYu3H4c2Sbl69pSAag16Zd1QPLIzOsMarsaql+2YPNa7kzcATGgvgkDH1egK0A1Jf7rlR4wLakgKjM5fXJmjWXLeZsWbR0+iYAcc4nGjDLRBD7lwBGrAEdRBhOM3bikYMugrY47owLWyfkD9Mo8DIcrw+0Khb/0L7rqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747403044; c=relaxed/simple;
	bh=LGjIHSIG+XagOZzQXytTkKRnm7d4FWeI4xnR8vvYEfU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QQw6XFrRUKIVrAV5vWCGYfNr5uuMqyrua5/WVZbfRll/y33fjAI7Wo8hHb5ZyvB4oHBo5J467rZASS8ykmvmvySYt87gCnZrPc9/2V8WmZykws79axas04xEFWjgtz/0WKgbltIHmc8vImx7gsBWp8LIIpXwubGBzULUHFqGSjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o9opEJAT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ACEKClsL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o9opEJAT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ACEKClsL"
Date: Fri, 16 May 2025 13:43:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747403040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vnBoKr5uj3m1kFiIwkCWqj0I87Ub0/GDTZtCjUbg5Ig=;
	b=o9opEJATUWMvLyKcLommtovUUUloBKDSDgdQ4YD3KB61ceWlU+WD52L4mLVclI5N+gQ2E5
	5Ct+Mkydkp3xfoy5c7WdFM2zy4IBkahjlfhxqMUURTzpv00dOqXEljUKmtQ5d157Lk/vOT
	qvqgft/rqyUw+Oi/ayWu7a02OlkxD4N4awJXOPXxFuSnZak72USqLPZ3KZewk11WH+q8/n
	Fr8u/inQkE+Heq1iRxPgdX+t5rCosqyiYUpNv2bOwlKNCWvl6Qf4ytvFWdwOC7VEE+VQ1g
	McJzCYLJYdDq9ILPZ3tdkCC4ZByrRIT6nA6gulZsXctZAoqkS1RT5/s8QH3SNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747403040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vnBoKr5uj3m1kFiIwkCWqj0I87Ub0/GDTZtCjUbg5Ig=;
	b=ACEKClsLOAA5JEnWcuFhXwnjk+5RoWCPeLJ2rGJoPURpZvcquDjxpL5eH4zmEi71+UJilJ
	OIQJkIUnHn4CySDg==
From: "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/amd/core: Fix Family 17h+ instruction
 cache events
Cc: Sandipan Das <sandipan.das@amd.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C2f475a1ba4b240111e69644fc2d5bf93b2e39c99=2E17466?=
 =?utf-8?q?18724=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C2f475a1ba4b240111e69644fc2d5bf93b2e39c99=2E174661?=
 =?utf-8?q?8724=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174740303900.406.5499797802401271693.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     ebe176981c14b5f6472718f9894db35816749120
Gitweb:        https://git.kernel.org/tip/ebe176981c14b5f6472718f9894db35816749120
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Wed, 07 May 2025 17:42:04 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 16 May 2025 15:32:59 +02:00

perf/x86/amd/core: Fix Family 17h+ instruction cache events

PMCx080 and PMCx081 report incorrect IC accesses and misses respectively
for all Family 17h and later processors. PMCx060 unit mask 0x10 replaces
PMCx081 for counting IC misses but there is no suitable replacement for
counting IC accesses.

Fixes: 0e3b74e26280 ("perf/x86/amd: Update generic hardware cache events for Family 17h")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org
Link: https://lore.kernel.org/r/2f475a1ba4b240111e69644fc2d5bf93b2e39c99.1746618724.git.sandipan.das@amd.com
---
 arch/x86/events/amd/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 30d6ceb..52860b9 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -148,8 +148,8 @@ static __initconst const u64 amd_hw_cache_event_ids_f17h
 },
 [C(L1I)] = {
 	[C(OP_READ)] = {
-		[C(RESULT_ACCESS)] = 0x0080, /* Instruction cache fetches  */
-		[C(RESULT_MISS)]   = 0x0081, /* Instruction cache misses   */
+		[C(RESULT_ACCESS)] = 0,
+		[C(RESULT_MISS)]   = 0x1060, /* L2$ access from IC Miss */
 	},
 	[C(OP_WRITE)] = {
 		[C(RESULT_ACCESS)] = -1,
