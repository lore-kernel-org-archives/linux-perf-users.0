Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE3B3A6EFC
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266493; cv=none; b=VVf7UDRsMZoj3tjggUqySfWy9eOnyH29Lv5PW0ZG/4u41rvh51UHxt3DDWu7gX3luW7Lm4kBzDCtYE+8mHV4SSrAKcrY5Kf6Y4pjRO1Nu+IV3yGLwVK18j4sQ3glPtSSdYCT1g2xIf8fDt1MPkX0Ai4S0jgfYJm9kuE47ITt5zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266493; c=relaxed/simple;
	bh=ps0+x7v8o1h4E3fWbb3MftmOd0t4fPH3H7ubcRwieT4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ix1Dl1q6HHYjmMiukyceqj4KdG1Q+BNEvyIVjZaaBt+/XktqAotPBm+wb2NjHaQ+9fSzcigt9c9uZiPNDiF+HkTx37yjMl0Iq2/rimGFUx3wM/Pb3pPeucUB/iVNUewNfRZemhQ7K51DZw/NDaguYCnmCzb68kIMSnJvh6ZZsEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcuHHXFb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcuHHXFb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECFD1F000E9;
	Wed, 20 May 2026 08:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779266491;
	bh=dPu8pNwUzJsJZxG9zkfhSU0aZ7NNk4Se2VAPDWZ6eWM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JcuHHXFbk8ycJLt2I8QtWCojh8Ji27vV2IFxA0J+riJWotkw+pjC4Y8bTE7C2SC8s
	 HV9WV9Xpj6gh8Fcjx4CfPXsqqoXy51+WI/QyQzUcphZO06Je07iVN0lxlQ4sJrCjrY
	 TqT12HIzQPLtqzcShcXaBjGJ5aHfhVK7pjh1+g0jsCMa2XuyBVpgzIuii8gdjmuaQ2
	 ZlLiHYvgpsbC78w3vgu7gft6DLT5Y1fHBDl7KlJVcCUILOeBIbF4gKNmz6mWE12Q3v
	 qvxnrAPqYBJqQH/Msi1zQjcBTCOKsOPi+FpzGlcJPi236C+MTW8kfwPa7QJPrlGAy4
	 W5TmglBYPDZgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/4] perf aslr: Strip sample registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260520063050.3917261-5-irogers@google.com>
References: <20260520063050.3917261-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 08:41:27 +0000
Message-Id: <20260520084131.2ECFD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Restoring unstripped `evsel` attributes before delegating the stri=
pped sample event corrupts downstream processors.
- [High] In pipe mode, synthesized headers bypass `aslr_tool__process_attr`=
, causing the output stream to start with unstripped attributes.
- [High] The manual attribute stripping loop in `__cmd_inject` misses `bp_a=
ddr` and unsupported sample types, leaking ASLR data in the file header.
- [High] Stripping `sample_type` attributes during pipe mode inline attribu=
te processing corrupts subsequent input sample parsing.
- [Medium] Silently ignoring allocation failures when caching original attr=
ibutes leads to trace parsing desynchronization and potential out-of-bounds=
 reads.

Pre-existing issues:
- [Critical] Stack buffer overflow when copying a variable-length `perf_eve=
nt` into a statically sized `union perf_event` local variable.
--

commit fb30fb1bb4e2af08887645a167b8d9c8ef4d7b2b
Author: Ian Rogers <irogers@google.com>

perf aslr: Strip sample registers

When the ASLR tracking tool encounters sample events containing user
or interrupt register dumps, it previously dropped the entire sample event
conservatively to prevent absolute virtual memory pointers leakage.
Refactor the ASLR tool to strip out only the register dump payload by
masking out the relevant perf_event_attr fields when the delegated
tool is handling the data.

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index f42b315199b3d..a34902ff0e77b 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -239,6 +239,8 @@ static int perf_event__repipe_attr(const struct perf_=
tool *tool,
> =20
>  		memcpy(&stripped_event, event, event->header.size);

[Severity: Critical]
This is a pre-existing issue, but stripped_event is a statically sized union
on the stack.=20

Since PERF_RECORD_HEADER_ATTR events can be almost 64KB due to the
variable-length ID array, could copying event->header.size bytes cause a
massive stack buffer overflow?

>  		stripped_event.attr.attr.sample_type &=3D ASLR_SUPPORTED_SAMPLE_TYPE;
> +		stripped_event.attr.attr.sample_regs_user =3D 0;
> +		stripped_event.attr.attr.sample_regs_intr =3D 0;
>  		return perf_event__repipe_synth(tool, &stripped_event);
>  	}

[ ... ]

> @@ -2470,7 +2472,16 @@ static int __cmd_inject(struct perf_inject *inject)
>  			}
>  		}
> =20
> +		if (inject->aslr) {
> +			struct evsel *evsel;
> =20
> +			evlist__for_each_entry(session->evlist, evsel) {
> +				evsel__reset_sample_bit(evsel, REGS_USER);
> +				evsel__reset_sample_bit(evsel, REGS_INTR);
> +				evsel->core.attr.sample_regs_user =3D 0;
> +				evsel->core.attr.sample_regs_intr =3D 0;
> +			}
> +		}
> =20
>  		session->header.data_offset =3D output_data_offset;
>  		session->header.data_size =3D inject->bytes_written;

[Severity: High]
This loop strips REGS_USER and REGS_INTR before the file header is
serialized, but it doesn't clear bp_addr for breakpoints or apply the
ASLR_SUPPORTED_SAMPLE_TYPE mask.

Since those are only cleared at the end of cmd_inject() after the header
is written, does this leak breakpoint virtual addresses and defeat ASLR
for those events?

[ ... ]

> @@ -2730,6 +2741,17 @@ int cmd_inject(int argc, const char **argv)
>  	if (zstd_init(&(inject.session->zstd_data), 0) < 0)
>  		pr_warning("Decompression initialization failed.\n");
> =20
> +	if (inject.aslr) {
> +		struct evsel *evsel;
> +
> +		evlist__for_each_entry(inject.session->evlist, evsel) {
> +			ret =3D aslr_tool__cache_orig_attrs(tool, evsel);
> +			if (ret) {
> +				pr_err("Failed to cache original attributes: %d\n", ret);
> +				goto out_delete;
> +			}
> +		}
> +	}

[Severity: High]
When processing pipe output, perf_event__synthesize_for_pipe() uses
perf_event__repipe directly rather than the tool's configured attr callback.

Will the output pipe stream begin with unstripped ATTR headers claiming
registers are present? Does this cause trace consumers to fail when parsing
the stripped SAMPLE records?

[ ... ]

> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> index 901b563048fa2..457813812a34a 100644
> --- a/tools/perf/util/aslr.c
> +++ b/tools/perf/util/aslr.c

[ ... ]

> @@ -983,8 +1013,22 @@ static int aslr_tool__process_sample(const struct p=
erf_tool *tool,
> =20
>  	new_event->sample.header.size =3D sizeof(struct perf_event_header) + j =
* sizeof(u64);
> =20
> +	/* Temporarily override evsel attributes to match the stripped new_even=
t format! */
> +	orig_sample_size =3D evsel->sample_size;
> +	evsel->sample_size =3D __evsel__sample_size(sample_type);
> +	evsel->core.attr.sample_type =3D sample_type;
> +	evsel->core.attr.sample_regs_user =3D 0;
> +	evsel->core.attr.sample_regs_intr =3D 0;
> +
>  	perf_sample__init(&new_sample, /*all=3D*/ true);
>  	ret =3D evsel__parse_sample(evsel, new_event, &new_sample);
> +
> +	/* Restore original attributes immediately so trace ingestion never des=
ynchronizes! */
> +	evsel->sample_size =3D orig_sample_size;
> +	evsel->core.attr.sample_type =3D orig_sample_type;
> +	evsel->core.attr.sample_regs_user =3D orig_regs_user;
> +	evsel->core.attr.sample_regs_intr =3D orig_regs_intr;
> +
>  	if (ret) {
>  		perf_sample__exit(&new_sample);
>  		goto out_put;

[Severity: High]
If downstream delegates like perf_event__convert_sample_callchain use
evsel->core.attr.sample_type to parse the event, will they expect register
data that is no longer present in new_event?

Since we restored the original attributes before calling the delegate, could
this read past the end of new_event and cause data corruption?

Should we restore the attributes after the delegate returns?

[ ... ]

> @@ -1010,6 +1054,7 @@ static int aslr_tool__process_attr(const struct per=
f_tool *tool,
>  	struct aslr_tool *aslr;
>  	struct perf_tool *delegate;
>  	union perf_event *new_event;
> +	int err;
> =20
>  	del_tool =3D container_of(tool, struct delegate_tool, tool);
>  	aslr =3D container_of(del_tool, struct aslr_tool, tool);
> @@ -1020,9 +1065,32 @@ static int aslr_tool__process_attr(const struct pe=
rf_tool *tool,
>  	if (new_event->attr.attr.type =3D=3D PERF_TYPE_BREAKPOINT)
>  		new_event->attr.attr.bp_addr =3D 0;  /* Conservatively remove addresse=
s. */
> =20
> +	if (new_event->attr.attr.sample_type & PERF_SAMPLE_REGS_USER) {
> +		new_event->attr.attr.sample_type &=3D ~PERF_SAMPLE_REGS_USER;
> +		new_event->attr.attr.sample_regs_user =3D 0;
> +	}
> +	if (new_event->attr.attr.sample_type & PERF_SAMPLE_REGS_INTR) {
> +		new_event->attr.attr.sample_type &=3D ~PERF_SAMPLE_REGS_INTR;
> +		new_event->attr.attr.sample_regs_intr =3D 0;
> +	}
> +

[Severity: High]
When processing inline attributes in pipe mode, this strips the register fl=
ags
before delegating to perf_event__repipe_attr().=20

When subsequent PERF_RECORD_SAMPLE events arrive from the input pipe, will
evsel__parse_sample() use this stripped evsel to parse the unstripped raw
input buffer? Could this cause the parser to misinterpret the unread regist=
er
data as subsequent fields and drop the samples?

>  	new_event->attr.attr.sample_type &=3D ASLR_SUPPORTED_SAMPLE_TYPE;
> =20
> -	return delegate->attr(delegate, new_event, pevlist);
> +	err =3D delegate->attr(delegate, new_event, pevlist);
> +	if (!err && pevlist && *pevlist) {
> +		struct evsel *evsel =3D evlist__last(*pevlist);
> +		struct aslr_evsel_priv *priv =3D zalloc(sizeof(*priv));
> +
> +		if (priv) {
> +			priv->orig_sample_type =3D event->attr.attr.sample_type;
> +			priv->orig_sample_regs_user =3D event->attr.attr.sample_regs_user;
> +			priv->orig_sample_regs_intr =3D event->attr.attr.sample_regs_intr;
> +			if (hashmap__add(&aslr->evsel_orig_attrs, evsel, priv) !=3D 0)
> +				free(priv);
> +		}
> +	}
> +
> +	return err;
>  }

[Severity: Medium]
If zalloc() or hashmap__add() fails here, the error is silently ignored.

When aslr_tool__process_sample() later fails the hashmap lookup, it will fa=
ll
back to an evsel->core.attr.sample_type that lacks the register flags. Will
parsing the unstripped raw kernel sample array with this stripped mask cause
the manual parser to desynchronize and misinterpret the unread register dat=
a?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520063050.3917=
261-1-irogers@google.com?part=3D4
