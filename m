Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582728;
	b=swDmPBdJnEAfXfFMk46rl1joNtIr+Y7aSSIN0SXjKKVnhzRHN0cy2L0KK5KM2DuI9e2R
	 GAPOoH1jhv41FoJKacLn4UQb9UsJslGHnZ/g5bmrjLkBfrfuQgmtZeLuYkZxilN7nAPiG
	 m5wOP+yBwFBMbEltWPnxR50kvB2Q6tNLqsnss8hTJamVwW5RdWPj7ifpEoy/Fa1wE0dI7
	 6YHFQvBzwGG8D1vR6xH0Qyon9rGrg03Ilr2Txr0yCAZNtC4jIEkfU/t6SpN4TolKBcUHd
	 7uwZsppq4wtFHIgd3tHnp28HKFW/QNu2NoPAUatBwu1uS/T6Gmxk9Pvnl9dTnnI35Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582728;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ScWGx+JJf4k/E8aCEJ73zJ2mQ0k1MgQfJ588aCNBYtg=;
	b=bN5R4Gkn9604fAySOzk8WhBuIEWvJ4Jyn8e/8iylxixmzJY6NrQUQgIsW5Hqobmb12bH
	 NSsmLalF+l89nhV/rjRJsoCP5WAh3DtIBnCxxOdEfjkoYYz0WFkivs4Ktss32Tc8Tdu2l
	 GxT/WqHb+dqK0iuNgsmRdAba8YcHZf6gnni4fA4KX3NmIzx7kUQFiQly6Ytv7qjJE5ylG
	 swq5/fKvmuDV8G7cBfy4OXjtpJ001qy/J8HtJkLXw3x2kZbvT9aKJqsXMA3nWVkub8YCo
	 XTePH8lWEUVNAAQl8P+J5XR29qmI4+BZrzXVb2NhGc4Tcsyz8lPSTCX98oypG2R6PDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Oppl/737";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01817606A327
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oppl/737
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC531F000C6;
	Fri, 13 Nov 2026 15:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582727;
	bh=ScWGx+JJf4k/E8aCEJ73zJ2mQ0k1MgQfJ588aCNBYtg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Oppl/737poHy3+7lJ1OVugEyCzJBBQri7cXNmokQso7v1oE15AVFW77IQfZsZLmrf
	 NvbIdHkr62FI7umZcWFI3B8c0momr9sIoQ+EDTIsEPf/foQQDV2gZ9SE+1lun8dgWe
	 VKHpZ1Bkf+qFeaaovGXBEEtXacELoECPW95uC16UWNNb8HqVdisCebmqbtMnC5cWeh
	 NcdstxlVYduRaG3tJv4LWno4qIB3965aMcLM9+wTJW5ahE3TBVuK5POAFVeMygZeKF
	 WwrtqYrpk3vvH+knFEPWAawMKE+xrs3rHtyhORKxhO6exsbECM232P7u6RErlfzd4E
	 GE8Zwe4leWu5g==
Message-ID: <sashiko-outbox-213062@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 03/12] perf tests: Exercise the flexible array member
 path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113150555.1163049-4-acme@kernel.org>
References: <20261113150555.1163049-1-acme@kernel.org>
 <20261113150555.1163049-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 15:12:07 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> No test covered find_flex_array() and get_flex_array_member().  Add one
> that keeps a struct with a trailing data[] behind a global pointer and
> checks that accesses past the struct size are resolved and named after
> the flexible array member.
>=20
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113150555.1163=
049-1-acme@kernel.org?part=3D3

