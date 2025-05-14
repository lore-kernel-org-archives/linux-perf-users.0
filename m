Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72D120C014
	for <linux-perf-users@vger.kernel.org>; Wed, 14 May 2025 23:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747264780; cv=none; b=GS5bi1hc+hR4g9OKsOnLL1qfsDYufIX9T7wro+xY7MddjiwkVR+aPwxHtU1JoD3DwlzYT2sqPQiZLeJE+1gg6xIWPiJEA5+mhUrVxUMqVXwFk85y1howPQUf1gIWKyRDby0JEvCysHsxKTWk/6RZNGBQxVlZ7tsfGBHpX+PAiDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747264780; c=relaxed/simple;
	bh=cNlVPYYnsQtqPjb2poMyKHUJYGJOPlxbA0jgyo6XDX8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SwcKCGuPwcmrQqXYZZPdF+cNnlTUy8xEye/00RsO6LxisPNqEoovXx8i46FVM+ItdCdMQTHnKnHvVKZS1VH3qET1uyfKj47CNwKAXpNmEAgLO9HcUeiUkP2y1weyNDoW1KibBu1LkuovUqt1dqpmu52j9Iy3n5TaWMDtbA6eVpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T3DNf+WR; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T3DNf+WR"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30ab5d34fdbso346787a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 14 May 2025 16:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747264778; x=1747869578; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=inzL0y+cbDFsyp/vzuyCwIe54VBn5YH91v/9/7m3MOg=;
        b=T3DNf+WRt5TCmAdcQ2vjHChChL+rwFC4OyuabZZXH3xG2eihOqqE0q38YK5UjrXvfK
         g7hSKkygwQRYlIGAsjaZhpH+GYVdZWL/ZAwRBHy6pQmVlG3igiYuBe49tVZ2KkRCyW7+
         qMtGr+/PDlHcMVzt9pM1eBFCS01/nhzQ0oDKgB5JNKWrmLb+Pp1ASpGnBd7xjxZVVpos
         Vw/kSahbU+LOc5hM9k9OB3lJoNIfyl5uO+n1sys9BjncipwhV0SHKay2xB/zO/4froQ9
         2L6rWGMwqhhip/wuTW2gUrx+wlO1CxqFLgUTMFRsG9Jktw1I21fKx1IN1q99p7WjexN1
         aM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747264778; x=1747869578;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=inzL0y+cbDFsyp/vzuyCwIe54VBn5YH91v/9/7m3MOg=;
        b=NXJ8vYNiAArWLkLizZOk//J1+jzAehEuNBwznVAoIkiC7qR3jwSp4eA9UxAJ0KAqUJ
         suEg8ao548Tk1Y9djbYW5rDw9XvsAOKJOnNbQAVuWoikbVAVXuhTtsLkKtc2l0waiND6
         2NPu/vrYdIcQNP2wLx7yS1I7w2aDFVQ7cKGQl/n0vLE8bo1/Go7T34rz04nveRVnQNhE
         MYIVQQqHtDgPZZ92aL3CI2ffLVBh1vQVAC8iXKg2QD9SlJP6NAygHcUeAzXxudO8vwDM
         dP25qPYPZlusqR9w8V3J8D9KnApyRp6V/nczlCcgC8aeksfExeO0mKyI2J24Z6+IS3JL
         09Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUHkMadv5sVQNTNp89lwqHx2XSLucspqnqSsDY3kc5CqEzq0fqGIWjK/v6ji7vXSh+/9Y56fxR8kUdrGsnpNaGe@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8mFUlFcRZLqbePPxMfu0guVynwLA4NtF9S+3vSXshb2C3QIwN
	oYF92UDSYYsNHIPgYAGTK+7TIm8O3tFa7aRz5B5HmDka6MZFoY8ZjNSliRRdRsj3Ov5u+4K4GYZ
	9nA==
X-Google-Smtp-Source: AGHT+IGCQ/sRX+3EYNcQDJbTeqc67xnpDL/NXZuajHJEmLyvMC58UdBnQowu6qn5H0+QlUsXIshKg9Pma6c=
X-Received: from pjn12.prod.google.com ([2002:a17:90b:570c:b0:2ef:8055:93d9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17d2:b0:30a:214c:24c9
 with SMTP id 98e67ed59e1d1-30e2e5d612dmr7495408a91.3.1747264778031; Wed, 14
 May 2025 16:19:38 -0700 (PDT)
Date: Wed, 14 May 2025 16:19:36 -0700
In-Reply-To: <20250425111352.GF1166@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-6-mizhang@google.com>
 <20250425111352.GF1166@noisy.programming.kicks-ass.net>
Message-ID: <aCUlCApeDM9Uy4a0@google.com>
Subject: Re: [PATCH v4 05/38] perf: Add generic exclude_guest support
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mingwei Zhang <mizhang@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yongwei Ma <yongwei.ma@intel.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Jim Mattson <jmattson@google.com>, 
	Sandipan Das <sandipan.das@amd.com>, Zide Chen <zide.chen@intel.com>, 
	Eranian Stephane <eranian@google.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 25, 2025, Peter Zijlstra wrote:
> On Mon, Mar 24, 2025 at 05:30:45PM +0000, Mingwei Zhang wrote:
> 
> > @@ -6040,6 +6041,71 @@ void perf_put_mediated_pmu(void)
> >  }
> >  EXPORT_SYMBOL_GPL(perf_put_mediated_pmu);
> >  
> > +static inline void perf_host_exit(struct perf_cpu_context *cpuctx)
> > +{
> > +	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
> > +	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_GUEST);
> > +	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);
> > +	if (cpuctx->task_ctx) {
> > +		perf_ctx_disable(cpuctx->task_ctx, EVENT_GUEST);
> > +		task_ctx_sched_out(cpuctx->task_ctx, NULL, EVENT_GUEST);
> > +		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
> > +	}
> > +}
> > +
> > +/* When entering a guest, schedule out all exclude_guest events. */
> > +void perf_guest_enter(void)
> > +{
> > +	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
> > +
> > +	lockdep_assert_irqs_disabled();
> > +
> > +	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
> > +
> > +	if (WARN_ON_ONCE(__this_cpu_read(perf_in_guest)))
> > +		goto unlock;
> > +
> > +	perf_host_exit(cpuctx);
> > +
> > +	__this_cpu_write(perf_in_guest, true);
> > +
> > +unlock:
> > +	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
> > +}
> > +EXPORT_SYMBOL_GPL(perf_guest_enter);
> > +
> > +static inline void perf_host_enter(struct perf_cpu_context *cpuctx)
> > +{
> > +	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
> > +	if (cpuctx->task_ctx)
> > +		perf_ctx_disable(cpuctx->task_ctx, EVENT_GUEST);
> > +
> > +	perf_event_sched_in(cpuctx, cpuctx->task_ctx, NULL, EVENT_GUEST);
> > +
> > +	if (cpuctx->task_ctx)
> > +		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
> > +	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);
> > +}
> > +
> > +void perf_guest_exit(void)
> > +{
> > +	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
> > +
> > +	lockdep_assert_irqs_disabled();
> > +
> > +	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
> > +
> > +	if (WARN_ON_ONCE(!__this_cpu_read(perf_in_guest)))
> > +		goto unlock;
> > +
> > +	perf_host_enter(cpuctx);
> > +
> > +	__this_cpu_write(perf_in_guest, false);
> > +unlock:
> > +	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
> > +}
> > +EXPORT_SYMBOL_GPL(perf_guest_exit);
> 
> This naming is confusing on purpose? Pick either guest/host and stick
> with it.

+1.  I also think the inner perf_host_{enter,exit}() helpers are superflous.
These flows

After a bit of hacking, and with a few spoilers, this is what I ended up with
(not anywhere near fully tested).  I like following KVM's kvm_xxx_{load,put}()
nomenclature to tie everything together, so I went with "guest" instead of "host"
even though the majority of work being down is to shedule out/in host context.

/* When loading a guest's mediated PMU, schedule out all exclude_guest events. */
void perf_load_guest_context(unsigned long data)
{
	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);

	lockdep_assert_irqs_disabled();

	perf_ctx_lock(cpuctx, cpuctx->task_ctx);

	if (WARN_ON_ONCE(__this_cpu_read(guest_ctx_loaded)))
		goto unlock;

	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_GUEST);
	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);
	if (cpuctx->task_ctx) {
		perf_ctx_disable(cpuctx->task_ctx, EVENT_GUEST);
		task_ctx_sched_out(cpuctx->task_ctx, NULL, EVENT_GUEST);
		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
	}

	arch_perf_load_guest_context(data);

	__this_cpu_write(guest_ctx_loaded, true);

unlock:
	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
}
EXPORT_SYMBOL_GPL(perf_load_guest_context);

void perf_put_guest_context(void)
{
	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);

	lockdep_assert_irqs_disabled();

	perf_ctx_lock(cpuctx, cpuctx->task_ctx);

	if (WARN_ON_ONCE(!__this_cpu_read(guest_ctx_loaded)))
		goto unlock;

	arch_perf_put_guest_context();

	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
	if (cpuctx->task_ctx)
		perf_ctx_disable(cpuctx->task_ctx, EVENT_GUEST);

	perf_event_sched_in(cpuctx, cpuctx->task_ctx, NULL, EVENT_GUEST);

	if (cpuctx->task_ctx)
		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);

	__this_cpu_write(guest_ctx_loaded, false);
unlock:
	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
}
EXPORT_SYMBOL_GPL(perf_put_guest_context);
