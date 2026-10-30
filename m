Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793389243;
	b=Tk1MrEovEgK1YqY52xBN4F0wC6xId6UaIq97tmit3tVXr5D40xSr638Y8LAVqPueiCul
	 4LgroS8gli3u4eqErAypX0z1/78Z29Voh+acMBMIXCHEnRHYXCKON7wiVDMFPtXBT0FiE
	 EY4FBjUvPtrEjIi0v6DihwArj9ESyYM+ehtiE3Mo/J9A/uv+9izTx4Blez8hOzp8aXJyj
	 8PPMFZd7Zna0yC9HmwYaqDnU7jPsFvJCkj7f9Us58Wpt04wtl5yj9ttKE6WCKvH7iOYo9
	 a7h5WrfAMgFkEYnNnCunSLBUNQ5vjZYNfMr0h9OlZTBAVwKYc7KVPX6izJIv2x8BJZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793389243;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QFLXRqbuAjoxnriQ0A0ueV5D49aOkTOgzKLSf/EieVM=;
	b=jZmT0hAaGP93p2CarY6qpR8W1u4k1rvBtZbaN82mwtCSdlkhq7HoluPgzGwAC3PwkMS0
	 s8GJ5nPp73+RgHuZ4WWi2nc2ukvchkqKkxpqz3h0g4xIIsUJYwlKhW0BtI5HF4pwtJVWX
	 YkJjCNaCEEBMeUYanti55gBQCRfAmcw63F1AOsApsfTmcFCzzV4GnrYce7ykM+1fO/Z9V
	 EGCiG7laMXhbVm2Dl+a5zsv5lIv3pUUTeqwtck9FWVTW5hYtCEQK/TUN96Xs27I7NKV3W
	 u0k1yY1kR4iemI1X2XkROSD2CqyDHGjigx48ipRFkKU8oQuAU4942xVW+uo/wzrZQhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NP892+zg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69BE606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 19:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NP892+zg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4203C1F000C1;
	Fri, 30 Oct 2026 19:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793389242;
	bh=QFLXRqbuAjoxnriQ0A0ueV5D49aOkTOgzKLSf/EieVM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NP892+zgclnCbfJqjNd6q4hVVb3LVSL8Wvp4T/icq5kC0c+ddyTDJKv73wpSc3gfo
	 4T/AlLG00Fap6wewFDA65W95LuH++2sVapfuqiYWc/wvgUg6+wDE//Ml9eaLqsRCZr
	 5G8Av91xlCtH5MRwkR6Fenjl+nTNqNaOfahv+4uNCqa+1un9gzLkjN/mWa9gshqE80
	 7lXFvGk1fH2+1F8YXwEoTdpjF/1obI+JzZLC5zPsQr67Aqm5UYyYrfJmC1LlBlv35C
	 QRBEru9Mj204UIZzizHZ45g7hGUL7vgtkyrPbLSknLKvvq6qzeBL66IM6XcSOY24QK
	 oa0Cm4h8hQbYQ==
Message-ID: <sashiko-outbox-191451@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] perf symbol: Add dso__load_symsrc()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matthew Wood" <thepacketgeek@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030193237.1440673-2-thepacketgeek@gmail.com>
References: <20261030193237.1440673-1-thepacketgeek@gmail.com>
 <20261030193237.1440673-2-thepacketgeek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 19:40:41 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> dso__load() goes through the candidate files for a DSO, such as the DSO
> itself, separate debuginfo found through .gnu_debuglink, the build-id
> cache and /usr/lib/debug, checks their build-ids, records the one with a
> symbol table in dso__symsrc_filename(), and then reads and demangles
> that symbol table.
>=20
> The DWARF unwinders depend on the first part. dso__symsrc_filename() is
> how they find a separate debuginfo file, for instance to use its
> .debug_frame, and libdw's build-id cache fallback needs the build-id
> that dso__load() reads when the DSO doesn't have one yet. They get both
> today as a side effect of loading the symbols of every frame they visit.
>=20
> Add dso__load_symsrc(), which does the same search, inside the DSO's
> mount namespace and honouring --symfs but stops before reading any
> symbols. A new symsrc_loaded flag records that it ran, so the search is
> done once per DSO, and the DSO's symbols stay unloaded, so dso__load()
> still loads them when they are wanted. Kernel and perf map DSOs are
> skipped, as the unwinders only handle user space ELF images.
>=20
> No functional change on its own; the next patch uses it.
>=20
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030193237.1440=
673-1-thepacketgeek@gmail.com?part=3D1

