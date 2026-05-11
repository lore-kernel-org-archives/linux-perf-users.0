Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26F232143D
	for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 23:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778543207; cv=none; b=OM0wr4b/EUfKID7PDglWKl8ugRDETUJJjzqgaVh/F8AJJQsE7D9ZuYiP0cnVAABUN3C5Bh4IciF6kt6ATIM9CfpNDSv3I7YflHzJ1+DwTAGRCdu4DDuIqOFi4prSPdWYiHZkAElWMHOjOxjH8Fl/9URgXyVFLmFn0ERmIfFq4xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778543207; c=relaxed/simple;
	bh=6WprV3kr3K3thb8yEzacIksTGZc6F4znYH4qDSF0a14=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=scfyLahKppfLS4v9Bth0PPDGL28NxSnIOUJ8+TPRtry3W/9zdy2eV7OS2T7mU1OGIj5Ha8PT9euuI8AOCBY1FrpQRYIRJOuQpvIzg/tLLOlqZznVBFOIYJ2vjdx3eOD5EBkCk0xMR9uItTKQVvrfkKpH0ox9i6z70vyf2qTmjqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tyc6hxU8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tyc6hxU8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C33DC2BCB0;
	Mon, 11 May 2026 23:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778543206;
	bh=6WprV3kr3K3thb8yEzacIksTGZc6F4znYH4qDSF0a14=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Tyc6hxU8lEOUPIcroUFBgCqR8jxZFak1IhJyjWscuItpCmXuuK5Sq6HL4r3hPaDmM
	 DHqQTddu+I+C0wsXZxAzdRd9Hpv3oUHBOMI7D0xQ5P3Ik3/uR9e8R/dGtNo4foxeXe
	 xdBJV4JhzH7+l4dEsFD28DOoa2CRVhWKpl/GjsLR47+5ROk1ZvrJTNp9cVrz16TRvH
	 JZDIoXQPv7EioWClUCLZEPh7p8QrFsb7LHREwuvFgh8CzS+lHCfx/UxgcX/Xny5/bO
	 +OgXo1r/I2/KY0rK11nuDLhgKQDUId9pQDRui9tyf42LqIzUh2A2n2kjxFg4Tonyq8
	 A2zZnEmPR7SoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/28] perf tools: Fix event_contains() macro to verify
 full field extent
Reply-To: sashiko@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260510033424.255812-3-acme@kernel.org>
References: <20260510033424.255812-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 May 2026 23:46:45 +0000
Message-Id: <20260511234646.8C33DC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The updated `event_contains()` macro is unsafe for trailing arrays =
with maximum bounds (e.g., `filename[PATH_MAX]`), as it will spuriously ret=
urn false.
--

commit fa33b73ce30ce23ebbf36b169a8ba7e3131d2218
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Fix event_contains() macro to verify full field extent

This commit updates the event_contains macro to ensure the entire field fits
within the event size, rather than just checking its start offset. It also
updates callers accessing extended time fields to check the last accessed
field, cap_user_time_short, so the whole extended block is verified.

> diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include=
/perf/event.h
> index 9043dc72b5d68..c821143e6e493 100644
> --- a/tools/lib/perf/include/perf/event.h
> +++ b/tools/lib/perf/include/perf/event.h
> @@ -8,7 +8,9 @@
>  #include <linux/bpf.h>
>  #include <sys/types.h> /* pid_t */
> =20
> -#define event_contains(obj, mem) ((obj).header.size > offsetof(typeof(ob=
j), mem))
> +/* Verify the full field fits within the event, not just its start offse=
t */
> +#define event_contains(obj, mem) \
> +	((obj).header.size >=3D offsetof(typeof(obj), mem) + sizeof((obj).mem))

Will this new macro definition spuriously return false for events with
dynamically sized trailing arrays?

For example, if the macro is used on a field with a maximum bound like
filename[PATH_MAX] in struct perf_record_mmap, sizeof() will statically
evaluate to the full maximum array size. Since perf often sizes the event
header dynamically to fit only the actual aligned string length,
the event's header.size could be much smaller than the offset plus the
statically declared sizeof().

While it looks like the current callers only use event_contains() on
fixed-size scalar fields in time_conv structs, could this be a trap for
future users trying to validate dynamically sized fields?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260510033424.2558=
12-1-acme@kernel.org?part=3D2
