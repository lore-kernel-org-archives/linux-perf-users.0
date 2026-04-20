Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4CF52F8B
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776646178; cv=none; b=bxrGzRiJjEqUxZ2VuO/c8cDv9aWL9TSM892qUWy4EzQ7uOG6e077CPFjtMP2pyOBs3mylmLOHVPODSp9bijrvb0b/S2kz4kaexFr5u30XspqCC2xn3r1HGyjpH9QMny8q9rIVkPynMNShiuaghZP1T2rJemRgSFAVJ9b64IjhsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776646178; c=relaxed/simple;
	bh=VhqAUc8TlrEpCRCqlF2s+k3SKZAGgEvGIIjJoxT47sQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VtC1MiJnCRaMWeY/6ySxgVr6z/aTd/lCs6weTHKuh26nEGw3CJPih474tvx7Ga9DravkrmG5cvfNE8l5zlitSEzxawn0YmsDy8plNpG2aZApFgu2+liaFwB+QMTggBNp9E9qpFgykMmbqy6uuLfra/sKVARUsQAMYtYg8HOXBkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAhWIIQS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAhWIIQS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B05C2BCAF;
	Mon, 20 Apr 2026 00:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776646178;
	bh=VhqAUc8TlrEpCRCqlF2s+k3SKZAGgEvGIIjJoxT47sQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=KAhWIIQSCyZitcXm2/5CFb+FkMQLl5cnLgJdFZv1Y0sSUZ6DsjD08gvsguiSnVDpW
	 P5Lu6zQDEg17VpimzvD/G5Knr6XF3PuSh7XRXfNHRK+oAJJE0SO3FGd0uxrFTkJ0Sz
	 E1knc95EpdWz/rwcd/XrhXjdNcYsAsy3RNbEodJzObj1E3Cit98IwROEoYFDe2eZAb
	 wZky9mxEHsY9Dl9FBA3bSeqiOrODusiel5LxCVwIY7ExxPc9grllwam2C93yERqKXx
	 L3NliNnYAjDdmF1g2jaYIaYNVzrW54R6YCnCAqahoLbBc3UdZt/qF4Aol7XgR+B/5+
	 ESULOWzMn/dHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 01/58] perf inject: Fix itrace branch stack synthesis
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-2-irogers@google.com>
References: <20260419235911.2186050-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:49:38 +0000
Message-Id: <20260420004938.80B05C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [Critical] Heap Buffer Overflow in `perf_event__repipe_sample` during bra=
nch stack synthesis.
- [High] Out-of-bounds Read and Data Corruption when synthesizing branch st=
acks.
- [High] File Format Corruption due to late `evsel` header modifications mi=
ssing in repiped events.
- [High] Deterministic NULL pointer dereference in `intel_pt_do_synth_pebs_=
sample`.
--

commit 375a716cafb1fd48c72a0867749d4d08171b6adb
Author: Ian Rogers <irogers@google.com>

perf inject: Fix itrace branch stack synthesis
   =20
When using "perf inject --itrace=3DL" to synthesize branch stacks from
AUX data, several issues caused failures.

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index f174bc69cec45..9da334740017b 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -375,7 +375,52 @@ static int perf_event__repipe_sample(const struct pe=
rf_tool *tool,

[ ... ]

> +		if (inject->itrace_synth_opts.add_last_branch) {
> +			/* Temporarily add in type bits for synthesis. */
> +			evsel->core.attr.sample_type |=3D PERF_SAMPLE_BRANCH_STACK;
> +			evsel->core.attr.branch_sample_type |=3D PERF_SAMPLE_BRANCH_HW_INDEX;
> +			evsel->core.attr.sample_type &=3D ~PERF_SAMPLE_AUX;
> +		}
> +
> +		sz =3D perf_event__sample_event_size(sample, evsel->core.attr.sample_t=
ype,
> +						   evsel->core.attr.read_format);

Does this code overflow event_copy?=20

If a large event near PERF_SAMPLE_MAX_SIZE is processed and add_last_branch
is set, adding PERF_SAMPLE_BRANCH_STACK causes the recalculated sz to exceed
65536 bytes.=20

perf_event__synthesize_sample() would then write out of bounds into the hea=
p.

[ ... ]

> @@ -2434,12 +2479,26 @@ static int __cmd_inject(struct perf_inject *injec=
t)

[ ... ]

>  		if (inject->itrace_synth_opts.set) {
> +			struct evsel *evsel;
> +
>  			perf_header__clear_feat(&session->header,
>  						HEADER_AUXTRACE);
> +
> +			evlist__for_each_entry(session->evlist, evsel) {
> +				evsel->core.attr.sample_type &=3D ~PERF_SAMPLE_AUX;
> +			}
> +
>  			if (inject->itrace_synth_opts.last_branch ||
> -			    inject->itrace_synth_opts.add_last_branch)
> +			    inject->itrace_synth_opts.add_last_branch) {
>  				perf_header__set_feat(&session->header,
>  						      HEADER_BRANCH_STACK);
> +
> +				evlist__for_each_entry(session->evlist, evsel) {
> +					evsel->core.attr.sample_type |=3D PERF_SAMPLE_BRANCH_STACK;
> +					evsel->core.attr.branch_sample_type |=3D
> +						PERF_SAMPLE_BRANCH_HW_INDEX;
> +				}
> +			}
>  		}

Can moving this attribute modification to just before writing the file head=
er
corrupt the output?

During perf_event__repipe_sample(), if itrace_synth_opts.last_branch is true
but add_last_branch is false, the event is synthesized and written using its
original sample_type. Additionally, this skips the fallback call to
perf_inject__cut_auxtrace_sample(), leaving PERF_SAMPLE_AUX data intact.

When the file header is subsequently written with the modified attributes
here, it advertises that all events contain branch stacks and lack AUX data,
causing a structural mismatch between the global header and the payload.

> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index fc9eec8b54b82..b9fcf3b457b0d 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -2557,7 +2557,8 @@ static int intel_pt_do_synth_pebs_sample(struct int=
el_pt_queue *ptq, struct evse
>  		sample.transaction =3D txn;
>  	}
> =20
> -	ret =3D intel_pt_deliver_synth_event(pt, event, &sample, sample_type);
> +	ret =3D intel_pt_deliver_synth_event(pt, event, &sample,
> +					   sample_type | evsel->synth_sample_type);

Could this cause a NULL pointer dereference in perf_event__sample_event_siz=
e()
which is called during event delivery?

If PERF_SAMPLE_BRANCH_STACK is present in evsel->synth_sample_type but
missing from evsel->core.attr.sample_type, sample.branch_stack will be NULL.

However, because the bit is set in the type passed to
intel_pt_deliver_synth_event(), the branch_stack pointer is dereferenced
unconditionally.

> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index 85bee747f4cd2..33b530b73796b 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -1719,9 +1719,9 @@ int perf_event__synthesize_sample(union perf_event =
*event, u64 type, u64 read_fo
> =20
>  	if (type & PERF_SAMPLE_BRANCH_STACK) {
>  		sz =3D sample->branch_stack->nr * sizeof(struct branch_entry);
> -		/* nr, hw_idx */
> -		sz +=3D 2 * sizeof(u64);
> -		memcpy(array, sample->branch_stack, sz);
> +		*array++ =3D sample->branch_stack->nr;
> +		*array++ =3D sample->branch_stack->hw_idx;
> +		memcpy(array, sample->branch_stack->entries, sz);
>  		array =3D (void *)array + sz;
>  	}

Are these reads safe for events that lack PERF_SAMPLE_BRANCH_HW_INDEX?

When an event lacks the hardware index, sample->branch_stack points directly
to the raw payload where hw_idx is omitted, meaning the entries array starts
8 bytes earlier (at offset 8 instead of 16).

Reading sample->branch_stack->hw_idx here will erroneously access the first
8 bytes of the first entry. Furthermore, sample->branch_stack->entries
evaluates to a pointer 8 bytes past the actual start of the entries, causing
the memcpy to read out of bounds at the end of the buffer.

Should this use the perf_sample__branch_entries() macro and check
sample->no_hw_idx instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D1
