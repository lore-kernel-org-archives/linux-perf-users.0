Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E952210F0;
	Fri, 20 Dec 2024 19:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734722190; cv=none; b=jfTVvpkgxURB9smeqOV+j9wE5zANXIMmvzh/bdva2mIof2tENzWO4QRbpB0E8puG6YisB7rY4hjz5iJDN/SQUZ7BrDDvVGNLQHyZzxP9GkM9ScMCj/Gd9XiHuq/gRMNW1HsYYzC261QE05Aqzw6PoipAYaa1Y8WkRjAgeqq3XQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734722190; c=relaxed/simple;
	bh=qWMk+Bjokcw5DQB9cAF8UqFtpkvZmt5V7WWZ3Xsr4CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfoucYPReeo5Tr6zFNxmmfM53q7Vj1Q27fZpHTRbqE/VIEvxcaWaiH61uvrBPy/RH9wS4ixVTRDiwyR2L6mwvXbFBjk0ubpT1wcge0hnKC3b+c7YriE80l25jXd9Be/KJqASvpHZtC3LPLzRGWBfUsBdYIqJZYzyROvH+HHwd9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjy5WbLh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjy5WbLh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78061C4CECD;
	Fri, 20 Dec 2024 19:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734722190;
	bh=qWMk+Bjokcw5DQB9cAF8UqFtpkvZmt5V7WWZ3Xsr4CA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pjy5WbLhTtSFhoqt0Zsnre5vxovGF7EGK/hJQ/HIIjlLVDCOPyM0tap8NNICLRorC
	 pZ56U5r+NOluW07tIaoIEGLh2M6/LJsx1b4m/mNhxI9iKkVij9txhygwWbIxeP2ffs
	 j67qbURo/wlXF1kZnJFjuotiDk29qliNhJ16Bp9JTZWWVPyfM4Oiw8tqnvHDTflmJ1
	 258WWQ4Azn+jaV2y0uS4KYSZq7J+x0xCfTEWhUm4U6O9tWO49ff3cVSvJEbKXng+PK
	 nyTQI4lDokt5Mrz4dTFPP6cw5WfsJJULBOzMy9LfV93eS3lBhcqfPEbvXeCOYv+A2a
	 NTs0Rv/XNc77g==
Date: Fri, 20 Dec 2024 16:16:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, ravi.bangoria@amd.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf script: Fix output type for dynamically
 allocated core PMU's
Message-ID: <Z2XCi3PgstSrV0SE@x1>
References: <20241213215421.661139-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213215421.661139-1-thomas.falcon@intel.com>

On Fri, Dec 13, 2024 at 03:54:21PM -0600, Thomas Falcon wrote:
> perf script output may show different fields on different core PMU's
> that exist on heterogeneous platforms. For example,
> 
> perf record -e "{cpu_core/mem-loads-aux/,cpu_core/event=0xcd,\
> umask=0x01,ldlat=3,name=MEM_UOPS_RETIRED.LOAD_LATENCY/}:upp"\
> -c10000 -W -d -a -- sleep 1
> 
> perf script:
> 
> chromium-browse   46572 [002] 544966.882384:      10000 	cpu_core/MEM_UOPS_RETIRED.LOAD_LATENCY/: 7ffdf1391b0c     10268100142 \
>  |OP LOAD|LVL L1 hit|SNP None|TLB L1 or L2 hit|LCK No|BLK    N/A    5   7    0   7fad7c47425d [unknown] (/usr/lib64/libglib-2.0.so.0.8000.3)
> 
> perf record -e cpu_atom/event=0xd0,umask=0x05,ldlat=3,\
> name=MEM_UOPS_RETIRED.LOAD_LATENCY/upp -c10000 -W -d -a -- sleep 1
> 
> perf script:
> 
> gnome-control-c  534224 [023] 544951.816227:      10000 cpu_atom/MEM_UOPS_RETIRED.LOAD_LATENCY/:   7f0aaaa0aae0  [unknown] (/usr/lib64/libglib-2.0.so.0.8000.3)
> 
> Some fields, such as data_src, are not included by default.
> 
> The cause is that while one PMU may be assigned a type such as
> PERF_TYPE_RAW, other core PMU's are dynamically allocated at boot time.
> If this value does not match an existing PERF_TYPE_X value,
> output_type(perf_event_attr.type) will return OUTPUT_TYPE_OTHER.
> 
> Instead search for a core PMU with a matching perf_event_attr type
> and, if one is found, return PERF_TYPE_RAW to match output of other
> core PMU's.
> 
> Suggested-by: Kan Liang <kan.liang@intel.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> ---
> v2: restrict pmu lookup to platforms with more than one core pmu
> v3: only scan core pmu list
> ---
>  tools/perf/builtin-script.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 9e47905f75a6..685232883f9c 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -384,6 +384,19 @@ static int evsel_script__fprintf(struct evsel_script *es, FILE *fp)
>  		       st.st_size / 1024.0 / 1024.0, es->filename, es->samples);
>  }
>  
> +static bool output_type_many_core_pmus(unsigned int type)
> +{
> +	struct perf_pmu *pmu = NULL;
> +
> +	if (perf_pmus__num_core_pmus() > 1) {
> +		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
> +			if (pmu->type == type)
> +				return true;
> +		}
> +	}
> +	return false;
> +}
> +
>  static inline int output_type(unsigned int type)
>  {
>  	switch (type) {
> @@ -394,6 +407,9 @@ static inline int output_type(unsigned int type)
>  			return type;
>  	}
>  
> +	if (output_type_many_core_pmus(type))
> +		return PERF_TYPE_RAW;
> +
>  	return OUTPUT_TYPE_OTHER;
>  }

Can you please test the patch below so that we don't do this while loop
in all calls to output_type when we have more than one core pmu?

I haven't tested this patch, so please see if your patch on top of it
produces the desired result.

- Arnaldo

From d3c64550a0365455980aaa9c567c4a6b8c10473a Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Fri, 20 Dec 2024 16:10:28 -0300
Subject: [PATCH 1/1] perf script: Cache the output type

Right now every time we need to figure out the type of an evsel for
output purposes we do a quick sequence of ifs, but there are new cases
where there is a need to do more complex iterations over multiple data
structures, sso allow for caching this operation on a hole of 'struct
evsel'.

This should really be done on the evsel->priv area that 'perf script'
sets up, but more work is needed to make sure that it is allocated when
we need it, right now it is only used for conditionally, add some
comments so that we move this to that 'perf script' specific area when
the conditions are in place for that.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 91 ++++++++++++++++++++-----------------
 tools/perf/util/evsel.c     |  1 +
 tools/perf/util/evsel.h     |  1 +
 3 files changed, 51 insertions(+), 42 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 6d5773539cfdf16e..33667b5346349268 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -221,6 +221,10 @@ enum {
 	OUTPUT_TYPE_MAX
 };
 
+// We need to refactor the evsel->priv use in in 'perf script' to allow for
+// using that area, that is being used only in some cases.
+#define OUTPUT_TYPE_UNSET -1
+
 /* default set to maintain compatibility with current format */
 static struct {
 	bool user_set;
@@ -394,6 +398,14 @@ static inline int output_type(unsigned int type)
 	return OUTPUT_TYPE_OTHER;
 }
 
+static inline int evsel__output_type(struct evsel *evsel)
+{
+	if (evsel->script_output_type == OUTPUT_TYPE_UNSET)
+		evsel->script_output_type = output_type(evsel->core.attr.type);
+
+	return evsel->script_output_type;
+}
+
 static bool output_set_by_user(void)
 {
 	int j;
@@ -418,13 +430,13 @@ static const char *output_field2str(enum perf_output_field field)
 	return str;
 }
 
-#define PRINT_FIELD(x)  (output[output_type(attr->type)].fields & PERF_OUTPUT_##x)
+#define PRINT_FIELD(x)  (output[evsel__output_type(evsel)].fields & PERF_OUTPUT_##x)
 
 static int evsel__do_check_stype(struct evsel *evsel, u64 sample_type, const char *sample_msg,
 				 enum perf_output_field field, bool allow_user_set)
 {
 	struct perf_event_attr *attr = &evsel->core.attr;
-	int type = output_type(attr->type);
+	int type = evsel__output_type(evsel);
 	const char *evname;
 
 	if (attr->sample_type & sample_type)
@@ -458,7 +470,6 @@ static int evsel__check_stype(struct evsel *evsel, u64 sample_type, const char *
 
 static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
 {
-	struct perf_event_attr *attr = &evsel->core.attr;
 	bool allow_user_set;
 
 	if (evsel__is_dummy_event(evsel))
@@ -575,9 +586,9 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
 	return 0;
 }
 
-static void set_print_ip_opts(struct perf_event_attr *attr)
+static void evsel__set_print_ip_opts(struct evsel *evsel)
 {
-	unsigned int type = output_type(attr->type);
+	unsigned int type = evsel__output_type(evsel);
 
 	output[type].print_ip_opts = 0;
 	if (PRINT_FIELD(IP))
@@ -607,7 +618,7 @@ static struct evsel *find_first_output_type(struct evlist *evlist,
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel__is_dummy_event(evsel))
 			continue;
-		if (output_type(evsel->core.attr.type) == (int)type)
+		if (evsel__output_type(evsel) == (int)type)
 			return evsel;
 	}
 	return NULL;
@@ -649,7 +660,7 @@ static int perf_session__check_output_opt(struct perf_session *session)
 		if (output[j].fields & PERF_OUTPUT_DSOFF)
 			output[j].fields |= PERF_OUTPUT_DSO;
 
-		set_print_ip_opts(&evsel->core.attr);
+		evsel__set_print_ip_opts(evsel);
 		tod |= output[j].fields & PERF_OUTPUT_TOD;
 	}
 
@@ -685,7 +696,7 @@ static int perf_session__check_output_opt(struct perf_session *session)
 				output[j].fields |= PERF_OUTPUT_SYM;
 				output[j].fields |= PERF_OUTPUT_SYMOFFSET;
 				output[j].fields |= PERF_OUTPUT_DSO;
-				set_print_ip_opts(&evsel->core.attr);
+				evsel__set_print_ip_opts(evsel);
 				goto out;
 			}
 		}
@@ -789,7 +800,6 @@ static int perf_sample__fprintf_start(struct perf_script *script,
 				      struct evsel *evsel,
 				      u32 type, FILE *fp)
 {
-	struct perf_event_attr *attr = &evsel->core.attr;
 	unsigned long secs;
 	unsigned long long nsecs;
 	int printed = 0;
@@ -941,7 +951,7 @@ static int print_bstack_flags(FILE *fp, struct branch_entry *br)
 
 static int perf_sample__fprintf_brstack(struct perf_sample *sample,
 					struct thread *thread,
-					struct perf_event_attr *attr, FILE *fp)
+					struct evsel *evsel, FILE *fp)
 {
 	struct branch_stack *br = sample->branch_stack;
 	struct branch_entry *entries = perf_sample__branch_entries(sample);
@@ -980,7 +990,7 @@ static int perf_sample__fprintf_brstack(struct perf_sample *sample,
 
 static int perf_sample__fprintf_brstacksym(struct perf_sample *sample,
 					   struct thread *thread,
-					   struct perf_event_attr *attr, FILE *fp)
+					   struct evsel *evsel, FILE *fp)
 {
 	struct branch_stack *br = sample->branch_stack;
 	struct branch_entry *entries = perf_sample__branch_entries(sample);
@@ -1018,7 +1028,7 @@ static int perf_sample__fprintf_brstacksym(struct perf_sample *sample,
 
 static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
 					   struct thread *thread,
-					   struct perf_event_attr *attr, FILE *fp)
+					   struct evsel *evsel, FILE *fp)
 {
 	struct branch_stack *br = sample->branch_stack;
 	struct branch_entry *entries = perf_sample__branch_entries(sample);
@@ -1185,7 +1195,7 @@ static int print_srccode(struct thread *thread, u8 cpumode, uint64_t addr)
 	return ret;
 }
 
-static int any_dump_insn(struct perf_event_attr *attr __maybe_unused,
+static int any_dump_insn(struct evsel *evsel __maybe_unused,
 			 struct perf_insn *x, uint64_t ip,
 			 u8 *inbuf, int inlen, int *lenp,
 			 FILE *fp)
@@ -1213,15 +1223,14 @@ static int add_padding(FILE *fp, int printed, int padding)
 static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
 			    struct perf_insn *x, u8 *inbuf, int len,
 			    int insn, FILE *fp, int *total_cycles,
-			    struct perf_event_attr *attr,
-			    struct thread *thread,
 			    struct evsel *evsel,
+			    struct thread *thread,
 			    u64 br_cntr)
 {
 	int ilen = 0;
 	int printed = fprintf(fp, "\t%016" PRIx64 "\t", ip);
 
-	printed += add_padding(fp, any_dump_insn(attr, x, ip, inbuf, len, &ilen, fp), 30);
+	printed += add_padding(fp, any_dump_insn(evsel, x, ip, inbuf, len, &ilen, fp), 30);
 	printed += fprintf(fp, "\t");
 
 	if (PRINT_FIELD(BRSTACKINSNLEN))
@@ -1277,7 +1286,7 @@ static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
 
 static int ip__fprintf_sym(uint64_t addr, struct thread *thread,
 			   u8 cpumode, int cpu, struct symbol **lastsym,
-			   struct perf_event_attr *attr, FILE *fp)
+			   struct evsel *evsel, FILE *fp)
 {
 	struct addr_location al;
 	int off, printed = 0, ret = 0;
@@ -1353,10 +1362,10 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 			machine, thread, &x.is64bit, &x.cpumode, false);
 	if (len > 0) {
 		printed += ip__fprintf_sym(entries[nr - 1].from, thread,
-					   x.cpumode, x.cpu, &lastsym, attr, fp);
+					   x.cpumode, x.cpu, &lastsym, evsel, fp);
 		printed += ip__fprintf_jump(entries[nr - 1].from, &entries[nr - 1],
 					    &x, buffer, len, 0, fp, &total_cycles,
-					    attr, thread, evsel, br_cntr);
+					    evsel, thread, br_cntr);
 		if (PRINT_FIELD(SRCCODE))
 			printed += print_srccode(thread, x.cpumode, entries[nr - 1].from);
 	}
@@ -1384,19 +1393,19 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 		for (off = 0; off < (unsigned)len; off += ilen) {
 			uint64_t ip = start + off;
 
-			printed += ip__fprintf_sym(ip, thread, x.cpumode, x.cpu, &lastsym, attr, fp);
+			printed += ip__fprintf_sym(ip, thread, x.cpumode, x.cpu, &lastsym, evsel, fp);
 			if (ip == end) {
 				if (PRINT_FIELD(BRCNTR) && sample->branch_stack_cntr)
 					br_cntr = sample->branch_stack_cntr[i];
 				printed += ip__fprintf_jump(ip, &entries[i], &x, buffer + off, len - off, ++insn, fp,
-							    &total_cycles, attr, thread, evsel, br_cntr);
+							    &total_cycles, evsel, thread, br_cntr);
 				if (PRINT_FIELD(SRCCODE))
 					printed += print_srccode(thread, x.cpumode, ip);
 				break;
 			} else {
 				ilen = 0;
 				printed += fprintf(fp, "\t%016" PRIx64 "\t", ip);
-				printed += any_dump_insn(attr, &x, ip, buffer + off, len - off, &ilen, fp);
+				printed += any_dump_insn(evsel, &x, ip, buffer + off, len - off, &ilen, fp);
 				if (PRINT_FIELD(BRSTACKINSNLEN))
 					printed += fprintf(fp, "\tilen: %d", ilen);
 				printed += fprintf(fp, "\n");
@@ -1435,7 +1444,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 		end = start + 128;
 	}
 	len = grab_bb(buffer, start, end, machine, thread, &x.is64bit, &x.cpumode, true);
-	printed += ip__fprintf_sym(start, thread, x.cpumode, x.cpu, &lastsym, attr, fp);
+	printed += ip__fprintf_sym(start, thread, x.cpumode, x.cpu, &lastsym, evsel, fp);
 	if (len <= 0) {
 		/* Print at least last IP if basic block did not work */
 		len = grab_bb(buffer, sample->ip, sample->ip,
@@ -1444,7 +1453,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 			goto out;
 		ilen = 0;
 		printed += fprintf(fp, "\t%016" PRIx64 "\t", sample->ip);
-		printed += any_dump_insn(attr, &x, sample->ip, buffer, len, &ilen, fp);
+		printed += any_dump_insn(evsel, &x, sample->ip, buffer, len, &ilen, fp);
 		if (PRINT_FIELD(BRSTACKINSNLEN))
 			printed += fprintf(fp, "\tilen: %d", ilen);
 		printed += fprintf(fp, "\n");
@@ -1455,7 +1464,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 	for (off = 0; off <= end - start; off += ilen) {
 		ilen = 0;
 		printed += fprintf(fp, "\t%016" PRIx64 "\t", start + off);
-		printed += any_dump_insn(attr, &x, start + off, buffer + off, len - off, &ilen, fp);
+		printed += any_dump_insn(evsel, &x, start + off, buffer + off, len - off, &ilen, fp);
 		if (PRINT_FIELD(BRSTACKINSNLEN))
 			printed += fprintf(fp, "\tilen: %d", ilen);
 		printed += fprintf(fp, "\n");
@@ -1479,13 +1488,13 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 
 static int perf_sample__fprintf_addr(struct perf_sample *sample,
 				     struct thread *thread,
-				     struct perf_event_attr *attr, FILE *fp)
+				     struct evsel *evsel, FILE *fp)
 {
 	struct addr_location al;
 	int printed = fprintf(fp, "%16" PRIx64, sample->addr);
 
 	addr_location__init(&al);
-	if (!sample_addr_correlates_sym(attr))
+	if (!sample_addr_correlates_sym(&evsel->core.attr))
 		goto out;
 
 	thread__resolve(thread, &al, sample);
@@ -1512,11 +1521,10 @@ static const char *resolve_branch_sym(struct perf_sample *sample,
 				      struct addr_location *addr_al,
 				      u64 *ip)
 {
-	struct perf_event_attr *attr = &evsel->core.attr;
 	const char *name = NULL;
 
 	if (sample->flags & (PERF_IP_FLAG_CALL | PERF_IP_FLAG_TRACE_BEGIN)) {
-		if (sample_addr_correlates_sym(attr)) {
+		if (sample_addr_correlates_sym(&evsel->core.attr)) {
 			if (!addr_al->thread)
 				thread__resolve(thread, addr_al, sample);
 			if (addr_al->sym)
@@ -1542,7 +1550,6 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
 					   struct addr_location *addr_al,
 					   FILE *fp)
 {
-	struct perf_event_attr *attr = &evsel->core.attr;
 	size_t depth = thread_stack__depth(thread, sample->cpu);
 	const char *name = NULL;
 	static int spacing;
@@ -1614,7 +1621,7 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
 }
 
 static int perf_sample__fprintf_ipc(struct perf_sample *sample,
-				    struct perf_event_attr *attr, FILE *fp)
+				    struct evsel *evsel, FILE *fp)
 {
 	unsigned int ipc;
 
@@ -1635,7 +1642,7 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
 				    struct machine *machine, FILE *fp)
 {
 	struct perf_event_attr *attr = &evsel->core.attr;
-	unsigned int type = output_type(attr->type);
+	unsigned int type = evsel__output_type(evsel);
 	bool print_srcline_last = false;
 	int printed = 0;
 
@@ -1672,10 +1679,10 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
 	    ((evsel->core.attr.sample_type & PERF_SAMPLE_ADDR) &&
 	     !output[type].user_set)) {
 		printed += fprintf(fp, " => ");
-		printed += perf_sample__fprintf_addr(sample, thread, attr, fp);
+		printed += perf_sample__fprintf_addr(sample, thread, evsel, fp);
 	}
 
-	printed += perf_sample__fprintf_ipc(sample, attr, fp);
+	printed += perf_sample__fprintf_ipc(sample, evsel, fp);
 
 	if (print_srcline_last)
 		printed += map__fprintf_srcline(al->map, al->addr, "\n  ", fp);
@@ -2157,7 +2164,7 @@ static void process_event(struct perf_script *script,
 {
 	struct thread *thread = al->thread;
 	struct perf_event_attr *attr = &evsel->core.attr;
-	unsigned int type = output_type(attr->type);
+	unsigned int type = evsel__output_type(evsel);
 	struct evsel_script *es = evsel->priv;
 	FILE *fp = es->fp;
 	char str[PAGE_SIZE_NAME_LEN];
@@ -2205,7 +2212,7 @@ static void process_event(struct perf_script *script,
 		perf_sample__fprintf_synth(sample, evsel, fp);
 
 	if (PRINT_FIELD(ADDR))
-		perf_sample__fprintf_addr(sample, thread, attr, fp);
+		perf_sample__fprintf_addr(sample, thread, evsel, fp);
 
 	if (PRINT_FIELD(DATA_SRC))
 		data_src__fprintf(sample->data_src, fp);
@@ -2255,11 +2262,11 @@ static void process_event(struct perf_script *script,
 		perf_sample__fprintf_uregs(sample, attr, arch, fp);
 
 	if (PRINT_FIELD(BRSTACK))
-		perf_sample__fprintf_brstack(sample, thread, attr, fp);
+		perf_sample__fprintf_brstack(sample, thread, evsel, fp);
 	else if (PRINT_FIELD(BRSTACKSYM))
-		perf_sample__fprintf_brstacksym(sample, thread, attr, fp);
+		perf_sample__fprintf_brstacksym(sample, thread, evsel, fp);
 	else if (PRINT_FIELD(BRSTACKOFF))
-		perf_sample__fprintf_brstackoff(sample, thread, attr, fp);
+		perf_sample__fprintf_brstackoff(sample, thread, evsel, fp);
 
 	if (evsel__is_bpf_output(evsel) && PRINT_FIELD(BPF_OUTPUT))
 		perf_sample__fprintf_bpf_output(sample, fp);
@@ -2274,7 +2281,7 @@ static void process_event(struct perf_script *script,
 	if (PRINT_FIELD(CODE_PAGE_SIZE))
 		fprintf(fp, " %s", get_page_size_name(sample->code_page_size, str));
 
-	perf_sample__fprintf_ipc(sample, attr, fp);
+	perf_sample__fprintf_ipc(sample, evsel, fp);
 
 	fprintf(fp, "\n");
 
@@ -2507,14 +2514,14 @@ static int process_attr(const struct perf_tool *tool, union perf_event *event,
 	     sample_type & PERF_SAMPLE_BRANCH_STACK ||
 	     (sample_type & PERF_SAMPLE_REGS_USER &&
 	      sample_type & PERF_SAMPLE_STACK_USER))) {
-		int type = output_type(evsel->core.attr.type);
+		int type = evsel__output_type(evsel);
 
 		if (!(output[type].user_unset_fields & PERF_OUTPUT_IP))
 			output[type].fields |= PERF_OUTPUT_IP;
 		if (!(output[type].user_unset_fields & PERF_OUTPUT_SYM))
 			output[type].fields |= PERF_OUTPUT_SYM;
 	}
-	set_print_ip_opts(&evsel->core.attr);
+	evsel__set_print_ip_opts(evsel);
 	return 0;
 }
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6ae5d110994a0322..697428efa644aa36 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -395,6 +395,7 @@ void evsel__init(struct evsel *evsel,
 	evsel->group_pmu_name = NULL;
 	evsel->skippable     = false;
 	evsel->alternate_hw_config = PERF_COUNT_HW_MAX;
+	evsel->script_output_type = -1; // FIXME: OUTPUT_TYPE_UNSET, see builtin-script.c
 }
 
 struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 5ad352c94d00f7b2..5e789fa80590b6f4 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -121,6 +121,7 @@ struct evsel {
 	bool			default_metricgroup; /* A member of the Default metricgroup */
 	struct hashmap		*per_pkg_mask;
 	int			err;
+	int			script_output_type;
 	struct {
 		evsel__sb_cb_t	*cb;
 		void		*data;
-- 
2.47.0

