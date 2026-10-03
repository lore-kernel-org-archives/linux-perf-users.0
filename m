Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0714D3769F9
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 01:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991216; cv=none; b=nqbl9bVqrNVFUn33oum0YGslIQLUpWef3fFIYNH5TTk5AuF9J6pw+vHBBBLv6nZn+VL7KkSta7bFhZWzUZ8V3Huk8y0fPMK0N1XCR7e8oXKCy8SEOo3E2lHfBnC+LFEnTsyZa5VCuQxvqIplGJnSs3CsLDT98L4ZtJiVXH20sw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991216; c=relaxed/simple;
	bh=MYeL19bnwgIypOwrIBOkazZ3tUDr25r1zhm8irR4sw8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=befN0o0vf+DCay9QFY6Y/62Bbf81SiIdipzKnJ1HPQJcoPnoQJt+P5MOFBQVUMbF9VhCRuuNfZ0PenXI9qbIYiUjNr3k2bMdJhOiysFMCbLU9i0mIi9IGGaPHDOORhvNM33tFt5S39fZv1VXvTa+YkKChe4Y5a5T6PpArWTvwy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLbJXlzp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLbJXlzp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39FC1F000FF;
	Sat,  3 Oct 2026 01:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991214;
	bh=MYeL19bnwgIypOwrIBOkazZ3tUDr25r1zhm8irR4sw8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gLbJXlzpiUvdGoSf+sUJudBhhVR/YdNvNUfCuz9k8V4yIIcV/lsgjvWZWyJ9XgFJz
	 ublsh0UlnjrBVl7tGftBZWVxglDZvQPfKX6ESBEEK6a8gf7T9JXKhqq/QoAvGn+dnW
	 D/lfh+nZPSs6sU0q9O15z/wCx8BvKFypasA4Kf9vbfjkaf+SunPqEPa8KSUxREHfrn
	 8OZKvpVbaAS/PK3dT+9ie9AhborSfzTUFgWl96cOFtwTL6nsJcfwEWTBxej/NZueqI
	 ajSWz8piB++VKlBh34LGSmuq05/7KNCkjFXRzUanILeSAlwK1CBXltKzvswhbTc16o
	 xT3leL3x2t+Pg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 02/13] perf python: Quietly stop processing events
 when a callback raises
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002182624.3259797-3-irogers@google.com>
References: <20261002182624.3259797-1-irogers@google.com>
 <20261002182624.3259797-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:34 +0000
Message-Id: <20261003013334.C39FC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When a session callback raises a python exception the callback returned
> -1 causing reader__read_event() to print a "processing failed for event
> of type: ..." error. This is redundant with the python exception that is
> raised from process_events(), and corrupts the display of a TUI that
> raises from a callback to deliberately stop processing, such as when
> cancelling a background load.
>=20
> Instead set session_done so that processing stops and return success,
> the pending exception is then raised by process_events(). As a single
> event may still cause further callbacks, for example multiple
> call_return callbacks followed by a sample callback, skip calling python
> while an exception is pending.
>=20
> The session whose callback raised resets session_done after processing
> so later sessions process all their events. As session_done is a global,
> a session processed concurrently in another thread may be stopped early
> too. Count the stop requests so that such a session raises an error
> rather than silently dropping events.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002182624.3259=
797-1-irogers@google.com?part=3D2

