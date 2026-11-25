Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795643965;
	b=hchvcusFM56cGdyP9a6pTqA0hvFHmwaoashErCxPO2sVGTsF6PUGWweEkGDkOvWk/2YI
	 rQiQglIy5vSj2qfRjSSlOFdoEnsyYhAYsyRyx/RFw1Q2owCkCC1fvgX+rqCdv3V3Or/YP
	 6FXJ/nC3RaU4wNP9O7ow+4C9Rtfgf7uJyCgil4eyP31Xw840dT7MyLa+a2A0mZf2Ns69V
	 RZTtHPQFsBz2qe6U/kMGErrnCwsR7ROKJg/wCGVtSWBvk+cK9EkiBIk1AJTHwE3j66bvB
	 p4/wTRcb2toWP3YqrkkYgpSo6TQjYLKhRG4cOENWZcFbPSwds4midEjssElxvsR42qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795643965;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=IdHNmCQbBc67OBro9jziYaYbfNM/pQVZLaQMGPyirXY=;
	b=ecjd91G6nlti2nFJ/+aUzW8eRg/D0FhfkN8yYadfx6qOb9nOHAcBgo9dv9TinHe+cDef
	 xKCsNVMqSqe1/sICm1fM/8tfWdPjWaPE86mPy/NULh/5nNimlg63SwZGWCo6CJtm0vxdF
	 qa1j6jt1O+veKm/M89GbLF0nl7sVjnZI6ZbZiLuWDmGO6vRQVNnJFI0n/G0CP3/dBEOMq
	 XPHGO+hQIyJP5YLOrxruoo+d1Z4O77af2DXkAGEKkJIX4BVKHMNJoQ0ddWhPdIXElf7Cj
	 Co4ktb7kGemDZQcgjNgMu3ZVUaP8qgU6t0B4rwOVxH9DEt1Izc0+81WbZXcZP5ewD9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9sL9aIi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0548E606A31E;
	Wed, 25 Nov 2026 21:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9sL9aIi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0E11F000C6;
	Wed, 25 Nov 2026 21:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795643964;
	bh=IdHNmCQbBc67OBro9jziYaYbfNM/pQVZLaQMGPyirXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M9sL9aIibZE0Mvp3Ku6NhT56E2nTC238W8hTylc/T0DQfCpWvduXtNy9Vsz6Utsqz
	 3qB3Dt0F+Tk/XR+r23dy2UPxvuxhnF4VZl1XlphH4n//OzIZurYwuhCKQtBwUGDN2p
	 fiafjd8Vv4STOSsfvotK187NG2/q3jwnIt45owzo2BW/CFuvmAx+qStBRHAP0rLYOp
	 xey1Odr8JdUVFLhVT2IzDtRXHnHaehFa8SxRtGoXg6JHsgVa4kTk1xbQ0tTf1pmXl+
	 TX6ELFEUpVk1af3KmwqBe/5mlxfudsONiqnIaPnAbdxW0JLYsshA9LJN0FuEU1qN+J
	 ThMGNm1PYh4sw==
Date: Wed, 25 Nov 2026 13:59:22 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Leo Yan <leo.yan@linux.dev>, Dmitry Vyukov <dvyukov@google.com>,
	"Steinar H . Gunderson" <sesse@google.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/19] perf/uapi: Add BUILD_ID_OFFSET sample types to
 UAPI
Message-ID: <awdaOldoL7p1Y_Sz@google.com>
References: <20261116074414.3174737-1-irogers@google.com>
 <20261116074414.3174737-4-irogers@google.com>
 <6F41ABBE-16A3-4B1F-96C0-D6369D5A5A55@linux.ibm.com>
 <CAP-5=fU-tWJM7brF=YJGfX0fbdivH-oFDo0s=PCt-UcQcqEEfA@mail.gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU-tWJM7brF=YJGfX0fbdivH-oFDo0s=PCt-UcQcqEEfA@mail.gmail.com>

On Tue, Nov 24, 2026 at 01:00:06PM -0800, Ian Rogers wrote:
> On Tue, Nov 24, 2026 at 2:36 AM Athira Rajeev <atrajeev@linux.ibm.com> wrote:
> >
> >
> >
> > > On 16 Nov 2026, at 1:13 PM, Ian Rogers <irogers@google.com> wrote:
> > >
> > > Introduce PERF_SAMPLE_BUILD_ID_OFFSET and
> > > PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET in enum perf_event_sample_format.
> > >
> > > For PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET (and
> > > PERF_RECORD_CALLCHAIN_DEFERRED when PERF_RECORD_MISC_MMAP_BUILD_ID is
> > > set), encode a deduplicated table of variable-length build IDs
> > > (u32 nr_build_ids, u32 nr_offsets, followed by packed { u8 size;
> > > u8 data[size]; } entries padded to 8-byte alignment) and an array of
> > > 64-bit offsets whose top 8 bits encode the 1-based build ID index (or
> > > 0x00 for unresolved user addresses and 0xff for kernel/context entries).
> > > In common cases where multiple callchain frames belong to the same
> > > binary, each unique build ID is encoded only once.
> > >
> > > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > > include/uapi/linux/perf_event.h | 59 ++++++++++++++++++++++++++++++---
> > > 1 file changed, 54 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > > index deb7c42d109b..775420ed9aee 100644
> > > --- a/include/uapi/linux/perf_event.h
> > > +++ b/include/uapi/linux/perf_event.h
> > > @@ -165,8 +165,10 @@ enum perf_event_sample_format {
> > > PERF_SAMPLE_DATA_PAGE_SIZE = 1U << 22,
> > > PERF_SAMPLE_CODE_PAGE_SIZE = 1U << 23,
> > > PERF_SAMPLE_WEIGHT_STRUCT = 1U << 24,
> > > + PERF_SAMPLE_BUILD_ID_OFFSET = 1U << 25,
> > > + PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET = 1U << 26,
> > >
> > > - PERF_SAMPLE_MAX = 1U << 25, /* non-ABI */
> > > + PERF_SAMPLE_MAX = 1U << 27, /* non-ABI */
> > > };
> > >
> > > #define PERF_SAMPLE_WEIGHT_TYPE (PERF_SAMPLE_WEIGHT | PERF_SAMPLE_WEIGHT_STRUCT)
> > > @@ -840,7 +842,8 @@ struct perf_event_mmap_page {
> > >  *
> > >  *   PERF_RECORD_MISC_EXACT_IP           - PERF_RECORD_SAMPLE of precise events
> > >  *   PERF_RECORD_MISC_SWITCH_OUT_PREEMPT - PERF_RECORD_SWITCH* events
> > > - *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 event
> > > + *   PERF_RECORD_MISC_MMAP_BUILD_ID      - PERF_RECORD_MMAP2 and
> > > + *                                         PERF_RECORD_CALLCHAIN_DEFERRED events
> > >  *
> > >  *
> > >  * PERF_RECORD_MISC_EXACT_IP:
> > > @@ -852,7 +855,7 @@ struct perf_event_mmap_page {
> > >  *   Indicates that thread was preempted in TASK_RUNNING state.
> > >  *
> > >  * PERF_RECORD_MISC_MMAP_BUILD_ID:
> > > - *   Indicates that mmap2 event carries build ID data.
> > > + *   Indicates that mmap2 or deferred callchain event carries build ID data.
> > >  */
> > > #define PERF_RECORD_MISC_EXACT_IP (1 << 14)
> > > #define PERF_RECORD_MISC_SWITCH_OUT_PREEMPT (1 << 14)
> > > @@ -1095,6 +1098,38 @@ enum perf_event_type {
> > > * { u64 code_page_size;} && PERF_SAMPLE_CODE_PAGE_SIZE
> > > * { u64 size;
> > > *  char data[size]; } && PERF_SAMPLE_AUX
> > > + * { union {
> > > + * struct {
> > > + * struct perf_build_id bid;
> > > + * u64 offset;
> > > + * };
> > > + * struct {
> > > + * u64 zero;
> > > + * u64 context;
> > > + * u64 cookie;
> > > + * u64 ip;
> > > + * }; && attr.defer_callchain
> > > + *  }; } && PERF_SAMPLE_BUILD_ID_OFFSET
> > > + * { u32 nr_build_ids;
> > > + *  u32 nr_offsets;
> > > + *  struct {
> > > + * u8 size;
> > > + * u8 data[size];
> > > + *  }[nr_build_ids];
> > > + *  u8 pad[];
> > > + *  u64 offsets[nr_offsets];
> > > + *  #
> > > + *  # Entries in offsets[] include PERF_CONTEXT_* markers (which
> > > + *  # have top 8 bits 0xff). Kernel/hypervisor entries (after
> > > + *  # PERF_CONTEXT_KERNEL, PERF_CONTEXT_HV, PERF_CONTEXT_GUEST,
> > > + *  # or PERF_CONTEXT_GUEST_KERNEL) and the cookie word following
> > > + *  # PERF_CONTEXT_USER_DEFERRED are raw 64-bit values. User
> > > + *  # entries (after PERF_CONTEXT_USER or PERF_CONTEXT_GUEST_USER,
> > > + *  # or in PERF_RECORD_CALLCHAIN_DEFERRED) use the top 8 bits to
> > > + *  # encode a 1-based index (1..254) into the build_ids table and
> > > + *  # the lower 56 bits for the DSO file offset, or 0x00 for an
> > > + *  # unresolved user virtual address.
> >
> > Hi Ian,
> >
> > On PERF_SAMPLE_BUILD_ID_OFFSET, the layout comment doesn't say what is
> > written in the non-resolved cases. For PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET
> > it is clear: kernel entries are raw 64-bit values, unresolved user entries
> > have 0x00 in the top byte, and resolved user entries carry the table index
> > and the 56-bit file offset.
> >
> > For the PERF_SAMPLE_BUILD_ID_OFFSET form, could the comment state:
> >
> >  - What is written for a kernel IP? (e.g. bid.size == 0 and offset == raw IP?)
> >  - What is written for an unresolved user IP? If bid.size == 0, does
> >    “offset” hold the raw virtual address?
> 
> Yes, in both non-user (e.g. kernel/hypervisor) and unresolved user IP
> cases, bid is zeroed (bid.size == 0) and offset holds the raw
> instruction pointer / virtual address. When attr.defer_callchain
> defers a user IP, the union carries zero == 0 (so bid.size == 0),
> context == PERF_CONTEXT_USER_DEFERRED, the stitching cookie, and the
> raw user IP.

Theoretically kernel IPs can have a build-ID as in /sys/kernel/notes.
But I don't know if we have a way to lookup module address ranges and
build-IDs easily.  Once that's available, it'd cover kernel IPs.

Thanks,
Namhyung

