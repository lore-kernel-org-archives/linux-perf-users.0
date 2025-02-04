Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1139078F4A;
	Tue,  4 Feb 2025 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738693575; cv=none; b=Lwewy2w7Tbu20pqK2Ct1b+Toj95TVd/yj3GATnPlfvdCB0QSVVg0CTtrWNPuV2TITi0guYn+CZD3oVolZ3oxCcSsPMnCC/nlicm4vo4HRjAlCpqFibdCa7N5haZd8DaHDgGJpwLFcVzCnktqOPEscorvO49kQMleiq9H1Edt5vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738693575; c=relaxed/simple;
	bh=+zZo88fWMpzareMBHzUEcmJzdCa2kVu4nmgqRmPiips=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6yX9gI48IXAYbpHMjc9DvzfolM63wOPZ6flNc6wGlymZ+hyv7Mdia62CQMfg6HyDfVgbmqO37JsLZ6oB/q+dgQ9kPE0oKLqcq6cTK6v8o9rkuIGhm89CBySOSf9FaPkrw5l3GgjWm+mdWkxXnd3HWWy+1vKJ70zsrmdb4WhhlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWd7zb5p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWd7zb5p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492C9C4CEDF;
	Tue,  4 Feb 2025 18:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738693574;
	bh=+zZo88fWMpzareMBHzUEcmJzdCa2kVu4nmgqRmPiips=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nWd7zb5pERZeeR8FjBnNkTvN7O7NZTSAhetJB7P3UxTHIoSsul3eR4zZ8MGNZb6Wb
	 bHzYPX3er6N0iz8LaoUCtEHJ7LDDSLQyCTTj+ncCu6UvyWLbDGd/HOIhJbTMwqkbQh
	 aLuB3LYuEA6EuoGHCScxC2EF4Wq0sFiP6DVx+nd76Isw5axx/5yHWqJSP5zV/+BNKQ
	 SNNCEH0z8ncisSl2ZHLGhShmcUzYRDzGy3FiWdS5Rh8x4e5aJMpk/jbUOnpd1HgMTY
	 89cmA1jC2Ixdl9s86wxIlYOHd1jRtNzsLL0wIwCOBmA4/Yss/sWo+8284Gi9mTXRwg
	 q8EdK4OD/MS0A==
Date: Tue, 4 Feb 2025 10:26:09 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Indu Bhagat <indu.bhagat@oracle.com>, x86@kernel.org,
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
Message-ID: <20250204182609.ouiy7ppng3rscfpo@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <f27e8463783febfa0dabb0432a3dd6be8ad98412.1737511963.git.jpoimboe@kernel.org>
 <CAEf4BzbQGipBq-Ls1=n49nyNoX941Ka13HgXAXLTzGAo9wckAA@mail.gmail.com>
 <20250124192159.ypvqwoqjvhasamev@jpoimboe>
 <47f1e244-992f-44fe-a0a5-6c271e9c719e@oracle.com>
 <CAEf4BzZaWrscT1HrcUJkz45iMMuyCcA6ivfMffeHpxf=LmmXRg@mail.gmail.com>
 <20250129020249.owmklacvuvss7z7n@jpoimboe>
 <CAEf4BzYvrAAJv0+2FceJfizRURUsWxUBzRL-VOquM+VtAe-goA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYvrAAJv0+2FceJfizRURUsWxUBzRL-VOquM+VtAe-goA@mail.gmail.com>

On Wed, Jan 29, 2025 at 04:02:34PM -0800, Andrii Nakryiko wrote:
> On Tue, Jan 28, 2025 at 6:02 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> I'm not sure about this chunked lookup approach for arbitrary user
> space applications. Those executable sections can be a) big and b)
> discontiguous. E.g., one of the production binaries I looked at. Here
> are its three main executable sections:
> 
> ...
>   [17] .bolt.org.text    PROGBITS         000000000b00e640  0ae0d640
>        0000000011ad621c  0000000000000000  AX       0     0     64
> ...
>   [48] .text             PROGBITS         000000001e600000  1ce00000
>        0000000000775dd8  0000000000000000  AX       0     0     2097152
>   [49] .text.cold        PROGBITS         000000001ed75e00  1d575e00
>        00000000007d3271  0000000000000000  AX       0     0     64
> ...
> 
> Total text size is about 300MB:
> >>> 0x0000000000775dd8 + 0x00000000007d3271 + 0x0000000011ad621c
> 312603237
> 
> Section #17 ends at:
> 
> >>> hex(0x0000000011ad621c + 0x000000000b00e640)
> '0x1cae485c'
> 
> While .text starts at 000000001e600000, so we have a gap of ~28MB:
> 
> >>> 0x000000001e600000 - 0x1cae485c
> 28424100
> 
> So unless we do something more clever to support multiple
> discontiguous chunks, this seems like a bad fit for user space.

Nothing clever needed, we could just have multiple sframe sections, each
one with a pointer to its text segment.  That would also have the
benefit of allowing the sframe data to be much more compact for the
noncontiguous cases.

> I think having all this just binary searchable is already a big win
> anyways and should be plenty fast, no?

Sframe is trying to compete with frame pointers which are MUCH faster.
3-4x faster in my testing, not including the page faults (which tend to
only affect performance in the very beginning).

-- 
Josh
