Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE411BD9DD;
	Wed, 30 Oct 2024 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730310955; cv=none; b=knvihRi+OdDliXu7c/z3U5Yg1VHTQeXHrsyc3qJRamvoUf7+RBbb4wS/D20CHYEqNPwLfQfgjsJ4u8dhZY9t1uMDIWsC8kU5DMOVTgykuGLayRnsSgGM4Orcnw4D32TKj1dU8DBOP5bq3fdmM9mmafqTwafU9XHqfZ7sOsdno3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730310955; c=relaxed/simple;
	bh=b/XZhS5qvIF8GRTaPPLH4l/WRsHDNNMXvE3cGm+jC+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9U6kVJe0b5LqLTy4GxDLnOK635cE11Q44itCXdRutxpUGZcnSpLdevqLq1mYBpe/Odb79jhCveN0A2ZMWqCAfnqzzQiFQ3Ax62K5yL6OPKQpCV1oJE8ufc+CSfQr/D1xzC0tU3y6IMIjIOqZH+VE+5aUTfxKTdxgc/dGBj+MXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ozs9COpH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ozs9COpH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60380C4CECE;
	Wed, 30 Oct 2024 17:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730310955;
	bh=b/XZhS5qvIF8GRTaPPLH4l/WRsHDNNMXvE3cGm+jC+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ozs9COpHkUTgo+pspB79K0MA2RfmpSIvmi43C5dKpUXQwMRT15P1cxY2uvONUv/pC
	 MD1gpprssuL04GzFOuk1fmVCCh/azeAwvjGKbFRL8JTze43dZqi0pdAaPblR/UcaMf
	 O/dQjCETTvMinCoyzxixu/6d0nLhGKFg1Yt1A1Yosu/HptFWTcTXEhQmtmrrgfRLBD
	 ohpa2yK9w6uuzaKvvVR2uQFgmTSn/I8BOE5Rgsh5zvw+Cy0FYer4khLsEk4AAWe2D1
	 hikNIbtBL6ajOBXaYCiF0wZOJVOf+SjzLo2Rp1vK8+F5SVpd05h8x4xeZHn194xBZr
	 ONTJORhKs8bkA==
Date: Wed, 30 Oct 2024 10:55:52 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
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
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 11/19] unwind: Add deferred user space unwinding API
Message-ID: <20241030175552.22cza6t7dfe3xy3p@treble.attlocal.net>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <a94eb70a80c4a13dedb2655b7848304a992cb1b0.1730150953.git.jpoimboe@kernel.org>
 <20241029135617.GB14555@noisy.programming.kicks-ass.net>
 <20241029171752.4y67p3ob24riogpi@treble.attlocal.net>
 <bcd11a07-45fb-442b-a25b-5cadc6aac0e6@efficios.com>
 <20241029183440.fbwoistveyxneezt@treble.attlocal.net>
 <74afc8d4-621a-4876-a8cf-6165a913e4b3@efficios.com>
 <20241030174752.gwzk6q6n2f3sg52a@treble.attlocal.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241030174752.gwzk6q6n2f3sg52a@treble.attlocal.net>

On Wed, Oct 30, 2024 at 10:47:55AM -0700, Josh Poimboeuf wrote:
> > Moving from per-cpu to per-task makes this cookie task-specific and not
> > global anymore, I don't think we want this for a stack walking
> > infrastructure meant to be used by various tracers. Also a global cookie
> > is more robust and does not depend on guaranteeing that all the
> > trace data is present to guarantee current thread ID accuracy and
> > thus that cookies match between deferred unwind request and their
> > fulfillment.
> 
> I don't disagree.  What I meant was, on entry (or exit), increment the
> task cookie *with* the CPU bits included.
> 
> Or as you suggested previously, the "cookie" just be a struct with two
> fields: CPU # and per-task entry counter.

Never mind, that wouldn't work...  Two tasks could have identical
per-task counters while being scheduled on the same CPU.

-- 
Josh
