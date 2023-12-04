Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C7233095;
	Mon,  4 Dec 2023 20:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cm/lro3C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0148C433C8;
	Mon,  4 Dec 2023 20:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701721616;
	bh=RUO62ldlZP9KwcJkqHitPPpiIOKUfgLfjbgl9wbMzt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cm/lro3C7SY1VPYFSZdmuAcF+uD8KD67JAkfVwzU7f4Nzl2k25dcxMRuiWRbH2rBN
	 Ega4ZyU57dzxqlZaUYriDX9Rme7xQRC8CWpKxI4deN+vMqugHFlNIW7g/9YIrmUyNu
	 do+s48CZDH6GrmPh2DDyFvgqLZdhuWs5eCVtqptUmFvNpl8wGzf/FuW36TXdiALFPh
	 lLD+p7Pr1TxfTQOvsyamZwelFypDacaoXRmLqtQmAB2VhqbjuHfgTPKkhD50GZVgGr
	 lV77uYhcDRJk0HxJ5k+wbXVUcH3fUGZaSXYKu5O8ZRxkEOLhKm65+UwJHId4qUgziB
	 HSLl6pFGgf3OQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 8FEA040094; Mon,  4 Dec 2023 17:26:54 -0300 (-03)
Date: Mon, 4 Dec 2023 17:26:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] perf/benchmark: Fix spelling mistake
 "synchronious" -> "synchronous"
Message-ID: <ZW42Du8dtF2b2zHJ@kernel.org>
References: <20230630080029.15614-1-colin.i.king@gmail.com>
 <CAP-5=fUX_ktsmrrVGr9kwa3-C_4=yobTFgm5L+TpFNt8UZMZGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUX_ktsmrrVGr9kwa3-C_4=yobTFgm5L+TpFNt8UZMZGg@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Fri, Jun 30, 2023 at 08:18:49AM -0700, Ian Rogers escreveu:
> On Fri, Jun 30, 2023 at 1:00 AM Colin Ian King <colin.i.king@gmail.com> wrote:
> >
> > There is a spelling mistake in an option description. Fix it.
> >
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next.

- Arnaldo

