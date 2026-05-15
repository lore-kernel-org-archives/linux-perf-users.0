Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99B93CE4BA;
	Fri, 15 May 2026 11:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778844476; cv=none; b=GVn3x1Hg+E+T2M6paCgOA+U0SGQNmHPm26KFwDn/gpNtwXzNK+TIM0VFdxaYyRPaCZ11LEt03j5kZKU+MqeymHSjCUILm7Jbn1Ic8AaeWSemyf5iNacBbhVfIUCk7Sb9gIyReGYns82tk3uPjBdHSoqblPxhqtYhLazoMGsMEx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778844476; c=relaxed/simple;
	bh=1QmB3Gx/1WbwJvtwiPsMqLpKCcMjMe1a+V1Ox4LyywU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aa87pvrYG6cPyvXIr9S6PgOvGPu8YK4ckE26kxEdIi1mtXtxI8ChhCOwv0nFcQhIP/QMPWjFRcACazOuI21k0+WlfqDlCTfhYnNsPxi5mY4x0xlVznfHPV56HvyndWTuxydqi8E1XN0kBIhSS4Tr/x9oDqLR87oEtsKw0nMaNmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ngf+V18U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ngf+V18U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B08C2BCB0;
	Fri, 15 May 2026 11:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778844476;
	bh=1QmB3Gx/1WbwJvtwiPsMqLpKCcMjMe1a+V1Ox4LyywU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ngf+V18Ur5maro1wDSUVkYvZsmnY0ceVusXYlGsjjujySbK+xDLHBppOtWEmUbTCZ
	 gVdL43QtPuDf88ZRUVt3xUoGumi4qWMpVHb9HK3MkqHRhWSxqkO+N55zQfxbL2+Mcw
	 zQ1UgEPdz1RAV+eWQgvfxGubdhFBFWDhv8akq0YrpgVpNWqldNSKSpBTYGUxB1miUN
	 70PE3WXEdhdvqG+qntvdGLz9Iv/StpStAghQurkSvHTvNpDhU2Y+v2zgM7GFebfnrW
	 NpiceKUZzALlN1/rh58lVjzfoAwiFS7rcZ+IppjDLReJsTcUokHCmSw+G0K0gsDH+4
	 yeAyQbusl+pFg==
Date: Fri, 15 May 2026 08:27:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com,
	james.clark@linaro.org, namhyung@kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Li Guan <guanli.oerv@isrc.iscas.ac.cn>, 9erthalion6@gmail.com,
	alex@ghiti.fr, alexander.shishkin@linux.intel.com,
	andrew.jones@oss.qualcomm.com, aou@eecs.berkeley.edu,
	atrajeev@linux.ibm.com, howardchu95@gmail.com,
	john.g.garry@oracle.com, jolsa@kernel.org, leo.yan@linux.dev,
	libunwind-devel@nongnu.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org, mingo@redhat.com,
	palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org,
	shimin.guo@skydio.com, tglozar@redhat.com, tmricht@linux.ibm.com,
	will@kernel.org
Subject: Re: [PATCH v5 1/7] perf unwind: Refactor get_entries to allow
 dynamic libdw/libunwind selection
Message-ID: <agcDOac0qbP1KZ4Y@x1>
References: <20260413024805.1316480-1-irogers@google.com>
 <20260513233151.572332-1-irogers@google.com>
 <20260513233151.572332-2-irogers@google.com>
 <agZk-CCrLUMTyWE4@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agZk-CCrLUMTyWE4@x1>

On Thu, May 14, 2026 at 09:12:40PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, May 13, 2026 at 04:31:45PM -0700, Ian Rogers wrote:

<SNIP>

> > +++ b/tools/perf/util/unwind.h

<SNIP>

> > +static inline int libdw__get_entries(unwind_entry_cb_t cb __maybe_unused, void *arg __maybe_unused,
> > +				     struct thread *thread __maybe_unused,
> > +				     struct perf_sample *data __maybe_unused,
> > +				     int max_stack __maybe_unused,
> > +				     bool best_effort __maybe_unused)
> > +{
> > +	pr_err("Error: libdw dwarf unwinding not built into perf\n");
> > +	return 0;
> > +}
> > +#endif

I also addressed this local sashiko review comment:

-------------------------------------------------------------------------
Since unwinding is performed per-sample in the hot path, will using pr_err()
here cause console flooding if the user explicitly configures an unsupported
unwind style?
Should this use pr_warning_once() instead, similar to the UNWIND_STYLE_UNKNOWN
fallback behavior in unwind.c?
-------------------------------------------------------------------------

And in one other place, please ack,

- Arnaldo

diff --git a/tools/perf/util/unwind.h b/tools/perf/util/unwind.h
index 28db3e3b9b513401..69ba08afda792d17 100644
--- a/tools/perf/util/unwind.h
+++ b/tools/perf/util/unwind.h
@@ -53,7 +53,7 @@ static inline int libdw__get_entries(unwind_entry_cb_t cb __maybe_unused, void *
 				     int max_stack __maybe_unused,
 				     bool best_effort __maybe_unused)
 {
-	pr_err("Error: libdw dwarf unwinding not built into perf\n");
+	pr_warning_once("Error: libdw dwarf unwinding not built into perf\n");
 	return 0;
 }
 #endif
@@ -81,7 +81,7 @@ static inline int libunwind__get_entries(unwind_entry_cb_t cb __maybe_unused,
 					 int max_stack __maybe_unused,
 					 bool best_effort __maybe_unused)
 {
-	pr_err("Error: libunwind dwarf unwinding not built into perf\n");
+	pr_warning_once("Error: libunwind dwarf unwinding not built into perf\n");
 	return 0;
 }
 
