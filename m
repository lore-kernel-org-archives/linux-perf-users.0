Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302F743637C;
	Thu,  4 Jun 2026 13:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579777; cv=none; b=jHbt4k3/uA5OT7u3d2Inrpl/7k281fivXSl8IkjJ8A3JHI7GgSJ4ia6o97FESdHAvf0AnGrzurwaWWcfO3WbqVO6PpGsdSD/LgQpktrlS1/J60aWb+Zve9+BNIuPDWHp/Xc22iBrRq7NycsGZs63CDsoka5+KPjQzR3kdia3Fsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579777; c=relaxed/simple;
	bh=hajUNbFJmxe/Xdycv4h9tI8DFIpE+ZM7GQXb7k+Tgr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMXf2pQfeovysNXtloB6iqCoCZit9l/D13JC7yD2vJSrk8kND5Av1U9zLkuxHVbBM6BGcp8orfPXUjkosxJmKZQJD9Bml7CwU/F2/LCrqh4UHCu+4t9EhWN0gB95QlUW1hJNcN1eYH7qIseTkFbK4eBuG66SelB+MidXWzNXz+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aG2mDa5V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aG2mDa5V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A831F00893;
	Thu,  4 Jun 2026 13:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780579775;
	bh=jLgdCh9W8Dljw1IXeH19HMGnPypOsY0VJmzvYmVfswE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aG2mDa5VP5hIdxPgCnDRfsZvmDSalAmL2to6nq1QIpo7xtdGjnjQ09j8mxW7sR/Yn
	 zs9rcflR4ZKGy7LLJzkr5Qr1/QJEHq6nnztcTxoFlCTvlLxZP6KUPPbgTDmh/jmz0o
	 pClRS1ufYD8JBys70BF5x7d+AjQ7o47QEUZLbS8lZ9wxYYGg5O7FQtq40VgGOA5pCH
	 ILpPYXbq+xBrklewjJKYWFUsgGQz1EHkuZIsqAh931EYyxf7PvglK8W2V1g2DRiRe7
	 HXpVHPK6fqrl7U4dTlkpivoYJ9VL9W7ltjvTo03m4BL1HuW7HFM3e7TZOu5RjGkt81
	 0yRroYugEYIpw==
Date: Thu, 4 Jun 2026 10:29:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Michael Jeanson <mjeanson@efficios.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Derek Foreman <derek.foreman@collabora.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] perf data ctf: replace libbabeltrace with
 babeltrace2-ctf-writer
Message-ID: <aiF9vEuU2A3m0gUq@x1>
References: <20260512194710.162215-1-mjeanson@efficios.com>
 <20260520191452.218717-1-mjeanson@efficios.com>
 <CAP-5=fUehWvDZB+u1wYGMRa1WD8SUQMqzPqyQB4O78KBa43kOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUehWvDZB+u1wYGMRa1WD8SUQMqzPqyQB4O78KBa43kOg@mail.gmail.com>

On Wed, May 20, 2026 at 12:26:13PM -0700, Ian Rogers wrote:
> On Wed, May 20, 2026 at 12:15 PM Michael Jeanson <mjeanson@efficios.com> wrote:
> >
> > The 1.x branch of Babeltrace has been superseded by 2.x in 2020 and has
> > been unmaintained since 2022, efforts have started to remove it from
> > popular distributions.
> >
> > Babeltrace 2.x offers a very similar 'ctf-writer' library that can be used
> > with minimal changes for the '--to-ctf' feature and has been packaged
> > since Debian 11 and Fedora 32.
> >
> > This patch replaces the 'libbabeltrace' build feature with
> > 'babeltrace2-ctf-writer' using pkgconfig detection, adjusts the naming of
> > the public headers and applies minor API cleanups.
> >
> > There is no changes to the output ctf traces, the ctf-writer API still
> > implements version 1.8 of the CTF specification that can be read by
> > either Babeltrace 1 / 2 or any CTF compliant reader.
> >
> > Also remove some ifdefs in the cli option parsing to allow printing the
> > helpful error message with '--to-ctf' when built without babeltrace2.
> >
> > Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Derek Foreman <derek.foreman@collabora.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: James Clark <james.clark@linaro.org>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Its not applying to perf-tools-next, Michael, can you please take a
look?

Thanks,

- Arnaldo
