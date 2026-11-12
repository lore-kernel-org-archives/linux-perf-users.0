Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516268;
	b=WnxiP20rBgYVpJJwS0Z5IrRc3Dz3DrBk1c1ckc9a2iMWi+CIl65oKwpNOnCvYkv12NNM
	 EgDbsd+3wqftNB9X6BZ84MBo4Ao31gjBeqTY5qHuTa6dGGojSDz4LgH5lUUoz2LkrwYkT
	 /qb/IDMnz3QreTHQ3EzsqQybZSpyV5xpaPBKDRWSi1p6FkJATxPrPz2v3xHAHZ6bCMogZ
	 IAFFXDyvtFrUD6ha5KSuGmiADXQxAf6xxvlbn0u3y7EWJf3F6jawStVwRyXmNdhAKJCg6
	 4dJ6Xn4vno1ltwHN35lMMqgM54mgQYCzIyJ+PDZ4/ixvDU34f9Y4Lw3W67dLvv5fcHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516268;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TjYf+8dhnMIL9eCs/TWWFEfx5EUiKSDHs33bkVry97c=;
	b=Zx0kFVAc5zWXsglR72WbR/vRUfcZ6W/XTgjKJ4V7f/n104KXBNrsP85FI3wOgwsQnzN7
	 Td6rgcTTEjDibpV2BFrArxSqUzo1+v8zdjA8Lz6fZHMpclQgYip3xCFII4vXlSqxEaDOg
	 icbqhNYoXHnRht0OGstc272Rbo/qV33LVgGVszYVag+KHH46gcNzjptQeI4uSL3BCy7hK
	 Ped/SQtFvPOI9P2gNpkAVgPFEp5tTkhslq5O6557YCnraKJYrmEFbtc+7ByeM8tm2kzvx
	 5dSG+R4RtdXfjczJTvgh2u2WbNzqvJt6uLgE+1e8Uu5hWyz8flFd+K5V27IwatQk+pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kZM7+aNP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D841606D57C
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kZM7+aNP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A253E1F000C4;
	Thu, 12 Nov 2026 20:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794516267;
	bh=TjYf+8dhnMIL9eCs/TWWFEfx5EUiKSDHs33bkVry97c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kZM7+aNPV85Ct695bOmE9+vI2g0uBsQun54yjfx115SvLRllh6gFFHmdQFFAFtaVZ
	 m8sj0mBu5rV4eHvJ/puAybWwk3FV1arqLcMZkISAIax67ZDm74G9YVJL/2AjU6pIzw
	 oMJBy6zx1rpRUSyHkJPuQNiwpT0ts5mbJAJtZsSsnsdAag9ngnbRGQxCsOwvbfDaWf
	 xiQySgKR0rQG5xgARLpGMJc58YThD1eZVicUCkheltrfZAZv3XQJQyK5gFEkXhTiv/
	 yI44uHFMjOExSfvnkjXYPnzMT2XzXCSquCEH9z1BelHRxp2Z0jhzQWn9HEu2bSoiyE
	 LU+odi6PN9T3g==
Message-ID: <sashiko-outbox-211811@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] perf inject: Support piped data with
 --convert-callchain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Serhei Makarov" <serhei@serhei.io>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261112201833.78630-1-serhei@serhei.io>
References: <20261112201833.78630-1-serhei@serhei.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 20:44:27 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] perf inject: unstripped pipe attrs in cmd_inject() for
  file-to-pipe mode
- [Medium] perf inject: attr/sample mismatch for non-DWARF events in
  piped mode
- [Medium] perf inject: unchecked attr.size write in
  perf_event__repipe_attr()
- [Medium] perf inject: missing ordered_events flush in
  perf_event__repipe_oe_synth()
--

commit c6a36707bb63847953234da6d70009330a9ffc22
Author: Serhei Makarov <serhei@serhei.io>

perf inject: Support piped data with --convert-callchain

This commit enables piped input and output with --convert-callchain by
stripping DWARF user register and stack sample attributes in
perf_event__repipe_attr() and deferring the DWARF callchain check to
perf_event__convert_sample_callchain().

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index ce7562fc788c2..9fd02a6f5849f 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -229,6 +229,7 @@ static int perf_event__repipe_attr(const struct perf_=
tool *tool,
>  				   union perf_event *event,
>  				   struct evlist **pevlist)
>  {
> +	union perf_event *event0;
>  	struct perf_inject *inject =3D container_of(tool, struct perf_inject,
>  						  tool);
>  	struct perf_event_attr attr;
> @@ -258,6 +259,25 @@ static int perf_event__repipe_attr(const struct perf=
_tool *tool,
>  		goto out;
>  	}
> =20
> +	if (inject->convert_callchain) {
> +		/* Copy event to repipe with corrected final attributes,
> +		   without confusing downstream users of pevlist: */
> +		event0 =3D event;
> +		event =3D (void *)inject->event_copy;
> +		if (event =3D=3D NULL) {
> +			inject->event_copy =3D malloc(PERF_SAMPLE_MAX_SIZE);
> +			if (!inject->event_copy)
> +				return -ENOMEM;
> +			event =3D (void *)inject->event_copy;
> +		}
> +		memcpy(event, event0, event0->header.size);
> +
> +		event->attr.attr.sample_type &=3D ~(PERF_SAMPLE_REGS_USER | PERF_SAMPL=
E_STACK_USER);
> +		event->attr.attr.sample_regs_user =3D 0;
> +		event->attr.attr.sample_stack_user =3D 0;
> +		event->attr.attr.exclude_callchain_user =3D 0;
> +	}

[Severity: Medium]
Can clearing sample_regs_user and sample_stack_user here clobber the
trailing event ID array when event->attr.attr.size is smaller than
PERF_ATTR_SIZE_VER3?

A PERF_RECORD_HEADER_ATTR record places its u64 ID array immediately after
attr_size bytes (event->attr.attr.size ?: PERF_ATTR_SIZE_VER0), so writing
to sample_regs_user and sample_stack_user without checking attr_size
overwrites the event IDs in the repiped record for VER0, VER1, or VER2
attribute headers.

[ ... ]

> @@ -526,7 +558,7 @@ static int perf_event__convert_sample_callchain(const=
 struct perf_tool *tool,
>  {
>  	struct perf_inject *inject =3D container_of(tool, struct perf_inject, t=
ool);
>  	struct evsel *evsel =3D sample->evsel;
> -	struct callchain_cursor *cursor =3D get_tls_callchain_cursor();
> +	struct callchain_cursor *cursor;
>  	union perf_event *event_copy =3D (void *)inject->event_copy;
>  	struct callchain_cursor_node *node;
>  	struct thread *thread;
> @@ -535,6 +567,10 @@ static int perf_event__convert_sample_callchain(cons=
t struct perf_tool *tool,
>  	u64 i, k;
>  	int ret;
> =20
> +	if (!evsel__has_dwarf_callchain(evsel))
> +		return perf_event__repipe(tool, event, sample, machine);

[Severity: Medium]
Does repiping non-DWARF samples unchanged leave their payload out of sync
with the stripped perf_event_attr headers in piped mode?

For piped input, cmd_inject() skips the upfront evsel__has_dwarf_callchain()
validation, while both perf_event__repipe_attr() and __cmd_inject()
unconditionally clear PERF_SAMPLE_REGS_USER and PERF_SAMPLE_STACK_USER on
every event's attributes.  If a piped event has PERF_SAMPLE_REGS_USER or
PERF_SAMPLE_STACK_USER without a DWARF callchain,
perf_event__convert_sample_callchain() writes the original sample payload
containing user registers or stack data while the output attributes claim
those fields are absent, causing downstream sample parsing to fail.

[ ... ]

> @@ -2956,15 +2980,15 @@ int cmd_inject(int argc, const char **argv)
>  	if (inject.convert_callchain) {
>  		struct evsel *evsel;
> =20
> -		if (inject.output.is_pipe || inject.session->data->is_pipe) {
> -			pr_err("--convert-callchain cannot work with pipe\n");
> -			goto out_delete;
> -		}

[Severity: Medium]
When reading from an on-disk perf.data file and writing to a pipe (such as
perf inject -i perf.data --convert-callchain -o -), does cmd_inject() emit
unstripped PERF_RECORD_HEADER_ATTR records into the output pipe?

For non-pipe input (!data.is_pipe), perf_event__repipe_attr() is never
called; instead, cmd_inject() synthesizes the pipe's attribute headers
directly from inject.session->evlist:

tools/perf/builtin-inject.c:cmd_inject() {
    ...
		if (!data.is_pipe) {
			if (inject.aslr)
				aslr_tool__strip_evlist(tool, inject.session->evlist);

			ret =3D perf_event__synthesize_for_pipe(&inject.tool,
							      inject.session,
							      &inject.output,
							      perf_event__repipe);
    ...
}

Because inject.session->evlist still has PERF_SAMPLE_REGS_USER and
PERF_SAMPLE_STACK_USER set at that point while
perf_event__convert_sample_callchain() strips those fields from every
sample, the output pipe's attribute headers do not match its sample records
and downstream consumers fail with -EFAULT.

> -
> -		evlist__for_each_entry(inject.session->evlist, evsel) {
> -			if (!evsel__has_dwarf_callchain(evsel) && !evsel__is_dummy_event(evse=
l)) {
> -				pr_err("--convert-callchain requires DWARF call graph.\n");
> -				goto out_delete;
> +		/* For on-disk data, check evlist up-front.
> +		   For piped data, evlist is not available yet;
> +		   check in perf_event__convert_sample_callchain. */
> +		if (!inject.session->data->is_pipe) {
> +			evlist__for_each_entry(inject.session->evlist, evsel) {
> +				if (!evsel__has_dwarf_callchain(evsel) && !evsel__is_dummy_event(evs=
el)) {
> +					pr_err("--convert-callchain requires DWARF call graph.\n");
> +					goto out_delete;
> +				}
>  			}
>  		}

[Severity: Medium]
With piped input enabled for --convert-callchain, does leaving
inject.tool.finished_round set to perf_event__repipe_oe_synth() keep every
raw DWARF sample buffered in memory until EOF?

In __cmd_inject(), inject->convert_callchain enables
inject->tool.ordered_events, and __perf_session__process_pipe_events() turns
on copy_on_queue so every queued sample is duplicated onto the heap.  Becau=
se
perf_event__repipe_oe_synth() writes PERF_RECORD_FINISHED_ROUND directly to
the output without calling perf_event__process_finished_round() to flush
session->ordered_events, raw DWARF stack samples accumulate on the heap for
the entire session and all PERF_RECORD_FINISHED_ROUND events are emitted
ahead of the timestamped samples.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112201833.7863=
0-1-serhei@serhei.io?part=3D1
