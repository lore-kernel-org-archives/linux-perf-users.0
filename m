Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1671362;
	Tue,  3 Dec 2024 21:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262875; cv=none; b=I7HqDFdhY0HZlOV+zeBSDduAsVDoNc3M3FT10tFnSa/FRHBCfkBYfzA4ScGFD2GsgNNcOFjxfRnULh5+7Nc6OmzivrtzvCs7k+QrFRkexffkQun+lLJFMixPdCrAhdoj6lGTkvvMM4ZhFubSLPpbRZbjslgrRQu65fCK2KacKyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262875; c=relaxed/simple;
	bh=6lQIgbwW0AqzRYFEpnv3aOGPz9JpnIDwoCp0f0bDRz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHb7fu46V1FpVQp97cLuhNKly71ALcvr7LFvYuvognSLeKnL+u6FIULrQKg5FPW1aglwS+SOGSjozR3UNJtnRcldRVyqqUlAQoCXoYQ50gd9vxxja+dQlLxC3xhUx+51OMrkv1TJ1d6tAQwTxdF9HHqPNSmf2jC5nF81499xF4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHqBC7xM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHqBC7xM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE78C4CEDC;
	Tue,  3 Dec 2024 21:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733262874;
	bh=6lQIgbwW0AqzRYFEpnv3aOGPz9JpnIDwoCp0f0bDRz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jHqBC7xMzhh9yoV9IcCek6qoGy4BO4tXW9UaPkz/Y/7doVyTv9jwVeK2VcN0EIu9C
	 nJvYqke0gM+/IZ/hb17ebMTCfHud5yAtsI9SmaFRCffOBMm2oTA9OzEMsTqmtkFJhn
	 t7m1kBVtiqYmR8RCL7XjzBlbIl3hOP07V99g2JuJhAboE8Tw2fOKFRGFiLHMV3r3XR
	 fyGmxuexaZF+VadgesCwnHxolrzTR3DFK/Xzmg0IKBraBfd+BzyUcVIsaDgn0VGHJP
	 StpIeAtUfrY/SusoT95oKMY4E07EWiEAQr4mW9wIVukj9hp5FHAu3R8umrUMcWQ1tI
	 gzx7a8lVHBqxQ==
Date: Tue, 3 Dec 2024 13:54:32 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 11/11] perf tools: Fix build error on
 generated/fs_at_flags_array.c
Message-ID: <Z09-GGWh87_wrslp@google.com>
References: <20241203035349.1901262-1-namhyung@kernel.org>
 <20241203035349.1901262-12-namhyung@kernel.org>
 <981436ce-2d41-4c3e-b77e-63e4c200cd0e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <981436ce-2d41-4c3e-b77e-63e4c200cd0e@linaro.org>

Hello,

On Tue, Dec 03, 2024 at 04:43:44PM +0000, James Clark wrote:
> 
> 
> On 03/12/2024 3:53 am, Namhyung Kim wrote:
> > It should only have generic flags in the array but the recent header
> > sync brought a new flags to fcntl.h and caused a build error.  Let's
> > update the shell script to exclude flags specific to name_to_handle_at().
> > 
> >      CC      trace/beauty/fs_at_flags.o
> >    In file included from trace/beauty/fs_at_flags.c:21:
> >    tools/perf/trace/beauty/generated/fs_at_flags_array.c:13:30: error: initialized field overwritten [-Werror=override-init]
> >       13 |         [ilog2(0x002) + 1] = "HANDLE_CONNECTABLE",
> >          |                              ^~~~~~~~~~~~~~~~~~~~
> >    tools/perf/trace/beauty/generated/fs_at_flags_array.c:13:30: note: (near initialization for ‘fs_at_flags[2]’)
> > 
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Hi Namhyung,
> 
> Is it possible to fix this before the updates to keep it buildable? Maybe
> it's not feasible, I didn't check.
> 
> I did notice a build issue in the kvm tests after this update:
> 
> $ make O=../build/local/ summary=1 TARGETS=kvm kselftest
> 
> In file included from aarch64/aarch32_id_regs.c:14:
> include/aarch64/processor.h:15:10: fatal error: asm/brk-imm.h: No such file
> or directory
>    15 | #include <asm/brk-imm.h>
> 
> But I tried the same on v6.13-rc1 and got a different error, so I don't know
> if it's any worse.

I suspect it's an unrelated issue.  This fix is about generating
descriptions of the flags for perf trace beautifier.

The below is the only change I made in this series for arm64.

Thanks,
Namhyung


---8<---
diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64/include/uapi/asm/kvm.h
index 964df31da9751c96..66736ff04011e0fa 100644
--- a/tools/arch/arm64/include/uapi/asm/kvm.h
+++ b/tools/arch/arm64/include/uapi/asm/kvm.h
@@ -484,6 +484,12 @@ enum {
  */
 #define KVM_SYSTEM_EVENT_RESET_FLAG_PSCI_RESET2        (1ULL << 0)
 
+/*
+ * Shutdown caused by a PSCI v1.3 SYSTEM_OFF2 call.
+ * Valid only when the system event has a type of KVM_SYSTEM_EVENT_SHUTDOWN.
+ */
+#define KVM_SYSTEM_EVENT_SHUTDOWN_FLAG_PSCI_OFF2       (1ULL << 0)
+
 /* run->fail_entry.hardware_entry_failure_reason codes. */
 #define KVM_EXIT_FAIL_ENTRY_CPU_UNSUPPORTED    (1ULL << 0)
