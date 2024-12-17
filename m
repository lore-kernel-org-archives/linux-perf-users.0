Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD801EC017
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Dec 2024 20:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734468287; cv=none; b=ZL9HYba4UjBeNU7AaKOgNMVBDQxUcjP/ZKxX1uOV56BuRFJNFRTO29Cmdb/lqnydc+zbhgXY05wWSGMVI4fdvopKAON9xh9GJ4ZYEbhjINDPHLTMt9nNHH4DQgF7rx1ZKpewUFIdPqMGwZoQdqYv1HaTkKRSh8g1jwj4+PBd49c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734468287; c=relaxed/simple;
	bh=sEYuhrUmxdWTwXMe3OJmJrKPoDvafPRpDMo8a2TOxEM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=YC+P/XKzlU95Lx4+u2jkNe1NbZ6vnmbW2YZpzs0qkYI6/dPIgGOoFQIsQerD5KpfR+8JxXV0PkyO79Wuqn73e985mUMNkdvk4VG2VduqExNd5ypI4tF43ezrUTfTI0O2DXtg5TcnIVuwyBD0dRq09tKtju4vn2j9wQwkVZXfv7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=NzVXOB2P; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="NzVXOB2P"
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 4AF22428AF9
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Dec 2024 21:44:35 +0100 (CET)
Received: from [IPV6:2a01:e34:ec24:52e0:cf9c:36b4:9e31:5a4e] (unknown [IPv6:2a01:e34:ec24:52e0:cf9c:36b4:9e31:5a4e])
	(Authenticated sender: marc.w.gonzalez@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 780CF13F879;
	Tue, 17 Dec 2024 21:44:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1734468267;
	bh=sEYuhrUmxdWTwXMe3OJmJrKPoDvafPRpDMo8a2TOxEM=;
	h=Date:To:From:Subject:Cc:From;
	b=NzVXOB2Pfr2bbdH7hrY0dbuPEBFTcVcgnqsxXT6R2fN3KWvTnTuTn9aMBP1ZaCdcF
	 dXaTyHUJ/jhUb4Dxf1EaCAfxNowKwJ4Lqwfcyap6/wFpWa6l3NUn3GgYuigg7rY+h4
	 nh5Wk86phgPWRKNhDGwS20OQrMMoROtcCsrjQu0UVt04c+Swj3Aumoxu5sBio0FZwb
	 AhKFNldAi2HA2TQgGjLDnMmaYQfG98NfIFnXk2sIiBs4OPp5osgxSb8Sg9Iy3L/ITd
	 3ZBIKNYOA7qcz5oe4nxkLgW70zyUXHTxye5omN6bBLWU3MsPdsgmzzQOm0nXZnNd/Y
	 XzWzoXnx9D5mA==
Message-ID: <fe0d6e93-d134-4279-9739-74b4d786038e@free.fr>
Date: Tue, 17 Dec 2024 21:44:24 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-perf-users@vger.kernel.org
Content-Language: fr, en-US
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Unexpected results from perf on haswell
Cc: mccalpin@tacc.utexas.edu, agner@agner.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello everyone,

I'm running v5.15 on Haswell (i5-4590)

I've been experimenting with some micro-benchmarks, to better
understand a few limitations in an actual program of mine.

Some of the events to count stalls are returning unexpected
results (unexpected by me).

Performance counter stats for './ubench01-1G':

    69 992 394 294      cycles
   257 046 635 675      uops_executed.core
   257 046 635 675      uops_executed.core_cycles_none
        38 249 144      cycle_activity.cycles_no_execute
        38 250 365      uops_executed.stall_cycles

      19,007025539 seconds time elapsed

      18,979117000 seconds user
       0,007997000 seconds sys

'uops_executed.core_cycles_none' is defined as
"Cycles with no micro-ops executed from any thread on physical core
Spec update: HSD30, HSM31"

However, it clearly seems to be counting all cycles, not just stalled cycles.
Am I misunderstanding something?

No big deal, I can use one of the other 2 events.

'cycle_activity.cycles_no_execute'
"This event increments by 1 for every cycle where there was no execute for this thread"

'uops_executed.stall_cycles'
"Counts number of cycles no uops were dispatched to be executed on this thread
Spec update: HSD144, HSD30, HSM31"

Not sure why the 2 latter events are not equal?
(However, "within 32ppm" might be close enough to "equal")

Somewhat relevant discussion:
https://community.intel.com/t5/Software-Tuning-Performance/Counting-number-of-uops/td-p/1101619
https://www.agner.org/optimize/blog/read.php?i=452&v=t%C2%A0%C2%A0

For completeness, my micro-benchmark is:

#define LOOP_BODY \
	add %eax, %eax ;\
	add %ebx, %ebx ;\
	add %ecx, %ecx ;\
	add %edx, %edx ;\

main:
	movq $(LOOP_COUNT), %rsi
1:	UNROLL6 // 2**6 copies of LOOP_BODY
	dec %rsi
	jnz 1b


Regards

