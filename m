Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E5B4CA264
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780595119; cv=none; b=aBv8d0Q9Mp5BK0B9SnElQ8JsMpS6+L/DeCbvs4rKisWObD1hGWwr+ema046aARpFOg4xtjBIVFDmasqIHyqmEb5r1c/6yiaLYlGSYuOla1IMlvEwODRlMuv8Q5PEVE/+mOW5npcWjb9CytY0Q8d7XPC9yscMmADG5rf0/JUPzl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780595119; c=relaxed/simple;
	bh=TlqKFcW55jcj9K67RLDm/TRPMmjMc/GT71S538q3uvA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iRbAb+NBoOkaoImFaVkTJ/VNQ+nMfb6LhIa9+vzEu29cEZ8Ke+WPkQt/NZNX9yw3Px75a+lgtM/iz4GUariZEI9y0TTkkzVr5nocqFmTWFNIlMAqXYQLT9Fcpe+y9hNxls7VOO/HO/wyDXfI+gBsuIGKYvE/RIGJ1d0Td/7MgPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIe8dp4a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIe8dp4a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1B51F00893;
	Thu,  4 Jun 2026 17:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780595118;
	bh=0nCVCJPqZVtXe9YooQs47XBGWIOHzxJ4+uQ3SUNvuwc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KIe8dp4aURepaAavzTZeozMMgruyniRFfGPehXP1Pp009W2CUaBrp4ApF5DbogvqH
	 zFv0OyHVk9yEcp5qUgsJUH9jJItCTwvCTzV8YSipAvaKWvADdtMaNc+tFWXu0SyEhb
	 HGQrGFgI+jb1PYVGwNBeBusa7bdaKqb9Cvx/9Xm7U/RV3alJYpD1T1QgXg5W8+l7DR
	 yiCdoHK2fE6bx8RD3GB+fSpQi/HXE5vyMNmX/Z8jy11XKIY4X8Iz9iT7+S6ZuYi3hc
	 RJeL+dNOARob8GzXpINvl7HWwjzNxI5UNjgnQK14+1R7RZcsz6xQv/J6aOL7ngg5yL
	 GP0woe55dwEpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 5/5] perf aslr: Strip sample registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260604172850.683329-6-irogers@google.com>
References: <20260604172850.683329-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 17:45:18 +0000
Message-Id: <20260604174518.7E1B51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Allocating `stripped_event` using unvalidated `event->header.s=
ize` and unconditionally writing to `sample_regs_user` and `sample_regs_int=
r` causes a severe heap buffer overflow.
- [High] Missing register stripping in the `itrace`-enabled path of `perf_e=
vent__repipe_attr` corrupts the trace output.
--

commit 5f1dabd94a15919e76927871536447a8782dba24
Author: Ian Rogers <irogers@google.com>

perf aslr: Strip sample registers

Refactor the ASLR tool to strip out only the register dump payload
by masking out the relevant perf_event_attr fields when the delegated
tool is handling the data. struct aslr_evsel_priv maintains the
original perf_event_attr values and is looked up via the evsel_orig_attrs
hashmap.

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index a9f0a3901e7bc..e0f59ef8b97b2 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -253,6 +253,8 @@ static int perf_event__repipe_attr(const struct perf_=
tool *tool,
>  				return -ENOMEM;
>  			memcpy(stripped_event, event, event->header.size);
>  			stripped_event->attr.attr.sample_type &=3D ASLR_SUPPORTED_SAMPLE_TYPE;
> +			stripped_event->attr.attr.sample_regs_user =3D 0;
> +			stripped_event->attr.attr.sample_regs_intr =3D 0;

[Severity: Critical]
Can this write out of bounds and corrupt the heap?

In perf_event__repipe_attr(), stripped_event is allocated using
event->header.size. For older perf.data formats (like PERF_ATTR_SIZE_VER0),
the size can be as small as 72 bytes.

However, sample_regs_user and sample_regs_intr are at offsets 88 and 104 in
the perf_event_attr structure. Writing to these fields unconditionally on a
72-byte allocation will corrupt the heap when processing older traces.

[Severity: High]
Also in perf_event__repipe_attr(), when itrace_synth_opts.set is true,
should the register bits and masks be cleared from the synthesized attr?

When --itrace and --aslr are used together in pipe mode, the code branches =
to
the itrace_synth_opts.set path in perf_event__repipe_attr():

perf_event__repipe_attr() {
    ...
    if (!inject->itrace_synth_opts.set) {
        /* registers are stripped in this branch */
    }
    ...
    attr.sample_type &=3D ~PERF_SAMPLE_AUX;
    if (inject->aslr)
        attr.sample_type &=3D ASLR_SUPPORTED_SAMPLE_TYPE;
    /* register clearing is missing here */
    ...
    perf_event__synthesize_attr(...)
}

This patch strips the repiped samples of their register payloads via
aslr_tool__process_sample(), but the itrace path above leaves the register
flags in the attr event.

This mismatch between the attr event and the payload can corrupt the output
pipe trace and cause parsers to fail.

>  			if (stripped_event->attr.attr.type =3D=3D PERF_TYPE_BREAKPOINT)
>  				stripped_event->attr.attr.bp_addr =3D 0;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604172850.6833=
29-1-irogers@google.com?part=3D5
