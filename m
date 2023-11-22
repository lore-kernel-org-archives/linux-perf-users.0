Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AE222077
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Nov 2023 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epZ3rf/o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDF0C433CA;
	Wed, 22 Nov 2023 12:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700655486;
	bh=tmSdO6nisNWdPSNXgRxViOIYsBYRjANzc2daxjLNPig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=epZ3rf/oEy+7PKuqgt/KSthVqt1SOGxa27is5H21g48Thjk0I+JTj7we4G3K9YFLa
	 rCoO9/MEKiZgh1dF5Tso7aqOHoyBhsEqh50oIRSMwVElFoQBbnz4IsI/HWu7y8l/oP
	 4M1+FCwa++5sJmD6U+/rPLtNw52T3WtqYaAHb/ESMESxAsBX7f6PC+aL3M3K/qMnEL
	 zuAdqADiWCdauxyIy6luFCgjtcY4L3iOXZER5+L9DZKU8UcoV/eraJ2h9sW5en35LO
	 fv+N4HfBPgErFNPbcovoOoVaGbG+/JaAxVgkpqFEs7t4pK1AEUEQm0BYtV6o7ofQA9
	 t6S++A1natRVA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 5872040094; Wed, 22 Nov 2023 09:18:03 -0300 (-03)
Date: Wed, 22 Nov 2023 09:18:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf MANIFEST: Add gen-sysreg for ARM SPE
Message-ID: <ZV3xe1qVCiz5bkLP@kernel.org>
References: <20231122022805.511839-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122022805.511839-1-irogers@google.com>
X-Url: http://acmel.wordpress.com

Em Tue, Nov 21, 2023 at 06:28:05PM -0800, Ian Rogers escreveu:
> The necessary files for generating sysreg-defs.h need adding to the
> perf tool MANIFEST that lists the files for packaging the perf tool
> source code. Fix for the following:
> 
> ```
> $ make perf-tar-src-pkg
> $ tar xvf perf-6.7.0-rc2.tar
> $ cd perf-6.7.0-rc2
> $ make -C tools/perf
> ...
>   PERF_VERSION = 6.7.rc2.gc2d5304e6c64
> make[3]: *** No rule to make target 'perf-6.7.0-rc2/arch/arm64/tools/gen-sysreg.awk', needed by 'perf-6.7.0-rc2/tools/arch/arm64/include/generated/asm/sysreg-defs.h'.  Stop.
> make[2]: *** [Makefile.perf:456: arm64-sysreg-defs] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [Makefile.perf:242: sub-make] Error 2
> make: *** [Makefile:70: all] Error 2
> make: Leaving directory 'perf-6.7.0-rc2/tools/perf'
> ...
> ```
> 
> Fixes: e2bdd172e665 ("perf build: Generate arm64's sysreg-defs.h and add to include path")

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Namhyung, I'm testing this together with your headers sync series + what
is in perf-tools/tmp.perf-tools, will report results soon.

- Arnaldo

> ---
> Note: the breakage is in Linus' tree and perf-tools, not yet in perf-tools-next.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/MANIFEST | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
> index 1da7f4b91b4f..dc42de1785ce 100644
> --- a/tools/perf/MANIFEST
> +++ b/tools/perf/MANIFEST
> @@ -1,3 +1,5 @@
> +arch/arm64/tools/gen-sysreg.awk
> +arch/arm64/tools/sysreg
>  tools/perf
>  tools/arch
>  tools/scripts
> -- 
> 2.43.0.rc1.413.gea7ed67945-goog
> 

-- 

- Arnaldo
