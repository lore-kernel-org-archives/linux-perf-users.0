Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4301A250E9
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7KkJl13"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFF6C433C7;
	Mon, 27 Nov 2023 14:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701096009;
	bh=vTUbAPNKdHgfHvgxRcJCOXwUsIbXASFDzkkqMyquuPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O7KkJl13o2go+127IAK9+2Ecf7MaeoMoLOgY2ssC/KD6WW9vOiAqWkiCx+HinnvCq
	 YZ6rAUHxh4kbXrcfCrdl3AOS3lMu8JXhY9rMmizsj8RBVqnlVf9oebahYHtFlRgAQN
	 LDsRGvmDGP5B+4xHIuI01j1QyE6l8zLkvP+PtuUjcZgiAXusHpZPDAvFwt7ZiEDZbT
	 Sw8sUXC4rfIeGB+FEZSWITwgkKw4oGdRMEe7zHsIaGgXU+/thpi9ImiSTxM9vXMLPn
	 PJYvMwiea8vDubXtqbVMwOnYu9ZY6gkIOb/R/cpLj1lEGgTcVOGBkdbsHlMcuIB0xI
	 A4DZfn+D7iPHQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 71CF340094; Mon, 27 Nov 2023 11:40:07 -0300 (-03)
Date: Mon, 27 Nov 2023 11:40:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Nikita Shubin <n.shubin@yadro.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4] perf vendor events riscv: add StarFive Dubhe-90 JSON
 file
Message-ID: <ZWSqR8cqMB//WE/A@kernel.org>
References: <20231122030908.2981502-1-jisheng.teoh@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122030908.2981502-1-jisheng.teoh@starfivetech.com>
X-Url: http://acmel.wordpress.com

Em Wed, Nov 22, 2023 at 11:09:08AM +0800, Ji Sheng Teoh escreveu:
> Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> ---
> Changelog:
> v3 -> v4:
> - Reuse common and firmware json file from starfive/dubhe-80.
> - Rebase against latest perf-tools-next
> - Update commit message to reflect the above changes.

I guess this addressed all the review comments, applied, if something is
still amiss we can add a followup patch.

- Arnaldo

> v2 -> v3:
> - Add standard RISC-V firmware event
> - Update commit message to reflect addition of standard
>   RISC-V firmware event.
> v1 -> v2:
> - Rename 'Starfive Dubhe' to 'StarFive Dubhe-90' in commit message.
> - Rename 'starfive/dubhe' pmu-events folder to 'starfive/dubhe-90'
> - Update MARCHID to 0x80000000db000090 in mapfile.csv
> ---
>  tools/perf/pmu-events/arch/riscv/mapfile.csv | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
