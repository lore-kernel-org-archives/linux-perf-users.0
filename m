Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80B313C3F2;
	Thu, 26 Sep 2024 03:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727321254; cv=none; b=PWOcFkcGyKaRWl231kZcO0Mugq5yhCzTSAJRHauNUwqQ+IWbNPMLEMR91rH0dXC6A6UrKSxAMatU3H1zkQBmvqHuXIouuV7NoH2XK+1sijDgWAktUnTTqxo6UTUe6QQHpsDPPUSDn6ukoiZojDacpDFvDeSse8Nukaj1/65Ksas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727321254; c=relaxed/simple;
	bh=oYaNX/FBJAEEOOqWGjXdBRhzbszI/dMHUcFatabIzL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtW2O1TUxQSqwhBTobD2zTOGaAzulSqEFuzw2k904CT8Z78z0cJmNy78YDWyr08GJFrwFoeNFq39xb7arOo9eOPJkn5JskLmMvth7ficmc8BwqXSd6EWopimhKcg1ABQxvOmQ1eW7bjhSTwRYcX0TQ0l2Z+Rj5eoVHCGPjpqBnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S35oOoZS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S35oOoZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BF3C4CEC5;
	Thu, 26 Sep 2024 03:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727321254;
	bh=oYaNX/FBJAEEOOqWGjXdBRhzbszI/dMHUcFatabIzL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S35oOoZSbcGM00IPKEn3yA3vb1QIHabWUboV0Pw3vrkR/mSATrlNGx3SDMV/oZGFs
	 OjltpK4RqzYw317RFe3oSOG/3MIrKXuKB93R1I9QCglylP8e1go7qhC0dcfM7WNDUR
	 deiXu4wJi4moBX/pDAFUozK4GuQi2aO6zM4kbu7XSgyuMezPUvW2oyxnOkRUWMFhJA
	 vCHOZsHzzZA0JTcAn1uBrdbrvV0EplhWJ08d2SrQtC19oKeNXJaZtyZfwB9bMEWoqY
	 xa1YCuQBcan7sY6wXgrRhdcwi3pdNmh/79/TfMcUk3Mc9sSq9zfyvyBtUZdwX0rZ1c
	 EUy4JIO5GOtPw==
Date: Wed, 25 Sep 2024 20:27:31 -0700
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
Message-ID: <ZvTUo_nbr_gKaJrs@google.com>
References: <20240924160418.1391100-1-irogers@google.com>
 <20240924160418.1391100-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924160418.1391100-12-irogers@google.com>

On Tue, Sep 24, 2024 at 09:04:18AM -0700, Ian Rogers wrote:
> The name dwarf can imply libunwind support, whereas
> PERF_HAVE_DWARF_REGS is only enabled with libdw support. Rename to
> make it clearer there is a libdw connection.

While it only covers libdw, I think the idea of this macro is whether
the arch has register mappings defined in DWARF standard.  So I think
it's better to keep the name for this case.

Thanks,
Namhyung
