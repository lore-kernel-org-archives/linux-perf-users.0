Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AA114A630;
	Sun, 26 Jan 2025 20:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737924232; cv=none; b=ZH1juIgCbB42/p2TbjPYcT82tz4ZkNcMySDHZ9hwBDZRZj1o+VXc/NhKZkStZGZj29+4ADWRptAVZyyz4vZ/EiksmTQE8upScLIQLStZLM3tzDi4T5g4ScB1DtnEX7GN6pM1OA7SwFywrzArPs67Vj6hwIIsECGfW3xWD2/M9kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737924232; c=relaxed/simple;
	bh=WAim0j695cQbkHdBbE74RIvL4CgLtldJ/wJDvGtd5IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgKFGp0BzpbgdcU7Qu4lsrM/G238pB/ka7QJ/PIx07klJxs0PUQgeGPgkQ1csn1uECWVWgGaFzkREbI0ti6vD3IRYLAcWn4tw+iCV2t6/M708h79TvJ3xrrq815AzsIZlGiNjQsvownfbZm3Voe1YaQx81WBamfUrLTsteTUybk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2azc8tR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2azc8tR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41770C4CED3;
	Sun, 26 Jan 2025 20:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737924231;
	bh=WAim0j695cQbkHdBbE74RIvL4CgLtldJ/wJDvGtd5IE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S2azc8tR2WMj7dxTEIbF1kxhsU6ZA4E+lP9PF5uoWQkff/UZjwntD816QswFwbeC6
	 EsChIR3SskqLaOZZcfxGaqFIDw7eSD60I4Fea4xx6x4XdH2c3vhKRiYszEwSCN4mGk
	 Xz65MFM7kcLwXiDTolMxW/eOF+E/vi0pcjLH1C1WfGitSYD/5Z881x4YemZOu2mt8T
	 2DqZFpxgzKt5M3SJc0143w4iRCRBxePVZ4Thq8GjiVuE/D4fcK8L49ds6a+HG2zK8/
	 ZBxjNFbKqelocySL7VSBoniZbbFIT0i5FqQFJVp4ooHXFywjWLbnjbpeYdTJjy7LIe
	 3s5mKoG/kIlyg==
Date: Sun, 26 Jan 2025 12:43:49 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 1/6] tools/build: Don't pass test log files to linker
Message-ID: <Z5aehY8evAFKqeiK@google.com>
References: <20241025172303.77538-1-irogers@google.com>
 <20241025172303.77538-2-irogers@google.com>
 <Z5Qi5olV2yy2-TJ8@google.com>
 <CAP-5=fXP8ZbVKBr6wetdP0AJZrz-MmtyigHOjZanA-wNUcTfRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXP8ZbVKBr6wetdP0AJZrz-MmtyigHOjZanA-wNUcTfRw@mail.gmail.com>

On Fri, Jan 24, 2025 at 05:58:37PM -0800, Ian Rogers wrote:
> On Fri, Jan 24, 2025 at 3:31 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Fri, Oct 25, 2024 at 10:22:58AM -0700, Ian Rogers wrote:
> > > Separate test log files from object files. Depend on test log output
> > > but don't pass to the linker.
> >
> > I don't know why $(obj-y) contains log files in the first place.  It's
> > supposed to have .o files only, right?
> 
> There's context here:
> https://lore.kernel.org/all/20231129213428.2227448-1-irogers@google.com/
> $(obj-y) is the set of the dependencies from Build files, generally
> directories or .o files. Perf added the test logs as the alternative
> is to duplicate all the directory scanning and other logic for a
> $(test-y) but it isn't clear how you'd even name targets for a test in
> the Build files. Rather than reinvent Makefile.build the choice was
> made to work with what we had.

Thanks for the explanation.  I'm ok with it for now but I'll take a look
if there's a better way later.

Thanks,
Namhyung

