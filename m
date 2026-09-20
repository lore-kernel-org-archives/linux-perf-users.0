Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C05277CA5;
	Sun, 20 Sep 2026 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789920033; cv=none; b=iBPQhXrudl7yz7Fg3kVBHZEYisatDzGRtGiz+9JnjQgQa1/keBSUIFlCt/8J/iNLyNCZQA5bdXn3TQqek3xlMyKNWTHvzydtY2wrUuW0bHtuvy7A8OoPp6rFsSa688U4/gjVVYbuYLcUMYiNmK6mVSITQEEf/7YSsfCO6bGL+2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789920033; c=relaxed/simple;
	bh=VlABz7TSYfRXMIZ//7hbKjFoH4bRSxz5J4YPAUHVQHg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oD7blgKfFJzPpn7+JdC+SVOt1g/EDxKIIjVB2EJGL7nn9aHK11knuKcP7UWzfNjKUWRFMETaT7X/XUL50DVYa/b+gr2ixxQOymiNkZLorrBMoEq6fHkXHRcLhBhuVawASFhMa1SzQTDZaaCaJ5pF7K1lHWCKsP8HgT68lxxWbUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3Rsja5Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3Rsja5Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A0D1F000FF;
	Sun, 20 Sep 2026 16:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789920032;
	bh=mvkIW1EkWOpkUoDKtP0GqaGHcS6x2RQ2YD6amBAEEfA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J3Rsja5QNRr+pU8S+tyzRlN2N6Zzs3ECYfwgFLPhKPcXWmb7ibWCuRyb1rE2w/DS3
	 Nj2hUfaYDoOBa1oGVz+aYwcn8kuhjgkSiHv0pT7ETV/3DeIKLFB048FeUaOvyHr5Dd
	 DUkoElVL6tzYu3PueB8eV7+I6cQEzMbOFvx50LzTe4bCVD7tg96qJ2H2740yWyGO2S
	 MG2tTEUmcQtf+AEytOQp6GdmAK66t9O7FGX/zQyTwJ4DdvNP7jdkhfZ/cmig3Id3u5
	 pFuuu2WOQAKSji0rw/E6VGVPmkSqHeTay2ZE1kcv6zmYpyGonDzHLUH+jpf8nJeWQm
	 6H+qY7SQfSjPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KVM: x86/pmu: Don't retry a counter whose config was
 rejected
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luka Absandze" <absandze@amazon.de>
Cc: kvm@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260920155453.10836-1-absandze@amazon.de>
References: <20260920155453.10836-1-absandze@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 16:00:31 +0000
Message-Id: <20260920160031.D4A0D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> kvm_pmu_handle_event() re-arms the reprogram bit for every failed
> reprogram, on the assumption that the failure is transient and a later
> refresh will succeed.  That is true for contention, e.g. the -EBUSY from
> x86_reserve_hardware(), but not for a configuration the host PMU driver
> rejects outright.  A rejected config can never succeed on retry, so the
> counter is reprogrammed on every PMU refresh for as long as the guest
> leaves it enabled, and every attempt fails the same way.
>=20
> Re-arm only for the errnos that indicate a transient condition, i.e.
> -EBUSY and -ENOMEM.
>=20
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Link: https://lore.kernel.org/all/20260916123315.89042-1-absandze@amazon.=
de/
> Signed-off-by: Luka Absandze <absandze@amazon.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920155453.1083=
6-1-absandze@amazon.de?part=3D1

