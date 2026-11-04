Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825635;
	b=5JCJVE4i0TtlEjWg+l9fLbKxFGZVPYr9apsy9q7KS5YNCNP2KWOdU33YSCSV8qeMM1VH
	 x1ejaKHHdSE8RWsGISIR3zp6u/5IG9Gdr1NzsJqyfHzjqPB8UerQbThGP8by1esenYQz/
	 SKfn046+rDb9K1ET4Ia5Y47lL+vqSo9wVSBi7Zdj+vQd/BRPlBNZGT0/QHhBL7zWvTFE0
	 8lfkbD6EzbBJJgsN2R44UyzZNCIInuL/SvQTotfqgaojmDG2YluQ78jrXgf7b3BrVZBlW
	 VGbqQb0wBfFuyRe4AUS0hd/L+UbrWbBFO6C7HbLBGizxbiyrO2caSZwR5vOu2qdpQhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825635;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HWLOq4qtfbMphmVaiYHtmULf2RgucUsQCzVuDARfa/4=;
	b=SwbGeeI7fQwo6/Pu9vukjSytEGTv1mij5AoGMUBEEEdr1wxzAcpmNfVMBXWpLkZWWpB5
	 uwEPpAutop3b6kTpN1iDCayFWosfJ5eWEWrPDyF5j/miJQQJwYb0SbKbQRZxxJJGP0gy/
	 TAFzQqMKhoKvsnH6zZ68w7yijg1gTndv+DUGFlZY0T/jVO/eMAXLOzTgsCxsbroOdBbVG
	 VVHD4hSHJJvztIET4ERkwC6pAhtQ4CYzS1rBs2yEUR602bd/QJs9JZS7vunEvp0UmpfZD
	 wvWnxuyzHPR2K1jqao18GRFZwpyhI38SFV1rzIrpp62ZNdI4ixcALppPhiNm8l5P8eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jkJrr6gL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93595606C91E;
	Wed,  4 Nov 2026 20:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jkJrr6gL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD871F000C1;
	Wed,  4 Nov 2026 20:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793825635;
	bh=HWLOq4qtfbMphmVaiYHtmULf2RgucUsQCzVuDARfa/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jkJrr6gL7/ZqREnA+f1m1/Tpgkl/VDYEWJ5ja5FlC1e+4Q5J05qzLnvS2QGVq4dN5
	 ar8JP0SSxkvKyfflOn78v12NenMRw3eVpN2MbaAFRVdUmdSioArX6FLcThWzA4P18+
	 XH5xl25j4+GLJ093NYU/UYkwg1/WfNnF5ztvfQhql6terxaRsxjo4fF/xeADPOJu7B
	 OJRwX3cUHPzVkSbkLW2efd7invXPRNP1OZAHgpGrvLxW6YoYe61dGUu/6fF/szYleo
	 IXE6Wtaf4qk5BIot7Wwz79IrE44MXJFYGRtwNE8jnD7ICAvOD8VobbLCRNldn4bbU6
	 jBdkeXDpE/6SQ==
Date: Wed, 4 Nov 2026 12:53:52 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	chjohnst@mail.com, neelx@suse.com, sean@ashe.io,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH perf-tools-next v12 01/10] perf ftrace: Handle signals,
 non-blocking reads and pager exits in __cmd_ftrace()
Message-ID: <auubYIQRs560OPXk@google.com>
References: <20261026025735.546101-1-atomlin@atomlin.com>
 <20261026025735.546101-2-atomlin@atomlin.com>
 <auWU4JndXjxKzBbm@z2>
 <gv2ojndchlo5yuwpqas554vgavuixfoenmaqsulvmqc65itz54@fjumgdv777w4>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <gv2ojndchlo5yuwpqas554vgavuixfoenmaqsulvmqc65itz54@fjumgdv777w4>

On Sat, Oct 31, 2026 at 06:29:30PM -0400, Aaron Tomlin wrote:
> On Sat, Oct 31, 2026 at 12:12:32AM -0700, Namhyung Kim wrote:
> > On Sun, Oct 25, 2026 at 10:57:26PM -0400, Aaron Tomlin wrote:
> > > In __cmd_ftrace(), trace_fd is configured for non-blocking I/O via
> > > fcntl(trace_fd, F_SETFL, O_NONBLOCK) and polled using poll(). However,
> > > the polling loop previously treated any negative return code from poll()
> > > or read() as an unrecoverable failure.
> > > 
> > > If poll() or read() is interrupted by a non-fatal signal (i.e. SIGWINCH
> > > upon terminal resizing), errno is set to EINTR. Furthermore, read() on
> > > trace_pipe can return EAGAIN/EWOULDBLOCK even after poll() indicates
> > > POLLIN (for instance, under concurrent readers, spurious wakeups, or
> > > block-mode trace iterator options). In all such cases, breaking from the
> > > loop causes perf ftrace to terminate tracing prematurely.
> > > 
> > > Additionally, output errors on stdout (i.e. when a pager or consumer
> > > process exits, closing the downstream pipe) were ignored by fflush(),
> > > leaving __cmd_ftrace() polling indefinitely until the workload
> > > completes.
> > > 
> > > Resolve these concerns by retrying poll() upon receiving EINTR, retrying
> > > read() on EAGAIN, EWOULDBLOCK, and EINTR, and breaking on EOF (n == 0).
> > > Furthermore, detect stdout errors and broken pipes via fflush() and
> > > ferror() to exit immediately when the downstream output sink closes, and
> > > handle EINTR and ferror(stdout) cleanly in the subsequent buffer
> > > draining loop.
> > > 
> > > Fixes: d01f4e8db22c ("perf ftrace: Introduce new 'ftrace' tool")
> > > Cc: stable@vger.kernel.org
> > > Tested-by: Ian Rogers <irogers@google.com>
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> > 
> > Acked-by: Namhyung Kim <namhyung@kernel.org>

Applied to perf-tools-next, thanks!

Best regards
Namhyung

