Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794810878;
	b=0/MLFJNsRjaMO7Dv3dey1rm8Mr8lf34taReR+IvW6YEZhyvt3EMocdG9V+uqj9oJquC5
	 cLFhJ7HyZw4TZLznS6qJMBKH5wPOJVvlQLC5Y15bFEcMC95hhaUNwx8VqMl6DesQ+Igtu
	 fVlqZBwLc9LIaBVxSUrQwFlSUVaSRtEE+CwjvRHoaYwugYmjOqr33R5zMFnDrrD5QlUl+
	 ROnZWbt8FVv7oIsS6YsPrnbf3w1Bn0fo5nUzH79B4xVlLXaP9y7cVJmqPJ1acqIbQbwAT
	 fWAHMO0TKEL1GyE6zB/QpqXlxf9XuAwEmkCdfETelR0mx0H6GFSZTDMqfwBGSlqBMAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794810878;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=C+R3ZSD2hb7DkE261VR9cTfUGxFBp36C3o+hQNSlth8=;
	b=xl3m9NF8tfUfmkksQAFP405dZCY1ejGj7fX3T9gA8dkwFoLtJxtCTIXVE5TOMFP8B93I
	 Dhj4Y4ZyN2Vydjov7ftSWdg8J2peEJBfwubt+mdzobbV0IJHYHPPfteW525ioo7lFqvYv
	 TSd1mwLHAZHimDua9ZHelS9FkyBfmGptuYRwNNwMQfV7GBKfA56D3y/51zQMFhcBjCh4s
	 foxYwSsut7JDWIHvU/4zjr3PnADHuazFhDAFr/KWZgbzi9Ql2Wh8RSU+pAmf8CRLd1MWa
	 PIR9J0cDChwDiZPUi36muhWkXUmPZWkKZYOlLyBNxiiT4n/I86R4nHEj/3nNCffdadQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kcucp5Mx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203A0606A32C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 06:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kcucp5Mx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82141F000C9;
	Mon, 16 Nov 2026 06:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794810878;
	bh=C+R3ZSD2hb7DkE261VR9cTfUGxFBp36C3o+hQNSlth8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kcucp5MxU9dsE2CClxVKzw7vqi0EvvRXWkOTR6TNbV4NoVbIUh6hG17CeUjZ+q65e
	 R3YD6vU+GMscMHlwpZV0egWRl5pAf0sbzyONOchPJFAL5ODeYOjWRhY/u/Ut6nSw8k
	 8JCfS6YaPqOuQORjkcIq4CLvqG8MTEX1/GoPAJrnFyoP1QlODQEP1KTzr6RWABB2ym
	 x6nuykPBFRwaL3s5nX8UAg8wAv8oN5fOHo4YIOz9BGh7wzm41pqsGBwb+VwHpoTD35
	 ZxgPw71GWvTU07Am/ATOfjF6Wy+7dJKfrS4v67dcX1pjaECrJnzmyUZtAzMMPTK+oc
	 gEjMV0rD7Gzzg==
Message-ID: <sashiko-outbox-216283@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/11] perf tools: Only enter mount namespace if
 necessary
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116055731.707164-10-namhyung@kernel.org>
References: <20261116055731.707164-1-namhyung@kernel.org>
 <20261116055731.707164-10-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 06:34:37 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add dso_binary_type__needs_ns() to distinguish DSO binary and debuginfo
> types that reside inside the target process's mount namespace from
> host-side paths.
>=20
> Gate mount namespace entry in open_dso(), dso__find_binary_type_locked(),
> dso__find_dbginfo_type(), __dso__read_symbol(), debuginfo__new(),
> symbol__disassemble(), and symbol__disassemble_capstone_powerpc() using
> dso_binary_type__needs_ns().
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116055731.7071=
64-1-namhyung@kernel.org?part=3D9

