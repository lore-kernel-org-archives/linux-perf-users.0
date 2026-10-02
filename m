Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1D2470E8A
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932389; cv=none; b=Tv6uwgbwMHnl39T8x/VmhfoMgD6LyWWhPmRc2WdcGeMK/ZDojs5TGcJ3kqujVl5sijvpnbHid6tYUPZyHJUhnLZFeWCFGPDc4XMUf/YemDGeBBOqzsEz61aAxXW61QhpfdiGMkKC7pz/pWipfIcSthZWpDpepRyQX6qN5qLAlUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932389; c=relaxed/simple;
	bh=08dzKm0jYvSiuUysQnufTBnNcI60TnidDcvKU+ICxgc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qIhepUnLIxy0JzgLmyOX+IgM51hI2W6b04KK6gOSOfJ0v0ADKexDBVfCSEN34bnpZn0yPqhs01kAB7mvQRNKvS9Wpd+Sc+reOthsmUNDuRaL6rc3PINcqm/g8TZkk37lo8PHZdRSVUZK93Cq72uJKXWpU9lprBOBp9m8G6/y4w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaxkmDpY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaxkmDpY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC761F00893;
	Fri,  2 Oct 2026 09:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932388;
	bh=08dzKm0jYvSiuUysQnufTBnNcI60TnidDcvKU+ICxgc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PaxkmDpYLgvnxpasOv+Q2YzE7GUyczl0Mu1+wCbILrKsZgSgIX+Ez+2WH2ul5hp8v
	 3Gu1s1gALYf12WZj0KUxmK2Po30CJO3avD+tOh45w4OTHZhgKZl09hI47sbV3x6YRv
	 ZQlCbJDLa09NotQ7555G0vPH8sAAIvEMbSjvr1aGEIFp1B4YVd7XiR/DLI2nOLqKGb
	 L4G/I1QDts89xgsdt1EzP+H6yruVaKASx5asoKdv873ryW82lFRZMgCgPFg7DAKrXi
	 kfHCrX7Vp33IDXDBbHMjlJOA9Grf2v5bKHHQI1NVbbVqyj8zl7gPvFcj3V4XI715Qr
	 C5yzQufAZ0LvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/9] perf mutex: Add DEFINE_MUTEX() static
 initializer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261001185400.2754753-4-acme@kernel.org>
References: <20261001185400.2754753-1-acme@kernel.org>
 <20261001185400.2754753-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:07 +0000
Message-Id: <20261002091307.EDC761F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> For file scope mutexes, so that they don't need a constructor function
> to initialize them at startup, mirroring PTHREAD_MUTEX_INITIALIZER
> while keeping the clang -Wthread-safety annotations of struct mutex.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001185400.2754=
753-1-acme@kernel.org?part=3D3

