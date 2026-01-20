Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10D234F474;
	Tue, 20 Jan 2026 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768935264; cv=none; b=bZfJgbY3o0f/EhOF7LKM5JlgMk/YIN9YWiygJn2ThZv/TLb7ow2MH1Y/ITbkY7+EPaGuS0CkQqxwdhasGsIWzKxfYpCJcJG3Upz2YSDsu6i/yhhj9/zphDhmqIdfk7kP1h0RHMCeG0zVLVuIDH8Ihk4ATxL7DUlv37qXTnQx048=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768935264; c=relaxed/simple;
	bh=7cVS/HfDiB+vrCWdHnPMA1cmeb11/jDWn7R2gJo5r80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZhHfyTqdXuw3g98tTHtB6yZ6O+31e0gmfE/EbceHgFNo24aLUU6YaDkN9kfHdi3aEd7hoChCIQqESvWXxJtKZsuS/bobJhPmuwzXJlNQsKSBmWM2BLjsPgdBbRKBikjjQzmhbnCHlfUfaJwWkW22IK141yJ1anqkcTN677yCU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lm1rWx3z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lm1rWx3z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D71C16AAE;
	Tue, 20 Jan 2026 18:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768935264;
	bh=7cVS/HfDiB+vrCWdHnPMA1cmeb11/jDWn7R2gJo5r80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lm1rWx3zJOfiikItzyqkvRHJaDfcOmxdaqjFLCO2tGihrtEDXInWE6omhLSXqVlTs
	 W2+DEC+3lR+HYDJS8fNhtVIc6uWK688DkDHAI79mDe+2/3jp/+yP4xYqHnIPPH4Sxn
	 yVpIzhZqBdINYYtfLkZct5uocBkrj+WmWFUf4F0+kFIniaZb5t929vZJQF9RbZHaXK
	 KfjDsUDsTe3DWliHa2fYgm9Nf3YwKVIRXEMc0WNnzlPaYMSlMSnOaH0gp7aGzKMnR7
	 7vYxDE4oI1UqosKKG9kv9F6GnptymFiyFaR0SofMPTJQXC0c1/eumUX/18hxltkVtQ
	 8mWCA65Wi6BvQ==
Date: Tue, 20 Jan 2026 15:54:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] perf jevents: Handle deleted JSONS in out of source
 builds
Message-ID: <aW_PXct-oIyOyrNe@x1>
References: <20260120-james-perf-json-delete-fix-v1-1-bae2194b1dcf@linaro.org>
 <CAP-5=fVxMcMt=red5+D9_m4+wrUdPGkNP0irNqr5PU1UPJSO6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVxMcMt=red5+D9_m4+wrUdPGkNP0irNqr5PU1UPJSO6A@mail.gmail.com>

On Tue, Jan 20, 2026 at 10:01:52AM -0800, Ian Rogers wrote:
> On Tue, Jan 20, 2026 at 7:39 AM James Clark <james.clark@linaro.org> wrote:
> >
> > The cp command here doesn't remove files that have been removed from the
> > sourcetree. That means incremental builds can either succeed with stale
> > events or will fail completely if a stale json file has a broken
> > reference in it.
> >
> > Fix it by using rsync instead of cp. legacy-cache.json has to be
> > excluded as this is a generated file isn't present in the source tree.
> >
> > This only happens when deleting a JSON file, which has only happened
> > once since the linked commit. The fixes commit is marked as the origin
> > of the problem in case any future changes that delete JSONs are back
> > ported, rather than the first commit that deleted a JSON file.
> >
> > Reported-by: Mark Brown <broonie@kernel.org>
> > Closes: https://lore.kernel.org/linux-next/aW5XSAo88_LBPSYI@sirena.org.uk/
> > Fixes: 4bb55de4ff03 ("perf jevents: Support copying the source json files to OUTPUT")
> > Signed-off-by: James Clark <james.clark@linaro.org>
> > ---
> > This is a bit of a hack and I thought that making jevents.py handle
> > multiple input folders would be a much better solution than this. Then
> > we could have "gen-pmu-events" for only generated files and "pmu-events"
> > for only in-tree input files. It would be very clear what's generated
> > and what's not and all copying rules and special clean rules just
> > disappear (and this isn't the first time these rules have caused build
> > issues).
> >
> > Unfortunately, after a while of trying to modify the script I thought it
> > was too invasive for now. The script does output per-file at the very
> > bottom of the logic in process_one_file(), so adding files in another
> > folder ends up re-emitting section headers when another chunk is output.
> > Although other parts of the script do build things up in memory before
> > outputting so it was possible to make those parts work with multiple
> > folders transparently.
> 
> Thanks James!
> Acked-by: Ian Rogers <irogers@google.com>
> I see other rsync uses in:
> tools/testing/selftests/sparc64/Makefile
> tools/testing/selftests/bpf/Makefile
> but they aren't the most compelling mainstream uses. I wonder whether
> we can test for rsync's availability and if not fall back on cp?

It is not mentioned at all in Documentation, so probably its best not to
add a requirement for it?

- Arnaldo
