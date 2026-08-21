Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5903264F2
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 01:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787275226; cv=pass; b=FEGTNXTRHS68X+HfAozTyYeZrdjRbn0+54oek0XyZ7/Mm8Jvkh2A7P/SY3TSZ8xpQWDma7L4aGS4tOqQURRzBr5M6eV6j6SqESg+QyAZBvgWSefTn852UzRBVewS7AKqBhP4phugocqcFdnNHr1Xj53t/kxgpEAb3JRx8rt0MGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787275226; c=relaxed/simple;
	bh=beEVlsUuL9o5hYoikgcqc1vZjOkeGxTIGhmngv+9k8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odHTURrfa2y3tEVRyRlxEeduudWmfUY7sjRaPvUGkKcz++5jw2VrBkBrh5QkqH2mr97LoPLWe8lgikBqAVrK5tCimFT8HndC9bH41zbMEyJFyoN2P9YpivSuALe0M/5zYN2vS76xz6TBUu9GeDyeU8/Z32jBk+/DtQ8auq5+C38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StO3cSkM; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StO3cSkM"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66b32bb75beso711828d50.2
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Aug 2026 18:20:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787275221; cv=none;
        d=google.com; s=arc-20260327;
        b=ae5naQCRtbyz59oz8Sja+77ydj7MgIbmLjbQnOgrlnDBo9zoX5l1kWAuxQyLT/csEP
         iWAAPbG7d+0i5JuFKW8GT0bVaqKf1b/Bll9fegVybhFJpLcZlgihgrBfpkssmcRBezK7
         qWcuPcXm9kaUCWpjimkbUNrlMbmu8/dfn7VDeI8qd6k2sqH9PWzdfi4qLLCLDRS30KVB
         mO2hX1IfMTRl3tgfw4a91UOaRhiC99fpVThT+WjyEpe6/k7SCMZBEsG8hlNiZ2A1jLSE
         Qvio6zDqbkwCcgLRqOO+Nx+qf4G0qiaW0Ymo0Z4xBEnNuHDLSHTZPdunc+1yp2GfTiI+
         lAIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cc/ydSvi4LcaS7pHjzjdCQH2bbW529bELwQ3mNa36YE=;
        fh=K2es/XnvKLA0Rzr7PW3qUr9/Ja/YePw2m+OVR5cad7A=;
        b=DbGoKsLOIfAALrwCpTP+TRuuwgz3mXbESaYH4qyfpql7+YfeGEaHoDA9r9pxC0W/t6
         SfrLGgJgvkoyclaFbfCJc06dEPMj66Gde2jiqLBrwKPRQborJUCvPBdZLprr8lgLFoJX
         Zy7s1zPp2A63xWUAjw8fXKMiiGu++Vioiv0MWHEgNq1sd5e6u3m2dEJvn3m3NhHR8alK
         h4fnXqpSVIsGZ3Uy7GZbMw03I5iSQjIqT7zrjXdYdMXH48Ir6edjTQlRFe3GF5d3kvV4
         Cws/F2w02quQVNso1CUaEAZSRikoXDKhJ6VuVCkBWNTzrw3On6GX9QJLxO9TPeGsgmo6
         iLAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787275221; x=1787880021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cc/ydSvi4LcaS7pHjzjdCQH2bbW529bELwQ3mNa36YE=;
        b=StO3cSkMRrkerKklAjGzm32z470HVenfFB21qn/HFzuepkklYWB0MvZhgKynrNdpUC
         OmlGZdFXpNj2LptWUYYRuMGmD+T7UgvEnYMSH8Ibj4XMYCdd5h12zqCU9gBuxkyGeqzS
         PF3aja90ZJvyr7a87wja02sZTiOZUnG2msi81cXlXKFKekGHsNTv3CSGZCLPxNQZ9f4/
         jaWAgjPrpMs1bMUdz7ArUsClK38d1ycA3vGG7JMQgM1i/UrJdvQokQPaFcuuuxVC5XqS
         zkrlywmyZE8/vYyIN2n5ZSD0DboWn9+a0cm0MjbY1SNAJFTyaN1H9EGBmD5WU07lH7KQ
         R8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787275221; x=1787880021;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cc/ydSvi4LcaS7pHjzjdCQH2bbW529bELwQ3mNa36YE=;
        b=cEiOKOCprBeWERP4C5SLJpJ5TAkD4DFthG+yxVhVID2KK9utlf2UuziMDJxnXE9Ezg
         AoDW/BV1dI+OQq3eO5J0aI0wRIXC/w60KLBqP+wOX94oAQoLTKS/7fLgyko2MVkEEmzg
         W8YTM1BrzsWEa9Y7XtCl4yBfBsgty/YQO+HxQgw2pZFp8vt1EoNMten59D2/bVZa6ley
         EQR58CLSzCP0hD8c67l+OuG8lPtZZGyBT66zfOVxTU+FhYpvsNRTubG2WE/V/BU6Tdls
         rDuJqQ3o06k4XsvDzCuLxPWUTWJltEV+fM9PHQJVi7JwBYUkzF/xWH7QsboVeGoDphtW
         30iw==
X-Forwarded-Encrypted: i=1; AHgh+Rob2vLeJMCw+s0snn7mQr6I2EIno68i64hHQYLI/zC+oBP/ADxIeBCdoT0PijmT4xw5O+er4liTMlu8Yb+KLX5k@vger.kernel.org
X-Gm-Message-State: AFuF++m+Rg6B/Buq9y9FaxhTU3h9v8ASURAxXH7lw4IupGaiUH/a1DAW
	0VAkd7m+gqjhgsTCOsOSrj1zEAY3N7og9dFUzAMOOI3O/M0ZJj42DaSrXLoeZ5zNhvyrHTNRNkh
	FOBSHHKtRUH+y17ydNNTO4e00mTFyHe4=
X-Gm-Gg: AR+sD133qMdDUxZNrPDrgGm08xe/ttZiz1BSG8GkayFATFt8+WyWeLWntfyeU/8+HgO
	Twr+Ug4XBLOYnMobj5FplZeIZjArcXUBRNMzbZhpI/QqYW9zlMwgiJBOcIwr2M+ZCjIOOtS3QuA
	5duQvJfd9ucSM4cQdXsFU4/kzn/RIjNcmVHfG3w5VW+zJGlZWCl3lOxy8Iv0rNh1x2o08r9xpQo
	11YuZZsxuLBjGxrjnTTced2gjQLwvKPCDlaj1upcYzdA9iokwmMZKmwmWpphlmsZmV3eQGsjJMR
	/HCFAPTn+WRp7xAZEmnulFL+tYVNoFA7OwCpiqpRmf92KO9k4RWc5mWHwMAoOCO0itaoCzxZUsb
	yBEBVJTqxJZWHkxQjlSWiwoNdLZ1Nxb4APJs=
X-Received: by 2002:a05:690e:6ca:b0:66c:9d32:46f2 with SMTP id
 956f58d0204a3-66ce4b91cc5mr837296d50.54.1787275220801; Thu, 20 Aug 2026
 18:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813060528.365959-1-kartikey406@gmail.com> <20260813110522.GD1246887@noisy.programming.kicks-ass.net>
In-Reply-To: <20260813110522.GD1246887@noisy.programming.kicks-ass.net>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Fri, 21 Aug 2026 06:50:09 +0530
X-Gm-Features: AcwNN1Xq-0u97UfSOxijlYn8NWJaauIW_R8xaQQaZYfAs9qafwmGEF-mflXoBV8
Message-ID: <CADhLXY783QR01JkL8C1sJh1tBrud-6d=fmovg8wzTqzDzE_PEw@mail.gmail.com>
Subject: Re: [PATCH v2] perf/bpf: Fix data races in BPF perf event handling
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	olsajiri@gmail.com, irogers@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, song@kernel.org, kpsingh@kernel.org, 
	mattbobrowski@google.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, 
	yonghong.song@linux.dev, emil@etsalapatis.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	syzbot+651d2774bd1d8395595f@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 4:35=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>

> As I said yesterday, how can perf_event_detach_bpf_prog() run
> concurrently with __perf_event_overflow()? Unless you answer that, this
> patch ain't moving nowhere.
>


You are right to question this. The KCSAN report from syzbot shows the
race was detected at runtime:

I don't have evidence to prove this race condition.

> > 3. perf_event_alloc() reads parent_event->prog locklessly during
> >    fork() which can race with a concurrent detach clearing and freeing
> >    the prog, potentially causing a NULL pointer dereference or
> >    use-after-free in bpf_prog_inc(). Fix by holding bpf_event_mutex
> >    when inheriting the BPF program. Make bpf_event_mutex non-static
> >    and declare it extern in perf_event.h so it is accessible from
> >    kernel/events/core.c.
>
> This seems like a separate issue and should thus be a separate patch.

Agreed. I will split the perf_event_alloc() fix into a separate patch.

Thanks

Deepanshu
