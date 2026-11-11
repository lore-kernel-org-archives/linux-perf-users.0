Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426087;
	b=nyKLSe1y91J+eIS7oOD09zb+eRHlDj8D1i2frcEYhRBcSodcG+DaY16AFBPLTVZToavS
	 wCuAGC//nPhVzDM1EJNNQQCFtby3GEfDo55xEiahNb5d1uslUG733gEWfJ2FmMzGyh9AT
	 teQuaETPtqRDDntahooRPvqaSzlDs7buJm6a9yawSIetZzw2Gbmh962utUm+wjYVDETJp
	 W1im3hlABsCO7/h5kjXOnhKwB1XFrcaHgNrs0Zcer0jdXVR0WEjVljM8EJvKVBxO8SqZX
	 G4TG07GZpafsRxoDhUeCp+2Zh/OvxKDNnrcW1yAShq8Oa+6qD9uvoVXzjpq3h4pHrGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426087;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+G33XAa8JaWXFBK8ycpLRC7AacBPgROZJtqaPyKQN5g=;
	b=3nVbnxamWmoYBxK/HJnNGFjXefBGI77tRAk7Sul16vU9qOukSqsWhGuXucgxqG2nR937
	 oTZrNPAd3SOsMbEW++QzTtDw73j4yZ6GPpC+Co4c/qmEcI0sI7LnllhS2/uW6sQq6yERC
	 l+dRmRBVM7DYCa2gwyCJ1vaS9I+v8YlipUNqP5sldFTi06TZS9l9vdwq5O635yDd7xKXa
	 wkzCS9S+At7B7XgeoHE4pbU1a3o9T1X4ygbmtGlaZTbqZSsAuUsu5LKhOXbUSIEd6b1/4
	 gpFUM+794alRXjH3pBZwsb8ujQejqNnDICIHWk+gllou+qsuvVGjwWjZEZFvK8606/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="m/RQ+ebs";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FCF606A32A
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 19:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m/RQ+ebs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9031F00A07;
	Wed, 11 Nov 2026 19:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794426087;
	bh=+G33XAa8JaWXFBK8ycpLRC7AacBPgROZJtqaPyKQN5g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m/RQ+ebsEcN03LebCzodsCc6Mg8HpEmnv96pCvjgwVX7N2IE7AfSXCFRKUI+JH/YV
	 //yW/7rukPa6glkVAI/rIQoBX54vNyIxpYZrxCUTu4p2jeEq6QRAyghRF8fouY6BvH
	 3f7+sZH+0B1sWlOjE1Qpa2o7Hcy1JOanx50Bm/1qG5YX+C/DgWeQalQ0l9JPG7pJSu
	 oOx9se7PLakGt7Ph5WGOiQQnX/w8rlX3aGoeBQIfvYmb4XUREEDHz1bwSqH2NHXOYI
	 YL9biaFqCy2pGLedovlpm+6Qmkgg0if6yP83jilsWPj4ugPrT81IDWNzxZqV99l1nM
	 7doeX9Ydr/Z9w==
Message-ID: <sashiko-outbox-209585@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 06/20] perf comm: Add __guarded_by annotations to
 struct comm_strs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111174213.3526604-7-irogers@google.com>
References: <20261111174213.3526604-1-irogers@google.com>
 <20261111174213.3526604-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 19:41:26 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Annotate strs, num_strs, and capacity in struct comm_strs with
> __guarded_by(&lock) and __pt_guarded_by(&lock) so Clang verifies all
> accesses hold comm_strs->lock.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111174213.3526=
604-1-irogers@google.com?part=3D6

