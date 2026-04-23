Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FA2332615
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 20:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776976085; cv=none; b=pETd83pLvCiPH5iS5I+JCH3DynwgX+GrkuQSCVOvzkVAaWHNZ/bKNoVugBBfJPgn+Uls2M7msXj3lsR6+LaqW07ymUCq/zvalUB6Q6EZAguLSYFHWMMLARQt6r9TuV73sgIClTOTTXmu0lYm3YCeEV1FFtOlaHFMoPqldEOuMPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776976085; c=relaxed/simple;
	bh=JdbHCPbLCcqtJwf9uq7R6ssmHNuSFJBOhhTxI1pM2k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgggNN/nued+YrzcNfmnJT/PcAfL2wjIrl3R21QWMGFrhK862c7llub+6IXIy/NjY51MLm+1fT/aJBYzemSLfh/53zEDKcDTR8kolp4UT2+r7T+QGZn/ZYWPge4zr37eGXSQFQkfC/LoXrLlX8Gp1XEss/f+R+VJYvbgplS3j80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWYvuotl; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWYvuotl"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7bb0d18c7f9so27195477b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 13:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776976082; x=1777580882; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uBsrIHveQTj43u4uWhioOd/AqRJr49vkfqhXJkPx3yc=;
        b=WWYvuotl+bpx1T9tuCyBSRWW0/y/VuKAsXj/ULaUtFWaUIMx82UImf6OtZCTuF7qNp
         su7xHTjy75HD7cthh736ngsZPgKrj+opaiZRxG+wOBmzSH13UsEoBL1kXLCOc+6/FwSi
         Rmor9ZDltYQB3CBaetdFJUeLwg/LGzLVJKQJw6DD0+eDEOzoYQkR51Oa9/XhAV3v7gLo
         +zep32s4Qb2w6LS2Sdhag42Sgb5q3c9DZpPdQe24OlXv64RLG/Rf3bP7eJ8/v5otcvkc
         GkowQLysBmWltZG1RUnCMwauouYN0mOSa3BCj1cbX5jSWBC2Zs52wF/CpmRsrYA/4k6P
         zcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776976082; x=1777580882;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBsrIHveQTj43u4uWhioOd/AqRJr49vkfqhXJkPx3yc=;
        b=nXTrpwTeXG6bTut7yeOk+dA90P4jD4MM1BC6wpG+BSt726OryANihyTnE75WEhzIB1
         CFUZrkXDWwTJUp5MFflmm8/5ucte1tg3VB5yOID86vDXFX4JAIEHKH4fkTi/7SzgNcol
         11B27K+050iAbsN2ZlO9Cfj8ua3hmwad2QkCAGRYV66afxGUM5uAI0JuNuAoSTLq2z/7
         78JH6TrpEKBuWnTePoUUTwWCDhYYA9FzIolvl1sLJ9iuwbXK7SmfLt7NePTO+/qps84X
         KwHLLUiY1moPnTnlJCi9j5AWzR82NCbeKDH+wmDgEXNmY7AHnvpK2eWal9TOnKlLAYS1
         ZO5w==
X-Forwarded-Encrypted: i=1; AFNElJ9H3MX9sj+WNHmcOkon2PpTrCdN2EKWKLl7xDBJ5zp0mW7iehRC/OYriaTS36T0SWGCyNkrk8zHYwTES2xovEFG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5S7bRL6Vhcvd0OyEI0Wt97LGrRX4FqON0lpDnytUgUzCbOCox
	/cqnExnY2ytjo0MtyJb/TMKFzNxsnvjs2OrNblEXp/zYoWSccbA/81ZE
X-Gm-Gg: AeBDiestaP/kSygelhjnVum7Ia+B3hugtP1Zxl/mkR6EVHhBC7hTA3QoKGfIzVE7ji4
	dnypgj+YGhbb9svbMMJV5PrTG3MOASuV2tPZF5L40B4jF7ASxDPRHsfctnxMjh5tV7aCwD7BrLZ
	w0aM1zRCrnMZKa/Rw/mogWvKPl8Rg/N0tJ6GcOnyEgbbjnUu3w16cTGz2vQTIX1VeLOYr1XBskn
	eIv0y96hJOsOpjtzLA93XTyfhUOuPD1i37SxO9Y5B502smg9VFo27nmkyLWz5lLX3pTBaLy2zLC
	sVPoK3TYkVyupGXjq6ZSYUjL/YASjPlsK5jzoU3zfemCXMMV3H/Bvjs3l2u0LbcM6pOFZH+zC8p
	Qy3xJ4mBTHexrZ2RLjSEyquPz5wCxOGDBKs+MYRyyeS4jjoqkFCCmQd/s0zA9746YfG3DMHxFfb
	LFkmh9+k4Lu4PgNyeoC43tmbQVntxR
X-Received: by 2002:a05:690c:39c:b0:7b8:926e:3ef4 with SMTP id 00721157ae682-7b9eced90e4mr285105677b3.17.1776976082479;
        Thu, 23 Apr 2026 13:28:02 -0700 (PDT)
Received: from localhost ([172.216.252.33])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7baf1cda83bsm50472457b3.5.2026.04.23.13.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 13:28:01 -0700 (PDT)
Date: Thu, 23 Apr 2026 23:27:54 +0300
From: Dan Carpenter <error27@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Guo Ren <guoren@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] perf dwarf-regs: s390: Fix an off by one bug
Message-ID: <aeqAypUUfE8jB7Uo@stanley.mountain>
References: <aenFGy9WDllTEO0S@stanley.mountain>
 <CAP-5=fVL_qishriDrRvvXQQ5VSBZAxs3F-HQ69yEtEzdf+6MMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVL_qishriDrRvvXQQ5VSBZAxs3F-HQ69yEtEzdf+6MMg@mail.gmail.com>

On Thu, Apr 23, 2026 at 01:24:50PM -0700, Ian Rogers wrote:
> On Thu, Apr 23, 2026 at 12:07 AM Dan Carpenter <error27@gmail.com> wrote:
> >
> > Change the > comparison to >= to prevent an out of bounds access of
> > the dwarf_s390_regnums[] array.
> >
> > Fixes: 1e452dd850f3 ("perf dwarf-regs: Add S390 perf to DWARF register number mapping functions")
> > Signed-off-by: Dan Carpenter <error27@gmail.com>
> > ---
> >  tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c | 1 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c
> > index 310a37451bdc..f79216a7665a 100644
> > --- a/tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c
> > +++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c
> > @@ -45,7 +45,7 @@ int __get_dwarf_regnum_for_perf_regnum_s390(int perf_regnum)
> >         if (perf_regnum == 0)
> >                 return 0;
> >
> > -       if (perf_regnum <  0 || perf_regnum > (int)ARRAY_SIZE(dwarf_s390_regnums) ||
> > +       if (perf_regnum <  0 || perf_regnum >= (int)ARRAY_SIZE(dwarf_s390_regnums) ||
> 
> It looks like this mistake was copy-pasted into these files as well:
>  - tools/perf/util/dwarf-regs-arch/dwarf-regs-csky.c
>  - tools/perf/util/dwarf-regs-arch/dwarf-regs-x86.c
>  - tools/perf/util/dwarf-regs-arch/dwarf-regs-powerpc.c
> 
> Could you fix them all?

Sure.  Do you want that as four separate patches or just one patch with
four Fixes tags?

regards,
dan carpenter

