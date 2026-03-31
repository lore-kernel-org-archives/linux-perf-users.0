Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD72A405AA5
	for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970763; cv=none; b=JKklb8zrgAFJpy3SRpE2HfD2fwbsDiBA9WaFYoR2IzhMUtUhFJQH8Ri2ExiiZXQR8DSzx6CTxYU8M2Wl6fUrfAX6VaXsrcr4XeIYYf9pY4Mko/0JthKkuiycc3OPMufO0/0oSm/SxpW1Cl7ElaRBiJMDY9X59bAyIhSUjkT2zqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970763; c=relaxed/simple;
	bh=gCrgkIPbFegO2eicyHZHrBUiLayP0ijxfcfJzSBVVUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyghWHZoeCbT1bLShvSxih0ieM56gk+BdTtSGGi6/RdvRMfQWwfrmcqx9jEdqjv2SBjZIVmRM1jVaEnVRQc+IgXkcNfdz7CjSBL1vQyC2Qc/r19P8SBQy427eIbMpCc/g5zx3PQvAd0Sot8M5rxZbrANPiJMHdSb2ofP5+sNRvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=EVzxZqv8; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="EVzxZqv8"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1273349c56bso7258197c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 08:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1774970761; x=1775575561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4j+OEfsG/I16P/3aLnzvA9y/trT47oVa/DsT3A9BUk=;
        b=EVzxZqv8Re+9cFLOPFK5SqVZ+v2MmJsH7a5IyPkR3lS2ifuF9q6XcxcmdLSbwqBc7M
         t07xVIvBHXn+MSnDhkp3HZL/e4tgKkCadF1k06rpAFXBjDmRe5+raJEv0iZCmJP8ez1D
         DEJEpBoaD66OYNcjF07XUgCmgGTa2NlK+Urq9ko+Dej0mCIzq+K8FKW7nWFGrco+JZkD
         Mh73ce+7B/3d6ugUm2ywwU0Kp38QVxThjXOcymiljzZOYnAtE9wEJUOwiQ9zWsyscxzY
         hqltvWE0REqknaPwApXz21qejqGgnva5HIoSzYQRnMBwWmk1MJFm7JKevzBgvu2MfGXm
         kT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774970761; x=1775575561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b4j+OEfsG/I16P/3aLnzvA9y/trT47oVa/DsT3A9BUk=;
        b=s0lpkBAtYDrsCU7hWVxtsxhRLqe2/nFXkwTpMjX7XuFOack30qLlbsUeTxF9BaH7PL
         qyhDo0kLIx1E/ATBVIbpuXPrhSPJyaNWM5YYmlhccgHkSAC//UMo4qSrO+QbnmbmS1CU
         7IhN+exOg+WiKCUophG/1sH74v7/6I4Unry9qP25h6GbQ26H1hEPaOvOXSickRUMuB9g
         lovvBoWri+RoMvdO+PPJmPNUVOIEqUX2ic2oxcbIYe0r3J4v8I3YC/YT7uoUuvSazuDU
         5GIGauv85P6wTbtAI5cYDMrsXDR0txfFv94FSJlOEk8xnLJrS57Q6hlEmc65RZ0CUKA3
         18gg==
X-Gm-Message-State: AOJu0YwxpCm0zPYYYg9vazs2BQkyw4CLe1IjpT5u3MZ5P8yIQU8tvh1+
	3SurrUMGT+EpuQvel6lmWM7HPEipgrYs0reS3w5gyS67nw5+rjvuSxKFD4DbJi75KOk=
X-Gm-Gg: ATEYQzyHCVR0Bbf7y6SoTz9+P36J44avfrFhZ5VRTaLAEpc0/E0jcZfvMMwPbUDnPtI
	gsuA1uezbU6wFMlSwoh86tYRHY3txdhlEI0w/Qk19xwNwyDD7zWA0MKVNlG9i1qi+6vf3f1Aa75
	1KtdIEKBC5vLSN+OK8daKkcnB3M5vTmPt9Woot7WwvIV9hE6Oh7lKLrQeUbkWNZNq0p3hVemMFB
	q5VBnIXhgFZJtZCIcBlSezLp5LqnVcyMO9JCacxdBEKoE3uKFbfeTBUeb7hgXnQItcpAO2XVlcy
	mEHyzMkvu5Iia+a/eRIAh0ys0lo779Mt1PtL8ARrJWyUnoTv4jjM+Acwz3KY85FyC8JSGub+eBB
	/G9T77oZzlitPLvVbHcDOIesIa4Gyot0xu882RxF2OjcHF7pfxpOZokQFMGUlaST9D+RGQwLtiz
	q4bJcg5LyUeyVRxvUNcX7LLmI=
X-Received: by 2002:a05:7022:220a:b0:128:d7a7:526f with SMTP id a92af1059eb24-12ab284be71mr9350215c88.4.1774970760868;
        Tue, 31 Mar 2026 08:26:00 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:5f44:e3d:a8c5:d59])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab983f9f3sm15618113c88.10.2026.03.31.08.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:26:00 -0700 (PDT)
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org,
	x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/2] perf/x86: Avoid double accounting of PMU NMI latencies
Date: Tue, 31 Mar 2026 08:25:49 -0700
Message-ID: <fb9d71a050a31d67a39962aad757feb66dac9a12.1774969692.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1774969692.git.calvin@wbinvd.org>
References: <cover.1774969692.git.calvin@wbinvd.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because NMIs always poll all handlers, calling perf_sample_event_took()
unconditionally in perf_ibs_nmi_handler() and perf_event_nmi_handler()
causes two latency numbers to be fed into the exponentially weighted
moving average for each NMI on AMD machines, one of which is much
smaller than the other:

    <...>-70985   [029] d.Z1. 13311.704313: nmi_handler: perf_event_nmi_handler() delta_ns: 6732 handled: 1
    <...>-70985   [029] d.Z1. 13311.704317: nmi_handler: nmi_cpu_backtrace_handler() delta_ns: 1673 handled: 0
    <...>-70985   [029] d.Z1. 13311.704319: nmi_handler: perf_ibs_nmi_handler() delta_ns: 2064 handled: 0

This can bias the average unrealistically low, in this case because the
latency of perf_ibs_handle_irq() doing nothing is averaged with the
latency of amd_pmu_v2_handle_irq() doing real work:

    # bpftrace -e 'kprobe:perf_sample_event_took {\
    printf("%s: cpu=%02d sample_len_ns=%d\n", strftime("%S.%f", nsecs), cpu(), arg0); }'
    Attached 1 probe
    02.836860: cpu=17 sample_len_ns=7775
    02.836871: cpu=17 sample_len_ns=1492  // avg=4634
    03.042803: cpu=20 sample_len_ns=4298
    03.042810: cpu=20 sample_len_ns=1152  // avg=2725
    03.204410: cpu=27 sample_len_ns=6973
    03.204420: cpu=27 sample_len_ns=1302  // avg=4137
    03.622364: cpu=00 sample_len_ns=5270
    03.622371: cpu=00 sample_len_ns=992   // avg=3131

Avoid the problem by only accounting the latency of the handler which
actually handled the NMI.

Fixes: c2872d381f1a ("perf/x86/ibs: Add IBS interrupt to the dynamic throttle")
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 arch/x86/events/amd/ibs.c | 6 +++---
 arch/x86/events/core.c    | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index aca89f23d2e0..036385de2123 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1402,10 +1402,10 @@ perf_ibs_nmi_handler(unsigned int cmd, struct pt_regs *regs)
 	handled += perf_ibs_handle_irq(&perf_ibs_fetch, regs);
 	handled += perf_ibs_handle_irq(&perf_ibs_op, regs);
 
-	if (handled)
+	if (handled) {
 		inc_irq_stat(apic_perf_irqs);
-
-	perf_sample_event_took(sched_clock() - stamp);
+		perf_sample_event_took(sched_clock() - stamp);
+	}
 
 	return handled;
 }
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 810ab21ffd99..d1c7612e2e5b 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1814,7 +1814,8 @@ perf_event_nmi_handler(unsigned int cmd, struct pt_regs *regs)
 	ret = static_call(x86_pmu_handle_irq)(regs);
 	finish_clock = sched_clock();
 
-	perf_sample_event_took(finish_clock - start_clock);
+	if (ret)
+		perf_sample_event_took(finish_clock - start_clock);
 
 	return ret;
 }
-- 
2.47.3

