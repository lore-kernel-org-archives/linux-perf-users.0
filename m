Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BB88F49;
	Thu, 18 Jun 2026 13:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781789580; cv=none; b=iF1YRRqJ10X3uXimYQZ/4oUSYcSjHIc8/D9+cRoEw6I+VmqyvHAxjFBwQkVfNPWJ9kKkadqHcIXqFuHFJcsbJmpnZb5EZJCJe11HnhttiCFTnTH1fRbKUFV5Fy0pXh6nQzyD6vzSdWjE8d5ydkmZpDXrSyMd94sQVs+qG/GmLso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781789580; c=relaxed/simple;
	bh=CXSLUqO1YTuBevMGCwMAe1FeVPEHneQot7Fc4KxOeEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmsHvkVPXLmse4hylsJOGWvgAHRcOllGIR7BXPJjPhs/xs5jNtmFaDNRb/v8vo3kDKSlJCPKilbNPIC9QE05KBNrPZkgMf5jPx1Y264X2QALqfHLaT+i1plVbz6qGibRPI6r4xXMyWn/p0impfjK8mVztZ+1XPPX4PTNdF/1+0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+g4v+Qv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+g4v+Qv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4001F000E9;
	Thu, 18 Jun 2026 13:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781789579;
	bh=/LkgN/vOE0yYk3tM3qI52dB1AgUy3O7PjFhM6DCr/iQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I+g4v+QvU27bbnc4nkxTeibaT6t5ZyLVkd+d/xY2Hdxqy0418euL9qB0+k5RAbSaL
	 bc4Jqx6xDpvLPrHkXlGECFoi4hyiQYiE27zVyii98hBnOrIM3v5G3C4SUrHfvBc/PK
	 mKLrVjFs/CIFSt9fC56f/gy69pC2gKSXXPZey5hDSNI2EK5kZeBSoCrpQakw1vohBE
	 JGsfCMXl35ERUSXK7KGTKEndcnqItv1fBOR9zmw+TdCJc9WNc4q9vCCm0ZwTOJDQBt
	 Uk1UdNd3uHDw/G0doRC5y+fJo6uuLgpPfRTagdYpvPBek7BgyxWV4y+q18DZa8/pnH
	 HuzLbp/xhwr2Q==
Date: Thu, 18 Jun 2026 10:32:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Aaron Tomlin <atomlin@atomlin.com>
Subject: Re: [PATCHES v3 0/2] perf tools: Add cached probe type detection for
 evsel
Message-ID: <ajPzhxj3KEF7jOTE@x1>
References: <20260616182546.8892-1-acme@kernel.org>
 <ajMkLzJpXzyeqQh4@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajMkLzJpXzyeqQh4@google.com>

On Wed, Jun 17, 2026 at 03:48:15PM -0700, Namhyung Kim wrote:
> On Tue, Jun 16, 2026 at 03:25:44PM -0300, Arnaldo Carvalho de Melo wrote:
> > 
> > Arnaldo Carvalho de Melo (3):
> >   perf evsel: Add lazy-initialized probe type detection helpers
> >   perf trace: Guard __probe_ip suppression with evsel__is_probe()
> >   perf evsel: Add no-libtraceevent stubs for evsel__field() and evsel__common_field()
> 
> It seems you squashed patch 3 into 1. :)

Yeah, I noticed and fixed it up before pushing publicly:

acme@x1:~/git/perf-tools-next$ git log --oneline 27dc372c83d90ccbb19107a2acffe01d6a076a53^.. | tail -3
846f367ff02226e7 perf trace: Guard __probe_ip suppression with evsel__is_probe()
fbb5e6e3ca28a325 perf evsel: Add lazy-initialized probe type detection helpers
27dc372c83d90ccb perf evsel: Add no-libtraceevent stubs for evsel__field() and evsel__common_field()
acme@x1:~/git/perf-tools-next$

- Arnaldo

acme@x1:~/git/perf-tools-next$ git show 27dc372c83d90ccb
commit 27dc372c83d90ccbb19107a2acffe01d6a076a53
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Tue Jun 16 16:37:09 2026 -0300

    perf evsel: Add no-libtraceevent stubs for evsel__field() and evsel__common_field()

    When building without libtraceevent (NO_LIBTRACEEVENT=1), evsel__field()
    and evsel__common_field() are declared but never defined, causing link
    errors in any code path that references them.

    Add inline stubs that return NULL when HAVE_LIBTRACEEVENT is not defined,
    matching the pattern used by other evsel accessor functions.

    Cc: Aaron Tomlin <atomlin@atomlin.com>
    Assisted-by: Claude:claude-opus-4.6
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 8009be22cc3f1055..b959d4797b14035d 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -397,8 +397,22 @@ struct tep_format_field;

 u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sample, bool needs_swap);

+#ifdef HAVE_LIBTRACEEVENT
 struct tep_format_field *evsel__field(struct evsel *evsel, const char *name);
 struct tep_format_field *evsel__common_field(struct evsel *evsel, const char *name);
+#else
+static inline struct tep_format_field *
+evsel__field(struct evsel *evsel __maybe_unused, const char *name __maybe_unused)
+{
+       return NULL;
+}
+
+static inline struct tep_format_field *
+evsel__common_field(struct evsel *evsel __maybe_unused, const char *name __maybe_unused)
+{
+       return NULL;
+}
+#endif

 bool __evsel__match(const struct evsel *evsel, u32 type, u64 config);

acme@x1:~/git/perf-tools-next$

acme@x1:~/git/perf-tools-next$ git show 846f367ff02226e7
commit 846f367ff02226e7089181d2adae45a6cca4a3e6 (number/perf/evsel-probe-type)
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Mon Jun 15 22:17:41 2026 -0300

    perf trace: Guard __probe_ip suppression with evsel__is_probe()

    trace__fprintf_tp_fields() compares every field name against
    "__probe_ip" for all tracepoint events, but this field is only
    implicitly added by the Ftrace subsystem to bare dynamic probes.

    Add an evsel__is_probe() check before the strcmp so the string
    comparison is skipped entirely for non-probe events.

    Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
    Assisted-by: Claude:claude-opus-4.6
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a8492da23a9cc178..57f3f14c5d435805 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3267,7 +3267,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct perf_sample *
                 * If verbose mode is enabled, ensure it is formatted as a
                 * hexadecimal memory address rather than a signed integer.
                 */
-               if (!strcmp(field->name, "__probe_ip")) {
+               if (evsel__is_probe(evsel) && !strcmp(field->name, "__probe_ip")) {
                        if (!verbose)
                                continue;

acme@x1:~/git/perf-tools-next$
