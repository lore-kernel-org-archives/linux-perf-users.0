Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600343;
	b=cDc21mFbd0b/KyLxiVHGq275Di7LHWrXrDDTazpX85Zlllai6YBz/0fgYPRy58NW9iJw
	 pgof9QroS74z+TjkPv19PcW6FqweeV8PvzwhgVbTiAVgyAibd9JylMSYAaB42W9OPomkq
	 KRu7NCdGNCrcR9GIN6yq4hBwL3eR815T64ttBHB9Eu5L5NmYIJvKKFseOnLZNIWQJTAhV
	 Kv18KWtJZB+HCseNTvABp+WSHsVZ2lTsXm6ul4hvr7uKJXOghV9j0WAGJNNCvvntRtWp6
	 +MBeNreVjPUxPMdDA97FuvKRPtozTJ35TQqhQmYYhRFBqdoEXTWbKuxpLtHrIlv8xWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600343;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jqAMIPVnuZOuXRbZQRNjYZ5xRgAGrFnN8UYw1ns509k=;
	b=gQOG4xKnUyc1e3VLAS+vjUWUxg4NMS0/04TmE9CCcVWyFwWhCLfQYKOYVQ6Fnf46+DSv
	 RbbRzV+7ecvhA5UVm7wL4O2WVCfpeyP+3xWTgmwLNT0Ui9lrSWHvMz7wVXoAhZAP2fHjv
	 vZF9ARHmIpQdjUCIQ/23McgXmj+e8042tb1f7cQZfDbzzK0HBtZcT54aOGGvcAZ2H71Ix
	 qvHBOqP2uF25Q+PZzUCGWJS+oTFhJjD/jd+cRvcB/KonzuZdleD8A5TdzBB4S8l3M6/UH
	 53izJfmXEavapmjSWis98OZgQtTC0qUq5L7UOpiWiARFmfy0Ywpb2E08gap9fhQYtBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TBtbyjWK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DC8606A323
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TBtbyjWK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A144F1F000C4;
	Fri, 13 Nov 2026 20:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600342;
	bh=jqAMIPVnuZOuXRbZQRNjYZ5xRgAGrFnN8UYw1ns509k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TBtbyjWKxY7CvO3diffpgjbAeZKTjPs8Z4L5TpPPwbOy7L/wOKPHG3Ll0OF/ufx6n
	 WBZCVW5rn2uXM3uQIcpXlxro4VUgbRCiW2pL6mtgV/Z++Ql2SxGGitpiYesQ0a+M9S
	 4VKGYYiCeU1gkMNHo1Z0UTjDGSvNsV+sJTIQpYYsZhku7ordHMT5fC4ehk4pvQ78Y9
	 yXynyqp3UyxPuj+Vkma9mU2yAxPysMWY7jyxg0rpoQVAJVm8Q/OqU3O8Ys0XYvQRe/
	 m58Uw1cN14DDqJQfOnlDuRGzvOy4n6Adl+lOMLxL0QxUVpLlfw6IVWdSXi1pT+38jT
	 eoB6bpW1HvVMQ==
Message-ID: <sashiko-outbox-213611@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/30] perf header: Support CPUID matching across all
 architectures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113195335.2865725-15-irogers@google.com>
References: <20261113195335.2865725-1-irogers@google.com>
 <20261113195335.2865725-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:05:42 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> strcmp_cpuid_str() had architecture specific overrides of a __weak
> regular expression matching implementation in arch/x86/util/header.c
> and arch/arm64/util/header.c, so a CPUID could only be compared using
> the rules of the architecture perf was built for. In addition, the
> HEADER_CPUID strings written by get_cpuid() on x86 ("vendor,family,
> model,step" in decimal) and PowerPC ("pvr_ver,pvr_rev" in decimal)
> differ from the get_cpuid_str() formats ("vendor-family-model-stepping"
> in hex and "0x%.8lx") matched against the pmu-events mapfile.csv
> tables. As a result, finding the core events or metrics table for the
> CPUID of a perf_env, such as from a perf.data file recorded on a
> different architecture, failed.
>=20
> Move the architecture specific comparisons into util/header.c and
> select them using the ELF machine of the CPUIDs: EM_NONE for the test
> and common tables compares exactly, arm64 compares MIDR part, variant
> and revision fields, x86 matches with an optional stepping and other
> architectures match a regular expression. Convert x86 and PowerPC
> HEADER_CPUID strings before matching.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113195335.2865=
725-1-irogers@google.com?part=3D14

