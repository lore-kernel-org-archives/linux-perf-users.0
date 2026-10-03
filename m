Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D683749F5
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 01:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991214; cv=none; b=mvvBiWF4Jvemn/NkNFQFQa4irye6pieHbMOtEQ5ss7iitqWXlK9ZCi7ZCrdcSlLAL9KypHahG+9AWFhM2y8efoSRuA5AXD4fBjF4gHdEFml7Wp0wL3IWmz69E4jBS6ybPH+GdljQ6LtUJsvYEJj5n+QnRYozJgJyhOhjxW1gZrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991214; c=relaxed/simple;
	bh=QRL6dvqS8NqRsYAsqeQ+7eAq0ZKvSWJYiYEobLe2Y70=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rculzBWl8K/fgv0LkqeLjA/F+kLSFmvG1i5txCL6xPEyqWupGXmmaMC8PUyf2QNYakEvIzVg6nBlcOtHcVWpmlOI2+eogNogrQLBYjl8SLwy3irPeM6K12XW0eMi8tz8tPm1s906s2E4O5W9jcQvTpS1nPQwv4luWSbuzdKjflE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gM8RCBCF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gM8RCBCF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5320A1F00893;
	Sat,  3 Oct 2026 01:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991213;
	bh=QRL6dvqS8NqRsYAsqeQ+7eAq0ZKvSWJYiYEobLe2Y70=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gM8RCBCFLsjvAUle6GkVDGkvpc1C78xybOHEmcexq41qL9Mifpu63Q8zgsbfpGjIx
	 0rxkcSDllk6iDDf046av30urFO7LyDo6gvVcRTtp1duzIiuOG8rB4/K9BtSsMXehOZ
	 2Atlzd4rpFzMEOranMcBFrhK5Zt+hgb0nZyFNSc336r3JQ9Zk5kFzzech5KFplUIzw
	 r6hDX6v5JvzfK4pnfVg24dZ5qpMG/4Oa90i4kHYqFkY7pk5s0FdL3knS3JTHYnV5VM
	 QENwmCZ1+R6fdSlXhxpw/EToh7cje9iJt+tTCJ8lRdnbcXG6m9KFE+d+Yi9yVlHEws
	 jBJZV14T/9Ing==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 01/13] perf session: Don't flush remaining events
 once processing is done
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002182624.3259797-2-irogers@google.com>
References: <20261002182624.3259797-1-irogers@google.com>
 <20261002182624.3259797-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:32 +0000
Message-Id: <20261003013333.5320A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When session_done() is set, for example by SIGINT or by a python
> callback requesting processing stop, the reader loops stop but the
> deferred samples and auxtrace data are still flushed afterwards. For
> large traces decoding and delivering the remaining auxtrace data can be
> slow, and the events are delivered to tools that asked to stop.
>=20
> Discard the remaining deferred samples, and skip
> auxtrace__flush_events(), when session_done() is set. The
> ordered_events flush already honors session_done().
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002182624.3259=
797-1-irogers@google.com?part=3D1

