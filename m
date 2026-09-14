Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3682F0673
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 01:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789350281; cv=none; b=u6pZ6VurPxwpIigkr2VRoryzbk3m8rMAkYBa0Rxt7vozwtDYmoiGIazgZxB3skDCnbB0XgH/Nfn6/GQNxaYxpjHFJsQH1MAXflnKFkVrBqfMOsdRzLEypML61cGld/sDcYF54wxAd3tkFTGnPnl97StorWAD7HgaZbEEExX7Vn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789350281; c=relaxed/simple;
	bh=g4LbyLazSyYYCxpCr8G9uG9U3uqKqcRbHXMmbvmiUb8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IcR87i6J1MM+HqirYD0IzAibbeUggdtTsEs1yWmLpN2Uzu6sfhkFV7xRTlvfNdRqpd3UNlCUqlAWVwO5g0f9Ab+GbVs9sVb8Z8PDDSfW9oXSj9kdBfRIKII6RCGfjaDqNZFRoh8owbE8pczQ8TQoRAKc0gu6pqZaQzvAaveW6Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzKzbsvH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzKzbsvH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253841F000FF;
	Mon, 14 Sep 2026 01:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789350279;
	bh=AIceJZKgH8LUOzMxqFi/Mfyee4fLT5KYztt1IohpLDo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GzKzbsvH3y7atGoUu4/wB0t9+b3gAw+ckHRc0UoWPCHw/AmZX/ia97lfWXZWUdJla
	 XDHP6ZfBdVWm/67FrejoajMpXMvYwYJ6hNKrKZFaeMUFmzXqXz068/kaaplCJSaGoa
	 Vj2XpsCBwI3Kcx0vLiAPXuBvnE7qv+U2gNpCG7URmyS0jG8s9X1IUexq4/Bp46SlfO
	 +rZpu19fg+ROx7ReUei6p7eg0LuScZJ1L6iPsOMtErWC9tcDdqdsNrI3cKyt2Ryhxs
	 GimO3aOb1ELIetJZ15vlGZgToBrdF7G3LIKY/NhWIaDfznZYivKH8ofkQMEGKfIjoL
	 3BIWJ+iTRibuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/8] perf symbol: Fall back to fetching the vmlinux by
 build ID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914013604.7702-4-acme@kernel.org>
References: <20260914013604.7702-1-acme@kernel.org>
 <20260914013604.7702-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 01:44:38 +0000
Message-Id: <20260914014439.253841F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> A profile recorded on a kernel that is no longer installed, be it
> because the machine was rebooted into a new kernel or because the
> profile is being processed on another machine, can't have its kernel
> symbols resolved: /proc/kallsyms matches the running kernel, not the
> one in the profile, and is refused when restricted, e.g. with
> kernel.perf_event_paranoid > 1, while the build-id cache may carry
> just a kallsyms copy with zeroed addresses.  With no kernel symbols
> the kernel samples can't be annotated, so they all end up in the
> '(unknown)' data type and the kernel is missing from the data type
> profile JSON "dsos" entry.
>=20
> As a last resort, when the kernel symbols can't be found locally and
> the user didn't specify a kallsyms file, fetch the vmlinux keyed by
> [ ... ]
> struct tty_struct, struct qspinlock, etc, with the kernel DSO, keyed
> by its build ID, appearing in the data type profile JSON.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914013604.7702=
-1-acme@kernel.org?part=3D3

