Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF74236B0E
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Nov 2023 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojpN+zsH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB46C433C7;
	Thu,  9 Nov 2023 19:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699558681;
	bh=W+5EFbRzSc82wWtYP28Rf+JY1o29oWZOx/AX38zMweA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ojpN+zsHVHV7MsUrOxLQZleMAomXqi9fUD6vJPBHHaFF1EPyMfOIj5uxObb1aQq16
	 lVlITggUlrqxgCyWFPjeMLKnvaRjusibGPqeN6Vd7oN5xY0fMsNSVVp8etGeL9n5Hu
	 6FSz3Ws1jslpIjmQHYZhbvGUu27OWNNdZ+l1t3XFG646rYKK/NuQ1ZjYJqJBkjVvZJ
	 TxYaaJB7mLgznprux11GmiG6ZzrTly1CQuxWf5PlW6rMoXqTYZBA+oHCuVSJjR/3Pu
	 LzxDmBRN71amcgZMa7gq6C8G6QU76oO+VkyZXYt3k4XOVPPYgXJs7bH/l/8jWaekCh
	 9Bdrnf7wvUTyQ==
Date: Thu, 9 Nov 2023 11:37:59 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Indu Bhagat <indu.bhagat@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org
Subject: Re: [PATCH RFC 09/10] unwind: Introduce SFrame user space unwinding
Message-ID: <20231109193759.6wugcdpucoilnncl@treble>
References: <cover.1699487758.git.jpoimboe@kernel.org>
 <09460e60dd1c2f8ea1abb8d9188195db699ce76f.1699487758.git.jpoimboe@kernel.org>
 <24e46e1c-e9fa-4d44-97f2-068bda6e54b4@oracle.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24e46e1c-e9fa-4d44-97f2-068bda6e54b4@oracle.com>

On Thu, Nov 09, 2023 at 11:31:59AM -0800, Indu Bhagat wrote:
> > +	if (shdr.preamble.magic != SFRAME_MAGIC ||
> > +	    shdr.preamble.version != SFRAME_VERSION_1 ||
> > +	    (!shdr.preamble.flags & SFRAME_F_FDE_SORTED) ||
> > +	    shdr.auxhdr_len || !shdr.num_fdes || !shdr.num_fres ||
> > +	    shdr.fdes_off > shdr.fres_off) {
> > +		return -EINVAL;
> > +	}
> > +
> 
> I would say that it will be ideal to start the support with SFRAME_VERSION_2
> onwards, if we have a choice.
> 
> The structure SFrame FDE in SFRAME_VERSION_1 was unaligned on-disk.  We
> fixed that in SFRAME_VERSION_2 (Binutils 2.41) by adding some padding as you
> have already noted. For x86_64, its not an issue though, yes.

Agreed.  I actually had v2 implemented but then realized my binutils was
older so I changed to v1 for testing.  But yeah, we can make v2 the
minimum.

-- 
Josh
