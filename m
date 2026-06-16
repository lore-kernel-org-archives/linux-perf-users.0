Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C4135AC3E
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635207; cv=none; b=qCt1V3tqYSwp945PUI5nM0gapJhu+w3+VYOJBeQfeeMWAd9UL0iJOLs1r164GzWkYHKlYkHZmjjk381k4yFwHsgPmFg2dJoQ+vWrvlkYZcCVa9v1EFu6kV2c/sM73ZSlRdL50Z3XUJuDk94AEN76F4YMLlpd+77ZbVb5Q6+ICxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635207; c=relaxed/simple;
	bh=K53QhDpg4K8iA/Ga8TaGZgs4BZvvtGE+ozjfnb2Pbl8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U7tl92KEj9YZOvm/Ll3KYTqDMp6c/tnsnYT1A1QJpdHmUlQRKtlQewBCCQ/dhQUxYlEJtSZ7cuaQBFpqjiSJkRQbj/lTdUZUygQ4tN+HMNti+wViYiIA74fbJMse/epNYXwH8ixNiFm38O6Y4uPiXm0qGA8IMddG7nkHHtQo8Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASjn4LKf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASjn4LKf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC9A1F000E9;
	Tue, 16 Jun 2026 18:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781635206;
	bh=siOm0LRAJeioJyI3Wq6QxPwjoKVlTz/oBTcnlVbxrKw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ASjn4LKfTyg75ct5nW0nAW1eQcOiWS1c6p9KxPtggJ5hyw2OY2ebmzyoliMQEYJFp
	 KaCzFZcHK9RsIv/dhOgTFWmnEnjbKVMXHkCqtVR2HQ0kXmzH8bjSxxB2dAnNxcY5RR
	 dUt05VDIw1B22WwbaKQPFDgTyXaXqfOpfbhGWzKWXTLu+4MFTkBuBYg7bW4loD/twn
	 uWTQ93280PRFNCc3cuw4OaoJ5K2NU4CvJEM3NDX1Fo/W2/yGRYMJrgXPqBN5z/0Lup
	 LlGZPZULzrz94S+NPMJdiG/KS3eYZS1mjwArECM8CT2fCYIQWGhj4X4sNG9hDu4g0M
	 VXPhYVKwfX9HA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf evsel: Add lazy-initialized probe type
 detection helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616182546.8892-2-acme@kernel.org>
References: <20260616182546.8892-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 18:40:05 +0000
Message-Id: <20260616184006.0CC9A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Ftrace-based return probes (kretprobe, uretprobe, fexit) are inc=
orrectly classified as PROBE__NOPE because they lack the __probe_ip field.
--

commit fc58c48524e7c99a712f8fb111c94abfbbeb4b6d
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf evsel: Add lazy-initialized probe type detection helpers

This commit introduces lazy-initialized probe type detection helpers for
perf evsel. It caches the probe type lookup in a 3-bit field within struct
evsel to avoid repeated PMU list walks via evsel__find_pmu().

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 05fa0010c858a..ea9fa04429f08 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c

[ ... ]

> @@ -254,6 +254,58 @@ const char *evsel__pmu_name(const struct evsel *evse=
l)
>  	return event_type(evsel->core.attr.type);
>  }
> =20
> +enum evsel_probe_type {
> +	PROBE__UNKNOWN	=3D 0,
> +	PROBE__NOPE	=3D 1,
> +	PROBE__KPROBE	=3D 2,
> +	PROBE__UPROBE	=3D 3,
> +	/*
> +	 * Ftrace-based dynamic probes (kprobes/uprobes/fprobes created via
> +	 * tracefs) report PMU "tracepoint", not "kprobe"/"uprobe".  Detect
> +	 * them by the __probe_ip field that the kernel adds to all dynamic
> +	 * probe formats.
> +	 */
> +	PROBE__FTRACE	=3D 4,
> +};
> +
> +static void evsel__resolve_probe_type(struct evsel *evsel)
> +{
> +	const char *name =3D evsel__pmu_name(evsel);
> +
> +	if (!strcmp(name, "kprobe"))
> +		evsel->probe_type =3D PROBE__KPROBE;
> +	else if (!strcmp(name, "uprobe"))
> +		evsel->probe_type =3D PROBE__UPROBE;
> +	else if (!strcmp(name, "tracepoint") && evsel__field(evsel, "__probe_ip=
"))

[Severity: Medium]
The commit message mentions this covers kprobes, uprobes, and fprobes
regardless of their group or system name by checking the __probe_ip field.
Will this successfully detect ftrace-based return probes?

It looks like return probes like kretprobe, uretprobe, and fexit do not
contain a __probe_ip field, but instead define __probe_func and
__probe_ret_ip.

If evsel__field() returns NULL for return probes, won't they incorrectly
fall through to the else branch and be classified as PROBE__NOPE?

> +		evsel->probe_type =3D PROBE__FTRACE;
> +	else
> +		evsel->probe_type =3D PROBE__NOPE;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616182546.8892=
-1-acme@kernel.org?part=3D1
