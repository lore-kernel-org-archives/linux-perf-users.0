Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B577A3822AB
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 03:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789702015; cv=none; b=bzLOB6hfmtWxXDT8kz5EodqpLz1QJrzKo5XwsVTUWfa6LE4fC6zZcWRzoyMUVKpuyvrZPJyNQVN11M/Ajc0n6Hd9aBklRF8RJwPPOEjNNxZvGWgLLTG+EXEZ2XwbWoOFHcsNop+C4oqVia4jV9r49II4naZWVkYrbjB9oUEn5G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789702015; c=relaxed/simple;
	bh=FOhN6njNP8QGir6lxYzN0C2gmTfz1r+X2vrk1HYvZWQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qNgop+X8VtNlDtcrYFYB75h5on8cRZ3xzwVXV5aIqQ4EVV+fi120tiyW1def6F7s6s9fqheYAYBbTN3vx0IiS12E3jbmiRFzO5PHh7bAEJWYzOo2c1nXWtJoE/KwjRUsc6Qim8bqUjnc6BaDli0oNsW/C6m1516geW0ycPNfdIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pq3FJ1u1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pq3FJ1u1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEEB1F000FF;
	Fri, 18 Sep 2026 03:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789702014;
	bh=FOhN6njNP8QGir6lxYzN0C2gmTfz1r+X2vrk1HYvZWQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pq3FJ1u1ZvqaNkspdcAUAFps79SNLujPmBPtbOVMCqjbFcrQBC/no3Wna37zlegtQ
	 OeSlIaCe1OexIUwxscHQm8rM9FiMXmjejFcegJhIJZF4sUOWzXN0ibBYpZxx2e+aZg
	 15cnZ4SstCvSRrJwW1SlTddcUx0/RQWKfv1xxvQI7lUJ54LLOXIcFTRky5nmB3UU+H
	 cFdP/2eRdP0gqHXhwKt2hBnc1EIz3haceJIzCZJUQswGvXWpZz+ck8v7mWxGUh3nId
	 KFc1INOg+pFUqmxmHq19yFETDTj5LV7XWzDHrWUDM2xMGzolt2jbFdyAE9hm4qJOoH
	 9HAlpYwkbLmGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf: remove unused empty help-unknown-cmd.h header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ethan Nelson-Moore" <enelsonmoore@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918032356.466938-1-enelsonmoore@gmail.com>
References: <20260918032356.466938-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 03:26:53 +0000
Message-Id: <20260918032654.2FEEB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> tools/perf/util/help-unknown-cmd.h has been empty and unused ever since
> it was added to the kernel in commit 5feaac248a46 ("perf tools: Move
> help_unknown_cmd() to its own file"). Remove it.
>=20
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918032356.4669=
38-1-enelsonmoore@gmail.com?part=3D1

