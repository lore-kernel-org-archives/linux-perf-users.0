Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9B32E36E1;
	Sat, 26 Jul 2025 23:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753574221; cv=none; b=ISBiqlSUvhCK4l6l7PFKjHDxOZ9iSeKbqMmoEXh7w2SQTC0B9XXZNZB9tqGH583PYcrROGAlernHClLkoqScecylJlrkwOF9FpWpeBniIIUI8klwzcLgJ09Tj8mCCCVEKVO9NaigO2I40ZYOhbooPFKdQ9DX3eg2PGHhHehtbfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753574221; c=relaxed/simple;
	bh=Sdfs3QkkKuQkwFg/ty22zrUbe9MrbPxVkKhvowscPYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoB4T3MkeBz1HIEWXvVGBgotYzTYsXYb1yyuwR0V0LTPq3AFkQTSZiqJ5CanQVSPyvkMRkwZaEKBXGQoGAZqK7V3v6qBZIDqzgUXoGSHKRGmKs/MHBGGKCoW7/Pptj+2xv3I2nMPWMwsSxanUOmL4IFhsYiM1kCktMnyuUs+L7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChW4BqMR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChW4BqMR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF263C4CEED;
	Sat, 26 Jul 2025 23:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753574221;
	bh=Sdfs3QkkKuQkwFg/ty22zrUbe9MrbPxVkKhvowscPYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ChW4BqMRcIYTheIsIdGmXlhog+Aq19Q78gKEovp6VgCuewHIqQNR/SxLbNM5AAi1T
	 ZqXVp9l/RIuLeSX7qUNg6zPVVxVPP8fUp8h7UUMvEujhB7c1ttdeDyzMM1gNzKUtzy
	 MuEwFz0jrsKlfesKSetCFSsYodPMRkQp8cv8FlCa9Hyg0s077vznwlVcEYcM7rMr/V
	 pfwKw/H27hLne0rpNH4PoFlyLagHBoSzUPFLEw4DRV4nlpug1QRwl6gAn7AVXp70hK
	 4A/83gqx11xFebuB3sW0vX+ti05+MSpBgjB6Xk0wC00Ax0hepnSDVBJuoD/MvV920D
	 QEx+ZvdsaIL9w==
Date: Sat, 26 Jul 2025 16:56:59 -0700
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
Subject: Re: [PATCH v1 1/6] perf dwarf-aux: Use signed comparison in
 match_var_offset
Message-ID: <aIVrSy8Z8s2JqqVO@google.com>
References: <20250725202809.1230085-1-zecheng@google.com>
 <20250725202809.1230085-2-zecheng@google.com>
 <CAP-5=fV3KaHMR1eFtUh0kY6CmVkZjw8vJ0UNcY3phH=2jsiwyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV3KaHMR1eFtUh0kY6CmVkZjw8vJ0UNcY3phH=2jsiwyg@mail.gmail.com>

On Fri, Jul 25, 2025 at 05:58:05PM -0700, Ian Rogers wrote:
> On Fri, Jul 25, 2025 at 1:28 PM Zecheng Li <zecheng@google.com> wrote:
> >
> > match_var_offset compares address offsets to determine if an access
> > falls within a variable's bounds. The offsets involved for those
> > relative to base registers from DW_OP_breg can be negative.
> >
> > The current implementation uses unsigned types (u64) for these offsets,
> > which rejects almost all negative values.
> >
> > This commit changes the local variables within match_var_offset to
> > signed types (s64) before performing comparisons. This ensures correct
> > behavior when addr_offset_ or addr_type_ are negative.
> >
> > Signed-off-by: Zecheng Li <zecheng@google.com>
> > ---
> >  tools/perf/util/dwarf-aux.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> > index 559c953ca172..bf906dff9ef0 100644
> > --- a/tools/perf/util/dwarf-aux.c
> > +++ b/tools/perf/util/dwarf-aux.c
> > @@ -1388,10 +1388,12 @@ struct find_var_data {
> >  #define DWARF_OP_DIRECT_REGS  32
> >
> >  static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
> > -                            u64 addr_offset, u64 addr_type, bool is_pointer)
> > +                            u64 addr_offset_, u64 addr_type_, bool is_pointer)
> >  {
> >         Dwarf_Die type_die;
> >         Dwarf_Word size;
> > +       s64 addr_offset = (s64)addr_offset_;
> > +       s64 addr_type = (s64)addr_type_;
> 
> Would it be better to make the function take signed types? I'm
> thinking if a 32-bit int is passed, with the signature as-is it is
> unclear if sign-extension will happen.

Hmm.. right.  The addr_offset often from 'int' type so negative value
can have the sign-extension problem.

Zecheng, can you please update the function signature to s64 and check
if the final offset is negative or bigger than the size?

Thanks,
Namhyung

> >
> >         if (addr_offset == addr_type) {
> >                 /* Update offset relative to the start of the variable */
> > @@ -1414,7 +1416,7 @@ static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
> >         if (dwarf_aggregate_size(&type_die, &size) < 0)
> >                 return false;
> >
> > -       if (addr_offset >= addr_type + size)
> > +       if (addr_offset_ - addr_type_ >= size)
> >                 return false;
> >
> >         /* Update offset relative to the start of the variable */
> > --
> > 2.50.1.470.g6ba607880d-goog
> >
