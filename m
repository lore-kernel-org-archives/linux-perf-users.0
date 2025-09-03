Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC2628AAF9;
	Wed,  3 Sep 2025 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914593; cv=none; b=iElJH/UTAw3JdU+mYaLOUD7hq/nwFkVgq5XstyZM6esxKgoTG1v5kH4FRpqtnwwL1R5HGUVhn9QnrloWsyqERyrCb0QG87XtTSPIo6lxfx35r0sgZokEjRLbUfK4L+cGMi87i/QKYTDib7Hd6H4N/55eB4C99DY/4IJa4Syw8LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914593; c=relaxed/simple;
	bh=YnxvmziU3045b9ncHephY70zMbzXiFiPjZSFZ2qzTVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JL+YXQTeyPGwP5zpD7JvW3rP+8BPg2bqpIfWz8riSFgIvSU2IHHEbessaZpR8n7BoJVOCh52ALSBqq0A0LIa5/kDsuHfZl26QRckCpepRYBt/DcELLoQHSaNl8VKmxhDOLkWyFhlZ4d6VY7lBYWrgDFljDu0YmnptEo1hdDmVJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hs/V/4ZB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hs/V/4ZB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F1FC4CEE7;
	Wed,  3 Sep 2025 15:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756914593;
	bh=YnxvmziU3045b9ncHephY70zMbzXiFiPjZSFZ2qzTVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hs/V/4ZBUuXzu5FPpigR/cIvaX6BxBqDhmYxagqwOZjsy25L9d3qlWpG0LEf21M+q
	 06XUUKy06FBrbmSM9lUipUL1aWhfEMB4bUiiHNv+q3I6gbMkJDsAWkhHEYzJRNc8DL
	 8WeeW5AjGk1qmURfxhnYs0z9akPzSKMi3Ui0+k7HGuL0FbLcxZFBuH9bgqSextyJWj
	 IzEYd0yVJwmGJpTQS0hKxg7QhqY+eS21ryamh+IQ5rRVn96gH+sOGM3STsrgUB67/e
	 Gw6e1+CGvwv32Ypft8IqJNWpAnge3BP6IS5atIlNe83fx0GAya3UWWAyMCSLp+VbjJ
	 DO62fZOmKsMPw==
Date: Wed, 3 Sep 2025 12:49:49 -0300
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
Message-ID: <aLhjnex4_SXpV_8N@x1>
References: <20250825195412.223077-1-zecheng@google.com>
 <20250825195412.223077-2-zecheng@google.com>
 <aK_8kt5Yf9MDoPdu@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK_8kt5Yf9MDoPdu@google.com>

On Wed, Aug 27, 2025 at 11:52:02PM -0700, Namhyung Kim wrote:
> On Mon, Aug 25, 2025 at 07:54:03PM +0000, Zecheng Li wrote:
> > match_var_offset compares address offsets to determine if an access
> > falls within a variable's bounds. The offsets involved for those
> > relative to base registers from DW_OP_breg can be negative.

> > The current implementation uses unsigned types (u64) for these offsets,
> > which rejects almost all negative values.
 
> Right, I thought it cannot get negative offsets except for stack access
> (e.g. fbreg).  But it turns out that container_of() trick can generate
> them with optimizing compilers.
 
> > Change the signature of match_var_offset to use signed types (s64). This
> > ensures correct behavior when addr_offset or addr_type are negative.

> > Signed-off-by: Zecheng Li <zecheng@google.com>
 
> I've confirmed it produced slightly better results on my test sets.
 
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Cherry picked this first patch to make a bit of progress in the
perf-tools-next front.

- Arnaldo
