Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D07111AF
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Oct 2023 11:33:14 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47ED2A7;
	Wed,  4 Oct 2023 04:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=LgTiEbkbWU/3dLeZ3ndl5aQ62XZwVSgJEp3sPp3BvRc=; b=IRxNn1UqLy+vTJM/bW1VgjMao3
	NvMCUspVk2mwGp0Ab0bQosB3DQJivBzggsXhKjIaiH871I0oHLkonKlLszjs14ZxPliBceljl4Z42
	xeb1Qyka3GIacctWSZmYGdK5PaCP94P2P2xFfatjLAeOAv8v8du001Uu1u8za51Fm/6BvEVUarV7p
	JtYfXvEwkTjvYnGPpOLM/bt9B68DXWSgVZqZUNGf83+Tfv6/hfwS4OiHlP7vY3S8tiJOL6WLLll70
	l0fwyN3Wrs5xttrnqrH0z3t/J95bWKm0x6G8GbrjxjMhDLdrvgLpCAy60o76REIr5uaM8Z0kPIRqS
	+4hI4UYA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qo07W-0037n5-SQ; Wed, 04 Oct 2023 11:32:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5CE08300392; Wed,  4 Oct 2023 13:32:50 +0200 (CEST)
Date: Wed, 4 Oct 2023 13:32:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Ingo Molnar <mingo@kernel.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Like Xu <likexu@tencent.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, kvm@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zhenyu Wang <zhenyuw@linux.intel.com>,
	Zhang Xiong <xiong.y.zhang@intel.com>,
	Lv Zhiyuan <zhiyuan.lv@intel.com>,
	Yang Weijiang <weijiang.yang@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>, David Dunn <daviddunn@google.com>,
	Mingwei Zhang <mizhang@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Patch v4 07/13] perf/x86: Add constraint for guest perf metrics
 event
Message-ID: <20231004113250.GB5947@noisy.programming.kicks-ass.net>
References: <20230929115344.GE6282@noisy.programming.kicks-ass.net>
 <ZRbxb15Opa2_AusF@google.com>
 <20231002115718.GB13957@noisy.programming.kicks-ass.net>
 <ZRrF38RGllA04R8o@gmail.com>
 <ZRroQg6flyGBtZTG@google.com>
 <20231002204017.GB27267@noisy.programming.kicks-ass.net>
 <ZRtmvLJFGfjcusQW@google.com>
 <20231003081616.GE27267@noisy.programming.kicks-ass.net>
 <ZRwx7gcY7x1x3a5y@google.com>
 <CALMp9eRew1+-gDy36m3qWy9D9TQP+mkzPQg=xowKcaG+NpbX0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALMp9eRew1+-gDy36m3qWy9D9TQP+mkzPQg=xowKcaG+NpbX0w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 03, 2023 at 11:21:46AM -0700, Jim Mattson wrote:
> On Tue, Oct 3, 2023 at 8:23 AM Sean Christopherson <seanjc@google.com> wrote:

> > > Since you steal the whole PMU, can't you re-route the PMI to something
> > > that's virt friendly too?
> >
> > Hmm, actually, we probably could.  It would require modifying the host's APIC_LVTPC
> > entry when context switching the PMU, e.g. to replace the NMI with a dedicated IRQ
> > vector.  As gross as that sounds, it might actually be cleaner overall than
> > deciphering whether an NMI belongs to the host or guest, and it would almost
> > certainly yield lower latency for guest PMIs.
> 
> Ugh.  Can't KVM just install its own NMI handler? Either way, it's
> possible for late PMIs to arrive in the wrong context.

I don't think you realize what a horrible trainwreck the NMI handler is.
Every handler has to be able to determine if the NMI is theirs to
handle.

If we go do this whole swizzle thing we must find a sequence of PMU
'instructions' that syncs against the PMI, because otherwise we're going
to loose PMIs and that's going to be a *TON* of pain.

I'll put it on the agenda for the next time I talk with the hardware
folks. But IIRC the AMD thing is *much* worse in this regards than the
Intel one.
