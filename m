Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="o3tsAP39"
X-Greylist: delayed 460 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Nov 2023 04:16:35 PST
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3BA137
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Nov 2023 04:16:35 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 42BE542118;
	Tue, 21 Nov 2023 12:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1700568533; bh=izpovA0XHb89VRrGlum7I7YsipyerFuXhLb0jEFlzB4=;
	h=Date:To:From:Subject:Cc;
	b=o3tsAP39aOWCf2InCItbLug8RNYooAAn10p4t1Uiq4fCQxp3UcnqgJoU3XuEb8frn
	 pGWdSs8OVwDZAlJy68MEs6p/W4cfxudO1LppS5ET7Nmi7uQVWSDfwk/0tu3Fec59at
	 4pN1uJ8uijvfztdmQNmWRIDctx2BtjAVN0qCpFEVbC0ISw/SCK+ctX5Jg2Aa1ma+aN
	 +I/fACBQJE5HBd+J4V1kZIfGKA9jfM0+Os9M4hlIdy68mTYe/Ti4p+rAKpdfj2MlhU
	 H3Wh+bSDZWP8qopJxkHcHkt6hf2CIFt3v5zKs1X0NAOBWHYrRwSgA6pW5AzeScdFQ4
	 lHVsG8gD6Fs7g==
Message-ID: <08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st>
Date: Tue, 21 Nov 2023 21:08:48 +0900
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-perf-users@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
From: Hector Martin <marcan@marcan.st>
Subject: [REGRESSION] Perf (userspace) broken on big.LITTLE systems since v6.5
Cc: Marc Zyngier <maz@kernel.org>, Asahi Linux <asahi@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Perf broke on all Apple ARM64 systems (tested almost everything), and
according to maz also on Juno (so, probably all big.LITTLE) since v6.5.

Test command:

sudo taskset -c 0 ./perf stat -e apple_icestorm_pmu/cycles/ -e
apple_firestorm_pmu/cycles/ -e cycles ls

Since this is taskset to CPU #0 (LITTLE core, icestorm), only events for
icestorm are expected.

I bisected the breakage to two distinct points:

5ea8f2ccffb is the first bad commit. With its parent, the output is as
expected (same as v6.4):

         3,297,462      apple_icestorm_pmu/cycles/

     <not counted>      apple_firestorm_pmu/cycles/
                       (0.00%)
     <not counted>      cycles
                       (0.00%)

With 5ea8f2ccffb everything breaks:

   <not supported>      apple_icestorm_pmu/cycles/

   <not supported>      apple_firestorm_pmu/cycles/

     <not counted>      cycles
                       (0.00%)

Somewhere along the way to 82fe2e45cdb00 things get even worse (didn't
bother bisecting this range). With its parent:

   <not supported>      apple_icestorm_pmu/cycles/

   <not supported>      apple_firestorm_pmu/cycles/

   <not supported>      apple_icestorm_pmu/cycles/

   <not supported>      apple_firestorm_pmu/cycles/

Then 82fe2e45cdb00 leads to the current v6.5 behavior:

     <not counted>      apple_icestorm_pmu/cycles/
                       (0.00%)
     <not counted>      apple_firestorm_pmu/cycles/
                       (0.00%)
     <not counted>      cycles
                       (0.00%)

If I taskset the task to CPU#2 (big core, firestorm), I get events:

         1,454,858      apple_icestorm_pmu/cycles/

         1,454,760      apple_firestorm_pmu/cycles/

         1,454,384      cycles


So the current behavior is that all output seems to come from the
firestorm PMU event counter, regardless of requested event.

This is all unchanged and still broken in v6.7-rc2.

- Hector
