Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9892275AE3;
	Fri,  5 Sep 2025 19:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757101927; cv=none; b=GJpdFlKDH2IkxRML0EsrEvqlQPx4QXgdf/PMY6qjORihcoHgCmhakbQ6J2SSLNkqNUGGdeRVbMZo71e709VqOjoHQ+SEobfYEAXaP1noMKBmacRzwAL1mHaMEP+BYwufNUqD+dTWPbG3VCeugRaOj+RAjH/usXRzA4vh0amqZwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757101927; c=relaxed/simple;
	bh=EcEhZQkcRDrFURtJpI4hMt6Rl+zj9Pnnl0nP7zN8uKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPaTjE6+kZVMt/OfkkslW6qAH//fNR4FlhDa9Fco1AP3nD06cFHxtLEEDZezbDMRoojVylP7u/YUcg+YP/to5yofmQyVdMEIiktpjrrHg5uwGhjhv11uwXpz5eh9iN9wNFDfioHouv0WL8fbHk/cvC9/eNT5Ex7KV8AWeYkQLVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xvwp4pn5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xvwp4pn5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57DEC4CEF1;
	Fri,  5 Sep 2025 19:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757101927;
	bh=EcEhZQkcRDrFURtJpI4hMt6Rl+zj9Pnnl0nP7zN8uKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xvwp4pn5VqxumoX8m7AtKvpO3NJty2v5GiPpQzI/Y8oB3SZiUi+SpMlTMKLX7M0d5
	 +fM1qgMDz1vadPq15toieUqpKq836VRgl8DaXu2+aq+0oHs3PpoUJiTgjveDl38EDQ
	 ZJVYw0bpoVFvNa5EKV+EgRqVt3uY1/M6K0Yp92p3FjjpfJdgAPIN9ZuotplH7sqn2i
	 yAU8DaOd7LVo4JTc62TqjpRYwq3eQSNrDzHyOS5tNI+3pb5q4YOq4ueQOLTrm2KI7X
	 f6maP+qbqBTJCICYHoognGVUEYoiL07Fx8jfMj9zkCXsNr95F0l/zyN0JPoaCIUURm
	 fxj1KA8ZXUsaw==
Date: Fri, 5 Sep 2025 12:52:05 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Zecheng Li <zecheng@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/10] perf annotate: Track arithmetic instructions on
 pointers
Message-ID: <aLs_ZeRBzNvgfbqK@google.com>
References: <20250825195737.225824-1-zecheng@google.com>
 <aLKknf6qFxVgN3gJ@google.com>
 <CAJUgMyKBFkF9rKFnzP6S_c9ma3P7a-NsCubV1DiTwoGUbByk+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJUgMyKBFkF9rKFnzP6S_c9ma3P7a-NsCubV1DiTwoGUbByk+w@mail.gmail.com>

Hi Zecheng,

On Wed, Sep 03, 2025 at 04:26:50PM -0400, Zecheng Li wrote:
> > I was thinking we can use TSR_KIND_POINTER here.  Probably we need to
> > distinguish it from the existing percpu base use case. Maybe you want
> > to rename it.  Then you don't need to find a pointer type in the DWARF.
> 
> Hi Namhyung, thanks for the review.
> 
> Yes. I think that's a better way to represent a pointer to a type.
> With that tag we can also support registers representing addresses
> (is_reg_var_addr == true). And when moving an address register to a
> memory location we probably can simply add the * to denote a pointer
> without finding the exact pointer type.
> 
> >
> > > +                     tsr->offset = 0;
> >
> > I think it can refer to a member in a struct.  How about this?
> >
> >                         tsr->offset = state->offset - offset;
> 
> True, it may load an address of a struct member. Do you mean
> stack->offset - offset?

Yep.

> 
> > > @@ -388,6 +493,7 @@ static void update_insn_state_x86(struct type_state *state,
> > >               tsr->type = state->regs[src->reg1].type;
> > >               tsr->kind = state->regs[src->reg1].kind;
> > >               tsr->imm_value = state->regs[src->reg1].imm_value;
> > > +             tsr->offset = 0;
> > >               tsr->ok = true;
> 
> I also find for mov register to register this should be
> 
> tsr->offset = state->regs[src->reg1].offset;
> 
> Let me update the patch.

Great, thanks!
Namhyung

