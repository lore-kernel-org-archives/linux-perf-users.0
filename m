Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554189;
	b=GDWr8j1fSWx2VPN+q7Onlz2Tgnt8J0fVatVOJ913z8CtMzvukMdv3MiTlP818rENOiM9
	 r8lLmdjw4RwXMEcc/ImZ/WFN+m+vJ1HwiUqMGzQjwRrpjrC+53LebI/XOAD4xLieylOX9
	 dpchq4yPrXUzDbFdfc/Uq1Lh13yHCTHz54bYHmSSP/z6cN3kUlkxM1yNp7etbWb/vkcd7
	 MPydSw+6DrsQwzj77j2R5zMbh8F49PQ2YWkzTVkqMr5t/w1aS9MD8Yo1SHDLGi7baO8ke
	 FBb1zn99G6HWW2+DvJ9Kjv810a+7A2jgOqnf+JxOW/jKgrN92Wl5ralOFZQw+TJKz8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554189;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ftZV1FGzI6Rq/bD5tKIyrVuBA66/zH6lfQJBVPZqDy8=;
	b=fzhv2UxNrrqOmPtoUai4URvRGvOCRCL3NMmvK1/5g8Nh4jcQ//kdP+LzFUoeE5fpAPF3
	 p2MaXdQ2FUOCB7Y9Pm0bX6iBbdh6DwfVcf7SW+tKEFo6FXaHAqROtCaGsjCktWaN1EyWb
	 gR3k2m2bl+/O3o2p5SLf1iF3HZGU/vCoofWHRygxWEuHcuse42kZIj16oSfS4IF9f20FW
	 al//7w1uSBqXXFg2TB8+A/EjvGcPCCSXmG8hKB1n+di2K8QKisVnnOntZoy6pU2SnIxGG
	 uVxMYq7EoHxJNU2FaIVXJz4uGGpuoujSde0Bx663HtCB/3PuDTrI55RclOAcDZbNpag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aeIcMqZn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AEB606A31E;
	Tue, 24 Nov 2026 21:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aeIcMqZn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225E31F000C6;
	Tue, 24 Nov 2026 21:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795554189;
	bh=ftZV1FGzI6Rq/bD5tKIyrVuBA66/zH6lfQJBVPZqDy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aeIcMqZnVRcPW7B8Ciq1HD6e62S8VDEs4RiM+PfLpr265eDow7z+F1S0Z2FnjFgV9
	 zo+Oz3HokP7cN1TCVzBOU2XZ6qjpZh9+Wp7AWHuqu6x1pRQoSI7O/86pRIHy7J47f7
	 rQdJ1fz7lmrgpDoHJWrjlJurkEFs6z7X0Ed4UFwCQkLGP1+MEiNe/ykYW4hqdb7cqj
	 kf/WzF0PvKHM8bCoX4WowVfr/Xy+F7W+5W0ienlj89iQqDkczUQImePdFa5cpoF/Ud
	 5alD7/VHxnSa1ITuxVmOVoUjezCApcE3/1ayhHGsWJd/IgZCFuA3EvARbtb2ZlZQ3x
	 1Q9zQg62E/3iw==
Date: Tue, 24 Nov 2026 13:03:07 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Yao Zhao <dragonlinux@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Jin Yao <yao.jin@linux.intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] perf annotate: fix annotate crash for fused
 instructions
Message-ID: <awX7ix4V3NZocdTp@google.com>
References: <sashiko-outbox-214904@kernel.org>
 <20261116165438.694835-1-dragonlinux@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261116165438.694835-1-dragonlinux@gmail.com>

On Mon, Nov 16, 2026 at 11:54:36AM -0500, Yao Zhao wrote:
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
> Fixes: 7efbcc8c075c ("perf annotate: Fix fused instr logic for assembly functions")
> 
> Signed-off-by: Yao Zhao <dragonlinux@gmail.com>

Applied to perf-tools-next, thanks!

Best regards
Namhyung
