Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85052353ED9
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 21:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185840; cv=none; b=KnDbkUSbnZemsz/NNeLZmTHMbqjqJ+i1r+W6522ZwyUv+A9+fZ/3kPNuY7o5pwGfb/nvLQ9NT/XUYc1lbOvJUycJMGkfYHNY3Xyi9ENGVnn2JHnaC8WWHztYPqLYX+U1CoxQrSXFelUz1RdoMVLbnhIj/1+UVWXXlnl8Pw2IirY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185840; c=relaxed/simple;
	bh=CArWfeKCmlpAHTJjDomBCGRwr9GJmkq7dQ+qfiaLYgw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=q/+HQxdop0hoH2yBxEidGX1wXF1NW43gT61V+OYyk0FXnFCCkEOt250xw3PqTF/1kiQyPrSeSSJt23eTnTRTRr9u6Yr3oADrI59RKd4GARwDCaSLgd7hzj0Lvr/90tVb2tsvxUajjJGgIQoViylBY4sgjFzloS9J/ZjaEZx1eXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gezz8fEb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gezz8fEb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C951F000C4;
	Fri, 16 Oct 2026 21:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792185839;
	bh=Tb9YyHCjLAvsqYSREgdO67xL55MlPNfpTHC0izhGdJI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gezz8fEbdO1qK8bCrq1dgLAhDTx/SJ65uS5rSCRweE9TUm1nP0TkCREDQLqGxHiKW
	 /wU5wVnJU8nAhMDPxPnIcmmTY0i9S4h0eifhIRjahkVYq9TumNK+SHxn8eumByGpcL
	 DSq21oVs2J460i0W2BZEycXU3d1btiwb9eapPkfrBKfU0684MqC4gft4yejgi2zlln
	 3JLJ8loR5b9U4BMmdn/WlW5CIR721NZ4B+zNGs/U5M/tMLszrJTWNYIaEo6u0nYukC
	 kkXGiq4WYmYIkFNfk8JHGcLO9xmKmLX//8pKWLK6qzU2Z9dUMyTApml/xaZp/CdEja
	 rDvNuRsjn23EA==
Message-ID: <sashiko-outbox-174953@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/21] perf evsel: Don't dump probe events to
 PERF_TEST_ATTR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016212102.76550-10-acme@kernel.org>
References: <20261016212102.76550-1-acme@kernel.org>
 <20261016212102.76550-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 21:23:58 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Events opened just to ask if they are supported, i.e. the ones in
> is_event_supported() and is_libpfm_event_supported(), go through the
> regular evsel__open() path and thus end up in the event files written to
> $PERF_TEST_ATTR, with everything but type, config and disabled zeroed:
>=20
>   [event-0-38654705664-3]
>   fd=3D3
>   cpu=3D-1
>   pid=3D0
>   type=3D0
>   size=3D0
>   config=3D38654705664
>   sample_type=3D0
> [ ... ]
>=20
> Reported-by: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/linux-perf-users/asWQvXRdqp_RK85c@google.co=
m/
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016212102.7655=
0-1-acme@kernel.org?part=3D9

