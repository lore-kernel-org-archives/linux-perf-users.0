Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825055;
	b=MiRaPYnFD1qlxCX0QcrthIkQlhg5NYe8GAmji4Pt8g2/hwhugrjDC1dHxnCvdBF6KVNx
	 H60pLkAFagnwLiLEp2kAuKv7IV/t6nNDJqbFHNC/vSf907plQme3vNDmbTb/KczKnrt7h
	 KwhnQwJ99fvg+lDEvcmvZ9OCHdkuNmETCZVCPt9cF5xaCplJxnBIvJCyrfWMYmF3QS6nC
	 nmj3pfor4IcL8MxhoHUy20MYtPJgfgW3aum6s4yjNvxlxLF7uSMHvlmbXEaq0WqXThMJ3
	 tTT0RAiPMRF1hsANzPE/B9lbtFAZTYn0Zt67twctghDoRqi4PO+S0UwFODVlGrL4+bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825055;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=tf2l3yXkE0t8Xin8N46UyRzO27EoLv897wb9giIedgs=;
	b=5LjlCGcUExlqhESqZqKue+xQUmAcittQD03JRsVUny8K77iHd/Mpht24zVx8GAdOLEYl
	 GcjDnhrYBTdCQKLabRwSZDrHMtx5rVnx8N6ouK6TpvTrDkEd/8d7Ii2BxFlM+tCQdd3ez
	 4eoYmdQ6E+g2yVS+Q+5Zm/jtb3+k0KVxvMW3RbcueZ9bx/X4Cj4vIgCyC0mb20kEJLHyl
	 LF6lKj27wOpsr3ND+kcW5kJG+lfmKnaEHH8HCKlqouEflJPoWUY65k8V7Ezu+r+xQZjKz
	 Fu95o7QGwY5rJ7BjWGa0tt4njcOG0i/L5d+IeNfCC56SLPrKMRK1s1IIvugLHVqWofg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="m/nBWSHZ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7DF606A87B;
	Wed,  4 Nov 2026 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m/nBWSHZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925A51F000C1;
	Wed,  4 Nov 2026 20:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793825055;
	bh=tf2l3yXkE0t8Xin8N46UyRzO27EoLv897wb9giIedgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m/nBWSHZ1Ava1b+ZNwOQl0RnwijsopBvm8DRCbBb9rSVZKhbk4hc5Id7icuXCLqS3
	 HczZB0azBitCJpi/oxCYt69/Ur2cRjZwovaywvPBJfpqHSY9d6gocWZvOj4JxWD45/
	 FgoSby3hbSQN2L5oMi2PoNEcJztoejKEQAJiIvCDxyS2LaJB9hbcDiNMrN5zd15d0V
	 AGUXpRj5csE6aw2w0BDFfyPHlyN3GR8QMNo+mqD8pgN+IdhzkBitiv04F5xLC740ir
	 NpOnFINhPYZf5R4JcJQAinVw18vg9hXl0XH+zQw24pYCtQqU9OJKT49DeB1iwDnXgm
	 rtmXPOi4mbTgw==
Date: Wed, 4 Nov 2026 17:44:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: dima@arista.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [PATCH] perf build: Override OUTPUT when building internal
 libraries
Message-ID: <auuZHBawk2--flHW@phoenix2>
References: <20261103-perf-output-v1-1-df33a0368cf2@arista.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261103-perf-output-v1-1-df33a0368cf2@arista.com>

On Tue, Nov 03, 2026 at 04:55:21PM +0000, Dmitry Safonov via B4 Relay wrote:
> From: Dmitry Safonov <dima@arista.com>
> 
> After commit 1572ba36fbca ("perf tests: Improvements to build-test
> performance"), building perf with OUTPUT on the command line fails:
>   make -C tools/perf OUTPUT=/tmp/linux/bld/perf/ ARCH=x86_64 LC_ALL=C CC=gcc HOSTCC=gcc LD=ld

That '/bld/' is not reflected in the next line, copy'n'paste mistake?

>   ...
>   make[3]: *** No rule to make target '/tmp/linux/perf/libsubcmd/libsubcmd.a'.  Stop.

⬢ [acme@toolbx perf-tools]$ mkdir -p /tmp/linux/perf
⬢ [acme@toolbx perf-tools]$ make -C tools/perf OUTPUT=/tmp/linux/perf/ ARCH=x86_64 LC_ALL=C CC=gcc HOSTCC=gcc LD=ld
make: Entering directory '/home/acme/git/perf-tools/tools/perf'
  BUILD:   Doing 'make -j32' parallel build
  <SNIP>
    TEST    /tmp/linux/perf/tests/shell/base_probe/test_line_semantics.sh.shellcheck_log
  GEN     /tmp/linux/perf/arch/arm64/include/generated/asm/sysreg-defs.h
make[3]: *** No rule to make target '/tmp/linux/perf/libsubcmd/libsubcmd.a'.  Stop.
make[2]: *** [Makefile.perf:827: /tmp/linux/perf/libsubcmd/libsubcmd.a] Error 2
make[2]: *** Waiting for unfinished jobs....
  MKDIR   /tmp/linux/perf/tests/shell/lib/
  TEST    /tmp/linux/perf/tests/shell/lib/perf_metric_validation.py.mypy_log
  TEST    /tmp/linux/perf/tests/shell/lib/perf_json_output_lint.py.mypy_log
  PERF_VERSION = 7.4.rc1.g45e09a6dbb2d
make[3]: *** No rule to make target '/tmp/linux/perf/libsymbol/libsymbol.a'.  Stop.
make[3]: *** No rule to make target '/tmp/linux/perf/libperf/libperf.a'.  Stop.

Minor stuff, I'll fix it up and apply to perf-tools to send for 7.4-rc1,

Thanks,

- Arnaldo

> MAKEFLAGS propagates the command-line OUTPUT assignment to recursive makes.
> The library builds pass their output directories through $O, but the assignment
> to $OUTPUT in tools/scripts/Makefile.include cannot replace a command-line
> argument. This affects libapi, libperf, libsubcmd and libsymbol.
> 
> With "unexport MAKEFLAGS" returned and added $(info) debug in libsubcmd
> Makefile produces:
>   OUTPUT = /tmp/linux/perf/libsubcmd/
> Without it, on current master it prints:
>   OUTPUT = /tmp/linux/perf/
> 
> Pass OUTPUT explicitly to each library build, including the trailing slash
> required when constructing file names. This follows the existing libbpf
> build rule and preserves MAKEFLAGS and jobserver propagation.
> 
> Fixes: 1572ba36fbca ("perf tests: Improvements to build-test performance")
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  tools/perf/Makefile.perf | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index b74b534e1153..4cc5bb3011da 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -798,7 +798,7 @@ $(patsubst perf-%,%.o,$(PROGRAMS)): $(wildcard */*.h)
>  
>  $(LIBAPI): FORCE | $(LIBAPI_OUTPUT)
>  	$(Q)$(MAKE) -C $(LIBAPI_DIR) O=$(LIBAPI_OUTPUT) \
> -		DESTDIR=$(LIBAPI_DESTDIR) prefix= subdir= \
> +		OUTPUT=$(LIBAPI_OUTPUT)/ DESTDIR=$(LIBAPI_DESTDIR) prefix= subdir= \
>  		$@ install_headers
>  
>  $(LIBAPI)-clean:
> @@ -816,7 +816,7 @@ $(LIBBPF)-clean:
>  
>  $(LIBPERF): FORCE | $(LIBPERF_OUTPUT)
>  	$(Q)$(MAKE) -C $(LIBPERF_DIR) O=$(LIBPERF_OUTPUT) \
> -		DESTDIR=$(LIBPERF_DESTDIR) prefix= subdir= \
> +		OUTPUT=$(LIBPERF_OUTPUT)/ DESTDIR=$(LIBPERF_DESTDIR) prefix= subdir= \
>  		$@ install_headers
>  
>  $(LIBPERF)-clean:
> @@ -825,7 +825,7 @@ $(LIBPERF)-clean:
>  
>  $(LIBSUBCMD): FORCE | $(LIBSUBCMD_OUTPUT)
>  	$(Q)$(MAKE) -C $(LIBSUBCMD_DIR) O=$(LIBSUBCMD_OUTPUT) \
> -		DESTDIR=$(LIBSUBCMD_DESTDIR) prefix= subdir= \
> +		OUTPUT=$(LIBSUBCMD_OUTPUT)/ DESTDIR=$(LIBSUBCMD_DESTDIR) prefix= subdir= \
>  		$@ install_headers
>  
>  $(LIBSUBCMD)-clean:
> @@ -834,7 +834,7 @@ $(LIBSUBCMD)-clean:
>  
>  $(LIBSYMBOL): FORCE | $(LIBSYMBOL_OUTPUT)
>  	$(Q)$(MAKE) -C $(LIBSYMBOL_DIR) O=$(LIBSYMBOL_OUTPUT) \
> -		DESTDIR=$(LIBSYMBOL_DESTDIR) prefix= subdir= \
> +		OUTPUT=$(LIBSYMBOL_OUTPUT)/ DESTDIR=$(LIBSYMBOL_DESTDIR) prefix= subdir= \
>  		$@ install_headers
>  
>  $(LIBSYMBOL)-clean:
> 
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261103-perf-output-58d6965d2726
> 
> Best regards,
> --  
> Dmitry Safonov <dima@arista.com>
> 
