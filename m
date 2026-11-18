Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021433;
	b=hUJcu0G6amAZxBGWbFxlSrvuPSOQVYPy37vjdJHOSTqOLvUpZUW2LUPT9rBWjZDzKgoW
	 Mnpe674kttYnVvsqEw4UGzd8P2KV2hoDnrXge0fObpWN/E/+okCKjqMXPn5KGXh3JsYu3
	 BjlxgcommDFTN1NqIOWDoERwFi7GCXf6yeWoG9a9paq26JAnuH1ohXRa1BevvYL6+uzQe
	 vi2lskyznX+5cnT/gLoeUaLjxSi6PwE55t5QzfDETKDqBpAnHWyt7YF0Ombe7Lq8Pr82I
	 pvFHB0emmlaMD6zf2R7RONV6bc68tpEydDf30Dg8HMr+iBHRml1vzY9GGa2hYtbLhnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021433;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DLjqocR7wKPP9xVmiAngUL7zXTV793qsL76qyI7Xi+U=;
	b=ILFlHqg0f2yx5cJqxdZuuERINApiOpSolA/odf5TKOnO3HWGCLwbkuPlC/HdyXS79JEn
	 C3ItOJHsfhJ8SvHfdasb3r4j44F6VG1xna0ML4MXuxbxvPW52fxRNztBKTmDHMT+Zs6C1
	 Qj8MOwWyo3XEQhxcCPt8JqzbPJdsHcKkIfUH67T7m72QHsxaOzpbNTmZ+qjmNDUFRl/8C
	 cRg1KsmmGfEkX0mee/DrwknWbqLuk8O+MkLC3hfXHBShVVKU571N7OSKtLebNiaGBpiG5
	 DPLkEzZO7WZoEXCbEcO3dLkHsQY1XtVYqpq0L1pw0HQGwy8qI9OSW+dOzbwPeup6Xyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UIO2JDdk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153CE60A2623
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UIO2JDdk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3F01F000CB;
	Wed, 18 Nov 2026 17:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795021432;
	bh=DLjqocR7wKPP9xVmiAngUL7zXTV793qsL76qyI7Xi+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UIO2JDdktupxWm5BVNtOBojjG1sBFbX5QUNjPnIxOugydJ9oj2J/e7F7wC6e/dQ5Q
	 ACuob9yUJyQgqnzt6sH1fVIBfc2WwaXjedZ/NEsaDzIFMYhCoGdRD70gPo07mWYeK8
	 2Fm5QK6H3HWOxOkMsvHwXwdVoGrGea4IUJSaWYZAW65udqROMaGhIYwr6wVa5zOHKG
	 +b24LLr5yYHJykNUcTLcKYPZgVF7ySDl38NXFguzMgtYoId05tqSmWhB7NwoqQHSXl
	 aqpHbJNs428dC7qkCWUZkECqPdRCq/il/dU7hU78AXy1yMARUtimPN9HGEY637G1W9
	 x2IcJMpbT83IA==
Message-ID: <sashiko-outbox-221576@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/34] perf build-id: Cache the vDSO in build ID mmap
 mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-7-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-7-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 17:03:52 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] perf build-id: dso__cache_build_id() fails to cache vDSO for
  synthesized mmaps
--

commit affc6379bdb9537b483a873cee2efe3e5b3ce5dd
Author: James Clark <james.clark@linaro.org>

perf build-id: Cache the vDSO in build ID mmap mode

This commit reads the host vDSO build ID from perf's temporary copy of the
vDSO in dso__cache_build_id() when the DSO lacks a build ID, so that the
vDSO can be added to the build ID cache in --buildid-mmap mode.

> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index 02233ef0eafff..cc813f421c9b2 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -886,6 +886,18 @@ static int dso__cache_build_id(struct dso *dso, stru=
ct machine *machine,
>  	char *allocated_name =3D NULL;
>  	int ret =3D 0;
> =20
> +	/*
> +	 * The kernel can't add the vDSO's build ID to mmap events because it
> +	 * doesn't have a file, so read it from the copy that perf made. That
> +	 * copy is of the host's vDSO, so it can't be used for guests.
> +	 */
> +	if (is_vdso && machine__is_host(machine) && !dso__has_build_id(dso)) {
> +		struct build_id bid =3D { .size =3D 0, };
> +
> +		if (filename__read_build_id(name, &bid) > 0)
> +			dso__set_build_id(dso, &bid);
> +	}
> +
>  	if (!dso__has_build_id(dso) || !dso__hit(dso))
>  		return 0;

[Severity: Medium]
Does filename__read_build_id(name, &bid) still fail when perf record
synthesizes mmap2 events from /proc (for example with -a or -p)?

In --buildid-mmap mode, perf_event__synthesize_mmap_events() calls
perf_record_mmap2__read_build_id() for the "[vdso]" mapping, which inserts
a DSO with short_name and long_name set to "[vdso]" and no build ID:

tools/perf/util/synthetic-events.c:perf_record_mmap2__read_build_id() {
	...
	dso =3D dsos__findnew_id(&machine->dsos, event->filename, &dso_id);
	...
	rc =3D filename__read_build_id(event->filename, &bid) > 0 ? 0 : -1;
	...
}

When process_buildids() later processes the mmap2 event, map__new() calls
machine__findnew_vdso(), which finds that existing "[vdso]" DSO in
machine->dsos via machine__find_vdso() and returns early before calling
get_file(&vdso_info->vdso) to create the temporary vDSO file:

tools/perf/util/vdso.c:machine__findnew_vdso() {
	...
	dso =3D machine__find_vdso(machine, thread);
	if (dso)
		return dso;
	...
	file =3D get_file(&vdso_info->vdso);
	if (!file)
		return NULL;

	return __machine__addnew_vdso(machine, DSO__NAME_VDSO, file);
}

As a result, name (dso__long_name(dso)) is still "[vdso]" when
dso__cache_build_id() runs, so filename__read_build_id() fails and the
vDSO remains uncached.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D7
