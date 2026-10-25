Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792968736;
	b=fWOMI2RYMt2IWI3EVU158s8ibhNXRY79tKoE5UuBLd2c1ucbuhgZgTA6BBvackHlLlOg
	 Qj6V/7RmWMpa+yXVbCLZO40Q1OW8O6IAlHagWjBtnyPty4q9NoOwvdmREpOJduzOvTXHR
	 npALYgFXqUimSMNQS9jDuYCq+w0Z8Pe1aOG2hNgxU3R9EK4HjIWs49wgubxZEnw4ubwDd
	 D1Uos1uNxan86Mf0F/s/qlrQX+zbWUOFchzsgInzb1yKw/+GZlZMEp6/pFw0qfr/6sMWe
	 +VXsPu7OPl1wMRDmSi5qWJNu5+RYAy6OIenK7hvM7WvwaBk3QFucF7L3JQjJ08sCt5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792968736;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0q2UFAE9gyRb8RJiOEo74KUzau3H/ZTU7kNWtqRto20=;
	b=i8rbVp/nT+dOsRlRSRh/i07CltuIJRHEeJ39mgQsFh4Iizye0nb1N2jxw6PMBpx26eVf
	 q7oAH4n2+sYhKxfeXpPvVjP58g40icE/2jtYdgOsvzk4j79271DqSkkz6mpc4uTKzp+LL
	 Z2mz7j1HLjFkeLwv4nxAgNGyL0Tc+l2FI0VW+XmeKoB/CKLT3qIVGNtcZu8T0C+ubvud1
	 ZhE1uI5MoIbDKoiQpoR/w2eusb64NE28V7NKl/AqjHlMo0DQrmLItGngN70Si5Y90Ij7H
	 HldPKYBVYGGyiVUtvWajKaqNbJ2XVNF4k+Gjos7EdUB2Choey7sLdG1vUjyO1wvdKUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c9j6sVrK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8937C606A31D
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 22:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c9j6sVrK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5C21F01825;
	Sun, 25 Oct 2026 22:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792968736;
	bh=0q2UFAE9gyRb8RJiOEo74KUzau3H/ZTU7kNWtqRto20=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=c9j6sVrK1MKjsvRJ9wKZuixVkuqePDE/YT4J7VMg/XDMYkaSFiaXrwb3deh1knrHz
	 F9sfTD9oQK+bNGmVqWqATJ8rj7NKRGfd0RmWbOzy9ooIiC4m7X3Jgc/UrdMogf4jKj
	 QuBekCHL4s42juMJK9N2HQnwOEbp06mbsYDLc99a0kKNxS+MVtb6u7W+S+bDxRS+vg
	 3rhdzrb9SYxmnTZIN+noimuCunuZrJLMFYrNRiCxc2j7Hd6wkEJBdh/tHpen/4JAk8
	 275BmF2YNJHXSBy2dLiOjAQlpPkSvA6Wn0LJp3vGN/6RyT4wtnYIWbh+yUjUb4w3dA
	 DbRDOjT+oJrqg==
Message-ID: <sashiko-outbox-184508@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 6/7] perf inject: Set ordering_requires_timestamps
 before creating session
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261025220349.1244499-6-irogers@google.com>
References: <20261025220349.1244499-1-irogers@google.com>
 <20261025220349.1244499-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 22:52:15 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In cmd_inject(), inject.tool.ordering_requires_timestamps was initialized
> after delegating tools (such as aslr_tool__new()) and __perf_session__new=
()
> had already been called, leaving delegate tools with the uninitialized
> value. Set ordering_requires_timestamps on inject.tool before creating
> delegate tools and the session.
>=20
> Fixes: febea9ec382f ("perf inject/aslr: Add ASLR tool infrastructure and =
MMAP tracking")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025220349.1244=
499-1-irogers@google.com?part=3D6

