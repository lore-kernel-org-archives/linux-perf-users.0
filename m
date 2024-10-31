Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83BE1CB316;
	Thu, 31 Oct 2024 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730402657; cv=none; b=bicR3aOcjePOjsWyXa8LXFuUSO4yjs7KZ21FSVHiUs+4qy7RCujk/wC+buUz7DVFu7tfeCLafc8i/Csdp4chkUtVwpZVT8wRkT1btCHHhH8AwmII/ddBthFUmg9Ve3qzr1nUUsr6xWI1xrDp+1hT4t3OAUgy9wgDeiTbsH3i4Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730402657; c=relaxed/simple;
	bh=WzpRpIob8QJ+SjaQ38OrD/oxcKrH/T/5ZQkzfobegfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heSsFy311iinHfFTLPJII2HFrxzOAuSI7nVTTa5LTWSDq017pzvcvYnns89zPwm1p1P+YQV/SQIj1/4euMHkctjc5DBhInsmGVINaXiXXeT8ifNT37KFuudpPpa0/9rOfI7d5oTGc51F8s2QDGpFLeoXSDgz2CrgPP6/11hcPcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbqrnSiR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbqrnSiR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52BAC4CED1;
	Thu, 31 Oct 2024 19:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730402657;
	bh=WzpRpIob8QJ+SjaQ38OrD/oxcKrH/T/5ZQkzfobegfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kbqrnSiRtA1aggiIf63a9U//G+uGJX52yNWbb0etaS+EPliwx3WawAsP90KmIlWsc
	 rG7RkGNPBQy3zcZbHi9EAGvH+sdgx9h9p7v7Sk3Px0NxG5kFSuFLaD16GAIethyZV0
	 ZNLdp7cpd6IYsG6/mq+0fdE/1YhGur+IDDHjWf2evMVSNSHl4/vbDFuFPNVBrQmFPK
	 BOfxWirXhMLs+Q+zyDAYb6cBdY1+jx364R2S+Kvg+x6Pydz2lO8cfFwzEXj3d2snGG
	 xA6kPiKJ6GHv1SS0jdApLx2NV+2+hIPtDdmGyPVxzf26ZdmajbvkM90tb1n3XdnNcY
	 B0jqmMoiwLmGg==
Date: Thu, 31 Oct 2024 16:24:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 05/21] perf kvm: Move functions used in util out of
 builtin
Message-ID: <ZyPZXUawgU9ZSGhP@x1>
References: <20241031014252.753588-1-irogers@google.com>
 <20241031014252.753588-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031014252.753588-6-irogers@google.com>

On Wed, Oct 30, 2024 at 06:42:36PM -0700, Ian Rogers wrote:
> The util library code is used by the python module but doesn't have
> access to the builtin files. Make a util/kvm-stat.c to match the
> kvm-stat.h file that declares the functions and move the functions
> there.

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-kvm.c   | 61 ---------------------------------
>  tools/perf/util/Build      |  1 +
>  tools/perf/util/kvm-stat.c | 70 ++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/kvm-stat.h |  3 ++
>  tools/perf/util/python.c   | 30 ----------------
>  5 files changed, 74 insertions(+), 91 deletions(-)
>  create mode 100644 tools/perf/util/kvm-stat.c
> 
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index 099ce3ebf67c..e50cd04e3725 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -615,67 +615,6 @@ static const char *get_filename_for_perf_kvm(void)
>  
>  #if defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
>  
> -void exit_event_get_key(struct evsel *evsel,
> -			struct perf_sample *sample,
> -			struct event_key *key)
> -{
> -	key->info = 0;
> -	key->key  = evsel__intval(evsel, sample, kvm_exit_reason);
> -}
> -
> -bool kvm_exit_event(struct evsel *evsel)
> -{
> -	return evsel__name_is(evsel, kvm_exit_trace);
> -}
> -
> -bool exit_event_begin(struct evsel *evsel,
> -		      struct perf_sample *sample, struct event_key *key)
> -{
> -	if (kvm_exit_event(evsel)) {
> -		exit_event_get_key(evsel, sample, key);
> -		return true;
> -	}
> -
> -	return false;
> -}
> -
> -bool kvm_entry_event(struct evsel *evsel)
> -{
> -	return evsel__name_is(evsel, kvm_entry_trace);
> -}
> -
> -bool exit_event_end(struct evsel *evsel,
> -		    struct perf_sample *sample __maybe_unused,
> -		    struct event_key *key __maybe_unused)
> -{
> -	return kvm_entry_event(evsel);
> -}
> -
> -static const char *get_exit_reason(struct perf_kvm_stat *kvm,
> -				   struct exit_reasons_table *tbl,
> -				   u64 exit_code)
> -{
> -	while (tbl->reason != NULL) {
> -		if (tbl->exit_code == exit_code)
> -			return tbl->reason;
> -		tbl++;
> -	}
> -
> -	pr_err("unknown kvm exit code:%lld on %s\n",
> -		(unsigned long long)exit_code, kvm->exit_reasons_isa);
> -	return "UNKNOWN";
> -}
> -
> -void exit_event_decode_key(struct perf_kvm_stat *kvm,
> -			   struct event_key *key,
> -			   char *decode)
> -{
> -	const char *exit_reason = get_exit_reason(kvm, key->exit_reasons,
> -						  key->key);
> -
> -	scnprintf(decode, KVM_EVENT_NAME_LEN, "%s", exit_reason);
> -}
> -
>  static bool register_kvm_events_ops(struct perf_kvm_stat *kvm)
>  {
>  	struct kvm_reg_events_ops *events_ops = kvm_reg_events_ops;
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 1eedead5f2f2..650974413849 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -120,6 +120,7 @@ perf-util-y += spark.o
>  perf-util-y += topdown.o
>  perf-util-y += iostat.o
>  perf-util-y += stream.o
> +perf-util-y += kvm-stat.o
>  perf-util-$(CONFIG_AUXTRACE) += auxtrace.o
>  perf-util-$(CONFIG_AUXTRACE) += intel-pt-decoder/
>  perf-util-$(CONFIG_AUXTRACE) += intel-pt.o
> diff --git a/tools/perf/util/kvm-stat.c b/tools/perf/util/kvm-stat.c
> new file mode 100644
> index 000000000000..38ace736db5c
> --- /dev/null
> +++ b/tools/perf/util/kvm-stat.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "debug.h"
> +#include "evsel.h"
> +#include "kvm-stat.h"
> +
> +#if defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
> +
> +bool kvm_exit_event(struct evsel *evsel)
> +{
> +	return evsel__name_is(evsel, kvm_exit_trace);
> +}
> +
> +void exit_event_get_key(struct evsel *evsel,
> +			struct perf_sample *sample,
> +			struct event_key *key)
> +{
> +	key->info = 0;
> +	key->key  = evsel__intval(evsel, sample, kvm_exit_reason);
> +}
> +
> +
> +bool exit_event_begin(struct evsel *evsel,
> +		      struct perf_sample *sample, struct event_key *key)
> +{
> +	if (kvm_exit_event(evsel)) {
> +		exit_event_get_key(evsel, sample, key);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +bool kvm_entry_event(struct evsel *evsel)
> +{
> +	return evsel__name_is(evsel, kvm_entry_trace);
> +}
> +
> +bool exit_event_end(struct evsel *evsel,
> +		    struct perf_sample *sample __maybe_unused,
> +		    struct event_key *key __maybe_unused)
> +{
> +	return kvm_entry_event(evsel);
> +}
> +
> +static const char *get_exit_reason(struct perf_kvm_stat *kvm,
> +				   struct exit_reasons_table *tbl,
> +				   u64 exit_code)
> +{
> +	while (tbl->reason != NULL) {
> +		if (tbl->exit_code == exit_code)
> +			return tbl->reason;
> +		tbl++;
> +	}
> +
> +	pr_err("unknown kvm exit code:%lld on %s\n",
> +		(unsigned long long)exit_code, kvm->exit_reasons_isa);
> +	return "UNKNOWN";
> +}
> +
> +void exit_event_decode_key(struct perf_kvm_stat *kvm,
> +			   struct event_key *key,
> +			   char *decode)
> +{
> +	const char *exit_reason = get_exit_reason(kvm, key->exit_reasons,
> +						  key->key);
> +
> +	scnprintf(decode, KVM_EVENT_NAME_LEN, "%s", exit_reason);
> +}
> +
> +#endif
> diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
> index 3e9ac754c3d1..4249542544bb 100644
> --- a/tools/perf/util/kvm-stat.h
> +++ b/tools/perf/util/kvm-stat.h
> @@ -115,6 +115,8 @@ struct kvm_reg_events_ops {
>  	struct kvm_events_ops *ops;
>  };
>  
> +#if defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
> +
>  void exit_event_get_key(struct evsel *evsel,
>  			struct perf_sample *sample,
>  			struct event_key *key);
> @@ -127,6 +129,7 @@ bool exit_event_end(struct evsel *evsel,
>  void exit_event_decode_key(struct perf_kvm_stat *kvm,
>  			   struct event_key *key,
>  			   char *decode);
> +#endif
>  
>  bool kvm_exit_event(struct evsel *evsel);
>  bool kvm_entry_event(struct evsel *evsel);
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 298f43981fc5..ab67abf3b607 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -1306,36 +1306,6 @@ PyMODINIT_FUNC PyInit_perf(void)
>  /* The following are stubs to avoid dragging in builtin-* objects. */
>  /* TODO: move the code out of the builtin-* file into util. */
>  
> -bool kvm_entry_event(struct evsel *evsel __maybe_unused)
> -{
> -	return false;
> -}
> -
> -bool kvm_exit_event(struct evsel *evsel __maybe_unused)
> -{
> -	return false;
> -}
> -
> -bool exit_event_begin(struct evsel *evsel __maybe_unused,
> -		      struct perf_sample *sample  __maybe_unused,
> -		      struct event_key *key  __maybe_unused)
> -{
> -	return false;
> -}
> -
> -bool exit_event_end(struct evsel *evsel __maybe_unused,
> -		    struct perf_sample *sample __maybe_unused,
> -		    struct event_key *key __maybe_unused)
> -{
> -	return false;
> -}
> -
> -void exit_event_decode_key(struct perf_kvm_stat *kvm __maybe_unused,
> -			   struct event_key *key __maybe_unused,
> -			   char *decode __maybe_unused)
> -{
> -}
> -
>  int find_scripts(char **scripts_array  __maybe_unused, char **scripts_path_array  __maybe_unused,
>  		int num  __maybe_unused, int pathlen __maybe_unused)
>  {
> -- 
> 2.47.0.163.g1226f6d8fa-goog
> 
