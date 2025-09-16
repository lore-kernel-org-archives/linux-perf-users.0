Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4281283FE1
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Sep 2025 20:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053277; cv=none; b=cdqsp7eGlbBbEqvSw6So6Uq2042kXmULT10i0iOKX98DbfEwj/GVgsT1FiguWieCgaf7nrhQ6b6FLFr8IVCGW1NViNEKrZgrYUsoUk/I0YDfeQOZo/L3J2TqItQmCR6qFGm8Qlt++sqKcnZOxdOtZAQWYGI9NPpHsRMF2OP+UNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053277; c=relaxed/simple;
	bh=zAgc80zVWEamKL0fX3pawReQ9UvOTax2idkMr1tnxJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLmhsZBJv3llvsIzOGejf8MjtPJOCW8wbOfGhPe+INrAjpdefnP9I2Ewysjj9GIY3EXNTVK0K8Z40Triy/wH0t09zZj6erRs8x99tU1AnJcLpsai12R3No8LyhPZ2eY+szIMd2nnd99LKKvjD6r/cq84cHOanu5I4VTv9MObJjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i5bQ4U2z; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i5bQ4U2z"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-265abad93bfso42215ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Sep 2025 13:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758053275; x=1758658075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmX2dG89z9s4QzftVPzn9RGiKlTrvwKXZrja38EG3uw=;
        b=i5bQ4U2zw99JwjG5Pq7JDh0e16Mv5U6N35vZ6MYdvbFtqrISXCxabPPK3+feRJ9M9S
         Wj8aXlfIRK6DSMyipZ10SRZJ55ubAY5dOWXCEsK6BfDuJUPKfDQyKGJNXaKv9j2MJJYH
         KNuhe/yCavmbHoLS8td/FJXuZtaovq00eK12QqEbPbQCG9Soq/6GmXvjycx+vhnh2o+P
         sza195N4yVu/LVJZcGArMTiBuWROdrpBx+EzNozzwLe/SGfWIZYVYo22rBnr4rlaDw6Y
         clJYw8pFT/nYhGJ/2nR59VUbQznMFaNFCRhLJnsYIfoQF3F1AvXCVVcu5kf8k8XlUC2O
         cCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758053275; x=1758658075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmX2dG89z9s4QzftVPzn9RGiKlTrvwKXZrja38EG3uw=;
        b=mT7n6zG8EqyVsrlPVrfAj4guKv9p5nSY2qdBhwUWMOMQQE/QOAXCZ3ZoOj9Z2hWAFR
         E0xOQZwRlyS2dhtchG4m1tjkvpjS/N+Cl0rpezozN1q2fEbysTXhhf0S+Ili9qIQOl1Q
         hApQc2dxXDVJMet0QKKytmNYiaYGeGKKINlPdsDTsmXF/NdcwuMzMRC9BvXe9B/BI1Lb
         +uG+MizxFZ1Xt20Ea6xxOQJmIfsMMYvigxhhUOK11AOGNpOhhwvMPHjRHMGKz0Z1tEEl
         +MYYyK/qvTHX3O1wUAAJcLg7+F9U4Br7vKE5qgM4gL92CTco8R3ynhnTbXsx9LPQfjWw
         BnKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWohK0aIl2afQJmcEw3B4jPbWx1IJP0CENsq/odNPPoapjdd3Lrez3U/VekAOxVMkItsCXskz/G6oopgl4WE4pf@vger.kernel.org
X-Gm-Message-State: AOJu0YxBrnRXZH8oRJ7VdWNZMvYWh6MxwP+rpdDN08UI37isfamCxhyW
	M/cO5DTrRSMEwss+Qi3RpA+G/EJyz4w2RvFcI9dxoft8dCxroH3D2SrnqlMy2brfMFqvqBBsyLA
	dt65cha77kN4jxP4Ufz4Ng5AmSG1QKj1IXJ1Lhbz9
X-Gm-Gg: ASbGnctQOuE00h8VuWPCDrbcyByEUn4tXJJ1GDZk1/UYuWfH+oFqvZDZ+tl8KKozE8o
	PNLwVZKHnjPxnOQGt/4yKCGtfB3kZoi/3C0vah/OiHbQvxi5e7naJLSThqBPAECQU1Z6uUs0IhI
	DFs7UkwS9yFFS6LqSOpKz9++7pW6ewsDjosB59S8/cHtnNUTfhG746p1a7gGktty7H/DDsa7kIh
	2VTAYX6hj47K5NMnA5fF9ew9G7F58LD+uUTm1eJDI/S7zh1V0wUbYU=
X-Google-Smtp-Source: AGHT+IGEuWVr23Zz1x5JlKHMYy4pYv6g5d4MtP765YpFDF3VkFTqqK2qZwJG2KZRGdDkNbo90uHaTUkmxi8HBKVltB8=
X-Received: by 2002:a17:902:e88c:b0:246:1f3e:4973 with SMTP id
 d9443c01a7336-26800f4ba2cmr1245035ad.6.1758053274798; Tue, 16 Sep 2025
 13:07:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728055937.58531-1-gautam@linux.ibm.com> <aMlmiHATn5WHUcSM@mac.in.ibm.com>
 <aMm5uvPsMfXEv8Oo@x1>
In-Reply-To: <aMm5uvPsMfXEv8Oo@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Sep 2025 13:07:43 -0700
X-Gm-Features: AS18NWBWsbgYiyExLr3xwCIKJ6z7cZXGocyZLej862MS88dpO_SC3EbWWLuO17s
Message-ID: <CAP-5=fW4JQYJ2NCRsRVePidCcZ9+JcQbfY=xQ00xZG-bSn96ew@mail.gmail.com>
Subject: Re: [PATCH 0/2] perf python: Add an example for sampling
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Gautam Menghani <gautam@linux.ibm.com>, peterz@infradead.org, mingo@redhat.com, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	maddy@linux.ibm.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 12:25=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Sep 16, 2025 at 07:00:48PM +0530, Gautam Menghani wrote:
> > Hi Ian/Arnaldo,
> >
> > Can you please review this series and let me know if any changes are
> > needed?
>
> Looking at it now, sry for the delay,

I think the patches look good. I'm a little concerned that the python
APIs are a chance to do something better than the C APIs that have
evolved. For example, we removed UID out of target recently [1] as the
BPF alternative was better. Had this patch come earlier then it seems
likely we'd have had target with UIDs. I wonder rather than having a
kwlist of:

+ static char *kwlist[] =3D { "target", "inherit_stat", "no_buffering",
"no_inherit",
+ "no_inherit_set", "no_samples", "raw_samples",
+ "sample_address", "sample_phys_addr", "sample_data_page_size",
+ "sample_code_page_size", "sample_weight", "sample_time",
+ "sample_time_set", "sample_cpu", "sample_identifier",
+ "sample_data_src", "period", "period_set", "running_time",
+ "full_auxtrace", "auxtrace_snapshot_mode",
+ "auxtrace_snapshot_on_exit", "auxtrace_sample_mode",
+ "record_namespaces", "record_cgroup", "record_switch_events",
+ "record_switch_events_set", "all_kernel", "all_user",
+ "kernel_callchains", "user_callchains", "tail_synthesize",
+ "overwrite", "ignore_missing_thread", "strict_freq", "sample_id",
+ "no_bpf_event", "kcore", "text_poke", "build_id", "freq",
+ "mmap_pages", "auxtrace_mmap_pages", "user_freq", "branch_stack",
+ "sample_intr_regs", "sample_user_regs", "default_interval",
+ "user_interval", "auxtrace_snapshot_size", "auxtrace_snapshot_opts",
+ "auxtrace_sample_opts", "sample_transaction", "use_clockid",
+ "clockid", "clockid_res_ns", "nr_cblocks", "affinity", "mmap_flush",
+ "comp_level", "nr_threads_synthesize", "ctl_fd", "ctl_fd_ack",
+ "ctl_fd_close", "synth", "threads_spec", "threads_user_spec",
+ "off_cpu_thresh_ns",  NULL };

but then just using this subset:

+    opts =3D perf.record_opts(freq=3D1000, target=3Dtgt, sample_time=3DTru=
e,
+                            sample_cpu=3DTrue, no_buffering=3DTrue,
no_inherit=3DTrue)

The kwlist should be kept to just those necessary values for the
example to work? I kind of see this as Arnaldo's baby, so he may just
want everything, so this needn't be a blocker.

Bigger picture I wonder about migrating the `perf script` code to just
being regular python programs like the example here. I sent out
deprecating the libperl code to this ends (looking for reviews):
https://lore.kernel.org/linux-perf-users/20250908181918.3533480-1-irogers@g=
oogle.com/
The issue is that `perf script` being the main thread inhibits things
like textual running until trace_end. This means we can't do things
like incremental loading support. We may want to make the perf events
support something like an asyncio interface for that.

Refactoring that support will likely raise backward compatibility
concerns. It'd be a really nice thing to do as the API has some fairly
major overheads like turning everything in a sample into a Dict
whether needed or not:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/tools/perf/util/scripting-engines/trace-event-python.c#n838
I mention this just to say why I'd like to minimize the API when possible.

Thanks,
Ian

[1] https://lore.kernel.org/r/20250604174545.2853620-10-irogers@google.com
