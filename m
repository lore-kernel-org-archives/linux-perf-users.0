Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0635B1C36;
	Thu,  2 Jan 2025 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735851537; cv=none; b=QXuJeTY3eGlDWBa2tglxoL4EtkkIkD8DF39XtBQQnfSArpOeAFXJ09DgiEbIHNsLNwbD24/TOkJDNbClLhHRHK403Qp5apEONCoQ/ahEK4O6AGRuhATCFkODNnpPklhtmcgEBMJIOg7yV6/Q5Eh/C/R0mfaXMQBBmLAuuskrgPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735851537; c=relaxed/simple;
	bh=UIHYLslxIdCVSwpOvRPX+1nJJ/5QCQZAwhmkU03M8Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCQ2ulY/mARwl+P8LMJ6tBQ1/hDja9z0DMqUZKq1Phv8E/K54t5SD2jDAU/XeiuJvCReELDuiwxqKBwYMPByO+Hlu46Zl+2Iaz2PfFOpMZntHxEjuCy9spG9qLcO8u3f/0IJT93dsskrtM+Eksm+7fIk8yHUwWlMUJQBK3Af7Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZ5N+aPQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZ5N+aPQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282A3C4CED0;
	Thu,  2 Jan 2025 20:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735851536;
	bh=UIHYLslxIdCVSwpOvRPX+1nJJ/5QCQZAwhmkU03M8Yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nZ5N+aPQ0w07tRMb/4AyZya2JyQ3xaYPGqig4IF6eGQ+NHvRnFQPw2th7kBXMIIsz
	 ByBY/4fI7mE7/VXbML7V+7kMbTGUjUj3379rxu+EEKDgsQPIHYa1guucv3LPQIHx21
	 UX3Zh0MWvHrpvN4QYpULS3tDH/+bMmTiBBgRIdpLn+vPb9hoHWNHFH47hXjqhnbO3y
	 LgpXNRr8nRqjN+fWFG7SdaSC7IT6WRru4ePjkSIxUzNVv9o0DXDbmElpOa1QFYcDum
	 WVB/R5+wpirnBUy19GEbTlWuU57gx5SJ/j8o3xPP1acIpuaJHOALr2zZ9/D7K6KevW
	 BIpO9m0AFGtsw==
Date: Thu, 2 Jan 2025 12:58:54 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [BUG] perf top reports not being able to resolve kernel symbols
Message-ID: <Z3b-DqBMnNb4ucEm@google.com>
References: <Z3bd2uCdo2EAMSnG@x1>
 <Z3boDyuus0fiGcok@x1>
 <Z3buKhcCsZi3_aGb@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z3buKhcCsZi3_aGb@x1>

Hi Arnaldo,

On Thu, Jan 02, 2025 at 04:51:06PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Jan 02, 2025 at 04:25:07PM -0300, Arnaldo Carvalho de Melo wrote:
> > root@number:~# readelf -sw /lib/modules/6.13.0-rc2/build/vmlinux | grep -B5 -A5 ' 0000000001600'
> > 259227: ffffffff8156e290   262 FUNC    GLOBAL DEFAULT    1 zs_free
> > 259228: ffffffff8183a4d0   269 FUNC    GLOBAL DEFAULT    1 security_inode_g[...]
> > 259229: ffffffff81c8d900   191 FUNC    GLOBAL DEFAULT    1 devres_find
> > 259230: ffffffff812e11c0    16 FUNC    GLOBAL DEFAULT    1 __pfx___probestu[...]
> > 259231: ffffffff81c985a0    16 FUNC    GLOBAL DEFAULT    1 __pfx_pm_qos_sys[...]
> > 259232: 0000000001600000     0 NOTYPE  GLOBAL DEFAULT  ABS text_size
> > 259233: ffffffff81487f10   117 FUNC    GLOBAL DEFAULT    1 shmem_read_folio_gfp
> > 259234: ffffffff81e08540   155 FUNC    GLOBAL DEFAULT    1 __traceiter_smbu[...]
> > 259235: ffffffff811e13a0    16 FUNC    GLOBAL DEFAULT    1 __pfx_thaw_workqueues
> > 259236: ffffffff81b04c70   599 FUNC    GLOBAL DEFAULT    1 acpi_install_method
> > 259237: ffffffff81de7d40    16 FUNC    GLOBAL DEFAULT    1 __pfx_psmouse_se[...]
> > root@number:~#
>  
> > There it is, that "text_size" symbol stayed with with a prev->end equal
> > to prev->start and thus 0x00000000016001c1 stops being resolved, which
> > leads us to get to that buggy warning.
>  
> > I'll put all this into a patch and send it for review,
> 
> But looking further, where do those 0x00000000016001c1 addresses coming
> from?
> 
> (gdb) p /x sample->ip
> $10 = 0xffffffffb7401fad
> (gdb) p /x al->addr
> $11 = 0x1601fad
> (gdb) bt
> #0  perf_event__process_sample (tool=0x7fffffff9bd0, event=0x1017400, evsel=0xf68860, sample=0x7fff8dffa470, machine=0xf8e818) at builtin-top.c:813
> #1  0x0000000000447c5c in deliver_event (qe=0x7fffffff9ee8, qevent=0x1024670) at builtin-top.c:1213
> #2  0x0000000000642706 in do_flush (oe=0x7fffffff9ee8, show_progress=false) at util/ordered-events.c:245
> #3  0x0000000000642a5d in __ordered_events__flush (oe=0x7fffffff9ee8, how=OE_FLUSH__TOP, timestamp=0) at util/ordered-events.c:324
> #4  0x0000000000642b47 in ordered_events__flush (oe=0x7fffffff9ee8, how=OE_FLUSH__TOP) at util/ordered-events.c:342
> #5  0x00000000004477e9 in process_thread (arg=0x7fffffff9bd0) at builtin-top.c:1125
> #6  0x00007ffff6ea5d97 in start_thread () from /lib64/libc.so.6
> #7  0x00007ffff6f29c8c in clone3 () from /lib64/libc.so.6
> (gdb)
> 
> root@number:~# grep ffffffffb7401f /proc/kallsyms 
> ffffffffb7401f09 t repeat_nmi
> ffffffffb7401f2e t end_repeat_nmi
> ffffffffb7401f81 t nmi_no_fsgsbase
> ffffffffb7401f85 t nmi_swapgs
> ffffffffb7401f88 t nmi_restore
> ffffffffb7401fb0 T entry_SYSCALL32_ignore
> ffffffffb7401fd0 T __pfx_clear_bhb_loop
> ffffffffb7401fe0 T clear_bhb_loop
> root@number:~# 
> 
> Looks like nmi_restore...
> 
> Which is...
> 
>    780: ffffffff82401ee8     0 NOTYPE  LOCAL  DEFAULT    1 nested_nmi_out
>    781: ffffffff82401ed0     0 NOTYPE  LOCAL  DEFAULT    1 nested_nmi
>    782: ffffffff82401eeb     0 NOTYPE  LOCAL  DEFAULT    1 first_nmi
>    783: ffffffff82401f81     0 NOTYPE  LOCAL  DEFAULT    1 nmi_no_fsgsbase
>    784: ffffffff82401f88     0 NOTYPE  LOCAL  DEFAULT    1 nmi_restore
>    785: ffffffff82401f85     0 NOTYPE  LOCAL  DEFAULT    1 nmi_swapgs
>    786: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS syscall_64.c
>    787: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS common.c
>    788: ffffffff810cc2b0    16 FUNC    LOCAL  DEFAULT    1 ia32_emulation_o[...]
>    789: ffffffff821e57f0   241 FUNC    LOCAL  DEFAULT    1 __do_fast_syscall_32
> 
> So there are symbols that are not being resolved anymore that were
> before your patch, namely:
> 
> arch/x86/entry/entry_64.S
> 
> nmi_no_fsgsbase:
>         /* EBX == 0 -> invoke SWAPGS */
>         testl   %ebx, %ebx
>         jnz     nmi_restore
> 
> nmi_swapgs:
>         swapgs
> 
> nmi_restore:
>         POP_REGS
> 

Sorry about that, maybe I should've done this instead.  Can you check
if it works correctly?

Thanks,
Namhyung

---8<---

From 3130ee711d28f6e280d4bf04bdacca094657bb99 Mon Sep 17 00:00:00 2001
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 2 Jan 2025 12:32:51 -0800
Subject: [PATCH] perf symbol: Prefer non-label symbols with same address

When there are more than one symbols at the same address, it needs to
choose which one is better.  In choose_best_symbol() it didn't check the
type of symbols.  It's possible to have labels in other symbols and in
that case, it would be better to pick the actual symbol over the labels.
To minimize the possible impact on other symbols, I only check NOTYPE
symbols specifically.

  $ readelf -sW vmlinux | grep -e __do_softirq -e __softirqentry_text_start
  105089: ffffffff82000000   814 FUNC    GLOBAL DEFAULT    1 __do_softirq
  111954: ffffffff82000000     0 NOTYPE  GLOBAL DEFAULT    1 __softirqentry_text_start

The commit 77b004f4c5c3c90b tried to do the same by not giving the size
to the label symbols but it seems there's some label-only symbols in asm
code.  Let's restore the original code and choose the right symbol using
type of the symbols.

Fixes: 77b004f4c5c3c90b ("perf symbol: Do not fixup end address of labels")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 0037f11639195dbf..49b08adc6ee34365 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -154,6 +154,13 @@ static int choose_best_symbol(struct symbol *syma, struct symbol *symb)
 	else if ((a == 0) && (b > 0))
 		return SYMBOL_B;
 
+	if (syma->type != symb->type) {
+		if (syma->type == STT_NOTYPE)
+			return SYMBOL_B;
+		if (symb->type == STT_NOTYPE)
+			return SYMBOL_A;
+	}
+
 	/* Prefer a non weak symbol over a weak one */
 	a = syma->binding == STB_WEAK;
 	b = symb->binding == STB_WEAK;
@@ -257,7 +264,7 @@ void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms)
 		 * like in:
 		 *   ffffffffc1937000 T hdmi_driver_init  [snd_hda_codec_hdmi]
 		 */
-		if (prev->end == prev->start && prev->type != STT_NOTYPE) {
+		if (prev->end == prev->start) {
 			const char *prev_mod;
 			const char *curr_mod;
 
-- 
2.47.1.613.gc27f4b7a9f-goog

