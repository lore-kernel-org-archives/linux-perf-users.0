Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AC214AD20
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 04:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784177041; cv=none; b=tt+XTy8blqa6I9Zs2EESsGXxnPBRI8KG4AJ0uRruyF8O8KKlYaEvh5CSsREfKgB/Cb+d+pm1OGa6ElJyXU6hjWact8auD0NixJlLiNBPCnFqCvuRIBI1t+RwQryAkMXWbgf2Xn5xoMnta9diS9XtjKcnwktHHXx5j6E7RWfKQ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784177041; c=relaxed/simple;
	bh=k7QdkiUxJMCG4W6c8pg9SBRxATJswnrrOTMEYFYjlDM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e4XqIpHmcSBTRP9TyoziK8lXcmCUcgU2T6rM1zafTeIUlxVe3RN8h5MMljMa6zLm2pLA/GnJf8fdQDjakK3Anu7KIyaWt/z43qWk9l1v+C/PKwFF5JsPHfPKqWHXHnmlpt4Wrc+/1bFISRiateTyh7sRkJ1siyCmDO6TFGAvBsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ua1ASD4z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ua1ASD4z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71F91F00A3D;
	Thu, 16 Jul 2026 04:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784177040;
	bh=9z/dgHBcyt/FWMNLT4ypKrhYh9OS1J/Yi5yAY+nEyQ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ua1ASD4zgAKnW13CoBNi6F0/bzY4J83rp+J5Ov9//FKYztPQw9ov96bfiMi4D4Q1O
	 Q3izCRCrC2sBIJBm5bcxrJr4sLNjXzZA4WVplsqhJL4uLFHIiUejdVQw6w2uXnEc38
	 0zCmmibv55u0qODl5VuAanXpemiTE0DLeokixSCQDiu0t2rsniq7zappZi6NA9A6c4
	 A1v6nZ3O/WuAIsb2qJqroY9aO7Pdfmuwc+KmDUUwNmjZIB9fj7St19aw2jLOfzogO1
	 AevnKLfZgGJI+I8DWGIiMs/gdsYOb4jE/B/BkFlIzkHu6+9+u89dWFPjEKjBkVUirj
	 nKyzO5oYEmMEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/14] perf stat: Implement CSV formatting callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260716043223.388233-8-irogers@google.com>
References: <20260525231900.3527228-1-irogers@google.com>
 <20260716043223.388233-1-irogers@google.com>
 <20260716043223.388233-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 04:43:59 +0000
Message-Id: <20260716044359.D71F91F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

New issues:
- [High] Metric-only CSV formatting uses an arbitrary event from the evlist=
 to generate aggregation ID prefixes for all metrics, ignoring the metric's=
 actual parent event.
- [High] In metric-only mode, missing or failing metrics cause CSV column m=
isalignment.
- [High] CSV output silently drops the stdev_pct (noise) and cgroup columns=
, breaking backward compatibility for CSV parsers.
- [Medium] Casting away const to mutate config state.
- [Medium] csv_print_event() fails to filter out zero-valued events using s=
hould_skip_zero_counter(), leading to a flood of useless 0-count lines for =
uncore events.
- [Medium] The aggr_idx field of struct queued_metric is left uninitialized=
 when allocated in csv_print_metric.
- [Low] Missing direct POSIX header inclusions for <time.h> and <stdbool.h>.

Pre-existing issues:
- [High] Potential null pointer dereference in print_aggr_id_csv when threa=
d map or comm string is missing.
--

--- Patch [7]: [PATCH v3 07/14] perf stat: Implement CSV formatting callbac=
ks ---
commit 09929d045ae8af174aed0263f453cda8542e4ec1
Author: Ian Rogers <irogers@google.com>

perf stat: Implement CSV formatting callbacks

This patch implements CSV output formatting callbacks inside
util/stat-print-csv.c, replacing the empty stubs. It defines formatting
structures to buffer traversal streams and fully encapsulates CSV queued
lists lifecycle and deallocations.

> diff --git a/tools/perf/util/stat-print-csv.c b/tools/perf/util/stat-prin=
t-csv.c
> index ee86d07636ea6..35cd4505c6c16 100644
> --- a/tools/perf/util/stat-print-csv.c
> +++ b/tools/perf/util/stat-print-csv.c

[ ... ]

> +	case AGGR_THREAD:
> +		fprintf(output, "%s-%d%s",
> +			perf_thread_map__comm(evsel->core.threads, id.thread_idx),

[Severity: High]
This isn't a bug introduced by this patch, but can this unconditionally
dereference evsel->core.threads? If the thread map or comm string is
missing, it could cause a null pointer dereference.

> +			perf_thread_map__pid(evsel->core.threads, id.thread_idx), sep);
> +		break;

[ ... ]

> +static int csv_print_event(void *ctx, const struct perf_stat_config *con=
fig __maybe_unused,
> +			   struct evsel *evsel, int aggr_idx, u64 val, u64 ena, u64 run,
> +			   double stdev_pct __maybe_unused)

[Severity: Medium]
Should this code filter out zero-valued events using should_skip_zero_count=
er()
before enqueueing the event? Without it, uncore zero-counts might bypass
filtering and pollute the output.

[Severity: High]
Does this silently drop the stdev_pct (noise) and cgroup columns? The noise
variance is explicitly ignored here, which could break backward compatibili=
ty
for downstream CSV parsers.

> +{
> +	struct csv_print_state *ps =3D ctx;
> +	struct queued_event *ev =3D malloc(sizeof(*ev));

[ ... ]

> +static int csv_print_metric(void *ctx, const struct perf_stat_config *co=
nfig __maybe_unused,
> +			    struct evsel *evsel __maybe_unused, int aggr_idx __maybe_unused,
> +			    const char *name, const char *unit, double val,
> +			    enum metric_threshold_classify thresh __maybe_unused)
> +{
> +	struct csv_print_state *ps =3D ctx;
> +	struct queued_metric *b;
> +
> +	if (!ps->current_event)
> +		return 0;
> +
> +	if (evsel !=3D ps->current_event->evsel) {
> +		pr_err("decoupled print engine: temporal coupling violation: evsel mis=
match!\n");
> +		return -EINVAL;
> +	}
> +
> +	b =3D malloc(sizeof(*b));

[Severity: Medium]
Is the aggr_idx field of struct queued_metric left uninitialized after
allocation? Leaving this uninitialized could cause unexpected behavior if
accessed later.

> +	if (!b)
> +		return -ENOMEM;
> +
> +	b->name =3D strdup(name);

[ ... ]

> +		fprintf(output, "%s", ev->name);
> +
> +		if (ev->run !=3D ev->ena)
> +			enabled_percent =3D 100.0 * ev->run / ev->ena;
> +		fprintf(output, "%s%" PRIu64 "%s%.2f", sep, ev->run, sep, enabled_perc=
ent);

[Severity: High]
Are we missing the stdev_pct (noise) and cgroup columns in the final output?
Event printing finishes here without including them, which could break
backward compatibility for CSV parsers.

> +
> +		/* Print metrics */
> +		has_metrics =3D false;

[ ... ]

> +static int csv_metric_only_print_metric(void *ctx,
> +					const struct perf_stat_config *config __maybe_unused,
> +					struct evsel *evsel __maybe_unused, int aggr_idx,

[Severity: High]
Is the actual evsel parameter ignored here rather than being saved? This se=
ems
to discard the metric's actual parent event.

> +					const char *name, const char *unit, double val,
> +					enum metric_threshold_classify thresh __maybe_unused)
> +{
> +	struct csv_metric_only_print_state *ps =3D ctx;

[ ... ]

> +				fprintf(output, "%s%s", header_name, sep);
> +				free(header_name);
> +			}
> +		}
> +		fprintf(output, "\n");
> +		((struct perf_stat_config *)config)->metric_only_headers_printed =3D t=
rue;

[Severity: Medium]
Is it safe to cast away const to mutate the config state here? This modifies
metric_only_headers_printed on a const pointer, which might cause undefined
behavior.

> +	}
> +
> +	/* Print values */
> +	list_for_each_entry_safe(b, tmp, &ps->queued_metrics, list) {
> +		if (b->aggr_idx !=3D current_aggr) {
> +			if (current_aggr !=3D -2)
> +				fprintf(output, "\n");
> +			current_aggr =3D b->aggr_idx;
> +			if (config->interval && ps->timestamp[0])
> +				fprintf(output, "%s", ps->timestamp);
> +			if (config->aggr_map && current_aggr >=3D 0) {
> +				struct aggr_cpu_id id =3D config->aggr_map->map[current_aggr];
> +				struct evsel *mock_evsel =3D list_first_entry(
> +					&ps->evlist->core.entries, struct evsel, core.node);

[Severity: High]
Does this code use an arbitrary event from the evlist to generate aggregati=
on
ID prefixes for all metrics, ignoring the metric's actual parent event?
Relying on a mocked event's thread maps could result in incorrectly generat=
ed
CSV aggregation headers for heterogeneous evlists.

> +				int aggr_nr =3D 0;
> +
> +				if (mock_evsel->stats && mock_evsel->stats->aggr)
> +					aggr_nr =3D mock_evsel->stats->aggr[current_aggr].nr;
> +
> +				print_aggr_id_csv(config, output, mock_evsel, id, aggr_nr);
> +			}
> +		}
> +		fprintf(output, "%.1f%s", b->val, sep);

[Severity: High]
Will missing or failing metrics cause CSV column misalignment here? Values
seem to be printed sequentially without column matching, which could shift
all subsequent row elements leftward if a dynamic metric is omitted.

> +
> +		list_del(&b->list);
> +		free(b->name);

[ ... ]

> +int perf_stat__print_csv(struct evlist *evlist, const struct perf_stat_c=
onfig *config,
> +			 const struct target *target, const struct timespec *ts, int argc,
> +			 const char **argv)
> +{
> +	if (config->metric_only) {
> +		struct csv_metric_only_print_state ps =3D {
> +			.fp =3D config->output,
> +			.sep =3D config->csv_sep,
> +			.evlist =3D evlist,
> +		};
> +		if (config->interval && ts) {
> +			scnprintf(ps.timestamp, sizeof(ps.timestamp), "%lu.%09lu%s",
> +				  (unsigned long)ts->tv_sec, ts->tv_nsec, config->csv_sep);

[Severity: Low]
Are we missing direct POSIX header inclusions for <time.h> and <stdbool.h>?
struct timespec and boolean types are used in this file without explicit
inclusion, which violates musl libc compilation requirements.

> +		} else {
> +			ps.timestamp[0] =3D '\0';
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716043223.3882=
33-1-irogers@google.com?part=3D7
