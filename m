Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF5C184524;
	Thu, 12 Mar 2026 01:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773278281; cv=none; b=WoDQmtItdu5tyQPM02w/9QSnj9pNFLUVAkWNRteG3YJu4o2taYwPxvpqzzE1alO8MO0youNtTUIdneElTN3Dxik8RlaU7euy/3sGZMSlluZUnZ2Del267LEfPbXxM01HAXLcmfGYlZCu3lvXuQKMmp6smDaaMf5CC4eocJV79FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773278281; c=relaxed/simple;
	bh=ZPkwsrJCcF4EP7sC2ZvRt1O2/NjGzArKjSz4TesUmqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIw0rvGFhs50F8zsbE5iBIRgUQ+3s81vZo1elF3duLfZxhOeT5X0zP0snGdwwQezrrCGfcqP/LBpaYvPPjO4ZesazUb5SCUQlyspkR/sNQfOU5jIbNTXXQjK6khx7o7UqjXiP2nbTPNlZoOBAtLeISCpq7PEGZ0jmEncQeRamDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRE3yNsV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRE3yNsV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18C3C4CEF7;
	Thu, 12 Mar 2026 01:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773278280;
	bh=ZPkwsrJCcF4EP7sC2ZvRt1O2/NjGzArKjSz4TesUmqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RRE3yNsVlLRtlOGnW54k8ORPlyXOg2JauuCYY6aYACa7gSVhM3peseqQ7nmAJdDlT
	 oxrfsEI58WnsqnbwX4Ckeu5UKonH3ApsR4CDcOud3/imMzYRVmhYH3kJTKjYRLPG4a
	 UogfFXN4Rrf+ibAcZviei4xaY0JzHn2Az3Z+hAeTOQ+iXl7KnYzRdvtkBXk2Orr8VX
	 QpJNY+2WDv/7Hus0KgnBQYepKbvW4JoEA8j8A3fOXSXvMqrMiAD1Z/SKKgPdcbXLz1
	 5yOUmU0kY3HI1wgW8zFkvIQwwe7PdkkCyGG38UTqRl6gcw/29RJJvfVV1mJou6eQ41
	 WhimTRugkjNaQ==
Date: Wed, 11 Mar 2026 18:17:58 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf disasm: Fix potential use-after-free on fileloc
Message-ID: <abIURgnW94VGFo8k@google.com>
References: <20260307002222.2463509-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260307002222.2463509-1-irogers@google.com>

On Fri, Mar 06, 2026 at 04:22:22PM -0800, Ian Rogers wrote:
> The fileloc is a copy of a pointer to a string but in places like
> symbol_disassemble__llvm this string appears to be freed setting up
> potential use-after-frees:
> 
> llvm.c:
> ```
> 		dl = disasm_line__new(args);
> 		if (dl == NULL)
> 			goto err;
> 
> 		annotation_line__add(&dl->al, &notes->src->source);
> 
> 		free(args->fileloc);
> ```
> disasm.c:
> ```
> static void annotation_line__init(struct annotation_line *al,
> 				  struct annotate_args *args,
> 				  int nr)
> {
> 	al->offset = args->offset;
> 	al->line = strdup(args->line);
> 	al->line_nr = args->line_nr;
> 	al->fileloc = args->fileloc;
> 	al->data_nr = nr;
> }
> 
> struct disasm_line *disasm_line__new(struct annotate_args *args)
> {
> 	struct disasm_line *dl = NULL;
> 	struct annotation *notes = symbol__annotation(args->ms->sym);
> 	int nr = notes->src->nr_events;
> 
> 	dl = zalloc(disasm_line_size(nr));
> 	if (!dl)
> 		return NULL;
> 
> 	annotation_line__init(&dl->al, args, nr);
> ```
> 
> Fix this by making the fileloc a copy of the underlying string in its
> init/exit.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

