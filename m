Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bdxT/MSq"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B59419E
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Nov 2023 09:05:03 -0800 (PST)
Date: Wed, 22 Nov 2023 17:04:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700672699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=104QOQ5hEY0RkqRaNEmxReWHLK4LQLrcVAu7ReXzItk=;
	b=bdxT/MSq/mhr3LycsyubYA0F0Hu/Y8N2nuriSNHcum/SOEADVHMHODsibQ2/s+N81ScnMy
	MVwv3NIwU1Wj05pke97e1iSDCD0/fD5FMjFe128atet1S8YYB5zQGIYHlIy22k9/QpzS7h
	XAjUsGF5a4dUdv22yurd032PnwlE8YA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Marc Zyngier <maz@kernel.org>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf MANIFEST: Add gen-sysreg for ARM SPE
Message-ID: <ZV40tp7uiaTk-Qp1@linux.dev>
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
X-Migadu-Flow: FLOW_OUT

Hi Ian,

On Tue, Nov 21, 2023 at 06:28:05PM -0800, Ian Rogers wrote:
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
> ---
> Note: the breakage is in Linus' tree and perf-tools, not yet in perf-tools-next.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

I had sent out fixes for both of your comments [*], no preference as to
which gets applied. So, FWIW:

Reviewed-by: Oliver Upton <oliver.upton@linux.dev>

[*] https://lore.kernel.org/linux-perf-users/20231121192956.919380-1-oliver.upton@linux.dev/

-- 
Thanks,
Oliver
