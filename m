Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C74631750
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Dec 2023 19:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dT30pWNU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C18C433C8;
	Mon,  4 Dec 2023 19:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701718985;
	bh=APRVnppDxg+3ZX+/Grp1+0OoD5lB8M8Nkp19j9S2qhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dT30pWNUPNx5szzJXbiC4d7qZfM/NcpO25RRG5TEnDhCoN7+EPrEH6psXv7DT3bNA
	 aslTpuM7PXA9X+jFMXOxx0EUzHEiLa5s0AT4e6dYPddB7wpqXz6JkohwCo7mmaiKZh
	 ScQjk2IH32jeMTAFAEjp6g7xeLPDwy0XjZNvH9Uf5bBVXVUd4QjJmz8KsKtJBmMaIv
	 SLzWoV/uIHXuHPLmY8UZQ1gklh1paYFBKRxxxsEJsq2o+QavKK0URZezWNS3aClD7/
	 74u+N1WDjo2h8o1Th5BEQHx1qtqJUJ+GrXDwgJ4+utyhT6p7XrKbl84wxTLkVonqgn
	 RmUEezqmls9ug==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 8A2A440094; Mon,  4 Dec 2023 16:43:02 -0300 (-03)
Date: Mon, 4 Dec 2023 16:43:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 0/2] Cache the arch specific stderrno routine
Message-ID: <ZW4rxvSSfJigYRAd@kernel.org>
References: <20231201203046.486596-1-acme@kernel.org>
 <CAP-5=fWJMcJb0+Nmkd1=HoOc5j7LEzGkJmqyAgdpfekOJtjybg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWJMcJb0+Nmkd1=HoOc5j7LEzGkJmqyAgdpfekOJtjybg@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Mon, Dec 04, 2023 at 11:10:54AM -0800, Ian Rogers escreveu:
> On Fri, Dec 1, 2023 at 12:30 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Arnaldo Carvalho de Melo (2):
> >   perf env: Introduce perf_env__arch_strerrno()
> >   perf env: Cache the arch specific strerrno function in perf_env__arch_strerrno()
 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, stamped the patches with that,

- Arnaldo
