Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795632082;
	b=K2kXL6PgvJiRSKoEqGvs1kfQnwa3EQw7bxDvUXMT+FcbC9KLjug8FAJkCFLqpMj7ms9P
	 bJKRXScjxhRLJQQm3VDjNY2U2f7+ttKHUnBnfaknCNrpf+iQJZdxgtEcC66hBXHrxBbYr
	 cPLldYS0s4skFTYWNLmEgwZAMZc9rdhuakVNALoMjbKFbCTuBRTazUW0ihBtSe9HOzW0M
	 n3yvJCoF+u4itHWuw+BHw5+iJxQp4JWt++OzdIcCp8zW+P5ggWRI8bnepCyGyC2afrUyU
	 iwhjRHzmadrepcWvqozfbxoy2A6IlIAXlZxOjnqpA3BUOUOFDQbszFXZ0bBT5eIfBlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795632082;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZJ02y3Z30VnfaB4wxrfHVkrt7dhk7m57ns1frXinnz4=;
	b=CYwe7MYhsfdA3xnR+jHAv+SHET3LJJB29NjBwNpn/jf67PfX3/nsNAm807YOTXSj8/We
	 J3nA5nD1sewtJq/KMwAxfS2Oa40bJWMH+e5U8dB/4vxtg1LDIEYRo/9q7KeIm7I8WRk56
	 I7fIOuNzFHbwCUAmVefWvl6zdCfLyA3z2cGH+8euJb+uPUOsCnpIka7+yUypjofpg3uCE
	 JgyF3Gps4QxWL3r0B6seofqEGkU8GRmtJr8fW53jzHmy0e0pZeFPHkEtdXzlJx48BHCDK
	 mdSk5+qH4L4YmtO1AoSrCgOHNAeqZmeFrSqTaea+5xOSzSbELoIH+aRF64lXpzoTmxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GK0HFFKE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABE5606A321;
	Wed, 25 Nov 2026 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GK0HFFKE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750FB1F000C6;
	Wed, 25 Nov 2026 18:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795632082;
	bh=ZJ02y3Z30VnfaB4wxrfHVkrt7dhk7m57ns1frXinnz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GK0HFFKE1HKitFjM8n3SlHQu6XByZ3pKm0R8a2UoEdaIlbDvu/si15UWYE7dgGDWs
	 sGaViuj6jlRuBGKZ2Kj8k9ao2WGzeM21S/S/QwWYCDW4VTJixdWk6EHBGbkz/w6mtC
	 vWP0RAUsaZM7pgBCAq8B1JYOxMQhIR14Gm3JMKttlCsXcJGTZvFnz4OL2lVEULNwPo
	 dKbcBUWZlXSxz0i41czZCsGhusaqNoslt63Z6hvgR5jg7D5I6PZ63xh2GGN/gfBv5U
	 7LcgWDhavlM1M1YhpQmvWXJLNgP1wH9P0wNkP9eAPWSOjxWepoSBCyuIWbhJPegO1V
	 GTwrw5PtK7q2g==
Date: Wed, 25 Nov 2026 15:41:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v12 03/19] perf annotate: Print the stats after the
 annotations
Message-ID: <awcrz9GZgf78UYLA@phoenix2>
References: <20261123220024.14891-1-acme@kernel.org>
 <20261123220024.14891-4-acme@kernel.org>
 <awYNhyPWLG0g_nDn@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awYNhyPWLG0g_nDn@google.com>

On Tue, Nov 24, 2026 at 02:19:51PM -0800, Namhyung Kim wrote:
> On Mon, Nov 23, 2026 at 07:00:08PM -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > With --code-with-type the instruction stats are printed from
> > hists__find_annotations() before that event is annotated: the first
> > event reports zeros and later events can report stale counts.  The data
> > type total is only counted in --data-type mode, so --type-stat without
> > it is incomplete too.
> 
> I prefer having type/insn stat before the result so that I can check the
> quality easily.  But probably it makes sense to do it later when it's
> used with --code-with-type.

Done:

commit a33b6175c93c126c92bd1b98bd0760b39d79c234
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Thu Oct 29 11:20:31 2026 -0300

    perf annotate: Print the stats where the counters are final
    
    The stats are printed from hists__find_annotations(), before that event
    is annotated: with --code-with-type the first event reports zeros,
    because those types are resolved while printing, and a later event can
    report a total that is not its own.  The data type total is only
    counted in --data-type mode, so --type-stat without it is incomplete
    too.
    
    The data type pass resolves the samples while the histograms are being
    resorted, so in stdio without --code-with-type the counters are final
    before any annotation is printed.  Print the stats once there, before
    the annotations, so that the quality can be checked without scrolling,
    and once after them when --code-with-type or a browser is used, where
    the counters only reach their final values during the output.  Leave
    the TUI's alternate screen before printing, so the stats remain on the
    terminal.  Warn if --type-stat is used without --data-type.
    
    Fixes: 58824fa0087e1cb7 ("perf annotate: Add --insn-stat option for debugging")
    Fixes: 61a9741e9f78c64c ("perf annotate: Add --type-stat option for debugging")
    Cc: Namhyung Kim <namhyung@kernel.org>
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Still doing local LLM and container fleet builds to make sure everything
builds and tests in multiple arches before posting.

- Arnaldo
