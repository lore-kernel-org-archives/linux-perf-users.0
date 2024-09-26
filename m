Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F4517BEB8;
	Thu, 26 Sep 2024 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727379599; cv=none; b=EDbYufsmVSLfhNlmPcDpXvwn2Tnk1z6V4X+SPdQEPKaqqaS+bUc/ayzRlj72tII9O2cTO7ty9r9imlJo5bXtNCD/Tml5KQsOvvvuBSzQRdP0F5fDeKyRVuczrRHWUN2nyEBIyZHA7HN1cxgzARW8TVsLznG79U4pmEUqAL299U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727379599; c=relaxed/simple;
	bh=54DM0uD8l3Df/Hh+XemJcRaOIqs/Q50HJKM4eD2PMk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSbqc0acXiZB/OQwdMYtgsWpbStwNomh88KMNpfRgq6z9AHqZ3oF3Ij59xzPzW5c+a4GoZPAJKZWfmR+59Cul1lXDO6OXkIafjW6r8gju/XvXiBA7CCw7KdODEuD9lazxX7k8ViDnrdGJUWgOR1BCaQ9iP5rptFtD96tVb3zk00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3A4OSPO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3A4OSPO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D153C4CEC6;
	Thu, 26 Sep 2024 19:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727379599;
	bh=54DM0uD8l3Df/Hh+XemJcRaOIqs/Q50HJKM4eD2PMk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g3A4OSPOKeMeF+859PedMzL7zRVGuXUThPHqt2+WTSpmVYwE9a1A4s93cKRAGK2WI
	 DbHoNo5cRcZRduuH02I6xZPQxAUKd/19xxrsyUVscFTI6WPqV60YjSGBLPjgMEiiqi
	 qSjNHYq4UhQ9j6czR4I8YwpM8bW4XYI3WEse5L3nHdAkxy/UqU7HnltFTT7C1ip5VW
	 mY0ulboLcY9Zm8Pxz3v2S7im9XN8foOPQLcHy7cuicI7ie4cSGTxr6jt7pLCbTeICF
	 qPa6CmBvE0JWc4zYVmGLUKSM3/jpN9rPyMN2fIJeeMZo1vmAHyei2YWt3RL1N+qX2N
	 UMr6kSTebJk5w==
Date: Thu, 26 Sep 2024 12:39:53 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>,
	Guilherme Amadio <amadio@gentoo.org>,
	Changbin Du <changbin.du@huawei.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>,
	Kajol Jain <kjain@linux.ibm.com>, Anup Patel <anup@brainfault.org>,
	Shenlin Liang <liangshenlin@eswincomputing.com>,
	Atish Patra <atishp@rivosinc.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Chen Pei <cp0613@linux.alibaba.com>,
	Dima Kogan <dima@secretsauce.net>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Yang Jihong <yangjihong@bytedance.com>
Subject: Re: [PATCH v1 11/11] perf build: Rename PERF_HAVE_DWARF_REGS to
 PERF_HAVE_LIBDW_REGS
Message-ID: <ZvW4iZpTinJKWIFD@google.com>
References: <20240924160418.1391100-1-irogers@google.com>
 <20240924160418.1391100-12-irogers@google.com>
 <ZvTUo_nbr_gKaJrs@google.com>
 <CAP-5=fVQVEgSK55Y_38KXyp3CJ1ssPOcqkA2JKwMDVYJe8iztA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVQVEgSK55Y_38KXyp3CJ1ssPOcqkA2JKwMDVYJe8iztA@mail.gmail.com>

On Thu, Sep 26, 2024 at 05:47:16AM -0700, Ian Rogers wrote:
> On Wed, Sep 25, 2024 at 8:27 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Tue, Sep 24, 2024 at 09:04:18AM -0700, Ian Rogers wrote:
> > > The name dwarf can imply libunwind support, whereas
> > > PERF_HAVE_DWARF_REGS is only enabled with libdw support. Rename to
> > > make it clearer there is a libdw connection.
> >
> > While it only covers libdw, I think the idea of this macro is whether
> > the arch has register mappings defined in DWARF standard.  So I think
> > it's better to keep the name for this case.
> 
> How can the dwarf standard exist for an arch but not define registers?

I meant it's about the arch code in the perf tools to have the mapping,
not the DWARF standard itself.

Thanks,
Namhyung

