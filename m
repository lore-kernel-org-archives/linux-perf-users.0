Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31ED3AEF44;
	Mon,  6 Jul 2026 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783359214; cv=none; b=S3v58BowXy2cE0XP19qwIR65kIH+U9Fd+CH5371Z5ruwyBm1Hg9mu40UQqfkjYFhUZ12ubMapzS4oxaHSu7jryFBJGCFn5jjkPWZGdW9+JTp7cQgPiIwtPe6SM9nV+P3sNOJ/lQmdBg+PkxzU65sWgwG3jBwGFrlP/8ERJ+Hksc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783359214; c=relaxed/simple;
	bh=zQncDbcaqdgk6eifoy2ni/lnGvGN2gECL1xvOkuHIm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=on3+QPQL28YSDKE3QARmHD8kp9sDoIofo2xHRQQSUjPzcOyJ1clfJGdhEXR6eQiTaU8+ChjXK5dq0oOI13Y2BGDy/A1tdWOi3pN3PAe7h6Y14fHjpDrxs/WsYXi1d2lwNUNz2m3S1NtOskKr9hyx3NSjfs48KfUpfdENi3+eFW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ft+yV14M reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ft+yV14M"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BB0BC40E0163;
	Mon,  6 Jul 2026 17:33:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qWq5n-OlK4_b; Mon,  6 Jul 2026 17:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1783359200; bh=Pb0MvunWQ+2l5DOak08vAfbsBKx+gJv+6HTcsR2W4mQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ft+yV14MgKjqRzdLeJdObK40HSCpPLeb4saFLHDnasQ1ZGWRvjaF3xYEJsnf9gXGF
	 EiODC6UWHr8M1W9N/IoFQ4HywcwmYArHl2RvqFyA4LIQU0AKygA5uDuEDaq+WTOTFU
	 eUIsQGBL4fIkFL3cTiIZ1hu+ogDI0bh3iP1sKxubEbaV3dn20JvtwYeuezvE5XnM+B
	 fAd/zABVIkvEPhxvWjCZN2CnOi45JaDz2zMOn8cLv+C2cKiq/y4Bv4w3upFiKMmAov
	 wczU38pZ5+WifAgC2MRGQKIGb+O63Myx8VmKABaueOZR26dXfOngcPxplRLt5dwCDU
	 vuoRYpe6IjsfeYAA/61h+ln0sEkKSYC3E1J4Zv+XFef2/cohMxw542XXaGVci0U41o
	 +Gv4uPuBIeFiMw8/ZlBnoGrB1Fn/BEClipXkd4TE6N2kQ52ob7gOfvnCV6hbFeVNFy
	 lVilvJ2OdreCL9zIk1cWuw+q9nF50fLBWgvjOjh9QU7QHiKdVht5l5udhAsFSPSkMu
	 gjq0nHXTkEdkDvjYU7HG8yUchTJnfCr7KiEm9r0o0AQ5ZdKFh4wRB1l8y2ZUuPCIA7
	 VTZ7rdQE/7NRGJTayISr12ns7ZvnAoVkBJ/DpNyEB8rCmxuVR5PBTuQo5KfN5ymzmK
	 GM3+0a0DzQeYZqxAu2El06MY=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1FE4740E016E;
	Mon,  6 Jul 2026 17:33:07 +0000 (UTC)
Date: Mon, 6 Jul 2026 10:33:04 -0700
From: Borislav Petkov <bp@alien8.de>
To: Qi Liu <liuqi@hygon.cn>
Cc: "peterz@infradead.org" <peterz@infradead.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"namhyung@kernel.org" <namhyung@kernel.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jing Li <lijing@hygon.cn>, Sandipan Das <sandipan.das@amd.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjIgMC8z?= =?utf-8?Q?=5D?=
 perf/x86/amd/uncore: Add common helpers and Hygon support
Message-ID: <20260706173304.GDakvm0P41x7Fo1H_K@fat_crate.local>
References: <20260701093417.1312443-1-liuqi@hygon.cn>
 <20260702023625.GIakXOqdXpW3GVkk8E@fat_crate.local>
 <7a2ac50cf004421bb6dadfa7f488b70b@hygon.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a2ac50cf004421bb6dadfa7f488b70b@hygon.cn>
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2026 at 11:45:10AM +0000, Qi Liu wrote:
> This makes sense. I see the concern about introducing common helpers to=
o
> early when AMD and Hygon may still evolve differently in details.  For =
the
> next revision, I can keep the Hygon support self-contained by copying t=
he
> needed AMD logic first, and avoid introducing a generic common layer at=
 this
> stage. If the helpers remain identical over time, we can always consoli=
date
> them later in a separate cleanup.  I=E2=80=99ll also revisit the symbol=
 exports and
> drop them unless there is a clear module boundary requirement

Thanks.

Also, for the next time, please do not top-post. Just like I do, put your
reply under the text you're replying to.

You can read some more hints here:

https://people.kernel.org/tglx/notes-about-netiquette

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
