Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD56F3D47C5
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Jul 2026 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782979179; cv=none; b=ANJbivynUSWrPmU5Ke+5/8HvrAmnD9ZMt5yrg2bg2aCdspM1mdEVAZamyO4C+58j+DrLlUNcAuKlCvzLJqO2uO8U5KIpzQfVYIlEsEI/2KfTJZ/25GC7vXdH/AywKmPJomHK7kMVK6y6TNFPKyX+s1fGg3m9tuGLhTKHLw6Nd8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782979179; c=relaxed/simple;
	bh=vRg8ejT1okP8H1BKFX7RnjGT4nGLmJ/GIqUOTUeg+rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUVNGjItlTog9BS9HL8WxYD5WtpCEA/xIjFtJamsp22TviNdAUYFdSWq1pEADclvyS0oNH3CCwbSKNn/bTQMWWAzFlYrwpU3l3Q1G06vZJxXWKakQk+NLZV9kdJE7Bga3xQQpHx63YNSrk3smtrDqZVehUfiFss750i1QNqFLo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cZo8RGxU; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cZo8RGxU"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso8153245e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Jul 2026 00:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782979175; x=1783583975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YKEK/klaSvR3KuXzn9lBRdKv/DAV0otTqYE5Q9JYbWE=;
        b=cZo8RGxUYvhTa3g25cb7mgXWFIp95k2Vo8KiN22NvDp/JHTpx704992vzKMWFOKvaS
         hs6rsKSWNuhf2GfTq1wrwrFb2I3kWD7SmoRGyNhv8tUrOtbtWvpiFnze+nklIJXaYtnp
         IRWv8i7156SAV00ltFmGS9gyb6P3HoCAkJ6VD6/KXJMkfz4eQmx68QSSnHBCpvuMV9h3
         tHtuEJLhGatfNrSAfq6y6owcJih4R9oMTDqnqeg8udgTENCgBq5Xcb1C7DaHw/96H4Iy
         JXe4/Lb/yJ7y/T3yu4BGrvGqn2WwlpSBC/FLOOJ/2BszDJ/F+RYHwyuph9tX3Ol3l8wW
         uZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782979175; x=1783583975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKEK/klaSvR3KuXzn9lBRdKv/DAV0otTqYE5Q9JYbWE=;
        b=B0CoWkfyVI7QtQijnqOply+lJ8dhKPYrrqWOVDl78oTCM3I3m8TBeJluSFQ/SK/f0A
         B361nEA76pi8bWHe0fff2iCax4dI5shSkQ4hf+4jV4yI3fLCqnkX+kwUk5A6DLFyfA1I
         u8s48v19CuwGrQON6eVdhVBXhsiypf2fpcfHK0qF3JIJgW4cOCYYBs2hy7a8cfzdya7h
         Zd8DH4Q8kCjBN2ezxO3aS5jrF3eZVADWCjvLyf3TW6Gv7LSVEOPQ9JiKtRRVMSNNQk7h
         RJL/6VODh79EwckR/qu0xah6rrxzw5nlgnXXER0PuT+tDh22JO5ihdmpDsCXEMXZte2F
         IsVw==
X-Gm-Message-State: AOJu0Yxw2Xir39+6NIkeF2zywKE9AyFpdarxLoBAGgojiPduONtGJv74
	dbIM9HDx4QOFEea1hyQYjUlu6EkyZVzCScmQgnLGbs9oJq9H7c12QcgHT1NlDH4g56k=
X-Gm-Gg: AfdE7cmxIREcnUI8MZrrE5WE1tV78KHbnkMPErszTBBtWrHjXenx5pz4GeI6tfrAWXR
	2cdJ+Qg2n6VxIBRJzfOTwMbRIxTJ4JexkLyjEY424snnIZnXnFcNxmb767GtzlmpRC/iSI46zu+
	gHrAcr/TdxeOj/5lVTWWScCgT1Gcdv5Gd+7vMGcB8SUet66/dAvwEFSgtSooQkuVWmsk3ylVTHy
	CzI6B0RMEjJki8jZoyplUPovW+LV0xASDMrbrS0vVYtW82DDEifOHENWm/uIma2eRi55fBG6Rrj
	GgsUHvkJaQRlbuhyk9PtVSjWsmcRJK2KtP+Ars9WgUw3vFcj0axnn9E5tcEmaook+LOksfM1JYg
	dUOcLLCbNRJe90BQdTtRlm6hWz2LwT4S41++mGU5exZ3W/bbnBfTFe5lbXLu7IsIpvb1ikt7WIK
	fy+kmuFeZcDFot6Ok=
X-Received: by 2002:a05:600d:8649:10b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-493c2b904e7mr57036485e9.22.1782979175224;
        Thu, 02 Jul 2026 00:59:35 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c6372368sm31052355e9.12.2026.07.02.00.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 00:59:34 -0700 (PDT)
Date: Thu, 2 Jul 2026 09:59:33 +0200
From: Petr Mladek <pmladek@suse.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org,
	Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH v2 0/2] perf symbols: skip livepatch symbols
Message-ID: <akYaZf228lnNLQbp@pathway.suse.cz>
References: <20260626212140.1380094-1-joe.lawrence@redhat.com>
 <akWomlgaxlvkBwkX@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akWomlgaxlvkBwkX@google.com>

On Wed 2026-07-01 16:54:02, Namhyung Kim wrote:
> Hello,
> 
> On Fri, Jun 26, 2026 at 05:21:38PM -0400, Joe Lawrence wrote:
> > This patchset fixes two minor perf bugs when livepatches containing
> > special so-called livepatch symbols are loaded.  In both cases, perf
> > should ignore these symbols as they resolve as relocations to kernel
> > addresses and not module space.
> > 
> > - Patch 1 fixes `perf test 1`
> > - Patch 2 fixes `perf record --kcore` bloat
> > 
> > 
> > Testing notes
> > =============
> > 
> > ("perf symbols: skip livepatch symbols when loading kallsyms"):
> > 
> >   Without patch:
> >   ./tools/perf/perf test 1
> >     1: vmlinux symtab matches kallsyms                     : FAILED!
> > 
> >   With patch:
> >   ./tools/perf/perf test 1
> >     1: vmlinux symtab matches kallsyms                     : Ok
> > 
> > ("perf symbols: skip livepatch symbols in kcore_copy")
> > 
> >   1. Baseline = pre-patch perf, no livepatch
> >   ------------------------------------------
> >   
> >   $ ./tools/perf/perf record --kcore -a -o /tmp/baseline.data -- sleep 1
> >   [ perf record: Woken up 1 times to write data ]
> >   [ perf record: Captured and wrote 0.221 MB /tmp/baseline.data (1717 samples) ]
> >   
> >   $ tree --noreport -h /tmp/baseline.data
> >   /tmp/baseline.data
> >   |-- [ 235K]  data
> >   `-- [   50]  kcore_dir
> >       |-- [  11M]  kallsyms
> >       |-- [  25M]  kcore
> >       `-- [ 1.7K]  modules
> >   
> >   
> >   2. Bloated kcore = pre-patch perf, with livepatch
> >   -------------------------------------------------
> >   
> >   $ insmod kpatch-5_14_0-570_94_1-1-3.ko
> >   $ ./tools/perf/perf record --kcore -a -o /tmp/klp-bloated.data -- sleep 1
> >   [ perf record: Woken up 1 times to write data ]
> >   [ perf record: Captured and wrote 0.274 MB /tmp/klp-bloated.data (2757 samples) ]
> >   
> >   $ tree --noreport  -h /tmp/klp-bloated.data
> >   /tmp/klp-bloated.data
> >   |-- [ 288K]  data
> >   `-- [   50]  kcore_dir
> >       |-- [  11M]  kallsyms
> >       |-- [  68M]  kcore
> >       `-- [ 1.8K]  modules
> >   
> >   
> >   3. Post-fix = patched perf, with livepatch
> >   ------------------------------------------
> >   
> >   [ kpatch-5_14_0-570_94_1-1-3.ko still loaded from test (2) ]
> >   
> >   $ ./tools/perf/perf record --kcore -a -o /tmp/postfix.data -- sleep 1
> >   [ perf record: Woken up 1 times to write data ]
> >   [ perf record: Captured and wrote 0.274 MB /tmp/postfix.data (2763 samples) ]
> >   
> >   $ tree --noreport -h /tmp/postfix.data
> >   /tmp/postfix.data
> >   |-- [ 289K]  data
> >   `-- [   50]  kcore_dir
> >       |-- [  11M]  kallsyms
> >       |-- [  25M]  kcore
> >       `-- [ 1.8K]  modules
> > 
> > Changes
> > =======
> > 
> > v2:
> > - Move klp symbol check into tools/perf/util/symbol.h alongside similar
> >   is_ignored_kernel_symbol() check [Petr]
> > - Use KLP_SYM_PREFIX instead of inlining it [Petr]
> > - Add similar check to kcore_copy__process_kallsyms() [Sashiko]
> > 
> > - Note: Sashiko flagged a pre-existing off-by-one in kallsyms__parse()
> >   where the symbol-name loop could write past symbol_name[] on overlong
> >   entries. That issue is unrelated to livepatch symbols and was already
> >   fixed by Rui Qi's 68018df3f55e ("perf: Fix off-by-one stack buffer
> >   overflow in kallsyms__parse()").
> 
> Petr, are you ok with this change?

Yup, both changes look good to me. Feel free to use:

Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
