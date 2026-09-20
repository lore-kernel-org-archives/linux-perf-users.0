Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFAD3D75CE
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882332; cv=none; b=Kb5fdB3DX1/m+fZvk2X3d3OjV3OjZsTbO2R2669FMq9K9CiVgNhIqnbzdrr44TwqRjAb9TKB39K6fjG6AQgtssBjXoFUb9wT9EkvcGurB33lpM9znBNavYn4CfiBb99ywfhkhT7qF8odrLWISTO7FxJvvJj909VAyOMmU/IWgr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882332; c=relaxed/simple;
	bh=8Utk39nPCIrtXOMD0B5wh5aCWMTev+kzjw6tYCWpdQI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bm/TH67TNGzVVCBp/AABBHTx/dEkye3FVmaLkq0gqyWKLBJQqYaLPyhmCGG1GupfMESJOYUZ4n4vN7BmBm/n78E9acSgbps2ABLr2OJYkEyu/3IDaTW5kP63l7xfceG3HsyUTf6bw07ZfLpF089Hr3W8UyWpM3imvV6wMOc00e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+Low0Ea; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+Low0Ea"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDBE1F000FF;
	Sun, 20 Sep 2026 05:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882330;
	bh=8Utk39nPCIrtXOMD0B5wh5aCWMTev+kzjw6tYCWpdQI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R+Low0EaDVcxPYYD20EK8TQGFESNFfx7jkp5eZEfmZkyQ8rlf/8RUUOIBNvjS1Jmo
	 SPTcQAAna0d8pjktJtYRG36nBOxg8GkXcA853/zk07pj4hQ+yKwDrqeqLkJdSjvbES
	 aVLG6X9OttkG18YWGo78PAQjxhRc0ZeBobnumVENll6gXQi3i5rsG5bx8k3q+3PA6N
	 yNJVe5vjjg3FBpiS4KZb8g4WPm3BxUz/nQB2FB7rgtmLpV9gJyORTrIVZRMrE7R00W
	 WLZm7d9pxalkelYTAzKY3GSI0vqCbquKerVUYpYyN2ID+ZGR7px05LW8gvgbuE5DG5
	 pPC7OM9SRIINA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 10/49] perf python: Allow KeyboardInterrupt to
 propagate in LiveSession
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <aa094b347932362df34f287fe8473e607a1f1ff3.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <aa094b347932362df34f287fe8473e607a1f1ff3.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:32:09 +0000
Message-Id: <20260920053210.3CDBE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> LiveSession.run() synchronously blocks while polling evlist for events.
> When running interactive tools or scripts from the terminal,
> KeyboardInterrupt exceptions raised via Ctrl-C must propagate so the
> caller can break out of the polling loop.
>=20
> Previously, LiveSession caught KeyboardInterrupt with an empty pass
> statement, swallowing the exception and preventing calling scripts from
> detecting the interrupt cleanly. Remove the empty handler so calling
> scripts receive KeyboardInterrupt and can perform clean teardown.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D10

