Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C273322B94;
	Tue, 13 Jan 2026 21:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768339494; cv=none; b=SVvkv0nQiI2OrpSo/8SpUPuHRfytKUibS3Pd6vWPolfa/U59fDXWepnccbD6qdHtmQvOokk3qls1ftqJoyN5PhlobLRc19kZ+qkEhT8Q74BrV0261bLiFYEcJhVutD7U+UMe4K/G/Nid9gOPBkHFQHtLfPeotaj9AVLVukNVQrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768339494; c=relaxed/simple;
	bh=sK0STND+G8BGh76Fn89EbNalb2V8RcOBh60TO9oP4Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTgOykRdK3fgbWEXUyEcZRi3I0CE43vOlFoPfvg1vpQeU4NAtQIE9x2P3p0avOn6Hpz5KYQAGO3g6hfurZLBuJmR3EH2lyXXD7xhyUqqZS3Iec1yyB8oAGnyObjUjROtnLx/2dKA5eXDB5DUg0th2tnI/o+EW6u3Succv6g6N2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMvUyYlt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMvUyYlt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8525C116C6;
	Tue, 13 Jan 2026 21:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768339494;
	bh=sK0STND+G8BGh76Fn89EbNalb2V8RcOBh60TO9oP4Nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PMvUyYltdzOXwI4fSapT0jy3z1XsAuvNdC/dodSFWBzunH63AWDBLWOCKLhMXbeMr
	 uFGeo9H13eZ25oxhMOppMBB8oYZgt5vCY0mpVfWFc30vn8ACUPMXekJYAypJ1b/ejz
	 TJyYI6jZo/kDNfT7P0e21pcACNn7/VT6YDUIQdi1RvXZow3sYktydtQlaOVIhxh7NN
	 zymaWNwFv6sYxHNcwZkO2k8eYz/KMiEtm4rLHnwooyFXqOa91CHv1NMvwSaQ51hcdw
	 QKwTHA8u0SIe1yI9vdfTW3dLH4Kj4rDB3Wy/MvtX/cwwbifevcmxN3o2SYeuLtsaMO
	 ha/dGjRfRKAtA==
Date: Tue, 13 Jan 2026 18:24:51 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf inject: Add --convert-callchain option
Message-ID: <aWa4IzM1QIxH5Z57@x1>
References: <20260110011715.1642869-1-namhyung@kernel.org>
 <aWafN6WpmaBJsIGP@x1>
 <aWa12lGzx5ulhvIs@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWa12lGzx5ulhvIs@google.com>

On Tue, Jan 13, 2026 at 01:15:06PM -0800, Namhyung Kim wrote:
> On Tue, Jan 13, 2026 at 04:38:31PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Fri, Jan 09, 2026 at 05:17:14PM -0800, Namhyung Kim wrote:
> > > There are applications not built with frame pointers, so DWARF is needed
> > > to get the stack traces.  So `perf record --call-graph dwarf` saves the
> > > stack and register data for each sample to get the stacktrace offline.
> > > But sometimes those data may have sensitive information and we don't
> > > want to keep them in the file.
 
> > > This perf inject --convert-callchain option parses the callchains and
> > > discard the stack and register after that.  This will save storage space
> > > and processing time for the new data file.  Of course, users should
> > > remove the original data file. :)

> > This made me think for a while to finally realize this is not a general
> > purpose "convert callchain" option, but one that converts to ip-based
> > callchains specificaly, useful and probably can stay with this name, or
> > maybe we could use --resolve-callchains as we use
> > thread__resolve_callchain() for that anyway?
 
> IIUC resolving callchain is to get DSO/map and symbol from raw data.
> But I admit the name is general but have no other idea. :)

Naming is difficult, I think we can keep as --convert-callchain, if we
ever want to do other kind of conversion than from DWARF to IP we can
just pass arguments to this option, with it without options, as is now,
meaning the most common convertion, the one being done in your patch.

I'll apply the patch as is, thanks.

- Arnaldo
