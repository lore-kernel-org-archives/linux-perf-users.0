Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ACE2E5429
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 01:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789351186; cv=none; b=WocluSbG7VnV7AKTq/M2mmFLs/QZ2T+EiUDcf2xE4R5Jr8FH/IObeJ1DIH205kucFCR9I2DJpDpt2ZGFyw8fewzOkOXba67NNoAFs6MTJEGGJhAfpoEpi6QJH8gUF548e2L82s9+9Eit2ZvB56GzjEhNC6eCnnE1quGS4dBZa34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789351186; c=relaxed/simple;
	bh=EZPAAw1XaX8998We8VAg0zpYwXf5kGQ3/D77/wsmoOg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HOHIDeN36aGzNBesq45CrdhJEMkgO6gcCC6lk6JMyx4jKqPUSTvUu8EuS3IXLGvf1Fpvt2YbXVmCaA7hNY05UGXd5cZjFxvDoIBg6XExfi742KoxGGneI+aXTHfdG14nFdU5PwONHGQP3dvlhb8i5iRyBAEgOVZtsPBhOEY2vaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kicBwFDc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kicBwFDc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE5E1F000FF;
	Mon, 14 Sep 2026 01:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789351184;
	bh=EZPAAw1XaX8998We8VAg0zpYwXf5kGQ3/D77/wsmoOg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kicBwFDcS7IF+Gpv+DNtqO6DZEgSgNZQWcnq7CkrB3lanD/aulrYuNFF046eOerXj
	 zB+FhcVVxD3ZuA5jeuw1A3oYsG0C8p3jmSayN2ha9w6ioUtbKrO0SHOcSAniBSJt6Q
	 Ox8BPNHTS/cNg2yirb3q+OszGBkjS1UoLnN27PqoxEreYOhYOn0KjnyqyJuvx9i5Ea
	 6oO1GDfOlfqzIQ8+w6x1CO3faysjjjQsemmaY6SQJKxjr7HCCYKqbLOvXWHIC4VCz5
	 RPpbPk0Gja5UWH8ASkaxbmEJNf3Fa0SSolx4/UfVNKqeFZWZGCES675vKG+JyWSvkN
	 PQY+3COE4eCHQ==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v11 10/10] perf tests: Add SIMD registers sampling test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914014049.2061519-11-dapeng1.mi@linux.intel.com>
References: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
 <20260914014049.2061519-11-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 01:59:43 +0000
Message-Id: <20260914015944.6EE5E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Validate that SIMD registers (XMM/YMM/ZMM/OPMASK on x86) can be sampled
> correctly with hardware support.
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914014049.2061=
519-1-dapeng1.mi@linux.intel.com?part=3D10

