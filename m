Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737942309B2
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777141747; cv=none; b=YieavdpMO31uYneM2dpU+6dzBkUFVzlVJ67b8HARFuXTEaTeSw/HERqEnRd43ykuFx+rNk/hzPqMPX//TyY6iZ7Fwzv7L3+n9wV7nuhewUMQ7ztFy9SU/zxATXFdVE3jiDKXaYuYGJTdEDEIcy+ZoPagbkMoxkDNaBY3mIfHezY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777141747; c=relaxed/simple;
	bh=cGZegRGdvOVrdt/oHIP4P1cm0UzJNQkIBerNUtU+bHY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CLbhGpSZKJxoGIZ5BfhppmxZfh4KbEy5pjvs4bbA4ZTYtCJIhZIaQmL7HLKlmfr5Bax0m459P5n3HyBR6STZlllg9SOGmNDzKZpFWvluVY3HZo3I1BLhO4+hcqMQgXN9U0k/Dh6lVuJXgQ1k9dnfxafyPoRf3iA9S04O9XIVAk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHFQQVq7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHFQQVq7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E583BC2BCB0;
	Sat, 25 Apr 2026 18:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777141747;
	bh=cGZegRGdvOVrdt/oHIP4P1cm0UzJNQkIBerNUtU+bHY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=YHFQQVq7t/qVZzYZRC7MF80I0W3yyM8G72VHUf8r1ZpcjEQFKyOuT/ByKxT8MQyPt
	 539M8WAHeMB1O9pnja6+rb6gpqrUCZiGQAYwxOaKN3RSQ7C45E9w7H29zvLfNdcHlT
	 TAl7bDHHbPeJpRXLhdNSvw7yAZnv4Uc9Ww0tJvYvHzDfhCV7uqkF37fnV6/6viMNln
	 tBDVYYuz5vNxH+9i5g5F42Tu0hKKT1esCOd0mml2Vo4WtLxPT1vhpq2MerSkikzzP1
	 xM838/2nQwoRAqgtHQPum6HRMQiWwn+O/v8EVPbdjLXISdtOoxeZBC/+cA+CAselP0
	 AKJ0ZJJhxIGNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 23/59] perf python: Add LiveSession helper
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-24-irogers@google.com>
References: <20260425174858.3922152-24-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:29:06 +0000
Message-Id: <20260425182906.E583BC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Inefficient ring buffer consumption causes severe event processing=
 delays and dropped events.
- [High] User callback exceptions are silently swallowed, masking consumer =
code errors.
--

commit a078113929da808a72925816e8a4dc8dd4e7f26d
Author: Ian Rogers <irogers@google.com>

perf python: Add LiveSession helper

Add LiveSession class in tools/perf/python/perf_live.py to support live
event collection using perf.evlist and perf.parse_events, avoiding the
need to fork a separate perf record process.

> diff --git a/tools/perf/python/perf_live.py b/tools/perf/python/perf_live=
.py
> new file mode 100755
> index 000000000000..d1dcbab1150b
> --- /dev/null
> +++ b/tools/perf/python/perf_live.py
> @@ -0,0 +1,48 @@
[ ... ]
> +    def run(self):
> +        """Run the live session."""
> +        self.evlist.open()
> +        try:
> +            self.evlist.mmap()
> +            self.evlist.enable()
> +
> +            while True:
> +                # Poll for events with 100ms timeout
> +                try:
> +                    self.evlist.poll(100)
> +                except InterruptedError:
> +                    continue
> +                for cpu in self.cpus:
> +                    try:
> +                        event =3D self.evlist.read_on_cpu(cpu)

Will this cause processing delays and dropped events?

If reading a single event drops the unread data below the wakeup watermark,
the next poll() call will block until more events arrive or the 100ms
timeout expires.

Should this code repeatedly call read_on_cpu() in an inner loop until it
returns None before polling again, to avoid a poll() syscall for every
single event?

> +                        if event and event.type =3D=3D perf.RECORD_SAMPL=
E:
> +                            self.sample_callback(event)
> +                    except Exception:
> +                        pass

Does catching Exception and passing here silently swallow errors in the
user's callback?

If sample_callback() contains bugs and raises an exception like
AttributeError or TypeError, it will be silently ignored without a tracebac=
k.

Could the try block be narrowed to only wrap the read_on_cpu() operation?

> +        except KeyboardInterrupt:
> +            pass
> +        finally:
> +            self.evlist.close()

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D23
