Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795492168;
	b=OOkcoAlka0ukpzEG76m5VH6laJhVnsqzd0u75f3xHWJ1ymkr7Qu2gTKYziINLpbJ9Isj
	 X6Z8ai73vqk1iOE8cc1Dkr/9HKUf/IG6Y+mjuk1RDWwjspxx9DaUGpLlf2lDRA9GwPaGR
	 f+UuiUjkH3y3jv7R3vnVMxEtrnMR+jzR7RIwSRdhFGmGKzWBJiOss+qO7VZeARfUjGHCS
	 PjcES3u3K5zAqOxZgq3ktsIljV6tV7jIh2Syi0ulOYwHaSchx8AHXEAN6iSmmhySZfgYt
	 xoRXJ6qlphIyYbi1NlUrEi8+Wuce7+QgxL69haej55gR1APeGZXUc4rGvyFS7TjruJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795492168;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Vdl3aO+y3/aeOdm5QmzUuU7xfPyHluDE6/m/9oM1i5I=;
	b=H880EOvhoj3Fo4arvpjCLUzL/entPVeB4srtws1Qg5uK4lpEFobM7hhldVzDrRxUyhAN
	 pnBIqToz0n3y29I6pLaU09qkcgZNFPlCp3lYFCE7qGuKMpRMSOl+TrVYDix/3e1BfLDZ1
	 HGXuTbuRvtGR3bMkWIkJ4X3mkJvWk59z4yfPp6FA4QDnrOTQtLzuPaKPHHkYUeov0NPxv
	 YPPay5PJ6n3oEVjMww0zzPchM7D2KpCXcGpJK8i1YgJzhBPdaoMMg2F4FE/gZ7A6IzWaP
	 ViR+9gd96VOM0aW05snwHF+oSxZxQxesUYsEUZsNvOm7JXpfJfIXm81pHfoaLKcPusw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bZoTJxCQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDA8606A31E
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 03:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bZoTJxCQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E371F000C6;
	Tue, 24 Nov 2026 03:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795492167;
	bh=Vdl3aO+y3/aeOdm5QmzUuU7xfPyHluDE6/m/9oM1i5I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bZoTJxCQze7nd2CV7XOxo9md0aVSiJNGiJcfFaamuCfvswX6/Ag4mG6TL+yYtfo5q
	 eNMzHqNgASPgzfecCDbfOYrGuthojI3Y9Mn1KejU9dAEY0GY1ScT9NyJiy0ILZyJST
	 9RkFl5lNf9hrIFa1subICXmGlB/IZ5GFUvq1cRwhe97K1xQ8J2MKF+ehiH5QcisuI3
	 7YTg35WyBc2jbZQUdHGBqh6ZBtJNBfq7uw46Nq1ckPVnjW3VvdVx/UBEdd8hrxR2gQ
	 5taDgybeo02BgxJmry8zn61mbxdE2E/M/Fh0HRYVG9vYsKggCb7MYebtaPQwjhb11Q
	 g3x65BgXhI3/w==
Message-ID: <sashiko-outbox-230486@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 00/11] perf symbol: Sorted array optimizations and
 memory shrinking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261124032902.3859564-1-irogers@google.com>
References: <20261124032902.3859564-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 03:49:27 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 11-patch series:

- Patches 1-3 and 5-11: no issues found.
- Patch 4 ("perf test symbols: Add sorted insertion and equal-st..."): 1
  potential issue (1 Medium)

A detailed review has been sent as a separate reply to patch 4.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124032902.3859=
564-1-irogers@google.com
