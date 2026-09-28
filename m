Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1B84C9E10
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 13:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602950; cv=pass; b=KXiXvKiq+pAQeH6r7INW61EfOPgb6BJhih+6LZz//2ZIRX5YiRRa0DHNeAbMi2ePehXPxShP+Lb9uF4rBjutRP5ourfaADyun9/i1labw3tsOjp1ZRQPwCviXahlSOGNpsQj6fGldZCBGYbTGjEt0M5LnWe6IdWzS9L31lksy0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602950; c=relaxed/simple;
	bh=k2uwa9kfpmX/6oBhi2iMilr4w0fmi3EZ1DNQBIYEhZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AT7LgiNpCJoY3Lg15c2ykVEMTMOu/vE+UYG57YfYecU+ASwedHY8Jjv0JiEXi6ppR5fn8gyNzMT7YtiP0R5lMlGYAOEtvKiPB4NoyAXc3e2nsSzkLL5lLc52Id/fcAjXQdLIaqvqJejXQHGmt+1nQLSNfzO7P/MkRhPdA/MmY6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=fLJpZYv6; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="fLJpZYv6"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffe281cb1so11338715e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 06:42:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790602946; cv=none;
        d=google.com; s=arc-20260327;
        b=olWOJ/+5joc9FP85zpBKZNapJOWoN6bFqc0FKHyEfI3r59aZnKwAOtI1zwuAhrK5OE
         L04UV1dxCU6DNhiLMJE1y0DQsfxAVsTHutDb6RqwLs/dmDh6+ZYYxqTDJvjav+/HN13+
         IO2wxMDm4FhSiRPP0RjF+DjD4tamsJGTUH5wq3ls7p7x2jxCqMrmBcB3Ls1ENQXcHTKx
         /eG/fHsfKnQOFZquIcLXo+6GtDjbPbY9xNWoj4sGWg95PYTt79Cwmb6eScYOKRJwZau0
         FZBI2UDBELAqEfMEeFklgB3/KOZw3BZ7/G0jYUSNR6umrvsm88ZfTemklDAZfEm8dOTe
         VBFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BQVE+Yt78Z3pfyI+mWf7Zu1XcCvdZQxX7b3ZOkZzIX8=;
        fh=kuHN/5W71qf65Sxypj1GEyE1XcFhe8Im2p3EGSPXgGU=;
        b=aOWLAJmemqI7BR8ujZcdytosJjdDNkILmDQBS63b7uUhI+/6+ktejYJPYs9RmczylW
         6mUEgtEop1KtyU6fZRRCVaKyZaXq/uPb5YOQscdqIA5usPEqUnepRcT6BhVDHRrsYJNY
         pGaVfI0+VShmzeVn/mOaFyEaKu+t0pSDxa+E7fBTKFYPzD1N1lNmMQrW16+ZLQ19le/g
         xsIRuINmNZmoCL1ozk4d16D2vFl5O9/A1hjsWeMNJgGSRxMRHqqI3WmPxnb/Q0MYHRiu
         eqZABMvAbiufIIiEBbDDlfls1DGN9kaiKpK0NxNM/Rd48r38aQ33HOnhKgBMoXAfoP5f
         0+bQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1790602946; x=1791207746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BQVE+Yt78Z3pfyI+mWf7Zu1XcCvdZQxX7b3ZOkZzIX8=;
        b=fLJpZYv6JMSV8xL3CAMW9ipZIwFhydjwC4jIHZb35FoQ3GbSVmcehaLelYJuiukDr/
         6YoI9XcdeRFpl2KyKZ5o4aBFZcM+P5Ic459MlVFWuBPni76FHPBFPyMcQX2sA1gwuExG
         vZXg48pdk/iY/fOa+62zxE3xMdkXdSWh6d9rbb8XBuM3CYbryZfD735vbsGx1XEn7Lgr
         1S/iiYROOTJVTNAxV9fqjR1l+8WaQ1PTaiZIDgI11PgCGRQCNh1wCNWhnvqRaqxH8IbP
         g+wKxr+Uo8oAk00Q0wY6caqEj4AwLwwpmsjAPkKVpTfxl6E7kqgkz10f9kfgp8e8avQt
         gQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602946; x=1791207746;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BQVE+Yt78Z3pfyI+mWf7Zu1XcCvdZQxX7b3ZOkZzIX8=;
        b=KBpfIB7Tcv530BQ/wBum3/ViD5SZuhqwe1sjXzjRt48VYlCMKPyI9HvBcpQXporwP2
         3Og25KfxrFja0547jy/yJ7JBEAWHTKAZGKCR8P0MrbTVmWG48bFwW+Yc40P55uIklvFU
         juuEzhlNC8iauyRU+3pVK/OPdf4muiK8WwxbjSKe/nIyAjw/ftRh50vZ9dTPHEO9huvi
         QupVL5EkpdFw83UbWNQwWTQS6Znt6ms7RtoPCu82BIUGVz4n+T1kzE7zGBWtQbCDIaCS
         FvW4VawMM1zsRGRVG5/tPdkR7maMCYoO8Mml3aJXDnXa8x5khR4MAuu6FioOZfiAhTsp
         1Oig==
X-Forwarded-Encrypted: i=1; AKwUvBwjTEHOfEoTNIIG3evA+f3Xqw/gZahoN/ktNJMvJaPj2xw+aJ06PR4LgBHNt4VRWlYb12GRcwrwo0Cm4kB0pqb8@vger.kernel.org
X-Gm-Message-State: AFuF++mshMW3s38ExupZr0jckefbVY5dMop7f7KwE/b2uZrV2k3NqGNk
	mQC7dXflEdXpiyjbW/QRkwkFqPNdIXSxbzNN1tVm6Uam8TfSHoiWGBzxTG8v4k2uFKfTAQjCP2P
	eDhhkh9lqC4WSbeek6kru0TZqOVruHtadnd8I3DHF9A==
X-Gm-Gg: AYBFou3XYEmQOiFEd8hxCZsVvkVpxEhpaNeGUNudvBEo4qxN2RSFe+kr/all8luCuPs
	wJK4QrGcubr4eGgEzTWsfdGNjc9+zDsm2Fs2Pa8/XQSb4xK9QXA+4OOH+7PQ1uCYdJNwHmCxO8c
	dlzZLhCLpAAnA2vf+ZPswB15krHtb3TISrH7972/8Xbiof9isDFjZSxMggyhk/g2v8xyoCT0zq+
	tWhKTxNfjitvJ6kIFdydpAAh22Tp3YByY3fRU7O83idUYyymCzM74Hg/8W8D9igcMzc4QS32ev0
	Gj4g8OLUzWTeqfqr5a6H6rjKU3kPqyD1keEXiMqY4rXyFFI9JgGvP4Ifha4jlWneypEb8WILUuc
	bzzvM1aj7ZkQyqlZ5IWhi/9luFcg+XLVagiXVpIZuwSDsYKfNUMGUbZ3gTRkodBSiIZuq7fnvXr
	ldvLTs4tpDZQ==
X-Received: by 2002:a05:600c:46d4:b0:49f:ec98:f030 with SMTP id
 5b1f17b1804b1-49ff06f839dmr165880955e9.33.1790602945896; Mon, 28 Sep 2026
 06:42:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928094739.2605-1-cp0613@linux.alibaba.com> <20260928094739.2605-2-cp0613@linux.alibaba.com>
In-Reply-To: <20260928094739.2605-2-cp0613@linux.alibaba.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 28 Sep 2026 19:12:14 +0530
X-Gm-Features: AclHuK9NQvFd0dqx39FONs2gN8zrhWEmLq1wAOlPjaDEqyssj2Y5zQw81EJtk-A
Message-ID: <CAAhSdy2JhEoG2-hrtN63ZF3sj6Uyqrs8G4Gj+P3Ut2f5h+v4fg@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf riscv: Implement rdtsc()
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, john.g.garry@oracle.com, 
	will@kernel.org, mike.leach@arm.com, pjw@kernel.org, palmer@dabbelt.com, 
	guoren@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 3:20=E2=80=AFPM Chen Pei <cp0613@linux.alibaba.com>=
 wrote:
>
> There is no riscv implementation of rdtsc(), so perf links against the
> weak stub in util/tsc.c and every caller reads a constant 0 that is
> indistinguishable from a real counter standing still.
>
> Implement rdtsc() over the time CSR with rdtime.  The time CSR is a TSC
> equivalent on riscv: it is readable from user mode, it ticks at a
> constant frequency, and it is the same counter that riscv's
> arch_perf_update_userpage() builds the user page conversion fields from,
> so the counter and perf time share a timebase.
>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

LGTM from RISC-V perspective.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  tools/perf/arch/riscv/util/Build |  1 +
>  tools/perf/arch/riscv/util/tsc.c | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)
>  create mode 100644 tools/perf/arch/riscv/util/tsc.c
>
> diff --git a/tools/perf/arch/riscv/util/Build b/tools/perf/arch/riscv/uti=
l/Build
> index 2328fb9a30a3..52cd6a481de8 100644
> --- a/tools/perf/arch/riscv/util/Build
> +++ b/tools/perf/arch/riscv/util/Build
> @@ -1 +1,2 @@
>  perf-util-y +=3D header.o
> +perf-util-y +=3D tsc.o
> diff --git a/tools/perf/arch/riscv/util/tsc.c b/tools/perf/arch/riscv/uti=
l/tsc.c
> new file mode 100644
> index 000000000000..7cc4710ac38c
> --- /dev/null
> +++ b/tools/perf/arch/riscv/util/tsc.c
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/types.h>
> +
> +#include "../../../util/tsc.h"
> +
> +u64 rdtsc(void)
> +{
> +       u64 val;
> +
> +       /*
> +        * The time CSR ticks at a constant frequency and is the same cou=
nter
> +        * the kernel feeds into the user page conversion fields through
> +        * sched_clock(), so it is a TSC equivalent here.
> +        */
> +       asm volatile("rdtime %0" : "=3Dr" (val));
> +
> +       return val;
> +}
> --
> 2.50.1
>
>
