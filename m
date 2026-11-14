Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794681435;
	b=dPGxjamo7JP9rKUaaiTR6tOQr4ZnkSzmFaRdtbJXUgF2eL7s5IBDZ5HObv3ETCkTm1i/
	 Qn3rg87zCUDab657Rw78hMu83hxapSSv86CMztjxAVP8fdYykH/lHT7UBzDm1Li+5Flr5
	 V74pey7pwD3x4IggYhLjQr8LXcQaVZIrn17Pq+yuFNiKNtkmb/62YhkZzR1ejGH5vv0Pj
	 7Y99ih9yhrODXWZejKFK0tM6MlnTjFD8yqUBxCgYP01HA0jFH/xdbc8aG0cyZAXplvoWY
	 RELI6UhBR2xCfktTZJv/2WBv//s20qLh2mDr54ceTLXNHHoJodWvyeF0/nvFEbYqBPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794681435;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YNRuToFUeGHPxRj+HMczn81mWAlaDf7PyxvvQ6u9+9c=;
	b=qbkgxtU/tD2l4r1rvQ2bljOa2y/DzeoAZ93SfU/MIrLZN5SsDoEAtCgQ/2PfXTEiA9Cn
	 BKXoF2K5wrQQhkt5NnPB0kCro+5LJ/om+FAKLz7LE4Hhy0EyZIgMDuvG4/apMr8atidXQ
	 R6uoTOsHW5dKJvNP9PYUafW506A3sjWJlxffV/kzUXNBNgMy3+4770gYBa8s6jXN/qItj
	 SCQvW9B/gJwBqXTwFa0h1La7ZKqEjuNzdtcYmdL0t54/F7865rxUCEuifn+/83bFy5IsG
	 63D+v0tsxkrGkRUjKzF4uwXYzWGUVjaFm+2FjLAIxNuM85du2a95OtK5kdnydiOzjmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QMnxCdn3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC18606A330
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 18:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QMnxCdn3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113B31F000C4;
	Sat, 14 Nov 2026 18:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794681435;
	bh=YNRuToFUeGHPxRj+HMczn81mWAlaDf7PyxvvQ6u9+9c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QMnxCdn3zsBUfpCHZgzNBOBQLjovcdlsomABVYaAbl0lwsLclpKxkBzJj4aLBt7Yj
	 25b/uKpE9NnyhIK4a0RK/UVw5GqXlvJ0UR3tWI3/so+f1rL5/zq/2VZ9lBxyiZEhfH
	 TcVvV9oZq6CFSUunV1I6Eo3CREP5E1ppRzV+07AGTA6zZvfuyuW6zV3K2Cv1oUoz5V
	 c482/0YFicUsdnuicxN8PQLtN/eikOCn2QDAAHCtXkGiF5JWnpVc9STwsOYdOIc4kM
	 Adb0Kn8mmN0cTB3NweUz88qTqKRBUY69J1dR5XPbgQh4o20yVeCf0MqH0G33uHT8mL
	 s7iFbpE5AW5oA==
Message-ID: <sashiko-outbox-214904@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf annotate: fix annotate crash for fused
 instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: Yao <dragonlinux@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261114183124.685561-1-dragonlinux@gmail.com>
References: <20261114183124.685561-1-dragonlinux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 18:37:14 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] perf annotate: single-word handle in Signed-off-by trailer
--

commit 209a79b063ed73e21e886fe346b1c09d14939eb2
Author: yao <dragonlinux@gmail.com>

> perf annotate: fix annotate crash for fused instructions
>
> Function is_fused tries to find the previous fused instruction with the
> current conditional jump instruction in the annotate_line list.
> disasm_line is the container of annotate_line.
> The annotate_line list uses list_head and the head is in annotated_source:
> notes->src which is not an annotate_line, so it couldn't walk without
> checking the list_head. If so it will read annoted_source neighbour memory
> mistakenly and most likely cause crash.
>
> Fix the case where current instruction is a conditional jump and it is
> the first instruction in the disassembled list, the original code will
> walk to the head and treats it as disasm_line which is not.
>
>     -------- backtrace --------
>     #0 0x564dd8d5d5cd in ui__signal_backtrace setup.c:0
>     #1 0x7f1737e3e6f0 libc.so.6[3e6f0]
>     #2 0x7f1737ec10b1 strstr-sse2-unaligned.S:41
>     #3 0x564dd8d625ef in intel__ins_is_fused annotate-x86.c:0
>     #4 0x564dd8d4bcde in annotate_browser__refresh annotate.c:0
>     #5 0x564dd8d49bd6 in __ui_browser__refresh.isra.0 browser.c:0
>     #6 0x564dd8d4a960 in ui_browser__run ??:0
>     #7 0x564dd8d4cbcf in __hist_entry__tui_annotate ??:0
>     #8 0x564dd8d50a91 in do_annotate hists.c:0
>     #9 0x564dd8d58bb1 in evsel__hists_browse hists.c:0
>     #10 0x564dd8d5a7fa in evlist__tui_browse_hists ??:0
>     #11 0x564dd8bf7a98 in cmd_report help.c:109
>     #12 0x564dd8c713e4 in handle_internal_command help.c:109
>     #13 0x564dd8bd6ac2 in main ??:0
>     #14 0x7f1737e27781 libc_start_call_main.h:83
>     #15 0x7f1737e278b9 in __libc_start_main libc-start.c:127
>     #16 0x564dd8bd7095 in _start help.c:109
>
> Fixes: 7efbcc8c075c ("perf annotate: Fix fused instr logic for assembly f=
unctions")
>
> Signed-off-by: yao <dragonlinux@gmail.com>

[Severity: High]
The Author header and Signed-off-by trailer use a single-word handle
("yao") instead of a full real human name, which does not meet the
Developer's Certificate of Origin requirements in
Documentation/process/submitting-patches.rst.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114183124.6855=
61-1-dragonlinux@gmail.com?part=3D1
