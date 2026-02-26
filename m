Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26FE2874E6;
	Thu, 26 Feb 2026 06:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772088611; cv=none; b=SrfLG8ARw1gMbFAFcZvPcXPEc+gZDK0q3kAljMTUs8in5rq+03u96EUVjS+rTfY9OhDWRWrZo2uEG00KZkyF8U4T7qWJ2lyu0XxtIhU7cn8HFJMFAwJWeizo3hNN6kj+bTMqIh4OS9AjVPI3mmxeQzjoYFutlnnCQpWx8qKt2lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772088611; c=relaxed/simple;
	bh=iK2ClZALasSVQLsXjwngoViqRlZPggGsyMLfFS4yAOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abjz4/DA5QcAZ5oImI4i/xuM0Y0by9gZ8JWloQIt/XuxiQnS2d0BfyKfmEVvHJ89Z9dYUh9vGSfH/fY0uHaOkw+VRtMZFR72u8UrIeKcYPvzvpMCB+K3wvahSVp/JSLj8Dz54W+uESrD2KCstQrZeFxvDRpUxYT20ym0nVatZ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h36YfHgc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h36YfHgc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0EEC19422;
	Thu, 26 Feb 2026 06:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772088610;
	bh=iK2ClZALasSVQLsXjwngoViqRlZPggGsyMLfFS4yAOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h36YfHgcqclnjcnW3Dn2udwrpsXo1t6rzz+ux0ypreb4Z8Fopxu3VTX+B9Q0rH8h1
	 yBrDJk62k7GP8xhu7rcS2sWId2fe40T1qBumWPOaMly/72dzH7eg4rtxZuzhVLxmud
	 6eBhb801T0eMPMfhXRo1eHhFBq0tNt+rgP6UXBqS6iny/D11mQblRfY0sjfQPOKTR+
	 5xO1wrAgSs1zJoH/vmU0STeQTshauFMqzb/PtmlxXkw0timJgunG7TwTtDZQ2gzWCm
	 xvYXMnOiIKHzdCABYK8usFQZ4BVZBci9buMMN1CqHOnLCyTv+ph8eURa61gAYNdUyK
	 M0ZnBKX94i6Sw==
Date: Wed, 25 Feb 2026 22:50:08 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Derek Foreman <derek.foreman@collabora.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Howard Chu <howardchu95@gmail.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Anubhav Shelat <ashelat@redhat.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Hrishikesh Suresh <hrishikesh123s@gmail.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/5] perf header: Refactor pipe mode end marker
 handling
Message-ID: <aZ_tIH4aW_XF-koQ@z2>
References: <20260226013534.2028272-1-irogers@google.com>
 <20260226013534.2028272-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260226013534.2028272-5-irogers@google.com>

On Wed, Feb 25, 2026 at 05:35:33PM -0800, Ian Rogers wrote:
> In non-pipe/data mode the header has a 256-bit bitmap representing
> whether a feature is enabled or not. In pipe mode features are written
> out in perf_event__synthesize_features as PERF_RECORD_HEADER_FEATURE
> events with a special zero sized marker for the last feature. If a new
> feature is added the last feature marker event appears as that feature
> from old pipe mode perf data. As the event is zero sized it will fail
> to be processed and generally terminate perf.
> 
> Add a last_feat variable to the header that in non-pipe/data mode is
> just HEADER_LAST_FEATURE. In pipe mode compute the last_feat by
> handling zero sized feature events, assuming they are the marker and
> updating last_feat accordingly. Potentially a feature event could be
> zero sized and so still process the feature event, just ignore the
> error if it fails.
> 
> As perf_event__process_feature can properly handle pipe mode data,
> migrate users to it except for report that still wants to group events
> with the last feature marker. Make perf_event__process_feature
> non-fatal in the case of a newer feature than this version of perf's
> HEADER_LAST_FEATURE, which was the behavior all users wanted.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-annotate.c       | 11 +-----
>  tools/perf/builtin-report.c         | 27 ++++++---------
>  tools/perf/builtin-script.c         | 11 +-----
>  tools/perf/util/data-convert-bt.c   |  9 ++---
>  tools/perf/util/data-convert-json.c | 12 +------
>  tools/perf/util/header.c            | 53 ++++++++++++++++++++++-------
>  tools/perf/util/header.h            |  4 ++-
>  tools/perf/util/intel-tpebs.c       | 11 +-----
>  8 files changed, 60 insertions(+), 78 deletions(-)
> 
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 9c27bb30b708..cf2d2011e148 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -313,15 +313,6 @@ static int process_sample_event(const struct perf_tool *tool,
>  	return ret;
>  }
>  
> -static int process_feature_event(const struct perf_tool *tool __maybe_unused,
> -				 struct perf_session *session,
> -				 union perf_event *event)
> -{
> -	if (event->feat.feat_id < HEADER_LAST_FEATURE)
> -		return perf_event__process_feature(session, event);
> -	return 0;
> -}
> -
>  static int hist_entry__stdio_annotate(struct hist_entry *he,
>  				    struct evsel *evsel,
>  				    struct perf_annotate *ann)
> @@ -876,7 +867,7 @@ int cmd_annotate(int argc, const char **argv)
>  	annotate.tool.id_index	= perf_event__process_id_index;
>  	annotate.tool.auxtrace_info	= perf_event__process_auxtrace_info;
>  	annotate.tool.auxtrace	= perf_event__process_auxtrace;
> -	annotate.tool.feature	= process_feature_event;
> +	annotate.tool.feature	= perf_event__process_feature;
>  	annotate.tool.ordering_requires_timestamps = true;
>  
>  	annotate.session = perf_session__new(&data, &annotate.tool);
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 3b81f4b3dc49..d1163f22648e 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -245,25 +245,18 @@ static int process_feature_event(const struct perf_tool *tool,
>  				 union perf_event *event)
>  {
>  	struct report *rep = container_of(tool, struct report, tool);
> +	int ret = perf_event__process_feature(tool, session, event);
>  
> -	if (event->feat.feat_id < HEADER_LAST_FEATURE)
> -		return perf_event__process_feature(session, event);
> -
> -	if (event->feat.feat_id != HEADER_LAST_FEATURE) {
> -		pr_err("failed: wrong feature ID: %" PRI_lu64 "\n",
> -		       event->feat.feat_id);
> -		return -1;
> -	} else if (rep->header_only) {
> -		session_done = 1;

It looks like this part is missing.  Still need to handle --header-only
option.


> +	if (ret == 0 && event->header.size == sizeof(struct perf_record_header_feature) &&
> +	    (int)event->feat.feat_id == session->header.last_feat) {
> +		/*
> +		 * (feat_id = HEADER_LAST_FEATURE) is the end marker which means
> +		 * all features are received, now we can force the group if
> +		 * needed.
> +		 */
> +		setup_forced_leader(rep, session->evlist);
>  	}
> -
> -	/*
> -	 * (feat_id = HEADER_LAST_FEATURE) is the end marker which
> -	 * means all features are received, now we can force the
> -	 * group if needed.
> -	 */
> -	setup_forced_leader(rep, session->evlist);
> -	return 0;
> +	return ret;
>  }
>  
>  static int process_sample_event(const struct perf_tool *tool,
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 7c743a303507..92b76ff24f16 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -3939,15 +3939,6 @@ int process_cpu_map_event(const struct perf_tool *tool,
>  	return set_maps(script);
>  }
>  
> -static int process_feature_event(const struct perf_tool *tool __maybe_unused,
> -				 struct perf_session *session,
> -				 union perf_event *event)
> -{
> -	if (event->feat.feat_id < HEADER_LAST_FEATURE)
> -		return perf_event__process_feature(session, event);
> -	return 0;
> -}
> -
>  static int perf_script__process_auxtrace_info(const struct perf_tool *tool,
>  					      struct perf_session *session,
>  					      union perf_event *event)
> @@ -4423,7 +4414,7 @@ int cmd_script(int argc, const char **argv)
>  #ifdef HAVE_LIBTRACEEVENT
>  	script.tool.tracing_data	 = perf_event__process_tracing_data;
>  #endif
> -	script.tool.feature		 = process_feature_event;
> +	script.tool.feature		 = perf_event__process_feature;
>  	script.tool.build_id		 = perf_event__process_build_id;
>  	script.tool.id_index		 = perf_event__process_id_index;
>  	script.tool.auxtrace_info	 = perf_script__process_auxtrace_info;
> diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
> index ba1c8e48d495..665bf8eea24b 100644
> --- a/tools/perf/util/data-convert-bt.c
> +++ b/tools/perf/util/data-convert-bt.c
> @@ -1412,13 +1412,10 @@ static int process_feature_event(const struct perf_tool *tool,
>  	struct convert *c = container_of(tool, struct convert, tool);
>  	struct ctf_writer *cw = &c->writer;
>  	struct perf_record_header_feature *fe = &event->feat;
> +	int ret = perf_event__process_feature(tool, session, event);
>  
> -	if (event->feat.feat_id < HEADER_LAST_FEATURE) {
> -		int ret = perf_event__process_feature(session, event);
> -
> -		if (ret)
> -			return ret;
> -	}
> +	if (ret)
> +		return ret;
>  
>  	switch (fe->feat_id) {
>  	case HEADER_HOSTNAME:
> diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
> index 6a626322476a..4b1b2f7bed25 100644
> --- a/tools/perf/util/data-convert-json.c
> +++ b/tools/perf/util/data-convert-json.c
> @@ -326,16 +326,6 @@ static void output_headers(struct perf_session *session, struct convert_json *c)
>  	output_json_format(out, false, 2, "]");
>  }
>  
> -static int process_feature_event(const struct perf_tool *tool __maybe_unused,
> -				 struct perf_session *session,
> -				 union perf_event *event)
> -{
> -	if (event->feat.feat_id < HEADER_LAST_FEATURE)
> -		return perf_event__process_feature(session, event);
> -
> -	return 0;
> -}
> -
>  int bt_convert__perf2json(const char *input_name, const char *output_name,
>  		struct perf_data_convert_opts *opts __maybe_unused)
>  {
> @@ -375,7 +365,7 @@ int bt_convert__perf2json(const char *input_name, const char *output_name,
>  	c.tool.auxtrace       = perf_event__process_auxtrace;
>  	c.tool.event_update   = perf_event__process_event_update;
>  	c.tool.attr           = perf_event__process_attr;
> -	c.tool.feature        = process_feature_event;
> +	c.tool.feature        = perf_event__process_feature;
>  	c.tool.ordering_requires_timestamps = true;
>  
>  	if (opts->all) {
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index fe5d21dde04f..7031f6c6bd66 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -3785,11 +3785,11 @@ static int perf_file_section__fprintf_info(struct perf_file_section *section,
>  	struct feat_fd ff;
>  
>  	if (lseek(fd, section->offset, SEEK_SET) == (off_t)-1) {
> -		pr_debug("Failed to lseek to %" PRIu64 " offset for feature "
> -				"%d, continuing...\n", section->offset, feat);
> +		pr_debug("Failed to lseek to %" PRIu64 " offset for feature %s (%d), continuing...\n",
> +			 section->offset, header_feat__name(feat), feat);
>  		return 0;
>  	}
> -	if (feat >= HEADER_LAST_FEATURE) {
> +	if (feat >= ph->last_feat) {
>  		pr_warning("unknown feature %d\n", feat);
>  		return 0;
>  	}
> @@ -3841,7 +3841,7 @@ int perf_header__fprintf_info(struct perf_session *session, FILE *fp, bool full)
>  		return 0;
>  
>  	fprintf(fp, "# missing features: ");
> -	for_each_clear_bit(bit, header->adds_features, HEADER_LAST_FEATURE) {
> +	for_each_clear_bit(bit, header->adds_features, header->last_feat) {
>  		if (bit)
>  			fprintf(fp, "%s ", feat_ops[bit].name);
>  	}
> @@ -4171,7 +4171,7 @@ int perf_header__process_sections(struct perf_header *header, int fd,
>  	if (err < 0)
>  		goto out_free;
>  
> -	for_each_set_bit(feat, header->adds_features, HEADER_LAST_FEATURE) {
> +	for_each_set_bit(feat, header->adds_features, header->last_feat) {
>  		err = process(sec++, header, feat, fd, data);
>  		if (err < 0)
>  			goto out_free;
> @@ -4386,6 +4386,7 @@ int perf_file_header__read(struct perf_file_header *header,
>  	ph->data_offset  = header->data.offset;
>  	ph->data_size	 = header->data.size;
>  	ph->feat_offset  = header->data.offset + header->data.size;
> +	ph->last_feat	 = HEADER_LAST_FEATURE;
>  	return 0;
>  }
>  
> @@ -4401,8 +4402,8 @@ static int perf_file_section__process(struct perf_file_section *section,
>  	};
>  
>  	if (lseek(fd, section->offset, SEEK_SET) == (off_t)-1) {
> -		pr_debug("Failed to lseek to %" PRIu64 " offset for feature "
> -			  "%d, continuing...\n", section->offset, feat);
> +		pr_debug("Failed to lseek to %" PRIu64 " offset for feature %s (%d), continuing...\n",
> +			 section->offset, header_feat__name(feat), feat);
>  		return 0;
>  	}
>  
> @@ -4435,6 +4436,8 @@ static int perf_file_header__read_pipe(struct perf_pipe_file_header *header,
>  	if (ph->needs_swap)
>  		header->size = bswap_64(header->size);
>  
> +	/* The last feature is written out as a 0 sized event and will update this value. */
> +	ph->last_feat = 0;
>  	return 0;
>  }
>  
> @@ -4667,31 +4670,55 @@ int perf_session__read_header(struct perf_session *session)
>  	return -ENOMEM;
>  }
>  
> -int perf_event__process_feature(struct perf_session *session,
> +int perf_event__process_feature(const struct perf_tool *tool __maybe_unused,
> +				struct perf_session *session,
>  				union perf_event *event)
>  {
>  	struct feat_fd ff = { .fd = 0 };
>  	struct perf_record_header_feature *fe = (struct perf_record_header_feature *)event;
> +	struct perf_header *header = &session->header;
>  	int type = fe->header.type;
> -	u64 feat = fe->feat_id;
> +	int feat = (int)fe->feat_id;
>  	int ret = 0;
>  	bool print = dump_trace;
> +	bool last_feature_mark = false;
>  
>  	if (type < 0 || type >= PERF_RECORD_HEADER_MAX) {
>  		pr_warning("invalid record type %d in pipe-mode\n", type);
>  		return 0;
>  	}
> -	if (feat == HEADER_RESERVED || feat >= HEADER_LAST_FEATURE) {
> -		pr_warning("invalid record type %d in pipe-mode\n", type);
> +	if (feat == HEADER_RESERVED) {
> +		pr_warning("invalid reserved record type in pipe-mode\n");
>  		return -1;
>  	}
> +	if (feat >= header->last_feat) {
> +		if (event->header.size == sizeof(*fe)) {
> +			// Either an unexpected zero size feature or the
> +			// HEADER_LAST_FEATURE mark.

Nit: I think we prefer C-style block comments.


> +			if (feat > header->last_feat)
> +				header->last_feat = min(feat, HEADER_LAST_FEATURE);
> +			last_feature_mark = true;
> +		} else {
> +			// A feature but beyond what is known as in
> +			// bounds. Assume the last feature is 1 beyond this
> +			// feature.

Ditto.

Thanks,
Namhyung


> +			session->header.last_feat = min(feat + 1, HEADER_LAST_FEATURE);
> +		}
> +	}
> +	if (feat >= HEADER_LAST_FEATURE) {
> +		pr_warning("unknown feature %d for data file version (%s) in this version of perf (%s)\n",
> +			   feat, header->env.version, perf_version_string);
> +		return 0;
> +	}
>  
>  	ff.buf  = (void *)fe->data;
>  	ff.size = event->header.size - sizeof(*fe);
> -	ff.ph = &session->header;
> +	ff.ph = header;
>  
>  	if (feat_ops[feat].process && feat_ops[feat].process(&ff, NULL)) {
> -		ret = -1;
> +		// Processing failed, ignore when this is the last feature mark.
> +		if (!last_feature_mark)
> +			ret = -1;
>  		goto out;
>  	}
>  
> diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
> index ca22030a1434..41ce663d93ff 100644
> --- a/tools/perf/util/header.h
> +++ b/tools/perf/util/header.h
> @@ -109,6 +109,7 @@ struct perf_header {
>  	u64				data_size;
>  	u64				feat_offset;
>  	DECLARE_BITMAP(adds_features, HEADER_FEAT_BITS);
> +	int				last_feat;
>  	struct perf_env 	env;
>  };
>  
> @@ -172,7 +173,8 @@ int perf_header__process_sections(struct perf_header *header, int fd,
>  
>  int perf_header__fprintf_info(struct perf_session *s, FILE *fp, bool full);
>  
> -int perf_event__process_feature(struct perf_session *session,
> +int perf_event__process_feature(const struct perf_tool *tool,
> +				struct perf_session *session,
>  				union perf_event *event);
>  int perf_event__process_attr(const struct perf_tool *tool, union perf_event *event,
>  			     struct evlist **pevlist);
> diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
> index 3c958d738ca6..f57ea6db02a0 100644
> --- a/tools/perf/util/intel-tpebs.c
> +++ b/tools/perf/util/intel-tpebs.c
> @@ -217,15 +217,6 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>  	return 0;
>  }
>  
> -static int process_feature_event(const struct perf_tool *tool __maybe_unused,
> -				 struct perf_session *session,
> -				 union perf_event *event)
> -{
> -	if (event->feat.feat_id < HEADER_LAST_FEATURE)
> -		return perf_event__process_feature(session, event);
> -	return 0;
> -}
> -
>  static void *__sample_reader(void *arg __maybe_unused)
>  {
>  	struct perf_session *session;
> @@ -238,7 +229,7 @@ static void *__sample_reader(void *arg __maybe_unused)
>  
>  	perf_tool__init(&tool, /*ordered_events=*/false);
>  	tool.sample = process_sample_event;
> -	tool.feature = process_feature_event;
> +	tool.feature = perf_event__process_feature;
>  	tool.attr = perf_event__process_attr;
>  
>  	session = perf_session__new(&data, &tool);
> -- 
> 2.53.0.414.gf7e9f6c205-goog
> 
