Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F6A111AB
	for <linux-perf-users@vger.kernel.org>; Wed, 27 Sep 2023 17:27:12 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370AFF4
	for <linux-perf-users@vger.kernel.org>; Wed, 27 Sep 2023 10:27:10 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-56fb25fdf06so10952435a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Sep 2023 10:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695835629; x=1696440429; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=45/FQrKeL8Udcs0UjyYMLebUZXfqqT6VPGukdHqASBY=;
        b=pxkIsUL/CYKNNtXcZ54jqEaRWNI1bRSTOtQ6roFCrUvxWV9z+gRVpfk81GbCzvJNUH
         gUqzv6OJdS1w6EKg5cP8ZnFGhFoU7A0uvR3Ok/cnerZmRjIwkJb58MY+qAbUZvjzPB9q
         ha5MUQUXsSfXOdj/dt9aoAUtuEuPCxxrnxBlj62vaq6X+W46VbEaQ1nE7AXyaTAN6+P+
         m7gD3ZK/P4XZsF71AgkhcU1DjgEzLC6Eq9Y3teJ7l2fOvaH7TKFJbSZEnEhc1lxhOeQc
         zdIPFIGEM0fm5UMD93MU6o2kBdyIv5klLMPtsXBxYP8OQVZ1i+Rc9MjcXOEnA0yaXDr6
         MiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695835629; x=1696440429;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=45/FQrKeL8Udcs0UjyYMLebUZXfqqT6VPGukdHqASBY=;
        b=JNn+xXlqjK6Ozw8C+DAgwUEs3vlkILcUKMy6Gz3b/LNVTtSoCCB221qwVMw3yqTloh
         DEEVU0BQXChM3IlyOqxiALQ/mgZ89oT9LF1CiZ8JNv4JbwesDwwVwiwbmoBcaw80xkjU
         TPNBZM1TTOW2g7qH8gawmEGnfQ5k1RM55U5m1+iuoxKN06WR3do07XSFYaWzpT1yXURF
         mdpN6pn678Om8Y3Rb/WxMRYciKOh9HFmjvReycB81kY95V8Ys45hiy2+HAlcBXc5SLI6
         c1lBAnvQ3vTUt5WvuQ/rve4pNcrwMZ7A24bVWzL5fwCckapZA3JaSQ118ymm1qUB0y6m
         j5VA==
X-Gm-Message-State: AOJu0Yzo2+EOLdacr+GMg31RsaOui5dnpNVDwyTKmJs/b4BOUYFff7Wn
	JlFdXpxLoF9dtLRxSNZoPV2CiydyGhM=
X-Google-Smtp-Source: AGHT+IEo/l8kLAGFPglCwVwc5Xc6q19FVQ0XSzm/QsHADwvKgtDSKq0Zssqfo5n0svX+VvLt6XNOBeajUM0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d501:b0:1c7:217c:3e4b with SMTP id
 b1-20020a170902d50100b001c7217c3e4bmr37979plg.5.1695835629656; Wed, 27 Sep
 2023 10:27:09 -0700 (PDT)
Date: Wed, 27 Sep 2023 10:27:07 -0700
In-Reply-To: <20230927113312.GD21810@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230927033124.1226509-1-dapeng1.mi@linux.intel.com>
 <20230927033124.1226509-8-dapeng1.mi@linux.intel.com> <20230927113312.GD21810@noisy.programming.kicks-ass.net>
Message-ID: <ZRRl6y1GL-7RM63x@google.com>
Subject: Re: [Patch v4 07/13] perf/x86: Add constraint for guest perf metrics event
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Like Xu <likexu@tencent.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zhenyu Wang <zhenyuw@linux.intel.com>, Zhang Xiong <xiong.y.zhang@intel.com>, 
	Lv Zhiyuan <zhiyuan.lv@intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Dapeng Mi <dapeng1.mi@intel.com>, Jim Mattson <jmattson@google.com>, 
	David Dunn <daviddunn@google.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

+Jim, David, and Mingwei

On Wed, Sep 27, 2023, Peter Zijlstra wrote:
> On Wed, Sep 27, 2023 at 11:31:18AM +0800, Dapeng Mi wrote:
> > When guest wants to use PERF_METRICS MSR, a virtual metrics event needs
> > to be created in the perf subsystem so that the guest can have exclusive
> > ownership of the PERF_METRICS MSR.
> 
> Urgh, can someone please remind me how all that is supposed to work
> again? The guest is just a task that wants the event. If the
> host creates a CPU event, then that gets scheduled with higher priority
> and the task looses out, no joy.
> 
> So you cannot guarantee the guest gets anything.
> 
> That is, I remember we've had this exact problem before, but I keep
> forgetting how this all is supposed to work. I don't use this virt stuff
> (and every time I try qemu arguments defeat me and I give up in
> disgust).

I don't think it does work, at least not without a very, very carefully crafted
setup and a host userspace that knows it must not use certain aspects of perf.
E.g. for PEBS, if the guest virtual counters don't map 1:1 to the "real" counters
in hardware, KVM+perf simply disables the counter.

And for top-down slots, getting anything remotely accurate requires pinning vCPUs
1:1 with pCPUs and enumerating an accurate toplogy to the guest:

  The count is distributed among unhalted logical processors (hyper-threads) who
  share the same physical core, in processors that support Intel Hyper-Threading
  Technology.

Jumping the gun a bit (we're in the *super* early stages of scraping together a
rough PoC), but I think we should effectively put KVM's current vPMU support into
maintenance-only mode, i.e. stop adding new features unless they are *very* simple
to enable, and instead pursue an implementation that (a) lets userspace (and/or
the kernel builder) completely disable host perf (or possibly just host perf usage
of the hardware PMU) and (b) let KVM passthrough the entire hardware PMU when it
has been turned off in the host.

I.e. keep KVM's existing best-offset vPMU support, e.g. for setups where the
platform owner is also the VM ueer (running a Windows VM on a Linux box, hosting
a Linux VM in ChromeOS, etc...).  But for anything advanced and for hard guarantees,
e.g. cloud providers that want to expose fully featured vPMU to customers, force
the platform owner to choose between using perf (or again, perf with hardware PMU)
in the host, and exposing the hardware PMU to the guest.

Hardware vendors are pushing us in the direction whether we like it or not, e.g.
SNP and TDX want to disallow profiling the guest from the host, ARM has an
upcoming PMU model where (IIUC) it can't be virtualized without a passthrough
approach, Intel's hybrid CPUs are a complete trainwreck unless vCPUs are pinned,
and virtualizing things like top-down slots, PEBS, and LBRs in the shared model
requires an absurd amount of complexity throughout the kernel and userspace.

Note, a similar idea was floated and rejected in the past[*], but that failed
proposal tried to retain host perf+PMU functionality by making the behavior dynamic,
which I agree would create an awful ABI for the host.  If we make the "knob" a
Kconfig or kernel param, i.e. require the platform owner to opt-out of using perf
no later than at boot time, then I think we can provide a sane ABI, keep the
implementation simple, all without breaking existing users that utilize perf in
the host to profile guests.

[*] https://lore.kernel.org/all/CALMp9eRBOmwz=mspp0m5Q093K3rMUeAsF3vEL39MGV5Br9wEQQ@mail.gmail.com
