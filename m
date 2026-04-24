Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA30334A3DB
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051098; cv=none; b=UQ/833xYA2qRnXKMLjriKSmCAf6wcGooIcKUsoOe7jNeDqYszbWDFOXhpr37uZ+Qw/jdHtmIZfaEyDJAY4i0rXX/nB+sF75nYov46AjFjxVUD4F3xiqoJyllEwyPpCe+K1x89tJ7MyCVHzQ5JWdgmqwvvAjqsJ7+P+nOBwhesSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051098; c=relaxed/simple;
	bh=4OsqJYLbelNoxTcUnzQpZyAF84woHsjUHGBdUNY8TY0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uVBUD+WLjhDWVNBK2xwbqp6CDoNxMlmPuXVDBtRyYCxQGegDbjN/4FwGUiwlJ4veoXobyJkpCjo1GISaz2wBJUKr6VdiKG9iM6gsHtgrkM6HtLKDMjL6h0z/3iiBN8Z3OSQtB3lUtHjIa+oM3ezFEYhyqElwcXEZCBpIXPGcfKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlzImJH0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlzImJH0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D91CC19425;
	Fri, 24 Apr 2026 17:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051098;
	bh=4OsqJYLbelNoxTcUnzQpZyAF84woHsjUHGBdUNY8TY0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=OlzImJH0KiK0rjVPkxKxgACN/06y7kIif+q9mbXZVg0DlaBgM82jXzclM0Hc2FY+M
	 mKi5cBXyXHCiAPgDm8pS/6qqRYtOXIXR5OVB8K7HBzI6IPjCX7nfzuQZvkENvJrX2l
	 APWrE2NC0dt/o1LvMDvba9W4oMC3ll00zem0bF5WmBhIjyTssuIz3OGYpKCjlonEg2
	 rd0mZ3Keo7R1kcc5rIVahl86pkHZfpg6v2+iOGaKEz1N/dXrivUthPN4kP8OJZp+Ux
	 QoPtZHaJ/QnIyoW0sbZFgKKc7MtUdYRaDKg4khZdZ+Q3+owtOYHppzCnXZzT60xgM3
	 6+miXKCBcJBEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 41/58] perf netdev-times: Port netdev-times to use
 python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-42-irogers@google.com>
References: <20260424164721.2229025-42-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:18:17 +0000
Message-Id: <20260424171818.8D91CC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] The script uses an invalid 'skblen' field name for the skb_copy_=
datagram_iovec tracepoint.
- [Medium] A KeyError will crash the script if str(sample.evsel) does not s=
tart with 'evsel('.
--

commit 928241bedb722e713ee101b815157974df1a613b
Author: Ian Rogers <irogers@google.com>

perf netdev-times: Port netdev-times to use python module

This patch refactors the netdev-times python script to use a class structure
to encapsulate state. It updates the script to use perf.session for event
collection, extracting tracepoint fields directly from sample attributes and
processing them in time order.

> diff --git a/tools/perf/python/netdev-times.py b/tools/perf/python/netdev=
-times.py
> new file mode 100755
> index 00000000000000..568986e2d49240
> --- /dev/null
> +++ b/tools/perf/python/netdev-times.py

[ ... ]

> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process events directly on-the-fly."""
> +        name =3D str(sample.evsel)
> +        pid =3D sample.sample_pid
> +        if hasattr(self, 'session') and self.session:
> +            comm =3D self.session.process(pid).comm()
> +        else:
> +            comm =3D "Unknown"
> +        event_data =3D {
> +            'name': name[6:-1] if name.startswith("evsel(") else name,
> +            'time': sample.sample_time,
> +            'cpu': sample.sample_cpu,
> +            'pid': pid,
> +            'comm': comm,
> +        }
> +
> +        # Extract specific fields based on event type
> +        if name.startswith("evsel(irq:softirq_"):

[ ... ]

> +        elif name =3D=3D "evsel(irq:irq_handler_entry)":
> +            event_data['irq'] =3D getattr(sample, "irq", -1)
> +            event_data['irq_name'] =3D getattr(sample, "name", "[unknown=
]")

If name does not start with "evsel(", event_data['name'] is normalized
to the raw name, but the field extraction checks below use the un-normalized
name variable. Will this cause the if/elif chain to be skipped entirely?

If the if/elif chain is skipped, handlers like handle_irq_handler_entry()
will still be called by handle_single_event(event_data) but will try to
access unpopulated fields like event['irq'], causing a KeyError.

Could the field extraction logic use the normalized event_data['name']
instead?

[ ... ]

> +        elif name =3D=3D "evsel(skb:skb_copy_datagram_iovec)":
> +            event_data['skbaddr'] =3D getattr(sample, "skbaddr", 0)
> +            event_data['skblen'] =3D getattr(sample, "skblen", 0)

Does the skb_copy_datagram_iovec tracepoint use skblen as the field name?

Looking at include/trace/events/skb.h, the field is defined as len. Will
getattr(sample, "skblen", 0) silently return 0 for every event, dropping
the length statistics?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D41
