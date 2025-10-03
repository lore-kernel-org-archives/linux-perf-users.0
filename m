Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53C33BB44;
	Fri,  3 Oct 2025 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759518641; cv=none; b=h9qsUARstMDtYu3EEy9HdP+NV49YhYlRldX5J9a/2a/iQFDlIVUfS+7fp9dSJ4t1K2jFX/+6Ypot3Aj5jVYHcO9XARQTHAgmnYY5tDlSMtvkeen8VFyo5o1dd+kuX7XGT9esQQ6g3LfTZ+2A+HfdaZ3cA/m0IFa5Oe/HeFAixQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759518641; c=relaxed/simple;
	bh=4gE/gOnjkDdtU7c16Hm6ajGIcMaPA26vNzDxGlkbPf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMzKAKQmJe53wLtS3kqultBwVnf1K/ICFPp/cHvoAUkQLpc1cEfiC+xqDaeKaA9bVluhqCWh4aMTyE5Pqzw56wEv//jkxnkYDBvQEv2qyvmxqpeyfu1Gcytiig438Kj1CunwUdyZ8S4LlASRdlIcky8EQMoZMi4BmbMdPljD9Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Km1M5lPZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Km1M5lPZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B8CC4CEF5;
	Fri,  3 Oct 2025 19:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759518641;
	bh=4gE/gOnjkDdtU7c16Hm6ajGIcMaPA26vNzDxGlkbPf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Km1M5lPZyNcgu+R3mXCeCMUHUxlDFUu81CxyLye7heBwUGt89sRbP2cXNpdRNN0o4
	 FvzKoQuil93ghDLE6/p79XszI1C6sKn6/qupa8v3XqqX8Oj/ZHuZq6dkDLMJ9RE7EW
	 wb9+X6/7FLX29cV+mIPesCGf662dz8h9nGvWfr8K2JLYbP+17k6d8l8R8GVmHI/FIZ
	 hd9IVRmb5xbmU0oxLmQ9bcQzdjJKgDJT6w2u+y3A5SDLrkf2JSzQV+0cA99PbPWeup
	 rwwC+XhHtoqCys4zkpPb2uoIR6kzyK+7kLUKTRGRQCPwj7/Gg+zcl8QitdqRndiGIt
	 Y8rT23eaKBrOg==
Date: Fri, 3 Oct 2025 16:10:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Zecheng Li <zecheng@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/10] perf annotate: Rename TSR_KIND_POINTER to
 TSR_KIND_PERCPU_POINTER
Message-ID: <aOAfrhzmKlX-NZBN@x1>
References: <20250917195808.2514277-1-zecheng@google.com>
 <20250917195808.2514277-3-zecheng@google.com>
 <aN9hByQIxqdefC8k@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aN9hByQIxqdefC8k@google.com>

On Fri, Oct 03, 2025 at 02:37:11PM +0900, Namhyung Kim wrote:
> On Wed, Sep 17, 2025 at 07:58:00PM +0000, Zecheng Li wrote:
> > TSR_KIND_POINTER only represents percpu pointers currently. Rename it to
> > TSR_KIND_PERCPU_POINTER so we can use the TSR_KIND_POINTER to represent
> > pointer to a type.
> > 
> > Signed-off-by: Zecheng Li <zecheng@google.com>
> 
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Cherry picked this one.

Thanks,

- Arnaldo
