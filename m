Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DE63451B0
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917990; cv=none; b=aTWF1iSrfkv74iHefuk022Oz7xpdavOZ6A9J+2blEwLmD6NiXR9AeL0yDL7Bsy0+PlwyVMyep134lNMuKgmVdjo8AlUbd0s7SoGH9ebuH2uQ4r43JWFUzOGpIUmjZtFNmpWq6til3rlLwJR1UZXsV3tp/kq46lYht2tKjpjpoEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917990; c=relaxed/simple;
	bh=4uNY/qz7/bvsl+au9aPaGi95ch+VBxBo14A1VoqfyC4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jzWoOod2WUotMDy0j0Itzv4grnYtF+smfUEoWQ9R5qllqUU55nzlhAtcpKAyXL6z5kAHATpO7F/HAZvSJHqBZO5OHXUv3GEH9/rzqt8DxEB4bKU3ZdlfLxMVQ8NSV5LQqDxkJanobFl6w11KwnpNO9gIhwHsnPplmSaC5gpxHtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/tCzTaL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/tCzTaL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF391C2BCB2;
	Thu, 23 Apr 2026 04:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917990;
	bh=4uNY/qz7/bvsl+au9aPaGi95ch+VBxBo14A1VoqfyC4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=D/tCzTaLFjzszExnwHWUbftcm/wkfw7SHKZ+grAgLNLxIhXI7ym1ykar4y0rrrU8/
	 E9k+0JI88f+jmsw3+V3ZZu5nHiePzfF8pZanneuwyiYJgV4M6z8LqaBaLZOI/49X/X
	 AnmUHVrUuxJq2MdG6s5cFTojgYgGVuPJLL5d6ZlnFYsvuMFnBD9YgC3Ge+Wxmdf2N8
	 Hshed9McNfcD1UiW1+xBdkN6dwHpIJ0BIoI0+fUvmZkX8yQhgoiM35L/W1iO6kCLz3
	 EmwpS3YYXKdC84M0oAK5+F3xy9Ucn7hBqSSPDcDoL2d+wDRF6yyUSPU4tmZbocbpdA
	 cKRT/YdKdkkEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 20/58] perf python: Extend API for stat events in
 python.c
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-21-irogers@google.com>
References: <20260423035526.1537178-21-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:19:49 +0000
Message-Id: <20260423041949.DF391C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Critical] Incorrect struct offset in `pyrf_stat_round_event__members` ex=
poses Python internal object metadata to memory corruption.
- [High] Unhandled Python exceptions, reference leaks, and mismatched callb=
ack signatures in `pyrf_session_tool__stat_round`.
--

commit b0070e631de8a0052c29623f25930efb7c6511b2
Author: Ian Rogers <irogers@google.com>
Subject: perf python: Extend API for stat events in python.c

This commit extends the Python API for the perf tool by adding stat
information to the session and introducing callbacks for stat events.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index c707adf4785cd..b7f877189f8cf 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c

[ ... ]

> +static const char pyrf_stat_round_event__doc[] =3D PyDoc_STR("perf stat =
round event object.");
> +
> +static PyMemberDef pyrf_stat_round_event__members[] =3D {
> +	sample_members
> +	member_def(perf_event_header, type, T_UINT, "event type"),
> +	{ .name =3D "stat_round_type", .type =3D T_ULONGLONG,
> +	  .offset =3D offsetof(struct perf_record_stat_round, type), .doc =3D "=
round type" },

The offset for the stat_round_type attribute is manually specified as
offsetof(struct perf_record_stat_round, type).

Does this need to include the base offset of the event union within the
struct pyrf_event wrapper object?

Without the base offset, this evaluates to 8 bytes, which on 64-bit systems
points directly to the ob_type pointer within the PyObject_HEAD struct.

Could reading or writing this attribute from a Python script inadvertently
manipulate the object's type pointer?

> +	member_def(perf_record_stat_round, time, T_ULONGLONG, "round time"),
> +	{ .name =3D NULL, },
> +};

[ ... ]

> +static int pyrf_session_tool__stat_round(const struct perf_tool *tool,
> +					 struct perf_session *session __maybe_unused,
> +					 union perf_event *event)
> +{
> +	struct pyrf_session *psession =3D container_of(tool, struct pyrf_sessio=
n, tool);
> +	PyObject *pyevent =3D pyrf_event__new(event);
> +
> +	if (pyevent =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	PyObject_CallFunction(psession->stat, "O", pyevent);

This invokes the user-provided Python stat callback with a single argument,
but pyrf_session_tool__stat() invokes the same callback with two arguments
("Os", pyevent, name).

Will this mismatched signature cause a TypeError when a typical Python
callback expecting two arguments is called from here?

Additionally, is it safe to ignore the return value of
PyObject_CallFunction()?

If the call succeeds, it looks like the returned Python object reference
might leak. If it fails, the code doesn't check for NULL or call
PyErr_Print(), which might leave an active exception uncleared on the
Python thread state.

> +	Py_DECREF(pyevent);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D20
