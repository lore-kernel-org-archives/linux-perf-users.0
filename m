Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3768025B09C
	for <linux-perf-users@vger.kernel.org>; Sun, 24 May 2026 04:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779596015; cv=none; b=iexyPbOsEnAlJq13yGmcM4YhsdNytFycMClnxa3VQ5XIIR/222l0Kpw7yYpOW9qncJIW0KcNQBPuuoebSHb3gatlQPsrhQC3tSQ2oWjJK693DZCYewo+xSZgHCZKlSxpXWO3cD86zoH3Rj7CmqXShL+OpqzjKKpOoWS+Nvcc4BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779596015; c=relaxed/simple;
	bh=zFP8wdmPUPLY8hTzb7h5TUfx0YnGribwrqzmud5ciUc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IZM2xVHf8zLMYseSPizCq8pzbaTwnGDn/30d3gxEA/qu9oYPE7hCLGSRzxJ+4IuEM0VMfIQK4ntnRVEV1s5WrxZQJZeqmp5OhfeshSN4PXfiqN+CUhE5HuH4OIJYGS1NAXm0amJSaRrIupeEGNIN+w8sbPxIq2Ed7VNdoAxBf2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBbTNuXo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBbTNuXo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B721F000E9;
	Sun, 24 May 2026 04:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779596013;
	bh=sZJSb1v1bZEJUxVzUOLbiiRFC86h8n4pxMPHVRg/Flo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gBbTNuXoM47cZMBlivCjGrxP5YOzSq43usMddTsKAYVEZYDxrcNxzeLOQMXXGPD3I
	 RCf0Ex0h+7n8OexfYfww98DAp3uROyDbCj+T7d7P4yQKk3Rita9U001cgHvgfE3nwJ
	 y7q7jX4tQkDaHznoQ/fdaIfeg5o2ZXS7vYMzVb8TZPwiSYosYDYouqwZfkl4ZhKIRR
	 4zhy5PbnqoFgv3uM7OJsLAFgTdAMBtrCQMiDw1hIlJZYOWwSwl+I01AlKBqRS7teGu
	 1qpFcQ72ZbmGtB1RlfJVw3OSXG0z8s7PqA1agfwf9M8Bkb2Dh2mDA5Y4ETBL5xUDik
	 +kl9Xsb5c1eVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/29] perf session: Add byte-swap and bounds check for
 PERF_RECORD_BPF_METADATA events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260524032709.1080771-16-acme@kernel.org>
References: <20260524032709.1080771-16-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 04:13:33 +0000
Message-Id: <20260524041333.C3B721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Re-fetching `event->header.size` in `perf_session__process_user_=
event` bypasses core bounds validation, leading to out-of-bounds reads.
--

commit a969bd48aeaaebd10cf33ba371bb6523a1e2faf9
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: perf session: Add byte-swap and bounds check for PERF_RECORD_BPF_M=
ETADATA events

This commit adds a byte-swap handler for PERF_RECORD_BPF_METADATA events to
handle cross-endian perf.data files. It also adds bounds checking and string
termination validation to prevent out-of-bounds reads during downstream
processing.

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index f6ce36f515207..ec7da1e1a00f7 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
[ ... ]
> @@ -2192,9 +2235,53 @@ static s64 perf_session__process_user_event(struct=
 perf_session *session,
>  	case PERF_RECORD_FINISHED_INIT:
>  		err =3D tool->finished_init(tool, session, event);
>  		break;
> -	case PERF_RECORD_BPF_METADATA:
> +	case PERF_RECORD_BPF_METADATA: {
> +		u64 nr_entries, max_entries;
> +		u32 hdr_size =3D READ_ONCE(event->header.size);

[Severity: Medium]
Can re-fetching event->header.size here bypass the core bounds validation?

The core event processing loop validates that the event fits within the mem=
ory
mapped region using the initial fetch of the size field. Because native-end=
ian
files are mapped using MAP_SHARED, the memory can be modified concurrently =
if
the file is shared or backed by a FUSE filesystem.

By re-fetching the size via READ_ONCE(event->header.size) after the initial
validation, a concurrent modification could inflate hdr_size. This artifici=
ally
inflates the max_entries calculation beyond the actual memory bounds of the
mmap, which could lead to out-of-bounds reads during the strnlen() loop and
potentially cause a segmentation fault.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524032709.1080=
771-1-acme@kernel.org?part=3D15
