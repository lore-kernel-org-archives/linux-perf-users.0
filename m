Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCEF2BFC85;
	Mon, 20 Oct 2025 04:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760934583; cv=none; b=MAriK/iTfvvM6sUbQVz98l7KjY8MEIFKavV6XceHdX17b7m7ydCzW8KeB/8ZitwKTVMTD3iE2IxkBICFcS51dKsZ/sV1KgtvnPORcj3YTvY1zWdK5AF/VY2Ow2B+dbR2/nqeO+F0lXAcRQwl0QzuwM5kcCLpHjTNsft0RU9b6VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760934583; c=relaxed/simple;
	bh=G8wPvJIawe3c7/4nWsLf0Ggnz1ZZW6fQPBZyxA+8XOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeiPmj+G8sOnWgQOngHeOt8Zab5xVFB74nx/PonS9Rw4F3oeYP2RNX7/C3ELjnVileVav5bOu2tj/KNmSGmFiAVmad27rf0NYzXWdhHElTad/1YtKsKBJEisWQPvlCNjUxbi6EeQv6dtTgHXhSYZ+PvdcGJOSEVJ57Ju1++qRoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzeAIT2C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzeAIT2C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37453C4CEF9;
	Mon, 20 Oct 2025 04:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760934583;
	bh=G8wPvJIawe3c7/4nWsLf0Ggnz1ZZW6fQPBZyxA+8XOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MzeAIT2Csw4SggUC9nBSLWYA98odWXVEVZ3oYU/3FuAiRiSZtXfUHdNIl7HrqOPt6
	 R8zOjbD07fpSLWl40znNIzZ6195LipribDAuqkYGRuWPxLYTMBmUqI73fvlN9EpNoQ
	 sFrzn5GJ1R0j5Y1ZL9/nTOy0xNN4Fe7Il1M5MdYyVDya7FLeZGL6KzyXlcULwD13Yb
	 LlyzxXzbe6q7RwxrtihMzYkaZfezVPmdafd/CZVh9dT1Cd8F6VLgF+8Ii+mNOytS3d
	 k6Ebc1QPVJzStdGsFfZmBe9aV6oN0W/HoZn0Zb2n/i+65Gi1qzR+taupDiY0mViV8K
	 0VsKBQooDyrkg==
Date: Mon, 20 Oct 2025 13:29:37 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Zecheng Li <zecheng@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/9] perf annotate: Skip annotating data types to lea
 instructions
Message-ID: <aPW6sUywwZzDeOkW@google.com>
References: <20251013181607.2745653-1-zecheng@google.com>
 <20251013181607.2745653-2-zecheng@google.com>
 <aO6ZIQ2WwTPGWATX@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aO6ZIQ2WwTPGWATX@x1>

On Tue, Oct 14, 2025 at 03:40:33PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Oct 13, 2025 at 06:15:58PM +0000, Zecheng Li wrote:
> > Introduce a helper function is_address_gen_insn() to check
> > arch-dependent address generation instructions like lea in x86. Remove
> > type annotation on these instructions since they are not accessing
> > memory. It should be counted as `no_mem_ops`.
> > 
> > Signed-off-by: Zecheng Li <zecheng@google.com>
> > ---
> >  tools/perf/util/annotate.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index a2e34f149a07..fb60467fa877 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -2698,6 +2698,20 @@ static bool is_stack_canary(struct arch *arch, struct annotated_op_loc *loc)
> >  	return false;
> >  }
> >  
> > +/**
> > + * Returns true if the instruction has a memory operand without
> > + * performing a load/store
> > + */
> > +static bool is_address_gen_insn(struct arch *arch, struct disasm_line *dl)
> > +{
> > +	if (arch__is(arch, "x86")) {
> > +		if (!strncmp(dl->ins.name, "lea", 3))
> > +			return true;
> > +	}
> 
> Can't we turn this into:
> 
> tatic bool disasm_line__is_address_gen_insn(const struct disasm_line *dl)
> {
> 		return dl->ins.address_gen;
> }

Probably better to add ins->ops->addr_gen() instead of adding a new
field to the struct ins.  Then it could be:

static bool ins__is_addr_gen(const struct ins *ins)
{
	return ins->ops == &addr_gen_ops;
}

But this requires more changes and it can be done later.

Thanks,
Namhyung

> 
> I.e. at some initial step when setting dl->ins, cache this series of
> string operations and then use it s result?
> 
> - Arnaldo
> 
> > +
> >  static struct disasm_line *
> >  annotation__prev_asm_line(struct annotation *notes, struct disasm_line *curr)
> >  {
> > @@ -2806,6 +2820,12 @@ __hist_entry__get_data_type(struct hist_entry *he, struct arch *arch,
> >  		return &stackop_type;
> >  	}
> >  
> > +	if (is_address_gen_insn(arch, dl)) {
> > +		istat->bad++;
> > +		ann_data_stat.no_mem_ops++;
> > +		return NO_TYPE;
> > +	}
> > +
> >  	for_each_insn_op_loc(&loc, i, op_loc) {
> >  		struct data_loc_info dloc = {
> >  			.arch = arch,
> > -- 
> > 2.51.0.788.g6d19910ace-goog
