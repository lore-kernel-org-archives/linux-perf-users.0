Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A107647;
	Wed, 25 Sep 2024 05:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727243872; cv=none; b=oBOQc07ciKUqcDJP19KXuavfwO6Rlr0uABHGjpFESOYohT/P9RSHez/7/vyy8w3yit+r3mPKoNIf+Xs1kIBomsHbElNrdJ0dOs1SYtx1t2wuULcUW+KTsc9L76Xa+G2ZDHCA+gbI8kvPJMC23oH/bVPdtt2t98coj5M3MMA4/m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727243872; c=relaxed/simple;
	bh=H+FzXnlUU5NaoXsOJGrXNwpPtM4ZfYM6NG/djvg6Afc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7Pm4+JVT4e65hXNUNZ64AR6aTKpNTUF7J+JbJydwkvXfPpky1y9I4g8rlyjZ4cdtjOMYEKMMZy3dbzoAM/zf09tVnW9l7+5isbEQX2p19LLD0dH8txhZiD5XjgZRiSveyjIsvy/DoG6uarm9NguUi0B7IEEZzcRJEuEIqviucU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGF+CXrO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGF+CXrO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F119C4CEC3;
	Wed, 25 Sep 2024 05:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727243871;
	bh=H+FzXnlUU5NaoXsOJGrXNwpPtM4ZfYM6NG/djvg6Afc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KGF+CXrOjYLSbOAIn0XNg/Kosu4gtC7rxtvhsCEpZSNbHv8+HJADQMHV+L7DSBHR9
	 46TukdvDPo3XhWuGiA1TksAM/y9tVlciTVQZbzl7kyXVBP7RKI/ifIpvUtR8uYjco7
	 j1T99AVk8qlD8AYYIsb1znhVAJOK+OqEWNMgeZa3OkbW3fFQj3SaoEBw2mqcqAXB9a
	 z2jdZBjGkH2CQ6tQ7QaJ5kq7J0xKdNnPRHR0YSGEBimib0uUcKlNphfNgWLdImh53x
	 MXlysAtRhU22BrGcHWL/xwjHQ/kdF1spdfLvKhET5tZoFTHifPDNM8UCduISYrps1B
	 ut31UHcKyVfPA==
Date: Tue, 24 Sep 2024 22:57:48 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Hemant Kumar <hemant@linux.vnet.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yang Jihong <yangjihong@bytedance.com>, leo.yan@arm.com
Subject: Re: [PATCH v1 1/3] perf disasm: Fix capstone memory leak
Message-ID: <ZvOmXH7gKzGKSh7y@google.com>
References: <20240924003720.617258-1-irogers@google.com>
 <20240924003720.617258-2-irogers@google.com>
 <ZvMHHKKZwab2IhlL@google.com>
 <CAP-5=fUCbzz=bLY75DKfdPRNjW91yz6yAzywVe_QWDwK4d7R8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUCbzz=bLY75DKfdPRNjW91yz6yAzywVe_QWDwK4d7R8g@mail.gmail.com>

On Tue, Sep 24, 2024 at 12:51:20PM -0700, Ian Rogers wrote:
> On Tue, Sep 24, 2024 at 11:38 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Sep 23, 2024 at 05:37:18PM -0700, Ian Rogers wrote:
> > > The insn argument passed to cs_disasm needs freeing. To support
> > > accurately having count, add an additional free_count variable.
> > >
> > > Fixes: c5d60de1813a ("perf annotate: Add support to use libcapstone in powerpc")
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/disasm.c | 11 +++++++----
> > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> > > index f05ba7739c1e..2c8063660f2e 100644
> > > --- a/tools/perf/util/disasm.c
> > > +++ b/tools/perf/util/disasm.c
> > > @@ -1627,12 +1627,12 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
> > >       u64 start = map__rip_2objdump(map, sym->start);
> > >       u64 len;
> > >       u64 offset;
> > > -     int i, count;
> > > +     int i, count, free_count;
> > >       bool is_64bit = false;
> > >       bool needs_cs_close = false;
> > >       u8 *buf = NULL;
> > >       csh handle;
> > > -     cs_insn *insn;
> > > +     cs_insn *insn = NULL;
> > >       char disasm_buf[512];
> > >       struct disasm_line *dl;
> > >
> > > @@ -1664,7 +1664,7 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
> > >
> > >       needs_cs_close = true;
> > >
> > > -     count = cs_disasm(handle, buf, len, start, len, &insn);
> > > +     free_count = count = cs_disasm(handle, buf, len, start, len, &insn);
> > >       for (i = 0, offset = 0; i < count; i++) {
> > >               int printed;
> > >
> > > @@ -1702,8 +1702,11 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
> > >       }
> > >
> > >  out:
> > > -     if (needs_cs_close)
> > > +     if (needs_cs_close) {
> > >               cs_close(&handle);
> > > +             if (free_count > 0)
> > > +                     cs_free(insn, free_count);
> >
> > It seems cs_free() can handle NULL insn and 0 free_count (like regular free)
> > so we can call it unconditionally.
> 
> No, on error from cs_disasm free_count gets assigned -1 and my
> experience was things crashing.
 
Ok then, I thought it returns 0 on error.

Thanks,
Namhyung

> >
> > > +     }
> > >       free(buf);
> > >       return count < 0 ? count : 0;
> > >
> > > --
> > > 2.46.0.792.g87dc391469-goog
> > >
