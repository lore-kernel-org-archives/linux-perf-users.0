Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A101F3491C4;
	Wed, 20 May 2026 19:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779306409; cv=none; b=OybwCZfeDFC1mpJs5lTI9dcDp5KcCrKGRbaP1cLVyJjQ4w5o58s8keBViQ0Ho8Bb12M+zXOUu0psb0ieNERe+QNrUKfdHRdlwVqAdjc9uuaWRReKt0dsE5rKrVUalCoHPUjEgQZFB+uK/3gwdHzrqqQ0KLQ5afjdCeQRg2YAxCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779306409; c=relaxed/simple;
	bh=3+/7FYKzQcC6gyZTmjmm/7r//9DZe5pmlgqvDEnJiH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0vSUI65VBvyl89iaWo8j5Fl3TRdNnve3bI2lFcC/Zr6t3cnDmpwCWtZqVM3ZDgW2nnrxqacF14PjnFRMaCG9j9LhX/gH+mrM6fu/oPmJ30XLxT+6wzpvU+Mvo81VqZqtGQ6vka/rk10SeSixnFRs8ZyQ0AMn/ITEuwFd03Vrlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltvuyNIR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltvuyNIR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DADD1F000E9;
	Wed, 20 May 2026 19:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779306408;
	bh=NexP6GNu/sih5qH17nC+eG4ll9i5KWXlHW+7k2fiIPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ltvuyNIRljSGKkkXTo+M3VObO9LP8lVEbCPIToyv5Lg6wglOhGxnmFBLeIEd6uDuB
	 zm6J9DXAl6KCSXX1ms3fqb2FDVjrInQYZg9jZ9QxHVcQMiWjYoNkH3EQeGSmTkAkxT
	 j5BNlzn8s5Fz4kcBDLpvPzssuCIOei0QaqyWJXpWt4EE5fDPmad+yaLGQGYdBxyqLX
	 usyLG86J/6H3PaJY2DMvhB17qmPG5ewPNbajohuBvkfqdJXzpBdNaFdsJRdxwuYXeq
	 lHOqsb26/E0SYA4btcqtWEftSAJSvN6Z8EL28ktbN77lnMtKFm2wPeBondm/fIA4lG
	 Hyz/TVqfhpkdg==
Date: Wed, 20 May 2026 16:46:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
	ak@linux.intel.com, alex@ghiti.fr,
	alexander.shishkin@linux.intel.com, anup@brainfault.org,
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com,
	blakejones@google.com, ctshao@google.com,
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com,
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com,
	james.clark@linaro.org, jolsa@kernel.org,
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn,
	palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org,
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn,
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com,
	zhouquan@iscas.ac.cn
Subject: Re: [PATCH v14 00/32] perf tools: Add evsel to perf_sample
Message-ID: <ag4PpWl-wV7SDpd5@x1>
References: <20260512223001.2952848-1-irogers@google.com>
 <20260520190538.142018-1-irogers@google.com>
 <ag4IT7YfVyFjggK6@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag4IT7YfVyFjggK6@x1>

On Wed, May 20, 2026 at 04:15:30PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, May 20, 2026 at 12:05:06PM -0700, Ian Rogers wrote:
> > Nearly all perf code ends up passing an evsel with the perf_sample,
> > which is problematic if you want to rewrite the evsel (such as with
> > off-CPU processing) because all uses of the evsel need to be fixed
> > up. Since the perf_sample now carries its own resolved evsel pointer,
> > passing evsel separately is redundant and error-prone (allowing
> > parameter divergence bugs).
> > 
> > This series cleans up the redundant evsel parameter across all perf
> > tool subcommands and APIs, ensuring that tools uniformly retrieve
> > event attributes directly from the sample itself. This simplifies
> > function signatures and improves API consistency.
> > 
> > Additionally, this series incorporates subsequent memory safety
> > improvements, robust bounds checking, and memory leak corrections
> > prompted by address sanitizers and Sashiko code reviews.
> > 
> > The original combined RFC patch:
> > https://lore.kernel.org/lkml/20260126071822.447368-1-irogers@google.com/
> > was split up per reviewer requests.
> > 
> > v14:
> >  - Incorporate Acked-by tags from Namhyung Kim.
> >  - Re-polish and expand commit descriptions to provide thorough explanations
> >    of the changes and their rationale.
> 
> Thanks, tentatively applying it to perf-tools-next, for v7.2.

Had to apply a minor fixup for a conflict with anoter patch series from
you, the LBR one.
 
- Arnaldo
