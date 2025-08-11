Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2358223DFF
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Aug 2025 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905302; cv=none; b=KPKZj8MEKddNi0yPV/j0yfGg2ZwR+uMy9LFP5PL3HdGkiQOTCnO+yMvOgadN9vHBkdmCX/gz48GoGNsXPYdjSp2XCCGr2Ra/y0phdCA99hfV2T7t0uIA1gCJCacreKUjAZyjQY884bUuOWY1RYR3v7uUBmC3XF8TXSiQc6vpz70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905302; c=relaxed/simple;
	bh=FegSiZ/uTFpjfSl6w3mw++RAIeSoUOFcA93L/NfHQZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CbbeAHiSk582gh0Xlm04fViQ/8vYRj31OXXdj71ecJGbOnXWJACWF4/SxJ1P05tUEQyf8iYv+OSbWKzYOgHxQpyiY+MnYRka6sQrly1bPAAOyeqgByaMBAasBMhAdz8/RrTMvqwrb7ESlqLXlxwNVYiFt0yfMcwYmWCuy5P+Vg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=AbljZKnb; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="AbljZKnb"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55b8a0f36fcso4470996e87.1
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Aug 2025 02:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1754905299; x=1755510099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cy59ORjyXtIVFFgfYeqm1wmJyEdmnPmaEOXMVqFckn4=;
        b=AbljZKnbDcKb7rjVsQSH4FwsC4jB1y+FTmw/znt5dyJFeR20/8cxkzVFF/phMbgXHR
         F/3fALREVG+MqUobCe+7Oo9lcbH8ldP+EhGd0Lxh2okKC5MG+bY9fS6i47YN0+WlMsv0
         B3z66gns21qhGlLBx54jv5p9WX3Nw+HFh+y+3/l8VKAj/LeapLFaSklMaYvFH+vceozn
         V8RFVeE8mESbVKKznQbi0DGzzjmeAILEAfjOaXuQbHDHxR2CEUr9mbCI20H9DFBh30hX
         KDx9dUrYl7f/DEnbqFYaOQqhzpD3lBu8sSDXYOzmk74PjPtSewPQprXnzy1zcZOYXU7d
         3wsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754905299; x=1755510099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cy59ORjyXtIVFFgfYeqm1wmJyEdmnPmaEOXMVqFckn4=;
        b=v33XgB/CnVllmr2iueO+sOKU2wkgKyzizkdHDU+LAF9GWU8SEeg3wyxaGmXbYC9clu
         0XkFiKBo2T6QCGcE+2y618SF54jISF4gCE1DpiiP4jbH9562mhulrEZY5Zv8AilWGkto
         loxtJovSS1o/D81t+OxKMcp2QLFNL0nnsPkzARON+UxLwoRSsoowdOt7ei608676IA+Q
         jJIX7kTwA4AIs/5X0KUSAkf2pMNys/jkB8wxr01zM1MtU1a4xS9vwY6PDi4Xo6+l0Bst
         9J0evqysJdxBCtbYw5WKUYkw6YL5+d6YNANkGzuCVNWQV09jUok+UsJ22lIz1z/4lwov
         81EA==
X-Forwarded-Encrypted: i=1; AJvYcCXCQnMCjpJBHUkOWPSjbQqJk8G2SOqO2Sq3/a1EOkWowoUNnLqZ1kkA8suZ87MTksocQHZ3ofr/ORJz7ireM9/S@vger.kernel.org
X-Gm-Message-State: AOJu0YxFzPKJTMwBMn5IhB142tACemktE5f740eDcoh0Wx8LUQB5Zkff
	Mom0FA6Msib3SjuiopNgJCkrKDPCeEkg7lRuFANIomF69gBkz4sLLvBDt06HAzjaXC5fYQXw8wy
	FPmxnKpWf3yYJ30UHqF9cnO7cX/VuQspHTWrRq/6ZNg==
X-Gm-Gg: ASbGncv34wO5+BhbjNuQ5L9d09xmF7X2br/n4uqiVuBsunkNj6s6ywsFjuF3bNRoWrk
	K+8YMH9egBQB8cgJMGndMTmN/ggkUfrLlABkL9c5sHrmWU0s6n4FBmw2gFfeVpepX+aAKsGWJRo
	3qap/CLSKSChPdhJSxRMuVoCfZ+gU8L3n97EzjVbdrgZYkaNorvQbIYDDNIeTCLAAkGOi8I1ZGe
	KQsZQyLfICSB+N3ty0=
X-Google-Smtp-Source: AGHT+IGmUn3ZM7jBX7D1YyhKjvaPN2e4dHa6K9n92Zz8n8QotO81v1sGyRseqSkkKtsFNnDYwv8ehf88vLMTTISTp9c=
X-Received: by 2002:a05:6512:2316:b0:553:3a0a:1892 with SMTP id
 2adb3069b0e04-55cc008637dmr3351518e87.15.1754905298946; Mon, 11 Aug 2025
 02:41:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805193955.798277-1-jesse@rivosinc.com> <20250805193955.798277-6-jesse@rivosinc.com>
In-Reply-To: <20250805193955.798277-6-jesse@rivosinc.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Mon, 11 Aug 2025 15:11:27 +0530
X-Gm-Features: Ac12FXzX2WBI8Efn8ZEvJJb1ujk-ZIhK3W3ZYl12yeFcZ1SpyaqkJna1l4oNLS8
Message-ID: <CAK9=C2X2J4ROJ7nKB0hcD9dVav7ZMFWw2Qy+GEsmYN_Tt8DxPQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] riscv: hw_breakpoint: Use icount for single stepping
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Oleg Nesterov <oleg@redhat.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Shuah Khan <shuah@kernel.org>, 
	Himanshu Chauhan <hchauhan@ventanamicro.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Deepak Gupta <debug@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Atish Patra <atishp@rivosinc.com>, Mayuresh Chitale <mchitale@ventanamicro.com>, 
	Evan Green <evan@rivosinc.com>, WangYuli <wangyuli@uniontech.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Nam Cao <namcao@linutronix.de>, 
	Yunhui Cui <cuiyunhui@bytedance.com>, Joel Granados <joel.granados@kernel.org>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Celeste Liu <coelacanthushex@gmail.com>, 
	Chunyan Zhang <zhangchunyan@iscas.ac.cn>, Nylon Chen <nylon.chen@sifive.com>, 
	Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Akihiko Odaki <akihiko.odaki@daynix.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jesse,

On Wed, Aug 6, 2025 at 1:10=E2=80=AFAM Jesse Taube <jesse@rivosinc.com> wro=
te:
>
> The Sdtrig RISC-V ISA extension does not have a resume flag for
> returning to and executing the instruction at the breakpoint.
> To avoid skipping the instruction or looping, it is necessary to remove
> the hardware breakpoint and single step. Use the icount feature of
> Sdtrig to accomplish this. Use icount as default with an option to allow
> software-based single stepping when hardware or SBI does not have
> icount functionality, as it may cause unwanted side effects when reading
> the instruction from memory.
>
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
> OpenSBI implementation of sbi_debug_read_triggers does not return the
> updated CSR values. There needs to be a check for working
> sbi_debug_read_triggers before this works.
>
> https://lists.riscv.org/g/tech-prs/message/1476
>
> RFC -> V1:
>  - Add dbtr_mode to rv_init_icount_trigger
>  - Add icount_triggered to check which breakpoint was triggered
>  - Fix typo: s/affects/effects
>  - Move HW_BREAKPOINT_COMPUTE_STEP to Platform type
> ---
>  arch/riscv/Kconfig                |  11 ++
>  arch/riscv/kernel/hw_breakpoint.c | 179 +++++++++++++++++++++++++++---
>  2 files changed, 172 insertions(+), 18 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index fd8b62cdc6f5..37f01ed199f3 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -546,6 +546,17 @@ config RISCV_COMBO_SPINLOCKS
>
>  endchoice
>
> +config HW_BREAKPOINT_COMPUTE_STEP
> +       bool "Allow computing hardware breakpoint step address"
> +       default n
> +       depends on HAVE_HW_BREAKPOINT
> +       help
> +         Select this option if hardware breakpoints are desired, but
> +         hardware or SBI does not have icount functionality. This may ca=
use
> +         unwanted side effects when reading the instruction from memory.
> +
> +         If unsure, say N.
> +

We expect the same kernel image to work on a platform with
icount triggers and without icount triggers.

Please drop this kconfig option. The decision of falling back to
computing hardware breakpoint step address should be at
boot-time and not compile-time.

Regards,
Anup
