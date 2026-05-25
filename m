Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201AD357D0E;
	Mon, 25 May 2026 23:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779752309; cv=none; b=jWN1SHvM8P3ugjyfFsGIR/9R7aWt5f/u11nRv5fWXMVqiQnnhohaDhb2+gUmZZ9s4H2DsPlpTpBVEkSMaueBRh3UVvS/AZROeFp/SuXEgZIMpp6L65ePFfbceUi/1r5EXOx77u8VeJIMTqINu2l9aDA+D9bZA0jSGnhsKlLZa3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779752309; c=relaxed/simple;
	bh=41DFfRmmXCm3/JzfQBD+OLryWI7OtF/e8VwpYjo1Vlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G36H3jmkWT/fzq4JHR+Ck+hSr+fccyp7MuF2DJ7V6s8DXM/Cgs9DaAEbkQ9RMNPxFcUVATeH2BHOc9wZdK45FWM36J5tLjpG0oXS2u4AR+DiYRjrLKpg9JH6Ou2dmkNqtolzjkMOdjI22q0dToeNoQvhaY31T5j2Gbtu1ovvBco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aM9btm8Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aM9btm8Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5811F000E9;
	Mon, 25 May 2026 23:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779752307;
	bh=WxCSkNslyBObqpJ5u7R6zM2zdEpaCIXxx+BCetGkn84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aM9btm8QLxSZRolNp5JT+fJ0w7v+QnVVmhwr9rfO0M09wGkwk0o1eUs4tdPrE9zIf
	 dH1VoeLwObPqkSiQ+92GQPnb3g8LtPnKkZOQ94qdMRKrmSzISAOT4qpM0Wf/+eeGuC
	 Qh2IjWjAsIpbQNJ02/j25tIVjiPrMOm0w45L31vb/KV71gACknG3bmPRNjHSFmkOi3
	 dbfqVg0xC+Kc72fBDp8YjigMA8fmPswblK0UPdI/e6urLkqH5LykcrwB3VnPzfM0Jj
	 /JwSPzdwNvExeWeZrLd0a2/YMgYzLTC6XoQ4Zy6AflGH6rri9s7UCsmqSoDOEh2NpU
	 ERLN5GeV4YSBA==
Date: Mon, 25 May 2026 20:38:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org,
	adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org
Subject: Re: [RFC PATCH v2 01/14] perf stat: Introduce core generic print
 traversal engine and header stubs
Message-ID: <ahTdcAqLUH_Za7qe@x1>
References: <20260522223342.2393553-1-irogers@google.com>
 <20260525231900.3527228-1-irogers@google.com>
 <20260525231900.3527228-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525231900.3527228-2-irogers@google.com>

On Mon, May 25, 2026 at 04:18:47PM -0700, Ian Rogers wrote:
> This patch introduces the initial infrastructure for decoupling the
> perf stat printing API. It declares the struct perf_stat_print_callbacks
> interface and the core traversal driver perf_stat__print_cb() inside
> the newly created util/stat-print.h and util/stat-print.c files.

Can we avoid these kinds of reflowings:

                OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
-                       "Set the metrics level for the top-down statistics (0: max level)"),
-               OPT_BOOLEAN(0, "smi-cost", &smi_cost,
-                       "measure SMI cost"),
+                            "Set the metrics level for the top-down statistics (0: max level)"),
+               OPT_BOOLEAN(0, "smi-cost", &smi_cost, "measure SMI cost")

There is a lot to process and these things gets in the way.

I'm trying to make sure this doesnt' happen in my patches with or
without AI assistance :-)

We need to have this as a skill so that AI don't do this.

Thanks,

- Arnaldo
