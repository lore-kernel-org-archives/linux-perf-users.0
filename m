Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367D1168BD;
	Fri,  6 Feb 2026 21:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770412697; cv=none; b=FTAFTgjCJuCyaLgHiktkO+itnsYPvXNbA4JwY/zfrJyYxgTAd6ekFkRFvLtGD7lsb21A7RU6ei6RyiA6jwE/15CSUqnCsHYQqJQ5w9NWEz5F1fT9fa7see2y04Xe0mnlxiUJnemZF6tSIo9+qIWGzMzs34uuZjQfitf4DvM32zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770412697; c=relaxed/simple;
	bh=O6L+Z95jmLQPmNyGRirEVxgA68yg7weeDu1WVxOJ73g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYixTzwGr0Qm7vl13XMhgC0m6BgZfkAuJPzxS8Guhr1j5chfOSPwAH9mcgVXqyCK/JUGUIfgioi1+UxftCv1R7/rU4ttCOKNFu4fP1aIbjdGB/BLIvEQdUofxG3/wkyH/6RScoDKQFtVdbCL7MqFT223n+comRfTjrQj/g4qeBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlUFu3xZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlUFu3xZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B23C116C6;
	Fri,  6 Feb 2026 21:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770412696;
	bh=O6L+Z95jmLQPmNyGRirEVxgA68yg7weeDu1WVxOJ73g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VlUFu3xZsml+uLS6L2hkb5jDF8MU4TsVx/ag14iti0gPxTLie6tJOiJV/ZKgAq22/
	 JHM0qK7HmFkWwY+/O0tIK3DNnLfGVPb85zNYB4b8w0Z5S72e6cq5ASC8ZTXvY5tWys
	 FAfVra9cOs5Z779swvZ72e6rLsIcNRjrVBpIphfzLcP/6S5h8KC5tk0vHmAzTzyl9v
	 zt5ez72pmm1DV0CSy4jA5nyiu2S1loPpJkjqCTcapPWOUcbr2q6hNr+238X+p9860E
	 Y17zghMjMuWMWG6mCCpVntvybbKzJ6ZgQ/x+lL2BXuA97B6VZI/F0+I8M+uxBasVvK
	 J1m71Hb/2me4w==
Date: Fri, 6 Feb 2026 18:18:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Zecheng Li <zli94@ncsu.edu>,
	Dmitry Dolgov <9erthalion6@gmail.com>
Subject: Re: [PATCH] perf annotate: Fix register usage in data type profiling
Message-ID: <aYZalTZ1AWpCp_ae@x1>
References: <20260206012743.2617945-1-namhyung@kernel.org>
 <CAP-5=fXn2jaPPBHfFLvZy-O2OXZbjOFHatDGdVm4b5q3C8jmnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXn2jaPPBHfFLvZy-O2OXZbjOFHatDGdVm4b5q3C8jmnA@mail.gmail.com>

On Thu, Feb 05, 2026 at 09:00:43PM -0800, Ian Rogers wrote:
> On Thu, Feb 5, 2026 at 5:27 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On data type profiling, it tried to match register name with a partial
> > string.  For example, it allowed to match with "%rbp)" or "%rdi,8)".
> > But with recent change in the area, it doesn't match anymore and break
> > the data type profiling.
> 
> Hmm.. the blamed patch was a strcmp before and after, so maybe
> something nearby changed causing this:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/?h=perf-tools-next&id=c31040085914f1188720073baa43d1483693c0a3
> ```
> - for (i = 0; i < ARRAY_SIZE(x86_regidx_table); i++)
> - if (!strcmp(x86_regidx_table[i].name, name + 1))
> - return x86_regidx_table[i].idx;
> + name++;
> + for (size_t i = 0; i < num_entries; i++) {
> + if (!strcmp(entries[i].name, name))
> + return entries[i].dwarf_regnum;
> ```
> 
> > Let's pass the correct register name by removing the unwanted part.  Add
> > arch__dwarf_regnum() to handle it in a single place.
> >
> > Reported-by: Dmitry Dolgov <9erthalion6@gmail.com>
> > Closes: 7d3n23li6drroxrdlpxn7ixehdeszkjdftah3zyngjl2qs22ef@yelcjv53v42o
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/annotate.c | 61 +++++++++++++++++++-------------------
> >  1 file changed, 30 insertions(+), 31 deletions(-)
> >
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index 880b1bd300c21e67..2e3522905046c1ec 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -2447,6 +2447,29 @@ int annotate_check_args(void)
> >         return 0;
> >  }
> >
> > +static int arch__dwarf_regnum(const struct arch *arch, const char *str)
> > +{
> > +       const char *p;
> > +       char *regname, *q;
> > +       int reg;
> > +
> > +       p = strchr(str, arch->objdump.register_char);
> > +       if (p == NULL)
> > +               return -1;
> > +
> > +       regname = strdup(p);
> 
> nit: Given register names are known to be so short it feels a shame to
> do a full strdup for this.
> 
> > +       if (regname == NULL)
> > +               return -1;
> > +
> > +       q = strpbrk(regname, ",) ");
> > +       if (q)
> > +               *q = '\0';
> > +
> > +       reg = get_dwarf_regnum(regname, arch->id.e_machine, arch->id.e_flags);
> 
> nit: Perhaps pass a regname_len to avoid the strdup.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, these extra nits can be done later,

- Arnaldo
 
> It'd be nice to have a test on this to avoid a regression. Dmitrii's patch:
> https://lore.kernel.org/linux-perf-users/20260127083030.5909-1-9erthalion6@gmail.com/
> does that for a Rust struct Buf, but it'd be nice to do something similar for C.
> 
> Thanks,
> Ian
> 
> > +       free(regname);
> > +       return reg;
> > +}
> > +
> >  /*
> >   * Get register number and access offset from the given instruction.
> >   * It assumes AT&T x86 asm format like OFFSET(REG).  Maybe it needs
> > @@ -2457,7 +2480,6 @@ static int extract_reg_offset(const struct arch *arch, const char *str,
> >                               struct annotated_op_loc *op_loc)
> >  {
> >         char *p;
> > -       char *regname;
> >
> >         if (arch->objdump.register_char == 0)
> >                 return -1;
> > @@ -2482,31 +2504,14 @@ static int extract_reg_offset(const struct arch *arch, const char *str,
> >         }
> >
> >         op_loc->offset = strtol(str, &p, 0);
> > -
> > -       p = strchr(p, arch->objdump.register_char);
> > -       if (p == NULL)
> > +       op_loc->reg1 = arch__dwarf_regnum(arch, p);
> > +       if (op_loc->reg1 == -1)
> >                 return -1;
> >
> > -       regname = strdup(p);
> > -       if (regname == NULL)
> > -               return -1;
> > -
> > -       op_loc->reg1 = get_dwarf_regnum(regname, arch->id.e_machine, arch->id.e_flags);
> > -       free(regname);
> > -
> >         /* Get the second register */
> > -       if (op_loc->multi_regs) {
> > -               p = strchr(p + 1, arch->objdump.register_char);
> > -               if (p == NULL)
> > -                       return -1;
> > -
> > -               regname = strdup(p);
> > -               if (regname == NULL)
> > -                       return -1;
> > +       if (op_loc->multi_regs)
> > +               op_loc->reg2 = arch__dwarf_regnum(arch, p + 1);
> >
> > -               op_loc->reg2 = get_dwarf_regnum(regname, arch->id.e_machine, arch->id.e_flags);
> > -               free(regname);
> > -       }
> >         return 0;
> >  }
> >
> > @@ -2585,7 +2590,8 @@ int annotate_get_insn_location(const struct arch *arch, struct disasm_line *dl,
> >                         op_loc->multi_regs = multi_regs;
> >                         extract_reg_offset(arch, insn_str, op_loc);
> >                 } else {
> > -                       char *s, *p = NULL;
> > +                       const char *s = insn_str;
> > +                       char *p = NULL;
> >
> >                         if (arch__is_x86(arch)) {
> >                                 /* FIXME: Handle other segment registers */
> > @@ -2599,21 +2605,14 @@ int annotate_get_insn_location(const struct arch *arch, struct disasm_line *dl,
> >                                 }
> >                         }
> >
> > -                       s = strdup(insn_str);
> > -                       if (s == NULL)
> > -                               return -1;
> > -
> >                         if (*s == arch->objdump.register_char) {
> > -                               op_loc->reg1 = get_dwarf_regnum(s,
> > -                                                               arch->id.e_machine,
> > -                                                               arch->id.e_flags);
> > +                               op_loc->reg1 = arch__dwarf_regnum(arch, s);
> >                         }
> >                         else if (*s == arch->objdump.imm_char) {
> >                                 op_loc->offset = strtol(s + 1, &p, 0);
> >                                 if (p && p != s + 1)
> >                                         op_loc->imm = true;
> >                         }
> > -                       free(s);
> >                 }
> >         }
> >
> > --
> > 2.53.0.rc2.204.g2597b5adb4-goog
> >
