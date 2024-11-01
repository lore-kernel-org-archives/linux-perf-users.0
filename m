Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAF41D0F50;
	Fri,  1 Nov 2024 19:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730490483; cv=none; b=mQIIHIO0U5jAY7dxjC76QoHtNo/baHSM0kpmIt6qeTDc9dXFhxktALS7olBPVQHQNAwWfWpL5Ic9NrCwkq8une3muik+1iSxzrzFdQBajQHzhO6WR55Mb+xkGsXHP0n1NnaMKoR9U1f9VtTZTn18i+bHpp/4XeCWNJwzIOxBezo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730490483; c=relaxed/simple;
	bh=qo7GbqyYnpGbEFsr9GufnLpQzs5ZRmYHGT+PyV+DU3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WX5VHNvzRAtycnfuhqMwcLMavKKmwD5W4Ithmek30hlacxIVKd4a6SeeUYwP2covofC0zcA/E5SyaB3WuBn8u6o0fzGJp2jC7v7suPXK2rsfQWzRBsmQfd0RAfoAoJfoPo2KsF9xXraNFVJ4ZcdqQPuCeTRnC5RuRUpOLT76mOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qBeBYKDo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBeBYKDo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE0CC4CECD;
	Fri,  1 Nov 2024 19:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730490483;
	bh=qo7GbqyYnpGbEFsr9GufnLpQzs5ZRmYHGT+PyV+DU3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qBeBYKDouAya22fb9hqZbKiAxW/8Vvy8zVTdyxuVusnd7wzvcRt6VG+0iMuMcz12/
	 ugIdpAuKfYduJg10Y+qbm41VrKXRQds0k+ngUrRkY4ChgcIxRwONAR6mcFLcp/SmwL
	 7qxvgPCdJJwCbY5jEzPLMuR3Ub9QPDzhG5CShWj0s/7vgnP4BG+4RYZPnRbGfdZiev
	 l2Kv0C4FftFYGCmNV4Gm0GNDCDi65kdzQ+Gebxs1xRl+sshDOsK23coBqPYvQIoRXf
	 TCV7rfuh9mDyW0Rk6jbtY48DDuhIRxdMhJSVXkHuIInq2Wz2HPeTCkWxWSX7KZTHHU
	 7sIZ/0Qt4iDtw==
Date: Fri, 1 Nov 2024 12:48:00 -0700
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
Message-ID: <20241101194800.wmvjljs7uxcuriem@jpoimboe>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
 <CAEf4BzY_rGszo9O9i3xhB2VFC-BOcqoZ3KGpKT+Hf4o-0W2BAQ@mail.gmail.com>
 <20241030055314.2vg55ychg5osleja@treble.attlocal.net>
 <CAEf4BzYzDRHBpTX=ED3peeXyRB4QgOUDvYSA4p__gti6mVQVcw@mail.gmail.com>
 <20241031230313.ubybve4r7mlbcbuu@jpoimboe>
 <20241101190908.GV29862@gate.crashing.org>
 <20241101193305.afwfopg4ryrrgxfb@jpoimboe>
 <20241101193510.53xj5ybz6vyyqb37@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241101193510.53xj5ybz6vyyqb37@jpoimboe>

On Fri, Nov 01, 2024 at 12:35:13PM -0700, Josh Poimboeuf wrote:
> On Fri, Nov 01, 2024 at 12:33:07PM -0700, Josh Poimboeuf wrote:
> > On Fri, Nov 01, 2024 at 02:09:08PM -0500, Segher Boessenkool wrote:
> > > On Thu, Oct 31, 2024 at 04:03:13PM -0700, Josh Poimboeuf wrote:
> > > > Actually I just double checked and even the kernel's ELF loader assumes
> > > > that each executable has only a single text start+end address pair.
> > > 
> > > Huh?  What makes you think that?  There can be many executable PT_LOAD
> > > segments in each and every binary.
> > 
> > Right, but for executables (not shared libraries) the kernel seems to
> > assume they're contiguous?  See the 'start_code' and 'end_code'
> > variables in load_elf_binary() load_elf_interp().
> 
> Typo, see load_elf_binary (not load_elf_interp).

Hm, actually AFAICT that's only for reporting things in sysfs/proc.  So
maybe it's assumed but not really "enforced".

-- 
Josh
