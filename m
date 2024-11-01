Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC511487D6;
	Fri,  1 Nov 2024 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489588; cv=none; b=lhYwtZKIVuFZDNKB2m+iZLhtYckdeZeZMkuOejQ5aEXGRwAqfY3QV8TzloZtyjkieXjnu3hhtnoG/4810L0AlYGgH7Q+J8RNSCwHjaIiPq4/wTYEdHZaRYRbAFpqBCKyyWCKNN2Co6xUr2uGIpVNzvGdD3F5o3Uqu5oVL3+6KGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489588; c=relaxed/simple;
	bh=0uD++iOkLSBl1jcPzNlz7t8Yip9BoZIgrsePVcD3N+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sX3wIAI8fOc4YBlyRM5Wr89n40ltTBIqdM0wwEhTtBS2bAwsYKoPuLF4j0ce1p5ML9pHsO1ip/0hF0TqkduYh0bA+iDQ3Ha5uYvkuaL/ca+tj2ZwHuH5mAobmZYIGUD6r+EYq0HQ8JZKngtQRyqnUgwzmR9BWhHF+fnowpISWAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0iF1QR4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0iF1QR4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9602BC4CECD;
	Fri,  1 Nov 2024 19:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730489587;
	bh=0uD++iOkLSBl1jcPzNlz7t8Yip9BoZIgrsePVcD3N+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N0iF1QR4Zrq00f6yzkwn18Dr9KLs4CbBg8u6njyERfEe6kiLR/LpO8qjm15aLisOj
	 +l6s/riYloOT/DS/J9aXatl1r9zhZZj8rseY2Y4LARYqDbwha38p4lVMLlJZV/8EQ1
	 I5rHjUuVEDSOU7L8qKAawmOTijuZiQCsLMzVZqH6rsRuWPtaabzIoouqPs+S414rJu
	 zZRxpxxRxQI+OswOGtQu8F+NKpxClwM8H5jJaZmxdbJWBxNztjssU+62o4S0RSZNLn
	 yZj5/ho/LxF4Lye+w3XlaT2GorRxaPojoOsOn2j6qzjxVTKpLjXQI87scc4qHpfHNv
	 ZzW7lQA+QVg7w==
Date: Fri, 1 Nov 2024 12:33:05 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
Message-ID: <20241101193305.afwfopg4ryrrgxfb@jpoimboe>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
 <CAEf4BzY_rGszo9O9i3xhB2VFC-BOcqoZ3KGpKT+Hf4o-0W2BAQ@mail.gmail.com>
 <20241030055314.2vg55ychg5osleja@treble.attlocal.net>
 <CAEf4BzYzDRHBpTX=ED3peeXyRB4QgOUDvYSA4p__gti6mVQVcw@mail.gmail.com>
 <20241031230313.ubybve4r7mlbcbuu@jpoimboe>
 <20241101190908.GV29862@gate.crashing.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241101190908.GV29862@gate.crashing.org>

On Fri, Nov 01, 2024 at 02:09:08PM -0500, Segher Boessenkool wrote:
> On Thu, Oct 31, 2024 at 04:03:13PM -0700, Josh Poimboeuf wrote:
> > Actually I just double checked and even the kernel's ELF loader assumes
> > that each executable has only a single text start+end address pair.
> 
> Huh?  What makes you think that?  There can be many executable PT_LOAD
> segments in each and every binary.

Right, but for executables (not shared libraries) the kernel seems to
assume they're contiguous?  See the 'start_code' and 'end_code'
variables in load_elf_binary() load_elf_interp().

-- 
Josh
