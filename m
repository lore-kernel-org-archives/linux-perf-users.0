Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793383789;
	b=DSULxW75oKxDqa7YkTFu8ypo4DjvhujOhio8+x1Eswt7qp4btbZZWb2M89iJ67Kt9eyr
	 24nsu8DN3sx28NtbzBWzgJ+eCBZe7HOGbdM0aEz2zjP7DcRvueOb2nz6ZVljUmZCW5siP
	 LU9c+xaYGtlYeoTwu6USde6kWv7JzHGi9oC29BCAspB7PmNfZKA0wMrKI+UvH0ag03G/m
	 djNxEz0vsRAsD9Z2DbXACCOEv/6PhOBoW9j3C4Fx5FuwSbwPjTVTRFB2bEQHtKuoRAhFA
	 riYnz7Fb1RWqOvnRnmEmy0cPrPc1RWsPJEJ2LZaAyOOhStbsZHGX6TxfTF8ogkGh8tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793383789;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=V8Rmf3mQZbIxWgdNvUXNQ+2GFF6B2pZgslpxwUibTuI=;
	b=N6g8F9FZLRDkHz1l4Pyh3QnZ4wcGCQALqFFS+ZsQLQMw9JBQ9ssWFzoQdAdGS0QbFtwc
	 7HQU0g93BtO6gvrsW0wm3Hw8k0PyQcIGDXPVxngRVqxvKYTufROTghzKhVtpixmSTq1Up
	 PEVHVCkAORXEEREPIagsaiov+cnwwCrDlhvg6jwbgW2rlnwHmBdLGy15tt7RTgheue6ye
	 BM76+/ibOlhh6u7L73vfxzPTsnxJSQqAN5lE6XtFX6DKpd/1cQzkw2LlOb9h95mSBcFax
	 cs5Yz4QRjUUipUpZPOhYn+VUlE3xgVsPszL+wEenXd0zOdGHTy3w+dIfzKRUbVxdinQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qzkeojff;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4770606A31E
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 18:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qzkeojff
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2751F000C1;
	Fri, 30 Oct 2026 18:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793383788;
	bh=V8Rmf3mQZbIxWgdNvUXNQ+2GFF6B2pZgslpxwUibTuI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qzkeojff0zigNYRze5LVelw/tqjzjuC9LorR+u4ClOFhskcp/6xtFsJ0Bpjz8z8ik
	 aa18Dnr+t2L6c/MtpKDEIzzqbGi68w+c+4NKxPeWf5O8UIQIw9QMDKAvNbmCkxMQb+
	 OTZY/pnhabV2Zqv4R0WaeL8ORsRXu/JSPks4bgVepiBoRrfzEMivJNGcU4i6sO2Ef9
	 iHWC/lalpJKtQAx6kXvv3+X5TB1M5fi1Ms20Rx1p9brrO75zjrl2ozSFLAEy1XJWEo
	 lAbo8an190bMXyT6GOaTs71Zsxf8vmPRhPcyXqezY8Q7il72ok6pX7l8QGGgPmi7dk
	 tkS66QhdQMeYQ==
Message-ID: <sashiko-outbox-191394@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/9] perf evsel: Name a merged uncore counter after
 all of its PMUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Besar Wicaksono" <bwicaksono@nvidia.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030174816.1544471-9-bwicaksono@nvidia.com>
References: <20261030174816.1544471-1-bwicaksono@nvidia.com>
 <20261030174816.1544471-9-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 18:09:47 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf evsel: evlist__uniquify_evsel_names() renames unmerged coun=
ters
--

commit 570949b12b356d4f0d3d0c5c530601e5cc91533f
Author: Besar Wicaksono <bwicaksono@nvidia.com>

perf evsel: Name a merged uncore counter after all of its PMUs

This commit renames merged uncore counters to reflect all of their underlyi=
ng
PMU instances, either by stripping a numeric suffix or by replacing differi=
ng
numbers with a wildcard when counters are aggregated.

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index c3d7847278106..6720d9dc5af74 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -2767,7 +2767,7 @@ void evlist__uniquify_evsel_names(struct evlist *ev=
list, const struct perf_stat_
>  		struct evsel *pos;
> =20
>  		evlist__for_each_entry(evlist, pos)
> -			evsel__uniquify_counter(pos);
> +			evsel__uniquify_counter(pos, config->aggr_mode !=3D AGGR_NONE);
>  	}
>  }

[Severity: Medium]
Can passing config->aggr_mode !=3D AGGR_NONE here cause unmerged uncore cou=
nters
to be renamed with the merged PMU name in perf stat --no-aggr, perf record,
and perf top?

In tools/perf/util/config.c, the global stat_config is initialized with
aggr_mode =3D AGGR_GLOBAL.

In tools/perf/builtin-stat.c, cmd_stat() parses command-line options before
updating stat_config.aggr_mode:

	argc =3D parse_options_subcommand(argc, argv, stat_options, stat_subcomman=
ds,
					(const char **) stat_usage,
					PARSE_OPT_STOP_AT_NON_OPTION);

	stat_config.aggr_mode =3D opt_aggr_mode_to_aggr_mode(&opt_mode);

When -e parses an event group that requires regrouping across PMUs,
__parse_events() in tools/perf/util/parse-events.c calls
evlist__uniquify_evsel_names() while stat_config.aggr_mode is still
AGGR_GLOBAL:

	if (ret2 > 0 && warn_if_reordered && !parse_state.wild_card_pmus) {
		evlist__uniquify_evsel_names(evlist, &stat_config);
		pr_warning("WARNING: events were regrouped to match PMUs\n");

Even when --no-aggr was passed on the command line, this early call sees
config->aggr_mode !=3D AGGR_NONE, renames the first PMU instance to the mer=
ged
PMU name, and sets counter->uniquified_name =3D true in
evsel__uniquify_counter():

	/* The evsel was already uniquified. */
	if (counter->uniquified_name)
		return;

	/* Avoid checking to uniquify twice. */
	counter->uniquified_name =3D true;

When evlist__print_counters() later calls evlist__uniquify_evsel_names() wi=
th
AGGR_NONE, the first PMU instance returns early and keeps the merged wildca=
rd
or suffix-stripped name while the remaining instances are given their
individual PMU names.

Similarly, __cmd_record() in tools/perf/builtin-record.c and __cmd_top() in
tools/perf/builtin-top.c call evlist__uniquify_evsel_names() with the global
&stat_config:

	/*
	 * Use global stat_config that is zero meaning aggr_mode is AGGR_NONE
	 * and hybrid_merge is false.
	 */
	evlist__uniquify_evsel_names(rec->evlist, &stat_config);

Because stat_config.aggr_mode is actually AGGR_GLOBAL rather than AGGR_NONE,
wouldn't perf record and perf top also rename the first uncore PMU instance=
 as
if its counts were merged?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030174816.1544=
471-1-bwicaksono@nvidia.com?part=3D8
