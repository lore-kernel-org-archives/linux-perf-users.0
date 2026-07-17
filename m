Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9D828725A
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300604; cv=none; b=SLmF5qrBbAv+WASQqVhaSXTAooDHDy/fIm6ZwIiUraBf4WYwvz5nTNsNmCa9KLGV5rjsKxbDiG5QCBqFaO76+LRK1nKsaUY2qp7uuKRK1m9wx+yG6BSgMuTp23QxmgbJyL7EjcnoIUGmz/uCv+OlmZQXurndVIdF4sgR19WxUjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300604; c=relaxed/simple;
	bh=FzqxM1GVEq6TxEsGnVur2jIHhbJa1HjYDaY+SvogvyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qMl5Ljdxxo5B1N1sMVftOR80sVByepQmxYUO+9l6YahGekk4CdLlZFmaFnStR45kGmWfte5iXkYJgWY94K810QkLO3ZysUFQfC7slvu1tBAQ72eczwg3yz7TDLyWmCIx2tD8U0Tdthti6q0vVky7bVHTGAK6pwSK/wkVu4L8Xcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eIVrZ0xK; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eIVrZ0xK"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4731f5ffa74so517298f8f.1
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 08:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784300600; x=1784905400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hPqRefE6xquJsDDK/v1oM/UNTjPpdK6K17Q75AUiy6c=;
        b=eIVrZ0xK/StUBx7qAsbmVhm9f2wxqs5KfPmZn9MSq+zyFgos9S3mYWDUk8sanQM3yv
         zmd7oVd0w7r3swrsnPgMNrhBNn+UPH/xpfvQVXqUnfcBfkviwROh6qzZBVEI6h5khzRD
         z3WT/yH7GZlWMuo1N5GL2xnCpflcX1DWCHZwSN0fpKKCcMeqBRUAPT1CkOg2d1i/5Epg
         R3PVOb4a/7ayarYf3BdxrHqOM7TO0qb3ej3FfzUt1MCwh/XhSXkxM8HtsKj/zen4/i6C
         n87PGy1XZMRw39VdzpHzoR9KInaF9vOyC1tYs92rV1zl/at8pLYeTpXe0zbGDPc6Wb1O
         bcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784300600; x=1784905400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hPqRefE6xquJsDDK/v1oM/UNTjPpdK6K17Q75AUiy6c=;
        b=OH/+qxZQu71kKSW9daYRTkyCF8VL7CBqXeFRn7jUnYO2i0x7LhoZdguT46h2rmtqA3
         7LmOkRnT+XWbTougSDO1CPBkalsSDCiTKsDBN6grz+I/UOTSFUMYj3H8LVZobfVzGcaY
         ukZEBb0VxmonCycWcimmvoDvV2dLcSMZYmgDhPThq8SaCrDMrrEKRGHFHW9Chk8o5VZa
         sUCXWmM46xQVo+OsHWRBtD1Uxba6u1hgUxiQ5f3VykecSfuDPF8/NTlqUFuhIqkM/CbX
         LsS60jvGzax0+csd+7t8nhojt6UTxcMR9/pkudj0AI3XnJ8egV8L2GWtdLXk2qy++yCy
         qfbg==
X-Forwarded-Encrypted: i=1; AHgh+RqmMmDj7uxxcuHzCiDEaFK0mtXtbiUjqZoPph99EwmpC16r9PmHHcvVxUzqtjVLG1B/2oxPBzZKVjMZKOtoOml+@vger.kernel.org
X-Gm-Message-State: AOJu0YxrgcDfCh44cTyhbQwRJ2FhU8ClaNsHbtIS/pWqS/RGjF9tf4Su
	Iw3LY9BNj21yo53KKzHGdekhD6qRncw6I4CXNdAj/XVmBI95UJ9MiZ2DGWVk4YqfA2Q=
X-Gm-Gg: AfdE7cmVW0HojuLI0SrYZUUAlwT/hYlM2T5Ioff6dYTkE4/HOGrod9On/s2S8JKRinf
	+d9MBCp71ZZAYcDvO5siyi3x0SqhcT2eC65vRZYDX3xC6fJB5N8bPWnENviaA346Hic8RG+R2e6
	SPWLhQZbWby/viYKDHXvgPE4DcL66p6VYCIoFeVJKUgfvFFaPrFqLSFlkKvrUo8/zebcGMv2qUH
	iC/nPT8GgdAptmK5qIIQF0ldEhTvvFwLKHm9ObGmWG34dcWIljUma0QuMFYmQ7RBgqdIpKqqDM3
	hlVyXOfqS3b9n4BZu4yhe0NZIuB/1Dp2y9hbAekbMD6kUXAELJxEXCt4CAK6xo0pF8GBfaC2YMN
	g1A49pbhw+UfYoxDJUOpU+aqH9EWItLA8ezAvE2W9up5HCkLl4SEOz6rjnacVGvHTI37Kz+zN4x
	egS2HxFSdJManAy4JFZY7jgE+RIwk5WNUnxiN5PWvhc3JP5B6OHgpwuGgY9VdBxA1yWaF5
X-Received: by 2002:a05:6000:2892:b0:47f:59b4:391e with SMTP id ffacd0b85a97d-47f6232903emr2470713f8f.3.1784300599398;
        Fri, 17 Jul 2026 08:03:19 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e52aa4sm4742089f8f.10.2026.07.17.08.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 08:03:18 -0700 (PDT)
From: Petr Tesarik <ptesarik@suse.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH 1/1] perf/x86: Do not read fixed counter control register if there is none
Date: Fri, 17 Jul 2026 17:03:15 +0200
Message-ID: <20260717150315.2868314-1-ptesarik@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When printing out CPU performance registers for debugging, skip
MSR_ARCH_PERFMON_FIXED_CTR_CTRL if fixed counters are not implemented.

Since AMD CPUs with PerMonV2 do not implement this register, attempts to
read it generate a #GP. In particular, SysRq-P logs something like this:

[   14.748144] [   T1118] sysrq: Show Regs
[   14.748896] [   T1118] unchecked MSR access error: RDMSR from 0x38d at rIP: 0xffffffff937154c6 (native_read_msr+0x6/0x40)
[   14.750878] [   T1118] Call Trace:
[   14.751505] [   T1118]  <TASK>
[   14.752057] [   T1118]  paravirt_read_msr+0x7/0x10
[   14.752940] [   T1118]  perf_event_print_debug+0x135/0x240
[   14.753931] [   T1118]  __handle_sysrq.cold+0x9b/0xde
[   14.754855] [   T1118]  write_sysrq_trigger+0x59/0x80
[   14.755779] [   T1118]  proc_reg_write+0x5a/0xb0
[   14.756631] [   T1118]  vfs_write+0xce/0x430
[   14.757406] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
[   14.758322] [   T1118]  ? security_file_fcntl+0x5f/0x120
[   14.759083] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
[   14.759754] [   T1118]  ? __x64_sys_fcntl+0x80/0x110
[   14.760334] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
[   14.761005] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
[   14.761676] [   T1118]  ? __ct_user_enter+0x27/0xc0
[   14.762270] [   T1118]  ksys_write+0x6a/0xe0
[   14.762776] [   T1118]  do_syscall_64+0xe1/0x610
[   14.763324] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
[   14.763995] [   T1118]  ? __ct_user_enter+0x27/0xc0
[   14.764564] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
[   14.765233] [   T1118]  ? do_syscall_64+0x205/0x610
[   14.765806] [   T1118]  ? __x64_sys_ioctl+0x97/0xe0
[   14.766375] [   T1118]  ? __pfx_woken_wake_function+0x10/0x10
[   14.767048] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
[   14.767717] [   T1118]  ? get_close_on_exec+0x34/0x40
[   14.768311] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
[   14.768985] [   T1118]  ? do_fcntl+0x6da/0x8e0
[   14.769502] [   T1118]  ? do_syscall_64+0x205/0x610
[   14.770083] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
[   14.772321] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
[   14.773166] [   T1118]  ? tty_read+0x150/0x220
[   14.773722] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
[   14.774423] [   T1118]  ? filp_flush+0x5b/0x80
[   14.774966] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
[   14.775660] [   T1118]  ? filp_close+0x25/0x40
[   14.776214] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
[   14.776936] [   T1118]  ? do_dup2+0xae/0x140
[   14.777486] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
[   14.778309] [   T1118]  ? ksys_dup3+0x67/0xf0
[   14.778870] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
[   14.779600] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
[   14.780310] [   T1118]  ? __ct_user_enter+0x27/0xc0
[   14.780917] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
[   14.781613] [   T1118]  ? do_syscall_64+0x205/0x610
[   14.782215] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
[   14.782907] [   T1118]  ? ksys_read+0x6a/0xe0
[   14.783429] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
[   14.784120] [   T1118]  ? __ct_user_enter+0x27/0xc0
[   14.784741] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
[   14.785431] [   T1118]  ? __ct_user_exit+0x15/0xb0
[   14.786014] [   T1118]  ? srso_alias_return_thunk+0x5/0xfbef5
[   14.786706] [   T1118]  ? do_syscall_64+0x98/0x610
[   14.787282] [   T1118]  ? exc_page_fault+0x6d/0x180
[   14.787873] [   T1118]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   14.788612] [   T1118] RIP: 0033:0x7f70d6497e0a
[   14.789186] [   T1118] Code: 08 03 00 00 59 5e 48 83 f8 fc 75 1e 83 e2 39 83 fa 08 75 16 e8 05 ff ff ff 0f 1f 80 00 00 00 00 49 89 ca 48 8b 44 24 20 0f 05 <48> 83 c4 18 c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f
[   14.791587] [   T1118] RSP: 002b:00007ffc36a93580 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[   14.792617] [   T1118] RAX: ffffffffffffffda RBX: 00007f70d65f6580 RCX: 00007f70d6497e0a
[   14.793594] [   T1118] RDX: 0000000000000002 RSI: 0000556f34e41c30 RDI: 0000000000000001
[   14.794574] [   T1118] RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
[   14.795563] [   T1118] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
[   14.796537] [   T1118] R13: 0000556f34e41c30 R14: 0000000000000001 R15: 0000000000000000
[   14.797514] [   T1118]  </TASK>

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 arch/x86/events/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index d1af33d96d0a3..8310bedfc364f 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1581,13 +1581,16 @@ void perf_event_print_debug(void)
 		rdmsrq(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
 		rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, status);
 		rdmsrq(MSR_CORE_PERF_GLOBAL_OVF_CTRL, overflow);
-		rdmsrq(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, fixed);
 
 		pr_info("\n");
 		pr_info("CPU#%d: ctrl:       %016llx\n", cpu, ctrl);
 		pr_info("CPU#%d: status:     %016llx\n", cpu, status);
 		pr_info("CPU#%d: overflow:   %016llx\n", cpu, overflow);
-		pr_info("CPU#%d: fixed:      %016llx\n", cpu, fixed);
+
+		if (x86_pmu.fixedctr) {
+			rdmsrq(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, fixed);
+			pr_info("CPU#%d: fixed:      %016llx\n", cpu, fixed);
+		}
 		if (pebs_constraints) {
 			rdmsrq(MSR_IA32_PEBS_ENABLE, pebs);
 			pr_info("CPU#%d: pebs:       %016llx\n", cpu, pebs);
-- 
2.54.0

