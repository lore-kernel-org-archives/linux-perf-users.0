Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A0A2ECD1A;
	Sat, 13 Sep 2025 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757774103; cv=none; b=jQs8WyP7BR9krPmNR3Li8HHf9IL/pQzd9GNn+GJGIPmgOHtVrkZOjSkrW4rmCQfwKlyy1R/qAj8Ag3JVdWy+ypLN0X7grzqDUrtupc8KejZD7SMEzeKDFtzsHaGC12b0q85hZyBMIwyWyeoRJIhuzgx7dvDCQNDoLcXpMmnb0J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757774103; c=relaxed/simple;
	bh=mUNm4okNp29XKgDWmmCQhXnA0JTa73TiDnxRLFhXz5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R44PlsY32bRncsRDxjyWIOohDVYEfg7lsqenDKg/cULhgz05CjguJi9hGbZa4G1aZmhd8Rduy6GohmPygqz/0jynRO2vve0KQsurPayf4ftkCO3bPtvZdOniNx3Ssom1MJgCj4HCa/Ydr4qUNuWkIrdcpHz1gseYfA1MQsPFIe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvdJtFz4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvdJtFz4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F322BC4CEEB;
	Sat, 13 Sep 2025 14:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757774102;
	bh=mUNm4okNp29XKgDWmmCQhXnA0JTa73TiDnxRLFhXz5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LvdJtFz48otkJeBu8uxmpzP4p/NGG9PDh6YaqfPobqxLQmrrm7TuhfpOu7ThB0Hph
	 a2OIZs3RJ+rEt+ZsLiJH2fZapLE5SAIOXLE9VKW+bMhQw6SZry9pHTnKoJno+b1t8B
	 9EYbr4vHwBjgwP8WEjLonFIo1zltie7ApDyOJ7qWri0P6t9afLcHyeZOvRMTRTc15n
	 wwGlrYFn//FcoT4qf3gQgXoAqmZV/oS6ppayJgZbJHadUV5jjiYylbKOvtjEy0G82O
	 pCXYj2aupyNarpdDA64VWJKsuzS1SyMxU8hl4bH2WtPUWd57iNECb0s9HnOPyb8E13
	 kLEcaVw67G7EQ==
Date: Sat, 13 Sep 2025 11:34:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Zecheng Li <zecheng@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] perf dwarf-aux: Use signed variable types in
 match_var_offset
Message-ID: <aMWBE4L2RtEXhxgG@x1>
References: <20250825195412.223077-1-zecheng@google.com>
 <20250825195412.223077-2-zecheng@google.com>
 <aK_8kt5Yf9MDoPdu@google.com>
 <aLhjnex4_SXpV_8N@x1>
 <aLi7o0hB23v7wpJ9@x1>
 <aLs_BuzNJZt6Wl2g@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLs_BuzNJZt6Wl2g@google.com>

On Fri, Sep 05, 2025 at 12:50:30PM -0700, Namhyung Kim wrote:
> On Wed, Sep 03, 2025 at 07:05:23PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Sep 03, 2025 at 12:49:49PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Wed, Aug 27, 2025 at 11:52:02PM -0700, Namhyung Kim wrote:
> > > > On Mon, Aug 25, 2025 at 07:54:03PM +0000, Zecheng Li wrote:
> > > > > Change the signature of match_var_offset to use signed types (s64). This
> > > > > ensures correct behavior when addr_offset or addr_type are negative.
  
> > > > > Signed-off-by: Zecheng Li <zecheng@google.com>
   
> > > > I've confirmed it produced slightly better results on my test sets.
  
> > > > Reviewed-by: Namhyung Kim <namhyung@kernel.org>
  
> > > Cherry picked this first patch to make a bit of progress in the
> > > perf-tools-next front.

> > It is in perf-tools-next/perf-tools-next now (this first reviewed one):
 
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/?h=perf-tools-next
 
> Thanks for doing that.  Please pick up the patch 2 and 3 as well.

Done.

- Arnaldo
