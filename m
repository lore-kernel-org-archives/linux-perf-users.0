Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64343947A4
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779263405; cv=none; b=F0oFF6CQaapHQq05AkLicCtWXG143K/uRzsXFXAO8PJXPA/Nenct3MLplNbwg/wzoxiD/YBLSnMGPj37U370HvrLeU4KB3SRiJZur4C4OJpOZuTP6UiI1O/HZ3EEfk/RwxQC/DU6zZiEv08A3BGdW8BUvko3gw+640js199qDfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779263405; c=relaxed/simple;
	bh=3yVlgnj9cSerx4LiJ1mfCRiew06kyZP12RIexyRGrzw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MqrNtgYQBWd+O+s9LlSeJX6uXZNVj5qjC11tYMy2MedJ/0RAh6K1KvzJaYUlxi1QFZqJRe4v83jzB7EreeLs9fdU0lGv/lXuQySMVZJulyBvOTQtUv2E/trvaU3w6+noxG0lGbCQ1N3UIc1MmkFN9xx8TZJ6x1BKneACDkjLYm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZ+/QNoU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZ+/QNoU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7AE1F00893;
	Wed, 20 May 2026 07:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779263403;
	bh=MF084rQTOEFhTYtK+diwGZdnG//mHjyZrsgBeiMmw8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XZ+/QNoUFxsb9k9H8gW1y/UVkDcfEh/IGXnZXY0SFkJ5lmQSbNkOh/PruH7Hc3dD/
	 SuP9/EytmeNsnXadtiTK/Nk4w/nlNw/yh9uR5SakxpWvz7IpjsvpAyWPEA3gW0rtts
	 Zsw8R1NNNpeLhoy3IftOcmOHYRFVtP7Fdd65AW79JiW56YjQjiRXGGFo49zkWaTC0f
	 rN48vdyje34556S71UejITWKELUJHAO367o/KL+Xg9PSglp7qNBp4YV1kIjlT0gn3y
	 vo9Bt3FNUZpLZ7YblQ1b3tBO6D/ElehqmuOj5o+gowNCZTnYFReqj/IzgU68Gjq205
	 Cplx0iCpyZIUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/4] perf inject/aslr: Add aslr tool to
 remap/obfuscate virtual addresses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260520063050.3917261-3-irogers@google.com>
References: <20260520063050.3917261-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 07:50:03 +0000
Message-Id: <20260520075003.4D7AE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] A malicious perf.data file can trigger a stack buffer overflow=
 in `perf_event__repipe_attr` by providing an event with a maximized size.
- [High] Prematurely masking `sample_type` in `aslr_tool__process_attr()` c=
orrupts the parsing of subsequent sample payloads.
--

commit 8f4f252e9954c1c30aaccf15ba0d851aee75c524
Author: Ian Rogers <irogers@google.com>

    perf inject/aslr: Add aslr tool to remap/obfuscate virtual addresses

    If perf.data files are taken from one machine to another they may
    leak virtual addresses and so weaken ASLR on the machine they are
    coming from. Add an aslr option for perf inject that remaps all
    virtual addresses, or drops data/events, so that the virtual address
    information isn't leaked.

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index a2493f1097df9..f42b315199b3d 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -232,6 +234,14 @@ static int perf_event__repipe_attr(const struct perf=
_tool *tool,
>  	if (!inject->output.is_pipe)
>  		return 0;
> =20
> +	if (inject->aslr) {
> +		union perf_event stripped_event;
> +
> +		memcpy(&stripped_event, event, event->header.size);

[Severity: Critical]
Is it possible for event->header.size to exceed sizeof(union perf_event)?

perf_session__process_events() reads events from the perf.data file and
dynamically reallocates its heap buffer if an event's header.size exceeds
sizeof(union perf_event). The format allows a maximum size of 65535 bytes.

If a malicious or unusually large event is processed, could this memcpy
overflow the local stripped_event buffer on the stack, potentially leading
to a return address overwrite?

> +		stripped_event.attr.attr.sample_type &=3D ASLR_SUPPORTED_SAMPLE_TYPE;
> +		return perf_event__repipe_synth(tool, &stripped_event);
> +	}
> +
>  	return perf_event__repipe_synth(tool, event);
>  }

[ ... ]

> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> new file mode 100644
> index 0000000000000..901b563048fa2
> --- /dev/null
> +++ b/tools/perf/util/aslr.c

[ ... ]

> +static int aslr_tool__process_attr(const struct perf_tool *tool,
> +				   union perf_event *event,
> +				   struct evlist **pevlist)
> +{
> +	struct delegate_tool *del_tool;
> +	struct aslr_tool *aslr;
> +	struct perf_tool *delegate;
> +	union perf_event *new_event;
> +
> +	del_tool =3D container_of(tool, struct delegate_tool, tool);
> +	aslr =3D container_of(del_tool, struct aslr_tool, tool);
> +	delegate =3D aslr->tool.delegate;
> +	new_event =3D (union perf_event *)aslr->event_copy;
> +
> +	memcpy(&new_event->attr, &event->attr, event->attr.header.size);
> +	if (new_event->attr.attr.type =3D=3D PERF_TYPE_BREAKPOINT)
> +		new_event->attr.attr.bp_addr =3D 0;  /* Conservatively remove addresse=
s. */
> +
> +	new_event->attr.attr.sample_type &=3D ASLR_SUPPORTED_SAMPLE_TYPE;

[Severity: High]
Does prematurely masking sample_type here corrupt the parsing of subsequent
sample payloads?

If evsel is created in the core session lacking the masked bits (e.g.,
PERF_SAMPLE_REGS_USER), evlist__parse_sample() will rely on this masked
sample_type when a raw PERF_RECORD_SAMPLE event is later read from the file.

However, the raw event on disk still contains the data bytes for the masked
fields. Could the parser fail to skip them and instead misalign, reading
these raw bytes as subsequent fields? This might cause evsel__parse_sample
to fail with -EFAULT or corrupt the parsed data.

> +
> +	return delegate->attr(delegate, new_event, pevlist);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520063050.3917=
261-1-irogers@google.com?part=3D2
