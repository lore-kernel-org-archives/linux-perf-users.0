Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95531384CD5;
	Fri,  7 Aug 2026 09:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786094334; cv=none; b=mSmT1w3Zw33ZIDeqhHoSBvxq+7h1sZGM39HsSahD6xP5Xa8bggfWbeDkd7csPbOA7L3SUGENXscx6fYtDvUlCNmJjIib3cmUHvhu/yXOJDDsnnbh/o1r85oS7Esr+3bNPw6O6x9HWVAmmNiZ9xN4PH8tTplkbgpkyBHGjWKq0vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786094334; c=relaxed/simple;
	bh=eMu50Nwpyv4Ytx1YEKL4wslM5xze3UlC74zUDjUFLjU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bV+xxA96TnAz6ijIRcZ1+EQdIXt29jJwofYX19ikq7y7Y/BtsQH2ysCDN838AgfI+aUga0sECeAwAazKIWgznFCXziO7yukxc7woUeLYt8jxRZ6sdVQvbTdFqGLu2uEz/WeajfOCSK4+Z9EGD5XzSQRjEosFAgT1POr6Om1qV7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZ1p2OjO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZ1p2OjO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDDE61F000E9;
	Fri,  7 Aug 2026 09:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786094333;
	bh=dELu6qPkQNcLya0Ipyc0a8+3uebz8vGNfosat2Ap0Bc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DZ1p2OjOxF8bFYW7kilfM+ywn5O7n2HomuIGqEMGWdsvwYbMTBINSY+r3MBdeXfDT
	 Z/3UQIlZQzyn8tGNInSGz7WwKz9dveDg9X/q29fb+SVCBECgZ8d1FNz1z4SBLhA/qk
	 tOWWkPVSq412uiIB7uKl6v92c40znHsG0NsJsUfdwRT7N/Z1np6NGmma9srzFwKnoz
	 TDiU/bN7mJ/+Bw4NF2PFRThFC60cpGJw0zEqXPK1gdGbi6dMmDEr5fZbiMWYz/gTJm
	 0Odjx3HuIq16IWEdtxqz5fJyKAnI0IWQldw2AlmysF7jvOCfz8MRHKCdlcl9Lqs9/P
	 JVD83SJNsMMwA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 6/8] perf inject: Extend perf inject to support
 bid_offset conversion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260807071818.718751-7-irogers@google.com>
References: <20260807071818.718751-1-irogers@google.com>
 <20260807071818.718751-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 09:18:52 +0000
Message-Id: <20260807091852.EDDE61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] Integer overflow in `u16 max_size` calculation bypasses bounds=
 check, leading to a massive heap buffer overflow.
- [High] Missing `inject_bid_offset_tool__new` instantiation and fatal inva=
lid pointer free on error path.
- [High] Unused attribute rewriting functions lead to complete data corrupt=
ion in output `perf.data`.
- [High] Raw event copying incorrectly checks `branch_sample_type` flags ag=
ainst the `sample_type` bitmask, aliasing with other flags.
- [High] Incorrect event boundary calculations allow the tool to read out-o=
f-bounds memory up to 16 bytes past the event buffer.
- [High] Missing curly braces around `PERF_SAMPLE_READ` format condition ch=
ecks leads to unconditional array execution, corrupting the sample payload.
- [Medium] Missing explicit inclusion of POSIX standard libc headers `<errn=
o.h>` and `<string.h>` breaks musl compatibility.
--

--- Patch [6]: [RFC PATCH v1 6/8] perf inject: Extend perf inject to suppor=
t bid_offset conversion ---
commit 00dac7cb64934c318662c48215a38d4a8f9ec625
Author: Ian Rogers <irogers@google.com>

perf inject: Extend perf inject to support bid_offset conversion

This patch adds a --sample-buildids option to perf inject. It drops MMAP
events and rewrites samples to use build IDs and offsets instead of virtual
addresses.

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 6aa9e3eea4383..8f8d5267a37e2 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
[ ... ]
> @@ -2880,8 +2889,11 @@ int cmd_inject(int argc, const char **argv)
> =20
>  	if (IS_ERR(inject.session)) {
>  		ret =3D PTR_ERR(inject.session);
> +
>  		if (inject.aslr)
>  			aslr_tool__delete(tool);
> +		if (inject.build_id_style =3D=3D BID_RWS__SAMPLE_BUILDID)
> +			inject_bid_offset_tool__delete(tool);

[Severity: High]
Does this code call inject_bid_offset_tool__delete() on an invalid pointer
if __perf_session__new() fails? It appears inject_bid_offset_tool__new() is
never called to instantiate the tool during setup, so when running with
--sample-buildids, this error path will use container_of() and free() on an
uninitialized or incorrect pointer, crashing the tool.

>  		goto out_close_output;
>  	}
> =20
> diff --git a/tools/perf/util/inject_bid_offset.c b/tools/perf/util/inject=
_bid_offset.c
> new file mode 100644
> index 0000000000000..f7b5fb05fac79
> --- /dev/null
> +++ b/tools/perf/util/inject_bid_offset.c
> @@ -0,0 +1,504 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "inject_bid_offset.h"
> +
> +#include <stdlib.h>
> +
> +#include <linux/compiler.h>
> +#include <linux/string.h>

[Severity: Medium]
Will this file fail to build against musl libc? According to the POSIX
standard, files using POSIX constants like -E2BIG, -EFAULT and functions
like memcpy() need to explicitly include <errno.h> and <string.h>.

> +#include <linux/zalloc.h>
[ ... ]
> +int perf_event__rewrite_attr_for_build_id_offset(struct perf_event_attr =
*attr)
> +{

[Severity: High]
Is this attribute rewriting function dead code? It seems to be defined but
never called. Since inject_bid_offset_tool__sample() strips PERF_SAMPLE_IP
and appends PERF_SAMPLE_BUILD_ID_OFFSET, leaving the event attributes
unmodified will cause downstream tools like perf report to parse the
rewritten build-id payloads using the old schema, corrupting the data.

> +	if (attr->sample_type & (PERF_SAMPLE_BUILD_ID_OFFSET |
> +				 PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET)) {
[ ... ]
> +static int inject_bid_offset_tool__sample(const struct perf_tool *tool,
> +					  union perf_event *event,
> +					  struct perf_sample *sample,
> +					  struct machine *machine)
> +{
[ ... ]
> +	__u64 i =3D 0, j =3D 0;
> +	__u64 *in_array, *out_array;
> +	__u64 sample_type =3D evsel->core.attr.sample_type;
> +	const __u64 max_i =3D event->header.size / sizeof(__u64);
> +	struct thread *thread;
> +	u16 max_size =3D event->header.size;

[Severity: Critical]
Can this variable overflow when adding the callchain size below? Because
max_size is typed as u16, when processing an event with a large
sample->callchain->nr, adding the size could cause it to wrap around.

> +
> +	if ((sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CALLCHAIN)) =3D=3D 0)
[ ... ]
> +	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
> +		max_size +=3D
> +			sample->callchain->nr * (sizeof(struct perf_build_id) +
> +						 sizeof(u64) - sizeof(u64));
> +	}
> +
> +	if (max_size > PERF_SAMPLE_MAX_SIZE) {

[Severity: Critical]
If max_size wraps around, will this bounds check (against 65536) bypass the
protection, leading to a massive out-of-bounds write later in the loop when
writing the unvalidated payload?

> +		pr_debug("Insufficient space to copy event\n");
> +		thread__put(thread);
> +		return -E2BIG;
> +	}
[ ... ]
> +	in_array =3D &event->sample.array[0];
> +	out_array =3D &ev->sample.array[0];
> +
> +	if (sample_type & PERF_SAMPLE_IDENTIFIER) {
> +		if (i > max_i)
> +			goto err;

[Severity: High]
Does this boundary calculation allow reading past the event buffer? max_i
represents the total number of 64-bit words including the 8-byte header,
but in_array points to the array skipping the header. Checking against
max_i loosely allows index i to read out of bounds.

> +		out_array[j++] =3D in_array[i++];
> +	}
[ ... ]
> +	if (sample_type & PERF_SAMPLE_READ) {
> +		if ((evsel->core.attr.read_format & PERF_FORMAT_GROUP) =3D=3D 0) {
> +			if (i > max_i)
> +				goto err;
> +			out_array[j++] =3D in_array[i++];
> +			if (evsel->core.attr.read_format &
> +			    PERF_FORMAT_TOTAL_TIME_ENABLED)
> +				if (i > max_i)
> +					goto err;
> +			out_array[j++] =3D in_array[i++];

[Severity: High]
Will this execute unconditionally? Because of the missing curly braces
around the condition check, it looks like only the if (i > max_i) goto
err; check is conditional on PERF_FORMAT_TOTAL_TIME_ENABLED, causing the
out_array assignment to always execute and misalign all subsequent fields
if the flag is absent.

> +			if (evsel->core.attr.read_format &
> +			    PERF_FORMAT_TOTAL_TIME_RUNNING)
> +				if (i > max_i)
> +					goto err;
> +			out_array[j++] =3D in_array[i++];
[ ... ]
> +		} else {
> +			u64 nr;
[ ... ]
> +			for (u64 cntr =3D 0; cntr < nr; cntr++) {
> +				if (i > max_i)
> +					goto err;
> +				out_array[j++] =3D in_array[i++];
> +				if (evsel->core.attr.read_format &
> +				    PERF_FORMAT_ID)
> +					if (i > max_i)
> +						goto err;
> +				out_array[j++] =3D in_array[i++];

[Severity: High]
Are there missing curly braces here as well? The array copy appears to
execute unconditionally, potentially corrupting the event if
PERF_FORMAT_ID is absent.

[ ... ]
> +	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
> +		if (i > max_i)
> +			goto err;
> +		out_array[j++] =3D in_array[i++];
> +		if (sample_type & PERF_SAMPLE_BRANCH_HW_INDEX) {

[Severity: High]
Does this code check the wrong bitmask? PERF_SAMPLE_BRANCH_HW_INDEX belongs
to branch_sample_type, not sample_type. Checking it against sample_type
means it aliases with PERF_SAMPLE_TRANSACTION, which might incorrectly
consume fields and corrupt the payload for unrelated events.

> +			if (i > max_i)
> +				goto err;
> +			out_array[j++] =3D in_array[i++];
> +		}
> +		if (i + (sample->branch_stack->nr * 3) > max_i)
> +			goto err;
> +		memcpy(&out_array[j], &in_array[i],
> +		       sample->branch_stack->nr * 3 * sizeof(u64));
> +		i +=3D sample->branch_stack->nr * 3;
> +		j +=3D sample->branch_stack->nr * 3;
> +		if (sample_type & PERF_SAMPLE_BRANCH_COUNTERS) {

[Severity: High]
Similarly, does this alias with PERF_SAMPLE_PHYS_ADDR since
PERF_SAMPLE_BRANCH_COUNTERS is a branch_sample_type flag, rather than a
sample_type flag?

> +			if (i + sample->branch_stack->nr > max_i)
> +				goto err;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807071818.7187=
51-1-irogers@google.com?part=3D6
