Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBED96F2F3;
	Thu, 22 Aug 2024 18:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724350431; cv=none; b=jMl/bUq0LZCMwM4tMJJFZhjxOGp9bYDqGM2KHDNoZYW5yROW0p49UkgVgcW786c9IjAqdZbpta1IdxySvgWrCf8INZmB/Ezy4YrHfAPzhwBiF9dTA9QI525brdHrxdsoEyiY/PneucFxp9aWtz9huoMfWyBVvi/T+A5kc/GuWq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724350431; c=relaxed/simple;
	bh=RJh5gKo+fqZyhJVD6tSM6wVWgMksIx+pSXtvOy8IS3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5yjx4BRh3B+YR+FeIZvbiJ1bC6yJlBL5MeOLk2dQhf6Y5oWqamLkL4/LeOps+yxJDdu3tod6Iiiw4HNU+PBmr/fTud8w7pVGGWBxwzRn6HZ3Rh4v2NVh36/YI4dDZgDztwdilnKMSDFi20o5wvUZZ+xyPOh4ZfmCJKZ3EeEYbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y559L7Rq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y559L7Rq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD338C32782;
	Thu, 22 Aug 2024 18:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724350431;
	bh=RJh5gKo+fqZyhJVD6tSM6wVWgMksIx+pSXtvOy8IS3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y559L7RqiEI9DUFK0N86e2QOdewZEzJJDfvVbmfsGf6L/vc4vU05agOIqLkVJ7EJ8
	 rDypYSoAc568QStO/Xt1xS3wr4gAILS8pX9E2cUigfvZZxi4sQUt10k2QexRg2WbFI
	 c7Plcxm4OQhYtmLKTN3Aqa6EkEIOzjY9EgNiMWlY7nlDjHe25hKAUZy7H7uljaf9O6
	 0JV6OXOOYdo+CRdw5onPoGwL7HsWsvLGlwyL/g2Hnpu+lwf/O9EC+DaftMPrNS8zCA
	 CdTjRNTKdxjif/jqET0KWI2YljDUvmkEPY3WQOqAVMpZAJZIIQmnt+iQsyNA9e63a8
	 BgMMViCFcbV0g==
Date: Thu, 22 Aug 2024 15:13:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/10] perf trace: Add a new argument to
 trace__btf_scnprintf()
Message-ID: <Zsd_278bECAXUzmC@x1>
References: <20240815013626.935097-1-howardchu95@gmail.com>
 <20240815013626.935097-6-howardchu95@gmail.com>
 <Zsd8vqCrTh5h69rp@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zsd8vqCrTh5h69rp@x1>

On Thu, Aug 22, 2024 at 03:00:30PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Aug 15, 2024 at 09:36:21AM +0800, Howard Chu wrote:
> > Pass the struct syscall_arg, so that we can use the augmented_arg later
> > in the struct augmentation.
> 
> Breaks the build with:
> 
> builtin-trace.c: In function ‘trace__btf_scnprintf’:
> builtin-trace.c:1011:78: error: unused parameter ‘arg’ [-Werror=unused-parameter]
>  1011 |                                    size_t size, int val, struct syscall_arg *arg, char *type)
>       |                                                          ~~~~~~~~~~~~~~~~~~~~^~~
>   LD      /tmp/build/perf-tools-next/util/perf-util-in.o
>   LD      /tmp/build/perf-tools-next/perf-util-in.o
>   AR      /tmp/build/perf-tools-next/libperf-util.a
>   GEN     /tmp/build/perf-tools-next/python/perf.cpython-312-x86_64-linux-gnu.so
> cc1: all warnings being treated as errors
> 
> So we either use __maybe_unused at this point or combine it with the
> patch where it really gets used. I think the later is better, will do.

So here what I think we should do is to use the patch below, ok? I'm
continuing...

- Arnaldo

---

From 2c1ea68ac3d18109d96bd16e2860e076d2e0d61e Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Thu, 22 Aug 2024 15:10:27 -0300
Subject: [PATCH 1/1] perf trace: Pass the richer 'struct syscall_arg' pointer
 to trace__btf_scnprintf()

Since we'll need it later in the current patch series and we can get the
syscall_arg_fmt from syscall_arg->fmt.

Based-on-a-patch-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/Zsd8vqCrTh5h69rp@x1
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 37ca96e130a5862d..a909880bd25e51d1 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1007,9 +1007,11 @@ static size_t btf_enum_scnprintf(const struct btf_type *type, struct btf *btf, c
 	return 0;
 }
 
-static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg_fmt *arg_fmt, char *bf,
+static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg *arg, char *bf,
 				   size_t size, int val, char *type)
 {
+	struct syscall_arg_fmt *arg_fmt = arg->fmt;
+
 	if (trace->btf == NULL)
 		return 0;
 
@@ -1029,7 +1031,7 @@ static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg_fmt *
 }
 
 #else // HAVE_LIBBPF_SUPPORT
-static size_t trace__btf_scnprintf(struct trace *trace __maybe_unused, struct syscall_arg_fmt *arg_fmt __maybe_unused,
+static size_t trace__btf_scnprintf(struct trace *trace __maybe_unused, struct syscall_arg *arg __maybe_unused,
 				   char *bf __maybe_unused, size_t size __maybe_unused, int val __maybe_unused,
 				   char *type __maybe_unused)
 {
@@ -2284,7 +2286,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			if (trace->show_arg_names)
 				printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
 
-			btf_printed = trace__btf_scnprintf(trace, &sc->arg_fmt[arg.idx], bf + printed,
+			btf_printed = trace__btf_scnprintf(trace, &arg, bf + printed,
 							   size - printed, val, field->type);
 			if (btf_printed) {
 				printed += btf_printed;
@@ -2987,7 +2989,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 		if (trace->show_arg_names)
 			printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
 
-		btf_printed = trace__btf_scnprintf(trace, arg, bf + printed, size - printed, val, field->type);
+		btf_printed = trace__btf_scnprintf(trace, &syscall_arg, bf + printed, size - printed, val, field->type);
 		if (btf_printed) {
 			printed += btf_printed;
 			continue;
-- 
2.46.0

