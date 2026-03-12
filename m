Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4743CCFDA
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327980; cv=pass; b=gY0EbsRPGVZYLlY0FSGM0twa4o1a/5e1oZbJyUjBND/gqu/8XQxuWLoOVmuZCP+RoeK4M/c/eL/d9mOKA0cWlN4oJVWXQB9OhTqZwjpzXyoSSU6RjnY1PgA8P7rgIhJcMu19Ts+TlSqxkMuZoDtz9uWIKSGTxzspHYgy56j34Ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327980; c=relaxed/simple;
	bh=3bEc7zXpPGSWGeMzJFpf3TrxB/6DLDB2N6Ulw7Kod0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OytonQwZLLg1Svtxtcd07VFr+wl25TxPzOanGaO0Gvr3/CrlgRvl1G+dsEi5Ln8J+rmUOPyTIgG+DFaiqKqCAtQ+pJKkxa9EOUvwjQFQtz2sM7G+wROKLoD1IAgRTxgocorSu54ZjtGAKYE1ei1dPUOiNsRWco1/vuVbJf4k8Go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TnstBzE3; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TnstBzE3"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aeab6ff148so87265ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 08:06:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773327979; cv=none;
        d=google.com; s=arc-20240605;
        b=KY09ZdgZjFn5TqpKu3xxT+rre2G7J9tOJ5GHNV2cH1aw4h/HVgDuWi3/kWrlEOAZZ+
         zgk9cezXdckTpFI2h/+g5opAcZ6D0xEfsDJRRdFNH8skiTdTRYsIqpWnfsBDj0HvT3dr
         Cv9d4CykcXCURZKr+vpn3NSSaTNzop9FhuJvUu5wKmWV6ItR6dUcOE5Smmq4w5CPcNcP
         tTMY9Jcu5SafJTmJrkB/YYnfO1u1bq12KLBcB1BBx73XZ54T95wpV/IMn9RcYxVqYmIY
         lD35Ios1vayDpljG1qzwUlXGytfCunBCfQJr9aAuTclGdeL8SuJgZrk5MfS1qDJfKheg
         gdqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dPJt4hq+3TiZfg/kVtWwc5jUDVVMFdS/nDlP1F8NOEE=;
        fh=8eaJ4XmI5CcMW1aCTYltpliyP2F6xJCy9QSJ6DexPbM=;
        b=cAtAkt9f9wst6tNxQaD4k59Er0/N2HHt8koKcxo3MXlOprt0Ue9PgkmpRXCze8iBas
         IqP+6Ub/361f3ZfYfT5doPkzQMUsc3x7JgyEBWCF9oIefyiDyOJFsyAIPb02aKYjMLwb
         5F5ySsRSKpYLCwbsXCJYErVv6xSZpV7bBRd4TtFhE7A/sJiupGlY9HmjpKYkdNIsMh5V
         Vtp26USH5UVBjZOwCpxv80DDhY7OdBj+cGZf8l9K7x+lxRhQXFBIzP+d+4rBH5QkXOgf
         oovcgwHzme50xTUPrgvi1kBM/FWXbUsfP8OU/jp1Gfk7BJfP9IL2UfyC89zHzwaqghq3
         knWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773327979; x=1773932779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPJt4hq+3TiZfg/kVtWwc5jUDVVMFdS/nDlP1F8NOEE=;
        b=TnstBzE3E0gC1coKZtro6GNslKOr3NuaTqpX9amvu1YgTt4pwj43P713e51RrE5gix
         7pg5yoU3Tj5ij8FUDGJ0xt/1RD4cBQlPq+OcrMLopWlcxfW2Ciip97oB33fFWc/BuHcX
         EMgf7us1W81nfRten89ZjyQElhdMm+tH4dc9AbAMHG7lcuhi8uatEL68QD9ysT6ETAam
         sqmt4aY6R/e3z4aa7ez2W827/y5NAWZ42mMpC1QZ4hBf6FqoAVqbdwFyh5nQVwtFG26U
         O0msdu1XhcE/L3L3XtUvKvX3/59AhH2AE6TEGTozcVoG1IOh0Tmui1Ols2nYbAxOYJ+c
         4tQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773327979; x=1773932779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dPJt4hq+3TiZfg/kVtWwc5jUDVVMFdS/nDlP1F8NOEE=;
        b=MVsmzfNoNlaP85ANpK7yev7j5Kr6UOsWj62tKDwkapqr9glZhercTHlHBw5/puH6gM
         VtbfNnWfSiVbWtu/wRcVnshcTgYmDk5T8zdz3T7XXKXfv5J6b1QO9cO6rheOYekKJXKb
         pXogP+lr9Qu3oux9PraaATApJnFx0qqVwhOVg1bYb069Yw7wXl+JjqIrGtGJTagJ1aIh
         OpUXwJbXzRreeqBENKkfmHyMt2rL3/g0FA0uqTu48ckRmKNYVnDxXeyJ/7szgVO0VMXx
         V1oWuSZxCDUXltk0uKXXnKDXgsD7hXDUE+v+I8VQUqDLm3nv9hjykPZcCgnVR1zAtLgu
         np4w==
X-Forwarded-Encrypted: i=1; AJvYcCVGSsjPsjqdyG9VuZUefkQ/AhWsG2SrVtWrxM8KzNKUQIo1JQ22bbHzC6RTkIwcbSDYskht5IHSyf7+DUU8Rz4m@vger.kernel.org
X-Gm-Message-State: AOJu0YxHEoAKKC/6b9fDc2hmGYZxU9B4UMZE4tSbuoi5WluEIc4t1Wfp
	cyxRl4sgajYdthz/0uePaRg2uuS6Iu+9Dig5ZTu74SMMNXbmsH6cqkF63JCXlN5ytfJ52SvSZ/q
	mbmD/wlZGUEERYg/tc2uvH18wuR2ZJcOOznDb6W22
X-Gm-Gg: ATEYQzxi7UM2hJLvxJP/8NjVoVtPCXg2dZK6rgsEOxjhNdpt80QD1w7el/rTOJblLGg
	CEJGoDakkhAJHhmigTj86Kz1Uks40p8OzZG4L4WsAfM5wxwi6vFhwnxJiM/obSuVt8rQbgj65Uj
	aaZXZm8r4iKq26x4ej/NWGR8VrKAJlipLYk8RQY5Mw7zfinWImlsiFiRwEdCVlWrRrTRS+ZjZDJ
	9TdOgx2jcDMUP52tGhGGTyzzByF0F7V+pp+fyUNwASK80ipZE43B4vDOQd+am6zRoZI7wDvAixD
	OcvLzEn3bHhHJ84JeaZAJwoQETNLE/cVkDs1
X-Received: by 2002:a17:903:b83:b0:2ad:6f9b:7817 with SMTP id
 d9443c01a7336-2aebae51554mr2810885ad.22.1773327978165; Thu, 12 Mar 2026
 08:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fUBy-vzdSB3xsuyU+AKd8o99R7DLgoyyJHxb6Shkfb-8w@mail.gmail.com>
 <20260312054810.1571020-1-irogers@google.com> <20260312054810.1571020-2-irogers@google.com>
 <20260312084050.GE606826@noisy.programming.kicks-ass.net>
In-Reply-To: <20260312084050.GE606826@noisy.programming.kicks-ass.net>
From: Ian Rogers <irogers@google.com>
Date: Thu, 12 Mar 2026 08:06:06 -0700
X-Gm-Features: AaiRm52qyymH67SE-R7y17rW19rTMSeHqzI6ak_nWzbO6DOcLA1kqiGDgbLyXJg
Message-ID: <CAP-5=fWstOeQSJE=YU6qRVNyrrvQBMv4Nf+mCFMYfbyCbdVCyg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf/x86: Reduce is_hybrid calls and aid ellision
 of BUG_ON in hybrid_pmu
To: Peter Zijlstra <peterz@infradead.org>
Cc: dapeng1.mi@intel.com, dapeng1.mi@linux.intel.com, acme@kernel.org, 
	adrian.hunter@intel.com, ak@linux.intel.com, 
	alexander.shishkin@linux.intel.com, eranian@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, namhyung@kernel.org, thomas.falcon@intel.com, 
	xudong.hao@intel.com, zide.chen@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 1:40=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Mar 11, 2026 at 10:48:10PM -0700, Ian Rogers wrote:
> > Use the capabilities of the PMU rather than the global variable
> > perf_is_hybrid to determine if a hybrid pmu has been passed to the
> > main accessors. As the pmu capabilities check mirrors that in
> > is_x86_pmu, the BUG_ON(!is_x86_pmu...) in hybrid_pmu can be elided as
> > it is provably always false (with sufficient function inlining, common
> > sub-expression elimination, etc.) in its most common uses.
>
> perf_is_hybrid is not a variable, its a static_branch. You're adding a
> runtime branch here, for no appreciable benefit.
>
> And while (Intel) client seems flooded with this hybrid nonsense,
> servers are still sane. Also AMD have uniform PMU across their regular
> and compact cores and don't need this either.

Agreed, and the AI review (set up similarly to how Dapeng suggested)
also agrees with you:

  Additionally, does replacing the is_hybrid() static branch with a dynamic
  pointer dereference and bitwise check introduce unnecessary overhead on h=
ot
  paths (like NMIs and context switches) for non-hybrid x86 CPUs?

This is missing what the next patch does: it introduces a dominating
branch, meaning the BUG_ON condition is known to be false at compile
time if reasonable compiler optimizations are enabled - possibly
better than a nop, although perhaps the static_branch makes the
initial capabilities check a nop too. Anyway, this series was
primarily meant to catch other inadvertent container_ofs and isn't
something that needs to be in production code. I just couldn't see an
easy way to do the equivalent of "ifndef NDEBUG". Given the comments
on the next patch I suggest we don't adopt the changes, but I'll add
some more feedback in that patch.

Thanks,
Ian
