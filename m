Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE0341A84;
	Fri, 20 Sep 2024 17:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726851853; cv=none; b=KBBgU70H71mgycJXXY1lPvy2m1hfVeAJCgwUJUDyecD6Ecag9HGmhQzb2iuMcIAZVkewD65PWEVoG4ndN995quGv7ZeuNCbPfUKusjglhQCjDLtoID7GEGe6Q/T55Mkor+gl/wds1OsPtvXeG+jiu+iiQAcqzYfxASnqQ0HhOIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726851853; c=relaxed/simple;
	bh=qeVkc+0i9qhmNcvr3RlYChsmn+IbD0wG5NG+qixhCDE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cGo3pFzcvfXeTjBS4ai1HulcW5PjojX6rCNJtC8AZa7X6Kj7NVbKxczVWv3JaRVEwb324HoLBLlftBA02ZM/xvJxyg3riVWn/STzsHFGNrK5akTlMeoEZrgKAkIRX4NnE8pNfZsAHUNQGyRa1bkuAOceqJfHhwz6dOczspIjVgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=BNRTI66A; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="BNRTI66A"
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
	by mail.ispras.ru (Postfix) with ESMTPS id 7D08340F1DC4;
	Fri, 20 Sep 2024 17:04:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 7D08340F1DC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1726851840;
	bh=rCFLEdkLioLotNqJ2qXe4wnVu+Hcij9Rndm8NmPmqhs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=BNRTI66ACpIpBMW8zfkJf2pHAGteDxtIFP0WrXa313ihBKrob4cjCJZ+N/Rf5unI2
	 NGXSGXdU+o4qXq6zjthWbioouDJfsuXBNaqkEWfUHnO6t237IbfucUSAZ1xTOQMnV2
	 21pMSgXMFpd93w65GRbWpPc5waOBkJl4hbIBudKY=
Date: Fri, 20 Sep 2024 20:04:00 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Namhyung Kim <namhyung@kernel.org>
cc: Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
    Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf symbol: Set binary_type of dso when loading
In-Reply-To: <20240426215139.1271039-1-namhyung@kernel.org>
Message-ID: <b9a82437-cd4a-5331-47da-b0d1640169d7@ispras.ru>
References: <20240426215139.1271039-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

On Fri, 26 Apr 2024, Namhyung Kim wrote:

> For the kernel dso, it sets the binary type of dso when loading the
> symbol table.  But it seems not to do that for user DSOs.  Actually
> it sets the symtab type only.  It's not clear why we want to maintain
> the two separately but it uses the binary type info before getting
> the disassembly.
> 
> Let's use the symtab type as binary type too if it's not set.  I think
> it's ok to set the binary type when it founds a symsrc whether or not
> it has actual symbols.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Any chance this can be applied and propagated to stable? Annotating
functions outside of the main executable is broken otherwise (regressed
since 873a83731f1c ("perf annotate: Skip DSOs not found")).

Tested-by: Alexander Monakov <amonakov@ispras.ru>

> ---
>  tools/perf/util/symbol.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 7772a4d3e66c..63936269ec15 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1927,6 +1927,9 @@ int dso__load(struct dso *dso, struct map *map)
>  		if (next_slot) {
>  			ss_pos++;
>  
> +			if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND)
> +				dso__set_binary_type(dso, symtab_type);
> +
>  			if (syms_ss && runtime_ss)
>  				break;
>  		} else {
> 
