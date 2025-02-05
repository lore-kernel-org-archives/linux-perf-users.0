Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F672F43;
	Wed,  5 Feb 2025 00:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738717033; cv=none; b=KuO6kgVp6DBHKBNRLWic+HroBohz/YvICYa+hb3+KrE9MIMe4qgHxoGqUdPWFvq1zQy0oU1fEAOB8kZvGMH6LwuBch5CI/qHw/Zwo+xSoaBBDHqoZCNr9OF5zFwh+wgzqZXGxtdd6C2K35hddTQfy+ycTJ7kQAOGtp5IdD7OKHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738717033; c=relaxed/simple;
	bh=B7z0x5seqAXVffdy9ePk/hSVwqrIAlxLk9eZJItykE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0x2/z+Uli24GhvdSGtcdMHajAzP8lOfFdCmO+QiAkb47gv6DCr1vO3HL7D2RMXpHnzhWUCJ9kQ9bT6peXIT76/dA6gahPHusFqaFHEh+glaTHVfQ3aqyKoxRLIVLqs2SiBjLPaixtFp71PlOsM01orK6PWlw7Daka/7s56hdrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Geqpiw4w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Geqpiw4w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29454C4CEDF;
	Wed,  5 Feb 2025 00:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738717033;
	bh=B7z0x5seqAXVffdy9ePk/hSVwqrIAlxLk9eZJItykE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Geqpiw4wAXIV6oo0v1qkE2bAZOcLFwMrC/iJGe9hClmdvvU95V5xUyaQw/Ns9mKhr
	 u4RRiVZCYaG4bWC+jZshNVa+pZ/W75/59p7WMnQ35SWP2cc9IfkMrciqO257AeIamb
	 p6TpyMmRvXlZhIPMIWMT787U/JLpZ293D4DGkyid4ubdPmVi2KDgGp3gLCNcqL+y/x
	 y9HlNeV5jmLUSJbc6L9jHCDiZhW+qu46KIYJliEYju+AxiR+6tPN4m6xC/280Cxzx6
	 gEUGNNta0qsDLSr2DLvoJkhX6k2FKNjW93FtLk5PSd8n5wggEVuYCYbCilHe1Q6kyS
	 Qh4xyyF6lDxrw==
Date: Tue, 4 Feb 2025 16:57:10 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Indu Bhagat <indu.bhagat@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 17/39] unwind_user/sframe: Add support for reading
 .sframe headers
Message-ID: <20250205005710.35wdzvobyhm6zyda@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <f27e8463783febfa0dabb0432a3dd6be8ad98412.1737511963.git.jpoimboe@kernel.org>
 <CAEf4BzbQGipBq-Ls1=n49nyNoX941Ka13HgXAXLTzGAo9wckAA@mail.gmail.com>
 <20250124192159.ypvqwoqjvhasamev@jpoimboe>
 <47f1e244-992f-44fe-a0a5-6c271e9c719e@oracle.com>
 <CAEf4BzZaWrscT1HrcUJkz45iMMuyCcA6ivfMffeHpxf=LmmXRg@mail.gmail.com>
 <20250129020249.owmklacvuvss7z7n@jpoimboe>
 <e4a52247-af59-4c0f-9215-00ee83a61339@oracle.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4a52247-af59-4c0f-9215-00ee83a61339@oracle.com>

On Thu, Jan 30, 2025 at 01:39:52PM -0800, Indu Bhagat wrote:
> On 1/28/25 6:02 PM, Josh Poimboeuf wrote:
> > However, if we're going that route, we might want to even consider a
> > completely revamped data layout.  For example:
> > 
> > One insight is that the vast majority of (cfa, fp, ra) tuples aren't
> > unique.  They could be deduped by storing the unique tuples in a
> > standalone 'fre_data' array which is referenced by another
> > address-specific array.
> > 
> >    struct fre_data {
> > 	s8|s16|s32 cfa, fp, ra;
> > 	u8 info;
> >    };
> >    struct fre_data fre_data[num_fre_data];
> > 
> 
> We had the same observation at the time of SFrame V1.  And this method of
> compaction (deduped tuples) was brain-stormed a bit.  Back then, the costs
> were thought to be:
>   - more work at build time.
>   - an additional data access once the FRE is found (as there is
> indirection).
> 
> So it was really compaction at the costs above.  We did steer towards
> simplicity and the SFrame FRE is what it stands today.
> 
> The difference in the pros and cons now from then:
>   - pros: helps mitigate unaligned accesses
>   - cons: interferes slightly with the design goal of efficient addition and
> removal of stack trace information per function for JIT. Think "removal" as
> the set of actions necessary for addressing fragmentation in SFrame section
> data in JIT usecase.

If fre_data[] is allowed to have duplicates then the deduping could be
optional.

> > Note FDEs aren't even needed here as the unwinder doesn't need to know
> > when a function begins/ends.  The only info needed by the unwinder is
> > just the fre_data struct.  So a simple binary search of fres[] is all
> > that's really needed.
> 
> Splitting out information (start_address) to an FDE (as done in V1/V2) has
> the benefit that a job like relocating information is proportional to
> O(NumFunctions).
> 
> In the case above, IIUC, where the proposal puts start_address in the FRE,
> these costs will be (much) higher.

I'm not sure I follow, is this referring to the link-time work of
sorting things?

> In addition, not being able to identify stack trace information per function
> will affect the JIT usecase.  We need to able to mark stack trace
> information stale for functions in JIT environment.

Maybe, though it's hard to really say how any of these changes would
affect JIT without knowing what those interfaces are going to look like.

-- 
Josh
