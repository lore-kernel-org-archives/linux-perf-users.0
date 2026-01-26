Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B350122259F;
	Mon, 26 Jan 2026 20:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769460344; cv=none; b=pYGBhgvvGVLhHWcHV3H/PQ8/6dsosUe7zsT3IdCCbTfiypk9kR2FdGGRUQRqUycP+yrkFBC2Ci+aydRD4cufG8pf9MupaC6em0osQyBpkqILbol99VcomYfgRKJF4X0+1TX33GA16wPGW2OV8cAdIVwnk1r5sEWaQBZyYObpT3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769460344; c=relaxed/simple;
	bh=wkTncGkdtqHPlWvte+kMN4z8neQO1MbfhWmkEmCVjH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKTZVPNrGACMq12L0O+oeqWzU6xZF0Cq01ftMA+v46Y2pyT0QzM3ZRoo10rTwoLDpOgOsWqwfiomXD4papSnx4SQbjFy6n2Z9uRK8B85uRR3xu7ED9PkHK2ZueHFCTGjuUjbZefKPMBkuy+LtMSxEBGcf0BrMDFyBUJpzVETb+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrJWcaWi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrJWcaWi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46DDC116C6;
	Mon, 26 Jan 2026 20:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769460344;
	bh=wkTncGkdtqHPlWvte+kMN4z8neQO1MbfhWmkEmCVjH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mrJWcaWirEk6+FvSZNNe9h7nxLedK+1vnjCsb9c7oVOZHJS4J4yLnd0MhyTWiaA+c
	 rWLF8k+Id5KGvHqlWPRIv4MdT9FkfEJDNmCPeAuSbFSQxWQqvz6LU7OXSGTvYOOuZB
	 /ewPvpIafCIvlQ60RyZueTZeWJStgUyMbPqTLHZ3NKvMkwhB8Ohm/lkNSC+W2cwBWO
	 GHIJF8X3YLoKYBz7HyLwCNKXiHer0KXB1KQXcSoIqfGO1u8DiJX7R3rFuu9NRqJneo
	 /ljXMgtZ3hPYx6V/+kPyjNp/o+NmqRLjWZpiIfdNgV4sJCg88VrcNIN+tl+OYFL7+n
	 4GOJFtS1Dd/bQ==
Date: Mon, 26 Jan 2026 17:45:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] perf jevents: Handle deleted JSONS in out of source
 builds
Message-ID: <aXfSdRS0qG_T7tO5@x1>
References: <20260120-james-perf-json-delete-fix-v1-1-bae2194b1dcf@linaro.org>
 <CAP-5=fVxMcMt=red5+D9_m4+wrUdPGkNP0irNqr5PU1UPJSO6A@mail.gmail.com>
 <aW_PXct-oIyOyrNe@x1>
 <185f91de-f0cc-4a84-9e41-56370df718fd@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <185f91de-f0cc-4a84-9e41-56370df718fd@linaro.org>

On Wed, Jan 21, 2026 at 09:51:30AM +0000, James Clark wrote:
> On 1/20/26 6:54 PM, Arnaldo Carvalho de Melo wrote:
> > On Tue, Jan 20, 2026 at 10:01:52AM -0800, Ian Rogers wrote:
> > > On Tue, Jan 20, 2026 at 7:39 AM James Clark <james.clark@linaro.org> wrote:
> > > > The cp command here doesn't remove files that have been removed from the
> > > > sourcetree. That means incremental builds can either succeed with stale
> > > > events or will fail completely if a stale json file has a broken
> > > > reference in it.

> > > > Fix it by using rsync instead of cp. legacy-cache.json has to be
> > > > excluded as this is a generated file isn't present in the source tree.

> > > > This only happens when deleting a JSON file, which has only happened
> > > > once since the linked commit. The fixes commit is marked as the origin
> > > > of the problem in case any future changes that delete JSONs are back
> > > > ported, rather than the first commit that deleted a JSON file.

> > > > Reported-by: Mark Brown <broonie@kernel.org>
> > > > Closes: https://lore.kernel.org/linux-next/aW5XSAo88_LBPSYI@sirena.org.uk/
> > > > Fixes: 4bb55de4ff03 ("perf jevents: Support copying the source json files to OUTPUT")
> > > > Signed-off-by: James Clark <james.clark@linaro.org>
> > > > ---
> > > > This is a bit of a hack and I thought that making jevents.py handle
> > > > multiple input folders would be a much better solution than this. Then
> > > > we could have "gen-pmu-events" for only generated files and "pmu-events"
> > > > for only in-tree input files. It would be very clear what's generated
> > > > and what's not and all copying rules and special clean rules just
> > > > disappear (and this isn't the first time these rules have caused build
> > > > issues).
> > > > 
> > > > Unfortunately, after a while of trying to modify the script I thought it
> > > > was too invasive for now. The script does output per-file at the very
> > > > bottom of the logic in process_one_file(), so adding files in another
> > > > folder ends up re-emitting section headers when another chunk is output.
> > > > Although other parts of the script do build things up in memory before
> > > > outputting so it was possible to make those parts work with multiple
> > > > folders transparently.
> > > 
> > > Thanks James!
> > > Acked-by: Ian Rogers <irogers@google.com>
> > > I see other rsync uses in:
> > > tools/testing/selftests/sparc64/Makefile
> > > tools/testing/selftests/bpf/Makefile
> > > but they aren't the most compelling mainstream uses. I wonder whether
> > > we can test for rsync's availability and if not fall back on cp?
 
> That will work if we completely wipe the destination directory every time.
> But it would be an untested path, because in reality everyone is going to
> have rsync. It might be better to re-implement rsync and then at least the
> same thing runs everywhere.
 
> > It is not mentioned at all in Documentation, so probably its best not to
> > add a requirement for it?
 
> I can hack together something that does the delete in a few lines of bash or
> make then? I did consider that originally but I thought that's what rsync
> does so I'll just use it.

Did this progress?

- Arnaldo
