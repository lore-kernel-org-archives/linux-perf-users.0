Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D259237B;
	Fri,  1 Nov 2024 19:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730488672; cv=none; b=gM8kFmm/spAT7ukS1PqlgA+sy3XOTuVYqx4siFpQ0sa5wrTDdMoM8DtS9Wenj2Q80hedIr/uxVrLOW8se2K0EExnMVtV8gldWAAeYg4JxSApqrZANn0uIiJvAZf+7cL1FWyiKkvp6IXTEnC6L0+eZUXAzVuKFpxvQrDCHTYFLrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730488672; c=relaxed/simple;
	bh=VtGa5ZKU9NG61xn0besl1aRipUS8Q+BV5+j5oxULFeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWJu6hkS4dmxwtN3WfGiFSdAUupODbus/rqDddsBBuMHYVPH7oRH7DsQYWaeTupNj8nhfOwZwC+qhBQqkLKSY5uhShFTyIUNmMdpvrN9ASpnDcjYv0CO3mu+rmF8q9VZAnHxSB98uCHWOFogbIdvZ3KZ4FaFfyjjQ+W8Knx19AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 4A1J9BQU010012;
	Fri, 1 Nov 2024 14:09:11 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 4A1J981p010011;
	Fri, 1 Nov 2024 14:09:08 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Fri, 1 Nov 2024 14:09:08 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
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
        Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
Message-ID: <20241101190908.GV29862@gate.crashing.org>
References: <cover.1730150953.git.jpoimboe@kernel.org> <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org> <CAEf4BzY_rGszo9O9i3xhB2VFC-BOcqoZ3KGpKT+Hf4o-0W2BAQ@mail.gmail.com> <20241030055314.2vg55ychg5osleja@treble.attlocal.net> <CAEf4BzYzDRHBpTX=ED3peeXyRB4QgOUDvYSA4p__gti6mVQVcw@mail.gmail.com> <20241031230313.ubybve4r7mlbcbuu@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031230313.ubybve4r7mlbcbuu@jpoimboe>
User-Agent: Mutt/1.4.2.3i

On Thu, Oct 31, 2024 at 04:03:13PM -0700, Josh Poimboeuf wrote:
> Personally I find the idea of a single 4GB+ text segment pretty
> surprising as I've never seen anything even close to that.

It is pretty common I'm afraid.

> Actually I just double checked and even the kernel's ELF loader assumes
> that each executable has only a single text start+end address pair.

Huh?  What makes you think that?  There can be many executable PT_LOAD
segments in each and every binary.


Segher
