Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF71B8F49;
	Wed, 19 Feb 2025 20:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998186; cv=none; b=sJa4v9XbXgSclRNGZ0CtRxquTDI4nd7vBaSj0G4mL3qrAfxTCVzE3JQ5xypBFVdczXtTdpq1CFKRrNgEbc8+Iq5oENDBpcMdEHECReftGo76bI7ups8WtAUMshHBS/x+irmEHWCGsWvEIACMt5+HEWmJMkUoXXhVaQ1pby/4bXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998186; c=relaxed/simple;
	bh=s03rz4axHKo31FDUMPilzZ69yl0nJqBHhKpgGNSRcUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAO2IgTS348VNBN/7qCDRdTEciF5xLDWtM0EedTaYngi4vR/mK0nheUP1fh82TJxG2ZIPE2LHxRQQfFgZfD14RTI0KEqPIHtq60Pd3dpI1JtQRb3IciWu5tusk/RS2/7pDmjsSSaB8i5wdfd+UBg3722sZaJH3eP1BaLrewylD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRnSPk1J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRnSPk1J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CA3C4CED1;
	Wed, 19 Feb 2025 20:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739998185;
	bh=s03rz4axHKo31FDUMPilzZ69yl0nJqBHhKpgGNSRcUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RRnSPk1JTB1a3lwbp7n18QYjnuDJeirTNXlbWXNFx1toinRxRZp9Lph6PQ0MnketA
	 VV63wu2RM7/yjPhpoNnU7R4cqJ3BaUQOXeh5z2d2AJunVHwQ09STFdylmvB/guVGb2
	 wjKs9x31Tn56vq8OV3+eGtt2BA0850sloIgqSqWQvz7GEPCGi/XjS+7ZUixbChIUDj
	 8f2bJQ6aZxIH1b+g+TX8l+cRpbPVZm2CzBirQ/NUlPWDnrotvnYdu4dH/KhFkKUjgL
	 KqvM+zmnK9MLxP7wK/bS8NXB2GqPRh3gPfj3DdloYhUP/5vFoBSwiTD4q4wJMcUuvR
	 a5J9LJyYitJ5A==
Date: Wed, 19 Feb 2025 12:49:42 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf parse-events: Tidy name token matching
Message-ID: <Z7ZD5phOOCbKggrn@google.com>
References: <20250109175401.161340-1-irogers@google.com>
 <CAP-5=fWghT8+pBFVxn9JDbqHU9NPy9mgyT8Ee=pTdkCKxRoJgA@mail.gmail.com>
 <CAP-5=fWZAk7XqtL+=CanefkuFxhDsJ22+-uHkrxXi4g8123oew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWZAk7XqtL+=CanefkuFxhDsJ22+-uHkrxXi4g8123oew@mail.gmail.com>

Hi Ian,

On Wed, Feb 19, 2025 at 11:02:40AM -0800, Ian Rogers wrote:
> On Mon, Feb 10, 2025 at 11:23 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Thu, Jan 9, 2025 at 9:54 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > Prior to commit 70c90e4a6b2f ("perf parse-events: Avoid scanning PMUs
> > > before parsing") names (generally event names) excluded hyphen (minus)
> > > symbols as the formation of legacy names with hyphens was handled in
> > > the yacc code. That commit allowed hyphens supposedly making
> > > name_minus unnecessary. However, changing name_minus to name has
> > > issues in the term config tokens as then name ends up having priority
> > > over numbers and name allows matching numbers since commit
> > > 5ceb57990bf4 ("perf parse: Allow tracepoint names to start with digits
> > > "). It is also permissable for a name to match with a colon (':') in
> > > it when its in a config term list. To address this rename name_minus
> > > to term_name, make the pattern match name's except for the colon, add
> > > number matching into the config term region with a higher priority
> > > than name matching. This addresses an inconsistency and allows greater
> > > matching for names inside of term lists, for example, they may start
> > > with a number.
> > >
> > > Rename name_tag to quoted_name and update comments and helper
> > > functions to avoid str detecting quoted strings which was already done
> > > by the lexer.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > Ping. This patch addresses name parsing inconsistencies, in particular
> > events may start with a number without a PMU, but not with. It also
> > aims to give better names to patterns than name_minus and name_tag
> > (with term_name and quoted_name respectively) that have drifted from
> > their original meaning and become to me less than intention revealing.
> 
> Ping.

Sorry for the delay.  Can you please give an example for better
understanding if there's a change in the behavior?

Thanks,
Namhyung

