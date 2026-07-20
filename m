Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B573F871A
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 11:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784545996; cv=none; b=pT26NCgS7dv2GHHdSM6tipM+dD61FwowA/jpl60ALrP+H0kSKauMTZMtFWqpsYUhjgpBo1zCvIeDuwSEx1Op8697np/kSaNKXJl9M6gpb3o5qvnb8eKdfq4PyM3NLZvCk+ZB0RA0gzvpOTObM/+u58o6/UFHXbQnxON93hEzxoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784545996; c=relaxed/simple;
	bh=jr2xOGLdd6qtGzwB0B23QTZ25xO+lHal34iBcZcHfwA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WVCpmw/sPmzPxl6nTpylW9EGgk1E3hOxd8sdy25hEy8FVLwuvtNsLaloa3SXXIAUnWdmjTl0SIVgRUt4zBH2nncAaNeXXL/negYzuG4S5rcNliB8u0BXMijeBuTR4PXQombuZKNNhlXsT3XCUCN+tTCU/YwA5CCO53B8Do25T7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evLIq8rq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evLIq8rq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2DD1F0155E;
	Mon, 20 Jul 2026 11:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784545994;
	bh=UzDpbrG5H1OACMpxhTKf6GAY8ux6yWV1yDKMm4zVai4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=evLIq8rqBowhQ7+eaCrw/Ktd5iYuwD38GM4uhKadN+WsqLWa0EHi7lVduny3juUjo
	 idVPuWfXn/6WTqgAkhpSwXOYHvdGn7a0cnAWySFWdX/Q1+LAwZkKCIFR0+Yv5w/GLW
	 +Iqxq3O8ZyVSwsINWSordmEn9KRkvl7DqtRC2IhWCzVFxAISwmDwnzGUjIbfy8z2sO
	 4naihl9+V14tQr6CB4S7zVyYvDiELxJTIuUdcbQQ5tDnegzuTfDHPfTmVTJHe2FgjD
	 qj+TTgkpYcgosEY5VBLp7CgDuyd7GzsDp0ktCKxWmiLA/9QGTd+FG9Y9QG6accKJ0v
	 QlXaSzcrO66+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 5/6] docs: ABI: sysfs-bus-event_source-devices-htm:
 Document sysfs event format entries for htm pmu
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260720104447.11843-6-atrajeev@linux.ibm.com>
References: <20260720104447.11843-1-atrajeev@linux.ibm.com>
 <20260720104447.11843-6-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 11:13:13 +0000
Message-Id: <20260720111314.3B2DD1F0155E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The format attributes documented in the ABI file do not match th=
e V2 layout claimed in the commit message.
- [Medium] The commit message provides a fundamentally flawed example for u=
sing the 'events' attribute group, conflating it with the 'format' group.
- [Low] Minor grammatical error in the description text.
--

--- Patch [5]: [PATCH V2 5/6] docs: ABI: sysfs-bus-event_source-devices-htm=
: Document sysfs event format entries for htm pmu ---
commit 9ec8c4a8a34dc7a4a75859018f086bb71432aa4a
Author: Athira Rajeev <atrajeev@linux.ibm.com>

docs: ABI: sysfs-bus-event_source-devices-htm: Document sysfs event format =
entries for htm pmu

This commit adds ABI documentation for the sysfs entries exposed by the
HTM PMU under /sys/bus/event_source/devices/htm/. It documents the format
attribute group and the events attribute group.

> Document the events attribute group, which lists the named events
> available on the PMU.  Users can pass these names directly to perf:
>=20
>   # perf record -e htm/nodalchipindex=3D2,nodeindex=3D0,htm_type=3D1/ ...

[Severity: Medium]
Does this example conflate the 'events' attribute group with the 'format'
group? The example provided uses format attribute fields (key-value pairs),
whereas the 'events' directory is supposed to provide named aliases.

> diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-htm=
 b/Documentation/ABI/testing/sysfs-bus-event_source-devices-htm
> new file mode 100644
> index 0000000000000..784ba7c31b89b
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-htm
> @@ -0,0 +1,21 @@
> +What:           /sys/bus/event_source/devices/htm/format
> +Date:           June 2026
> +Contact:        Linux on PowerPC Developer List <linuxppc-dev at lists.o=
zlabs.org>
> +Description:    Read-only. Attribute group to describe the magic bits
> +                that go into perf_event_attr.config for a particular pmu.
> +                (See ABI/testing/sysfs-bus-event_source-devices-format).
> +
> +                Each attribute under this group defines a bit range of t=
he
> +                perf_event_attr.config. Supported attribute are listed
                                                             ^^^^^^^^^
[Severity: Low]
This isn't a bug, but there is a grammatical error here ("attribute are"
instead of "attributes are").

> +                below::
> +
> +				event  =3D "config:0-27"  - event ID

[Severity: Medium]
Is the documentation missing the format attributes claimed in the commit
message?

The commit message explicitly states that htm_type, nodeindex,
nodalchipindex, and coreindexonchip were added for the V2 layout, but only
the generic 'event' attribute is listed here.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720104447.1184=
3-1-atrajeev@linux.ibm.com?part=3D5
