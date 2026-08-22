Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD9E3AB28F;
	Sat, 22 Aug 2026 09:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787391088; cv=none; b=Ke8YoLJaTZyZTWZIqatC3k8tEqNWetzSQIeETyelp6CDlwJ5IUyUGGUJfKjLXVFxQUo704YLPeSPqD60BUrYgGyVY8Wz3YlZfawJe9d6ziLSiwT4O1vcUpWEUF23KXEQcf0PfwyVjjIwTrii0Of5emaijUu0lheNcjvuscTHPKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787391088; c=relaxed/simple;
	bh=FO8RsUGTsRRBt6bR4dxrDS8ql+YX/OKVZTEzT/2HGvk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B0yeT6beNOc9eliFBYsOFQpxPl2hHA9FzPS1AonnQabEe4PmOptmmg+siZx15zi/6FplBfuu9z6bKufXrt2poWIziUx3kIOmE884sJKoKMEPogAvhddBBZGBgkVpfUaXLrUrT0iXBAdCkVW6rm1fFW1grUMwo8LEee8UlWPSofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQNyhoNL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQNyhoNL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AFB1F000E9;
	Sat, 22 Aug 2026 09:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787391085;
	bh=FO8RsUGTsRRBt6bR4dxrDS8ql+YX/OKVZTEzT/2HGvk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RQNyhoNL6lolgc28RgxNTu+MRbLigdBYC7EB0XfxrI+kOfvAP3D8NUR3+dN1wTu0n
	 Ohn4BnDkmOVScHjGLrxq3Myizd2ozLoyeIt6eKPKywp07BXG6dIj5d9+hI/f9kcU/v
	 SP9rFI6U2fM2cHvVSEoXFwv+z6Ivtk881cS+ofCvFom9B7lzdAShXTMJHIirWMYz/t
	 efT61Z6qQGqCoZ4rIEuwzr0aZj2P49tBiuIcWtYjrfHkpEe2jHNgZNURz2JYbdI7O4
	 LuIY+4XJx5X9K1zm9tDYHGx9H2IzVetzxqVhsgkh805j+9PKTe9YzzkruNqq2R3PIh
	 kX2/3avAw4XwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 06/12] x86: hw_breakpoint: Add a kconfig to clarify
 when a breakpoint fires
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <178739065859.1520941.7359422308748763102.stgit@devnote2>
References: <178739053919.1520941.17662338993878200834.stgit@devnote2>
 <178739065859.1520941.7359422308748763102.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 09:31:24 +0000
Message-Id: <20260822093124.B5AFB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add CONFIG_HAVE_POST_BREAKPOINT_HOOK which indicates the hw_breakpoint
> on that architecture fires after the target memory has been modified.
> This is currently x86 only behavior.
>=20
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178739053919.152094=
1.17662338993878200834.stgit@devnote2?part=3D6

