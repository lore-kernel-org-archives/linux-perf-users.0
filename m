Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AC41EF92F;
	Mon, 28 Oct 2024 23:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730159759; cv=none; b=kVyzwXgmr3yB5PTbBiv3G7I+bTe8Rla45Rj41HhSUwgq4/tJKTNgJ0/CSzk9kRY+Bcg6v3JZpGb3iEynDhNvJNmf7n8txRzpUprHi2+VWYIZQ2S2g1nent+nYh17FMRM7sPLrf4CP6g6DvMWaGPYeudk9YNLzl9+dW/s4elAA4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730159759; c=relaxed/simple;
	bh=yn8pmXtMPDVwM/CL0GlzMzykBosCTjJtPJtVvsu4WQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+u55axvVzHauRywbR7Asg/qnq6Xei3kTaqXQUn1gtdo2IP0lejaFPf3aHdz1Gx/Pj/VZaWRodsk6ey71u5nkAwtc8hQtceTlJyDvFij7B+PLFvthUJZNmU3/sVXa0LIJpCJabjyNa/EV9PkrfoXiCNzg2OufOXQnrmW/hEQlu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ht0DV9MH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ht0DV9MH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC76BC4CEC3;
	Mon, 28 Oct 2024 23:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730159758;
	bh=yn8pmXtMPDVwM/CL0GlzMzykBosCTjJtPJtVvsu4WQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ht0DV9MH6A+8IQp4lsAw/aOjztuUM86phGNdQvqcmddWXyin+EbwNUl5d/lYGLV2c
	 1Y9ZM/IQQ43i5gdkEOthK/wxp23h517TIO3BJhlJsQaQ+DQOJKEP4SCYghTiN6TIgZ
	 +6HTniG8JE+shaxwolQtFDsJ4/6DmVwJKGH4Sx6ocl7TOXmmz9rfcaD/NZ9omYhq19
	 ORqZHOvNicnsk3ovMXx1E/HsBqQ9Wu5OIx3r2bdGQT38lV7igE8gdcw5PWyLZwFMWV
	 EHW1N63/AM/WelLdYeEztAwMrz3pxPhH/eif1Oep67BxIxqiBxAmdDMNNFQPx3fOS+
	 ZN4t+ie/6yvVA==
Date: Mon, 28 Oct 2024 16:55:56 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
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
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 00/19] unwind, perf: sframe user space unwinding
Message-ID: <20241028235556.oyoyt3uvlau5vzsd@treble.attlocal.net>
References: <cover.1730150953.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1730150953.git.jpoimboe@kernel.org>

On Mon, Oct 28, 2024 at 02:47:27PM -0700, Josh Poimboeuf wrote:
> This has all the changes discussed in v2, plus VDSO sframe support and
> Namhyung's perf tool patches (see detailed changelog below).
> 
> I did quite a bit of testing, it seems to work well.  It still needs
> some binutils and glibc patches which I'll send in a reply.
> 
> Questions for perf experts:
> 
>   - Is the perf_event lifetime managed correctly or do we need to do
>     something to ensure it exists in unwind_user_task_work()?
> 
>     Or alternatively is the original perf_event even needed in
>     unwind_user_task_work() or can a new one be created on demand?
> 
>   - Is --call-graph=sframe needed for consistency?
> 
>   - Should perf use the context cookie?  Note that because the callback
>     is usually only called once for multiple NMIs in the same entry
>     context, it's possible for the PERF_RECORD_CALLCHAIN_DEFERRED event
>     to arrive *before* some of the corresponding kernel events.  The
>     context cookie disambiguates the corner cases.
> 
> Based on tip/master.
> 
> Also at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git sframe-v3

Argh, apparently it's a bad idea to pass "*.patch" twice on the
git-send-email cmdline ;-)  Sorry for sending it twice!

-- 
Josh
