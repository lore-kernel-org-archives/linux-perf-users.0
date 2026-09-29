Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAD5632
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 02:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790649505; cv=none; b=pMFFUfRJQA0IarCJF72PEkvMKhFhdyKiNjOaq5xLLPkLeTYRys+/tU/NqA9LW/4wm5zAlO1WklGtHIyS+FqagXNzGDWt4EZj7ej/w/UGtH37tRqfQVDN1I+xthHC/M0QhbJxlG0IM6z1XvjouT/YQcASZZctKvOtiUUrDkoFIRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790649505; c=relaxed/simple;
	bh=1hrJWMvxAiNdyArjGkHKYCnAMry1hitmd48Mo2V5Mk8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MMGk+sSfgqi9MWjbkJEma6vdgR5di1qI9DT9kd+lPJrL7Ypcq7ydKkXz6xs9n5yj0ARqV7hlQtpNi/is/ChBYeYNWFtEVGoCn9vrP9AOxxQ3EP/ASX+IVYc1w6tfr5GpIX7uWTmlcoYRUBwwjzfm1wPEypH2xZbBkSFmtXBolWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nx+V6j6c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nx+V6j6c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F431F00893;
	Tue, 29 Sep 2026 02:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790649504;
	bh=awLAwr5lur2GGOu9QRZoWsQx6kASVxjOoxUOvUDkvTE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nx+V6j6c5Gc527QXEgmu1x8+jRR54XLRPd8Mc4AfcYKml4xuBABjGhyunPC1f+XJc
	 Zuc1v9yRBCJYcheUSJPRNW7jz5d1qq1LtyGBM/3xnirRpGHehLmt1qPOkDFL2S1mYu
	 zT3xqbFOFDC+zQ2l85KlFpPW45+JPJtt7h/N26Hpak5qO5+P5oKwRURS34road9itR
	 1zgP9N6/Qj/d1BOhJEWOznEXDoeIOT79ar3G9pzDBvllOhDUF73WQ2sDmm25jFcpAm
	 FcUEPvyDhuf41YzQiOhMwPO/9nqCERa1u9QB9c+3ReFIjGlTVHqVZa1VlSc3d8SM2d
	 4LwhZuLA9Z2Yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/9] perf evsel: Clamp sample_id size for ksymbol,
 bpf, and text_poke events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929021913.56010-2-irogers@google.com>
References: <20260929021913.56010-1-irogers@google.com>
 <20260929021913.56010-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 02:38:23 +0000
Message-Id: <20260929023824.25F431F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf evsel: Incorrect PERF_RECORD_TEXT_POKE payload size calcula=
tion
--

commit fc6474e9b3305fb280e04ce2b30b2a815e2f3a7e
Author: Ian Rogers <irogers@google.com>

perf evsel: Clamp sample_id size for ksymbol, bpf, and text_poke events

This commit adds evsel__event_size() to clamp the effective size used to
locate the trailing id_sample for specific events. This prevents user-space
tools from reading uninitialized memory when processing data from unpatched
kernels.

Link: https://lore.kernel.org/r/20260929014206.4175245-1-irogers@google.com

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 3367242c57640..70da6be798cca 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c

[ ... ]

> @@ -3966,6 +3966,63 @@ u16 evsel__id_hdr_size(const struct evsel *evsel)
>  	return size;
>  }
> =20
> +/*
> + * Prior to kernel fix, perf_event_ksymbol_output(), perf_event_bpf_outp=
ut(),

[ ... ]

> +	case PERF_RECORD_TEXT_POKE: {
> +		size_t fixed =3D offsetof(struct perf_record_text_poke_event, bytes);
> +
> +		if (size < fixed)
> +			return size;
> +		payload =3D fixed + PERF_ALIGN((size_t)event->text_poke.old_len +
> +					     event->text_poke.new_len, sizeof(u64));

[Severity: Medium]
Does this misapply the 8-byte alignment only to the variable lengths rather
than the entire structure?

The kernel generates PERF_RECORD_TEXT_POKE events by padding the entire
event size to an 8-byte boundary. The payload size before id_sample is
16 + ALIGN(old_len + new_len + 4, 8).

This calculates the user-space payload as
fixed + PERF_ALIGN(old_len + new_len, 8), where fixed =3D 20. Because 20 is
not a multiple of 8, adding it outside the alignment yields a mathematically
incorrect size.

For example, if old_len =3D 1 and new_len =3D 1, the kernel calculates 24 b=
ytes,
but the code here calculates 28 bytes. Calculating the wrong payload size
causes perf to index incorrectly into event->sample.array, leading to parsi=
ng
failures or out-of-bounds accesses.

> +		break;
> +	}
> +	default:
> +		return size;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929021913.5601=
0-1-irogers@google.com?part=3D1
