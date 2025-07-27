Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FB1EEC0;
	Sun, 27 Jul 2025 00:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753575725; cv=none; b=PCGTvpUmRAfNxqVOj7cZa0Fp8pe7w4ENlZpmjpbhXjEAlMPlnG6bAgpRu/l4VIhBkiHt00fraE2ncWCjNvebXbD5GEQwYs21RUuIEiMMNvzkqkDMuilumYDfEKu2uhGFE9i4C1PG8EHubpRpu+Dh29o0SvvURdiN3EL6OxYi/ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753575725; c=relaxed/simple;
	bh=CqVBh1eNFuoWr+oqXQIbgrkODx9toeLDcERUESkHxO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mToB90opczx/9WraB/Vrs90ynTUbLmTG/z4+Fl1BAjQLL36kI3ThLLdJvCDJnKgEm7L9CNa6ccn5AIv9nfK9orqlKF3P8uadkSIwdLrKARIbcfc9UnmRheCDHbwnn9+xmbNyfLTzG9rRwV7yxyvMYKOE7mUFJC7lHZsC23l+cLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFry0C9Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFry0C9Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FA9C4CEED;
	Sun, 27 Jul 2025 00:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753575725;
	bh=CqVBh1eNFuoWr+oqXQIbgrkODx9toeLDcERUESkHxO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LFry0C9Q+N8JG31PmnrqmSR/VSs+sP+ej++zEUmdIzg2Tcks+h8jZ+raCVj2dM1dH
	 ZtN9oAAc/zb9njK+tBEqcAyx23NhgJWeaJ+m8zRuMTs5nQ1sQ55c2Y+9DG5QrrJja6
	 WZKajEsGKBVISumgcp8AIoOEXjm/McHm3iCC6ba/APUuzvBBek1L/sSSL/Z9+gfgBG
	 gxiURFn/Luxc3fuiYFL2k0dTQQpL//2Mypvn578tT3EXRU5/M9Xsj1HTRqUtstRNjw
	 ok+8MbeNCYsLnD4ZrP+g74OcmjE7eUJM04f5FH1y+oGzTkMmTTBqXEq/Df3jcxMb3b
	 Niuaf9CsOKwCg==
Date: Sat, 26 Jul 2025 17:22:03 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Zecheng Li <zecheng@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, Zecheng Li <zli94@ncsu.edu>,
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/6] perf dwarf-aux: Better type matching for stack
 variables
Message-ID: <aIVxK-xXxmHXzLTV@google.com>
References: <20250725202809.1230085-1-zecheng@google.com>
 <20250725202809.1230085-4-zecheng@google.com>
 <CAP-5=fWbKj6fjxTccpszgMoVCc17e+2ZmixU5B3W0WU5wo_zDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWbKj6fjxTccpszgMoVCc17e+2ZmixU5B3W0WU5wo_zDg@mail.gmail.com>

On Fri, Jul 25, 2025 at 06:17:33PM -0700, Ian Rogers wrote:
> On Fri, Jul 25, 2025 at 1:28 PM Zecheng Li <zecheng@google.com> wrote:
> >
> > Utilizes the previous is_breg_access_indirect function to determine if
> > the stack location stores the variable itself or the struct it points
> > to.
> >
> > If the DWARF expression shows DW_OP_stack_value without DW_OP_deref, it
> > indicates the variable value is the reg + offset itself, and the stack
> > location it points to is the dereferenced type.
> >
> > Signed-off-by: Zecheng Li <zecheng@google.com>
> > ---
> >  tools/perf/util/dwarf-aux.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> > index 814c96ea509f..4039dbd2b8c0 100644
> > --- a/tools/perf/util/dwarf-aux.c
> > +++ b/tools/perf/util/dwarf-aux.c
> > @@ -1635,6 +1635,14 @@ static int __die_collect_vars_cb(Dwarf_Die *die_mem, void *arg)
> >         if (die_get_real_type(die_mem, &type_die) == NULL)
> >                 return DIE_FIND_CB_SIBLING;
> >
> > +       if ((ops->atom == DW_OP_fbreg || ops->atom == DW_OP_breg7) &&
> 
> A comment saying the significance of DW_OP_fbreg and DW_OP_breg7 would
> be useful, for example, why not DW_OP_breg6? Isn't breg7 going to be
> x86 specific?

Good point!  Right, it's x86 specific and we cannot hard-code.  It needs
a way to indicate this register is a stack pointer on the target arch.
Please see the instruction tracking code which checks state->stack_reg.
 
On x86_64, DWARF reg 7 is RSP.  If RBP is used as a frame pointer, it's
probably using DW_OP_fbreg expression.

> 
> > +           dwarf_tag(&type_die) == DW_TAG_pointer_type &&
> > +           is_breg_access_indirect(ops, nops)) {

Maybe it needs to check the register inside is_breg_access_indirect().

Thanks,
Namhyung


> > +               /* Get the target type of the pointer */
> > +               if (die_get_real_type(&type_die, &type_die) == NULL)
> > +                       return DIE_FIND_CB_SIBLING;
> > +       }
> > +
> >         vt = malloc(sizeof(*vt));
> >         if (vt == NULL)
> >                 return DIE_FIND_CB_END;
> > --
> > 2.50.1.470.g6ba607880d-goog
> >
