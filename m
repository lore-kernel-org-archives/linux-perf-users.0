Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8B04D954D;
	Mon, 28 Sep 2026 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612822; cv=none; b=YzuRRy905O06UqKvGt6p75karijRMXRYWrR57vVzXmvQ7wxPq08uWU50HltIVru0tc/cxdKFqk/bfgYv67JmkKN//351biyHGKDhCVZjKi9agpZeNlD8YdePEWbScrTFg4kt0NiiFJXsEClf7oITmFCwLl3ofEFdWt0m/XUh0Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612822; c=relaxed/simple;
	bh=+0xqLCmbL5WWoAbeBD1OogqgbOApBgNJ3qsGc8KOcnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbsBXeGQEYu9edi0+b5M6EWGKf9I7wde7LmBmxb5BQborK5Lnil5/9Ht2kCzKYNT1Ar+Tv7T2xE6jKn9rnSXNssor4Lucp9vWyef8cvjQKVi0k97TUdSm30VzxNAXfKP82Xz/J8TucMK2A/dnakdrpZ13unwBGgO701HrdbkfjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7G2KwjF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7G2KwjF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3873B1F00893;
	Mon, 28 Sep 2026 16:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790612820;
	bh=+Od5jlHA59F449Ih3JqYBzOCfujYaWPV4dCS9J6l7lg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W7G2KwjF9Arc9f97cEeeKQcdBD8A2seBv16CSRSYUyOGT2u0jVy5Hkrdqym5D22Qw
	 E/Rb5QNF9mfbks1T73aOark1DXDs2tVuLdLw4gSVHNpo9BJiwZ0ojO1hex3DngmzUJ
	 KJdyCOvTqRhd3j2UjTkPGT8Hh+Ymt/zhATCxBiC8wjv4V7lkDhljvXHotgOfqsYIuJ
	 V7m7/dNH6yroifYza2CheMrsTJ8FXm7ohzmAWtzzG0yKKxuF7SYFA1VrWxmACNHG7J
	 8wyPIlXjTrStmoxw2ydzwMIzeLbhVz/t/dprGptBBj5SExHg6xCOYVlhDZv/pdGGFb
	 hVcQbus1lyIAg==
Date: Mon, 28 Sep 2026 18:26:57 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: benh@debian.org, namhyung@kernel.org, linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org, rostedt@goodmis.org, tglozar@redhat.com
Subject: Re: [PATCH v2 1/2] perf tools: Put Python egg info in output
 directory
Message-ID: <arqVUeoV8Wxtdvgk@x2>
References: <ag8X7gcDw6jpJsLq@decadent.org.uk>
 <20260921175719.846883-1-irogers@google.com>
 <CAP-5=fWEvnp1S4N37U69Shc=S_C7Xn+NnSiTS8q4YxR5_EUsXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWEvnp1S4N37U69Shc=S_C7Xn+NnSiTS8q4YxR5_EUsXA@mail.gmail.com>

On Mon, Sep 28, 2026 at 09:12:32AM -0700, Ian Rogers wrote:
> On Mon, Sep 21, 2026 at 10:57 AM Ian Rogers <irogers@google.com> wrote:
> >
> > From: Ben Hutchings <benh@debian.org>
> >
> > Installing the Python extension currently creates an egg-info
> > directory in the source tree, preventing a fully out-of-tree build.
> >
> > Add the necessary runes to the setup.py comamnd line to relocate the
> > egg-info directory in an out-of-tree build.
> >
> > Signed-off-by: Ben Hutchings <benh@debian.org>
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > ---
> > v2: Rebase
> 
> Ben's build clean up that I've then rebased and addressed an issue
> with building in tools/perf seems like a nice to land thing. I'm not
> sure what more I can do to push this forward, and I replied on the
> list about the Sashiko feedback, which was a little wide of the mark.
> Let me know what you think; perhaps the tags are not done properly.

I guess they are, you carried it forward and then pushed upstream, so
merits your Signed-off-by, I think.

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
