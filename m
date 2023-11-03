Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12A21BDF6
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Nov 2023 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLKrlXw0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A658C433C8;
	Fri,  3 Nov 2023 15:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699025374;
	bh=edDh2XpsaRN563DnkZjJS4NVRd5Q2t6fG+6H66m7udo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pLKrlXw0L/S2UskO27XAQmgmPT6dZ9tMrLKEzIAGadNvTyjmUTgfNTp2/NRvrhXOc
	 AU7doFGJd5md7YUNuCv/hT6BFkdkw/Iz/mX8YeQXa3iAE9xw2C8NIDIDnAr95xFQqF
	 ozvx+yZZNsHu2cC04cn4sGCnTqMVyoQpqAivCylvbvEzLg91ZCfwRVFlLA6YUd+Ocf
	 77mfT7iqC37kNp56ClsZNfCH2r/q0enSSej2pokdgN5cLW3aIRCVkJtBM7miOhsGWU
	 m8wJ/8JGgvLWLBcjastpZYJCwVI2gEF/6NFKwkydGRDfXthcRja6S6YOkW0u+y5kgV
	 H0phMvB4epNVQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 768A54035D; Fri,  3 Nov 2023 12:29:31 -0300 (-03)
Date: Fri, 3 Nov 2023 12:29:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yang Jihong <yangjihong1@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf debug: List available options when no variable
 is specified
Message-ID: <ZUUR2/9An1ccCY+C@kernel.org>
References: <20231101064543.1481957-1-yangjihong1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101064543.1481957-1-yangjihong1@huawei.com>
X-Url: http://acmel.wordpress.com

Em Wed, Nov 01, 2023 at 06:45:43AM +0000, Yang Jihong escreveu:
> Minor help message improvement for `perf --debug`
 
> Before:
 
>   # perf --debug
>   No variable specified for --debug.
 
>    Usage: perf [--version] [--help] [OPTIONS] COMMAND [ARGS]
 
> After:
 
>   # perf --debug
>   No variable specified for --debug, available options: verbose,ordered-events,stderr,data-convert,perf-event-open
> 
>    Usage: perf [--version] [--help] [OPTIONS] COMMAND [ARGS]

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
> 
> Changes since v1:
>  - Provide helper to iterate debug_opts and print name instead of adding a new variable.
