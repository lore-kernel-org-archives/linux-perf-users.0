Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CE3448CE0;
	Tue, 18 Aug 2026 09:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046053; cv=none; b=kabI9B682UCcyRdUtymbca04TXKXvVAX3CN8MD5IHAmj2pQt4JUIrZdelCPir/QjzAvdZBOInp6qn6wCyK/T4e5WTXtSTQvoOZL9T/wQtqxVHVKzPHulLQekmKVlxYRH52gD4u4YjW5xuI4mwuYPLBCIXRonvNhhCb5C+oCXdmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046053; c=relaxed/simple;
	bh=ZODE1qCBegI3Q5ragRVRaMCdnUDgtFr0CMCcfu4VSwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y1dGGXZMx7L8EkJzHNkQOHLe2UrOSNZdzDJWxxqn9UdBXw2M5kk0UsjTXKlME9Vu3R9N5LyMlDmbU9LxBl8nLoqX1Dj+DcGn2UXnTOr91ce5g262UIll6yH9h+U10ClaoDZ55QCo/EULMfU2Pa9HZFeUgMCNjexzU7dxFLT6IsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e13ee6be9ae811f19a56ed5b684f684d-20260818
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:4c6a68f2-9465-4f0f-9c4a-102e7d6ac4fa,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:31ff8c4e659937a5770258dd3f644217,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|865|898,TC:nil,Content:0|15|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e13ee6be9ae811f19a56ed5b684f684d-20260818
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1640359094; Tue, 18 Aug 2026 17:40:42 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: pjw@kernel.org
Cc: linux-riscv@lists.infradead.org, atish.patra@linux.dev, anup@brainfault.org, will@kernel.org, mark.rutland@arm.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: Re: [PATCH v1 2/2] perf: RISC-V: store available counter mask as bitmap
Date: Tue, 18 Aug 2026 17:15:00 +0800
Message-ID: <reply.pjw.pmumask22.1787042100.git.liuxixin@kylinos.cn>
In-Reply-To: <93cab992-f808-8f3e-03a6-19d84baf38f3@kernel.org>
References: <cover.1786092600.git.liuxixin@kylinos.cn> <prpmask02cmap.1786092600.git.liuxixin@kylinos.cn> <93cab992-f808-8f3e-03a6-19d84baf38f3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py

Hi Paul,

On Fri, 7 Aug 2026, Paul Walmsley wrote:
> This patch contains several array indexes to element 0 of the cmask
> bitmap, but that element is going to be XLEN bits wide.   Does that
> actually work on RV32 systems?

I built with CONFIG_ARCH_RV32I=y and booted qemu-system-riscv32.
Probe reports 16 firmware and 18 hardware counters.  The available
bitmap is two words: 0xfffffffd then 0x7.  Three bits sit at index 32
and above.

When CFG_MATCH fails on the first word, the same call is retried with
base 32 and the second word.  That is the walk the stop-all path already
used.  Clearing the first word still issues that second call with
base 32.

I also booted qemu-system-riscv64.  Probe reports the same 16 firmware
and 18 hardware counters.  The available bitmap is one word:
0x7fffffffd.  CFG_MATCH and stop-all stay on that word.  Opening a
cycles event from userspace succeeds on both guests.

A legacy-only RV32 kernel sets cycle and instret in the bitmap.  Opening
a cycles event from userspace succeeds there too.

v2 walks every bitmap word for the remaining CFG_MATCH sites, same as
stop-all, with the counter base set to i times BITS_PER_LONG.

Thanks,
Xixin

