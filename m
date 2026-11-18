Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020552;
	b=Jushxu2Em9T6zMqQMY1ytf0TfZM3KdfxzW532cl7dySnM67o9KxMfXC3/zSof8Zze/Hb
	 D4kx7akxcWE3XV50Wa8V66gVwXtPfn7dUQGHptZKDSHYTXCmJWNZmZOGARFv/VjibCd+L
	 0YEJ0UTg3NX0B/UoZaK5RRAoCGw68LtLubY7Y8qI+PqKDKNfa12PwXo/Nv/aznriHZqTj
	 i4hP9CfEyqKlcjJViOizuBNbviGwEtgOoB3LIqA8SOgLupTnbRjbPDw+O0CJfycltj/6f
	 fhPnPGsoBtH1DvIWnY3XttUk+tHGmP+d2JZf0JLVokbQ40PqmndiLNBSma9tK3Dq52w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020552;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QXTz/qndLvJmPN55OfFtU0i49BZQJVME/Bp4QK+xvEM=;
	b=u6B/FmCZOgyMdpQEV13AeiaSYobsIDVhz3L27wIUnNY0bpPiBbHTBMs2G881Jjbk9W1X
	 GS2pi5xEX3oIZTD+iVmp17AGA8XIP0CLFT4pVO2YssS7EoyRQ0RnAEZdAWUUtAtdXSwdn
	 2+NaQY608Z8bD6qViw7GNzUPTHM4z3WuH9yHORZcUEyvn7EmVzY2MTbHA5vISbdrnpjfP
	 1jwkRa5290oZCHZjNYQO30HSPfsihX+Iuh3RPl23xvPcseI4ZdYDOOeUWyBh7dUb4GzPO
	 T65iQSURlSpPst59Y44Jq66vcEmrSewReuDhb/C2FRN0J+3P5UyyOGOTY5MXhzCNESQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fevkgBVw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD08606A320
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fevkgBVw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94741F000C4;
	Wed, 18 Nov 2026 16:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795020551;
	bh=QXTz/qndLvJmPN55OfFtU0i49BZQJVME/Bp4QK+xvEM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fevkgBVwdeOKNv/l5PmCg/4M1Y89ITYDDryvYwMQCeoqk2jlAQrbTXoM8mxqeNjIe
	 UoToJxJXcovyQeCKmYNsaDYR5PQG3vkrQvjHjE+f7Paag2lvaLEVhQRAURj/njrc6A
	 Cciy6JRxDXQxsa2ToaebxmiezDsM09hgRj58Y3BFnpvvUtk22IyXR9PKzvlO/okmgk
	 x70VL1XatIEw6glqkGI9KpD7NRs+Dnq6GM844AStUwt3yBZLsCPBUPaoLavC5iP48a
	 Mv2s5hcoL6wjJFjj0ADsnN9P8rHSALJSACw/RyjeKZchjqwcpoOYoS8JEW4qcWT0gP
	 ETHOe0nk0fZxQ==
Message-ID: <sashiko-outbox-221559@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 23/34] perf cs-etm: Rename tidq variables to tidc
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-23-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-23-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:49:11 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Use tidc for variables that point at the new trace ID context struct.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D23

