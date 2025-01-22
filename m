Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A6A8F7D;
	Wed, 22 Jan 2025 21:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737581844; cv=none; b=Hs9eU6VkhDF+uNYJ0kBfrIVXE+jIEQgyTYKLkp8m6Cipd/m3eEy/56Nfu15snVVyRY52wF5AX89L6VA+BLSydbTzEtYx4JW1sdUCKQCT5UQmwsxLm1d5G/Zk3QDhtBZ+LcsRbV7yS+sV/NbHyLlTMLBzPua62cbdPqvAta9EqNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737581844; c=relaxed/simple;
	bh=h/FXToUat0JFfLM9H2+yAYkHxBYDs0KhogdClMOv3Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRjFDkbZe600GWdnmyK/ChvNEliqijLvVTamz8FG/CpQu6Ow9XvCiFFa1M6Rmm5A+7q8yuq9NLDBfoaimnwKbW4S8Zv3CKuRBLZeYKpRot9VWhoprSYVQ86urtduIUbpQY7GvurzOv43oM3uz8TMsfoj7hbWqnfQVcMtSCoc9W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQLEobd4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQLEobd4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1169BC4CED2;
	Wed, 22 Jan 2025 21:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737581844;
	bh=h/FXToUat0JFfLM9H2+yAYkHxBYDs0KhogdClMOv3Y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kQLEobd4PNgWmR4eCOBVfpF7o+6oJ3g8wUgPPlVnjB6LbH7tqqsaL7KmJ8XiJr4CN
	 ylqCFOGutrelsCgPo2Zx4xbwKWtCdTL6lFklrNfmxBI+D5EgD342DFVGnH4hyCSCRW
	 /QHZ4mNyyeM3IaAe8DDZHRZJnt4HKd1YopyRF1ergLC68PdLBvlxv0hZROKxlo3YgH
	 MI7aT+V80T3w4oQOCo/ZP5Vr9AxP0gNdTbzvddkBU29krMhYExegjSBkcCg2ZvF4P4
	 0qhv3XtXCvg5ugIIs2k7J53pub9fPCPjfcQrzC2vXvb2n+9oEGTDXzZ+VT7DiYu3XS
	 TJ4XGpwvUVNiQ==
Date: Wed, 22 Jan 2025 13:37:21 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
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
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 14/39] perf/x86: Rename get_segment_base() and make it
 global
Message-ID: <20250122213721.4h3kogmf2waun3tq@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <e54e48ab228aa386fb4c5f64ee02ef5291f2d3da.1737511963.git.jpoimboe@kernel.org>
 <20250122125154.GP7145@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250122125154.GP7145@noisy.programming.kicks-ass.net>

On Wed, Jan 22, 2025 at 01:51:54PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 21, 2025 at 06:31:06PM -0800, Josh Poimboeuf wrote:
> > get_segment_base() will be used by the unwind_user code, so make it
> > global and rename it so it doesn't conflict with a KVM function of the
> > same name.
> 
> Should it not also get moved out of the perf code in this case?

True, I'll try to find it a better home.

-- 
Josh
