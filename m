Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C1522C322;
	Mon, 10 Mar 2025 15:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741620096; cv=none; b=swmiMcTfapx094PP4HNW/RmwlTfdiKgaxXMrUrhr3JvytofRK9Oudw4rxm/Aykn/4geSoeGUsZT8by5KTN43/XLN+b39AxFBj+uD9eJ+W58HxWOpga6CA7eJIin96Nn47cSkgkOSQFjndtru5KcorzjEK/P/wEMo9UggetWYfhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741620096; c=relaxed/simple;
	bh=hXQNgckFdKYueMq99vRKaTD58E0w+Kq8iFgHPpemBCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmLFjw9bXd2h0lyUgcUkUE9IcZkc2QV/LaP0gpkkfVRL0rlJeICxa4hrloRsUNGscyBa9fHNkrxcT9eLGjwfQZYhkks6rzre6xHu/3JI6RuOd/OsP2fpp0rDOXGeRiR8Wv3QCtXZ8QiDhhBzBfJz0pCXsNHLRiNAzSStYV4QErc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNReww5F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNReww5F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7B2C4CEE5;
	Mon, 10 Mar 2025 15:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741620096;
	bh=hXQNgckFdKYueMq99vRKaTD58E0w+Kq8iFgHPpemBCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hNReww5FtAFFdhfD6In7xw3zsTu1HsBArEBSTNJ9D6/7Ma7Ko7E3eoO3Bvaxi2Mjj
	 QLb+ynyWl51Is7nlDrCEOY14QdL94m/IkLi6vH1DeZVUPPkQfNmB/KSLq5cFy3dFDP
	 H28Z9iF7Ubu7GCGwW1QJ9FrBHG3jCkoW6HTmgbqg5McAR5paFN+4xvgVzUHxu/4L32
	 UxAlKpnlBIu4RdA+ANGWQkjTl82PCViKN3gdMMepSda58qUcfUccnkNr3vr62KUXlw
	 nBNVLIOEWiHRnCKa5aATe2ndOkDHHRcTS8HMHFAu6mssZbgyaQpOfbrTgJdVfg+hAj
	 7La33v2FGW1nQ==
Date: Mon, 10 Mar 2025 12:21:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
	Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 0/3] Support .gnu_debugdata for symbols in perf
Message-ID: <Z88DfA2ROWNGfpD_@x1>
References: <20250220185512.3357820-1-stephen.s.brennan@oracle.com>
 <Z7-QZKNT4Cc8lspM@google.com>
 <Z8tSyzcHF2V7Lofx@x1>
 <Z8tUmcIH1qTF6YTn@x1>
 <Z8tbEgh7rZscggv6@x1>
 <87a59wwjxe.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a59wwjxe.fsf@oracle.com>

On Fri, Mar 07, 2025 at 02:33:01PM -0800, Stephen Brennan wrote:
> Arnaldo Carvalho de Melo <acme@kernel.org> writes:
> > On Fri, Mar 07, 2025 at 05:18:36PM -0300, Arnaldo Carvalho de Melo wrote:
> [...]
> > It has a way to use that section tho:

> > ⬢ [acme@toolbox perf-tools-next]$ man eu-readelf | grep -A2 -- --elf-section
> >                [--elf-section [section] ]
> >                [-w|
> >                 --debug-dump[=line,=decodedline,=info,=info+,=abbrev,=pubnames,=aranges,=macro,=frames,=str,=loc,=ranges,=gdb_index,=addr]]
> > --
> >        --elf-section [section]
> >            Use the named SECTION (default .gnu_debugdata) as (compressed) ELF input data

> > ⬢ [acme@toolbox perf-tools-next]$

> > ⬢ [acme@toolbox perf-tools-next]$ eu-readelf --elf-section -s /bin/find | grep -w FUNC | grep -vw UNDEF | wc -l
> > 339
> > ⬢ [acme@toolbox perf-tools-next]$ eu-readelf --elf-section -s /bin/find | grep -w FUNC | grep -vw UNDEF | head
> >     1: 00000000000056d0     35 FUNC    LOCAL  DEFAULT       17 entry_hashfunc
> >     2: 0000000000005700     34 FUNC    LOCAL  DEFAULT       17 entry_comparator
> >     3: 0000000000005920    121 FUNC    LOCAL  DEFAULT       17 subtree_has_side_effects
> >     4: 00000000000059a0    992 FUNC    LOCAL  DEFAULT       17 worst_cost.part.0
> >     5: 0000000000005d80    449 FUNC    LOCAL  DEFAULT       17 traverse_tree
> >     6: 0000000000005f50     73 FUNC    LOCAL  DEFAULT       17 undangle_file_pointers
> >     7: 0000000000005fa0     72 FUNC    LOCAL  DEFAULT       17 looks_like_expression
> >     8: 0000000000006030    303 FUNC    LOCAL  DEFAULT       17 get_fts_info_name
> >     9: 0000000000006190     35 FUNC    LOCAL  DEFAULT       17 inside_dir.part.0
> >    10: 0000000000006330    451 FUNC    LOCAL  DEFAULT       17 pred_sanity_check
> > ⬢ [acme@toolbox perf-tools-next]$
 
> Wow, thank you for teaching me that!
> I had been using:
 
>   gdb /usr/bin/bash --batch -ex 'maint print msymbols'
 
> Because I knew GDB had support for .gnu_debugdata. But the --elf-section
> argument to eu-readelf is much more useful.

That was a nice assumption and it did the work for you :-)

I thought that the elfutils guys would add something to eu-readelf for
them to dump the compressed data in human readable for, looked at the
man page and voila! 

<SNIP>
 
> > # Overhead  Command  Shared Object                    Symbol
> > # ........  .......  ...............................  .......................................................
> > #
> >      8.72%  find     /usr/bin/find                    0xb498
> >      7.90%  find     /usr/lib64/libc.so.6             0xe51e0            B [.] __GI___readdir64
> >      7.44%  find     /usr/lib64/libc.so.6             0xa77cd            B [.] _int_malloc
> > ⬢ [acme@toolbox perf-tools-next]$

> > The only strange thing was not having it resolved in the -v case, which
> > I think its because you added a new type of DSO but didn't update the
> > code that does the 'perf report -v' verbose case?

> > I ran out of time, have to go AFK now, can you please take a look,
> > Stephen?
 
> Thanks for the catch. I double checked all the places where
> DSO_BINARY_TYPE constants are enumerated, and it turns out I missed
> adding an entry to
 
> char dso__symtab_origin(const struct dso *dso) ...
> 
> I assume that the array defaulted to '\0' which terminated the string
> too early for this line. Oops!
> 
> Most of the letters I would associate with ".gnu_debugdata" are
> taken (namely, g/G for GNU, m/M for MiniDebugInfo, d/D for
> debugdata...). So 'n', for the second letter of GNU, is my selection
> unless you feel differently. With that change, the table is fixed for
> "perf report -v". Here it is running against my test data focusing on a
> symbol only found in .gnu_debugdata of bash:
> 
> $ ./perf report -v --stdio -i ~/repos/UEK6/perf.data 2>&1 | egrep yy_readline_get\|gnu_debugdata
> read_gnu_debugdata: using .gnu_debugdata of /usr/bin/bash
> unwind: yy_readline_get:ip = 0x55fdc4509dbe (0x33dbe)
> unwind: yy_readline_get:ip = 0x55fdc4509dbe (0x33dbe)
> unwind: yy_readline_get:ip = 0x55fdc4509dbe (0x33dbe)
> unwind: yy_readline_get:ip = 0x55fdc4509dbe (0x33dbe)
> unwind: yy_readline_get:ip = 0x55fdc4509dbe (0x33dbe)
> unwind: yy_readline_get:ip = 0x55fdc4509dbe (0x33dbe)
> read_gnu_debugdata: using .gnu_debugdata of /usr/bin/sed
> read_gnu_debugdata: using .gnu_debugdata of /usr/bin/date
> read_gnu_debugdata: using .gnu_debugdata of /usr/bin/sqlite3
> read_gnu_debugdata: using .gnu_debugdata of /usr/bin/sleep
>      0.20%     0.00%  bash     /usr/bin/bash                    0x55fdc4509dbe     n [.] yy_readline_get
> 
> I'll update the patch accordingly.

I just tested it, works as expected:

⬢ [acme@toolbox perf-tools-next]$ perf report -v --stdio |& head -20
build id event received for [vdso]: a2184b81fbbc08eff401d16259eca8ad5f9d8988 [20]
build id event received for /usr/bin/find: 3faf3f04d1b31abc9e5ce8428110e424fd980a37 [20]
build id event received for /usr/lib64/ld-linux-x86-64.so.2: 765f7ab0f3569ffe98de85864a0cedda9b686994 [20]
build id event received for /usr/lib64/libc.so.6: c8c3fa52aaee3f5d73b6fd862e39e9d4c010b6ba [20]
build id event received for [kernel.kallsyms]: c3fbb7df4dfb94762b1648bc65e4363e50f45585 [20]
read_gnu_debugdata: using .gnu_debugdata of /usr/bin/find
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 163  of event 'cpu_core/cycles/Pu'
# Event count (approx.): 68126524
#
# Overhead  Command  Shared Object                    Symbol                                                 
# ........  .......  ...............................  .......................................................
#
     8.72%  find     /usr/bin/find                    0xb498             n [.] consider_visiting
     7.90%  find     /usr/lib64/libc.so.6             0xe51e0            B [.] __GI___readdir64
     7.44%  find     /usr/lib64/libc.so.6             0xa77cd            B [.] _int_malloc
⬢ [acme@toolbox perf-tools-next]$

I'll reply to the v3 thread with my Tested-by.

Thanks!

- Arnaldo
