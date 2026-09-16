Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA72369D51;
	Wed, 16 Sep 2026 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789564721; cv=none; b=m5styJZ2kKwqcHVeUop+spgYz7wEvmt/G3MCvnlqHfulKGUPpYj8mdTglZS5RadoyQMyygx9YiSPYN86nTiYdr458aB+cD4FfHms6Hu1+QPF5JL/4cIeauTa1rCeeNJ43QE97CyN+cBzYNs/a0NR10yR+5FXI/p+Lxl62S7f73w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789564721; c=relaxed/simple;
	bh=u964tg7OvajdRHhf7gm5m4qrsdY5LxjCk55lGTKw3Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/kR7puXxUgq5Y68b+1X48WANgz+jKoyV+nXM+TZvfuAmM8JAHZT5KK0EgzMwLjKnoA6Ay8ct9ivEV1N6Z3TWc9SpXV9KzyVXfGbcZd7Tn09FnK+qdLDg8AV1wXxAYbtv9lXpF8XefYhe+X97VhNgNvbFlWyD4JMjtD5QVltBNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GcQM445q; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GcQM445q"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789564706; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vJhgkEYCWLxRsmvM0AaXxfQRBNKcEoqr8KBoPj1YNfE=;
	b=GcQM445qV8b2nSRN3dQdPT3vb206ecxNCnNtxIsGzv6ty6fuVLUDQ+O6xBjbfQ6aUl/Fh0jpFFgfG3hcaAhGzARIPIkuPKfaewN5obkn8okwORsgLcA+IsmUEqJblFP4G3ggm/ec2gentFY84RAgs4P1Hs2scGvpXC7wythVG40=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0XB56FNn_1789564703;
Received: from 30.221.133.171(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XB56FNn_1789564703 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Sep 2026 21:18:24 +0800
Message-ID: <16657cb9-eb83-4279-9f3a-46789c5cb8ef@linux.alibaba.com>
Date: Wed, 16 Sep 2026 21:18:23 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd: Move NMI latency window to last-resort
 suppression
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
 tglx@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 seanjc@google.com, kai.huang@intel.com, radu@rendec.net, x86@kernel.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260916065723.1976131-1-guanghuifeng@linux.alibaba.com>
 <20260916093217.GH4121339@noisy.programming.kicks-ass.net>
From: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <20260916093217.GH4121339@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

You are right — v1 as posted does re-introduce that problem. The perf
handler returning NMI_DONE unconditionally means every latent/spurious
NMI falls through to the reason port path (raw_spin_trylock on
nmi_reason_lock + inb 0x61), which is exactly what df4d29732fda was
designed to avoid.

v2 takes a different approach: consult the latency window in
default_do_nmi() before the reason port read, not after. When the
window is open, the expensive I/O and the global lock are skipped —
identical to the upstream behaviour. The difference is that the
dispatch path does NOT take the "handled" short-circuit exit; instead
it continues into unknown_nmi_error(), which gives NMI_UNKNOWN
handlers (hpwdt, etc.) a chance to identify the NMI.

The cost breakdown per spurious NMI within the window:

upstream (v0): perf claims → goto out
cost: ~10ns (time_after check only)

v1 (broken): perf NMI_DONE → trylock + inb(0x61) → ... → suppress
cost: ~600-1500ns (I/O + lock contention)

v2: perf NMI_DONE → window check → skip reason port
→ nmi_handle(NMI_UNKNOWN) → suppress
cost: ~60-110ns (list traversal, no I/O, no lock)

The only additional work compared to upstream is traversing the
NMI_UNKNOWN handler list. On a typical system that is 1-2 handlers
doing a quick per-CPU variable check each. No I/O port access, no
global lock, no cross-CPU cache line bouncing.

The SERR#/IOCHK# trade-off is unchanged from upstream: when the window
is open, the reason port is not read. This was already the case with
the original mitigation (perf claiming the NMI skips everything after
it). v2 does not make this worse.

v2 will follow as a separate posting. Key changes from v1:
·Add perf_nmi_window_active() check in default_do_nmi() between
the NMI_LOCAL return and the reason port block. The entire reason
port section (trylock, get_nmi_reason, SERR/IOCHK dispatch,
reassert_nmi, unlock) is wrapped in if (!perf_nmi_window_active()).

·Guard perf_nmi_window_active() with "if (!perf_nmi_window) return
false" so that on non-AMD platforms (where amd_core_pmu_init()
never runs and perf_nmi_window stays 0) the strong symbol cannot
accidentally suppress NMIs due to a zero-initialized
perf_nmi_tstamp.

·Initialize per-CPU perf_nmi_tstamp to (jiffies - 1) in
amd_core_pmu_init() so the window starts definitively closed.
Without this, on 32-bit kernels where INITIAL_JIFFIES places
jiffies near the 32-bit wrap point, time_after(jiffies, 0)
evaluates to false for the first 5 minutes of uptime, falsely
indicating an open window.


Thanks


在 2026/9/16 17:32, Peter Zijlstra 写道:
> On Wed, Sep 16, 2026 at 02:57:23PM +0800, Guanghui Feng wrote:
>> The upstream amd_pmu_adjust_nmi_window() mitigation claims every NMI
>> that arrives within a 100ms window opened after a PMC overflow. When no
>> counter overflowed, the handler still returns NMI_HANDLED, which makes
>> the NMI dispatch path take its "handled" exit. Everything that comes
>> after the perf handler is then skipped: the NMI reason port, which may
>> hold a latched SERR#/IOCHK# error, and all NMI_UNKNOWN handlers, such
>> as hpwdt. As a result unrelated NMIs are silently dropped for the whole
>> duration of the window.
>>
>> Stop claiming NMIs from within the perf handler. When no counter
>> overflowed there is nothing to claim, so always report NMI_DONE and let
>> the remaining NMI sources be probed first. Defer the window check to the
>> very end of the dispatch path, where it is used only as a last resort.
>>
>> Introduce perf_nmi_window_active(), which reports whether the latency
>> window opened by the last PMC overflow on this CPU is still open. It is
>> called from unknown_nmi_error() only after all NMI_LOCAL handlers, the
>> reason port and all NMI_UNKNOWN handlers failed to identify the NMI.
>> Only then is the bogus "unknown NMI" report suppressed. A __weak
>> fallback in arch/x86/kernel/nmi.c always returns false, so non-AMD
>> platforms are unaffected.
>>
>> nmi_stats.unknown is still incremented before the suppression, so the
>> dropped NMIs remain observable through debugfs.
> 
> So the point was that AMD hardware was generating these 'spurious' PMIs
> quite frequently, and hitting the reason port at any frequency from
> multiple CPUs is a massive performance problem.
> 
> How are you not re-introducing that?

